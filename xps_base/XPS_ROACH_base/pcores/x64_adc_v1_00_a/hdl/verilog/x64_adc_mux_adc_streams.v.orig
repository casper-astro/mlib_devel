module x64_adc_mux_adc_streams (
  input            clk,        
  input    [95:0]  din,        
  input            dinvld,     
  output   [23:0]  dout,       
  output           doutvld,    
  output           dout_sync   
);

  reg [24:0] word0;
  reg [24:0] word1;
  reg [24:0] word2;
  reg [24:0] word3;
  reg sync_reg;
 
  /* Parallel load, serial out shift register */
  // The dinvld signal has a huge fanout here -- can cause
  // timing issues
  
  // synthesis attribute MAX_FANOUT of dinvld is 12
  // synthesis attribute shreg_extract of word0 is NO
  // synthesis attribute shreg_extract of word1 is NO
  // synthesis attribute shreg_extract of word2 is NO
  // synthesis attribute shreg_extract of word3 is NO
  always @(posedge clk) begin
    if (dinvld) begin
      word0    <= {1'b1, din[24*1 -1:24*0]};
      word1    <= {1'b1, din[24*2 -1:24*1]};
      word2    <= {1'b1, din[24*3 -1:24*2]};
      word3    <= {1'b1, din[24*4 -1:24*3]};
      sync_reg <=  1'b1;
    end else begin
      word0     <= word1;
      word1     <= word2;
      word2     <= word3;
      word3     <= 25'b0;
      sync_reg  <= 1'b0;
    end
  end
  
  assign dout      = word0[23:0];
  assign doutvld   = word0[24];
  assign dout_sync = sync_reg;

/*
  reg [2:0] ctr
  reg       doutvld_reg

  always @(posedge clk) begin
    if (rst == 1) begin
      doutvld_reg <= 1'b0;
    end else if (dinvld) begin
      doutvld_reg <= 1'b1;
      ctr         <= 2'b0;
    end else 
      ctr <= ctr + 1;
    end
    if (ctr == 3) begin
      doutvld_reg <= 1'b0;
  end
  assign doutvld = doutvld_reg;
*/
endmodule
