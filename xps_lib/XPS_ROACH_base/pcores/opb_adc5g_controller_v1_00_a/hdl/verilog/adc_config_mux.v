 // Modify for e2V 5 Gsps by Howard Liu, ASIAA 2009/10/07
// change ctrl_strb_o to ctrl_spi_rst_o
module adc_config_mux #(
   parameter INTERLEAVED = 0,
   parameter MODE = 0 //defaults to A-channel, DMUX 1:1
  ) (
    input  clk,
    input  rst,
    input  request,//set '0' for ADC_5G temporarily
    input  ddrb_i, //don't care the value for ADC_5G temporarily
    input  mode_i, //don't care the value for ADC_5G temporarily

    input  config_start_i, //don't care the value for ADC_5G temporarily
    output config_busy_o,
    input  [15:0] config_data_i, //don't care the value for ADC_5G temporarily
    input   [2:0] config_addr_i, //don't care the value for ADC_5G temporarily

    output ddrb_o,
    output dcm_reset_o,
    output mode_o,  //spi modepin
    output ctrl_clk_o, //spi clock
    output ctrl_spi_rst_o, // SPI reset pin for E2V 5G chip
    output ctrl_data_o // spi data or MOSI
  );
  wire ddrb_int;
  wire mode_int;

  wire config_start;
  wire [15:0] config_data;
  //wire  [2:0] config_addr;
  wire [7:0] config_addr; //expand address width to 8 bit for ADC_5G

  wire config_start_int;
  wire [15:0] config_data_int;
  //wire  [2:0] config_addr_int;
  wire  [7:0] config_addr_int; //expand address width to 8 bit for ADC_5G

  wire ddrb_pre;

  assign ddrb_pre      = request ? ddrb_i         : ddrb_int;
// assign mode_o        = request ? mode_i         : mode_int;
//assign config_start  = request ? config_start_i : config_start_int;

  assign config_start  = config_start_int;

