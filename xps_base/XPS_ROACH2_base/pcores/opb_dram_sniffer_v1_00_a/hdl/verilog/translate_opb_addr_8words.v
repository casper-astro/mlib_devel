`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:03:14 11/18/2013 
// Design Name: 
// Module Name:    translate_opb_addr_8words 
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
module translate_opb_addr_8words(
    input  [15:0] software_address_bits,
    input  [31:0] opb_addr, //always multiple of 4
    output [28:0] ddr3_addr,
    output [2:0]  opb_word,
    output ddr3_word   //word 0 or 1, try BL8 addressing 
);

    //declare inputs
    wire [31:0] opb_addr; //opb_addr will only be a multiple of 4
    // BL8 requires an address skip by 8 bits
    wire [15:0] software_address_bits; //do nothing with this yet
    
    //declare outputs
    reg [28:0] ddr3_addr; //2^29 addressable addresses
    reg [2:0]  opb_word; // 3 bits only, count W0 to W7 = 8
    reg ddr3_word;

    // for each opb_addr, read a whole word
    always @ (*) begin
       opb_word = opb_addr[4:2]; // counts 0 to 15 words in ddr3 address space
       ddr3_addr = {opb_addr[31:6],3'b0};  //must always be a multiple of 4, hence 2'b0 at end
       ddr3_word = opb_addr[5]; 
       //0,4,8,12,16,20,24,28 map to D0W0-D0W7, 
       //32,36,40,44,48,50,54,58,12,20 map to 1
    end
endmodule
