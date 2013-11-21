module opb_dram_sniffer #(
    parameter ENABLE          = 0,
    parameter CTRL_C_BASEADDR = 0,
    parameter CTRL_C_HIGHADDR = 0,
    parameter MEM_C_BASEADDR  = 0,
    parameter MEM_C_HIGHADDR  = 0
  )(
    input 	   ctrl_OPB_Clk,
    input 	   ctrl_OPB_Rst,
    output [0:31]  ctrl_Sl_DBus,
    output 	   ctrl_Sl_errAck,
    output 	   ctrl_Sl_retry,
    output 	   ctrl_Sl_toutSup,
    output 	   ctrl_Sl_xferAck,
    input [0:31]   ctrl_OPB_ABus,
    input [0:3]    ctrl_OPB_BE,
    input [0:31]   ctrl_OPB_DBus,
    input 	   ctrl_OPB_RNW,
    input 	   ctrl_OPB_select,
    input 	   ctrl_OPB_seqAddr,

    input 	   mem_OPB_Clk,
    input 	   mem_OPB_Rst,
    output [0:31]  mem_Sl_DBus,
    output 	   mem_Sl_errAck,
    output 	   mem_Sl_retry,
    output 	   mem_Sl_toutSup,
    output 	   mem_Sl_xferAck,
    input [0:31]   mem_OPB_ABus,
    input [0:3]    mem_OPB_BE,
    input [0:31]   mem_OPB_DBus,
    input 	   mem_OPB_RNW,
    input 	   mem_OPB_select,
    input 	   mem_OPB_seqAddr,

    input 	   dram_clk,
    input 	   dram_rst,
    input 	   phy_ready,

    input [287:0]  ddr3_rd_data,
    input 	   ddr3_rd_data_end,
    input 	   ddr3_rd_data_valid,
    input 	   ddr3_rdy,
    input 	   ddr3_wdf_rdy,
    output [31:0]  ddr3_addr,
    output [2:0]   ddr3_cmd,
    output 	   ddr3_en,
    output [287:0] ddr3_wdf_data,
    output 	   ddr3_wdf_end,
    output [35:0]  ddr3_wdf_mask,
    output 	   ddr3_wdf_wren,
    
    output [287:0] app_rd_data,
    output 	   app_rd_data_end,
    output 	   app_rd_data_valid,
    output 	   app_rdy,
    output 	   app_wdf_rdy,
    input [31:0]   app_addr,
    input [2:0]    app_cmd,
    input 	   app_en,
    input [287:0]  app_wdf_data,
    input 	   app_wdf_end,
    input [35:0]   app_wdf_mask,
    input          app_wdf_wren
  );

  wire [15:0] 	   software_address_bits;
  wire  	   cpu_override_en;
  wire  	   cpu_override_sel;
  wire [3:0]	   mem_dram_state;
  wire [3:0]	   mem_opb_state;
  wire [3:0] 	   arbiter_state;
  wire 	           arbiter_conflict;
   wire [31:0]  ddr3_s0_ctr;
   wire [31:0]  ddr3_s1_ctr;
   wire [31:0]  ddr3_s2_ctr;
   wire [31:0]  ddr3_s3_ctr;
   wire [31:0]  ddr3_s4_ctr;
   wire [31:0]  ddr3_s5_ctr;
   wire [31:0]  ddr3_s6_ctr;
   wire [31:0]  ddr3_s7_ctr;
   wire [31:0]  ddr3_sx_ctr;
   
   /*OPB state counters*/
   wire [31:0]  opb_s0_ctr;
   wire [31:0]  opb_s1_ctr;
   wire [31:0]  opb_s2_ctr;
   wire [31:0]  opb_s3_ctr;
   wire [31:0]  opb_s4_ctr;
   wire [31:0]  opb_s5_ctr;
   wire [31:0]  opb_sx_ctr;
   wire [0:31]  ctrl_opb_addr_lil;
   wire [31:0]  ctrl_opb_addr_big;
	
   wire       opb_ctr_rst;
   wire       ddr3_ctr_rst;
  
   
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
    .cpu_override_en       (cpu_override_en),
    .cpu_override_sel      (cpu_override_sel),
    .mem_dram_state        (mem_dram_state),
    .mem_opb_state         (mem_opb_state),
    .arbiter_state         (arbiter_state),
    .arbiter_conflict      (arbiter_conflict),
    .phy_ready             (phy_ready),

    .ddr3_s0_ctr (ddr3_s0_ctr),
    .ddr3_s1_ctr (ddr3_s1_ctr),
    .ddr3_s2_ctr (ddr3_s2_ctr),
    .ddr3_s3_ctr (ddr3_s3_ctr),
    .ddr3_s4_ctr (ddr3_s4_ctr),
    .ddr3_s5_ctr (ddr3_s5_ctr),
    .ddr3_s6_ctr (ddr3_s6_ctr),
    .ddr3_s7_ctr (ddr3_s7_ctr),
    .ddr3_sx_ctr (ddr3_sx_ctr),
    .opb_s0_ctr  (opb_s0_ctr),
    .opb_s1_ctr  (opb_s1_ctr),
    .opb_s2_ctr  (opb_s2_ctr),
    .opb_s3_ctr  (opb_s3_ctr),
    .opb_s4_ctr  (opb_s4_ctr),
    .opb_s5_ctr  (opb_s5_ctr),
    .opb_sx_ctr  (opb_sx_ctr),
    .ctrl_opb_addr_lil(ctrl_opb_addr_lil),
    .ctrl_opb_addr_big(ctrl_opb_addr_big),
    .opb_ctr_rst (opb_ctr_rst),
    .ddr3_ctr_rst(ddr3_ctr_rst)
  );

