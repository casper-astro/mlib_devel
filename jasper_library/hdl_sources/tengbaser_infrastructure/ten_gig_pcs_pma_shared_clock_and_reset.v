`timescale 1ns / 1ps

(* DowngradeIPIdentifiedWarnings="yes" *)
module  ten_gig_pcs_pma_5_shared_clock_and_reset
    (
     input  areset,
     input  refclk_p,
     input  refclk_n,
     output refclk,   
     output refclk_bufh,   
     output dclk,   
     output clk156,   
     
     input  txclk322,
     input  qplllock,         
     output wire areset_clk156,
     output gttxreset,
     output gtrxreset,
     output reg txuserrdy,
     output txusrclk,
     output txusrclk2,     
     
     output qpllreset,
     output reset_counter_done
    );

  wire clk156_buf;
  wire qplllock_txusrclk2;
  reg [7:0] reset_counter = 8'h00;
  reg [3:0] reset_pulse = 4'b1110;
  wire gttxreset_txusrclk2;
  assign reset_counter_done = reset_counter[7];
  

   
  IBUFDS_GTE2 ibufds_inst  
  (
      .O     (refclk),
      .ODIV2 (),
      .CEB   (1'b0),
      .I     (refclk_p),
      .IB    (refclk_n)
  );

  BUFG tx322clk_bufg_i
  (
      .I (txclk322),
      .O (txusrclk)
  );

  wire refclk_bufh_int;
  assign refclk_bufh = refclk_bufh_int;
  BUFH refclk_bufg_inst 
  (
      .I                              (refclk),
      .O                              (refclk_bufh_int) 
  );

 // MMCM to generate both clk156 and dclk
  wire mmcm_clk_fb;
  wire dclk_buf;
  MMCME2_BASE #
  (
    .BANDWIDTH            ("OPTIMIZED"),
    .STARTUP_WAIT         ("FALSE"),
    .DIVCLK_DIVIDE        (1),
    .CLKFBOUT_MULT_F      (4.0),
    .CLKFBOUT_PHASE       (0.000),
    .CLKOUT0_DIVIDE_F     (4.000),
    .CLKOUT0_PHASE        (0.000),
    .CLKOUT0_DUTY_CYCLE   (0.500),
    .CLKIN1_PERIOD        (6.400),
    .CLKOUT1_DIVIDE       (8),
    .CLKOUT1_PHASE        (0.000),
    .CLKOUT1_DUTY_CYCLE   (0.500),
    .REF_JITTER1          (0.010)
  )
  clkgen_i
  (
    .CLKFBIN(mmcm_clk_fb),
    .CLKIN1(refclk_bufh),
    .PWRDWN(1'b0),
    .RST(!qplllock),
    .CLKFBOUT(mmcm_clk_fb),
    .CLKOUT0(clk156_buf),
    .CLKOUT1(dclk_buf),
    .LOCKED(mmcm_locked)
  );

  BUFG clk156_bufg_inst 
  (
      .I                              (clk156_buf),
      .O                              (clk156) 
  );

  BUFG dclk_bufg_inst 
  (
      .I                              (dclk_buf),
      .O                              (dclk) 
  ); 

     
  assign txusrclk2 = txusrclk;
  
    
  // Asynch reset synchronizers...
  
           
  ten_gig_pcs_pma_5_ff_synchronizer_rst2 
    #(
      .C_NUM_SYNC_REGS(4),
      .C_RVAL(1'b1)) 
  areset_clk156_sync_i
    (
     .clk(clk156),
     .rst(areset),
     .data_in(1'b0),
     .data_out(areset_clk156)
    );
            
  ten_gig_pcs_pma_5_ff_synchronizer_rst2 
    #(
      .C_NUM_SYNC_REGS(4),
      .C_RVAL(1'b0)) 
  qplllock_txusrclk2_sync_i
    (
     .clk(txusrclk2),
     .rst(!qplllock),
     .data_in(1'b1),
     .data_out(qplllock_txusrclk2)
    );

  
    
  // Hold off the GT resets until 500ns after configuration.
  // 128 ticks at 6.4ns period will be >> 500 ns.

  always @(posedge refclk_bufh)
  begin
    if (!reset_counter[7])
      reset_counter   <=   reset_counter + 1'b1;   
    else
      reset_counter   <=   reset_counter;
  end

  always @(posedge refclk_bufh)
  begin
    if (areset_clk156 == 1'b1)  
      reset_pulse   <=   4'b1110;
    else if(reset_counter[7])
      reset_pulse   <=   {1'b0, reset_pulse[3:1]};
  end
  assign   qpllreset  =     reset_pulse[0];
  assign   gttxreset  =     reset_pulse[0];
  assign   gtrxreset  =     reset_pulse[0];  

  ten_gig_pcs_pma_5_ff_synchronizer_rst2 
    #(
      .C_NUM_SYNC_REGS(4),
      .C_RVAL(1'b1)) 
  gttxreset_txusrclk2_sync_i
    (
     .clk(txusrclk2),
     .rst(gttxreset),
     .data_in(1'b0),
     .data_out(gttxreset_txusrclk2)
    );
            
  always @(posedge txusrclk2 or posedge gttxreset_txusrclk2)
  begin
     if(gttxreset_txusrclk2)
       txuserrdy <= 1'b0;
     else
       txuserrdy <= qplllock_txusrclk2;
  end

endmodule




