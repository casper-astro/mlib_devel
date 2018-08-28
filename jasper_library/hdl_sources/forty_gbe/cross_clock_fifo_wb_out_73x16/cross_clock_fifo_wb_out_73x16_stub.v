// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
// Date        : Tue Aug 28 12:16:39 2018
// Host        : adam-cm running 64-bit Ubuntu 14.04.5 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/aisaacson/work/git_work/ska_sa/projects/skarab_bsp_firmware/firmware/FRM123701U1R1/Vivado/FRM123701U1R1.srcs/sources_1/ip/cross_clock_fifo_wb_out_73x16/cross_clock_fifo_wb_out_73x16_stub.v
// Design      : cross_clock_fifo_wb_out_73x16
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx690tffg1927-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_2_2,Vivado 2018.2" *)
module cross_clock_fifo_wb_out_73x16(rst, wr_clk, rd_clk, din, wr_en, rd_en, dout, full, 
  empty)
/* synthesis syn_black_box black_box_pad_pin="rst,wr_clk,rd_clk,din[72:0],wr_en,rd_en,dout[72:0],full,empty" */;
  input rst;
  input wr_clk;
  input rd_clk;
  input [72:0]din;
  input wr_en;
  input rd_en;
  output [72:0]dout;
  output full;
  output empty;
endmodule
