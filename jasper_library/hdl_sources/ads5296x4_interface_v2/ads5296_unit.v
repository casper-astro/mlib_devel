module ads5296_unit (
  // lclk domain inputs
  input lclk, // Line clock (DDR)
  input fclk_rise, // Frame clock data signal
  input fclk_fall,
  input [1:0] din_rise,
  input [1:0] din_fall,
  // sclk_div2 domain inputs
  input sclk_div2, // frame clock (sample clock / 2)
  input rst,
  input wr_en,
  // sclk domain signals
  input sclk,  // sample clock (2x frame clock)
  input rd_en, // sample clock (2x frame clock)
  output [9:0] dout
  );

  //  assign dout[9:8] = 2'b0;
  //
  //  wire [15:0] dout_8bit;
  //
  //ISERDESE3 #(
  //  .DATA_WIDTH(8),
  //  .FIFO_ENABLE(1'b0)
  //) data_deserialize[1:0] (
  //  .Q(dout_8bit),
  //  .CLK(lclk),
  //  .CLKB(~lclk),
  //  .CLKDIV(fclk_8bit),
  //  .RST(rst),
  //  .D(din),
  //  .FIFO_RD_CLK(1'b0),
  //  .FIFO_RD_EN(1'b0)
  //);

  reg fclk_riseR;
  reg fclk_fallR;
  always @(posedge lclk) begin
    fclk_riseR <= fclk_rise;
    fclk_fallR <= fclk_fall;
  end

  wire fclk_posedge = fclk_rise & ~fclk_riseR; // occurs with bits 0/1 of sample
  //wire fclk_negedge = ~fclk_fall & fclk_fallR; // occurs with bits  of sample
  (* SHREG_EXTRACT = "no" *) reg fclk_posedgeR;
  (* SHREG_EXTRACT = "no" *) reg fclk_posedgeRR;
  
  reg [9:0] shreg0;
  reg [9:0] shreg1;
  (* SHREG_EXTRACT = "no" *) reg [9:0] shreg0R;
  (* SHREG_EXTRACT = "no" *) reg [9:0] shreg1R;
  always @(posedge lclk) begin
    fclk_posedgeR <= fclk_posedge;
    shreg0 <= {shreg0[7:0], din_rise[0], din_fall[0]};
    shreg1 <= {shreg1[7:0], din_rise[1], din_fall[1]};
    // fclk_posedge comes with the first bit of a new sample,
    // so register the existing word
    if (fclk_posedge) begin
      // Need to constrain these as multicycle? They change every 5 clocks
      shreg0R <= shreg0;
      shreg1R <= shreg1;
    end
  end

  reg [9:0] shreg0_sclk_div2_reg;
  reg [9:0] shreg1_sclk_div2_reg;
  always @(posedge sclk_div2) begin
    shreg0_sclk_div2_reg <= shreg0R;
    shreg1_sclk_div2_reg <= shreg1R;
  end

  wire [15:0] fifo_dout;
  assign dout = fifo_dout[9:0];
  data_fifo data_fifo_inst(
    .rst(rst),                  // input wire srst
    .wr_clk(sclk_div2),         // input wire wr_clk
    .rd_clk(sclk),              // input wire rd_clk
    .din({6'b0, shreg0_sclk_div2_reg, 6'b0, shreg1_sclk_div2_reg}), // input wire [31 : 0] din
    .wr_en(wr_en),              // input wire wr_en
    .rd_en(rd_en),              // input wire rd_en
    .dout(fifo_dout),           // output wire [15 : 0] dout
    .full(),                    // output wire full
    .empty(),                   // output wire empty
    .wr_rst_busy(),             // output wire wr_rst_busy
    .rd_rst_busy()              // output wire rd_rst_busy
  );

  //reg fclk_rise_sclk;
  //always @(posedge sclk) begin
  //  fclk_rise_sclk <= fclk_rise;
  //end

  //(* SHREG_EXTRACT = "no" *) reg [9:0] dout_reg;
  //reg [9:0] dout0R;
  //reg [9:0] dout1R;
  //reg fclk_rise_sclkR;
  //always @(posedge sclk) begin
  //  dout0R <= dout0;
  //  dout1R <= dout1;
  //  fclk_rise_sclkR;
  //  if (fclk_rise_sclkR) begin
  //    dout_reg <= dout0R;
  //  end else begin
  //    dout_reg <= dout1R;
  //  end
  //  dout <= dout_reg;
  //end

//  // Capture data on to frame clock domain
//  reg [9:0] d0_fclk;
//  reg [9:0] d1_fclk;
//  always @(posedge sclkd2) begin
//    d0_fclk <= shreg0;
//    d1_fclk <= shreg1;
//  end

//  // Interleave data back to sample rate
//  reg mux_cnt = 1'b0;
//  always @(posedge sclk) begin
//    mux_cnt <= mux_cnt + 1'b1;
//    if (mux_cnt) begin
//      dout <= d0_fclk;
//    end else begin
//      dout <= d1_fclk;
//    end
//  end

endmodule
