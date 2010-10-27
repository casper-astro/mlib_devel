`timescale 1ps / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    14:17:52 07/20/05
// Design Name:    
// Module Name:    cmd_gen
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

module cmd_gen(
	       clk, 
	       rst, 
	       start_rd, 
	       start_wr,
               start_burst,
	       start_addr, 
	       start_num, 
	       req, 
	       done,
               DDR_clk,
	       DDR_rdy, 
	       DDR_addr, 
	       DDR_rd, 
	       DDR_wr,
               DDR_rd_en,
               DDR_wr_en,
               FIFO_rst,
	       CMD_rdy
	       );
   
   //----------------------------------------------------------------------
   // Inputs and outputs
   //----------------------------------------------------------------------
   
   input                  clk;
   input                  rst;
   input 		  start_rd;
   input 		  start_wr;
   input                  start_burst;
   input [0:26] 	  start_addr;
   input [0:4] 		  start_num;
   input 		  req;
   input                  done;
   input                  DDR_clk;
   input 		  DDR_rdy;
   input                  DDR_rd_en;
   input                  DDR_wr_en;

   output [0:26] 	  DDR_addr;
   output 		  DDR_rd;
   output 		  DDR_wr;
   output                 FIFO_rst;
   output 		  CMD_rdy;

   //----------------------------------------------------------------------
   // Combinatorial registers
   //----------------------------------------------------------------------

   reg 			  DDR_rd;
   reg 			  DDR_wr;
   reg 			  CMD_rdy;
   reg                    FIFO_rst;

   //----------------------------------------------------------------------
   // Address generation
   //----------------------------------------------------------------------

   up_count ADDR_cntr( .CLK( clk ),
		       .CNT( DDR_addr ),
		       .LD( (start_rd | start_wr) & CMD_rdy ),
		       .L( start_addr ),
		       .EN( DDR_rd | DDR_wr ),
		       .RST( rst ) );
   defparam ADDR_cntr.width = 27;

   //----------------------------------------------------------------------
   // Toggle bit for DDR response
   //----------------------------------------------------------------------

   wire     DDR_resp_cnt;
   wire     DDR_resp = DDR_resp_cnt & (DDR_rd_en | DDR_wr_en);
   wire     DDR_resp_dly;
   wire #1  DDR_resp_100 = DDR_resp_dly | DDR_resp;

   d_ff DDR_resp_dly_ff( .CLK( DDR_clk ),
                         .D( DDR_resp ),
                         .Q( DDR_resp_dly ),
                         .EN( 1'b1 ),
                         .RST( rst ) );
   defparam DDR_resp_dly_ff.width = 1;
   
   d_ff DDR_resp_cntr( .CLK( DDR_clk ),
                       .D( ~DDR_resp_cnt ),
                       .Q( DDR_resp_cnt ),
                       .EN( DDR_rd_en | DDR_wr_en ),
                       .RST( rst ) );
   defparam DDR_resp_cntr.width = 1;
   
   //----------------------------------------------------------------------
   // Request completion counter
   //----------------------------------------------------------------------

   wire [0:4] COMP_cnt;
   
   ud_count COMP_cntr( .CLK( clk ),
                       .CNT( COMP_cnt ),
                       .LD( 1'b0 ),
                       .L( 5'h0 ),
                       .UP( DDR_rd | DDR_wr ),
                       .DOWN( DDR_resp_100 ),
                       .RST( rst ) );
   defparam COMP_cntr.width = 5;

   //----------------------------------------------------------------------
   // Allocation counter
   //----------------------------------------------------------------------

   wire [0:4] ALLOC_cnt;

   ud_count ALLOC_cntr( .CLK( clk ),
                        .CNT( ALLOC_cnt ),
                        .LD( start_rd ),
                        .L( start_num ),
                        .UP( req ),
                        .DOWN( DDR_rd | DDR_wr ),
                        .RST( rst ) );
   defparam   ALLOC_cntr.width = 5;   

   //----------------------------------------------------------------------
   // Reset counter
   //----------------------------------------------------------------------

   wire [0:1] RST_cnt;
   wire       RST_high_done = (RST_cnt == 2'b01);
   wire       RST_low_done = (RST_cnt == 2'b10);
   reg        RST_cnt_ld;
   reg        RST_cnt_en;
   
   up_count RST_cntr( .CLK( clk ),
                      .CNT( RST_cnt ),
                      .LD( RST_cnt_ld ),
                      .L( 2'h0 ),
                      .EN( RST_cnt_en ),
                      .RST( rst ) );
   defparam   RST_cntr.width = 2;
   
   //----------------------------------------------------------------------
   // Done bit
   //----------------------------------------------------------------------

   wire     CMD_done;
   reg 	    CMD_done_rst;
   
   sr_ff CMD_done_ff( .CLK( clk ),
		      .Q( CMD_done ),
		      .SET( done ),
		      .RST( CMD_done_rst | rst ) );
   defparam CMD_done_ff.width = 1;
   
   //----------------------------------------------------------------------
   // Command generation
   //----------------------------------------------------------------------

   localparam
     Idle           = 4'h0,
     IssueWrite     = 4'h1,
     IssueRead      = 4'h2,
     IssueReadBurst = 4'h3,
     ReadCleanup    = 4'h4,
     ResetCleanup   = 4'h5,
     DoRead         = 4'h6,
     DoReadBurst    = 4'h7,
     DoWrite        = 4'h8;

   reg [0:3] CMD_cs;
   reg [0:3] CMD_ns;

   always @( posedge clk )
     begin	
	if (rst) CMD_cs <= Idle;
	else     CMD_cs <= CMD_ns;
     end

   //----------------------------------------------------------------------

   always @( * )
     begin
	// Set defaults
	DDR_rd = 1'b0;
	DDR_wr = 1'b0;
	CMD_rdy = 1'b0;
	CMD_done_rst = 1'b0;
        FIFO_rst = 1'b0;
        RST_cnt_ld = 1'b0;
        RST_cnt_en = 1'b0;

        // Default to current state
	CMD_ns = CMD_cs;

	case (CMD_cs)
	  
	  //----------------------------------------------------------------------
	  
	  Idle: 
	    begin
	       CMD_rdy = 1'b1;
	       CMD_done_rst = 1'b1;

	       if (start_rd & start_burst)
		 CMD_ns = IssueReadBurst;
               else if (start_rd & ~start_burst)
		 CMD_ns = IssueRead;
	       else if (start_wr)
		 CMD_ns = IssueWrite;
	    end

	  //----------------------------------------------------------------------

	  IssueWrite:
	    begin
	       if (ALLOC_cnt == 5'h0 && CMD_done && COMP_cnt == 5'h0)
		 CMD_ns = Idle;
	       else if (DDR_rdy & |ALLOC_cnt & ~COMP_cnt[0])
                 CMD_ns = DoWrite;
	    end

	  //----------------------------------------------------------------------

          DoWrite:
            begin
               if (DDR_rdy)
                 begin
                    DDR_wr = 1'b1;
                    CMD_ns = IssueWrite;
                 end
            end
          
          //----------------------------------------------------------------------

          IssueReadBurst:
            begin
               if (CMD_done)
                 begin
                    RST_cnt_ld = 1'b1;
                    CMD_ns = ReadCleanup;
                 end
               else if (DDR_rdy & ~CMD_done & ~COMP_cnt[0])
                 CMD_ns = DoReadBurst;
            end
          
          //----------------------------------------------------------------------

          DoReadBurst:
            begin
               if (DDR_rdy)
                 begin
                    DDR_rd = 1'b1;
                    CMD_ns = IssueReadBurst;
                 end
            end
          
          //----------------------------------------------------------------------
	  
	  IssueRead:
	    begin
               if (ALLOC_cnt == 5'h0 && CMD_done && COMP_cnt == 5'h0)
                 CMD_ns = Idle;
	       else if (DDR_rdy & ~CMD_done & |ALLOC_cnt & ~COMP_cnt[0])
                 CMD_ns = DoRead;
	    end
	  
	  //----------------------------------------------------------------------

          DoRead:
            begin
               if (DDR_rdy)
                 begin
                    DDR_rd = 1'b1;
                    CMD_ns = IssueRead;
                 end
            end
          
	  //----------------------------------------------------------------------          

          ReadCleanup:
            begin
               FIFO_rst = 1'b1;

               if (~RST_high_done)
                 RST_cnt_en = 1'b1;
               
               if (COMP_cnt == 5'h0 && RST_high_done)
                 begin
                    RST_cnt_ld = 1'b1;
                    CMD_ns = ResetCleanup;
                 end
            end
          
          //----------------------------------------------------------------------

          ResetCleanup:
            begin
               RST_cnt_en = 1'b1;

               if (RST_low_done)
                 CMD_ns = Idle;
            end
          
          //----------------------------------------------------------------------
          
	endcase
     end
   
   //----------------------------------------------------------------------

endmodule
