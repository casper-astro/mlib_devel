module qdrc_phy_align #(
    parameter DATA_WIDTH = 36
  ) (
    input                     clk,
    input                     divclk,
    input               [7:0] bit_select,
    input                     align_strb,
    input                     align_en,
    input  [DATA_WIDTH - 1:0] q_rise,
    input  [DATA_WIDTH - 1:0] q_fall,
    output [DATA_WIDTH - 1:0] cal_rise,
    output [DATA_WIDTH - 1:0] cal_fall
  );

  reg [DATA_WIDTH - 1:0] align;
  always @(posedge divclk) begin
    if (align_strb)
      align[bit_select] <= align_en;
  end

  /* no retiming to save a few resources - expect artifacts*/

  reg [DATA_WIDTH - 1:0] data_buffer_rise;
  reg [DATA_WIDTH - 1:0] data_buffer_fall;
  reg [DATA_WIDTH - 1:0] data_buffer_riseR;
  reg [DATA_WIDTH - 1:0] data_buffer_fallR;

  always @(posedge clk) begin
    data_buffer_rise  <= q_rise;
    data_buffer_fall  <= q_fall;
    data_buffer_riseR <= data_buffer_rise;
    data_buffer_fallR <= data_buffer_fall;
  end

  assign cal_rise = !align ? data_buffer_riseR : data_buffer_fallR;
  assign cal_fall = !align ? data_buffer_fallR : data_buffer_rise;

endmodule
