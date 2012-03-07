module transceiver(
    //mgt resets and clocks
    reset, rx_reset, tx_reset,
    refclk, refclk_ret,
    mgt_clk, mgt_clk_mult_2,
    //mgt rx/tx
    txp_1, txn_1,
    txp_0, txn_0,
    rxp_1, rxn_1,
    rxp_0, rxn_0,
    //Channel bonding
    chbondi_1, chbondi_0,
    chbondo_1, chbondo_0,
    //xaui TX/RX ports
    rxdata_1, rxdata_0, 
    rxcharisk_1, rxcharisk_0,
    txdata_1, txdata_0, 
    txcharisk_1, txcharisk_0,
    code_comma_1, code_comma_0,
    //xaui align/sync control
    enchansync_1, enchansync_0,
    enable_align_1, enable_align_0,
    //xaui misc control bits
    loopback, powerdown,
    //xaui status bits
    rxlock_1, rxlock_0,
    syncok_1, syncok_0,
    codevalid_1, codevalid_0,
    rxbufferr_1, rxbufferr_0,
    //testing ports
    rxeqmix, rxeqpole,
    txpreemphasis, txdiffctrl
  );

  parameter TX_POLARITY_HACK_0 = 1'b0;
  parameter TX_POLARITY_HACK_1 = 1'b0;
  parameter RX_POLARITY_HACK_0 = 1'b0;
  parameter RX_POLARITY_HACK_1 = 1'b0;

  parameter CHAN_BOND_LEVEL_1 = "OFF";
  parameter CHAN_BOND_LEVEL_0 = "OFF";
  parameter CHAN_BOND_MODE_1  = "OFF";
  parameter CHAN_BOND_MODE_0  = "OFF";

  localparam TILE_CHAN_BOND_LEVEL_1 = CHAN_BOND_LEVEL_1;
  localparam TILE_CHAN_BOND_LEVEL_0 = CHAN_BOND_LEVEL_0;
  localparam TILE_CHAN_BOND_MODE_1  = CHAN_BOND_MODE_1;
  localparam TILE_CHAN_BOND_MODE_0  = CHAN_BOND_MODE_0;

  parameter DIFF_BOOST = "FALSE";

  input  reset, rx_reset, tx_reset;
  input  refclk, mgt_clk, mgt_clk_mult_2;
  output refclk_ret;

  output txp_1, txn_1, txp_0, txn_0;
  input  rxp_1, rxn_1, rxp_0, rxn_0;

  input   [2:0] chbondi_1;
  input   [2:0] chbondi_0;
  output  [2:0] chbondo_1;
  output  [2:0] chbondo_0;

  output [15:0] rxdata_1;
  output [15:0] rxdata_0;
  output  [1:0] rxcharisk_1;
  output  [1:0] rxcharisk_0;
  output  [1:0] code_comma_1;
  output  [1:0] code_comma_0;

  input  [15:0] txdata_1;
  input  [15:0] txdata_0; 
  input   [1:0] txcharisk_1;
  input   [1:0] txcharisk_0;
  
  input  enchansync_1, enchansync_0;
  input  enable_align_1, enable_align_0;
  
  input  loopback, powerdown;

  output rxlock_1, rxlock_0;
  output syncok_1, syncok_0;
  output [1:0] codevalid_1;
  output [1:0] codevalid_0;
  output rxbufferr_1, rxbufferr_0;

  input  [1:0] rxeqmix;
  input  [3:0] rxeqpole;
  input  [2:0] txpreemphasis;
  input  [2:0] txdiffctrl;

  /*********** Loopback Definitions *************/
  localparam LOOPTYPE_NEAR_PARALLEL = 0;
  localparam LOOPTYPE_NEAR_SERIAL   = 1;
  localparam LOOPTYPE_FAR_PARALLEL  = 2;
  localparam LOOPTYPE_FAR_SERIAL    = 3;
  localparam LOOPTYPE = LOOPTYPE_NEAR_SERIAL;

  wire [2:0] loopback_int = loopback == 1'b0                   ? 3'b000 : 
                            LOOPTYPE == LOOPTYPE_NEAR_PARALLEL ? 3'b001 :
                            LOOPTYPE == LOOPTYPE_NEAR_SERIAL   ? 3'b010 :
                            LOOPTYPE == LOOPTYPE_FAR_SERIAL    ? 3'b100 :
                            LOOPTYPE == LOOPTYPE_FAR_PARALLEL  ? 3'b110 :
                                                                 3'b000;
  /************* Polarity Hacks ******************/
  wire polarity_hack_rx_0 = loopback ? 1'b0 : RX_POLARITY_HACK_0;
  wire polarity_hack_rx_1 = loopback ? 1'b0 : RX_POLARITY_HACK_1;
  wire polarity_hack_tx_0 = loopback ? 1'b0 : TX_POLARITY_HACK_0;
  wire polarity_hack_tx_1 = loopback ? 1'b0 : TX_POLARITY_HACK_1;


  /*********** Powerdown Definitions *************/

    wire   [2: 0]      LOOPBACK0_IN;
    wire   [2: 0]      LOOPBACK1_IN;
    assign LOOPBACK0_IN = loopback_int;
    assign LOOPBACK1_IN = loopback_int;
    wire   [1: 0]      RXPOWERDOWN0_IN;
    wire   [1: 0]      RXPOWERDOWN1_IN;
    wire   [1: 0]      TXPOWERDOWN0_IN;
    wire   [1: 0]      TXPOWERDOWN1_IN;
    assign RXPOWERDOWN0_IN = {2{powerdown}};
    assign RXPOWERDOWN1_IN = {2{powerdown}};
    assign TXPOWERDOWN0_IN = {2{powerdown}};
    assign TXPOWERDOWN1_IN = {2{powerdown}};
    //--------------------- Receive Ports - 8b10b Decoder ----------------------
    wire  [1: 0]      RXCHARISCOMMA0_OUT;
    wire  [1: 0]      RXCHARISCOMMA1_OUT;
    assign code_comma_0 = RXCHARISCOMMA0_OUT;
    assign code_comma_1 = RXCHARISCOMMA1_OUT;
    wire  [1: 0]      RXCHARISK0_OUT;
    wire  [1: 0]      RXCHARISK1_OUT;
    assign rxcharisk_1 = RXCHARISK1_OUT;
    assign rxcharisk_0 = RXCHARISK0_OUT;

    wire  [1: 0]      RXDISPERR0_OUT;
    wire  [1: 0]      RXDISPERR1_OUT;
    wire  [1: 0]      RXNOTINTABLE0_OUT;
    wire  [1: 0]      RXNOTINTABLE1_OUT;

    assign codevalid_0 = ~(RXNOTINTABLE0_OUT | RXDISPERR0_OUT);
    assign codevalid_1 = ~(RXNOTINTABLE1_OUT | RXDISPERR1_OUT);

    //----------------- Receive Ports - Channel Bonding Ports ------------------
    wire              RXCHANBONDSEQ0_OUT;
    wire              RXCHANBONDSEQ1_OUT;

    wire  [2: 0]      RXCHBONDI0_IN;
    wire  [2: 0]      RXCHBONDI1_IN;
    wire  [2: 0]      RXCHBONDO0_OUT;
    wire  [2: 0]      RXCHBONDO1_OUT;

    assign RXCHBONDI1_IN = chbondi_1;
    assign RXCHBONDI0_IN = chbondi_0;
    assign chbondo_1 = RXCHBONDO1_OUT;
    assign chbondo_0 = RXCHBONDO0_OUT;

    wire              RXENCHANSYNC0_IN;
    wire              RXENCHANSYNC1_IN;
    assign RXENCHANSYNC0_IN = enchansync_0;
    assign RXENCHANSYNC1_IN = enchansync_1;
    //----------------- Receive Ports - Clock Correction Ports -----------------
    wire  [2: 0]      RXCLKCORCNT0_OUT;
    wire  [2: 0]      RXCLKCORCNT1_OUT;
    //------------- Receive Ports - Comma Detection and Alignment --------------
    
    wire              RXBYTEISALIGNED0_OUT;
    wire              RXBYTEISALIGNED1_OUT;
    wire              RXBYTEREALIGN0_OUT;
    wire              RXBYTEREALIGN1_OUT;
    wire              RXCOMMADET0_OUT;
    wire              RXCOMMADET1_OUT;

    wire              RXENMCOMMAALIGN0_IN;
    wire              RXENMCOMMAALIGN1_IN;
    wire              RXENPCOMMAALIGN0_IN;
    wire              RXENPCOMMAALIGN1_IN;

    assign RXENMCOMMAALIGN0_IN = enable_align_0;
    assign RXENMCOMMAALIGN1_IN = enable_align_1;
    assign RXENPCOMMAALIGN0_IN = enable_align_0;
    assign RXENPCOMMAALIGN1_IN = enable_align_1;

    //----------------- Receive Ports - RX Data Path interface -----------------
    wire  [15: 0]     RXDATA0_OUT;
    wire  [15: 0]     RXDATA1_OUT;
    assign rxdata_1 = RXDATA1_OUT;
    assign rxdata_0 = RXDATA0_OUT;
    wire              RXUSRCLK0_IN;
    wire              RXUSRCLK1_IN;
    wire              RXUSRCLK20_IN;
    wire              RXUSRCLK21_IN;
    assign RXUSRCLK0_IN = mgt_clk_mult_2;
    assign RXUSRCLK1_IN = mgt_clk_mult_2;
    assign RXUSRCLK20_IN = mgt_clk;
    assign RXUSRCLK21_IN = mgt_clk;
    //----- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
    wire               RXCDRRESET0_IN;
    wire               RXCDRRESET1_IN;
    /* HACK: use rx_reset */
    assign RXCDRRESET0_IN = rx_reset;
    assign RXCDRRESET1_IN = rx_reset;
    wire               RXN0_IN;
    wire               RXN1_IN;
    wire               RXP0_IN;
    wire               RXP1_IN;
    assign RXN0_IN = rxn_0;
    assign RXN1_IN = rxn_1;
    assign RXP0_IN = rxp_0;
    assign RXP1_IN = rxp_1;

    //------ Receive Ports - RX Elastic Buffer and Phase Alignment Ports -------
    wire              RXBUFRESET0_IN;
    wire              RXBUFRESET1_IN;
    assign RXBUFRESET0_IN = 1'b0;
    assign RXBUFRESET1_IN = 1'b0;
    wire  [2: 0]      RXBUFSTATUS0_OUT;
    wire  [2: 0]      RXBUFSTATUS1_OUT;

    assign rxbufferr_0 = RXBUFSTATUS0_OUT == 3'b101 || RXBUFSTATUS0_OUT == 3'b110;
    assign rxbufferr_1 = RXBUFSTATUS1_OUT == 3'b101 || RXBUFSTATUS1_OUT == 3'b110;

    wire              RXCHANISALIGNED0_OUT;
    wire              RXCHANISALIGNED1_OUT;
    wire              RXCHANREALIGN0_OUT;
    wire              RXCHANREALIGN1_OUT;
    //------------- Receive Ports - RX Loss-of-sync State Machine --------------
    wire  [1:0]       RXLOSSOFSYNC0_OUT;
    assign syncok_0 = 1'b1;// ~RXLOSSOFSYNC0_OUT[1];
    wire  [1:0]       RXLOSSOFSYNC1_OUT;
    assign syncok_1 = 1'b1;// ~RXLOSSOFSYNC1_OUT[1];
    //----------- Shared Ports - Dynamic Reconfiguration Port (DRP) ------------
    wire  [6: 0]      DADDR_IN;
    assign DADDR_IN = 7'b0;
    wire              DCLK_IN;
    assign DCLK_IN = 1'b0;
    wire              DEN_IN;
    assign DEN_IN = 1'b0;
    wire  [15: 0]     DI_IN;
    wire  [15: 0]     DO_OUT;
    assign DO_OUT = 16'b0;
    wire              DRDY_OUT;
    wire              DWE_IN;
    assign DWE_IN = 1'b0;
    //------------------- Shared Ports - Tile and PLL Ports --------------------
    wire              CLKIN_IN;
    assign CLKIN_IN = refclk;
    wire              GTPRESET_IN;
    assign GTPRESET_IN = reset;
    wire              PLLLKDET_OUT;
    assign rxlock_0 = PLLLKDET_OUT;
    assign rxlock_1 = PLLLKDET_OUT;
    wire              REFCLKOUT_OUT;
    assign refclk_ret = REFCLKOUT_OUT;
    wire              RESETDONE0_OUT;
    wire              RESETDONE1_OUT;
    wire              TXENPMAPHASEALIGN_IN;
    wire              TXPMASETPHASE_IN;
    assign TXENPMAPHASEALIGN_IN = 0;
    assign TXPMASETPHASE_IN = 0;
    //-------------- Transmit Ports - 8b10b Encoder Control Ports --------------
    wire   [1: 0]      TXCHARISK0_IN;
    wire   [1: 0]      TXCHARISK1_IN;
    assign TXCHARISK0_IN = txcharisk_0;
    assign TXCHARISK1_IN = txcharisk_1;

    //---------------- Transmit Ports - TX Data Path interface -----------------
    wire   [15: 0]     TXDATA0_IN;
    wire   [15: 0]     TXDATA1_IN;
    wire               TXUSRCLK0_IN;
    wire               TXUSRCLK1_IN;
    wire               TXUSRCLK20_IN;
    wire               TXUSRCLK21_IN;
    assign TXDATA0_IN = txdata_0; 
    assign TXDATA1_IN = txdata_1; 
    assign TXUSRCLK0_IN = mgt_clk_mult_2;
    assign TXUSRCLK1_IN = mgt_clk_mult_2;
    assign TXUSRCLK20_IN = mgt_clk;
    assign TXUSRCLK21_IN = mgt_clk;

    //------------- Transmit Ports - TX Driver and OOB signalling --------------
    wire              TXN0_OUT;
    wire              TXN1_OUT;
    wire              TXP0_OUT;
    wire              TXP1_OUT;
    assign txn_0 = TXN0_OUT;
    assign txn_1 = TXN1_OUT;
    assign txp_0 = TXP0_OUT;
    assign txp_1 = TXP1_OUT;


