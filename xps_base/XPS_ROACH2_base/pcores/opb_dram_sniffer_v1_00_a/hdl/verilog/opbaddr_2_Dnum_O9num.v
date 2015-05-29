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
module opbaddr_2_Dnum_O9num(
    input  [31:0] software_address_bits,
    input  [31:0] opb_addr, //always multiple of 4
    output [31:0] ddr3_addr,
    output [3:0]  opb_word,
    output ddr3_word   //word 0 or 1, try BL8 addressing 
);

    /* opb_addr must be of the form
        [*] least sig 2 bits 00 (skip by 4 BYTES to preserve address space)
        [*] bits 2-5 = 4 bits count the O9 word, or which 32 bit chunk to grab from, so will only use decimal values 0 through 8 (so need 4 bits) = opb_word 
        [*] bits 6-31 = 26 bits for which 288 bit word desired (this will break into ddr3_addr and ddr3_word)
    */
     
    //declare inputs
    wire [31:0] opb_addr; //opb_addr will only be a multiple of 4
    // BL8 requires an address skip by 8 bits
    wire [31:0] software_address_bits; //do nothing with this yet
    
    //declare outputs
    reg [31:0] ddr3_addr; //25 bits, so only get through 2^25 bits of addr space
    reg [3:0]  opb_word; // 4 bits only, count O9_0 to O9_8 = 9
    reg ddr3_word;

    //declare internals
    
    // for each opb_addr, read a whole word
    always @ (*) begin
       opb_word = opb_addr[5:2]; // counts 0 to 9 opb words per ddr3 word
       /* we will use 17 bits of the software_adddress which will step through
       the (2^17-1) chunks of 2^15 Bytes in 4 GB for a total of 29 bits addressable
       space on the ddr3, as expected*/
       ddr3_addr = {3'b0,{17'b0,opb_addr[15:7],3'b0} + {software_address_bits[16:0],12'b0}};
       //ddr3_addr = {opb_addr[31:7],3'b0};  //must always be a multiple of 4, hence 2'b0 at end
       ddr3_word = opb_addr[6]; 
       //want 0,4,8,12,16,20,24,28,32,36,40,44,...,60,64,68 to map to D0_O0,D0_O1,D0_O2,D0_O3,D0_04,D0_05,D0_O6,D0_O7,D0_O8, <0>, <0>, <0>, ...,<0>, D1_O0,D1_O1,etc
       //
    end
endmodule
