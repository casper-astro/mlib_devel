from .yellow_block import YellowBlock
from clk_factors import clk_factors
from constraints import ClockConstraint, ClockGroupConstraint, PortConstraint, RawConstraint


class au50(YellowBlock):
    def initialize(self):
        self.add_source('infrastructure/au50.v')
        self.add_source('au50')
        self.provides = [
            "sys_clk",
        ]

    def modify_top(self,top):
        inst = top.get_instance('au50_bd', 'au50_bd_inst')
	
        inst.add_port('s_axi_aclk',   's_axi_aclk')
        inst.add_port('s_axi_areset', 's_axi_areset')
        inst.add_port('axil_rst_n', 'axil_rst_n')
        inst.add_port('hbm_cattrip_tri_o', 'hbm_cattrip_tri_o', dir='out', parent_port=True)
        inst.add_port('hbm_clk_clk_n', 'hbm_clk_clk_n', dir='in', parent_port=True)
        inst.add_port('hbm_clk_clk_p', 'hbm_clk_clk_p', dir='in', parent_port=True)
        inst.add_port('pci_express_x1_rxn', 'pci_express_x1_rxn', dir='in', parent_port=True)
        inst.add_port('pci_express_x1_rxp', 'pci_express_x1_rxp', dir='in', parent_port=True)
        inst.add_port('pci_express_x1_txn', 'pci_express_x1_txn', dir='out', parent_port=True)
        inst.add_port('pci_express_x1_txp', 'pci_express_x1_txp', dir='out', parent_port=True)
        inst.add_port('pcie_perstn', 'pcie_perstn', dir='in', parent_port=True)
        inst.add_port('pcie_refclk_clk_n', 'pcie_refclk_clk_n', dir='in', parent_port=True)
        inst.add_port('pcie_refclk_clk_p', 'pcie_refclk_clk_p', dir='in', parent_port=True)
        inst.add_port('satellite_gpio_0', 'satellite_gpio_0', dir='in', parent_port=True, width=2)
        inst.add_port('satellite_uart_0_rxd', 'satellite_uart_0_rxd', dir='in', parent_port=True)
        inst.add_port('satellite_uart_0_txd', 'satellite_uart_0_txd', dir='out', parent_port=True)
        
        inst.add_port('M04_AXI_0_araddr',  'M04_AXI_0_araddr',   dir='out', width=32)
        inst.add_port('M04_AXI_0_arburst', 'M04_AXI_0_arburst',  dir='out', width=2)
        inst.add_port('M04_AXI_0_arcache', 'M04_AXI_0_arcache',  dir='out', width=4)
        inst.add_port('M04_AXI_0_arlen',   'M04_AXI_0_arlen',    dir='out', width=8)
        inst.add_port('M04_AXI_0_arlock',  'M04_AXI_0_arlock',   dir='out', width=1)
        inst.add_port('M04_AXI_0_arprot',  'M04_AXI_0_arprot',   dir='out', width=3)
        inst.add_port('M04_AXI_0_arqos',   'M04_AXI_0_arqos',    dir='out', width=4)
        inst.add_port('M04_AXI_0_arready', 'M04_AXI_0_arready',  dir='out', width=1)
        inst.add_port('M04_AXI_0_arregion','M04_AXI_0_arregion', dir='out', width=4)
        inst.add_port('M04_AXI_0_arsize',  'M04_AXI_0_arsize',   dir='out', width=3)
        inst.add_port('M04_AXI_0_arvalid', 'M04_AXI_0_arvalid',  dir='out', width=1)
        inst.add_port('M04_AXI_0_awaddr',  'M04_AXI_0_awaddr',   dir='out', width=32)
        inst.add_port('M04_AXI_0_awburst', 'M04_AXI_0_awburst',  dir='out', width=2)
        inst.add_port('M04_AXI_0_awcache', 'M04_AXI_0_awcache',  dir='out', width=4)
        inst.add_port('M04_AXI_0_awlen',   'M04_AXI_0_awlen',    dir='out', width=8)
        inst.add_port('M04_AXI_0_awlock',  'M04_AXI_0_awlock',   dir='out', width=1)
        inst.add_port('M04_AXI_0_awprot',  'M04_AXI_0_awprot',   dir='out', width=3)
        inst.add_port('M04_AXI_0_awqos',   'M04_AXI_0_awqos',    dir='out', width=4)
        inst.add_port('M04_AXI_0_awready', 'M04_AXI_0_awready',  dir='in',  width=1)
        inst.add_port('M04_AXI_0_awregion','M04_AXI_0_awregion', dir='out', width=4)
        inst.add_port('M04_AXI_0_awsize',  'M04_AXI_0_awsize',   dir='out', width=3)
        inst.add_port('M04_AXI_0_awvalid', 'M04_AXI_0_awvalid',  dir='out', width=1)
        inst.add_port('M04_AXI_0_bready',  'M04_AXI_0_bready',   dir='out', width=1)
        inst.add_port('M04_AXI_0_bresp',   'M04_AXI_0_bresp',    dir='in',  width=2)
        inst.add_port('M04_AXI_0_bvalid',  'M04_AXI_0_bvalid',   dir='in',  width=1)
        inst.add_port('M04_AXI_0_rdata',   'M04_AXI_0_rdata',    dir='in',  width=32)
        inst.add_port('M04_AXI_0_rlast',   'M04_AXI_0_rlast',    dir='in',  width=1)
        inst.add_port('M04_AXI_0_rready',  'M04_AXI_0_rready',   dir='out', width=1)
        inst.add_port('M04_AXI_0_rresp',   'M04_AXI_0_rresp',    dir='in',  width=2)
        inst.add_port('M04_AXI_0_rvalid',  'M04_AXI_0_rvalid',   dir='in',  width=1)
        inst.add_port('M04_AXI_0_wdata',   'M04_AXI_0_wdata',    dir='out', width=32)
        inst.add_port('M04_AXI_0_wlast',   'M04_AXI_0_wlast',    dir='out', width=1)
        inst.add_port('M04_AXI_0_wready',  'M04_AXI_0_wready',   dir='in',  width=1)
        inst.add_port('M04_AXI_0_wstrb',   'M04_AXI_0_wstrb',    dir='out', width=4)
        inst.add_port('M04_AXI_0_wvalid',  'M04_AXI_0_wvalid',   dir='out', width=1)
        

    def gen_children(self):
        return [YellowBlock.make_block({'fullpath': self.fullpath, 'tag': 'xps:sys_block', 'board_id': '4', 'rev_maj': '1', 'rev_min': '0', 'rev_rcs': '1','scratchpad': '0'}, self.platform)]
        # return [YellowBlock.make_block({'tag': 'xps:sys_block', 'board_id': '3', 'rev_maj': '2', 'rev_min': '0', 'rev_rcs': '1'}, self.platform),
        #         YellowBlock.make_block({'tag': 'xps:AXI4LiteInterconnect', 'name': 'AXI4LiteInterconnect'}, self.platform)]

    def gen_constraints(self):
        cons = []

        cons.append(PortConstraint('FIXED_IO_ddr_vrp', 'FIXED_IO_ddr_vrp'))
        cons.append(ClockConstraint('ADC_CLK_IN_P','ADC_CLK_IN_P', period=8.0, port_en=True, virtual_en=False, waveform_min=0.0, waveform_max=4.0))
        cons.append(ClockGroupConstraint('-of_objects [get_pins au50_inst/processing_system7_0/inst/PS7_i/FCLKCLK[0]]', '-of_objects [get_pins au50_infr_inst/dsp_clk_mmcm_inst/CLKOUT0]', 'asynchronous'))

        return cons

    def gen_tcl_cmds(self):
        tcl_cmds = {}
        tcl_cmds['pre_synth'] = []
        """
        Add a block design to project with wrapper via its exported tcl script.
        1. Source the tcl script.
        2. Generate the block design via generate_target.
        3. Have vivado make an HDL wrapper around the block design.
        4. Add the wrapper HDL file to project.
        """
        tcl_cmds['pre_synth'] += ['source {}'.format(self.hdl_root + '/au50_infr/au50.tcl')]
        tcl_cmds['pre_synth'] += ['generate_target all [get_files [get_property directory [current_project]]/myproj.srcs/sources_1/bd/bd/bd.bd]']        
        tcl_cmds['pre_synth'] += ['make_wrapper -files [get_files [get_property directory [current_project]]/myproj.srcs/sources_1/bd/bd/bd.bd] -top']
        tcl_cmds['pre_synth'] += ['add_files -norecurse [get_property directory [current_project]]/myproj.srcs/sources_1/bd/bd/hdl/bd_wrapper.v']
        tcl_cmds['pre_synth'] += ['update_compile_order -fileset sources_1']
        return tcl_cmds
