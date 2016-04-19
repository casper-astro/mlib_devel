//-----------------------------------------------------------------------------
// Title      : Core Support level wrapper
// Project    : 10GBASE-R
//-----------------------------------------------------------------------------
// File       : ten_gig_pcs_pma_5_support.v
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

`timescale 1ns / 1ps

(* DowngradeIPIdentifiedWarnings="yes" *)
module tengbaser_support #(
  parameter USE_GTH ="FALSE"
  )(
  input           refclk_p,
  input           refclk_n,
  output          core_clk156_out,
  output          dclk,
  input           txclk322,
  input           reset,
  output          qplloutclk_out,
  output          qplloutrefclk_out,
  output          qplllock_out,
  output          qpllreset,
  output          areset_clk156_out,
  output          txusrclk_out,
  output          txusrclk2_out,
  output          gttxreset_out,
  output          gtrxreset_out,
  output          txuserrdy_out,
  output          reset_counter_done_out
  );

  // Signal declarations
  wire clk156;
  wire qplloutclk;
  wire qplloutrefclk;
  wire qplllock;
  wire drp_gnt;
  wire drp_req;
  wire drp_den_o;
  wire drp_dwe_o;
  wire [15 : 0] drp_daddr_o;
  wire [15 : 0] drp_di_o;
  wire drp_drdy_o;
  wire [15 : 0] drp_drpdo_o;
  wire drp_den_i;
  wire drp_dwe_i;
  wire [15 : 0] drp_daddr_i;
  wire [15 : 0] drp_di_i;
  wire drp_drdy_i;
  wire [15 : 0] drp_drpdo_i;

  wire tx_resetdone_int;
  wire rx_resetdone_int;

  wire areset_clk156;
  wire gttxreset;
  wire gtrxreset;
  wire qpllreset_int;
  assign qpllreset = qpllreset_int;
  wire txuserrdy;
  wire reset_counter_done;

  wire txusrclk;
  wire txusrclk2;

  assign core_clk156_out = clk156;

  // If no arbitration is required on the GT DRP ports then connect REQ to GNT
  // and connect other signals i <= o;
  assign drp_gnt = drp_req;
  assign drp_den_i = drp_den_o;
  assign drp_dwe_i = drp_dwe_o;
  assign drp_daddr_i = drp_daddr_o;
  assign drp_di_i = drp_di_o;
  assign drp_drdy_i = drp_drdy_o;
  assign drp_drpdo_i = drp_drpdo_o;
  assign qplloutclk_out = qplloutclk;
  assign qplloutrefclk_out = qplloutrefclk;
  assign qplllock_out = qplllock;
  assign txusrclk_out = txusrclk;
  assign txusrclk2_out = txusrclk2;
  assign areset_clk156_out = areset_clk156;
  assign gttxreset_out = gttxreset;
  assign gtrxreset_out = gtrxreset;
  assign txuserrdy_out = txuserrdy;
  assign reset_counter_done_out = reset_counter_done;

  // Instantiate the 10GBASER/KR GT Common block
  ten_gig_pcs_pma_5_gt_common # (
      .WRAPPER_SIM_GTRESET_SPEEDUP("TRUE"), //Does not affect hardware
      .USE_GTH(USE_GTH)                     //Else use GTX
    ) ten_gig_eth_pcs_pma_gt_common_block (
     .refclk(refclk),
     .qpllreset(qpllreset_int),
     .qplllock(qplllock),
     .qplloutclk(qplloutclk),
     .qplloutrefclk(qplloutrefclk)
    );

  // Instantiate the 10GBASER/KR shared clock/reset block

  ten_gig_pcs_pma_5_shared_clock_and_reset ten_gig_eth_pcs_pma_shared_clock_reset_block
    (
     .areset(reset),
     .refclk_p(refclk_p),
     .refclk_n(refclk_n),
     .refclk(refclk),
     .refclk_bufh(refclk_bufh),
     .clk156(clk156),
     .dclk(dclk),
     .txclk322(txclk322),
     .qplllock(qplllock),
     .areset_clk156(areset_clk156),
     .gttxreset(gttxreset),
     .gtrxreset(gtrxreset),
     .txuserrdy(txuserrdy),
     .txusrclk(txusrclk),
     .txusrclk2(txusrclk2),
     .qpllreset(qpllreset_int),
     .reset_counter_done(reset_counter_done)
    );

endmodule

