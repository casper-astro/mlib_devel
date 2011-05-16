module adc_config_mux #(
    parameter INTERLEAVED = 0
  ) (
    input  clk,
    input  rst,
    input  request,
    input  ddrb_i,
    input  mode_i,

    input  config_start_i,
    output config_busy_o,
    input  [15:0] config_data_i,
    input   [2:0] config_addr_i,

    output ddrb_o,
    output mmcm_reset_o,
    output mode_o,
    output ctrl_clk_o,
    output ctrl_strb_o,
    output ctrl_data_o
  );
  wire ddrb_int;
  wire mode_int;

  wire config_start;
  wire [15:0] config_data;
  wire  [2:0] config_addr;

  wire config_start_int;
  wire [15:0] config_data_int;
  wire  [2:0] config_addr_int;

  wire ddrb_pre;

  assign ddrb_pre      = request ? ddrb_i         : ddrb_int;
  assign mode_o        = request ? mode_i         : mode_int;
  assign config_start  = request ? config_start_i : config_start_int;
  assign config_data   = request ? config_data_i  : config_data_int;
  assign config_addr   = request ? config_addr_i  : config_addr_int;

  /********** Three-wire Interface Control ************/
  //adc three wire interface registers
  reg  [6:0] clk_counter;
  reg [18:0] shift_register;

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
    if (rst) begin
      xfer_progress  <= 5'b0;
      shift_register <= 19'b0;
      xfer_state     <= STATE_IDLE;
    end else begin

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
            shift_register <= {shift_register, 1'b0};
            xfer_progress  <= xfer_progress + 1;
            if (xfer_progress == 18) begin
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
  assign ctrl_strb_o = !(xfer_state == STATE_DATA || xfer_state == STATE_COMMIT);
  assign ctrl_data_o = shift_register[18];

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
  assign config_data_int  = INTERLEAVED ? 16'h7c2c : 16'h7cbc;
  assign config_addr_int  = 3'b0;

  /* dcm reset extend */

  reg [4:0] mmcm_reset_extend;

  reg ddrb_reg;
  //synthesis attribute IOB of dcm_reg is true

  always @(posedge clk) begin
    if (rst) begin
      mmcm_reset_extend <= 4'b0;
      ddrb_reg <= 1'b0;
    end else begin
      ddrb_reg <= ddrb_pre;
      if (ddrb_pre) begin
        mmcm_reset_extend <= 5'b11111;
      end else begin
        mmcm_reset_extend <= mmcm_reset_extend << 1;
      end
    end
  end
  
  assign ddrb_o      = ddrb_reg;
  assign mmcm_reset_o = conf_state != CONF_DONE ? 1'b1 :mmcm_reset_extend[4];
endmodule
