module emac_mdio_wb (
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

    output        hostclk,
    output  [1:0] hostopcode,
    output        hostreq,
    output        hostmiimsel,
    output  [9:0] hostaddr, 
    output [31:0] hostwrdata,
    input  [31:0] hostrddata,
    input         hostmiimrdy,
    output        mdio_sel
  );

  localparam REG_MDIOSEL  = 0;
  localparam REG_OPISSUE  = 1;
  localparam REG_OPTYPE   = 2;
  localparam REG_OPADDR   = 3;
  localparam REG_OPDATA   = 4;
  localparam REG_OPRESULT = 5;
  localparam REG_DEBUG    = 6;
  localparam REG_DEBUG1   = 7;

  reg wb_ack_o_reg;

  always @(posedge wb_clk_i) begin
    wb_ack_o_reg <= 1'b0;
    if (wb_rst_i) begin
    end else begin
      if (wb_stb_i & wb_cyc_i)
        wb_ack_o_reg <= 1'b1;
    end
  end
  assign wb_ack_o = wb_ack_o_reg;

  reg        mdio_sel_reg;
  reg [15:0] op_addr;
  reg [31:0] op_data;
  reg        op_target;
  reg  [2:0] op_type;
  reg        op_issue;
  reg [31:0] op_result;
  reg [31:0] debug;
  reg [31:0] sDbgVal;

  always @(posedge wb_clk_i) begin
    op_issue <= 1'b0;
    if (wb_rst_i) begin
        mdio_sel_reg <= 1'b0;
        sDbgVal <= 32'h12345678;
    end else if (wb_cyc_i && wb_stb_i && !wb_ack_o_reg && wb_we_i) begin
      case (wb_adr_i[4:2])
        REG_MDIOSEL: begin
          mdio_sel_reg <= wb_dat_i[0];
        end
        REG_OPISSUE: begin
          op_issue <= wb_dat_i[0];
        end
        REG_OPTYPE: begin
          op_type <= wb_dat_i[2:0];
        end
        REG_OPADDR: begin
          op_addr <= wb_dat_i[15:0];
        end
        REG_OPDATA: begin
          op_data <= wb_dat_i[31:0];
        end
        REG_DEBUG1: begin
          sDbgVal <= wb_dat_i[31:0];
        end
      endcase
    end
  end
  assign mdio_sel = mdio_sel_reg;

  reg [31:0] wb_dat_o_reg;
  always @(*) begin
    case (wb_adr_i[4:2])
      REG_MDIOSEL: begin
        wb_dat_o_reg <= {31'b0, mdio_sel_reg};
      end
      REG_OPISSUE: begin
        wb_dat_o_reg <= {31'b0, 1'b1}; // The katcp read back must read '1' after a write of '1' - but the value is auto-cleared by gateware
      end
      REG_OPTYPE: begin
        wb_dat_o_reg <= {29'b0, op_type};
      end
      REG_OPADDR: begin
        wb_dat_o_reg <= {16'b0, op_addr};
      end
      REG_OPDATA: begin
        wb_dat_o_reg <= op_data;
      end
      REG_OPRESULT: begin
        wb_dat_o_reg <= op_result;
      end
      REG_DEBUG: begin
        wb_dat_o_reg <= debug;
      end
      REG_DEBUG1: begin
        wb_dat_o_reg <= sDbgVal;
      end
      default: begin
        wb_dat_o_reg <= 32'b0;
      end
    endcase
  end
  assign wb_dat_o = wb_dat_o_reg;

  /*************** MDIO op logic ********************/

  localparam S_IDLE    = 0;
  localparam S_CONFWR  = 1;
  localparam S_CONFRD0 = 2;
  localparam S_CONFRD1 = 3;
  localparam S_MDIO    = 4;

  wire is_conf_reg = op_type[0];
  wire is_conf_rd  = op_type[2];

  reg [2:0] state;

  reg hostreq_reg;

  reg [23:0] timeout;

  always @(posedge wb_clk_i) begin
    hostreq_reg  <= 1'b0;

    if (state != S_IDLE)
      timeout <= timeout + 24'b1;

    if (op_issue)
      timeout <= 0;

    if (timeout == {24{1'b1}}) begin
      state <= S_IDLE;
      debug[15:0] <= debug[15:0] + 16'd1;
    end

    debug[31:16] <= {13'b0, state};

    if (wb_rst_i) begin
      state <= S_IDLE;
      timeout <= 24'b0;
      debug <= 32'b0;
    end else begin
      case (state) 
        S_IDLE: begin
          if (op_issue) begin
            if (is_conf_reg && !is_conf_rd) begin
              state <= S_CONFWR;
            end 
            if (is_conf_reg && is_conf_rd) begin
              state <= S_CONFRD0;
            end 
            if (!is_conf_reg) begin
              state <= S_MDIO;
              hostreq_reg <= 1'b1;
            end 
          end
        end
        S_CONFWR: begin
          state <= S_IDLE;
        end
        S_CONFRD0: begin
          state <= S_CONFRD1;
        end
        S_CONFRD1: begin
          state <= S_IDLE;
        end
        S_MDIO: begin
          if (!hostreq_reg && hostmiimrdy) begin
            state <= S_IDLE;
          end
        end
      endcase
    end
  end
  
  always @(posedge wb_clk_i) begin
    if ((state == S_MDIO && hostmiimrdy) ||
        (state == S_CONFRD1)) begin
      op_result <= hostrddata;
    end
  end

  assign hostclk     = wb_clk_i;
  assign hostreq     = hostreq_reg;
  assign hostmiimsel = !(state == S_CONFWR || state == S_CONFRD0 || state == S_CONFRD1);
  /* always set the top bit to enable config access, bit unused for mdio */
  assign hostaddr    = is_conf_reg ? {1'b1, op_addr[8:0]} : {op_addr[12:8], op_addr[4:0]};
  assign hostwrdata  = op_data;
  assign hostopcode  = op_type[2:1];

endmodule

