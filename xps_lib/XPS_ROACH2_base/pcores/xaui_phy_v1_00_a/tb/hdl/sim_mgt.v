module sim_mgt(
    clk, reset,
    mgt_txdata, mgt_txcharisk,
    mgt_rxdata, mgt_rxcharisk,
    mgt_codevalid, mgt_codecomma,
    mgt_enable_align, mgt_enchansync,
    mgt_rxlock, mgt_tx_reset, mgt_rx_reset
  );
  input  clk, reset;
  input  [63:0] mgt_txdata;
  input   [7:0] mgt_txcharisk;
  output [63:0] mgt_rxdata;
  output  [7:0] mgt_rxcharisk;
  output  [7:0] mgt_codevalid;
  output  [7:0] mgt_codecomma;
  input   [3:0] mgt_enable_align;
  input  mgt_enchansync;
  output  [3:0] mgt_rxlock;
  output  [3:0] mgt_tx_reset;
  output  [3:0] mgt_rx_reset;

  /*********** Reset Logic *************/
  reg [3:0] lock_counter;
  reg [2:0] internal_reset_counter;

  assign mgt_rxlock = {4{lock_counter == 4'b0}};
  assign mgt_rx_reset = {4{internal_reset_counter != 4'b0}};
  assign mgt_tx_reset = mgt_rx_reset;

  always @(posedge clk) begin
    if (reset) begin
      lock_counter <= 4'b1111;
      internal_reset_counter <= 3'b111;
    end else begin
      if (internal_reset_counter) begin
        internal_reset_counter <= internal_reset_counter - 3'b1;
      end else if (lock_counter) begin
        lock_counter <= lock_counter - 4'b1;
      end
    end
  end

  /*********** Simulate Misalignment **************/
  reg [63:0] rxdata_aligned;
  reg  [7:0] rxisk_aligned;

  reg  [3:0] send_unaligned;

  reg  [7:0] codecomma_unaligned;
  reg  [7:0] codevalid_unaligned;

  always @(posedge clk) begin
    if (reset | mgt_rx_reset[0]) begin
      rxdata_aligned <= 64'b0;
      rxisk_aligned <= 8'b0;
      send_unaligned <= 4'b1111;
      codecomma_unaligned <= 8'b0;
      codevalid_unaligned <= 8'b0;
    end else begin
      rxisk_aligned <= mgt_txcharisk;

      rxdata_aligned <= {send_unaligned[3] ? {mgt_txdata[48] , mgt_txdata[63:57]} : mgt_txdata[63:48] ,
                         send_unaligned[2] ? {mgt_txdata[32] , mgt_txdata[47:33]} : mgt_txdata[47:32] ,
                         send_unaligned[1] ? {mgt_txdata[16] , mgt_txdata[31:17]} : mgt_txdata[31:16] ,
                         send_unaligned[0] ? {mgt_txdata[0]  , mgt_txdata[15:1] } : mgt_txdata[15:0]};

      codevalid_unaligned  <= {2'b11 ,
                               2'b11 ,
                               2'b11 ,
                               2'b11 };
      codecomma_unaligned <= {send_unaligned[3] ? 2'b00 : {mgt_txdata[63:56] == 8'hbc, mgt_txdata[55:48] == 8'hbc},
                              send_unaligned[2] ? 2'b00 : {mgt_txdata[47:40] == 8'hbc, mgt_txdata[39:32] == 8'hbc},
                              send_unaligned[1] ? 2'b00 : {mgt_txdata[31:24] == 8'hbc, mgt_txdata[23:16] == 8'hbc},
                              send_unaligned[0] ? 2'b00 : {mgt_txdata[15:8]  == 8'hbc, mgt_txdata[7:0] == 8'hbc} };

      send_unaligned <= {mgt_enable_align[3] ? 1'b0 : send_unaligned[3] ,
                         mgt_enable_align[2] ? 1'b0 : send_unaligned[2] ,
                         mgt_enable_align[1] ? 1'b0 : send_unaligned[1] ,
                         mgt_enable_align[0] ? 1'b0 : send_unaligned[0]};


    end
  end

  reg [63:0] mgt_rxdata;
  reg  [7:0] mgt_rxcharisk;
  reg  [7:0] mgt_codecomma;
  reg  [7:0] mgt_codevalid;

  always @(posedge clk) begin
    if (reset | mgt_rx_reset[0]) begin
      mgt_rxdata <= rxdata_aligned;
      mgt_rxcharisk <= rxisk_aligned;
      mgt_codevalid <= codevalid_unaligned;
      mgt_codecomma <= codecomma_unaligned;
    end else begin
      mgt_rxcharisk <= rxisk_aligned;
      mgt_rxdata <= rxdata_aligned;
      mgt_codevalid <= codevalid_unaligned;
      mgt_codecomma <= codecomma_unaligned;
    end
  end

endmodule
