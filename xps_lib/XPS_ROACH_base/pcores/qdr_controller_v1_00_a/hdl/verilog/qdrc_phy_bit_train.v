module qdrc_phy_bit_train(
    clk, // this can be a slow clock
    reset,

    train_start,
    train_done,
    train_fail,

    q_rise,
    q_fall,

    dly_inc_dec_n,
    dly_en,
    dly_rst,
    aligned
  );
  parameter DATA_WIDTH = 18;
  parameter CLK_FREQ   = 200;
  parameter BYPASS     = 1;

  input  clk, reset;

  input  train_start;
  output train_done, train_fail;

  input  [17:0] q_rise;
  input  [17:0] q_fall;

  output [17:0] dly_inc_dec_n;
  output [17:0] dly_en;
  output [17:0] dly_rst;

  output [17:0] aligned;

  /* DLY_DELTA is the delay increment when the IDELAY_CONF is configured
   * with a 200 MHz clock in ps*/
  localparam DLY_DELTA  = 78;
  /* ILogic hold time in ps */
  localparam HOLD_TIME  = 500;
  /* The width of a bit in ps */
  localparam BIT_STEPS  = 500/78 + 1;

  function valid;
    input [1:0] i;
    begin
      valid = i[1] ^ i[0];
    end
  endfunction
   
  /* primary state machine */

  reg [2:0] state;
  localparam STATE_IDLE    = 3'd0;
  localparam STATE_SEARCH  = 3'd1;
  localparam STATE_BACK    = 3'd2;
  localparam STATE_FORWARD = 3'd3;
  localparam STATE_ALIGN   = 3'd4;
  localparam STATE_DONE    = 3'd5;

  reg mode;
  localparam MODE_DEFAULT = 0;
  localparam MODE_ACQUIRE = 1;

  /* Registers referenced by the state machine */

  reg [17:0] dly_inc_dec_n;
  reg [17:0] dly_en;
  reg dly_rst_reg;
  assign dly_rst = {18{dly_rst_reg}};
  reg train_fail;
  reg train_done;

  reg [1:0] curr_reg; /* Async register for capturing IDDR data */
  // synthesis attribute ASYNC_REG of curr_reg[0] is true 
  // synthesis attribute ASYNC_REG of curr_reg[1] is true 
  //
  reg [1:0] prev;  /* the 'ACQUIRED' value 1 cycle  previous */
  reg [1:0] curr;  /* the current  'ACQUIRED' value */
  reg [1:0] hist0;    
  reg [1:0] hist1;    
  reg [1:0] hist2;    

  wire history_stable = curr == hist0 && hist0 == hist1 && hist1 == hist2;

  reg [5:0] acquire_progress;
  localparam ACQUIRE_THRESHOLD = 16;

  reg [4:0] bit_index;
  reg [5:0] progress;
  reg [5:0] baddies;

  reg [17:0] aligned;

  always @(posedge clk) begin
    /* Single cycle outputs */
    dly_en       <= 18'b0;
    dly_rst_reg  <= 1'b0;

    /* async registered iddr data */
    curr_reg <= {q_rise[bit_index], q_fall[bit_index]};

    if (reset) begin
      state      <= BYPASS ? STATE_DONE : STATE_IDLE;
      mode       <= MODE_DEFAULT;
      train_fail <= 1'b0;
      train_done <= 1'b0;

      aligned    <= {18{1'b1}};

      progress         <= 6'b0;
      acquire_progress <= 0;

      baddies     <= 6'b0;

      dly_rst_reg <= 1'b1;

      prev       <= 2'b0;
      hist0      <= 2'b0;
      hist1      <= 2'b0;
      hist2      <= 2'b0;
      bit_index  <= 5'b0;
    end else begin
      case (mode)
        MODE_DEFAULT: begin
          case (state)
            STATE_IDLE:    begin
              if (train_start) begin
                state       <= STATE_SEARCH;
                mode        <= MODE_ACQUIRE;

                progress         <= 6'b0;
                acquire_progress <= 0;

                baddies     <= 6'b0;

                prev       <= 2'b0;
                hist0      <= 2'b0;
                hist1      <= 2'b0;
                hist2      <= 2'b0;
              end
            end
            STATE_SEARCH:  begin
              /* Search for a edge transition
                 _______BBBBBBB--X
              */
              hist0 <= curr;
              hist1 <= hist0;
              hist2 <= hist1;

              if (curr != prev && valid(curr) && valid(prev) && history_stable) begin
                if (progress > BIT_STEPS + baddies + 2) begin
                  state    <= STATE_BACK;
                  progress <= BIT_STEPS + baddies + 2;
                end else begin
                  state    <= STATE_FORWARD;
                  progress <= BIT_STEPS - 2;
                end
              end else begin
                if (progress == 6'd63) begin
                  /* We have delayed as much as we could and have not found
                   * a bit transition */
                  state       <= STATE_ALIGN;
                  progress    <= 4;
                  train_fail  <= 1'b1;
                  dly_rst_reg <= 1'b1;
                end else begin
                  mode             <= MODE_ACQUIRE;
                  acquire_progress <= 0;
                  progress      <= progress + 1;
                  dly_inc_dec_n[bit_index] <= 1'b1;
                  dly_en[bit_index]        <= 1'b1;

                  if (valid(curr) && history_stable) begin
                    prev <= curr;
                  end

                  if (baddies || valid(prev) && curr != prev) begin
                    baddies <= baddies + 1;
                  end
                end
              end
            end
            STATE_BACK:    begin
              hist0 <= curr;
              hist1 <= hist0;
              hist2 <= hist1;

              if (progress != 0) begin
                mode             <= MODE_ACQUIRE;
                acquire_progress <= 0;

                progress      <= progress - 1;

                dly_inc_dec_n[bit_index] <= 1'b0;
                dly_en[bit_index]        <= 1'b1;
              end else begin
                state       <= STATE_ALIGN;
                progress    <= 4;
                if (!valid(curr) || !history_stable) begin
                  train_fail <= 1'b1;
                end
              end
            end
            STATE_FORWARD: begin
              hist0 <= curr;
              hist1 <= hist0;
              hist2 <= hist1;

              if (progress != 0) begin
                mode             <= MODE_ACQUIRE;
                acquire_progress <= 0;

                progress      <= progress - 1;

                dly_inc_dec_n[bit_index] <= 1'b1;
                dly_en[bit_index]        <= 1'b1;
              end else begin
                state       <= STATE_ALIGN;
                progress    <= 4;
                if (!valid(curr) || !history_stable) begin
                  train_fail <= 1'b1;
                end
              end
            end
            STATE_ALIGN:    begin
              if (progress) begin
                progress <= progress - 1;
              end else begin
                state    <= STATE_DONE;
                if (!curr_reg[1])
                  aligned[bit_index] <= 1'b0;
              end
            end
            STATE_DONE:    begin
              if (bit_index < DATA_WIDTH - 1) begin
                state       <= STATE_SEARCH;
                mode        <= MODE_ACQUIRE;

                progress         <= 6'b0;
                acquire_progress <= 0;

                baddies     <= 6'b0;

                prev       <= 2'b0;
                hist0      <= 2'b0;
                hist1      <= 2'b0;
                hist2      <= 2'b0;
                bit_index  <= bit_index + 1;
              end else begin
                train_done <= 1'b1;
              end
            end
          endcase
        end
        MODE_ACQUIRE: begin
          if (acquire_progress == 0) begin
            /* ignore the first to compensate for registered curr_reg */
          end else if (!valid(curr_reg)) begin
              /* if the data is invalid invalidate the data and
               * exit mode */
            mode <= MODE_DEFAULT;
            curr <= 2'b00; //invalid
          end begin
            curr <= curr_reg;
            /* by default store the previous reg'd value */

            if (acquire_progress > 1 && curr_reg != curr) begin
              /* if there is a change in the value invalidate the data and
               * exit mode */
              mode <= MODE_DEFAULT;
              curr <= 2'b00; //invalid
            end
            if (acquire_progress >= ACQUIRE_THRESHOLD) begin
              /* Acquire complete enter default mode */
              mode <= MODE_DEFAULT;
            end
          end
          acquire_progress <= acquire_progress + 1;
        end
      endcase
    end
  end

endmodule
