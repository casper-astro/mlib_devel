/*
 *
 * ADC Interface for KAT ACD w/ National Semiconductor ADC08D1500
 *
 */

module kat_adc_interface #(
    /* parameter to enable extra registers between
       input buffer and distributed ram fifo;
       enable to optimize timing */
    parameter    EXTRA_REG = 1
  ) (
    /* External signals */
    input        adc_clk_p,
    input        adc_clk_n,
    input        adc_sync_p,
    input        adc_sync_n,
    input        adc_overrange_p,
    input        adc_overrange_n,
    output       adc_rst,
    output       adc_powerdown,
    input  [7:0] adc_di_d_p,
    input  [7:0] adc_di_d_n,
    input  [7:0] adc_di_p,
    input  [7:0] adc_di_n,
    input  [7:0] adc_dq_d_p,
    input  [7:0] adc_dq_d_n,
    input  [7:0] adc_dq_p,
    input  [7:0] adc_dq_n,
    /* User ports */
    output [7:0] user_datai3,
    output [7:0] user_datai2,
    output [7:0] user_datai1,
    output [7:0] user_datai0,
    output [7:0] user_dataq3,
    output [7:0] user_dataq2,
    output [7:0] user_dataq1,
    output [7:0] user_dataq0,
    output       user_sync0,
    output       user_sync1,
    output       user_sync2,
    output       user_sync3,
    output       user_outofrange0,
    output       user_outofrange1,
    output       user_data_valid,
    /* Internal control signals */
    // ADC CLK MMCM Reset
    input        mmcm_reset,
    // Reset for ADC
    input        ctrl_reset,
    // Clock to use for output data domain crossing 
    input        ctrl_clk_in,
    // ADC Clock outputs
    output       ctrl_clk_out,
    output       ctrl_clk90_out,
    output       ctrl_clk180_out,
    output       ctrl_clk270_out,
    output       ctrl_mmcm_locked,
    /* MMCM Phase control signals */
    input        mmcm_psclk,
    input        mmcm_psen,
    input        mmcm_psincdec,
    output       mmcm_psdone
  );

  wire adc_clk, adc_clk90, adc_clk180, adc_clk270;


  /********** Sync Capture *********/

  wire adc_sync_ibufds;

  IBUFDS ibufds_sync(
    .I  (adc_sync_p),
    .IB (adc_sync_n),
    .O  (adc_sync_ibufds)
  );
  wire capture_sync0;
  wire capture_sync1;
  wire capture_sync2;
  wire capture_sync3;

  reg adc_sync0;
  always @(posedge adc_clk)
    adc_sync0 <= adc_sync_ibufds;
  assign capture_sync0 = adc_sync0;

  reg adc_sync90;
  always @(posedge adc_clk90)
    adc_sync90 <= adc_sync_ibufds;
  assign capture_sync1 = adc_sync90;

  reg adc_sync180;
  always @(posedge adc_clk180)
    adc_sync180 <= adc_sync_ibufds;
  assign capture_sync2 = adc_sync180;

  reg adc_sync270;
  always @(posedge adc_clk270)
    adc_sync270 <= adc_sync_ibufds;
  assign capture_sync3 = adc_sync270;

  reg [3:0] adc_sync_capture;
  always @(posedge adc_clk) begin
    adc_sync_capture[0] <= capture_sync0;
    adc_sync_capture[2] <= capture_sync2;
  end

  always @(posedge adc_clk90) begin
    adc_sync_capture[1] <= capture_sync1;
    adc_sync_capture[3] <= capture_sync3;
  end

  /******* Over-Range Capture ******/

  wire adc_overrange_ibufds;
  IBUFDS ibufds_overrange(
    .I  (adc_overrange_p),
    .IB (adc_overrange_n),
    .O  (adc_overrange_ibufds)
  );
  
  wire adc_overrange_rise;
  wire adc_overrange_fall;

  IDDR #( 
    .DDR_CLK_EDGE ("SAME_EDGE_PIPELINED"),
    .INIT_Q1      (0),
    .INIT_Q2      (0),
    .SRTYPE       ("SYNC")
  ) iddr_overrange (
    .Q1 (adc_overrange_rise),
    .Q2 (adc_overrange_fall),
    .C  (adc_clk),
    .CE (1),
    .D  (adc_overrange_ibufds),
    .R  (0),
    .S  (0)
  );

  /************** MMCM ****************/

  wire adc_clk_buf;

  IBUFDS ibufds(
    .I  (adc_clk_p),
    .IB (adc_clk_n),
    .O  (adc_clk_buf)
  );

  //wire adc_clk_dcm, adc_clk90_dcm, adc_clk180_dcm, adc_clk270_dcm;
  //BUFG bufg_adc_clk[3:0](
  //  .I  ({adc_clk_dcm, adc_clk90_dcm, adc_clk180_dcm, adc_clk270_dcm}),
  //  .O  ({adc_clk, adc_clk90, adc_clk180, adc_clk270})
  //);

  wire clk_fb, clk_fb_mmcm, adc_clk_mmcm, adc_clk90_mmcm, adc_clk180_mmcm, adc_clk270_mmcm;
  BUFG bufg_adc_clk [4:0](
    .I ({clk_fb_mmcm, adc_clk_mmcm, adc_clk90_mmcm, adc_clk180_mmcm, adc_clk270_mmcm}),
    .O ({clk_fb,      adc_clk,      adc_clk90,      adc_clk180,      adc_clk270})
  );
  assign ctrl_clk_out    = adc_clk;
  assign ctrl_clk90_out  = adc_clk90;
  assign ctrl_clk180_out = adc_clk180;
  assign ctrl_clk270_out = adc_clk270;

  MMCM_BASE #(
    .BANDWIDTH          ("OPTIMIZED"), // Jitter programming ("HIGH","LOW","OPTIMIZED")
    .CLKFBOUT_MULT_F    (5), // Multiply value for all CLKOUT (5.0-64.0). THIS IS THE MULTIPLIER
    .CLKFBOUT_PHASE     (0.0),
    .CLKIN1_PERIOD      (4.4),
    .CLKOUT0_DIVIDE_F   (5), // Divide amount for CLKOUT0 (1.000-128.000).
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
    .CLKOUT1_DIVIDE     (5), //THIS IS THE DIVISOR
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
    
    .CLKFBOUT  (clk_fb_mmcm),
    .CLKFBOUTB (),
    
    .CLKOUT0  (adc_clk_mmcm),
    .CLKOUT0B (),
    .CLKOUT1  (adc_clk90_mmcm),
    .CLKOUT1B (),
    .CLKOUT2  (adc_clk180_mmcm),
    .CLKOUT2B (),
    .CLKOUT3  (adc_clk270_mmcm),
    .CLKOUT3B (),
    .CLKOUT4  (),
    .CLKOUT5  (),
    .CLKOUT6  (),
    .LOCKED   (mmcm_psdone),
    
    .PWRDWN   (1'b0),
    .RST      (mmcm_reset)
  );

  /************* Data DDR Capture ************/

  wire [7:0] adc_di_d;
  wire [7:0] adc_di;
  wire [7:0] adc_dq_d;
  wire [7:0] adc_dq;
  
  IBUFDS #(
    .IOSTANDARD ("LVDS_25"),
    .DIFF_TERM  ("TRUE")
  ) ibufds_adc_data[31:0] (
    .I  ({adc_di_d_p, adc_di_p, adc_dq_d_p, adc_dq_p}),
    .IB ({adc_di_d_n, adc_di_n, adc_dq_d_n, adc_dq_n}),
    .O  ({adc_di_d, adc_di, adc_dq_d, adc_dq})
  );

  wire [7:0] adc_di_d_rise;
  wire [7:0] adc_di_rise;
  wire [7:0] adc_dq_d_rise;
  wire [7:0] adc_dq_rise;

  wire [7:0] adc_di_d_fall;
  wire [7:0] adc_di_fall;
  wire [7:0] adc_dq_d_fall;
  wire [7:0] adc_dq_fall;

  IDDR #( 
    .DDR_CLK_EDGE ("SAME_EDGE_PIPELINED"),
    .INIT_Q1      (1'b0),
    .INIT_Q2      (1'b0)
  ) iddr_data[31:0] (
    .Q1 ({adc_di_d_rise, adc_di_rise, adc_dq_d_rise, adc_dq_rise}),
    .Q2 ({adc_di_d_fall, adc_di_fall, adc_dq_d_fall, adc_dq_fall}),
    .C  (adc_clk),
    .CE (1'b1),
    .D  ({adc_di_d, adc_di, adc_dq_d, adc_dq}),
    .R  (1'b0),
    .S  (1'b0)
  );

  /*************** ADC Clock Domain FIFO *****************/

  wire [69:0] fifo_data_in;
  wire [69:0] reg_data_in;
  assign reg_data_in = {adc_sync_capture, adc_overrange_fall, adc_overrange_rise, adc_dq_fall, adc_dq_d_fall, adc_dq_rise, adc_dq_d_rise, adc_di_fall, adc_di_d_fall, adc_di_rise, adc_di_d_rise};

  wire [69:0] fifo_data_out;
  wire fifo_empty;

  reg fifo_rd_en;

/* Optional stage of registeration to between input buffer and 
   clock domain crossing FIFO to improve timing performance */

generate if (EXTRA_REG) begin : with_extra_reg

  reg [69:0] extra_reg;
  always @(posedge adc_clk) begin
    extra_reg <= reg_data_in;
  end
  assign fifo_data_in = extra_reg;
  
end else begin
  assign fifo_data_in = reg_data_in;
end endgenerate
  
  adc_async_fifo adc_async_fifo_inst(
    .rst    (mmcm_reset),
    .din    (fifo_data_in),
    .wr_clk (adc_clk),
    .wr_en  (1'b1),
    .rd_clk (ctrl_clk_in),
    .rd_en  (fifo_rd_en),
    .dout   (fifo_data_out), 
    .empty  (fifo_empty),
    .full   ()
  );

  always @(posedge adc_clk) begin
    if (mmcm_reset) begin
      fifo_rd_en <= 1'b0;
    end else begin
      fifo_rd_en <= !fifo_empty;
    end
  end

  //synthesis attribute box_type adc_async_fifo_inst "black_box" 

  assign user_data_valid = fifo_empty;

  assign user_datai0 = fifo_data_out[7:0];
  assign user_datai1 = fifo_data_out[15:8];
  assign user_datai2 = fifo_data_out[23:16];
  assign user_datai3 = fifo_data_out[31:24];

  assign user_dataq0 = fifo_data_out[39:32];
  assign user_dataq1 = fifo_data_out[47:40];
  assign user_dataq2 = fifo_data_out[55:48];
  assign user_dataq3 = fifo_data_out[63:56];

  assign user_outofrange0 = fifo_data_out[64];
  assign user_outofrange1 = fifo_data_out[65];
  assign user_sync0 = fifo_data_out[66];
  assign user_sync1 = fifo_data_out[67];
  assign user_sync2 = fifo_data_out[68];
  assign user_sync3 = fifo_data_out[69];

  /***************** Misc *******************/

  assign adc_powerdown = 1'b0; // active low
  assign adc_rst = ctrl_reset;
  
endmodule
