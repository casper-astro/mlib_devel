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
////////////////////////////////////////////////////////////
//
// Structure:
//   axis_infrastructure_v1_1_0_util_aclken_converter_wrapper
//     axis_infrastructure_v1_1_0_util_axis2_vector
//     axis_infrastructure_v1_1_0_util_aclken_converter
//     axis_infrastructure_v1_1_0_util_vector2axis 
//
////////////////////////////////////////////////////////////
`ifndef axis_infrastructure_v1_1_0_UTIL_ACLKEN_CONVERTER_WRAPPER_V
`define axis_infrastructure_v1_1_0_UTIL_ACLKEN_CONVERTER_WRAPPER_V

`timescale 1ps/1ps
`default_nettype none

(* DowngradeIPIdentifiedWarnings="yes" *)
module axis_infrastructure_v1_1_0_util_aclken_converter_wrapper # (
///////////////////////////////////////////////////////////////////////////////
// Parameter Definitions
///////////////////////////////////////////////////////////////////////////////
  parameter integer C_TDATA_WIDTH = 32,
  parameter integer C_TID_WIDTH   = 1,
  parameter integer C_TDEST_WIDTH = 1,
  parameter integer C_TUSER_WIDTH = 1,
  parameter [31:0]  C_SIGNAL_SET  = 32'hFF,
  // C_AXIS_SIGNAL_SET: each bit if enabled specifies which axis optional signals are present
  //   [0] => TREADY present
  //   [1] => TDATA present
  //   [2] => TSTRB present, TDATA must be present
  //   [3] => TKEEP present, TDATA must be present
  //   [4] => TLAST present
  //   [5] => TID present
  //   [6] => TDEST present
  //   [7] => TUSER present
  parameter integer C_S_ACLKEN_CAN_TOGGLE = 1,
  parameter integer C_M_ACLKEN_CAN_TOGGLE = 1
  )
 (
///////////////////////////////////////////////////////////////////////////////
// Port Declarations
///////////////////////////////////////////////////////////////////////////////
  // Slave side
  input  wire                       ACLK,
  input  wire                       ARESETN,
  input  wire                       S_ACLKEN,
  input  wire                       S_VALID,
  output wire                       S_READY,
  input  wire [C_TDATA_WIDTH-1:0]   S_TDATA,
  input  wire [C_TDATA_WIDTH/8-1:0] S_TSTRB,
  input  wire [C_TDATA_WIDTH/8-1:0] S_TKEEP,
  input  wire                       S_TLAST,
  input  wire [C_TID_WIDTH-1:0]     S_TID,
  input  wire [C_TDEST_WIDTH-1:0]   S_TDEST,
  input  wire [C_TUSER_WIDTH-1:0]   S_TUSER,
                                    
  input  wire                       M_ACLKEN,
  output wire                       M_VALID,
  input  wire                       M_READY,
  output wire [C_TDATA_WIDTH-1:0]   M_TDATA,
  output wire [C_TDATA_WIDTH/8-1:0] M_TSTRB,
  output wire [C_TDATA_WIDTH/8-1:0] M_TKEEP,
  output wire                       M_TLAST,
  output wire [C_TID_WIDTH-1:0]     M_TID,
  output wire [C_TDEST_WIDTH-1:0]   M_TDEST,
  output wire [C_TUSER_WIDTH-1:0]   M_TUSER
);

