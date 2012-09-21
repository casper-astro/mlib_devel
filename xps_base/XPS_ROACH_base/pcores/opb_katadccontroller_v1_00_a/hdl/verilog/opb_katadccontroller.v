`timescale 1ns/10ps

module opb_katadccontroller(
    input         OPB_Clk,
    input         OPB_Rst,
    output [0:31] Sl_DBus,
    output        Sl_errAck,
    output        Sl_retry,
    output        Sl_toutSup,
    output        Sl_xferAck,
    input  [0:31] OPB_ABus,
    input  [0:3]  OPB_BE,
    input  [0:31] OPB_DBus,
    input         OPB_RNW,
    input         OPB_select,
    input         OPB_seqAddr,

	  output        adc0_adc3wire_clk,
	  output        adc0_adc3wire_data,
	  output        adc0_adc3wire_strobe,
	  output        adc0_adc_reset,
	  output        adc0_dcm_reset,
    output        adc0_psclk,
    output        adc0_psen,
    output        adc0_psincdec,
    input         adc0_psdone,
    input         adc0_clk,

	  output        adc1_adc3wire_clk,
	  output        adc1_adc3wire_data,
	  output        adc1_adc3wire_strobe,
	  output        adc1_adc_reset,
	  output        adc1_dcm_reset,
    output        adc1_psclk,
    output        adc1_psen,
    output        adc1_psincdec,
    input         adc1_psdone,
    input         adc1_clk
  );
  parameter C_BASEADDR    = 32'h00000000;
  parameter C_HIGHADDR    = 32'h0000FFFF;
  parameter C_OPB_AWIDTH  = 32;
  parameter C_OPB_DWIDTH  = 32;
  parameter C_FAMILY      = "";

  parameter INTERLEAVED_0 = 0;
  parameter INTERLEAVED_1 = 0;
  parameter AUTOCONFIG_0  = 1;
  parameter AUTOCONFIG_1  = 1;

  /********* Global Signals *************/
  wire [15:0] adc0_config_data;
  wire  [3:0] adc0_config_addr;
  wire        adc0_config_start;
  wire        adc0_config_idle;
  wire        adc0_config_done;

  wire [15:0] adc1_config_data;
  wire  [3:0] adc1_config_addr;
  wire        adc1_config_start;
  wire        adc1_config_idle;
  wire        adc1_config_done;

  wire        adc0_reset;
  wire        adc1_reset;

  /**** CPU Attachment ********/
  wire [15:0] adc0_config_data_cpu;
  wire  [3:0] adc0_config_addr_cpu;
  wire        adc0_config_start_cpu;

  wire [15:0] adc1_config_data_cpu;
  wire  [3:0] adc1_config_addr_cpu;
  wire        adc1_config_start_cpu;

  wire auto_busy_0;
  wire auto_busy_1;

  opb_attach #(
    .C_BASEADDR   (C_BASEADDR),
    .C_HIGHADDR   (C_HIGHADDR),
    .C_OPB_AWIDTH (C_OPB_AWIDTH),
    .C_OPB_DWIDTH (C_OPB_DWIDTH)
  ) opb_attach_inst (
    .OPB_Clk           (OPB_Clk),
    .OPB_Rst           (OPB_Rst),
    .Sl_DBus           (Sl_DBus),
    .Sl_errAck         (Sl_errAck),
    .Sl_retry          (Sl_retry),
    .Sl_toutSup        (Sl_toutSup),
    .Sl_xferAck        (Sl_xferAck),
    .OPB_ABus          (OPB_ABus),
    .OPB_BE            (OPB_BE),
    .OPB_DBus          (OPB_DBus),
    .OPB_RNW           (OPB_RNW),
    .OPB_select        (OPB_select),
    .OPB_seqAddr       (OPB_seqAddr),
    .adc0_reset        (adc0_reset),
    .adc1_reset        (adc1_reset),
    .adc0_psen         (adc0_psen),
    .adc0_psincdec     (adc0_psincdec),
    .adc0_psclk        (adc0_psclk),
    .adc0_psdone       (adc0_psdone),
    .adc1_psen         (adc1_psen),
    .adc1_psincdec     (adc1_psincdec),
    .adc1_psclk        (adc1_psclk),
    .adc1_psdone       (adc1_psdone),
    .adc0_config_data  (adc0_config_data_cpu),
    .adc0_config_addr  (adc0_config_addr_cpu),
    .adc0_config_start (adc0_config_start_cpu),
    .adc0_config_idle  (adc0_config_idle),
    .adc1_config_data  (adc1_config_data_cpu),
    .adc1_config_addr  (adc1_config_addr_cpu),
    .adc1_config_start (adc1_config_start_cpu),
    .adc1_config_idle  (adc1_config_idle),
    .auto_busy_0       (auto_busy_0),
    .auto_busy_1       (auto_busy_1)

  );

  /********* ADC0 configuration state machine *********/

  serial_config serial_config_adc0 (
    .clk             (OPB_Clk),
    .rst             (OPB_Rst),
    .config_data     (adc0_config_data),
    .config_addr     (adc0_config_addr),
    .config_start    (adc0_config_start),
    .config_idle     (adc0_config_idle),
    .config_done     (adc0_config_done),
    .adc3wire_clk    (adc0_adc3wire_clk),
    .adc3wire_data   (adc0_adc3wire_data),
    .adc3wire_strobe (adc0_adc3wire_strobe)
    
  );

  /********* ADC1 configuration state machine *********/

  serial_config serial_config_adc1 (
    .clk             (OPB_Clk),
    .rst             (OPB_Rst),
    .config_data     (adc1_config_data),
    .config_addr     (adc1_config_addr),
    .config_start    (adc1_config_start),
    .config_idle     (adc1_config_idle),
    .config_done     (adc1_config_done),
    .adc3wire_clk    (adc1_adc3wire_clk),
    .adc3wire_data   (adc1_adc3wire_data),
    .adc3wire_strobe (adc1_adc3wire_strobe)
    
  );

  /*************** AUTOMAGIC CONFIGURATION *****************/

  wire [15:0] adc0_config_data_auto;
  wire  [3:0] adc0_config_addr_auto;
  wire        adc0_config_start_auto;

  assign adc0_config_data  = auto_busy_0 ? adc0_config_data_auto  : adc0_config_data_cpu;
  assign adc0_config_addr  = auto_busy_0 ? adc0_config_addr_auto  : adc0_config_addr_cpu;
  assign adc0_config_start = auto_busy_0 ? adc0_config_start_auto : adc0_config_start_cpu;

  autoconfig #(
    .INTERLEAVED (INTERLEAVED_0),
    .ENABLE      (AUTOCONFIG_0)
  ) autoconfig_adc0 (
    .clk          (OPB_Clk),
    .rst          (OPB_Rst),
    .busy         (auto_busy_0),
    .config_data  (adc0_config_data_auto),
    .config_addr  (adc0_config_addr_auto),
    .config_start (adc0_config_start_auto),
    .config_done  (adc0_config_done)
  );

  wire [15:0] adc1_config_data_auto;
  wire  [3:0] adc1_config_addr_auto;
  wire        adc1_config_start_auto;
  assign adc1_config_data  = auto_busy_1 ? adc1_config_data_auto  : adc1_config_data_cpu;
  assign adc1_config_addr  = auto_busy_1 ? adc1_config_addr_auto  : adc1_config_addr_cpu;
  assign adc1_config_start = auto_busy_1 ? adc1_config_start_auto : adc1_config_start_cpu;

  autoconfig #(
    .INTERLEAVED (INTERLEAVED_1),
    .ENABLE      (AUTOCONFIG_1)
  ) autoconfig_adc1 (
    .clk          (OPB_Clk),
    .rst          (OPB_Rst),
    .busy         (auto_busy_1),
    .config_data  (adc1_config_data_auto),
    .config_addr  (adc1_config_addr_auto),
    .config_start (adc1_config_start_auto),
    .config_done  (adc1_config_done)
  );


  /********* DCM Reset Gen *********/

  reg [7:0] adc0_reset_counter;
  reg [7:0] adc1_reset_counter;

  reg adc0_reset_iob;
  reg adc1_reset_iob;
  // synthesis attribute IOB of adc0_reset_iob is TRUE
  // synthesis attribute IOB of adc1_reset_iob is TRUE

  always @(posedge OPB_Clk) begin

    if (OPB_Rst) begin
      adc0_reset_counter <= {8{1'b1}};
      adc1_reset_counter <= {8{1'b1}};
      adc0_reset_iob <= 1'b1;
      adc1_reset_iob <= 1'b1;
    end else begin
      adc0_reset_iob <= adc0_reset;
      adc1_reset_iob <= adc1_reset;
      if (adc0_reset_counter) begin
        adc0_reset_counter <= adc0_reset_counter - 1;
      end
      if (adc1_reset_counter) begin
        adc1_reset_counter <= adc1_reset_counter - 1;
      end
      if (adc0_reset || auto_busy_0) begin
        adc0_reset_counter <= {8{1'b1}};
      end
      if (adc1_reset || auto_busy_1) begin
        adc1_reset_counter <= {8{1'b1}};
      end
    end
  end

  assign adc0_dcm_reset = adc0_reset_counter != 0;
  assign adc1_dcm_reset = adc1_reset_counter != 0;
  assign adc0_adc_reset = adc0_reset_iob;
  assign adc1_adc_reset = adc1_reset_iob;

endmodule
