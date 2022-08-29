`timescale 1ps/1ps
`default_nettype none

module gt_refclk_buf_wrapper (
  input wire logic gt_ref_clk_p,
  input wire logic gt_ref_clk_n,
  input wire logic gt_powergood,
  output logic gt_ref_clk,
  output logic gt_ref_clk_out
);

logic gt_ref_clk_int;

IBUFDS_GTE4 IBUFDS_GTE4_GTREFCLK_INST (
  .I(gt_ref_clk_p),
  .IB(gt_ref_clk_n),
  .CEB(1'b0),
  .O(gt_ref_clk),
  .ODIV2(gt_ref_clk_int)
);

BUFG_GT BUFG_GT_REFCLK_INST (
  .CE(gt_powergood),
  .CEMASK(1'b1),
  .CLR(1'b0),
  .CLRMASK(1'b1),
  .DIV(3'b000),
  .I(gt_ref_clk_int),
  .O(gt_ref_clk_out)
);

endmodule : gt_refclk_buf_wrapper

