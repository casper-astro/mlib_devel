// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
// Date        : Wed Oct 24 09:25:36 2018
// Host        : adam-cm running 64-bit Ubuntu 16.04.5 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/aisaacson/work/git_work/ska_sa/projects/mlib_devel/jasper_library/test_models/r2018a_test2/myproj/myproj.srcs/sources_1/ip/ska_tx_packet_fifo/ska_tx_packet_fifo_stub.v
// Design      : ska_tx_packet_fifo
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx690tffg1927-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_2_2,Vivado 2018.2" *)
module ska_tx_packet_fifo(rst, wr_clk, rd_clk, din, wr_en, rd_en, dout, full, 
  overflow, empty, prog_full)
/* synthesis syn_black_box black_box_pad_pin="rst,wr_clk,rd_clk,din[263:0],wr_en,rd_en,dout[263:0],full,overflow,empty,prog_full" */;
  input rst;
  input wr_clk;
  input rd_clk;
  input [263:0]din;
  input wr_en;
  input rd_en;
  output [263:0]dout;
  output full;
  output overflow;
  output empty;
  output prog_full;
endmodule
