module kat_iic_controller(
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
	  output        scl_t
  );
  parameter C_BASEADDR    = 32'h00000000;
  parameter C_HIGHADDR    = 32'h0000FFFF;
  parameter C_OPB_AWIDTH  = 32;
  parameter C_OPB_DWIDTH  = 32;
  parameter IIC_FREQ      = 100;  //kHz
  parameter CORE_FREQ     = 100000; //kHz

  /************* OPB Attach ***************/

  wire op_rd_error;

  wire        op_fifo_wr_en;
  wire [10:0] op_fifo_wr_data;
  wire        op_fifo_rd_en;
  wire [10:0] op_fifo_rd_data;
  wire        op_fifo_empty;
  wire        op_fifo_full;
  wire        op_fifo_over;

  wire        rx_fifo_wr_en;
  wire  [7:0] rx_fifo_wr_data;
  wire        rx_fifo_rd_en;
  wire  [7:0] rx_fifo_rd_data;
  wire        rx_fifo_empty;
  wire        rx_fifo_full;
  wire        rx_fifo_over;

  localparam REG_OP_FIFO = 0;
  localparam REG_RX_FIFO = 1;
  localparam REG_STATUS  = 2;
  localparam REG_CTRL    = 3;

  reg op_fifo_over_reg;
  reg rx_fifo_over_reg;

  reg op_fifo_wr_en_reg;
  reg rx_fifo_rd_en_reg;

  reg op_rd_error_reg;

  wire addr_match = OPB_ABus >= C_BASEADDR && OPB_ABus <= C_HIGHADDR;
  wire [31:0] local_addr = OPB_ABus - C_BASEADDR;

  reg Sl_xferAck_reg;

  reg fifo_rst_reg;

  reg op_fifo_block;

  always @(posedge OPB_Clk) begin
    Sl_xferAck_reg <= 1'b0;
    fifo_rst_reg <= 1'b0;

    op_fifo_wr_en_reg <= 1'b0;
    rx_fifo_rd_en_reg <= 1'b0;

    op_rd_error_reg <= op_rd_error_reg | op_rd_error;

    op_fifo_over_reg <= op_fifo_over_reg | op_fifo_over;
    rx_fifo_over_reg <= rx_fifo_over_reg | rx_fifo_over;

    if (OPB_Rst) begin
      op_fifo_over_reg <= 1'b0;
      rx_fifo_over_reg <= 1'b0;
      op_fifo_block <= 1'b0;
    end else begin
      if (addr_match && OPB_select && !Sl_xferAck_reg) begin
        Sl_xferAck_reg <= 1'b1;
        case (local_addr[3:2])
          REG_OP_FIFO: begin
            if (!OPB_RNW && OPB_BE[3]) begin
              op_fifo_wr_en_reg <= 1'b1;
            end
          end
          REG_RX_FIFO: begin
            if (OPB_RNW && OPB_BE[3]) begin
              rx_fifo_rd_en_reg <= 1'b1;
            end
          end
          REG_STATUS: begin
            if (!OPB_RNW) begin
              fifo_rst_reg <= 1'b1;
              op_fifo_over_reg <= 1'b0;
              rx_fifo_over_reg <= 1'b0;
              op_rd_error_reg <= 1'b0;
            end
          end
          REG_CTRL: begin
            if (!OPB_RNW && OPB_BE[3]) begin
              op_fifo_block <= OPB_DBus[31];
            end
          end
        endcase
      end
    end
  end

  reg [31:0] opb_dout;
  always @(*) begin
    case (local_addr[3:2])
      REG_OP_FIFO: begin
        opb_dout <= 32'b0;
      end
      REG_RX_FIFO: begin
        opb_dout <= {24'b0, rx_fifo_rd_data};
      end
      REG_STATUS: begin
        opb_dout <= {16'b0, 7'b0, op_rd_error_reg, 1'b0, op_fifo_over_reg, op_fifo_full, op_fifo_empty, 1'b0, rx_fifo_over_reg, rx_fifo_full, rx_fifo_empty};
      end
      REG_CTRL: begin
        opb_dout <= {31'b0, op_fifo_block};
      end
      default: begin
        opb_dout <= 32'b0;
      end
    endcase
  end

  assign Sl_DBus = Sl_xferAck_reg ? opb_dout : 32'b0;
  assign Sl_errAck = 1'b0;
  assign Sl_retry = 1'b0;
  assign Sl_toutSup = 1'b0;
  assign Sl_xferAck = Sl_xferAck_reg;

  /* OPB fifo assignments */
  assign op_fifo_wr_en   = op_fifo_wr_en_reg;
  assign op_fifo_wr_data = OPB_DBus[21:31];

  assign rx_fifo_rd_en = rx_fifo_rd_en_reg;

  /************* Operation Processing ************/

  wire op_valid;
  wire op_start;
  wire op_stop;
  wire op_rnw;
  wire [7:0] op_wr_data;
  wire [7:0] op_rd_data;
  wire op_ack;
  wire op_err;

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

  assign rx_fifo_wr_en   = op_valid && op_rnw && op_ack;
  assign rx_fifo_wr_data = op_rd_data;

  assign op_valid      = !op_fifo_empty && !op_fifo_block;
  assign op_fifo_rd_en = op_ack;
  assign op_wr_data    = op_fifo_rd_data[7:0];
  assign op_rnw        = op_fifo_rd_data[8];
  assign op_start      = op_fifo_rd_data[9];
  assign op_stop       = op_fifo_rd_data[10];

  assign op_rd_error   = op_err;

  /**** Fifos ****/

  reg op_fifo_empty_z;
  assign xfer_done = op_fifo_empty && !op_fifo_empty_z;

  always @(posedge OPB_Clk) begin
    op_fifo_empty_z <= op_fifo_empty;
  end

  op_fifo op_fifo_inst(
    .clk      (OPB_Clk),
    .din      (op_fifo_wr_data),
    .rd_en    (op_fifo_rd_en),
    .rst      (fifo_rst_reg),
    .wr_en    (op_fifo_wr_en),
    .dout     (op_fifo_rd_data),
    .empty    (op_fifo_empty),
    .full     (op_fifo_full),
    .overflow (op_fifo_over)
  );

  rx_fifo rx_fifo_inst(
    .clk      (OPB_Clk),
    .din      (rx_fifo_wr_data),
    .rd_en    (rx_fifo_rd_en),
    .rst      (fifo_rst_reg),
    .wr_en    (rx_fifo_wr_en),
    .dout     (rx_fifo_rd_data),
    .empty    (rx_fifo_empty),
    .full     (rx_fifo_full),
    .overflow (rx_fifo_over)
  );

endmodule
