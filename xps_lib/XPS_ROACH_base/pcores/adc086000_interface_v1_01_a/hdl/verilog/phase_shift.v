module phase_shift(
  clock,
  reset, 
  shift_done,
  shift_req,
  shift_count,
  dcm_psen,
  dcm_psincdec,
  dcm_psdone,
  STATE
);

// Inputs and Outputs
//===================
input clock;
input reset;
input shift_req;
input dcm_psdone;

output reg shift_done;
output reg [7:0] shift_count;
output reg dcm_psen;
input dcm_psincdec;
output [3:0] STATE;

// Wires and Regs
//===============
reg [3:0] STATE;
reg [3:0] NEXT_STATE;



// FSM
//====
parameter STATE_DONE = 0;
parameter STATE_SHIFT = 1;
parameter STATE_WAIT = 2;

// up-down counter to count the number of dcm shifts
always @ (posedge clock) begin
  if (reset) begin
    shift_count <= 0;
  end else if (dcm_psincdec & shift_req) begin
    shift_count <= shift_count + 1;
  end else begin
    shift_count <= shift_count - 1;
  end
end
    

always @ (posedge clock) begin
  if (reset) begin
    STATE <= STATE_DONE;
  end else begin
    STATE <= NEXT_STATE;
  end
end

always @ ( * ) begin
  shift_done = 0;
  dcm_psen = 0;
  case (STATE)
    STATE_DONE: begin
      shift_done = 1;
      if (shift_req) begin
        NEXT_STATE = STATE_SHIFT;
        shift_done = 0;
      end
    end
    
    STATE_SHIFT: begin
      dcm_psen = 1;
      NEXT_STATE = STATE_WAIT;
    end      
    
    STATE_WAIT: begin
      if (dcm_psdone) begin
        NEXT_STATE = STATE_DONE;
      end
    end
  endcase 
end

endmodule
