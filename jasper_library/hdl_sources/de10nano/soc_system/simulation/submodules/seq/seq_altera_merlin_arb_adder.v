// (C) 2001-2025 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


`timescale 1 ns / 1 ns

// ----------------------------------------------
// Adder for the standard arbitrator
// ----------------------------------------------
module seq_altera_merlin_arb_adder
#(
    parameter WIDTH = 8
)
(
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,

    output [WIDTH-1:0] sum
);

    // ----------------------------------------------
    // Benchmarks indicate that for small widths, the full
    // adder has higher fmax because synthesis can merge
    // it with the mux, allowing partial decisions to be 
    // made early.
    //
    // The magic number is 4 requesters, which means an
    // 8 bit adder.
    // ----------------------------------------------
    genvar i;
    generate if (WIDTH <= 8) begin : full_adder

        wire cout[WIDTH-1:0];

        assign sum[0]  = (a[0] ^ b[0]);
        assign cout[0] = (a[0] & b[0]);

        for (i = 1; i < WIDTH; i = i+1) begin : arb

            assign sum[i] = (a[i] ^ b[i]) ^ cout[i-1];
            assign cout[i] = (a[i] & b[i]) | (cout[i-1] & (a[i] ^ b[i]));

        end

    end else begin : carry_chain

        assign sum = a + b;

    end
    endgenerate

endmodule
