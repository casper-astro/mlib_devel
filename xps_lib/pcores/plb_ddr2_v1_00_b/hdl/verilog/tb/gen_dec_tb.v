`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    14:17:52 07/20/05
// Design Name:    
// Module Name:    gen_dec_tb
// Project Name:   
// Target Device:  
// Tool versions:  
// Description:
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module gen_dec_tb();

   //----------------------------------------------------------------------
   // Test inputs/outputs
   //----------------------------------------------------------------------

   reg [0:3] in;
   wire [0:15] out;

   //----------------------------------------------------------------------
   // System testing clock
   //----------------------------------------------------------------------

   reg 		CLK = 1'b0;

   always
     begin
	#10 CLK = ~CLK;
     end
   
   //----------------------------------------------------------------------
   // Create test vectors for CUT
   //----------------------------------------------------------------------

   initial
     begin
	in = 4'h0;
     end
   
   always @(negedge CLK)
     begin
	in = in + 1'b1;
	     
	if (in == 4'h0)
	  begin
	     $display("Testing complete!");
	  end
     end

   always @(posedge CLK)
     begin
	$display("in:%h out:%b\n", in, out);
     end
   
   //----------------------------------------------------------------------
   // CUT - gen_dec
   //----------------------------------------------------------------------

   gen_dec CUT( .IN( in ),
		.OUT( out ) );
   defparam CUT.inwidth = 4;
   defparam CUT.outwidth = 16;
   
endmodule