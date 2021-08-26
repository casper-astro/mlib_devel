module ads5296x4_interface_demux2 #(
    parameter G_NUM_UNITS = 4,          // Number of ADC chips. Only tested for 4
    parameter G_NUM_FCLKS = 4,          // Number of FCLKs routed to this interface
    parameter G_FCLK_MASTER = 0,        // Index of the FCLK vector to use for clock generation
    parameter G_IS_MASTER = 1'b1,       // If 1, generate output clocks in this core
    parameter G_SNAPSHOT_ADDR_BITS = 9, // log2 ADC sample snapshot depth
    parameter G_VERSION = 1             // Interface revision. Used only for runtime readback
 )(
    // Control signals from Simulink
    input rst,
    input sync,
    // Line clocks
    input lclk_p,
    input lclk_n,
    // Frame clocks
    input [G_NUM_FCLKS - 1 : 0] fclk_p,
    input [G_NUM_FCLKS - 1 : 0] fclk_n,
    // Clocks
    input sclk2_in, // Sample clock x2 (i.e. interleaved sample clock)
    input sclk_in,  // Sample clock (per ADC lane)
    input sclk5_in, // Sample clock x5 (i.e. bit clock)
    // Data inputs
    input [4*2*G_NUM_UNITS - 1:0] din_p,
    input [4*2*G_NUM_UNITS - 1:0] din_n,
    // Deserialized outputs
    output [10*4*G_NUM_UNITS - 1:0] dout,
    // Generate these clocks if G_IS_MASTER=1; otherwise tie to 0
    output sclk2_out, // Sample clock x2 (i.e. interleaved sample clock)
    output sclk_out,  // Sample clock (per ADC lane)
    output sclk5_out, // Sample clock x5 (i.e. bit clock)
    output sync_out,     // To Simulink
    output ext_sync_out, // To ADC pin
    
    // Pre-buffered Frame clock inputs. Software control allows either of 
    // these to be used to generate sclk*_out if G_IS_MASTER=1
    input  [1:0] fclk_in,
    // Frame clock output. Buffered fclk_p/n[G_FCLK_MASTER]
    output fclk_out,

    // Software register interface
   
    // external snapshot control
    
    input         snapshot_ext_trigger,
    output        snapshot_we,
    output [G_SNAPSHOT_ADDR_BITS-1:0] snapshot_addr,

    // Wishbone interface
    input         wb_clk_i,
    input         wb_rst_i,
    output [31:0] wb_dat_o,
    output        wb_err_o,
    output        wb_ack_o,
    input  [31:0] wb_adr_i,
    input  [3:0]  wb_sel_i,
    input  [31:0] wb_dat_i,
    input         wb_we_i,
    input         wb_cyc_i,
    input         wb_stb_i
  );

  (* mark_debug = "true" *) wire [4*2*G_NUM_UNITS - 1 + 2: 0]  delay_load;
  (* mark_debug = "true" *) wire [4*2*G_NUM_UNITS - 1 + 2: 0]  delay_rst;
  (* mark_debug = "true" *) wire [4*2*G_NUM_UNITS - 1 + 2: 0] delay_en_vtc;
  (* mark_debug = "true" *) wire [8 : 0] delay_val;

  // Clocks
  wire lclk_int; // lclk single ended unbuffered
  wire [4 - 1 : 0] fclk_int;     // fclk signal single ended
  wire fclk;     // FCLK buffered
  wire lclk;     // lclk buffered

  wire [31:0] fclk_err_cnt;
  wire iserdes_rst_wb;
  wire mmcm_rst;
  wire mmcm_locked;
  wire mmcm_clksel;
  reg [31:0] fclk0_ctr;
  reg [31:0] fclk1_ctr;
  reg [31:0] fclk2_ctr;
  reg [31:0] fclk3_ctr;
  reg [31:0] lclk_ctr;
  wire [4*G_NUM_UNITS - 1 : 0] bitslip;
  wire [2:0] slip_index;
  wire snapshot_trigger;
  wire wb_user_clk;
  wb_ads5296_attach #( 
    .G_NUM_UNITS(G_NUM_UNITS),
    .G_IS_MASTER(G_IS_MASTER),
    .G_NUM_FCLKS(1), // Only bother controlling 1 fclk
    .G_VERSION(G_VERSION)
  ) wb_ads5296_attach_inst (
    .wb_clk_i(wb_clk_i),
    .wb_rst_i(wb_rst_i),
    .wb_dat_o(wb_dat_o),
    .wb_err_o(wb_err_o),
    .wb_ack_o(wb_ack_o),
    .wb_adr_i(wb_adr_i),
    .wb_sel_i(wb_sel_i),
    .wb_dat_i(wb_dat_i),
    .wb_we_i(wb_we_i),
    .wb_cyc_i(wb_cyc_i),
    .wb_stb_i(wb_stb_i),
    //.user_clk(wb_user_clk),
    .lclk_cnt(lclk_ctr),
    .fclk0_cnt(fclk0_ctr),
    .fclk1_cnt(fclk1_ctr),
    .fclk2_cnt(fclk2_ctr),
    .fclk3_cnt(fclk3_ctr),
    .bitslip(bitslip),
    .slip_index(slip_index),
    .fclk_err_cnt(fclk_err_cnt),
    .delay_load(delay_load),
    .delay_rst(delay_rst),
    .delay_en_vtc(delay_en_vtc),
    .delay_val(delay_val),
    .iserdes_rst(iserdes_rst_wb),
    .mmcm_rst(mmcm_rst),
    .mmcm_locked(mmcm_locked),
    .mmcm_clksel(mmcm_clksel),
    .snapshot_trigger(snapshot_trigger)
  );

  (* async_reg = "true" *) reg snapshot_trigger_unstable;
  (* async_reg = "true" *) reg snapshot_trigger_stable;
  reg snapshot_trigger_stableR;
  wire snapshot_trigger_pulse = snapshot_trigger_stable & ~snapshot_trigger_stableR;
  reg snapshot_ext_triggerR;
  wire snapshot_ext_trigger_pulse = snapshot_ext_trigger & ~snapshot_ext_triggerR;
  reg [G_SNAPSHOT_ADDR_BITS-1:0] snapshot_addr_reg;
  assign snapshot_addr = snapshot_addr_reg;
  reg snapshot_we_reg;
  assign snapshot_we = snapshot_we_reg;
  reg snapshot_pending = 1'b0;
  always @(posedge sclk2_in) begin
    snapshot_addr_reg <= snapshot_addr_reg + 1'b1;
    snapshot_trigger_unstable <= snapshot_trigger;
    snapshot_trigger_stable <= snapshot_trigger_unstable;
    snapshot_trigger_stableR <= snapshot_trigger_stable;
    snapshot_ext_triggerR <= snapshot_ext_trigger;
    if (snapshot_trigger_pulse || snapshot_ext_trigger_pulse) begin
      snapshot_pending <= 1'b1;
    end
    if (&snapshot_addr_reg) begin
      snapshot_we_reg <= 1'b0;
    end
    if (snapshot_pending && sync_out) begin
      snapshot_we_reg <= 1'b1;
      snapshot_addr_reg <= {G_SNAPSHOT_ADDR_BITS{1'b0}};
      snapshot_pending <= 1'b0;
    end
  end
    
    

  // Buffer the differential inputs
  wire [4*2*G_NUM_UNITS - 1:0] din;
  wire [4*4*2*G_NUM_UNITS - 1:0] din4b;
  wire [8*4*2*G_NUM_UNITS - 1:0] din8b;
  (* mark_debug = "true" *) wire [3:0] fclk4b;

  IBUFDS fclk_ibuf [G_NUM_FCLKS - 1 : 0] (
    .I(fclk_p),
    .IB(fclk_n),
    .O(fclk_int[G_NUM_FCLKS - 1 : 0])
  );
  
  assign fclk_int[3 : G_NUM_FCLKS] = {(4-G_NUM_FCLKS){1'b0}};
   
  IBUFDS lclk_ibuf (
    .I(lclk_p),
    .IB(lclk_n),
    .O(lclk_int)
  );

  BUFG lclk_buf (
    .I(lclk_int),
    .O(lclk)
  );

  IBUFDS din_buf[4*2*G_NUM_UNITS - 1:0] (
    .I(din_p),
    .IB(din_n),
    .O(din)
  );
  
 // assign fclk_out = fclk_int[G_FCLK_MASTER];
  //assign fclk = fclk_in;
  BUFG fclk_buf (
    .I(fclk_int[G_FCLK_MASTER]),
    .O(fclk)
    //.O(fclk_out)
  );
  assign fclk_out = fclk;
  wire [3:0] fclk_reordered;

  // Generate clocks at rate
  // FCLK   (The rate at which samples are clocked into the FIFO)
  // 2*FCLK (Two ADC lanes interleaved -- the rate at which samples are clocked out of the FIFO)
  // 5*FCLK (The (DDR) bit clock
  
    wire sclk_mmcm;
    wire sclk_fb_mmcm;
    wire sclk_fb;
    wire sclk;
    wire sclk2_mmcm;
    wire sclk2;
    wire sclk5_mmcm;
    wire sclk5;
  generate
  if (G_IS_MASTER) begin
    /*
    reg mmcm_rstR;
    reg mmcm_rstRR;
    wire mcmm_rst_strobe = mmcm_rstR & ~mmcm_rstRR;
    
    always @(posedge fclk) begin
      mmcm_rstR <= mmcm_rst;
      mmcm_rstRR <= mmcm_rstR;
    end
    */
    
    //MMCME3_BASE #(
    MMCME3_ADV #(
      .BANDWIDTH("OPTIMIZED"),
      .DIVCLK_DIVIDE(2),
      .CLKFBOUT_MULT_F(20.000),
      .CLKOUT0_DIVIDE_F(10.0),
      .CLKOUT1_DIVIDE(5),
      //.CLKOUT0_PHASE(36), // Advance 1 bit time (empirically determined)
      //.CLKOUT1_PHASE(72), // Advance 1
      //.CLKOUT2_PHASE(180), // Advance 1
      .CLKOUT2_DIVIDE(2),
      .CLKIN1_PERIOD(10.000)
    ) mmcm_inst (
      .CLKIN1(fclk_in[1]),   // 2.5 fs
      .CLKIN2(fclk_in[0]),
      .CLKINSEL(mmcm_clksel), // mmcm_clksel=0 => use CLK2
      .RST(mmcm_rst),
      .CLKOUT0(sclk_mmcm),  // fs
      .CLKOUT1(sclk2_mmcm),
      .CLKOUT2(sclk5_mmcm),
      .CLKFBOUT(sclk_fb_mmcm),
      .CLKFBIN(sclk_fb),
      .LOCKED(mmcm_locked),
      .PWRDWN(1'b0)
    );

  BUFG clk_out_buf[3:0] (
    .I({sclk_mmcm, sclk2_mmcm, sclk5_mmcm, sclk_fb_mmcm}),
    .O({sclk, sclk2, sclk5, sclk_fb})
  );
  
    assign sclk_out = sclk;
    assign sclk2_out = sclk2;
    assign sclk5_out = sclk5;
  end else begin
    assign sclk2_out = 1'b0;
    assign sclk_out = 1'b0;
    assign sclk5_out = 1'b0;
  end
  endgenerate
 
  assign wb_user_clk = sclk_in;

  /*
   * To update:
   *   Wait for RDY to go high
   *   Write EN_VTC low
   *   Wait > 10 cycles
   *   write value to CNTVALUEIN
   *   wait 1 clock
   *   pulse LOAD high for 1 cycle
   */

  wire delay_clk = wb_clk_i;

  (* async_reg = "true" *) reg [4*2*G_NUM_UNITS + 2 - 1: 0] delay_loadR;
  (* async_reg = "true" *) reg [4*2*G_NUM_UNITS + 2 - 1: 0] delay_loadRR;
  (* async_reg = "true" *) reg [4*2*G_NUM_UNITS + 2 - 1: 0] delay_loadRRR;

  wire [4*2*G_NUM_UNITS + 2 - 1: 0] delay_load_strobe = delay_loadRR & ~delay_loadRRR;
  always @(posedge sclk_in) begin
    delay_loadR <= delay_load;
    delay_loadRR <= delay_loadR;
    delay_loadRRR <= delay_loadRR;
  end

  wire [4*2*G_NUM_UNITS - 1:0] din_delayed;
  wire fclk_delayed;
  
  wire delay_master_rst = delay_rst[32];
  reg delay_master_rstR;
  wire delay_master_rst_trig = delay_master_rst & ~delay_master_rstR;
  reg [31:0] idelay_ctrl_rst_sr = 32'b0;
  reg [31:0] idelay_rst_sr = 32'b0;
  reg [31:0] iserdes_rst_sr = 32'b0;
  (* mark_debug = "true" *) wire idelay_ctrl_rst = idelay_ctrl_rst_sr != 32'b0;
  (* mark_debug = "true" *) wire idelay_rst = idelay_rst_sr != 32'b0;
  (* mark_debug = "true" *) wire iserdes_rst = iserdes_rst_sr != 32'b0;
  (* mark_debug = "true" *) wire idelay_rdy;
  always @(posedge sclk_in) begin
    delay_master_rstR <= delay_master_rst;
    idelay_rst_sr <= {idelay_rst_sr[31:1], delay_master_rst_trig};
    iserdes_rst_sr <= {iserdes_rst_sr[31:0], idelay_rst};
    idelay_ctrl_rst_sr <= {idelay_ctrl_rst_sr[31:0], iserdes_rst};
  end
  

  wire [4*2*G_NUM_UNITS - 1:0] delay_casc_out;
  wire [4*2*G_NUM_UNITS - 1:0] delay_casc_return;
  IDELAYE3 #(
    .DELAY_TYPE("VAR_LOAD"),
    .DELAY_FORMAT("COUNT"),//("TIME"),
    .UPDATE_MODE("ASYNC"),
    .DELAY_SRC("IDATAIN"),
    //.DELAY_VALUE(1100),
    .CASCADE("MASTER"),
    .SIM_DEVICE("ULTRASCALE"),
    .REFCLK_FREQUENCY(200.0)
  ) idelay_in [ 4*2*G_NUM_UNITS - 1: 0] (
    .CLK     (sclk_in), // Not using CLKDIV in an ISERDES, so what are the rules here?
    .LOAD    (delay_load_strobe[ 4*2*G_NUM_UNITS - 1: 0]),
    .DATAIN  (1'b0),
    .IDATAIN (din),
    .CNTVALUEIN(delay_val),
    .CNTVALUEOUT(),
    .INC     (1'b0),
    .CE      (1'b0),
    .RST     (idelay_rst),
    .DATAOUT (din_delayed),
    .EN_VTC(1'b0),//(delay_en_vtc),
    .CASC_IN(),
    .CASC_OUT(delay_casc_out),
    .CASC_RETURN(delay_casc_return)
  );

  ODELAYE3 #(
    .DELAY_TYPE("VAR_LOAD"),
    .DELAY_FORMAT("COUNT"),//("TIME"),
    .UPDATE_MODE("ASYNC"),
    //.DELAY_VALUE(1100),
    .CASCADE("SLAVE_END"),
    .SIM_DEVICE("ULTRASCALE"),
    .REFCLK_FREQUENCY(200.0)
  ) odelay_in [ 4*2*G_NUM_UNITS - 1: 0] (
    .CLK     (sclk_in), // Not using CLKDIV in an ISERDES, so what are the rules here?
    .LOAD    (delay_load_strobe[ 4*2*G_NUM_UNITS - 1: 0]),
    .ODATAIN (),
    .CNTVALUEIN(delay_val),
    .CNTVALUEOUT(),
    .INC     (1'b0),
    .CE      (1'b0),
    .RST     (idelay_rst),
    .DATAOUT (delay_casc_return),
    .EN_VTC(1'b0),//(delay_en_vtc),
    .CASC_IN(delay_casc_out),
    .CASC_OUT(),
    .CASC_RETURN()
  );
  
  // Use the buffered FCLK signal for the counter driver. This just seems like good form.
  wire [3:0] fclk_ctr_clk;
  assign fclk_ctr_clk[0] = G_FCLK_MASTER==0 ? fclk : fclk_int[0];
  assign fclk_ctr_clk[1] = G_FCLK_MASTER==1 ? fclk : fclk_int[1];
  assign fclk_ctr_clk[2] = G_FCLK_MASTER==2 ? fclk : fclk_int[2];
  assign fclk_ctr_clk[3] = G_FCLK_MASTER==3 ? fclk : fclk_int[3];

  always @(posedge fclk_ctr_clk[0]) begin
    fclk0_ctr <= fclk0_ctr + 1'b1;
  end
  always @(posedge fclk_ctr_clk[1]) begin
    fclk1_ctr <= fclk1_ctr + 1'b1;
  end
  always @(posedge fclk_ctr_clk[2]) begin
    fclk2_ctr <= fclk2_ctr + 1'b1;
  end
  always @(posedge fclk_ctr_clk[3]) begin
    fclk3_ctr <= fclk3_ctr + 1'b1;
  end
  always @(posedge lclk) begin
    lclk_ctr <= lclk_ctr + 1'b1;
  end

  wire [4*2*G_NUM_UNITS - 1:0] din_rise;
  wire [4*2*G_NUM_UNITS - 1:0] din_fall;
  IDDRE1 #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED")
  ) data_iddr_inst [4*2*G_NUM_UNITS - 1 : 0] (
    .C(sclk5_in),
    .CB(~sclk5_in),
    .D(din_delayed),
    .R(1'b0),
    .Q1(din_rise),
    .Q2(din_fall)
  );

  wire [4*G_NUM_UNITS - 1 : 0] sync_out_multi;
  assign sync_out = sync_out_multi[0];
  wire fifo_we;
  wire fifo_re;
  wire fifo_rst;
  
  ads5296_unit adc_unit_inst[4*G_NUM_UNITS - 1:0] (
    .lclk(sclk5_in),
    .clk_in(sclk_in),
    .din_rise(din_rise),
    .din_fall(din_fall),
    .bitslip(bitslip),
    .slip_index(slip_index),
    .wr_en(fifo_we),
    .rst(fifo_rst),
    .clk_out(sclk2_in),
    .rd_en(fifo_re),
    .dout(dout),
    .sync_out(sync_out_multi)
  );
  

  // Generate FIFO control signals from sclk, to guard
  // against phase ambiguities
  reg syncR_sclk;
  reg syncRR_sclk;
  reg fifo_we_reg;
  reg fifo_rst_reg;
  (* max_fanout = 4 *) reg fifo_rst_regR;
  assign fifo_rst = fifo_rst_regR;
  assign fifo_we = fifo_we_reg;
  always @(posedge sclk_in) begin
    syncR_sclk <= sync;
    syncRR_sclk <= syncR_sclk;
    fifo_rst_regR <= fifo_rst_reg;
    if (rst) begin
      fifo_we_reg <= 1'b0;
      fifo_rst_reg <= 1'b1;
    end else begin
      fifo_rst_reg <= 1'b0;
      if (syncR_sclk & ~syncRR_sclk) begin
        fifo_we_reg <= 1'b1;
      end
    end
  end

  reg [10:0] fifo_re_sr;
  reg fifo_re_reg;
  assign fifo_re = fifo_re_sr[10];
  always @(posedge sclk2_in) begin
    if (rst) begin
      fifo_re_sr <= 11'b0;
    end else if ( ~fifo_re ) begin
      fifo_re_sr <= {fifo_re_sr[9:0], fifo_we_reg};
    end
  end

  generate
  if (G_IS_MASTER) begin
    // Sync output delay
    wire sync_out_delay_load = delay_load[4*2*G_NUM_UNITS + 2 - 1];
    (* async_reg = "true" *) reg sync_out_delay_loadR;
    (* async_reg = "true" *) reg sync_out_delay_loadRR;
    reg sync_out_delay_loadRRR;
    wire sync_out_delay_load_strobe = sync_out_delay_loadRR & ~sync_out_delay_loadRRR;
    (* async_reg = "true" *) reg sync_out_delay_rstR;
    (* async_reg = "true" *) reg sync_out_delay_rstRR;
    always @(posedge sclk_in) begin
      sync_out_delay_loadR <= sync_out_delay_load;
      sync_out_delay_loadRR <= sync_out_delay_loadR;
      sync_out_delay_loadRRR <= sync_out_delay_loadRR;
      sync_out_delay_rstR <= delay_rst[4*2*G_NUM_UNITS + 2 - 1];
      sync_out_delay_rstRR <= sync_out_delay_rstR;
    end
    ODELAYE3 #(
      .DELAY_TYPE("VAR_LOAD"),
      .DELAY_FORMAT("COUNT"),//("TIME"),
      .UPDATE_MODE("ASYNC"),
      //.DELAY_VALUE(1100),
      .CASCADE("NONE"),
      .SIM_DEVICE("ULTRASCALE"),
      .REFCLK_FREQUENCY(200.0)
    ) odelay_in (
      .CLK     (sclk2_in), // Not using CLKDIV in an ISERDES, so what are the rules here?
      .LOAD    (sync_out_delay_load_strobe),
      .ODATAIN (sync),
      .CNTVALUEIN(delay_val),
      .CNTVALUEOUT(),
      .INC     (1'b0),
      .CE      (1'b0),
      .RST     (sync_out_delay_rstRR),
      .DATAOUT (ext_sync_out),
      .EN_VTC(1'b0),//(delay_en_vtc),
      .CASC_IN(),
      .CASC_OUT(),
      .CASC_RETURN()
    );
  end else begin
    assign ext_sync_out = sync;
  end
  endgenerate

endmodule
