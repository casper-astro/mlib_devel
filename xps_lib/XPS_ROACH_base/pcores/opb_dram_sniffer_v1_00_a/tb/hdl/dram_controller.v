module dram_controller(
    parameter DRAM_DEPTH = 16384
  ) (
    input  dram_clk,
    input  dram_rst,
    input   [31:0] dram_cmd_addr,
    input  dram_cmd_rnw,
    input  dram_cmd_valid,
    input  [143:0] dram_wr_data,
    input   [17:0] dram_wr_be,
    output [143:0] dram_rd_data,
    output dram_rd_valid,
    output dram_fifo_ready
  );


  reg [7:0] dram_data [18*16384 - 1];

  reg dram_state;
  localparam READY = 1'b0;
  localparam WAIT  = 1'b1;

  integer i;

  always @(posedge dram_clk) begin
    if (dram_rst) begin
      dram_state <= READY;
    end else begin
      case (dram_state)
        READY: begin
        end
        WAIT: begin
          dram_state <= WAIT;
        end
      endcase
    end
  end

endmodule

