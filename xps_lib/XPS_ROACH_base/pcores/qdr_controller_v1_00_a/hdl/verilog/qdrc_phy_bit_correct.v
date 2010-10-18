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

  reg [1:0] data_buffer;
  reg [1:0] data_reg;

  always @(posedge clk0) begin
    data_reg    <= {qdr_q_rise, qdr_q_fall};
    data_buffer <= data_reg;
  end

  assign qdr_q_rise_cal = aligned ? data_buffer[1] : data_buffer[0];
  assign qdr_q_fall_cal = aligned ? data_buffer[0] : data_reg[1];

endmodule
