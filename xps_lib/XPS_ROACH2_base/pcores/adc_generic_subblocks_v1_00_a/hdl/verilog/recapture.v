// Module Name: recapture
// Original Module Author: Suraj Gowda
// Inputs:
// 	Parameterizable width data bus.
// Circuit overview:
// 	Runs the input data (din) through an IO shift register to ease IO
// 	timing requirements.  Registers are packed into the IOB.
module recapture #(
	parameter width = 8,
	parameter delay = 1
) ( 
	input clk,
	input ctrl_clk_out,
	input reset,
	input [width-1:0] din,
	output [width-1:0] dout
);

//Wires and regs
//==============
wire [width-1:0] stage_0_out;
wire [width-1:0] stage_1_in;

// Module Declarations
//====================
IORegister pipeline1(.Clock(clk), .Reset(reset), .Set(1'b0), .Enable(1'b1), .In(din), .Out(stage_0_out));
IORegister pipeline2(.Clock(ctrl_clk_out), .Reset(reset), .Set(1'b0), .Enable(1'b1), .In(stage_1_in), .Out(dout));

// Bitwise MAXDELAY constraint generation
genvar i;
generate for (i = 0; i < width; i = i + 1) begin: max_delay_gen
	(* MAXDELAY = "2 ns" *) wire int = stage_0_out[i];
	assign stage_1_in[i] = int;
end endgenerate

endmodule
