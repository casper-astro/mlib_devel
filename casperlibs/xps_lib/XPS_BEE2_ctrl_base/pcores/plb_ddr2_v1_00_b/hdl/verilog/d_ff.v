`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    14:17:52 07/20/05
// Design Name:    
// Module Name:    d_ff
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

module d_ff(CLK, D, Q, EN, RST);

   //----------------------------------------------------------------------
   // Parameters
   //----------------------------------------------------------------------

   parameter          width = 1;
   
   //----------------------------------------------------------------------
   // Inputs and outputs
   //----------------------------------------------------------------------

   input              CLK;
   input [0:width-1]  D;
   input 	      EN;
   input 	      RST;
   
   output [0:width-1] Q;

   //----------------------------------------------------------------------
   // Register
   //----------------------------------------------------------------------

   reg [0:width-1]    Q;

   always @( posedge CLK )
     begin
	if (RST)
	  Q <= {width{1'b0}};
	else if (EN)
	  Q <= D;
	else
	  Q <= Q;
     end

   //----------------------------------------------------------------------   
   
endmodule