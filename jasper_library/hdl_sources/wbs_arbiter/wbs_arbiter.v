module wbs_arbiter(
    /*generic wb signals*/
    wb_clk_i, wb_rst_i,
    /*wbm signals*/
    wbm_cyc_i, wbm_stb_i, wbm_we_i, wbm_sel_i,
    wbm_adr_i, wbm_dat_i, wbm_dat_o,
    wbm_ack_o, wbm_err_o,
    /*wbs signals*/
    wbs_cyc_o, wbs_stb_o, wbs_we_o, wbs_sel_o,
    wbs_adr_o, wbs_dat_o, wbs_dat_i,
    wbs_ack_i, wbs_err_i
  );
  parameter NUM_SLAVES = 14;
  parameter SLAVE_ADDR = 0;
  parameter SLAVE_HIGH = 0;
  parameter TIMEOUT    = 10;

  input  wb_clk_i, wb_rst_i;

  input  wbm_cyc_i;
  input  wbm_stb_i;
  input  wbm_we_i;
  input   [3:0] wbm_sel_i;
  input  [31:0] wbm_adr_i;
  input  [31:0] wbm_dat_i;
  output reg [31:0] wbm_dat_o;
  output reg wbm_ack_o;
  output reg wbm_err_o;

  output reg [NUM_SLAVES - 1:0] wbs_cyc_o;
  output reg [NUM_SLAVES - 1:0] wbs_stb_o;
  output reg wbs_we_o;
  output reg [3:0] wbs_sel_o;
  output reg [31:0] wbs_adr_o;
  output reg [31:0] wbs_dat_o;
  input  [NUM_SLAVES*32 - 1:0] wbs_dat_i;
  input  [NUM_SLAVES - 1:0] wbs_ack_i;
  input  [NUM_SLAVES - 1:0] wbs_err_i;

  reg        wbm_cyc_i_r;
  reg        wbm_stb_i_r;
  reg        wbm_we_i_r;
  reg  [3:0] wbm_sel_i_r;
  reg [31:0] wbm_adr_i_r;
  reg [31:0] wbm_dat_i_r;
  wire [31:0] wbm_dat_o_r;
  reg [31:0] wbm_dat_o_r_reg;
  wire       wbm_ack_o_r;
  reg        wbm_err_o_r;

  wire                       wbs_we_o_r;
  wire                 [3:0] wbs_sel_o_r;
  wire                [31:0] wbs_adr_o_r;
  wire                [31:0] wbs_dat_o_r;
  reg     [NUM_SLAVES - 1:0] wbs_cyc_o_r;
  wire    [NUM_SLAVES - 1:0] wbs_stb_o_r;
  reg    [NUM_SLAVES - 1:0] wbs_ack_i_r;
  reg    [NUM_SLAVES - 1:0] wbs_err_i_r;
  reg [NUM_SLAVES*32 - 1:0] wbs_dat_i_r;
  
  //Added for timing closure purposes
  always @(posedge wb_clk_i) begin
    wbm_cyc_i_r <= wbm_cyc_i;
    wbm_stb_i_r <= wbm_stb_i;
    wbm_we_i_r  <= wbm_we_i;
    wbm_sel_i_r <= wbm_sel_i;
    wbm_adr_i_r <= wbm_adr_i;
    wbm_dat_i_r <= wbm_dat_i;
    wbm_dat_o   <= wbm_dat_o_r;
    wbm_ack_o   <= wbm_ack_o_r;
    wbm_err_o   <= wbm_err_o_r;
    wbs_cyc_o   <= wbs_cyc_o_r;
    wbs_stb_o   <= wbs_stb_o_r;
    wbs_we_o    <= wbs_we_o_r;
    wbs_sel_o   <= wbs_sel_o_r;
    wbs_adr_o   <= wbs_adr_o_r;
    wbs_dat_o   <= wbs_dat_o_r;
    wbs_dat_i_r <= wbs_dat_i;
    wbs_ack_i_r <= wbs_ack_i;
    wbs_err_i_r <= wbs_err_i;
  end
 
  /************************* Function Defines **************************/
  function [NUM_SLAVES-1:0] encode;
    input [NUM_SLAVES-1:0] in;

    integer trans;
    begin
      encode = 0; //default condition
      for (trans=0; trans < NUM_SLAVES; trans=trans+1) begin
        if (in[trans]) begin
          encode = trans;
        end
      end
    end
  endfunction


  /************************** Common Signals ***************************/

  wire [NUM_SLAVES - 1:0] wbs_sel;
  reg  [NUM_SLAVES - 1:0] wbs_sel_reg;
  reg  [NUM_SLAVES - 1:0] wbs_active;

  wire timeout_reset;
  wire timeout;

  /************************ Timeout Monitoring **************************/

  timeout #(
    .TIMEOUT(TIMEOUT)
  ) timeout_inst (
    .clk(wb_clk_i), .reset(wb_rst_i | timeout_reset),
    .timeout(timeout)
  );
  
    /************************ ILA Monitoring **************************/
 
  //wire [9:0] masterwbcntrl;
  //wire [9:0] slavewb1;
  //wire [31:0] wbm_dat_in;
  //wire [31:0] wbm_dat_out;
  //wire [31:0] wbm_add_in;
  //wire [31:0] wbs_dat_in;
  //wire [31:0] wbs_dat_out;
  //wire [31:0] wbs_add_out;
  //wire [31:0] slavewb2;
  //wire [31:0] temp2;
 
  //ila_0 ila_0_inst(
  //.clk(wb_clk_i),
  //.probe0(masterwbcntrl), //10 bit input
  //.probe1(wbm_dat_in), //32 bit input
  //.probe2(wbm_dat_out), //32 bit input
  //.probe3(wbm_add_in), //32 bit input
  //.probe4(slavewb1), //10 bit input
  //.probe5(wbs_dat_in), //32 bit input
  //.probe6(wbs_dat_out), //32 bit input
  //.probe7(wbs_add_out), //32 bit input
  //.probe8(slavewb2), //32 bit input
  //.probe9(temp2) //32 bit input 
  //);
  
  //assign masterwbcntrl = {wbm_err_o, wbm_ack_o,wbm_sel_i[3:0], wbm_we_i, wbm_stb_i, wbm_cyc_i, wb_rst_i};
  //assign slavewb1 = {4'b0, wbs_sel_o[3:0], wbs_we_o, wb_rst_i};
  //assign wbm_dat_in = wbm_dat_i;
  //assign wbm_dat_out = wbm_dat_o;
  //assign wbm_add_in = wbm_adr_i;
  //assign wbs_dat_in = wbs_dat_i[31:0];
  //assign wbs_dat_out = wbs_dat_o;
  //assign wbs_add_out = wbs_adr_o;
  //assign slavewb2 = {8'b0 ,wbs_stb_o[12:0], wbs_cyc_o[12:0]};
  //assign temp2 = wbs_adr_o_diff;
    
  /*********************** WB Slave Arbitration **************************/
  assign wbs_sel_o_r = wbm_sel_i_r2;
 

  /* Generate wbs_sel from wbm_adr_i and SLAVE_ADDR & SLAVE_HIGH ie 001 -> slave 0 sel, 100 -> slave 2 sel*/
