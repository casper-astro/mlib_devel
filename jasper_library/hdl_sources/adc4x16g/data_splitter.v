`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/16/2020 09:31:05 PM
// Design Name: 
// Module Name: data_splitter
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


module data_splitter(
    input sync_in,
    output sync_out,
    input [255:0] data_in,
    output [3:0] data_out0,
    output [3:0] data_out1,
    output [3:0] data_out2,
    output [3:0] data_out3,
    output [3:0] data_out4,
    output [3:0] data_out5,
    output [3:0] data_out6,
    output [3:0] data_out7,
    output [3:0] data_out8,
    output [3:0] data_out9,
    output [3:0] data_out10,
    output [3:0] data_out11,
    output [3:0] data_out12,
    output [3:0] data_out13,
    output [3:0] data_out14,
    output [3:0] data_out15,
    output [3:0] data_out16,
    output [3:0] data_out17,
    output [3:0] data_out18,
    output [3:0] data_out19,
    output [3:0] data_out20,
    output [3:0] data_out21,
    output [3:0] data_out22,
    output [3:0] data_out23,
    output [3:0] data_out24,
    output [3:0] data_out25,
    output [3:0] data_out26,
    output [3:0] data_out27,
    output [3:0] data_out28,
    output [3:0] data_out29,
    output [3:0] data_out30,
    output [3:0] data_out31,
    output [3:0] data_out32,
    output [3:0] data_out33,
    output [3:0] data_out34,
    output [3:0] data_out35,
    output [3:0] data_out36,
    output [3:0] data_out37,
    output [3:0] data_out38,
    output [3:0] data_out39,
    output [3:0] data_out40,
    output [3:0] data_out41,
    output [3:0] data_out42,
    output [3:0] data_out43,
    output [3:0] data_out44,
    output [3:0] data_out45,
    output [3:0] data_out46,
    output [3:0] data_out47,
    output [3:0] data_out48,
    output [3:0] data_out49,
    output [3:0] data_out50,
    output [3:0] data_out51,
    output [3:0] data_out52,
    output [3:0] data_out53,
    output [3:0] data_out54,
    output [3:0] data_out55,
    output [3:0] data_out56,
    output [3:0] data_out57,
    output [3:0] data_out58,
    output [3:0] data_out59,
    output [3:0] data_out60,
    output [3:0] data_out61,
    output [3:0] data_out62,
    output [3:0] data_out63
    );

assign sync_out = sync_in;
assign data_out0 = data_in[3:0];
assign data_out1 = data_in[7:4];
assign data_out2 = data_in[11:8];
assign data_out3 = data_in[15:12];
assign data_out4 = data_in[19:16];
assign data_out5 = data_in[23:20];
assign data_out6 = data_in[27:24];
assign data_out7 = data_in[31:28];
assign data_out8 = data_in[35:32];
assign data_out9 = data_in[39:36];
assign data_out10 = data_in[43:40];
assign data_out11 = data_in[47:44];
assign data_out12 = data_in[51:48];
assign data_out13 = data_in[55:52];
assign data_out14 = data_in[59:56];
assign data_out15 = data_in[63:60];
assign data_out16 = data_in[67:64];
assign data_out17 = data_in[71:68];
assign data_out18 = data_in[75:72];
assign data_out19 = data_in[79:76];
assign data_out20 = data_in[83:80];
assign data_out21 = data_in[87:84];
assign data_out22 = data_in[91:88];
assign data_out23 = data_in[95:92];
assign data_out24 = data_in[99:96];
assign data_out25 = data_in[103:100];
assign data_out26 = data_in[107:104];
assign data_out27 = data_in[111:108];
assign data_out28 = data_in[115:112];
assign data_out29 = data_in[119:116];
assign data_out30 = data_in[123:120];
assign data_out31 = data_in[127:124];
assign data_out32 = data_in[131:128];
assign data_out33 = data_in[135:132];
assign data_out34 = data_in[139:136];
assign data_out35 = data_in[143:140];
assign data_out36 = data_in[147:144];
assign data_out37 = data_in[151:148];
assign data_out38 = data_in[155:152];
assign data_out39 = data_in[159:156];
assign data_out40 = data_in[163:160];
assign data_out41 = data_in[167:164];
assign data_out42 = data_in[171:168];
assign data_out43 = data_in[175:172];
assign data_out44 = data_in[179:176];
assign data_out45 = data_in[183:180];
assign data_out46 = data_in[187:184];
assign data_out47 = data_in[191:188];
assign data_out48 = data_in[195:192];
assign data_out49 = data_in[199:196];
assign data_out50 = data_in[203:200];
assign data_out51 = data_in[207:204];
assign data_out52 = data_in[211:208];
assign data_out53 = data_in[215:212];
assign data_out54 = data_in[219:216];
assign data_out55 = data_in[223:220];
assign data_out56 = data_in[227:224];
assign data_out57 = data_in[231:228];
assign data_out58 = data_in[235:232];
assign data_out59 = data_in[239:236];
assign data_out60 = data_in[243:240];
assign data_out61 = data_in[247:244];
assign data_out62 = data_in[251:248];
assign data_out63 = data_in[255:252];

endmodule
