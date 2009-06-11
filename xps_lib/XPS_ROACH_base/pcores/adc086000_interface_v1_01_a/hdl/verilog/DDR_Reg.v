`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    06:51:34 07/05/2007 
// Design Name: 
// Module Name:    DDR_Reg 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module DDR_Reg(din, dout_rise, dout_fall, clk, reset);
    input [7:0] din;
    output [7:0] dout_rise;
    output [7:0] dout_fall;
    input clk;
    input reset;

   // IDDR: Input Double Data Rate Input Register with Set, Reset
   //       and Clock Enable.
   //       Virtex-4/5
   // Xilinx HDL Language Template, version 9.1.3i

   IDDR #(
      .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"), // "OPPOSITE_EDGE", "SAME_EDGE" 
                                      //    or "SAME_EDGE_PIPELINED" 
      .INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
      .INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
      .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
   ) IDDR_0 (
      .Q1(dout_rise[0]), // 1-bit output for positive edge of clock 
      .Q2(dout_fall[0]), // 1-bit output for negative edge of clock
      .C(clk),   // 1-bit clock input
      .CE(1'b1), // 1-bit clock enable input
      .D(din[0]),   // 1-bit DDR data input
      .R(reset),   // 1-bit reset
      .S(1'b0)    // 1-bit set
   );


   IDDR #(
      .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"), // "OPPOSITE_EDGE", "SAME_EDGE" 
                                      //    or "SAME_EDGE_PIPELINED" 
      .INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
      .INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
      .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
   ) IDDR_1 (
      .Q1(dout_rise[1]), // 1-bit output for positive edge of clock 
      .Q2(dout_fall[1]), // 1-bit output for negative edge of clock
      .C(clk),   // 1-bit clock input
      .CE(1'b1), // 1-bit clock enable input
      .D(din[1]),   // 1-bit DDR data input
      .R(reset),   // 1-bit reset
      .S(1'b0)    // 1-bit set
   );

   IDDR #(
      .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"), // "OPPOSITE_EDGE", "SAME_EDGE" 
                                      //    or "SAME_EDGE_PIPELINED" 
      .INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
      .INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
      .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
   ) IDDR_2 (
      .Q1(dout_rise[2]), // 1-bit output for positive edge of clock 
      .Q2(dout_fall[2]), // 1-bit output for negative edge of clock
      .C(clk),   // 1-bit clock input
      .CE(1'b1), // 1-bit clock enable input
      .D(din[2]),   // 1-bit DDR data input
      .R(reset),   // 1-bit reset
      .S(1'b0)    // 1-bit set
   );

   IDDR #(
      .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"), // "OPPOSITE_EDGE", "SAME_EDGE" 
                                      //    or "SAME_EDGE_PIPELINED" 
      .INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
      .INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
      .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
   ) IDDR_3 (
      .Q1(dout_rise[3]), // 1-bit output for positive edge of clock 
      .Q2(dout_fall[3]), // 1-bit output for negative edge of clock
      .C(clk),   // 1-bit clock input
      .CE(1'b1), // 1-bit clock enable input
      .D(din[3]),   // 1-bit DDR data input
      .R(reset),   // 1-bit reset
      .S(1'b0)    // 1-bit set
   );

   IDDR #(
      .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"), // "OPPOSITE_EDGE", "SAME_EDGE" 
                                      //    or "SAME_EDGE_PIPELINED" 
      .INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
      .INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
      .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
   ) IDDR_4 (
      .Q1(dout_rise[4]), // 1-bit output for positive edge of clock 
      .Q2(dout_fall[4]), // 1-bit output for negative edge of clock
      .C(clk),   // 1-bit clock input
      .CE(1'b1), // 1-bit clock enable input
      .D(din[4]),   // 1-bit DDR data input
      .R(reset),   // 1-bit reset
      .S(1'b0)    // 1-bit set
   );

   IDDR #(
      .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"), // "OPPOSITE_EDGE", "SAME_EDGE" 
                                      //    or "SAME_EDGE_PIPELINED" 
      .INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
      .INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
      .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
   ) IDDR_5 (
      .Q1(dout_rise[5]), // 1-bit output for positive edge of clock 
      .Q2(dout_fall[5]), // 1-bit output for negative edge of clock
      .C(clk),   // 1-bit clock input
      .CE(1'b1), // 1-bit clock enable input
      .D(din[5]),   // 1-bit DDR data input
      .R(reset),   // 1-bit reset
      .S(1'b0)    // 1-bit set
   );

   IDDR #(
      .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"), // "OPPOSITE_EDGE", "SAME_EDGE" 
                                      //    or "SAME_EDGE_PIPELINED" 
      .INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
      .INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
      .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
   ) IDDR_6 (
      .Q1(dout_rise[6]), // 1-bit output for positive edge of clock 
      .Q2(dout_fall[6]), // 1-bit output for negative edge of clock
      .C(clk),   // 1-bit clock input
      .CE(1'b1), // 1-bit clock enable input
      .D(din[6]),   // 1-bit DDR data input
      .R(reset),   // 1-bit reset
      .S(1'b0)    // 1-bit set
   );

   IDDR #(
      .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"), // "OPPOSITE_EDGE", "SAME_EDGE" 
                                      //    or "SAME_EDGE_PIPELINED" 
      .INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
      .INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
      .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
   ) IDDR_7 (
      .Q1(dout_rise[7]), // 1-bit output for positive edge of clock 
      .Q2(dout_fall[7]), // 1-bit output for negative edge of clock
      .C(clk),   // 1-bit clock input
      .CE(1'b1), // 1-bit clock enable input
      .D(din[7]),   // 1-bit DDR data input
      .R(reset),   // 1-bit reset
      .S(1'b0)    // 1-bit set
   );

endmodule
