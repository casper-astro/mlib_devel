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
    input clk,
    input rst,
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
    output rxslide3,
    input XOR_ON,
    input [1:0]bit_sel,
    input fifo_read,
    input fifo_reset,
    input gtwiz_reset_all_in,
    input pattern_match_enable,
    input rxcdrhold,
    output reg XOR_ON0,
    output reg XOR_ON1,
    output reg XOR_ON2,
    output reg XOR_ON3,
    output reg [1:0]bit_sel0,
    output reg [1:0]bit_sel1,
    output reg [1:0]bit_sel2,
    output reg [1:0]bit_sel3,
    output reg fifo_read0,
    output reg fifo_read1,
    output reg fifo_read2,
    output reg fifo_read3,
    output reg fifo_reset0,
    output reg fifo_reset1,
    output reg fifo_reset2,
    output reg fifo_reset3,
    output reg gtwiz_reset_all_in0,
    output reg gtwiz_reset_all_in1,
    output reg gtwiz_reset_all_in2,
    output reg gtwiz_reset_all_in3,
    output reg pattern_match_enable0,
    output reg pattern_match_enable1,
    output reg pattern_match_enable2,
    output reg pattern_match_enable3,
    output reg rxcdrhold0,
    output reg rxcdrhold1,
    output reg rxcdrhold2,
    output reg rxcdrhold3
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

//xor_on
always @(posedge clk)
    begin
        if(rst)
            begin
               XOR_ON0 <= 0;
               XOR_ON1 <= 0;
               XOR_ON2 <= 0;
               XOR_ON3 <= 0;
            end
        else
            begin
            case(channel_sel)
                2'h0:
                    begin
                        XOR_ON0 <= XOR_ON;
                        XOR_ON1 <= XOR_ON1;
                        XOR_ON2 <= XOR_ON2;
                        XOR_ON3 <= XOR_ON3;
                    end 
                2'h1:
                    begin
                        XOR_ON0 <= XOR_ON0;
                        XOR_ON1 <= XOR_ON;
                        XOR_ON2 <= XOR_ON2;
                        XOR_ON3 <= XOR_ON3;
                    end
                2'h2:
                    begin
                        XOR_ON0 <= XOR_ON0;
                        XOR_ON1 <= XOR_ON1;
                        XOR_ON2 <= XOR_ON;
                        XOR_ON3 <= XOR_ON3;
                    end
                2'h3:
                    begin
                        XOR_ON0 <= XOR_ON0;
                        XOR_ON1 <= XOR_ON1;
                        XOR_ON2 <= XOR_ON2;
                        XOR_ON3 <= XOR_ON;
                    end
                default:
                    begin
                        XOR_ON0 <= 0;
                        XOR_ON1 <= 0;
                        XOR_ON2 <= 0;
                        XOR_ON3 <= 0;
                    end
            endcase
            end
    end
//bit_sel
always @(posedge clk)
    begin
        if(rst)
            begin
                bit_sel0 <= 0;
                bit_sel1 <= 0;
                bit_sel2 <= 0;
                bit_sel3 <= 0;
            end
        else
            begin
                case(channel_sel)
                    2'h0:
                        begin
                            bit_sel0 <= bit_sel;
                            bit_sel1 <= bit_sel1;
                            bit_sel2 <= bit_sel2;
                            bit_sel3 <= bit_sel3;
                        end
                    2'h1:
                        begin
                            bit_sel0 <= bit_sel0;
                            bit_sel1 <= bit_sel;
                            bit_sel2 <= bit_sel2;
                            bit_sel3 <= bit_sel3;
                        end
                    2'h2:
                        begin
                            bit_sel0 <= bit_sel0;
                            bit_sel1 <= bit_sel1;
                            bit_sel2 <= bit_sel;
                            bit_sel3 <= bit_sel3;
                        end
                    2'h3:
                        begin
                            bit_sel0 <= bit_sel0;
                            bit_sel1 <= bit_sel1;
                            bit_sel2 <= bit_sel2;
                            bit_sel3 <= bit_sel;
                        end
                    default:
                        begin
                            bit_sel0 <= 0;
                            bit_sel1 <= 0;
                            bit_sel2 <= 0;
                            bit_sel3 <= 0;
                        end
                endcase
            end
    end

