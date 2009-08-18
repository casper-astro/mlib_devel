`timescale 1ns / 1ps
module national_adc_interface(
				adc_clk_p,
				adc_clk_n,
				
				adc_sync_p,
				adc_sync_n,
				user_outofrange,
				user_sync,
				user_data_valid,

				adc_outofrange_p,
				adc_outofrange_n,

				// input LVDS pairs for signal
				adc_dataeveni_p,
				adc_dataeveni_n,
				adc_dataoddi_p,
				adc_dataoddi_n,
				adc_dataevenq_p,
				adc_dataevenq_n,
				adc_dataoddq_p,
				adc_dataoddq_n,

				adc_ddrb_p,
				adc_ddrb_n,

				user_datai0,
				user_datai1,
				user_datai2,
				user_datai3,
				user_dataq0,
				user_dataq1,
				user_dataq2,
				user_dataq3,

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

// Top-level I/O
input adc_clk_p, adc_clk_n;
input [7:0]		adc_dataeveni_p;
input [7:0]		adc_dataeveni_n;
input [7:0]		adc_dataoddi_p;
input [7:0]		adc_dataoddi_n;
input [7:0]		adc_dataevenq_p;
input [7:0]		adc_dataevenq_n;
input [7:0]		adc_dataoddq_p;
input [7:0]		adc_dataoddq_n;

output				adc_ddrb_p;
output				adc_ddrb_n;

output [7:0]	user_datai0;
output [7:0]	user_datai1;
output [7:0]	user_datai2;
output [7:0]	user_datai3;
output [7:0]	user_dataq0;
output [7:0]	user_dataq1;
output [7:0]	user_dataq2;
output [7:0]	user_dataq3;

input					dcm_reset;
input					ctrl_reset;
input					ctrl_clk_in;
output				ctrl_clk_out;
output				ctrl_clk90_out;
output				ctrl_clk180_out;
output				ctrl_clk270_out;
output				ctrl_dcm_locked;

input					dcm_psclk;
input					dcm_psen;
input					dcm_psincdec;
output				dcm_psdone;


input				adc_outofrange_p;
input				adc_outofrange_n;

input				adc_sync_p;
input				adc_sync_n;
output				user_outofrange;
output				user_sync;
output				user_data_valid;

// Wires and Regs
//===============
wire adc_clk_buf;
wire adc_clk, adc_clk90, adc_clk180, adc_clk270;
wire adc_clk_dcm, adc_clk90_dcm, adc_clk180_dcm, adc_clk270_dcm;
wire [7:0] adc_data_eveni;
wire [7:0] adc_data_oddi;
wire [7:0] adc_data_evenq;
wire [7:0] adc_data_oddq;
wire [7:0] user_datai0_asynch, user_datai1_asynch, user_datai2_asynch, user_datai3_asynch;
wire [7:0] user_dataq0_asynch, user_dataq1_asynch, user_dataq2_asynch, user_dataq3_asynch;
wire adc_sync; // ddr
wire adc_sync_rise, adc_sync_fall;
wire adc_data_fifo_full;
wire adc_data_fifo_empty;
wire [63:0] adc_data_capture = {
 	user_datai0_asynch,
	user_datai1_asynch,
	user_datai2_asynch,
	user_datai3_asynch,
	user_dataq0_asynch,
	user_dataq1_asynch,
	user_dataq2_asynch,
	user_dataq3_asynch};
wire [63:0] adc_fifo_dout;
wire [63:0] adc_data_recapture;




//OBUFDS instance_name (.O (user_O),
//                      .OB (user_OB),
//                      .I (user_I)); 

OBUFDS ADC_DDR_RST( .O(adc_ddrb_p), .OB(adc_ddrb_n), .I(ctrl_reset) );



// DCM
// -----------------------------

// Buffer for input clk
   IBUFGDS #(
      .DIFF_TERM("TRUE"),       	// Differential Termination (Virtex-4/5, Spartan-3E/3A)
      .IOSTANDARD("LVDS_25")    	// Specify the input I/O standard
   ) IBUFGDS_3 (
      .O(adc_clk_buf),  						// Buffer output
      .I(adc_clk_p),  						// Diff_p buffer input (connect directly to top-level port)
      .IB(adc_clk_n) 						// Diff_n buffer input (connect directly to top-level port)
   );

// DCM_BASE: Base Digital Clock Manager Circuit
//           Virtex-4/5
// Xilinx HDL Language Template, version 9.1.3i

   DCM #(
      .CLKDV_DIVIDE(2.0), 									// Divide by: 1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0,5.5,6.0,6.5 7.0,7.5,8.0,9.0,10.0,11.0,12.0,13.0,14.0,15.0 or 16.0
      .CLKFX_DIVIDE(1), 										// Can be any integer from 1 to 32
      .CLKFX_MULTIPLY(4), 									// Can be any integer from 2 to 32
      .CLKIN_DIVIDE_BY_2("FALSE"), 					// TRUE/FALSE to enable CLKIN divide by two feature
      .CLKIN_PERIOD(2.67), 									// Specify period of input clock in ns from 1.25 to 1000.00
      .CLKOUT_PHASE_SHIFT("NONE"), 					// Specify phase shift mode of NONE or FIXED
      .CLK_FEEDBACK("1X"), 									// Specify clock feedback of NONE, 1X or 2X
      //.DCM_PERFORMANCE_MODE("MAX_SPEED"), 	// Can be MAX_SPEED or MAX_RANGE
      .DESKEW_ADJUST("SOURCE_SYNCHRONOUS"), // SOURCE_SYNCHRONOUS, SYSTEM_SYNCHRONOUS or
                                            //   an integer from 0 to 15
      .DFS_FREQUENCY_MODE("HIGH"), 					// LOW or HIGH frequency mode for frequency synthesis
      .DLL_FREQUENCY_MODE("HIGH"), 					// LOW, HIGH, or HIGH_SER frequency mode for DLL
      .DUTY_CYCLE_CORRECTION("TRUE"), 			// Duty cycle correction, TRUE or FALSE
      .FACTORY_JF(16'hf0f0), 								// FACTORY JF value suggested to be set to 16'hf0f0
      .PHASE_SHIFT(0), 											// Amount of fixed phase shift from -255 to 1023
      .STARTUP_WAIT("FALSE") 								// Delay configuration DONE until DCM LOCK, TRUE/FALSE
   ) DCM_BASE_0 (
			.CLKFB( adc_clk ),       		// DCM clock feedback
	    .CLKIN( adc_clk_buf ),      // Clock input (from IBUFG, BUFG or DCM)		 
			.DSSEN( 0 ),
			.PSCLK( dcm_psclk ),
			.PSEN( dcm_psen ),
			.PSINCDEC( dcm_psincdec ),
	    .RST( dcm_reset ),           // DCM asynchronous reset input
      .CLKDV( ),       						// Divided DCM CLK out (CLKDV_DIVIDE)
      .CLKFX( ),       						// DCM CLK synthesis out (M/D)
      .CLKFX180( ), 							// 180 degree CLK synthesis out			
      .CLK0( adc_clk_dcm ),      	// 0 degree DCM CLK output
      .CLK2X( ),       						// 2X DCM CLK output
      .CLK2X180( ), 							// 2X, 180 degree DCM CLK out			
      .CLK90( adc_clk90_dcm ),    // 90 degree DCM CLK output
      .CLK180( adc_clk180_dcm ),	// 180 degree DCM CLK output
      .CLK270( adc_clk270_dcm ),  // 270 degree DCM CLK output
      .LOCKED( ctrl_dcm_locked ),  // DCM LOCK status output
			.PSDONE( dcm_psdone ),
			.STATUS( )
);

// End of DCM_BASE_inst instantiation
// 
// Buffer outputs of DCM
BUFG adc_clk0_bufg (.I( adc_clk_dcm ), .O( adc_clk ));
BUFG adc_clk90_bufg (.I( adc_clk90_dcm ), .O( adc_clk90 ));
BUFG adc_clk180_bufg (.I( adc_clk180_dcm ), .O( adc_clk180 ));
BUFG adc_clk270_bufg (.I( adc_clk270_dcm ), .O( adc_clk270 ));

assign ctrl_clk_out = adc_clk;
assign ctrl_clk90_out = adc_clk90;
assign ctrl_clk180_out = adc_clk180;
assign ctrl_clk270_out = adc_clk270;

// Digitize LVDS pairs
diff_in DI_dataeveni 	(.DP(adc_dataeveni_p), .DN(adc_dataeveni_n), .D(adc_data_eveni));
diff_in DI_dataoddi 	(.DP(adc_dataoddi_p), .DN(adc_dataoddi_n), .D(adc_data_oddi));

diff_in DI_dataevenq 	(.DP(adc_dataevenq_p), .DN(adc_dataevenq_n), .D(adc_data_evenq));
diff_in DI_dataoddq 	(.DP(adc_dataoddq_p), .DN(adc_dataoddq_n), .D(adc_data_oddq));


// Use DDR registers to parallelize samples at slower clockrate

DDR_Reg DDRs04 (.clk(adc_clk), .reset(1'b0), .din(adc_data_eveni), .dout_rise(user_datai0_asynch), .dout_fall(user_datai2_asynch));
DDR_Reg DDRs15 (.clk(adc_clk), .reset(1'b0), .din(adc_data_oddi), .dout_rise(user_datai1_asynch), .dout_fall(user_datai3_asynch));
DDR_Reg DDRs26 (.clk(adc_clk), .reset(1'b0), .din(adc_data_evenq), .dout_rise(user_dataq0_asynch), .dout_fall(user_dataq2_asynch));
DDR_Reg DDRs37 (.clk(adc_clk), .reset(1'b0), .din(adc_data_oddq), .dout_rise(user_dataq1_asynch), .dout_fall(user_dataq3_asynch));


// ADC sync output
   IBUFGDS #(
      .DIFF_TERM("TRUE"),       	// Differential Termination (Virtex-4/5, Spartan-3E/3A)
      .IOSTANDARD("LVDS_25")    	// Specify the input I/O standard
   ) IBUFGDS_sync (
      .O(adc_sync),  						// Buffer output
      .I(adc_sync_p),  						// Diff_p buffer input (connect directly to top-level port)
      .IB(adc_sync_n) 						// Diff_n buffer input (connect directly to top-level port)
   );
   
   IDDR #(
      .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"), // "OPPOSITE_EDGE", "SAME_EDGE" 
                                      //    or "SAME_EDGE_PIPELINED" 
      .INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
      .INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
      .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
   ) IDDR_0 (
      .Q1(adc_sync_rise), // 1-bit output for positive edge of clock 
      .Q2(adc_sync_fall), // 1-bit output for negative edge of clock
      .C(adc_clk),   // 1-bit clock input
      .CE(1'b1), // 1-bit clock enable input
      .D(adc_sync),   // 1-bit DDR data input
      .R(1'b0),   // 1-bit reset
      .S(1'b0)    // 1-bit set
   );
assign user_sync = adc_sync_rise | adc_sync_fall;   
   
// ADC out_of_range output
   IBUFGDS #(
      .DIFF_TERM("TRUE"),       	// Differential Termination (Virtex-4/5, Spartan-3E/3A)
      .IOSTANDARD("LVDS_25")    	// Specify the input I/O standard
   ) IBUFGDS_outofrange (
      .O(user_outofrange),  						// Buffer output
      .I(adc_outofrange_p),  						// Diff_p buffer input (connect directly to top-level port)
      .IB(adc_outofrange_n) 						// Diff_n buffer input (connect directly to top-level port)
   );

// asynch fifo

async_fifo_64by1024 adc_data_fifo (
	.din(adc_data_capture),
	.rd_clk(adc_clk),
	.rd_en(~adc_data_fifo_empty),
	.rst(dcm_reset),
	.wr_clk(adc_clk),
	.wr_en(~adc_data_fifo_full),
	.dout(adc_fifo_dout),
	.empty(adc_data_fifo_empty),
	.full(adc_data_fifo_full),
	.valid(user_data_valid)
);

assign user_datai0 = adc_fifo_dout[63:56]; 
assign user_datai1 = adc_fifo_dout[55:48];
assign user_datai2 = adc_fifo_dout[47:40];
assign user_datai3 = adc_fifo_dout[39:32];
assign user_dataq0 = adc_fifo_dout[31:24];
assign user_dataq1 = adc_fifo_dout[23:16];
assign user_dataq2 = adc_fifo_dout[15:8];
assign user_dataq3 = adc_fifo_dout[7:0];

endmodule
