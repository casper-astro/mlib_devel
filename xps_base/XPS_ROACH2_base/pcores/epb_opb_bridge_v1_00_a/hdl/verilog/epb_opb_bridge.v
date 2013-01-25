module epb_opb_bridge(
    epb_data_oe_n,
    epb_cs_n, epb_r_w_n, epb_be_n, 
    epb_oe_n,
    epb_addr, epb_addr_gp,
    epb_data_i, epb_data_o,
    epb_rdy,
    epb_rdy_oe,

    OPB_Clk,
    OPB_Rst,
    M_request,
    M_busLock,
    M_select,
    M_RNW,
    M_BE,
    M_seqAddr,
    M_DBus,
    M_ABus,
    OPB_MGrant,
    OPB_xferAck,
    OPB_errAck,
    OPB_retry,
    OPB_timeout,
    OPB_DBus
  );
  output epb_data_oe_n;
  input  epb_cs_n, epb_oe_n, epb_r_w_n;
  input   [1:0] epb_be_n;
  input  [22:0] epb_addr;
  input   [5:0] epb_addr_gp;
  input  [15:0] epb_data_i;
  output [15:0] epb_data_o;
  output epb_rdy;
  output epb_rdy_oe;

  input  OPB_Clk, OPB_Rst;
  output M_request;
  output M_busLock;
  output M_select;
  output M_RNW;
  output [0:3]  M_BE;
  output M_seqAddr;
  output [0:31] M_DBus;
  output [0:31] M_ABus;
  input  OPB_MGrant;
  input  OPB_xferAck;
  input  OPB_errAck;
  input  OPB_retry;
  input  OPB_timeout;
  input  [0:31] OPB_DBus;

  /********************** *******************/

  reg  epb_cs_n_reg, epb_oe_n_reg, epb_r_w_n_reg;
  reg   [1:0] epb_be_n_reg;
  reg  [22:0] epb_addr_reg;
  reg   [5:0] epb_addr_gp_reg;
  reg  [15:0] epb_data_i_reg;
  (* MAXDELAY = "4.0 ns" *) wire epb_cs_n_int;

  always @(posedge OPB_Clk) begin
    epb_cs_n_reg    <= epb_cs_n_int;
    epb_oe_n_reg    <= epb_oe_n;
    epb_r_w_n_reg   <= epb_r_w_n;
    epb_be_n_reg    <= epb_be_n;
    epb_addr_reg    <= epb_addr;
    epb_addr_gp_reg <= epb_addr_gp;
    epb_data_i_reg  <= epb_data_i;
  end
  assign epb_cs_n_int = epb_cs_n;

  //synthesis attribute IOB of epb_data_i_reg is true
  //synthesis attribute IOB of epb_addr_gp_reg is true
  //synthesis attribute IOB of epb_addr_reg is true
  //synthesis attribute IOB of epb_be_n_reg is true
  //synthesis attribute IOB of epb_oe_n_reg is true
  //synthesis attribute IOB of epb_r_w_n_reg is true


  /***** EPB CS edge detection *****/
  reg prev_cs_n;
  always @(posedge OPB_Clk) begin 
    prev_cs_n <= epb_cs_n_reg;
  end

  /***** Misc Assignments *****/
  wire epb_trans_strb = (prev_cs_n && !epb_cs_n_reg);
  wire epb_trans      = !epb_cs_n_reg;
  wire OPB_reply      = OPB_xferAck | OPB_errAck | OPB_timeout | OPB_retry;

  assign epb_data_oe_n = (!epb_r_w_n_reg) | (!epb_trans) | epb_oe_n_reg; //0 when read = 1 and epb_tran = 1 and epb_oe_n = 0 else 1

  /***** OPB Output Assignments *****/
  assign M_request = 1'b1;
  assign M_busLock = 1'b1;
  assign M_seqAddr = 1'b0; //TODO: implement bursting

  reg M_RNW;
  reg [0:31] M_ABus;
  reg [0:3 ] M_BE;
  reg [0:31] M_DBus;
  always @(*) begin
    if (!M_select) begin
      M_RNW  <= 1'b0;
      M_ABus <= 32'b0;
      M_BE   <= 4'b0;
      M_DBus <= 32'b0;
    end else begin
      M_RNW  <= epb_r_w_n_reg;
      M_ABus <= {5'b0, epb_addr_gp_reg[2:0], epb_addr_reg[22:1], 2'b0}; //bit truncated to support 32 bit addressing
      if (epb_addr_reg[0]) begin
        if (epb_r_w_n_reg) begin
          M_BE   <= {2'b0, 2'b11};
          M_DBus <= 32'b0;
        end else begin
          M_BE   <= {2'b0, !epb_be_n_reg[1], !epb_be_n_reg[0]};
          M_DBus <= {16'b0, epb_data_i_reg};
        end
      end else begin
        if (epb_r_w_n_reg) begin
          M_BE   <= {2'b11, 2'b00};
          M_DBus <= 32'b0;
        end else begin
          M_BE   <= {!epb_be_n_reg[1], !epb_be_n_reg[0], 2'b00};
          M_DBus <= {epb_data_i_reg, 16'b0};
        end
      end
    end
  end

  /******************** EPB/OPB State Machine ********************/

  reg opb_state;
  localparam OPB_STATE_IDLE = 1'd0; 
  localparam OPB_STATE_WAIT = 1'd1; 

  /* Cut Through routed M_select */
  reg M_select_reg;
  assign M_select = M_select_reg || (opb_state == OPB_STATE_IDLE && epb_trans_strb);
 
  /* Cut Through routed epb_rdy and epb_data_o */
  wire         epb_rdy_int = opb_state == OPB_STATE_WAIT && OPB_reply;
  wire [15:0] epb_data_int = epb_addr_reg[0] ? OPB_DBus[16:31] : OPB_DBus[0:15];

  reg [10:0] timeout_counter;

  reg opb_state_z;

  wire bus_timeout = timeout_counter[10:8] == 3'b111;

  always @(posedge OPB_Clk) begin
    timeout_counter <= timeout_counter + 1;
    opb_state_z <= opb_state;

    //strobes
    if (OPB_Rst) begin
      M_select_reg <= 1'b0;
      opb_state    <= OPB_STATE_IDLE;
    end else begin
      case (opb_state)
        OPB_STATE_IDLE: begin
          if (epb_trans_strb) begin
            M_select_reg    <= 1'b1;
            opb_state       <= OPB_STATE_WAIT;
            timeout_counter <= 0;
          end
        end
        OPB_STATE_WAIT: begin

          if (bus_timeout) begin
            M_select_reg <= 1'b0;
            opb_state    <= OPB_STATE_IDLE;
          end

          if (OPB_reply) begin
            M_select_reg <= 1'b0;
            opb_state    <= OPB_STATE_IDLE;
          end
        end
      endcase
    end
  end

  reg [15:0] epb_data_o_reg;
  reg epb_rdy_reg;

  always @(posedge OPB_Clk) begin
    epb_data_o_reg <= 16'hC0DE;

    if (bus_timeout && opb_state == OPB_STATE_WAIT)
      epb_data_o_reg <= 16'hdead;

    if (epb_rdy_int)
      epb_data_o_reg <= epb_data_int;
  end

  always @(posedge OPB_Clk) begin
    if (epb_cs_n_int) begin
      epb_rdy_reg <= 1'b0;
    end else begin
      epb_rdy_reg <= epb_rdy_reg | (opb_state == OPB_STATE_WAIT && (bus_timeout || OPB_reply));
    end
  end

  reg [15:0] epb_data_o;
  reg epb_rdy;

  always @(negedge OPB_Clk) begin
    epb_data_o <= epb_data_o_reg;
    epb_rdy <= epb_rdy_reg;
  end
  //synthesis attribute IOB of epb_data_o is TRUE
  //synthesis attribute IOB of epb_rdy is TRUE

  assign epb_rdy_oe = !epb_cs_n_int;

endmodule
