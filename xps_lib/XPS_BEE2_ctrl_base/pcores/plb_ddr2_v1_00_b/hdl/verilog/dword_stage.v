`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    14:17:52 07/20/05
// Design Name:    
// Module Name:    dword_stage
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

module dword_stage(clk, rst, din, be_in, en, dout, be_out);

   //----------------------------------------------------------------------
   // Inputs and outputs
   //----------------------------------------------------------------------
   
   input         clk;
   input         rst;
   input [0:63]  din;
   input [0:7] 	 be_in;
   input 	 en;
   
   output [0:63] dout;
   output [0:7]  be_out;

   //----------------------------------------------------------------------
   // Special reset, only reset when not enabled (give enable precedence)
   //----------------------------------------------------------------------

   wire          rst_real = rst; //rst & ~en;

   //----------------------------------------------------------------------
   // Individual byte enables (with global enable/disable)
   //----------------------------------------------------------------------

   wire [0:7] 	 en_internal;
   wire [0:7] 	 be_internal = be_in & {8{en}};

   assign 	 be_out = en_internal;

   //----------------------------------------------------------------------
   // Byte enable flip-flops
   //----------------------------------------------------------------------
   
   sr_ff en0( .CLK( clk ),
	      .Q( en_internal[0] ),
	      .SET( be_internal[0] ),
	      .RST( rst_real ) );
   defparam 	 en0.width = 1;

   //----------------------------------------------------------------------

   sr_ff en1( .CLK( clk ),
	      .Q( en_internal[1] ),
	      .SET( be_internal[1] ),
	      .RST( rst_real ) );
   defparam 	 en1.width = 1;

   //----------------------------------------------------------------------

   sr_ff en2( .CLK( clk ),
	      .Q( en_internal[2] ),
	      .SET( be_internal[2] ),
	      .RST( rst_real ) );
   defparam 	 en2.width = 1;

   //----------------------------------------------------------------------

   sr_ff en3( .CLK( clk ),
	      .Q( en_internal[3] ),
	      .SET( be_internal[3] ),
	      .RST( rst_real ) );
   defparam 	 en3.width = 1;

   //----------------------------------------------------------------------

   sr_ff en4( .CLK( clk ),
	      .Q( en_internal[4] ),
	      .SET( be_internal[4] ),
	      .RST( rst_real ) );
   defparam 	 en4.width = 1;

   //----------------------------------------------------------------------

   sr_ff en5( .CLK( clk ),
	      .Q( en_internal[5] ),
	      .SET( be_internal[5] ),
	      .RST( rst_real ) );
   defparam 	 en5.width = 1;

   //----------------------------------------------------------------------

   sr_ff en6( .CLK( clk ),
	      .Q( en_internal[6] ),
	      .SET( be_internal[6] ),
	      .RST( rst_real ) );
   defparam 	 en6.width = 1;

   //----------------------------------------------------------------------

   sr_ff en7( .CLK( clk ),
	      .Q( en_internal[7] ),
	      .SET( be_internal[7] ),
	      .RST( rst_real ) );
   defparam 	 en7.width = 1;

   //----------------------------------------------------------------------
   // Byte stores for staging to double word size
   //----------------------------------------------------------------------  
   
   d_ff byte0( .CLK( clk ),
	       .D( din[0:7] ), 
	       .Q( dout[0:7] ),  
	       .EN( be_internal[0] ), 
	       .RST( rst_real ) );
   defparam 	 byte0.width = 8;

   //----------------------------------------------------------------------  

   d_ff byte1( .CLK( clk ), 
	       .D( din[8:15] ), 
	       .Q( dout[8:15] ), 
	       .EN( be_internal[1] ), 
	       .RST( rst_real ) );
   defparam 	 byte1.width = 8;
   
   //----------------------------------------------------------------------  

   d_ff byte2( .CLK( clk ),
	       .D( din[16:23] ), 
	       .Q( dout[16:23] ),  
	       .EN( be_internal[2] ), 
	       .RST( rst_real ) );
   defparam 	 byte2.width = 8;   

   //----------------------------------------------------------------------  

   d_ff byte3( .CLK( clk ),
	       .D( din[24:31] ), 
	       .Q( dout[24:31] ), 
	       .EN( be_internal[3] ), 
	       .RST( rst_real ) );
   defparam 	 byte3.width = 8;

   //----------------------------------------------------------------------     

   d_ff byte4( .CLK( clk ),
	       .D( din[32:39] ), 
	       .Q( dout[32:39] ), 	       
	       .EN( be_internal[4] ), 
	       .RST( rst_real ) );
   defparam 	 byte4.width = 8;

   //----------------------------------------------------------------------  

   d_ff byte5( .CLK( clk ), 
	       .D( din[40:47] ), 
	       .Q( dout[40:47] ), 
	       .EN( be_internal[5] ), 
	       .RST( rst_real ) );
   defparam 	 byte5.width = 8;
   
   //----------------------------------------------------------------------  

   d_ff byte6( .CLK( clk ),
	       .D( din[48:55] ), 
	       .Q( dout[48:55] ), 	       
	       .EN( be_internal[6] ), 
	       .RST( rst_real ) );
   defparam 	 byte6.width = 8;
   
   //----------------------------------------------------------------------  

   d_ff byte7( .CLK( clk ), 
	       .D( din[56:63] ), 
	       .Q( dout[56:63] ), 
	       .EN( be_internal[7] ), 
	       .RST( rst_real ) );
   defparam 	 byte7.width = 8;

   //----------------------------------------------------------------------
   
endmodule
