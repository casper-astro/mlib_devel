//-----------------------------------------------------------------------
//	Module:		IOShiftRegister
//	Desc:		This module packs the ShiftRegster (see
//			ShiftRegister.v), located in this directory, into the IOB.  The
//			purpose is to break apart critical paths in timing for IO pcores.
//	Params:		pwidth:	Sets the bitwidth of the parallel data
//			(both in and out of the module)
//			swidth:	Sets the bitwidth of the serial data
//			(both in and out of the module)
//	Ex:		(32,1) will convert 32bit wide data into 1bit
//			serial data
//			(32,8) will convert 32bit words into bytes
//-----------------------------------------------------------------------
module IOShiftRegister(PIn, SIn, POut, SOut, Load, Enable, Clock, Reset);
	//---------------------------------------------------------------
	//	Parameters
	//---------------------------------------------------------------
	parameter		pwidth =		32,	// The parallel width
				swidth =		1;	// The serial width
	//---------------------------------------------------------------

	//---------------------------------------------------------------
	//	Parallel and Serial I/O
	//---------------------------------------------------------------
	input	[pwidth-1:0]	PIn;
	input	[swidth-1:0]	SIn;
	output	[pwidth-1:0]	POut; 
	// synthesis attribute iob of POut is true;
	output	[swidth-1:0]	SOut;
	//---------------------------------------------------------------

	//---------------------------------------------------------------
	//	Control Inputs
	//---------------------------------------------------------------
	input			Load, Enable, Clock, Reset;
	//---------------------------------------------------------------

	//---------------------------------------------------------------
	//	Registers
	//---------------------------------------------------------------
	reg	[pwidth-1:0]	POut;
	//---------------------------------------------------------------

	//---------------------------------------------------------------
	//	Generate the output
	//---------------------------------------------------------------
	assign	SOut =				POut[pwidth-1:pwidth-swidth];
	//---------------------------------------------------------------

	//---------------------------------------------------------------
	//	Behavioral Shift Register Core
	//---------------------------------------------------------------
	always @ (posedge Clock) begin
		if (Reset) POut <=		{pwidth{1'b0}};
		else if (Load) POut <=		PIn;
		else if (Enable) POut <=	{POut[pwidth-swidth-1:0], SIn};
	end
	//---------------------------------------------------------------
endmodule
//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
//	File:		$RCSfile: ShiftRegister.V,v $
//	Version:	$Revision: 1.3 $
//	Desc:		A Variable width parallel/serial converter
//	Author:		Greg Gibeling
//	Copyright:	Copyright 2003 UC Berkeley
//	This copyright header must appear in all derivative works.
//-----------------------------------------------------------------------

