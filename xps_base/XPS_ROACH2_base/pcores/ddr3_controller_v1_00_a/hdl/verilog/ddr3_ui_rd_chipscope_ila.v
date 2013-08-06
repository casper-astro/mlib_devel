///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Xilinx, Inc.
// All Rights Reserved
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor     : Xilinx
// \   \   \/     Version    : 14.3
//  \   \         Application: Xilinx CORE Generator
//  /   /         Filename   : ddr3_ui_rd_chipscope_ila.v
// /___/   /\     Timestamp  : Thu Jun 20 15:31:10 SAST 2013
// \   \  /  \
//  \___\/\___\
//
// Design Name: Verilog Synthesis Wrapper
///////////////////////////////////////////////////////////////////////////////
// This wrapper is used to integrate with Project Navigator and PlanAhead

`timescale 1ns/1ps

module ddr3_ui_rd_chipscope_ila(
    CONTROL,
    CLK,
    DATA,
    TRIG0) /* synthesis syn_black_box syn_noprune=1 */;


inout [35 : 0] CONTROL;
input CLK;
input [107 : 0] DATA;
input [4 : 0] TRIG0;

endmodule
