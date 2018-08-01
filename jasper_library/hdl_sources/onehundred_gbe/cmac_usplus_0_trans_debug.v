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
module cmac_usplus_0_trans_debug
   (
     output  reg [3 :0] gt_eyescanreset,
     output  reg [3 :0] gt_eyescantrigger,
     output  reg [3 :0] gt_rxcdrhold,
     output  reg [3 :0] gt_rxpolarity,
     output  reg [11 :0] gt_rxrate,
     output  reg [19 :0] gt_txdiffctrl,
     output  reg [3 :0] gt_txpolarity,
     output  reg [3 :0] gt_txinhibit,
     output  reg [19 :0] gt_txpostcursor,
     output  reg [3 :0] gt_txprbsforceerr,
     output  reg [19 :0] gt_txprecursor,

     input [3 :0] gt_eyescandataerror,
     input [7 :0] gt_txbufstatus,

     output  reg [3 :0]  gt_rxdfelpmreset,
     output  reg [3 :0]  gt_rxlpmen,
     output  reg [3 :0]  gt_rxprbscntreset,
     input [3 :0]  gt_rxprbserr,
     output  reg [15 :0]  gt_rxprbssel,
     input [3 :0]  gt_rxresetdone,
     output  reg [15 :0]  gt_txprbssel,
     input [3 :0]  gt_txresetdone,
     input [11 :0]  gt_rxbufstatus,

     output  reg [9:0]   gt0_drpaddr,  
     output  reg         gt0_drpen,
     output  reg [15:0]  gt0_drpdi,  
     input   [15:0]      gt0_drpdo,  
     input               gt0_drprdy, 
     output  reg         gt0_drpwe,
     output  reg [9:0]   gt1_drpaddr,  
     output  reg         gt1_drpen,
     output  reg [15:0]  gt1_drpdi,  
     input   [15:0]      gt1_drpdo,  
     input               gt1_drprdy, 
     output  reg         gt1_drpwe,
     output  reg [9:0]   gt2_drpaddr,  
     output  reg         gt2_drpen,
     output  reg [15:0]  gt2_drpdi,  
     input   [15:0]      gt2_drpdo,  
     input               gt2_drprdy, 
     output  reg         gt2_drpwe,
     output  reg [9:0]   gt3_drpaddr,  
     output  reg         gt3_drpen,
     output  reg [15:0]  gt3_drpdi,  
     input   [15:0]      gt3_drpdo,  
     input               gt3_drprdy, 
     output  reg         gt3_drpwe,
     output  reg [15:0]  common0_drpaddr,   //// Connect to both common and channel drp address
     output  reg [15:0]  common0_drpdi,     //// Connect to both common and channel drp data in
     output  reg         common0_drpen,     //// Connect to common drp enable
     output  reg         common0_drpwe,     //// Connect to common drp write enable
     input               common0_drprdy,    //// rdy signal from common
     input   [15:0]      common0_drpdo,     //// drp output signal from common
     input               reset,             //// Reset for this module 
     input               drp_clk            //// Drp clock input. Connect to the same clock that goes to GT drp clock. 

    );
    ////internal register declation

    //////////////////////////////////////////////////
    //// generating the output signals
    //// drp_clk is the init_clk  
    //// assigned default values 
    //////////////////////////////////////////////////
    always @( posedge drp_clk )
    begin
        gt_txpostcursor         <= 50'd0;
        gt_txdiffctrl           <= 20'd0;
        gt_txprecursor          <= 50'd0;
        gt_rxlpmen              <= 4'd0;
        gt_eyescanreset         <= 4'd0;
        gt_eyescantrigger       <= 4'd0;
        gt_rxcdrhold            <= 4'd0;
        gt_rxpolarity           <= 4'd0;
        gt_rxrate               <= 12'd0;
        gt_txpolarity           <= 4'd0;
        gt_txinhibit            <= 4'd0;
        gt_txprbsforceerr       <= 4'd0;
        gt_rxdfelpmreset        <= 4'd0;
        gt_rxprbscntreset       <= 4'd0;
        gt_rxprbssel            <= 16'd0;
        gt_txprbssel            <= 16'd0;
    end
    //////////////////////////////////////////////////
    //// generating the DRP signals
    //// reset is the sys_reset  
    //// drp_clk is the init_clk  
    //////////////////////////////////////////////////
    always @(posedge drp_clk)
    begin
        if  (reset == 1'b1)
        begin
            gt0_drpaddr      <= 10'b0;
            gt0_drpen        <= 1'b0;
            gt0_drpdi        <= 16'b0;
            gt0_drpwe        <= 1'b0;
            gt1_drpaddr      <= 10'b0;
            gt1_drpen        <= 1'b0;
            gt1_drpdi        <= 16'b0;
            gt1_drpwe        <= 1'b0;
            gt2_drpaddr      <= 10'b0;
            gt2_drpen        <= 1'b0;
            gt2_drpdi        <= 16'b0;
            gt2_drpwe        <= 1'b0;
            gt3_drpaddr      <= 10'b0;
            gt3_drpen        <= 1'b0;
            gt3_drpdi        <= 16'b0;
            gt3_drpwe        <= 1'b0;
            common0_drpaddr  <= 16'b0;
            common0_drpdi    <= 16'b0;
            common0_drpen    <= 1'b0;
            common0_drpwe    <= 1'b0;
        end
        else
        begin
            gt0_drpaddr      <= 10'b0;
            gt0_drpen        <= 1'b0;
            gt0_drpdi        <= 16'b0;
            gt0_drpwe        <= 1'b0;
            gt1_drpaddr      <= 10'b0;
            gt1_drpen        <= 1'b0;
            gt1_drpdi        <= 16'b0;
            gt1_drpwe        <= 1'b0;
            gt2_drpaddr      <= 10'b0;
            gt2_drpen        <= 1'b0;
            gt2_drpdi        <= 16'b0;
            gt2_drpwe        <= 1'b0;
            gt3_drpaddr      <= 10'b0;
            gt3_drpen        <= 1'b0;
            gt3_drpdi        <= 16'b0;
            gt3_drpwe        <= 1'b0;
            common0_drpaddr  <= 16'b0;
            common0_drpdi    <= 16'b0;
            common0_drpen    <= 1'b0;
            common0_drpwe    <= 1'b0;
        end
    end


endmodule



