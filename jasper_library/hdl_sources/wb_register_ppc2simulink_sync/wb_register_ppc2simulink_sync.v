module wb_register_ppc2simulink_sync
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
    output [31:0] user_data_out
  );

  /* OPB clock domain data value */
  reg [31:0] reg_buffer;

  assign wb_err_o = 1'b0;

  reg wb_ack_reg;
  assign wb_ack_o = wb_ack_reg;

  always @(posedge wb_clk_i) begin
    //single cycle signals
    wb_ack_reg  <= 1'b0;
    if (wb_rst_i) begin
      reg_buffer <= 32'b0;
    end else if (wb_stb_i && wb_cyc_i && !wb_ack_reg) begin
      wb_ack_reg <= 1'b1;
      if (wb_we_i) begin
        reg_buffer <= wb_dat_i; 
      end
    end
  end

  reg [0:31] wb_dat_reg;
  assign wb_dat_o = wb_dat_reg;

  always @(*) begin
    if (!wb_ack_reg) begin
      wb_dat_reg <= 32'b0;
    end else begin
      wb_dat_reg <= reg_buffer;
    end
  end

  assign user_data_out = reg_buffer;
endmodule
