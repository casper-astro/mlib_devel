`timescale 1ns/1ps
module sfp_mdio_controller #(
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
    
    inout   [11:0] mgt_gpio
  );


// ********************* OPB to WB Bridge **********************************//

// Begin OPB to WB bridge for EMAC_MDIO controller
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

  wire cpu_trans =  OPB_select && !OPB_select_z && OPB_ABus >= C_BASEADDR+16 && OPB_ABus <= C_HIGHADDR;
  
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
  assign wb_adr_o = OPB_ABus - C_BASEADDR - 16;
  assign wb_dat_o = OPB_DBus;
  assign wb_sel_o = OPB_BE;
  assign wb_cyc_o = cpu_trans;
  assign wb_stb_o = cpu_trans;
// End OPB to WB bridge for EMAC_MDIO controller

// Begin OPB to WB bridge for GPIO_CONTROLLER
  wire wb_cyc_o_gpio;
  wire wb_stb_o_gpio;
  wire wb_we_o_gpio;
  wire [3:0]  wb_sel_o_gpio;
  wire [31:0] wb_adr_o_gpio;
  wire [31:0] wb_dat_o_gpio;
  wire [31:0] wb_dat_i_gpio;
  wire wb_ack_i_gpio;
  wire wb_err_i_gpio;
  wire cpu_trans_gpio =  OPB_select && !OPB_select_z && OPB_ABus >= C_BASEADDR && OPB_ABus < C_BASEADDR + 16;

  reg cpu_ack_reg_gpio;
  always @(posedge OPB_Clk) begin
  //strobes
  cpu_ack_reg_gpio      <= 1'b0;

  if (OPB_Rst) begin
    cpu_ack_reg_gpio    <= 1'b0;
  end else if (cpu_trans_gpio)
      cpu_ack_reg_gpio <= 1'b1;
  end

  assign wb_we_o_gpio  = (cpu_trans_gpio) ? ~OPB_RNW : 1'b0;
  assign wb_adr_o_gpio = OPB_ABus - C_BASEADDR;
  assign wb_dat_o_gpio = OPB_DBus;
  assign wb_sel_o_gpio = OPB_BE;
  assign wb_cyc_o_gpio = cpu_trans_gpio;
  assign wb_stb_o_gpio = cpu_trans_gpio;

// End OPB to WB bridge for GPIO_CONTROLLER

// Read mux of WB to OPB
  assign Sl_DBus   = (cpu_ack_reg) ? wb_dat_i :
                     (cpu_ack_reg_gpio) ? wb_dat_i_gpio :
                     32'b0;
  assign Sl_errAck = wb_err_i | wb_err_i_gpio;
  assign Sl_retry   = 1'b0; 
  assign Sl_toutSup = 1'b0;
  assign Sl_xferAck = cpu_ack_reg | cpu_ack_reg_gpio;

// ********************* OPB to WB Bridge **********************************//


  // ************ MGT GPIO CONTROLLER ************/

  wire [11:0] mgt_gpio_out;
  wire [11:0] mgt_gpio_in;
  wire [11:0] mgt_gpio_oe;
  wire [11:0] mgt_gpio_ded;


  gpio_controller #(
    .COUNT(12)
  ) gpio_mgt (
    .wb_clk_i (wb_clk_i),
    .wb_rst_i (wb_rst_i),
    .wb_cyc_i (wb_cyc_o_gpio),
    .wb_stb_i (wb_stb_o_gpio),
    .wb_we_i  (wb_we_o_gpio),
    .wb_sel_i (wb_sel_o_gpio),
    .wb_adr_i (wb_adr_o_gpio),
    .wb_dat_i (wb_dat_o_gpio),
    .wb_dat_o (wb_dat_i_gpio),
    .wb_ack_o (wb_ack_i_gpio),
    .wb_err_o (wb_err_i_gpio),

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
    .wb_cyc_i (wb_cyc_o),
    .wb_stb_i (wb_stb_o),
    .wb_we_i  (wb_we_o),
    .wb_sel_i (wb_sel_o),
    .wb_adr_i (wb_adr_o),
    .wb_dat_i (wb_dat_o),
    .wb_dat_o (wb_dat_i),
    .wb_ack_o (wb_ack_i),
    .wb_err_o (wb_err_i),

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
  reg mdio_do_iR;
  reg [7:0] bit_cnt;
  reg start_detect;
  always @(negedge mdio_clk) begin
    if (wb_rst_i == 1'b1) begin
       mdio_do_iR <= 1'b1;
       bit_cnt <= 7'h0;
       start_detect <= 1'b0;
    end else begin
           
      mdio_do_iR <= mdio_do_i;

      if (mdio_do_iR == 1'b1 && mdio_do_i == 1'b0) begin
         bit_cnt <= 7'b1;
         start_detect <= 1'b1; 
      end
      if (start_detect == 1'b1)
         bit_cnt <= bit_cnt + 1'b1;
      if (bit_cnt == 7'd32) begin
         bit_cnt <= 7'h0;
         start_detect <= 1'b0;
      end
    end 
  end

  assign mdio_do = (bit_cnt == 7'd1) ? 1'b0 : mdio_do_i; // force bit 7 (2nd start bit) to '0'
 
  assign mdio_di       =  mdio_sel ? mgt_gpio_in[10] : mgt_gpio_in[4];
  assign sfp_mdc_0     = !mdio_sel ? mdio_clk : 1'b1;
  assign sfp_mdc_1     =  mdio_sel ? mdio_clk : 1'b1;
  assign sfp_mdio_0    = !mdio_sel ? mdio_do  : 1'b1;
  assign sfp_mdio_1    =  mdio_sel ? mdio_do  : 1'b1;
  assign sfp_mdio_oe_0 = !mdio_sel ? !mdio_dt : 1'b0;
  assign sfp_mdio_oe_1 =  mdio_sel ? !mdio_dt : 1'b0;

endmodule
