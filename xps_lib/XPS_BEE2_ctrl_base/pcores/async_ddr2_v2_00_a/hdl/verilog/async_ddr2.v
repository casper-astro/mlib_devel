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
// async_ddr2.v - module
//----------------------------------------------------------------------------

`timescale 1ps / 1ps

module async_ddr2
  (
   // -- Mem cmd ports ---------------
   Mem_Clk,
   Mem_Rst,
   Mem_Cmd_Address,
   Mem_Cmd_RNW,
   Mem_Cmd_Valid,
   Mem_Cmd_Tag,
   Mem_Cmd_Ack,
   Mem_Rd_Dout,
   Mem_Rd_Tag,
   Mem_Rd_Ack,
   Mem_Rd_Valid,
   Mem_Wr_Din,
   Mem_Wr_BE,

   // -- DDR2 ports ---------------
   DDR_clk,
   DDR_input_data,
   DDR_byte_enable,
   DDR_get_data,
   DDR_output_data,
   DDR_data_valid,
   DDR_address,
   DDR_read,
   DDR_write,
   DDR_half_burst,
   DDR_ready,
   DDR_reset
   );

   parameter                           C_WIDE_DATA = 0;
   parameter                           C_HALF_BURST = 0;

   // -- Mem cmd ports -----------------
   input                               Mem_Clk;
   input                               Mem_Rst;
   input [31:0]                        Mem_Cmd_Address;
   input                               Mem_Cmd_RNW;
   input                               Mem_Cmd_Valid;
   input [31:0]                        Mem_Cmd_Tag;
   output                              Mem_Cmd_Ack;

   output [(144*(C_WIDE_DATA+1))-1:0]  Mem_Rd_Dout;
   output [31:0]                       Mem_Rd_Tag;
   input                               Mem_Rd_Ack;
   output                              Mem_Rd_Valid;

   input [(144*(C_WIDE_DATA+1))-1:0]   Mem_Wr_Din;
   input [(18*(C_WIDE_DATA+1))-1:0]    Mem_Wr_BE;

   // -- DDR2 ports -----------------
   input                               DDR_clk;
   output [143:0]                      DDR_input_data;
   output [17:0]                       DDR_byte_enable;
   input                               DDR_get_data;
   input [143:0]                       DDR_output_data;
   input                               DDR_data_valid;
   output [31:0]                       DDR_address;
   output                              DDR_read;
   output                              DDR_write;
   output                              DDR_half_burst;
   input                               DDR_ready;
   output                              DDR_reset;

   //----------------------------------------------------------------------------
   // Implementation
   //----------------------------------------------------------------------------

   //   ____  _                   _       //
   //  / ___|(_) __ _ _ __   __ _| |___   //
   //  \___ \| |/ _` | '_ \ / _` | / __|  //
   //   ___) | | (_| | | | | (_| | \__ \  //
   //  |____/|_|\__, |_| |_|\__,_|_|___/  //
   //           |___/                     //

   ////
   // Command signals
   ////
   wire                              mem_cmd_full;

   ////
   // Command FIFO
   ////
   wire                              cmd_full;
   wire                              cmd_empty;
   wire [28:0]                       cmd_out;

   ////
   // Tag FIFO
   ////
   wire                              tag_empty;
   wire                              tag_full;
   wire                              tag_rd_en;
   wire                              nwd_tag_rd_en;


   ////
   // Write FIFO
   ////
   wire                              wr_data_full;
   wire                              wr_data_full_0;
   wire                              wr_data_full_1;
   wire                              wr_be_full;
   wire                              wr_data_empty;
   wire                              wr_data_empty_0;
   wire                              wr_data_empty_1;
   wire                              wr_be_empty;
   wire                              write_wr_en;

   ////
   // Read FIFO
   ////
   wire                              rd_data_full;
   wire                              rd_data_full_0;
   wire                              rd_data_full_1;
   wire                              rd_data_empty;
   wire                              rd_data_empty_0;
   wire                              rd_data_empty_1;
   wire [(144*(C_WIDE_DATA+1))-1:0]  rd_dout;

   //   ____  ____  ____     ____               _   //
   //  |  _ \|  _ \|  _ \   / ___|_ __ ___   __| |  //
   //  | | | | | | | |_) | | |   | '_ ` _ \ / _` |  //
   //  | |_| | |_| |  _ <  | |___| | | | | | (_| |  //
   //  |____/|____/|_| \_\  \____|_| |_| |_|\__,_|  //
   //                                               //

   assign #50 DDR_half_burst = ((C_HALF_BURST == 1) && (C_WIDE_DATA == 0)) ? 1'b1 : 1'b0;
   assign #50 DDR_reset = Mem_Rst;
   assign #50 DDR_address = {1'b0, cmd_out[27:0], 3'b000 };
   assign #50 DDR_write = (DDR_ready & ~cmd_out[28] & ~cmd_empty & ~wr_data_empty & ~wr_be_empty);
   assign #50 DDR_read = (DDR_ready & cmd_out[28] & ~cmd_empty & ~rd_data_full);

   //    ____               _   _____ ___ _____ ___    //
   //   / ___|_ __ ___   __| | |  ___|_ _|  ___/ _ \   //
   //  | |   | '_ ` _ \ / _` | | |_   | || |_ | | | |  //
   //  | |___| | | | | | (_| | |  _|  | ||  _|| |_| |  //
   //   \____|_| |_| |_|\__,_| |_|   |___|_|   \___/   //
   //                                                  //

   ////
   // Command counters
   ////
   reg    			wr_cmd_cnt;
   reg    			rd_cmd_cnt;
   reg [7:0]		rst_cmd_cnt;

   always @( posedge Mem_Clk )
     begin
        if (Mem_Rst)
          wr_cmd_cnt <= 1'b0;
        else if (~Mem_Cmd_RNW & Mem_Cmd_Valid)
          wr_cmd_cnt <= ~wr_cmd_cnt;
     end

   always @( posedge Mem_Clk )
     begin
        if (Mem_Rst)
          rd_cmd_cnt <= 1'b0;
        else if (tag_rd_en)
          rd_cmd_cnt <= ~rd_cmd_cnt;
     end

   always @( posedge Mem_Clk )
     begin
     	if (Mem_Rst)
     	  rst_cmd_cnt <= 8'h1;
     	else
     	  rst_cmd_cnt <= { rst_cmd_cnt[6:0], 1'b0 };
     end

   assign #50 tag_rd_en = Mem_Rd_Ack && Mem_Rd_Valid;
   assign #50 nwd_tag_rd_en = rd_cmd_cnt && Mem_Rd_Ack && Mem_Rd_Valid;

   ////
   // Read tag fifo (FWFT)
   ////
   generate
      if ((C_WIDE_DATA == 0) && (C_HALF_BURST == 0))
        begin:nwd_tag_fifo
           tag_fifo_32_32_1024
             tag_fifo_0( .din( Mem_Cmd_Tag ),
                         .rd_en( nwd_tag_rd_en ),
                         .rd_clk( Mem_Clk ),
                         .wr_clk( Mem_Clk ),
                         .rst( Mem_Rst ),
                         .wr_en( Mem_Cmd_Valid & Mem_Cmd_Ack & Mem_Cmd_RNW ),
                         .dout( Mem_Rd_Tag ),
                         .empty( tag_empty ),
                         .full( tag_full )
                         );
        end
      else
        begin:wd_tag_fifo
           tag_fifo_32_32_1024
             tag_fifo_0( .din( Mem_Cmd_Tag ),
                         .rd_en( tag_rd_en ),
                         .rd_clk( Mem_Clk ),
                         .wr_clk( Mem_Clk ),
                         .rst( Mem_Rst ),
                         .wr_en( Mem_Cmd_Valid & Mem_Cmd_Ack & Mem_Cmd_RNW ),
                         .dout( Mem_Rd_Tag ),
                         .empty( tag_empty ),
                         .full( tag_full )
                         );
        end
   endgenerate

   ////
   // Command and address fifo (FWFT)
   ////

   assign Mem_Cmd_Ack = Mem_Cmd_Valid & ~mem_cmd_full & ~wr_data_full;
   assign mem_cmd_full = cmd_full | |rst_cmd_cnt | Mem_Rst;

   generate
     if ((C_WIDE_DATA == 0) && (C_HALF_BURST == 0))
       begin:nwd_cmd_fifo
          //
          // In no MUX mode we only want to allow buffering for 256
          // commands.  This is a decision to make the no-MUX mode
          // more efficient in terms of block RAM.  Since the BRAMs
          // used for the data FIFOs already afford 512 entries (but
          // we need 2 per command) the command FIFO should only hold
          // 256 commands.  Also note that we only insert a new command
          // every two cmd_valid's (we accept the first, whose address
          // should be the 32-byte aligned address where the burst should
          // be written)
          //
          cmd_addr_fifo_29_29_256
            cmd_addr_fifo_0( .din( { Mem_Cmd_RNW, Mem_Cmd_Address[30:3] } ),
                             .rd_clk( DDR_clk ),
                             .rd_en( DDR_write | DDR_read ),
                             .rst( Mem_Rst ),
                             .wr_clk( Mem_Clk ),
                             .wr_en( (~Mem_Cmd_RNW & ~wr_cmd_cnt & Mem_Cmd_Ack) | (Mem_Cmd_RNW & Mem_Cmd_Ack) ),
                             .dout( cmd_out ),
                             .empty( cmd_empty ),
                             .full( cmd_full )
                             );
       end
     else
       begin:wd_cmd_fifo
          //
          // In wide (or half burst) mode we can have 512 commands because the command
          // corresponds to one of the 34-byte transfer units.  Since we are
          // already burning 8 36x512 BRAMs for each transfer unit we might
          // as well let the FIFO have 512 outstanding commands.
          //
          cmd_addr_fifo_29_29_512
            cmd_addr_fifo_0( .din( { Mem_Cmd_RNW, Mem_Cmd_Address[30:3] } ),
                             .rd_clk( DDR_clk ),
                             .rd_en( DDR_read | DDR_write ),
                             .rst( Mem_Rst ),
                             .wr_clk( Mem_Clk ),
                             .wr_en( Mem_Cmd_Ack ),
                             .dout( cmd_out ),
                             .empty( cmd_empty ),
                             .full( cmd_full )
                             );
       end
   endgenerate

   //  __        __    _ _         _____ ___ _____ ___    //
   //  \ \      / / __(_) |_ ___  |  ___|_ _|  ___/ _ \   //
   //   \ \ /\ / / '__| | __/ _ \ | |_   | || |_ | | | |  //
   //    \ V  V /| |  | | ||  __/ |  _|  | ||  _|| |_| |  //
   //     \_/\_/ |_|  |_|\__\___| |_|   |___|_|   \___/   //
   //                                                     //

   assign write_wr_en = Mem_Cmd_Ack & ~Mem_Cmd_RNW;

   generate
      if (C_WIDE_DATA == 0)
        begin:nwd_wr_fifo

           wire [161:0] wr_dout;
           wire         int_wr_data_prog_empty;
           wire         int_wr_data_emtpy;

           //
           // A single 162-bit FIFO suffices for both the 144-bits
           // of data and the corresponding 18-bit byte enables
           //

           ////
           // DDR write data and byte enable fifo (STD, 1 prog-empty)
           ////
           wr_data_be_fifo_162_162_512
             wr_data_be_fifo_0( .din( { Mem_Wr_BE, Mem_Wr_Din } ),
                                .rd_clk( DDR_clk ),
                                .rd_en( DDR_get_data ),
                                .rst( Mem_Rst ),
                                .wr_clk( Mem_Clk ),
                                .wr_en( write_wr_en ),
                                .dout( wr_dout ),
                                .full( wr_data_full ),
                                .empty( int_wr_data_empty),
                                .prog_empty( int_wr_data_prog_empty )
                                );

           assign       #50 DDR_byte_enable = wr_dout[161:144];
           assign       #50 DDR_input_data = wr_dout[143:0];
           assign       wr_data_empty = ((C_HALF_BURST == 0) ? int_wr_data_prog_empty : int_wr_data_empty);
           assign       wr_be_empty = wr_data_empty;
           assign       wr_be_full = wr_data_full;
        end
      else
        begin:wd_wr_fifo
           //
           // In USE_MUX mode we have to split the 288-bit transfer unit into
           // two asyncronous FIFOs b/c the largest width coregen supports
           // is 256-bits.  We need to interleave the inputs properly since
           // the two FIFOs are 144-bit input and 72-bit output.
           //

           ////
           // DDR data fifo 0 (STD)
           ////
           wr_data_fifo_144_72_512
             wr_data_fifo_0( .din( { Mem_Wr_Din[215:144], Mem_Wr_Din[71:0] } ),
                             .rd_clk( DDR_clk ),
                             .rd_en( DDR_get_data ),
                             .rst( Mem_Rst ),
                             .wr_clk( Mem_Clk ),
                             .wr_en( write_wr_en ),
                             .dout( DDR_input_data[71:0] ),
                             .full( wr_data_full_0 ),
                             .empty( wr_data_empty_0 )
                             );

           ////
           // DDR data fifo 1 (STD)
           ////
           wr_data_fifo_144_72_512
             wr_data_fifo_1( .din( { Mem_Wr_Din[287:216], Mem_Wr_Din[143:72] } ),
                             .rd_clk( DDR_clk ),
                             .rd_en( DDR_get_data ),
                             .rst( Mem_Rst ),
                             .wr_clk( Mem_Clk ),
                             .wr_en( write_wr_en ),
                             .dout( DDR_input_data[143:72] ),
                             .full( wr_data_full_1 ),
                             .empty( wr_data_empty_1 )
                             );

           ////
           // DDR byte enable fifo (STD)
           ////
           wr_be_fifo_36_18_512
             wr_be_fifo_0( .din( Mem_Wr_BE ),
                           .rd_clk( DDR_clk ),
                           .rd_en( DDR_get_data ),
                           .rst( Mem_Rst ),
                           .wr_clk( Mem_Clk ),
                           .wr_en( write_wr_en ),
                           .dout( DDR_byte_enable ),
                           .full( wr_be_full ),
                           .empty( wr_be_empty )
                           );

           assign wr_data_full = wr_data_full_0 | wr_data_full_1;
           assign wr_data_empty = wr_data_empty_0 | wr_data_empty_1;
        end
   endgenerate

   //   ____                _   _____ ___ _____ ___    //
   //  |  _ \ ___  __ _  __| | |  ___|_ _|  ___/ _ \   //
   //  | |_) / _ \/ _` |/ _` | | |_   | || |_ | | | |  //
   //  |  _ <  __/ (_| | (_| | |  _|  | ||  _|| |_| |  //
   //  |_| \_\___|\__,_|\__,_| |_|   |___|_|   \___/   //
   //                                                  //

   generate
      if (C_WIDE_DATA == 0)
        begin:nwd_rd_fifo
           ////
           // DDR read data fifo (FWFT)
           ////
           rd_data_fifo_144_144_512
             rd_data_fifo_0( .din( DDR_output_data ),
                             .rd_clk( Mem_Clk ),
                             .rd_en( Mem_Rd_Ack ),
                             .rst( Mem_Rst ),
                             .wr_clk( DDR_clk ),
                             .wr_en( DDR_data_valid ),
                             .dout( rd_dout ),
                             .empty( rd_data_empty ),
                             .prog_full( rd_data_full ),
                             .full(  )
                             );

           assign Mem_Rd_Valid = ~rd_data_empty & ~tag_empty;
           assign Mem_Rd_Dout = rd_dout;
        end
      else
        begin:wd_rd_fifo
           //
           // Just as with the write case, we need two FIFOs for
           // the 288-bits of data to be returned.  Again, we must
           // properly interleave the 72-bit words properly because
           // the data comes back in two bursts.
           //

           ////
           // DDR read data fifo 0 (FWFT)
           ////
           rd_data_fifo_72_144_512
             rd_data_fifo_0( .din( DDR_output_data[71:0] ),
                             .rd_clk( Mem_Clk ),
                             .rd_en( Mem_Rd_Ack ),
                             .rst( Mem_Rst ),
                             .wr_clk( DDR_clk ),
                             .wr_en( DDR_data_valid ),
                             .dout( rd_dout[143:0] ),
                             .empty( rd_data_empty_0 ),
                             .prog_full( rd_data_full_0 ),
                             .full(  )
                             );

           ////
           // DDR read data fifo 1 (FWFT)
           ////
           rd_data_fifo_72_144_512
             rd_data_fifo_1( .din( DDR_output_data[143:72] ),
                             .rd_clk( Mem_Clk ),
                             .rd_en( Mem_Rd_Ack ),
                             .rst( Mem_Rst ),
                             .wr_clk( DDR_clk ),
                             .wr_en( DDR_data_valid ),
                             .dout( rd_dout[287:144] ),
                             .empty( rd_data_empty_1 ),
                             .prog_full( rd_data_full_1 ),
                             .full(  )
                             );

           assign rd_data_full = rd_data_full_0 | rd_data_full_1;
           assign rd_data_empty = rd_data_empty_0 | rd_data_empty_1;
           assign Mem_Rd_Valid = ~rd_data_empty & ~tag_empty;
           assign Mem_Rd_Dout = {
                  rd_dout[287:216], rd_dout[143:72], rd_dout[215:144], rd_dout[71:0]
                                 };
        end
   endgenerate

endmodule
