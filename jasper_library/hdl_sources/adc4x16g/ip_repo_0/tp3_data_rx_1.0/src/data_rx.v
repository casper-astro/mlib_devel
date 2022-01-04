`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
/*
Accepts 8 8B/10B encoded DDR streams and a source-synch clock.  Receives and
decodes them, finding the commas indicating word boundaries.  Writes to 8
FIFOs, and allows processor access
*/
//////////////////////////////////////////////////////////////////////////////////


module data_rx(
    input data_clk,
    input rd_clk,
    input [7:0] ser_data,
    input fifo_reset,
    input write_inhibit,
    input [2:0]fifo_sel,
    input fifo_rd,
    output [7:0]fifo_dav,
    output [31:0] fifo_out,
    output [8:0] fifo_data_count0,
    output [8:0] fifo_data_count1,
    output [8:0] fifo_data_count2,
    output [8:0] fifo_data_count3,
    output [8:0] fifo_data_count4,
    output [8:0] fifo_data_count5,
    output [8:0] fifo_data_count6,
    output [8:0] fifo_data_count7,
    input [2:0] tp_select,
    output reg [7:0] testpoints,
    output MMCM_locked
    );
parameter comma_plus = 10'h17c;  //10'h0fa reversed
parameter comma_minus = 10'h283; //10'h305 reversed
//parameter comma_plus = 10'h0fa; 
//parameter comma_minus = 10'h305; 

wire clk_90deg;
  clk_wiz_0 DATA_RX_CLK
   (
   // Clock in ports
    .clk_in1(data_clk),      // input clk_in1- 40MHz only
    // Clock out ports
    .clk_out1(),     // output clk_out1 40MHz, 0 deg
    .clk_out2(clk_90deg),     // output clk_out2 40MHz, -90 deg
    // Status and control signals
    .reset(1'b0), // input reset
    .locked(MMCM_locked));      // output locked

//`define RISEFIRST
//Set of 8 DDR registers
wire [7:0] data_rise;
wire [7:0] data_fall;
genvar gg;
   generate
   for (gg=0; gg < 8; gg=gg+1)
   begin: IDDRs
   IDDR #(
      .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"), // "OPPOSITE_EDGE", "SAME_EDGE" 
                                      //    or "SAME_EDGE_PIPELINED" 
      .INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
      .INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
      .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
   ) IDDR_inst (
      .Q1(data_rise[gg]), // 1-bit output for positive edge of clock 
      .Q2(data_fall[gg]), // 1-bit output for negative edge of clock
      .C(clk_90deg),   // 1-bit clock input
      .CE(1'b1), // 1-bit clock enable input
      .D(ser_data[gg]),   // 1-bit DDR data input
      .R(1'b0),   // 1-bit reset
      .S(1'b0)    // 1-bit set
   );
   end
endgenerate
//Sync the fifo_reset to the write clock.  We'll use this to 
//  reset the byte counter
wire fifo_reset_wr_sync;
sync_input S0
    (.data_in(fifo_reset),
    .data_out(fifo_reset_wr_sync),
    .clk(clk_90deg));

//Set of 8 serial-parallel converters for rising data and 8 for falling data
//Need to look at 10 bits at a time to find the commas
reg [4:0] shiftreg_rise[7:0];
reg [4:0] shiftreg_fall[7:0];

integer ii;
always @ (posedge clk_90deg) begin
    for (ii = 0; ii < 8; ii = ii + 1) begin
        shiftreg_rise[ii] <= {shiftreg_rise[ii][3:0], data_rise[ii]};
        shiftreg_fall[ii] <= {shiftreg_fall[ii][3:0], data_fall[ii]};
    end
end

//Interleave the rise and fall to get 8 10-bit words
//Note that this implies that we can be certain that the LS bit is sampled by the rising edge of the clock
wire [9:0] data_10b[7:0];
generate
    for (gg=0; gg < 8; gg=gg+1)
    begin: DATA10B
    //The data comes out LS bit first. Since shiftreg_rise data comes from the Q1 output of the DDR, 
    // it arrived earlier than the shiftreg_fall data.  So shiftreg_rise[4] is the LS bit of the data
    assign data_10b[gg] = {
        shiftreg_fall[gg][0],shiftreg_rise[gg][0],
        shiftreg_fall[gg][1],shiftreg_rise[gg][1],
        shiftreg_fall[gg][2],shiftreg_rise[gg][2],
        shiftreg_fall[gg][3],shiftreg_rise[gg][3],
        shiftreg_fall[gg][4],shiftreg_rise[gg][4]
        };
    end
endgenerate

//Find the two kinds of comma for all streams
wire [7:0] cplus_found;
wire [7:0] cminus_found;
generate
    for (gg=0; gg < 8; gg=gg+1)
    begin: CFIND
        assign cplus_found[gg] = (data_10b[gg] == comma_plus); 
        assign cminus_found[gg] = (data_10b[gg] == comma_minus); 
    end
endgenerate

//Decode to 8bits
//bit 8 is the control code flag?
wire [8:0] data_9b[7:0];
wire [7:0] dispout;
wire [7:0] code_err;
wire [7:0] disp_err;
wire [7:0] fifo_wr;
wire [7:0] fifo_rd_en;
wire [7:0] fifo_full;
wire [7:0] fifo_empty;
wire [31:0] fifo_data[7:0];
wire [8:0] rd_data_count [7:0];
//prog_full asserts when there is still enough space for one packet
wire [7:0] prog_full;
//We'll set a bit for each FIFO when prog_full or wr_rst_busy goes true,
//  and clear it when a comma is detected, indicating the end of a 6B packet
reg [7:0] write_interrupted;
wire [7:0] wr_rst_busy;
wire [7:0] rd_rst_busy;
generate
    for (gg=0; gg < 8; gg=gg+1)
    begin: DECODE
   decode_10B8B DEC(
  .datain(data_10b[gg]),
  .dispin(1'b0),
  .dataout(data_9b[gg]),
  .dispout(dispout[gg]),
  .code_err(code_err[gg]),
  .disp_err(disp_err[gg])
  );
//Extend the fifo_reset for a few cycles and force wr and rd false
//An 8-in, 32-out FIFO for each channel
fifo_generator_0 DATAFIFO (
      .rst(fifo_reset),        // input wire rst
      .wr_clk(clk_90deg),  // input wire wr_clk
      .rd_clk(rd_clk),  // input wire rd_clk
      .din(data_9b[gg][7:0]),        // input wire [7 : 0] din
      .wr_en(fifo_wr[gg]),    // input wire wr_en
      .rd_en(fifo_rd_en[gg]),    // input wire rd_en
      .dout(fifo_data[gg]),      // output wire [31 : 0] dout
      .rd_data_count(rd_data_count[gg]),  // output wire [8 : 0] rd_data_count
      .full(fifo_full[gg]),      // output wire full
      .empty(fifo_empty[gg]),    // output wire empty
      .prog_full(prog_full[gg]),          // output wire prog_full
      .wr_rst_busy(wr_rst_busy[gg]),  // output wire wr_rst_busy
      .rd_rst_busy(rd_rst_busy[gg])  // output wire rd_rst_busy
    );
end

endgenerate

//Write to the fifo on every word, sync the write to the commas, but don't write the commas
reg [2:0] bit_count[7:0];
//Also keep track of the bytes, so that we make sure the first byte written after an interruption
// is the first byte of a packet
reg [2:0] byte_count[7:0];
//Need to hold off the byte counter after reset until a comma has been detected
//  to insure full packets are written
reg [7:0] hold_byte_count_zero = 0;
always @ (posedge clk_90deg) begin
    for (ii = 0; ii < 8; ii = ii + 1)
    begin
        if (fifo_reset_wr_sync) hold_byte_count_zero[ii] <= 1;
        else if (cplus_found[ii] || cminus_found[ii]) hold_byte_count_zero[ii] <= 0;
        if (cplus_found[ii] || cminus_found[ii]) bit_count[ii] <= 4'h1;
        else if (bit_count[ii] == 3'h4) bit_count[ii] <= 0;
        else bit_count[ii] <= bit_count[ii] + 1;
        if (hold_byte_count_zero[ii]) byte_count[ii] <= 0;
        else if (bit_count[ii] == 3'h0) begin
        //We'll reset the bytecounter at every comma, and wrap back to 0 after 5
            if ((byte_count[ii] == 3'h5) || cplus_found[ii] || cminus_found[ii]) byte_count[ii] <= 3'h0;
            else byte_count[ii] <= byte_count[ii] + 1;
        end
        //When the almost_full flag goes true, need to wait til a complete packet
        //  has been written before stopping the writes
        //When fifo_reset goes true, OK to clobber writes immediately
        if ((byte_count[ii] == 3'h5) && (bit_count[ii] == 3'h0) && prog_full[ii]
            ||wr_rst_busy[ii])write_interrupted[ii] <= 1;
            //if (wr_rst_busy[ii] || prog_full[ii]) write_interrupted[ii] <= 1;
        //Need to wait til a 
        else if ((byte_count[ii] == 3'h5) && (bit_count[ii] == 3'h0)) write_interrupted[ii] <= 0;
    end
end
generate
    for (gg=0; gg < 8; gg=gg+1)
    begin: FWR
        //assign fifo_wr[gg] = (bit_count[gg] == 4'h0) && !fifo_full[gg] && !cplus_found[gg] && !cminus_found[gg] && !wr_rst_busy[gg];
        assign fifo_wr[gg] = (bit_count[gg] == 4'h0) && !cplus_found[gg] && !cminus_found[gg] && !write_interrupted[gg];
    end
endgenerate

//sync the fifo_rd to the read clock and make a pulse
//No need for this- fifo_rd is sync to rd_clk
/*
wire fifo_read_sync;
sync_input S0
    (.data_in(fifo_rd),
    .data_out(fifo_read_sync),
    .clk(rd_clk));
*/
reg fifo_rd_d1;
always @ (posedge rd_clk) fifo_rd_d1 <= fifo_rd;
wire fifo_rd_pulse = fifo_rd && ! fifo_rd_d1;

//MUX the fifo read to the desired FIFO
generate
    for (gg=0; gg < 8; gg=gg+1)
    begin: FRD
        assign fifo_rd_en[gg] = fifo_rd_pulse && (fifo_sel == gg) && !fifo_empty[gg] && !rd_rst_busy[gg];
    end
endgenerate

reg [31:0]fifo_out_reg;
   always @(fifo_sel, fifo_data[0],fifo_data[1],fifo_data[2],fifo_data[3],fifo_data[4],fifo_data[5],fifo_data[6],fifo_data[7])
      case (fifo_sel)
         3'b000: fifo_out_reg = fifo_data[0];
         3'b001: fifo_out_reg = fifo_data[1];
         3'b010: fifo_out_reg = fifo_data[2];
         3'b011: fifo_out_reg = fifo_data[3];
         3'b100: fifo_out_reg = fifo_data[4];
         3'b101: fifo_out_reg = fifo_data[5];
         3'b110: fifo_out_reg = fifo_data[6];
         3'b111: fifo_out_reg = fifo_data[7];
      endcase

assign fifo_dav = ~fifo_empty;	
//Byte-reverse the data to compensate for FIFO ordering	
assign fifo_out = {fifo_out_reg[7:0],fifo_out_reg[15:8],fifo_out_reg[23:16],fifo_out_reg[31:24]};

wire control_code0 = data_9b[0][8];
always @*
    case (tp_select)
        3'h0: testpoints = {control_code0,fifo_rd, fifo_reset,fifo_full[0],fifo_dav[0],bit_count[0]};
        3'h1: testpoints = ser_data;
        3'h2: testpoints = cplus_found;
        3'h3: testpoints = cminus_found;
        3'h4: testpoints = dispout;
        3'h5: testpoints = code_err;
        3'h6: testpoints = disp_err;
        3'h7: testpoints = 8'hab;
    endcase
assign fifo_data_count0 = rd_data_count[0];		
assign fifo_data_count1 = rd_data_count[1];		
assign fifo_data_count2 = rd_data_count[2];		
assign fifo_data_count3 = rd_data_count[3];		
assign fifo_data_count4 = rd_data_count[4];		
assign fifo_data_count5 = rd_data_count[5];		
assign fifo_data_count6 = rd_data_count[6];		
assign fifo_data_count7 = rd_data_count[7];		
endmodule
