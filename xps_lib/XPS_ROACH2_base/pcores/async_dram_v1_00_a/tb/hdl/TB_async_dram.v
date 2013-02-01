`timescale 1ns/10ps

`define SIMLENGTH       100000
`define SYS_CLK_PERIOD  22
`define DRAM_CLK_PERIOD 6

module TB_async_dram();

  localparam BRAM_FIFOS    = 0;
  localparam WIDE_DATA     = 0;
  localparam HALF_BURST    = 0;
  localparam TAG_BUFFER_EN = 0;
  localparam TEST_LENGTH   = 1000;

  wire sys_rst;
  wire sys_clk;

  wire dram_clk;
  wire dram_rst;

  /***************** DUT ***************/

  wire  [143:0] dram_data_o;
  wire   [17:0] dram_byte_enable;
  wire  [143:0] dram_data_i;
  wire          dram_data_valid;
  wire   [31:0] dram_address;
  wire          dram_rnw;
  wire          dram_reset;
  wire          dram_cmd_en;
  wire          dram_ready;

  wire          Mem_Clk;
  wire          Mem_Rst;
  wire          Mem_Error;
  wire   [31:0] Mem_Cmd_Address;
  wire          Mem_Cmd_RNW;
  wire          Mem_Cmd_Valid;
  wire          Mem_Cmd_Ack;
  wire   [31:0] Mem_Cmd_Tag;
  wire  [143:0] Mem_Rd_Dout;
  wire          Mem_Rd_Ack;
  wire          Mem_Rd_Valid;
  wire   [31:0] Mem_Rd_Tag;
  wire [((WIDE_DATA+1)*144) - 1:0]
                Mem_Wr_Din;
  wire [((WIDE_DATA+1)*18) - 1:0]
                Mem_Wr_BE;

  async_dram #(
    .TAG_BUFFER_EN (TAG_BUFFER_EN),
    .BRAM_FIFOS    (BRAM_FIFOS),
    .C_WIDE_DATA   (WIDE_DATA),
    .C_HALF_BURST  (HALF_BURST)
  ) async_dram (
    .sys_rst         (sys_rst),

    .Mem_Clk         (Mem_Clk),
    .Mem_Rst         (Mem_Rst),
    .Mem_Cmd_Address (Mem_Cmd_Address),
    .Mem_Cmd_RNW     (Mem_Cmd_RNW),
    .Mem_Cmd_Valid   (Mem_Cmd_Valid),
    .Mem_Cmd_Ack     (Mem_Cmd_Ack),
    .Mem_Rd_Dout     (Mem_Rd_Dout),
    .Mem_Rd_Ack      (Mem_Rd_Ack),
    .Mem_Rd_Valid    (Mem_Rd_Valid),
    .Mem_Wr_Din      (Mem_Wr_Din),
    .Mem_Wr_BE       (Mem_Wr_BE),

        .Mem_Rd_Tag      (Mem_Rd_Tag),
        .Mem_Cmd_Tag     (Mem_Cmd_Tag),

    .dram_clk         (dram_clk),
    .dram_reset       (dram_reset),
    .dram_data_o      (dram_data_o),
    .dram_byte_enable (dram_byte_enable),
    .dram_data_i      (dram_data_i),
    .dram_data_valid  (dram_data_valid),
    .dram_address     (dram_address),
    .dram_rnw         (dram_rnw),
    .dram_cmd_en      (dram_cmd_en),
    .dram_ready       (dram_ready)
  );


  /****** System Signal generations ******/

  reg [31:0] dram_clk_counter;
  reg [31:0] sys_clk_counter;

  reg reset;

  initial begin
    dram_clk_counter <= 32'b0;
    sys_clk_counter  <= 32'b0;

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

  localparam MODE_RESET = 2'b10;
  localparam MODE_WRITE = 2'b00;
  localparam MODE_READ  = 2'd01;

  localparam NUM_MODES = 2;

  reg [1:0] mode;
  wire [NUM_MODES - 1:0] mode_done;

  reg [31:0] mode_data;

  wire [31:0] expected_data;

  always @(posedge sys_clk) begin
    if (sys_rst) begin
      mode <= MODE_RESET;
    end else begin
      case (mode)
        MODE_RESET: begin
            mode <= MODE_WRITE;
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
            $display("PASSED");
            $finish;
          end
        end
      endcase
    end
  end


  /********** Simulated DRAM Interface ***********/

  dram_controller #(
    .DRAM_DEPTH (16384),
    .HARD_READY (1)
  ) dram_controller_inst (
    .dram_clk (dram_clk),
    .dram_rst (dram_rst),

    .dram_cmd_addr  (dram_address),
    .dram_cmd_rnw   (dram_rnw),
    .dram_cmd_valid (dram_cmd_en),
    .dram_wr_data   (dram_data_o),
    .dram_wr_be     (dram_byte_enable),
    .dram_rd_data   (dram_data_i),
    .dram_rd_valid  (dram_data_valid),
    .dram_ready     (dram_ready)
  );

  /********** Simulated Fabric Interface ***********/

  reg [31:0] cmd_progress;
  reg second;


  /* Command Generation */
  always @(posedge sys_clk) begin

    if (sys_rst) begin
      cmd_progress  <= 32'b0;
      second <= 1'b0;
    end else begin
      case (mode)
        MODE_WRITE: begin 
          if (Mem_Cmd_Ack && !second) begin
            if (!(HALF_BURST || WIDE_DATA)) begin
              second <= 1'b1;
            end else begin  
              cmd_progress <= cmd_progress + 1;
            end
