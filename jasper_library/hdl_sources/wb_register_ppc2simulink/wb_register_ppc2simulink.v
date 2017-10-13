module wb_register_ppc2simulink
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
    output [31:0] user_data_out
  );

  /* OPB clock domain data value */
  reg [31:0] reg_buffer;
  /* Handshake signal from OPB to application indicating data is ready to be latched */
  reg register_ready;
  /* Handshake signal from application to OPB indicating data has been latched */
  reg register_done;

  assign wb_err_o = 1'b0;

  reg wb_ack_reg;
  assign wb_ack_o = wb_ack_reg;

  reg register_doneR;
  reg register_doneRR;

  always @(posedge wb_clk_i) begin
    //single cycle signals
    wb_ack_reg  <= 1'b0;

    /* Clock domain crossing registering */
    register_doneR  <= register_done;
    register_doneRR <= register_doneR;

    if (wb_rst_i) begin
      register_ready <= 1'b0;
    end else if (wb_stb_i && wb_cyc_i && !wb_ack_reg) begin
      wb_ack_reg <= 1'b1;
      if (wb_we_i) begin
        reg_buffer <= wb_dat_i; 

        register_ready <= 1'b1;
      end
    end
    if (register_doneRR) begin
      register_ready <= 1'b0;
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

  reg register_readyR;
  reg register_readyRR;
  reg [31:0] user_data_out_reg;
  assign user_data_out = user_data_out_reg;

  always @(posedge user_clk) begin
    /* Clock domain crossing registering */
    register_readyR  <= register_ready;
    register_readyRR <= register_readyR;

    if (!register_readyRR) begin
      register_done <= 1'b0;
    end

    if (register_readyRR) begin
      register_done <= 1'b1;
      user_data_out_reg <= reg_buffer;
    end

  end
endmodule
