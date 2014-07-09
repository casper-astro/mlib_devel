module sys_block #(
    parameter     BOARD_ID = 32'h0,
    parameter     REV_MAJ  = 32'h0,
    parameter     REV_MIN  = 32'h0,
    parameter     REV_RCS  = 32'h0
  )  (
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
    output        wb_err_o,
    output [31:0] debug_out
  );

  reg [31:0] scratchpad [3:0];
  assign debug_out = scratchpad[0][31:0];
  assign wb_err_o = 1'b0;

  reg wb_ack_reg;
  assign wb_ack_o = wb_ack_reg;
  always @(posedge wb_clk_i) begin
    wb_ack_reg <= 1'b0;
    if (wb_rst_i) begin
    end else begin
      if (wb_stb_i && wb_cyc_i) begin
        wb_ack_reg <= 1'b1;
      end
    end
  end

  /* wb write */
  always @(posedge wb_clk_i) begin
    if (wb_rst_i) begin
    end else begin
      if (wb_stb_i && wb_cyc_i && wb_we_i) begin
        case (wb_adr_i[6:2])
          /* TODO: add byte enables to test */
          5'h4: begin
            if (wb_sel_i[0])
              scratchpad[0][7:0] <= wb_dat_i[7:0];
            if (wb_sel_i[1])
              scratchpad[0][15:8] <= wb_dat_i[15:8];
            if (wb_sel_i[2])
              scratchpad[0][23:16] <= wb_dat_i[23:16];
            if (wb_sel_i[3])
              scratchpad[0][31:24] <= wb_dat_i[31:24];
          end
          5'h5: begin
            if (wb_sel_i[0])
              scratchpad[1][7:0] <= wb_dat_i[7:0];
            if (wb_sel_i[1])
              scratchpad[1][15:8] <= wb_dat_i[15:8];
            if (wb_sel_i[2])
              scratchpad[1][23:16]<= wb_dat_i[23:16];
            if (wb_sel_i[3])
              scratchpad[1][31:24] <= wb_dat_i[31:24];
          end
          5'h6: begin
            if (wb_sel_i[0])
              scratchpad[2][7:0] <= wb_dat_i[7:0];
            if (wb_sel_i[1])
              scratchpad[2][15:8] <= wb_dat_i[15:8];
            if (wb_sel_i[2])
              scratchpad[2][23:16] <= wb_dat_i[23:16];
            if (wb_sel_i[3])
              scratchpad[2][31:24] <= wb_dat_i[31:24];
          end
          5'h7: begin
            if (wb_sel_i[0])
              scratchpad[3][7:0] <= wb_dat_i[7:0];
            if (wb_sel_i[1])
              scratchpad[3][15:8] <= wb_dat_i[15:8];
            if (wb_sel_i[2])
              scratchpad[3][23:16] <= wb_dat_i[23:16];
            if (wb_sel_i[3])
              scratchpad[3][31:24] <= wb_dat_i[31:24];
          end
        endcase
      end
    end
  end

  /* wb read */

  reg [31:0] wb_dat_o_reg;
  assign wb_dat_o = wb_dat_o_reg;

  always @(*) begin
    case (wb_adr_i[6:2])
      5'h0:   wb_dat_o_reg <= BOARD_ID;
      5'h1:   wb_dat_o_reg <= REV_MAJ;
      5'h2:   wb_dat_o_reg <= REV_MIN;
      5'h3:   wb_dat_o_reg <= REV_RCS;
      5'h4:   wb_dat_o_reg <= scratchpad[0];
      5'h5:   wb_dat_o_reg <= scratchpad[1];
      5'h6:   wb_dat_o_reg <= scratchpad[2];
      5'h7:   wb_dat_o_reg <= scratchpad[3];
      default:
              wb_dat_o_reg <= 32'b0;
        
    endcase
  end

endmodule
