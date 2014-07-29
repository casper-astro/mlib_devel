module gtx_quad(
    input   [2:0] LOOPBACK_IN,
    input         RXPOWERDOWN_IN,
    input         TXPOWERDOWN_IN,
    output  [7:0] RXCHARISCOMMA_OUT,
    output  [7:0] RXCHARISK_OUT,
    output  [7:0] RXDISPERR_OUT,
    output  [7:0] RXNOTINTABLE_OUT,
    input   [3:0] RXENMCOMMAALIGN_IN,
    input   [3:0] RXENPCOMMAALIGN_IN,
    input         RXENCHANSYNC_IN,
    output [63:0] RXDATA_OUT,
    input         RXRESET_IN,
    input         RXUSRCLK2_IN,
    output  [3:0] RXELECIDLE_OUT,
    input   [2:0] RXEQMIX_IN,
    input   [3:0] RXN_IN,
    input   [3:0] RXP_IN,
    input         RXBUFRESET_IN,
    output  [3:0] RXBUFSTATUS_OUT,
    output  [7:0] RXLOSSOFSYNC_OUT,
    input   [3:0] RXPOLARITY_IN,
    input         GTXRXRESET_IN,
    input         MGTREFCLKRX_IN,
    input         PLLRXRESET_IN,
    output  [3:0] RXPLLLKDET_OUT,
    output  [3:0] RXRESETDONE_OUT,
    input   [7:0] TXCHARISK_IN,
    input  [63:0] TXDATA_IN,
    output  [3:0] TXOUTCLK_OUT,
    input         TXRESET_IN,
    input         TXUSRCLK2_IN,
    input   [3:0] TXDIFFCTRL_IN,
    output  [3:0] TXN_OUT,
    output  [3:0] TXP_OUT,
    input   [4:0] TXPOSTEMPHASIS_IN,
    input   [3:0] TXPREEMPHASIS_IN,
    input         GTXTXRESET_IN,
    input         MGTREFCLKTX_IN,
    input         PLLTXRESET_IN,
    output  [3:0] TXRESETDONE_OUT
  );

  //Channel bonding signals
  wire       RXCHANBONDSEQ_OUT    [3:0];
  wire [3:0] RXCHBONDI_IN         [3:0];
  wire [2:0] RXCHBONDLEVEL_IN     [3:0];
  wire       RXCHBONDMASTER_IN    [3:0];
  wire [3:0] RXCHBONDO_OUT        [3:0];
  wire       RXCHBONDSLAVE_IN     [3:0];

  assign RXCHBONDI_IN[0] = RXCHBONDO_OUT[1];
  assign RXCHBONDI_IN[1] = RXCHBONDO_OUT[2];
  assign RXCHBONDI_IN[2] = 4'b0000;
  assign RXCHBONDI_IN[3] = RXCHBONDO_OUT[2];

  assign RXCHBONDLEVEL_IN[0] = 3'd0;
  assign RXCHBONDLEVEL_IN[1] = 3'd1;
  assign RXCHBONDLEVEL_IN[2] = 3'd2;
  assign RXCHBONDLEVEL_IN[3] = 3'd1;

  assign RXCHBONDMASTER_IN[0] = 1'b0;
  assign RXCHBONDMASTER_IN[1] = 1'b0;
  assign RXCHBONDMASTER_IN[2] = 1'b1;
  assign RXCHBONDMASTER_IN[3] = 1'b0;

  assign RXCHBONDSLAVE_IN[0] = 1'b1;
  assign RXCHBONDSLAVE_IN[1] = 1'b1;
  assign RXCHBONDSLAVE_IN[2] = 1'b0;
  assign RXCHBONDSLAVE_IN[3] = 1'b1;

  //RX Datapath signals
  wire [15:0] rxdata_float_i        [3:0];
  wire  [1:0] rxchariscomma_float_i [3:0];
  wire  [1:0] rxcharisk_float_i     [3:0];
  wire  [1:0] rxdisperr_float_i     [3:0];
  wire  [1:0] rxnotintable_float_i  [3:0];

  wire  [1:0] rxbufstatus_float_i   [3:0];

  genvar I;

