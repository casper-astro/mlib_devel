module dram_controller #(
    parameter DRAM_DEPTH = 16384,
    parameter HARD_READY = 0
  ) (
    input  dram_clk,
    input  dram_rst,
    input   [31:0] dram_cmd_addr,
    input  dram_cmd_rnw,
    input  dram_cmd_valid,
    input  [143:0] dram_wr_data,
    input   [17:0] dram_wr_be,
    output [143:0] dram_rd_data,
    output dram_rd_valid,
    output dram_ready
  );

  /************ Simulated Memory **************/
  /*  18 bytes per word, two words per burst  */

  reg [7:0] dram_mem [18*DRAM_DEPTH*2 - 1:0];

  /* dram state control */
  reg dram_state;
  localparam READY = 1'b0;
  localparam WAIT  = 1'b1;

  integer i;

  wire [31:0] mem_address = (dram_cmd_addr >> 2) << 1;
  /* word address: lower 2 bits truncated then 1 bit extended - two words per burst */

  reg [31:0] mem_address_z;
  /* the word address on the second cycle */
  always @(posedge dram_clk) begin
    mem_address_z <= mem_address + 1; 
  end

  /* if HARD_READY is enable, mask the valid that the controller sees with the dram_fifo_ready signal */
  wire dram_cmd_overflow;
  wire dram_cmd_valid_real = HARD_READY ? dram_cmd_valid && dram_ready : dram_cmd_valid && !dram_cmd_overflow;

  reg dram_cmd_rnw_z;

  always @(posedge dram_clk) begin
    dram_cmd_rnw_z <= dram_cmd_rnw;
    if (dram_rst) begin
      dram_state <= READY;
    end else begin
      case (dram_state)
        READY: begin
          if (dram_cmd_valid_real) begin
            dram_state <= WAIT;
          end
        end
        WAIT: begin
          dram_state <= READY;
        end
      endcase
    end
  end

  /* Write Logic */

  /* get around no variable bit select in always block limitation */
  wire [7:0] dram_wr_data_int [17:0];

genvar geni;
generate for (geni=0; geni < 18; geni = geni+1) begin : gen_dram_wr_data_int
  assign dram_wr_data_int[geni] = dram_wr_data[8*(geni + 1) - 1:8*geni];
end endgenerate

  always @(posedge dram_clk) begin
    if (dram_rst) begin
    end else begin
      case (dram_state)
        READY: begin
          if (dram_cmd_valid_real && !dram_cmd_rnw) begin
            for (i=0; i < 18; i = i+1) begin
              if (dram_wr_be[i]) begin
                dram_mem[(mem_address)*18 + i] <= dram_wr_data_int[i];
              end
            end
`ifdef DESPERATE_DEBUG
            $display("dram: got write - addr = %x, data = %x, be = %x", mem_address, dram_wr_data, dram_wr_be);
`endif
          end
        end
        WAIT: begin
          if (!dram_cmd_rnw_z) begin
            for (i=0; i < 18; i = i+1) begin
              if (dram_wr_be[i]) begin
                dram_mem[(mem_address_z)*18 + i] <= dram_wr_data_int[i];
              end
            end
`ifdef DESPERATE_DEBUG
            $display("dram: 2nd write - addr = %x, data = %x, be = %x", mem_address_z, dram_wr_data, dram_wr_be);
`endif
          end
        end
      endcase 
    end
  end

  /* Read Logic */

  wire [143:0] dram_rd_data_int;
  /* get around no variable bit select in always block limitation */
genvar genj;
generate for (genj=0; genj < 18; genj = genj+1) begin : gen_dram_rd_data_int
  assign dram_rd_data_int[8*(genj + 1) - 1 : 8*genj] = dram_state == WAIT ? dram_mem[18*mem_address_z + genj] : dram_mem[18*mem_address + genj];
end endgenerate

  localparam READ_LATENCY = 16;

  reg     [READ_LATENCY - 1:0] dram_rd_dvld_shiftreg;
  reg [144*READ_LATENCY - 1:0] dram_rd_data_shiftreg;

  always @(posedge dram_clk) begin
    if (dram_rst) begin
      dram_rd_dvld_shiftreg <= {READ_LATENCY{1'b0}};
    end else begin
      if (dram_state == READY && dram_cmd_valid_real && dram_cmd_rnw || dram_state == WAIT && dram_cmd_rnw_z) begin
        dram_rd_dvld_shiftreg <= {dram_rd_dvld_shiftreg[READ_LATENCY - 2:0], 1'b1};
`ifdef DESPERATE_DEBUG
        
        $display("dram: outputting read data, addr = %x, data = %x", (dram_state == WAIT ? mem_address_z : mem_address), dram_rd_data_int);
`endif
      end else begin
        dram_rd_dvld_shiftreg <= {dram_rd_dvld_shiftreg[READ_LATENCY - 2:0], 1'b0};
      end

      /* Always shift out the data */
      dram_rd_data_shiftreg <= {dram_rd_data_shiftreg, dram_rd_data_int};
    end
  end

  assign dram_rd_data  = dram_rd_data_shiftreg[(READ_LATENCY)*144 - 1:(READ_LATENCY - 1)*144];
  assign dram_rd_valid = dram_rd_dvld_shiftreg[READ_LATENCY - 1];


  /******* dram ready controls ********/

  localparam CMD_OVER_THRESH = 72;
  localparam CMD_WAIT_THRESH = 64;
  reg [31:0] cmd_acc;

  always @(posedge dram_clk) begin
    if (dram_rst) begin
      cmd_acc    <= 0;
    end else begin
      if (dram_cmd_valid_real) begin
        cmd_acc <= cmd_acc + 1;
      end else if (cmd_acc) begin
        cmd_acc <= cmd_acc - 1;
      end
    end
  end
  assign dram_ready        = cmd_acc < CMD_WAIT_THRESH;
  assign dram_cmd_overflow = cmd_acc >= CMD_OVER_THRESH;

endmodule

