module calibration_fsm(
	dcm_psclk,
	ctrl_reset,
	adc1_ps_overflow,
	adc0_dcm_locked,
	adc1_dcm_locked,
	adc0_user_data_valid,
	adc1_user_data_valid,
	valid_interleave,	
	ps_shift_count,
	sample_valid,
	edge_found,
	adc1_dcm_psdone,
    interleaved_sampler_done,

	SYNC_STATE,
	adc1_dcm_psen,
	adc1_dcm_psincdec,
	ps_shift_count_en,
	clk_sample_req,
	adc1_dcm_reset,
	valid_ps_counts,
    adc1_reset,
    check_interleaved
);

// Inputs and Outputs
//===================
input dcm_psclk;
input ctrl_reset;
input adc1_ps_overflow;
input adc0_dcm_locked;
input adc1_dcm_locked;
input adc0_user_data_valid;
input adc1_user_data_valid;
input valid_interleave;
input [9:0] ps_shift_count;
input sample_valid;
input edge_found;
input adc1_dcm_psdone;
input interleaved_sampler_done;

output reg [4:0] SYNC_STATE;
output [127:0] valid_ps_counts;
output adc1_dcm_psen;
output ps_shift_count_en;
output clk_sample_req;
output adc1_dcm_psincdec;
output adc1_dcm_reset;
output adc1_reset;
output check_interleaved;

// Wires and Regs
//===============
reg [4:0] SYNC_NEXT_STATE;
reg adc1_reset;
reg adc1_dcm_reset;
reg adc1_dcm_psen;
reg adc1_dcm_psincdec;
reg clk_sample_req;
reg shift_back_count_en;
reg ps_shift_count_en;
reg shift_back_count_rst;
reg sync_done;
reg phase_save_en;
reg check_interleaved;
wire [31:0] delay_count;

// Module Declarations
//====================
ShiftRegister valid_phase_reg (
	.Clock(dcm_psclk),
	.Reset(ctrl_reset),
	.Enable(phase_save_en),
	.Load(1'b0),
	.SOut(),
	.POut(valid_ps_counts),
	.SIn(ps_shift_count[7:0]),
	.PIn()
);
defparam valid_phase_reg.pwidth = 128;
defparam valid_phase_reg.swidth = 8;

Counter delay_counter (
	.Clock(dcm_psclk),
	.Reset(ctrl_reset),
	.Set(0),
	.Load(0),
	.Enable(1'b1),
	.In(10'b0),
	.Count(delay_count)
);

// FSM
//====


parameter STATE_IDLE = 0;
parameter STATE_CHECK_INTERLEAVE = 1;
parameter STATE_SHIFT = 2;
parameter STATE_SAVE_PHASE = 3;
parameter STATE_BEGIN_RESET = 4;
parameter STATE_WAIT = 5;
parameter STATE_SAMPLE = 6;
parameter STATE_WAIT_SAMPLE = 7;
parameter STATE_CHECK_EDGE_FOUND = 8;
parameter STATE_RESET_ADC1_DCM = 9;
parameter STATE_REQUEST_CHECK_INTERLEAVE = 10;
parameter STATE_CHIPSCOPE_STALL = 11;

always @ (posedge dcm_psclk) begin
  if (ctrl_reset) begin
    SYNC_STATE <= STATE_CHIPSCOPE_STALL;
  end else begin
    SYNC_STATE <= SYNC_NEXT_STATE;
  end
end

always @ ( * ) begin
	adc1_reset = 0;
	adc1_dcm_reset = 0;
	adc1_dcm_psen = 0;
	adc1_dcm_psincdec = 1;
	clk_sample_req = 0;
	shift_back_count_en = 0;
	ps_shift_count_en = 0;
	shift_back_count_rst = 0;
	sync_done = 0;
	SYNC_NEXT_STATE = SYNC_STATE;
	phase_save_en = 0;
	check_interleaved = 0;

	case (SYNC_STATE)
        STATE_CHIPSCOPE_STALL: begin
          if (delay_count == 32'hffffffff) begin
            SYNC_NEXT_STATE = STATE_IDLE;
          end
        end

		STATE_IDLE: begin
			if (adc1_ps_overflow) begin
				SYNC_NEXT_STATE = STATE_BEGIN_RESET;
			end else if (adc0_dcm_locked && adc1_dcm_locked && ~adc1_ps_overflow) begin
				SYNC_NEXT_STATE = STATE_SHIFT;//STATE_REQUEST_CHECK_INTERLEAVE;
			end
		end

        STATE_REQUEST_CHECK_INTERLEAVE: begin
          check_interleaved = 1;
          if (~interleaved_sampler_done) begin
            check_interleaved = 0;
            SYNC_NEXT_STATE = STATE_CHECK_INTERLEAVE;
          end
        end

        STATE_CHECK_INTERLEAVE: begin
			sync_done = 1;
			if (valid_interleave && interleaved_sampler_done ) begin
				SYNC_NEXT_STATE = STATE_SHIFT;
			end else if (interleaved_sampler_done) begin
				SYNC_NEXT_STATE = STATE_BEGIN_RESET;
			end
		end

		STATE_SHIFT: begin
			adc1_dcm_psen = 1;
			ps_shift_count_en = 1;
			SYNC_NEXT_STATE = STATE_WAIT;
		end

		STATE_WAIT: begin
			if (adc1_dcm_psdone) begin
				SYNC_NEXT_STATE = STATE_SAMPLE;
			end
		end

		STATE_SAMPLE: begin
			clk_sample_req = 1;
			if (~sample_valid) begin
				SYNC_NEXT_STATE = STATE_WAIT_SAMPLE;
			end
		end
		
		STATE_WAIT_SAMPLE: begin
			if (sample_valid) begin
				SYNC_NEXT_STATE = STATE_CHECK_EDGE_FOUND;
			end
		end

		STATE_CHECK_EDGE_FOUND: begin
			if (edge_found)	begin
				SYNC_NEXT_STATE = STATE_SAVE_PHASE;
			end else begin
				SYNC_NEXT_STATE = STATE_SHIFT;
			end
		end

		STATE_SAVE_PHASE: begin
			phase_save_en = 1;
			SYNC_NEXT_STATE = STATE_BEGIN_RESET;
		end

		STATE_BEGIN_RESET: begin
			adc1_reset = 1;
			if (~adc1_dcm_locked) begin
				SYNC_NEXT_STATE = STATE_RESET_ADC1_DCM;
			end
		end

		STATE_RESET_ADC1_DCM: begin
			adc1_dcm_reset = 1;
			SYNC_NEXT_STATE = STATE_IDLE;
		end
        
        default: begin
            SYNC_NEXT_STATE = STATE_IDLE;
        end
	endcase
end
		
endmodule
