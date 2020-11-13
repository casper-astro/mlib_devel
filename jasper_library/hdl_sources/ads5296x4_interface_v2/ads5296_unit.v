module ads5296_unit (
  // lclk domain inputs
  input lclk, // Line clock (DDR)
  input fclk_rise, // Frame clock data signal
  input fclk_fall,
  input [1:0] din_rise,
  input [1:0] din_fall,
  input rst,
  input wr_en,
  input sclk_div2,
  // sclk domain signals
  input sclk,  // sample clock (2x frame clock)
  input rd_en, // sample clock (2x frame clock)
  output [9:0] dout
  );

  reg fclk_riseR;
  reg fclk_fallR;
  reg fifo_wr_enR;
  reg fifo_wr_enRR;
  (* shreg_extract = "no" *) reg [1:0] din_fallR;
  (* shreg_extract = "no" *) reg [1:0] din_riseR;
  wire fclk_posedge = fclk_rise & ~fclk_riseR; // occurs with bits 0/1 of sample
  (* shreg_extract = "no" *) reg fclk_posedgeR;
  always @(posedge lclk) begin
    fclk_riseR <= fclk_rise;
    fclk_fallR <= fclk_fall;
    din_fallR <= din_fall;
    din_riseR <= din_rise;
    fclk_posedgeR <= fclk_posedge;
  end

  //wire fclk_negedge = ~fclk_fall & fclk_fallR; // occurs with bits  of sample
  (* SHREG_EXTRACT = "no" *) reg fclk_posedgeRR;

  
  reg [9:0] shreg0;
  reg [9:0] shreg1;
  (* SHREG_EXTRACT = "no" *) reg [9:0] shreg0R;
  (* SHREG_EXTRACT = "no" *) reg [9:0] shreg1R;
  //(* SHREG_EXTRACT = "no" *) reg [9:0] shreg0RR;
  //(* SHREG_EXTRACT = "no" *) reg [9:0] shreg1RR;

  always @(posedge lclk) begin
    fclk_posedgeRR <= fclk_posedgeR;
    shreg0 <= {din_riseR[0], din_fallR[0], shreg0[9:2]};
    shreg1 <= {din_riseR[1], din_fallR[1], shreg1[9:2]};
    if (fclk_posedgeR) begin
      shreg0R <= shreg0; // static for 5 lclk cycles. Could use this to help timing.
      shreg1R <= shreg1;
    end
   // shreg0RR <= shreg0R;
   // shreg1RR <= shreg1R;
  end
  
  reg [9:0] shreg0_sclk;
  reg [9:0] shreg1_sclk;
  always @(posedge sclk_div2) begin
    shreg0_sclk <= shreg0R;
    shreg1_sclk <= shreg1R;
    fifo_wr_enR <= wr_en;
    fifo_wr_enRR <= fifo_wr_enR;
  end
    

  wire [15:0] fifo_dout;
  assign dout = fifo_dout[9:0];
  data_fifo data_fifo_inst(
    .rst(rst),                  // input wire srst
    .wr_clk(sclk_div2),         // input wire wr_clk
    .rd_clk(sclk),              // input wire rd_clk
    .din({6'b0, shreg0_sclk, 6'b0, shreg0_sclk}), // input wire [31 : 0] din
    .wr_en(fifo_wr_enRR),// & fclk_posedgeRR),              // input wire wr_en
    .rd_en(rd_en),              // input wire rd_en
    .dout(fifo_dout),           // output wire [15 : 0] dout
    .full(),                    // output wire full
    .empty(),                   // output wire empty
    .wr_rst_busy(),             // output wire wr_rst_busy
    .rd_rst_busy()              // output wire rd_rst_busy
  );

endmodule