// for simplicity. 5G 2010-04-20 homin
  assign config_data   =  config_data_int;
 //sign config_data   = request ? config_data_i  : config_data_int;
  //assign config_addr   = request ? config_addr_i  : config_addr_int;
  assign config_addr   = config_addr_int;

  /********** Three-wire Interface Control ************/
  //adc three wire interface registers
  reg  [6:0] clk_counter;
  //reg [18:0] shift_register;
  reg [23:0] shift_register; //expand shift_register to 24 bit for ADC_5G

  reg  [2:0] xfer_state;
  localparam STATE_IDLE   = 0; //nothing being sent
  localparam STATE_WAIT   = 1; //waiting for clock negedge
  localparam STATE_STRB0  = 2; //1 cycle with strobe inactive
  localparam STATE_DATA   = 3; //19 cycles to xfer data
  localparam STATE_COMMIT = 4; //1 cycle for commit bit commit 
  localparam STATE_STRB1  = 5; //1 cycle for strb inactive
  localparam STATE_SWAIT  = 6; //wait one cycle with previous strobe actived

  reg  [4:0] xfer_progress;

  always @(posedge clk) begin
    if (rst) begin
      clk_counter    <= 7'b0;
    end else begin
      /* Let counter trickle over */
      if (clk_counter == 7'b111_1111) begin
        clk_counter <= 7'b0;
      end else begin
        clk_counter <= clk_counter + 1;
      end
    end
  end

  always @(posedge clk) begin
// rst signal from powerPC confirmed
  if (rst ) begin
      xfer_progress  <= 5'b0;
      //shift_register <= 19'b0;
      shift_register <= 24'h810348; //expand shift_register to 24 bit for ADC_5G
      xfer_state     <= STATE_IDLE;
    end else begin
// tested. don't care about the config_start which should be from powerPC
   if (config_start && xfer_state == STATE_IDLE) begin //old transfers get pre
       shift_register <= {config_addr, config_data};
        xfer_state     <= STATE_WAIT;
        xfer_progress  <= 5'b0;
      end

      if (clk_counter == 7'b111_1111) begin //on negedge clk
        case (xfer_state)
          STATE_IDLE:   begin
          end
          STATE_WAIT:   begin
            xfer_state <= STATE_STRB0;
          end
          STATE_STRB0:  begin
            xfer_state <= STATE_DATA;
          end
          STATE_DATA:   begin
            shift_register <= {shift_register[22:0], 1'b0};
            xfer_progress  <= xfer_progress + 1;
          //  if (xfer_progress == 18) begin
           if (xfer_progress == 23) begin //adjust cycle length from 19 to 24 for ADC_5G
              xfer_state <= STATE_COMMIT;
            end
          end
          STATE_COMMIT: begin
           xfer_state <= STATE_STRB1;
          end
          STATE_STRB1:  begin
            xfer_state <= STATE_SWAIT;
          end
          STATE_SWAIT:  begin
            xfer_state <= STATE_IDLE;
          end
        endcase
      end
    end
  end

  assign config_busy_o = xfer_state != STATE_IDLE;
 
 assign ctrl_clk_o  = xfer_state == STATE_IDLE || xfer_state == STATE_WAIT ? 1'b0 : clk_counter[6];

 assign ctrl_spi_rst_o = !(xfer_state==STATE_WAIT);
//  assign mode_o = !(xfer_state == STATE_DATA || xfer_state == STATE_COMMIT);
// get rid of one extra bit
 assign mode_o = !(xfer_state == STATE_DATA );

 //assign ctrl_data_o = shift_register[18];
  assign ctrl_data_o = shift_register[23]; //adjust MSB from 18 to 23 for ADC_5G

  /* Auto Config state machine */

  reg [2:0] conf_state;
  localparam CONF_MODE_CLEAR = 3'd0;
  localparam CONF_MODE_SET   = 3'd1;
  localparam CONF_LOAD       = 3'd2;
  localparam CONF_WAIT       = 3'd3;
  localparam CONF_RESET      = 3'd4;
  localparam CONF_DONE       = 3'd5;

  reg [9:0] clear_wait;
  /* This wait needs to be long as there seems to be a TON of
     capacitance on the mode line
  */

  always @(posedge clk) begin
    if (rst) begin
      conf_state <= CONF_MODE_CLEAR;
      clear_wait <= 10'b11_1111_1111;
    end else begin
      case (conf_state)
        CONF_MODE_CLEAR: begin
          if (!clear_wait) begin
            conf_state <= CONF_MODE_SET;
          end else begin
            clear_wait <= clear_wait - 1;
          end
        end
        CONF_MODE_SET: begin
          conf_state <= CONF_LOAD;
        end
        CONF_LOAD: begin
          conf_state <= CONF_WAIT;
        end
        CONF_WAIT: begin
          if (!config_busy_o)
            conf_state <= CONF_RESET;
        end
        CONF_RESET: begin
          conf_state <= CONF_DONE;
        end
        CONF_DONE: begin
        end
      endcase
    end
  end

  assign ddrb_int         = conf_state == CONF_RESET;
  assign mode_int         = clear_wait < 10'b01_1111_1111;
  assign config_start_int = conf_state == CONF_LOAD;
  //assign config_data_int  = INTERLEAVED ? 16'h7c2c : 16'h7cbc; //original description in ADC_1G

   // one-channel modes
   localparam MODE_ACHAN_DMUX1 = 0;
   localparam MODE_ACHAN_DMUX2 = 1;
   localparam MODE_CCHAN_DMUX1 = 2;
   localparam MODE_CCHAN_DMUX2 = 3;

   // two-channel modes
   localparam MODE_2CHAN_DMUX1 = 4;
   localparam MODE_2CHAN_DMUX2 = 5;

   // test modes
   localparam MODE_TEST_RAMP   = 6;

   // set the config register for A channel mode
   assign config_data_int = MODE == MODE_ACHAN_DMUX1 ? 16'h0348 : config_data_int; // one-channel A mode, DMUX 1:1
   assign config_data_int = MODE == MODE_ACHAN_DMUX2 ? 16'h0308 : config_data_int; // one-channel A mode, DMUX 1:2
   
   // set the config register for C channel mode
   assign config_data_int = MODE == MODE_CCHAN_DMUX1 ? 16'h034a : config_data_int; // one-channel C mode, DMUX 1:1
   assign config_data_int = MODE == MODE_CCHAN_DMUX2 ? 16'h030a : config_data_int; // one-channel C mode, DMUX 1:2
   
   // set the config register for two channel mode
   assign config_data_int = MODE == MODE_2CHAN_DMUX1 ? 16'h0344 : config_data_int; // two-channel mode, DMUX 1:1
   assign config_data_int = MODE == MODE_2CHAN_DMUX2 ? 16'h0304 : config_data_int; // two-channel mode, DMUX 1:2
   
   // set the config register for test mode
   assign config_data_int = MODE == MODE_TEST_RAMP ? 16'h1344 : config_data_int; // ramp test mode
   
  //assign config_addr_int  = 3'b0;
  assign config_addr_int  = 8'h81; //new address value for ADC_5G temporarily

  /* dcm reset extend */

  reg [4:0] dcm_reset_extend;

  reg ddrb_reg;
  //synthesis attribute IOB of dcm_reg is true

  always @(posedge clk) begin
    if (rst) begin
 //     dcm_reset_extend <= 4'b0;
      ddrb_reg <= 1'b0;
    end else begin
//      ddrb_reg <= ddrb_pre;
//      if (ddrb_pre) begin
//        dcm_reset_extend <= 5'b11111;
//      end else begin
//        dcm_reset_extend <= dcm_reset_extend << 1;
//      end
    end
  end
  
  assign ddrb_o      = ddrb_reg;
  assign dcm_reset_o = conf_state != CONF_DONE ? 1'b1 : dcm_reset_extend[4];
endmodule
