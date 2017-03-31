module adc083000_board_phy(
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
	adc_user_dataq0,
	adc_user_dataq1,
	adc_user_dataq2,
	adc_user_dataq3,
	adc_sync0,
	adc_sync1,
	adc_sync2,
	adc_sync3,
	adc_outofrange0,
	adc_outofrange1,
	adc_outofrange2,
	adc_outofrange3,
	
	ctrl_reset,
	adc_dcm_locked,
	ctrl_clk_out
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
output [7:0] adc_user_dataq0;
output [7:0] adc_user_datai1;
output [7:0] adc_user_dataq1;
output [7:0] adc_user_datai2;
output [7:0] adc_user_dataq2;
output [7:0] adc_user_datai3;
output [7:0] adc_user_dataq3;
output adc_sync0;
output adc_sync1;
output adc_sync2;
output adc_sync3;
output adc_outofrange0;
output adc_outofrange1;
output adc_outofrange2;
output adc_outofrange3;

// control lines
input ctrl_reset;
output adc_dcm_locked;
input ctrl_clk_out;

// Wires and Regs
//===============
wire adc_clk_buf;
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
wire adc_data_fifo_full;
wire adc_data_fifo_empty;
wire [63:0] adc_fifo_din;
wire [63:0] adc_fifo_dout;
wire adc_dcm_locked;
wire [7:0] dcm0_status;
wire data_buf_clk;

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
	.ctrl_clk_out(ctrl_clk_out),
	.reset(ctrl_reset), 
	.din(adc_datai0_asynch), 
	.dout(adc_datai0_recapture));

recapture adc_datai1_recap( 
	.clk(adc_clk), 
	.ctrl_clk_out(ctrl_clk_out),
	.reset(ctrl_reset), 
	.din(adc_datai1_asynch), 
	.dout(adc_datai1_recapture));

recapture adc_datai2_recap( 
	.clk(adc_clk), 
	.ctrl_clk_out(ctrl_clk_out),
	.reset(ctrl_reset), 
	.din(adc_datai2_asynch), 
	.dout(adc_datai2_recapture));

recapture adc_datai3_recap( 
	.clk(adc_clk), 
	.ctrl_clk_out(ctrl_clk_out),
	.reset(ctrl_reset), 
	.din(adc_datai3_asynch), 
	.dout(adc_datai3_recapture));

recapture adc_dataq0_recap( 
	.clk(adc_clk), 
	.ctrl_clk_out(ctrl_clk_out),
	.reset(ctrl_reset), 
	.din(adc_dataq0_asynch), 
	.dout(adc_dataq0_recapture));

recapture adc_dataq1_recap( 
	.clk(adc_clk), 
	.ctrl_clk_out(ctrl_clk_out),
	.reset(ctrl_reset), 
	.din(adc_dataq1_asynch), 
	.dout(adc_dataq1_recapture));

recapture adc_dataq2_recap( 
	.clk(adc_clk), 
	.ctrl_clk_out(ctrl_clk_out),
	.reset(ctrl_reset), 
	.din(adc_dataq2_asynch), 
	.dout(adc_dataq2_recapture));

