module wb_adccontroller#(
    )(
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

    output       adc3wire_clk,    
    output       adc3wire_data,   
    output       adc3wire_strobe, 
    output       modepin,         
    output       ddrb,            
    output       mmcm_reset,      
    output       psclk,           
    output       psen,            
    output       psincdec,        
    input        psdone,          
    input        clk             
  );


  reg wb_ack;

  /*** Registers ****/

  // CPU -> adc controller register
  reg [31:0] wb_reg;
  assign adc3wire_clk    = wb_reg[0];
  assign adc3wire_data   = wb_reg[1];
  assign adc3wire_strobe = wb_reg[2];
  assign modepin         = wb_reg[3];
  assign ddrb            = wb_reg[4];
  assign mmcm_reset      = wb_reg[5];
  assign psclk           = wb_reg[6];
  assign psen            = wb_reg[7];
  assign psincdec        = wb_reg[8];

  // adc controller -> CPU register
  reg [31:0] wb_data_out_reg;

  always @(posedge wb_clk_i) begin
    wb_ack <= 1'b0;
    if (wb_rst_i) begin
    wb_reg <= 32'b0;
    wb_data_out_reg <= 32'b0;
    end else begin
      if (wb_stb_i && wb_cyc_i && !wb_ack) begin
        if (wb_we_i) begin
          case (wb_adr_i[3:2])
           0:  begin
                wb_ack <= 1'b1;
                if (wb_sel_i[0]) begin
                    wb_reg[7:0] <= wb_dat_i[7:0];
                end
                if (wb_sel_i[1]) begin
                    wb_reg[15:8] <= wb_dat_i[15:8];
                end
                if (wb_sel_i[2]) begin
                    wb_reg[23:16] <= wb_dat_i[23:16];
                end
                if (wb_sel_i[3]) begin
                    wb_reg[31:24] <= wb_dat_i[31:24];
                end
           end
          endcase
        end else begin // if (wb_we_i)
          case (wb_adr_i[3:2])
           0:  begin
                   wb_ack <= 1'b1;
                   wb_data_out_reg[0] <= psdone;
               end
          endcase
        end
      end
    end
  end

  assign wb_dat_o  = wb_ack_o ? wb_data_out_reg : 32'b0;
  assign wb_err_o  = 1'b0;
  assign wb_ack_o  = wb_ack;

endmodule
