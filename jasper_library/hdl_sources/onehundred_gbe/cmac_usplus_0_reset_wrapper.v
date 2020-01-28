//------------------------------------------------------------------------------
//  (c) Copyright 2013 Xilinx, Inc. All rights reserved.
//
//  This file contains confidential and proprietary information
//  of Xilinx, Inc. and is protected under U.S. and
//  international copyright and other intellectual property
//  laws.
//
//  DISCLAIMER
//  This disclaimer is not a license and does not grant any
//  rights to the materials distributed herewith. Except as
//  otherwise provided in a valid license issued to you by
//  Xilinx, and to the maximum extent permitted by applicable
//  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
//  WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
//  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
//  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
//  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
//  (2) Xilinx shall not be liable (whether in contract or tort,
//  including negligence, or under any other theory of
//  liability) for any loss or damage of any kind or nature
//  related to, arising under or in connection with these
//  materials, including for any direct, or any indirect,
//  special, incidental, or consequential loss or damage
//  (including loss of data, profits, goodwill, or any type of
//  loss or damage suffered as a result of any action brought
//  by a third party) even if such damage or loss was
//  reasonably foreseeable or Xilinx had been advised of the
//  possibility of the same.
//
//  CRITICAL APPLICATIONS
//  Xilinx products are not designed or intended to be fail-
//  safe, or for use in any application requiring fail-safe
//  performance, such as life-support or safety devices or
//  systems, Class III medical devices, nuclear facilities,
//  applications related to the deployment of airbags, or any
//  other applications that could lead to death, personal
//  injury, or severe property or environmental damage
//  (individually and collectively, "Critical
//  Applications"). Customer assumes the sole risk and
//  liability of any use of Xilinx products in Critical
//  Applications, subject only to applicable laws and
//  regulations governing limitations on product liability.
//
//  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
//  PART OF THIS FILE AT ALL TIMES.
//------------------------------------------------------------------------------

