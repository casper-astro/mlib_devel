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

`timescale 1ps / 1ps

module user_logic
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

   // Common SelectMAP ports
   CCLK,                        // Shared configuration clock

   // SelectMAP interface ports
   FPGA1_D_I,                   // Data bus input
   FPGA1_D_O,                   // Data bus output
   FPGA1_D_T,                   // Data bus tristate enable
   FPGA1_RDWR_B,                // Read/write signal
   FPGA1_CS_B,                  // Chip select
   FPGA1_PROG_B,                // Program/reset signal
   FPGA1_INIT_B,                // Initialization/interrupt/busy signal
   FPGA1_DONE,                  // Programming done signal

   FPGA2_D_I,                   // Data bus input
   FPGA2_D_O,                   // Data bus output
   FPGA2_D_T,                   // Data bus tristate enable
   FPGA2_RDWR_B,                // Read/write signal
   FPGA2_CS_B,                  // Chip select
   FPGA2_PROG_B,                // Program/reset signal
   FPGA2_INIT_B,                // Initialization/interrupt/busy signal
   FPGA2_DONE,                  // Programming done signal

   FPGA3_D_I,                   // Data bus input
   FPGA3_D_O,                   // Data bus output
   FPGA3_D_T,                   // Data bus tristate enable
   FPGA3_RDWR_B,                // Read/write signal
   FPGA3_CS_B,                  // Chip select
   FPGA3_PROG_B,                // Program/reset signal
   FPGA3_INIT_B,                // Initialization/interrupt/busy signal
   FPGA3_DONE,                  // Programming done signal

   FPGA4_D_I,                   // Data bus input
   FPGA4_D_O,                   // Data bus output
   FPGA4_D_T,                   // Data bus tristate enable
   FPGA4_RDWR_B,                // Read/write signal
   FPGA4_CS_B,                  // Chip select
   FPGA4_PROG_B,                // Program/reset signal
   FPGA4_INIT_B,                // Initialization/interrupt/busy signal
   FPGA4_DONE,                  // Programming done signal

   FPGA0_D_I,                   // Data bus input
   FPGA0_D_O,                   // Data bus output
   FPGA0_D_T,                   // Data bus tristate enable     
   FPGA0_RDWR_B,                // Read/write signal
   FPGA0_CS_B,                  // Chip select
   FPGA0_PROG_B,                // Program/reset signal
   FPGA0_INIT_B,                // Initialization/interrupt/busy signal
   FPGA0_DONE,                  // Programming done signal
   );

   // -- Bus protocol parameters, do not add to or delete
   parameter C_DWIDTH        = 32;
   parameter C_NUM_CE        = 10;
   parameter C_IP_INTR_NUM   = 5;

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
   output                      CCLK;

   input [0:7]                 FPGA1_D_I;
   output [0:7]                FPGA1_D_O;
   output [0:7]                FPGA1_D_T;
   output                      FPGA1_RDWR_B;
   output                      FPGA1_CS_B;
   input                       FPGA1_INIT_B;
   input                       FPGA1_DONE;
   output                      FPGA1_PROG_B;

   input [0:7]                 FPGA2_D_I;
   output [0:7]                FPGA2_D_O;
   output [0:7]                FPGA2_D_T;
   output                      FPGA2_RDWR_B;
   output                      FPGA2_CS_B;
   input                       FPGA2_INIT_B;
   input                       FPGA2_DONE;
   output                      FPGA2_PROG_B;

   input [0:7]                 FPGA3_D_I;
   output [0:7]                FPGA3_D_O;
   output [0:7]                FPGA3_D_T;
   output                      FPGA3_RDWR_B;
   output                      FPGA3_CS_B;
   input                       FPGA3_INIT_B;
   input                       FPGA3_DONE;
   output                      FPGA3_PROG_B;

   input [0:7]                 FPGA4_D_I;
   output [0:7]                FPGA4_D_O;
   output [0:7]                FPGA4_D_T;
   output                      FPGA4_RDWR_B;
   output                      FPGA4_CS_B;
   input                       FPGA4_INIT_B;
   input                       FPGA4_DONE;
   output                      FPGA4_PROG_B;

   input [0:7]                 FPGA0_D_I;
   output [0:7]                FPGA0_D_O;
   output [0:7]                FPGA0_D_T;   
   output 		       FPGA0_RDWR_B;
   output 		       FPGA0_CS_B;
   input 		       FPGA0_INIT_B;
   input 		       FPGA0_DONE;
   output 		       FPGA0_PROG_B;

   //   _____ ____   ____    _    _   //
   //  |  ___|  _ \ / ___|  / \  / |  //
   //  | |_  | |_) | |  _  / _ \ | |  //
   //  |  _| |  __/| |_| |/ ___ \| |  //
   //  |_|   |_|    \____/_/   \_\_|  //
   //                                 //

   wire [0:31]                 FPGA1_IP2Bus_Data;
   wire                        FPGA1_IP2Bus_Ack;
   wire                        FPGA1_IP2Bus_Retry;
   wire                        FPGA1_IP2Bus_Error;
   wire                        FPGA1_IP2Bus_ToutSup;
   wire                        FPGA1_IP2Bus_PostedWrInh;

   user_selectmap
     FPGA1_selectmap(
                      .Bus2IP_Clk( Bus2IP_Clk ),
                      .Bus2IP_Reset( Bus2IP_Reset ),
                      .IP2Bus_IntrEvent( IP2Bus_IntrEvent[0] ),
                      .Bus2IP_Data( Bus2IP_Data ),
                      .Bus2IP_BE( Bus2IP_BE ),
                      .Bus2IP_RdCE( Bus2IP_RdCE[0:1] ),
                      .Bus2IP_WrCE( Bus2IP_WrCE[0:1] ),
                      .IP2Bus_Data( FPGA1_IP2Bus_Data ),
                      .IP2Bus_Ack( FPGA1_IP2Bus_Ack ),
                      .IP2Bus_Retry( FPGA1_IP2Bus_Retry ),
                      .IP2Bus_Error( FPGA1_IP2Bus_Error ),
                      .IP2Bus_ToutSup( FPGA1_IP2Bus_ToutSup ),
                      .IP2Bus_PostedWrInh( FPGA1_IP2Bus_PostedWrInh ),
                      .D_I( FPGA1_D_I ),
                      .D_O( FPGA1_D_O ),
                      .D_T( FPGA1_D_T ),
                      .RDWR_B( FPGA1_RDWR_B ),
                      .CS_B( FPGA1_CS_B ),
                      .PROG_B( FPGA1_PROG_B ),
                      .INIT_B( FPGA1_INIT_B ),
                      .DONE( FPGA1_DONE ),
                      .CCLK(  )
                      );

   //   _____ ____   ____    _    ____    //
   //  |  ___|  _ \ / ___|  / \  |___ \   //
   //  | |_  | |_) | |  _  / _ \   __) |  //
   //  |  _| |  __/| |_| |/ ___ \ / __/   //
   //  |_|   |_|    \____/_/   \_\_____|  //
   //                                     //

   wire [0:31]                 FPGA2_IP2Bus_Data;
   wire                        FPGA2_IP2Bus_Ack;
   wire                        FPGA2_IP2Bus_Retry;
   wire                        FPGA2_IP2Bus_Error;
   wire                        FPGA2_IP2Bus_ToutSup;
   wire                        FPGA2_IP2Bus_PostedWrInh;

   user_selectmap
     FPGA2_selectmap(
                      .Bus2IP_Clk( Bus2IP_Clk ),
                      .Bus2IP_Reset( Bus2IP_Reset ),
                      .IP2Bus_IntrEvent( IP2Bus_IntrEvent[1] ),
                      .Bus2IP_Data( Bus2IP_Data ),
                      .Bus2IP_BE( Bus2IP_BE ),
                      .Bus2IP_RdCE( Bus2IP_RdCE[2:3] ),
                      .Bus2IP_WrCE( Bus2IP_WrCE[2:3] ),
                      .IP2Bus_Data( FPGA2_IP2Bus_Data ),
                      .IP2Bus_Ack( FPGA2_IP2Bus_Ack ),
                      .IP2Bus_Retry( FPGA2_IP2Bus_Retry ),
                      .IP2Bus_Error( FPGA2_IP2Bus_Error ),
                      .IP2Bus_ToutSup( FPGA2_IP2Bus_ToutSup ),
                      .IP2Bus_PostedWrInh( FPGA2_IP2Bus_PostedWrInh ),
                      .D_I( FPGA2_D_I ),
                      .D_O( FPGA2_D_O ),
                      .D_T( FPGA2_D_T ),
                      .RDWR_B( FPGA2_RDWR_B ),
                      .CS_B( FPGA2_CS_B ),
                      .PROG_B( FPGA2_PROG_B ),
                      .INIT_B( FPGA2_INIT_B ),
                      .DONE( FPGA2_DONE ),
                      .CCLK(  )
                      );

   //   _____ ____   ____    _    _____   //
   //  |  ___|  _ \ / ___|  / \  |___ /   //
   //  | |_  | |_) | |  _  / _ \   |_ \   //
   //  |  _| |  __/| |_| |/ ___ \ ___) |  //
   //  |_|   |_|    \____/_/   \_\____/   //
   //                                     //

   wire [0:31]                 FPGA3_IP2Bus_Data;
   wire                        FPGA3_IP2Bus_Ack;
   wire                        FPGA3_IP2Bus_Retry;
   wire                        FPGA3_IP2Bus_Error;
   wire                        FPGA3_IP2Bus_ToutSup;
   wire                        FPGA3_IP2Bus_PostedWrInh;

   user_selectmap
     FPGA3_selectmap(
                      .Bus2IP_Clk( Bus2IP_Clk ),
                      .Bus2IP_Reset( Bus2IP_Reset ),
                      .IP2Bus_IntrEvent( IP2Bus_IntrEvent[2] ),
                      .Bus2IP_Data( Bus2IP_Data ),
                      .Bus2IP_BE( Bus2IP_BE ),
                      .Bus2IP_RdCE( Bus2IP_RdCE[4:5] ),
                      .Bus2IP_WrCE( Bus2IP_WrCE[4:5] ),
                      .IP2Bus_Data( FPGA3_IP2Bus_Data ),
                      .IP2Bus_Ack( FPGA3_IP2Bus_Ack ),
                      .IP2Bus_Retry( FPGA3_IP2Bus_Retry ),
                      .IP2Bus_Error( FPGA3_IP2Bus_Error ),
                      .IP2Bus_ToutSup( FPGA3_IP2Bus_ToutSup ),
                      .IP2Bus_PostedWrInh( FPGA3_IP2Bus_PostedWrInh ),
                      .D_I( FPGA3_D_I ),
                      .D_O( FPGA3_D_O ),
                      .D_T( FPGA3_D_T ),
                      .RDWR_B( FPGA3_RDWR_B ),
                      .CS_B( FPGA3_CS_B ),
                      .PROG_B( FPGA3_PROG_B ),
                      .INIT_B( FPGA3_INIT_B ),
                      .DONE( FPGA3_DONE ),
                      .CCLK(  )
                      );

   //   _____ ____   ____    _   _  _     //
   //  |  ___|  _ \ / ___|  / \ | || |    //
   //  | |_  | |_) | |  _  / _ \| || |_   //
   //  |  _| |  __/| |_| |/ ___ \__   _|  //
   //  |_|   |_|    \____/_/   \_\ |_|    //
   //                                     //

   wire [0:31]                 FPGA4_IP2Bus_Data;
   wire                        FPGA4_IP2Bus_Ack;
   wire                        FPGA4_IP2Bus_Retry;
   wire                        FPGA4_IP2Bus_Error;
   wire                        FPGA4_IP2Bus_ToutSup;
   wire                        FPGA4_IP2Bus_PostedWrInh;

   user_selectmap
     FPGA4_selectmap(
                      .Bus2IP_Clk( Bus2IP_Clk ),
                      .Bus2IP_Reset( Bus2IP_Reset ),
                      .IP2Bus_IntrEvent( IP2Bus_IntrEvent[3] ),
                      .Bus2IP_Data( Bus2IP_Data ),
                      .Bus2IP_BE( Bus2IP_BE ),
                      .Bus2IP_RdCE( Bus2IP_RdCE[6:7] ),
                      .Bus2IP_WrCE( Bus2IP_WrCE[6:7] ),
                      .IP2Bus_Data( FPGA4_IP2Bus_Data ),
                      .IP2Bus_Ack( FPGA4_IP2Bus_Ack ),
                      .IP2Bus_Retry( FPGA4_IP2Bus_Retry ),
                      .IP2Bus_Error( FPGA4_IP2Bus_Error ),
                      .IP2Bus_ToutSup( FPGA4_IP2Bus_ToutSup ),
                      .IP2Bus_PostedWrInh( FPGA4_IP2Bus_PostedWrInh ),
                      .D_I( FPGA4_D_I ),
                      .D_O( FPGA4_D_O ),
                      .D_T( FPGA4_D_T ),
                      .RDWR_B( FPGA4_RDWR_B ),
                      .CS_B( FPGA4_CS_B ),
                      .PROG_B( FPGA4_PROG_B ),
                      .INIT_B( FPGA4_INIT_B ),
                      .DONE( FPGA4_DONE ),
                      .CCLK(  )
                      );

   //  _____ ____   ____    _    ___    //
   // |  ___|  _ \ / ___|  / \  / _ \   //
   // | |_  | |_) | |  _  / _ \| | | |  //
   // |  _| |  __/| |_| |/ ___ \ |_| |  //
   // |_|   |_|    \____/_/   \_\___/   //
   //

   wire [0:31]                 FPGA0_IP2Bus_Data;
   wire                        FPGA0_IP2Bus_Ack;
   wire                        FPGA0_IP2Bus_Retry;
   wire                        FPGA0_IP2Bus_Error;
   wire                        FPGA0_IP2Bus_ToutSup;
   wire                        FPGA0_IP2Bus_PostedWrInh;
   
   user_selectmap 
     FPGA0_selectmap( 
                      .Bus2IP_Clk( Bus2IP_Clk ),
                      .Bus2IP_Reset( Bus2IP_Reset ),
                      .IP2Bus_IntrEvent( IP2Bus_IntrEvent[4] ),
                      .Bus2IP_Data( Bus2IP_Data ),
                      .Bus2IP_BE( Bus2IP_BE ),
                      .Bus2IP_RdCE( Bus2IP_RdCE[8:9] ),
                      .Bus2IP_WrCE( Bus2IP_WrCE[8:9] ),
                      .IP2Bus_Data( FPGA0_IP2Bus_Data ),
                      .IP2Bus_Ack( FPGA0_IP2Bus_Ack ),
                      .IP2Bus_Retry( FPGA0_IP2Bus_Retry ),
                      .IP2Bus_Error( FPGA0_IP2Bus_Error ),
                      .IP2Bus_ToutSup( FPGA0_IP2Bus_ToutSup ),
                      .IP2Bus_PostedWrInh( FPGA0_IP2Bus_PostedWrInh ),
                      .D_I( FPGA0_D_I ),
                      .D_O( FPGA0_D_O ),
                      .D_T( FPGA0_D_T ),                                                                  
                      .RDWR_B( FPGA0_RDWR_B ),
                      .CS_B( FPGA0_CS_B ),
                      .PROG_B( FPGA0_PROG_B ),
                      .INIT_B( FPGA0_INIT_B ),
                      .DONE( FPGA0_DONE ),
                      .CCLK(  )
                      );

   //    ____ ____ _     _  __  //
   //   / ___/ ___| |   | |/ /  //
   //  | |  | |   | |   | ' /   //
   //  | |__| |___| |___| . \   //
   //   \____\____|_____|_|\_\  //
   //                           //

   //----------------------------------------------------------------------------
   // Generate configuration clock
   //----------------------------------------------------------------------------
   reg    CCLK_reg;        // synthesis attribute iob of CCLK_reg is true;
   assign CCLK = CCLK_reg;

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
   reg [0:31] IP2Bus_Data_mux;
   assign     IP2Bus_Data = IP2Bus_Data_mux;

   reg [0:C_NUM_CE-1] Bus2IP_RdCE_reg;

   always @( posedge Bus2IP_Clk )
     Bus2IP_RdCE_reg <= Bus2IP_RdCE;

   always @( * )
     begin
        if (Bus2IP_RdCE_reg[0] || Bus2IP_RdCE_reg[1])
          IP2Bus_Data_mux = FPGA1_IP2Bus_Data;
        else if (Bus2IP_RdCE_reg[2] || Bus2IP_RdCE_reg[3])
          IP2Bus_Data_mux = FPGA2_IP2Bus_Data;
        else if (Bus2IP_RdCE_reg[4] || Bus2IP_RdCE_reg[5])
          IP2Bus_Data_mux = FPGA3_IP2Bus_Data;
        else if (Bus2IP_RdCE_reg[6] || Bus2IP_RdCE_reg[7])
          IP2Bus_Data_mux = FPGA4_IP2Bus_Data;
        else if (Bus2IP_RdCE_reg[8] || Bus2IP_RdCE_reg[9])
          IP2Bus_Data_mux = FPGA0_IP2Bus_Data;
        else
          IP2Bus_Data_mux = 32'h0;
     end

   //----------------------------------------------------------------------------
   // Bus control signals
   //----------------------------------------------------------------------------
   assign IP2Bus_Ack         = FPGA1_IP2Bus_Ack | FPGA2_IP2Bus_Ack | 
                               FPGA3_IP2Bus_Ack | FPGA4_IP2Bus_Ack | FPGA0_IP2Bus_Ack;
   
   assign IP2Bus_Error       = FPGA1_IP2Bus_Error | FPGA2_IP2Bus_Error | 
                               FPGA3_IP2Bus_Error | FPGA4_IP2Bus_Error | FPGA0_IP2Bus_Error;
   
   assign IP2Bus_Retry       = FPGA1_IP2Bus_Retry | FPGA2_IP2Bus_Retry | 
                               FPGA3_IP2Bus_Retry | FPGA4_IP2Bus_Retry | FPGA0_IP2Bus_Retry;
   
   assign IP2Bus_ToutSup     = FPGA1_IP2Bus_ToutSup | FPGA2_IP2Bus_ToutSup | 
                               FPGA3_IP2Bus_ToutSup | FPGA4_IP2Bus_ToutSup | FPGA0_IP2Bus_ToutSup;
   
   assign IP2Bus_PostedWrInh = FPGA1_IP2Bus_PostedWrInh | FPGA2_IP2Bus_PostedWrInh | 
                               FPGA3_IP2Bus_PostedWrInh | FPGA4_IP2Bus_PostedWrInh | FPGA0_IP2Bus_PostedWrInh;



   //----------------------------------------------------------------------------

endmodule
