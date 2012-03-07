//-----------------------------------------------------------------------
//	Module:		IORegister
//	Desc:		Just like a normal register, but forced into the IOB.
//			for use in capturing data from IO pins.  This block is
//			necessary if clock skew unknown to the synthesis tools
//			causes a "normal" register to be unable to capture bus
//			data properly due to clock skew.
//-----------------------------------------------------------------------
module IORegister(Clock, Reset, Set, Enable, In, Out);
	// System Parameters
	// =================
	parameter width = 8;
	
	// Inputs and Outputs
	// ==================
	input			Clock, Enable, Reset, Set;
	input	[width-1:0]	In;
	output	[width-1:0]	Out;
	reg	[width-1:0]	Out;
	// synthesis attribute iob of Out is true;

	always @ (posedge Clock) begin
		if (Reset) Out <= {width{1'b0}};
		else if (Set) Out <= {width{1'b1}};
		else if (Enable) Out <= In;
	end
endmodule
