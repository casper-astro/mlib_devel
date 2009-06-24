`timescale 1ns/1ps
module ten_gig_eth_mac_UCB(
    input  reset,
    input  tx_clk0,
    input  tx_dcm_lock,
    input  rx_clk0,
    input  rx_dcm_lock,
    // transmit interface
    output tx_underrun,
    input  [63:0] tx_data,
    input   [7:0] tx_data_valid,
    input  tx_start,
    output tx_ack,
    output tx_ifg_delay,
    output tx_statistics_vector,
    output tx_statistics_valid,
    // receive interface
    output [63:0] rx_data,
    output  [7:0] rx_data_valid,
    output rx_good_frame,
    output rx_bad_frame,
    output rx_statistics_vector,
    output rx_statistics_valid,
    // flow_control interface
    output pause_val,
    output pause_req,
    // configuration
    output configuration_vector,
    // phy interface
    output [63:0] xgmii_txd,
    output  [7:0] xgmii_txc,
    input  [63:0] xgmii_rxd,
    input   [7:0] xgmii_rxc            
  );
  reg start;
  assign tx_ack = 1'b1;
  always @(posedge tx_clk0) begin
    if (reset) begin
     start <= 0;
    end else begin
      if (tx_start) begin
        start <= 1'b1;
`ifdef DEBUG
        $display("mac: got start of frame");
`endif
      end
      if (start) begin
        if (tx_data_valid != 8'b1111_1111) begin
          start <= 1'b0;
`ifdef DEBUG
          $display("mac: got end of frame - %b", tx_data_valid);
`endif
        end
      end

    end
  end
  assign xgmii_txc = start ? {8{1'b0}} : {8{1'b1}};
  assign xgmii_txd = tx_data;
endmodule
