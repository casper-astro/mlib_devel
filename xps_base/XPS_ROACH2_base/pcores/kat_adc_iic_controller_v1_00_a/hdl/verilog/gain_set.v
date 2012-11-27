`timescale 1ns/1ps
module gain_set (
    input         clk,
    input         rst,
    input  [13:0] gain_value,
    input         gain_load,

    output        trans_vld,
    output  [7:0] trans_data,
    output        trans_start,
    output        trans_stop,
    output        trans_rnw,
    output        trans_lock
  );

  reg state;
  localparam STATE_IDLE = 0;
  localparam STATE_RUN  = 1;

  reg [3:0] progress;
  localparam NUM_OPS = 12;

  reg [13:0] gain_value_latch;


  always @(posedge clk) begin
    if (rst) begin
      state <= STATE_IDLE;
    end else begin
      case (state)
        STATE_IDLE: begin
          if (gain_load) begin
            gain_value_latch <= gain_value;
            state <= STATE_RUN;
          end
        end
        STATE_RUN: begin
          if (progress == NUM_OPS - 1) begin
            state <= STATE_IDLE;
          end
        end
      endcase
    end
  end

  always @(posedge clk) begin
    if (rst || state == STATE_IDLE) begin
      progress <= 0;
    end else begin
      progress <= progress + 1;
    end
  end

  localparam GPIO_IIC_ADDRQ = 7'h21;
  localparam GPIO_IIC_ADDRI = 7'h20;
  localparam IIC_WR = 1'b0;

  localparam GPIO_REG_OEN = 8'h6;
  localparam GPIO_REG_OUT = 8'h2;

  reg [7:0] trans_data_reg;
  reg       trans_start_reg;
  reg       trans_stop_reg;
  reg       trans_rnw_reg;
  reg       trans_lock_reg;

  assign trans_data   = trans_data_reg;
  assign trans_start  = trans_start_reg;
  assign trans_stop   = trans_stop_reg;
  assign trans_rnw    = trans_rnw_reg;
  assign trans_lock   = trans_lock_reg;

  always @(*) begin
    case (progress[3:0])
      0: begin
        trans_lock_reg   <= 1'b1;
        trans_rnw_reg    <= 1'b0;
        trans_start_reg  <= 1'b1;
        trans_stop_reg   <= 1'b0;
        trans_data_reg   <= {GPIO_IIC_ADDRI, IIC_WR};
      end
      1: begin
        /* First Set the ouput enables for the IIC GPIO expansion IC */
        trans_lock_reg   <= 1'b1;
        trans_rnw_reg    <= 1'b0;
        trans_start_reg  <= 1'b0;
        trans_stop_reg   <= 1'b0;
        trans_data_reg   <= GPIO_REG_OEN;
      end
      2: begin
        /* set the register to 0x0, all outputs enabled */
        trans_lock_reg   <= 1'b1;
        trans_rnw_reg    <= 1'b0;
        trans_start_reg  <= 1'b0;
        trans_stop_reg   <= 1'b1;
        trans_data_reg   <= 8'b0;
      end
      3: begin
        trans_lock_reg   <= 1'b1;
        trans_rnw_reg    <= 1'b0;
        trans_start_reg  <= 1'b1;
        trans_stop_reg   <= 1'b0;
        trans_data_reg   <= {GPIO_IIC_ADDRI, IIC_WR};
      end
      4: begin
        /* Load the address of the output control register */
        trans_lock_reg   <= 1'b1;
        trans_rnw_reg    <= 1'b0;
        trans_start_reg  <= 1'b0;
        trans_stop_reg   <= 1'b0;
        trans_data_reg   <= GPIO_REG_OUT;
      end
      5: begin
        /* Load the address of the output control register */
        trans_lock_reg   <= 1'b1;
        trans_rnw_reg    <= 1'b0;
        trans_start_reg  <= 1'b0;
        trans_stop_reg   <= 1'b1;
        trans_data_reg   <= {gain_value_latch[6], 1'b1, gain_value_latch[5:0]};
      end
      6: begin
        trans_lock_reg   <= 1'b1;
        trans_rnw_reg    <= 1'b0;
        trans_start_reg  <= 1'b1;
        trans_stop_reg   <= 1'b0;
        trans_data_reg   <= {GPIO_IIC_ADDRQ, IIC_WR};
      end
      7: begin
        /* First Set the ouput enables for the IIC GPIO expansion IC */
        trans_lock_reg   <= 1'b1;
        trans_rnw_reg    <= 1'b0;
        trans_start_reg  <= 1'b0;
        trans_stop_reg   <= 1'b0;
        trans_data_reg   <= GPIO_REG_OEN;
      end
      8: begin
        /* set the register to 0x0, all outputs enabled */
        trans_lock_reg   <= 1'b1;
        trans_rnw_reg    <= 1'b0;
        trans_start_reg  <= 1'b0;
        trans_stop_reg   <= 1'b1;
        trans_data_reg   <= 8'b0;
      end
      9: begin
        trans_lock_reg   <= 1'b1;
        trans_rnw_reg    <= 1'b0;
        trans_start_reg  <= 1'b1;
        trans_stop_reg   <= 1'b0;
        trans_data_reg   <= {GPIO_IIC_ADDRQ, IIC_WR};
      end
      10: begin
        /* Load the address of the output control register */
        trans_lock_reg   <= 1'b1;
        trans_rnw_reg    <= 1'b0;
        trans_start_reg  <= 1'b0;
        trans_stop_reg   <= 1'b0;
        trans_data_reg   <= GPIO_REG_OUT;
      end
      default: begin
        /* Load the address of the output control register */
        trans_lock_reg   <= 1'b0;
        trans_rnw_reg    <= 1'b0;
        trans_start_reg  <= 1'b0;
        trans_stop_reg   <= 1'b1;
        trans_data_reg   <= {gain_value_latch[13], 1'b1, gain_value_latch[12:7]};
      end
    endcase
  end

  assign trans_vld = state == STATE_RUN;


endmodule
