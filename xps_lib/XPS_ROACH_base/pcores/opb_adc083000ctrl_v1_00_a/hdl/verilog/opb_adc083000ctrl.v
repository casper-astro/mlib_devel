 
module opb_adc083000ctrl(
	input sys_clk,
	input reset,
	input [2:0] conf,
	input [31:0] sdata_bus,
	
	output adc0_notSCS,
	output adc0_sclk,
	output adc0_sdata,
	output adc1_notSCS,
	output adc1_sclk,
	output adc1_sdata
);


// Wires and Regs
//===============
wire [3:0] sys_clk_cnt;
reg spi_reset;
wire spi_sdata;
wire spi_done;
reg adc_ctrl_notSCS, adc_ctrl_sdata;
assign adc0_sdata = adc_ctrl_sdata;
assign adc1_sdata = adc_ctrl_sdata;
assign adc0_notSCS = adc_ctrl_notSCS & conf[1];
assign adc1_notSCS = adc_ctrl_notSCS & conf[2];

// Module Declarations
//====================
// Generate a serial clock at 125/4 MHz
Counter sys_clk_counter(.Clock(sys_clk), .Reset(1'b0), .Set(0), .Load(0), .Enable(1'b1), .In(0), .Count(sys_clk_cnt));
defparam sys_clk_counter.width = 4;

assign adc0_sclk = sys_clk_cnt[3];
assign adc1_sclk = sys_clk_cnt[3];

spi32 spi( .spi_clk(adc_ctrl_clk), .reset(spi_reset), .pdata(sdata_bus), .sdata(spi_sdata), .done(spi_done));

/// TODO: add edge detector on LSB of conf
// mux the SCS lines

// State Update Mux
//=================
parameter state_idle = 4'd0;
parameter state_chip_sel = 4'd1;
parameter state_start_spi = 4'd2;
reg [3:0] state, next_state;
always @ (posedge adc0_sclk) begin
	if (reset) begin
		state <= state_idle;
	end else begin
		state <= next_state;
	end
end



// Next-state Logic
//=================
always @ (*) begin
	adc_ctrl_notSCS = 0;
	adc_ctrl_sdata = 0;
	spi_reset = 0;
	case(state)
		state_idle: begin
			if (conf) begin
				next_state = state_chip_sel;
			end
		end

		state_chip_sel: begin
			adc_ctrl_notSCS = 1;
			next_state = state_start_spi;
			spi_reset = 1;
		end

		state_start_spi: begin
			adc_ctrl_sdata = spi_sdata;
			if (spi_done) begin
				next_state = state_idle;
			end 
		end

		default: begin
			next_state = state_idle;
		end
	endcase
end

endmodule

module spi32(
	input spi_clk, 
	input reset, 
	input [31:0] pdata,
	output sdata,
	output done
);

wire [4:0] sdata_index;
Counter index_counter(.Clock(spi_clk), .Reset(1'b0), .Set(0), .Load(0), .Enable(1'b1), .In(0), .Count(sdata_index));
defparam index_counter.limited = 1;
defparam index_counter.width = 5;
assign sdata = pdata[sdata_index];
assign done = sdata_index == 31;

endmodule
