module reset_adc (
  clock,
	reset,
	reset_req,
	reset_line,
	done
);

// System Parameters
//==================
parameter RESET_LENGTH = 10; // cycles

// Inputs and Outputs
//===================
input clock;
input reset;
input reset_req;
output reg reset_line;
output reg done;

// Wires and Regs
//===============
reg [2:0] STATE, NEXT_STATE;
reg [7:0] reset_count;
reg reset_count_en;
reg reset_count_rst;

// Module Declarations
//====================

// 8-bit clock for tracking reset pulse length
always @ (posedge clock) begin
	if (reset | reset_count_rst) begin
		reset_count <= 8'b0;
	end else if (reset_count_en) begin
		reset_count <= reset_count + 1;
	end
end

// FSM
//====
parameter STATE_IDLE = 0;
parameter STATE_RESET = 1;

always @ (posedge clock) begin
	if (reset) begin
		STATE <= STATE_IDLE;
	end else begin
		STATE <= NEXT_STATE;
	end
end

always @ ( * ) begin
	reset_line = 0;
	done = 0;
	reset_count_rst = 0;
	reset_count_en = 0;
	case (STATE)
		STATE_IDLE: begin
			done = 1;
			reset_count_rst = 1;
			if (reset_req) begin
				reset_count_en = 1;
				NEXT_STATE = STATE_RESET;
			end
		end

		STATE_RESET: begin
			reset_count_en = 1;
			reset_line = 1;
			if (reset_count == RESET_LENGTH) begin
				NEXT_STATE= STATE_IDLE;
			end
		end
	endcase
end

endmodule
