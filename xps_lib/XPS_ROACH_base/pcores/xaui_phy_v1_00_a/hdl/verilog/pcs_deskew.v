module pcs_deskew(
    clk, reset, 
    mgt_rxdata, mgt_rxcharisk,
    disp_err,
    sync_status,
    enable_deskew,
    align_status
  );

  input clk, reset;
  input [63:0] mgt_rxdata;
  input  [7:0] mgt_rxcharisk;
  input  [7:0] disp_err;

  input  [3:0] sync_status;
  output enable_deskew;
  output align_status;

  wire [31:0] rxdata_0 = {mgt_rxdata[55:48], mgt_rxdata[39:32], mgt_rxdata[23:16], mgt_rxdata[7:0]};
  wire [31:0] rxdata_1 = {mgt_rxdata[63:56], mgt_rxdata[47:40], mgt_rxdata[31:24], mgt_rxdata[15:8]};

  wire  [3:0] rxisk_0 = {mgt_rxcharisk[6],mgt_rxcharisk[4],mgt_rxcharisk[2],mgt_rxcharisk[0]};
  wire  [3:0] rxisk_1 = {mgt_rxcharisk[7],mgt_rxcharisk[5],mgt_rxcharisk[3],mgt_rxcharisk[1]};

  reg  [2:0] state;
  wire [2:0] state_int_0;
  wire [2:0] state_int_1;

  wire enable_dekew_0;
  wire enable_dekew_1;
  assign enable_deskew = enable_dekew_0 | enable_dekew_1;

  wire align_status_0;
  wire align_status_1;
  assign align_status = align_status_0 | align_status_1;

  deskew_state deskew_state0(
    .reset(reset),
    .current_state(state), .next_state(state_int_0),
    .mgt_rxdata(rxdata_0), .mgt_rxcharisk(rxisk_0), .sync_status(sync_status),
    .disp_err({disp_err[6], disp_err[4], disp_err[2], disp_err[0]}),
    .next_align_status(align_status_0), .next_enable_deskew(enable_dekew_0)
  );

  deskew_state deskew_state1(
    .reset(reset),
    .current_state(state_int_0), .next_state(state_int_1),
    .mgt_rxdata(rxdata_1), .mgt_rxcharisk(rxisk_1), .sync_status(sync_status),
    .disp_err({disp_err[7], disp_err[5], disp_err[3], disp_err[1]}),
    .next_align_status(align_status_1), .next_enable_deskew(enable_dekew_1)
  );

  always @(posedge clk) begin
    state <= state_int_1;
  end

endmodule