recapture adc_dataq3_recap( 
	.clk(adc_clk), 
	.ctrl_clk_out(ctrl_clk_out),
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

//async_fifo_64by16 adc_data_fifo (
//	.din(adc_fifo_din),
//	.rd_clk(data_buf_clk),
//	.rd_en(~adc_data_fifo_empty),
//	.rst(ctrl_reset),
//	.wr_clk(adc_clk),
//	.wr_en(~adc_data_fifo_full),
//	.dout(adc_fifo_dout),
//	.empty(adc_data_fifo_empty),
//	.full(adc_data_fifo_full),
//	.valid(adc_user_data_valid)
//);

	
// DCM(s) and CLock Management 
// Clock from ZDOK0 	
 IBUFGDS #(// Buffer for input clk
	.DIFF_TERM("TRUE"),       	// Differential Termination (Virtex-4/5, Spartan-3E/3A)
	.IOSTANDARD("LVDS_25")    	// Specify the input I/O standard
) IBUFGDS_3 (
	.O(adc_clk_buf),  						// Buffer output
	.I(adc_clk_p),  						// Diff_p buffer input (connect directly to top-level port)
	.IB(adc_clk_n) 						// Diff_n buffer input (connect directly to top-level port)
);

  wire clk_fb;

  MMCM_BASE #(
   .BANDWIDTH          ("OPTIMIZED"), // Jitter programming ("HIGH","LOW","OPTIMIZED")
   .CLKFBOUT_MULT_F    (5), // Multiply value for all CLKOUT (5.0-64.0).
   .CLKFBOUT_PHASE     (0.0),
   .CLKIN1_PERIOD      (5.0),
   .CLKOUT0_DIVIDE_F   (5.0), // Divide amount for CLKOUT0 (1.000-128.000).
   .CLKOUT0_DUTY_CYCLE (0.5),
   .CLKOUT1_DUTY_CYCLE (0.5),
   .CLKOUT2_DUTY_CYCLE (0.5),
   .CLKOUT3_DUTY_CYCLE (0.5),
   .CLKOUT4_DUTY_CYCLE (0.5),
   .CLKOUT5_DUTY_CYCLE (0.5),
   .CLKOUT6_DUTY_CYCLE (0.5),
   .CLKOUT0_PHASE      (0.0),
   .CLKOUT1_PHASE      (90),
   .CLKOUT2_PHASE      (180),
   .CLKOUT3_PHASE      (270),
   .CLKOUT4_PHASE      (0.0),
   .CLKOUT5_PHASE      (0.0),
   .CLKOUT6_PHASE      (0.0),
   .CLKOUT1_DIVIDE     (5),
   .CLKOUT2_DIVIDE     (5),
   .CLKOUT3_DIVIDE     (5),
   .CLKOUT4_DIVIDE     (1),
   .CLKOUT5_DIVIDE     (1),
   .CLKOUT6_DIVIDE     (1),
   .CLKOUT4_CASCADE    ("FALSE"),
   .CLOCK_HOLD         ("FALSE"),
   .DIVCLK_DIVIDE      (1), // Master division value (1-80)
   .REF_JITTER1        (0.0),
   .STARTUP_WAIT       ("FALSE")
  ) MMCM_BASE_inst (
   .CLKIN1   (adc_clk_buf),
   .CLKFBIN  (clk_fb),

   .CLKFBOUT  (clk_fb),
   .CLKFBOUTB (),

   .CLKOUT0  (adc_clk_dcm),
   .CLKOUT0B (),
   .CLKOUT1  (adc_clk90_dcm),
   .CLKOUT1B (),
   .CLKOUT2  (adc_clk180_dcm),
   .CLKOUT2B (),
   .CLKOUT3  (adc_clk270_dcm),
   .CLKOUT3B (),
   .CLKOUT4  (),
   .CLKOUT5  (),
   .CLKOUT6  (),
   .LOCKED   (adc_dcm_locked),

   .PWRDWN   (1'b0),
   .RST      (ctrl_reset)
  );
  assign dcm0_status = 8'b0;

// Buffer outputs of DCM
BUFG adc_clk0_bufg (.I( adc_clk_dcm ), .O( adc_clk ));
BUFG data_buf_clk_bufg (.I( adc_clk_dcm ), .O( data_buf_clk ));
BUFG adc_clk90_bufg (.I( adc_clk90_dcm ), .O( adc_clk90 ));
BUFG adc_clk180_bufg (.I( adc_clk180_dcm ), .O( adc_clk180 ));
BUFG adc_clk270_bufg (.I( adc_clk270_dcm ), .O( adc_clk270 ));



assign adc_user_datai0 = adc_fifo_din[63:56]; 
assign adc_user_dataq0 = adc_fifo_din[31:24];
assign adc_user_datai1 = adc_fifo_din[55:48];
assign adc_user_dataq1 = adc_fifo_din[23:16];
assign adc_user_datai2 = adc_fifo_din[47:40];
assign adc_user_dataq2 = adc_fifo_din[15:8];
assign adc_user_datai3 = adc_fifo_din[39:32];
assign adc_user_dataq3 = adc_fifo_din[7:0];
endmodule
