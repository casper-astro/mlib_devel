`timescale 1ns/1ps
module clock_sync_fsm(
  dcm_psclk, 
  adc0_clk, 
  adc1_clk, 
  ctrl_reset, 
  adc0_dcm_locked, 
  adc1_dcm_locked,
  dcm_psdone,
  adc1_reset,
  adc1_dcm_psen,
  adc1_dcm_psincdec,
  adc_clocks_locked,
  STATE,
  falling_edge_detected,
  shift_count,

	clk_sample_req,
	clk_sample,
	clk_sample_valid,
	shift_done,
	shift_req,
	save_clk_sample,
	adc1_reset_req,
	adc1_reset_done
);

// Inputs and Outputs
//===================
input dcm_psclk;
input adc0_clk;
input adc1_clk;
input ctrl_reset;
input adc0_dcm_locked;
input adc1_dcm_locked;
input dcm_psdone;
  
output adc1_reset;
output adc1_dcm_psen;
output adc1_dcm_psincdec;
output adc_clocks_locked;
output [3:0] STATE;
output falling_edge_detected;
output [7:0] shift_count;


output clk_sample_req;
output clk_sample;
output clk_sample_valid;
output shift_done; 
output shift_req;
output save_clk_sample;
output adc1_reset_req;
output adc1_reset_done;
 
// Regs and Wires
//===============
reg clk_sample_req;
//wire clk_sample;
//wire clk_sample_valid;
//wire shift_done;
reg adc1_dcm_psincdec;
reg [3:0] STATE, NEXT_STATE;
reg shift_req;
//wire [7:0] shift_count;
reg save_clk_sample;
//wire falling_edge_detected;
reg adc_clocks_locked;
reg adc1_reset_req;
//wire adc1_reset_done;

// Module Declarations
//====================
clock_sample clock_sample (
  .clock(adc0_clk),
  .din(adc1_clk),
  .reset(ctrl_reset | adc1_reset),
  .sample_req(clk_sample_req),
  .dout(clk_sample),
  .sample_valid(clk_sample_valid)
);

phase_shift phase_shift(
  .clock(dcm_psclk),
  .reset(ctrl_reset | adc1_reset),
  .shift_done(shift_done),
  .shift_req(shift_req),
  .shift_count(shift_count),
  .dcm_psen(adc1_dcm_psen),
  .dcm_psincdec(adc1_dcm_psincdec),
  .dcm_psdone(dcm_psdone)
);

negedge_detect negedge_detect (
  .clock(dcm_psclk),
  .reset(ctrl_reset),
  .din(clk_sample),
  .en(save_clk_sample),
  .falling_edge_detected(falling_edge_detected)
);


reset_adc reset_adc1 (
	.clock(dcm_psclk),
	.reset(ctrl_reset),
	.reset_req( adc1_reset_req ),
	.reset_line(adc1_reset),
	.done(adc1_reset_done)
);


// FSM
//====  
parameter STATE_WAIT_FOR_DCM_LOCK = 0;
parameter STATE_INIT_PS = 1;
parameter STATE_PS_WAIT = 2;
parameter STATE_SAVE_SAMPLE = 3;
parameter STATE_CHECK_PHASE = 4;
parameter STATE_RESET_ADC1 = 5;
parameter STATE_SHIFT_BACK = 6;
parameter STATE_DONE = 7;
parameter STATE_WAIT_RESET_ADC = 8;
always @ (posedge dcm_psclk) begin
  if (ctrl_reset | adc1_reset) begin
    STATE <= STATE_WAIT_FOR_DCM_LOCK;
  end else begin
    STATE <= NEXT_STATE;
  end
end

always @ ( * ) begin
 	adc1_reset_req = 0;
  shift_req = 0;
  save_clk_sample = 0;
  adc_clocks_locked = 0;
  NEXT_STATE = STATE;
  adc1_dcm_psincdec = 0;
  case (STATE)
    STATE_WAIT_FOR_DCM_LOCK: begin
      if (adc0_dcm_locked && adc1_dcm_locked) begin
        NEXT_STATE = STATE_INIT_PS;
      end
    end
    
    STATE_INIT_PS: begin
      adc1_dcm_psincdec = 1;
      shift_req = 1;
      NEXT_STATE = STATE_PS_WAIT;
    end
    
    STATE_PS_WAIT: begin
      adc1_dcm_psincdec = 1;
      if (dcm_psdone) begin
        NEXT_STATE = STATE_SAVE_SAMPLE;
      end
    end
    
    STATE_SAVE_SAMPLE: begin
      save_clk_sample = 1;
      if (falling_edge_detected) begin
        NEXT_STATE = STATE_CHECK_PHASE;
      end else begin
        NEXT_STATE = STATE_INIT_PS;
      end
    end
    
    STATE_CHECK_PHASE: begin
      if (shift_count > 12 && shift_count < 20) begin
        NEXT_STATE = STATE_SHIFT_BACK;
      end
    end
    
    STATE_RESET_ADC1: begin
      adc1_reset_req = 1;
      NEXT_STATE = STATE_WAIT_RESET_ADC;
    end
    
		STATE_WAIT_RESET_ADC: begin
			if (adc1_reset_done) begin
				NEXT_STATE = STATE_WAIT_FOR_DCM_LOCK;
			end
		end

    STATE_SHIFT_BACK: begin
      if (shift_count == 0) begin
        NEXT_STATE = STATE_DONE;
      end else begin
        shift_req = 1;
      end
    end
    
    STATE_DONE: begin
      adc_clocks_locked = 1;
      NEXT_STATE = STATE_DONE;
    end 
    
  endcase
end


      
  

endmodule
