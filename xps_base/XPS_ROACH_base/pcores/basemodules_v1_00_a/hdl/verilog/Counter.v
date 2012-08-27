//-----------------------------------------------------------------------
//	File:		$RCSfile: Counter.V,v $
//	Version:	$Revision: 1.3 $
//	Desc:		A basic counter module
//	Author:		Greg Gibeling
//	Copyright:	Copyright 2003 UC Berkeley
//	This copyright header must appear in all derivative works.
//-----------------------------------------------------------------------

//-----------------------------------------------------------------------
//	Section:	Change Log
//-----------------------------------------------------------------------
//	$Log: Counter.V,v $
//	Revision 1.3  2004/08/06 01:03:58  SYSTEM
//	Added limit parameter
//	Cleaned up
//	Fixed comments
//	
//	Revision 1.2  2004/06/17 18:59:56  Administrator
//	Added Proper Headers
//	Updated Parameters and Constants
//	General Housekeeping
//	
//-----------------------------------------------------------------------

//-----------------------------------------------------------------------
//	Module:		Counter
//	Desc:		A Counter
//	Params:		width:		Sets the bitwidth of the counter
//			limited:	Should the counter saturate?
//	Ex:		Are you kidding me?
//-----------------------------------------------------------------------
module	Counter(Clock, Reset, Set, Load, Enable, In, Count);
	//---------------------------------------------------------------
	//	Parameters
	//---------------------------------------------------------------
	parameter		width = 		32,
				limited =		0;
	//---------------------------------------------------------------

	//---------------------------------------------------------------
	//	I/O
	//---------------------------------------------------------------
	input			Clock, Enable, Reset, Set, Load;
	input	[width-1:0]	In;
	output	[width-1:0]	Count;
	//---------------------------------------------------------------

	//---------------------------------------------------------------
	//	Wires and Regs
	//---------------------------------------------------------------
	reg	[width-1:0]	Count;
	wire			NoLimit;
	//---------------------------------------------------------------

	//---------------------------------------------------------------
	//	Assigns
	//---------------------------------------------------------------
	assign	NoLimit =				!limited;
	//---------------------------------------------------------------

	//---------------------------------------------------------------
	//	Behavioral Counter (with Set/Reset)
	//---------------------------------------------------------------
	always @ (posedge Clock) begin
		if (Reset) Count <=						{width{1'b0}};
		else if (Set) Count <=						{width{1'b1}};
		else if (Load) Count <=						In;
		else if (Enable & (NoLimit | ~&Count)) Count <=			Count + 1;
	end
	//---------------------------------------------------------------
endmodule
//-----------------------------------------------------------------------