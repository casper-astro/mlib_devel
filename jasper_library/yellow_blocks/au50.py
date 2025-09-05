from .yellow_block import YellowBlock
from clk_factors import clk_factors
from constraints import ClockConstraint, ClockGroupConstraint, PortConstraint, RawConstraint
import os


class au50(YellowBlock):
    def initialize(self):
        self.add_source('utils/cdc_synchroniser.vhd')
        self.add_source('serial_pipe')
        self.add_source('dsp_send')
        self.add_source('utils/dna_wrapper.vhd')
        self.add_source('alveo_onehundred_gbe/')
        self.add_source('au50')
        self.provides = [
            "sys_clk",
            "sys_clk90",
            "sys_clk180",
            "sys_clk270",
            "user_rst"
        ]

    def modify_top(self,top):
        inst = top.get_instance('au50_bd', 'au50_bd_inst')
	    
        inst.add_port('sys_clk',              'sys_clk',       dir='out')
        inst.add_port('sys_clk90',            'sys_clk90',     dir='out')
        inst.add_port('sys_clk180',           'sys_clk180',    dir='out')
        inst.add_port('sys_clk270',           'sys_clk270',    dir='out')
        inst.add_port('sys_rst_n',            'sys_rst_n',     dir='out')
        inst.add_port('cmc_clk_clk_n',        'cmc_clk_clk_n', dir='in', parent_port=True)
        inst.add_port('cmc_clk_clk_p',        'cmc_clk_clk_p', dir='in', parent_port=True)
        inst.add_port('hbm_clk_clk_n',        'hbm_clk_clk_n', dir='in',  parent_port=True)
        inst.add_port('hbm_clk_clk_p',        'hbm_clk_clk_p', dir='in',  parent_port=True)
        inst.add_port('s_axi_aclk',           'axil_clk',      dir='out')
        inst.add_port('s_axi_areset_n',       'axil_rst_n',    dir='out')

        #inst.add_port('hbm_clk_clk_n', 'hbm_clk_clk_n', dir='in', parent_port=True)
        #inst.add_port('hbm_clk_clk_p', 'hbm_clk_clk_p', dir='in', parent_port=True)
        inst.add_port('hbm_cattrip_tri_o',    'hbm_cattrip_tri_o',    dir='out', parent_port=True)

        inst.add_port('pci_express_x1_rxn',   'pci_express_x1_rxn',   dir='in',  parent_port=True)
        inst.add_port('pci_express_x1_rxp',   'pci_express_x1_rxp',   dir='in',  parent_port=True)
        inst.add_port('pci_express_x1_txn',   'pci_express_x1_txn',   dir='out', parent_port=True)
        inst.add_port('pci_express_x1_txp',   'pci_express_x1_txp',   dir='out', parent_port=True)
        inst.add_port('pcie_perstn',          'pcie_perstn',          dir='in',  parent_port=True)
        inst.add_port('pcie_refclk_clk_n',    'pcie_refclk_clk_n',    dir='in',  parent_port=True)
        inst.add_port('pcie_refclk_clk_p',    'pcie_refclk_clk_p',    dir='in',  parent_port=True)
        inst.add_port('satellite_gpio_0',     'satellite_gpio_0',     dir='in',  parent_port=True, width=2)
        inst.add_port('satellite_uart_0_rxd', 'satellite_uart_0_rxd', dir='in',  parent_port=True)
        inst.add_port('satellite_uart_0_txd', 'satellite_uart_0_txd', dir='out', parent_port=True)
        
        inst.add_port('gt_ref_clk_0_clk_n',   'gt_ref_clk_0_clk_n',    dir='in',  parent_port=True)
        inst.add_port('gt_ref_clk_0_clk_p',   'gt_ref_clk_0_clk_p',    dir='in',  parent_port=True)
        inst.add_port('gt_serial_port_0_grx_n', 'gt_serial_port_0_grx_n',    dir='in',  parent_port=True, width=4)
        inst.add_port('gt_serial_port_0_grx_p', 'gt_serial_port_0_grx_p',    dir='in',  parent_port=True, width=4)
        inst.add_port('gt_serial_port_0_gtx_n', 'gt_serial_port_0_gtx_n',    dir='out',  parent_port=True, width=4)
        inst.add_port('gt_serial_port_0_gtx_p', 'gt_serial_port_0_gtx_p',    dir='out',  parent_port=True, width=4)
        
        inst.add_port('M04_AXI_0_araddr',  'M_AXI_araddr',   dir='out', width=32)
        inst.add_port('M04_AXI_0_arready', 'M_AXI_arready',  dir='out', width=1)
        inst.add_port('M04_AXI_0_arvalid', 'M_AXI_arvalid',  dir='out', width=1)
        inst.add_port('M04_AXI_0_awaddr',  'M_AXI_awaddr',   dir='out', width=32)
        inst.add_port('M04_AXI_0_awready', 'M_AXI_awready',  dir='in',  width=1)
        inst.add_port('M04_AXI_0_awvalid', 'M_AXI_awvalid',  dir='out', width=1)
        inst.add_port('M04_AXI_0_bready',  'M_AXI_bready',   dir='out', width=1)
        inst.add_port('M04_AXI_0_bresp',   'M_AXI_bresp',    dir='in',  width=2)
        inst.add_port('M04_AXI_0_bvalid',  'M_AXI_bvalid',   dir='in',  width=1)
        inst.add_port('M04_AXI_0_rdata',   'M_AXI_rdata',    dir='in',  width=32)
        inst.add_port('M04_AXI_0_rready',  'M_AXI_rready',   dir='out', width=1)
        inst.add_port('M04_AXI_0_rresp',   'M_AXI_rresp',    dir='in',  width=2)
        inst.add_port('M04_AXI_0_rvalid',  'M_AXI_rvalid',   dir='in',  width=1)
        inst.add_port('M04_AXI_0_wdata',   'M_AXI_wdata',    dir='out', width=32)
        inst.add_port('M04_AXI_0_wready',  'M_AXI_wready',   dir='in',  width=1)
        inst.add_port('M04_AXI_0_wstrb',   'M_AXI_wstrb',    dir='out', width=4)
        inst.add_port('M04_AXI_0_wvalid',  'M_AXI_wvalid',   dir='out', width=1)

        # 100gbe RX interface
        inst.add_port('M_AXIS_0_tdata',  'M_AXIS_0_tdata',  dir='out', width=512)
        inst.add_port('M_AXIS_0_tkeep',  'M_AXIS_0_tkeep',  dir='out', width=64)
        inst.add_port('M_AXIS_0_tuser',  'M_AXIS_0_tuser',  dir='out', width=32)
        #inst.add_port('M_AXIS_0_tid',    'M_AXIS_0_tid',    dir='out', width=8)
        inst.add_port('M_AXIS_0_tlast',  'M_AXIS_0_tlast',  dir='out', width=1)
        inst.add_port('M_AXIS_0_tready', 'M_AXIS_0_tready', dir='in',  width=1)
        inst.add_port('M_AXIS_0_tvalid', 'M_AXIS_0_tvalid', dir='out', width=1)

        # 100gbe TX interface
        inst.add_port('S_AXIS_0_tdata',  'S_AXIS_0_tdata',  dir='out', width=512)
        inst.add_port('S_AXIS_0_tkeep',  'S_AXIS_0_tkeep',  dir='out', width=64)
        inst.add_port('S_AXIS_0_tuser',  'S_AXIS_0_tuser',  dir='out', width=32)
        #inst.add_port('S_AXIS_0_tid',    'S_AXIS_0_tid',    dir='out', width=8)
        inst.add_port('S_AXIS_0_tlast',  'S_AXIS_0_tlast',  dir='out', width=1)
        inst.add_port('S_AXIS_0_tready', 'S_AXIS_0_tready', dir='out', width=1)
        inst.add_port('S_AXIS_0_tid',    'S_AXIS_0_tid',    dir='out', width=8)
        inst.add_port('S_AXIS_0_tvalid', 'S_AXIS_0_tvalid', dir='in',  width=1)

        top.assign_signal('user_rst', '!sys_rst_n')
        top.assign_signal('axil_rst', '!axil_rst_n')
        top.assign_signal('user_rst', '!sys_rst_n')
        

    def gen_children(self):
        return [YellowBlock.make_block({'fullpath': self.fullpath, 'tag': 'xps:sys_block', 'board_id': '4', 'rev_maj': '1', 'rev_min': '0', 'rev_rcs': '1','scratchpad': '0'}, self.platform)]
        # return [YellowBlock.make_block({'tag': 'xps:sys_block', 'board_id': '3', 'rev_maj': '2', 'rev_min': '0', 'rev_rcs': '1'}, self.platform),
        #         YellowBlock.make_block({'tag': 'xps:AXI4LiteInterconnect', 'name': 'AXI4LiteInterconnect'}, self.platform)]

    def gen_constraints(self):
        cons = []

        #cons.append(PortConstraint('FIXED_IO_ddr_vrp', 'FIXED_IO_ddr_vrp'))
        #cons.append(ClockConstraint('ADC_CLK_IN_P','ADC_CLK_IN_P', period=8.0, port_en=True, virtual_en=False, waveform_min=0.0, waveform_max=4.0))
        #cons.append(ClockGroupConstraint('-of_objects [get_pins au50_inst/processing_system7_0/inst/PS7_i/FCLKCLK[0]]', '-of_objects [get_pins au50_infr_inst/dsp_clk_mmcm_inst/CLKOUT0]', 'asynchronous'))

        return cons

    def gen_tcl_cmds(self):
        tcl_cmds = {}
        tcl_cmds['pre_synth'] = []
        tcl_cmds['pre_impl'] = []
        """
        Add a block design to project with wrapper via its exported tcl script.
        1. Source the tcl script.
        2. Generate the block design via generate_target.
        3. Have vivado make an HDL wrapper around the block design.
        4. Add the wrapper HDL file to project.
        """

        # import the xdc files associated with the au50 block diagram, pin outs and bit stream generation
        tcl_cmds['pre_synth'] += ['import_files -force -fileset constrs_1 %s/au50_infr/au50_bd.xdc'%os.getenv('HDL_ROOT')]
        tcl_cmds['pre_synth'] += ['import_files -force -fileset constrs_1 %s/au50_infr/au50_bitstream.xdc'%os.getenv('HDL_ROOT')]
        tcl_cmds['pre_synth'] += ['import_files -force -fileset constrs_1 %s/au50_infr/au50_const.xdc'%os.getenv('HDL_ROOT')]

        # add the dsp_send IP to the IP catalog
        # add the udp core user IP to the IP catalog
        tcl_cmds['pre_synth'] += ['set repos [get_property ip_repo_paths [current_project]]']
        tcl_cmds['pre_synth'] += ['set_property ip_repo_paths "$repos %s/dsp_send/" [current_project]'%os.getenv('HDL_ROOT')]
        tcl_cmds['pre_synth'] += ['set repos [get_property ip_repo_paths [current_project]]']
        tcl_cmds['pre_synth'] += ['set_property ip_repo_paths "$repos %s/serial_pipe/" [current_project]'%os.getenv('HDL_ROOT')]
        tcl_cmds['pre_synth'] += ['set repos [get_property ip_repo_paths [current_project]]']
        tcl_cmds['pre_synth'] += ['set_property ip_repo_paths "$repos %s/alveo_onehundred_gbe/" [current_project]'%os.getenv('HDL_ROOT')]
        tcl_cmds['pre_synth'] += ['update_ip_catalog']

        tcl_cmds['pre_synth'] += ['import_files -force -norecurse %s/alveo_onehundred_gbe/src/common_stfc_lib/'%os.getenv('HDL_ROOT')]
        #tcl_cmds['pre_synth'] += ['set_property library common_stfc_lib [get_files  %s/alveo_onehundred_gbe/src/common_stfc_lib/]'%os.getenv('HDL_ROOT')]
        tcl_cmds['pre_synth'] += ['set_property library common_mem_lib [get_files [get_property directory [current_project]]/myproj.srcs/sources_1/imports/src/common_mem_lib/*.vhd]']
        tcl_cmds['pre_synth'] += ['set_property library common_ox_lib [get_files [get_property directory [current_project]]/myproj.srcs/sources_1/imports/src/common_ox_lib/*.vhd]']
        tcl_cmds['pre_synth'] += ['set_property library common_stfc_lib [get_files [get_property directory [current_project]]/myproj.srcs/sources_1/imports/src/common_stfc_lib/*.vhd]']
        tcl_cmds['pre_synth'] += ['set_property library axi4_lite [get_files [get_property directory [current_project]]/myproj.srcs/sources_1/imports/axi4_lite/*.vhd]']


        # run the block diagram generation script
        tcl_cmds['pre_synth'] += ['source {}'.format(self.hdl_root + '/au50_infr/au50_bd.tcl')]

        # the follow commands open up the block diagram, set the clk_wiz to the user specified clock, then save and close the block diagram
        # this is a new mechanism, previously this was accomplished by a python script working out the multiply/divide factors and passing
        # them as parameters to a verilog generated MMCM. Now it is all handled in the block diagram without the need to calculate these
        # factors
        # there wasn't a way to parameterize this in the initial block diagram script, so we have to do it this way, blah!!
        tcl_cmds['pre_synth'] += ['open_bd_design [get_files [get_property directory [current_project]]/myproj.srcs/sources_1/bd/au50_bd/au50_bd.bd]']
        tcl_cmds['pre_synth'] += ['set_property -dict [list CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {%s} CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {%s} CONFIG.CLKOUT3_REQUESTED_OUT_FREQ {%s} CONFIG.CLKOUT4_REQUESTED_OUT_FREQ {%s} CONFIG.CLKOUT5_REQUESTED_OUT_FREQ {%s} CONFIG.CLKOUT6_REQUESTED_OUT_FREQ {%s}] [get_bd_cells clk_wiz_0]'%(self.platform.user_clk_rate, self.platform.user_clk_rate, self.platform.user_clk_rate,self.platform.user_clk_rate, self.platform.user_clk_rate, self.platform.user_clk_rate)]
        # because the HBM also relies on this sys_clk, we need to configure the clock frequency it expects as well.
        tcl_cmds['pre_synth'] += ['set_property -dict [list CONFIG.USER_AXI_INPUT_CLK_FREQ {%s} CONFIG.USER_AXI_INPUT_CLK1_FREQ {%s}] [get_bd_cells hbm/hbm_0]'%(self.platform.user_clk_rate,self.platform.user_clk_rate)]
        #tcl_cmds['pre_synth'] += ['save_bd_design']
        #tcl_cmds['pre_synth'] += ['close_bd_design [get_bd_designs au50_bd]']

        # generate the output files associated with the block diagram
        tcl_cmds['pre_synth'] += ['generate_target all [get_files [get_property directory [current_project]]/myproj.srcs/sources_1/bd/au50_bd/au50_bd.bd]']
        #tcl_cmds['pre_synth'] += ['make_wrapper -files [get_files [get_property directory [current_project]]/myproj.srcs/sources_1/bd/au50_bd/au50_bd.bd] -top']
        tcl_cmds['pre_synth'] += ['update_compile_order -fileset sources_1']

        tcl_cmds['pre_impl'] += ['create_clock -period 6.206 [get_ports gt_ref_clk_0_clk_p]']
        tcl_cmds['pre_impl'] += ['set_property PACKAGE_PIN N37 [get_ports gt_ref_clk_0_clk_n]']
        tcl_cmds['pre_impl'] += ['set_property PACKAGE_PIN N36 [get_ports gt_ref_clk_0_clk_p]']

        tcl_cmds['pre_impl'] += ['create_clock -period 10.000 [get_ports pcie_refclk_clk_p]']
        tcl_cmds['pre_impl'] += ['create_clock -period 10.000 [get_ports cmc_clk_clk_p]']

        tcl_cmds['pre_impl'] += ['set_property LOC GTYE4_CHANNEL_X0Y28 [get_cells {au50_bd_inst/hgbe/cmac_usplus_0/inst/au50_bd_cmac_usplus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.au50_bd_cmac_usplus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST}]']
        tcl_cmds['pre_impl'] += ['set_property PACKAGE_PIN J45 [get_ports {gt_serial_port_0_grx_p[0]}]']
        tcl_cmds['pre_impl'] += ['set_property PACKAGE_PIN J46 [get_ports {gt_serial_port_0_grx_n[0]}]']
        tcl_cmds['pre_impl'] += ['set_property PACKAGE_PIN D42 [get_ports {gt_serial_port_0_gtx_p[0]}]']
        tcl_cmds['pre_impl'] += ['set_property PACKAGE_PIN D43 [get_ports {gt_serial_port_0_gtx_n[0]}]']

        tcl_cmds['pre_impl'] += ['set_property LOC GTYE4_CHANNEL_X0Y29 [get_cells {au50_bd_inst/hgbe/cmac_usplus_0/inst/au50_bd_cmac_usplus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.au50_bd_cmac_usplus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[1].GTYE4_CHANNEL_PRIM_INST}]']
        tcl_cmds['pre_impl'] += ['set_property PACKAGE_PIN G45 [get_ports {gt_serial_port_0_grx_p[1]}]']
        tcl_cmds['pre_impl'] += ['set_property PACKAGE_PIN G46 [get_ports {gt_serial_port_0_grx_n[1]}]']
        tcl_cmds['pre_impl'] += ['set_property PACKAGE_PIN C40 [get_ports {gt_serial_port_0_gtx_p[1]}]']
        tcl_cmds['pre_impl'] += ['set_property PACKAGE_PIN C41 [get_ports {gt_serial_port_0_gtx_n[1]}]']

        tcl_cmds['pre_impl'] += ['set_property LOC GTYE4_CHANNEL_X0Y30 [get_cells {au50_bd_inst/hgbe/cmac_usplus_0/inst/au50_bd_cmac_usplus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.au50_bd_cmac_usplus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[2].GTYE4_CHANNEL_PRIM_INST}]']
        tcl_cmds['pre_impl'] += ['set_property PACKAGE_PIN F43 [get_ports {gt_serial_port_0_grx_p[2]}]']
        tcl_cmds['pre_impl'] += ['set_property PACKAGE_PIN F44 [get_ports {gt_serial_port_0_grx_n[2]}]']
        tcl_cmds['pre_impl'] += ['set_property PACKAGE_PIN B42 [get_ports {gt_serial_port_0_gtx_p[2]}]']
        tcl_cmds['pre_impl'] += ['set_property PACKAGE_PIN B43 [get_ports {gt_serial_port_0_gtx_n[2]}]']

        tcl_cmds['pre_impl'] += ['set_property LOC GTYE4_CHANNEL_X0Y31 [get_cells {au50_bd_inst/hgbe/cmac_usplus_0/inst/au50_bd_cmac_usplus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.au50_bd_cmac_usplus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[3].GTYE4_CHANNEL_PRIM_INST}]']
        tcl_cmds['pre_impl'] += ['set_property PACKAGE_PIN E45 [get_ports {gt_serial_port_0_grx_p[3]}]']
        tcl_cmds['pre_impl'] += ['set_property PACKAGE_PIN E46 [get_ports {gt_serial_port_0_grx_n[3]}]']
        tcl_cmds['pre_impl'] += ['set_property PACKAGE_PIN A40 [get_ports {gt_serial_port_0_gtx_p[3]}]']
        tcl_cmds['pre_impl'] += ['set_property PACKAGE_PIN A41 [get_ports {gt_serial_port_0_gtx_n[3]}]']

        tcl_cmds['pre_impl'] += ['set_property PACKAGE_PIN BB26 [get_ports satellite_uart_0_rxd]']
        tcl_cmds['pre_impl'] += ['set_property -dict {IOSTANDARD LVCMOS18} [get_ports satellite_uart_0_rxd]']
        tcl_cmds['pre_impl'] += ['set_property PACKAGE_PIN BB25 [get_ports satellite_uart_0_txd]']
        tcl_cmds['pre_impl'] += ['set_property -dict {IOSTANDARD LVCMOS18 DRIVE 4} [get_ports satellite_uart_0_txd]']

        tcl_cmds['pre_impl'] += ['set_property PACKAGE_PIN J18 [get_ports hbm_cattrip_tri_o]']
        tcl_cmds['pre_impl'] += ['set_property -dict {IOSTANDARD LVCMOS18 DRIVE 4} [get_ports hbm_cattrip_tri_o]']

        tcl_cmds['pre_impl'] += ['set_property PACKAGE_PIN AW27 [get_ports pcie_perstn]']
        tcl_cmds['pre_impl'] += ['set_property -dict {IOSTANDARD LVCMOS18} [get_ports pcie_perstn]']

        tcl_cmds['pre_impl'] += ['set_property PACKAGE_PIN AF8 [get_ports pcie_refclk_clk_n]']
        tcl_cmds['pre_impl'] += ['set_property PACKAGE_PIN AF9 [get_ports pcie_refclk_clk_p]']

        tcl_cmds['pre_impl'] += ['set_property IOSTANDARD LVDS [get_ports cmc_clk_clk_n]']
        tcl_cmds['pre_impl'] += ['set_property PACKAGE_PIN G17 [get_ports cmc_clk_clk_p]']
        tcl_cmds['pre_impl'] += ['set_property PACKAGE_PIN G16 [get_ports cmc_clk_clk_n]']
        tcl_cmds['pre_impl'] += ['set_property IOSTANDARD LVDS [get_ports cmc_clk_clk_p]']
        tcl_cmds['pre_impl'] += ['set_property DQS_BIAS TRUE [get_ports cmc_clk_clk_p]']

        tcl_cmds['pre_impl'] += ['set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins au50_bd_inst/clk_wiz_0/inst/mmcme4_adv_inst/CLKOUT0]] -group [get_clocks -of_objects [get_pins {au50_bd_inst/hgbe/cmac_usplus_0/inst/au50_bd_cmac_usplus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.au50_bd_cmac_usplus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLK}]] -group [get_clocks -of_objects [get_pins au50_bd_inst/xdma_0/inst/pcie4c_ip_i/inst/au50_bd_xdma_0_0_pcie4c_ip_gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_clk_i/bufg_gt_userclk/O]] -group [get_clocks -of_objects [get_pins au50_bd_inst/xdma_0/inst/pcie4c_ip_i/inst/au50_bd_xdma_0_0_pcie4c_ip_gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_clk_i/bufg_gt_userclk/O]] -group [get_clocks -of_objects [get_pins {au50_bd_inst/hgbe/cmac_usplus_0/inst/au50_bd_cmac_usplus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.au50_bd_cmac_usplus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLKPCS}]] -group [get_clocks -of_objects [get_pins {au50_bd_inst/hgbe/cmac_usplus_0/inst/au50_bd_cmac_usplus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.au50_bd_cmac_usplus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[1].GTYE4_CHANNEL_PRIM_INST/TXOUTCLKPCS}]] -group [get_clocks -of_objects [get_pins {au50_bd_inst/hgbe/cmac_usplus_0/inst/au50_bd_cmac_usplus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.au50_bd_cmac_usplus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[2].GTYE4_CHANNEL_PRIM_INST/TXOUTCLKPCS}]] -group [get_clocks -of_objects [get_pins {au50_bd_inst/hgbe/cmac_usplus_0/inst/au50_bd_cmac_usplus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.au50_bd_cmac_usplus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[3].GTYE4_CHANNEL_PRIM_INST/TXOUTCLKPCS}]] -group [get_clocks -of_objects [get_pins {au50_bd_inst/hgbe/cmac_usplus_0/inst/au50_bd_cmac_usplus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.au50_bd_cmac_usplus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLK}]] -group [get_clocks -of_objects [get_pins {au50_bd_inst/hgbe/cmac_usplus_0/inst/au50_bd_cmac_usplus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.au50_bd_cmac_usplus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/RXOUTCLK}]]']

        tcl_cmds['pre_impl'] += ['set_false_path -from [get_ports pcie_perstn]']
        tcl_cmds['pre_impl'] += ['set_false_path -from [get_ports pcie_perstn]']
        tcl_cmds['pre_impl'] += ['set_false_path -from [get_ports satellite_uart_0_rxd]']
        tcl_cmds['pre_impl'] += ['set_false_path -from [get_ports satellite_uart_0_rxd]']

        tcl_cmds['pre_impl'] += ['set_false_path -to [get_ports hbm_cattrip_tri_o]']
        tcl_cmds['pre_impl'] += ['set_false_path -to [get_ports hbm_cattrip_tri_o]']
        tcl_cmds['pre_impl'] += ['set_false_path -to [get_ports satellite_uart_0_txd]']
        tcl_cmds['pre_impl'] += ['set_false_path -to [get_ports satellite_uart_0_txd]']

        tcl_cmds['pre_impl'] += ['set_operating_conditions -design_power_budget 63.0']

        # it is probably better to add this to constraints files. We will come back to this as there will be more similar constraints ;)
        # we will just need to add these to an xdc file that runs post synth.
        tcl_cmds['pre_impl'] += ['set_clock_groups -asynchronous -group [get_clocks axi_bram_ctrl_lmb_BRAM_PORTA_CLK] -group [get_clocks clk_out1_au50_bd_clk_wiz_0_0]']
        tcl_cmds['pre_impl'] += ['set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins au50_bd_inst/clk_wiz_0/inst/mmcme4_adv_inst/CLKOUT0]] -group [get_clocks -of_objects [get_pins {au50_bd_inst/hgbe/cmac_usplus_0/inst/au50_bd_cmac_usplus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.au50_bd_cmac_usplus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLK}]] -group [get_clocks -of_objects [get_pins au50_bd_inst/xdma_0/inst/pcie4c_ip_i/inst/au50_bd_xdma_0_0_pcie4c_ip_gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_clk_i/bufg_gt_userclk/O]] -group [get_clocks -of_objects [get_pins au50_bd_inst/xdma_0/inst/pcie4c_ip_i/inst/au50_bd_xdma_0_0_pcie4c_ip_gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_clk_i/bufg_gt_userclk/O]] -group [get_clocks -of_objects [get_pins {au50_bd_inst/hgbe/cmac_usplus_0/inst/au50_bd_cmac_usplus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.au50_bd_cmac_usplus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLKPCS}]] -group [get_clocks -of_objects [get_pins {au50_bd_inst/hgbe/cmac_usplus_0/inst/au50_bd_cmac_usplus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.au50_bd_cmac_usplus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[1].GTYE4_CHANNEL_PRIM_INST/TXOUTCLKPCS}]] -group [get_clocks -of_objects [get_pins {au50_bd_inst/hgbe/cmac_usplus_0/inst/au50_bd_cmac_usplus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.au50_bd_cmac_usplus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[2].GTYE4_CHANNEL_PRIM_INST/TXOUTCLKPCS}]] -group [get_clocks -of_objects [get_pins {au50_bd_inst/hgbe/cmac_usplus_0/inst/au50_bd_cmac_usplus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.au50_bd_cmac_usplus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[3].GTYE4_CHANNEL_PRIM_INST/TXOUTCLKPCS}]] -group [get_clocks -of_objects [get_pins {au50_bd_inst/hgbe/cmac_usplus_0/inst/au50_bd_cmac_usplus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.au50_bd_cmac_usplus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLK}]] -group [get_clocks -of_objects [get_pins {au50_bd_inst/hgbe/cmac_usplus_0/inst/au50_bd_cmac_usplus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.au50_bd_cmac_usplus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/RXOUTCLK}]]']
        tcl_cmds['pre_impl'] += ['set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins au50_bd_inst/clk_wiz_0/inst/mmcme4_adv_inst/CLKOUT0]] -group [get_clocks -of_objects [get_pins {au50_bd_inst/hgbe/cmac_usplus_0/inst/au50_bd_cmac_usplus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.au50_bd_cmac_usplus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLK}]] -group [get_clocks -of_objects [get_pins au50_bd_inst/xdma_0/inst/pcie4c_ip_i/inst/au50_bd_xdma_0_0_pcie4c_ip_gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_clk_i/bufg_gt_userclk/O]] -group [get_clocks -of_objects [get_pins au50_bd_inst/xdma_0/inst/pcie4c_ip_i/inst/au50_bd_xdma_0_0_pcie4c_ip_gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_clk_i/bufg_gt_userclk/O]] -group [get_clocks -of_objects [get_pins {au50_bd_inst/hgbe/cmac_usplus_0/inst/au50_bd_cmac_usplus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.au50_bd_cmac_usplus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLKPCS}]] -group [get_clocks -of_objects [get_pins {au50_bd_inst/hgbe/cmac_usplus_0/inst/au50_bd_cmac_usplus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.au50_bd_cmac_usplus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[1].GTYE4_CHANNEL_PRIM_INST/TXOUTCLKPCS}]] -group [get_clocks -of_objects [get_pins {au50_bd_inst/hgbe/cmac_usplus_0/inst/au50_bd_cmac_usplus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.au50_bd_cmac_usplus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[2].GTYE4_CHANNEL_PRIM_INST/TXOUTCLKPCS}]] -group [get_clocks -of_objects [get_pins {au50_bd_inst/hgbe/cmac_usplus_0/inst/au50_bd_cmac_usplus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.au50_bd_cmac_usplus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[3].GTYE4_CHANNEL_PRIM_INST/TXOUTCLKPCS}]] -group [get_clocks -of_objects [get_pins {au50_bd_inst/hgbe/cmac_usplus_0/inst/au50_bd_cmac_usplus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.au50_bd_cmac_usplus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLK}]] -group [get_clocks -of_objects [get_pins {au50_bd_inst/hgbe/cmac_usplus_0/inst/au50_bd_cmac_usplus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.au50_bd_cmac_usplus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/RXOUTCLK}]]']
        tcl_cmds['pre_impl'] += ['set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins au50_bd_inst/hbm/clk_wiz_1/inst/mmcme4_adv_inst/CLKOUT0]] -group [get_clocks -of_objects [get_pins {au50_bd_inst/hgbe/cmac_usplus_0/inst/au50_bd_cmac_usplus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.au50_bd_cmac_usplus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLK}]] -group [get_clocks -of_objects [get_pins au50_bd_inst/xdma_0/inst/pcie4c_ip_i/inst/au50_bd_xdma_0_0_pcie4c_ip_gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_clk_i/bufg_gt_userclk/O]] -group [get_clocks -of_objects [get_pins au50_bd_inst/xdma_0/inst/pcie4c_ip_i/inst/au50_bd_xdma_0_0_pcie4c_ip_gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_clk_i/bufg_gt_userclk/O]] -group [get_clocks -of_objects [get_pins {au50_bd_inst/hgbe/cmac_usplus_0/inst/au50_bd_cmac_usplus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.au50_bd_cmac_usplus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLKPCS}]] -group [get_clocks -of_objects [get_pins {au50_bd_inst/hgbe/cmac_usplus_0/inst/au50_bd_cmac_usplus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.au50_bd_cmac_usplus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[1].GTYE4_CHANNEL_PRIM_INST/TXOUTCLKPCS}]] -group [get_clocks -of_objects [get_pins {au50_bd_inst/hgbe/cmac_usplus_0/inst/au50_bd_cmac_usplus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.au50_bd_cmac_usplus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[2].GTYE4_CHANNEL_PRIM_INST/TXOUTCLKPCS}]] -group [get_clocks -of_objects [get_pins {au50_bd_inst/hgbe/cmac_usplus_0/inst/au50_bd_cmac_usplus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.au50_bd_cmac_usplus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[3].GTYE4_CHANNEL_PRIM_INST/TXOUTCLKPCS}]] -group [get_clocks -of_objects [get_pins {au50_bd_inst/hgbe/cmac_usplus_0/inst/au50_bd_cmac_usplus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.au50_bd_cmac_usplus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLK}]] -group [get_clocks -of_objects [get_pins {au50_bd_inst/hgbe/cmac_usplus_0/inst/au50_bd_cmac_usplus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.au50_bd_cmac_usplus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/RXOUTCLK}]]']
        tcl_cmds['pre_impl'] += ['set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins au50_bd_inst/hbm/clk_wiz_1/inst/mmcme4_adv_inst/CLKOUT0]] -group [get_clocks -of_objects [get_pins {au50_bd_inst/hgbe/cmac_usplus_0/inst/au50_bd_cmac_usplus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.au50_bd_cmac_usplus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLK}]] -group [get_clocks -of_objects [get_pins au50_bd_inst/xdma_0/inst/pcie4c_ip_i/inst/au50_bd_xdma_0_0_pcie4c_ip_gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_clk_i/bufg_gt_userclk/O]] -group [get_clocks -of_objects [get_pins au50_bd_inst/xdma_0/inst/pcie4c_ip_i/inst/au50_bd_xdma_0_0_pcie4c_ip_gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_clk_i/bufg_gt_userclk/O]] -group [get_clocks -of_objects [get_pins {au50_bd_inst/hgbe/cmac_usplus_0/inst/au50_bd_cmac_usplus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.au50_bd_cmac_usplus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLKPCS}]] -group [get_clocks -of_objects [get_pins {au50_bd_inst/hgbe/cmac_usplus_0/inst/au50_bd_cmac_usplus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.au50_bd_cmac_usplus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[1].GTYE4_CHANNEL_PRIM_INST/TXOUTCLKPCS}]] -group [get_clocks -of_objects [get_pins {au50_bd_inst/hgbe/cmac_usplus_0/inst/au50_bd_cmac_usplus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.au50_bd_cmac_usplus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[2].GTYE4_CHANNEL_PRIM_INST/TXOUTCLKPCS}]] -group [get_clocks -of_objects [get_pins {au50_bd_inst/hgbe/cmac_usplus_0/inst/au50_bd_cmac_usplus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.au50_bd_cmac_usplus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[3].GTYE4_CHANNEL_PRIM_INST/TXOUTCLKPCS}]] -group [get_clocks -of_objects [get_pins {au50_bd_inst/hgbe/cmac_usplus_0/inst/au50_bd_cmac_usplus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.au50_bd_cmac_usplus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLK}]] -group [get_clocks -of_objects [get_pins {au50_bd_inst/hgbe/cmac_usplus_0/inst/au50_bd_cmac_usplus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.au50_bd_cmac_usplus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/RXOUTCLK}]]']

        return tcl_cmds
