module opb_attach(
    //OPB attachment
    OPB_Clk, OPB_Rst,
    OPB_select, OPB_BE, OPB_RNW,
    OPB_ABus, OPB_DBus,
    Sl_DBus,
    Sl_errAck, Sl_retry, Sl_toutSup, Sl_xferAck,
    OPB_seqAddr,
    //local configurtaion bits
    local_mac, local_ip, local_gateway, local_port, local_valid,
    //xaui status
    phy_status,
    //MGT/GTP PMA Config
    mgt_rxeqmix,
    mgt_rxeqpole,
    mgt_txpreemphasis,
    mgt_txdiffctrl,
    //tx_buffer bits
    tx_buffer_data_in, tx_buffer_address, tx_buffer_we, tx_buffer_data_out,
    tx_cpu_buffer_size, tx_cpu_free_buffer, tx_cpu_buffer_filled, tx_cpu_buffer_select,
    //rx_buffer bits
    rx_buffer_data_in, rx_buffer_address, rx_buffer_we, rx_buffer_data_out, 
    rx_cpu_buffer_size, rx_cpu_new_buffer, rx_cpu_buffer_cleared, rx_cpu_buffer_select,
    //ARP Cache
    arp_cache_data_in, arp_cache_address, arp_cache_we, arp_cache_data_out
  );
	parameter C_BASEADDR             = 32'h0;
	parameter C_HIGHADDR             = 32'hffff;
	parameter C_OPB_AWIDTH           = 32;
	parameter C_OPB_DWIDTH           = 32;
  parameter DEFAULT_FABRIC_MAC     = 48'hffff_ffff_ffff;
  parameter DEFAULT_FABRIC_IP      = {8'd255, 8'd255, 8'd255, 8'd255};
  parameter DEFAULT_FABRIC_GATEWAY = 8'hff;
  parameter DEFAULT_FABRIC_PORT    = 16'hffff;
  parameter FABRIC_RUN_ON_STARTUP  = 1;
  parameter DEFAULT_RXEQMIX        = 2'b0;
  parameter DEFAULT_RXEQPOLE       = 4'b0000;
  parameter DEFAULT_TXPREEMPHASIS  = 3'b000;
  parameter DEFAULT_TXDIFFCTRL     = 3'b100;

  input  OPB_Clk,  OPB_Rst;
  input  OPB_RNW, OPB_select;
  input  OPB_seqAddr;
  input   [3:0] OPB_BE;
  input  [31:0] OPB_ABus;
  input  [31:0] OPB_DBus;
  output [31:0] Sl_DBus;
  output Sl_errAck, Sl_retry, Sl_toutSup, Sl_xferAck;

  //local configuration bits
  output [47:0] local_mac;
  output [31:0] local_ip;
  output  [7:0] local_gateway;
  output [15:0] local_port;
  output local_valid;
  //tx_buffer bits
  output [63:0] tx_buffer_data_in;
  output  [8:0] tx_buffer_address;
  output tx_buffer_we;
  input  [63:0] tx_buffer_data_out;
  output  [7:0] tx_cpu_buffer_size;
  input  tx_cpu_free_buffer;
  output tx_cpu_buffer_filled;
  input  tx_cpu_buffer_select;
  //rx_buffer bits
  output [63:0] rx_buffer_data_in;
  output  [8:0] rx_buffer_address;
  output rx_buffer_we;
  input  [63:0] rx_buffer_data_out;
  input   [7:0] rx_cpu_buffer_size;
  input  rx_cpu_new_buffer;
  output rx_cpu_buffer_cleared;
  input  rx_cpu_buffer_select;
  //ARP Cache
  output [47:0] arp_cache_data_in;
  output  [7:0] arp_cache_address;
  output arp_cache_we;
  input  [47:0] arp_cache_data_out;
  output  [1:0] mgt_rxeqmix;
  output  [3:0] mgt_rxeqpole;
  output  [2:0] mgt_txpreemphasis;
  output  [2:0] mgt_txdiffctrl;
  //xaui status
  input   [7:0] phy_status;

  /************* OPB Address Decoding *************/

  wire opb_sel = OPB_ABus >= C_BASEADDR && OPB_ABus <= C_HIGHADDR;

  wire [31:0] local_addr = OPB_ABus - C_BASEADDR;

  localparam REGISTERS_OFFSET = 32'h0000;
  localparam REGISTERS_HIGH   = 32'h07FF;
  localparam TX_BUFFER_OFFSET = 32'h1000;
  localparam TX_BUFFER_HIGH   = 32'h17FF;
  localparam RX_BUFFER_OFFSET = 32'h2000;
  localparam RX_BUFFER_HIGH   = 32'h27FF;
  localparam ARP_CACHE_OFFSET = 32'h3000;
  localparam ARP_CACHE_HIGH   = 32'h37FF;

  reg opb_ack;
  wire opb_trans = opb_sel && OPB_select && !opb_ack;

  wire reg_sel    = opb_trans && local_addr >= REGISTERS_OFFSET && local_addr <= REGISTERS_HIGH;
  wire rxbuf_sel  = opb_trans && local_addr >= RX_BUFFER_OFFSET && local_addr <= RX_BUFFER_HIGH;
  wire txbuf_sel  = opb_trans && local_addr >= TX_BUFFER_OFFSET && local_addr <= TX_BUFFER_HIGH;
  wire arp_sel    = opb_trans && local_addr >= ARP_CACHE_OFFSET && local_addr <= ARP_CACHE_HIGH;

  wire [31:0] reg_addr   = local_addr - REGISTERS_OFFSET;
  wire [31:0] rxbuf_addr = local_addr - RX_BUFFER_OFFSET;
  wire [31:0] txbuf_addr = local_addr - TX_BUFFER_OFFSET;
  wire [31:0] arp_addr   = local_addr - ARP_CACHE_OFFSET;

  /************** Registers ****************/
  
  localparam REG_LOCAL_MAC_1   = 4'd0;
  localparam REG_LOCAL_MAC_0   = 4'd1;
  localparam REG_LOCAL_GATEWAY = 4'd3;
  localparam REG_LOCAL_IPADDR  = 4'd4;
  localparam REG_BUFFER_SIZES  = 4'd6;
  localparam REG_VALID_PORTS   = 4'd8;
  localparam REG_XAUI_STATUS   = 4'd9;
  localparam REG_PHY_CONFIG    = 4'd10;

  reg [47:0] local_mac;
  reg [31:0] local_ip;
  reg  [7:0] local_gateway;
  reg [15:0] local_port;
  reg local_valid;
  reg  [1:0] mgt_rxeqmix;
  reg  [3:0] mgt_rxeqpole;
  reg  [2:0] mgt_txpreemphasis;
  reg  [2:0] mgt_txdiffctrl;

  reg rx_cpu_buffer_cleared, rx_cpu_buffer_select_int;
  reg tx_cpu_buffer_filled, tx_cpu_buffer_select_int;
  reg [7:0] tx_size;
  reg [7:0] rx_size;
  reg [7:0] tx_cpu_buffer_size;

  reg use_arp_data, use_tx_data, use_rx_data;

  reg tx_cpu_free_buffer_R, rx_cpu_new_buffer_R;

  reg opb_wait;

  reg [3:0] opb_data_src;

  always @(posedge OPB_Clk) begin
    //strobes
    opb_ack      <= 1'b0;
    use_arp_data <= 1'b0;
    use_tx_data  <= 1'b0;
    use_rx_data  <= 1'b0;

    if (OPB_Rst) begin
      opb_ack <= 1'b0;
      opb_data_src <= 4'b0;

      tx_size <= 8'b0;
      rx_size <= 8'b0;
      rx_cpu_buffer_cleared <= 1'b0;
      tx_cpu_buffer_filled  <= 1'b0;
      tx_cpu_free_buffer_R  <= 1'b0;
      rx_cpu_new_buffer_R   <= 1'b0;

      local_mac         <= DEFAULT_FABRIC_MAC;
      local_ip          <= DEFAULT_FABRIC_IP;
      local_gateway     <= DEFAULT_FABRIC_GATEWAY;
      local_port        <= DEFAULT_FABRIC_PORT;
      local_valid       <= FABRIC_RUN_ON_STARTUP;

      mgt_rxeqmix       <= DEFAULT_RXEQMIX;
      mgt_rxeqpole      <= DEFAULT_RXEQPOLE;
      mgt_txpreemphasis <= DEFAULT_TXPREEMPHASIS;
      mgt_txdiffctrl    <= DEFAULT_TXDIFFCTRL;
    end else if (opb_wait) begin
      opb_wait <= 1'b0;
      opb_ack  <= 1'b1;
    end else begin
      tx_cpu_free_buffer_R <= tx_cpu_free_buffer;
      rx_cpu_new_buffer_R  <= rx_cpu_new_buffer;

      if (opb_trans)
        opb_ack <= 1'b1;

      // RX Buffer control handshake
      if (!rx_cpu_buffer_cleared  && rx_cpu_new_buffer && !rx_cpu_new_buffer_R) begin
        rx_size <= rx_cpu_buffer_size;
        rx_cpu_buffer_select_int <= rx_cpu_buffer_select;
      end
      if (!rx_cpu_buffer_cleared && rx_cpu_new_buffer && rx_cpu_new_buffer_R && rx_size == 8'h00) begin
        rx_cpu_buffer_cleared <= 1'b1;
      end
      if (rx_cpu_buffer_cleared && !rx_cpu_new_buffer) begin
        rx_cpu_buffer_cleared <= 1'b0;
      end

      // When we see a positive edge on the free buffer signal we know that we
      // have been given a new buffer so we may continue with the new buffer
      if (!tx_cpu_buffer_filled && tx_cpu_free_buffer && !tx_cpu_free_buffer_R) begin
        tx_size <= 8'h00;
        tx_cpu_buffer_select_int <= tx_cpu_buffer_select;
      end
      // When we are ready to send (tx_size != 0 && tx_cpu_buffer_fille = 0) and there is a free buffer
      // we tell the controller we have data ready to send
      if (!tx_cpu_buffer_filled && tx_cpu_free_buffer && tx_cpu_free_buffer_R && tx_size != 8'h0) begin
        tx_cpu_buffer_filled <= 1'b1;
        tx_cpu_buffer_size <= tx_size;
      end
      // When we have filled the buffer and the free signal is deasserted, we dessert
      // to let the controller switch to the new buffer
      if (tx_cpu_buffer_filled && !tx_cpu_free_buffer) begin
        tx_cpu_buffer_filled <= 1'b0;
      end

  /* most of the work is done in the next always block in coverting 16 bit to 64 bit buffer
   * transactions */
      // ARP Cache
      if (arp_sel) begin 
        if (!OPB_RNW) begin
          opb_ack <= 1'b0;
          opb_wait <= 1'b1;
        end else begin
          use_arp_data <= 1'b1;
        end
      end

      // RX Buffer 
      if (rxbuf_sel) begin
        if (!OPB_RNW && opb_trans) begin
          opb_ack <= 1'b0;
          opb_wait <= 1'b1;
        end else begin
          use_rx_data <= 1'b1;
        end
      end

      // TX Buffer 
      if (txbuf_sel) begin
        if (!OPB_RNW && opb_trans) begin
          opb_ack <= 1'b0;
          opb_wait <= 1'b1;
        end else begin
          use_tx_data <= 1'b1;
        end
      end

      // registers
      if (reg_sel) begin
        opb_data_src <= reg_addr[5:2];
        if (!OPB_RNW) begin
          case (reg_addr[5:2])
            REG_LOCAL_MAC_1: begin
              if (OPB_BE[0])
                local_mac[39:32] <= OPB_DBus[7:0];
              if (OPB_BE[1])
                local_mac[47:40] <= OPB_DBus[15:8];
            end
            REG_LOCAL_MAC_0: begin
              if (OPB_BE[0])
                local_mac[7:0]   <= OPB_DBus[7:0];
              if (OPB_BE[1])
                local_mac[15:8]  <= OPB_DBus[15:8];
              if (OPB_BE[2])
                local_mac[23:16] <= OPB_DBus[23:16];
              if (OPB_BE[3])
                local_mac[31:24] <= OPB_DBus[31:24];
            end
            REG_LOCAL_GATEWAY: begin
              if (OPB_BE[0])
                local_gateway[7:0] <= OPB_DBus[7:0];
            end
            REG_LOCAL_IPADDR: begin
              if (OPB_BE[0])
                local_ip[7:0]   <= OPB_DBus[7:0];
              if (OPB_BE[1])
                local_ip[15:8]  <= OPB_DBus[15:8];
              if (OPB_BE[2])
                local_ip[23:16] <= OPB_DBus[23:16];
              if (OPB_BE[3])
                local_ip[31:24] <= OPB_DBus[31:24];
            end
            REG_BUFFER_SIZES: begin
              if (OPB_BE[0])
                rx_size <= OPB_DBus[7:0];
              if (OPB_BE[2])
                tx_size <= OPB_DBus[23:16];
            end
            REG_VALID_PORTS: begin
              if (OPB_BE[0])
                local_port[7:0]  <= OPB_DBus[7:0];
              if (OPB_BE[1])
                local_port[15:8] <= OPB_DBus[15:8];
              if (OPB_BE[2])
                local_valid      <= OPB_DBus[16];
            end
            REG_XAUI_STATUS: begin
            end
            REG_PHY_CONFIG: begin
              if (OPB_BE[0])
                mgt_rxeqmix       <= OPB_DBus[1:0];
              if (OPB_BE[1])
                mgt_rxeqpole      <= OPB_DBus[11:8];
              if (OPB_BE[2])
                mgt_txpreemphasis <= OPB_DBus[18:16];
              if (OPB_BE[3])
                mgt_txdiffctrl    <= OPB_DBus[26:24];
            end
            default: begin
            end
          endcase
        end
      end
    end
  end

  reg arp_cache_we, rx_buffer_we, tx_buffer_we;

  reg [63:0] write_data; //write data for all three buffers

  always @(posedge OPB_Clk) begin
    //strobes
    arp_cache_we <= 1'b0;
    rx_buffer_we <= 1'b0;
    tx_buffer_we <= 1'b0;
    if (OPB_Rst) begin
    end else begin
      //populate write_data according to opb transaction info & contents
      //of memory
      if (arp_sel && opb_wait) begin
        arp_cache_we <= 1'b1;

        write_data[ 7: 0] <= arp_addr[2] == 1'b1 & OPB_BE[0] ? OPB_DBus[ 7: 0] : arp_cache_data_out[ 7: 0]; 
        write_data[15: 8] <= arp_addr[2] == 1'b1 & OPB_BE[1] ? OPB_DBus[15: 8] : arp_cache_data_out[15: 8]; 
        write_data[23:16] <= arp_addr[2] == 1'b1 & OPB_BE[2] ? OPB_DBus[23:16] : arp_cache_data_out[23:16]; 
        write_data[31:24] <= arp_addr[2] == 1'b1 & OPB_BE[3] ? OPB_DBus[31:24] : arp_cache_data_out[31:24]; 
        write_data[39:32] <= arp_addr[2] == 1'b0 & OPB_BE[0] ? OPB_DBus[ 7: 0] : arp_cache_data_out[39:32]; 
        write_data[47:40] <= arp_addr[2] == 1'b0 & OPB_BE[1] ? OPB_DBus[15: 8] : arp_cache_data_out[47:40]; 
      end
      if (rxbuf_sel && opb_wait) begin
        rx_buffer_we <= 1'b1;
        write_data[ 7: 0] <= rxbuf_addr[2] == 1'b1 & OPB_BE[0] ? OPB_DBus[ 7: 0] : rx_buffer_data_out[ 7: 0]; 
        write_data[15: 8] <= rxbuf_addr[2] == 1'b1 & OPB_BE[1] ? OPB_DBus[15: 8] : rx_buffer_data_out[15: 8]; 
        write_data[23:16] <= rxbuf_addr[2] == 1'b1 & OPB_BE[2] ? OPB_DBus[23:16] : rx_buffer_data_out[23:16]; 
        write_data[31:24] <= rxbuf_addr[2] == 1'b1 & OPB_BE[3] ? OPB_DBus[31:24] : rx_buffer_data_out[31:24]; 
        write_data[39:32] <= rxbuf_addr[2] == 1'b0 & OPB_BE[0] ? OPB_DBus[ 7: 0] : rx_buffer_data_out[39:32]; 
        write_data[47:40] <= rxbuf_addr[2] == 1'b0 & OPB_BE[1] ? OPB_DBus[15: 8] : rx_buffer_data_out[47:40]; 
        write_data[55:48] <= rxbuf_addr[2] == 1'b0 & OPB_BE[2] ? OPB_DBus[23:16] : rx_buffer_data_out[55:48]; 
        write_data[63:56] <= rxbuf_addr[2] == 1'b0 & OPB_BE[3] ? OPB_DBus[31:24] : rx_buffer_data_out[63:56]; 
      end
      if (txbuf_sel && opb_wait) begin
        tx_buffer_we <= 1'b1;

        write_data[7:0]   <= txbuf_addr[2] == 1'b1 & OPB_BE[0] ? OPB_DBus[ 7: 0] : tx_buffer_data_out[ 7: 0];
        write_data[15:8]  <= txbuf_addr[2] == 1'b1 & OPB_BE[1] ? OPB_DBus[15: 8] : tx_buffer_data_out[15: 8];
        write_data[23:16] <= txbuf_addr[2] == 1'b1 & OPB_BE[2] ? OPB_DBus[23:16] : tx_buffer_data_out[23:16]; 
        write_data[31:24] <= txbuf_addr[2] == 1'b1 & OPB_BE[3] ? OPB_DBus[31:24] : tx_buffer_data_out[31:24]; 
        write_data[39:32] <= txbuf_addr[2] == 1'b0 & OPB_BE[0] ? OPB_DBus[ 7: 0] : tx_buffer_data_out[39:32]; 
        write_data[47:40] <= txbuf_addr[2] == 1'b0 & OPB_BE[1] ? OPB_DBus[15: 8] : tx_buffer_data_out[47:40]; 
        write_data[55:48] <= txbuf_addr[2] == 1'b0 & OPB_BE[2] ? OPB_DBus[23:16] : tx_buffer_data_out[55:48]; 
        write_data[63:56] <= txbuf_addr[2] == 1'b0 & OPB_BE[3] ? OPB_DBus[31:24] : tx_buffer_data_out[63:56]; 
      end
    end
  end

  assign arp_cache_address = arp_addr[10:3];

  assign rx_buffer_address = {rx_cpu_buffer_select_int, rxbuf_addr[10:3]};
  assign tx_buffer_address = {tx_cpu_buffer_select_int, txbuf_addr[10:3]};

  assign arp_cache_data_in = write_data[47:0];
  assign rx_buffer_data_in = write_data;
  assign tx_buffer_data_in = write_data;


// select what data to put on the bus

  wire [31:0] arp_data_int = arp_addr[2]   == 1'b1 ? arp_cache_data_out[31: 0] :
                                                     {16'b0, arp_cache_data_out[47:32]};

  wire [31:0] tx_data_int  = txbuf_addr[2] == 1'b1 ? tx_buffer_data_out[31: 0] :
                                                     tx_buffer_data_out[63:32];

  wire [31:0] rx_data_int  = rxbuf_addr[2] == 1'b1 ? rx_buffer_data_out[31: 0] :
                                                     rx_buffer_data_out[63:32];

  wire [31:0] opb_data_int = opb_data_src == REG_LOCAL_MAC_1    ? {16'b0, local_mac[47:32]}        :
                             opb_data_src == REG_LOCAL_MAC_0    ? local_mac[31:0]                  :
                             opb_data_src == REG_LOCAL_GATEWAY  ? {24'b0, local_gateway}           :
                             opb_data_src == REG_LOCAL_IPADDR   ? local_ip[31:0]                   :
                             opb_data_src == REG_BUFFER_SIZES   ? {8'b0, tx_size, 8'b0, rx_size}   :
                             opb_data_src == REG_VALID_PORTS    ? {15'b0, local_valid, local_port} :
                             opb_data_src == REG_XAUI_STATUS    ? {8'b0, phy_status}               :
                             opb_data_src == REG_PHY_CONFIG     ? {5'b0, mgt_txdiffctrl, 5'b0, mgt_txpreemphasis,
                                                                   4'b0, mgt_rxeqpole,   6'b0, mgt_rxeqmix} :
                                                                      16'b0;
  wire [31:0] Sl_DBus_int;
  assign Sl_DBus_int = use_arp_data ? arp_data_int :
                       use_tx_data  ? tx_data_int  :
                       use_rx_data  ? rx_data_int  :
                                      opb_data_int;

  assign Sl_DBus = Sl_xferAck ? Sl_DBus_int : 32'b0;

  assign Sl_errAck  = 1'b0;
  assign Sl_toutSup = 1'b0;
  assign Sl_retry   = 1'b0;
  assign Sl_xferAck = opb_ack;


endmodule
