// Module Name: recapture
// Original Module Author: Suraj Gowda
// Inputs:
// 	Parameterizable width data bus.
// Circuit overview:
// 	Runs the input data (din) through an IO shift register to ease IO
// 	timing requirements.  Registers are packed into the IOB.
module recapture ( clk, reset, din, dout );

// System Parameters
//==================
parameter width = 8;
parameter delay = 2;

// Inputs and Outputs
input clk;
input reset;
input [width-1:0] din;
output [width-1:0] dout;

//Wires and regs
//==============
wire [width-1:0] recapture0;

// Module Declarations
//====================

//module IOShiftRegister(PIn, SIn, POut, SOut, Load, Enable, Clock, Reset);
IOShiftRegister recapture_pipeline ( .Clock(clk), .Reset(reset), .PIn(), .SIn(din), .SOut(dout), .Load(), .Enable(1'b1));
defparam recapture_pipeline.pwidth = width * delay;
defparam recapture_pipeline.swidth = width;

endmodule
