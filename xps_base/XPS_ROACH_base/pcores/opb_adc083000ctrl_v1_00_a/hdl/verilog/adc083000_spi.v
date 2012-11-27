module adc083000_spi(
  input sclk,
  input reset,
  input [15:0] config_data,
  input [3:0]  config_addr,
  input config_start,
  output sdata,
  output reg chip_sel
);

parameter fixed_header_pattern = 12'h001;

// Wires and Regs
wire [31:0] serial_iface_word;

reg						shift_register_load;
reg         shift_register_en;
reg						shift_register_rst;

reg 					shift_count_rst;
wire [5:0] 		shift_count;

assign  serial_iface_word = {fixed_header_pattern, config_addr, config_data};

// Shift register for serialization
ShiftRegister #(
	.pwidth(32),
	.swidth(1)
)
ps_conv(
	.PIn( serial_iface_word ),
	.SIn(0),
	.POut(),
	.SOut(sdata),
	.Load(shift_register_load),
	.Enable(shift_register_en),
	.Clock( sclk  ),
	.Reset(shift_register_rst || reset)
);

Counter #(
  .width(6)
)
shift_counter(
	.Clock( sclk ), 
	.Reset( shift_count_rst || reset ), 
	.Set(0), 
	.Load(0), 
	.Enable( shift_register_en ), 
	.In(0), 
	.Count( shift_count )
);


reg [5:0] state, next_state;
parameter state_idle = 6'd0;
parameter state_load = 6'd1;
parameter state_shift = 6'd2;

// State Update
//=================
always @ (posedge sclk or posedge reset) begin
	if (reset) begin
		state <= state_idle;
	end else begin
		state <= next_state;
	end
end


// Next-state Logic
//=================
always @ (*) begin
	shift_register_load = 0;
	shift_register_en = 0;
	shift_register_rst = 0;
	chip_sel = 0;
	shift_count_rst = 1;
	next_state = state;
	case (state)
		state_idle: begin
			shift_register_rst = 1;
			if (config_start) begin
				next_state = state_load;
			end
		end

		state_load: begin
			chip_sel = 1;
			shift_register_load = 1;
			next_state = state_shift;
//			shift_count_rst = 1;
		end

		state_shift: begin
			chip_sel = 1;
			shift_register_en = 1;
			shift_count_rst = 0;
			if (shift_count == 6'd31) begin
				next_state = state_idle;
			end
		end

  endcase
end

endmodule