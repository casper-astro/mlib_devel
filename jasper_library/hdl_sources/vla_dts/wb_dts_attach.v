`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2021 05:36:08 PM
// Design Name: 
// Module Name: wb_dts_attach
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
// Interface to 12 DTS deformatters (i.e., a VLA antenna's worth)
// 
//////////////////////////////////////////////////////////////////////////////////


module wb_dts_attach(
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
    // To DTS deformatter control interface
    input [7:0] data_in,
    output [7:0] data_out,
    output [7:0] addr_out,
    output [11:0] cs_out,
    output wrst_out,
    output rdst_out,
    output unmute_out,
    // Delay control
    output [11:0] shift_advance,
    output [11:0] shift_delay,
    output shift_rst,
    // Mux control
    output [47:0] mux_control,
    output is_three_bit,
    // Artificially create a bit error
    output [11:0] induce_error,
    // Other control signals
    input [11:0] locked
  );
  

  /* WB domain registers, to be crossed to user_clock */
  reg [31:0] control_reg_wb;
  reg [31:0] delay_control_reg_wb;
  reg [47:0] mux_control_reg_wb;
  reg is_three_bit_reg_wb;
  reg [11:0] induce_error_reg_wb;
  
  /* Handshake signal from OPB to application indicating data is ready to be latched */
  reg register_ready;
  /* Handshake signal from application to OPB indicating data has been latched */
  reg register_done;
  
  // Handshaking for wishbone reads                                                                                                                                                      
  reg register_read_request; // wishbone data read requester                                                                                                                             
  reg register_read_ready;   // user clock domain locked register for reading                                                                                                            
                                                                                                                                                                                         
  reg register_read_requestR;                                                                                                                                                            
  reg register_read_requestRR;                                                                                                                                                           
  reg register_read_readyR;                                                                                                                                                              
  reg register_read_readyRR;
  
  reg [32:0] user_data_in_reg;
  reg [32:0] user_data_in_reg_wb;

  assign wb_err_o = 1'b0;

  reg wb_ack_reg;
  assign wb_ack_o = wb_ack_reg;

  reg register_doneR;
  reg register_doneRR;

  reg register_readyR;
  reg register_readyRR;
  reg [31:0] control_reg;
  reg [31:0] delay_control_reg;
  
  // Register map
  assign addr_out = control_reg[15:8];
  assign wrst_out = control_reg[16];
  assign rdst_out = control_reg[17];
  assign unmute_out = control_reg[18];
  assign cs_out = control_reg[30:19];
  assign data_out = control_reg[7:0];
  
  assign shift_advance = delay_control_reg_wb[11:0];
  assign shift_delay = delay_control_reg_wb[23:12];
  assign shift_rst = delay_control_reg_wb[31];

  assign mux_control = mux_control_reg_wb;
  assign is_three_bit = is_three_bit_reg_wb;
  assign induce_error = induce_error_reg_wb;
  
  reg [31:0] wb_dat_reg;
  assign wb_dat_o = wb_dat_reg;

  always @(posedge wb_clk_i) begin
    //single cycle signals
    wb_ack_reg  <= 1'b0;

    /* Clock domain crossing registering */
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
      user_data_in_reg_wb <= user_data_in_reg;
    end   

    if (wb_rst_i) begin
      register_ready <= 1'b0;
      control_reg_wb <= 32'b0;
    end else if (wb_stb_i && wb_cyc_i && !wb_ack_reg) begin
      wb_ack_reg <= 1'b1;
      if (wb_we_i) begin
        register_ready <= 1'b1;
        case (wb_adr_i[5:2])
          0: control_reg_wb <= wb_dat_i;
          1: delay_control_reg_wb <= wb_dat_i;
          2: mux_control_reg_wb[31:0] <= wb_dat_i;
          3: mux_control_reg_wb[47:32] <= wb_dat_i[15:0];
          4: is_three_bit_reg_wb <= wb_dat_i[0];
          5: induce_error_reg_wb <= wb_dat_i[11:0];
        endcase
      end else begin
        case (wb_adr_i[5:2])
          0: wb_dat_reg <= user_data_in_reg_wb;
          1: wb_dat_reg <= delay_control_reg_wb;
          2: wb_dat_reg <= mux_control_reg_wb[31:0];
          3: wb_dat_reg <= {16'b0, mux_control_reg_wb[47:32]};
          4: wb_dat_reg <= {31'b0, is_three_bit_reg_wb};
          5: wb_dat_reg <= {20'b0, induce_error_reg_wb};
        endcase
      end
    end
    if (register_doneRR) begin
      register_ready <= 1'b0;
    end
  end


  always @(posedge user_clk) begin
    /* Clock domain crossing registering */
    register_readyR  <= register_ready;
    register_readyRR <= register_readyR;

    // wishbone writes
    if (!register_readyRR) begin
      register_done <= 1'b0;
    end

    if (register_readyRR) begin
      register_done <= 1'b1;
      control_reg <= control_reg_wb;
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
      user_data_in_reg <= {8'b0, 4'b0, locked, data_in};
    end 
  end
endmodule


