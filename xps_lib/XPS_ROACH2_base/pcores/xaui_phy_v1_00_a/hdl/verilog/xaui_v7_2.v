module xaui_v7_2(
  reset,
  usrclk,
  xgmii_txd,xgmii_txc,
  xgmii_rxd,xgmii_rxc,
  mgt_txdata,mgt_txcharisk,
  mgt_rxdata,mgt_rxcharisk,
  mgt_codevalid, mgt_codecomma,
  mgt_enable_align, mgt_enchansync,
  mgt_syncok, mgt_loopback, mgt_powerdown,
  configuration_vector,
  status_vector,
  align_status, sync_status, mgt_rxlock,
  mgt_tx_reset, mgt_rx_reset,
  signal_detect
  );
  input  reset;
  input  usrclk;

  input  [63:0] xgmii_txd;
  input   [7:0] xgmii_txc;
  output [63:0] xgmii_rxd;
  output  [7:0] xgmii_rxc;

  output [63:0] mgt_txdata;
  output  [7:0] mgt_txcharisk;
  input  [63:0] mgt_rxdata;
  input   [7:0] mgt_rxcharisk;
  input   [7:0] mgt_codevalid;
  input   [7:0] mgt_codecomma;
  output  [3:0] mgt_enable_align;
  output mgt_enchansync;
  input   [3:0] mgt_syncok;
  input   [3:0] mgt_rxlock;
  output mgt_loopback;
  output mgt_powerdown;
  input   [6:0] configuration_vector;
  output  [7:0] status_vector;
  output align_status;
  output  [3:0] sync_status;
  input   [3:0] mgt_tx_reset;
  input   [3:0] mgt_rx_reset;
  input   [3:0] signal_detect;
// synthesis attribute box_type xaui_v7_2 "black_box" 
endmodule
