module hmc_ska_sa_top #(
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
    parameter CTRL_LANE_REVERSAL    = 1,    //Set to 0 if lane reversal is not applicable or performed by the transceivers, saves logic
    parameter CTRL_SCRAMBLERS       = 1,    //Set to 0 to remove the option to disable (de-)scramblers for debugging, saves logic
    parameter OPEN_RSP_MODE         = 0,    //Set to 1 if running response open loop mode, bypasses the RX input buffer
    parameter RX_RELAX_INIT_TIMING  = 1,    //Per default, incoming TS1 sequences are only checked for the lane independent h'F0 sequence. Save resources and
                                            //eases timing closure. !Lane reversal is still detected
    parameter RX_BIT_SLIP_CNT_LOG   = 5,    //Define the number of cycles between bit slips. Refer to the transceiver user guide
                                            //Example: RX_BIT_SLIP_CNT_LOG=5 results in 2^5=32 cycles between two bit slips
    parameter SYNC_AXI4_IF          = 0,    //Set to 1 if AXI IF is synchronous to clk_hmc to use simple fifos
    parameter XIL_CNT_PIPELINED     = 1,    //If Xilinx counters are used, set to 1 to enabled output register pipelining
    //Set the direction of bitslip. Set to 1 if bitslip performs a shift right, otherwise set to 0 (see the corresponding transceiver user guide)
    parameter BITSLIP_SHIFT_RIGHT   = 1,    
    //Debug Params
    parameter DBG_RX_TOKEN_MON      = 1,     //Set to 0 to remove the RX Link token monitor, saves logic
    //Configure the Functionality
    parameter LINK                  = 2    // 0,1,2,3 Specifies the mezzanine site on SKARAB to detangle lane order
    
    
)(

    //_________________________________________________________________________
    //GT0  (X1Y16)
    //____________________________CHANNEL PORTS________________________________
    //---------------- Receive Ports - FPGA RX interface Ports -----------------
   
    //---------------------- Receive Ports
    input wire  [7:0]   gt_gthrxp_in,
    input wire  [7:0]   gt_gthrxn_in,

    //---------------------- Transmit Ports
    output wire [7:0]   gt_gthtxp_out,
    output wire [7:0]   gt_gthtxn_out,

    input wire          REFCLK_PAD_N_IN_0,
    input wire          REFCLK_PAD_P_IN_0,
    input wire          REFCLK_PAD_N_IN_1,
    input wire          REFCLK_PAD_P_IN_1,

    //____________________________COMMON PORTS________________________________
    //-------------------- Common Block  - Ref Clock Ports ---------------------

    //----------------------------------
    //----SYSTEM INTERFACES
    //----------------------------------
    input  wire                         SOFT_RESET_IN,
    input  wire                         clk_user,
    //input  wire                         clk_hmc,
    input  wire                         res_n_user,
    //input  wire                         res_n_hmc,
    output wire clk_hmc_out,
    output wire hmc_reset_out,
    output wire QPLL_LOCK,

    //----------------------------------
    //----Connect AXI Ports
    //----------------------------------
    //From AXI to HMC Ctrl TX
    input  wire                         s_axis_tx_TVALID,
    output wire                         s_axis_tx_TREADY,
    input  wire [DWIDTH-1:0]            s_axis_tx_TDATA,
    input  wire [NUM_DATA_BYTES-1:0]    s_axis_tx_TUSER,
    //From HMC Ctrl RX to AXI
    output wire                         m_axis_rx_TVALID,
    input  wire                         m_axis_rx_TREADY,
    output wire [DWIDTH-1:0]            m_axis_rx_TDATA,
    output wire [NUM_DATA_BYTES-1:0]    m_axis_rx_TUSER,

    //----------------------------------
    //----Connect HMC
    //----------------------------------
    output wire                         P_RST_N,
    output wire                         LXRXPS,//hmc_LxRXPS,
    input  wire                         LXTXPS,//hmc_LxTXPS,
    input  wire                         FERR_N,

    //----------------------------------
    //----Connect RF
    //----------------------------------
    // NB! On 
    input  wire  [HMC_RF_AWIDTH-1:0]    rf_address,
    output wire  [HMC_RF_RWIDTH-1:0]    rf_read_data,
    output wire                         rf_invalid_address,
    output wire                         rf_access_complete,
    input  wire                         rf_read_en,
    input  wire                         rf_write_en,
    input  wire  [HMC_RF_WWIDTH-1:0]    rf_write_data,

    // IIC BUS
    inout  wire SDA,
    inout  wire SCL,

    output wire OPEN_HMC_INIT_DONE,
    input  wire HMC_IIC_INIT_DONE,
    output wire TX_PHY_RESET_DONE, // Flag to indicate when the GTH TX PHY is ready
    output wire RX_PHY_RESET_DONE, // Flag to indicate when the GTH RX PHY is ready
    input  wire TX_PHY_RESET, // Flag to reset the GTH TX PHY    
    input  wire RX_PHY_RESET, //Flag to reset the GTH RX 
    input  wire MMCM_RESET_IN,
    input  wire QPLL0_RESET_IN,
    input  wire QPLL1_RESET_IN,  
    //AI: debugging and error monitoring   
    output wire [15:0] RX_CRC_ERR_CNT,
    output wire [7:0] FIFO_TX_FLAG_STATUS,
    output wire [7:0] FIFO_RX_FLAG_STATUS
    
);

  // Not used
  assign LXRXPS = 1'b0;

    wire clk_hmc;

    //----------------------------------
    //----Connect Transceiver
    //----------------------------------
    wire  [DWIDTH-1:0]           loop_back;
    wire  [DWIDTH-1:0]           phy_data_tx_link2phy;
    wire  [DWIDTH-1:0]           phy_data_rx_phy2link;
    wire  [NUM_LANES-1:0]        phy_bit_slip;
    wire  [NUM_LANES-1:0]        phy_lane_polarity;  //All 0 if CTRL_LANE_POLARITY=1
    //wire                         phy_ready;
    wire                         phy_tx_ready;
    wire                         phy_rx_ready;
    wire 		         phy_init_cont_set;
    //----------------------------------
    //----Connect RF
    //----------------------------------
    wire  [HMC_RF_AWIDTH-1:0]    rf_address_hmc_init,rf_address_hmc;
    wire  [HMC_RF_RWIDTH-1:0]    rf_read_data_hmc_init,rf_read_data_hmc;
    wire                         rf_invalid_address_hmc_init,rf_invalid_address_hmc;
    wire                         rf_access_complete_hmc_init,rf_access_complete_hmc;
    wire                         rf_read_en_hmc_init,rf_read_en_hmc;
    wire                         rf_write_en_hmc_init,rf_write_en_hmc;
    wire  [HMC_RF_WWIDTH-1:0]    rf_write_data_hmc_init,rf_write_data_hmc;

