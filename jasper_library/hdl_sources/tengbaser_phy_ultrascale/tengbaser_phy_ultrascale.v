module tengbaser_phy_ultrascale (
//// GT_0 Signals
  gt_rxp_in_0,
  gt_rxn_in_0,
  gt_txp_out_0,
  gt_txn_out_0,
  tx_mii_clk_0,
  rx_core_clk_0,
  rx_clk_out_0,
  gt_loopback_in_0,
//// RX_0 Signals
  rx_reset_0,
  rxrecclkout_0,
//// RX_0 User Interface  Signals
  rx_mii_d_0,
  rx_mii_c_0,


//// RX_0 Control Signals
  ctl_rx_test_pattern_0,
  ctl_rx_test_pattern_enable_0,
  ctl_rx_data_pattern_select_0,
  ctl_rx_prbs31_test_pattern_enable_0,



//// RX_0 Stats Signals
  stat_rx_block_lock_0,
  stat_rx_framing_err_valid_0,
  stat_rx_framing_err_0,
  stat_rx_hi_ber_0,
  stat_rx_valid_ctrl_code_0,
  stat_rx_bad_code_0,
  stat_rx_bad_code_valid_0,
  stat_rx_error_valid_0,
  stat_rx_error_0,
  stat_rx_fifo_error_0,
  stat_rx_local_fault_0,
  stat_rx_status_0,



//// TX_0 Signals
  tx_reset_0,

//// TX_0 User Interface  Signals
  tx_mii_d_0,
  tx_mii_c_0,

//// TX_0 Control Signals
  ctl_tx_test_pattern_0,
  ctl_tx_test_pattern_enable_0,
  ctl_tx_test_pattern_select_0,
  ctl_tx_data_pattern_select_0,
  ctl_tx_test_pattern_seed_a_0,
  ctl_tx_test_pattern_seed_b_0,
  ctl_tx_prbs31_test_pattern_enable_0,


//// TX_0 Stats Signals
  stat_tx_local_fault_0,








  gtpowergood_out_0,
  txoutclksel_in_0,
  rxoutclksel_in_0,

  rx_serdes_reset_0,
  gt_reset_all_in_0,
  gt_tx_reset_in_0,
  gt_rx_reset_in_0,
  gt_reset_tx_done_out_0,
  gt_reset_rx_done_out_0,


  qpll0clk_in,
  qpll0refclk_in,
  qpll1clk_in,
  qpll1refclk_in,
  gtwiz_reset_qpll0lock_in,
  gtwiz_reset_qpll1lock_in,
  gtwiz_reset_qpll0reset_out,
  gtwiz_reset_qpll1reset_out,

  sys_reset,
  dclk
);
  input  wire gt_rxp_in_0;
  input  wire gt_rxn_in_0;
  output wire gt_txp_out_0;
  output wire gt_txn_out_0;
  output wire tx_mii_clk_0;
  input  wire rx_core_clk_0;
  output wire rx_clk_out_0;
  input  wire [2:0] gt_loopback_in_0;
//// RX_0 Signals
  input  wire rx_reset_0;
  output wire rxrecclkout_0;
//// RX_0 User Interface Signals
  output wire [63:0] rx_mii_d_0;
  output wire [7:0] rx_mii_c_0;



//// RX_0 Control Signals
  input  wire ctl_rx_test_pattern_0;
  input  wire ctl_rx_test_pattern_enable_0;
  input  wire ctl_rx_data_pattern_select_0;
  input  wire ctl_rx_prbs31_test_pattern_enable_0;



//// RX_0 Stats Signals
  output wire stat_rx_block_lock_0;
  output wire stat_rx_framing_err_valid_0;
  output wire stat_rx_framing_err_0;
  output wire stat_rx_hi_ber_0;
  output wire stat_rx_valid_ctrl_code_0;
  output wire stat_rx_bad_code_0;
  output wire stat_rx_bad_code_valid_0;
  output wire stat_rx_error_valid_0;
  output wire [7:0] stat_rx_error_0;
  output wire stat_rx_fifo_error_0;
  output wire stat_rx_local_fault_0;
    output wire  stat_rx_status_0;


