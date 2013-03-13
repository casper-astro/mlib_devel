module bram_block_custom #(
    parameter C_PORTA_DEPTH  = 10,
    parameter C_PORTB_DEPTH  = 10,

    parameter C_PORTA_DWIDTH = 32,
    parameter C_PORTA_AWIDTH = 32,
    parameter C_PORTA_NUM_WE = 4,

    parameter C_PORTB_DWIDTH = 32,
    parameter C_PORTB_AWIDTH = 32,
    parameter C_PORTB_NUM_WE = 4,
    
    parameter OPTIMIZATION    = "Minimum_Area",
    parameter REG_CORE_OUTPUT = "true",
    parameter REG_PRIM_OUTPUT = "true"
  ) (
    input                         clk,
    input                         bram_we,
    input                         bram_en_a,
    input  [C_PORTA_DEPTH  - 1:0] bram_addr,
    output [C_PORTA_DWIDTH - 1:0] bram_rd_data,
    input  [C_PORTA_DWIDTH - 1:0] bram_wr_data,

    input                         BRAM_Rst_B,
    input                         BRAM_Clk_B,
    input                         BRAM_EN_B,
    input  [0:C_PORTB_NUM_WE - 1] BRAM_WEN_B,
    input  [0:C_PORTB_AWIDTH - 1] BRAM_Addr_B,
    output [0:C_PORTB_DWIDTH - 1] BRAM_Din_B,
    input  [0:C_PORTB_DWIDTH - 1] BRAM_Dout_B
  );

  wire                        clka  = clk;
  wire [C_PORTA_NUM_WE - 1:0] wea   = {C_PORTA_NUM_WE{bram_we}};
  wire [C_PORTA_DEPTH  - 1:0] addra = bram_addr;
  wire [C_PORTA_DWIDTH - 1:0] dina  = bram_wr_data;
  wire [C_PORTA_DWIDTH - 1:0] douta;
  assign bram_rd_data = douta;

  wire                        clkb  = BRAM_Clk_B;
  wire [C_PORTB_NUM_WE - 1:0] web   = BRAM_WEN_B;
  wire [C_PORTB_AWIDTH - 1:0] addrb = BRAM_Addr_B >> 2;
  wire [C_PORTB_DWIDTH - 1:0] dinb  = BRAM_Dout_B;
  wire [C_PORTB_DWIDTH - 1:0] doutb;
  assign BRAM_Din_B = doutb;

  bram #(
    .WE_A (C_PORTA_NUM_WE),
    .AW_A (C_PORTA_DEPTH),
    .DW_A (C_PORTA_DWIDTH),

    .WE_B (C_PORTB_NUM_WE),
    .AW_B (C_PORTB_DEPTH),
    .DW_B (C_PORTB_DWIDTH)
  ) bram_inst (
    .clka  (clka),
    .ena   (1'b1),
    .wea   (wea),
    .addra (addra),
    .dina  (dina),
    .douta (douta),
    .clkb  (clkb),
    .enb   (1'b1),
    .web   (web),
    .addrb (addrb),
    .dinb  (dinb),
    .doutb (doutb)
  );
endmodule
