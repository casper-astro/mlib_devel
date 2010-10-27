`timescale 1ns/1ps
module miic_ops #(
    parameter IIC_FREQ  = 100,
    parameter CORE_FREQ = 100000
  ) (
    input        clk,
    input        rst,
    input        op_valid,
    input        op_start,
    input        op_stop,
    input        op_rnw,
    input  [7:0] op_wr_data,
    output [7:0] op_rd_data,
    output       op_ack,
    output       op_err,

    output       sda_o,
    input        sda_i,
    output       sda_t,

    output       scl_o,
    input        scl_i,
    output       scl_t
  );

  reg [2:0] iic_state;
  localparam IIC_IDLE  = 0;
  localparam IIC_START = 1;
  localparam IIC_RUN   = 2;
  localparam IIC_DATA  = 3;
  localparam IIC_STOP  = 4;

  wire send_start;
  wire send_stop;
  wire send_data;

  wire done_start;
  wire done_stop;
  wire done_data;

  reg op_ack_reg;
  assign op_ack = op_ack_reg;

  always @(posedge clk) begin
    op_ack_reg <= 1'b0;

    if (rst) begin
      iic_state <= IIC_IDLE;
    end else begin
      case (iic_state)
        IIC_IDLE: begin
          if (op_valid && !op_ack_reg && op_start) begin
            iic_state <= IIC_START;
          end else if (op_valid && !op_ack_reg) begin
            op_ack_reg <= 1'b1;
          end
        end
        IIC_START: begin
          if (done_start) begin
            iic_state <= IIC_DATA;
          end
        end
        IIC_RUN: begin
          if (op_valid && !op_ack_reg) begin
            if (op_start) begin
              iic_state <= IIC_START;
            end else begin
              iic_state <= IIC_DATA;
            end
          end
        end
        IIC_DATA: begin
          if (done_data) begin
            if (op_stop) begin
              iic_state  <= IIC_STOP;
            end else begin
              op_ack_reg <= 1'b1;
              iic_state  <= IIC_RUN;
            end
          end
        end
        IIC_STOP: begin
          if (done_stop) begin
            op_ack_reg <= 1'b1;
            iic_state  <= IIC_IDLE;
          end
        end
      endcase
    end
  end

  assign send_start = iic_state == IIC_START;
  assign send_stop  = iic_state == IIC_STOP;
  assign send_data  = iic_state == IIC_DATA;

  /*********** 8 *************/

  wire clk_done;

  reg sda_o_reg;
  reg scl_o_reg;
  reg op_err_reg;

  reg [7:0] op_rd_data_reg;
  assign op_rd_data = op_rd_data_reg;

  reg [2:0] bit_state;
  localparam BIT_IDLE  = 0;
  localparam BIT_START = 1;
  localparam BIT_STOP  = 2;
  localparam BIT_DATA  = 3;
  localparam BIT_ACK   = 4;

  reg bit_first;
  reg [2:0] bit_index;

  reg issue_full_clk;
  reg issue_half_clk;
  reg clk_pend;

  reg bit_done;

  always @(posedge clk) begin
    bit_done <= 1'b0;

    issue_full_clk <= 1'b0;
    issue_half_clk <= 1'b0;

    if (clk_done)
      clk_pend <= 1'b0;

    if (rst) begin
      bit_state <= BIT_IDLE;
      clk_pend <= 1'b0;
      op_err_reg <= 1'b0;
      sda_o_reg <= 1'b1;
    end else begin
      case (bit_state)
        BIT_IDLE: begin
          bit_index <= 0;
          if (!bit_done && !clk_pend) begin
            if (send_start) begin
              bit_state <= BIT_START;
            end
            if (send_stop) begin
              bit_state <= BIT_STOP;
            end
            if (send_data) begin
              bit_first <= 1'b1;
              bit_state <= BIT_DATA;
            end
          end
        end
        BIT_START: begin
          if (!clk_pend) begin
            if (scl_o_reg && sda_o_reg) begin
              sda_o_reg <= 1'b0;/* TODO: this will bugger up reads afters starts - need to release after clk_done*/
              issue_half_clk <= 1'b1; //ensure scl is '0'
              clk_pend <= 1'b1;

              bit_done <= 1'b1;
              bit_state <= BIT_IDLE;
            end
            if (scl_o_reg && !sda_o_reg) begin
              issue_half_clk <= 1'b1;
              clk_pend <= 1'b1;
            end
            if (!scl_o_reg) begin
              sda_o_reg <= 1'b1;
              issue_half_clk <= 1'b1;
              clk_pend <= 1'b1;
            end
          end
        end
        BIT_STOP: begin
          if (!clk_pend) begin
            if (scl_o_reg && !sda_o_reg) begin
              sda_o_reg <= 1'b1;

              issue_half_clk <= 1'b1;
              clk_pend <= 1'b1;

              bit_done <= 1'b1;
              bit_state <= BIT_IDLE;
            end
            if (scl_o_reg && sda_o_reg) begin
              issue_half_clk <= 1'b1;
              clk_pend <= 1'b1;
            end
            if (!scl_o_reg) begin
              sda_o_reg <= 1'b0;
              issue_half_clk <= 1'b1;
              clk_pend <= 1'b1;
            end
          end
        end
        BIT_DATA: begin
          if (!clk_pend) begin
            if (op_rnw) begin
              sda_o_reg <= 1'b1;
              bit_first <= 1'b0;

              if (bit_first || bit_index == 3'b111) begin 
                /* In the case of first bit we must issue a half clock cycle
                   for scl to go from just after negedge to just after posedge 
                   so we sample the read data safely */
                /* In the case of final bitindex we must issue a half clock cycle
                   for scl to go from just after posedge to just after negedge so we are ready
                   to output data */
                issue_half_clk <= 1'b1;
              end else begin
                issue_full_clk <= 1'b1;
              end

              clk_pend <= 1'b1;

              if (bit_index == 3'b111) begin
                bit_state <= BIT_ACK;
                bit_first <= 1'b1;
              end

              if (!bit_first) begin
                bit_index <= bit_index + 1;
                op_rd_data_reg[7 - bit_index] <= sda_i;
              end
            end

            if (!op_rnw) begin
              sda_o_reg <= op_wr_data[7 - bit_index];
              bit_index <= bit_index + 1;

              issue_full_clk <= 1'b1;
              clk_pend <= 1'b1;

              bit_index <= bit_index + 1;

              if (bit_index == 3'b111) begin
                bit_state <= BIT_ACK;
              end
            end
          end
        end
        BIT_ACK: begin
          if (!clk_pend) begin
            if (op_rnw) begin
              if (bit_first) begin
                if (op_stop) begin
                  sda_o_reg <= 1'b1; // Send no ack condition
                end else begin
                  sda_o_reg <= 1'b0;
                end
                issue_full_clk <= 1'b1;
                clk_pend <= 1'b1;
                bit_first <= 1'b0;
              end else begin
                sda_o_reg <= 1'b1; // ensure we give up bus after ack
                bit_done <= 1'b1;
                bit_state <= BIT_IDLE;
              end
            end
            if (!op_rnw) begin
              sda_o_reg <= 1'b1; // give up the bus, for slave to ack
              if (bit_first) begin
                bit_first <= 1'b0;
                issue_half_clk <= 1'b1; // issue half clock to get to just after posedge
                clk_pend <= 1'b1;
              end else begin
                issue_half_clk <= 1'b1; // issue half clock to get to just after negedge
                clk_pend <= 1'b1;
                op_err_reg <= sda_i;

                bit_done <= 1'b1;
                bit_state <= BIT_IDLE;
              end
            end
          end
        end
      endcase
    end
  end

  assign done_start = bit_done; 
  assign done_stop  = bit_done;
  assign done_data  = bit_done;

  assign op_err = op_err_reg;

  /*********** ***********/

  reg [31:0] bitwidth_counter;
  localparam BITWIDTH_DIV2 = (CORE_FREQ / IIC_FREQ)/2;

  reg [1:0] clk_state;
  localparam CLK_IDLE = 0;
  localparam CLK_WAIT = 3;
  localparam CLK_FULL = 1;
  localparam CLK_HALF = 2;

  reg clk_done_reg;
  assign clk_done = clk_done_reg;

  always @(posedge clk) begin
    clk_done_reg <= 1'b0;

    if (rst) begin
      scl_o_reg <= 1'b1;
      clk_state <= CLK_IDLE;
    end else begin
      case (clk_state)
        CLK_IDLE: begin
          bitwidth_counter <= BITWIDTH_DIV2;
          if (issue_half_clk)
            clk_state <= CLK_HALF;
          if (issue_full_clk)
            clk_state <= CLK_FULL;
        end
        CLK_FULL: begin
          if (|bitwidth_counter) begin
            bitwidth_counter <= bitwidth_counter - 1;
          end else begin
            bitwidth_counter <= BITWIDTH_DIV2;
            scl_o_reg <= !scl_o_reg;
            clk_state <= CLK_HALF;
          end
        end
        CLK_HALF: begin
          if (|bitwidth_counter) begin
            bitwidth_counter <= bitwidth_counter - 1;
          end else begin
            bitwidth_counter <= BITWIDTH_DIV2 >> 4;
            scl_o_reg <= !scl_o_reg;
            clk_state <= CLK_WAIT;
          end
        end
        CLK_WAIT: begin
          if (|bitwidth_counter) begin
            bitwidth_counter <= bitwidth_counter - 1;
          end else begin
            clk_state <= CLK_IDLE;
            clk_done_reg <= 1'b1;
          end
        end
      endcase
    end
  end

  /*********** ***********/

  assign sda_t = sda_o_reg ? 1'b1 : 1'b0;
  assign scl_t = scl_o_reg ? 1'b1 : 1'b0;

  assign sda_o = 1'b0; // Let the output enables do the work
  assign scl_o = 1'b0; // Let the output enables do the work


endmodule
