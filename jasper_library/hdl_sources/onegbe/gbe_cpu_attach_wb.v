`timescale 1ns/1ps
module gbe_cpu_attach_wb #(
    parameter LOCAL_MAC       = 48'hffff_ffff_ffff,
    parameter LOCAL_IP        = 32'hffff_ffff,
    parameter LOCAL_PORT      = 16'hffff,
    parameter LOCAL_GATEWAY   = 8'd0,
    parameter LOCAL_ENABLE    = 0,
    parameter CPU_PROMISCUOUS = 0,
    parameter PHY_CONFIG      = 32'd0,
    parameter CPU_TX_ENABLE   = 1'b0,
    parameter CPU_RX_ENABLE   = 1'b0
  )(
    //WB attachment
    input         wb_clk_i,
    input         wb_rst_i,
    input         wb_stb_i,
    input         wb_cyc_i,
    input         wb_we_i,
    input  [31:0] wb_adr_i,
    input  [31:0] wb_dat_i,
    input   [3:0] wb_sel_i,
    output [31:0] wb_dat_o,
    output        wb_err_o,
    output        wb_ack_o,
    //local registers
    output        local_enable,
    output [47:0] local_mac,
    output [31:0] local_ip,
    output [15:0] local_port,
    output  [7:0] local_gateway,
    output        cpu_promiscuous,
    //ARP Cache
    output  [7:0] arp_cache_addr,
    input  [47:0] arp_cache_rd_data,
    output [47:0] arp_cache_wr_data,
    output        arp_cache_wr_en,
    //rx_buffer bits
    output  [8:0] cpu_rx_buffer_addr,    //512 words deep
    input  [31:0] cpu_rx_buffer_rd_data, //4 Bytes wide
    input  [11:0] cpu_rx_size,
    output        cpu_rx_ack,
    input         cpu_rx_ready,
    //tx_buffer bits
    output  [8:0] cpu_tx_buffer_addr,    //512 words deep
    input  [31:0] cpu_tx_buffer_rd_data, //4 Bytes wide
    output [31:0] cpu_tx_buffer_wr_data,
    output        cpu_tx_buffer_wr_en,
    output [11:0] cpu_tx_size,
    output        cpu_tx_ready,
    input         cpu_tx_done,
    //phy status
    input  [31:0] phy_status,
    //phy control
    output [31:0] phy_control
  );


  /************* Generic Bus Assignments *************/

  wire        cpu_clk = wb_clk_i;
  wire        cpu_rst = wb_rst_i;

  wire  [3:0] cpu_sel   = wb_sel_i;
  wire        cpu_rnw   = !wb_we_i;
  wire        cpu_trans = !wb_ack_o && wb_stb_i && wb_cyc_i; 
  wire [31:0] cpu_addr  = wb_adr_i[31:0];
  wire [31:0] cpu_din   = wb_dat_i;

  wire        cpu_ack;
  wire        cpu_err;
  wire [31:0] cpu_dout;
  assign wb_ack_o = cpu_ack;
  assign wb_err_o = cpu_err;
  assign wb_dat_o = cpu_dout;

  /************* Hard coded parameters ************/

  localparam CORE_TYPE       = 8'b1; // 1GbE
  localparam CORE_REVISION   = 8'h2;
  localparam TX_BUF_MAX      = 16'd2048; // Size of TX buffer in bytes
  localparam RX_BUF_MAX      = 16'd2048; // Size of RX buffer in bytes
  localparam RX_WORD_SIZE    = 16'd1;    // The core counts RX data in 4-byte words (see gbe_rx.v)
  localparam TX_WORD_SIZE    = 16'd8;    // The core counts TX data in 8-byte words (see gbe_tx.v)
  localparam ARP_SIZE        = 32'd256;  // This core supports an ARP table with 256 entries

  /************* CPU Address Decoding *************/

  localparam REGISTERS_OFFSET = 32'h0000;
  localparam REGISTERS_HIGH   = 32'h0FFF;
  localparam ARP_CACHE_OFFSET = 32'h1000;
  localparam ARP_CACHE_HIGH   = 32'h3FFF;
  localparam TX_BUFFER_OFFSET = 32'h4000;
  localparam TX_BUFFER_HIGH   = 32'h7FFF;
  localparam RX_BUFFER_OFFSET = 32'h8000;
  localparam RX_BUFFER_HIGH   = 32'hBFFF;

  wire reg_sel   = (cpu_addr >= REGISTERS_OFFSET) && (cpu_addr <= REGISTERS_HIGH);
  wire rxbuf_sel = (cpu_addr >= RX_BUFFER_OFFSET) && (cpu_addr <= RX_BUFFER_HIGH);
  wire txbuf_sel = (cpu_addr >= TX_BUFFER_OFFSET) && (cpu_addr <= TX_BUFFER_HIGH);
  wire arp_sel   = (cpu_addr >= ARP_CACHE_OFFSET) && (cpu_addr <= ARP_CACHE_HIGH);

  wire [31:0] reg_addr   = cpu_addr - REGISTERS_OFFSET;
  wire [31:0] rxbuf_addr = cpu_addr - RX_BUFFER_OFFSET;
  wire [31:0] txbuf_addr = cpu_addr - TX_BUFFER_OFFSET;
  wire [31:0] arp_addr   = cpu_addr - ARP_CACHE_OFFSET;

  /************** Registers ****************/
  
  localparam REG_CORE_TYPE            = 8'd0;
  localparam REG_BUFFER_SIZE          = 8'd1;
  localparam REG_WORD_LENGTH          = 8'd2;
  localparam REG_LOCAL_MAC_1          = 8'd3;
  localparam REG_LOCAL_MAC_0          = 8'd4;
  localparam REG_LOCAL_IP             = 8'd5;
  localparam REG_LOCAL_GATEWAY        = 8'd6;
  localparam REG_LOCAL_NETMASK        = 8'd7;
  localparam REG_LOCAL_MULTICAST_IP   = 8'd8;
  localparam REG_LOCAL_MULTICAST_MASK = 8'd9;
  localparam REG_BUFFER_OCC           = 8'd10; // Number of bytes occupied in rx/tx buffers
  localparam REG_LOCAL_ENABLE         = 8'd11;
  localparam REG_LOCAL_PORT           = 8'd12;
  localparam REG_PHY_STATUS_1         = 8'd13;
  localparam REG_PHY_STATUS_0         = 8'd14;
  localparam REG_PHY_CONTROL_1        = 8'd15;
  localparam REG_PHY_CONTROL_0        = 8'd16;
  localparam REG_ARP_SIZE             = 8'd17;


  reg [47:0] local_mac_reg = 0;
  reg [31:0] local_ip_reg  = 0;
  reg [31:0] local_gateway_reg = 0;
  reg [31:0] local_multicast_ip_reg = 0;
  reg [31:0] local_multicast_ip_mask_reg = 0;
  reg        local_enable_reg = 0;
  reg        cpu_promiscuous_reg = 0;
  reg [15:0] local_port_reg = 0;
  reg [15:0] local_port_mask_reg = 0;
  reg [63:0] phy_status_reg = 0;
  reg [63:0] phy_control_reg = 0;

  assign local_mac               = local_mac_reg;
  assign local_ip                = local_ip_reg;
  assign local_gateway           = local_gateway_reg[7:0]; // This core only supports 8-bit gateway
  assign local_multicast_ip      = local_multicast_ip_reg;
  assign local_multicast_ip_mask = local_multicast_ip_mask_reg;
  assign local_port              = local_port_reg;
  //TODO: support port masking assign local_port_mask         = local_port_mask_reg;
  assign local_enable            = local_enable_reg;
  assign cpu_promiscuous         = cpu_promiscuous_reg;
  assign phy_control             = phy_control_reg[31:0]; // This core only supports 32-bit control
  assign phy_status              = phy_status_reg[63:32]; // This core only supports 32-bit status. Put it in the MSBs

  reg use_arp_data, use_tx_data, use_rx_data;

  reg [7:0] cpu_data_src;

  /* RX/TX Buffer Control regs */

  reg [16:0] cpu_rx_size_reg;
  reg [16:0] cpu_tx_size_reg;
  reg        cpu_tx_ready_reg;
  reg        cpu_rx_ack_reg;
  assign cpu_tx_size  = cpu_tx_size_reg[11:0];
  assign cpu_tx_ready = cpu_tx_ready_reg;
  assign cpu_rx_ack   = cpu_rx_ack_reg;

  reg cpu_wait;
  reg cpu_ack_reg;

  always @(posedge cpu_clk) begin
    //strobes
    cpu_ack_reg      <= 1'b0;
    use_arp_data     <= 1'b0;
    use_tx_data      <= 1'b0;
    use_rx_data      <= 1'b0;

    /* When the udp wrapper has sent the packet we tell the user by clearing 
       the size register */
    if (cpu_tx_done) begin
      cpu_tx_size_reg  <= 16'd0;
      cpu_tx_ready_reg <= 1'b0;
    end

    // If CPU is ready and we have written size to zero then send ack
    if (cpu_rx_size_reg == 16'h0 && cpu_rx_ready) begin
      cpu_rx_ack_reg  <= 1'b1;
    end
    // If CPU has released ready and we have written size to zero then
    // release ACK. This will put the receiver back into its IDLE state
    if (cpu_rx_size_reg == 16'h0 && ~cpu_rx_ready) begin
      cpu_rx_ack_reg  <= 1'b0;
    end

    if (cpu_rx_ready && ~cpu_rx_ack_reg) begin
      cpu_rx_size_reg <= cpu_rx_size;
    end

    if (cpu_rst) begin
      cpu_rx_size_reg   <= 16'b0;
      cpu_tx_ready_reg  <= 1'b0;

      cpu_data_src      <= 8'b0;

      local_mac_reg     <= LOCAL_MAC;
      local_ip_reg      <= LOCAL_IP;
      local_gateway_reg <= LOCAL_GATEWAY;
      local_port_reg    <= LOCAL_PORT;
      local_enable_reg  <= LOCAL_ENABLE;

      cpu_tx_size_reg   <= 16'd0;

      cpu_rx_ack_reg    <= 1'b0;

      phy_control_reg[31:0]   <= PHY_CONFIG;

      cpu_wait          <= 1'b0;

      cpu_promiscuous_reg <= CPU_PROMISCUOUS;

    end else if (cpu_wait) begin
      cpu_wait <= 1'b0;
      cpu_ack_reg  <= 1'b1;
    end else begin

      if (cpu_trans)
        cpu_ack_reg <= 1'b1;

      // ARP Cache
      if (arp_sel && cpu_trans) begin 
        if (!cpu_rnw) begin
          cpu_ack_reg  <= 1'b0;
          cpu_wait <= 1'b1;
        end else begin
          use_arp_data <= 1'b1;
        end
      end

      // RX Buffer 
      if (rxbuf_sel && cpu_trans) begin
        if (!cpu_rnw) begin
        end else begin
          use_rx_data <= 1'b1;
        end
      end

      // TX Buffer 
      if (txbuf_sel && cpu_trans) begin
        if (!cpu_rnw) begin
          cpu_ack_reg  <= 1'b0;
          cpu_wait <= 1'b1;
        end else begin
          use_tx_data <= 1'b1;
        end
      end

      // registers
      if (reg_sel && cpu_trans) begin
        cpu_data_src <= reg_addr[9:2];
        // Writable Registers
        if (!cpu_rnw) begin
          case (reg_addr[9:2])
            REG_LOCAL_MAC_1: begin
              if (cpu_sel[0])
                local_mac_reg[39:32] <= cpu_din[7:0];
              if (cpu_sel[1])
                local_mac_reg[47:40] <= cpu_din[15:8];
            end
            REG_LOCAL_MAC_0: begin
              if (cpu_sel[0])
                local_mac_reg[7:0]   <= cpu_din[7:0];
              if (cpu_sel[1])
                local_mac_reg[15:8]  <= cpu_din[15:8];
              if (cpu_sel[2])
                local_mac_reg[23:16] <= cpu_din[23:16];
              if (cpu_sel[3])
                local_mac_reg[31:24] <= cpu_din[31:24];
            end
            REG_LOCAL_GATEWAY: begin
              // This core only supports an 8-bit gateway
              if (cpu_sel[0])
                local_gateway_reg[7:0] <= cpu_din[7:0];
            end
            REG_LOCAL_MULTICAST_IP: begin
              // This core doesn't support multicast
              //if (cpu_sel[0])
              //  local_multicast_ip_reg[7:0] <= cpu_din[7:0];
              //if (cpu_sel[1])
              //  local_multicast_ip_reg[15:8] <= cpu_din[15:8];
              //if (cpu_sel[2])
              //  local_multicast_ip_reg[23:16] <= cpu_din[23:16];
              //if (cpu_sel[3])
              //  local_multicast_ip_reg[31:24] <= cpu_din[31:24];
            end
            REG_LOCAL_MULTICAST_MASK: begin
              // This core doesn't support multicast
              //if (cpu_sel[0])
              //  local_multicast_ip_mask_reg[7:0] <= cpu_din[7:0];
              //if (cpu_sel[1])
              //  local_multicast_ip_mask_reg[15:8] <= cpu_din[15:8];
              //if (cpu_sel[2])
              //  local_multicast_ip_mask_reg[23:16] <= cpu_din[23:16];
              //if (cpu_sel[3])
              //  local_multicast_ip_mask_reg[31:24] <= cpu_din[31:24];
            end
            REG_LOCAL_IP: begin
              if (cpu_sel[0])
                local_ip_reg[7:0]   <= cpu_din[7:0];
              if (cpu_sel[1])
                local_ip_reg[15:8]  <= cpu_din[15:8];
              if (cpu_sel[2])
                local_ip_reg[23:16] <= cpu_din[23:16];
              if (cpu_sel[3])
                local_ip_reg[31:24] <= cpu_din[31:24];
            end
            REG_BUFFER_OCC: begin
              if (cpu_sel[0]) begin
                cpu_rx_size_reg[7:0] <= cpu_din[7:0];
              end
              if (cpu_sel[1]) begin
                cpu_rx_size_reg[15:8] <= cpu_din[15:8];
              end
              if (cpu_sel[2]) begin
                cpu_tx_size_reg[7:0]  <= cpu_din[23:16];
                cpu_tx_ready_reg <= 1'b1;
              end
              if (cpu_sel[3]) begin
                cpu_tx_size_reg[15:8]  <= cpu_din[31:24];
              end
            end
            REG_LOCAL_ENABLE: begin
              if (cpu_sel[0])
                local_enable_reg     <= cpu_din[0];
              if (cpu_sel[1])
                cpu_promiscuous_reg  <= cpu_din[8];
            end
            REG_LOCAL_PORT: begin
              if (cpu_sel[0])
                local_port_reg[7:0] <= cpu_din[7:0];
              if (cpu_sel[1])
                local_port_reg[15:8] <= cpu_din[15:8];
              // This core doesn't support port masking
              //if (cpu_sel[2])
              //  local_port_mask_reg[7:0] <= cpu_din[23:16];
              //if (cpu_sel[3])
              //  local_port_mask_reg[15:8] <= cpu_din[31:24];
            end
            REG_PHY_CONTROL_0: begin
              if (cpu_sel[0])
                phy_control_reg[7:0] <= cpu_din[7:0];
              if (cpu_sel[1])
                phy_control_reg[15:8] <= cpu_din[15:8];
              if (cpu_sel[2])
                phy_control_reg[23:16] <= cpu_din[23:16];
              if (cpu_sel[3])
                phy_control_reg[31:24] <= cpu_din[31:24];
            end
            REG_PHY_CONTROL_1: begin
              if (cpu_sel[0])
                phy_control_reg[39:32] <= cpu_din[7:0];
              if (cpu_sel[1])
                phy_control_reg[47:40] <= cpu_din[15:8];
              if (cpu_sel[2])
                phy_control_reg[55:48] <= cpu_din[23:16];
              if (cpu_sel[3])
                phy_control_reg[63:56] <= cpu_din[31:24];
            end
            default: begin
            end
          endcase
        end
      end
    end
  end

  /********* Handle memory interfaces ***********/

  reg arp_cache_we, tx_buffer_we;

  reg [47:0] write_data; //write data for all three buffers

  always @(posedge cpu_clk) begin
    //strobes
    arp_cache_we <= 1'b0;
    tx_buffer_we <= 1'b0;

    if (cpu_rst) begin
    end else begin
      //populate write_data according to wishbone transaction info & contents
      //of memory
      if (arp_sel && cpu_wait) begin
        arp_cache_we <= 1'b1;
        write_data[ 7: 0] <= arp_addr[2] & cpu_sel[0] ? cpu_din[ 7: 0] : arp_cache_rd_data[ 7: 0]; 
        write_data[15: 8] <= arp_addr[2] & cpu_sel[1] ? cpu_din[15: 8] : arp_cache_rd_data[15: 8]; 
        write_data[23:16] <= arp_addr[2] & cpu_sel[2] ? cpu_din[23:16] : arp_cache_rd_data[23:16]; 
        write_data[31:24] <= arp_addr[2] & cpu_sel[3] ? cpu_din[31:24] : arp_cache_rd_data[31:24]; 
        write_data[39:32] <= !arp_addr[2] & cpu_sel[0] ? cpu_din[ 7: 0] : arp_cache_rd_data[39:32]; 
        write_data[47:40] <= !arp_addr[2] & cpu_sel[1] ? cpu_din[15: 8] : arp_cache_rd_data[47:40]; 
      end
      if (txbuf_sel && cpu_wait) begin
        tx_buffer_we <= 1'b1;
        write_data[7:0]   <= cpu_sel[0] ? cpu_din[ 7: 0] : cpu_tx_buffer_rd_data[ 7: 0];
        write_data[15:8]  <= cpu_sel[1] ? cpu_din[15: 8] : cpu_tx_buffer_rd_data[15: 8];
        write_data[23:16] <= cpu_sel[2] ? cpu_din[23:16] : cpu_tx_buffer_rd_data[23:16]; 
        write_data[31:24] <= cpu_sel[3] ? cpu_din[31:24] : cpu_tx_buffer_rd_data[31:24]; 
      end
    end
  end

  // memory assignments
  assign arp_cache_addr        = arp_addr[10:3]; // supports 256 entries
  assign arp_cache_wr_data     = write_data;
  assign arp_cache_wr_en       = arp_cache_we;

  assign cpu_tx_buffer_addr    = txbuf_addr[10:2]; // TX buffer is 512 words deep x 32-bits wide
  assign cpu_tx_buffer_wr_data = write_data[31:0];
  assign cpu_tx_buffer_wr_en   = tx_buffer_we;

  assign cpu_rx_buffer_addr    = rxbuf_addr[10:2]; // RX buffer is 512 words deep

  // select what data to put on the bus
  wire [31:0] arp_data_int = arp_addr[2] == 1'b1 ? arp_cache_rd_data[31:0] : {16'b0, arp_cache_rd_data[47:32]};
  wire [31:0] tx_data_int  = cpu_tx_buffer_rd_data[31:0];
  wire [31:0] rx_data_int  = cpu_rx_buffer_rd_data[31:0];

  wire [31:0] cpu_data_int = cpu_data_src == REG_CORE_TYPE            ? {7'b0, |CPU_TX_ENABLE, 7'b0, |CPU_RX_ENABLE, CORE_REVISION, CORE_TYPE} :
                             cpu_data_src == REG_BUFFER_SIZE          ? {TX_BUF_MAX, RX_BUF_MAX} :
                             cpu_data_src == REG_WORD_LENGTH          ? {TX_WORD_SIZE, RX_WORD_SIZE} :
                             cpu_data_src == REG_LOCAL_MAC_1          ? {16'b0, local_mac_reg[47:32]} :
                             cpu_data_src == REG_LOCAL_MAC_0          ? local_mac_reg[31:0] :
                             cpu_data_src == REG_LOCAL_IP             ? local_ip_reg :
                             cpu_data_src == REG_LOCAL_GATEWAY        ? local_gateway_reg :
                             cpu_data_src == REG_LOCAL_MULTICAST_IP   ? local_multicast_ip_reg:
                             cpu_data_src == REG_LOCAL_MULTICAST_MASK ? local_multicast_ip_mask_reg:
                             cpu_data_src == REG_BUFFER_OCC           ? {cpu_tx_size_reg, cpu_rx_size_reg}:
                             cpu_data_src == REG_LOCAL_ENABLE         ? {16'b0, 7'b0, cpu_promiscuous_reg, 7'b0, local_enable_reg} :
                             cpu_data_src == REG_LOCAL_PORT           ? {local_port_mask_reg, local_port_reg} :
                             cpu_data_src == REG_PHY_STATUS_1         ? phy_status_reg[63:32] :
                             cpu_data_src == REG_PHY_STATUS_0         ? 32'b1 : // force link-up to True
                             cpu_data_src == REG_PHY_CONTROL_1        ? phy_control_reg[63:32] :
                             cpu_data_src == REG_PHY_CONTROL_0        ? phy_control_reg[31:0] :
                             cpu_data_src == REG_ARP_SIZE             ? ARP_SIZE :
                                                                        32'h0;
  assign cpu_dout = use_arp_data ? arp_data_int :
                    use_tx_data  ? tx_data_int  :
                    use_rx_data  ? rx_data_int  :
                                   cpu_data_int;

  assign cpu_err   = 1'b0;
  assign cpu_ack   = cpu_ack_reg;

endmodule
