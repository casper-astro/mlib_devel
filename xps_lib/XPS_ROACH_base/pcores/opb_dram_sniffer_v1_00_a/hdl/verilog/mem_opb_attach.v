module mem_opb_attach #(
    parameter C_BASEADDR = 0,
    parameter C_HIGHADDR = 0
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

    input          dram_clk,
    input          dram_rst,

    output         dram_cmd_en,
    output         dram_cmd_rnw,
    output [143:0] dram_wr_data,
    output  [17:0] dram_wr_be,
    output  [31:0] dram_address,
    input  [143:0] dram_rd_data,
    input          dram_rd_dvld,
    input          dram_ack
  );

  /********************* Common signals **********************/
  wire opb_trans_strb;
  wire opb_resp_strb;
  wire dram_resp_strb;
  wire dram_trans_strb;

  /************** OPB transaction extraction *****************/
  
  wire [31:0] opb_addr = OPB_ABus - C_BASEADDR;
  wire opb_sel = (OPB_ABus >= C_BASEADDR && OPB_ABus <= C_HIGHADDR) && OPB_select;

  /* cache hit signal */
  wire cache_hit;

  reg [1:0] opb_state;
  localparam OPB_IDLE = 2'd0;
  localparam OPB_WAIT = 2'd1;
  localparam OPB_ACK  = 2'd2;

  reg opb_trans_strb_reg;

  always @(posedge OPB_Clk) begin
    /* Single cycle strobe */
    opb_trans_strb_reg <= 1'b0;

    if (OPB_Rst) begin
      opb_state <= OPB_IDLE;
    end else begin
      case (opb_state)
        OPB_IDLE: begin
          if (opb_sel) begin
            if (cache_hit) begin /* cache hit, ack immediately */
              opb_state <= OPB_ACK;
            end else begin /* cache miss, get data from controller */
              opb_state <= OPB_WAIT; 
              opb_trans_strb_reg <= 1'b1;
            end
          end
        end
        OPB_WAIT: begin
          if (!OPB_select || opb_resp_strb) begin
            opb_state <= OPB_IDLE;
          end
        end
        OPB_ACK: begin
          opb_state <= OPB_IDLE;
        end
      endcase
    end
  end

  assign opb_trans_strb = opb_trans_strb_reg;

  /*********** Read mini-cache logic ***********/

  reg cache_valid;
  reg [255:0] cache_data;
  reg  [26:0] cache_addr;

  localparam CACHE_BITS     = 7;
  localparam CACHE_LIFETIME = 127;
  reg [CACHE_BITS - 1:0] cache_timer;

  always @(posedge OPB_Clk) begin
    if (OPB_Rst) begin
      cache_valid <= 1'b0;
      cache_timer <= 0;
    end else begin
      if (cache_timer == 0 || (opb_trans_strb && !OPB_RNW)) begin
        cache_valid <= 1'b0;
      end
      if (cache_timer) begin
        cache_timer <= cache_timer - 1;
      end
      if (opb_resp_strb && OPB_RNW) begin
        cache_addr  <= opb_addr[31:5];
        cache_valid <= 1'b1;
        cache_timer <= CACHE_LIFETIME;
      end
    end
  end

  assign cache_hit = (cache_addr == opb_addr[31:5]) && OPB_RNW && cache_valid;

  /********** OPB output assignments ***********/

  assign Sl_xferAck = opb_resp_strb || opb_state == OPB_ACK;
  assign Sl_toutSup = opb_state == OPB_WAIT;
  assign Sl_retry   = 1'b0;
  assign Sl_errAck  = 1'b0;

  reg [31:0] SL_DBus_reg;
  always @(posedge OPB_Clk) begin
    case (opb_addr[4:2])
      3'd3: SL_DBus_reg <= cache_data[31:0];
      3'd2: SL_DBus_reg <= cache_data[63:32];
      3'd1: SL_DBus_reg <= cache_data[95:64];
      3'd0: SL_DBus_reg <= cache_data[127:96];
      3'd7: SL_DBus_reg <= cache_data[159:128];
      3'd6: SL_DBus_reg <= cache_data[191:160];
      3'd5: SL_DBus_reg <= cache_data[223:192];
      3'd4: SL_DBus_reg <= cache_data[255:224];
    endcase
  end
  assign Sl_DBus = Sl_xferAck ? SL_DBus_reg : 32'b0;

  /********* transaction and response handshaking ************/

  reg trans_reg;
  reg trans_regR;
  reg trans_regRR;
  //synthesis attribute HU_SET of trans_regR  is SET1
  //synthesis attribute HU_SET of trans_regRR is SET1
  //synthesis attribute RLOC   of trans_regR  is X0Y0
  //synthesis attribute RLOC   of trans_regRR is X0Y1

  reg resp_reg;
  reg resp_regR;
  reg resp_regRR;
  //synthesis attribute HU_SET of resp_regR  is SET0
  //synthesis attribute HU_SET of resp_regRR is SET0
  //synthesis attribute RLOC   of resp_regR  is X0Y0
  //synthesis attribute RLOC   of resp_regRR is X0Y1

  reg wait_clear;

  always @(posedge OPB_Clk) begin
    resp_regR  <= resp_reg;
    resp_regRR <= resp_regR;

    if (OPB_Rst) begin
      trans_reg  <= 1'b0;
      wait_clear <= 1'b0;
    end else begin
      if (opb_trans_strb && !trans_reg) begin
        trans_reg  <= 1'b1;
        wait_clear <= 1'b0;
      end
      if (opb_trans_strb && trans_reg) begin
        trans_reg  <= 1'b0;
        /* fail. we have gotten a request while a response was pending.
           Give up on both transactions.
        */
      end
      if (resp_regRR) begin
        trans_reg  <= 1'b0;
        wait_clear <= 1'b1;
      end
      if (wait_clear && !resp_regRR) begin
        wait_clear   <= 1'b0;
      end
    end
  end

  reg wait_reg;

  always @(posedge dram_clk) begin
    trans_regR  <= trans_reg;
    trans_regRR <= trans_regR;
    if (dram_rst) begin
      resp_reg <= 1'b0;
      wait_reg <= 1'b0;
    end else begin
      if (trans_regRR && !(wait_reg || resp_reg)) begin
        wait_reg <= 1'b1;
      end
      if (dram_resp_strb) begin
        wait_reg <= 1'b0;
        resp_reg <= 1'b1;
      end
      if (!trans_regRR) begin
        wait_reg <= 1'b0;
        resp_reg <= 1'b0;
      end
    end
  end

  assign opb_resp_strb   =  wait_clear && !resp_regRR;
  assign dram_trans_strb = trans_regRR && !(wait_reg || resp_reg);

  /***************** DRAM command generation ************/

  reg [31:0] opb_wr_data_reg;
  reg  [3:0] opb_be_reg;
  reg opb_rnw_reg;

  always @(posedge dram_clk) begin
    opb_wr_data_reg <= OPB_DBus;
    opb_be_reg      <= OPB_BE;
    opb_rnw_reg     <= OPB_RNW;
  end

  wire dram_wr_resp_strb;
  wire dram_rd_resp_strb;
  assign dram_resp_strb = dram_wr_resp_strb || dram_rd_resp_strb;

  wire second_cycle_sel    = opb_addr[4];
  wire [1:0] dram_word_sel = opb_addr[3:2];

  /* DRAM Command issue logic */
  reg second_wr_cycle;
  reg dram_cmd_en_reg;

  always @(posedge dram_clk) begin
    second_wr_cycle      <= 1'b0;

    if (dram_rst) begin
      dram_cmd_en_reg <= 1'b0;
    end else begin
      if (dram_trans_strb) begin
        dram_cmd_en_reg <= 1'b1;
      end
      if (dram_cmd_en && dram_ack) begin
        dram_cmd_en_reg <= 1'b0;
        if (second_cycle_sel)
          second_wr_cycle    <= 1'b1;
      end
    end
  end

  /* write assignments */
  assign dram_wr_resp_strb = dram_cmd_en && dram_ack && !dram_cmd_rnw;
  assign dram_cmd_rnw = opb_rnw_reg;
  assign dram_cmd_en  = dram_cmd_en_reg;
  
  reg [143:0] dram_wr_data_reg;
  always @(*) begin
    case (dram_word_sel)
      2'd3: dram_wr_data_reg <= {112'b0, opb_wr_data_reg} << 0;
      2'd2: dram_wr_data_reg <= {112'b0, opb_wr_data_reg} << 32;
      2'd1: dram_wr_data_reg <= {112'b0, opb_wr_data_reg} << 72;
      2'd0: dram_wr_data_reg <= {112'b0, opb_wr_data_reg} << 104;
    endcase
  end
  assign dram_wr_data = dram_wr_data_reg;

  reg [16:0] dram_wr_be_reg;
  always @(*) begin
    if (second_wr_cycle || dram_cmd_en && !second_cycle_sel) begin
      case (dram_word_sel)
        2'd3: dram_wr_be_reg <= {14'b0, opb_be_reg} << 0;
        2'd2: dram_wr_be_reg <= {14'b0, opb_be_reg} << 4;
        2'd1: dram_wr_be_reg <= {14'b0, opb_be_reg} << 9;
        2'd0: dram_wr_be_reg <= {14'b0, opb_be_reg} << 13;
      endcase
    end else begin
      dram_wr_be_reg <= 18'b0;
    end
  end
  assign dram_wr_be = dram_wr_be_reg;

  /* DRAM Read response collection */
  reg second_read_cycle;
  reg dram_rd_resp_strb_reg;

  always @(posedge dram_clk) begin
    second_read_cycle     <= 1'b0;
    dram_rd_resp_strb_reg <= 1'b0;

    if (dram_rst) begin
    end else begin
      if (second_read_cycle) begin
        dram_rd_resp_strb_reg <= 1'b1;
        cache_data[159:128] <=  dram_rd_data[ 31:0  ]; 
        cache_data[191:160] <=  dram_rd_data[ 63:32 ]; 
        cache_data[223:192] <=  dram_rd_data[103:72 ];
        cache_data[255:224] <=  dram_rd_data[135:104];
      end else begin
        if (dram_rd_dvld) begin
          second_read_cycle <= 1'b1;
          cache_data[ 31:0 ] <= dram_rd_data[ 31:0  ]; 
          cache_data[ 63:32] <= dram_rd_data[ 63:32 ]; 
          cache_data[ 95:64] <= dram_rd_data[103:72 ];
          cache_data[127:96] <= dram_rd_data[135:104];
        end
      end
    end
  end

  assign dram_address = {5'b0, opb_addr[31:5]};

  /* read assignments */
  assign dram_rd_resp_strb = dram_rd_resp_strb_reg;

endmodule
