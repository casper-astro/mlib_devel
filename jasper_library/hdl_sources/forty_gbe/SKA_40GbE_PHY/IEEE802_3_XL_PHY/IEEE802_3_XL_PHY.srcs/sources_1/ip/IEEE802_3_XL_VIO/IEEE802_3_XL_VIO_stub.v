// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1.1 (lin64) Build 2580384 Sat Jun 29 08:04:45 MDT 2019
// Date        : Mon Jul 15 17:23:36 2019
// Host        : casper1 running 64-bit Ubuntu 16.04.6 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/hpw1/work/tutorials_devel/vivado_2018/skarab/tut_intro/skarab_tut_intro/myproj/myproj.srcs/sources_1/ip/IEEE802_3_XL_VIO/IEEE802_3_XL_VIO_stub.v
// Design      : IEEE802_3_XL_VIO
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx690tffg1927-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "vio,Vivado 2019.1.1" *)
module IEEE802_3_XL_VIO(clk, probe_in0, probe_in1, probe_in2, probe_in3, 
  probe_in4, probe_in5, probe_in6, probe_in7, probe_in8, probe_in9, probe_in10, probe_in11, 
  probe_in12, probe_in13, probe_in14, probe_in15, probe_out0, probe_out1, probe_out2, probe_out3)
/* synthesis syn_black_box black_box_pad_pin="clk,probe_in0[3:0],probe_in1[3:0],probe_in2[3:0],probe_in3[3:0],probe_in4[0:0],probe_in5[15:0],probe_in6[31:0],probe_in7[31:0],probe_in8[31:0],probe_in9[31:0],probe_in10[3:0],probe_in11[3:0],probe_in12[3:0],probe_in13[3:0],probe_in14[31:0],probe_in15[31:0],probe_out0[0:0],probe_out1[0:0],probe_out2[0:0],probe_out3[0:0]" */;
  input clk;
  input [3:0]probe_in0;
  input [3:0]probe_in1;
  input [3:0]probe_in2;
  input [3:0]probe_in3;
  input [0:0]probe_in4;
  input [15:0]probe_in5;
  input [31:0]probe_in6;
  input [31:0]probe_in7;
  input [31:0]probe_in8;
  input [31:0]probe_in9;
  input [3:0]probe_in10;
  input [3:0]probe_in11;
  input [3:0]probe_in12;
  input [3:0]probe_in13;
  input [31:0]probe_in14;
  input [31:0]probe_in15;
  output [0:0]probe_out0;
  output [0:0]probe_out1;
  output [0:0]probe_out2;
  output [0:0]probe_out3;
endmodule
