`timescale 1ps / 1ps
`default_nettype none

(* DowngradeIPIdentifiedWarnings="yes" *)
module cmac_usplus_reset_wrapper (
  input wire logic gt_txusrclk2,
  input wire logic gt_rxusrclk2,
  input wire logic rx_clk,
  input wire logic gt_tx_reset_in,
  input wire logic gt_rx_reset_in,
  input wire logic core_drp_reset,
  input wire logic core_tx_reset,
  output logic        tx_reset_out,
  input wire logic core_rx_reset,
  output logic        rx_reset_out,
  output logic [9:0]  rx_serdes_reset_out,
  output logic        usr_tx_reset,
  output logic        usr_rx_reset
);

  logic tx_reset_done;
  logic tx_reset_done_sync_txusrclk2;
  logic gt_txresetdone_int;
  logic gt_txresetdone_int_sync;
  logic gt_tx_reset_done_inv;

  logic rx_reset_done;
  logic rx_reset_done_sync_rx_clk;
  logic gt_rxresetdone_int;
  logic gt_rxresetdone_int_sync;
  logic gt_rx_reset_done_inv;
  logic gt_rx_reset_done_inv_reg;
  logic gt_rx_reset_done_inv_reg_sync;
  logic reset_done_async;
  logic [9:0] rx_serdes_reset_done;

  assign gt_txresetdone_int = gt_tx_reset_in;

  cmac_usplus_cdc_sync cmac_cdc_sync_gt_txresetdone_int (
   .clk              (gt_txusrclk2),
   .signal_in        (gt_txresetdone_int), 
   .signal_out       (gt_txresetdone_int_sync)
  );

  logic core_drp_reset_tx_clk_sync;
  logic core_tx_reset_sync;

  cmac_usplus_cdc_sync cmac_cdc_sync_core_drp_reset_tx_clk (
   .clk              (gt_txusrclk2),
   .signal_in        (core_drp_reset), 
   .signal_out       (core_drp_reset_tx_clk_sync)
  );

  cmac_usplus_cdc_sync cmac_cdc_sync_core_tx_reset (
   .clk              (gt_txusrclk2),
   .signal_in        (core_tx_reset), 
   .signal_out       (core_tx_reset_sync)
  );

  assign gt_tx_reset_done_inv  =  ~(gt_txresetdone_int_sync);
  assign tx_reset_done         =  gt_tx_reset_done_inv | core_drp_reset_tx_clk_sync | core_tx_reset_sync;

  cmac_usplus_cdc_sync cmac_cdc_sync_tx_reset_done_txusrclk2 (
   .clk              (gt_txusrclk2),
   .signal_in        (tx_reset_done), 
   .signal_out       (tx_reset_done_sync_txusrclk2)
  );

  assign usr_tx_reset = tx_reset_done_sync_txusrclk2;
  assign tx_reset_out = tx_reset_done_sync_txusrclk2;

  assign gt_rxresetdone_int  = gt_rx_reset_in;
  assign rx_serdes_reset_out = rx_serdes_reset_done;

  cmac_usplus_cdc_sync cmac_cdc_sync_gt_rxresetdone_int (
   .clk              (rx_clk),
   .signal_in        (gt_rxresetdone_int), 
   .signal_out       (gt_rxresetdone_int_sync)
  );

  logic core_drp_reset_rx_clk_sync;
  logic core_rx_reset_sync;

  cmac_usplus_cdc_sync i_cmac_usplus_0_exdes_cmac_cdc_sync_core_drp_reset_rx_clk (
   .clk              (rx_clk),
   .signal_in        (core_drp_reset), 
   .signal_out       (core_drp_reset_rx_clk_sync)
  );

  cmac_usplus_cdc_sync cmac_cdc_sync_core_rx_reset (
   .clk              (rx_clk),
   .signal_in        (core_rx_reset), 
   .signal_out       (core_rx_reset_sync)
  );

  assign gt_rx_reset_done_inv =  ~(gt_rxresetdone_int_sync);
  assign rx_reset_done        =  gt_rx_reset_done_inv | core_drp_reset_rx_clk_sync | core_rx_reset_sync;

  cmac_usplus_cdc_sync cmac_cdc_sync_rx_reset_done_rx_clk (
   .clk              (rx_clk),
   .signal_in        (rx_reset_done), 
   .signal_out       (rx_reset_done_sync_rx_clk)
  );

  assign usr_rx_reset = rx_reset_done_sync_rx_clk;
  assign rx_reset_out = rx_reset_done_sync_rx_clk;

  always_ff @(posedge rx_clk) begin
    gt_rx_reset_done_inv_reg <= gt_rx_reset_done_inv;
  end

  cmac_usplus_cdc_sync cmac_cdc_sync_gt_rxresetdone_reg_rxusrclk2 (
   .clk              (gt_rxusrclk2),
   .signal_in        (gt_rx_reset_done_inv_reg), 
   .signal_out       (gt_rx_reset_done_inv_reg_sync)
  );
  
  logic core_drp_reset_serdes_clk_sync;

  cmac_usplus_cdc_sync cmac_cdc_sync_gt_txresetdone_int3 (
   .clk              (gt_rxusrclk2),
   .signal_in        (core_drp_reset), 
   .signal_out       (core_drp_reset_serdes_clk_sync)
  );

  assign reset_done_async = gt_rx_reset_done_inv_reg_sync | core_drp_reset_serdes_clk_sync;

  assign rx_serdes_reset_done[0] = reset_done_async;
  assign rx_serdes_reset_done[1] = reset_done_async;
  assign rx_serdes_reset_done[2] = reset_done_async;
  assign rx_serdes_reset_done[3] = reset_done_async;
  assign rx_serdes_reset_done[4] = 1'b1;
  assign rx_serdes_reset_done[5] = 1'b1;
  assign rx_serdes_reset_done[6] = 1'b1;
  assign rx_serdes_reset_done[7] = 1'b1;
  assign rx_serdes_reset_done[8] = 1'b1;
  assign rx_serdes_reset_done[9] = 1'b1;

endmodule : cmac_usplus_reset_wrapper


(* DowngradeIPIdentifiedWarnings="yes" *)
module cmac_usplus_cdc_sync (
  input wire logic clk,
  input wire logic signal_in,
  output logic signal_out
);
  
  logic sig_in_cdc_from;
  (* ASYNC_REG = "TRUE" *) logic s_out_d2_cdc_to;
  (* ASYNC_REG = "TRUE" *) logic s_out_d3;
  (* max_fanout = 500 *)   logic s_out_d4;
      
// synthesis translate_off
      
  initial s_out_d2_cdc_to = 1'b0;
  initial s_out_d3        = 1'b0;
  initial s_out_d4        = 1'b0;
      
// synthesis translate_on   
   
  assign sig_in_cdc_from = signal_in;
  assign signal_out      = s_out_d4;
      
  always_ff @(posedge clk) begin
    s_out_d4         <= s_out_d3;
    s_out_d3         <= s_out_d2_cdc_to;
    s_out_d2_cdc_to  <= sig_in_cdc_from;
  end
  
endmodule : cmac_usplus_cdc_sync

