module xaui_infrastructure #(
    parameter ENABLE0           = 0,
    parameter ENABLE1           = 0,
    parameter ENABLE2           = 0,
    parameter ENABLE3           = 0,
    parameter ENABLE4           = 0,
    parameter ENABLE5           = 0,
    parameter ENABLE6           = 0,
    parameter ENABLE7           = 0,
    parameter RX_LANE_STEER0    = 1,
    parameter RX_LANE_STEER1    = 1,
    parameter RX_LANE_STEER2    = 1,
    parameter RX_LANE_STEER3    = 1,
    parameter RX_LANE_STEER4    = 1,
    parameter RX_LANE_STEER5    = 1,
    parameter RX_LANE_STEER6    = 1,
    parameter RX_LANE_STEER7    = 1,
    parameter TX_LANE_STEER0    = 0,
    parameter TX_LANE_STEER1    = 0,
    parameter TX_LANE_STEER2    = 0,
    parameter TX_LANE_STEER3    = 0,
    parameter TX_LANE_STEER4    = 0,
    parameter TX_LANE_STEER5    = 0,
    parameter TX_LANE_STEER6    = 0,
    parameter TX_LANE_STEER7    = 0,
    parameter RX_INVERT0        = 1,
    parameter RX_INVERT1        = 1,
    parameter RX_INVERT2        = 1,
    parameter RX_INVERT3        = 0,
    parameter RX_INVERT4        = 1,
    parameter RX_INVERT5        = 1,
    parameter RX_INVERT6        = 1,
    parameter RX_INVERT7        = 0
  ) (
    input             reset,

    input       [2:0] xaui_refclk_n,
    input       [2:0] xaui_refclk_p,

    input   [8*4-1:0] mgt_rx_n,
    input   [8*4-1:0] mgt_rx_p,
    output  [8*4-1:0] mgt_tx_n,
    output  [8*4-1:0] mgt_tx_p,

    output            xaui_clk,

    input   [1-1:0] mgt_tx_rst0,
    input   [64-1:0] mgt_txdata0,
    input   [8-1:0] mgt_txcharisk0,
    input   [5-1:0] mgt_txpostemphasis0,
    input   [4-1:0] mgt_txpreemphasis0,
    input   [4-1:0] mgt_txdiffctrl0,

    input   [1-1:0] mgt_rx_rst0,
    output  [64-1:0] mgt_rxdata0,
    output  [8-1:0] mgt_rxcharisk0,
    output  [8-1:0] mgt_rxcodecomma0,
    input   [4-1:0] mgt_rxencommaalign0,
    input   [1-1:0] mgt_rxenchansync0,
    output  [4-1:0] mgt_rxsyncok0,
    output  [8-1:0] mgt_rxcodevalid0,
    output  [4-1:0] mgt_rxbufferr0,
    input   [3-1:0] mgt_rxeqmix0,
    output  [4-1:0] mgt_rxlock0,

    input   [1-1:0] mgt_tx_rst1,
    input   [64-1:0] mgt_txdata1,
    input   [8-1:0] mgt_txcharisk1,
    input   [5-1:0] mgt_txpostemphasis1,
    input   [4-1:0] mgt_txpreemphasis1,
    input   [4-1:0] mgt_txdiffctrl1,

    input   [1-1:0] mgt_rx_rst1,
    output  [64-1:0] mgt_rxdata1,
    output  [8-1:0] mgt_rxcharisk1,
    output  [8-1:0] mgt_rxcodecomma1,
    input   [4-1:0] mgt_rxencommaalign1,
    input   [1-1:0] mgt_rxenchansync1,
    output  [4-1:0] mgt_rxsyncok1,
    output  [8-1:0] mgt_rxcodevalid1,
    output  [4-1:0] mgt_rxbufferr1,
    input   [3-1:0] mgt_rxeqmix1,
    output  [4-1:0] mgt_rxlock1,

    input   [1-1:0] mgt_tx_rst2,
    input   [64-1:0] mgt_txdata2,
    input   [8-1:0] mgt_txcharisk2,
    input   [5-1:0] mgt_txpostemphasis2,
    input   [4-1:0] mgt_txpreemphasis2,
    input   [4-1:0] mgt_txdiffctrl2,

    input   [1-1:0] mgt_rx_rst2,
    output  [64-1:0] mgt_rxdata2,
    output  [8-1:0] mgt_rxcharisk2,
    output  [8-1:0] mgt_rxcodecomma2,
    input   [4-1:0] mgt_rxencommaalign2,
    input   [1-1:0] mgt_rxenchansync2,
    output  [4-1:0] mgt_rxsyncok2,
    output  [8-1:0] mgt_rxcodevalid2,
    output  [4-1:0] mgt_rxbufferr2,
    input   [3-1:0] mgt_rxeqmix2,
    output  [4-1:0] mgt_rxlock2,

    input   [1-1:0] mgt_tx_rst3,
    input   [64-1:0] mgt_txdata3,
    input   [8-1:0] mgt_txcharisk3,
    input   [5-1:0] mgt_txpostemphasis3,
    input   [4-1:0] mgt_txpreemphasis3,
    input   [4-1:0] mgt_txdiffctrl3,

    input   [1-1:0] mgt_rx_rst3,
    output  [64-1:0] mgt_rxdata3,
    output  [8-1:0] mgt_rxcharisk3,
    output  [8-1:0] mgt_rxcodecomma3,
    input   [4-1:0] mgt_rxencommaalign3,
    input   [1-1:0] mgt_rxenchansync3,
    output  [4-1:0] mgt_rxsyncok3,
    output  [8-1:0] mgt_rxcodevalid3,
    output  [4-1:0] mgt_rxbufferr3,
    input   [3-1:0] mgt_rxeqmix3,
    output  [4-1:0] mgt_rxlock3,

    input   [1-1:0] mgt_tx_rst4,
    input   [64-1:0] mgt_txdata4,
    input   [8-1:0] mgt_txcharisk4,
    input   [5-1:0] mgt_txpostemphasis4,
    input   [4-1:0] mgt_txpreemphasis4,
    input   [4-1:0] mgt_txdiffctrl4,

    input   [1-1:0] mgt_rx_rst4,
    output  [64-1:0] mgt_rxdata4,
    output  [8-1:0] mgt_rxcharisk4,
    output  [8-1:0] mgt_rxcodecomma4,
    input   [4-1:0] mgt_rxencommaalign4,
    input   [1-1:0] mgt_rxenchansync4,
    output  [4-1:0] mgt_rxsyncok4,
    output  [8-1:0] mgt_rxcodevalid4,
    output  [4-1:0] mgt_rxbufferr4,
    input   [3-1:0] mgt_rxeqmix4,
    output  [4-1:0] mgt_rxlock4,

    output  [16-1:0] mgt_status4,
 
    input   [1-1:0] mgt_tx_rst5,
    input   [64-1:0] mgt_txdata5,
    input   [8-1:0] mgt_txcharisk5,
    input   [5-1:0] mgt_txpostemphasis5,
    input   [4-1:0] mgt_txpreemphasis5,
    input   [4-1:0] mgt_txdiffctrl5,

    input   [1-1:0] mgt_rx_rst5,
    output  [64-1:0] mgt_rxdata5,
    output  [8-1:0] mgt_rxcharisk5,
    output  [8-1:0] mgt_rxcodecomma5,
    input   [4-1:0] mgt_rxencommaalign5,
    input   [1-1:0] mgt_rxenchansync5,
    output  [4-1:0] mgt_rxsyncok5,
    output  [8-1:0] mgt_rxcodevalid5,
    output  [4-1:0] mgt_rxbufferr5,
    input   [3-1:0] mgt_rxeqmix5,
    output  [4-1:0] mgt_rxlock5,

    input   [1-1:0] mgt_tx_rst6,
    input   [64-1:0] mgt_txdata6,
    input   [8-1:0] mgt_txcharisk6,
    input   [5-1:0] mgt_txpostemphasis6,
    input   [4-1:0] mgt_txpreemphasis6,
    input   [4-1:0] mgt_txdiffctrl6,

    input   [1-1:0] mgt_rx_rst6,
    output  [64-1:0] mgt_rxdata6,
    output  [8-1:0] mgt_rxcharisk6,
    output  [8-1:0] mgt_rxcodecomma6,
    input   [4-1:0] mgt_rxencommaalign6,
    input   [1-1:0] mgt_rxenchansync6,
    output  [4-1:0] mgt_rxsyncok6,
    output  [8-1:0] mgt_rxcodevalid6,
    output  [4-1:0] mgt_rxbufferr6,
    input   [3-1:0] mgt_rxeqmix6,
    output  [4-1:0] mgt_rxlock6,

    input   [1-1:0] mgt_tx_rst7,
    input   [64-1:0] mgt_txdata7,
    input   [8-1:0] mgt_txcharisk7,
    input   [5-1:0] mgt_txpostemphasis7,
    input   [4-1:0] mgt_txpreemphasis7,
    input   [4-1:0] mgt_txdiffctrl7,

    input   [1-1:0] mgt_rx_rst7,
    output  [64-1:0] mgt_rxdata7,
    output  [8-1:0] mgt_rxcharisk7,
    output  [8-1:0] mgt_rxcodecomma7,
    input   [4-1:0] mgt_rxencommaalign7,
    input   [1-1:0] mgt_rxenchansync7,
    output  [4-1:0] mgt_rxsyncok7,
    output  [8-1:0] mgt_rxcodevalid7,
    output  [4-1:0] mgt_rxbufferr7,
    input   [3-1:0] mgt_rxeqmix7,
    output  [4-1:0] mgt_rxlock7);

  wire [8*1-1:0] mgt_tx_rst;
  wire [8*64-1:0] mgt_txdata;
  wire [8*8-1:0] mgt_txcharisk;
  wire [8*5-1:0] mgt_txpostemphasis;
  wire [8*4-1:0] mgt_txpreemphasis;
  wire [8*4-1:0] mgt_txdiffctrl;

  wire [8*1-1:0] mgt_rx_rst;
  wire [8*64-1:0] mgt_rxdata;
  wire [8*8-1:0] mgt_rxcharisk;
  wire [8*8-1:0] mgt_rxcodecomma;
  wire [8*4-1:0] mgt_rxencommaalign;
  wire [8*1-1:0] mgt_rxenchansync;
  wire [8*4-1:0] mgt_rxsyncok;
  wire [8*8-1:0] mgt_rxcodevalid;
  wire [8*4-1:0] mgt_rxbufferr;
  wire [8*3-1:0] mgt_rxeqmix;
  wire [8*4-1:0] mgt_rxlock;


  assign mgt_tx_rst          = {mgt_tx_rst7, mgt_tx_rst6, mgt_tx_rst5, mgt_tx_rst4, mgt_tx_rst3, mgt_tx_rst2, mgt_tx_rst1, mgt_tx_rst0}; 
  assign mgt_txdata          = {mgt_txdata7, mgt_txdata6, mgt_txdata5, mgt_txdata4, mgt_txdata3, mgt_txdata2, mgt_txdata1, mgt_txdata0}; 
  assign mgt_txcharisk       = {mgt_txcharisk7, mgt_txcharisk6, mgt_txcharisk5, mgt_txcharisk4, mgt_txcharisk3, mgt_txcharisk2, mgt_txcharisk1, mgt_txcharisk0}; 
  assign mgt_txpostemphasis  = {mgt_txpostemphasis7, mgt_txpostemphasis6, mgt_txpostemphasis5, mgt_txpostemphasis4, mgt_txpostemphasis3, mgt_txpostemphasis2, mgt_txpostemphasis1, mgt_txpostemphasis0}; 
  assign mgt_txpreemphasis   = {mgt_txpreemphasis7, mgt_txpreemphasis6, mgt_txpreemphasis5, mgt_txpreemphasis4, mgt_txpreemphasis3, mgt_txpreemphasis2, mgt_txpreemphasis1, mgt_txpreemphasis0}; 
  assign mgt_txdiffctrl      = {mgt_txdiffctrl7, mgt_txdiffctrl6, mgt_txdiffctrl5, mgt_txdiffctrl4, mgt_txdiffctrl3, mgt_txdiffctrl2, mgt_txdiffctrl1, mgt_txdiffctrl0}; 
  assign mgt_rx_rst          = {mgt_rx_rst7, mgt_rx_rst6, mgt_rx_rst5, mgt_rx_rst4, mgt_rx_rst3, mgt_rx_rst2, mgt_rx_rst1, mgt_rx_rst0}; 
  assign mgt_rxdata0         = mgt_rxdata[1*64-1:0*64]; 
  assign mgt_rxdata1         = mgt_rxdata[2*64-1:1*64]; 
  assign mgt_rxdata2         = mgt_rxdata[3*64-1:2*64]; 
  assign mgt_rxdata3         = mgt_rxdata[4*64-1:3*64]; 
  assign mgt_rxdata4         = mgt_rxdata[5*64-1:4*64]; 
  assign mgt_rxdata5         = mgt_rxdata[6*64-1:5*64]; 
  assign mgt_rxdata6         = mgt_rxdata[7*64-1:6*64]; 
  assign mgt_rxdata7         = mgt_rxdata[8*64-1:7*64]; 
  assign mgt_rxcharisk0      = mgt_rxcharisk[1*8-1:0*8];
  assign mgt_rxcharisk1      = mgt_rxcharisk[2*8-1:1*8];
  assign mgt_rxcharisk2      = mgt_rxcharisk[3*8-1:2*8];
  assign mgt_rxcharisk3      = mgt_rxcharisk[4*8-1:3*8];
  assign mgt_rxcharisk4      = mgt_rxcharisk[5*8-1:4*8];
  assign mgt_rxcharisk5      = mgt_rxcharisk[6*8-1:5*8];
  assign mgt_rxcharisk6      = mgt_rxcharisk[7*8-1:6*8];
  assign mgt_rxcharisk7      = mgt_rxcharisk[8*8-1:7*8];
  assign mgt_rxcodecomma0    = mgt_rxcodecomma[1*8-1:0*8];
  assign mgt_rxcodecomma1    = mgt_rxcodecomma[2*8-1:1*8];
  assign mgt_rxcodecomma2    = mgt_rxcodecomma[3*8-1:2*8];
  assign mgt_rxcodecomma3    = mgt_rxcodecomma[4*8-1:3*8];
  assign mgt_rxcodecomma4    = mgt_rxcodecomma[5*8-1:4*8];
  assign mgt_rxcodecomma5    = mgt_rxcodecomma[6*8-1:5*8];
  assign mgt_rxcodecomma6    = mgt_rxcodecomma[7*8-1:6*8];
  assign mgt_rxcodecomma7    = mgt_rxcodecomma[8*8-1:7*8];
  assign mgt_rxencommaalign  = {mgt_rxencommaalign7, mgt_rxencommaalign6, mgt_rxencommaalign5, mgt_rxencommaalign4, mgt_rxencommaalign3, mgt_rxencommaalign2, mgt_rxencommaalign1 ,mgt_rxencommaalign0};
  assign mgt_rxenchansync    = {mgt_rxenchansync7, mgt_rxenchansync6, mgt_rxenchansync5, mgt_rxenchansync4, mgt_rxenchansync3, mgt_rxenchansync2, mgt_rxenchansync1, mgt_rxenchansync0}; 
  assign mgt_rxsyncok0       = mgt_rxsyncok[1*4-1:0*4];
  assign mgt_rxsyncok1       = mgt_rxsyncok[2*4-1:1*4];
  assign mgt_rxsyncok2       = mgt_rxsyncok[3*4-1:2*4];
  assign mgt_rxsyncok3       = mgt_rxsyncok[4*4-1:3*4];
  assign mgt_rxsyncok4       = mgt_rxsyncok[5*4-1:4*4];
  assign mgt_rxsyncok5       = mgt_rxsyncok[6*4-1:5*4];
  assign mgt_rxsyncok6       = mgt_rxsyncok[7*4-1:6*4];
  assign mgt_rxsyncok7       = mgt_rxsyncok[8*4-1:7*4];
  assign mgt_rxcodevalid0    = mgt_rxcodevalid[1*8-1:0*8];
  assign mgt_rxcodevalid1    = mgt_rxcodevalid[2*8-1:1*8];
  assign mgt_rxcodevalid2    = mgt_rxcodevalid[3*8-1:2*8];
  assign mgt_rxcodevalid3    = mgt_rxcodevalid[4*8-1:3*8];
  assign mgt_rxcodevalid4    = mgt_rxcodevalid[5*8-1:4*8];
  assign mgt_rxcodevalid5    = mgt_rxcodevalid[6*8-1:5*8];
  assign mgt_rxcodevalid6    = mgt_rxcodevalid[7*8-1:6*8];
  assign mgt_rxcodevalid7    = mgt_rxcodevalid[8*8-1:7*8];
  assign mgt_rxbufferr0      = mgt_rxbufferr[1*4-1:0*4];
  assign mgt_rxbufferr1      = mgt_rxbufferr[2*4-1:1*4];
  assign mgt_rxbufferr2      = mgt_rxbufferr[3*4-1:2*4];
  assign mgt_rxbufferr3      = mgt_rxbufferr[4*4-1:3*4];
  assign mgt_rxbufferr4      = mgt_rxbufferr[5*4-1:4*4];
  assign mgt_rxbufferr5      = mgt_rxbufferr[6*4-1:5*4];
  assign mgt_rxbufferr6      = mgt_rxbufferr[7*4-1:6*4];
  assign mgt_rxbufferr7      = mgt_rxbufferr[8*4-1:7*4];
  assign mgt_rxeqmix         = {mgt_rxeqmix7, mgt_rxeqmix6, mgt_rxeqmix5, mgt_rxeqmix4, mgt_rxeqmix3, mgt_rxeqmix2, mgt_rxeqmix1, mgt_rxeqmix0}; 
  assign mgt_rxlock0         = mgt_rxlock[1*4-1:0*4]; 
  assign mgt_rxlock1         = mgt_rxlock[2*4-1:1*4]; 
  assign mgt_rxlock2         = mgt_rxlock[3*4-1:2*4]; 
  assign mgt_rxlock3         = mgt_rxlock[4*4-1:3*4]; 
  assign mgt_rxlock4         = mgt_rxlock[5*4-1:4*4]; 
  assign mgt_rxlock5         = mgt_rxlock[6*4-1:5*4]; 
  assign mgt_rxlock6         = mgt_rxlock[7*4-1:6*4]; 
  assign mgt_rxlock7         = mgt_rxlock[8*4-1:7*4]; 

  localparam ENABLE = {ENABLE7 == 1, ENABLE6 == 1, ENABLE5 == 1, ENABLE4 == 1, ENABLE3 == 1, ENABLE2 == 1, ENABLE1 == 1, ENABLE0 == 1};
  localparam RX_LANE_STEER = {RX_LANE_STEER7 == 1, RX_LANE_STEER6 == 1, RX_LANE_STEER5 == 1, RX_LANE_STEER4 == 1, RX_LANE_STEER3 == 1, RX_LANE_STEER2 == 1, RX_LANE_STEER1 == 1, RX_LANE_STEER0 == 1};
  localparam TX_LANE_STEER = {TX_LANE_STEER7 == 1, TX_LANE_STEER6 == 1, TX_LANE_STEER5 == 1, TX_LANE_STEER4 == 1, TX_LANE_STEER3 == 1, TX_LANE_STEER2 == 1, TX_LANE_STEER1 == 1, TX_LANE_STEER0 == 1};
  localparam RX_INVERT = {RX_INVERT7 == 1, RX_INVERT6 == 1, RX_INVERT5 == 1, RX_INVERT4 == 1, RX_INVERT3 == 1, RX_INVERT2 == 1, RX_INVERT1 == 1, RX_INVERT0 == 1};
 
  xaui_infrastructure_low #(
    .ENABLE(ENABLE),
    .RX_LANE_STEER(RX_LANE_STEER),
    .TX_LANE_STEER(TX_LANE_STEER),
    .RX_INVERT(RX_INVERT)
  ) xaui_infrastructure_low_inst (
    .mgt_reset(reset),
    .xaui_refclk_n(xaui_refclk_n),
    .xaui_refclk_p(xaui_refclk_p),
    .mgt_rx_n(mgt_rx_n),
    .mgt_rx_p(mgt_rx_p),
    .mgt_tx_n(mgt_tx_n),
    .mgt_tx_p(mgt_tx_p),
    .xaui_clk(xaui_clk),
    .mgt_tx_rst(mgt_tx_rst),
    .mgt_txdata(mgt_txdata),
    .mgt_txcharisk(mgt_txcharisk),
    .mgt_txpostemphasis(mgt_txpostemphasis),
    .mgt_txpreemphasis(mgt_txpreemphasis),
    .mgt_txdiffctrl(mgt_txdiffctrl),
    .mgt_rx_rst(mgt_rx_rst),
    .mgt_rxdata(mgt_rxdata),
    .mgt_rxcharisk(mgt_rxcharisk),
    .mgt_rxcodecomma(mgt_rxcodecomma),
    .mgt_rxencommaalign(mgt_rxencommaalign),
    .mgt_rxenchansync(mgt_rxenchansync),
    .mgt_rxsyncok(mgt_rxsyncok),
    .mgt_rxcodevalid(mgt_rxcodevalid),
    .mgt_rxbufferr(mgt_rxbufferr),
    .mgt_rxeqmix(mgt_rxeqmix),
    .mgt_rxlock(mgt_rxlock),
    .mgt_rxelecidle(),
    .mgt_status()
  );
  
endmodule
