`timescale 1ns/1ps

module mac_tx #(
    parameter USE_HARD_CRC = 1
  ) (
    input         reset,
    //Transmit user I/F
    input         tx_clk,
    input         tx_dcm_lock,
    input         tx_underrun,
    input  [63:0] tx_data,
    input   [7:0] tx_data_valid,
    input         tx_start,
    output        tx_ack,
    input   [7:0] tx_ifg_delay,    
    output [24:0] tx_statistics_vector,
    output        tx_statistics_valid,
    //XGMII I/Fs
    output [63:0] xgmii_txd,
    output  [7:0] xgmii_txc
  );
  
  /************************ TRANSMIT ******************************/
  
  assign tx_statistics_vector = 0;
  assign tx_statistics_valid  = 0;
  
  /********* TX state machine ***********/
  
  reg [2:0] tx_state;
  localparam TX_IDLE                 = 3'd0;
  localparam TX_SEND_PREAMBLE        = 3'd1;
  localparam TX_SEND_DATA            = 3'd2;
  localparam TX_SEND_END_ALIGNED     = 3'd3;
  localparam TX_SEND_END_NON_ALIGNED = 3'd4;
  localparam TX_SEND_CORRUPTED_CRC   = 3'd5;
  localparam TX_INTERFRAME           = 3'd6;
  
  reg tx_ack_reg;
  assign tx_ack = tx_ack_reg;
  
  reg [63:0] tx_data_z;
  reg [63:0] tx_data_zz;
  reg  [7:0] tx_data_valid_z;
  reg        tx_start_latched;

  always @(posedge tx_clk) begin
    /* strobes */
    tx_ack_reg       <= 1'b0;

    /* We delay the data by once to improve timing closure
       We delay it again to align with CRC block, ditto with the dvalid */
    tx_data_z        <= tx_data;
    tx_data_zz       <= tx_data_z;
    tx_data_valid_z  <= tx_data_valid;
  
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
  
  reg  [2:0] tx_state_z;
  reg  [2:0] tx_state_zz;
  
  always @(posedge tx_clk) begin
    tx_state_z  <= tx_state;
    tx_state_zz <= tx_state_z;
  end
  
  /********* TX Data/Ctrl Decode *********/
  /* pre-CRC insertion values */
  reg [63:0] xgmii_txd_val;
  reg  [7:0] xgmii_txc_val;

  always @(posedge tx_clk) begin
    case (tx_state_z)
      TX_IDLE:
        xgmii_txd_val <= 64'h0707070707070707;
      TX_INTERFRAME:
        xgmii_txd_val <= 64'h0707070707070707;
      TX_SEND_PREAMBLE:
        xgmii_txd_val <= 64'hD5555555555555FB;
      TX_SEND_DATA:
        xgmii_txd_val <= tx_data_zz;
      TX_SEND_END_ALIGNED:
        xgmii_txd_val <= {32'h070707FD, 32'h00000000};
        /* Send stop code + zeros to be filled in by CRC insertion */
      TX_SEND_END_NON_ALIGNED:
        xgmii_txd_val <= {16'h07FD, 32'h0000_0000, tx_data_zz[15:0]};
        /* Move stop code left according to the only support data_valid value,
           leaving space for CRC insertion */
      TX_SEND_CORRUPTED_CRC:
        xgmii_txd_val <= {32'h070707FD, 32'h00000000};
        /* Send stop code + zeros to be filled in by CRC insertion */
      default:
        xgmii_txd_val <= 64'h0707070707070707;
    endcase
  end

  always @(posedge tx_clk) begin
    case (tx_state_z)
      TX_IDLE:
        xgmii_txc_val <= 8'b1111_1111;
      TX_INTERFRAME:
        xgmii_txc_val <= 8'b1111_1111;
      TX_SEND_PREAMBLE:
        xgmii_txc_val <= 8'b0000_0001;
      TX_SEND_DATA:
        xgmii_txc_val <= 8'b0000_0000;
      TX_SEND_END_ALIGNED:
        xgmii_txc_val <= 8'b1111_0000;
      TX_SEND_END_NON_ALIGNED:
        xgmii_txc_val <= 8'b1100_0000;
      TX_SEND_CORRUPTED_CRC:
        xgmii_txc_val <= 8'b1111_0000;
      default:
        xgmii_txc_val <= 8'b1111_1111;
    endcase
  end

  /************ Transmit CRC calculation *************/

  wire [63:0] tx_crc_data_in;
  wire  [7:0] tx_crc_data_valid;
  wire [31:0] tx_crc_out;
  wire        tx_crc_reset;

  mac_hard_crc mac_hard_crc_inst(
    .clk       (tx_clk),
    .rst       (tx_crc_reset),
    .din       (tx_crc_data_in),
    .din_valid (tx_crc_data_valid),
    .crc_out   (tx_crc_out)
  );

  assign tx_crc_data_in    = tx_data_z;
  assign tx_crc_data_valid = tx_data_valid_z;
  assign tx_crc_reset      = tx_state_z == TX_SEND_PREAMBLE; 

  /********** CRC Insertion ************/

  reg [63:0] xgmii_txd_reg;

  always @(*) begin
    case (tx_state_zz)
      TX_SEND_END_ALIGNED:
        xgmii_txd_reg <= {xgmii_txd_val[63:32], tx_crc_out};
      TX_SEND_END_NON_ALIGNED:
        xgmii_txd_reg <= {xgmii_txd_val[63:48], tx_crc_out, xgmii_txd_val[15:0]};
      TX_SEND_CORRUPTED_CRC:
        xgmii_txd_reg <= {xgmii_txd_val[63:32], tx_crc_out ^ 32'h1};
      default:
        xgmii_txd_reg <= xgmii_txd_val[63:0];
    endcase
  end
  
  assign xgmii_txd = xgmii_txd_reg;
  assign xgmii_txc = xgmii_txc_val;

endmodule
