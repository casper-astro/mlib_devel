`timescale 1ns/1ps
module gbe_tx #(
    parameter REG_APP_IF    = 1
  ) (
    // Application Interface
    input         app_clk,
    input         app_rst, /* These reset MUST be applied for multiple cycles */
    input   [7:0] app_data,
    input         app_dvld,
    input         app_eof,
    input  [31:0] app_destip,
    input  [15:0] app_destport,
    output        app_afull, 
    output        app_overflow, 

    // MAC
    input         mac_clk,
    input         mac_rst,
    output  [7:0] mac_tx_data,
    output        mac_tx_dvld,
    input         mac_tx_ack,

    // Local Parameters
    input         local_enable,
    input  [47:0] local_mac,
    input  [31:0] local_ip,
    input  [15:0] local_port,
    input   [7:0] local_gateway,

    // CPU Arp Cache signals,
    output  [7:0] arp_cache_addr,
    input  [47:0] arp_cache_rd_data,

    // CPU Interface
    output [10:0] cpu_tx_buffer_addr,
    input   [7:0] cpu_tx_buffer_rd_data,

    input  [10:0] cpu_tx_size,
    input         cpu_tx_ready,
    output        cpu_tx_done,
    output        cpu_buffer_sel
  );

  /**** Packet Fifo Signals ****/

  /*
     Packet fifo contains app data
  */

  wire  [7:0] packet_fifo_din;
  wire        packet_fifo_wr;
  wire        packet_fifo_overflow;
  wire        packet_fifo_afull;

  wire  [7:0] packet_fifo_dout;
  wire        packet_fifo_rd;
  wire        packet_fifo_empty;

  gbe_tx_packet_fifo tx_packet_fifo_inst(
    .wr_clk    (app_clk),
    .din       (packet_fifo_din),
    .wr_en     (packet_fifo_wr),

    .rd_clk    (mac_clk),
    .dout      (packet_fifo_dout),
    .rd_en     (packet_fifo_rd),

    .prog_full (packet_fifo_afull),
    .empty     (packet_fifo_empty),
    .overflow  (packet_fifo_overflow),

    .rst       (app_rst)
  );

  /**** Control Fifo Signals ****/

  /*
     control fifo containts packet control info:
     {data_count[15:0], dest_port[15:0], dest_ip[31:0] 
  */

  wire [63:0] ctrl_fifo_din;
  wire        ctrl_fifo_wr;
  wire        ctrl_fifo_overflow;
  wire        ctrl_fifo_afull;

  wire [63:0] ctrl_fifo_dout;
  wire        ctrl_fifo_rd;
  wire        ctrl_fifo_empty;


  gbe_ctrl_fifo tx_packet_ctrl_fifo_inst(
    .wr_clk    (app_clk),
    .din       (ctrl_fifo_din),
    .wr_en     (ctrl_fifo_wr),
    .overflow  (ctrl_fifo_overflow),
    .prog_full (ctrl_fifo_afull),

    .rd_clk    (mac_clk),
    .dout      (ctrl_fifo_dout),
    .rd_en     (ctrl_fifo_rd),
    .empty     (ctrl_fifo_empty),

    .rst       (app_rst)
  );

  /**** Application Trasmit Logic ****/

  /* optional register stage */

  wire   [7:0] app_data_int;
  wire         app_dvld_int;
  wire         app_eof_int;
  wire  [31:0] app_destip_int;
  wire  [15:0] app_destport_int;

  /* We add this as a register option too */
  wire         packet_eof;

generate if (REG_APP_IF) begin : gen_app_if_reg
  reg  [7:0] app_data_reg;
  reg        app_dvld_reg;
  reg        app_eof_reg;
  reg [31:0] app_destip_reg;
  reg [15:0] app_destport_reg;
  reg        packet_eof_reg;

  always @(posedge app_clk) begin
    app_data_reg     <= app_data;
    app_dvld_reg     <= app_dvld;
    app_eof_reg      <= app_eof;
    app_destip_reg   <= app_destip;
    app_destport_reg <= app_destport;
    packet_eof_reg   <= app_dvld && app_eof;
  end

  assign app_data_int     = app_data_reg;
  assign app_dvld_int     = app_dvld_reg;
  assign app_eof_int      = app_eof_reg;
  assign app_destip_int   = app_destip_reg;
  assign app_destport_int = app_destport_reg;
  assign packet_eof       = packet_eof_reg;

end else begin : gen_app_if_noreg

  assign app_data_int     = app_data;
  assign app_dvld_int     = app_dvld;
  assign app_eof_int      = app_eof;
  assign app_destip_int   = app_destip;
  assign app_destport_int = app_destport;
  assign packet_eof       = app_dvld && app_eof;

end endgenerate

  /* keep track of data count for ctrl_fifo */

  reg [15:0] data_count;

  always @(posedge app_clk) begin
    if (app_rst) begin
      data_count <= 1'd1; /* pre-add last word */
    end else begin
      if (ctrl_fifo_wr) begin
        data_count <= 16'd1;
`ifdef DESPERATE_DEBUG
        $display("tge_tx: got fabric frame, size = %d", data_count);
