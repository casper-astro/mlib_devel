`timescale 1ns/10ps

`define CLK_PERIOD 10
`define SIM_LENGTH 10000

module TB_ten_gig_eth();
  wire sys_clk, sys_reset;

  wire [63:0] mac_tx_data;
  wire  [7:0] mac_tx_data_valid;
  wire mac_tx_start;
  wire mac_tx_ack;

  wire [63:0] xgmii_txd;
  wire  [7:0] xgmii_txc;
  wire [63:0] xgmii_rxd;
  wire  [7:0] xgmii_rxc;

`ifndef __ICARUS__
  ten_gig_eth_mac_UCB ten_gig_eth_mac_UCB_inst(
		.reset                (sys_reset),

		.tx_clk0              (sys_clk),
		.rx_clk0              (sys_clk),
		.tx_dcm_lock          (1'b1),
		.rx_dcm_lock          (1'b1),

		.tx_data              (mac_tx_data),
		.tx_data_valid        (mac_tx_data_valid),
		.tx_start             (mac_tx_start),
		.tx_ack               (mac_tx_ack),
		.tx_underrun          (1'b0),
		.tx_ifg_delay         (8'b0),
		.tx_statistics_vector (),
		.tx_statistics_valid  (),
		.rx_data              (),
		.rx_data_valid        (),
		.rx_good_frame        (),
		.rx_bad_frame         (),

		.rx_statistics_vector (),
		.rx_statistics_valid  (),

		.pause_val            (16'b0),
		.pause_req            (1'b0),

		.xgmii_txd            (xgmii_txd),
		.xgmii_txc            (xgmii_txc),
		.xgmii_rxd            (xgmii_rxd),
		.xgmii_rxc            (xgmii_rxc),

		.configuration_vector (67'b0)
	);
`else

  reg [63:0] xgmii_txd_reg;
  reg  [7:0] xgmii_txc_reg;
  assign xgmii_txd = xgmii_txd_reg;
  assign xgmii_txc = xgmii_txc_reg;

  reg sending;

  always @(posedge sys_clk) begin
    if (sys_reset) begin
      xgmii_txd_reg <= 64'haaaa_bbbb_cccc_dddd;
      sending       <= 1'b0;
    end else begin
      if (mac_tx_start) begin
        sending <= 1'b1;
        xgmii_txc_reg <= 8'b1111_1111;
        xgmii_txd_reg <= 64'hD5555555555555FB;
`ifdef DEBUG
        $display("got frame start");
`endif
      end

      if (sending) begin
        if (mac_tx_data_valid != 8'b1111_1111) begin
          xgmii_txc_reg <= ~mac_tx_data_valid;
          xgmii_txd_reg <= 64'h0102_0304_0506_0708;
          sending <= 1'b0;
`ifdef DEBUG
        $display("got frame end");
`endif
        end else begin
          xgmii_txc_reg <=  8'b0000_0000;
          xgmii_txd_reg <= 64'h0000_0000_0000_0000;
        end
      end
    end
  end
`endif

  /**************** Clock/Reset Generation ***************/

  reg [31:0] clk_counter;
  reg sys_reset_reg;

  initial begin
    clk_counter <= 32'b0;

    sys_reset_reg   <= 1'b1;
    #50
    sys_reset_reg   <= 1'b0;

    #`SIM_LENGTH

    $display("FAILED: simulation timed out");
    $finish;
  end

  always begin
    #1 clk_counter <= (clk_counter == `CLK_PERIOD - 1 ? 32'b0 : clk_counter + 1);
  end

  assign sys_clk   = clk_counter < ((`CLK_PERIOD) / 2);
  assign sys_reset = sys_reset_reg;

  /***************** XGMII Receive **********************
   * tie of to all xgmii IDLE
   */
  assign xgmii_rxc = 8'b1111_1111;
  assign xgmii_rxd = 64'h0707_0707_0707_0707;

  /***************** Mode Control **********************/

  reg mode;
  localparam MODE_NON_ALIGNED = 1'b0;
  localparam MODE_ALIGNED     = 1'b1;

  wire  [1:0] mode_done;
  wire [31:0] mode_recovered_crc;

  localparam CRC_NON_ALIGNED = 32'h779a8c22;
  localparam CRC_ALIGNED     = 32'h0b20cce0;

  always @(posedge sys_clk) begin
    if (sys_reset) begin
      mode <= MODE_NON_ALIGNED;
    end else begin
      case (mode)
        MODE_NON_ALIGNED: begin
          if (mode_done[MODE_NON_ALIGNED]) begin
            if (mode_recovered_crc === CRC_NON_ALIGNED) begin
              mode <= MODE_ALIGNED;
`ifdef DEBUG
              $display("mode: MODE_NON_ALIGNED passed - crc = %x", mode_recovered_crc);
`endif
            end else begin
              $display("FAILED: invalid CRC, got %h - expected %h", mode_recovered_crc, CRC_NON_ALIGNED);
              $finish;
            end
          end
        end
        MODE_ALIGNED: begin
          if (mode_done[MODE_ALIGNED]) begin
            if (mode_recovered_crc === CRC_ALIGNED) begin
`ifdef DEBUG
              $display("mode: MODE_ALIGNED passed - crc = %x", mode_recovered_crc);
`endif
            end else begin
              $display("FAILED: invalid CRC, got %h - expected %h", mode_recovered_crc, CRC_ALIGNED);
              $finish;
            end
            $display("PASSED");
            $finish;
          end
        end
      endcase
    end
  end

  /***************** MAC Transmit **********************/

  localparam FRAME_LENGTH = 10; //8*64
  localparam WAIT_CYCLES  = 4;

  reg [31:0] tx_progress;


  reg mac_tx_start_reg;
  reg [7:0] mac_tx_valid_reg;

  assign mac_tx_data  = tx_progress;
  assign mac_tx_start = mac_tx_start_reg;
  assign mac_tx_data_valid = mac_tx_valid_reg;


  always @(posedge sys_clk) begin
    if (sys_reset) begin
      tx_progress      <= 32'b0;
      mac_tx_valid_reg <= 8'b0;
      mac_tx_start_reg <= 1'b0;
    end else begin
      if (tx_progress == FRAME_LENGTH + WAIT_CYCLES - 1) begin
        tx_progress <= 0;
      end else begin
        tx_progress <= tx_progress + 1;
      end
    end
  end

  always @(posedge sys_clk) begin
    if (sys_reset) begin
      mac_tx_start_reg <= 1'b0;
      mac_tx_valid_reg <= 8'b0000_0000;
    end else begin
      if (tx_progress == 0) begin
        mac_tx_start_reg <= 1'b1;
      end else begin
        mac_tx_start_reg <= 1'b0;
      end
      if (tx_progress < FRAME_LENGTH - 1) begin
        mac_tx_valid_reg <= 8'b1111_1111;
      end else if (tx_progress == FRAME_LENGTH - 1) begin
        if (mode == MODE_NON_ALIGNED) begin
          mac_tx_valid_reg <= 8'b0000_0011;
        end else if (mode == MODE_ALIGNED) begin
          mac_tx_valid_reg <= 8'b0000_0000;
        end
      end else begin
        mac_tx_valid_reg <= 8'b0000_0000;
      end
    end
  end

  /************** XGMII tx verification *************/

  reg [1:0] xgmii_ver_state;
  localparam XGMII_VER_IDLE = 2'd0; 
  localparam XGMII_VER_DATA = 2'd1;  
  localparam XGMII_VER_TEST = 2'd2;  

  reg [31:0] recovered_crc;
  assign mode_recovered_crc = recovered_crc;

  function [7:0] lowest_set_bit;
    input [7:0] value;
    integer i;
    begin
      lowest_set_bit = 7;
      for (i=0; i < 8; i=i+1) begin
        if (value[7 - i]) begin
          lowest_set_bit = 7 - i;
        end
      end
    end
  endfunction

  assign mode_done = {2{xgmii_ver_state == XGMII_VER_TEST}};

  always @(posedge sys_clk) begin
    if (sys_reset) begin
      xgmii_ver_state <= XGMII_VER_IDLE;
    end else begin
      case (xgmii_ver_state)
        XGMII_VER_IDLE: begin
          if (xgmii_txd[7:0] == 8'hfb && xgmii_txc[0] == 1'b1) begin
            xgmii_ver_state <= XGMII_VER_DATA;
          end
          if (xgmii_txd[39:32] == 8'hfb && xgmii_txc[4] == 1'b1) begin
            xgmii_ver_state <= XGMII_VER_DATA;
          end
        end
        XGMII_VER_DATA: begin
          if (xgmii_txc != 8'b0000_0000) begin 
            /* got a control char ie end of xfer */
            xgmii_ver_state <= XGMII_VER_TEST;
            recovered_crc <= xgmii_txd >> (8*(lowest_set_bit(xgmii_txc)-4));
`ifdef DEBUG
            $display("xgmii_ver: end of frame: txc = %b, txd = %x", xgmii_txc, xgmii_txd); 
`endif
          end
        end
        XGMII_VER_TEST: begin
          xgmii_ver_state <= XGMII_VER_IDLE;
`ifdef DEBUG
          $display("xgmii_ver: got crc = %x", recovered_crc);
`endif
        end
      endcase
    end
  end

endmodule
