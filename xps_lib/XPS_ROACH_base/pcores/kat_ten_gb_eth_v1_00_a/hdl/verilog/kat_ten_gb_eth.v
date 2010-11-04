`timescale 1ns/1ps
module kat_ten_gb_eth #(
    parameter C_BASEADDR     = 32'h0,
    parameter C_HIGHADDR     = 32'hffff,
    parameter C_OPB_AWIDTH   = 32,
    parameter C_OPB_DWIDTH   = 32,
    parameter FABRIC_MAC     = 48'hffff_ffff_ffff,
    parameter FABRIC_IP      = 32'hffff_ffff,
    parameter FABRIC_PORT    = 16'hffff,
    parameter FABRIC_GATEWAY = 8'd0,
    parameter FABRIC_ENABLE  = 0,
    parameter SWING          = 1,
    parameter PREEMPHASYS    = 1,
    parameter CPU_TX_ENABLE  = 1,
    parameter CPU_RX_ENABLE  = 1,
    parameter RX_DIST_RAM    = 0,
    parameter LARGE_PACKETS  = 0
  ) (
    input         clk,
    input         rst,

    input         tx_valid,
    input         tx_end_of_frame,
    input  [63:0] tx_data,
    input  [31:0] tx_dest_ip,
    input  [15:0] tx_dest_port,
    output        tx_overflow, 
    output        tx_afull, 

    output        rx_valid,
    output        rx_end_of_frame,
    output [63:0] rx_data,
    output [31:0] rx_source_ip,
    output [15:0] rx_source_port,
    output        rx_bad_frame,
    output        rx_overrun,
    input         rx_overrun_ack,
    input         rx_ack,

    input         OPB_Clk,
    input         OPB_Rst,
    input         OPB_RNW,
    input         OPB_select,
    input         OPB_seqAddr,
    input   [3:0] OPB_BE,
    input  [31:0] OPB_ABus,
    input  [31:0] OPB_DBus,
    output [31:0] Sl_DBus,
    output        Sl_errAck,
    output        Sl_retry,
    output        Sl_toutSup,
    output        Sl_xferAck,

    output        led_up,
    output        led_rx,
    output        led_tx,

    input         xaui_clk,
    input         xaui_reset,
    input   [7:0] xaui_status,
    output [63:0] xgmii_txd,
    output  [7:0] xgmii_txc,
    input  [63:0] xgmii_rxd,
    input   [7:0] xgmii_rxc,

    output  [1:0] mgt_rxeqmix,
    output  [3:0] mgt_rxeqpole,
    output  [2:0] mgt_txpreemphasis,
    output  [2:0] mgt_txdiffctrl
  );

  /**************************************** MAC Controller ***************************************/

  wire        mac_rst;
  wire        mac_clk;
  wire [63:0] mac_tx_data;
  wire  [7:0] mac_tx_data_valid;
  wire        mac_tx_start;
  wire        mac_tx_ack;

  wire [63:0] mac_rx_data;
  wire  [7:0] mac_rx_data_valid;
  wire        mac_rx_good_frame;
  wire        mac_rx_bad_frame;

  ten_gig_eth_mac ten_gig_eth_mac_inst (
    .reset                (mac_rst  ),
    .tx_clk0              (mac_clk  ),
    .tx_dcm_lock          (1'b1     ),
    .rx_clk0              (mac_clk  ),
    .rx_dcm_lock          (1'b1     ),
    // transmit interface
    .tx_underrun          (1'b0             ),
    .tx_data              (mac_tx_data      ),
    .tx_data_valid        (mac_tx_data_valid),
    .tx_start             (mac_tx_start     ),
    .tx_ack               (mac_tx_ack       ),
    .tx_ifg_delay         (8'b0             ),
    .tx_statistics_vector (),
    .tx_statistics_valid  (),
    // receive interface
    .rx_data              (mac_rx_data      ),
    .rx_data_valid        (mac_rx_data_valid),
    .rx_good_frame        (mac_rx_good_frame),
    .rx_bad_frame         (mac_rx_bad_frame ),
    .rx_statistics_vector (),
    .rx_statistics_valid  (),
    // flow_control interface
    .pause_val            (16'b0),
    .pause_req            (1'b0 ),
    // configuration
    .configuration_vector (67'b0),
    // phy interface
    .xgmii_txd            (xgmii_txd),
    .xgmii_txc            (xgmii_txc),
    .xgmii_rxd            (xgmii_rxd),
    .xgmii_rxc            (xgmii_rxc)
  );

  assign mac_clk = xaui_clk;
  assign mac_rst = xaui_reset;

  /**************************************** CPU Controller ***************************************/
  wire cpu_clk = OPB_Clk;
  wire cpu_rst = OPB_Rst;

  // Local parameter register outputs
  wire        soft_reset_cpu;
  wire        soft_reset_ack_cpu;
  wire        local_enable;
  wire [47:0] local_mac;
  wire [31:0] local_ip;
  wire [15:0] local_port;
  wire  [7:0] local_gateway;

  // CPU Arp Cache signals;
  wire  [7:0] arp_cache_addr;
  wire [47:0] arp_cache_rd_data;
  wire [47:0] arp_cache_wr_data;
  wire        arp_cache_wr_en;

  // CPU TX signals
  wire  [7:0] cpu_tx_buffer_addr;
  wire [63:0] cpu_tx_buffer_rd_data;
  wire [63:0] cpu_tx_buffer_wr_data;
  wire        cpu_tx_buffer_wr_en;
  wire  [7:0] cpu_tx_size;
  wire        cpu_tx_ready;
  wire        cpu_tx_done;

  // CPU RX signals
  wire  [7:0] cpu_rx_buffer_addr;
  wire [63:0] cpu_rx_buffer_rd_data;
  wire  [7:0] cpu_rx_size;
  wire        cpu_rx_ack;

  /* CPU Module */

  opb_attach #(
    .C_BASEADDR     (C_BASEADDR    ),
    .C_HIGHADDR     (C_HIGHADDR    ),
    .C_OPB_AWIDTH   (C_OPB_AWIDTH  ),
    .C_OPB_DWIDTH   (C_OPB_DWIDTH  ),
    .FABRIC_MAC     (FABRIC_MAC    ),
    .FABRIC_IP      (FABRIC_IP     ),
    .FABRIC_PORT    (FABRIC_PORT   ),
    .FABRIC_GATEWAY (FABRIC_GATEWAY),
    .FABRIC_ENABLE  (FABRIC_ENABLE ),
    .SWING          (SWING         ),
    .PREEMPHASYS    (PREEMPHASYS   )
  ) opb_attach_inst (
    //OPB attachment
    .OPB_Clk     (OPB_Clk),
    .OPB_Rst     (OPB_Rst),
    .OPB_RNW     (OPB_RNW),
    .OPB_select  (OPB_select),
    .OPB_seqAddr (OPB_seqAddr),
    .OPB_BE      (OPB_BE),
    .OPB_ABus    (OPB_ABus),
    .OPB_DBus    (OPB_DBus),
    .Sl_DBus     (Sl_DBus),
    .Sl_errAck   (Sl_errAck),
    .Sl_retry    (Sl_retry),
    .Sl_toutSup  (Sl_toutSup),
    .Sl_xferAck  (Sl_xferAck),
    //tx_buffer bits
    .cpu_tx_buffer_addr    (cpu_tx_buffer_addr),
    .cpu_tx_buffer_rd_data (cpu_tx_buffer_rd_data),
    .cpu_tx_buffer_wr_data (cpu_tx_buffer_wr_data),
    .cpu_tx_buffer_wr_en   (cpu_tx_buffer_wr_en),
    .cpu_tx_size           (cpu_tx_size),
    .cpu_tx_ready          (cpu_tx_ready),
    .cpu_tx_done           (cpu_tx_done),
    //rx_buffer bits
    .cpu_rx_buffer_addr    (cpu_rx_buffer_addr),
    .cpu_rx_buffer_rd_data (cpu_rx_buffer_rd_data),
    .cpu_rx_size           (cpu_rx_size),
    .cpu_rx_ack            (cpu_rx_ack),
    //ARP Cache
    .arp_cache_addr    (arp_cache_addr),
    .arp_cache_rd_data (arp_cache_rd_data),
    .arp_cache_wr_data (arp_cache_wr_data),
    .arp_cache_wr_en   (arp_cache_wr_en),
    //local registers
    .local_enable  (local_enable),
    .local_mac     (local_mac),
    .local_ip      (local_ip),
    .local_port    (local_port),
    .local_gateway (local_gateway),
    //software tge reset (app_reset only)
    .soft_reset     (soft_reset_cpu),
    .soft_reset_ack (soft_reset_ack_cpu),
    //xaui status
    .xaui_status       (xaui_status),
    //MGT/GTP PMA Config
    .mgt_rxeqmix       (mgt_rxeqmix),
    .mgt_rxeqpole      (mgt_rxeqpole),
    .mgt_txpreemphasis (mgt_txpreemphasis),
    .mgt_txdiffctrl    (mgt_txdiffctrl)
  );

  /**************************** TGE transmit logic ******************************/
  wire usr_rst; //software user reset
  reg app_rst;
  always @(posedge clk) begin
    app_rst <= rst || usr_rst;
  end

  tge_tx #(
    .CPU_ENABLE          (CPU_TX_ENABLE),
    .LARGE_PACKETS       (LARGE_PACKETS)
  ) tge_tx_inst (
    // Local parameters
    .local_enable        (local_enable),
    .local_mac           (local_mac),
    .local_ip            (local_ip),
    .local_port          (local_port),
    .local_gateway       (local_gateway),
    // CPU Arp Cache signals;
    .arp_cache_addr      (arp_cache_addr),
    .arp_cache_rd_data   (arp_cache_rd_data),
    .arp_cache_wr_data   (arp_cache_wr_data),
    .arp_cache_wr_en     (arp_cache_wr_en),
    // Application Interface
    .app_clk             (clk),
    .app_rst             (app_rst),
    .app_tx_valid        (tx_valid),
    .app_tx_end_of_frame (tx_end_of_frame),
    .app_tx_data         (tx_data),
    .app_tx_dest_ip      (tx_dest_ip),
    .app_tx_dest_port    (tx_dest_port),
    .app_tx_overflow     (tx_overflow), 
    .app_tx_afull        (tx_afull), 
    // CPU Interface
    .cpu_clk               (cpu_clk),
    .cpu_rst               (cpu_rst),
    .cpu_tx_buffer_addr    (cpu_tx_buffer_addr),
    .cpu_tx_buffer_rd_data (cpu_tx_buffer_rd_data),
    .cpu_tx_buffer_wr_data (cpu_tx_buffer_wr_data),
    .cpu_tx_buffer_wr_en   (cpu_tx_buffer_wr_en),
    .cpu_tx_size           (cpu_tx_size),
    .cpu_tx_ready          (cpu_tx_ready),
    .cpu_tx_done           (cpu_tx_done),
    // Mac
    .mac_clk           (mac_clk),
    .mac_rst           (mac_rst),
    .mac_tx_data       (mac_tx_data),
    .mac_tx_data_valid (mac_tx_data_valid),
    .mac_tx_start      (mac_tx_start),
    .mac_tx_ack        (mac_tx_ack)
  );

  /**************************** TGE receive logic ******************************/

  tge_rx #(
    .CPU_ENABLE          (CPU_RX_ENABLE),
    .USE_DISTRIBUTED_RAM (RX_DIST_RAM)
  ) tge_rx_inst (
    // Local Parameters
    .local_enable (local_enable),
    .local_mac    (local_mac),
    .local_ip     (local_ip),
    .local_port   (local_port),
    // Application Interface
    .app_clk             (clk),
    .app_rst             (app_rst),
    .app_rx_valid        (rx_valid),
    .app_rx_end_of_frame (rx_end_of_frame),
    .app_rx_data         (rx_data),
    .app_rx_source_ip    (rx_source_ip),
    .app_rx_source_port  (rx_source_port),
    .app_rx_bad_frame    (rx_bad_frame),
    .app_rx_overrun      (rx_overrun),
    .app_rx_overrun_ack  (rx_overrun_ack),
    .app_rx_ack          (rx_ack),
    // CPU Interface
    .cpu_clk               (cpu_clk),
    .cpu_rst               (cpu_rst),
    .cpu_rx_buffer_addr    (cpu_rx_buffer_addr),
    .cpu_rx_buffer_rd_data (cpu_rx_buffer_rd_data),
    .cpu_rx_size           (cpu_rx_size),
    .cpu_rx_ack            (cpu_rx_ack),
    // MAC Interface
    .mac_clk           (mac_clk),
    .mac_rst           (mac_rst),
    .mac_rx_data       (mac_rx_data),
    .mac_rx_data_valid (mac_rx_data_valid),
    .mac_rx_good_frame (mac_rx_good_frame),
    .mac_rx_bad_frame  (mac_rx_bad_frame),
    // PHY status
    .phy_rx_up (xaui_status[6:2] == 5'b11111)
  );

  /*********************** Software Reset Logic **************************/

  reg [1:0] swr_state;
  
  wire mac_reset_ack;
  wire mac_reset;

  reg mac_reset_ackR;
  reg mac_reset_ackRR;

  always @(posedge cpu_clk) begin
    mac_reset_ackR  <= mac_reset_ack;
    mac_reset_ackRR <= mac_reset_ackR;
    if (cpu_rst) begin
      swr_state <= 0;
    end else begin
      case (swr_state)
        0: begin
          if (soft_reset_cpu) begin
            swr_state <= 1;
          end
        end
        1: begin
          if (mac_reset_ackRR) begin
            swr_state <= 2;
          end
        end
        2: begin
          if (!mac_reset_ackRR) begin
          /* could wait for soft_reset to clear here, but why bother. */
            swr_state <= 0;
          end
        end
      endcase
    end
  end

  assign mac_reset          = swr_state == 1;
  assign soft_reset_ack_cpu = swr_state == 1 && mac_reset_ackRR;

  reg macr_state;

  reg mac_resetR;
  reg mac_resetRR;

  always @(posedge mac_clk) begin
    mac_resetR  <= mac_reset;
    mac_resetRR <= mac_resetR;

    if (mac_rst) begin
      macr_state <= 1'b0;
    end else begin
      case (macr_state)
        0: begin
          if (mac_resetRR)
            macr_state <= 1;
        end
        1: begin
          if (!mac_resetRR)
            macr_state <= 0;
        end
      endcase
    end
  end
  assign usr_rst       = macr_state && !mac_resetRR;
  assign mac_reset_ack = macr_state == 1;

  /******************************** LEDs *********************************/

  localparam LED_WIDTH = 26;

  reg [LED_WIDTH - 1:0] rx_stretch;
  reg [LED_WIDTH - 1:0] tx_stretch;
  reg [LED_WIDTH - 1:0] down_stretch;

  reg down_trig;
  reg rx_trig;
  reg tx_trig;

  always @(posedge mac_clk) begin
    down_trig <= xaui_status[6:2] != 5'b11111;
    rx_trig   <= mac_rx_good_frame;
    tx_trig   <= mac_tx_start;
    if (mac_rst) begin
      down_stretch <= {LED_WIDTH{1'b0}};
      rx_stretch   <= {LED_WIDTH{1'b0}};
      tx_stretch   <= {LED_WIDTH{1'b0}};
    end else begin
      if (down_stretch[LED_WIDTH-1]) begin
        down_stretch <= down_stretch - 1;
      end

      if (rx_stretch[LED_WIDTH-1]) begin
        rx_stretch <= rx_stretch - 1;
      end

      if (tx_stretch[LED_WIDTH-1]) begin
        tx_stretch <= tx_stretch - 1;
      end

      if (down_trig) begin
        down_stretch <= {LED_WIDTH{1'b1}};
      end

      if (rx_trig) begin
        rx_stretch <= {LED_WIDTH{1'b1}};
      end

      if (tx_trig) begin
        tx_stretch <= {LED_WIDTH{1'b1}};
      end
    end
  end

  reg led_up_reg; 
  reg led_rx_reg; 
  reg led_tx_reg; 

  always @(posedge clk) begin
    led_up_reg <= !down_stretch[LED_WIDTH-1];
    led_rx_reg <= rx_stretch[LED_WIDTH-1];
    led_tx_reg <= tx_stretch[LED_WIDTH-1];
  end

  assign led_up = led_up_reg;
  assign led_rx = led_rx_reg;
  assign led_tx = led_tx_reg;

endmodule
