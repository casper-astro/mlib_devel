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

//----------------------------------------------------------------------------
// arbiter.v - module
//----------------------------------------------------------------------------

module arbiter 
  (
   // System inputs
   Clk,
   Rst,
   En,
   Freeze,

   // Arbitration inputs
   Full,
   Req,

   // Arbitration outputs
   Ack,
   Select
   );
   
   // Parameters
   parameter                  C_NUM_PORTS = 2;
   parameter                  C_PORTS_WIDTH = 1;
   parameter                  C_BURST_WINDOW = 0;
   parameter                  C_BWIND_WIDTH = 0;
   
   // System inputs
   input                      Clk;
   input                      Rst;
   input                      En;
   input                      Freeze;
   
   // Arbitration inputs
   input                      Full;
   input [C_NUM_PORTS-1:0]    Req;
   
   // Arbitration outputs
   output [C_NUM_PORTS-1:0]   Ack;
   output [C_PORTS_WIDTH-1:0] Select;
   
   ///////////////////////////////////////
   //  ____  _                   _      //
   // / ___|(_) __ _ _ __   __ _| |___  //
   // \___ \| |/ _` | '_ \ / _` | / __| //
   //  ___) | | (_| | | | | (_| | \__ \ //
   // |____/|_|\__, |_| |_|\__,_|_|___/ //
   //          |___/                    //
   ///////////////////////////////////////

   reg [C_PORTS_WIDTH-1:0]    Select;
   wire [C_NUM_PORTS-1:0]     ack_int;   
   reg [C_NUM_PORTS-1:0]      last_ack;
   wire [C_NUM_PORTS:0]       pass_ack_L0;
   wire [C_NUM_PORTS-1:0]     pass_ack_L1;

   reg [C_BWIND_WIDTH-1:0]    window_cnt;
   wire                       window_cnt_down;
   wire                       window_cnt_rst;
   reg    [C_NUM_PORTS-1:0]   Ack_frozen;

   /////////////////////////////////////////////////////////////////////////
   //  ____                 _    __        ___           _                //
   // | __ ) _   _ _ __ ___| |_  \ \      / (_)_ __   __| | _____      __ //
   // |  _ \| | | | '__/ __| __|  \ \ /\ / /| | '_ \ / _` |/ _ \ \ /\ / / //
   // | |_) | |_| | |  \__ \ |_    \ V  V / | | | | | (_| | (_) \ V  V /  //
   // |____/ \__,_|_|  |___/\__|    \_/\_/  |_|_| |_|\__,_|\___/ \_/\_/   //
   //                                                                     //
   /////////////////////////////////////////////////////////////////////////
   
   generate
      if (C_BURST_WINDOW != 0)
        begin:gen_bwind_cnt
           assign window_cnt_down = (window_cnt != 0) & |(Req & last_ack);
           assign window_cnt_rst = (window_cnt == 0) | ~( |(Req & last_ack) );
           
           always @( posedge Clk )
             begin
                if (Rst || (window_cnt_rst))
                  window_cnt <= C_BURST_WINDOW;
                else if (window_cnt_down)
                  window_cnt <= window_cnt - 1;
             end
        end
      else
        begin:gen_no_bwind_cnt
           assign window_cnt_down = 1'b0;
           assign window_cnt_rst = 1'b0;
        end
   endgenerate   
   
   ////////////////////////////////////////////////
   //  ____  ____    ____       _           _    //
   // |  _ \|  _ \  / ___|  ___| | ___  ___| |_  //
   // | |_) | |_) | \___ \ / _ \ |/ _ \/ __| __| //
   // |  _ <|  _ <   ___) |  __/ |  __/ (__| |_  //
   // |_| \_\_| \_\ |____/ \___|_|\___|\___|\__| //
   //                                            //
   ////////////////////////////////////////////////
   
   assign pass_ack_L0 = { 1'b0, ~Req } + { 1'b0, last_ack[C_NUM_PORTS-2:0], last_ack[C_NUM_PORTS-1] };
   assign pass_ack_L1 = (~Req) + 1;

   assign ack_int = (window_cnt_down ? last_ack : 
                     ((pass_ack_L0[C_NUM_PORTS] ? pass_ack_L1 : 
                       pass_ack_L0[C_NUM_PORTS-1:0]) & Req));

   assign Ack = Freeze ? Ack_frozen : (Full ? {C_NUM_PORTS{1'b0}} : ack_int) & {C_NUM_PORTS{En}};
   
   always @( posedge Clk )
     begin
	 if (~Freeze)
	   begin
           Ack_frozen    <= Ack;
         end
     end   
   
   always @( posedge Clk )
     begin
	    if (Rst)
	      last_ack <= { 1'b1, {C_NUM_PORTS-1{1'b0}} };
	    else if (|Req && ~Full && En)
	      last_ack <= ack_int;
     end

   //////////////////////////////////////////////
   //   ___  _   _   _          ____  _        //
   //  / _ \| | | | | |_ ___   | __ )(_)_ __   //
   // | | | | |_| | | __/ _ \  |  _ \| | '_ \  //
   // | |_| |  _  | | || (_) | | |_) | | | | | //
   //  \___/|_| |_|  \__\___/  |____/|_|_| |_| //
   //                                          //
   //////////////////////////////////////////////
   
   integer i;
   always @( * )
     begin
	    Select = {C_PORTS_WIDTH{1'bx}}; // Default
	    
	    for (i = 0; i < C_NUM_PORTS; i = (i + 1))
	      begin
	         if (Ack[i] == 1'b1)
	           Select = i;
	      end
     end
   
endmodule