generate for (I=0; I < 4; I=I+1) begin : gen_xaui_gtx
  GTXE1 #(
    //_______________________ Simulation-Only Attributes __________________
    .SIM_RECEIVER_DETECT_PASS               ("TRUE"),
    .SIM_TX_ELEC_IDLE_LEVEL                 ("X"),
    .SIM_VERSION                            ("1.0"),
    .SIM_TXREFCLK_SOURCE                    (3'b000),
    .SIM_RXREFCLK_SOURCE                    (3'b000),
    //--------------------------TX PLL----------------------------
    .TX_CLK_SOURCE                          ("RXPLL"),
    .TX_OVERSAMPLE_MODE                     ("FALSE"),
    .TXPLL_COM_CFG                          (24'h21680a),
    .TXPLL_CP_CFG                           (8'h0D),
    .TXPLL_DIVSEL_FB                        (2),
    .TXPLL_DIVSEL_OUT                       (1),
    .TXPLL_DIVSEL_REF                       (1),
    .TXPLL_DIVSEL45_FB                      (5),
    .TXPLL_LKDET_CFG                        (3'b111),
    .TX_CLK25_DIVIDER                       (7),
    .TXPLL_SATA                             (2'b00),
    .TX_TDCC_CFG                            (2'b11),
    .PMA_CAS_CLK_EN                         ("FALSE"),            
    .POWER_SAVE                             (10'b0000110100),
                                             
    //-----------------------TX Interface-------------------------
    .GEN_TXUSRCLK                           ("TRUE"),
    .TX_DATA_WIDTH                          (20),
    .TX_USRCLK_CFG                          (6'h00),
    .TXOUTCLK_CTRL                          ("TXPLLREFCLK_DIV1"),
    .TXOUTCLK_DLY                           (10'b0000000000),            
    //------------TX Buffering and Phase Alignment----------------
    .TX_PMADATA_OPT                         (1'b0),
    .PMA_TX_CFG                             (20'h80082),
    .TX_BUFFER_USE                          ("TRUE"),
    .TX_BYTECLK_CFG                         (6'h00),
    .TX_EN_RATE_RESET_BUF                   ("TRUE"),
    .TX_XCLK_SEL                            ("TXOUT"),
    .TX_DLYALIGN_CTRINC                     (4'b0100),
    .TX_DLYALIGN_LPFINC                     (4'b0110),
    .TX_DLYALIGN_MONSEL                     (3'b000),
    .TX_DLYALIGN_OVRDSETTING                (8'b10000000),
    //-----------------------TX Gearbox---------------------------
    .GEARBOX_ENDEC                          (3'b000),
    .TXGEARBOX_USE                          ("FALSE"),
    //--------------TX Driver and OOB Signalling------------------
    .TX_DRIVE_MODE                          ("DIRECT"),
    .TX_IDLE_ASSERT_DELAY                   (3'b101),
    .TX_IDLE_DEASSERT_DELAY                 (3'b011),
    .TXDRIVE_LOOPBACK_HIZ                   ("FALSE"),
    .TXDRIVE_LOOPBACK_PD                    ("FALSE"),
    //------------TX Pipe Control for PCI Express/SATA------------
    .COM_BURST_VAL                          (4'b1111),
    //----------------TX Attributes for PCI Express---------------
    .TX_DEEMPH_0                            (5'b11010),
    .TX_DEEMPH_1                            (5'b10000),
    .TX_MARGIN_FULL_0                       (7'b1001110),
    .TX_MARGIN_FULL_1                       (7'b1001001),
    .TX_MARGIN_FULL_2                       (7'b1000101),
    .TX_MARGIN_FULL_3                       (7'b1000010),
    .TX_MARGIN_FULL_4                       (7'b1000000),
    .TX_MARGIN_LOW_0                        (7'b1000110),
    .TX_MARGIN_LOW_1                        (7'b1000100),
    .TX_MARGIN_LOW_2                        (7'b1000010),
    .TX_MARGIN_LOW_3                        (7'b1000000),
    .TX_MARGIN_LOW_4                        (7'b1000000),
    //--------------------------RX PLL----------------------------
    .RX_OVERSAMPLE_MODE                     ("FALSE"),
    .RXPLL_COM_CFG                          (24'h21680a),
    .RXPLL_CP_CFG                           (8'h0D),
    .RXPLL_DIVSEL_FB                        (2),
    .RXPLL_DIVSEL_OUT                       (1),
    .RXPLL_DIVSEL_REF                       (1),
    .RXPLL_DIVSEL45_FB                      (5),
    .RXPLL_LKDET_CFG                        (3'b111),
    .RX_CLK25_DIVIDER                       (7),
    //-----------------------RX Interface-------------------------
    .GEN_RXUSRCLK                           ("TRUE"),
    .RX_DATA_WIDTH                          (20),
    .RXRECCLK_CTRL                          ("RXRECCLKPMA_DIV2"),
    .RXRECCLK_DLY                           (10'b0000000000),
    .RXUSRCLK_DLY                           (16'h0000),            
    //--------RX Driver,OOB signalling,Coupling and Eq.,CDR-------
    .AC_CAP_DIS                             ("TRUE"),
    .CDR_PH_ADJ_TIME                        (5'b10100),
    .OOBDETECT_THRESHOLD                    (3'b011),
    .PMA_CDR_SCAN                           (27'h640404C),
    .PMA_RX_CFG                             (25'h05ce048),
    .RCV_TERM_GND                           ("FALSE"),
    .RCV_TERM_VTTRX                         ("FALSE"),
    .RX_EN_IDLE_HOLD_CDR                    ("FALSE"),
    .RX_EN_IDLE_RESET_FR                    ("TRUE"),
    .RX_EN_IDLE_RESET_PH                    ("TRUE"),
    .TX_DETECT_RX_CFG                       (14'h1832),            
    .TERMINATION_CTRL                       (5'b00000),
    .TERMINATION_OVRD                       ("FALSE"),
    .CM_TRIM                                (2'b01),
    .PMA_RXSYNC_CFG                         (7'h00),
    .PMA_CFG                                (76'h0040000040000000003),
    .BGTEST_CFG                             (2'b00),
    .BIAS_CFG                               (17'h00000),            
    //------------RX Decision Feedback Equalizer(DFE)-------------
    .DFE_CAL_TIME                           (5'b01100),
    .DFE_CFG                                (8'b00011011),
    .RX_EN_IDLE_HOLD_DFE                    ("TRUE"),
    .RX_EYE_OFFSET                          (8'h4C),
    .RX_EYE_SCANMODE                        (2'b00),
    //-----------------------PRBS Detection-----------------------
    .RXPRBSERR_LOOPBACK                     (1'b0),
    //----------------Comma Detection and Alignment---------------
    .ALIGN_COMMA_WORD                       (1),
    .COMMA_10B_ENABLE                       (10'b0001111111),
    .COMMA_DOUBLE                           ("FALSE"),
    .DEC_MCOMMA_DETECT                      ("TRUE"),
    .DEC_PCOMMA_DETECT                      ("TRUE"),
    .DEC_VALID_COMMA_ONLY                   ("FALSE"),
    //.DEC_VALID_COMMA_ONLY                   ("TRUE"),
    .MCOMMA_10B_VALUE                       (10'b1010000011),
    .MCOMMA_DETECT                          ("TRUE"),
    .PCOMMA_10B_VALUE                       (10'b0101111100),
    .PCOMMA_DETECT                          ("TRUE"),
    .RX_DECODE_SEQ_MATCH                    ("TRUE"),
    .RX_SLIDE_AUTO_WAIT                     (5),
    .RX_SLIDE_MODE                          ("OFF"),
    .SHOW_REALIGN_COMMA                     ("FALSE"),
    //---------------RX Loss-of-sync State Machine----------------
    .RX_LOS_INVALID_INCR                    (1),
    .RX_LOS_THRESHOLD                       (4),
    .RX_LOSS_OF_SYNC_FSM                    ("TRUE"),
    //-----------------------RX Gearbox---------------------------
    .RXGEARBOX_USE                          ("FALSE"),
    //-----------RX Elastic Buffer and Phase alignment------------
    .RX_BUFFER_USE                          ("TRUE"),
    .RX_EN_IDLE_RESET_BUF                   ("TRUE"),
    .RX_EN_MODE_RESET_BUF                   ("TRUE"),
    .RX_EN_RATE_RESET_BUF                   ("TRUE"),
    .RX_EN_REALIGN_RESET_BUF                ("FALSE"),
    .RX_EN_REALIGN_RESET_BUF2               ("FALSE"),            
    .RX_FIFO_ADDR_MODE                      ("FULL"),
    .RX_IDLE_HI_CNT                         (4'b1000),
    .RX_IDLE_LO_CNT                         (4'b0000),
    .RX_XCLK_SEL                            ("RXREC"),
    .RX_DLYALIGN_CTRINC                     (4'b0100),
    .RX_DLYALIGN_EDGESET                    (5'b00010),
    .RX_DLYALIGN_LPFINC                     (4'b0110),
    .RX_DLYALIGN_MONSEL                     (3'b000),
    .RX_DLYALIGN_OVRDSETTING                (8'b10000000),
    //----------------------Clock Correction----------------------
    .CLK_COR_ADJ_LEN                        (1),
    .CLK_COR_DET_LEN                        (1),
    .CLK_COR_INSERT_IDLE_FLAG               ("FALSE"),
    .CLK_COR_KEEP_IDLE                      ("FALSE"),
    .CLK_COR_MAX_LAT                        (20),
    .CLK_COR_MIN_LAT                        (18),
    .CLK_COR_PRECEDENCE                     ("TRUE"),
    .CLK_COR_REPEAT_WAIT                    (0),
    .CLK_COR_SEQ_1_1                        (10'b0100011100),
    .CLK_COR_SEQ_1_2                        (10'b0000000000),
    .CLK_COR_SEQ_1_3                        (10'b0000000000),
    .CLK_COR_SEQ_1_4                        (10'b0000000000),
    .CLK_COR_SEQ_1_ENABLE                   (4'b1111),
    .CLK_COR_SEQ_2_1                        (10'b0000000000),
    .CLK_COR_SEQ_2_2                        (10'b0000000000),
    .CLK_COR_SEQ_2_3                        (10'b0000000000),
    .CLK_COR_SEQ_2_4                        (10'b0000000000),
    .CLK_COR_SEQ_2_ENABLE                   (4'b1111),
    .CLK_COR_SEQ_2_USE                      ("FALSE"),
    .CLK_CORRECT_USE                        ("TRUE"),
    //----------------------Channel Bonding----------------------
    .CHAN_BOND_1_MAX_SKEW                   (7),
    .CHAN_BOND_2_MAX_SKEW                   (1),
    .CHAN_BOND_KEEP_ALIGN                   ("FALSE"),
    .CHAN_BOND_SEQ_1_1                      (10'b0101111100),
    .CHAN_BOND_SEQ_1_2                      (10'b0000000000),
    .CHAN_BOND_SEQ_1_3                      (10'b0000000000),
    .CHAN_BOND_SEQ_1_4                      (10'b0000000000),
    .CHAN_BOND_SEQ_1_ENABLE                 (4'b1111),
    .CHAN_BOND_SEQ_2_1                      (10'b0000000000),
    .CHAN_BOND_SEQ_2_2                      (10'b0000000000),
    .CHAN_BOND_SEQ_2_3                      (10'b0000000000),
    .CHAN_BOND_SEQ_2_4                      (10'b0000000000),
    .CHAN_BOND_SEQ_2_CFG                    (5'b00000),
    .CHAN_BOND_SEQ_2_ENABLE                 (4'b1111),
    .CHAN_BOND_SEQ_2_USE                    ("FALSE"),
    .CHAN_BOND_SEQ_LEN                      (1),
    .PCI_EXPRESS_MODE                       ("FALSE"),
    //-----------RX Attributes for PCI Express/SATA/SAS----------
    .SAS_MAX_COMSAS                         (52),
    .SAS_MIN_COMSAS                         (40),
    .SATA_BURST_VAL                         (3'b100),
    .SATA_IDLE_VAL                          (3'b100),
    .SATA_MAX_BURST                         (7),
    .SATA_MAX_INIT                          (22),
    .SATA_MAX_WAKE                          (7),
    .SATA_MIN_BURST                         (4),
    .SATA_MIN_INIT                          (12),
    .SATA_MIN_WAKE                          (4),
    .TRANS_TIME_FROM_P2                     (12'h03c),
    .TRANS_TIME_NON_P2                      (8'h19),
    .TRANS_TIME_RATE                        (8'hff),
    .TRANS_TIME_TO_P2                       (10'h064)
  ) gtxe_xaui_inst (
    //---------------------- Loopback and Powerdown Ports ----------------------
    .LOOPBACK                       (LOOPBACK_IN),
    .RXPOWERDOWN                    ({2{RXPOWERDOWN_IN}}),
    .TXPOWERDOWN                    ({2{TXPOWERDOWN_IN}}),
    //------------ Receive Ports - 64b66b and 64b67b Gearbox Ports -------------
    .RXDATAVALID                    (),
    .RXGEARBOXSLIP                  (1'b0),
    .RXHEADER                       (),
    .RXHEADERVALID                  (),
    .RXSTARTOFSEQ                   (),
    //--------------------- Receive Ports - 8b10b Decoder ----------------------
    .RXCHARISCOMMA                  ({rxchariscomma_float_i[I], RXCHARISCOMMA_OUT[I*2+:2]}),
    .RXCHARISK                      ({rxcharisk_float_i[I], RXCHARISK_OUT[I*2+:2]}),
    .RXDEC8B10BUSE                  (1'b1),
    .RXDISPERR                      ({rxdisperr_float_i[I],RXDISPERR_OUT[I*2+:2]}),
    .RXNOTINTABLE                   ({rxnotintable_float_i[I],RXNOTINTABLE_OUT[I*2+:2]}),
    .RXRUNDISP                      (),
    .USRCODEERR                     (1'b0),
    //----------------- Receive Ports - Channel Bonding Ports ------------------
    .RXCHANBONDSEQ                  (RXCHANBONDSEQ_OUT[I]),
    .RXCHBONDI                      (RXCHBONDI_IN[I]),
    .RXCHBONDLEVEL                  (RXCHBONDLEVEL_IN[I]),
    .RXCHBONDMASTER                 (RXCHBONDMASTER_IN[I]),
    .RXCHBONDO                      (RXCHBONDO_OUT[I]),
    .RXCHBONDSLAVE                  (RXCHBONDSLAVE_IN[I]),
    .RXENCHANSYNC                   (RXENCHANSYNC_IN),
    //----------------- Receive Ports - Clock Correction Ports -----------------
    .RXCLKCORCNT                    (),
    //------------- Receive Ports - Comma Detection and Alignment --------------
    .RXBYTEISALIGNED                (),
    .RXBYTEREALIGN                  (),
    .RXCOMMADET                     (),
    .RXCOMMADETUSE                  (1'b1),
    .RXENMCOMMAALIGN                (RXENMCOMMAALIGN_IN[I]),
    .RXENPCOMMAALIGN                (RXENPCOMMAALIGN_IN[I]),
    .RXSLIDE                        (1'b0),
    //--------------------- Receive Ports - PRBS Detection ---------------------
    .PRBSCNTRESET                   (1'b0),
    .RXENPRBSTST                    (3'b000),
    .RXPRBSERR                      (),
    //----------------- Receive Ports - RX Data Path interface -----------------
    .RXDATA                         ({rxdata_float_i[I], RXDATA_OUT[I*16+:16]}),
    .RXRECCLK                       (),
    .RXRECCLKPCS                    (),
    .RXRESET                        (RXRESET_IN),
    .RXUSRCLK                       (1'b0),
    .RXUSRCLK2                      (RXUSRCLK2_IN),
    //---------- Receive Ports - RX Decision Feedback Equalizer(DFE) -----------
    .DFECLKDLYADJ                   (6'b0),
    .DFECLKDLYADJMON                (),
    .DFEDLYOVRD                     (1'b1),
    .DFEEYEDACMON                   (),
    .DFESENSCAL                     (),
    .DFETAP1                        (5'b0),
    .DFETAP1MONITOR                 (),
    .DFETAP2                        (5'b0),
    .DFETAP2MONITOR                 (),
    .DFETAP3                        (4'b0),
    .DFETAP3MONITOR                 (),
    .DFETAP4                        (4'b0),
    .DFETAP4MONITOR                 (),
    .DFETAPOVRD                     (1'b1),
    //----- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
    .GATERXELECIDLE                 (1'b0),
    .IGNORESIGDET                   (1'b0),
    //.RXCDRRESET                     (RXCDRRESET_IN),
    .RXCDRRESET                     (1'b0),
    .RXELECIDLE                     (RXELECIDLE_OUT[I]),
    .RXEQMIX                        ({7'b0,RXEQMIX_IN}),
    .RXN                            (RXN_IN[I]),
    .RXP                            (RXP_IN[I]),
    //------ Receive Ports - RX Elastic Buffer and Phase Alignment Ports -------
    .RXBUFRESET                     (RXBUFRESET_IN),
    .RXBUFSTATUS                    ({RXBUFSTATUS_OUT[I], rxbufstatus_float_i[I]}),
    .RXCHANISALIGNED                (),
    .RXCHANREALIGN                  (),
    .RXDLYALIGNDISABLE              (1'b1),
    .RXDLYALIGNMONENB               (1'b1),
    .RXDLYALIGNMONITOR              (),
    .RXDLYALIGNOVERRIDE             (1'b1),
    .RXDLYALIGNRESET                (1'b0),
    .RXDLYALIGNSWPPRECURB           (1'b1),
    .RXDLYALIGNUPDSW                (1'b0),
    .RXENPMAPHASEALIGN              (1'b0),
    .RXPMASETPHASE                  (1'b0),
    .RXSTATUS                       (),
    //------------- Receive Ports - RX Loss-of-sync State Machine --------------
    .RXLOSSOFSYNC                   (RXLOSSOFSYNC_OUT[I*2+:2]),
    //-------------------- Receive Ports - RX Oversampling ---------------------
    .RXENSAMPLEALIGN                (1'b0),
    .RXOVERSAMPLEERR                (),
    //---------------------- Receive Ports - RX PLL Ports ----------------------
    .GREFCLKRX                      (1'b0),
    .GTXRXRESET                     (GTXRXRESET_IN),
    .MGTREFCLKRX                    ({1'b0, MGTREFCLKRX_IN}),
    .NORTHREFCLKRX                  (2'b0),
    .PERFCLKRX                      (1'b0),
    .PLLRXRESET                     (PLLRXRESET_IN),
    .RXPLLLKDET                     (RXPLLLKDET_OUT[I]),
    .RXPLLLKDETEN                   (1'b1),
    .RXPLLPOWERDOWN                 (1'b0),
    .RXPLLREFSELDY                  (3'b0),
    .RXRATE                         (2'b0),
    .RXRATEDONE                     (),
    .RXRESETDONE                    (RXRESETDONE_OUT[I]),
    .SOUTHREFCLKRX                  (2'b0),
    //------------ Receive Ports - RX Pipe Control for PCI Express -------------
    .PHYSTATUS                      (),
    .RXVALID                        (),
    //--------------- Receive Ports - RX Polarity Control Ports ----------------
    .RXPOLARITY                     (RXPOLARITY_IN[I]),
    //------------------- Receive Ports - RX Ports for SATA --------------------
    .COMINITDET                     (),
    .COMSASDET                      (),
    .COMWAKEDET                     (),
    //----------- Shared Ports - Dynamic Reconfiguration Port (DRP) ------------
    .DADDR                          (8'b0),
    .DCLK                           (1'b0),
    .DEN                            (1'b0),
    .DI                             (16'b0),
    .DRDY                           (),
    .DRPDO                          (),
    .DWE                            (1'b0),
    //------------ Transmit Ports - 64b66b and 64b67b Gearbox Ports ------------
    .TXGEARBOXREADY                 (),
    .TXHEADER                       (3'b0),
    .TXSEQUENCE                     (7'b0),
    .TXSTARTSEQ                     (1'b0),
    //-------------- Transmit Ports - 8b10b Encoder Control Ports --------------
    .TXBYPASS8B10B                  (4'b0),
    .TXCHARDISPMODE                 (4'b0),
    .TXCHARDISPVAL                  (4'b0),
    .TXCHARISK                      ({2'b0,TXCHARISK_IN[I*2+:2]}),
    .TXENC8B10BUSE                  (1'b1),
    .TXKERR                         (),
    .TXRUNDISP                      (),
    //----------------------- Transmit Ports - GTX Ports -----------------------
    .GTXTEST                        (13'b1000000000000),
    .MGTREFCLKFAB                   (),
    .TSTCLK0                        (1'b0),
    .TSTCLK1                        (1'b0),
    .TSTIN                          (20'b11111111111111111111),
    .TSTOUT                         (),
    //---------------- Transmit Ports - TX Data Path interface -----------------
    .TXDATA                         ({16'b0, TXDATA_IN[I*16+:16]}),
    .TXOUTCLK                       (TXOUTCLK_OUT[I]),
    .TXOUTCLKPCS                    (),
    .TXRESET                        (TXRESET_IN),
    .TXUSRCLK                       (1'b0),
    .TXUSRCLK2                      (TXUSRCLK2_IN),
    //-------------- Transmit Ports - TX Driver and OOB signaling --------------
    .TXBUFDIFFCTRL                  (3'b100),
    .TXDIFFCTRL                     (TXDIFFCTRL_IN),
    .TXINHIBIT                      (1'b0),
    .TXN                            (TXN_OUT[I]),
    .TXP                            (TXP_OUT[I]),
    .TXPOSTEMPHASIS                 (TXPOSTEMPHASIS_IN),
    //------------- Transmit Ports - TX Driver and OOB signalling --------------
    .TXPREEMPHASIS                  (TXPREEMPHASIS_IN),
    //--------- Transmit Ports - TX Elastic Buffer and Phase Alignment ---------
    .TXBUFSTATUS                    (),
    //------ Transmit Ports - TX Elastic Buffer and Phase Alignment Ports ------
    .TXDLYALIGNDISABLE              (1'b1),
    .TXDLYALIGNMONITOR              (),
    .TXDLYALIGNOVERRIDE             (1'b0),
    .TXDLYALIGNRESET                (1'b0),
    .TXDLYALIGNUPDSW                (1'b0),
    .TXENPMAPHASEALIGN              (1'b0),
    .TXPMASETPHASE                  (1'b0),
    //--------------------- Transmit Ports - TX PLL Ports ----------------------
    .GREFCLKTX                      (1'b0),
    .GTXTXRESET                     (GTXTXRESET_IN),
    .MGTREFCLKTX                    ({1'b0, MGTREFCLKTX_IN}),
    .NORTHREFCLKTX                  (2'b0),
    .PERFCLKTX                      (1'b0),
    .PLLTXRESET                     (PLLTXRESET_IN),
    .SOUTHREFCLKTX                  (2'b0),
    .TXPLLLKDET                     (),
    .TXPLLLKDETEN                   (1'b1),
    .TXPLLPOWERDOWN                 (1'b0),
    .TXPLLREFSELDY                  (3'b0),
    .TXRATE                         (2'b0),
    .TXRATEDONE                     (),
    .TXRESETDONE                    (TXRESETDONE_OUT[I]),
    .TXDLYALIGNMONENB               (1'b1),
    //------------------- Transmit Ports - TX PRBS Generator -------------------
    .TXENPRBSTST                    (3'b0),
    .TXPRBSFORCEERR                 (1'b0),
    //------------------ Transmit Ports - TX Polarity Control ------------------
    .TXPOLARITY                     (1'b0),
    //--------------- Transmit Ports - TX Ports for PCI Express ----------------
    .TXDEEMPH                       (1'b0),
    .TXDETECTRX                     (1'b0),
    .TXELECIDLE                     (RXPOWERDOWN_IN),
    .TXMARGIN                       (3'b0),
    .TXPDOWNASYNCH                  (1'b0),
    .TXSWING                        (1'b0),
    //------------------- Transmit Ports - TX Ports for SATA -------------------
    .COMFINISH                      (),
    .TXCOMINIT                      (1'b0),
    .TXCOMSAS                       (1'b0),
    .TXCOMWAKE                      (1'b0)
  );
end endgenerate

endmodule

