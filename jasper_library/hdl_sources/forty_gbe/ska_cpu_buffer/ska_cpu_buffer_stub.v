// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (lin64) Build 1577090 Thu Jun  2 16:32:35 MDT 2016
// Date        : Thu Nov  1 10:17:09 2018
// Host        : fiona running 64-bit Ubuntu 14.04.5 LTS
// Command     : write_verilog -force -mode synth_stub
//               /data/casper/mlib_devel_eth_map/jasper_library/test_models/skarab_fgbe/myproj/myproj.srcs/sources_1/ip/ska_cpu_buffer/ska_cpu_buffer_stub.v
// Design      : ska_cpu_buffer
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx690tffg1927-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_3_3,Vivado 2016.2" *)
module ska_cpu_buffer(clka, wea, addra, dina, douta, clkb, web, addrb, dinb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,wea[0:0],addra[9:0],dina[259:0],douta[259:0],clkb,web[0:0],addrb[9:0],dinb[259:0],doutb[259:0]" */;
  input clka;
  input [0:0]wea;
  input [9:0]addra;
  input [259:0]dina;
  output [259:0]douta;
  input clkb;
  input [0:0]web;
  input [9:0]addrb;
  input [259:0]dinb;
  output [259:0]doutb;
endmodule
