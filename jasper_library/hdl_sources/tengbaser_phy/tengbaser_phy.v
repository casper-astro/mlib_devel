module tengbaser_phy(
  input           dclk,
  input           clk156,
  input           txusrclk,
  input           txusrclk2,
  output          txclk322,
  input           areset,
  input           areset_clk156,
  input           gttxreset,
  input           gtrxreset,
  //input           sim_speedup_control,
  input           txuserrdy,
  input           qplllock,
  input           qplloutclk,
  input           qplloutrefclk,
  input           reset_counter_done,
  input  [63:0]   xgmii_txd,
  input  [7:0]    xgmii_txc,
  output [63:0]   xgmii_rxd,
  output [7:0]    xgmii_rxc,
  output          txp,
  output          txn,
  input           rxp,
  input           rxn,
  input  [535 : 0] configuration_vector,
  output [447 : 0]  status_vector,
  output [7 : 0]  core_status,
  output          resetdone,
  input           signal_detect,
  input           tx_fault,
  input [2:0]     pma_pmd_type,
  output          tx_disable
  );

  reg [63:0] xgmii_txd_reg;
  reg [7:0] xgmii_txc_reg;
  reg [63:0] xgmii_rxd_reg;
  reg [7:0] xgmii_rxc_reg;
  wire [63:0] xgmii_rxd_int;
  wire [7:0] xgmii_rxc_int;
  assign xgmii_rxd = xgmii_rxd_reg;
  assign xgmii_rxc = xgmii_rxc_reg;

  // Add a pipeline to the xmgii_tx inputs, to aid timing closure
  always @(posedge clk156)
  begin
    xgmii_txd_reg <= xgmii_txd;
    xgmii_txc_reg <= xgmii_txc;
  end

  // Add a pipeline to the xmgii_rx outputs, to aid timing closure
  always @(posedge clk156)
  begin
    xgmii_rxd_reg <= xgmii_rxd_int;
    xgmii_rxc_reg <= xgmii_rxc_int;
  end
  
  wire tx_resetdone_int;
  wire rx_resetdone_int;
  assign resetdone = tx_resetdone_int && rx_resetdone_int;

  // If no arbitration is required on the GT DRP ports then connect REQ to GNT
  // and connect other signals i <= o;
  wire drp_gnt;
  wire drp_req;
  wire drp_den_o;
  wire drp_dwe_o;
  wire [15 : 0] drp_daddr_o;
  wire [15 : 0] drp_di_o;
  wire drp_drdy_o;
  wire [15 : 0] drp_drpdo_o;
  wire drp_den_i;
  wire drp_dwe_i;
  wire [15 : 0] drp_daddr_i;
  wire [15 : 0] drp_di_i;
  wire drp_drdy_i;
  wire [15 : 0] drp_drpdo_i;
  assign drp_gnt = drp_req;
  assign drp_den_i = drp_den_o;
  assign drp_dwe_i = drp_dwe_o;
  assign drp_daddr_i = drp_daddr_o;
  assign drp_di_i = drp_di_o;
  assign drp_drdy_i = drp_drdy_o;
  assign drp_drpdo_i = drp_drpdo_o;


 ten_gig_pcs_pma_5 ten_gig_eth_pcs_pma_i
  (
  .coreclk(clk156),
  .dclk(dclk),
  .rxrecclk_out(rxrecclk_out),
  .txusrclk(txusrclk),
  .txusrclk2(txusrclk2),
  .txoutclk(txclk322),
  .areset(areset),
  .areset_coreclk(areset_clk156),
  .gttxreset(gttxreset),
  .gtrxreset(gtrxreset),
  .sim_speedup_control(1'b0),
  .txuserrdy(txuserrdy),
  .qplllock(qplllock),
  .qplloutclk(qplloutclk),
  .qplloutrefclk(qplloutrefclk),
  .reset_counter_done(reset_counter_done),
  .xgmii_txd(xgmii_txd_reg),
  .xgmii_txc(xgmii_txc_reg),
  .xgmii_rxd(xgmii_rxd_int),
  .xgmii_rxc(xgmii_rxc_int),
  .txp(txp),
  .txn(txn),
  .rxp(rxp),
  .rxn(rxn),
  .configuration_vector(configuration_vector),
  .status_vector(status_vector),
  .core_status(core_status),
  .tx_resetdone(tx_resetdone_int),
  .rx_resetdone(rx_resetdone_int),
  .signal_detect(signal_detect),
  .tx_fault(tx_fault),
  .drp_req(drp_req),
  .drp_gnt(drp_gnt),
  .drp_den_o(drp_den_o),
  .drp_dwe_o(drp_dwe_o),
  .drp_daddr_o(drp_daddr_o),
  .drp_di_o(drp_di_o),
  .drp_drdy_o(drp_drdy_o),
  .drp_drpdo_o(drp_drpdo_o),
  .drp_den_i(drp_den_i),
  .drp_dwe_i(drp_dwe_i),
  .drp_daddr_i(drp_daddr_i),
  .drp_di_i(drp_di_i),
  .drp_drdy_i(drp_drdy_i),
  .drp_drpdo_i(drp_drpdo_i),
  .pma_pmd_type(pma_pmd_type),
  .tx_disable(tx_disable)
  );
endmodule
