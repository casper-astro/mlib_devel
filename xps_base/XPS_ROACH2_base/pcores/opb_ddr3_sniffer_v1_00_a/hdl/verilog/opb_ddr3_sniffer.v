module opb_ddr3_sniffer #(
    parameter ENABLE          = 0,
    parameter CTRL_C_BASEADDR = 0,
    parameter CTRL_C_HIGHADDR = 0,
    parameter MEM_C_BASEADDR  = 0,
    parameter MEM_C_HIGHADDR  = 0
  )(
    input         ctrl_OPB_Clk,
    input         ctrl_OPB_Rst,
    output [0:31] ctrl_Sl_DBus,
    output        ctrl_Sl_errAck,
    output        ctrl_Sl_retry,
    output        ctrl_Sl_toutSup,
    output        ctrl_Sl_xferAck,
    input  [0:31] ctrl_OPB_ABus,
    input   [0:3] ctrl_OPB_BE,
    input  [0:31] ctrl_OPB_DBus,
    input         ctrl_OPB_RNW,
    input         ctrl_OPB_select,
    input         ctrl_OPB_seqAddr,

    input         mem_OPB_Clk,
    input         mem_OPB_Rst,
    output [0:31] mem_Sl_DBus,
    output        mem_Sl_errAck,
    output        mem_Sl_retry,
    output        mem_Sl_toutSup,
    output        mem_Sl_xferAck,
    input  [0:31] mem_OPB_ABus,
    input   [0:3] mem_OPB_BE,
    input  [0:31] mem_OPB_DBus,
    input         mem_OPB_RNW,
    input         mem_OPB_select,
    input         mem_OPB_seqAddr,

    input  ddr3_clk,
    input  ddr3_rst,
    input  phy_ready,

    //DDR3_CTRL BUS - to/from controller
    input          ddr3_rdy,           // ddr3 ready for commands
    input          ddr3_wdf_rdy,       // write data fifo ready
    input  [287:0] ddr3_rd_data,       // read data from ddr3
    input          ddr3_rd_data_valid, // read data valid
    input          ddr3_rd_data_end,   // last read data 
	
    output   [2:0] ddr3_cmd,           // ddr3 command - 000=write, 001=read
    output  [31:0] ddr3_addr,          // ddr3 address
    output         ddr3_en,            // strobe for command and address
    output [287:0] ddr3_wdf_data,      // write data to ddr3
    output  [35:0] ddr3_wdf_mask,      // write data mask
    output         ddr3_wdf_end,       // last write data
    output         ddr3_wdf_wren,      // strobe write data

    //DDR3_APP BUS - to/from async fifo
    input    [2:0] app_cmd,         
    input   [31:0] app_addr,
    input          app_en,          
    input  [287:0] app_wdf_data,
    input   [35:0] app_wdf_mask,
    input          app_wdf_end,     
    input          app_wdf_wren,    

    output         app_rdy,         
    output         app_wdf_rdy,    
    output [287:0] app_rd_data,
    output         app_rd_data_valid,
    output         app_rd_data_end  
  );
