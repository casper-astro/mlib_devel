module read_history_fifo #( 
    parameter FIFO_DEPTH      = 128,
    parameter FIFO_DEPTH_LOG2 = 7
  ) (
    input  clk,
    input  rst,
    input  wr_data,
    input  wr_en,
    output rd_data,
    input  rd_en
  );

  reg [FIFO_DEPTH - 1:0] fifo_data;
  /* this should explicitly be defined as a distributed ram element */
  reg [FIFO_DEPTH_LOG2 - 1:0] head_index;
  reg [FIFO_DEPTH_LOG2 - 1:0] tail_index;

  always @(posedge clk) begin
    if (rst) begin
      head_index <= 0;
      tail_index <= 0;
`ifdef SIMULATION
      fifo_data  <= {FIFO_DEPTH{1'b0}};
`endif
    end else begin
      if (wr_en) begin
        head_index <= head_index + 1;
        fifo_data[head_index] <= wr_data;
      end
      if (rd_en) begin
        tail_index <= tail_index + 1;
      end
    end
  end

  assign rd_data = fifo_data[tail_index];

endmodule
