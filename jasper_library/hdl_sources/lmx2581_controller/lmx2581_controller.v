module lmx2581_controller #(
    parameter SPI_CLK_DIV_BITS = 5
  )(
    input lmx_muxout,
    output lmx_clk,
    output lmx_data,
    output lmx_le,
    output lmx_ce,
    output lmx_be,
    // wishbone interface
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
    input         wb_stb_i
  );

  reg [31:0] wb_data_out_reg;
  reg [31:0] wb_in_reg;
  reg [31:0] lmx_in_reg;

  reg wb_ack = 0;
  always @(posedge wb_clk_i) begin
    wb_ack <= 1'b0;
    if (wb_rst_i) begin
    end else begin
      if (wb_stb_i && wb_cyc_i && !wb_ack) begin
        if (wb_we_i) begin
           wb_ack <= 1'b1;
           if (wb_sel_i[0]) begin
             wb_in_reg[7:0] <= wb_dat_i[7:0];
           end
           if (wb_sel_i[1]) begin
             wb_in_reg[15:8] <= wb_dat_i[15:8];
           end
           if (wb_sel_i[2]) begin
             wb_in_reg[23:16] <= wb_dat_i[23:16];
           end
           if (wb_sel_i[3]) begin
             wb_in_reg[31:24] <= wb_dat_i[31:24];
           end
        end else begin // if (wb_we_i)
           wb_ack <= 1'b1;
           wb_data_out_reg <= lmx_in_reg;
        end // not wb_we_i
      end // wb_stb_i && ....
    end // if not wb_rst_i
  end //wb_clk_i process

  assign wb_dat_o  = wb_ack_o ? wb_data_out_reg : 32'b0;
  assign wb_err_o  = 1'b0;
  assign wb_ack_o  = wb_ack;

  // SPI interface

  reg [SPI_CLK_DIV_BITS-1:0] spi_clk_ctr = 0;
  reg [4:0] spi_bit_ctr = 0;
  wire spi_clk = spi_clk_ctr[SPI_CLK_DIV_BITS-1];
  reg spi_clk_z = 0;
  wire spi_clk_posedge = spi_clk && ~spi_clk_z;
  wire spi_clk_negedge = ~spi_clk && spi_clk_z;

  always @(posedge wb_clk_i) begin
    if (wb_ack) begin
      spi_clk_ctr <= 0;
      spi_clk_z <= 0;
    end else begin
      spi_clk_ctr <= spi_clk_ctr + 1'b1;
      spi_clk_z <= spi_clk;
    end
  end
  
  reg [4:0] state;
  localparam START   = 5'b00001;
  localparam WRITE   = 5'b00010;
  localparam END     = 5'b00100;
  localparam LASTBIT = 5'b01000;
  localparam IDLE    = 5'b10000;


  reg [31:0] spi_bitout_reg = 0;
  reg [31:0] spi_bitin_reg = 0;
  reg le_reg = 0;
  reg enable_clk = 0;

  always @(posedge wb_clk_i) begin
    if (wb_rst_i) begin
      state <= IDLE;
    end else if (wb_ack && wb_we_i) begin //trigger SPI transaction on a wb write
      state <= START;
    end else begin
      case (state)
        START : begin
          le_reg <= 1; 
          spi_bitout_reg <= wb_in_reg;
          spi_bitin_reg <= 32'b0;
          spi_bit_ctr <= 0;
          if (spi_clk_negedge) begin
            state <= WRITE;
            le_reg <= 0;
            enable_clk <= 1;
          end
        end
        WRITE : begin
          if (spi_clk_posedge) begin
            if (spi_bit_ctr == 5'd31) begin
              state <= LASTBIT;
            end else begin
              spi_bit_ctr <= spi_bit_ctr + 1'b1;
            end
          end
          if (spi_clk_negedge) begin
            spi_bitout_reg <= {spi_bitout_reg[30:0], 1'b0};
            spi_bitin_reg <= {spi_bitin_reg[30:0], lmx_muxout};
          end
        end
        LASTBIT : begin
          if (spi_clk_negedge) begin
            spi_bitin_reg <= {spi_bitin_reg[30:0], lmx_muxout};
            le_reg <= 1;
            state <= END;
            enable_clk <= 0;
          end
        end
        END : begin
          if (spi_clk_posedge) begin
            le_reg <= 0;
            state <= IDLE;
            lmx_in_reg <= spi_bitin_reg;
          end
        end
        IDLE : begin
          le_reg <= 0;
          enable_clk <= 0;
        end
      endcase
    end
  end

  assign lmx_le   = le_reg;
  assign lmx_data = spi_bitout_reg[31];
  assign lmx_clk  = spi_clk && enable_clk;
  assign lmx_ce   = 1'b1;
  assign lmx_be   = 1'b1;

endmodule
