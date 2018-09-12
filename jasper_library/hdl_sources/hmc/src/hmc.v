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
    parameter FPW                   = 4,        //Legal Values: 2,4,6,8
    parameter LOG_FPW               = 2,        //Legal Values: 1 for FPW=2 ,2 for FPW=4 ,3 for FPW=6/8
    parameter DWIDTH                = FPW*128,  //Leave untouched
    //Define HMC interface width
    parameter LOG_NUM_LANES         = 3,                //Set 3 for half-width, 4 for full-width
    parameter NUM_LANES             = 2**LOG_NUM_LANES, //Leave untouched
    parameter NUM_DATA_BYTES        = FPW*16,           //Leave untouched
    //Define width of the register file
    parameter HMC_RF_WWIDTH         = 64,   //Leave untouched    
    parameter HMC_RF_RWIDTH         = 64,   //Leave untouched
    parameter HMC_RF_AWIDTH         = 5,    //Leave untouched
    //Configure the Functionality
    parameter LOG_MAX_RX_TOKENS     = 8,    //Set the depth of the RX input buffer. Must be >= LOG(rf_rx_buffer_rtc) in the RF. Dont't care if OPEN_RSP_MODE=1
    parameter LOG_MAX_HMC_TOKENS    = 10,   //Set the depth of the HMC input buffer. Must be >= LOG of the corresponding field in the HMC internal register
    parameter HMC_RX_AC_COUPLED     = 1,    //Set to 0 to bypass the run length limiter, saves logic and 1 cycle delay
    parameter DETECT_LANE_POLARITY  = 1,    //Set to 0 if lane polarity is not applicable, saves logic
    parameter CTRL_LANE_POLARITY    = 1,    //Set to 0 if lane polarity is not applicable or performed by the transceivers, saves logic and 1 cycle delay
                                            //If set to 1: Only valid if DETECT_LANE_POLARITY==1, otherwise tied to zero
    parameter CTRL_LANE_REVERSAL    = 0,    //Set to 0 if lane reversal is not applicable or performed by the transceivers, saves logic
    parameter CTRL_SCRAMBLERS       = 0,    //Set to 0 to remove the option to disable (de-)scramblers for debugging, saves logic
    parameter OPEN_RSP_MODE         = 0,    //Set to 1 if running response open loop mode, bypasses the RX input buffer
    parameter RX_RELAX_INIT_TIMING  = 0,    //Per default, incoming TS1 sequences are only checked for the lane independent h'F0 sequence. Save resources and
                                            //eases timing closure. !Lane reversal is still detected
    parameter RX_BIT_SLIP_CNT_LOG   = 5,    //Define the number of cycles between bit slips. Refer to the transceiver user guide
                                            //Example: RX_BIT_SLIP_CNT_LOG=5 results in 2^5=32 cycles between two bit slips
    parameter SYNC_AXI4_IF          = 0,    //Set to 1 if AXI IF is synchronous to clk_hmc to use simple fifos
    parameter XIL_CNT_PIPELINED     = 1,    //If Xilinx counters are used, set to 1 to enabled output register pipelining
    //Set the direction of bitslip. Set to 1 if bitslip performs a shift right, otherwise set to 0 (see the corresponding transceiver user guide)
    parameter BITSLIP_SHIFT_RIGHT   = 1,//1,    
    //Debug Params
    parameter DBG_RX_TOKEN_MON      = 1,     //Set to 0 to remove the RX Link token monitor, saves logic
            
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

    //Simulink Ports 
    //Link2
    input  wire [255:0] DATA_IN_LINK2,
    output wire [255:0] DATA_OUT_LINK2,
    input  wire RD_REQ_LINK2,
    input  wire WR_REQ_LINK2,
    input  wire [26:0] WR_ADDRESS_LINK2,
    input  wire [26:0] RD_ADDRESS_LINK2,
    input  wire [8:0] TAG_IN_LINK2,
    output wire [8:0] TAG_OUT_LINK2,
    output wire DATA_VALID_LINK2,
    output wire RD_READY_LINK2,
    output wire WR_READY_LINK2,
    output wire [15:0] RX_CRC_ERR_CNT_LINK2,
    output wire [6:0] ERRSTAT_LINK2,
    //output wire QPLL_LOCK_ERR_LINK2,
    //output wire [7:0] FIFO_TX_FLAG_STATUS_LINK2,    
    //output wire [7:0] FIFO_RX_FLAG_STATUS_LINK2,    
    
    //Link3
    input  wire [255:0] DATA_IN_LINK3,
    output wire [255:0] DATA_OUT_LINK3,
    input  wire RD_REQ_LINK3,
    input  wire WR_REQ_LINK3,
    input  wire [26:0] WR_ADDRESS_LINK3,
    input  wire [26:0] RD_ADDRESS_LINK3,
    input  wire [8:0] TAG_IN_LINK3,
    output wire [8:0] TAG_OUT_LINK3,
    output wire DATA_VALID_LINK3,
    output wire RD_READY_LINK3,
    output wire WR_READY_LINK3,
    output wire [15:0] RX_CRC_ERR_CNT_LINK3,
    output wire [6:0] ERRSTAT_LINK3,
    //output wire QPLL_LOCK_ERR_LINK3,
    //output wire [7:0] FIFO_TX_FLAG_STATUS_LINK3,    
    //output wire [7:0] FIFO_RX_FLAG_STATUS_LINK3,    
    
    //Simulink Ports Clocks and Status
    input  wire USER_CLK,
    input  wire USER_RST,
    output wire POST_OK,    
    output wire INIT_DONE,
    output wire [2:0] MEZZ_ID,
    output wire MEZZ_PRESENT,
    //System Clocks
    input wire HMC_CLK,
    input wire HMC_RST
    
    
);