`timescale 1ps / 1ps
(* DowngradeIPIdentifiedWarnings="yes" *)
module cmac_usplus_0_reset_wrapper
(
    input         gt_txusrclk2,
    input         gt_rxusrclk2,
    input         rx_clk,
    input         gt_tx_reset_in,
    input         gt_rx_reset_in,
    input         core_drp_reset,
    input         core_tx_reset,
    output        tx_reset_out,
    input         core_rx_reset,
    output        rx_reset_out,
    output [9:0]  rx_serdes_reset_out,
    output        usr_tx_reset,
    output        usr_rx_reset
);

  wire            gt_txresetdone_int;
  wire            gt_txresetdone_int_sync;
  wire            gt_tx_reset_done_inv;

  wire            gt_rxresetdone_int;
  wire            gt_rxresetdone_int_sync;
  wire            gt_rx_reset_done_inv;
  reg             gt_rx_reset_done_inv_reg;
  wire            gt_rx_reset_done_inv_reg_sync;
  wire            reset_done_async;
  wire [9:0]      rx_serdes_reset_done;


assign gt_txresetdone_int = gt_tx_reset_in;

  cmac_usplus_0_exdes_cdc_sync i_cmac_usplus_0_exdes_cmac_cdc_sync_gt_txresetdone_int
  (
   .clk              (gt_txusrclk2),
   .signal_in        (gt_txresetdone_int), 
   .signal_out       (gt_txresetdone_int_sync)
  );

  wire core_drp_reset_tx_clk_sync;
  wire core_tx_reset_sync;

  cmac_usplus_0_exdes_cdc_sync i_cmac_usplus_0_exdes_cmac_cdc_sync_core_drp_reset_tx_clk
  (
   .clk              (gt_txusrclk2),
   .signal_in        (core_drp_reset), 
   .signal_out       (core_drp_reset_tx_clk_sync)
  );

  cmac_usplus_0_exdes_cdc_sync i_cmac_usplus_0_exdes_cmac_cdc_sync_core_tx_reset
  (
   .clk              (gt_txusrclk2),
   .signal_in        (core_tx_reset), 
   .signal_out       (core_tx_reset_sync)
  );

  assign gt_tx_reset_done_inv     =  ~(gt_txresetdone_int_sync);
  assign tx_reset_done            =  gt_tx_reset_done_inv | core_drp_reset_tx_clk_sync | core_tx_reset_sync;


  assign usr_tx_reset             =  tx_reset_done;
  assign tx_reset_out             =  tx_reset_done;



  assign gt_rxresetdone_int       =  gt_rx_reset_in;
  assign rx_serdes_reset_out      =  rx_serdes_reset_done;

  cmac_usplus_0_exdes_cdc_sync i_cmac_usplus_0_exdes_cmac_cdc_sync_gt_rxresetdone_int
  (
   .clk              (rx_clk),
   .signal_in        (gt_rxresetdone_int), 
   .signal_out       (gt_rxresetdone_int_sync)
  );

  wire core_drp_reset_rx_clk_sync;
  wire core_rx_reset_sync;

  cmac_usplus_0_exdes_cdc_sync i_cmac_usplus_0_exdes_cmac_cdc_sync_core_drp_reset_rx_clk
  (
   .clk              (rx_clk),
   .signal_in        (core_drp_reset), 
   .signal_out       (core_drp_reset_rx_clk_sync)
  );

  cmac_usplus_0_exdes_cdc_sync i_cmac_usplus_0_exdes_cmac_cdc_sync_core_rx_reset
  (
   .clk              (rx_clk),
   .signal_in        (core_rx_reset), 
   .signal_out       (core_rx_reset_sync)
  );


  assign gt_rx_reset_done_inv     =  ~(gt_rxresetdone_int_sync);
  assign rx_reset_done            =  gt_rx_reset_done_inv | core_drp_reset_rx_clk_sync | core_rx_reset_sync;

  assign usr_rx_reset             =  rx_reset_done;
  assign rx_reset_out             =  rx_reset_done;

  always @(posedge rx_clk)
  begin
      gt_rx_reset_done_inv_reg    <= gt_rx_reset_done_inv;
  end

  cmac_usplus_0_exdes_cdc_sync i_cmac_usplus_0_exdes_cmac_cdc_sync_gt_rxresetdone_reg_rxusrclk2
  (
   .clk              (gt_rxusrclk2),
   .signal_in        (gt_rx_reset_done_inv_reg), 
   .signal_out       (gt_rx_reset_done_inv_reg_sync)
  );
  
  wire core_drp_reset_serdes_clk_sync;

  cmac_usplus_0_exdes_cdc_sync i_cmac_usplus_0_exdes_cmac_cdc_sync_gt_txresetdone_int3
  (
   .clk              (gt_rxusrclk2),
   .signal_in        (core_drp_reset), 
   .signal_out       (core_drp_reset_serdes_clk_sync)
  );

  assign reset_done_async         =  gt_rx_reset_done_inv_reg_sync | core_drp_reset_serdes_clk_sync;


  assign rx_serdes_reset_done[0]  =  reset_done_async;
  assign rx_serdes_reset_done[1]  =  reset_done_async;
  assign rx_serdes_reset_done[2]  =  reset_done_async;
  assign rx_serdes_reset_done[3]  =  reset_done_async;
  assign rx_serdes_reset_done[4]  =  1'b1;
  assign rx_serdes_reset_done[5]  =  1'b1;
  assign rx_serdes_reset_done[6]  =  1'b1;
  assign rx_serdes_reset_done[7]  =  1'b1;
  assign rx_serdes_reset_done[8]  =  1'b1;
  assign rx_serdes_reset_done[9]  =  1'b1;

endmodule


(* DowngradeIPIdentifiedWarnings="yes" *)
  module cmac_usplus_0_exdes_cdc_sync (
   input clk,
   input signal_in,
   output wire signal_out
  );
  
                               wire sig_in_cdc_from ;
      (* ASYNC_REG = "TRUE" *) reg  s_out_d2_cdc_to;
      (* ASYNC_REG = "TRUE" *) reg  s_out_d3;
      (* max_fanout = 500 *)   reg  s_out_d4;
      
// synthesis translate_off
      
      initial s_out_d2_cdc_to = 1'b0;
      initial s_out_d3        = 1'b0;
      initial s_out_d4        = 1'b0;
      
// synthesis translate_on   
   
      assign sig_in_cdc_from = signal_in;
      assign signal_out      = s_out_d4;
      
      always @(posedge clk) 
      begin
        s_out_d4         <= s_out_d3;
        s_out_d3         <= s_out_d2_cdc_to;
        s_out_d2_cdc_to  <= sig_in_cdc_from;
      end
  
  endmodule

