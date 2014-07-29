`timescale 1ns/1ps
module sfp_mdio_controller #(
    parameter C_BASEADDR      = 32'h0,
    parameter C_HIGHADDR      = 32'hffff,
    parameter C_OPB_AWIDTH    = 32'hffff,
    parameter C_OPB_DWIDTH    = 32'hffff
  )(
    //MGT controller
    input         wb_clk_i,
    input         wb_rst_i,
    input         wb_cyc_i,
    input         wb_stb_i,
    input         wb_we_i,
    input   [3:0] wb_sel_i,
    input  [31:0] wb_adr_i,
    input  [31:0] wb_dat_i,
    output [31:0] wb_dat_o,
    output        wb_ack_o,
    output        wb_err_o,

    //GPIO controller
    input         wb_cyc_i_gpio,
    input         wb_stb_i_gpio,
    input         wb_we_i_gpio,
    input   [3:0] wb_sel_i_gpio,
    input  [31:0] wb_adr_i_gpio,
    input  [31:0] wb_dat_i_gpio,
    output [31:0] wb_dat_o_gpio,
    output        wb_ack_o_gpio,
    output        wb_err_o_gpio,
    
    inout   [11:0] mgt_gpio
  );


  wire [11:0] mgt_gpio_out;
  wire [11:0] mgt_gpio_in;
  wire [11:0] mgt_gpio_oe;
  wire [11:0] mgt_gpio_ded;


  gpio_controller #(
    .COUNT(12)
  ) gpio_mgt (
    .wb_clk_i (wb_clk_i),
    .wb_rst_i (wb_rst_i),
    .wb_cyc_i (wb_cyc_i_gpio),
    .wb_stb_i (wb_stb_i_gpio),
    .wb_we_i  (wb_we_i_gpio),
    .wb_sel_i (wb_sel_i_gpio),
    .wb_adr_i (wb_adr_i_gpio),
    .wb_dat_i (wb_dat_i_gpio),
    .wb_dat_o (wb_dat_o_gpio),
    .wb_ack_o (wb_ack_o_gpio),
    .wb_err_o (wb_err_o_gpio),

    .gpio_out (mgt_gpio_out),
    .gpio_in  (mgt_gpio_in),
    .gpio_oe  (mgt_gpio_oe),
    .gpio_ded (mgt_gpio_ded)
  );

  wire [11:0] mgt_gpio_out_buf;
  wire [11:0] mgt_gpio_oe_buf;

  genvar M;
  generate for (M = 0; M < 12; M=M+1) begin : mgt_gpio_gen
    assign mgt_gpio_out_buf[M] = mgt_gpio_ded[M] ? mgt_gpio_ded_o[M]  : mgt_gpio_out[M];
    assign mgt_gpio_oe_buf[M]  = mgt_gpio_ded[M] ? mgt_gpio_ded_oe[M] : mgt_gpio_oe[M];
  end endgenerate
  
  IOBUF #(
    .IOSTANDARD("LVCMOS15")
  ) IOBUF_mgt_gpio[3:0] (
    .IO (mgt_gpio[3:0]),
    .I  (mgt_gpio_out_buf[3:0]),
    .O  (mgt_gpio_in[3:0]),
    .T  (~mgt_gpio_oe_buf[3:0])
  );
  
// MDIO is a OPEN DRAIN pin
  IOBUF #(
    .IOSTANDARD("LVCMOS15")
  ) IOBUF_mgt_gpio_mdio0 (
    .IO (mgt_gpio[4]),
    .I  (1'b0),
    .O  (mgt_gpio_in[4]),
    .T  (mgt_gpio_out_buf[4])
  );
  
  IOBUF #(
    .IOSTANDARD("LVCMOS15")
  ) IOBUF_mgt_gpio1[4:0] (
    .IO (mgt_gpio[9:5]),
    .I  (mgt_gpio_out_buf[9:5]),
    .O  (mgt_gpio_in[9:5]),
    .T  (~mgt_gpio_oe_buf[9:5])
  );
 
// MDIO is a OPEN DRAIN pin 
  IOBUF #(
    .IOSTANDARD("LVCMOS15")
  ) IOBUF_mgt_gpio_mdio1 (
    .IO (mgt_gpio[10]),
    .I  (1'b0),
    .O  (mgt_gpio_in[10]),
    .T  (mgt_gpio_out_buf[10])
  );
  
  IOBUF #(
    .IOSTANDARD("LVCMOS15")
  ) IOBUF_mgt_gpio11 (
    .IO (mgt_gpio[11]),
    .I  (mgt_gpio_out_buf[11]),
    .O  (mgt_gpio_in[11]),
    .T  (~mgt_gpio_oe_buf[11])
  );
   
  wire sfp_mdc_0;
  wire sfp_mdio_0;
  wire sfp_mdio_oe_0;
  wire sfp_rst0_0    = 1'b0;
  wire sfp_rst1_0    = 1'b0;
  wire sfp_mdio_en_0 = 1'b1;

  wire sfp_mdc_1;
  wire sfp_mdio_1;
  wire sfp_mdio_oe_1;
  wire sfp_rst0_1    = 1'b0;
  wire sfp_rst1_1    = 1'b0;
  wire sfp_mdio_en_1 = 1'b1;

  wire [11:0] mgt_gpio_ded_o  = {1'b0, sfp_mdio_1, sfp_mdc_1, sfp_rst1_1, sfp_rst0_1, sfp_mdio_en_1,
                                 1'b0, sfp_mdio_0, sfp_mdc_0, sfp_rst1_0, sfp_rst0_0, sfp_mdio_en_0};

  wire [11:0] mgt_gpio_ded_oe = {1'b0, sfp_mdio_oe_1, 4'b1111,
                                 1'b0, sfp_mdio_oe_0, 4'b1111};

  wire mdio_sel;
  wire mdio_clk;
  wire mdio_di;
  wire mdio_do;
  wire mdio_do_i;
  wire mdio_dt; // tri-state

  emac_mdio emac_mdio (
    .wb_clk_i (wb_clk_i),
    .wb_rst_i (wb_rst_i),
    .wb_cyc_i (wb_cyc_i),
    .wb_stb_i (wb_stb_i),
    .wb_we_i  (wb_we_i),
    .wb_sel_i (wb_sel_i),
    .wb_adr_i (wb_adr_i),
    .wb_dat_i (wb_dat_i),
    .wb_dat_o (wb_dat_o),
    .wb_ack_o (wb_ack_o),
    .wb_err_o (wb_err_o),

    .reset    (wb_rst_i),
    .emac_clk (), /* not sure if needed - included anyway */

    // MDIO bus to SFP Mezzanine cards
    .mdc      (mdio_clk),     
    .mdi      (mdio_di),     
    .mdo      (mdio_do_i),    
    .mdot     (mdio_dt),
    .mdio_sel (mdio_sel)
  );
 
  // This hack is needed to change the start bit sequence from Ethernet MDIO to 10GbE MDIO
  // Ethernet MDIO start = "01"
  // 10 GbE MDIO start = "00"
   
  // bit counter of outgoing MDIO serial data 
  reg [31:0] mdio_do_iR;
  reg start_detect,start_detectR;
  always @(posedge mdio_clk) begin
    if (wb_rst_i == 1'b1) begin
       mdio_do_iR <= {32{1'b1}};
       start_detectR <= 1'b0;
    end else begin
           
      mdio_do_iR[0] <= mdio_do_i;
      mdio_do_iR[31:1] <= mdio_do_iR[30:0];

      if (mdio_do_iR == {32{1'b1}} && mdio_do_i == 1'b0) begin
         start_detectR <= 1'b1; 
      end else begin
         start_detectR <= 1'b0;
      end
      

    end 
  end

  always @(negedge mdio_clk) begin
    if (wb_rst_i == 1'b1) begin
       start_detect <= 1'b0;
    end else begin
      start_detect <= start_detectR;
    end 
  end

  assign mdio_do = (start_detect == 1'b1) ? 1'b0 : mdio_do_i; // force 2nd start bit to '0'
 
  assign mdio_di       =  mdio_sel ? mgt_gpio_in[10] : mgt_gpio_in[4];
  assign sfp_mdc_0     = !mdio_sel ? mdio_clk : 1'b1;
  assign sfp_mdc_1     =  mdio_sel ? mdio_clk : 1'b1;
  assign sfp_mdio_0    = !mdio_sel ? mdio_do  : 1'b1;
  assign sfp_mdio_1    =  mdio_sel ? mdio_do  : 1'b1;
  assign sfp_mdio_oe_0 = !mdio_sel ? !mdio_dt : 1'b0;
  assign sfp_mdio_oe_1 =  mdio_sel ? !mdio_dt : 1'b0;

endmodule