//(* mark_debug = "true" *)
(* mark_debug = "true" *) wire soft_reset_link2,soft_reset_link3;
(* mark_debug = "true" *) reg [31:0] time_out_cnt;
(* mark_debug = "true" *) reg time_out_cnt_rst;
(* mark_debug = "true" *) wire soft_reset;

(* mark_debug = "true" *) wire [15:0] dbg_RX_CRC_ERR_CNT_LINK3;
(* mark_debug = "true" *) wire [15:0] dbg_RX_CRC_ERR_CNT_LINK2;
(* mark_debug = "true" *) wire [6:0] dbg_ERRSTAT_LINK3;
(* mark_debug = "true" *) wire [6:0] dbg_ERRSTAT_LINK2;
(* mark_debug = "true" *) wire dbg_QPLL_LOCK_ERR_LINK2;
(* mark_debug = "true" *) wire dbg_QPLL_LOCK_ERR_LINK3;
(* mark_debug = "true" *) wire [7:0] dbg_FIFO_TX_FLAG_STATUS_LINK2;
(* mark_debug = "true" *) wire [7:0] dbg_FIFO_RX_FLAG_STATUS_LINK2;
(* mark_debug = "true" *) wire [7:0] dbg_FIFO_TX_FLAG_STATUS_LINK3;
(* mark_debug = "true" *) wire [7:0] dbg_FIFO_RX_FLAG_STATUS_LINK3;

assign dbg_RX_CRC_ERR_CNT_LINK3 = RX_CRC_ERR_CNT_LINK3;
assign dbg_RX_CRC_ERR_CNT_LINK2 = RX_CRC_ERR_CNT_LINK2;
assign dbg_ERRSTAT_LINK3 = ERRSTAT_LINK3;
assign dbg_ERRSTAT_LINK2 = ERRSTAT_LINK2;
assign dbg_QPLL_LOCK_ERR_LINK2 = QPLL_LOCK_ERR_LINK2;
assign dbg_QPLL_LOCK_ERR_LINK3 = QPLL_LOCK_ERR_LINK3;
assign dbg_FIFO_TX_FLAG_STATUS_LINK2 = FIFO_TX_FLAG_STATUS_LINK2;
assign dbg_FIFO_RX_FLAG_STATUS_LINK2 = FIFO_RX_FLAG_STATUS_LINK2;
assign dbg_FIFO_TX_FLAG_STATUS_LINK3 = FIFO_TX_FLAG_STATUS_LINK3;
assign dbg_FIFO_RX_FLAG_STATUS_LINK3 = FIFO_RX_FLAG_STATUS_LINK3;


