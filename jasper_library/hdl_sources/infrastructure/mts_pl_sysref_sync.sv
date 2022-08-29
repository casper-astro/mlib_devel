`timescale 1ns/1ps
`default_nettype none 

module mts_pl_sysref_sync #(
  parameter SYNC_FFS=3
) (
  input wire logic pl_sysref_p,
  input wire logic pl_sysref_n,
  input wire logic pl_clk,
  output wire user_sysref_adc
);

  wire pl_sysref;

  IBUFDS #(
    .DQS_BIAS("FALSE")
  ) IBUFDS_inst (
    .O(pl_sysref),
    .I(pl_sysref_p),
    .IB(pl_sysref_n)
  );

  xpm_cdc_single #(
    .DEST_SYNC_FF(SYNC_FFS),
    .INIT_SYNC_FF(1),       // enable simulation init values
    .SIM_ASSERT_CHK(1),     // enable simulation messages
    .SRC_INPUT_REG(0)       // do not register the input
  ) cdc_inst (
    .dest_out(user_sysref_adc),
    .dest_clk(pl_clk),
    .src_clk(1'b0),
    .src_in(pl_sysref)
  );

endmodule : mts_pl_sysref_sync


