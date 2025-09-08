// (C) 2001-2025 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// (C) 2001-2011 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// $Id: //acds/rel/11.1/ip/merlin/seq_altera_merlin_slave_agent/seq_altera_merlin_slave_agent.sv#1 $
// $Revision: #1 $
// $Date: 2011/08/15 $
// $Author: max $

`timescale 1 ns / 1 ns

module seq_altera_merlin_slave_agent
  #(
    // Packet parameters
    parameter PKT_BEGIN_BURST  = 81,
    parameter PKT_DATA_H       = 31,
    parameter PKT_DATA_L       = 0,
    parameter PKT_SYMBOL_W     = 8,
    parameter PKT_BYTEEN_H     = 71,
    parameter PKT_BYTEEN_L     = 68,
    parameter PKT_ADDR_H       = 63,
    parameter PKT_ADDR_L       = 32,
    parameter PKT_TRANS_LOCK   = 87,
    parameter PKT_TRANS_COMPRESSED_READ = 67,
    parameter PKT_TRANS_POSTED = 66, 
    parameter PKT_TRANS_WRITE  = 65,
    parameter PKT_TRANS_READ   = 64,
    parameter PKT_SRC_ID_H     = 74,
    parameter PKT_SRC_ID_L     = 72,
    parameter PKT_DEST_ID_H    = 77,
    parameter PKT_DEST_ID_L    = 75,
    parameter PKT_BURSTWRAP_H  = 85,
    parameter PKT_BURSTWRAP_L  = 82,
    parameter PKT_BYTE_CNT_H   = 81,
    parameter PKT_BYTE_CNT_L   = 78,
    parameter PKT_PROTECTION_H = 86,
    parameter PKT_PROTECTION_L = 86,
    parameter ST_DATA_W        = 90,
    parameter ST_CHANNEL_W     = 32,
//    parameter PKT_AXI_RESP_L   = 88,
//    parameter PKT_AXI_RESP_H   = 89,


    // Slave parameters
    parameter ADDR_W  = PKT_ADDR_H - PKT_ADDR_L + 1,
    parameter AVS_DATA_W    = PKT_DATA_H - PKT_DATA_L + 1,
    parameter AVS_BURSTCOUNT_W = 4,
    parameter PKT_SYMBOLS      = AVS_DATA_W / PKT_SYMBOL_W,

    // Slave agent parameters
    parameter PREVENT_FIFO_OVERFLOW = 0,
    parameter SUPPRESS_0_BYTEEN_CMD = 1,

    // Derived slave parameters
    parameter AVS_BE_W = PKT_BYTEEN_H - PKT_BYTEEN_L + 1,

    // Derived FIFO width
    parameter FIFO_DATA_W = ST_DATA_W + 1
  )
  (

    input clk,
    input reset_n,

    // Universal-Avalon anti-slave
    output [ADDR_W-1:0]           m0_address,
    output [AVS_BURSTCOUNT_W-1:0] m0_burstcount,
    output [AVS_BE_W-1:0]         m0_byteenable,
    output                        m0_read,
    input  [AVS_DATA_W-1:0]       m0_readdata,
    input                         m0_waitrequest,
    output                        m0_write,
    output [AVS_DATA_W-1:0]       m0_writedata,
    input                         m0_readdatavalid,
    output                        m0_debugaccess,
    output                        m0_lock,

    // Avalon-ST FIFO interfaces.
    // Note: there's no need to include the "data" field here, at least for
    // reads, since readdata is filled in from slave info.  To keep life
    // simple, have a data field, but fill it with 0s.
    // Av-st response fifo source interface
    output reg [FIFO_DATA_W-1:0] rf_source_data,
    output                  rf_source_valid,
    output                  rf_source_startofpacket,
    output                  rf_source_endofpacket,
    input                   rf_source_ready,

    // Av-st response fifo sink interface
    input [FIFO_DATA_W-1:0] rf_sink_data,
    input                   rf_sink_valid,
    input                   rf_sink_startofpacket,
    input                   rf_sink_endofpacket,
    output                  rf_sink_ready,

    // Av-st readdata fifo src interface
    output [AVS_DATA_W-1:0] rdata_fifo_src_data,
    output                  rdata_fifo_src_valid,
    input                   rdata_fifo_src_ready,

    // Av-st readdata fifo sink interface
    input [AVS_DATA_W-1:0]  rdata_fifo_sink_data,
    input                   rdata_fifo_sink_valid,
    output                  rdata_fifo_sink_ready,

    // Av-st sink command packet interface
    output                   cp_ready,
    input                    cp_valid,
    input [ST_DATA_W-1:0]    cp_data,
    input [ST_CHANNEL_W-1:0] cp_channel,
    input                    cp_startofpacket,
    input                    cp_endofpacket,

    // Av-st source response packet interface
    input                      rp_ready,
    output                     rp_valid,
    output reg [ST_DATA_W-1:0] rp_data,
    output                     rp_startofpacket,
    output                     rp_endofpacket
);

      function integer clog2;
      input [31:0] Depth;
      integer i;
      begin
         i = Depth;        
         for(clog2 = 0; i > 0; clog2 = clog2 + 1)
           i = i >> 1;
      end
 
      endfunction // clog2
   

  // ------------------------------------------------
  // Local Parameters
  // ------------------------------------------------
  localparam DATA_W      = PKT_DATA_H - PKT_DATA_L + 1;
  localparam BE_W        = PKT_BYTEEN_H - PKT_BYTEEN_L + 1;
  localparam MID_W       = PKT_SRC_ID_H - PKT_SRC_ID_L + 1;
  localparam SID_W       = PKT_DEST_ID_H - PKT_DEST_ID_L + 1;
  localparam BYTE_CNT_W  = PKT_BYTE_CNT_H - PKT_BYTE_CNT_L + 1;
  localparam BURSTWRAP_W = PKT_BURSTWRAP_H - PKT_BURSTWRAP_L + 1;
//  localparam RESP_W 	 = PKT_AXI_RESP_H - PKT_AXI_RESP_L + 1;

  // ------------------------------------------------
  // Signals
  // ------------------------------------------------
  wire [DATA_W-1:0]      cmd_data;
  wire [BE_W-1:0]        cmd_byteen;
  wire [ADDR_W-1:0]      cmd_addr;
  wire [MID_W-1:0]       cmd_mid;
  wire [SID_W-1:0]       cmd_sid;
  wire                   cmd_read;
  wire                   cmd_write;
  wire                   cmd_compressed;
  wire                   cmd_posted;
  wire [BYTE_CNT_W-1:0]  cmd_byte_cnt;
  wire [BURSTWRAP_W-1:0] cmd_burstwrap;
  wire                   cmd_debugaccess;
//  wire [RESP_W-1:0]		 cmd_response;

  wire               byteen_asserted;
  wire               read_suppressed;
  wire               generate_response;
  wire				 nonposted_write_endofpacket; //llim: to get a condition where it is the end of packet and a write command packet. This is to push command packet into fifo 

  // Assign command fields										//for axi writes
  assign cmd_data     = cp_data[PKT_DATA_H  :PKT_DATA_L  ]; 	//wdata 		//0 default
  assign cmd_byteen   = cp_data[PKT_BYTEEN_H:PKT_BYTEEN_L]; 	//wstrb			//MISSING
  assign cmd_addr     = cp_data[PKT_ADDR_H  :PKT_ADDR_L  ]; 	//awaddr		//araddr
  assign cmd_compressed = cp_data[PKT_TRANS_COMPRESSED_READ]; 	//always 0		//0
  assign cmd_posted   = cp_data[PKT_TRANS_POSTED]; 				//alwyas 0		//0
  assign cmd_write    = cp_data[PKT_TRANS_WRITE];				// 1			//0
  assign cmd_read     = cp_data[PKT_TRANS_READ];				// 0			//1
  assign cmd_mid      = cp_data[PKT_SRC_ID_H :PKT_SRC_ID_L];	//take in the mid from transform
  assign cmd_sid      = cp_data[PKT_DEST_ID_H:PKT_DEST_ID_L];	//dump out the sid from the slave
  assign cmd_byte_cnt = cp_data[PKT_BYTE_CNT_H:PKT_BYTE_CNT_L]; //0 for now		//0
  assign cmd_burstwrap= cp_data[PKT_BURSTWRAP_H:PKT_BURSTWRAP_L]; //MISSING		//missing
  assign cmd_debugaccess = cp_data[PKT_PROTECTION_L];			// awprot bit0  //arprotbit0

  // Local "ready_for_command" signal: deasserted when the agent is unable to accept
  // another command, e.g. rdv FIFO is full, (local readdata storage is full &&
  // ~rp_ready), ...
  // Say, this could depend on the type of command, for example, even if the
  // rdv FIFO is full, a write request can be accepted.  For later.

  wire ready_for_command;

  wire local_lock  = cp_valid & cp_data[PKT_TRANS_LOCK];
  wire local_write = cp_valid & cp_data[PKT_TRANS_WRITE];
  wire local_read  = cp_valid & cp_data[PKT_TRANS_READ];
  wire local_compressed_read = cp_valid & cp_data[PKT_TRANS_COMPRESSED_READ]; 
  assign nonposted_write_endofpacket = local_write & cp_endofpacket & ~cp_data[PKT_TRANS_POSTED];
  //wire rf_sink_write = rf_sink_valid & rf_sink_data[PKT_TRANS_WRITE];  //llim: need a set of signals from the rf_sink to connect to sink_valid of burst uncompressor
  //assign rf_nonposted_write_endofpacket = rf_sink_write & rf_sink_endofpacket & ~rf_sink_data[PKT_TRANS_POSTED];

  // num_symbols is PKT_SYMBOLS, appropriately sized.
  wire [31:0] int_num_symbols = PKT_SYMBOLS;
  wire [BYTE_CNT_W-1:0] num_symbols = int_num_symbols[BYTE_CNT_W-1:0];

  generate
    if (PREVENT_FIFO_OVERFLOW) begin : prevent_fifo_overflow
      //---------------------------------------------------
      // Backpressure if the slave says to, or if FIFO overflow may occur.
      // 
      // All commands are backpressured once the FIFO is full
      // even if they don't need storage. This breaks a long
      // combinatorial path from the master read/write through
      // this logic and back to the master via the backpressure
      // path.
      //
      // To avoid a loss of throughput the FIFO will be parameterized 
      // one slot deeper. The extra slot should never be used in normal
      // operation, but should a slave misbehave and accept one more
      // read than it should then backpressure will kick in.
      //
      // An example: assume a slave with MPRT = 2. It can accept a
      // command sequence RRWW without backpressuring. If the FIFO is
      // only 2 deep, we'd backpressure the writes leading to loss of
      // throughput. If the FIFO is 3 deep, we'll only backpressure when
      // RRR... which is an illegal condition anyway.
      //---------------------------------------------------
      // assign cp_ready = ~m0_waitrequest && ready_for_command;
      assign cp_ready = (~m0_waitrequest | ~byteen_asserted) && ready_for_command;
      assign ready_for_command = rf_source_ready;
    end else begin : no_prevent_fifo_overflow
      // Backpressure only if the slave says to.
      assign cp_ready = ~m0_waitrequest | ~byteen_asserted;
      // Do not suppress the command or the slave will
      // not be able to waitrequest
      assign ready_for_command = 1'b1;
    end
  endgenerate

  generate if (SUPPRESS_0_BYTEEN_CMD) begin : suppress_0_byteen_cmd
      assign byteen_asserted = |cmd_byteen;
  end else begin : no_suppress_0_byteen_cmd
      assign byteen_asserted = 1'b1;
  end
  endgenerate

  //-------------------------------------------------------------------
  // Extract avalon signals from command packet.
  //-------------------------------------------------------------------
  assign m0_address = cmd_addr;
  assign m0_byteenable = cmd_byteen;
  assign m0_writedata = cmd_data;

  // Note: no Avalon-MM slave in existence accepts uncompressed read bursts -
  // this sort of burst exists only in merlin fabric ST packets. What to do
  // if we see such a burst? All beats in that burst need to be transmitted
  // to the slave so we have enough space-time for byteenable expression.
  //
  // There can be multiple bursts in a packet, but only one beat per burst
  // in <most> cases. The exception is when we've decided not to insert a
  // burst adapter for efficiency reasons, in which case this agent is also
  // responsible for driving burstcount to 1 on each beat of an uncompressed
  // read burst.

  assign m0_read = ready_for_command & byteen_asserted &
    (local_compressed_read | local_read);

  generate 
    begin : m0_burstcount_zero_pad
      // AVS_BURSTCOUNT_W and BYTE_CNT_W may not be equal.  Assign m0_burstcount
      // from a sub-range, or 0-pad, as appropriate.
      if (AVS_BURSTCOUNT_W > BYTE_CNT_W) begin
        wire [AVS_BURSTCOUNT_W - BYTE_CNT_W - 1 : 0] zero_pad =
          {(AVS_BURSTCOUNT_W - BYTE_CNT_W) {1'b0}};
        assign m0_burstcount = (local_read & ~local_compressed_read) ?
          {zero_pad, num_symbols} :
          {zero_pad, cmd_byte_cnt};
      end
      else begin : mo_burstcount_no_pad
        assign m0_burstcount = (local_read & ~local_compressed_read) ? 
          num_symbols[AVS_BURSTCOUNT_W-1:0] : 
          cmd_byte_cnt[AVS_BURSTCOUNT_W-1:0];
      end
    end 
  endgenerate

  assign m0_write = ready_for_command & local_write & byteen_asserted;
  assign m0_lock  = ready_for_command & local_lock & (m0_read | m0_write);
  assign m0_debugaccess = cmd_debugaccess;

  //-------------------------------------------------------------------
  // Indirection layer for response packet values.  Some may always wire
  // directly from the slave translator; others will no doubt emerge from
  // various FIFOs.
  // What to put in resp_data when a write occured? For now, there's simply no
  // response packet for writes.

  assign rdata_fifo_src_valid = m0_readdatavalid;
  assign rdata_fifo_src_data  = m0_readdata;

  // ------------------------------------------------------------------
  // Generate a token when read commands are suppressed. The token
  // is stored in the response FIFO, and will be used to synthesize 
  // a read response.

  // llim: token also used for generating write responses at the end of each packet for nonposted_write
  //
  // Note: this token is not generated for suppressed uncompressed read cycles;
  // the burst uncompression logic at the read side of the response FIFO
  // generates the correct number of responses.
  // ------------------------------------------------------------------
  assign read_suppressed = ((local_read | local_compressed_read) & !byteen_asserted) | nonposted_write_endofpacket;

  // Avalon-ST interfaces to external response fifo:
  assign rf_source_valid = (local_read | local_compressed_read | nonposted_write_endofpacket) & ready_for_command & cp_ready; //llim: modifying this to allow non-posted write commands to also be stored in the response fifo.
  assign rf_source_startofpacket = cp_startofpacket;
  assign rf_source_endofpacket   = cp_endofpacket;
  always @* begin
    // Default: assign every command packet field to the response FIFO...
    rf_source_data                              = {1'b0, cp_data};

    // ... and override select fields as needed.
    rf_source_data[FIFO_DATA_W-1]               = read_suppressed;
    rf_source_data[PKT_DATA_H   :PKT_DATA_L]    = {DATA_W {1'b0}};
    rf_source_data[PKT_BYTEEN_H :PKT_BYTEEN_L]  = cmd_byteen;
    rf_source_data[PKT_ADDR_H   :PKT_ADDR_L]    = cmd_addr;
    rf_source_data[PKT_TRANS_COMPRESSED_READ]   = cmd_compressed;
    rf_source_data[PKT_TRANS_POSTED]            = cmd_posted;
    rf_source_data[PKT_TRANS_WRITE]             = cmd_write;
    rf_source_data[PKT_TRANS_READ]              = cmd_read;
    rf_source_data[PKT_SRC_ID_H :PKT_SRC_ID_L]  = cmd_mid;
    rf_source_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = cmd_sid;
    rf_source_data[PKT_BYTE_CNT_H:PKT_BYTE_CNT_L]   = cmd_byte_cnt;
    rf_source_data[PKT_BURSTWRAP_H:PKT_BURSTWRAP_L] = cmd_burstwrap;
    rf_source_data[PKT_PROTECTION_H:PKT_PROTECTION_L] = 0;		//*** SV-to-V: '0=>0 
    rf_source_data[PKT_PROTECTION_L]            = cmd_debugaccess;
  end

  wire uncompressor_source_valid;
  assign generate_response = rf_sink_data[FIFO_DATA_W-1];
  //assign rp_valid = rdata_fifo_sink_valid | (uncompressor_source_valid | generate_response);
  assign rp_valid = rdata_fifo_sink_valid | uncompressor_source_valid;

  wire [BYTE_CNT_W-1:0] rf_sink_byte_cnt = rf_sink_data[PKT_BYTE_CNT_H:PKT_BYTE_CNT_L];
  wire rf_sink_compressed                = rf_sink_data[PKT_TRANS_COMPRESSED_READ];
  wire [BURSTWRAP_W-1:0] rf_sink_burstwrap = rf_sink_data[PKT_BURSTWRAP_H:PKT_BURSTWRAP_L];
  wire [ADDR_W-1:0] rf_sink_addr = rf_sink_data[PKT_ADDR_H:PKT_ADDR_L];

  wire [BYTE_CNT_W-1:0] burst_byte_cnt;
  wire [BURSTWRAP_W-1:0] rp_burstwrap;
  wire [ADDR_W-1:0] rp_address;
  wire rp_is_compressed;

  // ------------------------------------------------------------------
  // Backpressure the readdata fifo if we're supposed to synthesize a response
  // llim: also backpressure the rdata fifo when there is a write response
  // ------------------------------------------------------------------
  assign rdata_fifo_sink_ready = rdata_fifo_sink_valid & rp_ready & ~(rf_sink_valid & generate_response);

  always @* begin
    // By default, return all fields...
    rp_data                                    = rf_sink_data[ST_DATA_W - 1 : 0];

    // ... and override specific fields.
    rp_data[PKT_DATA_H   :PKT_DATA_L]          = rdata_fifo_sink_data;
    // Assignments directly from the response fifo.
    rp_data[PKT_TRANS_POSTED]                  = rf_sink_data[PKT_TRANS_POSTED]; // should always be 1
    rp_data[PKT_TRANS_WRITE]                   = rf_sink_data[PKT_TRANS_WRITE];
    rp_data[PKT_SRC_ID_H :PKT_SRC_ID_L]        = rf_sink_data[PKT_DEST_ID_H : PKT_DEST_ID_L];
    rp_data[PKT_DEST_ID_H:PKT_DEST_ID_L]       = rf_sink_data[PKT_SRC_ID_H : PKT_SRC_ID_L];
    rp_data[PKT_BYTEEN_H :PKT_BYTEEN_L]        = rf_sink_data[PKT_BYTEEN_H : PKT_BYTEEN_L];
    rp_data[PKT_PROTECTION_H:PKT_PROTECTION_L] = rf_sink_data[PKT_PROTECTION_H:PKT_PROTECTION_L];

    // Burst uncompressor assignments
    rp_data[PKT_ADDR_H   :PKT_ADDR_L]        = rp_address;
    rp_data[PKT_BURSTWRAP_H:PKT_BURSTWRAP_L] = rp_burstwrap;
    rp_data[PKT_BYTE_CNT_H:PKT_BYTE_CNT_L]   = burst_byte_cnt;
    rp_data[PKT_TRANS_READ]                  = rf_sink_data[PKT_TRANS_READ] | rf_sink_data[PKT_TRANS_COMPRESSED_READ];
    rp_data[PKT_TRANS_COMPRESSED_READ]       = rp_is_compressed;
//	rp_data[PKT_AXI_RESP_H:PKT_AXI_RESP_L]	 = 2'b0; //llim: always return OKAY for avalon non bursting transaction
  end

  seq_altera_merlin_burst_uncompressor #(
      .ADDR_W (ADDR_W),
      .BURSTWRAP_W (BURSTWRAP_W),
      .BYTE_CNT_W (BYTE_CNT_W),
      .PKT_SYMBOLS (PKT_SYMBOLS)
    ) uncompressor
  (
    .clk (clk),
    .reset_n (reset_n),
    .sink_startofpacket (rf_sink_startofpacket),
    .sink_endofpacket (rf_sink_endofpacket),
    .sink_valid (rf_sink_valid & (rdata_fifo_sink_valid | generate_response )), //llim
    .sink_ready (rf_sink_ready),
    .sink_addr (rf_sink_addr),
    .sink_burstwrap (rf_sink_burstwrap),
    .sink_byte_cnt (rf_sink_byte_cnt),
    .sink_is_compressed (rf_sink_compressed),

    .source_startofpacket (rp_startofpacket),
    .source_endofpacket (rp_endofpacket),
    .source_valid (uncompressor_source_valid),
    .source_ready (rp_ready),
    .source_addr (rp_address),
    .source_burstwrap (rp_burstwrap),
    .source_byte_cnt (burst_byte_cnt),
    .source_is_compressed (rp_is_compressed)
  );

endmodule

