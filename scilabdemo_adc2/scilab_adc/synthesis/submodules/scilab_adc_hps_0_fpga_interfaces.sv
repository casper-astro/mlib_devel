// (C) 2001-2025 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


module scilab_adc_hps_0_fpga_interfaces(
// h2f_reset
  output wire [1 - 1 : 0 ] h2f_rst_n
// h2f_lw_axi_clock
 ,input wire [1 - 1 : 0 ] h2f_lw_axi_clk
// h2f_lw_axi_master
 ,output wire [12 - 1 : 0 ] h2f_lw_AWID
 ,output wire [21 - 1 : 0 ] h2f_lw_AWADDR
 ,output wire [4 - 1 : 0 ] h2f_lw_AWLEN
 ,output wire [3 - 1 : 0 ] h2f_lw_AWSIZE
 ,output wire [2 - 1 : 0 ] h2f_lw_AWBURST
 ,output wire [2 - 1 : 0 ] h2f_lw_AWLOCK
 ,output wire [4 - 1 : 0 ] h2f_lw_AWCACHE
 ,output wire [3 - 1 : 0 ] h2f_lw_AWPROT
 ,output wire [1 - 1 : 0 ] h2f_lw_AWVALID
 ,input wire [1 - 1 : 0 ] h2f_lw_AWREADY
 ,output wire [12 - 1 : 0 ] h2f_lw_WID
 ,output wire [32 - 1 : 0 ] h2f_lw_WDATA
 ,output wire [4 - 1 : 0 ] h2f_lw_WSTRB
 ,output wire [1 - 1 : 0 ] h2f_lw_WLAST
 ,output wire [1 - 1 : 0 ] h2f_lw_WVALID
 ,input wire [1 - 1 : 0 ] h2f_lw_WREADY
 ,input wire [12 - 1 : 0 ] h2f_lw_BID
 ,input wire [2 - 1 : 0 ] h2f_lw_BRESP
 ,input wire [1 - 1 : 0 ] h2f_lw_BVALID
 ,output wire [1 - 1 : 0 ] h2f_lw_BREADY
 ,output wire [12 - 1 : 0 ] h2f_lw_ARID
 ,output wire [21 - 1 : 0 ] h2f_lw_ARADDR
 ,output wire [4 - 1 : 0 ] h2f_lw_ARLEN
 ,output wire [3 - 1 : 0 ] h2f_lw_ARSIZE
 ,output wire [2 - 1 : 0 ] h2f_lw_ARBURST
 ,output wire [2 - 1 : 0 ] h2f_lw_ARLOCK
 ,output wire [4 - 1 : 0 ] h2f_lw_ARCACHE
 ,output wire [3 - 1 : 0 ] h2f_lw_ARPROT
 ,output wire [1 - 1 : 0 ] h2f_lw_ARVALID
 ,input wire [1 - 1 : 0 ] h2f_lw_ARREADY
 ,input wire [12 - 1 : 0 ] h2f_lw_RID
 ,input wire [32 - 1 : 0 ] h2f_lw_RDATA
 ,input wire [2 - 1 : 0 ] h2f_lw_RRESP
 ,input wire [1 - 1 : 0 ] h2f_lw_RLAST
 ,input wire [1 - 1 : 0 ] h2f_lw_RVALID
 ,output wire [1 - 1 : 0 ] h2f_lw_RREADY
);


cyclonev_hps_interface_clocks_resets clocks_resets(
 .f2h_pending_rst_ack({
    1'b1 // 0:0
  })
,.f2h_warm_rst_req_n({
    1'b1 // 0:0
  })
,.f2h_dbg_rst_req_n({
    1'b1 // 0:0
  })
,.h2f_rst_n({
    h2f_rst_n[0:0] // 0:0
  })
,.f2h_cold_rst_req_n({
    1'b1 // 0:0
  })
);


cyclonev_hps_interface_dbg_apb debug_apb(
 .DBG_APB_DISABLE({
    1'b0 // 0:0
  })
,.P_CLK_EN({
    1'b0 // 0:0
  })
);


cyclonev_hps_interface_tpiu_trace tpiu(
 .traceclk_ctl({
    1'b1 // 0:0
  })
);


