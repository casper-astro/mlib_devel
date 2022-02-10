from .yellow_block import YellowBlock

class axi_wb_bridge(YellowBlock):
    def initialize(self):
        self.add_source('axi_wb_bridge/ip_repo/peralex.com_user_axi_slave_wishbone_classic_master_1.0/axi_slave_wishbone_classic_master.vhd')

    def modify_top(self, top):
        inst = top.get_instance('axi_slave_wishbone_classic_master', 'axi_wb_bridge')

        inst.add_parameter('C_S_AXI_ADDR_WIDTH', 32)

        # These default to zero, giving negative port widths.
        # The ports associated with these parameters aren't
        # used anyway, so set them all to 1
        inst.add_parameter('C_S_AXI_AWUSER_WIDTH', 1)
        inst.add_parameter('C_S_AXI_ARUSER_WIDTH', 1)
        inst.add_parameter('C_S_AXI_WUSER_WIDTH', 1)
        inst.add_parameter('C_S_AXI_RUSER_WIDTH', 1)
        inst.add_parameter('C_S_AXI_BUSER_WIDTH', 1)

        inst.add_port('S_AXI_ACLK',   'axil_clk')
        inst.add_port('S_AXI_ARESETN', 'axil_rst_n')
        inst.add_port('S_AXI_ARADDR', 'M_AXI_araddr', width=32)
        inst.add_port('S_AXI_ARPROT', 'M_AXI_arprot', width=3)
        inst.add_port('S_AXI_ARREADY', 'M_AXI_arready')
        inst.add_port('S_AXI_ARVALID', 'M_AXI_arvalid')
        inst.add_port('S_AXI_AWADDR', 'M_AXI_awaddr', width=32)
        inst.add_port('S_AXI_AWPROT', 'M_AXI_awprot', width=3)
        inst.add_port('S_AXI_AWREADY', 'M_AXI_awready')
        inst.add_port('S_AXI_AWVALID', 'M_AXI_awvalid')
        inst.add_port('S_AXI_BREADY', 'M_AXI_bready')
        inst.add_port('S_AXI_BRESP', 'M_AXI_bresp', width=2)
        inst.add_port('S_AXI_BVALID', 'M_AXI_bvalid')
        inst.add_port('S_AXI_RDATA', 'M_AXI_rdata', width=32)
        inst.add_port('S_AXI_RREADY', 'M_AXI_rready')
        inst.add_port('S_AXI_RRESP', 'M_AXI_rresp', width=2)
        inst.add_port('S_AXI_RVALID', 'M_AXI_rvalid')
        inst.add_port('S_AXI_WDATA', 'M_AXI_wdata', width=32)
        inst.add_port('S_AXI_WREADY', 'M_AXI_wready')
        inst.add_port('S_AXI_WSTRB', 'M_AXI_wstrb', width=4)
        inst.add_port('S_AXI_WVALID', 'M_AXI_wvalid')

        inst.add_port('CYC_O', 'wbm_cyc_o')
        inst.add_port('STB_O', 'wbm_stb_o')
        inst.add_port('WE_O ', 'wbm_we_o ')
        inst.add_port('SEL_O', 'wbm_sel_o', width=4)
        inst.add_port('ADR_O', 'wbm_adr_o', width=32)
        inst.add_port('DAT_O', 'wbm_dat_o', width=32)
        inst.add_port('DAT_I', 'wbm_dat_i', width=32)
        inst.add_port('ACK_I', 'wbm_ack_i')
        inst.add_port('RST_O', 'wbm_rst_o')

        top.add_signal('wb_clk_i')
        top.add_signal('wb_rst_i')
        top.assign_signal('wb_clk_i', 'axil_clk')
        top.assign_signal('wb_rst_i', '~axil_rst_n')
