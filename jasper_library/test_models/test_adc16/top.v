// /home/jack/github/jack-h/jasper/mlib_devel/jasper_library/test_models/test_adc16/top.v, AUTOMATICALLY MODIFIED BY PYTHON

module top (
    output [0:0] test_adc16_gpio1_ext,
    input [11:0] adc16_ser_b_n,
    input [0:0] adc16_clk_line_p,
    output [0:0] test_adc16_gpio_ext,
    output adc0_adc3wire_csn2,
    input [11:0] adc16_ser_a_n,
    input [11:0] adc16_ser_b_p,
    input [11:0] adc16_ser_a_p,
    output adc0_adc3wire_csn1,
    output [2:0] adc0_adc3wire_sdata,
    output adc0_adc3wire_csn3,
    input [0:0] adc16_clk_line_n,
    output [2:0] adc0_adc3wire_sclk,
    input          sysclk_n,
    input          sysclk_p,
    
    /* SPI interface */
    input   cs_n,
    input   sclk,
    input   mosi,
    output  miso,
    
    /* Debugging LED */
    output GPIO_LED_4_LS,
    output GPIO_LED_5_LS
    
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
  
  reg [27:0] led_ctr;
  reg cs_reg;
  always @(posedge sys_clk) begin
      led_ctr <= led_ctr + 1;
      cs_reg <= cs_n;
  end

  

  assign wb_clk_i = sys_clk;
  assign wb_rst_i = wb_rstRR;

  wire new_spi_cmd;
  spi_wb_bridge spi_wb_bridge_inst (
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

  localparam N_WB_SLAVES    = 10;



  localparam SLAVE_BASE = {
    32'h00017108, // sw_in
    32'h00015108, // shared_bram
    32'h00015008, // adc16_controller
    32'h00015004, // sw_out
    32'h00013004, // shared_bram1
    32'h00013000, // sw5
    32'h00012000, // adc16_wb_ram2
    32'h00011000, // adc16_wb_ram0
    32'h00010000, // adc16_wb_ram1
    32'h00000000
  };

  localparam SLAVE_HIGH = {
    32'h0001710b, // sw_in
    32'h00017107, // shared_bram
    32'h00015107, // adc16_controller
    32'h00015007, // sw_out
    32'h00015003, // shared_bram1
    32'h00013003, // sw5
    32'h00012fff, // adc16_wb_ram2
    32'h00011fff, // adc16_wb_ram0
    32'h00010fff, // adc16_wb_ram1
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
  sys_block #(
    .BOARD_ID (12),
    .REV_MAJ  (1),
    .REV_MIN  (0),
    .REV_RCS  (32'b0)
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
    .debug_out(debug_out)

  );

  reg led_reg = 0;
  always @(posedge sys_clk) begin
      if (new_spi_cmd) begin
          led_reg <= ~led_reg;
      end
  end
  assign GPIO_LED_4_LS = debug_out[0];
  assign GPIO_LED_5_LS = led_reg;
 
// INSTANCE top, AUTOMATICALLY GENERATED BY PYTHON



  localparam ADC16_WB_RAM1_WBID0 = 1;
  localparam ADC16_WB_RAM0_WBID0 = 2;
  localparam ADC16_WB_RAM2_WBID0 = 3;
  localparam TEST_ADC16_SW5_WBID0 = 4;
  localparam TEST_ADC16_SHARED_BRAM1_WBID0 = 5;
  localparam TEST_ADC16_SW_OUT_WBID0 = 6;
  localparam WB_ADC16_CONTROLLER_WBID0 = 7;
  localparam TEST_ADC16_SHARED_BRAM_WBID0 = 8;
  localparam TEST_ADC16_SW_IN_WBID0 = 9;

  wire [31:0] test_adc16_shared_bram_data_in;
  wire adc0_clk180;
  wire adc16_snap_we;
  wire adc0_clk;
  wire [63:0] adc16_delay_rst;
  wire adc16_snap_req;
  wire [1:0] adc16_locked;
  wire [7:0] test_adc16_snap_adc_b3;
  wire [7:0] test_adc16_snap_adc_b2;
  wire user_clk;
  wire [31:0] test_adc16_shared_bram_data_out;
  wire [31:0] test_adc16_sw_out_user_data_in;
  wire [10:0] test_adc16_shared_bram1_addr;
  wire [31:0] test_adc16_shared_bram1_data_in;
  wire test_adc16_shared_bram_we;
  wire test_adc16_shared_bram1_we;
  wire [7:0] test_adc16_snap_adc_b4;
  wire [7:0] test_adc16_snap_adc_c4;
  wire [7:0] adc16_iserdes_bitslip;
  wire user_clk270;
  wire [7:0] test_adc16_snap_adc_b1;
  wire user_clk180;
  wire [10:0] test_adc16_shared_bram_addr;
  wire [7:0] test_adc16_snap_adc_c2;
  wire [9:0] adc16_snap_addr;
  wire [7:0] test_adc16_snap_adc_a1;
  wire [7:0] test_adc16_snap_adc_a2;
  wire [7:0] test_adc16_snap_adc_a3;
  wire [7:0] test_adc16_snap_adc_a4;
  wire [7:0] test_adc16_snap_adc_c3;
  wire [0:0] test_adc16_gpio1_gateway;
  wire [7:0] test_adc16_snap_adc_c1;
  wire adc16_reset;
  wire user_clk90;
  wire adc0_clk90;
  wire [4:0] adc16_delay_tap;
  wire [31:0] test_adc16_sw_in_user_data_out;
  wire [31:0] test_adc16_shared_bram1_data_out;
  wire [0:0] test_adc16_gpio_gateway;
  wire adc0_clk270;
  wire [31:0] test_adc16_sw5_user_data_in;

  // Embedded ADC16 bram
  wb_bram #(
    .LOG_USER_WIDTH(5),
    .USER_ADDR_BITS(10),
    .N_REGISTERS(2)
  ) adc16_wb_ram1 (
    .wb_we_i(wbs_we_o),
    .wb_sel_i(wbs_sel_o),
    .wb_ack_o(wbs_ack_i[ADC16_WB_RAM1_WBID0]),
    .user_din({test_adc16_snap_adc_b1, test_adc16_snap_adc_b2, test_adc16_snap_adc_b3, test_adc16_snap_adc_b4}),
    .wb_rst_i(wb_rst_i),
    .wb_err_o(wbs_err_i[ADC16_WB_RAM1_WBID0]),
    .user_clk(user_clk),
    .wb_stb_i(wbs_stb_o[ADC16_WB_RAM1_WBID0]),
    .wb_cyc_i(wbs_cyc_o[ADC16_WB_RAM1_WBID0]),
    .wb_dat_i(wbs_dat_o),
    .wb_clk_i(wb_clk_i),
    .user_addr(adc16_snap_addr),
    .user_dout(),
    .user_we(adc16_snap_we),
    .wb_dat_o(wbs_dat_i[(ADC16_WB_RAM1_WBID0+1)*32-1:(ADC16_WB_RAM1_WBID0)*32]),
    .wb_adr_i(wbs_adr_o)
  );

  // Embedded ADC16 bram
  wb_bram #(
    .LOG_USER_WIDTH(5),
    .USER_ADDR_BITS(10),
    .N_REGISTERS(2)
  ) adc16_wb_ram0 (
    .wb_we_i(wbs_we_o),
    .wb_sel_i(wbs_sel_o),
    .wb_ack_o(wbs_ack_i[ADC16_WB_RAM0_WBID0]),
    .user_din({test_adc16_snap_adc_a1, test_adc16_snap_adc_a2, test_adc16_snap_adc_a3, test_adc16_snap_adc_a4}),
    .wb_rst_i(wb_rst_i),
    .wb_err_o(wbs_err_i[ADC16_WB_RAM0_WBID0]),
    .user_clk(user_clk),
    .wb_stb_i(wbs_stb_o[ADC16_WB_RAM0_WBID0]),
    .wb_cyc_i(wbs_cyc_o[ADC16_WB_RAM0_WBID0]),
    .wb_dat_i(wbs_dat_o),
    .wb_clk_i(wb_clk_i),
    .user_addr(adc16_snap_addr),
    .user_dout(),
    .user_we(adc16_snap_we),
    .wb_dat_o(wbs_dat_i[(ADC16_WB_RAM0_WBID0+1)*32-1:(ADC16_WB_RAM0_WBID0)*32]),
    .wb_adr_i(wbs_adr_o)
  );

  // Embedded ADC16 bram
  wb_bram #(
    .LOG_USER_WIDTH(5),
    .USER_ADDR_BITS(10),
    .N_REGISTERS(2)
  ) adc16_wb_ram2 (
    .wb_we_i(wbs_we_o),
    .wb_sel_i(wbs_sel_o),
    .wb_ack_o(wbs_ack_i[ADC16_WB_RAM2_WBID0]),
    .user_din({test_adc16_snap_adc_c1, test_adc16_snap_adc_c2, test_adc16_snap_adc_c3, test_adc16_snap_adc_c4}),
    .wb_rst_i(wb_rst_i),
    .wb_err_o(wbs_err_i[ADC16_WB_RAM2_WBID0]),
    .user_clk(user_clk),
    .wb_stb_i(wbs_stb_o[ADC16_WB_RAM2_WBID0]),
    .wb_cyc_i(wbs_cyc_o[ADC16_WB_RAM2_WBID0]),
    .wb_dat_i(wbs_dat_o),
    .wb_clk_i(wb_clk_i),
    .user_addr(adc16_snap_addr),
    .user_dout(),
    .user_we(adc16_snap_we),
    .wb_dat_o(wbs_dat_i[(ADC16_WB_RAM2_WBID0+1)*32-1:(ADC16_WB_RAM2_WBID0)*32]),
    .wb_adr_i(wbs_adr_o)
  );

  // test_adc16_sw5
  wb_register_simulink2ppc  test_adc16_sw5 (
    .wb_we_i(wbs_we_o),
    .wb_sel_i(wbs_sel_o),
    .wb_ack_o(wbs_ack_i[TEST_ADC16_SW5_WBID0]),
    .wb_rst_i(wb_rst_i),
    .wb_err_o(wbs_err_i[TEST_ADC16_SW5_WBID0]),
    .user_clk(user_clk),
    .wb_stb_i(wbs_stb_o[TEST_ADC16_SW5_WBID0]),
    .wb_cyc_i(wbs_cyc_o[TEST_ADC16_SW5_WBID0]),
    .user_data_in(test_adc16_sw5_user_data_in),
    .wb_dat_i(wbs_dat_o),
    .wb_clk_i(wb_clk_i),
    .wb_dat_o(wbs_dat_i[(TEST_ADC16_SW5_WBID0+1)*32-1:(TEST_ADC16_SW5_WBID0)*32]),
    .wb_adr_i(wbs_adr_o)
  );

  // test_adc16_shared_bram1
  wb_bram #(
    .LOG_USER_WIDTH(5),
    .USER_ADDR_BITS(11),
    .N_REGISTERS(0)
  ) test_adc16_shared_bram1 (
    .wb_we_i(wbs_we_o),
    .wb_sel_i(wbs_sel_o),
    .wb_ack_o(wbs_ack_i[TEST_ADC16_SHARED_BRAM1_WBID0]),
    .user_din(test_adc16_shared_bram1_data_in),
    .wb_rst_i(wb_rst_i),
    .wb_err_o(wbs_err_i[TEST_ADC16_SHARED_BRAM1_WBID0]),
    .user_clk(user_clk),
    .wb_stb_i(wbs_stb_o[TEST_ADC16_SHARED_BRAM1_WBID0]),
    .wb_cyc_i(wbs_cyc_o[TEST_ADC16_SHARED_BRAM1_WBID0]),
    .wb_dat_i(wbs_dat_o),
    .wb_clk_i(wb_clk_i),
    .user_addr(test_adc16_shared_bram1_addr),
    .user_dout(test_adc16_shared_bram1_data_out),
    .user_we(test_adc16_shared_bram1_we),
    .wb_dat_o(wbs_dat_i[(TEST_ADC16_SHARED_BRAM1_WBID0+1)*32-1:(TEST_ADC16_SHARED_BRAM1_WBID0)*32]),
    .wb_adr_i(wbs_adr_o)
  );

  // test_adc16_sw_out
  wb_register_simulink2ppc  test_adc16_sw_out (
    .wb_we_i(wbs_we_o),
    .wb_sel_i(wbs_sel_o),
    .wb_ack_o(wbs_ack_i[TEST_ADC16_SW_OUT_WBID0]),
    .wb_rst_i(wb_rst_i),
    .wb_err_o(wbs_err_i[TEST_ADC16_SW_OUT_WBID0]),
    .user_clk(user_clk),
    .wb_stb_i(wbs_stb_o[TEST_ADC16_SW_OUT_WBID0]),
    .wb_cyc_i(wbs_cyc_o[TEST_ADC16_SW_OUT_WBID0]),
    .user_data_in(test_adc16_sw_out_user_data_in),
    .wb_dat_i(wbs_dat_o),
    .wb_clk_i(wb_clk_i),
    .wb_dat_o(wbs_dat_i[(TEST_ADC16_SW_OUT_WBID0+1)*32-1:(TEST_ADC16_SW_OUT_WBID0)*32]),
    .wb_adr_i(wbs_adr_o)
  );

  // test_adc16_gpio1
  gpio_simulink2ext #(
    .CLK_PHASE(0),
    .WIDTH(1),
    .DDR(0),
    .REG_IOB("false")
  ) test_adc16_gpio1 (
    .clk90(user_clk90),
    .io_pad(test_adc16_gpio1_ext),
    .gateway(test_adc16_gpio1_gateway),
    .clk(user_clk)
  );

  // None
  wb_adc16_controller #(
    .G_ROACH2_REV(0),
    .G_ZDOK_REV(2),
    .G_NUM_UNITS(3),
    .G_NUM_SCLK_LINES(3),
    .G_NUM_SDATA_LINES(3)
  ) wb_adc16_controller (
    .adc16_delay_rst(adc16_delay_rst),
    .adc16_snap_req(adc16_snap_req),
    .adc16_locked(adc16_locked),
    .wb_rst_i(wb_rst_i),
    .adc1_adc3wire_csn4(),
    .adc1_adc3wire_csn1(),
    .wb_cyc_i(wbs_cyc_o[WB_ADC16_CONTROLLER_WBID0]),
    .adc1_adc3wire_csn3(),
    .adc1_adc3wire_csn2(),
    .adc0_adc3wire_sdata(adc0_adc3wire_sdata),
    .wb_adr_i(wbs_adr_o),
    .wb_ack_o(wbs_ack_i[WB_ADC16_CONTROLLER_WBID0]),
    .adc1_adc3wire_sclk(),
    .adc16_iserdes_bitslip(adc16_iserdes_bitslip),
    .adc0_adc3wire_csn1(adc0_adc3wire_csn1),
    .adc0_adc3wire_csn2(adc0_adc3wire_csn2),
    .adc0_adc3wire_csn3(adc0_adc3wire_csn3),
    .adc0_adc3wire_csn4(),
    .adc0_adc3wire_sclk(adc0_adc3wire_sclk),
    .wb_dat_o(wbs_dat_i[(WB_ADC16_CONTROLLER_WBID0+1)*32-1:(WB_ADC16_CONTROLLER_WBID0)*32]),
    .wb_dat_i(wbs_dat_o),
    .wb_clk_i(wb_clk_i),
    .wb_we_i(wbs_we_o),
    .wb_sel_i(wbs_sel_o),
    .adc16_reset(adc16_reset),
    .wb_stb_i(wbs_stb_o[WB_ADC16_CONTROLLER_WBID0]),
    .wb_err_o(wbs_err_i[WB_ADC16_CONTROLLER_WBID0]),
    .adc16_delay_tap(adc16_delay_tap),
    .adc1_adc3wire_sdata()
  );

  // test_adc16_shared_bram
  wb_bram #(
    .LOG_USER_WIDTH(5),
    .USER_ADDR_BITS(11),
    .N_REGISTERS(0)
  ) test_adc16_shared_bram (
    .wb_we_i(wbs_we_o),
    .wb_sel_i(wbs_sel_o),
    .wb_ack_o(wbs_ack_i[TEST_ADC16_SHARED_BRAM_WBID0]),
    .user_din(test_adc16_shared_bram_data_in),
    .wb_rst_i(wb_rst_i),
    .wb_err_o(wbs_err_i[TEST_ADC16_SHARED_BRAM_WBID0]),
    .user_clk(user_clk),
    .wb_stb_i(wbs_stb_o[TEST_ADC16_SHARED_BRAM_WBID0]),
    .wb_cyc_i(wbs_cyc_o[TEST_ADC16_SHARED_BRAM_WBID0]),
    .wb_dat_i(wbs_dat_o),
    .wb_clk_i(wb_clk_i),
    .user_addr(test_adc16_shared_bram_addr),
    .user_dout(test_adc16_shared_bram_data_out),
    .user_we(test_adc16_shared_bram_we),
    .wb_dat_o(wbs_dat_i[(TEST_ADC16_SHARED_BRAM_WBID0+1)*32-1:(TEST_ADC16_SHARED_BRAM_WBID0)*32]),
    .wb_adr_i(wbs_adr_o)
  );

  // test_adc16_sw_in
  wb_register_ppc2simulink  test_adc16_sw_in (
    .wb_we_i(wbs_we_o),
    .wb_sel_i(wbs_sel_o),
    .wb_ack_o(wbs_ack_i[TEST_ADC16_SW_IN_WBID0]),
    .wb_rst_i(wb_rst_i),
    .wb_err_o(wbs_err_i[TEST_ADC16_SW_IN_WBID0]),
    .user_clk(user_clk),
    .wb_stb_i(wbs_stb_o[TEST_ADC16_SW_IN_WBID0]),
    .wb_cyc_i(wbs_cyc_o[TEST_ADC16_SW_IN_WBID0]),
    .wb_dat_i(wbs_dat_o),
    .wb_clk_i(wb_clk_i),
    .wb_dat_o(wbs_dat_i[(TEST_ADC16_SW_IN_WBID0+1)*32-1:(TEST_ADC16_SW_IN_WBID0)*32]),
    .user_data_out(test_adc16_sw_in_user_data_out),
    .wb_adr_i(wbs_adr_o)
  );

  // test_adc16_snap_adc
  adc16_interface #(
    .G_NUM_CLOCKS(1),
    .G_ZDOK_REV(2),
    .G_NUM_UNITS(3)
  ) test_adc16_snap_adc (
    .snap_we(adc16_snap_we),
    .snap_addr(adc16_snap_addr),
    .ser_b_p(adc16_ser_b_p),
    .snap_req(adc16_snap_req),
    .delay_tap(adc16_delay_tap),
    .b4(test_adc16_snap_adc_b4),
    .b1(test_adc16_snap_adc_b1),
    .b2(test_adc16_snap_adc_b2),
    .b3(test_adc16_snap_adc_b3),
    .ser_b_n(adc16_ser_b_n),
    .ser_a_n(adc16_ser_a_n),
    .clk_line_n(adc16_clk_line_n),
    .fabric_clk(adc0_clk),
    .clk_line_p(adc16_clk_line_p),
    .fabric_clk_180(adc0_clk180),
    .fabric_clk_270(adc0_clk270),
    .fabric_clk_90(adc0_clk90),
    .clk_frame_n(0),
    .a1(test_adc16_snap_adc_a1),
    .delay_rst(adc16_delay_rst),
    .a2(test_adc16_snap_adc_a2),
    .clk_frame_p(0),
    .a4(test_adc16_snap_adc_a4),
    .c3(test_adc16_snap_adc_c3),
    .c2(test_adc16_snap_adc_c2),
    .c1(test_adc16_snap_adc_c1),
    .c4(test_adc16_snap_adc_c4),
    .reset(adc16_reset),
    .ser_a_p(adc16_ser_a_p),
    .locked(adc16_locked),
    .a3(test_adc16_snap_adc_a3),
    .iserdes_bitslip(adc16_iserdes_bitslip)
  );

  // None
  test_adc16  test_adc16_inst (
    .test_adc16_shared_bram_data_in(test_adc16_shared_bram_data_in),
    .test_adc16_snap_adc_b4(test_adc16_snap_adc_b4),
    .test_adc16_snap_adc_b1(test_adc16_snap_adc_b1),
    .test_adc16_snap_adc_b3(test_adc16_snap_adc_b3),
    .clk(user_clk),
    .test_adc16_shared_bram_data_out(test_adc16_shared_bram_data_out),
    .test_adc16_sw_out_user_data_in(test_adc16_sw_out_user_data_in),
    .test_adc16_shared_bram1_addr(test_adc16_shared_bram1_addr),
    .test_adc16_shared_bram1_data_in(test_adc16_shared_bram1_data_in),
    .test_adc16_shared_bram1_we(test_adc16_shared_bram1_we),
    .test_adc16_snap_adc_c4(test_adc16_snap_adc_c4),
    .test_adc16_snap_adc_c2(test_adc16_snap_adc_c2),
    .test_adc16_shared_bram_addr(test_adc16_shared_bram_addr),
    .test_adc16_shared_bram_we(test_adc16_shared_bram_we),
    .test_adc16_snap_adc_a1(test_adc16_snap_adc_a1),
    .test_adc16_snap_adc_a2(test_adc16_snap_adc_a2),
    .test_adc16_snap_adc_a3(test_adc16_snap_adc_a3),
    .test_adc16_snap_adc_a4(test_adc16_snap_adc_a4),
    .test_adc16_snap_adc_c3(test_adc16_snap_adc_c3),
    .test_adc16_gpio1_gateway(test_adc16_gpio1_gateway),
    .test_adc16_snap_adc_c1(test_adc16_snap_adc_c1),
    .test_adc16_snap_adc_b2(test_adc16_snap_adc_b2),
    .test_adc16_sw_in_user_data_out(test_adc16_sw_in_user_data_out),
    .test_adc16_shared_bram1_data_out(test_adc16_shared_bram1_data_out),
    .test_adc16_gpio_gateway(test_adc16_gpio_gateway),
    .test_adc16_sw5_user_data_in(test_adc16_sw5_user_data_in)
  );

  // test_adc16_gpio
  gpio_simulink2ext #(
    .CLK_PHASE(0),
    .WIDTH(1),
    .DDR(0),
    .REG_IOB("false")
  ) test_adc16_gpio (
    .clk90(user_clk90),
    .io_pad(test_adc16_gpio_ext),
    .gateway(test_adc16_gpio_gateway),
    .clk(user_clk)
  );

  assign user_clk = adc0_clk;
  assign user_clk90 = adc0_clk90;
  assign user_clk180 = adc0_clk180;
  assign user_clk270 = adc0_clk270;

endmodule
