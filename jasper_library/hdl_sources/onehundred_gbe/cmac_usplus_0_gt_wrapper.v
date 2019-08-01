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


`timescale 1ps/1ps

(* DowngradeIPIdentifiedWarnings="yes" *)
module cmac_usplus_0_gt_wrapper
(
    input  [3 :0] gt_rxp_in,
    input  [3 :0] gt_rxn_in,
    output [3 :0] gt_txp_out,
    output [3 :0] gt_txn_out,

    input  [11 :0]    gt_loopback_in,
    output [3 :0]     gt_rxrecclkout,
    output [3 :0]     gt_powergoodout,

    ////GT Transceiver debug interface ports
    input  [3 :0]     gt_eyescanreset,
    input  [3 :0]     gt_eyescantrigger,
    input  [3 :0]     gt_rxcdrhold,
    input  [3 :0]     gt_rxpolarity,
    input  [11 :0]    gt_rxrate,
    input  [19 :0]    gt_txdiffctrl,
    input  [3 :0]     gt_txpolarity,
    input  [3 :0]     gt_txinhibit,
    input  [19 :0]    gt_txpostcursor,
    input  [3 :0]     gt_txprbsforceerr,
    input  [19 :0]    gt_txprecursor,
    output [3 :0]     gt_eyescandataerror,
    output [7 :0]    gt_txbufstatus,

    input  [3 :0]     gt_rxdfelpmreset,
    input  [3 :0]     gt_rxlpmen,
    input  [3 :0]     gt_rxprbscntreset,
    output [3 :0]     gt_rxprbserr,
    input  [15 :0]    gt_rxprbssel,
    output [3 :0]     gt_rxresetdone,
    input  [15 :0]    gt_txprbssel,
    output [3 :0]     gt_txresetdone,
    output [11 :0]    gt_rxbufstatus,
    input             gtwiz_reset_tx_datapath,
    input             gtwiz_reset_rx_datapath,
    input             gt_drpclk,
    input  [9:0]      gt0_drpaddr,
    input             gt0_drpen,
    input  [15:0]     gt0_drpdi,
    output [15:0]     gt0_drpdo,
    output            gt0_drprdy,
    input             gt0_drpwe,
    input  [9:0]      gt1_drpaddr,
    input             gt1_drpen,
    input  [15:0]     gt1_drpdi,
    output [15:0]     gt1_drpdo,
    output            gt1_drprdy,
    input             gt1_drpwe,
    input  [9:0]      gt2_drpaddr,
    input             gt2_drpen,
    input  [15:0]     gt2_drpdi,
    output [15:0]     gt2_drpdo,
    output            gt2_drprdy,
    input             gt2_drpwe,
    input  [9:0]      gt3_drpaddr,
    input             gt3_drpen,
    input  [15:0]     gt3_drpdi,
    output [15:0]     gt3_drpdo,
    output            gt3_drprdy,
    input             gt3_drpwe,

    output            gt_txusrclk2,
    output            gt_rxusrclk2,
    output            gt_reset_tx_done_out,
    output            gt_reset_rx_done_out,
    output [9 :0]     rx_serdes_clk,

    input  [3 :0]     qpll0clk_in,
    input  [3 :0]     qpll0refclk_in,
    input  [3 :0]     qpll1clk_in,
    input  [3 :0]     qpll1refclk_in,
    input  [0 :0]     gtwiz_reset_qpll0lock_in,
    output [0 :0]     gtwiz_reset_qpll0reset_out,
    input  [511 : 0] txdata_in,
    input  [63 : 0]  txctrl0_in,
    input  [63 : 0]  txctrl1_in,

    output [511 : 0] rxdata_out,
    output [63 : 0]  rxctrl0_out,
    output [63 : 0]  rxctrl1_out,
    input             sys_reset,
    input             init_clk

);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
  wire [3 :0]     gthrxn_int;
  assign gthrxn_int      = gt_rxn_in;

  wire [3 :0]      gthrxp_int;
  assign gthrxp_int      = gt_rxp_in;

  wire [3 :0]      gthtxn_int;
  assign gt_txn_out      = gthtxn_int;

  wire [3 :0]      gthtxp_int;
  assign gt_txp_out      = gthtxp_int;

  ////--------------------------------------------------------------------------------------------------------------------
  wire [0:0]      gtwiz_userclk_tx_srcclk_int;

  ////--------------------------------------------------------------------------------------------------------------------
  wire [0:0]      gtwiz_userclk_tx_usrclk_int;

  ////--------------------------------------------------------------------------------------------------------------------
  wire [0:0]      gtwiz_userclk_tx_usrclk2_int;

  ////--------------------------------------------------------------------------------------------------------------------
  wire [0:0]      gtwiz_userclk_rx_usrclk_out;
  wire [0:0]      gtwiz_userclk_rx_srcclk_out;
  wire [0:0]      gtwiz_userclk_rx_usrclk2_out;
  wire [0:0]      gtwiz_userclk_rx_active_in;
  wire [0:0]      cmac_gtwiz_userclk_rx_reset_in;
  wire [0:0]      cmac_gtwiz_userclk_rx_active_out;
  wire [0:0]      gtwiz_userclk_rx_srcclk_int;
  wire [0:0]      gtwiz_userclk_rx_usrclk_int;
  wire [0:0]      gtwiz_userclk_rx_usrclk2_int;

  assign gt_txusrclk2             =  gtwiz_userclk_tx_usrclk2_int[0];
  assign gt_rxusrclk2             =  gtwiz_userclk_rx_usrclk2_int[0];

  assign rx_serdes_clk[0]         =  gt_rxusrclk2;
  assign rx_serdes_clk[1]         =  gt_rxusrclk2;
  assign rx_serdes_clk[2]         =  gt_rxusrclk2;
  assign rx_serdes_clk[3]         =  gt_rxusrclk2;
  assign rx_serdes_clk[4]         =  1'b0;
  assign rx_serdes_clk[5]         =  1'b0;
  assign rx_serdes_clk[6]         =  1'b0;
  assign rx_serdes_clk[7]         =  1'b0;
  assign rx_serdes_clk[8]         =  1'b0;
  assign rx_serdes_clk[9]         =  1'b0;


  wire [0 : 0]    gtwiz_userclk_tx_active_in;
  wire [3 : 0]    txusrclk_in;
  wire [3 : 0]    txusrclk2_in;
  wire [3 : 0]    rxusrclk_in;
  wire [3 : 0]    rxusrclk2_in;
  wire [0 : 0]    gtwiz_userclk_tx_reset_in;
  wire [0 : 0]    gtwiz_userclk_tx_srcclk_out;
  wire [0 : 0]    gtwiz_userclk_tx_usrclk_out;
  wire [0 : 0]    gtwiz_userclk_tx_usrclk2_out;
  wire [0 : 0]    gtwiz_userclk_rx_reset_in;
  wire [0 : 0]    gtwiz_reset_clk_freerun_in;
  wire [0 : 0]    gtwiz_reset_all_in;
  wire [0 : 0]    gtwiz_reset_tx_pll_and_datapath_in;
  wire [0 : 0]    gtwiz_reset_tx_datapath_in;
  wire [0 : 0]    gtwiz_reset_rx_pll_and_datapath_in;
  wire [0 : 0]    gtwiz_reset_rx_datapath_in;
  wire [0 : 0]    gtwiz_reset_rx_data_good_in;
  wire [0 : 0]    gtwiz_reset_rx_cdr_stable_out;
  wire [0 : 0]    gtwiz_reset_tx_done_out;
  wire [0 : 0]    gtwiz_reset_rx_done_out;

  wire [3 :0]     gtyrxn_in;
  wire [3 :0]     gtyrxp_in;
  wire [11 :0]    loopback_in;
  wire [3 :0]     rxrecclkout_out;
  //wire [319 :0]   gtwiz_userdata_tx_in;
      
  wire [3 :0]     gtytxn_out;
  wire [3 :0]     gtytxp_out;
  wire [3 :0]     gtpowergood_out;
  //wire [319 :0]   gtwiz_userdata_rx_out;
  wire [3 :0]     rxpmaresetdone_out;
  wire [3 :0]     txprgdivresetdone_out;
  wire [3 :0]     txpmaresetdone_out;
  wire [3 :0]     rxcdrhold_in;
  wire [3 :0]     rxdfelfhold_in;

  ////assign inputs to GT
  assign gtwiz_userclk_tx_reset_in              = 1'b0;
  assign gtwiz_userclk_rx_reset_in              = 1'b0;
  assign gtwiz_reset_clk_freerun_in[0]          = init_clk;

  assign rxcdrhold_in   = gt_rxcdrhold;
  assign rxdfelfhold_in = 3'b0;
  assign gtwiz_reset_all_in[0]                  = sys_reset;
  assign gtwiz_reset_tx_pll_and_datapath_in     = 1'b0;
  assign gtwiz_reset_rx_pll_and_datapath_in     = 1'b0;
  assign gtwiz_reset_tx_datapath_in             = gtwiz_reset_tx_datapath;
  assign gtwiz_reset_rx_datapath_in             = gtwiz_reset_rx_datapath;
  assign gtwiz_reset_rx_data_good_in            = 1'b1;

  assign gtyrxn_in                              = gthrxn_int;
  assign gtyrxp_in                              = gthrxp_int;
  assign loopback_in                            = gt_loopback_in;
  assign gt_rxrecclkout                         = rxrecclkout_out;


  ////outputs from GT
  assign gthtxn_int                             = gtytxn_out;
  assign gthtxp_int                             = gtytxp_out;
  assign gtwiz_userclk_tx_srcclk_int            = gtwiz_userclk_tx_srcclk_out;
  assign gtwiz_userclk_tx_usrclk_int            = gtwiz_userclk_tx_usrclk_out;
  assign gtwiz_userclk_tx_usrclk2_int           = gtwiz_userclk_tx_usrclk2_out;
  assign gtwiz_userclk_rx_srcclk_int            = gtwiz_userclk_rx_srcclk_out;
  assign gtwiz_userclk_rx_usrclk_int            = gtwiz_userclk_rx_usrclk_out;
  assign gtwiz_userclk_rx_usrclk2_int           = gtwiz_userclk_rx_usrclk2_out;
  assign gt_reset_tx_done_out                   = gtwiz_reset_tx_done_out[0];
  assign gt_reset_rx_done_out                   = gtwiz_reset_rx_done_out[0];
  assign gt_powergoodout                        = gtpowergood_out;

  //// ===================================================================================================================
  //// TX/RX USER CLOCKING Helper block integration
  //// ===================================================================================================================

  wire [0 : 0] cmac_gtwiz_userclk_tx_reset_in;
  wire [0 : 0] cmac_gtwiz_userclk_tx_active_out;

  wire [3 :0] txoutclk_out;
  wire [3 :0] rxoutclk_out;

  //// ===================================================================================================================
  //// USER CLOCKING RESETS
  //// ===================================================================================================================

  //// The TX user clocking helper block should be held in reset until the clock source of that block is known to be
  //// stable. The following assignment is an example of how that stability can be determined, based on the selected TX
  //// user clock source. Replace the assignment with the appropriate signal or logic to achieve that behavior as needed.

  assign cmac_gtwiz_userclk_tx_reset_in = ~((&txprgdivresetdone_out) & (&txpmaresetdone_out));

  //// The RX user clocking helper block should be held in reset until the clock source of that block is known to be
  //// stable. The following assignment is an example of how that stability can be determined, based on the selected RX
  //// user clock source. Replace the assignment with the appropriate signal or logic to achieve that behavior as needed.
  //// Note that, if the clock source is derived from the received data, this is indicated by a combination of the
  //// appropriate reset done signal and the reset helper block's RX CDR stable indicator.

  //// ===================================================================================================================
  //// USER CLOCKING Source clocks
  //// ===================================================================================================================
  //// Generate a single module instance which is driven by a clock source associated with the master transmitter channel,
  //// and which drives TXUSRCLK and TXUSRCLK2 for all channels

  //// The source clock is TXOUTCLK from the master transmitter channel

  assign gtwiz_userclk_tx_srcclk_out = txoutclk_out[0];

  //// Generate a single module instance which is driven by a clock source associated with the master receiver channel,
  //// and which drives RXUSRCLK and RXUSRCLK2 for all channels

  //// The source clock is RXOUTCLK from the master receiver channel

  assign gtwiz_userclk_rx_srcclk_out = rxoutclk_out[0];
  assign cmac_gtwiz_userclk_rx_reset_in = ~(&rxpmaresetdone_out);

  //// Multi_Lane GT Buffer Bypass Mode  
  //// Instantiate a single instance of the transmitter user clocking network helper block
  cmac_usplus_0_ultrascale_tx_userclk #(
    .P_CONTENTS                     (0),
    .P_FREQ_RATIO_SOURCE_TO_USRCLK  (1),
    .P_FREQ_RATIO_USRCLK_TO_USRCLK2 (1)
  ) cmac_gtwiz_userclk_tx_inst (
    .gtwiz_userclk_tx_srcclk_in   (gtwiz_userclk_tx_srcclk_out),
    .gtwiz_userclk_tx_reset_in    (cmac_gtwiz_userclk_tx_reset_in),
    .gtwiz_userclk_tx_usrclk_out  (gtwiz_userclk_tx_usrclk_out),
    .gtwiz_userclk_tx_usrclk2_out (gtwiz_userclk_tx_usrclk2_out),
    .gtwiz_userclk_tx_active_out  (cmac_gtwiz_userclk_tx_active_out)
  );

  //// Instantiate a single instance of the receiver user clocking network helper block
  cmac_usplus_0_ultrascale_rx_userclk #(
    .P_CONTENTS                     (0),
    .P_FREQ_RATIO_SOURCE_TO_USRCLK  (1),
    .P_FREQ_RATIO_USRCLK_TO_USRCLK2 (1)
  ) cmac_gtwiz_userclk_rx_inst (
    .gtwiz_userclk_rx_srcclk_in   (gtwiz_userclk_rx_srcclk_out),
    .gtwiz_userclk_rx_reset_in    (cmac_gtwiz_userclk_rx_reset_in),
    .gtwiz_userclk_rx_usrclk_out  (gtwiz_userclk_rx_usrclk_out),
    .gtwiz_userclk_rx_usrclk2_out (gtwiz_userclk_rx_usrclk2_out),
    .gtwiz_userclk_rx_active_out  (cmac_gtwiz_userclk_rx_active_out)
  );

  assign gtwiz_userclk_tx_active_in    = cmac_gtwiz_userclk_tx_active_out;

  //// Drive TXUSRCLK and TXUSRCLK2 for all channels with the respective helper block outputs

  assign txusrclk_in  = {4{gtwiz_userclk_tx_usrclk_out}};
  assign txusrclk2_in = {4{gtwiz_userclk_tx_usrclk2_out}};

  assign gtwiz_userclk_rx_active_in    = cmac_gtwiz_userclk_rx_active_out;

  //// Drive RXUSRCLK and RXUSRCLK2 for all channels with the respective helper block outputs

  assign rxusrclk_in  = {4{gtwiz_userclk_rx_usrclk_out}};
  assign rxusrclk2_in = {4{gtwiz_userclk_rx_usrclk2_out}};

  wire  [3 :0] eyescanreset_in;
  wire  [3 :0] eyescantrigger_in;
  wire  [3 :0] rxpolarity_in;
  wire  [11 :0] rxrate_in;
  wire  [3 :0] txpolarity_in;
  wire  [3 :0] txinhibit_in;
  wire  [19 :0] txpostcursor_in;
  wire  [3 :0] txprbsforceerr_in;
  wire  [19 :0] txprecursor_in;
  wire  [3 :0] eyescandataerror_out;
  wire  [7 :0] txbufstatus_out;

  wire  [3 :0] rxdfelpmreset_in;     
  wire  [3 :0] rxlpmen_in;
  wire  [3 :0] rxprbscntreset_in;
  wire  [3 :0] rxprbserr_out;
  wire  [15 :0]  rxprbssel_in;
  wire  [3 :0] rxresetdone_out;
  wire  [15 :0] txprbssel_in;
  wire  [3 :0]  txresetdone_out;   

  wire [19 :0] txdiffctrl_in;
  wire [11 :0] rxbufstatus_out;

  wire [39 :0] drpaddr_in;
  wire [63 :0] drpdi_in;
  wire [3 :0] drpen_in;
  wire [3 :0] drpwe_in;
  wire [3 :0] drpclk_in;
  wire [63 :0] drpdo_out;
  wire [3 :0] drprdy_out;

  assign gt_rxbufstatus       = rxbufstatus_out;
  assign rxdfelpmreset_in     = gt_rxdfelpmreset;
  assign rxlpmen_in           = gt_rxlpmen;
  assign rxprbscntreset_in    = gt_rxprbscntreset;
  assign gt_rxprbserr         = rxprbserr_out;
  assign rxprbssel_in         = gt_rxprbssel;
  assign gt_rxresetdone       = rxresetdone_out;
  assign txprbssel_in         = gt_txprbssel;
  assign gt_txresetdone       = txresetdone_out;

  assign eyescanreset_in      = gt_eyescanreset;
  assign eyescantrigger_in    = gt_eyescantrigger;
  assign rxpolarity_in        = gt_rxpolarity;
  assign rxrate_in            = gt_rxrate;
  assign txdiffctrl_in        = gt_txdiffctrl;
  assign txpolarity_in        = gt_txpolarity;
  assign txinhibit_in         = gt_txinhibit;
  assign txpostcursor_in      = gt_txpostcursor;
  assign txprbsforceerr_in    = gt_txprbsforceerr;
  assign txprecursor_in       = gt_txprecursor;
  assign gt_eyescandataerror  = eyescandataerror_out;
  assign gt_txbufstatus       = txbufstatus_out;

  assign drpaddr_in[9 : 0]  = gt0_drpaddr;
  assign drpdi_in[15 : 0]  = gt0_drpdi;
  assign gt0_drpdo           = drpdo_out[15 : 0];
  assign drpen_in[0]         = gt0_drpen;
  assign gt0_drprdy          = drprdy_out[0];
  assign drpwe_in[0]         = gt0_drpwe;
  assign drpclk_in[0]        = gt_drpclk;
  assign drpaddr_in[19 : 10]  = gt1_drpaddr;
  assign drpdi_in[31 : 16]  = gt1_drpdi;
  assign gt1_drpdo           = drpdo_out[31 : 16];
  assign drpen_in[1]         = gt1_drpen;
  assign gt1_drprdy          = drprdy_out[1];
  assign drpwe_in[1]         = gt1_drpwe;
  assign drpclk_in[1]        = gt_drpclk;
  assign drpaddr_in[29 : 20]  = gt2_drpaddr;
  assign drpdi_in[47 : 32]  = gt2_drpdi;
  assign gt2_drpdo           = drpdo_out[47 : 32];
  assign drpen_in[2]         = gt2_drpen;
  assign gt2_drprdy          = drprdy_out[2];
  assign drpwe_in[2]         = gt2_drpwe;
  assign drpclk_in[2]        = gt_drpclk;
  assign drpaddr_in[39 : 30]  = gt3_drpaddr;
  assign drpdi_in[63 : 48]  = gt3_drpdi;
  assign gt3_drpdo           = drpdo_out[63 : 48];
  assign drpen_in[3]         = gt3_drpen;
  assign gt3_drprdy          = drprdy_out[3];
  assign drpwe_in[3]         = gt3_drpwe;
  assign drpclk_in[3]        = gt_drpclk;


 cmac_usplus_0_gt i_cmac_usplus_0_gt
  (
   .drpaddr_in(drpaddr_in),
   .drpclk_in(drpclk_in),
   .drpdi_in(drpdi_in),
   .drpdo_out(drpdo_out),
   .drpen_in(drpen_in),
   .drprdy_out(drprdy_out),
   .drpwe_in(drpwe_in),
   .eyescandataerror_out(eyescandataerror_out),
   .eyescanreset_in(eyescanreset_in),
   .eyescantrigger_in(eyescantrigger_in),
   .gtpowergood_out(gtpowergood_out),
   .gtwiz_reset_all_in(gtwiz_reset_all_in),
   .gtwiz_reset_clk_freerun_in(gtwiz_reset_clk_freerun_in),
   .gtwiz_reset_qpll0lock_in(gtwiz_reset_qpll0lock_in),
   .gtwiz_reset_qpll0reset_out(gtwiz_reset_qpll0reset_out),
   .gtwiz_reset_rx_cdr_stable_out(gtwiz_reset_rx_cdr_stable_out),
   .gtwiz_reset_rx_datapath_in(gtwiz_reset_rx_datapath_in),
   .gtwiz_reset_rx_done_out(gtwiz_reset_rx_done_out),
   .gtwiz_reset_rx_pll_and_datapath_in(gtwiz_reset_rx_pll_and_datapath_in),
   .gtwiz_reset_tx_datapath_in(gtwiz_reset_tx_datapath_in),
   .gtwiz_reset_tx_done_out(gtwiz_reset_tx_done_out),
   .gtwiz_reset_tx_pll_and_datapath_in(gtwiz_reset_tx_pll_and_datapath_in),
   .gtwiz_userclk_rx_active_in(gtwiz_userclk_rx_active_in),
   .gtwiz_userclk_tx_active_in(gtwiz_userclk_tx_active_in),
   .rxctrl0_out(rxctrl0_out),
   .rxctrl1_out(rxctrl1_out),
   .rxdata_out(rxdata_out),

   .txctrl0_in(txctrl0_in),
   .txctrl1_in(txctrl1_in),
   .txdata_in(txdata_in),
   .gtyrxn_in(gtyrxn_in),
   .gtyrxp_in(gtyrxp_in),
   .gtytxn_out(gtytxn_out),
   .gtytxp_out(gtytxp_out),
   .loopback_in(loopback_in),
   .qpll0clk_in(qpll0clk_in),
   .qpll0refclk_in(qpll0refclk_in),
   .qpll1clk_in(qpll1clk_in),
   .qpll1refclk_in(qpll1refclk_in),
   .rxbufstatus_out(rxbufstatus_out),
   .rxcdrhold_in(rxcdrhold_in),
   .rxdfelfhold_in(rxdfelfhold_in),
   .rxdfelpmreset_in(rxdfelpmreset_in),
   .rxlpmen_in(rxlpmen_in),
   .rxoutclk_out(rxoutclk_out),
   .rxpmaresetdone_out(rxpmaresetdone_out),
   .rxpolarity_in(rxpolarity_in),
   .rxprbscntreset_in(rxprbscntreset_in),
   .rxprbserr_out(rxprbserr_out),
   .rxprbssel_in(rxprbssel_in),
   .rxrate_in(rxrate_in),
   .rxrecclkout_out(rxrecclkout_out),
   .rxresetdone_out(rxresetdone_out),
   .rxusrclk2_in(rxusrclk2_in),
   .rxusrclk_in(rxusrclk_in),
   .txbufstatus_out(txbufstatus_out),
   .txdiffctrl_in(txdiffctrl_in),
   .txoutclk_out(txoutclk_out),
   .txpmaresetdone_out(txpmaresetdone_out),
   .txpolarity_in(txpolarity_in),
   .txinhibit_in(txinhibit_in),
   .txpostcursor_in(txpostcursor_in),
   .txprbsforceerr_in(txprbsforceerr_in),
   .txprbssel_in(txprbssel_in),
   .txprecursor_in(txprecursor_in),
   .txprgdivresetdone_out(txprgdivresetdone_out),
   .txresetdone_out(txresetdone_out),
   .txusrclk2_in(txusrclk2_in),
   .txusrclk_in(txusrclk_in)
  );

endmodule


