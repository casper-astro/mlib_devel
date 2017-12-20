`timescale 1ns / 1ps

module clock_passthrough(
    input user_clock_p,
    input user_clock_n,
    output clock_out_p,
    output clock_out_n
    );


wire clk_out;
wire clock_bufg;

reg q;

IBUFDS IBUFDS_inst_user_clock(
    .O(clock_out), // Buffer output
    .I(user_clock_p), // Diff_p buffer input (connect directly to top-level port)
    .IB(user_clock_n) // Diff_n buffer input (connect directly to top-level port)
);

BUFG BUFG_inst_user_clock (
      .O(clock_bufg), // 1-bit output: Clock output
      .I(clock_out)
   );


 ODDR #(
      .DDR_CLK_EDGE("OPPOSITE_EDGE"), // "OPPOSITE_EDGE" or "SAME_EDGE" 
      .INIT(1'b0),    // Initial value of Q: 1'b0 or 1'b1
      .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
   ) ODDR_out_clock_inst_user_clock (
      .Q(clock_out_ddr),   // 1-bit DDR output
      .C(clock_bufg),   // 1-bit clock input
      .CE(1'b1), // 1-bit clock enable input
      .D1(1'b1), // 1-bit data input (positive edge)
      .D2(1'b0), // 1-bit data input (negative edge)
      .R(),   // 1-bit reset
      .S()    // 1-bit set
   );

    
OBUFDS OBUFDS_inst_user_clock (
      .O (clock_out_p),     // Diff_p output (connect directly to top-level port)
      .OB(clock_out_n),     // Diff_n output (connect directly to top-level port)
      .I (clock_out_ddr)      // Buffer input 
   );
  
endmodule
