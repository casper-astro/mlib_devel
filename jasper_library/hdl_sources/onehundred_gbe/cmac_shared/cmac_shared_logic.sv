`timescale 1ps / 1ps

module cmac_shared_logic #(
  parameter N_COMMON=2
) (
  input wire logic       gt_ref_clk_p,
  input wire logic       gt_ref_clk_n,
  input wire logic       gt_txusrclk2,
  input wire logic       gt_rxusrclk2,
  output logic           gt_ref_clk_out,
  input wire logic       rx_clk,
  input wire logic       gt_powergood,
  input wire logic       gt_tx_reset_in,
  input wire logic       gt_rx_reset_in,
  input wire logic       core_drp_reset,
  input wire logic       core_tx_reset,
  output logic           tx_reset_out,
  input wire logic       core_rx_reset,
  output logic           rx_reset_out,
  output logic [9:0]           rx_serdes_reset_out,
  input wire logic [N_COMMON-1:0] qpll0reset,
  output logic [N_COMMON-1:0]     qpll0lock,
  output logic [N_COMMON-1:0]     qpll0outclk,
  output logic [N_COMMON-1:0]     qpll0outrefclk,
  input wire [N_COMMON-1:0]       qpll1reset,
  output logic [N_COMMON-1:0]     qpll1lock,
  output logic [N_COMMON-1:0]     qpll1outclk,
  output logic [N_COMMON-1:0]     qpll1outrefclk,
  output logic           usr_tx_reset,
  output logic           usr_rx_reset
);

logic gt_ref_clk;

gt_refclk_buf_wrapper gt_refclk_buf_inst (
  .gt_ref_clk_p(gt_ref_clk_p),
  .gt_ref_clk_n(gt_ref_clk_n),
  .gt_powergood(gt_powergood),
  .gt_ref_clk(gt_ref_clk),
  .gt_ref_clk_out(gt_ref_clk_out)
);

cmac_usplus_reset_wrapper cmac_reset_wrapper_inst (
  .gt_txusrclk2(gt_txusrclk2),
  .gt_rxusrclk2(gt_rxusrclk2),
  .rx_clk(rx_clk),
  .gt_tx_reset_in(gt_tx_reset_in),
  .gt_rx_reset_in(gt_rx_reset_in),
  .core_drp_reset(core_drp_reset),
  .core_tx_reset(core_tx_reset),
  .tx_reset_out(tx_reset_out),
  .core_rx_reset(core_rx_reset),
  .rx_reset_out(rx_reset_out),
  .rx_serdes_reset_out(rx_serdes_reset_out),
  .usr_tx_reset(usr_tx_reset),
  .usr_rx_reset(usr_rx_reset)
);

gt_usplus_gtye4_common_wrapper #(
  .N_COMMON(N_COMMON)
) gt_common_wrapper_inst (
  .refclk(gt_ref_clk),
  .qpll0reset(qpll0reset),
  .qpll0lock(qpll0lock),
  .qpll0outclk(qpll0outclk),
  .qpll0outrefclk(qpll0outrefclk),
  .qpll1reset(qpll1reset),
  .qpll1lock(qpll1lock),
  .qpll1outclk(qpll1outclk),
  .qpll1outrefclk(qpll1outrefclk)
);

endmodule : cmac_shared_logic