`endif
      end else if (packet_fifo_wr) begin
        data_count <= data_count + 16'd1;
      end
    end
  end

  /* packet fifo assignments */

  assign packet_fifo_din = app_data_int;
  assign packet_fifo_wr  = app_dvld_int;

  assign ctrl_fifo_din   = {data_count, app_destport_int, app_destip_int};
  assign ctrl_fifo_wr    = packet_eof;

  /* Almost fulls */
  assign app_afull = packet_fifo_afull || ctrl_fifo_afull;

  /* Overflows */
  reg app_overflow_reg = 1'b0;
  assign app_overflow = app_overflow_reg;

  always @(posedge app_clk) begin
    if (app_rst) begin
      app_overflow_reg <= 1'b0;
    end else begin
      app_overflow_reg <= app_overflow_reg || (packet_fifo_overflow || ctrl_fifo_overflow);
    end
  end

  /**** MAC Trasmit Logic ****/

  /* control fifo signals */

  wire [7:0] packet_data = packet_fifo_dout;

  /* control fifo signals */
  wire [15:0] ctrl_size     = ctrl_fifo_dout[63:48];
  wire [15:0] ctrl_destport = ctrl_fifo_dout[47:32];
  wire [31:0] ctrl_destip   = ctrl_fifo_dout[31:0];
  reg packet_fifo_rd_reg;
  assign packet_fifo_rd = packet_fifo_rd_reg;

  /* ARP lookup */
  assign arp_cache_addr = ctrl_destip[31:8] != local_ip[31:8] ? local_gateway : ctrl_destip[7:0];
  wire [47:0] dest_mac = arp_cache_rd_data;

  /* CPU interface signals */

  reg [10:0] cpu_addr_reg;
  wire [10:0] cpu_addr;
  wire [10:0] cpu_addr_next;

  assign cpu_tx_buffer_addr = cpu_addr;
  wire [7:0] cpu_data = cpu_tx_buffer_rd_data;

  reg cpu_ack;
  wire cpu_pending = cpu_tx_ready_retimed;
  assign cpu_tx_done = cpu_ack;

  /* Local enable retimer */
  reg local_enableR;
  reg local_enableRR;
  wire local_enable_retimed = local_enableRR;
  always @(posedge mac_clk) begin
    local_enableR  <= local_enable;
    local_enableRR <= local_enableR;
  end

  /* Overflow retimer */

  reg app_overflowR;
  reg app_overflowRR;
  wire app_overflow_retimed = app_overflowRR;
  always @(posedge mac_clk) begin
    app_overflowR  <= app_overflow;
    app_overflowRR <= app_overflowR;
  end

  /* cpu_tx_ready retimer */

  reg cpu_tx_readyR;
  reg cpu_tx_readyRR;
  wire cpu_tx_ready_retimed = cpu_tx_readyRR;
  always @(posedge mac_clk) begin
    cpu_tx_readyR  <= cpu_tx_ready;
    cpu_tx_readyRR <= cpu_tx_readyR;
  end

  localparam MAC_HDR_SIZE = 14;
  localparam IP_HDR_SIZE  = 20;
  localparam UDP_HDR_SIZE = 8;

  localparam HDR_SIZE    = MAC_HDR_SIZE + IP_HDR_SIZE + UDP_HDR_SIZE;

  reg [2:0] tx_state;
  localparam TX_IDLE     = 3'd0;
  localparam TX_APP_HDR0 = 3'd1;
  localparam TX_APP_HDR1 = 3'd2;
  localparam TX_APP_HDR2 = 3'd3;
  localparam TX_APP_DATA = 3'd4;
  localparam TX_CPU_WAIT = 3'd5;
  localparam TX_CPU_DATA = 3'd6;

  // header progress
  reg  [5:0] progress;

  // bytes to send
  reg [15:0] tx_count;

  reg        tx_acked;

  reg        hdr_last;

  reg cpu_buffer_sel_reg;
  assign cpu_buffer_sel = cpu_buffer_sel_reg;

  always @(posedge mac_clk) begin
    hdr_last <= 1'b0;

    if (mac_rst) begin
      tx_state <= TX_IDLE;
      progress <= 4'd0;
      cpu_buffer_sel_reg <= 1'b0;
    end else begin

      /* final part of handshake, when the cpu clear the pending signal
         we clear out ack to allow further transfers */
      if (!cpu_pending) begin 
        cpu_ack <= 1'b0;
      end

      /* TODO: optimise - cpu frames will block if the app is using the interface, even though there is a free buffer */

      case (tx_state)
        TX_IDLE: begin
          progress <= 5'd1;
          tx_acked <= 1'b0;
          if (!ctrl_fifo_empty && !app_overflow_retimed && local_enable_retimed) begin
            tx_state <= TX_APP_HDR0;
            /* we start at one due to special case with ack delay */
            tx_count <= ctrl_size;
          end

          if (!cpu_ack && cpu_pending) begin
            tx_state <= TX_CPU_WAIT;
            //tx_count <= cpu_tx_size;
            // CPU sends tx size in 8 byte (64 bit) words
            tx_count <= {2'b0,cpu_tx_size,3'b0}; // size in bytes = cpu_tx_size * 8          
            cpu_addr_reg <= 11'h0;
            cpu_ack  <= 1'b1;
            cpu_buffer_sel_reg <= ~cpu_buffer_sel_reg;
          end

        end
        TX_APP_HDR0: begin
          if (mac_tx_ack)
            tx_acked <= 1'b1;

          if (mac_tx_ack || tx_acked)
            progress <= progress + 6'd1;

          if (progress == MAC_HDR_SIZE - 1) begin
            tx_state <= TX_APP_HDR1;
            progress <= 0;
          end
        end
        TX_APP_HDR1: begin
          progress <= progress + 6'd1;

          if (progress == IP_HDR_SIZE - 1) begin
            tx_state <= TX_APP_HDR2;
            progress <= 0;
          end
        end
        TX_APP_HDR2: begin
          progress <= progress + 6'd1;

          if (progress == UDP_HDR_SIZE - 1) begin
            tx_state <= TX_APP_DATA;
            hdr_last <= 1'b1;
          end
        end
        TX_APP_DATA: begin
          tx_count <= tx_count - 16'd1;
          if (tx_count == 16'h0) begin
            tx_state <= TX_IDLE;
          end
        end
        TX_CPU_WAIT: begin
          if (mac_tx_ack) begin
            tx_state <= TX_CPU_DATA;            
          end
        end
        TX_CPU_DATA: begin
          tx_count <= tx_count - 16'd1;
          if (tx_count == 16'd2) begin
            tx_state <= TX_IDLE;
          end 
        end
      endcase
      cpu_addr_reg <= cpu_addr_next;
    end
  end

  assign cpu_addr_next = tx_state == TX_CPU_DATA || mac_tx_ack ? cpu_addr_reg + 11'd1 : 0;
  assign cpu_addr = cpu_addr_next;

  assign ctrl_fifo_rd = (tx_state == TX_APP_DATA) && (tx_count == 16'h1);

  /* UDP/IP specific Calculations */

  reg [15:0] ip_length;
  reg [15:0] udp_length;

  always @(posedge mac_clk) begin
    ip_length  <= {ctrl_size} + 16'd28;
    udp_length <= {ctrl_size} + 16'd8;
  end

  /* checksum assignments */
  wire [17:0] ip_checksum_fixed_0 = {8'h00, 16'h8412} +
                                    {8'h00, local_ip[31:16]} + 
                                    {8'h00, local_ip[15:0]};
  wire [16:0] ip_checksum_fixed_1 = {1'b0,  ip_checksum_fixed_0[15:0]} +
                                    {15'b0, ip_checksum_fixed_0[17:16]};
  wire [15:0] ip_checksum_fixed   = {ip_checksum_fixed_1[15:0]} +
                                    {15'b0, ip_checksum_fixed_1[16]};


  reg [17:0] ip_checksum_0;
  reg [16:0] ip_checksum_1;
  reg [15:0] ip_checksum;

  always @(posedge mac_clk) begin
    ip_checksum_0 <= {2'b00, ip_checksum_fixed  } +
                     {2'b00, ip_length          } +
                     {2'b00, ctrl_destip[31:16] } +
                     {2'b00, ctrl_destip[15:0 ] };
    ip_checksum_1 <= {1'b0 , ip_checksum_0[15:0 ]} +
                     {15'b0, ip_checksum_0[17:16]};
    ip_checksum   <= ~(ip_checksum_1[15:0] + {15'b0, ip_checksum_1[16]});
  end

  /* MAC interface assignments */

  assign mac_tx_dvld = tx_state != TX_IDLE;

  reg [7:0] mac_data_reg;
  assign mac_tx_data = mac_data_reg;

  reg [7:0] hdr0_dat;
  reg [7:0] hdr1_dat;
  reg [7:0] hdr2_dat;
 
  wire [7:0] hdr0_first = dest_mac[47:40];

  always @(posedge mac_clk) begin
    case (progress)
      /* MAC Header */
      6'd00: hdr0_dat <= dest_mac[47:40];
      6'd01: hdr0_dat <= dest_mac[39:32];
      6'd02: hdr0_dat <= dest_mac[31:24];
      6'd03: hdr0_dat <= dest_mac[23:16];
      6'd04: hdr0_dat <= dest_mac[15:8];
      6'd05: hdr0_dat <= dest_mac[7:0];
      6'd06: hdr0_dat <= local_mac[47:40];
      6'd07: hdr0_dat <= local_mac[39:32]; 
      6'd08: hdr0_dat <= local_mac[31:24]; 
      6'd09: hdr0_dat <= local_mac[23:16]; 
      6'd10: hdr0_dat <= local_mac[15:8];  
      6'd11: hdr0_dat <= local_mac[7:0];   
      6'd12: hdr0_dat <= 8'h08; //Ethertype 0800 = IPV4
      6'd13: hdr0_dat <= 8'h00;
    endcase

    case(progress)
      /* IP Header */
      6'd00: hdr1_dat <= 8'h45; //IP Version 
      6'd01: hdr1_dat <= 8'h00; //IP Type
      6'd02: hdr1_dat <= ip_length[15:8];
      6'd03: hdr1_dat <= ip_length[7:0];
      6'd04: hdr1_dat <= 8'h00;
      6'd05: hdr1_dat <= 8'h00;
      6'd06: hdr1_dat <= 8'h40;
      6'd07: hdr1_dat <= 8'h00;
      6'd08: hdr1_dat <= 8'hff;
      6'd09: hdr1_dat <= 8'h11;
      6'd10: hdr1_dat <= ip_checksum[15:8];
      6'd11: hdr1_dat <= ip_checksum[7:0];
      6'd12: hdr1_dat <= local_ip[31:24];
      6'd13: hdr1_dat <= local_ip[23:16];
      6'd14: hdr1_dat <= local_ip[15:8];
      6'd15: hdr1_dat <= local_ip[7:0];
      6'd16: hdr1_dat <= ctrl_destip[31:24];
      6'd17: hdr1_dat <= ctrl_destip[23:16];
      6'd18: hdr1_dat <= ctrl_destip[15:8];
      6'd19: hdr1_dat <= ctrl_destip[7:0];
    endcase


    case (progress)
      /* UDP Header */
      6'd0: hdr2_dat <= local_port[15:8];
      6'd1: hdr2_dat <= local_port[7:0];
      6'd2: hdr2_dat <= ctrl_destport[15:8];
      6'd3: hdr2_dat <= ctrl_destport[7:0];
      6'd4: hdr2_dat <= udp_length[15:8];
      6'd5: hdr2_dat <= udp_length[7:0];
      6'd6: hdr2_dat <= 8'h00;
      6'd7: hdr2_dat <= 8'h00;
    endcase
  end

  reg [2:0] tx_state_z;
  always @(posedge mac_clk) begin
    tx_state_z <= tx_state;
  end

  always @(*) begin
    case (tx_state_z)
      TX_APP_HDR0: begin
        mac_data_reg <= mac_tx_ack ? hdr0_first : hdr0_dat;
      end
      TX_APP_HDR1: begin
        mac_data_reg <= hdr1_dat;
      end
      TX_APP_HDR2: begin
        mac_data_reg <= hdr2_dat;
      end
      TX_APP_DATA: begin
        mac_data_reg <= hdr_last ? hdr2_dat : packet_data;
      end
      default: begin
        mac_data_reg <= cpu_data;
      end
    endcase

    case (tx_state)
      TX_APP_DATA: begin
        packet_fifo_rd_reg <= hdr_last ? 1'b0 : 1'b1;
      end
      default: begin
        packet_fifo_rd_reg <= 1'b0;
      end
    endcase
  end

endmodule
