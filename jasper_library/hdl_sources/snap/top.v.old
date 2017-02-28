module top (
    input          sysclk_n,
    input          sysclk_p,
    
    /* SPI interface */
    input   cs_n,
    input   sclk,
    input   mosi,
    output  miso
  );
  
  wire clk_200;
  wire sys_clk;
  wire sys_clk270;
  wire sys_clk180;
  wire sys_clk90 = ~sys_clk180;

  wire rst_100;

  wire idelay_rdy;

  // Even though the oscillator is 200 MHz
  // sysclk is 100 MHz.
  // clk_200 is 200 MHz.
  snap_infrastructure infrastructure_inst (
    .sys_clk_buf_n  (sysclk_n),
    .sys_clk_buf_p  (sysclk_p),
    .sys_clk0       (sys_clk),
    .sys_clk180     (sys_clk180),
    .sys_clk270     (sys_clk270),
    .clk_200        (clk_200),
    .sys_rst        (rst_100),
    .idelay_rdy     (idelay_rdy)
  );


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


  reg wb_rstR;
  reg wb_rstRR;

  always @(posedge sys_clk) begin
    wb_rstR  <= rst_100;
    wb_rstRR <= wb_rstR;
  end
  

  assign wb_clk_i = sys_clk;
  assign wb_rst_i = wb_rstRR;

  wire new_spi_cmd;
  spi_wb_bridge #(
    .LITTLE_ENDIAN (1)
  ) spi_wb_bridge_inst (
    .wb_clk_i (wb_clk_i),
    .wb_rst_i (wb_rst_i),
    .wbm_cyc_o(wbm_cyc_o),
    .wbm_stb_o(wbm_stb_o),
    .wbm_we_o (wbm_we_o),
    .wbm_sel_o(wbm_sel_o),
    .wbm_adr_o(wbm_adr_o),
    .wbm_dat_o(wbm_dat_o),
    .wbm_dat_i(wbm_dat_i),
    .wbm_ack_i(wbm_ack_i),
    .wbm_err_i(wbm_err_i),
    .cs_n     (cs_n),
    .sclk     (sclk),
    .mosi     (mosi),
    .miso     (miso),
    .new_cmd_stb(new_spi_cmd)
    );

  localparam N_WB_SLAVES    = 1;



  localparam SLAVE_BASE = {
    32'h00000000
  };

  localparam SLAVE_HIGH = {
    32'h0000FFFF
  };

  wire    [N_WB_SLAVES - 1:0] wbs_cyc_o;
  wire    [N_WB_SLAVES - 1:0] wbs_stb_o;
  wire                        wbs_we_o;
  wire                  [3:0] wbs_sel_o;
  wire                 [31:0] wbs_adr_o;
  wire                 [31:0] wbs_dat_o;
  wire [32*N_WB_SLAVES - 1:0] wbs_dat_i;
  wire    [N_WB_SLAVES - 1:0] wbs_ack_i;
  wire    [N_WB_SLAVES - 1:0] wbs_err_i;

  wbs_arbiter #(
    .NUM_SLAVES (N_WB_SLAVES),
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

  localparam SYSBLOCK_WBID  =  0;

  wire [31:0] debug_out;
  wire user_clk;
  wire user_clk90;
  wire user_clk180;
  wire user_clk270;
  sys_block #(
    .BOARD_ID (12),
    .REV_MAJ  (1),
    .REV_MIN  (0),
    .REV_RCS  (32'b0)
  ) sys_block_inst (
    .user_clk (user_clk),
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
    .wb_err_o (wbs_err_i[SYSBLOCK_WBID])
  );

endmodule
