`timescale 1ns/10ps

module serial_config(
    input        clk,
    input        rst,
    input [15:0] config_data,
    input  [3:0] config_addr,
    input        config_start,
    output       config_idle,
    output       config_done,

    output       adc3wire_clk,
    output       adc3wire_data,
    output       adc3wire_strobe
  );

  wire clk_done;
  wire clk_en;

  reg [1:0] state;
  localparam CONFIG_IDLE      = 0;
  localparam CONFIG_CLKWAIT   = 1;
  localparam CONFIG_DATA      = 2;
  localparam CONFIG_FINISH    = 3;


  reg [31:0] config_data_shift;
  reg  [4:0] config_progress;

  always @(posedge clk) begin
    if (rst) begin
      state <= CONFIG_IDLE;
    end else begin
      case (state)
        CONFIG_IDLE: begin
          if (config_start) begin
            state <= CONFIG_CLKWAIT;
            config_data_shift <= {12'b1, config_addr, config_data};
          end
        end
        CONFIG_CLKWAIT: begin
          if (clk_done) begin
            state <= CONFIG_DATA;
            config_progress <= 0;
          end
        end 
        CONFIG_DATA: begin
          if (clk_done) begin
            config_data_shift <= config_data_shift << 1;
            config_progress <= config_progress + 1;
            if (config_progress == 31) begin
              state <= CONFIG_FINISH;
            end
          end
        end
        CONFIG_FINISH: begin
          if (clk_done) begin
            state <= CONFIG_IDLE;
          end
        end
        default: begin
          state <= CONFIG_IDLE;
        end
      endcase
    end
  end

  assign config_idle = state == CONFIG_IDLE;
  assign config_done = clk_done && state == CONFIG_FINISH;
  
  /* Clock Control */

  reg [3:0] clk_counter;
  always @(posedge clk) begin
    if (clk_en) begin
      clk_counter <= clk_counter + 1;
    end else begin
      clk_counter <= 4'b0;
    end
  end
  assign clk_done = clk_counter == 4'b1111;
  assign clk_en   = state != CONFIG_IDLE;

  assign adc3wire_strobe = !(state == CONFIG_DATA);
  assign adc3wire_data   = config_data_shift[31];
  assign adc3wire_clk    = clk_counter[3];

endmodule
