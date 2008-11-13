module qdrc_rd(
    clk,
    reset,
    phy_rdy,

    usr_strb,
    usr_data,
    usr_dvld,
    phy_strb,
    phy_data
  );
  parameter DATA_WIDTH = 18;
  parameter ADDR_WIDTH = 21;

  input  clk, reset, phy_rdy;

  input  usr_strb;
  output [2*DATA_WIDTH - 1:0] usr_data;
  output usr_dvld;

  output phy_strb;
  input  [2*DATA_WIDTH - 1:0] phy_data;

  reg strb_ignore;

  always @(posedge clk) begin
    if (reset) begin
      strb_ignore <= 1'b0;
    end else begin
      if (strb_ignore) begin
        strb_ignore <= 1'b0;
      end else if (usr_strb) begin
        strb_ignore <= 1'b1;
      end
    end
  end

  assign phy_strb = usr_strb;
  assign usr_data = phy_data;

  localparam READ_LATENCY = 8; /* TODO: finalize and comment on this */

  reg [READ_LATENCY - 1:0] usr_strb_shift_reg;
  assign usr_dvld = usr_strb_shift_reg[READ_LATENCY - 1];

  always @(posedge clk) begin
    if (reset) begin
      usr_strb_shift_reg <= 5'b0;
    end else begin
      usr_strb_shift_reg <= {usr_strb_shift_reg[READ_LATENCY - 2:0], phy_strb};
    end
  end

endmodule
