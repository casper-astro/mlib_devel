/*************************************************************************************************************************
* Module: skarab_hmc_tst
* Author: Henno Kriel
* Date: 11 Jan 2016
* 
* Description:
* This module is 
*************************************************************************************************************************/

module hmc #(
    //Define width of the datapath
    parameter LOG_FPW               = 2,        //Legal Values: 1,2,3
    parameter FPW                   = 4,        //Legal Values: 2,4,6,8
    parameter DWIDTH                = FPW*128,  //Leave untouched
    //Define HMC interface width
    parameter LOG_NUM_LANES         = 3,                //Set 3 for half-width, 4 for full-width
    parameter NUM_LANES             = 2**LOG_NUM_LANES, //Leave untouched
    parameter NUM_DATA_BYTES        = FPW*16,           //Leave untouched
    //Define width of the register file
    parameter HMC_RF_WWIDTH         = 64,
    parameter HMC_RF_RWIDTH         = 64,
    parameter HMC_RF_AWIDTH         = 5,
    //Configure the Functionality
    parameter LOG_MAX_RTC           = 8,   //Set the depth of the RX input buffer. Must be >= LOG(rf_rx_buffer_rtc) in the RF
    parameter HMC_RX_AC_COUPLED     = 1,    //Set to 0 to remove the run length limiter, saves logic and 1 cycle delay
    parameter CTRL_LANE_POLARITY    = 0,    //Set to 0 if lane polarity is not applicable or performed by the transceivers, saves logic and 1 cycle delay
    parameter CTRL_LANE_REVERSAL    = 0,    //Set to 0 if lane reversal is not applicable or performed by the transceivers, saves logic
    //Set the direction of bitslip. Set to 1 if bitslip performs a shift right, otherwise set to 0 (see the corresponding transceiver user guide)
    parameter BITSLIP_SHIFT_RIGHT   = 1,    
    //Debug Params
    parameter DBG_RX_TOKEN_MON      = 1,     //Remove the RX Link token monitor, saves logic
    parameter USE_CHIPSCOPE         = 1,
    parameter USE_LEDS              = 1
)(

    // FPGA GTH Transceivers RX (HMC TX)
    input wire  [3:0]   PHY11_LANE_RX_P,
    input wire  [3:0]   PHY12_LANE_RX_P,

    input wire  [3:0]   PHY21_LANE_RX_P,
    input wire  [3:0]   PHY22_LANE_RX_P,

    input wire  [3:0]   PHY11_LANE_RX_N,
    input wire  [3:0]   PHY12_LANE_RX_N,

    input wire  [3:0]   PHY21_LANE_RX_N,
    input wire  [3:0]   PHY22_LANE_RX_N,

   //FPGA GTH Transceivers TX (HMC RX)
   output wire  [3:0]   PHY11_LANE_TX_P,
   output wire  [3:0]   PHY12_LANE_TX_P,

   output wire  [3:0]   PHY21_LANE_TX_P,
   output wire  [3:0]   PHY22_LANE_TX_P,

   output wire  [3:0]   PHY11_LANE_TX_N,
   output wire  [3:0]   PHY12_LANE_TX_N,

   output wire  [3:0]   PHY21_LANE_TX_N,
   output wire  [3:0]   PHY22_LANE_TX_N,

    // FPGA GTH ref clocks
    input wire          REFCLK_PAD_N_IN_0_LINK2,
    input wire          REFCLK_PAD_P_IN_0_LINK2,
    input wire          REFCLK_PAD_N_IN_1_LINK2,
    input wire          REFCLK_PAD_P_IN_1_LINK2,

    input wire          REFCLK_PAD_N_IN_0_LINK3,
    input wire          REFCLK_PAD_P_IN_0_LINK3,
    input wire          REFCLK_PAD_N_IN_1_LINK3,
    input wire          REFCLK_PAD_P_IN_1_LINK3,

    // hard reset for mezzanine
    output wire HMC_MEZZ_RESET,

    // IIC BUS for mezzanine
    output SDA_OUT,
    output SCL_OUT,
    input SCL_IN,
    input SDA_IN,

    // Enable mezzanine1 SKARAB onboard clock 
    output wire MEZZ_CLK_SEL,

    //simulink ports
    input  wire USER_CLK,
    input  wire USER_RST,
    input  wire [255:0] DATA_IN,
    output wire [255:0] DATA_OUT,
    input  wire RD_REQ,
    input  wire WR_REQ,
    input  wire [26:0] WR_ADDRESS,
    input  wire [26:0] RD_ADDRESS,
    input  wire [8:0] TAG_IN,
    output wire [8:0] TAG_OUT,
    output wire DATA_VALID,
    output wire POST_OK,
    output wire RD_READY,
    output wire WR_READY,
    output wire INIT_DONE
);

wire soft_reset_link2,soft_reset_link3;
reg [31:0] time_out_cnt;
reg time_out_cnt_rst;
wire soft_reset;