wire [63:0] gt7_rxdata_out,gt6_rxdata_out,gt5_rxdata_out,gt4_rxdata_out,gt3_rxdata_out,gt2_rxdata_out,gt1_rxdata_out,gt0_rxdata_out;
reg [DWIDTH-1:0] phy_data_tx_link2phy_R;
reg [DWIDTH-1:0] phy_data_rx_phy2link_R;

wire [NUM_LANES-1:0] gt_rxslide_in,gt_rxslide_in_i;
reg [7:0] gt_rxslide_in_iR;

  assign TX_PHY_RESET_DONE = phy_tx_ready;
  assign RX_PHY_RESET_DONE = phy_rx_ready; 

  always @(negedge clk_hmc) begin   
    gt_rxslide_in_iR <= gt_rxslide_in_i;
  end

  wire [63:0] gt0_txdata_in;
  wire [63:0] gt3_txdata_in;
  wire [63:0] gt4_txdata_in;
  wire [63:0] gt7_txdata_in;
  wire [63:0] gt1_txdata_in;
  wire [63:0] gt2_txdata_in;
  wire [63:0] gt5_txdata_in;
  wire [63:0] gt6_txdata_in;
  wire [DWIDTH-1:0] phy_data_rx_phy2link_i;

// Sort out routing reorder for each mezzanine and HMC Link
generate
if (LINK==2) 
begin : mezz_link2_route_inst
  assign gt1_txdata_in = phy_data_tx_link2phy_R[(64*8)-1:(64*7)]; // OpenHMC link2 lane 7 maps to PHY21_LANE1
  assign gt2_txdata_in = phy_data_tx_link2phy_R[(64*7)-1:(64*6)]; // OpenHMC link2 lane 6 maps to PHY21_LANE2
  assign gt5_txdata_in = phy_data_tx_link2phy_R[(64*6)-1:(64*5)]; // OpenHMC link2 lane 5 maps to PHY22_LANE1
  assign gt6_txdata_in = phy_data_tx_link2phy_R[(64*5)-1:(64*4)]; // OpenHMC link2 lane 4 maps to PHY22_LANE2
  assign gt0_txdata_in = phy_data_tx_link2phy_R[(64*4)-1:(64*3)]; // OpenHMC link2 lane 3 maps to PHY21_LANE0
  assign gt3_txdata_in = phy_data_tx_link2phy_R[(64*3)-1:(64*2)]; // OpenHMC link2 lane 2 maps to PHY21_LANE3
  assign gt4_txdata_in = phy_data_tx_link2phy_R[(64*2)-1:(64*1)]; // OpenHMC link2 lane 1 maps to PHY22_LANE0
  assign gt7_txdata_in = phy_data_tx_link2phy_R[(64*1)-1:(64*0)]; // OpenHMC link2 lane 0 maps to PHY22_LANE3
  assign phy_data_rx_phy2link_i = {gt1_rxdata_out,gt2_rxdata_out,gt5_rxdata_out,gt6_rxdata_out,gt0_rxdata_out,gt3_rxdata_out,gt4_rxdata_out,gt7_rxdata_out};
  assign gt_rxslide_in[1] = gt_rxslide_in_iR[7]; 
  assign gt_rxslide_in[2] = gt_rxslide_in_iR[6]; 
  assign gt_rxslide_in[5] = gt_rxslide_in_iR[5]; 
  assign gt_rxslide_in[6] = gt_rxslide_in_iR[4]; 
  assign gt_rxslide_in[0] = gt_rxslide_in_iR[3]; 
  assign gt_rxslide_in[3] = gt_rxslide_in_iR[2]; 
  assign gt_rxslide_in[4] = gt_rxslide_in_iR[1]; 
  assign gt_rxslide_in[7] = gt_rxslide_in_iR[0]; 
