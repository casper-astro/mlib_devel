// test file
module clock_sync_fsm (
	adc0_clk90,
	adc0_clk180,
	adc0_clk270,
	adc0_clk,
	adc1_clk,
	ctrl_reset,
	dcm_psclk,
	adc0_dcm_locked,
	adc1_dcm_locked,
	
	adc1_reset,
	sync_done	

);

// Inputs and Outputs
//===================
input adc0_clk;
input adc0_clk90;
input adc0_clk180;
input adc0_clk270;
input adc1_clk;
input ctrl_reset;
input dcm_psclk;
input adc0_dcm_locked;
input adc1_dcm_locked;

output adc1_reset;
output sync_done;

// Wires and Regs
//===============
// Sampler wires
wire clk_sample0;
wire clk_sample_valid0;
wire clk_sample_error0;
wire clk_sample_idle0;
wire clk_sample90;
wire clk_sample_valid90;
wire clk_sample_error90;
wire clk_sample_idle90;
wire clk_sample180;
wire clk_sample_valid180;
wire clk_sample_error180;
wire clk_sample_idle180;
wire clk_sample270;
wire clk_sample_valid270;
wire clk_sample_error270;
wire clk_sample_idle270;

// Reset blocks
wire reset_start0;
wire reset_start90;
wire reset_start180;
wire reset_start270;
wire adc1_reset0;
wire adc1_reset90;
wire adc1_reset180;
wire adc1_reset270;

// Delay Counter
wire [31:0] delay_count;

// FSM regs
reg clk_sample_req;
reg reset_start;
reg sampler_rst;
reg adc1_reset_block_rst;
reg sync_done;
reg delay_count_rst;


// FSM state machine registers
reg [3:0] state;
reg [3:0] next_state;


// Module Declarations
//====================
	clock_sample clock_sample0 (
		.clock(adc0_clk),
		.din(adc1_clk),
		.reset(ctrl_reset | sampler_rst),
		.dout(clk_sample0),
		.sample_req(clk_sample_req),
		.sample_valid(clk_sample_valid0),
		.sample_error(clk_sample_error0),
    .sample_idle(clk_sample_idle0)
	);
	
	clock_sample clock_sample90 (
		.clock(adc0_clk90),
		.din(adc1_clk),
		.reset(ctrl_reset | sampler_rst),
		.dout(clk_sample90),
		.sample_req(clk_sample_req),
		.sample_valid(clk_sample_valid90),
		.sample_error(clk_sample_error90),
	    .sample_idle(clk_sample_idle90)
	);
	
	clock_sample clock_sample180 (
		.clock(adc0_clk180),
		.din(adc1_clk),
		.reset(ctrl_reset | sampler_rst),
		.dout(clk_sample180),
		.sample_req(clk_sample_req),
		.sample_valid(clk_sample_valid180),
		.sample_error(clk_sample_error180),
	    .sample_idle(clk_sample_idle180)
	);
	
	clock_sample clock_sample270 (
		.clock(adc0_clk270),
		.din(adc1_clk),
		.reset(ctrl_reset | sampler_rst),
		.dout(clk_sample270),
		.sample_req(clk_sample_req),
		.sample_valid(clk_sample_valid270),
		.sample_error(clk_sample_error270),
	    .sample_idle(clk_sample_idle270)
	);
	
	Counter reset_clock_counter (
	  .Clock(dcm_psclk),
	  .Reset(ctrl_reset),
		.Set(0),
		.Load(0),
		.Enable(reset_start),
		.In(10'b0),
		.Count(reset_clock)
	);
	defparam reset_clock_counter.width = 2;
	assign reset_start0 = (reset_clock == 2'd0);
	assign reset_start90 = (reset_clock == 2'd1);
	assign reset_start180 = (reset_clock == 2'd2);
	assign reset_start270 = (reset_clock == 2'd3);
	
	adc_reset adc1_reset_block0 (
	  .base_clk(dcm_psclk),
	  .reset_clk(adc0_clk),
	  .system_reset(ctrl_reset | adc1_reset_block_rst),
	  .reset_output(adc1_reset0),
	  .reset_start(reset_start0 & reset_start)
	  );
	
	adc_reset adc1_reset_block90 (
	  .base_clk(dcm_psclk),
	  .reset_clk(adc0_clk90),
	  .system_reset(ctrl_reset | adc1_reset_block_rst),
	  .reset_output(adc1_reset90),
	  .reset_start(reset_start90 & reset_start)
	  );
	
	adc_reset adc1_reset_block180 (
	  .base_clk(dcm_psclk),
	  .reset_clk(adc0_clk180),
	  .system_reset(ctrl_reset | adc1_reset_block_rst),
	  .reset_output(adc1_reset180),
	  .reset_start(reset_start180 & reset_start)
	);
	
	adc_reset adc1_reset_block270 (
	  .base_clk(dcm_psclk),
	  .reset_clk(adc0_clk270),
	  .system_reset(ctrl_reset | adc1_reset_block_rst),
	  .reset_output(adc1_reset270),
	  .reset_start(reset_start270 & reset_start)
	);
	
	assign adc1_reset = adc1_reset0 | adc1_reset90 | adc1_reset180 | adc1_reset270;
	
	Counter delay_counter (
		.Clock(dcm_psclk),
		.Reset(ctrl_reset | delay_count_rst),
		.Set(0),
		.Load(0),
		.Enable(1'b1),
		.In(10'b0),
		.Count(delay_count)
	);


// FSM
//====
// State Declarations
	parameter state_init = 4'd0;
	parameter state_reset_adc = 4'd1;
	parameter state_wait_adc = 4'd2;
	parameter state_wait_dcm = 4'd3;
	parameter state_sample_clocks = 4'd4;
	parameter state_decide = 4'd5;
	parameter state_done = 4'd6; 

// Update State registers
	always @ (posedge dcm_psclk) begin
	  if (ctrl_reset) begin
	    state <= state_init;
	  end else begin
	    state <= next_state;
	  end
	end

// Next State logic
	always @ ( * ) begin
	  sampler_rst = 0;
	  adc1_reset_block_rst = 0;
	  reset_start = 0;
	  sync_done = 0;
	  next_state = state;
	  delay_count_rst = 0;
	  clk_sample_req = 0;
	  case (state)
	    state_init: begin
	      if (delay_count > 32'd125000000) begin
	        next_state = state_reset_adc;
	      end
	    end
	
	    state_reset_adc: begin
	      delay_count_rst = 1;
	      reset_start = 1;
	      next_state = state_wait_adc;
	    end
	
	    state_wait_adc: begin
	      if (delay_count > 2000) begin
	        next_state = state_wait_dcm;
	      end
	    end
	
	    state_wait_dcm: begin
	      sampler_rst = 1;
	      if (adc0_dcm_locked && adc1_dcm_locked) begin
	        next_state = state_sample_clocks;
	      end
	    end
	
	    state_sample_clocks: begin
	      clk_sample_req = 1;
	      if (clk_sample_valid0 && clk_sample_valid90 && clk_sample_valid180 && clk_sample_valid270) begin
	        next_state = state_decide;
	      end
	    end
	
	    state_decide: begin
	      adc1_reset_block_rst = 1;
	      delay_count_rst = 1;
	      if (clk_sample180 && clk_sample90) begin
	        next_state = state_done;
	      end else begin
	        next_state = state_reset_adc;
	      end
	    end
	
	    state_done: begin
	      // assert some sort of done signal
	      sync_done = 1;
	      next_state = state_done;
	    end
	
	    default: begin
	      next_state = state_reset_adc;
	    end
	  endcase
	end

endmodule