//***************************** Wire Declarations *****************************

    // ground and vcc signals
    wire               tied_to_ground_i;
    wire    [63:0]     tied_to_ground_vec_i;
    wire               tied_to_vcc_i;
    wire    [63:0]     tied_to_vcc_vec_i;

    //RX Datapath signals
    wire    [15:0]  rxdata0_i;       

    //TX Datapath signals
    wire    [15:0]  txdata0_i;           

    // Electrical idle reset logic signals
    wire    [2:0]   loopback0_i;
    wire            rxelecidle0_i;
    wire            resetdone0_i;
    wire            rxelecidlereset0_i;
    wire            serialloopback0_i;
   

    //RX Datapath signals
    wire    [15:0]  rxdata1_i;       

    //TX Datapath signals
    wire    [15:0]  txdata1_i;           

    // Electrical idle reset logic signals
    wire    [2:0]   loopback1_i;
    wire            rxelecidle1_i;
    wire            resetdone1_i;
    wire            rxelecidlereset1_i;
    wire            serialloopback1_i;

    // Shared Electrical Idle Reset signal
    wire            rxenelecidleresetb_i;


// 
//********************************* Main Body of Code**************************
                       
    //-------------------------  Static signal Assigments ---------------------   

    assign tied_to_ground_i             = 1'b0;
    assign tied_to_ground_vec_i         = 64'h0000000000000000;
    assign tied_to_vcc_i                = 1'b1;
    assign tied_to_vcc_vec_i            = 64'hffffffffffffffff;

    //-------------------  GTP Datapath byte mapping  -----------------
    
    
    // The GTP provides little endian data (first byte received on RXDATA[7:0])     
    assign  RXDATA0_OUT    =   rxdata0_i;

    // The GTP transmits little endian data (TXDATA[7:0] transmitted first)     
    assign  txdata0_i    =   TXDATA0_IN;
    
    // The GTP provides little endian data (first byte received on RXDATA[7:0])     
    assign  RXDATA1_OUT    =   rxdata1_i;

    // The GTP transmits little endian data (TXDATA[7:0] transmitted first)     
    assign  txdata1_i    =   TXDATA1_IN;
    
    //-------------------------  Electrical Idle Reset Circuit  ---------------

    assign  RESETDONE0_OUT              =   resetdone0_i;
    assign  loopback0_i                 =   LOOPBACK0_IN;
    assign  RESETDONE1_OUT              =   resetdone1_i;
    assign  loopback1_i                 =   LOOPBACK1_IN;

    //Drive RXELECIDLERESET with elec idle reset enabled during normal operation when RXELECIDLE goes high
    assign  rxelecidlereset0_i          =  (rxelecidle0_i && resetdone0_i) && !serialloopback0_i;
    assign  rxelecidlereset1_i          =  (rxelecidle1_i && resetdone1_i) && !serialloopback1_i;
    assign  rxenelecidleresetb_i        =   !(rxelecidlereset0_i||rxelecidlereset1_i);  
    assign  serialloopback0_i           =   !loopback0_i[0] && loopback0_i[1] && !loopback0_i[2];
    assign  serialloopback1_i           =   !loopback1_i[0] && loopback1_i[1] && !loopback1_i[2];

    wire recclk;

    //------------------------- GT11 Instantiations  --------------------------   

    GTP_DUAL # 
    (
        //_______________________ Simulation-Only Attributes __________________

        .SIM_GTPRESET_SPEEDUP        (1'b1),
        .SIM_PLL_PERDIV2             (1'b1),

        //___________________________ Shared Attributes _______________________

        //---------------------- Tile and PLL Attributes ----------------------

        .CLK25_DIVIDER               (10), 
        .CLKINDC_B                   ("TRUE"),   
        .OOB_CLK_DIVIDER             (6),
        .OVERSAMPLE_MODE             ("FALSE"),
        .PLL_DIVSEL_FB               (2),
        .PLL_DIVSEL_REF              (1),
        .PLL_TXDIVSEL_COMM_OUT       (1),
        .TX_SYNC_FILTERB             (1),


        //______________________ Transmit Interface Attributes ________________

        //----------------- TX Buffering and Phase Alignment ------------------   

        .TX_BUFFER_USE_0            ("TRUE"),
        .TX_XCLK_SEL_0              ("TXOUT"),
        .TXRX_INVERT_0              (5'b00000),                

        .TX_BUFFER_USE_1            ("TRUE"),
        .TX_XCLK_SEL_1              ("TXOUT"),
        .TXRX_INVERT_1              (5'b00000),                

        //------------------- TX Serial Line Rate settings --------------------   

        .PLL_TXDIVSEL_OUT_0         (1),

        .PLL_TXDIVSEL_OUT_1         (1), 

        //------------------- TX Driver and OOB signalling --------------------  

         .TX_DIFF_BOOST_0           (DIFF_BOOST),
         .TX_DIFF_BOOST_1           (DIFF_BOOST),

        //---------------- TX Pipe Control for PCI Express/SATA ---------------

        .COM_BURST_VAL_0            (4'b1111),

        .COM_BURST_VAL_1            (4'b1111),

        //_______________________ Receive Interface Attributes ________________

        //---------- RX Driver,OOB signalling,Coupling and Eq.,CDR ------------  

        .AC_CAP_DIS_0               ("TRUE"),
        .OOBDETECT_THRESHOLD_0      (3'b001),
        .PMA_CDR_SCAN_0             (27'h6c07640), 
        //.PMA_RX_CFG_0               (25'h09f0089),
        .PMA_RX_CFG_0               (25'h09f0088),
        .RCV_TERM_GND_0             ("FALSE"),
        .RCV_TERM_MID_0             ("FALSE"),
        .RCV_TERM_VTTRX_0           ("FALSE"),
        .TERMINATION_IMP_0          (50),

        .AC_CAP_DIS_1               ("TRUE"),
        .OOBDETECT_THRESHOLD_1      (3'b001),
        .PMA_CDR_SCAN_1             (27'h6c07640), 
        .PMA_RX_CFG_1               (25'h09f0088),  
        .RCV_TERM_GND_1             ("FALSE"),
        .RCV_TERM_MID_1             ("FALSE"),
        .RCV_TERM_VTTRX_1           ("FALSE"),
        .TERMINATION_IMP_1          (50),

        //.PCS_COM_CFG                (28'h1680a0e),
        .TERMINATION_CTRL           (5'b10100),
        .TERMINATION_OVRD           ("FALSE"),

        //------------------- RX Serial Line Rate Settings --------------------   

        .PLL_RXDIVSEL_OUT_0         (1),
        .PLL_SATA_0                 ("FALSE"),

        .PLL_RXDIVSEL_OUT_1         (1),
        .PLL_SATA_1                 ("FALSE"),


        //------------------------- PRBS Detection ----------------------------  

        .PRBS_ERR_THRESHOLD_0       (32'h00000001),

        .PRBS_ERR_THRESHOLD_1       (32'h00000001),

        //------------------- Comma Detection and Alignment -------------------  

        .ALIGN_COMMA_WORD_0         (1),
        .COMMA_10B_ENABLE_0         (10'b0001111111),
        .COMMA_DOUBLE_0             ("FALSE"),
        .DEC_MCOMMA_DETECT_0        ("TRUE"),
        .DEC_PCOMMA_DETECT_0        ("TRUE"),
        .DEC_VALID_COMMA_ONLY_0     ("TRUE"),
        .MCOMMA_10B_VALUE_0         (10'b1010000011),
        .MCOMMA_DETECT_0            ("TRUE"),
        .PCOMMA_10B_VALUE_0         (10'b0101111100),
        .PCOMMA_DETECT_0            ("TRUE"),
        .RX_SLIDE_MODE_0            ("PCS"),

        .ALIGN_COMMA_WORD_1         (1),
        .COMMA_10B_ENABLE_1         (10'b0001111111),
        .COMMA_DOUBLE_1             ("FALSE"),
        .DEC_MCOMMA_DETECT_1        ("TRUE"),
        .DEC_PCOMMA_DETECT_1        ("TRUE"),
        .DEC_VALID_COMMA_ONLY_1     ("TRUE"),
        .MCOMMA_10B_VALUE_1         (10'b1010000011),
        .MCOMMA_DETECT_1            ("TRUE"),
        .PCOMMA_10B_VALUE_1         (10'b0101111100),
        .PCOMMA_DETECT_1            ("TRUE"),
        .RX_SLIDE_MODE_1            ("PCS"),


        //------------------- RX Loss-of-sync State Machine -------------------  

        
        .RX_LOSS_OF_SYNC_FSM_0      ("TRUE"),
        
        .RX_LOS_INVALID_INCR_0      (8),
        .RX_LOS_THRESHOLD_0         (128),

        
        .RX_LOSS_OF_SYNC_FSM_1      ("TRUE"),
                
        .RX_LOS_INVALID_INCR_1      (8),
        .RX_LOS_THRESHOLD_1         (128),

        //------------ RX Elastic Buffer and Phase alignment ports ------------   

        .RX_BUFFER_USE_0            ("TRUE"),
        .RX_XCLK_SEL_0              ("RXREC"),

        .RX_BUFFER_USE_1            ("TRUE"),
        .RX_XCLK_SEL_1              ("RXREC"),

        //--------------------- Clock Correction Attributes -------------------   

        .CLK_CORRECT_USE_0          ("TRUE"),
        .CLK_COR_ADJ_LEN_0          (1),
        .CLK_COR_DET_LEN_0          (1),
        .CLK_COR_INSERT_IDLE_FLAG_0 ("FALSE"),
        .CLK_COR_KEEP_IDLE_0        ("FALSE"),
        .CLK_COR_MAX_LAT_0          (18),
        .CLK_COR_MIN_LAT_0          (16),
        .CLK_COR_PRECEDENCE_0       ("TRUE"),
        .CLK_COR_REPEAT_WAIT_0      (0),
        .CLK_COR_SEQ_1_1_0          (10'b0100011100),
        .CLK_COR_SEQ_1_2_0          (10'b0000000000),
        .CLK_COR_SEQ_1_3_0          (10'b0000000000),
        .CLK_COR_SEQ_1_4_0          (10'b0000000000),
        .CLK_COR_SEQ_1_ENABLE_0     (4'b0001),
        .CLK_COR_SEQ_2_1_0          (10'b0000000000),
        .CLK_COR_SEQ_2_2_0          (10'b0000000000),
        .CLK_COR_SEQ_2_3_0          (10'b0000000000),
        .CLK_COR_SEQ_2_4_0          (10'b0000000000),
        .CLK_COR_SEQ_2_ENABLE_0     (4'b0000),
        .CLK_COR_SEQ_2_USE_0        ("FALSE"),
        .RX_DECODE_SEQ_MATCH_0      ("TRUE"),

        .CLK_CORRECT_USE_1          ("TRUE"),
        .CLK_COR_ADJ_LEN_1          (1),
        .CLK_COR_DET_LEN_1          (1),
        .CLK_COR_INSERT_IDLE_FLAG_1 ("FALSE"),
        .CLK_COR_KEEP_IDLE_1        ("FALSE"),
        .CLK_COR_MAX_LAT_1          (18),
        .CLK_COR_MIN_LAT_1          (16),
        .CLK_COR_PRECEDENCE_1       ("TRUE"),
        .CLK_COR_REPEAT_WAIT_1      (0),
        .CLK_COR_SEQ_1_1_1          (10'b0100011100),
        .CLK_COR_SEQ_1_2_1          (10'b0000000000),
        .CLK_COR_SEQ_1_3_1          (10'b0000000000),
        .CLK_COR_SEQ_1_4_1          (10'b0000000000),
        .CLK_COR_SEQ_1_ENABLE_1     (4'b0001),
        .CLK_COR_SEQ_2_1_1          (10'b0000000000),
        .CLK_COR_SEQ_2_2_1          (10'b0000000000),
        .CLK_COR_SEQ_2_3_1          (10'b0000000000),
        .CLK_COR_SEQ_2_4_1          (10'b0000000000),
        .CLK_COR_SEQ_2_ENABLE_1     (4'b0000),
        .CLK_COR_SEQ_2_USE_1        ("FALSE"),
        .RX_DECODE_SEQ_MATCH_1      ("TRUE"),

        //-------------------- Channel Bonding Attributes ---------------------   

        .CHAN_BOND_1_MAX_SKEW_0     (7),
        .CHAN_BOND_2_MAX_SKEW_0     (7),
        .CHAN_BOND_LEVEL_0          (TILE_CHAN_BOND_LEVEL_0),
        .CHAN_BOND_MODE_0           (TILE_CHAN_BOND_MODE_0),
        .CHAN_BOND_SEQ_1_1_0        (10'b0101111100),
        .CHAN_BOND_SEQ_1_2_0        (10'b0000000000),
        .CHAN_BOND_SEQ_1_3_0        (10'b0000000000),
        .CHAN_BOND_SEQ_1_4_0        (10'b0000000000),
        .CHAN_BOND_SEQ_1_ENABLE_0   (4'b0001),
        .CHAN_BOND_SEQ_2_1_0        (10'b0000000000),
        .CHAN_BOND_SEQ_2_2_0        (10'b0000000000),
        .CHAN_BOND_SEQ_2_3_0        (10'b0000000000),
        .CHAN_BOND_SEQ_2_4_0        (10'b0000000000),
        .CHAN_BOND_SEQ_2_ENABLE_0   (4'b0000),
        .CHAN_BOND_SEQ_2_USE_0      ("FALSE"),  
        .CHAN_BOND_SEQ_LEN_0        (1),
        .PCI_EXPRESS_MODE_0         ("FALSE"),     
     
        .CHAN_BOND_1_MAX_SKEW_1     (7),
        .CHAN_BOND_2_MAX_SKEW_1     (7),
        .CHAN_BOND_LEVEL_1          (TILE_CHAN_BOND_LEVEL_1),
        .CHAN_BOND_MODE_1           (TILE_CHAN_BOND_MODE_1),
        .CHAN_BOND_SEQ_1_1_1        (10'b0101111100),
        .CHAN_BOND_SEQ_1_2_1        (10'b0000000000),
        .CHAN_BOND_SEQ_1_3_1        (10'b0000000000),
        .CHAN_BOND_SEQ_1_4_1        (10'b0000000000),
        .CHAN_BOND_SEQ_1_ENABLE_1   (4'b0001),
        .CHAN_BOND_SEQ_2_1_1        (10'b0000000000),
        .CHAN_BOND_SEQ_2_2_1        (10'b0000000000),
        .CHAN_BOND_SEQ_2_3_1        (10'b0000000000),
        .CHAN_BOND_SEQ_2_4_1        (10'b0000000000),
        .CHAN_BOND_SEQ_2_ENABLE_1   (4'b0000),
        .CHAN_BOND_SEQ_2_USE_1      ("FALSE"),  
        .CHAN_BOND_SEQ_LEN_1        (1),
        .PCI_EXPRESS_MODE_1         ("FALSE"),

        //---------------- RX Attributes for PCI Express/SATA ---------------

        .RX_STATUS_FMT_0            ("PCIE"),
        .SATA_BURST_VAL_0           (3'b100),
        .SATA_IDLE_VAL_0            (3'b100),
        .SATA_MAX_BURST_0           (7),
        .SATA_MAX_INIT_0            (22),
        .SATA_MAX_WAKE_0            (7),
        .SATA_MIN_BURST_0           (4),
        .SATA_MIN_INIT_0            (12),
        .SATA_MIN_WAKE_0            (4),
        .TRANS_TIME_FROM_P2_0       (16'h0060),
        .TRANS_TIME_NON_P2_0        (16'h0025),
        .TRANS_TIME_TO_P2_0         (16'h0100),

        .RX_STATUS_FMT_1            ("PCIE"),
        .SATA_BURST_VAL_1           (3'b100),
        .SATA_IDLE_VAL_1            (3'b100),
        .SATA_MAX_BURST_1           (7),
        .SATA_MAX_INIT_1            (22),
        .SATA_MAX_WAKE_1            (7),
        .SATA_MIN_BURST_1           (4),
        .SATA_MIN_INIT_1            (12),
        .SATA_MIN_WAKE_1            (4),
        .TRANS_TIME_FROM_P2_1       (16'h0060),
        .TRANS_TIME_NON_P2_1        (16'h0025),
        .TRANS_TIME_TO_P2_1         (16'h0100)     
     ) 
     gtp_dual_i 
     (


    //---------------------- Loopback and Powerdown Ports ----------------------

        .LOOPBACK0                  (loopback0_i),
        .LOOPBACK1                  (loopback1_i),
        .RXPOWERDOWN0               (RXPOWERDOWN0_IN),
        .RXPOWERDOWN1               (RXPOWERDOWN1_IN),
        .TXPOWERDOWN0               (TXPOWERDOWN0_IN),
        .TXPOWERDOWN1               (TXPOWERDOWN1_IN),

    //--------------------- Receive Ports - 8b10b Decoder ----------------------

        .RXCHARISCOMMA0             (RXCHARISCOMMA0_OUT),
        .RXCHARISCOMMA1             (RXCHARISCOMMA1_OUT),
        .RXCHARISK0                 (RXCHARISK0_OUT),
        .RXCHARISK1                 (RXCHARISK1_OUT),
        .RXDEC8B10BUSE0             (tied_to_vcc_i),
        .RXDEC8B10BUSE1             (tied_to_vcc_i),
        .RXDISPERR0                 (RXDISPERR0_OUT),
        .RXDISPERR1                 (RXDISPERR1_OUT),
        .RXNOTINTABLE0              (RXNOTINTABLE0_OUT),
        .RXNOTINTABLE1              (RXNOTINTABLE1_OUT),
        .RXRUNDISP0                 ( ),
        .RXRUNDISP1                 ( ),

    //----------------- Receive Ports - Channel Bonding Ports ------------------

        .RXCHANBONDSEQ0             (RXCHANBONDSEQ0_OUT),
        .RXCHANBONDSEQ1             (RXCHANBONDSEQ1_OUT),
        .RXCHBONDI0                 (RXCHBONDI0_IN),
        .RXCHBONDI1                 (RXCHBONDI1_IN),
        .RXCHBONDO0                 (RXCHBONDO0_OUT),
        .RXCHBONDO1                 (RXCHBONDO1_OUT),
        .RXENCHANSYNC0              (RXENCHANSYNC0_IN),
        .RXENCHANSYNC1              (RXENCHANSYNC1_IN),

    //----------------- Receive Ports - Clock Correction Ports -----------------

        .RXCLKCORCNT0               (RXCLKCORCNT0_OUT),
        .RXCLKCORCNT1               (RXCLKCORCNT1_OUT),

    //------------- Receive Ports - Comma Detection and Alignment --------------

        .RXBYTEISALIGNED0           (RXBYTEISALIGNED0_OUT),
        .RXBYTEISALIGNED1           (RXBYTEISALIGNED1_OUT),
        .RXBYTEREALIGN0             (RXBYTEREALIGN0_OUT),
        .RXBYTEREALIGN1             (RXBYTEREALIGN1_OUT),
        .RXCOMMADET0                (RXCOMMADET0_OUT),
        .RXCOMMADET1                (RXCOMMADET1_OUT),
        .RXCOMMADETUSE0             (tied_to_vcc_i),
        .RXCOMMADETUSE1             (tied_to_vcc_i),
        .RXENMCOMMAALIGN0           (RXENMCOMMAALIGN0_IN),
        .RXENMCOMMAALIGN1           (RXENMCOMMAALIGN1_IN),
        .RXENPCOMMAALIGN0           (RXENPCOMMAALIGN0_IN),
        .RXENPCOMMAALIGN1           (RXENPCOMMAALIGN1_IN),
        .RXSLIDE0                   (tied_to_ground_i),
        .RXSLIDE1                   (tied_to_ground_i),

    //--------------------- Receive Ports - PRBS Detection ---------------------

        .PRBSCNTRESET0              (tied_to_ground_i),
        .PRBSCNTRESET1              (tied_to_ground_i),
        .RXENPRBSTST0               (tied_to_ground_vec_i[1:0]),
        .RXENPRBSTST1               (tied_to_ground_vec_i[1:0]),
        .RXPRBSERR0                 ( ),
        .RXPRBSERR1                 ( ),

    //----------------- Receive Ports - RX Data Path interface -----------------

        .RXDATA0                    (rxdata0_i),
        .RXDATA1                    (rxdata1_i),
        .RXDATAWIDTH0               (tied_to_vcc_i),
        .RXDATAWIDTH1               (tied_to_vcc_i),
        .RXRECCLK0                  (recclk),
        .RXRECCLK1                  ( ),
        .RXRESET0                   (tied_to_ground_i),
        .RXRESET1                   (tied_to_ground_i),
        .RXUSRCLK0                  (RXUSRCLK0_IN),
        .RXUSRCLK1                  (RXUSRCLK1_IN),
        .RXUSRCLK20                 (RXUSRCLK20_IN),
        .RXUSRCLK21                 (RXUSRCLK21_IN),

    //----- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------

        .RXCDRRESET0                (RXCDRRESET0_IN),
        .RXCDRRESET1                (RXCDRRESET1_IN),
        .RXELECIDLE0                (rxelecidle0_i),
        .RXELECIDLE1                (rxelecidle1_i),
        .RXELECIDLERESET0           (rxelecidlereset0_i),
        .RXELECIDLERESET1           (rxelecidlereset1_i),
        .RXENEQB0                   (1'b0),
        .RXENEQB1                   (1'b0),
        .RXEQMIX0                   (rxeqmix),
        .RXEQMIX1                   (rxeqmix),
        .RXEQPOLE0                  (rxeqpole),
        .RXEQPOLE1                  (rxeqpole),
        .RXN0                       (RXN0_IN),
        .RXN1                       (RXN1_IN),
        .RXP0                       (RXP0_IN),
        .RXP1                       (RXP1_IN),

    //------ Receive Ports - RX Elastic Buffer and Phase Alignment Ports -------

        .RXBUFRESET0                (RXBUFRESET0_IN),
        .RXBUFRESET1                (RXBUFRESET1_IN),
        .RXBUFSTATUS0               (RXBUFSTATUS0_OUT),
        .RXBUFSTATUS1               (RXBUFSTATUS1_OUT),
        .RXCHANISALIGNED0           (RXCHANISALIGNED0_OUT),
        .RXCHANISALIGNED1           (RXCHANISALIGNED1_OUT),
        .RXCHANREALIGN0             (RXCHANREALIGN0_OUT),
        .RXCHANREALIGN1             (RXCHANREALIGN1_OUT),
        .RXPMASETPHASE0             (tied_to_ground_i),
        .RXPMASETPHASE1             (tied_to_ground_i),
        .RXSTATUS0                  ( ),
        .RXSTATUS1                  ( ),

    //------------- Receive Ports - RX Loss-of-sync State Machine --------------

        .RXLOSSOFSYNC0              (RXLOSSOFSYNC0_OUT),
        .RXLOSSOFSYNC1              (RXLOSSOFSYNC1_OUT),

    //-------------------- Receive Ports - RX Oversampling ---------------------

        .RXENSAMPLEALIGN0           (tied_to_ground_i),
        .RXENSAMPLEALIGN1           (tied_to_ground_i),
        .RXOVERSAMPLEERR0           ( ),
        .RXOVERSAMPLEERR1           ( ),

    //------------ Receive Ports - RX Pipe Control for PCI Express -------------

        .PHYSTATUS0                 ( ),
        .PHYSTATUS1                 ( ),
        .RXVALID0                   ( ),
        .RXVALID1                   ( ),

    //--------------- Receive Ports - RX Polarity Control Ports ----------------

        .RXPOLARITY0                (polarity_hack_rx_0),
        .RXPOLARITY1                (polarity_hack_rx_1),

    //----------- Shared Ports - Dynamic Reconfiguration Port (DRP) ------------

        .DADDR                      (DADDR_IN),
        .DCLK                       (DCLK_IN),
        .DEN                        (DEN_IN),
        .DI                         (DI_IN),
        .DO                         (DO_OUT),
        .DRDY                       (DRDY_OUT),
        .DWE                        (DWE_IN),

    //------------------- Shared Ports - Tile and PLL Ports --------------------

        .CLKIN                      (CLKIN_IN),
        .GTPRESET                   (GTPRESET_IN),
        .GTPTEST                    (tied_to_ground_vec_i[3:0]),
        .INTDATAWIDTH               (tied_to_vcc_i),
        .PLLLKDET                   (PLLLKDET_OUT),
        .PLLLKDETEN                 (tied_to_vcc_i),
        .PLLPOWERDOWN               (tied_to_ground_i),
        .REFCLKOUT                  (REFCLKOUT_OUT),
        .REFCLKPWRDNB               (tied_to_vcc_i),
        .RESETDONE0                 (resetdone0_i),
        .RESETDONE1                 (resetdone1_i),
        .RXENELECIDLERESETB         (rxenelecidleresetb_i),
        .TXENPMAPHASEALIGN          (TXENPMAPHASEALIGN_IN),
        .TXPMASETPHASE              (TXPMASETPHASE_IN),

    //-------------- Transmit Ports - 8b10b Encoder Control Ports --------------

        .TXBYPASS8B10B0             (tied_to_ground_vec_i[1:0]),
        .TXBYPASS8B10B1             (tied_to_ground_vec_i[1:0]),
        .TXCHARDISPMODE0            (tied_to_ground_vec_i[1:0]),
        .TXCHARDISPMODE1            (tied_to_ground_vec_i[1:0]),
        .TXCHARDISPVAL0             (tied_to_ground_vec_i[1:0]),
        .TXCHARDISPVAL1             (tied_to_ground_vec_i[1:0]),
        .TXCHARISK0                 (TXCHARISK0_IN),
        .TXCHARISK1                 (TXCHARISK1_IN),
        .TXENC8B10BUSE0             (tied_to_vcc_i),
        .TXENC8B10BUSE1             (tied_to_vcc_i),
        .TXKERR0                    ( ),
        .TXKERR1                    ( ),
        .TXRUNDISP0                 ( ),
        .TXRUNDISP1                 ( ),

    //----------- Transmit Ports - TX Buffering and Phase Alignment ------------

        .TXBUFSTATUS0               (),
        .TXBUFSTATUS1               (),

    //---------------- Transmit Ports - TX Data Path interface -----------------

        .TXDATA0                    (txdata0_i),
        .TXDATA1                    (txdata1_i),
        .TXDATAWIDTH0               (tied_to_vcc_i),
        .TXDATAWIDTH1               (tied_to_vcc_i),
        .TXOUTCLK0                  (),
        .TXOUTCLK1                  (),
        .TXRESET0                   (tied_to_ground_i),
        .TXRESET1                   (tied_to_ground_i),
        .TXUSRCLK0                  (TXUSRCLK0_IN),
        .TXUSRCLK1                  (TXUSRCLK1_IN),
        .TXUSRCLK20                 (TXUSRCLK20_IN),
        .TXUSRCLK21                 (TXUSRCLK21_IN),

    //------------- Transmit Ports - TX Driver and OOB signalling --------------

        .TXBUFDIFFCTRL0             (txdiffctrl),
        .TXBUFDIFFCTRL1             (txdiffctrl),
        .TXDIFFCTRL0                (txdiffctrl),
        .TXDIFFCTRL1                (txdiffctrl),
        .TXINHIBIT0                 (tied_to_ground_i),
        .TXINHIBIT1                 (tied_to_ground_i),
        .TXN0                       (TXN0_OUT),
        .TXN1                       (TXN1_OUT),
        .TXP0                       (TXP0_OUT),
        .TXP1                       (TXP1_OUT),
        .TXPREEMPHASIS0             (txpreemphasis),
        .TXPREEMPHASIS1             (txpreemphasis),

//       .TXPREEMPHASIS0             (3'b011),
//       .TXPREEMPHASIS1             (3'b011),

    //------------------- Transmit Ports - TX PRBS Generator -------------------

        .TXENPRBSTST0               (tied_to_ground_vec_i[1:0]),
        .TXENPRBSTST1               (tied_to_ground_vec_i[1:0]),

    //------------------ Transmit Ports - TX Polarity Control ------------------

        .TXPOLARITY0                (polarity_hack_tx_0),
        .TXPOLARITY1                (polarity_hack_tx_1),

    //--------------- Transmit Ports - TX Ports for PCI Express ----------------

        .TXDETECTRX0                (tied_to_ground_i),
        .TXDETECTRX1                (tied_to_ground_i),
        .TXELECIDLE0                (tied_to_ground_i),
        .TXELECIDLE1                (tied_to_ground_i),

    //------------------- Transmit Ports - TX Ports for SATA -------------------

        .TXCOMSTART0                (tied_to_ground_i),
        .TXCOMSTART1                (tied_to_ground_i),
        .TXCOMTYPE0                 (tied_to_ground_i),
        .TXCOMTYPE1                 (tied_to_ground_i)
     );
endmodule
