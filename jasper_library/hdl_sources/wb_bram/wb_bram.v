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
//////////////////////////////////////////////////////////////////////////////////


module wb_bram  #(
    parameter LOG_USER_WIDTH = 5,
    parameter USER_ADDR_BITS = 10,
    parameter N_REGISTERS = 1
    )(
    // wishbone interface
    input         wb_clk_i,
    input         wb_rst_i,
    output [31:0] wb_dat_o,
    output        wb_err_o,
    output        wb_ack_o,
    input  [31:0] wb_adr_i,
    input  [3:0]  wb_sel_i,
    input  [31:0] wb_dat_i,
    input         wb_we_i,
    input         wb_cyc_i,
    input         wb_stb_i,
    // user interface
    input user_clk,
    input [USER_ADDR_BITS-1:0] user_addr,
    input [USER_WIDTH-1:0] user_din,
    input user_we,
    output [USER_WIDTH-1:0] user_dout
    );
    
    localparam USER_WIDTH = 1 << LOG_USER_WIDTH;
    localparam USER_DEPTH = 1 << USER_ADDR_BITS;
    
    // Wishbone signals to RAM
    localparam LOG_WB_WIDTH = 5;
    localparam WB_WIDTH = 1 << LOG_WB_WIDTH;
    localparam WB_ADDR_BITS = USER_ADDR_BITS - LOG_WB_WIDTH + LOG_USER_WIDTH;
    localparam WB_DEPTH = 1 << WB_ADDR_BITS;
    
    reg [1+N_REGISTERS-1:0] wb_ack_sr; // a shift register to track the wb ack 
    wire [WB_ADDR_BITS-1:0] wb_ram_addr = wb_adr_i[WB_ADDR_BITS+2-1:2]; //wb address is in bytes, but ram words are 4 bytes
    wire [WB_WIDTH-1:0] wb_ram_din = wb_dat_i;
    wire [WB_WIDTH-1:0] wb_ram_dout;
    wire wb_ram_we = wb_stb_i && wb_cyc_i && (wb_ack_sr==3'b0) && wb_we_i;
    
    //Instantiate the RAM. 
    
    tdp_ram_wrapper #(
    .SIZEA(USER_DEPTH),
    .ADDRWIDTHA(USER_ADDR_BITS),
    .WIDTHA(USER_WIDTH),
    .SIZEB(WB_DEPTH),
    .ADDRWIDTHB(WB_ADDR_BITS),
    .WIDTHB(WB_WIDTH),
    .N_REGISTERS(N_REGISTERS)
    ) bram_inst (
    .clkA(user_clk),
    .weA(user_we),
    .addrA(user_addr),
    .diA(user_din),
    .doA(user_dout),
    .enaA(1'b1),
    .clkB(wb_clk_i),
    .weB(wb_ram_we),
    .addrB(wb_ram_addr),
    .diB(wb_ram_din),
    .doB(wb_ram_dout),
    .enaB(1'b1)
    );
 
    // wb command processing
        
    
    integer i;
    always @(posedge wb_clk_i) begin
        //single cycle signals
        wb_ack_sr[0] <= 1'b0;
        // delayed ack, to compensate for ram latency
        for (i=1; i<N_REGISTERS+1; i=i+1) begin
          wb_ack_sr[i] <= wb_ack_sr[i-1];
        end
        
        if (wb_rst_i) begin
          wb_ack_sr <= {(N_REGISTERS+1){1'b0}};
        end else if (wb_stb_i && wb_cyc_i && (wb_ack_sr==3'b0)) begin
          wb_ack_sr[0] <= 1'b1; // we could ack the writes immediately, but let's treat them the same as reads
        end
      end
    
      wire ram_dout_vld = wb_ack_sr[N_REGISTERS];
      assign wb_dat_o = ram_dout_vld ? wb_ram_dout : 32'b0;
      assign wb_ack_o = ram_dout_vld;
      assign wb_err_o = 1'b0;
    
endmodule