end 
if (LINK==3) 
begin : mezz_link3_route_inst
  assign gt6_txdata_in = phy_data_tx_link2phy_R[(64*8)-1:(64*7)]; // OpenHMC link3 lane 7 maps to PHY12_LANE1
  assign gt5_txdata_in = phy_data_tx_link2phy_R[(64*7)-1:(64*6)]; // OpenHMC link3 lane 6 maps to PHY12_LANE2
  assign gt2_txdata_in = phy_data_tx_link2phy_R[(64*6)-1:(64*5)]; // OpenHMC link3 lane 5 maps to PHY11_LANE1
  assign gt1_txdata_in = phy_data_tx_link2phy_R[(64*5)-1:(64*4)]; // OpenHMC link3 lane 4 maps to PHY11_LANE2
  assign gt7_txdata_in = phy_data_tx_link2phy_R[(64*4)-1:(64*3)]; // OpenHMC link3 lane 3 maps to PHY12_LANE0
  assign gt4_txdata_in = phy_data_tx_link2phy_R[(64*3)-1:(64*2)]; // OpenHMC link3 lane 2 maps to PHY12_LANE3
  assign gt3_txdata_in = phy_data_tx_link2phy_R[(64*2)-1:(64*1)]; // OpenHMC link3 lane 1 maps to PHY11_LANE0
  assign gt0_txdata_in = phy_data_tx_link2phy_R[(64*1)-1:(64*0)]; // OpenHMC link3 lane 0 maps to PHY11_LANE3
  assign phy_data_rx_phy2link_i = {gt6_rxdata_out,gt5_rxdata_out,gt2_rxdata_out,gt1_rxdata_out,gt7_rxdata_out,gt4_rxdata_out,gt3_rxdata_out,gt0_rxdata_out};
  assign gt_rxslide_in[6] = gt_rxslide_in_iR[7]; 
  assign gt_rxslide_in[5] = gt_rxslide_in_iR[6]; 
  assign gt_rxslide_in[2] = gt_rxslide_in_iR[5]; 
  assign gt_rxslide_in[1] = gt_rxslide_in_iR[4]; 
  assign gt_rxslide_in[7] = gt_rxslide_in_iR[3]; 
  assign gt_rxslide_in[4] = gt_rxslide_in_iR[2]; 
  assign gt_rxslide_in[3] = gt_rxslide_in_iR[1]; 
  assign gt_rxslide_in[0] = gt_rxslide_in_iR[0]; 
