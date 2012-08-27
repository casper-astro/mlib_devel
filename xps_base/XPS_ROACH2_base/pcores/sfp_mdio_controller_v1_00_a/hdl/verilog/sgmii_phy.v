module sgmii_phy (
    input        mgt_rx_n,
    input        mgt_rx_p,
    output       mgt_tx_n,
    output       mgt_tx_p,

    input        mgt_clk_n,
    input        mgt_clk_p,

    input        mgt_reset,

    output       clk_125,
    output       recclk_125,

    // MAC Interface
    input  [7:0] sgmii_txd,
    input        sgmii_txisk,
    input        sgmii_txdispmode,
    input        sgmii_txdispval,
    output [1:0] sgmii_txbufstatus,
    input        sgmii_txreset,

    output [7:0] sgmii_rxd,
    output       sgmii_rxiscomma,
    output       sgmii_rxisk,
    output       sgmii_rxdisperr,
    output       sgmii_rxnotintable,
    output       sgmii_rxrundisp,
    output [2:0] sgmii_rxclkcorcnt,
    output [2:0] sgmii_rxbufstatus,
    input        sgmii_rxreset,
    

    input        sgmii_encommaalign,
    output       sgmii_pll_locked,
    output       sgmii_elecidle,

    output       sgmii_resetdone,

    input        sgmii_loopback,
    input        sgmii_powerdown
  );


  /*********** Clocks ************/

  // Clock for transceiver
  wire clk_ds;

  IBUFDS_GTXE1 clkingen (
    .I     (mgt_clk_p),
    .IB    (mgt_clk_n),
    .CEB   (1'b0),
    .O     (clk_ds),
    .ODIV2 ()
  );

  // Global buffer for output clock

  // gtp refclk out
  wire clk_125_o;
  BUFG bufg_clk_125 (
     .I (clk_125_o),
     .O (clk_125)
  );

  // recclk bufg
  wire recclk_125_o;
  BUFG bufg_recclk_125 (
     .I (recclk_125_o),
     .O (recclk_125)
  );

  wire pma_reset;

  // Locally buffer the output of the IBUFDS_GTXE1 for reset logic
  wire clk_ds_i;
  BUFR bufr_clk_ds (
     .I   (clk_ds),
     .O   (clk_ds_i),
     .CE  (1'b1),
     .CLR (1'b0)
  );

  reg  [3:0] reset_r;

  always@(posedge clk_ds_i or posedge mgt_reset)
     if (mgt_reset == 1'b1)
        reset_r <= 4'b1111;
     else
        reset_r <= {reset_r[2:0], mgt_reset};

  assign pma_reset = reset_r[3];
  

  /************* GTX Wrapper ****************/

  wire gtx_tx_reset_done;
  wire gtx_rx_reset_done;

  sgmii_gtx #(
    // Simulation attributes
    .GTX_SIM_GTXRESET_SPEEDUP   (0),

    // Share RX PLL parameter
    .GTX_TX_CLK_SOURCE           ("RXPLL"),
    // Save power parameter
    .GTX_POWER_SAVE              (10'b0000110100)
  ) sgmii_gtx_inst (
    //---------------------- Loopback and Powerdown Ports ----------------------
    .LOOPBACK_IN                    ({2'b0, sgmii_loopback}),
    .RXPOWERDOWN_IN                 ({2{sgmii_powerdown}}),
    .TXPOWERDOWN_IN                 ({2{sgmii_powerdown}}),
    //--------------------- Receive Ports - 8b10b Decoder ----------------------
    .RXCHARISCOMMA_OUT              (sgmii_rxiscomma),
    .RXCHARISK_OUT                  (sgmii_rxisk),
    .RXDISPERR_OUT                  (sgmii_rxdisperr),
    .RXNOTINTABLE_OUT               (sgmii_rxnotintable),
    .RXRUNDISP_OUT                  (sgmii_rxrundisp),
    //----------------- Receive Ports - Clock Correction Ports -----------------
    .RXCLKCORCNT_OUT                (sgmii_rxclkcorcnt),
    //------------- Receive Ports - Comma Detection and Alignment --------------
    .RXENMCOMMAALIGN_IN             (sgmii_encommaalign),
    .RXENPCOMMAALIGN_IN             (sgmii_encommaalign),
    //----------------- Receive Ports - RX Data Path interface -----------------
    .RXDATA_OUT                     (sgmii_rxd),
    .RXRECCLK_OUT                   (recclk_125_o),
    .RXRESET_IN                     (sgmii_rxreset),
    .RXUSRCLK2_IN                   (clk_125),
    //----- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
    .RXELECIDLE_OUT                 (sgmii_elecidle),
    .RXN_IN                         (mgt_rx_n),
    .RXP_IN                         (mgt_rx_p),
    //------ Receive Ports - RX Elastic Buffer and Phase Alignment Ports -------
    .RXBUFRESET_IN                  (sgmii_rxreset),
    .RXBUFSTATUS_OUT                (sgmii_rxbufstatus),
    //---------------------- Receive Ports - RX PLL Ports ----------------------
    .GTXRXRESET_IN                  (pma_reset),
    .MGTREFCLKRX_IN                 ({1'b0 , clk_ds}),
    .PLLRXRESET_IN                  (pma_reset),
    .RXPLLLKDET_OUT                 (sgmii_pll_locked),
    .RXRESETDONE_OUT                (gtx_rx_reset_done),
    //-------------- Transmit Ports - 8b10b Encoder Control Ports --------------

    .TXCHARDISPMODE_IN              (sgmii_txdispmode),
    .TXCHARDISPVAL_IN               (sgmii_txdispval),
    .TXCHARISK_IN                   (sgmii_txisk),
    //---------------- Transmit Ports - TX Data Path interface -----------------
    .TXDATA_IN                      (sgmii_txd),
    .TXOUTCLK_OUT                   (clk_125_o),
    .TXRESET_IN                     (sgmii_txreset),
    .TXUSRCLK2_IN                   (clk_125),
    //-------------- Transmit Ports - TX Driver and OOB signaling --------------
    .TXN_OUT                        (mgt_tx_n),
    .TXP_OUT                        (mgt_tx_p),
    //--------- Transmit Ports - TX Elastic Buffer and Phase Alignment ---------
    .TXBUFSTATUS_OUT                (sgmii_txbufstatus),
    //--------------------- Transmit Ports - TX PLL Ports ----------------------
    .GTXTXRESET_IN                  (pma_reset),
    .MGTREFCLKTX_IN                 ({1'b0 , clk_ds}),
    .PLLTXRESET_IN                  (1'b0),
    .TXPLLLKDET_OUT                 (),
    .TXRESETDONE_OUT                (gtx_tx_reset_done)
  );

   // Register the Tx and Rx resetdone signals, and AND them to provide a
   // single RESETDONE output
   reg resetdone_tx_r;
   reg resetdone_rx_r;
   always @(posedge clk_125 or posedge sgmii_txreset)
      if (sgmii_txreset === 1'b1)
         resetdone_tx_r <= 1'b0;
      else
         resetdone_tx_r <= gtx_tx_reset_done;

   always @(posedge clk_125 or posedge sgmii_rxreset)
      if (sgmii_rxreset === 1'b1)
         resetdone_rx_r <= 1'b0;
      else
         resetdone_rx_r <= gtx_rx_reset_done;

   assign resetdone_i = resetdone_tx_r && resetdone_rx_r;
   assign sgmii_resetdone = resetdone_i;

endmodule
