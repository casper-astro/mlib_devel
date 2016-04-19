`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/29/2014 08:16:58 PM
// Design Name: 
// Module Name: wb_bram
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
// This wrapper instantiates a true dual port ram, correctly using either
// a symmetric (both ports equal width) or assymmetric ram with the smaller
// width port connected to A.
// 
//////////////////////////////////////////////////////////////////////////////////


module tdp_ram_wrapper(clkA, clkB, enaA, enaB, weA, weB, addrA, addrB, diA, doA, diB, doB);
    parameter WIDTHB = 4;
    parameter SIZEB = 1024;
    parameter ADDRWIDTHB = 10;
    parameter WIDTHA = 16;
    parameter SIZEA = 256;
    parameter ADDRWIDTHA = 8;
    parameter N_REGISTERS = 3;
    input clkA;
    input clkB;
    input weA, weB;
    input enaA, enaB;
    
    input [ADDRWIDTHA-1:0] addrA;
    input [ADDRWIDTHB-1:0] addrB;
    input [WIDTHA-1:0] diA;
    input [WIDTHB-1:0] diB;
    
    output [WIDTHA-1:0] doA;
    output [WIDTHB-1:0] doB;

    `define max(a,b) {(a) > (b) ? (a) : (b)}
    `define min(a,b) {(a) < (b) ? (a) : (b)}
    
    function integer log2;
    input integer value;
    reg [31:0] shifted;
    integer res;
    begin
      if (value < 2)
        log2 = value;
      else
      begin
        shifted = value-1;
        for (res=0; shifted>0; res=res+1)
          shifted = shifted>>1;
        log2 = res;
      end
    end
    endfunction
    
    localparam maxSIZE = `max(SIZEA, SIZEB);
    localparam maxWIDTH = `max(WIDTHA, WIDTHB);
    localparam minWIDTH = `min(WIDTHA, WIDTHB);
    
    localparam RATIO = maxWIDTH / minWIDTH;
    localparam log2RATIO = log2(RATIO);
    
    reg [minWIDTH-1:0] RAM [0:maxSIZE-1];
    reg [WIDTHA-1:0] readA;
    reg [WIDTHB-1:0] readB;

    generate
    if (RATIO == 1) begin : symmetric_ram
        sym_ram_tdp #(
        .SIZE(SIZEA),
        .ADDRWIDTH(ADDRWIDTHA),
        .WIDTH(WIDTHA),
        .N_REGISTERS(N_REGISTERS)
        ) bram_inst (
        .clkA(clkA),
        .weA(weA),
        .addrA(addrA),
        .diA(diA),
        .doA(doA),
        .enaA(enaA),
        .clkB(clkB),
        .weB(weB),
        .addrB(addrB),
        .diB(diB),
        .doB(doB),
        .enaB(enaB)
        );
    end else if (WIDTHA < WIDTHB) begin :asymmetric_b_wider_than_a
        asym_ram_tdp #(
        .SIZEA(SIZEB),
        .ADDRWIDTHA(ADDRWIDTHB),
        .WIDTHA(WIDTHB),
        .SIZEB(SIZEA),
        .ADDRWIDTHB(ADDRWIDTHA),
        .WIDTHB(WIDTHA),
        .N_REGISTERS(N_REGISTERS)
        ) bram_inst (
        .clkA(clkB),
        .weA(weB),
        .addrA(addrB),
        .diA(diB),
        .doA(doB),
        .enaA(enaB),
        .clkB(clkA),
        .weB(weA),
        .addrB(addrA),
        .diB(diA),
        .doB(doA),
        .enaB(enaA)
        );
    end else if (WIDTHA > WIDTHB) begin :asymmetric_a_wider_than_b
        asym_ram_tdp #(
        .SIZEA(SIZEA),
        .ADDRWIDTHA(ADDRWIDTHA),
        .WIDTHA(WIDTHA),
        .SIZEB(SIZEB),
        .ADDRWIDTHB(ADDRWIDTHB),
        .WIDTHB(WIDTHB),
        .N_REGISTERS(N_REGISTERS)
        ) bram_inst (
        .clkA(clkA),
        .weA(weA),
        .addrA(addrA),
        .diA(diA),
        .doA(doA),
        .enaA(enaA),
        .clkB(clkB),
        .weB(weB),
        .addrB(addrB),
        .diB(diB),
        .doB(doB),
        .enaB(enaB)
        );
    end
    endgenerate
endmodule
