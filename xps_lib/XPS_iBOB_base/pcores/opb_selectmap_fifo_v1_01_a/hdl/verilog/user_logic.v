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
// user_logic.v - module
//----------------------------------------------------------------------------

module user_logic
  (
   // SelectMAP interface
   D_I,                         // Data bus input
   D_O,                         // Data bus output
   D_T,                         // Data bus tristate
   RDWR_B,                      // Read/write signal
   CS_B,                        // Chip select
   INIT_B,                      // Initialization/interrupt signal

   // OPB interface via IPIC
   Bus2IP_Clk,                     // Bus to IP clock
   Bus2IP_Reset,                   // Bus to IP reset
   IP2Bus_IntrEvent,               // IP to Bus interrupt event
   Bus2IP_Data,                    // Bus to IP data bus for user logic
   Bus2IP_BE,                      // Bus to IP byte enables for user logic
   Bus2IP_RdCE,                    // Bus to IP read chip enable for user logic
   Bus2IP_WrCE,                    // Bus to IP write chip enable for user logic
   IP2Bus_Data,                    // IP to Bus data bus for user logic
   IP2Bus_Ack,                     // IP to Bus acknowledgement
   IP2Bus_Retry,                   // IP to Bus retry response
   IP2Bus_Error,                   // IP to Bus error response
   IP2Bus_ToutSup,                 // IP to Bus timeout suppress
   IP2Bus_PostedWrInh              // IP to Bus posted write inhibit
   );

   parameter C_INTR_THRESH                  = 0;

   // -- DO NOT EDIT BELOW THIS LINE --------------------
   // -- Bus protocol parameters, do not add to or delete
   parameter C_DWIDTH                       = 32;
   parameter C_NUM_CE                       = 2;
   parameter C_IP_INTR_NUM                  = 1;
   // -- DO NOT EDIT ABOVE THIS LINE --------------------

   input [0:7]                  D_I;
   output [0:7]                 D_O;
   output [0:7]                 D_T;
   input                        RDWR_B;
   input                        CS_B;
   output                       INIT_B;

   // -- DO NOT EDIT BELOW THIS LINE --------------------
   // -- Bus protocol ports, do not add to or delete
   input                        Bus2IP_Clk;
   input                        Bus2IP_Reset;
   output [0 : C_IP_INTR_NUM-1] IP2Bus_IntrEvent;
   input [0 : C_DWIDTH-1]       Bus2IP_Data;
   input [0 : C_DWIDTH/8-1]     Bus2IP_BE;
   input [0 : C_NUM_CE-1]       Bus2IP_RdCE;
   input [0 : C_NUM_CE-1]       Bus2IP_WrCE;
   output [0 : C_DWIDTH-1]      IP2Bus_Data;
   output                       IP2Bus_Ack;
   output                       IP2Bus_Retry;
   output                       IP2Bus_Error;
   output                       IP2Bus_ToutSup;
   output                       IP2Bus_PostedWrInh;
   // -- DO NOT EDIT ABOVE THIS LINE --------------------

   //----------------------------------------------------------------------------
   // Implementation
   //----------------------------------------------------------------------------

   // --USER nets declarations added here, as needed for user logic

   // Nets for user logic slave model s/w accessible register example
   wire [0 : 1]                 slv_reg_write_select;
   wire [0 : 1]                 slv_reg_read_select;
   reg [0 : C_DWIDTH-1]         slv_ip2bus_data;
   wire                         slv_read_ack;
   wire                         slv_write_ack;

   // Registers
   reg [0:7]                    Intr_Thresh;
   reg                          Intr_Mode;
   reg                          Intr_WrFIFO;
   reg                          Intr_RdFIFO;
   reg [0:1]                    Intr_WrFIFO_pulse;

   wire [0:7]                   RFIFO_Data;
   wire [0:7]                   RFIFO_Cnt;
   wire [0:7]                   WFIFO_Cnt;
   // --USER logic implementation added here

   assign      slv_reg_write_select = Bus2IP_WrCE[0:1],
               slv_reg_read_select  = Bus2IP_RdCE[0:1],
               slv_write_ack        = Bus2IP_WrCE[0] || Bus2IP_WrCE[1],
               slv_read_ack         = Bus2IP_RdCE[0] || Bus2IP_RdCE[1];


   // implement slave model register read mux
   always @( * )
     begin: SLAVE_REG_READ_PROC

        case ( slv_reg_read_select )
          2'b10 : slv_ip2bus_data <= { Intr_Thresh,
                                       RFIFO_Cnt,
                                       WFIFO_Cnt,
                                       5'h0, Intr_Mode, Intr_RdFIFO, Intr_WrFIFO };
          2'b01 : slv_ip2bus_data <= { RFIFO_Data, 24'h0 };
          default : slv_ip2bus_data <= 0;
        endcase

     end // SLAVE_REG_READ_PROC

   // implement slave model register write
   always @( posedge Bus2IP_Clk )
     begin
        if (Bus2IP_Reset)
          begin
             Intr_WrFIFO <= 1'b0;
             Intr_RdFIFO <= 1'b0;
             Intr_Mode <= 1'b0;
             Intr_Thresh <= C_INTR_THRESH;
          end
        else if (Bus2IP_WrCE[0])
          begin
             if (Bus2IP_BE[3])
               begin
                  Intr_WrFIFO <= Bus2IP_Data[31];
                  Intr_RdFIFO <= Bus2IP_Data[30];
                  Intr_Mode <= Bus2IP_Data[29];
               end

             if (Bus2IP_BE[0])
               begin
                  Intr_Thresh <= Bus2IP_Data[0:7];
               end
          end
        else
          begin
             Intr_RdFIFO <= (RFIFO_Cnt > Intr_Thresh);
             Intr_WrFIFO <= Intr_Mode && ((8'd129 - WFIFO_Cnt) > Intr_Thresh);
          end
     end

   always @( posedge Bus2IP_Clk )
     begin
        if (Bus2IP_Reset)
          Intr_WrFIFO_pulse <= 2'b0;
        else
          Intr_WrFIFO_pulse <= { Intr_WrFIFO, Intr_WrFIFO_pulse[0] };
     end

   // ------------------------------------------------------------
   // SelectMAP FIFO
   // ------------------------------------------------------------

   user_fifo selectmap_fifo(
                             .WrFifo_Din( Bus2IP_Data[0:7] ),
                             .WrFifo_WrEn( slv_reg_write_select[1] ),
                             .WrFifo_Full(  ),
                             .WrFifo_WrCnt( WFIFO_Cnt ),
                             .RdFifo_Dout( RFIFO_Data ),
                             .RdFifo_RdEn( slv_reg_read_select[1] ),
                             .RdFifo_Empty(  ),
                             .RdFifo_RdCnt( RFIFO_Cnt ),
                             .User_Rst( Bus2IP_Reset ),
                             .User_Clk( Bus2IP_Clk ),
                             .Sys_Rst( Bus2IP_Reset ),
                             .Sys_Clk( Bus2IP_Clk ),
                             .D_I( D_I ),
                             .D_O( D_O ),
                             .D_T( D_T ),
                             .RDWR_B( RDWR_B ),
                             .CS_B( CS_B ),
                             .INIT_B(  ),
                             .CCLK(  )
                             );

   // ------------------------------------------------------------
   // Bus signals
   // ------------------------------------------------------------

   assign IP2Bus_Data        = slv_ip2bus_data;
   assign IP2Bus_Ack         = slv_write_ack || slv_read_ack;
   assign IP2Bus_Error       = 0;
   assign IP2Bus_Retry       = 0;
   assign IP2Bus_ToutSup     = 0;
   assign IP2Bus_PostedWrInh = 0;

   // ------------------------------------------------------------
   // Interrupt logic
   // ------------------------------------------------------------

   assign INIT_B = ~|Intr_WrFIFO_pulse;
   assign IP2Bus_IntrEvent = Intr_RdFIFO ;

endmodule
