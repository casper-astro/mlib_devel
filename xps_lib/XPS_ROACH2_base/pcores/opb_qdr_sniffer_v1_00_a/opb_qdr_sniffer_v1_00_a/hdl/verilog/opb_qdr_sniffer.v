module opb_qdr_sniffer #(
    /* config IF */
    parameter C_CONFIG_BASEADDR     = 0,
    parameter C_CONFIG_HIGHADDR     = 0,
    parameter C_CONFIG_OPB_AWIDTH   = 0,
    parameter C_CONFIG_OPB_DWIDTH   = 0,

    parameter C_BASEADDR     = 0,
    parameter C_HIGHADDR     = 0,
    parameter C_OPB_AWIDTH   = 0,
    parameter C_OPB_DWIDTH   = 0,
    parameter QDR_ADDR_WIDTH = 32,
    parameter QDR_DATA_WIDTH = 18,
    parameter QDR_BW_WIDTH   = 2,
    parameter QDR_LATENCY    = 10,
    parameter ENABLE         = 0
  )(
    input  OPB_Clk,
    input  OPB_Rst,
    output [0:31] Sl_DBus,
    output Sl_errAck,
    output Sl_retry,
    output Sl_toutSup,
    output Sl_xferAck,
    input  [0:31] OPB_ABus,
    input  [0:3]  OPB_BE,
    input  [0:31] OPB_DBus,
    input  OPB_RNW,
    input  OPB_select,
    input  OPB_seqAddr,

    input  OPB_Clk_config,
    input  OPB_Rst_config,
    output [0:31] Sl_DBus_config,
    output Sl_errAck_config,
    output Sl_retry_config,
    output Sl_toutSup_config,
    output Sl_xferAck_config,
    input  [0:31] OPB_ABus_config,
    input  [0:3]  OPB_BE_config,
    input  [0:31] OPB_DBus_config,
    input  OPB_RNW_config,
    input  OPB_select_config,
    input  OPB_seqAddr_config,

    input  qdr_clk,
    /* Master interface to QDR controller */
    output   [QDR_ADDR_WIDTH - 1:0] master_addr,
    output master_wr_strb,
    output [2*QDR_DATA_WIDTH - 1:0] master_wr_data,
    output   [2*QDR_BW_WIDTH - 1:0] master_wr_be,
    output master_rd_strb,
    input  [2*QDR_DATA_WIDTH - 1:0] master_rd_data,
    input  master_rd_dvld,

    /* Slave interface to fabric */
    input  [31:0] slave_addr,
    input  slave_wr_strb,
    input  [2*QDR_DATA_WIDTH - 1:0] slave_wr_data,
    input   [2*QDR_BW_WIDTH - 1:0] slave_wr_be,
    input  slave_rd_strb,
    output [2*QDR_DATA_WIDTH-1:0] slave_rd_data,
    output slave_rd_dvld,
    output slave_ack,

    /* Misc signals */
    input  phy_rdy,
    input  cal_fail,
    output qdr_reset
  );

  localparam SLAVE          = 4'h1;
  localparam SLAVE_WAIT     = 4'h2;
  localparam BACKDOOR       = 4'h4;
  localparam BACKDOOR_WAIT  = 4'h8;


generate if (ENABLE == 1) begin: qdr_enabled

  /* qdr_rst gen */
  reg qdr_rst_reg;
  reg qdr_rst_regR;
  always @(posedge qdr_clk) begin
    qdr_rst_reg  <= OPB_Rst;
    qdr_rst_regR <= qdr_rst_reg;
  end
  wire qdr_rst = qdr_rst_regR;

  /***************** Async QDR interface ****************/
  /* backdoor interface */
  wire backdoor_ack, backdoor_req;
  wire backdoor_r, backdoor_w;
  wire [31:0] backdoor_addr;
  wire [2*QDR_DATA_WIDTH - 1:0] backdoor_d;
  wire  [2*QDR_BW_WIDTH - 1 :0] backdoor_be;
  wire [2*QDR_DATA_WIDTH - 1:0] backdoor_q;
  wire backdoor_qvld;

  /* isolate start of opb xfer */
  reg opb_sel_state;

  wire addr_match = OPB_ABus >= C_BASEADDR && OPB_ABus < C_HIGHADDR;
  wire [31:0] local_addr =  OPB_ABus - C_BASEADDR;

  reg host_en;

  always @(posedge OPB_Clk) begin
    host_en <= 1'b0;
    if (OPB_Rst) begin
      opb_sel_state <= 1'b0;
    end else begin
      if (!opb_sel_state && OPB_select && addr_match) begin
        opb_sel_state <= 1'b1;
        host_en <= 1'b1;
      end
      if (Sl_xferAck || !OPB_select) begin
        opb_sel_state <= 1'b0;
      end
    end
  end

  assign Sl_toutSup = opb_sel_state;
  assign Sl_errAck  = 1'b0;

  wire [0:31] Sl_DBus_int;
  assign Sl_DBus = Sl_xferAck ? Sl_DBus_int : 32'b0;

  /* Inner generate. Select appropriate QDR interface based on QDR data width */
  if (QDR_DATA_WIDTH == 36) begin
    async_qdr_interface36 #(
      .QDR_LATENCY(QDR_LATENCY)
    ) async_qdr_interface_inst (
      .host_clk   (OPB_Clk),
      .host_rst   (OPB_Rst),
      .host_en    (host_en),
      .host_rnw   (OPB_RNW),
      .host_datai (OPB_DBus),
      .host_be    (OPB_BE),
      .host_addr  (local_addr),
      .host_datao (Sl_DBus_int),
      .host_ack   (Sl_xferAck),

      .qdr_clk  (qdr_clk),
      .qdr_rst  (qdr_rst),
      .qdr_req  (backdoor_req),
      .qdr_ack  (backdoor_ack),
      .qdr_addr (backdoor_addr),
      .qdr_r    (backdoor_r),
      .qdr_w    (backdoor_w),
      .qdr_d    (backdoor_d),
      .qdr_be   (backdoor_be),
      .qdr_q    (backdoor_q)
    );
  end else begin
    async_qdr_interface #(
      .QDR_LATENCY(QDR_LATENCY)
    ) async_qdr_interface_inst (
      .host_clk   (OPB_Clk),
      .host_rst   (OPB_Rst),
      .host_en    (host_en),
      .host_rnw   (OPB_RNW),
      .host_datai (OPB_DBus),
      .host_be    (OPB_BE),
      .host_addr  (local_addr),
      .host_datao (Sl_DBus_int),
      .host_ack   (Sl_xferAck),

      .qdr_clk  (qdr_clk),
      .qdr_rst  (qdr_rst),
      .qdr_req  (backdoor_req),
      .qdr_ack  (backdoor_ack),
      .qdr_addr (backdoor_addr),
      .qdr_r    (backdoor_r),
      .qdr_w    (backdoor_w),
      .qdr_d    (backdoor_d),
      .qdr_be   (backdoor_be),
      .qdr_q    (backdoor_q)
    );
  end /* if (QDR_DATA_WIDTH == 36) generation


  /***************** QDR Arbitration ****************/

  reg [3:0] arb_sel;
  /* TODO: arb_sel[1:0] are very high fan out signals, thus need to be duplicated to increase performance */

  always @(posedge qdr_clk) begin
    if (qdr_rst) begin
      arb_sel   <= SLAVE;
    end else begin
      case (arb_sel)
        SLAVE: begin
          if (backdoor_req && !(slave_wr_strb || slave_rd_strb)) begin
              arb_sel <= BACKDOOR;
