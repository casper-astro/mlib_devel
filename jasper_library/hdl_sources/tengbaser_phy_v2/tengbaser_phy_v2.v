//-----------------------------------------------------------------------------
// Title      : Example Design level wrapper
// Project    : 10GBASE-R
//-----------------------------------------------------------------------------
// File       : ten_gig_eth_pcs_pma_6_example_design.v
//-----------------------------------------------------------------------------
// Description: This file is a wrapper for the 10GBASE-R core; it contains the
// core support level and a few registers, including a DDR output register
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

module tengbaser_phy_v2
  (
  input           dclk,
  input           clk156,
  input           txusrclk,
  input           txusrclk2,
  output          txclk322,
  input           areset,
  input           areset_clk156,
  input           gttxreset,
  input           gtrxreset,
  //input           sim_speedup_control,
  input           txuserrdy,
  input           qplllock,
  input           qplloutclk,
  input           qplloutrefclk,
  input           reset_counter_done,
  input  [63 : 0] xgmii_txd,
  input  [7 : 0]  xgmii_txc,
  output reg [63 : 0] xgmii_rxd = 64'b0,
  output reg [7 : 0]  xgmii_rxc = 8'b0,
  output          txp,
  output          txn,
  input           rxp,
  input           rxn,
  output [7:0]    core_status,
  output          resetdone,
  input           signal_detect,
  input           tx_fault,
  output          tx_disable,
  input   [2:0] pma_pmd_type,
  input  [535 : 0] configuration_vector,
  output [447 : 0]  status_vector);

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
  assign resetdone = tx_resetdone_int && rx_resetdone_int;

  assign drp_gnt = drp_req;
  assign gt_drpen = core_to_gt_drpen;
  assign gt_drpwe = core_to_gt_drpwe;
  assign gt_drpaddr = core_to_gt_drpaddr;
  assign gt_drpdi = core_to_gt_drpdi;
  assign core_to_gt_drprdy = gt_drprdy;
  assign core_to_gt_drpdo = gt_drpdo;
  
  reg [63:0] xgmii_txd_reg = 63'b0;
  reg [7:0] xgmii_txc_reg = 8'b0;
  wire [63:0] xgmii_rxd_int;
  wire [7:0] xgmii_rxc_int;


  // Add a pipeline to the xmgii_tx inputs, to aid timing closure
  always @(posedge txusrclk2)
  begin
    xgmii_txd_reg <= xgmii_txd;
    xgmii_txc_reg <= xgmii_txc;
  end

  // Add a pipeline to the xmgii_rx outputs, to aid timing closure
  always @(posedge txusrclk2)
  begin
    xgmii_rxd <= xgmii_rxd_int;
    xgmii_rxc <= xgmii_rxc_int;
  end



//  BUFG dclk_bufg_i
//  (
//      .I (dclk),
//      .O (dclk_buf)
//  );

  // Instantiate the 10GBASE-R Block Level

  ten_gig_eth_pcs_pma_6 ten_gig_eth_pcs_pma_i
    (
      .coreclk(clk156),
      .dclk(dclk),
      .txusrclk(txusrclk),
      .txusrclk2(txusrclk2),
      .txoutclk(txclk322),
      .areset_coreclk(areset_clk156),
      .txuserrdy(txuserrdy),
      .rxrecclk_out(),
     .areset(areset),
      .gttxreset(gttxreset),
      .gtrxreset(gtrxreset),
     .sim_speedup_control(1'b0),
      .qpll0lock(qplllock),
      .qpll0outclk(qplloutclk),
      .qpll0outrefclk(qplloutrefclk),
      .qpll0reset(),
      .reset_tx_bufg_gt(),
      .reset_counter_done(reset_counter_done),
      .xgmii_txd(xgmii_txd_reg),
      .xgmii_txc(xgmii_txc_reg),
      .xgmii_rxd(xgmii_rxd_int),
      .xgmii_rxc(xgmii_rxc_int),
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
      .tx_disable(tx_disable),
       .gt_eyescanreset(1'b0),
      .gt_eyescantrigger(1'b0),
      .gt_rxcdrhold(1'b0),
      .gt_txprbsforceerr(1'b0),
      .gt_txpolarity(1'b0),
      .gt_rxpolarity(1'b0),
      .gt_rxrate(3'h0),
      .gt_loopback(3'h0),
      .gt_rxpmareset(1'b0),
      .gt_txpmareset(1'b0),
      .gt_txpcsreset(1'b0),
      .gt_txoutclksel(3'b101),
      .gt_rxdfelpmreset(1'b0),
      .gt_rxpmaresetdone(),
      .gt_txresetdone(),
      .gt_rxresetdone(),
      .gt_txprecursor(5'b0),
      .gt_txpostcursor(5'b10101),
      .gt_txdiffctrl(4'b1100),
      .gt_rxlpmen(1'b0),
      .gt_pcsrsvdin(16'h0),
      .gt_eyescandataerror(),
      .gt_txbufstatus(),
      .gt_rxbufstatus(),
      .gt_rxprbserr(),
      .gt_rxprbslocked(),
      .gt_dmonitorout(),
      .gt_cpllpd(1'b1),
      .gt_txelecidle(1'b0),
      .gt_txpdelecidlemode(1'b0),
      .gt_rxpd(2'h0),
      .gt_txpd(2'h0)
      );
      
endmodule
