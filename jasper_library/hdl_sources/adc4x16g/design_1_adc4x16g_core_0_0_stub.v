// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Mon Aug 10 16:12:58 2020
// Host        : DESKTOP-V18QKD3 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/XilinxProjects/SAO_ADC/ADC4X16G_system/ADC4X16G_system.srcs/sources_1/bd/design_1/ip/design_1_adc4x16g_core_0_0/design_1_adc4x16g_core_0_0_stub.v
// Design      : design_1_adc4x16g_core_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xcvu37p-fsvh2892-2L-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "gty_wrapper_0,Vivado 2019.2" *)
module design_1_adc4x16g_core_0_0(refclk0_p, refclk0_n, refclk1_p, refclk1_n, 
  refclk2_p, refclk2_n, refclk3_p, refclk3_n, clk100, clk_freerun, gtwiz_reset_all_in, bit_sel, 
  chan_sel, gty0rxp_in, gty0rxn_in, gty1rxp_in, gty1rxn_in, gty2rxp_in, gty2rxn_in, gty3rxp_in, 
  gty3rxn_in, rxcdrhold, rxslide, XOR_ON, match_pattern, pattern_match_enable, rxprbserr_out, 
  rxprbslocked, fifo_reset, fifo_read, fifo_full, data_out, prbs_error_count_reset, drp_addr, 
  drp_reset, drp_read, drp_data, write_interval)
/* synthesis syn_black_box black_box_pad_pin="refclk0_p,refclk0_n,refclk1_p,refclk1_n,refclk2_p,refclk2_n,refclk3_p,refclk3_n,clk100,clk_freerun,gtwiz_reset_all_in,bit_sel[1:0],chan_sel[1:0],gty0rxp_in[3:0],gty0rxn_in[3:0],gty1rxp_in[3:0],gty1rxn_in[3:0],gty2rxp_in[3:0],gty2rxn_in[3:0],gty3rxp_in[3:0],gty3rxn_in[3:0],rxcdrhold,rxslide,XOR_ON,match_pattern[31:0],pattern_match_enable,rxprbserr_out[15:0],rxprbslocked,fifo_reset,fifo_read,fifo_full,data_out[31:0],prbs_error_count_reset,drp_addr[9:0],drp_reset,drp_read,drp_data[15:0],write_interval[7:0]" */;
  input refclk0_p;
  input refclk0_n;
  input refclk1_p;
  input refclk1_n;
  input refclk2_p;
  input refclk2_n;
  input refclk3_p;
  input refclk3_n;
  input clk100;
  input clk_freerun;
  input gtwiz_reset_all_in;
  input [1:0]bit_sel;
  input [1:0]chan_sel;
  input [3:0]gty0rxp_in;
  input [3:0]gty0rxn_in;
  input [3:0]gty1rxp_in;
  input [3:0]gty1rxn_in;
  input [3:0]gty2rxp_in;
  input [3:0]gty2rxn_in;
  input [3:0]gty3rxp_in;
  input [3:0]gty3rxn_in;
  input rxcdrhold;
  input rxslide;
  input XOR_ON;
  input [31:0]match_pattern;
  input pattern_match_enable;
  output [15:0]rxprbserr_out;
  output rxprbslocked;
  input fifo_reset;
  input fifo_read;
  output fifo_full;
  output [31:0]data_out;
  input prbs_error_count_reset;
  input [9:0]drp_addr;
  input drp_reset;
  input drp_read;
  output [15:0]drp_data;
  input [7:0]write_interval;
endmodule
