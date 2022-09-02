// Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2014.3.1 (lin64) Build 1056140 Thu Oct 30 16:30:39 MDT 2014
// Date        : Fri Feb  5 10:39:14 2021
// Host        : hwdev-xbs running 64-bit Ubuntu 18.04.5 LTS
// Command     : write_verilog -force -mode synth_stub
//               /media/data/Francois/VivadoProjects/FRM123701U1R4/Vivado/IP/chbfifo/chbfifo_stub.v
// Design      : chbfifo
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx690tffg1927-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v12_0,Vivado 2014.3.1" *)
module chbfifo(clk, srst, din, wr_en, rd_en, dout, full, empty)
/* synthesis syn_black_box black_box_pad_pin="clk,srst,din[35:0],wr_en,rd_en,dout[35:0],full,empty" */;
  input clk;
  input srst;
  input [35:0]din;
  input wr_en;
  input rd_en;
  output [35:0]dout;
  output full;
  output empty;
endmodule
