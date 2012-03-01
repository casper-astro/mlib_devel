`timescale 1ns/1ps
module tge_rx #(
    parameter CPU_ENABLE          = 1,
    parameter USE_DISTRIBUTED_RAM = 0
  ) (
    // Local Parameters
    input         local_enable,
    input  [47:0] local_mac,
    input  [31:0] local_ip,
    input  [15:0] local_port,
    // Application Interface
    input         app_clk,
    input         app_rst,
    output        app_rx_valid,
    output        app_rx_end_of_frame,
    output [63:0] app_rx_data,
    output [31:0] app_rx_source_ip,
    output [15:0] app_rx_source_port,
    output        app_rx_bad_frame,
    output        app_rx_overrun,
    input         app_rx_overrun_ack,
    input         app_rx_ack,
    // CPU Interface
    input         cpu_clk,
    input         cpu_rst,
    input   [7:0] cpu_rx_buffer_addr,
    output [63:0] cpu_rx_buffer_rd_data,
    output  [7:0] cpu_rx_size,
    input         cpu_rx_ack,

    // MAC Interface
    input         mac_clk,
    input         mac_rst,
    input  [63:0] mac_rx_data,
    input   [7:0] mac_rx_data_valid,
    input         mac_rx_good_frame,
    input         mac_rx_bad_frame,
    // PHY status
    input         phy_rx_up
  );

  /* Common CPU signals */
  wire [63:0] cpu_data;
  wire        cpu_dvld;
  wire        cpu_frame_valid;
  wire        cpu_frame_invalid;

  /* Common Application signals */
  wire [63:0] app_data;
  wire        app_dvld;
  wire        app_badframe;
  wire        app_goodframe;
  wire [31:0] app_source_ip;
  wire [15:0] app_source_port;

  wire local_enable_retimed;

  /*************** Primary State Machine *************/

  reg [2:0] rx_state;
  localparam RX_IDLE       = 3'd0;
  localparam RX_HDR_WORD_2 = 3'd1;
  localparam RX_HDR_WORD_3 = 3'd2;
  localparam RX_HDR_WORD_4 = 3'd3;
  localparam RX_HDR_WORD_5 = 3'd4;
  localparam RX_HDR_WORD_6 = 3'd5;
  localparam RX_DATA       = 3'd6;

  reg cpu_frame;
  reg application_frame;

  /* delayed data */

  /* Register MAC signals to ease timing */
  reg [63:0] mac_rx_data_z;
  reg        mac_rx_good_frame_z;
  reg  [7:0] mac_rx_data_valid_z;
  reg        mac_rx_bad_frame_z;

  always @(posedge mac_clk) begin
    mac_rx_data_z       <= mac_rx_data;
    mac_rx_data_valid_z <= mac_rx_data_valid;
    mac_rx_good_frame_z <= mac_rx_good_frame;
    mac_rx_bad_frame_z  <= mac_rx_bad_frame;
  end

  reg [63:0] mac_rx_dataR;
  reg        mac_rx_good_frameR;
  reg        mac_rx_bad_frameR;

  reg [47:0] rx_control_data;

  /* Eady reading assignments */
  wire [47:0] destination_mac  = {mac_rx_data_z[ 7:0 ], mac_rx_data_z[15:8 ], mac_rx_data_z[23:16],
                                  mac_rx_data_z[31:24], mac_rx_data_z[39:32], mac_rx_data_z[47:40]};
  wire [15:0] destination_port = {mac_rx_data_z[39:32], mac_rx_data_z[47:40]};
  wire [31:0] destination_ip   = {mac_rx_dataR[55:48], mac_rx_dataR[63:56], mac_rx_data_z[7:0], mac_rx_data_z[15:8]};

  always @(posedge mac_clk) begin
    /* Delay Data + frame signals */
    mac_rx_dataR       <= mac_rx_data_z;
    mac_rx_good_frameR <= mac_rx_good_frame_z;
    mac_rx_bad_frameR  <= mac_rx_bad_frame_z;

    if (mac_rst) begin
      rx_control_data <= 64'd0;
      rx_state        <= RX_IDLE;
    end else begin
      case (rx_state)
        RX_IDLE: begin
          cpu_frame         <= 1'b1;
          application_frame <= 1'b1;

          if (mac_rx_data_valid_z == {8{1'b1}} && phy_rx_up) begin
            rx_state <= RX_HDR_WORD_2;
`ifdef DESPERATE_DEBUG
            $display("tge_rx: got frame start ");
