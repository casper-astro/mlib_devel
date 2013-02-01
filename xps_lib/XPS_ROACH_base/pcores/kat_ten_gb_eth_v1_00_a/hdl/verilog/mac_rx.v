`timescale 1ns/1ps

module mac_rx #(
    parameter USE_HARD_CRC = 1,
    parameter BYPASS_CRC   = 0
  ) (
    input         reset,
    input         rx_clk,
    input         rx_dcm_lock,
    output [63:0] rx_data,
    output  [7:0] rx_data_valid,
    output        rx_good_frame,
    output        rx_bad_frame,
    output [28:0] rx_statistics_vector,
    output  [7:0] rx_statistics_valid,
    input  [63:0] xgmii_rxd,
    input   [7:0] xgmii_rxc
  );

  /*********************** RECEIVE *******************************/
  
  assign rx_statistics_vector = 0;
  assign rx_statistics_valid  = 0;
  
  /************ Receive CRC *************/
  
  reg [0:0] rx_state;
  localparam RX_IDLE = 1'd0;
  localparam RX_DATA = 1'd1;
  
  reg rx_aligned;
  
  reg [63:0] xgmii_rxd_z;
  reg  [7:0] xgmii_rxc_z;
  
  wire [63:0] xgmii_rxd_align;
  wire  [7:0] xgmii_rxc_align;
  
  always @(posedge rx_clk) begin
    xgmii_rxd_z <= xgmii_rxd;
    xgmii_rxc_z <= xgmii_rxc;
    if (reset) begin
      rx_state   <= RX_IDLE;
      rx_aligned <= 1'b0;
    end else begin
      case (rx_state)
        RX_IDLE: begin
          /* Look for start code, only 0 and 4 are valid places */
          if (xgmii_rxd[7:0] == 8'hFB && xgmii_rxc[0]) begin
            rx_aligned <= 1'b1;
            rx_state <= RX_DATA;
`ifdef DESPERATE_DEBUG
            $display("mac_rx: got start aligned");
`endif
          end
          if (xgmii_rxd_z[39:32] == 8'hfb && xgmii_rxc_z[4]) begin
            rx_aligned <= 1'b0;
            rx_state <= RX_DATA;
`ifdef DESPERATE_DEBUG
            $display("mac_rx: got start non-aligned");
