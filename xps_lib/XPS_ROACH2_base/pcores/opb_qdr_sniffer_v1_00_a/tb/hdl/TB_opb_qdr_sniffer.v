`timescale 1ns/10ps

`define SIMLENGTH 1000000
`define SYS_CLK_PERIOD 22
`define QDR_CLK_PERIOD 6


`define TEST_ADDR 32'h1009
`define TEST_DATA 32'hdeadbeef
`define TEST_BE   4'b1001

`define OPB_BASEADDR 32'h1000000
`define OPB_HIGHADDR 32'h1ffffff

module TB_opb_qdr_sniffer();

  localparam QDR_ADDR_WIDTH = 32;
  localparam QDR_DATA_WIDTH = 18;
  localparam QDR_BW_WIDTH   = 2;
  localparam QDR_LATENCY    = 9;

  wire qdr_clk;
  wire sys_rst;
  wire sys_clk;

  /***************** DUT ***************/

  wire OPB_Clk;
  wire OPB_Rst;
  wire [0:31] Sl_DBus;
  wire Sl_errAck;
  wire Sl_retry;
  wire Sl_toutSup;
  wire Sl_xferAck;
  wire [0:31] OPB_ABus;
  wire [0:3]  OPB_BE;
  wire [0:31] OPB_DBus;
  wire OPB_RNW;
  wire OPB_select;
  wire OPB_seqAddr;
  wire   [QDR_ADDR_WIDTH - 1:0] master_addr;
  wire master_wr_strb;
  wire [2*QDR_DATA_WIDTH - 1:0] master_wr_data;
  wire   [2*QDR_BW_WIDTH - 1:0] master_wr_be;
  wire master_rd_strb;
  wire [2*QDR_DATA_WIDTH - 1:0] master_rd_data;
  wire master_rd_dvld;
  wire [31:0] slave_addr;
  wire slave_wr_strb;
  wire [35:0] slave_wr_data;
  wire  [3:0] slave_wr_be;
  wire slave_rd_strb;
  wire [35:0] slave_rd_data;
  wire slave_rd_dvld;
  wire slave_ack;

  opb_qdr_sniffer #(
    .C_BASEADDR   (`OPB_BASEADDR),
    .C_HIGHADDR   (`OPB_HIGHADDR),
    .C_OPB_AWIDTH (32),
    .C_OPB_DWIDTH (32)
  ) opb_qdr_sniffer_inst(
    .OPB_Clk     (OPB_Clk),
    .OPB_Rst     (OPB_Rst),
    .Sl_DBus     (Sl_DBus),
    .Sl_errAck   (Sl_errAck),
    .Sl_retry    (Sl_retry),
    .Sl_toutSup  (Sl_toutSup),
    .Sl_xferAck  (Sl_xferAck),
    .OPB_ABus    (OPB_ABus),
    .OPB_BE      (OPB_BE),
    .OPB_DBus    (OPB_DBus),
    .OPB_RNW     (OPB_RNW),
    .OPB_select  (OPB_select),
    .OPB_seqAddr (OPB_seqAddr),

    .qdr_clk     (qdr_clk),

    .master_addr    (master_addr),
    .master_wr_strb (master_wr_strb),
    .master_wr_data (master_wr_data),
    .master_wr_be   (master_wr_be),
    .master_rd_strb (master_rd_strb),
    .master_rd_data (master_rd_data),
    .master_rd_dvld (master_rd_dvld),

    .slave_addr     (slave_addr),
    .slave_wr_strb  (slave_wr_strb),
    .slave_wr_data  (slave_wr_data),
    .slave_wr_be    (slave_wr_be),
    .slave_rd_strb  (slave_rd_strb),
    .slave_rd_data  (slave_rd_data),
    .slave_rd_dvld  (slave_rd_dvld),
    .slave_ack      (slave_ack)
  );

  /****** System Signal generations ******/
  reg [31:0] qdr_clk_counter;
  reg [31:0] sys_clk_counter;

  reg reset;
  assign sys_rst = reset;

  initial begin
    $dumpvars;
    qdr_clk_counter <= 32'b0;
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

`define OPB_CLK_PERIOD 10
`define QDR_CLK_PERIOD 5

  assign qdr_clk = qdr_clk_counter < ((`QDR_CLK_PERIOD) / 2);
  assign sys_clk = sys_clk_counter < ((`SYS_CLK_PERIOD) / 2);

  always begin
    #1 sys_clk_counter <= (sys_clk_counter == `SYS_CLK_PERIOD - 1 ? 32'b0 : sys_clk_counter + 1);
    #1 qdr_clk_counter <= (qdr_clk_counter == `QDR_CLK_PERIOD - 1 ? 32'b0 : qdr_clk_counter + 1);
  end

  /********** Mode Control ***********/

  localparam MODE_WAIT  = 2'd0;
  localparam MODE_WRITE = 2'd1;
  localparam MODE_READ  = 2'd2;

  localparam NUM_MODES = 3;

  reg [1:0] mode;
  reg [NUM_MODES - 1:0] mode_done;

  reg [31:0] mode_data;

  wire  [3:0] dummy_be   = `TEST_BE;
  wire [31:0] dummy_mask = {{8{dummy_be[3]}}, {8{dummy_be[2]}}, {8{dummy_be[1]}}, {8{dummy_be[0]}}};

  wire [35:0] fabric_data = (`TEST_ADDR) >> 2;
  /* we are writing in a counter (shift due to TEST_ADDR byte addressed)*/

  wire [31:0] apparent_fabric_data = {fabric_data[34:27], fabric_data[25:18], fabric_data[16:9], fabric_data[7:0]};

  wire [31:0] expected_data = ((`TEST_DATA) & dummy_mask) | (apparent_fabric_data & ~dummy_mask);

  always @(posedge sys_clk) begin
    if (sys_rst) begin
      mode <= MODE_WAIT;
    end else begin
      case (mode)
        MODE_WAIT: begin
          if (mode_done[MODE_WAIT]) begin
            mode <= MODE_WRITE;
`ifdef DEBUG
            $display("mode: MODE_WAIT complete");
`endif
          end
        end
        MODE_WRITE: begin
          if (mode_done[MODE_WRITE]) begin
            mode <= MODE_READ;
`ifdef DEBUG
            $display("mode: MODE_WRITE complete");
`endif
          end
        end
        MODE_READ: begin
          if (mode_done[MODE_READ]) begin
            if (mode_data === expected_data) begin
              $display("PASSED");
            end else begin
              $display("%x, %x, %x, %x, %x", apparent_fabric_data, `TEST_DATA, (apparent_fabric_data & ~dummy_mask), (`TEST_DATA) & dummy_mask, expected_data);
              $display("FAILED: data mismatch - got %x, expected %x", mode_data, expected_data);
            end
            $finish;
          end
        end
      endcase
    end
  end

  reg [31:0] mode_counter;
  localparam WAIT_LENGTH = 3000;

  always @(posedge sys_clk) begin
    if (sys_rst) begin
      mode_counter <= WAIT_LENGTH;
    end else if (mode_counter) begin
      mode_counter <= mode_counter - 1;
    end
  end

  always @(*) begin
    mode_done[MODE_WAIT] <= mode_counter == 0;
  end

  /******* Simulated OPB Master ********/

  reg [31:0] OPB_ABus_reg;
  reg [31:0] OPB_DBus_reg;
  reg  [3:0] OPB_BE_reg;
  reg OPB_RNW_reg;
  reg OPB_select_reg;

  assign OPB_Clk = sys_clk;
  assign OPB_Rst = sys_rst;

  assign OPB_ABus = OPB_ABus_reg;
  assign OPB_DBus = OPB_DBus_reg;
  assign OPB_BE   = OPB_BE_reg;
  assign OPB_RNW  = OPB_RNW_reg;
  assign OPB_select  = OPB_select_reg;
  assign OPB_seqAddr = 1'b0;

  always @(posedge sys_clk) begin
    mode_done[MODE_WRITE] <= 1'b0;
    mode_done[MODE_READ]  <= 1'b0;

    if (sys_rst) begin
      OPB_ABus_reg   <= 32'b0;
      OPB_DBus_reg   <= 32'b0;
      OPB_BE_reg     <= 4'b0;
      OPB_RNW_reg    <= 1'b0;

      OPB_select_reg <= 1'b0;
    end else if (mode_done[MODE_WRITE] || mode_done[MODE_READ]) begin
      //give the mode state machine time to catch up
    end else begin
      case (OPB_select_reg)
        0: begin
          case (mode)
            MODE_WRITE: begin
              OPB_ABus_reg   <= `TEST_ADDR + `OPB_BASEADDR;
              OPB_DBus_reg   <= `TEST_DATA;
              OPB_BE_reg     <= `TEST_BE;
              OPB_select_reg <= 1'b1;
              OPB_RNW_reg    <= 1'b0;
`ifdef DEBUG
              $display("OPB_master: sending write, a = %x, d = %x, be = %b", `TEST_ADDR + `OPB_BASEADDR, `TEST_DATA, `TEST_BE);
`endif
            end
            MODE_READ: begin
              OPB_ABus_reg   <= `TEST_ADDR + `OPB_BASEADDR;
              OPB_select_reg <= 1'b1;
              OPB_RNW_reg    <= 1'b1;
`ifdef DEBUG
              $display("OPB_master: sending read, a = %x", `TEST_ADDR + `OPB_BASEADDR);
`endif
            end
          endcase
        end
        1: begin
          if (Sl_xferAck) begin
            OPB_select_reg <= 1'b0;
            case (mode)
              MODE_WRITE: begin
                mode_done[MODE_WRITE] <= 1'b1;
`ifdef DEBUG
                $display("OPB_master: got write response");
`endif
              end
              MODE_READ: begin
                mode_data <= Sl_DBus;
                mode_done[MODE_READ] <= 1'b1;
`ifdef DEBUG
                $display("OPB_master: got read response, data = %x", Sl_DBus);
`endif
              end
            endcase
          end
        end
      endcase
    end
  end

  /******* Simulated QDR Fabric Interface ********/

  reg [35:0] slave_progress;

  reg alt;

  reg qdr_rst;
  always @(posedge qdr_clk) begin
    if (sys_rst) begin
      qdr_rst <= 1'b1;
    end else begin
      qdr_rst <= 1'b0;
    end
  end

  always @(posedge qdr_clk) begin
    if (qdr_rst) begin
      alt <= 1'b0;
      slave_progress <= 32'b0;
    end else begin
 //     $display("? reset = %b r = %b, w = %b, a = %x, d = %x", sys_rst, slave_rd_strb, slave_wr_strb, slave_addr, slave_wr_data);
      if (slave_ack) begin
        alt <= ~alt;    
        slave_progress <= slave_progress + 1;
      end 
    end
  end

  assign slave_addr = {1'b0, slave_progress[31:1]};
  assign slave_wr_strb = !sys_rst && !alt && slave_ack;
  assign slave_wr_data = slave_progress;
  assign slave_wr_be   = 4'b1111;
  assign slave_rd_strb = !sys_rst &&  alt && slave_ack;

  reg [QDR_LATENCY - 1:0] qvld_shifter;
  always @(posedge qdr_clk) begin
    if (sys_rst) begin
      qvld_shifter <= {QDR_LATENCY{1'b0}};
    end else begin
      qvld_shifter <= {qvld_shifter[QDR_LATENCY - 2:0], alt && slave_ack};
    end
  end

  reg [31:0] read_progress;

  wire qvld = qvld_shifter[QDR_LATENCY-1];
  reg qvld_z;

  integer i;
  wire [36*(QDR_LATENCY+1) - 1:0] qdr_q_shifter_debug;

  always @(posedge qdr_clk) begin
    qvld_z <= qvld;

    if (sys_rst) begin
      read_progress <= 32'b0;
    end else begin
      if (qvld && qvld_z) begin
        $display("ERROR: got 2 consecutive qvlds");
        $finish;
      end
      if (qvld) begin
        if (slave_rd_data !== read_progress) begin
          $display("ERROR: fabric data0 mismatch - got %x, expected %x", slave_rd_data, read_progress);
          $finish;
        end
        read_progress <= read_progress + 1;
      end
      if (qvld_z) begin
        if (slave_rd_data !== read_progress) begin
          $display("%d: %x", 9,  qdr_q_shifter_debug[36*(9  + 1) - 1:36*(9)]);
          $display("%d: %x", 10, qdr_q_shifter_debug[36*(10 + 1) - 1:36*(10)]);
          $display("%d: %x", 11, qdr_q_shifter_debug[36*(11 + 1) - 1:36*(11)]);

          $display("ERROR: fabric data1 mismatch - got %x, expected %x", slave_rd_data, read_progress);
          $finish;
        end
        read_progress <= read_progress + 1;
      end
    end
  end

  /******* Simulated QDR Interface ********/

  localparam QDR_DEPTH = 1024*8;

  reg [8:0] data_byte0 [QDR_DEPTH - 1:0];
  reg [8:0] data_byte1 [QDR_DEPTH - 1:0];
  reg [8:0] data_byte2 [QDR_DEPTH - 1:0];
  reg [8:0] data_byte3 [QDR_DEPTH - 1:0];
  reg [8:0] data_byte4 [QDR_DEPTH - 1:0];
  reg [8:0] data_byte5 [QDR_DEPTH - 1:0];
  reg [8:0] data_byte6 [QDR_DEPTH - 1:0];
  reg [8:0] data_byte7 [QDR_DEPTH - 1:0];

  reg [36*(QDR_LATENCY+1) - 1:0] qdr_q_shifter;

  reg second_read;
  reg second_write;

  wire first_read  = master_rd_strb  && !second_read;
  wire first_write = !first_read && master_wr_strb && !second_write;

  reg [31:0] master_addr_z;

  always @(posedge qdr_clk) begin
    second_read  <= 1'b0;
    second_write <= 1'b0;
    master_addr_z <= master_addr;

    if (sys_rst) begin
    end else begin
//      $display(". r = %b, w = %b, a = %x, d = %x", master_rd_strb, master_wr_strb, master_addr, master_wr_data);
      if (first_read) begin
        second_read <= 1'b1;
        qdr_q_shifter <= {qdr_q_shifter[36*QDR_LATENCY - 1:0], data_byte3[master_addr], data_byte2[master_addr], 
                                                               data_byte1[master_addr], data_byte0[master_addr]};
`ifdef DESPERATE_DEBUG
        $display("qdr_master: read0 - addr = %x, q = %x", master_addr, {data_byte3[master_addr], data_byte2[master_addr], data_byte1[master_addr] ,data_byte0[master_addr]});
`endif
      end else if (second_read) begin
        qdr_q_shifter <= {qdr_q_shifter[36*QDR_LATENCY - 1:0], data_byte7[master_addr_z], data_byte6[master_addr_z], 
                                                               data_byte5[master_addr_z], data_byte4[master_addr_z]};
`ifdef DESPERATE_DEBUG
        $display("qdr_master: read1 - addr = %x, q = %x", master_addr, {data_byte7[master_addr_z], data_byte6[master_addr_z], data_byte5[master_addr_z] ,data_byte4[master_addr_z]});
`endif
      end else begin
        qdr_q_shifter <= {qdr_q_shifter[36*QDR_LATENCY - 1:0], {36{1'b0}}};
      end

      if (first_write) begin
        second_write <= 1'b1;

        if (master_wr_be[0])
          data_byte0[master_addr] <= master_wr_data[8:0];
        if (master_wr_be[1])
          data_byte1[master_addr] <= master_wr_data[17:9];
        if (master_wr_be[2])
          data_byte2[master_addr] <= master_wr_data[26:18];
        if (master_wr_be[3])
          data_byte3[master_addr] <= master_wr_data[35:27];

`ifdef DESPERATE_DEBUG
        $display("qdr_master: write0 - addr = %x, data = %x, be = %b", master_addr, master_wr_data, master_wr_be);
`endif
      end else if (second_write) begin

        if (master_wr_be[0])
          data_byte4[master_addr_z] <= master_wr_data[8:0];
        if (master_wr_be[1])
          data_byte5[master_addr_z] <= master_wr_data[17:9];
        if (master_wr_be[2])
          data_byte6[master_addr_z] <= master_wr_data[26:18];
        if (master_wr_be[3])
          data_byte7[master_addr_z] <= master_wr_data[35:27];

`ifdef DESPERATE_DEBUG
        $display("qdr_master: write1 - addr = %x, data = %x, be = %b", master_addr_z, master_wr_data, master_wr_be);
`endif
      end
    end
  end

  assign master_rd_data = qdr_q_shifter[36*(QDR_LATENCY) - 1:36*(QDR_LATENCY-1)];
  assign qdr_q_shifter_debug = qdr_q_shifter;
  
endmodule
