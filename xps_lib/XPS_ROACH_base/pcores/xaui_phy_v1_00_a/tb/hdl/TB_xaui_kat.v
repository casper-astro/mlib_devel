`define CLK_PERIOD 10
`define SIM_LENGTH 100000

module TB_xaui_kat();
  reg  reset;
  wire clk;

  wire [63:0] xgmii_txd;
  wire  [7:0] xgmii_txc;
  wire [63:0] xgmii_rxd;
  wire  [7:0] xgmii_rxc;

  wire [63:0] mgt_txdata;
  wire  [7:0] mgt_txcharisk;

  wire [63:0] mgt_rxdata;
  wire  [7:0] mgt_rxcharisk;
  wire  [7:0] mgt_codevalid;
  wire  [7:0] mgt_codecomma;
  wire  [3:0] mgt_enable_align;
  wire mgt_enchansync;
  wire  [3:0] mgt_rxlock;

  wire  [3:0] mgt_rx_reset;
  wire  [3:0] mgt_tx_reset;

  wire  [3:0] sync_status;
  wire  align_status;

  xaui_kat xaui_kat0(
    .reset(reset),
    .usrclk(clk),
    .xgmii_txd(xgmii_txd), .xgmii_txc(xgmii_txc),
    .xgmii_rxd(xgmii_rxd), .xgmii_rxc(xgmii_rxc),
    .mgt_txdata(mgt_txdata), .mgt_txcharisk(mgt_txcharisk),
    .mgt_rxdata(mgt_rxdata), .mgt_rxcharisk(mgt_rxcharisk),
    .mgt_codevalid(mgt_codevalid), .mgt_codecomma(mgt_codecomma),
    .mgt_enable_align(mgt_enable_align), .mgt_enchansync(mgt_enchansync),
    .mgt_syncok(4'b1111), .mgt_loopback(), .mgt_powerdown(),
    .mgt_rxlock(mgt_rxlock),
    .configuration_vector(7'b0),
    .status_vector(),
    .align_status(align_status), .sync_status(sync_status),
    .mgt_tx_reset(mgt_tx_reset), .mgt_rx_reset(mgt_rx_reset),
    .signal_detect(4'b1111)
  );

  sim_mgt sim_mgt0(
    .clk(clk), .reset(reset),
    .mgt_txdata(mgt_txdata), .mgt_txcharisk(mgt_txcharisk),
    .mgt_rxdata(mgt_rxdata), .mgt_rxcharisk(mgt_rxcharisk),
    .mgt_codevalid(mgt_codevalid), .mgt_codecomma(mgt_codecomma),
    .mgt_enable_align(mgt_enable_align), .mgt_enchansync(mgt_enchansync),
    .mgt_rxlock(mgt_rxlock), .mgt_tx_reset(mgt_tx_reset), .mgt_rx_reset(mgt_rx_reset)
  );

  reg [31:0] clk_counter;

  initial begin
    reset<=1'b1;
    clk_counter<=32'b0;
`ifdef DEBUG
    $display("sim: reset asserted");
`endif
    #50
    reset<=1'b0;
`ifdef DEBUG
    $display("sim: reset deasserted");
`endif
    #`SIM_LENGTH
    $display("PASSED");
    $finish;
  end

  assign clk=clk_counter < ((`CLK_PERIOD) / 2);

  always begin
    #1 clk_counter <= (clk_counter == `CLK_PERIOD - 1 ? 32'b0 : clk_counter + 1);
  end

  reg [4:0] idle_counter;
  reg [4:0] data_counter;

  reg [63:0] foo_counter;

  always @(posedge clk) begin
    if (reset) begin
      idle_counter <= 5'b11111;
      data_counter <= 5'b11111;
      foo_counter <= 64'b0;
    end else begin
      foo_counter <= foo_counter + 1;
      if (idle_counter) begin
        idle_counter <= idle_counter - 1;
      end else if (data_counter) begin
        data_counter <= data_counter - 1;
      end else begin
        data_counter <= 5'b11111;
        idle_counter <= 5'b11111;
      end
    end
  end

  assign xgmii_txd = idle_counter ? {8{8'h07}} :
                     data_counter == 5'b11111 ? {56'h01020304050607, 8'hfb} :
                     data_counter == 5'b00000 ? {{6{8'h07}}, 8'hfd, 8'h90} :
                     foo_counter;

  assign xgmii_txc = idle_counter ? 8'b1111_1111 :
                     data_counter == 5'b11111 ? 8'b0000_0001 :
                     data_counter == 5'b00000 ? 8'b1111_1110 :
                     8'b0000_0000;
  
  reg [3:0] prev_sync;
  reg prev_align;
  always @(posedge clk) begin
    if (reset) begin
      prev_sync <= 4'b0000;
      prev_align <= 1'b0;
    end else begin
      prev_sync <= sync_status;
      prev_align <= align_status;
      if (prev_sync != sync_status) begin
`ifdef DEBUG
        $display("sync: sync_event - %b", sync_status);
`endif
      end
      if (prev_align != align_status) begin
`ifdef DEBUG
        $display("align: align_event - %b", align_status);
`endif
      end
    end
  end

  reg idle;
  reg first;
  reg aligned;
  reg wait_aligned;

  reg [63:0] prev_data;
  reg [31:0] data_misaligned;

  always @(posedge clk) begin
    if (reset || !align_status) begin
      idle  <= 1'b1;
      first <= 1'b1;
    end else begin
      if (idle) begin
        first <= 1'b1;
        if (xgmii_rxd[7:0] == 8'hfb && xgmii_rxc[0]) begin
          aligned <= 1'b1;
          idle <= 1'b0;
        end
        if (xgmii_rxd[39:32] == 8'hfb && xgmii_rxc[4]) begin
          aligned <= 1'b0;
          idle <= 1'b0;
          wait_aligned <= 1'b1;
        end
      end else begin
        wait_aligned <= 1'b0;

        if (aligned || (!aligned && !wait_aligned)) begin
          first <= 1'b0;
        end
        if (aligned) begin
          prev_data <= xgmii_rxd;
        end else begin
          if (!wait_aligned) begin
            prev_data <= {xgmii_rxd[31:0], data_misaligned};
          end
        end

        data_misaligned <= xgmii_rxd[63:31];

        if (xgmii_rxd[63:56] == 8'hfd && xgmii_rxc[7] || xgmii_rxd[55:48] == 8'hfd && xgmii_rxc[6] || 
            xgmii_rxd[47:40] == 8'hfd && xgmii_rxc[5] || xgmii_rxd[39:32] == 8'hfd && xgmii_rxc[4] || 
            xgmii_rxd[31:24] == 8'hfd && xgmii_rxc[3] || xgmii_rxd[23:16] == 8'hfd && xgmii_rxc[2] || 
            xgmii_rxd[15:8 ] == 8'hfd && xgmii_rxc[1] || xgmii_rxd[7 :0 ] == 8'hfd && xgmii_rxc[0]) begin
            /* long if */

          idle <= 1'b1;
        end else begin
          if (!first) begin
            if (aligned) begin
              if (xgmii_rxd !== prev_data + 1) begin
                $display("FAILED: aligned - got %x, expected %x", xgmii_rxd, prev_data + 1);
                $finish;
              end
            end else begin
              if ({xgmii_rxd[31:0], data_misaligned} !== prev_data + 1) begin
                $display("FAILED: aligned - got %x, expected %x", {xgmii_rxd[31:0], data_misaligned}, prev_data + 1);
                $finish;
              end
            end
          end
        end
      end
`ifdef DESPERATE_DEBUG
      $display("tx:     d - %x, c - %b", xgmii_txd, xgmii_txc);
      $display("rx:     d - %x, c - %b", xgmii_rxd, xgmii_rxc);
`endif
    end
  end

endmodule
