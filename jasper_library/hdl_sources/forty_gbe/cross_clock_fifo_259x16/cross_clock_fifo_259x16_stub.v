// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (lin64) Build 1577090 Thu Jun  2 16:32:35 MDT 2016
// Date        : Mon Nov  7 14:25:06 2016
// Host        : adam-cm running 64-bit Ubuntu 14.04.5 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/aisaacson/work/git_work/ska_sa/projects/skarab_bsp_firmware/firmware/FRM123701U1R1/Vivado/IP/cross_clock_fifo_259x16/cross_clock_fifo_259x16_stub.v
// Design      : cross_clock_fifo_259x16
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx690tffg1927-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_1_1,Vivado 2016.2" *)
module cross_clock_fifo_259x16(rst, wr_clk, rd_clk, din, wr_en, rd_en, dout, full, almost_full, empty)
/* synthesis syn_black_box black_box_pad_pin="rst,wr_clk,rd_clk,din[258:0],wr_en,rd_en,dout[258:0],full,almost_full,empty" */;
  input rst;
  input wr_clk;
  input rd_clk;
  input [258:0]din;
  input wr_en;
  input rd_en;
  output [258:0]dout;
  output full;
  output almost_full;
  output empty;
endmodule
