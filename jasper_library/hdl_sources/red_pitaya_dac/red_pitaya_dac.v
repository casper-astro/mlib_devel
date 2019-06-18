/*************************************************************************************************************************
* Module: red_pitaya_dac
* Author: Adam Isaacson
* Date: 17 June 2019
* 
* Description:
* This module takes the outgoing 10 bit DAC twos complement IQ interleaved data from the Simulink DSP and outputs each I,Q or sample
* to each DAC in an interleaved fashion, so that all I components end up going to DAC CH0 and all Q components end up going to DAC CH1
* analog outputs
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
    input wire  DAC_CLK_P_IN,

    //Outputs
    output wire DAC_IQWRT,   
    output wire DAC_IQSEL,   
    output wire DAC_IQCLK,   
    output wire DAC_IQRESET,      
    output wire [NUM_OF_BITS-1:0]  DAC_DATA_OUT    
      
);

wire Reset;

assign Reset = DAC_RST_IN  || DAC_RST_IN2;


// DDR outputs
// TODO set parameter #(.DDR_CLK_EDGE ("SAME_EDGE"))
ODDR oddr_dac_clk          (.Q(DAC_IQCLK), .D1(1'b0), .D2(1'b1), .C(DAC_CLK_P_IN), .CE(1'b1), .R(1'b0), .S(1'b0));
ODDR oddr_dac_wrt          (.Q(DAC_IQWRT), .D1(1'b0), .D2(1'b1), .C(DAC_CLK_IN), .CE(1'b1), .R(1'b0), .S(1'b0));
ODDR oddr_dac_sel          (.Q(DAC_IQSEL), .D1(1'b0), .D2(1'b1), .C(ADC_CLK_IN), .CE(1'b1), .R(Reset), .S(1'b0));
ODDR oddr_dac_rst          (.Q(DAC_IQRESET), .D1(Reset), .D2(Reset), .C(ADC_CLK_IN), .CE(DAC_DATA_VAL_IN), .R(1'b0), .S(1'b0));
ODDR oddr_dac_dat [NUM_OF_BITS-1:0] (.Q(DAC_DATA_OUT), .D1(DAC0_DATA_I_IN), .D2(DAC1_DATA_Q_IN), .C(ADC_CLK_IN), .CE(DAC_DATA_VAL_IN), .R(Reset), .S(1'b0));

endmodule

`default_nettype wire

