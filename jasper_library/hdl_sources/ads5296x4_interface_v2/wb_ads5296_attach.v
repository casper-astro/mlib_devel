module wb_ads5296_attach #(
    // Need to adapt the wishbone addressing if this isn't 4
    parameter G_NUM_UNITS = 4,
    parameter G_NUM_FCLKS = 1,
    parameter G_IS_MASTER = 0
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

    input mmcm_locked,
    output mmcm_clksel,
    output mmcm_rst,

    input [31:0] fclk_err_cnt,
    input [31:0] lclk_cnt,
    input [31:0] fclk0_cnt,
    input [31:0] fclk1_cnt,
    input [31:0] fclk2_cnt,
    input [31:0] fclk3_cnt,
    output [4*G_NUM_UNITS - 1 : 0] bitslip,

    //input user_clk,
    output [4*2*G_NUM_UNITS + G_NUM_FCLKS - 1: 0]  delay_load,
    output [4*2*G_NUM_UNITS + G_NUM_FCLKS - 1: 0]  delay_rst,
    output [4*2*G_NUM_UNITS + G_NUM_FCLKS - 1: 0]  delay_en_vtc,
    output [8 : 0] delay_val,
    output iserdes_rst
  );

  reg wb_ack;
  reg [31:0] wb_data_out_reg;

  /* registers */
  reg [4*2*G_NUM_UNITS + G_NUM_FCLKS - 1: 0]  delay_load_reg;
  reg [4*2*G_NUM_UNITS + G_NUM_FCLKS - 1: 0]  delay_rst_reg;
  reg [4*2*G_NUM_UNITS + G_NUM_FCLKS - 1: 0]  delay_en_vtc_reg;
  reg [8 : 0] delay_val_reg;
  reg [4*G_NUM_UNITS - 1 : 0] bitslip_reg;
  reg iserdes_rst_reg;
  reg mmcm_rst_reg;
  reg mmcm_clksel_reg;

  /*
  reg [4*2*G_NUM_UNITS + G_NUM_FCLKS - 1: 0]  delay_load_reg_cdc;
  reg [4*2*G_NUM_UNITS + G_NUM_FCLKS - 1: 0]  delay_rst_reg_cdc;
  reg [4*2*G_NUM_UNITS + G_NUM_FCLKS - 1: 0]  delay_en_vtc_reg_cdc;
  reg [8 : 0] delay_val_reg_cdc;
  reg [4*G_NUM_UNITS - 1 : 0] bitslip_reg_cdc;
  reg iserdes_rst_reg_cdc;
  reg mmcm_rst_reg_cdc;
  */

  assign delay_load = delay_load_reg;//_cdc;
  assign delay_rst = delay_rst_reg;//_cdc;
  assign delay_en_vtc = delay_en_vtc_reg;//_cdc;
  assign delay_val = delay_val_reg;//_cdc;
  assign iserdes_rst = iserdes_rst_reg;//_cdc;
  assign mmcm_rst = mmcm_rst_reg;//_cdc;
  assign bitslip = bitslip_reg;//_cdc;
  assign mmcm_clksel = mmcm_clksel_reg;

  reg [31:0] fclk_err_cnt_reg;
  reg [31:0] lclk_cnt_reg;
  reg [31:0] fclk0_cnt_reg;
  reg [31:0] fclk1_cnt_reg;
  reg [31:0] fclk2_cnt_reg;
  reg [31:0] fclk3_cnt_reg;
  
  /*
  reg [31:0] fclk_err_cnt_reg_cdc;
  reg [31:0] lclk_cnt_reg_cdc;
  reg [31:0] fclk0_cnt_reg_cdc;
  reg [31:0] fclk1_cnt_reg_cdc;
  reg [31:0] fclk2_cnt_reg_cdc;
  reg [31:0] fclk3_cnt_reg_cdc;

  // Handshake registers for wishbone writes
  reg register_ready; // wishbone data ready to be latched
  reg register_done;  // user clock done with wishbone data

  reg register_doneR;
  reg register_doneRR;
  reg register_readyR;
  reg register_readyRR;

  // Handshaking for wishbone reads
  reg register_read_request; // wishbone data read requester
  reg register_read_ready;   // user clock domain locked register for reading

  reg register_read_requestR;
  reg register_read_requestRR;
  reg register_read_readyR;
  reg register_read_readyRR;
  */
  
  always @(posedge wb_clk_i) begin
    // strobes
    wb_ack <= 1'b0;
    if (wb_rst_i) begin
      /*
      register_ready <= 1'b0;
      register_read_request <= 1'b0;
      */
    end else begin
      /*
      // Clock domain crossing registering
      register_doneR  <= register_done;
      register_doneRR <= register_doneR;
      register_read_readyR  <= register_read_ready;
      register_read_readyRR <= register_read_readyR;
      // Request all the user_clk registers regardless of if we're actually reading one
      if (!register_read_readyRR) begin
        // always request the buffer
        register_read_request <= 1'b1;
      end
      // When buffer is ready, release the request
      if (register_read_readyRR) begin
        register_read_request <= 1'b0;
      end
      if (register_read_readyRR && register_read_request) begin
        // only latch the data when the buffer is not locked
        fclk_err_cnt_reg_cdc <= fclk_err_cnt_reg;
        lclk_cnt_reg_cdc <= lclk_cnt_reg;
        fclk0_cnt_reg_cdc <= fclk0_cnt_reg;
        fclk1_cnt_reg_cdc <= fclk1_cnt_reg;
        fclk2_cnt_reg_cdc <= fclk2_cnt_reg;
        fclk3_cnt_reg_cdc <= fclk3_cnt_reg;
      end
      */
      if (wb_stb_i && wb_cyc_i && !wb_ack) begin
        if (wb_we_i) begin
          wb_ack <= 1'b1;
          //register_ready <= 1'b1;
          case (wb_adr_i[6:2])
            0:  begin
              delay_load_reg[4*2*G_NUM_UNITS - 1 : 0] <= wb_dat_i[4*2*G_NUM_UNITS - 1 : 0];
            end
            1:  begin
              delay_load_reg[4*2*G_NUM_UNITS + G_NUM_FCLKS - 1 : 4*2*G_NUM_UNITS] <= wb_dat_i[G_NUM_FCLKS - 1 : 0];
            end
            2:  begin
              delay_rst_reg[4*2*G_NUM_UNITS - 1 : 0] <= wb_dat_i[4*2*G_NUM_UNITS - 1 : 0];
            end
            3:  begin
              delay_rst_reg[4*2*G_NUM_UNITS + G_NUM_FCLKS - 1 : 4*2*G_NUM_UNITS] <= wb_dat_i[G_NUM_FCLKS - 1 : 0];
            end
            4:  begin
              delay_en_vtc_reg[4*2*G_NUM_UNITS - 1 : 0] <= wb_dat_i[4*2*G_NUM_UNITS - 1 : 0];
            end
            5:  begin
              delay_en_vtc_reg[4*2*G_NUM_UNITS + G_NUM_FCLKS - 1 : 4*2*G_NUM_UNITS] <= wb_dat_i[G_NUM_FCLKS - 1 : 0];
            end
            6:  begin
              delay_val_reg <= wb_dat_i[8:0];
            end
            // 7 [READ ONLY] fclk error counter
            8:  begin
              iserdes_rst_reg <= wb_dat_i[0];
            end
            9 : begin
              mmcm_rst_reg <= wb_dat_i[0];
              mmcm_clksel_reg <= wb_dat_i[8];
            end
            // 10-14 [READ ONLY] fclk error counter
            15 : begin
              bitslip_reg <= wb_dat_i[4*G_NUM_UNITS - 1:0];
            end
            default: begin
            end
          endcase
        end else begin // if (wb_we_i)
          wb_ack <= 1'b1;
          wb_data_out_reg <= 32'b0;

          case (wb_adr_i[6:2])
            0: begin
              wb_data_out_reg[4*2*G_NUM_UNITS - 1 : 0] <= delay_load_reg[4*2*G_NUM_UNITS - 1 : 0];
            end
            1: begin
              wb_data_out_reg[31 : G_NUM_FCLKS] = {(32 - G_NUM_FCLKS){1'b0}};
              wb_data_out_reg[G_NUM_FCLKS - 1 : 0] <= delay_load_reg[4*2*G_NUM_UNITS + G_NUM_FCLKS - 1 : 4*2*G_NUM_UNITS];
            end
            2: begin
              wb_data_out_reg[4*2*G_NUM_UNITS - 1 : 0] <= delay_rst_reg[4*2*G_NUM_UNITS - 1 : 0];
            end
            3: begin
              wb_data_out_reg[31 : G_NUM_FCLKS] = {(32 - G_NUM_FCLKS){1'b0}};
              wb_data_out_reg[G_NUM_FCLKS - 1 : 0] <= delay_rst_reg[4*2*G_NUM_UNITS + G_NUM_FCLKS - 1 : 4*2*G_NUM_UNITS];
            end
            4: begin
              wb_data_out_reg[4*2*G_NUM_UNITS - 1 : 0] <= delay_en_vtc_reg[4*2*G_NUM_UNITS - 1 : 0];
            end
            5: begin
              wb_data_out_reg[31 : G_NUM_FCLKS] <= {(32 - G_NUM_FCLKS){1'b0}};
              wb_data_out_reg[G_NUM_FCLKS - 1 : 0] <= delay_en_vtc_reg[4*2*G_NUM_UNITS + G_NUM_FCLKS - 1 : 4*2*G_NUM_UNITS];
            end
            6: begin
              wb_data_out_reg <= {23'b0, delay_val_reg[8:0]};
            end
            7: begin
              wb_data_out_reg[31:0] <= fclk_err_cnt[31:0];
            end
            8: begin
              wb_data_out_reg <= {31'b0, iserdes_rst_reg};
            end
            9: begin
              wb_data_out_reg <= {7'b0, G_IS_MASTER, 7'b0, mmcm_locked, 7'b0, mmcm_clksel_reg, 7'b0, mmcm_rst_reg};
            end
            10: begin
              wb_data_out_reg[31:0] <= lclk_cnt[31:0];
            end
            11: begin
              wb_data_out_reg[31:0] <= fclk0_cnt[31:0];
            end
            12: begin
              wb_data_out_reg[31:0] <= fclk1_cnt[31:0];
            end
            13: begin
              wb_data_out_reg[31:0] <= fclk2_cnt[31:0];
            end
            14: begin
              wb_data_out_reg[31:0] <= fclk3_cnt[31:0];
            end
            15: begin
              wb_data_out_reg[4*G_NUM_UNITS-1:0] <= bitslip_reg;
              wb_data_out_reg[31:4*G_NUM_UNITS] <= {(32 - (4*G_NUM_UNITS)){1'b0}};
            end
            default: begin
              wb_data_out_reg <= 32'b0;
            end
          endcase
        end // if not (wb_we_i)
      end // if wb_stb_i...
    /*
    if (register_doneRR) begin
      register_ready <= 1'b0;
    end
    */

    end // if not wb_rst_i
  end // posedge wb_clk_i

  assign wb_dat_o  = wb_ack_o ? wb_data_out_reg: 32'b0;
  assign wb_err_o  = 1'b0;
  assign wb_ack_o  = wb_ack;
  
  /*
  always @(posedge user_clk) begin
    // Wishbone writes

    // Clock domain crossing registering
    register_readyR  <= register_ready;
    register_readyRR <= register_readyR;

    if (!register_readyRR) begin
      register_done <= 1'b0;
    end

    // strobes
    delay_load_reg_cdc <= 33'b0;
    if (register_readyRR) begin
      register_done <= 1'b1;
      delay_load_reg_cdc <= delay_load_reg;
      delay_rst_reg_cdc <= delay_rst_reg;
      delay_en_vtc_reg_cdc <= delay_en_vtc_reg;
      delay_val_reg_cdc <= delay_val_reg;
      iserdes_rst_reg_cdc <= iserdes_rst_reg;
      mmcm_rst_reg_cdc <= mmcm_rst_reg;
      bitslip_reg_cdc <= bitslip_reg;
    end

    // Wishbone reads

    // Clock domain crossing registering
    register_read_requestR  <= register_read_request;
    register_read_requestRR <= register_read_requestR;

    if (register_read_requestRR) begin
      register_read_ready<= 1'b1;
    end

    if (!register_read_requestRR) begin
      register_read_ready<= 1'b0;
    end

    
    if (register_read_requestRR && !register_read_ready) begin
      register_read_ready <= 1'b1;
      fclk_err_cnt_reg <= fclk_err_cnt;
      lclk_cnt_reg <= lclk_cnt;
      fclk0_cnt_reg <= fclk0_cnt;
      fclk1_cnt_reg <= fclk1_cnt;
      fclk2_cnt_reg <= fclk2_cnt;
      fclk3_cnt_reg <= fclk3_cnt;
    end
  end
  */

endmodule
