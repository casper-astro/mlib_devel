`timescale 1ns / 1ps
module adc083000x2_interface(
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
				sys_clk,
				dcm_psincdec,
				dcm_psen,
				dcm_psdone,

				adc0_user_sync0,
				adc0_user_sync1,
				adc0_user_sync2,
				adc0_user_sync3,
				adc1_user_sync0,
				adc1_user_sync1,
				adc1_user_sync2,
				adc1_user_sync3,
				adc0_user_outofrange0,
				adc0_user_outofrange1,
				adc0_user_outofrange2,
				adc0_user_outofrange3,
				adc1_user_outofrange0,
				adc1_user_outofrange1,
				adc1_user_outofrange2,
				adc1_user_outofrange3
);

// System Parameters
//==================

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
input					sys_clk;
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

output adc0_user_sync0;
output adc0_user_sync1;
output adc0_user_sync2;
output adc0_user_sync3;
output adc1_user_sync0;
output adc1_user_sync1;
output adc1_user_sync2;
output adc1_user_sync3;
output adc0_user_outofrange0;
output adc0_user_outofrange1;
output adc0_user_outofrange2;
output adc0_user_outofrange3;
output adc1_user_outofrange0;
output adc1_user_outofrange1;
output adc1_user_outofrange2;
output adc1_user_outofrange3;

// Wires and Regs
//===============
wire dcm_psclk = sys_clk;
wire adc0_clk;
wire adc0_clk90;
wire adc0_clk180;
wire adc0_clk270;
wire adc0_dcm_locked;

wire adc1_clk; 
wire adc1_clk90;
wire adc1_clk180; 
wire adc1_clk270;
wire adc1_dcm_locked;

wire sync_done;

// Module Declarations
//====================
clock_sync_fsm clock_sync_fsm(
	.adc0_clk(adc0_clk),
	.adc0_clk90(adc0_clk90),
	.adc0_clk180(adc0_clk180),
	.adc0_clk270(adc0_clk270),
	.adc1_clk(adc1_clk),
	.ctrl_reset(ctrl_reset),
	.dcm_psclk(dcm_psclk),
	.adc0_dcm_locked(adc0_dcm_locked),
	.adc1_dcm_locked(adc1_dcm_locked),
	.adc1_reset(adc1_reset),
	.sync_done(sync_done)	
);

assign ctrl_clk_out = adc0_clk;//dcm_psclk;//adc0_clk;
assign ctrl_clk90_out = adc0_clk90;
assign ctrl_clk180_out = adc0_clk180;
assign ctrl_clk270_out = adc0_clk270;
assign ctrl_dcm_locked = adc0_dcm_locked;


// ADC0 Instantiation
//===================
adc083000_interface ADC0 (
	.adc_clk_p(adc0_clk_p),
	.adc_clk_n(adc0_clk_n),
	.adc_sync_p(adc0_sync_p),
	.adc_sync_n(adc0_sync_n),
	.adc_outofrange_p(adc0_outofrange_p),
	.adc_outofrange_n(adc0_outofrange_n),
	.adc_dataeveni_p(adc0_dataeveni_p),
	.adc_dataeveni_n(adc0_dataeveni_n),
	.adc_dataoddi_p(adc0_dataoddi_p),
	.adc_dataoddi_n(adc0_dataoddi_n),
	.adc_dataevenq_p(adc0_dataevenq_p),
	.adc_dataevenq_n(adc0_dataevenq_n),
	.adc_dataoddq_p(adc0_dataoddq_p),
	.adc_dataoddq_n(adc0_dataoddq_n),
	.adc_clk(adc0_clk),
	.adc_clk90(adc0_clk90),
	.adc_clk180(adc0_clk180),
	.adc_clk270(adc0_clk270),
	.adc_user_datai0(adc0_user_datai0),
	.adc_user_datai1(adc0_user_datai1),
	.adc_user_datai2(adc0_user_datai2),
	.adc_user_datai3(adc0_user_datai3),
	.adc_user_dataq0(adc0_user_dataq0),
	.adc_user_dataq1(adc0_user_dataq1),
	.adc_user_dataq2(adc0_user_dataq2),
	.adc_user_dataq3(adc0_user_dataq3),
	.adc_sync0(adc0_user_sync0),
	.adc_sync1(adc0_user_sync1),
	.adc_sync2(adc0_user_sync2),
	.adc_sync3(adc0_user_sync3),
	.adc_outofrange0(adc0_user_outofrange0),
	.adc_outofrange1(adc0_user_outofrange1),
	.adc_outofrange2(adc0_user_outofrange2),
	.adc_outofrange3(adc0_user_outofrange3),
	.ctrl_reset(ctrl_reset),
	.adc_dcm_locked(adc0_dcm_locked)
);

// ADC1 Instantiation
//===================
adc083000_interface ADC1 (
	.adc_clk_p(adc1_clk_p),
	.adc_clk_n(adc1_clk_n),
	.adc_sync_p(adc1_sync_p),
	.adc_sync_n(adc1_sync_n),
	.adc_outofrange_p(adc1_outofrange_p),
	.adc_outofrange_n(adc1_outofrange_n),
	.adc_dataeveni_p(adc1_dataeveni_p),
	.adc_dataeveni_n(adc1_dataeveni_n),
	.adc_dataoddi_p(adc1_dataoddi_p),
	.adc_dataoddi_n(adc1_dataoddi_n),
	.adc_dataevenq_p(adc1_dataevenq_p),
	.adc_dataevenq_n(adc1_dataevenq_n),
	.adc_dataoddq_p(adc1_dataoddq_p),
	.adc_dataoddq_n(adc1_dataoddq_n),
	.adc_clk(adc1_clk),
	.adc_clk90(adc1_clk90),
	.adc_clk180(adc1_clk180),
	.adc_clk270(adc1_clk270),
	.adc_user_datai0(adc1_user_datai0),
	.adc_user_datai1(adc1_user_datai1),
	.adc_user_datai2(adc1_user_datai2),
	.adc_user_datai3(adc1_user_datai3),
	.adc_user_dataq0(adc1_user_dataq0),
	.adc_user_dataq1(adc1_user_dataq1),
	.adc_user_dataq2(adc1_user_dataq2),
	.adc_user_dataq3(adc1_user_dataq3),
	.adc_sync0(adc1_user_sync0),
	.adc_sync1(adc1_user_sync1),
	.adc_sync2(adc1_user_sync2),
	.adc_sync3(adc1_user_sync3),
	.adc_outofrange0(adc1_user_outofrange0),
	.adc_outofrange1(adc1_user_outofrange1),
	.adc_outofrange2(adc1_user_outofrange2),
	.adc_outofrange3(adc1_user_outofrange3),
	.ctrl_reset(ctrl_reset),
	.adc_dcm_locked(adc1_dcm_locked)
);


// Hacks
//assign adc0_user_sync = adc0_sync0 | adc0_sync1 | adc0_sync2 | adc0_sync3;
//assign adc0_user_outofrange = adc0_outofrange0 | adc0_outofrange1 | adc0_outofrange2 | adc0_outofrange3;
//assign adc1_user_sync = adc1_sync0 | adc1_sync1 | adc1_sync2 | adc1_sync3;
//assign adc1_user_outofrange = adc1_outofrange0 | adc1_outofrange1 | adc1_outofrange2 | adc1_outofrange3;
endmodule
