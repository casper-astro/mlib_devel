// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1.1 (lin64) Build 2580384 Sat Jun 29 08:04:45 MDT 2019
// Date        : Thu Jul 23 17:41:23 2020
// Host        : adam-cm running 64-bit Ubuntu 16.04.6 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/aisaacson/work/git_work/ska-sa/wes/mlib_devel/jasper_library/test_models/skarab_40gbe_1gbe_test/myproj/myproj.srcs/sources_1/ip/tx_packet_fifo/tx_packet_fifo_stub.v
// Design      : tx_packet_fifo
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx690tffg1927-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_2_4,Vivado 2019.1.1" *)
module tx_packet_fifo(wr_clk, wr_rst, rd_clk, rd_rst, din, wr_en, rd_en, 
  dout, full, overflow, empty, prog_full)
/* synthesis syn_black_box black_box_pad_pin="wr_clk,wr_rst,rd_clk,rd_rst,din[63:0],wr_en,rd_en,dout[63:0],full,overflow,empty,prog_full" */;
  input wr_clk;
  input wr_rst;
  input rd_clk;
  input rd_rst;
  input [63:0]din;
  input wr_en;
  input rd_en;
  output [63:0]dout;
  output full;
  output overflow;
  output empty;
  output prog_full;
endmodule
