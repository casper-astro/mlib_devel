module qdr_capture #(
	// Module Parameters
	parameter width = 8
) (
	// Input-Output ports
  input clk_0,
	input clk_90,
	input clk_180,
	input clk_270,
	input reset,
	input [width-1:0] data_p,
	input [width-1:0] data_n,
  output [width-1:0] data0,
	output [width-1:0] data90,
	output [width-1:0] data180,
	output [width-1:0] data270
);

// Wires and Regs
//===============
wire [width-1:0] data;

//make the input bus single ended
diff_to_se data_se_out (
	.data_p(data_p),
	.data_n(data_n),
	.data(data)
);
defparam data_se_out.width = width;

//capture on all 4 clocks using IO registers
IORegister capture0 (.Clock(clk_0), .Reset(reset), .Set(), .Enable(1'b1), .In(data), .Out(data0));
IORegister capture90 (.Clock(clk_90), .Reset(reset), .Set(), .Enable(1'b1), .In(data), .Out(data90));
IORegister capture180 (.Clock(clk_180), .Reset(reset), .Set(), .Enable(1'b1), .In(data), .Out(data180));
IORegister capture270 (.Clock(clk_270), .Reset(reset), .Set(), .Enable(1'b1), .In(data), .Out(data270));
defparam capture0.width = 1;
defparam capture90.width = 1;
defparam capture180.width = 1;
defparam capture270.width = 1;

endmodule