//  genvar gen_i;
//  generate for (gen_i=0; gen_i < NUM_SLAVES; gen_i=gen_i+1) begin : G0
//    assign wbs_sel[gen_i] = wbm_adr_i_r[32 - 1:0] >= SLAVE_ADDR[32*(gen_i+1) - 1:32*(gen_i)] &&
//                            wbm_adr_i_r[32 - 1:0] <= SLAVE_HIGH[32*(gen_i+1) - 1:32*(gen_i)];
//  end endgenerate

  //AI: Adding pipelining to the for loops
  genvar gen_i;
  generate for (gen_i=0; gen_i < NUM_SLAVES; gen_i=gen_i+1) begin : G0
     always @ (posedge wb_clk_i) begin   
        wbs_sel_reg[gen_i] = wbm_adr_i_r[32 - 1:0] >= SLAVE_ADDR[32*(gen_i+1) - 1:32*(gen_i)] &&
                             wbm_adr_i_r[32 - 1:0] <= SLAVE_HIGH[32*(gen_i+1) - 1:32*(gen_i)];
     end                          
  end endgenerate
  
  reg        wbm_cyc_i_r1;
  reg        wbm_cyc_i_r2;
  reg        wbm_stb_i_r1;
  reg        wbm_stb_i_r2;
  reg        wbm_we_i_r1;
  reg        wbm_we_i_r2;
  reg  [3:0] wbm_sel_i_r1;
  reg  [3:0] wbm_sel_i_r2;
  reg [31:0] wbm_adr_i_r1;
  reg [31:0] wbm_adr_i_r2;
  reg [31:0] wbm_dat_i_r1;
  reg [31:0] wbm_dat_i_r2;
  reg [NUM_SLAVES*32 - 1:0] wbs_dat_i_r1;
  reg [NUM_SLAVES*32 - 1:0] wbs_dat_i_r2;
  reg [NUM_SLAVES - 1:0] wbs_ack_i_r1;  
  reg [NUM_SLAVES - 1:0] wbs_ack_i_r2; 
  reg [NUM_SLAVES - 1:0] wbs_err_i_r1;   
  reg [NUM_SLAVES - 1:0] wbs_err_i_r2; 
  reg [NUM_SLAVES - 1:0] wbs_sel_reg1;   
  
  assign wbs_sel = wbs_sel_reg;

  wire [NUM_SLAVES-1:0] wbs_sel_enc = encode(wbs_sel); //this is the encoded value ie 10 -> 2, 100 -> 3 etc
    
  //Adding in Data Alignment since I am pipelining the for loops to meet timing  
  always @(posedge wb_clk_i) begin
    wbm_cyc_i_r1 <= wbm_cyc_i_r;
    wbm_cyc_i_r2 <= wbm_cyc_i_r1;
    
    wbm_stb_i_r1 <= wbm_stb_i_r;
    wbm_stb_i_r2 <= wbm_stb_i_r1;
    
    wbm_we_i_r1  <= wbm_we_i_r;
    wbm_we_i_r2  <= wbm_we_i_r1;
        
    wbm_sel_i_r1 <= wbm_sel_i_r;
    wbm_sel_i_r2 <= wbm_sel_i_r1;
        
    wbm_adr_i_r1 <= wbm_adr_i_r;
    wbm_adr_i_r2 <= wbm_adr_i_r1;

    wbm_dat_i_r1 <= wbm_dat_i_r;
    wbm_dat_i_r2 <= wbm_dat_i_r1;
        
    wbs_dat_i_r1 <= wbs_dat_i_r;
    wbs_dat_i_r2 <= wbs_dat_i_r1;
    
    wbs_ack_i_r1 <= wbs_ack_i_r;
    wbs_ack_i_r2 <= wbs_ack_i_r1;
    
    wbs_err_i_r1 <= wbs_err_i_r;
    wbs_err_i_r2 <= wbs_err_i_r1;
    
    wbs_sel_reg1 <= wbs_sel_reg;
    
  end 
  

  /* Generate wbs_adr_o from wbm_adr_i and wbs_sel */
  wire [31:0] wbs_adr_o_int;
  wire [31:0] wbs_adr_o_diff;
  reg [31:0] wbs_adr_o_diff_reg;  

  assign wbs_adr_o_int = wbm_adr_i_r2 - wbs_adr_o_diff;

