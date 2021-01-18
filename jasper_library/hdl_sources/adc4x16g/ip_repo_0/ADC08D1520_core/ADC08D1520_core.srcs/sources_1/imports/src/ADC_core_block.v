//Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
//Date        : Wed Jul 06 19:53:43 2016
//Host        : RixLaptop2010 running 64-bit Service Pack 1  (build 7601)
//Command     : generate_target ADC_core_block.bd
//Design      : ADC_core_block
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "ADC_core_block,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=ADC_core_block,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=0,numReposBlks=0,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=Global}" *) (* HW_HANDOFF = "ADC_core_block.hwdef" *) 
module ADC_core_block
   (
   input wire [7:0] DI_P,
   input wire [7:0] DI_N,
   input wire [7:0] DID_P,
   input wire [7:0] DID_N,
   input wire [7:0] DQ_P,
   input wire [7:0] DQ_N,
   input wire [7:0] DQD_P,
   input wire [7:0] DQD_N,
   input wire OR_P,
   input wire OR_N,
   input wire DCLK_P,
   input wire DCLK_N,
   output wire DCLKRST_P,
   output wire DCLKRST_N,
   output wire ADC_CALn,
   output wire [4:0] testpoints,
   output wire MMCM_locked,
   output wire [31:0] ADC_data_out,
   output wire ADC_data_valid,
   input wire read_clk,
   input wire [31:0] control
//Group these together in a single control port
//   input wire [1:0] ADC_data_sel,
//   input wire IDDR_reset,
//   input wire MMCM_reset,
//   input wire next_word,
//   input wire fake_enable
   );

parameter [7:0] DI_INVERT_VECTOR = 8'b11100100 ;
parameter [7:0] DID_INVERT_VECTOR = 8'b00010000;
parameter [7:0] DQ_INVERT_VECTOR = 8'b01000000 ;
parameter [7:0] DQD_INVERT_VECTOR = 8'b00110111 ;
parameter OR_INVERT_VECTOR = 1'b1;

wire IDDR_reset = control[0];
wire MMCM_reset = control[1];
wire [1:0] ADC_data_sel = control[3:2];
wire next_word = control[4];
wire fake_enable = control[5];
wire DCLK_RST_IN = control[6];
assign ADC_CALn = !control[7];


wire [7:0] DI;
wire [7:0] DI_rise;
wire [7:0] DI_fall;
wire [7:0] DID;
wire [7:0] DID_rise;
wire [7:0] DID_fall;
wire [7:0] DQ;
wire [7:0] DQ_rise;
wire [7:0] DQ_fall;
wire [7:0] DQD;
wire [7:0] DQD_rise;
wire [7:0] DQD_fall;
wire DCLK;
wire OR;
wire OR_rise;
wire OR_fall;
wire DCLKRST = DCLK_RST_IN;

wire data_clock;
genvar gg;

//Sync the IDDR reset to the dataclock
wire IDDR_reset_sync;
async_input_sync #(
   .SYNC_STAGES(2),
   .PIPELINE_STAGES(1),
   .INIT(1'b0)
) IDDR_RST_SYNC (
   .clk(data_clk),
   .async_in(IDDR_reset),
   .sync_out(IDDR_reset_sync)
);

