module emac_mdio (
    input         wb_clk_i,
    input         wb_rst_i,
    input         wb_cyc_i,
    input         wb_stb_i,
    input         wb_we_i,
    input   [3:0] wb_sel_i,
    input  [31:0] wb_adr_i,
    input  [31:0] wb_dat_i,
    output [31:0] wb_dat_o,
    output        wb_ack_o,
    output        wb_err_o,

    input         reset,
    input         emac_clk, /* not sure if needed - included anyway */

    output        mdc,     
    input         mdi,     
    output        mdo,     
    output        mdot,
    output        mdio_sel
);

    wire        hostclk;
    wire  [1:0] hostopcode;
    wire        hostreq;
    wire        hostmiimsel;
    wire  [9:0] hostaddr; 
    wire [31:0] hostwrdata;
    wire [31:0] hostrddata;
    wire        hostmiimrdy;
    
    /************ Wishbone Assignment **************/
    emac_mdio_wb emac_mdio_wb_inst(
      .wb_clk_i    (wb_clk_i),
      .wb_rst_i    (wb_rst_i),
      .wb_cyc_i    (wb_cyc_i),
      .wb_stb_i    (wb_stb_i),
      .wb_we_i     (wb_we_i),
      .wb_sel_i    (wb_sel_i),
      .wb_adr_i    (wb_adr_i),
      .wb_dat_i    (wb_dat_i),
      .wb_dat_o    (wb_dat_o),
      .wb_ack_o    (wb_ack_o),
      .wb_err_o    (wb_err_o),
      .hostclk     (hostclk),
      .hostopcode  (hostopcode),
      .hostreq     (hostreq),
      .hostmiimsel (hostmiimsel),
      .hostaddr    (hostaddr), 
      .hostwrdata  (hostwrdata),
      .hostrddata  (hostrddata),
      .hostmiimrdy (hostmiimrdy),
      .mdio_sel    (mdio_sel)
    );

    wire RESET = reset;
    wire GTX_CLK = emac_clk;
    //--------------------------------------------------------------------------
    // Port declarations
    //--------------------------------------------------------------------------

    // Client Receiver Interface
    wire          EMACCLIENTRXCLIENTCLKOUT;
    wire          CLIENTEMACRXCLIENTCLKIN;
    wire   [7:0]  EMACCLIENTRXD;
    wire          EMACCLIENTRXDVLD;
    wire          EMACCLIENTRXDVLDMSW;
    wire          EMACCLIENTRXGOODFRAME;
    wire          EMACCLIENTRXBADFRAME;
    wire          EMACCLIENTRXFRAMEDROP;
    wire   [6:0]  EMACCLIENTRXSTATS;
    wire          EMACCLIENTRXSTATSVLD;
    wire          EMACCLIENTRXSTATSBYTEVLD;

    // Client Transmitter Interface
    wire          EMACCLIENTTXCLIENTCLKOUT;
    wire          CLIENTEMACTXCLIENTCLKIN;
    wire   [7:0]  CLIENTEMACTXD;
    wire          CLIENTEMACTXDVLD;
    wire          CLIENTEMACTXDVLDMSW;
    wire          EMACCLIENTTXACK;
    wire          CLIENTEMACTXFIRSTBYTE;
    wire          CLIENTEMACTXUNDERRUN;
    wire          EMACCLIENTTXCOLLISION;
    wire          EMACCLIENTTXRETRANSMIT;
    wire   [7:0]  CLIENTEMACTXIFGDELAY;
    wire          EMACCLIENTTXSTATS;
    wire          EMACCLIENTTXSTATSVLD;
    wire          EMACCLIENTTXSTATSBYTEVLD;

    // MAC Control Interface
    wire           CLIENTEMACPAUSEREQ;
    wire   [15:0]  CLIENTEMACPAUSEVAL;

    // Clock Signals
    wire           EMACPHYTXGMIIMIICLKOUT;
    wire           PHYEMACTXGMIIMIICLKIN;

    // SGMII Interface
    wire    [7:0]  RXDATA;
    wire    [7:0]  TXDATA;
    wire           MMCM_LOCKED;
    wire           AN_INTERRUPT;
    wire           SIGNAL_DETECT;
    wire    [4:0]  PHYAD;
    wire           ENCOMMAALIGN;
    wire           LOOPBACKMSB;
    wire           MGTRXRESET;
    wire           MGTTXRESET;
    wire           POWERDOWN;
    wire           SYNCACQSTATUS;
    wire    [2:0]  RXCLKCORCNT;
    wire           RXBUFSTATUS;
    wire           RXCHARISCOMMA;
    wire           RXCHARISK;
    wire           RXDISPERR;
    wire           RXNOTINTABLE;
    wire           RXREALIGN;
    wire           RXRUNDISP;
    wire           TXBUFERR;
    wire           TXCHARDISPMODE;
    wire           TXCHARDISPVAL;
    wire           TXCHARISK;


    //--------------------------------------------------------------------------
    // Wire declarations
    //--------------------------------------------------------------------------

    wire    [15:0]  client_rx_data_i;
    wire    [15:0]  client_tx_data_i;

    //--------------------------------------------------------------------------
    // Main body of code
    //--------------------------------------------------------------------------

    // Use the 8-bit client data interface
    assign EMACCLIENTRXD = client_rx_data_i[7:0];
    assign #4000 client_tx_data_i = {8'b00000000, CLIENTEMACTXD};

    // Instantiate the Virtex-6 Embedded Tri-Mode Ethernet MAC
    TEMAC_SINGLE #(
    // Configure the PCS/PMA logic
    // PCS/PMA reset is not asserted
       .EMAC_PHYRESET                      ("FALSE"),
    // PCS/PMA Auto-Negotiation is not enabled
       .EMAC_PHYINITAUTONEG_ENABLE         ("TRUE"),
    // PCS/PMA isolate is not enabled
       .EMAC_PHYISOLATE                    ("FALSE"),
    // PCS/PMA is not held in powerdown mode
       .EMAC_PHYPOWERDOWN                  ("TRUE"),
    // PCS/PMA loopback is not enabled
       .EMAC_PHYLOOPBACKMSB                ("FALSE"),
    // GT loopback is not enabled
       .EMAC_GTLOOPBACK                    ("FALSE"),
    // Do not allow transmission without having established a valid link
       .EMAC_UNIDIRECTION_ENABLE           ("FALSE"),
       .EMAC_LINKTIMERVAL                  (9'h032),
    // Do not ignore the MDIO broadcast address
       .EMAC_MDIO_IGNORE_PHYADZERO         ("TRUE"),
    // Configure the EMAC operating mode
    // MDIO is enabled
       .EMAC_MDIO_ENABLE                   ("TRUE"),
    // Speed is defaulted to 1000 Mb/s
       .EMAC_SPEED_LSB                     ("FALSE"),
       .EMAC_SPEED_MSB                     ("TRUE"),
    // Clock Enable advanced clocking is not in use
       .EMAC_USECLKEN                      ("FALSE"),
    // Byte PHY advanced clocking is not supported. Do not modify.
       .EMAC_BYTEPHY                       ("FALSE"),
    // RGMII physical interface is not in use
       .EMAC_RGMII_ENABLE                  ("FALSE"),
    // SGMII physical interface is in use
       .EMAC_SGMII_ENABLE                  ("TRUE"),
       .EMAC_1000BASEX_ENABLE              ("FALSE"),
    // The host interface is not enabled
       .EMAC_HOST_ENABLE                   ("TRUE"),
    // The Tx-side 8-bit client data interface is used
       .EMAC_TX16BITCLIENT_ENABLE          ("FALSE"),
    // The Rx-side 8-bit client data interface is used
       .EMAC_RX16BITCLIENT_ENABLE          ("FALSE"),
    // The address filter is not enabled
       .EMAC_ADDRFILTER_ENABLE             ("FALSE"),

    // EMAC configuration defaults
    // Rx Length/Type checking is enabled
       .EMAC_LTCHECK_DISABLE               ("FALSE"),
    // Rx control frame length checking is enabled
       .EMAC_CTRLLENCHECK_DISABLE          ("FALSE"),
    // Rx flow control is enabled
       .EMAC_RXFLOWCTRL_ENABLE             ("TRUE"),
    // Tx flow control is enabled
       .EMAC_TXFLOWCTRL_ENABLE             ("TRUE"),
    // Transmitter is not held in reset
       .EMAC_TXRESET                       ("FALSE"),
    // Transmitter Jumbo frames are enabled
       .EMAC_TXJUMBOFRAME_ENABLE           ("TRUE"),
    // Transmitter in-band FCS is not enabled
       .EMAC_TXINBANDFCS_ENABLE            ("FALSE"),
    // Transmitter is enabled
       .EMAC_TX_ENABLE                     ("TRUE"),
    // Transmitter VLAN frames are not enabled
       .EMAC_TXVLAN_ENABLE                 ("FALSE"),
    // Transmitter full-duplex mode is enabled
       .EMAC_TXHALFDUPLEX                  ("FALSE"),
    // Transmitter IFG Adjust is not enabled
       .EMAC_TXIFGADJUST_ENABLE            ("FALSE"),
    // Receiver is not held in reset
       .EMAC_RXRESET                       ("FALSE"),
    // Receiver Jumbo frames are enabled
       .EMAC_RXJUMBOFRAME_ENABLE           ("TRUE"),
    // Receiver in-band FCS is not enabled
       .EMAC_RXINBANDFCS_ENABLE            ("FALSE"),
    // Receiver is enabled
       .EMAC_RX_ENABLE                     ("TRUE"),
    // Receiver VLAN frames are not enabled
       .EMAC_RXVLAN_ENABLE                 ("FALSE"),
    // Receiver full-duplex mode is enabled
       .EMAC_RXHALFDUPLEX                  ("FALSE"),

    // Configure the EMAC addressing
    // Set the PAUSE address default
       .EMAC_PAUSEADDR                     (48'hFFEEDDCCBBAA),
    // Do not set the unicast address (address filter is unused)
       .EMAC_UNICASTADDR                   (48'h000000000000),
    // Do not set the DCR base address (DCR is unused)
       .EMAC_DCRBASEADDR                   (8'h00)
    )
    v6_emac
    (
        .RESET                    (RESET),

        .EMACCLIENTRXCLIENTCLKOUT (EMACCLIENTRXCLIENTCLKOUT),
        .CLIENTEMACRXCLIENTCLKIN  (CLIENTEMACRXCLIENTCLKIN),
        .EMACCLIENTRXD            (client_rx_data_i),
        .EMACCLIENTRXDVLD         (EMACCLIENTRXDVLD),
        .EMACCLIENTRXDVLDMSW      (EMACCLIENTRXDVLDMSW),
        .EMACCLIENTRXGOODFRAME    (EMACCLIENTRXGOODFRAME),
        .EMACCLIENTRXBADFRAME     (EMACCLIENTRXBADFRAME),
        .EMACCLIENTRXFRAMEDROP    (EMACCLIENTRXFRAMEDROP),
        .EMACCLIENTRXSTATS        (EMACCLIENTRXSTATS),
        .EMACCLIENTRXSTATSVLD     (EMACCLIENTRXSTATSVLD),
        .EMACCLIENTRXSTATSBYTEVLD (EMACCLIENTRXSTATSBYTEVLD),

        .EMACCLIENTTXCLIENTCLKOUT (EMACCLIENTTXCLIENTCLKOUT),
        .CLIENTEMACTXCLIENTCLKIN  (CLIENTEMACTXCLIENTCLKIN),
        .CLIENTEMACTXD            (client_tx_data_i),
        .CLIENTEMACTXDVLD         (CLIENTEMACTXDVLD),
        .CLIENTEMACTXDVLDMSW      (CLIENTEMACTXDVLDMSW),
        .EMACCLIENTTXACK          (EMACCLIENTTXACK),
        .CLIENTEMACTXFIRSTBYTE    (CLIENTEMACTXFIRSTBYTE),
        .CLIENTEMACTXUNDERRUN     (CLIENTEMACTXUNDERRUN),
        .EMACCLIENTTXCOLLISION    (EMACCLIENTTXCOLLISION),
        .EMACCLIENTTXRETRANSMIT   (EMACCLIENTTXRETRANSMIT),
        .CLIENTEMACTXIFGDELAY     (CLIENTEMACTXIFGDELAY),
        .EMACCLIENTTXSTATS        (EMACCLIENTTXSTATS),
        .EMACCLIENTTXSTATSVLD     (EMACCLIENTTXSTATSVLD),
        .EMACCLIENTTXSTATSBYTEVLD (EMACCLIENTTXSTATSBYTEVLD),

        .CLIENTEMACPAUSEREQ       (CLIENTEMACPAUSEREQ),
        .CLIENTEMACPAUSEVAL       (CLIENTEMACPAUSEVAL),

        .PHYEMACGTXCLK            (GTX_CLK),
        .EMACPHYTXGMIIMIICLKOUT   (EMACPHYTXGMIIMIICLKOUT),
        .PHYEMACTXGMIIMIICLKIN    (PHYEMACTXGMIIMIICLKIN),

        .PHYEMACRXCLK             (1'b0),
        .PHYEMACMIITXCLK          (1'b0),
        .PHYEMACRXD               (RXDATA),
        .PHYEMACRXDV              (RXREALIGN),
        .PHYEMACRXER              (1'b0),
        .EMACPHYTXCLK             (),
        .EMACPHYTXD               (TXDATA),
        .EMACPHYTXEN              (),
        .EMACPHYTXER              (),
        .PHYEMACCOL               (1'b0),
        .PHYEMACCRS               (1'b0),
        .CLIENTEMACDCMLOCKED      (MMCM_LOCKED),
        .EMACCLIENTANINTERRUPT    (AN_INTERRUPT),
        .PHYEMACSIGNALDET         (SIGNAL_DETECT),
        .PHYEMACPHYAD             (5'b10101),
        .EMACPHYENCOMMAALIGN      (ENCOMMAALIGN),
        .EMACPHYLOOPBACKMSB       (LOOPBACKMSB),
        .EMACPHYMGTRXRESET        (MGTRXRESET),
        .EMACPHYMGTTXRESET        (MGTTXRESET),
        .EMACPHYPOWERDOWN         (POWERDOWN),
        .EMACPHYSYNCACQSTATUS     (SYNCACQSTATUS),
        .PHYEMACRXCLKCORCNT       (RXCLKCORCNT),
        .PHYEMACRXBUFSTATUS       ({RXBUFSTATUS,1'b0}),
        .PHYEMACRXCHARISCOMMA     (RXCHARISCOMMA),
        .PHYEMACRXCHARISK         (RXCHARISK),
        .PHYEMACRXDISPERR         (RXDISPERR),
        .PHYEMACRXNOTINTABLE      (RXNOTINTABLE),
        .PHYEMACRXRUNDISP         (RXRUNDISP),
        .PHYEMACTXBUFERR          (TXBUFERR),
        .EMACPHYTXCHARDISPMODE    (TXCHARDISPMODE),
        .EMACPHYTXCHARDISPVAL     (TXCHARDISPVAL),
        .EMACPHYTXCHARISK         (TXCHARISK),

        .EMACPHYMCLKOUT           (mdc),
        .PHYEMACMCLKIN            (1'b0),
        .PHYEMACMDIN              (mdi),
        .EMACPHYMDOUT             (mdo),
        .EMACPHYMDTRI             (mdt),

        .EMACSPEEDIS10100         (),

        .HOSTCLK                  (hostclk),
        .HOSTOPCODE               (hostopcode ),
        .HOSTREQ                  (hostreq),
        .HOSTMIIMSEL              (hostmiimsel),
        .HOSTADDR                 (hostaddr),
        .HOSTWRDATA               (hostwrdata),
        .HOSTMIIMRDY              (hostmiimrdy),
        .HOSTRDDATA               (hostrddata),

        .DCREMACCLK               (1'b0),
        .DCREMACABUS              (10'h000),
        .DCREMACREAD              (1'b0),
        .DCREMACWRITE             (1'b0),
        .DCREMACDBUS              (32'h00000000),
        .EMACDCRACK               (),
        .EMACDCRDBUS              (),
        .DCREMACENABLE            (1'b0),
        .DCRHOSTDONEIR            ()
    );

endmodule
