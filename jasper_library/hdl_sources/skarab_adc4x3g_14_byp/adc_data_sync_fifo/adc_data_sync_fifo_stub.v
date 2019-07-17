// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
// Date        : Fri Nov  2 13:30:45 2018
// Host        : adam-cm running 64-bit Ubuntu 16.04.5 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/aisaacson/work/git_work/ska_sa/projects/mlib_devel/jasper_library/test_models/test_skarab_adc/myproj/myproj.srcs/sources_1/ip/adc_data_sync_fifo/adc_data_sync_fifo_stub.v
// Design      : adc_data_sync_fifo
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx690tffg1927-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_2_2,Vivado 2018.2" *)
module adc_data_sync_fifo(clk, srst, din, wr_en, rd_en, dout, full, empty)
/* synthesis syn_black_box black_box_pad_pin="clk,srst,din[128:0],wr_en,rd_en,dout[128:0],full,empty" */;
  input clk;
  input srst;
  input [128:0]din;
  input wr_en;
  input rd_en;
  output [128:0]dout;
  output full;
  output empty;
endmodule
