module opb_dram_sniffer #(
    parameter ENABLE          = 0,
    parameter CTRL_C_BASEADDR = 0,
    parameter CTRL_C_HIGHADDR = 0,
    parameter MEM_C_BASEADDR  = 0,
    parameter MEM_C_HIGHADDR  = 0
  )(
    input  ctrl_OPB_Clk,
    input  ctrl_OPB_Rst,
    output [0:31] ctrl_Sl_DBus,
    output ctrl_Sl_errAck,
    output ctrl_Sl_retry,
    output ctrl_Sl_toutSup,
    output ctrl_Sl_xferAck,
    input  [0:31] ctrl_OPB_ABus,
    input  [0:3]  ctrl_OPB_BE,
    input  [0:31] ctrl_OPB_DBus,
    input  ctrl_OPB_RNW,
    input  ctrl_OPB_select,
    input  ctrl_OPB_seqAddr,

    input  mem_OPB_Clk,
    input  mem_OPB_Rst,
    output [0:31] mem_Sl_DBus,
    output mem_Sl_errAck,
    output mem_Sl_retry,
    output mem_Sl_toutSup,
    output mem_Sl_xferAck,
    input  [0:31] mem_OPB_ABus,
    input  [0:3]  mem_OPB_BE,
    input  [0:31] mem_OPB_DBus,
    input  mem_OPB_RNW,
    input  mem_OPB_select,
    input  mem_OPB_seqAddr,

    input  dram_clk,
    input  dram_rst,
    input  phy_ready,

    output  [31:0] dram_cmd_addr,
    output dram_cmd_rnw,
    output dram_cmd_valid,
    output [143:0] dram_wr_data,
    output  [17:0] dram_wr_be,
    input  [143:0] dram_rd_data,
    input  dram_rd_valid,
    input  dram_fifo_ready,

    input   [31:0] app_cmd_addr,
    input  app_cmd_rnw,
    input  app_cmd_valid,
    output app_cmd_ack,
    input  [143:0] app_wr_data,
    input   [17:0] app_wr_be,
    output [143:0] app_rd_data,
    output app_rd_valid
  );
