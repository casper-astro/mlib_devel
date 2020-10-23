////------------------------------------------------------------------------------
////  (c) Copyright 2013 Xilinx, Inc. All rights reserved.
////
////  This file contains confidential and proprietary information
////  of Xilinx, Inc. and is protected under U.S. and
////  international copyright and other intellectual property
////  laws.
////
////  DISCLAIMER
////  This disclaimer is not a license and does not grant any
////  rights to the materials distributed herewith. Except as
////  otherwise provided in a valid license issued to you by
////  Xilinx, and to the maximum extent permitted by applicable
////  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
////  WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
////  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
////  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
////  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
////  (2) Xilinx shall not be liable (whether in contract or tort,
////  including negligence, or under any other theory of
////  liability) for any loss or damage of any kind or nature
////  related to, arising under or in connection with these
////  materials, including for any direct, or any indirect,
////  special, incidental, or consequential loss or damage
////  (including loss of data, profits, goodwill, or any type of
////  loss or damage suffered as a result of any action brought
////  by a third party) even if such damage or loss was
////  reasonably foreseeable or Xilinx had been advised of the
////  possibility of the same.
////
////  CRITICAL APPLICATIONS
////  Xilinx products are not designed or intended to be fail-
////  safe, or for use in any application requiring fail-safe
////  performance, such as life-support or safety devices or
////  systems, Class III medical devices, nuclear facilities,
////  applications related to the deployment of airbags, or any
////  other applications that could lead to death, personal
////  injury, or severe property or environmental damage
////  (individually and collectively, "Critical
////  Applications"). Customer assumes the sole risk and
////  liability of any use of Xilinx products in Critical
////  Applications, subject only to applicable laws and
////  regulations governing limitations on product liability.
////
////  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
////  PART OF THIS FILE AT ALL TIMES.
////------------------------------------------------------------------------------


`timescale 1fs/1fs

(* DowngradeIPIdentifiedWarnings="yes" *)
module tengbaser_infrastructure_ultrascale (
     input gt_refclk_p,
     input gt_refclk_n,
     output gt_refclk_out,
     input  [0:0] qpll0reset,
     output [0:0] qpll0lock,
     output [0:0] qpll0outclk,
     output [0:0] qpll0outrefclk,
     input  [0:0] qpll1reset,
     output [0:0] qpll1lock,
     output [0:0] qpll1outclk,
     output [0:0] qpll1outrefclk,
     input  wire gt_txusrclk2_0,
     input  wire gt_rxusrclk2_0,
     input  wire rx_core_clk_0,
     input  wire gt_tx_reset_in_0,
     input  wire gt_rx_reset_in_0,

     input  wire tx_core_reset_in_0,
     input  wire rx_core_reset_in_0,
     output wire tx_core_reset_out_0,
     output wire rx_core_reset_out_0,
     output wire rx_serdes_reset_out_0,
     output wire usr_tx_reset_0,
     output wire usr_rx_reset_0,
     output wire gtwiz_reset_all_0,
     output wire gtwiz_reset_tx_datapath_out_0,
     output wire gtwiz_reset_rx_datapath_out_0,
    
     input  wire sys_reset,
     output  wire dclk

);

wire refclk;

xxv_ethernet_1_clocking_wrapper i_xxv_ethernet_1_clocking_wrapper(
    .gt_refclk_p (gt_refclk_p),
    .gt_refclk_n (gt_refclk_n),
    .gt_refclk_out (gt_refclk_out),
    .gt_refclk (refclk),
	.qplllock(qpll0lock),
	.dclk(dclk));
	
xxv_ethernet_1_common_wrapper i_xxv_ethernet_1_common_wrapper
(
    .refclk(refclk),
    .qpll0reset(qpll0reset),
    .qpll0lock(qpll0lock),
    .qpll0outclk(qpll0outclk),
    .qpll0outrefclk(qpll0outrefclk),
    .qpll1reset (1'b0),
    .qpll1lock (qpll1lock),
    .qpll1outclk (qpll1outclk),
    .qpll1outrefclk (qpll1outrefclk)
);

xxv_ethernet_1_reset_wrapper i_xxv_ethernet_1_reset_wrapper_0(
    .gt_txusrclk2 (gt_txusrclk2_0),
    .gt_rxusrclk2 (gt_rxusrclk2_0),
    .rx_core_clk (rx_core_clk_0),
    .gt_tx_reset_in (gt_tx_reset_in_0),
    .gt_rx_reset_in (gt_rx_reset_in_0),
    .tx_core_reset_in (tx_core_reset_in_0),
    .rx_core_reset_in (rx_core_reset_in_0),
    .tx_core_reset_out (tx_core_reset_out_0),
    .rx_core_reset_out (rx_core_reset_out_0),
    .rx_serdes_reset_out (rx_serdes_reset_out_0),
    .usr_tx_reset (usr_tx_reset_0),
    .usr_rx_reset (usr_rx_reset_0),
    .gtwiz_reset_all (gtwiz_reset_all_0),
    .gtwiz_reset_tx_datapath_out (gtwiz_reset_tx_datapath_out_0),
    .gtwiz_reset_rx_datapath_out (gtwiz_reset_rx_datapath_out_0),
    .sys_reset (sys_reset),
    .dclk (dclk)
);
endmodule

