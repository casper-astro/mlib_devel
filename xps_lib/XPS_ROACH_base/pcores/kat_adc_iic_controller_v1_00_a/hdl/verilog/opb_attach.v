`timescale 1ns/1ps
module opb_attach #(
    parameter C_BASEADDR    = 32'h00000000,
    parameter C_HIGHADDR    = 32'h0000FFFF,
    parameter C_OPB_AWIDTH  = 32,
    parameter C_OPB_DWIDTH  = 32
  ) (
    input         OPB_Clk,
    input         OPB_Rst,
    output [0:31] Sl_DBus,
    output        Sl_errAck,
    output        Sl_retry,
    output        Sl_toutSup,
    output        Sl_xferAck,
    input  [0:31] OPB_ABus,
    input  [0:3]  OPB_BE,
    input  [0:31] OPB_DBus,
    input         OPB_RNW,
    input         OPB_select,
    input         OPB_seqAddr,

    /**** IIC operations fifo controls *****/
    output        op_fifo_wr_en,
    output [11:0] op_fifo_wr_data,
    input         op_fifo_empty,
    input         op_fifo_full,
    input         op_fifo_over,

    /**** Receive data fifo controls *****/
    output        rx_fifo_rd_en,
    input   [7:0] rx_fifo_rd_data,
    input         rx_fifo_empty,
    input         rx_fifo_full,
    input         rx_fifo_over,
    /***** reset for both fifos *****/
    output        fifo_rst,
    /**** In high latency environment we need to block the op fifo
          in order to string together long IIC commands ****/
    output        op_fifo_block,
    /***** Was there an error during the IIC operation */
    input         op_error
  );

  /************* OPB Attach ***************/

  localparam REG_OP_FIFO = 0;
  localparam REG_RX_FIFO = 1;
  localparam REG_STATUS  = 2;
  localparam REG_CTRL    = 3;

  reg op_fifo_over_reg;
  reg rx_fifo_over_reg;

  reg op_fifo_wr_en_reg;
  assign op_fifo_wr_en = op_fifo_wr_en_reg;
  reg rx_fifo_rd_en_reg;
  assign rx_fifo_rd_en = rx_fifo_rd_en_reg;

  reg op_error_reg;

  wire addr_match = OPB_ABus >= C_BASEADDR && OPB_ABus <= C_HIGHADDR;
  wire [31:0] local_addr = OPB_ABus - C_BASEADDR;

  reg Sl_xferAck_reg;

  reg fifo_rst_reg;
  assign fifo_rst = fifo_rst_reg;

  reg op_fifo_block_reg;
  assign op_fifo_block = op_fifo_block_reg;

  always @(posedge OPB_Clk) begin
    // Single cycle strobes
    Sl_xferAck_reg    <= 1'b0;
    fifo_rst_reg      <= 1'b0;
    op_fifo_wr_en_reg <= 1'b0;
    rx_fifo_rd_en_reg <= 1'b0;

    // Latch contents high
    op_error_reg     <= op_error_reg | op_error;
    op_fifo_over_reg <= op_fifo_over_reg | op_fifo_over;
    rx_fifo_over_reg <= rx_fifo_over_reg | rx_fifo_over;

    if (OPB_Rst) begin
      op_fifo_over_reg  <= 1'b0;
      rx_fifo_over_reg  <= 1'b0;
      op_fifo_block_reg <= 1'b0;
    end else begin
      if (addr_match && OPB_select && !Sl_xferAck_reg) begin
        Sl_xferAck_reg <= 1'b1;
        case (local_addr[3:2])
          REG_OP_FIFO: begin
            if (!OPB_RNW && OPB_BE[3]) begin
              op_fifo_wr_en_reg <= 1'b1;
            end
          end
          REG_RX_FIFO: begin
            if (OPB_RNW && OPB_BE[3]) begin
              rx_fifo_rd_en_reg <= 1'b1;
            end
          end
          REG_STATUS: begin
            if (!OPB_RNW) begin
              fifo_rst_reg     <= 1'b1;
              op_fifo_over_reg <= 1'b0;
              rx_fifo_over_reg <= 1'b0;
              op_error_reg     <= 1'b0;
            end
          end
          REG_CTRL: begin
            if (!OPB_RNW && OPB_BE[3]) begin
              op_fifo_block_reg <= OPB_DBus[31];
            end
          end
        endcase
      end
    end
  end

  reg [31:0] opb_dout;
  always @(*) begin
    case (local_addr[3:2])
      REG_OP_FIFO: begin
        opb_dout <= 32'b0;
      end
      REG_RX_FIFO: begin
        opb_dout <= {24'b0, rx_fifo_rd_data};
      end
      REG_STATUS: begin
        opb_dout <= {16'b0, 7'b0, op_error_reg, 1'b0, op_fifo_over_reg, op_fifo_full, op_fifo_empty, 1'b0, rx_fifo_over_reg, rx_fifo_full, rx_fifo_empty};
      end
      REG_CTRL: begin
        opb_dout <= {31'b0, op_fifo_block_reg};
      end
      default: begin
        opb_dout <= 32'b0;
      end
    endcase
  end

  assign Sl_DBus = Sl_xferAck_reg ? opb_dout : 32'b0;
  assign Sl_errAck = 1'b0;
  assign Sl_retry = 1'b0;
  assign Sl_toutSup = 1'b0;
  assign Sl_xferAck = Sl_xferAck_reg;

  /* OPB fifo assignments */
  assign op_fifo_wr_data = OPB_DBus[20:31];

endmodule
