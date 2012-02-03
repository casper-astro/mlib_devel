`define SYNC_STATE_LOSS_OF_SYNC    4'd0
`define SYNC_STATE_COMMA_DET_1     4'd1
`define SYNC_STATE_COMMA_DET_2     4'd2
`define SYNC_STATE_COMMA_DET_3     4'd3
`define SYNC_STATE_SYNC_AQUIRED_1  4'd4
`define SYNC_STATE_SYNC_AQUIRED_2  4'd5
`define SYNC_STATE_SYNC_AQUIRED_3  4'd6
`define SYNC_STATE_SYNC_AQUIRED_4  4'd7
`define SYNC_STATE_SYNC_AQUIRED_2A 4'd8
`define SYNC_STATE_SYNC_AQUIRED_3A 4'd9
`define SYNC_STATE_SYNC_AQUIRED_4A 4'd10

module sync_state(
    reset,
    current_state,
    next_state,
    current_good_cgs,
    next_good_cgs,
    next_enable_align,
    next_lanesync,
    commadet,
    codevalid,
    rxlock,
    signal_detect
  );
  input  reset;
  input  [3:0] current_state;
  output [3:0] next_state;
  input  [1:0] current_good_cgs;
  output [1:0] next_good_cgs;
  output next_enable_align;
  output next_lanesync;
  input  commadet;
  input  codevalid;
  input  rxlock;
  input  signal_detect;

  function [3:0] nstate;
  input [3:0] cstate;
  input commadet;
  input codevalid;
  input signal_detect;
  input rxlock;
  input reset;
  input [1:0] good_cgs;
  begin
    if (reset || |(~rxlock) || |(~signal_detect)) begin
      nstate = `SYNC_STATE_LOSS_OF_SYNC;
    end else begin
      case (cstate)
        `SYNC_STATE_LOSS_OF_SYNC: begin
          nstate = ~codevalid ? `SYNC_STATE_LOSS_OF_SYNC : commadet ? `SYNC_STATE_COMMA_DET_1 : cstate;
        end
        `SYNC_STATE_COMMA_DET_1: begin
          nstate = ~codevalid ? `SYNC_STATE_LOSS_OF_SYNC : commadet ? `SYNC_STATE_COMMA_DET_2 : cstate;
        end
        `SYNC_STATE_COMMA_DET_2: begin
          nstate = ~codevalid ? `SYNC_STATE_LOSS_OF_SYNC : commadet ? `SYNC_STATE_COMMA_DET_3 : cstate;
        end
        `SYNC_STATE_COMMA_DET_3: begin
          nstate = ~codevalid ? `SYNC_STATE_LOSS_OF_SYNC : commadet ? `SYNC_STATE_SYNC_AQUIRED_1 : cstate;
        end
        `SYNC_STATE_SYNC_AQUIRED_1: begin
          nstate = ~codevalid ? `SYNC_STATE_SYNC_AQUIRED_2 : cstate;
        end
        `SYNC_STATE_SYNC_AQUIRED_2: begin
          nstate = ~codevalid ? `SYNC_STATE_SYNC_AQUIRED_3 : `SYNC_STATE_SYNC_AQUIRED_2A;
        end
        `SYNC_STATE_SYNC_AQUIRED_3: begin
          nstate = ~codevalid ? `SYNC_STATE_SYNC_AQUIRED_4 : `SYNC_STATE_SYNC_AQUIRED_3A;
        end
        `SYNC_STATE_SYNC_AQUIRED_4: begin
          nstate = ~codevalid ? `SYNC_STATE_LOSS_OF_SYNC : `SYNC_STATE_SYNC_AQUIRED_4A;
        end
        `SYNC_STATE_SYNC_AQUIRED_2A: begin
          nstate = ~codevalid ? `SYNC_STATE_SYNC_AQUIRED_3 : good_cgs == 2'b11 ? `SYNC_STATE_SYNC_AQUIRED_1 : cstate;
        end
        `SYNC_STATE_SYNC_AQUIRED_3A: begin
          nstate = ~codevalid ? `SYNC_STATE_SYNC_AQUIRED_4 : good_cgs == 2'b11 ? `SYNC_STATE_SYNC_AQUIRED_2 : cstate;
        end
        `SYNC_STATE_SYNC_AQUIRED_4A: begin
          nstate = ~codevalid ? `SYNC_STATE_LOSS_OF_SYNC : good_cgs == 2'b11 ? `SYNC_STATE_SYNC_AQUIRED_3 : cstate;
        end
        default: begin
          nstate = `SYNC_STATE_LOSS_OF_SYNC;
        end
      endcase
    end
  end
  endfunction

  assign next_state = nstate(current_state, commadet, codevalid, signal_detect, rxlock, reset, current_good_cgs);

  assign next_enable_align = current_state == `SYNC_STATE_LOSS_OF_SYNC;
  
  assign next_lanesync = (current_state != `SYNC_STATE_LOSS_OF_SYNC && current_state != `SYNC_STATE_COMMA_DET_1 &&
                          current_state != `SYNC_STATE_COMMA_DET_2  && current_state != `SYNC_STATE_COMMA_DET_3);

  assign next_good_cgs = reset || current_state == `SYNC_STATE_SYNC_AQUIRED_2 || current_state == `SYNC_STATE_SYNC_AQUIRED_3 ||
                         current_state == `SYNC_STATE_SYNC_AQUIRED_4 ? 2'b00 :
                         current_state == `SYNC_STATE_SYNC_AQUIRED_4A || current_state == `SYNC_STATE_SYNC_AQUIRED_3A ||
                         current_state == `SYNC_STATE_SYNC_AQUIRED_2A ? current_good_cgs + 1 : current_good_cgs;
                         
endmodule
