module sysmon(
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
  
  input vp,
  input vn
  );

  assign wb_err_o = 1'b0;

  reg wb_was_vld;
  wire wb_is_vld = wb_stb_i && wb_cyc_i;
  always @(posedge wb_clk_i) begin
      wb_was_vld <= wb_is_vld;
  end

  wire [15:0] xadc_dout;
  assign wb_dat_o = {16'b0, xadc_dout};

  wire [15:0] vauxp = 16'b0;
  wire [15:0] vauxn = 16'b0;

  SYSMONE1 sysmon_inst(
    // DRP
    .DI(wb_dat_i[15:0]),                      // input wire [15 : 0] di
    .DADDR(wb_adr_i[7+2:0+2]),                // input wire [7 : 0] daddr
    .DEN(wb_is_vld & ~wb_was_vld),            // input wire den  //take posedges of wishbone transaction
    .DWE(wb_we_i),                            // input wire dwe
    .DRDY(wb_ack_o),                          // output wire drdy
    .DO(xadc_dout),                           // output wire [15 : 0] do
    .DCLK(wb_clk_i),                          // input wire dclk
    // Control & Clock
    .RESET(wb_rst_i),                         // input wire reset
    .CONVST(1'b0),                            // input wire convst
    .CONVSTCLK(1'b0),                         // input wire convstclk
    // External Analog Inputs
    .VP(vp),                                  // input wire vp
    .VN(vn),                                  // input wire vn
    .VAUXP(vauxp),                            // input wire [15:0] vauxp
    .VAUXN(vauxn),                            // input wire [15:0] vauxn
    // DRP I2C
    .I2C_SCLK(),
    .I2C_SCLK_TS(),
    .I2C_SDA(),
    .I2C_SDA_TS()
  );

endmodule
