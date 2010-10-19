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
// multiport_ddr2.v - module
//----------------------------------------------------------------------------

module multiport_ddr2
  (
   // System inputs
   Clk,
   Rst,

   // Memory interface in 0 (non-shared)
   In0_Cmd_Address,
   In0_Cmd_RNW,
   In0_Cmd_Valid,
   In0_Cmd_Tag,
   In0_Cmd_Ack,
   In0_Rd_Dout,
   In0_Rd_Tag,
   In0_Rd_Ack,
   In0_Rd_Valid,
   In0_Wr_Din,
   In0_Wr_BE,

   // Memory interface in 1 (non-shared)
   In1_Cmd_Address,
   In1_Cmd_RNW,
   In1_Cmd_Valid,
   In1_Cmd_Tag,
   In1_Cmd_Ack,
   In1_Rd_Dout,
   In1_Rd_Tag,
   In1_Rd_Ack,
   In1_Rd_Valid,
   In1_Wr_Din,
   In1_Wr_BE,


   // Memory interface out (shared)
   Out_Cmd_Address,
   Out_Cmd_RNW,
   Out_Cmd_Valid,
   Out_Cmd_Tag,
   Out_Cmd_Ack,
   Out_Rd_Dout,
   Out_Rd_Tag,
   Out_Rd_Ack,
   Out_Rd_Valid,
   Out_Wr_Din,
   Out_Wr_BE
   );


   // Parameters
   parameter             C_NUM_PORTS    = 2;
   parameter             C_PORTS_WIDTH  = 1;
   parameter             C_WIDE_DATA    = 0;
   parameter             C_HALF_BURST   = 1;
   parameter             C_BURST_WINDOW = 0;
   parameter             C_BWIND_WIDTH  = 0;

   // System inputs
   input                              Clk;
   input                              Rst;

   // Memory interface in 0 (non-shared)
   input [31:0]                       In0_Cmd_Address;
   input                              In0_Cmd_RNW;
   input                              In0_Cmd_Valid;
   input [31:0]                       In0_Cmd_Tag;
   output                             In0_Cmd_Ack;
   output [(144*(C_WIDE_DATA+1))-1:0] In0_Rd_Dout;
   output [31:0]                      In0_Rd_Tag;
   input                              In0_Rd_Ack;
   output                             In0_Rd_Valid;
   input [(144*(C_WIDE_DATA+1))-1:0]  In0_Wr_Din;
   input [(18*(C_WIDE_DATA+1))-1:0]   In0_Wr_BE;

   // Memory interface in 1 (non-shared)
   input [31:0]                       In1_Cmd_Address;
   input                              In1_Cmd_RNW;
   input                              In1_Cmd_Valid;
   input [31:0]                       In1_Cmd_Tag;
   output                             In1_Cmd_Ack;
   output [(144*(C_WIDE_DATA+1))-1:0] In1_Rd_Dout;
   output [31:0]                      In1_Rd_Tag;
   input                              In1_Rd_Ack;
   output                             In1_Rd_Valid;
   input [(144*(C_WIDE_DATA+1))-1:0]  In1_Wr_Din;
   input [(18*(C_WIDE_DATA+1))-1:0]   In1_Wr_BE;


   // Memory interface out (shared)
   output [31:0]                      Out_Cmd_Address;
   output                             Out_Cmd_RNW;
   output                             Out_Cmd_Valid;
   output [31:0]                      Out_Cmd_Tag;
   input                              Out_Cmd_Ack;
   input [(144*(C_WIDE_DATA+1))-1:0]  Out_Rd_Dout;
   input [31:0]                       Out_Rd_Tag;
   output                             Out_Rd_Ack;
   input                              Out_Rd_Valid;
   output [(144*(C_WIDE_DATA+1))-1:0] Out_Wr_Din;
   output [(18*(C_WIDE_DATA+1))-1:0]  Out_Wr_BE;

   ///////////////////////////////////////
   //  ____  _                   _      //
   // / ___|(_) __ _ _ __   __ _| |___  //
   // \___ \| |/ _` | '_ \ / _` | / __| //
   //  ___) | | (_| | | | | (_| | \__ \ //
   // |____/|_|\__, |_| |_|\__,_|_|___/ //
   //          |___/                    //
   ///////////////////////////////////////

   // Arbitration signals
   wire [C_PORTS_WIDTH-1:0]        arb_select;
   wire [C_PORTS_WIDTH-1:0]        arb_rd_select;
   wire                            arb_rd_full;
   wire [(C_NUM_PORTS)-1:0]        arb_req;
   wire [(C_NUM_PORTS)-1:0]        arb_ack;
   reg                             arb_freeze;

   // MUX signals
   reg [31:0]                      mux_address;
   reg [31:0]                      mux_tag;
   reg                             mux_rnw;
   reg [(144*(C_WIDE_DATA+1))-1:0] mux_din;
   reg [(18*(C_WIDE_DATA+1))-1:0]  mux_be;

   // FIFO signals
   reg                             selfifo_rden_mask;
   wire                            selfifo_empty;

   /////////////////////////////////////////////////////////
   //  ___                   _     __  __ _   ___  __     //
   // |_ _|_ __  _ __  _   _| |_  |  \/  | | | \ \/ /___  //
   //  | || '_ \| '_ \| | | | __| | |\/| | | | |\  // __| //
   //  | || | | | |_) | |_| | |_  | |  | | |_| |/  \\__ \ //
   // |___|_| |_| .__/ \__,_|\__| |_|  |_|\___//_/\_\___/ //
   //           |_|                                       //
   /////////////////////////////////////////////////////////

   // Address MUX
   always @( * )
     begin
       case (arb_select)
         0:       mux_address = In0_Cmd_Address;
         1:       mux_address = In1_Cmd_Address;
         default: mux_address = 32'hx;
       endcase
     end

   // Tag MUX
   always @( * )
     begin
       case (arb_select)
         0:       mux_tag = In0_Cmd_Tag;
         1:       mux_tag = In1_Cmd_Tag;
         default: mux_tag = 32'hx;
       endcase
     end

   // RNW MUX
   always @( * )
     begin
       case (arb_select)
         0:       mux_rnw = In0_Cmd_RNW;
         1:       mux_rnw = In1_Cmd_RNW;
         default: mux_rnw = 1'b0;
       endcase
     end

   // Write data MUX
   always @( * )
     begin
       case (arb_select)
         0:       mux_din = In0_Wr_Din;
         1:       mux_din = In1_Wr_Din;
         default: mux_din = {(144*(C_WIDE_DATA+1)){1'bx}};
       endcase
     end

   // Write BE MUX
   always @( * )
     begin
       case (arb_select)
         0:       mux_be = In0_Wr_BE;
         1:       mux_be = In1_Wr_BE;
         default: mux_be = {(18*(C_WIDE_DATA+1)){1'bx}};
       endcase
     end

   /////////////////////////////////////////////////////////
   //  __  __                  ___                   _    //
   // |  \/  | ___ _ __ ___   |_ _|_ __  _ __  _   _| |_  //
   // | |\/| |/ _ \ '_ ` _ \   | || '_ \| '_ \| | | | __| //
   // | |  | |  __/ | | | | |  | || | | | |_) | |_| | |_  //
   // |_|  |_|\___|_| |_| |_| |___|_| |_| .__/ \__,_|\__| //
   //                                   |_|               //
   /////////////////////////////////////////////////////////

   // Address, tag, and command type
   assign Out_Cmd_RNW = mux_rnw;
   assign Out_Cmd_Address = mux_address;
   assign Out_Cmd_Tag = mux_tag;

   // Command valid
   assign Out_Cmd_Valid = |arb_req && ~(Out_Cmd_RNW && arb_rd_full);

   // Write data and byte enables
   assign Out_Wr_Din = mux_din;
   assign Out_Wr_BE =  mux_be;

   // Read acknowledge
   assign Out_Rd_Ack = (
                        (In1_Rd_Ack & (arb_rd_select == 1)) |
                        (In0_Rd_Ack & (arb_rd_select == 0))
                        );    

   ///////////////////////////////////////////////////////////////////////
   //  ____       _           _   _               _____ ___ _____ ___   //
   // / ___|  ___| | ___  ___| |_(_) ___  _ __   |  ___|_ _|  ___/ _ \  //
   // \___ \ / _ \ |/ _ \/ __| __| |/ _ \| '_ \  | |_   | || |_ | | | | //
   //  ___) |  __/ |  __/ (__| |_| | (_) | | | | |  _|  | ||  _|| |_| | //
   // |____/ \___|_|\___|\___|\__|_|\___/|_| |_| |_|   |___|_|   \___/  //
   //                                                                   //
   ///////////////////////////////////////////////////////////////////////

   generate
     if ( C_HALF_BURST == 1 || C_WIDE_DATA == 1)
       begin:hb_selfifo
         fifo_sync #( .D_WIDTH( C_PORTS_WIDTH ),
                      .A_WIDTH( 9 ),
                      .DEPTH( 512 )
                     )
           fifo_sync_0( .clk( Clk ),
                        .rst( Rst ),
                        .din( arb_select ),
                        .wr_en( Out_Cmd_Valid & Out_Cmd_Ack & Out_Cmd_RNW ),
                        .dout( arb_rd_select ),
                        .rd_en( Out_Rd_Valid & Out_Rd_Ack ),
                        .empty(  ),
                        .full( arb_rd_full )
                        );
       end
     else
       begin:fb_selfifo
         // Selection FIFO control state machine
         always @ (posedge Clk)
         begin
           if (Rst)
             selfifo_rden_mask <= 1'b0;
           else
             begin
               if ( Out_Rd_Valid & Out_Rd_Ack & ~selfifo_empty )
                 selfifo_rden_mask <= ~selfifo_rden_mask;
             end
         end
         fifo_sync #( .D_WIDTH( C_PORTS_WIDTH ),
                      .A_WIDTH( 9 ),
                      .DEPTH( 512 )
                     )
           fifo_sync_0( .clk( Clk ),
                        .rst( Rst ),
                        .din( arb_select ),
                        .wr_en( Out_Cmd_Valid & Out_Cmd_Ack & Out_Cmd_RNW ),
                        .dout( arb_rd_select ),
                        .rd_en( Out_Rd_Valid & Out_Rd_Ack & selfifo_rden_mask),
                        .empty( selfifo_empty ),
                        .full( arb_rd_full )
                        );
       end
   endgenerate

   ///////////////////////////////////////////////////////////////
   //  __  __                   ___        _               _    //
   // |  \/  | ___ _ __ ___    / _ \ _   _| |_ _ __  _   _| |_  //
   // | |\/| |/ _ \ '_ ` _ \  | | | | | | | __| '_ \| | | | __| //
   // | |  | |  __/ | | | | | | |_| | |_| | |_| |_) | |_| | |_  //
   // |_|  |_|\___|_| |_| |_|  \___/ \__,_|\__| .__/ \__,_|\__| //
   //                                         |_|               //
   ///////////////////////////////////////////////////////////////

   // Read data and tag 0
   assign In0_Rd_Dout = Out_Rd_Dout;
   assign In0_Rd_Tag = Out_Rd_Tag;
   assign In0_Rd_Valid = Out_Rd_Valid & (arb_rd_select == 0);
   assign In0_Cmd_Ack = arb_ack[0];

   // Read data and tag 1
   assign In1_Rd_Dout = Out_Rd_Dout;
   assign In1_Rd_Tag = Out_Rd_Tag;
   assign In1_Rd_Valid = Out_Rd_Valid & (arb_rd_select == 1);
   assign In1_Cmd_Ack = arb_ack[1];

   
   /////////////////////////////////////////
   //     _         _     _ _             //
   //    / \   _ __| |__ (_) |_ ___ _ __  //
   //   / _ \ | '__| '_ \| | __/ _ \ '__| //
   //  / ___ \| |  | |_) | | ||  __/ |    //
   // /_/   \_\_|  |_.__/|_|\__\___|_|    //
   //                                     //
   /////////////////////////////////////////

   generate
     if (C_HALF_BURST == 1 || C_WIDE_DATA == 1)
       begin:hb_arbiter
         // Arbiter
         arbiter #( .C_NUM_PORTS( C_NUM_PORTS ),
                    .C_PORTS_WIDTH( C_PORTS_WIDTH ),
                    .C_BURST_WINDOW( C_BURST_WINDOW ),
                    .C_BWIND_WIDTH( C_BWIND_WIDTH )
                   )
           arbiter_0
             ( .Clk( Clk ),
               .Rst( Rst ),
               .En( Out_Cmd_Ack ),
               .Freeze( 1'b0 ),
               .Full( arb_rd_full ),
               .Req( arb_req ),
               .Ack( arb_ack ),
               .Select( arb_select )
              );
       end
     else
       begin:fb_arbiter
         // Arbiter control state machine
         always @ (posedge Clk)
         begin
           if (Rst)
             arb_freeze <= 1'b0;
           else
             begin
               if (Out_Cmd_Ack & Out_Cmd_Valid & ~Out_Cmd_RNW)
                 arb_freeze <= ~arb_freeze;
             end
         end
         // Arbiter
         arbiter #( .C_NUM_PORTS( C_NUM_PORTS ),
                    .C_PORTS_WIDTH( C_PORTS_WIDTH ),
                    .C_BURST_WINDOW( C_BURST_WINDOW ),
                    .C_BWIND_WIDTH( C_BWIND_WIDTH )
                   )
            arbiter_0
             ( .Clk( Clk ),
               .Rst( Rst ),
               .En( Out_Cmd_Ack),
               .Freeze( arb_freeze && ~Out_Cmd_RNW ),
               .Full( arb_rd_full ),
               .Req( arb_req ),
               .Ack( arb_ack ),
               .Select( arb_select )
              );
       end
   endgenerate

   // Concatenate arbiter request signals
   assign arb_req = {
                     In1_Cmd_Valid,
                     In0_Cmd_Valid
                     };

endmodule

