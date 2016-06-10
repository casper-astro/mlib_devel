module qdr_controller (
    /* QDR Infrastructure */
    clk0,
    clk180,
    clk270,
    reset, //release when clock and delay elements are stable
    idelay_rdy, 
    /* Physical QDR Signals */
    qdr_d,
    qdr_q,
    qdr_sa,
    qdr_w_n,
    qdr_r_n,
    qdr_dll_off_n,
    //qdr_bw_n,
    //qdr_cq,
    //qdr_cq_n,
    qdr_k,
    qdr_k_n,
    //qdr_qvld,
    /* QDR PHY ready */
    phy_rdy, cal_fail,
    /* QDR read interface */
    usr_rd_strb,
    usr_wr_strb,
    usr_addr,

    usr_rd_data,
    usr_rd_dvld,

    usr_wr_data,
    usr_wr_be, /* 'byte' enable */
    
    /* phy training signals */
    dly_clk,
    dly_en_i,
    dly_en_o,
    dly_inc_dec,
    
    dly_cntrs
  );
  parameter DATA_WIDTH   = 36;
  parameter BW_WIDTH     = 4;
  parameter ADDR_WIDTH   = 22;
  parameter BURST_LENGTH = 4;
  parameter CLK_FREQ     = 200;
  parameter DLY_CNT_WD   = 216;

  input clk0, clk180, clk270, dly_clk;
  input reset;
  input idelay_rdy;

  output [DATA_WIDTH - 1:0] qdr_d;
  input  [DATA_WIDTH - 1:0] qdr_q;
  output [ADDR_WIDTH - 1:0] qdr_sa;
  output qdr_w_n;
  output qdr_r_n;
  output qdr_dll_off_n;
  //output   [BW_WIDTH - 1:0] qdr_bw_n;
  //input  qdr_cq;
  //input  qdr_cq_n;
  output qdr_k;
  output qdr_k_n;
  //input  qdr_qvld;

  output phy_rdy;
  output cal_fail;

  input  usr_rd_strb;
  input  usr_wr_strb;
  input  [ADDR_WIDTH - 1:0] usr_addr;

  output [2*DATA_WIDTH - 1:0] usr_rd_data;
  output usr_rd_dvld;

  input  [2*DATA_WIDTH - 1:0] usr_wr_data;
  input    [2*BW_WIDTH - 1:0] usr_wr_be;
  
  input  [DATA_WIDTH - 1:0] dly_en_i;
  input  [DATA_WIDTH    :0] dly_en_o;
  input                     dly_inc_dec;
  
  output [5*(36+35)-1:0] dly_cntrs;

  wire qdr_rst;
  
  assign qdr_rst = (idelay_rdy == 1'b0 || reset == 1'b1) ? 1'b1 : 1'b0;
  assign cal_fail = 1'b0;
  assign phy_rdy  = 1'b1;
  
  /*reg [71:0] usr_wr_data_i;
  
  always @(posedge clk0) begin
    if (qdr_rst == 1'b1) begin
      usr_wr_data_i <= {8'b0,64'h_abcd_ef12_3456_7890};
    end else begin
      //usr_wr_data_i <= ~usr_wr_data_i;
      usr_wr_data_i <= {8'b0,64'h_abcd_ef12_3456_7890};
    end
  end*/
  
  /* DDR rise and fall outputs*/
  wire [DATA_WIDTH - 1:0] qdr_d_rise;
  wire [DATA_WIDTH - 1:0] qdr_d_fall;
  wire [DATA_WIDTH - 1:0] qdr_q_rise;
  wire [DATA_WIDTH - 1:0] qdr_q_fall;
  wire   [BW_WIDTH - 1:0] qdr_bw_n_rise;
  wire   [BW_WIDTH - 1:0] qdr_bw_n_fall;
  wire [ADDR_WIDTH - 1:0] qdr_sa_buf;

  qdrc_infrastructure #(
    .DATA_WIDTH (DATA_WIDTH),
    .BW_WIDTH   (BW_WIDTH),
    .ADDR_WIDTH (ADDR_WIDTH),
    .CLK_FREQ   (CLK_FREQ)
  ) qdrc_infrastructure_inst(
    /* general signals */
    .clk0     (clk0),
    .clk180   (clk180),
    .clk270   (clk270),
    .reset0   (reset0),
    .reset180 (reset180),
    .reset270 (reset270),
    /* external signals */
    .qdr_d         (qdr_d),
    .qdr_q         (qdr_q),
    .qdr_sa        (qdr_sa),
    .qdr_w_n       (qdr_w_n),
    .qdr_r_n       (qdr_r_n),
    .qdr_dll_off_n (qdr_dll_off_n),
    .qdr_bw_n      (),
    .qdr_k         (qdr_k),
    .qdr_k_n       (qdr_k_n),
    /* phy->external signals */
    .qdr_d_rise        (qdr_d_rise),
    .qdr_d_fall        (qdr_d_fall),
    .qdr_q_rise        (qdr_q_rise),
    .qdr_q_fall        (qdr_q_fall),
    .qdr_bw_n_rise     (qdr_bw_n_rise),
    .qdr_bw_n_fall     (qdr_bw_n_fall),
    .qdr_sa_buf        (qdr_sa_buf),
    .qdr_w_n_buf       (qdr_w_n_buf),
    .qdr_r_n_buf       (qdr_r_n_buf),
    .qdr_dll_off_n_buf (qdr_dll_off_n_buf),
    /* phy training signals */
    .dly_clk         (dly_clk),
	  .dly_rst         (~idelay_rdy),
    .dly_en_i        (dly_en_i),
    .dly_en_o        (dly_en_o),
    .dly_inc_dec     (dly_inc_dec),
    .dly_cntrs       (dly_cntrs)
  );
  


  /********* QDR PHY interface **********/

  wire phy_wr_strb;
  wire [2*DATA_WIDTH - 1:0] phy_wr_data;
  wire   [2*BW_WIDTH - 1:0] phy_wr_be;

  wire phy_rd_strb;
  wire [2*DATA_WIDTH - 1:0] phy_rd_data;


  assign qdr_r_n_buf   = ~phy_rd_strb;
  assign qdr_w_n_buf   = ~phy_wr_strb;
  assign qdr_d_rise    =  phy_wr_data [DATA_WIDTH - 1:0];
  assign qdr_d_fall    =  phy_wr_data [2*DATA_WIDTH - 1:DATA_WIDTH];
  assign qdr_bw_n_rise =  phy_wr_be   [BW_WIDTH - 1:0];
  assign qdr_bw_n_fall =  phy_wr_be   [2*BW_WIDTH - 1:BW_WIDTH];
  assign qdr_sa_buf    =  usr_addr;
  assign phy_rd_data   = {qdr_q_fall, qdr_q_rise};

  /********* QDR Write logic **********/
  qdrc_wr #(
    .DATA_WIDTH (DATA_WIDTH),
    .BW_WIDTH   (BW_WIDTH),
    .ADDR_WIDTH (ADDR_WIDTH)
  ) qdrc_wr_inst (
    .clk   (clk0),
    .reset (reset0),

    .usr_strb (usr_wr_strb),
    .usr_data (usr_wr_data),
    .usr_ben  (usr_wr_be),

    .phy_strb (phy_wr_strb),
    .phy_data (phy_wr_data),
    .phy_ben  (phy_wr_be)
  );

  /********* QDR Read logic **********/
  qdrc_rd #(
    .DATA_WIDTH (DATA_WIDTH),
    .ADDR_WIDTH (ADDR_WIDTH)
  ) qdrc_rd_inst (
    .clk   (clk0),
    .reset (reset0),

    .phy_rdy (phy_rdy),

    .usr_strb (usr_rd_strb),
    .usr_data (usr_rd_data),
    .usr_dvld (usr_rd_dvld),

    .phy_strb (phy_rd_strb),
    .phy_data (phy_rd_data)
  );

  /********** Reset Generation **********/

  reg reset_retimed0;
  assign reset0 = reset_retimed0;

  always @(posedge clk0) begin
    reset_retimed0 <= qdr_rst;
  end

  reg reset_retimed180;
  assign reset180 = reset_retimed180;

  always @(posedge clk180) begin
    reset_retimed180 <= qdr_rst;
  end

  reg reset_retimed270;
  assign reset270 = reset_retimed270;

  always @(posedge clk270) begin
    reset_retimed270 <= reset;
  end
  //synthesis attribute ASYNC_REG of reset_retimed0   is true
  //synthesis attribute ASYNC_REG of reset_retimed180 is true
  //synthesis attribute ASYNC_REG of reset_retimed270 is true
  
  //===========================================================================
  // Chipscope modules used to debug the controller
  //===========================================================================
  /*wire [35:0] ctrl0;
  wire [31:0] trig0,trig1,trig2,trig3,trig4,trig5,trig6,trig7,trig8,trig9,trig10,trig11,trig12,trig13,trig14,trig15; 

  chipscope_icon chipscope_icon_inst(
    .CONTROL0    (ctrl0)
  );  

  chipscope_ila chipscope_ila_inst(
    .CONTROL   (ctrl0),
    .CLK       (clk0),
    .TRIG0     (trig0),
    .TRIG1     (trig1),
    .TRIG2     (trig2),
    .TRIG3     (trig3),
    .TRIG4     (trig4),
    .TRIG5     (trig5),
    .TRIG6     (trig6),
    .TRIG7     (trig7),
    .TRIG8     (trig8),
    .TRIG9     (trig9),
    .TRIG10    (trig10),
    .TRIG11    (trig11),
    .TRIG12    (trig12),
    .TRIG13    (trig13),
    .TRIG14    (trig14),
    .TRIG15    (trig15)
  ); 

  // 1 -> 31
  assign trig0  = {31'h0, usr_rd_strb, usr_rd_dvld};
  // 32 -> 63
  assign trig1  = {qdr_d_rise[31:0]};
  // 64 -> 95
  assign trig2  = {qdr_d_fall[31:0]};
  // 96 -> 127
  assign trig3  = {qdr_q_rise[31:0]};
  assign trig4  = {qdr_q_fall[31:0]};
  assign trig5  = {qdr_sa_buf};
  assign trig6  = {dly_en_i[31:0]};
  assign trig7  = {dly_en_o[31:0]};
  assign trig8  = {dly_inc_dec};
  assign trig9  = {dly_cntrs[31:0]};
  assign trig10 = {32'h0};
  assign trig11 = {32'h0};
  assign trig12 = {32'h0};
  assign trig13 = {32'h0};
  assign trig14 = {32'h0};
  assign trig15 = {usr_rd_data};
*/  
endmodule
