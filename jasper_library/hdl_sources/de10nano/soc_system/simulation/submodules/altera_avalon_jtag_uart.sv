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


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030

module altera_avalon_jtag_uart #(
  parameter legacySignalAllow = 1,
  parameter writeBufferDepth = 64,
  parameter readBufferDepth = 64,
  parameter writeIRQThreshold = 8,
  parameter readIRQThreshold = 8,
  parameter useRegistersForReadBuffer = 0,
  parameter useRegistersForWriteBuffer = 0,

  parameter printingMethod = 0,
  parameter FIFO_WIDTH = 8,
  parameter WR_WIDTHU = 6,
  parameter RD_WIDTHU = 6,
  parameter write_le = "ON",
  parameter read_le = "ON",
  parameter HEX_WRITE_DEPTH_STR = 64,
  parameter HEX_READ_DEPTH_STR = 64
  ) (

  // inputs:
   av_address,
   av_chipselect,
   av_read_n,
   av_write_n,
   av_writedata,
   clk,
   rst_n,

  // outputs:
   av_irq,
   av_readdata,
   av_waitrequest
  )
  /* synthesis ALTERA_ATTRIBUTE = "SUPPRESS_DA_RULE_INTERNAL=\"R101,C106,D101,D103\"" */ ;

  output           av_irq;
  output  [31: 0]  av_readdata;
  output           av_waitrequest;
  input            av_address;
  input            av_chipselect;
  input            av_read_n;
  input            av_write_n;
  input   [31: 0]  av_writedata;
  input            clk;
  input            rst_n;


