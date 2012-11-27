`timescale 1ns/1ps
module opb_wb_attach #(
    parameter C_BASEADDR      = 32'h0,
    parameter C_HIGHADDR      = 32'hffff,
    parameter C_OPB_AWIDTH    = 32'hffff,
    parameter C_OPB_DWIDTH    = 32'hffff
  )(
    //OPB attachment
    input         OPB_Clk,
    input         OPB_Rst,
    input         OPB_RNW,
    input         OPB_select,
    input   [3:0] OPB_BE,
    input  [31:0] OPB_ABus,
    input  [31:0] OPB_DBus,
    output [31:0] Sl_DBus,
    output        Sl_errAck,
    output        Sl_retry,
    output        Sl_toutSup,
    output        Sl_xferAck,
    inout         OPB_seqAddr,

    //WB attachment
    output wb_cyc_o,
    output wb_stb_o,
    output wb_we_o,
    output [3:0]  wb_sel_o,
    output [31:0] wb_adr_o,
    output [31:0] wb_dat_o,
    input [31:0] wb_dat_i,
    input wb_ack_i,
    input wb_err_i

  );
// ********************* OPB to WB Bridge **********************************//

// Begin OPB to WB attach
  wire wb_cyc_o;
  wire wb_stb_o;
  wire wb_we_o;
  wire [3:0]  wb_sel_o;
  wire [31:0] wb_adr_o;
  wire [31:0] wb_dat_o;
  wire [31:0] wb_dat_i;
  wire wb_ack_i;
  wire wb_err_i;

  reg OPB_select_z;
  always @(posedge OPB_Clk) begin
    OPB_select_z <= OPB_select;
  end

  wire cpu_trans =  OPB_select && !OPB_select_z && OPB_ABus >= C_BASEADDR && OPB_ABus <= C_HIGHADDR;
  
  reg cpu_ack_reg;
  always @(posedge OPB_Clk) begin
  //strobes
  cpu_ack_reg      <= 1'b0;

  if (OPB_Rst) begin
    cpu_ack_reg    <= 1'b0;
  end else if (cpu_trans)
      cpu_ack_reg <= 1'b1;
  end

  assign wb_clk_i = OPB_Clk;
  assign wb_rst_i = OPB_Rst;
  assign wb_we_o  = (cpu_trans) ? ~OPB_RNW : 1'b0;
  assign wb_adr_o = OPB_ABus - C_BASEADDR;
  assign wb_dat_o = OPB_DBus;
  assign wb_sel_o = OPB_BE;
  assign wb_cyc_o = cpu_trans;
  assign wb_stb_o = cpu_trans;

// Read mux of WB to OPB
  assign Sl_DBus   = (cpu_ack_reg) ? wb_dat_i :
                     32'b0;
  assign Sl_errAck = wb_err_i;
  assign Sl_retry   = 1'b0; 
  assign Sl_toutSup = 1'b0;
  assign Sl_xferAck = cpu_ack_reg;
// End OPB to WB attach 

endmodule
