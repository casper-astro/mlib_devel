`timescale 1ns/1ps
module gbe_udp #(
  /* Enable the application interface at startup */
    parameter LOCAL_ENABLE = 0,
  /* Default local MAC */
    parameter LOCAL_MAC = 0,
  /* Default local IP */
    parameter LOCAL_IP = 0,
  /* Default application UDP port */
    parameter LOCAL_PORT = 0,
  /* Default local gateway */
    parameter LOCAL_GATEWAY = 0,
  /* Default promiscuous mode (no MAC matching for CPU interface in promiscuous mode) */
    parameter CPU_PROMISCUOUS = 0,
  /* Disable CPU_TX */
    parameter DIS_CPU_TX = 0,
  /* Disable CPU_RX */
    parameter DIS_CPU_RX = 0,
  /* */
    parameter C_BASEADDR = 32'hffff_ffff,
  /* */
    parameter C_HIGHADDR = 32'h00,
  /* */
    parameter C_OPB_AWIDTH = 32'hFFFF,
  /* */
    parameter C_OPB_DWIDTH = 32'hFFFF
  ) (
  /**** Application Interface ****/
    input         app_clk,

    input   [7:0] app_tx_data,
    input         app_tx_dvld,
    input         app_tx_eof,
    input  [31:0] app_tx_destip,
    input  [15:0] app_tx_destport,

    output        app_tx_afull,
    output        app_tx_overflow,
    input         app_tx_rst,

    output  [7:0] app_rx_data,
    output        app_rx_dvld,
    output        app_rx_eof,
    output [31:0] app_rx_srcip,
    output [15:0] app_rx_srcport,
    output        app_rx_badframe,

    output        app_rx_overrun,
    input         app_rx_ack,
    input         app_rx_rst,

  /**** Debug Interface ****/
    output [31:0] app_dbg_data,
    output        app_dbg_dvld, 
    //output [7:0]  led,


  /**** MAC Interface ****/

    input         mac_tx_clk,
    input         mac_tx_rst,
    output  [7:0] mac_tx_data,
    output        mac_tx_dvld,
    input         mac_tx_ack,

    input         mac_rx_clk,
    input         mac_rx_rst,
    input   [7:0] mac_rx_data,
    input         mac_rx_dvld,
    input         mac_rx_goodframe,
    input         mac_rx_badframe,
    input         mac_syncacquired,

// Wishbone Bus
  /**** CPU Bus Attachment ****/
/*
    input         OPB_Clk,
    input         wb_rst_i,
    input         wb_stb_i,
    input         wb_cyc_i,
    input         wb_we_i,
    input  [31:0] wb_adr_i,
    input  [31:0] wb_dat_i,
    input   [3:0] wb_sel_i,
    output [31:0] wb_dat_o,
    output        wb_err_o,
    output        wb_ack_o */

// OPB Bus
  /**** CPU Bus Attachment ****/
    input         OPB_Clk,
    input         OPB_Rst,
    input         OPB_RNW,
    input         OPB_select,
    input   [3:0] OPB_BE,
    input  [31:0] OPB_ABus,
    input  [31:0] OPB_DBus,
    output [31:0] Sl_DBus,
    output        Sl_errAck,
    output        Sl_retry,
    output        Sl_toutSup,
    output        Sl_xferAck,i
  );

/****** Wishbone attachment ******/

  /* Common CPU signals */
  wire        local_enable;
  wire [47:0] local_mac;
  wire [31:0] local_ip;
  wire [15:0] local_port;
  wire  [7:0] local_gateway;

  /* ARP cache CPU signals */
  wire  [7:0] arp_cpu_cache_index;
  wire [47:0] arp_cpu_cache_rd_data;
  wire [47:0] arp_cpu_cache_wr_data;
  wire        arp_cpu_cache_wr_en;

  /* CPU TX signals */
  wire  [8:0] cputx_cpu_addr;
  wire [31:0] cputx_cpu_rd_data;
  wire [31:0] cputx_cpu_wr_data;
  wire        cputx_cpu_wr_en;

  wire [10:0] cpu_tx_size; //up to 2k
  wire        cpu_tx_packet_ready;
  wire        cpu_tx_packet_ack;

  /* CPU RX signals */
  wire  [8:0] cpurx_cpu_addr;
  wire [31:0] cpurx_cpu_rd_data;

  wire [10:0] cpu_rx_size; //up to 2k
  wire        cpu_rx_packet_ready;
  wire        cpu_rx_packet_ack;

  wire        cpu_promiscuous;
  
  // Debug 
  assign app_mac_tx_clk_cnt = 0;
  assign app_mac_rx_clk_cnt = 0; 
  assign app_app_clk_cnt = 0;
  assign app_mac_tx_ack = 0;

generate if (DIS_CPU_RX || DIS_CPU_TX) begin : disable_cpu

  assign local_enable = LOCAL_ENABLE;
  assign local_mac = LOCAL_MAC;
  assign local_ip = LOCAL_IP;
  assign local_port = LOCAL_PORT;
  assign local_gateway = LOCAL_GATEWAY;
  assign cpu_promiscuous = 1'b1;
  assign arp_tx_cache_rd_data = LOCAL_MAC;  

end else begin : enable_cpu

// Wishbone Bus
/*
  gbe_cpu_attach #(
    .LOCAL_ENABLE    (LOCAL_ENABLE),
    .LOCAL_MAC       (LOCAL_MAC),
    .LOCAL_IP        (LOCAL_IP),
    .LOCAL_PORT      (LOCAL_PORT),
    .LOCAL_GATEWAY   (LOCAL_GATEWAY),
    .CPU_PROMISCUOUS (CPU_PROMISCUOUS),
    .PHY_CONFIG      (PHY_CONFIG)
  ) gbe_cpu_attach_inst (
    .OPB_Clk (OPB_Clk),
    .wb_rst_i (wb_rst_i),
    .wb_stb_i (wb_stb_i),
    .wb_cyc_i (wb_cyc_i),
    .wb_we_i  (wb_we_i),
    .wb_adr_i (wb_adr_i),
    .wb_dat_i (wb_dat_i),
    .wb_sel_i (wb_sel_i),
    .wb_dat_o (wb_dat_o),
    .wb_err_o (wb_err_o),
    .wb_ack_o (wb_ack_o),
  // Common CPU signals 
    .local_enable  (local_enable),
    .local_mac     (local_mac),
    .local_ip      (local_ip),
    .local_port    (local_port),
    .local_gateway (local_gateway),

    .cpu_promiscuous (cpu_promiscuous),

  // ARP cache CPU signals 
    .arp_cache_addr    (arp_cpu_cache_index),
    .arp_cache_rd_data (arp_cpu_cache_rd_data),
    .arp_cache_wr_data (arp_cpu_cache_wr_data),
    .arp_cache_wr_en   (arp_cpu_cache_wr_en),

  // CPU RX signals 
    .cpu_rx_buffer_addr    (cpurx_cpu_addr),
    .cpu_rx_buffer_rd_data (cpurx_cpu_rd_data),
    .cpu_rx_size           (cpu_rx_size),
    .cpu_rx_ready          (cpu_rx_packet_ready),
    .cpu_rx_ack            (cpu_rx_packet_ack),

  // CPU TX signals 
    .cpu_tx_buffer_addr    (cputx_cpu_addr),
    .cpu_tx_buffer_rd_data (cputx_cpu_rd_data),
    .cpu_tx_buffer_wr_data (cputx_cpu_wr_data),
    .cpu_tx_buffer_wr_en   (cputx_cpu_wr_en),
    .cpu_tx_size           (cpu_tx_size),
    .cpu_tx_ready          (cpu_tx_packet_ready),
    .cpu_tx_done           (cpu_tx_packet_ack),
  // PHY Status/Control 
    .phy_status   (phy_status),
    .phy_control  (phy_control)
  ); */


// OPB Bus
  gbe_cpu_attach #(
    .LOCAL_ENABLE    (LOCAL_ENABLE),
    .LOCAL_MAC       (LOCAL_MAC),
    .LOCAL_IP        (LOCAL_IP),
    .LOCAL_PORT      (LOCAL_PORT),
    .LOCAL_GATEWAY   (LOCAL_GATEWAY),
    .CPU_PROMISCUOUS (CPU_PROMISCUOUS),
    .C_BASEADDR      (C_BASEADDR),
    .C_HIGHADDR      (C_HIGHADDR),
    .C_OPB_AWIDTH    (C_OPB_AWIDTH),
    .C_OPB_DWIDTH    (C_OPB_DWIDTH)
  ) gbe_cpu_attach_inst (
    .OPB_Clk    (OPB_Clk),
    .OPB_Rst    (OPB_Rst),
    .OPB_RNW    (OPB_RNW),
    .OPB_select (OPB_select),
    //.OPB_seqAddr (OPB_seqAddr),
    .OPB_BE (OPB_BE),
    .OPB_ABus   (OPB_ABus),
    .OPB_DBus   (OPB_DBus),
    .Sl_DBus    (Sl_DBus),
    .Sl_errAck  (Sl_errAck),
    .Sl_retry   (Sl_retry),
    .Sl_toutSup (Sl_toutSup), 
    .Sl_xferAck (Sl_xferAck),
  // Common CPU signals 
    .local_enable  (local_enable),
    .local_mac     (local_mac),
    .local_ip      (local_ip),
    .local_port    (local_port),
    .local_gateway (local_gateway),

    .cpu_promiscuous (cpu_promiscuous),

  // ARP cache CPU signals 
    .arp_cache_addr    (arp_cpu_cache_index),
    .arp_cache_rd_data (arp_cpu_cache_rd_data),
    .arp_cache_wr_data (arp_cpu_cache_wr_data),
    .arp_cache_wr_en   (arp_cpu_cache_wr_en),

  // CPU RX signals 
    .cpu_rx_buffer_addr    (cpurx_cpu_addr),
    .cpu_rx_buffer_rd_data (cpurx_cpu_rd_data),
    .cpu_rx_size           (cpu_rx_size),
    .cpu_rx_ready          (cpu_rx_packet_ready),
    .cpu_rx_ack            (cpu_rx_packet_ack),

  // CPU TX signals 
    .cpu_tx_buffer_addr    (cputx_cpu_addr),
    .cpu_tx_buffer_rd_data (cputx_cpu_rd_data),
    .cpu_tx_buffer_wr_data (cputx_cpu_wr_data),
    .cpu_tx_buffer_wr_en   (cputx_cpu_wr_en),
    .cpu_tx_size           (cpu_tx_size),
    .cpu_tx_ready          (cpu_tx_packet_ready),
    .cpu_tx_done           (cpu_tx_packet_ack)
  );

end endgenerate

/*** buffer size clock domain crossing ***/

  wire [10:0] cpu_rx_size_unstable;
  wire [10:0] cpu_tx_size_stable;
  assign cpu_rx_size = cpu_rx_size_unstable;
  assign cpu_tx_size_stable = cpu_tx_size;

  /* possible meta stability cause here
     although with handshake problems are VERY unlikely */

/*** CPU buffer Handshake clock domain crossing ***/
  wire cpu_rx_packet_ready_unstable;
  wire cpu_rx_packet_ack_stable;

  wire cpu_tx_packet_ready_stable;
  wire cpu_tx_packet_ack_unstable;

  /* RX */
  reg cpu_rx_packet_readyR;
  reg cpu_rx_packet_readyRR;

  reg cpu_rx_packet_ackR;
  reg cpu_rx_packet_ackRR;

  always @(posedge OPB_Clk) begin
    cpu_rx_packet_readyR  <= cpu_rx_packet_ready_unstable;
    cpu_rx_packet_readyRR <= cpu_rx_packet_readyR;
  end
  assign cpu_rx_packet_ready = cpu_rx_packet_readyRR;

  always @(posedge mac_rx_clk) begin
    cpu_rx_packet_ackR  <= cpu_rx_packet_ack;
    cpu_rx_packet_ackRR <= cpu_rx_packet_ackR;
  end
  assign cpu_rx_packet_ack_stable = cpu_rx_packet_ackRR;

  /* TX */
  reg cpu_tx_packet_readyR;
  reg cpu_tx_packet_readyRR;

  always @(posedge mac_tx_clk) begin
    cpu_tx_packet_readyR  <= cpu_tx_packet_ready;
    cpu_tx_packet_readyRR <= cpu_tx_packet_readyR;
  end
  assign cpu_tx_packet_ready_stable = cpu_tx_packet_readyRR;

  reg cpu_tx_packet_ackR;
  reg cpu_tx_packet_ackRR;

  always @(posedge OPB_Clk) begin
    cpu_tx_packet_ackR  <= cpu_tx_packet_ack_unstable;
    cpu_tx_packet_ackRR <= cpu_tx_packet_ackR;
  end
  assign cpu_tx_packet_ack = cpu_tx_packet_ackRR;

/****** TX Logic ******/
  /* ARP cache TX logic signals */
  wire  [7:0] arp_tx_cache_index;
  wire [47:0] arp_tx_cache_rd_data;

  /* CPU buffer TX logic signals */
  wire [10:0] cputx_tx_addr;
  wire  [7:0] cputx_tx_rd_data;
  wire        cpu_tx_buffer_sel;
  wire        cpu_tx_buffer_sel_unstable;
  
/****** ARP Cache ******/

  /* TODO: Optimization - shave off 1 bram
     A 48-bit memory will use two brams on virtex-6 (and others)
     due to the native BRAM geometry of 32x1k.  However, 
     we could quite comfortably use a 24 bit memory and time
     multiplex to make up 48 bits. */

  gbe_arp_cache arp_cache_inst (
    .clka  (OPB_Clk),
    .addra (arp_cpu_cache_index),
    .douta (arp_cpu_cache_rd_data),
    .dina  (arp_cpu_cache_wr_data),
    .wea   (arp_cpu_cache_wr_en),

    .clkb  (mac_tx_clk),
    .addrb (arp_tx_cache_index),
    .doutb (arp_tx_cache_rd_data),
    .dinb  (48'b0),
    .web   (1'b0)
  );

  gbe_tx gbe_tx_inst (
    .app_clk         (app_clk),
    .app_rst         (app_tx_rst),
    .app_data        (app_tx_data),
    .app_dvld        (app_tx_dvld),
    .app_eof         (app_tx_eof),
    .app_destip      (app_tx_destip),
    .app_destport    (app_tx_destport),
    .app_afull       (app_tx_afull),
    .app_overflow    (app_tx_overflow),

    .mac_clk      (mac_tx_clk),
    .mac_rst      (mac_tx_rst),
    .mac_tx_data  (mac_tx_data),
    .mac_tx_dvld  (mac_tx_dvld),
    .mac_tx_ack   (mac_tx_ack),

    .local_enable  (local_enable),
    .local_mac     (local_mac),
    .local_ip      (local_ip),
    .local_port    (local_port),
    .local_gateway (local_gateway),

    .arp_cache_addr    (arp_tx_cache_index),
    .arp_cache_rd_data (arp_tx_cache_rd_data),

    .cpu_tx_buffer_addr    (cputx_tx_addr),
    .cpu_tx_buffer_rd_data (cputx_tx_rd_data),
    .cpu_tx_size           (cpu_tx_size_stable),
    .cpu_tx_ready          (cpu_tx_packet_ready_stable),
    .cpu_tx_done           (cpu_tx_packet_ack_unstable),
    .cpu_buffer_sel        (cpu_tx_buffer_sel_unstable)
  );

// END Clock counter debugs

  reg cpu_tx_buffer_selR;
  reg cpu_tx_buffer_selRR;
  always @(posedge OPB_Clk) begin
    cpu_tx_buffer_selR  <= cpu_tx_buffer_sel_unstable;
    cpu_tx_buffer_selRR <= cpu_tx_buffer_selR;
  end
  assign cpu_tx_buffer_sel = cpu_tx_buffer_selRR;

/****** RX Logic ******/

  wire mac_rx_dvld_i;
wire [7:0] mac_rx_data_i;

  /* CPU buffer RX logic signals */
  wire [10:0] cpurx_rx_addr;
  wire  [7:0] cpurx_rx_wr_data;
  wire        cpurx_rx_wr_en;
  wire        cpu_rx_buffer_sel;
  wire        cpu_rx_buffer_sel_unstable;

  gbe_rx #(
    .DIS_CPU(DIS_CPU_RX)
  ) gbe_rx_inst (
    .app_clk      (app_clk),
    .app_rst      (app_rx_rst),
    .app_data     (app_rx_data),
    .app_dvld     (app_rx_dvld),
    .app_ack      (app_rx_ack),
    .app_eof      (app_rx_eof),
    .app_srcip    (app_rx_srcip),
    .app_srcport  (app_rx_srcport),
    .app_badframe (app_rx_badframe),
    .app_overrun  (app_rx_overrun),

    .mac_clk          (mac_rx_clk),
    .mac_rst          (mac_rx_rst),
    //.mac_rx_data      (mac_rx_data),
    //.mac_rx_dvld      (mac_rx_dvld),
    .mac_rx_data      (mac_rx_data_i),
    .mac_rx_dvld      (mac_rx_dvld_i),
    .mac_rx_goodframe (mac_rx_goodframe),
    .mac_rx_badframe  (mac_rx_badframe),

    .local_enable  (local_enable),
    .local_mac     (local_mac),
    .local_ip      (local_ip),
    .local_port    (local_port),

    .cpu_promiscuous (cpu_promiscuous),

    .cpu_addr       (cpurx_rx_addr),
    .cpu_wr_data    (cpurx_rx_wr_data),
    .cpu_wr_en      (cpurx_rx_wr_en),
    .cpu_size       (cpu_rx_size_unstable),
    .cpu_ready      (cpu_rx_packet_ready_unstable),
    .cpu_ack        (cpu_rx_packet_ack_stable),
    .cpu_buffer_sel (cpu_rx_buffer_sel_unstable)
  );

// >>>>>>>>>>>>>>>> DEBUG
// Route the incomming MAC data to the yellow block 

  assign app_dbg_data = {14'h0,mac_rx_dvld, mac_tx_dvld, mac_rx_data, mac_tx_data};
  assign app_dbg_dvld = mac_tx_dvld || mac_rx_dvld;

  assign mac_rx_data_i = mac_rx_data;
  assign mac_rx_dvld_i = mac_rx_dvld;

  reg cpu_rx_buffer_selR;
  reg cpu_rx_buffer_selRR;
  always @(posedge OPB_Clk) begin
    cpu_rx_buffer_selR  <= cpu_rx_buffer_sel_unstable;
    cpu_rx_buffer_selRR <= cpu_rx_buffer_selR;
  end
  assign cpu_rx_buffer_sel = cpu_rx_buffer_selRR;


/****** TX Buffer ******/

generate if (DIS_CPU_TX) begin : disable_cpu_tx

  assign cputx_cpu_rd_data = 32'b0;
  assign cputx_tx_rd_data  = 8'b0;

end else begin : enable_cpu_tx

  gbe_cpu_buffer cpu_buffer_tx(
    .clka  (OPB_Clk),
    .addra ({!cpu_tx_buffer_sel, cputx_cpu_addr}),
    .douta ({cputx_cpu_rd_data[ 7:0 ], cputx_cpu_rd_data[15:8],
             cputx_cpu_rd_data[23:16], cputx_cpu_rd_data[31:24]}),
    .dina  ({cputx_cpu_wr_data[ 7:0 ], cputx_cpu_wr_data[15:8],
             cputx_cpu_wr_data[23:16], cputx_cpu_wr_data[31:24]}),
    .wea   ({4{cputx_cpu_wr_en}}),

    .clkb  (mac_tx_clk),
    .addrb ({cpu_tx_buffer_sel_unstable, cputx_tx_addr}),
    .doutb (cputx_tx_rd_data),
    .dinb  (8'b0),
    .web   (1'b0)
  );
end endgenerate

/****** RX Buffer ******/

generate if (DIS_CPU_RX) begin : disable_cpu_rx

  assign cpurx_cpu_rd_data = 32'b0;

end else begin : enable_cpu_rx

  gbe_cpu_buffer cpu_buffer_rx(
    .clka  (OPB_Clk),
    .addra ({!cpu_rx_buffer_sel, cpurx_cpu_addr}),
    .douta ({cpurx_cpu_rd_data[ 7:0 ], cpurx_cpu_rd_data[15:8],
             cpurx_cpu_rd_data[23:16], cpurx_cpu_rd_data[31:24]}),
    .dina  (32'b0),
    .wea   (4'b0),

    .clkb  (mac_rx_clk),
    .addrb ({cpu_rx_buffer_sel, cpurx_rx_addr}),
    .doutb (),
    .dinb  (cpurx_rx_wr_data),
    .web   ({1{cpurx_rx_wr_en}})
  );

end endgenerate



endmodule
