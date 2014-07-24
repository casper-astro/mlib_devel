module wb_register_simulink2ppc
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
    input         user_clk,
    input  [31:0] user_data_in
  );

  /* Handshake signal from OPB to application indicating new data should be latched */
  reg register_request;
  /* Handshake signal from application to OPB indicating data has been latched */
  reg register_ready;

  assign wb_err_o  = 1'b0;

  reg wb_ack_o_reg;
  assign wb_ack_o = wb_ack_o_reg;

  /* Application clock domain data buffer */
  reg [31:0] user_data_in_reg;
  /* OPB clock domain data buffer */
  reg [31:0] register_buffer;

  reg register_readyR;
  reg register_readyRR;

  always @(posedge wb_clk_i) begin
    //single cycle signals
    wb_ack_o_reg  <= 1'b0;

    register_readyR  <= register_ready;
    register_readyRR <= register_readyR;

    if (wb_rst_i) begin
      register_request <= 1'b0;
    end else if (wb_stb_i && wb_cyc_i && !wb_ack_o_reg) begin
      wb_ack_o_reg <= 1'b1;
    end

    if (register_readyRR) begin
      register_request <= 1'b0;
    end

    if (register_readyRR && register_request) begin
      /* only latch the data when the buffer is not locked */
      register_buffer <= user_data_in_reg;
    end

    if (!register_readyRR) begin
      /* always request the buffer */
      register_request <= 1'b1;
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

  reg register_requestR;
  reg register_requestRR;

  always @(posedge user_clk) begin
    register_requestR  <= register_request;
    register_requestRR <= register_requestR;

    if (register_requestRR) begin
      register_ready <= 1'b1;
    end

    if (!register_requestRR) begin
      register_ready <= 1'b0;
    end

    if (register_requestRR && !register_ready) begin
      register_ready <= 1'b1;
      user_data_in_reg <= user_data_in;
    end
  end
endmodule
