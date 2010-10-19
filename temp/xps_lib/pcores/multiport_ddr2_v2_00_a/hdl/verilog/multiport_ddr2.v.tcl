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

!TCL! for {set i 0} {$i < $NUM_PORTS} {incr i} {
   // Memory interface in ${i} (non-shared)
   In${i}_Cmd_Address,
   In${i}_Cmd_RNW,
   In${i}_Cmd_Valid,
   In${i}_Cmd_Tag,
   In${i}_Cmd_Ack,
   In${i}_Rd_Dout,
   In${i}_Rd_Tag,
   In${i}_Rd_Ack,
   In${i}_Rd_Valid,
   In${i}_Wr_Din,
   In${i}_Wr_BE,

!TCL! }

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

!TCL! set PORTS_WIDTH 0
!TCL! for {set i 1} {$i < $NUM_PORTS} {set i [expr $i*2]} {
!TCL! incr PORTS_WIDTH
!TCL! }

   // Parameters
   parameter             C_NUM_PORTS    = ${NUM_PORTS};
   parameter             C_PORTS_WIDTH  = ${PORTS_WIDTH};
   parameter             C_WIDE_DATA    = 0;
   parameter             C_HALF_BURST   = 1;
   parameter             C_BURST_WINDOW = 0;
   parameter             C_BWIND_WIDTH  = 0;

   // System inputs
   input                              Clk;
   input                              Rst;

!TCL! for {set i 0} {$i < $NUM_PORTS} {incr i} {
   // Memory interface in ${i} (non-shared)
   input [31:0]                       In${i}_Cmd_Address;
   input                              In${i}_Cmd_RNW;
   input                              In${i}_Cmd_Valid;
   input [31:0]                       In${i}_Cmd_Tag;
   output                             In${i}_Cmd_Ack;
   output [(144*(C_WIDE_DATA+1))-1:0] In${i}_Rd_Dout;
   output [31:0]                      In${i}_Rd_Tag;
   input                              In${i}_Rd_Ack;
   output                             In${i}_Rd_Valid;
   input [(144*(C_WIDE_DATA+1))-1:0]  In${i}_Wr_Din;
   input [(18*(C_WIDE_DATA+1))-1:0]   In${i}_Wr_BE;

!TCL! }

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
!TCL! for {set i 0} {$i < $NUM_PORTS} {incr i} {
         ${i}:       mux_address = In${i}_Cmd_Address;
!TCL! }
         default: mux_address = 32'hx;
       endcase
     end

   // Tag MUX
   always @( * )
     begin
       case (arb_select)
!TCL! for {set i 0} {$i < $NUM_PORTS} {incr i} {
         ${i}:       mux_tag = In${i}_Cmd_Tag;
!TCL! }
         default: mux_tag = 32'hx;
       endcase
     end

   // RNW MUX
   always @( * )
     begin
       case (arb_select)
!TCL! for {set i 0} {$i < $NUM_PORTS} {incr i} {
         ${i}:       mux_rnw = In${i}_Cmd_RNW;
!TCL! }
         default: mux_rnw = 1'b0;
       endcase
     end

   // Write data MUX
   always @( * )
     begin
       case (arb_select)
!TCL! for {set i 0} {$i < $NUM_PORTS} {incr i} {
         ${i}:       mux_din = In${i}_Wr_Din;
!TCL! }
         default: mux_din = {(144*(C_WIDE_DATA+1)){1'bx}};
       endcase
     end

   // Write BE MUX
   always @( * )
     begin
       case (arb_select)
!TCL! for {set i 0} {$i < $NUM_PORTS} {incr i} {
         ${i}:       mux_be = In${i}_Wr_BE;
!TCL! }
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
!TCL! for {set i [expr $NUM_PORTS-1]} {$i >= 1} {set i [expr $i-1]} {
                        (In${i}_Rd_Ack & (arb_rd_select == ${i})) |
!TCL! }
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

!TCL! for {set i 0} {$i < $NUM_PORTS} {incr i} {
   // Read data and tag ${i}
   assign In${i}_Rd_Dout = Out_Rd_Dout;
   assign In${i}_Rd_Tag = Out_Rd_Tag;
   assign In${i}_Rd_Valid = Out_Rd_Valid & (arb_rd_select == ${i});
   assign In${i}_Cmd_Ack = arb_ack[${i}];

!TCL! }
   
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
!TCL! for {set i [expr $NUM_PORTS-1]} {$i >= 1} {set i [expr $i-1]} {
                     In${i}_Cmd_Valid,
!TCL! }
                     In0_Cmd_Valid
                     };

endmodule
