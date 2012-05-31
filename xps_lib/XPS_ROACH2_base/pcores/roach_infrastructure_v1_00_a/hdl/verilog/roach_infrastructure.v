module roach_infrastructure(
    sys_clk_n, sys_clk_p,
    sys_clk, sys_clk90, sys_clk180, sys_clk270,
    sys_clk_lock, op_power_on_rst,
    sys_clk2x, sys_clk2x90, sys_clk2x180, sys_clk2x270,
    //dly_clk_n,  dly_clk_p,
    //dly_clk,
    epb_clk_in,
    epb_clk,
    idelay_rst, idelay_rdy,
    aux_clk_n, aux_clk_p,
    aux_clk, aux_clk90, aux_clk180, aux_clk270,
    aux_clk2x, aux_clk2x90, aux_clk2x180, aux_clk2x270
  );

  parameter CLK_FREQ     = 100; 
  parameter CLK_HIGH_LOW = "low"; // high >= 135, low < 135
  parameter CLK_SOURCE   = "sys"; // "sys" = sys or arb, aux = aux (arb_clk is generated from sys_clk)
  parameter DIVIDE_1     = 3;
  parameter DIVIDE_2     = 6;
  parameter MULTIPLY     = 6;
  parameter CLK_200_D    = 6;

  input  sys_clk_n, sys_clk_p;
  output sys_clk, sys_clk90, sys_clk180, sys_clk270;
  output sys_clk_lock, op_power_on_rst;
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
  wire  clk_int;
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

  wire  mmcm_reset;

  generate
     begin: GEN_MMCM
        if (CLK_SOURCE == "SYS") begin
           // sys_clk diff buffer
           IBUFGDS #(
             .IOSTANDARD ("LVDS_25"),
             .DIFF_TERM  ("TRUE")
           ) ibufgd_sys (
             .I (sys_clk_p),
             .IB(sys_clk_n),
             .O (clk_int)
           );
        end
        else
        if (CLK_SOURCE == "AUX") begin
           // aux_clk diff buffer
           wire  aux_clk_int;
           IBUFGDS #(
             .IOSTANDARD ("LVDS_25"),
             .DIFF_TERM  ("TRUE")
           ) ibufgd_aux_arr (
             .I  (aux_clk_p),
             .IB (aux_clk_n),
             .O  (clk_int)
           );
        end
     end
  endgenerate

  MMCM_BASE #(
    .BANDWIDTH          (CLK_HIGH_LOW), // Jitter programming ("HIGH","LOW","OPTIMIZED")
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
    .CLKOUT3_PHASE      (0),
    .CLKOUT4_PHASE      (0),
    .CLKOUT5_PHASE      (0),
    .CLKOUT6_PHASE      (0.0),
    .CLKOUT1_DIVIDE     (6), //THIS IS THE DIVISOR
    .CLKOUT2_DIVIDE     (6),
    .CLKOUT3_DIVIDE     (3),
    .CLKOUT4_DIVIDE     (3),
    .CLKOUT5_DIVIDE     (3),
    .CLKOUT6_DIVIDE     (1),
    .CLKOUT4_CASCADE    ("FALSE"),
    .CLOCK_HOLD         ("FALSE"),
    .DIVCLK_DIVIDE      (1), // Master division value (1-80)
    .REF_JITTER1        (0.0),
    .STARTUP_WAIT       ("FALSE")
  ) MMCM_BASE_inst (
    .CLKIN1    (clk_int),
    .CLKFBIN   (sys_clk_fb),
    .CLKFBOUT  (sys_clk_fb_int),
    .CLKFBOUTB (),
    
    .CLKOUT0   (),
    .CLKOUT0B  (),
    .CLKOUT1   (sys_clk_mmcm),
    .CLKOUT1B  (sys_clk180_mmcm),
    .CLKOUT2   (sys_clk90_mmcm),
    .CLKOUT2B  (sys_clk270_mmcm),
    .CLKOUT3   (sys_clk2x_mmcm),
    .CLKOUT3B  (sys_clk2x180_mmcm),
    .CLKOUT4   (sys_clk2x90_mmcm),
    .CLKOUT5   (sys_clk2x270_mmcm),
    .CLKOUT6   (clk_200),
    .LOCKED    (sys_clk_mmcm_locked),
    
    .PWRDWN    (1'b0),
    .RST       (mmcm_reset)
  );
  
  assign op_power_on_rst = ~sys_clk_mmcm_locked;
  assign mmcm_reset = 1'b0;
  assign sys_clk_lock = sys_clk_mmcm_locked;

  BUFG bufg_sys_clk[4:0](
    .I({sys_clk_mmcm, sys_clk90_mmcm, sys_clk_fb_int, sys_clk180_mmcm, sys_clk270_mmcm}),
    .O({sys_clk,      sys_clk90,      sys_clk_fb    , sys_clk180     , sys_clk270})
  );

  BUFG bufg_sys_clk2x[3:0](
    .I({sys_clk2x_mmcm, sys_clk2x90_mmcm, sys_clk2x180_mmcm, sys_clk2x270_mmcm}),
    .O({sys_clk2x,      sys_clk2x90     , sys_clk2x180     , sys_clk2x270})
  );

  /* Aux clocks */ 


  wire  aux_clk_mmcm_locked;

  wire  aux_clk_mmcm;
  wire  aux_clk90_mmcm;
  wire  aux_clk180_mmcm;
  wire  aux_clk270_mmcm;
  wire  aux_clk2x_mmcm;
  wire  aux_clk2x90_mmcm;
  wire  aux_clk2x180_mmcm;
  wire  aux_clk2x270_mmcm;

  wire  aux_clk_fb_int;
  wire  aux_clk_fb;


// =====================================================================
// Generated MMCM instantiation based on target clock frequency; use
// "LOW" DLL frequency mode if < 135MHz (V6-specific target)

/*
generate
   begin: GEN_MMCM
      if (CLK_FREQ < 135) begin
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
           .CLKOUT5_PHASE      (270),
           .CLKOUT6_PHASE      (0.0),
           .CLKOUT1_DIVIDE     (6), //THIS IS THE DIVISOR
           .CLKOUT2_DIVIDE     (3),
           .CLKOUT3_DIVIDE     (6),
           .CLKOUT4_DIVIDE     (3),
           .CLKOUT5_DIVIDE     (3),
           .CLKOUT6_DIVIDE     (1),
           .CLKOUT4_CASCADE    ("FALSE"),
           .CLOCK_HOLD         ("FALSE"),
           .DIVCLK_DIVIDE      (1), // Master division value (1-80)
           .REF_JITTER1        (0.0),
           .STARTUP_WAIT       ("FALSE")
         ) MMCM_BASE_inst_aux (
           .CLKIN1    (aux_clk_int),
           .CLKFBIN   (aux_clk_fb),
           
           .CLKFBOUT  (aux_clk_fb_int),
           .CLKFBOUTB (),
           
           .CLKOUT0   (),
           .CLKOUT0B  (),
           .CLKOUT1   (aux_clk_mmcm),
           .CLKOUT1B  (aux_clk180_mmcm),
           .CLKOUT2   (aux_clk2x_mmcm),
           .CLKOUT2B  (aux_clk2x180_mmcm),
           .CLKOUT3   (aux_clk90_mmcm),
           .CLKOUT3B  (aux_clk270_mmcm),
           .CLKOUT4   (aux_clk2x90_mmcm),
           .CLKOUT5   (aux_clk2x270_mmcm),
           .CLKOUT6   (),
           .LOCKED    (aux_clk_mmcm_locked),
           
           .PWRDWN   (1'b0),
           .RST      (mmcm_reset)
         );
      end // if (CLK_FREQ < 135)
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
           .CLKOUT5_PHASE      (270),
           .CLKOUT6_PHASE      (0.0),
           .CLKOUT1_DIVIDE     (6), //THIS IS THE DIVISOR
           .CLKOUT2_DIVIDE     (3),
           .CLKOUT3_DIVIDE     (6),
           .CLKOUT4_DIVIDE     (3),
           .CLKOUT5_DIVIDE     (3),
           .CLKOUT6_DIVIDE     (1),
           .CLKOUT4_CASCADE    ("FALSE"),
           .CLOCK_HOLD         ("FALSE"),
           .DIVCLK_DIVIDE      (1), // Master division value (1-80)
           .REF_JITTER1        (0.0),
           .STARTUP_WAIT       ("FALSE")
         ) MMCM_BASE_inst_aux (
           .CLKIN1    (aux_clk_int),
           .CLKFBIN   (aux_clk_fb),
           
           .CLKFBOUT  (aux_clk_fb_int),
           .CLKFBOUTB (),
           
           .CLKOUT0   (),
           .CLKOUT0B  (),
           .CLKOUT1   (aux_clk_mmcm),
           .CLKOUT1B  (aux_clk180_mmcm),
           .CLKOUT2   (aux_clk2x_mmcm),
           .CLKOUT2B  (aux_clk2x180_mmcm),
           .CLKOUT3   (aux_clk90_mmcm),
           .CLKOUT3B  (aux_clk270_mmcm),
           .CLKOUT4   (aux_clk2x90_mmcm),
           .CLKOUT5   (aux_clk2x270_mmcm),
           .CLKOUT6   (),
           .LOCKED    (aux_clk_mmcm_locked),
           
           .PWRDWN   (1'b0),
           .RST      (mmcm_reset)
         );
      end // else
   end // GEN_MMCM
endgenerate


  BUFG bufg_aux_clk[4:0](
    .I({aux_clk_mmcm, aux_clk90_mmcm, aux_clk_fb_int, aux_clk180_mmcm, aux_clk270_mmcm}),
    .O({aux_clk,      aux_clk90,      aux_clk_fb,     aux_clk180,      aux_clk270})
  );

  BUFG bufg_aux2_clk[3:0](
    .I({aux_clk2x_mmcm, aux_clk2x90_mmcm, aux_clk2x180_mmcm, aux_clk2x270_mmcm}),
    .O({aux_clk2x,      aux_clk2x90,      aux_clk2x180,      aux_clk2x270})
  );
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

  IDELAYCTRL idelayctrl_inst(
    .REFCLK (sys_clk2x),
    .RST    (idelay_rst),
    .RDY    (idelay_rdy)
  );

  assign aux_clk      = sys_clk;
  assign aux_clk90    = sys_clk90;
  assign aux_clk180   = sys_clk180;
  assign aux_clk270   = sys_clk270;
  assign aux_clk2x    = sys_clk2x;
  assign aux_clk2x90  = sys_clk2x90;
  assign aux_clk2x180 = sys_clk2x180;
  assign aux_clk2x270 = sys_clk2x270;


endmodule
