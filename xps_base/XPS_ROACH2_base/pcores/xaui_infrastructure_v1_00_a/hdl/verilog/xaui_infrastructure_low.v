module xaui_infrastructure_low #(
    parameter ENABLE = 8'b0000_0000,
    parameter RX_LANE_STEER = 8'b1111_1111,
    parameter TX_LANE_STEER = 8'b0000_0000,
    parameter RX_INVERT = 8'b0111_0111
  ) (
    input             mgt_reset,

    input       [2:0] xaui_refclk_n,
    input       [2:0] xaui_refclk_p,

    input   [8*4-1:0] mgt_rx_n,
    input   [8*4-1:0] mgt_rx_p,
    output  [8*4-1:0] mgt_tx_n,
    output  [8*4-1:0] mgt_tx_p,

    output            xaui_clk,

    input   [8*1-1:0] mgt_tx_rst,
    input   [8*64-1:0] mgt_txdata,
    input   [8*8-1:0] mgt_txcharisk,
    input   [8*5-1:0] mgt_txpostemphasis,
    input   [8*4-1:0] mgt_txpreemphasis,
    input   [8*4-1:0] mgt_txdiffctrl,

    input   [8*1-1:0] mgt_rx_rst,
    output  [8*64-1:0] mgt_rxdata,
    output  [8*8-1:0] mgt_rxcharisk,
    output  [8*8-1:0] mgt_rxcodecomma,
    input   [8*4-1:0] mgt_rxencommaalign,
    input   [8*1-1:0] mgt_rxenchansync,
    output  [8*4-1:0] mgt_rxsyncok,
    output  [8*8-1:0] mgt_rxcodevalid,
    output  [8*4-1:0] mgt_rxbufferr,
    input   [8*3-1:0] mgt_rxeqmix,
    output  [8*4-1:0] mgt_rxlock,
    output  [8*4-1:0] mgt_rxelecidle,

    input   [8*3-1:0] mgt_loopback,
    input   [8*1-1:0] mgt_powerdown,
    output [8*16-1:0] mgt_status
  );

  /* RX Byte steering defines */
  wire [8*64-1:0] mgt_rxdata_swap;
  wire  [8*8-1:0] mgt_rxcharisk_swap;
  wire  [8*8-1:0] mgt_rxcodecomma_swap;
  wire  [8*4-1:0] mgt_rxencommaalign_swap;
  wire  [8*4-1:0] mgt_rxsyncok_swap;
  wire  [8*8-1:0] mgt_rxcodevalid_swap;
  wire  [8*4-1:0] mgt_rxbufferr_swap;
  wire  [8*4-1:0] mgt_rxelecidle_swap;
  wire  [8*4-1:0] mgt_rxlock_swap;
  
  /* TX Byte steering defines */
  wire [8*64-1:0] mgt_txdata_swap;
  wire  [8*8-1:0] mgt_txcharisk_swap;

  wire [2:0] gtx_refclk;
  wire [2:0] pma_reset;

  IBUFDS_GTXE1 gtk_clkbuf[2:0] (
    .I     (xaui_refclk_p),
    .IB    (xaui_refclk_n),
    .CEB   (1'b0),
    .O     (gtx_refclk),
    .ODIV2 ()
  );

  wire gtx_clk_o;

  BUFG bufg_xaui_clk(
    .I (gtx_clk_o),
    .O (xaui_clk)
  );

  wire [2:0] gtx_refclk_bufr;

  BUFR bufr_gtx_refclk[2:0](
    .I   (gtx_refclk),
    .O   (gtx_refclk_bufr),
    .CE  (1'b1),
    .CLR (1'b0)
  );

  /* synchronize pma reset to local gtx_refclk_bufr domain */
  // I'm not actually sure why, but the sgmii example did this so...

  reg  [3:0] reset_r[2:0];

  always@(posedge gtx_refclk_bufr[0] or posedge mgt_reset) begin
    if (mgt_reset == 1'b1) begin
      reset_r[0] <= 4'b1111;
    end else begin
      reset_r[0] <= {reset_r[0][2:0], mgt_reset};
    end
  end

  always@(posedge gtx_refclk_bufr[1] or posedge mgt_reset) begin
    if (mgt_reset == 1'b1) begin
      reset_r[1] <= 4'b1111;
    end else begin
      reset_r[1] <= {reset_r[1][2:0], mgt_reset};
    end
  end

  always@(posedge gtx_refclk_bufr[2] or posedge mgt_reset) begin
    if (mgt_reset == 1'b1) begin
      reset_r[2] <= 4'b1111;
    end else begin
      reset_r[2] <= {reset_r[2][2:0], mgt_reset};
    end
  end

  assign pma_reset = {reset_r[2][3], reset_r[1][3], reset_r[0][3]};

  /* Which pma resets and gtx_refclks go where */
  wire [7:0] pma_reset_map;
  wire [7:0] gtx_refclk_map;

  /* which GTX output clock should we use use as the xaui reference clock.
     Note that all clocks are generated from the source source using a PLL, this means
     that we can use one clock for all application interfaces */
  wire [8*4-1:0] gtxclk_out_map;
//  assign gtx_clk_o = gtxclk_out_map[2];

  wire [8*8-1:0] mgt_rxdisperror;
  wire [8*8-1:0] mgt_rxnotintable;
  assign mgt_rxcodevalid_swap = ~(mgt_rxdisperror | mgt_rxnotintable);

  wire [8*8-1:0] rxlossofsync;

  wire [8*4-1:0] rx_resetdone;
  wire [8*4-1:0] tx_resetdone;

//  wire [8*4-1:0] rx_polarity = 32'h0fff_0fff;
  wire [8*4-1:0] rx_polarity;
  assign rx_polarity = { {4{RX_INVERT[7] == 1}}, {4{RX_INVERT[6] == 1}}, {4{RX_INVERT[5] == 1}}, {4{RX_INVERT[4] == 1}},
                         {4{RX_INVERT[3] == 1}}, {4{RX_INVERT[2] == 1}}, {4{RX_INVERT[1] == 1}}, {4{RX_INVERT[0] == 1}}};

//--- make the gtx_clk (xaui_clk) the output of the first gtx_quad instantiated
generate 
  if(ENABLE[0] == 1'b1) begin
    assign gtx_clk_o = gtxclk_out_map[0*4];
  end else if (ENABLE[1] == 1'b1) begin
    assign gtx_clk_o = gtxclk_out_map[1*4];
  end else if (ENABLE[2] == 1'b1) begin
    assign gtx_clk_o = gtxclk_out_map[2*4];
  end else if (ENABLE[3] == 1'b1) begin
    assign gtx_clk_o = gtxclk_out_map[3*4];
  end else if (ENABLE[4] == 1'b1) begin
    assign gtx_clk_o = gtxclk_out_map[4*4];
  end else if (ENABLE[5] == 1'b1) begin
    assign gtx_clk_o = gtxclk_out_map[5*4];
  end else if (ENABLE[6] == 1'b1) begin
    assign gtx_clk_o = gtxclk_out_map[6*4];
  end else if (ENABLE[7] == 1'b1) begin
    assign gtx_clk_o = gtxclk_out_map[7*4];
  end else begin
    assign gtx_clk_o = 1'b0; //held low
  end
endgenerate

genvar I;
generate 
for (I=0; I < 8; I=I+1) begin : gtx_wrap_gen
  if (ENABLE[I] == 1'b1)
  begin
    gtx_quad gtx_quad_inst (
      //---------------------- Loopback and Powerdown Ports ----------------------
      .LOOPBACK_IN                    (mgt_loopback[I*3+:3]),
      .RXPOWERDOWN_IN                 (mgt_powerdown[I]),
      .TXPOWERDOWN_IN                 (mgt_powerdown[I]),
      //--------------------- Receive Ports - 8b10b Decoder ----------------------
      .RXCHARISCOMMA_OUT              (mgt_rxcodecomma_swap[I*8+:8]),
      .RXCHARISK_OUT                  (mgt_rxcharisk_swap[I*8+:8]),
      .RXDISPERR_OUT                  (mgt_rxdisperror[I*8+:8]),
      .RXNOTINTABLE_OUT               (mgt_rxnotintable[I*8+:8]),
      //------------- Receive Ports - Comma Detection and Alignment --------------
      .RXENMCOMMAALIGN_IN             (mgt_rxencommaalign_swap[I*4+:4]),
      .RXENPCOMMAALIGN_IN             (mgt_rxencommaalign_swap[I*4+:4]),
      .RXENCHANSYNC_IN                (mgt_rxenchansync[I]),
      //----------------- Receive Ports - RX Data Path interface -----------------
      .RXDATA_OUT                     (mgt_rxdata_swap[I*64+:64]),
      .RXRESET_IN                     (mgt_rx_rst[I]),
      .RXUSRCLK2_IN                   (xaui_clk),
      //----- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
      .RXELECIDLE_OUT                 (mgt_rxelecidle_swap[I*4+:4]),
      .RXEQMIX_IN                     (mgt_rxeqmix[I*3+:3]),
      .RXN_IN                         (mgt_rx_n[I*4+:4]),
      .RXP_IN                         (mgt_rx_p[I*4+:4]),
      //------ Receive Ports - RX Elastic Buffer and Phase Alignment Ports -------
      .RXBUFRESET_IN                  (mgt_rx_rst[I]),
      .RXBUFSTATUS_OUT                (mgt_rxbufferr_swap[I*4+:4]),
      //------------- Receive Ports - RX Loss-of-sync State Machine --------------
      .RXLOSSOFSYNC_OUT               (rxlossofsync[I*8+:8]),
      //---------------------- Receive Ports - RX PLL Ports ----------------------
      .GTXRXRESET_IN                  (pma_reset_map[I]),
      .MGTREFCLKRX_IN                 (gtx_refclk_map[I]),
      .PLLRXRESET_IN                  (pma_reset_map[I]),
      .RXPLLLKDET_OUT                 (mgt_rxlock_swap[I*4+:4]),
      .RXRESETDONE_OUT                (rx_resetdone[I*4+:4]),
      .RXPOLARITY_IN                  (rx_polarity[I*4+:4]),
      //---------------- Transmit Ports - TX Data Path interface -----------------
      .TXCHARISK_IN                   (mgt_txcharisk_swap[I*8+:8]),
      .TXDATA_IN                      (mgt_txdata_swap[I*64+:64]),

      .TXOUTCLK_OUT                   (gtxclk_out_map[I*4+:4]),        
      .TXRESET_IN                     (mgt_tx_rst[I]),
      .TXUSRCLK2_IN                   (xaui_clk),
      //-------------- Transmit Ports - TX Driver and OOB signaling --------------
      .TXDIFFCTRL_IN                  (mgt_txdiffctrl[I*4+:4]),
      .TXN_OUT                        (mgt_tx_n[I*4+:4]),
      .TXP_OUT                        (mgt_tx_p[I*4+:4]),
      .TXPOSTEMPHASIS_IN              (mgt_txpostemphasis[I*5+:5]),
      //------------- Transmit Ports - TX Driver and OOB signalling --------------
      .TXPREEMPHASIS_IN               (mgt_txpreemphasis[I*4+:4]),
      //--------------------- Transmit Ports - TX PLL Ports ----------------------
      .GTXTXRESET_IN                  (pma_reset_map[I]),
      .MGTREFCLKTX_IN                 (gtx_refclk_map[I]),
      .PLLTXRESET_IN                  (1'b0),
      .TXRESETDONE_OUT                (tx_resetdone[I*4+:4])
    );

    assign mgt_rxsyncok_swap[I*4+:4] = {rxlossofsync[I*8+7],
                                        rxlossofsync[I*8+5],
                                       rxlossofsync[I*8+3],
                                        rxlossofsync[I*8+1]};

    assign mgt_status[I*16+:16] = {4'b0, mgt_rxbufferr[I*4+:4], 4'b0, mgt_rxelecidle[I*4+:4]};
  end //if
end endgenerate

  /* Which pma resets and gtx_refclks go where */

  assign gtx_refclk_map = { gtx_refclk[2],  gtx_refclk[2],  gtx_refclk[2],
                            gtx_refclk[1],  gtx_refclk[1],  gtx_refclk[1],
                            gtx_refclk[0],  gtx_refclk[0]};

  assign pma_reset_map = { pma_reset[2],  pma_reset[2],  pma_reset[2],
                           pma_reset[1],  pma_reset[1],  pma_reset[1],
                           pma_reset[0],  pma_reset[0]};


  /**** RX rerouting to compensate for crossover at XAUI endpoint ****/

  xaui_rx_steer #(
    .LANE_STEER (RX_LANE_STEER)
  ) xaui_rx_steer_inst (
    .rxdata_in          (mgt_rxdata_swap),
    .rxcharisk_in       (mgt_rxcharisk_swap),
    .rxcodecomma_in     (mgt_rxcodecomma_swap),
    .rxsyncok_in        (mgt_rxsyncok_swap),
    .rxcodevalid_in     (mgt_rxcodevalid_swap),
    .rxbufferr_in       (mgt_rxbufferr_swap),
    .rxelecidle_in      (mgt_rxelecidle_swap),
    .rxlock_in          (mgt_rxlock_swap),
    .rxencommaalign_in  (mgt_rxencommaalign),
    .rxdata_out         (mgt_rxdata),
    .rxcharisk_out      (mgt_rxcharisk),
    .rxcodecomma_out    (mgt_rxcodecomma),
    .rxsyncok_out       (mgt_rxsyncok),
    .rxcodevalid_out    (mgt_rxcodevalid),
    .rxbufferr_out      (mgt_rxbufferr),
    .rxelecidle_out     (mgt_rxelecidle),
    .rxlock_out         (mgt_rxlock),
    .rxencommaalign_out (mgt_rxencommaalign_swap)
  );
  
  xaui_rx_steer #(
    .LANE_STEER (TX_LANE_STEER)
  ) xaui_tx_steer_inst (
    .rxdata_in          (mgt_txdata),
    .rxcharisk_in       (mgt_txcharisk),
    .rxcodecomma_in     (),
    .rxsyncok_in        (),
    .rxcodevalid_in     (),
    .rxbufferr_in       (),
    .rxelecidle_in      (),
    .rxlock_in          (),
    .rxencommaalign_in  (),
    .rxdata_out         (mgt_txdata_swap),
    .rxcharisk_out      (mgt_txcharisk_swap),
    .rxcodecomma_out    (),
    .rxsyncok_out       (),
    .rxcodevalid_out    (),
    .rxbufferr_out      (),
    .rxelecidle_out     (),
    .rxlock_out         (),
    .rxencommaalign_out ()
  );
  
endmodule
