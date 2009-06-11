`timescale 1ns / 1ps
module adc086000_interface(
				adc0_clk_p,
				adc0_clk_n,
				adc0_sync_p,
				adc0_sync_n,
				adc0_user_outofrange,
				adc0_user_sync,
				adc0_user_data_valid,
				adc0_outofrange_p,
				adc0_outofrange_n,
				adc0_dataeveni_p,
				adc0_dataeveni_n,
				adc0_dataoddi_p,
				adc0_dataoddi_n,
				adc0_dataevenq_p,
				adc0_dataevenq_n,
				adc0_dataoddq_p,
				adc0_dataoddq_n,
                adc0_reset,
				adc0_user_datai0,
				adc0_user_datai1,
				adc0_user_datai2,
				adc0_user_datai3,
				adc0_user_dataq0,
				adc0_user_dataq1,
				adc0_user_dataq2,
				adc0_user_dataq3,

				adc1_clk_p,
				adc1_clk_n,
				adc1_sync_p,
				adc1_sync_n,
				adc1_user_outofrange,
				adc1_user_sync,
				adc1_user_data_valid,
				adc1_outofrange_p,
				adc1_outofrange_n,
				adc1_dataeveni_p,
				adc1_dataeveni_n,
				adc1_dataoddi_p,
				adc1_dataoddi_n,
				adc1_dataevenq_p,
				adc1_dataevenq_n,
				adc1_dataoddq_p,
				adc1_dataoddq_n,
                adc1_reset,
				adc1_user_datai0,
				adc1_user_datai1,
				adc1_user_datai2,
				adc1_user_datai3,
				adc1_user_dataq0,
				adc1_user_dataq1,
				adc1_user_dataq2,
				adc1_user_dataq3,

				// dcm/ctrl signals
				dcm_reset,
				ctrl_reset,
				ctrl_clk_in,
				ctrl_clk_out,
				ctrl_clk90_out,
				ctrl_clk180_out,
				ctrl_clk270_out,
				ctrl_dcm_locked,
				dcm_psclk,
				dcm_psincdec,
				dcm_psen,
				dcm_psdone
);

// System Parameters
//==================
parameter DEBUG_MODE = 0;
parameter USE_ASYNCH_FIFOS = 1;
parameter CALIBRATION_MODE = 1;

// Inputs and Outputs
//===================
input 				adc0_clk_p;
input					adc0_clk_n;
input [7:0]		adc0_dataeveni_p;
input [7:0]		adc0_dataeveni_n;
input [7:0]		adc0_dataoddi_p;
input [7:0]		adc0_dataoddi_n;
input [7:0]		adc0_dataevenq_p;
input [7:0]		adc0_dataevenq_n;
input [7:0]		adc0_dataoddq_p;
input [7:0]		adc0_dataoddq_n;
input					adc0_outofrange_p;
input					adc0_outofrange_n;
input					adc0_sync_p;
input					adc0_sync_n;
input 				adc1_clk_p;
input					adc1_clk_n;
input [7:0]		adc1_dataeveni_p;
input [7:0]		adc1_dataeveni_n;
input [7:0]		adc1_dataoddi_p;
input [7:0]		adc1_dataoddi_n;
input [7:0]		adc1_dataevenq_p;
input [7:0]		adc1_dataevenq_n;
input [7:0]		adc1_dataoddq_p;
input [7:0]		adc1_dataoddq_n;
input					adc1_outofrange_p;
input					adc1_outofrange_n;
input					adc1_sync_p;
input					adc1_sync_n;
input					dcm_reset;
input					ctrl_reset;
input					ctrl_clk_in;
input					dcm_psclk;
input					dcm_psen;
input					dcm_psincdec;

output				dcm_psdone;
output				ctrl_clk_out;
output				ctrl_clk90_out;
output				ctrl_clk180_out;
output				ctrl_clk270_out;
output				ctrl_dcm_locked;
output				adc1_user_outofrange;
output				adc1_user_sync;
output				adc1_user_data_valid;
output [7:0]	adc1_user_datai0;
output [7:0]	adc1_user_datai1;
output [7:0]	adc1_user_datai2;
output [7:0]	adc1_user_datai3;
output [7:0]	adc1_user_dataq0;
output [7:0]	adc1_user_dataq1;
output [7:0]	adc1_user_dataq2;
output [7:0]	adc1_user_dataq3;
output				adc0_user_outofrange;
output				adc0_user_sync;
output				adc0_user_data_valid;
output [7:0]	adc0_user_datai0;
output [7:0]	adc0_user_datai1;
output [7:0]	adc0_user_datai2;
output [7:0]	adc0_user_datai3;
output [7:0]	adc0_user_dataq0;
output [7:0]	adc0_user_dataq1;
output [7:0]	adc0_user_dataq2;
output [7:0]	adc0_user_dataq3;

output adc0_reset;
output adc1_reset;


// Wires and Regs
//===============
wire adc0_clk_buf;
wire adc0_clk;
wire adc0_clk90;
wire adc0_clk180;
wire adc0_clk270;
wire adc0_clk_dcm;
wire adc0_clk90_dcm;
wire adc0_clk180_dcm;
wire adc0_clk270_dcm;
wire [7:0] adc0_data_eveni;
wire [7:0] adc0_data_oddi;
wire [7:0] adc0_data_evenq;
wire [7:0] adc0_data_oddq;
wire [7:0] adc0_user_datai0_asynch;
wire [7:0] adc0_user_datai1_asynch;
wire [7:0] adc0_user_datai2_asynch;
wire [7:0] adc0_user_datai3_asynch;
wire [7:0] adc0_user_dataq0_asynch;
wire [7:0] adc0_user_dataq1_asynch;
wire [7:0] adc0_user_dataq2_asynch;
wire [7:0] adc0_user_dataq3_asynch;
wire adc0_sync; // ddr
wire adc0_sync_rise;
wire adc0_sync_fall;
wire adc0_data_fifo_full;
wire adc0_data_fifo_empty;
wire [63:0] adc0_fifo_din;
wire [63:0] adc0_fifo_dout;
wire adc1_clk_buf;
wire adc1_clk; 
wire adc1_clk90;
wire adc1_clk180; 
wire adc1_clk270;
wire adc1_clk_dcm;
wire adc1_clk90_dcm;
wire adc1_clk180_dcm;
wire adc1_clk270_dcm;
wire [7:0] adc1_data_eveni;
wire [7:0] adc1_data_oddi;
wire [7:0] adc1_data_evenq;
wire [7:0] adc1_data_oddq;
wire [7:0] adc1_user_datai0_asynch;
wire [7:0] adc1_user_datai1_asynch;
wire [7:0] adc1_user_datai2_asynch;
wire [7:0] adc1_user_datai3_asynch;
wire [7:0] adc1_user_dataq0_asynch;
wire [7:0] adc1_user_dataq1_asynch;
wire [7:0] adc1_user_dataq2_asynch;
wire [7:0] adc1_user_dataq3_asynch;
wire adc1_data_fifo_full;
wire adc1_data_fifo_empty;
wire [63:0] adc1_fifo_din;
wire [63:0] adc1_fifo_dout;
wire adc0_dcm_locked;
wire adc1_dcm_locked;
wire adc1_dcm_psdone;
reg adc0_dcm_psen;
wire [7:0] shift_count;
wire [7:0] dcm0_status;
wire [7:0] dcm1_status;
wire adc0_outofrange_fall;
wire adc0_outofrange_rise;
wire adc1_outofrange_fall;
wire adc1_outofrange_rise;

// Sync and OR wires
wire adc0_sync0;
wire adc0_sync1;
wire adc0_sync2;
wire adc0_sync3;
wire adc1_sync0;
wire adc1_sync1;
wire adc1_sync2;
wire adc1_sync3;
wire adc0_outofrange0;
wire adc0_outofrange1;
wire adc0_outofrange2;
wire adc0_outofrange3;
wire adc1_outofrange0;
wire adc1_outofrange1;
wire adc1_outofrange2;
wire adc1_outofrange3;

// Reset wires
reg adc0_reset;
reg adc0_fifo_rst;
reg adc0_dcm_reset;
wire adc1_reset;
reg adc1_fifo_rst;
reg adc1_dcm_reset;
reg delay_count_rst;
wire [1:0] reset_clock;

// Sampler wires
wire clk_sample0;
reg clk_sample_req0;
wire clk_sample_valid0;
wire clk_sample_error0;
wire clk_sample_idle0;
wire clk_sample90;
reg clk_sample_req90;
wire clk_sample_valid90;
wire clk_sample_error90;
wire clk_sample_idle90;
wire clk_sample180;
reg clk_sample_req180;
wire clk_sample_valid180;
wire clk_sample_error180;
wire clk_sample270;
reg clk_sample_req270;
wire clk_sample_valid270;
wire clk_sample_error270;

wire [31:0] reset_delay_count;
wire [7:0] sampler_data = {clk_sample_valid0, clk_sample_valid90, clk_sample_valid180, clk_sample_valid270, clk_sample0, clk_sample90, clk_sample180, clk_sample270};
reg [3:0] state, next_state;

wire end_reset, adc0_view_reset, adc1_reset_test;
reg sync_done;
wire [31:0] delay_count;
reg reset_start;
wire reset_start0, reset_start90, reset_start180, reset_start270;
wire adc1_reset0, adc1_reset90, adc1_reset180, adc1_reset270;
reg adc1_reset_block_rst;

// Module Declarations
//====================
clock_sample clock_sample0 (
	.clock(adc0_clk),
	.din(adc1_clk),
	.reset(ctrl_reset),
	.dout(clk_sample0),
	.sample_req(clk_sample_req0),
	.sample_valid(clk_sample_valid0),
	.sample_error(clk_sample_error0),
    .sample_idle(clk_sample_idle0)
);

clock_sample clock_sample90 (
	.clock(adc0_clk90),
	.din(adc1_clk),
	.reset(ctrl_reset),
	.dout(clk_sample90),
	.sample_req(clk_sample_req90),
	.sample_valid(clk_sample_valid90),
	.sample_error(clk_sample_error90),
    .sample_idle(clk_sample_idle90)
);

clock_sample clock_sample180 (
	.clock(adc0_clk180),
	.din(adc1_clk),
	.reset(ctrl_reset),
	.dout(clk_sample180),
	.sample_req(clk_sample_req180),
	.sample_valid(clk_sample_valid180),
	.sample_error(clk_sample_error180),
    .sample_idle(clk_sample_idle180)
);

clock_sample clock_sample270 (
	.clock(adc0_clk270),
	.din(adc1_clk),
	.reset(ctrl_reset),
	.dout(clk_sample270),
	.sample_req(clk_sample_req270),
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
  .reset_start(reset_start0)
  );

adc_reset adc1_reset_block90 (
  .base_clk(dcm_psclk),
  .reset_clk(adc0_clk90),
  .system_reset(ctrl_reset | adc1_reset_block_rst),
  .reset_output(adc1_reset90),
  .reset_start(reset_start90)
  );

adc_reset adc1_reset_block180 (
  .base_clk(dcm_psclk),
  .reset_clk(adc0_clk180),
  .system_reset(ctrl_reset | adc1_reset_block_rst),
  .reset_output(adc1_reset180),
  .reset_start(reset_start180)
);

adc_reset adc1_reset_block270 (
  .base_clk(dcm_psclk),
  .reset_clk(adc0_clk270),
  .system_reset(ctrl_reset | adc1_reset_block_rst),
  .reset_output(adc1_reset270),
  .reset_start(reset_start270)
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

// FSM to synchronize ADC demuxing
parameter state_init = 4'd0;
parameter state_reset_adc = 4'd1;
parameter state_wait_adc = 4'd2;
parameter state_wait_dcm = 4'd3;
parameter state_sample_clocks = 4'd4;
parameter state_decide = 4'd5;
parameter state_done = 4'd6; 
always @ (posedge dcm_psclk) begin
  if (ctrl_reset) begin
    state <= state_init;
  end else begin
    state <= next_state;
  end
end

always @ ( * ) begin
  adc1_reset_block_rst = 0;
  reset_start = 0;
  sync_done = 0;
  next_state = state;
  adc1_dcm_reset = 0;
  adc0_dcm_reset = 0;
//  adc1_reset = 0;
  adc0_reset = 0;
  delay_count_rst = 0;
  clk_sample_req0 = 0;
  clk_sample_req90 = 0;
  clk_sample_req180 = 0;
  clk_sample_req270 = 0;
  case (state)
    state_init: begin
      if (delay_count > 32'd125000000) begin
        next_state = state_reset_adc;
      end
    end

    state_reset_adc: begin
      delay_count_rst = 1;
      reset_start = 1;
      //adc1_reset = 1;
      //adc0_reset = 1;
      //adc1_dcm_reset = 1;
      //adc0_dcm_reset = 1;
      next_state = state_wait_adc;
    end

    state_wait_adc: begin
      if (delay_count > 2000) begin
        next_state = state_wait_dcm;
      end
    end

    state_wait_dcm: begin
      if (adc0_dcm_locked && adc1_dcm_locked) begin
        next_state = state_sample_clocks;
      end
    end

    state_sample_clocks: begin
      clk_sample_req0 = 1;
      clk_sample_req90 = 1;
      clk_sample_req180 = 1;
      clk_sample_req270 = 1;
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

assign adc0_user_datai0 = adc0_fifo_dout[63:56]; 
assign adc1_user_datai0 = adc1_fifo_dout[63:56]; 
assign adc0_user_dataq0 = adc0_fifo_dout[31:24];
assign adc1_user_dataq0 = adc1_fifo_dout[31:24];
assign adc1_user_datai1 = adc1_fifo_dout[55:48];
assign adc0_user_datai1 = adc0_fifo_dout[55:48];
assign adc0_user_dataq1 = adc0_fifo_dout[23:16];
assign adc1_user_dataq1 = adc1_fifo_dout[23:16];
assign adc1_user_datai2 = adc1_fifo_dout[47:40];
assign adc0_user_datai2 = adc0_fifo_dout[47:40];
assign adc0_user_dataq2 = adc0_fifo_dout[15:8];
assign adc1_user_dataq2 = adc1_fifo_dout[15:8];
assign adc0_user_datai3 = adc0_fifo_dout[39:32];
assign adc1_user_datai3 = adc1_fifo_dout[39:32];//{6'b0, edge_found, adc1_dcm_psdone};//
assign adc0_user_dataq3 = {1'b0, reset_start, adc1_reset, sync_done, state};//adc0_fifo_dout[7:0];//{1'b0, adc1_ps_overflow,SYNC_STATE, adc1_dcm_psen};//
assign adc1_user_dataq3 = sampler_data[7:0];//adc1_fifo_dout[7:0];//ps_shift_count[7:0];//{1'b0, calibration_state, interleaved_sampler_done,valid_interleave};//


// Counter to keep track of the number of phase shifts
// Digitize LVDS pairs
// -------------------
// ADC0
diff_in adc0_DI_dataeveni 	(.DP(adc0_dataeveni_p), .DN(adc0_dataeveni_n), .D(adc0_data_eveni));
diff_in adc0_DI_dataoddi 	(.DP(adc0_dataoddi_p), .DN(adc0_dataoddi_n), .D(adc0_data_oddi));
diff_in adc0_DI_dataevenq 	(.DP(adc0_dataevenq_p), .DN(adc0_dataevenq_n), .D(adc0_data_evenq));
diff_in adc0_DI_dataoddq 	(.DP(adc0_dataoddq_p), .DN(adc0_dataoddq_n), .D(adc0_data_oddq));

// Capture/Recapture Logic
DDR_Reg adc0_DDRs04 (.clk(adc0_clk), .reset(1'b0), .din(adc0_data_eveni), .dout_rise(adc0_user_datai0_asynch), .dout_fall(adc0_user_datai2_asynch));
DDR_Reg adc0_DDRs15 (.clk(adc0_clk), .reset(1'b0), .din(adc0_data_oddi), .dout_rise(adc0_user_datai1_asynch), .dout_fall(adc0_user_datai3_asynch));
DDR_Reg adc0_DDRs26 (.clk(adc0_clk), .reset(1'b0), .din(adc0_data_evenq), .dout_rise(adc0_user_dataq0_asynch), .dout_fall(adc0_user_dataq2_asynch));
DDR_Reg adc0_DDRs37 (.clk(adc0_clk), .reset(1'b0), .din(adc0_data_oddq), .dout_rise(adc0_user_dataq1_asynch), .dout_fall(adc0_user_dataq3_asynch));

// ADC1
diff_in adc1_DI_dataeveni 	(.DP(adc1_dataeveni_p), .DN(adc1_dataeveni_n), .D(adc1_data_eveni));
diff_in adc1_DI_dataoddi 	(.DP(adc1_dataoddi_p), .DN(adc1_dataoddi_n), .D(adc1_data_oddi));
diff_in adc1_DI_dataevenq 	(.DP(adc1_dataevenq_p), .DN(adc1_dataevenq_n), .D(adc1_data_evenq));
diff_in adc1_DI_dataoddq 	(.DP(adc1_dataoddq_p), .DN(adc1_dataoddq_n), .D(adc1_data_oddq));

// Capture/Recapture Logic
DDR_Reg adc1_DDRs04 (.clk(adc1_clk), .reset(1'b0), .din(adc1_data_eveni), .dout_rise(adc1_user_datai0_asynch), .dout_fall(adc1_user_datai2_asynch));
DDR_Reg adc1_DDRs15 (.clk(adc1_clk), .reset(1'b0), .din(adc1_data_oddi), .dout_rise(adc1_user_datai1_asynch), .dout_fall(adc1_user_datai3_asynch));
DDR_Reg adc1_DDRs26 (.clk(adc1_clk), .reset(1'b0), .din(adc1_data_evenq), .dout_rise(adc1_user_dataq0_asynch), .dout_fall(adc1_user_dataq2_asynch));
DDR_Reg adc1_DDRs37 (.clk(adc1_clk), .reset(1'b0), .din(adc1_data_oddq), .dout_rise(adc1_user_dataq1_asynch), .dout_fall(adc1_user_dataq3_asynch));


// Module Declarations
//====================

ddr_capture adc0_sync_capture(
	.clk_0(adc0_clk),
	.clk_90(adc0_clk90),
	.reset(ctrl_reset),
	.data_p(adc0_sync_p),
	.data_n(adc0_sync_n),
	.data0(adc0_sync0),
	.data90(adc0_sync1),
	.data180(adc0_sync2),
	.data270(adc0_sync3)
);

ddr_capture adc1_sync_capture(
	.clk_0(adc1_clk),
	.clk_90(adc1_clk90),
	.reset(ctrl_reset),
	.data_p(adc1_sync_p),
	.data_n(adc1_sync_n),
	.data0(adc1_sync0),
	.data90(adc1_sync1),
	.data180(adc1_sync2),
	.data270(adc1_sync3)
);
assign adc0_user_sync = adc0_sync0 | adc0_sync1 | adc0_sync2 | adc0_sync3;
assign adc1_user_sync = adc1_sync0 | adc1_sync1 | adc1_sync3 | adc1_sync3;

ddr_capture adc0_outofrange(
	.clk_0(adc0_clk),
	.clk_90(adc0_clk90),
	.reset(ctrl_reset),
	.data_p(adc0_outofrange_p),
	.data_n(adc0_outofrange_n),
	.data0(adc0_outofrange0),
	.data90(adc0_outofrange1),
	.data180(adc0_outofrange2),
	.data270(adc0_outofrange3)
);

ddr_capture adc1_outofrange(
	.clk_0(adc1_clk),
	.clk_90(adc1_clk90),
	.reset(ctrl_reset),
	.data_p(adc1_outofrange_p),
	.data_n(adc1_outofrange_n),
	.data0(adc1_outofrange0),
	.data90(adc1_outofrange1),
	.data180(adc1_outofrange2),
	.data270(adc1_outofrange3)
);
assign adc0_user_outofrange = adc0_outofrange0 | adc0_outofrange1 | adc0_outofrange2 | adc0_outofrange3;
assign adc1_user_outofrange = adc1_outofrange0 | adc1_outofrange1 | adc1_outofrange2 | adc1_outofrange3;

// Asynchronous FIFO to support multiple clocks
// --------------------------------------------
assign adc0_fifo_din = {
 	adc0_user_datai0_asynch,
	adc0_user_datai1_asynch,
	adc0_user_datai2_asynch,
	adc0_user_datai3_asynch,
	adc0_user_dataq0_asynch,
	adc0_user_dataq1_asynch,
	adc0_user_dataq2_asynch,
	adc0_user_dataq3_asynch
};
async_fifo_64by16 adc0_data_fifo (
	.din(adc0_fifo_din),
	.rd_clk(adc0_clk),
	.rd_en(~adc0_data_fifo_empty),
	.rst(adc0_fifo_rst | ctrl_reset),
	.wr_clk(adc0_clk),
	.wr_en(~adc0_data_fifo_full),
	.dout(adc0_fifo_dout),
	.empty(adc0_data_fifo_empty),
	.full(adc0_data_fifo_full),
	.valid(adc0_user_data_valid)
);

assign adc1_fifo_din = {
 	adc1_user_datai0_asynch,
	adc1_user_datai1_asynch,
	adc1_user_datai2_asynch,
	adc1_user_datai3_asynch,
	adc1_user_dataq0_asynch,
	adc1_user_dataq1_asynch,
	adc1_user_dataq2_asynch,
	adc1_user_dataq3_asynch
};
async_fifo_64by16 adc1_data_fifo (
	.din(adc1_fifo_din),
	.rd_clk(adc0_clk),
	.rd_en(~adc1_data_fifo_empty),
	.rst(adc1_fifo_rst | ctrl_reset),
	.wr_clk(adc1_clk),
	.wr_en(~adc1_data_fifo_full),
	.dout(adc1_fifo_dout),
	.empty(adc1_data_fifo_empty),
	.full(adc1_data_fifo_full),
	.valid(adc1_user_data_valid)
);
	
// DCM(s) and CLock Management 
// -----------------------------
// Clock from ZDOK0 	
 IBUFGDS #(// Buffer for input clk
	.DIFF_TERM("TRUE"),       	// Differential Termination (Virtex-4/5, Spartan-3E/3A)
	.IOSTANDARD("LVDS_25")    	// Specify the input I/O standard
) IBUFGDS_3 (
	.O(adc0_clk_buf),  						// Buffer output
	.I(adc0_clk_p),  						// Diff_p buffer input (connect directly to top-level port)
	.IB(adc0_clk_n) 						// Diff_n buffer input (connect directly to top-level port)
);

DCM #(
	.CLK_FEEDBACK("1X"), 									// Specify clock feedback of NONE, 1X or 2X
	.CLKDV_DIVIDE(2.0), 									// Divide by: 1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0,5.5,6.0,6.5 7.0,7.5,8.0,9.0,10.0,11.0,12.0,13.0,14.0,15.0 or 16.0
	.CLKFX_DIVIDE(1), 										// Can be any integer from 1 to 32
	.CLKFX_MULTIPLY(4), 									// Can be any integer from 2 to 32
	.CLKIN_DIVIDE_BY_2("FALSE"), 					// TRUE/FALSE to enable CLKIN divide by two feature
	.CLKIN_PERIOD(4.0000), 									// Specify period of input clock in ns from 1.25 to 1000.00
	.CLKOUT_PHASE_SHIFT("NONE"), 					// Specify phase shift mode of NONE or FIXED
	.DESKEW_ADJUST("SOURCE_SYNCHRONOUS"), // SOURCE_SYNCHRONOUS, SYSTEM_SYNCHRONOUS or an integer from 0 to 15
	.DFS_FREQUENCY_MODE("HIGH"), 					// LOW or HIGH frequency mode for frequency synthesis
	.DLL_FREQUENCY_MODE("HIGH"), 					// LOW, HIGH, or HIGH_SER frequency mode for DLL
	.DUTY_CYCLE_CORRECTION("TRUE"), 			// Duty cycle correction, TRUE or FALSE
	.FACTORY_JF(16'hf0f0), 								// FACTORY JF value suggested to be set to 16'hf0f0
	.PHASE_SHIFT(0), 											// Amount of fixed phase shift from -255 to 1023
	.STARTUP_WAIT("FALSE"), 								// Delay configuration DONE until DCM LOCK, TRUE/FALSE
	.DSS_MODE("NONE")
) DCM_ZDOK0 (
	.CLKFB(adc0_clk),       		// DCM clock feedback
	.CLKIN(adc0_clk_buf),      // Clock input (from IBUFG, BUFG or DCM)		 
	.DSSEN(0),
	.PSCLK(), // dcm_psclk
	.PSEN( 1'b0 ),
	.PSINCDEC( 1'b0 ),
	.RST( ctrl_reset | adc0_dcm_reset ),           // DCM asynchronous reset input
	.CLKDV( ),       						// Divided DCM CLK out (CLKDV_DIVIDE)
	.CLKFX( ),       						// DCM CLK synthesis out (M/D)
	.CLKFX180( ), 							// 180 degree CLK synthesis out			
	.CLK0( adc0_clk_dcm ),      	// 0 degree DCM CLK output
	.CLK2X( ),       						// 2X DCM CLK output
	.CLK2X180( ), 							// 2X, 180 degree DCM CLK out			
	.CLK90( adc0_clk90_dcm ),    // 90 degree DCM CLK output
	.CLK180( adc0_clk180_dcm ),	// 180 degree DCM CLK output
	.CLK270( adc0_clk270_dcm ),  // 270 degree DCM CLK output
	.LOCKED( adc0_dcm_locked ),  // DCM LOCK status output
	.PSDONE( dcm_psdone ),
	.STATUS( dcm0_status)
);

// Buffer outputs of DCM
BUFG adc0_clk0_bufg (.I( adc0_clk_dcm ), .O( adc0_clk ));
BUFG adc0_clk90_bufg (.I( adc0_clk90_dcm ), .O( adc0_clk90 ));
BUFG adc0_clk180_bufg (.I( adc0_clk180_dcm ), .O( adc0_clk180 ));
BUFG adc0_clk270_bufg (.I( adc0_clk270_dcm ), .O( adc0_clk270 ));

// Clock from ZDOK1
IBUFGDS #(// Buffer for input clk
	.DIFF_TERM("TRUE"),       	// Differential Termination (Virtex-4/5, Spartan-3E/3A)
	.IOSTANDARD("LVDS_25")    	// Specify the input I/O standard
) IBUFGDS_adc1_clk (
	.O(adc1_clk_buf),  						// Buffer output
	.I(adc1_clk_p),  						// Diff_p buffer input (connect directly to top-level port)
	.IB(adc1_clk_n) 						// Diff_n buffer input (connect directly to top-level port)
);

DCM #(
	.CLK_FEEDBACK("1X"), 									// Specify clock feedback of NONE, 1X or 2X
	.CLKDV_DIVIDE(2.0), 									// Divide by: 1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0,5.5,6.0,6.5 7.0,7.5,8.0,9.0,10.0,11.0,12.0,13.0,14.0,15.0 or 16.0
	.CLKFX_DIVIDE(1), 										// Can be any integer from 1 to 32
	.CLKFX_MULTIPLY(4), 									// Can be any integer from 2 to 32
	.CLKIN_DIVIDE_BY_2("FALSE"), 					// TRUE/FALSE to enable CLKIN divide by two feature
	.CLKIN_PERIOD(4.0000), 									// Specify period of input clock in ns from 1.25 to 1000.00
	.CLKOUT_PHASE_SHIFT("NONE"), 					// Specify phase shift mode of NONE or FIXED
	.DESKEW_ADJUST("SOURCE_SYNCHRONOUS"), // SOURCE_SYNCHRONOUS, SYSTEM_SYNCHRONOUS or an integer from 0 to 15
	.DFS_FREQUENCY_MODE("HIGH"), 					// LOW or HIGH frequency mode for frequency synthesis
	.DLL_FREQUENCY_MODE("HIGH"), 					// LOW, HIGH, or HIGH_SER frequency mode for DLL
	.DUTY_CYCLE_CORRECTION("TRUE"), 			// Duty cycle correction, TRUE or FALSE
	.FACTORY_JF(16'hf0f0), 								// FACTORY JF value suggested to be set to 16'hf0f0
	.PHASE_SHIFT(0), 											// Amount of fixed phase shift from -255 to 1023
	.STARTUP_WAIT("FALSE"), 								// Delay configuration DONE until DCM LOCK, TRUE/FALSE
	.DSS_MODE("NONE")
) DCM_ZDOK1 (
	.CLKFB( adc1_clk ),       		// DCM clock feedback
	.CLKIN( adc1_clk_buf ),      // Clock input (from IBUFG, BUFG or DCM)		 
	.DSSEN( 0 ),
	.PSCLK( dcm_psclk ),
	.PSEN( 1'b0 ),
	.PSINCDEC( 1'b0 ),
	.RST(ctrl_reset | adc1_dcm_reset ),           // DCM asynchronous reset input
	.CLKDV( ),       						// Divided DCM CLK out (CLKDV_DIVIDE)
	.CLKFX( ),       						// DCM CLK synthesis out (M/D)
	.CLKFX180( ), 							// 180 degree CLK synthesis out			
	.CLK0( adc1_clk_dcm ),      	// 0 degree DCM CLK output
	.CLK2X( ),       						// 2X DCM CLK output
	.CLK2X180( ), 							// 2X, 180 degree DCM CLK out			
	.CLK90( adc1_clk90_dcm ),    // 90 degree DCM CLK output
	.CLK180( adc1_clk180_dcm ),	// 180 degree DCM CLK output
	.CLK270( adc1_clk270_dcm ),  // 270 degree DCM CLK output
	.LOCKED( adc1_dcm_locked ),  // DCM LOCK status output
	.PSDONE( adc1_dcm_psdone ),
	.STATUS( dcm1_status)
);

// Buffer outputs of DCM
BUFG adc1_clk0_bufg (.I( adc1_clk_dcm ), .O( adc1_clk ));
BUFG adc1_clk90_bufg (.I( adc1_clk90_dcm ), .O( adc1_clk90 ));
BUFG adc1_clk180_bufg (.I( adc1_clk180_dcm ), .O( adc1_clk180 ));
BUFG adc1_clk270_bufg (.I( adc1_clk270_dcm ), .O( adc1_clk270 ));

assign ctrl_clk_out = adc0_clk;//dcm_psclk;//adc0_clk;
assign ctrl_clk90_out = adc0_clk90;
assign ctrl_clk180_out = adc0_clk180;
assign ctrl_clk270_out = adc0_clk270;
assign ctrl_dcm_locked = adc0_dcm_locked;



endmodule
