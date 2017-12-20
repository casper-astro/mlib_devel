//-----------------------------------------------------------------------------
// Title      : Local clocking and resets                                             
// Project    : 10GBASE-R                                                      
//-----------------------------------------------------------------------------
// File       : ten_gig_pcs_pma_5_local_clock_and_reset.v                                          
//-----------------------------------------------------------------------------
// Description: This file contains the 10GBASE-R clocking 
// and reset logic which cannot be shared between multiple cores                
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

module  ten_gig_pcs_pma_5_local_clock_and_reset 
    (
     input  areset,
     input  clk156,
     input  dclk,
     input  txusrclk,
     input  rxclk322,
     input  sim_speedup_control,
     input  signal_detect,
     input  tx_resetdone,
     input  rx_resetdone,
     input  pma_resetout_rising,
     input  qplllock_rxusrclk2,
     input  gtrxreset,
     output wire clk156_reset_tx,
     output wire txreset322,
     output wire rxreset322,
     output wire dclk_reset,
     output wire areset_rxusrclk2,
     output wire pma_resetout_rising_rxusrclk2,
     output reg rxuserrdy,
     output rxusrclk,
     output rxusrclk2
    );

  wire clk156_reset_rx;
  wire clk156_reset_rx_tmp;
  wire clk156_reset_tx_tmp;
  wire clk156_areset;
  wire dclk_areset;
  wire rx_resetdone_dclk;
  wire signal_detect_dclk;
  wire signal_detect_clk156;
  wire dclk_reset_rx_tmp;
  
  reg [23:0] rxuserrdy_counter = 24'h0;
  // Nominal wait time of 50000 UI = 1563 cyles of 322.26MHz clock
  localparam [23:0] RXRESETTIME_NOM = 24'h00061B; 
  // Maximum wait time of 37x10^6 UI = 1156262 cycles of 322.26MHz clock
  localparam [23:0] RXRESETTIME_MAX = 24'h11A4A6;
  
  // Set this according to requirements
  wire [23:0] RXRESETTIME;

  ten_gig_pcs_pma_5_sim_speedup_controller 
    #(.SYNTH_VALUE(RXRESETTIME_MAX),
      .SIM_VALUE(RXRESETTIME_NOM))
    sim_speedup_controller_inst
     (.clk(clk156),
      .sim_speedup_control(sim_speedup_control),
      .sim_speedup_value(RXRESETTIME));
  
  BUFH rx322clk_bufh_i
  (
      .I (rxclk322),
      .O (rxusrclk)
  );

  assign rxusrclk2 = rxusrclk;
    
  ten_gig_pcs_pma_5_ff_synchronizer_rst 
    #(
      .C_NUM_SYNC_REGS(4),
      .C_RVAL(1'b1)) 
  clk156_areset_sync_i
    (
     .clk(clk156),
     .rst(areset),
     .data_in(1'b0),
     .data_out(clk156_areset)
    );
        
  ten_gig_pcs_pma_5_ff_synchronizer_rst 
    #(
      .C_NUM_SYNC_REGS(4),
      .C_RVAL(1'b1)) 
  dclk_areset_sync_i
    (
     .clk(dclk),
     .rst(areset),
     .data_in(1'b0),
     .data_out(dclk_areset)
    );
        
  assign clk156_reset_tx_tmp = (!(tx_resetdone) || clk156_areset);
  
  // Hold core in reset until everything else is ready...
  ten_gig_pcs_pma_5_ff_synchronizer_rst 
    #(
      .C_NUM_SYNC_REGS(4),
      .C_RVAL(1'b1)) 
  clk156_reset_tx_sync_i
    (
     .clk(clk156),
     .rst(clk156_reset_tx_tmp),
     .data_in(1'b0),
     .data_out(clk156_reset_tx)
    );
        
  // Create the other synchronized resets from the core reset...
    
  ten_gig_pcs_pma_5_ff_synchronizer_rst 
    #(
      .C_NUM_SYNC_REGS(4),
      .C_RVAL(1'b1)) 
  txreset322_sync_i
    (
     .clk(txusrclk),
     .rst(clk156_reset_tx),
     .data_in(1'b0),
     .data_out(txreset322)
    );
        
  ten_gig_pcs_pma_5_ff_synchronizer 
    #(
      .C_NUM_SYNC_REGS(4)) 
  signal_detect_clk156_sync_i
    (
     .clk(clk156),
     .data_in(signal_detect),
     .data_out(signal_detect_clk156)
    );
        
  assign clk156_reset_rx_tmp = (!(rx_resetdone) || clk156_areset || 
                              !(signal_detect_clk156) );

  ten_gig_pcs_pma_5_ff_synchronizer_rst 
    #(
      .C_NUM_SYNC_REGS(4),
      .C_RVAL(1'b1)) 
  clk156_reset_rx_sync_i
    (
     .clk(clk156),
     .rst(clk156_reset_rx_tmp),
     .data_in(1'b0),
     .data_out(clk156_reset_rx)
    );
        
  ten_gig_pcs_pma_5_ff_synchronizer 
    #(
      .C_NUM_SYNC_REGS(4)) 
  rxresetdone_dclk_sync_i
    (
     .clk(dclk),
     .data_in(rx_resetdone),
     .data_out(rx_resetdone_dclk)
    );
        
  ten_gig_pcs_pma_5_ff_synchronizer 
    #(
      .C_NUM_SYNC_REGS(4)) 
  signal_detect_dclk_sync_i
    (
     .clk(dclk),
     .data_in(signal_detect),
     .data_out(signal_detect_dclk)
    );
        
  assign dclk_reset_rx_tmp = (!(rx_resetdone_dclk) || dclk_areset || 
                              !(signal_detect_dclk) );

  ten_gig_pcs_pma_5_ff_synchronizer_rst 
    #(
      .C_NUM_SYNC_REGS(4),
      .C_RVAL(1'b1)) 
  dclk_reset_rx_sync_i
    (
     .clk(dclk),
     .rst(dclk_reset_rx_tmp),
     .data_in(1'b0),
     .data_out(dclk_reset)
    );        
    
  ten_gig_pcs_pma_5_ff_synchronizer_rst 
    #(
      .C_NUM_SYNC_REGS(4),
      .C_RVAL(1'b1)) 
  rxreset322_sync_i
    (
     .clk(rxusrclk2),
     .rst(clk156_reset_rx),
     .data_in(1'b0),
     .data_out(rxreset322)
    );
        
  // Asynch reset synchronizers

  ten_gig_pcs_pma_5_ff_synchronizer_rst 
    #(
      .C_NUM_SYNC_REGS(4),
      .C_RVAL(1'b1)) 
  areset_rxusrclk2_sync_i
    (
     .clk(rxusrclk2),
     .rst(areset),
     .data_in(1'b0),
     .data_out(areset_rxusrclk2)
    );
            
  ten_gig_pcs_pma_5_ff_synchronizer_rst 
    #(
      .C_NUM_SYNC_REGS(4),
      .C_RVAL(1'b1)) 
  pma_resetout_rising_rxusrclk2_sync_i
    (
     .clk(rxusrclk2),
     .rst(pma_resetout_rising),
     .data_in(1'b0),
     .data_out(pma_resetout_rising_rxusrclk2)
    );
            
  ten_gig_pcs_pma_5_ff_synchronizer_rst 
    #(
      .C_NUM_SYNC_REGS(4),
      .C_RVAL(1'b1)) 
  gtrxreset_rxusrclk2_sync_i
    (
     .clk(rxusrclk2),
     .rst(gtrxreset),
     .data_in(1'b0),
     .data_out(gtrxreset_rxusrclk2)
    );
            
  // Delay the assertion of RXUSERRDY by the given amount
  always @(posedge rxusrclk2)
  begin
     if(!qplllock_rxusrclk2 || gtrxreset_rxusrclk2)
       rxuserrdy_counter <= 24'h0;
     else if (!(rxuserrdy_counter == RXRESETTIME))
        rxuserrdy_counter   <=   rxuserrdy_counter + 1'b1;       
     else
        rxuserrdy_counter   <=   rxuserrdy_counter;
  end

  always @(posedge rxusrclk2)
  begin
     if(gtrxreset_rxusrclk2)
       rxuserrdy <= 1'b0;
     else if(rxuserrdy_counter == RXRESETTIME)
       rxuserrdy <= 1'b1;
     else
       rxuserrdy <= rxuserrdy;
  end

endmodule



