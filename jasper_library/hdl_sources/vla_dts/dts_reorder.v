`timescale 1ns / 1ps

module dts_reorder #(
    parameter NINPUTS = 12,
    parameter INPUT_WIDTH = 128,
    parameter SELECT_WIDTH = 4
  ) (
    input clk,
    input [SELECT_WIDTH-1:0] sel,

    input [INPUT_WIDTH * NINPUTS - 1:0] din,
    input [NINPUTS - 1:0] din_locked,
    input [NINPUTS - 1:0] din_one_sec,
    input [NINPUTS - 1:0] din_ten_sec,
    input [NINPUTS - 1:0] din_index,
    input [NINPUTS - 1:0] din_sync,
       
    output [INPUT_WIDTH-1 : 0] dout,
    output dout_locked,
    output dout_one_sec,
    output dout_ten_sec,
    output dout_index,
    output dout_sync
  );

  // Mux output wires
  wire [INPUT_WIDTH-1 : 0] dout_int;
  wire dout_locked_int;
  wire dout_one_sec_int;
  wire dout_ten_sec_int;
  wire dout_index_int;
  wire dout_sync_int;

  // Mux output registers
  reg [INPUT_WIDTH-1 : 0] dout_reg;
  reg dout_locked_reg;
  reg dout_one_sec_reg;
  reg dout_ten_sec_reg;
  reg dout_index_reg;
  reg dout_sync_reg;

  // output assignments
  assign dout         = dout_reg;
  assign dout_locked  = dout_locked_reg;
  assign dout_one_sec = dout_one_sec_reg;
  assign dout_ten_sec = dout_ten_sec_reg;
  assign dout_index   = dout_index_reg;
  assign dout_sync    = dout_sync_reg;

  // The actual multiplexor
  assign dout_int         = din >> (INPUT_WIDTH * sel);
  assign dout_locked_int  = din_locked  >> sel;
  assign dout_one_sec_int = din_one_sec >> sel;
  assign dout_ten_sec_int = din_ten_sec >> sel;
  assign dout_index_int   = din_index   >> sel;
  assign dout_sync_int    = din_sync    >> sel;

  always @(posedge clk) begin
    dout_reg         = dout_int;
    dout_locked_reg  = dout_locked_int;
    dout_one_sec_reg = dout_one_sec_int;
    dout_ten_sec_reg = dout_ten_sec_int;
    dout_index_reg   = dout_index_int;
    dout_sync_reg    = dout_sync_int;
  end

endmodule
