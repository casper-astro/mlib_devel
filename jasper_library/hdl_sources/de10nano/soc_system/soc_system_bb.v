
module soc_system (
	axi_bridge_0_m0_awaddr,
	axi_bridge_0_m0_awprot,
	axi_bridge_0_m0_awvalid,
	axi_bridge_0_m0_awready,
	axi_bridge_0_m0_wdata,
	axi_bridge_0_m0_wstrb,
	axi_bridge_0_m0_wlast,
	axi_bridge_0_m0_wvalid,
	axi_bridge_0_m0_wready,
	axi_bridge_0_m0_bresp,
	axi_bridge_0_m0_bvalid,
	axi_bridge_0_m0_bready,
	axi_bridge_0_m0_araddr,
	axi_bridge_0_m0_arprot,
	axi_bridge_0_m0_arvalid,
	axi_bridge_0_m0_arready,
	axi_bridge_0_m0_rdata,
	axi_bridge_0_m0_rresp,
	axi_bridge_0_m0_rvalid,
	axi_bridge_0_m0_rready,
	clk_clk,
	memory_mem_a,
	memory_mem_ba,
	memory_mem_ck,
	memory_mem_ck_n,
	memory_mem_cke,
	memory_mem_cs_n,
	memory_mem_ras_n,
	memory_mem_cas_n,
	memory_mem_we_n,
	memory_mem_reset_n,
	memory_mem_dq,
	memory_mem_dqs,
	memory_mem_dqs_n,
	memory_mem_odt,
	memory_mem_dm,
	memory_oct_rzqin);	

	output	[20:0]	axi_bridge_0_m0_awaddr;
	output	[2:0]	axi_bridge_0_m0_awprot;
	output		axi_bridge_0_m0_awvalid;
	input		axi_bridge_0_m0_awready;
	output	[31:0]	axi_bridge_0_m0_wdata;
	output	[3:0]	axi_bridge_0_m0_wstrb;
	output		axi_bridge_0_m0_wlast;
	output		axi_bridge_0_m0_wvalid;
	input		axi_bridge_0_m0_wready;
	input	[1:0]	axi_bridge_0_m0_bresp;
	input		axi_bridge_0_m0_bvalid;
	output		axi_bridge_0_m0_bready;
	output	[20:0]	axi_bridge_0_m0_araddr;
	output	[2:0]	axi_bridge_0_m0_arprot;
	output		axi_bridge_0_m0_arvalid;
	input		axi_bridge_0_m0_arready;
	input	[31:0]	axi_bridge_0_m0_rdata;
	input	[1:0]	axi_bridge_0_m0_rresp;
	input		axi_bridge_0_m0_rvalid;
	output		axi_bridge_0_m0_rready;
	input		clk_clk;
	output	[14:0]	memory_mem_a;
	output	[2:0]	memory_mem_ba;
	output		memory_mem_ck;
	output		memory_mem_ck_n;
	output		memory_mem_cke;
	output		memory_mem_cs_n;
	output		memory_mem_ras_n;
	output		memory_mem_cas_n;
	output		memory_mem_we_n;
	output		memory_mem_reset_n;
	inout	[31:0]	memory_mem_dq;
	inout	[3:0]	memory_mem_dqs;
	inout	[3:0]	memory_mem_dqs_n;
	output		memory_mem_odt;
	output	[3:0]	memory_mem_dm;
	input		memory_oct_rzqin;
endmodule
