`timescale 1ns/10ps

module epb32_opb_bridge(
    input         OPB_Clk,
    input         OPB_Rst,
    output        M_request,
    output        M_busLock,
    output        M_select,
    output        M_seqAddr,
    output        M_RNW,
    output  [3:0] M_BE,
    output [31:0] M_ABus,
    output [31:0] M_DBus,
    input  [31:0] OPB_DBus,
    input         OPB_xferAck,
    input         OPB_errAck,
    input         OPB_MGrant,
    input         OPB_retry,
    input         OPB_timeout,
    
    input         epb_clk,
    input         epb_cs_n,
    input         epb_oe_n,
    input         epb_r_w_n,
    input   [3:0] epb_be_n,
    input  [5:29] epb_addr,
    input  [0:31] epb_data_i,
    output [0:31] epb_data_o,
    output        epb_data_oe_n,
    output        epb_rdy,
    output        epb_doe_n
  );

//  wire [35:0] ctrl0;
//  wire [31:0] trig0,trig1,trig2,trig3; 
//
//  chipscope_icon chipscope_icon_inst(
//    .CONTROL0    (ctrl0)
//  );
//
//  chipscope_ila chipscope_ila_inst(
//    .CONTROL    (ctrl0),
//    .CLK       (epb_clk),
//    .TRIG0     (trig0),
//    .TRIG1     (trig1),
//    .TRIG2     (trig2),
//    .TRIG3     (trig3)
//  );
//
//  assign trig0 = {8'ha5,12'b0, 2'b0,epb_cs_n,epb_oe_n, epb_be_n, epb_r_w_n,epb_data_oe_n,epb_rdy,epb_doe_n};
//  assign trig1 = {epb_addr, 5'b0, 2'b0}; ;
//  assign trig2 = epb_data_i;
//  assign trig3 = OPB_DBus;

  assign M_seqAddr = 1'b0;
  assign M_busLock = 1'b1;
  assign M_request = 1'b1;

  /******* EPB Bus control ******/
  reg prev_cs_n; 
  wire epb_trans = (prev_cs_n != epb_cs_n && !epb_cs_n); 
  reg M_select_reg;

  /* Command Generation */
  always @(posedge OPB_Clk) begin
    prev_cs_n <= epb_cs_n;
    if (OPB_Rst) begin
      M_select_reg <= 1'b0;
      prev_cs_n <= 1'b1;
    end else begin
      if (epb_trans) begin
        M_select_reg <= 1'b1; 
      end

      if (OPB_xferAck) begin
        M_select_reg <= 1'b0;
      end
    end
  end

  assign epb_data_oe_n = epb_oe_n;
  assign epb_doe_n = epb_data_oe_n;
  assign epb_data_o = OPB_DBus;

  reg  [3:0] epb_be_n_reg;
  reg [24:0] epb_addr_reg;
  reg [31:0] epb_data_i_reg;
  reg        epb_r_w_n_reg;

  always @(posedge epb_clk) begin
    epb_be_n_reg   <= epb_be_n;
    epb_addr_reg   <= epb_addr;
    epb_data_i_reg <= epb_data_i;
    epb_r_w_n_reg  <= epb_r_w_n;
  end

  assign M_DBus   = M_RNW ? 32'b0 : epb_data_i_reg;
  wire [24:0] epb_addr_fixed = epb_addr_reg;
  assign M_ABus   = {epb_addr_fixed, 2'b0};
  assign M_BE       = ~epb_be_n_reg;
  assign M_RNW      = epb_r_w_n_reg;
  assign M_select = M_select_reg;
  assign epb_rdy = OPB_xferAck || OPB_errAck || OPB_timeout || OPB_retry;
  
endmodule
