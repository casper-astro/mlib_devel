`timescale 1ns/1ps
/*
 *  Copyright (c) 2005-2006, Regents of the University of California
 *  All rights reserved.
 *
 *  Redistribution and use in source and binary forms, with or without modification,
 *  are permitted provided that the following conditions are met:
 *
 *      - Redistributions of source code must retain the above copyright notice,
 *          this list of conditions and the following disclaimer.
 *      - Redistributions in binary form must reproduce the above copyright
 *          notice, this list of conditions and the following disclaimer
 *          in the documentation and/or other materials provided with the
 *          distribution.
 *      - Neither the name of the University of California, Berkeley nor the
 *          names of its contributors may be used to endorse or --          products derived from this software without specific prior
 *          written permission.
 *
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 *  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 *  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 *  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
 *  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 *  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 *  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 *  ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *   #      ###    #####          #######
 *  ##     #   #  #     #  #      #
 * # #    # #   # #        #      #
 *   #    #  #  # #  ####  #####  #####
 *   #    #   # # #     #  #    # #
 *   #     #   #  #     #  #    # #
 * #####    ###    #####   #####  #######
 *
 *
 * 10GbEthernet core MAC
 *
 * *********************************************************************
 * * THIS CORE IS INTENDED TO BE USED WITH THE UCB 10GB INTERFACE      *
 * * IT SUPPORTS ONLY A VERY LIMITED RANGE OF THE FUNCTIONALITIES      *
 * * THAT A REAL MAC SHOULD SUPPORT. FOR A FULL SUPPORT OF 10GB,       *
 * * USE THE XILINX MAC.                                               *
 * * NOT SUPPORTED:                                                    *
 * *   - no configuration                                              *
 * *   - no statistics vectors                                         *
 * *   - no interframe minimization                                    *
 * *   - supports only full words or 16 bits word at the input         *
 * *   - no flow control                                               *
 * *********************************************************************
 *
 * created by Pierre-Yves Droz 2006
 * CRC + verilogization by David George 2008/9
 *
 *----------------------------------------------------------------------------
 * mac.vhd
 *----------------------------------------------------------------------------
 */

module ten_gig_eth_mac_ucb(
    input         reset,
    //Transmit user I/F
    input         tx_clk0,
    input         tx_dcm_lock,
    input         tx_underrun,
    input  [63:0] tx_data,
    input   [7:0] tx_data_valid,
    input         tx_start,
    output        tx_ack,
    input   [7:0] tx_ifg_delay,    
    output [24:0] tx_statistics_vector,
    output        tx_statistics_valid,
    //Receive user I/F
    input         rx_clk0,
    input         rx_dcm_lock,
    output [63:0] rx_data,
    output  [7:0] rx_data_valid,
    output        rx_good_frame,
    output        rx_bad_frame,
    output [28:0] rx_statistics_vector,
    output  [7:0] rx_statistics_valid,
    // Misc
    input  [15:0] pause_val,
    input         pause_req,
    input  [66:0] configuration_vector,
    //XGMII I/Fs
    output [63:0] xgmii_txd,
    output  [7:0] xgmii_txc,
    input  [63:0] xgmii_rxd,
    input   [7:0] xgmii_rxc
  );

  /******** Functions *********/
  
  /* simple bit_reverse */
  function [63:0] bit_reverse;
  input [63:0] value;
  input [63:0] size;
  integer i;
  begin
    for (i=0; i < size; i=i+1) begin
      bit_reverse[i] = value[size - 1 - i];
    end
  end
  endfunction
  
  /* reverses bit-order within byte groups */
  function [63:0] byte_reverse;
  input [63:0] value;
  input [63:0] size;
  integer i;
  begin
    for (i=0; i < size; i=i+1) begin
      byte_reverse[i] = value[(i/8)*8 + 7 - (i % 8)];
    end
  end
  endfunction
  
  /************************ TRANSMIT ******************************/
  
  assign tx_statistics_vector = 0;
  assign tx_statistics_valid  = 0;
  
  /************ Transmit CRC *************/
  wire [63:0] tx_crc_data_in;
  wire [31:0] tx_crc_data_out;
  wire        tx_crc_reset;
  wire  [2:0] tx_crc_width;
  
  wire [63:0] tx_crc_data_in_fixed = byte_reverse(bit_reverse(tx_crc_data_in,64),64);
  wire [31:0] tx_crc_data_out_unfixed;
  
  /* Xilinx CRC primitive */

  CRC64 #(
    .CRC_INIT (32'hffff_ffff)
  ) tx_crc (
    .CRCOUT        (tx_crc_data_out_unfixed),
    .CRCCLK        (tx_clk0),
    .CRCDATAVALID  (1'b1),
    .CRCDATAWIDTH  (tx_crc_width),
    .CRCIN         (tx_crc_data_in_fixed),
    .CRCRESET      (tx_crc_reset)
  );

  assign tx_crc_data_out = bit_reverse(byte_reverse(tx_crc_data_out_unfixed,32),32);

  /********* TX state machine ***********/
  
  reg [2:0] tx_state;
  localparam TX_IDLE                 = 3'd0;
  localparam TX_SEND_PREAMBLE        = 3'd1;
  localparam TX_SEND_DATA            = 3'd2;
  localparam TX_SEND_END_ALIGNED     = 3'd3;
  localparam TX_SEND_END_NON_ALIGNED = 3'd4;
  localparam TX_SEND_CORRUPTED_CRC   = 3'd5;
  localparam TX_INTERFRAME           = 3'd6;
  
  reg tx_crc_reset_reg;
  assign tx_crc_reset = tx_crc_reset_reg;
  reg tx_ack_reg;
  assign tx_ack = tx_ack_reg;
  
  reg [63:0] tx_data_z;
  reg        tx_start_latched;

  always @(posedge tx_clk0) begin
    /* strobes */
    tx_crc_reset_reg <= 1'b0;
    tx_ack_reg       <= 1'b0;
    /* delay to ease timing */
    tx_data_z        <= tx_data;
  
    if (reset) begin
      tx_state         <= TX_IDLE;
      tx_start_latched <= 1'b0;
    end else begin
      if (tx_start) begin
        tx_start_latched <= 1'b1;
      end
  
      case (tx_state)
        TX_IDLE: begin
          if (tx_start || tx_start_latched) begin
            tx_ack_reg       <= 1'b1;
            tx_start_latched <= 1'b0;
            tx_state         <= TX_SEND_PREAMBLE;
          end
        end
        TX_SEND_PREAMBLE: begin
          tx_crc_reset_reg <= 1'b1;
          tx_state         <= TX_SEND_DATA;
        end
        TX_SEND_DATA: begin
          case (tx_data_valid)
            8'b1111_1111: begin
              /* keep going */
            end
            8'b0000_0000: begin
              tx_state <= TX_SEND_END_ALIGNED;
            end
            8'b0000_0011: begin
              tx_state <= TX_SEND_END_NON_ALIGNED;
            end
            default: begin
              tx_state <= TX_SEND_CORRUPTED_CRC;
            end
          endcase
        end
        TX_SEND_END_ALIGNED: begin
          tx_state <= TX_INTERFRAME;
        end
        TX_SEND_END_NON_ALIGNED: begin
          tx_state <= TX_INTERFRAME;
        end
        TX_SEND_CORRUPTED_CRC: begin
          tx_state <= TX_INTERFRAME;
        end
        TX_INTERFRAME: begin
          tx_state <= TX_IDLE;
        end
      endcase
    end
  end
  
  /********* TX Data/Ctrl Decode *********/
  
  reg [63:0] xgmii_txd_reg;
  always @(*) begin
    case (tx_state)
      TX_IDLE:
        xgmii_txd_reg <= 64'h0707070707070707;
      TX_INTERFRAME:
        xgmii_txd_reg <= 64'h0707070707070707;
      TX_SEND_PREAMBLE:
        xgmii_txd_reg <= 64'hD5555555555555FB;
      TX_SEND_DATA:
        xgmii_txd_reg <= tx_data_z;
      TX_SEND_END_ALIGNED:
        xgmii_txd_reg <= {32'h070707FD, 32'h00000000};
        /* Send stop code + zeros to be filled in by CRC insertion */
      TX_SEND_END_NON_ALIGNED:
        xgmii_txd_reg <= {16'h07FD, 32'h0000_0000, tx_data_z[15:0]};
        /* Move stop code left according to the only support data_valid value,
           leaving space for CRC insertion */
      TX_SEND_CORRUPTED_CRC:
        xgmii_txd_reg <= {32'h070707FD, 32'h00000000};
        /* Send stop code + zeros to be filled in by CRC insertion */
      default:
        xgmii_txd_reg <= 64'h0707070707070707;
    endcase
  end

  reg [7:0] xgmii_txc_reg;
  always @(*) begin
    case (tx_state)
      TX_IDLE:
        xgmii_txc_reg <= 8'b1111_1111;
      TX_INTERFRAME:
        xgmii_txc_reg <= 8'b1111_1111;
      TX_SEND_PREAMBLE:
        xgmii_txc_reg <= 8'b0000_0001;
      TX_SEND_DATA:
        xgmii_txc_reg <= 8'b0000_0000;
      TX_SEND_END_ALIGNED:
        xgmii_txc_reg <= 8'b1111_0000;
      TX_SEND_END_NON_ALIGNED:
        xgmii_txc_reg <= 8'b1100_0000;
      TX_SEND_CORRUPTED_CRC:
        xgmii_txc_reg <= 8'b1111_0000;
      default:
        xgmii_txc_reg <= 8'b1111_1111;
    endcase
  end

  
  
  /********** CRC Insertion ************/
  
  /* The CRC comes one cycle after data so we end up with two cases
     for CRC insertion
     1: SEND_END_ALIGNED and SEND_CORRUPTED_CRC
        we delay the xgmii_tx by one then insert the CRC
     2: SEND_END_NONALIGNED and SEND_CORRUPTED_CRC
        we delay the xgmii_tx by two then insert the CRC
        this is required as we have data and CRC in the same frame
  */
  
  reg [63:0] xgmii_txd_reg_z;
  reg  [7:0] xgmii_txc_reg_z;
  reg  [2:0] tx_state_z;
  
  reg [63:0] xgmii_txd_crc;
  reg  [7:0] xgmii_txc_crc;
  
  reg crc_insert;
  
  always @(posedge tx_clk0) begin
    crc_insert <= 1'b0;
    /* Delays Due to CRC latency */
    xgmii_txd_reg_z <= xgmii_txd_reg;
    xgmii_txc_reg_z <= xgmii_txc_reg;
    tx_state_z      <= tx_state;
  
    /* Extra delay to support data + CRC in same frame */
    xgmii_txc_crc <= xgmii_txc_reg_z;
  
    if (reset) begin
    end else begin
      case (tx_state_z)
        TX_SEND_END_ALIGNED: begin
          xgmii_txd_crc <= xgmii_txd_reg_z | {32'h0000_0000, tx_crc_data_out};
        end
        TX_SEND_CORRUPTED_CRC: begin
          xgmii_txd_crc <= xgmii_txd_reg_z | {32'h0000_0000, tx_crc_data_out ^ 32'h1};
        end
        default: begin
          xgmii_txd_crc <= xgmii_txd_reg_z;
        end
      endcase
      if (tx_state_z == TX_SEND_END_NON_ALIGNED) begin
        crc_insert <= 1'b1;
      end
      if (crc_insert) begin
      end
    end
  end

  assign tx_crc_width = tx_state == TX_SEND_END_NON_ALIGNED ? 3'b001 : 3'b111;
  assign tx_crc_data_in = tx_data_z;
  

  assign xgmii_txd = crc_insert ? {xgmii_txd_crc[63:48], tx_crc_data_out, xgmii_txd_crc[15:0]} : xgmii_txd_crc;
  assign xgmii_txc = xgmii_txc_crc;
  
  /*********************** RECEIVE *******************************/
  
  assign rx_statistics_vector = 0;
  assign rx_statistics_valid  = 0;
  
  /************ Transmit CRC *************/
  wire [63:0] rx_crc_data_in;
  wire [31:0] rx_crc_data_out;
  wire        rx_crc_reset;
  wire  [2:0] rx_crc_width;
  wire rx_crc_data_valid;
  
  wire [63:0] rx_crc_data_in_fixed = byte_reverse(bit_reverse(rx_crc_data_in, 64), 64);
  wire [31:0] rx_crc_data_out_unfixed;
  
  /* Xilinx CRC primitive */

  CRC64 #(
    .CRC_INIT (32'hffff_ffff)
  ) rx_crc (
    .CRCOUT        (rx_crc_data_out_unfixed),
    .CRCCLK        (rx_clk0),
    .CRCDATAVALID  (rx_crc_data_valid),
    .CRCDATAWIDTH  (rx_crc_width),
    .CRCIN         (rx_crc_data_in_fixed),
    .CRCRESET      (rx_crc_reset)
  );

  assign rx_crc_data_out = bit_reverse(byte_reverse(rx_crc_data_out_unfixed, 32), 32);
  
  /************ Receive CRC *************/
  
  reg [1:0] rx_state;
  localparam RX_IDLE    = 2'd0;
  localparam RX_WAIT    = 2'd1;
  localparam RX_RECEIVE = 2'd2;
  
  reg rx_aligned;
  
  reg [63:0] xgmii_rxd_z;
  reg  [7:0] xgmii_rxc_z;
  
  wire [63:0] xgmii_rxd_align;
  wire  [7:0] xgmii_rxc_align;
  
  reg rx_crc_start_reg;
  
  always @(posedge rx_clk0) begin
    xgmii_rxd_z <= xgmii_rxd;
    xgmii_rxc_z <= xgmii_rxc;
    rx_crc_start_reg <= 1'b0;
    if (reset) begin
      rx_state   <= RX_IDLE;
      rx_aligned <= 1'b0;
    end else begin
      case (rx_state)
        RX_IDLE: begin
          /* Look for start code, only 0 and 4 are valid places */
          if (xgmii_rxd[7:0] == 8'hFB && xgmii_rxc[0]) begin
            rx_aligned <= 1'b1;
            rx_state <= RX_WAIT;
`ifdef DESPERATE_DEBUG
            $display("mac_rx: got start aligned");
