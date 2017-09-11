module wb_register_simulink2ppc_sync
  (
    input         wb_clk_i,
    input         wb_rst_i,
    output [31:0] wb_dat_o,
    output        wb_err_o,
    output        wb_ack_o,
    input  [31:0] wb_adr_i,
    input  [3:0]  wb_sel_i,
    input  [31:0] wb_dat_i,
    input         wb_we_i,
    input         wb_cyc_i,
    input         wb_stb_i,
    input  [31:0] user_data_in
  );


  assign wb_err_o  = 1'b0;

  reg wb_ack_o_reg;
  assign wb_ack_o = wb_ack_o_reg;

  /* Application clock domain data buffer */
  reg [31:0] user_data_in_reg;
  /* OPB clock domain data buffer */
  reg [31:0] register_buffer;

  always @(posedge wb_clk_i) begin
    //single cycle signals
    wb_ack_o_reg  <= 1'b0;

    if (wb_rst_i) begin
    end else if (wb_stb_i && wb_cyc_i && !wb_ack_o_reg) begin
      wb_ack_o_reg <= 1'b1;
      register_buffer <= user_data_in;
    end
  end

  reg [31:0] wb_dat_o_reg;
  assign wb_dat_o = wb_dat_o_reg;

  always @(*) begin
    if (!wb_ack_o_reg) begin
      wb_dat_o_reg <= 32'b0;
    end else begin
      wb_dat_o_reg[31:0] <= register_buffer;
    end
  end
endmodule
