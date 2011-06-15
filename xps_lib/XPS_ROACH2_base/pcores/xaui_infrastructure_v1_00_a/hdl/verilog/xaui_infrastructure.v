module xaui_infrastructure(
    reset,

    mgt_refclk_t_n, mgt_refclk_t_p, 
    mgt_refclk_b_n, mgt_refclk_b_p, 

    mgt_tx_t0_n, mgt_tx_t0_p,
    mgt_tx_t1_n, mgt_tx_t1_p,
    mgt_tx_b0_n, mgt_tx_b0_p,
    mgt_tx_b1_n, mgt_tx_b1_p,
    mgt_rx_t0_n, mgt_rx_t0_p,
    mgt_rx_t1_n, mgt_rx_t1_p,
    mgt_rx_b0_n, mgt_rx_b0_p,
    mgt_rx_b1_n, mgt_rx_b1_p,

    mgt_clk_0, mgt_clk_lock_0,
    mgt_clk_1, mgt_clk_lock_1,

    mgt_tx_reset_3, mgt_rx_reset_3,
    mgt_rxdata_3, mgt_rxcharisk_3,
    mgt_txdata_3, mgt_txcharisk_3,
    mgt_code_comma_3,
    mgt_enchansync_3, mgt_enable_align_3,
    mgt_loopback_3, mgt_powerdown_3,
    mgt_rxlock_3, mgt_syncok_3, mgt_codevalid_3, mgt_rxbufferr_3,
    mgt_rxeqmix_3, mgt_rxeqpole_3, mgt_txpreemphasis_3, mgt_txdiffctrl_3,
    mgt_tx_reset_2, mgt_rx_reset_2,
    mgt_rxdata_2, mgt_rxcharisk_2,
    mgt_txdata_2, mgt_txcharisk_2,
    mgt_code_comma_2,
    mgt_enchansync_2, mgt_enable_align_2,
    mgt_loopback_2, mgt_powerdown_2,
    mgt_rxlock_2, mgt_syncok_2, mgt_codevalid_2, mgt_rxbufferr_2,
    mgt_rxeqmix_2, mgt_rxeqpole_2, mgt_txpreemphasis_2, mgt_txdiffctrl_2,
    mgt_tx_reset_1, mgt_rx_reset_1,
    mgt_rxdata_1, mgt_rxcharisk_1,
    mgt_txdata_1, mgt_txcharisk_1,
    mgt_code_comma_1,
    mgt_enchansync_1, mgt_enable_align_1,
    mgt_loopback_1, mgt_powerdown_1,
    mgt_rxlock_1, mgt_syncok_1, mgt_codevalid_1, mgt_rxbufferr_1,
    mgt_rxeqmix_1, mgt_rxeqpole_1, mgt_txpreemphasis_1, mgt_txdiffctrl_1,
    mgt_tx_reset_0, mgt_rx_reset_0,
    mgt_rxdata_0, mgt_rxcharisk_0,
    mgt_txdata_0, mgt_txcharisk_0,
    mgt_code_comma_0,
    mgt_enchansync_0, mgt_enable_align_0,
    mgt_loopback_0, mgt_powerdown_0,
    mgt_rxlock_0, mgt_syncok_0, mgt_codevalid_0, mgt_rxbufferr_0,
    mgt_rxeqmix_0, mgt_rxeqpole_0, mgt_txpreemphasis_0, mgt_txdiffctrl_0
  );
  parameter DIFF_BOOST = "TRUE";
  parameter DISABLE_0  = 1;
  parameter DISABLE_1  = 1;
  parameter DISABLE_2  = 1;
  parameter DISABLE_3  = 1;

  input  reset;

  input  mgt_refclk_t_n, mgt_refclk_t_p;
  input  mgt_refclk_b_n, mgt_refclk_b_p;

  output [3:0] mgt_tx_t0_n;
  output [3:0] mgt_tx_t0_p;
  output [3:0] mgt_tx_t1_n;
  output [3:0] mgt_tx_t1_p;
  output [3:0] mgt_tx_b0_n;
  output [3:0] mgt_tx_b0_p;
  output [3:0] mgt_tx_b1_n;
  output [3:0] mgt_tx_b1_p;
  input  [3:0] mgt_rx_t0_n;
  input  [3:0] mgt_rx_t0_p;
  input  [3:0] mgt_rx_t1_n;
  input  [3:0] mgt_rx_t1_p;
  input  [3:0] mgt_rx_b0_n;
  input  [3:0] mgt_rx_b0_p;
  input  [3:0] mgt_rx_b1_n;
  input  [3:0] mgt_rx_b1_p;

  output mgt_clk_0, mgt_clk_lock_0;
  output mgt_clk_1, mgt_clk_lock_1;

  input  mgt_tx_reset_3, mgt_rx_reset_3;
  output [63:0] mgt_rxdata_3;
  output  [7:0] mgt_rxcharisk_3;
  input  [63:0] mgt_txdata_3;
  input   [7:0] mgt_txcharisk_3;
  output  [7:0] mgt_code_comma_3;
  input   [3:0] mgt_enable_align_3;
  input  mgt_enchansync_3;
  input  mgt_loopback_3, mgt_powerdown_3;
  output  [3:0] mgt_rxlock_3;
  output  [3:0] mgt_syncok_3;
  output  [7:0] mgt_codevalid_3;
  output  [3:0] mgt_rxbufferr_3;
  input   [1:0] mgt_rxeqmix_3;
  input   [3:0] mgt_rxeqpole_3;
  input   [2:0] mgt_txpreemphasis_3;
  input   [2:0] mgt_txdiffctrl_3;

  input  mgt_tx_reset_2, mgt_rx_reset_2;
  output [63:0] mgt_rxdata_2;
  output  [7:0] mgt_rxcharisk_2;
  input  [63:0] mgt_txdata_2;
  input   [7:0] mgt_txcharisk_2;
  output  [7:0] mgt_code_comma_2;
  input   [3:0] mgt_enable_align_2;
  input  mgt_enchansync_2;
  input  mgt_loopback_2, mgt_powerdown_2;
  output  [3:0] mgt_rxlock_2;
  output  [3:0] mgt_syncok_2;
  output  [7:0] mgt_codevalid_2;
  output  [3:0] mgt_rxbufferr_2;
  input   [1:0] mgt_rxeqmix_2;
  input   [3:0] mgt_rxeqpole_2;
  input   [2:0] mgt_txpreemphasis_2;
  input   [2:0] mgt_txdiffctrl_2;

  input  mgt_tx_reset_1, mgt_rx_reset_1;
  output [63:0] mgt_rxdata_1;
  output  [7:0] mgt_rxcharisk_1;
  input  [63:0] mgt_txdata_1;
  input   [7:0] mgt_txcharisk_1;
  output  [7:0] mgt_code_comma_1;
  input   [3:0] mgt_enable_align_1;
  input  mgt_enchansync_1;
  input  mgt_loopback_1, mgt_powerdown_1;
  output  [3:0] mgt_rxlock_1;
  output  [3:0] mgt_syncok_1;
  output  [7:0] mgt_codevalid_1;
  output  [3:0] mgt_rxbufferr_1;
  input   [1:0] mgt_rxeqmix_1;
  input   [3:0] mgt_rxeqpole_1;
  input   [2:0] mgt_txpreemphasis_1;
  input   [2:0] mgt_txdiffctrl_1;

  input  mgt_tx_reset_0, mgt_rx_reset_0;
  output [63:0] mgt_rxdata_0;
  output  [7:0] mgt_rxcharisk_0;
  input  [63:0] mgt_txdata_0;
  input   [7:0] mgt_txcharisk_0;
  output  [7:0] mgt_code_comma_0;
  input   [3:0] mgt_enable_align_0;
  input  mgt_enchansync_0;
  input  mgt_loopback_0, mgt_powerdown_0;
  output  [3:0] mgt_rxlock_0;
  output  [3:0] mgt_syncok_0;
  output  [7:0] mgt_codevalid_0;
  output  [3:0] mgt_rxbufferr_0;
  input   [1:0] mgt_rxeqmix_0;
  input   [3:0] mgt_rxeqpole_0;
  input   [2:0] mgt_txpreemphasis_0;
  input   [2:0] mgt_txdiffctrl_0;


  /********* Polarity Correction Hacks for RX and TX **********/

  localparam RX_POLARITY_HACK_3 = { 1'b0, //lane 3
                                    1'b1, //lane 2
                                    1'b0, //lane 1
                                    1'b1  //lane 0
                                 };
  localparam RX_POLARITY_HACK_2 = { 1'b0, //lane 3
                                    1'b1, //lane 2
                                    1'b0, //lane 1
                                    1'b1  //lane 0
                                 };
  localparam RX_POLARITY_HACK_1 = { 1'b0, //lane 3
                                    1'b1, //lane 2
                                    1'b0, //lane 1
                                    1'b1  //lane 0
                                 };
  localparam RX_POLARITY_HACK_0 = { 1'b0, //lane 3
                                    1'b1, //lane 2
                                    1'b0, //lane 1
                                    1'b1  //lane 0
                                 };

  localparam TX_POLARITY_HACK_3 = { 1'b1, //lane 3
                                    1'b0, //lane 2
                                    1'b1, //lane 1
                                    1'b0  //lane 0
                                 };
  localparam TX_POLARITY_HACK_2 = { 1'b1, //lane 3
                                    1'b0, //lane 2
                                    1'b1, //lane 1
                                    1'b0  //lane 0
                                 };
  localparam TX_POLARITY_HACK_1 = { 1'b1, //lane 3
                                    1'b0, //lane 2
                                    1'b1, //lane 1
                                    1'b0  //lane 0
                                 };
  localparam TX_POLARITY_HACK_0 = { 1'b1, //lane 3
                                    1'b0, //lane 2
                                    1'b1, //lane 1
                                    1'b0  //lane 0
                                 };
                            

  /****************** GTP/MGT Clock Generation *******************/
  wire refclk_t; //dedicated mgt refclks
  wire refclk_b;

  wire refclk_b_ret; //dedicated return signals for refclks
  wire refclk_t_ret;

  /* Dedicated MGTREFCLK ibufds */
  IBUFDS ibufds_refclk_top (
    .I(mgt_refclk_t_p), .IB(mgt_refclk_t_n),
    .O(refclk_t)
  );
  IBUFDS ibufds_refclk_bottom (
    .I(mgt_refclk_b_p), .IB(mgt_refclk_b_n),
    .O(refclk_b)
  );

  wire mgt_clk_t, mgt_clk_mult_2_t; //top usr clks
  wire mgt_clk_b, mgt_clk_mult_2_b; //bottom usr clks



  /********** Top MGT clock generation **********/

  wire pll_fb_t;
  wire mgt_clk_int_t, mgt_clk_mult_2_int_t;
  wire refclk_t_ret_bufg;

  BUFG refclk_ret_bufg_t(
    .I(refclk_t_ret),
    .O(refclk_t_ret_bufg)
  );

  PLL_BASE #(
    .BANDWIDTH("OPTIMIZED"),
    .CLKFBOUT_MULT(4),
    .DIVCLK_DIVIDE(1),
    .CLKFBOUT_PHASE(0.0),
    .CLKIN_PERIOD(6.4),

    .CLKOUT0_DIVIDE(4),
    .CLKOUT0_DUTY_CYCLE(0.5),
    .CLKOUT0_PHASE(0.0),

    .CLKOUT1_DIVIDE(2),
    .CLKOUT1_DUTY_CYCLE(0.5),
    .CLKOUT1_PHASE(0),

    .COMPENSATION("SYSTEM_SYNCHRONOUS"),
    .REF_JITTER(0.100),
    .RESET_ON_LOSS_OF_LOCK("FALSE")
  ) PLL_BASE_inst_t (
   .CLKFBOUT(pll_fb_t),
   .CLKOUT0(mgt_clk_int_t),
   .CLKOUT1(mgt_clk_mult_2_int_t),
   .CLKOUT2(),
   .CLKOUT3(),
   .CLKOUT4(),
   .CLKOUT5(),
   .LOCKED(mgt_clk_lock_1),
   .CLKFBIN(pll_fb_t),
   .CLKIN(refclk_t_ret_bufg),
   .RST((!mgt_rxlock_3[0]) || reset)
  );

  BUFG bufg_mgt_t(
    .I(mgt_clk_int_t),
    .O(mgt_clk_t)
  );

  BUFG bufg_mgt_mult_2_t(
    .I(mgt_clk_mult_2_int_t),
    .O(mgt_clk_mult_2_t)
  );
  assign mgt_clk_1 = mgt_clk_t;

  /******** Bottom MGT clock generation ********/

  wire pll_fb_b;
  wire mgt_clk_int_b, mgt_clk_mult_2_int_b;
  wire refclk_b_ret_bufg;

  BUFG refclk_ret_bufg_b(
    .I(refclk_b_ret),
    .O(refclk_b_ret_bufg)
  );

  /* NOTE: PLLs could be DCMs*/

  PLL_BASE #(
    .BANDWIDTH("OPTIMIZED"),
    .CLKFBOUT_MULT(4),
    .DIVCLK_DIVIDE(1),
    .CLKFBOUT_PHASE(0.0),
    .CLKIN_PERIOD(6.4),

    .CLKOUT0_DIVIDE(4),
    .CLKOUT0_DUTY_CYCLE(0.5),
    .CLKOUT0_PHASE(0.0),

    .CLKOUT1_DIVIDE(2),
    .CLKOUT1_DUTY_CYCLE(0.5),
    .CLKOUT1_PHASE(0),

    .COMPENSATION("SYSTEM_SYNCHRONOUS"),
    .REF_JITTER(0.100),
    .RESET_ON_LOSS_OF_LOCK("FALSE")
  ) PLL_BASE_inst_b (
   .CLKFBOUT(pll_fb_b),
   .CLKOUT0(mgt_clk_int_b),
   .CLKOUT1(mgt_clk_mult_2_int_b),
   .CLKOUT2(),
   .CLKOUT3(),
   .CLKOUT4(),
   .CLKOUT5(),
   .LOCKED(mgt_clk_lock_0),
   .CLKFBIN(pll_fb_b),
   .CLKIN(refclk_b_ret_bufg),
   .RST((!mgt_rxlock_1[0]) || reset)
  );

  BUFG bufg_mgt_b(
    .I(mgt_clk_int_b),
    .O(mgt_clk_b)
  );

  BUFG bufg_mgt_mult_2_b(
    .I(mgt_clk_mult_2_int_b),
    .O(mgt_clk_mult_2_b)
  );
  assign mgt_clk_0 = mgt_clk_b;
  

  /*********************** XAUI Bank 0 *****************************/

  /* Reorder hack due to crossed RX pairs on ROACH hardware
   * When loopback is enable behaviour must transform as if 
   * RX lanes not crossed */
  wire [63:0] mgt_rxdata_int_0;
  assign mgt_rxdata_0 = mgt_loopback_0 ? mgt_rxdata_int_0 :
                        {mgt_rxdata_int_0[15:0],  mgt_rxdata_int_0[31:16], mgt_rxdata_int_0[47:32], mgt_rxdata_int_0[63:48]};

  wire [7:0] mgt_rxcharisk_int_0;
  assign mgt_rxcharisk_0 = mgt_loopback_0 ? mgt_rxcharisk_int_0 :
                           {mgt_rxcharisk_int_0[1:0], mgt_rxcharisk_int_0[3:2], mgt_rxcharisk_int_0[5:4], mgt_rxcharisk_int_0[7:6]};

  wire [7:0] mgt_code_comma_int_0;
  assign mgt_code_comma_0 = mgt_loopback_0 ? mgt_code_comma_int_0 :
                            {mgt_code_comma_int_0[1:0], mgt_code_comma_int_0[3:2], mgt_code_comma_int_0[5:4], mgt_code_comma_int_0[7:6]};

  wire [7:0] mgt_codevalid_int_0;
  assign mgt_codevalid_0 = mgt_loopback_0 ? mgt_codevalid_int_0 :
                           {mgt_codevalid_int_0[1:0], mgt_codevalid_int_0[3:2], mgt_codevalid_int_0[5:4], mgt_codevalid_int_0[7:6]};

  wire [3:0] mgt_enable_align_int_0 = mgt_loopback_0 ? mgt_enable_align_0 :
                                      {mgt_enable_align_0[0], mgt_enable_align_0[1], mgt_enable_align_0[2], mgt_enable_align_0[3]};

  wire [3:0] mgt_rxlock_int_0;
  assign mgt_rxlock_0 = mgt_loopback_0 ? mgt_rxlock_int_0 :
                        {mgt_rxlock_int_0[0], mgt_rxlock_int_0[1], mgt_rxlock_int_0[2], mgt_rxlock_int_0[3]};

  wire [3:0] mgt_syncok_int_0;
  assign mgt_syncok_0 = mgt_loopback_0 ? mgt_syncok_int_0 :
                        {mgt_syncok_int_0[0], mgt_syncok_int_0[1], mgt_syncok_int_0[2], mgt_syncok_int_0[3]};

  wire [3:0] mgt_rxbufferr_int_0;
  assign mgt_rxbufferr_0 = mgt_loopback_0 ? mgt_rxbufferr_int_0 :
                           {mgt_rxbufferr_int_0[0], mgt_rxbufferr_int_0[1], mgt_rxbufferr_int_0[2], mgt_rxbufferr_int_0[3]};


  transceiver_bank #(
    .TX_POLARITY_HACK(TX_POLARITY_HACK_0),
    .RX_POLARITY_HACK(RX_POLARITY_HACK_0),
    .DIFF_BOOST(DIFF_BOOST)
  ) transceiver_bank_0 (
    .reset(reset),
    .rx_reset(mgt_rx_reset_0),
    .tx_reset(mgt_tx_reset_0),
    .refclk(refclk_b), .refclk_ret(),
    .mgt_clk(mgt_clk_b),
    .mgt_clk_mult_2(mgt_clk_mult_2_b),
    .txp(mgt_tx_b0_p), .txn(mgt_tx_b0_n),
    .rxp(mgt_rx_b0_p), .rxn(mgt_rx_b0_n),
    .txdata(mgt_txdata_0),
    .txcharisk(mgt_txcharisk_0),
    .rxdata(mgt_rxdata_int_0),
    .rxcharisk(mgt_rxcharisk_int_0),
    .code_comma(mgt_code_comma_int_0),
    .enchansync(mgt_enchansync_0),
    .enable_align(mgt_enable_align_int_0),
    .rxlock(mgt_rxlock_int_0),
    .syncok(mgt_syncok_int_0),
    .codevalid(mgt_codevalid_int_0),
    .rxbufferr(mgt_rxbufferr_int_0),

    .loopback(mgt_loopback_0), .powerdown(DISABLE_0 ? 1'b1 : mgt_powerdown_0),
    .rxeqmix(mgt_rxeqmix_0), .rxeqpole(mgt_rxeqpole_0),
    .txpreemphasis(mgt_txpreemphasis_0), .txdiffctrl(mgt_txdiffctrl_0)
  );

  /*********************** XAUI Bank 1 *****************************/

  /* Reorder hack due to crossed RX pairs on ROACH hardware
   * When loopback is enable behaviour must transform as if 
   * RX lanes not crossed */
  wire [63:0] mgt_rxdata_int_1;
  assign mgt_rxdata_1 = mgt_loopback_1 ? mgt_rxdata_int_1 :
                        {mgt_rxdata_int_1[15:0],  mgt_rxdata_int_1[31:16], mgt_rxdata_int_1[47:32], mgt_rxdata_int_1[63:48]};

  wire [7:0] mgt_rxcharisk_int_1;
  assign mgt_rxcharisk_1 = mgt_loopback_1 ? mgt_rxcharisk_int_1 :
                           {mgt_rxcharisk_int_1[1:0], mgt_rxcharisk_int_1[3:2], mgt_rxcharisk_int_1[5:4], mgt_rxcharisk_int_1[7:6]};

  wire [7:0] mgt_code_comma_int_1;
  assign mgt_code_comma_1 = mgt_loopback_1 ? mgt_code_comma_int_1 :
                            {mgt_code_comma_int_1[1:0], mgt_code_comma_int_1[3:2], mgt_code_comma_int_1[5:4], mgt_code_comma_int_1[7:6]};

  wire [7:0] mgt_codevalid_int_1;
  assign mgt_codevalid_1 = mgt_loopback_1 ? mgt_codevalid_int_1 :
                           {mgt_codevalid_int_1[1:0], mgt_codevalid_int_1[3:2], mgt_codevalid_int_1[5:4], mgt_codevalid_int_1[7:6]};

  wire [3:0] mgt_enable_align_int_1 = mgt_loopback_1 ? mgt_enable_align_1 :
                                      {mgt_enable_align_1[0], mgt_enable_align_1[1], mgt_enable_align_1[2], mgt_enable_align_1[3]};

  wire [3:0] mgt_rxlock_int_1;
  assign mgt_rxlock_1 = mgt_loopback_1 ? mgt_rxlock_int_1 :
                        {mgt_rxlock_int_1[0], mgt_rxlock_int_1[1], mgt_rxlock_int_1[2], mgt_rxlock_int_1[3]};

  wire [3:0] mgt_syncok_int_1;
  assign mgt_syncok_1 = mgt_loopback_1 ? mgt_syncok_int_1 :
                        {mgt_syncok_int_1[0], mgt_syncok_int_1[1], mgt_syncok_int_1[2], mgt_syncok_int_1[3]};

  wire [3:0] mgt_rxbufferr_int_1;
  assign mgt_rxbufferr_1 = mgt_loopback_1 ? mgt_rxbufferr_int_1 :
                           {mgt_rxbufferr_int_1[0], mgt_rxbufferr_int_1[1], mgt_rxbufferr_int_1[2], mgt_rxbufferr_int_1[3]};

  transceiver_bank #(
    .TX_POLARITY_HACK(TX_POLARITY_HACK_1),
    .RX_POLARITY_HACK(RX_POLARITY_HACK_1),
    .DIFF_BOOST(DIFF_BOOST)
  ) transceiver_bank_1 (
    .reset(reset),
    .rx_reset(mgt_rx_reset_1),
    .tx_reset(mgt_tx_reset_1),
    .refclk(refclk_b), .refclk_ret(refclk_b_ret),
    .mgt_clk(mgt_clk_b),
    .mgt_clk_mult_2(mgt_clk_mult_2_b),
    .txp(mgt_tx_b1_p), .txn(mgt_tx_b1_n),
    .rxp(mgt_rx_b1_p), .rxn(mgt_rx_b1_n),
    .txdata(mgt_txdata_1),
    .txcharisk(mgt_txcharisk_1),
    .rxdata(mgt_rxdata_int_1),
    .rxcharisk(mgt_rxcharisk_int_1),
    .code_comma(mgt_code_comma_int_1),
    .enchansync(mgt_enchansync_1),
    .enable_align(mgt_enable_align_int_1),
    .rxlock(mgt_rxlock_int_1),
    .syncok(mgt_syncok_int_1),
    .codevalid(mgt_codevalid_int_1),
    .rxbufferr(mgt_rxbufferr_int_1),

    .loopback(mgt_loopback_1), .powerdown(DISABLE_1 ? 1'b1 : mgt_powerdown_1),
    .rxeqmix(mgt_rxeqmix_1), .rxeqpole(mgt_rxeqpole_1),
    .txpreemphasis(mgt_txpreemphasis_1), .txdiffctrl(mgt_txdiffctrl_1)
  );
  /*********************** XAUI Bank 2 *****************************/

  /* Reorder hack due to crossed RX pairs on ROACH hardware
   * When loopback is enable behaviour must transform as if 
   * RX lanes not crossed */
  wire [63:0] mgt_rxdata_int_2;
  assign mgt_rxdata_2 = mgt_loopback_2 ? mgt_rxdata_int_2 :
                        {mgt_rxdata_int_2[15:0],  mgt_rxdata_int_2[31:16], mgt_rxdata_int_2[47:32], mgt_rxdata_int_2[63:48]};

  wire [7:0] mgt_rxcharisk_int_2;
  assign mgt_rxcharisk_2 = mgt_loopback_2 ? mgt_rxcharisk_int_2 :
                           {mgt_rxcharisk_int_2[1:0], mgt_rxcharisk_int_2[3:2], mgt_rxcharisk_int_2[5:4], mgt_rxcharisk_int_2[7:6]};

  wire [7:0] mgt_code_comma_int_2;
  assign mgt_code_comma_2 = mgt_loopback_2 ? mgt_code_comma_int_2 :
                            {mgt_code_comma_int_2[1:0], mgt_code_comma_int_2[3:2], mgt_code_comma_int_2[5:4], mgt_code_comma_int_2[7:6]};

  wire [7:0] mgt_codevalid_int_2;
  assign mgt_codevalid_2 = mgt_loopback_2 ? mgt_codevalid_int_2 :
                           {mgt_codevalid_int_2[1:0], mgt_codevalid_int_2[3:2], mgt_codevalid_int_2[5:4], mgt_codevalid_int_2[7:6]};

  wire [3:0] mgt_enable_align_int_2 = mgt_loopback_2 ? mgt_enable_align_2 :
                                      {mgt_enable_align_2[0], mgt_enable_align_2[1], mgt_enable_align_2[2], mgt_enable_align_2[3]};

  wire [3:0] mgt_rxlock_int_2;
  assign mgt_rxlock_2 = mgt_loopback_2 ? mgt_rxlock_int_2 :
                        {mgt_rxlock_int_2[0], mgt_rxlock_int_2[1], mgt_rxlock_int_2[2], mgt_rxlock_int_2[3]};

  wire [3:0] mgt_syncok_int_2;
  assign mgt_syncok_2 = mgt_loopback_2 ? mgt_syncok_int_2 :
                        {mgt_syncok_int_2[0], mgt_syncok_int_2[1], mgt_syncok_int_2[2], mgt_syncok_int_2[3]};

  wire [3:0] mgt_rxbufferr_int_2;
  assign mgt_rxbufferr_2 = mgt_loopback_2 ? mgt_rxbufferr_int_2 :
                           {mgt_rxbufferr_int_2[0], mgt_rxbufferr_int_2[1], mgt_rxbufferr_int_2[2], mgt_rxbufferr_int_2[3]};

  transceiver_bank #(
    .TX_POLARITY_HACK(TX_POLARITY_HACK_2),
    .RX_POLARITY_HACK(RX_POLARITY_HACK_2),
    .DIFF_BOOST(DIFF_BOOST)
  ) transceiver_bank_2 (
    .reset(reset),
    .rx_reset(mgt_rx_reset_2),
    .tx_reset(mgt_tx_reset_2),
    .refclk(refclk_t), .refclk_ret(),
    .mgt_clk(mgt_clk_t),
    .mgt_clk_mult_2(mgt_clk_mult_2_t),
    .txp(mgt_tx_t0_p), .txn(mgt_tx_t0_n),
    .rxp(mgt_rx_t0_p), .rxn(mgt_rx_t0_n),
    .txdata(mgt_txdata_2),
    .txcharisk(mgt_txcharisk_2),
    .rxdata(mgt_rxdata_int_2),
    .rxcharisk(mgt_rxcharisk_int_2),
    .code_comma(mgt_code_comma_int_2),
    .enchansync(mgt_enchansync_2),
    .enable_align(mgt_enable_align_int_2),
    .rxlock(mgt_rxlock_int_2),
    .syncok(mgt_syncok_int_2),
    .codevalid(mgt_codevalid_int_2),
    .rxbufferr(mgt_rxbufferr_int_2),

    .loopback(mgt_loopback_2), .powerdown(DISABLE_2 ? 1'b1 : mgt_powerdown_2),
    .rxeqmix(mgt_rxeqmix_2), .rxeqpole(mgt_rxeqpole_2),
    .txpreemphasis(mgt_txpreemphasis_2), .txdiffctrl(mgt_txdiffctrl_2)
  );


  /*********************** XAUI Bank 3 *****************************/

  /* Reorder hack due to crossed RX pairs on ROACH hardware
   * When loopback is enable behaviour must transform as if 
   * RX lanes not crossed */
  wire [63:0] mgt_rxdata_int_3;
  assign mgt_rxdata_3 = mgt_loopback_3 ? mgt_rxdata_int_3 :
                        {mgt_rxdata_int_3[15:0],  mgt_rxdata_int_3[31:16], mgt_rxdata_int_3[47:32], mgt_rxdata_int_3[63:48]};

  wire [7:0] mgt_rxcharisk_int_3;
  assign mgt_rxcharisk_3 = mgt_loopback_3 ? mgt_rxcharisk_int_3 :
                           {mgt_rxcharisk_int_3[1:0], mgt_rxcharisk_int_3[3:2], mgt_rxcharisk_int_3[5:4], mgt_rxcharisk_int_3[7:6]};

  wire [7:0] mgt_code_comma_int_3;
  assign mgt_code_comma_3 = mgt_loopback_3 ? mgt_code_comma_int_3 :
                            {mgt_code_comma_int_3[1:0], mgt_code_comma_int_3[3:2], mgt_code_comma_int_3[5:4], mgt_code_comma_int_3[7:6]};

  wire [7:0] mgt_codevalid_int_3;
  assign mgt_codevalid_3 = mgt_loopback_3 ? mgt_codevalid_int_3 :
                           {mgt_codevalid_int_3[1:0], mgt_codevalid_int_3[3:2], mgt_codevalid_int_3[5:4], mgt_codevalid_int_3[7:6]};

  wire [3:0] mgt_enable_align_int_3 = mgt_loopback_3 ? mgt_enable_align_3 :
                                      {mgt_enable_align_3[0], mgt_enable_align_3[1], mgt_enable_align_3[2], mgt_enable_align_3[3]};

  wire [3:0] mgt_rxlock_int_3;
  assign mgt_rxlock_3 = mgt_loopback_3 ? mgt_rxlock_int_3 :
                        {mgt_rxlock_int_3[0], mgt_rxlock_int_3[1], mgt_rxlock_int_3[2], mgt_rxlock_int_3[3]};

  wire [3:0] mgt_syncok_int_3;
  assign mgt_syncok_3 = mgt_loopback_3 ? mgt_syncok_int_3 :
                        {mgt_syncok_int_3[0], mgt_syncok_int_3[1], mgt_syncok_int_3[2], mgt_syncok_int_3[3]};

  wire [3:0] mgt_rxbufferr_int_3;
  assign mgt_rxbufferr_3 = mgt_loopback_3 ? mgt_rxbufferr_int_3 :
                           {mgt_rxbufferr_int_3[0], mgt_rxbufferr_int_3[1], mgt_rxbufferr_int_3[2], mgt_rxbufferr_int_3[3]};


  transceiver_bank #(
    .TX_POLARITY_HACK(TX_POLARITY_HACK_3),
    .RX_POLARITY_HACK(RX_POLARITY_HACK_3),
    .DIFF_BOOST(DIFF_BOOST)
  ) transceiver_bank_3 (
    .reset(reset),
    .rx_reset(mgt_rx_reset_3),
    .tx_reset(mgt_tx_reset_3),
    .refclk(refclk_t), .refclk_ret(refclk_t_ret),
    .mgt_clk(mgt_clk_t),
    .mgt_clk_mult_2(mgt_clk_mult_2_t),
    .txp(mgt_tx_t1_p), .txn(mgt_tx_t1_n),
    .rxp(mgt_rx_t1_p), .rxn(mgt_rx_t1_n),
    .txdata(mgt_txdata_3),
    .txcharisk(mgt_txcharisk_3),
    .rxdata(mgt_rxdata_int_3),
    .rxcharisk(mgt_rxcharisk_int_3),
    .code_comma(mgt_code_comma_int_3),
    .enchansync(mgt_enchansync_3),
    .enable_align(mgt_enable_align_int_3),
    .rxlock(mgt_rxlock_int_3),
    .syncok(mgt_syncok_int_3),
    .codevalid(mgt_codevalid_int_3),
    .rxbufferr(mgt_rxbufferr_int_3),

    .loopback(mgt_loopback_3), .powerdown(DISABLE_3 ? 1'b1 : mgt_powerdown_3),
    .rxeqmix(mgt_rxeqmix_3), .rxeqpole(mgt_rxeqpole_3),
    .txpreemphasis(mgt_txpreemphasis_3), .txdiffctrl(mgt_txdiffctrl_3)
  );

endmodule