`endif
          end
          if (xgmii_rxd[39:32] == 8'hfb && xgmii_rxc[4]) begin
            rx_aligned <= 1'b0;
            rx_state <= RX_WAIT;
`ifdef DESPERATE_DEBUG
            $display("mac_rx: got start non-aligned");
`endif
          end
        end
        RX_WAIT: begin
          rx_state <= RX_RECEIVE;
          rx_crc_start_reg <= 1'b1;
        end
        RX_RECEIVE: begin
          if (xgmii_rxc_align != 8'b00000000) begin
            rx_state <= RX_IDLE;
          end
        end
      endcase
    end
  end
  
  assign xgmii_rxd_align = rx_aligned ? xgmii_rxd_z : {xgmii_rxd[31:0],xgmii_rxd_z[63:32]};
  assign xgmii_rxc_align = rx_state != RX_RECEIVE ? 8'b1111_1111 :
                                                    (rx_aligned ? xgmii_rxc_z : {xgmii_rxc[ 3:0],xgmii_rxc_z[ 7:4 ]});

  
  /**************** CRC Related Logic **********************
   * The goal here is to 'mask out' the crc data from the
   * data_valid lines, and then use that results to generate
   * the data_width crc signal
   */

  reg [63:0] rx_data_pre_crc_reg;
  reg [7:0] rx_data_valid_pre_crc_reg;
  /* remove the CRC from the data valid */

  reg rx_crc_start_reg_z;

  always @(posedge tx_clk0) begin
    rx_crc_start_reg_z  <= rx_crc_start_reg;
    rx_data_pre_crc_reg <= xgmii_rxd_align;
    if (reset) begin
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

  /* translate data valid to crc_width */
  reg [2:0] rx_crc_width_reg;
  reg rx_crc_data_valid_reg;
  always @(*) begin
    rx_crc_width_reg <= 3'b111; //default all bytes valid
    rx_crc_data_valid_reg <= 1'b1; //default valid

    if (rx_data_valid_pre_crc[7] == 1'b0)
      rx_crc_width_reg <= 3'b110; //7 valid bytes
    if (rx_data_valid_pre_crc[6] == 1'b0)
      rx_crc_width_reg <= 3'b101; //6 valid bytes
    if (rx_data_valid_pre_crc[5] == 1'b0)
      rx_crc_width_reg <= 3'b100; //5 valid bytes
    if (rx_data_valid_pre_crc[4] == 1'b0)
      rx_crc_width_reg <= 3'b011; //4 valid bytes
    if (rx_data_valid_pre_crc[3] == 1'b0)
      rx_crc_width_reg <= 3'b010; //3 valid bytes
    if (rx_data_valid_pre_crc[2] == 1'b0)
      rx_crc_width_reg <= 3'b001; //2 valid bytes
    if (rx_data_valid_pre_crc[1] == 1'b0)
      rx_crc_width_reg <= 3'b000; //1 valid byte

    if (rx_data_valid_pre_crc[0] == 1'b0)
      rx_crc_data_valid_reg <= 1'b0; //make CRC ignore data altogether
      
  end

  assign rx_crc_data_in    = rx_data_pre_crc;
  assign rx_crc_width      = rx_crc_width_reg;
  assign rx_crc_data_valid = rx_crc_data_valid_reg;
  assign rx_crc_reset      = rx_crc_start_reg_z;
  
  /***************** Store the receieved CRC ***************
   * Here we extract the CRC from the incoming data using the
   * xgmii_rxc lines to check for the end of the frame
   */
  reg [31:0] rx_crc_reg;
  reg searching;

  always @(posedge rx_clk0) begin
    if (reset) begin
      searching <= 1'b0;
    end else begin
      if (!searching) begin
        if (rx_state == RX_WAIT) begin
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
  always @(posedge rx_clk0) begin
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

  /* TODO: clean up, hard to follow */
  always @(posedge rx_clk0) begin
    rx_last          <= 1'b0;
    rx_data_R        <= rx_data_pre_crc;
    rx_data_valid_R  <= rx_data_valid_pre_crc;
    rx_data_RR       <= rx_data_R;
    rx_data_valid_RR <= rx_data_valid_R;
    rx_last_R        <= rx_last;

    rx_start   <= rx_state == RX_WAIT;
    rx_start_z <= rx_start;
    if (reset) begin
      got_start <= 1'b0;
    end else begin
      case (got_start)
        0: begin
          if (rx_start_z) begin
            got_start <= 1'b1;
          end
        end
        1: begin
          if (!rx_crc_data_valid) begin
            /* if we bypassed the CRC it means we only wait one cycle */
            rx_last_R <= 1'b1; 
            got_start <= 1'b0;
          end else if (rx_crc_width != 3'b111) begin
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

  assign rx_good_frame = rx_last_R ? rx_crc_reg == rx_crc_data_out : 1'b0;
  assign rx_bad_frame  = rx_last_R ? rx_crc_reg != rx_crc_data_out : 1'b0;

`ifdef DESPERATE_DEBUG
  always @(posedge tx_clk0) begin
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


endmodule
