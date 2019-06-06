module casia_k7_21cma_infrastructure(
    input  sys_clk_in,
    output sys_clk0,
    output sys_clk180,
    output sys_clk270,

    output clk_200,
    output clk_125,
    output clk_250MHz,
    output clk_250MHz270,

    output sys_rst,
    output pll_lock,
    output idelay_rdy
  );

  wire sys_clk_ds;
  IBUFG ibufgds_sys_clk (
    .I (sys_clk_in),
    .O (sys_clk_ds)
  );

  wire fb_clk;

  wire sys_clk0_dcm;
  wire sys_clk180_dcm;
  wire sys_clk270_dcm;
  wire clk_200_dcm;
  wire clk_125_dcm;
  wire clk_250MHz_dcm;
  wire clk_250MHz270_dcm;

  wire clk_fb;

  //wire pll_lock;

  MMCM_BASE #(
   .BANDWIDTH          ("OPTIMIZED"), // Jitter programming ("HIGH","LOW","OPTIMIZED")
   .CLKFBOUT_MULT_F    (20), // Multiply value for all CLKOUT (5.0-64.0).
   .CLKFBOUT_PHASE     (0.0),
   .CLKIN1_PERIOD      (20.0), // CASIA_K7_21CMA clock is 50 MHz
   .CLKOUT0_DIVIDE_F   (1.0), // Divide amount for CLKOUT0 (1.000-128.000).
   .CLKOUT0_DUTY_CYCLE (0.5),
   .CLKOUT1_DUTY_CYCLE (0.5),
   .CLKOUT2_DUTY_CYCLE (0.5),
   .CLKOUT3_DUTY_CYCLE (0.5),
   .CLKOUT4_DUTY_CYCLE (0.5),
   .CLKOUT5_DUTY_CYCLE (0.5),
   .CLKOUT6_DUTY_CYCLE (0.5),
   .CLKOUT0_PHASE      (0.0),
   .CLKOUT1_PHASE      (0.0),
   .CLKOUT2_PHASE      (270),
   .CLKOUT3_PHASE      (0.0),
   .CLKOUT4_PHASE      (0.0),
   .CLKOUT5_PHASE      (0.0),
   .CLKOUT6_PHASE      (270),
   .CLKOUT1_DIVIDE     (10),
   .CLKOUT2_DIVIDE     (10),
   .CLKOUT3_DIVIDE     (5),
   .CLKOUT4_DIVIDE     (8),
   .CLKOUT5_DIVIDE     (4),
   .CLKOUT6_DIVIDE     (4),
   .CLKOUT4_CASCADE    ("FALSE"),
   .CLOCK_HOLD         ("FALSE"),
   .DIVCLK_DIVIDE      (1), // Master division value (1-80)
   .REF_JITTER1        (0.0),
   .STARTUP_WAIT       ("FALSE")
  ) MMCM_BASE_inst (
   .CLKIN1   (sys_clk_ds),
   .CLKFBIN  (clk_fb),

   .CLKFBOUT  (clk_fb),
   .CLKFBOUTB (),

   .CLKOUT0  (),
   .CLKOUT0B (),
   .CLKOUT1  (sys_clk0_dcm),
   .CLKOUT1B (sys_clk180_dcm),
   .CLKOUT2  (sys_clk270_dcm),
   .CLKOUT2B (),
   .CLKOUT3  (clk_200_dcm),
   .CLKOUT3B (),
   .CLKOUT4  (clk_125_dcm),
   .CLKOUT5  (clk_250MHz_dcm),
   .CLKOUT6  (clk_250MHz270_dcm),
   .LOCKED   (pll_lock),

   .PWRDWN   (1'b0),
   .RST      (1'b0)

  );


  BUFG bufg_sysclk[4:0](
    .I({sys_clk0_dcm, sys_clk180_dcm, sys_clk270_dcm, clk_200_dcm,clk_125_dcm, clk_250MHz_dcm, clk_250MHz270_dcm}),
    .O({sys_clk0,     sys_clk180,     sys_clk270,     clk_200,clk_125,         clk_250MHz,     clk_250MHz270})
  );
  
  /* reset gen */
  reg sys_rst_reg_z;
  reg sys_rst_reg;
  reg [15:0] sys_rst_counter;
  always @(posedge sys_clk0) begin
    sys_rst_reg_z <= sys_rst_reg;
    if (!pll_lock) begin
      sys_rst_reg     <= 1'b0;
      sys_rst_counter <= {16{1'b0}};
    end else begin
      if (sys_rst_counter == {16{1'b1}}) begin
        sys_rst_reg <= 1'b0;
        sys_rst_counter <= {16{1'b1}};
      end else begin
        sys_rst_reg <= 1'b1;
        sys_rst_counter <= sys_rst_counter + 16'd1;
      end
    end

  end
  assign sys_rst = sys_rst_reg_z & pll_lock;

  /* io delay reset */
  /*
  IDELAYCTRL idelayctrl_inst(
    .REFCLK(clk_200),
    .RST(sys_rst),
    .RDY(idelay_rdy)
  );
  */

endmodule
