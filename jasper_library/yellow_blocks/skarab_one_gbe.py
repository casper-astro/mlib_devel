import os
from .yellow_block import YellowBlock
from constraints import PortConstraint, ClockConstraint, GenClockConstraint, ClockGroupConstraint, InputDelayConstraint,\
    OutputDelayConstraint, MaxDelayConstraint, MinDelayConstraint, FalsePathConstraint, MultiCycleConstraint, RawConstraint
from itertools import count



class one_gbe(YellowBlock):
    # @staticmethod
    # def factory(blk, plat, hdl_root=None):
    #    return forty_gbe_xilinx_v7(blk, plat, hdl_root)

    def modify_top(self,top):

        inst = top.get_instance(name=self.fullname, entity='one_gbe')
        # Wishbone memory for status registers / ARP table
        
        # request a wishbone offset that is a multiple of the port number
        # the one_gbe doesnt have a port number so request the 5 space
        req_offset = 0x16000 * 5
        inst.add_wb_interface(self.unique_name, mode='rw', nbytes=0x16000, req_offset=req_offset) # as in matlab code

        # one gbe specific parameters
        inst.add_parameter('FABRIC_MAC',     "48'h%x"%self.fab_mac)
        inst.add_parameter('FABRIC_IP',      "32'h%x"%self.fab_ip)
        inst.add_parameter('FABRIC_PORT',    "16'h%x"%self.fab_udp)
        inst.add_parameter('FABRIC_NETMASK', "32'hFFFFFF00")
        inst.add_parameter('FABRIC_GATEWAY', " 8'h%x"%self.fab_gate)
        inst.add_parameter('FABRIC_ENABLE',  " 1'b%x"%self.fab_en)
        inst.add_parameter('TTL',            " 8'h%x"%self.ttl)
        inst.add_parameter('PROMISC_MODE',   " 1'b%x"%self.promisc_mode)
        inst.add_parameter('MEZZ_PORT',      " 2'h%x"%self.port)

        inst.add_port('user_clk', 'sys_clk', dir='in', parent_sig=False)
        inst.add_port('user_rst', 'sys_rst', dir='in', parent_sig=False)

        inst.add_port('sys_clk', 'board_clk',     dir='in', parent_sig=False)
        inst.add_port('sys_rst', 'board_clk_rst', dir='in', parent_sig=False)

   


    def initialize(self):
        #self.add_source('forty_gbe')
        #self.add_source('forty_gbe/cpu_buffer/*.xci')

        self.add_source('forty_gbe/SKA_10GBE_MAC')


        #self.add_raw_tcl_cmd("")

        #self.add_source('');

        # roach2 mezzanine slot 0 has 4-7, roach2 mezzanine slot 1 has 0-3, so barrel shift
        # self.port = self.port + 4*((self.slot+1)%2)

        #self.exc_requirements = ['fgbe%d' % self.port]


    def gen_constraints(self):
        cons = []
        # leaving the aux constraints here so that we can support them at a later stage.
        #cons.append(PortConstraint('AUX_CLK_N','AUX_CLK_N'))
        #cons.append(PortConstraint('AUX_CLK_P','AUX_CLK_P'))
        #cons.append(PortConstraint('AUX_SYNCO_P','AUX_SYNCO_P'))
        #cons.append(PortConstraint('AUX_SYNCI_P','AUX_SYNCI_P'))
        #cons.append(PortConstraint('AUX_SYNCO_N','AUX_SYNCO_N'))
        #cons.append(PortConstraint('AUX_SYNCI_N', 'AUX_SYNCI_N'))
        #Need to extract the period and half period for creating the clock
        

        #Port constraints
        cons.append(PortConstraint('MEZ3_'+self.mez3_phy+'_LANE_TX_P', 'MEZ3_'+self.mez3_phy+'_LANE_TX_P', port_index=list(range(4)),  iogroup_index=list(range(4))))
        cons.append(ClockConstraint('MEZ3_REFCLK_%s_P'%self.port,'MEZ3_REFCLK_%s_P'%self.port, period=6.4, port_en=True, virtual_en=False, waveform_min=0.0, waveform_max=3.2))
        cons.append(RawConstraint('create_pblock MEZ3_'+self.mez3_phy+'_QSFP'))
        cons.append(ClockGroupConstraint('-of_objects [get_pins skarab_infr/USER_CLK_MMCM_inst/CLKOUT0]', 'MEZ3_REFCLK_%s_P'%self.port, 'asynchronous'))
        cons.append(InputDelayConstraint(clkname='MEZ3_REFCLK_%s_P'%self.port, consttype='max', constdelay_ns=2.0, add_delay_en=True, portname='FPGA_RESET_N'))
        cons.append(MultiCycleConstraint(multicycletype='hold',sourcepath='get_ports FPGA_RESET_N', destpath='get_clocks MEZ3_REFCLK_%s_P'%self.port, multicycledelay=4))
        return cons



    def gen_tcl_cmds(self):
        tcl_cmds = []

        tcl_cmds.append('import_files -force -fileset constrs_1 %s/forty_gbe/SKA_40GbE_PHY/IEEE802_3_XL_PHY/IEEE802_3_XL_PHY.srcs/constrs_1/new/IEEE802_3_XL_PHY.xdc'%os.getenv('HDL_ROOT'))
        #tcl_cmds.append('set_property is_locked true [get_files [get_property directory [current_project]]/myproj.srcs/sources_1/bd/cont_microblaze/cont_microblaze.bd]')
        #tcl_cmds.append('set_property is_locked true [get_files [get_property directory [current_project]]/myproj.srcs/sources_1/ip/gmii_to_sgmii/gmii_to_sgmii.xci]')
        tcl_cmds.append('set_property processing_order LATE [get_files [get_property directory [current_project]]/myproj.srcs/constrs_1/imports/new/IEEE802_3_XL_PHY.xdc]')

        return {'pre_synth': tcl_cmds}