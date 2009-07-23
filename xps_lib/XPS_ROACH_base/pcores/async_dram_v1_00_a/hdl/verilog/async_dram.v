`timescale 1ns / 1ps

module async_dram #(
    //Use bram to make nice deep fifos which are needed for certain
    //applications.
    //Default is shallow, distributed RAM fifos
    parameter BRAM_FIFOS    = 0,
    parameter TAG_BUFFER_EN = 0,
    parameter C_WIDE_DATA   = 0,
    parameter C_HALF_BURST  = 0
  )  (
    // -- Mem cmd ports ---------------
    Mem_Clk,
    Mem_Rst,
    Mem_Cmd_Address,
    Mem_Cmd_RNW,
    Mem_Cmd_Valid,
    Mem_Cmd_Ack,
    Mem_Cmd_Tag,
    Mem_Rd_Dout,
    Mem_Rd_Ack,
    Mem_Rd_Valid,
    Mem_Rd_Tag,
    Mem_Wr_Din,
    Mem_Wr_BE,

    // -- DDR2 ports ---------------
    dram_clk,
    dram_reset,
    dram_data_o,
    dram_byte_enable,
    dram_data_i,
    dram_data_valid,
    dram_address,
    dram_rnw,
    dram_cmd_en,
    dram_ready
  );

  // -- dram ports -----------------
  input              dram_clk;
  output             dram_reset;

  output [144 - 1:0] dram_data_o;
  output [ 18 - 1:0] dram_byte_enable;
  input  [144 - 1:0] dram_data_i;
  input              dram_data_valid;
  output  [32 - 1:0] dram_address;
  output             dram_rnw;
  output             dram_cmd_en;
  input              dram_ready;

  // -- Mem cmd ports -----------------
  input              Mem_Clk;
  input              Mem_Rst;
  input   [32 - 1:0] Mem_Cmd_Address;
  input              Mem_Cmd_RNW;
  input              Mem_Cmd_Valid;
  input   [32 - 1:0] Mem_Cmd_Tag;
  output             Mem_Cmd_Ack;
  output [144 - 1:0] Mem_Rd_Dout;
  input              Mem_Rd_Ack;
  output             Mem_Rd_Valid;
  output  [32 - 1:0] Mem_Rd_Tag;

  input  [144 - 1:0] Mem_Wr_Din;
  input  [ 18 - 1:0] Mem_Wr_BE;

  //synthesis attribute MAX_FANOUT of Mem_Rd_Ack is 20
  //synthesis attribute MAX_FANOUT of Mem_Cmd_Ack is 20

  //reset extend
  reg [3:0] dram_reset_extend;
  always @(posedge Mem_Clk) begin
    if (Mem_Rst) begin
      dram_reset_extend[0] <= 1'b1;
    end else begin
      dram_reset_extend <= {dram_reset_extend, 1'b0};
    end
  end

  reg dram_reset_reg;
  reg dram_reset;
  always @(posedge dram_clk) begin
    dram_reset_reg <= |dram_reset_extend;
    dram_reset     <= dram_reset_reg;
  end

  // Tags Not implemented
  assign Mem_Rd_Tag = Mem_Cmd_Tag;

  //----------------------------------------------------------------------------
  // fifo storage 
  //----------------------------------------------------------------------------

  //data and byte enable fifo
  wire [144 + 18 - 1:0] dat_fifo_input;
  wire [144 + 18 - 1:0] dat_fifo_output;
  wire                  dat_fifo_we, dat_fifo_re, dat_fifo_almost_full, dat_fifo_empty;
  wire                  dat_fifo_overflow, dat_fifo_underflow;
  
  //operation and address fifo
  wire   [32 + 1 - 1:0] txn_fifo_input;
  wire   [32 + 1 - 1:0] txn_fifo_output;
  wire                  txn_fifo_we, txn_fifo_re, txn_fifo_almost_full, txn_fifo_empty;
  wire                  txn_fifo_overflow, txn_fifo_underflow;

  //read data fifo
  wire      [144 - 1:0] rd_data_fifo_input; 
  wire      [144 - 1:0] rd_data_fifo_output;
  wire                  rd_data_fifo_we, rd_data_fifo_re, rd_data_fifo_empty, rd_data_fifo_full, rd_data_fifo_almost_full;
  wire                  rd_data_fifo_overflow, rd_data_fifo_underflow;

  /****************** Dram assignments *********************/
  assign dram_data_o      = dat_fifo_output[144 - 1:0];
  assign dram_byte_enable = dat_fifo_output[144 + 18 - 1:144];
  assign dram_address     = txn_fifo_output[31:0];
  assign dram_rnw         = txn_fifo_output[32];

  /********** Transaction and Write Fifo Control ************/
  reg  [144 + 18 - 1:0] dat_fifo_input_reg;
  reg                   dat_fifo_we_reg;
  reg        [33 - 1:0] txn_fifo_input_reg;
  reg                   txn_fifo_we_reg;
  wire [144 + 18 - 1:0] dat_fifo_input_int;
  wire                  dat_fifo_we_int;
  wire       [33 - 1:0] txn_fifo_input_int;
  wire                  txn_fifo_we_int;

  assign Mem_Cmd_Ack = !(dat_fifo_almost_full || txn_fifo_almost_full);

  /**** Write controls ****/
  /* Data Fifo Write Controls */
  assign dat_fifo_input = dat_fifo_input_reg;
  assign dat_fifo_we    = dat_fifo_we_reg;

  /* Transaction Fifo Write Controls */
  reg second_df_write;
  always @(posedge Mem_Clk) begin
    if (Mem_Rst) begin
      second_df_write <= 1'b0;
    end else begin
      if (dat_fifo_we_int && !second_df_write) begin
        second_df_write <= 1'b1;
      end
      if (dat_fifo_we_int && second_df_write) begin
        second_df_write <= 1'b0;
      end
    end
  end

  assign txn_fifo_input = txn_fifo_input_reg;
  assign txn_fifo_we    = txn_fifo_we_reg;

  assign dat_fifo_input_int = {Mem_Wr_BE, Mem_Wr_Din};
  assign dat_fifo_we_int    = Mem_Cmd_Ack && Mem_Cmd_Valid && (!Mem_Cmd_RNW);
  assign txn_fifo_input_int = {Mem_Cmd_RNW, Mem_Cmd_Address};
  assign txn_fifo_we_int    = Mem_Cmd_Ack && Mem_Cmd_Valid && (Mem_Cmd_RNW || second_df_write);


  /* Register to ease timing */
  always @(posedge Mem_Clk) begin
    dat_fifo_input_reg <= dat_fifo_input_int;
    dat_fifo_we_reg    <= dat_fifo_we_int;
    txn_fifo_input_reg <= txn_fifo_input_int;
    txn_fifo_we_reg    <= txn_fifo_we_int;
  end

  assign dram_data_o      = dat_fifo_output[144 - 1:0];
  assign dram_byte_enable = dat_fifo_output[144 + 18 - 1:144];
  assign dram_address     = txn_fifo_output[31:0];
  assign dram_rnw         = txn_fifo_output[32];

  /**** Transaction Fifo Read controls ****/

  reg second_cycle;
  /* Data Fifo Read Controls */
  always @(posedge dram_clk) begin
    second_cycle <= 1'b0;
    if (dram_reset) begin
    end else begin
      if (!second_cycle && dram_ready && (!txn_fifo_empty)) begin
        second_cycle <= 1'b1;
      end
    end
  end

  /* Transaction Fifo Read Controls */

  reg cycle_wait;
  /* Data Fifo Read Controls */
  wire txn_ready = (!txn_fifo_empty) && dram_ready;
  always @(posedge dram_clk) begin
    cycle_wait <= 1'b1;
    if (dram_reset) begin
    end else begin
      if (cycle_wait && txn_ready) begin
        cycle_wait <= 1'b0;
      end
    end
  end

  assign dat_fifo_re = ((!txn_fifo_empty) && dram_ready || !cycle_wait) && (!dram_rnw);
  /* Transaction Fifo Read Controls */
  assign txn_fifo_re = !cycle_wait;
  assign dram_cmd_en = cycle_wait && txn_ready; 


  /******************** Read Data Fifo ******************/

  reg [144 - 1:0] rd_data_fifo_input_reg;
  reg             rd_data_fifo_we_reg;

  always @(posedge dram_clk) begin
    rd_data_fifo_input_reg <= dram_data_i;
    rd_data_fifo_we_reg    <= dram_data_valid;
  end

  assign rd_data_fifo_input = rd_data_fifo_input_reg;
  assign rd_data_fifo_we    = rd_data_fifo_we_reg;
  assign rd_data_fifo_re    = Mem_Rd_Ack;
  //assign rd_data_fifo_re    = Mem_Rd_Valid && Mem_Rd_Ack;
  assign Mem_Rd_Dout        = rd_data_fifo_output;
  assign Mem_Rd_Valid       = !rd_data_fifo_empty;

generate if (BRAM_FIFOS == 0) begin : shallow_fifos
  //making FIFOS from distributed memory
  rd_fifo_dist rd_data_fifo0(
    .din       (rd_data_fifo_input),
    .rd_clk    (Mem_Clk),
    .rd_en     (rd_data_fifo_re),
    .rst       (dram_reset),
    .wr_clk    (dram_clk),
    .wr_en     (rd_data_fifo_we),
    .dout      (rd_data_fifo_output),
    .empty     (rd_data_fifo_empty),
    .full      (rd_data_fifo_full),
    .prog_full (rd_data_fifo_almost_full),
    .overflow  (rd_data_fifo_overflow),
    .underflow (rd_data_fifo_underflow)
  );

end else begin : deep_fifos

  rd_fifo_bram rd_data_fifo0(
    .din       (rd_data_fifo_input),
    .rd_clk    (Mem_Clk),
    .rd_en     (rd_data_fifo_re),
    .rst       (dram_reset),
    .wr_clk    (dram_clk),
    .wr_en     (rd_data_fifo_we),
    .dout      (rd_data_fifo_output),
    .empty     (rd_data_fifo_empty),
    .full      (rd_data_fifo_full),
    .prog_full (rd_data_fifo_almost_full),
    .overflow  (rd_data_fifo_overflow),
    .underflow (rd_data_fifo_underflow)
  );
end endgenerate

  //making FIFOS from distributed memory
  data_fifo_dist dat_fifo(
    .din       (dat_fifo_input),
    .rd_clk    (dram_clk),
    .rd_en     (dat_fifo_re),
    .rst       (dram_reset),
    .wr_clk    (Mem_Clk),
    .wr_en     (dat_fifo_we),
    .dout      (dat_fifo_output),
    .empty     (dat_fifo_empty),
    .full      (),
    .prog_full (dat_fifo_almost_full),
    .overflow  (dat_fifo_overflow),
    .underflow (dat_fifo_underflow)
  );
  
  transaction_fifo_dist txn_fifo(
    .din       (txn_fifo_input),
    .rd_clk    (dram_clk),
    .rd_en     (txn_fifo_re),
    .rst       (dram_reset),
    .wr_clk    (Mem_Clk),
    .wr_en     (txn_fifo_we),
    .dout      (txn_fifo_output),
    .empty     (txn_fifo_empty),
    .full      (),
    .prog_full (txn_fifo_almost_full),
    .overflow  (txn_fifo_overflow),
    .underflow (txn_fifo_underflow)
  );
        
endmodule
