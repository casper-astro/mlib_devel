`timescale 1ns/1ps
module hmc_wb_attach #(
    parameter HMC_RF_RWIDTH   = 64,
    parameter HMC_RF_AWIDTH   = 5
  )(
    //wishbone interface 
    input wire   wb_clk_i,
    input wire   wb_rst_i,
    output wire [31:0] wb_dat_o,
    output wire  wb_err_o,
    output wire  wb_ack_o,
    input  wire [31:0] wb_adr_i,
    input  wire [3:0]  wb_sel_i,
    input  wire [31:0] wb_dat_i,
    input  wire  wb_we_i,
    input  wire  wb_cyc_i,
    input  wire  wb_stb_i,   

    //OpenHMC link 2 registers (RF) 
    //(hmc_link2_clk)
    input wire [HMC_RF_RWIDTH-1:0] rf_read_data_link2,
    input wire [HMC_RF_AWIDTH-1:0] rf_address_link2,
    input wire  rf_access_complete_link2,
    input wire [15:0] rx_crc_err_cnt_link2,

    //OpenHMC link 3 registers (RF) 
    //(hmc_link3_clk)
    input wire [HMC_RF_RWIDTH-1:0] rf_read_data_link3,
    input wire [HMC_RF_AWIDTH-1:0] rf_address_link3,
    input wire  rf_access_complete_link3,
    input wire [15:0] rx_crc_err_cnt_link3,
    

    //HMC Status (user_clk)
    input wire post_ok,
    input wire init_done,
    input wire hmc_ok,
    input wire [3:0] flit_err_resp_link2,
    input wire [3:0] flit_err_resp_link3,
    input wire [6:0] errstat_link2,
    input wire [6:0] errstat_link3,
    
    
    //Clocks
    input wire user_clk,
    input wire hmc_link2_clk,
    input wire hmc_link3_clk,
    
    //Resets
    input wire user_rst,
    input wire hmc_link2_rst,
    input wire hmc_link3_rst    
    
  );



  /************** Registers ****************/
  
  //OpenHMC Status & Control Registers
  //General HMC controller status - 64 bits
  localparam REG_OPEN_HMC_STAT_GEN                  = 5'd0;
  //Debug register for initialisation - 64 bits
  localparam REG_OPEN_HMC_STAT_INIT                 = 5'd1;
  //Control register - 64 bits
  localparam REG_OPEN_HMC_CTRL                      = 5'd2;
  //Number of posted requests issued - 64 bits
  localparam REG_OPEN_HMC_SENT_P                    = 5'd3;
  //Number of non-posted requests issued - 64 bits
  localparam REG_OPEN_HMC_SENT_NP                   = 5'd4;
  //Number of read requests issued - 64 bits
  localparam REG_OPEN_HMC_SENT_R                    = 5'd5;
  //Number of poisoned packets received - 64 bits
  //(controller inverts CRC of packet due to issue)
  localparam REG_OPEN_HMC_POISONED_PACKET           = 5'd6;
  //Number of responses received - 64 bits  
  localparam REG_OPEN_HMC_RCVD_RSP                  = 5'd7;
  //Number of link retries performed on TX - 64 bits
  //(FPGA to HMC CRC errors increment this counter)
  localparam REG_OPEN_HMC_TX_LINK_RETRIES           = 5'd9;
  //Number of errors seen on RX - 64 bits
  //(HMC to FPGA CRC errors increment this counter -
  //the same as our current CRC error counter)
  localparam REG_OPEN_HMC_ERR_ON_RX                 = 5'd10;
  //Number of bit flips performed due to run length 
  //limitation - 64 bits
  localparam REG_OPEN_HMC_RUN_LNGTH_BIT_FLIP        = 5'd11;
  //Number of error_abort_mode not cleared - represents the
  //most important counter to monitor. If this is zero then
  //all retries after CRC errors were successful and if > 0 then
  //data issue occured - 64 bits
  localparam REG_OPEN_HMC_ERR_ABORT_NOT_CLR         = 5'd12;
  
  
  //Link 2
  //General HMC controller status - 64 bits
  localparam REG_OPEN_HMC_STAT_GEN_LOW_LINK2                  = 6'd0;
  localparam REG_OPEN_HMC_STAT_GEN_HIGH_LINK2                 = 6'd1;
  //Debug register for initialisation - 64 bits
  localparam REG_OPEN_HMC_STAT_INIT_LOW_LINK2                 = 6'd2;
  localparam REG_OPEN_HMC_STAT_INIT_HIGH_LINK2                = 6'd3;
  //Control register - 64 bits
  localparam REG_OPEN_HMC_CTRL_LOW_LINK2                      = 6'd4;
  localparam REG_OPEN_HMC_CTRL_HIGH_LINK2                     = 6'd5;
  //Number of posted requests issued - 64 bits
  localparam REG_OPEN_HMC_SENT_P_LOW_LINK2                    = 6'd6;
  localparam REG_OPEN_HMC_SENT_P_HIGH_LINK2                   = 6'd7;
  //Number of non-posted requests issued - 64 bits
  localparam REG_OPEN_HMC_SENT_NP_LOW_LINK2                   = 6'd8;
  localparam REG_OPEN_HMC_SENT_NP_HIGH_LINK2                  = 6'd9;
  //Number of read requests issued - 64 bits
  localparam REG_OPEN_HMC_SENT_R_LOW_LINK2                    = 6'd10;
  localparam REG_OPEN_HMC_SENT_R_HIGH_LINK2                   = 6'd11;
  //Number of poisoned packets received - 64 bits
  //(controller inverts CRC of packet due to issue)
  localparam REG_OPEN_HMC_POISONED_PACKET_LOW_LINK2           = 6'd12;
  localparam REG_OPEN_HMC_POISONED_PACKET_HIGH_LINK2          = 6'd13;
  //Number of responses received - 64 bits  
  localparam REG_OPEN_HMC_RCVD_RSP_LOW_LINK2                  = 6'd14;
  localparam REG_OPEN_HMC_RCVD_RSP_HIGH_LINK2                 = 6'd15;
  //Number of link retries performed on TX - 64 bits
  //(FPGA to HMC CRC errors increment this counter)
  localparam REG_OPEN_HMC_TX_LINK_RETRIES_LOW_LINK2           = 6'd16;
  localparam REG_OPEN_HMC_TX_LINK_RETRIES_HIGH_LINK2          = 6'd17;
  //Number of errors seen on RX - 64 bits
  //(HMC to FPGA CRC errors increment this counter -
  //the same as our current CRC error counter)
  localparam REG_OPEN_HMC_ERR_ON_RX_LOW_LINK2                 = 6'd18;
  localparam REG_OPEN_HMC_ERR_ON_RX_HIGH_LINK2                = 6'd19;
  //Number of bit flips performed due to run length 
  //limitation - 64 bits
  localparam REG_OPEN_HMC_RUN_LNGTH_BIT_FLIP_LOW_LINK2        = 6'd20;
  localparam REG_OPEN_HMC_RUN_LNGTH_BIT_FLIP_HIGH_LINK2       = 6'd21; 
  //Number of error_abort_mode not cleared - represents the
  //most important counter to monitor. If this is zero then
  //all retries after CRC errors were successful and if > 0 then
  //data issue occured - 64 bits
  localparam REG_OPEN_HMC_ERR_ABORT_NOT_CLR_LOW_LINK2         = 6'd22;
  localparam REG_OPEN_HMC_ERR_ABORT_NOT_CLR_HIGH_LINK2        = 6'd23;
  //4 bit error response packet FLIT register. If any CRC issue 
  //occurred then this flag will assert the error FLIT bit.
  localparam REG_HMC_ERR_RSP_PACKET_LINK2                     = 6'd24;
  //7 bit ERRSTAT register. This reports the status of any
  //issue with the HMC device itself and should remain zero
  localparam REG_HMC_ERRSTAT_LINK2                            = 6'd25;
  //16 bit CRC error count register. This is incremented each
  //time a CRC error occurs and does not include retries
  localparam REG_HMC_CRC_ERR_CNT_LINK2                        = 6'd26;
  
  
  //Link 3
  //General HMC controller status - 64 bits
  localparam REG_OPEN_HMC_STAT_GEN_LOW_LINK3                  = 6'd27;
  localparam REG_OPEN_HMC_STAT_GEN_HIGH_LINK3                 = 6'd28;
  //Debug register for initialisation - 64 bits
  localparam REG_OPEN_HMC_STAT_INIT_LOW_LINK3                 = 6'd29;
  localparam REG_OPEN_HMC_STAT_INIT_HIGH_LINK3                = 6'd30;
  //Control register - 64 bits
  localparam REG_OPEN_HMC_CTRL_LOW_LINK3                      = 6'd31;
  localparam REG_OPEN_HMC_CTRL_HIGH_LINK3                     = 6'd32;
  //Number of posted requests issued - 64 bits
  localparam REG_OPEN_HMC_SENT_P_LOW_LINK3                    = 6'd33;
  localparam REG_OPEN_HMC_SENT_P_HIGH_LINK3                   = 6'd34;
  //Number of non-posted requests issued - 64 bits
  localparam REG_OPEN_HMC_SENT_NP_LOW_LINK3                   = 6'd35;
  localparam REG_OPEN_HMC_SENT_NP_HIGH_LINK3                  = 6'd36;
  //Number of read requests issued - 64 bits
  localparam REG_OPEN_HMC_SENT_R_LOW_LINK3                    = 6'd37;
  localparam REG_OPEN_HMC_SENT_R_HIGH_LINK3                   = 6'd38;
  //Number of poisoned packets received - 64 bits
  //(controller inverts CRC of packet due to issue)
  localparam REG_OPEN_HMC_POISONED_PACKET_LOW_LINK3           = 6'd39;
  localparam REG_OPEN_HMC_POISONED_PACKET_HIGH_LINK3          = 6'd40;
  //Number of responses received - 64 bits  
  localparam REG_OPEN_HMC_RCVD_RSP_LOW_LINK3                  = 6'd41;
  localparam REG_OPEN_HMC_RCVD_RSP_HIGH_LINK3                 = 6'd42;
  //Number of link retries performed on TX - 64 bits
  //(FPGA to HMC CRC errors increment this counter)
  localparam REG_OPEN_HMC_TX_LINK_RETRIES_LOW_LINK3           = 6'd43;
  localparam REG_OPEN_HMC_TX_LINK_RETRIES_HIGH_LINK3          = 6'd44;
  //Number of errors seen on RX - 64 bits
  //(HMC to FPGA CRC errors increment this counter -
  //the same as our current CRC error counter)
  localparam REG_OPEN_HMC_ERR_ON_RX_LOW_LINK3                 = 6'd45;
  localparam REG_OPEN_HMC_ERR_ON_RX_HIGH_LINK3                = 6'd46;
  //Number of bit flips performed due to run length 
  //limitation - 64 bits
  localparam REG_OPEN_HMC_RUN_LNGTH_BIT_FLIP_LOW_LINK3        = 6'd47;
  localparam REG_OPEN_HMC_RUN_LNGTH_BIT_FLIP_HIGH_LINK3       = 6'd48; 
  //Number of error_abort_mode not cleared - represents the
  //most important counter to monitor. If this is zero then
  //all retries after CRC errors were successful and if > 0 then 
  //data issue occured - 64 bits
  localparam REG_OPEN_HMC_ERR_ABORT_NOT_CLR_LOW_LINK3         = 6'd49;
  localparam REG_OPEN_HMC_ERR_ABORT_NOT_CLR_HIGH_LINK3        = 6'd50;
  //4 bit error response packet FLIT register. If any CRC issue 
  //occurred then this flag will assert the error FLIT bit.
  localparam REG_HMC_ERR_RSP_PACKET_LINK3                     = 6'd51;
  //7 bit ERRSTAT register. This reports the status of any
  //issue with the HMC device itself and should remain zero
  localparam REG_HMC_ERRSTAT_LINK3                            = 6'd52;
  //16 bit CRC error count register. This is incremented each
  //time a CRC error occurs and does not include retries
  localparam REG_HMC_CRC_ERR_CNT_LINK3                        = 6'd53;
  
  //General HMC Status Register 
  //(includes hmc_ok init_done, post_ok)
  localparam REG_HMC_STATUS                                   = 6'd54;
  
  
  //Define registers (clock domain crossing registers)
  //Link2
  wire [31:0] open_hmc_stat_gen_low_link2_cdc_reg;
  wire [31:0] open_hmc_stat_gen_high_link2_cdc_reg;
  wire [31:0] open_hmc_stat_init_low_link2_cdc_reg;
  wire [31:0] open_hmc_stat_init_high_link2_cdc_reg;
  wire [31:0] open_hmc_ctrl_low_link2_cdc_reg;
  wire [31:0] open_hmc_ctrl_high_link2_cdc_reg;
  wire [31:0] open_hmc_sent_p_low_link2_cdc_reg;
  wire [31:0] open_hmc_sent_p_high_link2_cdc_reg;
  wire [31:0] open_hmc_sent_np_low_link2_cdc_reg;
  wire [31:0] open_hmc_sent_np_high_link2_cdc_reg;
  wire [31:0] open_hmc_sent_r_low_link2_cdc_reg;
  wire [31:0] open_hmc_sent_r_high_link2_cdc_reg;
  wire [31:0] open_hmc_poisoned_packet_low_link2_cdc_reg;
  wire [31:0] open_hmc_poisoned_packet_high_link2_cdc_reg;
  wire [31:0] open_hmc_rcvd_rsp_low_link2_cdc_reg;
  wire [31:0] open_hmc_rcvd_rsp_high_link2_cdc_reg;
  wire [31:0] open_hmc_tx_link_retries_low_link2_cdc_reg;
  wire [31:0] open_hmc_tx_link_retries_high_link2_cdc_reg;
  wire [31:0] open_hmc_err_on_rx_low_link2_cdc_reg;
  wire [31:0] open_hmc_err_on_rx_high_link2_cdc_reg;
  wire [31:0] open_hmc_run_lngth_bit_flip_low_link2_cdc_reg;
  wire [31:0] open_hmc_run_lngth_bit_flip_high_link2_cdc_reg;
  wire [31:0] open_hmc_err_abort_not_clr_low_link2_cdc_reg;
  wire [31:0] open_hmc_err_abort_not_clr_high_link2_cdc_reg;
  wire [31:0] hmc_err_rsp_packet_link2_cdc_reg;
  wire [31:0] hmc_errstat_link2_cdc_reg;
  wire [31:0] hmc_crc_err_cnt_link2_cdc_reg;
  //Link3
  wire [31:0] open_hmc_stat_gen_low_link3_cdc_reg;
  wire [31:0] open_hmc_stat_gen_high_link3_cdc_reg;
  wire [31:0] open_hmc_stat_init_low_link3_cdc_reg;
  wire [31:0] open_hmc_stat_init_high_link3_cdc_reg;
  wire [31:0] open_hmc_ctrl_low_link3_cdc_reg;
  wire [31:0] open_hmc_ctrl_high_link3_cdc_reg;
  wire [31:0] open_hmc_sent_p_low_link3_cdc_reg;
  wire [31:0] open_hmc_sent_p_high_link3_cdc_reg;
  wire [31:0] open_hmc_sent_np_low_link3_cdc_reg;
  wire [31:0] open_hmc_sent_np_high_link3_cdc_reg;
  wire [31:0] open_hmc_sent_r_low_link3_cdc_reg;
  wire [31:0] open_hmc_sent_r_high_link3_cdc_reg;
  wire [31:0] open_hmc_poisoned_packet_low_link3_cdc_reg;
  wire [31:0] open_hmc_poisoned_packet_high_link3_cdc_reg;
  wire [31:0] open_hmc_rcvd_rsp_low_link3_cdc_reg;
  wire [31:0] open_hmc_rcvd_rsp_high_link3_cdc_reg;
  wire [31:0] open_hmc_tx_link_retries_low_link3_cdc_reg;
  wire [31:0] open_hmc_tx_link_retries_high_link3_cdc_reg;
  wire [31:0] open_hmc_err_on_rx_low_link3_cdc_reg;
  wire [31:0] open_hmc_err_on_rx_high_link3_cdc_reg;
  wire [31:0] open_hmc_run_lngth_bit_flip_low_link3_cdc_reg;
  wire [31:0] open_hmc_run_lngth_bit_flip_high_link3_cdc_reg;
  wire [31:0] open_hmc_err_abort_not_clr_low_link3_cdc_reg;
  wire [31:0] open_hmc_err_abort_not_clr_high_link3_cdc_reg;
  wire [31:0] hmc_err_rsp_packet_link3_cdc_reg;
  wire [31:0] hmc_errstat_link3_cdc_reg;
  wire [31:0] hmc_crc_err_cnt_link3_cdc_reg;
  //HMC Status
  wire [31:0] hmc_status_cdc_reg;
  
  
   //Define registers (standard)
   
  //Temp Reg Link2
  reg [31:0] temp_open_hmc_stat_gen_low_link2_reg;
  reg [31:0] temp_open_hmc_stat_gen_high_link2_reg;
  reg [31:0] temp_open_hmc_stat_init_low_link2_reg;
  reg [31:0] temp_open_hmc_stat_init_high_link2_reg;
  reg [31:0] temp_open_hmc_ctrl_low_link2_reg;
  reg [31:0] temp_open_hmc_ctrl_high_link2_reg;
  reg [31:0] temp_open_hmc_sent_p_low_link2_reg;
  reg [31:0] temp_open_hmc_sent_p_high_link2_reg;
  reg [31:0] temp_open_hmc_sent_np_low_link2_reg;
  reg [31:0] temp_open_hmc_sent_np_high_link2_reg;
  reg [31:0] temp_open_hmc_sent_r_low_link2_reg;
  reg [31:0] temp_open_hmc_sent_r_high_link2_reg;
  reg [31:0] temp_open_hmc_poisoned_packet_low_link2_reg;
  reg [31:0] temp_open_hmc_poisoned_packet_high_link2_reg;
  reg [31:0] temp_open_hmc_rcvd_rsp_low_link2_reg;
  reg [31:0] temp_open_hmc_rcvd_rsp_high_link2_reg;
  reg [31:0] temp_open_hmc_tx_link_retries_low_link2_reg;
  reg [31:0] temp_open_hmc_tx_link_retries_high_link2_reg;
  reg [31:0] temp_open_hmc_err_on_rx_low_link2_reg;
  reg [31:0] temp_open_hmc_err_on_rx_high_link2_reg;
  reg [31:0] temp_open_hmc_run_lngth_bit_flip_low_link2_reg;
  reg [31:0] temp_open_hmc_run_lngth_bit_flip_high_link2_reg;
  reg [31:0] temp_open_hmc_err_abort_not_clr_low_link2_reg;
  reg [31:0] temp_open_hmc_err_abort_not_clr_high_link2_reg;

  //Temp Reg Link3
  reg [31:0] temp_open_hmc_stat_gen_low_link3_reg;
  reg [31:0] temp_open_hmc_stat_gen_high_link3_reg;
  reg [31:0] temp_open_hmc_stat_init_low_link3_reg;
  reg [31:0] temp_open_hmc_stat_init_high_link3_reg;
  reg [31:0] temp_open_hmc_ctrl_low_link3_reg;
  reg [31:0] temp_open_hmc_ctrl_high_link3_reg;
  reg [31:0] temp_open_hmc_sent_p_low_link3_reg;
  reg [31:0] temp_open_hmc_sent_p_high_link3_reg;
  reg [31:0] temp_open_hmc_sent_np_low_link3_reg;
  reg [31:0] temp_open_hmc_sent_np_high_link3_reg;
  reg [31:0] temp_open_hmc_sent_r_low_link3_reg;
  reg [31:0] temp_open_hmc_sent_r_high_link3_reg;
  reg [31:0] temp_open_hmc_poisoned_packet_low_link3_reg;
  reg [31:0] temp_open_hmc_poisoned_packet_high_link3_reg;
  reg [31:0] temp_open_hmc_rcvd_rsp_low_link3_reg;
  reg [31:0] temp_open_hmc_rcvd_rsp_high_link3_reg;
  reg [31:0] temp_open_hmc_tx_link_retries_low_link3_reg;
  reg [31:0] temp_open_hmc_tx_link_retries_high_link3_reg;
  reg [31:0] temp_open_hmc_err_on_rx_low_link3_reg;
  reg [31:0] temp_open_hmc_err_on_rx_high_link3_reg;
  reg [31:0] temp_open_hmc_run_lngth_bit_flip_low_link3_reg;
  reg [31:0] temp_open_hmc_run_lngth_bit_flip_high_link3_reg;
  reg [31:0] temp_open_hmc_err_abort_not_clr_low_link3_reg;
  reg [31:0] temp_open_hmc_err_abort_not_clr_high_link3_reg;
  
  //Link2
  reg [31:0] open_hmc_stat_gen_low_link2_reg;
  reg [31:0] open_hmc_stat_gen_high_link2_reg;
  reg [31:0] open_hmc_stat_init_low_link2_reg;
  reg [31:0] open_hmc_stat_init_high_link2_reg;
  reg [31:0] open_hmc_ctrl_low_link2_reg;
  reg [31:0] open_hmc_ctrl_high_link2_reg;
  reg [31:0] open_hmc_sent_p_low_link2_reg;
  reg [31:0] open_hmc_sent_p_high_link2_reg;
  reg [31:0] open_hmc_sent_np_low_link2_reg;
  reg [31:0] open_hmc_sent_np_high_link2_reg;
  reg [31:0] open_hmc_sent_r_low_link2_reg;
  reg [31:0] open_hmc_sent_r_high_link2_reg;
  reg [31:0] open_hmc_poisoned_packet_low_link2_reg;
  reg [31:0] open_hmc_poisoned_packet_high_link2_reg;
  reg [31:0] open_hmc_rcvd_rsp_low_link2_reg;
  reg [31:0] open_hmc_rcvd_rsp_high_link2_reg;
  reg [31:0] open_hmc_tx_link_retries_low_link2_reg;
  reg [31:0] open_hmc_tx_link_retries_high_link2_reg;
  reg [31:0] open_hmc_err_on_rx_low_link2_reg;
  reg [31:0] open_hmc_err_on_rx_high_link2_reg;
  reg [31:0] open_hmc_run_lngth_bit_flip_low_link2_reg;
  reg [31:0] open_hmc_run_lngth_bit_flip_high_link2_reg;
  reg [31:0] open_hmc_err_abort_not_clr_low_link2_reg;
  reg [31:0] open_hmc_err_abort_not_clr_high_link2_reg;
  reg [31:0] hmc_err_rsp_packet_link2_reg;
  reg [31:0] hmc_errstat_link2_reg;
  reg [31:0] hmc_crc_err_cnt_link2_reg;
  //Link3
  reg [31:0] open_hmc_stat_gen_low_link3_reg;
  reg [31:0] open_hmc_stat_gen_high_link3_reg;
  reg [31:0] open_hmc_stat_init_low_link3_reg;
  reg [31:0] open_hmc_stat_init_high_link3_reg;
  reg [31:0] open_hmc_ctrl_low_link3_reg;
  reg [31:0] open_hmc_ctrl_high_link3_reg;
  reg [31:0] open_hmc_sent_p_low_link3_reg;
  reg [31:0] open_hmc_sent_p_high_link3_reg;
  reg [31:0] open_hmc_sent_np_low_link3_reg;
  reg [31:0] open_hmc_sent_np_high_link3_reg;
  reg [31:0] open_hmc_sent_r_low_link3_reg;
  reg [31:0] open_hmc_sent_r_high_link3_reg;
  reg [31:0] open_hmc_poisoned_packet_low_link3_reg;
  reg [31:0] open_hmc_poisoned_packet_high_link3_reg;
  reg [31:0] open_hmc_rcvd_rsp_low_link3_reg;
  reg [31:0] open_hmc_rcvd_rsp_high_link3_reg;
  reg [31:0] open_hmc_tx_link_retries_low_link3_reg;
  reg [31:0] open_hmc_tx_link_retries_high_link3_reg;
  reg [31:0] open_hmc_err_on_rx_low_link3_reg;
  reg [31:0] open_hmc_err_on_rx_high_link3_reg;
  reg [31:0] open_hmc_run_lngth_bit_flip_low_link3_reg;
  reg [31:0] open_hmc_run_lngth_bit_flip_high_link3_reg;
  reg [31:0] open_hmc_err_abort_not_clr_low_link3_reg;
  reg [31:0] open_hmc_err_abort_not_clr_high_link3_reg;
  reg [31:0] hmc_err_rsp_packet_link3_reg;
  reg [31:0] hmc_errstat_link3_reg;
  reg [31:0] hmc_crc_err_cnt_link3_reg;
  //HMC Status
  reg [31:0] hmc_status_reg;
  
  //history RX CRC error count register
  reg [31:0] reg_hist_rx_crc_err_cnt_link2;
  reg [31:0] reg_hist_rx_crc_err_cnt_link3; 
  
  //history POST OK register
  reg reg_hist_post_ok;

  //history INIT DONE register
  reg reg_hist_init_done;
  
  //history HMC_OK register
  reg reg_hist_hmc_ok;
  
  //history FLIT ERROR Response register
  reg [32:0] reg_hist_flit_err_resp_link2;
  reg [32:0] reg_hist_flit_err_resp_link3;
  
  //history HMC ERRSTAT Response register
  reg [31:0] reg_hist_errstat_link2;
  reg [31:0] reg_hist_errstat_link3;
  
  //history Reg Link2
  reg [31:0] reg_hist_open_hmc_stat_gen_low_link2;
  reg [31:0] reg_hist_open_hmc_stat_gen_high_link2;
  reg [31:0] reg_hist_open_hmc_stat_init_low_link2;
  reg [31:0] reg_hist_open_hmc_stat_init_high_link2;
  reg [31:0] reg_hist_open_hmc_ctrl_low_link2;
  reg [31:0] reg_hist_open_hmc_ctrl_high_link2;
  reg [31:0] reg_hist_open_hmc_sent_p_low_link2;
  reg [31:0] reg_hist_open_hmc_sent_p_high_link2;
  reg [31:0] reg_hist_open_hmc_sent_np_low_link2;
  reg [31:0] reg_hist_open_hmc_sent_np_high_link2;
  reg [31:0] reg_hist_open_hmc_sent_r_low_link2;
  reg [31:0] reg_hist_open_hmc_sent_r_high_link2;
  reg [31:0] reg_hist_open_hmc_poisoned_packet_low_link2;
  reg [31:0] reg_hist_open_hmc_poisoned_packet_high_link2;
  reg [31:0] reg_hist_open_hmc_rcvd_rsp_low_link2;
  reg [31:0] reg_hist_open_hmc_rcvd_rsp_high_link2;
  reg [31:0] reg_hist_open_hmc_tx_link_retries_low_link2;
  reg [31:0] reg_hist_open_hmc_tx_link_retries_high_link2;
  reg [31:0] reg_hist_open_hmc_err_on_rx_low_link2;
  reg [31:0] reg_hist_open_hmc_err_on_rx_high_link2;
  reg [31:0] reg_hist_open_hmc_run_lngth_bit_flip_low_link2;
  reg [31:0] reg_hist_open_hmc_run_lngth_bit_flip_high_link2;
  reg [31:0] reg_hist_open_hmc_err_abort_not_clr_low_link2;
  reg [31:0] reg_hist_open_hmc_err_abort_not_clr_high_link2;

  //History Reg Link3
  reg [31:0] reg_hist_open_hmc_stat_gen_low_link3;
  reg [31:0] reg_hist_open_hmc_stat_gen_high_link3;
  reg [31:0] reg_hist_open_hmc_stat_init_low_link3;
  reg [31:0] reg_hist_open_hmc_stat_init_high_link3;
  reg [31:0] reg_hist_open_hmc_ctrl_low_link3;
  reg [31:0] reg_hist_open_hmc_ctrl_high_link3;
  reg [31:0] reg_hist_open_hmc_sent_p_low_link3;
  reg [31:0] reg_hist_open_hmc_sent_p_high_link3;
  reg [31:0] reg_hist_open_hmc_sent_np_low_link3;
  reg [31:0] reg_hist_open_hmc_sent_np_high_link3;
  reg [31:0] reg_hist_open_hmc_sent_r_low_link3;
  reg [31:0] reg_hist_open_hmc_sent_r_high_link3;
  reg [31:0] reg_hist_open_hmc_poisoned_packet_low_link3;
  reg [31:0] reg_hist_open_hmc_poisoned_packet_high_link3;
  reg [31:0] reg_hist_open_hmc_rcvd_rsp_low_link3;
  reg [31:0] reg_hist_open_hmc_rcvd_rsp_high_link3;
  reg [31:0] reg_hist_open_hmc_tx_link_retries_low_link3;
  reg [31:0] reg_hist_open_hmc_tx_link_retries_high_link3;
  reg [31:0] reg_hist_open_hmc_err_on_rx_low_link3;
  reg [31:0] reg_hist_open_hmc_err_on_rx_high_link3;
  reg [31:0] reg_hist_open_hmc_run_lngth_bit_flip_low_link3;
  reg [31:0] reg_hist_open_hmc_run_lngth_bit_flip_high_link3;
  reg [31:0] reg_hist_open_hmc_err_abort_not_clr_low_link3;
  reg [31:0] reg_hist_open_hmc_err_abort_not_clr_high_link3;

    
 /************* OpenHMC/HMC General Status Registers *************/

    reg dval_hmc_status;
    reg dval_hmc_err_rsp_packet_link2;
    reg dval_hmc_err_rsp_packet_link3;
    reg dval_errstat_link2;
    reg dval_errstat_link3;
    
   //Register data valid counter signals 
    reg [4:0] dval_cnt_hmc_status; 
    reg [4:0] dval_cnt_hmc_err_rsp_packet_link2;
    reg [4:0] dval_cnt_hmc_err_rsp_packet_link3;
    reg [4:0] dval_cnt_errstat_link2;
    reg [4:0] dval_cnt_errstat_link3;
    
    //latch control registers - ensures fault condition is read
    //if occurs
    reg hmc_status_post_ok_latch_en;
    reg hmc_status_init_done_latch_en;
    reg hmc_status_hmc_ok_latch_en;
    
    reg hmc_err_rsp_packet_link2_latch_en;
    reg hmc_err_rsp_packet_link3_latch_en;
    reg hmc_errstat_link2_latch_en;
    reg hmc_errstat_link3_latch_en;
    
  
    always @(posedge user_clk) begin

      if (user_rst) begin
        hmc_err_rsp_packet_link3_reg <= 32'b0;
        hmc_errstat_link3_reg <= 32'b0;
        hmc_status_reg <= 32'b0;
        hmc_err_rsp_packet_link2_reg <= 32'b0;
        hmc_errstat_link2_reg  <= 32'b0;
        reg_hist_post_ok  <= 1'b0;
        reg_hist_init_done  <= 1'b0;
        reg_hist_hmc_ok  <= 1'b0;
        reg_hist_flit_err_resp_link2  <= 32'b0;
        reg_hist_flit_err_resp_link3  <= 32'b0;
        reg_hist_errstat_link2  <= 32'b0;
        reg_hist_errstat_link3  <= 32'b0;
        dval_hmc_status <= 1'b0;
        dval_hmc_err_rsp_packet_link2 <= 1'b0;
        dval_hmc_err_rsp_packet_link3 <= 1'b0;
        dval_errstat_link2 <= 1'b0;
        dval_errstat_link3 <= 1'b0;
        dval_cnt_hmc_status <= 5'b0;
        dval_cnt_hmc_err_rsp_packet_link2 <= 5'b0;
        dval_cnt_hmc_err_rsp_packet_link3 <= 5'b0;
        dval_cnt_errstat_link2 <= 5'b0;
        dval_cnt_errstat_link3 <= 5'b0;
        hmc_status_post_ok_latch_en <= 1'b1;
        hmc_status_init_done_latch_en <= 1'b1;
        hmc_status_hmc_ok_latch_en <= 1'b1;
        hmc_err_rsp_packet_link2_latch_en <= 1'b1;
        hmc_err_rsp_packet_link3_latch_en <= 1'b1;
        hmc_errstat_link2_latch_en <= 1'b1;
        hmc_errstat_link3_latch_en <= 1'b1;        
      end else begin
        reg_hist_post_ok <= post_ok;
        reg_hist_init_done <= init_done;
        reg_hist_hmc_ok <= hmc_ok;
        reg_hist_flit_err_resp_link2[3:0] <= flit_err_resp_link2[3:0];
        reg_hist_flit_err_resp_link3[3:0] <= flit_err_resp_link3[3:0];
        reg_hist_errstat_link2[6:0] <= errstat_link2[6:0];
        reg_hist_errstat_link3[6:0] <= errstat_link3[6:0];
        
        //Reset the latch enables after reading the wishbone value in order to trigger on
        //the new fault conditions
        if (hmc_status_post_ok_latch_reset_cdc == 1'b1) begin
          hmc_status_post_ok_latch_en <= 1'b1;
        end
        if (hmc_status_init_done_latch_reset_cdc == 1'b1) begin
          hmc_status_init_done_latch_en <= 1'b1;
        end
        if (hmc_status_hmc_ok_latch_reset_cdc == 1'b1) begin
          hmc_status_hmc_ok_latch_en <= 1'b1;
        end        
        if (hmc_err_rsp_packet_link2_latch_reset_cdc == 1'b1) begin
          hmc_err_rsp_packet_link2_latch_en <= 1'b1;
        end
        if (hmc_err_rsp_packet_link3_latch_reset_cdc == 1'b1) begin
          hmc_err_rsp_packet_link3_latch_en <= 1'b1;
        end
        if (hmc_errstat_link2_latch_reset_cdc == 1'b1) begin
          hmc_errstat_link2_latch_en <= 1'b1;
        end
        if (hmc_errstat_link3_latch_reset_cdc == 1'b1) begin
          hmc_errstat_link3_latch_en <= 1'b1;
        end
               
        
        //Ensures Data Valid signals are longer than BSP clock 
        if (dval_hmc_status == 1'b1) begin        
          dval_cnt_hmc_status <= dval_cnt_hmc_status + 1;
          if(dval_cnt_hmc_status == 20) begin
            dval_cnt_hmc_status <= 5'b0;
            dval_hmc_status <= 1'b0; 
          end
        end          
        if (dval_hmc_err_rsp_packet_link2 == 1'b1) begin        
          dval_cnt_hmc_err_rsp_packet_link2 <= dval_cnt_hmc_err_rsp_packet_link2 + 1;
          if(dval_cnt_hmc_err_rsp_packet_link2 == 20) begin
            dval_cnt_hmc_err_rsp_packet_link2 <= 5'b0;
            dval_hmc_err_rsp_packet_link2 <= 1'b0; 
          end
        end  
        if (dval_hmc_err_rsp_packet_link3 == 1'b1) begin        
          dval_cnt_hmc_err_rsp_packet_link3 <= dval_cnt_hmc_err_rsp_packet_link3 + 1;
          if(dval_cnt_hmc_err_rsp_packet_link3 == 20) begin
            dval_cnt_hmc_err_rsp_packet_link3 <= 5'b0;
            dval_hmc_err_rsp_packet_link3 <= 1'b0; 
          end
        end          
        if (dval_errstat_link2 == 1'b1) begin        
          dval_cnt_errstat_link2 <= dval_cnt_errstat_link2 + 1;
          if(dval_cnt_errstat_link2 == 20) begin
            dval_cnt_errstat_link2 <= 5'b0;
            dval_errstat_link2 <= 1'b0; 
          end
        end  
        if (dval_errstat_link3 == 1'b1) begin        
          dval_cnt_errstat_link3 <= dval_cnt_errstat_link3 + 1;
          if(dval_cnt_errstat_link3 == 20) begin
            dval_cnt_errstat_link3 <= 5'b0;
            dval_errstat_link3 <= 1'b0; 
          end
        end          

        
        //Check when HMC POST OK changes and assign updated error value
        if((reg_hist_post_ok != post_ok) && (hmc_status_post_ok_latch_en == 1'b1)) begin
          hmc_status_reg[0] <= post_ok;
          dval_hmc_status <= 1'b1;
          hmc_status_post_ok_latch_en <= 1'b0;
        end

        //Check when HMC INIT_DONE changes and assign updated error value
        if((reg_hist_init_done != init_done) && (hmc_status_init_done_latch_en == 1'b1)) begin
          hmc_status_reg[1] <= init_done;
          dval_hmc_status <= 1'b1;
          hmc_status_init_done_latch_en <= 1'b0;
        end
        
        //Check when HMC OK changes and assign updated error value
        if((reg_hist_hmc_ok != hmc_ok) && (hmc_status_hmc_ok_latch_en == 1'b1)) begin
          hmc_status_reg[2] <= hmc_ok;
          dval_hmc_status <= 1'b1;
          hmc_status_hmc_ok_latch_en <= 1'b0;
        end
        
        //Check when LINK2 Error response changes and assign updated error value
        if((reg_hist_flit_err_resp_link2[3:0] != flit_err_resp_link2[3:0]) && (hmc_err_rsp_packet_link2_latch_en == 1'b1)) begin
          hmc_err_rsp_packet_link2_reg <= flit_err_resp_link2;
          dval_hmc_err_rsp_packet_link2 <= 1'b1;
          hmc_err_rsp_packet_link2_latch_en <= 1'b0;
        end
        
        //Check when LINK3 Error response changes and assign updated error value
        if((reg_hist_flit_err_resp_link3[3:0] != flit_err_resp_link3[3:0]) && (hmc_err_rsp_packet_link3_latch_en == 1'b1)) begin
          hmc_err_rsp_packet_link3_reg <= flit_err_resp_link3;
          dval_hmc_err_rsp_packet_link3 <= 1'b1;
          hmc_err_rsp_packet_link3_latch_en <= 1'b0;
        end
        
        //Check when LINK2 ERRSTAT changes and assign updated error value
        if((reg_hist_errstat_link2[6:0] != errstat_link2[6:0]) && (hmc_errstat_link2_latch_en == 1'b1)) begin
          hmc_errstat_link2_reg <= errstat_link2;
          dval_errstat_link2 <= 1'b1;
          hmc_errstat_link2_latch_en <= 1'b0;
        end
        
        //Check when LINK3 ERRSTAT changes and assign updated error value
        if((reg_hist_errstat_link3[6:0] != errstat_link3[6:0]) && (hmc_errstat_link3_latch_en == 1'b1)) begin
          hmc_errstat_link3_reg <= errstat_link3;
          dval_errstat_link3 <= 1'b1;
          hmc_errstat_link3_latch_en <= 1'b0;
        end        
        
      end
    end 
        
 
 /************* OpenHMC Link2 Status & Control Register Address Decoding *************/
    
   //Register data valid signals 
    reg dval_stat_gen_low_link2; 
    reg dval_stat_gen_high_link2;
    reg dval_stat_init_low_link2;
    reg dval_stat_init_high_link2;
    reg dval_ctrl_low_link2;
    reg dval_ctrl_high_link2;
    reg dval_sent_p_low_link2;
    reg dval_sent_p_high_link2;
    reg dval_sent_np_low_link2;
    reg dval_sent_np_high_link2;
    reg dval_sent_r_low_link2;
    reg dval_sent_r_high_link2;
    reg dval_poisoned_packet_low_link2;
    reg dval_poisoned_packet_high_link2;
    reg dval_rcvd_rsp_low_link2;
    reg dval_rcvd_rsp_high_link2;
    reg dval_poisoned_packet_low_link2;
    reg dval_poisoned_packet_high_link2;
    reg dval_rcvd_rsp_low_link2;
    reg dval_rcvd_rsp_high_link2;
    reg dval_tx_link_retries_low_link2;
    reg dval_tx_link_retries_high_link2;
    reg dval_err_on_rx_low_link2;
    reg dval_err_on_rx_high_link2;
    reg dval_run_lngth_bit_flip_low_link2;
    reg dval_run_lngth_bit_flip_high_link2;
    reg dval_err_abort_not_clr_low_link2;
    reg dval_err_abort_not_clr_high_link2;
    reg dval_hmc_crc_err_cnt_link2;
    
   //Register data valid counter signals 
    reg [4:0] dval_cnt_stat_gen_low_link2; 
    reg [4:0] dval_cnt_stat_gen_high_link2;
    reg [4:0] dval_cnt_stat_init_low_link2;
    reg [4:0] dval_cnt_stat_init_high_link2;
    reg [4:0] dval_cnt_ctrl_low_link2;
    reg [4:0] dval_cnt_ctrl_high_link2;
    reg [4:0] dval_cnt_sent_p_low_link2;
    reg [4:0] dval_cnt_sent_p_high_link2;
    reg [4:0] dval_cnt_sent_np_low_link2;
    reg [4:0] dval_cnt_sent_np_high_link2;
    reg [4:0] dval_cnt_sent_r_low_link2;
    reg [4:0] dval_cnt_sent_r_high_link2;
    reg [4:0] dval_cnt_poisoned_packet_low_link2;
    reg [4:0] dval_cnt_poisoned_packet_high_link2;
    reg [4:0] dval_cnt_rcvd_rsp_low_link2;
    reg [4:0] dval_cnt_rcvd_rsp_high_link2;
    reg [4:0] dval_cnt_poisoned_packet_low_link2;
    reg [4:0] dval_cnt_poisoned_packet_high_link2;
    reg [4:0] dval_cnt_rcvd_rsp_low_link2;
    reg [4:0] dval_cnt_rcvd_rsp_high_link2;
    reg [4:0] dval_cnt_tx_link_retries_low_link2;
    reg [4:0] dval_cnt_tx_link_retries_high_link2;
    reg [4:0] dval_cnt_err_on_rx_low_link2;
    reg [4:0] dval_cnt_err_on_rx_high_link2;
    reg [4:0] dval_cnt_run_lngth_bit_flip_low_link2;
    reg [4:0] dval_cnt_run_lngth_bit_flip_high_link2;
    reg [4:0] dval_cnt_err_abort_not_clr_low_link2;
    reg [4:0] dval_cnt_err_abort_not_clr_high_link2;
    reg [4:0] dval_cnt_hmc_crc_err_cnt_link2;    
  
    always @(posedge hmc_link2_clk) begin

      if (hmc_link2_rst) begin
        open_hmc_stat_gen_low_link2_reg <= 32'b0;
        open_hmc_stat_gen_high_link2_reg <= 32'b0;
        open_hmc_stat_init_low_link2_reg <= 32'b0;
        open_hmc_stat_init_high_link2_reg <= 32'b0;
        open_hmc_ctrl_low_link2_reg  <= 32'b0;
        open_hmc_ctrl_high_link2_reg  <= 32'b0;
        open_hmc_sent_p_low_link2_reg  <= 32'b0;
        open_hmc_sent_p_high_link2_reg  <= 32'b0;
        open_hmc_sent_np_low_link2_reg  <= 32'b0;
        open_hmc_sent_np_high_link2_reg  <= 32'b0;
        open_hmc_sent_r_low_link2_reg  <= 32'b0;
        open_hmc_sent_r_high_link2_reg  <= 32'b0;
        open_hmc_poisoned_packet_low_link2_reg  <= 32'b0;
        open_hmc_poisoned_packet_high_link2_reg  <= 32'b0;
        open_hmc_rcvd_rsp_low_link2_reg  <= 32'b0;
        open_hmc_rcvd_rsp_high_link2_reg  <= 32'b0;
        open_hmc_tx_link_retries_low_link2_reg  <= 32'b0;
        open_hmc_tx_link_retries_high_link2_reg  <= 32'b0;
        open_hmc_err_on_rx_low_link2_reg  <= 32'b0;
        open_hmc_err_on_rx_high_link2_reg  <= 32'b0;
        open_hmc_run_lngth_bit_flip_low_link2_reg  <= 32'b0;
        open_hmc_run_lngth_bit_flip_high_link2_reg  <= 32'b0;
        open_hmc_err_abort_not_clr_low_link2_reg  <= 32'b0;
        open_hmc_err_abort_not_clr_high_link2_reg  <= 32'b0;
        
        temp_open_hmc_stat_gen_low_link2_reg <= 32'b0;
        temp_open_hmc_stat_gen_high_link2_reg <= 32'b0;
        temp_open_hmc_stat_init_low_link2_reg <= 32'b0;
        temp_open_hmc_stat_init_high_link2_reg <= 32'b0;
        temp_open_hmc_ctrl_low_link2_reg  <= 32'b0;
        temp_open_hmc_ctrl_high_link2_reg  <= 32'b0;
        temp_open_hmc_sent_p_low_link2_reg  <= 32'b0;
        temp_open_hmc_sent_p_high_link2_reg  <= 32'b0;
        temp_open_hmc_sent_np_low_link2_reg  <= 32'b0;
        temp_open_hmc_sent_np_high_link2_reg  <= 32'b0;
        temp_open_hmc_sent_r_low_link2_reg  <= 32'b0;
        temp_open_hmc_sent_r_high_link2_reg  <= 32'b0;
        temp_open_hmc_poisoned_packet_low_link2_reg  <= 32'b0;
        temp_open_hmc_poisoned_packet_high_link2_reg  <= 32'b0;
        temp_open_hmc_rcvd_rsp_low_link2_reg  <= 32'b0;
        temp_open_hmc_rcvd_rsp_high_link2_reg  <= 32'b0;
        temp_open_hmc_tx_link_retries_low_link2_reg  <= 32'b0;
        temp_open_hmc_tx_link_retries_high_link2_reg  <= 32'b0;
        temp_open_hmc_err_on_rx_low_link2_reg  <= 32'b0;
        temp_open_hmc_err_on_rx_high_link2_reg  <= 32'b0;
        temp_open_hmc_run_lngth_bit_flip_low_link2_reg  <= 32'b0;
        temp_open_hmc_run_lngth_bit_flip_high_link2_reg  <= 32'b0;
        temp_open_hmc_err_abort_not_clr_low_link2_reg  <= 32'b0;
        temp_open_hmc_err_abort_not_clr_high_link2_reg  <= 32'b0; 
        
        reg_hist_open_hmc_stat_gen_low_link2 <= 32'b0;
        reg_hist_open_hmc_stat_gen_high_link2 <= 32'b0;
        reg_hist_open_hmc_stat_init_low_link2 <= 32'b0;
        reg_hist_open_hmc_stat_init_high_link2 <= 32'b0;
        reg_hist_open_hmc_ctrl_low_link2  <= 32'b0;
        reg_hist_open_hmc_ctrl_high_link2  <= 32'b0;
        reg_hist_open_hmc_sent_p_low_link2  <= 32'b0;
        reg_hist_open_hmc_sent_p_high_link2  <= 32'b0;
        reg_hist_open_hmc_sent_np_low_link2  <= 32'b0;
        reg_hist_open_hmc_sent_np_high_link2  <= 32'b0;
        reg_hist_open_hmc_sent_r_low_link2  <= 32'b0;
        reg_hist_open_hmc_sent_r_high_link2  <= 32'b0;
        reg_hist_open_hmc_poisoned_packet_low_link2  <= 32'b0;
        reg_hist_open_hmc_poisoned_packet_high_link2  <= 32'b0;
        reg_hist_open_hmc_rcvd_rsp_low_link2  <= 32'b0;
        reg_hist_open_hmc_rcvd_rsp_high_link2  <= 32'b0;
        reg_hist_open_hmc_tx_link_retries_low_link2  <= 32'b0;
        reg_hist_open_hmc_tx_link_retries_high_link2  <= 32'b0;
        reg_hist_open_hmc_err_on_rx_low_link2  <= 32'b0;
        reg_hist_open_hmc_err_on_rx_high_link2  <= 32'b0;
        reg_hist_open_hmc_run_lngth_bit_flip_low_link2  <= 32'b0;
        reg_hist_open_hmc_run_lngth_bit_flip_high_link2  <= 32'b0;
        reg_hist_open_hmc_err_abort_not_clr_low_link2  <= 32'b0;
        reg_hist_open_hmc_err_abort_not_clr_high_link2  <= 32'b0;        
        
        reg_hist_rx_crc_err_cnt_link2 <= 16'b0;
        hmc_crc_err_cnt_link2_reg <= 16'b0;
        
        dval_stat_gen_low_link2 <= 1'b0; 
        dval_stat_gen_high_link2 <= 1'b0;
        dval_stat_init_low_link2 <= 1'b0;
        dval_stat_init_high_link2 <= 1'b0;
        dval_ctrl_low_link2 <= 1'b0;
        dval_ctrl_high_link2 <= 1'b0;
        dval_sent_p_low_link2 <= 1'b0;
        dval_sent_p_high_link2 <= 1'b0;
        dval_sent_np_low_link2 <= 1'b0;
        dval_sent_np_high_link2 <= 1'b0;
        dval_sent_r_low_link2 <= 1'b0;
        dval_sent_r_high_link2 <= 1'b0;
        dval_poisoned_packet_low_link2 <= 1'b0;
        dval_poisoned_packet_high_link2 <= 1'b0;
        dval_rcvd_rsp_low_link2 <= 1'b0;
        dval_rcvd_rsp_high_link2 <= 1'b0;
        dval_tx_link_retries_low_link2 <= 1'b0;
        dval_tx_link_retries_high_link2 <= 1'b0;
        dval_err_on_rx_low_link2 <= 1'b0;
        dval_err_on_rx_high_link2 <= 1'b0;
        dval_run_lngth_bit_flip_low_link2 <= 1'b0;
        dval_run_lngth_bit_flip_high_link2 <= 1'b0;
        dval_err_abort_not_clr_low_link2 <= 1'b0;
        dval_err_abort_not_clr_high_link2 <= 1'b0;
        dval_hmc_crc_err_cnt_link2 <= 1'b0;  
        
       //Register data valid counter signals 
        dval_cnt_stat_gen_low_link2 <= 5'b0; 
        dval_cnt_stat_gen_high_link2 <= 5'b0; 
        dval_cnt_stat_init_low_link2 <= 5'b0; 
        dval_cnt_stat_init_high_link2 <= 5'b0; 
        dval_cnt_ctrl_low_link2 <= 5'b0; 
        dval_cnt_ctrl_high_link2 <= 5'b0; 
        dval_cnt_sent_p_low_link2 <= 5'b0; 
        dval_cnt_sent_p_high_link2 <= 5'b0;
        dval_cnt_sent_np_low_link2 <= 5'b0; 
        dval_cnt_sent_np_high_link2 <= 5'b0; 
        dval_cnt_sent_r_low_link2 <= 5'b0; 
        dval_cnt_sent_r_high_link2 <= 5'b0; 
        dval_cnt_poisoned_packet_low_link2 <= 5'b0; 
        dval_cnt_poisoned_packet_high_link2 <= 5'b0; 
        dval_cnt_rcvd_rsp_low_link2 <= 5'b0; 
        dval_cnt_rcvd_rsp_high_link2 <= 5'b0; 
        dval_cnt_poisoned_packet_low_link2 <= 5'b0; 
        dval_cnt_poisoned_packet_high_link2 <= 5'b0; 
        dval_cnt_rcvd_rsp_low_link2 <= 5'b0; 
        dval_cnt_rcvd_rsp_high_link2 <= 5'b0; 
        dval_cnt_tx_link_retries_low_link2 <= 5'b0; 
        dval_cnt_tx_link_retries_high_link2 <= 5'b0; 
        dval_cnt_err_on_rx_low_link2 <= 5'b0; 
        dval_cnt_err_on_rx_high_link2 <= 5'b0; 
        dval_cnt_run_lngth_bit_flip_low_link2 <= 5'b0; 
        dval_cnt_run_lngth_bit_flip_high_link2 <= 5'b0; 
        dval_cnt_err_abort_not_clr_low_link2 <= 5'b0; 
        dval_cnt_err_abort_not_clr_high_link2 <= 5'b0; 
        dval_cnt_hmc_crc_err_cnt_link2 <= 5'b0;          
                     
      end else begin
        //Populate History buffers
        reg_hist_rx_crc_err_cnt_link2 <= rx_crc_err_cnt_link2;
        reg_hist_open_hmc_stat_gen_low_link2 <= temp_open_hmc_stat_gen_low_link2_reg;
        reg_hist_open_hmc_stat_gen_high_link2 <= temp_open_hmc_stat_gen_high_link2_reg;
        reg_hist_open_hmc_stat_init_low_link2 <= temp_open_hmc_stat_init_low_link2_reg;
        reg_hist_open_hmc_stat_init_high_link2 <= temp_open_hmc_stat_init_high_link2_reg;
        reg_hist_open_hmc_ctrl_low_link2 <= temp_open_hmc_ctrl_low_link2_reg;
        reg_hist_open_hmc_ctrl_high_link2 <= temp_open_hmc_ctrl_high_link2_reg;
        reg_hist_open_hmc_sent_p_low_link2 <= temp_open_hmc_sent_p_low_link2_reg; 
        reg_hist_open_hmc_sent_p_high_link2 <= temp_open_hmc_sent_p_high_link2_reg;
        reg_hist_open_hmc_sent_np_low_link2 <= temp_open_hmc_sent_np_low_link2_reg;
        reg_hist_open_hmc_sent_np_high_link2 <= temp_open_hmc_sent_np_high_link2_reg;
        reg_hist_open_hmc_sent_r_low_link2 <= temp_open_hmc_sent_r_low_link2_reg;
        reg_hist_open_hmc_sent_r_high_link2 <= temp_open_hmc_sent_r_high_link2_reg;
        reg_hist_open_hmc_poisoned_packet_low_link2 <= temp_open_hmc_poisoned_packet_low_link2_reg;
        reg_hist_open_hmc_poisoned_packet_high_link2 <=  temp_open_hmc_poisoned_packet_high_link2_reg;
        reg_hist_open_hmc_rcvd_rsp_low_link2 <= temp_open_hmc_rcvd_rsp_low_link2_reg;
        reg_hist_open_hmc_rcvd_rsp_high_link2 <= temp_open_hmc_rcvd_rsp_high_link2_reg;
        reg_hist_open_hmc_tx_link_retries_low_link2 <= temp_open_hmc_tx_link_retries_low_link2_reg;
        reg_hist_open_hmc_tx_link_retries_high_link2 <= temp_open_hmc_tx_link_retries_high_link2_reg;
        reg_hist_open_hmc_err_on_rx_low_link2 <= temp_open_hmc_err_on_rx_low_link2_reg;
        reg_hist_open_hmc_err_on_rx_high_link2 <= temp_open_hmc_err_on_rx_high_link2_reg;
        reg_hist_open_hmc_run_lngth_bit_flip_low_link2 <= temp_open_hmc_run_lngth_bit_flip_low_link2_reg;
        reg_hist_open_hmc_run_lngth_bit_flip_high_link2 <= temp_open_hmc_run_lngth_bit_flip_high_link2_reg; 
        reg_hist_open_hmc_err_abort_not_clr_low_link2 <= temp_open_hmc_err_abort_not_clr_low_link2_reg;
        reg_hist_open_hmc_err_abort_not_clr_high_link2 <= temp_open_hmc_err_abort_not_clr_high_link2_reg;
        
        //Ensures Data Valid signals are longer than BSP clock 
        if (dval_stat_gen_low_link2 == 1'b1) begin        
          dval_cnt_stat_gen_low_link2 <= dval_cnt_stat_gen_low_link2 + 1;
          if(dval_cnt_stat_gen_low_link2 == 20) begin
            dval_cnt_stat_gen_low_link2 <= 5'b0;
            dval_stat_gen_low_link2 <= 1'b0; 
          end
        end
        if (dval_stat_gen_high_link2 == 1'b1) begin        
          dval_cnt_stat_gen_high_link2 <= dval_cnt_stat_gen_high_link2 + 1;
          if(dval_cnt_stat_gen_high_link2 == 20) begin
            dval_cnt_stat_gen_high_link2 <= 5'b0;
            dval_stat_gen_high_link2 <= 1'b0;
          end          
        end
        if (dval_stat_init_low_link2 == 1'b1) begin                
          dval_cnt_stat_init_low_link2 <= dval_cnt_stat_init_low_link2 + 1;
          if(dval_cnt_stat_init_low_link2 == 20) begin
            dval_cnt_stat_init_low_link2 <= 5'b0;
            dval_stat_init_low_link2 <= 1'b0;
          end          
        end
        if (dval_stat_init_high_link2 == 1'b1) begin                
          dval_cnt_stat_init_high_link2 <= dval_cnt_stat_init_high_link2 + 1;
          if(dval_cnt_stat_init_high_link2 == 20) begin
            dval_cnt_stat_init_high_link2 <= 5'b0;
            dval_stat_init_high_link2 <= 1'b0;
          end          
        end        
        if (dval_ctrl_low_link2 == 1'b1) begin                
          dval_cnt_ctrl_low_link2 <= dval_cnt_ctrl_low_link2 + 1;
          if(dval_cnt_ctrl_low_link2 == 20) begin
            dval_cnt_ctrl_low_link2 <= 5'b0;
            dval_ctrl_low_link2 <= 1'b0;
          end          
        end        
        if (dval_ctrl_high_link2 == 1'b1) begin                
          dval_cnt_ctrl_high_link2 <= dval_cnt_ctrl_high_link2 + 1;
          if(dval_cnt_ctrl_low_link2 == 20) begin
            dval_cnt_ctrl_high_link2 <= 5'b0;
            dval_ctrl_high_link2 <= 1'b0;
          end          
        end        
        if (dval_sent_p_low_link2 == 1'b1) begin                
          dval_cnt_sent_p_low_link2 <= dval_cnt_sent_p_low_link2 + 1;
          if(dval_cnt_sent_p_low_link2 == 20) begin
            dval_cnt_sent_p_low_link2 <= 5'b0;
            dval_sent_p_low_link2 <= 1'b0;
          end          
        end        
        if (dval_sent_p_high_link2 == 1'b1) begin                
          dval_cnt_sent_p_high_link2 <= dval_cnt_sent_p_high_link2 + 1;
          if(dval_cnt_sent_p_high_link2 == 20) begin
            dval_cnt_sent_p_high_link2 <= 5'b0;
            dval_sent_p_high_link2 <= 1'b0;
          end          
        end                
        if (dval_sent_np_low_link2 == 1'b1) begin                
          dval_cnt_sent_np_low_link2 <= dval_cnt_sent_np_low_link2 + 1;
          if(dval_cnt_sent_np_low_link2 == 20) begin
            dval_cnt_sent_np_low_link2 <= 5'b0;
            dval_sent_np_low_link2 <= 1'b0;
          end          
        end        
        if (dval_sent_np_high_link2 == 1'b1) begin                
          dval_cnt_sent_np_high_link2 <= dval_cnt_sent_np_high_link2 + 1;
          if(dval_cnt_sent_np_high_link2 == 20) begin
            dval_cnt_sent_np_high_link2 <= 5'b0;
            dval_sent_np_high_link2 <= 1'b0;
          end          
        end                      
        if (dval_sent_r_low_link2 == 1'b1) begin                
          dval_cnt_sent_r_low_link2 <= dval_cnt_sent_r_low_link2 + 1;
          if(dval_cnt_sent_r_low_link2 == 20) begin
            dval_cnt_sent_r_low_link2 <= 5'b0;
            dval_sent_r_low_link2 <= 1'b0;
          end          
        end        
        if (dval_sent_r_high_link2 == 1'b1) begin                
          dval_cnt_sent_r_high_link2 <= dval_cnt_sent_r_high_link2 + 1;
          if(dval_cnt_sent_r_high_link2 == 20) begin
            dval_cnt_sent_r_high_link2 <= 5'b0;
            dval_sent_r_high_link2 <= 1'b0;
          end          
        end                
        if (dval_poisoned_packet_low_link2 == 1'b1) begin                
          dval_cnt_poisoned_packet_low_link2 <= dval_cnt_poisoned_packet_low_link2 + 1;
          if(dval_cnt_poisoned_packet_low_link2 == 20) begin
            dval_cnt_poisoned_packet_low_link2 <= 5'b0;
            dval_poisoned_packet_low_link2 <= 1'b0;
          end          
        end        
        if (dval_poisoned_packet_high_link2 == 1'b1) begin                
          dval_cnt_poisoned_packet_high_link2 <= dval_cnt_poisoned_packet_high_link2 + 1;
          if(dval_cnt_poisoned_packet_high_link2 == 20) begin
            dval_cnt_poisoned_packet_high_link2 <= 5'b0;
            dval_poisoned_packet_high_link2 <= 1'b0;
          end          
        end                
        if (dval_rcvd_rsp_low_link2 == 1'b1) begin                
          dval_cnt_rcvd_rsp_low_link2 <= dval_cnt_rcvd_rsp_low_link2 + 1;
          if(dval_cnt_rcvd_rsp_low_link2 == 20) begin
            dval_cnt_rcvd_rsp_low_link2 <= 5'b0;
            dval_rcvd_rsp_low_link2 <= 1'b0;
          end          
        end        
        if (dval_rcvd_rsp_high_link2 == 1'b1) begin                
          dval_cnt_rcvd_rsp_high_link2 <= dval_cnt_rcvd_rsp_high_link2 + 1;
          if(dval_cnt_rcvd_rsp_high_link2 == 20) begin
            dval_cnt_rcvd_rsp_high_link2 <= 5'b0;
            dval_rcvd_rsp_high_link2 <= 1'b0;
          end          
        end        

        if (dval_rcvd_rsp_low_link2 == 1'b1) begin                
          dval_cnt_rcvd_rsp_low_link2 <= dval_cnt_rcvd_rsp_low_link2 + 1;
          if(dval_cnt_rcvd_rsp_low_link2 == 20) begin
            dval_cnt_rcvd_rsp_low_link2 <= 5'b0;
            dval_rcvd_rsp_low_link2 <= 1'b0;
          end          
        end        
        if (dval_rcvd_rsp_high_link2 == 1'b1) begin                
          dval_cnt_rcvd_rsp_high_link2 <= dval_cnt_rcvd_rsp_high_link2 + 1;
          if(dval_cnt_rcvd_rsp_high_link2 == 20) begin
            dval_cnt_rcvd_rsp_high_link2 <= 5'b0;
            dval_rcvd_rsp_high_link2 <= 1'b0;
          end          
        end           
        if (dval_tx_link_retries_low_link2 == 1'b1) begin                
          dval_cnt_tx_link_retries_low_link2 <= dval_cnt_tx_link_retries_low_link2 + 1;
          if(dval_cnt_tx_link_retries_low_link2 == 20) begin
            dval_cnt_tx_link_retries_low_link2 <= 5'b0;
            dval_tx_link_retries_low_link2 <= 1'b0;
          end          
        end        
        if (dval_tx_link_retries_high_link2 == 1'b1) begin                
          dval_cnt_tx_link_retries_high_link2 <= dval_cnt_tx_link_retries_high_link2 + 1;
          if(dval_cnt_tx_link_retries_high_link2 == 20) begin
            dval_cnt_tx_link_retries_high_link2 <= 5'b0;
            dval_tx_link_retries_high_link2 <= 1'b0;
          end          
        end           
        if (dval_err_on_rx_low_link2 == 1'b1) begin                
          dval_cnt_err_on_rx_low_link2 <= dval_cnt_err_on_rx_low_link2 + 1;
          if(dval_cnt_err_on_rx_low_link2 == 20) begin
            dval_cnt_err_on_rx_low_link2 <= 5'b0;
            dval_err_on_rx_low_link2 <= 1'b0;
          end          
        end        
        if (dval_err_on_rx_high_link2 == 1'b1) begin                
          dval_cnt_err_on_rx_high_link2 <= dval_cnt_err_on_rx_high_link2 + 1;
          if(dval_cnt_err_on_rx_high_link2 == 20) begin
            dval_cnt_err_on_rx_high_link2 <= 5'b0;
            dval_err_on_rx_high_link2 <= 1'b0;
          end          
        end           
        if (dval_run_lngth_bit_flip_low_link2 == 1'b1) begin                
          dval_cnt_run_lngth_bit_flip_low_link2 <= dval_cnt_run_lngth_bit_flip_low_link2 + 1;
          if(dval_cnt_run_lngth_bit_flip_low_link2 == 20) begin
            dval_cnt_run_lngth_bit_flip_low_link2 <= 5'b0;
            dval_run_lngth_bit_flip_low_link2 <= 1'b0;
          end          
        end        
        if (dval_run_lngth_bit_flip_high_link2 == 1'b1) begin                
          dval_cnt_run_lngth_bit_flip_high_link2 <= dval_cnt_run_lngth_bit_flip_high_link2 + 1;
          if(dval_cnt_run_lngth_bit_flip_high_link2 == 20) begin
            dval_cnt_run_lngth_bit_flip_high_link2 <= 5'b0;
            dval_run_lngth_bit_flip_high_link2 <= 1'b0;
          end          
        end           
        if (dval_err_abort_not_clr_low_link2 == 1'b1) begin                
          dval_cnt_err_abort_not_clr_low_link2 <= dval_cnt_err_abort_not_clr_low_link2 + 1;
          if(dval_cnt_err_abort_not_clr_low_link2 == 20) begin
            dval_cnt_err_abort_not_clr_low_link2 <= 5'b0;
            dval_err_abort_not_clr_low_link2 <= 1'b0;
          end          
        end        
        if (dval_err_abort_not_clr_high_link2 == 1'b1) begin                
          dval_cnt_err_abort_not_clr_high_link2 <= dval_cnt_err_abort_not_clr_high_link2 + 1;
          if(dval_cnt_err_abort_not_clr_high_link2 == 20) begin
            dval_cnt_err_abort_not_clr_high_link2 <= 5'b0;
            dval_err_abort_not_clr_high_link2 <= 1'b0;
          end 
          
        end   
        if (dval_hmc_crc_err_cnt_link2 == 1'b1) begin                
          dval_cnt_hmc_crc_err_cnt_link2 <= dval_cnt_hmc_crc_err_cnt_link2 + 1;
          if(dval_cnt_hmc_crc_err_cnt_link2 == 20) begin
            dval_cnt_hmc_crc_err_cnt_link2 <= 5'b0;
            dval_hmc_crc_err_cnt_link2 <= 1'b0;
          end          
        end           
        
        //Check when RX CRC error count changes and assign updated error value
        if(reg_hist_rx_crc_err_cnt_link2 != rx_crc_err_cnt_link2) begin
          hmc_crc_err_cnt_link2_reg <= rx_crc_err_cnt_link2;
          dval_hmc_crc_err_cnt_link2 <= 1'b1;
        end
        
        //Check when OpenHMC registers change and assign updated value
        if(reg_hist_open_hmc_stat_gen_low_link2 != temp_open_hmc_stat_gen_low_link2_reg) begin
          open_hmc_stat_gen_low_link2_reg <= temp_open_hmc_stat_gen_low_link2_reg;
          dval_stat_gen_low_link2 <= 1'b1; 
        end   
        if(reg_hist_open_hmc_stat_gen_high_link2 != temp_open_hmc_stat_gen_high_link2_reg) begin
          open_hmc_stat_gen_high_link2_reg <= temp_open_hmc_stat_gen_high_link2_reg;
          dval_stat_gen_high_link2 <= 1'b1;
        end        
        if(reg_hist_open_hmc_stat_init_low_link2 != temp_open_hmc_stat_init_low_link2_reg) begin
          open_hmc_stat_init_low_link2_reg <= temp_open_hmc_stat_init_low_link2_reg;
          dval_stat_init_low_link2 <= 1'b1;
        end   
        if(reg_hist_open_hmc_stat_init_high_link2 != temp_open_hmc_stat_init_high_link2_reg) begin
          open_hmc_stat_init_high_link2_reg <= temp_open_hmc_stat_init_high_link2_reg;
          dval_stat_init_high_link2 <= 1'b1;         
        end                  
        if(reg_hist_open_hmc_ctrl_low_link2 != temp_open_hmc_ctrl_low_link2_reg) begin
          open_hmc_ctrl_low_link2_reg <= temp_open_hmc_ctrl_low_link2_reg;
          dval_ctrl_low_link2 <= 1'b1;
        end          
        if(reg_hist_open_hmc_ctrl_high_link2 != temp_open_hmc_ctrl_high_link2_reg) begin
          open_hmc_ctrl_high_link2_reg <= temp_open_hmc_ctrl_high_link2_reg;
          dval_ctrl_high_link2 <= 1'b1;
        end         
        if(reg_hist_open_hmc_sent_p_low_link2 != temp_open_hmc_sent_p_low_link2_reg) begin
          open_hmc_sent_p_low_link2_reg <= temp_open_hmc_sent_p_low_link2_reg;
          dval_sent_p_low_link2 <= 1'b1;
        end         
        if(reg_hist_open_hmc_sent_p_high_link2 != temp_open_hmc_sent_p_high_link2_reg) begin
          open_hmc_sent_p_high_link2_reg <= temp_open_hmc_sent_p_high_link2_reg;
          dval_sent_p_high_link2 <= 1'b1;
        end          
        if(reg_hist_open_hmc_sent_np_low_link2 != temp_open_hmc_sent_np_low_link2_reg) begin
          open_hmc_sent_np_low_link2_reg <= temp_open_hmc_sent_np_low_link2_reg;
          dval_sent_np_low_link2 <= 1'b1;
        end         
        if(reg_hist_open_hmc_sent_np_high_link2 != temp_open_hmc_sent_np_high_link2_reg) begin
          open_hmc_sent_np_high_link2_reg <= temp_open_hmc_sent_np_high_link2_reg;
          dval_sent_np_high_link2 <= 1'b1;
        end      
        if(reg_hist_open_hmc_sent_r_low_link2 != temp_open_hmc_sent_r_low_link2_reg) begin
          open_hmc_sent_r_low_link2_reg <= temp_open_hmc_sent_r_low_link2_reg;
          dval_sent_r_low_link2 <= 1'b1;
        end          
        if(reg_hist_open_hmc_sent_r_high_link2 != temp_open_hmc_sent_r_high_link2_reg) begin
          open_hmc_sent_r_high_link2_reg <= temp_open_hmc_sent_r_high_link2_reg;
          dval_sent_r_high_link2 <= 1'b1;
        end        
        if(reg_hist_open_hmc_poisoned_packet_low_link2 != temp_open_hmc_poisoned_packet_low_link2_reg) begin
          open_hmc_poisoned_packet_low_link2_reg <= temp_open_hmc_poisoned_packet_low_link2_reg;
          dval_poisoned_packet_low_link2 <= 1'b1;
        end          
        if(reg_hist_open_hmc_poisoned_packet_high_link2 != temp_open_hmc_poisoned_packet_high_link2_reg) begin
          open_hmc_poisoned_packet_high_link2_reg <= temp_open_hmc_poisoned_packet_high_link2_reg;
          dval_poisoned_packet_high_link2 <= 1'b1;
        end          
        if(reg_hist_open_hmc_rcvd_rsp_low_link2 != temp_open_hmc_rcvd_rsp_low_link2_reg) begin
          open_hmc_rcvd_rsp_low_link2_reg <= temp_open_hmc_rcvd_rsp_low_link2_reg;
          dval_rcvd_rsp_low_link2 <= 1'b1;
        end          
        if(reg_hist_open_hmc_rcvd_rsp_high_link2 != temp_open_hmc_rcvd_rsp_high_link2_reg) begin
          open_hmc_rcvd_rsp_high_link2_reg <= temp_open_hmc_rcvd_rsp_high_link2_reg;
          dval_rcvd_rsp_high_link2 <= 1'b1;
        end           
        if(reg_hist_open_hmc_tx_link_retries_low_link2 != temp_open_hmc_tx_link_retries_low_link2_reg) begin
          open_hmc_tx_link_retries_low_link2_reg <= temp_open_hmc_tx_link_retries_low_link2_reg;
          dval_tx_link_retries_low_link2 <= 1'b1;
        end         
        if(reg_hist_open_hmc_tx_link_retries_high_link2 != temp_open_hmc_tx_link_retries_high_link2_reg) begin
          open_hmc_tx_link_retries_high_link2_reg <= temp_open_hmc_tx_link_retries_high_link2_reg;
          dval_tx_link_retries_high_link2 <= 1'b1;
        end         
        if(reg_hist_open_hmc_err_on_rx_low_link2 != temp_open_hmc_err_on_rx_low_link2_reg) begin
          open_hmc_err_on_rx_low_link2_reg <= temp_open_hmc_err_on_rx_low_link2_reg;
          dval_err_on_rx_low_link2 <= 1'b1;
        end         
        if(reg_hist_open_hmc_err_on_rx_high_link2 != temp_open_hmc_err_on_rx_high_link2_reg) begin
          open_hmc_err_on_rx_high_link2_reg <= temp_open_hmc_err_on_rx_high_link2_reg;
          dval_err_on_rx_high_link2 <= 1'b1;
        end            
        if(reg_hist_open_hmc_run_lngth_bit_flip_low_link2 != temp_open_hmc_run_lngth_bit_flip_low_link2_reg) begin
          open_hmc_run_lngth_bit_flip_low_link2_reg <= temp_open_hmc_run_lngth_bit_flip_low_link2_reg;
          dval_run_lngth_bit_flip_low_link2 <= 1'b1;
        end        
        if(reg_hist_open_hmc_run_lngth_bit_flip_high_link2 != temp_open_hmc_run_lngth_bit_flip_high_link2_reg) begin
          open_hmc_run_lngth_bit_flip_high_link2_reg <= temp_open_hmc_run_lngth_bit_flip_high_link2_reg;
          dval_run_lngth_bit_flip_high_link2 <= 1'b1;
        end                
        if(reg_hist_open_hmc_err_abort_not_clr_low_link2 != temp_open_hmc_err_abort_not_clr_low_link2_reg) begin
          open_hmc_err_abort_not_clr_low_link2_reg <= temp_open_hmc_err_abort_not_clr_low_link2_reg;
          dval_err_abort_not_clr_low_link2 <= 1'b1;
        end        
        if(reg_hist_open_hmc_err_abort_not_clr_high_link2 != temp_open_hmc_err_abort_not_clr_high_link2_reg) begin
          open_hmc_err_abort_not_clr_high_link2_reg <= temp_open_hmc_err_abort_not_clr_high_link2_reg;
          dval_err_abort_not_clr_high_link2 <= 1'b1;
        end        

        
        if (rf_access_complete_link2) begin
          case (rf_address_link2)
            REG_OPEN_HMC_STAT_GEN: begin
              temp_open_hmc_stat_gen_low_link2_reg[31:0] <= rf_read_data_link2[31:0];
              temp_open_hmc_stat_gen_high_link2_reg[31:0] <= rf_read_data_link2[63:32];
            end
            REG_OPEN_HMC_STAT_INIT: begin
              temp_open_hmc_stat_init_low_link2_reg[31:0] <= rf_read_data_link2[31:0];
              temp_open_hmc_stat_init_high_link2_reg[31:0] <= rf_read_data_link2[63:32];
            end  
            REG_OPEN_HMC_CTRL: begin
              temp_open_hmc_ctrl_low_link2_reg[31:0] <= rf_read_data_link2[31:0];
              temp_open_hmc_ctrl_high_link2_reg[31:0] <= rf_read_data_link2[63:32];
            end
            REG_OPEN_HMC_SENT_P: begin
              temp_open_hmc_sent_p_low_link2_reg[31:0] <= rf_read_data_link2[31:0];
              temp_open_hmc_sent_p_high_link2_reg[31:0] <= rf_read_data_link2[63:32];
            end  
            REG_OPEN_HMC_SENT_NP: begin
              temp_open_hmc_sent_np_low_link2_reg[31:0] <= rf_read_data_link2[31:0];
              temp_open_hmc_sent_np_high_link2_reg[31:0] <= rf_read_data_link2[63:32];
            end              
            REG_OPEN_HMC_SENT_R: begin
              temp_open_hmc_sent_r_low_link2_reg[31:0] <= rf_read_data_link2[31:0];
              temp_open_hmc_sent_r_high_link2_reg[31:0] <= rf_read_data_link2[63:32];
            end              
            REG_OPEN_HMC_POISONED_PACKET: begin
              temp_open_hmc_poisoned_packet_low_link2_reg[31:0] <= rf_read_data_link2[31:0];
              temp_open_hmc_poisoned_packet_high_link2_reg[31:0] <= rf_read_data_link2[63:32];
            end              
            REG_OPEN_HMC_RCVD_RSP: begin
              temp_open_hmc_rcvd_rsp_low_link2_reg[31:0] <= rf_read_data_link2[31:0];
              temp_open_hmc_rcvd_rsp_high_link2_reg[31:0] <= rf_read_data_link2[63:32];
            end              
            REG_OPEN_HMC_TX_LINK_RETRIES: begin
              temp_open_hmc_tx_link_retries_low_link2_reg[31:0] <= rf_read_data_link2[31:0];
              temp_open_hmc_tx_link_retries_high_link2_reg[31:0] <= rf_read_data_link2[63:32];
            end              
            REG_OPEN_HMC_ERR_ON_RX: begin
              temp_open_hmc_err_on_rx_low_link2_reg[31:0] <= rf_read_data_link2[31:0];
              temp_open_hmc_err_on_rx_high_link2_reg[31:0] <= rf_read_data_link2[63:32];
            end              
            REG_OPEN_HMC_RUN_LNGTH_BIT_FLIP: begin
              temp_open_hmc_run_lngth_bit_flip_low_link2_reg[31:0] <= rf_read_data_link2[31:0];
              temp_open_hmc_run_lngth_bit_flip_high_link2_reg[31:0] <= rf_read_data_link2[63:32];
            end  
            REG_OPEN_HMC_ERR_ABORT_NOT_CLR: begin
              temp_open_hmc_err_abort_not_clr_low_link2_reg[31:0] <= rf_read_data_link2[31:0];
              temp_open_hmc_err_abort_not_clr_high_link2_reg[31:0] <= rf_read_data_link2[63:32];
            end             
         
            default: begin
            end
          endcase
        end
      end
    end 
  
  
/************* OpenHMC Link3 Status & Control Register Address Decoding *************/

  
   //Register data valid signals 
    reg dval_stat_gen_low_link3; 
    reg dval_stat_gen_high_link3;
    reg dval_stat_init_low_link3;
    reg dval_stat_init_high_link3;
    reg dval_ctrl_low_link3;
    reg dval_ctrl_high_link3;
    reg dval_sent_p_low_link3;
    reg dval_sent_p_high_link3;
    reg dval_sent_np_low_link3;
    reg dval_sent_np_high_link3;
    reg dval_sent_r_low_link3;
    reg dval_sent_r_high_link3;
    reg dval_poisoned_packet_low_link3;
    reg dval_poisoned_packet_high_link3;
    reg dval_rcvd_rsp_low_link3;
    reg dval_rcvd_rsp_high_link3;
    reg dval_poisoned_packet_low_link3;
    reg dval_poisoned_packet_high_link3;
    reg dval_rcvd_rsp_low_link3;
    reg dval_rcvd_rsp_high_link3;
    reg dval_tx_link_retries_low_link3;
    reg dval_tx_link_retries_high_link3;
    reg dval_err_on_rx_low_link3;
    reg dval_err_on_rx_high_link3;
    reg dval_run_lngth_bit_flip_low_link3;
    reg dval_run_lngth_bit_flip_high_link3;
    reg dval_err_abort_not_clr_low_link3;
    reg dval_err_abort_not_clr_high_link3;
    reg dval_hmc_crc_err_cnt_link3;
    
   //Register data valid counter signals 
    reg [4:0] dval_cnt_stat_gen_low_link3; 
    reg [4:0] dval_cnt_stat_gen_high_link3;
    reg [4:0] dval_cnt_stat_init_low_link3;
    reg [4:0] dval_cnt_stat_init_high_link3;
    reg [4:0] dval_cnt_ctrl_low_link3;
    reg [4:0] dval_cnt_ctrl_high_link3;
    reg [4:0] dval_cnt_sent_p_low_link3;
    reg [4:0] dval_cnt_sent_p_high_link3;
    reg [4:0] dval_cnt_sent_np_low_link3;
    reg [4:0] dval_cnt_sent_np_high_link3;
    reg [4:0] dval_cnt_sent_r_low_link3;
    reg [4:0] dval_cnt_sent_r_high_link3;
    reg [4:0] dval_cnt_poisoned_packet_low_link3;
    reg [4:0] dval_cnt_poisoned_packet_high_link3;
    reg [4:0] dval_cnt_rcvd_rsp_low_link3;
    reg [4:0] dval_cnt_rcvd_rsp_high_link3;
    reg [4:0] dval_cnt_poisoned_packet_low_link3;
    reg [4:0] dval_cnt_poisoned_packet_high_link3;
    reg [4:0] dval_cnt_rcvd_rsp_low_link3;
    reg [4:0] dval_cnt_rcvd_rsp_high_link3;
    reg [4:0] dval_cnt_tx_link_retries_low_link3;
    reg [4:0] dval_cnt_tx_link_retries_high_link3;
    reg [4:0] dval_cnt_err_on_rx_low_link3;
    reg [4:0] dval_cnt_err_on_rx_high_link3;
    reg [4:0] dval_cnt_run_lngth_bit_flip_low_link3;
    reg [4:0] dval_cnt_run_lngth_bit_flip_high_link3;
    reg [4:0] dval_cnt_err_abort_not_clr_low_link3;
    reg [4:0] dval_cnt_err_abort_not_clr_high_link3;
    reg [4:0] dval_cnt_hmc_crc_err_cnt_link3;    
  
    always @(posedge hmc_link3_clk) begin

      if (hmc_link3_rst) begin
        open_hmc_stat_gen_low_link3_reg <= 32'b0;
        open_hmc_stat_gen_high_link3_reg <= 32'b0;
        open_hmc_stat_init_low_link3_reg <= 32'b0;
        open_hmc_stat_init_high_link3_reg <= 32'b0;
        open_hmc_ctrl_low_link3_reg  <= 32'b0;
        open_hmc_ctrl_high_link3_reg  <= 32'b0;
        open_hmc_sent_p_low_link3_reg  <= 32'b0;
        open_hmc_sent_p_high_link3_reg  <= 32'b0;
        open_hmc_sent_np_low_link3_reg  <= 32'b0;
        open_hmc_sent_np_high_link3_reg  <= 32'b0;
        open_hmc_sent_r_low_link3_reg  <= 32'b0;
        open_hmc_sent_r_high_link3_reg  <= 32'b0;
        open_hmc_poisoned_packet_low_link3_reg  <= 32'b0;
        open_hmc_poisoned_packet_high_link3_reg  <= 32'b0;
        open_hmc_rcvd_rsp_low_link3_reg  <= 32'b0;
        open_hmc_rcvd_rsp_high_link3_reg  <= 32'b0;
        open_hmc_tx_link_retries_low_link3_reg  <= 32'b0;
        open_hmc_tx_link_retries_high_link3_reg  <= 32'b0;
        open_hmc_err_on_rx_low_link3_reg  <= 32'b0;
        open_hmc_err_on_rx_high_link3_reg  <= 32'b0;
        open_hmc_run_lngth_bit_flip_low_link3_reg  <= 32'b0;
        open_hmc_run_lngth_bit_flip_high_link3_reg  <= 32'b0;
        open_hmc_err_abort_not_clr_low_link3_reg  <= 32'b0;
        open_hmc_err_abort_not_clr_high_link3_reg  <= 32'b0;
        
        temp_open_hmc_stat_gen_low_link3_reg <= 32'b0;
        temp_open_hmc_stat_gen_high_link3_reg <= 32'b0;
        temp_open_hmc_stat_init_low_link3_reg <= 32'b0;
        temp_open_hmc_stat_init_high_link3_reg <= 32'b0;
        temp_open_hmc_ctrl_low_link3_reg  <= 32'b0;
        temp_open_hmc_ctrl_high_link3_reg  <= 32'b0;
        temp_open_hmc_sent_p_low_link3_reg  <= 32'b0;
        temp_open_hmc_sent_p_high_link3_reg  <= 32'b0;
        temp_open_hmc_sent_np_low_link3_reg  <= 32'b0;
        temp_open_hmc_sent_np_high_link3_reg  <= 32'b0;
        temp_open_hmc_sent_r_low_link3_reg  <= 32'b0;
        temp_open_hmc_sent_r_high_link3_reg  <= 32'b0;
        temp_open_hmc_poisoned_packet_low_link3_reg  <= 32'b0;
        temp_open_hmc_poisoned_packet_high_link3_reg  <= 32'b0;
        temp_open_hmc_rcvd_rsp_low_link3_reg  <= 32'b0;
        temp_open_hmc_rcvd_rsp_high_link3_reg  <= 32'b0;
        temp_open_hmc_tx_link_retries_low_link3_reg  <= 32'b0;
        temp_open_hmc_tx_link_retries_high_link3_reg  <= 32'b0;
        temp_open_hmc_err_on_rx_low_link3_reg  <= 32'b0;
        temp_open_hmc_err_on_rx_high_link3_reg  <= 32'b0;
        temp_open_hmc_run_lngth_bit_flip_low_link3_reg  <= 32'b0;
        temp_open_hmc_run_lngth_bit_flip_high_link3_reg  <= 32'b0;
        temp_open_hmc_err_abort_not_clr_low_link3_reg  <= 32'b0;
        temp_open_hmc_err_abort_not_clr_high_link3_reg  <= 32'b0; 
        
        reg_hist_open_hmc_stat_gen_low_link3 <= 32'b0;
        reg_hist_open_hmc_stat_gen_high_link3 <= 32'b0;
        reg_hist_open_hmc_stat_init_low_link3 <= 32'b0;
        reg_hist_open_hmc_stat_init_high_link3 <= 32'b0;
        reg_hist_open_hmc_ctrl_low_link3  <= 32'b0;
        reg_hist_open_hmc_ctrl_high_link3  <= 32'b0;
        reg_hist_open_hmc_sent_p_low_link3  <= 32'b0;
        reg_hist_open_hmc_sent_p_high_link3  <= 32'b0;
        reg_hist_open_hmc_sent_np_low_link3  <= 32'b0;
        reg_hist_open_hmc_sent_np_high_link3  <= 32'b0;
        reg_hist_open_hmc_sent_r_low_link3  <= 32'b0;
        reg_hist_open_hmc_sent_r_high_link3  <= 32'b0;
        reg_hist_open_hmc_poisoned_packet_low_link3  <= 32'b0;
        reg_hist_open_hmc_poisoned_packet_high_link3  <= 32'b0;
        reg_hist_open_hmc_rcvd_rsp_low_link3  <= 32'b0;
        reg_hist_open_hmc_rcvd_rsp_high_link3  <= 32'b0;
        reg_hist_open_hmc_tx_link_retries_low_link3  <= 32'b0;
        reg_hist_open_hmc_tx_link_retries_high_link3  <= 32'b0;
        reg_hist_open_hmc_err_on_rx_low_link3  <= 32'b0;
        reg_hist_open_hmc_err_on_rx_high_link3  <= 32'b0;
        reg_hist_open_hmc_run_lngth_bit_flip_low_link3  <= 32'b0;
        reg_hist_open_hmc_run_lngth_bit_flip_high_link3  <= 32'b0;
        reg_hist_open_hmc_err_abort_not_clr_low_link3  <= 32'b0;
        reg_hist_open_hmc_err_abort_not_clr_high_link3  <= 32'b0;        
        
        reg_hist_rx_crc_err_cnt_link3 <= 16'b0;
        hmc_crc_err_cnt_link3_reg <= 16'b0;
        
        dval_stat_gen_low_link3 <= 1'b0; 
        dval_stat_gen_high_link3 <= 1'b0;
        dval_stat_init_low_link3 <= 1'b0;
        dval_stat_init_high_link3 <= 1'b0;
        dval_ctrl_low_link3 <= 1'b0;
        dval_ctrl_high_link3 <= 1'b0;
        dval_sent_p_low_link3 <= 1'b0;
        dval_sent_p_high_link3 <= 1'b0;
        dval_sent_np_low_link3 <= 1'b0;
        dval_sent_np_high_link3 <= 1'b0;
        dval_sent_r_low_link3 <= 1'b0;
        dval_sent_r_high_link3 <= 1'b0;
        dval_poisoned_packet_low_link3 <= 1'b0;
        dval_poisoned_packet_high_link3 <= 1'b0;
        dval_rcvd_rsp_low_link3 <= 1'b0;
        dval_rcvd_rsp_high_link3 <= 1'b0;
        dval_tx_link_retries_low_link3 <= 1'b0;
        dval_tx_link_retries_high_link3 <= 1'b0;
        dval_err_on_rx_low_link3 <= 1'b0;
        dval_err_on_rx_high_link3 <= 1'b0;
        dval_run_lngth_bit_flip_low_link3 <= 1'b0;
        dval_run_lngth_bit_flip_high_link3 <= 1'b0;
        dval_err_abort_not_clr_low_link3 <= 1'b0;
        dval_err_abort_not_clr_high_link3 <= 1'b0;
        dval_hmc_crc_err_cnt_link3 <= 1'b0;  
        
        //Register data valid counter signals 
        dval_cnt_stat_gen_low_link3 <= 5'b0; 
        dval_cnt_stat_gen_high_link3 <= 5'b0; 
        dval_cnt_stat_init_low_link3 <= 5'b0; 
        dval_cnt_stat_init_high_link3 <= 5'b0; 
        dval_cnt_ctrl_low_link3 <= 5'b0; 
        dval_cnt_ctrl_high_link3 <= 5'b0; 
        dval_cnt_sent_p_low_link3 <= 5'b0; 
        dval_cnt_sent_p_high_link3 <= 5'b0;
        dval_cnt_sent_np_low_link3 <= 5'b0; 
        dval_cnt_sent_np_high_link3 <= 5'b0; 
        dval_cnt_sent_r_low_link3 <= 5'b0; 
        dval_cnt_sent_r_high_link3 <= 5'b0; 
        dval_cnt_poisoned_packet_low_link3 <= 5'b0; 
        dval_cnt_poisoned_packet_high_link3 <= 5'b0; 
        dval_cnt_rcvd_rsp_low_link3 <= 5'b0; 
        dval_cnt_rcvd_rsp_high_link3 <= 5'b0; 
        dval_cnt_poisoned_packet_low_link3 <= 5'b0; 
        dval_cnt_poisoned_packet_high_link3 <= 5'b0; 
        dval_cnt_rcvd_rsp_low_link3 <= 5'b0; 
        dval_cnt_rcvd_rsp_high_link3 <= 5'b0; 
        dval_cnt_tx_link_retries_low_link3 <= 5'b0; 
        dval_cnt_tx_link_retries_high_link3 <= 5'b0; 
        dval_cnt_err_on_rx_low_link3 <= 5'b0; 
        dval_cnt_err_on_rx_high_link3 <= 5'b0; 
        dval_cnt_run_lngth_bit_flip_low_link3 <= 5'b0; 
        dval_cnt_run_lngth_bit_flip_high_link3 <= 5'b0; 
        dval_cnt_err_abort_not_clr_low_link3 <= 5'b0; 
        dval_cnt_err_abort_not_clr_high_link3 <= 5'b0; 
        dval_cnt_hmc_crc_err_cnt_link3 <= 5'b0;          
                     
      end else begin
        //Populate History buffers
        reg_hist_rx_crc_err_cnt_link3 <= rx_crc_err_cnt_link3;
        reg_hist_open_hmc_stat_gen_low_link3 <= temp_open_hmc_stat_gen_low_link3_reg;
        reg_hist_open_hmc_stat_gen_high_link3 <= temp_open_hmc_stat_gen_high_link3_reg;
        reg_hist_open_hmc_stat_init_low_link3 <= temp_open_hmc_stat_init_low_link3_reg;
        reg_hist_open_hmc_stat_init_high_link3 <= temp_open_hmc_stat_init_high_link3_reg;
        reg_hist_open_hmc_ctrl_low_link3 <= temp_open_hmc_ctrl_low_link3_reg;
        reg_hist_open_hmc_ctrl_high_link3 <= temp_open_hmc_ctrl_high_link3_reg;
        reg_hist_open_hmc_sent_p_low_link3 <= temp_open_hmc_sent_p_low_link3_reg; 
        reg_hist_open_hmc_sent_p_high_link3 <= temp_open_hmc_sent_p_high_link3_reg;
        reg_hist_open_hmc_sent_np_low_link3 <= temp_open_hmc_sent_np_low_link3_reg;
        reg_hist_open_hmc_sent_np_high_link3 <= temp_open_hmc_sent_np_high_link3_reg;
        reg_hist_open_hmc_sent_r_low_link3 <= temp_open_hmc_sent_r_low_link3_reg;
        reg_hist_open_hmc_sent_r_high_link3 <= temp_open_hmc_sent_r_high_link3_reg;
        reg_hist_open_hmc_poisoned_packet_low_link3 <= temp_open_hmc_poisoned_packet_low_link3_reg;
        reg_hist_open_hmc_poisoned_packet_high_link3 <=  temp_open_hmc_poisoned_packet_high_link3_reg;
        reg_hist_open_hmc_rcvd_rsp_low_link3 <= temp_open_hmc_rcvd_rsp_low_link3_reg;
        reg_hist_open_hmc_rcvd_rsp_high_link3 <= temp_open_hmc_rcvd_rsp_high_link3_reg;
        reg_hist_open_hmc_tx_link_retries_low_link3 <= temp_open_hmc_tx_link_retries_low_link3_reg;
        reg_hist_open_hmc_tx_link_retries_high_link3 <= temp_open_hmc_tx_link_retries_high_link3_reg;
        reg_hist_open_hmc_err_on_rx_low_link3 <= temp_open_hmc_err_on_rx_low_link3_reg;
        reg_hist_open_hmc_err_on_rx_high_link3 <= temp_open_hmc_err_on_rx_high_link3_reg;
        reg_hist_open_hmc_run_lngth_bit_flip_low_link3 <= temp_open_hmc_run_lngth_bit_flip_low_link3_reg;
        reg_hist_open_hmc_run_lngth_bit_flip_high_link3 <= temp_open_hmc_run_lngth_bit_flip_high_link3_reg; 
        reg_hist_open_hmc_err_abort_not_clr_low_link3 <= temp_open_hmc_err_abort_not_clr_low_link3_reg;
        reg_hist_open_hmc_err_abort_not_clr_high_link3 <= temp_open_hmc_err_abort_not_clr_high_link3_reg;
        
        //Ensures Data Valid signals are longer than BSP clock 
        if (dval_stat_gen_low_link3 == 1'b1) begin        
          dval_cnt_stat_gen_low_link3 <= dval_cnt_stat_gen_low_link3 + 1;
          if(dval_cnt_stat_gen_low_link3 == 20) begin
            dval_cnt_stat_gen_low_link3 <= 5'b0;
            dval_stat_gen_low_link3 <= 1'b0; 
          end
        end
        if (dval_stat_gen_high_link3 == 1'b1) begin        
          dval_cnt_stat_gen_high_link3 <= dval_cnt_stat_gen_high_link3 + 1;
          if(dval_cnt_stat_gen_high_link3 == 20) begin
            dval_cnt_stat_gen_high_link3 <= 5'b0;
            dval_stat_gen_high_link3 <= 1'b0;
          end          
        end
        if (dval_stat_init_low_link3 == 1'b1) begin                
          dval_cnt_stat_init_low_link3 <= dval_cnt_stat_init_low_link3 + 1;
          if(dval_cnt_stat_init_low_link3 == 20) begin
            dval_cnt_stat_init_low_link3 <= 5'b0;
            dval_stat_init_low_link3 <= 1'b0;
          end          
        end
        if (dval_stat_init_high_link3 == 1'b1) begin                
          dval_cnt_stat_init_high_link3 <= dval_cnt_stat_init_high_link3 + 1;
          if(dval_cnt_stat_init_high_link3 == 20) begin
            dval_cnt_stat_init_high_link3 <= 5'b0;
            dval_stat_init_high_link3 <= 1'b0;
          end          
        end        
        if (dval_ctrl_low_link3 == 1'b1) begin                
          dval_cnt_ctrl_low_link3 <= dval_cnt_ctrl_low_link3 + 1;
          if(dval_cnt_ctrl_low_link3 == 20) begin
            dval_cnt_ctrl_low_link3 <= 5'b0;
            dval_ctrl_low_link3 <= 1'b0;
          end          
        end        
        if (dval_ctrl_high_link3 == 1'b1) begin                
          dval_cnt_ctrl_high_link3 <= dval_cnt_ctrl_high_link3 + 1;
          if(dval_cnt_ctrl_low_link3 == 20) begin
            dval_cnt_ctrl_high_link3 <= 5'b0;
            dval_ctrl_high_link3 <= 1'b0;
          end          
        end        
        if (dval_sent_p_low_link3 == 1'b1) begin                
          dval_cnt_sent_p_low_link3 <= dval_cnt_sent_p_low_link3 + 1;
          if(dval_cnt_sent_p_low_link3 == 20) begin
            dval_cnt_sent_p_low_link3 <= 5'b0;
            dval_sent_p_low_link3 <= 1'b0;
          end          
        end        
        if (dval_sent_p_high_link3 == 1'b1) begin                
          dval_cnt_sent_p_high_link3 <= dval_cnt_sent_p_high_link3 + 1;
          if(dval_cnt_sent_p_high_link3 == 20) begin
            dval_cnt_sent_p_high_link3 <= 5'b0;
            dval_sent_p_high_link3 <= 1'b0;
          end          
        end                
        if (dval_sent_np_low_link3 == 1'b1) begin                
          dval_cnt_sent_np_low_link3 <= dval_cnt_sent_np_low_link3 + 1;
          if(dval_cnt_sent_np_low_link3 == 20) begin
            dval_cnt_sent_np_low_link3 <= 5'b0;
            dval_sent_np_low_link3 <= 1'b0;
          end          
        end        
        if (dval_sent_np_high_link3 == 1'b1) begin                
          dval_cnt_sent_np_high_link3 <= dval_cnt_sent_np_high_link3 + 1;
          if(dval_cnt_sent_np_high_link3 == 20) begin
            dval_cnt_sent_np_high_link3 <= 5'b0;
            dval_sent_np_high_link3 <= 1'b0;
          end          
        end                      
        if (dval_sent_r_low_link3 == 1'b1) begin                
          dval_cnt_sent_r_low_link3 <= dval_cnt_sent_r_low_link3 + 1;
          if(dval_cnt_sent_r_low_link3 == 20) begin
            dval_cnt_sent_r_low_link3 <= 5'b0;
            dval_sent_r_low_link3 <= 1'b0;
          end          
        end        
        if (dval_sent_r_high_link3 == 1'b1) begin                
          dval_cnt_sent_r_high_link3 <= dval_cnt_sent_r_high_link3 + 1;
          if(dval_cnt_sent_r_high_link3 == 20) begin
            dval_cnt_sent_r_high_link3 <= 5'b0;
            dval_sent_r_high_link3 <= 1'b0;
          end          
        end                
        if (dval_poisoned_packet_low_link3 == 1'b1) begin                
          dval_cnt_poisoned_packet_low_link3 <= dval_cnt_poisoned_packet_low_link3 + 1;
          if(dval_cnt_poisoned_packet_low_link3 == 20) begin
            dval_cnt_poisoned_packet_low_link3 <= 5'b0;
            dval_poisoned_packet_low_link3 <= 1'b0;
          end          
        end        
        if (dval_poisoned_packet_high_link3 == 1'b1) begin                
          dval_cnt_poisoned_packet_high_link3 <= dval_cnt_poisoned_packet_high_link3 + 1;
          if(dval_cnt_poisoned_packet_high_link3 == 20) begin
            dval_cnt_poisoned_packet_high_link3 <= 5'b0;
            dval_poisoned_packet_high_link3 <= 1'b0;
          end          
        end                
        if (dval_rcvd_rsp_low_link3 == 1'b1) begin                
          dval_cnt_rcvd_rsp_low_link3 <= dval_cnt_rcvd_rsp_low_link3 + 1;
          if(dval_cnt_rcvd_rsp_low_link3 == 20) begin
            dval_cnt_rcvd_rsp_low_link3 <= 5'b0;
            dval_rcvd_rsp_low_link3 <= 1'b0;
          end          
        end        
        if (dval_rcvd_rsp_high_link3 == 1'b1) begin                
          dval_cnt_rcvd_rsp_high_link3 <= dval_cnt_rcvd_rsp_high_link3 + 1;
          if(dval_cnt_rcvd_rsp_high_link3 == 20) begin
            dval_cnt_rcvd_rsp_high_link3 <= 5'b0;
            dval_rcvd_rsp_high_link3 <= 1'b0;
          end          
        end        

        if (dval_rcvd_rsp_low_link3 == 1'b1) begin                
          dval_cnt_rcvd_rsp_low_link3 <= dval_cnt_rcvd_rsp_low_link3 + 1;
          if(dval_cnt_rcvd_rsp_low_link3 == 20) begin
            dval_cnt_rcvd_rsp_low_link3 <= 5'b0;
            dval_rcvd_rsp_low_link3 <= 1'b0;
          end          
        end        
        if (dval_rcvd_rsp_high_link3 == 1'b1) begin                
          dval_cnt_rcvd_rsp_high_link3 <= dval_cnt_rcvd_rsp_high_link3 + 1;
          if(dval_cnt_rcvd_rsp_high_link3 == 20) begin
            dval_cnt_rcvd_rsp_high_link3 <= 5'b0;
            dval_rcvd_rsp_high_link3 <= 1'b0;
          end          
        end           
        if (dval_tx_link_retries_low_link3 == 1'b1) begin                
          dval_cnt_tx_link_retries_low_link3 <= dval_cnt_tx_link_retries_low_link3 + 1;
          if(dval_cnt_tx_link_retries_low_link3 == 20) begin
            dval_cnt_tx_link_retries_low_link3 <= 5'b0;
            dval_tx_link_retries_low_link3 <= 1'b0;
          end          
        end        
        if (dval_tx_link_retries_high_link3 == 1'b1) begin                
          dval_cnt_tx_link_retries_high_link3 <= dval_cnt_tx_link_retries_high_link3 + 1;
          if(dval_cnt_tx_link_retries_high_link3 == 20) begin
            dval_cnt_tx_link_retries_high_link3 <= 5'b0;
            dval_tx_link_retries_high_link3 <= 1'b0;
          end          
        end           
        if (dval_err_on_rx_low_link3 == 1'b1) begin                
          dval_cnt_err_on_rx_low_link3 <= dval_cnt_err_on_rx_low_link3 + 1;
          if(dval_cnt_err_on_rx_low_link3 == 20) begin
            dval_cnt_err_on_rx_low_link3 <= 5'b0;
            dval_err_on_rx_low_link3 <= 1'b0;
          end          
        end        
        if (dval_err_on_rx_high_link3 == 1'b1) begin                
          dval_cnt_err_on_rx_high_link3 <= dval_cnt_err_on_rx_high_link3 + 1;
          if(dval_cnt_err_on_rx_high_link3 == 20) begin
            dval_cnt_err_on_rx_high_link3 <= 5'b0;
            dval_err_on_rx_high_link3 <= 1'b0;
          end          
        end           
        if (dval_run_lngth_bit_flip_low_link3 == 1'b1) begin                
          dval_cnt_run_lngth_bit_flip_low_link3 <= dval_cnt_run_lngth_bit_flip_low_link3 + 1;
          if(dval_cnt_run_lngth_bit_flip_low_link3 == 20) begin
            dval_cnt_run_lngth_bit_flip_low_link3 <= 5'b0;
            dval_run_lngth_bit_flip_low_link3 <= 1'b0;
          end          
        end        
        if (dval_run_lngth_bit_flip_high_link3 == 1'b1) begin                
          dval_cnt_run_lngth_bit_flip_high_link3 <= dval_cnt_run_lngth_bit_flip_high_link3 + 1;
          if(dval_cnt_run_lngth_bit_flip_high_link3 == 20) begin
            dval_cnt_run_lngth_bit_flip_high_link3 <= 5'b0;
            dval_run_lngth_bit_flip_high_link3 <= 1'b0;
          end          
        end           
        if (dval_err_abort_not_clr_low_link3 == 1'b1) begin                
          dval_cnt_err_abort_not_clr_low_link3 <= dval_cnt_err_abort_not_clr_low_link3 + 1;
          if(dval_cnt_err_abort_not_clr_low_link3 == 20) begin
            dval_cnt_err_abort_not_clr_low_link3 <= 5'b0;
            dval_err_abort_not_clr_low_link3 <= 1'b0;
          end          
        end        
        if (dval_err_abort_not_clr_high_link3 == 1'b1) begin                
          dval_cnt_err_abort_not_clr_high_link3 <= dval_cnt_err_abort_not_clr_high_link3 + 1;
          if(dval_cnt_err_abort_not_clr_high_link3 == 20) begin
            dval_cnt_err_abort_not_clr_high_link3 <= 5'b0;
            dval_err_abort_not_clr_high_link3 <= 1'b0;
          end 
          
        end   
        if (dval_hmc_crc_err_cnt_link3 == 1'b1) begin                
          dval_cnt_hmc_crc_err_cnt_link3 <= dval_cnt_hmc_crc_err_cnt_link3 + 1;
          if(dval_cnt_hmc_crc_err_cnt_link3 == 20) begin
            dval_cnt_hmc_crc_err_cnt_link3 <= 5'b0;
            dval_hmc_crc_err_cnt_link3 <= 1'b0;
          end          
        end           
        
        //Check when RX CRC error count changes and assign updated error value
        if(reg_hist_rx_crc_err_cnt_link3 != rx_crc_err_cnt_link3) begin
          hmc_crc_err_cnt_link3_reg <= rx_crc_err_cnt_link3;
          dval_hmc_crc_err_cnt_link3 <= 1'b1;
        end
        
        //Check when OpenHMC registers change and assign updated value
        if(reg_hist_open_hmc_stat_gen_low_link3 != temp_open_hmc_stat_gen_low_link3_reg) begin
          open_hmc_stat_gen_low_link3_reg <= temp_open_hmc_stat_gen_low_link3_reg;
          dval_stat_gen_low_link3 <= 1'b1; 
        end   
        if(reg_hist_open_hmc_stat_gen_high_link3 != temp_open_hmc_stat_gen_high_link3_reg) begin
          open_hmc_stat_gen_high_link3_reg <= temp_open_hmc_stat_gen_high_link3_reg;
          dval_stat_gen_high_link3 <= 1'b1;
        end        
        if(reg_hist_open_hmc_stat_init_low_link3 != temp_open_hmc_stat_init_low_link3_reg) begin
          open_hmc_stat_init_low_link3_reg <= temp_open_hmc_stat_init_low_link3_reg;
          dval_stat_init_low_link3 <= 1'b1;
        end   
        if(reg_hist_open_hmc_stat_init_high_link3 != temp_open_hmc_stat_init_high_link3_reg) begin
          open_hmc_stat_init_high_link3_reg <= temp_open_hmc_stat_init_high_link3_reg;
          dval_stat_init_high_link3 <= 1'b1;         
        end                  
        if(reg_hist_open_hmc_ctrl_low_link3 != temp_open_hmc_ctrl_low_link3_reg) begin
          open_hmc_ctrl_low_link3_reg <= temp_open_hmc_ctrl_low_link3_reg;
          dval_ctrl_low_link3 <= 1'b1;
        end          
        if(reg_hist_open_hmc_ctrl_high_link3 != temp_open_hmc_ctrl_high_link3_reg) begin
          open_hmc_ctrl_high_link3_reg <= temp_open_hmc_ctrl_high_link3_reg;
          dval_ctrl_high_link3 <= 1'b1;
        end         
        if(reg_hist_open_hmc_sent_p_low_link3 != temp_open_hmc_sent_p_low_link3_reg) begin
          open_hmc_sent_p_low_link3_reg <= temp_open_hmc_sent_p_low_link3_reg;
          dval_sent_p_low_link3 <= 1'b1;
        end         
        if(reg_hist_open_hmc_sent_p_high_link3 != temp_open_hmc_sent_p_high_link3_reg) begin
          open_hmc_sent_p_high_link3_reg <= temp_open_hmc_sent_p_high_link3_reg;
          dval_sent_p_high_link3 <= 1'b1;
        end          
        if(reg_hist_open_hmc_sent_np_low_link3 != temp_open_hmc_sent_np_low_link3_reg) begin
          open_hmc_sent_np_low_link3_reg <= temp_open_hmc_sent_np_low_link3_reg;
          dval_sent_np_low_link3 <= 1'b1;
        end         
        if(reg_hist_open_hmc_sent_np_high_link3 != temp_open_hmc_sent_np_high_link3_reg) begin
          open_hmc_sent_np_high_link3_reg <= temp_open_hmc_sent_np_high_link3_reg;
          dval_sent_np_high_link3 <= 1'b1;
        end      
        if(reg_hist_open_hmc_sent_r_low_link3 != temp_open_hmc_sent_r_low_link3_reg) begin
          open_hmc_sent_r_low_link3_reg <= temp_open_hmc_sent_r_low_link3_reg;
          dval_sent_r_low_link3 <= 1'b1;
        end          
        if(reg_hist_open_hmc_sent_r_high_link3 != temp_open_hmc_sent_r_high_link3_reg) begin
          open_hmc_sent_r_high_link3_reg <= temp_open_hmc_sent_r_high_link3_reg;
          dval_sent_r_high_link3 <= 1'b1;
        end        
        if(reg_hist_open_hmc_poisoned_packet_low_link3 != temp_open_hmc_poisoned_packet_low_link3_reg) begin
          open_hmc_poisoned_packet_low_link3_reg <= temp_open_hmc_poisoned_packet_low_link3_reg;
          dval_poisoned_packet_low_link3 <= 1'b1;
        end          
        if(reg_hist_open_hmc_poisoned_packet_high_link3 != temp_open_hmc_poisoned_packet_high_link3_reg) begin
          open_hmc_poisoned_packet_high_link3_reg <= temp_open_hmc_poisoned_packet_high_link3_reg;
          dval_poisoned_packet_high_link3 <= 1'b1;
        end          
        if(reg_hist_open_hmc_rcvd_rsp_low_link3 != temp_open_hmc_rcvd_rsp_low_link3_reg) begin
          open_hmc_rcvd_rsp_low_link3_reg <= temp_open_hmc_rcvd_rsp_low_link3_reg;
          dval_rcvd_rsp_low_link3 <= 1'b1;
        end          
        if(reg_hist_open_hmc_rcvd_rsp_high_link3 != temp_open_hmc_rcvd_rsp_high_link3_reg) begin
          open_hmc_rcvd_rsp_high_link3_reg <= temp_open_hmc_rcvd_rsp_high_link3_reg;
          dval_rcvd_rsp_high_link3 <= 1'b1;
        end           
        if(reg_hist_open_hmc_tx_link_retries_low_link3 != temp_open_hmc_tx_link_retries_low_link3_reg) begin
          open_hmc_tx_link_retries_low_link3_reg <= temp_open_hmc_tx_link_retries_low_link3_reg;
          dval_tx_link_retries_low_link3 <= 1'b1;
        end         
        if(reg_hist_open_hmc_tx_link_retries_high_link3 != temp_open_hmc_tx_link_retries_high_link3_reg) begin
          open_hmc_tx_link_retries_high_link3_reg <= temp_open_hmc_tx_link_retries_high_link3_reg;
          dval_tx_link_retries_high_link3 <= 1'b1;
        end         
        if(reg_hist_open_hmc_err_on_rx_low_link3 != temp_open_hmc_err_on_rx_low_link3_reg) begin
          open_hmc_err_on_rx_low_link3_reg <= temp_open_hmc_err_on_rx_low_link3_reg;
          dval_err_on_rx_low_link3 <= 1'b1;
        end         
        if(reg_hist_open_hmc_err_on_rx_high_link3 != temp_open_hmc_err_on_rx_high_link3_reg) begin
          open_hmc_err_on_rx_high_link3_reg <= temp_open_hmc_err_on_rx_high_link3_reg;
          dval_err_on_rx_high_link3 <= 1'b1;
        end            
        if(reg_hist_open_hmc_run_lngth_bit_flip_low_link3 != temp_open_hmc_run_lngth_bit_flip_low_link3_reg) begin
          open_hmc_run_lngth_bit_flip_low_link3_reg <= temp_open_hmc_run_lngth_bit_flip_low_link3_reg;
          dval_run_lngth_bit_flip_low_link3 <= 1'b1;
        end        
        if(reg_hist_open_hmc_run_lngth_bit_flip_high_link3 != temp_open_hmc_run_lngth_bit_flip_high_link3_reg) begin
          open_hmc_run_lngth_bit_flip_high_link3_reg <= temp_open_hmc_run_lngth_bit_flip_high_link3_reg;
          dval_run_lngth_bit_flip_high_link3 <= 1'b1;
        end                
        if(reg_hist_open_hmc_err_abort_not_clr_low_link3 != temp_open_hmc_err_abort_not_clr_low_link3_reg) begin
          open_hmc_err_abort_not_clr_low_link3_reg <= temp_open_hmc_err_abort_not_clr_low_link3_reg;
          dval_err_abort_not_clr_low_link3 <= 1'b1;
        end        
        if(reg_hist_open_hmc_err_abort_not_clr_high_link3 != temp_open_hmc_err_abort_not_clr_high_link3_reg) begin
          open_hmc_err_abort_not_clr_high_link3_reg <= temp_open_hmc_err_abort_not_clr_high_link3_reg;
          dval_err_abort_not_clr_high_link3 <= 1'b1;
        end        

        
        if (rf_access_complete_link3) begin
          case (rf_address_link3)
            REG_OPEN_HMC_STAT_GEN: begin
              temp_open_hmc_stat_gen_low_link3_reg[31:0] <= rf_read_data_link3[31:0];
              temp_open_hmc_stat_gen_high_link3_reg[31:0] <= rf_read_data_link3[63:32];
            end
            REG_OPEN_HMC_STAT_INIT: begin
              temp_open_hmc_stat_init_low_link3_reg[31:0] <= rf_read_data_link3[31:0];
              temp_open_hmc_stat_init_high_link3_reg[31:0] <= rf_read_data_link3[63:32];
            end  
            REG_OPEN_HMC_CTRL: begin
              temp_open_hmc_ctrl_low_link3_reg[31:0] <= rf_read_data_link3[31:0];
              temp_open_hmc_ctrl_high_link3_reg[31:0] <= rf_read_data_link3[63:32];
            end
            REG_OPEN_HMC_SENT_P: begin
              temp_open_hmc_sent_p_low_link3_reg[31:0] <= rf_read_data_link3[31:0];
              temp_open_hmc_sent_p_high_link3_reg[31:0] <= rf_read_data_link3[63:32];
            end  
            REG_OPEN_HMC_SENT_NP: begin
              temp_open_hmc_sent_np_low_link3_reg[31:0] <= rf_read_data_link3[31:0];
              temp_open_hmc_sent_np_high_link3_reg[31:0] <= rf_read_data_link3[63:32];
            end              
            REG_OPEN_HMC_SENT_R: begin
              temp_open_hmc_sent_r_low_link3_reg[31:0] <= rf_read_data_link3[31:0];
              temp_open_hmc_sent_r_high_link3_reg[31:0] <= rf_read_data_link3[63:32];
            end              
            REG_OPEN_HMC_POISONED_PACKET: begin
              temp_open_hmc_poisoned_packet_low_link3_reg[31:0] <= rf_read_data_link3[31:0];
              temp_open_hmc_poisoned_packet_high_link3_reg[31:0] <= rf_read_data_link3[63:32];
            end              
            REG_OPEN_HMC_RCVD_RSP: begin
              temp_open_hmc_rcvd_rsp_low_link3_reg[31:0] <= rf_read_data_link3[31:0];
              temp_open_hmc_rcvd_rsp_high_link3_reg[31:0] <= rf_read_data_link3[63:32];
            end              
            REG_OPEN_HMC_TX_LINK_RETRIES: begin
              temp_open_hmc_tx_link_retries_low_link3_reg[31:0] <= rf_read_data_link3[31:0];
              temp_open_hmc_tx_link_retries_high_link3_reg[31:0] <= rf_read_data_link3[63:32];
            end              
            REG_OPEN_HMC_ERR_ON_RX: begin
              temp_open_hmc_err_on_rx_low_link3_reg[31:0] <= rf_read_data_link3[31:0];
              temp_open_hmc_err_on_rx_high_link3_reg[31:0] <= rf_read_data_link3[63:32];
            end              
            REG_OPEN_HMC_RUN_LNGTH_BIT_FLIP: begin
              temp_open_hmc_run_lngth_bit_flip_low_link3_reg[31:0] <= rf_read_data_link3[31:0];
              temp_open_hmc_run_lngth_bit_flip_high_link3_reg[31:0] <= rf_read_data_link3[63:32];
            end  
            REG_OPEN_HMC_ERR_ABORT_NOT_CLR: begin
              temp_open_hmc_err_abort_not_clr_low_link3_reg[31:0] <= rf_read_data_link3[31:0];
              temp_open_hmc_err_abort_not_clr_high_link3_reg[31:0] <= rf_read_data_link3[63:32];
            end             
         
            default: begin
            end
          endcase
        end
      end
    end 
    

 /************* Register Clock Domain Crossing Logic *************/
 
  //Link2 Register
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )
  cdc_sync_crc_err_cnt_link2_inst(   
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_hmc_crc_err_cnt_link2),
   .IP_BUS(hmc_crc_err_cnt_link2_reg),
   .OP_TRIGGER(),
   .OP_BUS(hmc_crc_err_cnt_link2_cdc_reg)
  );    
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )    
  cdc_sync_stat_gen_low_link2_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_stat_gen_low_link2),
   .IP_BUS(open_hmc_stat_gen_low_link2_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_stat_gen_low_link2_cdc_reg)
  );  
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_stat_gen_high_link2_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_stat_gen_high_link2),
   .IP_BUS(open_hmc_stat_gen_high_link2_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_stat_gen_high_link2_cdc_reg)
  ); 

  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_stat_init_low_link2_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_stat_init_low_link2),
   .IP_BUS(open_hmc_stat_init_low_link2_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_stat_init_low_link2_cdc_reg)
  );   
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_stat_init_high_link2_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_stat_init_high_link2),
   .IP_BUS(open_hmc_stat_init_high_link2_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_stat_init_high_link2_cdc_reg)
  );   
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_ctrl_low_link2_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_ctrl_low_link2),
   .IP_BUS(open_hmc_ctrl_low_link2_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_ctrl_low_link2_cdc_reg)
  );   

  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_ctrl_high_link2_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_ctrl_high_link2),
   .IP_BUS(open_hmc_ctrl_high_link2_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_ctrl_high_link2_cdc_reg)
  ); 
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_sent_p_low_link2_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_sent_p_low_link2),
   .IP_BUS(open_hmc_sent_p_low_link2_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_sent_p_low_link2_cdc_reg)
  );   
        
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_sent_p_high_link2_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_sent_p_high_link2),
   .IP_BUS(open_hmc_sent_p_high_link2_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_sent_p_high_link2_cdc_reg)
  );   
    
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_sent_np_low_link2_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_sent_np_low_link2),
   .IP_BUS(open_hmc_sent_np_low_link2_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_sent_np_low_link2_cdc_reg)
  );   
        
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_sent_np_high_link2_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_sent_np_high_link2),
   .IP_BUS(open_hmc_sent_np_high_link2_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_sent_np_high_link2_cdc_reg)
  );   
                 
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_sent_r_low_link2_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_sent_r_low_link2),
   .IP_BUS(open_hmc_sent_r_low_link2_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_sent_r_low_link2_cdc_reg)
  );   
        
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_sent_r_high_link2_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_sent_r_high_link2),
   .IP_BUS(open_hmc_sent_r_high_link2_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_sent_r_high_link2_cdc_reg)
  );   
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_poisoned_packet_low_link2_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_poisoned_packet_low_link2),
   .IP_BUS(open_hmc_poisoned_packet_low_link2_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_poisoned_packet_low_link2_cdc_reg)
  );   
        
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_poisoned_packet_high_link2_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_poisoned_packet_high_link2),
   .IP_BUS(open_hmc_poisoned_packet_high_link2_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_poisoned_packet_high_link2_cdc_reg)
  );
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_rcvd_rsp_low_link2_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_rcvd_rsp_low_link2),
   .IP_BUS(open_hmc_rcvd_rsp_low_link2_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_rcvd_rsp_low_link2_cdc_reg)
  );  
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_rcvd_rsp_high_link2_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_rcvd_rsp_high_link2),
   .IP_BUS(open_hmc_rcvd_rsp_high_link2_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_rcvd_rsp_high_link2_cdc_reg)
  );   
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )    
  cdc_sync_tx_link_retries_low_link2_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_tx_link_retries_low_link2),
   .IP_BUS(open_hmc_tx_link_retries_low_link2_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_tx_link_retries_low_link2_cdc_reg)
  );   
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_tx_link_retries_high_link2_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_tx_link_retries_high_link2),
   .IP_BUS(open_hmc_tx_link_retries_high_link2_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_tx_link_retries_high_link2_cdc_reg)
  );  
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_err_on_rx_low_link2_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_err_on_rx_low_link2),
   .IP_BUS(open_hmc_err_on_rx_low_link2_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_err_on_rx_low_link2_cdc_reg)
  );   
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_err_on_rx_high_link2_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_err_on_rx_high_link2),
   .IP_BUS(open_hmc_err_on_rx_high_link2_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_err_on_rx_high_link2_cdc_reg)
  );  
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_run_lngth_bit_flip_low_link2_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_run_lngth_bit_flip_low_link2),
   .IP_BUS(open_hmc_run_lngth_bit_flip_low_link2_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_run_lngth_bit_flip_low_link2_cdc_reg)
  ); 
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_run_lngth_bit_flip_high_link2_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_run_lngth_bit_flip_high_link2),
   .IP_BUS(open_hmc_run_lngth_bit_flip_high_link2_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_run_lngth_bit_flip_high_link2_cdc_reg)
  );   
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_err_abort_not_clr_low_link2_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_err_abort_not_clr_low_link2),
   .IP_BUS(open_hmc_err_abort_not_clr_low_link2_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_err_abort_not_clr_low_link2_cdc_reg)
  );   
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_err_abort_not_clr_high_link2_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_err_abort_not_clr_high_link2),
   .IP_BUS(open_hmc_err_abort_not_clr_high_link2_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_err_abort_not_clr_high_link2_cdc_reg)
  );   

  
  //Link3 Registers
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_crc_err_cnt_link3_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_hmc_crc_err_cnt_link3),
   .IP_BUS(hmc_crc_err_cnt_link3_reg),
   .OP_TRIGGER(),
   .OP_BUS(hmc_crc_err_cnt_link3_cdc_reg)
  );    
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_stat_gen_low_link3_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_stat_gen_low_link3),
   .IP_BUS(open_hmc_stat_gen_low_link3_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_stat_gen_low_link3_cdc_reg)
  );  
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_stat_gen_high_link3_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_stat_gen_high_link3),
   .IP_BUS(open_hmc_stat_gen_high_link3_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_stat_gen_high_link3_cdc_reg)
  ); 
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_stat_init_low_link3_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_stat_init_low_link3),
   .IP_BUS(open_hmc_stat_init_low_link3_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_stat_init_low_link3_cdc_reg)
  );   
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_stat_init_high_link3_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_stat_init_high_link3),
   .IP_BUS(open_hmc_stat_init_high_link3_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_stat_init_high_link3_cdc_reg)
  );   
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_ctrl_low_link3_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_ctrl_low_link3),
   .IP_BUS(open_hmc_ctrl_low_link3_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_ctrl_low_link3_cdc_reg)
  );   

  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_ctrl_high_link3_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_ctrl_high_link3),
   .IP_BUS(open_hmc_ctrl_high_link3_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_ctrl_high_link3_cdc_reg)
  ); 
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_sent_p_low_link3_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_sent_p_low_link3),
   .IP_BUS(open_hmc_sent_p_low_link3_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_sent_p_low_link3_cdc_reg)
  );   
        
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_sent_p_high_link3_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_sent_p_high_link3),
   .IP_BUS(open_hmc_sent_p_high_link3_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_sent_p_high_link3_cdc_reg)
  );   
    
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_sent_np_low_link3_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_sent_np_low_link3),
   .IP_BUS(open_hmc_sent_np_low_link3_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_sent_np_low_link3_cdc_reg)
  );   
        
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_sent_np_high_link3_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_sent_np_high_link3),
   .IP_BUS(open_hmc_sent_np_high_link3_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_sent_np_high_link3_cdc_reg)
  );   
                 
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_sent_r_low_link3_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_sent_r_low_link3),
   .IP_BUS(open_hmc_sent_r_low_link3_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_sent_r_low_link3_cdc_reg)
  );   
        
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_sent_r_high_link3_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_sent_r_high_link3),
   .IP_BUS(open_hmc_sent_r_high_link3_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_sent_r_high_link3_cdc_reg)
  );   
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_poisoned_packet_low_link3_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_poisoned_packet_low_link3),
   .IP_BUS(open_hmc_poisoned_packet_low_link3_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_poisoned_packet_low_link3_cdc_reg)
  );   
        
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_poisoned_packet_high_link3_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_poisoned_packet_high_link3),
   .IP_BUS(open_hmc_poisoned_packet_high_link3_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_poisoned_packet_high_link3_cdc_reg)
  );
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_rcvd_rsp_low_link3_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_rcvd_rsp_low_link3),
   .IP_BUS(open_hmc_rcvd_rsp_low_link3_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_rcvd_rsp_low_link3_cdc_reg)
  );  
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_rcvd_rsp_high_link3_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_rcvd_rsp_high_link3),
   .IP_BUS(open_hmc_rcvd_rsp_high_link3_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_rcvd_rsp_high_link3_cdc_reg)
  );   
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_tx_link_retries_low_link3_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_tx_link_retries_low_link3),
   .IP_BUS(open_hmc_tx_link_retries_low_link3_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_tx_link_retries_low_link3_cdc_reg)
  );   
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_tx_link_retries_high_link3_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_tx_link_retries_high_link3),
   .IP_BUS(open_hmc_tx_link_retries_high_link3_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_tx_link_retries_high_link3_cdc_reg)
  );  
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_err_on_rx_low_link3_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_err_on_rx_low_link3),
   .IP_BUS(open_hmc_err_on_rx_low_link3_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_err_on_rx_low_link3_cdc_reg)
  );   
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_err_on_rx_high_link3_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_err_on_rx_high_link3),
   .IP_BUS(open_hmc_err_on_rx_high_link3_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_err_on_rx_high_link3_cdc_reg)
  );  
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_run_lngth_bit_flip_low_link3_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_run_lngth_bit_flip_low_link3),
   .IP_BUS(open_hmc_run_lngth_bit_flip_low_link3_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_run_lngth_bit_flip_low_link3_cdc_reg)
  ); 
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_run_lngth_bit_flip_high_link3_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_run_lngth_bit_flip_high_link3),
   .IP_BUS(open_hmc_run_lngth_bit_flip_high_link3_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_run_lngth_bit_flip_high_link3_cdc_reg)
  );   
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_err_abort_not_clr_low_link3_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_err_abort_not_clr_low_link3),
   .IP_BUS(open_hmc_err_abort_not_clr_low_link3_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_err_abort_not_clr_low_link3_cdc_reg)
  );   
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_err_abort_not_clr_high_link3_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(),  
   .IP_BUS_VALID(dval_err_abort_not_clr_high_link3),
   .IP_BUS(open_hmc_err_abort_not_clr_high_link3_reg),
   .OP_TRIGGER(),
   .OP_BUS(open_hmc_err_abort_not_clr_high_link3_cdc_reg)
  );  
  
  //General HMC Status Registers
  //These registers must not be cleared until they are read by the user
  
  wire dval_hmc_status_cdc;
  wire dval_hmc_err_rsp_packet_link2_cdc;
  wire dval_hmc_err_rsp_packet_link3_cdc;
  wire dval_errstat_link2_cdc;
  wire dval_errstat_link3_cdc;

  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_hmc_status_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(dval_hmc_status),  
   .IP_BUS_VALID(dval_hmc_status),
   .IP_BUS(hmc_status_reg),
   .OP_TRIGGER(dval_hmc_status_cdc),
   .OP_BUS(hmc_status_cdc_reg)
  );    
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_hmc_err_rsp_packet_link2_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(dval_hmc_err_rsp_packet_link2),  
   .IP_BUS_VALID(dval_hmc_err_rsp_packet_link2),
   .IP_BUS(hmc_err_rsp_packet_link2_reg),
   .OP_TRIGGER(dval_hmc_err_rsp_packet_link2_cdc),
   .OP_BUS(hmc_err_rsp_packet_link2_cdc_reg)
  );   
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_hmc_err_rsp_packet_link3_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(dval_hmc_err_rsp_packet_link3),  
   .IP_BUS_VALID(dval_hmc_err_rsp_packet_link3),
   .IP_BUS(hmc_err_rsp_packet_link3_reg),
   .OP_TRIGGER(dval_hmc_err_rsp_packet_link3_cdc),
   .OP_BUS(hmc_err_rsp_packet_link3_cdc_reg)
  );  
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_errstat_link2_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(dval_errstat_link2),  
   .IP_BUS_VALID(dval_errstat_link2),
   .IP_BUS(hmc_errstat_link2_reg),
   .OP_TRIGGER(dval_errstat_link2_cdc),
   .OP_BUS(hmc_errstat_link2_cdc_reg)
  );  
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_sync_errstat_link3_inst(
   .IP_CLK(wb_clk_i),
   .IP_RESET(wb_rst_i),
   .IP_TRIGGER(dval_errstat_link3),  
   .IP_BUS_VALID(dval_errstat_link3),
   .IP_BUS(hmc_errstat_link3_reg),
   .OP_TRIGGER(dval_errstat_link3_cdc),
   .OP_BUS(hmc_errstat_link3_cdc_reg)
  );
  
  //Register Latch Reset Control 
  wire hmc_status_post_ok_latch_reset_cdc;
  wire hmc_status_init_done_latch_reset_cdc;
  wire hmc_status_hmc_ok_latch_reset_cdc; 
  wire hmc_err_rsp_packet_link2_latch_reset_cdc;
  wire hmc_err_rsp_packet_link3_latch_reset_cdc;
  wire hmc_errstat_link2_latch_reset_cdc;
  wire hmc_errstat_link3_latch_reset_cdc;
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_hmc_status_post_ok_latch_rst_inst(
   .IP_CLK(user_clk),
   .IP_RESET(user_rst),
   .IP_TRIGGER(hmc_status_post_ok_latch_reset),  
   .IP_BUS_VALID(),
   .IP_BUS(),
   .OP_TRIGGER(hmc_status_post_ok_latch_reset_cdc),
   .OP_BUS()
  ); 
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_hmc_status_init_done_latch_rst_inst(
   .IP_CLK(user_clk),
   .IP_RESET(user_rst),
   .IP_TRIGGER(hmc_status_init_done_latch_reset),  
   .IP_BUS_VALID(),
   .IP_BUS(),
   .OP_TRIGGER(hmc_status_init_done_latch_reset_cdc),
   .OP_BUS()
  );   
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_hmc_status_hmc_ok_latch_rst_inst(
   .IP_CLK(user_clk),
   .IP_RESET(user_rst),
   .IP_TRIGGER(hmc_status_hmc_ok_latch_reset),  
   .IP_BUS_VALID(),
   .IP_BUS(),
   .OP_TRIGGER(hmc_status_hmc_ok_latch_reset_cdc),
   .OP_BUS()
  );    
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_hmc_err_rsp_packet_link2_latch_rst_inst(
   .IP_CLK(user_clk),
   .IP_RESET(user_rst),
   .IP_TRIGGER(hmc_err_rsp_packet_link2_latch_reset),  
   .IP_BUS_VALID(),
   .IP_BUS(),
   .OP_TRIGGER(hmc_err_rsp_packet_link2_latch_reset_cdc),
   .OP_BUS()
  );   
   
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_hmc_err_rsp_packet_link3_latch_rst_inst(
   .IP_CLK(user_clk),
   .IP_RESET(user_rst),
   .IP_TRIGGER(hmc_err_rsp_packet_link3_latch_reset),  
   .IP_BUS_VALID(),
   .IP_BUS(),
   .OP_TRIGGER(hmc_err_rsp_packet_link3_latch_reset_cdc),
   .OP_BUS()
  ); 
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_hmc_errstat_link2_latch_rst_inst(
   .IP_CLK(user_clk),
   .IP_RESET(user_rst),
   .IP_TRIGGER(hmc_errstat_link2_latch_reset),  
   .IP_BUS_VALID(),
   .IP_BUS(),
   .OP_TRIGGER(hmc_errstat_link2_latch_reset_cdc),
   .OP_BUS()
  );  
  
  cdc_synchroniser #(
    .G_BUS_WIDTH(32)
  )  
  cdc_hmc_errstat_link3_latch_rst_inst(
   .IP_CLK(user_clk),
   .IP_RESET(user_rst),
   .IP_TRIGGER(hmc_errstat_link3_latch_reset),  
   .IP_BUS_VALID(),
   .IP_BUS(),
   .OP_TRIGGER(hmc_errstat_link3_latch_reset_cdc),
   .OP_BUS()
  );    
  
  /************* WB Address Decoding *************/

  wire opb_sel = wb_stb_i;

  wire [31:0] local_addr = wb_adr_i;

  localparam REGISTERS_OFFSET = 32'h00000000;
  localparam REGISTERS_HIGH   = 32'hFFFFFFFF;


  reg opb_ack;
  wire opb_trans = wb_cyc_i && wb_stb_i && !opb_ack;

  wire reg_sel   = opb_trans && (local_addr >= REGISTERS_OFFSET) && (local_addr <= REGISTERS_HIGH);

  wire [31:0] reg_addr   = local_addr - REGISTERS_OFFSET;  
  
  
  assign wb_err_o = 1'b0;

  reg [5:0] opb_data_src;
  
  reg [31:0] hmc_status_out_reg;
  reg [31:0] hmc_err_rsp_packet_link2_out_reg;
  reg [31:0] hmc_err_rsp_packet_link3_out_reg;
  reg [31:0] hmc_errstat_link2_out_reg;
  reg [31:0] hmc_errstat_link3_out_reg;
  
  reg hmc_status_post_ok_latch_reset;
  reg hmc_status_init_done_latch_reset;
  reg hmc_status_hmc_ok_latch_reset;
  reg hmc_err_rsp_packet_link2_latch_reset;
  reg hmc_err_rsp_packet_link3_latch_reset;
  reg hmc_errstat_link2_latch_reset;
  reg hmc_errstat_link3_latch_reset;
  
  always @(posedge wb_clk_i) begin


    if (wb_rst_i) begin
      opb_data_src      <= 6'b0;      
      hmc_status_out_reg <= 32'b0;
      hmc_err_rsp_packet_link2_out_reg <= 32'b0;
      hmc_err_rsp_packet_link3_out_reg <= 32'b0;
      hmc_errstat_link2_out_reg <= 32'b0;
      hmc_errstat_link3_out_reg <= 32'b0;
      hmc_status_post_ok_latch_reset <= 1'b1;
      hmc_status_init_done_latch_reset <= 1'b1;
      hmc_status_hmc_ok_latch_reset <= 1'b1;
      hmc_err_rsp_packet_link2_latch_reset <= 1'b1;
      hmc_err_rsp_packet_link3_latch_reset <= 1'b1;
      hmc_errstat_link2_latch_reset <= 1'b1;
      hmc_errstat_link3_latch_reset <= 1'b1;
    end else begin
      hmc_status_post_ok_latch_reset <= 1'b0;
      hmc_status_init_done_latch_reset <= 1'b0;
      hmc_status_hmc_ok_latch_reset <= 1'b0;    
      hmc_err_rsp_packet_link2_latch_reset <= 1'b0;
      hmc_err_rsp_packet_link3_latch_reset <= 1'b0;
      hmc_errstat_link2_latch_reset <= 1'b0;
      hmc_errstat_link3_latch_reset <= 1'b0;
      //strobes
      opb_ack <= 1'b0;
      if (opb_trans) begin
        opb_ack <= 1'b1;
      end  

      // Save error or fault until it is read by user, so as not to miss any failures
      if (reg_sel) begin
        opb_data_src <= reg_addr[7:2];
          case (reg_addr[7:2])
            REG_HMC_STATUS: begin            
              hmc_status_out_reg <= hmc_status_cdc_reg;
              hmc_status_post_ok_latch_reset <= 1'b1;
              hmc_status_init_done_latch_reset <= 1'b1;
              hmc_status_hmc_ok_latch_reset <= 1'b1;
            end
            REG_HMC_ERR_RSP_PACKET_LINK2: begin            
              hmc_err_rsp_packet_link2_out_reg <= hmc_err_rsp_packet_link2_cdc_reg;
              hmc_err_rsp_packet_link2_latch_reset <= 1'b1;
            end
            REG_HMC_ERR_RSP_PACKET_LINK3: begin            
              hmc_err_rsp_packet_link3_out_reg <= hmc_err_rsp_packet_link3_cdc_reg;
              hmc_err_rsp_packet_link3_latch_reset <= 1'b1;
            end
            REG_HMC_ERRSTAT_LINK2: begin            
              hmc_errstat_link2_out_reg <= hmc_errstat_link2_cdc_reg;
              hmc_errstat_link2_latch_reset <= 1'b1;
            end
            REG_HMC_ERRSTAT_LINK3: begin            
              hmc_errstat_link3_out_reg <= hmc_errstat_link3_cdc_reg;
              hmc_errstat_link3_latch_reset <= 1'b1;
            end            
            default: begin
            end
          endcase
      end
    end 
  end
  
  

  // memory assignments
                             //Link2
  wire [31:0] opb_data_int = opb_data_src == REG_OPEN_HMC_STAT_GEN_LOW_LINK2 ? open_hmc_stat_gen_low_link2_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_STAT_GEN_HIGH_LINK2 ? open_hmc_stat_gen_high_link2_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_STAT_INIT_LOW_LINK2 ? open_hmc_stat_init_low_link2_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_STAT_INIT_HIGH_LINK2 ? open_hmc_stat_init_high_link2_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_CTRL_LOW_LINK2 ? open_hmc_ctrl_low_link2_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_CTRL_HIGH_LINK2 ? open_hmc_ctrl_high_link2_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_SENT_P_LOW_LINK2 ? open_hmc_sent_p_low_link2_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_SENT_P_HIGH_LINK2 ? open_hmc_sent_p_high_link2_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_SENT_NP_LOW_LINK2 ? open_hmc_sent_np_low_link2_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_SENT_NP_HIGH_LINK2 ? open_hmc_sent_np_high_link2_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_SENT_R_LOW_LINK2 ? open_hmc_sent_r_low_link2_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_SENT_R_HIGH_LINK2 ? open_hmc_sent_r_high_link2_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_POISONED_PACKET_LOW_LINK2 ? open_hmc_poisoned_packet_low_link2_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_POISONED_PACKET_HIGH_LINK2 ? open_hmc_poisoned_packet_high_link2_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_RCVD_RSP_LOW_LINK2 ? open_hmc_rcvd_rsp_low_link2_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_RCVD_RSP_HIGH_LINK2 ? open_hmc_rcvd_rsp_high_link2_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_TX_LINK_RETRIES_LOW_LINK2 ? open_hmc_tx_link_retries_low_link2_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_TX_LINK_RETRIES_HIGH_LINK2 ? open_hmc_tx_link_retries_high_link2_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_ERR_ON_RX_LOW_LINK2 ? open_hmc_err_on_rx_low_link2_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_ERR_ON_RX_HIGH_LINK2 ? open_hmc_err_on_rx_high_link2_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_RUN_LNGTH_BIT_FLIP_LOW_LINK2 ? open_hmc_run_lngth_bit_flip_low_link2_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_RUN_LNGTH_BIT_FLIP_HIGH_LINK2 ? open_hmc_run_lngth_bit_flip_high_link2_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_ERR_ABORT_NOT_CLR_LOW_LINK2 ? open_hmc_err_abort_not_clr_low_link2_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_ERR_ABORT_NOT_CLR_HIGH_LINK2 ? open_hmc_err_abort_not_clr_high_link2_cdc_reg[31:0] :
                             opb_data_src == REG_HMC_ERR_RSP_PACKET_LINK2 ? hmc_err_rsp_packet_link2_out_reg[31:0] :
                             opb_data_src == REG_HMC_ERRSTAT_LINK2 ? hmc_errstat_link2_out_reg[31:0] :
                             opb_data_src == REG_HMC_CRC_ERR_CNT_LINK2 ? hmc_crc_err_cnt_link2_cdc_reg[31:0] :
                             //Link3
                             opb_data_src == REG_OPEN_HMC_STAT_GEN_LOW_LINK3 ? open_hmc_stat_gen_low_link3_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_STAT_GEN_HIGH_LINK3 ? open_hmc_stat_gen_high_link3_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_STAT_INIT_LOW_LINK3 ? open_hmc_stat_init_low_link3_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_STAT_INIT_HIGH_LINK3 ? open_hmc_stat_init_high_link3_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_CTRL_LOW_LINK3 ? open_hmc_ctrl_low_link3_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_CTRL_HIGH_LINK3 ? open_hmc_ctrl_high_link3_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_SENT_P_LOW_LINK3 ? open_hmc_sent_p_low_link3_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_SENT_P_HIGH_LINK3 ? open_hmc_sent_p_high_link3_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_SENT_NP_LOW_LINK3 ? open_hmc_sent_np_low_link3_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_SENT_NP_HIGH_LINK3 ? open_hmc_sent_np_high_link3_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_SENT_R_LOW_LINK3 ? open_hmc_sent_r_low_link3_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_SENT_R_HIGH_LINK3 ? open_hmc_sent_r_high_link3_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_POISONED_PACKET_LOW_LINK3 ? open_hmc_poisoned_packet_low_link3_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_POISONED_PACKET_HIGH_LINK3 ? open_hmc_poisoned_packet_high_link3_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_RCVD_RSP_LOW_LINK3 ? open_hmc_rcvd_rsp_low_link3_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_RCVD_RSP_HIGH_LINK3 ? open_hmc_rcvd_rsp_high_link3_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_TX_LINK_RETRIES_LOW_LINK3 ? open_hmc_tx_link_retries_low_link3_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_TX_LINK_RETRIES_HIGH_LINK3 ? open_hmc_tx_link_retries_high_link3_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_ERR_ON_RX_LOW_LINK3 ? open_hmc_err_on_rx_low_link3_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_ERR_ON_RX_HIGH_LINK3 ? open_hmc_err_on_rx_high_link3_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_RUN_LNGTH_BIT_FLIP_LOW_LINK3 ? open_hmc_run_lngth_bit_flip_low_link3_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_RUN_LNGTH_BIT_FLIP_HIGH_LINK3 ? open_hmc_run_lngth_bit_flip_high_link3_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_ERR_ABORT_NOT_CLR_LOW_LINK3 ? open_hmc_err_abort_not_clr_low_link3_cdc_reg[31:0] :
                             opb_data_src == REG_OPEN_HMC_ERR_ABORT_NOT_CLR_HIGH_LINK3 ? open_hmc_err_abort_not_clr_high_link3_cdc_reg[31:0] :
                             opb_data_src == REG_HMC_ERR_RSP_PACKET_LINK3 ? hmc_err_rsp_packet_link3_out_reg[31:0] :
                             opb_data_src == REG_HMC_ERRSTAT_LINK3 ? hmc_errstat_link3_out_reg[31:0] :
                             opb_data_src == REG_HMC_CRC_ERR_CNT_LINK3 ? hmc_crc_err_cnt_link3_cdc_reg[31:0] :
                             //HMC Status
                             opb_data_src == REG_HMC_STATUS ? hmc_status_out_reg[31:0] :
                                                                         32'd0;  
                                                                
  wire [31:0] wb_dat_o_int;
  assign wb_dat_o_int = opb_data_int;

  assign wb_dat_o = wb_ack_o ? wb_dat_o_int : 32'b0;

  assign wb_ack_o = opb_ack;
  assign wb_err_o = 1'b0;

endmodule
