`timescale 1ns/1ps
module kat_adc_iic_controller(
    input         OPB_Clk,
    input         OPB_Rst,
    output [0:31] Sl_DBus,
    output        Sl_errAck,
    output        Sl_retry,
    output        Sl_toutSup,
    output        Sl_xferAck,
    input  [0:31] OPB_ABus,
    input  [0:3]  OPB_BE,
    input  [0:31] OPB_DBus,
    input         OPB_RNW,
    input         OPB_select,
    input         OPB_seqAddr,

    output        xfer_done,

	  input         sda_i,
	  output        sda_o,
	  output        sda_t,
	  input         scl_i,
	  output        scl_o,
	  output        scl_t,

    input         app_clk,
    input         gain_load,
    input  [13:0] gain_value
  );
  parameter C_BASEADDR    = 32'h00000000;
  parameter C_HIGHADDR    = 32'h0000FFFF;
  parameter C_OPB_AWIDTH  = 32;
  parameter C_OPB_DWIDTH  = 32;
  parameter IIC_FREQ      = 100;  //kHz
  parameter CORE_FREQ     = 100000; //kHz
  parameter EN_GAIN       = 0;

  /************** OPB Attachment *************/

  wire        cpu_op_fifo_wr_en;
  wire [11:0] cpu_op_fifo_wr_data;
  wire        cpu_op_fifo_rd_en;
  wire [11:0] cpu_op_fifo_rd_data;
  wire        cpu_op_fifo_empty;
  wire        cpu_op_fifo_full;
  wire        cpu_op_fifo_over;

  wire        rx_fifo_rd_en;
  wire  [7:0] rx_fifo_rd_data;
  wire        rx_fifo_wr_en;
  wire  [7:0] rx_fifo_wr_data;
  wire        rx_fifo_empty;
  wire        rx_fifo_full;
  wire        rx_fifo_over;

  wire        fifo_rst;

  wire        cpu_op_fifo_block;
  wire        cpu_op_error;

  opb_attach #(
    .C_BASEADDR   (C_BASEADDR),
    .C_HIGHADDR   (C_HIGHADDR),
    .C_OPB_AWIDTH (C_OPB_AWIDTH),
    .C_OPB_DWIDTH (C_OPB_DWIDTH)
  ) opb_attch_inst (
    .OPB_Clk         (OPB_Clk),
    .OPB_Rst         (OPB_Rst),
    .Sl_DBus         (Sl_DBus),
    .Sl_errAck       (Sl_errAck),
    .Sl_retry        (Sl_retry),
    .Sl_toutSup      (Sl_toutSup),
    .Sl_xferAck      (Sl_xferAck),
    .OPB_ABus        (OPB_ABus),
    .OPB_BE          (OPB_BE),
    .OPB_DBus        (OPB_DBus),
    .OPB_RNW         (OPB_RNW),
    .OPB_select      (OPB_select),
    .OPB_seqAddr     (OPB_seqAddr),

    .op_fifo_wr_en   (cpu_op_fifo_wr_en),
    .op_fifo_wr_data (cpu_op_fifo_wr_data),
    .op_fifo_empty   (cpu_op_fifo_empty),
    .op_fifo_full    (cpu_op_fifo_full),
    .op_fifo_over    (cpu_op_fifo_over),

    .rx_fifo_rd_en   (rx_fifo_rd_en),
    .rx_fifo_rd_data (rx_fifo_rd_data),
    .rx_fifo_empty   (rx_fifo_empty),
    .rx_fifo_full    (rx_fifo_full),
    .rx_fifo_over    (rx_fifo_over),

    .fifo_rst        (fifo_rst),
    .op_fifo_block   (cpu_op_fifo_block),
    .op_error        (cpu_op_error)
  );

  /* Tranfer done on positive edge of the fifo empty signal */
  reg cpu_op_fifo_empty_z;
  assign xfer_done = cpu_op_fifo_empty && !cpu_op_fifo_empty_z;

  always @(posedge OPB_Clk) begin
    cpu_op_fifo_empty_z <= cpu_op_fifo_empty;
  end

  /* CPU Fifos */

  cpu_op_fifo cpu_op_fifo_inst(
    .clk      (OPB_Clk),
    .din      (cpu_op_fifo_wr_data),
    .rd_en    (cpu_op_fifo_rd_en),
    .rst      (fifo_rst),
    .wr_en    (cpu_op_fifo_wr_en),
    .dout     (cpu_op_fifo_rd_data),
    .empty    (cpu_op_fifo_empty),
    .full     (cpu_op_fifo_full),
    .overflow (cpu_op_fifo_over)
  );
  //synthesis attribute BOX_TYPE of cpu_op_fifo_inst is BLACK_BOX

  rx_fifo rx_fifo_inst(
    .clk      (OPB_Clk),
    .din      (rx_fifo_wr_data),
    .rd_en    (rx_fifo_rd_en),
    .rst      (fifo_rst),
    .wr_en    (rx_fifo_wr_en),
    .dout     (rx_fifo_rd_data),
    .empty    (rx_fifo_empty),
    .full     (rx_fifo_full),
    .overflow (rx_fifo_over)
  );
  //synthesis attribute BOX_TYPE of rx_fifo_inst is BLACK_BOX

  wire       cpu_op_valid   = !cpu_op_fifo_empty && !cpu_op_fifo_block;
  wire [7:0] cpu_op_wr_data = cpu_op_fifo_rd_data[7:0];
  wire       cpu_op_rnw     = cpu_op_fifo_rd_data[8];
  wire       cpu_op_start   = cpu_op_fifo_rd_data[9];
  wire       cpu_op_stop    = cpu_op_fifo_rd_data[10];
  wire       cpu_op_lock    = cpu_op_fifo_rd_data[11];

  wire [7:0] cpu_op_rd_data;
  wire       cpu_op_ack;

  assign rx_fifo_wr_data = cpu_op_rd_data;
  assign rx_fifo_wr_en   = cpu_op_ack && cpu_op_rnw && cpu_op_valid;

  /************ Fabric Operations Fifo ***************/

    wire       fab_op_valid;
    wire [7:0] fab_op_wr_data;
    wire       fab_op_rnw;
    wire       fab_op_start;
    wire       fab_op_stop;
    wire       fab_op_lock;
    wire       fab_op_ack;
    wire       fab_op_fifo_rd_en;

generate if (EN_GAIN) begin :GAIN_ENABLE_generate
 
    wire       trans_vld;
    wire [7:0] trans_data;
    wire       trans_start;
    wire       trans_stop;
    wire       trans_rnw;
    wire       trans_lock;
  
    gain_set gain_set_inst (
      .clk          (app_clk),
      .rst          (OPB_Rst),
      .gain_value   (gain_value),
      .gain_load    (gain_load),
      .trans_vld    (trans_vld),
      .trans_data   (trans_data),
      .trans_start  (trans_start),
      .trans_stop   (trans_stop),
      .trans_rnw    (trans_rnw),
      .trans_lock   (trans_lock)
    );
  
    wire [11:0] fab_op_fifo_wr_data = {trans_lock, trans_stop, trans_start, trans_rnw, trans_data};
    wire fab_op_fifo_wr_en = trans_vld;
  
    wire [11:0] fab_op_fifo_rd_data;
    wire fab_op_fifo_empty;
 
    fab_op_fifo fab_op_fifo_inst(
      .wr_clk   (app_clk),
      .din      (fab_op_fifo_wr_data),
      .wr_en    (fab_op_fifo_wr_en),
  
      .rd_clk   (OPB_Clk),
      .dout     (fab_op_fifo_rd_data),
      .rd_en    (fab_op_fifo_rd_en),
      .empty    (fab_op_fifo_empty),
      .full     (),
      .rst      (1'b0)
    );
    //synthesis attribute BOX_TYPE of fab_op_fifo_inst is BLACK_BOX
    
    assign fab_op_valid   = !fab_op_fifo_empty;
    assign fab_op_wr_data = fab_op_fifo_rd_data[7:0];
    assign fab_op_rnw     = fab_op_fifo_rd_data[8];
    assign fab_op_start   = fab_op_fifo_rd_data[9];
    assign fab_op_stop    = fab_op_fifo_rd_data[10];
    assign fab_op_lock    = fab_op_fifo_rd_data[11];

  end else begin : fabric_disable
    
    assign fab_op_valid   = 0;
    assign fab_op_wr_data = 0;
    assign fab_op_rnw     = 0;
    assign fab_op_start   = 0;
    assign fab_op_stop    = 0;
    assign fab_op_lock    = 0;
  end
endgenerate

  /********************** Arbiter *************/
  wire op_ack;
  wire op_valid;

  reg arb_select;
  localparam ARB_FAB  = 0;
  localparam ARB_CPU  = 1;

  wire cpu_has_data = cpu_op_valid;
  wire fab_has_data = fab_op_valid;

  reg locked;

  always @(posedge OPB_Clk) begin
    if (OPB_Rst) begin
      arb_select <= ARB_CPU;
      locked <= 1'b0;
    end else begin
      case (arb_select)
        ARB_FAB: begin
          if (cpu_has_data && !locked) begin
            /* If there is no transaction feel free to swap */
            if (!fab_has_data) begin
              arb_select <= ARB_CPU;
            end
            /* Only swap if the current transaction has just completed */
            if (fab_has_data && op_ack) begin
              arb_select <= ARB_CPU;
            end
          end
        end
        ARB_CPU: begin
          if (fab_has_data && !locked) begin
            if (!cpu_has_data) begin
              arb_select <= ARB_FAB;
            end
            if (cpu_has_data && op_ack) begin
              arb_select <= ARB_FAB;
            end
          end
        end
      endcase
    end

    if (op_valid) begin
      locked <= arb_select == ARB_FAB ? fab_op_lock : cpu_op_lock;
    end
  end

  /************* Operation Processing ************/

  assign     op_valid   = arb_select == ARB_FAB ? fab_op_valid   : cpu_op_valid;
  wire [7:0] op_wr_data = arb_select == ARB_FAB ? fab_op_wr_data : cpu_op_wr_data;
  wire       op_rnw     = arb_select == ARB_FAB ? fab_op_rnw     : cpu_op_rnw;
  wire       op_stop    = arb_select == ARB_FAB ? fab_op_stop    : cpu_op_stop;
  wire       op_start   = arb_select == ARB_FAB ? fab_op_start   : cpu_op_start;
  wire [7:0] op_rd_data;
  wire       op_err;

  miic_ops #(
    .IIC_FREQ  (IIC_FREQ),
    .CORE_FREQ (CORE_FREQ)
  ) miic_ops_inst(
    .clk        (OPB_Clk),
    .rst        (OPB_Rst),
    .op_valid   (op_valid),
    .op_start   (op_start),
    .op_stop    (op_stop),
    .op_rnw     (op_rnw),
    .op_wr_data (op_wr_data),
    .op_rd_data (op_rd_data),
    .op_ack     (op_ack),
    .op_err     (op_err),
	  .sda_i      (sda_i),
	  .sda_o      (sda_o),
	  .sda_t      (sda_t),
	  .scl_i      (scl_i),
	  .scl_o      (scl_o),
	  .scl_t      (scl_t)
  );

  assign fab_op_ack = op_ack && arb_select == ARB_FAB;
  assign cpu_op_ack = op_ack && arb_select == ARB_CPU;

  assign cpu_op_error = op_err && arb_select == ARB_CPU;
  assign cpu_op_rd_data = op_rd_data;

  assign cpu_op_fifo_rd_en = cpu_op_ack && cpu_op_valid;
  assign fab_op_fifo_rd_en = fab_op_ack && fab_op_valid;

endmodule
