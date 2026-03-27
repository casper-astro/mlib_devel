/* note for avalon interface
	bus type: nagtive
	read legacy = 0 (to consistent to FIFO)

*/

module adc_ltc2308_fifo #(
    parameter [2:0] DEFAULT_CH = 3'd0
  )(
	// avalon slave port
	slave_clk,
	slave_reset_n,
	slave_chipselect_n,
	slave_addr,
	slave_read_n,
	slave_wrtie_n,
	slave_readdata,
	slave_wriredata,
	
	// adc_clk, // max 40mhz
	// adc interface
	ADC_CONVST,
	ADC_SCK,
	ADC_SDI,
	ADC_SDO
);

	// avalon slave port
input									slave_clk;
input									slave_reset_n;
input									slave_chipselect_n;
input				  					slave_addr;
input									slave_read_n;
input									slave_wrtie_n;
output	reg	[15:0]			slave_readdata;
input				[15:0]			slave_wriredata;



// input								adc_clk;

output		          		ADC_CONVST;
output		          		ADC_SCK;
output	            		ADC_SDI;
input 		          		ADC_SDO;


////////////////////////////////////
// avalon slave port
`define WRITE_REG_START_CH				0
`define WRITE_REG_MEASURE_NUM			1

// write for control
reg   [11:0] 	measure_fifo_num;
reg	[2:0]		measure_fifo_ch;
reg            continuous_mode;
reg            start_pulse;

///////////////////////
// read 
`define READ_REG_MEASURE_DONE	0
`define READ_REG_ADC_VALUE		1
wire slave_read_status;
wire slave_read_data;


assign slave_read_status = (~slave_chipselect_n && ~slave_read_n && slave_addr == `READ_REG_MEASURE_DONE) ?1'b1:1'b0;
assign slave_read_data = (~slave_chipselect_n && ~slave_read_n && slave_addr == `READ_REG_ADC_VALUE) ?1'b1:1'b0;

reg measure_fifo_done;

always @* begin
  slave_readdata = 16'h0000;

  if (~slave_chipselect_n && ~slave_read_n) begin
    if (slave_addr == `READ_REG_MEASURE_DONE) begin
      slave_readdata = {13'b0, fifo_wrfull, fifo_rdempty, measure_fifo_done};
    end else begin // READ_REG_ADC_VALUE
      slave_readdata = fifo_rdempty ? 16'h0000 : {4'b0, fifo_q};
    end
  end
end

//always @(posedge slave_clk) begin
//  if (!slave_reset_n) begin
//    slave_readdata <= 16'h0000;
//  end else if (slave_read_status) begin
//    slave_readdata <= {13'b0, fifo_wrfull, fifo_rdempty, measure_fifo_done};
//  end else if (slave_read_data) begin
//    slave_readdata <= fifo_rdempty ? 16'h0000 : {4'b0, fifo_q};
//  end else begin
//    slave_readdata <= 16'h0000;
//  end
// end

///////////////////////////////////////
// FIFO
wire fifo_wrfull;
wire fifo_rdempty;
wire  fifo_wrreq;
wire [11:0]	 fifo_q;
wire fifo_rdreq;

// read ack for adc data. (note. Slave_read_data is read lency=2, so slave_read_data is assert two clock)
//assign fifo_rdreq = (pre_slave_read_data & slave_read_data)?1'b1:1'b0;

// One rdreq pulse on rising edge of slave_read_data (Avalon read of data register)
// One rdreq pulse on rising edge of an Avalon read of the DATA register
wire rd_data = (~slave_chipselect_n) && (~slave_read_n) &&
               (slave_addr == `READ_REG_ADC_VALUE);

reg rd_data_d;
always @(posedge slave_clk or negedge slave_reset_n) begin
  if (!slave_reset_n) rd_data_d <= 1'b0;
  else                rd_data_d <= rd_data;
end

wire rd_pulse = rd_data & ~rd_data_d;

// Pop exactly when SW reads DATA and FIFO is not empty
assign fifo_rdreq = rd_pulse & ~fifo_rdempty;


reg [15:0] por_cnt = 0;
reg        por_aclr = 1'b1;

