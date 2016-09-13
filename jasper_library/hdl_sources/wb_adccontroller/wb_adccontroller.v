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
    input        psdone          
    //input        clk             
  );


  reg wb_ack;

  /*** Registers ****/

  // CPU -> adc controller register
  reg [31:0] wb_reg_3wire;
  assign adc3wire_clk    = wb_reg_3wire[0];
  assign adc3wire_data   = wb_reg_3wire[1];
  assign adc3wire_strobe = wb_reg_3wire[2];
  assign modepin         = wb_reg_3wire[3];
  reg [31:0] wb_reg_ddrb;
  assign ddrb            = wb_reg_ddrb[0];
  reg [31:0] wb_reg_mmcm;
  assign mmcm_reset      = wb_reg_mmcm[0];
  assign psclk           = wb_reg_mmcm[1];
  assign psen            = wb_reg_mmcm[2];
  assign psincdec        = wb_reg_mmcm[3];

  // adc controller -> CPU register
  reg [31:0] wb_data_out_reg;

  always @(posedge wb_clk_i) begin
    wb_ack <= 1'b0;
    if (wb_rst_i) begin
    wb_reg_3wire <= 32'b0;
    wb_reg_ddrb  <= 32'b0;
    wb_reg_mmcm  <= 32'b0;
    wb_data_out_reg <= 32'b0;
    end else begin
      if (wb_stb_i && wb_cyc_i && !wb_ack) begin
        if (wb_we_i) begin
          case (wb_adr_i[3:2])
           0:  begin
                wb_ack <= 1'b1;
                if (wb_sel_i[0]) begin
                    wb_reg_3wire[7:0] <= wb_dat_i[7:0];
                end
           end
           1:  begin
                wb_ack <= 1'b1;
                if (wb_sel_i[0]) begin
                    wb_reg_ddrb[7:0] <= wb_dat_i[7:0];
                end
           end
           2:  begin
                wb_ack <= 1'b1;
                if (wb_sel_i[0]) begin
                    wb_reg_mmcm[7:0] <= wb_dat_i[7:0];
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
