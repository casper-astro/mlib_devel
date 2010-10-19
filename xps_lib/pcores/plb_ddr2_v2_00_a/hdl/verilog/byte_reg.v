//  Copyright (c) 2005-2006, Regents of the University of California
//  All rights reserved.
//  
//  Redistribution and use in source and binary forms, with or without modification,
//  are permitted provided that the following conditions are met:
//  
//      - Redistributions of source code must retain the above copyright notice,
//          this list of conditions and the following disclaimer. 
//      - Redistributions in binary form must reproduce the above copyright
//          notice, this list of conditions and the following disclaimer
//          in the documentation and/or other materials provided with the
//          distribution. 
//      - Neither the name of the University of California, Berkeley nor the
//          names of its contributors may be used to endorse or promote
//          products derived from this software without specific prior
//          written permission. 
//  
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
//  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
//  ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

//---------------------------------------------------------------------------
// byte_reg - A register to hold a byte and a corresponding byte enable
//---------------------------------------------------------------------------

`timescale 1ps / 1ps

module byte_reg
  (
   clk,
   rst,
   en,
   din,
   be_in,
   dout,
   be_out
   );

   //----------------------
   // Ports
   //----------------------
   input        clk;
   input        rst;
   input        en;
   input [7:0]  din;
   input        be_in;
   output [7:0] dout;
   output       be_out;

   //----------------------
   // Signals
   //----------------------
   reg [7:0]    data;
   reg          be;
   
   //----------------------
   // Byte register
   //----------------------
   always @( posedge clk )
     begin
        if (en && be_in)
          data <= din;
        else if (rst)
          data <= 8'h0;
     end

   //----------------------
   // Byte enable register
   //----------------------
   always @( posedge clk )
     begin
        if (en && be_in)
          be <= 1'b1;
        else if (rst)
          be <= 1'b0;
     end
   
   //----------------------
   // Outputs
   //----------------------
   assign dout = data;
   assign be_out = be;
   
endmodule