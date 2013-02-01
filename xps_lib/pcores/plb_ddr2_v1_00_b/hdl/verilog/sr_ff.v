`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    14:17:52 07/20/05
// Design Name:    
// Module Name:    sr_ff
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

module sr_ff(CLK, Q, SET, RST);

   //----------------------------------------------------------------------
   // Parameters
   //----------------------------------------------------------------------

   parameter          width = 1;
   
   //----------------------------------------------------------------------
   // Inputs and outputs
   //----------------------------------------------------------------------

   input              CLK;
   input 	      SET;
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
	else if (SET)
	  Q <= {width{1'b1}};
	else
	  Q <= Q;
     end

   //----------------------------------------------------------------------   
   
endmodule