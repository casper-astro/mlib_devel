module gpio_controller #(
    parameter COUNT = 32
  ) (
    input         wb_clk_i,
    input         wb_rst_i,
    input         wb_cyc_i,
    input         wb_stb_i,
    input         wb_we_i,
    input   [3:0] wb_sel_i,
    input  [31:0] wb_adr_i,
    input  [31:0] wb_dat_i,
    output [31:0] wb_dat_o,
    output        wb_ack_o,
    output        wb_err_o,

    output  [COUNT-1:0] gpio_out,
    input   [COUNT-1:0] gpio_in,
    output  [COUNT-1:0] gpio_oe,
    output  [COUNT-1:0] gpio_ded
  );

  localparam NUM_REGS = (COUNT + 31) /32;

  wire [5:0] selected_reg = wb_adr_i[9:4];
  wire [1:0] selected_function = wb_adr_i[3:2];

  reg wb_ack_reg;
  assign wb_ack_o = wb_ack_reg;

  always @(posedge wb_clk_i) begin
    wb_ack_reg <= 1'b0;
    if (wb_rst_i) begin
    end else begin
      if (wb_stb_i && wb_cyc_i) begin
        wb_ack_reg <= 1'b1;
      end
    end
  end

  reg [31:0] wb_dat_o_reg;
  assign wb_dat_o = wb_dat_o_reg;

  reg [COUNT-1:0] gpio_in_reg;
  always @(posedge wb_clk_i) begin
    gpio_in_reg <= gpio_in;
  end

  wire [COUNT-1:0] gpio_in_val = (gpio_in_reg >> (32*selected_reg));

  reg [31:0] gpio_out_arr [0:NUM_REGS-1];
  reg [31:0] gpio_oe_arr  [0:NUM_REGS-1];
  reg [31:0] gpio_ded_arr [0:NUM_REGS-1];

  always @(*) begin
    case (selected_function)
      2'd0: wb_dat_o_reg <= gpio_in_val;
      2'd1: wb_dat_o_reg <= gpio_out_arr[selected_reg];
      2'd2: wb_dat_o_reg <= gpio_oe_arr[selected_reg];
      2'd3: wb_dat_o_reg <= gpio_ded_arr[selected_reg];
      default:
            wb_dat_o_reg <= 32'b0;
    endcase
  end

  always @(posedge wb_clk_i) begin
    if (wb_rst_i) begin
    end else begin
      if (wb_stb_i && wb_cyc_i && wb_we_i) begin
        case (selected_function)
          2'd1: gpio_out_arr[selected_reg] <= wb_dat_i;
          2'd2: gpio_oe_arr[selected_reg] <= wb_dat_i;
          2'd3: gpio_ded_arr[selected_reg] <= wb_dat_i;
        endcase
      end
    end
  end

  wire [NUM_REGS*32-1:0] gpio_out_int;
  wire [NUM_REGS*32-1:0] gpio_oe_int;
  wire [NUM_REGS*32-1:0] gpio_ded_int;
  
  genvar geni;
generate for (geni = 0; geni < NUM_REGS; geni = geni+1) begin : gen_arr_assign
  assign gpio_out_int[(geni+1)*32-1:geni*32] = gpio_out_arr[geni];
  assign gpio_oe_int[(geni+1)*32-1:geni*32] = gpio_oe_arr[geni];
  assign gpio_ded_int[(geni+1)*32-1:geni*32] = gpio_ded_arr[geni];
end endgenerate

  assign gpio_out = gpio_out_int[COUNT-1:0];
  assign gpio_oe  = gpio_oe_int[COUNT-1:0];
  assign gpio_ded = gpio_ded_int[COUNT-1:0];

endmodule

