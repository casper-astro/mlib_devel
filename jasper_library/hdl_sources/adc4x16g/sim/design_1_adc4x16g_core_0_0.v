// (c) Copyright 1995-2020 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:user:adc4x16g_core:1.0
// IP Revision: 29

`timescale 1ns/1ps

(* IP_DEFINITION_SOURCE = "package_project" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module design_1_adc4x16g_core_0_0 (
  refclk0_p,
  refclk0_n,
  refclk1_p,
  refclk1_n,
  refclk2_p,
  refclk2_n,
  refclk3_p,
  refclk3_n,
  clk100,
  clk_freerun,
  gtwiz_reset_all_in,
  bit_sel,
  chan_sel,
  gty0rxp_in,
  gty0rxn_in,
  gty1rxp_in,
  gty1rxn_in,
  gty2rxp_in,
  gty2rxn_in,
  gty3rxp_in,
  gty3rxn_in,
  rxcdrhold,
  rxslide,
  XOR_ON,
  match_pattern,
  pattern_match_enable,
  rxprbserr_out,
  rxprbslocked,
  fifo_reset,
  fifo_read,
  fifo_full,
  data_out,
  prbs_error_count_reset,
  drp_addr,
  drp_reset,
  drp_read,
  drp_data,
  write_interval
);

input wire refclk0_p;
input wire refclk0_n;
input wire refclk1_p;
input wire refclk1_n;
input wire refclk2_p;
input wire refclk2_n;
input wire refclk3_p;
input wire refclk3_n;
input wire clk100;
input wire clk_freerun;
input wire gtwiz_reset_all_in;
input wire [1 : 0] bit_sel;
input wire [1 : 0] chan_sel;
input wire [3 : 0] gty0rxp_in;
input wire [3 : 0] gty0rxn_in;
input wire [3 : 0] gty1rxp_in;
input wire [3 : 0] gty1rxn_in;
input wire [3 : 0] gty2rxp_in;
input wire [3 : 0] gty2rxn_in;
input wire [3 : 0] gty3rxp_in;
input wire [3 : 0] gty3rxn_in;
input wire rxcdrhold;
input wire rxslide;
input wire XOR_ON;
input wire [31 : 0] match_pattern;
input wire pattern_match_enable;
output wire [15 : 0] rxprbserr_out;
output wire rxprbslocked;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME fifo_reset, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 fifo_reset RST" *)
input wire fifo_reset;
input wire fifo_read;
output wire fifo_full;
output wire [31 : 0] data_out;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME prbs_error_count_reset, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 prbs_error_count_reset RST" *)
input wire prbs_error_count_reset;
input wire [9 : 0] drp_addr;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME drp_reset, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 drp_reset RST" *)
input wire drp_reset;
input wire drp_read;
output wire [15 : 0] drp_data;
input wire [7 : 0] write_interval;

  gty_wrapper_0 #(
    .BOARD_REV(0)
  ) inst (
    .refclk0_p(refclk0_p),
    .refclk0_n(refclk0_n),
    .refclk1_p(refclk1_p),
    .refclk1_n(refclk1_n),
    .refclk2_p(refclk2_p),
    .refclk2_n(refclk2_n),
    .refclk3_p(refclk3_p),
    .refclk3_n(refclk3_n),
    .clk100(clk100),
    .clk_freerun(clk_freerun),
    .gtwiz_reset_all_in(gtwiz_reset_all_in),
    .bit_sel(bit_sel),
    .chan_sel(chan_sel),
    .gty0rxp_in(gty0rxp_in),
    .gty0rxn_in(gty0rxn_in),
    .gty1rxp_in(gty1rxp_in),
    .gty1rxn_in(gty1rxn_in),
    .gty2rxp_in(gty2rxp_in),
    .gty2rxn_in(gty2rxn_in),
    .gty3rxp_in(gty3rxp_in),
    .gty3rxn_in(gty3rxn_in),
    .rxcdrhold(rxcdrhold),
    .rxslide(rxslide),
    .XOR_ON(XOR_ON),
    .match_pattern(match_pattern),
    .pattern_match_enable(pattern_match_enable),
    .rxprbserr_out(rxprbserr_out),
    .rxprbslocked(rxprbslocked),
    .fifo_reset(fifo_reset),
    .fifo_read(fifo_read),
    .fifo_full(fifo_full),
    .data_out(data_out),
    .prbs_error_count_reset(prbs_error_count_reset),
    .drp_addr(drp_addr),
    .drp_reset(drp_reset),
    .drp_read(drp_read),
    .drp_data(drp_data),
    .write_interval(write_interval)
  );
endmodule
