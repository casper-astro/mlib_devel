module adc083000_demux_interface(
	adc_clk_p,
	adc_clk_n,
	adc_sync_p,
	adc_sync_n,
	adc_outofrange_p,
	adc_outofrange_n,
	adc_dataeveni_p,
	adc_dataeveni_n,
	adc_dataoddi_p,
	adc_dataoddi_n,
	adc_dataevenq_p,
	adc_dataevenq_n,
	adc_dataoddq_p,
	adc_dataoddq_n,

	adc_clk,
	adc_clk90,
	adc_clk180,
	adc_clk270,
	adc_user_datai0,
	adc_user_datai1, 
	adc_user_datai2,
	adc_user_datai3,
	adc_user_datai4,
	adc_user_datai5, 
	adc_user_datai6,
	adc_user_datai7,
	adc_user_dataq0,
	adc_user_dataq1,
	adc_user_dataq2,
	adc_user_dataq3,
	adc_user_dataq4,
	adc_user_dataq5, 
	adc_user_dataq6,
	adc_user_dataq7,
	adc_user_sync0,
	adc_user_sync1,
	adc_user_sync2,
	adc_user_sync3,
	adc_user_sync4,
	adc_user_sync5,
	adc_user_sync6,
	adc_user_sync7,
	adc_user_outofrange0,
	adc_user_outofrange1,
	adc_user_outofrange2,
	adc_user_outofrange3,
	adc_user_outofrange4,
	adc_user_outofrange5,
	adc_user_outofrange6,
	adc_user_outofrange7,
	adc_user_data_valid0,
	adc_user_data_valid1,
	
	ctrl_reset,
	ctrl_clk_in,
	ctrl_clk_out,
	ctrl_clk90_out,
	ctrl_clk180_out,
	ctrl_clk270_out,
	adc_dcm_locked

);
// Inputs and Outputs
//===================
input adc_clk_p;
input adc_clk_n;
input adc_sync_p;
input adc_sync_n;
input adc_outofrange_p;
input adc_outofrange_n;
input [7:0] adc_dataeveni_p;
input [7:0] adc_dataeveni_n;
input [7:0] adc_dataoddi_p;
input [7:0] adc_dataoddi_n;
input [7:0] adc_dataevenq_p;
input [7:0] adc_dataevenq_n;
input [7:0] adc_dataoddq_p;
input [7:0] adc_dataoddq_n;

output adc_clk;
output adc_clk90;
output adc_clk180;
output adc_clk270;
output [7:0] adc_user_datai0;
output [7:0] adc_user_datai1;
output [7:0] adc_user_datai2;
output [7:0] adc_user_datai3;
output [7:0] adc_user_datai4;
output [7:0] adc_user_datai5;
output [7:0] adc_user_datai6;
output [7:0] adc_user_datai7;
output [7:0] adc_user_dataq0;
output [7:0] adc_user_dataq1;
output [7:0] adc_user_dataq2;
output [7:0] adc_user_dataq3;
output [7:0] adc_user_dataq4;
output [7:0] adc_user_dataq5;
output [7:0] adc_user_dataq6;
output [7:0] adc_user_dataq7;
output adc_user_sync0;
output adc_user_sync1;
output adc_user_sync2;
output adc_user_sync3;
output adc_user_sync4;
output adc_user_sync5;
output adc_user_sync6;
output adc_user_sync7;
output adc_user_outofrange0;
output adc_user_outofrange1;
output adc_user_outofrange2;
output adc_user_outofrange3;
output adc_user_outofrange4;
output adc_user_outofrange5;
output adc_user_outofrange6;
output adc_user_outofrange7;

// control lines
input ctrl_reset;
input ctrl_clk_in;
output adc_dcm_locked;
output ctrl_clk_out;
output ctrl_clk90_out;
output ctrl_clk180_out;
output ctrl_clk270_out;
output adc_user_data_valid0;
output adc_user_data_valid1;

// Wires and Regs
//===============
wire adc_clk_buf;
wire adc_clk_dv;
wire adc_clk_dcm;
wire adc_clk90_dcm;
wire adc_clk180_dcm;
wire adc_clk270_dcm;
wire [7:0] adc_datai0_asynch;
wire [7:0] adc_datai1_asynch;
wire [7:0] adc_datai2_asynch;
wire [7:0] adc_datai3_asynch;
wire [7:0] adc_dataq0_asynch;
wire [7:0] adc_dataq1_asynch;
wire [7:0] adc_dataq2_asynch;
wire [7:0] adc_dataq3_asynch;
wire [7:0] adc_datai0_recapture;
wire [7:0] adc_datai1_recapture;
wire [7:0] adc_datai2_recapture;
wire [7:0] adc_datai3_recapture;
wire [7:0] adc_dataq0_recapture;
wire [7:0] adc_dataq1_recapture;
wire [7:0] adc_dataq2_recapture;
wire [7:0] adc_dataq3_recapture;
wire adc_sync; // ddr
wire adc_data_fifo0_full;
wire adc_data_fifo0_empty;
wire adc_data_fifo1_full;
wire adc_data_fifo1_empty;
wire [63:0] adc_fifo_din;
wire [63:0] adc_fifo0_dout;
wire [63:0] adc_fifo1_dout;
wire adc_dcm_locked;
wire [7:0] dcm0_status;
wire data_buf_clk;
wire adc_data_fifo0_we;
wire adc_data_fifo1_we;
wire fifo_we_count;