//  genvar gen_j;
//  generate for (gen_j=0; gen_j < 32; gen_j=gen_j+1) begin : G1
//    assign wbs_adr_o_diff[gen_j] = SLAVE_ADDR[32*wbs_sel_enc + gen_j];
//  end endgenerate
  
  //AI: Adding pipelining to the for loops
  genvar gen_j;
  generate for (gen_j=0; gen_j < 32; gen_j=gen_j+1) begin : G1
     always @ (posedge wb_clk_i) begin   
       wbs_adr_o_diff_reg[gen_j] = SLAVE_ADDR[32*wbs_sel_enc + gen_j];
     end  
  end endgenerate
  
  assign wbs_adr_o_diff = wbs_adr_o_diff_reg;
  

  reg  [31:0] wbs_adr_o_reg;
  assign wbs_adr_o_r = wbs_adr_o_reg;

  /* Generate wbm_dat_o from wbs_sel_enc */
//  genvar gen_k;
//  generate for (gen_k=0; gen_k < 32; gen_k=gen_k+1) begin : G2
//    assign wbm_dat_o_r[gen_k] = wbs_dat_i_r[32*wbs_sel_enc + gen_k];
//  end endgenerate
  //AI: Adding pipelining to the for loops
  genvar gen_k;
  generate for (gen_k=0; gen_k < 32; gen_k=gen_k+1) begin : G2
     always @ (posedge wb_clk_i) begin 
       wbm_dat_o_r_reg[gen_k] = wbs_dat_i_r1[32*wbs_sel_enc + gen_k]; 
     end
  end endgenerate
  
  assign wbm_dat_o_r = wbm_dat_o_r_reg;    

  assign wbm_ack_o_r = (wbs_ack_i_r2 & wbs_active) != {NUM_SLAVES{1'b0}};

  assign wbs_we_o_r = wbm_we_i_r2;
  assign wbs_dat_o_r = wbm_dat_i_r2;

  //reg wbm_err_o;

  reg [NUM_SLAVES - 1:0] wbs_cyc_o_r;
  assign wbs_stb_o_r = wbs_cyc_o_r;

  reg state;
  localparam STATE_IDLE   = 2'd0;
  localparam STATE_WAIT   = 2'd1;

  assign timeout_reset = ~(state == STATE_WAIT);
  
  always @(posedge wb_clk_i) begin
    /* strobes */
    wbs_cyc_o_r <= {NUM_SLAVES{1'b0}};
    wbm_err_o_r <= 1'b0;

    if (wb_rst_i) begin
      state <= STATE_IDLE;
      wbs_active <= {NUM_SLAVES{1'b0}};
    end else begin
      case (state)
        STATE_IDLE: begin
          if (wbm_cyc_i_r2 & wbm_stb_i_r2) begin
            if (wbs_sel_reg1 == {NUM_SLAVES{1'b0}}) begin
              wbm_err_o_r <= 1'b1;
            end else begin
              wbs_active <= wbs_sel_reg1;
              wbs_adr_o_reg <= wbs_adr_o_int;
              wbs_cyc_o_r <= wbs_sel_reg1;
              state <= STATE_WAIT;
            end
`ifdef DEBUG
            $display("wb_arb: got event, wbs_sel = %x",wbs_sel_reg1);
`endif
          end else begin
            //wbs_active <= {NUM_SLAVES{1'b0}};
            /* this delayed clear is intentional as the wbm_ack depends on the value */
          end
        end
        STATE_WAIT: begin
          if (wbs_ack_i_r2 & wbs_active) begin
            state <= STATE_IDLE;
`ifdef DEBUG
            $display("wb_arb: got ack");
`endif
          end else if (timeout) begin
            wbm_err_o_r <= 1'b1;
            state <= STATE_IDLE;
`ifdef DEBUG
            $display("wb_arb: bus timeout");
`endif
          end
        end
      endcase
    end
  end
  
endmodule
