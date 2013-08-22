module qdrc_phy_bit_train #(
    parameter DATA_WIDTH = 36
  ) (
    input                     clk,
    input                     reset,
    input                     train_start,
    output                    train_done,
    output                    train_fail,
    /* input data */
    input  [DATA_WIDTH - 1:0] q_rise,
    input  [DATA_WIDTH - 1:0] q_fall,
    /* IODELAY controls */
    output [DATA_WIDTH - 1:0] dly_inc_dec_n,
    output [DATA_WIDTH - 1:0] dly_en,
    output [DATA_WIDTH - 1:0] dly_rst,
    /* Final Half word alignment status */
    output [DATA_WIDTH - 1:0] aligned,
    /* Debug probes */
    output [3:0] bit_train_state_prb,
    output [3:0] bit_train_error_prb
  );

  /* DLY_DELTA (in ps) is the delay increment when the IDELAY_CONF is configured with a 200 MHz clock */
  localparam DLY_DELTA  = 78;
  /* ILogic hold time in ps */
  //localparam HOLD_TIME  = 600;
  localparam HOLD_TIME  = 400;
  /* The width of a bit in ps */
  localparam BIT_STEPS  = HOLD_TIME/DLY_DELTA + 1;

  function valid;
    input [1:0] i;
    begin
      valid = i[1] ^ i[0];
    end
  endfunction
   
  /* primary state machine */

  reg [3:0] state;
  assign bit_train_state_prb = state;
   
  localparam STATE_IDLE    = 4'd0;
  localparam STATE_SEARCH  = 4'd1;
  localparam STATE_BACK    = 4'd2;
  localparam STATE_FORWARD = 4'd3;
  localparam STATE_ALIGN   = 4'd4;
  localparam STATE_DONE    = 4'd5;

  reg mode;
  localparam MODE_DEFAULT = 0;
  localparam MODE_ACQUIRE = 1;

  /* Registers referenced by the state machine */
  reg dly_inc_dec_n_reg;
  assign dly_inc_dec_n = {DATA_WIDTH{dly_inc_dec_n_reg}};

  reg [DATA_WIDTH - 1:0] dly_en_reg;
  assign dly_en = dly_en_reg;

  reg [DATA_WIDTH - 1:0] dly_rst_reg;
  assign dly_rst = dly_rst_reg;

  reg [DATA_WIDTH - 1:0] aligned_reg;
  assign aligned = aligned_reg;

  reg train_fail_reg;
  assign train_fail = train_fail_reg;

  /* Errors used for debugging */
  localparam ERROR_NONE        = 4'd0;
  localparam ERROR_NO_TRANS    = 4'd1;
  localparam ERROR_CANT_BACK   = 4'd2;
  localparam ERROR_INVAL_BACK  = 4'd3;
  localparam ERROR_INVAL_FORW  = 4'd4;

  reg train_err_reg;
  assign bit_train_error_prb = train_err_reg;

  reg train_done_reg;
  assign train_done = train_done_reg;

  reg [1:0] curr_reg; /* Async register for capturing IDDR data */
  // synthesis attribute ASYNC_REG of curr_reg[0] is true 
  // synthesis attribute ASYNC_REG of curr_reg[1] is true 
  //
  reg [1:0] prev;  /* the 'ACQUIRED' value 1 cycle  previous */
  reg [1:0] curr;  /* the current  'ACQUIRED' value */
  reg [1:0] hist0;    
  reg [1:0] hist1;    
  reg [1:0] hist2;    
  localparam HISTORY_LENGTH = 3;

  wire history_stable = valid(curr) && curr == hist0 && hist0 == hist1 && hist1 == hist2;

  // ROACH2 has only 32 taps (Virtex6)
  //reg [5:0] acquire_progress;
  reg [4:0] acquire_progress;

  //reg [4:0] bit_index;
  reg [5:0] bit_index; // 4:0 max range is 0x1f (31), but QDR has 36 pins set to 5:0
  //reg [5:0] progress;
  reg [4:0] progress;
  //reg [5:0] baddies;
  reg [4:0] baddies;

  reg [DATA_WIDTH-1:0] q_rise_buf;
  reg [DATA_WIDTH-1:0] q_fall_buf;

  always @(posedge clk) begin
    /* Single cycle outputs */
    dly_en_reg   <= {DATA_WIDTH{1'b0}};
    dly_rst_reg  <= {DATA_WIDTH{1'b0}};

    /* async registered iddr data */
    q_rise_buf <= q_rise;
    q_fall_buf <= q_fall;
    curr_reg <= {q_rise_buf[bit_index], q_fall_buf[bit_index]};

    if (reset) begin
      state          <= STATE_IDLE;
      mode           <= MODE_DEFAULT;

      train_fail_reg <= 1'b0;
      train_done_reg <= 1'b0;
      train_err_reg  <= ERROR_NONE;

      aligned_reg <= {DATA_WIDTH{1'b1}};

      progress         <= 5'b0;//6'b0;
      acquire_progress <= 0;

      baddies     <= 5'b0;

      prev       <= 2'b0;
      hist0      <= 2'b0;
      hist1      <= 2'b0;
      hist2      <= 2'b0;
      bit_index  <= 6'b0;

      dly_rst_reg <= {DATA_WIDTH{1'b1}};
    end else begin
      case (mode)
        MODE_DEFAULT: begin
          /* always clear the aquire state */
          acquire_progress <= 0;

          case (state)
            STATE_IDLE:    begin
              if (train_start) begin
                state    <= STATE_SEARCH;
                mode     <= MODE_ACQUIRE;

                progress <= 5'b0;
                baddies  <= 5'b0;

                prev     <= 2'b0;
                hist0    <= 2'b0;
                hist1    <= 2'b0;
                hist2    <= 2'b0;
              end
            end
            STATE_SEARCH:  begin
              /* Search for a edge transition
                 _______BBBBBBB--X
              */
              mode  <= MODE_ACQUIRE;

              hist0 <= curr;
              hist1 <= hist0;
              hist2 <= hist1;

              /* We have delayed as much as we could and have not found
               * a bit transition */
              if (progress == 5'd31) begin
                  state           <= STATE_ALIGN;
                  train_fail_reg  <= 1'b1;
		  train_err_reg   <= ERROR_NO_TRANS;
                  dly_rst_reg[bit_index] <= 1'b1;
              end 

              /* the first time we have a stable value, store it in 'prev' */
              if (history_stable && !valid(prev)) begin
                prev <= curr;
              end

              /* if we have a stable value and there is a change in value */
              if (history_stable && valid(prev) && prev != curr) begin
                if (progress + BIT_STEPS - HISTORY_LENGTH < 32) begin
                /* if we have a stable value and there is a change in value */
                  state    <= STATE_FORWARD;
                  progress <= BIT_STEPS - HISTORY_LENGTH;
                end else begin
                  state    <= STATE_BACK;
                  progress <= BIT_STEPS + baddies + HISTORY_LENGTH;

                  if (BIT_STEPS + baddies + HISTORY_LENGTH > progress) begin
                    /* we cant go back further than we went */
                    train_fail_reg  <= 1'b1;
		    train_err_reg   <= ERROR_CANT_BACK;
                  end
                end
              end else begin
                progress              <= progress + 1;
                dly_inc_dec_n_reg     <= 1'b1;
                dly_en_reg[bit_index] <= 1'b1;
              end

              if (valid(prev) && !history_stable) begin
                baddies <= baddies + 1;
              end
            end
            STATE_BACK:    begin
              mode     <= MODE_ACQUIRE;
              progress <= progress - 1;

              if (progress) begin
                dly_inc_dec_n_reg     <= 1'b0;
                dly_en_reg[bit_index] <= 1'b1;
              end else begin
                state <= STATE_ALIGN;
                if (!valid(curr)) begin
                  train_fail_reg <= 1'b1;
		  train_err_reg  <= ERROR_INVAL_BACK;
                end
              end
            end
            STATE_FORWARD: begin
              mode          <= MODE_ACQUIRE;
              progress      <= progress - 1;

              if (progress) begin
                dly_inc_dec_n_reg     <= 1'b1;
                dly_en_reg[bit_index] <= 1'b1;
              end else begin
                state       <= STATE_ALIGN;
                if (!valid(curr)) begin
                  train_fail_reg <= 1'b1;
		  train_err_reg  <= ERROR_INVAL_FORW;
                end
              end
            end
            STATE_ALIGN:    begin
              state    <= STATE_DONE;
              if (!curr_reg[1])
                aligned_reg [bit_index] <= 1'b0;
            end
            STATE_DONE:    begin
              if (bit_index < DATA_WIDTH - 1) begin
                state      <= STATE_SEARCH;
                mode       <= MODE_ACQUIRE;

                progress   <= 5'b0;
                baddies    <= 5'b0;
                prev       <= 2'b0;
                hist0      <= 2'b0;
                hist1      <= 2'b0;
                hist2      <= 2'b0;
                bit_index  <= bit_index + 1'b1;
              end else begin
                train_done_reg <= 1'b1;
              end
            end
          endcase
        end
        MODE_ACQUIRE: begin
          acquire_progress <= acquire_progress + 1;
          if (!acquire_progress[4]) begin
            /* Latch the first value after waiting 16 cycles */
            if (acquire_progress[3:0] == 4'b1111) begin
              curr <= curr_reg;
            end
          end else begin
            if (!valid(curr_reg)) begin
              /* if the data is invalid mark the data and exit */
              mode <= MODE_DEFAULT;
              curr <= 2'b00; //invalid
            end

            if (curr_reg != curr) begin
              /* if the data value has changed mark the data and exit */
              mode <= MODE_DEFAULT;
              curr <= 2'b00; //invalid
            end

            if (acquire_progress[3:0] == 4'b1111) begin
              mode <= MODE_DEFAULT;
            end
          end
        end
      endcase
    end
  end

endmodule
