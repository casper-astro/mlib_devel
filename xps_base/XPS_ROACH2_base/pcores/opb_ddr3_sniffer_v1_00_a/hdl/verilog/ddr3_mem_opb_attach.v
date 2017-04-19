module ddr3_mem_opb_attach #(
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

    input          ddr3_clk,
    input          ddr3_rst,

    output [2:0]   ddr3_cmd,
    output [31:0]  ddr3_addr,
    output         ddr3_en,
    output [287:0] ddr3_wdf_data,
    output [35:0]  ddr3_wdf_mask,
    output         ddr3_wdf_end,
    output         ddr3_wdf_wren,
    input          ddr3_rdy,
    input          ddr3_wdf_rdy,
    input  [287:0] ddr3_rd_data,
    input          ddr3_rd_data_valid,
    input          ddr3_rd_data_end
  );

  /********************* Common signals **********************/
  wire opb_trans_strb;
  wire opb_resp_strb;
  wire ddr3_resp_strb;
  wire ddr3_trans_strb;

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
  reg [511:0] cache_data;
  reg  [25:0] cache_addr;

  localparam CACHE_BITS     = 8;
  localparam CACHE_LIFETIME = 255;
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
        cache_addr  <= opb_addr[31:6];
        cache_valid <= 1'b1;
        cache_timer <= CACHE_LIFETIME;
      end
    end
  end

  assign cache_hit = (cache_addr == opb_addr[31:6]) && OPB_RNW && cache_valid;

  /********** OPB output assignments ***********/

  assign Sl_xferAck = opb_resp_strb || opb_state == OPB_ACK;
  assign Sl_toutSup = opb_state == OPB_WAIT;
  assign Sl_retry   = 1'b0;
  assign Sl_errAck  = 1'b0;

  reg [31:0] SL_DBus_reg;
  always @(posedge OPB_Clk) begin
    case (opb_addr[5:2])
      4'd1:  SL_DBus_reg <= cache_data[31:0];
      4'd0:  SL_DBus_reg <= cache_data[63:32];
      4'd3:  SL_DBus_reg <= cache_data[95:64];
      4'd2:  SL_DBus_reg <= cache_data[127:96];
      4'd5:  SL_DBus_reg <= cache_data[159:128];
      4'd4:  SL_DBus_reg <= cache_data[191:160];
      4'd7:  SL_DBus_reg <= cache_data[223:192];
      4'd6:  SL_DBus_reg <= cache_data[255:224];
      4'd9:  SL_DBus_reg <= cache_data[287:256];
      4'd8:  SL_DBus_reg <= cache_data[319:288];
      4'd11: SL_DBus_reg <= cache_data[351:320];
      4'd10: SL_DBus_reg <= cache_data[383:352];
      4'd13: SL_DBus_reg <= cache_data[415:384];
      4'd12: SL_DBus_reg <= cache_data[447:416];
      4'd15: SL_DBus_reg <= cache_data[479:448];
      4'd14: SL_DBus_reg <= cache_data[511:480];
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

  always @(posedge ddr3_clk) begin
    trans_regR  <= trans_reg;
    trans_regRR <= trans_regR;
    if (ddr3_rst) begin
      resp_reg <= 1'b0;
      wait_reg <= 1'b0;
    end else begin
      if (trans_regRR && !(wait_reg || resp_reg)) begin
        wait_reg <= 1'b1;
      end
      if (ddr3_resp_strb) begin
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
  assign ddr3_trans_strb = trans_regRR && !(wait_reg || resp_reg);

  /***************** DDR3 command generation ************/

  reg [31:0] opb_wr_data_reg;
  reg  [3:0] opb_be_reg;
  reg opb_rnw_reg;

  always @(posedge ddr3_clk) begin
    opb_wr_data_reg <= OPB_DBus;
    opb_be_reg      <= OPB_BE;
    opb_rnw_reg     <= OPB_RNW;
  end

  wire ddr3_wr_resp_strb;
  wire ddr3_rd_resp_strb;
  assign ddr3_resp_strb = ddr3_wr_resp_strb || ddr3_rd_resp_strb;

  wire second_cycle_sel    = opb_addr[5];
  wire [2:0] ddr3_word_sel = opb_addr[4:2];

  /* DDR3 Command issue logic */
  reg second_wr_cycle;
  reg ddr3_en_reg;

  always @(posedge ddr3_clk) begin
    if (ddr3_rst) begin
      ddr3_en_reg <= 1'b0;
    end else begin
      if (ddr3_trans_strb) begin
        ddr3_en_reg <= 1'b1;
      end
      if (ddr3_en && ddr3_rdy) begin
        ddr3_en_reg <= 1'b0;
        if (second_cycle_sel)
          second_wr_cycle    <= 1'b1;
      end
    end
  end

  /* write assignments */
  assign ddr3_wr_resp_strb = ddr3_en && ddr3_rdy && ddr3_wdf_wren;
  assign ddr3_cmd          = {2'b0, opb_rnw_reg};
  assign ddr3_wdf_wren     = !opb_rnw_reg;
  assign ddr3_en           = ddr3_en_reg;
  
  reg [287:0] ddr3_wdf_data_reg;
  always @(*) begin
    case (ddr3_word_sel)
      3'd1: ddr3_wdf_data_reg <= {256'b0, opb_wr_data_reg} << 0;
      3'd0: ddr3_wdf_data_reg <= {256'b0, opb_wr_data_reg} << 32;
      3'd3: ddr3_wdf_data_reg <= {256'b0, opb_wr_data_reg} << 72;
      3'd2: ddr3_wdf_data_reg <= {256'b0, opb_wr_data_reg} << 104;
      3'd5: ddr3_wdf_data_reg <= {256'b0, opb_wr_data_reg} << 144;
      3'd4: ddr3_wdf_data_reg <= {256'b0, opb_wr_data_reg} << 176;
      3'd7: ddr3_wdf_data_reg <= {256'b0, opb_wr_data_reg} << 216;
      3'd6: ddr3_wdf_data_reg <= {256'b0, opb_wr_data_reg} << 248;
    endcase
  end
  assign ddr3_wdf_data = ddr3_wdf_data_reg;

  reg [35:0] ddr3_wdf_mask_reg;
  always @(*) begin
    if (second_wr_cycle || ddr3_en && !second_cycle_sel) begin
      case (ddr3_word_sel)
        3'd1: ddr3_wdf_mask_reg <= {32'b0, opb_be_reg} << 0;
        3'd0: ddr3_wdf_mask_reg <= {32'b0, opb_be_reg} << 4;
        3'd3: ddr3_wdf_mask_reg <= {32'b0, opb_be_reg} << 9;
        3'd2: ddr3_wdf_mask_reg <= {32'b0, opb_be_reg} << 13;
        3'd5: ddr3_wdf_mask_reg <= {32'b0, opb_be_reg} << 18;
        3'd4: ddr3_wdf_mask_reg <= {32'b0, opb_be_reg} << 22;
        3'd7: ddr3_wdf_mask_reg <= {32'b0, opb_be_reg} << 27;
        3'd6: ddr3_wdf_mask_reg <= {32'b0, opb_be_reg} << 31;
      endcase
    end else begin
      ddr3_wdf_mask_reg <= 36'b0;
    end
  end
  assign ddr3_wdf_mask = ddr3_wdf_mask_reg;

  /* DDR3 Read response collection */
  reg ddr3_rd_resp_strb_reg;

  always @(posedge ddr3_clk) begin
    ddr3_rd_resp_strb_reg <= 1'b0;

    if (ddr3_rst) begin
    end else begin
	  if (ddr3_rd_data_valid) begin
        if (ddr3_rd_data_end) begin 
		  ddr3_rd_resp_strb_reg <= 1'b1;
          cache_data[287:256] <= ddr3_rd_data[ 31:0  ]; 
          cache_data[319:288] <= ddr3_rd_data[ 63:32 ]; 
          cache_data[351:320] <= ddr3_rd_data[103:72 ];
          cache_data[383:352] <= ddr3_rd_data[135:104];
          cache_data[415:384] <= ddr3_rd_data[175:144]; 
          cache_data[447:416] <= ddr3_rd_data[207:176]; 
          cache_data[479:448] <= ddr3_rd_data[247:216];
          cache_data[511:480] <= ddr3_rd_data[279:248];
		end else begin
	      cache_data[31:0]    <= ddr3_rd_data[31:0]; 
          cache_data[63:32]   <= ddr3_rd_data[63:32]; 
          cache_data[95:64]   <= ddr3_rd_data[103:72];
          cache_data[127:96]  <= ddr3_rd_data[135:104];
          cache_data[159:128] <= ddr3_rd_data[175:144]; 
          cache_data[191:160] <= ddr3_rd_data[207:176]; 
          cache_data[223:192] <= ddr3_rd_data[247:216];
          cache_data[255:224] <= ddr3_rd_data[279:248];
        end		
	  end 
    end
  end

  assign ddr3_addr = {6'b0, opb_addr[31:6]};

  /* read assignments */
  assign ddr3_rd_resp_strb = ddr3_rd_resp_strb_reg;

endmodule
