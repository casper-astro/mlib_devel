`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    14:17:52 07/20/05
// Design Name:    
// Module Name:    cmd_gen_tb
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

module cmd_gen_tb();

   //----------------------------------------------------------------------
   // Test inputs/outputs
   //----------------------------------------------------------------------

   wire 	  DDR_wr_en;
   wire 	  DDR_rd_en;
   wire [0:127]   DDR_dout;
   wire 	  DDR_ready;
   wire [0:27] 	  DDR_addr;
   wire 	  DDR_wr;
   wire 	  DDR_rd;

   reg [0:127] 	  DDR_din;
   reg [0:15] 	  DDR_be;

   //----------------------------------------------------------------------
   // System testing clock
   //----------------------------------------------------------------------

   reg 		CLK = 1'b0;

   always
     begin
	#10 CLK = ~CLK;
     end
   
   //----------------------------------------------------------------------
   // Create test vectors for CUT
   //----------------------------------------------------------------------

   reg SYS_plbReset;
   
   assign DDR_clk = CLK;

   initial
     begin
	SYS_plbReset = 1'b1;
	@(negedge CLK);
	SYS_plbReset = 1'b0;
     end // initial begin

   always @(posedge CLK)
     begin
//     	$display("rd:%b wr:%b -- dout:%h ready:%b wr_en:%b rd_en:%b",
//		 DDR_rd, DDR_wr, DDR_dout, DDR_ready, DDR_wr_en, DDR_rd_en);
     end

   ////
   // Generate commands
   ////

   reg [0:127] CMD_data[0:511];
   reg [0:8]   CMD_data_head;
   reg [0:8]   CMD_data_tail;   
   
   reg [0:31] CMD_addrs[0:511];
   reg [0:31] CMD_addr;
   reg [0:8]  CMD_addr_head;
   reg [0:8]  CMD_addr_tail;

   initial
     begin
	CMD_addr_head = 9'h0;
	CMD_addr_tail = 9'h0;
	CMD_data_head = 9'h0;
	CMD_data_tail = 9'h0;
     end

   reg [0:1] CMD_cs;
   reg [0:1] CMD_ns;

   localparam
     CMD_Idle     = 2'h0,
     CMD_GenRead  = 2'h1,
     CMD_GenWrite = 2'h2;

   reg 	     start_rd;
   reg 	     start_wr;
   
   reg [0:7] CMD_num_reads;
   reg [0:7] CMD_num_writes;

   always @(posedge CLK)
     begin
	if (SYS_plbReset) CMD_cs <= CMD_Idle;
	else              CMD_cs <= CMD_ns;
     end
   
   always @(negedge CLK)
     begin
	start_rd = 1'b0;
	start_wr = 1'b0;
	
	CMD_ns = CMD_cs;
	
	case (CMD_cs)
	  CMD_Idle:
	    begin
	       CMD_addr = 32'h0;
	       CMD_num_reads = $random;
	       CMD_num_writes = 1'b1;
	       
	       CMD_ns = CMD_GenWrite;
	    end

	  CMD_GenRead:
	    begin
	       if (DDR_ready)
		 begin
		    start_rd = 1'b1;
		    CMD_ns = CMD_GenWrite;
		 end
	    end

	  CMD_GenWrite:
	    begin
	       if (CMD_num_writes == 0)
		 CMD_ns = CMD_Idle;
	       else if (DDR_ready)
		 begin
		    CMD_addr = $random;
		    CMD_addrs[CMD_addr_head] = CMD_addr;
		    CMD_addr_head = CMD_addr_head + 1'b1;

		    CMD_data[CMD_data_head] = $random;
		    CMD_data_head = CMD_data_head + 1'b1;
		    CMD_data[CMD_data_head] = $random;
		    CMD_data_head = CMD_data_head + 1'b1;

		    start_wr = 1'b1;
		    CMD_num_writes = CMD_num_writes - 1'b1;

		    CMD_ns = CMD_GenRead;
		 end
	    end
	endcase
     end

   ////
   // Check responses
   ////

   reg read_state;
   reg write_state;

   initial
     begin
	read_state = 1'b0;
	write_state = 1'b0;
     end

   always @( negedge DDR_clk )
     begin
	if (DDR_rd_en)
	  begin
	     DDR_be = 16'hffff;
	     
	     if (~read_state)
	       DDR_din = CMD_data[CMD_data_tail];
	     else
	       DDR_din = CMD_data[CMD_data_tail + 1'b1];
	     
	     read_state = ~read_state;
	  end
     end

   always @( posedge DDR_clk )
     begin
	if (DDR_wr_en)
	  begin
	     if (~write_state)
	       begin
		  if (DDR_dout != CMD_data[CMD_data_tail]) 
		    $display("ERROR: DDR_dout:%h -- CMD_data:%h\n",
			     DDR_dout, CMD_data[CMD_data_tail]);
		  else
		    $display("Match: DDR_dout:%h -- CMD_data:%h\n",
			     DDR_dout, CMD_data[CMD_data_tail]);
	       end
	     else
	       begin
		  if (DDR_dout != CMD_data[CMD_data_tail + 1'b1])
		    $display("ERROR (2): DDR_dout:%h -- CMD_data:%h\n",
			     DDR_dout, CMD_data[CMD_data_tail + 1'b1]);
		  else
		    $display("Match (2): DDR_dout:%h -- CMD_data:%h\n",
			     DDR_dout, CMD_data[CMD_data_tail + 1'b1]);
		  
		  CMD_data_tail = CMD_data_tail + 1'b1;
		  CMD_data_tail = CMD_data_tail + 1'b1;
	       end
	     
	     write_state = ~write_state;
	  end
     end 
   
   //----------------------------------------------------------------------
   // CUT - cmd_gen
   //----------------------------------------------------------------------

   cmd_gen CMD_gen( .clk( DDR_clk ),
		    .rst( SYS_plbReset ),
		    .num_cmds( CMD_num_writes ),
		    .start_rd( start_rd ),
		    .start_wr( start_wr ),
		    .start_addr( CMD_addr[0:27] ),
		    .DDR_rdy( DDR_ready ),
		    .DDR_addr( DDR_addr ),
		    .DDR_rd( DDR_rd ),
		    .DDR_wr( DDR_wr ) );
   
   //----------------------------------------------------------------------
   // CUT - ddr2_phys
   //----------------------------------------------------------------------

   ddr2_phys phys( .Reset( SYS_plbReset ),
		   .DDR_clk( DDR_clk ),
		   .DDR_addr( DDR_addr ),
		   .DDR_din( DDR_din ),
		   .DDR_be( DDR_be ),
		   .DDR_wr( DDR_wr ),
		   .DDR_rd( DDR_rd ),
		   .DDR_wr_en( DDR_wr_en ),
		   .DDR_rd_en( DDR_rd_en ),
		   .DDR_dout( DDR_dout ),
		   .DDR_ready( DDR_ready ) );

   //----------------------------------------------------------------------
   
endmodule