`timescale 1ns/10ps

`define SIMLENGTH       10000
`define SYS_CLK_PERIOD  22
`define DRAM_CLK_PERIOD 6

module TB_opb_qdr_sniffer();

  localparam TEST_ADDR    = 32'h00001000;
  localparam TEST_DATA    = 32'hdeadbeef;
  localparam OPB_BASEADDR = 32'h04000000;
  localparam OPB_HIGHADDR = 32'h07ffffff;

  wire sys_rst;
  wire sys_clk;

  wire dram_clk;
  wire dram_rst;

  /***************** DUT ***************/

  wire ctrl_OPB_Clk;
  wire ctrl_OPB_Rst;
  wire [0:31] ctrl_Sl_DBus;
  wire ctrl_Sl_errAck;
  wire ctrl_Sl_retry;
  wire ctrl_Sl_toutSup;
  wire ctrl_Sl_xferAck;
  wire [0:31] ctrl_OPB_ABus;
  wire [0:3]  ctrl_OPB_BE;
  wire [0:31] ctrl_OPB_DBus;
  wire ctrl_OPB_RNW;
  wire ctrl_OPB_select;
  wire ctrl_OPB_seqAddr;

  wire mem_OPB_Clk;
  wire mem_OPB_Rst;
  wire [0:31] mem_Sl_DBus;
  wire mem_Sl_errAck;
  wire mem_Sl_retry;
  wire mem_Sl_toutSup;
  wire mem_Sl_xferAck;
  wire [0:31] mem_OPB_ABus;
  wire [0:3]  mem_OPB_BE;
  wire [0:31] mem_OPB_DBus;
  wire mem_OPB_RNW;
  wire mem_OPB_select;
  wire mem_OPB_seqAddr;

  wire  [31:0] dram_cmd_addr;
  wire dram_cmd_rnw;
  wire dram_cmd_valid;
  wire [143:0] dram_wr_data;
  wire  [17:0] dram_wr_be;
  wire [143:0] dram_rd_data;
  wire dram_rd_valid;
  wire dram_fifo_ready;

  wire  [31:0] app_cmd_addr;
  wire app_cmd_rnw;
  wire app_cmd_valid;
  wire app_cmd_ack;
  wire [143:0] app_wr_data;
  wire  [17:0] app_wr_be;
  wire [143:0] app_rd_data;
  wire app_rd_valid;

  opb_dram_sniffer #(
    .CTRL_C_BASEADDR (0),
    .CTRL_C_HIGHADDR (0),
    .MEM_C_BASEADDR  (OPB_BASEADDR),
    .MEM_C_HIGHADDR  (OPB_HIGHADDR)
  ) opb_dram_sniffer_inst (
    .ctrl_OPB_Clk     (ctrl_OPB_Clk),
    .ctrl_OPB_Rst     (ctrl_OPB_Rst),
    .ctrl_Sl_DBus     (ctrl_Sl_DBus),
    .ctrl_Sl_errAck   (ctrl_Sl_errAck),
    .ctrl_Sl_retry    (ctrl_Sl_retry),
    .ctrl_Sl_toutSup  (ctrl_Sl_toutSup),
    .ctrl_Sl_xferAck  (ctrl_Sl_xferAck),
    .ctrl_OPB_ABus    (ctrl_OPB_ABus),
    .ctrl_OPB_BE      (ctrl_OPB_BE),
    .ctrl_OPB_DBus    (ctrl_OPB_DBus),
    .ctrl_OPB_RNW     (ctrl_OPB_RNW),
    .ctrl_OPB_select  (ctrl_OPB_select),
    .ctrl_OPB_seqAddr (ctrl_OPB_seqAddr),

    .mem_OPB_Clk     (mem_OPB_Clk),
    .mem_OPB_Rst     (mem_OPB_Rst),
    .mem_Sl_DBus     (mem_Sl_DBus),
    .mem_Sl_errAck   (mem_Sl_errAck),
    .mem_Sl_retry    (mem_Sl_retry),
    .mem_Sl_toutSup  (mem_Sl_toutSup),
    .mem_Sl_xferAck  (mem_Sl_xferAck),
    .mem_OPB_ABus    (mem_OPB_ABus),
    .mem_OPB_BE      (mem_OPB_BE),
    .mem_OPB_DBus    (mem_OPB_DBus),
    .mem_OPB_RNW     (mem_OPB_RNW),
    .mem_OPB_select  (mem_OPB_select),
    .mem_OPB_seqAddr (mem_OPB_seqAddr),

    .dram_clk        (dram_clk),
    .dram_rst        (dram_rst),
    .phy_ready       (1'b1),
    .dram_cmd_addr   (dram_cmd_addr),
    .dram_cmd_rnw    (dram_cmd_rnw),
    .dram_cmd_valid  (dram_cmd_valid),
    .dram_wr_data    (dram_wr_data),
    .dram_wr_be      (dram_wr_be),
    .dram_rd_data    (dram_rd_data),
    .dram_rd_valid   (dram_rd_valid),
    .dram_fifo_ready (dram_fifo_ready),

    .app_cmd_addr  (app_cmd_addr),
    .app_cmd_rnw   (app_cmd_rnw),
    .app_cmd_valid (app_cmd_valid),
    .app_cmd_ack   (app_cmd_ack),
    .app_wr_data   (app_wr_data),
    .app_wr_be     (app_wr_be),
    .app_rd_data   (app_rd_data),
    .app_rd_valid  (app_rd_valid)
  );

  /****** System Signal generations ******/

  reg [31:0] dram_clk_counter;
  reg [31:0] sys_clk_counter;

  reg reset;

  initial begin
    dram_clk_counter <= 32'b0;
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

  /* sys_clk / sys_rst gen */
  assign sys_clk = sys_clk_counter < (( `SYS_CLK_PERIOD)/2);
  always begin
    #1 sys_clk_counter <= (sys_clk_counter == `SYS_CLK_PERIOD - 1 ? 32'b0 : sys_clk_counter + 1);
  end

  reg sys_rst_reg;
  always @(posedge sys_clk) begin
    sys_rst_reg <= reset;
  end
  assign sys_rst = sys_rst_reg;

  /* dram_clk / dram_rst gen */
  assign dram_clk = dram_clk_counter < ((`DRAM_CLK_PERIOD)/2);
  always begin
    #1 dram_clk_counter <= (dram_clk_counter == `DRAM_CLK_PERIOD - 1 ? 32'b0 : dram_clk_counter + 1);
  end

  reg dram_rst_reg;
  always @(posedge dram_clk) begin
    dram_rst_reg <= reset;
  end
  assign dram_rst = dram_rst_reg;

  /********** Mode Control ***********/

  localparam MODE_WAIT  = 2'd0;
  localparam MODE_WRITE = 2'd1;
  localparam MODE_READ  = 2'd2;

  localparam NUM_MODES = 3;

  reg [1:0] mode;
  reg [NUM_MODES - 1:0] mode_done;

  reg [31:0] mode_data;

  wire [31:0] expected_data;

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
              $display("FAILED: data mismatch - expected %x, got %x", expected_data, mode_data);
            end
            $finish;
          end
        end
      endcase
    end
  end

  assign expected_data = TEST_DATA;

  reg [31:0] mode_counter;
  localparam WAIT_LENGTH = 100;

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

  wire [31:0] Sl_DBus;
  wire Sl_xferAck;

  reg [1:0] opbm_state;
  localparam OPB_COMMAND = 2'd0;
  localparam OPB_COLLECT = 2'd1;
  localparam OPB_WAIT    = 2'd2;

  always @(posedge sys_clk) begin
    mode_done[MODE_WRITE] <= 1'b0;
    mode_done[MODE_READ]  <= 1'b0;

    if (sys_rst) begin
      OPB_ABus_reg   <= 32'b0;
      OPB_DBus_reg   <= 32'b0;
      OPB_BE_reg     <= 4'b0;
      OPB_RNW_reg    <= 1'b0;

      OPB_select_reg <= 1'b0;
      opbm_state     <= OPB_COMMAND;
    end else begin
      case (opbm_state)
        OPB_COMMAND: begin
          case (mode)
            MODE_WRITE: begin
              OPB_ABus_reg   <= TEST_ADDR + OPB_BASEADDR;
              OPB_DBus_reg   <= TEST_DATA;
              OPB_BE_reg     <= 4'b1111;
              OPB_select_reg <= 1'b1;
              OPB_RNW_reg    <= 1'b0;
              opbm_state     <= OPB_COLLECT;
`ifdef DEBUG
              $display("opbm: sending write, a = %x, d = %x, be = %b", TEST_ADDR + OPB_BASEADDR, TEST_DATA, 4'b1111);
`endif
            end
            MODE_READ: begin
              OPB_ABus_reg   <= TEST_ADDR + OPB_BASEADDR;
              OPB_select_reg <= 1'b1;
              OPB_RNW_reg    <= 1'b1;
              opbm_state     <= OPB_COLLECT;
`ifdef DEBUG
              $display("opbm: sending read, a = %x", TEST_ADDR + OPB_BASEADDR);
`endif
            end
          endcase
        end

        OPB_COLLECT: begin
          if (Sl_xferAck) begin
            OPB_select_reg <= 1'b0;
            case (mode)
              MODE_WRITE: begin
                mode_done[MODE_WRITE] <= 1'b1;
`ifdef DEBUG
                $display("opbm: got write response");
`endif
              end
              MODE_READ: begin
                mode_data <= Sl_DBus;
                mode_done[MODE_READ] <= 1'b1;
`ifdef DEBUG
                $display("opbm: got read response, data = %x", Sl_DBus);
`endif
              end
            endcase
            opbm_state <= OPB_WAIT;
          end
        end

        OPB_WAIT: begin
          opbm_state <= OPB_COMMAND;
        end
      endcase
    end
  end

  assign mem_OPB_Clk     = sys_clk;
  assign mem_OPB_Rst     = sys_rst;
  assign mem_OPB_ABus    = OPB_ABus_reg;
  assign mem_OPB_DBus    = OPB_DBus_reg;
  assign mem_OPB_BE      = OPB_BE_reg;
  assign mem_OPB_RNW     = OPB_RNW_reg;
  assign mem_OPB_select  = OPB_select_reg;
  assign mem_OPB_seqAddr = 1'b0;
  assign Sl_DBus         = mem_Sl_DBus;
  assign Sl_xferAck      = mem_Sl_xferAck;

  /* No control interface */
  assign ctrl_OPB_Clk     = sys_clk;
  assign ctrl_OPB_Rst     = sys_rst;
  assign ctrl_OPB_ABus    = 0;
  assign ctrl_OPB_DBus    = 0;
  assign ctrl_OPB_BE      = 0;
  assign ctrl_OPB_RNW     = 0;
  assign ctrl_OPB_select  = 0;
  assign ctrl_OPB_seqAddr = 0;

  /******** Simulated DRAM Fabric Interface *******/

  /* command gen */
  reg [31:0] cmd_progress;

  reg [1:0] dramapp_state;
  localparam DAPP_WRITE   = 2'd0;
  localparam DAPP_WR_WAIT = 2'd1;
  localparam DAPP_READ    = 2'd2;
  localparam DAPP_RD_WAIT = 2'd3;

  always @(posedge dram_clk) begin
    if (dram_rst) begin
      dramapp_state <= DAPP_WRITE;
      cmd_progress  <= 32'd0;
    end else begin
      case (dramapp_state)
        DAPP_WRITE: begin
          if (app_cmd_ack) begin
            dramapp_state <= DAPP_WR_WAIT;
          end
        end
        DAPP_WR_WAIT: begin
          dramapp_state <= DAPP_READ;
        end
        DAPP_READ: begin
          if (app_cmd_ack) begin
            dramapp_state <= DAPP_RD_WAIT;
          end
        end
        DAPP_RD_WAIT: begin
          dramapp_state <= DAPP_WRITE;
          cmd_progress  <= cmd_progress + 1;
        end
      endcase
    end
  end

  /* read collection */
  reg [31:0] read_progress;

  reg first_read;

  wire [143:0] test_app_rd_data = {5{read_progress}};

  always @(posedge dram_clk) begin
    first_read <= 1'b1;
    if (dram_rst) begin
      read_progress <= 32'b0;
      first_read    <= 1'b1;
    end else begin
      if (!first_read) begin
        if (app_rd_data !== ~test_app_rd_data) begin
          $display("ERROR: fabric interface data mismatch - got %x, expected %x", app_rd_data, ~test_app_rd_data);
          $finish;
        end
        read_progress <= read_progress + 1;
      end else begin
        if (app_rd_valid) begin
          if (app_rd_data !== test_app_rd_data) begin
            $display("ERROR: fabric interface data mismatch - got %x, expected %x", app_rd_data, test_app_rd_data);
            $finish;
          end
          first_read <= 1'b0;
        end
      end
    end
  end

  /* assignments */
  assign app_cmd_addr  = cmd_progress[9:0]; //only use 10 bits
  assign app_cmd_rnw   = dramapp_state == DAPP_READ;
  assign app_cmd_valid = dramapp_state == DAPP_WRITE || dramapp_state == DAPP_READ;
  assign app_wr_data   = dramapp_state == DAPP_WRITE ? {5{cmd_progress}} : ~{5{cmd_progress}}; 
  assign app_wr_be     = {18{1'b1}}; //all enabled

  /********** Simulated DRAM Interface ***********/

  dram_controller #(
    .DRAM_DEPTH (16384),
    .HARD_READY (0)
  ) dram_controller_inst (
    .dram_clk (dram_clk),
    .dram_rst (dram_rst),

    .dram_cmd_addr  (dram_cmd_addr),
    .dram_cmd_rnw   (dram_cmd_rnw),
    .dram_cmd_valid (dram_cmd_valid),
    .dram_wr_data   (dram_wr_data),
    .dram_wr_be     (dram_wr_be),
    .dram_rd_data   (dram_rd_data),
    .dram_rd_valid  (dram_rd_valid),
    .dram_ready     (dram_fifo_ready)
  );
  
endmodule