generate if (ENABLE) begin : sniffer_enabled

  wire [15:0] software_address_bits;

  ddr3_ctrl_opb_attach #(
    .C_BASEADDR   (CTRL_C_BASEADDR),
    .C_HIGHADDR   (CTRL_C_HIGHADDR)
  ) ddr3_ctrl_opb_attach_inst (
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

  wire   [2:0] sniff_cmd;
  wire  [31:0] sniff_addr;
  wire         sniff_en;       
  wire [287:0] sniff_wdf_data;
  wire  [35:0] sniff_wdf_mask;
  wire         sniff_wdf_wren; 
  wire         sniff_wdf_end;
  wire         sniff_rdy;
  wire         sniff_wdf_rdy;
  wire [287:0] sniff_rd_data;
  wire         sniff_rd_data_valid;
  wire         sniff_rd_data_end;

  ddr3_mem_opb_attach #(
    .C_BASEADDR   (MEM_C_BASEADDR),
    .C_HIGHADDR   (MEM_C_HIGHADDR)
  ) ddr3_mem_opb_attach_inst (
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

    .ddr3_clk     (ddr3_clk),
    .ddr3_rst     (ddr3_rst),

    .ddr3_cmd           (sniff_cmd),
    .ddr3_addr          (sniff_addr),
    .ddr3_en            (sniff_en),
    .ddr3_wdf_data      (sniff_wdf_data),
    .ddr3_wdf_mask      (sniff_wdf_mask),
    .ddr3_wdf_end       (sniff_wdf_end),
    .ddr3_wdf_wren      (sniff_wdf_wren),
    .ddr3_rdy           (sniff_rdy),
    .ddr3_wdf_rdy       (sniff_wdf_rdy),
    .ddr3_rd_data       (sniff_rd_data),
    .ddr3_rd_data_valid (sniff_rd_data_valid),
    .ddr3_rd_data_end   (sniff_rd_data_end)

  );
  
  wire [31:0] sniff_cmd_addr = {software_address_bits[8:0], sniff_addr[19:0], 3'b0};
  /* TODO: finalize the software address width */

  /* No Pipelining */
/*   wire   [2:0] ddr3_cmd_int;
  wire  [31:0] ddr3_addr_int;
  wire         ddr3_en_int;
  wire [287:0] ddr3_wdf_data_int;
  wire  [35:0] ddr3_wdf_mask_int;
  wire         ddr3_wdf_end_int;
  wire         ddr3_wdf_wren_int;

  assign ddr3_cmd        = ddr3_cmd_int;
  assign ddr3_addr       = ddr3_addr_int;
  assign ddr3_en         = ddr3_en_int;
  assign ddr3_wdf_data   = ddr3_wdf_data_int;
  assign ddr3_wdf_mask   = ddr3_wdf_mask_int;
  assign ddr3_wdf_end    = ddr3_wdf_end_int;
  assign ddr3_wdf_wren   = ddr3_wdf_wren_int; */

  ddr3_arbiter ddr3_arbiter(
    .clk(ddr3_clk),
    .rst(ddr3_rst),
    // outputs to ddr3
    .master_cmd           (ddr3_cmd),
    .master_addr          (ddr3_addr),
    .master_en            (ddr3_en),
    .master_wdf_data      (ddr3_wdf_data),
    .master_wdf_mask      (ddr3_wdf_mask),
    .master_wdf_end       (ddr3_wdf_end),
    .master_wdf_wren      (ddr3_wdf_wren),
	// inputs from ddr3
    .master_rdy           (ddr3_rdy),
    .master_wdf_rdy       (ddr3_wdf_rdy),
    .master_rd_data       (ddr3_rd_data),
    .master_rd_data_valid (ddr3_rd_data_valid),
    .master_rd_data_end   (ddr3_rd_data_end),
    // sniffer inputs
    .slave1_cmd           (sniff_cmd),
    .slave1_addr          (sniff_cmd_addr),
    .slave1_en            (sniff_en),
    .slave1_wdf_data      (sniff_wdf_data),
    .slave1_wdf_mask      (sniff_wdf_mask),
    .slave1_wdf_end       (sniff_wdf_end),
    .slave1_wdf_wren      (sniff_wdf_wren),
    // sniffer outputs
    .slave1_rdy           (sniff_rdy),
    .slave1_wdf_rdy       (sniff_wdf_rdy),
    .slave1_rd_data       (sniff_rd_data),
    .slave1_rd_data_valid (sniff_rd_data_valid),
    .slave1_rd_data_end   (sniff_rd_data_end),
    // inputs from async fifo
    .slave0_cmd           (app_cmd),
    .slave0_addr          (app_addr),
    .slave0_en            (app_en),
    .slave0_wdf_data      (app_wdf_data),
    .slave0_wdf_mask      (app_wdf_mask),
    .slave0_wdf_end       (app_wdf_end),
    .slave0_wdf_wren      (app_wdf_wren),
	// outputs to async fifo
    .slave0_rdy           (app_rdy),
    .slave0_wdf_rdy       (app_wdf_rdy),
    .slave0_rd_data       (app_rd_data),
    .slave0_rd_data_valid (app_rd_data_valid),
    .slave0_rd_data_end   (app_rd_data_end)

	);
  
end else begin : sniffer_disabled
  assign ctrl_Sl_DBus    = 32'b0;
  assign ctrl_Sl_errAck  = 1'b0;
  assign ctrl_Sl_retry   = 1'b0;
  assign ctrl_Sl_toutSup = 1'b0;
  assign ctrl_Sl_xferAck = 1'b0;

  assign mem_Sl_DBus     = 32'b0;
  assign mem_Sl_errAck   = 1'b0;
  assign mem_Sl_retry    = 1'b0;
  assign mem_Sl_toutSup  = 1'b0;
  assign mem_Sl_xferAck  = 1'b0;

  // map through
  assign ddr3_cmd          = app_cmd;
  assign ddr3_addr         = app_addr;
  assign ddr3_en           = app_en;
  assign ddr3_wdf_data     = app_wdf_data;
  assign ddr3_wdf_mask     = app_wdf_mask;
  assign ddr3_wdf_end      = app_wdf_end;
  assign ddr3_wdf_wren     = app_wdf_wren;

  assign app_rdy           = ddr3_rdy;
  assign app_wdf_rdy       = ddr3_wdf_rdy;
  assign app_rd_data       = ddr3_rd_data;
  assign app_rd_data_valid = ddr3_rd_data_valid;
  assign app_rd_data_end   = ddr3_rd_data_end;
 
end endgenerate

endmodule
