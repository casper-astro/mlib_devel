`timescale 1ps / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    14:17:52 07/20/05
// Design Name:    
// Module Name:    plb_ctrl
// Project Name:   
// Target Device:  
// Tool versions:  
// Description:
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module plb_ctrl(
		// DDR2 controller inputs/outputs
		DDR_Clk,
		DDR_ready,
		DDR_wr,
		DDR_rd,
		DDR_wr_en,
		DDR_rd_en,
		DDR_dout,
		DDR_din,
		DDR_be,
		DDR_addr,
		
		// PLB to slave
		PLB_Clk,
		PLB_Rst,
		
		PLB_PAValid,
		PLB_busLock,
		PLB_masterID,
		PLB_RNW,
		PLB_BE,
		PLB_size,
		PLB_type,
		PLB_MSize,
		PLB_compress,
		PLB_guarded,
		PLB_ordered,
		PLB_lockErr,
		PLB_abort,
		PLB_ABus,
		PLB_pendReq,
		PLB_pendPri,
		PLB_reqPri,
		PLB_SAValid,
		PLB_rdPrim,
		PLB_wrPrim,
		PLB_wrDBus,
		PLB_wrBurst,
		PLB_rdBurst,
		
		// Slave to PLB
		Sl_addrAck,
		Sl_wait,
		Sl_SSize,
		Sl_rearbitrate,
		Sl_MBusy,
		Sl_MErr,
		Sl_wrDAck,
		Sl_wrComp,
		Sl_wrBTerm,
		Sl_rdDBus,
		Sl_rdWdAddr,
		Sl_rdDAck,
		Sl_rdComp,
		Sl_rdBTerm
		);
   
   //----------------------------------------------------------------------
   // Parameters
   //----------------------------------------------------------------------

   parameter 	  C_MEM_BASE_ADDR   = 32'h00000000;
   parameter 	  C_MEM_HIGH_ADDR   = 32'h0fffffff;
   parameter      C_PLB_AWIDTH      = 32;
   parameter      C_PLB_DWIDTH      = 64;
   parameter 	  C_PLB_MID_WIDTH   = 3;   
   parameter      C_PLB_NUM_MASTERS = 8;
   parameter      C_FAMILY          = "virtex2p";
   
   //----------------------------------------------------------------------
   // Inputs and outputs
   //----------------------------------------------------------------------

   input 	                  DDR_Clk;
   input 			  DDR_wr_en;
   input 			  DDR_rd_en;
   input 			  DDR_ready;
   input [0:127] 		  DDR_dout;
   output [0:26] 		  DDR_addr;
   output [0:127] 		  DDR_din;
   output [0:15] 		  DDR_be;
   output 			  DDR_wr;
   output 			  DDR_rd;

   input 			  PLB_Clk;
   input 			  PLB_Rst;
   input 			  PLB_PAValid;
   input 			  PLB_busLock;
   input [0:C_PLB_MID_WIDTH-1] 	  PLB_masterID;
   input 			  PLB_RNW;
   input [0:7] 			  PLB_BE;
   input [0:3] 			  PLB_size;
   input [0:2] 			  PLB_type;
   input [0:1] 			  PLB_MSize;
   input 			  PLB_compress;
   input 			  PLB_guarded;
   input 			  PLB_ordered;
   input 			  PLB_lockErr;
   input 			  PLB_abort;
   input [0:31] 		  PLB_ABus;
   input 			  PLB_pendReq;
   input [0:1] 			  PLB_pendPri;
   input [0:1] 			  PLB_reqPri;
   input 			  PLB_SAValid;
   input 			  PLB_rdPrim;
   input 			  PLB_wrPrim;
   input [0:63] 		  PLB_wrDBus;
   input 			  PLB_wrBurst;
   input 			  PLB_rdBurst;
   
   output 			  Sl_addrAck;
   output 			  Sl_wait;
   output [0:1] 		  Sl_SSize;
   output 			  Sl_rearbitrate;
   output [0:C_PLB_NUM_MASTERS-1] Sl_MBusy;
   output [0:C_PLB_NUM_MASTERS-1] Sl_MErr;
   output 			  Sl_wrDAck;
   output 			  Sl_wrComp;
   output 			  Sl_wrBTerm;
   output [0:63] 		  Sl_rdDBus;   
   output [0:3] 		  Sl_rdWdAddr;
   output 			  Sl_rdDAck;
   output 			  Sl_rdComp;
   output 			  Sl_rdBTerm;

   //----------------------------------------------------------------------
   // Default outputs
   //----------------------------------------------------------------------

   wire 			  Sl_wait    = 1'b0;
   wire [0:C_PLB_NUM_MASTERS-1]   Sl_MErr    = {C_PLB_NUM_MASTERS{1'b0}};
   
   //----------------------------------------------------------------------
   // Flattened registers
   //----------------------------------------------------------------------

   reg 				  Sl_addrAck;
   reg [0:1] 			  Sl_SSize;   
   reg 				  Sl_wrDAck;
   reg 				  Sl_wrComp;
   reg 				  Sl_rdDAck;
   reg 				  Sl_rdComp;
   reg                            Sl_wrBTerm;
   reg                            Sl_rdBTerm;

   //----------------------------------------------------------------------
   // Request control signals
   //----------------------------------------------------------------------

   reg 				  CTRL_wr_en;
   reg 				  CTRL_rd_en;
   reg 				  CTRL_P2D_en;
   reg 				  CTRL_BEAT_en;
   reg 				  CTRL_done;
   reg 				  CTRL_done_dly1;
   reg 				  CTRL_done_dly2;
   reg 				  CTRL_STG_en;
   reg 				  CTRL_start_rd;
   reg 				  CTRL_start_wr;
   reg 				  CTRL_wr_en_dly;
   reg                            CTRL_clear;
   
   wire 			  REQ_rst;
   wire 			  REQ_valid;
   wire [0:3] 			  REQ_size;
   wire 			  REQ_rnw;
   wire 			  REQ_burst;
   wire 			  REQ_byte;
   wire 			  REQ_half;
   wire 			  REQ_word;
   wire [0:7] 			  REQ_be;
   wire [0:26] 			  REQ_addr;
   
   //----------------------------------------------------------------------
   
   always @( posedge PLB_Clk )
     begin
	CTRL_wr_en_dly <= CTRL_wr_en;
	CTRL_done_dly1 <= CTRL_done;
	CTRL_done_dly2 <= CTRL_done_dly1;
     end

   //----------------------------------------------------------------------

   assign REQ_rst = PLB_Rst | CTRL_done;
   assign REQ_valid = ((~C_MEM_HIGH_ADDR & PLB_ABus) == 32'h0) & PLB_PAValid & ~PLB_abort;
   
   //----------------------------------------------------------------------
   // Registers for tranfer qualifiers
   //----------------------------------------------------------------------

   ////
   // Sl_MBusy
   //
   // This signal is a vector with a bit per master (thus is sized depending
   // on how the PLB bus is parametrized) that is asserted from one cycle after
   // the Sl_addrAck to the completion of the request (rd/wrComp) and should be
   // zero otherwise.  Here we register on the ACK cycle and it will be valid on
   // the next cycle.
   ////

   wire [0:C_PLB_NUM_MASTERS-1] REQ_MBusy;
   
   gen_dec master_dec( .IN( PLB_masterID ),
		       .OUT( REQ_MBusy ) );
   defparam master_dec.inwidth = C_PLB_MID_WIDTH;
   defparam master_dec.outwidth = C_PLB_NUM_MASTERS;
   defparam master_dec.flip = 1;

   d_ff REQ_MBusy_ff( .CLK( PLB_Clk ),
		      .D( REQ_MBusy ),
		      .Q( Sl_MBusy ),
		      .EN( Sl_addrAck ),
		      .RST( REQ_rst ) );
   defparam REQ_MBusy_ff.width = C_PLB_NUM_MASTERS;
   
   //----------------------------------------------------------------------

   ////
   // PLB_RNW -> REQ_rnw
   //
   // The ReadNotWrite signal is asserted high when the request is a read
   // and is low when it is a write.  This signal is only valid while
   // PLB_PAValid is asserted up to and including the cycle where the slave
   // asserts Sl_addrAck.  It is latched with a regular (not pass through)
   // FF because it is used on the cycle following the address ACK.
   ////
   
   d_ff REQ_rnw_ff( .CLK( PLB_Clk ),
		    .D( PLB_RNW ),
		    .Q( REQ_rnw ),
		    .EN( Sl_addrAck ),
		    .RST( REQ_rst ) );
   defparam REQ_rnw_ff.width = 1;

   //----------------------------------------------------------------------

   ////
   // PLB_size -> REQ_size
   //
   // This signal gives information on the size of the transaction that is 
   // requested.  The following table gives its meaning:
   //
   // PLB_size[0:3]  ----  Transfer
   //    0000               Single bus worth governed by byte enables
   //    0001               4-word line transfer
   //    0010               8-word line transfer
   //    0011               16-word line transfer
   //    1000               Burst of bytes
   //    1001               Burst of half words
   //    1010               Burst of words
   //    1011               Burst of double words
   //    1100               Burst of quad words
   //    1101               Burst of octal words
   ////

   localparam 
     ONE_WORD     = 4'b0000,
     FOUR_WORD    = 4'b0001,
     EIGHT_WORD   = 4'b0010,
     SIXTEEN_WORD = 4'b0011,
     BURST_BYTE   = 4'b1000,
     BURST_HALF   = 4'b1001,
     BURST_WORD   = 4'b1010,
     BURST_DWORD  = 4'b1011,
     BURST_QWORD  = 4'b1100,
     BURST_OWORD  = 4'b1101;
   
   d_ff REQ_size_ff( .CLK( PLB_Clk ),
		     .D( PLB_size ),
		     .Q( REQ_size ),
		     .EN( Sl_addrAck ),
		     .RST( REQ_rst ) );
   defparam REQ_size_ff.width = 4;

   //----------------------------------------------------------------------

   ////
   // PLB_BE -> REQ_be
   //
   // The byte enables directly select which bytes are read/written for
   // single bus width transactions.  For bursts the byte enables specify
   // how many data beats the transaction is composed of (although is not
   // necessary because the rd/wrBurst signals also govern transaction length.
   ////
   
   d_ff REQ_be_ff( .CLK( PLB_Clk ),
		   .D( PLB_BE ),
		   .Q( REQ_be ),
		   .EN(  Sl_addrAck ),
		   .RST( REQ_rst ) );
   defparam REQ_be_ff.width = 8;
   
   //----------------------------------------------------------------------

   ////
   // PLB_ABus -> REQ_addr
   //
   // The address is valid when PLB_PAValid is asserted until and including
   // the cycle where Sl_addrAck is asserted.  We only latch the upper 27 bits
   // of the address because our interface with the physical side operates in
   // 256-bit chunks.  We select particular bytes, halfwords, ect through
   // byte enables sent to the physical layer.
   ////
   
   reg      PLB_ABus_lsb;

   always @( * )
     begin
	if (PLB_size == SIXTEEN_WORD)
	  PLB_ABus_lsb = 1'b0;
	else
	  PLB_ABus_lsb = PLB_ABus[26];
     end

   assign REQ_addr = { PLB_ABus[0:25], PLB_ABus_lsb };

   //----------------------------------------------------------------------
   // PLB to data FIFO counter
   //----------------------------------------------------------------------

   wire [0:1] 	  P2D_dw_cnt;
   reg [0:1] 	  P2D_dw_cnt_l;

   always @( * )
     begin
	if ( (PLB_size == ONE_WORD)   | 
	     (PLB_size == BURST_BYTE) |
	     (PLB_size == BURST_HALF) | 
	     (PLB_size == BURST_WORD) |
	     (PLB_size == BURST_DWORD) )
	  P2D_dw_cnt_l = PLB_ABus[27:28];
        else if (PLB_size == FOUR_WORD)
          P2D_dw_cnt_l = { PLB_ABus[27], 1'b0 };
	else
	  P2D_dw_cnt_l = 2'b00;
     end
   
   up_count P2D_cntr( .CLK( PLB_Clk ),
		      .CNT( P2D_dw_cnt ),
		      .LD( Sl_addrAck ),
		      .L( P2D_dw_cnt_l ),
		      .EN( CTRL_P2D_en ),
		      .RST( REQ_rst ) );
   defparam 	  P2D_cntr.width = 2;
   
   wire 	  P2D_dw_0 = ~P2D_dw_cnt[1];
   wire 	  P2D_dw_1 = P2D_dw_cnt[1];
   wire           P2D_qw_0 = ~P2D_dw_cnt[0];
   wire 	  P2D_qw_1 = P2D_dw_cnt[0];

   //----------------------------------------------------------------------
   // Beat counter
   //----------------------------------------------------------------------

   wire [0:2] 	  BEAT_cnt;
   reg [0:2] 	  BEAT_cnt_l;

   always @( * )
     begin
	if (PLB_size == BURST_BYTE)
	  BEAT_cnt_l = PLB_ABus[29:31];
	else if (PLB_size == BURST_HALF)
	  BEAT_cnt_l = PLB_ABus[28:30];
	else if (PLB_size == BURST_WORD)
	  BEAT_cnt_l = PLB_ABus[27:29];
	else
	  BEAT_cnt_l = 3'h0;
     end

   up_count BEAT_cntr( .CLK( PLB_Clk ),
		       .CNT( BEAT_cnt ),
		       .LD( Sl_addrAck & PLB_size[0] ),
		       .L( BEAT_cnt_l ),
		       .EN( CTRL_BEAT_en ),
		       .RST( REQ_rst ) );
   defparam 	  BEAT_cntr.width = 3;

   wire [0:3]     TERM_cnt;
   
   ud_count TERM_cntr( .CLK( PLB_Clk ),
                       .CNT( TERM_cnt ),
                       .LD( Sl_addrAck & PLB_size[0] ),
                       .L( PLB_BE[0:3] ),
                       .UP( 1'b0 ),
                       .DOWN( Sl_rdDAck || Sl_wrDAck ),
                       .RST( REQ_rst ) );
   defparam       TERM_cntr.width = 4;
   
   //----------------------------------------------------------------------
   // Beat terminal count
   //----------------------------------------------------------------------

   reg [0:2] 	  BEAT_tc;
   wire 	  BEAT_done = (BEAT_cnt == BEAT_tc);
   
   always @( * )
     begin
	case (REQ_size[2:3])
	  2'b00: BEAT_tc = 3'b000;
	  2'b01: BEAT_tc = 3'b001;
	  2'b10: BEAT_tc = 3'b011;
	  2'b11: BEAT_tc = 3'b111;
	endcase
     end

   //----------------------------------------------------------------------
   // Delay counter
   //----------------------------------------------------------------------

   wire [0:1] 	REQ_rd_delay_cnt;
   wire 	REQ_rd_delay_done = (REQ_rd_delay_cnt == 2'b11);

   up_count rd_delay_cntr( .CLK( PLB_Clk ),
			   .CNT( REQ_rd_delay_cnt ),
			   .LD( Sl_addrAck ),
			   .L( 2'h0 ),
			   .EN( ~REQ_rd_delay_done ),
			   .RST( REQ_rst ) );
   defparam 	rd_delay_cntr.width = 2;

   //----------------------------------------------------------------------
   // Read word address generation
   //----------------------------------------------------------------------

   wire [0:3] rdWdAddr = { BEAT_cnt, 1'b0 };

   assign     Sl_rdWdAddr = (REQ_rd_delay_done & REQ_rnw) ? rdWdAddr : 4'b0;

   //----------------------------------------------------------------------
   // Byte enable generation
   //----------------------------------------------------------------------

   wire [0:7] BEG_be;
   
   byte_enable_gen bgen( .size( REQ_size ),
			 .count( BEAT_cnt ),
			 .be_in( REQ_be ),
			 .burst( REQ_burst ),
			 .byte( REQ_byte ),
			 .half( REQ_half ),
			 .word( REQ_word ),
			 .be_out( BEG_be ) );

   //----------------------------------------------------------------------
   // Byte to double word staging
   //----------------------------------------------------------------------

   wire [0:127]  STG_dout;
   wire [0:15] 	 STG_be;

   dword_stage dword0( .clk( PLB_Clk ),
		       .rst( PLB_Rst | Sl_addrAck | CTRL_clear ),
		       .din( PLB_wrDBus ),
		       .be_in( BEG_be ),
		       .en( P2D_dw_0 & CTRL_STG_en ),
		       .dout( STG_dout[0:63] ),
		       .be_out( STG_be[0:7] ) );

   dword_stage dword1( .clk( PLB_Clk ),
		       .rst( PLB_Rst | Sl_addrAck | (P2D_dw_0 & CTRL_STG_en) | CTRL_clear ),
		       .din( PLB_wrDBus ),
		       .be_in( BEG_be ),
		       .en( P2D_dw_1 & CTRL_STG_en ),
		       .dout( STG_dout[64:127] ),
		       .be_out( STG_be[8:15] ) );

   //----------------------------------------------------------------------
   // Logic clock enable syncronized to DDR clock
   //----------------------------------------------------------------------

   reg           PLB_Cycle_First_Half;
   reg           PLB_Rst_dly;

   always @( posedge PLB_Clk )
     begin
        PLB_Rst_dly <= PLB_Rst;
     end

   always @( posedge DDR_Clk )
     begin
        if (PLB_Rst_dly)
          PLB_Cycle_First_Half <= 1'b1;
        else
          PLB_Cycle_First_Half <= ~PLB_Cycle_First_Half;
     end
   
   //----------------------------------------------------------------------
   // Read and write signals for FIFOs, data MUX, data FIFOs
   //----------------------------------------------------------------------   

   wire 	 RFIFO_empty;
   wire 	 WFIFO_full;

   // Used for Debugging
   wire 	 RFIFO_full;
   wire 	 WFIFO_empty;

   ////
   // Extend the full/empty signals to PLB clock sized pulses aligned on the
   // rising edge of the PLB clock (so we get full 100MHz from FIFO status change)
   ////

   reg          RFIFO_empty_ff;
   reg          WFIFO_full_ff;

   wire         RFIFO_empty_100 = RFIFO_empty | RFIFO_empty_ff;
   wire         WFIFO_full_100 = WFIFO_full | WFIFO_full_ff;

   always @( posedge DDR_Clk )
     begin
        RFIFO_empty_ff <= RFIFO_empty;
        WFIFO_full_ff  <= WFIFO_full;
     end
   
//   always @( posedge PLB_Clk )
//     begin
//        RFIFO_empty_100 <= RFIFO_empty;
//        WFIFO_full_100  <= WFIFO_full;
//     end
      
   ////
   
   wire [0:127]  DFIFO_rd_out;
   wire          DFIFO_rst;

   wire  	rd_en = CTRL_rd_en & ~PLB_Cycle_First_Half;
   wire  	wr_en = CTRL_wr_en_dly & ~PLB_Cycle_First_Half;
   
   fifo_sync_128x16 DFIFO_rd_data( .clk( DDR_Clk ),
				   .din( DDR_dout ),
				   .rd_en( rd_en ),
				   .rst( PLB_Rst | DFIFO_rst ),
				   .wr_en( DDR_wr_en ),
				   .dout( DFIFO_rd_out ),
				   .empty( RFIFO_empty ),
				   .full( RFIFO_full ) );

   fifo_sync_144x16 DFIFO_wr_data( .clk( DDR_Clk ),
				   .din( { STG_dout, STG_be } ),
				   .rd_en( DDR_rd_en ),
				   .rst( PLB_Rst ),
				   .wr_en( wr_en ),
				   .dout( { DDR_din, DDR_be } ),
				   .empty( WFIFO_empty ),
				   .full( WFIFO_full ) );
    
   //----------------------------------------------------------------------
   // MUX for FIFO to PLB
   //----------------------------------------------------------------------

   reg [0:63] 	D2P_mux_out;

   always @( * )
     begin
	case (P2D_dw_cnt[1])
	  1'b0: D2P_mux_out = DFIFO_rd_out[0:63];
	  1'b1: D2P_mux_out = DFIFO_rd_out[64:127];
	endcase
     end
   
   assign 	Sl_rdDBus = REQ_rnw ? D2P_mux_out : 64'h0;

   //----------------------------------------------------------------------
   // Command counters
   //----------------------------------------------------------------------

   wire 	WR_cnt;
   
   up_count WR_cntr( .CLK( PLB_Clk ),
		     .CNT( WR_cnt ),
		     .LD( 1'b0 ),
		     .L( 1'bx ),
		     .EN( CTRL_wr_en_dly ),
		     .RST( PLB_Rst ) );
   defparam WR_cntr.width = 1;
   
   //----------------------------------------------------------------------
   // Command controller
   //----------------------------------------------------------------------
   
   wire 	CMD_rdy;
   wire 	CMD_req = CTRL_wr_en_dly & WR_cnt;
   wire 	CMD_done = CTRL_done_dly2;
   
   ////
   // Clean up the ready signal
   ////

   wire         DDR_ready_200 = DDR_ready & ~PLB_Cycle_First_Half;
      
   ////
   ////

   reg [0:4]   RD_num_cmds;

   always @( * )
     begin
        if (PLB_size[0])
          RD_num_cmds = 5'h0;
        else if (PLB_size == SIXTEEN_WORD)
          RD_num_cmds = 5'h2;
        else
          RD_num_cmds = 5'h1;
     end
   
   cmd_gen CMD_ctrl( .clk( PLB_Clk ),
		     .rst( PLB_Rst ),
		     .start_rd( CTRL_start_rd ),
		     .start_wr( CTRL_start_wr ),
                     .start_burst( PLB_size[0] ),
		     .start_addr( REQ_addr ),
		     .start_num( RD_num_cmds ),
		     .req( CMD_req ),
		     .done( CMD_done ),
                     .DDR_clk( DDR_Clk ),
		     .DDR_rdy( DDR_ready_200 ),
		     .DDR_addr( DDR_addr ),
		     .DDR_rd( DDR_rd ),
		     .DDR_wr( DDR_wr ),
                     .DDR_wr_en( DDR_wr_en ),
                     .DDR_rd_en( DDR_rd_en ),
                     .FIFO_rst( DFIFO_rst ),
		     .CMD_rdy( CMD_rdy ) );
   
   //----------------------------------------------------------------------
   // Bus control state machine
   //----------------------------------------------------------------------

   localparam 	
     Idle                  = 4'h0,
     ReadWaitEmpty         = 4'h1,
     ReadWait              = 4'h2,
     WriteWait             = 4'h3,
     ReadDword             = 4'h4,
     ReadDwordEnd          = 4'h5,
     WriteDword            = 4'h6,
     WriteDwordEnd         = 4'h7,
     ReadBurst             = 4'h8,
     ReadBurstEnd1         = 4'h9,
     ReadBurstEnd2         = 4'ha,
     WriteBurst            = 4'hb,
     WriteBurstEnd1        = 4'hc,
     WriteBurstEnd2        = 4'hd,
     WriteBurstEnd3        = 4'he;
   
   reg [0:3] 	CTRL_ns;
   reg [0:3] 	CTRL_cs;

   always @( posedge PLB_Clk )
     begin	
	if (PLB_Rst)
	  CTRL_cs <= Idle;
	else
	  CTRL_cs <= CTRL_ns;
     end

   assign 	Sl_rearbitrate = (REQ_valid & (CTRL_cs == Idle) & ~CMD_rdy) | (REQ_valid & (CTRL_cs != Idle));

   //----------------------------------------------------------------------

   always @ ( * )
     begin
	// Set default values
	CTRL_wr_en = 1'b0;
	CTRL_rd_en = 1'b0;
	CTRL_done = 1'b0;
	CTRL_STG_en = 1'b0;
	CTRL_P2D_en = 1'b0;
	CTRL_BEAT_en = 1'b0;
	CTRL_start_rd = 1'b0;
	CTRL_start_wr = 1'b0;
        CTRL_clear = 1'b0;

	Sl_addrAck = 1'b0;
	Sl_SSize = 2'b00;
	Sl_rdDAck = 1'b0;
	Sl_rdComp = 1'b0;
	Sl_wrDAck = 1'b0;
	Sl_wrComp = 1'b0;
        Sl_wrBTerm = 1'b0;
        Sl_rdBTerm = 1'b0;

	// Default return to current state
	CTRL_ns = CTRL_cs;

	case (CTRL_cs)

	  //----------------------------------------------------------------------
	  
	  Idle:
	    begin
	       if (REQ_valid & CMD_rdy)
		 begin
		    Sl_addrAck = 1'b1;
		    Sl_SSize = 2'b01;
		    
		    if (PLB_RNW)
		      begin
			 CTRL_start_rd = 1'b1;

                         // If this starts in the 2nd quadword, then wait to pull the empty first
                         if (P2D_dw_cnt_l[0])
                           CTRL_ns = ReadWaitEmpty;
                         else
		           CTRL_ns = ReadWait;
		      end
		    else
		      begin
                         // If this starts in the 2nd quadword, then push the empty data now
                         if (P2D_dw_cnt_l[0])
                           CTRL_wr_en = 1'b1;
                         
			 CTRL_start_wr = 1'b1;
			 if (PLB_size[0]) CTRL_ns = WriteBurst;
			 else             CTRL_ns = WriteDword;
		      end
		 end
	    end

          //----------------------------------------------------------------------

          ReadWaitEmpty:
            begin
               if (~RFIFO_empty_100)
                 begin
                    CTRL_rd_en = 1'b1;
                    CTRL_ns = ReadWait;
                 end
            end
          
	  //----------------------------------------------------------------------	  

	  ReadWait:
	    begin
	       if (~RFIFO_empty_100 & REQ_rd_delay_done)
		 begin
		    CTRL_rd_en = 1'b1;

		    if (REQ_burst)
		      CTRL_ns = ReadBurst;
		    else
		      CTRL_ns = ReadDword;
		 end
	    end

	  //----------------------------------------------------------------------

	  WriteWait:
	    begin
	       if (~WFIFO_full_100)
		 begin
		    CTRL_wr_en = 1'b1;
		    
		    if (REQ_burst)
		      CTRL_ns = WriteBurst;
		    else
		      CTRL_ns = WriteDword;
		 end
	    end

	  //----------------------------------------------------------------------	  
	  
	  ReadDword:
	    begin
	       Sl_rdDAck = 1'b1;
	       CTRL_BEAT_en = 1'b1;
	       CTRL_P2D_en = 1'b1;

	       if (BEAT_done)
		 begin
		    Sl_rdComp = 1'b1;
		    CTRL_done = 1'b1;

		    if (P2D_qw_0)
		      CTRL_ns = ReadDwordEnd;
		    else
		      CTRL_ns = Idle;
		 end
	       else if (P2D_dw_1)
		 begin
		    if (~RFIFO_empty_100)
		      CTRL_rd_en = 1'b1;    // continue onto next chunk
		    else
		      CTRL_ns = ReadWait;   // wait for next chunk
		 end
	    end

	  //----------------------------------------------------------------------

	  ReadDwordEnd:
	    begin
	       if (~RFIFO_empty_100)
		 begin
		    CTRL_rd_en = 1'b1;
		    CTRL_ns = Idle;
		 end
	    end
	  	  
	  //----------------------------------------------------------------------

	  WriteDword:
	    begin
	       Sl_wrDAck = 1'b1;
	       CTRL_BEAT_en = 1'b1;
	       CTRL_P2D_en = 1'b1;
	       CTRL_STG_en = 1'b1;

	       if (BEAT_done)
		 begin
		    Sl_wrComp = 1'b1;
		    CTRL_done = 1'b1;
		    CTRL_wr_en = 1'b1;

		    if (P2D_qw_0)
		      CTRL_ns = WriteDwordEnd;
		    else
		      CTRL_ns = Idle;
		 end
	       else if (P2D_dw_1)
		 begin
		    CTRL_wr_en = 1'b1;
		 end
	    end

	  //----------------------------------------------------------------------
	  
	  WriteDwordEnd:
	    begin
               CTRL_clear = 1'b1;
	       CTRL_wr_en = 1'b1;
	       CTRL_ns = Idle;
	    end

	  //----------------------------------------------------------------------

	  ReadBurst:
	    begin
	       Sl_rdDAck = 1'b1;
	       CTRL_BEAT_en = 1'b1;

               if (TERM_cnt == 4'h1)
                 Sl_rdBTerm = 1'b1;

	       if ((TERM_cnt == 4'h0) || ~PLB_rdBurst)
                 begin
                    Sl_rdComp = 1'b1;                    
                    CTRL_ns = ReadBurstEnd1;
                 end
	       else if ( (REQ_byte & (BEAT_cnt == 3'h7))      ||
			 (REQ_half & (BEAT_cnt[1:2] == 2'h3)) ||
			 (REQ_word & (BEAT_cnt[2] == 1'b1))   ||
			 (REQ_burst & ~REQ_byte & ~REQ_half & ~REQ_word) )
		 begin
		    CTRL_P2D_en = 1'b1;

		    if (P2D_dw_1 & ~RFIFO_empty_100)
		      CTRL_rd_en = 1'b1;             // continue onto next chunk
		    else if (P2D_dw_1 & RFIFO_empty_100)
		      CTRL_ns = ReadWait;            // wait for next chunk
		 end
	    end

	  //----------------------------------------------------------------------

          ReadBurstEnd1:
            begin
//               Sl_rdComp = 1'b1;

               if (~P2D_qw_0)
                 begin
                    CTRL_done = 1'b1;
                    CTRL_ns = Idle;
                 end
               else if (P2D_qw_0 & ~RFIFO_empty_100)
                 begin
                    CTRL_done = 1'b1;
                    CTRL_ns = Idle;
                    CTRL_rd_en = 1'b1;
                 end
               else if (P2D_qw_0 & RFIFO_empty_100)
                 begin
                    CTRL_ns = ReadBurstEnd2;
                 end
            end
          
          //----------------------------------------------------------------------
          
	  ReadBurstEnd2:
	    begin
	       if (~RFIFO_empty_100)
		 begin
		    CTRL_done = 1'b1;
		    CTRL_ns = Idle;
		 end
	    end
	  
	  //----------------------------------------------------------------------

	  WriteBurst:
	    begin
	       Sl_wrDAck = 1'b1;
	       CTRL_BEAT_en = 1'b1;
	       CTRL_STG_en = 1'b1;

               if (TERM_cnt == 4'h1)
                 Sl_wrBTerm = 1'b1;

               if ((TERM_cnt == 4'h0) || ~PLB_wrBurst)
                 begin
                    Sl_wrComp = 1'b1;                    
                    CTRL_ns = WriteBurstEnd1;
                 end
	       else if ( (REQ_byte & (BEAT_cnt == 3'h7)) ||
		         (REQ_half & (BEAT_cnt[1:2] == 2'h3)) ||
		         (REQ_word & (BEAT_cnt[2] == 1'b1))   ||
		         (REQ_burst & ~REQ_byte & ~REQ_half & ~REQ_word) )
		 begin
		    CTRL_P2D_en = 1'b1;
                    
		    if (P2D_dw_1 & ~WFIFO_full_100)
		      CTRL_wr_en = 1'b1;            // continue onto next chunk
		    else if (P2D_dw_1 & WFIFO_full_100)
		      CTRL_ns = WriteWait;          // wait for next chunk
		 end
	    end

	  //----------------------------------------------------------------------
          
	  WriteBurstEnd1:
	    begin
//               Sl_wrComp = 1'b1;

               if (P2D_qw_1 & ~WFIFO_full_100)
                 begin
                    CTRL_wr_en = 1'b1;
                    CTRL_done = 1'b1;
                    CTRL_ns = Idle;
                 end
               else if (P2D_qw_1 & WFIFO_full_100)
                 begin
                    CTRL_ns = WriteBurstEnd3;
                 end
               else if (P2D_qw_0 & ~WFIFO_full_100)
                 begin
                    CTRL_wr_en = 1'b1;
                    CTRL_ns = WriteBurstEnd3;
                 end
               else if (P2D_qw_0 & WFIFO_full_100)
                 begin
                    CTRL_ns = WriteBurstEnd2;
		 end
	    end

	  //----------------------------------------------------------------------
	  
	  WriteBurstEnd2:
	    begin
	       if (~WFIFO_full_100)
		 begin
		    CTRL_wr_en = 1'b1;
                    CTRL_ns = WriteBurstEnd3;
		 end
	    end

	  //----------------------------------------------------------------------
          
          WriteBurstEnd3:
            begin
               if (~WFIFO_full_100)
                 begin
                    CTRL_clear = 1'b1;
                    CTRL_wr_en = 1'b1;
                    CTRL_done = 1'b1;
                    CTRL_ns = Idle;
                 end
            end
	  
	  //----------------------------------------------------------------------

	  default: CTRL_ns = 4'hx;
	endcase
	
     end
   
   //----------------------------------------------------------------------

endmodule
