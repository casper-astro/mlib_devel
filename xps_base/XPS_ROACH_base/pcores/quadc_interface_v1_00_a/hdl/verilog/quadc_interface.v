module quadc_interface (
                adc0_clk_in_p,
                adc0_clk_in_n,
                adc1_clk_in_p,
                adc1_clk_in_n,
                adc2_clk_in_p,
                adc2_clk_in_n,
                adc3_clk_in_p,
                adc3_clk_in_n,

                adc0_data_in_p,
                adc0_data_in_n,
                adc1_data_in_p,
                adc1_data_in_n,
                adc2_data_in_p,
                adc2_data_in_n,
                adc3_data_in_p,
                adc3_data_in_n,

                sync_in_p,
                sync_in_n,

                user_clk,
                dcm_reset,
                reset,

                adc0_clk,
                adc1_clk,
                adc2_clk,
                adc3_clk,

                adc0_clk90,
                adc0_clk180,
                adc0_clk270,

                adc0_data,
                adc1_data,
                adc2_data,
                adc3_data,

                valid,

                sync
            );

    parameter       CLK_FREQ = 200;

    input           adc0_clk_in_p;
    input           adc0_clk_in_n;
    input           adc1_clk_in_p;
    input           adc1_clk_in_n;
    input           adc2_clk_in_p;
    input           adc2_clk_in_n;
    input           adc3_clk_in_p;
    input           adc3_clk_in_n;

    input [7:0]     adc0_data_in_p;
    input [7:0]     adc0_data_in_n;
    input [7:0]     adc1_data_in_p;
    input [7:0]     adc1_data_in_n;
    input [7:0]     adc2_data_in_p;
    input [7:0]     adc2_data_in_n;
    input [7:0]     adc3_data_in_p;
    input [7:0]     adc3_data_in_n;

    input           sync_in_p;
    input           sync_in_n;

    input           user_clk;
    input           dcm_reset;
    input           reset;

    output          adc0_clk;
    output          adc1_clk;
    output          adc2_clk;
    output          adc3_clk;

    output          adc0_clk90;
    output          adc0_clk180;
    output          adc0_clk270;

    output [7:0]    adc0_data;
    output [7:0]    adc1_data;
    output [7:0]    adc2_data;
    output [7:0]    adc3_data;

    output          valid;

    output          sync;

    wire            adc0_clk_in;
    wire            adc1_clk_in;
    wire            adc2_clk_in;
    wire            adc3_clk_in;

    wire [7:0]      adc0_data_in;
    wire [7:0]      adc1_data_in;
    wire [7:0]      adc2_data_in;
    wire [7:0]      adc3_data_in;

    wire            sync_in;

    wire            adc0_clk_buf;
    wire            adc0_clk_90_buf;
    wire            adc0_clk_180_buf;
    wire            adc0_clk_270_buf;
    wire            adc0_clk_2x_buf;

    wire            adc0_clk;
    wire            adc0_clk_90;
    wire            adc0_clk_180;
    wire            adc0_clk_270;
    wire            adc0_clk_2x;

    wire            dcm_adc0_locked;
    wire [7:0]      dcm_adc0_status;

    wire            fifo_empty;
    wire            fifo_valid;

    reg [7:0]       adc0_data_capture;
    reg [7:0]       adc1_data_capture;
    reg [7:0]       adc2_data_capture;
    reg [7:0]       adc3_data_capture;

    reg             sync_capture;

    reg [7:0]       adc0_data_recapture;
    reg [7:0]       adc1_data_recapture;
    reg [7:0]       adc2_data_recapture;
    reg [7:0]       adc3_data_recapture;

    reg             sync_recapture;

    reg [7:0]       fifo_adc0;
    reg [7:0]       fifo_adc1;
    reg [7:0]       fifo_adc2;
    reg [7:0]       fifo_adc3;

    reg             fifo_sync;

    reg             fifo_rd_en;

    wire [7:0]      adc0_data;
    wire [7:0]      adc1_data;
    wire [7:0]      adc2_data;
    wire [7:0]      adc3_data;

    wire            sync;

    IBUFGDS #(
            .IOSTANDARD("LVDS_25")      // Specify the input I/O standard
            )
        IBUFGDS_ADC0CLK (
            .I (adc0_clk_in_p),
            .IB(adc0_clk_in_n),
            .O (adc0_clk_in)
        );

    IBUFGDS #(
            .IOSTANDARD("LVDS_25")      // Specify the input I/O standard
            )
        IBUFGDS_AD10CLK (
            .I (adc1_clk_in_p),
            .IB(adc1_clk_in_n),
            .O (adc1_clk_in)
        );

    IBUFDS #(
            .IOSTANDARD("LVDS_25")      // Specify the input I/O standard
            )
        IBUFDS_ADC2CLK (
            .I (adc2_clk_in_p),
            .IB(adc2_clk_in_n),
            .O (adc2_clk_in)
        );

    IBUFDS #(
            .IOSTANDARD("LVDS_25")      // Specify the input I/O standard
            )
        IBUFDS_ADC3CLK (
            .I (adc3_clk_in_p),
            .IB(adc3_clk_in_n),
            .O (adc3_clk_in)
        );

    IBUFDS #(
            .IOSTANDARD("LVDS_25")     // Specify the input I/O standard
            )
        IBUFDS_ADC0DATA [7:0] (
            .I (adc0_data_in_p),
            .IB(adc0_data_in_n),
            .O (adc0_data_in)
        );

    IBUFDS #(
            .IOSTANDARD("LVDS_25")     // Specify the input I/O standard
            )
        IBUFDS_ADC1DATA [7:0] (
            .I (adc1_data_in_p),
            .IB(adc1_data_in_n),
            .O (adc1_data_in)
        );

    IBUFDS #(
            .IOSTANDARD("LVDS_25")     // Specify the input I/O standard
            )
        IBUFDS_ADC2DATA [7:0] (
            .I (adc2_data_in_p),
            .IB(adc2_data_in_n),
            .O (adc2_data_in)
        );

    IBUFDS #(
            .IOSTANDARD("LVDS_25")     // Specify the input I/O standard
            )
        IBUFDS_ADC3DATA [7:0] (
            .I (adc3_data_in_p),
            .IB(adc3_data_in_n),
            .O (adc3_data_in)
        );

    IBUFDS #(
            .IOSTANDARD("LVDS_25")     // Specify the input I/O standard
            )
        IBUFDS_SYNC (
            .I (sync_in_p),
            .IB(sync_in_n),
            .O (sync_in)
        );

    BUFG BUFG_ADC0CLK (
            .I(adc0_clk_buf),
            .O(adc0_clk)
        );

    BUFG BUFG_ADC0CLK90 (
            .I(adc0_clk_90_buf),
            .O(adc0_clk_90)
        );

    BUFG BUFG_ADC0CLK180 (
            .I(adc0_clk_180_buf),
            .O(adc0_clk_180)
        );

    BUFG BUFG_ADC0CLK270 (
            .I(adc0_clk_270_buf),
            .O(adc0_clk_270)
        );

    BUFG BUFG_ADC0CLK2X (
            .I(adc0_clk_2x_buf),
            .O(adc0_clk_2x)
        );


