`include "xaui_kat.vh"

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

  wire got_align = rxisk_0 == 4'b1111 && rxdata_0 == {4{`SYM_A_}} ||
                   rxisk_0 == 4'b1111 && rxdata_0 == {4{`SYM_A_}};

  reg  [2:0] state;

  wire enable_dekew_0;
  wire enable_dekew_1;
  assign enable_deskew = enable_dekew_0 | enable_dekew_1;

  wire align_status_0;
  wire align_status_1;
  assign align_status = align_status_0 | align_status_1;

`define DESKEW_STATE_LOSS_OF_ALIGNMENT 3'd0
`define DESKEW_STATE_ALIGN_DETECT_1    3'd1
`define DESKEW_STATE_ALIGN_DETECT_2    3'd2
`define DESKEW_STATE_ALIGN_DETECT_3    3'd3
`define DESKEW_STATE_ALIGN_ACQUIRED_1  3'd4
`define DESKEW_STATE_ALIGN_ACQUIRED_2  3'd5
`define DESKEW_STATE_ALIGN_ACQUIRED_3  3'd6
`define DESKEW_STATE_ALIGN_ACQUIRED_4  3'd7

  function [2:0] nstate;
  input [2:0] cstate;
  input got_align;
  input align_error;

  begin
    case (cstate)
      `DESKEW_STATE_LOSS_OF_ALIGNMENT: begin
        nstate = got_align ? `DESKEW_STATE_ALIGN_DETECT_1 : cstate;
      end
      `DESKEW_STATE_ALIGN_DETECT_1: begin
        nstate = got_align ? `DESKEW_STATE_ALIGN_DETECT_2 : align_error ? `DESKEW_STATE_LOSS_OF_ALIGNMENT : cstate;
      end
      `DESKEW_STATE_ALIGN_DETECT_2: begin
        nstate = got_align ? `DESKEW_STATE_ALIGN_DETECT_3 : align_error ? `DESKEW_STATE_LOSS_OF_ALIGNMENT : cstate;
      end
      `DESKEW_STATE_ALIGN_DETECT_3: begin
        nstate = got_align ? `DESKEW_STATE_ALIGN_ACQUIRED_1 : align_error ? `DESKEW_STATE_LOSS_OF_ALIGNMENT : cstate;
      end
      `DESKEW_STATE_ALIGN_ACQUIRED_1: begin
        nstate = align_error ? `DESKEW_STATE_ALIGN_ACQUIRED_2 : cstate;
      end
      `DESKEW_STATE_ALIGN_ACQUIRED_2: begin
        nstate = align_error ? `DESKEW_STATE_ALIGN_ACQUIRED_3 : got_align ? `DESKEW_STATE_ALIGN_ACQUIRED_1 : cstate;
      end
      `DESKEW_STATE_ALIGN_ACQUIRED_3: begin
        nstate = align_error ? `DESKEW_STATE_ALIGN_ACQUIRED_4 : got_align ? `DESKEW_STATE_ALIGN_ACQUIRED_2 : cstate;
      end
      `DESKEW_STATE_ALIGN_ACQUIRED_4: begin
        nstate = align_error ? `DESKEW_STATE_LOSS_OF_ALIGNMENT : got_align ? `DESKEW_STATE_ALIGN_ACQUIRED_3 : cstate;
      end
      default: begin
        nstate = `DESKEW_STATE_LOSS_OF_ALIGNMENT;
      end
    endcase
  end
  endfunction

  always @(posedge clk) begin
    if (reset || sync_status != 4'b1111) begin
      state <= `DESKEW_STATE_LOSS_OF_ALIGNMENT;
    end else begin
      state <= nstate(state, got_align, |disp_err);
    end
  end
  assign enable_deskew = state == `DESKEW_STATE_LOSS_OF_ALIGNMENT;

  assign align_status = state == `DESKEW_STATE_ALIGN_ACQUIRED_1 ||
                        state == `DESKEW_STATE_ALIGN_ACQUIRED_2 ||
                        state == `DESKEW_STATE_ALIGN_ACQUIRED_3 ||
                        state == `DESKEW_STATE_ALIGN_ACQUIRED_4;

endmodule
