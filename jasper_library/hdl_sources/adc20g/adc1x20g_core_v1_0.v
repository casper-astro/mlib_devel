
`timescale 1 ns / 1 ps
	module adc1x20g_core_notge_v1_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface S00_AXI
		parameter integer C_S00_AXI_DATA_WIDTH	= 32,
		parameter integer C_S00_AXI_ADDR_WIDTH	= 4,
		parameter WHICH_ADC = 1
	)
	(
		// Users to add ports here

        input wire Q8_CLK1_GTREFCLK_PAD_N_IN,
        input wire Q8_CLK1_GTREFCLK_PAD_P_IN,
        input wire DRP_CLK_IN,
        input wire [7:0] RXN_IN,
        input wire [7:0] RXP_IN,
        output wire [7:0] TXN_OUT,
        output wire [7:0] TXP_OUT,
        output wire TX_USR_CLK,
        output wire RX_USR_CLK,
        output wire TRACK_DATA_OUT,
        output wire [327:0] dout,
        output FLASH1,
        output FLASH2,
		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface S00_AXI
		input wire  s00_axi_aclk,
		input wire  s00_axi_aresetn,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
		input wire [2 : 0] s00_axi_awprot,
		input wire  s00_axi_awvalid,
		output wire  s00_axi_awready,
		input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
		input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb,
		input wire  s00_axi_wvalid,
		output wire  s00_axi_wready,
		output wire [1 : 0] s00_axi_bresp,
		output wire  s00_axi_bvalid,
		input wire  s00_axi_bready,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
		input wire [2 : 0] s00_axi_arprot,
		input wire  s00_axi_arvalid,
		output wire  s00_axi_arready,
		output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
		output wire [1 : 0] s00_axi_rresp,
		output wire  s00_axi_rvalid,
		input wire  s00_axi_rready
	);
// Instantiation of Axi Bus Interface S00_AXI
	adc1x20g_core_v1_0_S00_AXI # ( 
		.C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH),
		.WHICH_ADC(WHICH_ADC)
	) adc1x20g_core_v1_0_S00_AXI_inst (
		.S_AXI_ACLK(s00_axi_aclk),
		.S_AXI_ARESETN(s00_axi_aresetn),
		.S_AXI_AWADDR(s00_axi_awaddr),
		.S_AXI_AWPROT(s00_axi_awprot),
		.S_AXI_AWVALID(s00_axi_awvalid),
		.S_AXI_AWREADY(s00_axi_awready),
		.S_AXI_WDATA(s00_axi_wdata),
		.S_AXI_WSTRB(s00_axi_wstrb),
		.S_AXI_WVALID(s00_axi_wvalid),
		.S_AXI_WREADY(s00_axi_wready),
		.S_AXI_BRESP(s00_axi_bresp),
		.S_AXI_BVALID(s00_axi_bvalid),
		.S_AXI_BREADY(s00_axi_bready),
		.S_AXI_ARADDR(s00_axi_araddr),
		.S_AXI_ARPROT(s00_axi_arprot),
		.S_AXI_ARVALID(s00_axi_arvalid),
		.S_AXI_ARREADY(s00_axi_arready),
		.S_AXI_RDATA(s00_axi_rdata),
		.S_AXI_RRESP(s00_axi_rresp),
		.S_AXI_RVALID(s00_axi_rvalid),
		.S_AXI_RREADY(s00_axi_rready),
        .Q8_CLK1_GTREFCLK_PAD_N_IN(Q8_CLK1_GTREFCLK_PAD_N_IN),
        .Q8_CLK1_GTREFCLK_PAD_P_IN(Q8_CLK1_GTREFCLK_PAD_P_IN),
        .DRP_CLK_IN(DRP_CLK_IN),
        .RXN_IN(RXN_IN),
        .RXP_IN(RXP_IN),
        .TXN_OUT(TXN_OUT),
        .TXP_OUT(TXP_OUT),
        .TRACK_DATA_OUT(TRACK_DATA_OUT),
        .TX_USR_CLK(TX_USR_CLK),
        .RX_USR_CLK(RX_USR_CLK),
        .dout(dout),
        .FLASH1(FLASH1),
        .FLASH2(FLASH2)

	);

	// Add user logic here

	// User logic ends

	endmodule