// =====================================================================
// Generated DCM instantiation based on target clock frequency; use
// "LOW" DFS/DLL frequency mode if < 120MHz (V5-specific target)

generate
    begin: GEN_DCM
        if (CLK_FREQ < 120) begin
            DCM #(
                .CLKIN_DIVIDE_BY_2    ("FALSE"),                // TRUE/FALSE to enable clk_in divide by two feature
                .CLKOUT_PHASE_SHIFT   ("NONE"),                 // Specify phase shift of NONE, FIXED or VARIABLE
                .CLKIN_PERIOD         (1000/CLK_FREQ),          // Specify period of input clock
                .CLK_FEEDBACK         ("1X"),                   // Specify clock feedback of NONE, 1X or 2X
                .DESKEW_ADJUST        ("SYSTEM_SYNCHRONOUS"),   // SOURCE_SYNCHRONOUS, SYSTEM_SYNCHRONOUS or
                                                                // an integer from 0 to 15
                .DFS_FREQUENCY_MODE   ("LOW"),                  // HIGH or LOW frequency mode for frequency synthesis
                .DLL_FREQUENCY_MODE   ("LOW"),                  // HIGH or LOW frequency mode for DLL
                .DUTY_CYCLE_CORRECTION("TRUE"),                 // Duty cycle correction, TRUE or FALSE
                .FACTORY_JF           (16'hC080),               // FACTORY JF values
                .PHASE_SHIFT          (0),                      // Amount of fixed phase shift from -255 to 255
                .STARTUP_WAIT         ("FALSE")                 // Delay configuration DONE until DCM LOCK, TRUE/FALSE
            ) DCM_ADC0CLK (
                .CLKIN   (adc0_clk_in),                         // Clock input (from IBUFG, BUFG or DCM)
                .CLK0    (adc0_clk_buf),                        // 0 degree DCM CLK output
                .CLK90   (adc0_clk_90_buf),                     // 90 degree DCM CLK output
                .CLK180  (adc0_clk_180_buf),                    // 180 degree DCM CLK output
                .CLK270  (adc0_clk_270_buf),                    // 270 degree DCM CLK output
                .CLK2X   (adc0_clk_2x_buf),                     // 2X DCM CLK output
                .CLK2X180(),                                    // 2X, 180 degree DCM CLK out
                .CLKDV   (),                                    // Divided DCM CLK out (CLKDV_DIVIDE)
                .CLKFX   (),                                    // DCM CLK synthesis out (M/D)
                .CLKFX180(),                                    // 180 degree CLK synthesis out
                .CLKFB   (adc0_clk),                            // DCM clock feedback
                .LOCKED  (dcm_adc0_locked),                     // DCM LOCK status output
                .PSDONE  (),                                    // Dynamic phase adjust done output
                .STATUS  (dcm_adc0_status),                     // 8-bit DCM status bits output
                .PSCLK   (),                                    // Dynamic phase adjust clock input
                .PSEN    (),                                    // Dynamic phase adjust enable input
                .PSINCDEC(),                                    // Dynamic phase adjust increment/decrement
                .RST     (dcm_reset | reset)                    // DCM asynchronous reset input
            );
        end // if (CLK_FREQ < 100
        else begin
            DCM #(
                .CLKIN_DIVIDE_BY_2    ("FALSE"),                // TRUE/FALSE to enable clk_in divide by two feature
                .CLKOUT_PHASE_SHIFT   ("NONE"),                 // Specify phase shift of NONE, FIXED or VARIABLE
                .CLKIN_PERIOD         (1000/CLK_FREQ),          // Specify period of input clock
                .CLK_FEEDBACK         ("1X"),                   // Specify clock feedback of NONE, 1X or 2X
                .DESKEW_ADJUST        ("SYSTEM_SYNCHRONOUS"),   // SOURCE_SYNCHRONOUS, SYSTEM_SYNCHRONOUS or
                                                                // an integer from 0 to 15
                .DFS_FREQUENCY_MODE   ("HIGH"),                 // HIGH or LOW frequency mode for frequency synthesis
                .DLL_FREQUENCY_MODE   ("HIGH"),                 // HIGH or LOW frequency mode for DLL
                .DUTY_CYCLE_CORRECTION("TRUE"),                 // Duty cycle correction, TRUE or FALSE
                .FACTORY_JF           (16'hC080),               // FACTORY JF values
                .PHASE_SHIFT          (0),                      // Amount of fixed phase shift from -255 to 255
                .STARTUP_WAIT         ("FALSE")                 // Delay configuration DONE until DCM LOCK, TRUE/FALSE
            ) DCM_ADC0CLK (
                .CLKIN   (adc0_clk_in),                         // Clock input (from IBUFG, BUFG or DCM)
                .CLK0    (adc0_clk_buf),                        // 0 degree DCM CLK output
                .CLK90   (adc0_clk_90_buf),                     // 90 degree DCM CLK output
		.CLK180  (adc0_clk_180_buf),                    // 180 degree DCM CLK output
                .CLK270  (adc0_clk_270_buf),                    // 270 degree DCM CLK output
                .CLK2X   (adc0_clk_2x_buf),                     // 2X DCM CLK output
                .CLK2X180(),                                    // 2X, 180 degree DCM CLK out
                .CLKDV   (),                                    // Divided DCM CLK out (CLKDV_DIVIDE)
                .CLKFX   (),                                    // DCM CLK synthesis out (M/D)
                .CLKFX180(),                                    // 180 degree CLK synthesis out
                .CLKFB   (adc0_clk),                            // DCM clock feedback
                .LOCKED  (dcm_adc0_locked),                     // DCM LOCK status output
                .PSDONE  (),                                    // Dynamic phase adjust done output
                .STATUS  (dcm_adc0_status),                     // 8-bit DCM status bits output
                .PSCLK   (),                                    // Dynamic phase adjust clock input
                .PSEN    (),                                    // Dynamic phase adjust enable input
                .PSINCDEC(),                                    // Dynamic phase adjust increment/decrement
                .RST     (dcm_reset | reset)                    // DCM asynchronous reset input
            );
        end // else
   end // GEN_DCM