// Digitize LVDS pairs
// -------------------
diff_ddr_reg adc_eveni( 
	.clk(adc_clk), 
	.reset(1'b0), 
	.input_p(adc_dataeveni_p), 
	.input_n(adc_dataeveni_n), 
	.output_rise(adc_datai0_asynch), 
	.output_fall(adc_datai2_asynch));

diff_ddr_reg adc_oddi(
	.clk(adc_clk),
	.reset(1'b0),
	.input_p(adc_dataoddi_p),
	.input_n(adc_dataoddi_n),
	.output_rise(adc_datai1_asynch),
	.output_fall(adc_datai3_asynch));

diff_ddr_reg adc_evenq( 
	.clk(adc_clk), 
	.reset(1'b0), 
	.input_p(adc_dataevenq_p), 
	.input_n(adc_dataevenq_n), 
	.output_rise(adc_dataq0_asynch), 
	.output_fall(adc_dataq2_asynch));

diff_ddr_reg adc_oddq(
	.clk(adc_clk),
	.reset(1'b0),
	.input_p(adc_dataoddq_p),
	.input_n(adc_dataoddq_n),
	.output_rise(adc_dataq1_asynch),
	.output_fall(adc_dataq3_asynch));

qdr_capture adc_sync_capture(
	.clk_0(adc_clk),
	.clk_90(adc_clk90),
	.reset(ctrl_reset),
	.data_p(adc_sync_p),
	.data_n(adc_sync_n),
	.data0(adc_sync0),
	.data90(adc_sync1),
	.data180(adc_sync2),
	.data270(adc_sync3)
);
defparam adc_sync_capture.width = 1;


qdr_capture adc_outofrange(
	.clk_0(adc_clk),
	.clk_90(adc_clk90),
	.reset(ctrl_reset),
	.data_p(adc_outofrange_p),
	.data_n(adc_outofrange_n),
	.data0(adc_outofrange0),
	.data90(adc_outofrange1),
	.data180(adc_outofrange2),
	.data270(adc_outofrange3)
);
defparam adc_outofrange.width = 1;

// Recapture Datapath
recapture adc_datai0_recap( 
	.clk(adc_clk), 
	.reset(ctrl_reset), 
	.din(adc_datai0_asynch), 
	.dout(adc_datai0_recapture));

recapture adc_datai1_recap( 
	.clk(adc_clk), 
	.reset(ctrl_reset), 
	.din(adc_datai1_asynch), 
	.dout(adc_datai1_recapture));

recapture adc_datai2_recap( 
	.clk(adc_clk), 
	.reset(ctrl_reset), 
	.din(adc_datai2_asynch), 
	.dout(adc_datai2_recapture));

recapture adc_datai3_recap( 
	.clk(adc_clk), 
	.reset(ctrl_reset), 
	.din(adc_datai3_asynch), 
	.dout(adc_datai3_recapture));

recapture adc_dataq0_recap( 
	.clk(adc_clk), 
	.reset(ctrl_reset), 
	.din(adc_dataq0_asynch), 
	.dout(adc_dataq0_recapture));

recapture adc_dataq1_recap( 
	.clk(adc_clk), 
	.reset(ctrl_reset), 
	.din(adc_dataq1_asynch), 
	.dout(adc_dataq1_recapture));

recapture adc_dataq2_recap( 
	.clk(adc_clk), 
	.reset(ctrl_reset), 
	.din(adc_dataq2_asynch), 
	.dout(adc_dataq2_recapture));

recapture adc_dataq3_recap( 
	.clk(adc_clk), 
	.reset(ctrl_reset), 
	.din(adc_dataq3_asynch), 
	.dout(adc_dataq3_recapture));


// Async Data FIFO
assign adc_fifo_din = {
 	adc_datai0_recapture,
	adc_datai1_recapture,
	adc_datai2_recapture,
	adc_datai3_recapture,
	adc_dataq0_recapture,
	adc_dataq1_recapture,
	adc_dataq2_recapture,
	adc_dataq3_recapture
};


// Asynch data buffers
async_fifo_64by16 adc_data_fifo0 (
	.din(adc_fifo_din),
	.rd_clk(ctrl_clk_out),
	.rd_en(~adc_data_fifo0_empty),
	.rst(ctrl_reset),
	.wr_clk(adc_clk),
	.wr_en(adc_data_fifo0_we),
	.dout(adc_fifo0_dout),
	.empty(adc_data_fifo0_empty),
	.full(adc_data_fifo0_full),
	.valid(adc_user_data_valid0)
);

async_fifo_64by16 adc_data_fifo1 (
	.din(adc_fifo_din),
	.rd_clk(ctrl_clk_out),
	.rd_en(~adc_data_fifo1_empty),
	.rst(ctrl_reset),
	.wr_clk(adc_clk),
	.wr_en(adc_data_fifo1_we),
	.dout(adc_fifo1_dout),
	.empty(adc_data_fifo1_empty),
	.full(adc_data_fifo1_full),
	.valid(adc_user_data_valid1)
);

Counter fifo_we_counter ( .Clock(adc_clk),.Reset(ctrl_reset), .Enable(1'b1), .Count(fifo_we_count));
defparam fifo_we_counter.width = 1;

// write signals
assign adc_data_fifo0_we = ~fifo_we_count & ~adc_data_fifo0_full;
assign adc_data_fifo1_we = fifo_we_count & ~adc_data_fifo1_full;


// DCM(s) and CLock Management 
// -----------------------------
// Clock from ZDOK0 	
 IBUFGDS #(// Buffer for input clk
	.DIFF_TERM("TRUE"),       	// Differential Termination (Virtex-4/5, Spartan-3E/3A)
	.IOSTANDARD("LVDS_25")    	// Specify the input I/O standard
) IBUFGDS_3 (
	.O(adc_clk_buf),  						// Buffer output
	.I(adc_clk_p),  						// Diff_p buffer input (connect directly to top-level port)
	.IB(adc_clk_n) 						// Diff_n buffer input (connect directly to top-level port)
);

DCM #(
	.CLK_FEEDBACK("1X"), 									// Specify clock feedback of NONE, 1X or 2X
	.CLKDV_DIVIDE(2.0), 									// Divide by: 1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0,5.5,6.0,6.5 7.0,7.5,8.0,9.0,10.0,11.0,12.0,13.0,14.0,15.0 or 16.0
	.CLKFX_DIVIDE(4), 										// Can be any integer from 1 to 32
	.CLKFX_MULTIPLY(2), 									// Can be any integer from 2 to 32
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
	.CLKFB(adc_clk),       		// DCM clock feedback
	.CLKIN(adc_clk_buf),      // Clock input (from IBUFG, BUFG or DCM)		 
	.DSSEN(0),
	.PSCLK(), // dcm_psclk
	.PSEN( 1'b0 ),
	.PSINCDEC( 1'b0 ),
	.RST( ctrl_reset ),           // DCM asynchronous reset input
	.CLKDV( ),       						// Divided DCM CLK out (CLKDV_DIVIDE)
	.CLKFX(adc_clk_dv  ),       						// DCM CLK synthesis out (M/D)
	.CLKFX180( ), 							// 180 degree CLK synthesis out			
	.CLK0( adc_clk_dcm ),      	// 0 degree DCM CLK output
	.CLK2X( ),       						// 2X DCM CLK output
	.CLK2X180( ), 							// 2X, 180 degree DCM CLK out			
	.CLK90( adc_clk90_dcm ),    // 90 degree DCM CLK output
	.CLK180( adc_clk180_dcm ),	// 180 degree DCM CLK output
	.CLK270( adc_clk270_dcm ),  // 270 degree DCM CLK output
	.LOCKED( adc_dcm_locked ),  // DCM LOCK status output
	.PSDONE( dcm_psdone ),
	.STATUS( dcm0_status)
);

// Buffer outputs of DCM
BUFG adc_clk0_bufg (.I( adc_clk_dcm ), .O( adc_clk ));
BUFG adc_clk_dv_bufg (.I( adc_clk_dv ), .O( ctrl_clk_out ));
BUFG data_buf_clk_bufg (.I( adc_clk_dcm ), .O( data_buf_clk ));
BUFG adc_clk90_bufg (.I( adc_clk90_dcm ), .O( adc_clk90 ));
BUFG adc_clk180_bufg (.I( adc_clk180_dcm ), .O( adc_clk180 ));
BUFG adc_clk270_bufg (.I( adc_clk270_dcm ), .O( adc_clk270 ));


assign adc_user_datai0 = adc_fifo0_dout[63:56];
assign adc_user_datai1 = adc_fifo0_dout[55:48];
assign adc_user_datai2 = adc_fifo0_dout[47:40];
assign adc_user_datai3 = adc_fifo0_dout[39:32];
assign adc_user_dataq0 = adc_fifo0_dout[31:24];
assign adc_user_dataq1 = adc_fifo0_dout[23:16];
assign adc_user_dataq2 = adc_fifo0_dout[15:8];
assign adc_user_dataq3 = adc_fifo0_dout[7:0];

assign adc_user_datai4 = adc_fifo1_dout[63:56]; 
assign adc_user_datai5 = adc_fifo1_dout[55:48];
assign adc_user_datai6 = adc_fifo1_dout[47:40];
assign adc_user_datai7 = adc_fifo1_dout[39:32];
assign adc_user_dataq4 = adc_fifo1_dout[31:24];
assign adc_user_dataq5 = adc_fifo1_dout[23:16];
assign adc_user_dataq6 = adc_fifo1_dout[15:8];
assign adc_user_dataq7 = adc_fifo1_dout[7:0];
endmodule
