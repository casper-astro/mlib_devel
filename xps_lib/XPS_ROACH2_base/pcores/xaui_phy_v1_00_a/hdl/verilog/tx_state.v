`include "xaui_kat.vh"

`define IFG_A         1'b0
`define IFG_K         1'b1

`define SEND_DATA     0 //not used
`define SEND_A        1
`define SEND_K        2
`define SEND_Q        3
`define SEND_RANDOM_R 4
`define SEND_RANDOM_K 5
`define SEND_RANDOM_A 6
`define SEND_RANDOM_Q 7

module tx_state(
  reset,
  a_cnt, code_sel, a_send,
  current_state, next_state,
  current_ifg, current_q_det,
  next_ifg, next_q_det,
  txdata_i, txcharisk_i,
  txdata_o, txcharisk_o,
  link_status_event, link_status
  );
  input  reset;
  input   [4:0] a_cnt;
  input  code_sel;
  input   [2:0] current_state;
  output  [2:0] next_state;
  input  current_ifg, current_q_det;
  output next_ifg, next_q_det, a_send;
  input  [31:0] txdata_i;
  input   [3:0] txcharisk_i;
  output [31:0] txdata_o;
  output  [3:0] txcharisk_o;
  
  input  link_status_event;
  input  [31:0] link_status;

  wire got_tx_data = txdata_i != {4{8'h07}};

  function [2:0] nstate;
  input [2:0] cstate;
  input ifg;
  input code_sel;
  input [4:0] a_cnt;
  input q_det;
  input got_tx_data;
  input reset;
  begin
    nstate = `SEND_RANDOM_R;
    if (reset) begin
      nstate = `SEND_RANDOM_R;
    end else if (got_tx_data) begin
      nstate = ifg == `IFG_K || a_cnt == 5'b0 ? `SEND_K : `SEND_A;
    end else begin
      case (cstate)
        `SEND_K: begin
          nstate = `SEND_RANDOM_R;
        end
        `SEND_A: begin
          nstate = q_det ? `SEND_Q : `SEND_RANDOM_R;
        end
        `SEND_Q: begin
          nstate = `SEND_RANDOM_R;
        end
        `SEND_RANDOM_R: begin
          nstate = a_cnt != 5'b0 && code_sel ? `SEND_RANDOM_R : 
                       a_cnt == 5'b0 ? `SEND_RANDOM_A : `SEND_RANDOM_K ;
        end
        `SEND_RANDOM_K: begin
          nstate = a_cnt == 5'b0 ? `SEND_RANDOM_A :
                       code_sel ? `SEND_RANDOM_R : `SEND_RANDOM_K;
        end
        `SEND_RANDOM_A: begin
          nstate = q_det ? `SEND_RANDOM_Q :
                       code_sel ? `SEND_RANDOM_R : `SEND_RANDOM_K;
        end
        `SEND_RANDOM_Q: begin
          nstate = code_sel ? `SEND_RANDOM_R : `SEND_RANDOM_K;
        end
        default: begin
          nstate = nstate;
        end
      endcase
    end
  end
  endfunction

  function [31:0] idle_convert;
  input [31:0] data; 
  input  [3:0] isk; 
  begin
    idle_convert = { isk[3] && data[31:24] == `XAUI_IDLE_ ? `SYM_K_ : data[31:24] ,
                     isk[2] && data[23:16] == `XAUI_IDLE_ ? `SYM_K_ : data[23:16] ,
                     isk[1] && data[15:8 ] == `XAUI_IDLE_ ? `SYM_K_ : data[15:8 ] ,
                     isk[0] && data[ 7:0 ] == `XAUI_IDLE_ ? `SYM_K_ : data[ 7:0 ] };
  end
  endfunction

  assign next_state = nstate(current_state, current_ifg, code_sel, a_cnt, current_q_det, got_tx_data, reset);

  assign next_ifg   = (current_state ==`SEND_K || reset) ? `IFG_A : current_state == `SEND_A ? `IFG_K : current_ifg;

  assign next_q_det  = reset ? 1'b0 : 
                       link_status_event ? 1'b1 :
                       current_state == `SEND_RANDOM_Q ? 1'b0 :
                       current_state == `SEND_Q ? 1'b0 :
                       current_q_det;

  assign a_send = reset ? 1'b0 : txdata_o == {4{`SYM_A_}};

  assign txdata_o    = reset ? {4{`SYM_K_}} :
                       got_tx_data ? idle_convert(txdata_i, txcharisk_i) : 
                       current_state == `SEND_RANDOM_Q || current_state == `SEND_Q ? link_status :
                       current_state == `SEND_RANDOM_K || current_state == `SEND_K ? {4{`SYM_K_}} :
                       current_state == `SEND_RANDOM_R ? {4{`SYM_R_}} : 
                       current_state == `SEND_RANDOM_A ? {4{`SYM_A_}} :
                       {4{`SYM_K_}};

  assign txcharisk_o  = reset ? {4'b1111} :
                        got_tx_data ? txcharisk_i : 
                        current_state == `SEND_RANDOM_Q || current_state == `SEND_Q ? 4'b0001 :
                        4'b1111;
                       
endmodule
