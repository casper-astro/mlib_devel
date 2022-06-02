module ads5296_unit (
  // lclk domain inputs
  input lclk, // Line clock / 4
  input clk_in, // FIFO write clock (lclk / 5)
  input [1:0] din_rise,  // 4bit deserialized fclk
  input [1:0] din_fall,   // 4bit deserialized data lane0 for two lanes
  input bitslip,
  input [2:0] slip_index,
  input rst,
  input wr_en,
  // clk_out domain signals
  input clk_out,
  input rd_en,
  output [9:0] dout,
  output sync_out
  );
  
  (* shreg_extract = "no" *) reg bitslipR;
  (* shreg_extract = "no" *) reg bitslipRR;
  (* async_reg = "true" *) reg bitslip_unstable;
  (* async_reg = "true" *) reg bitslip_stable;
  (* mark_debug = "true" *) wire bitslip_strobe = bitslipR & ~bitslipRR;
  always @(posedge lclk) begin
    bitslip_unstable <= bitslip;
    bitslip_stable <= bitslip_unstable;
    bitslipR <= bitslip_stable;
    bitslipRR <= bitslipR;
  end

  /* 
   *
   * 1 word every 5 cycles.
   * latency of data input to FIFO is :
   * 4 clock dinRRRR <= din // But we are only using 2 cycles
   * 5 clock through shift reg
   * 1 clock shregR <= shreg
   */
  (* shreg_extract = "no" *) reg [1:0] din_riseR;
  (* shreg_extract = "no" *) reg [1:0] din_fallR;
  reg [1:0] din_riseRR;
  reg [1:0] din_fallRR;

  reg [9:0] shreg0;
  reg [9:0] shreg1;
  //(* shreg_extract = "no" *) reg [9:0] shreg0R;
  //(* shreg_extract = "no" *) reg [9:0] shreg1R;
  reg [9:0] shreg0R;
  reg [9:0] shreg1R;
  
  reg rst_lclk; // Reset on LCLK domain. Maybe better timing to cross rst before using it?
  reg [2:0] bit_cnt;
  always @(posedge lclk) begin
    // Probably want to deassert rst with known phase to the frame clock
    // else bit slip will come up randomly
    rst_lclk <= rst;
    if (rst_lclk) begin
      bit_cnt <= 3'd0;
    end else begin
      // Increment bit index by 1, unless bitslip is strobed, in which case increment by 2
      if (!bitslip_strobe) begin
        bit_cnt <= bit_cnt == 3'd4 ? 3'd0 : bit_cnt + 1'b1;
      end
    end
    din_riseR <= din_rise;
    din_fallR <= din_fall;
    din_riseRR <= din_riseR;
    din_fallRR <= din_fallR;
    //TODO Is this latency right? Seems to work in hardware
    shreg0 <= {din_fallRR[0], din_riseRR[0], shreg0[9:2]};
    shreg1 <= {din_fallRR[1], din_riseRR[1], shreg1[9:2]};
    //shreg0R <= shreg0;
    //shreg1R <= shreg1;
    
    // Copy shift register contents only
    // At the end of a word 
    if (bit_cnt == slip_index) begin
      shreg0R <= shreg0;
      shreg1R <= shreg1;
    end
  end
  
  // Copy the shift register again into the FIFO write clock domain.
  // We could use lclk for this domain with a multicycle constraint
  // to achieve the same 5x timing relaxation. 
  // Abuse the ASYNC_REG attribute to encourage the placer to keep
  // a short path between these registers. In reality, the path
  // is synchronous (though _is_ inter-clock) but has a challenging timing
  // constraint
  (* async_reg = "true" *) reg [9:0] shreg0RR;
  (* async_reg = "true" *) reg [9:0] shreg1RR;
  always @(posedge clk_in) begin
    shreg0RR <= shreg0R;
    shreg1RR <= shreg1R;
  end
  
  wire [15:0] fifo_dout;
  assign dout = fifo_dout[9:0];
  assign sync_out = fifo_dout[15];
  wire fifo_full;
  wire fifo_empty;
  wire fifo_wr_en;
  wire fifo_rd_en;
  assign fifo_rd_en = rd_en;
  assign fifo_wr_en = wr_en;
  data_fifo data_fifo_inst(
    .rst(rst_lclk),            // input wire srst
    .wr_clk(clk_in),           // input wire wr_clk
    .rd_clk(clk_out),          // input wire rd_clk
    //.din({1'b1, 5'b0, fifo_din1, 1'b0, 5'b0, fifo_din0}), // input wire [31 : 0] din
    // Big endian -- write first sample out into MSBs
    // ???? Hardware testing suggests the order of samples is lane 1 before lane0.
    // ???? This is NOT what the data sheet says!
    //.din({1'b0, 5'b0, shreg0RR, 1'b1, 5'b0, shreg1RR}), // input wire [31 : 0] din
    .din({1'b1, 5'b0, shreg1RR, 1'b0, 5'b0, shreg0RR}), // input wire [31 : 0] din
    .wr_en(wr_en),    // input wire wr_en
    .rd_en(rd_en),              // input wire rd_en
    .dout(fifo_dout),           // output wire [15 : 0] dout
    .full(fifo_full),                    // output wire full
    .empty(fifo_empty),                   // output wire empty
    .wr_rst_busy(),             // output wire wr_rst_busy
    .rd_rst_busy()              // output wire rd_rst_busy
  );

endmodule
