module opb_register_ppc2simulink #(
    parameter C_BASEADDR   = 32'h00000000,
    parameter C_HIGHADDR   = 32'h0000FFFF,
    parameter C_OPB_AWIDTH = 0,
    parameter C_OPB_DWIDTH = 0,
    parameter C_FAMILY     = "default"
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
    input         user_clk,
    output [31:0] user_data_out
  );

  /* OPB clock domain data value */
  reg [31:0] reg_buffer;
  /* Handshake signal from OPB to application indicating data is ready to be latched */
  reg register_ready;
  /* Handshake signal from application to OPB indicating data has been latched */
  reg register_done;

  assign Sl_toutSup = 1'b0;
  assign Sl_retry   = 1'b0;
  assign Sl_errAck  = 1'b0;

  reg Sl_xferAck_reg;
  assign Sl_xferAck = Sl_xferAck_reg;

  wire a_match = OPB_ABus >= C_BASEADDR && OPB_ABus <= C_HIGHADDR;
  wire [31:0] a_trans = OPB_ABus - C_BASEADDR;

  reg register_doneR;
  reg register_doneRR;

  always @(posedge OPB_Clk) begin
    //single cycle signals
    Sl_xferAck_reg  <= 1'b0;

    /* Clock domain crossing registering */
    register_doneR  <= register_done;
    register_doneRR <= register_doneR;

    if (OPB_Rst) begin
      register_ready <= 1'b0;
    end else if (a_match && OPB_select && !Sl_xferAck_reg) begin
      Sl_xferAck_reg <= 1'b1;
      if (!OPB_RNW) begin
        if (OPB_BE[0])
          reg_buffer[31:24] <= OPB_DBus[0:7]; 
        if (OPB_BE[1])
          reg_buffer[23:16] <= OPB_DBus[8:15]; 
        if (OPB_BE[2])
          reg_buffer[15:8] <= OPB_DBus[16:23]; 
        if (OPB_BE[3])
          reg_buffer[7:0] <= OPB_DBus[24:31]; 

        /* ROACH bus transaction occurs in two stages;
           to make sure that writes are atomic only latch on receiving the second half*/
        if (OPB_BE[3])
          register_ready <= 1'b1;
      end
    end
    if (register_doneRR) begin
      register_ready <= 1'b0;
    end
  end

  reg [0:31] Sl_DBus_reg;
  assign Sl_DBus = Sl_DBus_reg;

  always @(*) begin
    if (!Sl_xferAck_reg) begin
      Sl_DBus_reg <= 32'b0;
    end else begin
      Sl_DBus_reg[0:31] <= reg_buffer;
    end
  end

  reg register_readyR;
  reg register_readyRR;
  reg [31:0] user_data_out_reg;
  assign user_data_out = user_data_out_reg;

  always @(posedge user_clk) begin
    /* Clock domain crossing registering */
    register_readyR  <= register_ready;
    register_readyRR <= register_readyR;

    if (!register_readyRR) begin
      register_done <= 1'b0;
    end

    if (register_readyRR) begin
      register_done <= 1'b1;
      user_data_out_reg <= reg_buffer;
    end

  end
endmodule
