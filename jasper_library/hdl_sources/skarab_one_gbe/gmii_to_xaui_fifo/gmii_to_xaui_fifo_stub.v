// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1.1 (lin64) Build 2580384 Sat Jun 29 08:04:45 MDT 2019
// Date        : Thu Jul 23 15:59:15 2020
// Host        : adam-cm running 64-bit Ubuntu 16.04.6 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/aisaacson/work/git_work/ska-sa/wes/mlib_devel/jasper_library/test_models/skarab_40gbe_1gbe_test/myproj/myproj.srcs/sources_1/ip/gmii_to_xaui_fifo/gmii_to_xaui_fifo_stub.v
// Design      : gmii_to_xaui_fifo
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx690tffg1927-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_1_1,Vivado 2016.2" *)
module gmii_to_xaui_fifo(wr_rst, rd_rst, wr_clk, rd_clk, din, wr_en, rd_en, 
  dout, full, empty)
/* synthesis syn_black_box black_box_pad_pin="wr_rst,rd_rst,wr_clk,rd_clk,din[71:0],wr_en,rd_en,dout[71:0],full,empty" */;
  input wr_rst;
  input rd_rst;
  input wr_clk;
  input rd_clk;
  input [71:0]din;
  input wr_en;
  input rd_en;
  output [71:0]dout;
  output full;
  output empty;
endmodule