assign soft_reset_link2 = (qpll_lock_link2 == 1'b0 || USER_RST == 1'b1 || time_out_cnt_rst == 1'b1);
assign soft_reset_link3 = (qpll_lock_link3 == 1'b0 || USER_RST == 1'b1 || time_out_cnt_rst == 1'b1);
assign soft_reset = (soft_reset_link2 == 1'b1 || soft_reset_link3 == 1'b1);


assign MEZZ_CLK_SEL = 1'b0;
//assign HMC_MEZZ_RESET = USER_RST;//~P_RST_N;
wire                         s_axis_tx_TVALID_link2;
wire                         s_axis_tx_TREADY_link2;
wire [DWIDTH-1:0]            s_axis_tx_TDATA_link2;
wire [NUM_DATA_BYTES-1:0]    s_axis_tx_TUSER_link2;
//From HMC Ctrl RX to AXI
wire                         m_axis_rx_TVALID_link2;
wire                         m_axis_rx_TREADY_link2;
wire [DWIDTH-1:0]            m_axis_rx_TDATA_link2;
wire [NUM_DATA_BYTES-1:0]    m_axis_rx_TUSER_link2;

wire                         s_axis_tx_TVALID_link3;
wire                         s_axis_tx_TREADY_link3;
wire [DWIDTH-1:0]            s_axis_tx_TDATA_link3;
wire [NUM_DATA_BYTES-1:0]    s_axis_tx_TUSER_link3;
//From HMC Ctrl RX to AXI
wire                         m_axis_rx_TVALID_link3;
wire                         m_axis_rx_TREADY_link3;
wire [DWIDTH-1:0]            m_axis_rx_TDATA_link3;
wire [NUM_DATA_BYTES-1:0]    m_axis_rx_TUSER_link3;



wire                         post_flit_s_axis_tx_TVALID_link2;
wire                         post_flit_s_axis_tx_TREADY_link2;
wire [DWIDTH-1:0]            post_flit_s_axis_tx_TDATA_link2;
wire [NUM_DATA_BYTES-1:0]    post_flit_s_axis_tx_TUSER_link2;

wire                         post_flit_m_axis_rx_TVALID_link2;
wire                         post_flit_m_axis_rx_TREADY_link2;
wire [DWIDTH-1:0]            post_flit_m_axis_rx_TDATA_link2;
wire [NUM_DATA_BYTES-1:0]    post_flit_m_axis_rx_TUSER_link2;

wire                         post_flit_s_axis_tx_TVALID_link3;
wire                         post_flit_s_axis_tx_TREADY_link3;
wire [DWIDTH-1:0]            post_flit_s_axis_tx_TDATA_link3;
wire [NUM_DATA_BYTES-1:0]    post_flit_s_axis_tx_TUSER_link3;
//From HMC Ctrl RX to AXI
wire                         post_flit_m_axis_rx_TVALID_link3;
wire                         post_flit_m_axis_rx_TREADY_link3;
wire [DWIDTH-1:0]            post_flit_m_axis_rx_TDATA_link3;
wire [NUM_DATA_BYTES-1:0]    post_flit_m_axis_rx_TUSER_link3;

wire                         user_flit_s_axis_tx_TVALID_link2;
wire                         user_flit_s_axis_tx_TREADY_link2;
wire [DWIDTH-1:0]            user_flit_s_axis_tx_TDATA_link2;
wire [NUM_DATA_BYTES-1:0]    user_flit_s_axis_tx_TUSER_link2;

wire                         user_flit_m_axis_rx_TVALID_link2;
wire                         user_flit_m_axis_rx_TREADY_link2;
wire [DWIDTH-1:0]            user_flit_m_axis_rx_TDATA_link2;
wire [NUM_DATA_BYTES-1:0]    user_flit_m_axis_rx_TUSER_link2;

wire                         user_flit_s_axis_tx_TVALID_link3;
wire                         user_flit_s_axis_tx_TREADY_link3;
wire [DWIDTH-1:0]            user_flit_s_axis_tx_TDATA_link3;
wire [NUM_DATA_BYTES-1:0]    user_flit_s_axis_tx_TUSER_link3;
//From HMC Ctrl RX to AXI
wire                         user_flit_m_axis_rx_TVALID_link3;
wire                         user_flit_m_axis_rx_TREADY_link3;
wire [DWIDTH-1:0]            user_flit_m_axis_rx_TDATA_link3;
wire [NUM_DATA_BYTES-1:0]    user_flit_m_axis_rx_TUSER_link3;



//----------------------------------
//----Connect RF
//----------------------------------
wire  [HMC_RF_AWIDTH-1:0]    rf_address_link2,rf_address_link3;
wire  [HMC_RF_RWIDTH-1:0]    rf_read_data_link2,rf_read_data_link3;
wire                         rf_invalid_address_link2,rf_invalid_address_link3;
wire                         rf_access_complete_link2,rf_access_complete_link3;
wire                         rf_read_en_link2,rf_read_en_link3;
wire                         rf_write_en_link2,rf_write_en_link3;
wire  [HMC_RF_WWIDTH-1:0]    rf_write_data_link2,rf_write_data_link3;

wire open_hmc_done_link2,open_hmc_done_link3;
wire [63:0] data_rx_flit_cnt_link2,data_rx_flit_cnt_link3;
wire [63:0] data_rx_err_flit_cnt_link2,data_rx_err_flit_cnt_link3;
wire data_err_detect_link2,data_err_detect_link3;
wire [15:0] rx_crc_err_cnt_link2,rx_crc_err_cnt_link3;

// Currently not connected to Wisbone
assign rf_address_link2 = {HMC_RF_AWIDTH{1'b0}};
assign rf_read_en_link2 = 1'b0;
assign rf_write_en_link2 = 1'b0;
assign rf_write_data_link2 = {HMC_RF_WWIDTH{1'b0}};

assign rf_address_link3 = {HMC_RF_AWIDTH{1'b0}};
assign rf_read_en_link3 = 1'b0;
assign rf_write_en_link3 = 1'b0;
assign rf_write_data_link3 = {HMC_RF_WWIDTH{1'b0}};

//assignments here
//MEZZANINE RX PHY
wire [7:0] GT_GTHRXP_IN_LINK3, GT_GTHRXP_IN_LINK2, GT_GTHRXN_IN_LINK3, GT_GTHRXN_IN_LINK2;
wire [7:0] GT_GTHTXP_OUT_LINK3, GT_GTHTXP_OUT_LINK2, GT_GTHTXN_OUT_LINK3, GT_GTHTXN_OUT_LINK2;
assign GT_GTHRXP_IN_LINK3[0] = PHY11_LANE_RX_P[3];
assign GT_GTHRXP_IN_LINK3[1] = PHY11_LANE_RX_P[2];
assign GT_GTHRXP_IN_LINK3[2] = PHY11_LANE_RX_P[1];
assign GT_GTHRXP_IN_LINK3[3] = PHY11_LANE_RX_P[0];
assign GT_GTHRXP_IN_LINK3[4] = PHY12_LANE_RX_P[3];
assign GT_GTHRXP_IN_LINK3[5] = PHY12_LANE_RX_P[2];
assign GT_GTHRXP_IN_LINK3[6] = PHY12_LANE_RX_P[1];
assign GT_GTHRXP_IN_LINK3[7] = PHY12_LANE_RX_P[0]; 

assign GT_GTHRXN_IN_LINK3[0] = PHY11_LANE_RX_N[3];
assign GT_GTHRXN_IN_LINK3[1] = PHY11_LANE_RX_N[2];
assign GT_GTHRXN_IN_LINK3[2] = PHY11_LANE_RX_N[1];
assign GT_GTHRXN_IN_LINK3[3] = PHY11_LANE_RX_N[0];
assign GT_GTHRXN_IN_LINK3[4] = PHY12_LANE_RX_N[3];
assign GT_GTHRXN_IN_LINK3[5] = PHY12_LANE_RX_N[2];
assign GT_GTHRXN_IN_LINK3[6] = PHY12_LANE_RX_N[1];
assign GT_GTHRXN_IN_LINK3[7] = PHY12_LANE_RX_N[0]; 

assign GT_GTHRXP_IN_LINK2[0] = PHY21_LANE_RX_P[3];
assign GT_GTHRXP_IN_LINK2[1] = PHY21_LANE_RX_P[2];
assign GT_GTHRXP_IN_LINK2[2] = PHY21_LANE_RX_P[1];
assign GT_GTHRXP_IN_LINK2[3] = PHY21_LANE_RX_P[0];
assign GT_GTHRXP_IN_LINK2[4] = PHY22_LANE_RX_P[3];
assign GT_GTHRXP_IN_LINK2[5] = PHY22_LANE_RX_P[2];
assign GT_GTHRXP_IN_LINK2[6] = PHY22_LANE_RX_P[1];
assign GT_GTHRXP_IN_LINK2[7] = PHY22_LANE_RX_P[0]; 

assign GT_GTHRXN_IN_LINK2[0] = PHY21_LANE_RX_N[3];
assign GT_GTHRXN_IN_LINK2[1] = PHY21_LANE_RX_N[2];
assign GT_GTHRXN_IN_LINK2[2] = PHY21_LANE_RX_N[1];
assign GT_GTHRXN_IN_LINK2[3] = PHY21_LANE_RX_N[0];
assign GT_GTHRXN_IN_LINK2[4] = PHY22_LANE_RX_N[3];
assign GT_GTHRXN_IN_LINK2[5] = PHY22_LANE_RX_N[2];
assign GT_GTHRXN_IN_LINK2[6] = PHY22_LANE_RX_N[1];
assign GT_GTHRXN_IN_LINK2[7] = PHY22_LANE_RX_N[0];



// MEZZANINE TX PHY
assign PHY11_LANE_TX_P[3] = GT_GTHTXP_OUT_LINK3[0];
assign PHY11_LANE_TX_P[2] = GT_GTHTXP_OUT_LINK3[1];
assign PHY11_LANE_TX_P[1] = GT_GTHTXP_OUT_LINK3[2];
assign PHY11_LANE_TX_P[0] = GT_GTHTXP_OUT_LINK3[3];
assign PHY12_LANE_TX_P[3] = GT_GTHTXP_OUT_LINK3[4];
assign PHY12_LANE_TX_P[2] = GT_GTHTXP_OUT_LINK3[5];
assign PHY12_LANE_TX_P[1] = GT_GTHTXP_OUT_LINK3[6];
assign PHY12_LANE_TX_P[0] = GT_GTHTXP_OUT_LINK3[7];

assign PHY11_LANE_TX_N[3] = GT_GTHTXN_OUT_LINK3[0];
assign PHY11_LANE_TX_N[2] = GT_GTHTXN_OUT_LINK3[1];
assign PHY11_LANE_TX_N[1] = GT_GTHTXN_OUT_LINK3[2];
assign PHY11_LANE_TX_N[0] = GT_GTHTXN_OUT_LINK3[3];
assign PHY12_LANE_TX_N[3] = GT_GTHTXN_OUT_LINK3[4];
assign PHY12_LANE_TX_N[2] = GT_GTHTXN_OUT_LINK3[5];
assign PHY12_LANE_TX_N[1] = GT_GTHTXN_OUT_LINK3[6];
assign PHY12_LANE_TX_N[0] = GT_GTHTXN_OUT_LINK3[7];

assign PHY21_LANE_TX_P[3] = GT_GTHTXP_OUT_LINK2[0];
assign PHY21_LANE_TX_P[2] = GT_GTHTXP_OUT_LINK2[1];
assign PHY21_LANE_TX_P[1] = GT_GTHTXP_OUT_LINK2[2];
assign PHY21_LANE_TX_P[0] = GT_GTHTXP_OUT_LINK2[3];
assign PHY22_LANE_TX_P[3] = GT_GTHTXP_OUT_LINK2[4];
assign PHY22_LANE_TX_P[2] = GT_GTHTXP_OUT_LINK2[5];
assign PHY22_LANE_TX_P[1] = GT_GTHTXP_OUT_LINK2[6];
assign PHY22_LANE_TX_P[0] = GT_GTHTXP_OUT_LINK2[7];

assign PHY21_LANE_TX_N[3] = GT_GTHTXN_OUT_LINK2[0];
assign PHY21_LANE_TX_N[2] = GT_GTHTXN_OUT_LINK2[1];
assign PHY21_LANE_TX_N[1] = GT_GTHTXN_OUT_LINK2[2];
assign PHY21_LANE_TX_N[0] = GT_GTHTXN_OUT_LINK2[3];
assign PHY22_LANE_TX_N[3] = GT_GTHTXN_OUT_LINK2[4];
assign PHY22_LANE_TX_N[2] = GT_GTHTXN_OUT_LINK2[5];
assign PHY22_LANE_TX_N[1] = GT_GTHTXN_OUT_LINK2[6];
assign PHY22_LANE_TX_N[0] = GT_GTHTXN_OUT_LINK2[7];

// Instatiate HMC IIC initialization state machine
// This state machine must first setup the HMC chip before the openHMC core can proceed with link  

// wait for POST to run successfuly for 100s before declaring POST done
wire post_done = ((data_rx_flit_cnt_link2[25] == 1'b1) && (data_rx_flit_cnt_link3[25] == 1'b1));
wire post_ok = ((data_rx_err_flit_cnt_link3 == 64'd0) && (data_rx_err_flit_cnt_link2 == 64'd0) && (data_rx_flit_cnt_link2[25] == 1'b1) && (data_rx_flit_cnt_link3[25] == 1'b1));

reg [1:0] post_okR;
reg post_ok_latch;

always @(posedge USER_CLK or posedge USER_RST) begin 
  if (USER_RST == 1'b1) begin
    post_ok_latch <= 1'b0;
    post_okR <= 2'b00;
    time_out_cnt <= 32'd0;
    time_out_cnt_rst <= 1'b0;
  end else begin
    post_okR <= {post_okR[0],post_ok};
    time_out_cnt <= time_out_cnt + 1'b1;
    time_out_cnt_rst <= time_out_cnt[30];
    if (post_okR == 2'b01) begin
      post_ok_latch <= 1'b1;
    end
    if (hmc_reset == 1'b1) begin
      time_out_cnt <= 32'd0;
    end 
    if (open_hmc_done_link2 == 1'b1 && open_hmc_done_link3 == 1'b1) begin
      time_out_cnt <= 32'd0;
    end 
  end
end

hmc_iic_init 
hmc_iic_init_inst (
  .CLK         (USER_CLK),
  .RST         (soft_reset),//(USER_RST),// As soon as the clock is stable 
  .IIC_ACK_ERR (iic_err),
  .IIC_BUSY    (iic_busy),
  .HMC_IIC_INIT_DONE (hmc_iic_init_done),
  .HMC_POST_DONE (post_done),
  .POST_DONE_LATCH(post_done_latch),
  .HMC_RESET   (hmc_reset),
//  .SDA         (SDA),
//  .SCL         (SCL) 
  .SDA_OUT(SDA_OUT),
  .SCL_OUT(SCL_OUT),
  .SCL_IN(SCL_IN),
  .SDA_IN(SDA_IN)  
);

assign POST_OK = post_ok_latch;
assign INIT_DONE = post_done_latch;
assign HMC_MEZZ_RESET = hmc_reset;//~P_RST_N; 

// Instantiate core for HMC link2
hmc_ska_sa_top #(
   //Define width of the datapath
  .LOG_FPW(LOG_FPW),        //Legal Values: 1,2,3
  .FPW(FPW),        //Legal Values: 2,4,6,8
  .DWIDTH(DWIDTH),  //Leave untouched
  //Define HMC interface width
  .LOG_NUM_LANES(LOG_NUM_LANES),                //Set 3 for half-width, 4 for full-width
  .NUM_LANES(NUM_LANES), //Leave untouched
  .NUM_DATA_BYTES(NUM_DATA_BYTES),           //Leave untouched
  //Define width of the register file
  .HMC_RF_WWIDTH(HMC_RF_WWIDTH),
  .HMC_RF_RWIDTH(HMC_RF_RWIDTH),
  .HMC_RF_AWIDTH(HMC_RF_AWIDTH),
  //Configure the Functionality
  .LOG_MAX_RTC       (LOG_MAX_RTC       ),    //Set the depth of the RX input buffer. Must be >= LOG(rf_rx_buffer_rtc) in the RF
  .HMC_RX_AC_COUPLED (HMC_RX_AC_COUPLED ),    //Set to 0 to remove the run length limiter, saves logic and 1 cycle delay
  .CTRL_LANE_POLARITY(CTRL_LANE_POLARITY),    //Set to 0 if lane polarity is not applicable or performed by the transceivers, saves logic and 1 cycle delay
  .CTRL_LANE_REVERSAL(CTRL_LANE_REVERSAL),    //Set to 0 if lane reversal is not applicable or performed by the transceivers, saves logic
  //Set the direction of bitslip. Set to 1 if bitslip performs a shift right, otherwise set to 0 (see the corresponding transceiver user guide)
  .BITSLIP_SHIFT_RIGHT(BITSLIP_SHIFT_RIGHT),    
  //Debug Params
  .DBG_RX_TOKEN_MON (DBG_RX_TOKEN_MON),     //Remove the RX Link token monitor, saves logic
  .LINK(2)
)  
hmc_ska_sa_top_link2_inst(
  //---------------------- Receive Ports
  .gt_gthrxp_in(GT_GTHRXP_IN_LINK2),
  .gt_gthrxn_in(GT_GTHRXN_IN_LINK2),
  //---------------------- Transmit Ports
  .gt_gthtxp_out(GT_GTHTXP_OUT_LINK2),
  .gt_gthtxn_out(GT_GTHTXN_OUT_LINK2),
  .REFCLK_PAD_N_IN_0(REFCLK_PAD_N_IN_0_LINK2),
  .REFCLK_PAD_P_IN_0(REFCLK_PAD_P_IN_0_LINK2),
  .REFCLK_PAD_N_IN_1(REFCLK_PAD_N_IN_1_LINK2),
  .REFCLK_PAD_P_IN_1(REFCLK_PAD_P_IN_1_LINK2),
  //____________________________COMMON PORTS________________________________
  //-------------------- Common Block  - Ref Clock Ports ---------------------
  //----------------------------------
  //----SYSTEM INTERFACES
  //----------------------------------
  .SOFT_RESET_IN(soft_reset_link2),
  .clk_user(USER_CLK),
  .res_n_user(~soft_reset_link2),
  .clk_hmc_out(),
  .hmc_reset_out(),
  .QPLL_LOCK(qpll_lock_link2),
  //----------------------------------
  //----Connect RF
  //----------------------------------
  .rf_address(rf_address_link2),
  .rf_read_data(rf_read_data_link2),
  .rf_invalid_address(rf_invalid_address_link2),
  .rf_access_complete(rf_access_complete_link2),
  .rf_read_en(rf_read_en_link2),
  .rf_write_en(rf_write_en_link2),
  .rf_write_data(rf_write_data_link2),
  //----------------------------------
  //----Connect AXI Ports
  //----------------------------------
  //From AXI to HMC Ctrl TX
  .s_axis_tx_TVALID(s_axis_tx_TVALID_link2),
  .s_axis_tx_TREADY(s_axis_tx_TREADY_link2),
  .s_axis_tx_TDATA(s_axis_tx_TDATA_link2),
  .s_axis_tx_TUSER(s_axis_tx_TUSER_link2),
  //From HMC Ctrl RX to AXI
  .m_axis_rx_TVALID(m_axis_rx_TVALID_link2),
  .m_axis_rx_TREADY(m_axis_rx_TREADY_link2),
  .m_axis_rx_TDATA(m_axis_rx_TDATA_link2),
  .m_axis_rx_TUSER(m_axis_rx_TUSER_link2),
  //----------------------------------
  //----Connect HMC
  //----------------------------------
  .P_RST_N(),
  .FERR_N(1'b1), //Not connected
  .OPEN_HMC_INIT_DONE(open_hmc_done_link2),
  .HMC_IIC_INIT_DONE(hmc_iic_init_done),
  .RX_CRC_ERR_CNT(rx_crc_err_cnt_link2)
);

// Instantiate core for HMC link3
hmc_ska_sa_top #(
  //Define width of the datapath
  .LOG_FPW(LOG_FPW),        //Legal Values: 1,2,3
  .FPW(FPW),        //Legal Values: 2,4,6,8
  .DWIDTH(DWIDTH),  //Leave untouched
  //Define HMC interface width
  .LOG_NUM_LANES(LOG_NUM_LANES),                //Set 3 for half-width, 4 for full-width
  .NUM_LANES(NUM_LANES), //Leave untouched
  .NUM_DATA_BYTES(NUM_DATA_BYTES),           //Leave untouched
  //Define width of the register file
  .HMC_RF_WWIDTH(HMC_RF_WWIDTH),
  .HMC_RF_RWIDTH(HMC_RF_RWIDTH),
  .HMC_RF_AWIDTH(HMC_RF_AWIDTH),
  //Configure the Functionality
  .LOG_MAX_RTC       (LOG_MAX_RTC       ),    //Set the depth of the RX input buffer. Must be >= LOG(rf_rx_buffer_rtc) in the RF
  .HMC_RX_AC_COUPLED (HMC_RX_AC_COUPLED ),    //Set to 0 to remove the run length limiter, saves logic and 1 cycle delay
  .CTRL_LANE_POLARITY(CTRL_LANE_POLARITY),    //Set to 0 if lane polarity is not applicable or performed by the transceivers, saves logic and 1 cycle delay
  .CTRL_LANE_REVERSAL(CTRL_LANE_REVERSAL),    //Set to 0 if lane reversal is not applicable or performed by the transceivers, saves logic
  //Set the direction of bitslip. Set to 1 if bitslip performs a shift right, otherwise set to 0 (see the corresponding transceiver user guide)
  .BITSLIP_SHIFT_RIGHT(BITSLIP_SHIFT_RIGHT),    
  //Debug Params
  .DBG_RX_TOKEN_MON (DBG_RX_TOKEN_MON),     //Remove the RX Link token monitor, saves logic
  .LINK(3)
)  
hmc_ska_sa_top_link3_inst(
  //---------------------- Receive Ports
  .gt_gthrxp_in(GT_GTHRXP_IN_LINK3),
  .gt_gthrxn_in(GT_GTHRXN_IN_LINK3),
  //---------------------- Transmit Ports
  .gt_gthtxp_out(GT_GTHTXP_OUT_LINK3),
  .gt_gthtxn_out(GT_GTHTXN_OUT_LINK3),
  .REFCLK_PAD_N_IN_0(REFCLK_PAD_N_IN_0_LINK3),
  .REFCLK_PAD_P_IN_0(REFCLK_PAD_P_IN_0_LINK3),
  .REFCLK_PAD_N_IN_1(REFCLK_PAD_N_IN_1_LINK3),
  .REFCLK_PAD_P_IN_1(REFCLK_PAD_P_IN_1_LINK3),
  //____________________________COMMON PORTS________________________________
  //-------------------- Common Block  - Ref Clock Ports ---------------------
  //----------------------------------
  //----SYSTEM INTERFACES
  //----------------------------------
  .SOFT_RESET_IN(soft_reset_link3),
  .clk_user(USER_CLK),
  .res_n_user(~soft_reset_link3),
  .clk_hmc_out(),
  .hmc_reset_out(),
  .QPLL_LOCK(qpll_lock_link3),
  //----------------------------------
  //----Connect RF
  //----------------------------------
  .rf_address(rf_address_link3),
  .rf_read_data(rf_read_data_link3),
  .rf_invalid_address(rf_invalid_address_link3),
  .rf_access_complete(rf_access_complete_link3),
  .rf_read_en(rf_read_en_link3),
  .rf_write_en(rf_write_en_link3),
  .rf_write_data(rf_write_data_link3),
  //----------------------------------
  //----Connect AXI Ports
  //----------------------------------
  //From AXI to HMC Ctrl TX
  .s_axis_tx_TVALID(s_axis_tx_TVALID_link3),
  .s_axis_tx_TREADY(s_axis_tx_TREADY_link3),
  .s_axis_tx_TDATA(s_axis_tx_TDATA_link3),
  .s_axis_tx_TUSER(s_axis_tx_TUSER_link3),
  //From HMC Ctrl RX to AXI
  .m_axis_rx_TVALID(m_axis_rx_TVALID_link3),
  .m_axis_rx_TREADY(m_axis_rx_TREADY_link3),
  .m_axis_rx_TDATA(m_axis_rx_TDATA_link3),
  .m_axis_rx_TUSER(m_axis_rx_TUSER_link3),
  //----------------------------------
  //----Connect HMC
  //----------------------------------
  .P_RST_N(),
  .FERR_N(), //Not connected
  .OPEN_HMC_INIT_DONE(open_hmc_done_link3),
  .HMC_IIC_INIT_DONE(hmc_iic_init_done),
  .RX_CRC_ERR_CNT(rx_crc_err_cnt_link3)
);

// FLIT generator and checker for HMC LINK2 POST
flit_gen #(
  .LINK(0),
   //Define width of the datapath
  .LOG_FPW(LOG_FPW),        //Legal Values: 1,2,3
  .FPW(FPW),        //Legal Values: 2,4,6,8
  .DWIDTH(DWIDTH),  //Leave untouched
  //Define HMC interface width
  .LOG_NUM_LANES(LOG_NUM_LANES),                //Set 3 for half-width, 4 for full-width
  .NUM_LANES(NUM_LANES), //Leave untouched
  .NUM_DATA_BYTES(NUM_DATA_BYTES)           //Leave untouched
  ) 
flit_gen_link2_inst (
  .CLK(USER_CLK),
  .RST(soft_reset_link2),
  .OPEN_HMC_INIT_DONE(open_hmc_done_link2),
  .DATA_RX_FLIT_CNT(data_rx_flit_cnt_link2),
  .DATA_RX_ERR_FLIT_CNT(data_rx_err_flit_cnt_link2),
  .DATA_ERR_DETECT(data_err_detect_link2),
  .POST_DONE_IN(post_done_latch),
  .POST_DONE_OUT(post_done_link2),
  //----------------------------------
  //----Connect AXI Ports
  //----------------------------------
  //From AXI to HMC Ctrl TX
  .s_axis_tx_TVALID(post_flit_s_axis_tx_TVALID_link2),
  .s_axis_tx_TREADY(post_flit_s_axis_tx_TREADY_link2),
  .s_axis_tx_TDATA(post_flit_s_axis_tx_TDATA_link2),
  .s_axis_tx_TUSER(post_flit_s_axis_tx_TUSER_link2),
  //From HMC Ctrl RX to AXI
  .m_axis_rx_TVALID(post_flit_m_axis_rx_TVALID_link2),
  .m_axis_rx_TREADY(post_flit_m_axis_rx_TREADY_link2),
  .m_axis_rx_TDATA(post_flit_m_axis_rx_TDATA_link2),
  .m_axis_rx_TUSER(post_flit_m_axis_rx_TUSER_link2)
);

// FLIT generator and checker for HMC LINK3 POST
flit_gen #(
  .LINK(1),
   //Define width of the datapath
  .LOG_FPW(LOG_FPW),        //Legal Values: 1,2,3
  .FPW(FPW),        //Legal Values: 2,4,6,8
  .DWIDTH(DWIDTH),  //Leave untouched
  //Define HMC interface width
  .LOG_NUM_LANES(LOG_NUM_LANES),                //Set 3 for half-width, 4 for full-width
  .NUM_LANES(NUM_LANES), //Leave untouched
  .NUM_DATA_BYTES(NUM_DATA_BYTES)           //Leave untouched
  ) 
flit_gen_link3_inst (
  .CLK(USER_CLK),
  .RST(soft_reset_link3),
  .OPEN_HMC_INIT_DONE(open_hmc_done_link3),
  .DATA_RX_FLIT_CNT(data_rx_flit_cnt_link3),
  .DATA_RX_ERR_FLIT_CNT(data_rx_err_flit_cnt_link3),
  .DATA_ERR_DETECT(data_err_detect_link3),
  .POST_DONE_IN(post_done_latch),
  .POST_DONE_OUT(post_done_link3),
  //----------------------------------
  //----Connect AXI Ports
  //----------------------------------
  //From AXI to HMC Ctrl TX
  .s_axis_tx_TVALID(post_flit_s_axis_tx_TVALID_link3),
  .s_axis_tx_TREADY(post_flit_s_axis_tx_TREADY_link3),
  .s_axis_tx_TDATA(post_flit_s_axis_tx_TDATA_link3),
  .s_axis_tx_TUSER(post_flit_s_axis_tx_TUSER_link3),
  //From HMC Ctrl RX to AXI
  .m_axis_rx_TVALID(post_flit_m_axis_rx_TVALID_link3),
  .m_axis_rx_TREADY(post_flit_m_axis_rx_TREADY_link3),
  .m_axis_rx_TDATA(post_flit_m_axis_rx_TDATA_link3),
  .m_axis_rx_TUSER(post_flit_m_axis_rx_TUSER_link3)
);
 

// FLIT generator and checker for HMC LINK2 POST
flit_gen_user #(
   //Define width of the datapath
  .LOG_FPW(LOG_FPW),        //Legal Values: 1,2,3
  .FPW(FPW),        //Legal Values: 2,4,6,8
  .DWIDTH(DWIDTH),  //Leave untouched
  //Define HMC interface width
  .LOG_NUM_LANES(LOG_NUM_LANES),                //Set 3 for half-width, 4 for full-width
  .NUM_LANES(NUM_LANES), //Leave untouched
  .NUM_DATA_BYTES(NUM_DATA_BYTES)           //Leave untouched
  ) 
flit_gen_user_link2_inst (
  .CLK(USER_CLK),
  .RST(soft_reset),
  .POST_DONE(post_done_link2),
  //----------------------------------
  //----Connect AXI Ports
  //----------------------------------
  //From AXI to HMC Ctrl TX
  .s_axis_tx_TVALID(user_flit_s_axis_tx_TVALID_link2),
  .s_axis_tx_TREADY(user_flit_s_axis_tx_TREADY_link2),
  .s_axis_tx_TDATA(user_flit_s_axis_tx_TDATA_link2),
  .s_axis_tx_TUSER(user_flit_s_axis_tx_TUSER_link2),
  //From HMC Ctrl RX to AXI
  .m_axis_rx_TVALID(user_flit_m_axis_rx_TVALID_link2),
  .m_axis_rx_TREADY(user_flit_m_axis_rx_TREADY_link2),
  .m_axis_rx_TDATA(user_flit_m_axis_rx_TDATA_link2),
  .m_axis_rx_TUSER(user_flit_m_axis_rx_TUSER_link2),

  // write interface
  .WR_ADDRESS(WR_ADDRESS),
  .DATA_IN(DATA_IN),
  .WR_REQ(WR_REQ),
  .WR_READY(WR_READY),

  // read interface
  .RD_ADDRESS(27'd0),
  .RD_REQ(1'b0), 
  .DATA_OUT(),    
  .TAG_IN(9'd0),
  .TAG_OUT(),
  .DATA_VALID(),
  .RD_READY()
);

// FLIT generator and checker for HMC LINK3 POST
flit_gen_user #(
   //Define width of the datapath
  .LOG_FPW(LOG_FPW),        //Legal Values: 1,2,3
  .FPW(FPW),        //Legal Values: 2,4,6,8
  .DWIDTH(DWIDTH),  //Leave untouched
  //Define HMC interface width
  .LOG_NUM_LANES(LOG_NUM_LANES),                //Set 3 for half-width, 4 for full-width
  .NUM_LANES(NUM_LANES), //Leave untouched
  .NUM_DATA_BYTES(NUM_DATA_BYTES)           //Leave untouched
  ) 
flit_gen_user_link3_inst (
  .CLK(USER_CLK),
  .RST(soft_reset),
  .POST_DONE(post_done_link3),
  //----------------------------------
  //----Connect AXI Ports
  //----------------------------------
  //From AXI to HMC Ctrl TX
  .s_axis_tx_TVALID(user_flit_s_axis_tx_TVALID_link3),
  .s_axis_tx_TREADY(user_flit_s_axis_tx_TREADY_link3),
  .s_axis_tx_TDATA(user_flit_s_axis_tx_TDATA_link3),
  .s_axis_tx_TUSER(user_flit_s_axis_tx_TUSER_link3),
  //From HMC Ctrl RX to AXI
  .m_axis_rx_TVALID(user_flit_m_axis_rx_TVALID_link3),
  .m_axis_rx_TREADY(user_flit_m_axis_rx_TREADY_link3),
  .m_axis_rx_TDATA(user_flit_m_axis_rx_TDATA_link3),
  .m_axis_rx_TUSER(user_flit_m_axis_rx_TUSER_link3),

    // write interface
  .WR_ADDRESS(27'd0),
  .DATA_IN(256'd0),
  .WR_REQ(1'b0),
  .WR_READY(),

  // read interface
  .RD_ADDRESS(RD_ADDRESS),
  .RD_REQ(RD_REQ), 
  .DATA_OUT(DATA_OUT),
  .TAG_IN(TAG_IN),   
  .TAG_OUT(TAG_OUT),
  .DATA_VALID(DATA_VALID),
  .RD_READY(RD_READY)
);

// AXI Mux between POST & User FLIT Generation

// Link 2 MUX
assign s_axis_tx_TVALID_link2 = (post_done_link2 == 1'b0) ? post_flit_s_axis_tx_TVALID_link2 : user_flit_s_axis_tx_TVALID_link2;
assign s_axis_tx_TDATA_link2  = (post_done_link2 == 1'b0) ? post_flit_s_axis_tx_TDATA_link2 : user_flit_s_axis_tx_TDATA_link2;
assign s_axis_tx_TUSER_link2  = (post_done_link2 == 1'b0) ? post_flit_s_axis_tx_TUSER_link2 : user_flit_s_axis_tx_TUSER_link2;
assign post_flit_s_axis_tx_TREADY_link2 = s_axis_tx_TREADY_link2;
assign user_flit_s_axis_tx_TREADY_link2 = s_axis_tx_TREADY_link2;

assign post_flit_m_axis_rx_TVALID_link2 = m_axis_rx_TVALID_link2;
assign user_flit_m_axis_rx_TVALID_link2 = m_axis_rx_TVALID_link2;
assign post_flit_m_axis_rx_TDATA_link2  = m_axis_rx_TDATA_link2;
assign user_flit_m_axis_rx_TDATA_link2  = m_axis_rx_TDATA_link2;
assign post_flit_m_axis_rx_TUSER_link2  = m_axis_rx_TUSER_link2;
assign user_flit_m_axis_rx_TUSER_link2  = m_axis_rx_TUSER_link2;
assign m_axis_rx_TREADY_link2 = (post_done_link2 == 1'b0) ? post_flit_m_axis_rx_TREADY_link2 : user_flit_m_axis_rx_TREADY_link2;

// Link 3 MUX
assign s_axis_tx_TVALID_link3 = (post_done_link3 == 1'b0) ? post_flit_s_axis_tx_TVALID_link3 : user_flit_s_axis_tx_TVALID_link3;
assign s_axis_tx_TDATA_link3  = (post_done_link3 == 1'b0) ? post_flit_s_axis_tx_TDATA_link3 : user_flit_s_axis_tx_TDATA_link3;
assign s_axis_tx_TUSER_link3  = (post_done_link3 == 1'b0) ? post_flit_s_axis_tx_TUSER_link3 : user_flit_s_axis_tx_TUSER_link3;
assign post_flit_s_axis_tx_TREADY_link3 = s_axis_tx_TREADY_link3;
assign user_flit_s_axis_tx_TREADY_link3 = s_axis_tx_TREADY_link3;

assign post_flit_m_axis_rx_TVALID_link3 = m_axis_rx_TVALID_link3;
assign user_flit_m_axis_rx_TVALID_link3 = m_axis_rx_TVALID_link3;
assign post_flit_m_axis_rx_TDATA_link3  = m_axis_rx_TDATA_link3;
assign user_flit_m_axis_rx_TDATA_link3  = m_axis_rx_TDATA_link3;
assign post_flit_m_axis_rx_TUSER_link3  = m_axis_rx_TUSER_link3;
assign user_flit_m_axis_rx_TUSER_link3  = m_axis_rx_TUSER_link3;
assign m_axis_rx_TREADY_link3 = (post_done_link3 == 1'b0) ? post_flit_m_axis_rx_TREADY_link3 : user_flit_m_axis_rx_TREADY_link3;


endmodule

`default_nettype wire