//Assign HMC ID = 010 (uBlaze needs to know this is an HMC card)
assign MEZZ_ID = {1'b0, 1'b1, 1'b0};
//Assign MEZZ_PRESENT = 1'b1 (if Mezzanine is present then this will be high always)
assign MEZZ_PRESENT = 1'b1;

//AI: Monitor the QPLL lock Status
assign QPLL_LOCK_ERR_LINK2 = ~qpll_lock_link2RRRR;
assign QPLL_LOCK_ERR_LINK3 = ~qpll_lock_link3RRRR;

wire soft_reset_link2_async,soft_reset_link3_async;
wire soft_reset_async,user_rst;

//assign soft_reset_link2_async = (qpll_lock_link2 == 1'b0 || USER_RST == 1'b1 || time_out_cnt_rst == 1'b1);
//assign soft_reset_link3_async = (qpll_lock_link3 == 1'b0 || USER_RST == 1'b1 || time_out_cnt_rst == 1'b1);
//AI: debug. Reset HMC and OpenHMC when HMC does not reconfigure the first time
assign soft_reset_link2_async = (qpll_lock_link2 == 1'b0 || USER_RST == 1'b1 || time_out_cnt_rst == 1'b1);
assign soft_reset_link3_async = (qpll_lock_link3 == 1'b0 || USER_RST == 1'b1 || time_out_cnt_rst == 1'b1);


assign soft_reset_async = (soft_reset_link2_async == 1'b1 || soft_reset_link3_async == 1'b1);

// USER_CLK domain sync's
(* ASYNC_REG = "true" *)(* DONT_TOUCH = "true" *) reg soft_reset_link2R,soft_reset_link2RR,soft_reset_link2RRR,soft_reset_link2RRRR;
(* ASYNC_REG = "true" *)(* DONT_TOUCH = "true" *) reg soft_reset_link3R,soft_reset_link3RR,soft_reset_link3RRR,soft_reset_link3RRRR;
(* ASYNC_REG = "true" *)(* DONT_TOUCH = "true" *) reg user_rstR,user_rstRR,user_rstRRR,user_rstRRRR;
(* ASYNC_REG = "true" *)(* DONT_TOUCH = "true" *) reg qpll_lock_link2R,qpll_lock_link2RR,qpll_lock_link2RRR,qpll_lock_link2RRRR;
(* ASYNC_REG = "true" *)(* DONT_TOUCH = "true" *) reg qpll_lock_link3R,qpll_lock_link3RR,qpll_lock_link3RRR,qpll_lock_link3RRRR;

wire open_hmc_done_link2_i,open_hmc_done_link3_i;
(* ASYNC_REG = "true" *)(* DONT_TOUCH = "true" *) reg open_hmc_done_link2R,open_hmc_done_link2RR,open_hmc_done_link2RRR,open_hmc_done_link2RRRR;
(* ASYNC_REG = "true" *)(* DONT_TOUCH = "true" *) reg open_hmc_done_link3R,open_hmc_done_link3RR,open_hmc_done_link3RRR,open_hmc_done_link3RRRR;
(* ASYNC_REG = "true" *)(* DONT_TOUCH = "true" *) reg soft_resetR,soft_resetRR,soft_resetRRR,soft_resetRRRR;

//HMC_CLK domain sync's
(* ASYNC_REG = "true" *)(* DONT_TOUCH = "true" *) reg open_hmc_done_link2Rb,open_hmc_done_link2RRb,open_hmc_done_link2RRRb,open_hmc_done_link2RRRRb;
(* ASYNC_REG = "true" *)(* DONT_TOUCH = "true" *) reg open_hmc_done_link3Rb,open_hmc_done_link3RRb,open_hmc_done_link3RRRb,open_hmc_done_link3RRRRb;

always @(posedge USER_CLK) begin 
   
  user_rstR <= USER_RST;
  user_rstRR <= user_rstR;
  user_rstRRR <= user_rstRR;
  user_rstRRRR <= user_rstRRR;

  soft_resetR    <= soft_reset_async;
  soft_resetRR   <= soft_resetR;
  soft_resetRRR  <= soft_resetRR;
  soft_resetRRRR <= soft_resetRRR;
  
  soft_reset_link2R    <= soft_reset_link2_async;
  soft_reset_link2RR   <= soft_reset_link2R;
  soft_reset_link2RRR  <= soft_reset_link2RR;
  soft_reset_link2RRRR <= soft_reset_link2RRR;

  soft_reset_link3R    <= soft_reset_link3_async;
  soft_reset_link3RR   <= soft_reset_link3R;
  soft_reset_link3RRR  <= soft_reset_link3RR;
  soft_reset_link3RRRR <= soft_reset_link3RRR;

  open_hmc_done_link2R    <= open_hmc_done_link2_i;
  open_hmc_done_link2RR   <= open_hmc_done_link2R;
  open_hmc_done_link2RRR  <= open_hmc_done_link2RR;
  open_hmc_done_link2RRRR <= open_hmc_done_link2RRR;

  open_hmc_done_link3R    <= open_hmc_done_link3_i;
  open_hmc_done_link3RR   <= open_hmc_done_link3R;
  open_hmc_done_link3RRR  <= open_hmc_done_link3RR;
  open_hmc_done_link3RRRR <= open_hmc_done_link3RRR;

  post_ok_latchR <= post_ok_latch;
  post_ok_latchRR <= post_ok_latchR;
  post_ok_latchRRR <= post_ok_latchRR;
  post_ok_latchRRRR <= post_ok_latchRRR;
  
  init_done_latchR <= init_done_latch;
  init_done_latchRR <= init_done_latchR;
  init_done_latchRRR <= init_done_latchRR;
  init_done_latchRRRR <= init_done_latchRRR;
  
  qpll_lock_link2R <= qpll_lock_link2;
  qpll_lock_link2RR <= qpll_lock_link2R;
  qpll_lock_link2RRR <= qpll_lock_link2RR;
  qpll_lock_link2RRRR <= qpll_lock_link2RRR;

  qpll_lock_link3R <= qpll_lock_link3;
  qpll_lock_link3RR <= qpll_lock_link3R;
  qpll_lock_link3RRR <= qpll_lock_link3RR;
  qpll_lock_link3RRRR <= qpll_lock_link3RRR;

  
end


always @(posedge HMC_CLK) begin 
   
  open_hmc_done_link2Rb    <= open_hmc_done_link2_i;
  open_hmc_done_link2RRb   <= open_hmc_done_link2Rb;
  open_hmc_done_link2RRRb  <= open_hmc_done_link2RRb;
  open_hmc_done_link2RRRRb <= open_hmc_done_link2RRRb;

  open_hmc_done_link3Rb    <= open_hmc_done_link3_i;
  open_hmc_done_link3RRb   <= open_hmc_done_link3Rb;
  open_hmc_done_link3RRRb  <= open_hmc_done_link3RRb;
  open_hmc_done_link3RRRRb <= open_hmc_done_link3RRRb;

end




assign user_rst = user_rstRRRR;
assign soft_reset = soft_resetRRRR;
assign soft_reset_link2 = soft_reset_link2RRRR;
assign soft_reset_link3 = soft_reset_link3RRRR;

assign open_hmc_done_link3 = open_hmc_done_link3RRRR;
assign open_hmc_done_link2 = open_hmc_done_link2RRRR;

assign open_hmc_done_link3b = open_hmc_done_link3RRRRb;
assign open_hmc_done_link2b = open_hmc_done_link2RRRRb;


assign MEZZ_CLK_SEL = 1'b0;
//assign HMC_MEZZ_RESET = user_rst;//~P_RST_N;
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

(* mark_debug = "true" *) wire open_hmc_done_link2,open_hmc_done_link3, open_hmc_done_link2b,open_hmc_done_link3b;
(* mark_debug = "true" *) wire [63:0] data_rx_flit_cnt_link2,data_rx_flit_cnt_link3;
(* mark_debug = "true" *) wire [63:0] data_rx_err_flit_cnt_link2,data_rx_err_flit_cnt_link3;
wire data_err_detect_link2,data_err_detect_link3;
wire [15:0] rx_crc_err_cnt_link2a,rx_crc_err_cnt_link3a;
reg [15:0] rx_crc_err_cnt_link2aR, rx_crc_err_cnt_link2aRR, rx_crc_err_cnt_link2aRRR, rx_crc_err_cnt_link2aRRRR; 
reg [15:0] rx_crc_err_cnt_link3aR, rx_crc_err_cnt_link3aRR, rx_crc_err_cnt_link3aRRR, rx_crc_err_cnt_link3aRRRR; 

assign RX_CRC_ERR_CNT_LINK2 = rx_crc_err_cnt_link2aRRRR;
assign RX_CRC_ERR_CNT_LINK3 = rx_crc_err_cnt_link3aRRRR;

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
wire post_done_i = ((data_rx_flit_cnt_link2[25] == 1'b1) && (data_rx_flit_cnt_link3[25] == 1'b1));
//wire post_done_i = data_rx_flit_cnt_link2[25];
reg post_done_reg;
wire post_ok_i = ((data_rx_err_flit_cnt_link3 == 64'd0) && (data_rx_err_flit_cnt_link2 == 64'd0) && (data_rx_flit_cnt_link2[25] == 1'b1) && (data_rx_flit_cnt_link3[25] == 1'b1));
//wire post_ok_i = ((data_rx_err_flit_cnt_link2 == 64'd0) && (data_rx_flit_cnt_link2[25] == 1'b1));

(* ASYNC_REG = "true" *)(* DONT_TOUCH = "true" *) reg post_okR,post_okRR,post_okRRR,post_okRRRR;
reg post_ok_latch;
reg init_done_latch;
reg [15:0] reset_cnt;
reg [31:0] num_reset_cnt;
reg issue_retry_rst;
reg mmcm_reset;
reg [15:0] mmcm_reset_cnt;
reg mmcm_reset_cnt_en;
reg qpll_reset;
reg [15:0] qpll_reset_cnt;
reg qpll_reset_cnt_en;

(* ASYNC_REG = "true" *)(* DONT_TOUCH = "true" *) reg post_ok_latchR,post_ok_latchRR,post_ok_latchRRR,post_ok_latchRRRR;
(* ASYNC_REG = "true" *)(* DONT_TOUCH = "true" *) reg init_done_latchR,init_done_latchRR,init_done_latchRRR,init_done_latchRRRR;


(* mark_debug = "true" *) wire [15:0] dbg_reset_cnt;
(* mark_debug = "true" *) wire [31:0] dbg_num_reset_cnt;
(* mark_debug = "true" *) wire dbg_hmc_resetRRRR;
(* mark_debug = "true" *) wire dbg_hmc_reset_i;
(* mark_debug = "true" *) wire dbg_mmcm_reset;
(* mark_debug = "true" *) wire [15:0] dbg_mmcm_reset_cnt;
(* mark_debug = "true" *) wire dbg_mmcm_reset_cnt_en;
(* mark_debug = "true" *) wire dbg_qpll_reset;
(* mark_debug = "true" *) wire [15:0] dbg_qpll_reset_cnt;
(* mark_debug = "true" *) wire dbg_qpll_reset_cnt_en;


assign dbg_reset_cnt = reset_cnt;
assign dbg_num_reset_cnt = num_reset_cnt;
assign dbg_hmc_resetRRRR = hmc_resetRRRR;
assign dbg_hmc_reset_i = hmc_reset_i;
assign dbg_mmcm_reset = mmcm_reset;
assign dbg_mmcm_reset_cnt = mmcm_reset_cnt;
assign dbg_mmcm_reset_cnt_en = mmcm_reset_cnt_en;
assign dbg_qpll_reset = qpll_reset;
assign dbg_qpll_reset_cnt = qpll_reset_cnt;
assign dbg_qpll_reset_cnt_en = qpll_reset_cnt_en;

wire hmc_reset_i;
(* ASYNC_REG = "true" *)(* DONT_TOUCH = "true" *) reg hmc_resetR,hmc_resetRR,hmc_resetRRR,hmc_resetRRRR;


//Process ensures initialisation is successful. If initialisation is not successful then reset is issued again.
//Linked to HMC_CLK and HMC_RST, so the time duration does not change when the USER_CLK changes.
always @(posedge HMC_CLK) begin 
  if (HMC_RST == 1'b1) begin
    post_ok_latch <= 1'b0;
    init_done_latch <= 1'b0;
    post_okR <= 1'b0;
    post_okRR <= 1'b0;
    post_okRRR <= 1'b0;
    post_okRRRR <= 1'b0;
    time_out_cnt <= 32'd0;
    time_out_cnt_rst <= 1'b0;
    reset_cnt <= 16'd0;
    issue_retry_rst <= 1'b0;
    num_reset_cnt <= 32'd0;
    mmcm_reset <= 1'b0;
    mmcm_reset_cnt <= 16'd0;
    mmcm_reset_cnt_en <= 1'b0;
    qpll_reset <= 1'b0;
    qpll_reset_cnt <= 16'd0;
    qpll_reset_cnt_en <= 1'b0;    
  end else begin
    post_okR    <= post_ok_i;
    post_okRR   <= post_okR;
    post_okRRR  <= post_okRR;
    post_okRRRR <= post_okRRR; 
    time_out_cnt <= time_out_cnt + 1'b1;
    
    
    //Issue a reset after every second until OpenHMC initialises
    //156.25MHz clock = 1.78s (needs to be greater than 1.2s, which is the time
    //for the initialisation procedure)
    if (time_out_cnt == 32'd278125000) begin      //time_out_cnt[27]
      time_out_cnt_rst <= 1'b1;      
    end     
    
    //Time out has been reached and init done is not complete, so start the reset process
    if (time_out_cnt_rst == 1'b1) begin
      reset_cnt <= reset_cnt + 1'b1;
    end 
    
    //Reset process is complete, so deassert reset and take note how many times this is executed
    //if (reset_cnt[15] == 1'b1) begin
    if (reset_cnt[4] == 1'b1) begin   
      reset_cnt <= 16'd0;
      time_out_cnt_rst <= 1'b0;
      num_reset_cnt <= num_reset_cnt + 1'b1;
      time_out_cnt <= 32'd0;  //reset time out count and try again
      mmcm_reset_cnt_en <= 1'b1; //Enable the MMCM reset counter
    end
    
    //Increment the MMCM reset counter
    if (mmcm_reset_cnt_en == 1'b1) begin
       mmcm_reset_cnt <= mmcm_reset_cnt + 1'b1;
    end    

    //MMCM Reset process is enabled (Disabled and not used)
    if (mmcm_reset_cnt >= 16'd250 && mmcm_reset_cnt <= 16'd255) begin   
      mmcm_reset <= 1'b0; //1'b1;Disabled for now
    end
    
    //MMCM Reset process is disabled
    if (mmcm_reset_cnt >= 16'd256) begin   
      mmcm_reset_cnt <= 16'd0;
      mmcm_reset <= 1'b0;
      mmcm_reset_cnt_en <= 1'b0;
      qpll_reset_cnt_en <= 1'b1; //Enable the QPLL reset counter
    end 
    
    //Increment the QPLL reset counter
    if (qpll_reset_cnt_en == 1'b1) begin
       qpll_reset_cnt <= qpll_reset_cnt + 1'b1;
    end    

    //QPLL Reset process is enabled (Disabled and not used)
    if (qpll_reset_cnt >= 16'd250 && qpll_reset_cnt <= 16'd255) begin   
      qpll_reset <= 1'b0;
    end
    
    //QPLL Reset process is disabled
    if (qpll_reset_cnt >= 16'd256) begin   
      qpll_reset_cnt <= 16'd0;
      qpll_reset <= 1'b0; //1'b1; Disabled for now
      qpll_reset_cnt_en <= 1'b0;
    end       

    //Post has been successful, so latch it through to the status output ports
    if ({post_okRRRR,post_okRRR} == 2'b01) begin
      post_ok_latch <= 1'b1;
    end
    
    //Do not increment timer when HMC is in reset
    if (hmc_resetRRRR == 1'b1) begin
      time_out_cnt <= 32'd0;
    end 
    
    //Once the OpenHMC and HMC has initialised then stop the reset process
    if (open_hmc_done_link2b == 1'b1 && open_hmc_done_link3b == 1'b1) begin
      init_done_latch <= 1'b1;
      time_out_cnt <= 32'd0;
    end 
  end
end


(* ASYNC_REG = "true" *)(* DONT_TOUCH = "true" *) reg soft_reset_syncR,soft_reset_syncRR,soft_reset_syncRRR,soft_reset_syncRRRR;
(* ASYNC_REG = "true" *)(* DONT_TOUCH = "true" *) reg hmc_iic_init_doneR,hmc_iic_init_doneRR,hmc_iic_init_doneRRR,hmc_iic_init_doneRRRR;
(* ASYNC_REG = "true" *)(* DONT_TOUCH = "true" *) reg SCL_INR,SCL_INRR,SCL_INRRR,SCL_INRRRR;
(* ASYNC_REG = "true" *)(* DONT_TOUCH = "true" *) reg SDA_INR,SDA_INRR,SDA_INRRR,SDA_INRRRR;
wire clk_hmc_out_link2,clk_hmc_out_link3,hmc_iic_init_done_i;



always @(posedge clk_hmc_out_link2) begin
  soft_reset_syncR <= soft_reset;
  soft_reset_syncRR <= soft_reset_syncR;
  soft_reset_syncRRR <= soft_reset_syncRR;
  soft_reset_syncRRRR <= soft_reset_syncRRR;
end

always @(posedge clk_hmc_out_link2) begin
  SCL_INR <= SCL_IN;
  SCL_INRR <= SCL_INR;
  SCL_INRRR <= SCL_INRR;
  SCL_INRRRR <= SCL_INRRR;
  
  SDA_INR <= SDA_IN;
  SDA_INRR <= SDA_INR;
  SDA_INRRR <= SDA_INRR;
  SDA_INRRRR <= SDA_INRRR;  
end

assign SCL_IN_sync = SCL_INRRRR;
assign SDA_IN_sync = SDA_INRRRR;

always @(posedge clk_hmc_out_link3) begin
  hmc_iic_init_doneR    <= hmc_iic_init_done_i;
  hmc_iic_init_doneRR   <= hmc_iic_init_doneR;
  hmc_iic_init_doneRRR  <= hmc_iic_init_doneRR;
  hmc_iic_init_doneRRRR <= hmc_iic_init_doneRRR;
end

assign soft_reset_sync = soft_reset_syncRRRR;

wire post_done_latch,post_done_latch_i,post_done;
(* ASYNC_REG = "true" *)(* DONT_TOUCH = "true" *) reg post_done_latchR,post_done_latchRR,post_done_latchRRR,post_done_latchRRRR;
(* ASYNC_REG = "true" *)(* DONT_TOUCH = "true" *) reg post_doneR,post_doneRR,post_doneRRR,post_doneRRRR;

wire [7:0] fifo_tx_flag_status_link2,fifo_rx_flag_status_link2;
reg [7:0] fifo_tx_flag_status_link2R, fifo_tx_flag_status_link2RR, fifo_tx_flag_status_link2RRR, fifo_tx_flag_status_link2RRRR; 
reg [7:0] fifo_rx_flag_status_link2R, fifo_rx_flag_status_link2RR, fifo_rx_flag_status_link2RRR, fifo_rx_flag_status_link2RRRR; 

assign FIFO_TX_FLAG_STATUS_LINK2 = fifo_tx_flag_status_link2RRRR;
assign FIFO_RX_FLAG_STATUS_LINK2 = fifo_rx_flag_status_link2RRRR;

wire [7:0] fifo_tx_flag_status_link3,fifo_rx_flag_status_link3;
reg [7:0] fifo_tx_flag_status_link3R, fifo_tx_flag_status_link3RR, fifo_tx_flag_status_link3RRR, fifo_tx_flag_status_link3RRRR; 
reg [7:0] fifo_rx_flag_status_link3R, fifo_rx_flag_status_link3RR, fifo_rx_flag_status_link3RRR, fifo_rx_flag_status_link3RRRR; 

assign FIFO_TX_FLAG_STATUS_LINK3 = fifo_tx_flag_status_link3RRRR;
assign FIFO_RX_FLAG_STATUS_LINK3 = fifo_rx_flag_status_link3RRRR;

always @(posedge USER_CLK) begin
  post_done_latchR    <= post_done_latch_i;
  post_done_latchRR   <= post_done_latchR;
  post_done_latchRRR  <= post_done_latchRR;
  post_done_latchRRRR <= post_done_latchRRR;

  rx_crc_err_cnt_link2aR <= rx_crc_err_cnt_link2a;    
  rx_crc_err_cnt_link2aRR <= rx_crc_err_cnt_link2aR;    
  rx_crc_err_cnt_link2aRRR <= rx_crc_err_cnt_link2aRR;    
  rx_crc_err_cnt_link2aRRRR <= rx_crc_err_cnt_link2aRRR;    

  rx_crc_err_cnt_link3aR <= rx_crc_err_cnt_link3a;    
  rx_crc_err_cnt_link3aRR <= rx_crc_err_cnt_link3aR;    
  rx_crc_err_cnt_link3aRRR <= rx_crc_err_cnt_link3aRR;    
  rx_crc_err_cnt_link3aRRRR <= rx_crc_err_cnt_link3aRRR; 
  
  fifo_tx_flag_status_link2R <= fifo_tx_flag_status_link2;   
  fifo_tx_flag_status_link2RR <= fifo_tx_flag_status_link2R;   
  fifo_tx_flag_status_link2RRR <= fifo_tx_flag_status_link2RR;   
  fifo_tx_flag_status_link2RRRR <= fifo_tx_flag_status_link2RRR;   

  fifo_tx_flag_status_link3R <= fifo_tx_flag_status_link3;   
  fifo_tx_flag_status_link3RR <= fifo_tx_flag_status_link3R;   
  fifo_tx_flag_status_link3RRR <= fifo_tx_flag_status_link3RR;   
  fifo_tx_flag_status_link3RRRR <= fifo_tx_flag_status_link3RRR;   
  
  fifo_rx_flag_status_link2R <= fifo_rx_flag_status_link2;   
  fifo_rx_flag_status_link2RR <= fifo_rx_flag_status_link2R;   
  fifo_rx_flag_status_link2RRR <= fifo_rx_flag_status_link2RR;   
  fifo_rx_flag_status_link2RRRR <= fifo_rx_flag_status_link2RRR;   

  fifo_rx_flag_status_link3R <= fifo_rx_flag_status_link3;   
  fifo_rx_flag_status_link3RR <= fifo_rx_flag_status_link3R;   
  fifo_rx_flag_status_link3RRR <= fifo_rx_flag_status_link3RR;   
  fifo_rx_flag_status_link3RRRR <= fifo_rx_flag_status_link3RRR;  

  
  //hmc_resetR    <= hmc_reset_i;
  //hmc_resetRR   <= hmc_resetR;
  //hmc_resetRRR  <= hmc_resetRR;
  //hmc_resetRRRR <= hmc_resetRRR;
end

always @(posedge HMC_CLK) begin
  hmc_resetR    <= hmc_reset_i;
  hmc_resetRR   <= hmc_resetR;
  hmc_resetRRR  <= hmc_resetRR;
  hmc_resetRRRR <= hmc_resetRRR;
end

always @(posedge USER_CLK) begin
  post_done_reg <= post_done_i;
end

always @(posedge clk_hmc_out_link2) begin
  post_doneR    <= post_done_reg;
  post_doneRR   <= post_doneR;
  post_doneRRR  <= post_doneRR;
  post_doneRRRR <= post_doneRRR;
end

assign post_done_latch = post_done_latchRRRR;
assign post_done = post_doneRRRR;

wire tx_phy_reset_done, rx_phy_reset_done, tx_phy_reset_done_link2, tx_phy_reset_done_link3, rx_phy_reset_done_link2, rx_phy_reset_done_link3;
wire tx_phy_reset, rx_phy_reset;

assign tx_phy_reset_done = tx_phy_reset_done_link2 & tx_phy_reset_done_link3;
assign rx_phy_reset_done = rx_phy_reset_done_link2 & rx_phy_reset_done_link3;


hmc_iic_init 
hmc_iic_init_inst (
  .CLK         (clk_hmc_out_link2),
  .RST         (soft_reset_sync),//(user_rst),// As soon as the clock is stable 
  .IIC_ACK_ERR (iic_err),
  .IIC_BUSY    (iic_busy),
  .HMC_IIC_INIT_DONE (hmc_iic_init_done_i),
  .HMC_POST_DONE (post_done),
  .POST_DONE_LATCH(post_done_latch_i),
  .HMC_RESET   (hmc_reset_i),
  .TX_PHY_RESET_DONE(tx_phy_reset_done), // Flag to indicate when the GTH TX PHY is ready
  .RX_PHY_RESET_DONE(rx_phy_reset_done), // Flag to indicate when the GTH RX PHY is ready
  .TX_PHY_RESET(tx_phy_reset), // Flag to reset the GTH TX PHY    
  .RX_PHY_RESET(rx_phy_reset), //Flag to reset the GTH RX PHY   
//  .SDA         (SDA),
//  .SCL         (SCL) 
  .SDA_OUT(SDA_OUT),
  .SCL_OUT(SCL_OUT),
  .SCL_IN(SCL_IN_sync),
  .SDA_IN(SDA_IN_sync)  
);

assign POST_OK = post_ok_latchRRRR;
//Important to AND init_done and the post_done_latch to ensure the I2C switch over happens after POST_DONE_LATCH is asserted. If not then POST_LED on HMC Card will not be illuminated when POST is done
//and there will be no visual indication to the user that the HMC is ready for use 
assign INIT_DONE = init_done_latchRRRR & post_done_latchRRRR; //post_done_latch
assign HMC_MEZZ_RESET = hmc_resetRRRR;//~P_RST_N; 

// Instantiate core for HMC link2
hmc_ska_sa_top #(
  //Define width of the datapath
  .FPW(FPW),                //Legal Values: 2,4,6,8
  .LOG_FPW(LOG_FPW),        //Legal Values: 1 for FPW=2 ,2 for FPW=4 ,3 for FPW=6/8
  .DWIDTH(DWIDTH),          //Leave untouched
  //Define HMC interface width
  .LOG_NUM_LANES(LOG_NUM_LANES),     //Set 3 for half-width, 4 for full-width
  .NUM_LANES(NUM_LANES),             //Leave untouched
  .NUM_DATA_BYTES(NUM_DATA_BYTES),   //Leave untouched
  //Define width of the register file
  .HMC_RF_WWIDTH(HMC_RF_WWIDTH),    //Leave untouched    
  .HMC_RF_RWIDTH(HMC_RF_RWIDTH),    //Leave untouched
  .HMC_RF_AWIDTH(HMC_RF_AWIDTH),    //Leave untouched
  //Configure the Functionality
  .LOG_MAX_RX_TOKENS(LOG_MAX_RX_TOKENS),    //Set the depth of the RX input buffer. Must be >= LOG(rf_rx_buffer_rtc) in the RF. Dont't care if OPEN_RSP_MODE=1
  .LOG_MAX_HMC_TOKENS(LOG_MAX_HMC_TOKENS),  //Set the depth of the HMC input buffer. Must be >= LOG of the corresponding field in the HMC internal register
  .HMC_RX_AC_COUPLED(HMC_RX_AC_COUPLED),    //Set to 0 to bypass the run length limiter, saves logic and 1 cycle delay
  .DETECT_LANE_POLARITY(DETECT_LANE_POLARITY),    //Set to 0 if lane polarity is not applicable, saves logic
  .CTRL_LANE_POLARITY(CTRL_LANE_POLARITY),        //Set to 0 if lane polarity is not applicable or performed by the transceivers, saves logic and 1 cycle delay
                                                  //If set to 1: Only valid if DETECT_LANE_POLARITY==1, otherwise tied to zero
  .CTRL_LANE_REVERSAL(CTRL_LANE_REVERSAL),  //Set to 0 if lane reversal is not applicable or performed by the transceivers, saves logic
  .CTRL_SCRAMBLERS(CTRL_SCRAMBLERS),        //Set to 0 to remove the option to disable (de-)scramblers for debugging, saves logic
  .OPEN_RSP_MODE(OPEN_RSP_MODE),            //Set to 1 if running response open loop mode, bypasses the RX input buffer
  .RX_RELAX_INIT_TIMING(RX_RELAX_INIT_TIMING),    //Per default, incoming TS1 sequences are only checked for the lane independent h'F0 sequence. Save resources and
                                                   //eases timing closure. !Lane reversal is still detected
  .RX_BIT_SLIP_CNT_LOG(RX_BIT_SLIP_CNT_LOG),     //Define the number of cycles between bit slips. Refer to the transceiver user guide
                                    //Example: RX_BIT_SLIP_CNT_LOG=5 results in 2^5=32 cycles between two bit slips
  .SYNC_AXI4_IF(SYNC_AXI4_IF),    //Set to 1 if AXI IF is synchronous to clk_hmc to use simple fifos
  .XIL_CNT_PIPELINED(XIL_CNT_PIPELINED),    //If Xilinx counters are used, set to 1 to enabled output register pipelining
  //Set the direction of bitslip. Set to 1 if bitslip performs a shift right, otherwise set to 0 (see the corresponding transceiver user guide)
  .BITSLIP_SHIFT_RIGHT(BITSLIP_SHIFT_RIGHT),    
  //Debug Params
  .DBG_RX_TOKEN_MON(DBG_RX_TOKEN_MON),     //Set to 0 to remove the RX Link token monitor, saves logic    
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
  .clk_hmc_out(clk_hmc_out_link2),
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
  .FERR_N(1'b1),
  .OPEN_HMC_INIT_DONE(open_hmc_done_link2_i),
  .HMC_IIC_INIT_DONE(hmc_iic_init_done_i),
  .TX_PHY_RESET_DONE(tx_phy_reset_done_link2), // Flag to indicate when the GTH TX PHY is ready
  .RX_PHY_RESET_DONE(rx_phy_reset_done_link2), // Flag to indicate when the GTH RX PHY is ready
  .TX_PHY_RESET(tx_phy_reset), // Flag to reset the GTH TX PHY    
  .RX_PHY_RESET(rx_phy_reset), //Flag to reset the GTH RX 
  .MMCM_RESET_IN(mmcm_reset),
  .QPLL0_RESET_IN(qpll_reset),
  .QPLL1_RESET_IN(qpll_reset),      
  .RX_CRC_ERR_CNT(rx_crc_err_cnt_link2a),
  .FIFO_TX_FLAG_STATUS(fifo_tx_flag_status_link2),
  .FIFO_RX_FLAG_STATUS(fifo_rx_flag_status_link2)  
);

// Instantiate core for HMC link3
hmc_ska_sa_top #(
  //Define width of the datapath
  .FPW(FPW),                //Legal Values: 2,4,6,8
  .LOG_FPW(LOG_FPW),        //Legal Values: 1 for FPW=2 ,2 for FPW=4 ,3 for FPW=6/8
  .DWIDTH(DWIDTH),          //Leave untouched
  //Define HMC interface width
  .LOG_NUM_LANES(LOG_NUM_LANES),     //Set 3 for half-width, 4 for full-width
  .NUM_LANES(NUM_LANES),             //Leave untouched
  .NUM_DATA_BYTES(NUM_DATA_BYTES),   //Leave untouched
  //Define width of the register file
  .HMC_RF_WWIDTH(HMC_RF_WWIDTH),    //Leave untouched    
  .HMC_RF_RWIDTH(HMC_RF_RWIDTH),    //Leave untouched
  .HMC_RF_AWIDTH(HMC_RF_AWIDTH),    //Leave untouched
  //Configure the Functionality
  .LOG_MAX_RX_TOKENS(LOG_MAX_RX_TOKENS),    //Set the depth of the RX input buffer. Must be >= LOG(rf_rx_buffer_rtc) in the RF. Dont't care if OPEN_RSP_MODE=1
  .LOG_MAX_HMC_TOKENS(LOG_MAX_HMC_TOKENS),  //Set the depth of the HMC input buffer. Must be >= LOG of the corresponding field in the HMC internal register
  .HMC_RX_AC_COUPLED(HMC_RX_AC_COUPLED),    //Set to 0 to bypass the run length limiter, saves logic and 1 cycle delay
  .DETECT_LANE_POLARITY(DETECT_LANE_POLARITY),    //Set to 0 if lane polarity is not applicable, saves logic
  .CTRL_LANE_POLARITY(CTRL_LANE_POLARITY),        //Set to 0 if lane polarity is not applicable or performed by the transceivers, saves logic and 1 cycle delay
                                                  //If set to 1: Only valid if DETECT_LANE_POLARITY==1, otherwise tied to zero
  .CTRL_LANE_REVERSAL(CTRL_LANE_REVERSAL),  //Set to 0 if lane reversal is not applicable or performed by the transceivers, saves logic
  .CTRL_SCRAMBLERS(CTRL_SCRAMBLERS),        //Set to 0 to remove the option to disable (de-)scramblers for debugging, saves logic
  .OPEN_RSP_MODE(OPEN_RSP_MODE),            //Set to 1 if running response open loop mode, bypasses the RX input buffer
  .RX_RELAX_INIT_TIMING(RX_RELAX_INIT_TIMING),    //Per default, incoming TS1 sequences are only checked for the lane independent h'F0 sequence. Save resources and
                                                   //eases timing closure. !Lane reversal is still detected
  .RX_BIT_SLIP_CNT_LOG(RX_BIT_SLIP_CNT_LOG),     //Define the number of cycles between bit slips. Refer to the transceiver user guide
                                    //Example: RX_BIT_SLIP_CNT_LOG=5 results in 2^5=32 cycles between two bit slips
  .SYNC_AXI4_IF(SYNC_AXI4_IF),    //Set to 1 if AXI IF is synchronous to clk_hmc to use simple fifos
  .XIL_CNT_PIPELINED(XIL_CNT_PIPELINED),    //If Xilinx counters are used, set to 1 to enabled output register pipelining
  //Set the direction of bitslip. Set to 1 if bitslip performs a shift right, otherwise set to 0 (see the corresponding transceiver user guide)
  .BITSLIP_SHIFT_RIGHT(BITSLIP_SHIFT_RIGHT),    
  //Debug Params
  .DBG_RX_TOKEN_MON(DBG_RX_TOKEN_MON),     //Set to 0 to remove the RX Link token monitor, saves logic    
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
  .clk_hmc_out(clk_hmc_out_link3),
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
  .FERR_N(1'b1),
  .OPEN_HMC_INIT_DONE(open_hmc_done_link3_i),
  .HMC_IIC_INIT_DONE(hmc_iic_init_doneRRRR),
  .TX_PHY_RESET_DONE(tx_phy_reset_done_link3), // Flag to indicate when the GTH TX PHY is ready
  .RX_PHY_RESET_DONE(rx_phy_reset_done_link3), // Flag to indicate when the GTH RX PHY is ready
  .TX_PHY_RESET(tx_phy_reset), // Flag to reset the GTH TX PHY    
  .RX_PHY_RESET(rx_phy_reset), //Flag to reset the GTH RX PHY
  .MMCM_RESET_IN(mmcm_reset), 
  .QPLL0_RESET_IN(qpll_reset_in),
  .QPLL1_RESET_IN(qpll_reset_in),       
  .RX_CRC_ERR_CNT(rx_crc_err_cnt_link3a),
  .FIFO_TX_FLAG_STATUS(fifo_tx_flag_status_link3),
  .FIFO_RX_FLAG_STATUS(fifo_rx_flag_status_link3)  

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
  .WR_ADDRESS(WR_ADDRESS_LINK2),
  .DATA_IN(DATA_IN_LINK2),
  .WR_REQ(WR_REQ_LINK2),
  .WR_READY(WR_READY_LINK2),

  // Move both write and read to the same interface
  .RD_ADDRESS(RD_ADDRESS_LINK2),
  .RD_REQ(RD_REQ_LINK2), 
  .DATA_OUT(DATA_OUT_LINK2),
  .TAG_IN(TAG_IN_LINK2),   
  .TAG_OUT(TAG_OUT_LINK2),
  .DATA_VALID(DATA_VALID_LINK2),
  .RD_READY(RD_READY_LINK2),
  .FLIT_TAIL_ERRSTAT(ERRSTAT_LINK2)
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
  .WR_ADDRESS(WR_ADDRESS_LINK3),
  .DATA_IN(DATA_IN_LINK3),
  .WR_REQ(WR_REQ_LINK3),
  .WR_READY(WR_READY_LINK3),

  // Move both write and read to the same interface
  .RD_ADDRESS(RD_ADDRESS_LINK3),
  .RD_REQ(RD_REQ_LINK3), 
  .DATA_OUT(DATA_OUT_LINK3),
  .TAG_IN(TAG_IN_LINK3),   
  .TAG_OUT(TAG_OUT_LINK3),
  .DATA_VALID(DATA_VALID_LINK3),
  .RD_READY(RD_READY_LINK3),
  .FLIT_TAIL_ERRSTAT(ERRSTAT_LINK3)
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

