`timescale 1ns/10ps

`define SIMLENGTH 1000000

`define SYS_CLK_PERIOD 100

module TB_kat_adc_controller();

  wire        OPB_Clk;
  wire        OPB_Rst;
  wire [0:31] Sl_DBus;
  wire        Sl_errAck;
  wire        Sl_retry;
  wire        Sl_toutSup;
  wire        Sl_xferAck;
  wire [0:31] OPB_ABus;
  wire [0:3]  OPB_BE;
  wire [0:31] OPB_DBus;
  wire        OPB_RNW;
  wire        OPB_select;
  wire        OPB_seqAddr;
  wire        xfer_done;
	wire        sda_i;
	wire        sda_o;
	wire        sda_t;
	wire        scl_i;
	wire        scl_o;
	wire        scl_t;

  kat_iic_controller #(
    .IIC_FREQ  (1),
    .CORE_FREQ (20)
  ) kat_iic_controller_inst (
    .OPB_Clk(OPB_Clk),
    .OPB_Rst(OPB_Rst),
    .Sl_DBus(Sl_DBus),
    .Sl_errAck(Sl_errAck),
    .Sl_retry(Sl_retry),
    .Sl_toutSup(Sl_toutSup),
    .Sl_xferAck(Sl_xferAck),
    .OPB_ABus(OPB_ABus),
    .OPB_BE(OPB_BE),
    .OPB_DBus(OPB_DBus),
    .OPB_RNW(OPB_RNW),
    .OPB_select(OPB_select),
    .OPB_seqAddr(OPB_seqAddr),
    .xfer_done(xfer_done),
	  .sda_i(sda_i),
	  .sda_o(sda_o),
	  .sda_t(sda_t),
	  .scl_i(scl_i),
	  .scl_o(scl_o),
	  .scl_t(scl_t)
  );

  /****** System Signal generations ******/

  wire rst;
  wire clk;

  reg [31:0] sys_clk_counter;

  reg reset;
  assign rst = reset;

  initial begin
    $dumpvars;
    sys_clk_counter <= 32'b0;

    reset <= 1'b1;
    #5000
    reset <= 1'b0;
`ifdef DEBUG
    $display("sys: reset cleared");
