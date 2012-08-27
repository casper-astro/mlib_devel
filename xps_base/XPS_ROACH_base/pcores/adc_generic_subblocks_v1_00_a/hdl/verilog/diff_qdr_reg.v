module diff_qdr_reg(
  clk_0,
	clk_90,
	clk_180,
	clk_270,
	data_p,
	data_n,
	data_rise_0,
	data_fall_0,
	data_rise_90,
	data_fall_90
);

// System Parameters
parameter width = 8;

// Inputs and Outputs
//===================
input clk_0;
input clk_90;
input clk_180;
input clk_270;
input [width-1:0] data_p;
input [width-1:0] data_n;
output [width-1:0] data_rise_0;
output [width-1:0] data_fall_0;
output [width-1:0] data_rise_90;
output [width-1:0] data_fall_90;

// Wires and Regs
//===============
wire [width-1:0] data;

// Module Declarations
//====================
genvar i;
generate
	for (i = 0; i < width; i = i +1) begin: qdr_capture
		// Convert LVDS pair to single-ended
		IBUFGDS #(
			.DIFF_TERM("TRUE"),       	// Differential Termination (Virtex-4/5, Spartan-3E/3A)
			.IOSTANDARD("LVDS_25")    	// Specify the input I/O standard
		) IBUFGDS_data (
			.O(data[i]),  						// Buffer output
			.I(data_p[i]),  						// Diff_p buffer input (connect directly to top-level port)
			.IB(data_n[i]) 						// Diff_n buffer input (connect directly to top-level port)
		);
		
		IDDR #(
			.DDR_CLK_EDGE("SAME_EDGE_PIPELINED"), // "OPPOSITE_EDGE", "SAME_EDGE" or "SAME_EDGE_PIPELINED" 
			.INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
			.INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
			.SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
		) IDDR_data_0 (
			.Q1(data_rise_0[i]), // 1-bit output for positive edge of clock 
			.Q2(data_fall_0[i]), // 1-bit output for negative edge of clock
			.C(clk_0),   // 1-bit clock input
			.CE(1'b1), // 1-bit clock enable input
			.D(data[i]),   // 1-bit DDR data input
			.R(1'b0),   // 1-bit reset
			.S(1'b0)    // 1-bit set
		);
		
		IDDR #(
			.DDR_CLK_EDGE("SAME_EDGE_PIPELINED"), // "OPPOSITE_EDGE", "SAME_EDGE" or "SAME_EDGE_PIPELINED" 
			.INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
			.INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
			.SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
		) IDDR_data_90 (
			.Q1(data_rise_90[i]), // 1-bit output for positive edge of clock 
			.Q2(data_fall_90[i]), // 1-bit output for negative edge of clock
			.C(clk_90),   // 1-bit clock input
			.CE(1'b1), // 1-bit clock enable input
			.D(data[i]),   // 1-bit DDR data input
			.R(1'b0),   // 1-bit reset
			.S(1'b0)    // 1-bit set
		);
	end
endgenerate
endmodule