cyclonev_hps_interface_boot_from_fpga boot_from_fpga(
 .boot_from_fpga_ready({
    1'b0 // 0:0
  })
,.boot_from_fpga_on_failure({
    1'b0 // 0:0
  })
,.bsel_en({
    1'b0 // 0:0
  })
,.csel_en({
    1'b0 // 0:0
  })
,.csel({
    2'b01 // 1:0
  })
,.bsel({
    3'b001 // 2:0
  })
);


cyclonev_hps_interface_fpga2hps fpga2hps(
 .port_size_config({
    2'b11 // 1:0
  })
);


cyclonev_hps_interface_hps2fpga_light_weight hps2fpga_light_weight(
 .arsize({
    h2f_lw_ARSIZE[2:0] // 2:0
  })
,.wvalid({
    h2f_lw_WVALID[0:0] // 0:0
  })
,.rlast({
    h2f_lw_RLAST[0:0] // 0:0
  })
,.clk({
    h2f_lw_axi_clk[0:0] // 0:0
  })
,.rresp({
    h2f_lw_RRESP[1:0] // 1:0
  })
,.arready({
    h2f_lw_ARREADY[0:0] // 0:0
  })
,.arprot({
    h2f_lw_ARPROT[2:0] // 2:0
  })
,.araddr({
    h2f_lw_ARADDR[20:0] // 20:0
  })
,.bvalid({
    h2f_lw_BVALID[0:0] // 0:0
  })
,.arid({
    h2f_lw_ARID[11:0] // 11:0
  })
,.bid({
    h2f_lw_BID[11:0] // 11:0
  })
,.arburst({
    h2f_lw_ARBURST[1:0] // 1:0
  })
,.arcache({
    h2f_lw_ARCACHE[3:0] // 3:0
  })
,.awvalid({
    h2f_lw_AWVALID[0:0] // 0:0
  })
,.wdata({
    h2f_lw_WDATA[31:0] // 31:0
  })
,.rid({
    h2f_lw_RID[11:0] // 11:0
  })
,.rvalid({
    h2f_lw_RVALID[0:0] // 0:0
  })
,.wready({
    h2f_lw_WREADY[0:0] // 0:0
  })
,.awlock({
    h2f_lw_AWLOCK[1:0] // 1:0
  })
,.bresp({
    h2f_lw_BRESP[1:0] // 1:0
  })
,.arlen({
    h2f_lw_ARLEN[3:0] // 3:0
  })
,.awsize({
    h2f_lw_AWSIZE[2:0] // 2:0
  })
,.awlen({
    h2f_lw_AWLEN[3:0] // 3:0
  })
,.bready({
    h2f_lw_BREADY[0:0] // 0:0
  })
,.awid({
    h2f_lw_AWID[11:0] // 11:0
  })
,.rdata({
    h2f_lw_RDATA[31:0] // 31:0
  })
,.awready({
    h2f_lw_AWREADY[0:0] // 0:0
  })
,.arvalid({
    h2f_lw_ARVALID[0:0] // 0:0
  })
,.wlast({
    h2f_lw_WLAST[0:0] // 0:0
  })
,.awprot({
    h2f_lw_AWPROT[2:0] // 2:0
  })
,.awaddr({
    h2f_lw_AWADDR[20:0] // 20:0
  })
,.wid({
    h2f_lw_WID[11:0] // 11:0
  })
,.awcache({
    h2f_lw_AWCACHE[3:0] // 3:0
  })
,.arlock({
    h2f_lw_ARLOCK[1:0] // 1:0
  })
,.awburst({
    h2f_lw_AWBURST[1:0] // 1:0
  })
,.rready({
    h2f_lw_RREADY[0:0] // 0:0
  })
,.wstrb({
    h2f_lw_WSTRB[3:0] // 3:0
  })
);


cyclonev_hps_interface_hps2fpga hps2fpga(
 .port_size_config({
    2'b11 // 1:0
  })
);


cyclonev_hps_interface_fpga2sdram f2sdram(
 .cfg_cport_rfifo_map({
    18'b000000000000000000 // 17:0
  })
,.cfg_axi_mm_select({
    6'b000000 // 5:0
  })
,.cfg_wfifo_cport_map({
    16'b0000000000000000 // 15:0
  })
,.cfg_cport_type({
    12'b000000000000 // 11:0
  })
,.cfg_rfifo_cport_map({
    16'b0000000000000000 // 15:0
  })
,.cfg_port_width({
    12'b000000000000 // 11:0
  })
,.cfg_cport_wfifo_map({
    18'b000000000000000000 // 17:0
  })
);

endmodule