////////////////////////////////////////////////////////////////////////////////
// Functions
////////////////////////////////////////////////////////////////////////////////
`include "axis_infrastructure_v1_1_0_axis_infrastructure.vh"


////////////////////////////////////////////////////////////////////////////////
// Local parameters
////////////////////////////////////////////////////////////////////////////////

localparam integer P_TPAYLOAD_WIDTH       = f_payload_width(C_TDATA_WIDTH, C_TID_WIDTH, 
                                                 C_TDEST_WIDTH, C_TUSER_WIDTH, 
                                                 C_SIGNAL_SET);
////////////////////////////////////////////////////////////////////////////////
// Wires/Reg declarations
////////////////////////////////////////////////////////////////////////////////
wire [P_TPAYLOAD_WIDTH-1:0] s_tpayload;
wire [P_TPAYLOAD_WIDTH-1:0] m_tpayload;

////////////////////////////////////////////////////////////////////////////////
// BEGIN RTL
////////////////////////////////////////////////////////////////////////////////

axis_infrastructure_v1_1_0_util_axis2vector #(
  .C_TDATA_WIDTH    ( C_TDATA_WIDTH ) ,
  .C_TID_WIDTH      ( C_TID_WIDTH   ) ,
  .C_TDEST_WIDTH    ( C_TDEST_WIDTH ) ,
  .C_TUSER_WIDTH    ( C_TUSER_WIDTH ) ,
  .C_TPAYLOAD_WIDTH ( P_TPAYLOAD_WIDTH   ) ,
  .C_SIGNAL_SET     ( C_SIGNAL_SET  ) 
)
util_axis2vector_0 (
  .TDATA    ( S_TDATA    ) ,
  .TSTRB    ( S_TSTRB    ) ,
  .TKEEP    ( S_TKEEP    ) ,
  .TLAST    ( S_TLAST    ) ,
  .TID      ( S_TID      ) ,
  .TDEST    ( S_TDEST    ) ,
  .TUSER    ( S_TUSER    ) ,
  .TPAYLOAD ( s_tpayload )
);

generate
if (C_S_ACLKEN_CAN_TOGGLE | C_M_ACLKEN_CAN_TOGGLE) begin : gen_aclken_converter
  axis_infrastructure_v1_1_0_util_aclken_converter #( 
    .C_PAYLOAD_WIDTH       ( P_TPAYLOAD_WIDTH       ) ,
    .C_S_ACLKEN_CAN_TOGGLE ( C_S_ACLKEN_CAN_TOGGLE ) ,
    .C_M_ACLKEN_CAN_TOGGLE ( C_M_ACLKEN_CAN_TOGGLE ) 
  )
  s_util_aclken_converter_0 ( 
    .ACLK      ( ACLK       ) ,
    .ARESETN   ( ARESETN    ) ,
    .S_ACLKEN  ( S_ACLKEN   ) ,
    .S_PAYLOAD ( s_tpayload ) ,
    .S_VALID   ( S_VALID   ) ,
    .S_READY   ( S_READY   ) ,
    .M_ACLKEN  ( M_ACLKEN   ) ,
    .M_PAYLOAD ( m_tpayload ) ,
    .M_VALID   ( M_VALID   ) ,
    .M_READY   ( M_READY   ) 
  );
end
else begin : gen_aclken_passthru
  assign m_tpayload = s_tpayload;
  assign M_VALID   = S_VALID;
  assign S_READY = M_READY;
end
endgenerate

axis_infrastructure_v1_1_0_util_vector2axis #(
  .C_TDATA_WIDTH    ( C_TDATA_WIDTH ) ,
  .C_TID_WIDTH      ( C_TID_WIDTH   ) ,
  .C_TDEST_WIDTH    ( C_TDEST_WIDTH ) ,
  .C_TUSER_WIDTH    ( C_TUSER_WIDTH ) ,
  .C_TPAYLOAD_WIDTH ( P_TPAYLOAD_WIDTH   ) ,
  .C_SIGNAL_SET     ( C_SIGNAL_SET  ) 
)
util_vector2axis_0 (
  .TPAYLOAD ( m_tpayload ) ,
  .TDATA    ( M_TDATA    ) ,
  .TSTRB    ( M_TSTRB    ) ,
  .TKEEP    ( M_TKEEP    ) ,
  .TLAST    ( M_TLAST    ) ,
  .TID      ( M_TID      ) ,
  .TDEST    ( M_TDEST    ) ,
  .TUSER    ( M_TUSER    ) 
);

endmodule // axis_infrastructure_v1_1_0_util_aclken_converter_wrapper

`default_nettype wire
`endif
