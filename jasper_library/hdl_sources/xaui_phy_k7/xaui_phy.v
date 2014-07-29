module xaui_phy(
    xaui_clk,
    reset,

    /* XAUI signals */
    xgmii_txd,
    xgmii_txc,
    xgmii_rxd,
    xgmii_rxc,
    xaui_status,

    // SFP+ cage signals
    txp,
    txn,
    rxp,
    rxn,
    signal_detect,
    tx_fault,     
    tx_disable,

    REF_CLK_IN,       // 156.25 MHz MGT_REF_CLK in (after LVDS Buffer) (from xaui_infrastructure.v)
    REF_CLK_IN_BUFH,  // 156.25 MHz MGT_REF_CLK in (after BUFH Buffer) (from xaui_infrastructure.v) 
    GT0_QPLLLOCK,     // GTXE2_COMMON QPLL LOCK signal (from xaui_infrastructure.v)   
    GT0_QPLLOUTCLK,   // GTXE2_COMMON QPLL OUT CLK signal (from xaui_infrastructure.v)
    GT0_QPLLOUTREFCLK,// GTXE2_COMMON QPLL OUT REF CLK signal (from xaui_infrastructure.v)
    clk156,
    dclk,
    mmcm_locked,   

    xaui_clk_out,
    phy_stat 
  );

  input  xaui_clk, reset;

////// New 10G PCS PMA core signals over BUS = XAUI_SYS
  input REF_CLK_IN;       // 156.25 MHz MGT_REF_CLK in (after LVDS Buffer) (from xaui_infrastructure.v)
  input REF_CLK_IN_BUFH;  // 156.25 MHz MGT_REF_CLK in (after BUFH Buffer) (from xaui_infrastructure.v)
  input GT0_QPLLLOCK;     // GTXE2_COMMON QPLL LOCK signal (from xaui_infrastructure.v)   
  input GT0_QPLLOUTCLK;   // GTXE2_COMMON QPLL OUT CLK signal (from xaui_infrastructure.v) 
  input GT0_QPLLOUTREFCLK;// GTXE2_COMMON QPLL OUT REF CLK signal (from xaui_infrastructure.v)

  input clk156; // 156.25 MHz MMCM output in (after LVDS Buffer) (from xaui_infrastructure.v)
  input dclk;
  input mmcm_locked; 

  output txp;
  output txn;
  input rxp;
  input rxn;

  input signal_detect;
  input tx_fault;     
  output tx_disable;  

  output xaui_clk_out; 
  output [7:0] phy_stat;

    /* XAUI signals */
  // BUS = XGMII
  input  [63:0] xgmii_txd;   
  input   [7:0] xgmii_txc;   
  output [63:0] xgmii_rxd;   
  output  [7:0] xgmii_rxc;   

  // BUS = XAUI_CONF
  output  [7:0] xaui_status; 

  wire [7:0] core_status;

  ten_gig_eth_pcs_pma_v2_5_example_design ten_gig_eth_pcs_pma_v2_5_inst(
    .REF_CLK_IN       (REF_CLK_IN  ),     // 156.25 MHz MGT_REF_CLK in (after LVDS Buffer) (from xaui_infrastructure.v) 
    .REF_CLK_IN_BUFH  (REF_CLK_IN_BUFH),  // 156.25 MHz MGT_REF_CLK in (after BUFH Buffer) (from xaui_infrastructure.v)
    .GT0_QPLLLOCK     (GT0_QPLLLOCK),     // GTXE2_COMMON QPLL LOCK signal (from xaui_infrastructure.v)   
    .GT0_QPLLOUTCLK   (GT0_QPLLOUTCLK),   // GTXE2_COMMON QPLL OUT CLK signal (from xaui_infrastructure.v) 
    .GT0_QPLLOUTREFCLK(GT0_QPLLOUTREFCLK),// GTXE2_COMMON QPLL OUT REF CLK signal (from xaui_infrastructure.v) 
    .mmcm_locked      (mmcm_locked),
    .clk156           (clk156),
    .dclk             (dclk),  
    .core_clk156_out  (xaui_clk_out),
    .reset            (reset       ),
    .xgmii_txd        (xgmii_txd   ),
    .xgmii_txc        (xgmii_txc   ),
    .xgmii_rxd        (xgmii_rxd   ),
    .xgmii_rxc        (xgmii_rxc   ),
    .xgmii_rx_clk     (),
    .txp              (txp         ), 
    .txn              (txn         ),
    .rxp              (rxp         ),
    .rxn              (rxn         ),
    .mdc              (1'b1),
    .mdio_in          (1'b1),
    .mdio_out         (),
    .mdio_tri         (),
    .prtad            (5'b11111),
    .core_status      (core_status  ),
    .resetdone        (),
    .signal_detect    (signal_detect),
    .tx_fault         (tx_fault     ),
    .tx_disable       (tx_disable   )
  );

  assign xaui_status = {core_status[0],core_status[0],core_status[0],core_status[0],core_status[0],core_status[0],~core_status[0],~core_status[0]};

    // [7:6] Reserved,  
    // 5 BASE-KR Only: Auto Negotiation link_up
    // 4 BASE-KR Only: Auto Negotiation Enable
    // 3 BASE-KR Only: Auto Negotiation Complete
    // 2 BASE-KR Only: Training Done
    // 1 BASE-KR Only: FEC OK
    // 0 PCS Block Lock

    // .phy_rx_up (xaui_status[6:2] == 5'b11111)
    // xaui_status [7..0]
    // 0 TX Local Fault
    // 1 RX Local Fault
    // 2 XAUI lane 0 Sync
    // 3 XAUI lane 1 Sync
    // 4 XAUI lane 2 Sync
    // 5 XAUI lane 3 Sync
    // 6 XAUI lanes aligned
    // 7 RX Link status (0 = link down)

    // So for hack xaui_status vs core_status:
    // xaui_status[0] - not PCS Block Lock [0]
    // xaui_status[1] - not PCS Block Lock [0] 
    // xaui_status[7..2] <= 6'b11111, when corestatus [5..0] = 6'b111111

  assign phy_stat = core_status;
  
endmodule