//// TX_0 Signals
  input  wire tx_reset_0;

//// TX_0 User Interface Signals
  input  wire [63:0] tx_mii_d_0;
  input  wire [7:0] tx_mii_c_0;

//// TX_0 Control Signals
  input  wire ctl_tx_test_pattern_0;
  input  wire ctl_tx_test_pattern_enable_0;
  input  wire ctl_tx_test_pattern_select_0;
  input  wire ctl_tx_data_pattern_select_0;
  input  wire [57:0] ctl_tx_test_pattern_seed_a_0;
  input  wire [57:0] ctl_tx_test_pattern_seed_b_0;
  input  wire ctl_tx_prbs31_test_pattern_enable_0;


//// TX_0 Stats Signals
  output wire stat_tx_local_fault_0;





  output wire gtpowergood_out_0;
  input wire [2:0] txoutclksel_in_0;
  input wire [2:0] rxoutclksel_in_0;

  input  wire rx_serdes_reset_0;
  input  wire gt_reset_all_in_0;
  input  wire gt_tx_reset_in_0;
  input  wire gt_rx_reset_in_0;
  output wire gt_reset_tx_done_out_0;
  output wire gt_reset_rx_done_out_0;
  input  wire sys_reset;
  input  wire dclk;

  input  wire [0:0] qpll0clk_in;
  input  wire [0:0] qpll0refclk_in;
  input  wire [0:0] qpll1clk_in;
  input  wire [0:0] qpll1refclk_in;
  input  wire [0:0] gtwiz_reset_qpll0lock_in;
  input  wire [0:0] gtwiz_reset_qpll1lock_in;
  output wire [0:0] gtwiz_reset_qpll0reset_out;
  output wire [0:0] gtwiz_reset_qpll1reset_out;


  tengbaser_phy_ultrascale_wrapper #(
    .C_LINE_RATE(10),
    .C_NUM_OF_CORES(1),
    .C_CLOCKING("Asynchronous"),
    .C_DATA_PATH_INTERFACE("MII"),
    .C_BASE_R_KR("BASE-R"),
    .C_INCLUDE_FEC_LOGIC(0),
    .C_INCLUDE_RSFEC_LOGIC(0),
    .C_INCLUDE_AUTO_NEG_LT_LOGIC("None"),
    .C_INCLUDE_USER_FIFO("0"),
    .C_ENABLE_TX_FLOW_CONTROL_LOGIC(0),
    .C_ENABLE_RX_FLOW_CONTROL_LOGIC(0),
    .C_ENABLE_TIME_STAMPING(0),
    .C_PTP_OPERATION_MODE(2),
    .C_PTP_CLOCKING_MODE(0),
    .C_TX_LATENCY_ADJUST(0),
    .C_ENABLE_VLANE_ADJUST_MODE(0),
    .C_ENABLE_PIPELINE_REG(0),
    .C_RUNTIME_SWITCH(0)
  ) inst (
    .gt_rxp_in_0 (gt_rxp_in_0),
    .gt_rxn_in_0 (gt_rxn_in_0),
    .gt_txp_out_0 (gt_txp_out_0),
    .gt_txn_out_0 (gt_txn_out_0),

    .tx_mii_clk_0 (tx_mii_clk_0),
    .rx_core_clk_0 (rx_core_clk_0),
    .rx_clk_out_0 (rx_clk_out_0),

    .gt_loopback_in_0 (gt_loopback_in_0),

    .rx_reset_0(rx_reset_0),
    .rxrecclkout_0 (rxrecclkout_0),
//// RX User Interface Signals
    .rx_mii_d_0 (rx_mii_d_0),
    .rx_mii_c_0 (rx_mii_c_0),



//// RX Control Signals
    .ctl_rx_test_pattern_0 (ctl_rx_test_pattern_0),
    .ctl_rx_test_pattern_enable_0 (ctl_rx_test_pattern_enable_0),
    .ctl_rx_data_pattern_select_0 (ctl_rx_data_pattern_select_0),
    .ctl_rx_prbs31_test_pattern_enable_0 (ctl_rx_prbs31_test_pattern_enable_0),



//// RX Stats Signals
    .stat_rx_block_lock_0 (stat_rx_block_lock_0),
    .stat_rx_framing_err_valid_0 (stat_rx_framing_err_valid_0),
    .stat_rx_framing_err_0 (stat_rx_framing_err_0),
    .stat_rx_hi_ber_0 (stat_rx_hi_ber_0),
    .stat_rx_valid_ctrl_code_0 (stat_rx_valid_ctrl_code_0),
    .stat_rx_bad_code_0 (stat_rx_bad_code_0),
    .stat_rx_bad_code_valid_0 (stat_rx_bad_code_valid_0),
    .stat_rx_error_valid_0 (stat_rx_error_valid_0),
    .stat_rx_error_0 (stat_rx_error_0),
    .stat_rx_fifo_error_0 (stat_rx_fifo_error_0),
    .stat_rx_local_fault_0 (stat_rx_local_fault_0),
   .stat_rx_status_0 (stat_rx_status_0),


    .tx_reset_0(tx_reset_0),
//// TX User Interface Signals
    .tx_mii_d_0 (tx_mii_d_0),
    .tx_mii_c_0 (tx_mii_c_0),

//// TX Control Signals
    .ctl_tx_test_pattern_0 (ctl_tx_test_pattern_0),
    .ctl_tx_test_pattern_enable_0 (ctl_tx_test_pattern_enable_0),
    .ctl_tx_test_pattern_select_0 (ctl_tx_test_pattern_select_0),
    .ctl_tx_data_pattern_select_0 (ctl_tx_data_pattern_select_0),
    .ctl_tx_test_pattern_seed_a_0 (ctl_tx_test_pattern_seed_a_0),
    .ctl_tx_test_pattern_seed_b_0 (ctl_tx_test_pattern_seed_b_0),
    .ctl_tx_prbs31_test_pattern_enable_0 (ctl_tx_prbs31_test_pattern_enable_0),


//// TX Stats Signals
    .stat_tx_local_fault_0 (stat_tx_local_fault_0),



    .gtpowergood_out_0 (gtpowergood_out_0),
    .txoutclksel_in_0 (txoutclksel_in_0),
    .rxoutclksel_in_0 (rxoutclksel_in_0),
    .rx_serdes_reset_0 (rx_serdes_reset_0),
    .gt_reset_all_in_0 (gt_reset_all_in_0),
    .gt_tx_reset_in_0 (gt_tx_reset_in_0),
    .gt_rx_reset_in_0 (gt_rx_reset_in_0),
    .gt_reset_tx_done_out_0 (gt_reset_tx_done_out_0),
    .gt_reset_rx_done_out_0(gt_reset_rx_done_out_0),
    .qpll0clk_in (qpll0clk_in),
    .qpll0refclk_in (qpll0refclk_in),
    .qpll1clk_in (qpll1clk_in),
    .qpll1refclk_in (qpll1refclk_in),
    .gtwiz_reset_qpll0lock_in (gtwiz_reset_qpll0lock_in),
    .gtwiz_reset_qpll1lock_in (gtwiz_reset_qpll1lock_in),
    .gtwiz_reset_qpll0reset_out (gtwiz_reset_qpll0reset_out),
    .gtwiz_reset_qpll1reset_out (gtwiz_reset_qpll1reset_out),
    .sys_reset (sys_reset),
    .dclk (dclk)

  );
endmodule



