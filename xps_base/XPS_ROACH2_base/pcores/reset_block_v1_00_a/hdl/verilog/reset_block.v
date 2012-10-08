module reset_block(
    clk, ip_async_reset_i, ip_reset_i, op_reset_o
  );
  parameter WIDTH = 50;
  input  clk;
  input  ip_async_reset_i;
  input  ip_reset_i;
  output op_reset_o;

  reg [31:0] width_counter;

  reg op_reset_o;

  always @(posedge clk or posedge ip_async_reset_i) begin
    if (ip_async_reset_i) begin
      width_counter<=32'b0;
      //op_reset_o <= 1'b0;
      op_reset_o <= 1'b1; // If the input reset gets asserted => assert the output reset
`ifdef DEBUG
      $display("rb: got async reset");
`endif
    end else begin
      //op_reset_o <= (width_counter < WIDTH && delay_counter >= DELAY);
      op_reset_o <= (width_counter < WIDTH);
`ifdef SIMULATION
      /* fake initialization */
      if (width_counter === 32'hxxxx_xxxx) begin
        width_counter <= 32'b0;
        op_reset_o <= 1'b1;
      end else
`endif
      if (ip_reset_i == 1'b1) begin 
        width_counter<=32'b0;
        op_reset_o <= 1'b1; // If the input reset gets asserted => assert the output reset
      end else if (width_counter < WIDTH) begin
        width_counter<=width_counter + 1;
      end
    end
  end

endmodule
