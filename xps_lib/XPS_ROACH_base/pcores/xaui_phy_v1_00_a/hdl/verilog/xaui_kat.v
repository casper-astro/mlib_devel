module xaui_kat(
    reset,   
    usrclk,
    /* client side */
    xgmii_txd, xgmii_txc,
    xgmii_rxd, xgmii_rxc,
    /* mgt side */
    mgt_txdata, mgt_txcharisk,
    mgt_rxdata, mgt_rxcharisk,
    mgt_codevalid, mgt_codecomma,
    mgt_enable_align, mgt_enchansync,
    mgt_syncok, mgt_loopback, mgt_powerdown,
    mgt_rxlock,
    /* status & configuration*/
    configuration_vector,
    status_vector,
    align_status, sync_status, 
    mgt_tx_reset, mgt_rx_reset,
    signal_detect
  );
  input  reset;
  input  usrclk;
  /* XGMII interface to MAC */
  input  [63:0] xgmii_txd;
  input   [7:0] xgmii_txc;
  output [63:0] xgmii_rxd;
  output  [7:0] xgmii_rxc;
  /* Data Interface to PHY */
  input  [63:0] mgt_rxdata;
  input   [7:0] mgt_rxcharisk;
  output [63:0] mgt_txdata;
  output  [7:0] mgt_txcharisk;
  input   [7:0] mgt_codecomma;
  input   [7:0] mgt_codevalid;
  /* PHY synchronization and alignment control */
  output  [3:0] mgt_enable_align;
  output  mgt_enchansync;
  /* PHY mode control */
  output  mgt_loopback;
  output  mgt_powerdown;
  /* PHY Status */
  input   [3:0] mgt_syncok;
  input   [3:0] mgt_rxlock;
  input   [3:0] mgt_tx_reset;
  input   [3:0] mgt_rx_reset;
  input   [3:0] signal_detect;
  /* XAUI Configuration bits */
  input   [6:0] configuration_vector;
  /* XAUI Status bits */
  output  [7:0] status_vector;
  output  [3:0] sync_status;
  output  align_status;

  /*TODO: implement MDIO & test patterns */

  assign mgt_loopback  = configuration_vector[0];
  assign mgt_powerdown = configuration_vector[1];

  wire reset_local_fault    = configuration_vector[2];
  wire reset_rx_link_status = configuration_vector[3];

  reg [1:0] local_fault;
  reg rx_link_up;
  assign status_vector = {rx_link_up, align_status, sync_status, local_fault};

  reg [63:0] xgmii_txd_z;
  reg  [7:0] xgmii_txc_z;

  always @(posedge usrclk) begin
    xgmii_txd_z <= xgmii_txd;
    xgmii_txc_z <= xgmii_txc;
  end

  wire [63:0] xgmii_rxd_int;
  wire  [7:0] xgmii_rxc_int;

  reg [63:0] xgmii_rxd;
  reg  [7:0] xgmii_rxc;

  always @(posedge usrclk) begin
    xgmii_rxd <= xgmii_rxd_int;
    xgmii_rxc <= xgmii_rxc_int;
  end

  wire remote_error = xgmii_rxc_int[3:0] == 4'b0001 && xgmii_rxd_int[31:0]  == 32'h0200009c ||
                      xgmii_rxc_int[7:4] == 4'b0001 && xgmii_rxd_int[63:32] == 32'h0200009c;
 
  wire [3:0] sync_status_int;
  wire align_status_int;

  reg [3:0] sync_status;
  reg align_status;
  always @(posedge usrclk) begin
    sync_status  <= sync_status_int;
    align_status <= align_status_int;
  end

  pcs_tx pcs_tx_0(
    .clk(usrclk), .reset(reset),
    .xgmii_txdata(xgmii_txd_z), 
    .xgmii_txcharisk(xgmii_txc_z),
    .mgt_txdata(mgt_txdata),
    .mgt_txcharisk(mgt_txcharisk)
  );

  reg [63:0] mgt_rxdata_z;
  reg  [7:0] mgt_rxcharisk_z;
  reg  [7:0] mgt_codevalid_z;
  always @(posedge usrclk) begin
    mgt_rxdata_z    <= mgt_rxdata;
    mgt_rxcharisk_z <= mgt_rxcharisk;
    mgt_codevalid_z <= mgt_codevalid;
  end

  pcs_sync pcs_sync_0(
    .clk(usrclk),
    .reset(reset),
    .enable_align(mgt_enable_align),
    .commadet(mgt_codecomma),
    .codevalid(mgt_codevalid),
    .syncok(mgt_syncok),
    .rxlock(mgt_rxlock),
    .signal_detect(signal_detect),
    .lanesync(sync_status_int)
  );

  pcs_deskew pcs_deskew_0(
    .clk(usrclk), .reset(reset),
    .mgt_rxdata(mgt_rxdata_z), .mgt_rxcharisk(mgt_rxcharisk_z),
    .disp_err(~mgt_codevalid_z),
    .sync_status(sync_status),
    .enable_deskew(mgt_enchansync),
    .align_status(align_status_int)
  );

  pcs_rx pcs_rx_0(
    .clk(usrclk), .reset(reset),
    .align_status(align_status),
    .mgt_rxdata(mgt_rxdata_z), .mgt_rxcharisk(mgt_rxcharisk_z),
    .disperr(~mgt_codevalid_z),
    .xgmii_rxd(xgmii_rxd_int), .xgmii_rxc(xgmii_rxc_int)
  );

  reg prev_reset_local_fault, prev_reset_rx_link_status;

  always @(posedge usrclk) begin
    if (reset) begin
      local_fault <= 2'b10;
      rx_link_up <= 1'b0;
      prev_reset_local_fault <= 1'b0;
      prev_reset_rx_link_status <= 1'b0;
    end else begin
      prev_reset_local_fault <= reset_local_fault;
      prev_reset_rx_link_status <= reset_rx_link_status;
      if (prev_reset_local_fault != reset_local_fault & reset_local_fault) begin
        local_fault <= 2'b00;
      end
      if (prev_reset_rx_link_status != reset_rx_link_status & reset_rx_link_status) begin
        rx_link_up <= align_status;
      end

      if (remote_error) begin
        local_fault[0] <= 1'b0;
      end

      if (~align_status) begin
        local_fault[1] <= 1'b1;
      end

      if (~align_status) begin
        rx_link_up <= 1'b0;
      end
    end
  end

endmodule
