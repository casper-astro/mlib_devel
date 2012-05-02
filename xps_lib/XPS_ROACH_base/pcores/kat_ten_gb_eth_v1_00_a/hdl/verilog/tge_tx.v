`timescale 1ns/1ps
module tge_tx #(
    parameter CPU_ENABLE = 1'b1,
    parameter LARGE_PACKETS = 0
  ) (
    // Local Parameters
    input         local_enable,
    input  [47:0] local_mac,
    input  [31:0] local_ip,
    input  [15:0] local_port,
    input   [7:0] local_gateway,
    // CPU Arp Cache signals,
    input   [7:0] arp_cache_addr,
    output [47:0] arp_cache_rd_data,
    input  [47:0] arp_cache_wr_data,
    input         arp_cache_wr_en,
    // Application Interface
    input         app_clk,
    input         app_rst,
    input         app_tx_valid,
    input         app_tx_end_of_frame,
    input  [63:0] app_tx_data,
    input  [31:0] app_tx_dest_ip,
    input  [15:0] app_tx_dest_port,
    output        app_tx_overflow, 
    output        app_tx_afull, 
    // CPU Interface
    input         cpu_clk,
    input         cpu_rst,
    input   [7:0] cpu_tx_buffer_addr,
    output [63:0] cpu_tx_buffer_rd_data,
    input  [63:0] cpu_tx_buffer_wr_data,
    input         cpu_tx_buffer_wr_en,

    input   [7:0] cpu_tx_size,
    input         cpu_tx_ready,
    output        cpu_tx_done,
    // MAC
    input         mac_clk,
    input         mac_rst,
    output [63:0] mac_tx_data,
    output  [7:0] mac_tx_data_valid,
    output        mac_tx_start,
    input         mac_tx_ack
  );

  /****************** Common Signals *******************/
  /* these signals are used by the primary tx state machine and various
  /* periphery logic

  /* Fabric data signals */
  wire [63:0] packet_data;
  wire        packet_rd;
  wire        packet_data_overflow;

  /* Fabric control signals */
  wire [31:0] packet_ctrl_ip;
  wire [15:0] packet_ctrl_port;
  wire [15:0] packet_ctrl_size;
  wire        packet_ctrl_empty;
  wire        packet_ctrl_overflow;
  wire        packet_ctrl_rd;

  /* Arp cache signals */
  wire  [7:0] packet_arp_cache_addr;
  wire [47:0] packet_arp_cache_data;

  /* CPU interface signals */
  wire mac_cpu_ack;
  wire mac_cpu_pending;
  wire  [7:0] mac_cpu_size;
  wire [63:0] mac_cpu_data;
  wire  [7:0] mac_cpu_addr;

  /************ Application Interface logic ************/

  reg         app_tx_validR;
  reg  [63:0] app_tx_dataR;
  reg  [31:0] app_tx_dest_ipR;
  reg  [15:0] app_tx_dest_portR;
  reg         app_tx_ctrl_fifo_en;

  always @(posedge app_clk) begin
    app_tx_validR <= app_tx_valid;
    app_tx_dataR <= app_tx_data;
    app_tx_dest_ipR <= app_tx_dest_ip;
    app_tx_dest_portR <= app_tx_dest_port;
    app_tx_ctrl_fifo_en <= app_tx_valid && app_tx_end_of_frame;
  end

  /* keep track of data count for ctrl_fifo */
  reg [15:0] data_count;
  always @(posedge app_clk) begin
    if (app_rst) begin
      data_count <= 1'd1; /* pre-add last word */
    end else begin
      if (app_tx_ctrl_fifo_en) begin
        data_count <= 16'd1;
`ifdef DESPERATE_DEBUG
        $display("tge_tx: got fabric frame, size = %d", data_count);
