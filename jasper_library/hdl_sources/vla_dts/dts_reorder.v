`timescale 1ns / 1ps

module dts_reorder #(
    parameter N_INPUTS = 12,
    parameter INPUT_WIDTH = 128,
    parameter SELECT_WIDTH = 4
  ) (
    input clk,
    input [SELECT_WIDTH-1:0] sel,

    input [INPUT_WIDTH * N_INPUTS - 1:0] din,
    input [N_INPUTS - 1:0] din_locked,
    input [N_INPUTS - 1:0] din_one_sec,
    input [N_INPUTS - 1:0] din_ten_sec,
    input [N_INPUTS - 1:0] din_index,
    input [N_INPUTS - 1:0] din_sync,
       
    output [INPUT_WIDTH-1 : 0] dout,
    output dout_locked,
    output dout_one_sec,
    output dout_ten_sec,
    output dout_index,
    output dout_sync
  );

  // Mux output registers
  reg [INPUT_WIDTH-1 : 0] dout_reg;
  reg dout_locked_reg;
  reg dout_one_sec_reg;
  reg dout_ten_sec_reg;
  reg dout_index_reg;
  reg dout_sync_reg;

  always @(posedge clk) begin
    // equivalent to din[(sel+1)*INPUT_WIDTH-1:sel*INPUT_WIDTH]; which
    // verilog doesn't permit for non-constant `sel`
    dout_reg <= din[(sel+1)*INPUT_WIDTH-1 -: INPUT_WIDTH];
    dout_locked_reg  <= din_locked[sel];
    dout_one_sec_reg <= din_one_sec[sel];
    dout_ten_sec_reg <= din_ten_sec[sel];
    dout_index_reg   <= din_index[sel];
    dout_sync_reg    <= din_sync[sel];
  end

  // output assignments
  assign dout         = dout_reg;
  assign dout_locked  = dout_locked_reg;
  assign dout_one_sec = dout_one_sec_reg;
  assign dout_ten_sec = dout_ten_sec_reg;
  assign dout_index   = dout_index_reg;
  assign dout_sync    = dout_sync_reg;

endmodule
