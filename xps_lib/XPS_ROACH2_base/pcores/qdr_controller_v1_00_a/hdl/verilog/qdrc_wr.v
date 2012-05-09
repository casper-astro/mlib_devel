module qdrc_wr(
    clk,
    reset,

    usr_strb,
    usr_data,
    usr_ben,
    phy_strb,
    phy_data,
    phy_ben
  );

  parameter DATA_WIDTH = 36;
  parameter BW_WIDTH   = 4;
  parameter ADDR_WIDTH = 21;
  input  clk, reset;

  input  usr_strb;
  input  [2*DATA_WIDTH - 1:0] usr_data;
  input    [2*BW_WIDTH - 1:0] usr_ben;

  output phy_strb;
  output [2*DATA_WIDTH - 1:0] phy_data;
  output   [2*BW_WIDTH - 1:0] phy_ben;

  assign phy_strb = usr_strb;
  assign phy_data = usr_data;
  assign phy_ben  = usr_ben;

endmodule
