module opb_x64_adc #(
    parameter C_BASEADDR   = 32'h00000000,
    parameter C_HIGHADDR   = 32'h0000FFFF,
    parameter C_OPB_AWIDTH = 32,
    parameter C_OPB_DWIDTH = 32
  ) (
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

    input  [12*8-1:0] fc_sampled,
    output      [7:0] dly_rst,
    output      [7:0] dly_en,
    output      [7:0] dly_inc_dec_n,
    output            dcm_reset,
    input             dcm_locked
  );

  /************ OPB Logic ***************/

  localparam REG_CTRL    = 0;
  localparam REG_DLYCTRL = 1;
  localparam REG_DATASEL = 2;
  localparam REG_DATAVAL = 3;

  wire addr_match = OPB_ABus >= C_BASEADDR && OPB_ABus <= C_HIGHADDR;
  wire [31:0] opb_addr = OPB_ABus - C_BASEADDR;

  reg opb_ack;

  reg [7:0] dly_rst_reg;
  assign dly_rst = dly_rst_reg;
  reg [7:0] dly_en_reg;
  assign dly_en = dly_en_reg;
  reg [7:0] dly_inc_dec_n_reg;
  assign dly_inc_dec_n = dly_inc_dec_n_reg;
  reg dcm_reset_reg;
  assign dcm_reset = dcm_reset_reg;

  reg [1:0] data_index;

  /* Data from the sampler thing */
  reg [11:0] val0;
  reg [11:0] val1;
  reg val0_stable;
  reg val1_stable;
  wire val0_ready;
  wire val1_ready;

  always @(posedge OPB_Clk) begin
    /* Single cycle strobes */
    opb_ack     <= 1'b0;
    dly_rst_reg <= 8'b0;
    dly_en_reg  <= 8'b0;

    if (OPB_Rst) begin
      dcm_reset_reg <= 1'b0;
    end else begin
      if (addr_match && OPB_select && !opb_ack) begin
        opb_ack <= 1'b1;
        if (!OPB_RNW) begin
          case (opb_addr[3:2])
            REG_CTRL:  begin
              if (OPB_BE[3]) begin
                dcm_reset_reg  <= OPB_DBus[31];
              end
            end
            REG_DLYCTRL:  begin
              if (OPB_BE[3]) begin
                dly_rst_reg <= OPB_DBus[24:31];
              end
              if (OPB_BE[2]) begin
                dly_en_reg  <= OPB_DBus[16:23];
              end
              if (OPB_BE[1]) begin
                dly_inc_dec_n_reg  <= OPB_DBus[8:15];
              end
            end
            REG_DATASEL:  begin
              if (OPB_BE[3]) begin
                data_index <= OPB_DBus[30:31];
              end
            end
            REG_DATAVAL:  begin
            end
          endcase
        end
      end
    end
  end
  
  reg [31:0] opb_data_out;

  always @(*) begin
    case (opb_addr[3:2])
      REG_CTRL: begin
        opb_data_out <= {7'b0, dcm_locked, 24'b0};
      end
      REG_DLYCTRL: begin
        opb_data_out <= {8'b0, dly_inc_dec_n_reg, 16'b0};
      end
      REG_DATASEL: begin
        opb_data_out <= {30'b0, data_index};
      end
      default: begin
        opb_data_out <= {2'b0, val1_ready, val1_stable, val1, 2'b0, val0_ready, val0_stable, val0};
      end
    endcase
  end

  assign Sl_DBus     = Sl_xferAck ? opb_data_out : 32'b0;
  assign Sl_errAck   = 1'b0;
  assign Sl_retry    = 1'b0;
  assign Sl_toutSup  = 1'b0;
  assign Sl_xferAck  = opb_ack;

  /************* Frame clock Sample Logic ****************/

  reg [1:0] state;
  localparam STATE_WAIT   = 0;
  localparam STATE_SAMPLE = 1;
  localparam STATE_DONE   = 2;

  reg [4:0] progress;

  reg [11:0] val0_int;
  reg [11:0] val1_int;
  always @(*) begin
    case (data_index)
      0: begin
        val0_int <= fc_sampled[11:0 ];  //Channel 0
        val1_int <= fc_sampled[23:12]; //Channel 1
      end
      1: begin
        val0_int <= fc_sampled[35:24]; //Channel 2
        val1_int <= fc_sampled[47:36]; //Channel 3
      end
      2: begin
        val0_int <= fc_sampled[59:48]; //Channel 4
        val1_int <= fc_sampled[71:60]; //Channel 5
      end
      3: begin
        val0_int <= fc_sampled[83:72]; //Channel 6
        val1_int <= fc_sampled[95:84]; //Channel 7
      end
      default: begin
        val0_int <= fc_sampled[11:0 ];
        val1_int <= fc_sampled[23:12];
      end
    endcase
  end

  always @(posedge OPB_Clk) begin
    progress <= progress + 1;

    if (OPB_Rst) begin
      state <= STATE_DONE;
    end else begin
      case (state)
        STATE_WAIT: begin
          if (progress == {5{1'b1}}) begin
            val0 <= val0_int;
            val1 <= val1_int;
            state <= STATE_SAMPLE;
          end
        end
        STATE_SAMPLE: begin
          if (val0 != val0_int) begin
            val0_stable <= 1'b0;
          end
          if (val1 != val1_int) begin
            val1_stable <= 1'b0;
          end

          if (progress == {5{1'b1}}) begin
            state <= STATE_DONE;
          end
        end
        STATE_DONE: begin
          if (|dly_en_reg) begin
            val0_stable <= 1'b1;
            val1_stable <= 1'b1;
            progress    <= 0;
            state       <= STATE_WAIT;
          end
        end
      endcase
    end
  end
  assign val0_ready = state == STATE_DONE;
  assign val1_ready = state == STATE_DONE;

endmodule