`endif
          /* Check Dest MAC */
            if (destination_mac != local_mac && destination_mac != {48{1'b1}}) begin
              /* dont send if mac mismatch */
              cpu_frame         <= 1'b0;
              application_frame <= 1'b0;
              rx_state          <= RX_DATA;
`ifdef DEBUG
              $display("tge_rx: Ethernet address mismatch - got %x, local %x", destination_mac, local_mac);
`endif
            end
          end
        end
        RX_HDR_WORD_2: begin
         /* Check IPV4 info */
          if ({mac_rx_data_z[39:32], mac_rx_data_z[47:40]} != 16'h0800 || mac_rx_data_z[55:48] != 8'h45) begin
            /* If not IPv4 frame, with no options or padding no good for application */
            application_frame <= 1'b0;
            rx_state          <= RX_DATA;
`ifdef DEBUG
            $display("tge_rx: IPv4 stuff mismatch -- %x ?= 0x0800, %x ?= 0x45", {mac_rx_data_z[39:32], mac_rx_data_z[47:40]}, mac_rx_data_z[55:48]);
`endif
          end else begin
            rx_state          <= RX_HDR_WORD_3;
          end
        end
        RX_HDR_WORD_3: begin
         /* Check UDP protocol */
          if (mac_rx_data_z[63:56] != 8'h11) begin
            application_frame <= 1'b0;
            rx_state          <= RX_DATA;
`ifdef DEBUG
            $display("tge_rx: UDP mismatch");
`endif
          end else begin
            rx_state          <= RX_HDR_WORD_4;
          end
        end
        RX_HDR_WORD_4: begin
          /* Store source IP address info */
          rx_control_data[31:24] <= mac_rx_data_z[23:16];
          rx_control_data[23:16] <= mac_rx_data_z[31:24];
          rx_control_data[15:8 ] <= mac_rx_data_z[39:32];
          rx_control_data[ 7:0 ] <= mac_rx_data_z[47:40];
          /* No IP checksum */

          rx_state               <= RX_HDR_WORD_5;
        end
        RX_HDR_WORD_5: begin
          rx_state               <= RX_HDR_WORD_6;

          /* Store source port */
          rx_control_data[47:40] <= mac_rx_data_z[23:16];
          rx_control_data[39:32] <= mac_rx_data_z[31:24];
          /* Check destiniation port */
          if (destination_port != local_port) begin
`ifdef DEBUG
            $display("tge_rx: port mismatch");
`endif
            application_frame <= 1'b0;
            rx_state          <= RX_DATA;
          end
          /* Check destiniation IP */
          if (destination_ip != local_ip) begin
`ifdef DEBUG
            $display("tge_rx: ip mismatch - got %d.%d.%d.%d, local = %d.%d.%d.%d", destination_ip[31:24], destination_ip[23:16], destination_ip[15:8],destination_ip[7:0],
                                                                                   local_ip[31:24], local_ip[23:16], local_ip[15:8],local_ip[7:0] );
`endif
            application_frame <= 1'b0;
            rx_state          <= RX_DATA;
          end
        end
        RX_HDR_WORD_6: begin
          /* No UDP checksum */
          rx_state <= RX_DATA;
        end
        RX_DATA: begin
          /* get data until good frame/bad frame signal */
          /* note almost full */
          if (mac_rx_good_frameR || mac_rx_bad_frameR) begin
            rx_state <= RX_IDLE;
`ifdef DESPERATE_DEBUG
            if (mac_rx_good_frameR)
              $display("tge_rx: got good end of frame");
`endif
`ifdef DEBUG
            if (mac_rx_bad_frameR)
              $display("tge_rx: got BAD end of frame");
