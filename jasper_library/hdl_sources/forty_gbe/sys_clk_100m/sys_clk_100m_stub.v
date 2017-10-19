// Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2014.3.1 (win64) Build 1056140 Thu Oct 30 17:03:40 MDT 2014
// Date        : Mon Jan 19 12:24:34 2015
// Host        : gavin-win7 running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub
//               w:/VHDL/Proj/FRM123701U1R1/Vivado/FRM123701U1R1.srcs/sources_1/ip/sys_clk_100m/sys_clk_100m_stub.v
// Design      : sys_clk_100m
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx690tffg1927-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module sys_clk_100m(clk_in1, clkfb_in, clk_out1, clkfb_out, reset, locked)
/* synthesis syn_black_box black_box_pad_pin="clk_in1,clkfb_in,clk_out1,clkfb_out,reset,locked" */;
  input clk_in1;
  input clkfb_in;
  output clk_out1;
  output clkfb_out;
  input reset;
  output locked;
endmodule
