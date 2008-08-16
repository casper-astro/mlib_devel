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
   // DDR interface
   PLB_size,
   DDR_clk,
   DDR_input_data,
   DDR_byte_enable,
   DDR_get_data,
   DDR_output_data,
   DDR_data_valid,
   DDR_address,
   DDR_read,
   DDR_write,
   DDR_ready,

   // PLB interface via IPIC
   Bus2IP_Clk,                     // Bus to IP clock
   Bus2IP_Reset,                   // Bus to IP reset
   Bus2IP_Addr,                    // Bus to IP address bus
   Bus2IP_Data,                    // Bus to IP data bus for user logic
   Bus2IP_BE,                      // Bus to IP byte enables for user logic
   Bus2IP_Burst,                   // Bus to IP burst-mode qualifier
   Bus2IP_RNW,                     // Bus to IP read/not write
   Bus2IP_RdCE,                    // Bus to IP read chip enable for user logic
   Bus2IP_WrCE,                    // Bus to IP write chip enable for user logic
   Bus2IP_RdReq,                   // Bus to IP read request
   Bus2IP_WrReq,                   // Bus to IP write request
   IP2Bus_Data,                    // IP to Bus data bus for user logic
   IP2Bus_Retry,                   // IP to Bus retry response
   IP2Bus_Error,                   // IP to Bus error response
   IP2Bus_ToutSup,                 // IP to Bus timeout suppress
   IP2Bus_AddrAck,                 // IP to Bus address acknowledgement
   IP2Bus_Busy,                    // IP to Bus busy response
   IP2Bus_RdAck,                   // IP to Bus read transfer acknowledgement
   IP2Bus_WrAck                    // IP to Bus write transfer acknowledgement
   );

   // -- Bus protocol parameters, do not add to or delete
   parameter C_AWIDTH                       = 32;
   parameter C_DWIDTH                       = 64;
   parameter C_NUM_CE                       = 1;
   // -- DO NOT EDIT ABOVE THIS LINE --------------------

   input [0:3]              PLB_size;
   input                    DDR_clk;
   output [143:0]           DDR_input_data;
   output [17:0]            DDR_byte_enable;
   input                    DDR_get_data;
   input [143:0]            DDR_output_data;
   input                    DDR_data_valid;
   output [31:0]            DDR_address;
   output                   DDR_read;
   output                   DDR_write;
   input                    DDR_ready;

   // -- Bus protocol ports, do not add to or delete
   input                    Bus2IP_Clk;
   input                    Bus2IP_Reset;
   input [0 : C_AWIDTH-1]   Bus2IP_Addr;
   input [0 : C_DWIDTH-1]   Bus2IP_Data;
   input [0 : C_DWIDTH/8-1] Bus2IP_BE;
   input                    Bus2IP_Burst;
   input                    Bus2IP_RNW;
   input [0 : C_NUM_CE-1]   Bus2IP_RdCE;
   input [0 : C_NUM_CE-1]   Bus2IP_WrCE;
   input                    Bus2IP_RdReq;
   input                    Bus2IP_WrReq;
   output [0 : C_DWIDTH-1]  IP2Bus_Data;
   output                   IP2Bus_Retry;
   output                   IP2Bus_Error;
   output                   IP2Bus_ToutSup;
   output                   IP2Bus_AddrAck;
   output                   IP2Bus_Busy;
   output                   IP2Bus_RdAck;
   output                   IP2Bus_WrAck;

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
   // Bus signals
   ////
   reg [0 : C_DWIDTH-1]     IP2Bus_Data;

   ////
   // FIFO signals
   ////
   wire [255:0]             rd_data_out;
   wire                     rd_data_empty;
   wire                     rd_data_full;

   wire [255:0]             wr_data_in;
   wire                     wr_data_full;
   wire                     wr_data_empty;
   
   wire [31:0]              wr_be_in;
   wire                     wr_be_full;
   wire                     wr_be_empty;
   
   wire [27:0]              cmd_addr_out;
   wire                     cmd_addr_empty;   
   wire                     cmd_addr_full;

   ////
   // Sliced signals
   ////
   wire [1:0]               dword_addr;
   wire [4:0]               byte_addr;

   ////
   // Read signals
   ////
   reg [4:0]                rd_addr;
   reg [3:0]                xfer_size;
      
   ////
   // Control signals
   ////
   reg [3:0]                dword_reg_en;
   wire                     dword_wr_en;
   wire                     dword_rd_en;
   wire                     fifo_wr_en;
   reg                      fifo_wr_en_dly;
   wire                     fifo_rd_en;
   wire                     rd_cmd_issue;
   reg                      rd_cmd_issue_dly;   
   wire                     rd_cmd_inc;
   reg                      rd_cmd_inc_dly;   

   //    ____            _             _   //
   //   / ___|___  _ __ | |_ _ __ ___ | |  //
   //  | |   / _ \| '_ \| __| '__/ _ \| |  //
   //  | |__| (_) | | | | |_| | | (_) | |  //
   //   \____\___/|_| |_|\__|_|  \___/|_|  //
   //                                      // 

   ////
   // Address slicing
   ////
   assign dword_addr = Bus2IP_Addr[27:28];
   assign byte_addr = Bus2IP_Addr[27:31];

   ////
   // Write enables
   ////
   assign dword_wr_en = |Bus2IP_WrCE;
   assign fifo_wr_en = dword_wr_en & ((dword_addr == 3'b11) | ~Bus2IP_Burst);

   always @( posedge Bus2IP_Clk )
     begin
        if (Bus2IP_Reset)
          fifo_wr_en_dly <= 1'b0;
        else
          fifo_wr_en_dly <= fifo_wr_en;
     end

   ////
   // Read enables
   ////
   assign dword_rd_en = |Bus2IP_RdCE & ~rd_data_empty;
   assign fifo_rd_en = dword_rd_en & ((rd_addr[4:3] == 3'b11) | ~Bus2IP_Burst);

   ////
   // Read issue
   ////
   assign rd_cmd_inc = |Bus2IP_RdCE & Bus2IP_RdReq;
   assign rd_cmd_issue = (rd_cmd_inc & (dword_addr == 3'b11)) | 
                         ((~rd_cmd_inc & rd_cmd_inc_dly) & ~rd_cmd_issue_dly);

   always @( posedge Bus2IP_Clk )
     begin
        if (Bus2IP_Reset)
          rd_cmd_inc_dly <= 1'b0;
        else
          rd_cmd_inc_dly <= rd_cmd_inc;
     end

   always @( posedge Bus2IP_Clk )
     begin
        if (Bus2IP_Reset)
          rd_cmd_issue_dly <= 1'b0;
        else
          rd_cmd_issue_dly <= rd_cmd_issue;
     end
   
   //    ____                  _                  //
   //   / ___|___  _   _ _ __ | |_ ___ _ __ ___   //
   //  | |   / _ \| | | | '_ \| __/ _ \ '__/ __|  //
   //  | |__| (_) | |_| | | | | ||  __/ |  \__ \  //
   //   \____\___/ \__,_|_| |_|\__\___|_|  |___/  //
   //                                             //

   ////
   // Transfer size decoder
   ////
   always @( * )
     begin
        case ( PLB_size )
          4'b1000: xfer_size = 1;
          4'b1001: xfer_size = 2;
          4'b1010: xfer_size = 4;
          default: xfer_size = 8;
        endcase
     end

   ////
   // Read address counter
   ////
   wire [4:0] next_rd_addr = rd_addr + xfer_size;
   
   always @( posedge Bus2IP_Clk )
     begin
        if (Bus2IP_Reset)
          rd_addr <= 5'h0;
        else if (~rd_cmd_inc_dly && rd_cmd_inc)
          rd_addr <= byte_addr;
        else if (dword_rd_en)
          rd_addr <= (PLB_size == 4'b0001) ? { rd_addr[4], next_rd_addr[3:0] } : next_rd_addr;
     end
   
   //   ____  ____  ____     ____               _   //
   //  |  _ \|  _ \|  _ \   / ___|_ __ ___   __| |  //
   //  | | | | | | | |_) | | |   | '_ ` _ \ / _` |  //
   //  | |_| | |_| |  _ <  | |___| | | | | | (_| |  //
   //  |____/|____/|_| \_\  \____|_| |_| |_|\__,_|  //
   //                                               //

   assign DDR_read = (DDR_ready & cmd_addr_out[27] & ~cmd_addr_empty);
   assign DDR_write = (DDR_ready & ~cmd_addr_out[27] & ~cmd_addr_empty & ~wr_data_empty & ~wr_be_empty);
   
   //    ____               _   ____  _            _ _              //
   //   / ___|_ __ ___   __| | |  _ \(_)_ __   ___| (_)_ __   ___   //
   //  | |   | '_ ` _ \ / _` | | |_) | | '_ \ / _ \ | | '_ \ / _ \  //
   //  | |___| | | | | | (_| | |  __/| | |_) |  __/ | | | | |  __/  //
   //   \____|_| |_| |_|\__,_| |_|   |_| .__/ \___|_|_|_| |_|\___|  //
   //                                  |_|                          //

   ////
   // Command and address fifo
   ///
   cmd_addr_fifo cmd_addr_fifo_0( .din( { Bus2IP_RNW, Bus2IP_Addr[0:26] } ),
                                  .rd_clk( DDR_clk ),
                                  .rd_en( DDR_read | DDR_write ),
                                  .rst( Bus2IP_Reset ),
                                  .wr_clk( Bus2IP_Clk ),
                                  .wr_en( fifo_wr_en | rd_cmd_issue ),
                                  .dout( cmd_addr_out ),
                                  .empty( cmd_addr_empty ),
                                  .full( cmd_addr_full )
                                  );

   ////
   // Zero pad address bits
   ///
   assign DDR_address = { cmd_addr_out[26:0], 5'b00000 };
   
   //  __        __    _ _         ____  _            _ _              //
   //  \ \      / / __(_) |_ ___  |  _ \(_)_ __   ___| (_)_ __   ___   //
   //   \ \ /\ / / '__| | __/ _ \ | |_) | | '_ \ / _ \ | | '_ \ / _ \  //
   //    \ V  V /| |  | | ||  __/ |  __/| | |_) |  __/ | | | | |  __/  //
   //     \_/\_/ |_|  |_|\__\___| |_|   |_| .__/ \___|_|_|_| |_|\___|  //
   //                                     |_|                          //

   ////
   // Dword enable decoder
   ////
   always @( * )
     begin
        case ( dword_addr )
          2'b00: dword_reg_en = 4'b0001;
          2'b01: dword_reg_en = 4'b0010;
          2'b10: dword_reg_en = 4'b0100;
          2'b11: dword_reg_en = 4'b1000;
        endcase
     end
   
   ////
   // Staging registers
   ////
   genvar i;
   
   generate
      for (i=0; i < 4; i=i+1)
        begin:dword_reg_inst
           dword_reg d0( .clk( Bus2IP_Clk ),
                         .rst( Bus2IP_Reset | fifo_wr_en_dly ),
                         .en( dword_reg_en[i] & dword_wr_en ),
                         .din( Bus2IP_Data ),
                         .be_in( Bus2IP_BE ),
                         .dout( wr_data_in[(((i+1)*64)-1):(i*64)] ),
                         .be_out( wr_be_in[(((i+1)*8)-1):(i*8)] )
                         );
        end
   endgenerate

   //
   // We don't need the full or empty signals, because the command
   // fifo size and semantics of the DDR interface ensure that we
   // will never fill
   //
   
   ////
   // DDR write data fifo
   ////
   wr_data_fifo wr_data_fifo_0( .din( wr_data_in ),
                                .rd_clk( DDR_clk ),
                                .rd_en( DDR_get_data ),
                                .rst( Bus2IP_Reset ),
                                .wr_clk( Bus2IP_Clk ),
                                .wr_en( fifo_wr_en_dly ),
                                .dout( DDR_input_data[127:0] ),
                                .full( wr_data_full ),
                                .empty( wr_data_empty )
                                );

   ////
   // DDR byte enable fifo
   ////
   wr_be_fifo wr_be_fifo_0( .din( wr_be_in ),
                            .rd_clk( DDR_clk ),
                            .rd_en( DDR_get_data ),
                            .rst( Bus2IP_Reset ),
                            .wr_clk( Bus2IP_Clk ),
                            .wr_en( fifo_wr_en_dly ),
                            .dout( DDR_byte_enable[15:0] ),
                            .full( wr_be_full ),
                            .empty( wr_be_empty )
                            );

   ////
   // Zero pad ECC bits
   ///
   assign DDR_input_data[143:128] = 16'h0;
   assign DDR_byte_enable[17:16] = 2'h0;
   
   //   ____                _   ____  _            _ _             //
   //  |  _ \ ___  __ _  __| | |  _ \(_)_ __   ___| (_)_ __   ___  //
   //  | |_) / _ \/ _` |/ _` | | |_) | | '_ \ / _ \ | | '_ \ / _ \ //
   //  |  _ <  __/ (_| | (_| | |  __/| | |_) |  __/ | | | | |  __/ //
   //  |_| \_\___|\__,_|\__,_| |_|   |_| .__/ \___|_|_|_| |_|\___| //
   //                                  |_|                         //  

   //
   // We don't care about the full signal, because our reads will
   // always complete as soon as possible and will never allow
   // the fifo to fill (the fifo is overprovisioned)
   //
   
   ////
   // DDR output fifo
   ////
   rd_data_fifo rd_data_fifo_0( .din( DDR_output_data[127:0] ),
                                .rd_clk( Bus2IP_Clk ),
                                .rd_en( fifo_rd_en ),
                                .rst( Bus2IP_Reset ),
                                .wr_clk( DDR_clk ),
                                .wr_en( DDR_data_valid ),
                                .dout( rd_data_out ),
                                .empty( rd_data_empty ),
                                .full( rd_data_full )
                                );

   ////
   // FIFO output to bus MUX
   ////
   always @( * )
     begin
        case ( rd_addr[4:3] )
          2'b00: IP2Bus_Data = rd_data_out[63:0];
          2'b01: IP2Bus_Data = rd_data_out[127:64];
          2'b10: IP2Bus_Data = rd_data_out[191:128];
          2'b11: IP2Bus_Data = rd_data_out[255:192];
        endcase
     end

   // ------------------------------------------------------------
   // Bus signals
   // ------------------------------------------------------------

   assign                   IP2Bus_WrAck       = dword_wr_en;
   assign                   IP2Bus_RdAck       = dword_rd_en;
   assign                   IP2Bus_AddrAck     = |Bus2IP_WrCE || |Bus2IP_RdCE;
   assign                   IP2Bus_Busy        = 0;
   assign                   IP2Bus_Error       = 0;
   assign                   IP2Bus_Retry       = 0;
   assign                   IP2Bus_ToutSup     = IP2Bus_AddrAck;
   assign                   IP2Bus_PostedWrInh = 0;

endmodule