generate if (ENABLE) begin : sniffer_enabled

  wire [15:0] software_address_bits;

  ctrl_opb_attach #(
    .C_BASEADDR   (CTRL_C_BASEADDR),
    .C_HIGHADDR   (CTRL_C_HIGHADDR)
  ) ctrl_opb_attach_inst (
    .OPB_Clk     (ctrl_OPB_Clk),
    .OPB_Rst     (ctrl_OPB_Rst),
    .Sl_DBus     (ctrl_Sl_DBus),
    .Sl_errAck   (ctrl_Sl_errAck),
    .Sl_retry    (ctrl_Sl_retry),
    .Sl_toutSup  (ctrl_Sl_toutSup),
    .Sl_xferAck  (ctrl_Sl_xferAck),
    .OPB_ABus    (ctrl_OPB_ABus),
    .OPB_BE      (ctrl_OPB_BE),
    .OPB_DBus    (ctrl_OPB_DBus),
    .OPB_RNW     (ctrl_OPB_RNW),
    .OPB_select  (ctrl_OPB_select),
    .OPB_seqAddr (ctrl_OPB_seqAddr),

    .software_address_bits (software_address_bits),
    .phy_ready             (phy_ready)
  );

  wire sniff_cmd_en;
  wire sniff_cmd_rnw;
  wire  [31:0] sniff_address;
  wire [143:0] sniff_wr_data;
  wire  [17:0] sniff_wr_be;
  wire [143:0] sniff_rd_data;
  wire sniff_rd_dvld;
  wire sniff_ack;

  mem_opb_attach #(
    .C_BASEADDR   (MEM_C_BASEADDR),
    .C_HIGHADDR   (MEM_C_HIGHADDR)
  ) mem_opb_attach_inst (
    .OPB_Clk     (mem_OPB_Clk),
    .OPB_Rst     (mem_OPB_Rst),
    .Sl_DBus     (mem_Sl_DBus),
    .Sl_errAck   (mem_Sl_errAck),
    .Sl_retry    (mem_Sl_retry),
    .Sl_toutSup  (mem_Sl_toutSup),
    .Sl_xferAck  (mem_Sl_xferAck),
    .OPB_ABus    (mem_OPB_ABus),
    .OPB_BE      (mem_OPB_BE),
    .OPB_DBus    (mem_OPB_DBus),
    .OPB_RNW     (mem_OPB_RNW),
    .OPB_select  (mem_OPB_select),
    .OPB_seqAddr (mem_OPB_seqAddr),

    .dram_clk     (dram_clk),
    .dram_rst     (dram_rst),

    .dram_cmd_en  (sniff_cmd_en),
    .dram_cmd_rnw (sniff_cmd_rnw),
    .dram_wr_data (sniff_wr_data),
    .dram_wr_be   (sniff_wr_be),
    .dram_address (sniff_address),
    .dram_rd_data (sniff_rd_data),
    .dram_rd_dvld (sniff_rd_dvld),
    .dram_ack     (sniff_ack)
  );
  
  wire [31:0] sniff_cmd_address = {software_address_bits[8:0], sniff_address[20:0], 2'b0};
  /* TODO: finalize the software address width */

  /* Pipeline to improve timing, almost full control permit this approach */
  wire [144 - 1:0] dram_wr_data_int;
  wire  [18 - 1:0] dram_wr_be_int;
  wire             dram_cmd_valid_int;
  wire  [32 - 1:0] dram_cmd_addr_int;
  wire             dram_cmd_rnw_int;
  reg  [144 - 1:0] dram_wr_data_reg;
  reg   [18 - 1:0] dram_wr_be_reg;
  reg              dram_cmd_valid_reg;
  reg   [32 - 1:0] dram_cmd_addr_reg;
  reg              dram_cmd_rnw_reg;

  always @(posedge dram_clk) begin
    dram_wr_data_reg   <= dram_wr_data_int;
    dram_wr_be_reg     <= dram_wr_be_int;
    dram_cmd_valid_reg <= dram_cmd_valid_int;
    dram_cmd_addr_reg  <= dram_cmd_addr_int;
    dram_cmd_rnw_reg   <= dram_cmd_rnw_int;
  end
  assign dram_wr_data   = dram_wr_data_reg;
  assign dram_wr_be     = dram_wr_be_reg;
  assign dram_cmd_valid = dram_cmd_valid_reg;
  assign dram_cmd_addr  = dram_cmd_addr_reg;
  assign dram_cmd_rnw   = dram_cmd_rnw_reg;

  dram_arbiter dram_arbiter(
    .clk(dram_clk),
    .rst(dram_rst),

    .master_cmd_addr   (dram_cmd_addr_int),
    .master_cmd_rnw    (dram_cmd_rnw_int),
    .master_cmd_valid  (dram_cmd_valid_int),
    .master_wr_data    (dram_wr_data_int),
    .master_wr_be      (dram_wr_be_int),

    .master_rd_data    (dram_rd_data),
    .master_rd_valid   (dram_rd_valid),
    .master_fifo_ready (dram_fifo_ready),

    .slave1_cmd_addr  (sniff_cmd_address), //already shifted: TODO - should change
    .slave1_cmd_rnw   (sniff_cmd_rnw),
    .slave1_cmd_valid (sniff_cmd_en),
    .slave1_wr_data   (sniff_wr_data),
    .slave1_wr_be     (sniff_wr_be),
    .slave1_rd_data   (sniff_rd_data),
    .slave1_rd_valid  (sniff_rd_dvld),
    .slave1_ack       (sniff_ack),

    .slave0_cmd_addr  (app_cmd_addr << 2),
    .slave0_cmd_rnw   (app_cmd_rnw),
    .slave0_cmd_valid (app_cmd_valid),
    .slave0_wr_data   (app_wr_data),
    .slave0_wr_be     (app_wr_be),
    .slave0_rd_data   (app_rd_data),
    .slave0_rd_valid  (app_rd_valid),
    .slave0_ack       (app_cmd_ack)
  );

end else begin : sniffer_disabled
    assign ctrl_Sl_DBus    = 32'b0;
    assign ctrl_Sl_errAck  = 1'b0;
    assign ctrl_Sl_retry   = 1'b0;
    assign ctrl_Sl_toutSup = 1'b0;
    assign ctrl_Sl_xferAck = 1'b0;

    assign mem_Sl_DBus    = 32'b0;
    assign mem_Sl_errAck  = 1'b0;
    assign mem_Sl_retry   = 1'b0;
    assign mem_Sl_toutSup = 1'b0;
    assign mem_Sl_xferAck = 1'b0;

    assign dram_cmd_addr  = app_cmd_addr << 2;
    assign dram_cmd_rnw   = app_cmd_rnw;
    assign dram_cmd_valid = app_cmd_valid;
    assign dram_wr_data   = app_wr_data;
    assign dram_wr_be     = app_wr_be;
    assign app_rd_data    = dram_rd_data;
    assign app_rd_valid   = dram_rd_valid;

    assign app_cmd_ack    = dram_fifo_ready;

end endgenerate

endmodule
