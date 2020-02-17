//-----------------------------------------------------------------------------
// Title      : Core Support level wrapper
// Project    : 10GBASE-R
//-----------------------------------------------------------------------------
// File       : ten_gig_eth_pcs_pma_6_support.v
//-----------------------------------------------------------------------------
// Description: This file is a wrapper for the 10GBASE-R/KR Core Support level
// It contains the block level for the core which a user would instance in
// their own design, along with various modules which can be shared between
// several block levels.
//-----------------------------------------------------------------------------
// (c) Copyright 2009 - 2014 Xilinx, Inc. All rights reserved.
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

`timescale 1ps / 1ps

(* DowngradeIPIdentifiedWarnings="yes" *)
module ten_gig_eth_pcs_pma_6_support
  (
  input           refclk_p,
  input           refclk_n,
  input           dclk,
  output          coreclk_out,
  input           reset,
  input           sim_speedup_control,
  output          qpll0outclk_out,
  output          qpll0outrefclk_out,
  output          qpll0lock_out,
  output          areset_datapathclk_out,
  output          areset_coreclk_out,
  output          txusrclk_out,
  output          txusrclk2_out,
  output          gttxreset_out,
  output          gtrxreset_out,
  output          txuserrdy_out,
  output          rxrecclk_out,
  output          reset_counter_done_out,
  input  [63 : 0] xgmii_txd,
  input  [7 : 0]  xgmii_txc,
  output [63 : 0] xgmii_rxd,
  output [7 : 0]  xgmii_rxc,
  output          txp,
  output          txn,
  input           rxp,
  input           rxn,
  input [535:0]   configuration_vector,
  output [447:0]  status_vector,
  output [7:0]    core_status,
  output          resetdone_out,
  input           signal_detect,
  input           tx_fault,
  input [2:0]     pma_pmd_type,
  output          tx_disable);

  // Signal declarations
  wire coreclk;
  wire txoutclk;
  wire rxrecclk_out_int;
  wire qpll0outclk;
  wire qpll0outrefclk;
  wire qpll0lock;
  wire qpll0reset;
  wire reset_tx_bufg_gt;
  wire drp_gnt;
  wire drp_req;
  wire          core_to_gt_drpen;
  wire          core_to_gt_drpwe;
  wire [15 : 0] core_to_gt_drpaddr;
  wire [15 : 0] core_to_gt_drpdi;
  wire          gt_drprdy;
  wire [15 : 0] gt_drpdo;
  wire          gt_drpen;
  wire          gt_drpwe;
  wire [15 : 0] gt_drpaddr;
  wire [15 : 0] gt_drpdi;
  wire          core_to_gt_drprdy;
  wire [15 : 0] core_to_gt_drpdo;

  wire tx_resetdone_int;
  wire rx_resetdone_int;

  wire areset_coreclk;
  wire gttxreset;
  wire gtrxreset;
  wire qpllreset;
  wire txuserrdy;
  wire reset_counter_done;

  wire txusrclk;
  wire txusrclk2;
  wire areset_txusrclk2;
  wire refclk;

  assign coreclk_out = coreclk;
  assign resetdone_out = tx_resetdone_int && rx_resetdone_int;

  // If no arbitration is required on the GT DRP ports then connect REQ to GNT
  // and connect other signals core_to_gt_drp* <=> gt_drp*;
  assign drp_gnt = drp_req;
  assign gt_drpen = core_to_gt_drpen;
  assign gt_drpwe = core_to_gt_drpwe;
  assign gt_drpaddr = core_to_gt_drpaddr;
  assign gt_drpdi = core_to_gt_drpdi;
  assign core_to_gt_drprdy = gt_drprdy;
  assign core_to_gt_drpdo = gt_drpdo;
  assign qpll0outclk_out = qpll0outclk;
  assign qpll0outrefclk_out = qpll0outrefclk;
  assign qpll0lock_out = qpll0lock;
  assign txusrclk_out = txusrclk;
  assign txusrclk2_out = txusrclk2;
  assign areset_datapathclk_out = areset_txusrclk2;
  assign areset_coreclk_out = areset_coreclk;
  assign gttxreset_out = gttxreset;
  assign gtrxreset_out = gtrxreset;
  assign txuserrdy_out = txuserrdy;
  assign reset_counter_done_out = reset_counter_done;

  // Instantiate the 10GBASER/KR GT Common block
  ten_gig_eth_pcs_pma_6_gt_common # (
      .WRAPPER_SIM_GTRESET_SPEEDUP("TRUE") ) //Does not affect hardware
  ten_gig_eth_pcs_pma_gt_common_block
    (
     .refclk(refclk),
     .qpllreset(qpllreset),
     .qpll0lock(qpll0lock),
     .qpll0outclk(qpll0outclk),
     .qpll0outrefclk(qpll0outrefclk)
    );

  
  // Instantiate the 10GBASER/KR shared clock/reset block

  ten_gig_eth_pcs_pma_6_shared_clock_and_reset ten_gig_eth_pcs_pma_shared_clock_reset_block
    (
     .areset(reset),
     .refclk_p(refclk_p),
     .refclk_n(refclk_n),
     .qpll0reset(qpll0reset),
     .refclk(refclk),
     .coreclk(coreclk),
     .txoutclk(txoutclk),
     .qplllock(qpll0lock),
     .reset_tx_bufg_gt(reset_tx_bufg_gt),
     .areset_coreclk(areset_coreclk),
     .areset_txusrclk2(areset_txusrclk2),
     .gttxreset(gttxreset),
     .gtrxreset(gtrxreset),
     .txuserrdy(txuserrdy),
     .txusrclk(txusrclk),
     .txusrclk2(txusrclk2),
     .qpllreset(qpllreset),
     .reset_counter_done(reset_counter_done)
    );

  // Instantiate the 10GBASER/KR Block Level

  ten_gig_eth_pcs_pma_6 ten_gig_eth_pcs_pma_i
    (
      .coreclk(coreclk),
      .dclk(dclk),
      .txusrclk(txusrclk),
      .txusrclk2(txusrclk2),
      .txoutclk(txoutclk),
      .areset_coreclk(areset_coreclk),
      .txuserrdy(txuserrdy),
      .rxrecclk_out(rxrecclk_out),
     .areset(reset),
      .gttxreset(gttxreset),
      .gtrxreset(gtrxreset),
     .sim_speedup_control(sim_speedup_control),
      .qpll0lock(qpll0lock),
      .qpll0outclk(qpll0outclk),
      .qpll0outrefclk(qpll0outrefclk),
      .qpll0reset(qpll0reset),
      .reset_tx_bufg_gt(reset_tx_bufg_gt),
      .reset_counter_done(reset_counter_done),
      .xgmii_txd(xgmii_txd),
      .xgmii_txc(xgmii_txc),
      .xgmii_rxd(xgmii_rxd),
      .xgmii_rxc(xgmii_rxc),
      .txp(txp),
      .txn(txn),
      .rxp(rxp),
      .rxn(rxn),
      .configuration_vector(configuration_vector),
      .status_vector(status_vector),
      .core_status(core_status),
      .tx_resetdone(tx_resetdone_int),
      .rx_resetdone(rx_resetdone_int),
      .signal_detect(signal_detect),
      .tx_fault(tx_fault),
      .drp_req(drp_req),
      .drp_gnt(drp_gnt),
      .core_to_gt_drpen(core_to_gt_drpen),
      .core_to_gt_drpwe(core_to_gt_drpwe),
      .core_to_gt_drpaddr(core_to_gt_drpaddr),
      .core_to_gt_drpdi(core_to_gt_drpdi),
      .gt_drprdy(gt_drprdy),
      .gt_drpdo(gt_drpdo),
      .gt_drpen(gt_drpen),
      .gt_drpwe(gt_drpwe),
      .gt_drpaddr(gt_drpaddr),
      .gt_drpdi(gt_drpdi),
      .core_to_gt_drprdy(core_to_gt_drprdy),
      .core_to_gt_drpdo(core_to_gt_drpdo),
      .pma_pmd_type(pma_pmd_type),
      .tx_disable(tx_disable)
      );

endmodule
