module adc_ltc2308_stream #(
    parameter [2:0] DEFAULT_CH = 3'd0,
    parameter integer FRAME_LEN = 1024,
    parameter integer OUT_W = 18,
    parameter CENTER_DATA = 1  // 1: subtract 2048, 0: zero-extend raw ADC code
)(
    input  wire              clk,
    input  wire              rst_n,
    input  wire              enable,

    output wire              ADC_CONVST,
    output wire              ADC_SCK,
    output wire              ADC_SDI,
    input  wire              ADC_SDO,

    output reg  [OUT_W-1:0]  sample_data,
    output reg               sample_valid,
    output reg  [7:0]        sample_sync
);

    // ------------------------------------------------------------
    // Interface to low-level ADC engine
    // ------------------------------------------------------------
    reg         measure_start;
    wire        measure_done;
    wire [11:0] measure_dataread;
    wire [2:0]  measure_ch;

    assign measure_ch = DEFAULT_CH;

    adc_ltc2308 adc_ltc2308_inst (
        .clk(clk),
        .rst_n(rst_n),
        .measure_start(measure_start),
        .measure_done(measure_done),
        .measure_ch(measure_ch),
        .measure_dataread(measure_dataread),
        .ADC_CONVST(ADC_CONVST),
        .ADC_SCK(ADC_SCK),
        .ADC_SDI(ADC_SDI),
        .ADC_SDO(ADC_SDO)
    );

    // ------------------------------------------------------------
    // Stream-generation state machine
    // Based on adc_ltc2308_fifo measurement FSM, but without FIFO/Avalon.
    // ------------------------------------------------------------
    localparam [1:0]
        MS_IDLE     = 2'd0,
        MS_START    = 2'd1,
        MS_WAITDONE = 2'd2,
        MS_DONE     = 2'd3;

    reg [1:0]  ms_state;
    reg        config_first;
    reg [31:0] frame_count;

    // Center ADC around zero if desired:
    // raw 12-bit unipolar 0..4095 -> signed -2048..+2047
    wire signed [12:0] centered_sample = {1'b0, measure_dataread} - 13'sd2048;
    wire signed [OUT_W-1:0] centered_ext =
        {{(OUT_W-13){centered_sample[12]}}, centered_sample};

    wire [OUT_W-1:0] raw_ext =
        {{(OUT_W-12){1'b0}}, measure_dataread};

    wire [OUT_W-1:0] next_sample =
        CENTER_DATA ? centered_ext : raw_ext;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            ms_state      <= MS_IDLE;
            measure_start <= 1'b0;
            config_first  <= 1'b1;
            frame_count   <= 32'd0;

            sample_data   <= {OUT_W{1'b0}};
            sample_valid  <= 1'b0;
            sample_sync   <= 8'd0;
        end else begin
            // defaults
            measure_start <= 1'b0;
            sample_valid  <= 1'b0;
            sample_sync   <= 8'd0;

            case (ms_state)
                MS_IDLE: begin
                    if (!enable) begin
                        config_first <= 1'b1;
                        frame_count  <= 32'd0;
                    end else begin
                        ms_state <= MS_START;
                    end
                end

                MS_START: begin
                    // one-cycle kick to adc_ltc2308
                    measure_start <= 1'b1;
                    ms_state      <= MS_WAITDONE;
                end

                MS_WAITDONE: begin
                    if (measure_done) begin
                        if (config_first) begin
                            // first conversion after enable/reset is config; ignore it
                            config_first <= 1'b0;
                        end else begin
                            sample_data  <= next_sample;
                            sample_valid <= 1'b1;

                            if (frame_count == 0)
                                sample_sync <= 8'd1;

                            if (frame_count == FRAME_LEN-1)
                                frame_count <= 32'd0;
                            else
                                frame_count <= frame_count + 1'b1;
                        end

                        if (enable)
                            ms_state <= MS_START;
                        else
                            ms_state <= MS_DONE;
                    end
                end

                MS_DONE: begin
                    if (!enable) begin
                        config_first <= 1'b1;
                        frame_count  <= 32'd0;
                        ms_state     <= MS_IDLE;
                    end else begin
                        ms_state <= MS_START;
                    end
                end

                default: begin
                    ms_state <= MS_IDLE;
                end
            endcase
        end
    end

endmodule