//fifo_read
always @(posedge clk)
    begin
        if(rst)
            begin
                fifo_read0 <= 0;
                fifo_read1 <= 0;
                fifo_read2 <= 0;
                fifo_read3 <= 0;
            end
        else
            begin
                case(channel_sel)
                    2'h0:
                        begin
                            fifo_read0 <= fifo_read;
                            fifo_read1 <= fifo_read1;
                            fifo_read2 <= fifo_read2;
                            fifo_read3 <= fifo_read3; 
                        end
                    2'h1:
                        begin
                            fifo_read0 <= fifo_read0;
                            fifo_read1 <= fifo_read;
                            fifo_read2 <= fifo_read2;
                            fifo_read3 <= fifo_read3;
                        end
                    2'h2:
                        begin
                            fifo_read0 <= fifo_read0;
                            fifo_read1 <= fifo_read1;
                            fifo_read2 <= fifo_read;
                            fifo_read3 <= fifo_read3;
                        end
                    2'h3:
                        begin
                            fifo_read0 <= fifo_read0;
                            fifo_read1 <= fifo_read1;
                            fifo_read2 <= fifo_read2;
                            fifo_read3 <= fifo_read;
                        end
                    default:
                        begin
                            fifo_read0 <= 0;
                            fifo_read1 <= 0;
                            fifo_read2 <= 0;
                            fifo_read3 <= 0;
                        end
                endcase
            end
    end
//fifo_reset
always @(posedge clk)
    begin
        if(rst)
            begin
                fifo_reset0 <= 0;
                fifo_reset1 <= 0;
                fifo_reset2 <= 0;
                fifo_reset3 <= 0;
            end
        else
            begin
                case(channel_sel)
                    2'h0:
                        begin
                            fifo_reset0 <= fifo_reset;
                            fifo_reset1 <= fifo_reset1;
                            fifo_reset2 <= fifo_reset2;
                            fifo_reset3 <= fifo_reset3; 
                        end
                    2'h1:
                        begin
                            fifo_reset0 <= fifo_reset0;
                            fifo_reset1 <= fifo_reset;
                            fifo_reset2 <= fifo_reset2;
                            fifo_reset3 <= fifo_reset3;
                        end
                    2'h2:
                        begin
                            fifo_reset0 <= fifo_reset0;
                            fifo_reset1 <= fifo_reset1;
                            fifo_reset2 <= fifo_reset;
                            fifo_reset3 <= fifo_reset3;
                        end
                    2'h3:
                        begin
                            fifo_reset0 <= fifo_reset0;
                            fifo_reset1 <= fifo_reset1;
                            fifo_reset2 <= fifo_reset2;
                            fifo_reset3 <= fifo_reset;
                        end
                    default:
                        begin
                            fifo_reset0 <= 0;
                            fifo_reset1 <= 0;
                            fifo_reset2 <= 0;
                            fifo_reset3 <= 0;
                        end
                endcase
            end
    end

////gtwiz_reset_all_in
always @(posedge clk)
    begin
        if(rst)
            begin
                gtwiz_reset_all_in0 <= 0;
                gtwiz_reset_all_in1 <= 0;
                gtwiz_reset_all_in2 <= 0;
                gtwiz_reset_all_in3 <= 0;
            end
        else
            begin
                case(channel_sel)
                    2'h0:
                        begin
                            gtwiz_reset_all_in0 <= gtwiz_reset_all_in;
                            gtwiz_reset_all_in1 <= gtwiz_reset_all_in1;
                            gtwiz_reset_all_in2 <= gtwiz_reset_all_in2;
                            gtwiz_reset_all_in3 <= gtwiz_reset_all_in3; 
                        end
                    2'h1:
                        begin
                            gtwiz_reset_all_in0 <= gtwiz_reset_all_in0;
                            gtwiz_reset_all_in1 <= gtwiz_reset_all_in;
                            gtwiz_reset_all_in2 <= gtwiz_reset_all_in2;
                            gtwiz_reset_all_in3 <= gtwiz_reset_all_in3;
                        end
                    2'h2:
                        begin
                            gtwiz_reset_all_in0 <= gtwiz_reset_all_in0;
                            gtwiz_reset_all_in1 <= gtwiz_reset_all_in1;
                            gtwiz_reset_all_in2 <= gtwiz_reset_all_in;
                            gtwiz_reset_all_in3 <= gtwiz_reset_all_in3;
                        end
                    2'h3:
                        begin
                            gtwiz_reset_all_in0 <= gtwiz_reset_all_in0;
                            gtwiz_reset_all_in1 <= gtwiz_reset_all_in1;
                            gtwiz_reset_all_in2 <= gtwiz_reset_all_in2;
                            gtwiz_reset_all_in3 <= gtwiz_reset_all_in;
                        end
                    default:
                        begin
                            gtwiz_reset_all_in0 <= 0;
                            gtwiz_reset_all_in1 <= 0;
                            gtwiz_reset_all_in2 <= 0;
                            gtwiz_reset_all_in3 <= 0;
                        end
                endcase
            end
    end