`endif
      end else if (app_tx_validR) begin
        data_count <= data_count + 1;
      end
    end
  end

  wire tx_packet_fifo_prog_full;

  /* tx data fifo - 1024 deep*/

  wire [63:0] packet_fifo_data;
  wire        packet_fifo_rd;
  wire        packet_fifo_empty;

  tx_packet_fifo tx_packet_fifo_inst(
    .wr_clk    (app_clk),
    .din       (app_tx_dataR),
    .wr_en     (app_tx_validR),
    .rd_clk    (mac_clk),
    .dout      (packet_fifo_data),
    .rd_en     (packet_fifo_rd),
    .prog_full (tx_packet_fifo_prog_full),
    .empty     (packet_fifo_empty),
    .overflow  (packet_data_overflow),
    .rst       (app_rst)
  );

  /* ip, port & data_count fifo*/
  wire tx_packet_ctrl_fifo_prog_full;
  wire [63:0] ctrl_fifo_data;
  wire        ctrl_fifo_rd;
  wire        ctrl_fifo_empty;

  tx_packet_ctrl_fifo tx_packet_ctrl_fifo_inst(
    .wr_clk    (app_clk),
    .din       ({data_count, app_tx_dest_portR, app_tx_dest_ipR}),
    .wr_en     (app_tx_ctrl_fifo_en),
    .rd_clk    (mac_clk),
    .dout      (ctrl_fifo_data),
    .rd_en     (ctrl_fifo_rd),
    .prog_full (tx_packet_ctrl_fifo_prog_full),
    .overflow  (packet_ctrl_overflow),
    .empty     (ctrl_fifo_empty),
    .rst       (app_rst)
  );
  assign app_tx_afull = tx_packet_fifo_prog_full || tx_packet_ctrl_fifo_prog_full;

generate if (LARGE_PACKETS) begin : large_packet_gen
  /* Depth extension Fifos - required to allow >= 8k packets */
  wire data_fifo_ext_afull;

  assign packet_fifo_rd = !data_fifo_ext_afull && !packet_fifo_empty;

  tx_fifo_ext tx_data_fifo_ext(
    .clk       (mac_clk),
    .rst       (app_rst),
    .din       (packet_fifo_data),
    .wr_en     (packet_fifo_rd),
    .dout      (packet_data),
    .rd_en     (packet_rd),
    .empty     (),
    .full      (),
    .prog_full (data_fifo_ext_afull)
  );

  wire ctrl_fifo_ext_afull;
  assign ctrl_fifo_rd = !ctrl_fifo_ext_afull && !ctrl_fifo_empty;

  tx_fifo_ext tx_ctrl_fifo_ext(
    .clk       (mac_clk),
    .rst       (app_rst),
    .din       (ctrl_fifo_data),
    .wr_en     (ctrl_fifo_rd),
    .dout      ({packet_ctrl_size, packet_ctrl_port, packet_ctrl_ip}),
    .rd_en     (packet_ctrl_rd),
    .empty     (packet_ctrl_empty),
    .full      (),
    .prog_full (ctrl_fifo_ext_afull)
  );

end else begin : small_packet_gen

  /* No extension Fifos */
  assign packet_ctrl_size  = ctrl_fifo_data[63:48];
  assign packet_ctrl_port  = ctrl_fifo_data[47:32];
  assign packet_ctrl_ip    = ctrl_fifo_data[31:0];
  assign ctrl_fifo_rd      = packet_ctrl_rd;
  assign packet_ctrl_empty = ctrl_fifo_empty;

  assign packet_data       = packet_fifo_data;
  assign packet_fifo_rd    = packet_rd;

end endgenerate

  /* Overflow Control */
  reg tx_overflow_latch;

  always @(posedge app_clk) begin
    if (app_rst) begin
      tx_overflow_latch <= 1'b0;
    end else begin
      if (packet_data_overflow || packet_ctrl_overflow) begin
        tx_overflow_latch <= 1'b1;
      end
    end
  end
  assign app_tx_overflow = tx_overflow_latch;

  /************ ARP Cache ************/

  arp_cache arp_cache_inst(   
    .clka      (cpu_clk),
    .dina      (arp_cache_wr_data),
    .addra     (arp_cache_addr),
    .wea       (arp_cache_wr_en),
    .douta     (arp_cache_rd_data),

    .clkb      (mac_clk),
    .dinb      (48'b0),
    .addrb     (packet_arp_cache_addr),
    .web       (1'b0),
    .doutb     (packet_arp_cache_data)
  );

  /************ TX CPU Memory ************/

  reg cpu_buffer_sel;  

  /* tx data fifo - 64x512 */

generate if (CPU_ENABLE) begin : rx_cpu_enabled

  cpu_buffer cpu_tx_buffer(   
    .clka      (cpu_clk),
    .dina      (cpu_tx_buffer_wr_data),
    .addra     ({cpu_buffer_sel, cpu_tx_buffer_addr}),
    .wea       (cpu_tx_buffer_wr_en),
    .douta     (cpu_tx_buffer_rd_data),

    .clkb      (mac_clk),
    .dinb      (64'h0),
    .addrb     ({!cpu_buffer_sel, mac_cpu_addr}),
    .web       (1'b0),
    .doutb     (mac_cpu_data)
  );

end endgenerate

  /* CPU handshaking */
  reg ack_low_wait;
  reg mac_cpu_ackR, mac_cpu_ackRR;
  reg mac_pending;

  reg [7:0] cpu_tx_size_reg;

  always @(posedge cpu_clk) begin
    mac_cpu_ackR  <= mac_cpu_ack;
    mac_cpu_ackRR <= mac_cpu_ackR;
    if (cpu_rst) begin
      cpu_buffer_sel  <= 1'b0;
      mac_pending     <= 1'b0;
      ack_low_wait    <= 1'b0;
      cpu_tx_size_reg <= 8'h0;
    end else begin
      case (ack_low_wait)
        1'b0: begin
          if (!mac_pending && cpu_tx_ready) begin
            mac_pending     <= 1'b1;
            cpu_buffer_sel  <= !cpu_buffer_sel;
            cpu_tx_size_reg <= cpu_tx_size;
          end 
          if (mac_cpu_ackRR) begin
            mac_pending     <= 1'b0;
            ack_low_wait    <= 1'b1;
          end
        end
        1'b1: begin
          if (!mac_cpu_ackRR) begin
            ack_low_wait <= 1'b0;
          end
        end
      endcase
    end
  end
  assign cpu_tx_done = !ack_low_wait && !mac_pending && cpu_tx_ready;

  reg mac_pendingR;
  reg mac_pendingRR;

  always @(posedge mac_clk) begin
    mac_pendingR  <= mac_pending;
    mac_pendingRR <= mac_pendingR;
  end

  assign mac_cpu_size = cpu_tx_size_reg;
  assign mac_cpu_pending = mac_pendingRR;

  /******* cross local_enable to MAC clock domain **********/

  reg local_enable_R;
  reg local_enable_retimed;

  always @(posedge mac_clk) begin
    local_enable_R   <= local_enable;
    local_enable_retimed <= local_enable_R;
  end

  reg app_overflowR;
  wire app_overflow_retimed = app_overflowR;
  always @(posedge mac_clk) begin
    app_overflowR  <= tx_overflow_latch;
  end

  /************** Primary transmit State Machine ***************/

  reg [3:0] tx_state;
  localparam TX_IDLE       = 4'd0;
  localparam TX_SEND_HDR_1 = 4'd1;
  localparam TX_SEND_HDR_2 = 4'd2;
  localparam TX_SEND_HDR_3 = 4'd3;
  localparam TX_SEND_HDR_4 = 4'd4;
  localparam TX_SEND_HDR_5 = 4'd5;
  localparam TX_SEND_HDR_6 = 4'd6;
  localparam TX_SEND_DATA  = 4'd7;
  localparam TX_SEND_LAST  = 4'd8;
  localparam TX_CPU_WAIT   = 4'd9;
  localparam TX_SEND_CPU   = 4'd10;
  localparam TX_SEND_HDR_1_MCAST = 4'd11;

  /* Outside interface registers */
  reg  packet_rd_reg;
  assign packet_rd = packet_rd_reg;

  reg [7:0] mac_data_valid;
  assign mac_tx_data_valid = mac_data_valid;

  /* Internal registers */
  reg [15:0] ip_length;
  reg [15:0] udp_length;

  reg [17:0] ip_checksum_0;
  reg [16:0] ip_checksum_1;
  reg [15:0] ip_checksum;
  wire [17:0] ip_checksum_fixed_0;
  wire [16:0] ip_checksum_fixed_1;
  wire [15:0] ip_checksum_fixed;

  reg [15:0] tx_size;

  /* Due to wrapper format, we always need to wait one cycle to send the last 16 bits */
  reg [15:0] data_leftovers;

  reg mac_cpu_ack_reg;
  assign mac_cpu_ack = mac_cpu_ack_reg;
  reg [7:0] mac_cpu_addr_reg;

  always @(posedge mac_clk) begin
    /* strobes */
    packet_rd_reg      <= 1'b0;
    /* always latch data to store leftovers */
    data_leftovers <= packet_data[15:0];

    if (mac_rst) begin
      tx_state          <= TX_IDLE;
      mac_data_valid    <= 8'b0;
      ip_length         <= 16'b0;
      ip_checksum_0     <= 18'b0;
      ip_checksum_1     <= 17'b0;
      ip_checksum       <= 16'b0;
      mac_cpu_ack_reg   <= 1'b0;
      mac_cpu_addr_reg  <= 8'd0;
    end else begin
      if (!mac_cpu_pending) begin
        mac_cpu_ack_reg <= 1'b0;
      end

      case (tx_state)
        TX_IDLE:          begin
          mac_cpu_addr_reg <= 8'd0;

          if (!packet_ctrl_empty && local_enable_retimed && !app_overflow_retimed) begin
            mac_data_valid <= {8{1'b1}};
            tx_size        <= packet_ctrl_size - 1;
            if (packet_ctrl_ip[31:28] == 4'b1110) begin
                tx_state       <= TX_SEND_HDR_1_MCAST;
            end else begin
                tx_state       <= TX_SEND_HDR_1;
            end
          end

          /* CPU Access take preference */
          if (!mac_cpu_ack_reg && mac_cpu_pending) begin
            if (mac_cpu_size != 16'd0) begin
              mac_data_valid   <= {8{1'b1}};
              tx_size          <= mac_cpu_size;
              tx_state         <= TX_CPU_WAIT;
              mac_cpu_addr_reg <= 8'd1;
            end else begin
              mac_cpu_ack_reg <= 1'b1;
            end
`ifdef DEBUG
            $display("tge_tx: sending cpu frame, size = %d", mac_cpu_size);
