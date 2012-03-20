`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    14:17:52 07/20/05
// Design Name:    
// Module Name:    ud_count
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

module ud_count(CLK, CNT, LD, L, UP, DOWN, RST);

   //----------------------------------------------------------------------
   // Parameters
   //----------------------------------------------------------------------

   parameter          width = 1;
   
   //----------------------------------------------------------------------
   // Inputs and outputs
   //----------------------------------------------------------------------

   input              CLK;
   input 	      LD;
   input [0:width-1]  L;
   input 	      UP;
   input 	      DOWN;
   input 	      RST;
   
   output [0:width-1] CNT;

   //----------------------------------------------------------------------
   // Register
   //----------------------------------------------------------------------

   reg [0:width-1]    CNT;

   always @( posedge CLK )
     begin
	if (RST)
	  CNT <= {width{1'b0}};
	else if (LD)
	  CNT <= L;
	else if (UP & ~DOWN)
	  CNT <= CNT + 1'b1;
	else if (~UP & DOWN)
	  CNT <= CNT - 1'b1;
	else
	  CNT <= CNT;
     end

   //----------------------------------------------------------------------   
   
endmodule