reg                       ac;
wire                      activity;
wire                      av_irq;
wire    [31: 0]           av_readdata;
reg                       av_waitrequest;
reg                       fifo_AE;
reg                       fifo_AF;
wire                      fifo_EF;
wire                      fifo_FF;
wire                      fifo_clear;
wire                      fifo_rd;
wire    [FIFO_WIDTH-1: 0] fifo_rdata;
wire    [FIFO_WIDTH-1: 0] fifo_wdata;
reg                       fifo_wr;
reg                       ien_AE;
reg                       ien_AF;
wire                      ipen_AE;
wire                      ipen_AF;
reg                       pause_irq;
wire    [FIFO_WIDTH-1: 0] r_dat;
wire                      r_ena;
reg                       r_val;
wire                      rd_wfifo;
reg                       read_0;
wire    [31: 0]           read_0_true;
wire    [31: 0]           read_0_false;
wire                      rfifo_full;
wire    [RD_WIDTHU-1: 0]  rfifo_used;
reg                       rvalid;
reg                       sim_r_ena;
reg                       sim_t_dat;
reg                       sim_t_ena;
reg                       sim_t_pause;
wire    [FIFO_WIDTH-1: 0] t_dat;
reg                       t_dav;
wire                      t_ena;
wire                      t_pause;
wire                      wfifo_empty;
wire    [WR_WIDTHU-1: 0]  wfifo_used;
reg                       woverflow;
wire                      wr_rfifo;

  assign rd_wfifo = r_ena & ~wfifo_empty;
  assign wr_rfifo = t_ena & ~rfifo_full;
  assign fifo_clear = ~rst_n;
  altera_avalon_jtag_uart_scfifo_w
  #(
      .FIFO_WIDTH       (FIFO_WIDTH),
      .WR_WIDTHU        (WR_WIDTHU),
      .write_le         (write_le),
      .writeBufferDepth (writeBufferDepth),
      .printingMethod   (printingMethod)
   )
  altera_avalon_jtag_uart_scfifo_w
    (
      .clk         (clk),
      .fifo_FF     (fifo_FF),
      .fifo_clear  (fifo_clear),
      .fifo_wdata  (fifo_wdata),
      .fifo_wr     (fifo_wr),
      .r_dat       (r_dat),
      .rd_wfifo    (rd_wfifo),
      .wfifo_empty (wfifo_empty),
      .wfifo_used  (wfifo_used)
    );

  altera_avalon_jtag_uart_scfifo_r
  #(
   .FIFO_WIDTH(FIFO_WIDTH),
   .RD_WIDTHU(RD_WIDTHU),
   .read_le(read_le),
   .readBufferDepth(readBufferDepth),
   .HEX_READ_DEPTH_STR(HEX_READ_DEPTH_STR)
   )
  altera_avalon_jtag_uart_scfifo_r
    (
      .clk        (clk),
      .fifo_EF    (fifo_EF),
      .fifo_clear (fifo_clear),
      .fifo_rd    (fifo_rd),
      .fifo_rdata (fifo_rdata),
      .rfifo_full (rfifo_full),
      .rfifo_used (rfifo_used),
      .rst_n      (rst_n),
      .t_dat      (t_dat),
      .wr_rfifo   (wr_rfifo)
    );

  assign ipen_AE = ien_AE & fifo_AE;
  assign ipen_AF = ien_AF & (pause_irq | fifo_AF);
  assign av_irq = ipen_AE | ipen_AF;
  assign activity = t_pause | t_ena;
  always @(posedge clk or negedge rst_n)
    begin
      if (rst_n == 0)
          pause_irq <= 1'b0;
      else // only if fifo is not empty...
      if (t_pause & ~fifo_EF)
          pause_irq <= 1'b1;
      else if (read_0)
          pause_irq <= 1'b0;
    end


  always @(posedge clk or negedge rst_n)
    begin
      if (rst_n == 0)
        begin
          r_val <= 1'b0;
          t_dav <= 1'b1;
        end
      else 
        begin
          r_val <= r_ena & ~wfifo_empty;
          t_dav <= ~rfifo_full;
        end
    end


  always @(posedge clk or negedge rst_n)
    begin
      if (rst_n == 0)
        begin
          fifo_AE <= 1'b0;
          fifo_AF <= 1'b0;
          fifo_wr <= 1'b0;
          rvalid <= 1'b0;
          read_0 <= 1'b0;
          ien_AE <= 1'b0;
          ien_AF <= 1'b0;
          ac <= 1'b0;
          woverflow <= 1'b0;
          av_waitrequest <= 1'b1;
        end
      else 
        begin
          fifo_AE <= {fifo_FF,wfifo_used} <= writeIRQThreshold;
          fifo_AF <= (HEX_READ_DEPTH_STR - {rfifo_full,rfifo_used}) <= readIRQThreshold;
          fifo_wr <= 1'b0;
          read_0 <= 1'b0;
          av_waitrequest <= ~(av_chipselect & (~av_write_n | ~av_read_n) & av_waitrequest);
          if (activity)
              ac <= 1'b1;
          // write
          if (av_chipselect & ~av_write_n & av_waitrequest)
              // addr 1 is control; addr 0 is data
              if (av_address)
                begin
                  ien_AF <= av_writedata[0];
                  ien_AE <= av_writedata[1];
                  if (av_writedata[10] & ~activity)
                      ac <= 1'b0;
                end
              else 
                begin
                  fifo_wr <= ~fifo_FF;
                  woverflow <= fifo_FF;
                end
          // read
          if (av_chipselect & ~av_read_n & av_waitrequest)
            begin
              // addr 1 is interrupt; addr 0 is data
              if (~av_address)
                  rvalid <= ~fifo_EF;
              read_0 <= ~av_address;
            end
        end
    end


  assign fifo_wdata = av_writedata[FIFO_WIDTH-1 : 0];
  assign fifo_rd = (av_chipselect & ~av_read_n & av_waitrequest & ~av_address) ? ~fifo_EF : 1'b0;

  assign read_0_true = { {(15-RD_WIDTHU){1'b0}},rfifo_full,rfifo_used,rvalid,woverflow,~fifo_FF,~fifo_EF,1'b0,ac,ipen_AE,ipen_AF,fifo_rdata };
  assign read_0_false = { {(15-WR_WIDTHU){1'b0}},(HEX_WRITE_DEPTH_STR - {fifo_FF,wfifo_used}),rvalid,woverflow,~fifo_FF,~fifo_EF,1'b0,ac,ipen_AE,ipen_AF,{6{1'b0}},ien_AE,ien_AF };
  assign av_readdata = read_0 ? read_0_true : read_0_false;



//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  // Tie off Atlantic Interface signals not used for simulation
  always @(posedge clk)
    begin
      sim_t_pause <= 1'b0;
      sim_t_ena <= 1'b0;
      sim_t_dat <= t_dav ? r_dat : {FIFO_WIDTH{r_val}};
      sim_r_ena <= 1'b0;
    end


  assign r_ena = sim_r_ena;
  assign t_ena = sim_t_ena;
  assign t_dat = sim_t_dat;
  assign t_pause = sim_t_pause;


//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on
//synthesis read_comments_as_HDL on
//  alt_jtag_atlantic altera_avalon_jtag_uart_alt_jtag_atlantic
//    (
//      .clk (clk),
//      .r_dat (r_dat),
//      .r_ena (r_ena),
//      .r_val (r_val),
//      .rst_n (rst_n),
//      .t_dat (t_dat),
//      .t_dav (t_dav),
//      .t_ena (t_ena),
//      .t_pause (t_pause)
//    );
//
//  defparam altera_avalon_jtag_uart_alt_jtag_atlantic.INSTANCE_ID = 0,
//           altera_avalon_jtag_uart_alt_jtag_atlantic.LOG2_RXFIFO_DEPTH = WR_WIDTHU,
//           altera_avalon_jtag_uart_alt_jtag_atlantic.LOG2_TXFIFO_DEPTH = RD_WIDTHU,
//           altera_avalon_jtag_uart_alt_jtag_atlantic.SLD_AUTO_INSTANCE_INDEX = "YES";
//
//synthesis read_comments_as_HDL off

endmodule
