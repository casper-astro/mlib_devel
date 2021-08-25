import os
from .yellow_block import YellowBlock
from constraints import PortConstraint, ClockConstraint, GenClockConstraint, ClockGroupConstraint, InputDelayConstraint,\
    OutputDelayConstraint, MaxDelayConstraint, MinDelayConstraint, FalsePathConstraint, MultiCycleConstraint, RawConstraint
from itertools import count

from .yellow_block_typecodes import TYPECODE_ETHCORE


class forty_gbe(YellowBlock):
    # @staticmethod
    # def factory(blk, plat, hdl_root=None):
    #    return forty_gbe_xilinx_v7(blk, plat, hdl_root)

    def modify_top(self,top):

        inst = top.get_instance(name=self.fullname, entity='forty_gbe')
        # Wishbone memory for status registers / ARP table
        
        # request a wishbone offset that is a multiple of the port number
        if self.platform.name == 'skarab':
            # This is liable to break if multiple 40GBE blocks don't have their
            # WB interfaces processed in address order
            req_offset = 0x16000 * self.port
        else:
            req_offset = -1 # Let the toolflow decide
        inst.add_wb_interface(self.unique_name, mode='rw', nbytes=0x16000, req_offset=req_offset, typecode=TYPECODE_ETHCORE)

        # forty gbe specific parameters
        inst.add_parameter('FABRIC_MAC',     "48'h%x"%self.fab_mac)
        inst.add_parameter('FABRIC_IP',      "32'h%x"%self.fab_ip)
        inst.add_parameter('FABRIC_PORT',    "16'h%x"%self.fab_udp)
        inst.add_parameter('FABRIC_NETMASK', "32'hFFFFFF00")
        inst.add_parameter('FABRIC_GATEWAY', " 8'h%x"%self.fab_gate)
        inst.add_parameter('FABRIC_ENABLE',  " 1'b%x"%self.fab_en)
        inst.add_parameter('TTL',            " 8'h%x"%self.ttl)
        inst.add_parameter('PROMISC_MODE',   " 1'b%x"%self.promisc_mode)
        use_cpu_tx = self.cpu_tx_en == 'on'
        use_cpu_rx = self.cpu_rx_en == 'on'
        inst.add_parameter('USE_CPU_RX',   " 1'b%x"%int(use_cpu_rx))
        inst.add_parameter('USE_CPU_TX',   " 1'b%x"%int(use_cpu_tx))
        if self.platform.name == 'skarab':
            inst.add_parameter('RX_2B_SWAP',   "true") # SKARAB Microblaze requires some swizzling of RX data read via wishbone

        # User clk is the simulink clock
        inst.add_port('user_clk', 'user_clk', dir='in', parent_sig=False)
        inst.add_port('user_rst', 'sys_rst', dir='in', parent_sig=False)

        # Don't be fooled -- sys_clk is used as the xlgmii clock and MUST be a 156.25 MHz.
        inst.add_port('sys_clk', 'qsfp_gtrefclk_'+str(self.port),     dir='in', parent_sig=False)
        # Should probably use a real reset here, but it would have to be [probably] on the sys_clk domain(?)
        # Empirically (on SNAP2), tying the reset to 0 doesn't seem to cause a problem with the fabric interface.
        inst.add_port('sys_rst', '1\'b0', dir='in', parent_sig=False)

        inst.add_port('REFCLK_P',      'forty_gbe_refclk' + self.suffix + '_p', parent_port=True, dir='in')
        inst.add_port('REFCLK_N',      'forty_gbe_refclk' + self.suffix + '_n', parent_port=True, dir='in')
        inst.add_port('PHY_LANE_RX_P', 'forty_gbe_rx' + self.suffix + '_p', parent_port=True, dir='in', width=4)
        inst.add_port('PHY_LANE_RX_N', 'forty_gbe_rx' + self.suffix + '_n', parent_port=True, dir='in', width=4)
        inst.add_port('PHY_LANE_TX_P', 'forty_gbe_tx' + self.suffix + '_p', parent_port=True, dir='out', width=4)
        inst.add_port('PHY_LANE_TX_N', 'forty_gbe_tx' + self.suffix + '_n', parent_port=True, dir='out', width=4)
        
        inst.add_port('forty_gbe_rst',             self.fullname+'_rst',             width=1,   dir='in')
        inst.add_port('forty_gbe_tx_valid',        self.fullname+'_tx_valid',        width=4,   dir='in')
        inst.add_port('forty_gbe_tx_end_of_frame', self.fullname+'_tx_end_of_frame', width=1,   dir='in')
        inst.add_port('forty_gbe_tx_data',         self.fullname+'_tx_data',         width=256, dir='in')
        inst.add_port('forty_gbe_tx_dest_ip',      self.fullname+'_tx_dest_ip',      width=32,  dir='in')
        inst.add_port('forty_gbe_tx_dest_port',    self.fullname+'_tx_dest_port',    width=16,  dir='in')
        inst.add_port('forty_gbe_tx_overflow',     self.fullname+'_tx_overflow',     width=1,   dir='out')
        inst.add_port('forty_gbe_tx_afull',        self.fullname+'_tx_afull',        width=1,   dir='out')
        inst.add_port('forty_gbe_rx_valid',        self.fullname+'_rx_valid',        width=4,   dir='out')
        inst.add_port('forty_gbe_rx_end_of_frame', self.fullname+'_rx_end_of_frame', width=1,   dir='out')
        inst.add_port('forty_gbe_rx_data',         self.fullname+'_rx_data',         width=256, dir='out')
        inst.add_port('forty_gbe_rx_source_ip',    self.fullname+'_rx_source_ip',    width=32,  dir='out')
        inst.add_port('forty_gbe_rx_dest_ip',      self.fullname+'_rx_dest_ip',      width=32,  dir='out')
        inst.add_port('forty_gbe_rx_source_port',  self.fullname+'_rx_source_port',  width=16,  dir='out')
        inst.add_port('forty_gbe_rx_dest_port',    self.fullname+'_rx_dest_port',    width=16,  dir='out')
        inst.add_port('forty_gbe_rx_bad_frame',    self.fullname+'_rx_bad_frame',    width=1,   dir='out')
        inst.add_port('forty_gbe_rx_overrun',      self.fullname+'_rx_overrun',      width=1,   dir='out')
        inst.add_port('forty_gbe_rx_overrun_ack',  self.fullname+'_rx_overrun_ack',  width=1,   dir='in')
        inst.add_port('forty_gbe_rx_ack',          self.fullname+'_rx_ack',          width=1,   dir='in')

        inst.add_port('forty_gbe_led_rx',          self.fullname+'_led_rx',          width=1,  dir='out')
        inst.add_port('forty_gbe_led_tx',          self.fullname+'_led_tx',          width=1,  dir='out')
        inst.add_port('forty_gbe_led_up',          self.fullname+'_led_up',          width=1,  dir='out')

        inst.add_port('qsfp_gtrefclk',             'qsfp_gtrefclk_'+str(self.port),   width=1,  dir='out')
        #inst.add_port('qsfp_soft_reset',           'qsfp_soft_reset_'+str(self.port), width=1,  dir='in', parent_sig=False)
        inst.add_port('qsfp_soft_reset',           '1\'b0', width=1,  dir='in', parent_sig=False)

        #inst.add_port('eth_if_present',            'eth_if_%s_present'%str(self.port),  width=1,  dir='out', parent_sig=False)
        inst.add_port('eth_if_present',            '',  width=1,  dir='out', parent_sig=False)

        #inst.add_port('phy_rx_up',                 'phy_rx_up_%s' %str(self.port),   width=1,  dir='out', parent_sig=False)
        #inst.add_port('xlgmii_txled',              'xlgmii_txled_%s' %str(self.port),   width=2,  dir='out', parent_sig=False)
        #inst.add_port('xlgmii_rxled',              'xlgmii_rxled_%s' %str(self.port),   width=2,  dir='out', parent_sig=False)
        inst.add_port('phy_rx_up',                 '',   width=1,  dir='out', parent_sig=False)
        inst.add_port('xlgmii_txled',              '',   width=2,  dir='out', parent_sig=False)
        inst.add_port('xlgmii_rxled',              '',   width=2,  dir='out', parent_sig=False)


    def initialize(self):

        if self.platform.fpga.startswith('xcku'):
            self.add_source("forty_gbe/SKA_40GBE_PHY/IEEE802_3_XL_PMA/ip/XLAUI/xlaui_us.xci")
            self.add_source('forty_gbe/SKA_40GBE_PHY/IEEE802_3_XL_PMA/hdl/ultrascale/*')
        elif self.platform.fpga.startswith('xc7'):
            self.add_source("forty_gbe/SKA_40GBE_PHY/IEEE802_3_XL_PMA/ip/XLAUI/xlaui.xci")
            self.add_source('forty_gbe/SKA_40GBE_PHY/IEEE802_3_XL_PMA/hdl/7series/*')
            

        #self.add_source('forty_gbe/SKA_10GBE_MAC')
        self.add_source('forty_gbe/SKA_40GBE_MAC')
        self.add_source('forty_gbe/SKA_40GBE_PHY/IEEE802_3_XL_PCS/hdl')
        self.add_source('forty_gbe/SKA_40GBE_PHY/IEEE802_3_XL_PHY_top')
        self.add_source('forty_gbe/SKA_40GBE_PHY/IEEE802_3_XL_PHY/hdl')
        self.add_source('forty_gbe/SKA_40GBE_PHY/IEEE802_3_XL_PMA/hdl/*.vhd')
        self.add_source('forty_gbe/*.vhd')
        self.add_source('forty_gbe/*.sv')
        self.add_source('forty_gbe/*.v')
        self.add_source("forty_gbe/arp_cache/arp_cache.coe")
        #self.add_source("forty_gbe/cont_microblaze/ip/cont_microblaze_axi_slave_wishbone_classic_master_0_0/cont_microblaze_axi_slave_wishbone_classic_master_0_0.upgrade_log")
        self.add_source("forty_gbe/gmii_to_sgmii/*.xci")
        self.add_source("forty_gbe/isp_spi_buffer/*.xci")
        self.add_source("forty_gbe/cross_clock_fifo_67x16/*.xci")
        self.add_source("forty_gbe/tx_packet_fifo/*.xci")
        self.add_source("forty_gbe/tx_packet_ctrl_fifo/*.xci")
        self.add_source("forty_gbe/tx_fifo_ext/*.xci")
        self.add_source("forty_gbe/tx_data_fifo_ext/*.xci")
        self.add_source("forty_gbe/rx_packet_fifo_bram/*.xci")
        self.add_source("forty_gbe/rx_packet_ctrl_fifo/*.xci")
        self.add_source("forty_gbe/cpu_buffer/*.xci")
        self.add_source("forty_gbe/arp_cache/*.xci")
        self.add_source("forty_gbe/xaui_to_gmii_fifo/*.xci")
        self.add_source("forty_gbe/gmii_to_xaui_fifo/*.xci")
        self.add_source("forty_gbe/packet_byte_count_fifo/*.xci")
        self.add_source("forty_gbe/ska_tx_packet_fifo/*.xci")
        self.add_source("forty_gbe/ska_tx_packet_ctrl_fifo/*.xci")
        self.add_source("forty_gbe/ska_rx_packet_fifo/*.xci")
        self.add_source("forty_gbe/ska_rx_packet_ctrl_fifo/*.xci")
        self.add_source("forty_gbe/ska_cpu_buffer/*.xci")
        self.add_source("forty_gbe/cross_clock_fifo_36x16/*.xci")
        self.add_source("forty_gbe/cross_clock_fifo_259x16/*.xci")
        self.add_source("forty_gbe/common_clock_fifo_32x16/*.xci")
        self.add_source("forty_gbe/cross_clock_fifo_wb_out_73x16/*.xci")
        self.add_source("forty_gbe/overlap_buffer/*.xci")
        self.add_source("forty_gbe/SKA_40GBE_PHY/IEEE802_3_XL_PCS/ip/fifo_dual_clk/*.xci")
        self.add_source("forty_gbe/SKA_40GBE_PHY/IEEE802_3_XL_PCS/ip/XGMII_FIFO_DUAL_SYNC/*.xci")
        self.add_source("forty_gbe/cpu_rx_packet_size/*.xci")
        self.add_source("forty_gbe/SKA_40GBE_PHY/IEEE802_3_XL_PCS/ip/RS256_FIFO/*.xci")
        #self.add_source("forty_gbe/SKA_40GBE_PHY/IEEE802_3_XL_PHY/ip/IEEE802_3_XL_VIO/*.xci") # Only for debugging
        #self.add_source("forty_gbe/WISHBONE/wishbone_forty_gb_eth_attach.vhd") # The original SARAO/SKARAB Wb attachment
        self.add_source("forty_gbe/WISHBONE/wishbone_forty_gb_eth_attach2.v") # An attachment based on the 10GbE module

        self.suffix = "_%d" % self.inst_id

        #self.add_raw_tcl_cmd("")

        #self.add_source('');

        # roach2 mezzanine slot 0 has 4-7, roach2 mezzanine slot 1 has 0-3, so barrel shift
        # self.port = self.port + 4*((self.slot+1)%2)

        #self.exc_requirements = ['fgbe%d' % self.port]


    def gen_constraints(self):
        cons = []

        #Port constraints
        cons.append(PortConstraint('forty_gbe_tx' + self.suffix + '_p', 'forty_gbe_tx_p', port_index=range(4),  iogroup_index=range(4*self.port, 4*(self.port + 1))))
        cons.append(PortConstraint('forty_gbe_tx' + self.suffix + '_n', 'forty_gbe_tx_n', port_index=range(4),  iogroup_index=range(4*self.port, 4*(self.port + 1))))
        cons.append(PortConstraint('forty_gbe_rx' + self.suffix + '_p', 'forty_gbe_rx_p', port_index=range(4),  iogroup_index=range(4*self.port, 4*(self.port + 1))))
        cons.append(PortConstraint('forty_gbe_rx' + self.suffix + '_n', 'forty_gbe_rx_n', port_index=range(4),  iogroup_index=range(4*self.port, 4*(self.port + 1))))

        cons.append(PortConstraint('forty_gbe_refclk' + self.suffix + '_p', 'forty_gbe_refclk_p', iogroup_index=self.port))
        cons.append(PortConstraint('forty_gbe_refclk' + self.suffix + '_n', 'forty_gbe_refclk_n', iogroup_index=self.port))
        clockconst = ClockConstraint('forty_gbe_refclk' + self.suffix + '_p', period=6.4, port_en=True, virtual_en=False, waveform_min=0.0, waveform_max=3.2)
        cons.append(clockconst)

        cons.append(ClockGroupConstraint(clockconst.name, '-include_generated_clocks -of_objects [get_nets user_clk]', 'asynchronous'))
        cons.append(ClockGroupConstraint(clockconst.name, '-include_generated_clocks -of_objects [get_nets wb_clk_i]', 'asynchronous'))

        return cons

    def gen_tcl_cmds(self):
        tcl_cmds = []

        tcl_cmds.append('import_files -force -fileset constrs_1 %s/forty_gbe/SKA_40GBE_PHY/IEEE802_3_XL_PCS/constraints/IEEE802_3_XL_PCS.xdc'%os.getenv('HDL_ROOT'))
        tcl_cmds.append('import_files -force -fileset constrs_1 %s/forty_gbe/SKA_40GBE_PHY/IEEE802_3_XL_PCS/constraints/DATA_FREQUENCY_DIVIDER.xdc'%os.getenv('HDL_ROOT'))
        tcl_cmds.append('import_files -force -fileset constrs_1 %s/forty_gbe/SKA_40GBE_PHY/IEEE802_3_XL_PCS/constraints/DATA_FREQUENCY_MULTIPLIER.xdc'%os.getenv('HDL_ROOT'))
        tcl_cmds.append('import_files -force -fileset constrs_1 %s/forty_gbe/SKA_40GBE_PHY/IEEE802_3_XL_PCS/constraints/DUAL_CLOCK_STROBE_GENERATOR.xdc'%os.getenv('HDL_ROOT'))
        tcl_cmds.append('import_files -force -fileset constrs_1 %s/forty_gbe/SKA_40GBE_PHY/IEEE802_3_XL_PHY/constraints/IEEE802_3_XL_PHY.xdc'%os.getenv('HDL_ROOT'))
        tcl_cmds.append('import_files -force -fileset constrs_1 %s/forty_gbe/SKA_40GBE_PHY/IEEE802_3_XL_PHY/constraints/IEEE802_3_XL_PHY.xdc'%os.getenv('HDL_ROOT'))
        tcl_cmds.append('set_property SCOPED_TO_REF IEEE802_3_XL_PCS [get_files [get_property directory [current_project]]/myproj.srcs/constrs_1/imports/constraints/IEEE802_3_XL_PCS.xdc]')
        tcl_cmds.append('set_property processing_order LATE [get_files [get_property directory [current_project]]/myproj.srcs/constrs_1/imports/constraints/IEEE802_3_XL_PCS.xdc]')
        tcl_cmds.append('set_property SCOPED_TO_REF DATA_FREQUENCY_DIVIDER [get_files [get_property directory [current_project]]/myproj.srcs/constrs_1/imports/constraints/DATA_FREQUENCY_DIVIDER.xdc]')
        tcl_cmds.append('set_property processing_order LATE [get_files [get_property directory [current_project]]/myproj.srcs/constrs_1/imports/constraints/DATA_FREQUENCY_DIVIDER.xdc]')
        tcl_cmds.append('set_property SCOPED_TO_REF DATA_FREQUENCY_MULTIPLIER [get_files [get_property directory [current_project]]/myproj.srcs/constrs_1/imports/constraints/DATA_FREQUENCY_MULTIPLIER.xdc]')
        tcl_cmds.append('set_property processing_order LATE [get_files [get_property directory [current_project]]/myproj.srcs/constrs_1/imports/constraints/DATA_FREQUENCY_MULTIPLIER.xdc]')
        tcl_cmds.append('set_property SCOPED_TO_REF IEEE802_3_XL_PHY [get_files [get_property directory [current_project]]/myproj.srcs/constrs_1/imports/constraints/IEEE802_3_XL_PHY.xdc]')
        tcl_cmds.append('set_property processing_order LATE [get_files [get_property directory [current_project]]/myproj.srcs/constrs_1/imports/constraints/IEEE802_3_XL_PHY.xdc]')
        tcl_cmds.append('set_property SCOPED_TO_REF DUAL_CLOCK_STROBE_GENERATOR [get_files [get_property directory [current_project]]/myproj.srcs/constrs_1/imports/constraints/DUAL_CLOCK_STROBE_GENERATOR.xdc]')
        tcl_cmds.append('set_property processing_order LATE [get_files [get_property directory [current_project]]/myproj.srcs/constrs_1/imports/constraints/DUAL_CLOCK_STROBE_GENERATOR.xdc]')

        return {'pre_synth': tcl_cmds}
