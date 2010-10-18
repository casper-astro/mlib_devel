`timescale 1ns/10ps

`define SIMLENGTH 400000
`define SYS_CLK_PERIOD 4

module TB_opb_katadccontroller();

  wire sys_rst;
  wire sys_clk;

  /***************** DUT ***************/
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

	wire        adc0_adc3wire_clk;
	wire        adc0_adc3wire_data;
	wire        adc0_adc3wire_strobe;
	wire        adc0_adc_reset;
	wire        adc0_dcm_reset;
  wire        adc0_psclk;
  wire        adc0_psen;
  wire        adc0_psincdec;
  wire        adc0_psdone;
  wire        adc0_clk;

	wire        adc1_adc3wire_clk;
	wire        adc1_adc3wire_data;
	wire        adc1_adc3wire_strobe;
	wire        adc1_adc_reset;
	wire        adc1_dcm_reset;
  wire        adc1_psclk;
  wire        adc1_psen;
  wire        adc1_psincdec;
  wire        adc1_psdone;
  wire        adc1_clk;

  opb_katadccontroller opb_katadccontroller_inst(
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
	  .adc0_adc3wire_clk(adc0_adc3wire_clk),
	  .adc0_adc3wire_data(adc0_adc3wire_data),
	  .adc0_adc3wire_strobe(adc0_adc3wire_strobe),
	  .adc0_adc_reset(adc0_adc_reset),
	  .adc0_dcm_reset(adc0_dcm_reset),
    .adc0_psclk(adc0_psclk),
    .adc0_psen(adc0_psen),
    .adc0_psincdec(adc0_psincdec),
    .adc0_psdone(adc0_psdone),
    .adc0_clk(adc0_clk),
	  .adc1_adc3wire_clk(adc1_adc3wire_clk),
	  .adc1_adc3wire_data(adc1_adc3wire_data),
	  .adc1_adc3wire_strobe(adc1_adc3wire_strobe),
	  .adc1_adc_reset(adc1_adc_reset),
	  .adc1_dcm_reset(adc1_dcm_reset),
    .adc1_psclk(adc1_psclk),
    .adc1_psen(adc1_psen),
    .adc1_psincdec(adc1_psincdec),
    .adc1_psdone(adc1_psdone),
    .adc1_clk(adc1_clk)
  );

  /****** System Signal generations ******/
  reg [31:0] sys_clk_counter;

  reg arm;

  reg reset;
  assign sys_rst = reset;

  initial begin
    $dumpvars;
    sys_clk_counter <= 32'b0;
    arm <= 1'b0;

    reset <= 1'b1;
    #20
    reset <= 1'b0;
`ifdef DEBUG
    $display("sys: reset cleared");
`endif
    #`SIMLENGTH
    $display("FAILED: system timeout");
    $finish;
  end

  assign sys_clk = sys_clk_counter < ((`SYS_CLK_PERIOD) / 2);

  always begin
    #1 sys_clk_counter <= (sys_clk_counter == `SYS_CLK_PERIOD - 1 ? 32'b0 : sys_clk_counter + 1);
  end

  assign OPB_Clk = sys_clk;
  assign OPB_Rst = sys_rst;

  reg [31:0] opb_data;
  reg  [3:0] opb_be;
  reg        opb_select;
  reg [31:0] opb_addr;
  reg        opb_rnw;

  reg [31:0] progress;

  always @(posedge sys_clk) begin
    if (sys_rst) begin
      progress   <= 32'b0;
      opb_select <= 0;
    end else begin
      case (progress)
        0: begin
          opb_data <= 32'b11;
          opb_rnw  <= 1;
          opb_addr <= 4;
          opb_be   <= 4'b0001;
          opb_select <= 1'b1;
          progress <= 1;
        end
        1: begin
          if (Sl_xferAck) begin
            if (Sl_DBus[27]) begin
              progress <= 0;
              opb_select <= 1'b0;
            end else begin
              opb_data <= 32'b11;
              opb_rnw  <= 0;
              opb_addr <= 0;
              opb_be   <= 4'b0001;
              opb_select <= 1'b1;
              progress <= 2;
              arm <= 1'b1;
            end
          end
        end
        2: begin
          if (Sl_xferAck) begin
            opb_data <= {16'hdead, 4'b0, 4'h9, 8'b1};
            opb_addr <= 4;
            opb_be   <= 4'b1111;
            opb_rnw  <= 0;
            opb_select <= 1'b1;
            progress <= 3;
          end
        end
        3: begin
          if (Sl_xferAck) begin
            opb_data <= {16'hbeef, 4'b0, 4'h8, 8'b1};
            opb_addr <= 8;
            opb_be   <= 4'b1111;
            opb_rnw  <= 0;
            opb_select <= 1'b1;
            progress <= 4;
          end
        end
        4: begin
          if (Sl_xferAck) begin
            opb_select <= 1'b0;
          end
        end
      endcase
    end
  end 

  assign OPB_ABus   = opb_addr;
  assign OPB_BE     = opb_be;
  assign OPB_DBus   = opb_data;
  assign OPB_RNW    = opb_rnw;
  assign OPB_select = opb_select;

  reg [4:0] config0_cntr;
  initial begin
    config0_cntr <= 0;
  end

  reg[31:0] config0_data;

  always @(posedge adc0_adc3wire_clk) begin
    if (sys_rst || !arm) begin
    end else begin
      if (adc0_adc3wire_strobe === 0) begin
        config0_data[31-config0_cntr] <= adc0_adc3wire_data;
        config0_cntr <= config0_cntr + 1;
        if (config0_cntr == 31) begin
          #10
          $display("adc0_conf: %x", config0_data);
          if (config0_data === {12'b1, 4'h9, 16'hdead}) begin
          end else begin
            $display("FAILED: adc0 mismatch - got = %x, expected = %x", config0_data, {12'b1, 4'h9, 16'hdead});
            $finish;
          end
        end
      end
    end
  end

  reg [4:0] config1_cntr;
  initial begin
    config1_cntr <= 0;
    config1_data <= 0;
  end

  reg[31:0] config1_data;

  always @(posedge adc1_adc3wire_clk) begin
    if (sys_rst || !arm) begin
    end else begin
      if (adc1_adc3wire_strobe === 0) begin
        config1_data[31 - config1_cntr] <= adc1_adc3wire_data;
        config1_cntr <= config1_cntr + 1;
        if (config1_cntr == 31) begin
          #20
          $display("adc1_conf: %x", config1_data);
          if (config1_data === {12'b1, 4'h8, 16'hbeef}) begin
            $display("PASSED");
          end else begin
            $display("FAILED: adc1 mismatch - got = %x, expected = %x", config1_data, {12'b1, 4'h8, 16'hbeef});
          end
          $finish;
        end
      end
    end
  end

  
endmodule
