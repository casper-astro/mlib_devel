// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1.1 (lin64) Build 2580384 Sat Jun 29 08:04:45 MDT 2019
// Date        : Fri Jul 17 10:37:51 2020
// Host        : adam-cm running 64-bit Ubuntu 16.04.6 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/aisaacson/work/git_work/ska-sa/wes/mlib_devel/jasper_library/test_models/skarab_fgbe/myproj/myproj.srcs/sources_1/ip/cpu_rx_packet_size/cpu_rx_packet_size_stub.v
// Design      : cpu_rx_packet_size
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx690tffg1927-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_2_4,Vivado 2019.1.1" *)
module cpu_rx_packet_size(wr_clk, wr_rst, rd_clk, rd_rst, din, wr_en, rd_en, 
  dout, full, empty, wr_data_count)
/* synthesis syn_black_box black_box_pad_pin="wr_clk,wr_rst,rd_clk,rd_rst,din[10:0],wr_en,rd_en,dout[10:0],full,empty,wr_data_count[3:0]" */;
  input wr_clk;
  input wr_rst;
  input rd_clk;
  input rd_rst;
  input [10:0]din;
  input wr_en;
  input rd_en;
  output [10:0]dout;
  output full;
  output empty;
  output [3:0]wr_data_count;
endmodule
