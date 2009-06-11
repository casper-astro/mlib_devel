module negedge_detect(
  clock,
  reset,
  din,
  en,
  falling_edge_detected
);

// System Parameters
//==================
parameter WIDTH = 1;


// Inputs and Outputs
//===================
input clock;
input reset;
input [WIDTH-1:0] din;
input en;
output reg falling_edge_detected;

// Wires and Regs
//===============
reg Q;

// FSM
//====
always @ (posedge clock) begin
  if (reset) begin
    Q <= 0;
  end else if (en) begin
    Q <= din;
  end
end

always @ (posedge clock) begin
  if (reset) begin
    falling_edge_detected <= 0;
  end else if (Q && (~din && en)) begin
    falling_edge_detected <= 1;
  end
end

endmodule
    