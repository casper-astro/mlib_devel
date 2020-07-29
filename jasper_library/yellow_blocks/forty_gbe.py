import os
from .yellow_block import YellowBlock
from constraints import PortConstraint, ClockConstraint, GenClockConstraint, ClockGroupConstraint, InputDelayConstraint,\
    OutputDelayConstraint, MaxDelayConstraint, MinDelayConstraint, FalsePathConstraint, MultiCycleConstraint, RawConstraint
from itertools import count



class forty_gbe(YellowBlock):
    # @staticmethod
    # def factory(blk, plat, hdl_root=None):
    #    return forty_gbe_xilinx_v7(blk, plat, hdl_root)

    def modify_top(self,top):

        inst = top.get_instance(name=self.fullname, entity='forty_gbe')
        # Wishbone memory for status registers / ARP table
        
        # request a wishbone offset that is a multiple of the port number
        req_offset = 0x16000 * self.port
        inst.add_wb_interface(self.unique_name, mode='rw', nbytes=0x16000, req_offset=req_offset) # as in matlab code

        # forty gbe specific parameters
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

        self.mez3_phy = "PHY11"
        self.psize_extend = False
        self.clock_region2 = ""
        self.clock_region = "CLOCKREGION_X1Y7:CLOCKREGION_X1Y7"
        if  (self.port ==  1):
            self.mez3_phy = "PHY12"
            self.clock_region = "CLOCKREGION_X1Y6:CLOCKREGION_X1Y6"
        elif  (self.port ==  2):
            self.mez3_phy = "PHY21"
            self.clock_region = "CLOCKREGION_X1Y5:CLOCKREGION_X1Y5"
        elif  (self.port ==  3):
            self.mez3_phy = "PHY22"
            self.clock_region = "CLOCKREGION_X0Y4:CLOCKREGION_X1Y4"
            self.clock_region2 = "CLOCKREGION_X1Y3:CLOCKREGION_X1Y3"
            self.psize_extend = True
        else:
            self.mez3_phy == "PHY11"
            self.clock_region = "CLOCKREGION_X1Y7:CLOCKREGION_X1Y7"

        inst.add_port('MEZ3_REFCLK_P',      'MEZ3_REFCLK_%s_P'%self.port,       parent_port=True, dir='in')
        inst.add_port('MEZ3_REFCLK_N',      'MEZ3_REFCLK_%s_N'%self.port,       parent_port=True, dir='in')
        inst.add_port('MEZ3_PHY_LANE_RX_P', 'MEZ3_'+self.mez3_phy+'_LANE_RX_P', parent_port=True, dir='in', width=4)
        inst.add_port('MEZ3_PHY_LANE_RX_N', 'MEZ3_'+self.mez3_phy+'_LANE_RX_N', parent_port=True, dir='in', width=4)
        inst.add_port('MEZ3_PHY_LANE_TX_P', 'MEZ3_'+self.mez3_phy+'_LANE_TX_P', parent_port=True, dir='out', width=4)
        inst.add_port('MEZ3_PHY_LANE_TX_N', 'MEZ3_'+self.mez3_phy+'_LANE_TX_N', parent_port=True, dir='out', width=4)
        
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
        inst.add_port('qsfp_soft_reset',           'qsfp_soft_reset_'+str(self.port), width=1,  dir='in', parent_sig=False)

        inst.add_port('fgbe_if_present',           'fgbe_if_%s_present'%str(self.port),  width=1,  dir='out', parent_sig=False)

        inst.add_port('phy_rx_up',                 'fgbe_phy_rx_up_%s' %str(self.port),   width=1,  dir='out', parent_sig=False)
        inst.add_port('xlgmii_txled',              'xlgmii_txled_%s' %str(self.port),   width=2,  dir='out', parent_sig=False)
        inst.add_port('xlgmii_rxled',              'xlgmii_rxled_%s' %str(self.port),   width=2,  dir='out', parent_sig=False)


    def initialize(self):
        #self.add_source('forty_gbe')
        #self.add_source('forty_gbe/cpu_buffer/*.xci')

        #self.add_source('forty_gbe/SKA_10GBE_MAC')
        self.add_source('forty_gbe/SKA_40GBE_MAC')
        self.add_source('forty_gbe/SKA_40GbE_PHY/IEEE802_3_XL_PCS/IEEE802_3_XL_PCS.srcs/sources_1/new')
        self.add_source('forty_gbe/SKA_40GbE_PHY/IEEE802_3_XL_PHY_top')
        self.add_source('forty_gbe/SKA_40GbE_PHY/IEEE802_3_XL_PMA/IEEE802_3_XL_PMA.srcs/sources_1/new')
        self.add_source('forty_gbe/SKA_40GbE_PHY/IEEE802_3_XL_PHY/IEEE802_3_XL_PHY.srcs/sources_1/new')
        self.add_source('forty_gbe/forty_gbe.vhd')
        #self.add_source('forty_gbe/*.sv')
        #self.add_source('forty_gbe/*.v')
        #self.add_source("forty_gbe/arp_cache/arp_cache.coe")
        #self.add_source("forty_gbe/cont_microblaze/ip/cont_microblaze_axi_slave_wishbone_classic_master_0_0/cont_microblaze_axi_slave_wishbone_classic_master_0_0.upgrade_log")
        #self.add_source("forty_gbe/gmii_to_sgmii/*.xci")
        #self.add_source("forty_gbe/isp_spi_buffer/*.xci")
        #self.add_source("forty_gbe/tx_packet_fifo/*.xci")
        #self.add_source("forty_gbe/tx_packet_ctrl_fifo/*.xci")
        #self.add_source("forty_gbe/tx_fifo_ext/*.xci")
        #self.add_source("forty_gbe/tx_data_fifo_ext/*.xci")
        #self.add_source("forty_gbe/rx_packet_fifo_bram/*.xci")
        #self.add_source("forty_gbe/rx_packet_ctrl_fifo/*.xci")
        #self.add_source("forty_gbe/cpu_buffer/*.xci")
        #self.add_source("forty_gbe/arp_cache/*.xci")
        #self.add_source("forty_gbe/xaui_to_gmii_fifo/*.xci")
        #self.add_source("forty_gbe/gmii_to_xaui_fifo/*.xci")
        #self.add_source("forty_gbe/packet_byte_count_fifo/*.xci")
        self.add_source("forty_gbe/ska_tx_packet_fifo/*.xci")
        self.add_source("forty_gbe/ska_tx_packet_ctrl_fifo/*.xci")
        self.add_source("forty_gbe/ska_rx_packet_fifo/*.xci")
        self.add_source("forty_gbe/ska_rx_packet_ctrl_fifo/*.xci")
        #self.add_source("forty_gbe/ska_cpu_buffer/*.xci")
        #self.add_source("forty_gbe/cross_clock_fifo_36x16/*.xci")
        #self.add_source("forty_gbe/cross_clock_fifo_259x16/*.xci")
        #self.add_source("forty_gbe/common_clock_fifo_32x16/*.xci")
        #self.add_source("forty_gbe/cross_clock_fifo_67x16/*.xci")
        #self.add_source("forty_gbe/cross_clock_fifo_wb_out_73x16/*.xci")
        self.add_source("forty_gbe/overlap_buffer/*.xci")
        self.add_source("forty_gbe/SKA_40GbE_PHY/IEEE802_3_XL_PMA/IEEE802_3_XL_PMA.srcs/sources_1/ip/XLAUI/*.xci")
        self.add_source("forty_gbe/SKA_40GbE_PHY/IEEE802_3_XL_PCS/IEEE802_3_XL_PCS.srcs/sources_1/ip/fifo_dual_clk/*.xci")
        self.add_source("forty_gbe/SKA_40GbE_PHY/IEEE802_3_XL_PCS/IEEE802_3_XL_PCS.srcs/sources_1/ip/XGMII_FIFO_DUAL_SYNC/*.xci")
        self.add_source("forty_gbe/cpu_rx_packet_size/*.xci")
        self.add_source("forty_gbe/SKA_40GbE_PHY/IEEE802_3_XL_PCS/IEEE802_3_XL_PCS.srcs/sources_1/ip/RS256_FIFO/*.xci")
        self.add_source("forty_gbe/SKA_40GbE_PHY/IEEE802_3_XL_PHY/IEEE802_3_XL_PHY.srcs/sources_1/ip/IEEE802_3_XL_VIO/*.xci")

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
        cons.append(PortConstraint('MEZ3_'+self.mez3_phy+'_LANE_TX_N', 'MEZ3_'+self.mez3_phy+'_LANE_TX_N', port_index=list(range(4)),  iogroup_index=list(range(4))))
        cons.append(PortConstraint('MEZ3_'+self.mez3_phy+'_LANE_RX_P', 'MEZ3_'+self.mez3_phy+'_LANE_RX_P', port_index=list(range(4)),  iogroup_index=list(range(4))))
        cons.append(PortConstraint('MEZ3_'+self.mez3_phy+'_LANE_RX_N', 'MEZ3_'+self.mez3_phy+'_LANE_RX_N', port_index=list(range(4)),  iogroup_index=list(range(4))))

        cons.append(PortConstraint('MEZ3_REFCLK_%s_P'%self.port,'MEZ3_REFCLK_%s_P'%self.port))
        cons.append(PortConstraint('MEZ3_REFCLK_%s_N'%self.port,'MEZ3_REFCLK_%s_N'%self.port))
        cons.append(ClockConstraint('MEZ3_REFCLK_%s_P'%self.port,'MEZ3_REFCLK_%s_P'%self.port, period=6.4, port_en=True, virtual_en=False, waveform_min=0.0, waveform_max=3.2))

        cons.append(RawConstraint('create_pblock MEZ3_'+self.mez3_phy+'_QSFP'))
        cons.append(RawConstraint('add_cells_to_pblock [get_pblocks MEZ3_'+self.mez3_phy+'_QSFP] [get_cells -quiet [list '+self.fullname+'/IEEE802_3_XL_PHY_0/PHY_inst/RX_CLK_RCC]]'))
        cons.append(RawConstraint('add_cells_to_pblock [get_pblocks MEZ3_'+self.mez3_phy+'_QSFP] [get_cells -quiet [list '+self.fullname+'/IEEE802_3_XL_PHY_0/PHY_inst/TX_CLK_RCC]]'))
        cons.append(RawConstraint('resize_pblock [get_pblocks MEZ3_'+self.mez3_phy+'_QSFP] -add {'+self.clock_region+'}'))
        if(self.psize_extend):
          cons.append(RawConstraint('resize_pblock [get_pblocks MEZ3_'+self.mez3_phy+'_QSFP] -add {'+self.clock_region2+'}'))
          cons.append(RawConstraint('set_property BEL MMCME2_ADV [get_cells [list '+self.fullname+'/IEEE802_3_XL_lPHY_0/PHY_inst/RX_CLK_RCC/ref_clkB_MMCME2_BASE_inst]]'))
          cons.append(RawConstraint('set_property LOC MMCME2_ADV_X1Y4 [get_cells [list '+self.fullname+'/IEEE802_3_XL_PHY_0/PHY_inst/RX_CLK_RCC/ref_clkB_MMCME2_BASE_inst]]'))
          cons.append(RawConstraint('set_property BEL PLLE2_ADV [get_cells [list '+self.fullname+'/IEEE802_3_XL_PHY_0/PHY_inst/TX_CLK_RCC/PLLE2_BASE_inst]]'))
          cons.append(RawConstraint('set_property LOC PLLE2_ADV_X1Y4 [get_cells [list '+self.fullname+'/IEEE802_3_XL_PHY_0/PHY_inst/TX_CLK_RCC/PLLE2_BASE_inst]]'))
          cons.append(RawConstraint('set_property BEL MMCME2_ADV [get_cells [list skarab_infr/SYS_CLK_MMCM_inst]]'))
          cons.append(RawConstraint('set_property LOC MMCME2_ADV_X1Y3 [get_cells [list skarab_infr/SYS_CLK_MMCM_inst]]'))
          cons.append(RawConstraint('set_property BEL MMCME2_ADV [get_cells [list skarab_infr/USER_CLK_MMCM_inst]]'))
          cons.append(RawConstraint('set_property LOC MMCME2_ADV_X0Y4 [get_cells [list skarab_infr/USER_CLK_MMCM_inst]]'))
          cons.append(RawConstraint('set_property CLOCK_DEDICATED_ROUTE ANY_CMT_COLUMN [get_nets skarab_infr/refclk_0]'))
        #cons.append(ClockGroupConstraint('MEZ3_REFCLK_%s_P'%self.port, '-include_generated_clocks FPGA_REFCLK_BUF1_P', 'asynchronous'))
        cons.append(ClockGroupConstraint('-of_objects [get_pins skarab_infr/SYS_CLK_MMCM_inst/CLKOUT0]', 'MEZ3_REFCLK_%s_P'%self.port, 'asynchronous'))
        #cons.append(ClockGroupConstraint('MEZ3_REFCLK_%s_P'%self.port, '-of_objects [get_pins skarab_infr/gmii_to_sgmii_0/U0/core_clocking_i/mmcm_adv_inst/CLKOUT0]', 'asynchronous'))
        #cons.append(ClockGroupConstraint('-of_objects [get_pins %s/gmii_to_sgmii_0/U0/core_clocking_i/mmcm_adv_inst/CLKOUT0]' %self.fullname, 'MEZ3_REFCLK_%s_P'%self.port, 'asynchronous'))
        cons.append(ClockGroupConstraint('MEZ3_REFCLK_%s_P'%self.port, 'FPGA_EMCCLK2', 'asynchronous'))
        cons.append(ClockGroupConstraint('FPGA_EMCCLK2', 'MEZ3_REFCLK_%s_P'%self.port, 'asynchronous'))
        cons.append(ClockGroupConstraint('MEZ3_REFCLK_%s_P'%self.port, '-of_objects [get_pins skarab_infr/SYS_CLK_MMCM_inst/CLKOUT0]', 'asynchronous'))
        cons.append(ClockGroupConstraint('MEZ3_REFCLK_%s_P'%self.port, '-of_objects [get_pins skarab_infr/USER_CLK_MMCM_inst/CLKOUT0]','asynchronous'))
        cons.append(ClockGroupConstraint('MEZ3_REFCLK_%s_P'%self.port, '-of_objects [get_pins skarab_infr/SYS_CLK_MMCM_inst/CLKOUT1]', 'asynchronous'))
        cons.append(ClockGroupConstraint('-of_objects [get_pins skarab_infr/SYS_CLK_MMCM_inst/CLKOUT1]', 'MEZ3_REFCLK_%s_P'%self.port, 'asynchronous'))
        cons.append(ClockGroupConstraint('-of_objects [get_pins skarab_infr/USER_CLK_MMCM_inst/CLKOUT0]', 'MEZ3_REFCLK_%s_P'%self.port, 'asynchronous'))
        
        #cons.append(ClockGroupConstraint('-of_objects [get_pins %s/SYS_CLK_MMCM_inst/CLKOUT0]'  % self.fullname, 'MEZ3_REFCLK_%s_P'%self.port, 'asynchronous'))
        #cons.append(ClockGroupConstraint('MEZ3_REFCLK_%s_P'%self.port, '-of_objects [get_pins %s/gmii_to_sgmii_0/U0/core_clocking_i/mmcm_adv_inst/CLKOUT0]' % self.fullname, 'asynchronous'))
        #cons.append(ClockGroupConstraint('VIRTUAL_clkout0', 'MEZ3_REFCLK_%s_P'%self.port, 'asynchronous'))
        #cons.append(ClockGroupConstraint('virtual_clock', 'MEZ3_REFCLK_%s_P'%self.port, 'asynchronous'))
        #cons.append(ClockGroupConstraint('MEZ3_REFCLK_%s_P'%self.port, 'FPGA_EMCCLK2', 'asynchronous'))
        #cons.append(ClockGroupConstraint('FPGA_EMCCLK2', 'MEZ3_REFCLK_%s_P'%self.port, 'asynchronous'))
        #cons.append(ClockGroupConstraint('MEZ3_REFCLK_%s_P'%self.port, 'virtual_clock', 'asynchronous'))
        #cons.append(ClockGroupConstraint('VIRTUAL_I', 'MEZ3_REFCLK_%s_P'%self.port, 'asynchronous'))
        #cons.append(ClockGroupConstraint('MEZ3_REFCLK_%s_P'%self.port, 'VIRTUAL_I','asynchronous'))
        #cons.append(ClockGroupConstraint('MEZ3_REFCLK_%s_P'%self.port, '-of_objects [get_pins %s/SYS_CLK_MMCM_inst/CLKOUT1]' % self.fullname, 'asynchronous'))
        #cons.append(ClockGroupConstraint('-of_objects [get_pins %s/SYS_CLK_MMCM_inst/CLKOUT1]' % self.fullname, 'MEZ3_REFCLK_%s_P'%self.port, 'asynchronous'))
        #cons.append(ClockGroupConstraint('MEZ3_REFCLK_%s_P'%self.port, '-of_objects [get_pins %s/USER_CLK_MMCM_inst/CLKOUT0]' % self.fullname, 'asynchronous'))
        #cons.append(ClockGroupConstraint('-of_objects [get_pins %s/USER_CLK_MMCM_inst/CLKOUT0]' % self.fullname, 'MEZ3_REFCLK_%s_P'%self.port, 'asynchronous'))
        

        cons.append(InputDelayConstraint(clkname='MEZ3_REFCLK_%s_P'%self.port, consttype='min', constdelay_ns=1.0, add_delay_en=True, portname='FPGA_RESET_N'))
        cons.append(InputDelayConstraint(clkname='MEZ3_REFCLK_%s_P'%self.port, consttype='max', constdelay_ns=2.0, add_delay_en=True, portname='FPGA_RESET_N'))
        #cons.append(MultiCycleConstraint(multicycletype='setup',sourcepath='get_ports FPGA_RESET_N', destpath='get_clocks MEZ3_REFCLK_%s_P'%self.port, multicycledelay=4))
        #cons.append(MultiCycleConstraint(multicycletype='hold',sourcepath='get_ports FPGA_RESET_N', destpath='get_clocks MEZ3_REFCLK_%s_P'%self.port, multicycledelay=4))
        return cons



    def gen_tcl_cmds(self):
        tcl_cmds = []

        #tcl_cmds.append('import_files -force -fileset constrs_1 %s/forty_gbe/Constraints/gmii_to_sgmii.xdc'%os.getenv('HDL_ROOT'))
        tcl_cmds.append('import_files -force -fileset constrs_1 %s/forty_gbe/SKA_40GbE_PHY/IEEE802_3_XL_PCS/IEEE802_3_XL_PCS.srcs/constrs_1/new/IEEE802_3_XL_PCS.xdc'%os.getenv('HDL_ROOT'))
        tcl_cmds.append('import_files -force -fileset constrs_1 %s/forty_gbe/SKA_40GbE_PHY/IEEE802_3_XL_PCS/IEEE802_3_XL_PCS.srcs/constrs_1/new/DATA_FREQUENCY_DIVIDER.xdc'%os.getenv('HDL_ROOT'))
        tcl_cmds.append('import_files -force -fileset constrs_1 %s/forty_gbe/SKA_40GbE_PHY/IEEE802_3_XL_PCS/IEEE802_3_XL_PCS.srcs/constrs_1/new/DATA_FREQUENCY_MULTIPLIER.xdc'%os.getenv('HDL_ROOT'))
        tcl_cmds.append('import_files -force -fileset constrs_1 %s/forty_gbe/SKA_40GbE_PHY/IEEE802_3_XL_PHY/IEEE802_3_XL_PHY.srcs/constrs_1/new/IEEE802_3_XL_PHY.xdc'%os.getenv('HDL_ROOT'))
        #tcl_cmds.append('set_property is_locked true [get_files [get_property directory [current_project]]/myproj.srcs/sources_1/bd/cont_microblaze/cont_microblaze.bd]')
        #tcl_cmds.append('set_property is_locked true [get_files [get_property directory [current_project]]/myproj.srcs/sources_1/ip/gmii_to_sgmii/gmii_to_sgmii.xci]')
        tcl_cmds.append('set_property SCOPED_TO_REF IEEE802_3_XL_PCS [get_files [get_property directory [current_project]]/myproj.srcs/constrs_1/imports/new/IEEE802_3_XL_PCS.xdc]')
        tcl_cmds.append('set_property processing_order LATE [get_files [get_property directory [current_project]]/myproj.srcs/constrs_1/imports/new/IEEE802_3_XL_PCS.xdc]')
        tcl_cmds.append('set_property SCOPED_TO_REF DATA_FREQUENCY_DIVIDER [get_files [get_property directory [current_project]]/myproj.srcs/constrs_1/imports/new/DATA_FREQUENCY_DIVIDER.xdc]')
        tcl_cmds.append('set_property processing_order LATE [get_files [get_property directory [current_project]]/myproj.srcs/constrs_1/imports/new/DATA_FREQUENCY_DIVIDER.xdc]')
        tcl_cmds.append('set_property SCOPED_TO_REF DATA_FREQUENCY_MULTIPLIER [get_files [get_property directory [current_project]]/myproj.srcs/constrs_1/imports/new/DATA_FREQUENCY_MULTIPLIER.xdc]')
        tcl_cmds.append('set_property processing_order LATE [get_files [get_property directory [current_project]]/myproj.srcs/constrs_1/imports/new/DATA_FREQUENCY_MULTIPLIER.xdc]')
        tcl_cmds.append('set_property SCOPED_TO_REF IEEE802_3_XL_PHY [get_files [get_property directory [current_project]]/myproj.srcs/constrs_1/imports/new/IEEE802_3_XL_PHY.xdc]')
        tcl_cmds.append('set_property processing_order LATE [get_files [get_property directory [current_project]]/myproj.srcs/constrs_1/imports/new/IEEE802_3_XL_PHY.xdc]')

        return {'pre_synth': tcl_cmds}
