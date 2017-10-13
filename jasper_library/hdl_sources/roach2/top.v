module top(
    input          sys_clk_n,
    input          sys_clk_p,

    /* PPC EPB interface */
    input          ppc_perclk,
    input   [5:29] ppc_paddr,
    input    [1:0] ppc_pcsn,
    inout   [0:31] ppc_pdata,
    input    [0:3] ppc_pben,
    input          ppc_poen,
    input          ppc_pwrn,
    input          ppc_pblastn,
    output         ppc_prdy,
    output         ppc_doen
  );
  
  wire clk_200;

  wire sys_reset;

  wire sys_clk;
  wire sys_clk270;
  wire sys_clk180;
  wire sys_clk90 = ~sys_clk180;

  wire idelay_rdy;

  infrastructure infrastructure_inst (
    .sys_clk_buf_n  (sys_clk_n),
    .sys_clk_buf_p  (sys_clk_p),
    .sys_clk0       (sys_clk),
    .sys_clk180     (sys_clk180),
    .sys_clk270     (sys_clk270),
    .clk_200        (clk_200),
    .sys_rst        (sys_reset),
    .idelay_rdy     (idelay_rdy)
  );

  reg rst_200R;
  reg rst_200RR;


  wire        wb_clk_i;
  wire        wb_rst_i;
  wire        wbm_cyc_o;
  wire        wbm_stb_o;
  wire        wbm_we_o;
  wire  [3:0] wbm_sel_o;
  wire [31:0] wbm_adr_o;
  wire [31:0] wbm_dat_o;
  wire [31:0] wbm_dat_i;
  wire        wbm_ack_i;
  wire        wbm_err_i;

  wire [0:31] epb_data_i;
  wire [0:31] epb_data_o;
  wire        epb_data_oe_n;
  wire        epb_clk;

  epb_infrastructure epb_infrastructure_inst(
    .epb_data_buf  (ppc_pdata),
    .epb_data_oe_n (epb_data_oe_n),
    .epb_data_in   (epb_data_o),
    .epb_data_out  (epb_data_i),
    .per_clk       (ppc_perclk),
    .epb_clk       (epb_clk)
  );

  wire ppc_prdy_int;

  reg epb_rstR;
  reg epb_rstRR;

  always @(posedge epb_clk) begin
    epb_rstR  <= sys_reset;
    epb_rstRR <= epb_rstR;
  end

  assign wb_clk_i = epb_clk;
  assign wb_rst_i = epb_rstRR;

  epb_wb_bridge_reg epb_wb_bridge_reg_inst(
    .wb_clk_i (wb_clk_i),
    .wb_rst_i (wb_rst_i),
    .wb_cyc_o (wbm_cyc_o),
    .wb_stb_o (wbm_stb_o),
    .wb_we_o  (wbm_we_o),
    .wb_sel_o (wbm_sel_o),
    .wb_adr_o (wbm_adr_o),
    .wb_dat_o (wbm_dat_o),
    .wb_dat_i (wbm_dat_i),
    .wb_ack_i (wbm_ack_i),
    .wb_err_i (wbm_err_i),

    .epb_clk       (epb_clk),
    .epb_cs_n      (ppc_pcsn[0]),
    .epb_oe_n      (ppc_poen),
    .epb_r_w_n     (ppc_pwrn),
    .epb_be_n      (ppc_pben), 
    .epb_addr      (ppc_paddr),
    .epb_data_i    (epb_data_i),
    .epb_data_o    (epb_data_o),
    .epb_data_oe_n (epb_data_oe_n),
    .epb_rdy       (ppc_prdy_int),
    .epb_doen      (ppc_doen)
  );
  assign ppc_prdy = !ppc_pcsn[0] ? ppc_prdy_int : 1'b1;

  localparam N_WB_SLAVES    = 1;

  localparam SYSBLOCK_WBID  =  0;

  localparam SLAVE_BASE = {
    32'h00000000
  };

  localparam SLAVE_HIGH = {
    32'h0000FFFF
  };

  wire    [N_WB_SLAVES - 1:0] wbs_cyc_o;
  wire    [N_WB_SLAVES - 1:0] wbs_stb_o;
  wire                       wbs_we_o;
  wire                 [3:0] wbs_sel_o;
  wire                [31:0] wbs_adr_o;
  wire                [31:0] wbs_dat_o;
  wire [32*N_WB_SLAVES - 1:0] wbs_dat_i;
  wire    [N_WB_SLAVES - 1:0] wbs_ack_i;
  wire    [N_WB_SLAVES - 1:0] wbs_err_i;

  wbs_arbiter #(
    .NUM_SLAVES(N_WB_SLAVES),
    .SLAVE_ADDR (SLAVE_BASE),
    .SLAVE_HIGH (SLAVE_HIGH),
    .TIMEOUT    (1024)
  ) wbs_arbiter_inst (
    .wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),

    .wbm_cyc_i (wbm_cyc_o),
    .wbm_stb_i (wbm_stb_o),
    .wbm_we_i  (wbm_we_o),
    .wbm_sel_i (wbm_sel_o),
    .wbm_adr_i (wbm_adr_o),
    .wbm_dat_i (wbm_dat_o),
    .wbm_dat_o (wbm_dat_i),
    .wbm_ack_o (wbm_ack_i),
    .wbm_err_o (wbm_err_i),

    .wbs_cyc_o (wbs_cyc_o),
    .wbs_stb_o (wbs_stb_o),
    .wbs_we_o  (wbs_we_o),
    .wbs_sel_o (wbs_sel_o),
    .wbs_adr_o (wbs_adr_o),
    .wbs_dat_o (wbs_dat_o),
    .wbs_dat_i (wbs_dat_i),
    .wbs_ack_i (wbs_ack_i)
  );


  sys_block #(
    .BOARD_ID (0),
    .REV_MAJ  (0),
    .REV_MIN  (0),
    .REV_RCS  (0)
  ) sys_block_inst (
    .wb_clk_i (wb_clk_i),
    .wb_rst_i (wb_rst_i),
    .wb_cyc_i (wbs_cyc_o[SYSBLOCK_WBID]),
    .wb_stb_i (wbs_stb_o[SYSBLOCK_WBID]),
    .wb_we_i  (wbs_we_o),
    .wb_sel_i (wbs_sel_o),
    .wb_adr_i (wbs_adr_o),
    .wb_dat_i (wbs_dat_o),
    .wb_dat_o (wbs_dat_i[(SYSBLOCK_WBID+1)*32-1:(SYSBLOCK_WBID)*32]),
    .wb_ack_o (wbs_ack_i[SYSBLOCK_WBID]),
    .wb_err_o (wbs_err_i[SYSBLOCK_WBID]),
    .debug_out()
  );

endmodule
