`timescale 1ns/1ps
module gbe_rx #(
    parameter DIS_CPU = 0
  ) (
    input         app_clk,

    output  [7:0] app_data,
    output        app_dvld,
    output        app_eof,
    output [31:0] app_srcip,
    output [15:0] app_srcport,
    output        app_badframe,

    output        app_overrun,
    input         app_ack,
    input         app_rst,

    input         mac_clk,
    input         mac_rst,
    input   [7:0] mac_rx_data,
    input         mac_rx_dvld,
    input         mac_rx_goodframe,
    input         mac_rx_badframe,

    input         local_enable,
    input  [47:0] local_mac,
    input  [31:0] local_ip,
    input  [15:0] local_port,
    input         cpu_promiscuous,

    output [10:0] cpu_addr,
    output  [7:0] cpu_wr_data,
    output        cpu_wr_en,

    output        cpu_buffer_sel,
    output [10:0] cpu_size,
    output        cpu_ready,
    input         cpu_ack
  );


  wire [10:0] packet_fifo_din;
  wire        packet_fifo_wr;
  wire        packet_fifo_overflow;

  wire [10:0] packet_fifo_dout;
  wire        packet_fifo_rd;
  wire        packet_fifo_empty;

  gbe_rx_packet_fifo rx_packet_fifo_inst(
    .wr_clk    (mac_clk),
    .din       (packet_fifo_din),
    .wr_en     (packet_fifo_wr),

    .rd_clk    (app_clk),
    .dout      (packet_fifo_dout),
    .rd_en     (packet_fifo_rd),

    .empty     (packet_fifo_empty),
    .overflow  (packet_fifo_overflow),

    .rst       (app_rst)
  );

  wire  [47:0] ctrl_fifo_din;
  wire         ctrl_fifo_wr;
  wire         ctrl_fifo_overflow;

  wire  [47:0] ctrl_fifo_dout;
  wire         ctrl_fifo_rd;
  wire         ctrl_fifo_empty;

  gbe_rx_ctrl_fifo rx_ctrl_fifo_inst(
    .wr_clk    (mac_clk),
    .din       (ctrl_fifo_din),
    .wr_en     (ctrl_fifo_wr),

    .rd_clk    (app_clk),
    .dout      (ctrl_fifo_dout),
    .rd_en     (ctrl_fifo_rd),

    .empty     (ctrl_fifo_empty),
    .overflow  (ctrl_fifo_overflow),

    .rst       (app_rst)
  );

  assign app_dvld     = !packet_fifo_empty;
  assign app_data     = packet_fifo_dout[7:0];
  assign app_eof      = packet_fifo_dout[8];
  assign app_badframe = packet_fifo_dout[9];

  assign app_srcip    = ctrl_fifo_dout[31:0];
  assign app_srcport  = ctrl_fifo_dout[47:32];

  assign packet_fifo_rd = app_ack;

  /* This is a significant timing hazard
     It may be possible to improve this by prefetching this first value into a register
     but it's probably a little too much of a mission OR
     you could just make the ctrl stuff lag the data by one cycle... */

  assign ctrl_fifo_rd   = app_ack && app_eof && app_dvld;


  /*** MAC RX state machine ***/
  reg [2:0] rx_state;

  localparam RX_IDLE = 3'd0;
  localparam RX_HDR0 = 3'd1;
  localparam RX_HDR1 = 3'd2;
  localparam RX_HDR2 = 3'd3;
  localparam RX_DATA = 3'd4;

  reg [5:0] hdr_progress;

  localparam MAC_HDR_SIZE = 14;
  localparam IP_HDR_SIZE  = 20;
  localparam UDP_HDR_SIZE = 8;
  
  reg icmp_unsearchable;

  always @(posedge mac_clk) begin
    hdr_progress  <= hdr_progress + 6'd1;

    if (mac_rst) begin
      rx_state     <= RX_IDLE;
      hdr_progress <= 6'd0;
    end else begin
      case (rx_state)
        RX_IDLE: begin
          if (mac_rx_dvld) begin
            hdr_progress <= 6'd0;
            rx_state     <= RX_HDR0;
          end
        end
        RX_HDR0: begin
          if (hdr_progress == MAC_HDR_SIZE - 1) begin
            rx_state     <= RX_HDR1;
            hdr_progress <= 6'd0;
          end
        end
        RX_HDR1: begin
//           if (hdr_progress == IP_HDR_SIZE - 1) begin
//             rx_state     <= RX_HDR2;
//             hdr_progress <= 6'd0;
//           end

          if ((hdr_progress == IP_HDR_SIZE - 1) && (icmp_unsearchable == 1'b0)) begin
            rx_state     <= RX_HDR2;
            hdr_progress <= 6'd0;
          end
          if ((hdr_progress == IP_HDR_SIZE + 28 - 1) && (icmp_unsearchable == 1'b1)) begin
            rx_state     <= RX_HDR2;
            hdr_progress <= 6'd0;
          end
          
        end
        RX_HDR2: begin
          if (hdr_progress == UDP_HDR_SIZE - 1) begin
            rx_state <= RX_DATA;
          end
        end
        RX_DATA: begin
          if (!mac_rx_dvld) begin
            rx_state <= RX_IDLE;
          end
        end
      endcase
    end
  end

  /* Delay data by 1 to align with state machine */

  reg [7:0] mac_data;
  reg       mac_dvld;
  always @(posedge mac_clk) begin
    mac_data <= mac_rx_data;
    mac_dvld <= mac_rx_dvld;
  end

  /*** Another delay to line up with frame ok's ***/

  reg [7:0] mac_data_aligned;
  reg       mac_dvld_aligned;
  always @(posedge mac_clk) begin
    mac_data_aligned <= mac_data;
    mac_dvld_aligned <= mac_dvld;
  end
   
  /**** Collect destination and UDP ports ****/

  reg [31:0] src_addr;
  reg [15:0] src_port;

  always @(posedge mac_clk) begin
    if (rx_state == RX_HDR1) begin
      case (hdr_progress)
        12: src_addr[31:24] <= mac_data;
        13: src_addr[23:16] <= mac_data;
        14: src_addr[15:8]  <= mac_data;
        15: src_addr[7:0]   <= mac_data;
      endcase
    end
    if (rx_state == RX_HDR2) begin
      case (hdr_progress)
        0: src_port[15:8] <= mac_data;
        1: src_port[7:0]  <= mac_data;
      endcase
    end
  end

  /**** Generate packet check flags ****/

  reg cpu_ok;
  reg app_ok;

  reg hdr0_cpu_ok;
  reg hdr0_app_ok;

  reg hdr1_cpu_ok;
  reg hdr1_app_ok;

  reg hdr2_cpu_ok;
  reg hdr2_app_ok;

  reg hdr0_cpu_okR;
  reg hdr0_app_okR;

  reg hdr1_cpu_okR;
  reg hdr1_app_okR;

  reg hdr2_cpu_okR;
  reg hdr2_app_okR;

  reg [2:0] rx_stateR;

  always @(posedge mac_clk) begin
    /* Register here to improve timing
       we need to register the state too */
    rx_stateR     <= rx_state;
    hdr0_cpu_okR  <= hdr0_cpu_ok;
    hdr0_app_okR  <= hdr0_app_ok;
                                
    hdr1_cpu_okR  <= hdr1_cpu_ok;
    hdr1_app_okR  <= hdr1_app_ok;
                                
    hdr2_cpu_okR  <= hdr2_cpu_ok;
    hdr2_app_okR  <= hdr2_app_ok;

    if (mac_rst) begin
      cpu_ok <= 1'b1;
      app_ok <= 1'b1;
    end else begin
      case (rx_stateR) 
        RX_IDLE: begin
          cpu_ok <= 1'b1;
          app_ok <= 1'b1;
        end
        RX_HDR0: begin
          cpu_ok <= cpu_ok && hdr0_cpu_okR;
          app_ok <= app_ok && hdr0_app_okR;
        end
        RX_HDR1: begin
          cpu_ok <= cpu_ok && hdr1_cpu_okR;
          app_ok <= app_ok && hdr1_app_okR;
        end
        RX_HDR2: begin
          cpu_ok <= cpu_ok && hdr2_cpu_okR;
          app_ok <= app_ok && hdr2_app_okR;
        end
        RX_DATA: begin
          if (app_ok)
            cpu_ok <= 1'b0;
        end
      endcase
      if (DIS_CPU) begin
        cpu_ok <= 1'b0; // Force CPU NOK
      end
    end
  end

  /* Local enable retimer */
  reg local_enableR;
  reg local_enableRR;
  wire local_enable_retimed = local_enableRR;
  always @(posedge mac_clk) begin
    local_enableR  <= local_enable;
    local_enableRR <= local_enableR;
  end

  /********** MAC Header Checks **********/

  always @(posedge mac_clk) begin
    hdr0_cpu_ok <= 1'b1;

    if (local_enable_retimed) begin
      hdr0_app_ok <= 1'b1;
    end else begin
      hdr0_app_ok <= 1'b0;
    end
   if (rx_state == RX_HDR0) begin
    case (hdr_progress)
      0: begin
        if (local_mac[47:40] != mac_data && mac_data != 8'hff) begin
          hdr0_app_ok <= 1'b0;
          if (!cpu_promiscuous)
            hdr0_cpu_ok <= 1'b0;
        end
      end
      1: begin
        if (local_mac[39:32] != mac_data && mac_data != 8'hff) begin
          hdr0_app_ok <= 1'b0;
          if (!cpu_promiscuous)
            hdr0_cpu_ok <= 1'b0;
        end
      end
      2: begin
        if (local_mac[31:24] != mac_data && mac_data != 8'hff) begin
          hdr0_app_ok <= 1'b0;
          if (!cpu_promiscuous)
            hdr0_cpu_ok <= 1'b0;
        end
      end
      3: begin
        if (local_mac[23:16] != mac_data && mac_data != 8'hff) begin
          hdr0_app_ok <= 1'b0;
          if (!cpu_promiscuous)
            hdr0_cpu_ok <= 1'b0;
        end
      end
      4: begin
        if (local_mac[15:8] != mac_data && mac_data != 8'hff) begin
          hdr0_app_ok <= 1'b0;
          if (!cpu_promiscuous)
            hdr0_cpu_ok <= 1'b0;
        end
      end
      5: begin
        if (local_mac[7:0] != mac_data && mac_data != 8'hff) begin
          hdr0_app_ok <= 1'b0;
          if (!cpu_promiscuous)
            hdr0_cpu_ok <= 1'b0;
        end
      end
      12: begin /* Ethertype[15:8] - must be ipv4*/
        if (mac_data != 8'h08) begin
          hdr0_app_ok <= 1'b0;
        end
      end
      13: begin /* Ethertype[7:0] - must be ipv4*/
        if (mac_data != 8'h00) begin
          hdr0_app_ok <= 1'b0;
        end
      end
    endcase
   end // if (rx_state == RX_HDR0) begin
  end

  /********** IP Header Checks **********/

  always @(posedge mac_clk) begin
    hdr1_cpu_ok <= 1'b1;

    if (local_enable_retimed) begin
      hdr1_app_ok <= 1'b1;
    end else begin
      hdr1_app_ok <= 1'b0;
    end    
   
   if (rx_state == RX_HDR1) begin
    case (hdr_progress)
      0: begin
        if (mac_data != 8'h45) begin
          hdr1_app_ok <= 1'b0;
        end
      end
      9: begin
        /* must be udp */
//         if (mac_data != 8'h11) begin
//           hdr1_app_ok <= 1'b0;
//         end

        // must be udp or icmp unsearchable (loopback test)
        if ((mac_data != 8'h11) && (mac_data != 8'h1)) begin        
          hdr1_app_ok <= 1'b0;
        end
        
        // if ICMP unsearchable
        if (mac_data == 8'h1) begin        
          icmp_unsearchable <= 1'b1;
        end        
        
      end
      16: begin
        if (mac_data != local_ip[31:24]) begin
          hdr1_app_ok <= 1'b0;
        end
      end
      17: begin
        if (mac_data != local_ip[23:16]) begin
          hdr1_app_ok <= 1'b0;
        end
      end
      18: begin
        if (mac_data != local_ip[15:8]) begin
          hdr1_app_ok <= 1'b0;
        end
      end
      19: begin
        if (mac_data != local_ip[7:0]) begin
          hdr1_app_ok <= 1'b0;
        end
      end    
    endcase
   end // if (rx_state == RX_HDR1) begin
   if (rx_state == RX_HDR0) begin
     icmp_unsearchable <= 1'b0;
   end
  end

  /********** UDP Header Checks **********/

  always @(posedge mac_clk) begin
    hdr2_cpu_ok <= 1'b1;

    if (local_enable_retimed) begin
      hdr2_app_ok <= 1'b1;
    end else begin
      hdr2_app_ok <= 1'b0;
    end

   if (rx_state == RX_HDR2) begin
    case (hdr_progress)
      2: begin
        if (mac_data != local_port[15:8]) begin
          hdr2_app_ok <= 1'b0;
        end
      end
      3: begin
        if (mac_data != local_port[7:0]) begin
          hdr2_app_ok <= 1'b0;
        end
      end
    endcase
   end //    if (rx_state == RX_HDR1) begin
  end

  /*********** Application WR Interface ***********/

  /* Overrun logic */

  reg rx_overrun;

  reg app_overrunR;
  reg app_overrunRR;
  assign app_overrun = app_overrunRR;

  always @(posedge app_clk) begin
    app_overrunR  <= rx_overrun;
    app_overrunRR <= app_overrunR;
  end

  reg  app_rst_got;
  reg  app_rst_ack;
  reg  app_rst_ackR;
  reg  app_rst_ackRR;

  always @(posedge app_clk) begin
    app_rst_ackR  <= app_rst_ack;
    app_rst_ackRR <= app_rst_ackR;

    if (app_rst) begin
      app_rst_got <= 1'b1; 
    end else begin
      if (app_rst_ackRR) begin
        app_rst_got <= 1'b0;
      end
    end
  end

  reg  app_rst_gotR;
  reg  app_rst_gotRR;

  always @(posedge mac_clk) begin
    app_rst_gotR  <= app_rst_got;
    app_rst_gotRR <= app_rst_gotR;
    if (mac_rst) begin
      rx_overrun <= 1'b0;
    end else begin
      if (packet_fifo_overflow || ctrl_fifo_overflow) begin
        rx_overrun <= 1'b1;
      end

      if (app_rst_gotRR) begin
        app_rst_ack <= 1'b1;
      end

      if (app_rst_ack && !app_rst_gotRR) begin
        rx_overrun <= 1'b0;
        app_rst_ack <= 1'b0;
      end
    end
  end

  reg app_state;
  localparam APP_RUNNING = 1'b0;
  localparam APP_BLOCKED = 1'b1;

  always @(posedge mac_clk) begin
    if (mac_rst) begin
      app_state <= APP_RUNNING;
    end else begin
      case (app_state)
        APP_RUNNING: begin
          if (rx_overrun)
            app_state <= APP_BLOCKED;
        end
        APP_BLOCKED: begin
          if (!rx_overrun) begin
            if (!mac_dvld_aligned)
              app_state <= APP_RUNNING;
          end
        end
      endcase
    end
  end

  reg packet_dvld;
  reg packet_first;
  always @(posedge mac_clk) begin
    packet_dvld  <= 1'b0;
    packet_first <= 1'b0;

    if (rx_state == RX_DATA && rx_stateR != RX_DATA)
      packet_first <= 1'b1;

    if (rx_state == RX_DATA)
      packet_dvld <= 1'b1;
  end

  wire packet_eof = mac_dvld_aligned && !mac_dvld;

  assign packet_fifo_din = {1'b0, packet_eof, mac_data_aligned};
  assign packet_fifo_wr  = packet_dvld && app_state == APP_RUNNING && app_ok;

  assign ctrl_fifo_din = {src_port, src_addr};
  assign ctrl_fifo_wr  = app_state == APP_RUNNING && packet_first && app_ok;

  /*********** CPU Interface ***********/

  reg [1:0] cpu_state;
  localparam CPU_IDLE      = 2'd0;
  localparam CPU_DATA      = 2'd1;
  localparam CPU_VALIDATE  = 2'd2;
  localparam CPU_HANDSHAKE = 2'd3;

  reg cpu_buffer_sel_reg;
  assign cpu_buffer_sel = cpu_buffer_sel_reg;

  reg cpu_invalidate;

  reg [10:0] cpu_counter;

  reg cpu_ready_reg;
  assign cpu_ready = cpu_ready_reg;

  always @(posedge mac_clk) begin

    if (mac_rst) begin
      cpu_state          <= CPU_IDLE;
      cpu_buffer_sel_reg <= 1'b0;
      cpu_counter        <= 11'b0;
      cpu_invalidate     <= 1'b0;
      cpu_ready_reg      <= 1'b0;
    end else begin

      case (cpu_state)
        CPU_IDLE: begin
          cpu_invalidate <= 1'b0;
          cpu_counter    <= 11'b0;
          cpu_ready_reg  <= 1'b0;

          if (mac_dvld)
            cpu_state <= CPU_DATA;
        end
        CPU_DATA: begin
          if (!mac_dvld) begin
            cpu_state <= CPU_VALIDATE;
          end else begin
            if (cpu_counter == {11{1'b1}}) begin
              cpu_invalidate <= 1'b1;
            end 
            if (!cpu_ok)
              cpu_invalidate <= 1'b1;
            cpu_counter <= cpu_counter + 11'd1;
          end
        end
        CPU_VALIDATE: begin
          if (mac_rx_goodframe) begin
            cpu_state     <= CPU_HANDSHAKE;
            cpu_ready_reg <= 1'b1;
          end

          if (mac_rx_badframe || cpu_invalidate) begin
            cpu_state <= CPU_IDLE;
          end
        end
        CPU_HANDSHAKE: begin
          if (cpu_ack && cpu_ready_reg) begin
            cpu_ready_reg      <= 1'b0;
            cpu_buffer_sel_reg <= !cpu_buffer_sel_reg;
          end
          if (!cpu_ready && !cpu_ack) begin
            cpu_state <= CPU_IDLE;
          end
        end
      endcase

      // Kill CPU interface when DIS_CPU == 1
      if (DIS_CPU) begin
        cpu_state          <= CPU_IDLE;
        cpu_buffer_sel_reg <= 1'b0;
        cpu_counter        <= 11'b0;
        cpu_invalidate     <= 1'b1;
        cpu_ready_reg      <= 1'b0;
      end
    end
  end

  assign cpu_wr_en   = cpu_state == CPU_DATA;
  assign cpu_addr    = cpu_counter;
  assign cpu_wr_data = mac_data_aligned;

  assign cpu_size    = cpu_counter;

endmodule //
