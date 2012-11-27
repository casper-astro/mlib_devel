`timescale 1ns/1ps

`define SIMLENGTH  100000
`define MGT_PERIOD 8
`define USR_PERIOD 5
`define OPB_PERIOD 12

module TB_kat_ten_gb_eth_bugcheck();
  /* Simulation constants */

  /* the size of the TX frame in 64-bit words */
  localparam TX_FRAME_SIZE  = 32'd12;

  localparam FABRIC_MAC     = 48'h0202_0a00_0080;
  localparam FABRIC_IP      = {8'd10, 8'd0, 8'd0, 8'd128};
  localparam FABRIC_PORT    = 16'd8888;
  localparam FABRIC_GATEWAY = 8'd1;
  localparam FABRIC_ENABLE  = 1;

  localparam CPU_PACKET_SIZE = 8'd8;
  localparam CPU_SRC_MAC     = 48'h1111_2222_3333;
  localparam CPU_DEST_MAC    = FABRIC_MAC;

  
  /* global clocks + resets */
  wire mgt_rst;
  wire usr_rst;
  wire opb_rst;

  wire mgt_clk;
  wire usr_clk;
  wire opb_clk;

  /******************* DUT *************************/
  wire        app_clk;
  wire        app_rst;

  wire        app_tx_valid;
  wire        app_tx_end_of_frame;
  wire [63:0] app_tx_data;
  wire [31:0] app_tx_dest_ip;
  wire [15:0] app_tx_dest_port;
  wire        app_tx_overflow; 
  wire        app_tx_afull; 

  wire        app_rx_valid;
  wire        app_rx_end_of_frame;
  wire [63:0] app_rx_data;
  wire [31:0] app_rx_source_ip;
  wire [15:0] app_rx_source_port;
  wire        app_rx_bad_frame;
  wire        app_rx_overrun; 
  wire        app_rx_overrun_ack; 
  wire        app_rx_ack;

  wire        led_up;
  wire        led_rx;
  wire        led_tx;

  wire        xaui_clk;
  wire        xaui_reset;
  wire  [7:0] xaui_status;
  wire [63:0] xgmii_txd;
  wire  [7:0] xgmii_txc;
  wire [63:0] xgmii_rxd;
  wire  [7:0] xgmii_rxc;

  wire  [1:0] mgt_rxeqmix;
  wire  [3:0] mgt_rxeqpole;
  wire  [2:0] mgt_txpreemphasis;
  wire  [2:0] mgt_txdiffctrl;

  wire        OPB_Clk;
  wire        OPB_Rst;
  wire        OPB_RNW;
  wire        OPB_select;
  wire        OPB_seqAddr;
  wire  [3:0] OPB_BE;
  wire [31:0] OPB_ABus;
  wire [31:0] OPB_DBus;
  wire [31:0] Sl_DBus;
  wire        Sl_errAck;
  wire        Sl_retry;
  wire        Sl_toutSup;
  wire        Sl_xferAck;

  kat_ten_gb_eth #(
    .SWING          (1),
    .PREEMPHASYS    (1),
    .FABRIC_MAC     (FABRIC_MAC    ),
    .FABRIC_IP      (FABRIC_IP     ),
    .FABRIC_PORT    (FABRIC_PORT   ),
    .FABRIC_GATEWAY (FABRIC_GATEWAY),
    .FABRIC_ENABLE  (FABRIC_ENABLE ),
    .C_BASEADDR     (32'h0),
    .C_HIGHADDR     (32'hffff),
    .RX_DIST_RAM    (1),
    .LARGE_PACKETS  (1)
  ) kat_ten_gb_eth_inst (
    .clk(app_clk),
    .rst(app_rst),
    .tx_valid(app_tx_valid),
    .tx_end_of_frame(app_tx_end_of_frame),
    .tx_data(app_tx_data),
    .tx_dest_ip(app_tx_dest_ip),
    .tx_dest_port(app_tx_dest_port),
    .tx_overflow(app_tx_overflow), 
    .tx_afull(app_tx_afull), 
    .rx_valid(app_rx_valid),
    .rx_end_of_frame(app_rx_end_of_frame),
    .rx_data(app_rx_data),
    .rx_source_ip(app_rx_source_ip),
    .rx_source_port(app_rx_source_port),
    .rx_bad_frame(app_rx_bad_frame),
    .rx_overrun(app_rx_overrun), 
    .rx_overrun_ack(app_rx_overrun_ack), 
    .rx_ack(app_rx_ack),
    .led_up(led_up),
    .led_rx(led_rx),
    .led_tx(led_tx),
    .xaui_clk(xaui_clk),
    .xaui_reset(xaui_reset),
    .xaui_status(xaui_status),
    .xgmii_txd(xgmii_txd),
    .xgmii_txc(xgmii_txc),
    .xgmii_rxd(xgmii_rxd),
    .xgmii_rxc(xgmii_rxc),
    .OPB_Clk(OPB_Clk),
    .OPB_Rst(OPB_Rst),
    .OPB_RNW(OPB_RNW),
    .OPB_select(OPB_select),
    .OPB_seqAddr(OPB_seqAddr),
    .OPB_BE(OPB_BE),
    .OPB_ABus(OPB_ABus),
    .OPB_DBus(OPB_DBus),
    .Sl_DBus(Sl_DBus),
    .Sl_errAck(Sl_errAck),
    .Sl_retry(Sl_retry),
    .Sl_toutSup(Sl_toutSup),
    .Sl_xferAck(Sl_xferAck),
    .mgt_rxeqmix(mgt_rxeqmix),
    .mgt_rxeqpole(mgt_rxeqpole),
    .mgt_txpreemphasis(mgt_txpreemphasis),
    .mgt_txdiffctrl(mgt_txdiffctrl)
  );


  /***************** Clock/Reset Gen *****************/
  reg [31:0] mgt_clk_counter;
  reg [31:0] usr_clk_counter;
  reg [31:0] opb_clk_counter;
  reg reset;

  initial begin
    reset <= 1'b1;
    mgt_clk_counter <= 32'b0;
    usr_clk_counter <= 32'b0;
    opb_clk_counter <= 32'b0;
    $dumpvars();
    #50
    reset <= 1'b0;
`ifdef DEBUG
    $display("sys: reset cleared");
