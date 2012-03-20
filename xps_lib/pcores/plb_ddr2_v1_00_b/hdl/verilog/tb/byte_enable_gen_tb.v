`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    14:17:52 07/20/05
// Design Name:    
// Module Name:    byte_enable_gen_tb
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

module byte_enable_gen_tb();

   //----------------------------------------------------------------------
   // Test inputs/outputs
   //----------------------------------------------------------------------

   wire [0:3] 	size;
   wire [0:2] 	count;
   reg [0:7] 	be_in;

   wire 	burst;
   wire 	byte;
   wire 	half;
   wire 	word;
   wire [0:7] 	be_out;

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

   reg stop;
   reg [0:6] in_vec;
   assign     size = in_vec[0:3];
   assign     count = in_vec[4:6];

   initial
     begin
	in_vec = 15'h0;
	be_in = 8'hda;
	stop = 1'b0;
     end
   
   always @(negedge CLK)
     begin
	if (stop == 1'b0)
	  begin
	     $display("size:%b count:%b be_in:%b -- burst:%b byte:%b half:%b word:%b be_out:%b",
		      size, count, be_in, burst, byte, half, word, be_out);
	     
	     in_vec = in_vec + 1'b1;
	     
	     if (in_vec == 15'h0)
	       begin
		  $display("Testing complete!");
		  stop = 1'b1;
	       end
	  end
     end
   
   //----------------------------------------------------------------------
   // CUT - byte_enable_gen
   //----------------------------------------------------------------------

   byte_enable_gen CUT( .size( size ),
			.count( count ),
			.be_in( be_in ),
			.burst( burst ),
			.byte( byte ),
			.half( half ),
			.word( word ),
			.be_out( be_out ) );
   
endmodule