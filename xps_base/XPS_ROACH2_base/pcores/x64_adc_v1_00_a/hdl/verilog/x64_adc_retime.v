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

  
  //bring the reset into the write clock domain
  // synthesis attribute MAX_FANOUT of rst_retimed_z is 6
  (* SHREG_EXTRACT = "NO" *) reg rst_z;
  (* SHREG_EXTRACT = "NO" *) reg rst_retimed;
  (* SHREG_EXTRACT = "NO" *) reg rst_retimed_z;
  always @(posedge wr_clk) begin
      rst_z <= rst;
      rst_retimed <= rst_z;
      rst_retimed_z <= rst_retimed;
  end


  wire [23:0] mux_dout;
  wire        mux_dout_valid;
  wire        mux_dout_sync;


  x64_adc_mux_adc_streams x64_adc_mux_adc_streams_inst (
    .clk        (wr_clk),
    .rst        (rst_retimed_z),
    .din        (din),
    .dinvld     (dvld),
    .dout       (mux_dout),
    .doutvld    (mux_dout_valid),
    .dout_sync  (mux_dout_sync)
  );
  
  // Register everything between the multiplexer and the
  // FIFO, as we desperately try to get this bloody thing
  // to compile.
  
  reg [23:0] dout_pipeline_reg;
  reg doutvld_pipeline_reg;
  reg dout_sync_pipeline_reg;
  // synthesis attribute shreg_extract of dout_pipeline_reg is NO
  // synthesis attribute shreg_extract of doutvld_pipeline_reg is NO
  // synthesis attribute shreg_extract of dout_sync_pipeline_reg is NO
  // NO NO NO NO NO NO NO NO NO NO NO NO NO NO NO NO NO NO NO NO NO 
 
  always @(posedge wr_clk) begin
    dout_pipeline_reg <= mux_dout;
    doutvld_pipeline_reg <= mux_dout_valid;
    dout_sync_pipeline_reg <= mux_dout_sync;
  end

  wire [23:0] dout_pl_int = dout_pipeline_reg;
  wire doutvld_pl_int = doutvld_pipeline_reg;
  wire dout_sync_pl_int = dout_sync_pipeline_reg;

  wire [24:0] dout_int;
  wire fifo_full;
  wire fifo_uf_int;
  wire fifo_of_int;
  reg  rd_en_reg;
  reg  fifo_empty_reg;

  fifo_generator_v5_3 async_data_fifo_inst (
    .din        ({dout_sync_pl_int, dout_pl_int}),
    .rd_clk     (rd_clk),
    .rd_en      (rd_en_reg),
    .rst        (rst_retimed_z),
    .wr_clk     (wr_clk),
    .wr_en      (doutvld_pl_int),
    .dout       (dout_int),
    .empty      (fifo_empty_int),
    .full       (fifo_full),
    .overflow   (fifo_of_int),
    .underflow  (fifo_uf_int)
  );

  reg [23:0] dout_reg;
  reg dout_sync_reg;

  always @(posedge rd_clk) begin
    fifo_empty_reg <= fifo_empty_int;
    rd_en_reg <= rd_en;
    dout_reg <= dout_int[23:0];
    dout_sync_reg <= dout_int[24];
  end

  assign dout       =  dout_reg;
  assign dout_sync  =  dout_sync_reg;
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


