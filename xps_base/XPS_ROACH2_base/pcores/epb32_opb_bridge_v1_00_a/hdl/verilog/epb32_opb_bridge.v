`timescale 1ns/10ps

module epb32_opb_bridge(
    input         OPB_Clk,
    input         OPB_Rst,
    output        M_request,
    output        M_busLock,
    output        M_select,
    output        M_seqAddr,
    output        M_RNW,
    output  [3:0] M_BE,
    output [31:0] M_ABus,
    output [31:0] M_DBus,
    input  [31:0] OPB_DBus,
    input         OPB_xferAck,
    input         OPB_errAck,
    input         OPB_MGrant,
    input         OPB_retry,
    input         OPB_timeout,
    
    input         epb_clk,
    input         epb_cs_n,
    input         epb_oe_n,
    input         epb_r_w_n,
    input   [3:0] epb_be_n,
    input  [5:29] epb_addr,
    input  [0:31] epb_data_i,
    output [0:31] epb_data_o,
    output        epb_data_oe_n,
    output        epb_rdy,
    output        epb_doe_n
  );

  assign M_seqAddr = 1'b0;
  assign M_busLock = 1'b1;
  assign M_request = 1'b1;

  /******* Common Signals *******/

  reg cmnd_got, cmnd_ack;
  reg resp_got, resp_ack;

  wire cmnd_got_unstable, cmnd_ack_unstable;
  wire resp_got_unstable, resp_ack_unstable;

  /******* EPB Bus control ******/

  reg cmnd_got_reg;
  reg prev_cs_n; 

  wire epb_trans = (prev_cs_n != epb_cs_n && !epb_cs_n);

  assign cmnd_got_unstable = epb_trans | cmnd_got_reg; 
  

  /* Command Generation */
  always @(posedge epb_clk) begin
    prev_cs_n <= epb_cs_n;
    if (OPB_Rst) begin
      cmnd_got_reg <= 1'b0;
    end else begin
      if (epb_trans) begin
        cmnd_got_reg <= 1'b1;      
      end

      if (cmnd_ack) begin
      //if (!epb_trans) begin
        cmnd_got_reg <= 1'b0;
      end
    end
  end

  /* Response Collection */

  reg resp_ack_reg;
  assign resp_ack_unstable = resp_ack_reg | resp_got;


  reg epb_rdy_int;
  assign epb_rdy = cmnd_got_unstable ? 1'b0 : epb_rdy_int;


  reg epb_data_oen_reg;
  assign epb_data_oe_n = epb_data_oen_reg ? epb_oe_n : 1'b1;
  assign epb_doe_n = epb_data_oe_n;

  always @(posedge epb_clk) begin
    //strobes 
    epb_rdy_int <= 1'b0; /* TODO: add tristate to this ? */
    if (OPB_Rst) begin
      resp_ack_reg <= 1'b0;
      epb_data_oen_reg <= 1'b0;
    end else begin
      if (cmnd_got_unstable) begin
        epb_rdy_int <= 1'b0;
        epb_data_oen_reg <= 1'b1;
      end
      if (resp_got) begin
        if (~resp_ack_reg) begin
          epb_rdy_int <= 1'b1;
        end
        resp_ack_reg <= 1'b1;
        epb_data_oen_reg <= 1'b0;
      end else begin
        resp_ack_reg <= 1'b0;
      end
    end
  end

  /**** WishBone Generation ****/
  reg [31:0] OPB_DBus_reg;
  assign epb_data_o = OPB_DBus_reg;

  /* Register everything */
  reg  [3:0] epb_be_n_reg;
  reg [24:0] epb_addr_reg;
  reg [31:0] epb_data_i_reg;
  reg        epb_r_w_n_reg;

  always @(posedge OPB_Clk) begin
    epb_be_n_reg   <= epb_be_n;
    epb_addr_reg   <= epb_addr;
    epb_data_i_reg <= epb_data_i;
    epb_r_w_n_reg  <= epb_r_w_n;
  end

  assign M_DBus   = M_RNW ? 32'b0 : epb_data_i_reg;
  wire [24:0] epb_addr_fixed = epb_addr_reg;
  assign M_ABus   = {epb_addr_fixed, 2'b0};
  assign M_BE       = ~epb_be_n_reg;
  assign M_RNW      = epb_r_w_n_reg;

  /* Command collection */

  reg M_select_reg;
  assign M_select = M_select_reg;
  
  reg cmnd_ack_reg;
  assign cmnd_ack_unstable = cmnd_ack_reg | cmnd_got;

  wire opb_reply;

  always @(posedge OPB_Clk) begin
    //strobes
    if (OPB_Rst) begin
      M_select_reg <= 1'b0;
      cmnd_ack_reg <= 1'b0;
    end else begin
      if (cmnd_got) begin
        M_select_reg <= 1'b1;
        cmnd_ack_reg <= 1'b1;
      end else begin
        cmnd_ack_reg <= 1'b0;
      end
      if (opb_reply)
        M_select_reg <= 1'b0;
    end
  end

  /* Response generation */
  wire internal_timeout;

  reg resp_got_reg;
  assign resp_got_unstable = OPB_xferAck | resp_got_reg;

  assign opb_reply = OPB_xferAck || OPB_errAck || OPB_timeout || OPB_retry || internal_timeout;

  always @(posedge OPB_Clk) begin
    if (OPB_Rst) begin
      resp_got_reg <= 1'b0;
      OPB_DBus_reg <= 32'b0;
    end else begin
      if (opb_reply) begin
        resp_got_reg <= 1'b1;
        OPB_DBus_reg <= OPB_DBus;
      end
      if (resp_ack) begin
        resp_got_reg <= 1'b0;
      end
    end
  end

  localparam BUS_TIMEOUT = 1000;
  reg [9:0] timeout_counter;

  reg internal_timeout_reg;
  assign internal_timeout = internal_timeout_reg;

  always @(posedge OPB_Clk) begin
    internal_timeout_reg <= 1'b0;

    timeout_counter <= timeout_counter + 10'b1;

    if (OPB_Rst) begin
      timeout_counter <= 10'b0;
    end else begin
      if (!M_select_reg)
        timeout_counter <= 10'b0;

      if (timeout_counter >= BUS_TIMEOUT  && M_select_reg)
        internal_timeout_reg <= 1'b1;
        
    end
  end

  /******** Clock Domain Crossing **********/

  reg resp_got_retimed;
  always @(posedge epb_clk) begin
    resp_got_retimed <= resp_got_unstable;
    resp_got         <= resp_got_retimed;
  end

  reg resp_ack_retimed;
  always @(posedge OPB_Clk) begin
    resp_ack_retimed <= resp_ack_unstable;
    resp_ack         <= resp_ack_retimed;
  end

  reg cmnd_got_retimed;
  always @(posedge OPB_Clk) begin
    cmnd_got_retimed <= cmnd_got_unstable;
    cmnd_got         <= cmnd_got_retimed;
  end

  reg cmnd_ack_retimed;
  always @(posedge epb_clk) begin
    cmnd_ack_retimed <= cmnd_ack_unstable;
    cmnd_ack         <= cmnd_ack_retimed;
  end

endmodule