`endif
          end
        end
        TX_SEND_HDR_1:    begin
          if (mac_tx_ack) begin
            tx_state      <= TX_SEND_HDR_2;
          end
        end
        TX_SEND_HDR_1_MCAST: begin
          if (mac_tx_ack) begin
            tx_state      <= TX_SEND_HDR_2;
          end
        end
        TX_SEND_HDR_2:    begin
          tx_state <= TX_SEND_HDR_3;
        end
        TX_SEND_HDR_3:    begin
          tx_state <= TX_SEND_HDR_4;
        end
        TX_SEND_HDR_4:    begin
          tx_state <= TX_SEND_HDR_5;
        end
        TX_SEND_HDR_5:    begin
          /* We now start to tick the data fifo */
          tx_state  <= TX_SEND_HDR_6;
          packet_rd_reg <= 1'b1; /* tick */
        end
        TX_SEND_HDR_6:    begin
          tx_size       <= tx_size - 1;
          if (tx_size == 16'd0) begin
            mac_data_valid <= 8'b00000011;
            tx_state       <= TX_SEND_LAST;
          end else begin
            tx_state       <= TX_SEND_DATA;
            packet_rd_reg <= 1'b1; /* tick */
          end
        end
        TX_SEND_DATA: begin
          tx_size        <= tx_size - 1;
          if (tx_size == 16'd0) begin
            mac_data_valid <= 8'b00000011;
            tx_state          <= TX_SEND_LAST;
          end else begin
            packet_rd_reg <= 1'b1; /* tick */
          end
        end
        TX_SEND_LAST: begin
           tx_state       <= TX_IDLE;
           mac_data_valid <= 8'b00000000;
`ifdef DESPERATE_DEBUG
           $display("tge_tx: sent fabric frame");
