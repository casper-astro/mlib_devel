module qdrc_phy_train #(
    parameter DATA_WIDTH = 36
  ) (
    input                     clk,
    input  [DATA_WIDTH - 1:0] q_rise,
    input  [DATA_WIDTH - 1:0] q_fall,
    output [DATA_WIDTH - 1:0] dly_inc_dec_n,
    output [DATA_WIDTH - 1:0] dly_en,
    output [DATA_WIDTH - 1:0] dly_rst,

    input               [7:0] bit_select,
    input                     dll_en,
    input                     dll_inc_dec_n,
    input                     dll_rst,
    output              [1:0] data_value,
    output                    data_sampled,
    output                    data_valid        
  );

  /* TODO: these registers are probably not needed */
  reg [DATA_WIDTH - 1:0] q_rise_buf;
  reg [DATA_WIDTH - 1:0] q_fall_buf;

  always @(posedge clk) begin
    q_rise_buf <= q_rise;
    q_fall_buf <= q_fall;
  end

  wire qsel_rise = q_rise_buf[bit_select];
  wire qsel_fall = q_fall_buf[bit_select];

  reg [1:0] qsel;
  always @(posedge clk) begin
    qsel <= {qsel_rise, qsel_fall}; 
  end

  assign data_value = qsel;

  assign dly_rst       = {{DATA_WIDTH - 1{1'b0}}, dll_rst}<< bit_select;
  assign dly_inc_dec_n = {DATA_WIDTH{dll_inc_dec_n}};
  assign dly_en        = {{DATA_WIDTH - 1{1'b0}}, dll_en} << bit_select;

  reg [1:0] sample_status;
  localparam DONE   = 2'b00;
  localparam WAIT   = 2'b01;
  localparam SAMPLE = 2'b10;

  reg [4:0] sample_index;
  reg [1:0] data_latched;
  reg       data_valid_reg;

  always @(posedge clk) begin
    if (dly_en) begin
      sample_index <= 5'b0;
    end else begin
      sample_index <= sample_index + 5'b1;
    end

    if (dly_en) begin
      sample_status  <= WAIT;
      data_valid_reg <= 1'b1;
    end else begin
      case (sample_status)
        WAIT: begin
          if (sample_index == 31) begin
            sample_status <= SAMPLE;
            data_latched  <= data_value;
          end
        end
        SAMPLE: begin
          if (sample_index == 31) begin
            sample_status <= DONE;
          end
          if (data_value == 2'b11 || data_value == 2'b00 || data_value != data_latched) begin
            data_valid_reg <= 1'b0;
          end
        end
        DONE: begin
        end
      endcase
    end
  end
  assign data_valid   = data_valid_reg;
  assign data_sampled = sample_status == DONE;

endmodule
