`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2020 10:01:17 PM
// Design Name: 
// Module Name: ADC4C16G_Channel_Sel
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ADC4X16G_Channel_Sel(
    input [1:0] channel_sel,
    input [15:0]drp_data0,
    input [15:0]drp_data1,
    input [15:0]drp_data2,
    input [15:0]drp_data3,
    output reg[15:0]drp_data,
    input rxprbslocked0,
    input rxprbslocked1,
    input rxprbslocked2,
    input rxprbslocked3,
    output reg rxprbslocked,
    input rxslide,
    output rxslide0,
    output rxslide1,
    output rxslide2,
    output rxslide3
    );
//rxslide
assign rxslide0 = (channel_sel == 0)? rxslide: 0;
assign rxslide1 = (channel_sel == 1)? rxslide: 0;
assign rxslide2 = (channel_sel == 2)? rxslide: 0;
assign rxslide3 = (channel_sel == 3)? rxslide: 0;
//drp data
always @(*)
    case (channel_sel)
        2'h0: drp_data = drp_data0;
        2'h1: drp_data = drp_data1;
        2'h2: drp_data = drp_data2;
        2'h3: drp_data = drp_data3;
    endcase
//drp rxprbslocked
always @(*)
    case (channel_sel)
        2'h0: rxprbslocked = rxprbslocked0;
        2'h1: rxprbslocked = rxprbslocked1;
        2'h2: rxprbslocked = rxprbslocked2;
        2'h3: rxprbslocked = rxprbslocked3;
    endcase    
endmodule
