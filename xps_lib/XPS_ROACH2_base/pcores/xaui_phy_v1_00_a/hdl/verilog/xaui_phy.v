module xaui_phy(
    xaui_clk,
    reset,
    /* mgt signals */
    mgt_txdata,
    mgt_txcharisk,
    mgt_rxdata,
    mgt_rxcharisk,
    mgt_enable_align,
    mgt_en_chan_sync, 
    mgt_code_valid,
    mgt_rxbufferr,
    mgt_code_comma,
    mgt_rxlock,
    mgt_syncok,
    mgt_tx_reset,
    mgt_rx_reset,
    /* XAUI signals */
    xgmii_txd,
    xgmii_txc,
    xgmii_rxd,
    xgmii_rxc,
    xaui_status
  );

  input  xaui_clk, reset;
  /* mgt signals */
  output [63:0] mgt_txdata;
  output  [7:0] mgt_txcharisk;
  input   [63:0] mgt_rxdata;
  input   [7:0] mgt_rxcharisk;
  output  [3:0] mgt_enable_align;
  output  mgt_en_chan_sync;
  input   [7:0] mgt_code_valid;
  input   [7:0] mgt_code_comma;
  input   [3:0] mgt_rxbufferr;
  input   [3:0] mgt_rxlock;
  input   [3:0] mgt_syncok;
  output  mgt_tx_reset;
  output  mgt_rx_reset;
    /* XAUI signals */
  input  [63:0] xgmii_txd;
  input   [7:0] xgmii_txc;
  output [63:0] xgmii_rxd;
  output  [7:0] xgmii_rxc;
  output  [7:0] xaui_status;

  wire [6:0] xaui_configuration_vector;
  wire [3:0] xaui_tx_reset, xaui_rx_reset; 

  wire mgt_rx_reset_int; 
  assign xaui_configuration_vector = {
      2'b0,                     //Test Select
      1'b0,                     //TODO Test Enable,
      mgt_rx_reset,               //reset rx link status
      mgt_rx_reset,               //reset local fault status
      1'b0,                     //power down
      1'b0                      //loopback
    };

  xaui_v9_1  xaui_inst(
    .reset  (reset),   
    .usrclk (xaui_clk),
    /* client side */
    .xgmii_txd (xgmii_txd),
    .xgmii_txc (xgmii_txc),
    .xgmii_rxd (xgmii_rxd),
    .xgmii_rxc (xgmii_rxc),
    /* mgt side */
    .mgt_txdata       (mgt_txdata),
    .mgt_txcharisk    (mgt_txcharisk),
    .mgt_rxdata       (mgt_rxdata),
    .mgt_rxcharisk    (mgt_rxcharisk),
    .mgt_codevalid    (mgt_code_valid),
    .mgt_codecomma    (mgt_code_comma),
    .mgt_enable_align (mgt_enable_align),
    .mgt_enchansync   (mgt_en_chan_sync),
    .mgt_syncok       (mgt_syncok),
    .mgt_loopback     (),
    .mgt_powerdown    (),
    .mgt_rxlock       (mgt_rxlock),
    /* status & configuration*/
    .configuration_vector (xaui_configuration_vector),
    .status_vector        (xaui_status),
    .align_status         (),
    .sync_status          (),
    .mgt_tx_reset         (xaui_tx_reset),
    .mgt_rx_reset         (xaui_rx_reset),
    .signal_detect        (4'b1111)
  );
  // synthesis attribute box_type xaui_inst "user_black_box"

  /**************** Resets ***********************/

  assign mgt_tx_reset = 1'b0;
  assign xaui_tx_reset = {4{mgt_tx_reset}};

  reg reset_state;
  localparam LOOK = 1'b0;
  localparam WAIT = 1'b1;

  localparam WAIT_BITS = 24;

  reg [WAIT_BITS - 1:0] wait_counter;
  always @(posedge xaui_clk) begin
    if (reset) begin
      reset_state <= LOOK;
      wait_counter <= 0;
    end else begin
      case (reset_state)
        LOOK: begin
          if (xaui_status[6:2] != 5'b11111) begin
            wait_counter <= {WAIT_BITS{1'b1}};
            reset_state  <= WAIT;
          end
        end
        WAIT: begin
          if (|wait_counter) begin
            wait_counter <= wait_counter - {{WAIT_BITS - 1{1'b0}}, 1'b1};
          end else begin
            reset_state  <= LOOK;
          end
        end
      endcase
    end
  end

  reg [3:0] mgt_rx_reset_stretch;
  always @(posedge xaui_clk) begin
    if (reset_state == LOOK && xaui_status[6:2] != 5'b11111) begin
      mgt_rx_reset_stretch <= 4'b1111;
    end else begin
      if (mgt_rx_reset_stretch)
        mgt_rx_reset_stretch <= mgt_rx_reset_stretch - 4'b1;
    end
  end

  assign xaui_rx_reset = {4{mgt_rx_reset_stretch != 4'b0}};
  assign mgt_rx_reset_int = {mgt_rx_reset_stretch != 4'b0};
  assign mgt_rx_reset = mgt_rx_reset_int;
  
endmodule
