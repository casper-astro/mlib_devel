`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2014 10:54:50 AM
// Design Name: 
// Module Name: modulation_gen
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


module modulation_gen(
    input clk,
    input [39:0] data_in,
    input enable,
    output [39:0] modulation_out,
    input [1:0] MOD_SEL
    );
    
`define DLY #1
    //________________________________ BRAM Inference Logic _____________________________    
  
    reg     [3:0]   rom_addr;
    reg     [43:0] rom0 [0:15];
    reg     [43:0] rom1 [0:15];
    reg     [43:0] rom2 [0:15];
    reg     [43:0] rom3 [0:15];
    reg     [43:0]  rom_out;
    initial
    begin
    $readmemh("mod_source0.dat",rom0,0,15);
    $readmemh("mod_source1.dat",rom1,0,15);
    $readmemh("mod_source2.dat",rom2,0,15);
    $readmemh("mod_source3.dat",rom3,0,15);
    end

    always @(posedge clk) 
           rom_out <= `DLY (MOD_SEL == 2'b00) ? rom0[rom_addr] :
                                 (MOD_SEL == 2'b01) ? rom1[rom_addr] :
                                 (MOD_SEL == 2'b10) ? rom2[rom_addr] :
                                 rom3[rom_addr];


reg waiting_for_sync = 1;
reg waiting_for_sync_d1 = 1;
reg enable_d1;
wire enable_RE = enable && ~enable_d1;
always @ (posedge clk) begin
        waiting_for_sync_d1 <= waiting_for_sync;
        enable_d1 <= enable;
        if (enable_RE) begin 
            waiting_for_sync <= 1;
            rom_addr <= 0;
        end
        else begin
            if (waiting_for_sync) begin
                if ((data_in == rom_out[39:0]) && waiting_for_sync_d1) begin
                    //when sync is found, jump ahead 2 to make up for latency
                    rom_addr <= 2;
                    waiting_for_sync <= 0;
                end
            end
        else rom_addr <= rom_addr + 1;        
        end
end

//assign modulation_out = {2'b00, rom_32b[31:24], 2'b00, rom_32b[23:16], 2'b00, rom_32b[15:8], 2'b00, rom_32b[7:0]} ;
assign modulation_out = rom_out[39:0];
endmodule
