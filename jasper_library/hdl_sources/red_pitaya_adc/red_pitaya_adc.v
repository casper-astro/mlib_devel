/*************************************************************************************************************************
* Module: red_pitaya_adc
* Author: Adam Isaacson
* Date: 14 June 2019
* 
* Description:
* This module takes the incoming 10 bit ADC data from each channel, performs two's complement operation and writes this
* data into a clock domain crossing FIFO so that it can be used by the Simulink DSP. 
*************************************************************************************************************************/

module red_pitaya_adc #(
    //Define width of the ADC Data
    parameter NUM_OF_BITS           = 10       //Legal Values: 10,14,16
)(
    // Inputs
    input wire  [NUM_OF_BITS-1:0]   ADC_DATA_IN1,
    input wire  [NUM_OF_BITS-1:0]   ADC_DATA_IN2,    
    input wire  ADC_CLK_IN,
    input wire  ADC_RST_IN,
    input wire  ADC_RST_IN2,
    input wire  DSP_CLK_IN,
    input wire  DSP_RST_IN,

    //Outputs
    output wire ADC_DATA_VAL_OUT,   
    output wire  [NUM_OF_BITS-1:0]   ADC0_DATA_I_OUT,  
    output wire  [NUM_OF_BITS-1:0]   ADC1_DATA_Q_OUT,    
    output wire ADC_CLK_STB_OUT
    //output wire ADC_LA_CLK
    
      
);

//Registered ADC data
reg [15:0] sAdc0DataIIn;
reg [15:0] sAdc1DataQIn;
reg sAdcDataValidIn;
reg [4:0] sAdcClkCount;

wire Reset;

assign Reset = ADC_RST_IN  || ADC_RST_IN2;
//Just for debugging on external logic analyser
//assign ADC_LA_CLK = DSP_CLK_IN;

//Register in ADC Data for both channels and wait for
//a pipeline of 16 clock cycles before asserting data
//valid in. This also converts from offset binary to
//twos complement (inverts MSB)
always @(posedge ADC_CLK_IN or posedge Reset) begin
  if (Reset == 1'b1) begin
    sAdc0DataIIn[15:0] <= 16'b0;
    sAdc1DataQIn[15:0] <= 16'b0;
    sAdcDataValidIn <= 1'b0;
    sAdcClkCount <= 5'b0;
  end else begin 
    sAdcClkCount <= sAdcClkCount + 1'b1;
    //Wait for a pipeline delay of 16 clock cycles at
    //start up
    if (sAdcClkCount == 16) begin
      sAdcDataValidIn <= 1'b1; 
    end
    //Convert ADC data from offset binary to twos complement
    //If 16 bit data then the bus is 32 bits, but if less then zero pad
    if (NUM_OF_BITS == 16) begin
      sAdc0DataIIn <= {ADC_DATA_IN1[NUM_OF_BITS-1], ~ADC_DATA_IN1[NUM_OF_BITS-2:0]}; 
      sAdc1DataQIn <= {ADC_DATA_IN2[NUM_OF_BITS-1], ~ADC_DATA_IN2[NUM_OF_BITS-2:0]};
    end else begin
      sAdc0DataIIn <= {{{16-NUM_OF_BITS}{1'b0}},ADC_DATA_IN1[NUM_OF_BITS-1], ~ADC_DATA_IN1[NUM_OF_BITS-2:0]}; 
      sAdc1DataQIn <= {{{16-NUM_OF_BITS}{1'b0}},ADC_DATA_IN2[NUM_OF_BITS-1], ~ADC_DATA_IN2[NUM_OF_BITS-2:0]};    
    end
  end  
end

wire FifoEmpty;
wire FifoFull;
wire FifoWrEn;
reg FifoRdEn;
reg FifoRdEnD1;
wire [31:0] FifoDataIn;
wire [31:0] FifoDataOut;

//CDC ADC FIFO, 32 bit x 512 Deep
//to cater for 10 bit, 14 bit and 16 bit ADC data
adc_data_fifo adc_data_fifo_inst(
 .rst(Reset),
 .wr_clk(ADC_CLK_IN),
 .rd_clk(DSP_CLK_IN),
 .din(FifoDataIn),
 .wr_en(FifoWrEn),
 .rd_en(FifoRdEn),
 .dout(FifoDataOut),
 .full(FifoFull),
 .empty(FifoEmpty)
   
); 

//CDC FIFO write and read control signals
//gated with ADC data valid, FIFO Full and ADC reset
assign FifoWrEn = sAdcDataValidIn && (Reset == 1'b0) && (FifoFull == 1'b0);

//FIFO ADC Input data
assign FifoDataIn = {sAdc1DataQIn,sAdc0DataIIn};

//This process generates the FIFO read enable signal and
//delays the FIFO read enable signal by one clock cycle to align with
//the data
always @(posedge DSP_CLK_IN or posedge DSP_RST_IN) begin
  if (DSP_RST_IN == 1'b1) begin
    FifoRdEn <= 1'b0;
    FifoRdEnD1 <= 1'b0;
  end else begin
    //There is a data delay of one clock cycle when the FIFO read is asserted 
    FifoRdEnD1 <= FifoRdEn;
    //If FIFO empty then disable FIFO read enable signal
    if (FifoEmpty == 1'b1) begin
      FifoRdEn <= 1'b0; 
    end else begin
      FifoRdEn <= 1'b1;     
    end
  end  
end

//Assign ADC Yellow block outputs
assign ADC_DATA_VAL_OUT = FifoRdEnD1;
assign ADC0_DATA_I_OUT = FifoDataOut[NUM_OF_BITS-1:0];
assign ADC1_DATA_Q_OUT = FifoDataOut[NUM_OF_BITS+15:16];
//Always Enable ADC clock Stabilizer
assign ADC_CLK_STB_OUT = 1'b1;


endmodule

`default_nettype wire

