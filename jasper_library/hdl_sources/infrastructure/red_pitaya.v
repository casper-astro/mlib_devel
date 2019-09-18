module red_pitaya_infrastructure #(
        parameter MULTIPLY = 1,
        parameter DIVIDE   = 1,
        parameter DIVCLK   = 1
    ) (
        //input  sys_clk_buf_n,
        //input  sys_clk_buf_p,

        input adc_clk_in,

        output dsp_clk,
        output dsp_clk_p90,
        output dsp_clk_p180,
        output dsp_clk_p270,
        output dsp_rst,

        output adc_clk_125,
        output adc_rst,
        output dac_clk_250,
        output dac_rst,
        output dac_clk_250_p315
    );

    wire adc_clk_ibuf;
    wire adc_clk_mmcm_fb;
    wire dsp_clk_mmcm_fb;
    wire adc_clk_mmcm;
    wire dsp_clk_mmcm;
    wire dsp_clk_mmcm_p90;
    wire dsp_clk_mmcm_p180;
    wire dsp_clk_mmcm_p270;
    wire dac_clk_mmcm;
    wire dac_clk_mmcm_250_p315;
    wire dsp_mmcm_lock;
    wire adc_mmcm_lock;
    
    // single clock input
    IBUF adc_clk_ibuf_inst (.I (adc_clk_in), .O (adc_clk_ibuf));  // differential clock input
    
    // diferential clock input
    // IBUFDS i_clk (.I (adc_clk_i[1]), .IB (adc_clk_i[0]), .O (adc_clk_ibufds));  // differential clock input
    
    MMCM_BASE #(
        .BANDWIDTH          ("OPTIMIZED"), // Jitter programming ("HIGH","LOW","OPTIMIZED")
        .CLKFBOUT_MULT_F    (MULTIPLY), // Multiply value for all CLKOUT (5.0-64.0).
        .CLKFBOUT_PHASE     (0.0),
        .CLKIN1_PERIOD      (8.0), // Red Pitaya clock is 125 MHz
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
        .CLKOUT1_DIVIDE     (12),
        .CLKOUT2_DIVIDE     (12),
        .CLKOUT3_DIVIDE     (12),
        .CLKOUT4_DIVIDE     (1),
        .CLKOUT5_DIVIDE     (1),
        .CLKOUT6_DIVIDE     (1),
        .CLKOUT4_CASCADE    ("FALSE"),
        .CLOCK_HOLD         ("FALSE"),
        .DIVCLK_DIVIDE      (DIVCLK), // Master division value (1-80)
        .REF_JITTER1        (0.0),
        .STARTUP_WAIT       ("FALSE")
    ) dsp_clk_mmcm_inst (
        .CLKIN1   (adc_clk_ibuf),
        .CLKFBIN  (dsp_clk_mmcm_fb),
        .CLKFBOUT  (dsp_clk_mmcm_fb),
        .CLKFBOUTB (),
        .CLKOUT0  (dsp_clk_mmcm),
        .CLKOUT0B (),
        .CLKOUT1  (dsp_clk_mmcm_p90),
        .CLKOUT1B (),
        .CLKOUT2  (dsp_clk_mmcm_p180),
        .CLKOUT2B (),
        .CLKOUT3  (dsp_clk_mmcm_p270),
        .CLKOUT3B (),
        .CLKOUT4  (),
        .CLKOUT5  (),
        .CLKOUT6  (),
        .LOCKED   (dsp_mmcm_lock),
        .PWRDWN   (1'b0),
        .RST      (1'b0)
    );
    
    MMCM_BASE #(
        .BANDWIDTH          ("OPTIMIZED"), // Jitter programming ("HIGH","LOW","OPTIMIZED")
        .CLKFBOUT_MULT_F    (8), // Multiply value for all CLKOUT (5.0-64.0).
        .CLKFBOUT_PHASE     (0.0),
        .CLKIN1_PERIOD      (8.0), // Red Pitaya clock is 125 MHz
        .CLKOUT0_DIVIDE_F   (1),   // Divide amount for CLKOUT0 (1.000-128.000).
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
        .CLKOUT3_PHASE      (-45.0),
        .CLKOUT4_PHASE      (0.0),
        .CLKOUT5_PHASE      (0.0),
        .CLKOUT6_PHASE      (0.0),
        .CLKOUT1_DIVIDE     (8),
        .CLKOUT2_DIVIDE     (4),
        .CLKOUT3_DIVIDE     (4),
        .CLKOUT4_DIVIDE     (1),
        .CLKOUT5_DIVIDE     (1),
        .CLKOUT6_DIVIDE     (1),
        .CLKOUT4_CASCADE    ("FALSE"),
        .CLOCK_HOLD         ("FALSE"),
        .DIVCLK_DIVIDE      (1), // Master division value (1-80)
        .REF_JITTER1        (0.0),
        .STARTUP_WAIT       ("FALSE")
    ) adc_clk_mmcm_inst (
        .CLKIN1   (adc_clk_ibuf),
        .CLKFBIN  (adc_clk_mmcm_fb),
        .CLKFBOUT  (adc_clk_mmcm_fb),
        .CLKFBOUTB (),
        .CLKOUT0  (),
        .CLKOUT0B (),
        .CLKOUT1  (adc_clk_125_mmcm),
        .CLKOUT1B (),
        .CLKOUT2  (dac_clk_250_mmcm),
        .CLKOUT2B (),
        .CLKOUT3  (dac_clk_250_mmcm_p315),
        .CLKOUT3B (),
        .CLKOUT4  (),
        .CLKOUT5  (),
        .CLKOUT6  (),
        .LOCKED   (adc_mmcm_lock),
        .PWRDWN   (1'b0),
        .RST      (1'b0)
    );
    
    BUFG bufg_sysclk[6:0](
      .I({dsp_clk_mmcm, dsp_clk_mmcm_p90, dsp_clk_mmcm_p180, dsp_clk_mmcm_p270, adc_clk_125_mmcm, dac_clk_250_mmcm, dac_clk_250_mmcm_p315}),
      .O({dsp_clk,      dsp_clk_p90,      dsp_clk_p180,      dsp_clk_p270,      adc_clk_125,      dac_clk_250     , dac_clk_250_p315})
    );
    
    // TODO: Check this logic and look a the resets
    assign user_rst = !(adc_mmcm_lock & dsp_mmcm_lock);
    assign adc_rst  = !(adc_mmcm_lock & dsp_mmcm_lock);
    assign dac_rst  = !(adc_mmcm_lock & dsp_mmcm_lock);

endmodule
