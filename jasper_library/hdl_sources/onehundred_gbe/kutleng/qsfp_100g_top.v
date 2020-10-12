module qsfp_100g_top
  #(
    parameter CORE_MAC_ADDR    = 48'h020202030405,
    parameter CORE_IP_ADDR     = 32'h0A0A0A0A,
    //parameter CORE_PR_PORT     = 20000,
    parameter CORE_FABRIC_PORT = 10000
  )(
    input clk_100, // 100 MHz reference clock
    input clk_100_locked,
    input enable,
    input rst,
    // MGT connections
    input refclk156_p,
    input refclk156_n,
    input [3:0] qsfp_mgt_rx_p,
    input [3:0] qsfp_mgt_rx_n,
    output [3:0] qsfp_mgt_tx_p,
    output [3:0] qsfp_mgt_tx_n
  );

  wire clkout_qsfp; // 322.265625MHz clock

  wire lbus_reset;
  wire lbus_tx_ovfout;
  wire lbus_tx_unfout;

  wire [511:0] axis_rx_tdata;
  wire axis_rx_tvalid;
  wire [64:0] axis_rx_tkeep;
  wire axis_rx_tlast;
  wire axis_rx_tuser;

  wire [511:0] axis_tx_tdata_fifo;
  wire axis_tx_tvalid_fifo;
  wire [63:0]  axis_tx_tkeep_fifo;
  wire axis_tx_tlast_fifo;
  wire axis_tx_tready_fifo;
  wire axis_tx_tuser_fifo;

  wire [511:0] axis_tx_tdata;
  wire axis_tx_tvalid;
  wire [63:0]  axis_tx_tkeep;
  wire axis_tx_tlast;
  wire axis_tx_tready;
  wire axis_tx_tuser;

  gmacqsfp1top mac_inst (
    // 100MHz ref
    .Clk100MHz(clk100),
    // Global System Enable
    .Enable(enable),
    .Reset(rst),
    // Ethernet reference clock for 156.25MHz
    .mgt_qsfp_clock_p(refclk156_p),
    .mgt_qsfp_clock_n(refclk156_n),
    // RX
    .qsfp_mgt_rx0_p(qsfp_mgt_rx_p[0]),
    .qsfp_mgt_rx0_n(qsfp_mgt_rx_n[0]),
    .qsfp_mgt_rx1_p(qsfp_mgt_rx_p[1]),
    .qsfp_mgt_rx1_n(qsfp_mgt_rx_n[1]),
    .qsfp_mgt_rx2_p(qsfp_mgt_rx_p[2]),
    .qsfp_mgt_rx2_n(qsfp_mgt_rx_n[2]),
    .qsfp_mgt_rx3_p(qsfp_mgt_rx_p[3]),
    .qsfp_mgt_rx3_n(qsfp_mgt_rx_n[3]),
    // TX
    .qsfp_mgt_tx0_p(qsfp_mgt_tx_p[0]),
    .qsfp_mgt_tx0_n(qsfp_mgt_tx_n[0]),
    .qsfp_mgt_tx1_p(qsfp_mgt_tx_p[1]),
    .qsfp_mgt_tx1_n(qsfp_mgt_tx_n[1]),
    .qsfp_mgt_tx2_p(qsfp_mgt_tx_p[2]),
    .qsfp_mgt_tx2_n(qsfp_mgt_tx_n[2]),
    .qsfp_mgt_tx3_p(qsfp_mgt_tx_p[3]),
    .qsfp_mgt_tx3_n(qsfp_mgt_tx_n[3]),
    // Lbus and AXIS
    // This bus runs at 322.265625MHz
    // Everything below here is on the clkout_qsfp domain
    .lbus_reset(lbus_reset),
    // Overflow signal
    .lbus_tx_ovfout(lbus_tx_ovfout),
    // Underflow signal
    .lbus_tx_unfout(lbus_tx_unfout),
    // AXIS Bus
    // RX Bus
    .axis_rx_clkin(clkout_qsfp),
    .axis_rx_tdata(axi_tx_tdata_fifo),
    .axis_rx_tvalid(axis_tx_tvalid_fifo),
    .axis_rx_tready(axis_tx_tready_fifo),
    .axis_rx_tkeep(axis_tx_tkeep_fifo),
    .axis_rx_tlast(axis_tx_tlast_fifo),
    .axis_rx_tuser(axis_tx_tuser_fifo),
    // TX Bus
    .axis_tx_clkout(clkout_qsfp),
    .axis_tx_tdata(axis_rx_tdata),
    .axis_tx_tvalid(axis_rx_tvalid),
    .axis_tx_tkeep(axis_rx_tkeep),
    .axis_tx_tlast(axis_rx_tlast),
    // User output signal for errors and dropping of packets
    .axis_tx_tuser(axis_rx_tuser)
  );

  axispacketbufferfifo packet_fifo_inst
  (
    .s_aclk       (clkout_qsfp),
    .s_aresetn    (clk_100_locked),
    .s_axis_tvalid(axis_tx_tvalid),
    .s_axis_tready(axis_tx_tready),
    .s_axis_tdata (axis_tx_tdata),
    .s_axis_tkeep (axis_tx_tkeep),
    .s_axis_tlast (axis_tx_tlast),
    .s_axis_tuser (axis_tx_tuser),
    .m_axis_tvalid(axis_tx_tvalid_fifo),
    .m_axis_tready(axis_tx_tready_fifo),
    .m_axis_tdata (axis_tx_tdata_fifo),
    .m_axis_tkeep (axis_tx_tkeep_fifo),
    .m_axis_tlast (axis_tx_tlast_fifo),
    .m_axis_tuser (axis_tx_tuser_fifo)
  );

  ipcomms_fabric_only
  #(
    .G_DATA_WIDTH     (512),
    .G_EMAC_ADDR      (CORE_MAC_ADDR),
    .G_IP_ADDR        (CORE_IP_ADDR),
    //.G_PR_SERVER_PORT (C_PR_SERVER_PORT),
    .G_UDP_SERVER_PORT(CORE_FABRIC_PORT)
  ) ip_comms_inst (
    .axis_clk       (clkout_qsfp),
    //.icap_clk       (ICAPClk125MHz,
    .axis_reset     (rst),
    //Outputs to AXIS bus MAC side 
    .axis_tx_tdata  (axis_tx_tdata),
    .axis_tx_tvalid (axis_tx_tvalid),
    .axis_tx_tready (axis_tx_tready),
    .axis_tx_tkeep  (axis_tx_tkeep),
    .axis_tx_tlast  (axis_tx_tlast),
    .axis_tx_tuser  (axis_tx_tuser),
    //.ICAP_PRDONE    (ICAP_PRDONE),
    //.ICAP_PRERROR   (ICAP_PRERROR),
    //.ICAP_AVAIL     (ICAP_AVAIL),
    //.ICAP_CSIB      (),     //ICAP_CSIB,
    //.ICAP_RDWRB     (),     //ICAP_RDWRB,
    //.ICAP_DataOut   (ICAP_DataOut),
    //.ICAP_DataIn    (),      //ICAP_DataIn
    //Inputs from AXIS bus of the MAC side
    .axis_rx_tdata  (axis_rx_tdata),
    .axis_rx_tvalid (axis_rx_tvalid),
    .axis_rx_tuser  (axis_rx_tuser),
    .axis_rx_tkeep  (axis_rx_tkeep),
    .axis_rx_tlast  (axis_rx_tlast)
  );

endmodule
