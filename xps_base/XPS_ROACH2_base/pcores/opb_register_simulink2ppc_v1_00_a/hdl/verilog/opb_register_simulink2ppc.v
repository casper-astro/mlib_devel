module opb_register_simulink2ppc #(
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
    input  [31:0] user_data_in
  );

  /* Handshake signal from OPB to application indicating new data should be latched */
  reg register_request;
  /* Handshake signal from application to OPB indicating data has been latched */
  reg register_ready;

  assign Sl_toutSup = 1'b0;
  assign Sl_retry   = 1'b0;
  assign Sl_errAck  = 1'b0;

  reg Sl_xferAck_reg;
  assign Sl_xferAck = Sl_xferAck_reg;

  wire a_match = OPB_ABus >= C_BASEADDR && OPB_ABus <= C_HIGHADDR;
  wire [31:0] a_trans = OPB_ABus - C_BASEADDR;

  /* Application clock domain data buffer */
  reg [31:0] user_data_in_reg;
  /* OPB clock domain data buffer */
  reg [31:0] register_buffer;

  reg register_readyR;
  reg register_readyRR;

  always @(posedge OPB_Clk) begin
    //single cycle signals
    Sl_xferAck_reg  <= 1'b0;

    register_readyR  <= register_ready;
    register_readyRR <= register_readyR;

    if (OPB_Rst) begin
      register_request <= 1'b0;
    end else if (a_match && OPB_select && !Sl_xferAck_reg) begin
      Sl_xferAck_reg <= 1'b1;
    end

    if (register_readyRR) begin
      register_request <= 1'b0;
    end

    if (register_readyRR && register_request) begin
      /* only latch the data when the buffer is not locked */
      register_buffer <= user_data_in_reg;
    end

    if (!register_readyRR) begin
      /* always request the buffer */
      register_request <= 1'b1;
    end
  end

  reg [0:31] Sl_DBus_reg;
  assign Sl_DBus = Sl_DBus_reg;

  always @(*) begin
    if (!Sl_xferAck_reg) begin
      Sl_DBus_reg <= 32'b0;
    end else begin
      Sl_DBus_reg[0:31] <= register_buffer;
    end
  end

  reg register_requestR;
  reg register_requestRR;

  always @(posedge user_clk) begin
    register_requestR  <= register_request;
    register_requestRR <= register_requestR;

    if (register_requestRR) begin
      register_ready <= 1'b1;
    end

    if (!register_requestRR) begin
      register_ready <= 1'b0;
    end

    if (register_requestRR && !register_ready) begin
      register_ready <= 1'b1;
      user_data_in_reg <= user_data_in;
    end
  end
endmodule
