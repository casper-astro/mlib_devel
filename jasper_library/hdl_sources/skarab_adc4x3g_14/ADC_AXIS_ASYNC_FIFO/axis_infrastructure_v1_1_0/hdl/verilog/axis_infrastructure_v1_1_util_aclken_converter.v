//  (c) Copyright 2012-2013 Xilinx, Inc. All rights reserved.
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
////////////////////////////////////////////////////////////
//
// Verilog-standard:  Verilog 2001
//--------------------------------------------------------------------------
//
// Structure:
//   axis_infrastructure_v1_1_0_util_aclken_converter
//
//--------------------------------------------------------------------------
`ifndef AXIS_INFRASTRUCTURE_V1_0_UTIL_ACLKEN_CONVERTER_V
`define AXIS_INFRASTRUCTURE_V1_0_UTIL_ACLKEN_CONVERTER_V

`timescale 1ps/1ps
`default_nettype none

(* DowngradeIPIdentifiedWarnings="yes" *)
module axis_infrastructure_v1_1_0_util_aclken_converter # (
///////////////////////////////////////////////////////////////////////////////
// Parameter Definitions
///////////////////////////////////////////////////////////////////////////////
  parameter integer C_PAYLOAD_WIDTH       = 32,
  parameter integer C_S_ACLKEN_CAN_TOGGLE = 1,
  parameter integer C_M_ACLKEN_CAN_TOGGLE = 1
  )
 (
///////////////////////////////////////////////////////////////////////////////
// Port Declarations
///////////////////////////////////////////////////////////////////////////////
  // Slave side
  input  wire                        ACLK,
  input  wire                        ARESETN,

  input  wire                        S_ACLKEN,
  input  wire [C_PAYLOAD_WIDTH-1:0]  S_PAYLOAD,
  input  wire                        S_VALID,
  output wire                        S_READY,

  // Master side
  input  wire                        M_ACLKEN,
  output wire [C_PAYLOAD_WIDTH-1:0]  M_PAYLOAD,
  output wire                        M_VALID,
  input  wire                        M_READY
);

////////////////////////////////////////////////////////////////////////////////
// Functions
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
// Local parameters
////////////////////////////////////////////////////////////////////////////////

// State machine states
localparam SM_NOT_READY    = 3'b000;
localparam SM_EMPTY        = 3'b001;
localparam SM_R0_NOT_READY = 3'b010;
localparam SM_R0           = 3'b011;
localparam SM_R1           = 3'b100;
localparam SM_FULL         = 3'b110;

////////////////////////////////////////////////////////////////////////////////
// Wires/Reg declarations
////////////////////////////////////////////////////////////////////////////////
wire s_aclken_i;
wire m_aclken_i;
reg  areset;

reg [2:0] state;

// r0 is the output register
reg [C_PAYLOAD_WIDTH-1:0] r0;
wire                      load_r0;
wire                      load_r0_from_r1;

// r1 is the overflow register
reg [C_PAYLOAD_WIDTH-1:0] r1;
wire                      load_r1;
////////////////////////////////////////////////////////////////////////////////
// BEGIN RTL
////////////////////////////////////////////////////////////////////////////////

assign s_aclken_i = C_S_ACLKEN_CAN_TOGGLE ? S_ACLKEN : 1'b1;
assign m_aclken_i = C_M_ACLKEN_CAN_TOGGLE ? M_ACLKEN : 1'b1;

always @(posedge ACLK) begin 
  areset <= ~ARESETN;
end

// Valid/Ready outputs encoded into state machine.
assign S_READY = state[0];
assign M_VALID = state[1];

// State machine: Controls outputs and hold register state info
always @(posedge ACLK) begin 
  if (areset) begin
    state <= SM_NOT_READY;
  end
  else begin 
    case (state)
      // De-assert s_ready, de-assert m_valid, R0 unoccupied, R1 unoccupied
      SM_NOT_READY: begin
        if (s_aclken_i) begin
          state <= SM_EMPTY;
        end
        else begin
          state <= state;
        end
      end

      // Assert s_ready, de-assert m_valid, R0 unoccupied, R1 unoccupied
      SM_EMPTY: begin
        if (s_aclken_i & S_VALID & m_aclken_i) begin
          state <= SM_R0;
        end
        else if (s_aclken_i & S_VALID & ~m_aclken_i) begin
          state <= SM_R1;
        end
        else begin 
          state <= state;
        end
      end

      // Assert s_ready, Assert m_valid, R0 occupied, R1 unoccupied
      SM_R0: begin
        if ((m_aclken_i & M_READY) & ~(s_aclken_i & S_VALID)) begin
          state <= SM_EMPTY;
        end
        else if (~(m_aclken_i & M_READY) & (s_aclken_i & S_VALID)) begin
          state <= SM_FULL;
        end
        else begin 
          state <= state;
        end
      end

      // De-assert s_ready, Assert m_valid, R0 occupied, R1 unoccupied
      SM_R0_NOT_READY: begin
        if (s_aclken_i & m_aclken_i & M_READY) begin
          state <= SM_EMPTY;
        end
        else if (~s_aclken_i & m_aclken_i & M_READY) begin
          state <= SM_NOT_READY;
        end
        else if (s_aclken_i) begin
          state <= SM_R0;
        end
        else begin 
          state <= state;
        end
      end

      // De-assert s_ready, De-assert m_valid, R0 unoccupied, R1 occupied
      SM_R1: begin
        if (~s_aclken_i & m_aclken_i) begin
          state <= SM_R0_NOT_READY;
        end
        else if (s_aclken_i & m_aclken_i) begin 
          state <= SM_R0;
        end
        else begin 
          state <= state;
        end
      end

      // De-assert s_ready, De-assert m_valid, R0 occupied, R1 occupied
      SM_FULL: begin
        if (~s_aclken_i & m_aclken_i & M_READY) begin
          state <= SM_R0_NOT_READY;
        end
        else if (s_aclken_i & m_aclken_i & M_READY) begin 
          state <= SM_R0;
        end
        else begin 
          state <= state;
        end
      end

      default: begin
        state <= SM_NOT_READY;
      end
    endcase
  end
end

assign M_PAYLOAD = r0;

always @(posedge ACLK) begin
  if (m_aclken_i) begin 
    r0 <= ~load_r0 ? r0 :
          load_r0_from_r1 ? r1 :
          S_PAYLOAD ;
  end
end

assign load_r0 = (state == SM_EMPTY) 
                 | (state == SM_R1) 
                 | ((state == SM_R0) & M_READY)
                 | ((state == SM_FULL) & M_READY);

assign load_r0_from_r1 = (state == SM_R1) | (state == SM_FULL);

always @(posedge ACLK) begin
  r1 <= ~load_r1 ? r1 : S_PAYLOAD;
end

assign load_r1 = (state == SM_EMPTY) | (state == SM_R0);


endmodule // axis_infrastructure_v1_1_0_util_aclken_converter

`default_nettype wire
`endif
