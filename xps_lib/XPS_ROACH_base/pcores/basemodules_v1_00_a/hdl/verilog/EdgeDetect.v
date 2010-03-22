//-----------------------------------------------------------------------
//	File:		$RCSfile: Edgedetect.v,v $
//	Version:	$Revision: 1.5 $
//	Desc:		Shifting Edge Detector, Used for synchronization
//	Author:		Greg Gibeling
//	Copyright:	Copyright 2003 UC Berkeley
//	This copyright header must appear in all derivative works.
//-----------------------------------------------------------------------

//-----------------------------------------------------------------------
//	Section:	Change Log
//-----------------------------------------------------------------------
//	$Log: Edgedetect.v,v $
//	Revision 1.5  2004/07/30 21:15:20  Administrator
//	Reformatted
//	
//	Revision 1.4  2004/06/25 23:11:45  Administrator
//	Added enable signal (for slow clocking)
//	
//	Revision 1.3  2004/06/22 17:46:12  Administrator
//	Added neg and both edge options
//	Note pos is still default for backward compatibility
//	
//	Revision 1.2  2004/06/17 18:59:56  Administrator
//	Added Proper Headers
//	Updated Parameters and Constants
//	General Housekeeping
//	
//-----------------------------------------------------------------------

//-----------------------------------------------------------------------
//	Module:		EdgeDetect
//	Desc:		A simple parameterized, shift-register based
//			positive edge detector.  Note this module is
//			fully moore-tyle, the output is isolated from the
//			input by a single flip-flop.
//	Params:		width:		The number of samples of the
//					input signal to examine
//			upwidth:	The number of consecutive high
//					samples which must appear before
//					the edge is signaled.
//			type:		number	type
//					0	posedge
//					1	negedge
//					2	both
//-----------------------------------------------------------------------
module EdgeDetect(In, Out, Clock, Reset, Enable);
	//---------------------------------------------------------------
	//	Parameters
	//---------------------------------------------------------------
	parameter		width = 		3,
				upwidth = 		2,
				type =			0;
	//---------------------------------------------------------------

	//---------------------------------------------------------------
	//	I/O
	//---------------------------------------------------------------
	input			In;
	output			Out;
	//---------------------------------------------------------------

	//---------------------------------------------------------------
	//	System Inputs
	//---------------------------------------------------------------
	input			Clock, Reset, Enable;
	//---------------------------------------------------------------

	//---------------------------------------------------------------
	//	Registers
	//---------------------------------------------------------------
	reg	[width-1:0]	Q;
	reg			Out;
	//---------------------------------------------------------------

	//---------------------------------------------------------------
	//	Output Decoder
	//---------------------------------------------------------------
	always @ (*) begin
		case (type)
			0:	Out =		(~|(Q[width-1:upwidth])) & (&(Q[upwidth-1:0]));
			1:	Out =		(&(Q[width-1:upwidth])) & (~|(Q[upwidth-1:0]));
			2:	Out =		((~|(Q[width-1:upwidth])) | (&(Q[width-1:upwidth]))) ^ ((~|(Q[upwidth-1:0])) | (&(Q[upwidth-1:0])));
			default:Out =		1'b0;
		endcase
	end
	//---------------------------------------------------------------

	//---------------------------------------------------------------
	//	Behavioural Shift Register
	//---------------------------------------------------------------
	always @ (posedge Clock) begin
		if (Reset) Q <=			0;
		else if (Enable) Q <=		{Q[width-2:0], In};
	end
	//---------------------------------------------------------------
endmodule
//-----------------------------------------------------------------------