`ifdef DEBUG
              $display($time,": fab: write first data = %x, address = %x",Mem_Wr_Din, Mem_Cmd_Address);
`endif
          end
          if( second && Mem_Cmd_Ack ) begin 
              second <= 1'b0; 
              cmd_progress <= cmd_progress + 1;
          
              if (cmd_progress == TEST_LENGTH) begin
                cmd_progress <= 32'b0;
              end
          
`ifdef DEBUG
              $display($time, ": fab: write second data = %x, address = %x",Mem_Wr_Din, Mem_Cmd_Address);
`endif          
          end

        end
        MODE_READ:  begin
`ifdef DEBUG
              $display($time, ": fab: read address = %x",Mem_Cmd_Address);
`endif
          if (Mem_Cmd_Ack && cmd_progress <= TEST_LENGTH)
            cmd_progress <= cmd_progress + 1;
        end
        

      endcase
    end
  end

  assign mode_done[MODE_WRITE] = (mode == MODE_WRITE && cmd_progress == TEST_LENGTH && (second & Mem_Cmd_Ack | (WIDE_DATA || HALF_BURST) && Mem_Cmd_Ack));
  assign Mem_Cmd_Address = cmd_progress;
  assign Mem_Cmd_RNW     = mode == MODE_READ;
  assign Mem_Cmd_Valid   = ((mode == MODE_READ || mode == MODE_WRITE) && cmd_progress <= TEST_LENGTH) ? 1'b1 : 1'b0; //always issue commands
  assign Mem_Cmd_Tag     = cmd_progress;

  reg [(WIDE_DATA+1*144) - 1:0]
         Mem_Wr_Din_reg;

  wire [143:0] foo_data = {5{cmd_progress}};
  always @(*) begin
    if (WIDE_DATA) begin
      Mem_Wr_Din_reg <= {~foo_data, foo_data};
    end else if (second) begin
      Mem_Wr_Din_reg <= ~foo_data;
    end else begin
      Mem_Wr_Din_reg <= foo_data;
    end
  end
  assign Mem_Wr_Din = Mem_Wr_Din_reg;
  assign Mem_Wr_BE  = WIDE_DATA ? {36{1'b1}} : {18{1'b1}};
  assign Mem_Rd_Ack = 1'b1;

  /* Read Processing */

  reg [31:0] rd_progress;
  reg rd_second;

  wire [143:0] rd_foo_data = {5{rd_progress}};

  always @(posedge sys_clk) begin
    rd_second            <= 1'b0;

    if (sys_rst) begin
      rd_progress <= 32'b0;
    end else begin
      if (rd_second) begin
        rd_progress <= rd_progress + 1;

        if (!HALF_BURST) begin
          if (Mem_Rd_Dout !== ~rd_foo_data) begin
            $display("ERROR: data mismatch - got %x, expected %x", Mem_Rd_Dout, ~rd_foo_data);
            $finish;
          end
        end
        if (Mem_Rd_Tag !== rd_progress && TAG_BUFFER_EN) begin
          $display("ERROR: tag mismatch - got %x, expected %x", Mem_Rd_Tag, rd_progress);
          $finish;
        end
      end else if (Mem_Rd_Valid) begin
        rd_second <= 1'b1;
        if (Mem_Rd_Dout !== rd_foo_data) begin
          $display("ERROR: data mismatch - got %x, expected %x", Mem_Rd_Dout, rd_foo_data);
          $finish;
        end
      end
    end
  end

  assign Mem_Clk = sys_clk;
  assign Mem_Rst = sys_rst;
  assign mode_done[MODE_READ] = (rd_second && rd_progress == TEST_LENGTH);
  
endmodule