end 
endgenerate 

  always @(posedge clk_hmc) begin   
    phy_data_tx_link2phy_R <= phy_data_tx_link2phy;
    phy_data_rx_phy2link_R <= phy_data_rx_phy2link_i;    
  end

  assign phy_data_rx_phy2link = phy_data_rx_phy2link_R;



// 4 Link Board
//wire [63:0] gt5_txdata_in = phy_data_tx_link2phy_R[(64*8)-1:(64*7)]; // OpenHMC lane 7 maps to GTH X0Y5
//wire [63:0] gt4_txdata_in = phy_data_tx_link2phy_R[(64*7)-1:(64*6)]; // OpenHMC lane 6 maps to GTH X0Y4
//wire [63:0] gt3_txdata_in = phy_data_tx_link2phy_R[(64*6)-1:(64*5)]; // OpenHMC lane 5 maps to GTH X0Y3
//wire [63:0] gt2_txdata_in = phy_data_tx_link2phy_R[(64*5)-1:(64*4)]; // OpenHMC lane 4 maps to GTH X0Y2
//wire [63:0] gt6_txdata_in = phy_data_tx_link2phy_R[(64*4)-1:(64*3)]; // OpenHMC lane 3 maps to GTH X0Y6
//wire [63:0] gt7_txdata_in = phy_data_tx_link2phy_R[(64*3)-1:(64*2)]; // OpenHMC lane 2 maps to GTH X0Y7
//wire [63:0] gt0_txdata_in = phy_data_tx_link2phy_R[(64*2)-1:(64*1)]; // OpenHMC lane 1 maps to GTH X0Y0
//wire [63:0] gt1_txdata_in = phy_data_tx_link2phy_R[(64*1)-1:(64*0)]; // OpenHMC lane 0 maps to  
//wire [DWIDTH-1:0] phy_data_rx_phy2link_i = {gt5_rxdata_out,gt4_rxdata_out,gt3_rxdata_out,gt2_rxdata_out,gt6_rxdata_out,gt7_rxdata_out,gt0_rxdata_out,gt1_rxdata_out};
//assign gt_rxslide_in[5] = gt_rxslide_in_iR[7]; // OpenHMC lane 7 maps to GTH X0Y5
//assign gt_rxslide_in[4] = gt_rxslide_in_iR[6]; // OpenHMC lane 6 maps to GTH X0Y4
//assign gt_rxslide_in[3] = gt_rxslide_in_iR[5]; // OpenHMC lane 5 maps to GTH X0Y3
//assign gt_rxslide_in[2] = gt_rxslide_in_iR[4]; // OpenHMC lane 4 maps to GTH X0Y2
//assign gt_rxslide_in[6] = gt_rxslide_in_iR[3]; // OpenHMC lane 3 maps to GTH X0Y6
//assign gt_rxslide_in[7] = gt_rxslide_in_iR[2]; // OpenHMC lane 2 maps to GTH X0Y7
//assign gt_rxslide_in[0] = gt_rxslide_in_iR[1]; // OpenHMC lane 1 maps to GTH X0Y0
//assign gt_rxslide_in[1] = gt_rxslide_in_iR[0]; // OpenHMC lane 0 maps to GTH X0Y1



   //wire clk_hmc;
   assign clk_hmc_out = clk_hmc;
  
  reg [17:0] rst_cnt;
  always @(posedge clk_hmc or posedge SOFT_RESET_IN) begin 
    if (SOFT_RESET_IN == 1'b1) begin
      rst_cnt <= 18'd0;
    end else   
    if (mmcm_locked == 1'b1) begin
      if (rst_cnt[17] == 1'b0) begin
        rst_cnt <= rst_cnt + 1'b1;
      end     
    end
  end

    wire res_n;
    assign res_n = rst_cnt[17];//~(SOFT_RESET_IN) && mmcm_locked && rst_cnt[17];//
    assign hmc_reset_out = ~res_n;

hmc_gth hmc_gth_inst(

    .REFCLK_PAD_N_IN_0(REFCLK_PAD_N_IN_0),
    .REFCLK_PAD_P_IN_0(REFCLK_PAD_P_IN_0),
    .REFCLK_PAD_N_IN_1(REFCLK_PAD_N_IN_1),
    .REFCLK_PAD_P_IN_1(REFCLK_PAD_P_IN_1),

    //------------- Receive Ports - Comma Detection and Alignment --------------
    .GT0_RXSLIDE_IN(gt_rxslide_in[0]),
    .GT1_RXSLIDE_IN(gt_rxslide_in[1]),
    .GT2_RXSLIDE_IN(gt_rxslide_in[2]),
    .GT3_RXSLIDE_IN(gt_rxslide_in[3]),
    .GT4_RXSLIDE_IN(gt_rxslide_in[4]),
    .GT5_RXSLIDE_IN(gt_rxslide_in[5]),
    .GT6_RXSLIDE_IN(gt_rxslide_in[6]),
    .GT7_RXSLIDE_IN(gt_rxslide_in[7]),

    //---------------- Receive Ports - FPGA RX interface Ports -----------------
    .GT0_RXDATA_OUT(gt0_rxdata_out),
    .GT1_RXDATA_OUT(gt1_rxdata_out),
    .GT2_RXDATA_OUT(gt2_rxdata_out),
    .GT3_RXDATA_OUT(gt3_rxdata_out),
    .GT4_RXDATA_OUT(gt4_rxdata_out),
    .GT5_RXDATA_OUT(gt5_rxdata_out),
    .GT6_RXDATA_OUT(gt6_rxdata_out),
    .GT7_RXDATA_OUT(gt7_rxdata_out),

    //---------------------- Receive Ports - RX AFE Ports ----------------------
    .GT0_GTHRXN_IN(gt_gthrxn_in[0]),
    .GT1_GTHRXN_IN(gt_gthrxn_in[1]),
    .GT2_GTHRXN_IN(gt_gthrxn_in[2]),
    .GT3_GTHRXN_IN(gt_gthrxn_in[3]),
    .GT4_GTHRXN_IN(gt_gthrxn_in[4]),
    .GT5_GTHRXN_IN(gt_gthrxn_in[5]),
    .GT6_GTHRXN_IN(gt_gthrxn_in[6]),
    .GT7_GTHRXN_IN(gt_gthrxn_in[7]),

    //---------------------- Receive Ports -RX AFE Ports -----------------------
    .GT0_GTHRXP_IN(gt_gthrxp_in[0]),
    .GT1_GTHRXP_IN(gt_gthrxp_in[1]),
    .GT2_GTHRXP_IN(gt_gthrxp_in[2]),
    .GT3_GTHRXP_IN(gt_gthrxp_in[3]),
    .GT4_GTHRXP_IN(gt_gthrxp_in[4]),
    .GT5_GTHRXP_IN(gt_gthrxp_in[5]),
    .GT6_GTHRXP_IN(gt_gthrxp_in[6]),
    .GT7_GTHRXP_IN(gt_gthrxp_in[7]),
    //------------ Receive Ports -RX Initialization and Reset Ports ------------
    .PHY_RX_RDY(phy_rx_ready),
    .SOFT_RESET_RX_IN(SOFT_RESET_IN | RX_PHY_RESET),//(1'b0),    
    .GTH_RX_RST(),
    //---------------- Transmit Ports - TX Data Path interface -----------------
    .GT0_TXDATA_IN(gt0_txdata_in),
    .GT1_TXDATA_IN(gt1_txdata_in),
    .GT2_TXDATA_IN(gt2_txdata_in),
    .GT3_TXDATA_IN(gt3_txdata_in),
    .GT4_TXDATA_IN(gt4_txdata_in),
    .GT5_TXDATA_IN(gt5_txdata_in),
    .GT6_TXDATA_IN(gt6_txdata_in),
    .GT7_TXDATA_IN(gt7_txdata_in),
    //-------------- Transmit Ports - TX Driver and OOB signaling --------------
    .GT0_GTHTXN_OUT(gt_gthtxn_out[0]),
    .GT1_GTHTXN_OUT(gt_gthtxn_out[1]),
    .GT2_GTHTXN_OUT(gt_gthtxn_out[2]),
    .GT3_GTHTXN_OUT(gt_gthtxn_out[3]),
    .GT4_GTHTXN_OUT(gt_gthtxn_out[4]),
    .GT5_GTHTXN_OUT(gt_gthtxn_out[5]),
    .GT6_GTHTXN_OUT(gt_gthtxn_out[6]),
    .GT7_GTHTXN_OUT(gt_gthtxn_out[7]),

    .GT0_GTHTXP_OUT(gt_gthtxp_out[0]),
    .GT1_GTHTXP_OUT(gt_gthtxp_out[1]),
    .GT2_GTHTXP_OUT(gt_gthtxp_out[2]),
    .GT3_GTHTXP_OUT(gt_gthtxp_out[3]),
    .GT4_GTHTXP_OUT(gt_gthtxp_out[4]),
    .GT5_GTHTXP_OUT(gt_gthtxp_out[5]),
    .GT6_GTHTXP_OUT(gt_gthtxp_out[6]),
    .GT7_GTHTXP_OUT(gt_gthtxp_out[7]),

    .FABRIC_CLK(clk_hmc),

    .QPLL_LOCK0(qpll_lock0),
    .QPLL_LOCK1(qpll_lock1),
    .MMCM_RESET_IN(MMCM_RESET_IN),
    .MMCM_LOCKED_OUT(mmcm_locked),
    .QPLL0_RESET_IN(QPLL0_RESET_IN),
    .QPLL1_RESET_IN(QPLL1_RESET_IN),
    .PHY_TX_RDY(phy_tx_ready),
    .SOFT_RESET_TX_IN(SOFT_RESET_IN | TX_PHY_RESET),
    .GTH_TX_RST()
);

assign QPLL_LOCK = qpll_lock0 & qpll_lock1;

//AI: debugging and memory error checking
wire [63:0] rx_data_lane0;
wire [63:0] rx_data_lane1;
wire [63:0] rx_data_lane2;
wire [63:0] rx_data_lane3;
wire [63:0] rx_data_lane4;
wire [63:0] rx_data_lane5;
wire [63:0] rx_data_lane6;
wire [63:0] rx_data_lane7;
wire [63:0] rf_dbg_reg;
wire [127:0] crc_out;

// Instatiate openHMC register interface initialization sequence after the HMC IIC setup state machine completes
  openhmc_init openhmc_init_inst(
    .clk_hmc(clk_hmc),
    .res_n_hmc(res_n),

    //----------------------------------
    //----Connect RF
    //----------------------------------
    .rf_address(rf_address_hmc_init),
    .rf_read_data(rf_read_data_hmc_init),
    .rf_invalid_address(rf_invalid_address_hmc_init),
    .rf_access_complete(rf_access_complete_hmc_init),
    .rf_read_en(rf_read_en_hmc_init),
    .rf_write_en(rf_write_en_hmc_init),
    .rf_write_data(rf_write_data_hmc_init),

    // Init Status
    .HMC_IIC_INIT_DONE(HMC_IIC_INIT_DONE),
    .OPEN_HMC_INIT_DONE(OPEN_HMC_INIT_DONE)
  );

// HMC Register interface mux
//assign rf_address_hmc = (OPEN_HMC_INIT_DONE == 1'b0) ? rf_address_hmc_init : rf_address;
assign rf_address_hmc = rf_address_hmc_init;
assign rf_read_data_hmc_init = rf_read_data_hmc;
assign rf_read_data = rf_read_data_hmc;
assign rf_invalid_address_hmc_init = rf_invalid_address_hmc;
assign rf_invalid_address = rf_invalid_address_hmc;
assign rf_access_complete_hmc_init = rf_access_complete_hmc;
assign rf_access_complete = rf_access_complete_hmc;
//assign rf_read_en_hmc = (OPEN_HMC_INIT_DONE == 1'b0) ? rf_read_en_hmc_init : rf_read_en;
//assign rf_write_en_hmc = (OPEN_HMC_INIT_DONE == 1'b0) ? rf_write_en_hmc_init : rf_write_en;
//assign rf_write_data_hmc = (OPEN_HMC_INIT_DONE == 1'b0) ? rf_write_data_hmc_init : rf_write_data;
assign rf_read_en_hmc = rf_read_en_hmc_init;
assign rf_write_en_hmc = rf_write_en_hmc_init;
assign rf_write_data_hmc = rf_write_data_hmc_init;

// Instantiate openHMC controller

  (* mark_debug = "true" *) wire dbg_ska_sa_top_phy_tx_ready;
  (* mark_debug = "true" *) wire dbg_ska_sa_top_phy_rx_ready;
  (* mark_debug = "true" *) wire dbg_ska_sa_top_phy_init_cont_set;
  (* mark_debug = "true" *) wire dbg_ska_sa_top_HMC_IIC_INIT_DONE;
  
  assign dbg_ska_sa_top_phy_tx_ready = phy_tx_ready;
  assign dbg_ska_sa_top_phy_rx_ready = phy_rx_ready;
  assign dbg_ska_sa_top_phy_init_cont_set = phy_init_cont_set;
  assign dbg_ska_sa_top_HMC_IIC_INIT_DONE = HMC_IIC_INIT_DONE;
  
//  wire m_axis_rx_TREADY_ser;
//  wire m_axis_rx_TVALID_ser;
//  wire [DWIDTH-1:0] m_axis_rx_TDATA_ser;
//  wire [NUM_DATA_BYTES-1:0] m_axis_rx_TUSER_ser;
  
//openhmc_rx_pkt_serializer #(
//    //Define width of the datapath
//    .FPW(FPW),                //Legal Values: 2,4,6,8
//    .LOG_FPW(LOG_FPW),        //Legal Values: 1 for FPW=2 ,2 for FPW=4 ,3 for FPW=6/8
//    .DWIDTH(DWIDTH),          //Leave untouched
//    .NUM_DATA_BYTES(NUM_DATA_BYTES)   //Leave untouched
    
//) openhmc_rx_pkt_serializer_inst (
//    .clk(clk_user),
//    .res_n(res_n_user),
//    //To USER Logic
//    .out_TREADY(m_axis_rx_TREADY),
//    .out_TVALID(m_axis_rx_TVALID),
//    .out_TDATA(m_axis_rx_TDATA),
//    .out_TUSER(m_axis_rx_TUSER),
//    //From openHMC
//    .in_TREADY(m_axis_rx_TREADY_ser),
//    .in_TVALID(m_axis_rx_TVALID_ser),
//    .in_TDATA(m_axis_rx_TDATA_ser),
//    .in_TUSER(m_axis_rx_TUSER_ser)
//    );

    

openhmc_top #(    
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
    .DBG_RX_TOKEN_MON(DBG_RX_TOKEN_MON)     //Set to 0 to remove the RX Link token monitor, saves logic
        
) openhmc_top_inst (
    //----------------------------------
    //----SYSTEM INTERFACES
    //----------------------------------
    .clk_user(clk_user),
    .clk_hmc(clk_hmc),
    .res_n_user(res_n_user),
    .res_n_hmc(res_n),

    //----------------------------------
    //----Connect AXI Ports
    //----------------------------------
    //From AXI to HMC Ctrl TX
    .s_axis_tx_TVALID(s_axis_tx_TVALID),
    .s_axis_tx_TREADY(s_axis_tx_TREADY),
    .s_axis_tx_TDATA(s_axis_tx_TDATA),
    .s_axis_tx_TUSER(s_axis_tx_TUSER),
    //From HMC Ctrl RX to AXI
//    .m_axis_rx_TVALID(m_axis_rx_TVALID_ser),
//    .m_axis_rx_TREADY(m_axis_rx_TREADY_ser),
//    .m_axis_rx_TDATA(m_axis_rx_TDATA_ser),
//    .m_axis_rx_TUSER(m_axis_rx_TUSER_ser),

    .m_axis_rx_TVALID(m_axis_rx_TVALID),
    .m_axis_rx_TREADY(m_axis_rx_TREADY),
    .m_axis_rx_TDATA(m_axis_rx_TDATA),
    .m_axis_rx_TUSER(m_axis_rx_TUSER),


    //----------------------------------
    //----Connect Transceiver
    //----------------------------------
    .phy_data_tx_link2phy(phy_data_tx_link2phy),//(loop_back),//(phy_data_tx_link2phy),
    .phy_data_rx_phy2link(phy_data_rx_phy2link),//(loop_back),//(phy_data_rx_phy2link),
    .phy_bit_slip(gt_rxslide_in_i),
    .phy_lane_polarity(),  //All 0 if CTRL_LANE_POLARITY=1
    .phy_tx_ready(phy_tx_ready),
    .phy_rx_ready(phy_rx_ready & phy_init_cont_set & HMC_IIC_INIT_DONE),
    .phy_init_cont_set(phy_init_cont_set),
    

    //----------------------------------
    //----Connect HMC
    //----------------------------------
    .P_RST_N(),//(P_RST_N),
    .LXRXPS(), // No link power down // .hmc_LxRXPS(hmc_LxRXPS),
    .LXTXPS(1'b1), // No link power down //.hmc_LxTXPS(hmc_LxTXPS),
    .FERR_N(FERR_N), //FERR_N), //Not connected

    //----------------------------------
    //----Connect RF
    //----------------------------------
    .rf_address(rf_address_hmc),
    .rf_read_data(rf_read_data_hmc),
    .rf_invalid_address(rf_invalid_address_hmc),
    .rf_access_complete(rf_access_complete_hmc),
    .rf_read_en(rf_read_en_hmc),
    .rf_write_en(rf_write_en_hmc),
    .rf_write_data(rf_write_data_hmc),
    
    //AI:debugging and error checking
    .rx_data_lane0(rx_data_lane0),
    .rx_data_lane1(rx_data_lane1),
    .rx_data_lane2(rx_data_lane2),
    .rx_data_lane3(rx_data_lane3),
    .rx_data_lane4(rx_data_lane4),
    .rx_data_lane5(rx_data_lane5),
    .rx_data_lane6(rx_data_lane6),
    .rx_data_lane7(rx_data_lane7),
    .rf_dbg_reg(rf_dbg_reg),
    .crc_out(crc_out),
    .fifo_tx_flag_status(FIFO_TX_FLAG_STATUS),
    .fifo_rx_flag_status(FIFO_RX_FLAG_STATUS)        
    );
    
reg [15:0] rx_crc_err_cnt;

  always @(posedge clk_hmc) begin   
    if (res_n == 1'b0) begin
      rx_crc_err_cnt <= 16'd0;
    end begin
      rx_crc_err_cnt <= rx_crc_err_cnt + rf_dbg_reg[3:0];
    end  
  end

  assign RX_CRC_ERR_CNT = rx_crc_err_cnt; //16'd0;

  assign P_RST_N = 1'b1; // As soon as the FPGA is configured the HMC must startup

endmodule


`default_nettype wire