generate if (ENABLE) begin : sniffer_enabled

  wire  [287:0] sniff_rd_data;
  wire          sniff_rd_data_end; 
  wire          sniff_rd_data_valid;
  wire          sniff_rdy; 
  wire          sniff_wdf_rdy; 
  wire  [31:0]  sniff_addr;
  wire  [2:0]   sniff_cmd;
  wire          sniff_en;
  wire  [287:0] sniff_wdf_data;
  wire          sniff_wdf_end; 
  wire  [35:0]  sniff_wdf_mask;
  wire          sniff_wdf_wren; 

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
	 
	 .software_address_bits (software_address_bits),

    .dram_clk     (dram_clk),
    .dram_rst     (dram_rst),

    .dram_rd_data        (sniff_rd_data),
    .dram_rd_data_end    (sniff_rd_data_end),
    .dram_rd_data_valid  (sniff_rd_data_valid),
    .dram_rdy            (sniff_rdy),
    .dram_wdf_rdy        (sniff_wdf_rdy),
    .dram_addr           (sniff_addr),
    .dram_cmd            (sniff_cmd),
    .dram_en             (sniff_en),
    .dram_wdf_data       (sniff_wdf_data),
    .dram_wdf_end        (sniff_wdf_end),
    .dram_wdf_mask       (sniff_wdf_mask),
    .dram_wdf_wren       (sniff_wdf_wren),

    .dram_state          (mem_dram_state),
    .cpu_state           (mem_opb_state),

    .ddr3_s0_ctr (ddr3_s0_ctr),
    .ddr3_s1_ctr (ddr3_s1_ctr),
    .ddr3_s2_ctr (ddr3_s2_ctr),
    .ddr3_s3_ctr (ddr3_s3_ctr),
    .ddr3_s4_ctr (ddr3_s4_ctr),
    .ddr3_s5_ctr (ddr3_s5_ctr),
    .ddr3_s6_ctr (ddr3_s6_ctr),
    .ddr3_s7_ctr (ddr3_s7_ctr),
    .ddr3_sx_ctr (ddr3_sx_ctr),
    .opb_s0_ctr  (opb_s0_ctr),
    .opb_s1_ctr  (opb_s1_ctr),
    .opb_s2_ctr  (opb_s2_ctr),
    .opb_s3_ctr  (opb_s3_ctr),
    .opb_s4_ctr  (opb_s4_ctr),
    .opb_s5_ctr  (opb_s5_ctr),
    .opb_sx_ctr  (opb_sx_ctr),
    .ctrl_opb_addr_lil(ctrl_opb_addr_lil),
    .ctrl_opb_addr_big(ctrl_opb_addr_big),
    .opb_ctr_rst (opb_ctr_rst),
    .ddr3_ctr_rst(ddr3_ctr_rst)
  );
  
  wire [31:0] sniff_cmd_address = {software_address_bits[8:0], sniff_addr[20:0], 2'b0};
  /* TODO: finalize the software address width */

//   /* Pipeline to improve timing, almost full control permit this approach */
//   wire  [32 - 1:0] ddr3_addr_int;
//   wire   [3 - 1:0] ddr3_cmd_int;
//   wire             ddr3_en_int;
//   wire [288 - 1:0] ddr3_wdf_data_int;
//   wire             ddr3_wdf_end_int;
//   wire  [36 - 1:0] ddr3_wdf_mask_int;
//   wire             ddr3_wdf_wren_int;

//   reg   [32 - 1:0] ddr3_addr_reg;
//   reg    [3 - 1:0] ddr3_cmd_reg;
//   reg              ddr3_en_reg;
//   reg  [288 - 1:0] ddr3_wdf_data_reg;
//   reg              ddr3_wdf_end_reg;
//   reg   [36 - 1:0] ddr3_wdf_mask_reg;
//   reg              ddr3_wdf_wren_reg;

//   always @(posedge dram_clk) begin
//     ddr3_addr_reg      <= ddr3_addr_int;
//     ddr3_cmd_reg       <= ddr3_cmd_int;
//     ddr3_en_reg        <= ddr3_en_int;
//     ddr3_wdf_data_reg  <= ddr3_wdf_data_int;
//     ddr3_wdf_end_reg   <= ddr3_wdf_end_int; 
//     ddr3_wdf_mask_reg  <= ddr3_wdf_mask_int;
//     ddr3_wdf_wren_reg  <= ddr3_wdf_wren_int; 
//   end

//   assign ddr3_addr     = ddr3_addr_reg;
//   assign ddr3_cmd      = ddr3_cmd_reg;
//   assign ddr3_en       = ddr3_en_reg;
//   assign ddr3_wdf_data = ddr3_wdf_data_reg;
//   assign ddr3_wdf_end  = ddr3_wdf_end_reg;
//   assign ddr3_wdf_mask = ddr3_wdf_mask_reg;
//   assign ddr3_wdf_wren = ddr3_wdf_wren_reg;

  dram_arbiter dram_arbiter(
    .clk(dram_clk),
    .rst(dram_rst),

    .override_en           (cpu_override_en),
    .override_sel          (cpu_override_sel),
    .arbiter_state         (arbiter_state),
    .arbiter_conflict      (arbiter_conflict),

    .master_rd_data        (ddr3_rd_data),
    .master_rd_data_end    (ddr3_rd_data_end),
    .master_rd_data_valid  (ddr3_rd_data_valid),
    .master_rdy            (ddr3_rdy),
    .master_wdf_rdy        (ddr3_wdf_rdy),
    .master_addr           (ddr3_addr),
    .master_cmd            (ddr3_cmd),
    .master_en             (ddr3_en),
    .master_wdf_data       (ddr3_wdf_data),
    .master_wdf_end        (ddr3_wdf_end),
    .master_wdf_mask       (ddr3_wdf_mask),
    .master_wdf_wren       (ddr3_wdf_wren),

    .slave0_rd_data        (app_rd_data),
    .slave0_rd_data_end    (app_rd_data_end),
    .slave0_rd_data_valid  (app_rd_data_valid),
    .slave0_rdy            (app_rdy),
    .slave0_wdf_rdy        (app_wdf_rdy),
    .slave0_addr           (app_addr),
    .slave0_cmd            (app_cmd),
    .slave0_en             (app_en),
    .slave0_wdf_data       (app_wdf_data),
    .slave0_wdf_end        (app_wdf_end),
    .slave0_wdf_mask       (app_wdf_mask),
    .slave0_wdf_wren       (app_wdf_wren),

    .slave1_rd_data        (sniff_rd_data),
    .slave1_rd_data_end    (sniff_rd_data_end),
    .slave1_rd_data_valid  (sniff_rd_data_valid),
    .slave1_rdy            (sniff_rdy),
    .slave1_wdf_rdy        (sniff_wdf_rdy),
    .slave1_addr           (sniff_addr),
    .slave1_cmd            (sniff_cmd),
    .slave1_en             (sniff_en),
    .slave1_wdf_data       (sniff_wdf_data),
    .slave1_wdf_end        (sniff_wdf_end),
    .slave1_wdf_mask       (sniff_wdf_mask),
    .slave1_wdf_wren       (sniff_wdf_wren)
  );

end else begin : sniffer_disabled
//     assign ctrl_Sl_DBus    = 32'b0;
//     assign ctrl_Sl_errAck  = 1'b0;
//     assign ctrl_Sl_retry   = 1'b0;
//     assign ctrl_Sl_toutSup = 1'b0;
//     assign ctrl_Sl_xferAck = 1'b0;

    assign mem_Sl_DBus     = 32'b0;
    assign mem_Sl_errAck   = 1'b0;
    assign mem_Sl_retry    = 1'b0;
    assign mem_Sl_toutSup  = 1'b0;
    assign mem_Sl_xferAck  = 1'b0;

    assign ddr3_addr       = app_addr;
    assign ddr3_cmd        = app_cmd;
    assign ddr3_en         = app_en;
    assign ddr3_wdf_data   = app_wdf_data;
    assign ddr3_wdf_end    = app_wdf_end;
    assign ddr3_wdf_mask   = app_wdf_mask;
    assign ddr3_wdf_wren   = app_wdf_wren;

    assign app_rd_data       = ddr3_rd_data;
    assign app_rd_data_end   = ddr3_rd_data_end;
    assign app_rd_data_valid = ddr3_rd_data_valid;
    assign app_rdy           = ddr3_rdy;
    assign app_wdf_rdy       = ddr3_wdf_rdy;

end endgenerate

endmodule
