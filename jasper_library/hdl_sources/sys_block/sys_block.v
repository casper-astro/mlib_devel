module sys_block #(
    parameter     BOARD_ID = 32'h0,
    parameter     REV_MAJ  = 32'h0,
    parameter     REV_MIN  = 32'h0,
    parameter     REV_RCS  = 32'h0
  )  (
    input         user_clk,
    input         wb_clk_i,
    input         wb_rst_i,
    input         wb_cyc_i,
    input         wb_stb_i,
    input         wb_we_i,
    input   [3:0] wb_sel_i,
    input  [31:0] wb_adr_i,
    input  [31:0] wb_dat_i,
    output [31:0] wb_dat_o,
    output        wb_ack_o,
    output        wb_err_o
  );

  reg [31:0] scratchpad;
  reg [31:0] clk_counter_reg = 32'b0;

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
      if (wb_we_i) begin
        // Scratchpad write
        if (wb_adr_i[6:2] == 5'h4) begin
          scratchpad <= wb_dat_i;
        end
      end
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
      case (wb_adr_i[6:2])
        5'h0:   wb_dat_o_reg <= BOARD_ID;
        5'h1:   wb_dat_o_reg <= REV_MAJ;
        5'h2:   wb_dat_o_reg <= REV_MIN;
        5'h3:   wb_dat_o_reg <= REV_RCS;
        5'h4:   wb_dat_o_reg <= scratchpad;
        5'h5:   wb_dat_o_reg <= register_buffer + 1;
        default:
                wb_dat_o_reg <= 32'b0;
      endcase
    end
  end

  reg register_requestR;
  reg register_requestRR;

  always @(posedge user_clk) begin
    clk_counter_reg <= clk_counter_reg + 1;
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
      user_data_in_reg <= clk_counter_reg;
    end
  end
endmodule
