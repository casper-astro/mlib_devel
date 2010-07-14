`timescale 1ns/10ps

module autoconfig #(
    parameter INTERLEAVED = 0,
    parameter ENABLE      = 0
  ) (
    input         clk,
    input         rst,

    output        busy,
    output [15:0] config_data,
    output  [3:0] config_addr,
    output        config_start,
    input         config_done
  );

  localparam STATE_IDLE = 0;
  localparam STATE_BUSY = 1;
  localparam STATE_DONE = 2;
  localparam REG_COUNT  = 4'd9;

generate if (ENABLE) begin :AUTO_ENABLE_generate

  reg [1:0] config_state;

  reg [3:0] progress;

  always @(posedge clk) begin
    if (rst) begin
      config_state <= STATE_IDLE;
    end else begin
      case (config_state)
        STATE_IDLE: begin
          config_state <= STATE_BUSY;
        end
        STATE_BUSY: begin
          if (progress == REG_COUNT - 1 && config_done) begin
            config_state <= STATE_DONE;
          end
        end
        STATE_DONE: begin
        end
      endcase
    end
  end
  assign busy = config_state != STATE_DONE;

  reg config_start_reg;
  assign config_start = config_start_reg;
  reg waiting;

  always @(posedge clk) begin
    config_start_reg <= 1'b0;

    if (config_state == STATE_IDLE) begin
      waiting <= 0;
      progress     <= 4'b0;
    end else begin
      if (progress < 9) begin
        if (!waiting) begin
          config_start_reg <= 1'b1;
          waiting <= 1'b1;
        end
        if (config_done) begin
          waiting  <= 1'b0;
          progress <= progress + 1;
        end
      end
    end
  end

  assign config_data = progress == 0 ? 16'h7FFF :
                       progress == 1 ? 16'hBAFF :
                       progress == 2 ? 16'h007F :
                       progress == 3 ? 16'h807F :
                       progress == 4 ? (INTERLEAVED ? 16'h23FF : 16'h03FF ):
                       progress == 5 ? 16'h007F :
                       progress == 6 ? 16'h807F :
                       progress == 7 ? 16'h00FF :
                                       16'h007F;

  assign config_addr = progress == 0 ? 4'h0 : 
                       progress == 1 ? 4'h1 : 
                       progress == 2 ? 4'h2 : 
                       progress == 3 ? 4'h3 : 
                       progress == 4 ? 4'h9 : 
                       progress == 5 ? 4'ha : 
                       progress == 6 ? 4'hb : 
                       progress == 7 ? 4'he : 
                                       4'hf;

end else begin : AUTO_DISABLE_generate
    assign busy         = 0;
    assign config_data  = 0;
    assign config_addr  = 0;
    assign config_start = 0;
end endgenerate
endmodule
