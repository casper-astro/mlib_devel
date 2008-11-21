module opb_qdr_sniffer #(
    parameter C_BASEADDR     = 0,
    parameter C_HIGHADDR     = 0,
    parameter C_OPB_AWIDTH   = 0,
    parameter C_OPB_DWIDTH   = 0,
    parameter QDR_ADDR_WIDTH = 32,
    parameter QDR_DATA_WIDTH = 18,
    parameter QDR_BW_WIDTH   = 2
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
    input  [35:0] slave_wr_data,
    input   [3:0] slave_wr_be,
    input  slave_rd_strb,
    output [35:0] slave_rd_data,
    output slave_rd_dvld,
    output slave_ack
  );

  localparam QDR_LATENCY = 9;

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
  wire [35:0] backdoor_d;
  wire  [3:0] backdoor_be;
  wire [35:0] backdoor_q;
  wire backdorr_qvld;

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

  assign Sl_toutSup = 1'b1; //need to supress timeout as reads can take a long time
  assign Sl_errAck  = 1'b0;

  wire [0:31] Sl_DBus_int;
  assign Sl_DBus = Sl_xferAck ? Sl_DBus_int : 32'b0;

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

  /***************** QDR Arbitration ****************/

  wire arb_sel;
  localparam SLAVE    = 0;
  localparam BACKDOOR = 1;

  reg arb_sel_reg;
  reg slave_busy;
  reg backdoor_busy;

  always @(posedge qdr_clk) begin
    backdoor_busy <= 1'b0;
    slave_busy    <= 1'b0;
    if (qdr_rst) begin
      arb_sel_reg   <= SLAVE;
    end else begin
      case (arb_sel_reg)
        SLAVE: begin
          if (!backdoor_busy) begin
            slave_busy <= slave_wr_strb || slave_rd_strb;
            if (backdoor_req) begin
              arb_sel_reg <= BACKDOOR;
`ifdef DEBUG
              $display("sniff_arb: got backdoor_req");
`endif
            end
          end
        end
        BACKDOOR: begin
          if (!slave_busy) begin
            backdoor_busy <= backdoor_w || backdoor_r;
            if (backdoor_w || backdoor_r) begin
              arb_sel_reg <= SLAVE;
            end
          end
        end
      endcase
    end
  end

  /***************** QDR Assignments ****************/
  assign arb_sel      = arb_sel_reg;

  assign slave_ack    = arb_sel == SLAVE && !backdoor_busy;
  assign backdoor_ack = arb_sel == BACKDOOR && !slave_busy;

  assign master_wr_strb = slave_wr_strb && slave_ack || backdoor_w && backdoor_ack;
  assign master_rd_strb = slave_rd_strb && slave_ack || backdoor_r && backdoor_ack;
  assign master_addr    =               slave_ack ? slave_addr  : backdoor_addr;
  assign master_wr_data = slave_ack || slave_busy ? slave_wr_data : backdoor_d;
  assign master_wr_be   = slave_ack || slave_busy ? slave_wr_be   : backdoor_be;

  assign backdoor_q     = master_rd_data;
  assign slave_rd_data  = master_rd_data;

  assign slave_rd_dvld  = master_rd_dvld;

endmodule
