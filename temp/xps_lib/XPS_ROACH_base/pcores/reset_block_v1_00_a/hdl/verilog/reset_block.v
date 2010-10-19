module reset_block(
    clk, async_reset_i, reset_i, reset_o
  );
  parameter DELAY = 10;
  parameter WIDTH = 50;
  input  clk;
  input  async_reset_i;
  input  reset_i;
  output reset_o;

  reg [31:0] delay_counter;
  reg [31:0] width_counter;

  reg reset_o;

  always @(posedge clk or posedge async_reset_i) begin
    if (async_reset_i) begin
      delay_counter<=32'b0;
      width_counter<=32'b0;
      reset_o <= 1'b0;
`ifdef DEBUG
      $display("rb: got async reset");
`endif
    end else begin
      reset_o <= (width_counter < WIDTH && delay_counter >= DELAY);
`ifdef SIMULATION
      /* fake initialization */
      if (delay_counter === 32'hxxxx_xxxx) begin
        delay_counter <= 32'b0;
      end else if (width_counter === 32'hxxxx_xxxx) begin
        width_counter <= 32'b0;
      end else
`endif
      if (delay_counter < DELAY) begin
        delay_counter<=delay_counter + 1;
      end else if (width_counter < WIDTH) begin
        width_counter<=width_counter + 1;
      end else if (reset_i == 1'b1) begin 
        delay_counter<=32'b0;
        width_counter<=32'b0;
      end
    end
  end

endmodule
