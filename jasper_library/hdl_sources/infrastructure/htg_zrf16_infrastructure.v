module htg_zrf16_infrastructure #(
      parameter GEN_USER_CLK = 1,
      parameter MULTIPLY = 1,
      parameter DIVIDE   = 1,
      parameter DIVCLK   = 1
    ) (
      input clk_300_n,
	    input clk_300_p,

	    output user_clk,
	    output user_clk90,
	    output user_clk180,
	    output user_clk270,

	    output sys_clk,
	    output sys_clk90,
	    output sys_clk180,
	    output sys_clk270,
	
      output sys_clk_rst,
      output user_clk_rst
    );

    wire clk_300_buf;

    wire sys_clk_mmcm_fb;
    wire sys_clk_mmcm;
    wire sys_clk_90_mmcm;
    wire sys_clk_180_mmcm;
    wire sys_clk_270_mmcm;
    wire sys_mmcm_lock;

    wire user_clk_mmcm_fb;
    wire user_clk_mmcm;
    wire user_clk_90_mmcm;
    wire user_clk_180_mmcm;
    wire user_clk_270_mmcm;
    wire user_mmcm_lock;
    
    // single clock input
    //IBUF adc_clk_ibuf_inst (.I (adc_clk_in), .O (adc_clk_ibuf));  // differential clock input
    
    // diferential clock input
    IBUFDS i_clk (.I (clk_300_p), .IB (clk_300_n), .O (clk_300_buf));  // differential clock input

    MMCM_BASE #(
        .BANDWIDTH          ("OPTIMIZED"), // Jitter programming ("HIGH","LOW","OPTIMIZED")
        .CLKFBOUT_MULT_F    (3), // Multiply value for all CLKOUT (5.0-64.0).
        .CLKFBOUT_PHASE     (0.0),
        .CLKIN1_PERIOD      (3.3333),   // Input clock is 300 MHz
        .CLKOUT0_DIVIDE_F   (9),   // Divide amount for CLKOUT0 (1.000-128.000).
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
        .CLKOUT1_DIVIDE     (9),
        .CLKOUT2_DIVIDE     (9),
        .CLKOUT3_DIVIDE     (9),
        .CLKOUT4_DIVIDE     (1),
        .CLKOUT5_DIVIDE     (1),
        .CLKOUT6_DIVIDE     (1),
        .CLKOUT4_CASCADE    ("FALSE"),
        .CLOCK_HOLD         ("FALSE"),
        .DIVCLK_DIVIDE      (1), // Master division value (1-80)
        .REF_JITTER1        (0.0),
        .STARTUP_WAIT       ("FALSE")
    ) sys_clk_mmcm_inst (
        .CLKIN1   (clk_300_buf),
        .CLKFBIN  (sys_clk_mmcm_fb),
        .CLKFBOUT  (sys_clk_mmcm_fb),
        .CLKFBOUTB (),
        .CLKOUT0  (sys_clk_mmcm),
        .CLKOUT0B (),
        .CLKOUT1  (sys_clk_90_mmcm),
        .CLKOUT1B (),
        .CLKOUT2  (sys_clk_180_mmcm),
        .CLKOUT2B (),
        .CLKOUT3  (sys_clk_270_mmcm),
        .CLKOUT3B (),
        .CLKOUT4  (),
        .CLKOUT5  (),
        .CLKOUT6  (),
        .LOCKED   (sys_mmcm_lock),
        .PWRDWN   (1'b0),
        .RST      (1'b0)
    );
    BUFG bufg_sysclk[3:0](
      .I({sys_clk_mmcm, sys_clk_90_mmcm, sys_clk_180_mmcm, sys_clk_270_mmcm}),
      .O({sys_clk, sys_clk90, sys_clk180, sys_clk270})
    );

    generate
    if (GEN_USER_CLK == 1) begin
        MMCM_BASE #(
            .BANDWIDTH          ("OPTIMIZED"), // Jitter programming ("HIGH","LOW","OPTIMIZED")
            .CLKFBOUT_MULT_F    (MULTIPLY), // Multiply value for all CLKOUT (5.0-64.0).
            .CLKFBOUT_PHASE     (0.0),
            .CLKIN1_PERIOD      (3.3333),   // Input clock is 300 MHz
            .CLKOUT0_DIVIDE_F   (DIVIDE),   // Divide amount for CLKOUT0 (1.000-128.000).
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
            .CLOCK_HOLD         ("FALSE"),
            .DIVCLK_DIVIDE      (DIVCLK), // Master division value (1-80)
            .REF_JITTER1        (0.0),
            .STARTUP_WAIT       ("FALSE")
        ) user_clk_mmcm_inst (
            .CLKIN1   (clk_300_buf),
            .CLKFBIN  (user_clk_mmcm_fb),
            .CLKFBOUT  (user_clk_mmcm_fb),
            .CLKFBOUTB (),
            .CLKOUT0  (user_clk_mmcm),
            .CLKOUT0B (),
            .CLKOUT1  (user_clk_90_mmcm),
            .CLKOUT1B (),
            .CLKOUT2  (user_clk_180_mmcm),
            .CLKOUT2B (),
            .CLKOUT3  (user_clk_270_mmcm),
            .CLKOUT3B (),
            .CLKOUT4  (),
            .CLKOUT5  (),
            .CLKOUT6  (),
            .LOCKED   (user_mmcm_lock),
            .PWRDWN   (1'b0),
            .RST      (1'b0)
        );
        
        BUFG bufg_sysclk[3:0](
          .I({user_clk_mmcm, user_clk_90_mmcm, user_clk_180_mmcm, user_clk_270_mmcm}),
          .O({user_clk, user_clk90, user_clk180, user_clk270})
        );
    end else begin
        assign user_mmcm_lock = 1'b1;
        assign user_clk = 1'b0;
        assign user_clk90 = 1'b0;
        assign user_clk180 = 1'b0;
        assign user_clk270 = 1'b0;
    end
    endgenerate

    // TODO: Check this logic and look a the resets
    assign sys_clk_rst = !sys_mmcm_lock;
    assign user_clk_rst = !user_mmcm_lock;
	
endmodule
