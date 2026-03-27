module adc_ltc2308(
    input  wire        clk,
    input  wire        rst_n,

    input  wire        measure_start,
    input  wire [2:0]  measure_ch,

    output reg         measure_done,
    output reg  [11:0] measure_dataread,

    output reg         ADC_CONVST,
    output reg         ADC_SCK,
    output reg         ADC_SDI,
    input  wire        ADC_SDO
);

    localparam integer CONVST_HIGH_CYC = 2;
    localparam integer CONV_WAIT_CYC   = 64;

    localparam integer CMD_BITS  = 6;
    localparam integer DATA_BITS = 12;

    localparam UNI_MODE = 1'b1;
    localparam SLP_MODE = 1'b0;

    function [3:0] ch_to_nibble;
        input [2:0] ch;
        begin
            case (ch)
                3'd0: ch_to_nibble = 4'h8;
                3'd1: ch_to_nibble = 4'hC;
                3'd2: ch_to_nibble = 4'h9;
                3'd3: ch_to_nibble = 4'hD;
                3'd4: ch_to_nibble = 4'hA;
                3'd5: ch_to_nibble = 4'hE;
                3'd6: ch_to_nibble = 4'hB;
                3'd7: ch_to_nibble = 4'hF;
                default: ch_to_nibble = 4'hF;
            endcase
        end
    endfunction

    // edge detect start
    reg pre_start;
    wire start_pulse = measure_start & ~pre_start;

    localparam [2:0]
        ST_IDLE        = 3'd0,
        ST_CONVST_HIGH = 3'd1,
        ST_CONV_WAIT   = 3'd2,
        ST_SHIFT       = 3'd3,
        ST_DONE        = 3'd4;

    reg [2:0] state;
    integer   wait_cnt;

    // 12-bit shift control
    reg       sck_phase;   // 0->1 rising, 1->0 falling (we toggle each clk)
    integer   bit_idx;     // 0..11, increments once per FULL SCK (on rising)

    reg [5:0]  cmd_sr;     // {S/D, O/S, S1, S0, UNI, SLP}
    reg [11:0] rd_sr;
	 reg sdi_hold;
    
	 always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pre_start        <= 1'b0;
            state            <= ST_IDLE;
            wait_cnt         <= 0;

            ADC_CONVST       <= 1'b0;
            ADC_SCK          <= 1'b0;
            ADC_SDI          <= 1'b0;

            measure_done     <= 1'b0;
            measure_dataread <= 12'd0;

            sck_phase        <= 1'b0;
            bit_idx          <= 0;
            cmd_sr           <= 6'd0;
            rd_sr            <= 12'd0;
        end else begin
            measure_done <= 1'b0;
            measure_done <= 1'b0;
            pre_start    <= measure_start;

            case (state)
                ST_IDLE: begin
                    ADC_CONVST <= 1'b0;
                    ADC_SCK    <= 1'b0;
                    ADC_SDI    <= 1'b0;
                    sck_phase  <= 1'b0;

                    if (start_pulse) begin
                        cmd_sr     <= { ch_to_nibble(measure_ch), UNI_MODE, SLP_MODE };
                        ADC_CONVST <= 1'b1;
                        wait_cnt   <= 0;
                        state      <= ST_CONVST_HIGH;
                    end
                end

                ST_CONVST_HIGH: begin
                    if (wait_cnt >= (CONVST_HIGH_CYC-1)) begin
                        ADC_CONVST <= 1'b0;
                        wait_cnt   <= 0;
                        state      <= ST_CONV_WAIT;
                    end else begin
                        wait_cnt <= wait_cnt + 1;
                    end
                end

                ST_CONV_WAIT: begin
                    if (wait_cnt >= (CONV_WAIT_CYC-1)) begin
                        wait_cnt  <= 0;

                        ADC_SCK   <= 1'b0;
                        sck_phase <= 1'b0;
                        bit_idx   <= 0;
                        rd_sr     <= 12'd0;
	
                        // SDI must be valid BEFORE the first rising edge:
                        // drive cmd[5] now; then cmd[4..0] on subsequent falling edges.
                        ADC_SDI   <= cmd_sr[5];
								sdi_hold <= cmd_sr[CMD_BITS-1];  // cmd[5] for the first clock
                        state     <= ST_SHIFT;
                    end else begin
                        wait_cnt <= wait_cnt + 1;
                    end
                end

                ST_SHIFT: begin
						 // Toggle half-cycle
						 sck_phase <= ~sck_phase;

						 if (!sck_phase) begin
							  // -------- rising half-cycle --------
							  // SCK rises
							  ADC_SCK <= 1'b1;

							  // SDI is held stable by sdi_hold (do NOT change SDI here)
							  // ADC_SDI <= sdi_hold;

							  // SDO was shifted by the ADC on the PREVIOUS falling edge,
							  // so it's stable now -> sample it here.
							  rd_sr[DATA_BITS-1 - bit_idx] <= ADC_SDO;

						 end else begin
							  // -------- falling half-cycle --------
							  // SCK falls (ADC shifts SDO here)
							  ADC_SCK <= 1'b0;

							  // Prepare SDI bit for the *next* rising edge.
							  // For SCK pulses 0..5, drive cmd_sr[5..0] (MSB first).
							  // For pulses 6..11, SDI must be 0.
							  if (bit_idx < (CMD_BITS - 1)) begin
									sdi_hold <= cmd_sr[CMD_BITS-2 - bit_idx];  // cmd[5]..cmd[0]
									ADC_SDI <= cmd_sr[CMD_BITS-2 - bit_idx];
							  end else begin
									sdi_hold <= 1'b0;
									ADC_SDI <= 1'b0;
							  end
							  // Advance bit counter once per full SCK period (here on falling half)
							  if (bit_idx == (DATA_BITS-1)) begin
									state <= ST_DONE;
							  end else begin
									bit_idx <= bit_idx + 1;
							  end
						 end
					 end

                ST_DONE: begin
                    ADC_SCK          <= 1'b0;
                    ADC_SDI          <= 1'b0;
                    measure_dataread <= rd_sr;
                    measure_done     <= 1'b1;
                    state            <= ST_IDLE;
                end

                default: state <= ST_IDLE;
            endcase
        end
    end

endmodule