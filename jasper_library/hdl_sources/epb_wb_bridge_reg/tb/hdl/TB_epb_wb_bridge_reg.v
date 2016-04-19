`timescale 1ns/10ps

`define SIMLENGTH 64000
`define CLK_PERIOD 10

`define NUM_OPS 16
module TB_epb_wb_bridge_reg();
  reg reset;
  wire clk;

  wire wb_cyc_o, wb_stb_o, wb_we_o;
  wire  [1:0] wb_sel_o;
  wire [31:0] wb_adr_o;
  wire [15:0] wb_dat_o;
  reg  [15:0] wb_dat_i;
  reg  wb_ack_i, wb_err_i;

  wire epb_clk;
  reg  epb_cs_n;
  reg  epb_r_w_n;
  wire  [1:0] epb_be_n;
  wire [22:0] epb_addr;
  wire  [5:0] epb_addr_gp;
  wire [15:0] epb_data_o;
  reg  [15:0] epb_data_i;
  wire epb_rdy;

  epb_wb_bridge_reg epb_wb_bridge_reg_inst(
    .wb_clk_i(clk), .wb_rst_i(reset),
    .wb_cyc_o(wb_cyc_o), .wb_stb_o(wb_stb_o), .wb_we_o(wb_we_o), .wb_sel_o(wb_sel_o),
    .wb_adr_o(wb_adr_o), .wb_dat_o(wb_dat_o), .wb_dat_i(wb_dat_i),
    .wb_ack_i(wb_ack_i), .wb_err_i(wb_err_i),

    .epb_clk(epb_clk),
    .epb_cs_n(epb_cs_n), .epb_r_w_n(epb_r_w_n), .epb_be_n(epb_be_n), 
    .epb_addr(epb_addr), .epb_addr_gp(epb_addr_gp),
    .epb_data_i(epb_data_i), .epb_data_o(epb_data_o), 
    .epb_rdy(epb_rdy)
  );

  reg [31:0] clk_counter;

  initial begin
    $dumpvars;
    reset<=1'b1;
    clk_counter<=32'b0;
    #50
    reset<=1'b0;
`ifdef DEBUG
    $display("sys: reset cleared");
`endif
    #`SIMLENGTH
    $display("FAILED: simulation timed out");
    $finish;
  end

  assign clk = clk_counter < ((`CLK_PERIOD) / 2);

  always begin
    #1 clk_counter <= (clk_counter == `CLK_PERIOD - 1 ? 32'b0 : clk_counter + 1);
  end

  /****** Mode Control *******/
  reg [15:0] wb_mem  [1024*64-1:0]; 
  reg [15:0] epb_mem [1024*64-1:0]; 

  reg mode;
  localparam MODE_WRITE = 1'd0;
  localparam MODE_READ  = 1'd1;
  reg [1:0] mode_done;

  integer i;
  always @(posedge clk) begin
    if (reset) begin
      mode <= MODE_WRITE;
    end else begin
      case (mode)
        MODE_WRITE: begin
          if (mode_done[MODE_WRITE]) begin
            mode <= MODE_READ;
`ifdef DEBUG
            $display("mode: MODE_WRITE done");
`endif 
          end
        end
        MODE_READ: begin
          if (mode_done[MODE_READ]) begin
            for (i=0; i < `NUM_OPS; i=i+1) begin
              if (wb_mem[i] !== i) begin
                $display("FAILED: wb mem mismatch - got %x, expected %x", wb_mem[i], i);
                $finish;
              end
              if (epb_mem[i] !== i) begin
                $display("FAILED: epb mem mismatch - got %x, expected %x", epb_mem[i], i);
                $finish;
              end
            end
            $display("PASSED");
            $finish;
          end
        end
      endcase
    end
  end

  /*********** WishBone Slave ************/

  always @(posedge clk) begin
    wb_ack_i <= 1'b0;
    if (reset) begin
    end else begin
      if (wb_cyc_o & wb_stb_o & !wb_ack_i) begin
        wb_ack_i <= 1'b1;
        if (wb_we_o) begin
          wb_mem[wb_adr_o[15:1]] <= wb_dat_o;
`ifdef DEBUG
          $display("wbs: got write, adr = %x, data = %x", wb_adr_o, wb_dat_o);
`endif
        end else begin
          wb_dat_i <= wb_mem[wb_adr_o[15:1]];
`ifdef DEBUG
          $display("wbs: got read, adr = %x, data = %x", wb_adr_o, wb_mem[wb_adr_o[15:1]]);
`endif
        end
      end
    end
  end

  /************ EPB Master *****************/

  reg clk_div;
  initial begin
    clk_div <= 1'b0;
  end
  always @(posedge clk) begin
    clk_div <= ~clk_div;
  end

  assign #1 epb_clk = clk_div;

  reg [1:0] epb_state;
  localparam EPB_COMMAND = 2'd0;
  localparam EPB_COLLECT = 2'd1;
  localparam EPB_WAIT    = 2'd2;

  reg [31:0] mode_progress;

  reg [28:0] epb_addr_r;
  assign epb_addr = epb_addr_r[22:0];
  assign epb_addr_gp = epb_addr_r[28:23];

  assign epb_be_n = 2'b00;

  always @(posedge epb_clk) begin
    if (reset) begin
      epb_state <= EPB_COMMAND;
      mode_progress <= 32'b0;
      epb_cs_n <= 1'b1;
      mode_done[MODE_WRITE] <= 1'b0;
      mode_done[MODE_READ]  <= 1'b0;
    end else begin
      case (epb_state) 
        EPB_COMMAND: begin
          case (mode)
            MODE_WRITE: begin
              epb_r_w_n <= 1'b0;
`ifdef DEBUG
              $display("epbm: sent write, adr = %x, data = %x", mode_progress[28:0], mode_progress[15:0]);
`endif
            end
            MODE_READ: begin
              epb_r_w_n <= 1'b1;
`ifdef DEBUG
              $display("epbm: sent read, adr = %x", mode_progress[28:0]);
`endif
            end
          endcase

          epb_cs_n <= 1'b0;
          epb_addr_r <= mode_progress[28:0];
          epb_data_i <= mode_progress[15:0];

          epb_state  <= EPB_COLLECT;
        end
        EPB_COLLECT: begin
          if (epb_rdy) begin
            epb_cs_n <= 1'b1;
            if (mode_progress < `NUM_OPS - 1) begin
              mode_progress <= mode_progress + 1;
              epb_state <= EPB_COMMAND;
            end else begin
              mode_progress <= 32'b0;
              mode_done[mode] <= 1'b1;
              epb_state <= EPB_WAIT;
            end
            if (mode == MODE_READ) begin
              epb_mem[epb_addr_r] <= epb_data_o;
            end
          end
        end
        EPB_WAIT: begin
          epb_state <= EPB_COMMAND;
        end
      endcase
    end
  end

  
endmodule
