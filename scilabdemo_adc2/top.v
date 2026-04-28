`default_nettype wire

// New top-level for DE10-Nano HPS + ADC (scilab_adc2 system)
module top (
    // 50 MHz input clock from DE10-Nano
    input  wire        FPGA_CLK1_50,

    // HPS DDR3 interface (same naming as old design)
    input  wire        HPS_DDR3_RZQ,
    inout  wire [31:0] HPS_DDR3_DQ,
    inout  wire [3:0]  HPS_DDR3_DQS_N,
    inout  wire [3:0]  HPS_DDR3_DQS_P,
    output wire [14:0] HPS_DDR3_ADDR,
    output wire [2:0]  HPS_DDR3_BA,
    output wire        HPS_DDR3_CAS_N,
    output wire        HPS_DDR3_CKE,
    output wire        HPS_DDR3_CK_N,
    output wire        HPS_DDR3_CK_P,
    output wire        HPS_DDR3_CS_N,
    output wire [3:0]  HPS_DDR3_DM,
    output wire        HPS_DDR3_ODT,
    output wire        HPS_DDR3_RAS_N,
    output wire        HPS_DDR3_RESET_N,
    output wire        HPS_DDR3_WE_N,

    // On-board LTC2308 ADC interface
    output wire        ADC_CONVST,
    output wire        ADC_SCK,
    output wire        ADC_SDI,
    input  wire        ADC_SDO
);

    // Simple always-deasserted reset for the Platform Designer system.
    // If you later add a pushbutton or HPS-controlled reset, wire it here.
    wire sys_reset_n = 1'b1;

    // Instantiate the Platform Designer system generated as scilab_adc2.v
    scilab_adc2 u_system (
        // ADC conduit
        .adc_ltc2308_0_adc_conduit_adc_convst (ADC_CONVST),
        .adc_ltc2308_0_adc_conduit_adc_sck    (ADC_SCK),
        .adc_ltc2308_0_adc_conduit_adc_sdi    (ADC_SDI),
        .adc_ltc2308_0_adc_conduit_adc_sdo    (ADC_SDO),

        // System clock and reset
        .clk_clk          (FPGA_CLK1_50),
        .reset_reset_n    (sys_reset_n),

        // HPS DDR3 memory interface
        .memory_mem_a       (HPS_DDR3_ADDR),
        .memory_mem_ba      (HPS_DDR3_BA),
        .memory_mem_ck      (HPS_DDR3_CK_P),
        .memory_mem_ck_n    (HPS_DDR3_CK_N),
        .memory_mem_cke     (HPS_DDR3_CKE),
        .memory_mem_cs_n    (HPS_DDR3_CS_N),
        .memory_mem_ras_n   (HPS_DDR3_RAS_N),
        .memory_mem_cas_n   (HPS_DDR3_CAS_N),
        .memory_mem_we_n    (HPS_DDR3_WE_N),
        .memory_mem_reset_n (HPS_DDR3_RESET_N),
        .memory_mem_dq      (HPS_DDR3_DQ),
        .memory_mem_dqs     (HPS_DDR3_DQS_P),
        .memory_mem_dqs_n   (HPS_DDR3_DQS_N),
        .memory_mem_odt     (HPS_DDR3_ODT),
        .memory_mem_dm      (HPS_DDR3_DM),
        .memory_oct_rzqin   (HPS_DDR3_RZQ),

        // HPS-to-FPGA reset output; we don't use it at the top level,
        // but the port must be connected.
        .hps_0_h2f_reset_reset_n ()
    );
	 

endmodule
