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
// user_selectmap.v - module
//----------------------------------------------------------------------------

`timescale 1ps / 1ps

module user_selectmap
  (
    // Bus protocol ports
    Bus2IP_Clk,                  // Bus to IP clock
    Bus2IP_Reset,                // Bus to IP reset
    IP2Bus_IntrEvent,            // IP to Bus interrupt event
    Bus2IP_Data,                 // Bus to IP data bus for user logic
    Bus2IP_BE,                   // Bus to IP byte enables for user logic
    Bus2IP_RdCE,                 // Bus to IP read chip enable for user logic
    Bus2IP_WrCE,                 // Bus to IP write chip enable for user logic
    IP2Bus_Data,                 // IP to Bus data bus for user logic
    IP2Bus_Ack,                  // IP to Bus acknowledgement
    IP2Bus_Retry,                // IP to Bus retry response
    IP2Bus_Error,                // IP to Bus error response
    IP2Bus_ToutSup,              // IP to Bus timeout suppress
    IP2Bus_PostedWrInh,          // IP to Bus posted write inhibit

    // SelectMAP interface ports
    D_I,                         // Data bus input
    D_O,                         // Data bus output
    D_T,                         // Data bus tristate
    RDWR_B,                      // Read/write signal
    CS_B,                        // Chip select
    PROG_B,                      // Program/reset signal
    INIT_B,                      // Initialization/interrupt/busy signal
    DONE,                        // Programming done signal
    CCLK                         // Configuration clock
    );

   // -- Bus protocol parameters, do not add to or delete
   parameter C_DWIDTH        = 32;
   parameter C_NUM_CE        = 2;
   parameter C_IP_INTR_NUM   = 1;
   
   // Bus protocol ports
   input                       Bus2IP_Clk;
   input                       Bus2IP_Reset;
   output [0:C_IP_INTR_NUM-1]  IP2Bus_IntrEvent;
   input [0:C_DWIDTH-1]        Bus2IP_Data;
   input [0:C_DWIDTH/8-1]      Bus2IP_BE;
   input [0:C_NUM_CE-1]        Bus2IP_RdCE;
   input [0:C_NUM_CE-1]        Bus2IP_WrCE;
   output [0:C_DWIDTH-1]       IP2Bus_Data;
   output                      IP2Bus_Ack;
   output                      IP2Bus_Retry;
   output                      IP2Bus_Error;
   output                      IP2Bus_ToutSup;
   output                      IP2Bus_PostedWrInh;

   // SelectMAP protocol ports
   input [0:7]                 D_I;
   output [0:7]                D_O;
   output [0:7]                D_T;
   output                      RDWR_B;
   output                      CS_B;
   input                       INIT_B;
   input                       DONE;
   output                      PROG_B;
   output                      CCLK;

   //   ____        __ _       _ _   _                   //
   //  |  _ \  ___ / _(_)_ __ (_) |_(_) ___  _ __  ___   //
   //  | | | |/ _ \ |_| | '_ \| | __| |/ _ \| '_ \/ __|  //
   //  | |_| |  __/  _| | | | | | |_| | (_) | | | \__ \  //
   //  |____/ \___|_| |_|_| |_|_|\__|_|\___/|_| |_|___/  //
   //                                                    //

   localparam
     DATA_RD_DONE_CYCLE     = 6,
     DATA_RD_DONE_CFG_CYCLE = 5,
     DATA_WR_DONE_CYCLE     = 3,
     CTRL_WR_CNT_CYCLE      = 4,
     CTRL_RD_CNT_CYCLE      = 6,
     CTRL_RD_DONE_CYCLE     = 7;

   //----------------------------------------------------------------------------
   // Register inputs off OPB bus
   //----------------------------------------------------------------------------
   reg [0:C_DWIDTH-1]          Bus2IP_Data_reg;
   reg [0:C_DWIDTH/8-1]        Bus2IP_BE_reg;
   reg [0:C_NUM_CE-1]          Bus2IP_RdCE_reg;
   reg [0:C_NUM_CE-1]          Bus2IP_WrCE_reg;

   always @( posedge Bus2IP_Clk )
     begin
        Bus2IP_Data_reg <= Bus2IP_Data;
        Bus2IP_BE_reg   <= Bus2IP_BE;
        Bus2IP_RdCE_reg <= Bus2IP_RdCE;
        Bus2IP_WrCE_reg <= Bus2IP_WrCE;
     end

   //----------------------------------------------------------------------------
   // IO pad registers
   //----------------------------------------------------------------------------
   reg                         CCLK_reg;   // synthesis attribute iob of CCLK_reg is true;
   reg [0:7]                   D_I_reg;    // synthesis attribute iob of D_I_reg is true;
   reg [0:7]                   D_O_reg;    // synthesis attribute iob of D_O_reg is true;
   reg [0:7]                   D_T_reg;    // synthesis attribute iob of D_T_reg is true;
                                           // synthesis attribute equivalent_register_removal of D_T_reg is "no";
   reg                         RDWR_B_reg; // synthesis attribute iob of RDWR_B_reg is true;
   reg                         CS_B_reg;   // synthesis attribute iob of CS_B_reg is true;
   reg                         PROG_B_reg; // synthesis attribute iob of PROG_B_reg is true;
   reg                         INIT_B_reg; // synthesis attribute iob of INIT_B_reg is true;
   reg                         DONE_reg;   // synthesis attribute iob of DONE_reg is true;

   //----------------------------------------------------------------------------
   // Signal definitions
   //----------------------------------------------------------------------------
   // SelectMAP signals
   wire                        RDWR_B_int;       // Internal RDWR_B signal
   wire                        CS_B_int;         // Internal CS_B signal

   // Control register
   reg                         CTRL_intr;        // Interrupt register
   reg                         CTRL_mode;        // Operation mode register
   reg [0:7]                   CTRL_RdCnt;       // Read FIFO count
   reg [0:7]                   CTRL_WrCnt;       // Write FIFO count

   reg [7:0]                   CTRL_rd_cntr;     // Control read counter
   reg                         CTRL_RdCE_dly;    // Delayed version of RdCE
   wire                        CTRL_RdStart;     // First cycle of read
   wire                        CTRL_RdEnd;       // Last cycle of read
   reg                         CTRL_WrCE_dly;    // Delayed version of WrCE
   wire                        CTRL_WrStart;     // First cycle of write

   wire [0:31]                 CTRL_BusData;     // Output to IP2Bus_Data for control register
   wire                        CTRL_RdCE;        // Read control register
   wire                        CTRL_WrCE;        // Write control register
   wire                        CTRL_Ack;         // Control register data ack

   // Data register
   reg [3:0]                   DATA_wr_cntr;     // Selectmap read counter
   reg [7:0]                   DATA_rd_cntr;     // Selectmap write counter
   reg                         DATA_WrCE_dly;    // Delayed version of WrCE
   wire                        DATA_WrStart;     // Start of write
   reg                         DATA_RdCE_dly;    // Delayed version of RdCE
   wire                        DATA_RdStart;     // Start of read

   wire [0:31]                 DATA_BusData;     // Output to IP2Bus_Data for data register
   reg [7:0]                   DATA_RdData;      // Extra latency on read
   wire                        DATA_RdCE;        // Data register read enable
   wire                        DATA_WrCE;        // Data register write enable
   wire                        DATA_Ack;         // Data register data ack

   //   ____        _          ____            _     _              //
   //  |  _ \  __ _| |_ __ _  |  _ \ ___  __ _(_)___| |_ ___ _ __   //
   //  | | | |/ _` | __/ _` | | |_) / _ \/ _` | / __| __/ _ \ '__|  //
   //  | |_| | (_| | || (_| | |  _ <  __/ (_| | \__ \ ||  __/ |     //
   //  |____/ \__,_|\__\__,_| |_| \_\___|\__, |_|___/\__\___|_|     //
   //                                    |___/                      //

   //----------------------------------------------------------------------------
   // Bus control signals for data register
   //----------------------------------------------------------------------------
   assign DATA_RdCE = Bus2IP_RdCE_reg[1];
   assign DATA_WrCE = Bus2IP_WrCE_reg[1];
   assign DATA_Ack = (CTRL_mode & DATA_rd_cntr[DATA_RD_DONE_CYCLE]) |
                     (~CTRL_mode & DATA_rd_cntr[DATA_RD_DONE_CFG_CYCLE]) |
                     DATA_wr_cntr[DATA_WR_DONE_CYCLE];
   assign DATA_BusData = { DATA_RdData, 24'h0 };

   //----------------------------------------------------------------------------
   // Data read/write counters
   //----------------------------------------------------------------------------
   always @( posedge Bus2IP_Clk )
     begin
        if (Bus2IP_Reset)
          begin
             DATA_wr_cntr <= 4'h0;
             DATA_rd_cntr <= 8'h0;
          end
        else
          begin
             if (DATA_WrStart)
               DATA_wr_cntr <= { 2'h0, CCLK, ~CCLK };
             else
               DATA_wr_cntr <= { DATA_wr_cntr[2:0], 1'b0 };

             if (DATA_RdStart)
               DATA_rd_cntr <= { 6'h0, CCLK, ~CCLK };
             else
               DATA_rd_cntr <= { DATA_rd_cntr[6:0], 1'b0 };
          end
     end

   //----------------------------------------------------------------------------
   // Data write
   //----------------------------------------------------------------------------
   assign    DATA_WrStart = (DATA_WrCE && ~DATA_WrCE_dly);

   always @( posedge Bus2IP_Clk )
     begin
        if (Bus2IP_Reset)
          DATA_WrCE_dly <= 1'b0;
        else
          DATA_WrCE_dly <= DATA_WrCE;
     end

   //----------------------------------------------------------------------------
   // Data read
   //----------------------------------------------------------------------------
   assign    DATA_RdStart = (DATA_RdCE && ~DATA_RdCE_dly);

   always @( posedge Bus2IP_Clk )
     begin
        if (Bus2IP_Reset)
          DATA_RdCE_dly <= 1'b0;
        else
          DATA_RdCE_dly <= DATA_RdCE;
     end

   // Extra cycle of latency to make things easier to PAR
   always @( posedge Bus2IP_Clk )
     DATA_RdData <= D_I_reg;

   //    ____            _             _   ____            _     _              //
   //   / ___|___  _ __ | |_ _ __ ___ | | |  _ \ ___  __ _(_)___| |_ ___ _ __   //
   //  | |   / _ \| '_ \| __| '__/ _ \| | | |_) / _ \/ _` | / __| __/ _ \ '__|  //
   //  | |__| (_) | | | | |_| | | (_) | | |  _ <  __/ (_| | \__ \ ||  __/ |     //
   //   \____\___/|_| |_|\__|_|  \___/|_| |_| \_\___|\__, |_|___/\__\___|_|     //
   //                                                |___/                      //
   //
   // Control register - This register return information about the DONE, and INIT_B
   //                    signals.  It is also used to set the PROG_B signal.
   //
   // Bits:         0-3         4       5        6       7
   //      +-------------------------------------------------+
   //      |       ...       | MODE | PROG_B | INIT_B | DONE |
   //      +-------------------------------------------------+
   //                             8-15
   //      +-------------------------------------------------+
   //      |                   Read FIFO count               |
   //      +-------------------------------------------------+
   //                            16-23
   //      +-------------------------------------------------+
   //      |                  Write FIFO count               |
   //      +-------------------------------------------------+
   //                            24-30                   31
   //      +-------------------------------------------------+
   //      |                      ...                 | INTR |
   //      +-------------------------------------------------+
   //

   //----------------------------------------------------------------------------
   // Bus control signals for control register
   //----------------------------------------------------------------------------
   assign CTRL_RdCE = Bus2IP_RdCE_reg[0];
   assign CTRL_WrCE = Bus2IP_WrCE_reg[0];
   assign CTRL_Ack = CTRL_RdEnd | CTRL_WrCE;
   assign CTRL_BusData = { 4'h0, CTRL_mode, PROG_B_reg, INIT_B_reg, DONE_reg,
                           CTRL_RdCnt,
                           CTRL_WrCnt,
                           7'h0, CTRL_intr };

   //----------------------------------------------------------------------------
   // Control register write
   //----------------------------------------------------------------------------
   assign    CTRL_WrStart = (CTRL_WrCE && ~CTRL_WrCE_dly);

   always @( posedge Bus2IP_Clk )
     begin
        if (Bus2IP_Reset)
          CTRL_WrCE_dly <= 1'b0;
        else
          CTRL_WrCE_dly <= CTRL_WrCE;
     end

   always @( posedge Bus2IP_Clk )
     begin
        // Either clear or write PROG_B bit
        if (Bus2IP_Reset)
          begin
             PROG_B_reg <= 1'b1;
             CTRL_mode  <= 1'b0;
             CTRL_intr  <= 1'b0;
          end
        else
          begin
             if (CTRL_WrStart && Bus2IP_BE_reg[0])
               begin
                  PROG_B_reg <= Bus2IP_Data_reg[5];
                  CTRL_mode  <= Bus2IP_Data_reg[4];
               end

             if (CTRL_WrStart && Bus2IP_BE_reg[3])
               begin
                  CTRL_intr <= Bus2IP_Data_reg[31];
               end
             else
               begin
                  CTRL_intr <= ~CTRL_intr ? (CTRL_mode & ~INIT_B_reg) : CTRL_intr;
               end
          end
     end

   //----------------------------------------------------------------------------
   // Control register read
   //----------------------------------------------------------------------------
   assign    CTRL_RdStart = (CTRL_mode && CTRL_RdCE && ~CTRL_RdCE_dly);
   assign    CTRL_RdEnd = (CTRL_mode && CTRL_rd_cntr[CTRL_RD_DONE_CYCLE]) ||
                          (~CTRL_mode && CTRL_RdCE);

   always @( posedge Bus2IP_Clk )
     begin
        if (Bus2IP_Reset)
          CTRL_RdCE_dly <= 1'b0;
        else
          CTRL_RdCE_dly <= CTRL_RdCE;
     end

   always @( posedge Bus2IP_Clk )
     begin
        if (Bus2IP_Reset)
          CTRL_rd_cntr <= 8'h0;
        else
          CTRL_rd_cntr <= { CTRL_rd_cntr[6:0], CTRL_RdStart };
     end

   always @( posedge Bus2IP_Clk )
     begin
        if (Bus2IP_Reset)
          CTRL_WrCnt <= 8'b0;
        else if (CTRL_rd_cntr[CTRL_WR_CNT_CYCLE])
          CTRL_WrCnt <= D_I_reg;
     end

   always @( posedge Bus2IP_Clk )
     begin
        if (Bus2IP_Reset)
          CTRL_RdCnt <= 8'b0;
        else if (CTRL_rd_cntr[CTRL_RD_CNT_CYCLE])
          CTRL_RdCnt <= D_I_reg;
     end


   //   ____       _           _   __  __    _    ____    //
   //  / ___|  ___| | ___  ___| |_|  \/  |  / \  |  _ \   //
   //  \___ \ / _ \ |/ _ \/ __| __| |\/| | / _ \ | |_) |  //
   //   ___) |  __/ |  __/ (__| |_| |  | |/ ___ \|  __/   //
   //  |____/ \___|_|\___|\___|\__|_|  |_/_/   \_\_|      //
   //                                                     //

   //----------------------------------------------------------------------------
   // SelectMAP input from IO regs
   //----------------------------------------------------------------------------
   always @( posedge Bus2IP_Clk )
     begin
        D_I_reg    <= D_I;
        INIT_B_reg <= INIT_B;
        DONE_reg   <= DONE;
     end

   //----------------------------------------------------------------------------
   // SelectMAP output to IO regs
   //----------------------------------------------------------------------------
   assign CCLK    = CCLK_reg;
   assign D_O     = D_O_reg;
   assign D_T     = D_T_reg;
   assign RDWR_B  = RDWR_B_reg;
   assign CS_B    = CS_B_reg;
   assign PROG_B  = PROG_B_reg;

   //----------------------------------------------------------------------------
   // SelectMAP control
   //----------------------------------------------------------------------------
   assign RDWR_B_int = ~((DATA_WrStart & CCLK_reg) | |DATA_wr_cntr | CTRL_RdStart | CTRL_rd_cntr[0]);
   assign CS_B_int   = ~(|DATA_wr_cntr[3:2] | (DATA_RdStart & CCLK_reg) | |DATA_rd_cntr[1:0]);

   always @( posedge Bus2IP_Clk )
     begin
        RDWR_B_reg <= RDWR_B_int;
        CS_B_reg   <= CS_B_int;
        D_T_reg    <= {8{~(~RDWR_B_int && ~CS_B_int)}}; // drive on active write
        D_O_reg    <= (DATA_WrStart ? Bus2IP_Data_reg[0:7] : D_O_reg); // capture bus data on start
     end

   //----------------------------------------------------------------------------
   // Generate configuration clock
   //----------------------------------------------------------------------------
   always @( posedge Bus2IP_Clk )
     begin
        if (Bus2IP_Reset)
          CCLK_reg <= 1'b0;
        else
          CCLK_reg <= ~CCLK_reg;
     end

   //   ___ ____ ___ ____   //
   //  |_ _|  _ \_ _/ ___|  //
   //   | || |_) | | |      //
   //   | ||  __/| | |___   //
   //  |___|_|  |___\____|  //
   //                       //

   //----------------------------------------------------------------------------
   // Control/data register to bus MUX (for reads)
   //----------------------------------------------------------------------------
   reg [0:31] IP2Bus_Data;

   always @( * )
     begin
        if (CTRL_RdCE)
          IP2Bus_Data = CTRL_BusData;
        else if (DATA_RdCE)
          IP2Bus_Data = DATA_BusData;
        else
          IP2Bus_Data = 32'h0;
     end

   //----------------------------------------------------------------------------
   // Bus control signals
   //----------------------------------------------------------------------------
   assign IP2Bus_Ack         = CTRL_Ack | DATA_Ack;
   assign IP2Bus_IntrEvent   = CTRL_mode & CTRL_intr;
   assign IP2Bus_Error       = 1'b0;
   assign IP2Bus_Retry       = 1'b0;
   assign IP2Bus_ToutSup     = 1'b0;
   assign IP2Bus_PostedWrInh = 1'b1;

   //----------------------------------------------------------------------------

endmodule
