module serdes_gearbox #(
  parameter DIN_WIDTH = 4,
  parameter S_TO_P_FACTOR = 5,
  parameter P_TO_S_FACTOR = 2
  ) (
  input fastclock,
  output slowclock,
  input [DIN_WIDTH-1:0] din,
  output [DIN_WIDTH*S_TO_P_FACTOR/P_TO_S_FACTOR - 1 : 0] dout,
  input bitslip
  );

  localparam DOUT_WIDTH = DIN_WIDTH*S_TO_P_FACTOR/P_TO_S_FACTOR;

  reg [DIN_WIDTH*S_TO_P_FACTOR - 1 : 0] shift_reg_in;
  reg [7:0] fastcount = 8'b0;
  always @(posedge fastclock) begin
    if (bitslip) begin
      shift_reg_in[DIN_WIDTH-1-1:0] <= din[2:0];
      shift_reg_in[DIN_WIDTH*S_TO_P_FACTOR - 1 : DIN_WIDTH-1] <= shift_reg_in[DIN_WIDTH*S_TO_P_FACTOR-DIN_WIDTH-1-1 : 0];
    end else begin
      shift_reg_in[DIN_WIDTH-1:0] <= din;
      shift_reg_in[DIN_WIDTH*S_TO_P_FACTOR - 1 : DIN_WIDTH] <= shift_reg_in[DIN_WIDTH*S_TO_P_FACTOR-DIN_WIDTH-1 : 0];
    end
    if (fastcount == S_TO_P_FACTOR-1) begin
      fastcount <= 8'b0;
    end else begin
      fastcount <= fastcount + 1'b1;
    end
  end

  reg [7:0] slowcount = 8'b0;
  reg [DOUT_WIDTH * P_TO_S_FACTOR -1 : 0] shift_reg_out;
  reg [DOUT_WIDTH-1:0] dout_reg;
  assign dout = dout_reg;
  always @(posedge slowclock) begin
    if (fastcount == 8'b0) begin
      shift_reg_out <= shift_reg_in;
    end else begin
      shift_reg_out[DOUT_WIDTH*P_TO_S_FACTOR-1 : DOUT_WIDTH] <=  shift_reg_out[DOUT_WIDTH*(P_TO_S_FACTOR-1)-1:0];
    end
    dout_reg <= shift_reg_out[DOUT_WIDTH*P_TO_S_FACTOR-1:DOUT_WIDTH*(P_TO_S_FACTOR-1)];
  end
endmodule
