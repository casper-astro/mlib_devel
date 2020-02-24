`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:12:06 08/13/2010 
// Design Name: 
// Module Name:    iddr_inst 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module DATA_IDELAY // #(parameter IDELAY_VALUE = 5'd0)
(
          rst        ,
          clk_div    ,   
          load       ,
          data_out   ,          
          data_in    
//          CNTVALUEIN 
//          CNTVALUEOUT
          //----------- 
);

//define IO port
input     rst        ;
input     clk_div    ;
input     load       ;
output    data_out   ;
input     data_in    ;

//input     [8:0] CNTVALUEIN	;
//output    [8:0] CNTVALUEOUT	;
//-----register----------
//reg [8:0] CNTVALUEIN_r1;
reg  load_r1;

always@(posedge clk_div)
begin
//    CNTVALUEIN_r1 <= CNTVALUEIN;
    load_r1       <= load;
end

//reg [8:0] CNTVALUEIN_r2;
reg  load_r2;
always@(posedge clk_div)
begin
//    CNTVALUEIN_r2 <= CNTVALUEIN_r1;
    load_r2       <= load_r1;
end
//-------------reset register-------
reg rst_r1;
reg rst_r2;
always@(posedge clk_div)
begin
    rst_r1 <= rst;
    rst_r2 <= rst_r1;
end

//--------------end-------------------------------
//wire [8:0] CNTVALUEOUT_r;

//reg [8:0] CNTVALUEOUT_r1;
//reg [8:0] CNTVALUEOUT_r2;

//always@(posedge clk_div)
//begin
//    CNTVALUEOUT_r1 <= CNTVALUEOUT_r;
//    CNTVALUEOUT_r2 <= CNTVALUEOUT_r1;
//end
//assign CNTVALUEOUT = CNTVALUEOUT_r2;


//------------------------------------------------
// IDELAYE3: Input Fixed or Variable Delay Element
   //           Kintex UltraScale
   // Xilinx HDL Language Template, version 2015.4
//(* IODELAY_GROUP = "<iodelay_group_adc>" *) // Specifies group name for associated IDELAYs/ODELAYs and IDELAYCTRL
   IDELAYE3 #(
      .CASCADE("NONE"),         // Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
      .DELAY_FORMAT("COUNT"),   // Units of the DELAY_VALUE (COUNT, TIME)
      .DELAY_SRC("IDATAIN"),    // Delay input (DATAIN, IDATAIN)
      .DELAY_TYPE("VAR_LOAD"),  // Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
      .DELAY_VALUE(0),           // Input delay value setting
      .IS_CLK_INVERTED(1'b0),    // Optional inversion for CLK
      .IS_RST_INVERTED(1'b0),    // Optional inversion for RST
      .REFCLK_FREQUENCY(200.0),  // IDELAYCTRL clock input frequency in MHz (200.0-2667.0)
      .SIM_DEVICE("ULTRASCALE"), // Set the device version (ULTRASCALE, ULTRASCALE_PLUS_ES1)
      .UPDATE_MODE("ASYNC")      // Determines when updates to the delay will take effect (ASYNC, MANUAL, SYNC)
   )
   IDELAYE3_inst (
      .CASC_OUT( ),              // 1-bit output: Cascade delay output to ODELAY input cascade
      .CNTVALUEOUT( ), // 9-bit output: Counter value output
      .DATAOUT(data_out),        // 1-bit output: Delayed data output
      .CASC_IN(1'b0),            // 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      .CASC_RETURN(1'b0),        // 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      .CE(1'b0),                 // 1-bit input: Active high enable increment/decrement input
      .CLK(clk_div),             // 1-bit input: Clock input
      .CNTVALUEIN(9'd9),   // 9-bit input: Counter value input
      .DATAIN(1'b0),           // 1-bit input: Data input from the logic
      .EN_VTC(1'b0),           // 1-bit input: Keep delay constant over VT
      .IDATAIN(data_in),         // 1-bit input: Data input from the IOBUF
      .INC(1'b0),                 // 1-bit input: Increment / Decrement tap delay input
      .LOAD(load_r2),               // 1-bit input: Load DELAY_VALUE input
      .RST(rst_r2)                  // 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );

   // End of IDELAYE3_inst instantiation


endmodule
