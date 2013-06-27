/*
 
 Modified version of: 
 XPS_ROACH2_BASE/pcores/opb_katcontroller/hdl/verilog/opb_katcontroller.v
 
 Modified by Rurik Primiani on Feb. 27 2012 to fit the SPI scheme of the 
 ASIAA 5 GSps ADC chip. Modifications include:
 
 - changing SPI address width from 4 to 8
 - slowing down the SPI clock by factor of 2
 - removing first 8 bits of data shift register
 
 */
module opb_adc5g_controller(
    input 	  OPB_Clk,
    input 	  OPB_Rst,
    output [0:31] Sl_DBus,
    output 	  Sl_errAck,
    output 	  Sl_retry,
    output 	  Sl_toutSup,
    output 	  Sl_xferAck,
    input [0:31]  OPB_ABus,
    input [0:3]   OPB_BE,
    input [0:31]  OPB_DBus,
    input 	  OPB_RNW,
    input 	  OPB_select,
    input 	  OPB_seqAddr,

    output 	  adc0_adc3wire_clk,
    output 	  adc0_adc3wire_data,
    input 	  adc0_adc3wire_data_o,
    output 	  adc0_adc3wire_spi_rst,
    output 	  adc0_modepin,
    output 	  adc0_reset,
    output 	  adc0_dcm_reset,
    input 	  adc0_dcm_locked,
    input [15:0]  adc0_fifo_full_cnt,
    input [15:0]  adc0_fifo_empty_cnt,
    output 	  adc0_psclk,
    output 	  adc0_psen,
    output 	  adc0_psincdec,
    input 	  adc0_psdone,
    input 	  adc0_clk,
    output 	  adc0_tap_rst,
    output [4:0]  adc0_datain_pin, 
    output [4:0]  adc0_datain_tap, 

    output 	  adc1_adc3wire_clk,
    output 	  adc1_adc3wire_data,
    input 	  adc1_adc3wire_data_o,
    output 	  adc1_adc3wire_spi_rst,
    output 	  adc1_modepin,
    output 	  adc1_reset,
    output 	  adc1_dcm_reset,
    input 	  adc1_dcm_locked,
    input [15:0]  adc1_fifo_full_cnt,
    input [15:0]  adc1_fifo_empty_cnt,
    output 	  adc1_psclk,
    output 	  adc1_psen,
    output 	  adc1_psincdec,
    input 	  adc1_psdone,
    input 	  adc1_clk,
    output 	  adc1_tap_rst,
    output [4:0]  adc1_datain_pin, 
    output [4:0]  adc1_datain_tap
  );
  parameter C_BASEADDR    = 32'h00000000;
  parameter C_HIGHADDR    = 32'h0000FFFF;
  parameter C_OPB_AWIDTH  = 32;
  parameter C_OPB_DWIDTH  = 32;
  parameter C_FAMILY      = "";

  /* TODO: implement AUTO configuration */
  parameter INITIAL_CONFIG_MODE_0   = 0;
  parameter INITIAL_CONFIG_MODE_1   = 0;

  /********* Global Signals *************/

  wire [15:0] adc0_read_data;
  wire [15:0] adc0_config_data;
  wire  [7:0] adc0_config_addr;
  wire        adc0_config_start;
  wire        adc0_config_done;

  wire [15:0] adc1_read_data;
  wire [15:0] adc1_config_data;
  wire  [7:0] adc1_config_addr;
  wire        adc1_config_start;
  wire        adc1_config_done;

  wire        adc0_reset_wire;
  wire        adc1_reset_wire;

  /************ OPB Logic ***************/

  wire addr_match = OPB_ABus >= C_BASEADDR && OPB_ABus <= C_HIGHADDR;
  wire [31:0] opb_addr = OPB_ABus - C_BASEADDR;

  reg opb_ack;

  /*** Registers ****/

  reg adc0_reset_reg;
  reg adc1_reset_reg;
  assign adc0_reset_wire = adc0_reset_reg;
  assign adc1_reset_wire = adc1_reset_reg;

  reg adc0_mmcm_psen_reg;
  reg adc0_mmcm_psincdec_reg;
  assign adc0_psen     = adc0_mmcm_psen_reg;
  assign adc0_psincdec = adc0_mmcm_psincdec_reg;
  assign adc0_psclk    = OPB_Clk;

  reg adc1_mmcm_psen_reg;
  reg adc1_mmcm_psincdec_reg;
  assign adc1_psen     = adc1_mmcm_psen_reg;
  assign adc1_psincdec = adc1_mmcm_psincdec_reg;
  assign adc1_psclk    = OPB_Clk;

  reg [15:0] adc0_read_data_reg;
  assign adc0_read_data = adc0_read_data_reg;
   
  reg [15:0] adc0_config_data_reg;
  reg  [7:0] adc0_config_addr_reg;
  reg        adc0_config_start_reg;
  assign adc0_config_data  = adc0_config_data_reg;
  assign adc0_config_addr  = adc0_config_addr_reg;
  assign adc0_config_start = adc0_config_start_reg;

  reg [15:0] adc1_read_data_reg;
  assign adc1_read_data = adc1_read_data_reg;
   
  reg [15:0] adc1_config_data_reg;
  reg  [7:0] adc1_config_addr_reg;
  reg        adc1_config_start_reg;
  assign adc1_config_data  = adc1_config_data_reg;
  assign adc1_config_addr  = adc1_config_addr_reg;
  assign adc1_config_start = adc1_config_start_reg;

   /**** IODELAY control signals for ADC 0 ****/
   reg 	     adc0_tap_rst_reg;
   reg [4:0] adc0_datain_pin_reg;
   reg [4:0] adc0_datain_tap_reg;
   assign adc0_tap_rst    = adc0_tap_rst_reg;   
   assign adc0_datain_pin = adc0_datain_pin_reg;
   assign adc0_datain_tap = adc0_datain_tap_reg;
   
   /**** IODELAY control signals for ADC 1 ****/
   reg 	     adc1_tap_rst_reg;
   reg [4:0] adc1_datain_pin_reg;
   reg [4:0] adc1_datain_tap_reg;
   assign adc1_tap_rst    = adc1_tap_rst_reg;   
   assign adc1_datain_pin = adc1_datain_pin_reg;
   assign adc1_datain_tap = adc1_datain_tap_reg;   
   
  reg [31:0] opb_data_out;

  always @(posedge OPB_Clk) begin
    opb_ack <= 1'b0;

    adc0_reset_reg <= 1'b0;
    adc1_reset_reg <= 1'b0;

    adc0_mmcm_psen_reg <= 1'b0;
    adc1_mmcm_psen_reg <= 1'b0;

    adc0_config_start_reg <= 1'b0;
    adc1_config_start_reg <= 1'b0;

    adc0_tap_rst_reg <= 1'b0;
    adc1_tap_rst_reg <= 1'b0;

    if (OPB_Rst) begin
    end else begin
      if (addr_match && OPB_select && !opb_ack) begin
        //opb_ack <= 1'b1;
        if (!OPB_RNW) begin
          case (opb_addr[4:2])
            0:  begin
	       opb_ack <= 1'b1;
               if (OPB_BE[3]) begin
                  adc0_reset_reg <= OPB_DBus[31];
                  adc1_reset_reg <= OPB_DBus[30];
	       end
	       if (OPB_BE[1]) begin
                  adc0_mmcm_psen_reg <= OPB_DBus[15];
                  adc1_mmcm_psen_reg <= OPB_DBus[11];
                  adc0_mmcm_psincdec_reg <= OPB_DBus[14];
                  adc1_mmcm_psincdec_reg <= OPB_DBus[10];
	       end
            end
            1:  begin
	      if (adc0_config_done) begin
		 opb_ack <= 1'b1;
		 if (OPB_BE[3]) begin
                    adc0_config_start_reg <= OPB_DBus[31];
		 end
		 if (OPB_BE[2]) begin
                    adc0_config_addr_reg <= OPB_DBus[16:23];
		 end
		 if (OPB_BE[1]) begin
                    adc0_config_data_reg[7:0] <= OPB_DBus[8:15];
		 end
		 if (OPB_BE[0]) begin
                    adc0_config_data_reg[15:8] <= OPB_DBus[0:7];
		 end
	      end
            end
            2:  begin
	      if (adc1_config_done) begin
		 opb_ack <= 1'b1;
		 if (OPB_BE[3]) begin
                    adc1_config_start_reg <= OPB_DBus[31];
		 end
		 if (OPB_BE[2]) begin
                    adc1_config_addr_reg <= OPB_DBus[16:23];
		 end
		 if (OPB_BE[1]) begin
                    adc1_config_data_reg[7:0] <= OPB_DBus[8:15];
		 end
		 if (OPB_BE[0]) begin
                    adc1_config_data_reg[15:8] <= OPB_DBus[0:7];
		 end
	      end
            end
            3:  begin
	    end
	    4:  begin
	       opb_ack <= 1'b1;
	       if (OPB_BE[3]) begin
		  adc0_tap_rst_reg    <= OPB_DBus[31];
	       end
	       if (OPB_BE[1]) begin
		  adc0_datain_pin_reg <= OPB_DBus[11:15];
	       end
	       if (OPB_BE[0]) begin
		  adc0_datain_tap_reg <= OPB_DBus[3:7];
	       end
	    end
	    5:  begin
	       opb_ack <= 1'b1;
	       if (OPB_BE[3]) begin
		  adc1_tap_rst_reg    <= OPB_DBus[31];
	       end
	       if (OPB_BE[1]) begin
		  adc1_datain_pin_reg <= OPB_DBus[11:15];
	       end
	       if (OPB_BE[0]) begin
		  adc1_datain_tap_reg <= OPB_DBus[3:7];
	       end
            end
          endcase
        end else begin // if (!OPB_RNW)
	  case (opb_addr[4:2])
	    0: begin
	       opb_ack <= 1'b1;
	       opb_data_out <= {2'b0, adc1_psdone, adc0_psdone, 4'b0, 
	       			2'b0, adc1_mmcm_psincdec_reg, adc1_mmcm_psen_reg, 
	       			2'b0, adc0_mmcm_psincdec_reg, adc0_mmcm_psen_reg, 16'b0};
	    end
	    1: begin
	       opb_ack <= adc0_config_done ? 1'b1 : 1'b0;
	       opb_data_out <= {adc0_read_data_reg[15:8], 
	       			adc0_read_data_reg[7:0], 
	       			adc0_config_addr_reg, 7'b0, 
	       			adc0_config_done};
	    end
	    2: begin
	       opb_ack <= adc1_config_done ? 1'b1 : 1'b0;
	       opb_data_out <= {adc1_read_data_reg[15:8], 
	       			adc1_read_data_reg[7:0], 
	       			adc1_config_addr_reg, 
	       			7'b0, adc1_config_done};
	    end
	    3: begin
	       opb_ack <= 1'b1;
	       opb_data_out <= {adc0_fifo_full_cnt[15:8], adc0_fifo_full_cnt[7:0], 
	       			adc0_fifo_empty_cnt[15:8], adc0_fifo_empty_cnt[7:0]};
	    end
	    4: begin
	       opb_ack <= 1'b1;
	       opb_data_out <= {adc1_fifo_full_cnt[15:8], adc1_fifo_full_cnt[7:0], 
	       			adc1_fifo_empty_cnt[15:8], adc1_fifo_empty_cnt[7:0]};
	    end
	    5: begin
	       opb_ack <= 1'b1;
	       opb_data_out <= {adc0_dcm_unlocked_cnt[15:8], adc0_dcm_unlocked_cnt[7:0],
	       			adc1_dcm_unlocked_cnt[15:8], adc1_dcm_unlocked_cnt[7:0]};
	    end
	    6: begin
	       opb_ack <= 1'b1;
	       opb_data_out <= {3'b0, adc0_datain_tap_reg,
				3'b0, adc0_datain_pin_reg,
				8'b0,
				adc0_tap_rst_reg, 7'b0};
	    end
	    7: begin
	       opb_ack <= 1'b1;
	       opb_data_out <= {3'b0, adc1_datain_tap_reg,
				3'b0, adc1_datain_pin_reg,
				8'b0, 
				adc1_tap_rst_reg, 7'b0};
	    end
	  endcase
	end
      end
    end
  end

  assign Sl_DBus     = Sl_xferAck ? opb_data_out : 32'b0;
  assign Sl_errAck   = 1'b0;
  assign Sl_retry    = 1'b0;
  assign Sl_toutSup  = 1'b0;
  assign Sl_xferAck  = opb_ack;


   /***** DCM Unlocked Counter ******/

   reg [15:0] adc0_dcm_unlocked_cnt;
   reg [15:0] adc1_dcm_unlocked_cnt;
	      
   always @(posedge OPB_Clk) begin
      
      if (OPB_Rst) begin
	 adc0_dcm_unlocked_cnt <= 15'b0;
	 adc1_dcm_unlocked_cnt <= 15'b0;
      end else begin

	 if (!adc0_dcm_locked) begin
	    adc0_dcm_unlocked_cnt <= adc0_dcm_unlocked_cnt + 1;
	 end

	 if (!adc1_dcm_locked) begin
	    adc1_dcm_unlocked_cnt <= adc1_dcm_unlocked_cnt + 1;
	 end

      end // else: !if(OPB_Rst)

   end // always @ (posedge OPB_Clk)



  /********* DCM Reset Gen *********/


  reg [7:0] adc0_reset_counter;
  reg [7:0] adc1_reset_counter;

  reg adc0_reset_iob;
  reg adc1_reset_iob;
  // synthesis attribute IOB of adc0_reset_iob is TRUE
  // synthesis attribute IOB of adc1_reset_iob is TRUE

  localparam RST_LENGTH = 8'h10;

  always @(posedge OPB_Clk) begin

    if (OPB_Rst) begin
      adc0_reset_counter <= RST_LENGTH;
      adc1_reset_counter <= RST_LENGTH;
      adc0_reset_iob <= 1'b1;
      adc1_reset_iob <= 1'b1;
    end else begin
      adc0_reset_iob <= adc0_reset_wire;
      adc1_reset_iob <= adc1_reset_wire;
      if (adc0_reset_counter) begin
        adc0_reset_counter <= adc0_reset_counter - 1;
      end
      if (adc1_reset_counter) begin
        adc1_reset_counter <= adc1_reset_counter - 1;
      end
      if ((adc0_reset_wire) || (adc0_startup_reset)) begin
        adc0_reset_counter <= RST_LENGTH;
      end
      if ((adc1_reset_wire) || (adc1_startup_reset)) begin
        adc1_reset_counter <= RST_LENGTH;
      end
    end
  end

  assign adc0_dcm_reset = adc0_startup;
  assign adc1_dcm_reset = adc1_startup;
  assign adc0_reset = adc0_reset_counter != 0;//adc0_reset_iob;
  assign adc1_reset = adc1_reset_counter != 0;//adc1_reset_iob;
  assign adc0_adc3wire_spi_rst = 1'b1;
  assign adc1_adc3wire_spi_rst = 1'b1;
   
  /*** machine states ***/
  localparam CONFIG_IDLE        = 0;
  localparam CONFIG_STARTUP     = 1;
  localparam CONFIG_CLKWAIT     = 2;
  localparam CONFIG_READWAIT    = 3;
  localparam CONFIG_DATA_ADDR   = 4;
  localparam CONFIG_DATA_WRITE  = 5;
  localparam CONFIG_DATA_READ   = 6;
  localparam CONFIG_ALMOST_DONE = 7;
  localparam CONFIG_FINISH      = 8;

  /*** initial configuration modes ***/
  localparam MODE_ACHAN_DMUX1   = 0;
  localparam MODE_ACHAN_DMUX2   = 1;
  localparam MODE_CCHAN_DMUX1   = 2;
  localparam MODE_CCHAN_DMUX2   = 3;
  localparam MODE_2CHAN_DMUX1   = 4;
  localparam MODE_2CHAN_DMUX2   = 5;
  localparam MODE_TEST_RAMP     = 6;

  /********* ADC0 configuration state machine *********/

  wire clk0_falling;
  wire clk0_midhigh;
  wire clk0_prerise;
  wire clk0_en;

  reg [3:0] adc0_state;
  reg [15:0] adc0_read_data_shift;
  reg [23:0] adc0_config_data_shift;
  reg [4:0] adc0_config_progress;
  reg [23:0] adc0_startup_data;
  reg adc0_config_writing;
  reg adc0_startup_reset;
  reg adc0_startup;

  initial begin
     case (INITIAL_CONFIG_MODE_0)
       MODE_ACHAN_DMUX1: adc0_startup_data <= {8'h81, 16'h03c8};
       MODE_ACHAN_DMUX2: adc0_startup_data <= {8'h81, 16'h0388};
       MODE_CCHAN_DMUX1: adc0_startup_data <= {8'h81, 16'h03ca};
       MODE_CCHAN_DMUX2: adc0_startup_data <= {8'h81, 16'h038a};
       MODE_2CHAN_DMUX1: adc0_startup_data <= {8'h81, 16'h03c4};
       MODE_2CHAN_DMUX2: adc0_startup_data <= {8'h81, 16'h0384};
       MODE_TEST_RAMP  : adc0_startup_data <= {8'h81, 16'h13c4};
       default         : adc0_startup_data <= {8'h81, 16'h03c8};
     endcase // case (INITIAL_CONFIG_MODE_0)
  end

  always @(posedge OPB_Clk) begin
    if (OPB_Rst) begin
      adc0_state <= CONFIG_STARTUP;
      adc0_config_writing <= 1'b0;
    end else begin
      case (adc0_state)
        CONFIG_STARTUP: begin
	    adc0_startup <= 1'b1;
            adc0_state <= CONFIG_CLKWAIT;
	    adc0_read_data_shift <= 16'b0;
	    adc0_config_writing <= 1'b1;
            adc0_config_data_shift <= adc0_startup_data;
        end
        CONFIG_IDLE: begin
	  adc0_startup <= 1'b0;
          if (adc0_config_start) begin
            adc0_state <= CONFIG_CLKWAIT;
	    adc0_read_data_shift <= 16'b0;
	    adc0_config_writing <= adc0_config_addr[7];
            adc0_config_data_shift <= {adc0_config_addr, adc0_config_data};
          end
        end
        CONFIG_CLKWAIT: begin
          if (clk0_falling) begin
            adc0_state <= CONFIG_DATA_ADDR;
            adc0_config_progress <= 0;
          end
        end 
        CONFIG_READWAIT: begin
          if (clk0_falling) begin
            adc0_state <= CONFIG_DATA_READ;
          end
        end 
        CONFIG_DATA_ADDR: begin
          if (clk0_falling) begin
            adc0_config_data_shift <= adc0_config_data_shift << 1;
            adc0_config_progress <= adc0_config_progress + 1;
            if (adc0_config_progress == 7) begin
	      if (adc0_config_writing) begin
		adc0_state <= CONFIG_DATA_WRITE;
	      end else begin
		adc0_state <= CONFIG_READWAIT;
	      end
            end
          end
        end
        CONFIG_DATA_WRITE: begin
          if (clk0_falling) begin
	    adc0_config_data_shift <= adc0_config_data_shift << 1;
            adc0_config_progress <= adc0_config_progress + 1;
	  end
	  if (clk0_midhigh) begin
            if (adc0_config_progress == 23) begin
	      adc0_state <= CONFIG_ALMOST_DONE;
	    end
          end
        end
        CONFIG_DATA_READ: begin
          if (clk0_prerise) begin
	    adc0_config_progress <= adc0_config_progress + 1;
            if (adc0_config_progress == 16) begin
	      adc0_state <= CONFIG_READWAIT;
	    end else begin
	      adc0_read_data_shift <= {adc0_read_data_shift[14:0], adc0_adc3wire_data_o};
	    end
	  end
	  if (clk0_midhigh) begin
	    if (adc0_config_progress == 25) begin
	      adc0_state <= CONFIG_ALMOST_DONE;
	    end
          end
        end
        CONFIG_ALMOST_DONE: begin
          if (clk0_prerise) begin
            adc0_state <= CONFIG_FINISH;
          end
	  if (adc0_startup) begin
	    adc0_startup_reset <= 1'b1;
	  end
        end
        CONFIG_FINISH: begin
	  adc0_startup_reset <= 1'b0;
	  adc0_config_writing <= 1'b0;
          if (clk0_falling) begin
            adc0_state <= CONFIG_IDLE;
	    adc0_read_data_reg <= adc0_read_data_shift;
          end
        end
        default: begin
          adc0_state <= CONFIG_IDLE;
        end
      endcase
    end
  end

  assign adc0_config_done = adc0_state == CONFIG_IDLE;
  
  /* Clock Control */

  reg [4:0] clk0_counter;
  always @(posedge OPB_Clk) begin
    if (clk0_en) begin
      clk0_counter <= clk0_counter + 1;
    end else begin
      clk0_counter <= 5'b0;
    end
  end
  assign clk0_falling = clk0_counter == 5'b00000;
  assign clk0_midhigh = clk0_counter == 5'b11000;
  assign clk0_prerise = clk0_counter == 5'b01111;
  assign clk0_en   = adc0_state != CONFIG_IDLE;

  assign adc0_modepin         = !((adc0_state == CONFIG_DATA_ADDR) || (adc0_state == CONFIG_DATA_WRITE) || 
				  (adc0_state == CONFIG_DATA_READ) || (adc0_state == CONFIG_READWAIT));
  assign adc0_adc3wire_data   = adc0_config_data_shift[23];
  assign adc0_adc3wire_clk    = clk0_counter[4] && !(adc0_state == CONFIG_READWAIT) && !(adc0_state == CONFIG_FINISH);


  /********* ADC1 configuration state machine *********/

  wire clk1_falling;
  wire clk1_midhigh;
  wire clk1_prerise;
  wire clk1_en;

  reg [3:0] adc1_state;
  reg [15:0] adc1_read_data_shift;
  reg [23:0] adc1_config_data_shift;
  reg [4:0] adc1_config_progress;
  reg [23:0] adc1_startup_data;
  reg adc1_config_writing;
  reg adc1_startup_reset;
  reg adc1_startup;

  initial begin
     case (INITIAL_CONFIG_MODE_1)
       MODE_ACHAN_DMUX1: adc1_startup_data <= {8'h81, 16'h03c8};
       MODE_ACHAN_DMUX2: adc1_startup_data <= {8'h81, 16'h0388};
       MODE_CCHAN_DMUX1: adc1_startup_data <= {8'h81, 16'h03ca};
       MODE_CCHAN_DMUX2: adc1_startup_data <= {8'h81, 16'h038a};
       MODE_2CHAN_DMUX1: adc1_startup_data <= {8'h81, 16'h03c4};
       MODE_2CHAN_DMUX2: adc1_startup_data <= {8'h81, 16'h0384};
       MODE_TEST_RAMP  : adc1_startup_data <= {8'h81, 16'h13c4};
     endcase // case (INITIAL_CONFIG_MODE_1)
  end

  always @(posedge OPB_Clk) begin
    if (OPB_Rst) begin
      adc1_state <= CONFIG_STARTUP;
      adc1_config_writing <= 1'b0;
    end else begin
      case (adc1_state)
        CONFIG_STARTUP: begin
	    adc1_startup <= 1'b1;
            adc1_state <= CONFIG_CLKWAIT;
	    adc1_read_data_shift <= 16'b0;
	    adc1_config_writing <= 1'b1;
            adc1_config_data_shift <= adc1_startup_data;
        end
        CONFIG_IDLE: begin
	  adc1_startup <= 1'b0;
          if (adc1_config_start) begin
            adc1_state <= CONFIG_CLKWAIT;
	    adc1_read_data_shift <= 16'b0;
	    adc1_config_writing <= adc1_config_addr[7];
            adc1_config_data_shift <= {adc1_config_addr, adc1_config_data};
          end
        end
        CONFIG_CLKWAIT: begin
          if (clk1_falling) begin
            adc1_state <= CONFIG_DATA_ADDR;
            adc1_config_progress <= 0;
          end
        end 
        CONFIG_READWAIT: begin
          if (clk1_falling) begin
            adc1_state <= CONFIG_DATA_READ;
          end
        end 
        CONFIG_DATA_ADDR: begin
          if (clk1_falling) begin
            adc1_config_data_shift <= adc1_config_data_shift << 1;
            adc1_config_progress <= adc1_config_progress + 1;
            if (adc1_config_progress == 7) begin
	      if (adc1_config_writing) begin
		adc1_state <= CONFIG_DATA_WRITE;
	      end else begin
		adc1_state <= CONFIG_READWAIT;
	      end
            end
          end
        end
        CONFIG_DATA_WRITE: begin
          if (clk1_falling) begin
	    adc1_config_data_shift <= adc1_config_data_shift << 1;
            adc1_config_progress <= adc1_config_progress + 1;
	  end
	  if (clk1_midhigh) begin
            if (adc1_config_progress == 23) begin
	      adc1_state <= CONFIG_ALMOST_DONE;
	    end
          end
        end
        CONFIG_DATA_READ: begin
          if (clk1_prerise) begin
	    adc1_config_progress <= adc1_config_progress + 1;
            if (adc1_config_progress == 16) begin
	      adc1_state <= CONFIG_READWAIT;
	    end else begin
	      adc1_read_data_shift <= {adc1_read_data_shift[14:0], adc1_adc3wire_data_o};
	    end
	  end
	  if (clk1_midhigh) begin
	    if (adc1_config_progress == 25) begin
	      adc1_state <= CONFIG_ALMOST_DONE;
	    end
          end
        end
        CONFIG_ALMOST_DONE: begin
          if (clk1_prerise) begin
            adc1_state <= CONFIG_FINISH;
          end
	  if (adc1_startup) begin
	    adc1_startup_reset <= 1'b1;
	  end
        end
        CONFIG_FINISH: begin
	  adc1_startup_reset <= 1'b0;
	  adc1_config_writing <= 1'b0;
          if (clk1_falling) begin
            adc1_state <= CONFIG_IDLE;
	    adc1_read_data_reg <= adc1_read_data_shift;
          end
        end
        default: begin
          adc1_state <= CONFIG_IDLE;
        end
      endcase
    end
  end

  assign adc1_config_done = adc1_state == CONFIG_IDLE;
  
  /* Clock Control */

  reg [4:0] clk1_counter;
  always @(posedge OPB_Clk) begin
    if (clk1_en) begin
      clk1_counter <= clk1_counter + 1;
    end else begin
      clk1_counter <= 5'b0;
    end
  end
  assign clk1_falling = clk1_counter == 5'b00000;
  assign clk1_midhigh = clk1_counter == 5'b11000;
  assign clk1_prerise = clk1_counter == 5'b01111;
  assign clk1_en   = adc1_state != CONFIG_IDLE;

  assign adc1_modepin         = !((adc1_state == CONFIG_DATA_ADDR) || (adc1_state == CONFIG_DATA_WRITE) || 
				  (adc1_state == CONFIG_DATA_READ) || (adc1_state == CONFIG_READWAIT));
  assign adc1_adc3wire_data   = adc1_config_data_shift[23];
  assign adc1_adc3wire_clk    = clk1_counter[4] && !(adc1_state == CONFIG_READWAIT) && !(adc1_state == CONFIG_FINISH);


endmodule
