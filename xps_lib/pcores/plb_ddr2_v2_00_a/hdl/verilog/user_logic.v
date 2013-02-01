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
   // PLB signals
   PLB_size,

   // Memory interface
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

   parameter C_SUPPORT_SHARED               = 0;
   parameter C_WIDE_DATA                    = 0;

   // -- Bus protocol parameters, do not add to or delete
   parameter C_AWIDTH                       = 32;
   parameter C_DWIDTH                       = 64;
   parameter C_NUM_CE                       = 1;
   // -- DO NOT EDIT ABOVE THIS LINE --------------------

   // PLB signals
   input [0:3] PLB_size;

   // Memory interface
   output [31:0]                        Mem_Cmd_Address;
   output                               Mem_Cmd_RNW;
   output                               Mem_Cmd_Valid;
   output [31:0]                        Mem_Cmd_Tag;
   input                                Mem_Cmd_Ack;
   input [(144*(C_WIDE_DATA+1))-1:0]    Mem_Rd_Dout;
   input [31:0]                         Mem_Rd_Tag;
   output                               Mem_Rd_Ack;
   input                                Mem_Rd_Valid;
   output [(144*(C_WIDE_DATA+1))-1:0]   Mem_Wr_Din;
   output [(18*(C_WIDE_DATA+1))-1:0]    Mem_Wr_BE;

   // -- Bus protocol ports, do not add to or delete
   input                                Bus2IP_Clk;
   input                                Bus2IP_Reset;
   input [0 : C_AWIDTH-1]               Bus2IP_Addr;
   input [0 : C_DWIDTH-1]               Bus2IP_Data;
   input [0 : C_DWIDTH/8-1]             Bus2IP_BE;
   input                                Bus2IP_Burst;
   input                                Bus2IP_RNW;
   input [0 : C_NUM_CE-1]               Bus2IP_RdCE;
   input [0 : C_NUM_CE-1]               Bus2IP_WrCE;
   input                                Bus2IP_RdReq;
   input                                Bus2IP_WrReq;
   output [0 : C_DWIDTH-1]              IP2Bus_Data;
   output                               IP2Bus_Retry;
   output                               IP2Bus_Error;
   output                               IP2Bus_ToutSup;
   output                               IP2Bus_AddrAck;
   output                               IP2Bus_Busy;
   output                               IP2Bus_RdAck;
   output                               IP2Bus_WrAck;

   //----------------------------------------------------------------------------
   // Implementation
   //----------------------------------------------------------------------------

   ///////////////////////////////////////
   //  ____  _                   _      //
   // / ___|(_) __ _ _ __   __ _| |___  //
   // \___ \| |/ _` | '_ \ / _` | / __| //
   //  ___) | | (_| | | | | (_| | \__ \ //
   // |____/|_|\__, |_| |_|\__,_|_|___/ //
   //          |___/                    //
   ///////////////////////////////////////

   ////
   // Bus signals
   ////
   reg [0 : C_AWIDTH-1]     Bus2IP_Addr_reg;
   reg                      Bus2IP_RNW_reg;
   reg [0 : C_DWIDTH-1]     IP2Bus_Data;

   always @( posedge Bus2IP_Clk )
     begin
        Bus2IP_Addr_reg <= Bus2IP_Addr;
        Bus2IP_RNW_reg  <= Bus2IP_RNW;
     end

   ////
   // FIFO signals
   ////
   wire [(128*(C_WIDE_DATA+1))-1:0] rd_data_out;
   wire [(128*(C_WIDE_DATA+1))-1:0] wr_data_in;
   wire [(16*(C_WIDE_DATA+1))-1:0]  wr_be_in;

   ////
   // Sliced signals
   ////
   wire [(1*(C_WIDE_DATA+1))-1:0]   dword_addr;
   wire [4:0]                       byte_addr;

   ////
   // Read signals
   ////
   reg [4:0]                        rd_addr;
   reg [3:0]                        xfer_size;

   ////
   // Control signals
   ////
   reg [(2*(C_WIDE_DATA+1))-1:0]    dword_reg_en;
   wire                             dword_wr_last;
   wire                             dword_wr_en;
   wire                             dword_rd_en;
   wire                             dword_rd_last;
   wire                             fifo_wr_en;
   reg                              fifo_wr_en_dly;
   wire                             fifo_rd_en;
   wire                             rd_cmd_issue;
   reg                              rd_cmd_issue_dly;
   wire                             rd_cmd_inc;
   reg                              rd_cmd_inc_dly;

   wire [((128*(C_WIDE_DATA+1))+(16*(C_WIDE_DATA+1))+(28-C_WIDE_DATA)+1)-1:0] bus_fifo_din, bus_fifo_dout;
   wire                             bus_fifo_empty, bus_fifo_full;

   ////////////////////////////////////////
   //   ____            _             _  //
   //  / ___|___  _ __ | |_ _ __ ___ | | //
   // | |   / _ \| '_ \| __| '__/ _ \| | //
   // | |__| (_) | | | | |_| | | (_) | | //
   //  \____\___/|_| |_|\__|_|  \___/|_| //
   //                                    //
   ////////////////////////////////////////

   ////
   // Address slicing
   ////
   assign dword_addr = (C_WIDE_DATA == 0) ? Bus2IP_Addr[28] : Bus2IP_Addr[27:28];
   assign byte_addr = Bus2IP_Addr[27:31];

   ////
   // Write enables
   ////

   /////////////////////////////////////////////////////
   wire   wr_req;
   reg    wr_req_dly;
   reg    pending;

   assign wr_req = |Bus2IP_WrCE;

   always @( posedge Bus2IP_Clk )
     begin
        wr_req_dly <= wr_req;
     end

   always @( posedge Bus2IP_Clk )
     begin
        if (Bus2IP_Reset || (pending && bus_fifo_empty))
          pending <= 1'b0;
        else if (wr_req_dly && ~wr_req && (~bus_fifo_empty || fifo_wr_en_dly))
          pending <= 1'b1;
     end
   ////////////////////////////////////////////////////

   assign dword_wr_en = (C_SUPPORT_SHARED == 0) ? |Bus2IP_WrCE : |Bus2IP_WrCE & ~pending;
   assign dword_wr_last = (C_WIDE_DATA == 0) ? (dword_addr == 1'b1) : (dword_addr == 2'b11);
   assign fifo_wr_en = dword_wr_en & (dword_wr_last | ~Bus2IP_Burst);

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
   assign dword_rd_en = |Bus2IP_RdCE & Mem_Rd_Valid;
   assign dword_rd_last = (C_WIDE_DATA == 0) ? (rd_addr[3] == 1'b1) : (rd_addr[4:3] == 2'b11);
   assign fifo_rd_en = dword_rd_en & (dword_rd_last | ~Bus2IP_Burst);

   ////
   // Read issue
   ////
   assign rd_cmd_inc = |Bus2IP_RdCE & Bus2IP_RdReq;
   assign rd_cmd_issue = (rd_cmd_inc & dword_wr_last) |
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

   ///////////////////////////////////////////////
   //   ____                  _                 //
   //  / ___|___  _   _ _ __ | |_ ___ _ __ ___  //
   // | |   / _ \| | | | '_ \| __/ _ \ '__/ __| //
   // | |__| (_) | |_| | | | | ||  __/ |  \__ \ //
   //  \____\___/ \__,_|_| |_|\__\___|_|  |___/ //
   //                                           //
   ///////////////////////////////////////////////

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


   /////////////////////////////////////////////////////////////////////////
   //   ____               _   ___       _             __                 //
   //  / ___|_ __ ___   __| | |_ _|_ __ | |_ ___ _ __ / _| __ _  ___ ___  //
   // | |   | '_ ` _ \ / _` |  | || '_ \| __/ _ \ '__| |_ / _` |/ __/ _ \ //
   // | |___| | | | | | (_| |  | || | | | ||  __/ |  |  _| (_| | (_|  __/ //
   //  \____|_| |_| |_|\__,_| |___|_| |_|\__\___|_|  |_|  \__,_|\___\___| //
   //                                                                     //
   /////////////////////////////////////////////////////////////////////////

   generate
      if (C_SUPPORT_SHARED == 0)
        begin:gen_cmd_no_shared
           assign Mem_Cmd_RNW = Bus2IP_RNW_reg;
           assign Mem_Cmd_Valid = fifo_wr_en_dly | rd_cmd_issue_dly;
           assign Mem_Cmd_Tag = 32'hx;

           if (C_WIDE_DATA == 0)
             begin:gen_ns_nwd
                assign Mem_Cmd_Address = { Bus2IP_Addr_reg[0:27], 4'b0000 };
                assign Mem_Wr_Din = { 8'h0, wr_data_in[127:64], 8'h0, wr_data_in[63:0] };
                assign Mem_Wr_BE = { 1'h0, wr_be_in[15:8], 1'b0, wr_be_in[7:0] };
             end
           else
             begin:gen_ns_wd
                assign Mem_Cmd_Address = { Bus2IP_Addr_reg[0:26], 5'b00000 };
                assign Mem_Wr_Din = { 8'h0, wr_data_in[255:192],
                                      8'h0, wr_data_in[191:128],
                                      8'h0, wr_data_in[127:64],
                                      8'h0, wr_data_in[63:0] };
                assign Mem_Wr_BE = { 1'b0, wr_be_in[31:24],
                                     1'b0, wr_be_in[23:16],
                                     1'b0, wr_be_in[15:8],
                                     1'b0, wr_be_in[7:0] };
             end
        end
      else
        begin:gen_cmd_shared
           assign Mem_Cmd_Tag = 32'hx;
           assign Mem_Cmd_Valid = ~bus_fifo_empty;

           if (C_WIDE_DATA == 0)
             begin:gen_s_nwd
                assign bus_fifo_din = { wr_be_in, wr_data_in, Bus2IP_RNW_reg, Bus2IP_Addr_reg[0:27] };
                assign Mem_Cmd_RNW = Mem_Cmd_Valid & bus_fifo_dout[28];
                assign Mem_Cmd_Address = { bus_fifo_dout[27:0] , 4'b0000 };
                assign Mem_Wr_Din = { 8'h0, bus_fifo_dout[156:93], 8'h0, bus_fifo_dout[92:29] };
                assign Mem_Wr_BE = { 1'b0, bus_fifo_dout[172:165] , 1'b0, bus_fifo_dout[164:157] };
             end
           else
             begin:gen_s_wd
                assign bus_fifo_din = { wr_be_in, wr_data_in, Bus2IP_RNW_reg, Bus2IP_Addr_reg[0:26] };
                assign Mem_Cmd_RNW = Mem_Cmd_Valid & bus_fifo_dout[27];
                assign Mem_Cmd_Address = { bus_fifo_dout[26:0] , 5'b00000 };
                assign Mem_Wr_Din = { 8'h0, bus_fifo_dout[283:220],
                                      8'h0, bus_fifo_dout[219:156],
                                      8'h0, bus_fifo_dout[155:92],
                                      8'h0, bus_fifo_dout[91:28] };
                assign Mem_Wr_BE = { 1'b0, bus_fifo_dout[315:308],
                                     1'b0, bus_fifo_dout[307:300],
                                     1'b0, bus_fifo_dout[299:292],
                                     1'b0, bus_fifo_dout[291:284] };
             end

           // TODO: First, this really sucks and is inefficient in performance and resources
           //       (mostly resources).  This should be replaced by playing with the Wr/RdAck
           //       signals.  However, these are tempermental and mysterious so I am not going to
           //       do that now.
           fifo_sync #( .D_WIDTH( ((128*(C_WIDE_DATA+1))+(16*(C_WIDE_DATA+1))+(28-C_WIDE_DATA)+1) ),
                        .A_WIDTH( 5-C_WIDE_DATA ),
                        .DEPTH( 16*(2-C_WIDE_DATA) )
                        )
             bus_fifo( .clk( Bus2IP_Clk ),
                       .rst( Bus2IP_Reset ),
                       .din( bus_fifo_din ),
                       .wr_en( fifo_wr_en_dly | rd_cmd_issue_dly ),
                       .dout( bus_fifo_dout ),
                       .rd_en( Mem_Cmd_Ack ),
                       .empty( bus_fifo_empty ),
                       .full( bus_fifo_full )
                       );
        end
   endgenerate


   /////////////////////////////////////////////////////////////////////
   // __        __    _ _         ____  _              _              //
   // \ \      / / __(_) |_ ___  / ___|| |_ __ _  __ _(_)_ __   __ _  //
   //  \ \ /\ / / '__| | __/ _ \ \___ \| __/ _` |/ _` | | '_ \ / _` | //
   //   \ V  V /| |  | | ||  __/  ___) | || (_| | (_| | | | | | (_| | //
   //    \_/\_/ |_|  |_|\__\___| |____/ \__\__,_|\__, |_|_| |_|\__, | //
   //                                            |___/         |___/  //
   /////////////////////////////////////////////////////////////////////

   ////
   // Dword enable decoder
   ////
   generate
      if (C_WIDE_DATA == 0)
        begin:gen_dre_nwd
           always @( * )
             begin
                case ( dword_addr )
                  1'b0: dword_reg_en = 2'b01;
                  1'b1: dword_reg_en = 2'b10;
                endcase
             end
        end
      else
        begin:gen_dre_wd
           always @( * )
             begin
                case ( dword_addr )
                  2'b00: dword_reg_en = 4'b0001;
                  2'b01: dword_reg_en = 4'b0010;
                  2'b10: dword_reg_en = 4'b0100;
                  2'b11: dword_reg_en = 4'b1000;
                endcase
             end
        end
   endgenerate

   ////
   // Staging registers
   ////
   genvar i;

   generate
      for (i=0; i < 2*(C_WIDE_DATA+1); i=i+1)
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

   //////////////////////////////////////////////////////////////
   //  ____     _   ___       _             __                 //
   // |  _ \ __| | |_ _|_ __ | |_ ___ _ __ / _| __ _  ___ ___  //
   // | |_) / _` |  | || '_ \| __/ _ \ '__| |_ / _` |/ __/ _ \ //
   // |  _ < (_| |  | || | | | ||  __/ |  |  _| (_| | (_|  __/ //
   // |_| \_\__,_| |___|_| |_|\__\___|_|  |_|  \__,_|\___\___| //
   //                                                          //
   //////////////////////////////////////////////////////////////

   //
   // We don't care about the full signal, because our reads will
   // always complete as soon as possible and will never allow
   // the fifo to fill (the fifo is overprovisioned)
   //

   assign Mem_Rd_Ack = fifo_rd_en;

   generate
      if (C_WIDE_DATA == 0)
        begin:gen_rdo_nwd
           assign rd_data_out = { Mem_Rd_Dout[135:72], Mem_Rd_Dout[63:0] };
        end
      else
        begin:gen_rdo_wd
           assign rd_data_out = { Mem_Rd_Dout[279:216], Mem_Rd_Dout[207:144], Mem_Rd_Dout[135:72], Mem_Rd_Dout[63:0] };
        end
   endgenerate

   ////
   // FIFO output to bus MUX
   ////
   generate
      if (C_WIDE_DATA == 0)
        begin:gen_rdom_nwd
           always @( * )
             begin
                case ( rd_addr[3] )
                  1'b0: IP2Bus_Data = rd_data_out[63:0];
                  1'b1: IP2Bus_Data = rd_data_out[127:64];
                endcase
             end
        end
      else
        begin:gen_rdom_wd
           always @( * )
             begin
                case ( rd_addr[4:3] )
                  2'b00: IP2Bus_Data = rd_data_out[63:0];
                  2'b01: IP2Bus_Data = rd_data_out[127:64];
                  2'b10: IP2Bus_Data = rd_data_out[191:128];
                  2'b11: IP2Bus_Data = rd_data_out[255:192];
                endcase
             end
        end
   endgenerate

   /////////////////////////
   //  ___ ____ ___ ____  //
   // |_ _|  _ \_ _/ ___| //
   //  | || |_) | | |     //
   //  | ||  __/| | |___  //
   // |___|_|  |___\____| //
   //                     //
   /////////////////////////

   assign IP2Bus_PostedWrInh = (C_SUPPORT_SHARED == 0) ? 1'b0 : 1'b1;
   assign IP2Bus_WrAck       = dword_wr_en;
   assign IP2Bus_RdAck       = dword_rd_en;
   assign IP2Bus_AddrAck     = (C_SUPPORT_SHARED == 0) ? (|Bus2IP_WrCE || |Bus2IP_RdCE) : (dword_wr_en | |Bus2IP_RdCE);
   assign IP2Bus_Busy        = 0;
   assign IP2Bus_Error       = 0;
   assign IP2Bus_Retry       = 0;
   assign IP2Bus_ToutSup     = (C_SUPPORT_SHARED == 0) ? IP2Bus_AddrAck : (pending | IP2Bus_AddrAck);

endmodule
