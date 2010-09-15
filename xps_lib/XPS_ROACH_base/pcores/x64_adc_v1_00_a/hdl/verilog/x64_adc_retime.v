module x64_adc_retime (
  input             wr_clk,
  input             rd_clk,
  input     [95:0]  din,
  input             dvld,
  input             rst,
  input             rd_en,
  output    [23:0]  dout,
  output            dout_sync,
  output            fifo_of, 
  output            fifo_uf,
  output            fifo_empty,
  output            dout_vld
  );

  wire [23:0] mux_dout;
  wire        mux_dout_valid;
  wire        mux_dout_sync;

  x64_adc_mux_adc_streams x64_adc_mux_adc_streams_inst (
    .clk        (wr_clk),
    .din        (din),
    .dinvld     (dvld),
    .dout       (mux_dout),
    .doutvld    (mux_dout_valid),
    .dout_sync  (mux_dout_sync)
  );
  
  wire [24:0] dout_int;
  wire fifo_full;
  wire fifo_uf_int;
  wire fifo_of_int;
  reg  rd_en_reg;
  reg  fifo_empty_reg;

  fifo_generator_v5_3 async_data_fifo_inst (
    .din        ({mux_dout_sync, mux_dout}),
    .rd_clk     (rd_clk),
    .rd_en      (rd_en_reg),
    .rst        (rst),
    .wr_clk     (wr_clk),
    .wr_en      (mux_dout_valid),
    .dout       (dout_int),
    .empty      (fifo_empty_int),
    .full       (fifo_full),
    .overflow   (fifo_of_int),
    .underflow  (fifo_uf_int)
  );

  always @(posedge rd_clk) begin
    fifo_empty_reg <= fifo_empty_int;
    rd_en_reg <= rd_en;
  end

  assign dout       =  dout_int[23:0];
  assign dout_sync  =  dout_int[24];
  assign fifo_empty =  fifo_empty_reg;

  //reg fifo_full_reg;
  //reg fifo_empty_reg;

  //always @(posedge rd_clk) begin
  //fifo_full_reg  <= fifo_full;
  //fifo_empty_reg <= fifo_empty;
  //end


  //assign fifo_of = fifo_full_reg;
  //assign fifo_uf = fifo_empty_reg;

endmodule


