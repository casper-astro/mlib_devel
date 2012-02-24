module roach_infrastructure(
    sys_clk_n, sys_clk_p,
    sys_clk, sys_clk90, sys_clk180, sys_clk270,
    sys_clk_lock,
    sys_clk2x, sys_clk2x90, sys_clk2x180, sys_clk2x270,
    ///dly_clk_n,  dly_clk_p,
    //dly_clk,
    epb_clk_in,
    epb_clk,
    idelay_rst, idelay_rdy,
    aux_clk_n, aux_clk_p,
    aux_clk, aux_clk90, aux_clk180, aux_clk270,
    aux_clk2x, aux_clk2x90, aux_clk2x180, aux_clk2x270
    
  );

  parameter CLK_FREQ = 100;

  input  sys_clk_n, sys_clk_p;
  output sys_clk, sys_clk90, sys_clk180, sys_clk270;
  output sys_clk_lock;
  output sys_clk2x, sys_clk2x90, sys_clk2x180, sys_clk2x270;
  //input  dly_clk_n, dly_clk_p;
  //output dly_clk;
  input  epb_clk_in;
  output epb_clk;
  input  aux_clk_n, aux_clk_p;
  output aux_clk, aux_clk90, aux_clk180, aux_clk270;
  output aux_clk2x, aux_clk2x90, aux_clk2x180, aux_clk2x270;

  input  idelay_rst;
  output idelay_rdy;


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
  wire  sys_clk_mmcm, sys_clk90_mmcm;
  wire  sys_clk_fb_out;

  wire  sys_clk2x_int;
  wire  sys_clk2x_buf;
  wire  sys_clk2x_mmcm;
  wire  sys_clk2x90_mmcm;

  IBUFGDS #(
    .IOSTANDARD ("LVDS_25"),
    .DIFF_TERM  ("TRUE")
  ) ibufgd_sys (
    .I (sys_clk_p),
    .IB(sys_clk_n),
    .O (sys_clk_int)
  );


  MMCM_BASE #(
    .BANDWIDTH          ("OPTIMIZED"), // Jitter programming ("HIGH","LOW","OPTIMIZED")
    .CLKFBOUT_MULT_F    (6), // Multiply value for all CLKOUT (5.0-64.0). THIS IS THE MULTIPLIER
    .CLKFBOUT_PHASE     (0.0),
    .CLKIN1_PERIOD      (10),
    .CLKOUT0_DIVIDE_F   (1), // Divide amount for CLKOUT0 (1.000-128.000).
    .CLKOUT0_DUTY_CYCLE (0.5),
    .CLKOUT1_DUTY_CYCLE (0.5),
    .CLKOUT2_DUTY_CYCLE (0.5),
    .CLKOUT3_DUTY_CYCLE (0.5),
    .CLKOUT4_DUTY_CYCLE (0.5),
    .CLKOUT5_DUTY_CYCLE (0.5),
    .CLKOUT6_DUTY_CYCLE (0.5),
    .CLKOUT0_PHASE      (0.0),
    .CLKOUT1_PHASE      (0.0),
    .CLKOUT2_PHASE      (0.0),
    .CLKOUT3_PHASE      (90),
    .CLKOUT4_PHASE      (90),
    .CLKOUT5_PHASE      (0.0),
    .CLKOUT6_PHASE      (0.0),
    .CLKOUT1_DIVIDE     (6), //THIS IS THE DIVISOR
    .CLKOUT2_DIVIDE     (3),
    .CLKOUT3_DIVIDE     (6),
    .CLKOUT4_DIVIDE     (3),
    .CLKOUT5_DIVIDE     (1),
    .CLKOUT6_DIVIDE     (1),
    .CLKOUT4_CASCADE    ("FALSE"),
    .CLOCK_HOLD         ("FALSE"),
    .DIVCLK_DIVIDE      (1), // Master division value (1-80)
    .REF_JITTER1        (0.0),
    .STARTUP_WAIT       ("FALSE")
  ) MMCM_BASE_inst (
    .CLKIN1   (sys_clk_int),
    .CLKFBIN  (sys_clk_fb),
    
    .CLKFBOUT  (sys_clk_fb_int),
    .CLKFBOUTB (),
    
    .CLKOUT0  (),
    .CLKOUT0B (),
    .CLKOUT1  (sys_clk_mmcm),
    .CLKOUT1B (),
    .CLKOUT2  (sys_clk2x_mmcm),
    .CLKOUT2B (),
    .CLKOUT3  (sys_clk90_mmcm),
    .CLKOUT3B (),
    .CLKOUT4  (sys_clk2x90_mmcm),
    .CLKOUT5  (),
    .CLKOUT6  (),
    .LOCKED   (mmcm_psdone),
    
    .PWRDWN   (1'b0),
    .RST      (mmcm_reset)
  );

  BUFG bufg_sys_clk[2:0](
    .I({sys_clk_mmcm, sys_clk90_mmcm, sys_clk_fb_int}),
    .O({sys_clk,      sys_clk90,      sys_clk_fb})
  );

  BUFG bufg_sys_clk2x[1:0](
    .I({sys_clk2x_mmcm, sys_clk2x90_mmcm}),
    .O({sys_clk2x,      sys_clk2x90})
  );

  // rely on inference of Xilinx internal clock inversion structures down the line
  assign sys_clk180   = ~sys_clk;
  assign sys_clk270   = ~sys_clk90;
  assign sys_clk2x180 = ~sys_clk2x;
  assign sys_clk2x270 = ~sys_clk2x90;

  /* Aux clocks */ //TODO 
/*
  wire  aux_clk_int;
  IBUFGDS #(
    .IOSTANDARD ("LVDS_25"),
    .DIFF_TERM  ("TRUE")
  ) ibufgd_aux_arr (
    .I  ({aux_clk_p}),
    .IB ({aux_clk_n}),
    .O  ({aux_clk_int})
  );

  wire  aux_clk_mmcm;
  wire  aux_clk90_mmcm;

  wire  aux_clk_mmcm_locked;

  wire  aux_clk2x_int;
  wire  aux_clk2x_buf;
  wire  aux_clk2x_mmcm;
  wire  aux_clk2x90_mmcm;

// =====================================================================
// Generated DCM instantiation based on target clock frequency; use
// "LOW" DLL frequency mode if < 120MHz (V5-specific target)

generate
    begin: GEN_DCM
        if (CLK_FREQ < 120) begin
            MMCM_BASE #(
              .BANDWIDTH          ("LOW"), // Jitter programming ("HIGH","LOW","OPTIMIZED")
              .CLKFBOUT_MULT_F    (6), // Multiply value for all CLKOUT (5.0-64.0). THIS IS THE MULTIPLIER
              .CLKFBOUT_PHASE     (0.0),
              .CLKIN1_PERIOD      (1000/CLK_FREQ),
              .CLKOUT0_DIVIDE_F   (1), // Divide amount for CLKOUT0 (1.000-128.000).
              .CLKOUT0_DUTY_CYCLE (0.5),
              .CLKOUT1_DUTY_CYCLE (0.5),
              .CLKOUT2_DUTY_CYCLE (0.5),
              .CLKOUT3_DUTY_CYCLE (0.5),
              .CLKOUT4_DUTY_CYCLE (0.5),
              .CLKOUT5_DUTY_CYCLE (0.5),
              .CLKOUT6_DUTY_CYCLE (0.5),
              .CLKOUT0_PHASE      (0.0),
              .CLKOUT1_PHASE      (0.0),
              .CLKOUT2_PHASE      (0.0),
              .CLKOUT3_PHASE      (90),
              .CLKOUT4_PHASE      (90),
              .CLKOUT5_PHASE      (0.0),
              .CLKOUT6_PHASE      (0.0),
              .CLKOUT1_DIVIDE     (6), //THIS IS THE DIVISOR
              .CLKOUT2_DIVIDE     (3),
              .CLKOUT3_DIVIDE     (6),
              .CLKOUT4_DIVIDE     (3),
              .CLKOUT5_DIVIDE     (1),
              .CLKOUT6_DIVIDE     (1),
              .CLKOUT4_CASCADE    ("FALSE"),
              .CLOCK_HOLD         ("FALSE"),
              .DIVCLK_DIVIDE      (1), // Master division value (1-80)
              .REF_JITTER1        (0.0),
              .STARTUP_WAIT       ("FALSE")
            ) MMCM_BASE_inst (
              .CLKIN1   (aux_clk_int),
              .CLKFBIN  (aux_clk_fb),
              
              .CLKFBOUT  (aux_clk_fb_int),
              .CLKFBOUTB (),
              
              .CLKOUT0  (),
              .CLKOUT0B (),
              .CLKOUT1  (aux_clk_mmcm),
              .CLKOUT1B (),
              .CLKOUT2  (aux_clk2x_mmcm),
              .CLKOUT2B (),
              .CLKOUT3  (aux_clk90_mmcm),
              .CLKOUT3B (),
              .CLKOUT4  (aux_clk2x90_mmcm),
              .CLKOUT5  (),
              .CLKOUT6  (),
              .LOCKED   (),
              
              .PWRDWN   (1'b0),
              .RST      (mmcm_reset)
            );
        end // if (CLK_FREQ < 120)
        else begin
            MMCM_BASE #(
              .BANDWIDTH          ("HIGH"), // Jitter programming ("HIGH","LOW","OPTIMIZED")
              .CLKFBOUT_MULT_F    (6), // Multiply value for all CLKOUT (5.0-64.0). THIS IS THE MULTIPLIER
              .CLKFBOUT_PHASE     (0.0),
              .CLKIN1_PERIOD      (1000/CLK_FREQ),
              .CLKOUT0_DIVIDE_F   (1), // Divide amount for CLKOUT0 (1.000-128.000).
              .CLKOUT0_DUTY_CYCLE (0.5),
              .CLKOUT1_DUTY_CYCLE (0.5),
              .CLKOUT2_DUTY_CYCLE (0.5),
              .CLKOUT3_DUTY_CYCLE (0.5),
              .CLKOUT4_DUTY_CYCLE (0.5),
              .CLKOUT5_DUTY_CYCLE (0.5),
              .CLKOUT6_DUTY_CYCLE (0.5),
              .CLKOUT0_PHASE      (0.0),
              .CLKOUT1_PHASE      (0.0),
              .CLKOUT2_PHASE      (0.0),
              .CLKOUT3_PHASE      (90),
              .CLKOUT4_PHASE      (90),
              .CLKOUT5_PHASE      (0.0),
              .CLKOUT6_PHASE      (0.0),
              .CLKOUT1_DIVIDE     (6), //THIS IS THE DIVISOR
              .CLKOUT2_DIVIDE     (3),
              .CLKOUT3_DIVIDE     (6),
              .CLKOUT4_DIVIDE     (3),
              .CLKOUT5_DIVIDE     (1),
              .CLKOUT6_DIVIDE     (1),
              .CLKOUT4_CASCADE    ("FALSE"),
              .CLOCK_HOLD         ("FALSE"),
              .DIVCLK_DIVIDE      (1), // Master division value (1-80)
              .REF_JITTER1        (0.0),
              .STARTUP_WAIT       ("FALSE")
            ) MMCM_BASE_inst (
              .CLKIN1   (aux_clk_int),
              .CLKFBIN  (aux_clk_fb),
              
              .CLKFBOUT  (aux_clk_fb_int),
              .CLKFBOUTB (),
              
              .CLKOUT0  (),
              .CLKOUT0B (),
              .CLKOUT1  (aux_clk_mmcm),
              .CLKOUT1B (),
              .CLKOUT2  (aux_clk2x_mmcm),
              .CLKOUT2B (),
              .CLKOUT3  (aux_clk90_mmcm),
              .CLKOUT3B (),
              .CLKOUT4  (aux_clk2x90_mmcm),
              .CLKOUT5  (),
              .CLKOUT6  (),
              .LOCKED   (),
              
              .PWRDWN   (1'b0),
              .RST      (mmcm_reset)
            );
        end // else
   end // GEN_DCM
endgenerate


  BUFG bufg_aux_clk[2:0](
    .I({aux_clk_mmcm, aux_clk90_mmcm, aux_clk_fb_int}),
    .O({aux_clk,      aux_clk90,      aux_clk_fb})
  );

  BUFG bufg_aux2_clk[1:0](
    .I({aux_clk2x_mmcm, aux_clk2x90_mmcm}),
    .O({aux_clk2x,      aux_clk2x90})
  );

  // rely on inference of Xilinx internal clock inversion structures down the line
  assign aux_clk180 = ~aux_clk;
  assign aux_clk270 = ~aux_clk90;

  assign aux_clk2x180 = ~aux_clk2x;
  assign aux_clk2x270 = ~aux_clk2x90;
*/

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

  /*IDELAYCTRL idelayctrl_inst(
    .REFCLK (dly_clk),
    .RST    (idelay_rst),
    .RDY    (idelay_rdy)
  );*/


endmodule