`endif
    #`SIMLENGTH
    $display("FAILED: simulation timed out");
  end

  assign mgt_clk = mgt_clk_counter < ((`MGT_PERIOD) / 2);
  always begin
    #1 mgt_clk_counter <= (mgt_clk_counter == `MGT_PERIOD - 1 ? 32'b0 : mgt_clk_counter + 1);
  end

  assign usr_clk = usr_clk_counter < ((`USR_PERIOD) / 2);
  always begin
    #1 usr_clk_counter <= (usr_clk_counter == `USR_PERIOD - 1 ? 32'b0 : usr_clk_counter + 1);
  end

  assign opb_clk = opb_clk_counter < ((`OPB_PERIOD) / 2);
  always begin
    #1 opb_clk_counter <= (opb_clk_counter == `OPB_PERIOD - 1 ? 32'b0 : opb_clk_counter + 1);
  end

  reg mgt_rst_reg;
  always @(posedge mgt_clk) begin
    mgt_rst_reg <= reset;
  end
  assign mgt_rst = mgt_rst_reg;

  reg usr_rst_reg;
  always @(posedge usr_clk) begin
    usr_rst_reg <= reset;
  end
  assign usr_rst = usr_rst_reg;

  reg opb_rst_reg;
  always @(posedge opb_clk) begin
    opb_rst_reg <= reset;
  end
  assign opb_rst = opb_rst_reg;

  /********************* Mode Control ***********************/
  reg [31:0] mode;
  localparam MODE_CPU_WRITE   = 0;
  localparam MODE_CPU_READ    = 1;
  localparam MODE_XGMII_BREAK = 2;
  localparam MODE_PROCESS     = 4;

  localparam MODE_COUNT = 4;
  reg [MODE_COUNT - 1:0] mode_done;

  reg [31:0] mode_progress;

  reg [31:0] mode_mem [1023:0];

  integer i;

  always @(posedge opb_clk) begin
    if (opb_rst) begin
      mode          <= MODE_CPU_WRITE;
      mode_progress <= 32'd0;
    end else begin
      case (mode)
        MODE_CPU_WRITE: begin
          if (mode_done[MODE_CPU_WRITE]) begin
            mode          <= MODE_CPU_READ;
`ifdef DEBUG
            $display("mode: MODE_CPU_WRITE completed");
`endif
          end
        end
        MODE_CPU_READ: begin
          if (mode_done[MODE_CPU_READ]) begin
            mode          <= MODE_PROCESS;
            for (i=0; i < CPU_PACKET_SIZE*2; i=i+1) begin
              if (i == 0) begin
                if (mode_mem[i] !== {FABRIC_MAC[47:16]}) begin
                  $display("ERROR: cpu header mismatch 0, got %x", mode_mem[i]);
                end
              end else if (i == 1) begin
                if (mode_mem[i] !== {FABRIC_MAC[15:0], 16'b0}) begin
                  $display("ERROR: cpu header mismatch 1, got %x", mode_mem[i]);
                end
              end else begin
                if (mode_mem[i] !== i) begin
                  $display("ERROR: cpu data mismatch - got = %x,  expected = %x", mode_mem[i], i);
                end
              end
              mode_mem[i] <= 32'd0; //clear after reading
            end
`ifdef DEBUG
            $display("mode: MODE_CPU_READ completed");
`endif
          end
        end
        MODE_PROCESS: begin
          if (mode_progress < 3) begin
            mode_progress <= mode_progress + 1;
            mode          <= MODE_CPU_WRITE;
          end else begin
            mode_progress <= 3;
            mode          <= MODE_XGMII_BREAK;
`ifdef DEBUG
            $display("mode: MODE_PROCESS completed");
`endif
          end
        end
        MODE_XGMII_BREAK: begin
          if (mode_done[MODE_XGMII_BREAK]) begin
`ifdef DEBUG
            $display("mode: MODE_XGMII_BREAK completed");
`endif
            $display("PASSED");
          end
        end
        /************ ************/
        /************ ************/
      endcase
    end
  end

  /********************* XAUI interface ************************/

  assign xaui_clk    = mgt_clk;
  assign xaui_reset  = mgt_rst;
  assign xaui_status = {6'b111111, 2'b00}; 


  always @(posedge xaui_clk) begin
   // $display("xgmii: d = %x, c = %b", xgmii_txd, xgmii_txc);
  end

  /********** Add a half cycle delay ***********/

  reg xgmii_add_delay;

  reg [63:0] xgmii_txd_z;
  reg  [7:0] xgmii_txc_z; 
  always @(posedge xaui_clk) begin
    xgmii_txd_z <= xgmii_txd;
    xgmii_txc_z <= xgmii_txc;

    if (mgt_rst) begin
      xgmii_add_delay <= 1'b0;
    end else begin
      /* after mode progress is non-zero add a half cycle delay when */
      if (mode_progress >= 2) begin
        if (xgmii_txc == 8'b1111_1111 && xgmii_txd == {8{8'h07}}) begin
          xgmii_add_delay <= 1'b1;
        end
      end
    end
  end

  wire [63:0] xgmii_rxd_int = xgmii_add_delay ? {xgmii_txd[31:0], xgmii_txd_z[63:32]}: xgmii_txd;
  wire  [7:0] xgmii_rxc_int = xgmii_add_delay ? {xgmii_txc[ 3:0], xgmii_txc_z[ 7:4 ]}: xgmii_txc;

  /********** Make sure we test for minimum if-gap ***********/

  reg [63:0] xgmii_rxd_int_z;
  reg  [7:0] xgmii_rxc_int_z;
  reg [63:0] xgmii_rxd_int_zz;
  reg  [7:0] xgmii_rxc_int_zz;

  reg buffered_idle;
  reg got_start;

  wire perform_idle_drop = xgmii_rxd_int_zz == 64'h07070707_070707FD && xgmii_rxc_int_zz == 8'hff &&
                           xgmii_rxd_int_z  == 64'h07070707_07070707 && xgmii_rxc_int_z  == 8'hff &&
                           xgmii_rxd_int    == 64'h555555FB_07070707 && xgmii_rxc_int    == 8'h1f;
  always @(posedge xaui_clk) begin
    xgmii_rxd_int_z  <= xgmii_rxd_int;
    xgmii_rxc_int_z  <= xgmii_rxc_int;
    xgmii_rxd_int_zz <= xgmii_rxd_int_z;
    xgmii_rxc_int_zz <= xgmii_rxc_int_z;

    if (mgt_rst) begin
      buffered_idle <= 0;
      got_start <= 0;
    end else begin
      if (!buffered_idle) begin
        /* if there is an idle we are free to add another one in */
        if (xgmii_rxc_int == 8'b1111_1111 && xgmii_rxd_int == {8{8'h07}}) begin
          buffered_idle <= 1'b1;
`ifdef DEBUG
          $display("app_rx: adding an extra idle");
`endif
        end
      end else begin
        if (xgmii_rxc_int[0] &&  xgmii_rxd_int[7:0]   == 8'hFB ||
            xgmii_rxc_int[4] &&  xgmii_rxd_int[39:32] == 8'hFB) begin
          got_start <= 1'b1;
        end
        if (got_start) begin
          if (perform_idle_drop) begin
             got_start     <= 0;
             buffered_idle <= 0;
`ifdef DEBUG
             $display("app_rx: dropping an idle to make interframe gap minumum");
`endif
          end
        end
      end
    end
  end

  wire [63:0] xgmii_rxd_if = !buffered_idle || got_start && perform_idle_drop ? xgmii_rxd_int : xgmii_rxd_int_z;
  wire  [7:0] xgmii_rxc_if = !buffered_idle || got_start && perform_idle_drop ? xgmii_rxc_int : xgmii_rxc_int_z;

  /********** Break XGMII ***********/

  /* NOTE: this scheme is flakey but should work provided the data packet size is not tiny */

  reg [5:0] break_xgmii_shifter;
  wire break_xgmii = break_xgmii_shifter[5];
  // need to delay the break action until the payload, otherwise the error will not propogate to the fabric I/F

  reg [1:0] break_state;
  localparam BREAK_WAIT_IDLE       = 2'd0;
  localparam BREAK_WAIT_FIRST_DATA = 2'd1;
  localparam BREAK_DONE            = 2'd2;

  always @(posedge xaui_clk) begin
    break_xgmii_shifter <= {break_xgmii_shifter[4:0], 1'b0};

    if (mgt_rst) begin
      break_state <= BREAK_WAIT_IDLE;
    end else begin
      case (break_state)
        BREAK_WAIT_IDLE: begin
          if (mode == MODE_XGMII_BREAK && xgmii_rxc_if == {8{1'b1}}) begin
            break_state <= BREAK_WAIT_FIRST_DATA;
          end
        end
        BREAK_WAIT_FIRST_DATA: begin
          if (xgmii_rxc_if == {8{1'b0}}) begin
            break_state <= BREAK_DONE;
            break_xgmii_shifter <= {break_xgmii_shifter[4:0], 1'b1};
          end
        end
        BREAK_DONE: begin
        end
      endcase
    end
  end

  /* negate data when break packet = 1 */
  reg [31:0] index;

  reg [63:0] rxd;
  reg  [7:0] rxc;


  always @(posedge xaui_clk) begin
    if (mgt_rst) begin
      index <= 0;
      rxc <= 8'b1111_1111;
      rxd <= {8{8'h07}};
    end else begin
      index <= index + 1;
      case (index)
        10: begin
          rxc <= 8'b0000_0001;
          rxd <= {{7{8'h55}}, 8'hfb};
        end
        11: begin
          rxc <= 8'b0000_0000;
        end
        20: begin
          rxc <= 8'b1111_1111;
          rxd <= {{7{8'h07}}, 8'hfd};
        end
        21: begin
          rxc <= 8'b0001_1111;
          rxd <= {{3{8'h55}}, 8'hfb, {4{8'h07}}};
        end
        22: begin
          rxc <= 8'b0000_0000;
          rxd <= {8{8'h55}};
        end
        30: begin
          rxc <= 8'b1111_1111;
          rxd <= {{7{8'h07}}, 8'hfd};
        end
        31: begin
          rxc <= 8'b1111_1111;
          rxd <= {8{8'h07}};
        end
        50: begin
          $finish;
        end
      endcase
    end
  end

  assign xgmii_rxd = rxd;
  assign xgmii_rxc = rxc;

  /************** Application CLK/RST assignments ***********/

  assign app_clk = usr_clk;
  assign app_rst = usr_rst;

  /************** Simulated TGE TX Application    ***********/
 
  reg app_tx_state;
  localparam APP_TX_STATE_RUN  = 1'd0;
  localparam APP_TX_STATE_WAIT = 1'd1;
 
  always @(posedge usr_clk) begin
    if (usr_rst) begin
      app_tx_state <= APP_TX_STATE_RUN;
    end else begin
      case (app_tx_state)
        APP_TX_STATE_RUN: begin
          if (app_tx_afull) begin
            app_tx_state <= APP_TX_STATE_WAIT;
          end
        end
        APP_TX_STATE_WAIT: begin
          if (!app_tx_afull) begin
            app_tx_state <= APP_TX_STATE_RUN;
          end
        end
      endcase
    end
  end
 
  reg [63:0] tx_test_data;
 
  always @(posedge usr_clk) begin
    if (usr_rst) begin
      tx_test_data <= 64'd0;
    end else begin
      if (app_tx_state == APP_TX_STATE_RUN) begin
        tx_test_data <= tx_test_data + 1;
      end
    end
  end
 
  always @(posedge usr_clk) begin
    if (usr_rst) begin
    end else begin
      if (app_tx_overflow) begin
        $display("ERROR: tx fabric buffer overflowed");
      end
    end
  end
 
  assign app_tx_data         = tx_test_data | {app_tx_end_of_frame, 63'b0};
  assign app_tx_valid        = !usr_rst && app_tx_state == APP_TX_STATE_RUN;
  wire [31:0] foo = tx_test_data; //iveirlog bug hack
  assign app_tx_end_of_frame = (foo % (TX_FRAME_SIZE)) == (TX_FRAME_SIZE - 1); 

  /* Send loopback */
  assign app_tx_dest_ip      = FABRIC_IP;
  assign app_tx_dest_port    = FABRIC_PORT;


  /**************** Application RX ************************/

  reg [1:0] rx_app_state;
  localparam RX_APP_WAIT = 2'd0;
  localparam RX_APP_OVER = 2'd1;
  localparam RX_APP_RUN  = 2'd2;

  reg [31:0] rx_app_progress;

  reg [63:0] app_rx_data_reg;

  reg [7:0] block_counter;
  wire app_rx_block = block_counter < 10;

  always @(posedge app_clk) begin
    if (app_rst) begin
      rx_app_state    <= RX_APP_WAIT;
      rx_app_progress <= 32'd0;
      mode_done[MODE_XGMII_BREAK] <= 1'b0;
      block_counter <= 0;
    end else begin
      case (rx_app_state)
        /* wait 256 cycles -- long enough for the rx buffer to overflow (only with distributed memory) */
        RX_APP_WAIT: begin
          if (app_rx_valid)
            rx_app_progress <= rx_app_progress + 1;

          if (rx_app_progress == 256) begin
            rx_app_state    <= RX_APP_OVER;
            rx_app_progress <= 32'b0;
          end
        end
        RX_APP_OVER: begin
          if (app_rx_overrun) begin
            rx_app_state    <= RX_APP_RUN;
            rx_app_progress <= 32'b0;
            $display("app_rx: got overflow");
          end
        end
        RX_APP_RUN: begin
          if (app_rx_valid)
            block_counter <= block_counter + 1;

          if (app_rx_valid && !app_rx_block) begin
            app_rx_data_reg <= app_rx_data & {1'b0, {63{1'b1}}};
            if (mode == MODE_XGMII_BREAK) begin
              if (app_rx_end_of_frame && app_rx_bad_frame) begin
                mode_done[MODE_XGMII_BREAK] <= 1'b1;
                $display("app_rx: got bad frame, but expected it!");
              end
            end else begin
              rx_app_progress <= rx_app_progress + 1;
              if (rx_app_progress != 32'd0) begin
                if (app_rx_data != ((app_rx_data_reg + 1) | {app_rx_end_of_frame, 63'b0})) begin
                  $display("FAILED: application data mismatch - got = %x, expected = %x", app_rx_data, (app_rx_data_reg + 1 | {app_rx_end_of_frame, 63'b0}));
                end
              end
              if (app_rx_end_of_frame && app_rx_bad_frame) begin
                $display("FAILED: unexpected bad frame");
              end
              if (app_rx_end_of_frame && app_rx_overrun) begin
                $display("FAILED: unexpected overflow");
              end
              if (app_rx_end_of_frame) begin
`ifdef DEBUG
                $display("app_rx: got fabric frame");
`endif
              end
            end
          end
        end
      endcase
    end
  end

  assign app_rx_overrun_ack = rx_app_state == RX_APP_OVER && app_rx_overrun;
  assign app_rx_ack         = !(rx_app_state == RX_APP_WAIT || (rx_app_state == RX_APP_RUN && app_rx_block));



  /********************* OPB interface ************************/

  assign OPB_Clk = opb_clk;
  assign OPB_Rst = opb_rst;

  reg OPB_RNW_reg;
  reg OPB_select_reg;
  reg OPB_seqAddr_reg;
  reg  [3:0] OPB_BE_reg;
  reg [31:0] OPB_ABus_reg;
  reg [31:0] OPB_DBus_reg;

  assign OPB_RNW     = OPB_RNW_reg;
  assign OPB_select  = OPB_select_reg;
  assign OPB_seqAddr = OPB_seqAddr_reg;
  assign OPB_BE      = OPB_BE_reg;
  assign OPB_ABus    = OPB_ABus_reg;
  assign OPB_DBus    = OPB_DBus_reg;

  reg [31:0] opb_progress;
  reg        opb_state;
  localparam OPB_COMMAND  = 1'd0;
  localparam OPB_RESPONSE = 1'd1;

  /* Read Mode Registers */
  reg [7:0] cpu_rx_size;

  always @(posedge opb_clk) begin
    mode_done[MODE_CPU_WRITE] <= 1'b0;
    mode_done[MODE_CPU_READ]  <= 1'b0;

    if (opb_rst || mode_done[MODE_CPU_WRITE] || mode_done[MODE_CPU_READ]) begin
      opb_progress <= 32'd0;
      opb_state    <= OPB_COMMAND;
      cpu_rx_size  <= 8'd0;
    end else begin
      case (mode)
/********************************* Write MODE ***************************************/
        MODE_CPU_WRITE: begin
          case (opb_state) 
            OPB_COMMAND: begin
              opb_state      <= OPB_RESPONSE;
              OPB_select_reg <= 1'b1;
              if (opb_progress[31:1] == CPU_PACKET_SIZE) begin
                OPB_RNW_reg  <= 1'b0;
                OPB_BE_reg   <= 4'b0100;
                OPB_ABus_reg <= {32'h6, 2'b0};
                OPB_DBus_reg <= {CPU_PACKET_SIZE, 16'b0};
              end else begin
                OPB_RNW_reg  <= 1'b0;
                OPB_BE_reg   <= 4'b1111;
                OPB_ABus_reg <= 32'h1000 + opb_progress*4;
                /* We need to tx the destination address, but nothing else*/
                case (opb_progress)
                  0: OPB_DBus_reg <= {CPU_DEST_MAC[47:16]};
                  1: OPB_DBus_reg <= {CPU_DEST_MAC[15:0], 16'd0};
                  default: OPB_DBus_reg <= opb_progress[31:0];
                endcase
              end
            end 
            OPB_RESPONSE: begin
              if (Sl_xferAck) begin
                if (opb_progress[31:1] == CPU_PACKET_SIZE) begin
                  mode_done[MODE_CPU_WRITE] <= 1'b1; //reset this SM
                end else begin
                  opb_progress <= opb_progress + 1;
                  opb_state    <= OPB_COMMAND;
                end
                OPB_select_reg <= 1'b0;
              end
            end
          endcase
        end
/********************************* Read MODE ***************************************/
        MODE_CPU_READ: begin
          case (opb_state) 
            OPB_COMMAND: begin
              opb_state      <= OPB_RESPONSE;
              OPB_select_reg <= 1'b1;
              if (cpu_rx_size == 8'd0) begin
                OPB_RNW_reg  <= 1'b1;
                OPB_BE_reg   <= 4'b1111;
                OPB_ABus_reg <= {32'h6, 2'b0};
                OPB_DBus_reg <= {24'b0, 8'b0}; //ack the buffer
              end else if (opb_progress[31:0] == CPU_PACKET_SIZE*2) begin
                OPB_RNW_reg  <= 1'b0;
                OPB_BE_reg   <= 4'b0001;
                OPB_ABus_reg <= {32'h6, 2'b0};
              end else begin
                OPB_RNW_reg  <= 1'b1;
                OPB_BE_reg   <= 4'b1111;
                OPB_ABus_reg <= 32'h2000 + opb_progress*4;
              end
            end 
            OPB_RESPONSE: begin
              if (Sl_xferAck) begin
                OPB_select_reg <= 1'b0;
                if (cpu_rx_size == 8'd0) begin
                  cpu_rx_size <= Sl_DBus[15:0]; 
                  opb_state   <= OPB_COMMAND;
`ifdef DEBUG
                  if (Sl_DBus[15:0])
                    $display("opb_rx: rx frame present rx_size = %x", Sl_DBus[15:0]);
`endif
                end else if (opb_progress[31:0] < CPU_PACKET_SIZE*2) begin
                  opb_state    <= OPB_COMMAND;
                  opb_progress <= opb_progress + 1;
                  mode_mem[opb_progress] <= Sl_DBus;
`ifdef DESPERATE_DEBUG
                  $display("opb: got data = %x, p = %x", Sl_DBus, opb_progress);
`endif
                end else begin
                  mode_done[MODE_CPU_READ] <= 1'b1; //reset this SM
`ifdef DEBUG
                  $display("opb_rx: acked buffer");
`endif
                end
              end
            end
          endcase
        end
      endcase
    end
  end

  /*
  wire [31:0] Sl_DBus;
  wire        Sl_errAck;
  wire        Sl_retry;
  wire        Sl_toutSup;
  wire        Sl_xferAck;
  */


endmodule
