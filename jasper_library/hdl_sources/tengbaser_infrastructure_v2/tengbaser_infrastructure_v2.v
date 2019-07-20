module tengbaser_infrastructure_v2 #(
  parameter USE_GTH = "FALSE"
  )(
  input           refclk_p,
  input           refclk_n,
  input           txclk322,
  input           reset,
  output          core_clk156_out,
  output          core_clk,
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
//  input pma_loopback,
//  input pma_reset,
//  input global_tx_disable,
//  input pcs_loopback,
//  input pcs_reset,
//  input [57:0] test_patt_a_b,
//  input data_patt_sel,
//  input test_patt_sel,
//  input rx_test_patt_en,
//  input tx_test_patt_en,
//  input prbs31_tx_en,
//  input prbs31_rx_en,
//  input set_pma_link_status,
//  input set_pcs_link_status,
//  input clear_pcs_status2,
//  input clear_test_patt_err_count,
//  output pma_link_status,
//  output rx_sig_det,
//  output pcs_rx_link_status,
//  output pcs_rx_locked,
//  output pcs_hiber,
//  output teng_pcs_rx_link_status,
//  output [279:272] pcs_err_block_count,
//  output [285:280] pcs_ber_count,
//  output pcs_rx_hiber_lh,
//  output pcs_rx_locked_ll,
//  output [303:288] pcs_test_patt_err_count,
//  output [7:0]    core_status,
//  output          resetdone,
//  input           signal_detect,
//  input           tx_fault,
//  output          tx_disable,
//  input   [2:0] pma_pmd_type
);

  // Signal declarations
  wire areset_datapathclk_out;

//  reg [63:0] xgmii_txd_reg = 63'b0;
//  reg [7:0] xgmii_txc_reg = 8'b0;
//  wire [63:0] xgmii_rxd_int;
//  wire [7:0] xgmii_rxc_int;
//  wire dclk_buf;
//   wire [535:0] configuration_vector;
//   wire [447:0] status_vector;

//   assign configuration_vector[0]   = pma_loopback;
//   assign configuration_vector[14:1] = 0;
//   assign configuration_vector[15]  = pma_reset;
//   assign configuration_vector[16]  = global_tx_disable;
//   assign configuration_vector[79:17] = 0;
//   assign configuration_vector[83:80] = 0;
//   assign configuration_vector[109:84] = 0;
//   assign configuration_vector[110] = pcs_loopback;
//   assign configuration_vector[111] = pcs_reset;
//   assign configuration_vector[169:112] = test_patt_a_b;
//   assign configuration_vector[175:170] = 0;
//   assign configuration_vector[233:176] = test_patt_a_b;
//   assign configuration_vector[239:234] = 0;
//   assign configuration_vector[240] = data_patt_sel;
//   assign configuration_vector[241] = test_patt_sel;
//   assign configuration_vector[242] = rx_test_patt_en;
//   assign configuration_vector[243] = tx_test_patt_en;
//   assign configuration_vector[244] = prbs31_tx_en;
//   assign configuration_vector[245] = prbs31_rx_en;
//   assign configuration_vector[269:246] = 0;
//   assign configuration_vector[271:270] = 0;
//   assign configuration_vector[383:272] = 0;
//   assign configuration_vector[399:384] = 16'h4C4B;
//   assign configuration_vector[511:400] = 0;
//   assign configuration_vector[512] = set_pma_link_status;
//   assign configuration_vector[515:513] = 0;
//   assign configuration_vector[516] = set_pcs_link_status;
//   assign configuration_vector[517] = 0;
//   assign configuration_vector[518] = clear_pcs_status2;
//   assign configuration_vector[519] = clear_test_patt_err_count;
//   assign configuration_vector[535:520] = 0;

//   assign pma_link_status = status_vector[18];
//   assign rx_sig_det = status_vector[48];
//   assign pcs_rx_link_status = status_vector[226];
//   assign pcs_rx_locked = status_vector[256];
//   assign pcs_hiber = status_vector[257];
//   assign teng_pcs_rx_link_status = status_vector[268];
//   assign pcs_err_block_count = status_vector[279:272];
//   assign pcs_ber_count = status_vector[285:280];
//   assign pcs_rx_hiber_lh = status_vector[286];
//   assign pcs_rx_locked_ll = status_vector[287];
//   assign pcs_test_patt_err_count = status_vector[303:288];


  // Add a pipeline to the xmgii_tx inputs, to aid timing closure
//  always @(posedge txusrclk2_out)
//  begin
//    xgmii_txd_reg <= xgmii_txd;
//    xgmii_txc_reg <= xgmii_txc;
//  end

//  // Add a pipeline to the xmgii_rx outputs, to aid timing closure
//  always @(posedge txusrclk2_out)
//  begin
//    xgmii_rxd <= xgmii_rxd_int;
//    xgmii_rxc <= xgmii_rxc_int;
//  end



//  BUFG dclk_bufg_i
//  (
//      .I (dclk),
//      .O (dclk_buf)
//  );

  // Instantiate the 10GBASE-R Block Level

  tengbaser_support_v2 ten_gig_eth_pcs_pma_core_support_layer_i
    (
    .refclk_p(refclk_p),
    .refclk_n(refclk_n),
    .reset(reset),
    .coreclk(core_clk),
    .qplloutclk_out(qplloutclk_out),
    .qplloutrefclk_out(qplloutrefclk_out),
    .qplllock_out(qplllock_out),
    .txusrclk_out(txusrclk_out),
    .txusrclk2_out(txusrclk2_out),
    .gttxreset_out(gttxreset_out),
    .gtrxreset_out(gtrxreset_out),
    .txuserrdy_out(txuserrdy_out),
    .areset_datapathclk_out(areset_datapathclk_out),
    .areset_coreclk_out(areset_clk156_out),
    .reset_counter_done_out(reset_counter_done_out),
    .txclk322(txclk322),
    .qpllreset(qpllreset)
    );

  assign core_clk156_out = txusrclk2_out;



  OSERDESE3 #(
    .DATA_WIDTH(8)
   )
   rx_clk_ddr (
    .OQ(xgmii_rx_clk), // 1-bit output: Serial Output Data
    .T_OUT(), // 1-bit output: 3-state control output to IOB
    .CLK(txusrclk2_out), // 1-bit input: High-speed clock
    .CLKDIV(txusrclk2_out), // 1-bit input: Divided Clock
    .D(8'b10101010), // 8-bit input: Parallel Data Input
    .RST(1'b0), // 1-bit input: Asynchronous Reset
    .T(1'b0) // 1-bit input: Tristate input from fabric
    );



endmodule
