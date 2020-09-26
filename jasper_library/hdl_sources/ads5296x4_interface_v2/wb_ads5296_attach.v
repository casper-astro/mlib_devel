module wb_ads5296_attach #(
    // Need to adapt the wishbone addressing if this isn't 4
    parameter G_NUM_UNITS = 4
    ) (
    // Wishbone interface
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

    output [4*2*G_NUM_UNITS + 1 - 1: 0]  delay_load,
    output [4*2*G_NUM_UNITS + 1 - 1: 0]  delay_rst,
    output [4*2*G_NUM_UNITS + 1 - 1: 0]  delay_en_vtc,
    output [8 : 0] delay_val
  );

  reg wb_ack;
  reg [31:0] wb_data_out_reg;

  /* registers */
  reg [4*2*G_NUM_UNITS + 1 - 1: 0]  delay_load_reg;
  reg [4*2*G_NUM_UNITS + 1 - 1: 0]  delay_rst_reg;
  reg [4*2*G_NUM_UNITS + 1 - 1: 0]  delay_en_vtc_reg;
  reg [8 : 0] delay_val_reg;

  assign delay_load = delay_load_reg;
  assign delay_rst = delay_rst_reg;
  assign delay_en_vtc = delay_en_vtc_reg;
  assign delay_val = delay_val_reg;

  
  always @(posedge wb_clk_i) begin
    // strobes
    wb_ack <= 1'b0;
    if (wb_rst_i) begin
    end else begin
      if (wb_stb_i && wb_cyc_i && !wb_ack) begin
        if (wb_we_i) begin
          wb_ack <= 1'b1;
          case (wb_adr_i[5:2])
            0:  begin
              delay_load_reg[4*2*G_NUM_UNITS - 1 : 0] <= wb_dat_i[4*2*G_NUM_UNITS - 1 : 0];
            end
            1:  begin
              delay_load_reg[4*2*G_NUM_UNITS] <= wb_dat_i[0];
            end
            2:  begin
              delay_rst_reg[4*2*G_NUM_UNITS - 1 : 0] <= wb_dat_i[4*2*G_NUM_UNITS - 1 : 0];
            end
            3:  begin
              delay_rst_reg[4*2*G_NUM_UNITS] <= wb_dat_i[0];
            end
            4:  begin
              delay_en_vtc_reg[4*2*G_NUM_UNITS - 1 : 0] <= wb_dat_i[4*2*G_NUM_UNITS - 1 : 0];
            end
            5:  begin
              delay_en_vtc_reg[4*2*G_NUM_UNITS] <= wb_dat_i[0];
            end
            6:  begin
              delay_val_reg <= wb_dat_i[8:0];
            end
            default: begin
            end
          endcase
        end else begin // if (wb_we_i)
          wb_ack <= 1'b1;
          wb_data_out_reg <= 32'b0;
          case (wb_adr_i[5:2])
            0: begin
              wb_data_out_reg[4*2*G_NUM_UNITS - 1 : 0] <= delay_load_reg[4*2*G_NUM_UNITS - 1 : 0];
            end
            1: begin
              wb_data_out_reg[0] <= delay_load_reg[4*2*G_NUM_UNITS];
            end
            2: begin
              wb_data_out_reg[4*2*G_NUM_UNITS - 1 : 0] <= delay_rst_reg[4*2*G_NUM_UNITS - 1 : 0];
            end
            3: begin
              wb_data_out_reg[0] <= delay_rst_reg[4*2*G_NUM_UNITS];
            end
            4: begin
              wb_data_out_reg[4*2*G_NUM_UNITS - 1 : 0] <= delay_en_vtc_reg[4*2*G_NUM_UNITS - 1 : 0];
            end
            5: begin
              wb_data_out_reg[0] <= delay_en_vtc_reg[4*2*G_NUM_UNITS];
            end
            6: begin
              wb_data_out_reg[8:0] <= delay_val_reg[8:0];
            end
            default: begin
              wb_data_out_reg <= 32'b0;
            end
          endcase
        end // if not (wb_we_i)
      end // if wb_stb_i...
    end // if not wb_rst_i
  end // posedge wb_clk_i

  assign wb_dat_o  = wb_ack_o ? wb_data_out_reg: 32'b0;
  assign wb_err_o  = 1'b0;
  assign wb_ack_o  = wb_ack;

endmodule
