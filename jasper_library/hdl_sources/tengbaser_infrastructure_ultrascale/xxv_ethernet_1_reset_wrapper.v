////------------------------------------------------------------------------------
////  (c) Copyright 2015 Xilinx, Inc. All rights reserved.
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

`timescale 1ps / 1ps
(* DowngradeIPIdentifiedWarnings="yes" *)
module xxv_ethernet_1_reset_wrapper
(
    input  wire sys_reset,
    input  wire dclk,
    input  wire gt_txusrclk2,
    input  wire gt_rxusrclk2,
    input  wire rx_core_clk,
    input  wire gt_tx_reset_in,
    input  wire gt_rx_reset_in,

    input  wire tx_core_reset_in,
    input  wire rx_core_reset_in,
    output wire tx_core_reset_out,
    output wire rx_core_reset_out,
    output wire rx_serdes_reset_out,
    output wire usr_tx_reset,
    output wire usr_rx_reset,
    output wire gtwiz_reset_all,
    output wire gtwiz_reset_tx_datapath_out,
    output wire gtwiz_reset_rx_datapath_out
);

  wire gt_tx_reset_in_sync;
  wire gt_tx_reset_in_sync_inv;
  wire tx_reset_done_async;

  wire gt_rx_reset_in_sync;
  wire gt_rx_reset_in_sync_inv;
  wire rx_reset_done_async;
  wire rx_serdes_reset_done;
  reg  rx_reset_done_async_r;
  wire rx_reset_done;



  assign gtwiz_reset_tx_datapath_out = 1'b0;
  assign gtwiz_reset_rx_datapath_out = 1'b0;

  assign gtwiz_reset_all             = sys_reset;
 
 

 
  xxv_ethernet_1_reset_wrapper_cdc_sync i_xxv_ethernet_1_cdc_sync_gt_tx_resetdone
  (
   .clk              (gt_txusrclk2),
   .signal_in        (gt_tx_reset_in), 
   .signal_out       (gt_tx_reset_in_sync)
  );

  assign gt_tx_reset_in_sync_inv  =  ~(gt_tx_reset_in_sync);
  assign tx_reset_done_async      =  gt_tx_reset_in_sync_inv | tx_core_reset_in;
  assign usr_tx_reset             =  tx_reset_done_async;
  assign tx_core_reset_out        =  tx_reset_done_async;

  xxv_ethernet_1_reset_wrapper_cdc_sync i_xxv_ethernet_1_cdc_sync_gt_rx_resetdone
  (
   .clk              (gt_txusrclk2),
   .signal_in        (gt_rx_reset_in), 
   .signal_out       (gt_rx_reset_in_sync)
  );

  assign gt_rx_reset_in_sync_inv   =  ~(gt_rx_reset_in_sync);
  assign rx_reset_done_async       =  gt_rx_reset_in_sync_inv | rx_core_reset_in;
 
  always @( posedge gt_txusrclk2)
  begin
       rx_reset_done_async_r  <= rx_reset_done_async;
  end
 
  xxv_ethernet_1_reset_wrapper_cdc_sync i_xxv_ethernet_1_cdc_sync_gt_rx_serdes_resetdone
  (
   .clk              (gt_rxusrclk2),
   .signal_in        (rx_reset_done_async_r), 
   .signal_out       (rx_serdes_reset_done)
  );
 
  xxv_ethernet_1_reset_wrapper_cdc_sync i_xxv_ethernet_1_cdc_sync_gt_rx_resetdone_rx_core_clk
  (
   .clk              (rx_core_clk),
   .signal_in        (rx_reset_done_async_r), 
   .signal_out       (rx_reset_done)
  );
 
  assign rx_serdes_reset_out        = rx_serdes_reset_done;
  assign rx_core_reset_out          = rx_reset_done;
  assign usr_rx_reset               = rx_reset_done;

endmodule


(* DowngradeIPIdentifiedWarnings="yes" *)
  module xxv_ethernet_1_reset_wrapper_cdc_sync (
   input clk,
   input signal_in,
   output wire signal_out
  );
  
                                wire sig_in_cdc_from ;
       (* ASYNC_REG = "TRUE" *) reg  s_out_d2_cdc_to;
       (* ASYNC_REG = "TRUE" *) reg  s_out_d3;
       (* ASYNC_REG = "TRUE" *) reg  s_out_d4;
      
      assign sig_in_cdc_from = signal_in;
      assign signal_out      = s_out_d4;

      always @(posedge clk) 
      begin
        s_out_d2_cdc_to  <= sig_in_cdc_from;
        s_out_d3         <= s_out_d2_cdc_to;
        s_out_d4         <= s_out_d3;
      end
  
  endmodule

