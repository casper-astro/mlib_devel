// Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2014.3.1 (win64) Build 1056140 Thu Oct 30 17:03:40 MDT 2014
// Date        : Thu Jan 08 09:05:33 2015
// Host        : gavin-win7 running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub
//               W:/VHDL/Proj/FRM123701U1R1/Vivado/IP/xlgmii_loopback_fifo/xlgmii_loopback_fifo_stub.v
// Design      : xlgmii_loopback_fifo
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx690tffg1927-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v12_0,Vivado 2014.3.1" *)
module xlgmii_loopback_fifo(clk, rst, din, wr_en, rd_en, dout, full, empty)
/* synthesis syn_black_box black_box_pad_pin="clk,rst,din[287:0],wr_en,rd_en,dout[287:0],full,empty" */;
  input clk;
  input rst;
  input [287:0]din;
  input wr_en;
  input rd_en;
  output [287:0]dout;
  output full;
  output empty;
endmodule
