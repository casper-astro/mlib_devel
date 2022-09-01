`timescale 1ns/1ps
module casper100g_wb_attach #(
    parameter FABRIC_MAC      = 48'hffff_ffff_ffff,
    parameter FABRIC_IP       = 32'hffff_ffff,
    parameter FABRIC_PORT     = 16'hffff,
    parameter FABRIC_GATEWAY  = 8'd0,
    parameter FABRIC_ENABLE   = 0,
    parameter MC_RECV_IP      = 32'h00000000,
    parameter MC_RECV_IP_MASK = 32'h00000000,
    parameter PREEMPHASIS     = 4'b0100,
    parameter POSTEMPHASIS    = 5'b00000,
    parameter DIFFCTRL        = 4'b1010,
    parameter RXEQMIX         = 3'b111,
    parameter CPU_TX_ENABLE   = 1'b0,
    parameter CPU_RX_ENABLE   = 1'b0
  )(
    input         wb_clk_i,
    input         wb_rst_i,
    output [31:0] wb_dat_o,
    output        wb_err_o,
    output        wb_ack_o,
    input  [31:0] wb_adr_i,
    input  [3:0]  wb_sel_i,
    input  [31:0] wb_dat_i,
    input         wb_we_i,
    input         wb_cyc_i,
    input         wb_stb_i,

    // Registers from 100G core
    input link_up,
    input [31:0] gmac_reg_core_type,
    input [31:0] gmac_reg_buffer_max_size,
    input [31:0] gmac_reg_word_size,
    input [31:0] gmac_reg_phy_status_h,
    input [31:0] gmac_reg_phy_status_l,
    input [31:0] gmac_reg_arp_size,             // Not implemented
    input [31:0] gmac_reg_tx_packet_rate,       // Not implemented
    input [31:0] gmac_reg_tx_packet_count,      // Not implemented
    input [31:0] gmac_reg_tx_valid_rate,        // Not implemented
    input [31:0] gmac_reg_tx_valid_count,       // Not implemented
    input [31:0] gmac_reg_tx_overflow_count,    // Not implemented
    input [31:0] gmac_reg_tx_almost_full_count, // Not implemented
    input [31:0] gmac_reg_rx_packet_rate,       // Not implemented
    input [31:0] gmac_reg_rx_packet_count,      // Not implemented
    input [31:0] gmac_reg_rx_valid_rate,        // Not implemented
    input [31:0] gmac_reg_rx_valid_count,       // Not implemented
    input [31:0] gmac_reg_rx_overflow_count,    // Not implemented
    input [31:0] gmac_reg_rx_bad_packet_count,  // Not implemented

    // To 100G core
    output [31:0] gmac_reg_mac_address_l,
    output [31:0] gmac_reg_mac_address_h,
    output [31:0] gmac_reg_local_ip_address,
    output [31:0] gmac_reg_gateway_ip_address,
    output [31:0] gmac_reg_local_ip_netmask,
    output [31:0] gmac_reg_udp_port,
    output [31:0] gmac_reg_multicast_ip_address,
    output [31:0] gmac_reg_multicast_ip_mask,
    output [31:0] gmac_reg_count_reset,         // Not implemented
    //output [31:0] gmac_reg_bytes_rdy,
    output [31:0] gmac_reg_core_ctrl,
    output [31:0] gmac_reg_phy_control_h,       // Not implemented
    output [31:0] gmac_reg_phy_control_l,       // Not implemented
    

    //ARP Cache
    output [31:0] gmac_arp_cache_write_enable,
    output [31:0] gmac_arp_cache_read_enable,
    output [31:0] gmac_arp_cache_write_data,
    output [31:0] gmac_arp_cache_write_address,
    output [31:0] gmac_arp_cache_read_address,
    input  [31:0] gmac_arp_cache_read_data
  );

  // Not implemented outputs
  assign gmac_reg_count_reset = 32'b0;
  assign gmac_reg_phy_control_h = 32'b0;
  assign gmac_reg_phy_control_l = 32'b0;

  /**************** Hard coded core parameters ************/
  localparam CORE_REV     = 8'd1;
  localparam CORE_TYPE    = 8'd2; // 10GbE core
  localparam TX_WORD_SIZE = 16'd8;
  localparam RX_WORD_SIZE = 16'd8;
  localparam TX_MAX_SIZE  = 16'd2048;
  localparam RX_MAX_SIZE  = 16'd2048;
  /************* OPB Address Decoding *************/

  wire opb_sel = wb_stb_i;

  wire [31:0] local_addr = wb_adr_i;

  localparam REGISTERS_OFFSET = 32'h0000;
  localparam REGISTERS_HIGH   = 32'h1FFF;
  localparam TX_BUFFER_OFFSET = 32'h4000;
  localparam TX_BUFFER_HIGH   = 32'h7FFF;
  localparam RX_BUFFER_OFFSET = 32'h8000;
  localparam RX_BUFFER_HIGH   = 32'hBFFF;

  reg opb_ack;
  wire opb_trans = wb_cyc_i && wb_stb_i && !opb_ack;

  wire reg_sel   = opb_trans && (local_addr >= REGISTERS_OFFSET) && (local_addr <= REGISTERS_HIGH);

  wire [31:0] reg_addr   = local_addr - REGISTERS_OFFSET;

  /************** Registers ****************/
  
 // localparam REG_VALID_PORTS     = 4'd8; // soft_reset, local_enable, local_port, set to phy control_0
 // localparam REG_XAUI_STATUS     = 4'd9; // cpu tx/rx enable put in REG_CORE_TYPE. xaui_status put in PHY_STATUS
 // localparam REG_PHY_CONFIG      = 4'd10; // set to phy_control_1

  localparam REG_CORE_TYPE       = 16'd0;
  localparam REG_TX_RX_MAX_BUF   = 16'd1;
  localparam REG_WORD_LENGTHS    = 16'd2;
  localparam REG_MAC_ADDR_1      = 16'd3;
  localparam REG_MAC_ADDR_0      = 16'd4;
  localparam REG_IP_ADDR         = 16'd5;
  localparam REG_GATEWAY_ADDR    = 16'd6;
  localparam REG_NETMASK         = 16'd7;
  localparam REG_MC_RECV_IP      = 16'd8;
  localparam REG_MC_RECV_IP_MASK = 16'd9;
  localparam REG_TX_RX_BUF       = 16'd10;
  localparam REG_PROMIS_EN       = 16'd11;
  localparam REG_PMASK_PORT      = 16'd12;
  localparam REG_PHY_STATUS_1    = 16'd13;
  localparam REG_PHY_STATUS_0    = 16'd14;
  localparam REG_PHY_CONTROL_1   = 16'd15;
  localparam REG_PHY_CONTROL_0   = 16'd16;
  localparam REG_ARP_SIZE        = 16'd17;
  // Not memmap compliant, but constructed to match the AXI interface
  localparam REG_ARP_WE          = 16'd1024;
  localparam REG_ARP_RE          = 16'd1025;
  localparam REG_ARP_WDATA       = 16'd1026;
  localparam REG_ARP_WADDR       = 16'd1027;
  localparam REG_ARP_RADDR       = 16'd1028;
  localparam REG_ARP_RDATA       = 16'd1029;


  reg [47:0] local_mac_reg;
  reg [31:0] local_ip_reg;
  reg [31:0] local_gateway_reg = 0;
  reg [31:0] local_netmask_reg = 0;
  reg [15:0] local_port_mask_reg;
  reg [15:0] local_port_reg;
  reg        local_enable_reg;
  reg [31:0] local_mc_recv_ip_reg;
  reg [31:0] local_mc_recv_ip_mask_reg;
  reg        soft_reset_reg;

  reg [31:0] gmac_arp_cache_write_enable_reg;
  reg [31:0] gmac_arp_cache_read_enable_reg;
  reg [31:0] gmac_arp_cache_write_data_reg;
  reg [31:0] gmac_arp_cache_write_address_reg;
  reg [31:0] gmac_arp_cache_read_address_reg;
  assign gmac_arp_cache_write_enable  = gmac_arp_cache_write_enable_reg;
  assign gmac_arp_cache_read_enable   = gmac_arp_cache_read_enable_reg;
  assign gmac_arp_cache_write_data    = gmac_arp_cache_write_data_reg;
  assign gmac_arp_cache_write_address = gmac_arp_cache_write_address_reg;
  assign gmac_arp_cache_read_address  = gmac_arp_cache_read_address_reg;

  assign gmac_reg_mac_address_l = local_mac_reg[31:0];
  assign gmac_reg_mac_address_h = {16'b0, local_mac_reg[47:32]};
  assign gmac_reg_local_ip_address = local_ip_reg;
  assign gmac_reg_gateway_ip_address = local_gateway_reg;
  assign gmac_reg_local_ip_netmask = local_netmask_reg;
  assign gmac_reg_udp_port = {16'b0, local_port_reg};
  assign gmac_reg_multicast_ip_address = local_mc_recv_ip_reg;
  assign gmac_reg_multicast_ip_mask = local_mc_recv_ip_mask_reg;
  assign gmac_reg_core_ctrl = {8'b0, 7'b0, soft_reset_reg, 8'b0, 7'b0, local_enable_reg};
  //assign local_port_mask   = local_port_mask_reg;
  
  assign wb_err_o = 1'b0;

  reg [15:0] opb_data_src;

  /* RX/TX Buffer Control regs */

  reg [7:0] cpu_tx_size_reg;
  reg       cpu_tx_ready_reg;
  reg       cpu_rx_ack_reg;

  reg opb_wait;
  reg write_arp;
  reg tx_write;
  always @(posedge wb_clk_i) begin
    //strobes
    opb_ack          <= 1'b0;

    if (wb_rst_i) begin
      opb_data_src      <= 16'b0;

      local_mac_reg     <= FABRIC_MAC;
      local_ip_reg      <= FABRIC_IP;
      local_gateway_reg <= FABRIC_GATEWAY;
      local_port_reg    <= FABRIC_PORT;
      local_enable_reg  <= FABRIC_ENABLE;
      local_mc_recv_ip_reg      <= MC_RECV_IP;
      local_mc_recv_ip_mask_reg <= MC_RECV_IP_MASK;

      cpu_tx_size_reg   <= 8'd0;

      cpu_rx_ack_reg  <= 1'b0;

      opb_wait <= 1'b0;

      soft_reset_reg <= 1'b0;

    end else if (opb_wait) begin
      opb_wait <= 1'b0;
      opb_ack  <= 1'b1;
    end else begin

      if (opb_trans)
        opb_ack <= 1'b1;

      // registers
      if (reg_sel) begin
        opb_data_src <= reg_addr[17:2];
        if (wb_we_i) begin
          case (reg_addr[17:2])
            REG_CORE_TYPE: begin
            end
            REG_TX_RX_MAX_BUF: begin
            end
            REG_WORD_LENGTHS: begin
            end
            REG_MAC_ADDR_1: begin
              if (wb_sel_i[0])
                local_mac_reg[39:32] <= wb_dat_i[7:0];
              if (wb_sel_i[1])
                local_mac_reg[47:40] <= wb_dat_i[15:8];
            end
            REG_MAC_ADDR_0: begin
              if (wb_sel_i[0])
                local_mac_reg[7:0]   <= wb_dat_i[7:0];
              if (wb_sel_i[1])
                local_mac_reg[15:8]  <= wb_dat_i[15:8];
              if (wb_sel_i[2])
                local_mac_reg[23:16] <= wb_dat_i[23:16];
              if (wb_sel_i[3])
                local_mac_reg[31:24] <= wb_dat_i[31:24];
            end
            REG_IP_ADDR: begin
              if (wb_sel_i[0])
                local_ip_reg[7:0]   <= wb_dat_i[7:0];
              if (wb_sel_i[1])
                local_ip_reg[15:8]  <= wb_dat_i[15:8];
              if (wb_sel_i[2])
                local_ip_reg[23:16] <= wb_dat_i[23:16];
              if (wb_sel_i[3])
                local_ip_reg[31:24] <= wb_dat_i[31:24];
            end
            REG_GATEWAY_ADDR: begin
              if (wb_sel_i[0])
                local_gateway_reg[7:0] <= wb_dat_i[7:0];
              if (wb_sel_i[1])
                local_gateway_reg[15:8]  <= wb_dat_i[15:8];
              if (wb_sel_i[2])
                local_gateway_reg[23:16] <= wb_dat_i[23:16];
              if (wb_sel_i[3])
                local_gateway_reg[31:24] <= wb_dat_i[31:24];
            end
            REG_NETMASK: begin
              if (wb_sel_i[0])
                local_netmask_reg[7:0] <= wb_dat_i[7:0];
              if (wb_sel_i[1])
                local_netmask_reg[15:8]  <= wb_dat_i[15:8];
              if (wb_sel_i[2])
                local_netmask_reg[23:16] <= wb_dat_i[23:16];
              if (wb_sel_i[3])
                local_netmask_reg[31:24] <= wb_dat_i[31:24];
            end
            REG_MC_RECV_IP: begin
              if (wb_sel_i[0])
                local_mc_recv_ip_reg[7:0]   <= wb_dat_i[7:0];
              if (wb_sel_i[1])
                local_mc_recv_ip_reg[15:8]  <= wb_dat_i[15:8];
              if (wb_sel_i[2])
                local_mc_recv_ip_reg[23:16] <= wb_dat_i[23:16];
              if (wb_sel_i[3])
                local_mc_recv_ip_reg[31:24] <= wb_dat_i[31:24];
            end
            REG_MC_RECV_IP_MASK: begin
              if (wb_sel_i[0])
                local_mc_recv_ip_mask_reg[7:0]   <= wb_dat_i[7:0];
              if (wb_sel_i[1])
                local_mc_recv_ip_mask_reg[15:8]  <= wb_dat_i[15:8];
              if (wb_sel_i[2])
                local_mc_recv_ip_mask_reg[23:16] <= wb_dat_i[23:16];
              if (wb_sel_i[3])
                local_mc_recv_ip_mask_reg[31:24] <= wb_dat_i[31:24];
            end
            REG_TX_RX_BUF: begin
              if (wb_sel_i[0] && wb_dat_i[7:0] == 8'b0) begin
                cpu_rx_ack_reg <= 1'b1;
              end
              if (wb_sel_i[2]) begin
                cpu_tx_size_reg  <= wb_dat_i[23:16];
                cpu_tx_ready_reg <= 1'b1;
              end
            end
            REG_PROMIS_EN: begin
              if (wb_sel_i[0])
                local_enable_reg     <= wb_dat_i[0];
              if (wb_sel_i[2] && wb_dat_i[16])
                soft_reset_reg       <= 1'b1;
            end
            REG_PMASK_PORT: begin
              if (wb_sel_i[0])
                local_port_reg[7:0] <= wb_dat_i[7:0];
              if (wb_sel_i[1])
                local_port_reg[15:8] <= wb_dat_i[15:8];
              // TODO Support port mask
              //if (wb_sel_i[2])
              //  local_port_mask_reg[7:0] <= wb_dat_i[23:16];
              //if (wb_sel_i[3])
              //  local_port_mask_reg[15:8] <= wb_dat_i[31:24];
            end
            REG_PHY_STATUS_0: begin
            end
            REG_PHY_STATUS_1: begin
            end
            REG_PHY_CONTROL_0: begin
            end
            REG_PHY_CONTROL_1: begin
            end
            REG_ARP_WE: begin
              gmac_arp_cache_write_enable_reg <= wb_dat_i;
            end
            REG_ARP_RE: begin
              gmac_arp_cache_read_enable_reg <= wb_dat_i;
            end
            REG_ARP_WDATA : begin
              gmac_arp_cache_write_data_reg <= wb_dat_i;
            end
            REG_ARP_WADDR: begin
              gmac_arp_cache_write_address_reg <= wb_dat_i;
            end
            REG_ARP_RADDR: begin
              gmac_arp_cache_read_address_reg <= wb_dat_i;
            end
            REG_ARP_SIZE: begin
            end
            default: begin
            end
          endcase
        end
      end
    end
  end


  wire [31:0] opb_data_int = opb_data_src == REG_CORE_TYPE ? gmac_reg_core_type :
                             opb_data_src == REG_TX_RX_MAX_BUF ? gmac_reg_buffer_max_size :
                             opb_data_src == REG_WORD_LENGTHS ? gmac_reg_word_size :
                             opb_data_src == REG_MAC_ADDR_1   ? {16'b0,local_mac_reg[47:32]} :
                             opb_data_src == REG_MAC_ADDR_0   ? {local_mac_reg[31:0]} :
                             opb_data_src == REG_IP_ADDR      ? {local_ip_reg[31:0]} :
                             opb_data_src == REG_GATEWAY_ADDR ? local_gateway_reg :
                             opb_data_src == REG_NETMASK      ? local_netmask_reg :
                             opb_data_src == REG_MC_RECV_IP   ? {local_mc_recv_ip_reg[31:0]} :
                             opb_data_src == REG_MC_RECV_IP_MASK ? {local_mc_recv_ip_mask_reg[31:0]} :
                             opb_data_src == REG_TX_RX_BUF ? {32'b0} : //{8'b0, cpu_tx_size_reg, 8'b0, 8'b0} :
                             opb_data_src == REG_PROMIS_EN ? {8'b0, 7'b0, soft_reset_reg, 8'b0, 7'b0, local_enable_reg} :
                             opb_data_src == REG_PMASK_PORT ? {local_port_mask_reg, local_port_reg} :
                             opb_data_src == REG_PHY_STATUS_1 ? {32'b0} :
                             opb_data_src == REG_PHY_STATUS_0 ? {31'b0, link_up} :
                             opb_data_src == REG_PHY_CONTROL_1 ? {32'b0} :
                             opb_data_src == REG_PHY_CONTROL_0 ? {32'b0} :
                             opb_data_src == REG_ARP_WE ? gmac_arp_cache_write_enable_reg :
                             opb_data_src == REG_ARP_RE ? gmac_arp_cache_read_enable_reg :
                             opb_data_src == REG_ARP_WDATA ? gmac_arp_cache_write_data_reg :
                             opb_data_src == REG_ARP_RDATA ? gmac_arp_cache_read_data :
                             opb_data_src == REG_ARP_WADDR ? gmac_arp_cache_write_address_reg :
                             opb_data_src == REG_ARP_RADDR ? gmac_arp_cache_read_address_reg :
                             opb_data_src == REG_ARP_SIZE ? {32'b0} : 32'b0;


  wire [31:0] wb_dat_o_int;
  assign wb_dat_o_int = opb_data_int;

  assign wb_dat_o = wb_ack_o ? wb_dat_o_int : 32'b0;

  assign wb_ack_o = opb_ack;
  assign wb_err_o = 1'b0;

endmodule