`endif
          end
        end
      endcase
      if (!local_enable_retimed) begin
        application_frame <= 1'b0;
      end
    end
  end 

  /********** CPU Interface Assignments ************/


  /* Common CPU signals */

  /* we only get data that was not destined for application design */ 
  wire valid_cpu_frame = !application_frame && cpu_frame;

  assign cpu_data          = {mac_rx_dataR[ 7:0 ], mac_rx_dataR[15:8 ], mac_rx_dataR[23:16], mac_rx_dataR[31:24],
                              mac_rx_dataR[39:32], mac_rx_dataR[47:40], mac_rx_dataR[55:48], mac_rx_dataR[63:56]};
  assign cpu_dvld          = rx_state != RX_IDLE;
  assign cpu_frame_invalid = mac_rx_bad_frameR || mac_rx_good_frameR && !valid_cpu_frame;
  assign cpu_frame_valid   = mac_rx_good_frameR && valid_cpu_frame;

  /* Common Application signals */
  assign app_data        = {mac_rx_dataR[23:16], mac_rx_dataR[31:24], mac_rx_dataR[39:32], mac_rx_dataR[47:40],
                            mac_rx_dataR[55:48], mac_rx_dataR[63:56],  mac_rx_data_z[ 7:0 ],  mac_rx_data_z[15:8 ]};
  assign app_dvld        = application_frame && rx_state == RX_DATA && (!(mac_rx_good_frameR || mac_rx_bad_frameR));
  assign app_goodframe   = application_frame && mac_rx_good_frame_z;
  assign app_badframe    = application_frame && mac_rx_bad_frame_z;
  assign app_source_ip   = rx_control_data[31:0];
  assign app_source_port = rx_control_data[47:32];
  /* TODO: need neater way to align eof/dvld for cpu+app */

  /********** CPU Interface Logic *************/

  /* rx data fifo - 64x1024 */

  wire        cpu_buffer_sel;
  wire        cpu_buffer_we;
  wire [63:0] cpu_buffer_data;
  wire  [7:0] cpu_buffer_addr;

generate if (CPU_ENABLE) begin : rx_cpu_enabled

  cpu_buffer cpu_rx_buffer(   
    .clka      (cpu_clk),
    .dina      (64'h0),
    .addra     ({cpu_buffer_sel, cpu_rx_buffer_addr}),
    .wea       (1'b0), //no writing from cpu side
    .douta     (cpu_rx_buffer_rd_data),

    .clkb      (mac_clk),
    .dinb      (cpu_buffer_data),
    .addrb     ({!cpu_buffer_sel, cpu_buffer_addr}),
    .web       (cpu_buffer_we),
    .doutb     () //no reading on mac side
  );
  //synthesis attribute box_type cpu_rx_buffer "user_black_box"

end endgenerate

  /* buffer control state machine */

  reg cpu_state;
  localparam CPU_BUFFERING = 1'd0;
  localparam CPU_WAIT      = 1'd1;

  reg cpu_buffer_sel_reg;
  assign cpu_buffer_sel = cpu_buffer_sel_reg;
  /* TODO: ^^^^^^^ this might be dodge (addr msb on wrong clock domain)... */

  reg [7:0] cpu_addr;
  reg frame_bypass;

  wire cpu_buffer_free;

  assign cpu_buffer_data = cpu_data;
  assign cpu_buffer_addr = cpu_addr;
  assign cpu_buffer_we   = cpu_dvld;

  always @(posedge mac_clk) begin
    if (mac_rst) begin
      cpu_addr           <= 8'd0;
      cpu_buffer_sel_reg <= 1'b0;
      frame_bypass       <= 1'b0;
      cpu_state          <= CPU_BUFFERING;
    end else begin
      case (cpu_state)
        /* Buffer data from tge interface */
        CPU_BUFFERING: begin
          if (cpu_dvld) begin
            if (cpu_addr == {8{1'b1}}) begin
              frame_bypass <= 1'b1;
            end else begin
              cpu_addr <= cpu_addr + 8'd1;
            end
          end
          if (cpu_frame_invalid || cpu_frame_valid && frame_bypass) begin
            cpu_addr  <= 8'd0;
            cpu_state <= CPU_BUFFERING;
           // $display("tge_rx_cpu: got unsuitable frame, rolling back...");
          end
          if (cpu_frame_valid) begin
            cpu_state <= CPU_WAIT;
            $display("tge_rx_cpu: got good frame, waiting for buffer to become available");
          end
        end
        /* Wait for CPU buffer free up */
        CPU_WAIT: begin
          if (cpu_buffer_free) begin
            cpu_buffer_sel_reg <= ~cpu_buffer_sel_reg;
            cpu_addr  <= 8'd0;
            cpu_state <= CPU_BUFFERING;
            $display("tge_rx_cpu: buffer free, swapping now");
          end
          if (cpu_dvld) begin
            /* If we got data frome a new frame tag the frame to be bypassed*/
            frame_bypass <= 1'b1;
          end
        end
      endcase
      if (cpu_frame_invalid || cpu_frame_valid) begin
        frame_bypass <= 1'b0;
      end
    end
  end

  /* CPU Handshaking */

  reg [7:0] cpu_size;
  (* shreg_extract = "NO" *) reg cpu_ackR;
  (* shreg_extract = "NO" *) reg cpu_ackRR;
  assign cpu_buffer_free = cpu_size == 8'd0 && !cpu_ackRR;

  always @(posedge mac_clk) begin
    cpu_ackR  <= cpu_rx_ack;
    cpu_ackRR <= cpu_ackR;

    if (mac_rst) begin
      cpu_size <= 8'd0;
    end else begin
      if (cpu_ackRR) begin
        cpu_size <= 8'd0;
      end
      if (cpu_state == CPU_WAIT && cpu_buffer_free) begin
        cpu_size <= cpu_addr;
      end
    end
  end

  /* FIXME: this is pretty dumb (registering on size), should add handshake signal */
  (* shreg_extract = "NO" *) reg [7:0] cpu_sizeR;
  (* shreg_extract = "NO" *) reg [7:0] cpu_sizeRR;
  assign cpu_rx_size = cpu_sizeRR;

  always @(posedge cpu_clk) begin
    cpu_sizeR  <= cpu_size;
    cpu_sizeRR <= cpu_sizeR;
  end

  /********** Application buffer Logic *************/

  wire [66:0] packet_fifo_wr_data;
  wire        packet_fifo_wr_en;
  wire        packet_fifo_almost_full;
  wire [66:0] packet_fifo_rd_data;
  wire        packet_fifo_rd_en;
  wire        packet_fifo_empty;


generate if (USE_DISTRIBUTED_RAM == 0) begin : use_bram

  rx_packet_fifo_bram rx_packet_fifo_bram_inst (
    .rd_clk    (app_clk),
    .rd_en     (packet_fifo_rd_en),
    .dout      (packet_fifo_rd_data),
    .wr_clk    (mac_clk),
    .wr_en     (packet_fifo_wr_en),
    .din       (packet_fifo_wr_data),
    .empty     (packet_fifo_empty),
    .full      (),
    .rst       (app_rst),
    .prog_full (packet_fifo_almost_full)
  );
  //synthesis attribute box_type rx_packet_fifo_bram_inst "user_black_box"

end else begin : usr_dram

  rx_packet_fifo_dist rx_packet_fifo_dist_inst (
    .rd_clk    (app_clk),
    .rd_en     (packet_fifo_rd_en),
    .dout      (packet_fifo_rd_data),
    .wr_clk    (mac_clk),
    .wr_en     (packet_fifo_wr_en),
    .din       (packet_fifo_wr_data),
    .empty     (packet_fifo_empty),
    .full      (),
    .rst       (app_rst),
    .prog_full (packet_fifo_almost_full)
  );
  //synthesis attribute box_type rx_packet_fifo_dist_inst "user_black_box"

end endgenerate


  wire [47:0] ctrl_fifo_wr_data;
  wire        ctrl_fifo_wr_en;
  wire        ctrl_fifo_almost_full;
  wire [47:0] ctrl_fifo_rd_data;
  wire        ctrl_fifo_rd_en;

  rx_packet_ctrl_fifo rx_packet_ctrl_fifo_inst (
    .rd_clk    (app_clk),
    .rd_en     (ctrl_fifo_rd_en),
    .dout      (ctrl_fifo_rd_data),
    .wr_clk    (mac_clk),
    .wr_en     (ctrl_fifo_wr_en),
    .din       (ctrl_fifo_wr_data),
    .empty     (),
    .full      (),
    .rst       (app_rst),
    .prog_full (ctrl_fifo_almost_full)
  );
  //synthesis attribute box_type rx_packet_ctrl_fifo_inst "user_black_box"

  assign app_rx_valid        = !packet_fifo_empty;
  assign app_rx_end_of_frame = packet_fifo_rd_data[64];
  assign app_rx_bad_frame    = packet_fifo_rd_data[65];
  assign app_rx_overrun      = packet_fifo_rd_data[66];
  assign app_rx_data         = packet_fifo_rd_data[63:0];
  assign app_rx_source_ip    = ctrl_fifo_rd_data[31:0];
  assign app_rx_source_port  = ctrl_fifo_rd_data[47:32];

  assign packet_fifo_rd_en = app_rx_ack;
  assign ctrl_fifo_rd_en   = app_rx_ack && app_rx_end_of_frame && app_rx_valid;
  //assign ctrl_fifo_rd_en   = app_rx_ack && app_rx_end_of_frame; /* this is better */
  /* ^ In theory could add fifo_empty status to these controls */

  reg [1:0] app_state;
  localparam APP_RUN   = 2'd0;
  localparam APP_OVER  = 2'd2;
  localparam APP_WAIT  = 2'd3;

  reg first_word;

  wire rx_eof  = app_goodframe || app_badframe || (app_dvld && (packet_fifo_almost_full || ctrl_fifo_almost_full));
  wire rx_bad  = app_badframe;
  wire rx_over = packet_fifo_almost_full || ctrl_fifo_almost_full;
  assign packet_fifo_wr_data = {rx_over, rx_bad, rx_eof, app_data};
  assign packet_fifo_wr_en   = app_dvld && (app_state == APP_RUN);
  assign ctrl_fifo_wr_data   = {app_source_port, app_source_ip};
  assign ctrl_fifo_wr_en     = app_dvld && first_word && app_state == APP_RUN;

  wire overrun_ack;   
  (* shreg_extract = "NO" *) reg overrun_ackR;   
  (* shreg_extract = "NO" *) reg overrun_ackRR;   

  always @(posedge mac_clk) begin
    overrun_ackR  <= overrun_ack;
    overrun_ackRR <= overrun_ackR;

    if (mac_rst) begin
      app_state  <= APP_RUN;
      first_word <= 1'b1;
    end else begin
      case (app_state)
        APP_RUN: begin
          if (app_dvld)
            first_word <= 1'b0;

          if (rx_eof) begin
            first_word <= 1'b1;
          end
          if (app_dvld && (packet_fifo_almost_full || ctrl_fifo_almost_full)) begin
            app_state <= APP_OVER;
          end
        end
        APP_OVER: begin
          if (overrun_ackRR) begin
            app_state <= APP_WAIT;
          end
        end
        APP_WAIT: begin
          if (!overrun_ackRR) begin
            app_state <= APP_RUN;
          end
        end
      endcase
    end
  end

  (* shreg_extract = "NO" *) reg overrunR;
  (* shreg_extract = "NO" *) reg overrunRR;

  reg app_overrun_ack;
  assign overrun_ack = app_overrun_ack;

  always @(posedge app_clk) begin
    overrunR  <= app_state == APP_OVER;
    overrunRR <= overrunR;

    if (app_rst) begin
      app_overrun_ack <= 1'b1;
    end else begin
      if (!overrunRR) begin
        app_overrun_ack <= 1'b0;
      end
      if (app_rx_overrun_ack) begin
        app_overrun_ack <= 1'b1;
      end
    end
  end

  (* shreg_extract = "NO" *) reg local_enableR;
  (* shreg_extract = "NO" *) reg local_enableRR;

  always @(posedge mac_clk) begin
    local_enableR  <= local_enable;
    local_enableRR <= local_enableR;
  end
  assign local_enable_retimed = local_enableRR;

endmodule
