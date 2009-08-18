module qdr_capture (
  clk_0,
	clk_90,
	reset,
	data_p,
	data_n,
  data0,
	data90,
	data180,
	data270
);

// System Parameters
// =================
parameter width = 8;

// Inputs and Outputs
//===================
input clk_0;
input clk_90;
input reset;
input data_p;
input data_n;
output data0;
output data90;
output data180;
output data270;

// Wires and Regs
//===============
wire data_rise_0;
wire data_rise_90;
wire data_fall_0;
wire data_fall_90;
reg data0;
reg data90;
reg data180;
reg data270;

// Module Declarations
//====================
// capture
diff_qdr_reg data_capture(
	.clk_0(clk_0),
	.clk_90(clk_90),
	.data_p(data_p),
	.data_n(data_n),
	.data_rise_0(data_rise_0),
	.data_fall_0(data_fall_0),
	.data_rise_90(data_rise_90),
	.data_fall_90(data_fall_90)
);
defparam data_capture.width = width;

// recapture
always @ (posedge clk_0) begin
	if (reset) begin
		data0 <= 0;
		data90 <= 0;
		data180 <= 0;
		data270 <= 0;
	end else begin
		data0 <= data_rise_0;
		data90 <= data_fall_0;
		data180 <= data_rise_90;
		data270 <= data_fall_90;
	end
end	

endmodule