always @(posedge slave_clk or negedge slave_reset_n) begin
  if (!slave_reset_n) begin
    por_cnt  <= 16'd0;
    por_aclr <= 1'b1;
  end else if (por_cnt != 16'd1023) begin
    por_cnt  <= por_cnt + 1'b1;
    por_aclr <= 1'b1;
  end else begin
    por_aclr <= 1'b0;
  end
end

//wire wr_ctrl = (~slave_chipselect_n) && (~slave_wrtie_n) && (slave_addr == 1'b0);
//wire wr_data = (~slave_chipselect_n) && (~slave_wrtie_n) && (slave_addr == 1'b1);

////////////////////////////////////
// create triggle message: adc_reset_n


////////////////////////////////////
// control measure_start 
localparam [2:0]
    MS_IDLE     = 3'd0,
    MS_START    = 3'd1,
    MS_WAITDONE = 3'd2,
    MS_HOLDFULL = 3'd3,
    MS_DONE     = 3'd4;

reg [2:0] ms_state;

reg [11:0] measure_count;
reg        config_first;
reg        measure_start;

// You already generate fifo_wrreq below; define a helper:
wire measure_done;
wire [11:0] measure_dataread;

always @(posedge slave_clk or negedge slave_reset_n) begin
  if (!slave_reset_n) begin
    continuous_mode <= 1'b0;
    measure_fifo_ch <= DEFAULT_CH;
    measure_fifo_num <= 12'd0;
    start_pulse <= 1'b0;
  end else begin
    start_pulse <= 1'b0; // default

    if (~slave_chipselect_n && ~slave_wrtie_n && slave_addr == `WRITE_REG_START_CH) begin
      continuous_mode <= slave_wriredata[4];
      measure_fifo_ch <= slave_wriredata[3:1];
      if (slave_wriredata[0]) start_pulse <= 1'b1;
    end

    if (~slave_chipselect_n && ~slave_wrtie_n && slave_addr == `WRITE_REG_MEASURE_NUM) begin
      measure_fifo_num <= slave_wriredata[11:0];
    end
  end
end

reg pre_measure_done;

always @(posedge slave_clk or negedge slave_reset_n) begin
  if (!slave_reset_n) begin
    pre_measure_done <= 1'b0;
  end else if (start_pulse) begin
    pre_measure_done <= 1'b0;   // re-arm edge detector on each start
  end else begin
    pre_measure_done <= measure_done;
  end
end

wire measure_done_rise = (~pre_measure_done) & measure_done;
assign fifo_wrreq = measure_done_rise & ~config_first & ~fifo_wrfull;

// Power-on reset for FIFO (since slave_reset_n never asserts)
reg [15:0] fifo_rst_cnt = 16'd0;
reg       fifo_aclr    = 1'b0;
wire fifo_reset = por_aclr | fifo_aclr;

always @(posedge slave_clk) begin
  if (start_pulse) begin
    fifo_aclr    <= 1'b1;      // assert FIFO reset
    fifo_rst_cnt <= 16'd255;     // hold reset for 256 cycles
  end else if (fifo_aclr) begin
    if (fifo_rst_cnt == 0) begin
      fifo_aclr <= 1'b0;       // release reset
    end else begin
      fifo_rst_cnt <= fifo_rst_cnt - 1'b1;
    end
  end
end

// Treat 0 as "1 sample" to avoid (N-1) underflow and weird stop behavior
wire [11:0] burst_len = (measure_fifo_num == 12'd0) ? 12'd1 : measure_fifo_num;

wire wrote_sample = fifo_wrreq;   // fifo_wrreq already includes ~config_first & ~fifo_wrfull and done edge

always @(posedge slave_clk or negedge slave_reset_n) begin
  if (!slave_reset_n) begin
    ms_state          <= MS_IDLE;
    measure_start     <= 1'b0;
    config_first      <= 1'b1;
    measure_count     <= 12'd0;
    measure_fifo_done <= 1'b0;
  end else begin
    measure_start <= 1'b0;   // default

    // synchronous "arm/reset" conditions
    if (fifo_reset || start_pulse) begin
      ms_state          <= MS_IDLE;
      measure_start     <= 1'b0;
      config_first      <= 1'b1;
      measure_count     <= 12'd0;
      measure_fifo_done <= 1'b0;
    end else begin
      case (ms_state)
        MS_IDLE: begin
          if (measure_fifo_done) begin
            ms_state <= MS_DONE;
          end else if (fifo_wrfull) begin
            ms_state <= MS_HOLDFULL;
          end else begin
            ms_state <= MS_START;
          end
        end

        MS_START: begin
          // one-cycle start pulse into adc_ltc2308
          measure_start <= 1'b1;
          ms_state      <= MS_WAITDONE;
        end

        MS_WAITDONE: begin
          if (measure_done) begin
            if (config_first) begin
              // first conversion after reset/start is "config", don't store
              config_first <= 1'b0;
              ms_state     <= MS_IDLE;
            end else if (fifo_wrfull) begin
              // can't accept sample; pause until space
              ms_state <= MS_HOLDFULL;
            end else begin
              // sample should be written via fifo_wrreq pulse
              if (!continuous_mode) begin
                if (wrote_sample) begin
                  if (measure_count == (burst_len - 12'd1)) begin
                    measure_fifo_done <= 1'b1;
                    ms_state          <= MS_DONE;
                  end else begin
                    measure_count <= measure_count + 12'd1;
                    ms_state      <= MS_IDLE;
                  end
                end else begin
                  // extremely unlikely, but safe fallback
                  ms_state <= MS_HOLDFULL;
                end
              end else begin
                // continuous: just keep going
                ms_state <= MS_IDLE;
              end
            end
          end
        end
        MS_HOLDFULL: begin
          if (!fifo_wrfull) ms_state <= MS_IDLE;
        end

        MS_DONE: begin
          // stay here until next start_pulse or fifo_reset (handled above)
          ms_state <= MS_DONE;
        end

        default: ms_state <= MS_IDLE;
      endcase
    end
  end
end


///////////////////////////////////////
// SPI

adc_ltc2308 adc_ltc2308_inst(
    .clk(slave_clk),
	 .rst_n(~fifo_reset),
    .measure_start(measure_start),
    .measure_done(measure_done),
    .measure_ch(measure_fifo_ch),
    .measure_dataread(measure_dataread),
    .ADC_CONVST(ADC_CONVST),
    .ADC_SCK(ADC_SCK),
    .ADC_SDI(ADC_SDI),
    .ADC_SDO(ADC_SDO)
);

	
adc_data_fifo adc_data_fifo_inst(
  .aclr(fifo_reset),
  .data(measure_dataread),
  .rdclk(slave_clk),
  .rdreq(fifo_rdreq),
  .wrclk(slave_clk),
  .wrreq(fifo_wrreq),
  .q(fifo_q),
  .rdempty(fifo_rdempty),
  .wrfull(fifo_wrfull)
);


endmodule