/*
assign gtwiz_reset_all_in0 = gtwiz_reset_all_in;
assign gtwiz_reset_all_in1 = gtwiz_reset_all_in;
assign gtwiz_reset_all_in2 = gtwiz_reset_all_in;
assign gtwiz_reset_all_in3 = gtwiz_reset_all_in;
*/
always @(posedge clk)
    begin
        if(rst)
            begin
                pattern_match_enable0 <= 0;
                pattern_match_enable1 <= 0;
                pattern_match_enable2 <= 0;
                pattern_match_enable3 <= 0;
            end
        else
            begin
                case(channel_sel)
                    2'h0:
                        begin
                            pattern_match_enable0 <= pattern_match_enable;
                            pattern_match_enable1 <= pattern_match_enable1;
                            pattern_match_enable2 <= pattern_match_enable2;
                            pattern_match_enable3 <= pattern_match_enable3; 
                        end
                    2'h1:
                        begin
                            pattern_match_enable0 <= pattern_match_enable0;
                            pattern_match_enable1 <= pattern_match_enable;
                            pattern_match_enable2 <= pattern_match_enable2;
                            pattern_match_enable3 <= pattern_match_enable3;
                        end
                    2'h2:
                        begin
                            pattern_match_enable0 <= pattern_match_enable0;
                            pattern_match_enable1 <= pattern_match_enable1;
                            pattern_match_enable2 <= pattern_match_enable;
                            pattern_match_enable3 <= pattern_match_enable3;
                        end
                    2'h3:
                        begin
                            pattern_match_enable0 <= pattern_match_enable0;
                            pattern_match_enable1 <= pattern_match_enable1;
                            pattern_match_enable2 <= pattern_match_enable2;
                            pattern_match_enable3 <= pattern_match_enable;
                        end
                    default:
                        begin
                            pattern_match_enable0 <= 0;
                            pattern_match_enable1 <= 0;
                            pattern_match_enable2 <= 0;
                            pattern_match_enable3 <= 0;
                        end
                endcase
            end
    end

////rxcdrhold
always @(posedge clk)
    begin
        if(rst)
            begin
                rxcdrhold0 <= 0;
                rxcdrhold1 <= 0;
                rxcdrhold2 <= 0;
                rxcdrhold3 <= 0;
            end
        else
            begin
                case(channel_sel)
                    2'h0:
                        begin
                            rxcdrhold0 <= rxcdrhold;
                            rxcdrhold1 <= rxcdrhold1;
                            rxcdrhold2 <= rxcdrhold2;
                            rxcdrhold3 <= rxcdrhold3; 
                        end
                    2'h1:
                        begin
                            rxcdrhold0 <= rxcdrhold0;
                            rxcdrhold1 <= rxcdrhold;
                            rxcdrhold2 <= rxcdrhold2;
                            rxcdrhold3 <= rxcdrhold3;
                        end
                    2'h2:
                        begin
                            rxcdrhold0 <= rxcdrhold0;
                            rxcdrhold1 <= rxcdrhold1;
                            rxcdrhold2 <= rxcdrhold;
                            rxcdrhold3 <= rxcdrhold3;
                        end
                    2'h3:
                        begin
                            rxcdrhold0 <= rxcdrhold0;
                            rxcdrhold1 <= rxcdrhold1;
                            rxcdrhold2 <= rxcdrhold2;
                            rxcdrhold3 <= rxcdrhold;
                        end
                    default:
                        begin
                            rxcdrhold0 <= 0;
                            rxcdrhold1 <= 0;
                            rxcdrhold2 <= 0;
                            rxcdrhold3 <= 0;
                        end
                endcase
            end
    end

endmodule
