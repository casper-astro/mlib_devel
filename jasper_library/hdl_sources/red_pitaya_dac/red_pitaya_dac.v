/*************************************************************************************************************************
* Module: red_pitaya_dac
* Author: Adam Isaacson
* Date: 17 June 2019
* 
* Description:
* This module takes the outgoing 10 bit DAC twos complement IQ interleaved data from the Simulink DSP and outputs each I,Q or sample
* to each DAC in an interleaved fashion, so that all I components end up going to DAC CH0 and all Q components end up going to DAC CH1
* analog outputs. It uses a FIFO for Clock Domain Crossing from the DSP clock domain to the ADC/DAC clock domain
*************************************************************************************************************************/

module red_pitaya_dac #(
    //Define width of the DAC Data
    parameter NUM_OF_BITS           = 10       //Legal Values: 10,14,16
)(
    // Inputs
    input wire  [NUM_OF_BITS-1:0]  DAC0_DATA_I_IN,
    input wire  [NUM_OF_BITS-1:0]  DAC1_DATA_Q_IN, 
    input wire  DAC_DATA_VAL_IN,    
    input wire  ADC_CLK_IN,
    input wire  DAC_RST_IN,
    input wire  DAC_RST_IN2,    
    input wire  DAC_CLK_IN,
    input wire  DSP_RST_IN,    
    input wire  DSP_CLK_IN,    
    
    input wire  DAC_CLK_P_IN,

    //Outputs
    output wire DAC_IQWRT,   
    output wire DAC_IQSEL,   
    output wire DAC_IQCLK,   
    output wire DAC_IQRESET,      
    output wire [NUM_OF_BITS-1:0]  DAC_DATA_OUT    
      
);

wire Reset;

assign Reset = DAC_RST_IN  || DAC_RST_IN2 || DSP_RST_IN;

//Registered DAC data
reg [15:0] sDac0DataIIn;
reg [15:0] sDac1DataQIn;
reg sDacDataValidIn;


//Register in DAC Data. This also converts from signed to
//unsigned
always @(posedge DSP_CLK_IN or posedge Reset) begin
  if (Reset == 1'b1) begin
    sDac0DataIIn[15:0] <= 16'b0;
    sDac1DataQIn[15:0] <= 16'b0;
    sDacDataValidIn <= 1'b0;
  end else begin
    sDacDataValidIn <= DAC_DATA_VAL_IN;
    //Convert DAC data from signed to unsigned
    //If 16 bit data then the bus is 32 bits, but if less then zero pad
    if (NUM_OF_BITS == 16) begin
      sDac0DataIIn <= {DAC0_DATA_I_IN[NUM_OF_BITS-1], ~DAC0_DATA_I_IN[NUM_OF_BITS-2:0]}; 
      sDac1DataQIn <= {DAC1_DATA_Q_IN[NUM_OF_BITS-1], ~DAC1_DATA_Q_IN[NUM_OF_BITS-2:0]};
    end else begin
      sDac0DataIIn <= {{{16-NUM_OF_BITS}{1'b0}},DAC0_DATA_I_IN[NUM_OF_BITS-1], ~DAC0_DATA_I_IN[NUM_OF_BITS-2:0]}; 
      sDac1DataQIn <= {{{16-NUM_OF_BITS}{1'b0}},DAC1_DATA_Q_IN[NUM_OF_BITS-1], ~DAC1_DATA_Q_IN[NUM_OF_BITS-2:0]};    
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

//FIFO ADC Input data
assign FifoDataIn = {sDac1DataQIn,sDac0DataIIn};

//CDC DAC FIFO, 32 bit x 512 Deep
//to cater for 10 bit, 14 bit and 16 bit DAC data
dac_data_fifo dac_data_fifo_inst(
 .rst(Reset),
 .wr_clk(DSP_CLK_IN),
 .rd_clk(ADC_CLK_IN),
 .din(FifoDataIn),
 .wr_en(FifoWrEn),
 .rd_en(FifoRdEn),
 .dout(FifoDataOut),
 .full(FifoFull),
 .empty(FifoEmpty)
   
); 


//CDC FIFO write and read control signals
//gated with DAC data valid, FIFO Full and DSP reset
assign FifoWrEn = sDacDataValidIn && (Reset == 1'b0) && (FifoFull == 1'b0);


//This process generates the FIFO read enable signal and
//delays the FIFO read enable signal by one clock cycle to align with
//the data
always @(posedge ADC_CLK_IN or posedge Reset) begin
  if (Reset == 1'b1) begin
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

// DDR outputs
// TODO set parameter #(.DDR_CLK_EDGE ("SAME_EDGE"))
ODDR oddr_dac_clk          (.Q(DAC_IQCLK), .D1(1'b0), .D2(1'b1), .C(DAC_CLK_P_IN), .CE(1'b1), .R(1'b0), .S(1'b0));
ODDR oddr_dac_wrt          (.Q(DAC_IQWRT), .D1(1'b0), .D2(1'b1), .C(DAC_CLK_IN), .CE(1'b1), .R(1'b0), .S(1'b0));
ODDR oddr_dac_sel          (.Q(DAC_IQSEL), .D1(1'b0), .D2(1'b1), .C(ADC_CLK_IN), .CE(1'b1), .R(Reset), .S(1'b0));
ODDR oddr_dac_rst          (.Q(DAC_IQRESET), .D1(Reset), .D2(Reset), .C(ADC_CLK_IN), .CE(1'b1), .R(1'b0), .S(1'b0));
ODDR oddr_dac_dat [NUM_OF_BITS-1:0] (.Q(DAC_DATA_OUT), .D1(FifoDataOut[NUM_OF_BITS-1:0]), .D2(FifoDataOut[NUM_OF_BITS+15:16]), .C(ADC_CLK_IN), .CE(1'b1), .R(Reset), .S(1'b0));
//ODDR oddr_dac_dat [NUM_OF_BITS-1:0] (.Q(DAC_DATA_OUT), .D1(FifoDataOut[NUM_OF_BITS-1:0]), .D2(FifoDataOut[NUM_OF_BITS-1:0]), .C(ADC_CLK_IN), .CE(1'b1), .R(Reset), .S(1'b0));

endmodule

`default_nettype wire

