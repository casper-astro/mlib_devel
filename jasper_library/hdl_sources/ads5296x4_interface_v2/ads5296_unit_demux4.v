module ads5296_unit (
  // lclk domain inputs
  input lclk_d4, // Line clock / 4
  input [3:0] fclk4b,  // 4bit deserialized fclk
  input [7:0] din4b,   // 4bit deserialized data lane0 for two lanes
  input rst,
  input wr_en,
  // sclk domain signals
  input sclk,  // sample clock (2x frame clock)
  input rd_en, // sample clock (2x frame clock)
  output [9:0] dout
  );

  /*
   * Clock phase ambiguity means the first sample might be
   * bit 0, 2, 4, 6, or 8.
   * But, if data and frame clock are deserialized together,
   * each of these scenarios can be distinguished by looking at the
   * accompanying frame clock.
   */

  // Two wires to select data to be written to the output
  // FIFO. We need two because an ADC unit handles two interleaved
  // streams.
  wire [9:0] fifo_din0;
  wire [9:0] fifo_din1;
  // FIFO write enable strobe
  reg fifo_we;
  // Stream index -- should be 1 when adcX_d1 is ready to write, and
  // 0 when adcX_d0 is ready to write.
  reg stream_index;
  // Temporary ADC registers for the two mixed up words (d0/d1)
  // of the two ADC streams (adc0 / adc1)
  reg [9:0] adc0_d0;
  reg [9:0] adc0_d1;
  reg [9:0] adc1_d0;
  reg [9:0] adc1_d1;

  // Split up input data into two channels
  wire [3:0] din4b_0 = din4b[3:0];
  wire [3:0] din4b_1 = din4b[7:4];

  reg error;
  (* mark_debug = "true" *) wire debug_error = error;

  assign fifo_din0 = stream_index==1'b1 ? adc0_d1 : adc0_d0;
  assign fifo_din1 = stream_index==1'b1 ? adc1_d1 : adc1_d0;

  // Assume data is received MSB first
  always @(posedge lclk_d4) begin
    // Strobe defaults
    fifo_we <= 1'b0;
    if (fclk4b == 4'b1111) begin
      adc0_d0[3:0] <= din4b_0;
      adc1_d0[3:0] <= din4b_1;
    end else if (fclk4b == 4'b1000) begin
      adc0_d0[7:4] <= din4b_0;
      adc1_d0[7:4] <= din4b_1;
    end else if (fclk4b == 4'b0011) begin
      // Finish first word
      adc0_d0[9:8] <= din4b_0[1:0];
      adc1_d0[9:8] <= din4b_1[1:0];
      fifo_we <= 1'b1;
      stream_index <= 1'b0;
      // Start second word
      adc0_d1[1:0] <= din4b_0[3:2];
      adc1_d1[1:0] <= din4b_1[3:2];
    end else if (fclk4b == 4'b1110) begin
      adc0_d1[5:2] <= din4b_0;
      adc1_d1[5:2] <= din4b_1;
    end else if (fclk4b == 4'b0000) begin
      // Finish second word
      adc0_d1[9:6] <= din4b_0;
      adc1_d1[9:6] <= din4b_1;
      fifo_we <= 1'b1;
      stream_index <= 1'b1;
    end else begin
      error <= 1'b1;
    end
  end

  wire [15:0] fifo_dout;
  assign dout = fifo_dout[9:0];
  data_fifo data_fifo_inst(
    .rst(rst),                  // input wire srst
    .wr_clk(lclk_d4),           // input wire wr_clk
    .rd_clk(sclk),              // input wire rd_clk
    .din({6'b0, fifo_din1, 6'b0, fifo_din0}), // input wire [31 : 0] din
    .wr_en(fifo_we),            // input wire wr_en
    .rd_en(rd_en),              // input wire rd_en
    .dout(fifo_dout),           // output wire [15 : 0] dout
    .full(),                    // output wire full
    .empty(),                   // output wire empty
    .wr_rst_busy(),             // output wire wr_rst_busy
    .rd_rst_busy()              // output wire rd_rst_busy
  );

endmodule
