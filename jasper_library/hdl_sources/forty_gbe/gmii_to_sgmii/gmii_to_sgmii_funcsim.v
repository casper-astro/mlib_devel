// Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2014.3.1 (lin64) Build 1056140 Thu Oct 30 16:30:39 MDT 2014
// Date        : Thu Mar 24 13:42:24 2016
// Host        : adam-cm running 64-bit Ubuntu 14.04.4 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/aisaacson/work/git_work/ska_sa/projects/skarab_bsp_firmware/firmware/FRM123701U1R1/Vivado/IP/gmii_to_sgmii/gmii_to_sgmii_funcsim.v
// Design      : gmii_to_sgmii
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7vx690tffg1927-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* downgradeipidentifiedwarnings = "yes" *) (* core_generation_info = "gmii_to_sgmii,gig_ethernet_pcs_pma_v14_2,{x_ipProduct=Vivado 2014.2,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=gig_ethernet_pcs_pma,x_ipVersion=14.2,x_ipCoreRevision=1,x_ipLanguage=VHDL,c_elaboration_transient_dir=.,c_component_name=gmii_to_sgmii,c_family=virtex7,c_is_sgmii=true,c_use_transceiver=true,c_use_tbi=false,c_use_lvds=false,c_has_an=true,c_has_mdio=false,c_has_ext_mdio=false,c_sgmii_phy_mode=false,c_dynamic_switching=false,c_transceiver_mode=A,c_sgmii_fabric_buffer=true,c_1588=0,gt_rx_byte_width=1,C_EMAC_IF_TEMAC=true,C_PHYADDR=1,EXAMPLE_SIMULATION=0,c_support_level=true,c_sub_core_name=gmii_to_sgmii_gt,c_transceivercontrol=false,c_xdevicefamily=xc7vx690t}" *) (* x_core_info = "gig_ethernet_pcs_pma_v14_2,Vivado 2014.2" *) 
(* NotValidForBitStream *)
module gmii_to_sgmii
   (gtrefclk_p,
    gtrefclk_n,
    gtrefclk_out,
    txp,
    txn,
    rxp,
    rxn,
    resetdone,
    userclk_out,
    userclk2_out,
    rxuserclk_out,
    rxuserclk2_out,
    pma_reset_out,
    mmcm_locked_out,
    independent_clock_bufg,
    sgmii_clk_r,
    sgmii_clk_f,
    sgmii_clk_en,
    gmii_txd,
    gmii_tx_en,
    gmii_tx_er,
    gmii_rxd,
    gmii_rx_dv,
    gmii_rx_er,
    gmii_isolate,
    configuration_vector,
    an_interrupt,
    an_adv_config_vector,
    an_restart_config,
    speed_is_10_100,
    speed_is_100,
    status_vector,
    reset,
    signal_detect,
    gt0_qplloutclk_out,
    gt0_qplloutrefclk_out);
  input gtrefclk_p;
  input gtrefclk_n;
  output gtrefclk_out;
  output txp;
  output txn;
  input rxp;
  input rxn;
  output resetdone;
  output userclk_out;
  output userclk2_out;
  output rxuserclk_out;
  output rxuserclk2_out;
  output pma_reset_out;
  output mmcm_locked_out;
  input independent_clock_bufg;
  output sgmii_clk_r;
  output sgmii_clk_f;
  output sgmii_clk_en;
  input [7:0]gmii_txd;
  input gmii_tx_en;
  input gmii_tx_er;
  output [7:0]gmii_rxd;
  output gmii_rx_dv;
  output gmii_rx_er;
  output gmii_isolate;
  input [4:0]configuration_vector;
  output an_interrupt;
  input [15:0]an_adv_config_vector;
  input an_restart_config;
  input speed_is_10_100;
  input speed_is_100;
  output [15:0]status_vector;
  input reset;
  input signal_detect;
  output gt0_qplloutclk_out;
  output gt0_qplloutrefclk_out;

  wire \<const0> ;
  wire [15:0]an_adv_config_vector;
  wire an_interrupt;
  wire an_restart_config;
  wire [4:0]configuration_vector;
  wire gmii_isolate;
  wire gmii_rx_dv;
  wire gmii_rx_er;
  wire [7:0]gmii_rxd;
  wire gmii_tx_en;
  wire gmii_tx_er;
  wire [7:0]gmii_txd;
  wire gt0_qplloutclk_out;
  wire gt0_qplloutrefclk_out;
  wire gtrefclk_n;
  wire gtrefclk_out;
  wire gtrefclk_p;
  wire independent_clock_bufg;
  wire mmcm_locked_out;
  wire pma_reset_out;
  wire reset;
  wire resetdone;
  wire rxn;
  wire rxp;
  wire rxuserclk_out;
  wire sgmii_clk_en;
  wire sgmii_clk_f;
  wire sgmii_clk_r;
  wire signal_detect;
  wire speed_is_100;
  wire speed_is_10_100;
  wire [13:0]\^status_vector ;
  wire txn;
  wire txp;
  wire userclk2_out;
  wire userclk_out;

  assign rxuserclk2_out = rxuserclk_out;
  assign status_vector[15] = \<const0> ;
  assign status_vector[14] = \<const0> ;
  assign status_vector[13:9] = \^status_vector [13:9];
  assign status_vector[8] = \<const0> ;
  assign status_vector[7:0] = \^status_vector [7:0];
GND GND
       (.G(\<const0> ));
gmii_to_sgmiigmii_to_sgmii_support U0
       (.O1(gmii_isolate),
        .Q(pma_reset_out),
        .an_adv_config_vector(an_adv_config_vector[11]),
        .an_interrupt(an_interrupt),
        .an_restart_config(an_restart_config),
        .configuration_vector(configuration_vector),
        .gmii_rx_dv(gmii_rx_dv),
        .gmii_rx_er(gmii_rx_er),
        .gmii_rxd(gmii_rxd),
        .gmii_tx_en(gmii_tx_en),
        .gmii_tx_er(gmii_tx_er),
        .gmii_txd(gmii_txd),
        .gt0_qplloutclk_out(gt0_qplloutclk_out),
        .gt0_qplloutrefclk_out(gt0_qplloutrefclk_out),
        .gtrefclk_n(gtrefclk_n),
        .gtrefclk_out(gtrefclk_out),
        .gtrefclk_p(gtrefclk_p),
        .independent_clock_bufg(independent_clock_bufg),
        .mmcm_locked_out(mmcm_locked_out),
        .reset(reset),
        .resetdone(resetdone),
        .rxn(rxn),
        .rxp(rxp),
        .rxuserclk2_out(rxuserclk_out),
        .sgmii_clk_en(sgmii_clk_en),
        .sgmii_clk_f(sgmii_clk_f),
        .sgmii_clk_r(sgmii_clk_r),
        .signal_detect(signal_detect),
        .speed_is_100(speed_is_100),
        .speed_is_10_100(speed_is_10_100),
        .status_vector({\^status_vector [13:9],\^status_vector [7:0]}),
        .txn(txn),
        .txp(txp),
        .userclk2_out(userclk2_out),
        .userclk_out(userclk_out));
endmodule

(* ORIG_REF_NAME = "AUTO_NEG" *) 
module gmii_to_sgmiiAUTO_NEG__parameterized0
   (STAT_VEC_DUPLEX_MODE_RSLVD,
    status_vector,
    XMIT_DATA_INT,
    O1,
    O2,
    ACKNOWLEDGE_MATCH_2,
    O3,
    an_interrupt,
    O4,
    O5,
    XMIT_DATA,
    O6,
    XMIT_CONFIG,
    D,
    O7,
    I1,
    Q,
    CLK,
    RESTART_AN_SET,
    I2,
    RX_IDLE,
    I3,
    I4,
    I5,
    I6,
    RX_CONFIG_VALID,
    ACKNOWLEDGE_MATCH_3,
    RXSYNC_STATUS,
    RX_RUDI_INVALID,
    data_out,
    p_0_in,
    MASK_RUDI_BUFERR_TIMER0,
    an_adv_config_vector,
    EOP_REG1,
    I7,
    I8,
    I9,
    I10,
    SYNC_STATUS_HELD,
    S,
    I11,
    SOP_REG3,
    I12,
    I13,
    SR);
  output STAT_VEC_DUPLEX_MODE_RSLVD;
  output [5:0]status_vector;
  output XMIT_DATA_INT;
  output O1;
  output O2;
  output ACKNOWLEDGE_MATCH_2;
  output O3;
  output an_interrupt;
  output O4;
  output O5;
  output XMIT_DATA;
  output [3:0]O6;
  output XMIT_CONFIG;
  output [2:0]D;
  output [2:0]O7;
  input I1;
  input [15:0]Q;
  input CLK;
  input RESTART_AN_SET;
  input [3:0]I2;
  input RX_IDLE;
  input I3;
  input I4;
  input I5;
  input I6;
  input RX_CONFIG_VALID;
  input ACKNOWLEDGE_MATCH_3;
  input RXSYNC_STATUS;
  input RX_RUDI_INVALID;
  input data_out;
  input p_0_in;
  input MASK_RUDI_BUFERR_TIMER0;
  input [0:0]an_adv_config_vector;
  input EOP_REG1;
  input I7;
  input I8;
  input I9;
  input [1:0]I10;
  input SYNC_STATUS_HELD;
  input [0:0]S;
  input [0:0]I11;
  input SOP_REG3;
  input I12;
  input I13;
  input [0:0]SR;

  wire ABILITY_MATCH;
  wire ABILITY_MATCH_2;
  wire ACKNOWLEDGE_MATCH_2;
  wire ACKNOWLEDGE_MATCH_3;
  wire AN_SYNC_STATUS;
  wire CLK;
  wire CONSISTENCY_MATCH;
  wire CONSISTENCY_MATCH1;
  wire CONSISTENCY_MATCH_COMB;
  wire [2:0]D;
  wire EOP_REG1;
  wire GENERATE_REMOTE_FAULT;
  wire GENERATE_REMOTE_FAULT0;
  wire I1;
  wire [1:0]I10;
  wire [0:0]I11;
  wire I12;
  wire I13;
  wire [3:0]I2;
  wire I3;
  wire I4;
  wire I5;
  wire I6;
  wire I7;
  wire I8;
  wire I9;
  wire IDLE_INSERTED;
  wire IDLE_INSERTED0;
  wire IDLE_INSERTED_REG1;
  wire IDLE_INSERTED_REG2;
  wire IDLE_INSERTED_REG3;
  wire IDLE_INSERTED_REG30;
  wire IDLE_INSERTED_REG4;
  wire IDLE_MATCH;
  wire IDLE_MATCH_2;
  wire IDLE_REMOVED;
  wire IDLE_REMOVED0;
  wire IDLE_REMOVED_REG1;
  wire IDLE_REMOVED_REG2;
  wire LINK_TIMER_DONE;
  wire LINK_TIMER_SATURATED;
  wire LINK_TIMER_SATURATED_COMB;
  wire [8:0]LINK_TIMER_reg__0;
  wire [8:0]MASK_RUDI_BUFERR_TIMER;
  wire MASK_RUDI_BUFERR_TIMER0;
  wire MR_AN_ENABLE_CHANGE;
  wire MR_AN_ENABLE_CHANGE0;
  wire MR_AN_ENABLE_REG1;
  wire MR_AN_ENABLE_REG2;
  wire MR_PAGE_RX_SET128_out;
  wire MR_RESTART_AN_SET_REG1;
  wire MR_RESTART_AN_SET_REG2;
  wire O1;
  wire O2;
  wire O3;
  wire O4;
  wire O5;
  wire [3:0]O6;
  wire [2:0]O7;
  wire [3:0]PREVIOUS_STATE;
  wire PULSE4096;
  wire PULSE40960;
  wire [15:0]Q;
  wire RESTART_AN_SET;
  wire RXSYNC_STATUS;
  wire RX_CONFIG_SNAPSHOT;
  wire RX_CONFIG_VALID;
  wire RX_IDLE;
  wire RX_IDLE_REG1;
  wire RX_IDLE_REG2;
  wire RX_RUDI_INVALID;
  wire [1:0]RX_RUDI_INVALID_DELAY;
  wire RX_RUDI_INVALID_DELAY0;
  wire RX_RUDI_INVALID_REG;
  wire [0:0]S;
  wire SOP_REG3;
  wire [0:0]SR;
  wire START_LINK_TIMER_REG;
  wire START_LINK_TIMER_REG2;
  wire STATE0;
  wire STAT_VEC_DUPLEX_MODE_RSLVD;
  wire SYNC_STATUS_HELD;
  wire SYNC_STATUS_HELD__0;
  wire TIMER4096_MSB_REG;
  wire TOGGLE_RX;
  wire TOGGLE_TX;
  wire XMIT_CONFIG;
  wire XMIT_CONFIG_INT;
  wire XMIT_DATA;
  wire XMIT_DATA_INT;
  wire XMIT_DATA_INT0;
  wire [0:0]an_adv_config_vector;
  wire an_interrupt;
  wire data_out;
  wire n_0_ABILITY_MATCH_2_i_1;
  wire n_0_ABILITY_MATCH_2_i_2;
  wire n_0_ABILITY_MATCH_i_1;
  wire n_0_ACKNOWLEDGE_MATCH_3_i_1;
  wire n_0_ACKNOWLEDGE_MATCH_3_reg;
  wire n_0_AN_SYNC_STATUS_i_1;
  wire \n_0_BASEX_REMOTE_FAULT[1]_i_1 ;
  wire n_0_CONSISTENCY_MATCH_i_4;
  wire n_0_CONSISTENCY_MATCH_i_6;
  wire n_0_CONSISTENCY_MATCH_i_7;
  wire n_0_CONSISTENCY_MATCH_i_8;
  wire n_0_CONSISTENCY_MATCH_reg_i_3;
  wire n_0_GENERATE_REMOTE_FAULT_i_2;
  wire n_0_GENERATE_REMOTE_FAULT_i_3;
  wire n_0_GENERATE_REMOTE_FAULT_i_4;
  wire n_0_IDLE_MATCH_2_i_1;
  wire n_0_IDLE_MATCH_i_1;
  wire \n_0_LINK_TIMER[8]_i_1 ;
  wire \n_0_LINK_TIMER[8]_i_3 ;
  wire n_0_LINK_TIMER_DONE_i_1;
  wire n_0_LINK_TIMER_DONE_i_2;
  wire n_0_LINK_TIMER_DONE_i_3;
  wire n_0_LINK_TIMER_DONE_i_4;
  wire n_0_LINK_TIMER_SATURATED_i_2;
  wire \n_0_MASK_RUDI_BUFERR_TIMER[0]_i_1 ;
  wire \n_0_MASK_RUDI_BUFERR_TIMER[1]_i_1 ;
  wire \n_0_MASK_RUDI_BUFERR_TIMER[2]_i_1 ;
  wire \n_0_MASK_RUDI_BUFERR_TIMER[3]_i_1 ;
  wire \n_0_MASK_RUDI_BUFERR_TIMER[4]_i_1 ;
  wire \n_0_MASK_RUDI_BUFERR_TIMER[5]_i_1 ;
  wire \n_0_MASK_RUDI_BUFERR_TIMER[5]_i_2 ;
  wire \n_0_MASK_RUDI_BUFERR_TIMER[6]_i_1 ;
  wire \n_0_MASK_RUDI_BUFERR_TIMER[7]_i_1 ;
  wire \n_0_MASK_RUDI_BUFERR_TIMER[8]_i_1 ;
  wire \n_0_MASK_RUDI_BUFERR_TIMER[8]_i_2 ;
  wire \n_0_MASK_RUDI_BUFERR_TIMER[8]_i_3 ;
  wire n_0_MASK_RUDI_BUFERR_i_1;
  wire n_0_MASK_RUDI_BUFERR_i_2;
  wire n_0_MASK_RUDI_CLKCOR_i_1;
  wire n_0_MASK_RUDI_CLKCOR_reg;
  wire n_0_MR_AN_COMPLETE_i_1;
  wire n_0_MR_REMOTE_FAULT_i_1;
  wire n_0_MR_RESTART_AN_INT_i_1;
  wire n_0_MR_RESTART_AN_INT_reg;
  wire \n_0_RX_CONFIG_REG_REG_reg[0] ;
  wire \n_0_RX_CONFIG_REG_REG_reg[12] ;
  wire \n_0_RX_CONFIG_REG_REG_reg[13] ;
  wire \n_0_RX_CONFIG_REG_REG_reg[1] ;
  wire \n_0_RX_CONFIG_REG_REG_reg[2] ;
  wire \n_0_RX_CONFIG_REG_REG_reg[3] ;
  wire \n_0_RX_CONFIG_REG_REG_reg[4] ;
  wire \n_0_RX_CONFIG_REG_REG_reg[5] ;
  wire \n_0_RX_CONFIG_REG_REG_reg[6] ;
  wire \n_0_RX_CONFIG_REG_REG_reg[7] ;
  wire \n_0_RX_CONFIG_REG_REG_reg[8] ;
  wire \n_0_RX_CONFIG_SNAPSHOT[15]_i_10 ;
  wire \n_0_RX_CONFIG_SNAPSHOT[15]_i_3 ;
  wire \n_0_RX_CONFIG_SNAPSHOT[15]_i_4 ;
  wire \n_0_RX_CONFIG_SNAPSHOT[15]_i_6 ;
  wire \n_0_RX_CONFIG_SNAPSHOT[15]_i_8 ;
  wire \n_0_RX_CONFIG_SNAPSHOT[15]_i_9 ;
  wire \n_0_RX_CONFIG_SNAPSHOT_reg[0] ;
  wire \n_0_RX_CONFIG_SNAPSHOT_reg[12] ;
  wire \n_0_RX_CONFIG_SNAPSHOT_reg[13] ;
  wire \n_0_RX_CONFIG_SNAPSHOT_reg[15] ;
  wire \n_0_RX_CONFIG_SNAPSHOT_reg[15]_i_5 ;
  wire \n_0_RX_CONFIG_SNAPSHOT_reg[1] ;
  wire \n_0_RX_CONFIG_SNAPSHOT_reg[2] ;
  wire \n_0_RX_CONFIG_SNAPSHOT_reg[3] ;
  wire \n_0_RX_CONFIG_SNAPSHOT_reg[4] ;
  wire \n_0_RX_CONFIG_SNAPSHOT_reg[5] ;
  wire \n_0_RX_CONFIG_SNAPSHOT_reg[6] ;
  wire \n_0_RX_CONFIG_SNAPSHOT_reg[7] ;
  wire \n_0_RX_CONFIG_SNAPSHOT_reg[8] ;
  wire n_0_RX_DV_i_2;
  wire \n_0_SGMII_SPEED[1]_i_2 ;
  wire n_0_START_LINK_TIMER_REG_i_1;
  wire n_0_START_LINK_TIMER_REG_i_2;
  wire \n_0_STATE[0]_i_1 ;
  wire \n_0_STATE[0]_i_2 ;
  wire \n_0_STATE[0]_i_3 ;
  wire \n_0_STATE[0]_i_4 ;
  wire \n_0_STATE[0]_i_5 ;
  wire \n_0_STATE[1]_i_1 ;
  wire \n_0_STATE[1]_i_2 ;
  wire \n_0_STATE[1]_i_3 ;
  wire \n_0_STATE[1]_i_4 ;
  wire \n_0_STATE[2]_i_1 ;
  wire \n_0_STATE[2]_i_2 ;
  wire \n_0_STATE[2]_i_3 ;
  wire \n_0_STATE[2]_i_4 ;
  wire \n_0_STATE[2]_i_5 ;
  wire \n_0_STATE[3]_i_2 ;
  wire \n_0_STATE[3]_i_3 ;
  wire \n_0_STATE[3]_i_4 ;
  wire \n_0_STATE[3]_i_5 ;
  wire \n_0_STATE_reg[0] ;
  wire \n_0_STATE_reg[1] ;
  wire \n_0_STATE_reg[2] ;
  wire \n_0_STATE_reg[3] ;
  wire n_0_SYNC_STATUS_HELD_i_1;
  wire \n_0_TIMER4096[0]_i_2 ;
  wire \n_0_TIMER4096[0]_i_3 ;
  wire \n_0_TIMER4096[0]_i_4 ;
  wire \n_0_TIMER4096[0]_i_5 ;
  wire \n_0_TIMER4096[4]_i_2 ;
  wire \n_0_TIMER4096[4]_i_3 ;
  wire \n_0_TIMER4096[4]_i_4 ;
  wire \n_0_TIMER4096[4]_i_5 ;
  wire \n_0_TIMER4096[8]_i_2 ;
  wire \n_0_TIMER4096[8]_i_3 ;
  wire \n_0_TIMER4096[8]_i_4 ;
  wire \n_0_TIMER4096[8]_i_5 ;
  wire \n_0_TIMER4096_reg[0] ;
  wire \n_0_TIMER4096_reg[0]_i_1 ;
  wire \n_0_TIMER4096_reg[10] ;
  wire \n_0_TIMER4096_reg[11] ;
  wire \n_0_TIMER4096_reg[1] ;
  wire \n_0_TIMER4096_reg[2] ;
  wire \n_0_TIMER4096_reg[3] ;
  wire \n_0_TIMER4096_reg[4] ;
  wire \n_0_TIMER4096_reg[4]_i_1 ;
  wire \n_0_TIMER4096_reg[5] ;
  wire \n_0_TIMER4096_reg[6] ;
  wire \n_0_TIMER4096_reg[7] ;
  wire \n_0_TIMER4096_reg[8] ;
  wire \n_0_TIMER4096_reg[9] ;
  wire n_0_TOGGLE_TX_i_1;
  wire n_0_TOGGLE_TX_i_2;
  wire \n_0_TX_CONFIG_REG_INT[0]_i_1 ;
  wire \n_0_TX_CONFIG_REG_INT[11]_i_1 ;
  wire \n_0_TX_CONFIG_REG_INT[14]_i_1 ;
  wire n_0_XMIT_CONFIG_INT_i_1__0;
  wire n_0_XMIT_CONFIG_INT_i_2;
  wire n_0_XMIT_CONFIG_INT_i_3;
  wire n_1_CONSISTENCY_MATCH_reg_i_3;
  wire \n_1_RX_CONFIG_SNAPSHOT_reg[15]_i_5 ;
  wire \n_1_TIMER4096_reg[0]_i_1 ;
  wire \n_1_TIMER4096_reg[4]_i_1 ;
  wire \n_1_TIMER4096_reg[8]_i_1 ;
  wire n_2_CONSISTENCY_MATCH_reg_i_3;
  wire \n_2_RX_CONFIG_SNAPSHOT_reg[15]_i_5 ;
  wire \n_2_TIMER4096_reg[0]_i_1 ;
  wire \n_2_TIMER4096_reg[4]_i_1 ;
  wire \n_2_TIMER4096_reg[8]_i_1 ;
  wire n_3_CONSISTENCY_MATCH_reg_i_3;
  wire \n_3_RX_CONFIG_SNAPSHOT_reg[15]_i_2 ;
  wire \n_3_RX_CONFIG_SNAPSHOT_reg[15]_i_5 ;
  wire \n_3_TIMER4096_reg[0]_i_1 ;
  wire \n_3_TIMER4096_reg[4]_i_1 ;
  wire \n_3_TIMER4096_reg[8]_i_1 ;
  wire \n_4_TIMER4096_reg[0]_i_1 ;
  wire \n_4_TIMER4096_reg[4]_i_1 ;
  wire \n_4_TIMER4096_reg[8]_i_1 ;
  wire \n_5_TIMER4096_reg[0]_i_1 ;
  wire \n_5_TIMER4096_reg[4]_i_1 ;
  wire \n_5_TIMER4096_reg[8]_i_1 ;
  wire \n_6_TIMER4096_reg[0]_i_1 ;
  wire \n_6_TIMER4096_reg[4]_i_1 ;
  wire \n_6_TIMER4096_reg[8]_i_1 ;
  wire \n_7_TIMER4096_reg[0]_i_1 ;
  wire \n_7_TIMER4096_reg[4]_i_1 ;
  wire \n_7_TIMER4096_reg[8]_i_1 ;
  wire p_0_in;
  wire p_0_in0_in;
  wire [8:0]plusOp__0;
  wire [5:0]status_vector;
  wire [3:1]NLW_CONSISTENCY_MATCH_reg_i_2_CO_UNCONNECTED;
  wire [3:0]NLW_CONSISTENCY_MATCH_reg_i_2_O_UNCONNECTED;
  wire [3:0]NLW_CONSISTENCY_MATCH_reg_i_3_O_UNCONNECTED;
  wire [3:1]\NLW_RX_CONFIG_SNAPSHOT_reg[15]_i_2_CO_UNCONNECTED ;
  wire [3:0]\NLW_RX_CONFIG_SNAPSHOT_reg[15]_i_2_O_UNCONNECTED ;
  wire [3:0]\NLW_RX_CONFIG_SNAPSHOT_reg[15]_i_5_O_UNCONNECTED ;
  wire [3:3]\NLW_TIMER4096_reg[8]_i_1_CO_UNCONNECTED ;

LUT5 #(
    .INIT(32'h00002E22)) 
     ABILITY_MATCH_2_i_1
       (.I0(ABILITY_MATCH_2),
        .I1(RX_CONFIG_VALID),
        .I2(n_0_ABILITY_MATCH_2_i_2),
        .I3(\n_3_RX_CONFIG_SNAPSHOT_reg[15]_i_2 ),
        .I4(ACKNOWLEDGE_MATCH_3),
        .O(n_0_ABILITY_MATCH_2_i_1));
(* SOFT_HLUTNM = "soft_lutpair17" *) 
   LUT3 #(
    .INIT(8'hF6)) 
     ABILITY_MATCH_2_i_2
       (.I0(p_0_in0_in),
        .I1(Q[15]),
        .I2(O2),
        .O(n_0_ABILITY_MATCH_2_i_2));
FDRE ABILITY_MATCH_2_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_ABILITY_MATCH_2_i_1),
        .Q(ABILITY_MATCH_2),
        .R(1'b0));
LUT6 #(
    .INIT(64'h0000000020FF2000)) 
     ABILITY_MATCH_i_1
       (.I0(\n_3_RX_CONFIG_SNAPSHOT_reg[15]_i_2 ),
        .I1(n_0_ABILITY_MATCH_2_i_2),
        .I2(ABILITY_MATCH_2),
        .I3(RX_CONFIG_VALID),
        .I4(ABILITY_MATCH),
        .I5(ACKNOWLEDGE_MATCH_3),
        .O(n_0_ABILITY_MATCH_i_1));
FDRE ABILITY_MATCH_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_ABILITY_MATCH_i_1),
        .Q(ABILITY_MATCH),
        .R(1'b0));
FDRE ACKNOWLEDGE_MATCH_2_reg
       (.C(CLK),
        .CE(1'b1),
        .D(I5),
        .Q(ACKNOWLEDGE_MATCH_2),
        .R(1'b0));
LUT6 #(
    .INIT(64'h00000000E2222222)) 
     ACKNOWLEDGE_MATCH_3_i_1
       (.I0(n_0_ACKNOWLEDGE_MATCH_3_reg),
        .I1(RX_CONFIG_VALID),
        .I2(Q[14]),
        .I3(O6[3]),
        .I4(ACKNOWLEDGE_MATCH_2),
        .I5(ACKNOWLEDGE_MATCH_3),
        .O(n_0_ACKNOWLEDGE_MATCH_3_i_1));
FDRE ACKNOWLEDGE_MATCH_3_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_ACKNOWLEDGE_MATCH_3_i_1),
        .Q(n_0_ACKNOWLEDGE_MATCH_3_reg),
        .R(1'b0));
LUT5 #(
    .INIT(32'hFFBFFF80)) 
     AN_SYNC_STATUS_i_1
       (.I0(SYNC_STATUS_HELD__0),
        .I1(PULSE4096),
        .I2(LINK_TIMER_SATURATED),
        .I3(RXSYNC_STATUS),
        .I4(AN_SYNC_STATUS),
        .O(n_0_AN_SYNC_STATUS_i_1));
FDRE AN_SYNC_STATUS_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_AN_SYNC_STATUS_i_1),
        .Q(AN_SYNC_STATUS),
        .R(I1));
LUT4 #(
    .INIT(16'h1310)) 
     \BASEX_REMOTE_FAULT[1]_i_1 
       (.I0(Q[15]),
        .I1(I1),
        .I2(MR_PAGE_RX_SET128_out),
        .I3(status_vector[2]),
        .O(\n_0_BASEX_REMOTE_FAULT[1]_i_1 ));
FDRE \BASEX_REMOTE_FAULT_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_BASEX_REMOTE_FAULT[1]_i_1 ),
        .Q(status_vector[2]),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair17" *) 
   LUT3 #(
    .INIT(8'h82)) 
     CONSISTENCY_MATCH_i_1
       (.I0(CONSISTENCY_MATCH1),
        .I1(\n_0_RX_CONFIG_SNAPSHOT_reg[15] ),
        .I2(Q[15]),
        .O(CONSISTENCY_MATCH_COMB));
LUT4 #(
    .INIT(16'h9009)) 
     CONSISTENCY_MATCH_i_4
       (.I0(\n_0_RX_CONFIG_SNAPSHOT_reg[13] ),
        .I1(Q[13]),
        .I2(\n_0_RX_CONFIG_SNAPSHOT_reg[12] ),
        .I3(Q[12]),
        .O(n_0_CONSISTENCY_MATCH_i_4));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     CONSISTENCY_MATCH_i_6
       (.I0(\n_0_RX_CONFIG_SNAPSHOT_reg[8] ),
        .I1(Q[8]),
        .I2(Q[6]),
        .I3(\n_0_RX_CONFIG_SNAPSHOT_reg[6] ),
        .I4(Q[7]),
        .I5(\n_0_RX_CONFIG_SNAPSHOT_reg[7] ),
        .O(n_0_CONSISTENCY_MATCH_i_6));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     CONSISTENCY_MATCH_i_7
       (.I0(\n_0_RX_CONFIG_SNAPSHOT_reg[5] ),
        .I1(Q[5]),
        .I2(Q[3]),
        .I3(\n_0_RX_CONFIG_SNAPSHOT_reg[3] ),
        .I4(Q[4]),
        .I5(\n_0_RX_CONFIG_SNAPSHOT_reg[4] ),
        .O(n_0_CONSISTENCY_MATCH_i_7));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     CONSISTENCY_MATCH_i_8
       (.I0(\n_0_RX_CONFIG_SNAPSHOT_reg[2] ),
        .I1(Q[2]),
        .I2(Q[0]),
        .I3(\n_0_RX_CONFIG_SNAPSHOT_reg[0] ),
        .I4(Q[1]),
        .I5(\n_0_RX_CONFIG_SNAPSHOT_reg[1] ),
        .O(n_0_CONSISTENCY_MATCH_i_8));
FDRE CONSISTENCY_MATCH_reg
       (.C(CLK),
        .CE(1'b1),
        .D(CONSISTENCY_MATCH_COMB),
        .Q(CONSISTENCY_MATCH),
        .R(I1));
CARRY4 CONSISTENCY_MATCH_reg_i_2
       (.CI(n_0_CONSISTENCY_MATCH_reg_i_3),
        .CO({NLW_CONSISTENCY_MATCH_reg_i_2_CO_UNCONNECTED[3:1],CONSISTENCY_MATCH1}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_CONSISTENCY_MATCH_reg_i_2_O_UNCONNECTED[3:0]),
        .S({1'b0,1'b0,1'b0,n_0_CONSISTENCY_MATCH_i_4}));
CARRY4 CONSISTENCY_MATCH_reg_i_3
       (.CI(1'b0),
        .CO({n_0_CONSISTENCY_MATCH_reg_i_3,n_1_CONSISTENCY_MATCH_reg_i_3,n_2_CONSISTENCY_MATCH_reg_i_3,n_3_CONSISTENCY_MATCH_reg_i_3}),
        .CYINIT(1'b1),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_CONSISTENCY_MATCH_reg_i_3_O_UNCONNECTED[3:0]),
        .S({I11,n_0_CONSISTENCY_MATCH_i_6,n_0_CONSISTENCY_MATCH_i_7,n_0_CONSISTENCY_MATCH_i_8}));
LUT5 #(
    .INIT(32'h0000D000)) 
     GENERATE_REMOTE_FAULT_i_1
       (.I0(\n_0_STATE[0]_i_4 ),
        .I1(n_0_GENERATE_REMOTE_FAULT_i_2),
        .I2(\n_0_STATE[2]_i_2 ),
        .I3(n_0_GENERATE_REMOTE_FAULT_i_3),
        .I4(\n_0_STATE[1]_i_2 ),
        .O(GENERATE_REMOTE_FAULT0));
LUT6 #(
    .INIT(64'hFFFFC8F8C8C8C8C8)) 
     GENERATE_REMOTE_FAULT_i_2
       (.I0(LINK_TIMER_DONE),
        .I1(\n_0_STATE[0]_i_2 ),
        .I2(\n_0_STATE_reg[0] ),
        .I3(ABILITY_MATCH),
        .I4(n_0_GENERATE_REMOTE_FAULT_i_4),
        .I5(\n_0_STATE[2]_i_4 ),
        .O(n_0_GENERATE_REMOTE_FAULT_i_2));
(* SOFT_HLUTNM = "soft_lutpair11" *) 
   LUT4 #(
    .INIT(16'h0040)) 
     GENERATE_REMOTE_FAULT_i_3
       (.I0(\n_0_STATE_reg[1] ),
        .I1(\n_0_STATE_reg[2] ),
        .I2(\n_0_STATE_reg[0] ),
        .I3(\n_0_STATE_reg[3] ),
        .O(n_0_GENERATE_REMOTE_FAULT_i_3));
(* SOFT_HLUTNM = "soft_lutpair8" *) 
   LUT3 #(
    .INIT(8'h28)) 
     GENERATE_REMOTE_FAULT_i_4
       (.I0(ABILITY_MATCH),
        .I1(TOGGLE_RX),
        .I2(O6[2]),
        .O(n_0_GENERATE_REMOTE_FAULT_i_4));
FDRE GENERATE_REMOTE_FAULT_reg
       (.C(CLK),
        .CE(1'b1),
        .D(GENERATE_REMOTE_FAULT0),
        .Q(GENERATE_REMOTE_FAULT),
        .R(I1));
FDRE IDLE_INSERTED_REG1_reg
       (.C(CLK),
        .CE(1'b1),
        .D(IDLE_INSERTED),
        .Q(IDLE_INSERTED_REG1),
        .R(I1));
FDRE IDLE_INSERTED_REG2_reg
       (.C(CLK),
        .CE(1'b1),
        .D(IDLE_INSERTED_REG1),
        .Q(IDLE_INSERTED_REG2),
        .R(I1));
(* SOFT_HLUTNM = "soft_lutpair1" *) 
   LUT2 #(
    .INIT(4'h2)) 
     IDLE_INSERTED_REG3_i_1
       (.I0(IDLE_INSERTED_REG2),
        .I1(RX_IDLE_REG2),
        .O(IDLE_INSERTED_REG30));
FDRE IDLE_INSERTED_REG3_reg
       (.C(CLK),
        .CE(1'b1),
        .D(IDLE_INSERTED_REG30),
        .Q(IDLE_INSERTED_REG3),
        .R(I1));
FDRE IDLE_INSERTED_REG4_reg
       (.C(CLK),
        .CE(1'b1),
        .D(IDLE_INSERTED_REG3),
        .Q(IDLE_INSERTED_REG4),
        .R(I1));
LUT3 #(
    .INIT(8'h08)) 
     IDLE_INSERTED_i_1
       (.I0(I10[1]),
        .I1(I10[0]),
        .I2(XMIT_CONFIG_INT),
        .O(IDLE_INSERTED0));
FDRE IDLE_INSERTED_reg
       (.C(CLK),
        .CE(1'b1),
        .D(IDLE_INSERTED0),
        .Q(IDLE_INSERTED),
        .R(I1));
(* SOFT_HLUTNM = "soft_lutpair1" *) 
   LUT5 #(
    .INIT(32'h04FF0400)) 
     IDLE_MATCH_2_i_1
       (.I0(IDLE_INSERTED_REG2),
        .I1(RX_IDLE),
        .I2(IDLE_INSERTED_REG4),
        .I3(RX_IDLE_REG2),
        .I4(IDLE_MATCH_2),
        .O(n_0_IDLE_MATCH_2_i_1));
FDRE IDLE_MATCH_2_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_IDLE_MATCH_2_i_1),
        .Q(IDLE_MATCH_2),
        .R(I1));
LUT6 #(
    .INIT(64'h4440FFFF44400000)) 
     IDLE_MATCH_i_1
       (.I0(IDLE_INSERTED_REG2),
        .I1(RX_IDLE),
        .I2(IDLE_REMOVED_REG2),
        .I3(IDLE_MATCH_2),
        .I4(RX_IDLE_REG2),
        .I5(IDLE_MATCH),
        .O(n_0_IDLE_MATCH_i_1));
FDRE IDLE_MATCH_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_IDLE_MATCH_i_1),
        .Q(IDLE_MATCH),
        .R(I1));
FDRE IDLE_REMOVED_REG1_reg
       (.C(CLK),
        .CE(1'b1),
        .D(IDLE_REMOVED),
        .Q(IDLE_REMOVED_REG1),
        .R(I1));
FDRE IDLE_REMOVED_REG2_reg
       (.C(CLK),
        .CE(1'b1),
        .D(IDLE_REMOVED_REG1),
        .Q(IDLE_REMOVED_REG2),
        .R(I1));
(* SOFT_HLUTNM = "soft_lutpair16" *) 
   LUT3 #(
    .INIT(8'h04)) 
     IDLE_REMOVED_i_1
       (.I0(I10[1]),
        .I1(I10[0]),
        .I2(XMIT_CONFIG_INT),
        .O(IDLE_REMOVED0));
FDRE IDLE_REMOVED_reg
       (.C(CLK),
        .CE(1'b1),
        .D(IDLE_REMOVED0),
        .Q(IDLE_REMOVED),
        .R(I1));
LUT1 #(
    .INIT(2'h1)) 
     \LINK_TIMER[0]_i_1 
       (.I0(LINK_TIMER_reg__0[0]),
        .O(plusOp__0[0]));
(* SOFT_HLUTNM = "soft_lutpair15" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \LINK_TIMER[1]_i_1 
       (.I0(LINK_TIMER_reg__0[0]),
        .I1(LINK_TIMER_reg__0[1]),
        .O(plusOp__0[1]));
(* SOFT_HLUTNM = "soft_lutpair15" *) 
   LUT3 #(
    .INIT(8'h6A)) 
     \LINK_TIMER[2]_i_1 
       (.I0(LINK_TIMER_reg__0[2]),
        .I1(LINK_TIMER_reg__0[0]),
        .I2(LINK_TIMER_reg__0[1]),
        .O(plusOp__0[2]));
(* SOFT_HLUTNM = "soft_lutpair6" *) 
   LUT4 #(
    .INIT(16'h6AAA)) 
     \LINK_TIMER[3]_i_1 
       (.I0(LINK_TIMER_reg__0[3]),
        .I1(LINK_TIMER_reg__0[1]),
        .I2(LINK_TIMER_reg__0[0]),
        .I3(LINK_TIMER_reg__0[2]),
        .O(plusOp__0[3]));
(* SOFT_HLUTNM = "soft_lutpair6" *) 
   LUT5 #(
    .INIT(32'h6AAAAAAA)) 
     \LINK_TIMER[4]_i_1 
       (.I0(LINK_TIMER_reg__0[4]),
        .I1(LINK_TIMER_reg__0[2]),
        .I2(LINK_TIMER_reg__0[0]),
        .I3(LINK_TIMER_reg__0[1]),
        .I4(LINK_TIMER_reg__0[3]),
        .O(plusOp__0[4]));
LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
     \LINK_TIMER[5]_i_1 
       (.I0(LINK_TIMER_reg__0[3]),
        .I1(LINK_TIMER_reg__0[1]),
        .I2(LINK_TIMER_reg__0[0]),
        .I3(LINK_TIMER_reg__0[2]),
        .I4(LINK_TIMER_reg__0[4]),
        .I5(LINK_TIMER_reg__0[5]),
        .O(plusOp__0[5]));
LUT2 #(
    .INIT(4'h6)) 
     \LINK_TIMER[6]_i_1 
       (.I0(LINK_TIMER_reg__0[6]),
        .I1(\n_0_LINK_TIMER[8]_i_3 ),
        .O(plusOp__0[6]));
(* SOFT_HLUTNM = "soft_lutpair14" *) 
   LUT3 #(
    .INIT(8'h6A)) 
     \LINK_TIMER[7]_i_1 
       (.I0(LINK_TIMER_reg__0[7]),
        .I1(\n_0_LINK_TIMER[8]_i_3 ),
        .I2(LINK_TIMER_reg__0[6]),
        .O(plusOp__0[7]));
LUT4 #(
    .INIT(16'hFFEA)) 
     \LINK_TIMER[8]_i_1 
       (.I0(START_LINK_TIMER_REG),
        .I1(LINK_TIMER_SATURATED),
        .I2(PULSE4096),
        .I3(I1),
        .O(\n_0_LINK_TIMER[8]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair14" *) 
   LUT4 #(
    .INIT(16'h6AAA)) 
     \LINK_TIMER[8]_i_2 
       (.I0(LINK_TIMER_reg__0[8]),
        .I1(LINK_TIMER_reg__0[6]),
        .I2(\n_0_LINK_TIMER[8]_i_3 ),
        .I3(LINK_TIMER_reg__0[7]),
        .O(plusOp__0[8]));
LUT6 #(
    .INIT(64'h8000000000000000)) 
     \LINK_TIMER[8]_i_3 
       (.I0(LINK_TIMER_reg__0[5]),
        .I1(LINK_TIMER_reg__0[4]),
        .I2(LINK_TIMER_reg__0[2]),
        .I3(LINK_TIMER_reg__0[0]),
        .I4(LINK_TIMER_reg__0[1]),
        .I5(LINK_TIMER_reg__0[3]),
        .O(\n_0_LINK_TIMER[8]_i_3 ));
LUT6 #(
    .INIT(64'h000000000000000E)) 
     LINK_TIMER_DONE_i_1
       (.I0(LINK_TIMER_DONE),
        .I1(LINK_TIMER_SATURATED),
        .I2(n_0_LINK_TIMER_DONE_i_2),
        .I3(\n_0_STATE[3]_i_3 ),
        .I4(n_0_START_LINK_TIMER_REG_i_2),
        .I5(n_0_LINK_TIMER_DONE_i_3),
        .O(n_0_LINK_TIMER_DONE_i_1));
LUT3 #(
    .INIT(8'hFE)) 
     LINK_TIMER_DONE_i_2
       (.I0(START_LINK_TIMER_REG),
        .I1(START_LINK_TIMER_REG2),
        .I2(I1),
        .O(n_0_LINK_TIMER_DONE_i_2));
LUT6 #(
    .INIT(64'h00000000002A0000)) 
     LINK_TIMER_DONE_i_3
       (.I0(LINK_TIMER_DONE),
        .I1(ABILITY_MATCH),
        .I2(O3),
        .I3(\n_0_STATE_reg[3] ),
        .I4(n_0_LINK_TIMER_DONE_i_4),
        .I5(\n_0_STATE_reg[0] ),
        .O(n_0_LINK_TIMER_DONE_i_3));
(* SOFT_HLUTNM = "soft_lutpair9" *) 
   LUT2 #(
    .INIT(4'h2)) 
     LINK_TIMER_DONE_i_4
       (.I0(\n_0_STATE_reg[2] ),
        .I1(\n_0_STATE_reg[1] ),
        .O(n_0_LINK_TIMER_DONE_i_4));
FDRE LINK_TIMER_DONE_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_LINK_TIMER_DONE_i_1),
        .Q(LINK_TIMER_DONE),
        .R(1'b0));
LUT4 #(
    .INIT(16'h0400)) 
     LINK_TIMER_SATURATED_i_1
       (.I0(LINK_TIMER_reg__0[0]),
        .I1(LINK_TIMER_reg__0[5]),
        .I2(LINK_TIMER_reg__0[7]),
        .I3(n_0_LINK_TIMER_SATURATED_i_2),
        .O(LINK_TIMER_SATURATED_COMB));
LUT6 #(
    .INIT(64'h0000000000000040)) 
     LINK_TIMER_SATURATED_i_2
       (.I0(LINK_TIMER_reg__0[2]),
        .I1(LINK_TIMER_reg__0[4]),
        .I2(LINK_TIMER_reg__0[1]),
        .I3(LINK_TIMER_reg__0[8]),
        .I4(LINK_TIMER_reg__0[3]),
        .I5(LINK_TIMER_reg__0[6]),
        .O(n_0_LINK_TIMER_SATURATED_i_2));
FDRE LINK_TIMER_SATURATED_reg
       (.C(CLK),
        .CE(1'b1),
        .D(LINK_TIMER_SATURATED_COMB),
        .Q(LINK_TIMER_SATURATED),
        .R(I1));
FDRE \LINK_TIMER_reg[0] 
       (.C(CLK),
        .CE(PULSE4096),
        .D(plusOp__0[0]),
        .Q(LINK_TIMER_reg__0[0]),
        .R(\n_0_LINK_TIMER[8]_i_1 ));
FDRE \LINK_TIMER_reg[1] 
       (.C(CLK),
        .CE(PULSE4096),
        .D(plusOp__0[1]),
        .Q(LINK_TIMER_reg__0[1]),
        .R(\n_0_LINK_TIMER[8]_i_1 ));
FDRE \LINK_TIMER_reg[2] 
       (.C(CLK),
        .CE(PULSE4096),
        .D(plusOp__0[2]),
        .Q(LINK_TIMER_reg__0[2]),
        .R(\n_0_LINK_TIMER[8]_i_1 ));
FDRE \LINK_TIMER_reg[3] 
       (.C(CLK),
        .CE(PULSE4096),
        .D(plusOp__0[3]),
        .Q(LINK_TIMER_reg__0[3]),
        .R(\n_0_LINK_TIMER[8]_i_1 ));
FDRE \LINK_TIMER_reg[4] 
       (.C(CLK),
        .CE(PULSE4096),
        .D(plusOp__0[4]),
        .Q(LINK_TIMER_reg__0[4]),
        .R(\n_0_LINK_TIMER[8]_i_1 ));
FDRE \LINK_TIMER_reg[5] 
       (.C(CLK),
        .CE(PULSE4096),
        .D(plusOp__0[5]),
        .Q(LINK_TIMER_reg__0[5]),
        .R(\n_0_LINK_TIMER[8]_i_1 ));
FDRE \LINK_TIMER_reg[6] 
       (.C(CLK),
        .CE(PULSE4096),
        .D(plusOp__0[6]),
        .Q(LINK_TIMER_reg__0[6]),
        .R(\n_0_LINK_TIMER[8]_i_1 ));
FDRE \LINK_TIMER_reg[7] 
       (.C(CLK),
        .CE(PULSE4096),
        .D(plusOp__0[7]),
        .Q(LINK_TIMER_reg__0[7]),
        .R(\n_0_LINK_TIMER[8]_i_1 ));
FDRE \LINK_TIMER_reg[8] 
       (.C(CLK),
        .CE(PULSE4096),
        .D(plusOp__0[8]),
        .Q(LINK_TIMER_reg__0[8]),
        .R(\n_0_LINK_TIMER[8]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair2" *) 
   LUT4 #(
    .INIT(16'h5155)) 
     \MASK_RUDI_BUFERR_TIMER[0]_i_1 
       (.I0(MASK_RUDI_BUFERR_TIMER[0]),
        .I1(data_out),
        .I2(I2[1]),
        .I3(p_0_in),
        .O(\n_0_MASK_RUDI_BUFERR_TIMER[0]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair2" *) 
   LUT5 #(
    .INIT(32'h66066666)) 
     \MASK_RUDI_BUFERR_TIMER[1]_i_1 
       (.I0(MASK_RUDI_BUFERR_TIMER[0]),
        .I1(MASK_RUDI_BUFERR_TIMER[1]),
        .I2(data_out),
        .I3(I2[1]),
        .I4(p_0_in),
        .O(\n_0_MASK_RUDI_BUFERR_TIMER[1]_i_1 ));
LUT6 #(
    .INIT(64'h7878007878787878)) 
     \MASK_RUDI_BUFERR_TIMER[2]_i_1 
       (.I0(MASK_RUDI_BUFERR_TIMER[0]),
        .I1(MASK_RUDI_BUFERR_TIMER[1]),
        .I2(MASK_RUDI_BUFERR_TIMER[2]),
        .I3(data_out),
        .I4(I2[1]),
        .I5(p_0_in),
        .O(\n_0_MASK_RUDI_BUFERR_TIMER[2]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair0" *) 
   LUT5 #(
    .INIT(32'h00007F80)) 
     \MASK_RUDI_BUFERR_TIMER[3]_i_1 
       (.I0(MASK_RUDI_BUFERR_TIMER[2]),
        .I1(MASK_RUDI_BUFERR_TIMER[1]),
        .I2(MASK_RUDI_BUFERR_TIMER[0]),
        .I3(MASK_RUDI_BUFERR_TIMER[3]),
        .I4(MASK_RUDI_BUFERR_TIMER0),
        .O(\n_0_MASK_RUDI_BUFERR_TIMER[3]_i_1 ));
LUT6 #(
    .INIT(64'h000000007FFF8000)) 
     \MASK_RUDI_BUFERR_TIMER[4]_i_1 
       (.I0(MASK_RUDI_BUFERR_TIMER[2]),
        .I1(MASK_RUDI_BUFERR_TIMER[1]),
        .I2(MASK_RUDI_BUFERR_TIMER[0]),
        .I3(MASK_RUDI_BUFERR_TIMER[3]),
        .I4(MASK_RUDI_BUFERR_TIMER[4]),
        .I5(MASK_RUDI_BUFERR_TIMER0),
        .O(\n_0_MASK_RUDI_BUFERR_TIMER[4]_i_1 ));
LUT6 #(
    .INIT(64'hA6A600A6A6A6A6A6)) 
     \MASK_RUDI_BUFERR_TIMER[5]_i_1 
       (.I0(MASK_RUDI_BUFERR_TIMER[5]),
        .I1(MASK_RUDI_BUFERR_TIMER[4]),
        .I2(\n_0_MASK_RUDI_BUFERR_TIMER[5]_i_2 ),
        .I3(data_out),
        .I4(I2[1]),
        .I5(p_0_in),
        .O(\n_0_MASK_RUDI_BUFERR_TIMER[5]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair0" *) 
   LUT4 #(
    .INIT(16'h7FFF)) 
     \MASK_RUDI_BUFERR_TIMER[5]_i_2 
       (.I0(MASK_RUDI_BUFERR_TIMER[2]),
        .I1(MASK_RUDI_BUFERR_TIMER[1]),
        .I2(MASK_RUDI_BUFERR_TIMER[0]),
        .I3(MASK_RUDI_BUFERR_TIMER[3]),
        .O(\n_0_MASK_RUDI_BUFERR_TIMER[5]_i_2 ));
LUT5 #(
    .INIT(32'h66066666)) 
     \MASK_RUDI_BUFERR_TIMER[6]_i_1 
       (.I0(\n_0_MASK_RUDI_BUFERR_TIMER[8]_i_3 ),
        .I1(MASK_RUDI_BUFERR_TIMER[6]),
        .I2(data_out),
        .I3(I2[1]),
        .I4(p_0_in),
        .O(\n_0_MASK_RUDI_BUFERR_TIMER[6]_i_1 ));
LUT6 #(
    .INIT(64'h7878007878787878)) 
     \MASK_RUDI_BUFERR_TIMER[7]_i_1 
       (.I0(MASK_RUDI_BUFERR_TIMER[6]),
        .I1(\n_0_MASK_RUDI_BUFERR_TIMER[8]_i_3 ),
        .I2(MASK_RUDI_BUFERR_TIMER[7]),
        .I3(data_out),
        .I4(I2[1]),
        .I5(p_0_in),
        .O(\n_0_MASK_RUDI_BUFERR_TIMER[7]_i_1 ));
LUT5 #(
    .INIT(32'hFFFF7FFF)) 
     \MASK_RUDI_BUFERR_TIMER[8]_i_1 
       (.I0(MASK_RUDI_BUFERR_TIMER[7]),
        .I1(\n_0_MASK_RUDI_BUFERR_TIMER[8]_i_3 ),
        .I2(MASK_RUDI_BUFERR_TIMER[6]),
        .I3(MASK_RUDI_BUFERR_TIMER[8]),
        .I4(MASK_RUDI_BUFERR_TIMER0),
        .O(\n_0_MASK_RUDI_BUFERR_TIMER[8]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair3" *) 
   LUT5 #(
    .INIT(32'h00007F80)) 
     \MASK_RUDI_BUFERR_TIMER[8]_i_2 
       (.I0(MASK_RUDI_BUFERR_TIMER[7]),
        .I1(\n_0_MASK_RUDI_BUFERR_TIMER[8]_i_3 ),
        .I2(MASK_RUDI_BUFERR_TIMER[6]),
        .I3(MASK_RUDI_BUFERR_TIMER[8]),
        .I4(MASK_RUDI_BUFERR_TIMER0),
        .O(\n_0_MASK_RUDI_BUFERR_TIMER[8]_i_2 ));
LUT6 #(
    .INIT(64'h8000000000000000)) 
     \MASK_RUDI_BUFERR_TIMER[8]_i_3 
       (.I0(MASK_RUDI_BUFERR_TIMER[5]),
        .I1(MASK_RUDI_BUFERR_TIMER[4]),
        .I2(MASK_RUDI_BUFERR_TIMER[2]),
        .I3(MASK_RUDI_BUFERR_TIMER[1]),
        .I4(MASK_RUDI_BUFERR_TIMER[0]),
        .I5(MASK_RUDI_BUFERR_TIMER[3]),
        .O(\n_0_MASK_RUDI_BUFERR_TIMER[8]_i_3 ));
FDSE \MASK_RUDI_BUFERR_TIMER_reg[0] 
       (.C(CLK),
        .CE(\n_0_MASK_RUDI_BUFERR_TIMER[8]_i_1 ),
        .D(\n_0_MASK_RUDI_BUFERR_TIMER[0]_i_1 ),
        .Q(MASK_RUDI_BUFERR_TIMER[0]),
        .S(I1));
FDSE \MASK_RUDI_BUFERR_TIMER_reg[1] 
       (.C(CLK),
        .CE(\n_0_MASK_RUDI_BUFERR_TIMER[8]_i_1 ),
        .D(\n_0_MASK_RUDI_BUFERR_TIMER[1]_i_1 ),
        .Q(MASK_RUDI_BUFERR_TIMER[1]),
        .S(I1));
FDSE \MASK_RUDI_BUFERR_TIMER_reg[2] 
       (.C(CLK),
        .CE(\n_0_MASK_RUDI_BUFERR_TIMER[8]_i_1 ),
        .D(\n_0_MASK_RUDI_BUFERR_TIMER[2]_i_1 ),
        .Q(MASK_RUDI_BUFERR_TIMER[2]),
        .S(I1));
FDSE \MASK_RUDI_BUFERR_TIMER_reg[3] 
       (.C(CLK),
        .CE(\n_0_MASK_RUDI_BUFERR_TIMER[8]_i_1 ),
        .D(\n_0_MASK_RUDI_BUFERR_TIMER[3]_i_1 ),
        .Q(MASK_RUDI_BUFERR_TIMER[3]),
        .S(I1));
FDSE \MASK_RUDI_BUFERR_TIMER_reg[4] 
       (.C(CLK),
        .CE(\n_0_MASK_RUDI_BUFERR_TIMER[8]_i_1 ),
        .D(\n_0_MASK_RUDI_BUFERR_TIMER[4]_i_1 ),
        .Q(MASK_RUDI_BUFERR_TIMER[4]),
        .S(I1));
FDSE \MASK_RUDI_BUFERR_TIMER_reg[5] 
       (.C(CLK),
        .CE(\n_0_MASK_RUDI_BUFERR_TIMER[8]_i_1 ),
        .D(\n_0_MASK_RUDI_BUFERR_TIMER[5]_i_1 ),
        .Q(MASK_RUDI_BUFERR_TIMER[5]),
        .S(I1));
FDSE \MASK_RUDI_BUFERR_TIMER_reg[6] 
       (.C(CLK),
        .CE(\n_0_MASK_RUDI_BUFERR_TIMER[8]_i_1 ),
        .D(\n_0_MASK_RUDI_BUFERR_TIMER[6]_i_1 ),
        .Q(MASK_RUDI_BUFERR_TIMER[6]),
        .S(I1));
FDSE \MASK_RUDI_BUFERR_TIMER_reg[7] 
       (.C(CLK),
        .CE(\n_0_MASK_RUDI_BUFERR_TIMER[8]_i_1 ),
        .D(\n_0_MASK_RUDI_BUFERR_TIMER[7]_i_1 ),
        .Q(MASK_RUDI_BUFERR_TIMER[7]),
        .S(I1));
FDSE \MASK_RUDI_BUFERR_TIMER_reg[8] 
       (.C(CLK),
        .CE(\n_0_MASK_RUDI_BUFERR_TIMER[8]_i_1 ),
        .D(\n_0_MASK_RUDI_BUFERR_TIMER[8]_i_2 ),
        .Q(MASK_RUDI_BUFERR_TIMER[8]),
        .S(I1));
LUT6 #(
    .INIT(64'h0000AEAA00000C00)) 
     MASK_RUDI_BUFERR_i_1
       (.I0(n_0_MASK_RUDI_BUFERR_i_2),
        .I1(p_0_in),
        .I2(I2[1]),
        .I3(data_out),
        .I4(I1),
        .I5(O1),
        .O(n_0_MASK_RUDI_BUFERR_i_1));
(* SOFT_HLUTNM = "soft_lutpair3" *) 
   LUT4 #(
    .INIT(16'h7FFF)) 
     MASK_RUDI_BUFERR_i_2
       (.I0(MASK_RUDI_BUFERR_TIMER[8]),
        .I1(MASK_RUDI_BUFERR_TIMER[6]),
        .I2(\n_0_MASK_RUDI_BUFERR_TIMER[8]_i_3 ),
        .I3(MASK_RUDI_BUFERR_TIMER[7]),
        .O(n_0_MASK_RUDI_BUFERR_i_2));
FDRE MASK_RUDI_BUFERR_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_MASK_RUDI_BUFERR_i_1),
        .Q(O1),
        .R(1'b0));
LUT6 #(
    .INIT(64'hFFFB0000FFF00000)) 
     MASK_RUDI_CLKCOR_i_1
       (.I0(RX_RUDI_INVALID),
        .I1(RX_RUDI_INVALID_REG),
        .I2(I10[0]),
        .I3(I10[1]),
        .I4(SYNC_STATUS_HELD),
        .I5(n_0_MASK_RUDI_CLKCOR_reg),
        .O(n_0_MASK_RUDI_CLKCOR_i_1));
FDRE MASK_RUDI_CLKCOR_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_MASK_RUDI_CLKCOR_i_1),
        .Q(n_0_MASK_RUDI_CLKCOR_reg),
        .R(1'b0));
LUT6 #(
    .INIT(64'h00000000BAAAAAA0)) 
     MR_AN_COMPLETE_i_1
       (.I0(an_interrupt),
        .I1(\n_0_STATE_reg[3] ),
        .I2(\n_0_STATE_reg[2] ),
        .I3(\n_0_STATE_reg[1] ),
        .I4(\n_0_STATE_reg[0] ),
        .I5(I1),
        .O(n_0_MR_AN_COMPLETE_i_1));
FDRE MR_AN_COMPLETE_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_MR_AN_COMPLETE_i_1),
        .Q(an_interrupt),
        .R(1'b0));
LUT2 #(
    .INIT(4'h6)) 
     MR_AN_ENABLE_CHANGE_i_1
       (.I0(MR_AN_ENABLE_REG1),
        .I1(MR_AN_ENABLE_REG2),
        .O(MR_AN_ENABLE_CHANGE0));
FDRE MR_AN_ENABLE_CHANGE_reg
       (.C(CLK),
        .CE(1'b1),
        .D(MR_AN_ENABLE_CHANGE0),
        .Q(MR_AN_ENABLE_CHANGE),
        .R(I1));
FDRE MR_AN_ENABLE_REG1_reg
       (.C(CLK),
        .CE(1'b1),
        .D(I2[3]),
        .Q(MR_AN_ENABLE_REG1),
        .R(I1));
FDRE MR_AN_ENABLE_REG2_reg
       (.C(CLK),
        .CE(1'b1),
        .D(MR_AN_ENABLE_REG1),
        .Q(MR_AN_ENABLE_REG2),
        .R(I1));
FDRE \MR_LP_ADV_ABILITY_INT_reg[13] 
       (.C(CLK),
        .CE(MR_PAGE_RX_SET128_out),
        .D(Q[12]),
        .Q(STAT_VEC_DUPLEX_MODE_RSLVD),
        .R(I1));
LUT4 #(
    .INIT(16'h5510)) 
     MR_REMOTE_FAULT_i_1
       (.I0(I1),
        .I1(status_vector[1]),
        .I2(GENERATE_REMOTE_FAULT),
        .I3(status_vector[5]),
        .O(n_0_MR_REMOTE_FAULT_i_1));
FDRE MR_REMOTE_FAULT_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_MR_REMOTE_FAULT_i_1),
        .Q(status_vector[5]),
        .R(1'b0));
LUT6 #(
    .INIT(64'h2020332000003300)) 
     MR_RESTART_AN_INT_i_1
       (.I0(n_0_XMIT_CONFIG_INT_i_3),
        .I1(I1),
        .I2(I2[3]),
        .I3(MR_RESTART_AN_SET_REG1),
        .I4(MR_RESTART_AN_SET_REG2),
        .I5(n_0_MR_RESTART_AN_INT_reg),
        .O(n_0_MR_RESTART_AN_INT_i_1));
FDRE MR_RESTART_AN_INT_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_MR_RESTART_AN_INT_i_1),
        .Q(n_0_MR_RESTART_AN_INT_reg),
        .R(1'b0));
FDRE MR_RESTART_AN_SET_REG1_reg
       (.C(CLK),
        .CE(1'b1),
        .D(RESTART_AN_SET),
        .Q(MR_RESTART_AN_SET_REG1),
        .R(I1));
FDRE MR_RESTART_AN_SET_REG2_reg
       (.C(CLK),
        .CE(1'b1),
        .D(MR_RESTART_AN_SET_REG1),
        .Q(MR_RESTART_AN_SET_REG2),
        .R(I1));
FDRE \PREVIOUS_STATE_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_STATE_reg[0] ),
        .Q(PREVIOUS_STATE[0]),
        .R(STATE0));
FDRE \PREVIOUS_STATE_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_STATE_reg[1] ),
        .Q(PREVIOUS_STATE[1]),
        .R(STATE0));
FDRE \PREVIOUS_STATE_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_STATE_reg[2] ),
        .Q(PREVIOUS_STATE[2]),
        .R(STATE0));
FDRE \PREVIOUS_STATE_reg[3] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_STATE_reg[3] ),
        .Q(PREVIOUS_STATE[3]),
        .R(STATE0));
LUT2 #(
    .INIT(4'h2)) 
     PULSE4096_i_1
       (.I0(TIMER4096_MSB_REG),
        .I1(\n_0_TIMER4096_reg[11] ),
        .O(PULSE40960));
FDRE PULSE4096_reg
       (.C(CLK),
        .CE(1'b1),
        .D(PULSE40960),
        .Q(PULSE4096),
        .R(I1));
FDRE RECEIVED_IDLE_reg
       (.C(CLK),
        .CE(1'b1),
        .D(I4),
        .Q(O2),
        .R(1'b0));
FDRE RUDI_INVALID_reg
       (.C(CLK),
        .CE(1'b1),
        .D(RX_RUDI_INVALID_DELAY[1]),
        .Q(status_vector[0]),
        .R(I1));
FDRE RX_CONFIG_REG_NULL_reg
       (.C(CLK),
        .CE(1'b1),
        .D(I6),
        .Q(O3),
        .R(1'b0));
FDRE \RX_CONFIG_REG_REG_reg[0] 
       (.C(CLK),
        .CE(RX_CONFIG_VALID),
        .D(Q[0]),
        .Q(\n_0_RX_CONFIG_REG_REG_reg[0] ),
        .R(SR));
FDRE \RX_CONFIG_REG_REG_reg[10] 
       (.C(CLK),
        .CE(RX_CONFIG_VALID),
        .D(Q[10]),
        .Q(O6[1]),
        .R(SR));
FDRE \RX_CONFIG_REG_REG_reg[11] 
       (.C(CLK),
        .CE(RX_CONFIG_VALID),
        .D(Q[11]),
        .Q(O6[2]),
        .R(SR));
FDRE \RX_CONFIG_REG_REG_reg[12] 
       (.C(CLK),
        .CE(RX_CONFIG_VALID),
        .D(Q[12]),
        .Q(\n_0_RX_CONFIG_REG_REG_reg[12] ),
        .R(SR));
FDRE \RX_CONFIG_REG_REG_reg[13] 
       (.C(CLK),
        .CE(RX_CONFIG_VALID),
        .D(Q[13]),
        .Q(\n_0_RX_CONFIG_REG_REG_reg[13] ),
        .R(SR));
FDRE \RX_CONFIG_REG_REG_reg[14] 
       (.C(CLK),
        .CE(RX_CONFIG_VALID),
        .D(Q[14]),
        .Q(O6[3]),
        .R(SR));
FDRE \RX_CONFIG_REG_REG_reg[15] 
       (.C(CLK),
        .CE(RX_CONFIG_VALID),
        .D(Q[15]),
        .Q(p_0_in0_in),
        .R(SR));
FDRE \RX_CONFIG_REG_REG_reg[1] 
       (.C(CLK),
        .CE(RX_CONFIG_VALID),
        .D(Q[1]),
        .Q(\n_0_RX_CONFIG_REG_REG_reg[1] ),
        .R(SR));
FDRE \RX_CONFIG_REG_REG_reg[2] 
       (.C(CLK),
        .CE(RX_CONFIG_VALID),
        .D(Q[2]),
        .Q(\n_0_RX_CONFIG_REG_REG_reg[2] ),
        .R(SR));
FDRE \RX_CONFIG_REG_REG_reg[3] 
       (.C(CLK),
        .CE(RX_CONFIG_VALID),
        .D(Q[3]),
        .Q(\n_0_RX_CONFIG_REG_REG_reg[3] ),
        .R(SR));
FDRE \RX_CONFIG_REG_REG_reg[4] 
       (.C(CLK),
        .CE(RX_CONFIG_VALID),
        .D(Q[4]),
        .Q(\n_0_RX_CONFIG_REG_REG_reg[4] ),
        .R(SR));
FDRE \RX_CONFIG_REG_REG_reg[5] 
       (.C(CLK),
        .CE(RX_CONFIG_VALID),
        .D(Q[5]),
        .Q(\n_0_RX_CONFIG_REG_REG_reg[5] ),
        .R(SR));
FDRE \RX_CONFIG_REG_REG_reg[6] 
       (.C(CLK),
        .CE(RX_CONFIG_VALID),
        .D(Q[6]),
        .Q(\n_0_RX_CONFIG_REG_REG_reg[6] ),
        .R(SR));
FDRE \RX_CONFIG_REG_REG_reg[7] 
       (.C(CLK),
        .CE(RX_CONFIG_VALID),
        .D(Q[7]),
        .Q(\n_0_RX_CONFIG_REG_REG_reg[7] ),
        .R(SR));
FDRE \RX_CONFIG_REG_REG_reg[8] 
       (.C(CLK),
        .CE(RX_CONFIG_VALID),
        .D(Q[8]),
        .Q(\n_0_RX_CONFIG_REG_REG_reg[8] ),
        .R(SR));
FDRE \RX_CONFIG_REG_REG_reg[9] 
       (.C(CLK),
        .CE(RX_CONFIG_VALID),
        .D(Q[9]),
        .Q(O6[0]),
        .R(SR));
LUT6 #(
    .INIT(64'h0080000000000080)) 
     \RX_CONFIG_SNAPSHOT[15]_i_1 
       (.I0(\n_3_RX_CONFIG_SNAPSHOT_reg[15]_i_2 ),
        .I1(\n_0_RX_CONFIG_SNAPSHOT[15]_i_3 ),
        .I2(\n_0_RX_CONFIG_SNAPSHOT[15]_i_4 ),
        .I3(O2),
        .I4(Q[15]),
        .I5(p_0_in0_in),
        .O(RX_CONFIG_SNAPSHOT));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     \RX_CONFIG_SNAPSHOT[15]_i_10 
       (.I0(\n_0_RX_CONFIG_REG_REG_reg[2] ),
        .I1(Q[2]),
        .I2(Q[0]),
        .I3(\n_0_RX_CONFIG_REG_REG_reg[0] ),
        .I4(Q[1]),
        .I5(\n_0_RX_CONFIG_REG_REG_reg[1] ),
        .O(\n_0_RX_CONFIG_SNAPSHOT[15]_i_10 ));
LUT5 #(
    .INIT(32'h00000020)) 
     \RX_CONFIG_SNAPSHOT[15]_i_3 
       (.I0(RX_CONFIG_VALID),
        .I1(ABILITY_MATCH),
        .I2(ABILITY_MATCH_2),
        .I3(RX_IDLE),
        .I4(O1),
        .O(\n_0_RX_CONFIG_SNAPSHOT[15]_i_3 ));
(* SOFT_HLUTNM = "soft_lutpair7" *) 
   LUT4 #(
    .INIT(16'hFFDF)) 
     \RX_CONFIG_SNAPSHOT[15]_i_4 
       (.I0(\n_0_STATE_reg[0] ),
        .I1(\n_0_STATE_reg[3] ),
        .I2(\n_0_STATE_reg[1] ),
        .I3(\n_0_STATE_reg[2] ),
        .O(\n_0_RX_CONFIG_SNAPSHOT[15]_i_4 ));
LUT4 #(
    .INIT(16'h9009)) 
     \RX_CONFIG_SNAPSHOT[15]_i_6 
       (.I0(\n_0_RX_CONFIG_REG_REG_reg[13] ),
        .I1(Q[13]),
        .I2(\n_0_RX_CONFIG_REG_REG_reg[12] ),
        .I3(Q[12]),
        .O(\n_0_RX_CONFIG_SNAPSHOT[15]_i_6 ));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     \RX_CONFIG_SNAPSHOT[15]_i_8 
       (.I0(\n_0_RX_CONFIG_REG_REG_reg[8] ),
        .I1(Q[8]),
        .I2(Q[6]),
        .I3(\n_0_RX_CONFIG_REG_REG_reg[6] ),
        .I4(Q[7]),
        .I5(\n_0_RX_CONFIG_REG_REG_reg[7] ),
        .O(\n_0_RX_CONFIG_SNAPSHOT[15]_i_8 ));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     \RX_CONFIG_SNAPSHOT[15]_i_9 
       (.I0(\n_0_RX_CONFIG_REG_REG_reg[5] ),
        .I1(Q[5]),
        .I2(Q[3]),
        .I3(\n_0_RX_CONFIG_REG_REG_reg[3] ),
        .I4(Q[4]),
        .I5(\n_0_RX_CONFIG_REG_REG_reg[4] ),
        .O(\n_0_RX_CONFIG_SNAPSHOT[15]_i_9 ));
FDRE \RX_CONFIG_SNAPSHOT_reg[0] 
       (.C(CLK),
        .CE(RX_CONFIG_SNAPSHOT),
        .D(Q[0]),
        .Q(\n_0_RX_CONFIG_SNAPSHOT_reg[0] ),
        .R(I1));
FDRE \RX_CONFIG_SNAPSHOT_reg[10] 
       (.C(CLK),
        .CE(RX_CONFIG_SNAPSHOT),
        .D(Q[10]),
        .Q(O7[1]),
        .R(I1));
FDRE \RX_CONFIG_SNAPSHOT_reg[11] 
       (.C(CLK),
        .CE(RX_CONFIG_SNAPSHOT),
        .D(Q[11]),
        .Q(O7[2]),
        .R(I1));
FDRE \RX_CONFIG_SNAPSHOT_reg[12] 
       (.C(CLK),
        .CE(RX_CONFIG_SNAPSHOT),
        .D(Q[12]),
        .Q(\n_0_RX_CONFIG_SNAPSHOT_reg[12] ),
        .R(I1));
FDRE \RX_CONFIG_SNAPSHOT_reg[13] 
       (.C(CLK),
        .CE(RX_CONFIG_SNAPSHOT),
        .D(Q[13]),
        .Q(\n_0_RX_CONFIG_SNAPSHOT_reg[13] ),
        .R(I1));
FDRE \RX_CONFIG_SNAPSHOT_reg[15] 
       (.C(CLK),
        .CE(RX_CONFIG_SNAPSHOT),
        .D(Q[15]),
        .Q(\n_0_RX_CONFIG_SNAPSHOT_reg[15] ),
        .R(I1));
CARRY4 \RX_CONFIG_SNAPSHOT_reg[15]_i_2 
       (.CI(\n_0_RX_CONFIG_SNAPSHOT_reg[15]_i_5 ),
        .CO({\NLW_RX_CONFIG_SNAPSHOT_reg[15]_i_2_CO_UNCONNECTED [3:1],\n_3_RX_CONFIG_SNAPSHOT_reg[15]_i_2 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(\NLW_RX_CONFIG_SNAPSHOT_reg[15]_i_2_O_UNCONNECTED [3:0]),
        .S({1'b0,1'b0,1'b0,\n_0_RX_CONFIG_SNAPSHOT[15]_i_6 }));
CARRY4 \RX_CONFIG_SNAPSHOT_reg[15]_i_5 
       (.CI(1'b0),
        .CO({\n_0_RX_CONFIG_SNAPSHOT_reg[15]_i_5 ,\n_1_RX_CONFIG_SNAPSHOT_reg[15]_i_5 ,\n_2_RX_CONFIG_SNAPSHOT_reg[15]_i_5 ,\n_3_RX_CONFIG_SNAPSHOT_reg[15]_i_5 }),
        .CYINIT(1'b1),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(\NLW_RX_CONFIG_SNAPSHOT_reg[15]_i_5_O_UNCONNECTED [3:0]),
        .S({S,\n_0_RX_CONFIG_SNAPSHOT[15]_i_8 ,\n_0_RX_CONFIG_SNAPSHOT[15]_i_9 ,\n_0_RX_CONFIG_SNAPSHOT[15]_i_10 }));
FDRE \RX_CONFIG_SNAPSHOT_reg[1] 
       (.C(CLK),
        .CE(RX_CONFIG_SNAPSHOT),
        .D(Q[1]),
        .Q(\n_0_RX_CONFIG_SNAPSHOT_reg[1] ),
        .R(I1));
FDRE \RX_CONFIG_SNAPSHOT_reg[2] 
       (.C(CLK),
        .CE(RX_CONFIG_SNAPSHOT),
        .D(Q[2]),
        .Q(\n_0_RX_CONFIG_SNAPSHOT_reg[2] ),
        .R(I1));
FDRE \RX_CONFIG_SNAPSHOT_reg[3] 
       (.C(CLK),
        .CE(RX_CONFIG_SNAPSHOT),
        .D(Q[3]),
        .Q(\n_0_RX_CONFIG_SNAPSHOT_reg[3] ),
        .R(I1));
FDRE \RX_CONFIG_SNAPSHOT_reg[4] 
       (.C(CLK),
        .CE(RX_CONFIG_SNAPSHOT),
        .D(Q[4]),
        .Q(\n_0_RX_CONFIG_SNAPSHOT_reg[4] ),
        .R(I1));
FDRE \RX_CONFIG_SNAPSHOT_reg[5] 
       (.C(CLK),
        .CE(RX_CONFIG_SNAPSHOT),
        .D(Q[5]),
        .Q(\n_0_RX_CONFIG_SNAPSHOT_reg[5] ),
        .R(I1));
FDRE \RX_CONFIG_SNAPSHOT_reg[6] 
       (.C(CLK),
        .CE(RX_CONFIG_SNAPSHOT),
        .D(Q[6]),
        .Q(\n_0_RX_CONFIG_SNAPSHOT_reg[6] ),
        .R(I1));
FDRE \RX_CONFIG_SNAPSHOT_reg[7] 
       (.C(CLK),
        .CE(RX_CONFIG_SNAPSHOT),
        .D(Q[7]),
        .Q(\n_0_RX_CONFIG_SNAPSHOT_reg[7] ),
        .R(I1));
FDRE \RX_CONFIG_SNAPSHOT_reg[8] 
       (.C(CLK),
        .CE(RX_CONFIG_SNAPSHOT),
        .D(Q[8]),
        .Q(\n_0_RX_CONFIG_SNAPSHOT_reg[8] ),
        .R(I1));
FDRE \RX_CONFIG_SNAPSHOT_reg[9] 
       (.C(CLK),
        .CE(RX_CONFIG_SNAPSHOT),
        .D(Q[9]),
        .Q(O7[0]),
        .R(I1));
LUT6 #(
    .INIT(64'h0A0B0A0A0A0A0A0A)) 
     RX_DV_i_1
       (.I0(n_0_RX_DV_i_2),
        .I1(EOP_REG1),
        .I2(I7),
        .I3(I8),
        .I4(XMIT_DATA),
        .I5(I9),
        .O(O5));
LUT4 #(
    .INIT(16'h0008)) 
     RX_DV_i_2
       (.I0(O4),
        .I1(SOP_REG3),
        .I2(I2[2]),
        .I3(I2[1]),
        .O(n_0_RX_DV_i_2));
FDRE RX_IDLE_REG1_reg
       (.C(CLK),
        .CE(1'b1),
        .D(RX_IDLE),
        .Q(RX_IDLE_REG1),
        .R(I1));
FDRE RX_IDLE_REG2_reg
       (.C(CLK),
        .CE(1'b1),
        .D(RX_IDLE_REG1),
        .Q(RX_IDLE_REG2),
        .R(I1));
LUT5 #(
    .INIT(32'h000000AB)) 
     \RX_RUDI_INVALID_DELAY[0]_i_1 
       (.I0(I12),
        .I1(XMIT_DATA),
        .I2(RXSYNC_STATUS),
        .I3(O1),
        .I4(n_0_MASK_RUDI_CLKCOR_reg),
        .O(RX_RUDI_INVALID_DELAY0));
FDRE \RX_RUDI_INVALID_DELAY_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(RX_RUDI_INVALID_DELAY0),
        .Q(RX_RUDI_INVALID_DELAY[0]),
        .R(I1));
FDRE \RX_RUDI_INVALID_DELAY_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(RX_RUDI_INVALID_DELAY[0]),
        .Q(RX_RUDI_INVALID_DELAY[1]),
        .R(I1));
FDRE RX_RUDI_INVALID_REG_reg
       (.C(CLK),
        .CE(1'b1),
        .D(I3),
        .Q(RX_RUDI_INVALID_REG),
        .R(1'b0));
FDRE SGMII_PHY_STATUS_reg
       (.C(CLK),
        .CE(MR_PAGE_RX_SET128_out),
        .D(Q[15]),
        .Q(status_vector[1]),
        .R(I1));
LUT5 #(
    .INIT(32'h00001000)) 
     \SGMII_SPEED[1]_i_1 
       (.I0(PREVIOUS_STATE[3]),
        .I1(PREVIOUS_STATE[2]),
        .I2(PREVIOUS_STATE[0]),
        .I3(PREVIOUS_STATE[1]),
        .I4(\n_0_SGMII_SPEED[1]_i_2 ),
        .O(MR_PAGE_RX_SET128_out));
(* SOFT_HLUTNM = "soft_lutpair11" *) 
   LUT4 #(
    .INIT(16'hFFFB)) 
     \SGMII_SPEED[1]_i_2 
       (.I0(\n_0_STATE_reg[0] ),
        .I1(\n_0_STATE_reg[2] ),
        .I2(\n_0_STATE_reg[1] ),
        .I3(\n_0_STATE_reg[3] ),
        .O(\n_0_SGMII_SPEED[1]_i_2 ));
FDRE \SGMII_SPEED_reg[0] 
       (.C(CLK),
        .CE(MR_PAGE_RX_SET128_out),
        .D(Q[10]),
        .Q(status_vector[3]),
        .R(I1));
FDSE \SGMII_SPEED_reg[1] 
       (.C(CLK),
        .CE(MR_PAGE_RX_SET128_out),
        .D(Q[11]),
        .Q(status_vector[4]),
        .S(I1));
(* SOFT_HLUTNM = "soft_lutpair13" *) 
   LUT4 #(
    .INIT(16'hF200)) 
     SOP_i_2
       (.I0(I2[0]),
        .I1(I2[3]),
        .I2(XMIT_DATA_INT),
        .I3(RXSYNC_STATUS),
        .O(O4));
FDRE START_LINK_TIMER_REG2_reg
       (.C(CLK),
        .CE(1'b1),
        .D(START_LINK_TIMER_REG),
        .Q(START_LINK_TIMER_REG2),
        .R(I1));
LUT6 #(
    .INIT(64'hEEEEEEEEEEFEFEFE)) 
     START_LINK_TIMER_REG_i_1
       (.I0(\n_0_STATE[3]_i_3 ),
        .I1(n_0_START_LINK_TIMER_REG_i_2),
        .I2(LINK_TIMER_DONE),
        .I3(ABILITY_MATCH),
        .I4(O3),
        .I5(\n_0_SGMII_SPEED[1]_i_2 ),
        .O(n_0_START_LINK_TIMER_REG_i_1));
LUT6 #(
    .INIT(64'h00000C0200000002)) 
     START_LINK_TIMER_REG_i_2
       (.I0(I2[3]),
        .I1(\n_0_STATE_reg[0] ),
        .I2(\n_0_STATE_reg[3] ),
        .I3(\n_0_STATE_reg[1] ),
        .I4(\n_0_STATE_reg[2] ),
        .I5(\n_0_STATE[2]_i_5 ),
        .O(n_0_START_LINK_TIMER_REG_i_2));
FDRE START_LINK_TIMER_REG_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_START_LINK_TIMER_REG_i_1),
        .Q(START_LINK_TIMER_REG),
        .R(I1));
LUT6 #(
    .INIT(64'hAAAAA800AAAAAAAA)) 
     \STATE[0]_i_1 
       (.I0(\n_0_STATE[2]_i_2 ),
        .I1(LINK_TIMER_DONE),
        .I2(\n_0_STATE_reg[0] ),
        .I3(\n_0_STATE[0]_i_2 ),
        .I4(\n_0_STATE[0]_i_3 ),
        .I5(\n_0_STATE[0]_i_4 ),
        .O(\n_0_STATE[0]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair10" *) 
   LUT4 #(
    .INIT(16'h0444)) 
     \STATE[0]_i_2 
       (.I0(\n_0_STATE_reg[1] ),
        .I1(\n_0_STATE_reg[2] ),
        .I2(O3),
        .I3(ABILITY_MATCH),
        .O(\n_0_STATE[0]_i_2 ));
(* SOFT_HLUTNM = "soft_lutpair8" *) 
   LUT5 #(
    .INIT(32'h2AA20880)) 
     \STATE[0]_i_3 
       (.I0(\n_0_STATE[2]_i_4 ),
        .I1(ABILITY_MATCH),
        .I2(TOGGLE_RX),
        .I3(O6[2]),
        .I4(\n_0_STATE_reg[0] ),
        .O(\n_0_STATE[0]_i_3 ));
LUT6 #(
    .INIT(64'hFFFFFBABAAAAFBAB)) 
     \STATE[0]_i_4 
       (.I0(\n_0_STATE_reg[2] ),
        .I1(I2[3]),
        .I2(\n_0_STATE_reg[0] ),
        .I3(LINK_TIMER_DONE),
        .I4(\n_0_STATE_reg[1] ),
        .I5(\n_0_STATE[0]_i_5 ),
        .O(\n_0_STATE[0]_i_4 ));
(* SOFT_HLUTNM = "soft_lutpair12" *) 
   LUT4 #(
    .INIT(16'hF833)) 
     \STATE[0]_i_5 
       (.I0(n_0_ACKNOWLEDGE_MATCH_3_reg),
        .I1(\n_0_STATE_reg[0] ),
        .I2(O3),
        .I3(ABILITY_MATCH),
        .O(\n_0_STATE[0]_i_5 ));
LUT2 #(
    .INIT(4'h2)) 
     \STATE[1]_i_1 
       (.I0(\n_0_STATE[2]_i_2 ),
        .I1(\n_0_STATE[1]_i_2 ),
        .O(\n_0_STATE[1]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair9" *) 
   LUT5 #(
    .INIT(32'h0000FACA)) 
     \STATE[1]_i_2 
       (.I0(\n_0_STATE[1]_i_3 ),
        .I1(\n_0_STATE_reg[1] ),
        .I2(\n_0_STATE_reg[2] ),
        .I3(\n_0_STATE[1]_i_4 ),
        .I4(\n_0_STATE[2]_i_4 ),
        .O(\n_0_STATE[1]_i_2 ));
LUT6 #(
    .INIT(64'hC800C8FF00FF00FF)) 
     \STATE[1]_i_3 
       (.I0(n_0_ACKNOWLEDGE_MATCH_3_reg),
        .I1(ABILITY_MATCH),
        .I2(O3),
        .I3(\n_0_STATE_reg[1] ),
        .I4(LINK_TIMER_DONE),
        .I5(\n_0_STATE_reg[0] ),
        .O(\n_0_STATE[1]_i_3 ));
LUT5 #(
    .INIT(32'hD5FFFFFF)) 
     \STATE[1]_i_4 
       (.I0(LINK_TIMER_DONE),
        .I1(ABILITY_MATCH),
        .I2(O3),
        .I3(\n_0_STATE_reg[0] ),
        .I4(IDLE_MATCH),
        .O(\n_0_STATE[1]_i_4 ));
LUT6 #(
    .INIT(64'hA88AAAAA88888888)) 
     \STATE[2]_i_1 
       (.I0(\n_0_STATE[2]_i_2 ),
        .I1(\n_0_STATE[2]_i_3 ),
        .I2(O6[2]),
        .I3(TOGGLE_RX),
        .I4(ABILITY_MATCH),
        .I5(\n_0_STATE[2]_i_4 ),
        .O(\n_0_STATE[2]_i_1 ));
LUT6 #(
    .INIT(64'h0000000055515555)) 
     \STATE[2]_i_2 
       (.I0(\n_0_STATE_reg[3] ),
        .I1(RX_RUDI_INVALID),
        .I2(O1),
        .I3(n_0_MASK_RUDI_CLKCOR_reg),
        .I4(XMIT_CONFIG_INT),
        .I5(\n_0_STATE[3]_i_5 ),
        .O(\n_0_STATE[2]_i_2 ));
LUT6 #(
    .INIT(64'h07F0070007000700)) 
     \STATE[2]_i_3 
       (.I0(ABILITY_MATCH),
        .I1(O3),
        .I2(\n_0_STATE_reg[1] ),
        .I3(\n_0_STATE_reg[2] ),
        .I4(\n_0_STATE_reg[0] ),
        .I5(\n_0_STATE[2]_i_5 ),
        .O(\n_0_STATE[2]_i_3 ));
(* SOFT_HLUTNM = "soft_lutpair10" *) 
   LUT5 #(
    .INIT(32'h00C040C0)) 
     \STATE[2]_i_4 
       (.I0(\n_0_STATE_reg[0] ),
        .I1(\n_0_STATE_reg[2] ),
        .I2(\n_0_STATE_reg[1] ),
        .I3(ABILITY_MATCH),
        .I4(O3),
        .O(\n_0_STATE[2]_i_4 ));
(* SOFT_HLUTNM = "soft_lutpair12" *) 
   LUT4 #(
    .INIT(16'h0080)) 
     \STATE[2]_i_5 
       (.I0(ABILITY_MATCH),
        .I1(n_0_ACKNOWLEDGE_MATCH_3_reg),
        .I2(CONSISTENCY_MATCH),
        .I3(O3),
        .O(\n_0_STATE[2]_i_5 ));
LUT2 #(
    .INIT(4'hB)) 
     \STATE[3]_i_1 
       (.I0(I1),
        .I1(I13),
        .O(STATE0));
LUT4 #(
    .INIT(16'h2F20)) 
     \STATE[3]_i_2 
       (.I0(AN_SYNC_STATUS),
        .I1(I2[3]),
        .I2(\n_0_STATE[3]_i_3 ),
        .I3(\n_0_STATE[3]_i_4 ),
        .O(\n_0_STATE[3]_i_2 ));
LUT5 #(
    .INIT(32'hAAAEAAAA)) 
     \STATE[3]_i_3 
       (.I0(\n_0_STATE[3]_i_5 ),
        .I1(XMIT_CONFIG_INT),
        .I2(n_0_MASK_RUDI_CLKCOR_reg),
        .I3(O1),
        .I4(RX_RUDI_INVALID),
        .O(\n_0_STATE[3]_i_3 ));
(* SOFT_HLUTNM = "soft_lutpair5" *) 
   LUT5 #(
    .INIT(32'h00100011)) 
     \STATE[3]_i_4 
       (.I0(\n_0_STATE_reg[1] ),
        .I1(\n_0_STATE_reg[0] ),
        .I2(\n_0_STATE_reg[3] ),
        .I3(\n_0_STATE_reg[2] ),
        .I4(I2[3]),
        .O(\n_0_STATE[3]_i_4 ));
LUT3 #(
    .INIT(8'hFB)) 
     \STATE[3]_i_5 
       (.I0(n_0_MR_RESTART_AN_INT_reg),
        .I1(AN_SYNC_STATUS),
        .I2(MR_AN_ENABLE_CHANGE),
        .O(\n_0_STATE[3]_i_5 ));
FDRE \STATE_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_STATE[0]_i_1 ),
        .Q(\n_0_STATE_reg[0] ),
        .R(STATE0));
FDRE \STATE_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_STATE[1]_i_1 ),
        .Q(\n_0_STATE_reg[1] ),
        .R(STATE0));
FDRE \STATE_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_STATE[2]_i_1 ),
        .Q(\n_0_STATE_reg[2] ),
        .R(STATE0));
FDRE \STATE_reg[3] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_STATE[3]_i_2 ),
        .Q(\n_0_STATE_reg[3] ),
        .R(STATE0));
LUT5 #(
    .INIT(32'h00BF00AA)) 
     SYNC_STATUS_HELD_i_1
       (.I0(RXSYNC_STATUS),
        .I1(LINK_TIMER_SATURATED),
        .I2(PULSE4096),
        .I3(I1),
        .I4(SYNC_STATUS_HELD__0),
        .O(n_0_SYNC_STATUS_HELD_i_1));
FDRE SYNC_STATUS_HELD_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_SYNC_STATUS_HELD_i_1),
        .Q(SYNC_STATUS_HELD__0),
        .R(1'b0));
LUT1 #(
    .INIT(2'h2)) 
     \TIMER4096[0]_i_2 
       (.I0(\n_0_TIMER4096_reg[3] ),
        .O(\n_0_TIMER4096[0]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \TIMER4096[0]_i_3 
       (.I0(\n_0_TIMER4096_reg[2] ),
        .O(\n_0_TIMER4096[0]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \TIMER4096[0]_i_4 
       (.I0(\n_0_TIMER4096_reg[1] ),
        .O(\n_0_TIMER4096[0]_i_4 ));
LUT1 #(
    .INIT(2'h1)) 
     \TIMER4096[0]_i_5 
       (.I0(\n_0_TIMER4096_reg[0] ),
        .O(\n_0_TIMER4096[0]_i_5 ));
LUT1 #(
    .INIT(2'h2)) 
     \TIMER4096[4]_i_2 
       (.I0(\n_0_TIMER4096_reg[7] ),
        .O(\n_0_TIMER4096[4]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \TIMER4096[4]_i_3 
       (.I0(\n_0_TIMER4096_reg[6] ),
        .O(\n_0_TIMER4096[4]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \TIMER4096[4]_i_4 
       (.I0(\n_0_TIMER4096_reg[5] ),
        .O(\n_0_TIMER4096[4]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \TIMER4096[4]_i_5 
       (.I0(\n_0_TIMER4096_reg[4] ),
        .O(\n_0_TIMER4096[4]_i_5 ));
LUT1 #(
    .INIT(2'h2)) 
     \TIMER4096[8]_i_2 
       (.I0(\n_0_TIMER4096_reg[11] ),
        .O(\n_0_TIMER4096[8]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \TIMER4096[8]_i_3 
       (.I0(\n_0_TIMER4096_reg[10] ),
        .O(\n_0_TIMER4096[8]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \TIMER4096[8]_i_4 
       (.I0(\n_0_TIMER4096_reg[9] ),
        .O(\n_0_TIMER4096[8]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \TIMER4096[8]_i_5 
       (.I0(\n_0_TIMER4096_reg[8] ),
        .O(\n_0_TIMER4096[8]_i_5 ));
FDRE TIMER4096_MSB_REG_reg
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_TIMER4096_reg[11] ),
        .Q(TIMER4096_MSB_REG),
        .R(I1));
FDRE \TIMER4096_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_7_TIMER4096_reg[0]_i_1 ),
        .Q(\n_0_TIMER4096_reg[0] ),
        .R(I1));
CARRY4 \TIMER4096_reg[0]_i_1 
       (.CI(1'b0),
        .CO({\n_0_TIMER4096_reg[0]_i_1 ,\n_1_TIMER4096_reg[0]_i_1 ,\n_2_TIMER4096_reg[0]_i_1 ,\n_3_TIMER4096_reg[0]_i_1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\n_4_TIMER4096_reg[0]_i_1 ,\n_5_TIMER4096_reg[0]_i_1 ,\n_6_TIMER4096_reg[0]_i_1 ,\n_7_TIMER4096_reg[0]_i_1 }),
        .S({\n_0_TIMER4096[0]_i_2 ,\n_0_TIMER4096[0]_i_3 ,\n_0_TIMER4096[0]_i_4 ,\n_0_TIMER4096[0]_i_5 }));
FDRE \TIMER4096_reg[10] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_5_TIMER4096_reg[8]_i_1 ),
        .Q(\n_0_TIMER4096_reg[10] ),
        .R(I1));
FDRE \TIMER4096_reg[11] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_4_TIMER4096_reg[8]_i_1 ),
        .Q(\n_0_TIMER4096_reg[11] ),
        .R(I1));
FDRE \TIMER4096_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_6_TIMER4096_reg[0]_i_1 ),
        .Q(\n_0_TIMER4096_reg[1] ),
        .R(I1));
FDRE \TIMER4096_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_5_TIMER4096_reg[0]_i_1 ),
        .Q(\n_0_TIMER4096_reg[2] ),
        .R(I1));
FDRE \TIMER4096_reg[3] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_4_TIMER4096_reg[0]_i_1 ),
        .Q(\n_0_TIMER4096_reg[3] ),
        .R(I1));
FDRE \TIMER4096_reg[4] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_7_TIMER4096_reg[4]_i_1 ),
        .Q(\n_0_TIMER4096_reg[4] ),
        .R(I1));
CARRY4 \TIMER4096_reg[4]_i_1 
       (.CI(\n_0_TIMER4096_reg[0]_i_1 ),
        .CO({\n_0_TIMER4096_reg[4]_i_1 ,\n_1_TIMER4096_reg[4]_i_1 ,\n_2_TIMER4096_reg[4]_i_1 ,\n_3_TIMER4096_reg[4]_i_1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_TIMER4096_reg[4]_i_1 ,\n_5_TIMER4096_reg[4]_i_1 ,\n_6_TIMER4096_reg[4]_i_1 ,\n_7_TIMER4096_reg[4]_i_1 }),
        .S({\n_0_TIMER4096[4]_i_2 ,\n_0_TIMER4096[4]_i_3 ,\n_0_TIMER4096[4]_i_4 ,\n_0_TIMER4096[4]_i_5 }));
FDRE \TIMER4096_reg[5] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_6_TIMER4096_reg[4]_i_1 ),
        .Q(\n_0_TIMER4096_reg[5] ),
        .R(I1));
FDRE \TIMER4096_reg[6] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_5_TIMER4096_reg[4]_i_1 ),
        .Q(\n_0_TIMER4096_reg[6] ),
        .R(I1));
FDRE \TIMER4096_reg[7] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_4_TIMER4096_reg[4]_i_1 ),
        .Q(\n_0_TIMER4096_reg[7] ),
        .R(I1));
FDRE \TIMER4096_reg[8] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_7_TIMER4096_reg[8]_i_1 ),
        .Q(\n_0_TIMER4096_reg[8] ),
        .R(I1));
CARRY4 \TIMER4096_reg[8]_i_1 
       (.CI(\n_0_TIMER4096_reg[4]_i_1 ),
        .CO({\NLW_TIMER4096_reg[8]_i_1_CO_UNCONNECTED [3],\n_1_TIMER4096_reg[8]_i_1 ,\n_2_TIMER4096_reg[8]_i_1 ,\n_3_TIMER4096_reg[8]_i_1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_TIMER4096_reg[8]_i_1 ,\n_5_TIMER4096_reg[8]_i_1 ,\n_6_TIMER4096_reg[8]_i_1 ,\n_7_TIMER4096_reg[8]_i_1 }),
        .S({\n_0_TIMER4096[8]_i_2 ,\n_0_TIMER4096[8]_i_3 ,\n_0_TIMER4096[8]_i_4 ,\n_0_TIMER4096[8]_i_5 }));
FDRE \TIMER4096_reg[9] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_6_TIMER4096_reg[8]_i_1 ),
        .Q(\n_0_TIMER4096_reg[9] ),
        .R(I1));
FDRE TOGGLE_RX_reg
       (.C(CLK),
        .CE(MR_PAGE_RX_SET128_out),
        .D(Q[11]),
        .Q(TOGGLE_RX),
        .R(I1));
LUT6 #(
    .INIT(64'h3A3B3B3BCAC8C8C8)) 
     TOGGLE_TX_i_1
       (.I0(an_adv_config_vector),
        .I1(MR_PAGE_RX_SET128_out),
        .I2(\n_0_STATE_reg[2] ),
        .I3(\n_0_STATE_reg[1] ),
        .I4(n_0_TOGGLE_TX_i_2),
        .I5(TOGGLE_TX),
        .O(n_0_TOGGLE_TX_i_1));
LUT2 #(
    .INIT(4'h1)) 
     TOGGLE_TX_i_2
       (.I0(\n_0_STATE_reg[3] ),
        .I1(\n_0_STATE_reg[0] ),
        .O(n_0_TOGGLE_TX_i_2));
FDRE TOGGLE_TX_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_TOGGLE_TX_i_1),
        .Q(TOGGLE_TX),
        .R(I1));
(* SOFT_HLUTNM = "soft_lutpair4" *) 
   LUT5 #(
    .INIT(32'hEFFE0010)) 
     \TX_CONFIG_REG_INT[0]_i_1 
       (.I0(\n_0_STATE_reg[0] ),
        .I1(\n_0_STATE_reg[3] ),
        .I2(\n_0_STATE_reg[1] ),
        .I3(\n_0_STATE_reg[2] ),
        .I4(D[0]),
        .O(\n_0_TX_CONFIG_REG_INT[0]_i_1 ));
LUT6 #(
    .INIT(64'hFEFFFCFC02000000)) 
     \TX_CONFIG_REG_INT[11]_i_1 
       (.I0(TOGGLE_TX),
        .I1(\n_0_STATE_reg[0] ),
        .I2(\n_0_STATE_reg[3] ),
        .I3(\n_0_STATE_reg[1] ),
        .I4(\n_0_STATE_reg[2] ),
        .I5(D[1]),
        .O(\n_0_TX_CONFIG_REG_INT[11]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair7" *) 
   LUT5 #(
    .INIT(32'hFFAE0020)) 
     \TX_CONFIG_REG_INT[14]_i_1 
       (.I0(\n_0_STATE_reg[0] ),
        .I1(\n_0_STATE_reg[2] ),
        .I2(\n_0_STATE_reg[1] ),
        .I3(\n_0_STATE_reg[3] ),
        .I4(D[2]),
        .O(\n_0_TX_CONFIG_REG_INT[14]_i_1 ));
FDRE \TX_CONFIG_REG_INT_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_TX_CONFIG_REG_INT[0]_i_1 ),
        .Q(D[0]),
        .R(I1));
FDRE \TX_CONFIG_REG_INT_reg[11] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_TX_CONFIG_REG_INT[11]_i_1 ),
        .Q(D[1]),
        .R(I1));
FDRE \TX_CONFIG_REG_INT_reg[14] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_TX_CONFIG_REG_INT[14]_i_1 ),
        .Q(D[2]),
        .R(I1));
(* SOFT_HLUTNM = "soft_lutpair16" *) 
   LUT3 #(
    .INIT(8'h8A)) 
     XMIT_CONFIG_INT_i_1
       (.I0(XMIT_CONFIG_INT),
        .I1(I2[3]),
        .I2(I2[0]),
        .O(XMIT_CONFIG));
LUT4 #(
    .INIT(16'hFFAE)) 
     XMIT_CONFIG_INT_i_1__0
       (.I0(n_0_XMIT_CONFIG_INT_i_2),
        .I1(I2[3]),
        .I2(n_0_XMIT_CONFIG_INT_i_3),
        .I3(I1),
        .O(n_0_XMIT_CONFIG_INT_i_1__0));
LUT6 #(
    .INIT(64'hAA8AA8AAAA8AA8A8)) 
     XMIT_CONFIG_INT_i_2
       (.I0(XMIT_CONFIG_INT),
        .I1(\n_0_STATE_reg[1] ),
        .I2(\n_0_STATE_reg[0] ),
        .I3(\n_0_STATE_reg[3] ),
        .I4(\n_0_STATE_reg[2] ),
        .I5(I2[3]),
        .O(n_0_XMIT_CONFIG_INT_i_2));
(* SOFT_HLUTNM = "soft_lutpair4" *) 
   LUT4 #(
    .INIT(16'hFFFE)) 
     XMIT_CONFIG_INT_i_3
       (.I0(\n_0_STATE_reg[1] ),
        .I1(\n_0_STATE_reg[0] ),
        .I2(\n_0_STATE_reg[3] ),
        .I3(\n_0_STATE_reg[2] ),
        .O(n_0_XMIT_CONFIG_INT_i_3));
FDRE XMIT_CONFIG_INT_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_XMIT_CONFIG_INT_i_1__0),
        .Q(XMIT_CONFIG_INT),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair13" *) 
   LUT3 #(
    .INIT(8'hBA)) 
     XMIT_DATA_INT_i_1
       (.I0(XMIT_DATA_INT),
        .I1(I2[3]),
        .I2(I2[0]),
        .O(XMIT_DATA));
(* SOFT_HLUTNM = "soft_lutpair5" *) 
   LUT4 #(
    .INIT(16'h0810)) 
     XMIT_DATA_INT_i_1__0
       (.I0(\n_0_STATE_reg[2] ),
        .I1(\n_0_STATE_reg[1] ),
        .I2(\n_0_STATE_reg[3] ),
        .I3(\n_0_STATE_reg[0] ),
        .O(XMIT_DATA_INT0));
FDRE XMIT_DATA_INT_reg
       (.C(CLK),
        .CE(1'b1),
        .D(XMIT_DATA_INT0),
        .Q(XMIT_DATA_INT),
        .R(I1));
endmodule

(* ORIG_REF_NAME = "GPCS_PMA_GEN" *) 
module gmii_to_sgmiiGPCS_PMA_GEN
   (SR,
    O1,
    RX_ER,
    status_vector,
    D,
    O2,
    O3,
    O4,
    encommaalign,
    an_interrupt,
    O5,
    Q,
    O6,
    O7,
    O8,
    O9,
    CLK,
    AS,
    I1,
    I2,
    rxnotintable_usr,
    rxbuferr,
    txbuferr,
    rxdisperr_usr,
    an_restart_config,
    I3,
    an_adv_config_vector,
    I4,
    rx_dv_reg1,
    data_out,
    rxcharisk,
    rxchariscomma,
    I5,
    signal_detect,
    configuration_vector,
    I6,
    I7);
  output [0:0]SR;
  output [0:0]O1;
  output RX_ER;
  output [12:0]status_vector;
  output [0:0]D;
  output [0:0]O2;
  output O3;
  output O4;
  output encommaalign;
  output an_interrupt;
  output [0:0]O5;
  output [1:0]Q;
  output O6;
  output [7:0]O7;
  output O8;
  output [7:0]O9;
  input CLK;
  input [0:0]AS;
  input I1;
  input I2;
  input rxnotintable_usr;
  input rxbuferr;
  input txbuferr;
  input rxdisperr_usr;
  input an_restart_config;
  input [1:0]I3;
  input [0:0]an_adv_config_vector;
  input I4;
  input rx_dv_reg1;
  input data_out;
  input rxcharisk;
  input rxchariscomma;
  input [7:0]I5;
  input signal_detect;
  input [4:0]configuration_vector;
  input [7:0]I6;
  input [1:0]I7;

  wire ACKNOWLEDGE_MATCH_2;
  wire ACKNOWLEDGE_MATCH_3;
  wire AN_ENABLE_INT;
  wire [0:0]AS;
  wire CLK;
  wire [0:0]D;
  wire DUPLEX_MODE_RSLVD_REG;
  wire D_1;
  wire EOP_REG1;
  wire I1;
  wire I2;
  wire [1:0]I3;
  wire I4;
  wire [7:0]I5;
  wire [7:0]I6;
  wire [1:0]I7;
  wire K28p5_REG1;
  wire LOOPBACK_INT;
  wire MASK_RUDI_BUFERR_TIMER0;
  wire MGT_RX_RESET_INT;
  wire MGT_TX_RESET_INT;
  wire [0:0]O1;
  wire [0:0]O2;
  wire O3;
  wire O4;
  wire [0:0]O5;
  wire O6;
  wire [7:0]O7;
  wire O8;
  wire [7:0]O9;
  wire [1:0]Q;
  wire Q_0;
  wire RESET_INT;
  wire RESET_INT_PIPE;
  wire RESTART_AN_EN;
  wire RESTART_AN_EN_REG;
  wire RESTART_AN_SET;
  wire RXEVEN;
  wire RXNOTINTABLE_INT;
  wire RXNOTINTABLE_SRL;
  wire RXRUNDISP_INT;
  wire RXSYNC_STATUS;
  wire [14:14]RX_CONFIG_REG;
  wire RX_CONFIG_REG_REG0;
  wire RX_CONFIG_VALID;
  wire RX_ER;
  wire RX_IDLE;
(* RTL_KEEP = "yes" *)   wire [3:0]RX_RST_SM;
  wire RX_RUDI_INVALID;
  wire SIGNAL_DETECT_MOD;
  wire SOP_REG3;
  wire [0:0]SR;
  wire SRESET_PIPE;
  wire STATUS_VECTOR_0_PRE;
  wire STATUS_VECTOR_0_PRE0;
  wire STAT_VEC_DUPLEX_MODE_RSLVD;
  wire SYNC_STATUS_HELD;
  wire SYNC_STATUS_REG;
  wire SYNC_STATUS_REG0;
  wire TXBUFERR_INT;
(* RTL_KEEP = "yes" *)   wire [3:0]TX_RST_SM;
  wire XMIT_CONFIG;
  wire XMIT_DATA;
  wire XMIT_DATA_INT;
  wire [0:0]an_adv_config_vector;
  wire an_interrupt;
  wire an_restart_config;
  wire [4:0]configuration_vector;
  wire data_out;
  wire data_out_2;
  wire encommaalign;
  wire \n_0_FSM_sequential_USE_ROCKET_IO.RX_RST_SM[0]_i_1 ;
  wire \n_0_FSM_sequential_USE_ROCKET_IO.RX_RST_SM[1]_i_1 ;
  wire \n_0_FSM_sequential_USE_ROCKET_IO.RX_RST_SM[2]_i_1 ;
  wire \n_0_FSM_sequential_USE_ROCKET_IO.RX_RST_SM[3]_i_2 ;
  wire \n_0_FSM_sequential_USE_ROCKET_IO.TX_RST_SM[0]_i_1 ;
  wire \n_0_FSM_sequential_USE_ROCKET_IO.TX_RST_SM[1]_i_1 ;
  wire \n_0_FSM_sequential_USE_ROCKET_IO.TX_RST_SM[2]_i_1 ;
  wire \n_0_FSM_sequential_USE_ROCKET_IO.TX_RST_SM[3]_i_2 ;
  wire \n_0_MGT_RESET.SRESET_reg ;
  wire \n_0_NO_MANAGEMENT.CONFIGURATION_VECTOR_REG_reg[0] ;
  wire \n_0_NO_MANAGEMENT.NO_MDIO_HAS_AN.RESTART_AN_EN_i_1 ;
  wire \n_0_USE_ROCKET_IO.NO_1588.RXCHARISCOMMA_INT_reg ;
  wire \n_0_USE_ROCKET_IO.NO_1588.RXCHARISK_INT_reg ;
  wire \n_0_USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT_reg[0] ;
  wire \n_0_USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT_reg[2] ;
  wire \n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[0] ;
  wire \n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[1] ;
  wire \n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[2] ;
  wire \n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[3] ;
  wire \n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[4] ;
  wire \n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[5] ;
  wire \n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[6] ;
  wire \n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[7] ;
  wire n_10_RECEIVER;
  wire n_10_TRANSMITTER;
  wire \n_11_HAS_AUTO_NEG.AUTO_NEGOTIATION ;
  wire n_11_TRANSMITTER;
  wire n_12_TRANSMITTER;
  wire \n_13_HAS_AUTO_NEG.AUTO_NEGOTIATION ;
  wire n_13_TRANSMITTER;
  wire \n_14_HAS_AUTO_NEG.AUTO_NEGOTIATION ;
  wire n_14_TRANSMITTER;
  wire n_15_TRANSMITTER;
  wire n_16_TRANSMITTER;
  wire \n_17_HAS_AUTO_NEG.AUTO_NEGOTIATION ;
  wire n_17_TRANSMITTER;
  wire \n_18_HAS_AUTO_NEG.AUTO_NEGOTIATION ;
  wire n_18_TRANSMITTER;
  wire \n_19_HAS_AUTO_NEG.AUTO_NEGOTIATION ;
  wire n_19_TRANSMITTER;
  wire n_1_TRANSMITTER;
  wire n_20_RECEIVER;
  wire n_20_TRANSMITTER;
  wire \n_21_HAS_AUTO_NEG.AUTO_NEGOTIATION ;
  wire n_21_TRANSMITTER;
  wire \n_22_HAS_AUTO_NEG.AUTO_NEGOTIATION ;
  wire n_22_RECEIVER;
  wire n_22_TRANSMITTER;
  wire \n_23_HAS_AUTO_NEG.AUTO_NEGOTIATION ;
  wire n_23_RECEIVER;
  wire \n_24_HAS_AUTO_NEG.AUTO_NEGOTIATION ;
  wire n_24_RECEIVER;
  wire \n_25_HAS_AUTO_NEG.AUTO_NEGOTIATION ;
  wire n_25_RECEIVER;
  wire \n_26_HAS_AUTO_NEG.AUTO_NEGOTIATION ;
  wire n_26_RECEIVER;
  wire n_27_RECEIVER;
  wire n_28_RECEIVER;
  wire n_29_RECEIVER;
  wire n_2_TRANSMITTER;
  wire n_30_RECEIVER;
  wire n_31_RECEIVER;
  wire n_32_RECEIVER;
  wire n_33_RECEIVER;
  wire n_34_RECEIVER;
  wire n_35_RECEIVER;
  wire n_36_RECEIVER;
  wire n_37_RECEIVER;
  wire n_38_RECEIVER;
  wire n_3_SYNCHRONISATION;
  wire n_3_TRANSMITTER;
  wire n_43_RECEIVER;
  wire n_44_RECEIVER;
  wire n_4_TRANSMITTER;
  wire n_5_TRANSMITTER;
  wire n_6_SYNCHRONISATION;
  wire n_6_TRANSMITTER;
  wire n_7_TRANSMITTER;
  wire \n_8_HAS_AUTO_NEG.AUTO_NEGOTIATION ;
  wire n_8_SYNCHRONISATION;
  wire n_8_TRANSMITTER;
  wire \n_9_HAS_AUTO_NEG.AUTO_NEGOTIATION ;
  wire n_9_RECEIVER;
  wire n_9_SYNCHRONISATION;
  wire n_9_TRANSMITTER;
  wire p_0_in;
  wire p_0_in44_in;
  wire p_0_out;
  wire p_1_out;
  wire rx_dv_reg1;
  wire rxbuferr;
  wire rxchariscomma;
  wire rxcharisk;
  wire rxdisperr_usr;
  wire rxnotintable_usr;
  wire signal_detect;
  wire [12:0]status_vector;
  wire txbuferr;

(* XILINX_LEGACY_PRIM = "SRL16" *) 
   (* box_type = "PRIMITIVE" *) 
   (* srl_name = "\U0/pcs_pma_block_i/gmii_to_sgmii_core/gpcs_pma_inst/DELAY_RXDISPERR " *) 
   SRL16E #(
    .INIT(16'h0000)) 
     DELAY_RXDISPERR
       (.A0(1'b0),
        .A1(1'b0),
        .A2(1'b1),
        .A3(1'b0),
        .CE(1'b1),
        .CLK(CLK),
        .D(D_1),
        .Q(Q_0));
(* XILINX_LEGACY_PRIM = "SRL16" *) 
   (* box_type = "PRIMITIVE" *) 
   (* srl_name = "\U0/pcs_pma_block_i/gmii_to_sgmii_core/gpcs_pma_inst/DELAY_RXNOTINTABLE " *) 
   SRL16E #(
    .INIT(16'h0000)) 
     DELAY_RXNOTINTABLE
       (.A0(1'b0),
        .A1(1'b0),
        .A2(1'b1),
        .A3(1'b0),
        .CE(1'b1),
        .CLK(CLK),
        .D(RXNOTINTABLE_INT),
        .Q(RXNOTINTABLE_SRL));
FDRE #(
    .INIT(1'b0)) 
     DUPLEX_MODE_RSLVD_REG_reg
       (.C(CLK),
        .CE(1'b1),
        .D(STAT_VEC_DUPLEX_MODE_RSLVD),
        .Q(DUPLEX_MODE_RSLVD_REG),
        .R(1'b0));
LUT4 #(
    .INIT(16'h1554)) 
     \FSM_sequential_USE_ROCKET_IO.RX_RST_SM[0]_i_1 
       (.I0(RX_RST_SM[0]),
        .I1(RX_RST_SM[2]),
        .I2(RX_RST_SM[3]),
        .I3(RX_RST_SM[1]),
        .O(\n_0_FSM_sequential_USE_ROCKET_IO.RX_RST_SM[0]_i_1 ));
LUT4 #(
    .INIT(16'h2666)) 
     \FSM_sequential_USE_ROCKET_IO.RX_RST_SM[1]_i_1 
       (.I0(RX_RST_SM[0]),
        .I1(RX_RST_SM[1]),
        .I2(RX_RST_SM[3]),
        .I3(RX_RST_SM[2]),
        .O(\n_0_FSM_sequential_USE_ROCKET_IO.RX_RST_SM[1]_i_1 ));
LUT4 #(
    .INIT(16'h34CC)) 
     \FSM_sequential_USE_ROCKET_IO.RX_RST_SM[2]_i_1 
       (.I0(RX_RST_SM[3]),
        .I1(RX_RST_SM[2]),
        .I2(RX_RST_SM[0]),
        .I3(RX_RST_SM[1]),
        .O(\n_0_FSM_sequential_USE_ROCKET_IO.RX_RST_SM[2]_i_1 ));
LUT2 #(
    .INIT(4'hE)) 
     \FSM_sequential_USE_ROCKET_IO.RX_RST_SM[3]_i_1 
       (.I0(p_0_in),
        .I1(RESET_INT),
        .O(p_0_out));
LUT4 #(
    .INIT(16'h3F80)) 
     \FSM_sequential_USE_ROCKET_IO.RX_RST_SM[3]_i_2 
       (.I0(RX_RST_SM[0]),
        .I1(RX_RST_SM[1]),
        .I2(RX_RST_SM[2]),
        .I3(RX_RST_SM[3]),
        .O(\n_0_FSM_sequential_USE_ROCKET_IO.RX_RST_SM[3]_i_2 ));
(* KEEP = "yes" *) 
   FDSE \FSM_sequential_USE_ROCKET_IO.RX_RST_SM_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_FSM_sequential_USE_ROCKET_IO.RX_RST_SM[0]_i_1 ),
        .Q(RX_RST_SM[0]),
        .S(p_0_out));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_USE_ROCKET_IO.RX_RST_SM_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_FSM_sequential_USE_ROCKET_IO.RX_RST_SM[1]_i_1 ),
        .Q(RX_RST_SM[1]),
        .R(p_0_out));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_USE_ROCKET_IO.RX_RST_SM_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_FSM_sequential_USE_ROCKET_IO.RX_RST_SM[2]_i_1 ),
        .Q(RX_RST_SM[2]),
        .R(p_0_out));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_USE_ROCKET_IO.RX_RST_SM_reg[3] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_FSM_sequential_USE_ROCKET_IO.RX_RST_SM[3]_i_2 ),
        .Q(RX_RST_SM[3]),
        .R(p_0_out));
LUT4 #(
    .INIT(16'h1554)) 
     \FSM_sequential_USE_ROCKET_IO.TX_RST_SM[0]_i_1 
       (.I0(TX_RST_SM[0]),
        .I1(TX_RST_SM[2]),
        .I2(TX_RST_SM[3]),
        .I3(TX_RST_SM[1]),
        .O(\n_0_FSM_sequential_USE_ROCKET_IO.TX_RST_SM[0]_i_1 ));
LUT4 #(
    .INIT(16'h2666)) 
     \FSM_sequential_USE_ROCKET_IO.TX_RST_SM[1]_i_1 
       (.I0(TX_RST_SM[0]),
        .I1(TX_RST_SM[1]),
        .I2(TX_RST_SM[3]),
        .I3(TX_RST_SM[2]),
        .O(\n_0_FSM_sequential_USE_ROCKET_IO.TX_RST_SM[1]_i_1 ));
LUT4 #(
    .INIT(16'h34CC)) 
     \FSM_sequential_USE_ROCKET_IO.TX_RST_SM[2]_i_1 
       (.I0(TX_RST_SM[3]),
        .I1(TX_RST_SM[2]),
        .I2(TX_RST_SM[0]),
        .I3(TX_RST_SM[1]),
        .O(\n_0_FSM_sequential_USE_ROCKET_IO.TX_RST_SM[2]_i_1 ));
LUT2 #(
    .INIT(4'hE)) 
     \FSM_sequential_USE_ROCKET_IO.TX_RST_SM[3]_i_1 
       (.I0(RESET_INT),
        .I1(TXBUFERR_INT),
        .O(p_1_out));
LUT4 #(
    .INIT(16'h3F80)) 
     \FSM_sequential_USE_ROCKET_IO.TX_RST_SM[3]_i_2 
       (.I0(TX_RST_SM[0]),
        .I1(TX_RST_SM[1]),
        .I2(TX_RST_SM[2]),
        .I3(TX_RST_SM[3]),
        .O(\n_0_FSM_sequential_USE_ROCKET_IO.TX_RST_SM[3]_i_2 ));
(* KEEP = "yes" *) 
   FDSE \FSM_sequential_USE_ROCKET_IO.TX_RST_SM_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_FSM_sequential_USE_ROCKET_IO.TX_RST_SM[0]_i_1 ),
        .Q(TX_RST_SM[0]),
        .S(p_1_out));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_USE_ROCKET_IO.TX_RST_SM_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_FSM_sequential_USE_ROCKET_IO.TX_RST_SM[1]_i_1 ),
        .Q(TX_RST_SM[1]),
        .R(p_1_out));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_USE_ROCKET_IO.TX_RST_SM_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_FSM_sequential_USE_ROCKET_IO.TX_RST_SM[2]_i_1 ),
        .Q(TX_RST_SM[2]),
        .R(p_1_out));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_USE_ROCKET_IO.TX_RST_SM_reg[3] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_FSM_sequential_USE_ROCKET_IO.TX_RST_SM[3]_i_2 ),
        .Q(TX_RST_SM[3]),
        .R(p_1_out));
gmii_to_sgmiiAUTO_NEG__parameterized0 \HAS_AUTO_NEG.AUTO_NEGOTIATION 
       (.ACKNOWLEDGE_MATCH_2(ACKNOWLEDGE_MATCH_2),
        .ACKNOWLEDGE_MATCH_3(ACKNOWLEDGE_MATCH_3),
        .CLK(CLK),
        .D({\n_21_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_22_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_23_HAS_AUTO_NEG.AUTO_NEGOTIATION }),
        .EOP_REG1(EOP_REG1),
        .I1(\n_0_MGT_RESET.SRESET_reg ),
        .I10({\n_0_USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT_reg[2] ,\n_0_USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT_reg[0] }),
        .I11(n_44_RECEIVER),
        .I12(n_10_RECEIVER),
        .I13(data_out),
        .I2({AN_ENABLE_INT,Q,\n_0_NO_MANAGEMENT.CONFIGURATION_VECTOR_REG_reg[0] }),
        .I3(n_3_SYNCHRONISATION),
        .I4(n_36_RECEIVER),
        .I5(n_38_RECEIVER),
        .I6(n_37_RECEIVER),
        .I7(SR),
        .I8(n_9_SYNCHRONISATION),
        .I9(O4),
        .MASK_RUDI_BUFERR_TIMER0(MASK_RUDI_BUFERR_TIMER0),
        .O1(\n_8_HAS_AUTO_NEG.AUTO_NEGOTIATION ),
        .O2(\n_9_HAS_AUTO_NEG.AUTO_NEGOTIATION ),
        .O3(\n_11_HAS_AUTO_NEG.AUTO_NEGOTIATION ),
        .O4(\n_13_HAS_AUTO_NEG.AUTO_NEGOTIATION ),
        .O5(\n_14_HAS_AUTO_NEG.AUTO_NEGOTIATION ),
        .O6({p_0_in44_in,\n_17_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_18_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_19_HAS_AUTO_NEG.AUTO_NEGOTIATION }),
        .O7({\n_24_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_25_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_26_HAS_AUTO_NEG.AUTO_NEGOTIATION }),
        .Q({n_20_RECEIVER,RX_CONFIG_REG,n_22_RECEIVER,n_23_RECEIVER,n_24_RECEIVER,n_25_RECEIVER,n_26_RECEIVER,n_27_RECEIVER,n_28_RECEIVER,n_29_RECEIVER,n_30_RECEIVER,n_31_RECEIVER,n_32_RECEIVER,n_33_RECEIVER,n_34_RECEIVER,n_35_RECEIVER}),
        .RESTART_AN_SET(RESTART_AN_SET),
        .RXSYNC_STATUS(RXSYNC_STATUS),
        .RX_CONFIG_VALID(RX_CONFIG_VALID),
        .RX_IDLE(RX_IDLE),
        .RX_RUDI_INVALID(RX_RUDI_INVALID),
        .S(n_43_RECEIVER),
        .SOP_REG3(SOP_REG3),
        .SR(RX_CONFIG_REG_REG0),
        .STAT_VEC_DUPLEX_MODE_RSLVD(STAT_VEC_DUPLEX_MODE_RSLVD),
        .SYNC_STATUS_HELD(SYNC_STATUS_HELD),
        .XMIT_CONFIG(XMIT_CONFIG),
        .XMIT_DATA(XMIT_DATA),
        .XMIT_DATA_INT(XMIT_DATA_INT),
        .an_adv_config_vector(an_adv_config_vector),
        .an_interrupt(an_interrupt),
        .data_out(data_out_2),
        .p_0_in(p_0_in),
        .status_vector({status_vector[12],status_vector[10:7],status_vector[4]}));
(* ASYNC_REG *) 
   FDPE #(
    .INIT(1'b0)) 
     \MGT_RESET.RESET_INT_PIPE_reg 
       (.C(CLK),
        .CE(1'b1),
        .D(1'b0),
        .PRE(AS),
        .Q(RESET_INT_PIPE));
(* ASYNC_REG *) 
   FDPE #(
    .INIT(1'b0)) 
     \MGT_RESET.RESET_INT_reg 
       (.C(CLK),
        .CE(1'b1),
        .D(RESET_INT_PIPE),
        .PRE(AS),
        .Q(RESET_INT));
(* ASYNC_REG *) 
   FDRE #(
    .INIT(1'b0)) 
     \MGT_RESET.SRESET_PIPE_reg 
       (.C(CLK),
        .CE(1'b1),
        .D(RESET_INT),
        .Q(SRESET_PIPE),
        .R(1'b0));
(* ASYNC_REG *) 
   FDSE #(
    .INIT(1'b0)) 
     \MGT_RESET.SRESET_reg 
       (.C(CLK),
        .CE(1'b1),
        .D(SRESET_PIPE),
        .Q(\n_0_MGT_RESET.SRESET_reg ),
        .S(RESET_INT));
FDRE #(
    .INIT(1'b0)) 
     \NO_MANAGEMENT.CONFIGURATION_VECTOR_REG_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(configuration_vector[0]),
        .Q(\n_0_NO_MANAGEMENT.CONFIGURATION_VECTOR_REG_reg[0] ),
        .R(\n_0_MGT_RESET.SRESET_reg ));
FDRE #(
    .INIT(1'b0)) 
     \NO_MANAGEMENT.CONFIGURATION_VECTOR_REG_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(configuration_vector[1]),
        .Q(LOOPBACK_INT),
        .R(\n_0_MGT_RESET.SRESET_reg ));
FDRE #(
    .INIT(1'b0)) 
     \NO_MANAGEMENT.CONFIGURATION_VECTOR_REG_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .D(configuration_vector[2]),
        .Q(Q[0]),
        .R(\n_0_MGT_RESET.SRESET_reg ));
FDRE #(
    .INIT(1'b0)) 
     \NO_MANAGEMENT.CONFIGURATION_VECTOR_REG_reg[3] 
       (.C(CLK),
        .CE(1'b1),
        .D(configuration_vector[3]),
        .Q(Q[1]),
        .R(\n_0_MGT_RESET.SRESET_reg ));
FDRE #(
    .INIT(1'b0)) 
     \NO_MANAGEMENT.CONFIGURATION_VECTOR_REG_reg[4] 
       (.C(CLK),
        .CE(1'b1),
        .D(configuration_vector[4]),
        .Q(AN_ENABLE_INT),
        .R(\n_0_MGT_RESET.SRESET_reg ));
FDRE #(
    .INIT(1'b0)) 
     \NO_MANAGEMENT.NO_MDIO_HAS_AN.RESTART_AN_EN_REG_reg 
       (.C(CLK),
        .CE(1'b1),
        .D(an_restart_config),
        .Q(RESTART_AN_EN_REG),
        .R(\n_0_MGT_RESET.SRESET_reg ));
LUT2 #(
    .INIT(4'h2)) 
     \NO_MANAGEMENT.NO_MDIO_HAS_AN.RESTART_AN_EN_i_1 
       (.I0(an_restart_config),
        .I1(RESTART_AN_EN_REG),
        .O(\n_0_NO_MANAGEMENT.NO_MDIO_HAS_AN.RESTART_AN_EN_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \NO_MANAGEMENT.NO_MDIO_HAS_AN.RESTART_AN_EN_reg 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_NO_MANAGEMENT.NO_MDIO_HAS_AN.RESTART_AN_EN_i_1 ),
        .Q(RESTART_AN_EN),
        .R(\n_0_MGT_RESET.SRESET_reg ));
FDRE #(
    .INIT(1'b0)) 
     \NO_MANAGEMENT.NO_MDIO_HAS_AN.RESTART_AN_SET_reg 
       (.C(CLK),
        .CE(1'b1),
        .D(RESTART_AN_EN),
        .Q(RESTART_AN_SET),
        .R(\n_0_MGT_RESET.SRESET_reg ));
gmii_to_sgmiiRX__parameterized0 RECEIVER
       (.ACKNOWLEDGE_MATCH_2(ACKNOWLEDGE_MATCH_2),
        .ACKNOWLEDGE_MATCH_3(ACKNOWLEDGE_MATCH_3),
        .CLK(CLK),
        .D_1(D_1),
        .EOP_REG1(EOP_REG1),
        .I1(SR),
        .I10({p_0_in44_in,\n_17_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_18_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_19_HAS_AUTO_NEG.AUTO_NEGOTIATION }),
        .I11(\n_13_HAS_AUTO_NEG.AUTO_NEGOTIATION ),
        .I12({AN_ENABLE_INT,Q,\n_0_NO_MANAGEMENT.CONFIGURATION_VECTOR_REG_reg[0] }),
        .I13(\n_8_HAS_AUTO_NEG.AUTO_NEGOTIATION ),
        .I14({\n_24_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_25_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_26_HAS_AUTO_NEG.AUTO_NEGOTIATION }),
        .I15(n_8_SYNCHRONISATION),
        .I2(\n_0_USE_ROCKET_IO.NO_1588.RXCHARISK_INT_reg ),
        .I3(\n_14_HAS_AUTO_NEG.AUTO_NEGOTIATION ),
        .I4({\n_0_USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT_reg[2] ,\n_0_USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT_reg[0] }),
        .I5(I3),
        .I6(\n_0_MGT_RESET.SRESET_reg ),
        .I7(n_6_SYNCHRONISATION),
        .I8(\n_9_HAS_AUTO_NEG.AUTO_NEGOTIATION ),
        .I9(\n_11_HAS_AUTO_NEG.AUTO_NEGOTIATION ),
        .K28p5_REG1(K28p5_REG1),
        .O1(n_9_RECEIVER),
        .O10(O8),
        .O11(n_44_RECEIVER),
        .O2(n_10_RECEIVER),
        .O3({n_20_RECEIVER,RX_CONFIG_REG,n_22_RECEIVER,n_23_RECEIVER,n_24_RECEIVER,n_25_RECEIVER,n_26_RECEIVER,n_27_RECEIVER,n_28_RECEIVER,n_29_RECEIVER,n_30_RECEIVER,n_31_RECEIVER,n_32_RECEIVER,n_33_RECEIVER,n_34_RECEIVER,n_35_RECEIVER}),
        .O4(O4),
        .O5(n_36_RECEIVER),
        .O6(O6),
        .O7(O7),
        .O8(n_37_RECEIVER),
        .O9(n_38_RECEIVER),
        .Q({\n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[7] ,\n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[6] ,\n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[5] ,\n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[4] ,\n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[3] ,\n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[2] ,\n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[1] ,\n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[0] }),
        .RXEVEN(RXEVEN),
        .RXNOTINTABLE_INT(RXNOTINTABLE_INT),
        .RXSYNC_STATUS(RXSYNC_STATUS),
        .RX_CONFIG_VALID(RX_CONFIG_VALID),
        .RX_ER(RX_ER),
        .RX_IDLE(RX_IDLE),
        .RX_RUDI_INVALID(RX_RUDI_INVALID),
        .S(n_43_RECEIVER),
        .SOP_REG3(SOP_REG3),
        .SR(RX_CONFIG_REG_REG0),
        .SYNC_STATUS_REG0(SYNC_STATUS_REG0),
        .XMIT_DATA(XMIT_DATA),
        .XMIT_DATA_INT(XMIT_DATA_INT),
        .p_0_in(p_0_in),
        .rx_dv_reg1(rx_dv_reg1),
        .status_vector(status_vector[3:2]));
FDRE #(
    .INIT(1'b0)) 
     RXDISPERR_REG_reg
       (.C(CLK),
        .CE(1'b1),
        .D(Q_0),
        .Q(status_vector[5]),
        .R(1'b0));
FDRE #(
    .INIT(1'b0)) 
     RXNOTINTABLE_REG_reg
       (.C(CLK),
        .CE(1'b1),
        .D(RXNOTINTABLE_SRL),
        .Q(status_vector[6]),
        .R(1'b0));
FDRE #(
    .INIT(1'b0)) 
     STATUS_VECTOR_0_PRE_reg
       (.C(CLK),
        .CE(1'b1),
        .D(STATUS_VECTOR_0_PRE0),
        .Q(STATUS_VECTOR_0_PRE),
        .R(1'b0));
FDRE \STATUS_VECTOR_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(STATUS_VECTOR_0_PRE),
        .Q(status_vector[0]),
        .R(1'b0));
FDRE \STATUS_VECTOR_reg[12] 
       (.C(CLK),
        .CE(1'b1),
        .D(DUPLEX_MODE_RSLVD_REG),
        .Q(status_vector[11]),
        .R(1'b0));
FDRE \STATUS_VECTOR_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(SYNC_STATUS_REG),
        .Q(status_vector[1]),
        .R(1'b0));
gmii_to_sgmiiSYNCHRONISE SYNCHRONISATION
       (.CLK(CLK),
        .D_1(D_1),
        .I1(SR),
        .I2(\n_0_USE_ROCKET_IO.NO_1588.RXCHARISCOMMA_INT_reg ),
        .I3(\n_0_MGT_RESET.SRESET_reg ),
        .I4(n_10_RECEIVER),
        .I5(\n_0_USE_ROCKET_IO.NO_1588.RXCHARISK_INT_reg ),
        .I6(n_9_RECEIVER),
        .K28p5_REG1(K28p5_REG1),
        .O1(n_3_SYNCHRONISATION),
        .O2(n_6_SYNCHRONISATION),
        .O3(n_8_SYNCHRONISATION),
        .O4(n_9_SYNCHRONISATION),
        .Q({AN_ENABLE_INT,LOOPBACK_INT,\n_0_NO_MANAGEMENT.CONFIGURATION_VECTOR_REG_reg[0] }),
        .RXEVEN(RXEVEN),
        .RXNOTINTABLE_INT(RXNOTINTABLE_INT),
        .RXSYNC_STATUS(RXSYNC_STATUS),
        .SIGNAL_DETECT_MOD(SIGNAL_DETECT_MOD),
        .STATUS_VECTOR_0_PRE0(STATUS_VECTOR_0_PRE0),
        .SYNC_STATUS_HELD(SYNC_STATUS_HELD),
        .SYNC_STATUS_REG0(SYNC_STATUS_REG0),
        .XMIT_DATA_INT(XMIT_DATA_INT),
        .data_out(data_out),
        .encommaalign(encommaalign),
        .p_0_in(p_0_in));
gmii_to_sgmiisync_block__parameterized0 SYNC_SIGNAL_DETECT
       (.CLK(CLK),
        .MASK_RUDI_BUFERR_TIMER0(MASK_RUDI_BUFERR_TIMER0),
        .Q(Q[0]),
        .SIGNAL_DETECT_MOD(SIGNAL_DETECT_MOD),
        .data_out(data_out_2),
        .p_0_in(p_0_in),
        .signal_detect(signal_detect));
FDRE #(
    .INIT(1'b0)) 
     SYNC_STATUS_REG_reg
       (.C(CLK),
        .CE(1'b1),
        .D(RXSYNC_STATUS),
        .Q(SYNC_STATUS_REG),
        .R(1'b0));
gmii_to_sgmiiTX__parameterized0 TRANSMITTER
       (.CLK(CLK),
        .D({n_1_TRANSMITTER,n_2_TRANSMITTER,n_3_TRANSMITTER,n_4_TRANSMITTER}),
        .I1(O1),
        .I2(I1),
        .I3(I2),
        .I4(I4),
        .I5(I5),
        .I6({\n_21_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_22_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_23_HAS_AUTO_NEG.AUTO_NEGOTIATION }),
        .I7(I6),
        .O1(O3),
        .O10(n_13_TRANSMITTER),
        .O11({n_14_TRANSMITTER,n_15_TRANSMITTER,n_16_TRANSMITTER,n_17_TRANSMITTER,n_18_TRANSMITTER,n_19_TRANSMITTER,n_20_TRANSMITTER,n_21_TRANSMITTER}),
        .O12(n_22_TRANSMITTER),
        .O2(n_5_TRANSMITTER),
        .O3(n_6_TRANSMITTER),
        .O4(n_7_TRANSMITTER),
        .O5(n_8_TRANSMITTER),
        .O6(n_9_TRANSMITTER),
        .O7(n_10_TRANSMITTER),
        .O8(n_11_TRANSMITTER),
        .O9(n_12_TRANSMITTER),
        .Q({Q[1],LOOPBACK_INT}),
        .XMIT_CONFIG(XMIT_CONFIG),
        .XMIT_DATA(XMIT_DATA),
        .rxchariscomma(rxchariscomma),
        .rxcharisk(rxcharisk));
LUT4 #(
    .INIT(16'h7FFE)) 
     \USE_ROCKET_IO.MGT_RX_RESET_INT_i_1 
       (.I0(RX_RST_SM[0]),
        .I1(RX_RST_SM[1]),
        .I2(RX_RST_SM[2]),
        .I3(RX_RST_SM[3]),
        .O(MGT_RX_RESET_INT));
FDSE #(
    .INIT(1'b0)) 
     \USE_ROCKET_IO.MGT_RX_RESET_INT_reg 
       (.C(CLK),
        .CE(1'b1),
        .D(MGT_RX_RESET_INT),
        .Q(SR),
        .S(p_0_out));
LUT4 #(
    .INIT(16'h7FFE)) 
     \USE_ROCKET_IO.MGT_TX_RESET_INT_i_1 
       (.I0(TX_RST_SM[0]),
        .I1(TX_RST_SM[1]),
        .I2(TX_RST_SM[2]),
        .I3(TX_RST_SM[3]),
        .O(MGT_TX_RESET_INT));
FDSE #(
    .INIT(1'b0)) 
     \USE_ROCKET_IO.MGT_TX_RESET_INT_reg 
       (.C(CLK),
        .CE(1'b1),
        .D(MGT_TX_RESET_INT),
        .Q(O1),
        .S(p_1_out));
FDRE #(
    .INIT(1'b0)) 
     \USE_ROCKET_IO.NO_1588.RXBUFSTATUS_INT_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(rxbuferr),
        .Q(p_0_in),
        .R(RXRUNDISP_INT));
FDRE #(
    .INIT(1'b0)) 
     \USE_ROCKET_IO.NO_1588.RXCHARISCOMMA_INT_reg 
       (.C(CLK),
        .CE(1'b1),
        .D(n_13_TRANSMITTER),
        .Q(\n_0_USE_ROCKET_IO.NO_1588.RXCHARISCOMMA_INT_reg ),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \USE_ROCKET_IO.NO_1588.RXCHARISK_INT_reg 
       (.C(CLK),
        .CE(1'b1),
        .D(n_12_TRANSMITTER),
        .Q(\n_0_USE_ROCKET_IO.NO_1588.RXCHARISK_INT_reg ),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(I7[0]),
        .Q(\n_0_USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT_reg[0] ),
        .R(RXRUNDISP_INT));
FDRE #(
    .INIT(1'b0)) 
     \USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .D(I7[1]),
        .Q(\n_0_USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT_reg[2] ),
        .R(RXRUNDISP_INT));
FDRE #(
    .INIT(1'b0)) 
     \USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(n_21_TRANSMITTER),
        .Q(\n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[0] ),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(n_20_TRANSMITTER),
        .Q(\n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[1] ),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .D(n_19_TRANSMITTER),
        .Q(\n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[2] ),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[3] 
       (.C(CLK),
        .CE(1'b1),
        .D(n_18_TRANSMITTER),
        .Q(\n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[3] ),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[4] 
       (.C(CLK),
        .CE(1'b1),
        .D(n_17_TRANSMITTER),
        .Q(\n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[4] ),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[5] 
       (.C(CLK),
        .CE(1'b1),
        .D(n_16_TRANSMITTER),
        .Q(\n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[5] ),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[6] 
       (.C(CLK),
        .CE(1'b1),
        .D(n_15_TRANSMITTER),
        .Q(\n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[6] ),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[7] 
       (.C(CLK),
        .CE(1'b1),
        .D(n_14_TRANSMITTER),
        .Q(\n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[7] ),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \USE_ROCKET_IO.NO_1588.RXDISPERR_INT_reg 
       (.C(CLK),
        .CE(1'b1),
        .D(rxdisperr_usr),
        .Q(D_1),
        .R(RXRUNDISP_INT));
LUT2 #(
    .INIT(4'hE)) 
     \USE_ROCKET_IO.NO_1588.RXNOTINTABLE_INT_i_1 
       (.I0(LOOPBACK_INT),
        .I1(SR),
        .O(RXRUNDISP_INT));
FDRE #(
    .INIT(1'b0)) 
     \USE_ROCKET_IO.NO_1588.RXNOTINTABLE_INT_reg 
       (.C(CLK),
        .CE(1'b1),
        .D(rxnotintable_usr),
        .Q(RXNOTINTABLE_INT),
        .R(RXRUNDISP_INT));
FDRE #(
    .INIT(1'b0)) 
     \USE_ROCKET_IO.TXBUFERR_INT_reg 
       (.C(CLK),
        .CE(1'b1),
        .D(txbuferr),
        .Q(TXBUFERR_INT),
        .R(O1));
FDRE \USE_ROCKET_IO.TXCHARDISPMODE_reg 
       (.C(CLK),
        .CE(1'b1),
        .D(n_6_TRANSMITTER),
        .Q(D),
        .R(O1));
FDRE \USE_ROCKET_IO.TXCHARDISPVAL_reg 
       (.C(CLK),
        .CE(1'b1),
        .D(n_5_TRANSMITTER),
        .Q(O5),
        .R(1'b0));
FDRE \USE_ROCKET_IO.TXCHARISK_reg 
       (.C(CLK),
        .CE(1'b1),
        .D(n_11_TRANSMITTER),
        .Q(O2),
        .R(O1));
FDRE \USE_ROCKET_IO.TXDATA_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(n_4_TRANSMITTER),
        .Q(O9[0]),
        .R(1'b0));
FDRE \USE_ROCKET_IO.TXDATA_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(n_3_TRANSMITTER),
        .Q(O9[1]),
        .R(1'b0));
FDSE \USE_ROCKET_IO.TXDATA_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .D(n_10_TRANSMITTER),
        .Q(O9[2]),
        .S(n_22_TRANSMITTER));
FDSE \USE_ROCKET_IO.TXDATA_reg[3] 
       (.C(CLK),
        .CE(1'b1),
        .D(n_9_TRANSMITTER),
        .Q(O9[3]),
        .S(n_22_TRANSMITTER));
FDRE \USE_ROCKET_IO.TXDATA_reg[4] 
       (.C(CLK),
        .CE(1'b1),
        .D(n_2_TRANSMITTER),
        .Q(O9[4]),
        .R(1'b0));
FDSE \USE_ROCKET_IO.TXDATA_reg[5] 
       (.C(CLK),
        .CE(1'b1),
        .D(n_8_TRANSMITTER),
        .Q(O9[5]),
        .S(n_22_TRANSMITTER));
FDRE \USE_ROCKET_IO.TXDATA_reg[6] 
       (.C(CLK),
        .CE(1'b1),
        .D(n_1_TRANSMITTER),
        .Q(O9[6]),
        .R(1'b0));
FDSE \USE_ROCKET_IO.TXDATA_reg[7] 
       (.C(CLK),
        .CE(1'b1),
        .D(n_7_TRANSMITTER),
        .Q(O9[7]),
        .S(n_22_TRANSMITTER));
endmodule

(* ORIG_REF_NAME = "RX" *) 
module gmii_to_sgmiiRX__parameterized0
   (SOP_REG3,
    RX_ER,
    K28p5_REG1,
    RX_IDLE,
    EOP_REG1,
    RX_CONFIG_VALID,
    status_vector,
    O4,
    O1,
    O2,
    O6,
    O7,
    O3,
    O5,
    O8,
    O9,
    ACKNOWLEDGE_MATCH_3,
    O10,
    RX_RUDI_INVALID,
    SR,
    S,
    O11,
    Q,
    CLK,
    SYNC_STATUS_REG0,
    I1,
    I2,
    I3,
    I4,
    I5,
    I6,
    I7,
    RXEVEN,
    RXSYNC_STATUS,
    I8,
    I9,
    ACKNOWLEDGE_MATCH_2,
    I10,
    rx_dv_reg1,
    RXNOTINTABLE_INT,
    D_1,
    p_0_in,
    I11,
    XMIT_DATA_INT,
    I12,
    XMIT_DATA,
    I13,
    I14,
    I15);
  output SOP_REG3;
  output RX_ER;
  output K28p5_REG1;
  output RX_IDLE;
  output EOP_REG1;
  output RX_CONFIG_VALID;
  output [1:0]status_vector;
  output O4;
  output O1;
  output O2;
  output O6;
  output [7:0]O7;
  output [15:0]O3;
  output O5;
  output O8;
  output O9;
  output ACKNOWLEDGE_MATCH_3;
  output O10;
  output RX_RUDI_INVALID;
  output [0:0]SR;
  output [0:0]S;
  output [0:0]O11;
  input [7:0]Q;
  input CLK;
  input SYNC_STATUS_REG0;
  input I1;
  input I2;
  input I3;
  input [1:0]I4;
  input [1:0]I5;
  input I6;
  input I7;
  input RXEVEN;
  input RXSYNC_STATUS;
  input I8;
  input I9;
  input ACKNOWLEDGE_MATCH_2;
  input [3:0]I10;
  input rx_dv_reg1;
  input RXNOTINTABLE_INT;
  input D_1;
  input p_0_in;
  input I11;
  input XMIT_DATA_INT;
  input [3:0]I12;
  input XMIT_DATA;
  input I13;
  input [2:0]I14;
  input I15;

  wire ACKNOWLEDGE_MATCH_2;
  wire ACKNOWLEDGE_MATCH_3;
  wire C;
  wire C0;
  wire CGBAD;
  wire CGBAD_REG1;
  wire CGBAD_REG2;
  wire CGBAD_REG3;
  wire CLK;
  wire C_HDR_REMOVED;
  wire C_HDR_REMOVED_REG;
  wire C_REG1;
  wire C_REG2;
  wire C_REG3;
  wire D0p0;
  wire D0p0_REG;
  wire D_1;
  wire EOP;
  wire EOP0;
  wire EOP_REG1;
  wire EOP_REG10;
  wire EXTEND_ERR;
  wire EXTEND_ERR0;
  wire EXTEND_REG1;
  wire EXTEND_REG2;
  wire EXTEND_REG3;
  wire EXT_ILLEGAL_K;
  wire EXT_ILLEGAL_K0;
  wire EXT_ILLEGAL_K_REG1;
  wire EXT_ILLEGAL_K_REG2;
  wire FALSE_CARRIER;
  wire FALSE_CARRIER_REG1;
  wire FALSE_CARRIER_REG2;
  wire FALSE_CARRIER_REG3;
  wire FALSE_DATA;
  wire FALSE_DATA0;
  wire FALSE_K;
  wire FALSE_K0;
  wire FALSE_NIT;
  wire FALSE_NIT0;
  wire FROM_IDLE_D;
  wire FROM_IDLE_D0;
  wire FROM_RX_CX;
  wire FROM_RX_CX0;
  wire FROM_RX_K;
  wire FROM_RX_K0;
  wire I;
  wire I0;
  wire I1;
  wire [3:0]I10;
  wire I11;
  wire [3:0]I12;
  wire I13;
  wire [2:0]I14;
  wire I15;
  wire I2;
  wire I3;
  wire [1:0]I4;
  wire [1:0]I5;
  wire I6;
  wire I7;
  wire I8;
  wire I9;
  wire ILLEGAL_K;
  wire ILLEGAL_K0;
  wire ILLEGAL_K_REG1;
  wire ILLEGAL_K_REG2;
  wire K23p7;
  wire K28p5;
  wire K28p5_REG1;
  wire K28p5_REG2;
  wire K29p7;
  wire O1;
  wire O10;
  wire [0:0]O11;
  wire O2;
  wire [15:0]O3;
  wire O4;
  wire O5;
  wire O6;
  wire [7:0]O7;
  wire O8;
  wire O9;
  wire [7:0]Q;
  wire R;
  wire RUDI_C0;
  wire RUDI_I0;
  wire RXCHARISK_REG1;
  wire [7:0]RXDATA_REG5;
  wire RXEVEN;
  wire RXNOTINTABLE_INT;
  wire RXSYNC_STATUS;
  wire RX_CONFIG_VALID;
  wire RX_CONFIG_VALID_INT0;
  wire RX_DATA_ERROR;
  wire RX_DATA_ERROR0;
  wire RX_ER;
  wire RX_ER0;
  wire RX_IDLE;
  wire RX_RUDI_INVALID;
  wire R_REG1;
  wire [0:0]S;
  wire S0;
  wire S2;
  wire SOP;
  wire SOP0;
  wire SOP_REG1;
  wire SOP_REG2;
  wire SOP_REG3;
  wire [0:0]SR;
  wire SYNC_STATUS_REG;
  wire SYNC_STATUS_REG0;
  wire S_0;
  wire T;
  wire T_REG1;
  wire T_REG2;
  wire WAIT_FOR_K;
  wire XMIT_DATA;
  wire XMIT_DATA_INT;
  wire n_0_D0p0_REG_i_2;
  wire n_0_EOP_i_2;
  wire n_0_EXTEND_i_1;
  wire n_0_EXTEND_i_3;
  wire n_0_EXTEND_reg;
  wire n_0_FALSE_CARRIER_i_1;
  wire n_0_FALSE_CARRIER_i_2;
  wire n_0_FALSE_CARRIER_i_3;
  wire n_0_FALSE_DATA_i_2;
  wire n_0_FALSE_DATA_i_3;
  wire n_0_FALSE_DATA_i_4;
  wire n_0_FALSE_DATA_i_5;
  wire n_0_FALSE_K_i_2;
  wire n_0_FALSE_NIT_i_2;
  wire n_0_FALSE_NIT_i_3;
  wire n_0_FALSE_NIT_i_4;
  wire n_0_FALSE_NIT_i_5;
  wire n_0_FALSE_NIT_i_6;
  wire n_0_FALSE_NIT_i_7;
  wire \n_0_IDLE_REG_reg[0] ;
  wire \n_0_IDLE_REG_reg[2] ;
  wire n_0_I_i_2;
  wire n_0_I_i_3;
  wire n_0_I_i_4;
  wire n_0_I_i_5;
  wire n_0_RECEIVE_i_1;
  wire \n_0_RXDATA_REG4_reg[0]_srl4 ;
  wire \n_0_RXDATA_REG4_reg[1]_srl4 ;
  wire \n_0_RXDATA_REG4_reg[2]_srl4 ;
  wire \n_0_RXDATA_REG4_reg[3]_srl4 ;
  wire \n_0_RXDATA_REG4_reg[4]_srl4 ;
  wire \n_0_RXDATA_REG4_reg[5]_srl4 ;
  wire \n_0_RXDATA_REG4_reg[6]_srl4 ;
  wire \n_0_RXDATA_REG4_reg[7]_srl4 ;
  wire \n_0_RXD[0]_i_1 ;
  wire \n_0_RXD[1]_i_1 ;
  wire \n_0_RXD[2]_i_1 ;
  wire \n_0_RXD[3]_i_1 ;
  wire \n_0_RXD[4]_i_1 ;
  wire \n_0_RXD[5]_i_1 ;
  wire \n_0_RXD[6]_i_1 ;
  wire \n_0_RXD[7]_i_1 ;
  wire \n_0_RX_CONFIG_REG[7]_i_1 ;
  wire n_0_RX_CONFIG_REG_NULL_i_2;
  wire n_0_RX_CONFIG_REG_NULL_i_3;
  wire n_0_RX_CONFIG_REG_NULL_i_4;
  wire n_0_RX_CONFIG_VALID_INT_i_2;
  wire \n_0_RX_CONFIG_VALID_REG_reg[0] ;
  wire \n_0_RX_CONFIG_VALID_REG_reg[3] ;
  wire n_0_RX_DATA_ERROR_i_2;
  wire n_0_RX_DATA_ERROR_i_4;
  wire n_0_RX_ER_i_2;
  wire n_0_RX_ER_i_3;
  wire n_0_RX_INVALID_i_1;
  wire n_0_RX_INVALID_i_2;
  wire n_0_R_i_2;
  wire n_0_S_i_2;
  wire n_0_WAIT_FOR_K_i_1;
  wire p_0_in;
  wire p_0_in1_in;
  wire p_0_in2_in;
  wire [11:11]p_0_out;
  wire p_1_in;
  wire rx_dv_reg1;
  wire [1:0]status_vector;

(* SOFT_HLUTNM = "soft_lutpair27" *) 
   LUT3 #(
    .INIT(8'hFE)) 
     ABILITY_MATCH_2_i_3
       (.I0(I6),
        .I1(RX_IDLE),
        .I2(I13),
        .O(ACKNOWLEDGE_MATCH_3));
LUT5 #(
    .INIT(32'h0000E222)) 
     ACKNOWLEDGE_MATCH_2_i_1
       (.I0(ACKNOWLEDGE_MATCH_2),
        .I1(RX_CONFIG_VALID),
        .I2(I10[3]),
        .I3(O3[14]),
        .I4(ACKNOWLEDGE_MATCH_3),
        .O(O9));
FDRE CGBAD_REG1_reg
       (.C(CLK),
        .CE(1'b1),
        .D(CGBAD),
        .Q(CGBAD_REG1),
        .R(1'b0));
FDRE CGBAD_REG2_reg
       (.C(CLK),
        .CE(1'b1),
        .D(CGBAD_REG1),
        .Q(CGBAD_REG2),
        .R(1'b0));
FDRE CGBAD_REG3_reg
       (.C(CLK),
        .CE(1'b1),
        .D(CGBAD_REG2),
        .Q(CGBAD_REG3),
        .R(I1));
LUT3 #(
    .INIT(8'hFE)) 
     CGBAD_i_1
       (.I0(RXNOTINTABLE_INT),
        .I1(D_1),
        .I2(p_0_in),
        .O(S2));
FDRE CGBAD_reg
       (.C(CLK),
        .CE(1'b1),
        .D(S2),
        .Q(CGBAD),
        .R(I1));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     CONSISTENCY_MATCH_i_5
       (.I0(O3[9]),
        .I1(I14[0]),
        .I2(O3[10]),
        .I3(I14[1]),
        .I4(I14[2]),
        .I5(O3[11]),
        .O(O11));
LUT3 #(
    .INIT(8'h08)) 
     C_HDR_REMOVED_REG_i_1
       (.I0(I4[0]),
        .I1(C_REG2),
        .I2(I4[1]),
        .O(C_HDR_REMOVED));
FDRE C_HDR_REMOVED_REG_reg
       (.C(CLK),
        .CE(1'b1),
        .D(C_HDR_REMOVED),
        .Q(C_HDR_REMOVED_REG),
        .R(1'b0));
FDRE C_REG1_reg
       (.C(CLK),
        .CE(1'b1),
        .D(C),
        .Q(C_REG1),
        .R(1'b0));
FDRE C_REG2_reg
       (.C(CLK),
        .CE(1'b1),
        .D(C_REG1),
        .Q(C_REG2),
        .R(1'b0));
FDRE C_REG3_reg
       (.C(CLK),
        .CE(1'b1),
        .D(C_REG2),
        .Q(C_REG3),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair19" *) 
   LUT3 #(
    .INIT(8'h04)) 
     C_i_1
       (.I0(n_0_I_i_2),
        .I1(K28p5_REG1),
        .I2(I2),
        .O(C0));
FDRE C_reg
       (.C(CLK),
        .CE(1'b1),
        .D(C0),
        .Q(C),
        .R(1'b0));
LUT4 #(
    .INIT(16'h0002)) 
     D0p0_REG_i_1
       (.I0(n_0_D0p0_REG_i_2),
        .I1(Q[0]),
        .I2(Q[1]),
        .I3(Q[7]),
        .O(D0p0));
LUT6 #(
    .INIT(64'h0000000000000001)) 
     D0p0_REG_i_2
       (.I0(Q[3]),
        .I1(Q[2]),
        .I2(I2),
        .I3(Q[4]),
        .I4(Q[5]),
        .I5(Q[6]),
        .O(n_0_D0p0_REG_i_2));
FDRE D0p0_REG_reg
       (.C(CLK),
        .CE(1'b1),
        .D(D0p0),
        .Q(D0p0_REG),
        .R(1'b0));
LUT3 #(
    .INIT(8'hEA)) 
     EOP_REG1_i_1
       (.I0(EOP),
        .I1(n_0_EXTEND_reg),
        .I2(EXTEND_REG1),
        .O(EOP_REG10));
FDRE EOP_REG1_reg
       (.C(CLK),
        .CE(1'b1),
        .D(EOP_REG10),
        .Q(EOP_REG1),
        .R(I1));
LUT6 #(
    .INIT(64'hFFFFFFFF88888000)) 
     EOP_i_1
       (.I0(T_REG2),
        .I1(R_REG1),
        .I2(RXEVEN),
        .I3(K28p5_REG1),
        .I4(R),
        .I5(n_0_EOP_i_2),
        .O(EOP0));
LUT5 #(
    .INIT(32'hFF808080)) 
     EOP_i_2
       (.I0(RXEVEN),
        .I1(C_REG1),
        .I2(D0p0_REG),
        .I3(RX_IDLE),
        .I4(K28p5_REG1),
        .O(n_0_EOP_i_2));
FDRE EOP_reg
       (.C(CLK),
        .CE(1'b1),
        .D(EOP0),
        .Q(EOP),
        .R(I1));
LUT3 #(
    .INIT(8'hEA)) 
     EXTEND_ERR_i_2
       (.I0(EXT_ILLEGAL_K_REG2),
        .I1(CGBAD_REG3),
        .I2(EXTEND_REG3),
        .O(EXTEND_ERR0));
FDRE EXTEND_ERR_reg
       (.C(CLK),
        .CE(1'b1),
        .D(EXTEND_ERR0),
        .Q(EXTEND_ERR),
        .R(SYNC_STATUS_REG0));
FDRE EXTEND_REG1_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_EXTEND_reg),
        .Q(EXTEND_REG1),
        .R(1'b0));
FDRE EXTEND_REG2_reg
       (.C(CLK),
        .CE(1'b1),
        .D(EXTEND_REG1),
        .Q(EXTEND_REG2),
        .R(1'b0));
FDRE EXTEND_REG3_reg
       (.C(CLK),
        .CE(1'b1),
        .D(EXTEND_REG2),
        .Q(EXTEND_REG3),
        .R(1'b0));
LUT6 #(
    .INIT(64'hAA00AA2AAA00AA00)) 
     EXTEND_i_1
       (.I0(I7),
        .I1(RXEVEN),
        .I2(K28p5_REG1),
        .I3(n_0_EXTEND_i_3),
        .I4(S_0),
        .I5(n_0_EXTEND_reg),
        .O(n_0_EXTEND_i_1));
LUT3 #(
    .INIT(8'h80)) 
     EXTEND_i_3
       (.I0(O1),
        .I1(R),
        .I2(R_REG1),
        .O(n_0_EXTEND_i_3));
FDRE EXTEND_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_EXTEND_i_1),
        .Q(n_0_EXTEND_reg),
        .R(1'b0));
FDRE EXT_ILLEGAL_K_REG1_reg
       (.C(CLK),
        .CE(1'b1),
        .D(EXT_ILLEGAL_K),
        .Q(EXT_ILLEGAL_K_REG1),
        .R(SYNC_STATUS_REG0));
FDRE EXT_ILLEGAL_K_REG2_reg
       (.C(CLK),
        .CE(1'b1),
        .D(EXT_ILLEGAL_K_REG1),
        .Q(EXT_ILLEGAL_K_REG2),
        .R(SYNC_STATUS_REG0));
LUT5 #(
    .INIT(32'h00000700)) 
     EXT_ILLEGAL_K_i_1
       (.I0(RXEVEN),
        .I1(K28p5_REG1),
        .I2(R),
        .I3(EXTEND_REG1),
        .I4(S_0),
        .O(EXT_ILLEGAL_K0));
FDRE EXT_ILLEGAL_K_reg
       (.C(CLK),
        .CE(1'b1),
        .D(EXT_ILLEGAL_K0),
        .Q(EXT_ILLEGAL_K),
        .R(SYNC_STATUS_REG0));
FDRE FALSE_CARRIER_REG1_reg
       (.C(CLK),
        .CE(1'b1),
        .D(FALSE_CARRIER),
        .Q(FALSE_CARRIER_REG1),
        .R(1'b0));
FDRE FALSE_CARRIER_REG2_reg
       (.C(CLK),
        .CE(1'b1),
        .D(FALSE_CARRIER_REG1),
        .Q(FALSE_CARRIER_REG2),
        .R(1'b0));
FDRE FALSE_CARRIER_REG3_reg
       (.C(CLK),
        .CE(1'b1),
        .D(FALSE_CARRIER_REG2),
        .Q(FALSE_CARRIER_REG3),
        .R(SYNC_STATUS_REG0));
LUT6 #(
    .INIT(64'h0A0E0E0E0A0A0A0A)) 
     FALSE_CARRIER_i_1
       (.I0(n_0_FALSE_CARRIER_i_2),
        .I1(RXSYNC_STATUS),
        .I2(I1),
        .I3(RXEVEN),
        .I4(K28p5_REG1),
        .I5(FALSE_CARRIER),
        .O(n_0_FALSE_CARRIER_i_1));
LUT5 #(
    .INIT(32'h00000020)) 
     FALSE_CARRIER_i_2
       (.I0(I11),
        .I1(S_0),
        .I2(RX_IDLE),
        .I3(K28p5_REG1),
        .I4(n_0_FALSE_CARRIER_i_3),
        .O(n_0_FALSE_CARRIER_i_2));
LUT3 #(
    .INIT(8'hFE)) 
     FALSE_CARRIER_i_3
       (.I0(FALSE_DATA),
        .I1(FALSE_K),
        .I2(FALSE_NIT),
        .O(n_0_FALSE_CARRIER_i_3));
FDRE FALSE_CARRIER_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_FALSE_CARRIER_i_1),
        .Q(FALSE_CARRIER),
        .R(1'b0));
LUT4 #(
    .INIT(16'h000E)) 
     FALSE_DATA_i_1
       (.I0(n_0_FALSE_DATA_i_2),
        .I1(n_0_FALSE_DATA_i_3),
        .I2(RXNOTINTABLE_INT),
        .I3(I2),
        .O(FALSE_DATA0));
(* SOFT_HLUTNM = "soft_lutpair22" *) 
   LUT5 #(
    .INIT(32'h00004000)) 
     FALSE_DATA_i_2
       (.I0(Q[6]),
        .I1(Q[5]),
        .I2(Q[7]),
        .I3(Q[2]),
        .I4(n_0_FALSE_DATA_i_4),
        .O(n_0_FALSE_DATA_i_2));
LUT6 #(
    .INIT(64'h00000000004040C0)) 
     FALSE_DATA_i_3
       (.I0(Q[4]),
        .I1(Q[1]),
        .I2(Q[0]),
        .I3(Q[3]),
        .I4(Q[2]),
        .I5(n_0_FALSE_DATA_i_5),
        .O(n_0_FALSE_DATA_i_3));
LUT4 #(
    .INIT(16'hEFF1)) 
     FALSE_DATA_i_4
       (.I0(Q[4]),
        .I1(Q[3]),
        .I2(Q[0]),
        .I3(Q[1]),
        .O(n_0_FALSE_DATA_i_4));
(* SOFT_HLUTNM = "soft_lutpair22" *) 
   LUT3 #(
    .INIT(8'hFB)) 
     FALSE_DATA_i_5
       (.I0(Q[7]),
        .I1(Q[6]),
        .I2(Q[5]),
        .O(n_0_FALSE_DATA_i_5));
FDRE FALSE_DATA_reg
       (.C(CLK),
        .CE(1'b1),
        .D(FALSE_DATA0),
        .Q(FALSE_DATA),
        .R(I1));
LUT6 #(
    .INIT(64'h0000000040000040)) 
     FALSE_K_i_1
       (.I0(n_0_FALSE_K_i_2),
        .I1(Q[7]),
        .I2(Q[4]),
        .I3(Q[5]),
        .I4(Q[6]),
        .I5(RXNOTINTABLE_INT),
        .O(FALSE_K0));
LUT5 #(
    .INIT(32'hEFFFFFFF)) 
     FALSE_K_i_2
       (.I0(Q[1]),
        .I1(Q[0]),
        .I2(I2),
        .I3(Q[2]),
        .I4(Q[3]),
        .O(n_0_FALSE_K_i_2));
FDRE FALSE_K_reg
       (.C(CLK),
        .CE(1'b1),
        .D(FALSE_K0),
        .Q(FALSE_K),
        .R(I1));
LUT6 #(
    .INIT(64'h000A02A2A0AA02A2)) 
     FALSE_NIT_i_1
       (.I0(RXNOTINTABLE_INT),
        .I1(n_0_FALSE_NIT_i_2),
        .I2(Q[7]),
        .I3(n_0_FALSE_NIT_i_3),
        .I4(D_1),
        .I5(n_0_FALSE_NIT_i_4),
        .O(FALSE_NIT0));
LUT6 #(
    .INIT(64'hFFFFFFFFFF7F7FFF)) 
     FALSE_NIT_i_2
       (.I0(I2),
        .I1(Q[2]),
        .I2(Q[3]),
        .I3(Q[0]),
        .I4(Q[1]),
        .I5(n_0_FALSE_NIT_i_5),
        .O(n_0_FALSE_NIT_i_2));
LUT6 #(
    .INIT(64'h0000BFFFBFFFBFFF)) 
     FALSE_NIT_i_3
       (.I0(n_0_FALSE_K_i_2),
        .I1(Q[6]),
        .I2(Q[5]),
        .I3(Q[4]),
        .I4(n_0_FALSE_NIT_i_6),
        .I5(n_0_D0p0_REG_i_2),
        .O(n_0_FALSE_NIT_i_3));
(* SOFT_HLUTNM = "soft_lutpair23" *) 
   LUT5 #(
    .INIT(32'hFFFEFEFF)) 
     FALSE_NIT_i_4
       (.I0(Q[3]),
        .I1(Q[2]),
        .I2(n_0_FALSE_NIT_i_7),
        .I3(Q[0]),
        .I4(Q[1]),
        .O(n_0_FALSE_NIT_i_4));
(* SOFT_HLUTNM = "soft_lutpair25" *) 
   LUT3 #(
    .INIT(8'h7F)) 
     FALSE_NIT_i_5
       (.I0(Q[6]),
        .I1(Q[5]),
        .I2(Q[4]),
        .O(n_0_FALSE_NIT_i_5));
(* SOFT_HLUTNM = "soft_lutpair23" *) 
   LUT2 #(
    .INIT(4'h8)) 
     FALSE_NIT_i_6
       (.I0(Q[0]),
        .I1(Q[1]),
        .O(n_0_FALSE_NIT_i_6));
LUT4 #(
    .INIT(16'hFFFE)) 
     FALSE_NIT_i_7
       (.I0(Q[6]),
        .I1(Q[5]),
        .I2(Q[4]),
        .I3(I2),
        .O(n_0_FALSE_NIT_i_7));
FDRE FALSE_NIT_reg
       (.C(CLK),
        .CE(1'b1),
        .D(FALSE_NIT0),
        .Q(FALSE_NIT),
        .R(I1));
(* SOFT_HLUTNM = "soft_lutpair24" *) 
   LUT4 #(
    .INIT(16'h0004)) 
     FROM_IDLE_D_i_1
       (.I0(K28p5_REG1),
        .I1(RX_IDLE),
        .I2(WAIT_FOR_K),
        .I3(I11),
        .O(FROM_IDLE_D0));
FDRE FROM_IDLE_D_reg
       (.C(CLK),
        .CE(1'b1),
        .D(FROM_IDLE_D0),
        .Q(FROM_IDLE_D),
        .R(SYNC_STATUS_REG0));
LUT6 #(
    .INIT(64'hFFFFA8FFFCFCA8A8)) 
     FROM_RX_CX_i_1
       (.I0(RXCHARISK_REG1),
        .I1(C_REG1),
        .I2(C_REG2),
        .I3(I15),
        .I4(CGBAD),
        .I5(C_REG3),
        .O(FROM_RX_CX0));
FDRE FROM_RX_CX_reg
       (.C(CLK),
        .CE(1'b1),
        .D(FROM_RX_CX0),
        .Q(FROM_RX_CX),
        .R(SYNC_STATUS_REG0));
(* SOFT_HLUTNM = "soft_lutpair28" *) 
   LUT4 #(
    .INIT(16'h00E0)) 
     FROM_RX_K_i_1
       (.I0(RXCHARISK_REG1),
        .I1(CGBAD),
        .I2(K28p5_REG2),
        .I3(I11),
        .O(FROM_RX_K0));
FDRE FROM_RX_K_reg
       (.C(CLK),
        .CE(1'b1),
        .D(FROM_RX_K0),
        .Q(FROM_RX_K),
        .R(SYNC_STATUS_REG0));
FDRE \IDLE_REG_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(RX_IDLE),
        .Q(\n_0_IDLE_REG_reg[0] ),
        .R(I1));
FDRE \IDLE_REG_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_IDLE_REG_reg[0] ),
        .Q(p_0_in1_in),
        .R(I1));
FDRE \IDLE_REG_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .D(p_0_in1_in),
        .Q(\n_0_IDLE_REG_reg[2] ),
        .R(I1));
FDRE ILLEGAL_K_REG1_reg
       (.C(CLK),
        .CE(1'b1),
        .D(ILLEGAL_K),
        .Q(ILLEGAL_K_REG1),
        .R(SYNC_STATUS_REG0));
FDRE ILLEGAL_K_REG2_reg
       (.C(CLK),
        .CE(1'b1),
        .D(ILLEGAL_K_REG1),
        .Q(ILLEGAL_K_REG2),
        .R(SYNC_STATUS_REG0));
LUT4 #(
    .INIT(16'h0010)) 
     ILLEGAL_K_i_1
       (.I0(R),
        .I1(K28p5_REG1),
        .I2(RXCHARISK_REG1),
        .I3(T),
        .O(ILLEGAL_K0));
FDRE ILLEGAL_K_reg
       (.C(CLK),
        .CE(1'b1),
        .D(ILLEGAL_K0),
        .Q(ILLEGAL_K),
        .R(SYNC_STATUS_REG0));
FDRE I_REG_reg
       (.C(CLK),
        .CE(1'b1),
        .D(I),
        .Q(RX_IDLE),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair19" *) 
   LUT5 #(
    .INIT(32'h33220020)) 
     I_i_1
       (.I0(n_0_I_i_2),
        .I1(n_0_I_i_3),
        .I2(K28p5_REG1),
        .I3(I2),
        .I4(I11),
        .O(I0));
LUT6 #(
    .INIT(64'hFFFFAAFFFFCFAAFF)) 
     I_i_2
       (.I0(n_0_I_i_4),
        .I1(Q[3]),
        .I2(Q[2]),
        .I3(Q[1]),
        .I4(Q[0]),
        .I5(n_0_I_i_5),
        .O(n_0_I_i_2));
LUT6 #(
    .INIT(64'h000001FFFFFFFFFF)) 
     I_i_3
       (.I0(FALSE_DATA),
        .I1(FALSE_K),
        .I2(FALSE_NIT),
        .I3(RX_IDLE),
        .I4(K28p5_REG1),
        .I5(RXEVEN),
        .O(n_0_I_i_3));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFB)) 
     I_i_4
       (.I0(Q[5]),
        .I1(Q[6]),
        .I2(Q[7]),
        .I3(Q[2]),
        .I4(Q[3]),
        .I5(Q[4]),
        .O(n_0_I_i_4));
(* SOFT_HLUTNM = "soft_lutpair25" *) 
   LUT4 #(
    .INIT(16'hDFFF)) 
     I_i_5
       (.I0(Q[5]),
        .I1(Q[6]),
        .I2(Q[4]),
        .I3(Q[7]),
        .O(n_0_I_i_5));
FDRE I_reg
       (.C(CLK),
        .CE(1'b1),
        .D(I0),
        .Q(I),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair20" *) 
   LUT5 #(
    .INIT(32'h02000000)) 
     K28p5_REG1_i_1
       (.I0(Q[5]),
        .I1(Q[6]),
        .I2(n_0_FALSE_K_i_2),
        .I3(Q[7]),
        .I4(Q[4]),
        .O(K28p5));
FDRE K28p5_REG1_reg
       (.C(CLK),
        .CE(1'b1),
        .D(K28p5),
        .Q(K28p5_REG1),
        .R(1'b0));
FDRE K28p5_REG2_reg
       (.C(CLK),
        .CE(1'b1),
        .D(K28p5_REG1),
        .Q(K28p5_REG2),
        .R(1'b0));
LUT5 #(
    .INIT(32'hAAAABABB)) 
     MASK_RUDI_CLKCOR_i_2
       (.I0(O2),
        .I1(XMIT_DATA_INT),
        .I2(I12[3]),
        .I3(I12[0]),
        .I4(RXSYNC_STATUS),
        .O(RX_RUDI_INVALID));
(* SOFT_HLUTNM = "soft_lutpair27" *) 
   LUT4 #(
    .INIT(16'h0D0C)) 
     RECEIVED_IDLE_i_1
       (.I0(RX_CONFIG_VALID),
        .I1(RX_IDLE),
        .I2(I6),
        .I3(I8),
        .O(O5));
LUT5 #(
    .INIT(32'h44044400)) 
     RECEIVE_i_1
       (.I0(I1),
        .I1(RXSYNC_STATUS),
        .I2(EOP),
        .I3(SOP_REG2),
        .I4(O1),
        .O(n_0_RECEIVE_i_1));
FDRE RECEIVE_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_RECEIVE_i_1),
        .Q(O1),
        .R(1'b0));
LUT4 #(
    .INIT(16'hFFFE)) 
     RUDI_C_i_1
       (.I0(p_1_in),
        .I1(\n_0_RX_CONFIG_VALID_REG_reg[0] ),
        .I2(\n_0_RX_CONFIG_VALID_REG_reg[3] ),
        .I3(p_0_in2_in),
        .O(RUDI_C0));
FDRE RUDI_C_reg
       (.C(CLK),
        .CE(1'b1),
        .D(RUDI_C0),
        .Q(status_vector[0]),
        .R(I1));
LUT2 #(
    .INIT(4'hE)) 
     RUDI_I_i_1
       (.I0(\n_0_IDLE_REG_reg[2] ),
        .I1(p_0_in1_in),
        .O(RUDI_I0));
FDRE RUDI_I_reg
       (.C(CLK),
        .CE(1'b1),
        .D(RUDI_I0),
        .Q(status_vector[1]),
        .R(I1));
FDRE RXCHARISK_REG1_reg
       (.C(CLK),
        .CE(1'b1),
        .D(I2),
        .Q(RXCHARISK_REG1),
        .R(1'b0));
(* srl_bus_name = "\U0/pcs_pma_block_i/gmii_to_sgmii_core/gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg " *) 
   (* srl_name = "\U0/pcs_pma_block_i/gmii_to_sgmii_core/gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg[0]_srl4 " *) 
   SRL16E \RXDATA_REG4_reg[0]_srl4 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b0),
        .A3(1'b0),
        .CE(1'b1),
        .CLK(CLK),
        .D(Q[0]),
        .Q(\n_0_RXDATA_REG4_reg[0]_srl4 ));
(* srl_bus_name = "\U0/pcs_pma_block_i/gmii_to_sgmii_core/gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg " *) 
   (* srl_name = "\U0/pcs_pma_block_i/gmii_to_sgmii_core/gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg[1]_srl4 " *) 
   SRL16E \RXDATA_REG4_reg[1]_srl4 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b0),
        .A3(1'b0),
        .CE(1'b1),
        .CLK(CLK),
        .D(Q[1]),
        .Q(\n_0_RXDATA_REG4_reg[1]_srl4 ));
(* srl_bus_name = "\U0/pcs_pma_block_i/gmii_to_sgmii_core/gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg " *) 
   (* srl_name = "\U0/pcs_pma_block_i/gmii_to_sgmii_core/gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg[2]_srl4 " *) 
   SRL16E \RXDATA_REG4_reg[2]_srl4 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b0),
        .A3(1'b0),
        .CE(1'b1),
        .CLK(CLK),
        .D(Q[2]),
        .Q(\n_0_RXDATA_REG4_reg[2]_srl4 ));
(* srl_bus_name = "\U0/pcs_pma_block_i/gmii_to_sgmii_core/gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg " *) 
   (* srl_name = "\U0/pcs_pma_block_i/gmii_to_sgmii_core/gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg[3]_srl4 " *) 
   SRL16E \RXDATA_REG4_reg[3]_srl4 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b0),
        .A3(1'b0),
        .CE(1'b1),
        .CLK(CLK),
        .D(Q[3]),
        .Q(\n_0_RXDATA_REG4_reg[3]_srl4 ));
(* srl_bus_name = "\U0/pcs_pma_block_i/gmii_to_sgmii_core/gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg " *) 
   (* srl_name = "\U0/pcs_pma_block_i/gmii_to_sgmii_core/gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg[4]_srl4 " *) 
   SRL16E \RXDATA_REG4_reg[4]_srl4 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b0),
        .A3(1'b0),
        .CE(1'b1),
        .CLK(CLK),
        .D(Q[4]),
        .Q(\n_0_RXDATA_REG4_reg[4]_srl4 ));
(* srl_bus_name = "\U0/pcs_pma_block_i/gmii_to_sgmii_core/gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg " *) 
   (* srl_name = "\U0/pcs_pma_block_i/gmii_to_sgmii_core/gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg[5]_srl4 " *) 
   SRL16E \RXDATA_REG4_reg[5]_srl4 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b0),
        .A3(1'b0),
        .CE(1'b1),
        .CLK(CLK),
        .D(Q[5]),
        .Q(\n_0_RXDATA_REG4_reg[5]_srl4 ));
(* srl_bus_name = "\U0/pcs_pma_block_i/gmii_to_sgmii_core/gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg " *) 
   (* srl_name = "\U0/pcs_pma_block_i/gmii_to_sgmii_core/gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg[6]_srl4 " *) 
   SRL16E \RXDATA_REG4_reg[6]_srl4 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b0),
        .A3(1'b0),
        .CE(1'b1),
        .CLK(CLK),
        .D(Q[6]),
        .Q(\n_0_RXDATA_REG4_reg[6]_srl4 ));
(* srl_bus_name = "\U0/pcs_pma_block_i/gmii_to_sgmii_core/gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg " *) 
   (* srl_name = "\U0/pcs_pma_block_i/gmii_to_sgmii_core/gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg[7]_srl4 " *) 
   SRL16E \RXDATA_REG4_reg[7]_srl4 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b0),
        .A3(1'b0),
        .CE(1'b1),
        .CLK(CLK),
        .D(Q[7]),
        .Q(\n_0_RXDATA_REG4_reg[7]_srl4 ));
FDRE \RXDATA_REG5_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_RXDATA_REG4_reg[0]_srl4 ),
        .Q(RXDATA_REG5[0]),
        .R(1'b0));
FDRE \RXDATA_REG5_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_RXDATA_REG4_reg[1]_srl4 ),
        .Q(RXDATA_REG5[1]),
        .R(1'b0));
FDRE \RXDATA_REG5_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_RXDATA_REG4_reg[2]_srl4 ),
        .Q(RXDATA_REG5[2]),
        .R(1'b0));
FDRE \RXDATA_REG5_reg[3] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_RXDATA_REG4_reg[3]_srl4 ),
        .Q(RXDATA_REG5[3]),
        .R(1'b0));
FDRE \RXDATA_REG5_reg[4] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_RXDATA_REG4_reg[4]_srl4 ),
        .Q(RXDATA_REG5[4]),
        .R(1'b0));
FDRE \RXDATA_REG5_reg[5] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_RXDATA_REG4_reg[5]_srl4 ),
        .Q(RXDATA_REG5[5]),
        .R(1'b0));
FDRE \RXDATA_REG5_reg[6] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_RXDATA_REG4_reg[6]_srl4 ),
        .Q(RXDATA_REG5[6]),
        .R(1'b0));
FDRE \RXDATA_REG5_reg[7] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_RXDATA_REG4_reg[7]_srl4 ),
        .Q(RXDATA_REG5[7]),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair29" *) 
   LUT4 #(
    .INIT(16'hBBBA)) 
     \RXD[0]_i_1 
       (.I0(SOP_REG3),
        .I1(FALSE_CARRIER_REG3),
        .I2(EXTEND_REG1),
        .I3(RXDATA_REG5[0]),
        .O(\n_0_RXD[0]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair26" *) 
   LUT4 #(
    .INIT(16'h5554)) 
     \RXD[1]_i_1 
       (.I0(SOP_REG3),
        .I1(RXDATA_REG5[1]),
        .I2(FALSE_CARRIER_REG3),
        .I3(EXTEND_REG1),
        .O(\n_0_RXD[1]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair29" *) 
   LUT4 #(
    .INIT(16'hFFFE)) 
     \RXD[2]_i_1 
       (.I0(EXTEND_REG1),
        .I1(FALSE_CARRIER_REG3),
        .I2(RXDATA_REG5[2]),
        .I3(SOP_REG3),
        .O(\n_0_RXD[2]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair26" *) 
   LUT4 #(
    .INIT(16'h5554)) 
     \RXD[3]_i_1 
       (.I0(SOP_REG3),
        .I1(RXDATA_REG5[3]),
        .I2(FALSE_CARRIER_REG3),
        .I3(EXTEND_REG1),
        .O(\n_0_RXD[3]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair18" *) 
   LUT5 #(
    .INIT(32'hBABBBAAA)) 
     \RXD[4]_i_1 
       (.I0(SOP_REG3),
        .I1(FALSE_CARRIER_REG3),
        .I2(EXTEND_ERR),
        .I3(EXTEND_REG1),
        .I4(RXDATA_REG5[4]),
        .O(\n_0_RXD[4]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair30" *) 
   LUT4 #(
    .INIT(16'h0010)) 
     \RXD[5]_i_1 
       (.I0(EXTEND_REG1),
        .I1(FALSE_CARRIER_REG3),
        .I2(RXDATA_REG5[5]),
        .I3(SOP_REG3),
        .O(\n_0_RXD[5]_i_1 ));
LUT4 #(
    .INIT(16'hABAA)) 
     \RXD[6]_i_1 
       (.I0(SOP_REG3),
        .I1(FALSE_CARRIER_REG3),
        .I2(EXTEND_REG1),
        .I3(RXDATA_REG5[6]),
        .O(\n_0_RXD[6]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair30" *) 
   LUT4 #(
    .INIT(16'h0010)) 
     \RXD[7]_i_1 
       (.I0(EXTEND_REG1),
        .I1(FALSE_CARRIER_REG3),
        .I2(RXDATA_REG5[7]),
        .I3(SOP_REG3),
        .O(\n_0_RXD[7]_i_1 ));
FDRE \RXD_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_RXD[0]_i_1 ),
        .Q(O7[0]),
        .R(I12[2]));
FDRE \RXD_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_RXD[1]_i_1 ),
        .Q(O7[1]),
        .R(I12[2]));
FDRE \RXD_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_RXD[2]_i_1 ),
        .Q(O7[2]),
        .R(I12[2]));
FDRE \RXD_reg[3] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_RXD[3]_i_1 ),
        .Q(O7[3]),
        .R(I12[2]));
FDRE \RXD_reg[4] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_RXD[4]_i_1 ),
        .Q(O7[4]),
        .R(I12[2]));
FDRE \RXD_reg[5] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_RXD[5]_i_1 ),
        .Q(O7[5]),
        .R(I12[2]));
FDRE \RXD_reg[6] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_RXD[6]_i_1 ),
        .Q(O7[6]),
        .R(I12[2]));
FDRE \RXD_reg[7] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_RXD[7]_i_1 ),
        .Q(O7[7]),
        .R(I12[2]));
LUT4 #(
    .INIT(16'h0054)) 
     \RX_CONFIG_REG[15]_i_1 
       (.I0(RXCHARISK_REG1),
        .I1(C_REG1),
        .I2(C_HDR_REMOVED_REG),
        .I3(I2),
        .O(p_0_out));
LUT5 #(
    .INIT(32'h55550040)) 
     \RX_CONFIG_REG[7]_i_1 
       (.I0(I2),
        .I1(I4[0]),
        .I2(C_REG2),
        .I3(I4[1]),
        .I4(C),
        .O(\n_0_RX_CONFIG_REG[7]_i_1 ));
LUT6 #(
    .INIT(64'h808080FF80808000)) 
     RX_CONFIG_REG_NULL_i_1
       (.I0(n_0_RX_CONFIG_REG_NULL_i_2),
        .I1(n_0_RX_CONFIG_REG_NULL_i_3),
        .I2(n_0_RX_CONFIG_REG_NULL_i_4),
        .I3(I6),
        .I4(RX_CONFIG_VALID),
        .I5(I9),
        .O(O8));
LUT5 #(
    .INIT(32'h00000001)) 
     RX_CONFIG_REG_NULL_i_2
       (.I0(O3[3]),
        .I1(O3[4]),
        .I2(O3[1]),
        .I3(O3[2]),
        .I4(O3[0]),
        .O(n_0_RX_CONFIG_REG_NULL_i_2));
LUT6 #(
    .INIT(64'h0000000000000001)) 
     RX_CONFIG_REG_NULL_i_3
       (.I0(O3[10]),
        .I1(O3[14]),
        .I2(O3[12]),
        .I3(I6),
        .I4(O3[11]),
        .I5(O3[15]),
        .O(n_0_RX_CONFIG_REG_NULL_i_3));
LUT6 #(
    .INIT(64'h0000000000000001)) 
     RX_CONFIG_REG_NULL_i_4
       (.I0(O3[6]),
        .I1(O3[5]),
        .I2(O3[9]),
        .I3(O3[13]),
        .I4(O3[7]),
        .I5(O3[8]),
        .O(n_0_RX_CONFIG_REG_NULL_i_4));
(* SOFT_HLUTNM = "soft_lutpair24" *) 
   LUT2 #(
    .INIT(4'hE)) 
     \RX_CONFIG_REG_REG[15]_i_1 
       (.I0(I6),
        .I1(RX_IDLE),
        .O(SR));
FDRE \RX_CONFIG_REG_reg[0] 
       (.C(CLK),
        .CE(\n_0_RX_CONFIG_REG[7]_i_1 ),
        .D(Q[0]),
        .Q(O3[0]),
        .R(1'b0));
FDRE \RX_CONFIG_REG_reg[10] 
       (.C(CLK),
        .CE(p_0_out),
        .D(Q[2]),
        .Q(O3[10]),
        .R(1'b0));
FDRE \RX_CONFIG_REG_reg[11] 
       (.C(CLK),
        .CE(p_0_out),
        .D(Q[3]),
        .Q(O3[11]),
        .R(1'b0));
FDRE \RX_CONFIG_REG_reg[12] 
       (.C(CLK),
        .CE(p_0_out),
        .D(Q[4]),
        .Q(O3[12]),
        .R(1'b0));
FDRE \RX_CONFIG_REG_reg[13] 
       (.C(CLK),
        .CE(p_0_out),
        .D(Q[5]),
        .Q(O3[13]),
        .R(1'b0));
FDRE \RX_CONFIG_REG_reg[14] 
       (.C(CLK),
        .CE(p_0_out),
        .D(Q[6]),
        .Q(O3[14]),
        .R(1'b0));
FDRE \RX_CONFIG_REG_reg[15] 
       (.C(CLK),
        .CE(p_0_out),
        .D(Q[7]),
        .Q(O3[15]),
        .R(1'b0));
FDRE \RX_CONFIG_REG_reg[1] 
       (.C(CLK),
        .CE(\n_0_RX_CONFIG_REG[7]_i_1 ),
        .D(Q[1]),
        .Q(O3[1]),
        .R(1'b0));
FDRE \RX_CONFIG_REG_reg[2] 
       (.C(CLK),
        .CE(\n_0_RX_CONFIG_REG[7]_i_1 ),
        .D(Q[2]),
        .Q(O3[2]),
        .R(1'b0));
FDRE \RX_CONFIG_REG_reg[3] 
       (.C(CLK),
        .CE(\n_0_RX_CONFIG_REG[7]_i_1 ),
        .D(Q[3]),
        .Q(O3[3]),
        .R(1'b0));
FDRE \RX_CONFIG_REG_reg[4] 
       (.C(CLK),
        .CE(\n_0_RX_CONFIG_REG[7]_i_1 ),
        .D(Q[4]),
        .Q(O3[4]),
        .R(1'b0));
FDRE \RX_CONFIG_REG_reg[5] 
       (.C(CLK),
        .CE(\n_0_RX_CONFIG_REG[7]_i_1 ),
        .D(Q[5]),
        .Q(O3[5]),
        .R(1'b0));
FDRE \RX_CONFIG_REG_reg[6] 
       (.C(CLK),
        .CE(\n_0_RX_CONFIG_REG[7]_i_1 ),
        .D(Q[6]),
        .Q(O3[6]),
        .R(1'b0));
FDRE \RX_CONFIG_REG_reg[7] 
       (.C(CLK),
        .CE(\n_0_RX_CONFIG_REG[7]_i_1 ),
        .D(Q[7]),
        .Q(O3[7]),
        .R(1'b0));
FDRE \RX_CONFIG_REG_reg[8] 
       (.C(CLK),
        .CE(p_0_out),
        .D(Q[0]),
        .Q(O3[8]),
        .R(1'b0));
FDRE \RX_CONFIG_REG_reg[9] 
       (.C(CLK),
        .CE(p_0_out),
        .D(Q[1]),
        .Q(O3[9]),
        .R(1'b0));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     \RX_CONFIG_SNAPSHOT[15]_i_7 
       (.I0(O3[11]),
        .I1(I10[2]),
        .I2(O3[9]),
        .I3(I10[0]),
        .I4(I10[1]),
        .I5(O3[10]),
        .O(S));
LUT6 #(
    .INIT(64'h0040004000400000)) 
     RX_CONFIG_VALID_INT_i_1
       (.I0(S2),
        .I1(RXSYNC_STATUS),
        .I2(n_0_RX_CONFIG_VALID_INT_i_2),
        .I3(I2),
        .I4(C_HDR_REMOVED_REG),
        .I5(C_REG1),
        .O(RX_CONFIG_VALID_INT0));
(* SOFT_HLUTNM = "soft_lutpair28" *) 
   LUT2 #(
    .INIT(4'h1)) 
     RX_CONFIG_VALID_INT_i_2
       (.I0(RXCHARISK_REG1),
        .I1(CGBAD),
        .O(n_0_RX_CONFIG_VALID_INT_i_2));
FDRE RX_CONFIG_VALID_INT_reg
       (.C(CLK),
        .CE(1'b1),
        .D(RX_CONFIG_VALID_INT0),
        .Q(RX_CONFIG_VALID),
        .R(I1));
FDRE \RX_CONFIG_VALID_REG_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(RX_CONFIG_VALID),
        .Q(\n_0_RX_CONFIG_VALID_REG_reg[0] ),
        .R(I1));
FDRE \RX_CONFIG_VALID_REG_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_RX_CONFIG_VALID_REG_reg[0] ),
        .Q(p_0_in2_in),
        .R(I1));
FDRE \RX_CONFIG_VALID_REG_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .D(p_0_in2_in),
        .Q(p_1_in),
        .R(I1));
FDRE \RX_CONFIG_VALID_REG_reg[3] 
       (.C(CLK),
        .CE(1'b1),
        .D(p_1_in),
        .Q(\n_0_RX_CONFIG_VALID_REG_reg[3] ),
        .R(I1));
LUT6 #(
    .INIT(64'h888AAAAA88888888)) 
     RX_DATA_ERROR_i_1
       (.I0(O1),
        .I1(n_0_RX_DATA_ERROR_i_2),
        .I2(R),
        .I3(I15),
        .I4(R_REG1),
        .I5(T_REG2),
        .O(RX_DATA_ERROR0));
LUT5 #(
    .INIT(32'hFFFF0A0E)) 
     RX_DATA_ERROR_i_2
       (.I0(K28p5_REG1),
        .I1(R),
        .I2(R_REG1),
        .I3(T_REG1),
        .I4(n_0_RX_DATA_ERROR_i_4),
        .O(n_0_RX_DATA_ERROR_i_2));
LUT4 #(
    .INIT(16'hFFFE)) 
     RX_DATA_ERROR_i_4
       (.I0(CGBAD_REG3),
        .I1(C_REG1),
        .I2(ILLEGAL_K_REG2),
        .I3(RX_IDLE),
        .O(n_0_RX_DATA_ERROR_i_4));
FDRE RX_DATA_ERROR_reg
       (.C(CLK),
        .CE(1'b1),
        .D(RX_DATA_ERROR0),
        .Q(RX_DATA_ERROR),
        .R(SYNC_STATUS_REG0));
FDRE #(
    .INIT(1'b0)) 
     RX_DV_reg
       (.C(CLK),
        .CE(1'b1),
        .D(I3),
        .Q(O4),
        .R(1'b0));
LUT6 #(
    .INIT(64'h2220222000202220)) 
     RX_ER_i_1
       (.I0(XMIT_DATA),
        .I1(n_0_RX_ER_i_2),
        .I2(O1),
        .I3(RXSYNC_STATUS),
        .I4(n_0_RX_ER_i_3),
        .I5(RX_DATA_ERROR),
        .O(RX_ER0));
LUT2 #(
    .INIT(4'hE)) 
     RX_ER_i_2
       (.I0(I12[2]),
        .I1(I12[1]),
        .O(n_0_RX_ER_i_2));
(* SOFT_HLUTNM = "soft_lutpair18" *) 
   LUT2 #(
    .INIT(4'h1)) 
     RX_ER_i_3
       (.I0(FALSE_CARRIER_REG3),
        .I1(EXTEND_REG1),
        .O(n_0_RX_ER_i_3));
FDRE #(
    .INIT(1'b0)) 
     RX_ER_reg
       (.C(CLK),
        .CE(1'b1),
        .D(RX_ER0),
        .Q(RX_ER),
        .R(I1));
LUT5 #(
    .INIT(32'h080C0808)) 
     RX_INVALID_i_1
       (.I0(n_0_RX_INVALID_i_2),
        .I1(RXSYNC_STATUS),
        .I2(I1),
        .I3(K28p5_REG1),
        .I4(O2),
        .O(n_0_RX_INVALID_i_1));
LUT4 #(
    .INIT(16'hBBBA)) 
     RX_INVALID_i_2
       (.I0(FROM_RX_CX),
        .I1(I11),
        .I2(FROM_RX_K),
        .I3(FROM_IDLE_D),
        .O(n_0_RX_INVALID_i_2));
FDRE RX_INVALID_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_RX_INVALID_i_1),
        .Q(O2),
        .R(1'b0));
FDRE R_REG1_reg
       (.C(CLK),
        .CE(1'b1),
        .D(R),
        .Q(R_REG1),
        .R(1'b0));
LUT6 #(
    .INIT(64'h2000000000000000)) 
     R_i_1
       (.I0(n_0_R_i_2),
        .I1(Q[3]),
        .I2(Q[1]),
        .I3(Q[0]),
        .I4(Q[2]),
        .I5(I2),
        .O(K23p7));
(* SOFT_HLUTNM = "soft_lutpair20" *) 
   LUT4 #(
    .INIT(16'h8000)) 
     R_i_2
       (.I0(Q[4]),
        .I1(Q[7]),
        .I2(Q[6]),
        .I3(Q[5]),
        .O(n_0_R_i_2));
FDRE R_reg
       (.C(CLK),
        .CE(1'b1),
        .D(K23p7),
        .Q(R),
        .R(1'b0));
FDRE SOP_REG1_reg
       (.C(CLK),
        .CE(1'b1),
        .D(SOP),
        .Q(SOP_REG1),
        .R(1'b0));
FDRE SOP_REG2_reg
       (.C(CLK),
        .CE(1'b1),
        .D(SOP_REG1),
        .Q(SOP_REG2),
        .R(1'b0));
FDRE SOP_REG3_reg
       (.C(CLK),
        .CE(1'b1),
        .D(SOP_REG2),
        .Q(SOP_REG3),
        .R(1'b0));
LUT5 #(
    .INIT(32'h20202000)) 
     SOP_i_1
       (.I0(I11),
        .I1(WAIT_FOR_K),
        .I2(S_0),
        .I3(RX_IDLE),
        .I4(n_0_EXTEND_reg),
        .O(SOP0));
FDRE SOP_reg
       (.C(CLK),
        .CE(1'b1),
        .D(SOP0),
        .Q(SOP),
        .R(I1));
FDRE SYNC_STATUS_REG_reg
       (.C(CLK),
        .CE(1'b1),
        .D(1'b1),
        .Q(SYNC_STATUS_REG),
        .R(SYNC_STATUS_REG0));
(* SOFT_HLUTNM = "soft_lutpair21" *) 
   LUT5 #(
    .INIT(32'h00002000)) 
     S_i_1
       (.I0(n_0_S_i_2),
        .I1(Q[2]),
        .I2(Q[1]),
        .I3(Q[0]),
        .I4(S2),
        .O(S0));
LUT6 #(
    .INIT(64'h8000000000000000)) 
     S_i_2
       (.I0(Q[5]),
        .I1(Q[6]),
        .I2(Q[7]),
        .I3(Q[4]),
        .I4(Q[3]),
        .I5(I2),
        .O(n_0_S_i_2));
FDRE S_reg
       (.C(CLK),
        .CE(1'b1),
        .D(S0),
        .Q(S_0),
        .R(1'b0));
FDRE T_REG1_reg
       (.C(CLK),
        .CE(1'b1),
        .D(T),
        .Q(T_REG1),
        .R(1'b0));
FDRE T_REG2_reg
       (.C(CLK),
        .CE(1'b1),
        .D(T_REG1),
        .Q(T_REG2),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair21" *) 
   LUT4 #(
    .INIT(16'h0800)) 
     T_i_1
       (.I0(n_0_S_i_2),
        .I1(Q[2]),
        .I2(Q[1]),
        .I3(Q[0]),
        .O(K29p7));
FDRE T_reg
       (.C(CLK),
        .CE(1'b1),
        .D(K29p7),
        .Q(T),
        .R(1'b0));
LUT6 #(
    .INIT(64'h0222222200002222)) 
     WAIT_FOR_K_i_1
       (.I0(RXSYNC_STATUS),
        .I1(I1),
        .I2(RXEVEN),
        .I3(K28p5_REG1),
        .I4(SYNC_STATUS_REG),
        .I5(WAIT_FOR_K),
        .O(n_0_WAIT_FOR_K_i_1));
FDRE WAIT_FOR_K_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_WAIT_FOR_K_i_1),
        .Q(WAIT_FOR_K),
        .R(1'b0));
LUT2 #(
    .INIT(4'h2)) 
     sfd_enable_i_3
       (.I0(O4),
        .I1(rx_dv_reg1),
        .O(O10));
LUT6 #(
    .INIT(64'h0000000040000000)) 
     sfd_enable_i_5
       (.I0(I5[1]),
        .I1(I5[0]),
        .I2(O7[2]),
        .I3(O7[3]),
        .I4(O7[0]),
        .I5(O7[1]),
        .O(O6));
endmodule

(* ORIG_REF_NAME = "SYNCHRONISE" *) 
module gmii_to_sgmiiSYNCHRONISE
   (RXEVEN,
    RXSYNC_STATUS,
    encommaalign,
    O1,
    STATUS_VECTOR_0_PRE0,
    SYNC_STATUS_REG0,
    O2,
    SYNC_STATUS_HELD,
    O3,
    O4,
    SIGNAL_DETECT_MOD,
    CLK,
    I1,
    I2,
    I3,
    I4,
    I5,
    Q,
    p_0_in,
    D_1,
    RXNOTINTABLE_INT,
    data_out,
    XMIT_DATA_INT,
    K28p5_REG1,
    I6);
  output RXEVEN;
  output RXSYNC_STATUS;
  output encommaalign;
  output O1;
  output STATUS_VECTOR_0_PRE0;
  output SYNC_STATUS_REG0;
  output O2;
  output SYNC_STATUS_HELD;
  output O3;
  output O4;
  input SIGNAL_DETECT_MOD;
  input CLK;
  input I1;
  input I2;
  input I3;
  input I4;
  input I5;
  input [2:0]Q;
  input p_0_in;
  input D_1;
  input RXNOTINTABLE_INT;
  input data_out;
  input XMIT_DATA_INT;
  input K28p5_REG1;
  input I6;

  wire CLK;
  wire D_1;
  wire [1:0]GOOD_CGS;
  wire I1;
  wire I2;
  wire I3;
  wire I4;
  wire I5;
  wire I6;
  wire K28p5_REG1;
  wire O1;
  wire O2;
  wire O3;
  wire O4;
  wire [2:0]Q;
  wire RXEVEN;
  wire RXNOTINTABLE_INT;
  wire RXSYNC_STATUS;
  wire SIGNAL_DETECT_MOD;
  wire SIGNAL_DETECT_REG;
(* RTL_KEEP = "yes" *)   wire [3:0]STATE;
  wire STATUS_VECTOR_0_PRE0;
  wire SYNC_STATUS0;
  wire SYNC_STATUS_HELD;
  wire SYNC_STATUS_REG0;
  wire XMIT_DATA_INT;
  wire data_out;
  wire encommaalign;
  wire n_0_ENCOMMAALIGN_i_1;
  wire n_0_EVEN_i_1;
  wire \n_0_FSM_sequential_STATE[0]_i_2 ;
  wire \n_0_FSM_sequential_STATE[0]_i_3 ;
  wire \n_0_FSM_sequential_STATE[1]_i_2 ;
  wire \n_0_FSM_sequential_STATE[1]_i_3 ;
  wire \n_0_FSM_sequential_STATE[2]_i_2 ;
  wire \n_0_FSM_sequential_STATE[2]_i_3 ;
  wire \n_0_FSM_sequential_STATE[3]_i_1 ;
  wire \n_0_FSM_sequential_STATE[3]_i_2 ;
  wire \n_0_FSM_sequential_STATE[3]_i_3 ;
  wire \n_0_FSM_sequential_STATE[3]_i_4 ;
  wire \n_0_FSM_sequential_STATE_reg[0]_i_1 ;
  wire \n_0_FSM_sequential_STATE_reg[1]_i_1 ;
  wire \n_0_FSM_sequential_STATE_reg[2]_i_1 ;
  wire \n_0_GOOD_CGS[0]_i_1 ;
  wire \n_0_GOOD_CGS[1]_i_1 ;
  wire \n_0_GOOD_CGS[1]_i_2 ;
  wire n_0_SYNC_STATUS_i_1;
  wire n_0_SYNC_STATUS_i_2;
  wire p_0_in;

(* SOFT_HLUTNM = "soft_lutpair32" *) 
   LUT3 #(
    .INIT(8'h0E)) 
     ENCOMMAALIGN_i_1
       (.I0(encommaalign),
        .I1(n_0_SYNC_STATUS_i_2),
        .I2(SYNC_STATUS0),
        .O(n_0_ENCOMMAALIGN_i_1));
FDRE ENCOMMAALIGN_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_ENCOMMAALIGN_i_1),
        .Q(encommaalign),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair34" *) 
   LUT3 #(
    .INIT(8'h4F)) 
     EVEN_i_1
       (.I0(RXSYNC_STATUS),
        .I1(I2),
        .I2(RXEVEN),
        .O(n_0_EVEN_i_1));
FDRE EVEN_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_EVEN_i_1),
        .Q(RXEVEN),
        .R(I1));
(* SOFT_HLUTNM = "soft_lutpair34" *) 
   LUT2 #(
    .INIT(4'hB)) 
     EXTEND_ERR_i_1
       (.I0(I1),
        .I1(RXSYNC_STATUS),
        .O(SYNC_STATUS_REG0));
(* SOFT_HLUTNM = "soft_lutpair35" *) 
   LUT2 #(
    .INIT(4'h2)) 
     EXTEND_i_2
       (.I0(RXSYNC_STATUS),
        .I1(I1),
        .O(O2));
LUT5 #(
    .INIT(32'h99404050)) 
     \FSM_sequential_STATE[0]_i_2 
       (.I0(STATE[0]),
        .I1(\n_0_FSM_sequential_STATE[3]_i_4 ),
        .I2(I2),
        .I3(STATE[1]),
        .I4(STATE[2]),
        .O(\n_0_FSM_sequential_STATE[0]_i_2 ));
LUT6 #(
    .INIT(64'h00F000DF00000000)) 
     \FSM_sequential_STATE[0]_i_3 
       (.I0(GOOD_CGS[1]),
        .I1(GOOD_CGS[0]),
        .I2(STATE[0]),
        .I3(STATE[2]),
        .I4(STATE[1]),
        .I5(\n_0_FSM_sequential_STATE[3]_i_4 ),
        .O(\n_0_FSM_sequential_STATE[0]_i_3 ));
LUT5 #(
    .INIT(32'h33403040)) 
     \FSM_sequential_STATE[1]_i_2 
       (.I0(I5),
        .I1(STATE[0]),
        .I2(\n_0_FSM_sequential_STATE[3]_i_4 ),
        .I3(STATE[1]),
        .I4(STATE[2]),
        .O(\n_0_FSM_sequential_STATE[1]_i_2 ));
LUT6 #(
    .INIT(64'h00000000FF0020FF)) 
     \FSM_sequential_STATE[1]_i_3 
       (.I0(GOOD_CGS[1]),
        .I1(GOOD_CGS[0]),
        .I2(\n_0_FSM_sequential_STATE[3]_i_4 ),
        .I3(STATE[0]),
        .I4(STATE[1]),
        .I5(STATE[2]),
        .O(\n_0_FSM_sequential_STATE[1]_i_3 ));
LUT5 #(
    .INIT(32'h33704000)) 
     \FSM_sequential_STATE[2]_i_2 
       (.I0(I5),
        .I1(STATE[0]),
        .I2(\n_0_FSM_sequential_STATE[3]_i_4 ),
        .I3(STATE[1]),
        .I4(STATE[2]),
        .O(\n_0_FSM_sequential_STATE[2]_i_2 ));
LUT6 #(
    .INIT(64'h140E141400000000)) 
     \FSM_sequential_STATE[2]_i_3 
       (.I0(STATE[0]),
        .I1(STATE[1]),
        .I2(STATE[2]),
        .I3(GOOD_CGS[0]),
        .I4(GOOD_CGS[1]),
        .I5(\n_0_FSM_sequential_STATE[3]_i_4 ),
        .O(\n_0_FSM_sequential_STATE[2]_i_3 ));
LUT3 #(
    .INIT(8'hAB)) 
     \FSM_sequential_STATE[3]_i_1 
       (.I0(I1),
        .I1(SIGNAL_DETECT_REG),
        .I2(Q[1]),
        .O(\n_0_FSM_sequential_STATE[3]_i_1 ));
LUT6 #(
    .INIT(64'h0FB000B000C0C0F0)) 
     \FSM_sequential_STATE[3]_i_2 
       (.I0(\n_0_FSM_sequential_STATE[3]_i_3 ),
        .I1(\n_0_FSM_sequential_STATE[3]_i_4 ),
        .I2(STATE[3]),
        .I3(STATE[2]),
        .I4(STATE[1]),
        .I5(STATE[0]),
        .O(\n_0_FSM_sequential_STATE[3]_i_2 ));
LUT2 #(
    .INIT(4'hB)) 
     \FSM_sequential_STATE[3]_i_3 
       (.I0(GOOD_CGS[0]),
        .I1(GOOD_CGS[1]),
        .O(\n_0_FSM_sequential_STATE[3]_i_3 ));
LUT5 #(
    .INIT(32'h00000007)) 
     \FSM_sequential_STATE[3]_i_4 
       (.I0(I2),
        .I1(RXEVEN),
        .I2(p_0_in),
        .I3(D_1),
        .I4(RXNOTINTABLE_INT),
        .O(\n_0_FSM_sequential_STATE[3]_i_4 ));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_STATE_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_FSM_sequential_STATE_reg[0]_i_1 ),
        .Q(STATE[0]),
        .R(\n_0_FSM_sequential_STATE[3]_i_1 ));
MUXF7 \FSM_sequential_STATE_reg[0]_i_1 
       (.I0(\n_0_FSM_sequential_STATE[0]_i_2 ),
        .I1(\n_0_FSM_sequential_STATE[0]_i_3 ),
        .O(\n_0_FSM_sequential_STATE_reg[0]_i_1 ),
        .S(STATE[3]));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_STATE_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_FSM_sequential_STATE_reg[1]_i_1 ),
        .Q(STATE[1]),
        .R(\n_0_FSM_sequential_STATE[3]_i_1 ));
MUXF7 \FSM_sequential_STATE_reg[1]_i_1 
       (.I0(\n_0_FSM_sequential_STATE[1]_i_2 ),
        .I1(\n_0_FSM_sequential_STATE[1]_i_3 ),
        .O(\n_0_FSM_sequential_STATE_reg[1]_i_1 ),
        .S(STATE[3]));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_STATE_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_FSM_sequential_STATE_reg[2]_i_1 ),
        .Q(STATE[2]),
        .R(\n_0_FSM_sequential_STATE[3]_i_1 ));
MUXF7 \FSM_sequential_STATE_reg[2]_i_1 
       (.I0(\n_0_FSM_sequential_STATE[2]_i_2 ),
        .I1(\n_0_FSM_sequential_STATE[2]_i_3 ),
        .O(\n_0_FSM_sequential_STATE_reg[2]_i_1 ),
        .S(STATE[3]));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_STATE_reg[3] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_FSM_sequential_STATE[3]_i_2 ),
        .Q(STATE[3]),
        .R(\n_0_FSM_sequential_STATE[3]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair31" *) 
   LUT3 #(
    .INIT(8'h06)) 
     \GOOD_CGS[0]_i_1 
       (.I0(GOOD_CGS[0]),
        .I1(\n_0_FSM_sequential_STATE[3]_i_4 ),
        .I2(\n_0_GOOD_CGS[1]_i_2 ),
        .O(\n_0_GOOD_CGS[0]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair31" *) 
   LUT4 #(
    .INIT(16'h006A)) 
     \GOOD_CGS[1]_i_1 
       (.I0(GOOD_CGS[1]),
        .I1(\n_0_FSM_sequential_STATE[3]_i_4 ),
        .I2(GOOD_CGS[0]),
        .I3(\n_0_GOOD_CGS[1]_i_2 ),
        .O(\n_0_GOOD_CGS[1]_i_1 ));
LUT5 #(
    .INIT(32'hFFFF0580)) 
     \GOOD_CGS[1]_i_2 
       (.I0(STATE[0]),
        .I1(STATE[1]),
        .I2(STATE[2]),
        .I3(STATE[3]),
        .I4(I1),
        .O(\n_0_GOOD_CGS[1]_i_2 ));
FDRE \GOOD_CGS_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_GOOD_CGS[0]_i_1 ),
        .Q(GOOD_CGS[0]),
        .R(1'b0));
FDRE \GOOD_CGS_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_GOOD_CGS[1]_i_1 ),
        .Q(GOOD_CGS[1]),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair33" *) 
   LUT2 #(
    .INIT(4'h2)) 
     MASK_RUDI_CLKCOR_i_3
       (.I0(RXSYNC_STATUS),
        .I1(I3),
        .O(SYNC_STATUS_HELD));
LUT2 #(
    .INIT(4'h8)) 
     RX_DATA_ERROR_i_3
       (.I0(RXEVEN),
        .I1(K28p5_REG1),
        .O(O3));
(* SOFT_HLUTNM = "soft_lutpair35" *) 
   LUT2 #(
    .INIT(4'h1)) 
     RX_DV_i_3
       (.I0(RXSYNC_STATUS),
        .I1(I6),
        .O(O4));
(* SOFT_HLUTNM = "soft_lutpair33" *) 
   LUT3 #(
    .INIT(8'h40)) 
     RX_RUDI_INVALID_REG_i_1
       (.I0(I3),
        .I1(RXSYNC_STATUS),
        .I2(I4),
        .O(O1));
FDRE SIGNAL_DETECT_REG_reg
       (.C(CLK),
        .CE(1'b1),
        .D(SIGNAL_DETECT_MOD),
        .Q(SIGNAL_DETECT_REG),
        .R(1'b0));
LUT5 #(
    .INIT(32'h80888080)) 
     STATUS_VECTOR_0_PRE_i_1
       (.I0(data_out),
        .I1(RXSYNC_STATUS),
        .I2(XMIT_DATA_INT),
        .I3(Q[2]),
        .I4(Q[0]),
        .O(STATUS_VECTOR_0_PRE0));
(* SOFT_HLUTNM = "soft_lutpair32" *) 
   LUT3 #(
    .INIT(8'hF2)) 
     SYNC_STATUS_i_1
       (.I0(RXSYNC_STATUS),
        .I1(n_0_SYNC_STATUS_i_2),
        .I2(SYNC_STATUS0),
        .O(n_0_SYNC_STATUS_i_1));
LUT5 #(
    .INIT(32'h00000443)) 
     SYNC_STATUS_i_2
       (.I0(\n_0_FSM_sequential_STATE[3]_i_4 ),
        .I1(STATE[3]),
        .I2(STATE[1]),
        .I3(STATE[2]),
        .I4(STATE[0]),
        .O(n_0_SYNC_STATUS_i_2));
LUT6 #(
    .INIT(64'h0000100000000000)) 
     SYNC_STATUS_i_3
       (.I0(STATE[3]),
        .I1(STATE[1]),
        .I2(STATE[2]),
        .I3(STATE[0]),
        .I4(I5),
        .I5(\n_0_FSM_sequential_STATE[3]_i_4 ),
        .O(SYNC_STATUS0));
FDRE #(
    .INIT(1'b0)) 
     SYNC_STATUS_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_SYNC_STATUS_i_1),
        .Q(RXSYNC_STATUS),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "TX" *) 
module gmii_to_sgmiiTX__parameterized0
   (O1,
    D,
    O2,
    O3,
    O4,
    O5,
    O6,
    O7,
    O8,
    O9,
    O10,
    O11,
    O12,
    I1,
    CLK,
    XMIT_CONFIG,
    I2,
    I3,
    XMIT_DATA,
    Q,
    I4,
    rxcharisk,
    rxchariscomma,
    I5,
    I6,
    I7);
  output O1;
  output [3:0]D;
  output O2;
  output O3;
  output O4;
  output O5;
  output O6;
  output O7;
  output O8;
  output O9;
  output O10;
  output [7:0]O11;
  output O12;
  input I1;
  input CLK;
  input XMIT_CONFIG;
  input I2;
  input I3;
  input XMIT_DATA;
  input [1:0]Q;
  input I4;
  input rxcharisk;
  input rxchariscomma;
  input [7:0]I5;
  input [2:0]I6;
  input [7:0]I7;

  wire CLK;
  wire CODE_GRPISK;
  wire CONFIG_K28p5;
  wire [3:0]D;
  wire DISPARITY;
  wire I1;
  wire I2;
  wire I3;
  wire I4;
  wire [7:0]I5;
  wire [2:0]I6;
  wire [7:0]I7;
  wire K28p5;
  wire O1;
  wire O10;
  wire [7:0]O11;
  wire O12;
  wire O2;
  wire O3;
  wire O4;
  wire O5;
  wire O6;
  wire O7;
  wire O8;
  wire O9;
  wire [1:0]Q;
  wire S;
  wire S0;
  wire T;
  wire T0;
  wire TRIGGER_S;
  wire TRIGGER_S0;
  wire TRIGGER_T;
  wire TXCHARDISPMODE_INT;
  wire TXCHARDISPVAL;
  wire TXCHARISK_INT;
  wire [7:0]TXDATA;
  wire [7:0]TXD_REG1;
  wire [14:0]TX_CONFIG;
  wire TX_EN_REG1;
  wire TX_ER_REG1;
  wire TX_EVEN;
  wire XMIT_CONFIG;
  wire XMIT_CONFIG_INT;
  wire XMIT_DATA;
  wire XMIT_DATA_INT;
  wire n_0_C1_OR_C2_i_1;
  wire n_0_C1_OR_C2_reg;
  wire n_0_CODE_GRPISK_i_1;
  wire \n_0_CODE_GRP[0]_i_1 ;
  wire \n_0_CODE_GRP[0]_i_2 ;
  wire \n_0_CODE_GRP[1]_i_1 ;
  wire \n_0_CODE_GRP[1]_i_2 ;
  wire \n_0_CODE_GRP[2]_i_1 ;
  wire \n_0_CODE_GRP[2]_i_2 ;
  wire \n_0_CODE_GRP[3]_i_1 ;
  wire \n_0_CODE_GRP[3]_i_2 ;
  wire \n_0_CODE_GRP[4]_i_1 ;
  wire \n_0_CODE_GRP[5]_i_1 ;
  wire \n_0_CODE_GRP[6]_i_1 ;
  wire \n_0_CODE_GRP[6]_i_2 ;
  wire \n_0_CODE_GRP[7]_i_1 ;
  wire \n_0_CODE_GRP[7]_i_2 ;
  wire \n_0_CODE_GRP[7]_i_3 ;
  wire \n_0_CODE_GRP_CNT_reg[1] ;
  wire \n_0_CODE_GRP_reg[0] ;
  wire \n_0_CONFIG_DATA[0]_i_1 ;
  wire \n_0_CONFIG_DATA[1]_i_1 ;
  wire \n_0_CONFIG_DATA[2]_i_1 ;
  wire \n_0_CONFIG_DATA[3]_i_1 ;
  wire \n_0_CONFIG_DATA[6]_i_1 ;
  wire \n_0_CONFIG_DATA_reg[0] ;
  wire \n_0_CONFIG_DATA_reg[1] ;
  wire \n_0_CONFIG_DATA_reg[2] ;
  wire \n_0_CONFIG_DATA_reg[3] ;
  wire \n_0_CONFIG_DATA_reg[6] ;
  wire n_0_INSERT_IDLE_i_1;
  wire n_0_INSERT_IDLE_reg;
  wire n_0_K28p5_i_1;
  wire \n_0_NO_QSGMII_CHAR.TXCHARDISPVAL_i_1 ;
  wire \n_0_NO_QSGMII_DATA.TXCHARISK_i_1 ;
  wire \n_0_NO_QSGMII_DATA.TXDATA[0]_i_1 ;
  wire \n_0_NO_QSGMII_DATA.TXDATA[1]_i_1 ;
  wire \n_0_NO_QSGMII_DATA.TXDATA[2]_i_1 ;
  wire \n_0_NO_QSGMII_DATA.TXDATA[3]_i_1 ;
  wire \n_0_NO_QSGMII_DATA.TXDATA[4]_i_1 ;
  wire \n_0_NO_QSGMII_DATA.TXDATA[5]_i_1 ;
  wire \n_0_NO_QSGMII_DATA.TXDATA[6]_i_1 ;
  wire \n_0_NO_QSGMII_DATA.TXDATA[7]_i_1 ;
  wire \n_0_NO_QSGMII_DISP.DISPARITY_i_1 ;
  wire \n_0_NO_QSGMII_DISP.DISPARITY_i_2 ;
  wire \n_0_NO_QSGMII_DISP.DISPARITY_i_3 ;
  wire n_0_R_i_1__0;
  wire n_0_R_reg;
  wire n_0_SYNC_DISPARITY_i_1;
  wire n_0_SYNC_DISPARITY_reg;
  wire n_0_TX_PACKET_i_1;
  wire n_0_V_i_1;
  wire n_0_V_i_3;
  wire n_0_V_reg;
  wire n_0_XMIT_DATA_INT_reg;
  wire p_0_in;
  wire p_0_in18_in;
  wire p_0_in37_in;
  wire p_12_out;
  wire p_1_in;
  wire p_1_in1_in;
  wire p_1_in36_in;
  wire p_35_in;
  wire p_49_in;
  wire [1:0]plusOp;
  wire rxchariscomma;
  wire rxcharisk;

(* SOFT_HLUTNM = "soft_lutpair45" *) 
   LUT4 #(
    .INIT(16'h3F80)) 
     C1_OR_C2_i_1
       (.I0(XMIT_CONFIG_INT),
        .I1(\n_0_CODE_GRP_CNT_reg[1] ),
        .I2(TX_EVEN),
        .I3(n_0_C1_OR_C2_reg),
        .O(n_0_C1_OR_C2_i_1));
FDRE C1_OR_C2_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_C1_OR_C2_i_1),
        .Q(n_0_C1_OR_C2_reg),
        .R(I1));
LUT6 #(
    .INIT(64'h30303030FFFF55FF)) 
     CODE_GRPISK_i_1
       (.I0(O1),
        .I1(\n_0_CODE_GRP_CNT_reg[1] ),
        .I2(TX_EVEN),
        .I3(\n_0_CODE_GRP[6]_i_2 ),
        .I4(Q[1]),
        .I5(XMIT_CONFIG_INT),
        .O(n_0_CODE_GRPISK_i_1));
FDRE CODE_GRPISK_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_CODE_GRPISK_i_1),
        .Q(CODE_GRPISK),
        .R(1'b0));
LUT6 #(
    .INIT(64'hFFFF000031003100)) 
     \CODE_GRP[0]_i_1 
       (.I0(n_0_V_reg),
        .I1(Q[1]),
        .I2(S),
        .I3(\n_0_CODE_GRP[0]_i_2 ),
        .I4(\n_0_CONFIG_DATA_reg[0] ),
        .I5(XMIT_CONFIG_INT),
        .O(\n_0_CODE_GRP[0]_i_1 ));
LUT5 #(
    .INIT(32'hFFFEFEFE)) 
     \CODE_GRP[0]_i_2 
       (.I0(S),
        .I1(n_0_R_reg),
        .I2(T),
        .I3(TXD_REG1[0]),
        .I4(O1),
        .O(\n_0_CODE_GRP[0]_i_2 ));
LUT4 #(
    .INIT(16'hF011)) 
     \CODE_GRP[1]_i_1 
       (.I0(\n_0_CODE_GRP[1]_i_2 ),
        .I1(Q[1]),
        .I2(\n_0_CONFIG_DATA_reg[1] ),
        .I3(XMIT_CONFIG_INT),
        .O(\n_0_CODE_GRP[1]_i_1 ));
LUT6 #(
    .INIT(64'h1111111100000111)) 
     \CODE_GRP[1]_i_2 
       (.I0(n_0_V_reg),
        .I1(S),
        .I2(TXD_REG1[1]),
        .I3(O1),
        .I4(n_0_R_reg),
        .I5(T),
        .O(\n_0_CODE_GRP[1]_i_2 ));
LUT5 #(
    .INIT(32'h8A8A808A)) 
     \CODE_GRP[2]_i_1 
       (.I0(\n_0_CODE_GRP[2]_i_2 ),
        .I1(\n_0_CONFIG_DATA_reg[2] ),
        .I2(XMIT_CONFIG_INT),
        .I3(S),
        .I4(Q[1]),
        .O(\n_0_CODE_GRP[2]_i_1 ));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFD)) 
     \CODE_GRP[2]_i_2 
       (.I0(O1),
        .I1(n_0_V_reg),
        .I2(\n_0_CODE_GRP[7]_i_3 ),
        .I3(T),
        .I4(TXD_REG1[2]),
        .I5(n_0_R_reg),
        .O(\n_0_CODE_GRP[2]_i_2 ));
LUT6 #(
    .INIT(64'hD0DDD0D0D0DDD0DD)) 
     \CODE_GRP[3]_i_1 
       (.I0(XMIT_CONFIG_INT),
        .I1(\n_0_CONFIG_DATA_reg[3] ),
        .I2(\n_0_CODE_GRP[3]_i_2 ),
        .I3(n_0_R_reg),
        .I4(TXD_REG1[3]),
        .I5(O1),
        .O(\n_0_CODE_GRP[3]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair37" *) 
   LUT5 #(
    .INIT(32'hFFFFFFFE)) 
     \CODE_GRP[3]_i_2 
       (.I0(n_0_V_reg),
        .I1(S),
        .I2(Q[1]),
        .I3(XMIT_CONFIG_INT),
        .I4(T),
        .O(\n_0_CODE_GRP[3]_i_2 ));
(* SOFT_HLUTNM = "soft_lutpair38" *) 
   LUT4 #(
    .INIT(16'hDDD0)) 
     \CODE_GRP[4]_i_1 
       (.I0(XMIT_CONFIG_INT),
        .I1(\n_0_CONFIG_DATA_reg[2] ),
        .I2(\n_0_CODE_GRP[7]_i_2 ),
        .I3(TXD_REG1[4]),
        .O(\n_0_CODE_GRP[4]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair38" *) 
   LUT4 #(
    .INIT(16'hDDD0)) 
     \CODE_GRP[5]_i_1 
       (.I0(XMIT_CONFIG_INT),
        .I1(\n_0_CONFIG_DATA_reg[2] ),
        .I2(\n_0_CODE_GRP[7]_i_2 ),
        .I3(TXD_REG1[5]),
        .O(\n_0_CODE_GRP[5]_i_1 ));
LUT6 #(
    .INIT(64'hFFFF000000D500D5)) 
     \CODE_GRP[6]_i_1 
       (.I0(\n_0_CODE_GRP[6]_i_2 ),
        .I1(TXD_REG1[6]),
        .I2(O1),
        .I3(Q[1]),
        .I4(\n_0_CONFIG_DATA_reg[6] ),
        .I5(XMIT_CONFIG_INT),
        .O(\n_0_CODE_GRP[6]_i_1 ));
LUT4 #(
    .INIT(16'h0001)) 
     \CODE_GRP[6]_i_2 
       (.I0(n_0_V_reg),
        .I1(T),
        .I2(n_0_R_reg),
        .I3(S),
        .O(\n_0_CODE_GRP[6]_i_2 ));
LUT4 #(
    .INIT(16'hDDD0)) 
     \CODE_GRP[7]_i_1 
       (.I0(XMIT_CONFIG_INT),
        .I1(\n_0_CONFIG_DATA_reg[2] ),
        .I2(\n_0_CODE_GRP[7]_i_2 ),
        .I3(TXD_REG1[7]),
        .O(\n_0_CODE_GRP[7]_i_1 ));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFEFF)) 
     \CODE_GRP[7]_i_2 
       (.I0(S),
        .I1(n_0_R_reg),
        .I2(T),
        .I3(O1),
        .I4(n_0_V_reg),
        .I5(\n_0_CODE_GRP[7]_i_3 ),
        .O(\n_0_CODE_GRP[7]_i_2 ));
(* SOFT_HLUTNM = "soft_lutpair37" *) 
   LUT2 #(
    .INIT(4'hE)) 
     \CODE_GRP[7]_i_3 
       (.I0(Q[1]),
        .I1(XMIT_CONFIG_INT),
        .O(\n_0_CODE_GRP[7]_i_3 ));
LUT1 #(
    .INIT(2'h1)) 
     \CODE_GRP_CNT[0]_i_1 
       (.I0(TX_EVEN),
        .O(plusOp[0]));
(* SOFT_HLUTNM = "soft_lutpair59" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \CODE_GRP_CNT[1]_i_1 
       (.I0(\n_0_CODE_GRP_CNT_reg[1] ),
        .I1(TX_EVEN),
        .O(plusOp[1]));
FDSE \CODE_GRP_CNT_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(plusOp[0]),
        .Q(TX_EVEN),
        .S(I1));
FDSE \CODE_GRP_CNT_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(plusOp[1]),
        .Q(\n_0_CODE_GRP_CNT_reg[1] ),
        .S(I1));
FDRE \CODE_GRP_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_CODE_GRP[0]_i_1 ),
        .Q(\n_0_CODE_GRP_reg[0] ),
        .R(1'b0));
FDRE \CODE_GRP_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_CODE_GRP[1]_i_1 ),
        .Q(p_1_in),
        .R(1'b0));
FDRE \CODE_GRP_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_CODE_GRP[2]_i_1 ),
        .Q(p_0_in18_in),
        .R(1'b0));
FDRE \CODE_GRP_reg[3] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_CODE_GRP[3]_i_1 ),
        .Q(p_0_in),
        .R(1'b0));
FDRE \CODE_GRP_reg[4] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_CODE_GRP[4]_i_1 ),
        .Q(p_1_in1_in),
        .R(1'b0));
FDRE \CODE_GRP_reg[5] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_CODE_GRP[5]_i_1 ),
        .Q(p_1_in36_in),
        .R(1'b0));
FDRE \CODE_GRP_reg[6] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_CODE_GRP[6]_i_1 ),
        .Q(p_35_in),
        .R(1'b0));
FDRE \CODE_GRP_reg[7] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_CODE_GRP[7]_i_1 ),
        .Q(p_0_in37_in),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair47" *) 
   LUT4 #(
    .INIT(16'h3404)) 
     \CONFIG_DATA[0]_i_1 
       (.I0(n_0_C1_OR_C2_reg),
        .I1(TX_EVEN),
        .I2(\n_0_CODE_GRP_CNT_reg[1] ),
        .I3(TX_CONFIG[0]),
        .O(\n_0_CONFIG_DATA[0]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair57" *) 
   LUT3 #(
    .INIT(8'h20)) 
     \CONFIG_DATA[1]_i_1 
       (.I0(n_0_C1_OR_C2_reg),
        .I1(\n_0_CODE_GRP_CNT_reg[1] ),
        .I2(TX_EVEN),
        .O(\n_0_CONFIG_DATA[1]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair47" *) 
   LUT3 #(
    .INIT(8'h07)) 
     \CONFIG_DATA[2]_i_1 
       (.I0(TX_EVEN),
        .I1(n_0_C1_OR_C2_reg),
        .I2(\n_0_CODE_GRP_CNT_reg[1] ),
        .O(\n_0_CONFIG_DATA[2]_i_1 ));
LUT3 #(
    .INIT(8'h83)) 
     \CONFIG_DATA[3]_i_1 
       (.I0(TX_CONFIG[11]),
        .I1(TX_EVEN),
        .I2(\n_0_CODE_GRP_CNT_reg[1] ),
        .O(\n_0_CONFIG_DATA[3]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair45" *) 
   LUT4 #(
    .INIT(16'hE020)) 
     \CONFIG_DATA[6]_i_1 
       (.I0(n_0_C1_OR_C2_reg),
        .I1(\n_0_CODE_GRP_CNT_reg[1] ),
        .I2(TX_EVEN),
        .I3(TX_CONFIG[14]),
        .O(\n_0_CONFIG_DATA[6]_i_1 ));
FDRE \CONFIG_DATA_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_CONFIG_DATA[0]_i_1 ),
        .Q(\n_0_CONFIG_DATA_reg[0] ),
        .R(I1));
FDRE \CONFIG_DATA_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_CONFIG_DATA[1]_i_1 ),
        .Q(\n_0_CONFIG_DATA_reg[1] ),
        .R(I1));
FDRE \CONFIG_DATA_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_CONFIG_DATA[2]_i_1 ),
        .Q(\n_0_CONFIG_DATA_reg[2] ),
        .R(I1));
FDRE \CONFIG_DATA_reg[3] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_CONFIG_DATA[3]_i_1 ),
        .Q(\n_0_CONFIG_DATA_reg[3] ),
        .R(I1));
FDRE \CONFIG_DATA_reg[6] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_CONFIG_DATA[6]_i_1 ),
        .Q(\n_0_CONFIG_DATA_reg[6] ),
        .R(I1));
FDRE CONFIG_K28p5_reg
       (.C(CLK),
        .CE(1'b1),
        .D(XMIT_DATA_INT),
        .Q(CONFIG_K28p5),
        .R(I1));
(* SOFT_HLUTNM = "soft_lutpair39" *) 
   LUT4 #(
    .INIT(16'h00F2)) 
     INSERT_IDLE_i_1
       (.I0(\n_0_CODE_GRP[6]_i_2 ),
        .I1(O1),
        .I2(Q[1]),
        .I3(XMIT_CONFIG_INT),
        .O(n_0_INSERT_IDLE_i_1));
FDRE INSERT_IDLE_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_INSERT_IDLE_i_1),
        .Q(n_0_INSERT_IDLE_reg),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair39" *) 
   LUT2 #(
    .INIT(4'h8)) 
     K28p5_i_1
       (.I0(XMIT_CONFIG_INT),
        .I1(CONFIG_K28p5),
        .O(n_0_K28p5_i_1));
FDRE K28p5_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_K28p5_i_1),
        .Q(K28p5),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair59" *) 
   LUT2 #(
    .INIT(4'h2)) 
     \NO_QSGMII_CHAR.TXCHARDISPMODE_i_1 
       (.I0(n_0_SYNC_DISPARITY_reg),
        .I1(TX_EVEN),
        .O(p_12_out));
FDSE \NO_QSGMII_CHAR.TXCHARDISPMODE_reg 
       (.C(CLK),
        .CE(1'b1),
        .D(p_12_out),
        .Q(TXCHARDISPMODE_INT),
        .S(I1));
(* SOFT_HLUTNM = "soft_lutpair57" *) 
   LUT3 #(
    .INIT(8'h40)) 
     \NO_QSGMII_CHAR.TXCHARDISPVAL_i_1 
       (.I0(TX_EVEN),
        .I1(n_0_SYNC_DISPARITY_reg),
        .I2(DISPARITY),
        .O(\n_0_NO_QSGMII_CHAR.TXCHARDISPVAL_i_1 ));
FDRE \NO_QSGMII_CHAR.TXCHARDISPVAL_reg 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_NO_QSGMII_CHAR.TXCHARDISPVAL_i_1 ),
        .Q(TXCHARDISPVAL),
        .R(I1));
(* SOFT_HLUTNM = "soft_lutpair40" *) 
   LUT4 #(
    .INIT(16'h002A)) 
     \NO_QSGMII_DATA.TXCHARISK_i_1 
       (.I0(CODE_GRPISK),
        .I1(TX_EVEN),
        .I2(n_0_INSERT_IDLE_reg),
        .I3(I1),
        .O(\n_0_NO_QSGMII_DATA.TXCHARISK_i_1 ));
FDRE \NO_QSGMII_DATA.TXCHARISK_reg 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_NO_QSGMII_DATA.TXCHARISK_i_1 ),
        .Q(TXCHARISK_INT),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair44" *) 
   LUT4 #(
    .INIT(16'hBF80)) 
     \NO_QSGMII_DATA.TXDATA[0]_i_1 
       (.I0(DISPARITY),
        .I1(TX_EVEN),
        .I2(n_0_INSERT_IDLE_reg),
        .I3(\n_0_CODE_GRP_reg[0] ),
        .O(\n_0_NO_QSGMII_DATA.TXDATA[0]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair42" *) 
   LUT4 #(
    .INIT(16'h002A)) 
     \NO_QSGMII_DATA.TXDATA[1]_i_1 
       (.I0(p_1_in),
        .I1(TX_EVEN),
        .I2(n_0_INSERT_IDLE_reg),
        .I3(I1),
        .O(\n_0_NO_QSGMII_DATA.TXDATA[1]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair44" *) 
   LUT4 #(
    .INIT(16'hBF80)) 
     \NO_QSGMII_DATA.TXDATA[2]_i_1 
       (.I0(DISPARITY),
        .I1(TX_EVEN),
        .I2(n_0_INSERT_IDLE_reg),
        .I3(p_0_in18_in),
        .O(\n_0_NO_QSGMII_DATA.TXDATA[2]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair41" *) 
   LUT4 #(
    .INIT(16'h002A)) 
     \NO_QSGMII_DATA.TXDATA[3]_i_1 
       (.I0(p_0_in),
        .I1(TX_EVEN),
        .I2(n_0_INSERT_IDLE_reg),
        .I3(I1),
        .O(\n_0_NO_QSGMII_DATA.TXDATA[3]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair43" *) 
   LUT4 #(
    .INIT(16'h7F40)) 
     \NO_QSGMII_DATA.TXDATA[4]_i_1 
       (.I0(DISPARITY),
        .I1(TX_EVEN),
        .I2(n_0_INSERT_IDLE_reg),
        .I3(p_1_in1_in),
        .O(\n_0_NO_QSGMII_DATA.TXDATA[4]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair41" *) 
   LUT4 #(
    .INIT(16'h002A)) 
     \NO_QSGMII_DATA.TXDATA[5]_i_1 
       (.I0(p_1_in36_in),
        .I1(TX_EVEN),
        .I2(n_0_INSERT_IDLE_reg),
        .I3(I1),
        .O(\n_0_NO_QSGMII_DATA.TXDATA[5]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair40" *) 
   LUT4 #(
    .INIT(16'h5540)) 
     \NO_QSGMII_DATA.TXDATA[6]_i_1 
       (.I0(I1),
        .I1(TX_EVEN),
        .I2(n_0_INSERT_IDLE_reg),
        .I3(p_35_in),
        .O(\n_0_NO_QSGMII_DATA.TXDATA[6]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair43" *) 
   LUT4 #(
    .INIT(16'hBF80)) 
     \NO_QSGMII_DATA.TXDATA[7]_i_1 
       (.I0(DISPARITY),
        .I1(TX_EVEN),
        .I2(n_0_INSERT_IDLE_reg),
        .I3(p_0_in37_in),
        .O(\n_0_NO_QSGMII_DATA.TXDATA[7]_i_1 ));
FDRE \NO_QSGMII_DATA.TXDATA_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_NO_QSGMII_DATA.TXDATA[0]_i_1 ),
        .Q(TXDATA[0]),
        .R(I1));
FDRE \NO_QSGMII_DATA.TXDATA_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_NO_QSGMII_DATA.TXDATA[1]_i_1 ),
        .Q(TXDATA[1]),
        .R(1'b0));
FDRE \NO_QSGMII_DATA.TXDATA_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_NO_QSGMII_DATA.TXDATA[2]_i_1 ),
        .Q(TXDATA[2]),
        .R(I1));
FDRE \NO_QSGMII_DATA.TXDATA_reg[3] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_NO_QSGMII_DATA.TXDATA[3]_i_1 ),
        .Q(TXDATA[3]),
        .R(1'b0));
FDRE \NO_QSGMII_DATA.TXDATA_reg[4] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_NO_QSGMII_DATA.TXDATA[4]_i_1 ),
        .Q(TXDATA[4]),
        .R(I1));
FDRE \NO_QSGMII_DATA.TXDATA_reg[5] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_NO_QSGMII_DATA.TXDATA[5]_i_1 ),
        .Q(TXDATA[5]),
        .R(1'b0));
FDRE \NO_QSGMII_DATA.TXDATA_reg[6] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_NO_QSGMII_DATA.TXDATA[6]_i_1 ),
        .Q(TXDATA[6]),
        .R(1'b0));
FDRE \NO_QSGMII_DATA.TXDATA_reg[7] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_NO_QSGMII_DATA.TXDATA[7]_i_1 ),
        .Q(TXDATA[7]),
        .R(I1));
LUT6 #(
    .INIT(64'h0009090900F6F6F6)) 
     \NO_QSGMII_DISP.DISPARITY_i_1 
       (.I0(\n_0_NO_QSGMII_DISP.DISPARITY_i_2 ),
        .I1(\n_0_NO_QSGMII_DISP.DISPARITY_i_3 ),
        .I2(K28p5),
        .I3(n_0_INSERT_IDLE_reg),
        .I4(TX_EVEN),
        .I5(DISPARITY),
        .O(\n_0_NO_QSGMII_DISP.DISPARITY_i_1 ));
LUT5 #(
    .INIT(32'hE8818157)) 
     \NO_QSGMII_DISP.DISPARITY_i_2 
       (.I0(p_0_in18_in),
        .I1(p_0_in),
        .I2(p_1_in1_in),
        .I3(\n_0_CODE_GRP_reg[0] ),
        .I4(p_1_in),
        .O(\n_0_NO_QSGMII_DISP.DISPARITY_i_2 ));
LUT3 #(
    .INIT(8'h83)) 
     \NO_QSGMII_DISP.DISPARITY_i_3 
       (.I0(p_0_in37_in),
        .I1(p_1_in36_in),
        .I2(p_35_in),
        .O(\n_0_NO_QSGMII_DISP.DISPARITY_i_3 ));
FDSE \NO_QSGMII_DISP.DISPARITY_reg 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_NO_QSGMII_DISP.DISPARITY_i_1 ),
        .Q(DISPARITY),
        .S(I1));
LUT6 #(
    .INIT(64'h0D0D0D0C0C0C0C0C)) 
     R_i_1__0
       (.I0(S),
        .I1(T),
        .I2(I1),
        .I3(TX_ER_REG1),
        .I4(TX_EVEN),
        .I5(n_0_R_reg),
        .O(n_0_R_i_1__0));
FDRE R_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_R_i_1__0),
        .Q(n_0_R_reg),
        .R(1'b0));
LUT6 #(
    .INIT(64'h2F202F2F2F202F20)) 
     SYNC_DISPARITY_i_1
       (.I0(TX_EVEN),
        .I1(\n_0_CODE_GRP_CNT_reg[1] ),
        .I2(XMIT_CONFIG_INT),
        .I3(Q[1]),
        .I4(O1),
        .I5(\n_0_CODE_GRP[6]_i_2 ),
        .O(n_0_SYNC_DISPARITY_i_1));
FDRE SYNC_DISPARITY_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_SYNC_DISPARITY_i_1),
        .Q(n_0_SYNC_DISPARITY_reg),
        .R(1'b0));
LUT6 #(
    .INIT(64'h8888A8AA88888888)) 
     S_i_1__0
       (.I0(n_0_XMIT_DATA_INT_reg),
        .I1(TRIGGER_S),
        .I2(TX_ER_REG1),
        .I3(TX_EVEN),
        .I4(TX_EN_REG1),
        .I5(I3),
        .O(S0));
FDRE S_reg
       (.C(CLK),
        .CE(1'b1),
        .D(S0),
        .Q(S),
        .R(I1));
(* SOFT_HLUTNM = "soft_lutpair48" *) 
   LUT4 #(
    .INIT(16'h0400)) 
     TRIGGER_S_i_1
       (.I0(TX_EN_REG1),
        .I1(I3),
        .I2(TX_ER_REG1),
        .I3(TX_EVEN),
        .O(TRIGGER_S0));
FDRE TRIGGER_S_reg
       (.C(CLK),
        .CE(1'b1),
        .D(TRIGGER_S0),
        .Q(TRIGGER_S),
        .R(I1));
(* SOFT_HLUTNM = "soft_lutpair48" *) 
   LUT2 #(
    .INIT(4'h2)) 
     TRIGGER_T_i_1
       (.I0(TX_EN_REG1),
        .I1(I3),
        .O(p_49_in));
FDRE TRIGGER_T_reg
       (.C(CLK),
        .CE(1'b1),
        .D(p_49_in),
        .Q(TRIGGER_T),
        .R(I1));
FDRE \TXD_REG1_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(I7[0]),
        .Q(TXD_REG1[0]),
        .R(1'b0));
FDRE \TXD_REG1_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(I7[1]),
        .Q(TXD_REG1[1]),
        .R(1'b0));
FDRE \TXD_REG1_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .D(I7[2]),
        .Q(TXD_REG1[2]),
        .R(1'b0));
FDRE \TXD_REG1_reg[3] 
       (.C(CLK),
        .CE(1'b1),
        .D(I7[3]),
        .Q(TXD_REG1[3]),
        .R(1'b0));
FDRE \TXD_REG1_reg[4] 
       (.C(CLK),
        .CE(1'b1),
        .D(I7[4]),
        .Q(TXD_REG1[4]),
        .R(1'b0));
FDRE \TXD_REG1_reg[5] 
       (.C(CLK),
        .CE(1'b1),
        .D(I7[5]),
        .Q(TXD_REG1[5]),
        .R(1'b0));
FDRE \TXD_REG1_reg[6] 
       (.C(CLK),
        .CE(1'b1),
        .D(I7[6]),
        .Q(TXD_REG1[6]),
        .R(1'b0));
FDRE \TXD_REG1_reg[7] 
       (.C(CLK),
        .CE(1'b1),
        .D(I7[7]),
        .Q(TXD_REG1[7]),
        .R(1'b0));
LUT2 #(
    .INIT(4'h1)) 
     \TX_CONFIG[14]_i_1 
       (.I0(\n_0_CODE_GRP_CNT_reg[1] ),
        .I1(TX_EVEN),
        .O(XMIT_DATA_INT));
FDRE \TX_CONFIG_reg[0] 
       (.C(CLK),
        .CE(XMIT_DATA_INT),
        .D(I6[0]),
        .Q(TX_CONFIG[0]),
        .R(I1));
FDRE \TX_CONFIG_reg[11] 
       (.C(CLK),
        .CE(XMIT_DATA_INT),
        .D(I6[1]),
        .Q(TX_CONFIG[11]),
        .R(I1));
FDRE \TX_CONFIG_reg[14] 
       (.C(CLK),
        .CE(XMIT_DATA_INT),
        .D(I6[2]),
        .Q(TX_CONFIG[14]),
        .R(I1));
FDRE TX_EN_REG1_reg
       (.C(CLK),
        .CE(1'b1),
        .D(I3),
        .Q(TX_EN_REG1),
        .R(1'b0));
FDRE TX_ER_REG1_reg
       (.C(CLK),
        .CE(1'b1),
        .D(I2),
        .Q(TX_ER_REG1),
        .R(1'b0));
LUT4 #(
    .INIT(16'h5150)) 
     TX_PACKET_i_1
       (.I0(I1),
        .I1(T),
        .I2(S),
        .I3(O1),
        .O(n_0_TX_PACKET_i_1));
FDRE TX_PACKET_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_TX_PACKET_i_1),
        .Q(O1),
        .R(1'b0));
LUT6 #(
    .INIT(64'h88888888FFF88888)) 
     T_i_1__0
       (.I0(n_0_V_reg),
        .I1(TRIGGER_T),
        .I2(S),
        .I3(O1),
        .I4(TX_EN_REG1),
        .I5(I3),
        .O(T0));
FDRE T_reg
       (.C(CLK),
        .CE(1'b1),
        .D(T0),
        .Q(T),
        .R(I1));
(* SOFT_HLUTNM = "soft_lutpair55" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \USE_ROCKET_IO.NO_1588.RXCHARISCOMMA_INT_i_1 
       (.I0(TXCHARISK_INT),
        .I1(Q[0]),
        .I2(rxchariscomma),
        .O(O10));
(* SOFT_HLUTNM = "soft_lutpair58" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \USE_ROCKET_IO.NO_1588.RXCHARISK_INT_i_1 
       (.I0(TXCHARISK_INT),
        .I1(Q[0]),
        .I2(rxcharisk),
        .O(O9));
(* SOFT_HLUTNM = "soft_lutpair52" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \USE_ROCKET_IO.NO_1588.RXDATA_INT[0]_i_1 
       (.I0(TXDATA[0]),
        .I1(Q[0]),
        .I2(I5[0]),
        .O(O11[0]));
(* SOFT_HLUTNM = "soft_lutpair56" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \USE_ROCKET_IO.NO_1588.RXDATA_INT[1]_i_1 
       (.I0(TXDATA[1]),
        .I1(Q[0]),
        .I2(I5[1]),
        .O(O11[1]));
(* SOFT_HLUTNM = "soft_lutpair54" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \USE_ROCKET_IO.NO_1588.RXDATA_INT[2]_i_1 
       (.I0(TXDATA[2]),
        .I1(Q[0]),
        .I2(I5[2]),
        .O(O11[2]));
(* SOFT_HLUTNM = "soft_lutpair51" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \USE_ROCKET_IO.NO_1588.RXDATA_INT[3]_i_1 
       (.I0(TXDATA[3]),
        .I1(Q[0]),
        .I2(I5[3]),
        .O(O11[3]));
LUT3 #(
    .INIT(8'hB8)) 
     \USE_ROCKET_IO.NO_1588.RXDATA_INT[4]_i_1 
       (.I0(TXDATA[4]),
        .I1(Q[0]),
        .I2(I5[4]),
        .O(O11[4]));
(* SOFT_HLUTNM = "soft_lutpair50" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \USE_ROCKET_IO.NO_1588.RXDATA_INT[5]_i_1 
       (.I0(TXDATA[5]),
        .I1(Q[0]),
        .I2(I5[5]),
        .O(O11[5]));
(* SOFT_HLUTNM = "soft_lutpair58" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \USE_ROCKET_IO.NO_1588.RXDATA_INT[6]_i_1 
       (.I0(TXDATA[6]),
        .I1(Q[0]),
        .I2(I5[6]),
        .O(O11[6]));
(* SOFT_HLUTNM = "soft_lutpair49" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \USE_ROCKET_IO.NO_1588.RXDATA_INT[7]_i_1 
       (.I0(TXDATA[7]),
        .I1(Q[0]),
        .I2(I5[7]),
        .O(O11[7]));
(* SOFT_HLUTNM = "soft_lutpair46" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \USE_ROCKET_IO.TXCHARDISPMODE_i_1 
       (.I0(TX_EVEN),
        .I1(Q[0]),
        .I2(TXCHARDISPMODE_INT),
        .O(O3));
(* SOFT_HLUTNM = "soft_lutpair53" *) 
   LUT3 #(
    .INIT(8'h02)) 
     \USE_ROCKET_IO.TXCHARDISPVAL_i_1 
       (.I0(TXCHARDISPVAL),
        .I1(Q[0]),
        .I2(I1),
        .O(O2));
(* SOFT_HLUTNM = "soft_lutpair55" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \USE_ROCKET_IO.TXCHARISK_i_1 
       (.I0(TX_EVEN),
        .I1(Q[0]),
        .I2(TXCHARISK_INT),
        .O(O8));
(* SOFT_HLUTNM = "soft_lutpair52" *) 
   LUT3 #(
    .INIT(8'h02)) 
     \USE_ROCKET_IO.TXDATA[0]_i_1 
       (.I0(TXDATA[0]),
        .I1(Q[0]),
        .I2(I1),
        .O(D[0]));
(* SOFT_HLUTNM = "soft_lutpair56" *) 
   LUT3 #(
    .INIT(8'h02)) 
     \USE_ROCKET_IO.TXDATA[1]_i_1 
       (.I0(TXDATA[1]),
        .I1(Q[0]),
        .I2(I1),
        .O(D[1]));
(* SOFT_HLUTNM = "soft_lutpair54" *) 
   LUT3 #(
    .INIT(8'h02)) 
     \USE_ROCKET_IO.TXDATA[2]_i_1 
       (.I0(TXDATA[2]),
        .I1(Q[0]),
        .I2(I1),
        .O(O7));
(* SOFT_HLUTNM = "soft_lutpair51" *) 
   LUT3 #(
    .INIT(8'h02)) 
     \USE_ROCKET_IO.TXDATA[3]_i_1 
       (.I0(TXDATA[3]),
        .I1(Q[0]),
        .I2(I1),
        .O(O6));
(* SOFT_HLUTNM = "soft_lutpair53" *) 
   LUT3 #(
    .INIT(8'h54)) 
     \USE_ROCKET_IO.TXDATA[4]_i_1 
       (.I0(I1),
        .I1(TXDATA[4]),
        .I2(Q[0]),
        .O(D[2]));
(* SOFT_HLUTNM = "soft_lutpair50" *) 
   LUT3 #(
    .INIT(8'h02)) 
     \USE_ROCKET_IO.TXDATA[5]_i_1 
       (.I0(TXDATA[5]),
        .I1(Q[0]),
        .I2(I1),
        .O(O5));
(* SOFT_HLUTNM = "soft_lutpair46" *) 
   LUT4 #(
    .INIT(16'h003A)) 
     \USE_ROCKET_IO.TXDATA[6]_i_1 
       (.I0(TXDATA[6]),
        .I1(TX_EVEN),
        .I2(Q[0]),
        .I3(I1),
        .O(D[3]));
(* SOFT_HLUTNM = "soft_lutpair42" *) 
   LUT3 #(
    .INIT(8'h08)) 
     \USE_ROCKET_IO.TXDATA[7]_i_1 
       (.I0(Q[0]),
        .I1(TX_EVEN),
        .I2(I1),
        .O(O12));
(* SOFT_HLUTNM = "soft_lutpair49" *) 
   LUT3 #(
    .INIT(8'h02)) 
     \USE_ROCKET_IO.TXDATA[7]_i_2 
       (.I0(TXDATA[7]),
        .I1(Q[0]),
        .I2(I1),
        .O(O4));
LUT6 #(
    .INIT(64'h00FF00D000D000D0)) 
     V_i_1
       (.I0(I4),
        .I1(n_0_V_i_3),
        .I2(n_0_XMIT_DATA_INT_reg),
        .I3(I1),
        .I4(S),
        .I5(n_0_V_reg),
        .O(n_0_V_i_1));
LUT3 #(
    .INIT(8'h40)) 
     V_i_3
       (.I0(O1),
        .I1(TX_ER_REG1),
        .I2(TX_EN_REG1),
        .O(n_0_V_i_3));
FDRE V_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_V_i_1),
        .Q(n_0_V_reg),
        .R(1'b0));
FDSE XMIT_CONFIG_INT_reg
       (.C(CLK),
        .CE(XMIT_DATA_INT),
        .D(XMIT_CONFIG),
        .Q(XMIT_CONFIG_INT),
        .S(I1));
FDRE XMIT_DATA_INT_reg
       (.C(CLK),
        .CE(XMIT_DATA_INT),
        .D(XMIT_DATA),
        .Q(n_0_XMIT_DATA_INT_reg),
        .R(I1));
endmodule

(* ORIG_REF_NAME = "gig_ethernet_pcs_pma_v14_2" *) 
module gmii_to_sgmiigig_ethernet_pcs_pma_v14_2__parameterized0
   (rxreset,
    mgt_tx_reset,
    RX_ER,
    status_vector,
    D,
    O1,
    O2,
    O3,
    encommaalign,
    an_interrupt,
    O4,
    Q,
    O5,
    O6,
    O7,
    O8,
    CLK,
    AS,
    I1,
    I2,
    rxnotintable_usr,
    rxbuferr,
    txbuferr,
    rxdisperr_usr,
    an_restart_config,
    I3,
    an_adv_config_vector,
    I4,
    rx_dv_reg1,
    data_out,
    rxcharisk,
    rxchariscomma,
    I5,
    signal_detect,
    configuration_vector,
    I6,
    I7);
  output rxreset;
  output mgt_tx_reset;
  output RX_ER;
  output [12:0]status_vector;
  output [0:0]D;
  output [0:0]O1;
  output O2;
  output O3;
  output encommaalign;
  output an_interrupt;
  output [0:0]O4;
  output [1:0]Q;
  output O5;
  output [7:0]O6;
  output O7;
  output [7:0]O8;
  input CLK;
  input [0:0]AS;
  input I1;
  input I2;
  input rxnotintable_usr;
  input rxbuferr;
  input txbuferr;
  input rxdisperr_usr;
  input an_restart_config;
  input [1:0]I3;
  input [0:0]an_adv_config_vector;
  input I4;
  input rx_dv_reg1;
  input data_out;
  input rxcharisk;
  input rxchariscomma;
  input [7:0]I5;
  input signal_detect;
  input [4:0]configuration_vector;
  input [7:0]I6;
  input [1:0]I7;

  wire [0:0]AS;
  wire CLK;
  wire [0:0]D;
  wire I1;
  wire I2;
  wire [1:0]I3;
  wire I4;
  wire [7:0]I5;
  wire [7:0]I6;
  wire [1:0]I7;
  wire [0:0]O1;
  wire O2;
  wire O3;
  wire [0:0]O4;
  wire O5;
  wire [7:0]O6;
  wire O7;
  wire [7:0]O8;
  wire [1:0]Q;
  wire RX_ER;
  wire [0:0]an_adv_config_vector;
  wire an_interrupt;
  wire an_restart_config;
  wire [4:0]configuration_vector;
  wire data_out;
  wire encommaalign;
  wire mgt_tx_reset;
  wire rx_dv_reg1;
  wire rxbuferr;
  wire rxchariscomma;
  wire rxcharisk;
  wire rxdisperr_usr;
  wire rxnotintable_usr;
  wire rxreset;
  wire signal_detect;
  wire [12:0]status_vector;
  wire txbuferr;

gmii_to_sgmiiGPCS_PMA_GEN gpcs_pma_inst
       (.AS(AS),
        .CLK(CLK),
        .D(D),
        .I1(I1),
        .I2(I2),
        .I3(I3),
        .I4(I4),
        .I5(I5),
        .I6(I6),
        .I7(I7),
        .O1(mgt_tx_reset),
        .O2(O1),
        .O3(O2),
        .O4(O3),
        .O5(O4),
        .O6(O5),
        .O7(O6),
        .O8(O7),
        .O9(O8),
        .Q(Q),
        .RX_ER(RX_ER),
        .SR(rxreset),
        .an_adv_config_vector(an_adv_config_vector),
        .an_interrupt(an_interrupt),
        .an_restart_config(an_restart_config),
        .configuration_vector(configuration_vector),
        .data_out(data_out),
        .encommaalign(encommaalign),
        .rx_dv_reg1(rx_dv_reg1),
        .rxbuferr(rxbuferr),
        .rxchariscomma(rxchariscomma),
        .rxcharisk(rxcharisk),
        .rxdisperr_usr(rxdisperr_usr),
        .rxnotintable_usr(rxnotintable_usr),
        .signal_detect(signal_detect),
        .status_vector(status_vector),
        .txbuferr(txbuferr));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_GTWIZARD_GT" *) 
module gmii_to_sgmiigmii_to_sgmii_GTWIZARD_GT__parameterized0
   (O1,
    txn,
    txp,
    I_0,
    O2,
    txoutclk,
    O3,
    TXBUFSTATUS,
    D,
    independent_clock_bufg,
    CPLL_RESET,
    CLK,
    rxn,
    rxp,
    gtrefclk_out,
    gt0_gttxreset_in0_out,
    gt0_qplloutclk_out,
    gt0_qplloutrefclk_out,
    RXDFELFHOLD,
    gt0_rxmcommaalignen_in,
    RXUSERRDY,
    I1,
    TXPD,
    TXUSERRDY,
    I2,
    RXPD,
    Q,
    I3,
    I4,
    I5,
    gt0_gtrxreset_in1_out);
  output O1;
  output txn;
  output txp;
  output I_0;
  output O2;
  output txoutclk;
  output O3;
  output [0:0]TXBUFSTATUS;
  output [23:0]D;
  input independent_clock_bufg;
  input CPLL_RESET;
  input CLK;
  input rxn;
  input rxp;
  input gtrefclk_out;
  input gt0_gttxreset_in0_out;
  input gt0_qplloutclk_out;
  input gt0_qplloutrefclk_out;
  input RXDFELFHOLD;
  input gt0_rxmcommaalignen_in;
  input RXUSERRDY;
  input I1;
  input [0:0]TXPD;
  input TXUSERRDY;
  input I2;
  input [0:0]RXPD;
  input [15:0]Q;
  input [1:0]I3;
  input [1:0]I4;
  input [1:0]I5;
  input gt0_gtrxreset_in1_out;

  wire CLK;
  wire CPLLREFCLKLOST;
  wire CPLL_RESET;
  wire [23:0]D;
  wire DRP_OP_DONE;
  wire GTRXRESET_OUT;
  wire I1;
  wire I2;
  wire [1:0]I3;
  wire [1:0]I4;
  wire [1:0]I5;
  wire I_0;
  wire O1;
  wire O2;
  wire O3;
  wire [15:0]Q;
  wire RXDFELFHOLD;
  wire [0:0]RXPD;
  wire RXPMARESET_OUT;
  wire RXUSERRDY;
  wire [0:0]TXBUFSTATUS;
  wire [0:0]TXPD;
  wire TXUSERRDY;
  wire drp_busy_i1;
  wire gt0_gtrxreset_in1_out;
  wire gt0_gttxreset_in0_out;
  wire gt0_qplloutclk_out;
  wire gt0_qplloutrefclk_out;
  wire gt0_rxmcommaalignen_in;
  wire gtrefclk_out;
  wire independent_clock_bufg;
  wire n_0_gthe2_i;
  wire n_10_gthe2_i;
  wire n_10_gtrxreset_seq_i;
  wire n_10_rxpmarst_seq_i;
  wire n_113_gthe2_i;
  wire n_114_gthe2_i;
  wire n_115_gthe2_i;
  wire n_116_gthe2_i;
  wire n_11_gthe2_i;
  wire n_11_gtrxreset_seq_i;
  wire n_11_rxpmarst_seq_i;
  wire n_12_gtrxreset_seq_i;
  wire n_12_rxpmarst_seq_i;
  wire n_13_gtrxreset_seq_i;
  wire n_13_rxpmarst_seq_i;
  wire n_14_gtrxreset_seq_i;
  wire n_14_rxpmarst_seq_i;
  wire n_15_gtrxreset_seq_i;
  wire n_15_rxpmarst_seq_i;
  wire n_16_gtrxreset_seq_i;
  wire n_16_rxpmarst_seq_i;
  wire n_17_gthe2_i;
  wire n_17_gtrxreset_seq_i;
  wire n_17_rxpmarst_seq_i;
  wire n_18_gtrxreset_seq_i;
  wire n_18_rxpmarst_seq_i;
  wire n_19_gtrxreset_seq_i;
  wire n_19_rxpmarst_seq_i;
  wire n_205_gthe2_i;
  wire n_206_gthe2_i;
  wire n_207_gthe2_i;
  wire n_208_gthe2_i;
  wire n_209_gthe2_i;
  wire n_20_gtrxreset_seq_i;
  wire n_20_rxpmarst_seq_i;
  wire n_210_gthe2_i;
  wire n_211_gthe2_i;
  wire n_2_gtrxreset_seq_i;
  wire n_2_rxpmarst_seq_i;
  wire n_33_gthe2_i;
  wire n_34_gthe2_i;
  wire n_3_gthe2_i;
  wire n_3_gtrxreset_seq_i;
  wire n_3_rxpmarst_seq_i;
  wire n_46_gthe2_i;
  wire n_47_gthe2_i;
  wire n_4_gthe2_i;
  wire n_4_gtrxreset_seq_i;
  wire n_4_rxpmarst_seq_i;
  wire n_50_gthe2_i;
  wire n_57_gthe2_i;
  wire n_58_gthe2_i;
  wire n_59_gthe2_i;
  wire n_5_gtrxreset_seq_i;
  wire n_5_rxpmarst_seq_i;
  wire n_60_gthe2_i;
  wire n_61_gthe2_i;
  wire n_62_gthe2_i;
  wire n_63_gthe2_i;
  wire n_64_gthe2_i;
  wire n_65_gthe2_i;
  wire n_66_gthe2_i;
  wire n_67_gthe2_i;
  wire n_68_gthe2_i;
  wire n_69_gthe2_i;
  wire n_6_gtrxreset_seq_i;
  wire n_6_rxpmarst_seq_i;
  wire n_70_gthe2_i;
  wire n_71_gthe2_i;
  wire n_72_gthe2_i;
  wire n_73_gthe2_i;
  wire n_74_gthe2_i;
  wire n_75_gthe2_i;
  wire n_76_gthe2_i;
  wire n_77_gthe2_i;
  wire n_78_gthe2_i;
  wire n_79_gthe2_i;
  wire n_7_gtrxreset_seq_i;
  wire n_7_rxpmarst_seq_i;
  wire n_80_gthe2_i;
  wire n_81_gthe2_i;
  wire n_82_gthe2_i;
  wire n_83_gthe2_i;
  wire n_84_gthe2_i;
  wire n_85_gthe2_i;
  wire n_86_gthe2_i;
  wire n_87_gthe2_i;
  wire n_8_gtrxreset_seq_i;
  wire n_8_rxpmarst_seq_i;
  wire n_9_gtrxreset_seq_i;
  wire n_9_rxpmarst_seq_i;
  wire rxn;
  wire rxp;
  wire [2:2]state;
  wire txn;
  wire txoutclk;
  wire txp;
  wire NLW_gthe2_i_GTREFCLKMONITOR_UNCONNECTED;
  wire NLW_gthe2_i_PHYSTATUS_UNCONNECTED;
  wire NLW_gthe2_i_RSOSINTDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXCDRLOCK_UNCONNECTED;
  wire NLW_gthe2_i_RXCHANBONDSEQ_UNCONNECTED;
  wire NLW_gthe2_i_RXCHANISALIGNED_UNCONNECTED;
  wire NLW_gthe2_i_RXCHANREALIGN_UNCONNECTED;
  wire NLW_gthe2_i_RXCOMINITDET_UNCONNECTED;
  wire NLW_gthe2_i_RXCOMSASDET_UNCONNECTED;
  wire NLW_gthe2_i_RXCOMWAKEDET_UNCONNECTED;
  wire NLW_gthe2_i_RXDFESLIDETAPSTARTED_UNCONNECTED;
  wire NLW_gthe2_i_RXDFESLIDETAPSTROBEDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXDFESLIDETAPSTROBESTARTED_UNCONNECTED;
  wire NLW_gthe2_i_RXDFESTADAPTDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXDLYSRESETDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXELECIDLE_UNCONNECTED;
  wire NLW_gthe2_i_RXOSINTSTARTED_UNCONNECTED;
  wire NLW_gthe2_i_RXOSINTSTROBEDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXOSINTSTROBESTARTED_UNCONNECTED;
  wire NLW_gthe2_i_RXOUTCLKFABRIC_UNCONNECTED;
  wire NLW_gthe2_i_RXOUTCLKPCS_UNCONNECTED;
  wire NLW_gthe2_i_RXPHALIGNDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXQPISENN_UNCONNECTED;
  wire NLW_gthe2_i_RXQPISENP_UNCONNECTED;
  wire NLW_gthe2_i_RXRATEDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXSYNCDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXSYNCOUT_UNCONNECTED;
  wire NLW_gthe2_i_RXVALID_UNCONNECTED;
  wire NLW_gthe2_i_TXCOMFINISH_UNCONNECTED;
  wire NLW_gthe2_i_TXDLYSRESETDONE_UNCONNECTED;
  wire NLW_gthe2_i_TXGEARBOXREADY_UNCONNECTED;
  wire NLW_gthe2_i_TXPHALIGNDONE_UNCONNECTED;
  wire NLW_gthe2_i_TXPHINITDONE_UNCONNECTED;
  wire NLW_gthe2_i_TXQPISENN_UNCONNECTED;
  wire NLW_gthe2_i_TXQPISENP_UNCONNECTED;
  wire NLW_gthe2_i_TXRATEDONE_UNCONNECTED;
  wire NLW_gthe2_i_TXSYNCDONE_UNCONNECTED;
  wire NLW_gthe2_i_TXSYNCOUT_UNCONNECTED;
  wire [15:0]NLW_gthe2_i_PCSRSVDOUT_UNCONNECTED;
  wire [7:2]NLW_gthe2_i_RXCHARISCOMMA_UNCONNECTED;
  wire [7:2]NLW_gthe2_i_RXCHARISK_UNCONNECTED;
  wire [4:0]NLW_gthe2_i_RXCHBONDO_UNCONNECTED;
  wire [1:0]NLW_gthe2_i_RXCLKCORCNT_UNCONNECTED;
  wire [63:16]NLW_gthe2_i_RXDATA_UNCONNECTED;
  wire [1:0]NLW_gthe2_i_RXDATAVALID_UNCONNECTED;
  wire [7:2]NLW_gthe2_i_RXDISPERR_UNCONNECTED;
  wire [5:0]NLW_gthe2_i_RXHEADER_UNCONNECTED;
  wire [1:0]NLW_gthe2_i_RXHEADERVALID_UNCONNECTED;
  wire [7:2]NLW_gthe2_i_RXNOTINTABLE_UNCONNECTED;
  wire [4:0]NLW_gthe2_i_RXPHMONITOR_UNCONNECTED;
  wire [4:0]NLW_gthe2_i_RXPHSLIPMONITOR_UNCONNECTED;
  wire [1:0]NLW_gthe2_i_RXSTARTOFSEQ_UNCONNECTED;
  wire [2:0]NLW_gthe2_i_RXSTATUS_UNCONNECTED;

FDRE #(
    .INIT(1'b0)) 
     drp_busy_i1_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_2_gtrxreset_seq_i),
        .Q(drp_busy_i1),
        .R(1'b0));
(* box_type = "PRIMITIVE" *) 
   GTHE2_CHANNEL #(
    .ACJTAG_DEBUG_MODE(1'b0),
    .ACJTAG_MODE(1'b0),
    .ACJTAG_RESET(1'b0),
    .ADAPT_CFG0(20'h00C10),
    .ALIGN_COMMA_DOUBLE("FALSE"),
    .ALIGN_COMMA_ENABLE(10'b0001111111),
    .ALIGN_COMMA_WORD(2),
    .ALIGN_MCOMMA_DET("TRUE"),
    .ALIGN_MCOMMA_VALUE(10'b1010000011),
    .ALIGN_PCOMMA_DET("TRUE"),
    .ALIGN_PCOMMA_VALUE(10'b0101111100),
    .A_RXOSCALRESET(1'b0),
    .CBCC_DATA_SOURCE_SEL("DECODED"),
    .CFOK_CFG(42'h24800040E80),
    .CFOK_CFG2(6'b100000),
    .CFOK_CFG3(6'b100000),
    .CHAN_BOND_KEEP_ALIGN("FALSE"),
    .CHAN_BOND_MAX_SKEW(1),
    .CHAN_BOND_SEQ_1_1(10'b0000000000),
    .CHAN_BOND_SEQ_1_2(10'b0000000000),
    .CHAN_BOND_SEQ_1_3(10'b0000000000),
    .CHAN_BOND_SEQ_1_4(10'b0000000000),
    .CHAN_BOND_SEQ_1_ENABLE(4'b1111),
    .CHAN_BOND_SEQ_2_1(10'b0000000000),
    .CHAN_BOND_SEQ_2_2(10'b0000000000),
    .CHAN_BOND_SEQ_2_3(10'b0000000000),
    .CHAN_BOND_SEQ_2_4(10'b0000000000),
    .CHAN_BOND_SEQ_2_ENABLE(4'b1111),
    .CHAN_BOND_SEQ_2_USE("FALSE"),
    .CHAN_BOND_SEQ_LEN(1),
    .CLK_CORRECT_USE("FALSE"),
    .CLK_COR_KEEP_IDLE("FALSE"),
    .CLK_COR_MAX_LAT(36),
    .CLK_COR_MIN_LAT(32),
    .CLK_COR_PRECEDENCE("TRUE"),
    .CLK_COR_REPEAT_WAIT(0),
    .CLK_COR_SEQ_1_1(10'b0100000000),
    .CLK_COR_SEQ_1_2(10'b0000000000),
    .CLK_COR_SEQ_1_3(10'b0000000000),
    .CLK_COR_SEQ_1_4(10'b0000000000),
    .CLK_COR_SEQ_1_ENABLE(4'b1111),
    .CLK_COR_SEQ_2_1(10'b0100000000),
    .CLK_COR_SEQ_2_2(10'b0000000000),
    .CLK_COR_SEQ_2_3(10'b0000000000),
    .CLK_COR_SEQ_2_4(10'b0000000000),
    .CLK_COR_SEQ_2_ENABLE(4'b1111),
    .CLK_COR_SEQ_2_USE("FALSE"),
    .CLK_COR_SEQ_LEN(1),
    .CPLL_CFG(29'h00BC07DC),
    .CPLL_FBDIV(4),
    .CPLL_FBDIV_45(5),
    .CPLL_INIT_CFG(24'h00001E),
    .CPLL_LOCK_CFG(16'h01E8),
    .CPLL_REFCLK_DIV(1),
    .DEC_MCOMMA_DETECT("TRUE"),
    .DEC_PCOMMA_DETECT("TRUE"),
    .DEC_VALID_COMMA_ONLY("FALSE"),
    .DMONITOR_CFG(24'h000A00),
    .ES_CLK_PHASE_SEL(1'b0),
    .ES_CONTROL(6'b000000),
    .ES_ERRDET_EN("FALSE"),
    .ES_EYE_SCAN_EN("TRUE"),
    .ES_HORZ_OFFSET(12'h000),
    .ES_PMA_CFG(10'b0000000000),
    .ES_PRESCALE(5'b00000),
    .ES_QUALIFIER(80'h00000000000000000000),
    .ES_QUAL_MASK(80'h00000000000000000000),
    .ES_SDATA_MASK(80'h00000000000000000000),
    .ES_VERT_OFFSET(9'b000000000),
    .FTS_DESKEW_SEQ_ENABLE(4'b1111),
    .FTS_LANE_DESKEW_CFG(4'b1111),
    .FTS_LANE_DESKEW_EN("FALSE"),
    .GEARBOX_MODE(3'b000),
    .IS_CLKRSVD0_INVERTED(1'b0),
    .IS_CLKRSVD1_INVERTED(1'b0),
    .IS_CPLLLOCKDETCLK_INVERTED(1'b0),
    .IS_DMONITORCLK_INVERTED(1'b0),
    .IS_DRPCLK_INVERTED(1'b0),
    .IS_GTGREFCLK_INVERTED(1'b0),
    .IS_RXUSRCLK2_INVERTED(1'b0),
    .IS_RXUSRCLK_INVERTED(1'b0),
    .IS_SIGVALIDCLK_INVERTED(1'b0),
    .IS_TXPHDLYTSTCLK_INVERTED(1'b0),
    .IS_TXUSRCLK2_INVERTED(1'b0),
    .IS_TXUSRCLK_INVERTED(1'b0),
    .LOOPBACK_CFG(1'b0),
    .OUTREFCLK_SEL_INV(2'b11),
    .PCS_PCIE_EN("FALSE"),
    .PCS_RSVD_ATTR(48'h000000000000),
    .PD_TRANS_TIME_FROM_P2(12'h03C),
    .PD_TRANS_TIME_NONE_P2(8'h19),
    .PD_TRANS_TIME_TO_P2(8'h64),
    .PMA_RSV(32'b00000000000000011000010010000000),
    .PMA_RSV2(32'b00011100000000000000000000001010),
    .PMA_RSV3(2'b00),
    .PMA_RSV4(15'b000000000001000),
    .PMA_RSV5(4'b0000),
    .RESET_POWERSAVE_DISABLE(1'b0),
    .RXBUFRESET_TIME(5'b00001),
    .RXBUF_ADDR_MODE("FAST"),
    .RXBUF_EIDLE_HI_CNT(4'b1000),
    .RXBUF_EIDLE_LO_CNT(4'b0000),
    .RXBUF_EN("TRUE"),
    .RXBUF_RESET_ON_CB_CHANGE("TRUE"),
    .RXBUF_RESET_ON_COMMAALIGN("FALSE"),
    .RXBUF_RESET_ON_EIDLE("FALSE"),
    .RXBUF_RESET_ON_RATE_CHANGE("TRUE"),
    .RXBUF_THRESH_OVFLW(61),
    .RXBUF_THRESH_OVRD("FALSE"),
    .RXBUF_THRESH_UNDFLW(8),
    .RXCDRFREQRESET_TIME(5'b00001),
    .RXCDRPHRESET_TIME(5'b00001),
    .RXCDR_CFG(83'h0002007FE0800C2200018),
    .RXCDR_FR_RESET_ON_EIDLE(1'b0),
    .RXCDR_HOLD_DURING_EIDLE(1'b0),
    .RXCDR_LOCK_CFG(6'b010101),
    .RXCDR_PH_RESET_ON_EIDLE(1'b0),
    .RXDFELPMRESET_TIME(7'b0001111),
    .RXDLY_CFG(16'h001F),
    .RXDLY_LCFG(9'h030),
    .RXDLY_TAP_CFG(16'h0000),
    .RXGEARBOX_EN("FALSE"),
    .RXISCANRESET_TIME(5'b00001),
    .RXLPM_HF_CFG(14'b00001000000000),
    .RXLPM_LF_CFG(18'b001001000000000000),
    .RXOOB_CFG(7'b0000110),
    .RXOOB_CLK_CFG("PMA"),
    .RXOSCALRESET_TIME(5'b00011),
    .RXOSCALRESET_TIMEOUT(5'b00000),
    .RXOUT_DIV(4),
    .RXPCSRESET_TIME(5'b00001),
    .RXPHDLY_CFG(24'h084020),
    .RXPH_CFG(24'hC00002),
    .RXPH_MONITOR_SEL(5'b00000),
    .RXPI_CFG0(2'b00),
    .RXPI_CFG1(2'b00),
    .RXPI_CFG2(2'b00),
    .RXPI_CFG3(2'b11),
    .RXPI_CFG4(1'b1),
    .RXPI_CFG5(1'b1),
    .RXPI_CFG6(3'b001),
    .RXPMARESET_TIME(5'b00011),
    .RXPRBS_ERR_LOOPBACK(1'b1),
    .RXSLIDE_AUTO_WAIT(7),
    .RXSLIDE_MODE("OFF"),
    .RXSYNC_MULTILANE(1'b0),
    .RXSYNC_OVRD(1'b0),
    .RXSYNC_SKIP_DA(1'b0),
    .RX_BIAS_CFG(24'b000011000000000000010000),
    .RX_BUFFER_CFG(6'b000000),
    .RX_CLK25_DIV(5),
    .RX_CLKMUX_PD(1'b1),
    .RX_CM_SEL(2'b11),
    .RX_CM_TRIM(4'b1010),
    .RX_DATA_WIDTH(20),
    .RX_DDI_SEL(6'b000000),
    .RX_DEBUG_CFG(14'b00000000000000),
    .RX_DEFER_RESET_BUF_EN("TRUE"),
    .RX_DFELPM_CFG0(4'b0110),
    .RX_DFELPM_CFG1(1'b0),
    .RX_DFELPM_KLKH_AGC_STUP_EN(1'b1),
    .RX_DFE_AGC_CFG0(2'b00),
    .RX_DFE_AGC_CFG1(3'b100),
    .RX_DFE_AGC_CFG2(4'b0000),
    .RX_DFE_AGC_OVRDEN(1'b1),
    .RX_DFE_GAIN_CFG(23'h0020C0),
    .RX_DFE_H2_CFG(12'b000000000000),
    .RX_DFE_H3_CFG(12'b000001000000),
    .RX_DFE_H4_CFG(11'b00011100000),
    .RX_DFE_H5_CFG(11'b00011100000),
    .RX_DFE_H6_CFG(11'b00000100000),
    .RX_DFE_H7_CFG(11'b00000100000),
    .RX_DFE_KL_CFG(33'b001000001000000000000001100010000),
    .RX_DFE_KL_LPM_KH_CFG0(2'b01),
    .RX_DFE_KL_LPM_KH_CFG1(3'b010),
    .RX_DFE_KL_LPM_KH_CFG2(4'b0010),
    .RX_DFE_KL_LPM_KH_OVRDEN(1'b1),
    .RX_DFE_KL_LPM_KL_CFG0(2'b10),
    .RX_DFE_KL_LPM_KL_CFG1(3'b010),
    .RX_DFE_KL_LPM_KL_CFG2(4'b0010),
    .RX_DFE_KL_LPM_KL_OVRDEN(1'b1),
    .RX_DFE_LPM_CFG(16'h0080),
    .RX_DFE_LPM_HOLD_DURING_EIDLE(1'b0),
    .RX_DFE_ST_CFG(54'h00E100000C003F),
    .RX_DFE_UT_CFG(17'b00011100000000000),
    .RX_DFE_VP_CFG(17'b00011101010100011),
    .RX_DISPERR_SEQ_MATCH("TRUE"),
    .RX_INT_DATAWIDTH(0),
    .RX_OS_CFG(13'b0000010000000),
    .RX_SIG_VALID_DLY(10),
    .RX_XCLK_SEL("RXREC"),
    .SAS_MAX_COM(64),
    .SAS_MIN_COM(36),
    .SATA_BURST_SEQ_LEN(4'b1111),
    .SATA_BURST_VAL(3'b100),
    .SATA_CPLL_CFG("VCO_3000MHZ"),
    .SATA_EIDLE_VAL(3'b100),
    .SATA_MAX_BURST(8),
    .SATA_MAX_INIT(21),
    .SATA_MAX_WAKE(7),
    .SATA_MIN_BURST(4),
    .SATA_MIN_INIT(12),
    .SATA_MIN_WAKE(4),
    .SHOW_REALIGN_COMMA("TRUE"),
    .SIM_CPLLREFCLK_SEL(3'b001),
    .SIM_RECEIVER_DETECT_PASS("TRUE"),
    .SIM_RESET_SPEEDUP("TRUE"),
    .SIM_TX_EIDLE_DRIVE_LEVEL("X"),
    .SIM_VERSION("2.0"),
    .TERM_RCAL_CFG(15'b100001000010000),
    .TERM_RCAL_OVRD(3'b000),
    .TRANS_TIME_RATE(8'h0E),
    .TST_RSV(32'h00000000),
    .TXBUF_EN("TRUE"),
    .TXBUF_RESET_ON_RATE_CHANGE("TRUE"),
    .TXDLY_CFG(16'h001F),
    .TXDLY_LCFG(9'h030),
    .TXDLY_TAP_CFG(16'h0000),
    .TXGEARBOX_EN("FALSE"),
    .TXOOB_CFG(1'b0),
    .TXOUT_DIV(4),
    .TXPCSRESET_TIME(5'b00001),
    .TXPHDLY_CFG(24'h084020),
    .TXPH_CFG(16'h0780),
    .TXPH_MONITOR_SEL(5'b00000),
    .TXPI_CFG0(2'b00),
    .TXPI_CFG1(2'b00),
    .TXPI_CFG2(2'b00),
    .TXPI_CFG3(1'b0),
    .TXPI_CFG4(1'b0),
    .TXPI_CFG5(3'b100),
    .TXPI_GREY_SEL(1'b0),
    .TXPI_INVSTROBE_SEL(1'b0),
    .TXPI_PPMCLK_SEL("TXUSRCLK2"),
    .TXPI_PPM_CFG(8'b00000000),
    .TXPI_SYNFREQ_PPM(3'b000),
    .TXPMARESET_TIME(5'b00001),
    .TXSYNC_MULTILANE(1'b0),
    .TXSYNC_OVRD(1'b0),
    .TXSYNC_SKIP_DA(1'b0),
    .TX_CLK25_DIV(5),
    .TX_CLKMUX_PD(1'b1),
    .TX_DATA_WIDTH(20),
    .TX_DEEMPH0(6'b000000),
    .TX_DEEMPH1(6'b000000),
    .TX_DRIVE_MODE("DIRECT"),
    .TX_EIDLE_ASSERT_DELAY(3'b110),
    .TX_EIDLE_DEASSERT_DELAY(3'b100),
    .TX_INT_DATAWIDTH(0),
    .TX_LOOPBACK_DRIVE_HIZ("FALSE"),
    .TX_MAINCURSOR_SEL(1'b0),
    .TX_MARGIN_FULL_0(7'b1001110),
    .TX_MARGIN_FULL_1(7'b1001001),
    .TX_MARGIN_FULL_2(7'b1000101),
    .TX_MARGIN_FULL_3(7'b1000010),
    .TX_MARGIN_FULL_4(7'b1000000),
    .TX_MARGIN_LOW_0(7'b1000110),
    .TX_MARGIN_LOW_1(7'b1000100),
    .TX_MARGIN_LOW_2(7'b1000010),
    .TX_MARGIN_LOW_3(7'b1000000),
    .TX_MARGIN_LOW_4(7'b1000000),
    .TX_QPI_STATUS_EN(1'b0),
    .TX_RXDETECT_CFG(14'h1832),
    .TX_RXDETECT_PRECHARGE_TIME(17'h155CC),
    .TX_RXDETECT_REF(3'b100),
    .TX_XCLK_SEL("TXOUT"),
    .UCODEER_CLR(1'b0),
    .USE_PCS_CLK_PHASE_SEL(1'b0)) 
     gthe2_i
       (.CFGRESET(1'b0),
        .CLKRSVD0(1'b0),
        .CLKRSVD1(1'b0),
        .CPLLFBCLKLOST(n_0_gthe2_i),
        .CPLLLOCK(O1),
        .CPLLLOCKDETCLK(independent_clock_bufg),
        .CPLLLOCKEN(1'b1),
        .CPLLPD(1'b0),
        .CPLLREFCLKLOST(CPLLREFCLKLOST),
        .CPLLREFCLKSEL({1'b0,1'b0,1'b1}),
        .CPLLRESET(CPLL_RESET),
        .DMONFIFORESET(1'b0),
        .DMONITORCLK(1'b0),
        .DMONITOROUT({n_57_gthe2_i,n_58_gthe2_i,n_59_gthe2_i,n_60_gthe2_i,n_61_gthe2_i,n_62_gthe2_i,n_63_gthe2_i,n_64_gthe2_i,n_65_gthe2_i,n_66_gthe2_i,n_67_gthe2_i,n_68_gthe2_i,n_69_gthe2_i,n_70_gthe2_i,n_71_gthe2_i}),
        .DRPADDR({1'b0,1'b0,1'b0,1'b0,n_2_rxpmarst_seq_i,1'b0,1'b0,1'b0,n_2_rxpmarst_seq_i}),
        .DRPCLK(CLK),
        .DRPDI({n_3_gtrxreset_seq_i,n_4_gtrxreset_seq_i,n_5_gtrxreset_seq_i,n_6_gtrxreset_seq_i,n_7_gtrxreset_seq_i,n_8_gtrxreset_seq_i,n_9_gtrxreset_seq_i,n_10_gtrxreset_seq_i,n_11_gtrxreset_seq_i,n_12_gtrxreset_seq_i,n_13_gtrxreset_seq_i,n_14_gtrxreset_seq_i,n_15_gtrxreset_seq_i,n_16_gtrxreset_seq_i,n_17_gtrxreset_seq_i,n_18_gtrxreset_seq_i}),
        .DRPDO({n_72_gthe2_i,n_73_gthe2_i,n_74_gthe2_i,n_75_gthe2_i,n_76_gthe2_i,n_77_gthe2_i,n_78_gthe2_i,n_79_gthe2_i,n_80_gthe2_i,n_81_gthe2_i,n_82_gthe2_i,n_83_gthe2_i,n_84_gthe2_i,n_85_gthe2_i,n_86_gthe2_i,n_87_gthe2_i}),
        .DRPEN(n_20_gtrxreset_seq_i),
        .DRPRDY(n_3_gthe2_i),
        .DRPWE(n_19_gtrxreset_seq_i),
        .EYESCANDATAERROR(n_4_gthe2_i),
        .EYESCANMODE(1'b0),
        .EYESCANRESET(1'b0),
        .EYESCANTRIGGER(1'b0),
        .GTGREFCLK(1'b0),
        .GTHRXN(rxn),
        .GTHRXP(rxp),
        .GTHTXN(txn),
        .GTHTXP(txp),
        .GTNORTHREFCLK0(1'b0),
        .GTNORTHREFCLK1(1'b0),
        .GTREFCLK0(gtrefclk_out),
        .GTREFCLK1(1'b0),
        .GTREFCLKMONITOR(NLW_gthe2_i_GTREFCLKMONITOR_UNCONNECTED),
        .GTRESETSEL(1'b0),
        .GTRSVD({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .GTRXRESET(GTRXRESET_OUT),
        .GTSOUTHREFCLK0(1'b0),
        .GTSOUTHREFCLK1(1'b0),
        .GTTXRESET(gt0_gttxreset_in0_out),
        .LOOPBACK({1'b0,1'b0,1'b0}),
        .PCSRSVDIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PCSRSVDIN2({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PCSRSVDOUT(NLW_gthe2_i_PCSRSVDOUT_UNCONNECTED[15:0]),
        .PHYSTATUS(NLW_gthe2_i_PHYSTATUS_UNCONNECTED),
        .PMARSVDIN({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .QPLLCLK(gt0_qplloutclk_out),
        .QPLLREFCLK(gt0_qplloutrefclk_out),
        .RESETOVRD(1'b0),
        .RSOSINTDONE(NLW_gthe2_i_RSOSINTDONE_UNCONNECTED),
        .RX8B10BEN(1'b1),
        .RXADAPTSELTEST({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .RXBUFRESET(1'b0),
        .RXBUFSTATUS({n_114_gthe2_i,n_115_gthe2_i,n_116_gthe2_i}),
        .RXBYTEISALIGNED(n_10_gthe2_i),
        .RXBYTEREALIGN(n_11_gthe2_i),
        .RXCDRFREQRESET(1'b0),
        .RXCDRHOLD(1'b0),
        .RXCDRLOCK(NLW_gthe2_i_RXCDRLOCK_UNCONNECTED),
        .RXCDROVRDEN(1'b0),
        .RXCDRRESET(1'b0),
        .RXCDRRESETRSV(1'b0),
        .RXCHANBONDSEQ(NLW_gthe2_i_RXCHANBONDSEQ_UNCONNECTED),
        .RXCHANISALIGNED(NLW_gthe2_i_RXCHANISALIGNED_UNCONNECTED),
        .RXCHANREALIGN(NLW_gthe2_i_RXCHANREALIGN_UNCONNECTED),
        .RXCHARISCOMMA({NLW_gthe2_i_RXCHARISCOMMA_UNCONNECTED[7:2],D[11],D[23]}),
        .RXCHARISK({NLW_gthe2_i_RXCHARISK_UNCONNECTED[7:2],D[10],D[22]}),
        .RXCHBONDEN(1'b0),
        .RXCHBONDI({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .RXCHBONDLEVEL({1'b0,1'b0,1'b0}),
        .RXCHBONDMASTER(1'b0),
        .RXCHBONDO(NLW_gthe2_i_RXCHBONDO_UNCONNECTED[4:0]),
        .RXCHBONDSLAVE(1'b0),
        .RXCLKCORCNT(NLW_gthe2_i_RXCLKCORCNT_UNCONNECTED[1:0]),
        .RXCOMINITDET(NLW_gthe2_i_RXCOMINITDET_UNCONNECTED),
        .RXCOMMADET(n_17_gthe2_i),
        .RXCOMMADETEN(1'b1),
        .RXCOMSASDET(NLW_gthe2_i_RXCOMSASDET_UNCONNECTED),
        .RXCOMWAKEDET(NLW_gthe2_i_RXCOMWAKEDET_UNCONNECTED),
        .RXDATA({NLW_gthe2_i_RXDATA_UNCONNECTED[63:16],D[7:0],D[19:12]}),
        .RXDATAVALID(NLW_gthe2_i_RXDATAVALID_UNCONNECTED[1:0]),
        .RXDDIEN(1'b0),
        .RXDFEAGCHOLD(RXDFELFHOLD),
        .RXDFEAGCOVRDEN(1'b0),
        .RXDFEAGCTRL({1'b1,1'b0,1'b0,1'b0,1'b0}),
        .RXDFECM1EN(1'b0),
        .RXDFELFHOLD(RXDFELFHOLD),
        .RXDFELFOVRDEN(1'b0),
        .RXDFELPMRESET(1'b0),
        .RXDFESLIDETAP({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .RXDFESLIDETAPADAPTEN(1'b0),
        .RXDFESLIDETAPHOLD(1'b0),
        .RXDFESLIDETAPID({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .RXDFESLIDETAPINITOVRDEN(1'b0),
        .RXDFESLIDETAPONLYADAPTEN(1'b0),
        .RXDFESLIDETAPOVRDEN(1'b0),
        .RXDFESLIDETAPSTARTED(NLW_gthe2_i_RXDFESLIDETAPSTARTED_UNCONNECTED),
        .RXDFESLIDETAPSTROBE(1'b0),
        .RXDFESLIDETAPSTROBEDONE(NLW_gthe2_i_RXDFESLIDETAPSTROBEDONE_UNCONNECTED),
        .RXDFESLIDETAPSTROBESTARTED(NLW_gthe2_i_RXDFESLIDETAPSTROBESTARTED_UNCONNECTED),
        .RXDFESTADAPTDONE(NLW_gthe2_i_RXDFESTADAPTDONE_UNCONNECTED),
        .RXDFETAP2HOLD(1'b0),
        .RXDFETAP2OVRDEN(1'b0),
        .RXDFETAP3HOLD(1'b0),
        .RXDFETAP3OVRDEN(1'b0),
        .RXDFETAP4HOLD(1'b0),
        .RXDFETAP4OVRDEN(1'b0),
        .RXDFETAP5HOLD(1'b0),
        .RXDFETAP5OVRDEN(1'b0),
        .RXDFETAP6HOLD(1'b0),
        .RXDFETAP6OVRDEN(1'b0),
        .RXDFETAP7HOLD(1'b0),
        .RXDFETAP7OVRDEN(1'b0),
        .RXDFEUTHOLD(1'b0),
        .RXDFEUTOVRDEN(1'b0),
        .RXDFEVPHOLD(1'b0),
        .RXDFEVPOVRDEN(1'b0),
        .RXDFEVSEN(1'b0),
        .RXDFEXYDEN(1'b1),
        .RXDISPERR({NLW_gthe2_i_RXDISPERR_UNCONNECTED[7:2],D[9],D[21]}),
        .RXDLYBYPASS(1'b1),
        .RXDLYEN(1'b0),
        .RXDLYOVRDEN(1'b0),
        .RXDLYSRESET(1'b0),
        .RXDLYSRESETDONE(NLW_gthe2_i_RXDLYSRESETDONE_UNCONNECTED),
        .RXELECIDLE(NLW_gthe2_i_RXELECIDLE_UNCONNECTED),
        .RXELECIDLEMODE({1'b1,1'b1}),
        .RXGEARBOXSLIP(1'b0),
        .RXHEADER(NLW_gthe2_i_RXHEADER_UNCONNECTED[5:0]),
        .RXHEADERVALID(NLW_gthe2_i_RXHEADERVALID_UNCONNECTED[1:0]),
        .RXLPMEN(1'b0),
        .RXLPMHFHOLD(1'b0),
        .RXLPMHFOVRDEN(1'b0),
        .RXLPMLFHOLD(1'b0),
        .RXLPMLFKLOVRDEN(1'b0),
        .RXMCOMMAALIGNEN(gt0_rxmcommaalignen_in),
        .RXMONITOROUT({n_205_gthe2_i,n_206_gthe2_i,n_207_gthe2_i,n_208_gthe2_i,n_209_gthe2_i,n_210_gthe2_i,n_211_gthe2_i}),
        .RXMONITORSEL({1'b0,1'b0}),
        .RXNOTINTABLE({NLW_gthe2_i_RXNOTINTABLE_UNCONNECTED[7:2],D[8],D[20]}),
        .RXOOBRESET(1'b0),
        .RXOSCALRESET(1'b0),
        .RXOSHOLD(1'b0),
        .RXOSINTCFG({1'b0,1'b1,1'b1,1'b0}),
        .RXOSINTEN(1'b1),
        .RXOSINTHOLD(1'b0),
        .RXOSINTID0({1'b0,1'b0,1'b0,1'b0}),
        .RXOSINTNTRLEN(1'b0),
        .RXOSINTOVRDEN(1'b0),
        .RXOSINTSTARTED(NLW_gthe2_i_RXOSINTSTARTED_UNCONNECTED),
        .RXOSINTSTROBE(1'b0),
        .RXOSINTSTROBEDONE(NLW_gthe2_i_RXOSINTSTROBEDONE_UNCONNECTED),
        .RXOSINTSTROBESTARTED(NLW_gthe2_i_RXOSINTSTROBESTARTED_UNCONNECTED),
        .RXOSINTTESTOVRDEN(1'b0),
        .RXOSOVRDEN(1'b0),
        .RXOUTCLK(I_0),
        .RXOUTCLKFABRIC(NLW_gthe2_i_RXOUTCLKFABRIC_UNCONNECTED),
        .RXOUTCLKPCS(NLW_gthe2_i_RXOUTCLKPCS_UNCONNECTED),
        .RXOUTCLKSEL({1'b0,1'b1,1'b0}),
        .RXPCOMMAALIGNEN(gt0_rxmcommaalignen_in),
        .RXPCSRESET(1'b0),
        .RXPD({RXPD,RXPD}),
        .RXPHALIGN(1'b0),
        .RXPHALIGNDONE(NLW_gthe2_i_RXPHALIGNDONE_UNCONNECTED),
        .RXPHALIGNEN(1'b0),
        .RXPHDLYPD(1'b0),
        .RXPHDLYRESET(1'b0),
        .RXPHMONITOR(NLW_gthe2_i_RXPHMONITOR_UNCONNECTED[4:0]),
        .RXPHOVRDEN(1'b0),
        .RXPHSLIPMONITOR(NLW_gthe2_i_RXPHSLIPMONITOR_UNCONNECTED[4:0]),
        .RXPMARESET(RXPMARESET_OUT),
        .RXPMARESETDONE(n_33_gthe2_i),
        .RXPOLARITY(1'b0),
        .RXPRBSCNTRESET(1'b0),
        .RXPRBSERR(n_34_gthe2_i),
        .RXPRBSSEL({1'b0,1'b0,1'b0}),
        .RXQPIEN(1'b0),
        .RXQPISENN(NLW_gthe2_i_RXQPISENN_UNCONNECTED),
        .RXQPISENP(NLW_gthe2_i_RXQPISENP_UNCONNECTED),
        .RXRATE({1'b0,1'b0,1'b0}),
        .RXRATEDONE(NLW_gthe2_i_RXRATEDONE_UNCONNECTED),
        .RXRATEMODE(1'b0),
        .RXRESETDONE(O2),
        .RXSLIDE(1'b0),
        .RXSTARTOFSEQ(NLW_gthe2_i_RXSTARTOFSEQ_UNCONNECTED[1:0]),
        .RXSTATUS(NLW_gthe2_i_RXSTATUS_UNCONNECTED[2:0]),
        .RXSYNCALLIN(1'b0),
        .RXSYNCDONE(NLW_gthe2_i_RXSYNCDONE_UNCONNECTED),
        .RXSYNCIN(1'b0),
        .RXSYNCMODE(1'b0),
        .RXSYNCOUT(NLW_gthe2_i_RXSYNCOUT_UNCONNECTED),
        .RXSYSCLKSEL({1'b0,1'b0}),
        .RXUSERRDY(RXUSERRDY),
        .RXUSRCLK(I1),
        .RXUSRCLK2(I1),
        .RXVALID(NLW_gthe2_i_RXVALID_UNCONNECTED),
        .SETERRSTATUS(1'b0),
        .SIGVALIDCLK(1'b0),
        .TSTIN({1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .TX8B10BBYPASS({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TX8B10BEN(1'b1),
        .TXBUFDIFFCTRL({1'b1,1'b0,1'b0}),
        .TXBUFSTATUS({TXBUFSTATUS,n_113_gthe2_i}),
        .TXCHARDISPMODE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,I3}),
        .TXCHARDISPVAL({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,I4}),
        .TXCHARISK({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,I5}),
        .TXCOMFINISH(NLW_gthe2_i_TXCOMFINISH_UNCONNECTED),
        .TXCOMINIT(1'b0),
        .TXCOMSAS(1'b0),
        .TXCOMWAKE(1'b0),
        .TXDATA({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,Q}),
        .TXDEEMPH(1'b0),
        .TXDETECTRX(1'b0),
        .TXDIFFCTRL({1'b0,1'b0,1'b0,1'b0}),
        .TXDIFFPD(1'b0),
        .TXDLYBYPASS(1'b1),
        .TXDLYEN(1'b0),
        .TXDLYHOLD(1'b0),
        .TXDLYOVRDEN(1'b0),
        .TXDLYSRESET(1'b0),
        .TXDLYSRESETDONE(NLW_gthe2_i_TXDLYSRESETDONE_UNCONNECTED),
        .TXDLYUPDOWN(1'b0),
        .TXELECIDLE(TXPD),
        .TXGEARBOXREADY(NLW_gthe2_i_TXGEARBOXREADY_UNCONNECTED),
        .TXHEADER({1'b0,1'b0,1'b0}),
        .TXINHIBIT(1'b0),
        .TXMAINCURSOR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXMARGIN({1'b0,1'b0,1'b0}),
        .TXOUTCLK(txoutclk),
        .TXOUTCLKFABRIC(n_46_gthe2_i),
        .TXOUTCLKPCS(n_47_gthe2_i),
        .TXOUTCLKSEL({1'b1,1'b0,1'b0}),
        .TXPCSRESET(1'b0),
        .TXPD({TXPD,TXPD}),
        .TXPDELECIDLEMODE(1'b0),
        .TXPHALIGN(1'b0),
        .TXPHALIGNDONE(NLW_gthe2_i_TXPHALIGNDONE_UNCONNECTED),
        .TXPHALIGNEN(1'b0),
        .TXPHDLYPD(1'b0),
        .TXPHDLYRESET(1'b0),
        .TXPHDLYTSTCLK(1'b0),
        .TXPHINIT(1'b0),
        .TXPHINITDONE(NLW_gthe2_i_TXPHINITDONE_UNCONNECTED),
        .TXPHOVRDEN(1'b0),
        .TXPIPPMEN(1'b0),
        .TXPIPPMOVRDEN(1'b0),
        .TXPIPPMPD(1'b0),
        .TXPIPPMSEL(1'b0),
        .TXPIPPMSTEPSIZE({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXPISOPD(1'b0),
        .TXPMARESET(1'b0),
        .TXPMARESETDONE(n_50_gthe2_i),
        .TXPOLARITY(1'b0),
        .TXPOSTCURSOR({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXPOSTCURSORINV(1'b0),
        .TXPRBSFORCEERR(1'b0),
        .TXPRBSSEL({1'b0,1'b0,1'b0}),
        .TXPRECURSOR({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXPRECURSORINV(1'b0),
        .TXQPIBIASEN(1'b0),
        .TXQPISENN(NLW_gthe2_i_TXQPISENN_UNCONNECTED),
        .TXQPISENP(NLW_gthe2_i_TXQPISENP_UNCONNECTED),
        .TXQPISTRONGPDOWN(1'b0),
        .TXQPIWEAKPUP(1'b0),
        .TXRATE({1'b0,1'b0,1'b0}),
        .TXRATEDONE(NLW_gthe2_i_TXRATEDONE_UNCONNECTED),
        .TXRATEMODE(1'b0),
        .TXRESETDONE(O3),
        .TXSEQUENCE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXSTARTSEQ(1'b0),
        .TXSWING(1'b0),
        .TXSYNCALLIN(1'b0),
        .TXSYNCDONE(NLW_gthe2_i_TXSYNCDONE_UNCONNECTED),
        .TXSYNCIN(1'b0),
        .TXSYNCMODE(1'b0),
        .TXSYNCOUT(NLW_gthe2_i_TXSYNCOUT_UNCONNECTED),
        .TXSYSCLKSEL({1'b0,1'b0}),
        .TXUSERRDY(TXUSERRDY),
        .TXUSRCLK(I2),
        .TXUSRCLK2(I2));
gmii_to_sgmiigmii_to_sgmii_gtwizard_gtrxreset_seq gtrxreset_seq_i
       (.CLK(CLK),
        .CPLL_RESET(CPLL_RESET),
        .D({n_72_gthe2_i,n_73_gthe2_i,n_74_gthe2_i,n_75_gthe2_i,n_77_gthe2_i,n_78_gthe2_i,n_79_gthe2_i,n_80_gthe2_i,n_81_gthe2_i,n_82_gthe2_i,n_83_gthe2_i,n_84_gthe2_i,n_85_gthe2_i,n_86_gthe2_i,n_87_gthe2_i}),
        .DRPDI({n_3_gtrxreset_seq_i,n_4_gtrxreset_seq_i,n_5_gtrxreset_seq_i,n_6_gtrxreset_seq_i,n_7_gtrxreset_seq_i,n_8_gtrxreset_seq_i,n_9_gtrxreset_seq_i,n_10_gtrxreset_seq_i,n_11_gtrxreset_seq_i,n_12_gtrxreset_seq_i,n_13_gtrxreset_seq_i,n_14_gtrxreset_seq_i,n_15_gtrxreset_seq_i,n_16_gtrxreset_seq_i,n_17_gtrxreset_seq_i,n_18_gtrxreset_seq_i}),
        .DRP_OP_DONE(DRP_OP_DONE),
        .GTRXRESET_OUT(GTRXRESET_OUT),
        .I1(n_33_gthe2_i),
        .I2(n_3_gthe2_i),
        .I3(n_5_rxpmarst_seq_i),
        .I4(n_3_rxpmarst_seq_i),
        .I5({n_6_rxpmarst_seq_i,n_7_rxpmarst_seq_i,n_8_rxpmarst_seq_i,n_9_rxpmarst_seq_i,n_10_rxpmarst_seq_i,n_11_rxpmarst_seq_i,n_12_rxpmarst_seq_i,n_13_rxpmarst_seq_i,n_14_rxpmarst_seq_i,n_15_rxpmarst_seq_i,n_16_rxpmarst_seq_i,n_17_rxpmarst_seq_i,n_18_rxpmarst_seq_i,n_19_rxpmarst_seq_i,n_20_rxpmarst_seq_i}),
        .I6(n_4_rxpmarst_seq_i),
        .O1(n_2_gtrxreset_seq_i),
        .O2(n_19_gtrxreset_seq_i),
        .O3(n_20_gtrxreset_seq_i),
        .Q(state),
        .gt0_gtrxreset_in1_out(gt0_gtrxreset_in1_out));
gmii_to_sgmiigmii_to_sgmii_gtwizard_rxpmarst_seq rxpmarst_seq_i
       (.CLK(CLK),
        .CPLL_RESET(CPLL_RESET),
        .D({n_72_gthe2_i,n_73_gthe2_i,n_74_gthe2_i,n_75_gthe2_i,n_77_gthe2_i,n_78_gthe2_i,n_79_gthe2_i,n_80_gthe2_i,n_81_gthe2_i,n_82_gthe2_i,n_83_gthe2_i,n_84_gthe2_i,n_85_gthe2_i,n_86_gthe2_i,n_87_gthe2_i}),
        .DRPADDR(n_2_rxpmarst_seq_i),
        .DRP_OP_DONE(DRP_OP_DONE),
        .I1(n_33_gthe2_i),
        .I2(n_3_gthe2_i),
        .O1(n_3_rxpmarst_seq_i),
        .O2(n_4_rxpmarst_seq_i),
        .O3(n_5_rxpmarst_seq_i),
        .O4({n_6_rxpmarst_seq_i,n_7_rxpmarst_seq_i,n_8_rxpmarst_seq_i,n_9_rxpmarst_seq_i,n_10_rxpmarst_seq_i,n_11_rxpmarst_seq_i,n_12_rxpmarst_seq_i,n_13_rxpmarst_seq_i,n_14_rxpmarst_seq_i,n_15_rxpmarst_seq_i,n_16_rxpmarst_seq_i,n_17_rxpmarst_seq_i,n_18_rxpmarst_seq_i,n_19_rxpmarst_seq_i,n_20_rxpmarst_seq_i}),
        .Q(state),
        .RXPMARESET_OUT(RXPMARESET_OUT),
        .drp_busy_i1(drp_busy_i1));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_GTWIZARD" *) 
module gmii_to_sgmiigmii_to_sgmii_GTWIZARD__parameterized0
   (txn,
    txp,
    I_0,
    txoutclk,
    TXBUFSTATUS,
    D,
    resetdone,
    independent_clock_bufg,
    CLK,
    rxn,
    rxp,
    gtrefclk_out,
    gt0_qplloutclk_out,
    gt0_qplloutrefclk_out,
    gt0_rxmcommaalignen_in,
    I1,
    TXPD,
    I2,
    RXPD,
    Q,
    I3,
    I4,
    I5,
    mmcm_locked_out,
    data_out,
    AR,
    rxreset,
    reset_out);
  output txn;
  output txp;
  output I_0;
  output txoutclk;
  output [0:0]TXBUFSTATUS;
  output [23:0]D;
  output resetdone;
  input independent_clock_bufg;
  input CLK;
  input rxn;
  input rxp;
  input gtrefclk_out;
  input gt0_qplloutclk_out;
  input gt0_qplloutrefclk_out;
  input gt0_rxmcommaalignen_in;
  input I1;
  input [0:0]TXPD;
  input I2;
  input [0:0]RXPD;
  input [15:0]Q;
  input [1:0]I3;
  input [1:0]I4;
  input [1:0]I5;
  input mmcm_locked_out;
  input data_out;
  input [0:0]AR;
  input rxreset;
  input reset_out;

  wire [0:0]AR;
  wire CLK;
  wire [23:0]D;
  wire I1;
  wire I2;
  wire [1:0]I3;
  wire [1:0]I4;
  wire [1:0]I5;
  wire I_0;
  wire [15:0]Q;
  wire [0:0]RXPD;
  wire [0:0]TXBUFSTATUS;
  wire [0:0]TXPD;
  wire data_out;
  wire gt0_qplloutclk_out;
  wire gt0_qplloutrefclk_out;
  wire gt0_rxmcommaalignen_in;
  wire gtrefclk_out;
  wire independent_clock_bufg;
  wire mmcm_locked_out;
  wire reset_out;
  wire resetdone;
  wire rxn;
  wire rxp;
  wire rxreset;
  wire txn;
  wire txoutclk;
  wire txp;

gmii_to_sgmiigmii_to_sgmii_GTWIZARD_init__parameterized0 U0
       (.AR(AR),
        .CLK(CLK),
        .D(D),
        .I1(I1),
        .I2(I2),
        .I3(I3),
        .I4(I4),
        .I5(I5),
        .I_0(I_0),
        .Q(Q),
        .RXPD(RXPD),
        .TXBUFSTATUS(TXBUFSTATUS),
        .TXPD(TXPD),
        .data_out(data_out),
        .gt0_qplloutclk_out(gt0_qplloutclk_out),
        .gt0_qplloutrefclk_out(gt0_qplloutrefclk_out),
        .gt0_rxmcommaalignen_in(gt0_rxmcommaalignen_in),
        .gtrefclk_out(gtrefclk_out),
        .independent_clock_bufg(independent_clock_bufg),
        .mmcm_locked_out(mmcm_locked_out),
        .reset_out(reset_out),
        .resetdone(resetdone),
        .rxn(rxn),
        .rxp(rxp),
        .rxreset(rxreset),
        .txn(txn),
        .txoutclk(txoutclk),
        .txp(txp));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_GTWIZARD_init" *) 
module gmii_to_sgmiigmii_to_sgmii_GTWIZARD_init__parameterized0
   (txn,
    txp,
    I_0,
    txoutclk,
    TXBUFSTATUS,
    D,
    resetdone,
    independent_clock_bufg,
    CLK,
    rxn,
    rxp,
    gtrefclk_out,
    gt0_qplloutclk_out,
    gt0_qplloutrefclk_out,
    gt0_rxmcommaalignen_in,
    I1,
    TXPD,
    I2,
    RXPD,
    Q,
    I3,
    I4,
    I5,
    mmcm_locked_out,
    data_out,
    AR,
    rxreset,
    reset_out);
  output txn;
  output txp;
  output I_0;
  output txoutclk;
  output [0:0]TXBUFSTATUS;
  output [23:0]D;
  output resetdone;
  input independent_clock_bufg;
  input CLK;
  input rxn;
  input rxp;
  input gtrefclk_out;
  input gt0_qplloutclk_out;
  input gt0_qplloutrefclk_out;
  input gt0_rxmcommaalignen_in;
  input I1;
  input [0:0]TXPD;
  input I2;
  input [0:0]RXPD;
  input [15:0]Q;
  input [1:0]I3;
  input [1:0]I4;
  input [1:0]I5;
  input mmcm_locked_out;
  input data_out;
  input [0:0]AR;
  input rxreset;
  input reset_out;

  wire [0:0]AR;
  wire CLK;
  wire CPLL_RESET;
  wire [23:0]D;
  wire I1;
  wire I2;
  wire [1:0]I3;
  wire [1:0]I4;
  wire [1:0]I5;
  wire I_0;
  wire [15:0]Q;
  wire RXDFELFHOLD;
  wire [0:0]RXPD;
  wire RXUSERRDY;
  wire [0:0]TXBUFSTATUS;
  wire [0:0]TXPD;
  wire TXUSERRDY;
  wire data_out;
  wire data_out_0;
  wire gt0_gtrxreset_in1_out;
  wire gt0_gttxreset_in0_out;
  wire gt0_qplloutclk_out;
  wire gt0_qplloutrefclk_out;
  wire [13:0]gt0_rx_cdrlock_counter;
  wire [13:0]gt0_rx_cdrlock_counter_1;
  wire gt0_rxmcommaalignen_in;
  wire gt0_txresetdone_out;
  wire gtrefclk_out;
  wire independent_clock_bufg;
  wire mmcm_locked_out;
  wire \n_0_gt0_rx_cdrlock_counter[12]_i_3 ;
  wire \n_0_gt0_rx_cdrlock_counter[12]_i_4 ;
  wire \n_0_gt0_rx_cdrlock_counter[12]_i_5 ;
  wire \n_0_gt0_rx_cdrlock_counter[12]_i_6 ;
  wire \n_0_gt0_rx_cdrlock_counter[13]_i_2 ;
  wire \n_0_gt0_rx_cdrlock_counter[13]_i_3 ;
  wire \n_0_gt0_rx_cdrlock_counter[13]_i_5 ;
  wire \n_0_gt0_rx_cdrlock_counter[4]_i_3 ;
  wire \n_0_gt0_rx_cdrlock_counter[4]_i_4 ;
  wire \n_0_gt0_rx_cdrlock_counter[4]_i_5 ;
  wire \n_0_gt0_rx_cdrlock_counter[4]_i_6 ;
  wire \n_0_gt0_rx_cdrlock_counter[8]_i_3 ;
  wire \n_0_gt0_rx_cdrlock_counter[8]_i_4 ;
  wire \n_0_gt0_rx_cdrlock_counter[8]_i_5 ;
  wire \n_0_gt0_rx_cdrlock_counter[8]_i_6 ;
  wire \n_0_gt0_rx_cdrlock_counter_reg[12]_i_2 ;
  wire \n_0_gt0_rx_cdrlock_counter_reg[4]_i_2 ;
  wire \n_0_gt0_rx_cdrlock_counter_reg[8]_i_2 ;
  wire n_0_gt0_rx_cdrlocked_i_1;
  wire n_0_gt0_rx_cdrlocked_reg;
  wire n_0_gtwizard_i;
  wire \n_1_gt0_rx_cdrlock_counter_reg[12]_i_2 ;
  wire \n_1_gt0_rx_cdrlock_counter_reg[4]_i_2 ;
  wire \n_1_gt0_rx_cdrlock_counter_reg[8]_i_2 ;
  wire \n_2_gt0_rx_cdrlock_counter_reg[12]_i_2 ;
  wire \n_2_gt0_rx_cdrlock_counter_reg[4]_i_2 ;
  wire \n_2_gt0_rx_cdrlock_counter_reg[8]_i_2 ;
  wire \n_3_gt0_rx_cdrlock_counter_reg[12]_i_2 ;
  wire \n_3_gt0_rx_cdrlock_counter_reg[4]_i_2 ;
  wire \n_3_gt0_rx_cdrlock_counter_reg[8]_i_2 ;
  wire \n_4_gt0_rx_cdrlock_counter_reg[12]_i_2 ;
  wire \n_4_gt0_rx_cdrlock_counter_reg[4]_i_2 ;
  wire \n_4_gt0_rx_cdrlock_counter_reg[8]_i_2 ;
  wire n_4_gtwizard_i;
  wire \n_5_gt0_rx_cdrlock_counter_reg[12]_i_2 ;
  wire \n_5_gt0_rx_cdrlock_counter_reg[4]_i_2 ;
  wire \n_5_gt0_rx_cdrlock_counter_reg[8]_i_2 ;
  wire \n_6_gt0_rx_cdrlock_counter_reg[12]_i_2 ;
  wire \n_6_gt0_rx_cdrlock_counter_reg[4]_i_2 ;
  wire \n_6_gt0_rx_cdrlock_counter_reg[8]_i_2 ;
  wire n_6_gtwizard_i;
  wire \n_7_gt0_rx_cdrlock_counter_reg[12]_i_2 ;
  wire \n_7_gt0_rx_cdrlock_counter_reg[13]_i_4 ;
  wire \n_7_gt0_rx_cdrlock_counter_reg[4]_i_2 ;
  wire \n_7_gt0_rx_cdrlock_counter_reg[8]_i_2 ;
  wire reset_out;
  wire resetdone;
  wire rxn;
  wire rxp;
  wire rxreset;
  wire txn;
  wire txoutclk;
  wire txp;
  wire [3:0]\NLW_gt0_rx_cdrlock_counter_reg[13]_i_4_CO_UNCONNECTED ;
  wire [3:1]\NLW_gt0_rx_cdrlock_counter_reg[13]_i_4_O_UNCONNECTED ;

(* SOFT_HLUTNM = "soft_lutpair98" *) 
   LUT4 #(
    .INIT(16'h00FE)) 
     \gt0_rx_cdrlock_counter[0]_i_1 
       (.I0(\n_0_gt0_rx_cdrlock_counter[13]_i_2 ),
        .I1(gt0_rx_cdrlock_counter[5]),
        .I2(\n_0_gt0_rx_cdrlock_counter[13]_i_3 ),
        .I3(gt0_rx_cdrlock_counter[0]),
        .O(gt0_rx_cdrlock_counter_1[0]));
LUT5 #(
    .INIT(32'hFF00FF01)) 
     \gt0_rx_cdrlock_counter[10]_i_1 
       (.I0(\n_0_gt0_rx_cdrlock_counter[13]_i_2 ),
        .I1(gt0_rx_cdrlock_counter[5]),
        .I2(\n_0_gt0_rx_cdrlock_counter[13]_i_3 ),
        .I3(\n_6_gt0_rx_cdrlock_counter_reg[12]_i_2 ),
        .I4(gt0_rx_cdrlock_counter[0]),
        .O(gt0_rx_cdrlock_counter_1[10]));
LUT5 #(
    .INIT(32'hFFFE0000)) 
     \gt0_rx_cdrlock_counter[11]_i_1 
       (.I0(\n_0_gt0_rx_cdrlock_counter[13]_i_2 ),
        .I1(gt0_rx_cdrlock_counter[5]),
        .I2(\n_0_gt0_rx_cdrlock_counter[13]_i_3 ),
        .I3(gt0_rx_cdrlock_counter[0]),
        .I4(\n_5_gt0_rx_cdrlock_counter_reg[12]_i_2 ),
        .O(gt0_rx_cdrlock_counter_1[11]));
LUT5 #(
    .INIT(32'hFFFE0000)) 
     \gt0_rx_cdrlock_counter[12]_i_1 
       (.I0(\n_0_gt0_rx_cdrlock_counter[13]_i_2 ),
        .I1(gt0_rx_cdrlock_counter[5]),
        .I2(\n_0_gt0_rx_cdrlock_counter[13]_i_3 ),
        .I3(gt0_rx_cdrlock_counter[0]),
        .I4(\n_4_gt0_rx_cdrlock_counter_reg[12]_i_2 ),
        .O(gt0_rx_cdrlock_counter_1[12]));
LUT1 #(
    .INIT(2'h2)) 
     \gt0_rx_cdrlock_counter[12]_i_3 
       (.I0(gt0_rx_cdrlock_counter[12]),
        .O(\n_0_gt0_rx_cdrlock_counter[12]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \gt0_rx_cdrlock_counter[12]_i_4 
       (.I0(gt0_rx_cdrlock_counter[11]),
        .O(\n_0_gt0_rx_cdrlock_counter[12]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \gt0_rx_cdrlock_counter[12]_i_5 
       (.I0(gt0_rx_cdrlock_counter[10]),
        .O(\n_0_gt0_rx_cdrlock_counter[12]_i_5 ));
LUT1 #(
    .INIT(2'h2)) 
     \gt0_rx_cdrlock_counter[12]_i_6 
       (.I0(gt0_rx_cdrlock_counter[9]),
        .O(\n_0_gt0_rx_cdrlock_counter[12]_i_6 ));
LUT5 #(
    .INIT(32'hFF00FF01)) 
     \gt0_rx_cdrlock_counter[13]_i_1 
       (.I0(\n_0_gt0_rx_cdrlock_counter[13]_i_2 ),
        .I1(gt0_rx_cdrlock_counter[5]),
        .I2(\n_0_gt0_rx_cdrlock_counter[13]_i_3 ),
        .I3(\n_7_gt0_rx_cdrlock_counter_reg[13]_i_4 ),
        .I4(gt0_rx_cdrlock_counter[0]),
        .O(gt0_rx_cdrlock_counter_1[13]));
LUT6 #(
    .INIT(64'hFFFFFFFDFFFFFFFF)) 
     \gt0_rx_cdrlock_counter[13]_i_2 
       (.I0(gt0_rx_cdrlock_counter[10]),
        .I1(gt0_rx_cdrlock_counter[12]),
        .I2(gt0_rx_cdrlock_counter[2]),
        .I3(gt0_rx_cdrlock_counter[3]),
        .I4(gt0_rx_cdrlock_counter[1]),
        .I5(gt0_rx_cdrlock_counter[13]),
        .O(\n_0_gt0_rx_cdrlock_counter[13]_i_2 ));
LUT6 #(
    .INIT(64'hFFFFFDFFFFFFFFFF)) 
     \gt0_rx_cdrlock_counter[13]_i_3 
       (.I0(gt0_rx_cdrlock_counter[4]),
        .I1(gt0_rx_cdrlock_counter[6]),
        .I2(gt0_rx_cdrlock_counter[11]),
        .I3(gt0_rx_cdrlock_counter[9]),
        .I4(gt0_rx_cdrlock_counter[7]),
        .I5(gt0_rx_cdrlock_counter[8]),
        .O(\n_0_gt0_rx_cdrlock_counter[13]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \gt0_rx_cdrlock_counter[13]_i_5 
       (.I0(gt0_rx_cdrlock_counter[13]),
        .O(\n_0_gt0_rx_cdrlock_counter[13]_i_5 ));
LUT5 #(
    .INIT(32'hFFFE0000)) 
     \gt0_rx_cdrlock_counter[1]_i_1 
       (.I0(\n_0_gt0_rx_cdrlock_counter[13]_i_2 ),
        .I1(gt0_rx_cdrlock_counter[5]),
        .I2(\n_0_gt0_rx_cdrlock_counter[13]_i_3 ),
        .I3(gt0_rx_cdrlock_counter[0]),
        .I4(\n_7_gt0_rx_cdrlock_counter_reg[4]_i_2 ),
        .O(gt0_rx_cdrlock_counter_1[1]));
LUT5 #(
    .INIT(32'hFFFE0000)) 
     \gt0_rx_cdrlock_counter[2]_i_1 
       (.I0(\n_0_gt0_rx_cdrlock_counter[13]_i_2 ),
        .I1(gt0_rx_cdrlock_counter[5]),
        .I2(\n_0_gt0_rx_cdrlock_counter[13]_i_3 ),
        .I3(gt0_rx_cdrlock_counter[0]),
        .I4(\n_6_gt0_rx_cdrlock_counter_reg[4]_i_2 ),
        .O(gt0_rx_cdrlock_counter_1[2]));
LUT5 #(
    .INIT(32'hFFFE0000)) 
     \gt0_rx_cdrlock_counter[3]_i_1 
       (.I0(\n_0_gt0_rx_cdrlock_counter[13]_i_2 ),
        .I1(gt0_rx_cdrlock_counter[5]),
        .I2(\n_0_gt0_rx_cdrlock_counter[13]_i_3 ),
        .I3(gt0_rx_cdrlock_counter[0]),
        .I4(\n_5_gt0_rx_cdrlock_counter_reg[4]_i_2 ),
        .O(gt0_rx_cdrlock_counter_1[3]));
LUT5 #(
    .INIT(32'hFF00FF01)) 
     \gt0_rx_cdrlock_counter[4]_i_1 
       (.I0(\n_0_gt0_rx_cdrlock_counter[13]_i_2 ),
        .I1(gt0_rx_cdrlock_counter[5]),
        .I2(\n_0_gt0_rx_cdrlock_counter[13]_i_3 ),
        .I3(\n_4_gt0_rx_cdrlock_counter_reg[4]_i_2 ),
        .I4(gt0_rx_cdrlock_counter[0]),
        .O(gt0_rx_cdrlock_counter_1[4]));
LUT1 #(
    .INIT(2'h2)) 
     \gt0_rx_cdrlock_counter[4]_i_3 
       (.I0(gt0_rx_cdrlock_counter[4]),
        .O(\n_0_gt0_rx_cdrlock_counter[4]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \gt0_rx_cdrlock_counter[4]_i_4 
       (.I0(gt0_rx_cdrlock_counter[3]),
        .O(\n_0_gt0_rx_cdrlock_counter[4]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \gt0_rx_cdrlock_counter[4]_i_5 
       (.I0(gt0_rx_cdrlock_counter[2]),
        .O(\n_0_gt0_rx_cdrlock_counter[4]_i_5 ));
LUT1 #(
    .INIT(2'h2)) 
     \gt0_rx_cdrlock_counter[4]_i_6 
       (.I0(gt0_rx_cdrlock_counter[1]),
        .O(\n_0_gt0_rx_cdrlock_counter[4]_i_6 ));
LUT5 #(
    .INIT(32'hFFFE0000)) 
     \gt0_rx_cdrlock_counter[5]_i_1 
       (.I0(\n_0_gt0_rx_cdrlock_counter[13]_i_2 ),
        .I1(gt0_rx_cdrlock_counter[5]),
        .I2(\n_0_gt0_rx_cdrlock_counter[13]_i_3 ),
        .I3(gt0_rx_cdrlock_counter[0]),
        .I4(\n_7_gt0_rx_cdrlock_counter_reg[8]_i_2 ),
        .O(gt0_rx_cdrlock_counter_1[5]));
LUT5 #(
    .INIT(32'hFFFE0000)) 
     \gt0_rx_cdrlock_counter[6]_i_1 
       (.I0(\n_0_gt0_rx_cdrlock_counter[13]_i_2 ),
        .I1(gt0_rx_cdrlock_counter[5]),
        .I2(\n_0_gt0_rx_cdrlock_counter[13]_i_3 ),
        .I3(gt0_rx_cdrlock_counter[0]),
        .I4(\n_6_gt0_rx_cdrlock_counter_reg[8]_i_2 ),
        .O(gt0_rx_cdrlock_counter_1[6]));
LUT5 #(
    .INIT(32'hFFFE0000)) 
     \gt0_rx_cdrlock_counter[7]_i_1 
       (.I0(\n_0_gt0_rx_cdrlock_counter[13]_i_2 ),
        .I1(gt0_rx_cdrlock_counter[5]),
        .I2(\n_0_gt0_rx_cdrlock_counter[13]_i_3 ),
        .I3(gt0_rx_cdrlock_counter[0]),
        .I4(\n_5_gt0_rx_cdrlock_counter_reg[8]_i_2 ),
        .O(gt0_rx_cdrlock_counter_1[7]));
(* SOFT_HLUTNM = "soft_lutpair98" *) 
   LUT5 #(
    .INIT(32'hFF00FF01)) 
     \gt0_rx_cdrlock_counter[8]_i_1 
       (.I0(\n_0_gt0_rx_cdrlock_counter[13]_i_2 ),
        .I1(gt0_rx_cdrlock_counter[5]),
        .I2(\n_0_gt0_rx_cdrlock_counter[13]_i_3 ),
        .I3(\n_4_gt0_rx_cdrlock_counter_reg[8]_i_2 ),
        .I4(gt0_rx_cdrlock_counter[0]),
        .O(gt0_rx_cdrlock_counter_1[8]));
LUT1 #(
    .INIT(2'h2)) 
     \gt0_rx_cdrlock_counter[8]_i_3 
       (.I0(gt0_rx_cdrlock_counter[8]),
        .O(\n_0_gt0_rx_cdrlock_counter[8]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \gt0_rx_cdrlock_counter[8]_i_4 
       (.I0(gt0_rx_cdrlock_counter[7]),
        .O(\n_0_gt0_rx_cdrlock_counter[8]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \gt0_rx_cdrlock_counter[8]_i_5 
       (.I0(gt0_rx_cdrlock_counter[6]),
        .O(\n_0_gt0_rx_cdrlock_counter[8]_i_5 ));
LUT1 #(
    .INIT(2'h2)) 
     \gt0_rx_cdrlock_counter[8]_i_6 
       (.I0(gt0_rx_cdrlock_counter[5]),
        .O(\n_0_gt0_rx_cdrlock_counter[8]_i_6 ));
LUT5 #(
    .INIT(32'hFF00FF01)) 
     \gt0_rx_cdrlock_counter[9]_i_1 
       (.I0(\n_0_gt0_rx_cdrlock_counter[13]_i_2 ),
        .I1(gt0_rx_cdrlock_counter[5]),
        .I2(\n_0_gt0_rx_cdrlock_counter[13]_i_3 ),
        .I3(\n_7_gt0_rx_cdrlock_counter_reg[12]_i_2 ),
        .I4(gt0_rx_cdrlock_counter[0]),
        .O(gt0_rx_cdrlock_counter_1[9]));
FDRE #(
    .INIT(1'b0)) 
     \gt0_rx_cdrlock_counter_reg[0] 
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(gt0_rx_cdrlock_counter_1[0]),
        .Q(gt0_rx_cdrlock_counter[0]),
        .R(data_out_0));
FDRE #(
    .INIT(1'b0)) 
     \gt0_rx_cdrlock_counter_reg[10] 
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(gt0_rx_cdrlock_counter_1[10]),
        .Q(gt0_rx_cdrlock_counter[10]),
        .R(data_out_0));
FDRE #(
    .INIT(1'b0)) 
     \gt0_rx_cdrlock_counter_reg[11] 
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(gt0_rx_cdrlock_counter_1[11]),
        .Q(gt0_rx_cdrlock_counter[11]),
        .R(data_out_0));
FDRE #(
    .INIT(1'b0)) 
     \gt0_rx_cdrlock_counter_reg[12] 
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(gt0_rx_cdrlock_counter_1[12]),
        .Q(gt0_rx_cdrlock_counter[12]),
        .R(data_out_0));
CARRY4 \gt0_rx_cdrlock_counter_reg[12]_i_2 
       (.CI(\n_0_gt0_rx_cdrlock_counter_reg[8]_i_2 ),
        .CO({\n_0_gt0_rx_cdrlock_counter_reg[12]_i_2 ,\n_1_gt0_rx_cdrlock_counter_reg[12]_i_2 ,\n_2_gt0_rx_cdrlock_counter_reg[12]_i_2 ,\n_3_gt0_rx_cdrlock_counter_reg[12]_i_2 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_gt0_rx_cdrlock_counter_reg[12]_i_2 ,\n_5_gt0_rx_cdrlock_counter_reg[12]_i_2 ,\n_6_gt0_rx_cdrlock_counter_reg[12]_i_2 ,\n_7_gt0_rx_cdrlock_counter_reg[12]_i_2 }),
        .S({\n_0_gt0_rx_cdrlock_counter[12]_i_3 ,\n_0_gt0_rx_cdrlock_counter[12]_i_4 ,\n_0_gt0_rx_cdrlock_counter[12]_i_5 ,\n_0_gt0_rx_cdrlock_counter[12]_i_6 }));
FDRE #(
    .INIT(1'b0)) 
     \gt0_rx_cdrlock_counter_reg[13] 
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(gt0_rx_cdrlock_counter_1[13]),
        .Q(gt0_rx_cdrlock_counter[13]),
        .R(data_out_0));
CARRY4 \gt0_rx_cdrlock_counter_reg[13]_i_4 
       (.CI(\n_0_gt0_rx_cdrlock_counter_reg[12]_i_2 ),
        .CO(\NLW_gt0_rx_cdrlock_counter_reg[13]_i_4_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_gt0_rx_cdrlock_counter_reg[13]_i_4_O_UNCONNECTED [3:1],\n_7_gt0_rx_cdrlock_counter_reg[13]_i_4 }),
        .S({1'b0,1'b0,1'b0,\n_0_gt0_rx_cdrlock_counter[13]_i_5 }));
FDRE #(
    .INIT(1'b0)) 
     \gt0_rx_cdrlock_counter_reg[1] 
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(gt0_rx_cdrlock_counter_1[1]),
        .Q(gt0_rx_cdrlock_counter[1]),
        .R(data_out_0));
FDRE #(
    .INIT(1'b0)) 
     \gt0_rx_cdrlock_counter_reg[2] 
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(gt0_rx_cdrlock_counter_1[2]),
        .Q(gt0_rx_cdrlock_counter[2]),
        .R(data_out_0));
FDRE #(
    .INIT(1'b0)) 
     \gt0_rx_cdrlock_counter_reg[3] 
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(gt0_rx_cdrlock_counter_1[3]),
        .Q(gt0_rx_cdrlock_counter[3]),
        .R(data_out_0));
FDRE #(
    .INIT(1'b0)) 
     \gt0_rx_cdrlock_counter_reg[4] 
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(gt0_rx_cdrlock_counter_1[4]),
        .Q(gt0_rx_cdrlock_counter[4]),
        .R(data_out_0));
CARRY4 \gt0_rx_cdrlock_counter_reg[4]_i_2 
       (.CI(1'b0),
        .CO({\n_0_gt0_rx_cdrlock_counter_reg[4]_i_2 ,\n_1_gt0_rx_cdrlock_counter_reg[4]_i_2 ,\n_2_gt0_rx_cdrlock_counter_reg[4]_i_2 ,\n_3_gt0_rx_cdrlock_counter_reg[4]_i_2 }),
        .CYINIT(gt0_rx_cdrlock_counter[0]),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_gt0_rx_cdrlock_counter_reg[4]_i_2 ,\n_5_gt0_rx_cdrlock_counter_reg[4]_i_2 ,\n_6_gt0_rx_cdrlock_counter_reg[4]_i_2 ,\n_7_gt0_rx_cdrlock_counter_reg[4]_i_2 }),
        .S({\n_0_gt0_rx_cdrlock_counter[4]_i_3 ,\n_0_gt0_rx_cdrlock_counter[4]_i_4 ,\n_0_gt0_rx_cdrlock_counter[4]_i_5 ,\n_0_gt0_rx_cdrlock_counter[4]_i_6 }));
FDRE #(
    .INIT(1'b0)) 
     \gt0_rx_cdrlock_counter_reg[5] 
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(gt0_rx_cdrlock_counter_1[5]),
        .Q(gt0_rx_cdrlock_counter[5]),
        .R(data_out_0));
FDRE #(
    .INIT(1'b0)) 
     \gt0_rx_cdrlock_counter_reg[6] 
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(gt0_rx_cdrlock_counter_1[6]),
        .Q(gt0_rx_cdrlock_counter[6]),
        .R(data_out_0));
FDRE #(
    .INIT(1'b0)) 
     \gt0_rx_cdrlock_counter_reg[7] 
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(gt0_rx_cdrlock_counter_1[7]),
        .Q(gt0_rx_cdrlock_counter[7]),
        .R(data_out_0));
FDRE #(
    .INIT(1'b0)) 
     \gt0_rx_cdrlock_counter_reg[8] 
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(gt0_rx_cdrlock_counter_1[8]),
        .Q(gt0_rx_cdrlock_counter[8]),
        .R(data_out_0));
CARRY4 \gt0_rx_cdrlock_counter_reg[8]_i_2 
       (.CI(\n_0_gt0_rx_cdrlock_counter_reg[4]_i_2 ),
        .CO({\n_0_gt0_rx_cdrlock_counter_reg[8]_i_2 ,\n_1_gt0_rx_cdrlock_counter_reg[8]_i_2 ,\n_2_gt0_rx_cdrlock_counter_reg[8]_i_2 ,\n_3_gt0_rx_cdrlock_counter_reg[8]_i_2 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_gt0_rx_cdrlock_counter_reg[8]_i_2 ,\n_5_gt0_rx_cdrlock_counter_reg[8]_i_2 ,\n_6_gt0_rx_cdrlock_counter_reg[8]_i_2 ,\n_7_gt0_rx_cdrlock_counter_reg[8]_i_2 }),
        .S({\n_0_gt0_rx_cdrlock_counter[8]_i_3 ,\n_0_gt0_rx_cdrlock_counter[8]_i_4 ,\n_0_gt0_rx_cdrlock_counter[8]_i_5 ,\n_0_gt0_rx_cdrlock_counter[8]_i_6 }));
FDRE #(
    .INIT(1'b0)) 
     \gt0_rx_cdrlock_counter_reg[9] 
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(gt0_rx_cdrlock_counter_1[9]),
        .Q(gt0_rx_cdrlock_counter[9]),
        .R(data_out_0));
LUT5 #(
    .INIT(32'hFF00FF01)) 
     gt0_rx_cdrlocked_i_1
       (.I0(\n_0_gt0_rx_cdrlock_counter[13]_i_2 ),
        .I1(gt0_rx_cdrlock_counter[5]),
        .I2(\n_0_gt0_rx_cdrlock_counter[13]_i_3 ),
        .I3(n_0_gt0_rx_cdrlocked_reg),
        .I4(gt0_rx_cdrlock_counter[0]),
        .O(n_0_gt0_rx_cdrlocked_i_1));
FDRE gt0_rx_cdrlocked_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_gt0_rx_cdrlocked_i_1),
        .Q(n_0_gt0_rx_cdrlocked_reg),
        .R(data_out_0));
gmii_to_sgmiigmii_to_sgmii_RX_STARTUP_FSM__parameterized0 gt0_rxresetfsm_i
       (.AR(AR),
        .I1(I1),
        .I2(n_4_gtwizard_i),
        .I3(n_0_gtwizard_i),
        .I4(n_0_gt0_rx_cdrlocked_reg),
        .RXDFELFHOLD(RXDFELFHOLD),
        .RXUSERRDY(RXUSERRDY),
        .data_out(data_out),
        .gt0_gtrxreset_in1_out(gt0_gtrxreset_in1_out),
        .gt0_txresetdone_out(gt0_txresetdone_out),
        .independent_clock_bufg(independent_clock_bufg),
        .mmcm_locked_out(mmcm_locked_out),
        .resetdone(resetdone),
        .rxreset(rxreset));
gmii_to_sgmiigmii_to_sgmii_TX_STARTUP_FSM__parameterized0 gt0_txresetfsm_i
       (.AR(AR),
        .CPLL_RESET(CPLL_RESET),
        .I1(n_6_gtwizard_i),
        .I2(I2),
        .I3(n_0_gtwizard_i),
        .TXUSERRDY(TXUSERRDY),
        .gt0_gttxreset_in0_out(gt0_gttxreset_in0_out),
        .gt0_txresetdone_out(gt0_txresetdone_out),
        .independent_clock_bufg(independent_clock_bufg),
        .mmcm_locked_out(mmcm_locked_out),
        .reset_out(reset_out));
gmii_to_sgmiigmii_to_sgmii_GTWIZARD_multi_gt__parameterized0 gtwizard_i
       (.CLK(CLK),
        .CPLL_RESET(CPLL_RESET),
        .D(D),
        .I1(I1),
        .I2(I2),
        .I3(I3),
        .I4(I4),
        .I5(I5),
        .I_0(I_0),
        .O1(n_0_gtwizard_i),
        .O2(n_4_gtwizard_i),
        .O3(n_6_gtwizard_i),
        .Q(Q),
        .RXDFELFHOLD(RXDFELFHOLD),
        .RXPD(RXPD),
        .RXUSERRDY(RXUSERRDY),
        .TXBUFSTATUS(TXBUFSTATUS),
        .TXPD(TXPD),
        .TXUSERRDY(TXUSERRDY),
        .gt0_gtrxreset_in1_out(gt0_gtrxreset_in1_out),
        .gt0_gttxreset_in0_out(gt0_gttxreset_in0_out),
        .gt0_qplloutclk_out(gt0_qplloutclk_out),
        .gt0_qplloutrefclk_out(gt0_qplloutrefclk_out),
        .gt0_rxmcommaalignen_in(gt0_rxmcommaalignen_in),
        .gtrefclk_out(gtrefclk_out),
        .independent_clock_bufg(independent_clock_bufg),
        .rxn(rxn),
        .rxp(rxp),
        .txn(txn),
        .txoutclk(txoutclk),
        .txp(txp));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gmii_to_sgmiigmii_to_sgmii_sync_block__parameterized0__33 sync_block_gtrxreset
       (.clk(independent_clock_bufg),
        .data_in(gt0_gtrxreset_in1_out),
        .data_out(data_out_0));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_GTWIZARD_multi_gt" *) 
module gmii_to_sgmiigmii_to_sgmii_GTWIZARD_multi_gt__parameterized0
   (O1,
    txn,
    txp,
    I_0,
    O2,
    txoutclk,
    O3,
    TXBUFSTATUS,
    D,
    independent_clock_bufg,
    CPLL_RESET,
    CLK,
    rxn,
    rxp,
    gtrefclk_out,
    gt0_gttxreset_in0_out,
    gt0_qplloutclk_out,
    gt0_qplloutrefclk_out,
    RXDFELFHOLD,
    gt0_rxmcommaalignen_in,
    RXUSERRDY,
    I1,
    TXPD,
    TXUSERRDY,
    I2,
    RXPD,
    Q,
    I3,
    I4,
    I5,
    gt0_gtrxreset_in1_out);
  output O1;
  output txn;
  output txp;
  output I_0;
  output O2;
  output txoutclk;
  output O3;
  output [0:0]TXBUFSTATUS;
  output [23:0]D;
  input independent_clock_bufg;
  input CPLL_RESET;
  input CLK;
  input rxn;
  input rxp;
  input gtrefclk_out;
  input gt0_gttxreset_in0_out;
  input gt0_qplloutclk_out;
  input gt0_qplloutrefclk_out;
  input RXDFELFHOLD;
  input gt0_rxmcommaalignen_in;
  input RXUSERRDY;
  input I1;
  input [0:0]TXPD;
  input TXUSERRDY;
  input I2;
  input [0:0]RXPD;
  input [15:0]Q;
  input [1:0]I3;
  input [1:0]I4;
  input [1:0]I5;
  input gt0_gtrxreset_in1_out;

  wire CLK;
  wire CPLL_RESET;
  wire [23:0]D;
  wire I1;
  wire I2;
  wire [1:0]I3;
  wire [1:0]I4;
  wire [1:0]I5;
  wire I_0;
  wire O1;
  wire O2;
  wire O3;
  wire [15:0]Q;
  wire RXDFELFHOLD;
  wire [0:0]RXPD;
  wire RXUSERRDY;
  wire [0:0]TXBUFSTATUS;
  wire [0:0]TXPD;
  wire TXUSERRDY;
  wire gt0_gtrxreset_in1_out;
  wire gt0_gttxreset_in0_out;
  wire gt0_qplloutclk_out;
  wire gt0_qplloutrefclk_out;
  wire gt0_rxmcommaalignen_in;
  wire gtrefclk_out;
  wire independent_clock_bufg;
  wire rxn;
  wire rxp;
  wire txn;
  wire txoutclk;
  wire txp;

gmii_to_sgmiigmii_to_sgmii_GTWIZARD_GT__parameterized0 gt0_GTWIZARD_i
       (.CLK(CLK),
        .CPLL_RESET(CPLL_RESET),
        .D(D),
        .I1(I1),
        .I2(I2),
        .I3(I3),
        .I4(I4),
        .I5(I5),
        .I_0(I_0),
        .O1(O1),
        .O2(O2),
        .O3(O3),
        .Q(Q),
        .RXDFELFHOLD(RXDFELFHOLD),
        .RXPD(RXPD),
        .RXUSERRDY(RXUSERRDY),
        .TXBUFSTATUS(TXBUFSTATUS),
        .TXPD(TXPD),
        .TXUSERRDY(TXUSERRDY),
        .gt0_gtrxreset_in1_out(gt0_gtrxreset_in1_out),
        .gt0_gttxreset_in0_out(gt0_gttxreset_in0_out),
        .gt0_qplloutclk_out(gt0_qplloutclk_out),
        .gt0_qplloutrefclk_out(gt0_qplloutrefclk_out),
        .gt0_rxmcommaalignen_in(gt0_rxmcommaalignen_in),
        .gtrefclk_out(gtrefclk_out),
        .independent_clock_bufg(independent_clock_bufg),
        .rxn(rxn),
        .rxp(rxp),
        .txn(txn),
        .txoutclk(txoutclk),
        .txp(txp));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_RX_STARTUP_FSM" *) 
module gmii_to_sgmiigmii_to_sgmii_RX_STARTUP_FSM__parameterized0
   (RXUSERRDY,
    RXDFELFHOLD,
    gt0_gtrxreset_in1_out,
    resetdone,
    I1,
    independent_clock_bufg,
    I2,
    mmcm_locked_out,
    data_out,
    I3,
    AR,
    I4,
    rxreset,
    gt0_txresetdone_out);
  output RXUSERRDY;
  output RXDFELFHOLD;
  output gt0_gtrxreset_in1_out;
  output resetdone;
  input I1;
  input independent_clock_bufg;
  input I2;
  input mmcm_locked_out;
  input data_out;
  input I3;
  input [0:0]AR;
  input I4;
  input rxreset;
  input gt0_txresetdone_out;

  wire [0:0]AR;
  wire GTRXRESET;
  wire I1;
  wire I2;
  wire I3;
  wire I4;
  wire RXDFELFHOLD;
  wire RXUSERRDY;
  wire [22:0]\adapt_wait_hw.adapt_count_reg ;
  wire cplllock_sync;
  wire data_out;
  wire data_out_0;
  wire data_valid_sync;
  wire gt0_gtrxreset_in1_out;
  wire gt0_rxresetdone_out;
  wire gt0_txresetdone_out;
  wire independent_clock_bufg;
  wire [6:0]init_wait_count_reg__0;
  wire [9:0]mmcm_lock_count_reg__0;
  wire mmcm_lock_i;
  wire mmcm_lock_reclocked;
  wire mmcm_locked_out;
  wire \n_0_FSM_sequential_rx_state[0]_i_1 ;
  wire \n_0_FSM_sequential_rx_state[0]_i_2 ;
  wire \n_0_FSM_sequential_rx_state[1]_i_1 ;
  wire \n_0_FSM_sequential_rx_state[2]_i_1 ;
  wire \n_0_FSM_sequential_rx_state[3]_i_1 ;
  wire \n_0_FSM_sequential_rx_state[3]_i_2 ;
  wire \n_0_FSM_sequential_rx_state[3]_i_3 ;
  wire \n_0_FSM_sequential_rx_state[3]_i_4 ;
  wire \n_0_FSM_sequential_rx_state[3]_i_5 ;
  wire \n_0_FSM_sequential_rx_state[3]_i_6 ;
  wire \n_0_FSM_sequential_rx_state[3]_i_8 ;
  wire n_0_RXDFEAGCHOLD_i_1;
  wire n_0_RXUSERRDY_i_1;
  wire n_0_adapt_count_reset_i_1;
  wire \n_0_adapt_wait_hw.adapt_count[0]_i_1 ;
  wire \n_0_adapt_wait_hw.adapt_count[0]_i_10 ;
  wire \n_0_adapt_wait_hw.adapt_count[0]_i_3 ;
  wire \n_0_adapt_wait_hw.adapt_count[0]_i_4 ;
  wire \n_0_adapt_wait_hw.adapt_count[0]_i_5 ;
  wire \n_0_adapt_wait_hw.adapt_count[0]_i_6 ;
  wire \n_0_adapt_wait_hw.adapt_count[0]_i_7 ;
  wire \n_0_adapt_wait_hw.adapt_count[0]_i_8 ;
  wire \n_0_adapt_wait_hw.adapt_count[0]_i_9 ;
  wire \n_0_adapt_wait_hw.adapt_count[12]_i_2 ;
  wire \n_0_adapt_wait_hw.adapt_count[12]_i_3 ;
  wire \n_0_adapt_wait_hw.adapt_count[12]_i_4 ;
  wire \n_0_adapt_wait_hw.adapt_count[12]_i_5 ;
  wire \n_0_adapt_wait_hw.adapt_count[16]_i_2 ;
  wire \n_0_adapt_wait_hw.adapt_count[16]_i_3 ;
  wire \n_0_adapt_wait_hw.adapt_count[16]_i_4 ;
  wire \n_0_adapt_wait_hw.adapt_count[16]_i_5 ;
  wire \n_0_adapt_wait_hw.adapt_count[20]_i_2 ;
  wire \n_0_adapt_wait_hw.adapt_count[20]_i_3 ;
  wire \n_0_adapt_wait_hw.adapt_count[20]_i_4 ;
  wire \n_0_adapt_wait_hw.adapt_count[4]_i_2 ;
  wire \n_0_adapt_wait_hw.adapt_count[4]_i_3 ;
  wire \n_0_adapt_wait_hw.adapt_count[4]_i_4 ;
  wire \n_0_adapt_wait_hw.adapt_count[4]_i_5 ;
  wire \n_0_adapt_wait_hw.adapt_count[8]_i_2 ;
  wire \n_0_adapt_wait_hw.adapt_count[8]_i_3 ;
  wire \n_0_adapt_wait_hw.adapt_count[8]_i_4 ;
  wire \n_0_adapt_wait_hw.adapt_count[8]_i_5 ;
  wire \n_0_adapt_wait_hw.adapt_count_reg[0]_i_2 ;
  wire \n_0_adapt_wait_hw.adapt_count_reg[12]_i_1 ;
  wire \n_0_adapt_wait_hw.adapt_count_reg[16]_i_1 ;
  wire \n_0_adapt_wait_hw.adapt_count_reg[4]_i_1 ;
  wire \n_0_adapt_wait_hw.adapt_count_reg[8]_i_1 ;
  wire \n_0_adapt_wait_hw.time_out_adapt_i_1 ;
  wire \n_0_adapt_wait_hw.time_out_adapt_i_2 ;
  wire \n_0_adapt_wait_hw.time_out_adapt_i_3 ;
  wire \n_0_adapt_wait_hw.time_out_adapt_i_4 ;
  wire \n_0_adapt_wait_hw.time_out_adapt_i_5 ;
  wire \n_0_adapt_wait_hw.time_out_adapt_reg ;
  wire n_0_check_tlock_max_i_1;
  wire n_0_check_tlock_max_reg;
  wire n_0_gtrxreset_i_i_1;
  wire \n_0_init_wait_count[0]_i_1__0 ;
  wire \n_0_init_wait_count[6]_i_1__0 ;
  wire \n_0_init_wait_count[6]_i_3__0 ;
  wire \n_0_init_wait_count[6]_i_4__0 ;
  wire n_0_init_wait_done_i_1__0;
  wire n_0_init_wait_done_i_2__0;
  wire n_0_init_wait_done_reg;
  wire \n_0_mmcm_lock_count[9]_i_1__0 ;
  wire \n_0_mmcm_lock_count[9]_i_2__0 ;
  wire \n_0_mmcm_lock_count[9]_i_4__0 ;
  wire n_0_mmcm_lock_reclocked_i_1__0;
  wire n_0_mmcm_lock_reclocked_i_2__0;
  wire n_0_reset_time_out_i_1__0;
  wire n_0_reset_time_out_i_2__0;
  wire n_0_reset_time_out_i_3__0;
  wire n_0_reset_time_out_i_4;
  wire n_0_reset_time_out_reg;
  wire n_0_run_phase_alignment_int_i_1__0;
  wire n_0_run_phase_alignment_int_reg;
  wire n_0_run_phase_alignment_int_s3_reg;
  wire n_0_rx_fsm_reset_done_int_i_1;
  wire n_0_rx_fsm_reset_done_int_i_2;
  wire n_0_rx_fsm_reset_done_int_i_3;
  wire n_0_time_out_1us_i_1;
  wire n_0_time_out_1us_i_2;
  wire n_0_time_out_1us_i_3;
  wire n_0_time_out_1us_i_4;
  wire n_0_time_out_1us_i_5;
  wire n_0_time_out_1us_reg;
  wire n_0_time_out_2ms_i_1;
  wire n_0_time_out_2ms_i_2__0;
  wire n_0_time_out_2ms_reg;
  wire \n_0_time_out_counter[0]_i_10 ;
  wire \n_0_time_out_counter[0]_i_1__0 ;
  wire \n_0_time_out_counter[0]_i_3__0 ;
  wire \n_0_time_out_counter[0]_i_4__0 ;
  wire \n_0_time_out_counter[0]_i_5__0 ;
  wire \n_0_time_out_counter[0]_i_6__0 ;
  wire \n_0_time_out_counter[0]_i_7__0 ;
  wire \n_0_time_out_counter[0]_i_8 ;
  wire \n_0_time_out_counter[0]_i_9__0 ;
  wire \n_0_time_out_counter[12]_i_2__0 ;
  wire \n_0_time_out_counter[12]_i_3__0 ;
  wire \n_0_time_out_counter[12]_i_4__0 ;
  wire \n_0_time_out_counter[12]_i_5__0 ;
  wire \n_0_time_out_counter[16]_i_2__0 ;
  wire \n_0_time_out_counter[16]_i_3__0 ;
  wire \n_0_time_out_counter[16]_i_4__0 ;
  wire \n_0_time_out_counter[16]_i_5 ;
  wire \n_0_time_out_counter[4]_i_2__0 ;
  wire \n_0_time_out_counter[4]_i_3__0 ;
  wire \n_0_time_out_counter[4]_i_4__0 ;
  wire \n_0_time_out_counter[4]_i_5__0 ;
  wire \n_0_time_out_counter[8]_i_2__0 ;
  wire \n_0_time_out_counter[8]_i_3__0 ;
  wire \n_0_time_out_counter[8]_i_4__0 ;
  wire \n_0_time_out_counter[8]_i_5__0 ;
  wire \n_0_time_out_counter_reg[0]_i_2__0 ;
  wire \n_0_time_out_counter_reg[12]_i_1__0 ;
  wire \n_0_time_out_counter_reg[4]_i_1__0 ;
  wire \n_0_time_out_counter_reg[8]_i_1__0 ;
  wire n_0_time_out_wait_bypass_i_1__0;
  wire n_0_time_out_wait_bypass_reg;
  wire n_0_time_tlock_max_i_10;
  wire n_0_time_tlock_max_i_11;
  wire n_0_time_tlock_max_i_12;
  wire n_0_time_tlock_max_i_13;
  wire n_0_time_tlock_max_i_14;
  wire n_0_time_tlock_max_i_15;
  wire n_0_time_tlock_max_i_16;
  wire n_0_time_tlock_max_i_17;
  wire n_0_time_tlock_max_i_18;
  wire n_0_time_tlock_max_i_19;
  wire n_0_time_tlock_max_i_1__0;
  wire n_0_time_tlock_max_i_20;
  wire n_0_time_tlock_max_i_21;
  wire n_0_time_tlock_max_i_22;
  wire n_0_time_tlock_max_i_4;
  wire n_0_time_tlock_max_i_5;
  wire n_0_time_tlock_max_i_6;
  wire n_0_time_tlock_max_i_7;
  wire n_0_time_tlock_max_i_9;
  wire n_0_time_tlock_max_reg_i_3;
  wire n_0_time_tlock_max_reg_i_8;
  wire \n_0_wait_bypass_count[0]_i_1__0 ;
  wire \n_0_wait_bypass_count[0]_i_2__0 ;
  wire \n_0_wait_bypass_count[0]_i_4__0 ;
  wire \n_0_wait_bypass_count[0]_i_5__0 ;
  wire \n_0_wait_bypass_count[0]_i_6__0 ;
  wire \n_0_wait_bypass_count[0]_i_7__0 ;
  wire \n_0_wait_bypass_count[0]_i_8__0 ;
  wire \n_0_wait_bypass_count[0]_i_9 ;
  wire \n_0_wait_bypass_count[12]_i_2__0 ;
  wire \n_0_wait_bypass_count[4]_i_2__0 ;
  wire \n_0_wait_bypass_count[4]_i_3__0 ;
  wire \n_0_wait_bypass_count[4]_i_4__0 ;
  wire \n_0_wait_bypass_count[4]_i_5__0 ;
  wire \n_0_wait_bypass_count[8]_i_2__0 ;
  wire \n_0_wait_bypass_count[8]_i_3__0 ;
  wire \n_0_wait_bypass_count[8]_i_4__0 ;
  wire \n_0_wait_bypass_count[8]_i_5__0 ;
  wire \n_0_wait_bypass_count_reg[0]_i_3__0 ;
  wire \n_0_wait_bypass_count_reg[4]_i_1__0 ;
  wire \n_0_wait_bypass_count_reg[8]_i_1__0 ;
  wire \n_0_wait_time_cnt[6]_i_1__0 ;
  wire \n_0_wait_time_cnt[6]_i_2__0 ;
  wire \n_0_wait_time_cnt[6]_i_4__0 ;
  wire \n_1_adapt_wait_hw.adapt_count_reg[0]_i_2 ;
  wire \n_1_adapt_wait_hw.adapt_count_reg[12]_i_1 ;
  wire \n_1_adapt_wait_hw.adapt_count_reg[16]_i_1 ;
  wire \n_1_adapt_wait_hw.adapt_count_reg[4]_i_1 ;
  wire \n_1_adapt_wait_hw.adapt_count_reg[8]_i_1 ;
  wire \n_1_time_out_counter_reg[0]_i_2__0 ;
  wire \n_1_time_out_counter_reg[12]_i_1__0 ;
  wire \n_1_time_out_counter_reg[16]_i_1__0 ;
  wire \n_1_time_out_counter_reg[4]_i_1__0 ;
  wire \n_1_time_out_counter_reg[8]_i_1__0 ;
  wire n_1_time_tlock_max_reg_i_3;
  wire n_1_time_tlock_max_reg_i_8;
  wire \n_1_wait_bypass_count_reg[0]_i_3__0 ;
  wire \n_1_wait_bypass_count_reg[4]_i_1__0 ;
  wire \n_1_wait_bypass_count_reg[8]_i_1__0 ;
  wire \n_2_adapt_wait_hw.adapt_count_reg[0]_i_2 ;
  wire \n_2_adapt_wait_hw.adapt_count_reg[12]_i_1 ;
  wire \n_2_adapt_wait_hw.adapt_count_reg[16]_i_1 ;
  wire \n_2_adapt_wait_hw.adapt_count_reg[20]_i_1 ;
  wire \n_2_adapt_wait_hw.adapt_count_reg[4]_i_1 ;
  wire \n_2_adapt_wait_hw.adapt_count_reg[8]_i_1 ;
  wire \n_2_time_out_counter_reg[0]_i_2__0 ;
  wire \n_2_time_out_counter_reg[12]_i_1__0 ;
  wire \n_2_time_out_counter_reg[16]_i_1__0 ;
  wire \n_2_time_out_counter_reg[4]_i_1__0 ;
  wire \n_2_time_out_counter_reg[8]_i_1__0 ;
  wire n_2_time_tlock_max_reg_i_3;
  wire n_2_time_tlock_max_reg_i_8;
  wire \n_2_wait_bypass_count_reg[0]_i_3__0 ;
  wire \n_2_wait_bypass_count_reg[4]_i_1__0 ;
  wire \n_2_wait_bypass_count_reg[8]_i_1__0 ;
  wire \n_3_adapt_wait_hw.adapt_count_reg[0]_i_2 ;
  wire \n_3_adapt_wait_hw.adapt_count_reg[12]_i_1 ;
  wire \n_3_adapt_wait_hw.adapt_count_reg[16]_i_1 ;
  wire \n_3_adapt_wait_hw.adapt_count_reg[20]_i_1 ;
  wire \n_3_adapt_wait_hw.adapt_count_reg[4]_i_1 ;
  wire \n_3_adapt_wait_hw.adapt_count_reg[8]_i_1 ;
  wire \n_3_time_out_counter_reg[0]_i_2__0 ;
  wire \n_3_time_out_counter_reg[12]_i_1__0 ;
  wire \n_3_time_out_counter_reg[16]_i_1__0 ;
  wire \n_3_time_out_counter_reg[4]_i_1__0 ;
  wire \n_3_time_out_counter_reg[8]_i_1__0 ;
  wire n_3_time_tlock_max_reg_i_2;
  wire n_3_time_tlock_max_reg_i_3;
  wire n_3_time_tlock_max_reg_i_8;
  wire \n_3_wait_bypass_count_reg[0]_i_3__0 ;
  wire \n_3_wait_bypass_count_reg[4]_i_1__0 ;
  wire \n_3_wait_bypass_count_reg[8]_i_1__0 ;
  wire \n_4_adapt_wait_hw.adapt_count_reg[0]_i_2 ;
  wire \n_4_adapt_wait_hw.adapt_count_reg[12]_i_1 ;
  wire \n_4_adapt_wait_hw.adapt_count_reg[16]_i_1 ;
  wire \n_4_adapt_wait_hw.adapt_count_reg[4]_i_1 ;
  wire \n_4_adapt_wait_hw.adapt_count_reg[8]_i_1 ;
  wire \n_4_time_out_counter_reg[0]_i_2__0 ;
  wire \n_4_time_out_counter_reg[12]_i_1__0 ;
  wire \n_4_time_out_counter_reg[16]_i_1__0 ;
  wire \n_4_time_out_counter_reg[4]_i_1__0 ;
  wire \n_4_time_out_counter_reg[8]_i_1__0 ;
  wire \n_4_wait_bypass_count_reg[0]_i_3__0 ;
  wire \n_4_wait_bypass_count_reg[4]_i_1__0 ;
  wire \n_4_wait_bypass_count_reg[8]_i_1__0 ;
  wire \n_5_adapt_wait_hw.adapt_count_reg[0]_i_2 ;
  wire \n_5_adapt_wait_hw.adapt_count_reg[12]_i_1 ;
  wire \n_5_adapt_wait_hw.adapt_count_reg[16]_i_1 ;
  wire \n_5_adapt_wait_hw.adapt_count_reg[20]_i_1 ;
  wire \n_5_adapt_wait_hw.adapt_count_reg[4]_i_1 ;
  wire \n_5_adapt_wait_hw.adapt_count_reg[8]_i_1 ;
  wire \n_5_time_out_counter_reg[0]_i_2__0 ;
  wire \n_5_time_out_counter_reg[12]_i_1__0 ;
  wire \n_5_time_out_counter_reg[16]_i_1__0 ;
  wire \n_5_time_out_counter_reg[4]_i_1__0 ;
  wire \n_5_time_out_counter_reg[8]_i_1__0 ;
  wire \n_5_wait_bypass_count_reg[0]_i_3__0 ;
  wire \n_5_wait_bypass_count_reg[4]_i_1__0 ;
  wire \n_5_wait_bypass_count_reg[8]_i_1__0 ;
  wire \n_6_adapt_wait_hw.adapt_count_reg[0]_i_2 ;
  wire \n_6_adapt_wait_hw.adapt_count_reg[12]_i_1 ;
  wire \n_6_adapt_wait_hw.adapt_count_reg[16]_i_1 ;
  wire \n_6_adapt_wait_hw.adapt_count_reg[20]_i_1 ;
  wire \n_6_adapt_wait_hw.adapt_count_reg[4]_i_1 ;
  wire \n_6_adapt_wait_hw.adapt_count_reg[8]_i_1 ;
  wire \n_6_time_out_counter_reg[0]_i_2__0 ;
  wire \n_6_time_out_counter_reg[12]_i_1__0 ;
  wire \n_6_time_out_counter_reg[16]_i_1__0 ;
  wire \n_6_time_out_counter_reg[4]_i_1__0 ;
  wire \n_6_time_out_counter_reg[8]_i_1__0 ;
  wire \n_6_wait_bypass_count_reg[0]_i_3__0 ;
  wire \n_6_wait_bypass_count_reg[4]_i_1__0 ;
  wire \n_6_wait_bypass_count_reg[8]_i_1__0 ;
  wire \n_7_adapt_wait_hw.adapt_count_reg[0]_i_2 ;
  wire \n_7_adapt_wait_hw.adapt_count_reg[12]_i_1 ;
  wire \n_7_adapt_wait_hw.adapt_count_reg[16]_i_1 ;
  wire \n_7_adapt_wait_hw.adapt_count_reg[20]_i_1 ;
  wire \n_7_adapt_wait_hw.adapt_count_reg[4]_i_1 ;
  wire \n_7_adapt_wait_hw.adapt_count_reg[8]_i_1 ;
  wire \n_7_time_out_counter_reg[0]_i_2__0 ;
  wire \n_7_time_out_counter_reg[12]_i_1__0 ;
  wire \n_7_time_out_counter_reg[16]_i_1__0 ;
  wire \n_7_time_out_counter_reg[4]_i_1__0 ;
  wire \n_7_time_out_counter_reg[8]_i_1__0 ;
  wire \n_7_wait_bypass_count_reg[0]_i_3__0 ;
  wire \n_7_wait_bypass_count_reg[12]_i_1__0 ;
  wire \n_7_wait_bypass_count_reg[4]_i_1__0 ;
  wire \n_7_wait_bypass_count_reg[8]_i_1__0 ;
  wire [6:1]p_0_in__1;
  wire [9:0]p_0_in__2;
  wire recclk_mon_count_reset;
  wire resetdone;
  wire rx_fsm_reset_done_int_s2;
  wire rx_fsm_reset_done_int_s3;
(* RTL_KEEP = "yes" *)   wire [3:0]rx_state;
  wire rx_state15_out;
  wire rx_state16_out;
  wire rxreset;
  wire rxresetdone_s2;
  wire rxresetdone_s3;
  wire [19:0]time_out_counter_reg;
  wire time_out_wait_bypass_s2;
  wire time_out_wait_bypass_s3;
  wire time_tlock_max;
  wire time_tlock_max1;
  wire [12:0]wait_bypass_count_reg;
  wire [6:0]wait_time_cnt0__0;
  wire [6:0]wait_time_cnt_reg__0;
  wire [3:2]\NLW_adapt_wait_hw.adapt_count_reg[20]_i_1_CO_UNCONNECTED ;
  wire [3:3]\NLW_adapt_wait_hw.adapt_count_reg[20]_i_1_O_UNCONNECTED ;
  wire [3:3]\NLW_time_out_counter_reg[16]_i_1__0_CO_UNCONNECTED ;
  wire [3:2]NLW_time_tlock_max_reg_i_2_CO_UNCONNECTED;
  wire [3:0]NLW_time_tlock_max_reg_i_2_O_UNCONNECTED;
  wire [3:0]NLW_time_tlock_max_reg_i_3_O_UNCONNECTED;
  wire [3:0]NLW_time_tlock_max_reg_i_8_O_UNCONNECTED;
  wire [3:0]\NLW_wait_bypass_count_reg[12]_i_1__0_CO_UNCONNECTED ;
  wire [3:1]\NLW_wait_bypass_count_reg[12]_i_1__0_O_UNCONNECTED ;

LUT4 #(
    .INIT(16'h444F)) 
     \FSM_sequential_rx_state[0]_i_1 
       (.I0(rx_state[3]),
        .I1(\n_0_FSM_sequential_rx_state[0]_i_2 ),
        .I2(rx_state[2]),
        .I3(rx_state[0]),
        .O(\n_0_FSM_sequential_rx_state[0]_i_1 ));
LUT6 #(
    .INIT(64'h4E0AEE2A4E0ACE0A)) 
     \FSM_sequential_rx_state[0]_i_2 
       (.I0(rx_state[2]),
        .I1(rx_state[1]),
        .I2(rx_state[0]),
        .I3(n_0_time_out_2ms_reg),
        .I4(n_0_reset_time_out_reg),
        .I5(time_tlock_max),
        .O(\n_0_FSM_sequential_rx_state[0]_i_2 ));
LUT6 #(
    .INIT(64'h00000F0000FFDF00)) 
     \FSM_sequential_rx_state[1]_i_1 
       (.I0(time_tlock_max),
        .I1(n_0_reset_time_out_reg),
        .I2(rx_state[2]),
        .I3(rx_state[0]),
        .I4(rx_state[1]),
        .I5(rx_state[3]),
        .O(\n_0_FSM_sequential_rx_state[1]_i_1 ));
LUT6 #(
    .INIT(64'h1111004015150040)) 
     \FSM_sequential_rx_state[2]_i_1 
       (.I0(rx_state[3]),
        .I1(rx_state[0]),
        .I2(rx_state[1]),
        .I3(n_0_time_out_2ms_reg),
        .I4(rx_state[2]),
        .I5(rx_state16_out),
        .O(\n_0_FSM_sequential_rx_state[2]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair74" *) 
   LUT2 #(
    .INIT(4'h2)) 
     \FSM_sequential_rx_state[2]_i_2 
       (.I0(time_tlock_max),
        .I1(n_0_reset_time_out_reg),
        .O(rx_state16_out));
LUT5 #(
    .INIT(32'hFEFEFEAE)) 
     \FSM_sequential_rx_state[3]_i_1 
       (.I0(\n_0_FSM_sequential_rx_state[3]_i_3 ),
        .I1(\n_0_FSM_sequential_rx_state[3]_i_4 ),
        .I2(rx_state[0]),
        .I3(\n_0_FSM_sequential_rx_state[3]_i_5 ),
        .I4(\n_0_FSM_sequential_rx_state[3]_i_6 ),
        .O(\n_0_FSM_sequential_rx_state[3]_i_1 ));
LUT6 #(
    .INIT(64'h000A00A2500A00A2)) 
     \FSM_sequential_rx_state[3]_i_2 
       (.I0(rx_state[3]),
        .I1(time_out_wait_bypass_s3),
        .I2(rx_state[1]),
        .I3(rx_state[2]),
        .I4(rx_state[0]),
        .I5(rx_state15_out),
        .O(\n_0_FSM_sequential_rx_state[3]_i_2 ));
LUT5 #(
    .INIT(32'hCCCC4430)) 
     \FSM_sequential_rx_state[3]_i_3 
       (.I0(data_valid_sync),
        .I1(rx_state[3]),
        .I2(n_0_init_wait_done_reg),
        .I3(rx_state[1]),
        .I4(rx_state[2]),
        .O(\n_0_FSM_sequential_rx_state[3]_i_3 ));
LUT6 #(
    .INIT(64'h0F0F0F0F1F101010)) 
     \FSM_sequential_rx_state[3]_i_4 
       (.I0(wait_time_cnt_reg__0[6]),
        .I1(\n_0_wait_time_cnt[6]_i_4__0 ),
        .I2(rx_state[1]),
        .I3(I4),
        .I4(rx_state[2]),
        .I5(rx_state[3]),
        .O(\n_0_FSM_sequential_rx_state[3]_i_4 ));
LUT6 #(
    .INIT(64'h88A8FFFF88A80000)) 
     \FSM_sequential_rx_state[3]_i_5 
       (.I0(rx_state[1]),
        .I1(rxresetdone_s3),
        .I2(n_0_time_out_2ms_reg),
        .I3(n_0_reset_time_out_reg),
        .I4(rx_state[2]),
        .I5(\n_0_FSM_sequential_rx_state[3]_i_8 ),
        .O(\n_0_FSM_sequential_rx_state[3]_i_5 ));
LUT6 #(
    .INIT(64'hCCCCCCCCB8B8BBB8)) 
     \FSM_sequential_rx_state[3]_i_6 
       (.I0(data_valid_sync),
        .I1(rx_state[3]),
        .I2(mmcm_lock_reclocked),
        .I3(time_tlock_max),
        .I4(n_0_reset_time_out_reg),
        .I5(rx_state[1]),
        .O(\n_0_FSM_sequential_rx_state[3]_i_6 ));
(* SOFT_HLUTNM = "soft_lutpair81" *) 
   LUT2 #(
    .INIT(4'h2)) 
     \FSM_sequential_rx_state[3]_i_7 
       (.I0(n_0_time_out_2ms_reg),
        .I1(n_0_reset_time_out_reg),
        .O(rx_state15_out));
LUT4 #(
    .INIT(16'h5455)) 
     \FSM_sequential_rx_state[3]_i_8 
       (.I0(rx_state[3]),
        .I1(n_0_time_out_2ms_reg),
        .I2(cplllock_sync),
        .I3(rx_state[1]),
        .O(\n_0_FSM_sequential_rx_state[3]_i_8 ));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_rx_state_reg[0] 
       (.C(independent_clock_bufg),
        .CE(\n_0_FSM_sequential_rx_state[3]_i_1 ),
        .D(\n_0_FSM_sequential_rx_state[0]_i_1 ),
        .Q(rx_state[0]),
        .R(AR));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_rx_state_reg[1] 
       (.C(independent_clock_bufg),
        .CE(\n_0_FSM_sequential_rx_state[3]_i_1 ),
        .D(\n_0_FSM_sequential_rx_state[1]_i_1 ),
        .Q(rx_state[1]),
        .R(AR));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_rx_state_reg[2] 
       (.C(independent_clock_bufg),
        .CE(\n_0_FSM_sequential_rx_state[3]_i_1 ),
        .D(\n_0_FSM_sequential_rx_state[2]_i_1 ),
        .Q(rx_state[2]),
        .R(AR));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_rx_state_reg[3] 
       (.C(independent_clock_bufg),
        .CE(\n_0_FSM_sequential_rx_state[3]_i_1 ),
        .D(\n_0_FSM_sequential_rx_state[3]_i_2 ),
        .Q(rx_state[3]),
        .R(AR));
LUT6 #(
    .INIT(64'hFFFFFFFF00400000)) 
     RXDFEAGCHOLD_i_1
       (.I0(rx_state[2]),
        .I1(rx_state[1]),
        .I2(\n_0_adapt_wait_hw.time_out_adapt_reg ),
        .I3(rx_state[0]),
        .I4(rx_state[3]),
        .I5(RXDFELFHOLD),
        .O(n_0_RXDFEAGCHOLD_i_1));
FDRE RXDFEAGCHOLD_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_RXDFEAGCHOLD_i_1),
        .Q(RXDFELFHOLD),
        .R(AR));
LUT5 #(
    .INIT(32'hFFFD2000)) 
     RXUSERRDY_i_1
       (.I0(rx_state[0]),
        .I1(rx_state[3]),
        .I2(rx_state[2]),
        .I3(rx_state[1]),
        .I4(RXUSERRDY),
        .O(n_0_RXUSERRDY_i_1));
FDRE #(
    .INIT(1'b0)) 
     RXUSERRDY_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_RXUSERRDY_i_1),
        .Q(RXUSERRDY),
        .R(AR));
LUT6 #(
    .INIT(64'hEFFFFFFF00100010)) 
     adapt_count_reset_i_1
       (.I0(rx_state[3]),
        .I1(rx_state[2]),
        .I2(rx_state[0]),
        .I3(rx_state[1]),
        .I4(cplllock_sync),
        .I5(recclk_mon_count_reset),
        .O(n_0_adapt_count_reset_i_1));
FDSE #(
    .INIT(1'b0)) 
     adapt_count_reset_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_adapt_count_reset_i_1),
        .Q(recclk_mon_count_reset),
        .S(AR));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFB)) 
     \adapt_wait_hw.adapt_count[0]_i_1 
       (.I0(\n_0_adapt_wait_hw.adapt_count[0]_i_3 ),
        .I1(\n_0_adapt_wait_hw.adapt_count[0]_i_4 ),
        .I2(\adapt_wait_hw.adapt_count_reg [18]),
        .I3(\adapt_wait_hw.adapt_count_reg [17]),
        .I4(\n_0_adapt_wait_hw.adapt_count[0]_i_5 ),
        .I5(\n_0_adapt_wait_hw.adapt_count[0]_i_6 ),
        .O(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ));
LUT1 #(
    .INIT(2'h1)) 
     \adapt_wait_hw.adapt_count[0]_i_10 
       (.I0(\adapt_wait_hw.adapt_count_reg [0]),
        .O(\n_0_adapt_wait_hw.adapt_count[0]_i_10 ));
LUT6 #(
    .INIT(64'hFFFFF7FFFFFFFFFF)) 
     \adapt_wait_hw.adapt_count[0]_i_3 
       (.I0(\adapt_wait_hw.adapt_count_reg [14]),
        .I1(\adapt_wait_hw.adapt_count_reg [13]),
        .I2(\adapt_wait_hw.adapt_count_reg [16]),
        .I3(\adapt_wait_hw.adapt_count_reg [15]),
        .I4(\adapt_wait_hw.adapt_count_reg [12]),
        .I5(\adapt_wait_hw.adapt_count_reg [11]),
        .O(\n_0_adapt_wait_hw.adapt_count[0]_i_3 ));
LUT4 #(
    .INIT(16'h4000)) 
     \adapt_wait_hw.adapt_count[0]_i_4 
       (.I0(\adapt_wait_hw.adapt_count_reg [19]),
        .I1(\adapt_wait_hw.adapt_count_reg [20]),
        .I2(\adapt_wait_hw.adapt_count_reg [22]),
        .I3(\adapt_wait_hw.adapt_count_reg [21]),
        .O(\n_0_adapt_wait_hw.adapt_count[0]_i_4 ));
(* SOFT_HLUTNM = "soft_lutpair68" *) 
   LUT5 #(
    .INIT(32'hFFEFFFFF)) 
     \adapt_wait_hw.adapt_count[0]_i_5 
       (.I0(\adapt_wait_hw.adapt_count_reg [8]),
        .I1(\adapt_wait_hw.adapt_count_reg [7]),
        .I2(\adapt_wait_hw.adapt_count_reg [0]),
        .I3(\adapt_wait_hw.adapt_count_reg [10]),
        .I4(\adapt_wait_hw.adapt_count_reg [9]),
        .O(\n_0_adapt_wait_hw.adapt_count[0]_i_5 ));
LUT6 #(
    .INIT(64'hF7FFFFFFFFFFFFFF)) 
     \adapt_wait_hw.adapt_count[0]_i_6 
       (.I0(\adapt_wait_hw.adapt_count_reg [4]),
        .I1(\adapt_wait_hw.adapt_count_reg [3]),
        .I2(\adapt_wait_hw.adapt_count_reg [6]),
        .I3(\adapt_wait_hw.adapt_count_reg [5]),
        .I4(\adapt_wait_hw.adapt_count_reg [2]),
        .I5(\adapt_wait_hw.adapt_count_reg [1]),
        .O(\n_0_adapt_wait_hw.adapt_count[0]_i_6 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[0]_i_7 
       (.I0(\adapt_wait_hw.adapt_count_reg [3]),
        .O(\n_0_adapt_wait_hw.adapt_count[0]_i_7 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[0]_i_8 
       (.I0(\adapt_wait_hw.adapt_count_reg [2]),
        .O(\n_0_adapt_wait_hw.adapt_count[0]_i_8 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[0]_i_9 
       (.I0(\adapt_wait_hw.adapt_count_reg [1]),
        .O(\n_0_adapt_wait_hw.adapt_count[0]_i_9 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[12]_i_2 
       (.I0(\adapt_wait_hw.adapt_count_reg [15]),
        .O(\n_0_adapt_wait_hw.adapt_count[12]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[12]_i_3 
       (.I0(\adapt_wait_hw.adapt_count_reg [14]),
        .O(\n_0_adapt_wait_hw.adapt_count[12]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[12]_i_4 
       (.I0(\adapt_wait_hw.adapt_count_reg [13]),
        .O(\n_0_adapt_wait_hw.adapt_count[12]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[12]_i_5 
       (.I0(\adapt_wait_hw.adapt_count_reg [12]),
        .O(\n_0_adapt_wait_hw.adapt_count[12]_i_5 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[16]_i_2 
       (.I0(\adapt_wait_hw.adapt_count_reg [19]),
        .O(\n_0_adapt_wait_hw.adapt_count[16]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[16]_i_3 
       (.I0(\adapt_wait_hw.adapt_count_reg [18]),
        .O(\n_0_adapt_wait_hw.adapt_count[16]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[16]_i_4 
       (.I0(\adapt_wait_hw.adapt_count_reg [17]),
        .O(\n_0_adapt_wait_hw.adapt_count[16]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[16]_i_5 
       (.I0(\adapt_wait_hw.adapt_count_reg [16]),
        .O(\n_0_adapt_wait_hw.adapt_count[16]_i_5 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[20]_i_2 
       (.I0(\adapt_wait_hw.adapt_count_reg [22]),
        .O(\n_0_adapt_wait_hw.adapt_count[20]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[20]_i_3 
       (.I0(\adapt_wait_hw.adapt_count_reg [21]),
        .O(\n_0_adapt_wait_hw.adapt_count[20]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[20]_i_4 
       (.I0(\adapt_wait_hw.adapt_count_reg [20]),
        .O(\n_0_adapt_wait_hw.adapt_count[20]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[4]_i_2 
       (.I0(\adapt_wait_hw.adapt_count_reg [7]),
        .O(\n_0_adapt_wait_hw.adapt_count[4]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[4]_i_3 
       (.I0(\adapt_wait_hw.adapt_count_reg [6]),
        .O(\n_0_adapt_wait_hw.adapt_count[4]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[4]_i_4 
       (.I0(\adapt_wait_hw.adapt_count_reg [5]),
        .O(\n_0_adapt_wait_hw.adapt_count[4]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[4]_i_5 
       (.I0(\adapt_wait_hw.adapt_count_reg [4]),
        .O(\n_0_adapt_wait_hw.adapt_count[4]_i_5 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[8]_i_2 
       (.I0(\adapt_wait_hw.adapt_count_reg [11]),
        .O(\n_0_adapt_wait_hw.adapt_count[8]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[8]_i_3 
       (.I0(\adapt_wait_hw.adapt_count_reg [10]),
        .O(\n_0_adapt_wait_hw.adapt_count[8]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[8]_i_4 
       (.I0(\adapt_wait_hw.adapt_count_reg [9]),
        .O(\n_0_adapt_wait_hw.adapt_count[8]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[8]_i_5 
       (.I0(\adapt_wait_hw.adapt_count_reg [8]),
        .O(\n_0_adapt_wait_hw.adapt_count[8]_i_5 ));
FDRE \adapt_wait_hw.adapt_count_reg[0] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_7_adapt_wait_hw.adapt_count_reg[0]_i_2 ),
        .Q(\adapt_wait_hw.adapt_count_reg [0]),
        .R(recclk_mon_count_reset));
CARRY4 \adapt_wait_hw.adapt_count_reg[0]_i_2 
       (.CI(1'b0),
        .CO({\n_0_adapt_wait_hw.adapt_count_reg[0]_i_2 ,\n_1_adapt_wait_hw.adapt_count_reg[0]_i_2 ,\n_2_adapt_wait_hw.adapt_count_reg[0]_i_2 ,\n_3_adapt_wait_hw.adapt_count_reg[0]_i_2 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\n_4_adapt_wait_hw.adapt_count_reg[0]_i_2 ,\n_5_adapt_wait_hw.adapt_count_reg[0]_i_2 ,\n_6_adapt_wait_hw.adapt_count_reg[0]_i_2 ,\n_7_adapt_wait_hw.adapt_count_reg[0]_i_2 }),
        .S({\n_0_adapt_wait_hw.adapt_count[0]_i_7 ,\n_0_adapt_wait_hw.adapt_count[0]_i_8 ,\n_0_adapt_wait_hw.adapt_count[0]_i_9 ,\n_0_adapt_wait_hw.adapt_count[0]_i_10 }));
FDRE \adapt_wait_hw.adapt_count_reg[10] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_5_adapt_wait_hw.adapt_count_reg[8]_i_1 ),
        .Q(\adapt_wait_hw.adapt_count_reg [10]),
        .R(recclk_mon_count_reset));
FDRE \adapt_wait_hw.adapt_count_reg[11] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_4_adapt_wait_hw.adapt_count_reg[8]_i_1 ),
        .Q(\adapt_wait_hw.adapt_count_reg [11]),
        .R(recclk_mon_count_reset));
FDRE \adapt_wait_hw.adapt_count_reg[12] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_7_adapt_wait_hw.adapt_count_reg[12]_i_1 ),
        .Q(\adapt_wait_hw.adapt_count_reg [12]),
        .R(recclk_mon_count_reset));
CARRY4 \adapt_wait_hw.adapt_count_reg[12]_i_1 
       (.CI(\n_0_adapt_wait_hw.adapt_count_reg[8]_i_1 ),
        .CO({\n_0_adapt_wait_hw.adapt_count_reg[12]_i_1 ,\n_1_adapt_wait_hw.adapt_count_reg[12]_i_1 ,\n_2_adapt_wait_hw.adapt_count_reg[12]_i_1 ,\n_3_adapt_wait_hw.adapt_count_reg[12]_i_1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_adapt_wait_hw.adapt_count_reg[12]_i_1 ,\n_5_adapt_wait_hw.adapt_count_reg[12]_i_1 ,\n_6_adapt_wait_hw.adapt_count_reg[12]_i_1 ,\n_7_adapt_wait_hw.adapt_count_reg[12]_i_1 }),
        .S({\n_0_adapt_wait_hw.adapt_count[12]_i_2 ,\n_0_adapt_wait_hw.adapt_count[12]_i_3 ,\n_0_adapt_wait_hw.adapt_count[12]_i_4 ,\n_0_adapt_wait_hw.adapt_count[12]_i_5 }));
FDRE \adapt_wait_hw.adapt_count_reg[13] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_6_adapt_wait_hw.adapt_count_reg[12]_i_1 ),
        .Q(\adapt_wait_hw.adapt_count_reg [13]),
        .R(recclk_mon_count_reset));
FDRE \adapt_wait_hw.adapt_count_reg[14] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_5_adapt_wait_hw.adapt_count_reg[12]_i_1 ),
        .Q(\adapt_wait_hw.adapt_count_reg [14]),
        .R(recclk_mon_count_reset));
FDRE \adapt_wait_hw.adapt_count_reg[15] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_4_adapt_wait_hw.adapt_count_reg[12]_i_1 ),
        .Q(\adapt_wait_hw.adapt_count_reg [15]),
        .R(recclk_mon_count_reset));
FDRE \adapt_wait_hw.adapt_count_reg[16] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_7_adapt_wait_hw.adapt_count_reg[16]_i_1 ),
        .Q(\adapt_wait_hw.adapt_count_reg [16]),
        .R(recclk_mon_count_reset));
CARRY4 \adapt_wait_hw.adapt_count_reg[16]_i_1 
       (.CI(\n_0_adapt_wait_hw.adapt_count_reg[12]_i_1 ),
        .CO({\n_0_adapt_wait_hw.adapt_count_reg[16]_i_1 ,\n_1_adapt_wait_hw.adapt_count_reg[16]_i_1 ,\n_2_adapt_wait_hw.adapt_count_reg[16]_i_1 ,\n_3_adapt_wait_hw.adapt_count_reg[16]_i_1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_adapt_wait_hw.adapt_count_reg[16]_i_1 ,\n_5_adapt_wait_hw.adapt_count_reg[16]_i_1 ,\n_6_adapt_wait_hw.adapt_count_reg[16]_i_1 ,\n_7_adapt_wait_hw.adapt_count_reg[16]_i_1 }),
        .S({\n_0_adapt_wait_hw.adapt_count[16]_i_2 ,\n_0_adapt_wait_hw.adapt_count[16]_i_3 ,\n_0_adapt_wait_hw.adapt_count[16]_i_4 ,\n_0_adapt_wait_hw.adapt_count[16]_i_5 }));
FDRE \adapt_wait_hw.adapt_count_reg[17] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_6_adapt_wait_hw.adapt_count_reg[16]_i_1 ),
        .Q(\adapt_wait_hw.adapt_count_reg [17]),
        .R(recclk_mon_count_reset));
FDRE \adapt_wait_hw.adapt_count_reg[18] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_5_adapt_wait_hw.adapt_count_reg[16]_i_1 ),
        .Q(\adapt_wait_hw.adapt_count_reg [18]),
        .R(recclk_mon_count_reset));
FDRE \adapt_wait_hw.adapt_count_reg[19] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_4_adapt_wait_hw.adapt_count_reg[16]_i_1 ),
        .Q(\adapt_wait_hw.adapt_count_reg [19]),
        .R(recclk_mon_count_reset));
FDRE \adapt_wait_hw.adapt_count_reg[1] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_6_adapt_wait_hw.adapt_count_reg[0]_i_2 ),
        .Q(\adapt_wait_hw.adapt_count_reg [1]),
        .R(recclk_mon_count_reset));
FDRE \adapt_wait_hw.adapt_count_reg[20] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_7_adapt_wait_hw.adapt_count_reg[20]_i_1 ),
        .Q(\adapt_wait_hw.adapt_count_reg [20]),
        .R(recclk_mon_count_reset));
CARRY4 \adapt_wait_hw.adapt_count_reg[20]_i_1 
       (.CI(\n_0_adapt_wait_hw.adapt_count_reg[16]_i_1 ),
        .CO({\NLW_adapt_wait_hw.adapt_count_reg[20]_i_1_CO_UNCONNECTED [3:2],\n_2_adapt_wait_hw.adapt_count_reg[20]_i_1 ,\n_3_adapt_wait_hw.adapt_count_reg[20]_i_1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_adapt_wait_hw.adapt_count_reg[20]_i_1_O_UNCONNECTED [3],\n_5_adapt_wait_hw.adapt_count_reg[20]_i_1 ,\n_6_adapt_wait_hw.adapt_count_reg[20]_i_1 ,\n_7_adapt_wait_hw.adapt_count_reg[20]_i_1 }),
        .S({1'b0,\n_0_adapt_wait_hw.adapt_count[20]_i_2 ,\n_0_adapt_wait_hw.adapt_count[20]_i_3 ,\n_0_adapt_wait_hw.adapt_count[20]_i_4 }));
FDRE \adapt_wait_hw.adapt_count_reg[21] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_6_adapt_wait_hw.adapt_count_reg[20]_i_1 ),
        .Q(\adapt_wait_hw.adapt_count_reg [21]),
        .R(recclk_mon_count_reset));
FDRE \adapt_wait_hw.adapt_count_reg[22] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_5_adapt_wait_hw.adapt_count_reg[20]_i_1 ),
        .Q(\adapt_wait_hw.adapt_count_reg [22]),
        .R(recclk_mon_count_reset));
FDRE \adapt_wait_hw.adapt_count_reg[2] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_5_adapt_wait_hw.adapt_count_reg[0]_i_2 ),
        .Q(\adapt_wait_hw.adapt_count_reg [2]),
        .R(recclk_mon_count_reset));
FDRE \adapt_wait_hw.adapt_count_reg[3] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_4_adapt_wait_hw.adapt_count_reg[0]_i_2 ),
        .Q(\adapt_wait_hw.adapt_count_reg [3]),
        .R(recclk_mon_count_reset));
FDRE \adapt_wait_hw.adapt_count_reg[4] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_7_adapt_wait_hw.adapt_count_reg[4]_i_1 ),
        .Q(\adapt_wait_hw.adapt_count_reg [4]),
        .R(recclk_mon_count_reset));
CARRY4 \adapt_wait_hw.adapt_count_reg[4]_i_1 
       (.CI(\n_0_adapt_wait_hw.adapt_count_reg[0]_i_2 ),
        .CO({\n_0_adapt_wait_hw.adapt_count_reg[4]_i_1 ,\n_1_adapt_wait_hw.adapt_count_reg[4]_i_1 ,\n_2_adapt_wait_hw.adapt_count_reg[4]_i_1 ,\n_3_adapt_wait_hw.adapt_count_reg[4]_i_1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_adapt_wait_hw.adapt_count_reg[4]_i_1 ,\n_5_adapt_wait_hw.adapt_count_reg[4]_i_1 ,\n_6_adapt_wait_hw.adapt_count_reg[4]_i_1 ,\n_7_adapt_wait_hw.adapt_count_reg[4]_i_1 }),
        .S({\n_0_adapt_wait_hw.adapt_count[4]_i_2 ,\n_0_adapt_wait_hw.adapt_count[4]_i_3 ,\n_0_adapt_wait_hw.adapt_count[4]_i_4 ,\n_0_adapt_wait_hw.adapt_count[4]_i_5 }));
FDRE \adapt_wait_hw.adapt_count_reg[5] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_6_adapt_wait_hw.adapt_count_reg[4]_i_1 ),
        .Q(\adapt_wait_hw.adapt_count_reg [5]),
        .R(recclk_mon_count_reset));
FDRE \adapt_wait_hw.adapt_count_reg[6] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_5_adapt_wait_hw.adapt_count_reg[4]_i_1 ),
        .Q(\adapt_wait_hw.adapt_count_reg [6]),
        .R(recclk_mon_count_reset));
FDRE \adapt_wait_hw.adapt_count_reg[7] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_4_adapt_wait_hw.adapt_count_reg[4]_i_1 ),
        .Q(\adapt_wait_hw.adapt_count_reg [7]),
        .R(recclk_mon_count_reset));
FDRE \adapt_wait_hw.adapt_count_reg[8] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_7_adapt_wait_hw.adapt_count_reg[8]_i_1 ),
        .Q(\adapt_wait_hw.adapt_count_reg [8]),
        .R(recclk_mon_count_reset));
CARRY4 \adapt_wait_hw.adapt_count_reg[8]_i_1 
       (.CI(\n_0_adapt_wait_hw.adapt_count_reg[4]_i_1 ),
        .CO({\n_0_adapt_wait_hw.adapt_count_reg[8]_i_1 ,\n_1_adapt_wait_hw.adapt_count_reg[8]_i_1 ,\n_2_adapt_wait_hw.adapt_count_reg[8]_i_1 ,\n_3_adapt_wait_hw.adapt_count_reg[8]_i_1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_adapt_wait_hw.adapt_count_reg[8]_i_1 ,\n_5_adapt_wait_hw.adapt_count_reg[8]_i_1 ,\n_6_adapt_wait_hw.adapt_count_reg[8]_i_1 ,\n_7_adapt_wait_hw.adapt_count_reg[8]_i_1 }),
        .S({\n_0_adapt_wait_hw.adapt_count[8]_i_2 ,\n_0_adapt_wait_hw.adapt_count[8]_i_3 ,\n_0_adapt_wait_hw.adapt_count[8]_i_4 ,\n_0_adapt_wait_hw.adapt_count[8]_i_5 }));
FDRE \adapt_wait_hw.adapt_count_reg[9] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_6_adapt_wait_hw.adapt_count_reg[8]_i_1 ),
        .Q(\adapt_wait_hw.adapt_count_reg [9]),
        .R(recclk_mon_count_reset));
LUT6 #(
    .INIT(64'h00000000EAAAAAAA)) 
     \adapt_wait_hw.time_out_adapt_i_1 
       (.I0(\n_0_adapt_wait_hw.time_out_adapt_reg ),
        .I1(\n_0_adapt_wait_hw.time_out_adapt_i_2 ),
        .I2(\n_0_adapt_wait_hw.time_out_adapt_i_3 ),
        .I3(\n_0_adapt_wait_hw.time_out_adapt_i_4 ),
        .I4(\n_0_adapt_wait_hw.time_out_adapt_i_5 ),
        .I5(recclk_mon_count_reset),
        .O(\n_0_adapt_wait_hw.time_out_adapt_i_1 ));
LUT6 #(
    .INIT(64'h0040000000000000)) 
     \adapt_wait_hw.time_out_adapt_i_2 
       (.I0(\adapt_wait_hw.adapt_count_reg [12]),
        .I1(\adapt_wait_hw.adapt_count_reg [11]),
        .I2(\adapt_wait_hw.adapt_count_reg [15]),
        .I3(\adapt_wait_hw.adapt_count_reg [16]),
        .I4(\adapt_wait_hw.adapt_count_reg [13]),
        .I5(\adapt_wait_hw.adapt_count_reg [14]),
        .O(\n_0_adapt_wait_hw.time_out_adapt_i_2 ));
LUT6 #(
    .INIT(64'h0000000010000000)) 
     \adapt_wait_hw.time_out_adapt_i_3 
       (.I0(\adapt_wait_hw.adapt_count_reg [18]),
        .I1(\adapt_wait_hw.adapt_count_reg [17]),
        .I2(\adapt_wait_hw.adapt_count_reg [21]),
        .I3(\adapt_wait_hw.adapt_count_reg [22]),
        .I4(\adapt_wait_hw.adapt_count_reg [20]),
        .I5(\adapt_wait_hw.adapt_count_reg [19]),
        .O(\n_0_adapt_wait_hw.time_out_adapt_i_3 ));
(* SOFT_HLUTNM = "soft_lutpair68" *) 
   LUT5 #(
    .INIT(32'h00000040)) 
     \adapt_wait_hw.time_out_adapt_i_4 
       (.I0(\adapt_wait_hw.adapt_count_reg [10]),
        .I1(\adapt_wait_hw.adapt_count_reg [9]),
        .I2(\adapt_wait_hw.adapt_count_reg [0]),
        .I3(\adapt_wait_hw.adapt_count_reg [7]),
        .I4(\adapt_wait_hw.adapt_count_reg [8]),
        .O(\n_0_adapt_wait_hw.time_out_adapt_i_4 ));
LUT6 #(
    .INIT(64'h0080000000000000)) 
     \adapt_wait_hw.time_out_adapt_i_5 
       (.I0(\adapt_wait_hw.adapt_count_reg [2]),
        .I1(\adapt_wait_hw.adapt_count_reg [1]),
        .I2(\adapt_wait_hw.adapt_count_reg [5]),
        .I3(\adapt_wait_hw.adapt_count_reg [6]),
        .I4(\adapt_wait_hw.adapt_count_reg [3]),
        .I5(\adapt_wait_hw.adapt_count_reg [4]),
        .O(\n_0_adapt_wait_hw.time_out_adapt_i_5 ));
FDRE #(
    .INIT(1'b0)) 
     \adapt_wait_hw.time_out_adapt_reg 
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(\n_0_adapt_wait_hw.time_out_adapt_i_1 ),
        .Q(\n_0_adapt_wait_hw.time_out_adapt_reg ),
        .R(1'b0));
LUT5 #(
    .INIT(32'hFFFB0008)) 
     check_tlock_max_i_1
       (.I0(rx_state[2]),
        .I1(rx_state[0]),
        .I2(rx_state[3]),
        .I3(rx_state[1]),
        .I4(n_0_check_tlock_max_reg),
        .O(n_0_check_tlock_max_i_1));
FDRE #(
    .INIT(1'b0)) 
     check_tlock_max_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_check_tlock_max_i_1),
        .Q(n_0_check_tlock_max_reg),
        .R(AR));
LUT5 #(
    .INIT(32'hFFFD0004)) 
     gtrxreset_i_i_1
       (.I0(rx_state[2]),
        .I1(rx_state[0]),
        .I2(rx_state[3]),
        .I3(rx_state[1]),
        .I4(GTRXRESET),
        .O(n_0_gtrxreset_i_i_1));
FDRE #(
    .INIT(1'b0)) 
     gtrxreset_i_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_gtrxreset_i_i_1),
        .Q(GTRXRESET),
        .R(AR));
LUT1 #(
    .INIT(2'h1)) 
     \init_wait_count[0]_i_1__0 
       (.I0(init_wait_count_reg__0[0]),
        .O(\n_0_init_wait_count[0]_i_1__0 ));
(* SOFT_HLUTNM = "soft_lutpair80" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \init_wait_count[1]_i_1__0 
       (.I0(init_wait_count_reg__0[1]),
        .I1(init_wait_count_reg__0[0]),
        .O(p_0_in__1[1]));
(* SOFT_HLUTNM = "soft_lutpair73" *) 
   LUT3 #(
    .INIT(8'h78)) 
     \init_wait_count[2]_i_1__0 
       (.I0(init_wait_count_reg__0[1]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[2]),
        .O(p_0_in__1[2]));
(* SOFT_HLUTNM = "soft_lutpair73" *) 
   LUT4 #(
    .INIT(16'h7F80)) 
     \init_wait_count[3]_i_1__0 
       (.I0(init_wait_count_reg__0[2]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[1]),
        .I3(init_wait_count_reg__0[3]),
        .O(p_0_in__1[3]));
(* SOFT_HLUTNM = "soft_lutpair70" *) 
   LUT5 #(
    .INIT(32'h7FFF8000)) 
     \init_wait_count[4]_i_1__0 
       (.I0(init_wait_count_reg__0[3]),
        .I1(init_wait_count_reg__0[1]),
        .I2(init_wait_count_reg__0[0]),
        .I3(init_wait_count_reg__0[2]),
        .I4(init_wait_count_reg__0[4]),
        .O(p_0_in__1[4]));
LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
     \init_wait_count[5]_i_1__0 
       (.I0(init_wait_count_reg__0[4]),
        .I1(init_wait_count_reg__0[2]),
        .I2(init_wait_count_reg__0[0]),
        .I3(init_wait_count_reg__0[1]),
        .I4(init_wait_count_reg__0[3]),
        .I5(init_wait_count_reg__0[5]),
        .O(p_0_in__1[5]));
LUT6 #(
    .INIT(64'hFFFFFFFFFF7FFFFF)) 
     \init_wait_count[6]_i_1__0 
       (.I0(init_wait_count_reg__0[5]),
        .I1(init_wait_count_reg__0[6]),
        .I2(init_wait_count_reg__0[3]),
        .I3(init_wait_count_reg__0[4]),
        .I4(init_wait_count_reg__0[2]),
        .I5(\n_0_init_wait_count[6]_i_3__0 ),
        .O(\n_0_init_wait_count[6]_i_1__0 ));
LUT3 #(
    .INIT(8'hD2)) 
     \init_wait_count[6]_i_2__0 
       (.I0(init_wait_count_reg__0[5]),
        .I1(\n_0_init_wait_count[6]_i_4__0 ),
        .I2(init_wait_count_reg__0[6]),
        .O(p_0_in__1[6]));
(* SOFT_HLUTNM = "soft_lutpair80" *) 
   LUT2 #(
    .INIT(4'hB)) 
     \init_wait_count[6]_i_3__0 
       (.I0(init_wait_count_reg__0[0]),
        .I1(init_wait_count_reg__0[1]),
        .O(\n_0_init_wait_count[6]_i_3__0 ));
(* SOFT_HLUTNM = "soft_lutpair70" *) 
   LUT5 #(
    .INIT(32'h7FFFFFFF)) 
     \init_wait_count[6]_i_4__0 
       (.I0(init_wait_count_reg__0[3]),
        .I1(init_wait_count_reg__0[1]),
        .I2(init_wait_count_reg__0[0]),
        .I3(init_wait_count_reg__0[2]),
        .I4(init_wait_count_reg__0[4]),
        .O(\n_0_init_wait_count[6]_i_4__0 ));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[0] 
       (.C(independent_clock_bufg),
        .CE(\n_0_init_wait_count[6]_i_1__0 ),
        .CLR(AR),
        .D(\n_0_init_wait_count[0]_i_1__0 ),
        .Q(init_wait_count_reg__0[0]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[1] 
       (.C(independent_clock_bufg),
        .CE(\n_0_init_wait_count[6]_i_1__0 ),
        .CLR(AR),
        .D(p_0_in__1[1]),
        .Q(init_wait_count_reg__0[1]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[2] 
       (.C(independent_clock_bufg),
        .CE(\n_0_init_wait_count[6]_i_1__0 ),
        .CLR(AR),
        .D(p_0_in__1[2]),
        .Q(init_wait_count_reg__0[2]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[3] 
       (.C(independent_clock_bufg),
        .CE(\n_0_init_wait_count[6]_i_1__0 ),
        .CLR(AR),
        .D(p_0_in__1[3]),
        .Q(init_wait_count_reg__0[3]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[4] 
       (.C(independent_clock_bufg),
        .CE(\n_0_init_wait_count[6]_i_1__0 ),
        .CLR(AR),
        .D(p_0_in__1[4]),
        .Q(init_wait_count_reg__0[4]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[5] 
       (.C(independent_clock_bufg),
        .CE(\n_0_init_wait_count[6]_i_1__0 ),
        .CLR(AR),
        .D(p_0_in__1[5]),
        .Q(init_wait_count_reg__0[5]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[6] 
       (.C(independent_clock_bufg),
        .CE(\n_0_init_wait_count[6]_i_1__0 ),
        .CLR(AR),
        .D(p_0_in__1[6]),
        .Q(init_wait_count_reg__0[6]));
LUT6 #(
    .INIT(64'hFFFFFFFF00008000)) 
     init_wait_done_i_1__0
       (.I0(n_0_init_wait_done_i_2__0),
        .I1(init_wait_count_reg__0[2]),
        .I2(init_wait_count_reg__0[6]),
        .I3(init_wait_count_reg__0[5]),
        .I4(\n_0_init_wait_count[6]_i_3__0 ),
        .I5(n_0_init_wait_done_reg),
        .O(n_0_init_wait_done_i_1__0));
LUT2 #(
    .INIT(4'h2)) 
     init_wait_done_i_2__0
       (.I0(init_wait_count_reg__0[3]),
        .I1(init_wait_count_reg__0[4]),
        .O(n_0_init_wait_done_i_2__0));
FDCE #(
    .INIT(1'b0)) 
     init_wait_done_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .CLR(AR),
        .D(n_0_init_wait_done_i_1__0),
        .Q(n_0_init_wait_done_reg));
LUT1 #(
    .INIT(2'h1)) 
     \mmcm_lock_count[0]_i_1__0 
       (.I0(mmcm_lock_count_reg__0[0]),
        .O(p_0_in__2[0]));
(* SOFT_HLUTNM = "soft_lutpair77" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \mmcm_lock_count[1]_i_1__0 
       (.I0(mmcm_lock_count_reg__0[0]),
        .I1(mmcm_lock_count_reg__0[1]),
        .O(p_0_in__2[1]));
(* SOFT_HLUTNM = "soft_lutpair77" *) 
   LUT3 #(
    .INIT(8'h78)) 
     \mmcm_lock_count[2]_i_1__0 
       (.I0(mmcm_lock_count_reg__0[1]),
        .I1(mmcm_lock_count_reg__0[0]),
        .I2(mmcm_lock_count_reg__0[2]),
        .O(p_0_in__2[2]));
(* SOFT_HLUTNM = "soft_lutpair71" *) 
   LUT4 #(
    .INIT(16'h7F80)) 
     \mmcm_lock_count[3]_i_1__0 
       (.I0(mmcm_lock_count_reg__0[2]),
        .I1(mmcm_lock_count_reg__0[0]),
        .I2(mmcm_lock_count_reg__0[1]),
        .I3(mmcm_lock_count_reg__0[3]),
        .O(p_0_in__2[3]));
(* SOFT_HLUTNM = "soft_lutpair71" *) 
   LUT5 #(
    .INIT(32'h7FFF8000)) 
     \mmcm_lock_count[4]_i_1__0 
       (.I0(mmcm_lock_count_reg__0[3]),
        .I1(mmcm_lock_count_reg__0[1]),
        .I2(mmcm_lock_count_reg__0[0]),
        .I3(mmcm_lock_count_reg__0[2]),
        .I4(mmcm_lock_count_reg__0[4]),
        .O(p_0_in__2[4]));
LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
     \mmcm_lock_count[5]_i_1__0 
       (.I0(mmcm_lock_count_reg__0[4]),
        .I1(mmcm_lock_count_reg__0[2]),
        .I2(mmcm_lock_count_reg__0[0]),
        .I3(mmcm_lock_count_reg__0[1]),
        .I4(mmcm_lock_count_reg__0[3]),
        .I5(mmcm_lock_count_reg__0[5]),
        .O(p_0_in__2[5]));
LUT2 #(
    .INIT(4'h9)) 
     \mmcm_lock_count[6]_i_1__0 
       (.I0(\n_0_mmcm_lock_count[9]_i_4__0 ),
        .I1(mmcm_lock_count_reg__0[6]),
        .O(p_0_in__2[6]));
(* SOFT_HLUTNM = "soft_lutpair76" *) 
   LUT3 #(
    .INIT(8'hD2)) 
     \mmcm_lock_count[7]_i_1__0 
       (.I0(mmcm_lock_count_reg__0[6]),
        .I1(\n_0_mmcm_lock_count[9]_i_4__0 ),
        .I2(mmcm_lock_count_reg__0[7]),
        .O(p_0_in__2[7]));
(* SOFT_HLUTNM = "soft_lutpair76" *) 
   LUT4 #(
    .INIT(16'hDF20)) 
     \mmcm_lock_count[8]_i_1__0 
       (.I0(mmcm_lock_count_reg__0[7]),
        .I1(\n_0_mmcm_lock_count[9]_i_4__0 ),
        .I2(mmcm_lock_count_reg__0[6]),
        .I3(mmcm_lock_count_reg__0[8]),
        .O(p_0_in__2[8]));
LUT1 #(
    .INIT(2'h1)) 
     \mmcm_lock_count[9]_i_1__0 
       (.I0(mmcm_lock_i),
        .O(\n_0_mmcm_lock_count[9]_i_1__0 ));
LUT5 #(
    .INIT(32'hDFFFFFFF)) 
     \mmcm_lock_count[9]_i_2__0 
       (.I0(mmcm_lock_count_reg__0[7]),
        .I1(\n_0_mmcm_lock_count[9]_i_4__0 ),
        .I2(mmcm_lock_count_reg__0[6]),
        .I3(mmcm_lock_count_reg__0[8]),
        .I4(mmcm_lock_count_reg__0[9]),
        .O(\n_0_mmcm_lock_count[9]_i_2__0 ));
(* SOFT_HLUTNM = "soft_lutpair69" *) 
   LUT5 #(
    .INIT(32'hF7FF0800)) 
     \mmcm_lock_count[9]_i_3__0 
       (.I0(mmcm_lock_count_reg__0[8]),
        .I1(mmcm_lock_count_reg__0[6]),
        .I2(\n_0_mmcm_lock_count[9]_i_4__0 ),
        .I3(mmcm_lock_count_reg__0[7]),
        .I4(mmcm_lock_count_reg__0[9]),
        .O(p_0_in__2[9]));
LUT6 #(
    .INIT(64'h7FFFFFFFFFFFFFFF)) 
     \mmcm_lock_count[9]_i_4__0 
       (.I0(mmcm_lock_count_reg__0[4]),
        .I1(mmcm_lock_count_reg__0[2]),
        .I2(mmcm_lock_count_reg__0[0]),
        .I3(mmcm_lock_count_reg__0[1]),
        .I4(mmcm_lock_count_reg__0[3]),
        .I5(mmcm_lock_count_reg__0[5]),
        .O(\n_0_mmcm_lock_count[9]_i_4__0 ));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[0] 
       (.C(independent_clock_bufg),
        .CE(\n_0_mmcm_lock_count[9]_i_2__0 ),
        .D(p_0_in__2[0]),
        .Q(mmcm_lock_count_reg__0[0]),
        .R(\n_0_mmcm_lock_count[9]_i_1__0 ));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[1] 
       (.C(independent_clock_bufg),
        .CE(\n_0_mmcm_lock_count[9]_i_2__0 ),
        .D(p_0_in__2[1]),
        .Q(mmcm_lock_count_reg__0[1]),
        .R(\n_0_mmcm_lock_count[9]_i_1__0 ));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[2] 
       (.C(independent_clock_bufg),
        .CE(\n_0_mmcm_lock_count[9]_i_2__0 ),
        .D(p_0_in__2[2]),
        .Q(mmcm_lock_count_reg__0[2]),
        .R(\n_0_mmcm_lock_count[9]_i_1__0 ));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[3] 
       (.C(independent_clock_bufg),
        .CE(\n_0_mmcm_lock_count[9]_i_2__0 ),
        .D(p_0_in__2[3]),
        .Q(mmcm_lock_count_reg__0[3]),
        .R(\n_0_mmcm_lock_count[9]_i_1__0 ));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[4] 
       (.C(independent_clock_bufg),
        .CE(\n_0_mmcm_lock_count[9]_i_2__0 ),
        .D(p_0_in__2[4]),
        .Q(mmcm_lock_count_reg__0[4]),
        .R(\n_0_mmcm_lock_count[9]_i_1__0 ));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[5] 
       (.C(independent_clock_bufg),
        .CE(\n_0_mmcm_lock_count[9]_i_2__0 ),
        .D(p_0_in__2[5]),
        .Q(mmcm_lock_count_reg__0[5]),
        .R(\n_0_mmcm_lock_count[9]_i_1__0 ));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[6] 
       (.C(independent_clock_bufg),
        .CE(\n_0_mmcm_lock_count[9]_i_2__0 ),
        .D(p_0_in__2[6]),
        .Q(mmcm_lock_count_reg__0[6]),
        .R(\n_0_mmcm_lock_count[9]_i_1__0 ));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[7] 
       (.C(independent_clock_bufg),
        .CE(\n_0_mmcm_lock_count[9]_i_2__0 ),
        .D(p_0_in__2[7]),
        .Q(mmcm_lock_count_reg__0[7]),
        .R(\n_0_mmcm_lock_count[9]_i_1__0 ));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[8] 
       (.C(independent_clock_bufg),
        .CE(\n_0_mmcm_lock_count[9]_i_2__0 ),
        .D(p_0_in__2[8]),
        .Q(mmcm_lock_count_reg__0[8]),
        .R(\n_0_mmcm_lock_count[9]_i_1__0 ));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[9] 
       (.C(independent_clock_bufg),
        .CE(\n_0_mmcm_lock_count[9]_i_2__0 ),
        .D(p_0_in__2[9]),
        .Q(mmcm_lock_count_reg__0[9]),
        .R(\n_0_mmcm_lock_count[9]_i_1__0 ));
LUT3 #(
    .INIT(8'hE0)) 
     mmcm_lock_reclocked_i_1__0
       (.I0(mmcm_lock_reclocked),
        .I1(n_0_mmcm_lock_reclocked_i_2__0),
        .I2(mmcm_lock_i),
        .O(n_0_mmcm_lock_reclocked_i_1__0));
(* SOFT_HLUTNM = "soft_lutpair69" *) 
   LUT5 #(
    .INIT(32'h00800000)) 
     mmcm_lock_reclocked_i_2__0
       (.I0(mmcm_lock_count_reg__0[9]),
        .I1(mmcm_lock_count_reg__0[8]),
        .I2(mmcm_lock_count_reg__0[6]),
        .I3(\n_0_mmcm_lock_count[9]_i_4__0 ),
        .I4(mmcm_lock_count_reg__0[7]),
        .O(n_0_mmcm_lock_reclocked_i_2__0));
FDRE #(
    .INIT(1'b0)) 
     mmcm_lock_reclocked_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_mmcm_lock_reclocked_i_1__0),
        .Q(mmcm_lock_reclocked),
        .R(1'b0));
LUT6 #(
    .INIT(64'hFF10FFFFFF100000)) 
     reset_time_out_i_1__0
       (.I0(rx_state[3]),
        .I1(rx_state[2]),
        .I2(cplllock_sync),
        .I3(n_0_reset_time_out_i_2__0),
        .I4(n_0_reset_time_out_i_3__0),
        .I5(n_0_reset_time_out_reg),
        .O(n_0_reset_time_out_i_1__0));
LUT6 #(
    .INIT(64'h8F88FFFF8F880000)) 
     reset_time_out_i_2__0
       (.I0(rxresetdone_s3),
        .I1(rx_state[2]),
        .I2(data_valid_sync),
        .I3(rx_state[3]),
        .I4(rx_state[1]),
        .I5(n_0_reset_time_out_i_4),
        .O(n_0_reset_time_out_i_2__0));
LUT5 #(
    .INIT(32'h0333FF08)) 
     reset_time_out_i_3__0
       (.I0(I4),
        .I1(rx_state[2]),
        .I2(rx_state[1]),
        .I3(rx_state[0]),
        .I4(rx_state[3]),
        .O(n_0_reset_time_out_i_3__0));
LUT6 #(
    .INIT(64'hFFF3DDF333F311F3)) 
     reset_time_out_i_4
       (.I0(rx_state[3]),
        .I1(rx_state[2]),
        .I2(I4),
        .I3(rx_state[0]),
        .I4(data_valid_sync),
        .I5(mmcm_lock_reclocked),
        .O(n_0_reset_time_out_i_4));
FDSE #(
    .INIT(1'b0)) 
     reset_time_out_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_reset_time_out_i_1__0),
        .Q(n_0_reset_time_out_reg),
        .S(AR));
(* SOFT_HLUTNM = "soft_lutpair78" *) 
   LUT2 #(
    .INIT(4'h8)) 
     resetdone_INST_0
       (.I0(gt0_rxresetdone_out),
        .I1(gt0_txresetdone_out),
        .O(resetdone));
LUT5 #(
    .INIT(32'hFFFB0002)) 
     run_phase_alignment_int_i_1__0
       (.I0(rx_state[3]),
        .I1(rx_state[0]),
        .I2(rx_state[2]),
        .I3(rx_state[1]),
        .I4(n_0_run_phase_alignment_int_reg),
        .O(n_0_run_phase_alignment_int_i_1__0));
FDRE #(
    .INIT(1'b0)) 
     run_phase_alignment_int_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_run_phase_alignment_int_i_1__0),
        .Q(n_0_run_phase_alignment_int_reg),
        .R(AR));
FDRE #(
    .INIT(1'b0)) 
     run_phase_alignment_int_s3_reg
       (.C(I1),
        .CE(1'b1),
        .D(data_out_0),
        .Q(n_0_run_phase_alignment_int_s3_reg),
        .R(1'b0));
LUT6 #(
    .INIT(64'hFF5FF5FF00008000)) 
     rx_fsm_reset_done_int_i_1
       (.I0(n_0_rx_fsm_reset_done_int_i_2),
        .I1(n_0_rx_fsm_reset_done_int_i_3),
        .I2(data_valid_sync),
        .I3(rx_state[1]),
        .I4(rx_state[0]),
        .I5(gt0_rxresetdone_out),
        .O(n_0_rx_fsm_reset_done_int_i_1));
LUT2 #(
    .INIT(4'h2)) 
     rx_fsm_reset_done_int_i_2
       (.I0(rx_state[3]),
        .I1(rx_state[2]),
        .O(n_0_rx_fsm_reset_done_int_i_2));
(* SOFT_HLUTNM = "soft_lutpair81" *) 
   LUT2 #(
    .INIT(4'h2)) 
     rx_fsm_reset_done_int_i_3
       (.I0(n_0_time_out_1us_reg),
        .I1(n_0_reset_time_out_reg),
        .O(n_0_rx_fsm_reset_done_int_i_3));
FDRE #(
    .INIT(1'b0)) 
     rx_fsm_reset_done_int_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_rx_fsm_reset_done_int_i_1),
        .Q(gt0_rxresetdone_out),
        .R(AR));
FDRE #(
    .INIT(1'b0)) 
     rx_fsm_reset_done_int_s3_reg
       (.C(I1),
        .CE(1'b1),
        .D(rx_fsm_reset_done_int_s2),
        .Q(rx_fsm_reset_done_int_s3),
        .R(1'b0));
FDRE #(
    .INIT(1'b0)) 
     rxresetdone_s3_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(rxresetdone_s2),
        .Q(rxresetdone_s3),
        .R(1'b0));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gmii_to_sgmiigmii_to_sgmii_sync_block__parameterized0__28 sync_RXRESETDONE
       (.clk(independent_clock_bufg),
        .data_in(I2),
        .data_out(rxresetdone_s2));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gmii_to_sgmiigmii_to_sgmii_sync_block__parameterized0__32 sync_cplllock
       (.clk(independent_clock_bufg),
        .data_in(I3),
        .data_out(cplllock_sync));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gmii_to_sgmiigmii_to_sgmii_sync_block__parameterized0__31 sync_data_valid
       (.clk(independent_clock_bufg),
        .data_in(data_out),
        .data_out(data_valid_sync));
(* SOFT_HLUTNM = "soft_lutpair78" *) 
   LUT3 #(
    .INIT(8'hEA)) 
     sync_gtrxreset_in_i_1
       (.I0(GTRXRESET),
        .I1(gt0_rxresetdone_out),
        .I2(rxreset),
        .O(gt0_gtrxreset_in1_out));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gmii_to_sgmiigmii_to_sgmii_sync_block__parameterized0__30 sync_mmcm_lock_reclocked
       (.clk(independent_clock_bufg),
        .data_in(mmcm_locked_out),
        .data_out(mmcm_lock_i));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gmii_to_sgmiigmii_to_sgmii_sync_block__parameterized0__26 sync_run_phase_alignment_int
       (.clk(I1),
        .data_in(n_0_run_phase_alignment_int_reg),
        .data_out(data_out_0));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gmii_to_sgmiigmii_to_sgmii_sync_block__parameterized0__27 sync_rx_fsm_reset_done_int
       (.clk(I1),
        .data_in(gt0_rxresetdone_out),
        .data_out(rx_fsm_reset_done_int_s2));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gmii_to_sgmiigmii_to_sgmii_sync_block__parameterized0__29 sync_time_out_wait_bypass
       (.clk(independent_clock_bufg),
        .data_in(n_0_time_out_wait_bypass_reg),
        .data_out(time_out_wait_bypass_s2));
LUT6 #(
    .INIT(64'h00000000AAAAAAAE)) 
     time_out_1us_i_1
       (.I0(n_0_time_out_1us_reg),
        .I1(n_0_time_out_1us_i_2),
        .I2(n_0_time_out_1us_i_3),
        .I3(n_0_time_out_1us_i_4),
        .I4(\n_0_time_out_counter[0]_i_3__0 ),
        .I5(n_0_reset_time_out_reg),
        .O(n_0_time_out_1us_i_1));
LUT6 #(
    .INIT(64'h0000000000000010)) 
     time_out_1us_i_2
       (.I0(time_out_counter_reg[10]),
        .I1(time_out_counter_reg[8]),
        .I2(time_out_counter_reg[3]),
        .I3(time_out_counter_reg[2]),
        .I4(time_out_counter_reg[9]),
        .I5(n_0_time_out_1us_i_5),
        .O(n_0_time_out_1us_i_2));
(* SOFT_HLUTNM = "soft_lutpair75" *) 
   LUT2 #(
    .INIT(4'hE)) 
     time_out_1us_i_3
       (.I0(time_out_counter_reg[18]),
        .I1(time_out_counter_reg[19]),
        .O(n_0_time_out_1us_i_3));
LUT2 #(
    .INIT(4'hE)) 
     time_out_1us_i_4
       (.I0(time_out_counter_reg[12]),
        .I1(time_out_counter_reg[13]),
        .O(n_0_time_out_1us_i_4));
LUT2 #(
    .INIT(4'hE)) 
     time_out_1us_i_5
       (.I0(time_out_counter_reg[16]),
        .I1(time_out_counter_reg[17]),
        .O(n_0_time_out_1us_i_5));
FDRE #(
    .INIT(1'b0)) 
     time_out_1us_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_time_out_1us_i_1),
        .Q(n_0_time_out_1us_reg),
        .R(1'b0));
LUT6 #(
    .INIT(64'h00000000AAAAABAA)) 
     time_out_2ms_i_1
       (.I0(n_0_time_out_2ms_reg),
        .I1(time_out_counter_reg[2]),
        .I2(time_out_counter_reg[3]),
        .I3(n_0_time_out_2ms_i_2__0),
        .I4(\n_0_time_out_counter[0]_i_3__0 ),
        .I5(n_0_reset_time_out_reg),
        .O(n_0_time_out_2ms_i_1));
LUT6 #(
    .INIT(64'h0000000010000000)) 
     time_out_2ms_i_2__0
       (.I0(\n_0_time_out_counter[0]_i_10 ),
        .I1(time_out_counter_reg[17]),
        .I2(time_out_counter_reg[16]),
        .I3(time_out_counter_reg[10]),
        .I4(time_out_counter_reg[13]),
        .I5(time_out_counter_reg[12]),
        .O(n_0_time_out_2ms_i_2__0));
FDRE #(
    .INIT(1'b0)) 
     time_out_2ms_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_time_out_2ms_i_1),
        .Q(n_0_time_out_2ms_reg),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair75" *) 
   LUT4 #(
    .INIT(16'hFF7F)) 
     \time_out_counter[0]_i_10 
       (.I0(time_out_counter_reg[9]),
        .I1(time_out_counter_reg[8]),
        .I2(time_out_counter_reg[19]),
        .I3(time_out_counter_reg[18]),
        .O(\n_0_time_out_counter[0]_i_10 ));
LUT4 #(
    .INIT(16'hFFFE)) 
     \time_out_counter[0]_i_1__0 
       (.I0(\n_0_time_out_counter[0]_i_3__0 ),
        .I1(\n_0_time_out_counter[0]_i_4__0 ),
        .I2(time_out_counter_reg[2]),
        .I3(time_out_counter_reg[3]),
        .O(\n_0_time_out_counter[0]_i_1__0 ));
LUT4 #(
    .INIT(16'hFFFE)) 
     \time_out_counter[0]_i_3__0 
       (.I0(time_out_counter_reg[4]),
        .I1(time_out_counter_reg[0]),
        .I2(time_out_counter_reg[1]),
        .I3(\n_0_time_out_counter[0]_i_9__0 ),
        .O(\n_0_time_out_counter[0]_i_3__0 ));
LUT6 #(
    .INIT(64'hFFFFEFFFFFFFFFFF)) 
     \time_out_counter[0]_i_4__0 
       (.I0(\n_0_time_out_counter[0]_i_10 ),
        .I1(time_out_counter_reg[12]),
        .I2(time_out_counter_reg[13]),
        .I3(time_out_counter_reg[10]),
        .I4(time_out_counter_reg[17]),
        .I5(time_out_counter_reg[16]),
        .O(\n_0_time_out_counter[0]_i_4__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[0]_i_5__0 
       (.I0(time_out_counter_reg[3]),
        .O(\n_0_time_out_counter[0]_i_5__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[0]_i_6__0 
       (.I0(time_out_counter_reg[2]),
        .O(\n_0_time_out_counter[0]_i_6__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[0]_i_7__0 
       (.I0(time_out_counter_reg[1]),
        .O(\n_0_time_out_counter[0]_i_7__0 ));
LUT1 #(
    .INIT(2'h1)) 
     \time_out_counter[0]_i_8 
       (.I0(time_out_counter_reg[0]),
        .O(\n_0_time_out_counter[0]_i_8 ));
LUT6 #(
    .INIT(64'hFFFFFFFDFFFFFFFF)) 
     \time_out_counter[0]_i_9__0 
       (.I0(time_out_counter_reg[6]),
        .I1(time_out_counter_reg[5]),
        .I2(time_out_counter_reg[14]),
        .I3(time_out_counter_reg[15]),
        .I4(time_out_counter_reg[11]),
        .I5(time_out_counter_reg[7]),
        .O(\n_0_time_out_counter[0]_i_9__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_2__0 
       (.I0(time_out_counter_reg[15]),
        .O(\n_0_time_out_counter[12]_i_2__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_3__0 
       (.I0(time_out_counter_reg[14]),
        .O(\n_0_time_out_counter[12]_i_3__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_4__0 
       (.I0(time_out_counter_reg[13]),
        .O(\n_0_time_out_counter[12]_i_4__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_5__0 
       (.I0(time_out_counter_reg[12]),
        .O(\n_0_time_out_counter[12]_i_5__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[16]_i_2__0 
       (.I0(time_out_counter_reg[19]),
        .O(\n_0_time_out_counter[16]_i_2__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[16]_i_3__0 
       (.I0(time_out_counter_reg[18]),
        .O(\n_0_time_out_counter[16]_i_3__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[16]_i_4__0 
       (.I0(time_out_counter_reg[17]),
        .O(\n_0_time_out_counter[16]_i_4__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[16]_i_5 
       (.I0(time_out_counter_reg[16]),
        .O(\n_0_time_out_counter[16]_i_5 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_2__0 
       (.I0(time_out_counter_reg[7]),
        .O(\n_0_time_out_counter[4]_i_2__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_3__0 
       (.I0(time_out_counter_reg[6]),
        .O(\n_0_time_out_counter[4]_i_3__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_4__0 
       (.I0(time_out_counter_reg[5]),
        .O(\n_0_time_out_counter[4]_i_4__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_5__0 
       (.I0(time_out_counter_reg[4]),
        .O(\n_0_time_out_counter[4]_i_5__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_2__0 
       (.I0(time_out_counter_reg[11]),
        .O(\n_0_time_out_counter[8]_i_2__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_3__0 
       (.I0(time_out_counter_reg[10]),
        .O(\n_0_time_out_counter[8]_i_3__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_4__0 
       (.I0(time_out_counter_reg[9]),
        .O(\n_0_time_out_counter[8]_i_4__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_5__0 
       (.I0(time_out_counter_reg[8]),
        .O(\n_0_time_out_counter[8]_i_5__0 ));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[0] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_7_time_out_counter_reg[0]_i_2__0 ),
        .Q(time_out_counter_reg[0]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[0]_i_2__0 
       (.CI(1'b0),
        .CO({\n_0_time_out_counter_reg[0]_i_2__0 ,\n_1_time_out_counter_reg[0]_i_2__0 ,\n_2_time_out_counter_reg[0]_i_2__0 ,\n_3_time_out_counter_reg[0]_i_2__0 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\n_4_time_out_counter_reg[0]_i_2__0 ,\n_5_time_out_counter_reg[0]_i_2__0 ,\n_6_time_out_counter_reg[0]_i_2__0 ,\n_7_time_out_counter_reg[0]_i_2__0 }),
        .S({\n_0_time_out_counter[0]_i_5__0 ,\n_0_time_out_counter[0]_i_6__0 ,\n_0_time_out_counter[0]_i_7__0 ,\n_0_time_out_counter[0]_i_8 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[10] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_5_time_out_counter_reg[8]_i_1__0 ),
        .Q(time_out_counter_reg[10]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[11] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_4_time_out_counter_reg[8]_i_1__0 ),
        .Q(time_out_counter_reg[11]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[12] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_7_time_out_counter_reg[12]_i_1__0 ),
        .Q(time_out_counter_reg[12]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[12]_i_1__0 
       (.CI(\n_0_time_out_counter_reg[8]_i_1__0 ),
        .CO({\n_0_time_out_counter_reg[12]_i_1__0 ,\n_1_time_out_counter_reg[12]_i_1__0 ,\n_2_time_out_counter_reg[12]_i_1__0 ,\n_3_time_out_counter_reg[12]_i_1__0 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_time_out_counter_reg[12]_i_1__0 ,\n_5_time_out_counter_reg[12]_i_1__0 ,\n_6_time_out_counter_reg[12]_i_1__0 ,\n_7_time_out_counter_reg[12]_i_1__0 }),
        .S({\n_0_time_out_counter[12]_i_2__0 ,\n_0_time_out_counter[12]_i_3__0 ,\n_0_time_out_counter[12]_i_4__0 ,\n_0_time_out_counter[12]_i_5__0 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[13] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_6_time_out_counter_reg[12]_i_1__0 ),
        .Q(time_out_counter_reg[13]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[14] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_5_time_out_counter_reg[12]_i_1__0 ),
        .Q(time_out_counter_reg[14]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[15] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_4_time_out_counter_reg[12]_i_1__0 ),
        .Q(time_out_counter_reg[15]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[16] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_7_time_out_counter_reg[16]_i_1__0 ),
        .Q(time_out_counter_reg[16]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[16]_i_1__0 
       (.CI(\n_0_time_out_counter_reg[12]_i_1__0 ),
        .CO({\NLW_time_out_counter_reg[16]_i_1__0_CO_UNCONNECTED [3],\n_1_time_out_counter_reg[16]_i_1__0 ,\n_2_time_out_counter_reg[16]_i_1__0 ,\n_3_time_out_counter_reg[16]_i_1__0 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_time_out_counter_reg[16]_i_1__0 ,\n_5_time_out_counter_reg[16]_i_1__0 ,\n_6_time_out_counter_reg[16]_i_1__0 ,\n_7_time_out_counter_reg[16]_i_1__0 }),
        .S({\n_0_time_out_counter[16]_i_2__0 ,\n_0_time_out_counter[16]_i_3__0 ,\n_0_time_out_counter[16]_i_4__0 ,\n_0_time_out_counter[16]_i_5 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[17] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_6_time_out_counter_reg[16]_i_1__0 ),
        .Q(time_out_counter_reg[17]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[18] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_5_time_out_counter_reg[16]_i_1__0 ),
        .Q(time_out_counter_reg[18]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[19] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_4_time_out_counter_reg[16]_i_1__0 ),
        .Q(time_out_counter_reg[19]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[1] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_6_time_out_counter_reg[0]_i_2__0 ),
        .Q(time_out_counter_reg[1]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[2] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_5_time_out_counter_reg[0]_i_2__0 ),
        .Q(time_out_counter_reg[2]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[3] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_4_time_out_counter_reg[0]_i_2__0 ),
        .Q(time_out_counter_reg[3]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[4] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_7_time_out_counter_reg[4]_i_1__0 ),
        .Q(time_out_counter_reg[4]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[4]_i_1__0 
       (.CI(\n_0_time_out_counter_reg[0]_i_2__0 ),
        .CO({\n_0_time_out_counter_reg[4]_i_1__0 ,\n_1_time_out_counter_reg[4]_i_1__0 ,\n_2_time_out_counter_reg[4]_i_1__0 ,\n_3_time_out_counter_reg[4]_i_1__0 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_time_out_counter_reg[4]_i_1__0 ,\n_5_time_out_counter_reg[4]_i_1__0 ,\n_6_time_out_counter_reg[4]_i_1__0 ,\n_7_time_out_counter_reg[4]_i_1__0 }),
        .S({\n_0_time_out_counter[4]_i_2__0 ,\n_0_time_out_counter[4]_i_3__0 ,\n_0_time_out_counter[4]_i_4__0 ,\n_0_time_out_counter[4]_i_5__0 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[5] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_6_time_out_counter_reg[4]_i_1__0 ),
        .Q(time_out_counter_reg[5]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[6] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_5_time_out_counter_reg[4]_i_1__0 ),
        .Q(time_out_counter_reg[6]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[7] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_4_time_out_counter_reg[4]_i_1__0 ),
        .Q(time_out_counter_reg[7]),
        .R(n_0_reset_time_out_reg));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[8] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_7_time_out_counter_reg[8]_i_1__0 ),
        .Q(time_out_counter_reg[8]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[8]_i_1__0 
       (.CI(\n_0_time_out_counter_reg[4]_i_1__0 ),
        .CO({\n_0_time_out_counter_reg[8]_i_1__0 ,\n_1_time_out_counter_reg[8]_i_1__0 ,\n_2_time_out_counter_reg[8]_i_1__0 ,\n_3_time_out_counter_reg[8]_i_1__0 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_time_out_counter_reg[8]_i_1__0 ,\n_5_time_out_counter_reg[8]_i_1__0 ,\n_6_time_out_counter_reg[8]_i_1__0 ,\n_7_time_out_counter_reg[8]_i_1__0 }),
        .S({\n_0_time_out_counter[8]_i_2__0 ,\n_0_time_out_counter[8]_i_3__0 ,\n_0_time_out_counter[8]_i_4__0 ,\n_0_time_out_counter[8]_i_5__0 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[9] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_6_time_out_counter_reg[8]_i_1__0 ),
        .Q(time_out_counter_reg[9]),
        .R(n_0_reset_time_out_reg));
LUT6 #(
    .INIT(64'hFF00FF0100000000)) 
     time_out_wait_bypass_i_1__0
       (.I0(\n_0_wait_bypass_count[0]_i_4__0 ),
        .I1(wait_bypass_count_reg[10]),
        .I2(\n_0_wait_bypass_count[0]_i_5__0 ),
        .I3(n_0_time_out_wait_bypass_reg),
        .I4(rx_fsm_reset_done_int_s3),
        .I5(n_0_run_phase_alignment_int_s3_reg),
        .O(n_0_time_out_wait_bypass_i_1__0));
FDRE #(
    .INIT(1'b0)) 
     time_out_wait_bypass_reg
       (.C(I1),
        .CE(1'b1),
        .D(n_0_time_out_wait_bypass_i_1__0),
        .Q(n_0_time_out_wait_bypass_reg),
        .R(1'b0));
FDRE #(
    .INIT(1'b0)) 
     time_out_wait_bypass_s3_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(time_out_wait_bypass_s2),
        .Q(time_out_wait_bypass_s3),
        .R(1'b0));
LUT2 #(
    .INIT(4'h8)) 
     time_tlock_max_i_10
       (.I0(time_out_counter_reg[9]),
        .I1(time_out_counter_reg[8]),
        .O(n_0_time_tlock_max_i_10));
LUT2 #(
    .INIT(4'h2)) 
     time_tlock_max_i_11
       (.I0(time_out_counter_reg[14]),
        .I1(time_out_counter_reg[15]),
        .O(n_0_time_tlock_max_i_11));
LUT2 #(
    .INIT(4'h1)) 
     time_tlock_max_i_12
       (.I0(time_out_counter_reg[13]),
        .I1(time_out_counter_reg[12]),
        .O(n_0_time_tlock_max_i_12));
LUT2 #(
    .INIT(4'h8)) 
     time_tlock_max_i_13
       (.I0(time_out_counter_reg[10]),
        .I1(time_out_counter_reg[11]),
        .O(n_0_time_tlock_max_i_13));
LUT2 #(
    .INIT(4'h2)) 
     time_tlock_max_i_14
       (.I0(time_out_counter_reg[9]),
        .I1(time_out_counter_reg[8]),
        .O(n_0_time_tlock_max_i_14));
LUT2 #(
    .INIT(4'hE)) 
     time_tlock_max_i_15
       (.I0(time_out_counter_reg[6]),
        .I1(time_out_counter_reg[7]),
        .O(n_0_time_tlock_max_i_15));
LUT2 #(
    .INIT(4'h8)) 
     time_tlock_max_i_16
       (.I0(time_out_counter_reg[4]),
        .I1(time_out_counter_reg[5]),
        .O(n_0_time_tlock_max_i_16));
LUT2 #(
    .INIT(4'hE)) 
     time_tlock_max_i_17
       (.I0(time_out_counter_reg[2]),
        .I1(time_out_counter_reg[3]),
        .O(n_0_time_tlock_max_i_17));
LUT2 #(
    .INIT(4'hE)) 
     time_tlock_max_i_18
       (.I0(time_out_counter_reg[0]),
        .I1(time_out_counter_reg[1]),
        .O(n_0_time_tlock_max_i_18));
LUT2 #(
    .INIT(4'h1)) 
     time_tlock_max_i_19
       (.I0(time_out_counter_reg[6]),
        .I1(time_out_counter_reg[7]),
        .O(n_0_time_tlock_max_i_19));
(* SOFT_HLUTNM = "soft_lutpair74" *) 
   LUT4 #(
    .INIT(16'h00EA)) 
     time_tlock_max_i_1__0
       (.I0(time_tlock_max),
        .I1(time_tlock_max1),
        .I2(n_0_check_tlock_max_reg),
        .I3(n_0_reset_time_out_reg),
        .O(n_0_time_tlock_max_i_1__0));
LUT2 #(
    .INIT(4'h2)) 
     time_tlock_max_i_20
       (.I0(time_out_counter_reg[5]),
        .I1(time_out_counter_reg[4]),
        .O(n_0_time_tlock_max_i_20));
LUT2 #(
    .INIT(4'h1)) 
     time_tlock_max_i_21
       (.I0(time_out_counter_reg[3]),
        .I1(time_out_counter_reg[2]),
        .O(n_0_time_tlock_max_i_21));
LUT2 #(
    .INIT(4'h1)) 
     time_tlock_max_i_22
       (.I0(time_out_counter_reg[1]),
        .I1(time_out_counter_reg[0]),
        .O(n_0_time_tlock_max_i_22));
LUT2 #(
    .INIT(4'hE)) 
     time_tlock_max_i_4
       (.I0(time_out_counter_reg[18]),
        .I1(time_out_counter_reg[19]),
        .O(n_0_time_tlock_max_i_4));
LUT2 #(
    .INIT(4'hE)) 
     time_tlock_max_i_5
       (.I0(time_out_counter_reg[16]),
        .I1(time_out_counter_reg[17]),
        .O(n_0_time_tlock_max_i_5));
LUT2 #(
    .INIT(4'h1)) 
     time_tlock_max_i_6
       (.I0(time_out_counter_reg[19]),
        .I1(time_out_counter_reg[18]),
        .O(n_0_time_tlock_max_i_6));
LUT2 #(
    .INIT(4'h1)) 
     time_tlock_max_i_7
       (.I0(time_out_counter_reg[17]),
        .I1(time_out_counter_reg[16]),
        .O(n_0_time_tlock_max_i_7));
LUT2 #(
    .INIT(4'hE)) 
     time_tlock_max_i_9
       (.I0(time_out_counter_reg[12]),
        .I1(time_out_counter_reg[13]),
        .O(n_0_time_tlock_max_i_9));
FDRE #(
    .INIT(1'b0)) 
     time_tlock_max_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_time_tlock_max_i_1__0),
        .Q(time_tlock_max),
        .R(1'b0));
CARRY4 time_tlock_max_reg_i_2
       (.CI(n_0_time_tlock_max_reg_i_3),
        .CO({NLW_time_tlock_max_reg_i_2_CO_UNCONNECTED[3:2],time_tlock_max1,n_3_time_tlock_max_reg_i_2}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,n_0_time_tlock_max_i_4,n_0_time_tlock_max_i_5}),
        .O(NLW_time_tlock_max_reg_i_2_O_UNCONNECTED[3:0]),
        .S({1'b0,1'b0,n_0_time_tlock_max_i_6,n_0_time_tlock_max_i_7}));
CARRY4 time_tlock_max_reg_i_3
       (.CI(n_0_time_tlock_max_reg_i_8),
        .CO({n_0_time_tlock_max_reg_i_3,n_1_time_tlock_max_reg_i_3,n_2_time_tlock_max_reg_i_3,n_3_time_tlock_max_reg_i_3}),
        .CYINIT(1'b0),
        .DI({time_out_counter_reg[15],n_0_time_tlock_max_i_9,1'b0,n_0_time_tlock_max_i_10}),
        .O(NLW_time_tlock_max_reg_i_3_O_UNCONNECTED[3:0]),
        .S({n_0_time_tlock_max_i_11,n_0_time_tlock_max_i_12,n_0_time_tlock_max_i_13,n_0_time_tlock_max_i_14}));
CARRY4 time_tlock_max_reg_i_8
       (.CI(1'b0),
        .CO({n_0_time_tlock_max_reg_i_8,n_1_time_tlock_max_reg_i_8,n_2_time_tlock_max_reg_i_8,n_3_time_tlock_max_reg_i_8}),
        .CYINIT(1'b0),
        .DI({n_0_time_tlock_max_i_15,n_0_time_tlock_max_i_16,n_0_time_tlock_max_i_17,n_0_time_tlock_max_i_18}),
        .O(NLW_time_tlock_max_reg_i_8_O_UNCONNECTED[3:0]),
        .S({n_0_time_tlock_max_i_19,n_0_time_tlock_max_i_20,n_0_time_tlock_max_i_21,n_0_time_tlock_max_i_22}));
LUT1 #(
    .INIT(2'h1)) 
     \wait_bypass_count[0]_i_1__0 
       (.I0(n_0_run_phase_alignment_int_s3_reg),
        .O(\n_0_wait_bypass_count[0]_i_1__0 ));
LUT4 #(
    .INIT(16'h00FE)) 
     \wait_bypass_count[0]_i_2__0 
       (.I0(\n_0_wait_bypass_count[0]_i_4__0 ),
        .I1(wait_bypass_count_reg[10]),
        .I2(\n_0_wait_bypass_count[0]_i_5__0 ),
        .I3(rx_fsm_reset_done_int_s3),
        .O(\n_0_wait_bypass_count[0]_i_2__0 ));
LUT6 #(
    .INIT(64'hFEFFFFFFFFFFFFFF)) 
     \wait_bypass_count[0]_i_4__0 
       (.I0(wait_bypass_count_reg[5]),
        .I1(wait_bypass_count_reg[3]),
        .I2(wait_bypass_count_reg[6]),
        .I3(wait_bypass_count_reg[0]),
        .I4(wait_bypass_count_reg[8]),
        .I5(wait_bypass_count_reg[7]),
        .O(\n_0_wait_bypass_count[0]_i_4__0 ));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFF7FFF)) 
     \wait_bypass_count[0]_i_5__0 
       (.I0(wait_bypass_count_reg[1]),
        .I1(wait_bypass_count_reg[12]),
        .I2(wait_bypass_count_reg[9]),
        .I3(wait_bypass_count_reg[2]),
        .I4(wait_bypass_count_reg[4]),
        .I5(wait_bypass_count_reg[11]),
        .O(\n_0_wait_bypass_count[0]_i_5__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[0]_i_6__0 
       (.I0(wait_bypass_count_reg[3]),
        .O(\n_0_wait_bypass_count[0]_i_6__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[0]_i_7__0 
       (.I0(wait_bypass_count_reg[2]),
        .O(\n_0_wait_bypass_count[0]_i_7__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[0]_i_8__0 
       (.I0(wait_bypass_count_reg[1]),
        .O(\n_0_wait_bypass_count[0]_i_8__0 ));
LUT1 #(
    .INIT(2'h1)) 
     \wait_bypass_count[0]_i_9 
       (.I0(wait_bypass_count_reg[0]),
        .O(\n_0_wait_bypass_count[0]_i_9 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[12]_i_2__0 
       (.I0(wait_bypass_count_reg[12]),
        .O(\n_0_wait_bypass_count[12]_i_2__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_2__0 
       (.I0(wait_bypass_count_reg[7]),
        .O(\n_0_wait_bypass_count[4]_i_2__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_3__0 
       (.I0(wait_bypass_count_reg[6]),
        .O(\n_0_wait_bypass_count[4]_i_3__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_4__0 
       (.I0(wait_bypass_count_reg[5]),
        .O(\n_0_wait_bypass_count[4]_i_4__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_5__0 
       (.I0(wait_bypass_count_reg[4]),
        .O(\n_0_wait_bypass_count[4]_i_5__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_2__0 
       (.I0(wait_bypass_count_reg[11]),
        .O(\n_0_wait_bypass_count[8]_i_2__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_3__0 
       (.I0(wait_bypass_count_reg[10]),
        .O(\n_0_wait_bypass_count[8]_i_3__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_4__0 
       (.I0(wait_bypass_count_reg[9]),
        .O(\n_0_wait_bypass_count[8]_i_4__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_5__0 
       (.I0(wait_bypass_count_reg[8]),
        .O(\n_0_wait_bypass_count[8]_i_5__0 ));
FDRE \wait_bypass_count_reg[0] 
       (.C(I1),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_7_wait_bypass_count_reg[0]_i_3__0 ),
        .Q(wait_bypass_count_reg[0]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
CARRY4 \wait_bypass_count_reg[0]_i_3__0 
       (.CI(1'b0),
        .CO({\n_0_wait_bypass_count_reg[0]_i_3__0 ,\n_1_wait_bypass_count_reg[0]_i_3__0 ,\n_2_wait_bypass_count_reg[0]_i_3__0 ,\n_3_wait_bypass_count_reg[0]_i_3__0 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\n_4_wait_bypass_count_reg[0]_i_3__0 ,\n_5_wait_bypass_count_reg[0]_i_3__0 ,\n_6_wait_bypass_count_reg[0]_i_3__0 ,\n_7_wait_bypass_count_reg[0]_i_3__0 }),
        .S({\n_0_wait_bypass_count[0]_i_6__0 ,\n_0_wait_bypass_count[0]_i_7__0 ,\n_0_wait_bypass_count[0]_i_8__0 ,\n_0_wait_bypass_count[0]_i_9 }));
FDRE \wait_bypass_count_reg[10] 
       (.C(I1),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_5_wait_bypass_count_reg[8]_i_1__0 ),
        .Q(wait_bypass_count_reg[10]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
FDRE \wait_bypass_count_reg[11] 
       (.C(I1),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_4_wait_bypass_count_reg[8]_i_1__0 ),
        .Q(wait_bypass_count_reg[11]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
FDRE \wait_bypass_count_reg[12] 
       (.C(I1),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_7_wait_bypass_count_reg[12]_i_1__0 ),
        .Q(wait_bypass_count_reg[12]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
CARRY4 \wait_bypass_count_reg[12]_i_1__0 
       (.CI(\n_0_wait_bypass_count_reg[8]_i_1__0 ),
        .CO(\NLW_wait_bypass_count_reg[12]_i_1__0_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_wait_bypass_count_reg[12]_i_1__0_O_UNCONNECTED [3:1],\n_7_wait_bypass_count_reg[12]_i_1__0 }),
        .S({1'b0,1'b0,1'b0,\n_0_wait_bypass_count[12]_i_2__0 }));
FDRE \wait_bypass_count_reg[1] 
       (.C(I1),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_6_wait_bypass_count_reg[0]_i_3__0 ),
        .Q(wait_bypass_count_reg[1]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
FDRE \wait_bypass_count_reg[2] 
       (.C(I1),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_5_wait_bypass_count_reg[0]_i_3__0 ),
        .Q(wait_bypass_count_reg[2]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
FDRE \wait_bypass_count_reg[3] 
       (.C(I1),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_4_wait_bypass_count_reg[0]_i_3__0 ),
        .Q(wait_bypass_count_reg[3]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
FDRE \wait_bypass_count_reg[4] 
       (.C(I1),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_7_wait_bypass_count_reg[4]_i_1__0 ),
        .Q(wait_bypass_count_reg[4]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
CARRY4 \wait_bypass_count_reg[4]_i_1__0 
       (.CI(\n_0_wait_bypass_count_reg[0]_i_3__0 ),
        .CO({\n_0_wait_bypass_count_reg[4]_i_1__0 ,\n_1_wait_bypass_count_reg[4]_i_1__0 ,\n_2_wait_bypass_count_reg[4]_i_1__0 ,\n_3_wait_bypass_count_reg[4]_i_1__0 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_wait_bypass_count_reg[4]_i_1__0 ,\n_5_wait_bypass_count_reg[4]_i_1__0 ,\n_6_wait_bypass_count_reg[4]_i_1__0 ,\n_7_wait_bypass_count_reg[4]_i_1__0 }),
        .S({\n_0_wait_bypass_count[4]_i_2__0 ,\n_0_wait_bypass_count[4]_i_3__0 ,\n_0_wait_bypass_count[4]_i_4__0 ,\n_0_wait_bypass_count[4]_i_5__0 }));
FDRE \wait_bypass_count_reg[5] 
       (.C(I1),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_6_wait_bypass_count_reg[4]_i_1__0 ),
        .Q(wait_bypass_count_reg[5]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
FDRE \wait_bypass_count_reg[6] 
       (.C(I1),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_5_wait_bypass_count_reg[4]_i_1__0 ),
        .Q(wait_bypass_count_reg[6]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
FDRE \wait_bypass_count_reg[7] 
       (.C(I1),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_4_wait_bypass_count_reg[4]_i_1__0 ),
        .Q(wait_bypass_count_reg[7]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
FDRE \wait_bypass_count_reg[8] 
       (.C(I1),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_7_wait_bypass_count_reg[8]_i_1__0 ),
        .Q(wait_bypass_count_reg[8]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
CARRY4 \wait_bypass_count_reg[8]_i_1__0 
       (.CI(\n_0_wait_bypass_count_reg[4]_i_1__0 ),
        .CO({\n_0_wait_bypass_count_reg[8]_i_1__0 ,\n_1_wait_bypass_count_reg[8]_i_1__0 ,\n_2_wait_bypass_count_reg[8]_i_1__0 ,\n_3_wait_bypass_count_reg[8]_i_1__0 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_wait_bypass_count_reg[8]_i_1__0 ,\n_5_wait_bypass_count_reg[8]_i_1__0 ,\n_6_wait_bypass_count_reg[8]_i_1__0 ,\n_7_wait_bypass_count_reg[8]_i_1__0 }),
        .S({\n_0_wait_bypass_count[8]_i_2__0 ,\n_0_wait_bypass_count[8]_i_3__0 ,\n_0_wait_bypass_count[8]_i_4__0 ,\n_0_wait_bypass_count[8]_i_5__0 }));
FDRE \wait_bypass_count_reg[9] 
       (.C(I1),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_6_wait_bypass_count_reg[8]_i_1__0 ),
        .Q(wait_bypass_count_reg[9]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
(* SOFT_HLUTNM = "soft_lutpair79" *) 
   LUT1 #(
    .INIT(2'h1)) 
     \wait_time_cnt[0]_i_1__0 
       (.I0(wait_time_cnt_reg__0[0]),
        .O(wait_time_cnt0__0[0]));
(* SOFT_HLUTNM = "soft_lutpair79" *) 
   LUT2 #(
    .INIT(4'h9)) 
     \wait_time_cnt[1]_i_1__0 
       (.I0(wait_time_cnt_reg__0[1]),
        .I1(wait_time_cnt_reg__0[0]),
        .O(wait_time_cnt0__0[1]));
LUT3 #(
    .INIT(8'hA9)) 
     \wait_time_cnt[2]_i_1__0 
       (.I0(wait_time_cnt_reg__0[2]),
        .I1(wait_time_cnt_reg__0[0]),
        .I2(wait_time_cnt_reg__0[1]),
        .O(wait_time_cnt0__0[2]));
(* SOFT_HLUTNM = "soft_lutpair72" *) 
   LUT4 #(
    .INIT(16'hAAA9)) 
     \wait_time_cnt[3]_i_1__0 
       (.I0(wait_time_cnt_reg__0[3]),
        .I1(wait_time_cnt_reg__0[1]),
        .I2(wait_time_cnt_reg__0[0]),
        .I3(wait_time_cnt_reg__0[2]),
        .O(wait_time_cnt0__0[3]));
(* SOFT_HLUTNM = "soft_lutpair72" *) 
   LUT5 #(
    .INIT(32'hAAAAAAA9)) 
     \wait_time_cnt[4]_i_1__0 
       (.I0(wait_time_cnt_reg__0[4]),
        .I1(wait_time_cnt_reg__0[2]),
        .I2(wait_time_cnt_reg__0[0]),
        .I3(wait_time_cnt_reg__0[1]),
        .I4(wait_time_cnt_reg__0[3]),
        .O(wait_time_cnt0__0[4]));
LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA9)) 
     \wait_time_cnt[5]_i_1__0 
       (.I0(wait_time_cnt_reg__0[5]),
        .I1(wait_time_cnt_reg__0[3]),
        .I2(wait_time_cnt_reg__0[1]),
        .I3(wait_time_cnt_reg__0[0]),
        .I4(wait_time_cnt_reg__0[2]),
        .I5(wait_time_cnt_reg__0[4]),
        .O(wait_time_cnt0__0[5]));
LUT3 #(
    .INIT(8'h10)) 
     \wait_time_cnt[6]_i_1__0 
       (.I0(rx_state[1]),
        .I1(rx_state[3]),
        .I2(rx_state[0]),
        .O(\n_0_wait_time_cnt[6]_i_1__0 ));
LUT2 #(
    .INIT(4'hE)) 
     \wait_time_cnt[6]_i_2__0 
       (.I0(\n_0_wait_time_cnt[6]_i_4__0 ),
        .I1(wait_time_cnt_reg__0[6]),
        .O(\n_0_wait_time_cnt[6]_i_2__0 ));
LUT2 #(
    .INIT(4'h9)) 
     \wait_time_cnt[6]_i_3__0 
       (.I0(wait_time_cnt_reg__0[6]),
        .I1(\n_0_wait_time_cnt[6]_i_4__0 ),
        .O(wait_time_cnt0__0[6]));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
     \wait_time_cnt[6]_i_4__0 
       (.I0(wait_time_cnt_reg__0[4]),
        .I1(wait_time_cnt_reg__0[2]),
        .I2(wait_time_cnt_reg__0[0]),
        .I3(wait_time_cnt_reg__0[1]),
        .I4(wait_time_cnt_reg__0[3]),
        .I5(wait_time_cnt_reg__0[5]),
        .O(\n_0_wait_time_cnt[6]_i_4__0 ));
FDRE \wait_time_cnt_reg[0] 
       (.C(independent_clock_bufg),
        .CE(\n_0_wait_time_cnt[6]_i_2__0 ),
        .D(wait_time_cnt0__0[0]),
        .Q(wait_time_cnt_reg__0[0]),
        .R(\n_0_wait_time_cnt[6]_i_1__0 ));
FDRE \wait_time_cnt_reg[1] 
       (.C(independent_clock_bufg),
        .CE(\n_0_wait_time_cnt[6]_i_2__0 ),
        .D(wait_time_cnt0__0[1]),
        .Q(wait_time_cnt_reg__0[1]),
        .R(\n_0_wait_time_cnt[6]_i_1__0 ));
FDSE \wait_time_cnt_reg[2] 
       (.C(independent_clock_bufg),
        .CE(\n_0_wait_time_cnt[6]_i_2__0 ),
        .D(wait_time_cnt0__0[2]),
        .Q(wait_time_cnt_reg__0[2]),
        .S(\n_0_wait_time_cnt[6]_i_1__0 ));
FDRE \wait_time_cnt_reg[3] 
       (.C(independent_clock_bufg),
        .CE(\n_0_wait_time_cnt[6]_i_2__0 ),
        .D(wait_time_cnt0__0[3]),
        .Q(wait_time_cnt_reg__0[3]),
        .R(\n_0_wait_time_cnt[6]_i_1__0 ));
FDRE \wait_time_cnt_reg[4] 
       (.C(independent_clock_bufg),
        .CE(\n_0_wait_time_cnt[6]_i_2__0 ),
        .D(wait_time_cnt0__0[4]),
        .Q(wait_time_cnt_reg__0[4]),
        .R(\n_0_wait_time_cnt[6]_i_1__0 ));
FDSE \wait_time_cnt_reg[5] 
       (.C(independent_clock_bufg),
        .CE(\n_0_wait_time_cnt[6]_i_2__0 ),
        .D(wait_time_cnt0__0[5]),
        .Q(wait_time_cnt_reg__0[5]),
        .S(\n_0_wait_time_cnt[6]_i_1__0 ));
FDSE \wait_time_cnt_reg[6] 
       (.C(independent_clock_bufg),
        .CE(\n_0_wait_time_cnt[6]_i_2__0 ),
        .D(wait_time_cnt0__0[6]),
        .Q(wait_time_cnt_reg__0[6]),
        .S(\n_0_wait_time_cnt[6]_i_1__0 ));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_TX_STARTUP_FSM" *) 
module gmii_to_sgmiigmii_to_sgmii_TX_STARTUP_FSM__parameterized0
   (gt0_txresetdone_out,
    CPLL_RESET,
    TXUSERRDY,
    gt0_gttxreset_in0_out,
    I2,
    independent_clock_bufg,
    I1,
    mmcm_locked_out,
    I3,
    AR,
    reset_out);
  output gt0_txresetdone_out;
  output CPLL_RESET;
  output TXUSERRDY;
  output gt0_gttxreset_in0_out;
  input I2;
  input independent_clock_bufg;
  input I1;
  input mmcm_locked_out;
  input I3;
  input [0:0]AR;
  input reset_out;

  wire [0:0]AR;
  wire CPLL_RESET;
  wire GTTXRESET;
  wire I1;
  wire I2;
  wire I3;
  wire TXUSERRDY;
  wire clear;
  wire cplllock_sync;
  wire data_out;
  wire gt0_gttxreset_in0_out;
  wire gt0_txresetdone_out;
  wire independent_clock_bufg;
  wire [6:0]init_wait_count_reg__0;
  wire [9:0]mmcm_lock_count_reg__0;
  wire mmcm_lock_i;
  wire mmcm_lock_reclocked;
  wire mmcm_locked_out;
  wire n_0_CPLL_RESET_i_1;
  wire \n_0_FSM_sequential_tx_state[0]_i_1 ;
  wire \n_0_FSM_sequential_tx_state[0]_i_2 ;
  wire \n_0_FSM_sequential_tx_state[1]_i_1 ;
  wire \n_0_FSM_sequential_tx_state[1]_i_2 ;
  wire \n_0_FSM_sequential_tx_state[2]_i_1 ;
  wire \n_0_FSM_sequential_tx_state[3]_i_1 ;
  wire \n_0_FSM_sequential_tx_state[3]_i_2 ;
  wire \n_0_FSM_sequential_tx_state[3]_i_4 ;
  wire \n_0_FSM_sequential_tx_state[3]_i_6 ;
  wire \n_0_FSM_sequential_tx_state[3]_i_7 ;
  wire \n_0_FSM_sequential_tx_state_reg[3]_i_3 ;
  wire n_0_TXUSERRDY_i_1;
  wire n_0_gttxreset_i_i_1;
  wire \n_0_init_wait_count[0]_i_1 ;
  wire \n_0_init_wait_count[6]_i_1 ;
  wire \n_0_init_wait_count[6]_i_3 ;
  wire \n_0_init_wait_count[6]_i_4 ;
  wire n_0_init_wait_done_i_1;
  wire n_0_init_wait_done_i_2;
  wire n_0_init_wait_done_reg;
  wire \n_0_mmcm_lock_count[9]_i_1 ;
  wire \n_0_mmcm_lock_count[9]_i_2 ;
  wire \n_0_mmcm_lock_count[9]_i_4 ;
  wire n_0_mmcm_lock_reclocked_i_1;
  wire n_0_mmcm_lock_reclocked_i_2;
  wire n_0_pll_reset_asserted_i_1;
  wire n_0_pll_reset_asserted_reg;
  wire n_0_reset_time_out_i_1;
  wire n_0_reset_time_out_i_2;
  wire n_0_reset_time_out_i_3;
  wire n_0_run_phase_alignment_int_i_1;
  wire n_0_run_phase_alignment_int_reg;
  wire n_0_time_out_2ms_i_1__0;
  wire n_0_time_out_2ms_i_2;
  wire n_0_time_out_2ms_reg;
  wire n_0_time_out_500us_i_1;
  wire n_0_time_out_500us_i_2;
  wire n_0_time_out_500us_reg;
  wire \n_0_time_out_counter[0]_i_1 ;
  wire \n_0_time_out_counter[0]_i_10__0 ;
  wire \n_0_time_out_counter[0]_i_3 ;
  wire \n_0_time_out_counter[0]_i_4 ;
  wire \n_0_time_out_counter[0]_i_5 ;
  wire \n_0_time_out_counter[0]_i_6 ;
  wire \n_0_time_out_counter[0]_i_7 ;
  wire \n_0_time_out_counter[0]_i_8__0 ;
  wire \n_0_time_out_counter[0]_i_9 ;
  wire \n_0_time_out_counter[12]_i_2 ;
  wire \n_0_time_out_counter[12]_i_3 ;
  wire \n_0_time_out_counter[12]_i_4 ;
  wire \n_0_time_out_counter[12]_i_5 ;
  wire \n_0_time_out_counter[16]_i_2 ;
  wire \n_0_time_out_counter[16]_i_3 ;
  wire \n_0_time_out_counter[16]_i_4 ;
  wire \n_0_time_out_counter[4]_i_2 ;
  wire \n_0_time_out_counter[4]_i_3 ;
  wire \n_0_time_out_counter[4]_i_4 ;
  wire \n_0_time_out_counter[4]_i_5 ;
  wire \n_0_time_out_counter[8]_i_2 ;
  wire \n_0_time_out_counter[8]_i_3 ;
  wire \n_0_time_out_counter[8]_i_4 ;
  wire \n_0_time_out_counter[8]_i_5 ;
  wire \n_0_time_out_counter_reg[0]_i_2 ;
  wire \n_0_time_out_counter_reg[12]_i_1 ;
  wire \n_0_time_out_counter_reg[4]_i_1 ;
  wire \n_0_time_out_counter_reg[8]_i_1 ;
  wire n_0_time_out_wait_bypass_i_1;
  wire n_0_time_out_wait_bypass_reg;
  wire n_0_time_tlock_max_i_1;
  wire n_0_time_tlock_max_i_2;
  wire n_0_time_tlock_max_i_3;
  wire n_0_time_tlock_max_reg;
  wire n_0_tx_fsm_reset_done_int_i_1;
  wire \n_0_wait_bypass_count[0]_i_1 ;
  wire \n_0_wait_bypass_count[0]_i_10 ;
  wire \n_0_wait_bypass_count[0]_i_2 ;
  wire \n_0_wait_bypass_count[0]_i_4 ;
  wire \n_0_wait_bypass_count[0]_i_5 ;
  wire \n_0_wait_bypass_count[0]_i_6 ;
  wire \n_0_wait_bypass_count[0]_i_7 ;
  wire \n_0_wait_bypass_count[0]_i_8 ;
  wire \n_0_wait_bypass_count[0]_i_9__0 ;
  wire \n_0_wait_bypass_count[12]_i_2 ;
  wire \n_0_wait_bypass_count[12]_i_3 ;
  wire \n_0_wait_bypass_count[12]_i_4 ;
  wire \n_0_wait_bypass_count[12]_i_5 ;
  wire \n_0_wait_bypass_count[16]_i_2 ;
  wire \n_0_wait_bypass_count[4]_i_2 ;
  wire \n_0_wait_bypass_count[4]_i_3 ;
  wire \n_0_wait_bypass_count[4]_i_4 ;
  wire \n_0_wait_bypass_count[4]_i_5 ;
  wire \n_0_wait_bypass_count[8]_i_2 ;
  wire \n_0_wait_bypass_count[8]_i_3 ;
  wire \n_0_wait_bypass_count[8]_i_4 ;
  wire \n_0_wait_bypass_count[8]_i_5 ;
  wire \n_0_wait_bypass_count_reg[0]_i_3 ;
  wire \n_0_wait_bypass_count_reg[12]_i_1 ;
  wire \n_0_wait_bypass_count_reg[4]_i_1 ;
  wire \n_0_wait_bypass_count_reg[8]_i_1 ;
  wire \n_0_wait_time_cnt[6]_i_4 ;
  wire \n_1_time_out_counter_reg[0]_i_2 ;
  wire \n_1_time_out_counter_reg[12]_i_1 ;
  wire \n_1_time_out_counter_reg[4]_i_1 ;
  wire \n_1_time_out_counter_reg[8]_i_1 ;
  wire \n_1_wait_bypass_count_reg[0]_i_3 ;
  wire \n_1_wait_bypass_count_reg[12]_i_1 ;
  wire \n_1_wait_bypass_count_reg[4]_i_1 ;
  wire \n_1_wait_bypass_count_reg[8]_i_1 ;
  wire \n_2_time_out_counter_reg[0]_i_2 ;
  wire \n_2_time_out_counter_reg[12]_i_1 ;
  wire \n_2_time_out_counter_reg[16]_i_1 ;
  wire \n_2_time_out_counter_reg[4]_i_1 ;
  wire \n_2_time_out_counter_reg[8]_i_1 ;
  wire \n_2_wait_bypass_count_reg[0]_i_3 ;
  wire \n_2_wait_bypass_count_reg[12]_i_1 ;
  wire \n_2_wait_bypass_count_reg[4]_i_1 ;
  wire \n_2_wait_bypass_count_reg[8]_i_1 ;
  wire \n_3_time_out_counter_reg[0]_i_2 ;
  wire \n_3_time_out_counter_reg[12]_i_1 ;
  wire \n_3_time_out_counter_reg[16]_i_1 ;
  wire \n_3_time_out_counter_reg[4]_i_1 ;
  wire \n_3_time_out_counter_reg[8]_i_1 ;
  wire \n_3_wait_bypass_count_reg[0]_i_3 ;
  wire \n_3_wait_bypass_count_reg[12]_i_1 ;
  wire \n_3_wait_bypass_count_reg[4]_i_1 ;
  wire \n_3_wait_bypass_count_reg[8]_i_1 ;
  wire \n_4_time_out_counter_reg[0]_i_2 ;
  wire \n_4_time_out_counter_reg[12]_i_1 ;
  wire \n_4_time_out_counter_reg[4]_i_1 ;
  wire \n_4_time_out_counter_reg[8]_i_1 ;
  wire \n_4_wait_bypass_count_reg[0]_i_3 ;
  wire \n_4_wait_bypass_count_reg[12]_i_1 ;
  wire \n_4_wait_bypass_count_reg[4]_i_1 ;
  wire \n_4_wait_bypass_count_reg[8]_i_1 ;
  wire \n_5_time_out_counter_reg[0]_i_2 ;
  wire \n_5_time_out_counter_reg[12]_i_1 ;
  wire \n_5_time_out_counter_reg[16]_i_1 ;
  wire \n_5_time_out_counter_reg[4]_i_1 ;
  wire \n_5_time_out_counter_reg[8]_i_1 ;
  wire \n_5_wait_bypass_count_reg[0]_i_3 ;
  wire \n_5_wait_bypass_count_reg[12]_i_1 ;
  wire \n_5_wait_bypass_count_reg[4]_i_1 ;
  wire \n_5_wait_bypass_count_reg[8]_i_1 ;
  wire \n_6_time_out_counter_reg[0]_i_2 ;
  wire \n_6_time_out_counter_reg[12]_i_1 ;
  wire \n_6_time_out_counter_reg[16]_i_1 ;
  wire \n_6_time_out_counter_reg[4]_i_1 ;
  wire \n_6_time_out_counter_reg[8]_i_1 ;
  wire \n_6_wait_bypass_count_reg[0]_i_3 ;
  wire \n_6_wait_bypass_count_reg[12]_i_1 ;
  wire \n_6_wait_bypass_count_reg[4]_i_1 ;
  wire \n_6_wait_bypass_count_reg[8]_i_1 ;
  wire \n_7_time_out_counter_reg[0]_i_2 ;
  wire \n_7_time_out_counter_reg[12]_i_1 ;
  wire \n_7_time_out_counter_reg[16]_i_1 ;
  wire \n_7_time_out_counter_reg[4]_i_1 ;
  wire \n_7_time_out_counter_reg[8]_i_1 ;
  wire \n_7_wait_bypass_count_reg[0]_i_3 ;
  wire \n_7_wait_bypass_count_reg[12]_i_1 ;
  wire \n_7_wait_bypass_count_reg[16]_i_1 ;
  wire \n_7_wait_bypass_count_reg[4]_i_1 ;
  wire \n_7_wait_bypass_count_reg[8]_i_1 ;
  wire [6:1]p_0_in;
  wire [9:0]p_0_in__0;
  wire reset_out;
  wire reset_time_out;
  wire run_phase_alignment_int_s3;
  wire sel;
  wire [18:0]time_out_counter_reg;
  wire time_out_wait_bypass_s2;
  wire time_out_wait_bypass_s3;
  wire tx_fsm_reset_done_int_s2;
  wire tx_fsm_reset_done_int_s3;
(* RTL_KEEP = "yes" *)   wire [3:0]tx_state;
  wire tx_state12_out;
  wire tx_state13_out;
  wire txresetdone_s2;
  wire txresetdone_s3;
  wire [16:0]wait_bypass_count_reg;
  wire [6:0]wait_time_cnt0;
  wire [6:0]wait_time_cnt_reg__0;
  wire [3:2]\NLW_time_out_counter_reg[16]_i_1_CO_UNCONNECTED ;
  wire [3:3]\NLW_time_out_counter_reg[16]_i_1_O_UNCONNECTED ;
  wire [3:0]\NLW_wait_bypass_count_reg[16]_i_1_CO_UNCONNECTED ;
  wire [3:1]\NLW_wait_bypass_count_reg[16]_i_1_O_UNCONNECTED ;

LUT6 #(
    .INIT(64'hFFFFFFF700000004)) 
     CPLL_RESET_i_1
       (.I0(n_0_pll_reset_asserted_reg),
        .I1(tx_state[0]),
        .I2(tx_state[2]),
        .I3(tx_state[1]),
        .I4(tx_state[3]),
        .I5(CPLL_RESET),
        .O(n_0_CPLL_RESET_i_1));
FDRE #(
    .INIT(1'b0)) 
     CPLL_RESET_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_CPLL_RESET_i_1),
        .Q(CPLL_RESET),
        .R(AR));
LUT5 #(
    .INIT(32'h0F001F1F)) 
     \FSM_sequential_tx_state[0]_i_1 
       (.I0(tx_state[1]),
        .I1(tx_state[2]),
        .I2(tx_state[3]),
        .I3(\n_0_FSM_sequential_tx_state[0]_i_2 ),
        .I4(tx_state[0]),
        .O(\n_0_FSM_sequential_tx_state[0]_i_1 ));
LUT6 #(
    .INIT(64'h22F0000022F0FFFF)) 
     \FSM_sequential_tx_state[0]_i_2 
       (.I0(n_0_time_out_500us_reg),
        .I1(reset_time_out),
        .I2(n_0_time_out_2ms_reg),
        .I3(tx_state[2]),
        .I4(tx_state[1]),
        .I5(\n_0_FSM_sequential_tx_state[1]_i_2 ),
        .O(\n_0_FSM_sequential_tx_state[0]_i_2 ));
LUT4 #(
    .INIT(16'h0062)) 
     \FSM_sequential_tx_state[1]_i_1 
       (.I0(tx_state[1]),
        .I1(tx_state[0]),
        .I2(\n_0_FSM_sequential_tx_state[1]_i_2 ),
        .I3(tx_state[3]),
        .O(\n_0_FSM_sequential_tx_state[1]_i_1 ));
LUT4 #(
    .INIT(16'hFFF7)) 
     \FSM_sequential_tx_state[1]_i_2 
       (.I0(tx_state[2]),
        .I1(n_0_time_tlock_max_reg),
        .I2(reset_time_out),
        .I3(mmcm_lock_reclocked),
        .O(\n_0_FSM_sequential_tx_state[1]_i_2 ));
LUT6 #(
    .INIT(64'h00000000222A662A)) 
     \FSM_sequential_tx_state[2]_i_1 
       (.I0(tx_state[2]),
        .I1(tx_state[0]),
        .I2(tx_state13_out),
        .I3(tx_state[1]),
        .I4(n_0_time_out_2ms_reg),
        .I5(tx_state[3]),
        .O(\n_0_FSM_sequential_tx_state[2]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair89" *) 
   LUT3 #(
    .INIT(8'h10)) 
     \FSM_sequential_tx_state[2]_i_2 
       (.I0(mmcm_lock_reclocked),
        .I1(reset_time_out),
        .I2(n_0_time_tlock_max_reg),
        .O(tx_state13_out));
LUT6 #(
    .INIT(64'h4F4AEAEA4F4AEFEF)) 
     \FSM_sequential_tx_state[3]_i_1 
       (.I0(tx_state[3]),
        .I1(\n_0_FSM_sequential_tx_state_reg[3]_i_3 ),
        .I2(tx_state[0]),
        .I3(n_0_init_wait_done_reg),
        .I4(\n_0_FSM_sequential_tx_state[3]_i_4 ),
        .I5(sel),
        .O(\n_0_FSM_sequential_tx_state[3]_i_1 ));
LUT6 #(
    .INIT(64'h0300004C00000044)) 
     \FSM_sequential_tx_state[3]_i_2 
       (.I0(time_out_wait_bypass_s3),
        .I1(tx_state[3]),
        .I2(tx_state12_out),
        .I3(tx_state[2]),
        .I4(tx_state[1]),
        .I5(tx_state[0]),
        .O(\n_0_FSM_sequential_tx_state[3]_i_2 ));
LUT2 #(
    .INIT(4'h1)) 
     \FSM_sequential_tx_state[3]_i_4 
       (.I0(tx_state[2]),
        .I1(tx_state[1]),
        .O(\n_0_FSM_sequential_tx_state[3]_i_4 ));
(* SOFT_HLUTNM = "soft_lutpair88" *) 
   LUT2 #(
    .INIT(4'h2)) 
     \FSM_sequential_tx_state[3]_i_5 
       (.I0(n_0_time_out_500us_reg),
        .I1(reset_time_out),
        .O(tx_state12_out));
LUT6 #(
    .INIT(64'hF400F400F4FFF400)) 
     \FSM_sequential_tx_state[3]_i_6 
       (.I0(reset_time_out),
        .I1(n_0_time_tlock_max_reg),
        .I2(mmcm_lock_reclocked),
        .I3(tx_state[2]),
        .I4(n_0_pll_reset_asserted_reg),
        .I5(cplllock_sync),
        .O(\n_0_FSM_sequential_tx_state[3]_i_6 ));
LUT6 #(
    .INIT(64'hF4FFF4FFF4FFF400)) 
     \FSM_sequential_tx_state[3]_i_7 
       (.I0(reset_time_out),
        .I1(n_0_time_out_500us_reg),
        .I2(txresetdone_s3),
        .I3(tx_state[2]),
        .I4(n_0_time_out_2ms_reg),
        .I5(cplllock_sync),
        .O(\n_0_FSM_sequential_tx_state[3]_i_7 ));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_tx_state_reg[0] 
       (.C(independent_clock_bufg),
        .CE(\n_0_FSM_sequential_tx_state[3]_i_1 ),
        .D(\n_0_FSM_sequential_tx_state[0]_i_1 ),
        .Q(tx_state[0]),
        .R(AR));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_tx_state_reg[1] 
       (.C(independent_clock_bufg),
        .CE(\n_0_FSM_sequential_tx_state[3]_i_1 ),
        .D(\n_0_FSM_sequential_tx_state[1]_i_1 ),
        .Q(tx_state[1]),
        .R(AR));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_tx_state_reg[2] 
       (.C(independent_clock_bufg),
        .CE(\n_0_FSM_sequential_tx_state[3]_i_1 ),
        .D(\n_0_FSM_sequential_tx_state[2]_i_1 ),
        .Q(tx_state[2]),
        .R(AR));
(* KEEP = "yes" *) 
   FDRE \FSM_sequential_tx_state_reg[3] 
       (.C(independent_clock_bufg),
        .CE(\n_0_FSM_sequential_tx_state[3]_i_1 ),
        .D(\n_0_FSM_sequential_tx_state[3]_i_2 ),
        .Q(tx_state[3]),
        .R(AR));
MUXF7 \FSM_sequential_tx_state_reg[3]_i_3 
       (.I0(\n_0_FSM_sequential_tx_state[3]_i_6 ),
        .I1(\n_0_FSM_sequential_tx_state[3]_i_7 ),
        .O(\n_0_FSM_sequential_tx_state_reg[3]_i_3 ),
        .S(tx_state[1]));
LUT5 #(
    .INIT(32'hFFFD0080)) 
     TXUSERRDY_i_1
       (.I0(tx_state[0]),
        .I1(tx_state[1]),
        .I2(tx_state[2]),
        .I3(tx_state[3]),
        .I4(TXUSERRDY),
        .O(n_0_TXUSERRDY_i_1));
FDRE #(
    .INIT(1'b0)) 
     TXUSERRDY_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_TXUSERRDY_i_1),
        .Q(TXUSERRDY),
        .R(AR));
LUT3 #(
    .INIT(8'hEA)) 
     gthe2_i_i_3
       (.I0(GTTXRESET),
        .I1(reset_out),
        .I2(gt0_txresetdone_out),
        .O(gt0_gttxreset_in0_out));
LUT5 #(
    .INIT(32'hFFFB0010)) 
     gttxreset_i_i_1
       (.I0(tx_state[1]),
        .I1(tx_state[2]),
        .I2(tx_state[0]),
        .I3(tx_state[3]),
        .I4(GTTXRESET),
        .O(n_0_gttxreset_i_i_1));
FDRE #(
    .INIT(1'b0)) 
     gttxreset_i_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_gttxreset_i_i_1),
        .Q(GTTXRESET),
        .R(AR));
LUT1 #(
    .INIT(2'h1)) 
     \init_wait_count[0]_i_1 
       (.I0(init_wait_count_reg__0[0]),
        .O(\n_0_init_wait_count[0]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair91" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \init_wait_count[1]_i_1 
       (.I0(init_wait_count_reg__0[1]),
        .I1(init_wait_count_reg__0[0]),
        .O(p_0_in[1]));
(* SOFT_HLUTNM = "soft_lutpair86" *) 
   LUT3 #(
    .INIT(8'h78)) 
     \init_wait_count[2]_i_1 
       (.I0(init_wait_count_reg__0[1]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[2]),
        .O(p_0_in[2]));
(* SOFT_HLUTNM = "soft_lutpair86" *) 
   LUT4 #(
    .INIT(16'h7F80)) 
     \init_wait_count[3]_i_1 
       (.I0(init_wait_count_reg__0[2]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[1]),
        .I3(init_wait_count_reg__0[3]),
        .O(p_0_in[3]));
(* SOFT_HLUTNM = "soft_lutpair82" *) 
   LUT5 #(
    .INIT(32'h7FFF8000)) 
     \init_wait_count[4]_i_1 
       (.I0(init_wait_count_reg__0[3]),
        .I1(init_wait_count_reg__0[1]),
        .I2(init_wait_count_reg__0[0]),
        .I3(init_wait_count_reg__0[2]),
        .I4(init_wait_count_reg__0[4]),
        .O(p_0_in[4]));
LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
     \init_wait_count[5]_i_1 
       (.I0(init_wait_count_reg__0[4]),
        .I1(init_wait_count_reg__0[2]),
        .I2(init_wait_count_reg__0[0]),
        .I3(init_wait_count_reg__0[1]),
        .I4(init_wait_count_reg__0[3]),
        .I5(init_wait_count_reg__0[5]),
        .O(p_0_in[5]));
LUT6 #(
    .INIT(64'hFFFFFFFFFF7FFFFF)) 
     \init_wait_count[6]_i_1 
       (.I0(init_wait_count_reg__0[5]),
        .I1(init_wait_count_reg__0[6]),
        .I2(init_wait_count_reg__0[3]),
        .I3(init_wait_count_reg__0[4]),
        .I4(init_wait_count_reg__0[2]),
        .I5(\n_0_init_wait_count[6]_i_3 ),
        .O(\n_0_init_wait_count[6]_i_1 ));
LUT3 #(
    .INIT(8'hD2)) 
     \init_wait_count[6]_i_2 
       (.I0(init_wait_count_reg__0[5]),
        .I1(\n_0_init_wait_count[6]_i_4 ),
        .I2(init_wait_count_reg__0[6]),
        .O(p_0_in[6]));
(* SOFT_HLUTNM = "soft_lutpair91" *) 
   LUT2 #(
    .INIT(4'hB)) 
     \init_wait_count[6]_i_3 
       (.I0(init_wait_count_reg__0[0]),
        .I1(init_wait_count_reg__0[1]),
        .O(\n_0_init_wait_count[6]_i_3 ));
(* SOFT_HLUTNM = "soft_lutpair82" *) 
   LUT5 #(
    .INIT(32'h7FFFFFFF)) 
     \init_wait_count[6]_i_4 
       (.I0(init_wait_count_reg__0[3]),
        .I1(init_wait_count_reg__0[1]),
        .I2(init_wait_count_reg__0[0]),
        .I3(init_wait_count_reg__0[2]),
        .I4(init_wait_count_reg__0[4]),
        .O(\n_0_init_wait_count[6]_i_4 ));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[0] 
       (.C(independent_clock_bufg),
        .CE(\n_0_init_wait_count[6]_i_1 ),
        .CLR(AR),
        .D(\n_0_init_wait_count[0]_i_1 ),
        .Q(init_wait_count_reg__0[0]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[1] 
       (.C(independent_clock_bufg),
        .CE(\n_0_init_wait_count[6]_i_1 ),
        .CLR(AR),
        .D(p_0_in[1]),
        .Q(init_wait_count_reg__0[1]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[2] 
       (.C(independent_clock_bufg),
        .CE(\n_0_init_wait_count[6]_i_1 ),
        .CLR(AR),
        .D(p_0_in[2]),
        .Q(init_wait_count_reg__0[2]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[3] 
       (.C(independent_clock_bufg),
        .CE(\n_0_init_wait_count[6]_i_1 ),
        .CLR(AR),
        .D(p_0_in[3]),
        .Q(init_wait_count_reg__0[3]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[4] 
       (.C(independent_clock_bufg),
        .CE(\n_0_init_wait_count[6]_i_1 ),
        .CLR(AR),
        .D(p_0_in[4]),
        .Q(init_wait_count_reg__0[4]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[5] 
       (.C(independent_clock_bufg),
        .CE(\n_0_init_wait_count[6]_i_1 ),
        .CLR(AR),
        .D(p_0_in[5]),
        .Q(init_wait_count_reg__0[5]));
FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[6] 
       (.C(independent_clock_bufg),
        .CE(\n_0_init_wait_count[6]_i_1 ),
        .CLR(AR),
        .D(p_0_in[6]),
        .Q(init_wait_count_reg__0[6]));
LUT6 #(
    .INIT(64'hFFFFFFFF00008000)) 
     init_wait_done_i_1
       (.I0(n_0_init_wait_done_i_2),
        .I1(init_wait_count_reg__0[2]),
        .I2(init_wait_count_reg__0[6]),
        .I3(init_wait_count_reg__0[5]),
        .I4(\n_0_init_wait_count[6]_i_3 ),
        .I5(n_0_init_wait_done_reg),
        .O(n_0_init_wait_done_i_1));
LUT2 #(
    .INIT(4'h2)) 
     init_wait_done_i_2
       (.I0(init_wait_count_reg__0[3]),
        .I1(init_wait_count_reg__0[4]),
        .O(n_0_init_wait_done_i_2));
FDCE #(
    .INIT(1'b0)) 
     init_wait_done_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .CLR(AR),
        .D(n_0_init_wait_done_i_1),
        .Q(n_0_init_wait_done_reg));
LUT1 #(
    .INIT(2'h1)) 
     \mmcm_lock_count[0]_i_1 
       (.I0(mmcm_lock_count_reg__0[0]),
        .O(p_0_in__0[0]));
(* SOFT_HLUTNM = "soft_lutpair90" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \mmcm_lock_count[1]_i_1 
       (.I0(mmcm_lock_count_reg__0[0]),
        .I1(mmcm_lock_count_reg__0[1]),
        .O(p_0_in__0[1]));
(* SOFT_HLUTNM = "soft_lutpair90" *) 
   LUT3 #(
    .INIT(8'h78)) 
     \mmcm_lock_count[2]_i_1 
       (.I0(mmcm_lock_count_reg__0[1]),
        .I1(mmcm_lock_count_reg__0[0]),
        .I2(mmcm_lock_count_reg__0[2]),
        .O(p_0_in__0[2]));
(* SOFT_HLUTNM = "soft_lutpair84" *) 
   LUT4 #(
    .INIT(16'h7F80)) 
     \mmcm_lock_count[3]_i_1 
       (.I0(mmcm_lock_count_reg__0[2]),
        .I1(mmcm_lock_count_reg__0[0]),
        .I2(mmcm_lock_count_reg__0[1]),
        .I3(mmcm_lock_count_reg__0[3]),
        .O(p_0_in__0[3]));
(* SOFT_HLUTNM = "soft_lutpair84" *) 
   LUT5 #(
    .INIT(32'h7FFF8000)) 
     \mmcm_lock_count[4]_i_1 
       (.I0(mmcm_lock_count_reg__0[3]),
        .I1(mmcm_lock_count_reg__0[1]),
        .I2(mmcm_lock_count_reg__0[0]),
        .I3(mmcm_lock_count_reg__0[2]),
        .I4(mmcm_lock_count_reg__0[4]),
        .O(p_0_in__0[4]));
LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
     \mmcm_lock_count[5]_i_1 
       (.I0(mmcm_lock_count_reg__0[4]),
        .I1(mmcm_lock_count_reg__0[2]),
        .I2(mmcm_lock_count_reg__0[0]),
        .I3(mmcm_lock_count_reg__0[1]),
        .I4(mmcm_lock_count_reg__0[3]),
        .I5(mmcm_lock_count_reg__0[5]),
        .O(p_0_in__0[5]));
LUT2 #(
    .INIT(4'h9)) 
     \mmcm_lock_count[6]_i_1 
       (.I0(\n_0_mmcm_lock_count[9]_i_4 ),
        .I1(mmcm_lock_count_reg__0[6]),
        .O(p_0_in__0[6]));
(* SOFT_HLUTNM = "soft_lutpair87" *) 
   LUT3 #(
    .INIT(8'hD2)) 
     \mmcm_lock_count[7]_i_1 
       (.I0(mmcm_lock_count_reg__0[6]),
        .I1(\n_0_mmcm_lock_count[9]_i_4 ),
        .I2(mmcm_lock_count_reg__0[7]),
        .O(p_0_in__0[7]));
(* SOFT_HLUTNM = "soft_lutpair87" *) 
   LUT4 #(
    .INIT(16'hDF20)) 
     \mmcm_lock_count[8]_i_1 
       (.I0(mmcm_lock_count_reg__0[7]),
        .I1(\n_0_mmcm_lock_count[9]_i_4 ),
        .I2(mmcm_lock_count_reg__0[6]),
        .I3(mmcm_lock_count_reg__0[8]),
        .O(p_0_in__0[8]));
LUT1 #(
    .INIT(2'h1)) 
     \mmcm_lock_count[9]_i_1 
       (.I0(mmcm_lock_i),
        .O(\n_0_mmcm_lock_count[9]_i_1 ));
LUT5 #(
    .INIT(32'hDFFFFFFF)) 
     \mmcm_lock_count[9]_i_2 
       (.I0(mmcm_lock_count_reg__0[7]),
        .I1(\n_0_mmcm_lock_count[9]_i_4 ),
        .I2(mmcm_lock_count_reg__0[6]),
        .I3(mmcm_lock_count_reg__0[8]),
        .I4(mmcm_lock_count_reg__0[9]),
        .O(\n_0_mmcm_lock_count[9]_i_2 ));
(* SOFT_HLUTNM = "soft_lutpair83" *) 
   LUT5 #(
    .INIT(32'hF7FF0800)) 
     \mmcm_lock_count[9]_i_3 
       (.I0(mmcm_lock_count_reg__0[8]),
        .I1(mmcm_lock_count_reg__0[6]),
        .I2(\n_0_mmcm_lock_count[9]_i_4 ),
        .I3(mmcm_lock_count_reg__0[7]),
        .I4(mmcm_lock_count_reg__0[9]),
        .O(p_0_in__0[9]));
LUT6 #(
    .INIT(64'h7FFFFFFFFFFFFFFF)) 
     \mmcm_lock_count[9]_i_4 
       (.I0(mmcm_lock_count_reg__0[4]),
        .I1(mmcm_lock_count_reg__0[2]),
        .I2(mmcm_lock_count_reg__0[0]),
        .I3(mmcm_lock_count_reg__0[1]),
        .I4(mmcm_lock_count_reg__0[3]),
        .I5(mmcm_lock_count_reg__0[5]),
        .O(\n_0_mmcm_lock_count[9]_i_4 ));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[0] 
       (.C(independent_clock_bufg),
        .CE(\n_0_mmcm_lock_count[9]_i_2 ),
        .D(p_0_in__0[0]),
        .Q(mmcm_lock_count_reg__0[0]),
        .R(\n_0_mmcm_lock_count[9]_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[1] 
       (.C(independent_clock_bufg),
        .CE(\n_0_mmcm_lock_count[9]_i_2 ),
        .D(p_0_in__0[1]),
        .Q(mmcm_lock_count_reg__0[1]),
        .R(\n_0_mmcm_lock_count[9]_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[2] 
       (.C(independent_clock_bufg),
        .CE(\n_0_mmcm_lock_count[9]_i_2 ),
        .D(p_0_in__0[2]),
        .Q(mmcm_lock_count_reg__0[2]),
        .R(\n_0_mmcm_lock_count[9]_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[3] 
       (.C(independent_clock_bufg),
        .CE(\n_0_mmcm_lock_count[9]_i_2 ),
        .D(p_0_in__0[3]),
        .Q(mmcm_lock_count_reg__0[3]),
        .R(\n_0_mmcm_lock_count[9]_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[4] 
       (.C(independent_clock_bufg),
        .CE(\n_0_mmcm_lock_count[9]_i_2 ),
        .D(p_0_in__0[4]),
        .Q(mmcm_lock_count_reg__0[4]),
        .R(\n_0_mmcm_lock_count[9]_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[5] 
       (.C(independent_clock_bufg),
        .CE(\n_0_mmcm_lock_count[9]_i_2 ),
        .D(p_0_in__0[5]),
        .Q(mmcm_lock_count_reg__0[5]),
        .R(\n_0_mmcm_lock_count[9]_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[6] 
       (.C(independent_clock_bufg),
        .CE(\n_0_mmcm_lock_count[9]_i_2 ),
        .D(p_0_in__0[6]),
        .Q(mmcm_lock_count_reg__0[6]),
        .R(\n_0_mmcm_lock_count[9]_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[7] 
       (.C(independent_clock_bufg),
        .CE(\n_0_mmcm_lock_count[9]_i_2 ),
        .D(p_0_in__0[7]),
        .Q(mmcm_lock_count_reg__0[7]),
        .R(\n_0_mmcm_lock_count[9]_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[8] 
       (.C(independent_clock_bufg),
        .CE(\n_0_mmcm_lock_count[9]_i_2 ),
        .D(p_0_in__0[8]),
        .Q(mmcm_lock_count_reg__0[8]),
        .R(\n_0_mmcm_lock_count[9]_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[9] 
       (.C(independent_clock_bufg),
        .CE(\n_0_mmcm_lock_count[9]_i_2 ),
        .D(p_0_in__0[9]),
        .Q(mmcm_lock_count_reg__0[9]),
        .R(\n_0_mmcm_lock_count[9]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair89" *) 
   LUT3 #(
    .INIT(8'hE0)) 
     mmcm_lock_reclocked_i_1
       (.I0(mmcm_lock_reclocked),
        .I1(n_0_mmcm_lock_reclocked_i_2),
        .I2(mmcm_lock_i),
        .O(n_0_mmcm_lock_reclocked_i_1));
(* SOFT_HLUTNM = "soft_lutpair83" *) 
   LUT5 #(
    .INIT(32'h00800000)) 
     mmcm_lock_reclocked_i_2
       (.I0(mmcm_lock_count_reg__0[9]),
        .I1(mmcm_lock_count_reg__0[8]),
        .I2(mmcm_lock_count_reg__0[6]),
        .I3(\n_0_mmcm_lock_count[9]_i_4 ),
        .I4(mmcm_lock_count_reg__0[7]),
        .O(n_0_mmcm_lock_reclocked_i_2));
FDRE #(
    .INIT(1'b0)) 
     mmcm_lock_reclocked_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_mmcm_lock_reclocked_i_1),
        .Q(mmcm_lock_reclocked),
        .R(1'b0));
LUT5 #(
    .INIT(32'hF0F0F072)) 
     pll_reset_asserted_i_1
       (.I0(tx_state[0]),
        .I1(tx_state[1]),
        .I2(n_0_pll_reset_asserted_reg),
        .I3(tx_state[2]),
        .I4(tx_state[3]),
        .O(n_0_pll_reset_asserted_i_1));
FDRE #(
    .INIT(1'b0)) 
     pll_reset_asserted_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_pll_reset_asserted_i_1),
        .Q(n_0_pll_reset_asserted_reg),
        .R(AR));
LUT6 #(
    .INIT(64'hF9F8FFFFF9F80000)) 
     reset_time_out_i_1
       (.I0(tx_state[3]),
        .I1(tx_state[0]),
        .I2(n_0_reset_time_out_i_2),
        .I3(n_0_init_wait_done_reg),
        .I4(n_0_reset_time_out_i_3),
        .I5(reset_time_out),
        .O(n_0_reset_time_out_i_1));
LUT5 #(
    .INIT(32'hAFC0A0C0)) 
     reset_time_out_i_2
       (.I0(txresetdone_s3),
        .I1(cplllock_sync),
        .I2(tx_state[1]),
        .I3(tx_state[2]),
        .I4(mmcm_lock_reclocked),
        .O(n_0_reset_time_out_i_2));
LUT6 #(
    .INIT(64'h505040FF505040FA)) 
     reset_time_out_i_3
       (.I0(tx_state[3]),
        .I1(cplllock_sync),
        .I2(tx_state[0]),
        .I3(tx_state[1]),
        .I4(tx_state[2]),
        .I5(n_0_init_wait_done_reg),
        .O(n_0_reset_time_out_i_3));
FDRE #(
    .INIT(1'b0)) 
     reset_time_out_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_reset_time_out_i_1),
        .Q(reset_time_out),
        .R(AR));
LUT5 #(
    .INIT(32'hFEFF0002)) 
     run_phase_alignment_int_i_1
       (.I0(tx_state[3]),
        .I1(tx_state[1]),
        .I2(tx_state[2]),
        .I3(tx_state[0]),
        .I4(n_0_run_phase_alignment_int_reg),
        .O(n_0_run_phase_alignment_int_i_1));
FDRE #(
    .INIT(1'b0)) 
     run_phase_alignment_int_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_run_phase_alignment_int_i_1),
        .Q(n_0_run_phase_alignment_int_reg),
        .R(AR));
FDRE #(
    .INIT(1'b0)) 
     run_phase_alignment_int_s3_reg
       (.C(I2),
        .CE(1'b1),
        .D(data_out),
        .Q(run_phase_alignment_int_s3),
        .R(1'b0));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gmii_to_sgmiigmii_to_sgmii_sync_block__parameterized0__22 sync_TXRESETDONE
       (.clk(independent_clock_bufg),
        .data_in(I1),
        .data_out(txresetdone_s2));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gmii_to_sgmiigmii_to_sgmii_sync_block__parameterized0__25 sync_cplllock
       (.clk(independent_clock_bufg),
        .data_in(I3),
        .data_out(cplllock_sync));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gmii_to_sgmiigmii_to_sgmii_sync_block__parameterized0__24 sync_mmcm_lock_reclocked
       (.clk(independent_clock_bufg),
        .data_in(mmcm_locked_out),
        .data_out(mmcm_lock_i));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gmii_to_sgmiigmii_to_sgmii_sync_block__parameterized0__20 sync_run_phase_alignment_int
       (.clk(I2),
        .data_in(n_0_run_phase_alignment_int_reg),
        .data_out(data_out));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gmii_to_sgmiigmii_to_sgmii_sync_block__parameterized0__23 sync_time_out_wait_bypass
       (.clk(independent_clock_bufg),
        .data_in(n_0_time_out_wait_bypass_reg),
        .data_out(time_out_wait_bypass_s2));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gmii_to_sgmiigmii_to_sgmii_sync_block__parameterized0__21 sync_tx_fsm_reset_done_int
       (.clk(I2),
        .data_in(gt0_txresetdone_out),
        .data_out(tx_fsm_reset_done_int_s2));
(* SOFT_HLUTNM = "soft_lutpair88" *) 
   LUT4 #(
    .INIT(16'h00AE)) 
     time_out_2ms_i_1__0
       (.I0(n_0_time_out_2ms_reg),
        .I1(n_0_time_out_2ms_i_2),
        .I2(\n_0_time_out_counter[0]_i_5 ),
        .I3(reset_time_out),
        .O(n_0_time_out_2ms_i_1__0));
LUT6 #(
    .INIT(64'h0000000000000800)) 
     time_out_2ms_i_2
       (.I0(time_out_counter_reg[17]),
        .I1(time_out_counter_reg[18]),
        .I2(time_out_counter_reg[10]),
        .I3(time_out_counter_reg[12]),
        .I4(time_out_counter_reg[5]),
        .I5(\n_0_time_out_counter[0]_i_3 ),
        .O(n_0_time_out_2ms_i_2));
FDRE #(
    .INIT(1'b0)) 
     time_out_2ms_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_time_out_2ms_i_1__0),
        .Q(n_0_time_out_2ms_reg),
        .R(1'b0));
LUT6 #(
    .INIT(64'h00000000AAAAAAAE)) 
     time_out_500us_i_1
       (.I0(n_0_time_out_500us_reg),
        .I1(n_0_time_out_500us_i_2),
        .I2(time_out_counter_reg[17]),
        .I3(time_out_counter_reg[18]),
        .I4(\n_0_time_out_counter[0]_i_5 ),
        .I5(reset_time_out),
        .O(n_0_time_out_500us_i_1));
LUT6 #(
    .INIT(64'h0040000000000000)) 
     time_out_500us_i_2
       (.I0(time_out_counter_reg[12]),
        .I1(time_out_counter_reg[10]),
        .I2(time_out_counter_reg[5]),
        .I3(time_out_counter_reg[11]),
        .I4(time_out_counter_reg[15]),
        .I5(time_out_counter_reg[16]),
        .O(n_0_time_out_500us_i_2));
FDRE #(
    .INIT(1'b0)) 
     time_out_500us_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_time_out_500us_i_1),
        .Q(n_0_time_out_500us_reg),
        .R(1'b0));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFBFFFF)) 
     \time_out_counter[0]_i_1 
       (.I0(\n_0_time_out_counter[0]_i_3 ),
        .I1(\n_0_time_out_counter[0]_i_4 ),
        .I2(\n_0_time_out_counter[0]_i_5 ),
        .I3(time_out_counter_reg[10]),
        .I4(time_out_counter_reg[12]),
        .I5(time_out_counter_reg[5]),
        .O(\n_0_time_out_counter[0]_i_1 ));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
     \time_out_counter[0]_i_10__0 
       (.I0(time_out_counter_reg[2]),
        .I1(time_out_counter_reg[1]),
        .I2(time_out_counter_reg[6]),
        .I3(time_out_counter_reg[8]),
        .I4(time_out_counter_reg[3]),
        .I5(time_out_counter_reg[4]),
        .O(\n_0_time_out_counter[0]_i_10__0 ));
LUT3 #(
    .INIT(8'hEF)) 
     \time_out_counter[0]_i_3 
       (.I0(time_out_counter_reg[16]),
        .I1(time_out_counter_reg[15]),
        .I2(time_out_counter_reg[11]),
        .O(\n_0_time_out_counter[0]_i_3 ));
LUT2 #(
    .INIT(4'h8)) 
     \time_out_counter[0]_i_4 
       (.I0(time_out_counter_reg[17]),
        .I1(time_out_counter_reg[18]),
        .O(\n_0_time_out_counter[0]_i_4 ));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFDFFFF)) 
     \time_out_counter[0]_i_5 
       (.I0(time_out_counter_reg[7]),
        .I1(time_out_counter_reg[14]),
        .I2(\n_0_time_out_counter[0]_i_10__0 ),
        .I3(time_out_counter_reg[13]),
        .I4(time_out_counter_reg[9]),
        .I5(time_out_counter_reg[0]),
        .O(\n_0_time_out_counter[0]_i_5 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[0]_i_6 
       (.I0(time_out_counter_reg[3]),
        .O(\n_0_time_out_counter[0]_i_6 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[0]_i_7 
       (.I0(time_out_counter_reg[2]),
        .O(\n_0_time_out_counter[0]_i_7 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[0]_i_8__0 
       (.I0(time_out_counter_reg[1]),
        .O(\n_0_time_out_counter[0]_i_8__0 ));
LUT1 #(
    .INIT(2'h1)) 
     \time_out_counter[0]_i_9 
       (.I0(time_out_counter_reg[0]),
        .O(\n_0_time_out_counter[0]_i_9 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_2 
       (.I0(time_out_counter_reg[15]),
        .O(\n_0_time_out_counter[12]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_3 
       (.I0(time_out_counter_reg[14]),
        .O(\n_0_time_out_counter[12]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_4 
       (.I0(time_out_counter_reg[13]),
        .O(\n_0_time_out_counter[12]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_5 
       (.I0(time_out_counter_reg[12]),
        .O(\n_0_time_out_counter[12]_i_5 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[16]_i_2 
       (.I0(time_out_counter_reg[18]),
        .O(\n_0_time_out_counter[16]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[16]_i_3 
       (.I0(time_out_counter_reg[17]),
        .O(\n_0_time_out_counter[16]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[16]_i_4 
       (.I0(time_out_counter_reg[16]),
        .O(\n_0_time_out_counter[16]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_2 
       (.I0(time_out_counter_reg[7]),
        .O(\n_0_time_out_counter[4]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_3 
       (.I0(time_out_counter_reg[6]),
        .O(\n_0_time_out_counter[4]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_4 
       (.I0(time_out_counter_reg[5]),
        .O(\n_0_time_out_counter[4]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_5 
       (.I0(time_out_counter_reg[4]),
        .O(\n_0_time_out_counter[4]_i_5 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_2 
       (.I0(time_out_counter_reg[11]),
        .O(\n_0_time_out_counter[8]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_3 
       (.I0(time_out_counter_reg[10]),
        .O(\n_0_time_out_counter[8]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_4 
       (.I0(time_out_counter_reg[9]),
        .O(\n_0_time_out_counter[8]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_5 
       (.I0(time_out_counter_reg[8]),
        .O(\n_0_time_out_counter[8]_i_5 ));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[0] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_7_time_out_counter_reg[0]_i_2 ),
        .Q(time_out_counter_reg[0]),
        .R(reset_time_out));
CARRY4 \time_out_counter_reg[0]_i_2 
       (.CI(1'b0),
        .CO({\n_0_time_out_counter_reg[0]_i_2 ,\n_1_time_out_counter_reg[0]_i_2 ,\n_2_time_out_counter_reg[0]_i_2 ,\n_3_time_out_counter_reg[0]_i_2 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\n_4_time_out_counter_reg[0]_i_2 ,\n_5_time_out_counter_reg[0]_i_2 ,\n_6_time_out_counter_reg[0]_i_2 ,\n_7_time_out_counter_reg[0]_i_2 }),
        .S({\n_0_time_out_counter[0]_i_6 ,\n_0_time_out_counter[0]_i_7 ,\n_0_time_out_counter[0]_i_8__0 ,\n_0_time_out_counter[0]_i_9 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[10] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_5_time_out_counter_reg[8]_i_1 ),
        .Q(time_out_counter_reg[10]),
        .R(reset_time_out));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[11] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_4_time_out_counter_reg[8]_i_1 ),
        .Q(time_out_counter_reg[11]),
        .R(reset_time_out));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[12] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_7_time_out_counter_reg[12]_i_1 ),
        .Q(time_out_counter_reg[12]),
        .R(reset_time_out));
CARRY4 \time_out_counter_reg[12]_i_1 
       (.CI(\n_0_time_out_counter_reg[8]_i_1 ),
        .CO({\n_0_time_out_counter_reg[12]_i_1 ,\n_1_time_out_counter_reg[12]_i_1 ,\n_2_time_out_counter_reg[12]_i_1 ,\n_3_time_out_counter_reg[12]_i_1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_time_out_counter_reg[12]_i_1 ,\n_5_time_out_counter_reg[12]_i_1 ,\n_6_time_out_counter_reg[12]_i_1 ,\n_7_time_out_counter_reg[12]_i_1 }),
        .S({\n_0_time_out_counter[12]_i_2 ,\n_0_time_out_counter[12]_i_3 ,\n_0_time_out_counter[12]_i_4 ,\n_0_time_out_counter[12]_i_5 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[13] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_6_time_out_counter_reg[12]_i_1 ),
        .Q(time_out_counter_reg[13]),
        .R(reset_time_out));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[14] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_5_time_out_counter_reg[12]_i_1 ),
        .Q(time_out_counter_reg[14]),
        .R(reset_time_out));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[15] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_4_time_out_counter_reg[12]_i_1 ),
        .Q(time_out_counter_reg[15]),
        .R(reset_time_out));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[16] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_7_time_out_counter_reg[16]_i_1 ),
        .Q(time_out_counter_reg[16]),
        .R(reset_time_out));
CARRY4 \time_out_counter_reg[16]_i_1 
       (.CI(\n_0_time_out_counter_reg[12]_i_1 ),
        .CO({\NLW_time_out_counter_reg[16]_i_1_CO_UNCONNECTED [3:2],\n_2_time_out_counter_reg[16]_i_1 ,\n_3_time_out_counter_reg[16]_i_1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_time_out_counter_reg[16]_i_1_O_UNCONNECTED [3],\n_5_time_out_counter_reg[16]_i_1 ,\n_6_time_out_counter_reg[16]_i_1 ,\n_7_time_out_counter_reg[16]_i_1 }),
        .S({1'b0,\n_0_time_out_counter[16]_i_2 ,\n_0_time_out_counter[16]_i_3 ,\n_0_time_out_counter[16]_i_4 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[17] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_6_time_out_counter_reg[16]_i_1 ),
        .Q(time_out_counter_reg[17]),
        .R(reset_time_out));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[18] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_5_time_out_counter_reg[16]_i_1 ),
        .Q(time_out_counter_reg[18]),
        .R(reset_time_out));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[1] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_6_time_out_counter_reg[0]_i_2 ),
        .Q(time_out_counter_reg[1]),
        .R(reset_time_out));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[2] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_5_time_out_counter_reg[0]_i_2 ),
        .Q(time_out_counter_reg[2]),
        .R(reset_time_out));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[3] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_4_time_out_counter_reg[0]_i_2 ),
        .Q(time_out_counter_reg[3]),
        .R(reset_time_out));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[4] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_7_time_out_counter_reg[4]_i_1 ),
        .Q(time_out_counter_reg[4]),
        .R(reset_time_out));
CARRY4 \time_out_counter_reg[4]_i_1 
       (.CI(\n_0_time_out_counter_reg[0]_i_2 ),
        .CO({\n_0_time_out_counter_reg[4]_i_1 ,\n_1_time_out_counter_reg[4]_i_1 ,\n_2_time_out_counter_reg[4]_i_1 ,\n_3_time_out_counter_reg[4]_i_1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_time_out_counter_reg[4]_i_1 ,\n_5_time_out_counter_reg[4]_i_1 ,\n_6_time_out_counter_reg[4]_i_1 ,\n_7_time_out_counter_reg[4]_i_1 }),
        .S({\n_0_time_out_counter[4]_i_2 ,\n_0_time_out_counter[4]_i_3 ,\n_0_time_out_counter[4]_i_4 ,\n_0_time_out_counter[4]_i_5 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[5] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_6_time_out_counter_reg[4]_i_1 ),
        .Q(time_out_counter_reg[5]),
        .R(reset_time_out));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[6] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_5_time_out_counter_reg[4]_i_1 ),
        .Q(time_out_counter_reg[6]),
        .R(reset_time_out));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[7] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_4_time_out_counter_reg[4]_i_1 ),
        .Q(time_out_counter_reg[7]),
        .R(reset_time_out));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[8] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_7_time_out_counter_reg[8]_i_1 ),
        .Q(time_out_counter_reg[8]),
        .R(reset_time_out));
CARRY4 \time_out_counter_reg[8]_i_1 
       (.CI(\n_0_time_out_counter_reg[4]_i_1 ),
        .CO({\n_0_time_out_counter_reg[8]_i_1 ,\n_1_time_out_counter_reg[8]_i_1 ,\n_2_time_out_counter_reg[8]_i_1 ,\n_3_time_out_counter_reg[8]_i_1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_time_out_counter_reg[8]_i_1 ,\n_5_time_out_counter_reg[8]_i_1 ,\n_6_time_out_counter_reg[8]_i_1 ,\n_7_time_out_counter_reg[8]_i_1 }),
        .S({\n_0_time_out_counter[8]_i_2 ,\n_0_time_out_counter[8]_i_3 ,\n_0_time_out_counter[8]_i_4 ,\n_0_time_out_counter[8]_i_5 }));
FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[9] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_6_time_out_counter_reg[8]_i_1 ),
        .Q(time_out_counter_reg[9]),
        .R(reset_time_out));
LUT6 #(
    .INIT(64'hFF00FF0100000000)) 
     time_out_wait_bypass_i_1
       (.I0(\n_0_wait_bypass_count[0]_i_4 ),
        .I1(\n_0_wait_bypass_count[0]_i_5 ),
        .I2(\n_0_wait_bypass_count[0]_i_6 ),
        .I3(n_0_time_out_wait_bypass_reg),
        .I4(tx_fsm_reset_done_int_s3),
        .I5(run_phase_alignment_int_s3),
        .O(n_0_time_out_wait_bypass_i_1));
FDRE #(
    .INIT(1'b0)) 
     time_out_wait_bypass_reg
       (.C(I2),
        .CE(1'b1),
        .D(n_0_time_out_wait_bypass_i_1),
        .Q(n_0_time_out_wait_bypass_reg),
        .R(1'b0));
FDRE #(
    .INIT(1'b0)) 
     time_out_wait_bypass_s3_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(time_out_wait_bypass_s2),
        .Q(time_out_wait_bypass_s3),
        .R(1'b0));
LUT6 #(
    .INIT(64'h00000000AAAAAAAE)) 
     time_tlock_max_i_1
       (.I0(n_0_time_tlock_max_reg),
        .I1(n_0_time_tlock_max_i_2),
        .I2(time_out_counter_reg[17]),
        .I3(time_out_counter_reg[18]),
        .I4(n_0_time_tlock_max_i_3),
        .I5(reset_time_out),
        .O(n_0_time_tlock_max_i_1));
LUT6 #(
    .INIT(64'h0000000000400000)) 
     time_tlock_max_i_2
       (.I0(time_out_counter_reg[12]),
        .I1(time_out_counter_reg[14]),
        .I2(time_out_counter_reg[10]),
        .I3(time_out_counter_reg[7]),
        .I4(time_out_counter_reg[5]),
        .I5(\n_0_time_out_counter[0]_i_3 ),
        .O(n_0_time_tlock_max_i_2));
LUT4 #(
    .INIT(16'hFFFB)) 
     time_tlock_max_i_3
       (.I0(time_out_counter_reg[0]),
        .I1(time_out_counter_reg[9]),
        .I2(time_out_counter_reg[13]),
        .I3(\n_0_time_out_counter[0]_i_10__0 ),
        .O(n_0_time_tlock_max_i_3));
FDRE #(
    .INIT(1'b0)) 
     time_tlock_max_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_time_tlock_max_i_1),
        .Q(n_0_time_tlock_max_reg),
        .R(1'b0));
LUT5 #(
    .INIT(32'hFFFF0200)) 
     tx_fsm_reset_done_int_i_1
       (.I0(tx_state[3]),
        .I1(tx_state[1]),
        .I2(tx_state[2]),
        .I3(tx_state[0]),
        .I4(gt0_txresetdone_out),
        .O(n_0_tx_fsm_reset_done_int_i_1));
FDRE #(
    .INIT(1'b0)) 
     tx_fsm_reset_done_int_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_tx_fsm_reset_done_int_i_1),
        .Q(gt0_txresetdone_out),
        .R(AR));
FDRE #(
    .INIT(1'b0)) 
     tx_fsm_reset_done_int_s3_reg
       (.C(I2),
        .CE(1'b1),
        .D(tx_fsm_reset_done_int_s2),
        .Q(tx_fsm_reset_done_int_s3),
        .R(1'b0));
FDRE #(
    .INIT(1'b0)) 
     txresetdone_s3_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(txresetdone_s2),
        .Q(txresetdone_s3),
        .R(1'b0));
LUT1 #(
    .INIT(2'h1)) 
     \wait_bypass_count[0]_i_1 
       (.I0(run_phase_alignment_int_s3),
        .O(\n_0_wait_bypass_count[0]_i_1 ));
LUT1 #(
    .INIT(2'h1)) 
     \wait_bypass_count[0]_i_10 
       (.I0(wait_bypass_count_reg[0]),
        .O(\n_0_wait_bypass_count[0]_i_10 ));
LUT4 #(
    .INIT(16'h00FE)) 
     \wait_bypass_count[0]_i_2 
       (.I0(\n_0_wait_bypass_count[0]_i_4 ),
        .I1(\n_0_wait_bypass_count[0]_i_5 ),
        .I2(\n_0_wait_bypass_count[0]_i_6 ),
        .I3(tx_fsm_reset_done_int_s3),
        .O(\n_0_wait_bypass_count[0]_i_2 ));
LUT5 #(
    .INIT(32'hBFFFFFFF)) 
     \wait_bypass_count[0]_i_4 
       (.I0(wait_bypass_count_reg[15]),
        .I1(wait_bypass_count_reg[1]),
        .I2(wait_bypass_count_reg[2]),
        .I3(wait_bypass_count_reg[16]),
        .I4(wait_bypass_count_reg[0]),
        .O(\n_0_wait_bypass_count[0]_i_4 ));
LUT6 #(
    .INIT(64'hFFFFFDFFFFFFFFFF)) 
     \wait_bypass_count[0]_i_5 
       (.I0(wait_bypass_count_reg[9]),
        .I1(wait_bypass_count_reg[10]),
        .I2(wait_bypass_count_reg[13]),
        .I3(wait_bypass_count_reg[14]),
        .I4(wait_bypass_count_reg[11]),
        .I5(wait_bypass_count_reg[12]),
        .O(\n_0_wait_bypass_count[0]_i_5 ));
LUT6 #(
    .INIT(64'hF7FFFFFFFFFFFFFF)) 
     \wait_bypass_count[0]_i_6 
       (.I0(wait_bypass_count_reg[4]),
        .I1(wait_bypass_count_reg[3]),
        .I2(wait_bypass_count_reg[8]),
        .I3(wait_bypass_count_reg[7]),
        .I4(wait_bypass_count_reg[5]),
        .I5(wait_bypass_count_reg[6]),
        .O(\n_0_wait_bypass_count[0]_i_6 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[0]_i_7 
       (.I0(wait_bypass_count_reg[3]),
        .O(\n_0_wait_bypass_count[0]_i_7 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[0]_i_8 
       (.I0(wait_bypass_count_reg[2]),
        .O(\n_0_wait_bypass_count[0]_i_8 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[0]_i_9__0 
       (.I0(wait_bypass_count_reg[1]),
        .O(\n_0_wait_bypass_count[0]_i_9__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[12]_i_2 
       (.I0(wait_bypass_count_reg[15]),
        .O(\n_0_wait_bypass_count[12]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[12]_i_3 
       (.I0(wait_bypass_count_reg[14]),
        .O(\n_0_wait_bypass_count[12]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[12]_i_4 
       (.I0(wait_bypass_count_reg[13]),
        .O(\n_0_wait_bypass_count[12]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[12]_i_5 
       (.I0(wait_bypass_count_reg[12]),
        .O(\n_0_wait_bypass_count[12]_i_5 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[16]_i_2 
       (.I0(wait_bypass_count_reg[16]),
        .O(\n_0_wait_bypass_count[16]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_2 
       (.I0(wait_bypass_count_reg[7]),
        .O(\n_0_wait_bypass_count[4]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_3 
       (.I0(wait_bypass_count_reg[6]),
        .O(\n_0_wait_bypass_count[4]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_4 
       (.I0(wait_bypass_count_reg[5]),
        .O(\n_0_wait_bypass_count[4]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_5 
       (.I0(wait_bypass_count_reg[4]),
        .O(\n_0_wait_bypass_count[4]_i_5 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_2 
       (.I0(wait_bypass_count_reg[11]),
        .O(\n_0_wait_bypass_count[8]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_3 
       (.I0(wait_bypass_count_reg[10]),
        .O(\n_0_wait_bypass_count[8]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_4 
       (.I0(wait_bypass_count_reg[9]),
        .O(\n_0_wait_bypass_count[8]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_5 
       (.I0(wait_bypass_count_reg[8]),
        .O(\n_0_wait_bypass_count[8]_i_5 ));
FDRE \wait_bypass_count_reg[0] 
       (.C(I2),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_7_wait_bypass_count_reg[0]_i_3 ),
        .Q(wait_bypass_count_reg[0]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
CARRY4 \wait_bypass_count_reg[0]_i_3 
       (.CI(1'b0),
        .CO({\n_0_wait_bypass_count_reg[0]_i_3 ,\n_1_wait_bypass_count_reg[0]_i_3 ,\n_2_wait_bypass_count_reg[0]_i_3 ,\n_3_wait_bypass_count_reg[0]_i_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\n_4_wait_bypass_count_reg[0]_i_3 ,\n_5_wait_bypass_count_reg[0]_i_3 ,\n_6_wait_bypass_count_reg[0]_i_3 ,\n_7_wait_bypass_count_reg[0]_i_3 }),
        .S({\n_0_wait_bypass_count[0]_i_7 ,\n_0_wait_bypass_count[0]_i_8 ,\n_0_wait_bypass_count[0]_i_9__0 ,\n_0_wait_bypass_count[0]_i_10 }));
FDRE \wait_bypass_count_reg[10] 
       (.C(I2),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_5_wait_bypass_count_reg[8]_i_1 ),
        .Q(wait_bypass_count_reg[10]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
FDRE \wait_bypass_count_reg[11] 
       (.C(I2),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_4_wait_bypass_count_reg[8]_i_1 ),
        .Q(wait_bypass_count_reg[11]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
FDRE \wait_bypass_count_reg[12] 
       (.C(I2),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_7_wait_bypass_count_reg[12]_i_1 ),
        .Q(wait_bypass_count_reg[12]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
CARRY4 \wait_bypass_count_reg[12]_i_1 
       (.CI(\n_0_wait_bypass_count_reg[8]_i_1 ),
        .CO({\n_0_wait_bypass_count_reg[12]_i_1 ,\n_1_wait_bypass_count_reg[12]_i_1 ,\n_2_wait_bypass_count_reg[12]_i_1 ,\n_3_wait_bypass_count_reg[12]_i_1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_wait_bypass_count_reg[12]_i_1 ,\n_5_wait_bypass_count_reg[12]_i_1 ,\n_6_wait_bypass_count_reg[12]_i_1 ,\n_7_wait_bypass_count_reg[12]_i_1 }),
        .S({\n_0_wait_bypass_count[12]_i_2 ,\n_0_wait_bypass_count[12]_i_3 ,\n_0_wait_bypass_count[12]_i_4 ,\n_0_wait_bypass_count[12]_i_5 }));
FDRE \wait_bypass_count_reg[13] 
       (.C(I2),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_6_wait_bypass_count_reg[12]_i_1 ),
        .Q(wait_bypass_count_reg[13]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
FDRE \wait_bypass_count_reg[14] 
       (.C(I2),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_5_wait_bypass_count_reg[12]_i_1 ),
        .Q(wait_bypass_count_reg[14]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
FDRE \wait_bypass_count_reg[15] 
       (.C(I2),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_4_wait_bypass_count_reg[12]_i_1 ),
        .Q(wait_bypass_count_reg[15]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
FDRE \wait_bypass_count_reg[16] 
       (.C(I2),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_7_wait_bypass_count_reg[16]_i_1 ),
        .Q(wait_bypass_count_reg[16]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
CARRY4 \wait_bypass_count_reg[16]_i_1 
       (.CI(\n_0_wait_bypass_count_reg[12]_i_1 ),
        .CO(\NLW_wait_bypass_count_reg[16]_i_1_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_wait_bypass_count_reg[16]_i_1_O_UNCONNECTED [3:1],\n_7_wait_bypass_count_reg[16]_i_1 }),
        .S({1'b0,1'b0,1'b0,\n_0_wait_bypass_count[16]_i_2 }));
FDRE \wait_bypass_count_reg[1] 
       (.C(I2),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_6_wait_bypass_count_reg[0]_i_3 ),
        .Q(wait_bypass_count_reg[1]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
FDRE \wait_bypass_count_reg[2] 
       (.C(I2),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_5_wait_bypass_count_reg[0]_i_3 ),
        .Q(wait_bypass_count_reg[2]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
FDRE \wait_bypass_count_reg[3] 
       (.C(I2),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_4_wait_bypass_count_reg[0]_i_3 ),
        .Q(wait_bypass_count_reg[3]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
FDRE \wait_bypass_count_reg[4] 
       (.C(I2),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_7_wait_bypass_count_reg[4]_i_1 ),
        .Q(wait_bypass_count_reg[4]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
CARRY4 \wait_bypass_count_reg[4]_i_1 
       (.CI(\n_0_wait_bypass_count_reg[0]_i_3 ),
        .CO({\n_0_wait_bypass_count_reg[4]_i_1 ,\n_1_wait_bypass_count_reg[4]_i_1 ,\n_2_wait_bypass_count_reg[4]_i_1 ,\n_3_wait_bypass_count_reg[4]_i_1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_wait_bypass_count_reg[4]_i_1 ,\n_5_wait_bypass_count_reg[4]_i_1 ,\n_6_wait_bypass_count_reg[4]_i_1 ,\n_7_wait_bypass_count_reg[4]_i_1 }),
        .S({\n_0_wait_bypass_count[4]_i_2 ,\n_0_wait_bypass_count[4]_i_3 ,\n_0_wait_bypass_count[4]_i_4 ,\n_0_wait_bypass_count[4]_i_5 }));
FDRE \wait_bypass_count_reg[5] 
       (.C(I2),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_6_wait_bypass_count_reg[4]_i_1 ),
        .Q(wait_bypass_count_reg[5]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
FDRE \wait_bypass_count_reg[6] 
       (.C(I2),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_5_wait_bypass_count_reg[4]_i_1 ),
        .Q(wait_bypass_count_reg[6]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
FDRE \wait_bypass_count_reg[7] 
       (.C(I2),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_4_wait_bypass_count_reg[4]_i_1 ),
        .Q(wait_bypass_count_reg[7]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
FDRE \wait_bypass_count_reg[8] 
       (.C(I2),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_7_wait_bypass_count_reg[8]_i_1 ),
        .Q(wait_bypass_count_reg[8]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
CARRY4 \wait_bypass_count_reg[8]_i_1 
       (.CI(\n_0_wait_bypass_count_reg[4]_i_1 ),
        .CO({\n_0_wait_bypass_count_reg[8]_i_1 ,\n_1_wait_bypass_count_reg[8]_i_1 ,\n_2_wait_bypass_count_reg[8]_i_1 ,\n_3_wait_bypass_count_reg[8]_i_1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_wait_bypass_count_reg[8]_i_1 ,\n_5_wait_bypass_count_reg[8]_i_1 ,\n_6_wait_bypass_count_reg[8]_i_1 ,\n_7_wait_bypass_count_reg[8]_i_1 }),
        .S({\n_0_wait_bypass_count[8]_i_2 ,\n_0_wait_bypass_count[8]_i_3 ,\n_0_wait_bypass_count[8]_i_4 ,\n_0_wait_bypass_count[8]_i_5 }));
FDRE \wait_bypass_count_reg[9] 
       (.C(I2),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_6_wait_bypass_count_reg[8]_i_1 ),
        .Q(wait_bypass_count_reg[9]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair92" *) 
   LUT1 #(
    .INIT(2'h1)) 
     \wait_time_cnt[0]_i_1 
       (.I0(wait_time_cnt_reg__0[0]),
        .O(wait_time_cnt0[0]));
(* SOFT_HLUTNM = "soft_lutpair92" *) 
   LUT2 #(
    .INIT(4'h9)) 
     \wait_time_cnt[1]_i_1 
       (.I0(wait_time_cnt_reg__0[1]),
        .I1(wait_time_cnt_reg__0[0]),
        .O(wait_time_cnt0[1]));
LUT3 #(
    .INIT(8'hA9)) 
     \wait_time_cnt[2]_i_1 
       (.I0(wait_time_cnt_reg__0[2]),
        .I1(wait_time_cnt_reg__0[0]),
        .I2(wait_time_cnt_reg__0[1]),
        .O(wait_time_cnt0[2]));
(* SOFT_HLUTNM = "soft_lutpair85" *) 
   LUT4 #(
    .INIT(16'hAAA9)) 
     \wait_time_cnt[3]_i_1 
       (.I0(wait_time_cnt_reg__0[3]),
        .I1(wait_time_cnt_reg__0[1]),
        .I2(wait_time_cnt_reg__0[0]),
        .I3(wait_time_cnt_reg__0[2]),
        .O(wait_time_cnt0[3]));
(* SOFT_HLUTNM = "soft_lutpair85" *) 
   LUT5 #(
    .INIT(32'hAAAAAAA9)) 
     \wait_time_cnt[4]_i_1 
       (.I0(wait_time_cnt_reg__0[4]),
        .I1(wait_time_cnt_reg__0[2]),
        .I2(wait_time_cnt_reg__0[0]),
        .I3(wait_time_cnt_reg__0[1]),
        .I4(wait_time_cnt_reg__0[3]),
        .O(wait_time_cnt0[4]));
LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA9)) 
     \wait_time_cnt[5]_i_1 
       (.I0(wait_time_cnt_reg__0[5]),
        .I1(wait_time_cnt_reg__0[3]),
        .I2(wait_time_cnt_reg__0[1]),
        .I3(wait_time_cnt_reg__0[0]),
        .I4(wait_time_cnt_reg__0[2]),
        .I5(wait_time_cnt_reg__0[4]),
        .O(wait_time_cnt0[5]));
LUT4 #(
    .INIT(16'h020A)) 
     \wait_time_cnt[6]_i_1 
       (.I0(tx_state[0]),
        .I1(tx_state[2]),
        .I2(tx_state[3]),
        .I3(tx_state[1]),
        .O(clear));
LUT2 #(
    .INIT(4'hE)) 
     \wait_time_cnt[6]_i_2 
       (.I0(\n_0_wait_time_cnt[6]_i_4 ),
        .I1(wait_time_cnt_reg__0[6]),
        .O(sel));
LUT2 #(
    .INIT(4'h9)) 
     \wait_time_cnt[6]_i_3 
       (.I0(wait_time_cnt_reg__0[6]),
        .I1(\n_0_wait_time_cnt[6]_i_4 ),
        .O(wait_time_cnt0[6]));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
     \wait_time_cnt[6]_i_4 
       (.I0(wait_time_cnt_reg__0[4]),
        .I1(wait_time_cnt_reg__0[2]),
        .I2(wait_time_cnt_reg__0[0]),
        .I3(wait_time_cnt_reg__0[1]),
        .I4(wait_time_cnt_reg__0[3]),
        .I5(wait_time_cnt_reg__0[5]),
        .O(\n_0_wait_time_cnt[6]_i_4 ));
FDRE \wait_time_cnt_reg[0] 
       (.C(independent_clock_bufg),
        .CE(sel),
        .D(wait_time_cnt0[0]),
        .Q(wait_time_cnt_reg__0[0]),
        .R(clear));
FDRE \wait_time_cnt_reg[1] 
       (.C(independent_clock_bufg),
        .CE(sel),
        .D(wait_time_cnt0[1]),
        .Q(wait_time_cnt_reg__0[1]),
        .R(clear));
FDSE \wait_time_cnt_reg[2] 
       (.C(independent_clock_bufg),
        .CE(sel),
        .D(wait_time_cnt0[2]),
        .Q(wait_time_cnt_reg__0[2]),
        .S(clear));
FDRE \wait_time_cnt_reg[3] 
       (.C(independent_clock_bufg),
        .CE(sel),
        .D(wait_time_cnt0[3]),
        .Q(wait_time_cnt_reg__0[3]),
        .R(clear));
FDRE \wait_time_cnt_reg[4] 
       (.C(independent_clock_bufg),
        .CE(sel),
        .D(wait_time_cnt0[4]),
        .Q(wait_time_cnt_reg__0[4]),
        .R(clear));
FDSE \wait_time_cnt_reg[5] 
       (.C(independent_clock_bufg),
        .CE(sel),
        .D(wait_time_cnt0[5]),
        .Q(wait_time_cnt_reg__0[5]),
        .S(clear));
FDSE \wait_time_cnt_reg[6] 
       (.C(independent_clock_bufg),
        .CE(sel),
        .D(wait_time_cnt0[6]),
        .Q(wait_time_cnt_reg__0[6]),
        .S(clear));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_block" *) 
module gmii_to_sgmiigmii_to_sgmii_block
   (O1,
    txn,
    txp,
    txoutclk,
    resetdone,
    sgmii_clk_r,
    O2,
    gmii_rx_dv,
    gmii_rx_er,
    status_vector,
    sgmii_clk_f,
    an_interrupt,
    Q,
    gmii_rxd,
    CLK,
    speed_is_10_100,
    speed_is_100,
    I1,
    independent_clock_bufg,
    rxn,
    rxp,
    gtrefclk_out,
    gt0_qplloutclk_out,
    gt0_qplloutrefclk_out,
    mmcm_locked_out,
    AS,
    gmii_tx_er,
    gmii_tx_en,
    an_restart_config,
    AR,
    an_adv_config_vector,
    signal_detect,
    configuration_vector,
    gmii_txd);
  output O1;
  output txn;
  output txp;
  output txoutclk;
  output resetdone;
  output sgmii_clk_r;
  output O2;
  output gmii_rx_dv;
  output gmii_rx_er;
  output [12:0]status_vector;
  output sgmii_clk_f;
  output an_interrupt;
  output [0:0]Q;
  output [7:0]gmii_rxd;
  input CLK;
  input speed_is_10_100;
  input speed_is_100;
  input I1;
  input independent_clock_bufg;
  input rxn;
  input rxp;
  input gtrefclk_out;
  input gt0_qplloutclk_out;
  input gt0_qplloutrefclk_out;
  input mmcm_locked_out;
  input [0:0]AS;
  input gmii_tx_er;
  input gmii_tx_en;
  input an_restart_config;
  input [0:0]AR;
  input [0:0]an_adv_config_vector;
  input signal_detect;
  input [4:0]configuration_vector;
  input [7:0]gmii_txd;

  wire [0:0]AR;
  wire [0:0]AS;
  wire CLK;
  wire I1;
  wire I_0;
  wire O1;
  wire O2;
  wire [0:0]Q;
  wire RX_ER;
  wire [0:0]an_adv_config_vector;
  wire an_interrupt;
  wire an_restart_config;
  wire [4:0]configuration_vector;
  wire data_out;
  wire encommaalign;
  wire gmii_rx_dv;
  wire gmii_rx_er;
  wire [7:0]gmii_rxd;
  wire gmii_tx_en;
  wire gmii_tx_er;
  wire [7:0]gmii_txd;
  wire [7:0]gmii_txd_out;
  wire gt0_qplloutclk_out;
  wire gt0_qplloutrefclk_out;
  wire gtrefclk_out;
  wire independent_clock_bufg;
  wire mgt_tx_reset;
  wire mmcm_locked_out;
  wire n_0_rxrecclkbufmr;
  wire n_16_gmii_to_sgmii_core;
  wire n_17_gmii_to_sgmii_core;
  wire n_18_gmii_to_sgmii_core;
  wire n_18_sgmii_logic;
  wire n_19_gmii_to_sgmii_core;
  wire n_19_transceiver_inst;
  wire n_22_gmii_to_sgmii_core;
  wire n_25_gmii_to_sgmii_core;
  wire n_26_gmii_to_sgmii_core;
  wire n_27_gmii_to_sgmii_core;
  wire n_28_gmii_to_sgmii_core;
  wire n_29_gmii_to_sgmii_core;
  wire n_30_gmii_to_sgmii_core;
  wire n_31_gmii_to_sgmii_core;
  wire n_32_gmii_to_sgmii_core;
  wire n_33_gmii_to_sgmii_core;
  wire n_34_gmii_to_sgmii_core;
  wire n_35_gmii_to_sgmii_core;
  wire n_36_gmii_to_sgmii_core;
  wire n_37_gmii_to_sgmii_core;
  wire n_38_gmii_to_sgmii_core;
  wire n_39_gmii_to_sgmii_core;
  wire n_40_gmii_to_sgmii_core;
  wire n_41_gmii_to_sgmii_core;
  wire n_42_gmii_to_sgmii_core;
  wire n_5_sgmii_logic;
  wire n_6_sgmii_logic;
  wire powerdown;
  wire [3:2]\receiver/p_0_in ;
  wire \receiver/rx_dv_reg1 ;
  wire resetdone;
  wire rxbuferr;
  wire rxchariscomma;
  wire rxcharisk;
  wire [0:0]rxclkcorcnt;
  wire [7:0]rxdata_usr;
  wire rxdisperr_usr;
  wire rxn;
  wire rxnotintable_usr;
  wire rxp;
  wire rxreset;
  wire sgmii_clk_f;
  wire sgmii_clk_r;
  wire signal_detect;
  wire speed_is_100;
  wire speed_is_10_100;
  wire [12:0]status_vector;
  wire txbuferr;
  wire txn;
  wire txoutclk;
  wire txp;

gmii_to_sgmiigig_ethernet_pcs_pma_v14_2__parameterized0 gmii_to_sgmii_core
       (.AS(AS),
        .CLK(CLK),
        .D(n_16_gmii_to_sgmii_core),
        .I1(n_5_sgmii_logic),
        .I2(n_6_sgmii_logic),
        .I3(\receiver/p_0_in ),
        .I4(n_18_sgmii_logic),
        .I5(rxdata_usr),
        .I6(gmii_txd_out),
        .I7({n_19_transceiver_inst,rxclkcorcnt}),
        .O1(n_17_gmii_to_sgmii_core),
        .O2(n_18_gmii_to_sgmii_core),
        .O3(n_19_gmii_to_sgmii_core),
        .O4(n_22_gmii_to_sgmii_core),
        .O5(n_25_gmii_to_sgmii_core),
        .O6({n_26_gmii_to_sgmii_core,n_27_gmii_to_sgmii_core,n_28_gmii_to_sgmii_core,n_29_gmii_to_sgmii_core,n_30_gmii_to_sgmii_core,n_31_gmii_to_sgmii_core,n_32_gmii_to_sgmii_core,n_33_gmii_to_sgmii_core}),
        .O7(n_34_gmii_to_sgmii_core),
        .O8({n_35_gmii_to_sgmii_core,n_36_gmii_to_sgmii_core,n_37_gmii_to_sgmii_core,n_38_gmii_to_sgmii_core,n_39_gmii_to_sgmii_core,n_40_gmii_to_sgmii_core,n_41_gmii_to_sgmii_core,n_42_gmii_to_sgmii_core}),
        .Q({Q,powerdown}),
        .RX_ER(RX_ER),
        .an_adv_config_vector(an_adv_config_vector),
        .an_interrupt(an_interrupt),
        .an_restart_config(an_restart_config),
        .configuration_vector(configuration_vector),
        .data_out(data_out),
        .encommaalign(encommaalign),
        .mgt_tx_reset(mgt_tx_reset),
        .rx_dv_reg1(\receiver/rx_dv_reg1 ),
        .rxbuferr(rxbuferr),
        .rxchariscomma(rxchariscomma),
        .rxcharisk(rxcharisk),
        .rxdisperr_usr(rxdisperr_usr),
        .rxnotintable_usr(rxnotintable_usr),
        .rxreset(rxreset),
        .signal_detect(signal_detect),
        .status_vector(status_vector),
        .txbuferr(txbuferr));
(* box_type = "PRIMITIVE" *) 
   BUFMR rxrecclkbufmr
       (.I(I_0),
        .O(n_0_rxrecclkbufmr));
(* box_type = "PRIMITIVE" *) 
   BUFR #(
    .BUFR_DIVIDE("BYPASS"),
    .SIM_DEVICE("7SERIES")) 
     rxrecclkbufr
       (.CE(1'b1),
        .CLR(1'b0),
        .I(n_0_rxrecclkbufmr),
        .O(O1));
gmii_to_sgmiigmii_to_sgmii_sgmii_adapt sgmii_logic
       (.CLK(CLK),
        .D({n_26_gmii_to_sgmii_core,n_27_gmii_to_sgmii_core,n_28_gmii_to_sgmii_core,n_29_gmii_to_sgmii_core,n_30_gmii_to_sgmii_core,n_31_gmii_to_sgmii_core,n_32_gmii_to_sgmii_core,n_33_gmii_to_sgmii_core}),
        .I1(n_19_gmii_to_sgmii_core),
        .I2(n_25_gmii_to_sgmii_core),
        .I3(n_34_gmii_to_sgmii_core),
        .I4(n_18_gmii_to_sgmii_core),
        .O1(O2),
        .O2(n_5_sgmii_logic),
        .O3(n_6_sgmii_logic),
        .O4(gmii_txd_out),
        .O5(n_18_sgmii_logic),
        .Q(\receiver/p_0_in ),
        .RX_ER(RX_ER),
        .SR(mgt_tx_reset),
        .gmii_rx_dv(gmii_rx_dv),
        .gmii_rx_er(gmii_rx_er),
        .gmii_rxd(gmii_rxd),
        .gmii_tx_en(gmii_tx_en),
        .gmii_tx_er(gmii_tx_er),
        .gmii_txd(gmii_txd),
        .rx_dv_reg1(\receiver/rx_dv_reg1 ),
        .sgmii_clk_f(sgmii_clk_f),
        .sgmii_clk_r(sgmii_clk_r),
        .speed_is_100(speed_is_100),
        .speed_is_10_100(speed_is_10_100));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gmii_to_sgmiigmii_to_sgmii_sync_block__parameterized0 sync_block_reset_done
       (.clk(CLK),
        .data_in(resetdone),
        .data_out(data_out));
gmii_to_sgmiigmii_to_sgmii_transceiver__parameterized0 transceiver_inst
       (.AR(AR),
        .CLK(CLK),
        .D(n_16_gmii_to_sgmii_core),
        .I1(O1),
        .I2(I1),
        .I3(n_22_gmii_to_sgmii_core),
        .I4(n_17_gmii_to_sgmii_core),
        .I5({n_35_gmii_to_sgmii_core,n_36_gmii_to_sgmii_core,n_37_gmii_to_sgmii_core,n_38_gmii_to_sgmii_core,n_39_gmii_to_sgmii_core,n_40_gmii_to_sgmii_core,n_41_gmii_to_sgmii_core,n_42_gmii_to_sgmii_core}),
        .I7({n_19_transceiver_inst,rxclkcorcnt}),
        .I_0(I_0),
        .O1(rxdata_usr),
        .Q(powerdown),
        .SR(mgt_tx_reset),
        .encommaalign(encommaalign),
        .gt0_qplloutclk_out(gt0_qplloutclk_out),
        .gt0_qplloutrefclk_out(gt0_qplloutrefclk_out),
        .gtrefclk_out(gtrefclk_out),
        .independent_clock_bufg(independent_clock_bufg),
        .mmcm_locked_out(mmcm_locked_out),
        .resetdone(resetdone),
        .rxbuferr(rxbuferr),
        .rxchariscomma(rxchariscomma),
        .rxcharisk(rxcharisk),
        .rxdisperr_usr(rxdisperr_usr),
        .rxn(rxn),
        .rxnotintable_usr(rxnotintable_usr),
        .rxp(rxp),
        .rxreset(rxreset),
        .status_vector(status_vector[1]),
        .txbuferr(txbuferr),
        .txn(txn),
        .txoutclk(txoutclk),
        .txp(txp));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_clk_gen" *) 
module gmii_to_sgmiigmii_to_sgmii_clk_gen
   (sgmii_clk_r,
    O1,
    sgmii_clk_f,
    I1,
    CLK,
    I2,
    I3);
  output sgmii_clk_r;
  output O1;
  output sgmii_clk_f;
  input I1;
  input CLK;
  input I2;
  input I3;

  wire CLK;
  wire I1;
  wire I2;
  wire I3;
  wire O1;
  wire clk12_5_reg;
  wire clk1_25_reg;
  wire clk_div10;
  wire clk_en;
  wire clk_en_12_5_fall;
  wire clk_en_1_25_fall;
  wire n_0_clk_div_stage2;
  wire n_0_sgmii_clk_en_i_1;
  wire n_1_clk_div_stage1;
  wire n_1_clk_div_stage2;
  wire n_2_clk_div_stage1;
  wire n_3_clk_div_stage1;
  wire reset_fall;
  wire sgmii_clk_f;
  wire sgmii_clk_r;
  wire sgmii_clk_r0_out;
  wire speed_is_100_fall;
  wire speed_is_10_100_fall;

FDRE clk12_5_reg_reg
       (.C(CLK),
        .CE(1'b1),
        .D(clk_div10),
        .Q(clk12_5_reg),
        .R(I3));
FDRE clk1_25_reg_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_clk_div_stage2),
        .Q(clk1_25_reg),
        .R(I3));
gmii_to_sgmiigmii_to_sgmii_johnson_cntr clk_div_stage1
       (.CLK(CLK),
        .I1(n_0_clk_div_stage2),
        .I3(I3),
        .O1(n_1_clk_div_stage1),
        .O2(n_2_clk_div_stage1),
        .O3(n_3_clk_div_stage1),
        .clk12_5_reg(clk12_5_reg),
        .clk_div10(clk_div10),
        .reset_fall(reset_fall),
        .speed_is_100_fall(speed_is_100_fall),
        .speed_is_10_100_fall(speed_is_10_100_fall));
gmii_to_sgmiigmii_to_sgmii_johnson_cntr_0 clk_div_stage2
       (.CLK(CLK),
        .I1(I1),
        .I2(I2),
        .I3(I3),
        .O1(n_0_clk_div_stage2),
        .O2(n_1_clk_div_stage2),
        .clk1_25_reg(clk1_25_reg),
        .clk_div10(clk_div10),
        .clk_en(clk_en),
        .sgmii_clk_r0_out(sgmii_clk_r0_out));
FDRE clk_en_12_5_fall_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_1_clk_div_stage1),
        .Q(clk_en_12_5_fall),
        .R(I3));
FDRE clk_en_12_5_rise_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_2_clk_div_stage1),
        .Q(clk_en),
        .R(I3));
FDRE clk_en_1_25_fall_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_1_clk_div_stage2),
        .Q(clk_en_1_25_fall),
        .R(I3));
FDRE #(
    .IS_C_INVERTED(1'b1)) 
     reset_fall_reg
       (.C(CLK),
        .CE(1'b1),
        .D(I3),
        .Q(reset_fall),
        .R(1'b0));
LUT4 #(
    .INIT(16'hE2FF)) 
     sgmii_clk_en_i_1
       (.I0(clk_en_1_25_fall),
        .I1(I1),
        .I2(clk_en_12_5_fall),
        .I3(I2),
        .O(n_0_sgmii_clk_en_i_1));
FDRE sgmii_clk_en_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_sgmii_clk_en_i_1),
        .Q(O1),
        .R(I3));
FDRE #(
    .IS_C_INVERTED(1'b1)) 
     sgmii_clk_f_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_3_clk_div_stage1),
        .Q(sgmii_clk_f),
        .R(1'b0));
FDRE sgmii_clk_r_reg
       (.C(CLK),
        .CE(1'b1),
        .D(sgmii_clk_r0_out),
        .Q(sgmii_clk_r),
        .R(I3));
FDRE #(
    .IS_C_INVERTED(1'b1)) 
     speed_is_100_fall_reg
       (.C(CLK),
        .CE(1'b1),
        .D(I1),
        .Q(speed_is_100_fall),
        .R(1'b0));
FDRE #(
    .IS_C_INVERTED(1'b1)) 
     speed_is_10_100_fall_reg
       (.C(CLK),
        .CE(1'b1),
        .D(I2),
        .Q(speed_is_10_100_fall),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_clocking" *) 
module gmii_to_sgmiigmii_to_sgmii_clocking
   (AS,
    mmcm_locked,
    gtrefclk_out,
    userclk,
    userclk2,
    reset,
    gtrefclk_p,
    gtrefclk_n,
    txoutclk);
  output [0:0]AS;
  output mmcm_locked;
  output gtrefclk_out;
  output userclk;
  output userclk2;
  input reset;
  input gtrefclk_p;
  input gtrefclk_n;
  input txoutclk;

  wire [0:0]AS;
  wire clkfbout;
  wire clkout0;
  wire clkout1;
  wire gtrefclk_n;
  wire gtrefclk_out;
  wire gtrefclk_p;
  wire mmcm_locked;
  wire reset;
  wire txoutclk;
  wire txoutclk_bufg;
  wire userclk;
  wire userclk2;
  wire NLW_ibufds_gtrefclk_ODIV2_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKFBOUTB_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKFBSTOPPED_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKINSTOPPED_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT0B_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT1B_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT2_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT2B_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT3_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT3B_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT4_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT5_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT6_UNCONNECTED;
  wire NLW_mmcm_adv_inst_DRDY_UNCONNECTED;
  wire NLW_mmcm_adv_inst_PSDONE_UNCONNECTED;
  wire [15:0]NLW_mmcm_adv_inst_DO_UNCONNECTED;

(* box_type = "PRIMITIVE" *) 
   BUFG bufg_txoutclk
       (.I(txoutclk),
        .O(txoutclk_bufg));
(* box_type = "PRIMITIVE" *) 
   BUFG bufg_userclk
       (.I(clkout1),
        .O(userclk));
(* box_type = "PRIMITIVE" *) 
   BUFG bufg_userclk2
       (.I(clkout0),
        .O(userclk2));
(* box_type = "PRIMITIVE" *) 
   IBUFDS_GTE2 #(
    .CLKCM_CFG("TRUE"),
    .CLKRCV_TRST("TRUE"),
    .CLKSWING_CFG(2'b11)) 
     ibufds_gtrefclk
       (.CEB(1'b0),
        .I(gtrefclk_p),
        .IB(gtrefclk_n),
        .O(gtrefclk_out),
        .ODIV2(NLW_ibufds_gtrefclk_ODIV2_UNCONNECTED));
(* box_type = "PRIMITIVE" *) 
   MMCME2_ADV #(
    .BANDWIDTH("OPTIMIZED"),
    .CLKFBOUT_MULT_F(16.000000),
    .CLKFBOUT_PHASE(0.000000),
    .CLKFBOUT_USE_FINE_PS("FALSE"),
    .CLKIN1_PERIOD(16.000000),
    .CLKIN2_PERIOD(0.000000),
    .CLKOUT0_DIVIDE_F(8.000000),
    .CLKOUT0_DUTY_CYCLE(0.500000),
    .CLKOUT0_PHASE(0.000000),
    .CLKOUT0_USE_FINE_PS("FALSE"),
    .CLKOUT1_DIVIDE(16),
    .CLKOUT1_DUTY_CYCLE(0.500000),
    .CLKOUT1_PHASE(0.000000),
    .CLKOUT1_USE_FINE_PS("FALSE"),
    .CLKOUT2_DIVIDE(1),
    .CLKOUT2_DUTY_CYCLE(0.500000),
    .CLKOUT2_PHASE(0.000000),
    .CLKOUT2_USE_FINE_PS("FALSE"),
    .CLKOUT3_DIVIDE(1),
    .CLKOUT3_DUTY_CYCLE(0.500000),
    .CLKOUT3_PHASE(0.000000),
    .CLKOUT3_USE_FINE_PS("FALSE"),
    .CLKOUT4_CASCADE("FALSE"),
    .CLKOUT4_DIVIDE(1),
    .CLKOUT4_DUTY_CYCLE(0.500000),
    .CLKOUT4_PHASE(0.000000),
    .CLKOUT4_USE_FINE_PS("FALSE"),
    .CLKOUT5_DIVIDE(1),
    .CLKOUT5_DUTY_CYCLE(0.500000),
    .CLKOUT5_PHASE(0.000000),
    .CLKOUT5_USE_FINE_PS("FALSE"),
    .CLKOUT6_DIVIDE(1),
    .CLKOUT6_DUTY_CYCLE(0.500000),
    .CLKOUT6_PHASE(0.000000),
    .CLKOUT6_USE_FINE_PS("FALSE"),
    .COMPENSATION("INTERNAL"),
    .DIVCLK_DIVIDE(1),
    .IS_CLKINSEL_INVERTED(1'b0),
    .IS_PSEN_INVERTED(1'b0),
    .IS_PSINCDEC_INVERTED(1'b0),
    .IS_PWRDWN_INVERTED(1'b0),
    .IS_RST_INVERTED(1'b0),
    .REF_JITTER1(0.010000),
    .REF_JITTER2(0.000000),
    .SS_EN("FALSE"),
    .SS_MODE("CENTER_HIGH"),
    .SS_MOD_PERIOD(10000),
    .STARTUP_WAIT("FALSE")) 
     mmcm_adv_inst
       (.CLKFBIN(clkfbout),
        .CLKFBOUT(clkfbout),
        .CLKFBOUTB(NLW_mmcm_adv_inst_CLKFBOUTB_UNCONNECTED),
        .CLKFBSTOPPED(NLW_mmcm_adv_inst_CLKFBSTOPPED_UNCONNECTED),
        .CLKIN1(txoutclk_bufg),
        .CLKIN2(1'b0),
        .CLKINSEL(1'b1),
        .CLKINSTOPPED(NLW_mmcm_adv_inst_CLKINSTOPPED_UNCONNECTED),
        .CLKOUT0(clkout0),
        .CLKOUT0B(NLW_mmcm_adv_inst_CLKOUT0B_UNCONNECTED),
        .CLKOUT1(clkout1),
        .CLKOUT1B(NLW_mmcm_adv_inst_CLKOUT1B_UNCONNECTED),
        .CLKOUT2(NLW_mmcm_adv_inst_CLKOUT2_UNCONNECTED),
        .CLKOUT2B(NLW_mmcm_adv_inst_CLKOUT2B_UNCONNECTED),
        .CLKOUT3(NLW_mmcm_adv_inst_CLKOUT3_UNCONNECTED),
        .CLKOUT3B(NLW_mmcm_adv_inst_CLKOUT3B_UNCONNECTED),
        .CLKOUT4(NLW_mmcm_adv_inst_CLKOUT4_UNCONNECTED),
        .CLKOUT5(NLW_mmcm_adv_inst_CLKOUT5_UNCONNECTED),
        .CLKOUT6(NLW_mmcm_adv_inst_CLKOUT6_UNCONNECTED),
        .DADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DCLK(1'b0),
        .DEN(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DO(NLW_mmcm_adv_inst_DO_UNCONNECTED[15:0]),
        .DRDY(NLW_mmcm_adv_inst_DRDY_UNCONNECTED),
        .DWE(1'b0),
        .LOCKED(mmcm_locked),
        .PSCLK(1'b0),
        .PSDONE(NLW_mmcm_adv_inst_PSDONE_UNCONNECTED),
        .PSEN(1'b0),
        .PSINCDEC(1'b0),
        .PWRDWN(1'b0),
        .RST(reset));
LUT2 #(
    .INIT(4'hB)) 
     \pma_reset_pipe[3]_i_1 
       (.I0(reset),
        .I1(mmcm_locked),
        .O(AS));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_gt_common" *) 
module gmii_to_sgmiigmii_to_sgmii_gt_common
   (gt0_qplloutclk_out,
    gt0_qplloutrefclk_out,
    gtrefclk_out,
    independent_clock_bufg,
    Q);
  output gt0_qplloutclk_out;
  output gt0_qplloutrefclk_out;
  input gtrefclk_out;
  input independent_clock_bufg;
  input [0:0]Q;

  wire [0:0]Q;
  wire gt0_qplloutclk_out;
  wire gt0_qplloutrefclk_out;
  wire gtrefclk_out;
  wire independent_clock_bufg;
  wire n_2_gthe2_common_0_i;
  wire n_5_gthe2_common_0_i;
  wire NLW_gthe2_common_0_i_DRPRDY_UNCONNECTED;
  wire NLW_gthe2_common_0_i_QPLLFBCLKLOST_UNCONNECTED;
  wire NLW_gthe2_common_0_i_REFCLKOUTMONITOR_UNCONNECTED;
  wire [15:0]NLW_gthe2_common_0_i_DRPDO_UNCONNECTED;
  wire [15:0]NLW_gthe2_common_0_i_PMARSVDOUT_UNCONNECTED;
  wire [7:0]NLW_gthe2_common_0_i_QPLLDMONITOR_UNCONNECTED;

(* box_type = "PRIMITIVE" *) 
   GTHE2_COMMON #(
    .BIAS_CFG(64'h0000040000001050),
    .COMMON_CFG(32'h0000001C),
    .IS_DRPCLK_INVERTED(1'b0),
    .IS_GTGREFCLK_INVERTED(1'b0),
    .IS_QPLLLOCKDETCLK_INVERTED(1'b0),
    .QPLL_CFG(27'h04801C7),
    .QPLL_CLKOUT_CFG(4'b1111),
    .QPLL_COARSE_FREQ_OVRD(6'b010000),
    .QPLL_COARSE_FREQ_OVRD_EN(1'b0),
    .QPLL_CP(10'b0000011111),
    .QPLL_CP_MONITOR_EN(1'b0),
    .QPLL_DMONITOR_SEL(1'b0),
    .QPLL_FBDIV(10'b0000100000),
    .QPLL_FBDIV_MONITOR_EN(1'b0),
    .QPLL_FBDIV_RATIO(1'b1),
    .QPLL_INIT_CFG(24'h000006),
    .QPLL_LOCK_CFG(16'h05E8),
    .QPLL_LPF(4'b1111),
    .QPLL_REFCLK_DIV(1),
    .QPLL_RP_COMP(1'b0),
    .QPLL_VTRL_RESET(2'b00),
    .RCAL_CFG(2'b00),
    .RSVD_ATTR0(16'h0000),
    .RSVD_ATTR1(16'h0000),
    .SIM_QPLLREFCLK_SEL(3'b001),
    .SIM_RESET_SPEEDUP("FALSE"),
    .SIM_VERSION("2.0")) 
     gthe2_common_0_i
       (.BGBYPASSB(1'b1),
        .BGMONITORENB(1'b1),
        .BGPDB(1'b1),
        .BGRCALOVRD({1'b1,1'b1,1'b1,1'b1,1'b1}),
        .BGRCALOVRDENB(1'b1),
        .DRPADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DRPCLK(1'b0),
        .DRPDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DRPDO(NLW_gthe2_common_0_i_DRPDO_UNCONNECTED[15:0]),
        .DRPEN(1'b0),
        .DRPRDY(NLW_gthe2_common_0_i_DRPRDY_UNCONNECTED),
        .DRPWE(1'b0),
        .GTGREFCLK(1'b0),
        .GTNORTHREFCLK0(1'b0),
        .GTNORTHREFCLK1(1'b0),
        .GTREFCLK0(gtrefclk_out),
        .GTREFCLK1(1'b0),
        .GTSOUTHREFCLK0(1'b0),
        .GTSOUTHREFCLK1(1'b0),
        .PMARSVD({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PMARSVDOUT(NLW_gthe2_common_0_i_PMARSVDOUT_UNCONNECTED[15:0]),
        .QPLLDMONITOR(NLW_gthe2_common_0_i_QPLLDMONITOR_UNCONNECTED[7:0]),
        .QPLLFBCLKLOST(NLW_gthe2_common_0_i_QPLLFBCLKLOST_UNCONNECTED),
        .QPLLLOCK(n_2_gthe2_common_0_i),
        .QPLLLOCKDETCLK(independent_clock_bufg),
        .QPLLLOCKEN(1'b1),
        .QPLLOUTCLK(gt0_qplloutclk_out),
        .QPLLOUTREFCLK(gt0_qplloutrefclk_out),
        .QPLLOUTRESET(1'b0),
        .QPLLPD(1'b1),
        .QPLLREFCLKLOST(n_5_gthe2_common_0_i),
        .QPLLREFCLKSEL({1'b0,1'b0,1'b1}),
        .QPLLRESET(Q),
        .QPLLRSVD1({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .QPLLRSVD2({1'b1,1'b1,1'b1,1'b1,1'b1}),
        .RCALENB(1'b1),
        .REFCLKOUTMONITOR(NLW_gthe2_common_0_i_REFCLKOUTMONITOR_UNCONNECTED));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_gtwizard_gtrxreset_seq" *) 
module gmii_to_sgmiigmii_to_sgmii_gtwizard_gtrxreset_seq
   (GTRXRESET_OUT,
    DRP_OP_DONE,
    O1,
    DRPDI,
    O2,
    O3,
    gt0_gtrxreset_in1_out,
    CLK,
    I1,
    CPLL_RESET,
    I2,
    I3,
    Q,
    I4,
    I5,
    I6,
    D);
  output GTRXRESET_OUT;
  output DRP_OP_DONE;
  output O1;
  output [15:0]DRPDI;
  output O2;
  output O3;
  input gt0_gtrxreset_in1_out;
  input CLK;
  input I1;
  input CPLL_RESET;
  input I2;
  input I3;
  input [0:0]Q;
  input I4;
  input [14:0]I5;
  input I6;
  input [14:0]D;

  wire CLK;
  wire CPLL_RESET;
  wire [14:0]D;
  wire [15:0]DRPDI;
  wire DRP_OP_DONE;
  wire GTRXRESET_OUT;
  wire I1;
  wire I2;
  wire I3;
  wire I4;
  wire [14:0]I5;
  wire I6;
  wire O1;
  wire O2;
  wire O3;
  wire [0:0]Q;
  wire data_out;
  wire gt0_gtrxreset_in1_out;
  wire gtrxreset_i;
  wire gtrxreset_s;
  wire gtrxreset_ss;
  wire n_0_drp_op_done_o_i_1;
  wire n_0_gthe2_i_i_23;
  wire \n_0_rd_data[15]_i_1 ;
  wire \n_0_state[0]_i_2__0 ;
  wire n_0_sync_rst_sync;
  wire [2:0]next_state;
  wire [15:0]rd_data;
  wire reset_out;
  wire rxpmaresetdone_s;
  wire rxpmaresetdone_ss;
  wire rxpmaresetdone_sss;
  wire [2:0]state;

(* SOFT_HLUTNM = "soft_lutpair94" *) 
   LUT1 #(
    .INIT(2'h1)) 
     drp_busy_i1_i_1
       (.I0(DRP_OP_DONE),
        .O(O1));
(* SOFT_HLUTNM = "soft_lutpair93" *) 
   LUT5 #(
    .INIT(32'hFFFF8000)) 
     drp_op_done_o_i_1
       (.I0(state[2]),
        .I1(I2),
        .I2(state[1]),
        .I3(state[0]),
        .I4(DRP_OP_DONE),
        .O(n_0_drp_op_done_o_i_1));
FDCE drp_op_done_o_reg
       (.C(CLK),
        .CE(1'b1),
        .CLR(gtrxreset_ss),
        .D(n_0_drp_op_done_o_i_1),
        .Q(DRP_OP_DONE));
LUT5 #(
    .INIT(32'h88BBB888)) 
     gthe2_i_i_1
       (.I0(I6),
        .I1(DRP_OP_DONE),
        .I2(state[1]),
        .I3(state[2]),
        .I4(state[0]),
        .O(O3));
LUT5 #(
    .INIT(32'h8F808080)) 
     gthe2_i_i_10
       (.I0(I4),
        .I1(I5[9]),
        .I2(DRP_OP_DONE),
        .I3(n_0_gthe2_i_i_23),
        .I4(rd_data[9]),
        .O(DRPDI[9]));
LUT5 #(
    .INIT(32'h8F808080)) 
     gthe2_i_i_11
       (.I0(I4),
        .I1(I5[8]),
        .I2(DRP_OP_DONE),
        .I3(n_0_gthe2_i_i_23),
        .I4(rd_data[8]),
        .O(DRPDI[8]));
(* SOFT_HLUTNM = "soft_lutpair94" *) 
   LUT5 #(
    .INIT(32'h8F808080)) 
     gthe2_i_i_12
       (.I0(I4),
        .I1(I5[7]),
        .I2(DRP_OP_DONE),
        .I3(n_0_gthe2_i_i_23),
        .I4(rd_data[7]),
        .O(DRPDI[7]));
LUT5 #(
    .INIT(32'h8F808080)) 
     gthe2_i_i_13
       (.I0(I4),
        .I1(I5[6]),
        .I2(DRP_OP_DONE),
        .I3(n_0_gthe2_i_i_23),
        .I4(rd_data[6]),
        .O(DRPDI[6]));
LUT5 #(
    .INIT(32'h8F808080)) 
     gthe2_i_i_14
       (.I0(I4),
        .I1(I5[5]),
        .I2(DRP_OP_DONE),
        .I3(n_0_gthe2_i_i_23),
        .I4(rd_data[5]),
        .O(DRPDI[5]));
LUT5 #(
    .INIT(32'h8F808080)) 
     gthe2_i_i_15
       (.I0(I4),
        .I1(I5[4]),
        .I2(DRP_OP_DONE),
        .I3(n_0_gthe2_i_i_23),
        .I4(rd_data[4]),
        .O(DRPDI[4]));
LUT5 #(
    .INIT(32'h8F808080)) 
     gthe2_i_i_16
       (.I0(I4),
        .I1(I5[3]),
        .I2(DRP_OP_DONE),
        .I3(n_0_gthe2_i_i_23),
        .I4(rd_data[3]),
        .O(DRPDI[3]));
LUT5 #(
    .INIT(32'h8F808080)) 
     gthe2_i_i_17
       (.I0(I4),
        .I1(I5[2]),
        .I2(DRP_OP_DONE),
        .I3(n_0_gthe2_i_i_23),
        .I4(rd_data[2]),
        .O(DRPDI[2]));
LUT5 #(
    .INIT(32'h8F808080)) 
     gthe2_i_i_18
       (.I0(I4),
        .I1(I5[1]),
        .I2(DRP_OP_DONE),
        .I3(n_0_gthe2_i_i_23),
        .I4(rd_data[1]),
        .O(DRPDI[1]));
LUT5 #(
    .INIT(32'h8F808080)) 
     gthe2_i_i_19
       (.I0(I4),
        .I1(I5[0]),
        .I2(DRP_OP_DONE),
        .I3(n_0_gthe2_i_i_23),
        .I4(rd_data[0]),
        .O(DRPDI[0]));
LUT5 #(
    .INIT(32'h8B88B888)) 
     gthe2_i_i_2
       (.I0(I4),
        .I1(DRP_OP_DONE),
        .I2(state[2]),
        .I3(state[1]),
        .I4(state[0]),
        .O(O2));
(* SOFT_HLUTNM = "soft_lutpair93" *) 
   LUT3 #(
    .INIT(8'h48)) 
     gthe2_i_i_23
       (.I0(state[2]),
        .I1(state[1]),
        .I2(state[0]),
        .O(n_0_gthe2_i_i_23));
LUT5 #(
    .INIT(32'h8F808080)) 
     gthe2_i_i_4
       (.I0(I4),
        .I1(I5[14]),
        .I2(DRP_OP_DONE),
        .I3(n_0_gthe2_i_i_23),
        .I4(rd_data[15]),
        .O(DRPDI[15]));
LUT5 #(
    .INIT(32'h8F808080)) 
     gthe2_i_i_5
       (.I0(I4),
        .I1(I5[13]),
        .I2(DRP_OP_DONE),
        .I3(n_0_gthe2_i_i_23),
        .I4(rd_data[14]),
        .O(DRPDI[14]));
LUT5 #(
    .INIT(32'h8F808080)) 
     gthe2_i_i_6
       (.I0(I4),
        .I1(I5[12]),
        .I2(DRP_OP_DONE),
        .I3(n_0_gthe2_i_i_23),
        .I4(rd_data[13]),
        .O(DRPDI[13]));
LUT5 #(
    .INIT(32'h8F808080)) 
     gthe2_i_i_7
       (.I0(I4),
        .I1(I5[11]),
        .I2(DRP_OP_DONE),
        .I3(n_0_gthe2_i_i_23),
        .I4(rd_data[12]),
        .O(DRPDI[12]));
LUT6 #(
    .INIT(64'h808F808080808080)) 
     gthe2_i_i_8
       (.I0(I3),
        .I1(Q),
        .I2(DRP_OP_DONE),
        .I3(state[0]),
        .I4(state[1]),
        .I5(state[2]),
        .O(DRPDI[11]));
LUT5 #(
    .INIT(32'h8F808080)) 
     gthe2_i_i_9
       (.I0(I4),
        .I1(I5[10]),
        .I2(DRP_OP_DONE),
        .I3(n_0_gthe2_i_i_23),
        .I4(rd_data[10]),
        .O(DRPDI[10]));
(* SOFT_HLUTNM = "soft_lutpair95" *) 
   LUT4 #(
    .INIT(16'h3B3C)) 
     gtrxreset_o_i_1
       (.I0(gtrxreset_ss),
        .I1(state[2]),
        .I2(state[1]),
        .I3(state[0]),
        .O(gtrxreset_i));
FDCE gtrxreset_o_reg
       (.C(CLK),
        .CE(1'b1),
        .CLR(n_0_sync_rst_sync),
        .D(gtrxreset_i),
        .Q(GTRXRESET_OUT));
FDCE gtrxreset_s_reg
       (.C(CLK),
        .CE(1'b1),
        .CLR(n_0_sync_rst_sync),
        .D(reset_out),
        .Q(gtrxreset_s));
FDCE gtrxreset_ss_reg
       (.C(CLK),
        .CE(1'b1),
        .CLR(n_0_sync_rst_sync),
        .D(gtrxreset_s),
        .Q(gtrxreset_ss));
LUT4 #(
    .INIT(16'h0040)) 
     \rd_data[15]_i_1 
       (.I0(state[0]),
        .I1(state[1]),
        .I2(I2),
        .I3(state[2]),
        .O(\n_0_rd_data[15]_i_1 ));
FDCE \rd_data_reg[0] 
       (.C(CLK),
        .CE(\n_0_rd_data[15]_i_1 ),
        .CLR(n_0_sync_rst_sync),
        .D(D[0]),
        .Q(rd_data[0]));
FDCE \rd_data_reg[10] 
       (.C(CLK),
        .CE(\n_0_rd_data[15]_i_1 ),
        .CLR(n_0_sync_rst_sync),
        .D(D[10]),
        .Q(rd_data[10]));
FDCE \rd_data_reg[12] 
       (.C(CLK),
        .CE(\n_0_rd_data[15]_i_1 ),
        .CLR(n_0_sync_rst_sync),
        .D(D[11]),
        .Q(rd_data[12]));
FDCE \rd_data_reg[13] 
       (.C(CLK),
        .CE(\n_0_rd_data[15]_i_1 ),
        .CLR(n_0_sync_rst_sync),
        .D(D[12]),
        .Q(rd_data[13]));
FDCE \rd_data_reg[14] 
       (.C(CLK),
        .CE(\n_0_rd_data[15]_i_1 ),
        .CLR(n_0_sync_rst_sync),
        .D(D[13]),
        .Q(rd_data[14]));
FDCE \rd_data_reg[15] 
       (.C(CLK),
        .CE(\n_0_rd_data[15]_i_1 ),
        .CLR(n_0_sync_rst_sync),
        .D(D[14]),
        .Q(rd_data[15]));
FDCE \rd_data_reg[1] 
       (.C(CLK),
        .CE(\n_0_rd_data[15]_i_1 ),
        .CLR(n_0_sync_rst_sync),
        .D(D[1]),
        .Q(rd_data[1]));
FDCE \rd_data_reg[2] 
       (.C(CLK),
        .CE(\n_0_rd_data[15]_i_1 ),
        .CLR(n_0_sync_rst_sync),
        .D(D[2]),
        .Q(rd_data[2]));
FDCE \rd_data_reg[3] 
       (.C(CLK),
        .CE(\n_0_rd_data[15]_i_1 ),
        .CLR(n_0_sync_rst_sync),
        .D(D[3]),
        .Q(rd_data[3]));
FDCE \rd_data_reg[4] 
       (.C(CLK),
        .CE(\n_0_rd_data[15]_i_1 ),
        .CLR(n_0_sync_rst_sync),
        .D(D[4]),
        .Q(rd_data[4]));
FDCE \rd_data_reg[5] 
       (.C(CLK),
        .CE(\n_0_rd_data[15]_i_1 ),
        .CLR(n_0_sync_rst_sync),
        .D(D[5]),
        .Q(rd_data[5]));
FDCE \rd_data_reg[6] 
       (.C(CLK),
        .CE(\n_0_rd_data[15]_i_1 ),
        .CLR(n_0_sync_rst_sync),
        .D(D[6]),
        .Q(rd_data[6]));
FDCE \rd_data_reg[7] 
       (.C(CLK),
        .CE(\n_0_rd_data[15]_i_1 ),
        .CLR(n_0_sync_rst_sync),
        .D(D[7]),
        .Q(rd_data[7]));
FDCE \rd_data_reg[8] 
       (.C(CLK),
        .CE(\n_0_rd_data[15]_i_1 ),
        .CLR(n_0_sync_rst_sync),
        .D(D[8]),
        .Q(rd_data[8]));
FDCE \rd_data_reg[9] 
       (.C(CLK),
        .CE(\n_0_rd_data[15]_i_1 ),
        .CLR(n_0_sync_rst_sync),
        .D(D[9]),
        .Q(rd_data[9]));
FDCE rxpmaresetdone_s_reg
       (.C(CLK),
        .CE(1'b1),
        .CLR(n_0_sync_rst_sync),
        .D(data_out),
        .Q(rxpmaresetdone_s));
FDCE rxpmaresetdone_ss_reg
       (.C(CLK),
        .CE(1'b1),
        .CLR(n_0_sync_rst_sync),
        .D(rxpmaresetdone_s),
        .Q(rxpmaresetdone_ss));
FDCE rxpmaresetdone_sss_reg
       (.C(CLK),
        .CE(1'b1),
        .CLR(n_0_sync_rst_sync),
        .D(rxpmaresetdone_ss),
        .Q(rxpmaresetdone_sss));
LUT6 #(
    .INIT(64'h00CC8888FFCCFC30)) 
     \state[0]_i_1 
       (.I0(\n_0_state[0]_i_2__0 ),
        .I1(state[2]),
        .I2(gtrxreset_ss),
        .I3(I2),
        .I4(state[1]),
        .I5(state[0]),
        .O(next_state[0]));
LUT2 #(
    .INIT(4'hB)) 
     \state[0]_i_2__0 
       (.I0(rxpmaresetdone_ss),
        .I1(rxpmaresetdone_sss),
        .O(\n_0_state[0]_i_2__0 ));
LUT6 #(
    .INIT(64'h5500FFFF30FF0000)) 
     \state[1]_i_1__0 
       (.I0(I2),
        .I1(rxpmaresetdone_ss),
        .I2(rxpmaresetdone_sss),
        .I3(state[2]),
        .I4(state[0]),
        .I5(state[1]),
        .O(next_state[1]));
(* SOFT_HLUTNM = "soft_lutpair95" *) 
   LUT4 #(
    .INIT(16'h7CCC)) 
     \state[2]_i_1__0 
       (.I0(I2),
        .I1(state[2]),
        .I2(state[1]),
        .I3(state[0]),
        .O(next_state[2]));
FDCE #(
    .INIT(1'b0)) 
     \state_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .CLR(n_0_sync_rst_sync),
        .D(next_state[0]),
        .Q(state[0]));
FDCE #(
    .INIT(1'b0)) 
     \state_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .CLR(n_0_sync_rst_sync),
        .D(next_state[1]),
        .Q(state[1]));
FDCE #(
    .INIT(1'b0)) 
     \state_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .CLR(n_0_sync_rst_sync),
        .D(next_state[2]),
        .Q(state[2]));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b11" *) 
   gmii_to_sgmiigmii_to_sgmii_reset_sync__10 sync_gtrxreset_in
       (.clk(CLK),
        .reset_in(gt0_gtrxreset_in1_out),
        .reset_out(reset_out));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b11" *) 
   gmii_to_sgmiigmii_to_sgmii_reset_sync sync_rst_sync
       (.clk(CLK),
        .reset_in(CPLL_RESET),
        .reset_out(n_0_sync_rst_sync));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gmii_to_sgmiigmii_to_sgmii_sync_block__parameterized0__18 sync_rxpmaresetdone
       (.clk(CLK),
        .data_in(I1),
        .data_out(data_out));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_gtwizard_rxpmarst_seq" *) 
module gmii_to_sgmiigmii_to_sgmii_gtwizard_rxpmarst_seq
   (RXPMARESET_OUT,
    Q,
    DRPADDR,
    O1,
    O2,
    O3,
    O4,
    CLK,
    I1,
    CPLL_RESET,
    I2,
    drp_busy_i1,
    DRP_OP_DONE,
    D);
  output RXPMARESET_OUT;
  output [0:0]Q;
  output [0:0]DRPADDR;
  output O1;
  output O2;
  output O3;
  output [14:0]O4;
  input CLK;
  input I1;
  input CPLL_RESET;
  input I2;
  input drp_busy_i1;
  input DRP_OP_DONE;
  input [14:0]D;

  wire CLK;
  wire CPLL_RESET;
  wire [14:0]D;
  wire [0:0]DRPADDR;
  wire DRP_OP_DONE;
  wire I1;
  wire I2;
  wire O1;
  wire O2;
  wire O3;
  wire [14:0]O4;
  wire [0:0]Q;
  wire RXPMARESET_OUT;
  wire data_out;
  wire drp_busy_i1;
  wire \n_0_rd_data[15]_i_1__0 ;
  wire \n_0_state[0]_i_2 ;
  wire \n_0_state[0]_i_3 ;
  wire n_0_sync_rst_sync;
  wire [3:0]next_state;
  wire reset_out;
  wire rxpmareset_i;
  wire rxpmareset_s;
  wire rxpmareset_ss;
  wire [3:0]state;

LUT6 #(
    .INIT(64'h55555510FFFFFFFF)) 
     gthe2_i_i_20
       (.I0(state[3]),
        .I1(drp_busy_i1),
        .I2(state[0]),
        .I3(state[1]),
        .I4(Q),
        .I5(DRP_OP_DONE),
        .O(DRPADDR));
LUT5 #(
    .INIT(32'h00005A10)) 
     gthe2_i_i_21
       (.I0(Q),
        .I1(drp_busy_i1),
        .I2(state[0]),
        .I3(state[1]),
        .I4(state[3]),
        .O(O2));
(* SOFT_HLUTNM = "soft_lutpair96" *) 
   LUT4 #(
    .INIT(16'h0048)) 
     gthe2_i_i_22
       (.I0(Q),
        .I1(state[1]),
        .I2(state[0]),
        .I3(state[3]),
        .O(O1));
(* SOFT_HLUTNM = "soft_lutpair97" *) 
   LUT3 #(
    .INIT(8'h04)) 
     gthe2_i_i_24
       (.I0(state[0]),
        .I1(state[1]),
        .I2(state[3]),
        .O(O3));
LUT5 #(
    .INIT(32'h00000020)) 
     \rd_data[15]_i_1__0 
       (.I0(I2),
        .I1(state[0]),
        .I2(state[1]),
        .I3(state[3]),
        .I4(Q),
        .O(\n_0_rd_data[15]_i_1__0 ));
FDCE \rd_data_reg[0] 
       (.C(CLK),
        .CE(\n_0_rd_data[15]_i_1__0 ),
        .CLR(n_0_sync_rst_sync),
        .D(D[0]),
        .Q(O4[0]));
FDCE \rd_data_reg[10] 
       (.C(CLK),
        .CE(\n_0_rd_data[15]_i_1__0 ),
        .CLR(n_0_sync_rst_sync),
        .D(D[10]),
        .Q(O4[10]));
FDCE \rd_data_reg[12] 
       (.C(CLK),
        .CE(\n_0_rd_data[15]_i_1__0 ),
        .CLR(n_0_sync_rst_sync),
        .D(D[11]),
        .Q(O4[11]));
FDCE \rd_data_reg[13] 
       (.C(CLK),
        .CE(\n_0_rd_data[15]_i_1__0 ),
        .CLR(n_0_sync_rst_sync),
        .D(D[12]),
        .Q(O4[12]));
FDCE \rd_data_reg[14] 
       (.C(CLK),
        .CE(\n_0_rd_data[15]_i_1__0 ),
        .CLR(n_0_sync_rst_sync),
        .D(D[13]),
        .Q(O4[13]));
FDCE \rd_data_reg[15] 
       (.C(CLK),
        .CE(\n_0_rd_data[15]_i_1__0 ),
        .CLR(n_0_sync_rst_sync),
        .D(D[14]),
        .Q(O4[14]));
FDCE \rd_data_reg[1] 
       (.C(CLK),
        .CE(\n_0_rd_data[15]_i_1__0 ),
        .CLR(n_0_sync_rst_sync),
        .D(D[1]),
        .Q(O4[1]));
FDCE \rd_data_reg[2] 
       (.C(CLK),
        .CE(\n_0_rd_data[15]_i_1__0 ),
        .CLR(n_0_sync_rst_sync),
        .D(D[2]),
        .Q(O4[2]));
FDCE \rd_data_reg[3] 
       (.C(CLK),
        .CE(\n_0_rd_data[15]_i_1__0 ),
        .CLR(n_0_sync_rst_sync),
        .D(D[3]),
        .Q(O4[3]));
FDCE \rd_data_reg[4] 
       (.C(CLK),
        .CE(\n_0_rd_data[15]_i_1__0 ),
        .CLR(n_0_sync_rst_sync),
        .D(D[4]),
        .Q(O4[4]));
FDCE \rd_data_reg[5] 
       (.C(CLK),
        .CE(\n_0_rd_data[15]_i_1__0 ),
        .CLR(n_0_sync_rst_sync),
        .D(D[5]),
        .Q(O4[5]));
FDCE \rd_data_reg[6] 
       (.C(CLK),
        .CE(\n_0_rd_data[15]_i_1__0 ),
        .CLR(n_0_sync_rst_sync),
        .D(D[6]),
        .Q(O4[6]));
FDCE \rd_data_reg[7] 
       (.C(CLK),
        .CE(\n_0_rd_data[15]_i_1__0 ),
        .CLR(n_0_sync_rst_sync),
        .D(D[7]),
        .Q(O4[7]));
FDCE \rd_data_reg[8] 
       (.C(CLK),
        .CE(\n_0_rd_data[15]_i_1__0 ),
        .CLR(n_0_sync_rst_sync),
        .D(D[8]),
        .Q(O4[8]));
FDCE \rd_data_reg[9] 
       (.C(CLK),
        .CE(\n_0_rd_data[15]_i_1__0 ),
        .CLR(n_0_sync_rst_sync),
        .D(D[9]),
        .Q(O4[9]));
(* SOFT_HLUTNM = "soft_lutpair96" *) 
   LUT5 #(
    .INIT(32'h0010AA00)) 
     rxpmareset_o_i_1
       (.I0(Q),
        .I1(state[1]),
        .I2(rxpmareset_ss),
        .I3(state[0]),
        .I4(state[3]),
        .O(rxpmareset_i));
FDCE rxpmareset_o_reg
       (.C(CLK),
        .CE(1'b1),
        .CLR(n_0_sync_rst_sync),
        .D(rxpmareset_i),
        .Q(RXPMARESET_OUT));
FDCE rxpmareset_s_reg
       (.C(CLK),
        .CE(1'b1),
        .CLR(n_0_sync_rst_sync),
        .D(reset_out),
        .Q(rxpmareset_s));
FDCE rxpmareset_ss_reg
       (.C(CLK),
        .CE(1'b1),
        .CLR(n_0_sync_rst_sync),
        .D(rxpmareset_s),
        .Q(rxpmareset_ss));
LUT5 #(
    .INIT(32'h000000B8)) 
     \state[0]_i_2 
       (.I0(I2),
        .I1(state[1]),
        .I2(rxpmareset_ss),
        .I3(state[0]),
        .I4(state[3]),
        .O(\n_0_state[0]_i_2 ));
LUT5 #(
    .INIT(32'h000074EE)) 
     \state[0]_i_3 
       (.I0(I2),
        .I1(state[1]),
        .I2(data_out),
        .I3(state[0]),
        .I4(state[3]),
        .O(\n_0_state[0]_i_3 ));
LUT6 #(
    .INIT(64'h0000000050FF3F00)) 
     \state[1]_i_1 
       (.I0(I2),
        .I1(data_out),
        .I2(Q),
        .I3(state[0]),
        .I4(state[1]),
        .I5(state[3]),
        .O(next_state[1]));
(* SOFT_HLUTNM = "soft_lutpair97" *) 
   LUT5 #(
    .INIT(32'h00007CCC)) 
     \state[2]_i_1 
       (.I0(I2),
        .I1(Q),
        .I2(state[1]),
        .I3(state[0]),
        .I4(state[3]),
        .O(next_state[2]));
LUT6 #(
    .INIT(64'h0000030080800000)) 
     \state[3]_i_1 
       (.I0(I2),
        .I1(Q),
        .I2(state[1]),
        .I3(rxpmareset_ss),
        .I4(state[0]),
        .I5(state[3]),
        .O(next_state[3]));
FDCE #(
    .INIT(1'b0)) 
     \state_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .CLR(n_0_sync_rst_sync),
        .D(next_state[0]),
        .Q(state[0]));
MUXF7 \state_reg[0]_i_1 
       (.I0(\n_0_state[0]_i_2 ),
        .I1(\n_0_state[0]_i_3 ),
        .O(next_state[0]),
        .S(Q));
FDCE #(
    .INIT(1'b0)) 
     \state_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .CLR(n_0_sync_rst_sync),
        .D(next_state[1]),
        .Q(state[1]));
FDCE #(
    .INIT(1'b0)) 
     \state_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .CLR(n_0_sync_rst_sync),
        .D(next_state[2]),
        .Q(Q));
FDCE #(
    .INIT(1'b0)) 
     \state_reg[3] 
       (.C(CLK),
        .CE(1'b1),
        .CLR(n_0_sync_rst_sync),
        .D(next_state[3]),
        .Q(state[3]));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gmii_to_sgmiigmii_to_sgmii_sync_block__parameterized0__19 sync_RXPMARESETDONE
       (.clk(CLK),
        .data_in(I1),
        .data_out(data_out));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gmii_to_sgmiigmii_to_sgmii_reset_sync__parameterized1 sync_rst_sync
       (.clk(CLK),
        .reset_in(CPLL_RESET),
        .reset_out(n_0_sync_rst_sync));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gmii_to_sgmiigmii_to_sgmii_reset_sync__parameterized1__2 sync_rxpmareset_in
       (.clk(CLK),
        .reset_in(1'b0),
        .reset_out(reset_out));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_johnson_cntr" *) 
module gmii_to_sgmiigmii_to_sgmii_johnson_cntr
   (clk_div10,
    O1,
    O2,
    O3,
    CLK,
    clk12_5_reg,
    speed_is_10_100_fall,
    speed_is_100_fall,
    I1,
    reset_fall,
    I3);
  output clk_div10;
  output O1;
  output O2;
  output O3;
  input CLK;
  input clk12_5_reg;
  input speed_is_10_100_fall;
  input speed_is_100_fall;
  input I1;
  input reset_fall;
  input I3;

  wire CLK;
  wire I1;
  wire I3;
  wire O1;
  wire O2;
  wire O3;
  wire clk12_5_reg;
  wire clk_div10;
  wire n_0_reg1_i_1__0;
  wire n_0_reg5_reg;
  wire reg1;
  wire reg2;
  wire reg4;
  wire reg5;
  wire reset_fall;
  wire speed_is_100_fall;
  wire speed_is_10_100_fall;

(* SOFT_HLUTNM = "soft_lutpair60" *) 
   LUT2 #(
    .INIT(4'h2)) 
     clk_en_12_5_fall_i_1
       (.I0(clk12_5_reg),
        .I1(clk_div10),
        .O(O1));
(* SOFT_HLUTNM = "soft_lutpair60" *) 
   LUT2 #(
    .INIT(4'h2)) 
     clk_en_12_5_rise_i_1
       (.I0(clk_div10),
        .I1(clk12_5_reg),
        .O(O2));
LUT1 #(
    .INIT(2'h1)) 
     reg1_i_1__0
       (.I0(n_0_reg5_reg),
        .O(n_0_reg1_i_1__0));
FDRE reg1_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_reg1_i_1__0),
        .Q(reg1),
        .R(reg5));
FDRE reg2_reg
       (.C(CLK),
        .CE(1'b1),
        .D(reg1),
        .Q(reg2),
        .R(reg5));
FDRE reg3_reg
       (.C(CLK),
        .CE(1'b1),
        .D(reg2),
        .Q(clk_div10),
        .R(reg5));
FDRE reg4_reg
       (.C(CLK),
        .CE(1'b1),
        .D(clk_div10),
        .Q(reg4),
        .R(reg5));
LUT3 #(
    .INIT(8'hBA)) 
     reg5_i_1
       (.I0(I3),
        .I1(reg4),
        .I2(n_0_reg5_reg),
        .O(reg5));
FDRE reg5_reg
       (.C(CLK),
        .CE(1'b1),
        .D(reg4),
        .Q(n_0_reg5_reg),
        .R(reg5));
LUT5 #(
    .INIT(32'h0000DFD5)) 
     sgmii_clk_f_i_1
       (.I0(speed_is_10_100_fall),
        .I1(clk_div10),
        .I2(speed_is_100_fall),
        .I3(I1),
        .I4(reset_fall),
        .O(O3));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_johnson_cntr" *) 
module gmii_to_sgmiigmii_to_sgmii_johnson_cntr_0
   (O1,
    O2,
    sgmii_clk_r0_out,
    clk_en,
    CLK,
    clk1_25_reg,
    I2,
    I1,
    clk_div10,
    I3);
  output O1;
  output O2;
  output sgmii_clk_r0_out;
  input clk_en;
  input CLK;
  input clk1_25_reg;
  input I2;
  input I1;
  input clk_div10;
  input I3;

  wire CLK;
  wire I1;
  wire I2;
  wire I3;
  wire O1;
  wire O2;
  wire clk1_25_reg;
  wire clk_div10;
  wire clk_en;
  wire n_0_reg1_i_1;
  wire n_0_reg1_reg;
  wire n_0_reg2_reg;
  wire n_0_reg5_reg;
  wire reg4;
  wire reg5;
  wire sgmii_clk_r0_out;

(* SOFT_HLUTNM = "soft_lutpair61" *) 
   LUT2 #(
    .INIT(4'h2)) 
     clk_en_1_25_fall_i_1
       (.I0(clk1_25_reg),
        .I1(O1),
        .O(O2));
LUT1 #(
    .INIT(2'h1)) 
     reg1_i_1
       (.I0(n_0_reg5_reg),
        .O(n_0_reg1_i_1));
FDRE reg1_reg
       (.C(CLK),
        .CE(clk_en),
        .D(n_0_reg1_i_1),
        .Q(n_0_reg1_reg),
        .R(reg5));
FDRE reg2_reg
       (.C(CLK),
        .CE(clk_en),
        .D(n_0_reg1_reg),
        .Q(n_0_reg2_reg),
        .R(reg5));
FDRE reg3_reg
       (.C(CLK),
        .CE(clk_en),
        .D(n_0_reg2_reg),
        .Q(O1),
        .R(reg5));
FDRE reg4_reg
       (.C(CLK),
        .CE(clk_en),
        .D(O1),
        .Q(reg4),
        .R(reg5));
LUT4 #(
    .INIT(16'hBAAA)) 
     reg5_i_1__0
       (.I0(I3),
        .I1(reg4),
        .I2(n_0_reg5_reg),
        .I3(clk_en),
        .O(reg5));
FDRE reg5_reg
       (.C(CLK),
        .CE(clk_en),
        .D(reg4),
        .Q(n_0_reg5_reg),
        .R(reg5));
(* SOFT_HLUTNM = "soft_lutpair61" *) 
   LUT4 #(
    .INIT(16'hA808)) 
     sgmii_clk_r_i_1
       (.I0(I2),
        .I1(O1),
        .I2(I1),
        .I3(clk_div10),
        .O(sgmii_clk_r0_out));
endmodule

(* INITIALISE = "2'b11" *) (* dont_touch = "yes" *) (* ORIG_REF_NAME = "gmii_to_sgmii_reset_sync" *) 
module gmii_to_sgmiigmii_to_sgmii_reset_sync
   (reset_in,
    clk,
    reset_out);
  input reset_in;
  input clk;
  output reset_out;

  wire clk;
  wire reset_in;
  wire reset_out;
  wire reset_sync_reg1;
  wire reset_sync_reg2;
  wire reset_sync_reg3;
  wire reset_sync_reg4;
  wire reset_sync_reg5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync1
       (.C(clk),
        .CE(1'b1),
        .D(1'b0),
        .PRE(reset_in),
        .Q(reset_sync_reg1));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync2
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg1),
        .PRE(reset_in),
        .Q(reset_sync_reg2));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync3
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg2),
        .PRE(reset_in),
        .Q(reset_sync_reg3));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync4
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg3),
        .PRE(reset_in),
        .Q(reset_sync_reg4));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync5
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg4),
        .PRE(reset_in),
        .Q(reset_sync_reg5));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync6
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg5),
        .PRE(1'b0),
        .Q(reset_out));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_reset_sync" *) (* INITIALISE = "2'b11" *) (* dont_touch = "yes" *) 
module gmii_to_sgmiigmii_to_sgmii_reset_sync__10
   (reset_in,
    clk,
    reset_out);
  input reset_in;
  input clk;
  output reset_out;

  wire clk;
  wire reset_in;
  wire reset_out;
  wire reset_sync_reg1;
  wire reset_sync_reg2;
  wire reset_sync_reg3;
  wire reset_sync_reg4;
  wire reset_sync_reg5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync1
       (.C(clk),
        .CE(1'b1),
        .D(1'b0),
        .PRE(reset_in),
        .Q(reset_sync_reg1));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync2
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg1),
        .PRE(reset_in),
        .Q(reset_sync_reg2));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync3
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg2),
        .PRE(reset_in),
        .Q(reset_sync_reg3));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync4
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg3),
        .PRE(reset_in),
        .Q(reset_sync_reg4));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync5
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg4),
        .PRE(reset_in),
        .Q(reset_sync_reg5));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync6
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg5),
        .PRE(1'b0),
        .Q(reset_out));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_reset_sync" *) (* INITIALISE = "2'b11" *) (* dont_touch = "yes" *) 
module gmii_to_sgmiigmii_to_sgmii_reset_sync__6
   (reset_in,
    clk,
    reset_out);
  input reset_in;
  input clk;
  output reset_out;

  wire clk;
  wire reset_in;
  wire reset_out;
  wire reset_sync_reg1;
  wire reset_sync_reg2;
  wire reset_sync_reg3;
  wire reset_sync_reg4;
  wire reset_sync_reg5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync1
       (.C(clk),
        .CE(1'b1),
        .D(1'b0),
        .PRE(reset_in),
        .Q(reset_sync_reg1));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync2
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg1),
        .PRE(reset_in),
        .Q(reset_sync_reg2));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync3
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg2),
        .PRE(reset_in),
        .Q(reset_sync_reg3));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync4
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg3),
        .PRE(reset_in),
        .Q(reset_sync_reg4));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync5
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg4),
        .PRE(reset_in),
        .Q(reset_sync_reg5));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync6
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg5),
        .PRE(1'b0),
        .Q(reset_out));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_reset_sync" *) (* INITIALISE = "2'b11" *) (* dont_touch = "yes" *) 
module gmii_to_sgmiigmii_to_sgmii_reset_sync__7
   (reset_in,
    clk,
    reset_out);
  input reset_in;
  input clk;
  output reset_out;

  wire clk;
  wire reset_in;
  wire reset_out;
  wire reset_sync_reg1;
  wire reset_sync_reg2;
  wire reset_sync_reg3;
  wire reset_sync_reg4;
  wire reset_sync_reg5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync1
       (.C(clk),
        .CE(1'b1),
        .D(1'b0),
        .PRE(reset_in),
        .Q(reset_sync_reg1));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync2
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg1),
        .PRE(reset_in),
        .Q(reset_sync_reg2));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync3
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg2),
        .PRE(reset_in),
        .Q(reset_sync_reg3));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync4
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg3),
        .PRE(reset_in),
        .Q(reset_sync_reg4));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync5
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg4),
        .PRE(reset_in),
        .Q(reset_sync_reg5));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync6
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg5),
        .PRE(1'b0),
        .Q(reset_out));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_reset_sync" *) (* INITIALISE = "2'b11" *) (* dont_touch = "yes" *) 
module gmii_to_sgmiigmii_to_sgmii_reset_sync__8
   (reset_in,
    clk,
    reset_out);
  input reset_in;
  input clk;
  output reset_out;

  wire clk;
  wire reset_in;
  wire reset_out;
  wire reset_sync_reg1;
  wire reset_sync_reg2;
  wire reset_sync_reg3;
  wire reset_sync_reg4;
  wire reset_sync_reg5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync1
       (.C(clk),
        .CE(1'b1),
        .D(1'b0),
        .PRE(reset_in),
        .Q(reset_sync_reg1));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync2
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg1),
        .PRE(reset_in),
        .Q(reset_sync_reg2));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync3
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg2),
        .PRE(reset_in),
        .Q(reset_sync_reg3));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync4
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg3),
        .PRE(reset_in),
        .Q(reset_sync_reg4));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync5
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg4),
        .PRE(reset_in),
        .Q(reset_sync_reg5));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync6
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg5),
        .PRE(1'b0),
        .Q(reset_out));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_reset_sync" *) (* INITIALISE = "2'b11" *) (* dont_touch = "yes" *) 
module gmii_to_sgmiigmii_to_sgmii_reset_sync__9
   (reset_in,
    clk,
    reset_out);
  input reset_in;
  input clk;
  output reset_out;

  wire clk;
  wire reset_in;
  wire reset_out;
  wire reset_sync_reg1;
  wire reset_sync_reg2;
  wire reset_sync_reg3;
  wire reset_sync_reg4;
  wire reset_sync_reg5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync1
       (.C(clk),
        .CE(1'b1),
        .D(1'b0),
        .PRE(reset_in),
        .Q(reset_sync_reg1));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync2
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg1),
        .PRE(reset_in),
        .Q(reset_sync_reg2));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync3
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg2),
        .PRE(reset_in),
        .Q(reset_sync_reg3));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync4
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg3),
        .PRE(reset_in),
        .Q(reset_sync_reg4));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync5
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg4),
        .PRE(reset_in),
        .Q(reset_sync_reg5));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync6
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg5),
        .PRE(1'b0),
        .Q(reset_out));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_reset_sync" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gmii_to_sgmiigmii_to_sgmii_reset_sync__parameterized1
   (reset_in,
    clk,
    reset_out);
  input reset_in;
  input clk;
  output reset_out;

  wire clk;
  wire reset_in;
  wire reset_out;
  wire reset_sync_reg1;
  wire reset_sync_reg2;
  wire reset_sync_reg3;
  wire reset_sync_reg4;
  wire reset_sync_reg5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b0)) 
     reset_sync1
       (.C(clk),
        .CE(1'b1),
        .D(1'b0),
        .PRE(reset_in),
        .Q(reset_sync_reg1));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b0)) 
     reset_sync2
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg1),
        .PRE(reset_in),
        .Q(reset_sync_reg2));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b0)) 
     reset_sync3
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg2),
        .PRE(reset_in),
        .Q(reset_sync_reg3));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b0)) 
     reset_sync4
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg3),
        .PRE(reset_in),
        .Q(reset_sync_reg4));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b0)) 
     reset_sync5
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg4),
        .PRE(reset_in),
        .Q(reset_sync_reg5));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b0)) 
     reset_sync6
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg5),
        .PRE(1'b0),
        .Q(reset_out));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_reset_sync" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gmii_to_sgmiigmii_to_sgmii_reset_sync__parameterized1__2
   (reset_in,
    clk,
    reset_out);
  input reset_in;
  input clk;
  output reset_out;

  wire clk;
  wire reset_in;
  wire reset_out;
  wire reset_sync_reg1;
  wire reset_sync_reg2;
  wire reset_sync_reg3;
  wire reset_sync_reg4;
  wire reset_sync_reg5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b0)) 
     reset_sync1
       (.C(clk),
        .CE(1'b1),
        .D(1'b0),
        .PRE(reset_in),
        .Q(reset_sync_reg1));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b0)) 
     reset_sync2
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg1),
        .PRE(reset_in),
        .Q(reset_sync_reg2));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b0)) 
     reset_sync3
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg2),
        .PRE(reset_in),
        .Q(reset_sync_reg3));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b0)) 
     reset_sync4
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg3),
        .PRE(reset_in),
        .Q(reset_sync_reg4));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b0)) 
     reset_sync5
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg4),
        .PRE(reset_in),
        .Q(reset_sync_reg5));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b0)) 
     reset_sync6
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg5),
        .PRE(1'b0),
        .Q(reset_out));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_resets" *) 
module gmii_to_sgmiigmii_to_sgmii_resets
   (Q,
    independent_clock_bufg,
    AS);
  output [0:0]Q;
  input independent_clock_bufg;
  input [0:0]AS;

  wire [0:0]AS;
  wire [0:0]Q;
  wire independent_clock_bufg;
  wire [2:0]pma_reset_pipe;

(* ASYNC_REG *) 
   FDPE \pma_reset_pipe_reg[0] 
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(1'b0),
        .PRE(AS),
        .Q(pma_reset_pipe[0]));
(* ASYNC_REG *) 
   FDPE \pma_reset_pipe_reg[1] 
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(pma_reset_pipe[0]),
        .PRE(AS),
        .Q(pma_reset_pipe[1]));
(* ASYNC_REG *) 
   FDPE \pma_reset_pipe_reg[2] 
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(pma_reset_pipe[1]),
        .PRE(AS),
        .Q(pma_reset_pipe[2]));
(* ASYNC_REG *) 
   FDPE \pma_reset_pipe_reg[3] 
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(pma_reset_pipe[2]),
        .PRE(AS),
        .Q(Q));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_rx_elastic_buffer" *) 
module gmii_to_sgmiigmii_to_sgmii_rx_elastic_buffer
   (rxnotintable_usr,
    rxdisperr_usr,
    rxchariscomma,
    rxcharisk,
    rxbuferr,
    O1,
    I7,
    CLK,
    I1,
    rxrecreset,
    rxreset,
    D);
  output rxnotintable_usr;
  output rxdisperr_usr;
  output rxchariscomma;
  output rxcharisk;
  output rxbuferr;
  output [7:0]O1;
  output [1:0]I7;
  input CLK;
  input I1;
  input rxrecreset;
  input rxreset;
  input [23:0]D;

  wire CLK;
  wire [23:0]D;
  wire I1;
  wire [1:0]I7;
  wire [7:0]O1;
  wire d16p2_wr_reg;
  wire data_in;
  wire data_out;
  wire data_out0_out;
  wire data_out1_out;
  wire data_out2_out;
  wire data_out3_out;
  wire data_out4_out;
  wire [28:0]dpo;
  wire even;
  wire initialize_counter0;
  wire [4:0]initialize_counter_reg__0;
  wire initialize_ram;
  wire initialize_ram0;
  wire initialize_ram_complete;
  wire initialize_ram_complete_pulse;
  wire initialize_ram_complete_pulse0;
  wire initialize_ram_complete_reg__0;
  wire initialize_ram_complete_sync_reg1;
  wire initialize_ram_complete_sync_ris_edg;
  wire insert_idle;
  wire insert_idle_reg__0;
  wire k28p5_wr_reg;
  wire n_0_d16p2_wr_reg_i_2;
  wire n_0_even_i_1;
  wire n_0_initialize_ram_complete_i_1;
  wire n_0_initialize_ram_complete_sync_ris_edg_i_1;
  wire n_0_initialize_ram_i_1;
  wire n_0_insert_idle_i_1;
  wire n_0_k28p5_wr_reg_i_2;
  wire n_0_ram_reg_0_63_15_17;
  wire n_0_ram_reg_0_63_24_26;
  wire \n_0_rd_addr_gray[0]_i_1 ;
  wire \n_0_rd_addr_gray[1]_i_1 ;
  wire \n_0_rd_addr_gray[2]_i_1 ;
  wire \n_0_rd_addr_gray[3]_i_1 ;
  wire \n_0_rd_addr_gray[4]_i_1 ;
  wire \n_0_rd_addr_plus2_reg[0] ;
  wire \n_0_rd_addr_plus2_reg[5] ;
  wire \n_0_rd_addr_reg[0] ;
  wire \n_0_rd_addr_reg[1] ;
  wire \n_0_rd_addr_reg[2] ;
  wire \n_0_rd_addr_reg[3] ;
  wire \n_0_rd_addr_reg[4] ;
  wire \n_0_rd_addr_reg[5] ;
  wire \n_0_rd_data_reg_reg[0] ;
  wire \n_0_rd_data_reg_reg[10] ;
  wire \n_0_rd_data_reg_reg[11] ;
  wire \n_0_rd_data_reg_reg[12] ;
  wire \n_0_rd_data_reg_reg[13] ;
  wire \n_0_rd_data_reg_reg[16] ;
  wire \n_0_rd_data_reg_reg[17] ;
  wire \n_0_rd_data_reg_reg[18] ;
  wire \n_0_rd_data_reg_reg[19] ;
  wire \n_0_rd_data_reg_reg[1] ;
  wire \n_0_rd_data_reg_reg[20] ;
  wire \n_0_rd_data_reg_reg[21] ;
  wire \n_0_rd_data_reg_reg[22] ;
  wire \n_0_rd_data_reg_reg[23] ;
  wire \n_0_rd_data_reg_reg[25] ;
  wire \n_0_rd_data_reg_reg[26] ;
  wire \n_0_rd_data_reg_reg[27] ;
  wire \n_0_rd_data_reg_reg[28] ;
  wire \n_0_rd_data_reg_reg[2] ;
  wire \n_0_rd_data_reg_reg[3] ;
  wire \n_0_rd_data_reg_reg[4] ;
  wire \n_0_rd_data_reg_reg[5] ;
  wire \n_0_rd_data_reg_reg[6] ;
  wire \n_0_rd_data_reg_reg[7] ;
  wire \n_0_rd_data_reg_reg[9] ;
  wire n_0_rd_enable_i_1;
  wire n_0_rd_enable_i_2;
  wire n_0_rd_enable_i_3;
  wire n_0_rd_enable_i_4;
  wire n_0_rd_enable_i_5;
  wire \n_0_rd_occupancy[3]_i_6 ;
  wire \n_0_rd_occupancy[3]_i_7 ;
  wire \n_0_rd_occupancy[3]_i_8 ;
  wire \n_0_rd_occupancy[3]_i_9 ;
  wire \n_0_rd_occupancy[5]_i_2 ;
  wire \n_0_rd_occupancy[5]_i_3 ;
  wire \n_0_rd_occupancy[5]_i_4 ;
  wire \n_0_rd_occupancy_reg[3]_i_1 ;
  wire \n_0_reclock_rd_addrgray[0].sync_rd_addrgray ;
  wire \n_0_reclock_rd_addrgray[4].sync_rd_addrgray ;
  wire \n_0_reclock_wr_addrgray[0].sync_wr_addrgray ;
  wire n_0_remove_idle_i_1;
  wire n_0_reset_modified_i_1;
  wire n_0_rxbuferr_i_1;
  wire n_0_rxchariscomma_usr_i_1;
  wire n_0_rxcharisk_usr_i_1;
  wire \n_0_rxclkcorcnt[0]_i_1 ;
  wire \n_0_rxclkcorcnt[2]_i_1 ;
  wire \n_0_rxdata_usr[0]_i_1 ;
  wire \n_0_rxdata_usr[1]_i_1 ;
  wire \n_0_rxdata_usr[2]_i_1 ;
  wire \n_0_rxdata_usr[3]_i_1 ;
  wire \n_0_rxdata_usr[4]_i_1 ;
  wire \n_0_rxdata_usr[5]_i_1 ;
  wire \n_0_rxdata_usr[6]_i_1 ;
  wire \n_0_rxdata_usr[7]_i_1 ;
  wire n_0_rxdisperr_usr_i_1;
  wire n_0_rxnotintable_usr_i_1;
  wire \n_0_wr_addr[5]_i_1 ;
  wire \n_0_wr_addr_gray_reg[0] ;
  wire \n_0_wr_addr_gray_reg[1] ;
  wire \n_0_wr_addr_gray_reg[2] ;
  wire \n_0_wr_addr_gray_reg[3] ;
  wire \n_0_wr_addr_gray_reg[4] ;
  wire \n_0_wr_addr_plus1[5]_i_1 ;
  wire \n_0_wr_addr_plus2[0]_i_1 ;
  wire \n_0_wr_addr_plus2[1]_i_1 ;
  wire \n_0_wr_addr_plus2[2]_i_1 ;
  wire \n_0_wr_addr_plus2[3]_i_1 ;
  wire \n_0_wr_addr_plus2[4]_i_1 ;
  wire \n_0_wr_addr_plus2[4]_i_2 ;
  wire \n_0_wr_addr_plus2[5]_i_1 ;
  wire \n_0_wr_addr_plus2[5]_i_2 ;
  wire \n_0_wr_addr_plus2_reg[0] ;
  wire \n_0_wr_addr_plus2_reg[5] ;
  wire \n_0_wr_addr_reg[0] ;
  wire \n_0_wr_addr_reg[1] ;
  wire \n_0_wr_addr_reg[2] ;
  wire \n_0_wr_addr_reg[3] ;
  wire \n_0_wr_addr_reg[4] ;
  wire \n_0_wr_addr_reg[5] ;
  wire \n_0_wr_data_reg[0] ;
  wire \n_0_wr_data_reg[10] ;
  wire \n_0_wr_data_reg[11] ;
  wire \n_0_wr_data_reg[12] ;
  wire \n_0_wr_data_reg[16] ;
  wire \n_0_wr_data_reg[17] ;
  wire \n_0_wr_data_reg[18] ;
  wire \n_0_wr_data_reg[19] ;
  wire \n_0_wr_data_reg[1] ;
  wire \n_0_wr_data_reg[20] ;
  wire \n_0_wr_data_reg[21] ;
  wire \n_0_wr_data_reg[22] ;
  wire \n_0_wr_data_reg[23] ;
  wire \n_0_wr_data_reg[25] ;
  wire \n_0_wr_data_reg[26] ;
  wire \n_0_wr_data_reg[28] ;
  wire \n_0_wr_data_reg[2] ;
  wire \n_0_wr_data_reg[3] ;
  wire \n_0_wr_data_reg[4] ;
  wire \n_0_wr_data_reg[5] ;
  wire \n_0_wr_data_reg[6] ;
  wire \n_0_wr_data_reg[7] ;
  wire \n_0_wr_data_reg[9] ;
  wire n_0_wr_enable_i_1;
  wire n_0_wr_enable_i_3;
  wire n_0_wr_enable_i_4;
  wire n_0_wr_enable_i_5;
  wire n_0_wr_enable_i_6;
  wire \n_0_wr_occupancy[3]_i_2 ;
  wire \n_0_wr_occupancy[3]_i_3 ;
  wire \n_0_wr_occupancy[3]_i_4 ;
  wire \n_0_wr_occupancy[3]_i_5 ;
  wire \n_0_wr_occupancy[3]_i_6 ;
  wire \n_0_wr_occupancy[5]_i_2 ;
  wire \n_0_wr_occupancy[5]_i_3 ;
  wire \n_0_wr_occupancy_reg[3]_i_1 ;
  wire \n_1_rd_occupancy_reg[3]_i_1 ;
  wire \n_1_wr_occupancy_reg[3]_i_1 ;
  wire n_2_ram_reg_0_63_12_14;
  wire n_2_ram_reg_0_63_27_29;
  wire n_2_ram_reg_0_63_6_8;
  wire \n_2_rd_occupancy_reg[3]_i_1 ;
  wire \n_2_wr_occupancy_reg[3]_i_1 ;
  wire \n_3_rd_occupancy_reg[3]_i_1 ;
  wire \n_3_rd_occupancy_reg[5]_i_1 ;
  wire \n_3_wr_occupancy_reg[3]_i_1 ;
  wire \n_3_wr_occupancy_reg[5]_i_1 ;
  wire p_0_in;
  wire [4:0]p_0_in1_in1_in;
  wire p_0_in5_in;
  wire [4:0]p_0_in5_out;
  wire p_1_in;
  wire p_1_in18_in;
  wire p_1_in6_in;
  wire p_2_in;
  wire p_2_in21_in;
  wire p_2_in8_in;
  wire p_3_in;
  wire p_3_in10_in;
  wire p_3_in24_in;
  wire p_4_in;
  wire p_4_in12_in;
  wire p_7_in;
  wire p_8_in;
  wire [5:0]plusOp__1;
  wire [4:0]plusOp__2;
  wire [5:0]rd_addr0_in;
  wire [5:0]rd_addr_gray;
  wire [28:0]rd_data;
  wire rd_enable;
  wire [5:0]rd_occupancy;
  wire [5:0]rd_occupancy02_out;
  wire remove_idle;
  wire reset_modified;
  wire rxbuferr;
  wire rxbuferr0;
  wire rxchariscomma;
  wire rxcharisk;
  wire rxdisperr_usr;
  wire rxnotintable_usr;
  wire rxrecreset;
  wire rxreset;
  wire start;
  wire [5:0]wr_addr1_in;
  wire wr_data1;
  wire [28:0]wr_data_reg__0;
  wire wr_enable;
  wire wr_enable1;
  wire [5:1]wr_occupancy;
  wire [5:1]wr_occupancy00_out;
  wire NLW_ram_reg_0_63_0_2_DOD_UNCONNECTED;
  wire NLW_ram_reg_0_63_12_14_DOD_UNCONNECTED;
  wire NLW_ram_reg_0_63_15_17_DOD_UNCONNECTED;
  wire NLW_ram_reg_0_63_18_20_DOD_UNCONNECTED;
  wire NLW_ram_reg_0_63_21_23_DOD_UNCONNECTED;
  wire NLW_ram_reg_0_63_24_26_DOD_UNCONNECTED;
  wire NLW_ram_reg_0_63_27_29_DOD_UNCONNECTED;
  wire NLW_ram_reg_0_63_3_5_DOD_UNCONNECTED;
  wire NLW_ram_reg_0_63_6_8_DOD_UNCONNECTED;
  wire NLW_ram_reg_0_63_9_11_DOD_UNCONNECTED;
  wire [3:1]\NLW_rd_occupancy_reg[5]_i_1_CO_UNCONNECTED ;
  wire [3:2]\NLW_rd_occupancy_reg[5]_i_1_O_UNCONNECTED ;
  wire [0:0]\NLW_wr_occupancy_reg[3]_i_1_O_UNCONNECTED ;
  wire [3:1]\NLW_wr_occupancy_reg[5]_i_1_CO_UNCONNECTED ;
  wire [3:2]\NLW_wr_occupancy_reg[5]_i_1_O_UNCONNECTED ;

(* SOFT_HLUTNM = "soft_lutpair104" *) 
   LUT4 #(
    .INIT(16'h0100)) 
     d16p2_wr_reg_i_1
       (.I0(\n_0_wr_data_reg[0] ),
        .I1(\n_0_wr_data_reg[1] ),
        .I2(\n_0_wr_data_reg[2] ),
        .I3(n_0_d16p2_wr_reg_i_2),
        .O(p_7_in));
LUT6 #(
    .INIT(64'h0000000000040000)) 
     d16p2_wr_reg_i_2
       (.I0(\n_0_wr_data_reg[3] ),
        .I1(\n_0_wr_data_reg[4] ),
        .I2(\n_0_wr_data_reg[7] ),
        .I3(\n_0_wr_data_reg[11] ),
        .I4(\n_0_wr_data_reg[6] ),
        .I5(\n_0_wr_data_reg[5] ),
        .O(n_0_d16p2_wr_reg_i_2));
FDRE d16p2_wr_reg_reg
       (.C(I1),
        .CE(1'b1),
        .D(p_7_in),
        .Q(d16p2_wr_reg),
        .R(rxrecreset));
LUT1 #(
    .INIT(2'h1)) 
     even_i_1
       (.I0(even),
        .O(n_0_even_i_1));
FDSE even_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_even_i_1),
        .Q(even),
        .S(reset_modified));
LUT1 #(
    .INIT(2'h1)) 
     \initialize_counter[0]_i_1 
       (.I0(initialize_counter_reg__0[0]),
        .O(plusOp__2[0]));
(* SOFT_HLUTNM = "soft_lutpair107" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \initialize_counter[1]_i_1 
       (.I0(initialize_counter_reg__0[0]),
        .I1(initialize_counter_reg__0[1]),
        .O(plusOp__2[1]));
(* SOFT_HLUTNM = "soft_lutpair107" *) 
   LUT3 #(
    .INIT(8'h6A)) 
     \initialize_counter[2]_i_1 
       (.I0(initialize_counter_reg__0[2]),
        .I1(initialize_counter_reg__0[0]),
        .I2(initialize_counter_reg__0[1]),
        .O(plusOp__2[2]));
(* SOFT_HLUTNM = "soft_lutpair99" *) 
   LUT4 #(
    .INIT(16'h7F80)) 
     \initialize_counter[3]_i_1 
       (.I0(initialize_counter_reg__0[1]),
        .I1(initialize_counter_reg__0[0]),
        .I2(initialize_counter_reg__0[2]),
        .I3(initialize_counter_reg__0[3]),
        .O(plusOp__2[3]));
LUT6 #(
    .INIT(64'h2AAAAAAAAAAAAAAA)) 
     \initialize_counter[4]_i_1 
       (.I0(initialize_ram),
        .I1(initialize_counter_reg__0[3]),
        .I2(initialize_counter_reg__0[2]),
        .I3(initialize_counter_reg__0[0]),
        .I4(initialize_counter_reg__0[1]),
        .I5(initialize_counter_reg__0[4]),
        .O(initialize_counter0));
(* SOFT_HLUTNM = "soft_lutpair99" *) 
   LUT5 #(
    .INIT(32'h6AAAAAAA)) 
     \initialize_counter[4]_i_2 
       (.I0(initialize_counter_reg__0[4]),
        .I1(initialize_counter_reg__0[1]),
        .I2(initialize_counter_reg__0[0]),
        .I3(initialize_counter_reg__0[2]),
        .I4(initialize_counter_reg__0[3]),
        .O(plusOp__2[4]));
FDRE \initialize_counter_reg[0] 
       (.C(I1),
        .CE(initialize_counter0),
        .D(plusOp__2[0]),
        .Q(initialize_counter_reg__0[0]),
        .R(initialize_ram0));
FDRE \initialize_counter_reg[1] 
       (.C(I1),
        .CE(initialize_counter0),
        .D(plusOp__2[1]),
        .Q(initialize_counter_reg__0[1]),
        .R(initialize_ram0));
FDRE \initialize_counter_reg[2] 
       (.C(I1),
        .CE(initialize_counter0),
        .D(plusOp__2[2]),
        .Q(initialize_counter_reg__0[2]),
        .R(initialize_ram0));
FDRE \initialize_counter_reg[3] 
       (.C(I1),
        .CE(initialize_counter0),
        .D(plusOp__2[3]),
        .Q(initialize_counter_reg__0[3]),
        .R(initialize_ram0));
FDRE \initialize_counter_reg[4] 
       (.C(I1),
        .CE(initialize_counter0),
        .D(plusOp__2[4]),
        .Q(initialize_counter_reg__0[4]),
        .R(initialize_ram0));
LUT6 #(
    .INIT(64'hFFFFFFFF80000000)) 
     initialize_ram_complete_i_1
       (.I0(initialize_counter_reg__0[3]),
        .I1(initialize_counter_reg__0[2]),
        .I2(initialize_counter_reg__0[0]),
        .I3(initialize_counter_reg__0[1]),
        .I4(initialize_counter_reg__0[4]),
        .I5(initialize_ram_complete),
        .O(n_0_initialize_ram_complete_i_1));
LUT2 #(
    .INIT(4'h2)) 
     initialize_ram_complete_pulse_i_1
       (.I0(initialize_ram_complete),
        .I1(initialize_ram_complete_reg__0),
        .O(initialize_ram_complete_pulse0));
FDRE initialize_ram_complete_pulse_reg
       (.C(I1),
        .CE(1'b1),
        .D(initialize_ram_complete_pulse0),
        .Q(initialize_ram_complete_pulse),
        .R(initialize_ram0));
FDRE initialize_ram_complete_reg
       (.C(I1),
        .CE(1'b1),
        .D(n_0_initialize_ram_complete_i_1),
        .Q(initialize_ram_complete),
        .R(initialize_ram0));
LUT2 #(
    .INIT(4'hE)) 
     initialize_ram_complete_reg_i_1
       (.I0(start),
        .I1(rxrecreset),
        .O(initialize_ram0));
FDRE initialize_ram_complete_reg_reg
       (.C(I1),
        .CE(1'b1),
        .D(initialize_ram_complete),
        .Q(initialize_ram_complete_reg__0),
        .R(initialize_ram0));
FDRE initialize_ram_complete_sync_reg1_reg
       (.C(CLK),
        .CE(1'b1),
        .D(data_out),
        .Q(initialize_ram_complete_sync_reg1),
        .R(1'b0));
LUT2 #(
    .INIT(4'h2)) 
     initialize_ram_complete_sync_ris_edg_i_1
       (.I0(data_out),
        .I1(initialize_ram_complete_sync_reg1),
        .O(n_0_initialize_ram_complete_sync_ris_edg_i_1));
FDRE #(
    .INIT(1'b0)) 
     initialize_ram_complete_sync_ris_edg_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_initialize_ram_complete_sync_ris_edg_i_1),
        .Q(initialize_ram_complete_sync_ris_edg),
        .R(1'b0));
LUT2 #(
    .INIT(4'h4)) 
     initialize_ram_i_1
       (.I0(initialize_ram_complete),
        .I1(initialize_ram),
        .O(n_0_initialize_ram_i_1));
FDSE initialize_ram_reg
       (.C(I1),
        .CE(1'b1),
        .D(n_0_initialize_ram_i_1),
        .Q(initialize_ram),
        .S(initialize_ram0));
LUT6 #(
    .INIT(64'h0000000000010000)) 
     insert_idle_i_1
       (.I0(n_0_rd_enable_i_2),
        .I1(n_0_rd_enable_i_3),
        .I2(n_0_rd_enable_i_4),
        .I3(n_0_rd_enable_i_5),
        .I4(even),
        .I5(reset_modified),
        .O(n_0_insert_idle_i_1));
FDRE insert_idle_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_insert_idle_i_1),
        .Q(insert_idle),
        .R(1'b0));
FDRE insert_idle_reg_reg
       (.C(CLK),
        .CE(1'b1),
        .D(insert_idle),
        .Q(insert_idle_reg__0),
        .R(reset_modified));
(* SOFT_HLUTNM = "soft_lutpair102" *) 
   LUT4 #(
    .INIT(16'h0400)) 
     k28p5_wr_reg_i_1
       (.I0(\n_0_wr_data_reg[16] ),
        .I1(\n_0_wr_data_reg[18] ),
        .I2(\n_0_wr_data_reg[17] ),
        .I3(n_0_k28p5_wr_reg_i_2),
        .O(p_8_in));
LUT6 #(
    .INIT(64'h0000000080000000)) 
     k28p5_wr_reg_i_2
       (.I0(\n_0_wr_data_reg[20] ),
        .I1(\n_0_wr_data_reg[19] ),
        .I2(\n_0_wr_data_reg[23] ),
        .I3(p_0_in5_in),
        .I4(\n_0_wr_data_reg[21] ),
        .I5(\n_0_wr_data_reg[22] ),
        .O(n_0_k28p5_wr_reg_i_2));
FDRE k28p5_wr_reg_reg
       (.C(I1),
        .CE(1'b1),
        .D(p_8_in),
        .Q(k28p5_wr_reg),
        .R(rxrecreset));
RAM64M ram_reg_0_63_0_2
       (.ADDRA({\n_0_rd_addr_reg[5] ,\n_0_rd_addr_reg[4] ,\n_0_rd_addr_reg[3] ,\n_0_rd_addr_reg[2] ,\n_0_rd_addr_reg[1] ,\n_0_rd_addr_reg[0] }),
        .ADDRB({\n_0_rd_addr_reg[5] ,\n_0_rd_addr_reg[4] ,\n_0_rd_addr_reg[3] ,\n_0_rd_addr_reg[2] ,\n_0_rd_addr_reg[1] ,\n_0_rd_addr_reg[0] }),
        .ADDRC({\n_0_rd_addr_reg[5] ,\n_0_rd_addr_reg[4] ,\n_0_rd_addr_reg[3] ,\n_0_rd_addr_reg[2] ,\n_0_rd_addr_reg[1] ,\n_0_rd_addr_reg[0] }),
        .ADDRD({\n_0_wr_addr_reg[5] ,\n_0_wr_addr_reg[4] ,\n_0_wr_addr_reg[3] ,\n_0_wr_addr_reg[2] ,\n_0_wr_addr_reg[1] ,\n_0_wr_addr_reg[0] }),
        .DIA(wr_data_reg__0[0]),
        .DIB(wr_data_reg__0[1]),
        .DIC(wr_data_reg__0[2]),
        .DID(1'b0),
        .DOA(dpo[0]),
        .DOB(dpo[1]),
        .DOC(dpo[2]),
        .DOD(NLW_ram_reg_0_63_0_2_DOD_UNCONNECTED),
        .WCLK(I1),
        .WE(wr_enable));
RAM64M ram_reg_0_63_12_14
       (.ADDRA({\n_0_rd_addr_reg[5] ,\n_0_rd_addr_reg[4] ,\n_0_rd_addr_reg[3] ,\n_0_rd_addr_reg[2] ,\n_0_rd_addr_reg[1] ,\n_0_rd_addr_reg[0] }),
        .ADDRB({\n_0_rd_addr_reg[5] ,\n_0_rd_addr_reg[4] ,\n_0_rd_addr_reg[3] ,\n_0_rd_addr_reg[2] ,\n_0_rd_addr_reg[1] ,\n_0_rd_addr_reg[0] }),
        .ADDRC({\n_0_rd_addr_reg[5] ,\n_0_rd_addr_reg[4] ,\n_0_rd_addr_reg[3] ,\n_0_rd_addr_reg[2] ,\n_0_rd_addr_reg[1] ,\n_0_rd_addr_reg[0] }),
        .ADDRD({\n_0_wr_addr_reg[5] ,\n_0_wr_addr_reg[4] ,\n_0_wr_addr_reg[3] ,\n_0_wr_addr_reg[2] ,\n_0_wr_addr_reg[1] ,\n_0_wr_addr_reg[0] }),
        .DIA(wr_data_reg__0[12]),
        .DIB(wr_data_reg__0[13]),
        .DIC(1'b0),
        .DID(1'b0),
        .DOA(dpo[12]),
        .DOB(dpo[13]),
        .DOC(n_2_ram_reg_0_63_12_14),
        .DOD(NLW_ram_reg_0_63_12_14_DOD_UNCONNECTED),
        .WCLK(I1),
        .WE(wr_enable));
RAM64M ram_reg_0_63_15_17
       (.ADDRA({\n_0_rd_addr_reg[5] ,\n_0_rd_addr_reg[4] ,\n_0_rd_addr_reg[3] ,\n_0_rd_addr_reg[2] ,\n_0_rd_addr_reg[1] ,\n_0_rd_addr_reg[0] }),
        .ADDRB({\n_0_rd_addr_reg[5] ,\n_0_rd_addr_reg[4] ,\n_0_rd_addr_reg[3] ,\n_0_rd_addr_reg[2] ,\n_0_rd_addr_reg[1] ,\n_0_rd_addr_reg[0] }),
        .ADDRC({\n_0_rd_addr_reg[5] ,\n_0_rd_addr_reg[4] ,\n_0_rd_addr_reg[3] ,\n_0_rd_addr_reg[2] ,\n_0_rd_addr_reg[1] ,\n_0_rd_addr_reg[0] }),
        .ADDRD({\n_0_wr_addr_reg[5] ,\n_0_wr_addr_reg[4] ,\n_0_wr_addr_reg[3] ,\n_0_wr_addr_reg[2] ,\n_0_wr_addr_reg[1] ,\n_0_wr_addr_reg[0] }),
        .DIA(1'b0),
        .DIB(wr_data_reg__0[16]),
        .DIC(wr_data_reg__0[17]),
        .DID(1'b0),
        .DOA(n_0_ram_reg_0_63_15_17),
        .DOB(dpo[16]),
        .DOC(dpo[17]),
        .DOD(NLW_ram_reg_0_63_15_17_DOD_UNCONNECTED),
        .WCLK(I1),
        .WE(wr_enable));
RAM64M ram_reg_0_63_18_20
       (.ADDRA({\n_0_rd_addr_reg[5] ,\n_0_rd_addr_reg[4] ,\n_0_rd_addr_reg[3] ,\n_0_rd_addr_reg[2] ,\n_0_rd_addr_reg[1] ,\n_0_rd_addr_reg[0] }),
        .ADDRB({\n_0_rd_addr_reg[5] ,\n_0_rd_addr_reg[4] ,\n_0_rd_addr_reg[3] ,\n_0_rd_addr_reg[2] ,\n_0_rd_addr_reg[1] ,\n_0_rd_addr_reg[0] }),
        .ADDRC({\n_0_rd_addr_reg[5] ,\n_0_rd_addr_reg[4] ,\n_0_rd_addr_reg[3] ,\n_0_rd_addr_reg[2] ,\n_0_rd_addr_reg[1] ,\n_0_rd_addr_reg[0] }),
        .ADDRD({\n_0_wr_addr_reg[5] ,\n_0_wr_addr_reg[4] ,\n_0_wr_addr_reg[3] ,\n_0_wr_addr_reg[2] ,\n_0_wr_addr_reg[1] ,\n_0_wr_addr_reg[0] }),
        .DIA(wr_data_reg__0[18]),
        .DIB(wr_data_reg__0[19]),
        .DIC(wr_data_reg__0[20]),
        .DID(1'b0),
        .DOA(dpo[18]),
        .DOB(dpo[19]),
        .DOC(dpo[20]),
        .DOD(NLW_ram_reg_0_63_18_20_DOD_UNCONNECTED),
        .WCLK(I1),
        .WE(wr_enable));
RAM64M ram_reg_0_63_21_23
       (.ADDRA({\n_0_rd_addr_reg[5] ,\n_0_rd_addr_reg[4] ,\n_0_rd_addr_reg[3] ,\n_0_rd_addr_reg[2] ,\n_0_rd_addr_reg[1] ,\n_0_rd_addr_reg[0] }),
        .ADDRB({\n_0_rd_addr_reg[5] ,\n_0_rd_addr_reg[4] ,\n_0_rd_addr_reg[3] ,\n_0_rd_addr_reg[2] ,\n_0_rd_addr_reg[1] ,\n_0_rd_addr_reg[0] }),
        .ADDRC({\n_0_rd_addr_reg[5] ,\n_0_rd_addr_reg[4] ,\n_0_rd_addr_reg[3] ,\n_0_rd_addr_reg[2] ,\n_0_rd_addr_reg[1] ,\n_0_rd_addr_reg[0] }),
        .ADDRD({\n_0_wr_addr_reg[5] ,\n_0_wr_addr_reg[4] ,\n_0_wr_addr_reg[3] ,\n_0_wr_addr_reg[2] ,\n_0_wr_addr_reg[1] ,\n_0_wr_addr_reg[0] }),
        .DIA(wr_data_reg__0[21]),
        .DIB(wr_data_reg__0[22]),
        .DIC(wr_data_reg__0[23]),
        .DID(1'b0),
        .DOA(dpo[21]),
        .DOB(dpo[22]),
        .DOC(dpo[23]),
        .DOD(NLW_ram_reg_0_63_21_23_DOD_UNCONNECTED),
        .WCLK(I1),
        .WE(wr_enable));
RAM64M ram_reg_0_63_24_26
       (.ADDRA({\n_0_rd_addr_reg[5] ,\n_0_rd_addr_reg[4] ,\n_0_rd_addr_reg[3] ,\n_0_rd_addr_reg[2] ,\n_0_rd_addr_reg[1] ,\n_0_rd_addr_reg[0] }),
        .ADDRB({\n_0_rd_addr_reg[5] ,\n_0_rd_addr_reg[4] ,\n_0_rd_addr_reg[3] ,\n_0_rd_addr_reg[2] ,\n_0_rd_addr_reg[1] ,\n_0_rd_addr_reg[0] }),
        .ADDRC({\n_0_rd_addr_reg[5] ,\n_0_rd_addr_reg[4] ,\n_0_rd_addr_reg[3] ,\n_0_rd_addr_reg[2] ,\n_0_rd_addr_reg[1] ,\n_0_rd_addr_reg[0] }),
        .ADDRD({\n_0_wr_addr_reg[5] ,\n_0_wr_addr_reg[4] ,\n_0_wr_addr_reg[3] ,\n_0_wr_addr_reg[2] ,\n_0_wr_addr_reg[1] ,\n_0_wr_addr_reg[0] }),
        .DIA(1'b0),
        .DIB(wr_data_reg__0[25]),
        .DIC(wr_data_reg__0[26]),
        .DID(1'b0),
        .DOA(n_0_ram_reg_0_63_24_26),
        .DOB(dpo[25]),
        .DOC(dpo[26]),
        .DOD(NLW_ram_reg_0_63_24_26_DOD_UNCONNECTED),
        .WCLK(I1),
        .WE(wr_enable));
RAM64M ram_reg_0_63_27_29
       (.ADDRA({\n_0_rd_addr_reg[5] ,\n_0_rd_addr_reg[4] ,\n_0_rd_addr_reg[3] ,\n_0_rd_addr_reg[2] ,\n_0_rd_addr_reg[1] ,\n_0_rd_addr_reg[0] }),
        .ADDRB({\n_0_rd_addr_reg[5] ,\n_0_rd_addr_reg[4] ,\n_0_rd_addr_reg[3] ,\n_0_rd_addr_reg[2] ,\n_0_rd_addr_reg[1] ,\n_0_rd_addr_reg[0] }),
        .ADDRC({\n_0_rd_addr_reg[5] ,\n_0_rd_addr_reg[4] ,\n_0_rd_addr_reg[3] ,\n_0_rd_addr_reg[2] ,\n_0_rd_addr_reg[1] ,\n_0_rd_addr_reg[0] }),
        .ADDRD({\n_0_wr_addr_reg[5] ,\n_0_wr_addr_reg[4] ,\n_0_wr_addr_reg[3] ,\n_0_wr_addr_reg[2] ,\n_0_wr_addr_reg[1] ,\n_0_wr_addr_reg[0] }),
        .DIA(wr_data_reg__0[27]),
        .DIB(wr_data_reg__0[28]),
        .DIC(1'b0),
        .DID(1'b0),
        .DOA(dpo[27]),
        .DOB(dpo[28]),
        .DOC(n_2_ram_reg_0_63_27_29),
        .DOD(NLW_ram_reg_0_63_27_29_DOD_UNCONNECTED),
        .WCLK(I1),
        .WE(wr_enable));
RAM64M ram_reg_0_63_3_5
       (.ADDRA({\n_0_rd_addr_reg[5] ,\n_0_rd_addr_reg[4] ,\n_0_rd_addr_reg[3] ,\n_0_rd_addr_reg[2] ,\n_0_rd_addr_reg[1] ,\n_0_rd_addr_reg[0] }),
        .ADDRB({\n_0_rd_addr_reg[5] ,\n_0_rd_addr_reg[4] ,\n_0_rd_addr_reg[3] ,\n_0_rd_addr_reg[2] ,\n_0_rd_addr_reg[1] ,\n_0_rd_addr_reg[0] }),
        .ADDRC({\n_0_rd_addr_reg[5] ,\n_0_rd_addr_reg[4] ,\n_0_rd_addr_reg[3] ,\n_0_rd_addr_reg[2] ,\n_0_rd_addr_reg[1] ,\n_0_rd_addr_reg[0] }),
        .ADDRD({\n_0_wr_addr_reg[5] ,\n_0_wr_addr_reg[4] ,\n_0_wr_addr_reg[3] ,\n_0_wr_addr_reg[2] ,\n_0_wr_addr_reg[1] ,\n_0_wr_addr_reg[0] }),
        .DIA(wr_data_reg__0[3]),
        .DIB(wr_data_reg__0[4]),
        .DIC(wr_data_reg__0[5]),
        .DID(1'b0),
        .DOA(dpo[3]),
        .DOB(dpo[4]),
        .DOC(dpo[5]),
        .DOD(NLW_ram_reg_0_63_3_5_DOD_UNCONNECTED),
        .WCLK(I1),
        .WE(wr_enable));
RAM64M ram_reg_0_63_6_8
       (.ADDRA({\n_0_rd_addr_reg[5] ,\n_0_rd_addr_reg[4] ,\n_0_rd_addr_reg[3] ,\n_0_rd_addr_reg[2] ,\n_0_rd_addr_reg[1] ,\n_0_rd_addr_reg[0] }),
        .ADDRB({\n_0_rd_addr_reg[5] ,\n_0_rd_addr_reg[4] ,\n_0_rd_addr_reg[3] ,\n_0_rd_addr_reg[2] ,\n_0_rd_addr_reg[1] ,\n_0_rd_addr_reg[0] }),
        .ADDRC({\n_0_rd_addr_reg[5] ,\n_0_rd_addr_reg[4] ,\n_0_rd_addr_reg[3] ,\n_0_rd_addr_reg[2] ,\n_0_rd_addr_reg[1] ,\n_0_rd_addr_reg[0] }),
        .ADDRD({\n_0_wr_addr_reg[5] ,\n_0_wr_addr_reg[4] ,\n_0_wr_addr_reg[3] ,\n_0_wr_addr_reg[2] ,\n_0_wr_addr_reg[1] ,\n_0_wr_addr_reg[0] }),
        .DIA(wr_data_reg__0[6]),
        .DIB(wr_data_reg__0[7]),
        .DIC(1'b0),
        .DID(1'b0),
        .DOA(dpo[6]),
        .DOB(dpo[7]),
        .DOC(n_2_ram_reg_0_63_6_8),
        .DOD(NLW_ram_reg_0_63_6_8_DOD_UNCONNECTED),
        .WCLK(I1),
        .WE(wr_enable));
RAM64M ram_reg_0_63_9_11
       (.ADDRA({\n_0_rd_addr_reg[5] ,\n_0_rd_addr_reg[4] ,\n_0_rd_addr_reg[3] ,\n_0_rd_addr_reg[2] ,\n_0_rd_addr_reg[1] ,\n_0_rd_addr_reg[0] }),
        .ADDRB({\n_0_rd_addr_reg[5] ,\n_0_rd_addr_reg[4] ,\n_0_rd_addr_reg[3] ,\n_0_rd_addr_reg[2] ,\n_0_rd_addr_reg[1] ,\n_0_rd_addr_reg[0] }),
        .ADDRC({\n_0_rd_addr_reg[5] ,\n_0_rd_addr_reg[4] ,\n_0_rd_addr_reg[3] ,\n_0_rd_addr_reg[2] ,\n_0_rd_addr_reg[1] ,\n_0_rd_addr_reg[0] }),
        .ADDRD({\n_0_wr_addr_reg[5] ,\n_0_wr_addr_reg[4] ,\n_0_wr_addr_reg[3] ,\n_0_wr_addr_reg[2] ,\n_0_wr_addr_reg[1] ,\n_0_wr_addr_reg[0] }),
        .DIA(wr_data_reg__0[9]),
        .DIB(wr_data_reg__0[10]),
        .DIC(wr_data_reg__0[11]),
        .DID(1'b0),
        .DOA(dpo[9]),
        .DOB(dpo[10]),
        .DOC(dpo[11]),
        .DOD(NLW_ram_reg_0_63_9_11_DOD_UNCONNECTED),
        .WCLK(I1),
        .WE(wr_enable));
(* SOFT_HLUTNM = "soft_lutpair108" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \rd_addr_gray[0]_i_1 
       (.I0(\n_0_rd_addr_plus2_reg[0] ),
        .I1(p_1_in),
        .O(\n_0_rd_addr_gray[0]_i_1 ));
LUT2 #(
    .INIT(4'h6)) 
     \rd_addr_gray[1]_i_1 
       (.I0(p_1_in),
        .I1(p_2_in),
        .O(\n_0_rd_addr_gray[1]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair115" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \rd_addr_gray[2]_i_1 
       (.I0(p_2_in),
        .I1(p_3_in),
        .O(\n_0_rd_addr_gray[2]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair115" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \rd_addr_gray[3]_i_1 
       (.I0(p_3_in),
        .I1(p_4_in),
        .O(\n_0_rd_addr_gray[3]_i_1 ));
LUT2 #(
    .INIT(4'h6)) 
     \rd_addr_gray[4]_i_1 
       (.I0(p_4_in),
        .I1(\n_0_rd_addr_plus2_reg[5] ),
        .O(\n_0_rd_addr_gray[4]_i_1 ));
FDRE \rd_addr_gray_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_rd_addr_gray[0]_i_1 ),
        .Q(rd_addr_gray[0]),
        .R(reset_modified));
FDRE \rd_addr_gray_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_rd_addr_gray[1]_i_1 ),
        .Q(rd_addr_gray[1]),
        .R(reset_modified));
FDRE \rd_addr_gray_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_rd_addr_gray[2]_i_1 ),
        .Q(rd_addr_gray[2]),
        .R(reset_modified));
FDRE \rd_addr_gray_reg[3] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_rd_addr_gray[3]_i_1 ),
        .Q(rd_addr_gray[3]),
        .R(reset_modified));
FDRE \rd_addr_gray_reg[4] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_rd_addr_gray[4]_i_1 ),
        .Q(rd_addr_gray[4]),
        .R(reset_modified));
FDRE \rd_addr_gray_reg[5] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_rd_addr_plus2_reg[5] ),
        .Q(rd_addr_gray[5]),
        .R(reset_modified));
FDSE \rd_addr_plus1_reg[0] 
       (.C(CLK),
        .CE(rd_enable),
        .D(\n_0_rd_addr_plus2_reg[0] ),
        .Q(rd_addr0_in[0]),
        .S(reset_modified));
FDRE \rd_addr_plus1_reg[1] 
       (.C(CLK),
        .CE(rd_enable),
        .D(p_1_in),
        .Q(rd_addr0_in[1]),
        .R(reset_modified));
FDRE \rd_addr_plus1_reg[2] 
       (.C(CLK),
        .CE(rd_enable),
        .D(p_2_in),
        .Q(rd_addr0_in[2]),
        .R(reset_modified));
FDRE \rd_addr_plus1_reg[3] 
       (.C(CLK),
        .CE(rd_enable),
        .D(p_3_in),
        .Q(rd_addr0_in[3]),
        .R(reset_modified));
FDRE \rd_addr_plus1_reg[4] 
       (.C(CLK),
        .CE(rd_enable),
        .D(p_4_in),
        .Q(rd_addr0_in[4]),
        .R(reset_modified));
FDRE \rd_addr_plus1_reg[5] 
       (.C(CLK),
        .CE(rd_enable),
        .D(\n_0_rd_addr_plus2_reg[5] ),
        .Q(rd_addr0_in[5]),
        .R(reset_modified));
LUT1 #(
    .INIT(2'h1)) 
     \rd_addr_plus2[0]_i_1 
       (.I0(\n_0_rd_addr_plus2_reg[0] ),
        .O(plusOp__1[0]));
(* SOFT_HLUTNM = "soft_lutpair108" *) 
   LUT3 #(
    .INIT(8'h6A)) 
     \rd_addr_plus2[2]_i_1 
       (.I0(p_2_in),
        .I1(p_1_in),
        .I2(\n_0_rd_addr_plus2_reg[0] ),
        .O(plusOp__1[2]));
(* SOFT_HLUTNM = "soft_lutpair100" *) 
   LUT4 #(
    .INIT(16'h6AAA)) 
     \rd_addr_plus2[3]_i_1 
       (.I0(p_3_in),
        .I1(\n_0_rd_addr_plus2_reg[0] ),
        .I2(p_1_in),
        .I3(p_2_in),
        .O(plusOp__1[3]));
(* SOFT_HLUTNM = "soft_lutpair100" *) 
   LUT5 #(
    .INIT(32'h6AAAAAAA)) 
     \rd_addr_plus2[4]_i_1 
       (.I0(p_4_in),
        .I1(p_2_in),
        .I2(p_1_in),
        .I3(\n_0_rd_addr_plus2_reg[0] ),
        .I4(p_3_in),
        .O(plusOp__1[4]));
LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
     \rd_addr_plus2[5]_i_1 
       (.I0(\n_0_rd_addr_plus2_reg[5] ),
        .I1(p_3_in),
        .I2(\n_0_rd_addr_plus2_reg[0] ),
        .I3(p_1_in),
        .I4(p_2_in),
        .I5(p_4_in),
        .O(plusOp__1[5]));
FDRE \rd_addr_plus2_reg[0] 
       (.C(CLK),
        .CE(rd_enable),
        .D(plusOp__1[0]),
        .Q(\n_0_rd_addr_plus2_reg[0] ),
        .R(reset_modified));
FDSE \rd_addr_plus2_reg[1] 
       (.C(CLK),
        .CE(rd_enable),
        .D(\n_0_rd_addr_gray[0]_i_1 ),
        .Q(p_1_in),
        .S(reset_modified));
FDRE \rd_addr_plus2_reg[2] 
       (.C(CLK),
        .CE(rd_enable),
        .D(plusOp__1[2]),
        .Q(p_2_in),
        .R(reset_modified));
FDRE \rd_addr_plus2_reg[3] 
       (.C(CLK),
        .CE(rd_enable),
        .D(plusOp__1[3]),
        .Q(p_3_in),
        .R(reset_modified));
FDRE \rd_addr_plus2_reg[4] 
       (.C(CLK),
        .CE(rd_enable),
        .D(plusOp__1[4]),
        .Q(p_4_in),
        .R(reset_modified));
FDRE \rd_addr_plus2_reg[5] 
       (.C(CLK),
        .CE(rd_enable),
        .D(plusOp__1[5]),
        .Q(\n_0_rd_addr_plus2_reg[5] ),
        .R(reset_modified));
FDRE \rd_addr_reg[0] 
       (.C(CLK),
        .CE(rd_enable),
        .D(rd_addr0_in[0]),
        .Q(\n_0_rd_addr_reg[0] ),
        .R(reset_modified));
FDRE \rd_addr_reg[1] 
       (.C(CLK),
        .CE(rd_enable),
        .D(rd_addr0_in[1]),
        .Q(\n_0_rd_addr_reg[1] ),
        .R(reset_modified));
FDRE \rd_addr_reg[2] 
       (.C(CLK),
        .CE(rd_enable),
        .D(rd_addr0_in[2]),
        .Q(\n_0_rd_addr_reg[2] ),
        .R(reset_modified));
FDRE \rd_addr_reg[3] 
       (.C(CLK),
        .CE(rd_enable),
        .D(rd_addr0_in[3]),
        .Q(\n_0_rd_addr_reg[3] ),
        .R(reset_modified));
FDRE \rd_addr_reg[4] 
       (.C(CLK),
        .CE(rd_enable),
        .D(rd_addr0_in[4]),
        .Q(\n_0_rd_addr_reg[4] ),
        .R(reset_modified));
FDRE \rd_addr_reg[5] 
       (.C(CLK),
        .CE(rd_enable),
        .D(rd_addr0_in[5]),
        .Q(\n_0_rd_addr_reg[5] ),
        .R(reset_modified));
FDRE \rd_data_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(dpo[0]),
        .Q(rd_data[0]),
        .R(reset_modified));
FDRE \rd_data_reg[10] 
       (.C(CLK),
        .CE(1'b1),
        .D(dpo[10]),
        .Q(rd_data[10]),
        .R(reset_modified));
FDRE \rd_data_reg[11] 
       (.C(CLK),
        .CE(1'b1),
        .D(dpo[11]),
        .Q(rd_data[11]),
        .R(reset_modified));
FDRE \rd_data_reg[12] 
       (.C(CLK),
        .CE(1'b1),
        .D(dpo[12]),
        .Q(rd_data[12]),
        .R(reset_modified));
FDRE \rd_data_reg[13] 
       (.C(CLK),
        .CE(1'b1),
        .D(dpo[13]),
        .Q(rd_data[13]),
        .R(reset_modified));
FDRE \rd_data_reg[16] 
       (.C(CLK),
        .CE(1'b1),
        .D(dpo[16]),
        .Q(rd_data[16]),
        .R(reset_modified));
FDRE \rd_data_reg[17] 
       (.C(CLK),
        .CE(1'b1),
        .D(dpo[17]),
        .Q(rd_data[17]),
        .R(reset_modified));
FDRE \rd_data_reg[18] 
       (.C(CLK),
        .CE(1'b1),
        .D(dpo[18]),
        .Q(rd_data[18]),
        .R(reset_modified));
FDRE \rd_data_reg[19] 
       (.C(CLK),
        .CE(1'b1),
        .D(dpo[19]),
        .Q(rd_data[19]),
        .R(reset_modified));
FDRE \rd_data_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(dpo[1]),
        .Q(rd_data[1]),
        .R(reset_modified));
FDRE \rd_data_reg[20] 
       (.C(CLK),
        .CE(1'b1),
        .D(dpo[20]),
        .Q(rd_data[20]),
        .R(reset_modified));
FDRE \rd_data_reg[21] 
       (.C(CLK),
        .CE(1'b1),
        .D(dpo[21]),
        .Q(rd_data[21]),
        .R(reset_modified));
FDRE \rd_data_reg[22] 
       (.C(CLK),
        .CE(1'b1),
        .D(dpo[22]),
        .Q(rd_data[22]),
        .R(reset_modified));
FDRE \rd_data_reg[23] 
       (.C(CLK),
        .CE(1'b1),
        .D(dpo[23]),
        .Q(rd_data[23]),
        .R(reset_modified));
FDRE \rd_data_reg[25] 
       (.C(CLK),
        .CE(1'b1),
        .D(dpo[25]),
        .Q(rd_data[25]),
        .R(reset_modified));
FDRE \rd_data_reg[26] 
       (.C(CLK),
        .CE(1'b1),
        .D(dpo[26]),
        .Q(rd_data[26]),
        .R(reset_modified));
FDRE \rd_data_reg[27] 
       (.C(CLK),
        .CE(1'b1),
        .D(dpo[27]),
        .Q(rd_data[27]),
        .R(reset_modified));
FDRE \rd_data_reg[28] 
       (.C(CLK),
        .CE(1'b1),
        .D(dpo[28]),
        .Q(rd_data[28]),
        .R(reset_modified));
FDRE \rd_data_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .D(dpo[2]),
        .Q(rd_data[2]),
        .R(reset_modified));
FDRE \rd_data_reg[3] 
       (.C(CLK),
        .CE(1'b1),
        .D(dpo[3]),
        .Q(rd_data[3]),
        .R(reset_modified));
FDRE \rd_data_reg[4] 
       (.C(CLK),
        .CE(1'b1),
        .D(dpo[4]),
        .Q(rd_data[4]),
        .R(reset_modified));
FDRE \rd_data_reg[5] 
       (.C(CLK),
        .CE(1'b1),
        .D(dpo[5]),
        .Q(rd_data[5]),
        .R(reset_modified));
FDRE \rd_data_reg[6] 
       (.C(CLK),
        .CE(1'b1),
        .D(dpo[6]),
        .Q(rd_data[6]),
        .R(reset_modified));
FDRE \rd_data_reg[7] 
       (.C(CLK),
        .CE(1'b1),
        .D(dpo[7]),
        .Q(rd_data[7]),
        .R(reset_modified));
FDRE \rd_data_reg[9] 
       (.C(CLK),
        .CE(1'b1),
        .D(dpo[9]),
        .Q(rd_data[9]),
        .R(reset_modified));
FDRE \rd_data_reg_reg[0] 
       (.C(CLK),
        .CE(rd_enable),
        .D(rd_data[0]),
        .Q(\n_0_rd_data_reg_reg[0] ),
        .R(reset_modified));
FDRE \rd_data_reg_reg[10] 
       (.C(CLK),
        .CE(rd_enable),
        .D(rd_data[10]),
        .Q(\n_0_rd_data_reg_reg[10] ),
        .R(reset_modified));
FDRE \rd_data_reg_reg[11] 
       (.C(CLK),
        .CE(rd_enable),
        .D(rd_data[11]),
        .Q(\n_0_rd_data_reg_reg[11] ),
        .R(reset_modified));
FDRE \rd_data_reg_reg[12] 
       (.C(CLK),
        .CE(rd_enable),
        .D(rd_data[12]),
        .Q(\n_0_rd_data_reg_reg[12] ),
        .R(reset_modified));
FDRE \rd_data_reg_reg[13] 
       (.C(CLK),
        .CE(rd_enable),
        .D(rd_data[13]),
        .Q(\n_0_rd_data_reg_reg[13] ),
        .R(reset_modified));
FDRE \rd_data_reg_reg[16] 
       (.C(CLK),
        .CE(rd_enable),
        .D(rd_data[16]),
        .Q(\n_0_rd_data_reg_reg[16] ),
        .R(reset_modified));
FDRE \rd_data_reg_reg[17] 
       (.C(CLK),
        .CE(rd_enable),
        .D(rd_data[17]),
        .Q(\n_0_rd_data_reg_reg[17] ),
        .R(reset_modified));
FDRE \rd_data_reg_reg[18] 
       (.C(CLK),
        .CE(rd_enable),
        .D(rd_data[18]),
        .Q(\n_0_rd_data_reg_reg[18] ),
        .R(reset_modified));
FDRE \rd_data_reg_reg[19] 
       (.C(CLK),
        .CE(rd_enable),
        .D(rd_data[19]),
        .Q(\n_0_rd_data_reg_reg[19] ),
        .R(reset_modified));
FDRE \rd_data_reg_reg[1] 
       (.C(CLK),
        .CE(rd_enable),
        .D(rd_data[1]),
        .Q(\n_0_rd_data_reg_reg[1] ),
        .R(reset_modified));
FDRE \rd_data_reg_reg[20] 
       (.C(CLK),
        .CE(rd_enable),
        .D(rd_data[20]),
        .Q(\n_0_rd_data_reg_reg[20] ),
        .R(reset_modified));
FDRE \rd_data_reg_reg[21] 
       (.C(CLK),
        .CE(rd_enable),
        .D(rd_data[21]),
        .Q(\n_0_rd_data_reg_reg[21] ),
        .R(reset_modified));
FDRE \rd_data_reg_reg[22] 
       (.C(CLK),
        .CE(rd_enable),
        .D(rd_data[22]),
        .Q(\n_0_rd_data_reg_reg[22] ),
        .R(reset_modified));
FDRE \rd_data_reg_reg[23] 
       (.C(CLK),
        .CE(rd_enable),
        .D(rd_data[23]),
        .Q(\n_0_rd_data_reg_reg[23] ),
        .R(reset_modified));
FDRE \rd_data_reg_reg[25] 
       (.C(CLK),
        .CE(rd_enable),
        .D(rd_data[25]),
        .Q(\n_0_rd_data_reg_reg[25] ),
        .R(reset_modified));
FDRE \rd_data_reg_reg[26] 
       (.C(CLK),
        .CE(rd_enable),
        .D(rd_data[26]),
        .Q(\n_0_rd_data_reg_reg[26] ),
        .R(reset_modified));
FDRE \rd_data_reg_reg[27] 
       (.C(CLK),
        .CE(rd_enable),
        .D(rd_data[27]),
        .Q(\n_0_rd_data_reg_reg[27] ),
        .R(reset_modified));
FDRE \rd_data_reg_reg[28] 
       (.C(CLK),
        .CE(rd_enable),
        .D(rd_data[28]),
        .Q(\n_0_rd_data_reg_reg[28] ),
        .R(reset_modified));
FDRE \rd_data_reg_reg[2] 
       (.C(CLK),
        .CE(rd_enable),
        .D(rd_data[2]),
        .Q(\n_0_rd_data_reg_reg[2] ),
        .R(reset_modified));
FDRE \rd_data_reg_reg[3] 
       (.C(CLK),
        .CE(rd_enable),
        .D(rd_data[3]),
        .Q(\n_0_rd_data_reg_reg[3] ),
        .R(reset_modified));
FDRE \rd_data_reg_reg[4] 
       (.C(CLK),
        .CE(rd_enable),
        .D(rd_data[4]),
        .Q(\n_0_rd_data_reg_reg[4] ),
        .R(reset_modified));
FDRE \rd_data_reg_reg[5] 
       (.C(CLK),
        .CE(rd_enable),
        .D(rd_data[5]),
        .Q(\n_0_rd_data_reg_reg[5] ),
        .R(reset_modified));
FDRE \rd_data_reg_reg[6] 
       (.C(CLK),
        .CE(rd_enable),
        .D(rd_data[6]),
        .Q(\n_0_rd_data_reg_reg[6] ),
        .R(reset_modified));
FDRE \rd_data_reg_reg[7] 
       (.C(CLK),
        .CE(rd_enable),
        .D(rd_data[7]),
        .Q(\n_0_rd_data_reg_reg[7] ),
        .R(reset_modified));
FDRE \rd_data_reg_reg[9] 
       (.C(CLK),
        .CE(rd_enable),
        .D(rd_data[9]),
        .Q(\n_0_rd_data_reg_reg[9] ),
        .R(reset_modified));
LUT6 #(
    .INIT(64'h00000000FFFE0000)) 
     rd_enable_i_1
       (.I0(n_0_rd_enable_i_2),
        .I1(n_0_rd_enable_i_3),
        .I2(n_0_rd_enable_i_4),
        .I3(n_0_rd_enable_i_5),
        .I4(even),
        .I5(reset_modified),
        .O(n_0_rd_enable_i_1));
LUT6 #(
    .INIT(64'hFFFFFFFF80000000)) 
     rd_enable_i_2
       (.I0(rd_occupancy[4]),
        .I1(rd_occupancy[3]),
        .I2(rd_occupancy[2]),
        .I3(rd_occupancy[0]),
        .I4(rd_occupancy[1]),
        .I5(rd_data[11]),
        .O(n_0_rd_enable_i_2));
LUT6 #(
    .INIT(64'hFFFFFFFDFFFFFFFF)) 
     rd_enable_i_3
       (.I0(rd_data[27]),
        .I1(rd_data[3]),
        .I2(rd_data[22]),
        .I3(rd_data[16]),
        .I4(rd_data[0]),
        .I5(rd_data[19]),
        .O(n_0_rd_enable_i_3));
LUT6 #(
    .INIT(64'hFFFFFDFFFFFFFFFF)) 
     rd_enable_i_4
       (.I0(rd_data[21]),
        .I1(rd_data[17]),
        .I2(rd_data[2]),
        .I3(rd_data[6]),
        .I4(rd_occupancy[5]),
        .I5(rd_data[4]),
        .O(n_0_rd_enable_i_4));
LUT6 #(
    .INIT(64'hFFFFFDFFFFFFFFFF)) 
     rd_enable_i_5
       (.I0(rd_data[23]),
        .I1(rd_data[7]),
        .I2(rd_data[5]),
        .I3(rd_data[18]),
        .I4(rd_data[1]),
        .I5(rd_data[20]),
        .O(n_0_rd_enable_i_5));
FDRE rd_enable_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_rd_enable_i_1),
        .Q(rd_enable),
        .R(1'b0));
LUT2 #(
    .INIT(4'h6)) 
     \rd_occupancy[3]_i_10 
       (.I0(data_out4_out),
        .I1(data_out3_out),
        .O(p_0_in1_in1_in[4]));
LUT3 #(
    .INIT(8'h96)) 
     \rd_occupancy[3]_i_2 
       (.I0(data_out4_out),
        .I1(data_out2_out),
        .I2(data_out3_out),
        .O(p_0_in1_in1_in[3]));
LUT4 #(
    .INIT(16'h6996)) 
     \rd_occupancy[3]_i_3 
       (.I0(data_out3_out),
        .I1(data_out4_out),
        .I2(data_out1_out),
        .I3(data_out2_out),
        .O(p_0_in1_in1_in[2]));
LUT5 #(
    .INIT(32'h96696996)) 
     \rd_occupancy[3]_i_4 
       (.I0(data_out4_out),
        .I1(data_out1_out),
        .I2(data_out0_out),
        .I3(data_out3_out),
        .I4(data_out2_out),
        .O(p_0_in1_in1_in[1]));
LUT6 #(
    .INIT(64'h6996966996696996)) 
     \rd_occupancy[3]_i_5 
       (.I0(data_out3_out),
        .I1(data_out4_out),
        .I2(data_out0_out),
        .I3(\n_0_reclock_wr_addrgray[0].sync_wr_addrgray ),
        .I4(data_out2_out),
        .I5(data_out1_out),
        .O(p_0_in1_in1_in[0]));
LUT4 #(
    .INIT(16'h9669)) 
     \rd_occupancy[3]_i_6 
       (.I0(data_out3_out),
        .I1(data_out2_out),
        .I2(data_out4_out),
        .I3(\n_0_rd_addr_reg[3] ),
        .O(\n_0_rd_occupancy[3]_i_6 ));
LUT5 #(
    .INIT(32'h69969669)) 
     \rd_occupancy[3]_i_7 
       (.I0(data_out2_out),
        .I1(data_out1_out),
        .I2(data_out4_out),
        .I3(data_out3_out),
        .I4(\n_0_rd_addr_reg[2] ),
        .O(\n_0_rd_occupancy[3]_i_7 ));
LUT6 #(
    .INIT(64'h9669699669969669)) 
     \rd_occupancy[3]_i_8 
       (.I0(data_out3_out),
        .I1(data_out2_out),
        .I2(data_out1_out),
        .I3(data_out0_out),
        .I4(\n_0_rd_addr_reg[1] ),
        .I5(data_out4_out),
        .O(\n_0_rd_occupancy[3]_i_8 ));
LUT6 #(
    .INIT(64'h9669699669969669)) 
     \rd_occupancy[3]_i_9 
       (.I0(data_out1_out),
        .I1(data_out2_out),
        .I2(\n_0_reclock_wr_addrgray[0].sync_wr_addrgray ),
        .I3(data_out0_out),
        .I4(p_0_in1_in1_in[4]),
        .I5(\n_0_rd_addr_reg[0] ),
        .O(\n_0_rd_occupancy[3]_i_9 ));
LUT2 #(
    .INIT(4'h6)) 
     \rd_occupancy[5]_i_2 
       (.I0(data_out4_out),
        .I1(data_out3_out),
        .O(\n_0_rd_occupancy[5]_i_2 ));
LUT2 #(
    .INIT(4'h9)) 
     \rd_occupancy[5]_i_3 
       (.I0(data_out4_out),
        .I1(\n_0_rd_addr_reg[5] ),
        .O(\n_0_rd_occupancy[5]_i_3 ));
LUT3 #(
    .INIT(8'h69)) 
     \rd_occupancy[5]_i_4 
       (.I0(data_out3_out),
        .I1(data_out4_out),
        .I2(\n_0_rd_addr_reg[4] ),
        .O(\n_0_rd_occupancy[5]_i_4 ));
FDRE \rd_occupancy_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(rd_occupancy02_out[0]),
        .Q(rd_occupancy[0]),
        .R(reset_modified));
FDRE \rd_occupancy_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(rd_occupancy02_out[1]),
        .Q(rd_occupancy[1]),
        .R(reset_modified));
FDRE \rd_occupancy_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .D(rd_occupancy02_out[2]),
        .Q(rd_occupancy[2]),
        .R(reset_modified));
FDRE \rd_occupancy_reg[3] 
       (.C(CLK),
        .CE(1'b1),
        .D(rd_occupancy02_out[3]),
        .Q(rd_occupancy[3]),
        .R(reset_modified));
CARRY4 \rd_occupancy_reg[3]_i_1 
       (.CI(1'b0),
        .CO({\n_0_rd_occupancy_reg[3]_i_1 ,\n_1_rd_occupancy_reg[3]_i_1 ,\n_2_rd_occupancy_reg[3]_i_1 ,\n_3_rd_occupancy_reg[3]_i_1 }),
        .CYINIT(1'b1),
        .DI(p_0_in1_in1_in[3:0]),
        .O(rd_occupancy02_out[3:0]),
        .S({\n_0_rd_occupancy[3]_i_6 ,\n_0_rd_occupancy[3]_i_7 ,\n_0_rd_occupancy[3]_i_8 ,\n_0_rd_occupancy[3]_i_9 }));
FDRE \rd_occupancy_reg[4] 
       (.C(CLK),
        .CE(1'b1),
        .D(rd_occupancy02_out[4]),
        .Q(rd_occupancy[4]),
        .R(reset_modified));
FDSE \rd_occupancy_reg[5] 
       (.C(CLK),
        .CE(1'b1),
        .D(rd_occupancy02_out[5]),
        .Q(rd_occupancy[5]),
        .S(reset_modified));
CARRY4 \rd_occupancy_reg[5]_i_1 
       (.CI(\n_0_rd_occupancy_reg[3]_i_1 ),
        .CO({\NLW_rd_occupancy_reg[5]_i_1_CO_UNCONNECTED [3:1],\n_3_rd_occupancy_reg[5]_i_1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,\n_0_rd_occupancy[5]_i_2 }),
        .O({\NLW_rd_occupancy_reg[5]_i_1_O_UNCONNECTED [3:2],rd_occupancy02_out[5:4]}),
        .S({1'b0,1'b0,\n_0_rd_occupancy[5]_i_3 ,\n_0_rd_occupancy[5]_i_4 }));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gmii_to_sgmiigmii_to_sgmii_sync_block \reclock_rd_addrgray[0].sync_rd_addrgray 
       (.clk(I1),
        .data_in(rd_addr_gray[0]),
        .data_out(\n_0_reclock_rd_addrgray[0].sync_rd_addrgray ));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gmii_to_sgmiigmii_to_sgmii_sync_block__17 \reclock_rd_addrgray[1].sync_rd_addrgray 
       (.clk(I1),
        .data_in(rd_addr_gray[1]),
        .data_out(p_3_in24_in));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gmii_to_sgmiigmii_to_sgmii_sync_block__16 \reclock_rd_addrgray[2].sync_rd_addrgray 
       (.clk(I1),
        .data_in(rd_addr_gray[2]),
        .data_out(p_2_in21_in));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gmii_to_sgmiigmii_to_sgmii_sync_block__15 \reclock_rd_addrgray[3].sync_rd_addrgray 
       (.clk(I1),
        .data_in(rd_addr_gray[3]),
        .data_out(p_1_in18_in));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gmii_to_sgmiigmii_to_sgmii_sync_block__14 \reclock_rd_addrgray[4].sync_rd_addrgray 
       (.clk(I1),
        .data_in(rd_addr_gray[4]),
        .data_out(\n_0_reclock_rd_addrgray[4].sync_rd_addrgray ));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gmii_to_sgmiigmii_to_sgmii_sync_block__13 \reclock_rd_addrgray[5].sync_rd_addrgray 
       (.clk(I1),
        .data_in(rd_addr_gray[5]),
        .data_out(p_0_in));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gmii_to_sgmiigmii_to_sgmii_sync_block__12 \reclock_wr_addrgray[0].sync_wr_addrgray 
       (.clk(CLK),
        .data_in(\n_0_wr_addr_gray_reg[0] ),
        .data_out(\n_0_reclock_wr_addrgray[0].sync_wr_addrgray ));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gmii_to_sgmiigmii_to_sgmii_sync_block__11 \reclock_wr_addrgray[1].sync_wr_addrgray 
       (.clk(CLK),
        .data_in(\n_0_wr_addr_gray_reg[1] ),
        .data_out(data_out0_out));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gmii_to_sgmiigmii_to_sgmii_sync_block__10 \reclock_wr_addrgray[2].sync_wr_addrgray 
       (.clk(CLK),
        .data_in(\n_0_wr_addr_gray_reg[2] ),
        .data_out(data_out1_out));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gmii_to_sgmiigmii_to_sgmii_sync_block__9 \reclock_wr_addrgray[3].sync_wr_addrgray 
       (.clk(CLK),
        .data_in(\n_0_wr_addr_gray_reg[3] ),
        .data_out(data_out2_out));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gmii_to_sgmiigmii_to_sgmii_sync_block__8 \reclock_wr_addrgray[4].sync_wr_addrgray 
       (.clk(CLK),
        .data_in(\n_0_wr_addr_gray_reg[4] ),
        .data_out(data_out3_out));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gmii_to_sgmiigmii_to_sgmii_sync_block__7 \reclock_wr_addrgray[5].sync_wr_addrgray 
       (.clk(CLK),
        .data_in(data_in),
        .data_out(data_out4_out));
(* SOFT_HLUTNM = "soft_lutpair106" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     remove_idle_i_1
       (.I0(wr_enable1),
        .I1(initialize_ram_complete),
        .I2(remove_idle),
        .O(n_0_remove_idle_i_1));
FDRE remove_idle_reg
       (.C(I1),
        .CE(1'b1),
        .D(n_0_remove_idle_i_1),
        .Q(remove_idle),
        .R(rxrecreset));
LUT3 #(
    .INIT(8'h74)) 
     reset_modified_i_1
       (.I0(initialize_ram_complete_sync_ris_edg),
        .I1(reset_modified),
        .I2(rxreset),
        .O(n_0_reset_modified_i_1));
FDRE #(
    .INIT(1'b0)) 
     reset_modified_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_reset_modified_i_1),
        .Q(reset_modified),
        .R(1'b0));
LUT2 #(
    .INIT(4'hE)) 
     rxbuferr_i_1
       (.I0(rxbuferr0),
        .I1(rxbuferr),
        .O(n_0_rxbuferr_i_1));
LUT6 #(
    .INIT(64'h8000800180010001)) 
     rxbuferr_i_2
       (.I0(rd_occupancy[3]),
        .I1(rd_occupancy[4]),
        .I2(rd_occupancy[5]),
        .I3(rd_occupancy[2]),
        .I4(rd_occupancy[0]),
        .I5(rd_occupancy[1]),
        .O(rxbuferr0));
FDRE rxbuferr_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_rxbuferr_i_1),
        .Q(rxbuferr),
        .R(reset_modified));
(* SOFT_HLUTNM = "soft_lutpair111" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     rxchariscomma_usr_i_1
       (.I0(\n_0_rd_data_reg_reg[28] ),
        .I1(even),
        .I2(\n_0_rd_data_reg_reg[12] ),
        .O(n_0_rxchariscomma_usr_i_1));
FDRE rxchariscomma_usr_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_rxchariscomma_usr_i_1),
        .Q(rxchariscomma),
        .R(reset_modified));
(* SOFT_HLUTNM = "soft_lutpair110" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     rxcharisk_usr_i_1
       (.I0(\n_0_rd_data_reg_reg[27] ),
        .I1(even),
        .I2(\n_0_rd_data_reg_reg[11] ),
        .O(n_0_rxcharisk_usr_i_1));
FDRE rxcharisk_usr_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_rxcharisk_usr_i_1),
        .Q(rxcharisk),
        .R(reset_modified));
LUT3 #(
    .INIT(8'hBA)) 
     \rxclkcorcnt[0]_i_1 
       (.I0(insert_idle_reg__0),
        .I1(I7[0]),
        .I2(\n_0_rd_data_reg_reg[13] ),
        .O(\n_0_rxclkcorcnt[0]_i_1 ));
LUT4 #(
    .INIT(16'h00A2)) 
     \rxclkcorcnt[2]_i_1 
       (.I0(insert_idle_reg__0),
        .I1(\n_0_rd_data_reg_reg[13] ),
        .I2(I7[0]),
        .I3(reset_modified),
        .O(\n_0_rxclkcorcnt[2]_i_1 ));
FDRE \rxclkcorcnt_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_rxclkcorcnt[0]_i_1 ),
        .Q(I7[0]),
        .R(reset_modified));
FDRE \rxclkcorcnt_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_rxclkcorcnt[2]_i_1 ),
        .Q(I7[1]),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair109" *) 
   LUT3 #(
    .INIT(8'hAC)) 
     \rxdata_usr[0]_i_1 
       (.I0(\n_0_rd_data_reg_reg[16] ),
        .I1(\n_0_rd_data_reg_reg[0] ),
        .I2(even),
        .O(\n_0_rxdata_usr[0]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair110" *) 
   LUT3 #(
    .INIT(8'hAC)) 
     \rxdata_usr[1]_i_1 
       (.I0(\n_0_rd_data_reg_reg[17] ),
        .I1(\n_0_rd_data_reg_reg[1] ),
        .I2(even),
        .O(\n_0_rxdata_usr[1]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair111" *) 
   LUT3 #(
    .INIT(8'hAC)) 
     \rxdata_usr[2]_i_1 
       (.I0(\n_0_rd_data_reg_reg[18] ),
        .I1(\n_0_rd_data_reg_reg[2] ),
        .I2(even),
        .O(\n_0_rxdata_usr[2]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair112" *) 
   LUT3 #(
    .INIT(8'hAC)) 
     \rxdata_usr[3]_i_1 
       (.I0(\n_0_rd_data_reg_reg[19] ),
        .I1(\n_0_rd_data_reg_reg[3] ),
        .I2(even),
        .O(\n_0_rxdata_usr[3]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair113" *) 
   LUT3 #(
    .INIT(8'hAC)) 
     \rxdata_usr[4]_i_1 
       (.I0(\n_0_rd_data_reg_reg[20] ),
        .I1(\n_0_rd_data_reg_reg[4] ),
        .I2(even),
        .O(\n_0_rxdata_usr[4]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair114" *) 
   LUT3 #(
    .INIT(8'hAC)) 
     \rxdata_usr[5]_i_1 
       (.I0(\n_0_rd_data_reg_reg[21] ),
        .I1(\n_0_rd_data_reg_reg[5] ),
        .I2(even),
        .O(\n_0_rxdata_usr[5]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair113" *) 
   LUT3 #(
    .INIT(8'hAC)) 
     \rxdata_usr[6]_i_1 
       (.I0(\n_0_rd_data_reg_reg[22] ),
        .I1(\n_0_rd_data_reg_reg[6] ),
        .I2(even),
        .O(\n_0_rxdata_usr[6]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair109" *) 
   LUT3 #(
    .INIT(8'hAC)) 
     \rxdata_usr[7]_i_1 
       (.I0(\n_0_rd_data_reg_reg[23] ),
        .I1(\n_0_rd_data_reg_reg[7] ),
        .I2(even),
        .O(\n_0_rxdata_usr[7]_i_1 ));
FDRE \rxdata_usr_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_rxdata_usr[0]_i_1 ),
        .Q(O1[0]),
        .R(reset_modified));
FDRE \rxdata_usr_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_rxdata_usr[1]_i_1 ),
        .Q(O1[1]),
        .R(reset_modified));
FDRE \rxdata_usr_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_rxdata_usr[2]_i_1 ),
        .Q(O1[2]),
        .R(reset_modified));
FDRE \rxdata_usr_reg[3] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_rxdata_usr[3]_i_1 ),
        .Q(O1[3]),
        .R(reset_modified));
FDRE \rxdata_usr_reg[4] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_rxdata_usr[4]_i_1 ),
        .Q(O1[4]),
        .R(reset_modified));
FDRE \rxdata_usr_reg[5] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_rxdata_usr[5]_i_1 ),
        .Q(O1[5]),
        .R(reset_modified));
FDRE \rxdata_usr_reg[6] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_rxdata_usr[6]_i_1 ),
        .Q(O1[6]),
        .R(reset_modified));
FDRE \rxdata_usr_reg[7] 
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_rxdata_usr[7]_i_1 ),
        .Q(O1[7]),
        .R(reset_modified));
(* SOFT_HLUTNM = "soft_lutpair112" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     rxdisperr_usr_i_1
       (.I0(\n_0_rd_data_reg_reg[26] ),
        .I1(even),
        .I2(\n_0_rd_data_reg_reg[10] ),
        .O(n_0_rxdisperr_usr_i_1));
FDRE rxdisperr_usr_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_rxdisperr_usr_i_1),
        .Q(rxdisperr_usr),
        .R(reset_modified));
(* SOFT_HLUTNM = "soft_lutpair114" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     rxnotintable_usr_i_1
       (.I0(\n_0_rd_data_reg_reg[25] ),
        .I1(even),
        .I2(\n_0_rd_data_reg_reg[9] ),
        .O(n_0_rxnotintable_usr_i_1));
FDRE rxnotintable_usr_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_rxnotintable_usr_i_1),
        .Q(rxnotintable_usr),
        .R(reset_modified));
FDRE #(
    .INIT(1'b1)) 
     start_reg
       (.C(I1),
        .CE(1'b1),
        .D(1'b0),
        .Q(start),
        .R(1'b0));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gmii_to_sgmiigmii_to_sgmii_sync_block__6 sync_initialize_ram_comp
       (.clk(CLK),
        .data_in(initialize_ram_complete),
        .data_out(data_out));
(* SOFT_HLUTNM = "soft_lutpair105" *) 
   LUT4 #(
    .INIT(16'hFBF8)) 
     \wr_addr[5]_i_1 
       (.I0(wr_addr1_in[5]),
        .I1(wr_enable),
        .I2(initialize_ram_complete_pulse),
        .I3(\n_0_wr_addr_reg[5] ),
        .O(\n_0_wr_addr[5]_i_1 ));
LUT2 #(
    .INIT(4'h6)) 
     \wr_addr_gray[0]_i_1 
       (.I0(p_1_in6_in),
        .I1(\n_0_wr_addr_plus2_reg[0] ),
        .O(p_0_in5_out[0]));
LUT2 #(
    .INIT(4'h6)) 
     \wr_addr_gray[1]_i_1 
       (.I0(p_2_in8_in),
        .I1(p_1_in6_in),
        .O(p_0_in5_out[1]));
(* SOFT_HLUTNM = "soft_lutpair116" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \wr_addr_gray[2]_i_1 
       (.I0(p_3_in10_in),
        .I1(p_2_in8_in),
        .O(p_0_in5_out[2]));
(* SOFT_HLUTNM = "soft_lutpair116" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \wr_addr_gray[3]_i_1 
       (.I0(p_4_in12_in),
        .I1(p_3_in10_in),
        .O(p_0_in5_out[3]));
LUT2 #(
    .INIT(4'h6)) 
     \wr_addr_gray[4]_i_1 
       (.I0(\n_0_wr_addr_plus2_reg[5] ),
        .I1(p_4_in12_in),
        .O(p_0_in5_out[4]));
FDSE \wr_addr_gray_reg[0] 
       (.C(I1),
        .CE(1'b1),
        .D(p_0_in5_out[0]),
        .Q(\n_0_wr_addr_gray_reg[0] ),
        .S(rxrecreset));
FDRE \wr_addr_gray_reg[1] 
       (.C(I1),
        .CE(1'b1),
        .D(p_0_in5_out[1]),
        .Q(\n_0_wr_addr_gray_reg[1] ),
        .R(rxrecreset));
FDRE \wr_addr_gray_reg[2] 
       (.C(I1),
        .CE(1'b1),
        .D(p_0_in5_out[2]),
        .Q(\n_0_wr_addr_gray_reg[2] ),
        .R(rxrecreset));
FDRE \wr_addr_gray_reg[3] 
       (.C(I1),
        .CE(1'b1),
        .D(p_0_in5_out[3]),
        .Q(\n_0_wr_addr_gray_reg[3] ),
        .R(rxrecreset));
FDSE \wr_addr_gray_reg[4] 
       (.C(I1),
        .CE(1'b1),
        .D(p_0_in5_out[4]),
        .Q(\n_0_wr_addr_gray_reg[4] ),
        .S(rxrecreset));
FDSE \wr_addr_gray_reg[5] 
       (.C(I1),
        .CE(1'b1),
        .D(\n_0_wr_addr_plus2_reg[5] ),
        .Q(data_in),
        .S(rxrecreset));
(* SOFT_HLUTNM = "soft_lutpair105" *) 
   LUT4 #(
    .INIT(16'hFBF8)) 
     \wr_addr_plus1[5]_i_1 
       (.I0(\n_0_wr_addr_plus2_reg[5] ),
        .I1(wr_enable),
        .I2(initialize_ram_complete_pulse),
        .I3(wr_addr1_in[5]),
        .O(\n_0_wr_addr_plus1[5]_i_1 ));
FDSE \wr_addr_plus1_reg[0] 
       (.C(I1),
        .CE(wr_enable),
        .D(\n_0_wr_addr_plus2_reg[0] ),
        .Q(wr_addr1_in[0]),
        .S(\n_0_wr_addr_plus2[4]_i_1 ));
FDRE \wr_addr_plus1_reg[1] 
       (.C(I1),
        .CE(wr_enable),
        .D(p_1_in6_in),
        .Q(wr_addr1_in[1]),
        .R(\n_0_wr_addr_plus2[4]_i_1 ));
FDRE \wr_addr_plus1_reg[2] 
       (.C(I1),
        .CE(wr_enable),
        .D(p_2_in8_in),
        .Q(wr_addr1_in[2]),
        .R(\n_0_wr_addr_plus2[4]_i_1 ));
FDRE \wr_addr_plus1_reg[3] 
       (.C(I1),
        .CE(wr_enable),
        .D(p_3_in10_in),
        .Q(wr_addr1_in[3]),
        .R(\n_0_wr_addr_plus2[4]_i_1 ));
FDRE \wr_addr_plus1_reg[4] 
       (.C(I1),
        .CE(wr_enable),
        .D(p_4_in12_in),
        .Q(wr_addr1_in[4]),
        .R(\n_0_wr_addr_plus2[4]_i_1 ));
FDRE \wr_addr_plus1_reg[5] 
       (.C(I1),
        .CE(1'b1),
        .D(\n_0_wr_addr_plus1[5]_i_1 ),
        .Q(wr_addr1_in[5]),
        .R(rxrecreset));
LUT1 #(
    .INIT(2'h1)) 
     \wr_addr_plus2[0]_i_1 
       (.I0(\n_0_wr_addr_plus2_reg[0] ),
        .O(\n_0_wr_addr_plus2[0]_i_1 ));
LUT2 #(
    .INIT(4'h6)) 
     \wr_addr_plus2[1]_i_1 
       (.I0(\n_0_wr_addr_plus2_reg[0] ),
        .I1(p_1_in6_in),
        .O(\n_0_wr_addr_plus2[1]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair103" *) 
   LUT3 #(
    .INIT(8'h78)) 
     \wr_addr_plus2[2]_i_1 
       (.I0(\n_0_wr_addr_plus2_reg[0] ),
        .I1(p_1_in6_in),
        .I2(p_2_in8_in),
        .O(\n_0_wr_addr_plus2[2]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair103" *) 
   LUT4 #(
    .INIT(16'h7F80)) 
     \wr_addr_plus2[3]_i_1 
       (.I0(p_1_in6_in),
        .I1(\n_0_wr_addr_plus2_reg[0] ),
        .I2(p_2_in8_in),
        .I3(p_3_in10_in),
        .O(\n_0_wr_addr_plus2[3]_i_1 ));
LUT2 #(
    .INIT(4'hE)) 
     \wr_addr_plus2[4]_i_1 
       (.I0(rxrecreset),
        .I1(initialize_ram_complete_pulse),
        .O(\n_0_wr_addr_plus2[4]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair101" *) 
   LUT5 #(
    .INIT(32'h7FFF8000)) 
     \wr_addr_plus2[4]_i_2 
       (.I0(p_2_in8_in),
        .I1(\n_0_wr_addr_plus2_reg[0] ),
        .I2(p_1_in6_in),
        .I3(p_3_in10_in),
        .I4(p_4_in12_in),
        .O(\n_0_wr_addr_plus2[4]_i_2 ));
LUT5 #(
    .INIT(32'hFF7FFF80)) 
     \wr_addr_plus2[5]_i_1 
       (.I0(p_4_in12_in),
        .I1(\n_0_wr_addr_plus2[5]_i_2 ),
        .I2(wr_enable),
        .I3(initialize_ram_complete_pulse),
        .I4(\n_0_wr_addr_plus2_reg[5] ),
        .O(\n_0_wr_addr_plus2[5]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair101" *) 
   LUT4 #(
    .INIT(16'h8000)) 
     \wr_addr_plus2[5]_i_2 
       (.I0(p_3_in10_in),
        .I1(p_1_in6_in),
        .I2(\n_0_wr_addr_plus2_reg[0] ),
        .I3(p_2_in8_in),
        .O(\n_0_wr_addr_plus2[5]_i_2 ));
FDRE \wr_addr_plus2_reg[0] 
       (.C(I1),
        .CE(wr_enable),
        .D(\n_0_wr_addr_plus2[0]_i_1 ),
        .Q(\n_0_wr_addr_plus2_reg[0] ),
        .R(\n_0_wr_addr_plus2[4]_i_1 ));
FDSE \wr_addr_plus2_reg[1] 
       (.C(I1),
        .CE(wr_enable),
        .D(\n_0_wr_addr_plus2[1]_i_1 ),
        .Q(p_1_in6_in),
        .S(\n_0_wr_addr_plus2[4]_i_1 ));
FDRE \wr_addr_plus2_reg[2] 
       (.C(I1),
        .CE(wr_enable),
        .D(\n_0_wr_addr_plus2[2]_i_1 ),
        .Q(p_2_in8_in),
        .R(\n_0_wr_addr_plus2[4]_i_1 ));
FDRE \wr_addr_plus2_reg[3] 
       (.C(I1),
        .CE(wr_enable),
        .D(\n_0_wr_addr_plus2[3]_i_1 ),
        .Q(p_3_in10_in),
        .R(\n_0_wr_addr_plus2[4]_i_1 ));
FDRE \wr_addr_plus2_reg[4] 
       (.C(I1),
        .CE(wr_enable),
        .D(\n_0_wr_addr_plus2[4]_i_2 ),
        .Q(p_4_in12_in),
        .R(\n_0_wr_addr_plus2[4]_i_1 ));
FDRE \wr_addr_plus2_reg[5] 
       (.C(I1),
        .CE(1'b1),
        .D(\n_0_wr_addr_plus2[5]_i_1 ),
        .Q(\n_0_wr_addr_plus2_reg[5] ),
        .R(rxrecreset));
FDRE \wr_addr_reg[0] 
       (.C(I1),
        .CE(wr_enable),
        .D(wr_addr1_in[0]),
        .Q(\n_0_wr_addr_reg[0] ),
        .R(\n_0_wr_addr_plus2[4]_i_1 ));
FDRE \wr_addr_reg[1] 
       (.C(I1),
        .CE(wr_enable),
        .D(wr_addr1_in[1]),
        .Q(\n_0_wr_addr_reg[1] ),
        .R(\n_0_wr_addr_plus2[4]_i_1 ));
FDRE \wr_addr_reg[2] 
       (.C(I1),
        .CE(wr_enable),
        .D(wr_addr1_in[2]),
        .Q(\n_0_wr_addr_reg[2] ),
        .R(\n_0_wr_addr_plus2[4]_i_1 ));
FDRE \wr_addr_reg[3] 
       (.C(I1),
        .CE(wr_enable),
        .D(wr_addr1_in[3]),
        .Q(\n_0_wr_addr_reg[3] ),
        .R(\n_0_wr_addr_plus2[4]_i_1 ));
FDRE \wr_addr_reg[4] 
       (.C(I1),
        .CE(wr_enable),
        .D(wr_addr1_in[4]),
        .Q(\n_0_wr_addr_reg[4] ),
        .R(\n_0_wr_addr_plus2[4]_i_1 ));
FDRE \wr_addr_reg[5] 
       (.C(I1),
        .CE(1'b1),
        .D(\n_0_wr_addr[5]_i_1 ),
        .Q(\n_0_wr_addr_reg[5] ),
        .R(rxrecreset));
FDRE \wr_data_reg[0] 
       (.C(I1),
        .CE(1'b1),
        .D(D[0]),
        .Q(\n_0_wr_data_reg[0] ),
        .R(wr_data1));
FDRE \wr_data_reg[10] 
       (.C(I1),
        .CE(1'b1),
        .D(D[9]),
        .Q(\n_0_wr_data_reg[10] ),
        .R(wr_data1));
FDRE \wr_data_reg[11] 
       (.C(I1),
        .CE(1'b1),
        .D(D[10]),
        .Q(\n_0_wr_data_reg[11] ),
        .R(wr_data1));
FDRE \wr_data_reg[12] 
       (.C(I1),
        .CE(1'b1),
        .D(D[11]),
        .Q(\n_0_wr_data_reg[12] ),
        .R(wr_data1));
FDRE \wr_data_reg[16] 
       (.C(I1),
        .CE(1'b1),
        .D(D[12]),
        .Q(\n_0_wr_data_reg[16] ),
        .R(wr_data1));
FDRE \wr_data_reg[17] 
       (.C(I1),
        .CE(1'b1),
        .D(D[13]),
        .Q(\n_0_wr_data_reg[17] ),
        .R(wr_data1));
FDRE \wr_data_reg[18] 
       (.C(I1),
        .CE(1'b1),
        .D(D[14]),
        .Q(\n_0_wr_data_reg[18] ),
        .R(wr_data1));
FDRE \wr_data_reg[19] 
       (.C(I1),
        .CE(1'b1),
        .D(D[15]),
        .Q(\n_0_wr_data_reg[19] ),
        .R(wr_data1));
FDRE \wr_data_reg[1] 
       (.C(I1),
        .CE(1'b1),
        .D(D[1]),
        .Q(\n_0_wr_data_reg[1] ),
        .R(wr_data1));
FDRE \wr_data_reg[20] 
       (.C(I1),
        .CE(1'b1),
        .D(D[16]),
        .Q(\n_0_wr_data_reg[20] ),
        .R(wr_data1));
FDRE \wr_data_reg[21] 
       (.C(I1),
        .CE(1'b1),
        .D(D[17]),
        .Q(\n_0_wr_data_reg[21] ),
        .R(wr_data1));
FDRE \wr_data_reg[22] 
       (.C(I1),
        .CE(1'b1),
        .D(D[18]),
        .Q(\n_0_wr_data_reg[22] ),
        .R(wr_data1));
FDRE \wr_data_reg[23] 
       (.C(I1),
        .CE(1'b1),
        .D(D[19]),
        .Q(\n_0_wr_data_reg[23] ),
        .R(wr_data1));
FDRE \wr_data_reg[25] 
       (.C(I1),
        .CE(1'b1),
        .D(D[20]),
        .Q(\n_0_wr_data_reg[25] ),
        .R(wr_data1));
FDRE \wr_data_reg[26] 
       (.C(I1),
        .CE(1'b1),
        .D(D[21]),
        .Q(\n_0_wr_data_reg[26] ),
        .R(wr_data1));
FDRE \wr_data_reg[27] 
       (.C(I1),
        .CE(1'b1),
        .D(D[22]),
        .Q(p_0_in5_in),
        .R(wr_data1));
FDRE \wr_data_reg[28] 
       (.C(I1),
        .CE(1'b1),
        .D(D[23]),
        .Q(\n_0_wr_data_reg[28] ),
        .R(wr_data1));
LUT2 #(
    .INIT(4'hB)) 
     \wr_data_reg[28]_i_1 
       (.I0(rxrecreset),
        .I1(initialize_ram_complete),
        .O(wr_data1));
FDRE \wr_data_reg[2] 
       (.C(I1),
        .CE(1'b1),
        .D(D[2]),
        .Q(\n_0_wr_data_reg[2] ),
        .R(wr_data1));
FDRE \wr_data_reg[3] 
       (.C(I1),
        .CE(1'b1),
        .D(D[3]),
        .Q(\n_0_wr_data_reg[3] ),
        .R(wr_data1));
FDRE \wr_data_reg[4] 
       (.C(I1),
        .CE(1'b1),
        .D(D[4]),
        .Q(\n_0_wr_data_reg[4] ),
        .R(wr_data1));
FDRE \wr_data_reg[5] 
       (.C(I1),
        .CE(1'b1),
        .D(D[5]),
        .Q(\n_0_wr_data_reg[5] ),
        .R(wr_data1));
FDRE \wr_data_reg[6] 
       (.C(I1),
        .CE(1'b1),
        .D(D[6]),
        .Q(\n_0_wr_data_reg[6] ),
        .R(wr_data1));
FDRE \wr_data_reg[7] 
       (.C(I1),
        .CE(1'b1),
        .D(D[7]),
        .Q(\n_0_wr_data_reg[7] ),
        .R(wr_data1));
FDRE \wr_data_reg[9] 
       (.C(I1),
        .CE(1'b1),
        .D(D[8]),
        .Q(\n_0_wr_data_reg[9] ),
        .R(wr_data1));
FDRE \wr_data_reg_reg[0] 
       (.C(I1),
        .CE(1'b1),
        .D(\n_0_wr_data_reg[0] ),
        .Q(wr_data_reg__0[0]),
        .R(wr_data1));
FDRE \wr_data_reg_reg[10] 
       (.C(I1),
        .CE(1'b1),
        .D(\n_0_wr_data_reg[10] ),
        .Q(wr_data_reg__0[10]),
        .R(wr_data1));
FDRE \wr_data_reg_reg[11] 
       (.C(I1),
        .CE(1'b1),
        .D(\n_0_wr_data_reg[11] ),
        .Q(wr_data_reg__0[11]),
        .R(wr_data1));
FDRE \wr_data_reg_reg[12] 
       (.C(I1),
        .CE(1'b1),
        .D(\n_0_wr_data_reg[12] ),
        .Q(wr_data_reg__0[12]),
        .R(wr_data1));
FDRE \wr_data_reg_reg[13] 
       (.C(I1),
        .CE(1'b1),
        .D(remove_idle),
        .Q(wr_data_reg__0[13]),
        .R(wr_data1));
FDRE \wr_data_reg_reg[16] 
       (.C(I1),
        .CE(1'b1),
        .D(\n_0_wr_data_reg[16] ),
        .Q(wr_data_reg__0[16]),
        .R(wr_data1));
FDRE \wr_data_reg_reg[17] 
       (.C(I1),
        .CE(1'b1),
        .D(\n_0_wr_data_reg[17] ),
        .Q(wr_data_reg__0[17]),
        .R(wr_data1));
FDRE \wr_data_reg_reg[18] 
       (.C(I1),
        .CE(1'b1),
        .D(\n_0_wr_data_reg[18] ),
        .Q(wr_data_reg__0[18]),
        .R(wr_data1));
FDRE \wr_data_reg_reg[19] 
       (.C(I1),
        .CE(1'b1),
        .D(\n_0_wr_data_reg[19] ),
        .Q(wr_data_reg__0[19]),
        .R(wr_data1));
FDRE \wr_data_reg_reg[1] 
       (.C(I1),
        .CE(1'b1),
        .D(\n_0_wr_data_reg[1] ),
        .Q(wr_data_reg__0[1]),
        .R(wr_data1));
FDRE \wr_data_reg_reg[20] 
       (.C(I1),
        .CE(1'b1),
        .D(\n_0_wr_data_reg[20] ),
        .Q(wr_data_reg__0[20]),
        .R(wr_data1));
FDRE \wr_data_reg_reg[21] 
       (.C(I1),
        .CE(1'b1),
        .D(\n_0_wr_data_reg[21] ),
        .Q(wr_data_reg__0[21]),
        .R(wr_data1));
FDRE \wr_data_reg_reg[22] 
       (.C(I1),
        .CE(1'b1),
        .D(\n_0_wr_data_reg[22] ),
        .Q(wr_data_reg__0[22]),
        .R(wr_data1));
FDRE \wr_data_reg_reg[23] 
       (.C(I1),
        .CE(1'b1),
        .D(\n_0_wr_data_reg[23] ),
        .Q(wr_data_reg__0[23]),
        .R(wr_data1));
FDRE \wr_data_reg_reg[25] 
       (.C(I1),
        .CE(1'b1),
        .D(\n_0_wr_data_reg[25] ),
        .Q(wr_data_reg__0[25]),
        .R(wr_data1));
FDRE \wr_data_reg_reg[26] 
       (.C(I1),
        .CE(1'b1),
        .D(\n_0_wr_data_reg[26] ),
        .Q(wr_data_reg__0[26]),
        .R(wr_data1));
FDRE \wr_data_reg_reg[27] 
       (.C(I1),
        .CE(1'b1),
        .D(p_0_in5_in),
        .Q(wr_data_reg__0[27]),
        .R(wr_data1));
FDRE \wr_data_reg_reg[28] 
       (.C(I1),
        .CE(1'b1),
        .D(\n_0_wr_data_reg[28] ),
        .Q(wr_data_reg__0[28]),
        .R(wr_data1));
FDRE \wr_data_reg_reg[2] 
       (.C(I1),
        .CE(1'b1),
        .D(\n_0_wr_data_reg[2] ),
        .Q(wr_data_reg__0[2]),
        .R(wr_data1));
FDRE \wr_data_reg_reg[3] 
       (.C(I1),
        .CE(1'b1),
        .D(\n_0_wr_data_reg[3] ),
        .Q(wr_data_reg__0[3]),
        .R(wr_data1));
FDRE \wr_data_reg_reg[4] 
       (.C(I1),
        .CE(1'b1),
        .D(\n_0_wr_data_reg[4] ),
        .Q(wr_data_reg__0[4]),
        .R(wr_data1));
FDRE \wr_data_reg_reg[5] 
       (.C(I1),
        .CE(1'b1),
        .D(\n_0_wr_data_reg[5] ),
        .Q(wr_data_reg__0[5]),
        .R(wr_data1));
FDRE \wr_data_reg_reg[6] 
       (.C(I1),
        .CE(1'b1),
        .D(\n_0_wr_data_reg[6] ),
        .Q(wr_data_reg__0[6]),
        .R(wr_data1));
FDRE \wr_data_reg_reg[7] 
       (.C(I1),
        .CE(1'b1),
        .D(\n_0_wr_data_reg[7] ),
        .Q(wr_data_reg__0[7]),
        .R(wr_data1));
FDRE \wr_data_reg_reg[9] 
       (.C(I1),
        .CE(1'b1),
        .D(\n_0_wr_data_reg[9] ),
        .Q(wr_data_reg__0[9]),
        .R(wr_data1));
(* SOFT_HLUTNM = "soft_lutpair106" *) 
   LUT2 #(
    .INIT(4'h7)) 
     wr_enable_i_1
       (.I0(initialize_ram_complete),
        .I1(wr_enable1),
        .O(n_0_wr_enable_i_1));
LUT6 #(
    .INIT(64'h0080000000000000)) 
     wr_enable_i_2
       (.I0(n_0_k28p5_wr_reg_i_2),
        .I1(n_0_wr_enable_i_3),
        .I2(n_0_wr_enable_i_4),
        .I3(n_0_wr_enable_i_5),
        .I4(n_0_wr_enable_i_6),
        .I5(n_0_d16p2_wr_reg_i_2),
        .O(wr_enable1));
(* SOFT_HLUTNM = "soft_lutpair102" *) 
   LUT3 #(
    .INIT(8'h04)) 
     wr_enable_i_3
       (.I0(\n_0_wr_data_reg[17] ),
        .I1(\n_0_wr_data_reg[18] ),
        .I2(\n_0_wr_data_reg[16] ),
        .O(n_0_wr_enable_i_3));
LUT4 #(
    .INIT(16'h0800)) 
     wr_enable_i_4
       (.I0(k28p5_wr_reg),
        .I1(d16p2_wr_reg),
        .I2(remove_idle),
        .I3(wr_occupancy[5]),
        .O(n_0_wr_enable_i_4));
LUT4 #(
    .INIT(16'h0001)) 
     wr_enable_i_5
       (.I0(wr_occupancy[2]),
        .I1(wr_occupancy[1]),
        .I2(wr_occupancy[3]),
        .I3(wr_occupancy[4]),
        .O(n_0_wr_enable_i_5));
(* SOFT_HLUTNM = "soft_lutpair104" *) 
   LUT3 #(
    .INIT(8'h01)) 
     wr_enable_i_6
       (.I0(\n_0_wr_data_reg[2] ),
        .I1(\n_0_wr_data_reg[1] ),
        .I2(\n_0_wr_data_reg[0] ),
        .O(n_0_wr_enable_i_6));
FDRE wr_enable_reg
       (.C(I1),
        .CE(1'b1),
        .D(n_0_wr_enable_i_1),
        .Q(wr_enable),
        .R(rxrecreset));
LUT4 #(
    .INIT(16'h9669)) 
     \wr_occupancy[3]_i_2 
       (.I0(\n_0_wr_addr_reg[3] ),
        .I1(\n_0_reclock_rd_addrgray[4].sync_rd_addrgray ),
        .I2(p_1_in18_in),
        .I3(p_0_in),
        .O(\n_0_wr_occupancy[3]_i_2 ));
LUT5 #(
    .INIT(32'h69969669)) 
     \wr_occupancy[3]_i_3 
       (.I0(\n_0_wr_addr_reg[2] ),
        .I1(p_1_in18_in),
        .I2(p_2_in21_in),
        .I3(p_0_in),
        .I4(\n_0_reclock_rd_addrgray[4].sync_rd_addrgray ),
        .O(\n_0_wr_occupancy[3]_i_3 ));
LUT6 #(
    .INIT(64'h9669699669969669)) 
     \wr_occupancy[3]_i_4 
       (.I0(\n_0_reclock_rd_addrgray[4].sync_rd_addrgray ),
        .I1(p_1_in18_in),
        .I2(p_2_in21_in),
        .I3(p_3_in24_in),
        .I4(\n_0_wr_addr_reg[1] ),
        .I5(p_0_in),
        .O(\n_0_wr_occupancy[3]_i_4 ));
LUT6 #(
    .INIT(64'h9669699669969669)) 
     \wr_occupancy[3]_i_5 
       (.I0(\n_0_wr_addr_reg[0] ),
        .I1(p_2_in21_in),
        .I2(p_1_in18_in),
        .I3(\n_0_reclock_rd_addrgray[0].sync_rd_addrgray ),
        .I4(p_3_in24_in),
        .I5(\n_0_wr_occupancy[3]_i_6 ),
        .O(\n_0_wr_occupancy[3]_i_5 ));
LUT2 #(
    .INIT(4'h6)) 
     \wr_occupancy[3]_i_6 
       (.I0(p_0_in),
        .I1(\n_0_reclock_rd_addrgray[4].sync_rd_addrgray ),
        .O(\n_0_wr_occupancy[3]_i_6 ));
LUT2 #(
    .INIT(4'h9)) 
     \wr_occupancy[5]_i_2 
       (.I0(\n_0_wr_addr_reg[5] ),
        .I1(p_0_in),
        .O(\n_0_wr_occupancy[5]_i_2 ));
LUT3 #(
    .INIT(8'h69)) 
     \wr_occupancy[5]_i_3 
       (.I0(\n_0_wr_addr_reg[4] ),
        .I1(\n_0_reclock_rd_addrgray[4].sync_rd_addrgray ),
        .I2(p_0_in),
        .O(\n_0_wr_occupancy[5]_i_3 ));
FDRE \wr_occupancy_reg[1] 
       (.C(I1),
        .CE(1'b1),
        .D(wr_occupancy00_out[1]),
        .Q(wr_occupancy[1]),
        .R(wr_data1));
FDRE \wr_occupancy_reg[2] 
       (.C(I1),
        .CE(1'b1),
        .D(wr_occupancy00_out[2]),
        .Q(wr_occupancy[2]),
        .R(wr_data1));
FDRE \wr_occupancy_reg[3] 
       (.C(I1),
        .CE(1'b1),
        .D(wr_occupancy00_out[3]),
        .Q(wr_occupancy[3]),
        .R(wr_data1));
CARRY4 \wr_occupancy_reg[3]_i_1 
       (.CI(1'b0),
        .CO({\n_0_wr_occupancy_reg[3]_i_1 ,\n_1_wr_occupancy_reg[3]_i_1 ,\n_2_wr_occupancy_reg[3]_i_1 ,\n_3_wr_occupancy_reg[3]_i_1 }),
        .CYINIT(1'b1),
        .DI({\n_0_wr_addr_reg[3] ,\n_0_wr_addr_reg[2] ,\n_0_wr_addr_reg[1] ,\n_0_wr_addr_reg[0] }),
        .O({wr_occupancy00_out[3:1],\NLW_wr_occupancy_reg[3]_i_1_O_UNCONNECTED [0]}),
        .S({\n_0_wr_occupancy[3]_i_2 ,\n_0_wr_occupancy[3]_i_3 ,\n_0_wr_occupancy[3]_i_4 ,\n_0_wr_occupancy[3]_i_5 }));
FDRE \wr_occupancy_reg[4] 
       (.C(I1),
        .CE(1'b1),
        .D(wr_occupancy00_out[4]),
        .Q(wr_occupancy[4]),
        .R(wr_data1));
FDSE \wr_occupancy_reg[5] 
       (.C(I1),
        .CE(1'b1),
        .D(wr_occupancy00_out[5]),
        .Q(wr_occupancy[5]),
        .S(wr_data1));
CARRY4 \wr_occupancy_reg[5]_i_1 
       (.CI(\n_0_wr_occupancy_reg[3]_i_1 ),
        .CO({\NLW_wr_occupancy_reg[5]_i_1_CO_UNCONNECTED [3:1],\n_3_wr_occupancy_reg[5]_i_1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,\n_0_wr_addr_reg[4] }),
        .O({\NLW_wr_occupancy_reg[5]_i_1_O_UNCONNECTED [3:2],wr_occupancy00_out[5:4]}),
        .S({1'b0,1'b0,\n_0_wr_occupancy[5]_i_2 ,\n_0_wr_occupancy[5]_i_3 }));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_rx_rate_adapt" *) 
module gmii_to_sgmiigmii_to_sgmii_rx_rate_adapt
   (rx_dv_reg1,
    gmii_rx_dv,
    gmii_rx_er,
    Q,
    gmii_rxd,
    I1,
    I2,
    I3,
    CLK,
    RX_ER,
    I4,
    I5,
    D);
  output rx_dv_reg1;
  output gmii_rx_dv;
  output gmii_rx_er;
  output [1:0]Q;
  output [7:0]gmii_rxd;
  input I1;
  input I2;
  input I3;
  input CLK;
  input RX_ER;
  input I4;
  input I5;
  input [7:0]D;

  wire CLK;
  wire [7:0]D;
  wire I1;
  wire I2;
  wire I3;
  wire I4;
  wire I5;
  wire [1:0]Q;
  wire RX_ER;
  wire gmii_rx_dv;
  wire gmii_rx_er;
  wire [7:0]gmii_rxd;
  wire muxsel;
  wire n_0_muxsel_i_1;
  wire n_0_rx_dv_aligned_i_1;
  wire \n_0_rxd_aligned[0]_i_1 ;
  wire \n_0_rxd_aligned[1]_i_1 ;
  wire \n_0_rxd_aligned[2]_i_1 ;
  wire \n_0_rxd_aligned[3]_i_1 ;
  wire \n_0_rxd_aligned[4]_i_1 ;
  wire \n_0_rxd_aligned[5]_i_1 ;
  wire \n_0_rxd_aligned[6]_i_1 ;
  wire \n_0_rxd_aligned[7]_i_1 ;
  wire \n_0_rxd_reg1_reg[0] ;
  wire \n_0_rxd_reg1_reg[1] ;
  wire \n_0_rxd_reg1_reg[2] ;
  wire \n_0_rxd_reg1_reg[3] ;
  wire n_0_sfd_enable_i_1;
  wire n_0_sfd_enable_i_2;
  wire n_0_sfd_enable_i_4;
  wire n_0_sfd_enable_i_6;
  wire [1:0]p_0_in;
  wire rx_dv_aligned;
  wire rx_dv_reg1;
  wire rx_dv_reg2;
  wire rx_er_aligned;
  wire rx_er_aligned_0;
  wire rx_er_reg1;
  wire rx_er_reg2;
  wire [7:0]rxd_aligned;
  wire [7:0]rxd_reg2;
  wire sfd_enable;

FDRE gmii_rx_dv_out_reg
       (.C(CLK),
        .CE(I2),
        .D(rx_dv_aligned),
        .Q(gmii_rx_dv),
        .R(I1));
FDRE gmii_rx_er_out_reg
       (.C(CLK),
        .CE(I2),
        .D(rx_er_aligned),
        .Q(gmii_rx_er),
        .R(I1));
FDRE \gmii_rxd_out_reg[0] 
       (.C(CLK),
        .CE(I2),
        .D(rxd_aligned[0]),
        .Q(gmii_rxd[0]),
        .R(I1));
FDRE \gmii_rxd_out_reg[1] 
       (.C(CLK),
        .CE(I2),
        .D(rxd_aligned[1]),
        .Q(gmii_rxd[1]),
        .R(I1));
FDRE \gmii_rxd_out_reg[2] 
       (.C(CLK),
        .CE(I2),
        .D(rxd_aligned[2]),
        .Q(gmii_rxd[2]),
        .R(I1));
FDRE \gmii_rxd_out_reg[3] 
       (.C(CLK),
        .CE(I2),
        .D(rxd_aligned[3]),
        .Q(gmii_rxd[3]),
        .R(I1));
FDRE \gmii_rxd_out_reg[4] 
       (.C(CLK),
        .CE(I2),
        .D(rxd_aligned[4]),
        .Q(gmii_rxd[4]),
        .R(I1));
FDRE \gmii_rxd_out_reg[5] 
       (.C(CLK),
        .CE(I2),
        .D(rxd_aligned[5]),
        .Q(gmii_rxd[5]),
        .R(I1));
FDRE \gmii_rxd_out_reg[6] 
       (.C(CLK),
        .CE(I2),
        .D(rxd_aligned[6]),
        .Q(gmii_rxd[6]),
        .R(I1));
FDRE \gmii_rxd_out_reg[7] 
       (.C(CLK),
        .CE(I2),
        .D(rxd_aligned[7]),
        .Q(gmii_rxd[7]),
        .R(I1));
LUT6 #(
    .INIT(64'h000000000EAAAAAA)) 
     muxsel_i_1
       (.I0(muxsel),
        .I1(n_0_sfd_enable_i_2),
        .I2(n_0_sfd_enable_i_4),
        .I3(sfd_enable),
        .I4(I2),
        .I5(I1),
        .O(n_0_muxsel_i_1));
FDRE muxsel_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_muxsel_i_1),
        .Q(muxsel),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair63" *) 
   LUT3 #(
    .INIT(8'h8A)) 
     rx_dv_aligned_i_1
       (.I0(rx_dv_reg2),
        .I1(rx_dv_reg1),
        .I2(muxsel),
        .O(n_0_rx_dv_aligned_i_1));
FDRE rx_dv_aligned_reg
       (.C(CLK),
        .CE(I2),
        .D(n_0_rx_dv_aligned_i_1),
        .Q(rx_dv_aligned),
        .R(I1));
FDRE rx_dv_reg1_reg
       (.C(CLK),
        .CE(I2),
        .D(I3),
        .Q(rx_dv_reg1),
        .R(I1));
FDRE rx_dv_reg2_reg
       (.C(CLK),
        .CE(I2),
        .D(rx_dv_reg1),
        .Q(rx_dv_reg2),
        .R(I1));
(* SOFT_HLUTNM = "soft_lutpair63" *) 
   LUT3 #(
    .INIT(8'hEA)) 
     rx_er_aligned_i_1
       (.I0(rx_er_reg2),
        .I1(rx_er_reg1),
        .I2(muxsel),
        .O(rx_er_aligned_0));
FDRE rx_er_aligned_reg
       (.C(CLK),
        .CE(I2),
        .D(rx_er_aligned_0),
        .Q(rx_er_aligned),
        .R(I1));
FDRE rx_er_reg1_reg
       (.C(CLK),
        .CE(I2),
        .D(RX_ER),
        .Q(rx_er_reg1),
        .R(I1));
FDRE rx_er_reg2_reg
       (.C(CLK),
        .CE(I2),
        .D(rx_er_reg1),
        .Q(rx_er_reg2),
        .R(I1));
(* SOFT_HLUTNM = "soft_lutpair67" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \rxd_aligned[0]_i_1 
       (.I0(rxd_reg2[4]),
        .I1(muxsel),
        .I2(rxd_reg2[0]),
        .O(\n_0_rxd_aligned[0]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair66" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \rxd_aligned[1]_i_1 
       (.I0(rxd_reg2[5]),
        .I1(muxsel),
        .I2(rxd_reg2[1]),
        .O(\n_0_rxd_aligned[1]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair65" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \rxd_aligned[2]_i_1 
       (.I0(rxd_reg2[6]),
        .I1(muxsel),
        .I2(rxd_reg2[2]),
        .O(\n_0_rxd_aligned[2]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair64" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \rxd_aligned[3]_i_1 
       (.I0(rxd_reg2[7]),
        .I1(muxsel),
        .I2(rxd_reg2[3]),
        .O(\n_0_rxd_aligned[3]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair67" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \rxd_aligned[4]_i_1 
       (.I0(\n_0_rxd_reg1_reg[0] ),
        .I1(muxsel),
        .I2(rxd_reg2[4]),
        .O(\n_0_rxd_aligned[4]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair66" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \rxd_aligned[5]_i_1 
       (.I0(\n_0_rxd_reg1_reg[1] ),
        .I1(muxsel),
        .I2(rxd_reg2[5]),
        .O(\n_0_rxd_aligned[5]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair65" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \rxd_aligned[6]_i_1 
       (.I0(\n_0_rxd_reg1_reg[2] ),
        .I1(muxsel),
        .I2(rxd_reg2[6]),
        .O(\n_0_rxd_aligned[6]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair64" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \rxd_aligned[7]_i_1 
       (.I0(\n_0_rxd_reg1_reg[3] ),
        .I1(muxsel),
        .I2(rxd_reg2[7]),
        .O(\n_0_rxd_aligned[7]_i_1 ));
FDRE \rxd_aligned_reg[0] 
       (.C(CLK),
        .CE(I2),
        .D(\n_0_rxd_aligned[0]_i_1 ),
        .Q(rxd_aligned[0]),
        .R(I1));
FDRE \rxd_aligned_reg[1] 
       (.C(CLK),
        .CE(I2),
        .D(\n_0_rxd_aligned[1]_i_1 ),
        .Q(rxd_aligned[1]),
        .R(I1));
FDRE \rxd_aligned_reg[2] 
       (.C(CLK),
        .CE(I2),
        .D(\n_0_rxd_aligned[2]_i_1 ),
        .Q(rxd_aligned[2]),
        .R(I1));
FDRE \rxd_aligned_reg[3] 
       (.C(CLK),
        .CE(I2),
        .D(\n_0_rxd_aligned[3]_i_1 ),
        .Q(rxd_aligned[3]),
        .R(I1));
FDRE \rxd_aligned_reg[4] 
       (.C(CLK),
        .CE(I2),
        .D(\n_0_rxd_aligned[4]_i_1 ),
        .Q(rxd_aligned[4]),
        .R(I1));
FDRE \rxd_aligned_reg[5] 
       (.C(CLK),
        .CE(I2),
        .D(\n_0_rxd_aligned[5]_i_1 ),
        .Q(rxd_aligned[5]),
        .R(I1));
FDRE \rxd_aligned_reg[6] 
       (.C(CLK),
        .CE(I2),
        .D(\n_0_rxd_aligned[6]_i_1 ),
        .Q(rxd_aligned[6]),
        .R(I1));
FDRE \rxd_aligned_reg[7] 
       (.C(CLK),
        .CE(I2),
        .D(\n_0_rxd_aligned[7]_i_1 ),
        .Q(rxd_aligned[7]),
        .R(I1));
FDRE \rxd_reg1_reg[0] 
       (.C(CLK),
        .CE(I2),
        .D(D[0]),
        .Q(\n_0_rxd_reg1_reg[0] ),
        .R(I1));
FDRE \rxd_reg1_reg[1] 
       (.C(CLK),
        .CE(I2),
        .D(D[1]),
        .Q(\n_0_rxd_reg1_reg[1] ),
        .R(I1));
FDRE \rxd_reg1_reg[2] 
       (.C(CLK),
        .CE(I2),
        .D(D[2]),
        .Q(\n_0_rxd_reg1_reg[2] ),
        .R(I1));
FDRE \rxd_reg1_reg[3] 
       (.C(CLK),
        .CE(I2),
        .D(D[3]),
        .Q(\n_0_rxd_reg1_reg[3] ),
        .R(I1));
FDRE \rxd_reg1_reg[4] 
       (.C(CLK),
        .CE(I2),
        .D(D[4]),
        .Q(p_0_in[0]),
        .R(I1));
FDRE \rxd_reg1_reg[5] 
       (.C(CLK),
        .CE(I2),
        .D(D[5]),
        .Q(p_0_in[1]),
        .R(I1));
FDRE \rxd_reg1_reg[6] 
       (.C(CLK),
        .CE(I2),
        .D(D[6]),
        .Q(Q[0]),
        .R(I1));
FDRE \rxd_reg1_reg[7] 
       (.C(CLK),
        .CE(I2),
        .D(D[7]),
        .Q(Q[1]),
        .R(I1));
FDRE \rxd_reg2_reg[0] 
       (.C(CLK),
        .CE(I2),
        .D(\n_0_rxd_reg1_reg[0] ),
        .Q(rxd_reg2[0]),
        .R(I1));
FDRE \rxd_reg2_reg[1] 
       (.C(CLK),
        .CE(I2),
        .D(\n_0_rxd_reg1_reg[1] ),
        .Q(rxd_reg2[1]),
        .R(I1));
FDRE \rxd_reg2_reg[2] 
       (.C(CLK),
        .CE(I2),
        .D(\n_0_rxd_reg1_reg[2] ),
        .Q(rxd_reg2[2]),
        .R(I1));
FDRE \rxd_reg2_reg[3] 
       (.C(CLK),
        .CE(I2),
        .D(\n_0_rxd_reg1_reg[3] ),
        .Q(rxd_reg2[3]),
        .R(I1));
FDRE \rxd_reg2_reg[4] 
       (.C(CLK),
        .CE(I2),
        .D(p_0_in[0]),
        .Q(rxd_reg2[4]),
        .R(I1));
FDRE \rxd_reg2_reg[5] 
       (.C(CLK),
        .CE(I2),
        .D(p_0_in[1]),
        .Q(rxd_reg2[5]),
        .R(I1));
FDRE \rxd_reg2_reg[6] 
       (.C(CLK),
        .CE(I2),
        .D(Q[0]),
        .Q(rxd_reg2[6]),
        .R(I1));
FDRE \rxd_reg2_reg[7] 
       (.C(CLK),
        .CE(I2),
        .D(Q[1]),
        .Q(rxd_reg2[7]),
        .R(I1));
LUT6 #(
    .INIT(64'h5051555550500000)) 
     sfd_enable_i_1
       (.I0(I1),
        .I1(n_0_sfd_enable_i_2),
        .I2(I5),
        .I3(n_0_sfd_enable_i_4),
        .I4(I2),
        .I5(sfd_enable),
        .O(n_0_sfd_enable_i_1));
(* SOFT_HLUTNM = "soft_lutpair62" *) 
   LUT3 #(
    .INIT(8'h08)) 
     sfd_enable_i_2
       (.I0(I4),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .O(n_0_sfd_enable_i_2));
(* SOFT_HLUTNM = "soft_lutpair62" *) 
   LUT3 #(
    .INIT(8'h08)) 
     sfd_enable_i_4
       (.I0(n_0_sfd_enable_i_6),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .O(n_0_sfd_enable_i_4));
LUT6 #(
    .INIT(64'h0000000040000000)) 
     sfd_enable_i_6
       (.I0(\n_0_rxd_reg1_reg[3] ),
        .I1(\n_0_rxd_reg1_reg[0] ),
        .I2(Q[0]),
        .I3(Q[1]),
        .I4(\n_0_rxd_reg1_reg[2] ),
        .I5(\n_0_rxd_reg1_reg[1] ),
        .O(n_0_sfd_enable_i_6));
FDRE sfd_enable_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_sfd_enable_i_1),
        .Q(sfd_enable),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_sgmii_adapt" *) 
module gmii_to_sgmiigmii_to_sgmii_sgmii_adapt
   (sgmii_clk_r,
    O1,
    rx_dv_reg1,
    gmii_rx_dv,
    gmii_rx_er,
    O2,
    O3,
    sgmii_clk_f,
    Q,
    O4,
    O5,
    gmii_rxd,
    SR,
    CLK,
    speed_is_10_100,
    speed_is_100,
    I1,
    RX_ER,
    gmii_tx_er,
    gmii_tx_en,
    I2,
    I3,
    I4,
    gmii_txd,
    D);
  output sgmii_clk_r;
  output O1;
  output rx_dv_reg1;
  output gmii_rx_dv;
  output gmii_rx_er;
  output O2;
  output O3;
  output sgmii_clk_f;
  output [1:0]Q;
  output [7:0]O4;
  output O5;
  output [7:0]gmii_rxd;
  input [0:0]SR;
  input CLK;
  input speed_is_10_100;
  input speed_is_100;
  input I1;
  input RX_ER;
  input gmii_tx_er;
  input gmii_tx_en;
  input I2;
  input I3;
  input I4;
  input [7:0]gmii_txd;
  input [7:0]D;

  wire CLK;
  wire [7:0]D;
  wire I1;
  wire I2;
  wire I3;
  wire I4;
  wire O1;
  wire O2;
  wire O3;
  wire [7:0]O4;
  wire O5;
  wire [1:0]Q;
  wire RX_ER;
  wire [0:0]SR;
  wire gmii_rx_dv;
  wire gmii_rx_er;
  wire [7:0]gmii_rxd;
  wire gmii_tx_en;
  wire gmii_tx_er;
  wire [7:0]gmii_txd;
  wire n_0_gen_sync_reset;
  wire n_0_resync_speed_100;
  wire n_0_resync_speed_10_100;
  wire rx_dv_reg1;
  wire sgmii_clk_f;
  wire sgmii_clk_r;
  wire speed_is_100;
  wire speed_is_10_100;

gmii_to_sgmiigmii_to_sgmii_clk_gen clock_generation
       (.CLK(CLK),
        .I1(n_0_resync_speed_100),
        .I2(n_0_resync_speed_10_100),
        .I3(n_0_gen_sync_reset),
        .O1(O1),
        .sgmii_clk_f(sgmii_clk_f),
        .sgmii_clk_r(sgmii_clk_r));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b11" *) 
   gmii_to_sgmiigmii_to_sgmii_reset_sync__6 gen_sync_reset
       (.clk(CLK),
        .reset_in(SR),
        .reset_out(n_0_gen_sync_reset));
gmii_to_sgmiigmii_to_sgmii_rx_rate_adapt receiver
       (.CLK(CLK),
        .D(D),
        .I1(n_0_gen_sync_reset),
        .I2(O1),
        .I3(I1),
        .I4(I2),
        .I5(I3),
        .Q(Q),
        .RX_ER(RX_ER),
        .gmii_rx_dv(gmii_rx_dv),
        .gmii_rx_er(gmii_rx_er),
        .gmii_rxd(gmii_rxd),
        .rx_dv_reg1(rx_dv_reg1));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gmii_to_sgmiigmii_to_sgmii_sync_block__5 resync_speed_100
       (.clk(CLK),
        .data_in(speed_is_100),
        .data_out(n_0_resync_speed_100));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gmii_to_sgmiigmii_to_sgmii_sync_block__4 resync_speed_10_100
       (.clk(CLK),
        .data_in(speed_is_10_100),
        .data_out(n_0_resync_speed_10_100));
gmii_to_sgmiigmii_to_sgmii_tx_rate_adapt transmitter
       (.CLK(CLK),
        .E(O1),
        .I1(n_0_gen_sync_reset),
        .I4(I4),
        .O2(O2),
        .O3(O3),
        .O4(O4),
        .O5(O5),
        .gmii_tx_en(gmii_tx_en),
        .gmii_tx_er(gmii_tx_er),
        .gmii_txd(gmii_txd));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_support" *) 
module gmii_to_sgmiigmii_to_sgmii_support
   (userclk2_out,
    mmcm_locked_out,
    status_vector,
    rxuserclk2_out,
    userclk_out,
    txn,
    txp,
    gtrefclk_out,
    gt0_qplloutclk_out,
    gt0_qplloutrefclk_out,
    Q,
    resetdone,
    sgmii_clk_r,
    sgmii_clk_en,
    O1,
    gmii_rxd,
    gmii_rx_dv,
    gmii_rx_er,
    an_interrupt,
    sgmii_clk_f,
    an_restart_config,
    reset,
    speed_is_10_100,
    speed_is_100,
    signal_detect,
    independent_clock_bufg,
    rxn,
    rxp,
    gtrefclk_p,
    gtrefclk_n,
    configuration_vector,
    gmii_txd,
    gmii_tx_er,
    gmii_tx_en,
    an_adv_config_vector);
  output userclk2_out;
  output mmcm_locked_out;
  output [12:0]status_vector;
  output rxuserclk2_out;
  output userclk_out;
  output txn;
  output txp;
  output gtrefclk_out;
  output gt0_qplloutclk_out;
  output gt0_qplloutrefclk_out;
  output [0:0]Q;
  output resetdone;
  output sgmii_clk_r;
  output sgmii_clk_en;
  output [0:0]O1;
  output [7:0]gmii_rxd;
  output gmii_rx_dv;
  output gmii_rx_er;
  output an_interrupt;
  output sgmii_clk_f;
  input an_restart_config;
  input reset;
  input speed_is_10_100;
  input speed_is_100;
  input signal_detect;
  input independent_clock_bufg;
  input rxn;
  input rxp;
  input gtrefclk_p;
  input gtrefclk_n;
  input [4:0]configuration_vector;
  input [7:0]gmii_txd;
  input gmii_tx_er;
  input gmii_tx_en;
  input [0:0]an_adv_config_vector;

  wire [0:0]O1;
  wire [0:0]Q;
  wire [0:0]an_adv_config_vector;
  wire an_interrupt;
  wire an_restart_config;
  wire [4:0]configuration_vector;
  wire gmii_rx_dv;
  wire gmii_rx_er;
  wire [7:0]gmii_rxd;
  wire gmii_tx_en;
  wire gmii_tx_er;
  wire [7:0]gmii_txd;
  wire gt0_qplloutclk_out;
  wire gt0_qplloutrefclk_out;
  wire gtrefclk_n;
  wire gtrefclk_out;
  wire gtrefclk_p;
  wire independent_clock_bufg;
  wire mmcm_locked_out;
  wire n_0_core_clocking_i;
  wire reset;
  wire resetdone;
  wire rxn;
  wire rxp;
  wire rxuserclk2_out;
  wire sgmii_clk_en;
  wire sgmii_clk_f;
  wire sgmii_clk_r;
  wire signal_detect;
  wire speed_is_100;
  wire speed_is_10_100;
  wire [12:0]status_vector;
  wire txn;
  wire txoutclk;
  wire txp;
  wire userclk2_out;
  wire userclk_out;

gmii_to_sgmiigmii_to_sgmii_clocking core_clocking_i
       (.AS(n_0_core_clocking_i),
        .gtrefclk_n(gtrefclk_n),
        .gtrefclk_out(gtrefclk_out),
        .gtrefclk_p(gtrefclk_p),
        .mmcm_locked(mmcm_locked_out),
        .reset(reset),
        .txoutclk(txoutclk),
        .userclk(userclk_out),
        .userclk2(userclk2_out));
gmii_to_sgmiigmii_to_sgmii_gt_common core_gt_common_i
       (.Q(Q),
        .gt0_qplloutclk_out(gt0_qplloutclk_out),
        .gt0_qplloutrefclk_out(gt0_qplloutrefclk_out),
        .gtrefclk_out(gtrefclk_out),
        .independent_clock_bufg(independent_clock_bufg));
gmii_to_sgmiigmii_to_sgmii_resets core_resets_i
       (.AS(n_0_core_clocking_i),
        .Q(Q),
        .independent_clock_bufg(independent_clock_bufg));
gmii_to_sgmiigmii_to_sgmii_block pcs_pma_block_i
       (.AR(Q),
        .AS(n_0_core_clocking_i),
        .CLK(userclk2_out),
        .I1(userclk_out),
        .O1(rxuserclk2_out),
        .O2(sgmii_clk_en),
        .Q(O1),
        .an_adv_config_vector(an_adv_config_vector),
        .an_interrupt(an_interrupt),
        .an_restart_config(an_restart_config),
        .configuration_vector(configuration_vector),
        .gmii_rx_dv(gmii_rx_dv),
        .gmii_rx_er(gmii_rx_er),
        .gmii_rxd(gmii_rxd),
        .gmii_tx_en(gmii_tx_en),
        .gmii_tx_er(gmii_tx_er),
        .gmii_txd(gmii_txd),
        .gt0_qplloutclk_out(gt0_qplloutclk_out),
        .gt0_qplloutrefclk_out(gt0_qplloutrefclk_out),
        .gtrefclk_out(gtrefclk_out),
        .independent_clock_bufg(independent_clock_bufg),
        .mmcm_locked_out(mmcm_locked_out),
        .resetdone(resetdone),
        .rxn(rxn),
        .rxp(rxp),
        .sgmii_clk_f(sgmii_clk_f),
        .sgmii_clk_r(sgmii_clk_r),
        .signal_detect(signal_detect),
        .speed_is_100(speed_is_100),
        .speed_is_10_100(speed_is_10_100),
        .status_vector(status_vector),
        .txn(txn),
        .txoutclk(txoutclk),
        .txp(txp));
endmodule

(* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) (* ORIG_REF_NAME = "gmii_to_sgmii_sync_block" *) 
module gmii_to_sgmiigmii_to_sgmii_sync_block
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gmii_to_sgmiigmii_to_sgmii_sync_block__10
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gmii_to_sgmiigmii_to_sgmii_sync_block__11
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gmii_to_sgmiigmii_to_sgmii_sync_block__12
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gmii_to_sgmiigmii_to_sgmii_sync_block__13
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gmii_to_sgmiigmii_to_sgmii_sync_block__14
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gmii_to_sgmiigmii_to_sgmii_sync_block__15
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gmii_to_sgmiigmii_to_sgmii_sync_block__16
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gmii_to_sgmiigmii_to_sgmii_sync_block__17
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gmii_to_sgmiigmii_to_sgmii_sync_block__4
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gmii_to_sgmiigmii_to_sgmii_sync_block__5
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gmii_to_sgmiigmii_to_sgmii_sync_block__6
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gmii_to_sgmiigmii_to_sgmii_sync_block__7
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gmii_to_sgmiigmii_to_sgmii_sync_block__8
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gmii_to_sgmiigmii_to_sgmii_sync_block__9
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gmii_to_sgmiigmii_to_sgmii_sync_block__parameterized0
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gmii_to_sgmiigmii_to_sgmii_sync_block__parameterized0__18
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gmii_to_sgmiigmii_to_sgmii_sync_block__parameterized0__19
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gmii_to_sgmiigmii_to_sgmii_sync_block__parameterized0__20
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gmii_to_sgmiigmii_to_sgmii_sync_block__parameterized0__21
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gmii_to_sgmiigmii_to_sgmii_sync_block__parameterized0__22
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gmii_to_sgmiigmii_to_sgmii_sync_block__parameterized0__23
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gmii_to_sgmiigmii_to_sgmii_sync_block__parameterized0__24
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gmii_to_sgmiigmii_to_sgmii_sync_block__parameterized0__25
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gmii_to_sgmiigmii_to_sgmii_sync_block__parameterized0__26
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gmii_to_sgmiigmii_to_sgmii_sync_block__parameterized0__27
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gmii_to_sgmiigmii_to_sgmii_sync_block__parameterized0__28
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gmii_to_sgmiigmii_to_sgmii_sync_block__parameterized0__29
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gmii_to_sgmiigmii_to_sgmii_sync_block__parameterized0__30
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gmii_to_sgmiigmii_to_sgmii_sync_block__parameterized0__31
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gmii_to_sgmiigmii_to_sgmii_sync_block__parameterized0__32
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gmii_to_sgmiigmii_to_sgmii_sync_block__parameterized0__33
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gmii_to_sgmiigmii_to_sgmii_sync_block__parameterized0__34
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_transceiver" *) 
module gmii_to_sgmiigmii_to_sgmii_transceiver__parameterized0
   (txn,
    txp,
    I_0,
    txoutclk,
    rxnotintable_usr,
    txbuferr,
    rxdisperr_usr,
    rxchariscomma,
    rxcharisk,
    rxbuferr,
    resetdone,
    O1,
    I7,
    encommaalign,
    I1,
    SR,
    I2,
    rxreset,
    independent_clock_bufg,
    CLK,
    rxn,
    rxp,
    gtrefclk_out,
    gt0_qplloutclk_out,
    gt0_qplloutrefclk_out,
    mmcm_locked_out,
    Q,
    D,
    I3,
    I4,
    status_vector,
    AR,
    I5);
  output txn;
  output txp;
  output I_0;
  output txoutclk;
  output rxnotintable_usr;
  output txbuferr;
  output rxdisperr_usr;
  output rxchariscomma;
  output rxcharisk;
  output rxbuferr;
  output resetdone;
  output [7:0]O1;
  output [1:0]I7;
  input encommaalign;
  input I1;
  input [0:0]SR;
  input I2;
  input rxreset;
  input independent_clock_bufg;
  input CLK;
  input rxn;
  input rxp;
  input gtrefclk_out;
  input gt0_qplloutclk_out;
  input gt0_qplloutrefclk_out;
  input mmcm_locked_out;
  input [0:0]Q;
  input [0:0]D;
  input [0:0]I3;
  input [0:0]I4;
  input [0:0]status_vector;
  input [0:0]AR;
  input [7:0]I5;

  wire [0:0]AR;
  wire CLK;
  wire [0:0]D;
  wire I1;
  wire I2;
  wire [0:0]I3;
  wire [0:0]I4;
  wire [7:0]I5;
  wire [1:0]I7;
  wire I_0;
  wire [7:0]O1;
  wire [0:0]Q;
  wire [0:0]SR;
  wire data_out;
  wire data_valid_reg;
  wire encommaalign;
  wire gt0_qplloutclk_out;
  wire gt0_qplloutrefclk_out;
  wire gt0_rxmcommaalignen_in;
  wire gtrefclk_out;
  wire independent_clock_bufg;
  wire mmcm_locked_out;
  wire n_0_toggle_i_1;
  wire \n_0_txbufstatus_reg_reg[1] ;
  wire n_4_gtwizard_inst;
  wire reset_out;
  wire resetdone;
  wire rxbuferr;
  wire rxchariscomma;
  wire [1:0]rxchariscomma_rec;
  wire rxcharisk;
  wire [1:0]rxcharisk_rec;
  wire [15:0]rxdata_rec;
  wire [1:0]rxdisperr_rec;
  wire rxdisperr_usr;
  wire rxn;
  wire [1:0]rxnotintable_rec;
  wire rxnotintable_usr;
  wire rxp;
  wire rxpowerdown_reg;
  wire rxrecreset;
  wire rxreset;
  wire [0:0]status_vector;
  wire toggle;
  wire txbuferr;
  wire [1:0]txchardispmode_double;
  wire [1:0]txchardispmode_int;
  wire txchardispmode_reg;
  wire [1:0]txchardispval_double;
  wire [1:0]txchardispval_int;
  wire txchardispval_reg;
  wire [1:0]txcharisk_double;
  wire [1:0]txcharisk_int;
  wire txcharisk_reg;
  wire [15:0]txdata_double;
  wire [15:0]txdata_int;
  wire [7:0]txdata_reg;
  wire txn;
  wire txoutclk;
  wire txp;
  wire txpowerdown;
  wire txpowerdown_double;
  wire txpowerdown_reg__0;

FDRE data_valid_reg_reg
       (.C(CLK),
        .CE(1'b1),
        .D(status_vector),
        .Q(data_valid_reg),
        .R(1'b0));
gmii_to_sgmiigmii_to_sgmii_GTWIZARD__parameterized0 gtwizard_inst
       (.AR(AR),
        .CLK(CLK),
        .D({rxchariscomma_rec[0],rxcharisk_rec[0],rxdisperr_rec[0],rxnotintable_rec[0],rxdata_rec[7:0],rxchariscomma_rec[1],rxcharisk_rec[1],rxdisperr_rec[1],rxnotintable_rec[1],rxdata_rec[15:8]}),
        .I1(I1),
        .I2(I2),
        .I3(txchardispmode_int),
        .I4(txchardispval_int),
        .I5(txcharisk_int),
        .I_0(I_0),
        .Q(txdata_int),
        .RXPD(rxpowerdown_reg),
        .TXBUFSTATUS(n_4_gtwizard_inst),
        .TXPD(txpowerdown),
        .data_out(data_out),
        .gt0_qplloutclk_out(gt0_qplloutclk_out),
        .gt0_qplloutrefclk_out(gt0_qplloutrefclk_out),
        .gt0_rxmcommaalignen_in(gt0_rxmcommaalignen_in),
        .gtrefclk_out(gtrefclk_out),
        .independent_clock_bufg(independent_clock_bufg),
        .mmcm_locked_out(mmcm_locked_out),
        .reset_out(reset_out),
        .resetdone(resetdone),
        .rxn(rxn),
        .rxp(rxp),
        .rxreset(rxreset),
        .txn(txn),
        .txoutclk(txoutclk),
        .txp(txp));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b11" *) 
   gmii_to_sgmiigmii_to_sgmii_reset_sync__7 reclock_encommaalign
       (.clk(I1),
        .reset_in(encommaalign),
        .reset_out(gt0_rxmcommaalignen_in));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b11" *) 
   gmii_to_sgmiigmii_to_sgmii_reset_sync__9 reclock_rxreset
       (.clk(I1),
        .reset_in(rxreset),
        .reset_out(rxrecreset));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b11" *) 
   gmii_to_sgmiigmii_to_sgmii_reset_sync__8 reclock_txreset
       (.clk(I2),
        .reset_in(SR),
        .reset_out(reset_out));
gmii_to_sgmiigmii_to_sgmii_rx_elastic_buffer rx_elastic_buffer_inst
       (.CLK(CLK),
        .D({rxchariscomma_rec[0],rxcharisk_rec[0],rxdisperr_rec[0],rxnotintable_rec[0],rxdata_rec[7:0],rxchariscomma_rec[1],rxcharisk_rec[1],rxdisperr_rec[1],rxnotintable_rec[1],rxdata_rec[15:8]}),
        .I1(I1),
        .I7(I7),
        .O1(O1),
        .rxbuferr(rxbuferr),
        .rxchariscomma(rxchariscomma),
        .rxcharisk(rxcharisk),
        .rxdisperr_usr(rxdisperr_usr),
        .rxnotintable_usr(rxnotintable_usr),
        .rxrecreset(rxrecreset),
        .rxreset(rxreset));
FDRE #(
    .INIT(1'b0)) 
     rxpowerdown_reg_reg
       (.C(CLK),
        .CE(1'b1),
        .D(Q),
        .Q(rxpowerdown_reg),
        .R(rxreset));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gmii_to_sgmiigmii_to_sgmii_sync_block__parameterized0__34 sync_block_data_valid
       (.clk(independent_clock_bufg),
        .data_in(data_valid_reg),
        .data_out(data_out));
LUT1 #(
    .INIT(2'h1)) 
     toggle_i_1
       (.I0(toggle),
        .O(n_0_toggle_i_1));
FDRE toggle_reg
       (.C(CLK),
        .CE(1'b1),
        .D(n_0_toggle_i_1),
        .Q(toggle),
        .R(SR));
FDRE txbuferr_reg
       (.C(CLK),
        .CE(1'b1),
        .D(\n_0_txbufstatus_reg_reg[1] ),
        .Q(txbuferr),
        .R(1'b0));
FDRE \txbufstatus_reg_reg[1] 
       (.C(I2),
        .CE(1'b1),
        .D(n_4_gtwizard_inst),
        .Q(\n_0_txbufstatus_reg_reg[1] ),
        .R(1'b0));
FDRE \txchardispmode_double_reg[0] 
       (.C(CLK),
        .CE(n_0_toggle_i_1),
        .D(txchardispmode_reg),
        .Q(txchardispmode_double[0]),
        .R(SR));
FDRE \txchardispmode_double_reg[1] 
       (.C(CLK),
        .CE(n_0_toggle_i_1),
        .D(D),
        .Q(txchardispmode_double[1]),
        .R(SR));
FDRE \txchardispmode_int_reg[0] 
       (.C(I2),
        .CE(1'b1),
        .D(txchardispmode_double[0]),
        .Q(txchardispmode_int[0]),
        .R(1'b0));
FDRE \txchardispmode_int_reg[1] 
       (.C(I2),
        .CE(1'b1),
        .D(txchardispmode_double[1]),
        .Q(txchardispmode_int[1]),
        .R(1'b0));
FDRE txchardispmode_reg_reg
       (.C(CLK),
        .CE(1'b1),
        .D(D),
        .Q(txchardispmode_reg),
        .R(SR));
FDRE \txchardispval_double_reg[0] 
       (.C(CLK),
        .CE(n_0_toggle_i_1),
        .D(txchardispval_reg),
        .Q(txchardispval_double[0]),
        .R(SR));
FDRE \txchardispval_double_reg[1] 
       (.C(CLK),
        .CE(n_0_toggle_i_1),
        .D(I3),
        .Q(txchardispval_double[1]),
        .R(SR));
FDRE \txchardispval_int_reg[0] 
       (.C(I2),
        .CE(1'b1),
        .D(txchardispval_double[0]),
        .Q(txchardispval_int[0]),
        .R(1'b0));
FDRE \txchardispval_int_reg[1] 
       (.C(I2),
        .CE(1'b1),
        .D(txchardispval_double[1]),
        .Q(txchardispval_int[1]),
        .R(1'b0));
FDRE txchardispval_reg_reg
       (.C(CLK),
        .CE(1'b1),
        .D(I3),
        .Q(txchardispval_reg),
        .R(SR));
FDRE \txcharisk_double_reg[0] 
       (.C(CLK),
        .CE(n_0_toggle_i_1),
        .D(txcharisk_reg),
        .Q(txcharisk_double[0]),
        .R(SR));
FDRE \txcharisk_double_reg[1] 
       (.C(CLK),
        .CE(n_0_toggle_i_1),
        .D(I4),
        .Q(txcharisk_double[1]),
        .R(SR));
FDRE \txcharisk_int_reg[0] 
       (.C(I2),
        .CE(1'b1),
        .D(txcharisk_double[0]),
        .Q(txcharisk_int[0]),
        .R(1'b0));
FDRE \txcharisk_int_reg[1] 
       (.C(I2),
        .CE(1'b1),
        .D(txcharisk_double[1]),
        .Q(txcharisk_int[1]),
        .R(1'b0));
FDRE txcharisk_reg_reg
       (.C(CLK),
        .CE(1'b1),
        .D(I4),
        .Q(txcharisk_reg),
        .R(SR));
FDRE \txdata_double_reg[0] 
       (.C(CLK),
        .CE(n_0_toggle_i_1),
        .D(txdata_reg[0]),
        .Q(txdata_double[0]),
        .R(SR));
FDRE \txdata_double_reg[10] 
       (.C(CLK),
        .CE(n_0_toggle_i_1),
        .D(I5[2]),
        .Q(txdata_double[10]),
        .R(SR));
FDRE \txdata_double_reg[11] 
       (.C(CLK),
        .CE(n_0_toggle_i_1),
        .D(I5[3]),
        .Q(txdata_double[11]),
        .R(SR));
FDRE \txdata_double_reg[12] 
       (.C(CLK),
        .CE(n_0_toggle_i_1),
        .D(I5[4]),
        .Q(txdata_double[12]),
        .R(SR));
FDRE \txdata_double_reg[13] 
       (.C(CLK),
        .CE(n_0_toggle_i_1),
        .D(I5[5]),
        .Q(txdata_double[13]),
        .R(SR));
FDRE \txdata_double_reg[14] 
       (.C(CLK),
        .CE(n_0_toggle_i_1),
        .D(I5[6]),
        .Q(txdata_double[14]),
        .R(SR));
FDRE \txdata_double_reg[15] 
       (.C(CLK),
        .CE(n_0_toggle_i_1),
        .D(I5[7]),
        .Q(txdata_double[15]),
        .R(SR));
FDRE \txdata_double_reg[1] 
       (.C(CLK),
        .CE(n_0_toggle_i_1),
        .D(txdata_reg[1]),
        .Q(txdata_double[1]),
        .R(SR));
FDRE \txdata_double_reg[2] 
       (.C(CLK),
        .CE(n_0_toggle_i_1),
        .D(txdata_reg[2]),
        .Q(txdata_double[2]),
        .R(SR));
FDRE \txdata_double_reg[3] 
       (.C(CLK),
        .CE(n_0_toggle_i_1),
        .D(txdata_reg[3]),
        .Q(txdata_double[3]),
        .R(SR));
FDRE \txdata_double_reg[4] 
       (.C(CLK),
        .CE(n_0_toggle_i_1),
        .D(txdata_reg[4]),
        .Q(txdata_double[4]),
        .R(SR));
FDRE \txdata_double_reg[5] 
       (.C(CLK),
        .CE(n_0_toggle_i_1),
        .D(txdata_reg[5]),
        .Q(txdata_double[5]),
        .R(SR));
FDRE \txdata_double_reg[6] 
       (.C(CLK),
        .CE(n_0_toggle_i_1),
        .D(txdata_reg[6]),
        .Q(txdata_double[6]),
        .R(SR));
FDRE \txdata_double_reg[7] 
       (.C(CLK),
        .CE(n_0_toggle_i_1),
        .D(txdata_reg[7]),
        .Q(txdata_double[7]),
        .R(SR));
FDRE \txdata_double_reg[8] 
       (.C(CLK),
        .CE(n_0_toggle_i_1),
        .D(I5[0]),
        .Q(txdata_double[8]),
        .R(SR));
FDRE \txdata_double_reg[9] 
       (.C(CLK),
        .CE(n_0_toggle_i_1),
        .D(I5[1]),
        .Q(txdata_double[9]),
        .R(SR));
FDRE \txdata_int_reg[0] 
       (.C(I2),
        .CE(1'b1),
        .D(txdata_double[0]),
        .Q(txdata_int[0]),
        .R(1'b0));
FDRE \txdata_int_reg[10] 
       (.C(I2),
        .CE(1'b1),
        .D(txdata_double[10]),
        .Q(txdata_int[10]),
        .R(1'b0));
FDRE \txdata_int_reg[11] 
       (.C(I2),
        .CE(1'b1),
        .D(txdata_double[11]),
        .Q(txdata_int[11]),
        .R(1'b0));
FDRE \txdata_int_reg[12] 
       (.C(I2),
        .CE(1'b1),
        .D(txdata_double[12]),
        .Q(txdata_int[12]),
        .R(1'b0));
FDRE \txdata_int_reg[13] 
       (.C(I2),
        .CE(1'b1),
        .D(txdata_double[13]),
        .Q(txdata_int[13]),
        .R(1'b0));
FDRE \txdata_int_reg[14] 
       (.C(I2),
        .CE(1'b1),
        .D(txdata_double[14]),
        .Q(txdata_int[14]),
        .R(1'b0));
FDRE \txdata_int_reg[15] 
       (.C(I2),
        .CE(1'b1),
        .D(txdata_double[15]),
        .Q(txdata_int[15]),
        .R(1'b0));
FDRE \txdata_int_reg[1] 
       (.C(I2),
        .CE(1'b1),
        .D(txdata_double[1]),
        .Q(txdata_int[1]),
        .R(1'b0));
FDRE \txdata_int_reg[2] 
       (.C(I2),
        .CE(1'b1),
        .D(txdata_double[2]),
        .Q(txdata_int[2]),
        .R(1'b0));
FDRE \txdata_int_reg[3] 
       (.C(I2),
        .CE(1'b1),
        .D(txdata_double[3]),
        .Q(txdata_int[3]),
        .R(1'b0));
FDRE \txdata_int_reg[4] 
       (.C(I2),
        .CE(1'b1),
        .D(txdata_double[4]),
        .Q(txdata_int[4]),
        .R(1'b0));
FDRE \txdata_int_reg[5] 
       (.C(I2),
        .CE(1'b1),
        .D(txdata_double[5]),
        .Q(txdata_int[5]),
        .R(1'b0));
FDRE \txdata_int_reg[6] 
       (.C(I2),
        .CE(1'b1),
        .D(txdata_double[6]),
        .Q(txdata_int[6]),
        .R(1'b0));
FDRE \txdata_int_reg[7] 
       (.C(I2),
        .CE(1'b1),
        .D(txdata_double[7]),
        .Q(txdata_int[7]),
        .R(1'b0));
FDRE \txdata_int_reg[8] 
       (.C(I2),
        .CE(1'b1),
        .D(txdata_double[8]),
        .Q(txdata_int[8]),
        .R(1'b0));
FDRE \txdata_int_reg[9] 
       (.C(I2),
        .CE(1'b1),
        .D(txdata_double[9]),
        .Q(txdata_int[9]),
        .R(1'b0));
FDRE \txdata_reg_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(I5[0]),
        .Q(txdata_reg[0]),
        .R(SR));
FDRE \txdata_reg_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(I5[1]),
        .Q(txdata_reg[1]),
        .R(SR));
FDRE \txdata_reg_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .D(I5[2]),
        .Q(txdata_reg[2]),
        .R(SR));
FDRE \txdata_reg_reg[3] 
       (.C(CLK),
        .CE(1'b1),
        .D(I5[3]),
        .Q(txdata_reg[3]),
        .R(SR));
FDRE \txdata_reg_reg[4] 
       (.C(CLK),
        .CE(1'b1),
        .D(I5[4]),
        .Q(txdata_reg[4]),
        .R(SR));
FDRE \txdata_reg_reg[5] 
       (.C(CLK),
        .CE(1'b1),
        .D(I5[5]),
        .Q(txdata_reg[5]),
        .R(SR));
FDRE \txdata_reg_reg[6] 
       (.C(CLK),
        .CE(1'b1),
        .D(I5[6]),
        .Q(txdata_reg[6]),
        .R(SR));
FDRE \txdata_reg_reg[7] 
       (.C(CLK),
        .CE(1'b1),
        .D(I5[7]),
        .Q(txdata_reg[7]),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     txpowerdown_double_reg
       (.C(CLK),
        .CE(1'b1),
        .D(txpowerdown_reg__0),
        .Q(txpowerdown_double),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     txpowerdown_reg
       (.C(I2),
        .CE(1'b1),
        .D(txpowerdown_double),
        .Q(txpowerdown),
        .R(1'b0));
FDRE #(
    .INIT(1'b0)) 
     txpowerdown_reg_reg
       (.C(CLK),
        .CE(1'b1),
        .D(Q),
        .Q(txpowerdown_reg__0),
        .R(SR));
endmodule

(* ORIG_REF_NAME = "gmii_to_sgmii_tx_rate_adapt" *) 
module gmii_to_sgmiigmii_to_sgmii_tx_rate_adapt
   (O2,
    O3,
    O4,
    O5,
    I1,
    E,
    gmii_tx_er,
    CLK,
    gmii_tx_en,
    I4,
    gmii_txd);
  output O2;
  output O3;
  output [7:0]O4;
  output O5;
  input I1;
  input [0:0]E;
  input gmii_tx_er;
  input CLK;
  input gmii_tx_en;
  input I4;
  input [7:0]gmii_txd;

  wire CLK;
  wire [0:0]E;
  wire I1;
  wire I4;
  wire O2;
  wire O3;
  wire [7:0]O4;
  wire O5;
  wire gmii_tx_en;
  wire gmii_tx_er;
  wire [7:0]gmii_txd;
  wire n_0_V_i_4;

LUT6 #(
    .INIT(64'h55557555FFFF7555)) 
     V_i_2
       (.I0(O2),
        .I1(n_0_V_i_4),
        .I2(O4[0]),
        .I3(O4[1]),
        .I4(O3),
        .I5(I4),
        .O(O5));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFF7)) 
     V_i_4
       (.I0(O4[3]),
        .I1(O4[2]),
        .I2(O4[6]),
        .I3(O4[7]),
        .I4(O4[4]),
        .I5(O4[5]),
        .O(n_0_V_i_4));
FDRE gmii_tx_en_out_reg
       (.C(CLK),
        .CE(E),
        .D(gmii_tx_en),
        .Q(O3),
        .R(I1));
FDRE gmii_tx_er_out_reg
       (.C(CLK),
        .CE(E),
        .D(gmii_tx_er),
        .Q(O2),
        .R(I1));
FDRE \gmii_txd_out_reg[0] 
       (.C(CLK),
        .CE(E),
        .D(gmii_txd[0]),
        .Q(O4[0]),
        .R(I1));
FDRE \gmii_txd_out_reg[1] 
       (.C(CLK),
        .CE(E),
        .D(gmii_txd[1]),
        .Q(O4[1]),
        .R(I1));
FDRE \gmii_txd_out_reg[2] 
       (.C(CLK),
        .CE(E),
        .D(gmii_txd[2]),
        .Q(O4[2]),
        .R(I1));
FDRE \gmii_txd_out_reg[3] 
       (.C(CLK),
        .CE(E),
        .D(gmii_txd[3]),
        .Q(O4[3]),
        .R(I1));
FDRE \gmii_txd_out_reg[4] 
       (.C(CLK),
        .CE(E),
        .D(gmii_txd[4]),
        .Q(O4[4]),
        .R(I1));
FDRE \gmii_txd_out_reg[5] 
       (.C(CLK),
        .CE(E),
        .D(gmii_txd[5]),
        .Q(O4[5]),
        .R(I1));
FDRE \gmii_txd_out_reg[6] 
       (.C(CLK),
        .CE(E),
        .D(gmii_txd[6]),
        .Q(O4[6]),
        .R(I1));
FDRE \gmii_txd_out_reg[7] 
       (.C(CLK),
        .CE(E),
        .D(gmii_txd[7]),
        .Q(O4[7]),
        .R(I1));
endmodule

(* ORIG_REF_NAME = "sync_block" *) 
module gmii_to_sgmiisync_block__parameterized0
   (MASK_RUDI_BUFERR_TIMER0,
    data_out,
    SIGNAL_DETECT_MOD,
    p_0_in,
    Q,
    signal_detect,
    CLK);
  output MASK_RUDI_BUFERR_TIMER0;
  output data_out;
  output SIGNAL_DETECT_MOD;
  input p_0_in;
  input [0:0]Q;
  input signal_detect;
  input CLK;

  wire CLK;
  wire MASK_RUDI_BUFERR_TIMER0;
  wire [0:0]Q;
  wire SIGNAL_DETECT_MOD;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire p_0_in;
  wire signal_detect;

(* SOFT_HLUTNM = "soft_lutpair36" *) 
   LUT3 #(
    .INIT(8'h20)) 
     \MASK_RUDI_BUFERR_TIMER[8]_i_4 
       (.I0(p_0_in),
        .I1(Q),
        .I2(data_out),
        .O(MASK_RUDI_BUFERR_TIMER0));
(* SOFT_HLUTNM = "soft_lutpair36" *) 
   LUT2 #(
    .INIT(4'h2)) 
     SIGNAL_DETECT_REG_i_1
       (.I0(data_out),
        .I1(Q),
        .O(SIGNAL_DETECT_MOD));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(CLK),
        .CE(1'b1),
        .D(signal_detect),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(CLK),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(CLK),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(CLK),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(CLK),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(CLK),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
