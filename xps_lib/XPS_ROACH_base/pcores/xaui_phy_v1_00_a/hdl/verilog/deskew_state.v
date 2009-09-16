`include "xaui_kat.vh"

`define DESKEW_STATE_LOSS_OF_ALIGNMENT 3'd0
`define DESKEW_STATE_ALIGN_DETECT_1    3'd1
`define DESKEW_STATE_ALIGN_DETECT_2    3'd2
`define DESKEW_STATE_ALIGN_DETECT_3    3'd3
`define DESKEW_STATE_ALIGN_ACQUIRED_1  3'd4
`define DESKEW_STATE_ALIGN_ACQUIRED_2  3'd5
`define DESKEW_STATE_ALIGN_ACQUIRED_3  3'd6
`define DESKEW_STATE_ALIGN_ACQUIRED_4  3'd7

module deskew_state(
    current_state, next_state,
    got_align,
    disp_err,
    aligned
  );
  input   [2:0] current_state;
  output  [2:0] next_state;
  input  got_align;
  input  disp_err;
  output aligned;

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

  assign next_state = nstate(current_state, got_align, disp_err);

  assign aligned = current_state == `DESKEW_STATE_ALIGN_ACQUIRED_1 || current_state == `DESKEW_STATE_ALIGN_ACQUIRED_2 ||
                             current_state == `DESKEW_STATE_ALIGN_ACQUIRED_3 || current_state == `DESKEW_STATE_ALIGN_ACQUIRED_4;

endmodule
