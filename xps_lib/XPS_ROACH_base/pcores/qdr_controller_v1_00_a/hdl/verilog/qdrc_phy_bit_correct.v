module qdrc_phy_bit_correct(
    clk0,
    clk270,
    reset,

    aligned,

    qdr_q_rise, //180 clock domain
    qdr_q_fall,
    qdr_q_rise_cal,
    qdr_q_fall_cal
  );
  input  clk0, clk270, reset;
  input  aligned;
  input  qdr_q_rise, qdr_q_fall;
  output qdr_q_rise_cal, qdr_q_fall_cal;

  parameter USE_CLK270 = 0;


generate if (USE_CLK270 == 1) begin :use_clk270

  reg [1:0] data_buffer;

  always @(posedge clk270) begin
    data_buffer <= {qdr_q_rise, qdr_q_fall};
  end

  assign qdr_q_rise_cal = aligned ? data_buffer[1] : data_buffer[0];
  assign qdr_q_fall_cal = aligned ? data_buffer[0] : qdr_q_rise;

end else begin                      :use_clk0

  reg [1:0] data_buffer;
  reg [1:0] data_reg;

  always @(posedge clk0) begin
    data_reg    <= {qdr_q_rise, qdr_q_fall};
    data_buffer <= data_reg;
  end

  assign qdr_q_rise_cal = aligned ? data_buffer[1] : data_buffer[0];
  assign qdr_q_fall_cal = aligned ? data_buffer[0] : data_reg[1];

end endgenerate

endmodule