`ifdef DEBUG
              $display("sniff_arb: got backdoor_req without pending slave xfer");
`endif
          end
          if (backdoor_req && (slave_wr_strb || slave_rd_strb)) begin
              arb_sel <= SLAVE_WAIT;
`ifdef DEBUG
              $display("sniff_arb: got backdoor_req with pending slave xfer");
`endif
          end
        end
        SLAVE_WAIT: begin
          arb_sel <= BACKDOOR;
        end
        BACKDOOR: begin
          // We only give the backdoor interface one slot 
          arb_sel <= BACKDOOR_WAIT;
        end
        BACKDOOR_WAIT: begin
          arb_sel <= SLAVE;
        end
      endcase
    end
  end

  /***************** QDR Assignments ****************/

  assign slave_ack    = arb_sel == SLAVE;
  assign backdoor_ack = arb_sel == BACKDOOR;

  assign master_wr_strb = slave_wr_strb && slave_ack || backdoor_w && backdoor_ack;
  assign master_rd_strb = slave_rd_strb && slave_ack || backdoor_r && backdoor_ack;
  assign master_addr    =               slave_ack ? slave_addr  : backdoor_addr;
  assign master_wr_data = arb_sel == SLAVE || arb_sel == SLAVE_WAIT ? slave_wr_data : backdoor_d;
  assign master_wr_be   = arb_sel == SLAVE || arb_sel == SLAVE_WAIT ? slave_wr_be   : backdoor_be;

  assign backdoor_q     = master_rd_data;
  assign slave_rd_data  = master_rd_data;

  assign slave_rd_dvld  = master_rd_dvld;
  assign Sl_retry   = 1'b0;

end else begin : qdr_disabled
  assign Sl_errAck  = 1'b0;
  assign Sl_retry   = 1'b0;
  assign Sl_toutSup = 1'b0;
  assign Sl_xferAck = 1'b0;
  assign Sl_DBus    = 32'b0;

  assign master_addr    = slave_addr;
  assign master_wr_strb = slave_wr_strb;
  assign master_wr_data = slave_wr_data;
  assign master_wr_be   = slave_wr_be;
  assign master_rd_strb = slave_rd_strb;
  assign slave_rd_data  = master_rd_data;
  assign slave_rd_dvld  = master_rd_dvld;
  assign slave_ack      = 1'b1;
end endgenerate

  reg phy_rdyR;
  reg cal_failR;

  always @(posedge OPB_Clk_config) begin
    phy_rdyR <= phy_rdy;
    cal_failR <= cal_fail;
  end

  qdr_config #(
    /* config IF */
    .C_BASEADDR   (C_CONFIG_BASEADDR),
    .C_HIGHADDR   (C_CONFIG_HIGHADDR),
    .C_OPB_AWIDTH (C_CONFIG_OPB_AWIDTH),
    .C_OPB_DWIDTH (C_CONFIG_OPB_DWIDTH)
  ) qdr_config_inst (
    .OPB_Clk     (OPB_Clk_config),
    .OPB_Rst     (OPB_Rst_config),
    .Sl_DBus     (Sl_DBus_config),
    .Sl_errAck   (Sl_errAck_config),
    .Sl_retry    (Sl_retry_config),
    .Sl_toutSup  (Sl_toutSup_config),
    .Sl_xferAck  (Sl_xferAck_config),
    .OPB_ABus    (OPB_ABus_config),
    .OPB_BE      (OPB_BE_config),
    .OPB_DBus    (OPB_DBus_config),
    .OPB_RNW     (OPB_RNW_config),
    .OPB_select  (OPB_select_config),
    .OPB_seqAddr (OPB_seqAddr_config),
    .qdr_reset   (qdr_reset),
    .cal_fail    (cal_failR),
    .phy_rdy     (phy_rdyR),
    .qdr_clk     (qdr_clk)
  );


endmodule