`endif
          end
        end
        RX_DATA: begin
          if (|xgmii_rxc_align) begin
            rx_state <= RX_IDLE;
          end
        end
      endcase
    end
  end
  
  assign xgmii_rxd_align = rx_aligned ? xgmii_rxd : {xgmii_rxd[31:0], xgmii_rxd_z[63:32]};
  assign xgmii_rxc_align = rx_aligned ? xgmii_rxc : {xgmii_rxc[ 3:0], xgmii_rxc_z[ 7:4 ]};
  
  /**************** CRC Related Logic **********************
   * The goal here is to 'mask out' the crc data from the
   * data_valid lines. This is done firstly so the received CRC is not
   * included when calculating the frame CRC and also so the user does
   * not get the CRC portion in their data
   */

  reg [63:0] rx_data_pre_crc_reg;
  reg [7:0] rx_data_valid_pre_crc_reg;

  reg rx_crc_start_reg;
  reg rx_crc_start_reg_z;

  always @(posedge rx_clk) begin
    /* the CRC start needs to be asserted on the same cycle as the first data */
    rx_crc_start_reg    <= rx_state == RX_IDLE;
    rx_crc_start_reg_z  <= rx_crc_start_reg;
    rx_data_pre_crc_reg <= xgmii_rxd_align;
    if (reset || rx_state != RX_DATA) begin
      rx_data_valid_pre_crc_reg <= 8'b0;
    end else begin
      rx_data_valid_pre_crc_reg <= 8'b1111_1111;
      if (xgmii_rxc_align[7])
        rx_data_valid_pre_crc_reg <= {5'b0, 3'b111};
      if (xgmii_rxc_align[6])
        rx_data_valid_pre_crc_reg <= {6'b0, 2'b11};
      if (xgmii_rxc_align[5])
        rx_data_valid_pre_crc_reg <= {7'b0, 1'b1};
      if (xgmii_rxc_align[4])
        rx_data_valid_pre_crc_reg <= 8'b0;
    end
  end

  wire [63:0] rx_data_pre_crc = rx_data_pre_crc_reg;
  reg [7:0] rx_data_valid_pre_crc;
  always @(*) begin
    rx_data_valid_pre_crc <= rx_data_valid_pre_crc_reg;
    if (xgmii_rxc_align[3])
      rx_data_valid_pre_crc <= {1'b0, rx_data_valid_pre_crc_reg[6:0]};
    if (xgmii_rxc_align[2])
      rx_data_valid_pre_crc <= {2'b0, rx_data_valid_pre_crc_reg[5:0]};
    if (xgmii_rxc_align[1])
      rx_data_valid_pre_crc <= {3'b0, rx_data_valid_pre_crc_reg[4:0]};
    if (xgmii_rxc_align[0])
      rx_data_valid_pre_crc <= {4'b0, rx_data_valid_pre_crc_reg[3:0]};
  end

generate if (BYPASS_CRC) begin : nocrc
  /* final assignments */
  assign rx_data       = rx_data_pre_crc;
  assign rx_data_valid = rx_data_valid_pre_crc;

  reg eof;

  always @(posedge rx_clk) begin
    eof   <= 1'b0;

    if (rx_state == RX_DATA) begin
      if (|xgmii_rxc_align[7:3] && !xgmii_rxc_align[4:0]) begin
        eof   <= 1'b1;
      end
    end
  end

  assign rx_good_frame = rx_state == RX_DATA && (|xgmii_rxc_align[4:0]) ? 1'b1 : eof;
  assign rx_bad_frame  = 0;

end else begin : hardcrc
  wire [63:0] rx_crc_data_in;
  wire  [7:0] rx_crc_data_valid;
  wire [31:0] rx_crc_out;
  wire        rx_crc_reset;

  mac_hard_crc mac_hard_crc_inst(
    .clk       (rx_clk),
    .rst       (rx_crc_reset),
    .din       (rx_crc_data_in),
    .din_valid (rx_crc_data_valid),
    .crc_out   (rx_crc_out)
  );

  assign rx_crc_data_in    = rx_data_pre_crc;
  assign rx_crc_data_valid = rx_data_valid_pre_crc;
  assign rx_crc_reset      = rx_crc_start_reg_z;
  
  /***************** Store the receieved CRC ***************
   * Here we extract the CRC from the incoming data using the
   * xgmii_rxc lines to check for the end of the frame
   */
  reg [31:0] rx_crc_reg;
  reg searching;

  always @(posedge rx_clk) begin
    if (reset) begin
      searching <= 1'b0;
    end else begin
      if (!searching) begin
        if (rx_state == RX_DATA) begin
          searching <= 1'b1;
        end
      end else begin
        rx_crc_reg <= xgmii_rxd_align[63:32];

        if (|xgmii_rxc_align) begin
          searching <= 1'b0;
        end
        if (xgmii_rxc_align[7])
          rx_crc_reg <= xgmii_rxd_align[55:24];
        if (xgmii_rxc_align[6])
          rx_crc_reg <= xgmii_rxd_align[47:16];
        if (xgmii_rxc_align[5])
          rx_crc_reg <= xgmii_rxd_align[39:8];
        if (xgmii_rxc_align[4])
          rx_crc_reg <= xgmii_rxd_align[31:0];
        if (xgmii_rxc_align[3])
          rx_crc_reg <= {xgmii_rxd_align[23:0], rx_crc_reg[31:24]};
        if (xgmii_rxc_align[2])
          rx_crc_reg <= {xgmii_rxd_align[15:0], rx_crc_reg[31:16]};
        if (xgmii_rxc_align[1])
          rx_crc_reg <= {xgmii_rxd_align[7:0], rx_crc_reg[31:8]};
        if (xgmii_rxc_align[0])
          rx_crc_reg <= rx_crc_reg[31:0];
      end
    end
  end

`ifdef DESPERATE_DEBUG
  reg prev_searching;
  always @(posedge rx_clk) begin
    prev_searching <= searching;
    if (reset) begin
    end else begin
      if (!searching && prev_searching) begin
        $display("mac_rx: got crc = %x", rx_crc_reg);
      end
    end
  end
`endif
  
  /****************** Wait for CRC result *******************
   * here we need to register the data a few times to
   * compensate for the CRC calc latency. Also
   * we take care of aligning the EOF
   */

  reg [63:0] rx_data_R;
  reg  [7:0] rx_data_valid_R;
  reg [63:0] rx_data_RR;
  reg  [7:0] rx_data_valid_RR;
  reg got_start;

  reg rx_last_R;
  reg rx_last;

  reg rx_start, rx_start_z;
  reg rx_state_z;

  always @(posedge rx_clk) begin
    rx_last          <= 1'b0;
    rx_data_R        <= rx_data_pre_crc;
    rx_data_valid_R  <= rx_data_valid_pre_crc;
    rx_data_RR       <= rx_data_R;
    rx_data_valid_RR <= rx_data_valid_R;
    rx_last_R        <= rx_last;

    if (reset) begin
      got_start <= 1'b0;
    end else begin
      case (got_start)
        0: begin
          if (rx_state == RX_DATA) begin
            got_start <= 1'b1;
          end
        end
        1: begin
          if (!rx_crc_data_valid[0]) begin
            /* in the case where is no payload data in the final frame octet,
               ie it is all crc, we need to issue the end of frame a cycle earlier
            */
            rx_last_R <= 1'b1; 
            got_start <= 1'b0;
          end else if (!rx_crc_data_valid[7]) begin
            rx_last   <= 1'b1;
            got_start <= 1'b0;
          end
        end
      endcase
    end
  end

  /* final assignments */
  assign rx_data       = rx_data_RR;
  assign rx_data_valid = rx_data_valid_RR;

  assign rx_good_frame = rx_last_R ? rx_crc_reg == rx_crc_out : 1'b0;
  assign rx_bad_frame  = rx_last_R ? rx_crc_reg != rx_crc_out : 1'b0;

`ifdef DESPERATE_DEBUG
  always @(posedge rx_clk) begin
    if (reset) begin
    end else begin
      if (rx_good_frame) begin
        $display("mac_rx: good frame");
      end
      if (rx_bad_frame) begin
        $display("mac_rx: bad frame");
      end
    end
  end
`endif

end endgenerate
  
endmodule
