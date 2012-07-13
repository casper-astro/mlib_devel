`timescale 1ns/10ps

`define SIMLENGTH 400000
`define SYS_CLK_PERIOD 4

module TB_opb_adc5g_controller();

   wire sys_rst;
   wire sys_clk;

   /***************** DUT ***************/
   wire OPB_Clk;
   wire OPB_Rst;
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
   wire        adc0_adc3wire_data_o;
   wire        adc0_adc3wire_spi_rst;
   wire        adc0_modepin;
   wire        adc0_reset;
   wire        adc0_dcm_reset;
   wire        adc0_psclk;
   wire        adc0_psen;
   wire        adc0_psincdec;
   wire        adc0_psdone;
   wire        adc0_clk;

   wire        adc1_adc3wire_clk;
   wire        adc1_adc3wire_data;
   wire        adc1_adc3wire_data_o;
   wire        adc1_adc3wire_spi_rst;
   wire        adc1_modepin;
   wire        adc1_reset;
   wire        adc1_dcm_reset;
   wire        adc1_psclk;
   wire        adc1_psen;
   wire        adc1_psincdec;
   wire        adc1_psdone;
   wire        adc1_clk;

   opb_adc5g_controller #(.INITIAL_CONFIG_MODE_0(6),
			  .INITIAL_CONFIG_MODE_1(6))
   opb_adc5g_controller_inst (
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
			      .adc0_adc3wire_data_o(adc0_adc3wire_data_o),
			      .adc0_modepin(adc0_modepin),
			      .adc0_reset(adc0_reset),
			      .adc0_dcm_reset(adc0_dcm_reset),
			      .adc0_psclk(adc0_psclk),
			      .adc0_psen(adc0_psen),
			      .adc0_psincdec(adc0_psincdec),
			      .adc0_psdone(adc0_psdone),
			      .adc0_clk(adc0_clk),
			      .adc1_adc3wire_clk(adc1_adc3wire_clk),
			      .adc1_adc3wire_data(adc1_adc3wire_data),
			      .adc1_adc3wire_data_o(adc1_adc3wire_data_o),
			      .adc1_modepin(adc1_modepin),
			      .adc1_reset(adc1_reset),
			      .adc1_dcm_reset(adc1_dcm_reset),
			      .adc1_psclk(adc1_psclk),
			      .adc1_psen(adc1_psen),
			      .adc1_psincdec(adc1_psincdec),
			      .adc1_psdone(adc1_psdone),
			      .adc1_clk(adc1_clk)
			      );

   /****** System Signal generations ******/
   reg [31:0]  sys_clk_counter;

   reg 	       reset;
   assign sys_rst = reset;

   initial begin
      $dumpvars;
      sys_clk_counter <= 32'b0;

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
   reg [3:0]  opb_be;
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
	      opb_rnw  <= 0;
	      opb_addr <= 0;
	      opb_be   <= 4'b0001;
	      opb_select <= 1'b1;
	      progress <= 1;
           end
           1: begin
              if (Sl_xferAck) begin
		 opb_data <= {16'h03c8, 8'h81, 8'b1};
		 opb_addr <= 4;
		 opb_be   <= 4'b1111;
		 opb_rnw  <= 0;
		 opb_select <= 1'b1;
		 progress <= 2;
              end
           end
           2: begin
              if (Sl_xferAck) begin
		 opb_data <= {16'h03c8, 8'h01, 8'b1};
		 opb_addr <= 4;
		 opb_be   <= 4'b1111;
		 opb_rnw  <= 0;
		 opb_select <= 1'b1;
		 progress <= 3;
              end
           end
           3: begin
              if (Sl_xferAck) begin
		 opb_data <= 32'b0;
		 opb_addr <= 4;
		 opb_be   <= 4'b1111;
		 opb_rnw  <= 1;
		 opb_select <= 1'b1;
		 progress <= 4;
              end
           end
           4: begin
              if (Sl_xferAck) begin
		 opb_data <= {16'h03c8, 8'h81, 8'b1};
		 opb_addr <= 8;
		 opb_be   <= 4'b1111;
		 opb_rnw  <= 0;
		 opb_select <= 1'b1;
		 progress <= 5;
              end
           end
           5: begin
              if (Sl_xferAck) begin
		 opb_data <= {16'h03c8, 8'h01, 8'b1};
		 opb_addr <= 8;
		 opb_be   <= 4'b1111;
		 opb_rnw  <= 0;
		 opb_select <= 1'b1;
		 progress <= 6;
              end
           end
           6: begin
              if (Sl_xferAck) begin
		 opb_data <= 32'b0;
		 opb_addr <= 8;
		 opb_be   <= 4'b1111;
		 opb_rnw  <= 1;
		 opb_select <= 1'b1;
		 progress <= 7;
              end
           end
           7: begin
              if (Sl_xferAck) begin
		 opb_data <= 32'b0;
		 opb_addr <= 12;
		 opb_be   <= 4'b1111;
		 opb_rnw  <= 1;
		 opb_select <= 1'b1;
		 progress <= 8;
              end
           end
           8: begin
              if (Sl_xferAck) begin
		 opb_select <= 1'b0;
		 progress <= 9;
              end
           end
	   9: begin
	      $finish;
	   end
	 endcase
      end
   end 

   assign OPB_ABus   = opb_addr;
   assign OPB_BE     = opb_be;
   assign OPB_DBus   = opb_data;
   assign OPB_RNW    = opb_rnw;
   assign OPB_select = opb_select;


   /* ADC0 test setup */
   
   reg [4:0] config0_cntr;
   initial begin
      config0_cntr <= 0;
   end

   reg [23:0] config0_data;
   reg 	      config0_data_o;
   reg 	      config0_reading;
   reg [15:0] config0_data_o_shift;

   assign adc0_adc3wire_data_o = config0_data_o;

   always @(posedge adc0_adc3wire_clk) begin
      if (sys_rst) begin
      end else begin
	 if (adc0_modepin === 0) begin
            config0_data[23-config0_cntr] <= adc0_adc3wire_data;
            config0_cntr <= config0_cntr + 1;
	    if (config0_cntr == 7) begin
	       if (config0_data[23] == 0) begin
		  config0_reading <= 1'b1;
	       end
	    end
            if (config0_cntr == 23) begin
	       config0_cntr <= 0;
               #10
			      $display("adc0_conf: %x", config0_data);
	       if (!config0_reading) begin
		  if (config0_data === {8'h81, 16'h03c8}) begin
		     config0_reading <= 1'b0;
		  end else begin
		     $display("FAILED @(%x): adc0 mismatch - got = %x, expected = %x", progress, config0_data, {8'h81, 16'h03c8});
		  end
	       end
            end
	 end // if (adc0_modepin === 0)
      end
   end // always @ (posedge adc0_adc3wire_clk)

   always @(negedge adc0_adc3wire_clk) begin
      if (sys_rst) begin
	 config0_data_o <= 1'b0;
	 config0_data_o_shift <= 16'h03c8;
      end else begin
	 if (config0_reading) begin
	    config0_data_o <= config0_data_o_shift[15];
	    config0_data_o_shift <= config0_data_o_shift << 1;
	 end
      end
   end

   /* ADC1 test setup */
   
   reg [4:0] config1_cntr;
   initial begin
      config1_cntr <= 0;
   end

   reg [23:0] config1_data;
   reg 	      config1_data_o;
   reg 	      config1_reading;
   reg [15:0] config1_data_o_shift;

   assign adc1_adc3wire_data_o = config1_data_o;

   always @(posedge adc1_adc3wire_clk) begin
      if (sys_rst) begin
      end else begin
	 if (adc1_modepin === 0) begin
            config1_data[23-config1_cntr] <= adc1_adc3wire_data;
            config1_cntr <= config1_cntr + 1;
	    if (config1_cntr == 7) begin
	       if (config1_data[23] == 0) begin
		  config1_reading <= 1'b1;
	       end
	    end
            if (config1_cntr == 23) begin
	       config1_cntr <= 0;
               #10
			      $display("adc1_conf: %x", config1_data);
	       if (!config1_reading) begin
		  if (config1_data === {8'h81, 16'h03c8}) begin
		     config1_reading <= 1'b0;
		  end else begin
		     $display("FAILED @(%x): adc1 mismatch - got = %x, expected = %x", progress, config1_data, {8'h81, 16'h03c8});
		  end
	       end
            end
	 end // if (adc1_modepin === 0)
      end
   end // always @ (posedge adc1_adc3wire_clk)

   always @(negedge adc1_adc3wire_clk) begin
      if (sys_rst) begin
	 config1_data_o <= 1'b0;
	 config1_data_o_shift <= 16'h03c8;
      end else begin
	 if (config1_reading) begin
	    config1_data_o <= config1_data_o_shift[15];
	    config1_data_o_shift <= config1_data_o_shift << 1;
	 end
      end
   end

   
endmodule
