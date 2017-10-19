module tengbaser_infrastructure #(
  parameter USE_GTH = "FALSE"
  )(
  input           refclk_p,
  input           refclk_n,
  input           txclk322,
  output          dclk,
  output          core_clk156_out,
  input           reset,
  output          xgmii_rx_clk,
  output          qplloutclk_out,
  output          qplloutrefclk_out,
  output          qplllock_out,
  output          qpllreset,
  output          areset_clk156_out,
  output          txusrclk_out,
  output          txusrclk2_out,
  output          gttxreset_out,
  output          gtrxreset_out,
  output          txuserrdy_out,
  output          reset_counter_done_out
  //input pma_loopback,
  //input pma_reset,
  //input global_tx_disable,
  //input pcs_loopback,
  //input pcs_reset,
  //input [57:0] test_patt_a_b,
  //input data_patt_sel,
  //input test_patt_sel,
  //input rx_test_patt_en,
  //input tx_test_patt_en,
  //input prbs31_tx_en,
  //input prbs31_rx_en,
  //input set_pma_link_status,
  //input set_pcs_link_status,
  //input clear_pcs_status2,
  //input clear_test_patt_err_count,
  //output pma_link_status,
  //output rx_sig_det,
  //output pcs_rx_link_status,
  //output pcs_rx_locked,
  //output pcs_hiber,
  //output teng_pcs_rx_link_status,
  //output [279:272] pcs_err_block_count,
  //output [285:280] pcs_ber_count,
  //output pcs_rx_hiber_lh,
  //output pcs_rx_locked_ll,
  //output [303:288] pcs_test_patt_err_count,
  //output [7:0]    core_status,
  );

  // Signal declarations
  wire clk156;

  // Instantiate the 10GBASE-R Block Level

  tengbaser_support #( 
    .USE_GTH(USE_GTH)
  ) ten_gig_eth_pcs_pma_core_support_layer_i (
    .refclk_p(refclk_p),
    .refclk_n(refclk_n),
    .dclk(dclk),
    .txclk322(txclk322),
    .core_clk156_out(clk156),
    .reset(reset),
    .qplloutclk_out(qplloutclk_out),
    .qplloutrefclk_out(qplloutrefclk_out),
    .qplllock_out(qplllock_out),
    .qpllreset(qpllreset),
    .txusrclk_out(txusrclk_out),
    .txusrclk2_out(txusrclk2_out),
    .gttxreset_out(gttxreset_out),
    .gtrxreset_out(gtrxreset_out),
    .txuserrdy_out(txuserrdy_out),

    .areset_clk156_out(areset_clk156_out),
    .reset_counter_done_out(reset_counter_done_out)
  );

  assign core_clk156_out = clk156;

  ODDR #(
     .SRTYPE("ASYNC"),
     .DDR_CLK_EDGE("SAME_EDGE")
  ) rx_clk_ddr (
    .Q(xgmii_rx_clk),
    .D1(1'b0),
    .D2(1'b1),
    .C(clk156),
    .CE(1'b1),
    .R(1'b0),
    .S(1'b0)
  );



endmodule
