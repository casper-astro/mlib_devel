`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    14:17:52 07/20/05
// Design Name:    
// Module Name:    gen_dec
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

module gen_dec(IN, OUT);

   //----------------------------------------------------------------------
   // Parameters
   //----------------------------------------------------------------------

   parameter          inwidth = 4;
   parameter          outwidth = 16;
   parameter          flip = 0;
   
   //----------------------------------------------------------------------
   // Inputs and outputs
   //----------------------------------------------------------------------

   input [inwidth-1:0] IN;
   output [outwidth-1:0] OUT;

   //----------------------------------------------------------------------
   // Generate decoder
   //----------------------------------------------------------------------

   genvar i;

   generate 
   for (i=0; i < outwidth; i=i+1)
     begin:bit
        if (flip)
          begin:flip
             assign OUT[(outwidth-1)-i] = (IN == i);
          end
        else
          begin:noflip
	     assign OUT[i] = (IN == i);
          end
     end
   endgenerate
   
   //----------------------------------------------------------------------   
   
endmodule
