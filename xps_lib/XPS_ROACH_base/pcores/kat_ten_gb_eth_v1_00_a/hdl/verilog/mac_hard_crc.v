`timescale 1ns/1ps

module mac_hard_crc (
    input         clk,
    input         rst,
    input  [63:0] din,
    input   [7:0] din_valid,

    output [31:0] crc_out
  );

  /******** Functions *********/
  
  /* simple bit_reverse */
  function [63:0] bit_reverse;
  input [63:0] value;
  input [63:0] size;
  integer i;
  begin
    for (i=0; i < size; i=i+1) begin
      bit_reverse[i] = value[size - 1 - i];
    end
  end
  endfunction
  
  /* reverses bit-order within byte groups */
  function [63:0] byte_reverse;
  input [63:0] value;
  input [63:0] size;
  integer i;
  begin
    for (i=0; i < size; i=i+1) begin
      byte_reverse[i] = value[(i/8)*8 + 7 - (i % 8)];
    end
  end
  endfunction
  
  /************ Transmit CRC *************/
  wire [63:0] crc_din = byte_reverse(bit_reverse(din,64),64);
  wire [31:0] crc_value;
  wire  [2:0] crc_width;
  wire        crc_valid;

  /* Xilinx CRC primitive */

  CRC64 #(
    .CRC_INIT (32'hffff_ffff)
  ) tx_crc (
    .CRCOUT        (crc_value),
    .CRCCLK        (clk),
    .CRCDATAVALID  (crc_valid),
    .CRCDATAWIDTH  (crc_width),
    .CRCIN         (crc_din),
    .CRCRESET      (rst)
  );

  assign crc_out = bit_reverse(byte_reverse(crc_value,32),32);

  reg [2:0] crc_width_reg;
  assign crc_width = crc_width_reg;
  reg crc_valid_reg;
  assign crc_valid = crc_valid_reg;

  always @(*) begin
    crc_width_reg <= 3'b000;
    crc_valid_reg <= 1'b0;

    if (din_valid[0]) 
      crc_valid_reg <= 1'b1;

    if (din_valid[1]) 
      crc_width_reg <= 3'd1;
    if (din_valid[2]) 
      crc_width_reg <= 3'd2;
    if (din_valid[3]) 
      crc_width_reg <= 3'd3;
    if (din_valid[4]) 
      crc_width_reg <= 3'd4;
    if (din_valid[5]) 
      crc_width_reg <= 3'd5;
    if (din_valid[6]) 
      crc_width_reg <= 3'd6;
    if (din_valid[7]) 
      crc_width_reg <= 3'd7;
  end

endmodule

