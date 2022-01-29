`default_nettype none

module zcu216_clk_infrastructure #(
  parameter real PERIOD = 10.0,
  parameter MULTIPLY = 1,
  parameter DIVIDE   = 1,
  parameter DIVCLK   = 1
) (
  input wire logic pl_clk_n,
  input wire logic pl_clk_p,

  output logic adc_clk,
  output logic adc_clk90,
  output logic adc_clk180,
  output logic adc_clk270,
  output logic mmcm_locked
);

  logic pl_clk;
  logic pl_clk_buf;
  logic pl_clk_mmcm_fb;
  logic pl_clk_mmcm_fb_buf; // for deskew bufg instance to have known phase alignment relationship to input clk (UG572 v1.10 pg.39)
  logic pl_clk_mmcm, pl_clk_mmcm90, pl_clk_mmcm180, pl_clk_mmcm270;

  // diferential clock input
  IBUFDS i_clk (.I (pl_clk_p), .IB (pl_clk_n), .O (pl_clk));

  // TODO: This buffer may not be needed, but was added for placement by the tool to ease
  // routing to allow a HD CLK drive an MMCM...
  BUFGCE ibuf (.CE(1'b1), .I(pl_clk), .O(pl_clk_buf));

  MMCME4_BASE #(
    .BANDWIDTH          ("OPTIMIZED"), // Jitter programming ("HIGH","LOW","OPTIMIZED")
    .CLKFBOUT_MULT_F    (MULTIPLY),    // Multiply value for all CLKOUT (5.0-64.0).
    .CLKFBOUT_PHASE     (0.0),
    .CLKIN1_PERIOD      (PERIOD),      // real 0.968 to 100.0, resolution to ps.
    .CLKOUT0_DIVIDE_F   (DIVIDE),      // Divide amount for CLKOUT0 (1.000-128.000).
    .CLKOUT0_DUTY_CYCLE (0.5),
    .CLKOUT1_DUTY_CYCLE (0.5),
    .CLKOUT2_DUTY_CYCLE (0.5),
    .CLKOUT3_DUTY_CYCLE (0.5),
    .CLKOUT4_DUTY_CYCLE (0.5),
    .CLKOUT5_DUTY_CYCLE (0.5),
    .CLKOUT6_DUTY_CYCLE (0.5),
    .CLKOUT0_PHASE      (0.0),
    .CLKOUT1_PHASE      (90.0),
    .CLKOUT2_PHASE      (180.0),
    .CLKOUT3_PHASE      (270.0),
    .CLKOUT4_PHASE      (0.0),
    .CLKOUT5_PHASE      (0.0),
    .CLKOUT6_PHASE      (0.0),
    .CLKOUT1_DIVIDE     (DIVIDE),
    .CLKOUT2_DIVIDE     (DIVIDE),
    .CLKOUT3_DIVIDE     (DIVIDE),
    .CLKOUT4_DIVIDE     (1),
    .CLKOUT5_DIVIDE     (1),
    .CLKOUT6_DIVIDE     (1),
    .CLKOUT4_CASCADE    ("FALSE"),
    .DIVCLK_DIVIDE      (DIVCLK),      // Master division value (1-80)
    .REF_JITTER1        (0.0),
    .STARTUP_WAIT       ("FALSE")
  ) pl_clk_mmcm_inst (
    .CLKIN1   (pl_clk_buf),
    .CLKFBIN  (pl_clk_mmcm_fb_buf),
    .CLKFBOUT  (pl_clk_mmcm_fb),
    .CLKFBOUTB (),
    .CLKOUT0  (pl_clk_mmcm),
    .CLKOUT0B (),
    .CLKOUT1  (pl_clk_mmcm90),
    .CLKOUT1B (),
    .CLKOUT2  (pl_clk_mmcm180),
    .CLKOUT2B (),
    .CLKOUT3  (pl_clk_mmcm270),
    .CLKOUT3B (),
    .CLKOUT4  (),
    .CLKOUT5  (),
    .CLKOUT6  (),
    .LOCKED   (mmcm_locked),
    .PWRDWN   (1'b0),
    .RST      (1'b0)
  );

  // To have a known phase relationship to the input clock (phase alignment in multi-board
  // sync applications) we perform "clock deskew" as described in UG572 v1.10. "A clock output matching the reference
  // clock CLKIN frequency is connected to a clock buffer of the same type driving the logic and
  // fed back to CLKFBIN pin of the MMCM." A block diagram of the hardware instanced for clock
  // deskew is shown in Figure 3-9 on pg 59.

  // This is the important BUFG that is used on CLKFBOUT off the MMCM to deskew and provide
  // phased align between the input clock on CLKIN and the clock on the output of the BUFG
  // driving user logic
  BUFG bufg_fb_clk (
    .I(pl_clk_mmcm_fb),
    .O(pl_clk_mmcm_fb_buf)
  );

  // BUFG driving logic 
  BUFG bufg_adc_clk[3:0](
    .I({pl_clk_mmcm, pl_clk_mmcm90, pl_clk_mmcm180, pl_clk_mmcm270}),
    .O({adc_clk, adc_clk90, adc_clk180, adc_clk270})
  );
  
endmodule