endgenerate

// Generated DCM instantiation
// =====================================================================

    async_fifo_generator_v2_2_33x16 async_fifo_adc_data (
        	.wr_clk  (adc0_clk),
	        .rd_clk  (user_clk),
	        .rst     (reset),
	        .wr_en   (1'b1),
	        .rd_en   (fifo_rd_en),
	        .din     ({fifo_adc0, fifo_adc1, fifo_adc2, fifo_adc3, fifo_sync}),
	        .dout    ({adc0_data, adc1_data, adc2_data, adc3_data, sync}),
	        .empty   (fifo_empty),
	        .full    (),
	        .valid   (fifo_valid)
    );

    assign  adc0_clk90 = adc0_clk_90;
    assign  adc0_clk180 = adc0_clk_180;
    assign  adc0_clk270 = adc0_clk_270;
    assign  valid      = fifo_valid;

    always @ (negedge adc0_clk) begin
        adc0_data_capture <= adc0_data_in;
        adc1_data_capture <= adc1_data_in;
        adc2_data_capture <= adc2_data_in;
        adc3_data_capture <= adc3_data_in;

        sync_capture <= sync_in;
    end

    always @ (posedge adc0_clk_90) begin
        adc0_data_recapture <= adc0_data_capture;
        adc1_data_recapture <= adc1_data_capture;
        adc2_data_recapture <= adc2_data_capture;
        adc3_data_recapture <= adc3_data_capture;

        sync_recapture <= sync_capture;
    end

    always @ (posedge adc0_clk) begin
        fifo_adc0 <= adc0_data_recapture;
        fifo_adc1 <= adc1_data_recapture;
        fifo_adc2 <= adc2_data_recapture;
        fifo_adc3 <= adc3_data_recapture;

        fifo_sync <= sync_recapture;
    end

    always @ (posedge user_clk) begin
        if (reset)
            fifo_rd_en <= 1'b0;
        else
            fifo_rd_en <= ~fifo_empty;
    end

endmodule // quadc_interface
