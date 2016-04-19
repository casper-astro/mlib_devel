module timeout(
    clk, reset,
    timeout
  );
  parameter TIMEOUT = 20'b0;

  input  clk, reset;
  output timeout;

  reg [19:0] counter;

  assign timeout = TIMEOUT == 0 ? 1'b0 : counter >= TIMEOUT;

  always @(posedge clk) begin
    if (reset | timeout) begin
      counter <= 20'b0;
    end else begin
      counter <= counter + 20'b1;
    end
  end
endmodule
