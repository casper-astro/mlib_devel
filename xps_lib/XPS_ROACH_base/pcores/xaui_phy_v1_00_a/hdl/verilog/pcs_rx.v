`include "xaui_kat.vh"
module pcs_rx(
    clk, reset,
    align_status,
    mgt_rxdata, mgt_rxcharisk,
    disperr,
    xgmii_rxd, xgmii_rxc
  );
  input  clk, reset;
  input  align_status;
  input  [63:0] mgt_rxdata;
  input   [7:0] mgt_rxcharisk;
  input   [7:0] disperr;
  output [63:0] xgmii_rxd;
  output  [7:0] xgmii_rxc;

  /* convert 64 bit MGT words, [bytes: 7, 3, 6, 2, 5, 1, 4, 0] to
    into 2x32 bit ethernet words, [W0: 3, 2, 1, 0  W1: 7, 6, 5, 4] */
  wire [31:0] rx_data_0 = {mgt_rxdata[55:48],mgt_rxdata[39:32],mgt_rxdata[23:16],mgt_rxdata[7:0]};
  wire [31:0] rx_data_1 = {mgt_rxdata[63:56],mgt_rxdata[47:40],mgt_rxdata[31:24],mgt_rxdata[15:8]};
  wire  [3:0] rx_isk_0 = {mgt_rxcharisk[6], mgt_rxcharisk[4], mgt_rxcharisk[2], mgt_rxcharisk[0]}; 
  wire  [3:0] rx_isk_1 = {mgt_rxcharisk[7], mgt_rxcharisk[5], mgt_rxcharisk[3], mgt_rxcharisk[1]}; 

  reg  [3:0] checkterm;
  wire [3:0] checkterm_int_0;
  wire [3:0] checkterm_int_1;

  wire [31:0] rx_data_fixed_0;
  wire [31:0] rx_data_fixed_1;
  wire  [3:0] rx_isk_fixed_0;
  wire  [3:0] rx_isk_fixed_1;

  /* fix term performs check_end function as well as idle translation */
  fix_term fix_term_0(
    .data_i(rx_data_0),
    .isk_i(rx_isk_0),
    .data_o(rx_data_fixed_0),
    .isk_o(rx_isk_fixed_0),
    .disperr({disperr[6], disperr[4], disperr[2], disperr[0]}),
    .current_term(checkterm),
    .next_term(checkterm_int_0)
  );

  fix_term fix_term_1(
    .data_i(rx_data_1),
    .isk_i(rx_isk_1),
    .data_o(rx_data_fixed_1),
    .isk_o(rx_isk_fixed_1),
    .disperr({disperr[7], disperr[5], disperr[3], disperr[1]}),
    .current_term(checkterm_int_0),
    .next_term(checkterm_int_1)
  );

  wire [31:0] xgmii_rxd_0;
  wire [31:0] xgmii_rxd_1;
  wire  [3:0] xgmii_rxc_0;
  wire  [3:0] xgmii_rxc_1;

  /* 
     If the xaui is in reset or if the link is not up, output the magic link broken word (32'h0100009c)
     otherwise output the corrected data
  */

  assign xgmii_rxd_0 = !align_status || reset ? 32'h0100009c :
                                                rx_data_fixed_0;

  assign xgmii_rxc_0 = !align_status || reset ? 4'b0001 :
                                                rx_isk_fixed_0;

  assign xgmii_rxd_1 = !align_status || reset ? 32'h0100009c :
                                                rx_data_fixed_1;

  assign xgmii_rxc_1 = !align_status || reset ? 4'b0001 :
                                                rx_isk_fixed_1;

  assign xgmii_rxd = {xgmii_rxd_1, xgmii_rxd_0};
  assign xgmii_rxc = {xgmii_rxc_1, xgmii_rxc_0};

  always @(posedge clk) begin
    if (reset) begin
      checkterm <= 4'b0;
    end else begin
      checkterm <= checkterm_int_1;
    end
  end

endmodule

