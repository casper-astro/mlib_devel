`timescale 1ns/1ps

`define SIM_LENGTH 400000

`define APPCLK_PERIOD 4
module TB_emac_mdio();

/**** CPU Bus Attachment ****/
  wire        wb_clk_i;
  wire        wb_rst_i;
  wire        wb_stb_i;
  wire        wb_cyc_i;
  wire        wb_we_i;
  wire [31:0] wb_adr_i;
  wire [31:0] wb_dat_i;
  wire  [3:0] wb_sel_i;
  wire [31:0] wb_dat_o;
  wire        wb_err_o;
  wire        wb_ack_o;

  wire        hostclk;
  wire  [1:0] hostopcode;
  wire        hostreq;
  wire        hostmiimsel;
  wire  [9:0] hostaddr; 
  wire [31:0] hostwrdata;
  wire [31:0] hostrddata;
  wire        hostmiimrdy;

  emac_mdio_wb emac_mdio_wb (
    .wb_clk_i(wb_clk_i),
    .wb_rst_i(wb_rst_i),
    .wb_cyc_i(wb_cyc_i),
    .wb_stb_i(wb_stb_i),
    .wb_we_i(wb_we_i),
    .wb_sel_i(wb_sel_i),
    .wb_adr_i(wb_adr_i),
    .wb_dat_i(wb_dat_i),
    .wb_dat_o(wb_dat_o),
    .wb_ack_o(wb_ack_o),
    .wb_err_o(wb_err_o),

    .hostclk(hostclk),
    .hostopcode(hostopcode),
    .hostreq(hostreq),
    .hostmiimsel(hostmiimsel),
    .hostaddr(hostaddr), 
    .hostwrdata(hostwrdata),
    .hostrddata(hostrddata),
    .hostmiimrdy(hostmiimrdy)
  );

  reg [31:0] clk_counter;
  reg rst;

  initial begin
    $dumpvars;
    clk_counter <= 32'b0;
    rst <= 1'b1;
    #100
    rst <= 1'b0;
    #`SIM_LENGTH
    $display("FAILED: simulation timed out");
    $finish;
  end

  always
   #1 clk_counter <= clk_counter + 1;

  wire app_clk = (clk_counter % (`APPCLK_PERIOD)) < ((`APPCLK_PERIOD)/2);
  /************************ Simulated emac ********************/

  reg    hostmiimrdy_reg;
  assign hostmiimrdy = hostmiimrdy_reg;
  assign hostrddata = hostwrdata;

  reg  [1:0] emac_state;
  reg [31:0] emac_progress;

  reg [3:0] test_mask;

  always @(posedge hostclk) begin

    if (rst) begin
      hostmiimrdy_reg <= 1'b1;
      emac_state <= 2'b0;
      test_mask <= 4'b0;
    end else begin
      case (emac_state)
        2'b00: begin
          if (!hostmiimsel && hostaddr[9]) begin
            if (hostopcode[1]) begin /* read */
              emac_state <= 2'b01;
              test_mask <= test_mask | 4'b0001;
              $display("config read");
            end else begin
              test_mask <= test_mask | 4'b0010;
              emac_state <= 2'b10;
              $display("config write");
            end
          end else if (hostreq) begin
            $display("MDIO read");
            test_mask <= test_mask | 4'b1100;
            hostmiimrdy_reg <= 1'b0;
            emac_state <= 2'b11;
            emac_progress <= 0;
          end
        end
        2'b01: begin
          if (hostmiimsel) begin
            $display("FAILED: expected another high on hostmiimsel");
            $finish;
          end
          emac_state <= 2'b00;
        end
        2'b10: begin
          emac_state <= 2'b00;
        end
        2'b11: begin
          emac_progress <= emac_progress + 1;
          if (emac_progress > 16) begin
            hostmiimrdy_reg <= 1'b1;
            emac_state <= 2'b0;
          end
        end
      endcase
    end
  end

  /************************ CPU Master ******************************/

  reg cpu_rst;
  always @(posedge cpu_clk) begin
    cpu_rst <= rst;
  end
  wire cpu_clk = app_clk;

  reg         cpu_stb;
  reg         cpu_rnw;
  reg   [3:0] cpu_sel;
  reg  [31:0] cpu_adr;
  reg  [31:0] cpu_dat_wr;
  wire [31:0] cpu_dat_rd;
  wire        cpu_ack;

  reg [31:0] cpu_progress;


  always @(posedge cpu_clk) begin
    cpu_stb <= 1'b0;

    if (cpu_rst) begin
      cpu_progress <= 32'b0;
    end else begin
      case (cpu_progress)
        0 : begin
            cpu_rnw <= 1'b0;
            cpu_adr <= 32'h8;
            cpu_dat_wr <= 32'b001;
            cpu_stb <= 1'b1;
            cpu_progress <= cpu_progress + 1;
        end
        1 : if (cpu_ack)
              cpu_progress = cpu_progress + 1;
        2 : begin
            cpu_rnw <= 1'b0;
            cpu_adr <= 32'h4;
            cpu_dat_wr <= 32'h1;
            cpu_stb <= 1'b1;
            cpu_progress <= cpu_progress + 1;
        end
        3 : if (cpu_ack)
              cpu_progress = cpu_progress + 1;
        4 : begin
            cpu_rnw <= 1'b0;
            cpu_adr <= 32'h8;
            cpu_dat_wr <= 32'b101;
            cpu_stb <= 1'b1;
            cpu_progress <= cpu_progress + 1;
        end
        5 : if (cpu_ack)
              cpu_progress = cpu_progress + 1;
        6 : begin
            cpu_rnw <= 1'b0;
            cpu_adr <= 32'h4;
            cpu_dat_wr <= 32'h1;
            cpu_stb <= 1'b1;
              cpu_progress = cpu_progress + 1;
        end
        7 : if (cpu_ack)
              cpu_progress = cpu_progress + 1;
        8 : begin
            cpu_rnw <= 1'b0;
            cpu_adr <= 32'h8;
            cpu_dat_wr <= 32'h0;
            cpu_stb <= 1'b1;
              cpu_progress = cpu_progress + 1;
        end
        9 : if (cpu_ack)
              cpu_progress = cpu_progress + 1;
        10 : begin
            cpu_rnw <= 1'b0;
            cpu_adr <= 32'h4;
            cpu_dat_wr <= 32'h1;
            cpu_stb <= 1'b1;
              cpu_progress = cpu_progress + 1;
        end
        11 : if (cpu_ack)
              cpu_progress = cpu_progress + 1;
        99 : begin /* wait for MDIO to respond */
          if (test_mask === 4'b1111) begin
            $display("PASSED");
            $finish;
          end else begin
            $display("FAILED: test_make = %b", test_mask);
            $finish;
          end
        end
        default: begin
           cpu_progress = cpu_progress + 1;
        end
      endcase
    end
  end

  assign wb_clk_i   = cpu_clk;
  assign wb_rst_i   = cpu_rst;

  assign wb_stb_i   = cpu_stb;
  assign wb_cyc_i   = cpu_stb;
  assign wb_we_i    = !cpu_rnw;
  assign wb_adr_i   = cpu_adr;
  assign wb_dat_i   = cpu_dat_wr;
  assign wb_sel_i   = cpu_sel;

  assign cpu_dat_rd = wb_dat_o;
  assign cpu_ack    = wb_ack_o;



endmodule
