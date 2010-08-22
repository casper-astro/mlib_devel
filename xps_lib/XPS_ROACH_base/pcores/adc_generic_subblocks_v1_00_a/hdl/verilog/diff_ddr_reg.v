// Module Name: diff_ddr_reg
// Original Module Author: Suraj Gowda
// Inputs:
// 	Bus of LVDS DDR data pairs (width is parameterizable, see below).
// Circuit overview:
// 	Turns the LVDS bus into a single ended bus and captures the rising 
// 	edge and falling edge bus data 

module diff_ddr_reg (
	clk,
	reset,
	input_p,
	input_n,
	output_rise,
	output_fall
);

// System Parameters
//==================
parameter width = 8;

// Inputs and Outputs
//====================
input clk;
input reset;
input [width-1:0] input_p;
input [width-1:0] input_n;
output [width-1:0] output_rise;
output [width-1:0] output_fall;

wire [width-1:0] input_se;

genvar i;
generate
	for (i = 0; i < width; i = i +1) begin: diff_buffer
		// Convert LVDS pair to single-ended
		IBUFDS #(.DIFF_TERM("TRUE"),.IOSTANDARD("LVDS_25"))     
			LVDS_buf (.I(input_p[i]), .IB(input_n[i]), .O( input_se[i] ));

		// DDR register the single ended line
		IDDR #(
			.DDR_CLK_EDGE("SAME_EDGE_PIPELINED"), // "OPPOSITE_EDGE", "SAME_EDGE" 
			                                //    or "SAME_EDGE_PIPELINED" 
			.INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
			.INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
			.SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
		) IDDR_buf (
			.Q1(output_rise[i]), // 1-bit output for positive edge of clock 
			.Q2(output_fall[i]), // 1-bit output for negative edge of clock
			.C(clk),   // 1-bit clock input
			.CE(1'b1), // 1-bit clock enable input
			.D(input_se[i]),   // 1-bit DDR data input
			.R(reset),   // 1-bit reset
			.S(1'b0)    // 1-bit set
		);		
	end
endgenerate
endmodule
