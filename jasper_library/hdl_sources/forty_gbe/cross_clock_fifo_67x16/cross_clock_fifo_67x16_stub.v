// Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2014.3.1 (lin64) Build 1056140 Thu Oct 30 16:30:39 MDT 2014
// Date        : Mon May 23 14:38:54 2016
// Host        : adam-cm running 64-bit Ubuntu 14.04.4 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/aisaacson/work/git_work/ska_sa/projects/mlib_devel/jasper_library/hdl_sources/forty_gbe/cross_clock_fifo_67x16/cross_clock_fifo_67x16_stub.v
// Design      : cross_clock_fifo_67x16
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx690tffg1927-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v12_0,Vivado 2014.3.1" *)
module cross_clock_fifo_67x16(rst, wr_clk, rd_clk, din, wr_en, rd_en, dout, full, almost_full, empty)
/* synthesis syn_black_box black_box_pad_pin="rst,wr_clk,rd_clk,din[66:0],wr_en,rd_en,dout[66:0],full,almost_full,empty" */;
  input rst;
  input wr_clk;
  input rd_clk;
  input [66:0]din;
  input wr_en;
  input rd_en;
  output [66:0]dout;
  output full;
  output almost_full;
  output empty;
endmodule
