`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    14:17:52 07/20/05
// Design Name:    
// Module Name:    byte_enable_gen
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

module byte_enable_gen(size, count, be_in, burst, byte, half, word, be_out);

   //----------------------------------------------------------------------
   // Inputs and outputs
   //----------------------------------------------------------------------

   input [0:3] 	size;
   input [0:2] 	count;
   input [0:7] 	be_in;
   
   output 	burst;
   output 	byte;
   output 	half;
   output 	word;
   output [0:7] be_out;

   //----------------------------------------------------------------------
   // Size decoder
   //----------------------------------------------------------------------

   wire [0:7] 	size_dec_out;
   
   assign 	burst = size[0];
   assign       byte = size_dec_out[7];
   assign 	half = size_dec_out[6];
   assign 	word = size_dec_out[5];

   gen_dec size_dec( .IN( size[1:3] ),
		     .OUT( size_dec_out ) );
   defparam 	size_dec.inwidth = 3;
   defparam 	size_dec.outwidth = 8;
   
   //----------------------------------------------------------------------
   // Byte enable generation
   //----------------------------------------------------------------------

   wire [0:7] 	be_internal;
   wire 	all_en = ~burst | (~byte & ~half & ~word);   

   assign be_internal[0] = 
	  all_en | 
	  (word & ~count[2]) | 
	  (half & ~count[1] & ~count[2]) |
	  (byte & ~count[0] & ~count[1] & ~count[2]);

   assign be_internal[1] = 
	  all_en | 
	  (word & ~count[2]) | 
	  (half & ~count[1] & ~count[2]) |
	  (byte & ~count[0] & ~count[1] & count[2]);

   assign be_internal[2] = 
	  all_en | 
	  (word & ~count[2]) | 
	  (half & ~count[1] & count[2]) |
	  (byte & ~count[0] & count[1] & ~count[2]);

   assign be_internal[3] = 
	  all_en | 
	  (word & ~count[2]) | 
	  (half & ~count[1] & count[2]) |
	  (byte & ~count[0] & count[1] & count[2]);

   assign be_internal[4] = 
	  all_en | 
	  (word & count[2]) | 
	  (half & count[1] & ~count[2]) |
	  (byte & count[0] & ~count[1] & ~count[2]);

   assign be_internal[5] = 
	  all_en | 
	  (word & count[2]) | 
	  (half & count[1] & ~count[2]) |
	  (byte & count[0] & ~count[1] & count[2]);
   
   assign be_internal[6] = 
	  all_en | 
	  (word & count[2]) | 
	  (half & count[1] & count[2]) |
	  (byte & count[0] & count[1] & ~count[2]);

   assign be_internal[7] = 
	  all_en | 
	  (word & count[2]) | 
	  (half & count[1] & count[2]) |
	  (byte & count[0] & count[1] & count[2]);

   //----------------------------------------------------------------------
   // Byte enable pass through MUX
   //----------------------------------------------------------------------

   assign 	be_out = ( |size ) ? be_internal : be_in;   

endmodule
