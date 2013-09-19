module roach_infrastructure #(
    parameter CLK_FREQ     = 100, 
    parameter CLK_HIGH_LOW = "low", // high >= 135, low < 135
    parameter MULTIPLY     = 6,
    parameter DIVIDE       = 6,
    parameter DIVCLK       = 1
  )  (
    input  sys_clk_n,    sys_clk_p,
    output sys_clk,      sys_clk90,       sys_clk180,   sys_clk270,
    output sys_clk2x,    sys_clk2x90,     sys_clk2x180, sys_clk2x270,
    output sys_clk_lock, op_power_on_rst,
    //dly_clk_n,  dly_clk_p,
    //dly_clk,
    input  epb_clk_in,
    output epb_clk,
    input  idelay_rst, 
    output idelay_rdy,
    input  aux_clk_n,  aux_clk_p,
    output aux_clk,    aux_clk90,   aux_clk180,   aux_clk270,
    output aux_clk2x,  aux_clk2x90, aux_clk2x180, aux_clk2x270,
    output clk_100, clk_200
  );


  /* EPB Clk */

  wire epb_clk_int;
  IBUFG ibuf_epb(
    .I(epb_clk_in),
    .O(epb_clk_int)
  );

  BUFG bufg_epb(
    .I(epb_clk_int),
    .O(epb_clk)
  );


  /* system clock */
  wire  sys_clk_int;
  wire  sys_clk_mmcm_locked;
  wire  sys_clk_fb_int;
  wire  sys_clk_fb;

  wire  sys_clk2x_mmcm;
  wire  sys_clk2x90_mmcm;
  wire  sys_clk_mmcm;
  wire  sys_clk180_mmcm;
  wire  sys_clk2x180_mmcm;
  wire  sys_clk90_mmcm;
  wire  sys_clk270_mmcm;
  wire  sys_clk2x270_mmcm;

  /* Aux clocks */ 
  wire  aux_clk_int;
  wire  aux_clk_mmcm_locked;
  wire  aux_clk_fb_int;
  wire  aux_clk_fb;

  wire  aux_clk_mmcm;
  wire  aux_clk90_mmcm;
  wire  aux_clk180_mmcm;
  wire  aux_clk270_mmcm;
  wire  aux_clk2x_mmcm;
  wire  aux_clk2x90_mmcm;
  wire  aux_clk2x180_mmcm;
  wire  aux_clk2x270_mmcm;

  wire  mmcm_reset;

 /* 200MHz clock for idelayctrl */
  wire clk_200_mmcm;
 /* 100MHz clock for ddr3 clk */
 //wire clk_100_mmcm;

  // sys_clk diff buffer
  IBUFGDS #(
    .IOSTANDARD ("LVDS_25"),
    .DIFF_TERM  ("TRUE")
  ) ibufgd_sys (
    .I (sys_clk_p),
    .IB(sys_clk_n),
    .O (sys_clk_int)
  );

  // aux_clk diff buffer
  IBUFGDS #(
    .IOSTANDARD ("LVDS_25"),
    .DIFF_TERM  ("TRUE")
  ) ibufgd_aux_arr (
    .I  (aux_clk_p),
    .IB (aux_clk_n),
    .O  (aux_clk_int)
  );

  // sys_clk mmcm
  MMCM_BASE #(
    .BANDWIDTH          ("low"), // Jitter programming ("HIGH","LOW","OPTIMIZED")
    .CLKFBOUT_MULT_F    (MULTIPLY), // Multiply value for all CLKOUT (5.0-64.0). THIS IS THE MULTIPLIER
    .CLKFBOUT_PHASE     (0.0),
    .CLKIN1_PERIOD      (1000.0/100),
    .CLKOUT0_DIVIDE_F   (MULTIPLY/DIVCLK/2.0), // Divide amount for CLKOUT0 (1.000-128.000).
    .CLKOUT0_DUTY_CYCLE (0.5),
    .CLKOUT1_DUTY_CYCLE (0.5),
    .CLKOUT2_DUTY_CYCLE (0.5),
    .CLKOUT3_DUTY_CYCLE (0.5),
    .CLKOUT4_DUTY_CYCLE (0.5),
    .CLKOUT5_DUTY_CYCLE (0.5),
    .CLKOUT6_DUTY_CYCLE (0.5),
    .CLKOUT0_PHASE      (0.0),
    .CLKOUT1_PHASE      (0.0),
    .CLKOUT2_PHASE      (90.0),
    .CLKOUT3_PHASE      (180.0),
    .CLKOUT4_PHASE      (270.0),
    .CLKOUT5_PHASE      (0.0),
    .CLKOUT6_PHASE      (0.0),
    .CLKOUT1_DIVIDE     (DIVIDE), //THIS IS THE DIVISOR
    .CLKOUT2_DIVIDE     (DIVIDE),
    .CLKOUT3_DIVIDE     (DIVIDE),
    .CLKOUT4_DIVIDE     (DIVIDE),
    .CLKOUT5_DIVIDE     (DIVIDE/2),//(MULTIPLY/DIVCLK/2)
    .CLKOUT6_DIVIDE     (MULTIPLY/DIVCLK),
    .CLKOUT4_CASCADE    ("FALSE"),
    .CLOCK_HOLD         ("FALSE"),
    .DIVCLK_DIVIDE      (DIVCLK), // Master division value (1-80)
    .REF_JITTER1        (0.0),
    .STARTUP_WAIT       ("FALSE")
  ) MMCM_BASE_sys_clk (
    .CLKIN1    (sys_clk_int),
    .CLKFBIN   (sys_clk_fb),
    .CLKFBOUT  (sys_clk_fb_int),
    .CLKFBOUTB (),
    
    .CLKOUT0   (clk_200_mmcm),
    .CLKOUT0B  (),
    .CLKOUT1   (sys_clk_mmcm),
    .CLKOUT2   (sys_clk90_mmcm),
    .CLKOUT3   (sys_clk180_mmcm),
    .CLKOUT4   (sys_clk270_mmcm),
    .CLKOUT5   (),//(sys_clk2x_mmcm),
    .CLKOUT6   (clk_100),//(ddr3_clk),
    .LOCKED    (sys_clk_mmcm_locked),
    
    .PWRDWN    (1'b0),
    .RST       (mmcm_reset)
  );
  
  BUFG bufg_sys_clk[4:0](
    .I({sys_clk_mmcm, sys_clk90_mmcm, sys_clk_fb_int, sys_clk180_mmcm, sys_clk270_mmcm}),
    .O({sys_clk,      sys_clk90,      sys_clk_fb    , sys_clk180     , sys_clk270})
  );

//  BUFG bufg_sys_clk[3:0](
//    .I({sys_clk_mmcm, sys_clk90_mmcm, sys_clk180_mmcm, sys_clk270_mmcm}),
//    .O({sys_clk,      sys_clk90, sys_clk180     , sys_clk270})
//  );

//  // All of these I signals are undriven and should probably be deleted.
//  BUFG bufg_sys_clk2x[3:0](
//    .I({sys_clk2x_mmcm, sys_clk2x90_mmcm, sys_clk2x180_mmcm, sys_clk2x270_mmcm}),
//    .O({sys_clk2x,      sys_clk2x90     , sys_clk2x180     , sys_clk2x270})
//  );
  
//  BUFG bufg_clk_100(
//    .I(clk_100_mmcm),
//    .O(clk_100)
//  );

 BUFG bufg_clk_200(
    .I(clk_200_mmcm),
    .O(clk_200)
  );

  // Since sys_clk2c_mmcm is undriven, just drive sys_clk2x from clk_200.
  assign sys_clk2x = clk_200;

  // sys_clk2x{90,180,270} have "always"(?) been undriven on ROACH2.  Why do
  // we still carry them around as if they are real signals?
  assign sys_clk2x90  = 1'b0;
  assign sys_clk2x180 = 1'b0;
  assign sys_clk2x270 = 1'b0;

  MMCM_BASE #(
    .BANDWIDTH          (CLK_HIGH_LOW), // Jitter programming ("HIGH","LOW","OPTIMIZED")
    .CLKFBOUT_MULT_F    (6), // Multiply value for all CLKOUT (5.0-64.0). THIS IS THE MULTIPLIER
    .CLKFBOUT_PHASE     (0.0),
    .CLKIN1_PERIOD      (1000.0/CLK_FREQ),
    .CLKOUT0_DIVIDE_F   (6), // Divide amount for CLKOUT0 (1.000-128.000).
    .CLKOUT0_DUTY_CYCLE (0.5),
    .CLKOUT1_DUTY_CYCLE (0.5),
    .CLKOUT2_DUTY_CYCLE (0.5),
    .CLKOUT3_DUTY_CYCLE (0.5),
    .CLKOUT4_DUTY_CYCLE (0.5),
    .CLKOUT5_DUTY_CYCLE (0.5),
    .CLKOUT6_DUTY_CYCLE (0.5),
    .CLKOUT0_PHASE      (0.0),
    .CLKOUT1_PHASE      (0.0),
    .CLKOUT2_PHASE      (90.0),
    .CLKOUT3_PHASE      (0.0),
    .CLKOUT4_PHASE      (0.0),
    .CLKOUT5_PHASE      (0.0),
    .CLKOUT6_PHASE      (0.0),
    .CLKOUT1_DIVIDE     (6), //THIS IS THE DIVISOR
    .CLKOUT2_DIVIDE     (6),
    .CLKOUT3_DIVIDE     (6),
    .CLKOUT4_DIVIDE     (6),
    .CLKOUT5_DIVIDE     (6),
    .CLKOUT6_DIVIDE     (6),
    .CLKOUT4_CASCADE    ("FALSE"),
    .CLOCK_HOLD         ("FALSE"),
    .DIVCLK_DIVIDE      (1), // Master division value (1-80)
    .REF_JITTER1        (0.0),
    .STARTUP_WAIT       ("FALSE")
  ) MMCM_BASE_aux_clk (
    .CLKIN1    (aux_clk_int),
    .CLKFBIN   (aux_clk_fb),
    .CLKFBOUT  (aux_clk_fb_int),
    .CLKFBOUTB (),
    
    .CLKOUT0   (),
    .CLKOUT0B  (),
    .CLKOUT1   (aux_clk_mmcm),
    .CLKOUT1B  (aux_clk180_mmcm),
    .CLKOUT2   (aux_clk90_mmcm),
    .CLKOUT2B  (aux_clk270_mmcm),
    .CLKOUT3   (),
    .CLKOUT3B  (),
    .CLKOUT4   (),
    .CLKOUT5   (),
    .CLKOUT6   (aux_ddr3_clk),
    .LOCKED    (aux_clk_mmcm_locked),
    
    .PWRDWN    (1'b0),
    .RST       (mmcm_reset)
  );

  BUFG bufg_aux_clk[4:0](
    .I({aux_clk_mmcm, aux_clk90_mmcm, aux_clk_fb_int, aux_clk180_mmcm, aux_clk270_mmcm}),
    .O({aux_clk,      aux_clk90,      aux_clk_fb    , aux_clk180     , aux_clk270})
  );

  assign op_power_on_rst = ~sys_clk_mmcm_locked;
  assign mmcm_reset = 1'b0;
  assign sys_clk_lock = sys_clk_mmcm_locked;


  /* Delay Clock */
  /*wire dly_clk_int;
  IBUFDS ibufds_dly_clk(
    .I (dly_clk_p),
    .IB(dly_clk_n),
    .O (dly_clk_int)
  );*/

  /*BUFG bufg_inst(
    .I(dly_clk_int),
    .O(dly_clk)
  );*/
 
  IDELAYCTRL idelayctrl_inst(
    .REFCLK (clk_200),
    .RST    (idelay_rst),
    .RDY    (idelay_rdy)
  );

endmodule
