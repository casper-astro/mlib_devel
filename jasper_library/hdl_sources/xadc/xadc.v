module xadc (
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
  
  input vp_in,
  input vn_in
  );

  assign wb_err_o = 1'b0;

  reg wb_was_vld;
  wire wb_is_vld = wb_stb_i && wb_cyc_i;
  always @(posedge wb_clk_i) begin
      wb_was_vld <= wb_is_vld;
  end

  wire [15:0] xadc_dout;
  assign wb_dat_o = {16'b0, xadc_dout};


  xadc_wiz_0 xadc_inst (
    .di_in(wb_dat_ri),                              // input wire [15 : 0] di_in
    .daddr_in(wb_adr_i[6+2:0+2]),                   // input wire [6 : 0] daddr_in
    .den_in(wb_is_vld & ~wb_was_vld),               // input wire den_in  //take posedges of wishbone transaction
    .dwe_in(wb_we_i),                               // input wire dwe_in
    .drdy_out(wb_ack_o),                            // output wire drdy_out
    .do_out(xadc_dout),                             // output wire [15 : 0] do_out
    .dclk_in(wb_clk_i),                             // input wire dclk_in
    //.reset_in(wb_rst_i),                          // input wire reset_in
    //.convst_in(1'b0),                             // input wire convst_in
    .vp_in(vp_in),                                  // input wire vp_in
    .vn_in(vn_in),                                  // input wire vn_in
    .user_temp_alarm_out(),                         // output wire user_temp_alarm_out
    .vccint_alarm_out(),                            // output wire vccint_alarm_out
    .vccaux_alarm_out(),                            // output wire vccaux_alarm_out
    .ot_out(),                                      // output wire ot_out
    .channel_out(),                                 // output wire [4 : 0] channel_out
    .eoc_out(),                                     // output wire eoc_out
    .vbram_alarm_out(),                             // output wire vbram_alarm_out
    .alarm_out(),                                   // output wire alarm_out
    .eos_out(),                                     // output wire eos_out
    .busy_out()                                     // output wire busy_out
  );

endmodule