`endif
    #`SIMLENGTH
    $display("FAILED: simulation timed out");
    $finish;
  end

  assign clk = sys_clk_counter < ((`SYS_CLK_PERIOD) / 2);

  always begin
    #1 sys_clk_counter <= (sys_clk_counter == `SYS_CLK_PERIOD - 1 ? 32'b0 : sys_clk_counter + 1);
  end

  /****** ******/

  reg [31:0] progress;


  assign OPB_Clk = clk;
  assign OPB_Rst = rst;

  reg [0:31] OPB_ABus_reg;
  reg [0:3]  OPB_BE_reg;
  reg [0:31] OPB_DBus_reg;
  reg        OPB_RNW_reg;
  reg        OPB_select_reg;

  assign OPB_ABus    = OPB_ABus_reg;
  assign OPB_BE      = OPB_BE_reg;
  assign OPB_DBus    = OPB_DBus_reg;
  assign OPB_RNW     = OPB_RNW_reg;
  assign OPB_select  = OPB_select_reg;
  assign OPB_seqAddr = 1'b0;

  always @(posedge clk) begin
    if (rst) begin
      progress <= 0;
      OPB_select_reg <= 0;
    end else begin
      case (progress)
        0: begin
          OPB_select_reg <= 1;
          OPB_ABus_reg <= 0;
          OPB_BE_reg <= 4'b1111;
          OPB_RNW_reg <= 1'b0;
          OPB_DBus_reg <= {1'b0, 1'b1, 1'b0, 8'h53};
          progress <= progress + 1;
        end
        1: begin
          if (Sl_xferAck) begin
            OPB_select_reg <= 1;
            OPB_ABus_reg <= 0;
            OPB_RNW_reg <= 1'b0;
            OPB_BE_reg <= 4'b1111;
            OPB_DBus_reg <= {1'b0, 1'b0, 1'b0, 8'h78};
            progress <= progress + 1;
          end
        end
        2: begin
          if (Sl_xferAck) begin
            OPB_select_reg <= 1;
            OPB_RNW_reg <= 1'b0;
            OPB_ABus_reg <= 0;
            OPB_BE_reg <= 4'b1111;
            OPB_DBus_reg <= {1'b1, 1'b0, 1'b0, 8'h0f};
            progress <= progress + 1;
          end
        end
        3: begin
          if (Sl_xferAck) begin
            OPB_select_reg <= 1;
            OPB_RNW_reg <= 1'b0;
            OPB_ABus_reg <= 0;
            OPB_BE_reg <= 4'b1111;
            OPB_DBus_reg <= {1'b0, 1'b1, 1'b0, 8'h18};
            progress <= progress + 1;
          end
        end
        4: begin
          if (Sl_xferAck) begin
            OPB_select_reg <= 1;
            OPB_RNW_reg <= 1'b0;
            OPB_ABus_reg <= 0;
            OPB_BE_reg <= 4'b1111;
            OPB_DBus_reg <= {1'b1, 1'b0, 1'b1, 8'h0};
            progress <= progress + 1;
          end
        end
        5: begin
          if (Sl_xferAck) begin
            OPB_select_reg <= 1;
            OPB_RNW_reg <= 1'b0;
            OPB_ABus_reg <= 0;
            OPB_BE_reg <= 4'b1111;
            OPB_DBus_reg <= {1'b0, 1'b1, 1'b1, 8'h0};
            progress <= progress + 1;
          end
        end
        6: begin
          if (Sl_xferAck) begin
            OPB_select_reg <= 1;
            OPB_RNW_reg <= 1'b0;
            OPB_ABus_reg <= 0;
            OPB_BE_reg <= 4'b1111;
            OPB_DBus_reg <= {1'b1, 1'b1, 1'b1, 8'h0};
            progress <= progress + 1;
          end
        end
        7: begin
          if (Sl_xferAck) begin
            OPB_select_reg <= 0;
          end
          if (xfer_done) begin
            OPB_select_reg <= 1;
            OPB_RNW_reg <= 1'b1;
            OPB_ABus_reg <= 1;
            OPB_BE_reg <= 4'b1111;
            OPB_DBus_reg <= {1'b1, 1'b0, 1'b1, 8'h0};
            progress <= progress + 1;
          end
        end
        8: begin
          if (Sl_xferAck) begin
            $display("opbs: got iic 0 data %x", Sl_DBus);
            OPB_select_reg <= 1;
            OPB_RNW_reg <= 1'b1;
            OPB_ABus_reg <= 1;
            OPB_BE_reg <= 4'b1111;
            OPB_DBus_reg <= {1'b1, 1'b0, 1'b1, 8'h0};
            progress <= progress + 1;
          end
        end
        9: begin
          if (Sl_xferAck) begin
            $display("opbs: got iic 1 data %x", Sl_DBus);
            OPB_select_reg <= 1;
            OPB_RNW_reg <= 1'b1;
            OPB_ABus_reg <= 1;
            OPB_BE_reg <= 4'b1111;
            OPB_DBus_reg <= {1'b1, 1'b0, 1'b1, 8'h0};
            progress <= progress + 1;
          end
        end
        10: begin
          if (Sl_xferAck) begin
            OPB_select_reg <= 0;
            $display("opbs: got iic 2 data %x", Sl_DBus);
            $finish;
          end
        end
      endcase
    end
  end
  //wire [0:31] Sl_DBus;

  /************ *************/

  wire sda = !sda_t ? sda_o : 1'b1;
  wire scl = !scl_t ? scl_o : 1'b1;
  reg sda_z;
  reg scl_z;

  wire start = !sda &&  sda_z && scl;
  wire stop  =  sda && !sda_z && scl;

  wire scl_pos = scl && !scl_z;
  wire scl_neg = !scl && scl_z;

  reg [31:0] slave_prog;

  reg [7:0] rd_buffer;
  reg [7:0] wr_buffer;
  reg [3:0] rd_index;

  reg foo;

  always @(posedge clk) begin
    sda_z <= sda;
    scl_z <= scl;
    if (rst) begin
      slave_prog = 0;
      rd_buffer <= 8'hc3;
    end else begin
      if (start) begin
        slave_prog <= 1;
        rd_index <= 0;
        $display("iic_slave: got_start");
      end
      if (stop) begin
        slave_prog <= 0;
        $display("iic_slave: got_stop");
      end
      if (scl_neg) begin
        rd_index <= rd_index + 1;
        foo <= rd_buffer[rd_index];
      end
      if (scl_pos && (|slave_prog)) begin
        if (slave_prog > 0 && slave_prog <= 8) begin
          slave_prog <= slave_prog + 1;
          wr_buffer[7 - (slave_prog-1)] <= sda;
        end
        if (slave_prog == 9) begin
          $display("iic_slave: data %x", wr_buffer);
          $display("iic_slave: ack %b", sda);
          slave_prog <= 1;
        end
      end

    end
  end

  /****** ******/
  
  assign sda_i = foo;
  assign scl_i = scl_o;

  
endmodule