///////////// IBUFDS's ///////////////////////////////////
generate
 for (gg=0; gg < 8; gg=gg+1)
 begin: DI_IN
    IBUFDS #(
    .DIFF_TERM("TRUE"),       // Differential Termination
    .IBUF_LOW_PWR("FALSE"),     // Low power="TRUE", Highest performance="FALSE" 
    .IOSTANDARD("DEFAULT")     // Specify the input I/O standard
    ) IBUFDS_inst (
    .O(DI[gg]),  // Buffer output
    .I(DI_P[gg]),  // Diff_p buffer input (connect directly to top-level port)
    .IB(DI_N[gg]) // Diff_n buffer input (connect directly to top-level port)
    );
    
    IDDR #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"), // "OPPOSITE_EDGE", "SAME_EDGE" 
                                   //    or "SAME_EDGE_PIPELINED" 
    .INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
    .INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
    .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
    ) IDDR_inst (
    .Q1(DI_rise[gg]), // 1-bit output for positive edge of clock 
    .Q2(DI_fall[gg]), // 1-bit output for negative edge of clock
    .C(data_clock),   // 1-bit clock input
    .CE(1'b1), // 1-bit clock enable input
    .D(DI[gg]),   // 1-bit DDR data input
    .R(IDDR_reset_sync),   // 1-bit reset
    .S(1'b0)    // 1-bit set
    );
    
end
endgenerate
generate
 for (gg=0; gg < 8; gg=gg+1)
 begin: DID_IN
    IBUFDS #(
    .DIFF_TERM("TRUE"),       // Differential Termination
    .IBUF_LOW_PWR("FALSE"),     // Low power="TRUE", Highest performance="FALSE" 
    .IOSTANDARD("DEFAULT")     // Specify the input I/O standard
    ) IBUFDS_inst (
    .O(DID[gg]),  // Buffer output
    .I(DID_P[gg]),  // Diff_p buffer input (connect directly to top-level port)
    .IB(DID_N[gg]) // Diff_n buffer input (connect directly to top-level port)
    );
    IDDR #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"), // "OPPOSITE_EDGE", "SAME_EDGE" 
                                   //    or "SAME_EDGE_PIPELINED" 
    .INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
    .INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
    .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
    ) IDDR_inst (
    .Q1(DID_rise[gg]), // 1-bit output for positive edge of clock 
    .Q2(DID_fall[gg]),// 1-bit output for negative edge of clock
    .C(data_clock),   // 1-bit clock input
    .CE(1'b1), // 1-bit clock enable input
    .D(DID[gg]),   // 1-bit DDR data input
    .R(IDDR_reset_sync),   // 1-bit reset
    .S(1'b0)    // 1-bit set
    );

end
endgenerate
generate
 for (gg=0; gg < 8; gg=gg+1)
 begin: DQ_IN
    IBUFDS #(
    .DIFF_TERM("TRUE"),       // Differential Termination
    .IBUF_LOW_PWR("FALSE"),     // Low power="TRUE", Highest performance="FALSE" 
    .IOSTANDARD("DEFAULT")     // Specify the input I/O standard
    ) IBUFDS_inst (
    .O(DQ[gg]),  // Buffer output
    .I(DQ_P[gg]),  // Diff_p buffer input (connect directly to top-level port)
    .IB(DQ_N[gg]) // Diff_n buffer input (connect directly to top-level port)
    );

    IDDR #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"), // "OPPOSITE_EDGE", "SAME_EDGE" 
                                   //    or "SAME_EDGE_PIPELINED" 
    .INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
    .INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
    .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
    ) IDDR_inst (
    .Q1(DQ_rise[gg]), // 1-bit output for positive edge of clock 
    .Q2(DQ_fall[gg]), // 1-bit output for negative edge of clock
    .C(data_clock),   // 1-bit clock input
    .CE(1'b1), // 1-bit clock enable input
    .D(DQ[gg]),   // 1-bit DDR data input
    .R(IDDR_reset_sync),   // 1-bit reset
    .S(1'b0)    // 1-bit set
    );

end
endgenerate
generate
 for (gg=0; gg < 8; gg=gg+1)
 begin: DQD_IN
    IBUFDS #(
    .DIFF_TERM("TRUE"),       // Differential Termination
    .IBUF_LOW_PWR("FALSE"),     // Low power="TRUE", Highest performance="FALSE" 
    .IOSTANDARD("DEFAULT")     // Specify the input I/O standard
    ) IBUFDS_inst (
    .O(DQD[gg]),  // Buffer output
    .I(DQD_P[gg]),  // Diff_p buffer input (connect directly to top-level port)
    .IB(DQD_N[gg]) // Diff_n buffer input (connect directly to top-level port)
    );

    IDDR #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"), // "OPPOSITE_EDGE", "SAME_EDGE" 
                                   //    or "SAME_EDGE_PIPELINED" 
    .INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
    .INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
    .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
    ) IDDR_inst (
    .Q1(DQD_rise[gg]), // 1-bit output for positive edge of clock 
    .Q2(DQD_fall[gg]), // 1-bit output for negative edge of clock
    .C(data_clock),   // 1-bit clock input
    .CE(1'b1), // 1-bit clock enable input
    .D(DQD[gg]),   // 1-bit DDR data input
    .R(IDDR_reset_sync),   // 1-bit reset
    .S(1'b0)    // 1-bit set
    );

end
endgenerate

IBUFDS #(
.DIFF_TERM("TRUE"),       // Differential Termination
.IBUF_LOW_PWR("FALSE"),     // Low power="TRUE", Highest performance="FALSE" 
.IOSTANDARD("DEFAULT")     // Specify the input I/O standard
) IBUFDS_OR (
.O(OR),  // Buffer output
.I(OR_P),  // Diff_p buffer input (connect directly to top-level port)
.IB(OR_N) // Diff_n buffer input (connect directly to top-level port)
);
    IDDR #(
.DDR_CLK_EDGE("SAME_EDGE_PIPELINED"), // "OPPOSITE_EDGE", "SAME_EDGE" 
                               //    or "SAME_EDGE_PIPELINED" 
.INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
.INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
.SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
) IDDR_OR (
.Q1(OR_rise), // 1-bit output for positive edge of clock 
.Q2(OR_fall), // 1-bit output for negative edge of clock
.C(data_clock),   // 1-bit clock input
.CE(1'b1), // 1-bit clock enable input
.D(OR),   // 1-bit DDR data input
.R(IDDR_reset_sync),   // 1-bit reset
.S(1'b0)    // 1-bit set
);

//IBUFDS #(
//.DIFF_TERM("TRUE"),       // Differential Termination
//.IBUF_LOW_PWR("TRUE"),     // Low power="TRUE", Highest performance="FALSE" 
//.IOSTANDARD("DEFAULT")     // Specify the input I/O standard
//) IBUFDS_DCLK (
//.O(DCLK),  // Buffer output
//.I(DCLK_P),  // Diff_p buffer input (connect directly to top-level port)
//.IB(DCLK_N) // Diff_n buffer input (connect directly to top-level port)
//);

OBUFDS #(
  .IOSTANDARD("DEFAULT"), // Specify the output I/O standard
  .SLEW("FAST")           // Specify the output slew rate
) OBUFDS_DCLKRST (
  .O(DCLKRST_P),     // Diff_p output (connect directly to top-level port)
  .OB(DCLKRST_N),   // Diff_n output (connect directly to top-level port)
  .I(DCLKRST)      // Buffer input 
);

//   BUFMR BUFMR_DCLK (
//      .O(data_clock), // 1-bit output: Clock output (connect to BUFIOs/BUFRs)
//      .I(DCLK)  // 1-bit input: Clock input (Connect to IBUF)
//   );
(*DONT_TOUCH = "TRUE"*)wire fabric_clk;
  clk_wiz_0 MMCM_DATACLK
   (
   // Clock in ports
    .clk_in1_p(DCLK_P),      // input clk_in1
    .clk_in1_n(DCLK_N),      // input clk_in1
    // Clock out ports
    .clk_out1(fabric_clk),     // output clk_out1
    // Status and control signals
    .reset(MMCM_reset), // input reset
    .locked(MMCM_locked));      // output locked
assign data_clock = fabric_clk;
 //To prevent logic being optimized away
/* assign testpoints = DI_rise | DI_fall | 
                        DID_rise | DID_fall | 
                        DQ_rise | DQ_fall | 
                        DQD_rise | DQD_fall | 
                        OR_rise | OR_fall;
 */
//A 10-bit counter to count words                        
 reg [10:0] word_count;
(*KEEP = "TRUE"*) wire [10:0] word_count_debug = word_count;

// The samples are acquired in this order: DQD_r, DID_r, DQ_r, DI_r, DQD_f, DID_f, DQ_f, DI_f
// They will be read as a pair of u32s by the Zynq, and sent out byte-by-byte.  Zynq is little-endian,
//  so organize the bytes accordingly

 wire [65:0] all_ADC_data =   
                {OR_fall ^ OR_INVERT_VECTOR,
                OR_rise ^ OR_INVERT_VECTOR,
//                DQD_fall ^ DQD_INVERT_VECTOR, 
//                DQD_rise ^ DQD_INVERT_VECTOR, 
//                DQ_fall ^ DQ_INVERT_VECTOR, 
//                DQ_rise ^ DQ_INVERT_VECTOR, 
//                DID_fall ^ DID_INVERT_VECTOR, 
//                DID_rise ^ DID_INVERT_VECTOR, 
//                DI_fall ^ DI_INVERT_VECTOR,
//                DI_rise ^ DI_INVERT_VECTOR};
                DI_fall ^ DI_INVERT_VECTOR,
                DQ_fall ^ DQ_INVERT_VECTOR, 
                DID_fall ^ DID_INVERT_VECTOR, 
                DQD_fall ^ DQD_INVERT_VECTOR, 
                DI_rise ^ DI_INVERT_VECTOR,
                DQ_rise ^ DQ_INVERT_VECTOR, 
                DID_rise ^ DID_INVERT_VECTOR, 
                DQD_rise ^ DQD_INVERT_VECTOR}; 
                
//Fake data, from a ROM
(*KEEP = "TRUE"*)wire [63:0] fake_data;

//MUX. to select real or fake
(*KEEP = "TRUE"*)wire fake_enable_sync;
wire [65:0] fake_mux_out = fake_enable_sync ? {2'b0, fake_data} : all_ADC_data;
 //All of the ADC data, overrange bits, and the word counter, to load into the FIFO
 wire [75:0] all_data = {word_count[9:0], 
                            fake_mux_out
                            };
                            
 async_input_sync #(
                   .SYNC_STAGES(2),
                   .PIPELINE_STAGES(1),
                   .INIT(1'b0)
                   ) FAKE_EN_SYNC (
                   .clk(fabric_clk),
                   .async_in(fake_enable),
                   .sync_out(fake_enable_sync)
                    );

 wire [75:0] data_fifo_out;                         
 wire data_fifo_empty;                         
 wire data_fifo_full;            
 (*KEEP = "TRUE"*)wire data_fifo_write;        
 
 //Counter to cycle through the fake values
 wire [9:0] fake_ROM_address;

 blk_mem_gen_0 FAKE_ROM (
   .clka(fabric_clk),    // input wire clka
   .ena(1'b1),      // input wire ena
   .addra(fake_ROM_address),  // input wire [9 : 0] addra
   .douta(fake_data)  // output wire [63 : 0] douta
 );

 //Edge-detect next_word to get next word from FIFO
 reg next_word_d1;
 wire next_word_pulse = next_word && !next_word_d1;
 always @ (posedge read_clk) next_word_d1 <= next_word;
 fifo_generator_0 DATA_FIFO (
                              .rst(IDDR_reset),        // input wire rst
                              .wr_clk(fabric_clk),  // input wire wr_clk
                              .rd_clk(read_clk),  // input wire rd_clk
                              .din(all_data),        // input wire [75 : 0] din
                              .wr_en(data_fifo_write),    // input wire wr_en
                              .rd_en(next_word_pulse),    // input wire rd_en
                              .dout(data_fifo_out),      // output wire [75 : 0] dout
                              .full(data_fifo_full),      // output wire full
                              .empty(data_fifo_empty)    // output wire empty
                            );

//MUX to select one of three words
reg [31:0] data_mux_out;
wire [1:0] data_mux_sel;
always @ (data_fifo_out, data_mux_sel) 
    case (data_mux_sel)
        2'b00: data_mux_out = data_fifo_out[31:0];
        2'b01: data_mux_out = data_fifo_out[63:32];
        2'b10: data_mux_out = {20'h0, data_fifo_out[75:64]};
        2'b11: data_mux_out = 32'hx;
     endcase

// Sync the empty signal
wire data_fifo_empty_sync;
async_input_sync #(
   .SYNC_STAGES(2),
   .PIPELINE_STAGES(1),
   .INIT(1'b0)
) EMPTY_SYNC (
   .clk(fabric_clk),
   .async_in(data_fifo_empty),
   .sync_out(data_fifo_empty_sync)
);

assign fake_ROM_address = word_count[9:0];
//When FIFO goes empty (after being read out by CPU) write 1024 words
//  (=8k samples, = 4us window at 2GHz sample rate
reg empty_d1;
wire empty_pulse = !empty_d1 && data_fifo_empty_sync;
always @ (posedge fabric_clk) begin
    empty_d1 <= data_fifo_empty_sync;
    if (empty_pulse) 
        begin
            word_count <= 0;
        end
    else begin 
        if (word_count < 1025) word_count <= word_count + 1;
    end 
end
//Delay the fifo_write by one cycle to account for the delay through the FAKE_ROM; real data doesn't care
wire writing = (word_count > 0) && (word_count < 1025);
reg writing_d1;
always @ (posedge fabric_clk) writing_d1 <= writing;
assign data_fifo_write = writing_d1;

assign  ADC_data_out = data_mux_out;
assign ADC_data_valid = !data_fifo_empty;
assign data_mux_sel = ADC_data_sel;
assign testpoints[4] = fake_ROM_address[9];
assign testpoints[3] = MMCM_locked;
assign testpoints[2] = next_word_pulse;
assign testpoints[1] = data_fifo_empty;
assign testpoints[0] = IDDR_reset_sync;
endmodule
