module ads5296_unit (
  // lclk domain inputs
  input lclk_d4, // Line clock / 4
  input [3:0] fclk4b,  // 4bit deserialized fclk
  input [7:0] din4b,   // 4bit deserialized data lane0 for two lanes
  input rst,
  input sync,
  input wr_en,
  output [31:0] fclk_err_cnt,
  // sclk domain signals
  input sclk,  // sample clock (2x frame clock)
  input rd_en, // sample clock (2x frame clock)
  output [9:0] dout,
  output sync_out
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
  (* mark_debug = "true" *) wire [9:0] fifo_din0;
  (* mark_debug = "true" *) wire [9:0] fifo_din1;
  // FIFO write enable strobe
  reg fifo_we;
  (* mark_debug = "true" *) wire debug_fifo_we = fifo_we;
  (* mark_debug = "true" *) wire debug_fifo_re = rd_en;
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
  
  // Frame clock error counter
  // FCLK should cycle: 0b1111 -> 0b1000 -> 0b0011 -> 0b1110 -> 0b0000
  (* shreg_extract = "no" *) reg [3:0] fclk4bR;
  (* shreg_extract = "no" *) reg [3:0] fclk4bRR;
  reg [31:0] err_cnt;
  assign fclk_err_cnt = err_cnt;
  (* mark_debug = "true" *) wire [31:0] debug_err_cnt = err_cnt;
  always @(posedge lclk_d4) begin
    fclk4bR <= fclk4b;
    fclk4bRR <= fclk4bR;
    case(fclk4bR)
      4'b0001 : begin
        if (fclk4bRR != 4'b1111) begin
          err_cnt <= err_cnt + 1'b1;
        end
      end
      4'b1100 : begin
        if (fclk4bRR != 4'b0001) begin
          err_cnt <= err_cnt + 1'b1;
        end
      end
      4'b0111 : begin
        if (fclk4bRR != 4'b1100) begin
          err_cnt <= err_cnt + 1'b1;
        end
      end
      4'b0000 : begin
        if (fclk4bRR != 4'b0111) begin
          err_cnt <= err_cnt + 1'b1;
        end
      end
      4'b1111 : begin
        if (fclk4bRR != 4'b0000) begin
          err_cnt <= err_cnt + 1'b1;
        end
      end
      default : begin
        err_cnt <= err_cnt + 1'b1;
      end
    endcase
  end

  // On sync or reset, reset the deserializer. After a sync,
  // start writing on the next word start, where frame clock = 1111.
  // Thereafter, just count. This means that behaviour is (might be)
  // unpredictable with a corrupted frame clock
  reg [2:0] ctr;
  reg wait_reg;
  always @(posedge lclk_d4) begin
    if (sync | rst) begin
      ctr <= 3'b0;
      wait_reg <= 1'b1;
    end else begin
      if (~wait_reg) begin
        if (ctr == 3'd4) begin
          ctr <= 3'b0;
        end else begin
          ctr <= ctr + 1'b1;
        end
      end else begin
        // On the last cycle, release the counter reset.
        // On the next clock the counter will be 0, which should happen as fclk4b goes to 0b1111.
        // I.e. release the counter when fclk4b is 0b0000
        // And the first values in a data word are received.
        if (fclk4b == 4'b0000) begin
          wait_reg <= 1'b0;
        end
      end
    end
  end  

  // Assume data is received LSB first      
  always @(posedge lclk_d4) begin
    // Strobe defaults
    fifo_we <= 1'b0;
    if (ctr == 3'd0) begin
      adc0_d0[3:0] <= din4b_0;
      adc1_d0[3:0] <= din4b_1;
    end else if (ctr == 3'd1) begin
      adc0_d0[7:4] <= din4b_0;
      adc1_d0[7:4] <= din4b_1;
    end else if (ctr == 3'd2) begin
      // Finish first word
      adc0_d0[9:8] <= din4b_0[1:0];
      adc1_d0[9:8] <= din4b_1[1:0];
      fifo_we <= 1'b1;
      stream_index <= 1'b0;
      // Start second word
      adc0_d1[1:0] <= din4b_0[3:2];
      adc1_d1[1:0] <= din4b_1[3:2];
    end else if (ctr == 3'd3) begin
      adc0_d1[5:2] <= din4b_0;
      adc1_d1[5:2] <= din4b_1;
    end else if (ctr == 3'd4) begin
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
  assign sync_out = fifo_dout[15];
  data_fifo data_fifo_inst(
    .rst(rst),                  // input wire srst
    .wr_clk(lclk_d4),           // input wire wr_clk
    .rd_clk(sclk),              // input wire rd_clk
    //.din({1'b1, 5'b0, fifo_din1, 1'b0, 5'b0, fifo_din0}), // input wire [31 : 0] din
    // Big endian -- write first sample out into MSBs
    .din({1'b0, 5'b0, fifo_din0, 1'b1, 5'b0, fifo_din1}), // input wire [31 : 0] din
    .wr_en(fifo_we & wr_en),    // input wire wr_en
    .rd_en(rd_en),              // input wire rd_en
    .dout(fifo_dout),           // output wire [15 : 0] dout
    .full(),                    // output wire full
    .empty(),                   // output wire empty
    .wr_rst_busy(),             // output wire wr_rst_busy
    .rd_rst_busy()              // output wire rd_rst_busy
  );

endmodule
