`timescale 1ns / 1ps
module adc083000x2_interface #(
	// System Parameters
	//==================
	parameter 		USE_ADC0 = 1,
	parameter			USE_ADC1 = 0,
	parameter			INTERLEAVE_BOARDS = 0,
	parameter			DEMUX_DATA_OUT = 0
) (
	// IO Ports
	//=========
	input					adc0_clk_p,
	input					adc0_clk_n,
	input					adc0_sync_p,
	input					adc0_sync_n,
	input [7:0]		adc0_outofrange_p,
	input [7:0]		adc0_outofrange_n,
	input [7:0]		adc0_dataeveni_p,
	input [7:0]		adc0_dataeveni_n,
	input [7:0]		adc0_dataoddi_p,
	input [7:0]		adc0_dataoddi_n,
	input [7:0]		adc0_dataevenq_p,
	input [7:0]		adc0_dataevenq_n,
	input [7:0]		adc0_dataoddq_p,
	input [7:0]		adc0_dataoddq_n,
	output		  	adc0_reset,
	output [7:0] 	adc0_user_s0,
	output [7:0] 	adc0_user_s2,
	output [7:0] 	adc0_user_s4,
	output [7:0] 	adc0_user_s6,
	output [7:0] 	adc0_user_s8,
	output [7:0] 	adc0_user_s10,
	output [7:0] 	adc0_user_s12,
	output [7:0] 	adc0_user_s14,
	output [7:0] 	adc0_user_s1,
	output [7:0] 	adc0_user_s3,
	output [7:0] 	adc0_user_s5,
	output [7:0] 	adc0_user_s7,
	output [7:0] 	adc0_user_s9,
	output [7:0] 	adc0_user_s11,
	output [7:0] 	adc0_user_s13,
	output [7:0] 	adc0_user_s15,
	output [3:0] 	adc0_user_outofrange,
	output [3:0] 	adc0_user_sync,
	output [0:0] 	adc0_user_data_valid,

	input					adc1_clk_p,
	input					adc1_clk_n,
	input					adc1_sync_p,
	input					adc1_sync_n,
	input [7:0]		adc1_outofrange_p,
	input [7:0]		adc1_outofrange_n,
	input [7:0]		adc1_dataeveni_p,
	input [7:0]		adc1_dataeveni_n,
	input [7:0]		adc1_dataoddi_p,
	input [7:0]		adc1_dataoddi_n,
	input [7:0]		adc1_dataevenq_p,
	input [7:0]		adc1_dataevenq_n,
	input [7:0]		adc1_dataoddq_p,
	input [7:0]		adc1_dataoddq_n,
	output		  	adc1_reset,
	output [7:0] 	adc1_user_s0,
	output [7:0] 	adc1_user_s2,
	output [7:0] 	adc1_user_s4,
	output [7:0] 	adc1_user_s6,
	output [7:0] 	adc1_user_s8,
	output [7:0] 	adc1_user_s10,
	output [7:0] 	adc1_user_s12,
	output [7:0] 	adc1_user_s14,
	output [7:0] 	adc1_user_s1,
	output [7:0] 	adc1_user_s3,
	output [7:0] 	adc1_user_s5,
	output [7:0] 	adc1_user_s7,
	output [7:0] 	adc1_user_s9,
	output [7:0] 	adc1_user_s11,
	output [7:0] 	adc1_user_s13,
	output [7:0] 	adc1_user_s15,
	output [3:0] 	adc1_user_outofrange,
	output [3:0] 	adc1_user_sync,
	output [0:0] 	adc1_user_data_valid,

	// 3-wire serial interface ports
	//output		adc0_notSCS,
	//output		adc0_sclk,
	//output 		adc0_sdata,
	//output		adc1_notSCS,
	//output		adc1_sclk,
	//output 		adc1_sdata,

	//input		adc_ctrl_clk,
	//input		adc_ctrl_sdata,
	//input		adc_ctrl_notSCS,


	// dcm/ctrl signals
	input					ctrl_clk_in,
	output				ctrl_clk_out,
	output				ctrl_clk90_out,
	output				ctrl_clk180_out,
	output				ctrl_clk270_out,
	output				ctrl_dcm_locked,
	input					sys_clk
);

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
generate if (INTERLEAVE_BOARDS) begin
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
end
endgenerate

// ADC0 Instantiation
//===================
generate if (USE_ADC0 && ~DEMUX_DATA_OUT) begin
	adc083000_board_phy ADC0 (
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
		.adc_user_datai0(adc0_user_s0),
		.adc_user_datai1(adc0_user_s2),
		.adc_user_datai2(adc0_user_s4),
		.adc_user_datai3(adc0_user_s6),
		.adc_user_dataq0(adc0_user_s1),
		.adc_user_dataq1(adc0_user_s3),
		.adc_user_dataq2(adc0_user_s5),
		.adc_user_dataq3(adc0_user_s7),
		.adc_sync0(adc0_user_sync[0]),
		.adc_sync1(adc0_user_sync[1]),
		.adc_sync2(adc0_user_sync[2]),
		.adc_sync3(adc0_user_sync[3]),
		.adc_outofrange0(adc0_user_outofrange[0]),
		.adc_outofrange1(adc0_user_outofrange[1]),
		.adc_outofrange2(adc0_user_outofrange[2]),
		.adc_outofrange3(adc0_user_outofrange[3]),
		.ctrl_reset(ctrl_reset),
		.adc_dcm_locked(adc0_dcm_locked),
		.ctrl_clk_out(ctrl_clk_out)
	);
end else if (USE_ADC0 && DEMUX_DATA_OUT) begin
	adc083000_board_phy_demux ADC0 (
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
		.adc_user_datai0(adc0_user_s0),
		.adc_user_datai1(adc0_user_s2),
		.adc_user_datai2(adc0_user_s4),
		.adc_user_datai3(adc0_user_s6),
		.adc_user_datai4(adc0_user_s8),
		.adc_user_datai5(adc0_user_s10),
		.adc_user_datai6(adc0_user_s12),
		.adc_user_datai7(adc0_user_s14),
		.adc_user_dataq0(adc0_user_s1),
		.adc_user_dataq1(adc0_user_s3),
		.adc_user_dataq2(adc0_user_s5),
		.adc_user_dataq3(adc0_user_s7),
		.adc_user_dataq4(adc0_user_s9),
		.adc_user_dataq5(adc0_user_s11),
		.adc_user_dataq6(adc0_user_s13),
		.adc_user_dataq7(adc0_user_s15),
		.adc_sync0(adc0_user_sync[0]),
		.adc_sync1(adc0_user_sync[1]),
		.adc_sync2(adc0_user_sync[2]),
		.adc_sync3(adc0_user_sync[3]),
		.adc_outofrange0(adc0_user_outofrange[0]),
		.adc_outofrange1(adc0_user_outofrange[1]),
		.adc_outofrange2(adc0_user_outofrange[2]),
		.adc_outofrange3(adc0_user_outofrange[3]),
		.ctrl_reset(ctrl_reset),
		.adc_dcm_locked(adc0_dcm_locked)
	);
end
endgenerate


generate if (USE_ADC1) begin
	// ADC1 Instantiation
	//===================
	adc083000_board_phy ADC1 (
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
		.adc_user_datai0(adc1_user_s0),
		.adc_user_datai1(adc1_user_s2),
		.adc_user_datai2(adc1_user_s4),
		.adc_user_datai3(adc1_user_s6),
		.adc_user_dataq0(adc1_user_s1),
		.adc_user_dataq1(adc1_user_s3),
		.adc_user_dataq2(adc1_user_s5),
		.adc_user_dataq3(adc1_user_s7),
		.adc_sync0(adc1_user_sync[0]),
		.adc_sync1(adc1_user_sync[1]),
		.adc_sync2(adc1_user_sync[2]),
		.adc_sync3(adc1_user_sync[3]),
		.adc_outofrange0(adc1_user_outofrange[0]),
		.adc_outofrange1(adc1_user_outofrange[1]),
		.adc_outofrange2(adc1_user_outofrange[2]),
		.adc_outofrange3(adc1_user_outofrange[3]),
		.ctrl_reset(ctrl_reset),
		.adc_dcm_locked(adc1_dcm_locked),
		.ctrl_clk_out(ctrl_clk_out)
	);
end else if (USE_ADC1 && DEMUX_DATA_OUT) begin
	adc083000_board_phy_demux ADC1 (
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
		.adc_user_datai0(adc1_user_s0),
		.adc_user_datai1(adc1_user_s2),
		.adc_user_datai2(adc1_user_s4),
		.adc_user_datai3(adc1_user_s6),
		.adc_user_datai4(adc1_user_s8),
		.adc_user_datai5(adc1_user_s10),
		.adc_user_datai6(adc1_user_s12),
		.adc_user_datai7(adc1_user_s14),
		.adc_user_dataq0(adc1_user_s1),
		.adc_user_dataq1(adc1_user_s3),
		.adc_user_dataq2(adc1_user_s5),
		.adc_user_dataq3(adc1_user_s7),
		.adc_user_dataq4(adc1_user_s9),
		.adc_user_dataq5(adc1_user_s11),
		.adc_user_dataq6(adc1_user_s13),
		.adc_user_dataq7(adc1_user_s15),
		.adc_sync0(adc1_user_sync[0]),
		.adc_sync1(adc1_user_sync[1]),
		.adc_sync2(adc1_user_sync[2]),
		.adc_sync3(adc1_user_sync[3]),
		.adc_outofrange0(adc1_user_outofrange[0]),
		.adc_outofrange1(adc1_user_outofrange[1]),
		.adc_outofrange2(adc1_user_outofrange[2]),
		.adc_outofrange3(adc1_user_outofrange[3]),
		.ctrl_reset(ctrl_reset),
		.adc_dcm_locked(adc1_dcm_locked)
	);
end
endgenerate


// Serial interface
//assign adc0_notSCS = adc_ctrl_notSCS;
//assign adc0_sclk = adc_ctrl_clk;
//assign adc0_sdata = adc_ctrl_sdata;
//assign adc1_notSCS = adc_ctrl_notSCS;
//assign adc1_sclk = adc_ctrl_clk;
//assign adc1_sdata = adc_ctrl_sdata;


// Clock signal assignment
generate if (USE_ADC0) begin
	assign ctrl_clk_out 		= adc0_clk;
	assign ctrl_clk90_out 	= adc0_clk90;
	assign ctrl_clk180_out 	= adc0_clk180;
	assign ctrl_clk270_out 	= adc0_clk270;
	assign ctrl_dcm_locked 	= adc0_dcm_locked;
end else begin 
	assign ctrl_clk_out 		= adc1_clk;
	assign ctrl_clk90_out 	= adc1_clk90;
	assign ctrl_clk180_out 	= adc1_clk180;
	assign ctrl_clk270_out 	= adc1_clk270;
	assign ctrl_dcm_locked 	= adc1_dcm_locked;
end
endgenerate 
endmodule
