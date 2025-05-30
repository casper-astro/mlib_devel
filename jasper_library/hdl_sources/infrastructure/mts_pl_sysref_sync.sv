`timescale 1ns/1ps
`default_nettype none 

module mts_pl_sysref_sync #(
  parameter SYNC_FFS=3,
  parameter ADC_SYSREF = 1,
  parameter DAC_SYSREF = 0
) (
  input wire logic pl_sysref_p,
  input wire logic pl_sysref_n,
  input wire logic pl_clk,
  output wire user_sysref_adc,
  output wire user_sysref_dac
);

  wire pl_sysref;
  wire user_sysref;

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
    .dest_out(user_sysref),
    .dest_clk(pl_clk),
    .src_clk(1'b0),
    .src_in(pl_sysref)
  );

  generate
    if (ADC_SYSREF) begin : gen_adc_sysref
      assign user_sysref_adc = user_sysref;
    end else begin
      assign user_sysref_adc = 1'b0;
    end
  endgenerate

  generate
    if (DAC_SYSREF) begin : gen_dac_sysref
      assign user_sysref_dac = user_sysref;
    end else begin
      assign user_sysref_dac = 1'b0;
    end
  endgenerate

endmodule : mts_pl_sysref_sync


