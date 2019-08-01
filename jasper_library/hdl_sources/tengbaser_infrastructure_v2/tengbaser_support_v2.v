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
module tengbaser_support_v2
  (
  input           refclk_p,
  input           refclk_n,
  input           reset,
  output          coreclk,
  output          qplloutclk_out,
  output          qplloutrefclk_out,
  output          qplllock_out,
  output          areset_datapathclk_out,
  output          areset_coreclk_out,
  output          txusrclk_out,
  output          txusrclk2_out,
  output          gttxreset_out,
  output          gtrxreset_out,
  output          txuserrdy_out,
  output          reset_counter_done_out,
  input           txclk322,
  output          qpllreset);

  // Signal declarations
  wire qplloutclk;
  wire qplloutrefclk;
  wire qplllock;
  wire reset_tx_bufg_gt;

  wire areset_coreclk;
  wire gttxreset;
  wire gtrxreset;
//  wire qpllreset;
  wire txuserrdy;
  wire reset_counter_done;

  wire txusrclk;
  wire txusrclk2;
  wire areset_txusrclk2;
  wire refclk;

  // If no arbitration is required on the GT DRP ports then connect REQ to GNT
  // and connect other signals core_to_gt_drp* <=> gt_drp*;
  assign qplloutclk_out = qplloutclk;
  assign qplloutrefclk_out = qplloutrefclk;
  assign qplllock_out = qplllock;
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
     .qpll0lock(qplllock),
     .qpll0outclk(qplloutclk),
     .qpll0outrefclk(qplloutrefclk)
    );

  
  // Instantiate the 10GBASER/KR shared clock/reset block

  ten_gig_eth_pcs_pma_6_shared_clock_and_reset ten_gig_eth_pcs_pma_shared_clock_reset_block
    (
     .areset(reset),
     .refclk_p(refclk_p),
     .refclk_n(refclk_n),
     .refclk(refclk),
     .coreclk(coreclk),
     .txoutclk(txclk322),
     .qplllock(qplllock),
//     .reset_tx_bufg_gt(reset_tx_bufg_gt),
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

endmodule
