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
// user_fifo.v
//----------------------------------------------------------------------------

`timescale 1ps / 1ps

module user_fifo
  (
   // FIFO interface ports
   WrFifo_Din,                  // Write FIFO data-in
   WrFifo_WrEn,                 // Write FIFO write enable
   WrFifo_Full,                 // Write FIFO full
   WrFifo_WrCnt,                // Write FIFO write count
   RdFifo_Dout,                 // Read FIFO data-out
   RdFifo_RdEn,                 // Read FIFO read enable
   RdFifo_Empty,                // Read FIFO empty
   RdFifo_RdCnt,                // Read FIFO read count
   User_Rst,                    // User reset
   User_Clk,                    // User clock
   Sys_Rst,                     // System clock reset
   Sys_Clk,                     // 100MHz system clock for CCLK generation

   // SelectMAP interface ports
   D_I,                         // Data bus input
   D_O,                         // Data bus output
   D_T,                         // Data bus tristate enable
   RDWR_B,                      // Read/write signal
   CS_B,                        // Chip select
   INIT_B,                      // Initialization/interrupt signal
   CCLK                         // CCLK output
   );

   // FIFO interface ports
   input [0:7]         WrFifo_Din;
   input               WrFifo_WrEn;
   output              WrFifo_Full;
   output [0:7]        WrFifo_WrCnt;
   output [0:7]        RdFifo_Dout;
   input               RdFifo_RdEn;
   output              RdFifo_Empty;
   output [0:7]        RdFifo_RdCnt;
   input               User_Rst;
   input               User_Clk;
   input               Sys_Rst;
   input               Sys_Clk;

   // SelectMAP protocol ports
   input [0:7]         D_I;
   output [0:7]        D_O;
   output [0:7]        D_T;
   input               RDWR_B;
   input               CS_B;
   output              INIT_B;
   output              CCLK;

   //   ____        __ _       _ _   _                   //
   //  |  _ \  ___ / _(_)_ __ (_) |_(_) ___  _ __  ___   //
   //  | | | |/ _ \ |_| | '_ \| | __| |/ _ \| '_ \/ __|  //
   //  | |_| |  __/  _| | | | | | |_| | (_) | | | \__ \  //
   //  |____/ \___|_| |_|_| |_|_|\__|_|\___/|_| |_|___/  //
   //                                                    //

   //----------------------------------------------------------------------------
   // Signal definitions
   //----------------------------------------------------------------------------
   // Write FIFO signals
   wire [0:7]          WrFifo_Dout;
   wire                WrFifo_Empty;
   wire                WrFifo_RdEn;
   wire [0:7]          WrFifo_RdCnt;
   wire [0:7]          WrFifo_RdCnt_int;
   wire [0:7]          WrFifo_WrCnt_int;

   // Read FIFO signals
   wire [0:7]          RdFifo_Din;
   wire                RdFifo_Full;
   wire                RdFifo_WrEn;
   wire [0:7]          RdFifo_WrCnt;
   wire [0:7]          RdFifo_WrCnt_int;
   wire [0:7]          RdFifo_RdCnt_int;

   //----------------------------------------------------------------------------
   // IO Registers
   //----------------------------------------------------------------------------
   reg                 CCLK;

   reg [0:7]           D_I_reg;    // synthesis attribute iob of D_I_reg is true;
   reg [0:7]           D_O_reg;    // synthesis attribute iob of D_O_reg is true;
   reg                 RDWR_B_reg; // synthesis attribute iob of RDWR_B_reg is true;
   reg                 CS_B_reg;   // synthesis attribute iob of CS_B_reg is true;
   reg                 INIT_B_reg; // synthesis attribute iob of INIT_B_reg is true;

   // Outputs
   assign              D_O = D_O_reg;
   assign              INIT_B = INIT_B_reg;

   // Inputs
   always @( posedge Sys_Clk )
     begin
        D_I_reg    <= D_I;
        RDWR_B_reg <= RDWR_B;
        CS_B_reg   <= CS_B;
     end

   //----------------------------------------------------------------------------
   // Generate CCLK and associated reset
   //----------------------------------------------------------------------------
   reg                SYNC_done;
   reg                SYNC_done_dly;
   reg                CS_B_reg_dly;

   always @( posedge Sys_Clk )
     begin
        CS_B_reg_dly <= CS_B_reg;
     end

   always @( posedge Sys_Clk )
     begin
        if (Sys_Rst)
          SYNC_done <= 1'b0;
        else if (RDWR_B_reg && ~CS_B_reg)
          SYNC_done <= 1'b1;
     end

   always @( posedge Sys_Clk )
     begin
        if (Sys_Rst)
          SYNC_done_dly <= 1'b0;
        else
          SYNC_done_dly <= SYNC_done;
     end

   always @( posedge Sys_Clk )
     begin
        if (Sys_Rst)
          CCLK <= 1'b0;
        else if (~CS_B_reg && CS_B_reg_dly && CCLK)
          CCLK <= 1'b1;
        else
          CCLK <= ~CCLK;
     end

   //   _____ ___ _____ ___        //
   //  |  ___|_ _|  ___/ _ \ ___   //
   //  | |_   | || |_ | | | / __|  //
   //  |  _|  | ||  _|| |_| \__ \  //
   //  |_|   |___|_|   \___/|___/  //
   //                              //
   // Write FIFO:  The write is with respect to the user.  The user writes data to this
   //              FIFO and the control side of SelectMAP reads the data.
   //
   // Read FIFO:  The read is with respect to the user.  The user reads data sent from the
   //             control side of SelectMAP.
   //

   //----------------------------------------------------------------------------
   // Read FIFO
   //----------------------------------------------------------------------------
   assign RdFifo_WrEn = SYNC_done_dly && ~RDWR_B_reg && ~CS_B_reg && ~RdFifo_Full && CCLK;
   assign RdFifo_Din = D_I_reg;

   async_fifo_8_8_128 RdFifo( .din( RdFifo_Din ),
                  .dout( RdFifo_Dout ),
                  .rd_clk( User_Clk ),
                  .rd_en( RdFifo_RdEn ),
                  .wr_clk( Sys_Clk ),
                  .wr_en( RdFifo_WrEn ),
                  .rst( User_Rst ),
                  .empty( RdFifo_Empty ),
                  .full( RdFifo_Full ),
                  .rd_data_count( RdFifo_RdCnt_int ),
                  .wr_data_count( RdFifo_WrCnt_int ) );

   assign RdFifo_WrCnt = 8'd129 - RdFifo_WrCnt_int;
   assign RdFifo_RdCnt = RdFifo_RdCnt_int;

   //----------------------------------------------------------------------------
   // Write FIFO
   //----------------------------------------------------------------------------
   assign WrFifo_RdEn = SYNC_done_dly && RDWR_B_reg && ~CS_B_reg && ~WrFifo_Empty && CCLK;

   async_fifo_8_8_128 WrFifo( .din( WrFifo_Din ),
                  .dout( WrFifo_Dout ),
                  .rd_clk( Sys_Clk ),
                  .rd_en( WrFifo_RdEn ),
                  .wr_clk( User_Clk ),
                  .wr_en( WrFifo_WrEn ),
                  .rst( User_Rst ),
                  .empty( WrFifo_Empty ),
                  .full( WrFifo_Full ),
                  .rd_data_count( WrFifo_RdCnt_int ),
                  .wr_data_count( WrFifo_WrCnt_int ) );

   assign WrFifo_WrCnt = 8'd129 - WrFifo_WrCnt_int;
   assign WrFifo_RdCnt = WrFifo_RdCnt_int;

   //   ____       _           _   __  __    _    ____    //
   //  / ___|  ___| | ___  ___| |_|  \/  |  / \  |  _ \   //
   //  \___ \ / _ \ |/ _ \/ __| __| |\/| | / _ \ | |_) |  //
   //   ___) |  __/ |  __/ (__| |_| |  | |/ ___ \|  __/   //
   //  |____/ \___|_|\___|\___|\__|_|  |_/_/   \_\_|      //
   //                                                     //

   //----------------------------------------------------------------------------
   // SelectMAP control outputs
   //----------------------------------------------------------------------------
   wire [0:7] DataCnt = RDWR_B_reg ? WrFifo_RdCnt : RdFifo_WrCnt;

   assign     D_T    = {8{(~RDWR_B & ~CS_B)}}; // stop driving if master is sending

   always @( posedge Sys_Clk )
     begin
        D_O_reg    <= CS_B_reg ? DataCnt : WrFifo_Dout;
        INIT_B_reg <= WrFifo_Empty;
     end

   //----------------------------------------------------------------------------

endmodule
