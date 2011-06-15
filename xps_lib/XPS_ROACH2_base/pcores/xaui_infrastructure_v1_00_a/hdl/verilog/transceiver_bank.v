module transceiver_bank(
    //mgt resets and clocks
    reset, rx_reset, tx_reset,
    refclk, refclk_ret,
    mgt_clk, mgt_clk_mult_2,
    //mgt rx/tx
    txp, txn,
    rxp, rxn,
    //xaui TX/RX ports
    rxdata,
    rxcharisk,
    txdata,
    txcharisk,
    code_comma,
    //xaui align/sync control
    enchansync,
    enable_align,
    //xaui misc control bits
    loopback, powerdown,
    //xaui status bits
    rxlock,
    syncok,
    codevalid,
    rxbufferr,
    //testing ports
    rxeqmix, rxeqpole,
    txpreemphasis, txdiffctrl
  );
  parameter TX_POLARITY_HACK = 4'd0;
  parameter RX_POLARITY_HACK = 4'd0;
  parameter DIFF_BOOST = "TRUE";

  input  reset, rx_reset, tx_reset;
  input  refclk, mgt_clk, mgt_clk_mult_2;
  output refclk_ret;
  output  [3:0] txp;
  output  [3:0] txn;
  input   [3:0] rxp;
  input   [3:0] rxn;
  output [63:0] rxdata;
  output  [7:0] rxcharisk;
  output  [7:0] code_comma;
  input  [63:0] txdata;
  input   [7:0] txcharisk;
  input   [3:0] enable_align;
  input  enchansync;
  input  loopback, powerdown;
  output  [3:0] rxlock;
  output  [3:0] syncok;
  output  [7:0] codevalid;
  output  [3:0] rxbufferr;
  input   [1:0] rxeqmix;
  input   [3:0] rxeqpole;
  input   [2:0] txpreemphasis;
  input   [2:0] txdiffctrl;

  wire [2:0] chbond_1_hop;

  transceiver #(
    .TX_POLARITY_HACK_0(TX_POLARITY_HACK[0]),
    .TX_POLARITY_HACK_1(TX_POLARITY_HACK[1]),
    .RX_POLARITY_HACK_0(RX_POLARITY_HACK[0]),
    .RX_POLARITY_HACK_1(RX_POLARITY_HACK[1]),
    .CHAN_BOND_LEVEL_1(0),
    .CHAN_BOND_LEVEL_0(1),
    .CHAN_BOND_MODE_1("SLAVE"),
    .CHAN_BOND_MODE_0("MASTER"),
    .DIFF_BOOST(DIFF_BOOST)
  ) transceiver_0 (
    .reset(reset), .rx_reset(rx_reset), .tx_reset(tx_reset),
    .refclk(refclk), .refclk_ret(refclk_ret),
    .mgt_clk(mgt_clk), .mgt_clk_mult_2(mgt_clk_mult_2),
    .txp_1(txp[1]), .txn_1(txn[1]),
    .txp_0(txp[0]), .txn_0(txn[0]),
    .rxp_1(rxp[1]), .rxn_1(rxn[1]),
    .rxp_0(rxp[0]), .rxn_0(rxn[0]),
    .chbondi_1(chbond_1_hop), .chbondi_0(3'b000),
    .chbondo_1(), .chbondo_0(chbond_1_hop),

    .rxdata_1(rxdata[31:16]), .rxdata_0(rxdata[15:0]), 
    .rxcharisk_1(rxcharisk[3:2]), .rxcharisk_0(rxcharisk[1:0]),
    .txdata_1(txdata[31:16]), .txdata_0(txdata[15:0]), 
    .txcharisk_1(txcharisk[3:2]), .txcharisk_0(txcharisk[1:0]),
    .code_comma_1(code_comma[3:2]), .code_comma_0(code_comma[1:0]),
    .enchansync_1(enchansync), .enchansync_0(enchansync),
    .enable_align_1(enable_align[1]), .enable_align_0(enable_align[0]),
    .loopback(loopback), .powerdown(powerdown),
    .rxlock_1(rxlock[1]), .rxlock_0(rxlock[0]),
    .syncok_1(syncok[1]), .syncok_0(syncok[0]),
    .codevalid_1(codevalid[3:2]), .codevalid_0(codevalid[1:0]),
    .rxbufferr_1(rxbufferr[1]), .rxbufferr_0(rxbufferr[0]),

    .rxeqmix(rxeqmix), .rxeqpole(rxeqpole),
    .txpreemphasis(txpreemphasis), .txdiffctrl(txdiffctrl)
  );

  wire refclk_ret_nc;

  transceiver #(
    .TX_POLARITY_HACK_0(TX_POLARITY_HACK[2]),
    .TX_POLARITY_HACK_1(TX_POLARITY_HACK[3]),
    .RX_POLARITY_HACK_0(RX_POLARITY_HACK[2]),
    .RX_POLARITY_HACK_1(RX_POLARITY_HACK[3]),
    .CHAN_BOND_LEVEL_1(0),
    .CHAN_BOND_LEVEL_0(0),
    .CHAN_BOND_MODE_1("SLAVE"),
    .CHAN_BOND_MODE_0("SLAVE"),
    .DIFF_BOOST(DIFF_BOOST)
  ) transceiver_1 (
    .reset(reset), .rx_reset(rx_reset), .tx_reset(tx_reset),
    .refclk(refclk), .refclk_ret(refclk_ret_nc),
    .mgt_clk(mgt_clk), .mgt_clk_mult_2(mgt_clk_mult_2),
    .txp_1(txp[3]), .txn_1(txn[3]),
    .txp_0(txp[2]), .txn_0(txn[2]),
    .rxp_1(rxp[3]), .rxn_1(rxn[3]),
    .rxp_0(rxp[2]), .rxn_0(rxn[2]),
    .chbondi_1(chbond_1_hop), .chbondi_0(chbond_1_hop),
    .chbondo_1(), .chbondo_0(),

    .rxdata_1(rxdata[63:48]), .rxdata_0(rxdata[47:32]), 
    .rxcharisk_1(rxcharisk[7:6]), .rxcharisk_0(rxcharisk[5:4]),
    .txdata_1(txdata[63:48]), .txdata_0(txdata[47:32]), 
    .txcharisk_1(txcharisk[7:6]), .txcharisk_0(txcharisk[5:4]),
    .code_comma_1(code_comma[7:6]), .code_comma_0(code_comma[5:4]),
    .enchansync_1(enchansync), .enchansync_0(enchansync),
    .enable_align_1(enable_align[3]), .enable_align_0(enable_align[2]),
    .loopback(loopback), .powerdown(powerdown),
    .rxlock_1(rxlock[3]), .rxlock_0(rxlock[2]),
    .syncok_1(syncok[3]), .syncok_0(syncok[2]),
    .codevalid_1(codevalid[7:6]), .codevalid_0(codevalid[5:4]),
    .rxbufferr_1(rxbufferr[3]), .rxbufferr_0(rxbufferr[2]),

    .rxeqmix(rxeqmix), .rxeqpole(rxeqpole),
    .txpreemphasis(txpreemphasis), .txdiffctrl(txdiffctrl)
  );

endmodule
