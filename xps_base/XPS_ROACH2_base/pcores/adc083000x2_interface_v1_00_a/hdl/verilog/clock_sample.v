`timescale 1ns/1ps

module clock_sample(
  clock,
  din,
  reset, 
  sample_req,
  dout,
  sample_valid,
	sample_error,
	sampling_timer_count,
	stable_sample_count,
    sample_idle,
    edge_found,
    ps_shift_count
);

// Module Parameters
//==================
parameter NUM_SAMPLES = 1000;

// Inputs and Outputs
//===================
input clock;
input reset;
input din;
input sample_req;
input [7:0] ps_shift_count;
output dout;
output reg sample_valid;
output reg sample_error;
output [9:0] sampling_timer_count;
output [9:0] stable_sample_count;
output sample_idle;
output edge_found;

// Regs and Wires
//===============
reg sample;
reg [2:0] STATE;
reg [2:0] NEXT_STATE;
reg stable_sample_count_rst;
reg sampling_timer_count_rst;
reg sample_idle;
reg edge_found;
wire [1:0] sample_pout;
reg dout_set;
reg dout_reset;

// Module declarations
//====================
Register dout_register (.Clock(clock), .Reset(reset | dout_reset), .Set(dout_set), .Enable(1'b0), .In(1'b0), .Out(dout));
defparam dout_register.width = 1;

//module Register(Clock, Reset, Set, Enable, In, Out);

// register for clock signal
always @ (posedge clock) begin
  if (reset) begin
    sample <= 0;
  end else begin
    sample <= din;
  end
end

// Shift register to store previous samples and edge-detect
ShiftRegister sample_shift_reg (
	.Clock(clock),
	.Reset(reset),
	.Enable(sample_valid),
	.Load(1'b0),
	.SOut(),
	.POut(sample_pout),
	.SIn(sample),
	.PIn()
);
defparam sample_shift_reg.pwidth = 2;
defparam sample_shift_reg.swidth = 1;

always @ (posedge clock) begin
	if (reset) begin
		edge_found <= 0;
	end else if ((~sample_pout[0] & sample_pout[1]) && ps_shift_count > 1) begin
		edge_found <= 1;
	end
end



// 10-bit counters to count stable samples and clock time
//module	Counter(Clock, Reset, Set, Load, Enable, In, Count);
Counter stable_sample_counter (
	.Clock(clock),
	.Reset(stable_sample_count_rst),
	.Set(1'b0),
	.Load(1'b0),
	.Enable(din),
	.In(10'b0),
	.Count(stable_sample_count)
);
defparam stable_sample_counter.width = 10;

Counter sampling_timer_counter (
	.Clock(clock),
	.Reset(sampling_timer_count_rst),
	.Set(0),
	.Load(0),
	.Enable(1),
	.In(10'b0),
	.Count(sampling_timer_count)
);
defparam sampling_timer_counter.width = 10;

// FSM
//====
parameter STATE_IDLE = 0;
parameter STATE_SAMPLE = 1;
parameter STATE_EXIT_SUCCESS = 2;
parameter STATE_EXIT_FAILURE = 3;

always @ (posedge clock) begin
  if (reset) begin
    STATE <= STATE_IDLE;
  end else begin
    STATE <= NEXT_STATE;
  end
end

always @ ( * ) begin
  sample_idle = 0;
  sample_valid = 0;
  stable_sample_count_rst = 1;
  sampling_timer_count_rst = 1;
  sample_error = 0;
  dout_set = 0;
  dout_reset = 0;
  NEXT_STATE = STATE;

  case (STATE)
    STATE_IDLE: begin
      sample_idle = 1;
      if(sample_req) begin
        sample_idle = 0;
        NEXT_STATE = STATE_SAMPLE;
      end
    end
    
    STATE_SAMPLE: begin
      stable_sample_count_rst = 0;
      sampling_timer_count_rst = 0;
      if ((sampling_timer_count == 1023) && (stable_sample_count == 1023)) begin
        dout_set = 1; 
        NEXT_STATE = STATE_EXIT_SUCCESS;
      end else if ((sampling_timer_count == 1023) && (stable_sample_count == 0)) begin
        dout_reset = 1;
        NEXT_STATE = STATE_EXIT_SUCCESS;
      end else if (sampling_timer_count == 1023) begin
        NEXT_STATE = STATE_EXIT_FAILURE;
      end        
    end
    
    STATE_EXIT_SUCCESS: begin
      sample_valid = 1;
      NEXT_STATE = STATE_EXIT_SUCCESS;
    end
    
    STATE_EXIT_FAILURE: begin
      sample_error = 1;
      NEXT_STATE = STATE_SAMPLE;
    end
  endcase
end

endmodule
//always @ (posedge clock) begin
//  if (reset | stable_sample_count_rst) begin
//    stable_sample_count <= 0;
//  end else if (din) begin
//    stable_sample_count <= stable_sample_count + 1;
//  end
//end
//always @ (posedge clock) begin
//  if (reset | sampling_timer_count_rst) begin
//    sampling_timer_count <= 0;
//  end else begin
//    sampling_timer_count <= sampling_timer_count + 1;
//  end
//end
