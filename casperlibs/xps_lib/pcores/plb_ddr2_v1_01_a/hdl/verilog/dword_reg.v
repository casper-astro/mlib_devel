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
// dword_reg - A register to hold a dbl word and a corresponding byte enable
//---------------------------------------------------------------------------

`timescale 1ps / 1ps

module dword_reg
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
   input         clk;
   input         rst;
   input         en;
   input [63:0]  din;
   input [7:0]   be_in;
   output [63:0] dout;
   output [7:0]  be_out;

   //----------------------
   // Byte register blocks
   //----------------------
   genvar i;
   
   generate
      for (i=0; i < 8; i=i+1)
        begin:byte_reg_inst
           byte_reg b0( .clk( clk ),
                        .rst( rst ),
                        .en( en ),
                        .din( din[(((i+1)*8)-1):(i*8)] ),
                        .be_in( be_in[i] ),
                        .dout( dout[(((i+1)*8)-1):(i*8)] ),
                        .be_out( be_out[i] )
                        );
        end
   endgenerate
   
endmodule