`endif
        end
        TX_CPU_WAIT: begin
           if (mac_tx_ack) begin
             if (tx_size == 16'd1) begin
               tx_state       <= TX_IDLE;
               mac_data_valid <= 8'b00000000;
               mac_cpu_ack_reg <= 1'b1;
             end else begin
               tx_state         <= TX_SEND_CPU;
               tx_size          <= tx_size - 1;
               mac_cpu_addr_reg <= mac_cpu_addr_reg + 1;
             end
           end
        end
        TX_SEND_CPU: begin
           if (tx_size == 16'd1) begin
             tx_state       <= TX_IDLE;
             mac_data_valid <= 8'b00000000;
             mac_cpu_ack_reg <= 1'b1;
           end else begin
             tx_size          <= tx_size - 1;
             mac_cpu_addr_reg <= mac_cpu_addr_reg + 1;
           end
        end
      endcase
      // compute the ip length
      ip_length <= {packet_ctrl_size, 3'b0} + 28;
      // compute the udp length
      udp_length <= {packet_ctrl_size, 3'b0} + 8;
      // compute the ip checksum (1's complement logic)
      ip_checksum_0 <= {2'b00, ip_checksum_fixed     }+
                       {2'b00, ip_length             }+
                       {2'b00, packet_ctrl_ip[31:16] }+
                       {2'b00, packet_ctrl_ip[15:0 ] };
      ip_checksum_1 <= {1'b0 , ip_checksum_0[15:0 ]  }+
                       {15'b0, ip_checksum_0[17:16]  };
      ip_checksum   <= ~(ip_checksum_1[15:0] + {15'b0, ip_checksum_1[16]});

    end
  end

  /* checkdsum assignments */
  assign ip_checksum_fixed_0 = {8'h00, 16'h8412} + {8'h00, local_ip[31:16]} + {8'h00, local_ip[15:0]};
  assign ip_checksum_fixed_1 = {1'b0, ip_checksum_fixed_0[15:0]} + {15'b0, ip_checksum_fixed_0[17:16]};
  assign ip_checksum_fixed   = {ip_checksum_fixed_1[15:0]} + {15'b0, ip_checksum_fixed_1[16]};

  /* Cpu address assignment */
  assign mac_cpu_addr = tx_state == TX_CPU_WAIT && !mac_tx_ack ? 8'd0 : mac_cpu_addr_reg;

  /* pop stuff off the ctrl fifo on last word */
  assign packet_ctrl_rd = tx_state == TX_SEND_LAST;

  /* Mac Start assign */
  assign mac_tx_start = (tx_state == TX_IDLE) && ((!packet_ctrl_empty && local_enable_retimed && !app_overflow_retimed) || (!mac_cpu_ack_reg && mac_cpu_pending && mac_cpu_size != 16'd0));

  /*** MAC data decode ***/
  reg [63:0] mac_data;

  wire [47:0] dest_mac = packet_arp_cache_data;
  always @(*) begin
    case (tx_state)
      TX_SEND_HDR_1:    begin
        /* {src_mac[4], src_mac[5], dest_mac[0], dest_mac[1] dest_mac[2], dest_mac[3], dest_mac[4], dest_mac[5]} */
        mac_data <= {local_mac[39:32], local_mac[47:40], dest_mac[ 7:0 ], dest_mac[15:8 ],
                      dest_mac[23:16],  dest_mac[31:24], dest_mac[39:32], dest_mac[47:40]};
      end
      TX_SEND_HDR_1_MCAST:    begin
        /* {src_mac[4], src_mac[5], dest_mac[0], dest_mac[1] dest_mac[2], dest_mac[3], dest_mac[4], dest_mac[5]} */
        mac_data <= {local_mac[39:32], local_mac[47:40], packet_ctrl_ip[ 7:0 ], packet_ctrl_ip[15:8 ],
                     1'b0,packet_ctrl_ip[22:16], 8'b01011110, 8'b00000000, 8'b00000001};
      end
      TX_SEND_HDR_2:    begin
        /* {IP Type, IP version, Ethetype[0], Ethertype[1], src_mac[0], src_mac[1], src_mac[2], src_mac[3]} */
        mac_data <= {         8'h00,           8'h45,            8'h00,           8'h08,
                     local_mac[7:0], local_mac[15:8], local_mac[23:16], local_mac[31:24]};
      end
      TX_SEND_HDR_3:    begin
        /* {protocol(UDP), TTL, frag_offset[0], flags, ID[0], ID[1], ipsize[0], ipsize[1]} */ 
        mac_data <= {8'h11, 8'hff, 8'h00, 8'h40, 8'h00, 8'h00, ip_length[7:0], ip_length[15:8]};
      end
      TX_SEND_HDR_4:    begin
        mac_data <= {packet_ctrl_ip[23:16], packet_ctrl_ip[31:24], local_ip[7:0], local_ip[15:8], local_ip[23:16], local_ip[31:24], ip_checksum[7:0], ip_checksum[15:8]};
      end
      TX_SEND_HDR_5:    begin
        mac_data <= {udp_length[7:0], udp_length[15:8], packet_ctrl_port[7:0], packet_ctrl_port[15:8],
                     local_port[7:0], local_port[15:8],   packet_ctrl_ip[7:0],   packet_ctrl_ip[15:8]};
      end
      TX_SEND_HDR_6:    begin
        /* No UDP Checksum */
        mac_data <= {packet_data[23:16], packet_data[31:24], packet_data[39:32], packet_data[47:40],
                     packet_data[55:48], packet_data[63:56], 8'h00,              8'h00};
      end
      TX_SEND_DATA: begin
        mac_data <= {packet_data[23:16], packet_data[31:24],    packet_data[39:32],    packet_data[47:40],
                     packet_data[55:48], packet_data[63:56], data_leftovers[ 7:0 ], data_leftovers[15:8 ]};
      end
      TX_SEND_LAST: begin
        mac_data <= {48'h00000000, data_leftovers[7:0], data_leftovers[15:8]};
      end
      TX_SEND_CPU: begin
        mac_data <= {mac_cpu_data[ 7:0 ], mac_cpu_data[15:8 ], mac_cpu_data[23:16], mac_cpu_data[31:24],
                     mac_cpu_data[39:32], mac_cpu_data[47:40], mac_cpu_data[55:48], mac_cpu_data[63:56]};
      end
      TX_CPU_WAIT: begin
        mac_data <= {mac_cpu_data[ 7:0 ], mac_cpu_data[15:8 ], mac_cpu_data[23:16], mac_cpu_data[31:24],
                     mac_cpu_data[39:32], mac_cpu_data[47:40], mac_cpu_data[55:48], mac_cpu_data[63:56]};
      end
      default: begin
        mac_data <= 64'b0;
      end
    endcase
  end
  assign mac_tx_data = mac_data;

  /* arp cache address decode */
  assign packet_arp_cache_addr = packet_ctrl_ip[31:8] != local_ip[31:8] ? local_gateway : packet_ctrl_ip[7:0];

endmodule
