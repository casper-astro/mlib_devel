// (c) Copyright 2014 Xilinx, Inc. All rights reserved. 
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
//  
///////////////////////////////////////////////////////////////////////////////
//
// File name: axis_infrastructure_v1_1_0_cdc_handshake
//
///////////////////////////////////////////////////////////////////////////////
`timescale 1ps/1ps
`default_nettype none

module axis_infrastructure_v1_1_0_cdc_handshake #
(
///////////////////////////////////////////////////////////////////////////////
// Parameter Definitions
///////////////////////////////////////////////////////////////////////////////
  parameter integer C_WIDTH                   = 32,
  parameter integer C_NUM_SYNCHRONIZER_STAGES = 2
)
(
///////////////////////////////////////////////////////////////////////////////
// Port Declarations     
///////////////////////////////////////////////////////////////////////////////
  input  wire                               from_clk,
  input  wire                               req, 
  output wire                               ack,
  input  wire [C_WIDTH-1:0]                 data_in,

  input  wire                               to_clk,
  output wire                               data_valid,
  output wire [C_WIDTH-1:0]                 data_out
);

/////////////////////////////////////////////////////////////////////////////
// Functions
/////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Local parameters
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Wires/Reg declarations
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// BEGIN RTL
///////////////////////////////////////////////////////////////////////////////
xpm_cdc_handshake #(
  .WIDTH          ( C_WIDTH                   ) ,
  .DEST_SYNC_FF   ( C_NUM_SYNCHRONIZER_STAGES ) ,
  .SRC_SYNC_FF    ( C_NUM_SYNCHRONIZER_STAGES ) ,
  .DEST_EXT_HSK   ( 0                         ) ,
  .SIM_ASSERT_CHK ( 0                         ) 
)
inst_xpm_cdc_handshake (
  .src_in   ( data_in    ) ,
  .src_send ( req        ) ,
  .src_rcv  ( ack        ) ,
  .src_clk  ( from_clk ) ,
  .dest_out ( data_out   ) ,
  .dest_req ( data_valid ) ,
  .dest_ack ( 1'b0       ) ,
  .dest_clk ( to_clk     ) 
);

endmodule // axis_infrastructure_v1_1_0_cdc_handshake

`default_nettype wire
