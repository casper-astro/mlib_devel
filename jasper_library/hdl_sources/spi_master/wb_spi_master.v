module wb_spi_master#(
    parameter NBITS = 24,
    parameter NCLKDIVBITS = 5,
    parameter NCSBITS = 3
    )(

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

    // SPI
    output [NCSBITS - 1 : 0] cs_n,
    output sclk,
    output mosi,
    input miso
  );

  reg wb_ack;

  /*** Registers ****/
  reg [31:0] din_reg = 32'b0;
  reg [31:0] spi_dout_reg = 32'b0;
  reg [7:0] cs_n_reg;
  wire [NBITS-1:0] spi_dout;
  wire spi_dvld;
  
  reg spi_trigger;
  reg spi_ack;
  reg wait_for_spi = 1'b0;
   
  reg [31:0] wb_data_out_reg = 32'b0;
  reg [31:0] spi_event_count = 32'b0;

  always @(posedge wb_clk_i) begin
    // defaults
    wb_ack <= 1'b0;
    spi_trigger <= 1'b0;
    spi_ack <= 1'b0;
    if (wb_rst_i) begin
    end else begin
      if (wb_stb_i && wb_cyc_i && !wb_ack) begin
        if (wait_for_spi && spi_dvld) begin
          spi_event_count <= spi_event_count + 1'b1;
          wait_for_spi <= 1'b0;
          spi_dout_reg[NBITS-1:0] <= spi_dout;
          spi_ack <= 1'b1;
          wb_ack <= 1'b1;
        end else if (wb_we_i) begin
          case (wb_adr_i[4:2])
            // Address 0 has CS_N in byte 0
            // Writing it causes a trigger
            0:  begin
              wait_for_spi <= 1'b1;
              if (wb_sel_i[0]) begin
                cs_n_reg <= wb_dat_i[7:0];
                spi_trigger <= 1'b1;
              end
            end
            1:  begin
              wb_ack <= 1'b1;
              if (wb_sel_i[0]) begin
                din_reg[7:0] <= wb_dat_i[7:0];
              end
              if (wb_sel_i[1]) begin
                din_reg[15:8] <= wb_dat_i[15:8];
              end
              if (wb_sel_i[2]) begin
                din_reg[23:16] <= wb_dat_i[23:16];
              end
              if (wb_sel_i[3]) begin
                din_reg[31:24] <= wb_dat_i[31:24];
              end
            end
            default: begin
              wb_ack <= 1'b1;
            end
          endcase
        end else begin // if (wb_we_i)
          wb_ack <= 1'b1;
          case (wb_adr_i[4:2])
            0: begin
              wb_data_out_reg <= {24'b0, cs_n_reg};
            end
            1: begin
              wb_data_out_reg <= din_reg;
            end
            2: begin
              wb_data_out_reg[NBITS-1:0] <= spi_dout_reg[NBITS-1:0];
            end
            3: begin
              wb_data_out_reg <= spi_event_count;
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

  spi_master #(
    .NCLKDIVBITS(NCLKDIVBITS),
    .NBITS(NBITS),
    .NCSBITS(NCSBITS)
    ) uut (
    .clk(wb_clk_i),
    .cs_n_in(cs_n_reg[NCSBITS-1:0]),
    .din(din_reg[NBITS-1:0]),
    .trigger(spi_trigger),
    .ack(spi_ack),
    .dout(spi_dout),
    .dvld(spi_dvld),

    .cs_n(cs_n),
    .sclk(sclk),
    .mosi(mosi),
    .miso(miso)
  );

endmodule
