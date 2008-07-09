module epb_opb_bridge(
    sys_reset,

    epb_clk,
    epb_data_oe_n,
    epb_cs_n, epb_r_w_n, epb_be_n, 
    epb_oe_n,
    epb_addr, epb_addr_gp,
    epb_data_i, epb_data_o,
    epb_rdy,

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
    ,debug
  );
  output reg [3:0] debug;
  input  sys_reset;

  input  epb_clk;
  output epb_data_oe_n;
  input  epb_cs_n, epb_oe_n, epb_r_w_n;
  input   [1:0] epb_be_n;
  input  [22:0] epb_addr;
  input   [5:0] epb_addr_gp;
  input  [15:0] epb_data_i;
  output [15:0] epb_data_o;
  output epb_rdy;

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

  /***** EPB CS edge detection *****/
  reg prev_cs_n;
  always @(posedge OPB_Clk) begin //epb_clk must equal OPB_Clk
    prev_cs_n <= epb_cs_n;
  end

  /***** Misc Assignments *****/
  wire epb_trans_strb = (prev_cs_n != epb_cs_n && !epb_cs_n);
  wire epb_trans      = !epb_cs_n;
  wire OPB_reply      = OPB_xferAck | OPB_errAck | OPB_timeout | OPB_retry;

  assign epb_data_oe_n = (!epb_r_w_n) | (!epb_trans) | epb_oe_n; //0 when read = 1 and epb_tran = 1 and epb_oe_n = 0 else 1

  /***** OPB Output Assignments *****/
  assign M_request = 1'b1;
  assign M_busLock = 1'b1;
  assign M_seqAddr = 1'b0; //TODO: implement bursting

  assign M_RNW  = M_select ? epb_r_w_n : 1'b0;
  assign M_ABus = M_select ? {5'b0, epb_addr_gp[2:0], epb_addr[22:1], 2'b0} : 32'b0; //convert to 32 bit addressing
  assign M_BE   = M_select ? epb_addr[0] ? {2'b0, !epb_be_n[1], !epb_be_n[0]} : {!epb_be_n[1], !epb_be_n[0], 2'b00} : 4'b0; 
  assign M_DBus = M_select ? epb_addr[0] ? {16'b0, epb_data_i} : {epb_data_i, 16'b0} : 32'b0;


  /******************** EPB/OPB State Machine ********************/

  reg [1:0] opb_state;
  localparam OPB_STATE_IDLE = 2'd0; 
  localparam OPB_STATE_ARB  = 2'd1; 
  localparam OPB_STATE_WAIT = 2'd2; 

  reg M_select_reg;

  /* Cut Through routed M_select */
  assign M_select = M_select_reg                                                  ||
                    (opb_state == OPB_STATE_IDLE && epb_trans_strb && OPB_MGrant) ||
                    (opb_state == OPB_STATE_ARB  && OPB_MGrant);
  /* Cut Through routed epb_rdy and epb_data_o */
  assign epb_rdy    = opb_state == OPB_STATE_WAIT && OPB_reply;
  assign epb_data_o = epb_addr[0] ? OPB_DBus[16:31] : OPB_DBus[0:15];

  always @(posedge OPB_Clk) begin
    debug[3] <= M_select;
    //strobes
    if (OPB_Rst | sys_reset) begin
      M_select_reg <= 1'b0;
      opb_state    <= OPB_STATE_IDLE;
    end else begin
      case (opb_state)
        OPB_STATE_IDLE: begin
          if (epb_trans_strb) begin //on first
            if (OPB_MGrant) begin
              M_select_reg <= 1'b1;
              opb_state    <= OPB_STATE_WAIT;
              debug[0] <= ~debug[0];
            end else begin
              opb_state    <= OPB_STATE_ARB;
            end
          end
        end
        OPB_STATE_ARB: begin
          if (!epb_trans) begin //if epb gives up, give up too
            M_select_reg <= 1'b0;
            opb_state    <= OPB_STATE_IDLE;
          end else if (OPB_MGrant) begin
            M_select_reg  <= 1'b1;
            opb_state     <= OPB_STATE_WAIT;
          end
        end
        OPB_STATE_WAIT: begin
          if (!epb_trans) begin //if epb gives up, give up too
            M_select_reg <= 1'b0;
            opb_state    <= OPB_STATE_IDLE;
            debug[1] <= ~debug[1];
          end else if (OPB_reply) begin
            M_select_reg <= 1'b0;
            opb_state    <= OPB_STATE_IDLE;
            debug[0] <= ~debug[0];
          end
        end
      endcase
    end
  end


endmodule
