//----------------------------------------------------------------------------
// Title      : Verilog component declaration for block level XAUI
// Project    : 10 Gigabit Ethernet XAUI Core
// File       : xaui_mod.v
// Author     : Xilinx Inc.
// Description: This module holds the block level component declaration for the
//              10Gb/E XAUI core.
//---------------------------------------------------------------------------
// (c) Copyright 2003 - 2009 Xilinx, Inc. All rights reserved. 
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
module xaui_v9_1
(
   reset,
   xgmii_txd,
   xgmii_txc,
   xgmii_rxd,
   xgmii_rxc,
   usrclk,
   mgt_txdata,
   mgt_txcharisk,
   mgt_rxdata,
   mgt_rxcharisk,
   mgt_codevalid,
   mgt_codecomma,
   mgt_enable_align,
   mgt_enchansync,
   mgt_syncok,
   mgt_rxlock,
   mgt_loopback,
   mgt_powerdown,
   mgt_tx_reset,
   mgt_rx_reset,
   signal_detect,
   align_status,
   sync_status,
   configuration_vector,
   status_vector);

   // Port declarations
   input           reset;
   input  [63 : 0] xgmii_txd;
   input  [7 : 0]  xgmii_txc;
   output [63 : 0] xgmii_rxd;
   output [7 : 0]  xgmii_rxc;
   input           usrclk;
   output [63:0]   mgt_txdata;
   output [ 7:0]   mgt_txcharisk;
   input  [63:0]   mgt_rxdata;
   input  [ 7:0]   mgt_rxcharisk;
   input  [ 7:0]   mgt_codevalid;
   input  [ 7:0]   mgt_codecomma;
   output [ 3:0]   mgt_enable_align;
   output          mgt_enchansync;
   input  [ 3:0]   mgt_syncok;
   input  [ 3:0]   mgt_rxlock;
   output          mgt_loopback;
   output          mgt_powerdown;
   input  [ 3:0]   mgt_tx_reset;
   input  [ 3:0]   mgt_rx_reset;
   input  [3 : 0]  signal_detect;
   output          align_status;
   output [3 : 0]  sync_status;
   input  [6 : 0]  configuration_vector;
   output [7 : 0]  status_vector;

endmodule
