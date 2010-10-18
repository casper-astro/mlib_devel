 
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
wire [3:0] 		sys_clk_cnt;
wire sclk;
wire sdata;
wire chip_sel;

wire [31:0] serial_iface_word;
wire [15:0] config_data;
wire [3:0]  config_addr;
wire [7:0]  config_metadata;

wire config_trig;
wire config_trig_dly;
wire config_start;



// Continuous assigns
assign sclk = sys_clk_cnt[3];
assign adc0_sclk = sclk;
assign adc1_sclk = sclk;
assign config_metadata = sdata_bus[31:24];
assign config_data = sdata_bus[15:0];
assign config_addr = sdata_bus[19:16];
assign config_trig = config_metadata[0];
assign config_start = config_trig & ~config_trig_dly;

// Chip pin assigns
assign adc0_notSCS = config_metadata[1] & chip_sel;
assign adc1_notSCS = config_metadata[2] & chip_sel;
assign adc0_sdata = sdata;
assign adc1_sdata = sdata;

// Module Declarations
//====================
// Generate a serial clock at 125/4 MHz
Counter #(
	.width(4)
)
sys_clk_counter(
	.Clock(sys_clk), 
	.Reset( reset ), 
	.Set(0), 
	.Load(0), 
	.Enable(1'b1), 
	.In(0), 
	.Count(sys_clk_cnt)
);

// SPI for serial control 
adc083000_spi spi(
  .sclk( sclk ),
  .reset( reset ),
  .config_data( sdata_bus[15:0] ),
  .config_addr( sdata_bus[19:16] ),
  .config_start( config_start ),
  .sdata( sdata ),
  .chip_sel( chip_sel )
);

// Posedge detector for config_start
Register config_trig_delay(
  .Clock( sclk ),
  .Reset( reset ),
  .Set( 0 ),
  .Enable( 1 ),
  .In( config_trig ),
  .Out( config_trig_dly )
);


endmodule
