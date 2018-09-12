-- Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2014.4 (win64) Build 1071353 Tue Nov 18 18:24:04 MST 2014
-- Date        : Tue Apr 11 10:01:09 2017
-- Host        : hwdev2 running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode funcsim
--               W:/Gavin/Vivado/Vivado2014_4/Vivado2014_4.srcs/sources_1/ip/gmii_to_sgmii/gmii_to_sgmii_funcsim.vhdl
-- Design      : gmii_to_sgmii
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7vx690tffg1927-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \gmii_to_sgmii_AUTO_NEG__parameterized0\ is
  port (
    status_vector : out STD_LOGIC_VECTOR ( 5 downto 0 );
    XMIT_DATA_INT : out STD_LOGIC;
    O1 : out STD_LOGIC;
    O2 : out STD_LOGIC;
    O3 : out STD_LOGIC;
    XMIT_DATA : out STD_LOGIC;
    XMIT_CONFIG_INT : out STD_LOGIC;
    S : out STD_LOGIC_VECTOR ( 0 to 0 );
    O4 : out STD_LOGIC_VECTOR ( 0 to 0 );
    O5 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    O6 : out STD_LOGIC;
    O7 : out STD_LOGIC;
    O8 : out STD_LOGIC;
    O9 : out STD_LOGIC;
    STAT_VEC_DUPLEX_MODE_RSLVD : out STD_LOGIC;
    O10 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    an_interrupt : out STD_LOGIC;
    I1 : in STD_LOGIC;
    userclk2 : in STD_LOGIC;
    RESTART_AN_SET : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 3 downto 0 );
    p_1_in : in STD_LOGIC;
    RX_IDLE : in STD_LOGIC;
    I2 : in STD_LOGIC;
    I3 : in STD_LOGIC;
    I4 : in STD_LOGIC;
    CO : in STD_LOGIC_VECTOR ( 0 to 0 );
    RX_CONFIG_VALID : in STD_LOGIC;
    RXSYNC_STATUS : in STD_LOGIC;
    SOP_REG3 : in STD_LOGIC;
    I5 : in STD_LOGIC;
    RX_RUDI_INVALID : in STD_LOGIC;
    I6 : in STD_LOGIC_VECTOR ( 0 to 0 );
    an_adv_config_vector : in STD_LOGIC_VECTOR ( 1 downto 0 );
    I7 : in STD_LOGIC;
    I8 : in STD_LOGIC;
    link_timer_value : in STD_LOGIC_VECTOR ( 8 downto 0 );
    I9 : in STD_LOGIC_VECTOR ( 2 downto 0 );
    EOP_REG1 : in STD_LOGIC;
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    I10 : in STD_LOGIC;
    gmii_rx_dv : in STD_LOGIC;
    p_0_in : in STD_LOGIC;
    data_out : in STD_LOGIC;
    I11 : in STD_LOGIC;
    RX_CONFIG_REG : in STD_LOGIC_VECTOR ( 0 to 0 );
    I12 : in STD_LOGIC;
    MASK_RUDI_BUFERR_TIMER0 : in STD_LOGIC;
    I13 : in STD_LOGIC_VECTOR ( 0 to 0 );
    I14 : in STD_LOGIC;
    I15 : in STD_LOGIC;
    I16 : in STD_LOGIC;
    I17 : in STD_LOGIC;
    I18 : in STD_LOGIC;
    I19 : in STD_LOGIC;
    I20 : in STD_LOGIC;
    I21 : in STD_LOGIC;
    I22 : in STD_LOGIC;
    I23 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \gmii_to_sgmii_AUTO_NEG__parameterized0\ : entity is "AUTO_NEG";
end \gmii_to_sgmii_AUTO_NEG__parameterized0\;

architecture STRUCTURE of \gmii_to_sgmii_AUTO_NEG__parameterized0\ is
  signal ABILITY_MATCH : STD_LOGIC;
  signal ABILITY_MATCH_2 : STD_LOGIC;
  signal ACKNOWLEDGE_MATCH_2 : STD_LOGIC;
  signal ACKNOWLEDGE_MATCH_3 : STD_LOGIC;
  signal AN_SYNC_STATUS : STD_LOGIC;
  signal CONSISTENCY_MATCH : STD_LOGIC;
  signal CONSISTENCY_MATCH_COMB : STD_LOGIC;
  signal GENERATE_REMOTE_FAULT : STD_LOGIC;
  signal GENERATE_REMOTE_FAULT0 : STD_LOGIC;
  signal IDLE_INSERTED : STD_LOGIC;
  signal IDLE_INSERTED0 : STD_LOGIC;
  signal IDLE_INSERTED_REG1 : STD_LOGIC;
  signal IDLE_INSERTED_REG2 : STD_LOGIC;
  signal IDLE_INSERTED_REG3 : STD_LOGIC;
  signal IDLE_INSERTED_REG30 : STD_LOGIC;
  signal IDLE_INSERTED_REG4 : STD_LOGIC;
  signal IDLE_MATCH : STD_LOGIC;
  signal IDLE_MATCH_2 : STD_LOGIC;
  signal IDLE_REMOVED : STD_LOGIC;
  signal IDLE_REMOVED0 : STD_LOGIC;
  signal IDLE_REMOVED_REG1 : STD_LOGIC;
  signal IDLE_REMOVED_REG2 : STD_LOGIC;
  signal LINK_TIMER_DONE : STD_LOGIC;
  signal LINK_TIMER_SATURATED : STD_LOGIC;
  signal LINK_TIMER_SATURATED_COMB : STD_LOGIC;
  signal \LINK_TIMER_reg__0\ : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal MASK_RUDI_BUFERR_TIMER : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal MR_AN_ENABLE_CHANGE : STD_LOGIC;
  signal MR_AN_ENABLE_CHANGE0 : STD_LOGIC;
  signal MR_AN_ENABLE_REG1 : STD_LOGIC;
  signal MR_AN_ENABLE_REG2 : STD_LOGIC;
  signal MR_RESTART_AN_SET_REG1 : STD_LOGIC;
  signal MR_RESTART_AN_SET_REG2 : STD_LOGIC;
  signal \^o1\ : STD_LOGIC;
  signal \^o2\ : STD_LOGIC;
  signal \^o3\ : STD_LOGIC;
  signal \^o5\ : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal \^o7\ : STD_LOGIC;
  signal \^o8\ : STD_LOGIC;
  signal \^o9\ : STD_LOGIC;
  signal PREVIOUS_STATE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal PULSE4096 : STD_LOGIC;
  signal PULSE40960 : STD_LOGIC;
  signal RX_CONFIG_SNAPSHOT : STD_LOGIC;
  signal RX_IDLE_REG1 : STD_LOGIC;
  signal RX_IDLE_REG2 : STD_LOGIC;
  signal RX_RUDI_INVALID_DELAY : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal RX_RUDI_INVALID_DELAY0 : STD_LOGIC;
  signal RX_RUDI_INVALID_REG : STD_LOGIC;
  signal SGMII_PHY_STATUS1_out : STD_LOGIC;
  signal START_LINK_TIMER_REG : STD_LOGIC;
  signal START_LINK_TIMER_REG2 : STD_LOGIC;
  signal \^stat_vec_duplex_mode_rslvd\ : STD_LOGIC;
  signal SYNC_STATUS_HELD : STD_LOGIC;
  signal TIMER4096_MSB_REG : STD_LOGIC;
  signal TOGGLE_RX : STD_LOGIC;
  signal TOGGLE_TX : STD_LOGIC;
  signal \^xmit_config_int\ : STD_LOGIC;
  signal \^xmit_data\ : STD_LOGIC;
  signal \^xmit_data_int\ : STD_LOGIC;
  signal XMIT_DATA_INT0 : STD_LOGIC;
  signal \^an_interrupt\ : STD_LOGIC;
  signal n_0_ABILITY_MATCH_2_i_1 : STD_LOGIC;
  signal n_0_ABILITY_MATCH_i_1 : STD_LOGIC;
  signal n_0_ACKNOWLEDGE_MATCH_2_i_1 : STD_LOGIC;
  signal n_0_ACKNOWLEDGE_MATCH_3_i_1 : STD_LOGIC;
  signal n_0_ACKNOWLEDGE_MATCH_3_reg : STD_LOGIC;
  signal n_0_AN_SYNC_STATUS_i_1 : STD_LOGIC;
  signal \n_0_BASEX_REMOTE_FAULT[1]_i_1\ : STD_LOGIC;
  signal n_0_GENERATE_REMOTE_FAULT_i_2 : STD_LOGIC;
  signal n_0_GENERATE_REMOTE_FAULT_i_3 : STD_LOGIC;
  signal n_0_GENERATE_REMOTE_FAULT_i_4 : STD_LOGIC;
  signal n_0_GENERATE_REMOTE_FAULT_i_5 : STD_LOGIC;
  signal n_0_GENERATE_REMOTE_FAULT_i_6 : STD_LOGIC;
  signal n_0_GENERATE_REMOTE_FAULT_i_7 : STD_LOGIC;
  signal n_0_IDLE_MATCH_2_i_1 : STD_LOGIC;
  signal n_0_IDLE_MATCH_i_1 : STD_LOGIC;
  signal \n_0_LINK_TIMER[4]_i_1\ : STD_LOGIC;
  signal \n_0_LINK_TIMER[8]_i_1\ : STD_LOGIC;
  signal \n_0_LINK_TIMER[8]_i_3\ : STD_LOGIC;
  signal n_0_LINK_TIMER_DONE_i_1 : STD_LOGIC;
  signal n_0_LINK_TIMER_DONE_i_2 : STD_LOGIC;
  signal n_0_LINK_TIMER_DONE_i_3 : STD_LOGIC;
  signal n_0_LINK_TIMER_SATURATED_i_2 : STD_LOGIC;
  signal n_0_LINK_TIMER_SATURATED_i_3 : STD_LOGIC;
  signal n_0_LINK_TIMER_SATURATED_i_4 : STD_LOGIC;
  signal \n_0_MASK_RUDI_BUFERR_TIMER[0]_i_1\ : STD_LOGIC;
  signal \n_0_MASK_RUDI_BUFERR_TIMER[1]_i_1\ : STD_LOGIC;
  signal \n_0_MASK_RUDI_BUFERR_TIMER[2]_i_1\ : STD_LOGIC;
  signal \n_0_MASK_RUDI_BUFERR_TIMER[3]_i_1\ : STD_LOGIC;
  signal \n_0_MASK_RUDI_BUFERR_TIMER[4]_i_1\ : STD_LOGIC;
  signal \n_0_MASK_RUDI_BUFERR_TIMER[5]_i_1\ : STD_LOGIC;
  signal \n_0_MASK_RUDI_BUFERR_TIMER[5]_i_2\ : STD_LOGIC;
  signal \n_0_MASK_RUDI_BUFERR_TIMER[5]_i_3\ : STD_LOGIC;
  signal \n_0_MASK_RUDI_BUFERR_TIMER[6]_i_1\ : STD_LOGIC;
  signal \n_0_MASK_RUDI_BUFERR_TIMER[7]_i_1\ : STD_LOGIC;
  signal \n_0_MASK_RUDI_BUFERR_TIMER[8]_i_1\ : STD_LOGIC;
  signal \n_0_MASK_RUDI_BUFERR_TIMER[8]_i_2\ : STD_LOGIC;
  signal n_0_MASK_RUDI_BUFERR_i_1 : STD_LOGIC;
  signal n_0_MASK_RUDI_BUFERR_reg : STD_LOGIC;
  signal n_0_MASK_RUDI_CLKCOR_i_1 : STD_LOGIC;
  signal n_0_MASK_RUDI_CLKCOR_i_3 : STD_LOGIC;
  signal n_0_MASK_RUDI_CLKCOR_reg : STD_LOGIC;
  signal n_0_MR_AN_COMPLETE_i_1 : STD_LOGIC;
  signal \n_0_MR_LP_ADV_ABILITY_INT[13]_i_1\ : STD_LOGIC;
  signal \n_0_MR_LP_ADV_ABILITY_INT[16]_i_1\ : STD_LOGIC;
  signal \n_0_MR_LP_ADV_ABILITY_INT_reg[16]\ : STD_LOGIC;
  signal \n_0_MR_NP_RX_INT_reg[16]\ : STD_LOGIC;
  signal n_0_MR_REMOTE_FAULT_i_1 : STD_LOGIC;
  signal n_0_MR_RESTART_AN_INT_i_1 : STD_LOGIC;
  signal n_0_MR_RESTART_AN_INT_reg : STD_LOGIC;
  signal \n_0_RX_CONFIG_REG_REG_reg[12]\ : STD_LOGIC;
  signal \n_0_RX_CONFIG_REG_REG_reg[13]\ : STD_LOGIC;
  signal \n_0_RX_CONFIG_SNAPSHOT[15]_i_3\ : STD_LOGIC;
  signal \n_0_RX_CONFIG_SNAPSHOT[15]_i_4\ : STD_LOGIC;
  signal \n_0_RX_CONFIG_SNAPSHOT_reg[12]\ : STD_LOGIC;
  signal \n_0_RX_CONFIG_SNAPSHOT_reg[13]\ : STD_LOGIC;
  signal \n_0_RX_CONFIG_SNAPSHOT_reg[15]\ : STD_LOGIC;
  signal n_0_RX_DV_i_2 : STD_LOGIC;
  signal n_0_SGMII_PHY_STATUS_i_1 : STD_LOGIC;
  signal \n_0_SGMII_SPEED[0]_i_1\ : STD_LOGIC;
  signal \n_0_SGMII_SPEED[1]_i_1\ : STD_LOGIC;
  signal \n_0_SGMII_SPEED[1]_i_3\ : STD_LOGIC;
  signal n_0_START_LINK_TIMER_REG_i_1 : STD_LOGIC;
  signal n_0_START_LINK_TIMER_REG_i_2 : STD_LOGIC;
  signal n_0_START_LINK_TIMER_REG_i_3 : STD_LOGIC;
  signal n_0_START_LINK_TIMER_REG_i_4 : STD_LOGIC;
  signal \n_0_STATE[0]_i_1\ : STD_LOGIC;
  signal \n_0_STATE[0]_i_2\ : STD_LOGIC;
  signal \n_0_STATE[0]_i_3\ : STD_LOGIC;
  signal \n_0_STATE[0]_i_4\ : STD_LOGIC;
  signal \n_0_STATE[0]_i_5\ : STD_LOGIC;
  signal \n_0_STATE[0]_i_6\ : STD_LOGIC;
  signal \n_0_STATE[0]_i_7\ : STD_LOGIC;
  signal \n_0_STATE[1]_i_1\ : STD_LOGIC;
  signal \n_0_STATE[1]_i_2\ : STD_LOGIC;
  signal \n_0_STATE[1]_i_3\ : STD_LOGIC;
  signal \n_0_STATE[1]_i_4\ : STD_LOGIC;
  signal \n_0_STATE[1]_i_5\ : STD_LOGIC;
  signal \n_0_STATE[1]_i_6\ : STD_LOGIC;
  signal \n_0_STATE[2]_i_1\ : STD_LOGIC;
  signal \n_0_STATE[2]_i_2\ : STD_LOGIC;
  signal \n_0_STATE[2]_i_3\ : STD_LOGIC;
  signal \n_0_STATE[2]_i_4\ : STD_LOGIC;
  signal \n_0_STATE[2]_i_5\ : STD_LOGIC;
  signal \n_0_STATE[3]_i_1\ : STD_LOGIC;
  signal \n_0_STATE[3]_i_2\ : STD_LOGIC;
  signal \n_0_STATE[3]_i_3\ : STD_LOGIC;
  signal \n_0_STATE[3]_i_4\ : STD_LOGIC;
  signal \n_0_STATE_reg[0]\ : STD_LOGIC;
  signal \n_0_STATE_reg[1]\ : STD_LOGIC;
  signal \n_0_STATE_reg[2]\ : STD_LOGIC;
  signal \n_0_STATE_reg[3]\ : STD_LOGIC;
  signal n_0_SYNC_STATUS_HELD_i_1 : STD_LOGIC;
  signal \n_0_TIMER4096[0]_i_2\ : STD_LOGIC;
  signal \n_0_TIMER4096_reg[0]\ : STD_LOGIC;
  signal \n_0_TIMER4096_reg[0]_i_1\ : STD_LOGIC;
  signal \n_0_TIMER4096_reg[10]\ : STD_LOGIC;
  signal \n_0_TIMER4096_reg[10]_i_1\ : STD_LOGIC;
  signal \n_0_TIMER4096_reg[10]_i_2\ : STD_LOGIC;
  signal \n_0_TIMER4096_reg[11]\ : STD_LOGIC;
  signal \n_0_TIMER4096_reg[11]_i_1\ : STD_LOGIC;
  signal \n_0_TIMER4096_reg[1]\ : STD_LOGIC;
  signal \n_0_TIMER4096_reg[1]_i_1\ : STD_LOGIC;
  signal \n_0_TIMER4096_reg[1]_i_2\ : STD_LOGIC;
  signal \n_0_TIMER4096_reg[2]\ : STD_LOGIC;
  signal \n_0_TIMER4096_reg[2]_i_1\ : STD_LOGIC;
  signal \n_0_TIMER4096_reg[2]_i_2\ : STD_LOGIC;
  signal \n_0_TIMER4096_reg[3]\ : STD_LOGIC;
  signal \n_0_TIMER4096_reg[3]_i_1\ : STD_LOGIC;
  signal \n_0_TIMER4096_reg[3]_i_2\ : STD_LOGIC;
  signal \n_0_TIMER4096_reg[4]\ : STD_LOGIC;
  signal \n_0_TIMER4096_reg[4]_i_1\ : STD_LOGIC;
  signal \n_0_TIMER4096_reg[4]_i_2\ : STD_LOGIC;
  signal \n_0_TIMER4096_reg[5]\ : STD_LOGIC;
  signal \n_0_TIMER4096_reg[5]_i_1\ : STD_LOGIC;
  signal \n_0_TIMER4096_reg[5]_i_2\ : STD_LOGIC;
  signal \n_0_TIMER4096_reg[6]\ : STD_LOGIC;
  signal \n_0_TIMER4096_reg[6]_i_1\ : STD_LOGIC;
  signal \n_0_TIMER4096_reg[6]_i_2\ : STD_LOGIC;
  signal \n_0_TIMER4096_reg[7]\ : STD_LOGIC;
  signal \n_0_TIMER4096_reg[7]_i_1\ : STD_LOGIC;
  signal \n_0_TIMER4096_reg[7]_i_2\ : STD_LOGIC;
  signal \n_0_TIMER4096_reg[8]\ : STD_LOGIC;
  signal \n_0_TIMER4096_reg[8]_i_1\ : STD_LOGIC;
  signal \n_0_TIMER4096_reg[8]_i_2\ : STD_LOGIC;
  signal \n_0_TIMER4096_reg[9]\ : STD_LOGIC;
  signal \n_0_TIMER4096_reg[9]_i_1\ : STD_LOGIC;
  signal \n_0_TIMER4096_reg[9]_i_2\ : STD_LOGIC;
  signal n_0_TOGGLE_RX_i_1 : STD_LOGIC;
  signal n_0_TOGGLE_TX_i_1 : STD_LOGIC;
  signal n_0_TOGGLE_TX_i_2 : STD_LOGIC;
  signal \n_0_TX_CONFIG_REG_INT[0]_i_1\ : STD_LOGIC;
  signal \n_0_TX_CONFIG_REG_INT[11]_i_1\ : STD_LOGIC;
  signal \n_0_TX_CONFIG_REG_INT[14]_i_1\ : STD_LOGIC;
  signal n_0_XMIT_CONFIG_INT_i_1 : STD_LOGIC;
  signal n_0_XMIT_CONFIG_INT_i_2 : STD_LOGIC;
  signal n_0_XMIT_CONFIG_INT_i_3 : STD_LOGIC;
  signal n_0_XMIT_CONFIG_INT_i_4 : STD_LOGIC;
  signal n_2_LINK_TIMER_SATURATED_reg_i_1 : STD_LOGIC;
  signal n_3_LINK_TIMER_SATURATED_reg_i_1 : STD_LOGIC;
  signal p_0_in0_in : STD_LOGIC;
  signal p_0_in44_in : STD_LOGIC;
  signal \plusOp__0\ : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal \^status_vector\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal NLW_LINK_TIMER_SATURATED_reg_i_1_CO_UNCONNECTED : STD_LOGIC_VECTOR ( 3 to 3 );
  signal NLW_LINK_TIMER_SATURATED_reg_i_1_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_TIMER4096_reg[9]_i_2_CARRY4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_TIMER4096_reg[9]_i_2_CARRY4_DI_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of ABILITY_MATCH_2_i_2 : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of CONSISTENCY_MATCH_i_1 : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of GENERATE_REMOTE_FAULT_i_4 : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of GENERATE_REMOTE_FAULT_i_6 : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of IDLE_INSERTED_REG3_i_1 : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of IDLE_INSERTED_i_1 : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of IDLE_MATCH_2_i_1 : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of IDLE_REMOVED_i_1 : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of I_i_4 : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \LINK_TIMER[1]_i_1\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \LINK_TIMER[2]_i_1\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \LINK_TIMER[3]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \LINK_TIMER[4]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \LINK_TIMER[7]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \LINK_TIMER[8]_i_2\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of LINK_TIMER_DONE_i_2 : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \MASK_RUDI_BUFERR_TIMER[5]_i_3\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \MASK_RUDI_BUFERR_TIMER[6]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \MASK_RUDI_BUFERR_TIMER[7]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \MASK_RUDI_BUFERR_TIMER[8]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \MR_LP_ADV_ABILITY_INT[13]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \MR_LP_ADV_ABILITY_INT[16]_i_1\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \RX_CONFIG_SNAPSHOT[15]_i_4\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of RX_DV_i_4 : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of SGMII_PHY_STATUS_i_1 : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \SGMII_SPEED[1]_i_3\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of START_LINK_TIMER_REG_i_3 : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of START_LINK_TIMER_REG_i_4 : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \STATE[0]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \STATE[0]_i_3\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \STATE[0]_i_4\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \STATE[0]_i_7\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \STATE[1]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \STATE[1]_i_2\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \STATE[1]_i_4\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \STATE[1]_i_5\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \STATE[1]_i_6\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \STATE[2]_i_2\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \STATE[2]_i_3\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \STATE[2]_i_5\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \STATE[3]_i_2\ : label is "soft_lutpair0";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of \TIMER4096_reg[1]_i_2_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute XILINX_TRANSFORM_PINMAP : string;
  attribute XILINX_TRANSFORM_PINMAP of \TIMER4096_reg[1]_i_2_CARRY4\ : label is "LO:O";
  attribute XILINX_LEGACY_PRIM of \TIMER4096_reg[5]_i_2_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute XILINX_TRANSFORM_PINMAP of \TIMER4096_reg[5]_i_2_CARRY4\ : label is "LO:O";
  attribute XILINX_LEGACY_PRIM of \TIMER4096_reg[9]_i_2_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute XILINX_TRANSFORM_PINMAP of \TIMER4096_reg[9]_i_2_CARRY4\ : label is "LO:O";
  attribute SOFT_HLUTNM of TOGGLE_RX_i_1 : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \TX_CONFIG_REG_INT[0]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \TX_CONFIG_REG_INT[14]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of XMIT_CONFIG_INT_i_2 : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of XMIT_CONFIG_INT_i_3 : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of XMIT_CONFIG_INT_i_4 : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of XMIT_DATA_INT_i_1 : label is "soft_lutpair0";
begin
  O1 <= \^o1\;
  O2 <= \^o2\;
  O3 <= \^o3\;
  O5(11 downto 0) <= \^o5\(11 downto 0);
  O7 <= \^o7\;
  O8 <= \^o8\;
  O9 <= \^o9\;
  STAT_VEC_DUPLEX_MODE_RSLVD <= \^stat_vec_duplex_mode_rslvd\;
  XMIT_CONFIG_INT <= \^xmit_config_int\;
  XMIT_DATA <= \^xmit_data\;
  XMIT_DATA_INT <= \^xmit_data_int\;
  an_interrupt <= \^an_interrupt\;
  status_vector(5 downto 0) <= \^status_vector\(5 downto 0);
ABILITY_MATCH_2_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00002E22"
    )
    port map (
      I0 => ABILITY_MATCH_2,
      I1 => RX_CONFIG_VALID,
      I2 => \n_0_RX_CONFIG_SNAPSHOT[15]_i_4\,
      I3 => CO(0),
      I4 => ACKNOWLEDGE_MATCH_3,
      O => n_0_ABILITY_MATCH_2_i_1
    );
ABILITY_MATCH_2_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => I1,
      I1 => n_0_MASK_RUDI_BUFERR_reg,
      I2 => RX_IDLE,
      O => ACKNOWLEDGE_MATCH_3
    );
ABILITY_MATCH_2_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => n_0_ABILITY_MATCH_2_i_1,
      Q => ABILITY_MATCH_2,
      R => '0'
    );
ABILITY_MATCH_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000020FF2000"
    )
    port map (
      I0 => CO(0),
      I1 => \n_0_RX_CONFIG_SNAPSHOT[15]_i_4\,
      I2 => ABILITY_MATCH_2,
      I3 => RX_CONFIG_VALID,
      I4 => ABILITY_MATCH,
      I5 => ACKNOWLEDGE_MATCH_3,
      O => n_0_ABILITY_MATCH_i_1
    );
ABILITY_MATCH_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => n_0_ABILITY_MATCH_i_1,
      Q => ABILITY_MATCH,
      R => '0'
    );
ACKNOWLEDGE_MATCH_2_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000E222"
    )
    port map (
      I0 => ACKNOWLEDGE_MATCH_2,
      I1 => RX_CONFIG_VALID,
      I2 => p_0_in44_in,
      I3 => RX_CONFIG_REG(0),
      I4 => ACKNOWLEDGE_MATCH_3,
      O => n_0_ACKNOWLEDGE_MATCH_2_i_1
    );
ACKNOWLEDGE_MATCH_2_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => n_0_ACKNOWLEDGE_MATCH_2_i_1,
      Q => ACKNOWLEDGE_MATCH_2,
      R => '0'
    );
ACKNOWLEDGE_MATCH_3_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000E2222222"
    )
    port map (
      I0 => n_0_ACKNOWLEDGE_MATCH_3_reg,
      I1 => RX_CONFIG_VALID,
      I2 => RX_CONFIG_REG(0),
      I3 => p_0_in44_in,
      I4 => ACKNOWLEDGE_MATCH_2,
      I5 => ACKNOWLEDGE_MATCH_3,
      O => n_0_ACKNOWLEDGE_MATCH_3_i_1
    );
ACKNOWLEDGE_MATCH_3_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => n_0_ACKNOWLEDGE_MATCH_3_i_1,
      Q => n_0_ACKNOWLEDGE_MATCH_3_reg,
      R => '0'
    );
AN_SYNC_STATUS_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFBFFF80"
    )
    port map (
      I0 => SYNC_STATUS_HELD,
      I1 => PULSE4096,
      I2 => LINK_TIMER_SATURATED,
      I3 => RXSYNC_STATUS,
      I4 => AN_SYNC_STATUS,
      O => n_0_AN_SYNC_STATUS_i_1
    );
AN_SYNC_STATUS_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => n_0_AN_SYNC_STATUS_i_1,
      Q => AN_SYNC_STATUS,
      R => I1
    );
\BASEX_REMOTE_FAULT[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"030A"
    )
    port map (
      I0 => \^status_vector\(2),
      I1 => p_1_in,
      I2 => I1,
      I3 => SGMII_PHY_STATUS1_out,
      O => \n_0_BASEX_REMOTE_FAULT[1]_i_1\
    );
\BASEX_REMOTE_FAULT_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_BASEX_REMOTE_FAULT[1]_i_1\,
      Q => \^status_vector\(2),
      R => '0'
    );
CONSISTENCY_MATCH_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"82"
    )
    port map (
      I0 => I6(0),
      I1 => \n_0_RX_CONFIG_SNAPSHOT_reg[15]\,
      I2 => p_1_in,
      O => CONSISTENCY_MATCH_COMB
    );
CONSISTENCY_MATCH_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => \n_0_RX_CONFIG_SNAPSHOT_reg[13]\,
      I1 => I7,
      I2 => \n_0_RX_CONFIG_SNAPSHOT_reg[12]\,
      I3 => I8,
      O => O4(0)
    );
CONSISTENCY_MATCH_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => CONSISTENCY_MATCH_COMB,
      Q => CONSISTENCY_MATCH,
      R => I1
    );
GENERATE_REMOTE_FAULT_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF02000000000000"
    )
    port map (
      I0 => n_0_GENERATE_REMOTE_FAULT_i_2,
      I1 => n_0_GENERATE_REMOTE_FAULT_i_3,
      I2 => \n_0_STATE[0]_i_2\,
      I3 => \n_0_STATE_reg[3]\,
      I4 => n_0_GENERATE_REMOTE_FAULT_i_4,
      I5 => \n_0_STATE[3]_i_3\,
      O => GENERATE_REMOTE_FAULT0
    );
GENERATE_REMOTE_FAULT_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF2AFFFFFF2AFF2A"
    )
    port map (
      I0 => \n_0_STATE[1]_i_4\,
      I1 => \n_0_STATE[2]_i_5\,
      I2 => ABILITY_MATCH,
      I3 => \n_0_STATE[1]_i_5\,
      I4 => \n_0_STATE_reg[2]\,
      I5 => n_0_GENERATE_REMOTE_FAULT_i_5,
      O => n_0_GENERATE_REMOTE_FAULT_i_2
    );
GENERATE_REMOTE_FAULT_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"007F0000007F007F"
    )
    port map (
      I0 => \n_0_STATE[1]_i_5\,
      I1 => n_0_GENERATE_REMOTE_FAULT_i_6,
      I2 => IDLE_MATCH,
      I3 => \n_0_STATE[1]_i_4\,
      I4 => \n_0_STATE_reg[2]\,
      I5 => n_0_GENERATE_REMOTE_FAULT_i_7,
      O => n_0_GENERATE_REMOTE_FAULT_i_3
    );
GENERATE_REMOTE_FAULT_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0040"
    )
    port map (
      I0 => \n_0_STATE_reg[1]\,
      I1 => \n_0_STATE_reg[0]\,
      I2 => \n_0_STATE_reg[2]\,
      I3 => \n_0_STATE_reg[3]\,
      O => n_0_GENERATE_REMOTE_FAULT_i_4
    );
GENERATE_REMOTE_FAULT_i_5: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000800000000000"
    )
    port map (
      I0 => \n_0_STATE_reg[1]\,
      I1 => ABILITY_MATCH,
      I2 => n_0_ACKNOWLEDGE_MATCH_3_reg,
      I3 => CONSISTENCY_MATCH,
      I4 => \^o2\,
      I5 => \n_0_STATE_reg[0]\,
      O => n_0_GENERATE_REMOTE_FAULT_i_5
    );
GENERATE_REMOTE_FAULT_i_6: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => LINK_TIMER_DONE,
      I1 => \n_0_STATE_reg[0]\,
      O => n_0_GENERATE_REMOTE_FAULT_i_6
    );
GENERATE_REMOTE_FAULT_i_7: unisim.vcomponents.LUT6
    generic map(
      INIT => X"37FFFF003700FF00"
    )
    port map (
      I0 => n_0_ACKNOWLEDGE_MATCH_3_reg,
      I1 => ABILITY_MATCH,
      I2 => \^o2\,
      I3 => \n_0_STATE_reg[1]\,
      I4 => \n_0_STATE_reg[0]\,
      I5 => LINK_TIMER_DONE,
      O => n_0_GENERATE_REMOTE_FAULT_i_7
    );
GENERATE_REMOTE_FAULT_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => GENERATE_REMOTE_FAULT0,
      Q => GENERATE_REMOTE_FAULT,
      R => I1
    );
IDLE_INSERTED_REG1_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => IDLE_INSERTED,
      Q => IDLE_INSERTED_REG1,
      R => I1
    );
IDLE_INSERTED_REG2_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => IDLE_INSERTED_REG1,
      Q => IDLE_INSERTED_REG2,
      R => I1
    );
IDLE_INSERTED_REG3_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => IDLE_INSERTED_REG2,
      I1 => RX_IDLE_REG2,
      O => IDLE_INSERTED_REG30
    );
IDLE_INSERTED_REG3_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => IDLE_INSERTED_REG30,
      Q => IDLE_INSERTED_REG3,
      R => I1
    );
IDLE_INSERTED_REG4_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => IDLE_INSERTED_REG3,
      Q => IDLE_INSERTED_REG4,
      R => I1
    );
IDLE_INSERTED_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4000"
    )
    port map (
      I0 => \^xmit_config_int\,
      I1 => I9(0),
      I2 => I9(2),
      I3 => I9(1),
      O => IDLE_INSERTED0
    );
IDLE_INSERTED_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => IDLE_INSERTED0,
      Q => IDLE_INSERTED,
      R => I1
    );
IDLE_MATCH_2_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"04FF0400"
    )
    port map (
      I0 => IDLE_INSERTED_REG2,
      I1 => RX_IDLE,
      I2 => IDLE_INSERTED_REG4,
      I3 => RX_IDLE_REG2,
      I4 => IDLE_MATCH_2,
      O => n_0_IDLE_MATCH_2_i_1
    );
IDLE_MATCH_2_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => n_0_IDLE_MATCH_2_i_1,
      Q => IDLE_MATCH_2,
      R => I1
    );
IDLE_MATCH_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4440FFFF44400000"
    )
    port map (
      I0 => IDLE_INSERTED_REG2,
      I1 => RX_IDLE,
      I2 => IDLE_REMOVED_REG2,
      I3 => IDLE_MATCH_2,
      I4 => RX_IDLE_REG2,
      I5 => IDLE_MATCH,
      O => n_0_IDLE_MATCH_i_1
    );
IDLE_MATCH_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => n_0_IDLE_MATCH_i_1,
      Q => IDLE_MATCH,
      R => I1
    );
IDLE_REMOVED_REG1_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => IDLE_REMOVED,
      Q => IDLE_REMOVED_REG1,
      R => I1
    );
IDLE_REMOVED_REG2_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => IDLE_REMOVED_REG1,
      Q => IDLE_REMOVED_REG2,
      R => I1
    );
IDLE_REMOVED_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0100"
    )
    port map (
      I0 => I9(2),
      I1 => I9(1),
      I2 => \^xmit_config_int\,
      I3 => I9(0),
      O => IDLE_REMOVED0
    );
IDLE_REMOVED_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => IDLE_REMOVED0,
      Q => IDLE_REMOVED,
      R => I1
    );
I_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F200"
    )
    port map (
      I0 => Q(0),
      I1 => Q(3),
      I2 => \^xmit_data_int\,
      I3 => RXSYNC_STATUS,
      O => \^o3\
    );
\LINK_TIMER[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \LINK_TIMER_reg__0\(0),
      O => \plusOp__0\(0)
    );
\LINK_TIMER[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \LINK_TIMER_reg__0\(0),
      I1 => \LINK_TIMER_reg__0\(1),
      O => \plusOp__0\(1)
    );
\LINK_TIMER[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
    port map (
      I0 => \LINK_TIMER_reg__0\(2),
      I1 => \LINK_TIMER_reg__0\(0),
      I2 => \LINK_TIMER_reg__0\(1),
      O => \plusOp__0\(2)
    );
\LINK_TIMER[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6AAA"
    )
    port map (
      I0 => \LINK_TIMER_reg__0\(3),
      I1 => \LINK_TIMER_reg__0\(1),
      I2 => \LINK_TIMER_reg__0\(0),
      I3 => \LINK_TIMER_reg__0\(2),
      O => \plusOp__0\(3)
    );
\LINK_TIMER[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
    port map (
      I0 => \LINK_TIMER_reg__0\(4),
      I1 => \LINK_TIMER_reg__0\(3),
      I2 => \LINK_TIMER_reg__0\(1),
      I3 => \LINK_TIMER_reg__0\(0),
      I4 => \LINK_TIMER_reg__0\(2),
      O => \n_0_LINK_TIMER[4]_i_1\
    );
\LINK_TIMER[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6AAAAAAAAAAAAAAA"
    )
    port map (
      I0 => \LINK_TIMER_reg__0\(5),
      I1 => \LINK_TIMER_reg__0\(3),
      I2 => \LINK_TIMER_reg__0\(1),
      I3 => \LINK_TIMER_reg__0\(0),
      I4 => \LINK_TIMER_reg__0\(2),
      I5 => \LINK_TIMER_reg__0\(4),
      O => \plusOp__0\(5)
    );
\LINK_TIMER[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => \n_0_LINK_TIMER[8]_i_3\,
      I1 => \LINK_TIMER_reg__0\(6),
      O => \plusOp__0\(6)
    );
\LINK_TIMER[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"9A"
    )
    port map (
      I0 => \LINK_TIMER_reg__0\(7),
      I1 => \n_0_LINK_TIMER[8]_i_3\,
      I2 => \LINK_TIMER_reg__0\(6),
      O => \plusOp__0\(7)
    );
\LINK_TIMER[8]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFEA"
    )
    port map (
      I0 => START_LINK_TIMER_REG,
      I1 => LINK_TIMER_SATURATED,
      I2 => PULSE4096,
      I3 => I1,
      O => \n_0_LINK_TIMER[8]_i_1\
    );
\LINK_TIMER[8]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A6AA"
    )
    port map (
      I0 => \LINK_TIMER_reg__0\(8),
      I1 => \LINK_TIMER_reg__0\(6),
      I2 => \n_0_LINK_TIMER[8]_i_3\,
      I3 => \LINK_TIMER_reg__0\(7),
      O => \plusOp__0\(8)
    );
\LINK_TIMER[8]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFFFFFFFFFF"
    )
    port map (
      I0 => \LINK_TIMER_reg__0\(4),
      I1 => \LINK_TIMER_reg__0\(2),
      I2 => \LINK_TIMER_reg__0\(0),
      I3 => \LINK_TIMER_reg__0\(1),
      I4 => \LINK_TIMER_reg__0\(3),
      I5 => \LINK_TIMER_reg__0\(5),
      O => \n_0_LINK_TIMER[8]_i_3\
    );
LINK_TIMER_DONE_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000E00"
    )
    port map (
      I0 => LINK_TIMER_DONE,
      I1 => LINK_TIMER_SATURATED,
      I2 => n_0_LINK_TIMER_DONE_i_2,
      I3 => \n_0_STATE[3]_i_3\,
      I4 => n_0_START_LINK_TIMER_REG_i_2,
      I5 => n_0_LINK_TIMER_DONE_i_3,
      O => n_0_LINK_TIMER_DONE_i_1
    );
LINK_TIMER_DONE_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => START_LINK_TIMER_REG2,
      I1 => START_LINK_TIMER_REG,
      I2 => I1,
      O => n_0_LINK_TIMER_DONE_i_2
    );
LINK_TIMER_DONE_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000002A0000"
    )
    port map (
      I0 => n_0_START_LINK_TIMER_REG_i_3,
      I1 => ABILITY_MATCH,
      I2 => \^o2\,
      I3 => n_0_TOGGLE_TX_i_2,
      I4 => \n_0_STATE_reg[2]\,
      I5 => \n_0_STATE_reg[1]\,
      O => n_0_LINK_TIMER_DONE_i_3
    );
LINK_TIMER_DONE_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => n_0_LINK_TIMER_DONE_i_1,
      Q => LINK_TIMER_DONE,
      R => '0'
    );
LINK_TIMER_SATURATED_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => \LINK_TIMER_reg__0\(6),
      I1 => link_timer_value(6),
      I2 => \LINK_TIMER_reg__0\(7),
      I3 => link_timer_value(7),
      I4 => link_timer_value(8),
      I5 => \LINK_TIMER_reg__0\(8),
      O => n_0_LINK_TIMER_SATURATED_i_2
    );
LINK_TIMER_SATURATED_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => link_timer_value(4),
      I1 => \LINK_TIMER_reg__0\(4),
      I2 => \LINK_TIMER_reg__0\(5),
      I3 => link_timer_value(5),
      I4 => \LINK_TIMER_reg__0\(3),
      I5 => link_timer_value(3),
      O => n_0_LINK_TIMER_SATURATED_i_3
    );
LINK_TIMER_SATURATED_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => link_timer_value(0),
      I1 => \LINK_TIMER_reg__0\(0),
      I2 => \LINK_TIMER_reg__0\(1),
      I3 => link_timer_value(1),
      I4 => \LINK_TIMER_reg__0\(2),
      I5 => link_timer_value(2),
      O => n_0_LINK_TIMER_SATURATED_i_4
    );
LINK_TIMER_SATURATED_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => LINK_TIMER_SATURATED_COMB,
      Q => LINK_TIMER_SATURATED,
      R => I1
    );
LINK_TIMER_SATURATED_reg_i_1: unisim.vcomponents.CARRY4
    port map (
      CI => '0',
      CO(3) => NLW_LINK_TIMER_SATURATED_reg_i_1_CO_UNCONNECTED(3),
      CO(2) => LINK_TIMER_SATURATED_COMB,
      CO(1) => n_2_LINK_TIMER_SATURATED_reg_i_1,
      CO(0) => n_3_LINK_TIMER_SATURATED_reg_i_1,
      CYINIT => '1',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '0',
      O(3 downto 0) => NLW_LINK_TIMER_SATURATED_reg_i_1_O_UNCONNECTED(3 downto 0),
      S(3) => '0',
      S(2) => n_0_LINK_TIMER_SATURATED_i_2,
      S(1) => n_0_LINK_TIMER_SATURATED_i_3,
      S(0) => n_0_LINK_TIMER_SATURATED_i_4
    );
\LINK_TIMER_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => PULSE4096,
      D => \plusOp__0\(0),
      Q => \LINK_TIMER_reg__0\(0),
      R => \n_0_LINK_TIMER[8]_i_1\
    );
\LINK_TIMER_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => PULSE4096,
      D => \plusOp__0\(1),
      Q => \LINK_TIMER_reg__0\(1),
      R => \n_0_LINK_TIMER[8]_i_1\
    );
\LINK_TIMER_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => PULSE4096,
      D => \plusOp__0\(2),
      Q => \LINK_TIMER_reg__0\(2),
      R => \n_0_LINK_TIMER[8]_i_1\
    );
\LINK_TIMER_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => PULSE4096,
      D => \plusOp__0\(3),
      Q => \LINK_TIMER_reg__0\(3),
      R => \n_0_LINK_TIMER[8]_i_1\
    );
\LINK_TIMER_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => PULSE4096,
      D => \n_0_LINK_TIMER[4]_i_1\,
      Q => \LINK_TIMER_reg__0\(4),
      R => \n_0_LINK_TIMER[8]_i_1\
    );
\LINK_TIMER_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => PULSE4096,
      D => \plusOp__0\(5),
      Q => \LINK_TIMER_reg__0\(5),
      R => \n_0_LINK_TIMER[8]_i_1\
    );
\LINK_TIMER_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => PULSE4096,
      D => \plusOp__0\(6),
      Q => \LINK_TIMER_reg__0\(6),
      R => \n_0_LINK_TIMER[8]_i_1\
    );
\LINK_TIMER_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => PULSE4096,
      D => \plusOp__0\(7),
      Q => \LINK_TIMER_reg__0\(7),
      R => \n_0_LINK_TIMER[8]_i_1\
    );
\LINK_TIMER_reg[8]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => PULSE4096,
      D => \plusOp__0\(8),
      Q => \LINK_TIMER_reg__0\(8),
      R => \n_0_LINK_TIMER[8]_i_1\
    );
\MASK_RUDI_BUFERR_TIMER[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"5155A2AA"
    )
    port map (
      I0 => \n_0_MASK_RUDI_BUFERR_TIMER[5]_i_3\,
      I1 => data_out,
      I2 => Q(1),
      I3 => p_0_in,
      I4 => MASK_RUDI_BUFERR_TIMER(0),
      O => \n_0_MASK_RUDI_BUFERR_TIMER[0]_i_1\
    );
\MASK_RUDI_BUFERR_TIMER[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7707777788088888"
    )
    port map (
      I0 => MASK_RUDI_BUFERR_TIMER(0),
      I1 => \n_0_MASK_RUDI_BUFERR_TIMER[5]_i_3\,
      I2 => data_out,
      I3 => Q(1),
      I4 => p_0_in,
      I5 => MASK_RUDI_BUFERR_TIMER(1),
      O => \n_0_MASK_RUDI_BUFERR_TIMER[1]_i_1\
    );
\MASK_RUDI_BUFERR_TIMER[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"007F0080"
    )
    port map (
      I0 => MASK_RUDI_BUFERR_TIMER(0),
      I1 => MASK_RUDI_BUFERR_TIMER(1),
      I2 => \n_0_MASK_RUDI_BUFERR_TIMER[5]_i_3\,
      I3 => MASK_RUDI_BUFERR_TIMER0,
      I4 => MASK_RUDI_BUFERR_TIMER(2),
      O => \n_0_MASK_RUDI_BUFERR_TIMER[2]_i_1\
    );
\MASK_RUDI_BUFERR_TIMER[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00007FFF00008000"
    )
    port map (
      I0 => MASK_RUDI_BUFERR_TIMER(2),
      I1 => MASK_RUDI_BUFERR_TIMER(1),
      I2 => MASK_RUDI_BUFERR_TIMER(0),
      I3 => \n_0_MASK_RUDI_BUFERR_TIMER[5]_i_3\,
      I4 => MASK_RUDI_BUFERR_TIMER0,
      I5 => MASK_RUDI_BUFERR_TIMER(3),
      O => \n_0_MASK_RUDI_BUFERR_TIMER[3]_i_1\
    );
\MASK_RUDI_BUFERR_TIMER[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BB0BBBBB44044444"
    )
    port map (
      I0 => \n_0_MASK_RUDI_BUFERR_TIMER[5]_i_2\,
      I1 => \n_0_MASK_RUDI_BUFERR_TIMER[5]_i_3\,
      I2 => data_out,
      I3 => Q(1),
      I4 => p_0_in,
      I5 => MASK_RUDI_BUFERR_TIMER(4),
      O => \n_0_MASK_RUDI_BUFERR_TIMER[4]_i_1\
    );
\MASK_RUDI_BUFERR_TIMER[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00DF0020"
    )
    port map (
      I0 => MASK_RUDI_BUFERR_TIMER(4),
      I1 => \n_0_MASK_RUDI_BUFERR_TIMER[5]_i_2\,
      I2 => \n_0_MASK_RUDI_BUFERR_TIMER[5]_i_3\,
      I3 => MASK_RUDI_BUFERR_TIMER0,
      I4 => MASK_RUDI_BUFERR_TIMER(5),
      O => \n_0_MASK_RUDI_BUFERR_TIMER[5]_i_1\
    );
\MASK_RUDI_BUFERR_TIMER[5]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
    port map (
      I0 => MASK_RUDI_BUFERR_TIMER(2),
      I1 => MASK_RUDI_BUFERR_TIMER(1),
      I2 => MASK_RUDI_BUFERR_TIMER(0),
      I3 => MASK_RUDI_BUFERR_TIMER(3),
      O => \n_0_MASK_RUDI_BUFERR_TIMER[5]_i_2\
    );
\MASK_RUDI_BUFERR_TIMER[5]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F7FF"
    )
    port map (
      I0 => MASK_RUDI_BUFERR_TIMER(8),
      I1 => MASK_RUDI_BUFERR_TIMER(6),
      I2 => \n_0_MASK_RUDI_BUFERR_TIMER[8]_i_2\,
      I3 => MASK_RUDI_BUFERR_TIMER(7),
      O => \n_0_MASK_RUDI_BUFERR_TIMER[5]_i_3\
    );
\MASK_RUDI_BUFERR_TIMER[6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000E3C3"
    )
    port map (
      I0 => MASK_RUDI_BUFERR_TIMER(7),
      I1 => \n_0_MASK_RUDI_BUFERR_TIMER[8]_i_2\,
      I2 => MASK_RUDI_BUFERR_TIMER(6),
      I3 => MASK_RUDI_BUFERR_TIMER(8),
      I4 => MASK_RUDI_BUFERR_TIMER0,
      O => \n_0_MASK_RUDI_BUFERR_TIMER[6]_i_1\
    );
\MASK_RUDI_BUFERR_TIMER[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000BA9A"
    )
    port map (
      I0 => MASK_RUDI_BUFERR_TIMER(7),
      I1 => \n_0_MASK_RUDI_BUFERR_TIMER[8]_i_2\,
      I2 => MASK_RUDI_BUFERR_TIMER(6),
      I3 => MASK_RUDI_BUFERR_TIMER(8),
      I4 => MASK_RUDI_BUFERR_TIMER0,
      O => \n_0_MASK_RUDI_BUFERR_TIMER[7]_i_1\
    );
\MASK_RUDI_BUFERR_TIMER[8]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000FF20"
    )
    port map (
      I0 => MASK_RUDI_BUFERR_TIMER(7),
      I1 => \n_0_MASK_RUDI_BUFERR_TIMER[8]_i_2\,
      I2 => MASK_RUDI_BUFERR_TIMER(6),
      I3 => MASK_RUDI_BUFERR_TIMER(8),
      I4 => MASK_RUDI_BUFERR_TIMER0,
      O => \n_0_MASK_RUDI_BUFERR_TIMER[8]_i_1\
    );
\MASK_RUDI_BUFERR_TIMER[8]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFFFFFFFFFF"
    )
    port map (
      I0 => MASK_RUDI_BUFERR_TIMER(4),
      I1 => MASK_RUDI_BUFERR_TIMER(2),
      I2 => MASK_RUDI_BUFERR_TIMER(1),
      I3 => MASK_RUDI_BUFERR_TIMER(0),
      I4 => MASK_RUDI_BUFERR_TIMER(3),
      I5 => MASK_RUDI_BUFERR_TIMER(5),
      O => \n_0_MASK_RUDI_BUFERR_TIMER[8]_i_2\
    );
\MASK_RUDI_BUFERR_TIMER_reg[0]\: unisim.vcomponents.FDSE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_MASK_RUDI_BUFERR_TIMER[0]_i_1\,
      Q => MASK_RUDI_BUFERR_TIMER(0),
      S => I1
    );
\MASK_RUDI_BUFERR_TIMER_reg[1]\: unisim.vcomponents.FDSE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_MASK_RUDI_BUFERR_TIMER[1]_i_1\,
      Q => MASK_RUDI_BUFERR_TIMER(1),
      S => I1
    );
\MASK_RUDI_BUFERR_TIMER_reg[2]\: unisim.vcomponents.FDSE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_MASK_RUDI_BUFERR_TIMER[2]_i_1\,
      Q => MASK_RUDI_BUFERR_TIMER(2),
      S => I1
    );
\MASK_RUDI_BUFERR_TIMER_reg[3]\: unisim.vcomponents.FDSE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_MASK_RUDI_BUFERR_TIMER[3]_i_1\,
      Q => MASK_RUDI_BUFERR_TIMER(3),
      S => I1
    );
\MASK_RUDI_BUFERR_TIMER_reg[4]\: unisim.vcomponents.FDSE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_MASK_RUDI_BUFERR_TIMER[4]_i_1\,
      Q => MASK_RUDI_BUFERR_TIMER(4),
      S => I1
    );
\MASK_RUDI_BUFERR_TIMER_reg[5]\: unisim.vcomponents.FDSE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_MASK_RUDI_BUFERR_TIMER[5]_i_1\,
      Q => MASK_RUDI_BUFERR_TIMER(5),
      S => I1
    );
\MASK_RUDI_BUFERR_TIMER_reg[6]\: unisim.vcomponents.FDSE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_MASK_RUDI_BUFERR_TIMER[6]_i_1\,
      Q => MASK_RUDI_BUFERR_TIMER(6),
      S => I1
    );
\MASK_RUDI_BUFERR_TIMER_reg[7]\: unisim.vcomponents.FDSE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_MASK_RUDI_BUFERR_TIMER[7]_i_1\,
      Q => MASK_RUDI_BUFERR_TIMER(7),
      S => I1
    );
\MASK_RUDI_BUFERR_TIMER_reg[8]\: unisim.vcomponents.FDSE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_MASK_RUDI_BUFERR_TIMER[8]_i_1\,
      Q => MASK_RUDI_BUFERR_TIMER(8),
      S => I1
    );
MASK_RUDI_BUFERR_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000AEAA00000C00"
    )
    port map (
      I0 => \n_0_MASK_RUDI_BUFERR_TIMER[5]_i_3\,
      I1 => p_0_in,
      I2 => Q(1),
      I3 => data_out,
      I4 => I1,
      I5 => n_0_MASK_RUDI_BUFERR_reg,
      O => n_0_MASK_RUDI_BUFERR_i_1
    );
MASK_RUDI_BUFERR_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => n_0_MASK_RUDI_BUFERR_i_1,
      Q => n_0_MASK_RUDI_BUFERR_reg,
      R => '0'
    );
MASK_RUDI_CLKCOR_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000BF0000000F00"
    )
    port map (
      I0 => RX_RUDI_INVALID,
      I1 => RX_RUDI_INVALID_REG,
      I2 => n_0_MASK_RUDI_CLKCOR_i_3,
      I3 => RXSYNC_STATUS,
      I4 => I1,
      I5 => n_0_MASK_RUDI_CLKCOR_reg,
      O => n_0_MASK_RUDI_CLKCOR_i_1
    );
MASK_RUDI_CLKCOR_i_3: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
    port map (
      I0 => I9(2),
      I1 => I9(1),
      I2 => I9(0),
      O => n_0_MASK_RUDI_CLKCOR_i_3
    );
MASK_RUDI_CLKCOR_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => n_0_MASK_RUDI_CLKCOR_i_1,
      Q => n_0_MASK_RUDI_CLKCOR_reg,
      R => '0'
    );
MR_AN_COMPLETE_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2222222032222220"
    )
    port map (
      I0 => \^an_interrupt\,
      I1 => I1,
      I2 => \n_0_STATE_reg[2]\,
      I3 => \n_0_STATE_reg[1]\,
      I4 => \n_0_STATE_reg[0]\,
      I5 => \n_0_STATE_reg[3]\,
      O => n_0_MR_AN_COMPLETE_i_1
    );
MR_AN_COMPLETE_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => n_0_MR_AN_COMPLETE_i_1,
      Q => \^an_interrupt\,
      R => '0'
    );
MR_AN_ENABLE_CHANGE_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => MR_AN_ENABLE_REG1,
      I1 => MR_AN_ENABLE_REG2,
      O => MR_AN_ENABLE_CHANGE0
    );
MR_AN_ENABLE_CHANGE_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => MR_AN_ENABLE_CHANGE0,
      Q => MR_AN_ENABLE_CHANGE,
      R => I1
    );
MR_AN_ENABLE_REG1_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => Q(3),
      Q => MR_AN_ENABLE_REG1,
      R => I1
    );
MR_AN_ENABLE_REG2_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => MR_AN_ENABLE_REG1,
      Q => MR_AN_ENABLE_REG2,
      R => I1
    );
\MR_LP_ADV_ABILITY_INT[13]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => I8,
      I1 => SGMII_PHY_STATUS1_out,
      I2 => \^stat_vec_duplex_mode_rslvd\,
      O => \n_0_MR_LP_ADV_ABILITY_INT[13]_i_1\
    );
\MR_LP_ADV_ABILITY_INT[16]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => p_1_in,
      I1 => SGMII_PHY_STATUS1_out,
      I2 => \n_0_MR_LP_ADV_ABILITY_INT_reg[16]\,
      O => \n_0_MR_LP_ADV_ABILITY_INT[16]_i_1\
    );
\MR_LP_ADV_ABILITY_INT_reg[13]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_MR_LP_ADV_ABILITY_INT[13]_i_1\,
      Q => \^stat_vec_duplex_mode_rslvd\,
      R => I1
    );
\MR_LP_ADV_ABILITY_INT_reg[16]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_MR_LP_ADV_ABILITY_INT[16]_i_1\,
      Q => \n_0_MR_LP_ADV_ABILITY_INT_reg[16]\,
      R => I1
    );
\MR_NP_RX_INT_reg[16]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '0',
      D => p_1_in,
      Q => \n_0_MR_NP_RX_INT_reg[16]\,
      R => I1
    );
MR_REMOTE_FAULT_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"5510"
    )
    port map (
      I0 => I1,
      I1 => \n_0_MR_LP_ADV_ABILITY_INT_reg[16]\,
      I2 => GENERATE_REMOTE_FAULT,
      I3 => \^status_vector\(5),
      O => n_0_MR_REMOTE_FAULT_i_1
    );
MR_REMOTE_FAULT_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => n_0_MR_REMOTE_FAULT_i_1,
      Q => \^status_vector\(5),
      R => '0'
    );
MR_RESTART_AN_INT_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2020332000003300"
    )
    port map (
      I0 => n_0_XMIT_CONFIG_INT_i_4,
      I1 => I1,
      I2 => Q(3),
      I3 => MR_RESTART_AN_SET_REG1,
      I4 => MR_RESTART_AN_SET_REG2,
      I5 => n_0_MR_RESTART_AN_INT_reg,
      O => n_0_MR_RESTART_AN_INT_i_1
    );
MR_RESTART_AN_INT_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => n_0_MR_RESTART_AN_INT_i_1,
      Q => n_0_MR_RESTART_AN_INT_reg,
      R => '0'
    );
MR_RESTART_AN_SET_REG1_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => RESTART_AN_SET,
      Q => MR_RESTART_AN_SET_REG1,
      R => I1
    );
MR_RESTART_AN_SET_REG2_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => MR_RESTART_AN_SET_REG1,
      Q => MR_RESTART_AN_SET_REG2,
      R => I1
    );
\PREVIOUS_STATE_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_STATE_reg[0]\,
      Q => PREVIOUS_STATE(0),
      R => I1
    );
\PREVIOUS_STATE_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_STATE_reg[1]\,
      Q => PREVIOUS_STATE(1),
      R => I1
    );
\PREVIOUS_STATE_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_STATE_reg[2]\,
      Q => PREVIOUS_STATE(2),
      R => I1
    );
\PREVIOUS_STATE_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_STATE_reg[3]\,
      Q => PREVIOUS_STATE(3),
      R => I1
    );
PULSE4096_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => TIMER4096_MSB_REG,
      I1 => \n_0_TIMER4096_reg[11]\,
      O => PULSE40960
    );
PULSE4096_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => PULSE40960,
      Q => PULSE4096,
      R => I1
    );
RECEIVED_IDLE_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => I3,
      Q => \^o1\,
      R => '0'
    );
RUDI_INVALID_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => RX_RUDI_INVALID_DELAY(1),
      Q => \^status_vector\(0),
      R => I1
    );
RX_CONFIG_REG_NULL_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => I4,
      Q => \^o2\,
      R => '0'
    );
\RX_CONFIG_REG_REG_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => RX_CONFIG_VALID,
      D => I23,
      Q => \^o5\(0),
      R => I13(0)
    );
\RX_CONFIG_REG_REG_reg[10]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => RX_CONFIG_VALID,
      D => I12,
      Q => \^o5\(10),
      R => I13(0)
    );
\RX_CONFIG_REG_REG_reg[11]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => RX_CONFIG_VALID,
      D => I11,
      Q => \^o5\(11),
      R => I13(0)
    );
\RX_CONFIG_REG_REG_reg[12]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => RX_CONFIG_VALID,
      D => I8,
      Q => \n_0_RX_CONFIG_REG_REG_reg[12]\,
      R => I13(0)
    );
\RX_CONFIG_REG_REG_reg[13]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => RX_CONFIG_VALID,
      D => I7,
      Q => \n_0_RX_CONFIG_REG_REG_reg[13]\,
      R => I13(0)
    );
\RX_CONFIG_REG_REG_reg[14]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => RX_CONFIG_VALID,
      D => RX_CONFIG_REG(0),
      Q => p_0_in44_in,
      R => I13(0)
    );
\RX_CONFIG_REG_REG_reg[15]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => RX_CONFIG_VALID,
      D => p_1_in,
      Q => p_0_in0_in,
      R => I13(0)
    );
\RX_CONFIG_REG_REG_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => RX_CONFIG_VALID,
      D => I22,
      Q => \^o5\(1),
      R => I13(0)
    );
\RX_CONFIG_REG_REG_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => RX_CONFIG_VALID,
      D => I21,
      Q => \^o5\(2),
      R => I13(0)
    );
\RX_CONFIG_REG_REG_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => RX_CONFIG_VALID,
      D => I20,
      Q => \^o5\(3),
      R => I13(0)
    );
\RX_CONFIG_REG_REG_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => RX_CONFIG_VALID,
      D => I19,
      Q => \^o5\(4),
      R => I13(0)
    );
\RX_CONFIG_REG_REG_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => RX_CONFIG_VALID,
      D => I18,
      Q => \^o5\(5),
      R => I13(0)
    );
\RX_CONFIG_REG_REG_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => RX_CONFIG_VALID,
      D => I17,
      Q => \^o5\(6),
      R => I13(0)
    );
\RX_CONFIG_REG_REG_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => RX_CONFIG_VALID,
      D => I16,
      Q => \^o5\(7),
      R => I13(0)
    );
\RX_CONFIG_REG_REG_reg[8]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => RX_CONFIG_VALID,
      D => I15,
      Q => \^o5\(8),
      R => I13(0)
    );
\RX_CONFIG_REG_REG_reg[9]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => RX_CONFIG_VALID,
      D => I14,
      Q => \^o5\(9),
      R => I13(0)
    );
\RX_CONFIG_SNAPSHOT[15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000088088888"
    )
    port map (
      I0 => CO(0),
      I1 => \n_0_RX_CONFIG_SNAPSHOT[15]_i_3\,
      I2 => \n_0_STATE[2]_i_3\,
      I3 => \n_0_STATE_reg[3]\,
      I4 => \n_0_STATE_reg[0]\,
      I5 => \n_0_RX_CONFIG_SNAPSHOT[15]_i_4\,
      O => RX_CONFIG_SNAPSHOT
    );
\RX_CONFIG_SNAPSHOT[15]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000020"
    )
    port map (
      I0 => RX_CONFIG_VALID,
      I1 => ABILITY_MATCH,
      I2 => ABILITY_MATCH_2,
      I3 => n_0_MASK_RUDI_BUFERR_reg,
      I4 => RX_IDLE,
      O => \n_0_RX_CONFIG_SNAPSHOT[15]_i_3\
    );
\RX_CONFIG_SNAPSHOT[15]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F6"
    )
    port map (
      I0 => p_0_in0_in,
      I1 => p_1_in,
      I2 => \^o1\,
      O => \n_0_RX_CONFIG_SNAPSHOT[15]_i_4\
    );
\RX_CONFIG_SNAPSHOT[15]_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => \n_0_RX_CONFIG_REG_REG_reg[13]\,
      I1 => I7,
      I2 => \n_0_RX_CONFIG_REG_REG_reg[12]\,
      I3 => I8,
      O => S(0)
    );
\RX_CONFIG_SNAPSHOT_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => RX_CONFIG_SNAPSHOT,
      D => I23,
      Q => O10(0),
      R => I1
    );
\RX_CONFIG_SNAPSHOT_reg[10]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => RX_CONFIG_SNAPSHOT,
      D => I12,
      Q => O10(10),
      R => I1
    );
\RX_CONFIG_SNAPSHOT_reg[11]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => RX_CONFIG_SNAPSHOT,
      D => I11,
      Q => O10(11),
      R => I1
    );
\RX_CONFIG_SNAPSHOT_reg[12]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => RX_CONFIG_SNAPSHOT,
      D => I8,
      Q => \n_0_RX_CONFIG_SNAPSHOT_reg[12]\,
      R => I1
    );
\RX_CONFIG_SNAPSHOT_reg[13]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => RX_CONFIG_SNAPSHOT,
      D => I7,
      Q => \n_0_RX_CONFIG_SNAPSHOT_reg[13]\,
      R => I1
    );
\RX_CONFIG_SNAPSHOT_reg[15]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => RX_CONFIG_SNAPSHOT,
      D => p_1_in,
      Q => \n_0_RX_CONFIG_SNAPSHOT_reg[15]\,
      R => I1
    );
\RX_CONFIG_SNAPSHOT_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => RX_CONFIG_SNAPSHOT,
      D => I22,
      Q => O10(1),
      R => I1
    );
\RX_CONFIG_SNAPSHOT_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => RX_CONFIG_SNAPSHOT,
      D => I21,
      Q => O10(2),
      R => I1
    );
\RX_CONFIG_SNAPSHOT_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => RX_CONFIG_SNAPSHOT,
      D => I20,
      Q => O10(3),
      R => I1
    );
\RX_CONFIG_SNAPSHOT_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => RX_CONFIG_SNAPSHOT,
      D => I19,
      Q => O10(4),
      R => I1
    );
\RX_CONFIG_SNAPSHOT_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => RX_CONFIG_SNAPSHOT,
      D => I18,
      Q => O10(5),
      R => I1
    );
\RX_CONFIG_SNAPSHOT_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => RX_CONFIG_SNAPSHOT,
      D => I17,
      Q => O10(6),
      R => I1
    );
\RX_CONFIG_SNAPSHOT_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => RX_CONFIG_SNAPSHOT,
      D => I16,
      Q => O10(7),
      R => I1
    );
\RX_CONFIG_SNAPSHOT_reg[8]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => RX_CONFIG_SNAPSHOT,
      D => I15,
      Q => O10(8),
      R => I1
    );
\RX_CONFIG_SNAPSHOT_reg[9]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => RX_CONFIG_SNAPSHOT,
      D => I14,
      Q => O10(9),
      R => I1
    );
RX_DV_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0A0B0A0A0A0A0A0A"
    )
    port map (
      I0 => n_0_RX_DV_i_2,
      I1 => EOP_REG1,
      I2 => SR(0),
      I3 => I10,
      I4 => \^xmit_data\,
      I5 => gmii_rx_dv,
      O => O6
    );
RX_DV_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0008"
    )
    port map (
      I0 => \^o3\,
      I1 => SOP_REG3,
      I2 => Q(2),
      I3 => Q(1),
      O => n_0_RX_DV_i_2
    );
RX_DV_i_4: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BA"
    )
    port map (
      I0 => \^xmit_data_int\,
      I1 => Q(3),
      I2 => Q(0),
      O => \^xmit_data\
    );
RX_IDLE_REG1_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => RX_IDLE,
      Q => RX_IDLE_REG1,
      R => I1
    );
RX_IDLE_REG2_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => RX_IDLE_REG1,
      Q => RX_IDLE_REG2,
      R => I1
    );
\RX_RUDI_INVALID_DELAY[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"000000AB"
    )
    port map (
      I0 => I5,
      I1 => \^xmit_data\,
      I2 => RXSYNC_STATUS,
      I3 => n_0_MASK_RUDI_BUFERR_reg,
      I4 => n_0_MASK_RUDI_CLKCOR_reg,
      O => RX_RUDI_INVALID_DELAY0
    );
\RX_RUDI_INVALID_DELAY_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => RX_RUDI_INVALID_DELAY0,
      Q => RX_RUDI_INVALID_DELAY(0),
      R => I1
    );
\RX_RUDI_INVALID_DELAY_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => RX_RUDI_INVALID_DELAY(0),
      Q => RX_RUDI_INVALID_DELAY(1),
      R => I1
    );
RX_RUDI_INVALID_REG_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => I2,
      Q => RX_RUDI_INVALID_REG,
      R => '0'
    );
SGMII_PHY_STATUS_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => p_1_in,
      I1 => SGMII_PHY_STATUS1_out,
      I2 => \^status_vector\(1),
      O => n_0_SGMII_PHY_STATUS_i_1
    );
SGMII_PHY_STATUS_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => n_0_SGMII_PHY_STATUS_i_1,
      Q => \^status_vector\(1),
      R => I1
    );
\SGMII_SPEED[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => I12,
      I1 => SGMII_PHY_STATUS1_out,
      I2 => \^status_vector\(3),
      O => \n_0_SGMII_SPEED[0]_i_1\
    );
\SGMII_SPEED[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => I11,
      I1 => SGMII_PHY_STATUS1_out,
      I2 => \^status_vector\(4),
      O => \n_0_SGMII_SPEED[1]_i_1\
    );
\SGMII_SPEED[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000001000"
    )
    port map (
      I0 => PREVIOUS_STATE(3),
      I1 => PREVIOUS_STATE(2),
      I2 => PREVIOUS_STATE(0),
      I3 => PREVIOUS_STATE(1),
      I4 => \n_0_SGMII_SPEED[1]_i_3\,
      I5 => n_0_TOGGLE_TX_i_2,
      O => SGMII_PHY_STATUS1_out
    );
\SGMII_SPEED[1]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => \n_0_STATE_reg[1]\,
      I1 => \n_0_STATE_reg[2]\,
      O => \n_0_SGMII_SPEED[1]_i_3\
    );
\SGMII_SPEED_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_SGMII_SPEED[0]_i_1\,
      Q => \^status_vector\(3),
      R => I1
    );
\SGMII_SPEED_reg[1]\: unisim.vcomponents.FDSE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_SGMII_SPEED[1]_i_1\,
      Q => \^status_vector\(4),
      S => I1
    );
START_LINK_TIMER_REG2_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => START_LINK_TIMER_REG,
      Q => START_LINK_TIMER_REG2,
      R => I1
    );
START_LINK_TIMER_REG_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"DDDDDDDDDDFDFDFD"
    )
    port map (
      I0 => \n_0_STATE[3]_i_3\,
      I1 => n_0_START_LINK_TIMER_REG_i_2,
      I2 => n_0_START_LINK_TIMER_REG_i_3,
      I3 => ABILITY_MATCH,
      I4 => \^o2\,
      I5 => n_0_START_LINK_TIMER_REG_i_4,
      O => n_0_START_LINK_TIMER_REG_i_1
    );
START_LINK_TIMER_REG_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000C000200000002"
    )
    port map (
      I0 => Q(3),
      I1 => \n_0_STATE_reg[0]\,
      I2 => \n_0_STATE_reg[3]\,
      I3 => \n_0_STATE_reg[2]\,
      I4 => \n_0_STATE_reg[1]\,
      I5 => \n_0_STATE[2]_i_2\,
      O => n_0_START_LINK_TIMER_REG_i_2
    );
START_LINK_TIMER_REG_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2AAA"
    )
    port map (
      I0 => LINK_TIMER_DONE,
      I1 => an_adv_config_vector(1),
      I2 => \n_0_MR_LP_ADV_ABILITY_INT_reg[16]\,
      I3 => \n_0_MR_NP_RX_INT_reg[16]\,
      O => n_0_START_LINK_TIMER_REG_i_3
    );
START_LINK_TIMER_REG_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFEF"
    )
    port map (
      I0 => \n_0_STATE_reg[3]\,
      I1 => \n_0_STATE_reg[0]\,
      I2 => \n_0_STATE_reg[2]\,
      I3 => \n_0_STATE_reg[1]\,
      O => n_0_START_LINK_TIMER_REG_i_4
    );
START_LINK_TIMER_REG_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => n_0_START_LINK_TIMER_REG_i_1,
      Q => START_LINK_TIMER_REG,
      R => I1
    );
\STATE[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"02"
    )
    port map (
      I0 => \n_0_STATE[3]_i_3\,
      I1 => \n_0_STATE[0]_i_2\,
      I2 => \n_0_STATE_reg[3]\,
      O => \n_0_STATE[0]_i_1\
    );
\STATE[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0015001500000015"
    )
    port map (
      I0 => \n_0_STATE[0]_i_3\,
      I1 => \n_0_STATE[1]_i_5\,
      I2 => \n_0_STATE[0]_i_4\,
      I3 => \n_0_STATE[0]_i_5\,
      I4 => \n_0_STATE[0]_i_6\,
      I5 => \n_0_STATE[0]_i_7\,
      O => \n_0_STATE[0]_i_2\
    );
\STATE[0]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00101110"
    )
    port map (
      I0 => \n_0_STATE_reg[1]\,
      I1 => \n_0_STATE_reg[2]\,
      I2 => Q(3),
      I3 => \n_0_STATE_reg[0]\,
      I4 => LINK_TIMER_DONE,
      O => \n_0_STATE[0]_i_3\
    );
\STATE[0]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BFFFAAAA"
    )
    port map (
      I0 => \n_0_STATE_reg[0]\,
      I1 => \n_0_MR_NP_RX_INT_reg[16]\,
      I2 => \n_0_MR_LP_ADV_ABILITY_INT_reg[16]\,
      I3 => an_adv_config_vector(1),
      I4 => LINK_TIMER_DONE,
      O => \n_0_STATE[0]_i_4\
    );
\STATE[0]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0404004004440040"
    )
    port map (
      I0 => \n_0_STATE_reg[2]\,
      I1 => \n_0_STATE_reg[1]\,
      I2 => ABILITY_MATCH,
      I3 => \^o2\,
      I4 => \n_0_STATE_reg[0]\,
      I5 => n_0_ACKNOWLEDGE_MATCH_3_reg,
      O => \n_0_STATE[0]_i_5\
    );
\STATE[0]_i_6\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => \n_0_STATE_reg[2]\,
      I1 => \n_0_STATE_reg[1]\,
      O => \n_0_STATE[0]_i_6\
    );
\STATE[0]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"DDD9D9DD"
    )
    port map (
      I0 => \n_0_STATE_reg[0]\,
      I1 => ABILITY_MATCH,
      I2 => \^o2\,
      I3 => \^o5\(11),
      I4 => TOGGLE_RX,
      O => \n_0_STATE[0]_i_7\
    );
\STATE[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00A8"
    )
    port map (
      I0 => \n_0_STATE[3]_i_3\,
      I1 => \n_0_STATE[1]_i_2\,
      I2 => \n_0_STATE[1]_i_3\,
      I3 => \n_0_STATE_reg[3]\,
      O => \n_0_STATE[1]_i_1\
    );
\STATE[1]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EAAAAAAA"
    )
    port map (
      I0 => \n_0_STATE[1]_i_4\,
      I1 => IDLE_MATCH,
      I2 => \n_0_STATE_reg[0]\,
      I3 => LINK_TIMER_DONE,
      I4 => \n_0_STATE[1]_i_5\,
      O => \n_0_STATE[1]_i_2\
    );
\STATE[1]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF003F00A0"
    )
    port map (
      I0 => LINK_TIMER_DONE,
      I1 => \n_0_STATE[1]_i_6\,
      I2 => \n_0_STATE_reg[0]\,
      I3 => \n_0_STATE_reg[2]\,
      I4 => \n_0_STATE_reg[1]\,
      I5 => \n_0_STATE_reg[3]\,
      O => \n_0_STATE[1]_i_3\
    );
\STATE[1]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00088888"
    )
    port map (
      I0 => \n_0_STATE_reg[1]\,
      I1 => \n_0_STATE_reg[2]\,
      I2 => \n_0_STATE_reg[0]\,
      I3 => \^o2\,
      I4 => ABILITY_MATCH,
      O => \n_0_STATE[1]_i_4\
    );
\STATE[1]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0444"
    )
    port map (
      I0 => \n_0_STATE_reg[1]\,
      I1 => \n_0_STATE_reg[2]\,
      I2 => \^o2\,
      I3 => ABILITY_MATCH,
      O => \n_0_STATE[1]_i_5\
    );
\STATE[1]_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"C8"
    )
    port map (
      I0 => \^o2\,
      I1 => ABILITY_MATCH,
      I2 => n_0_ACKNOWLEDGE_MATCH_3_reg,
      O => \n_0_STATE[1]_i_6\
    );
\STATE[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000AAAA00008000"
    )
    port map (
      I0 => \n_0_STATE[3]_i_3\,
      I1 => \n_0_STATE[2]_i_2\,
      I2 => \n_0_STATE_reg[0]\,
      I3 => \n_0_STATE[2]_i_3\,
      I4 => \n_0_STATE_reg[3]\,
      I5 => \n_0_STATE[2]_i_4\,
      O => \n_0_STATE[2]_i_1\
    );
\STATE[2]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => ABILITY_MATCH,
      I1 => n_0_ACKNOWLEDGE_MATCH_3_reg,
      I2 => CONSISTENCY_MATCH,
      I3 => \^o2\,
      O => \n_0_STATE[2]_i_2\
    );
\STATE[2]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \n_0_STATE_reg[1]\,
      I1 => \n_0_STATE_reg[2]\,
      O => \n_0_STATE[2]_i_3\
    );
\STATE[2]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"550055005F007F00"
    )
    port map (
      I0 => ABILITY_MATCH,
      I1 => \n_0_STATE[2]_i_5\,
      I2 => \n_0_STATE_reg[1]\,
      I3 => \n_0_STATE_reg[2]\,
      I4 => \n_0_STATE_reg[0]\,
      I5 => \^o2\,
      O => \n_0_STATE[2]_i_4\
    );
\STATE[2]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \^o5\(11),
      I1 => TOGGLE_RX,
      O => \n_0_STATE[2]_i_5\
    );
\STATE[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"88B8"
    )
    port map (
      I0 => \n_0_STATE[3]_i_2\,
      I1 => \n_0_STATE[3]_i_3\,
      I2 => AN_SYNC_STATUS,
      I3 => Q(3),
      O => \n_0_STATE[3]_i_1\
    );
\STATE[3]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000203"
    )
    port map (
      I0 => \n_0_STATE_reg[3]\,
      I1 => \n_0_STATE_reg[1]\,
      I2 => \n_0_STATE_reg[0]\,
      I3 => Q(3),
      I4 => \n_0_STATE_reg[2]\,
      O => \n_0_STATE[3]_i_2\
    );
\STATE[3]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000FDFF"
    )
    port map (
      I0 => \^xmit_config_int\,
      I1 => n_0_MASK_RUDI_CLKCOR_reg,
      I2 => n_0_MASK_RUDI_BUFERR_reg,
      I3 => RX_RUDI_INVALID,
      I4 => \n_0_STATE[3]_i_4\,
      O => \n_0_STATE[3]_i_3\
    );
\STATE[3]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FB"
    )
    port map (
      I0 => MR_AN_ENABLE_CHANGE,
      I1 => AN_SYNC_STATUS,
      I2 => n_0_MR_RESTART_AN_INT_reg,
      O => \n_0_STATE[3]_i_4\
    );
\STATE_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_STATE[0]_i_1\,
      Q => \n_0_STATE_reg[0]\,
      R => I1
    );
\STATE_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_STATE[1]_i_1\,
      Q => \n_0_STATE_reg[1]\,
      R => I1
    );
\STATE_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_STATE[2]_i_1\,
      Q => \n_0_STATE_reg[2]\,
      R => I1
    );
\STATE_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_STATE[3]_i_1\,
      Q => \n_0_STATE_reg[3]\,
      R => I1
    );
SYNC_STATUS_HELD_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00BF00AA"
    )
    port map (
      I0 => RXSYNC_STATUS,
      I1 => LINK_TIMER_SATURATED,
      I2 => PULSE4096,
      I3 => I1,
      I4 => SYNC_STATUS_HELD,
      O => n_0_SYNC_STATUS_HELD_i_1
    );
SYNC_STATUS_HELD_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => n_0_SYNC_STATUS_HELD_i_1,
      Q => SYNC_STATUS_HELD,
      R => '0'
    );
\TIMER4096[0]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \n_0_TIMER4096_reg[0]\,
      O => \n_0_TIMER4096[0]_i_2\
    );
TIMER4096_MSB_REG_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_TIMER4096_reg[11]\,
      Q => TIMER4096_MSB_REG,
      R => I1
    );
\TIMER4096_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_TIMER4096_reg[0]_i_1\,
      Q => \n_0_TIMER4096_reg[0]\,
      R => I1
    );
\TIMER4096_reg[10]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_TIMER4096_reg[10]_i_1\,
      Q => \n_0_TIMER4096_reg[10]\,
      R => I1
    );
\TIMER4096_reg[11]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_TIMER4096_reg[11]_i_1\,
      Q => \n_0_TIMER4096_reg[11]\,
      R => I1
    );
\TIMER4096_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_TIMER4096_reg[1]_i_1\,
      Q => \n_0_TIMER4096_reg[1]\,
      R => I1
    );
\TIMER4096_reg[1]_i_2_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => '0',
      CO(3) => \n_0_TIMER4096_reg[4]_i_2\,
      CO(2) => \n_0_TIMER4096_reg[3]_i_2\,
      CO(1) => \n_0_TIMER4096_reg[2]_i_2\,
      CO(0) => \n_0_TIMER4096_reg[1]_i_2\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '1',
      O(3) => \n_0_TIMER4096_reg[3]_i_1\,
      O(2) => \n_0_TIMER4096_reg[2]_i_1\,
      O(1) => \n_0_TIMER4096_reg[1]_i_1\,
      O(0) => \n_0_TIMER4096_reg[0]_i_1\,
      S(3) => \n_0_TIMER4096_reg[3]\,
      S(2) => \n_0_TIMER4096_reg[2]\,
      S(1) => \n_0_TIMER4096_reg[1]\,
      S(0) => \n_0_TIMER4096[0]_i_2\
    );
\TIMER4096_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_TIMER4096_reg[2]_i_1\,
      Q => \n_0_TIMER4096_reg[2]\,
      R => I1
    );
\TIMER4096_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_TIMER4096_reg[3]_i_1\,
      Q => \n_0_TIMER4096_reg[3]\,
      R => I1
    );
\TIMER4096_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_TIMER4096_reg[4]_i_1\,
      Q => \n_0_TIMER4096_reg[4]\,
      R => I1
    );
\TIMER4096_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_TIMER4096_reg[5]_i_1\,
      Q => \n_0_TIMER4096_reg[5]\,
      R => I1
    );
\TIMER4096_reg[5]_i_2_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_TIMER4096_reg[4]_i_2\,
      CO(3) => \n_0_TIMER4096_reg[8]_i_2\,
      CO(2) => \n_0_TIMER4096_reg[7]_i_2\,
      CO(1) => \n_0_TIMER4096_reg[6]_i_2\,
      CO(0) => \n_0_TIMER4096_reg[5]_i_2\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '0',
      O(3) => \n_0_TIMER4096_reg[7]_i_1\,
      O(2) => \n_0_TIMER4096_reg[6]_i_1\,
      O(1) => \n_0_TIMER4096_reg[5]_i_1\,
      O(0) => \n_0_TIMER4096_reg[4]_i_1\,
      S(3) => \n_0_TIMER4096_reg[7]\,
      S(2) => \n_0_TIMER4096_reg[6]\,
      S(1) => \n_0_TIMER4096_reg[5]\,
      S(0) => \n_0_TIMER4096_reg[4]\
    );
\TIMER4096_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_TIMER4096_reg[6]_i_1\,
      Q => \n_0_TIMER4096_reg[6]\,
      R => I1
    );
\TIMER4096_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_TIMER4096_reg[7]_i_1\,
      Q => \n_0_TIMER4096_reg[7]\,
      R => I1
    );
\TIMER4096_reg[8]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_TIMER4096_reg[8]_i_1\,
      Q => \n_0_TIMER4096_reg[8]\,
      R => I1
    );
\TIMER4096_reg[9]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_TIMER4096_reg[9]_i_1\,
      Q => \n_0_TIMER4096_reg[9]\,
      R => I1
    );
\TIMER4096_reg[9]_i_2_CARRY4\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_TIMER4096_reg[8]_i_2\,
      CO(3 downto 2) => \NLW_TIMER4096_reg[9]_i_2_CARRY4_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \n_0_TIMER4096_reg[10]_i_2\,
      CO(0) => \n_0_TIMER4096_reg[9]_i_2\,
      CYINIT => '0',
      DI(3) => \NLW_TIMER4096_reg[9]_i_2_CARRY4_DI_UNCONNECTED\(3),
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '0',
      O(3) => \n_0_TIMER4096_reg[11]_i_1\,
      O(2) => \n_0_TIMER4096_reg[10]_i_1\,
      O(1) => \n_0_TIMER4096_reg[9]_i_1\,
      O(0) => \n_0_TIMER4096_reg[8]_i_1\,
      S(3) => \n_0_TIMER4096_reg[11]\,
      S(2) => \n_0_TIMER4096_reg[10]\,
      S(1) => \n_0_TIMER4096_reg[9]\,
      S(0) => \n_0_TIMER4096_reg[8]\
    );
TOGGLE_RX_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => I11,
      I1 => SGMII_PHY_STATUS1_out,
      I2 => TOGGLE_RX,
      O => n_0_TOGGLE_RX_i_1
    );
TOGGLE_RX_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => n_0_TOGGLE_RX_i_1,
      Q => TOGGLE_RX,
      R => I1
    );
TOGGLE_TX_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3333BABBCCCC8A88"
    )
    port map (
      I0 => an_adv_config_vector(0),
      I1 => SGMII_PHY_STATUS1_out,
      I2 => n_0_TOGGLE_TX_i_2,
      I3 => \n_0_STATE_reg[1]\,
      I4 => \n_0_STATE_reg[2]\,
      I5 => TOGGLE_TX,
      O => n_0_TOGGLE_TX_i_1
    );
TOGGLE_TX_i_2: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \n_0_STATE_reg[0]\,
      I1 => \n_0_STATE_reg[3]\,
      O => n_0_TOGGLE_TX_i_2
    );
TOGGLE_TX_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => n_0_TOGGLE_TX_i_1,
      Q => TOGGLE_TX,
      R => I1
    );
\TX_CONFIG_REG_INT[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFF60004"
    )
    port map (
      I0 => \n_0_STATE_reg[2]\,
      I1 => \n_0_STATE_reg[1]\,
      I2 => \n_0_STATE_reg[3]\,
      I3 => \n_0_STATE_reg[0]\,
      I4 => \^o9\,
      O => \n_0_TX_CONFIG_REG_INT[0]_i_1\
    );
\TX_CONFIG_REG_INT[11]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFF8C00000080"
    )
    port map (
      I0 => TOGGLE_TX,
      I1 => \n_0_STATE_reg[2]\,
      I2 => \n_0_STATE_reg[1]\,
      I3 => \n_0_STATE_reg[3]\,
      I4 => \n_0_STATE_reg[0]\,
      I5 => \^o8\,
      O => \n_0_TX_CONFIG_REG_INT[11]_i_1\
    );
\TX_CONFIG_REG_INT[14]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EFEE0020"
    )
    port map (
      I0 => \n_0_STATE_reg[0]\,
      I1 => \n_0_STATE_reg[3]\,
      I2 => \n_0_STATE_reg[1]\,
      I3 => \n_0_STATE_reg[2]\,
      I4 => \^o7\,
      O => \n_0_TX_CONFIG_REG_INT[14]_i_1\
    );
\TX_CONFIG_REG_INT_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_TX_CONFIG_REG_INT[0]_i_1\,
      Q => \^o9\,
      R => I1
    );
\TX_CONFIG_REG_INT_reg[11]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_TX_CONFIG_REG_INT[11]_i_1\,
      Q => \^o8\,
      R => I1
    );
\TX_CONFIG_REG_INT_reg[14]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_TX_CONFIG_REG_INT[14]_i_1\,
      Q => \^o7\,
      R => I1
    );
XMIT_CONFIG_INT_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF1010FF00"
    )
    port map (
      I0 => n_0_XMIT_CONFIG_INT_i_2,
      I1 => n_0_XMIT_CONFIG_INT_i_3,
      I2 => \^xmit_config_int\,
      I3 => Q(3),
      I4 => n_0_XMIT_CONFIG_INT_i_4,
      I5 => I1,
      O => n_0_XMIT_CONFIG_INT_i_1
    );
XMIT_CONFIG_INT_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0002"
    )
    port map (
      I0 => \n_0_STATE_reg[3]\,
      I1 => \n_0_STATE_reg[2]\,
      I2 => \n_0_STATE_reg[1]\,
      I3 => \n_0_STATE_reg[0]\,
      O => n_0_XMIT_CONFIG_INT_i_2
    );
XMIT_CONFIG_INT_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0040"
    )
    port map (
      I0 => \n_0_STATE_reg[1]\,
      I1 => \n_0_STATE_reg[2]\,
      I2 => \n_0_STATE_reg[0]\,
      I3 => \n_0_STATE_reg[3]\,
      O => n_0_XMIT_CONFIG_INT_i_3
    );
XMIT_CONFIG_INT_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => \n_0_STATE_reg[3]\,
      I1 => \n_0_STATE_reg[0]\,
      I2 => \n_0_STATE_reg[1]\,
      I3 => \n_0_STATE_reg[2]\,
      O => n_0_XMIT_CONFIG_INT_i_4
    );
XMIT_CONFIG_INT_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => n_0_XMIT_CONFIG_INT_i_1,
      Q => \^xmit_config_int\,
      R => '0'
    );
XMIT_DATA_INT_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4002"
    )
    port map (
      I0 => \n_0_STATE_reg[3]\,
      I1 => \n_0_STATE_reg[0]\,
      I2 => \n_0_STATE_reg[2]\,
      I3 => \n_0_STATE_reg[1]\,
      O => XMIT_DATA_INT0
    );
XMIT_DATA_INT_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => XMIT_DATA_INT0,
      Q => \^xmit_data_int\,
      R => I1
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \gmii_to_sgmii_RX__parameterized0\ is
  port (
    K28p5_REG1 : out STD_LOGIC;
    RX_IDLE : out STD_LOGIC;
    SOP_REG3 : out STD_LOGIC;
    EOP_REG1 : out STD_LOGIC;
    gmii_rx_er : out STD_LOGIC;
    RX_CONFIG_VALID : out STD_LOGIC;
    status_vector : out STD_LOGIC_VECTOR ( 1 downto 0 );
    O1 : out STD_LOGIC;
    gmii_rx_dv : out STD_LOGIC;
    O2 : out STD_LOGIC;
    O3 : out STD_LOGIC;
    O4 : out STD_LOGIC;
    p_1_in : out STD_LOGIC;
    O5 : out STD_LOGIC;
    RX_CONFIG_REG : out STD_LOGIC_VECTOR ( 0 to 0 );
    O6 : out STD_LOGIC;
    O7 : out STD_LOGIC;
    O8 : out STD_LOGIC;
    O9 : out STD_LOGIC;
    O10 : out STD_LOGIC;
    O11 : out STD_LOGIC;
    O12 : out STD_LOGIC;
    O13 : out STD_LOGIC;
    O14 : out STD_LOGIC;
    O15 : out STD_LOGIC;
    O16 : out STD_LOGIC;
    CO : out STD_LOGIC_VECTOR ( 0 to 0 );
    I6 : out STD_LOGIC_VECTOR ( 0 to 0 );
    RX_RUDI_INVALID : out STD_LOGIC;
    I13 : out STD_LOGIC_VECTOR ( 0 to 0 );
    O17 : out STD_LOGIC;
    O18 : out STD_LOGIC;
    gmii_rxd : out STD_LOGIC_VECTOR ( 7 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 7 downto 0 );
    userclk2 : in STD_LOGIC;
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    SYNC_STATUS_REG0 : in STD_LOGIC;
    I1 : in STD_LOGIC;
    I2 : in STD_LOGIC;
    I3 : in STD_LOGIC;
    S : in STD_LOGIC_VECTOR ( 0 to 0 );
    I4 : in STD_LOGIC_VECTOR ( 0 to 0 );
    RXSYNC_STATUS : in STD_LOGIC;
    RXNOTINTABLE_INT : in STD_LOGIC;
    D : in STD_LOGIC;
    p_0_in : in STD_LOGIC;
    I5 : in STD_LOGIC;
    XMIT_DATA_INT : in STD_LOGIC;
    I7 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    XMIT_DATA : in STD_LOGIC;
    RXEVEN : in STD_LOGIC;
    I8 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    I9 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    I10 : in STD_LOGIC;
    I11 : in STD_LOGIC_VECTOR ( 2 downto 0 );
    I12 : in STD_LOGIC;
    I14 : in STD_LOGIC;
    I15 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \gmii_to_sgmii_RX__parameterized0\ : entity is "RX";
end \gmii_to_sgmii_RX__parameterized0\;

architecture STRUCTURE of \gmii_to_sgmii_RX__parameterized0\ is
  signal C : STD_LOGIC;
  signal C0 : STD_LOGIC;
  signal CGBAD : STD_LOGIC;
  signal CGBAD_REG1 : STD_LOGIC;
  signal CGBAD_REG2 : STD_LOGIC;
  signal CGBAD_REG3 : STD_LOGIC;
  signal C_HDR_REMOVED : STD_LOGIC;
  signal C_HDR_REMOVED_REG : STD_LOGIC;
  signal C_REG1 : STD_LOGIC;
  signal C_REG2 : STD_LOGIC;
  signal C_REG3 : STD_LOGIC;
  signal D0p0 : STD_LOGIC;
  signal D0p0_REG : STD_LOGIC;
  signal EOP : STD_LOGIC;
  signal EOP0 : STD_LOGIC;
  signal EOP_REG10 : STD_LOGIC;
  signal EXTEND_ERR : STD_LOGIC;
  signal EXTEND_ERR0 : STD_LOGIC;
  signal EXTEND_REG1 : STD_LOGIC;
  signal EXTEND_REG2 : STD_LOGIC;
  signal EXTEND_REG3 : STD_LOGIC;
  signal EXT_ILLEGAL_K : STD_LOGIC;
  signal EXT_ILLEGAL_K0 : STD_LOGIC;
  signal EXT_ILLEGAL_K_REG1 : STD_LOGIC;
  signal EXT_ILLEGAL_K_REG2 : STD_LOGIC;
  signal FALSE_CARRIER : STD_LOGIC;
  signal FALSE_CARRIER_REG1 : STD_LOGIC;
  signal FALSE_CARRIER_REG2 : STD_LOGIC;
  signal FALSE_CARRIER_REG3 : STD_LOGIC;
  signal FALSE_DATA : STD_LOGIC;
  signal FALSE_DATA0 : STD_LOGIC;
  signal FALSE_K : STD_LOGIC;
  signal FALSE_K0 : STD_LOGIC;
  signal FALSE_NIT : STD_LOGIC;
  signal FALSE_NIT0 : STD_LOGIC;
  signal FROM_IDLE_D : STD_LOGIC;
  signal FROM_IDLE_D0 : STD_LOGIC;
  signal FROM_RX_CX : STD_LOGIC;
  signal FROM_RX_CX0 : STD_LOGIC;
  signal FROM_RX_K : STD_LOGIC;
  signal FROM_RX_K0 : STD_LOGIC;
  signal I : STD_LOGIC;
  signal I0 : STD_LOGIC;
  signal ILLEGAL_K : STD_LOGIC;
  signal ILLEGAL_K0 : STD_LOGIC;
  signal ILLEGAL_K_REG1 : STD_LOGIC;
  signal ILLEGAL_K_REG2 : STD_LOGIC;
  signal K23p7 : STD_LOGIC;
  signal K28p5 : STD_LOGIC;
  signal \^k28p5_reg1\ : STD_LOGIC;
  signal K28p5_REG2 : STD_LOGIC;
  signal K29p7 : STD_LOGIC;
  signal \^o1\ : STD_LOGIC;
  signal \^o10\ : STD_LOGIC;
  signal \^o11\ : STD_LOGIC;
  signal \^o12\ : STD_LOGIC;
  signal \^o13\ : STD_LOGIC;
  signal \^o14\ : STD_LOGIC;
  signal \^o15\ : STD_LOGIC;
  signal \^o16\ : STD_LOGIC;
  signal \^o2\ : STD_LOGIC;
  signal \^o3\ : STD_LOGIC;
  signal \^o4\ : STD_LOGIC;
  signal \^o5\ : STD_LOGIC;
  signal \^o6\ : STD_LOGIC;
  signal \^o7\ : STD_LOGIC;
  signal \^o8\ : STD_LOGIC;
  signal \^o9\ : STD_LOGIC;
  signal R : STD_LOGIC;
  signal RUDI_C0 : STD_LOGIC;
  signal RUDI_I0 : STD_LOGIC;
  signal RXCHARISK_REG1 : STD_LOGIC;
  signal RXDATA_REG5 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \^rx_config_reg\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^rx_config_valid\ : STD_LOGIC;
  signal RX_CONFIG_VALID_INT0 : STD_LOGIC;
  signal RX_DATA_ERROR : STD_LOGIC;
  signal RX_DATA_ERROR0 : STD_LOGIC;
  signal RX_ER0 : STD_LOGIC;
  signal \^rx_idle\ : STD_LOGIC;
  signal R_REG1 : STD_LOGIC;
  signal S0 : STD_LOGIC;
  signal S2 : STD_LOGIC;
  signal SOP : STD_LOGIC;
  signal SOP0 : STD_LOGIC;
  signal SOP_REG1 : STD_LOGIC;
  signal SOP_REG2 : STD_LOGIC;
  signal \^sop_reg3\ : STD_LOGIC;
  signal SYNC_STATUS_REG : STD_LOGIC;
  signal S_0 : STD_LOGIC;
  signal T : STD_LOGIC;
  signal T_REG1 : STD_LOGIC;
  signal T_REG2 : STD_LOGIC;
  signal WAIT_FOR_K : STD_LOGIC;
  signal n_0_CONSISTENCY_MATCH_i_5 : STD_LOGIC;
  signal n_0_CONSISTENCY_MATCH_i_6 : STD_LOGIC;
  signal n_0_CONSISTENCY_MATCH_i_7 : STD_LOGIC;
  signal n_0_CONSISTENCY_MATCH_i_8 : STD_LOGIC;
  signal n_0_CONSISTENCY_MATCH_reg_i_3 : STD_LOGIC;
  signal n_0_D0p0_REG_i_2 : STD_LOGIC;
  signal n_0_EOP_i_2 : STD_LOGIC;
  signal n_0_EXTEND_i_1 : STD_LOGIC;
  signal n_0_EXTEND_i_3 : STD_LOGIC;
  signal n_0_EXTEND_reg : STD_LOGIC;
  signal n_0_FALSE_CARRIER_i_1 : STD_LOGIC;
  signal n_0_FALSE_CARRIER_i_2 : STD_LOGIC;
  signal n_0_FALSE_CARRIER_i_3 : STD_LOGIC;
  signal n_0_FALSE_DATA_i_2 : STD_LOGIC;
  signal n_0_FALSE_DATA_i_3 : STD_LOGIC;
  signal n_0_FALSE_DATA_i_4 : STD_LOGIC;
  signal n_0_FALSE_DATA_i_5 : STD_LOGIC;
  signal n_0_FALSE_DATA_i_6 : STD_LOGIC;
  signal n_0_FALSE_K_i_2 : STD_LOGIC;
  signal n_0_FALSE_NIT_i_2 : STD_LOGIC;
  signal n_0_FALSE_NIT_i_3 : STD_LOGIC;
  signal n_0_FALSE_NIT_i_4 : STD_LOGIC;
  signal n_0_FALSE_NIT_i_5 : STD_LOGIC;
  signal n_0_FALSE_NIT_i_6 : STD_LOGIC;
  signal \n_0_IDLE_REG_reg[0]\ : STD_LOGIC;
  signal \n_0_IDLE_REG_reg[2]\ : STD_LOGIC;
  signal n_0_I_i_2 : STD_LOGIC;
  signal n_0_I_i_3 : STD_LOGIC;
  signal n_0_I_i_5 : STD_LOGIC;
  signal n_0_I_i_6 : STD_LOGIC;
  signal n_0_I_i_7 : STD_LOGIC;
  signal n_0_I_i_8 : STD_LOGIC;
  signal n_0_RECEIVE_i_1 : STD_LOGIC;
  signal \n_0_RXDATA_REG4_reg[0]_srl4\ : STD_LOGIC;
  signal \n_0_RXDATA_REG4_reg[1]_srl4\ : STD_LOGIC;
  signal \n_0_RXDATA_REG4_reg[2]_srl4\ : STD_LOGIC;
  signal \n_0_RXDATA_REG4_reg[3]_srl4\ : STD_LOGIC;
  signal \n_0_RXDATA_REG4_reg[4]_srl4\ : STD_LOGIC;
  signal \n_0_RXDATA_REG4_reg[5]_srl4\ : STD_LOGIC;
  signal \n_0_RXDATA_REG4_reg[6]_srl4\ : STD_LOGIC;
  signal \n_0_RXDATA_REG4_reg[7]_srl4\ : STD_LOGIC;
  signal \n_0_RXD[0]_i_1\ : STD_LOGIC;
  signal \n_0_RXD[1]_i_1\ : STD_LOGIC;
  signal \n_0_RXD[2]_i_1\ : STD_LOGIC;
  signal \n_0_RXD[3]_i_1\ : STD_LOGIC;
  signal \n_0_RXD[4]_i_1\ : STD_LOGIC;
  signal \n_0_RXD[5]_i_1\ : STD_LOGIC;
  signal \n_0_RXD[6]_i_1\ : STD_LOGIC;
  signal \n_0_RXD[7]_i_1\ : STD_LOGIC;
  signal \n_0_RX_CONFIG_REG[0]_i_1\ : STD_LOGIC;
  signal \n_0_RX_CONFIG_REG[10]_i_1\ : STD_LOGIC;
  signal \n_0_RX_CONFIG_REG[11]_i_1\ : STD_LOGIC;
  signal \n_0_RX_CONFIG_REG[12]_i_1\ : STD_LOGIC;
  signal \n_0_RX_CONFIG_REG[13]_i_1\ : STD_LOGIC;
  signal \n_0_RX_CONFIG_REG[14]_i_1\ : STD_LOGIC;
  signal \n_0_RX_CONFIG_REG[15]_i_1\ : STD_LOGIC;
  signal \n_0_RX_CONFIG_REG[1]_i_1\ : STD_LOGIC;
  signal \n_0_RX_CONFIG_REG[2]_i_1\ : STD_LOGIC;
  signal \n_0_RX_CONFIG_REG[3]_i_1\ : STD_LOGIC;
  signal \n_0_RX_CONFIG_REG[4]_i_1\ : STD_LOGIC;
  signal \n_0_RX_CONFIG_REG[5]_i_1\ : STD_LOGIC;
  signal \n_0_RX_CONFIG_REG[6]_i_1\ : STD_LOGIC;
  signal \n_0_RX_CONFIG_REG[7]_i_1\ : STD_LOGIC;
  signal \n_0_RX_CONFIG_REG[7]_i_2\ : STD_LOGIC;
  signal \n_0_RX_CONFIG_REG[8]_i_1\ : STD_LOGIC;
  signal \n_0_RX_CONFIG_REG[9]_i_1\ : STD_LOGIC;
  signal n_0_RX_CONFIG_REG_NULL_i_2 : STD_LOGIC;
  signal n_0_RX_CONFIG_REG_NULL_i_3 : STD_LOGIC;
  signal n_0_RX_CONFIG_REG_NULL_i_4 : STD_LOGIC;
  signal \n_0_RX_CONFIG_SNAPSHOT[15]_i_10\ : STD_LOGIC;
  signal \n_0_RX_CONFIG_SNAPSHOT[15]_i_7\ : STD_LOGIC;
  signal \n_0_RX_CONFIG_SNAPSHOT[15]_i_8\ : STD_LOGIC;
  signal \n_0_RX_CONFIG_SNAPSHOT[15]_i_9\ : STD_LOGIC;
  signal \n_0_RX_CONFIG_SNAPSHOT_reg[15]_i_5\ : STD_LOGIC;
  signal n_0_RX_CONFIG_VALID_INT_i_2 : STD_LOGIC;
  signal \n_0_RX_CONFIG_VALID_REG_reg[0]\ : STD_LOGIC;
  signal \n_0_RX_CONFIG_VALID_REG_reg[3]\ : STD_LOGIC;
  signal n_0_RX_DATA_ERROR_i_2 : STD_LOGIC;
  signal n_0_RX_DATA_ERROR_i_4 : STD_LOGIC;
  signal n_0_RX_ER_i_2 : STD_LOGIC;
  signal n_0_RX_ER_i_3 : STD_LOGIC;
  signal n_0_RX_INVALID_i_1 : STD_LOGIC;
  signal n_0_RX_INVALID_i_2 : STD_LOGIC;
  signal n_0_R_i_2 : STD_LOGIC;
  signal n_0_S_i_2 : STD_LOGIC;
  signal n_0_WAIT_FOR_K_i_1 : STD_LOGIC;
  signal n_1_CONSISTENCY_MATCH_reg_i_3 : STD_LOGIC;
  signal \n_1_RX_CONFIG_SNAPSHOT_reg[15]_i_5\ : STD_LOGIC;
  signal n_2_CONSISTENCY_MATCH_reg_i_3 : STD_LOGIC;
  signal \n_2_RX_CONFIG_SNAPSHOT_reg[15]_i_5\ : STD_LOGIC;
  signal n_3_CONSISTENCY_MATCH_reg_i_3 : STD_LOGIC;
  signal \n_3_RX_CONFIG_SNAPSHOT_reg[15]_i_5\ : STD_LOGIC;
  signal p_0_in1_in : STD_LOGIC;
  signal p_0_in2_in : STD_LOGIC;
  signal \^p_1_in\ : STD_LOGIC;
  signal p_1_in_1 : STD_LOGIC;
  signal NLW_CONSISTENCY_MATCH_reg_i_2_CO_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal NLW_CONSISTENCY_MATCH_reg_i_2_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_CONSISTENCY_MATCH_reg_i_3_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_RX_CONFIG_SNAPSHOT_reg[15]_i_2_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_RX_CONFIG_SNAPSHOT_reg[15]_i_2_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_RX_CONFIG_SNAPSHOT_reg[15]_i_5_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of C_HDR_REMOVED_REG_i_1 : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of C_i_1 : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of D0p0_REG_i_1 : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of FALSE_DATA_i_4 : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of FALSE_DATA_i_5 : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of FALSE_DATA_i_6 : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of FALSE_K_i_2 : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of FALSE_NIT_i_4 : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of FALSE_NIT_i_5 : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of FALSE_NIT_i_6 : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of FROM_IDLE_D_i_1 : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of I_i_1 : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of I_i_5 : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of I_i_6 : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of I_i_7 : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of I_i_8 : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of K28p5_REG1_i_1 : label is "soft_lutpair26";
  attribute srl_bus_name : string;
  attribute srl_bus_name of \RXDATA_REG4_reg[0]_srl4\ : label is "\U0/pcs_pma_block_i/gmii_to_sgmii_core /\gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg ";
  attribute srl_name : string;
  attribute srl_name of \RXDATA_REG4_reg[0]_srl4\ : label is "\U0/pcs_pma_block_i/gmii_to_sgmii_core /\gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg[0]_srl4 ";
  attribute srl_bus_name of \RXDATA_REG4_reg[1]_srl4\ : label is "\U0/pcs_pma_block_i/gmii_to_sgmii_core /\gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg ";
  attribute srl_name of \RXDATA_REG4_reg[1]_srl4\ : label is "\U0/pcs_pma_block_i/gmii_to_sgmii_core /\gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg[1]_srl4 ";
  attribute srl_bus_name of \RXDATA_REG4_reg[2]_srl4\ : label is "\U0/pcs_pma_block_i/gmii_to_sgmii_core /\gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg ";
  attribute srl_name of \RXDATA_REG4_reg[2]_srl4\ : label is "\U0/pcs_pma_block_i/gmii_to_sgmii_core /\gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg[2]_srl4 ";
  attribute srl_bus_name of \RXDATA_REG4_reg[3]_srl4\ : label is "\U0/pcs_pma_block_i/gmii_to_sgmii_core /\gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg ";
  attribute srl_name of \RXDATA_REG4_reg[3]_srl4\ : label is "\U0/pcs_pma_block_i/gmii_to_sgmii_core /\gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg[3]_srl4 ";
  attribute srl_bus_name of \RXDATA_REG4_reg[4]_srl4\ : label is "\U0/pcs_pma_block_i/gmii_to_sgmii_core /\gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg ";
  attribute srl_name of \RXDATA_REG4_reg[4]_srl4\ : label is "\U0/pcs_pma_block_i/gmii_to_sgmii_core /\gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg[4]_srl4 ";
  attribute srl_bus_name of \RXDATA_REG4_reg[5]_srl4\ : label is "\U0/pcs_pma_block_i/gmii_to_sgmii_core /\gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg ";
  attribute srl_name of \RXDATA_REG4_reg[5]_srl4\ : label is "\U0/pcs_pma_block_i/gmii_to_sgmii_core /\gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg[5]_srl4 ";
  attribute srl_bus_name of \RXDATA_REG4_reg[6]_srl4\ : label is "\U0/pcs_pma_block_i/gmii_to_sgmii_core /\gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg ";
  attribute srl_name of \RXDATA_REG4_reg[6]_srl4\ : label is "\U0/pcs_pma_block_i/gmii_to_sgmii_core /\gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg[6]_srl4 ";
  attribute srl_bus_name of \RXDATA_REG4_reg[7]_srl4\ : label is "\U0/pcs_pma_block_i/gmii_to_sgmii_core /\gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg ";
  attribute srl_name of \RXDATA_REG4_reg[7]_srl4\ : label is "\U0/pcs_pma_block_i/gmii_to_sgmii_core /\gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg[7]_srl4 ";
  attribute SOFT_HLUTNM of \RXD[1]_i_1\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \RXD[2]_i_1\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \RXD[3]_i_1\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \RXD[4]_i_1\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \RXD[5]_i_1\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \RXD[6]_i_1\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \RXD[7]_i_1\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \RX_CONFIG_REG[0]_i_1\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \RX_CONFIG_REG[3]_i_1\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \RX_CONFIG_REG[7]_i_2\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \RX_CONFIG_REG_REG[15]_i_1\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of RX_ER_i_3 : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of R_i_2 : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of S_i_1 : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of T_i_1 : label is "soft_lutpair25";
begin
  K28p5_REG1 <= \^k28p5_reg1\;
  O1 <= \^o1\;
  O10 <= \^o10\;
  O11 <= \^o11\;
  O12 <= \^o12\;
  O13 <= \^o13\;
  O14 <= \^o14\;
  O15 <= \^o15\;
  O16 <= \^o16\;
  O2 <= \^o2\;
  O3 <= \^o3\;
  O4 <= \^o4\;
  O5 <= \^o5\;
  O6 <= \^o6\;
  O7 <= \^o7\;
  O8 <= \^o8\;
  O9 <= \^o9\;
  RX_CONFIG_REG(0) <= \^rx_config_reg\(0);
  RX_CONFIG_VALID <= \^rx_config_valid\;
  RX_IDLE <= \^rx_idle\;
  SOP_REG3 <= \^sop_reg3\;
  p_1_in <= \^p_1_in\;
CGBAD_REG1_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => CGBAD,
      Q => CGBAD_REG1,
      R => '0'
    );
CGBAD_REG2_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => CGBAD_REG1,
      Q => CGBAD_REG2,
      R => '0'
    );
CGBAD_REG3_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => CGBAD_REG2,
      Q => CGBAD_REG3,
      R => SR(0)
    );
CGBAD_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => RXNOTINTABLE_INT,
      I1 => D,
      I2 => p_0_in,
      O => S2
    );
CGBAD_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => S2,
      Q => CGBAD,
      R => SR(0)
    );
CONSISTENCY_MATCH_i_5: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => \^o9\,
      I1 => I9(10),
      I2 => \^o4\,
      I3 => I9(11),
      I4 => I9(9),
      I5 => \^o8\,
      O => n_0_CONSISTENCY_MATCH_i_5
    );
CONSISTENCY_MATCH_i_6: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => \^o10\,
      I1 => I9(7),
      I2 => \^o11\,
      I3 => I9(8),
      I4 => I9(6),
      I5 => \^o6\,
      O => n_0_CONSISTENCY_MATCH_i_6
    );
CONSISTENCY_MATCH_i_7: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => \^o13\,
      I1 => I9(4),
      I2 => \^o7\,
      I3 => I9(5),
      I4 => I9(3),
      I5 => \^o12\,
      O => n_0_CONSISTENCY_MATCH_i_7
    );
CONSISTENCY_MATCH_i_8: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => \^o15\,
      I1 => I9(2),
      I2 => \^o16\,
      I3 => I9(0),
      I4 => I9(1),
      I5 => \^o14\,
      O => n_0_CONSISTENCY_MATCH_i_8
    );
CONSISTENCY_MATCH_reg_i_2: unisim.vcomponents.CARRY4
    port map (
      CI => n_0_CONSISTENCY_MATCH_reg_i_3,
      CO(3 downto 1) => NLW_CONSISTENCY_MATCH_reg_i_2_CO_UNCONNECTED(3 downto 1),
      CO(0) => I6(0),
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '0',
      O(3 downto 0) => NLW_CONSISTENCY_MATCH_reg_i_2_O_UNCONNECTED(3 downto 0),
      S(3) => '0',
      S(2) => '0',
      S(1) => '0',
      S(0) => I4(0)
    );
CONSISTENCY_MATCH_reg_i_3: unisim.vcomponents.CARRY4
    port map (
      CI => '0',
      CO(3) => n_0_CONSISTENCY_MATCH_reg_i_3,
      CO(2) => n_1_CONSISTENCY_MATCH_reg_i_3,
      CO(1) => n_2_CONSISTENCY_MATCH_reg_i_3,
      CO(0) => n_3_CONSISTENCY_MATCH_reg_i_3,
      CYINIT => '1',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '0',
      O(3 downto 0) => NLW_CONSISTENCY_MATCH_reg_i_3_O_UNCONNECTED(3 downto 0),
      S(3) => n_0_CONSISTENCY_MATCH_i_5,
      S(2) => n_0_CONSISTENCY_MATCH_i_6,
      S(1) => n_0_CONSISTENCY_MATCH_i_7,
      S(0) => n_0_CONSISTENCY_MATCH_i_8
    );
C_HDR_REMOVED_REG_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      I0 => I11(2),
      I1 => I11(1),
      I2 => I11(0),
      I3 => C_REG2,
      O => C_HDR_REMOVED
    );
C_HDR_REMOVED_REG_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => C_HDR_REMOVED,
      Q => C_HDR_REMOVED_REG,
      R => '0'
    );
C_REG1_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => C,
      Q => C_REG1,
      R => '0'
    );
C_REG2_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => C_REG1,
      Q => C_REG2,
      R => '0'
    );
C_REG3_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => C_REG2,
      Q => C_REG3,
      R => '0'
    );
C_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \^k28p5_reg1\,
      I1 => n_0_I_i_2,
      O => C0
    );
C_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => C0,
      Q => C,
      R => '0'
    );
D0p0_REG_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => Q(0),
      I1 => Q(1),
      I2 => Q(7),
      I3 => n_0_D0p0_REG_i_2,
      O => D0p0
    );
D0p0_REG_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
    port map (
      I0 => Q(2),
      I1 => Q(3),
      I2 => Q(4),
      I3 => Q(5),
      I4 => Q(6),
      I5 => I1,
      O => n_0_D0p0_REG_i_2
    );
D0p0_REG_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => D0p0,
      Q => D0p0_REG,
      R => '0'
    );
EOP_REG1_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => EOP,
      I1 => n_0_EXTEND_reg,
      I2 => EXTEND_REG1,
      O => EOP_REG10
    );
EOP_REG1_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => EOP_REG10,
      Q => EOP_REG1,
      R => SR(0)
    );
EOP_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF88888000"
    )
    port map (
      I0 => T_REG2,
      I1 => R_REG1,
      I2 => RXEVEN,
      I3 => \^k28p5_reg1\,
      I4 => R,
      I5 => n_0_EOP_i_2,
      O => EOP0
    );
EOP_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F8888888"
    )
    port map (
      I0 => \^rx_idle\,
      I1 => \^k28p5_reg1\,
      I2 => RXEVEN,
      I3 => D0p0_REG,
      I4 => C_REG1,
      O => n_0_EOP_i_2
    );
EOP_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => EOP0,
      Q => EOP,
      R => SR(0)
    );
EXTEND_ERR_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => EXT_ILLEGAL_K_REG2,
      I1 => CGBAD_REG3,
      I2 => EXTEND_REG3,
      O => EXTEND_ERR0
    );
EXTEND_ERR_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => EXTEND_ERR0,
      Q => EXTEND_ERR,
      R => SYNC_STATUS_REG0
    );
EXTEND_REG1_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => n_0_EXTEND_reg,
      Q => EXTEND_REG1,
      R => '0'
    );
EXTEND_REG2_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => EXTEND_REG1,
      Q => EXTEND_REG2,
      R => '0'
    );
EXTEND_REG3_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => EXTEND_REG2,
      Q => EXTEND_REG3,
      R => '0'
    );
EXTEND_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AA00AA2AAA00AA00"
    )
    port map (
      I0 => I12,
      I1 => RXEVEN,
      I2 => \^k28p5_reg1\,
      I3 => n_0_EXTEND_i_3,
      I4 => S_0,
      I5 => n_0_EXTEND_reg,
      O => n_0_EXTEND_i_1
    );
EXTEND_i_3: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => R,
      I1 => \^o1\,
      I2 => R_REG1,
      O => n_0_EXTEND_i_3
    );
EXTEND_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => n_0_EXTEND_i_1,
      Q => n_0_EXTEND_reg,
      R => '0'
    );
EXT_ILLEGAL_K_REG1_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => EXT_ILLEGAL_K,
      Q => EXT_ILLEGAL_K_REG1,
      R => SYNC_STATUS_REG0
    );
EXT_ILLEGAL_K_REG2_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => EXT_ILLEGAL_K_REG1,
      Q => EXT_ILLEGAL_K_REG2,
      R => SYNC_STATUS_REG0
    );
EXT_ILLEGAL_K_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000700"
    )
    port map (
      I0 => RXEVEN,
      I1 => \^k28p5_reg1\,
      I2 => R,
      I3 => EXTEND_REG1,
      I4 => S_0,
      O => EXT_ILLEGAL_K0
    );
EXT_ILLEGAL_K_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => EXT_ILLEGAL_K0,
      Q => EXT_ILLEGAL_K,
      R => SYNC_STATUS_REG0
    );
FALSE_CARRIER_REG1_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => FALSE_CARRIER,
      Q => FALSE_CARRIER_REG1,
      R => '0'
    );
FALSE_CARRIER_REG2_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => FALSE_CARRIER_REG1,
      Q => FALSE_CARRIER_REG2,
      R => '0'
    );
FALSE_CARRIER_REG3_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => FALSE_CARRIER_REG2,
      Q => FALSE_CARRIER_REG3,
      R => SYNC_STATUS_REG0
    );
FALSE_CARRIER_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0A0E0E0E0A0A0A0A"
    )
    port map (
      I0 => n_0_FALSE_CARRIER_i_2,
      I1 => RXSYNC_STATUS,
      I2 => SR(0),
      I3 => RXEVEN,
      I4 => \^k28p5_reg1\,
      I5 => FALSE_CARRIER,
      O => n_0_FALSE_CARRIER_i_1
    );
FALSE_CARRIER_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000020"
    )
    port map (
      I0 => I5,
      I1 => S_0,
      I2 => \^rx_idle\,
      I3 => \^k28p5_reg1\,
      I4 => n_0_FALSE_CARRIER_i_3,
      O => n_0_FALSE_CARRIER_i_2
    );
FALSE_CARRIER_i_3: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => FALSE_DATA,
      I1 => FALSE_K,
      I2 => FALSE_NIT,
      O => n_0_FALSE_CARRIER_i_3
    );
FALSE_CARRIER_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => n_0_FALSE_CARRIER_i_1,
      Q => FALSE_CARRIER,
      R => '0'
    );
FALSE_DATA_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"000E"
    )
    port map (
      I0 => n_0_FALSE_DATA_i_2,
      I1 => n_0_FALSE_DATA_i_3,
      I2 => RXNOTINTABLE_INT,
      I3 => I1,
      O => FALSE_DATA0
    );
FALSE_DATA_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000004040C0"
    )
    port map (
      I0 => Q(4),
      I1 => Q(1),
      I2 => Q(0),
      I3 => Q(3),
      I4 => Q(2),
      I5 => n_0_FALSE_DATA_i_4,
      O => n_0_FALSE_DATA_i_2
    );
FALSE_DATA_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4000000000000040"
    )
    port map (
      I0 => n_0_FALSE_DATA_i_5,
      I1 => Q(2),
      I2 => Q(7),
      I3 => n_0_FALSE_DATA_i_6,
      I4 => Q(1),
      I5 => Q(0),
      O => n_0_FALSE_DATA_i_3
    );
FALSE_DATA_i_4: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FB"
    )
    port map (
      I0 => Q(7),
      I1 => Q(6),
      I2 => Q(5),
      O => n_0_FALSE_DATA_i_4
    );
FALSE_DATA_i_5: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => Q(6),
      I1 => Q(5),
      O => n_0_FALSE_DATA_i_5
    );
FALSE_DATA_i_6: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => Q(4),
      I1 => Q(3),
      O => n_0_FALSE_DATA_i_6
    );
FALSE_DATA_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => FALSE_DATA0,
      Q => FALSE_DATA,
      R => SR(0)
    );
FALSE_K_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000040000040"
    )
    port map (
      I0 => n_0_FALSE_K_i_2,
      I1 => Q(7),
      I2 => Q(4),
      I3 => Q(5),
      I4 => Q(6),
      I5 => RXNOTINTABLE_INT,
      O => FALSE_K0
    );
FALSE_K_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EFFFFFFF"
    )
    port map (
      I0 => Q(1),
      I1 => Q(0),
      I2 => I1,
      I3 => Q(2),
      I4 => Q(3),
      O => n_0_FALSE_K_i_2
    );
FALSE_K_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => FALSE_K0,
      Q => FALSE_K,
      R => SR(0)
    );
FALSE_NIT_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000A02A2A0AA02A2"
    )
    port map (
      I0 => RXNOTINTABLE_INT,
      I1 => n_0_FALSE_NIT_i_2,
      I2 => Q(7),
      I3 => n_0_FALSE_NIT_i_3,
      I4 => D,
      I5 => n_0_FALSE_NIT_i_4,
      O => FALSE_NIT0
    );
FALSE_NIT_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFF7F7FFF"
    )
    port map (
      I0 => I1,
      I1 => Q(2),
      I2 => Q(3),
      I3 => Q(0),
      I4 => Q(1),
      I5 => n_0_FALSE_NIT_i_5,
      O => n_0_FALSE_NIT_i_2
    );
FALSE_NIT_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BFFF0000BFFFBFFF"
    )
    port map (
      I0 => n_0_FALSE_K_i_2,
      I1 => Q(6),
      I2 => Q(5),
      I3 => Q(4),
      I4 => n_0_D0p0_REG_i_2,
      I5 => n_0_FALSE_NIT_i_6,
      O => n_0_FALSE_NIT_i_3
    );
FALSE_NIT_i_4: unisim.vcomponents.LUT3
    generic map(
      INIT => X"EB"
    )
    port map (
      I0 => n_0_D0p0_REG_i_2,
      I1 => Q(1),
      I2 => Q(0),
      O => n_0_FALSE_NIT_i_4
    );
FALSE_NIT_i_5: unisim.vcomponents.LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => Q(6),
      I1 => Q(5),
      I2 => Q(4),
      O => n_0_FALSE_NIT_i_5
    );
FALSE_NIT_i_6: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => Q(0),
      I1 => Q(1),
      O => n_0_FALSE_NIT_i_6
    );
FALSE_NIT_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => FALSE_NIT0,
      Q => FALSE_NIT,
      R => SR(0)
    );
FROM_IDLE_D_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0004"
    )
    port map (
      I0 => \^k28p5_reg1\,
      I1 => \^rx_idle\,
      I2 => WAIT_FOR_K,
      I3 => I5,
      O => FROM_IDLE_D0
    );
FROM_IDLE_D_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => FROM_IDLE_D0,
      Q => FROM_IDLE_D,
      R => SYNC_STATUS_REG0
    );
FROM_RX_CX_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFA8FFFCFCA8A8"
    )
    port map (
      I0 => RXCHARISK_REG1,
      I1 => C_REG1,
      I2 => C_REG2,
      I3 => I10,
      I4 => CGBAD,
      I5 => C_REG3,
      O => FROM_RX_CX0
    );
FROM_RX_CX_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => FROM_RX_CX0,
      Q => FROM_RX_CX,
      R => SYNC_STATUS_REG0
    );
FROM_RX_K_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00E0"
    )
    port map (
      I0 => RXCHARISK_REG1,
      I1 => CGBAD,
      I2 => K28p5_REG2,
      I3 => I5,
      O => FROM_RX_K0
    );
FROM_RX_K_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => FROM_RX_K0,
      Q => FROM_RX_K,
      R => SYNC_STATUS_REG0
    );
\IDLE_REG_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \^rx_idle\,
      Q => \n_0_IDLE_REG_reg[0]\,
      R => SR(0)
    );
\IDLE_REG_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_IDLE_REG_reg[0]\,
      Q => p_0_in1_in,
      R => SR(0)
    );
\IDLE_REG_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => p_0_in1_in,
      Q => \n_0_IDLE_REG_reg[2]\,
      R => SR(0)
    );
ILLEGAL_K_REG1_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => ILLEGAL_K,
      Q => ILLEGAL_K_REG1,
      R => SYNC_STATUS_REG0
    );
ILLEGAL_K_REG2_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => ILLEGAL_K_REG1,
      Q => ILLEGAL_K_REG2,
      R => SYNC_STATUS_REG0
    );
ILLEGAL_K_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0010"
    )
    port map (
      I0 => R,
      I1 => \^k28p5_reg1\,
      I2 => RXCHARISK_REG1,
      I3 => T,
      O => ILLEGAL_K0
    );
ILLEGAL_K_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => ILLEGAL_K0,
      Q => ILLEGAL_K,
      R => SYNC_STATUS_REG0
    );
I_REG_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => I,
      Q => \^rx_idle\,
      R => '0'
    );
I_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"22220020"
    )
    port map (
      I0 => n_0_I_i_2,
      I1 => n_0_I_i_3,
      I2 => \^k28p5_reg1\,
      I3 => I1,
      I4 => I5,
      O => I0
    );
I_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FBFBFBAA"
    )
    port map (
      I0 => I1,
      I1 => n_0_I_i_5,
      I2 => n_0_I_i_6,
      I3 => n_0_I_i_7,
      I4 => n_0_I_i_8,
      O => n_0_I_i_2
    );
I_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000001FFFFFFFFFF"
    )
    port map (
      I0 => FALSE_DATA,
      I1 => FALSE_K,
      I2 => FALSE_NIT,
      I3 => \^rx_idle\,
      I4 => \^k28p5_reg1\,
      I5 => RXEVEN,
      O => n_0_I_i_3
    );
I_i_5: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => Q(2),
      I1 => Q(0),
      I2 => Q(1),
      O => n_0_I_i_5
    );
I_i_6: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFDFFF"
    )
    port map (
      I0 => Q(5),
      I1 => Q(6),
      I2 => Q(7),
      I3 => Q(4),
      I4 => Q(3),
      O => n_0_I_i_6
    );
I_i_7: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => Q(4),
      I1 => Q(3),
      I2 => Q(2),
      O => n_0_I_i_7
    );
I_i_8: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFBFF"
    )
    port map (
      I0 => Q(5),
      I1 => Q(6),
      I2 => Q(7),
      I3 => Q(1),
      I4 => Q(0),
      O => n_0_I_i_8
    );
I_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => I0,
      Q => I,
      R => '0'
    );
K28p5_REG1_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"02000000"
    )
    port map (
      I0 => Q(5),
      I1 => Q(6),
      I2 => n_0_FALSE_K_i_2,
      I3 => Q(7),
      I4 => Q(4),
      O => K28p5
    );
K28p5_REG1_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => K28p5,
      Q => \^k28p5_reg1\,
      R => '0'
    );
K28p5_REG2_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \^k28p5_reg1\,
      Q => K28p5_REG2,
      R => '0'
    );
MASK_RUDI_CLKCOR_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAAABABB"
    )
    port map (
      I0 => \^o2\,
      I1 => XMIT_DATA_INT,
      I2 => I7(3),
      I3 => I7(0),
      I4 => RXSYNC_STATUS,
      O => RX_RUDI_INVALID
    );
RECEIVED_IDLE_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0D0C"
    )
    port map (
      I0 => \^rx_config_valid\,
      I1 => \^rx_idle\,
      I2 => I3,
      I3 => I14,
      O => O17
    );
RECEIVE_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"44044400"
    )
    port map (
      I0 => SR(0),
      I1 => RXSYNC_STATUS,
      I2 => EOP,
      I3 => SOP_REG2,
      I4 => \^o1\,
      O => n_0_RECEIVE_i_1
    );
RECEIVE_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => n_0_RECEIVE_i_1,
      Q => \^o1\,
      R => '0'
    );
RUDI_C_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => p_1_in_1,
      I1 => \n_0_RX_CONFIG_VALID_REG_reg[0]\,
      I2 => \n_0_RX_CONFIG_VALID_REG_reg[3]\,
      I3 => p_0_in2_in,
      O => RUDI_C0
    );
RUDI_C_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => RUDI_C0,
      Q => status_vector(0),
      R => SR(0)
    );
RUDI_I_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \n_0_IDLE_REG_reg[2]\,
      I1 => p_0_in1_in,
      O => RUDI_I0
    );
RUDI_I_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => RUDI_I0,
      Q => status_vector(1),
      R => SR(0)
    );
RXCHARISK_REG1_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => I1,
      Q => RXCHARISK_REG1,
      R => '0'
    );
\RXDATA_REG4_reg[0]_srl4\: unisim.vcomponents.SRL16E
    port map (
      A0 => '1',
      A1 => '1',
      A2 => '0',
      A3 => '0',
      CE => '1',
      CLK => userclk2,
      D => Q(0),
      Q => \n_0_RXDATA_REG4_reg[0]_srl4\
    );
\RXDATA_REG4_reg[1]_srl4\: unisim.vcomponents.SRL16E
    port map (
      A0 => '1',
      A1 => '1',
      A2 => '0',
      A3 => '0',
      CE => '1',
      CLK => userclk2,
      D => Q(1),
      Q => \n_0_RXDATA_REG4_reg[1]_srl4\
    );
\RXDATA_REG4_reg[2]_srl4\: unisim.vcomponents.SRL16E
    port map (
      A0 => '1',
      A1 => '1',
      A2 => '0',
      A3 => '0',
      CE => '1',
      CLK => userclk2,
      D => Q(2),
      Q => \n_0_RXDATA_REG4_reg[2]_srl4\
    );
\RXDATA_REG4_reg[3]_srl4\: unisim.vcomponents.SRL16E
    port map (
      A0 => '1',
      A1 => '1',
      A2 => '0',
      A3 => '0',
      CE => '1',
      CLK => userclk2,
      D => Q(3),
      Q => \n_0_RXDATA_REG4_reg[3]_srl4\
    );
\RXDATA_REG4_reg[4]_srl4\: unisim.vcomponents.SRL16E
    port map (
      A0 => '1',
      A1 => '1',
      A2 => '0',
      A3 => '0',
      CE => '1',
      CLK => userclk2,
      D => Q(4),
      Q => \n_0_RXDATA_REG4_reg[4]_srl4\
    );
\RXDATA_REG4_reg[5]_srl4\: unisim.vcomponents.SRL16E
    port map (
      A0 => '1',
      A1 => '1',
      A2 => '0',
      A3 => '0',
      CE => '1',
      CLK => userclk2,
      D => Q(5),
      Q => \n_0_RXDATA_REG4_reg[5]_srl4\
    );
\RXDATA_REG4_reg[6]_srl4\: unisim.vcomponents.SRL16E
    port map (
      A0 => '1',
      A1 => '1',
      A2 => '0',
      A3 => '0',
      CE => '1',
      CLK => userclk2,
      D => Q(6),
      Q => \n_0_RXDATA_REG4_reg[6]_srl4\
    );
\RXDATA_REG4_reg[7]_srl4\: unisim.vcomponents.SRL16E
    port map (
      A0 => '1',
      A1 => '1',
      A2 => '0',
      A3 => '0',
      CE => '1',
      CLK => userclk2,
      D => Q(7),
      Q => \n_0_RXDATA_REG4_reg[7]_srl4\
    );
\RXDATA_REG5_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_RXDATA_REG4_reg[0]_srl4\,
      Q => RXDATA_REG5(0),
      R => '0'
    );
\RXDATA_REG5_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_RXDATA_REG4_reg[1]_srl4\,
      Q => RXDATA_REG5(1),
      R => '0'
    );
\RXDATA_REG5_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_RXDATA_REG4_reg[2]_srl4\,
      Q => RXDATA_REG5(2),
      R => '0'
    );
\RXDATA_REG5_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_RXDATA_REG4_reg[3]_srl4\,
      Q => RXDATA_REG5(3),
      R => '0'
    );
\RXDATA_REG5_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_RXDATA_REG4_reg[4]_srl4\,
      Q => RXDATA_REG5(4),
      R => '0'
    );
\RXDATA_REG5_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_RXDATA_REG4_reg[5]_srl4\,
      Q => RXDATA_REG5(5),
      R => '0'
    );
\RXDATA_REG5_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_RXDATA_REG4_reg[6]_srl4\,
      Q => RXDATA_REG5(6),
      R => '0'
    );
\RXDATA_REG5_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_RXDATA_REG4_reg[7]_srl4\,
      Q => RXDATA_REG5(7),
      R => '0'
    );
\RXD[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BBBA"
    )
    port map (
      I0 => \^sop_reg3\,
      I1 => FALSE_CARRIER_REG3,
      I2 => EXTEND_REG1,
      I3 => RXDATA_REG5(0),
      O => \n_0_RXD[0]_i_1\
    );
\RXD[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"5554"
    )
    port map (
      I0 => \^sop_reg3\,
      I1 => RXDATA_REG5(1),
      I2 => FALSE_CARRIER_REG3,
      I3 => EXTEND_REG1,
      O => \n_0_RXD[1]_i_1\
    );
\RXD[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => EXTEND_REG1,
      I1 => FALSE_CARRIER_REG3,
      I2 => RXDATA_REG5(2),
      I3 => \^sop_reg3\,
      O => \n_0_RXD[2]_i_1\
    );
\RXD[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"5554"
    )
    port map (
      I0 => \^sop_reg3\,
      I1 => RXDATA_REG5(3),
      I2 => FALSE_CARRIER_REG3,
      I3 => EXTEND_REG1,
      O => \n_0_RXD[3]_i_1\
    );
\RXD[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BABBBAAA"
    )
    port map (
      I0 => \^sop_reg3\,
      I1 => FALSE_CARRIER_REG3,
      I2 => EXTEND_ERR,
      I3 => EXTEND_REG1,
      I4 => RXDATA_REG5(4),
      O => \n_0_RXD[4]_i_1\
    );
\RXD[5]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0010"
    )
    port map (
      I0 => EXTEND_REG1,
      I1 => FALSE_CARRIER_REG3,
      I2 => RXDATA_REG5(5),
      I3 => \^sop_reg3\,
      O => \n_0_RXD[5]_i_1\
    );
\RXD[6]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"ABAA"
    )
    port map (
      I0 => \^sop_reg3\,
      I1 => FALSE_CARRIER_REG3,
      I2 => EXTEND_REG1,
      I3 => RXDATA_REG5(6),
      O => \n_0_RXD[6]_i_1\
    );
\RXD[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0010"
    )
    port map (
      I0 => EXTEND_REG1,
      I1 => FALSE_CARRIER_REG3,
      I2 => RXDATA_REG5(7),
      I3 => \^sop_reg3\,
      O => \n_0_RXD[7]_i_1\
    );
\RXD_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_RXD[0]_i_1\,
      Q => gmii_rxd(0),
      R => I7(2)
    );
\RXD_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_RXD[1]_i_1\,
      Q => gmii_rxd(1),
      R => I7(2)
    );
\RXD_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_RXD[2]_i_1\,
      Q => gmii_rxd(2),
      R => I7(2)
    );
\RXD_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_RXD[3]_i_1\,
      Q => gmii_rxd(3),
      R => I7(2)
    );
\RXD_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_RXD[4]_i_1\,
      Q => gmii_rxd(4),
      R => I7(2)
    );
\RXD_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_RXD[5]_i_1\,
      Q => gmii_rxd(5),
      R => I7(2)
    );
\RXD_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_RXD[6]_i_1\,
      Q => gmii_rxd(6),
      R => I7(2)
    );
\RXD_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_RXD[7]_i_1\,
      Q => gmii_rxd(7),
      R => I7(2)
    );
\RX_CONFIG_REG[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
    port map (
      I0 => Q(0),
      I1 => I1,
      I2 => \n_0_RX_CONFIG_REG[7]_i_2\,
      I3 => \^o16\,
      O => \n_0_RX_CONFIG_REG[0]_i_1\
    );
\RX_CONFIG_REG[10]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFEEEF00002220"
    )
    port map (
      I0 => Q(2),
      I1 => RXCHARISK_REG1,
      I2 => C_REG1,
      I3 => C_HDR_REMOVED_REG,
      I4 => I1,
      I5 => \^o9\,
      O => \n_0_RX_CONFIG_REG[10]_i_1\
    );
\RX_CONFIG_REG[11]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFEEEF00002220"
    )
    port map (
      I0 => Q(3),
      I1 => RXCHARISK_REG1,
      I2 => C_REG1,
      I3 => C_HDR_REMOVED_REG,
      I4 => I1,
      I5 => \^o4\,
      O => \n_0_RX_CONFIG_REG[11]_i_1\
    );
\RX_CONFIG_REG[12]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFEEEF00002220"
    )
    port map (
      I0 => Q(4),
      I1 => RXCHARISK_REG1,
      I2 => C_REG1,
      I3 => C_HDR_REMOVED_REG,
      I4 => I1,
      I5 => \^o3\,
      O => \n_0_RX_CONFIG_REG[12]_i_1\
    );
\RX_CONFIG_REG[13]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFEEEF00002220"
    )
    port map (
      I0 => Q(5),
      I1 => RXCHARISK_REG1,
      I2 => C_REG1,
      I3 => C_HDR_REMOVED_REG,
      I4 => I1,
      I5 => \^o5\,
      O => \n_0_RX_CONFIG_REG[13]_i_1\
    );
\RX_CONFIG_REG[14]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFEEEF00002220"
    )
    port map (
      I0 => Q(6),
      I1 => RXCHARISK_REG1,
      I2 => C_REG1,
      I3 => C_HDR_REMOVED_REG,
      I4 => I1,
      I5 => \^rx_config_reg\(0),
      O => \n_0_RX_CONFIG_REG[14]_i_1\
    );
\RX_CONFIG_REG[15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFEEEF00002220"
    )
    port map (
      I0 => Q(7),
      I1 => RXCHARISK_REG1,
      I2 => C_REG1,
      I3 => C_HDR_REMOVED_REG,
      I4 => I1,
      I5 => \^p_1_in\,
      O => \n_0_RX_CONFIG_REG[15]_i_1\
    );
\RX_CONFIG_REG[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
    port map (
      I0 => Q(1),
      I1 => I1,
      I2 => \n_0_RX_CONFIG_REG[7]_i_2\,
      I3 => \^o14\,
      O => \n_0_RX_CONFIG_REG[1]_i_1\
    );
\RX_CONFIG_REG[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
    port map (
      I0 => Q(2),
      I1 => I1,
      I2 => \n_0_RX_CONFIG_REG[7]_i_2\,
      I3 => \^o15\,
      O => \n_0_RX_CONFIG_REG[2]_i_1\
    );
\RX_CONFIG_REG[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
    port map (
      I0 => Q(3),
      I1 => I1,
      I2 => \n_0_RX_CONFIG_REG[7]_i_2\,
      I3 => \^o12\,
      O => \n_0_RX_CONFIG_REG[3]_i_1\
    );
\RX_CONFIG_REG[4]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
    port map (
      I0 => Q(4),
      I1 => I1,
      I2 => \n_0_RX_CONFIG_REG[7]_i_2\,
      I3 => \^o13\,
      O => \n_0_RX_CONFIG_REG[4]_i_1\
    );
\RX_CONFIG_REG[5]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
    port map (
      I0 => Q(5),
      I1 => I1,
      I2 => \n_0_RX_CONFIG_REG[7]_i_2\,
      I3 => \^o7\,
      O => \n_0_RX_CONFIG_REG[5]_i_1\
    );
\RX_CONFIG_REG[6]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
    port map (
      I0 => Q(6),
      I1 => I1,
      I2 => \n_0_RX_CONFIG_REG[7]_i_2\,
      I3 => \^o6\,
      O => \n_0_RX_CONFIG_REG[6]_i_1\
    );
\RX_CONFIG_REG[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
    port map (
      I0 => Q(7),
      I1 => I1,
      I2 => \n_0_RX_CONFIG_REG[7]_i_2\,
      I3 => \^o10\,
      O => \n_0_RX_CONFIG_REG[7]_i_1\
    );
\RX_CONFIG_REG[7]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"55555515"
    )
    port map (
      I0 => C,
      I1 => C_REG2,
      I2 => I11(0),
      I3 => I11(1),
      I4 => I11(2),
      O => \n_0_RX_CONFIG_REG[7]_i_2\
    );
\RX_CONFIG_REG[8]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFEEEF00002220"
    )
    port map (
      I0 => Q(0),
      I1 => RXCHARISK_REG1,
      I2 => C_REG1,
      I3 => C_HDR_REMOVED_REG,
      I4 => I1,
      I5 => \^o11\,
      O => \n_0_RX_CONFIG_REG[8]_i_1\
    );
\RX_CONFIG_REG[9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFEEEF00002220"
    )
    port map (
      I0 => Q(1),
      I1 => RXCHARISK_REG1,
      I2 => C_REG1,
      I3 => C_HDR_REMOVED_REG,
      I4 => I1,
      I5 => \^o8\,
      O => \n_0_RX_CONFIG_REG[9]_i_1\
    );
RX_CONFIG_REG_NULL_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"808080FF80808000"
    )
    port map (
      I0 => n_0_RX_CONFIG_REG_NULL_i_2,
      I1 => n_0_RX_CONFIG_REG_NULL_i_3,
      I2 => n_0_RX_CONFIG_REG_NULL_i_4,
      I3 => I3,
      I4 => \^rx_config_valid\,
      I5 => I15,
      O => O18
    );
RX_CONFIG_REG_NULL_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
    port map (
      I0 => \^o12\,
      I1 => \^o13\,
      I2 => \^o14\,
      I3 => \^o15\,
      I4 => \^o16\,
      O => n_0_RX_CONFIG_REG_NULL_i_2
    );
RX_CONFIG_REG_NULL_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => \^o3\,
      I1 => \^o4\,
      I2 => \^p_1_in\,
      I3 => I3,
      I4 => \^o5\,
      I5 => \^rx_config_reg\(0),
      O => n_0_RX_CONFIG_REG_NULL_i_3
    );
RX_CONFIG_REG_NULL_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => \^o6\,
      I1 => \^o7\,
      I2 => \^o8\,
      I3 => \^o9\,
      I4 => \^o10\,
      I5 => \^o11\,
      O => n_0_RX_CONFIG_REG_NULL_i_4
    );
\RX_CONFIG_REG_REG[15]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => I3,
      I1 => \^rx_idle\,
      O => I13(0)
    );
\RX_CONFIG_REG_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_RX_CONFIG_REG[0]_i_1\,
      Q => \^o16\,
      R => '0'
    );
\RX_CONFIG_REG_reg[10]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_RX_CONFIG_REG[10]_i_1\,
      Q => \^o9\,
      R => '0'
    );
\RX_CONFIG_REG_reg[11]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_RX_CONFIG_REG[11]_i_1\,
      Q => \^o4\,
      R => '0'
    );
\RX_CONFIG_REG_reg[12]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_RX_CONFIG_REG[12]_i_1\,
      Q => \^o3\,
      R => '0'
    );
\RX_CONFIG_REG_reg[13]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_RX_CONFIG_REG[13]_i_1\,
      Q => \^o5\,
      R => '0'
    );
\RX_CONFIG_REG_reg[14]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_RX_CONFIG_REG[14]_i_1\,
      Q => \^rx_config_reg\(0),
      R => '0'
    );
\RX_CONFIG_REG_reg[15]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_RX_CONFIG_REG[15]_i_1\,
      Q => \^p_1_in\,
      R => '0'
    );
\RX_CONFIG_REG_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_RX_CONFIG_REG[1]_i_1\,
      Q => \^o14\,
      R => '0'
    );
\RX_CONFIG_REG_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_RX_CONFIG_REG[2]_i_1\,
      Q => \^o15\,
      R => '0'
    );
\RX_CONFIG_REG_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_RX_CONFIG_REG[3]_i_1\,
      Q => \^o12\,
      R => '0'
    );
\RX_CONFIG_REG_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_RX_CONFIG_REG[4]_i_1\,
      Q => \^o13\,
      R => '0'
    );
\RX_CONFIG_REG_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_RX_CONFIG_REG[5]_i_1\,
      Q => \^o7\,
      R => '0'
    );
\RX_CONFIG_REG_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_RX_CONFIG_REG[6]_i_1\,
      Q => \^o6\,
      R => '0'
    );
\RX_CONFIG_REG_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_RX_CONFIG_REG[7]_i_1\,
      Q => \^o10\,
      R => '0'
    );
\RX_CONFIG_REG_reg[8]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_RX_CONFIG_REG[8]_i_1\,
      Q => \^o11\,
      R => '0'
    );
\RX_CONFIG_REG_reg[9]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_RX_CONFIG_REG[9]_i_1\,
      Q => \^o8\,
      R => '0'
    );
\RX_CONFIG_SNAPSHOT[15]_i_10\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => \^o14\,
      I1 => I8(1),
      I2 => \^o15\,
      I3 => I8(2),
      I4 => I8(0),
      I5 => \^o16\,
      O => \n_0_RX_CONFIG_SNAPSHOT[15]_i_10\
    );
\RX_CONFIG_SNAPSHOT[15]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => \^o4\,
      I1 => I8(11),
      I2 => \^o8\,
      I3 => I8(9),
      I4 => I8(10),
      I5 => \^o9\,
      O => \n_0_RX_CONFIG_SNAPSHOT[15]_i_7\
    );
\RX_CONFIG_SNAPSHOT[15]_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => \^o6\,
      I1 => I8(6),
      I2 => \^o10\,
      I3 => I8(7),
      I4 => I8(8),
      I5 => \^o11\,
      O => \n_0_RX_CONFIG_SNAPSHOT[15]_i_8\
    );
\RX_CONFIG_SNAPSHOT[15]_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => \^o12\,
      I1 => I8(3),
      I2 => \^o13\,
      I3 => I8(4),
      I4 => I8(5),
      I5 => \^o7\,
      O => \n_0_RX_CONFIG_SNAPSHOT[15]_i_9\
    );
\RX_CONFIG_SNAPSHOT_reg[15]_i_2\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_RX_CONFIG_SNAPSHOT_reg[15]_i_5\,
      CO(3 downto 1) => \NLW_RX_CONFIG_SNAPSHOT_reg[15]_i_2_CO_UNCONNECTED\(3 downto 1),
      CO(0) => CO(0),
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '0',
      O(3 downto 0) => \NLW_RX_CONFIG_SNAPSHOT_reg[15]_i_2_O_UNCONNECTED\(3 downto 0),
      S(3) => '0',
      S(2) => '0',
      S(1) => '0',
      S(0) => S(0)
    );
\RX_CONFIG_SNAPSHOT_reg[15]_i_5\: unisim.vcomponents.CARRY4
    port map (
      CI => '0',
      CO(3) => \n_0_RX_CONFIG_SNAPSHOT_reg[15]_i_5\,
      CO(2) => \n_1_RX_CONFIG_SNAPSHOT_reg[15]_i_5\,
      CO(1) => \n_2_RX_CONFIG_SNAPSHOT_reg[15]_i_5\,
      CO(0) => \n_3_RX_CONFIG_SNAPSHOT_reg[15]_i_5\,
      CYINIT => '1',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '0',
      O(3 downto 0) => \NLW_RX_CONFIG_SNAPSHOT_reg[15]_i_5_O_UNCONNECTED\(3 downto 0),
      S(3) => \n_0_RX_CONFIG_SNAPSHOT[15]_i_7\,
      S(2) => \n_0_RX_CONFIG_SNAPSHOT[15]_i_8\,
      S(1) => \n_0_RX_CONFIG_SNAPSHOT[15]_i_9\,
      S(0) => \n_0_RX_CONFIG_SNAPSHOT[15]_i_10\
    );
RX_CONFIG_VALID_INT_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000004"
    )
    port map (
      I0 => S2,
      I1 => RXSYNC_STATUS,
      I2 => CGBAD,
      I3 => RXCHARISK_REG1,
      I4 => n_0_RX_CONFIG_VALID_INT_i_2,
      O => RX_CONFIG_VALID_INT0
    );
RX_CONFIG_VALID_INT_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AB"
    )
    port map (
      I0 => I1,
      I1 => C_HDR_REMOVED_REG,
      I2 => C_REG1,
      O => n_0_RX_CONFIG_VALID_INT_i_2
    );
RX_CONFIG_VALID_INT_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => RX_CONFIG_VALID_INT0,
      Q => \^rx_config_valid\,
      R => SR(0)
    );
\RX_CONFIG_VALID_REG_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \^rx_config_valid\,
      Q => \n_0_RX_CONFIG_VALID_REG_reg[0]\,
      R => SR(0)
    );
\RX_CONFIG_VALID_REG_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_RX_CONFIG_VALID_REG_reg[0]\,
      Q => p_0_in2_in,
      R => SR(0)
    );
\RX_CONFIG_VALID_REG_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => p_0_in2_in,
      Q => p_1_in_1,
      R => SR(0)
    );
\RX_CONFIG_VALID_REG_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => p_1_in_1,
      Q => \n_0_RX_CONFIG_VALID_REG_reg[3]\,
      R => SR(0)
    );
RX_DATA_ERROR_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"888AAAAA88888888"
    )
    port map (
      I0 => \^o1\,
      I1 => n_0_RX_DATA_ERROR_i_2,
      I2 => R,
      I3 => I10,
      I4 => R_REG1,
      I5 => T_REG2,
      O => RX_DATA_ERROR0
    );
RX_DATA_ERROR_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF0A0E"
    )
    port map (
      I0 => \^k28p5_reg1\,
      I1 => R,
      I2 => R_REG1,
      I3 => T_REG1,
      I4 => n_0_RX_DATA_ERROR_i_4,
      O => n_0_RX_DATA_ERROR_i_2
    );
RX_DATA_ERROR_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => CGBAD_REG3,
      I1 => C_REG1,
      I2 => ILLEGAL_K_REG2,
      I3 => \^rx_idle\,
      O => n_0_RX_DATA_ERROR_i_4
    );
RX_DATA_ERROR_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => RX_DATA_ERROR0,
      Q => RX_DATA_ERROR,
      R => SYNC_STATUS_REG0
    );
RX_DV_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => I2,
      Q => gmii_rx_dv,
      R => '0'
    );
RX_ER_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2220222000202220"
    )
    port map (
      I0 => XMIT_DATA,
      I1 => n_0_RX_ER_i_2,
      I2 => \^o1\,
      I3 => RXSYNC_STATUS,
      I4 => n_0_RX_ER_i_3,
      I5 => RX_DATA_ERROR,
      O => RX_ER0
    );
RX_ER_i_2: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => I7(2),
      I1 => I7(1),
      O => n_0_RX_ER_i_2
    );
RX_ER_i_3: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => FALSE_CARRIER_REG3,
      I1 => EXTEND_REG1,
      O => n_0_RX_ER_i_3
    );
RX_ER_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => RX_ER0,
      Q => gmii_rx_er,
      R => SR(0)
    );
RX_INVALID_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00700050"
    )
    port map (
      I0 => n_0_RX_INVALID_i_2,
      I1 => \^k28p5_reg1\,
      I2 => RXSYNC_STATUS,
      I3 => SR(0),
      I4 => \^o2\,
      O => n_0_RX_INVALID_i_1
    );
RX_INVALID_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4445"
    )
    port map (
      I0 => FROM_RX_CX,
      I1 => I5,
      I2 => FROM_RX_K,
      I3 => FROM_IDLE_D,
      O => n_0_RX_INVALID_i_2
    );
RX_INVALID_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => n_0_RX_INVALID_i_1,
      Q => \^o2\,
      R => '0'
    );
R_REG1_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => R,
      Q => R_REG1,
      R => '0'
    );
R_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2000000000000000"
    )
    port map (
      I0 => n_0_R_i_2,
      I1 => Q(3),
      I2 => Q(1),
      I3 => Q(0),
      I4 => Q(2),
      I5 => I1,
      O => K23p7
    );
R_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => Q(4),
      I1 => Q(7),
      I2 => Q(6),
      I3 => Q(5),
      O => n_0_R_i_2
    );
R_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => K23p7,
      Q => R,
      R => '0'
    );
SOP_REG1_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => SOP,
      Q => SOP_REG1,
      R => '0'
    );
SOP_REG2_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => SOP_REG1,
      Q => SOP_REG2,
      R => '0'
    );
SOP_REG3_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => SOP_REG2,
      Q => \^sop_reg3\,
      R => '0'
    );
SOP_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"20202000"
    )
    port map (
      I0 => I5,
      I1 => WAIT_FOR_K,
      I2 => S_0,
      I3 => \^rx_idle\,
      I4 => n_0_EXTEND_reg,
      O => SOP0
    );
SOP_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => SOP0,
      Q => SOP,
      R => SR(0)
    );
SYNC_STATUS_REG_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => '1',
      Q => SYNC_STATUS_REG,
      R => SYNC_STATUS_REG0
    );
S_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00002000"
    )
    port map (
      I0 => n_0_S_i_2,
      I1 => Q(2),
      I2 => Q(1),
      I3 => Q(0),
      I4 => S2,
      O => S0
    );
S_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000000"
    )
    port map (
      I0 => Q(5),
      I1 => Q(6),
      I2 => Q(7),
      I3 => Q(4),
      I4 => Q(3),
      I5 => I1,
      O => n_0_S_i_2
    );
S_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => S0,
      Q => S_0,
      R => '0'
    );
T_REG1_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => T,
      Q => T_REG1,
      R => '0'
    );
T_REG2_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => T_REG1,
      Q => T_REG2,
      R => '0'
    );
T_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4000"
    )
    port map (
      I0 => Q(1),
      I1 => Q(0),
      I2 => Q(2),
      I3 => n_0_S_i_2,
      O => K29p7
    );
T_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => K29p7,
      Q => T,
      R => '0'
    );
WAIT_FOR_K_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0222222200002222"
    )
    port map (
      I0 => RXSYNC_STATUS,
      I1 => SR(0),
      I2 => RXEVEN,
      I3 => \^k28p5_reg1\,
      I4 => SYNC_STATUS_REG,
      I5 => WAIT_FOR_K,
      O => n_0_WAIT_FOR_K_i_1
    );
WAIT_FOR_K_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => n_0_WAIT_FOR_K_i_1,
      Q => WAIT_FOR_K,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gmii_to_sgmii_SYNCHRONISE is
  port (
    RXEVEN : out STD_LOGIC;
    RXSYNC_STATUS : out STD_LOGIC;
    O1 : out STD_LOGIC;
    STATUS_VECTOR_0_PRE0 : out STD_LOGIC;
    SYNC_STATUS_REG0 : out STD_LOGIC;
    O2 : out STD_LOGIC;
    O3 : out STD_LOGIC;
    O4 : out STD_LOGIC;
    enablealign : out STD_LOGIC;
    SIGNAL_DETECT_MOD : in STD_LOGIC;
    userclk2 : in STD_LOGIC;
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    I1 : in STD_LOGIC;
    I2 : in STD_LOGIC;
    I3 : in STD_LOGIC;
    I4 : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 2 downto 0 );
    p_0_in : in STD_LOGIC;
    D : in STD_LOGIC;
    RXNOTINTABLE_INT : in STD_LOGIC;
    reset_done : in STD_LOGIC;
    XMIT_DATA_INT : in STD_LOGIC;
    K28p5_REG1 : in STD_LOGIC;
    I5 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of gmii_to_sgmii_SYNCHRONISE : entity is "SYNCHRONISE";
end gmii_to_sgmii_SYNCHRONISE;

architecture STRUCTURE of gmii_to_sgmii_SYNCHRONISE is
  signal GOOD_CGS : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \^rxeven\ : STD_LOGIC;
  signal \^rxsync_status\ : STD_LOGIC;
  signal SIGNAL_DETECT_REG : STD_LOGIC;
  signal STATE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal SYNC_STATUS0 : STD_LOGIC;
  signal \^enablealign\ : STD_LOGIC;
  signal n_0_ENCOMMAALIGN_i_1 : STD_LOGIC;
  signal n_0_ENCOMMAALIGN_i_2 : STD_LOGIC;
  signal n_0_EVEN_i_1 : STD_LOGIC;
  signal \n_0_FSM_sequential_STATE[0]_i_2\ : STD_LOGIC;
  signal \n_0_FSM_sequential_STATE[0]_i_3\ : STD_LOGIC;
  signal \n_0_FSM_sequential_STATE[1]_i_2\ : STD_LOGIC;
  signal \n_0_FSM_sequential_STATE[1]_i_3\ : STD_LOGIC;
  signal \n_0_FSM_sequential_STATE[2]_i_2\ : STD_LOGIC;
  signal \n_0_FSM_sequential_STATE[2]_i_3\ : STD_LOGIC;
  signal \n_0_FSM_sequential_STATE[3]_i_1\ : STD_LOGIC;
  signal \n_0_FSM_sequential_STATE[3]_i_2\ : STD_LOGIC;
  signal \n_0_FSM_sequential_STATE[3]_i_3\ : STD_LOGIC;
  signal \n_0_FSM_sequential_STATE[3]_i_4\ : STD_LOGIC;
  signal \n_0_FSM_sequential_STATE_reg[0]_i_1\ : STD_LOGIC;
  signal \n_0_FSM_sequential_STATE_reg[1]_i_1\ : STD_LOGIC;
  signal \n_0_FSM_sequential_STATE_reg[2]_i_1\ : STD_LOGIC;
  signal \n_0_GOOD_CGS[0]_i_1\ : STD_LOGIC;
  signal \n_0_GOOD_CGS[1]_i_1\ : STD_LOGIC;
  signal \n_0_GOOD_CGS[1]_i_2\ : STD_LOGIC;
  signal n_0_SYNC_STATUS_i_1 : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of ENCOMMAALIGN_i_1 : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of EVEN_i_1 : label is "soft_lutpair41";
  attribute KEEP : string;
  attribute KEEP of \FSM_sequential_STATE_reg[0]\ : label is "yes";
  attribute KEEP of \FSM_sequential_STATE_reg[1]\ : label is "yes";
  attribute KEEP of \FSM_sequential_STATE_reg[2]\ : label is "yes";
  attribute KEEP of \FSM_sequential_STATE_reg[3]\ : label is "yes";
  attribute SOFT_HLUTNM of \GOOD_CGS[0]_i_1\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \GOOD_CGS[1]_i_1\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of RX_DV_i_3 : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of RX_RUDI_INVALID_REG_i_1 : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of SYNC_STATUS_REG_i_1 : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of SYNC_STATUS_i_1 : label is "soft_lutpair42";
begin
  RXEVEN <= \^rxeven\;
  RXSYNC_STATUS <= \^rxsync_status\;
  enablealign <= \^enablealign\;
ENCOMMAALIGN_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"0E"
    )
    port map (
      I0 => \^enablealign\,
      I1 => n_0_ENCOMMAALIGN_i_2,
      I2 => SYNC_STATUS0,
      O => n_0_ENCOMMAALIGN_i_1
    );
ENCOMMAALIGN_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000443"
    )
    port map (
      I0 => \n_0_FSM_sequential_STATE[3]_i_4\,
      I1 => STATE(3),
      I2 => STATE(1),
      I3 => STATE(2),
      I4 => STATE(0),
      O => n_0_ENCOMMAALIGN_i_2
    );
ENCOMMAALIGN_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000100000000000"
    )
    port map (
      I0 => STATE(3),
      I1 => STATE(1),
      I2 => STATE(2),
      I3 => STATE(0),
      I4 => I4,
      I5 => \n_0_FSM_sequential_STATE[3]_i_4\,
      O => SYNC_STATUS0
    );
ENCOMMAALIGN_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => n_0_ENCOMMAALIGN_i_1,
      Q => \^enablealign\,
      R => '0'
    );
EVEN_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"4F"
    )
    port map (
      I0 => \^rxsync_status\,
      I1 => I1,
      I2 => \^rxeven\,
      O => n_0_EVEN_i_1
    );
EVEN_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => n_0_EVEN_i_1,
      Q => \^rxeven\,
      R => SR(0)
    );
EXTEND_i_2: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \^rxsync_status\,
      I1 => SR(0),
      O => O2
    );
\FSM_sequential_STATE[0]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"99404050"
    )
    port map (
      I0 => STATE(0),
      I1 => \n_0_FSM_sequential_STATE[3]_i_4\,
      I2 => I1,
      I3 => STATE(1),
      I4 => STATE(2),
      O => \n_0_FSM_sequential_STATE[0]_i_2\
    );
\FSM_sequential_STATE[0]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00F000DF00000000"
    )
    port map (
      I0 => GOOD_CGS(1),
      I1 => GOOD_CGS(0),
      I2 => STATE(0),
      I3 => STATE(2),
      I4 => STATE(1),
      I5 => \n_0_FSM_sequential_STATE[3]_i_4\,
      O => \n_0_FSM_sequential_STATE[0]_i_3\
    );
\FSM_sequential_STATE[1]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"33403040"
    )
    port map (
      I0 => I4,
      I1 => STATE(0),
      I2 => \n_0_FSM_sequential_STATE[3]_i_4\,
      I3 => STATE(1),
      I4 => STATE(2),
      O => \n_0_FSM_sequential_STATE[1]_i_2\
    );
\FSM_sequential_STATE[1]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000FF0020FF"
    )
    port map (
      I0 => GOOD_CGS(1),
      I1 => GOOD_CGS(0),
      I2 => \n_0_FSM_sequential_STATE[3]_i_4\,
      I3 => STATE(0),
      I4 => STATE(1),
      I5 => STATE(2),
      O => \n_0_FSM_sequential_STATE[1]_i_3\
    );
\FSM_sequential_STATE[2]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"33704000"
    )
    port map (
      I0 => I4,
      I1 => STATE(0),
      I2 => \n_0_FSM_sequential_STATE[3]_i_4\,
      I3 => STATE(1),
      I4 => STATE(2),
      O => \n_0_FSM_sequential_STATE[2]_i_2\
    );
\FSM_sequential_STATE[2]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"140E141400000000"
    )
    port map (
      I0 => STATE(0),
      I1 => STATE(1),
      I2 => STATE(2),
      I3 => GOOD_CGS(0),
      I4 => GOOD_CGS(1),
      I5 => \n_0_FSM_sequential_STATE[3]_i_4\,
      O => \n_0_FSM_sequential_STATE[2]_i_3\
    );
\FSM_sequential_STATE[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AB"
    )
    port map (
      I0 => SR(0),
      I1 => SIGNAL_DETECT_REG,
      I2 => Q(1),
      O => \n_0_FSM_sequential_STATE[3]_i_1\
    );
\FSM_sequential_STATE[3]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0FB000B000C0C0F0"
    )
    port map (
      I0 => \n_0_FSM_sequential_STATE[3]_i_3\,
      I1 => \n_0_FSM_sequential_STATE[3]_i_4\,
      I2 => STATE(3),
      I3 => STATE(2),
      I4 => STATE(1),
      I5 => STATE(0),
      O => \n_0_FSM_sequential_STATE[3]_i_2\
    );
\FSM_sequential_STATE[3]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => GOOD_CGS(0),
      I1 => GOOD_CGS(1),
      O => \n_0_FSM_sequential_STATE[3]_i_3\
    );
\FSM_sequential_STATE[3]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000007"
    )
    port map (
      I0 => I1,
      I1 => \^rxeven\,
      I2 => p_0_in,
      I3 => D,
      I4 => RXNOTINTABLE_INT,
      O => \n_0_FSM_sequential_STATE[3]_i_4\
    );
\FSM_sequential_STATE_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_FSM_sequential_STATE_reg[0]_i_1\,
      Q => STATE(0),
      R => \n_0_FSM_sequential_STATE[3]_i_1\
    );
\FSM_sequential_STATE_reg[0]_i_1\: unisim.vcomponents.MUXF7
    port map (
      I0 => \n_0_FSM_sequential_STATE[0]_i_2\,
      I1 => \n_0_FSM_sequential_STATE[0]_i_3\,
      O => \n_0_FSM_sequential_STATE_reg[0]_i_1\,
      S => STATE(3)
    );
\FSM_sequential_STATE_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_FSM_sequential_STATE_reg[1]_i_1\,
      Q => STATE(1),
      R => \n_0_FSM_sequential_STATE[3]_i_1\
    );
\FSM_sequential_STATE_reg[1]_i_1\: unisim.vcomponents.MUXF7
    port map (
      I0 => \n_0_FSM_sequential_STATE[1]_i_2\,
      I1 => \n_0_FSM_sequential_STATE[1]_i_3\,
      O => \n_0_FSM_sequential_STATE_reg[1]_i_1\,
      S => STATE(3)
    );
\FSM_sequential_STATE_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_FSM_sequential_STATE_reg[2]_i_1\,
      Q => STATE(2),
      R => \n_0_FSM_sequential_STATE[3]_i_1\
    );
\FSM_sequential_STATE_reg[2]_i_1\: unisim.vcomponents.MUXF7
    port map (
      I0 => \n_0_FSM_sequential_STATE[2]_i_2\,
      I1 => \n_0_FSM_sequential_STATE[2]_i_3\,
      O => \n_0_FSM_sequential_STATE_reg[2]_i_1\,
      S => STATE(3)
    );
\FSM_sequential_STATE_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_FSM_sequential_STATE[3]_i_2\,
      Q => STATE(3),
      R => \n_0_FSM_sequential_STATE[3]_i_1\
    );
\GOOD_CGS[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"06"
    )
    port map (
      I0 => GOOD_CGS(0),
      I1 => \n_0_FSM_sequential_STATE[3]_i_4\,
      I2 => \n_0_GOOD_CGS[1]_i_2\,
      O => \n_0_GOOD_CGS[0]_i_1\
    );
\GOOD_CGS[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"006A"
    )
    port map (
      I0 => GOOD_CGS(1),
      I1 => \n_0_FSM_sequential_STATE[3]_i_4\,
      I2 => GOOD_CGS(0),
      I3 => \n_0_GOOD_CGS[1]_i_2\,
      O => \n_0_GOOD_CGS[1]_i_1\
    );
\GOOD_CGS[1]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF0580"
    )
    port map (
      I0 => STATE(0),
      I1 => STATE(1),
      I2 => STATE(2),
      I3 => STATE(3),
      I4 => SR(0),
      O => \n_0_GOOD_CGS[1]_i_2\
    );
\GOOD_CGS_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_GOOD_CGS[0]_i_1\,
      Q => GOOD_CGS(0),
      R => '0'
    );
\GOOD_CGS_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_GOOD_CGS[1]_i_1\,
      Q => GOOD_CGS(1),
      R => '0'
    );
RX_DATA_ERROR_i_3: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => \^rxeven\,
      I1 => K28p5_REG1,
      O => O3
    );
RX_DV_i_3: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \^rxsync_status\,
      I1 => I5,
      O => O4
    );
RX_RUDI_INVALID_REG_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
    port map (
      I0 => I2,
      I1 => \^rxsync_status\,
      I2 => I3,
      O => O1
    );
SIGNAL_DETECT_REG_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => SIGNAL_DETECT_MOD,
      Q => SIGNAL_DETECT_REG,
      R => '0'
    );
STATUS_VECTOR_0_PRE_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"80888080"
    )
    port map (
      I0 => reset_done,
      I1 => \^rxsync_status\,
      I2 => XMIT_DATA_INT,
      I3 => Q(2),
      I4 => Q(0),
      O => STATUS_VECTOR_0_PRE0
    );
SYNC_STATUS_REG_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => SR(0),
      I1 => \^rxsync_status\,
      O => SYNC_STATUS_REG0
    );
SYNC_STATUS_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F4"
    )
    port map (
      I0 => n_0_ENCOMMAALIGN_i_2,
      I1 => \^rxsync_status\,
      I2 => SYNC_STATUS0,
      O => n_0_SYNC_STATUS_i_1
    );
SYNC_STATUS_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => n_0_SYNC_STATUS_i_1,
      Q => \^rxsync_status\,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \gmii_to_sgmii_TX__parameterized0\ is
  port (
    D : out STD_LOGIC_VECTOR ( 3 downto 0 );
    O1 : out STD_LOGIC;
    O2 : out STD_LOGIC;
    O3 : out STD_LOGIC;
    O4 : out STD_LOGIC;
    O5 : out STD_LOGIC;
    O6 : out STD_LOGIC;
    O7 : out STD_LOGIC;
    O8 : out STD_LOGIC;
    O9 : out STD_LOGIC_VECTOR ( 7 downto 0 );
    O10 : out STD_LOGIC;
    O11 : out STD_LOGIC;
    gmii_tx_er : in STD_LOGIC;
    userclk2 : in STD_LOGIC;
    gmii_tx_en : in STD_LOGIC;
    I1 : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gmii_txd : in STD_LOGIC_VECTOR ( 7 downto 0 );
    rxcharisk : in STD_LOGIC_VECTOR ( 0 to 0 );
    rxchariscomma : in STD_LOGIC_VECTOR ( 0 to 0 );
    rxdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
    XMIT_DATA_INT : in STD_LOGIC;
    XMIT_CONFIG_INT : in STD_LOGIC;
    I2 : in STD_LOGIC;
    I3 : in STD_LOGIC;
    I4 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \gmii_to_sgmii_TX__parameterized0\ : entity is "TX";
end \gmii_to_sgmii_TX__parameterized0\;

architecture STRUCTURE of \gmii_to_sgmii_TX__parameterized0\ is
  signal CODE_GRPISK : STD_LOGIC;
  signal CONFIG_K28p5 : STD_LOGIC;
  signal CONFIG_K28p5_1 : STD_LOGIC;
  signal DISPARITY : STD_LOGIC;
  signal K28p5 : STD_LOGIC;
  signal S : STD_LOGIC;
  signal S0 : STD_LOGIC;
  signal T : STD_LOGIC;
  signal T0 : STD_LOGIC;
  signal TRIGGER_S : STD_LOGIC;
  signal TRIGGER_S0 : STD_LOGIC;
  signal TRIGGER_T : STD_LOGIC;
  signal TXCHARDISPMODE_INT : STD_LOGIC;
  signal TXCHARDISPVAL : STD_LOGIC;
  signal TXCHARISK_INT : STD_LOGIC;
  signal TXDATA : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal TXD_REG1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal TX_CONFIG : STD_LOGIC_VECTOR ( 14 downto 0 );
  signal TX_EN_REG1 : STD_LOGIC;
  signal TX_ER_REG1 : STD_LOGIC;
  signal TX_EVEN : STD_LOGIC;
  signal XMIT_CONFIG_INT_0 : STD_LOGIC;
  signal n_0_C1_OR_C2_i_1 : STD_LOGIC;
  signal n_0_C1_OR_C2_reg : STD_LOGIC;
  signal n_0_CODE_GRPISK_i_1 : STD_LOGIC;
  signal \n_0_CODE_GRP[0]_i_1\ : STD_LOGIC;
  signal \n_0_CODE_GRP[0]_i_2\ : STD_LOGIC;
  signal \n_0_CODE_GRP[1]_i_1\ : STD_LOGIC;
  signal \n_0_CODE_GRP[1]_i_2\ : STD_LOGIC;
  signal \n_0_CODE_GRP[2]_i_1\ : STD_LOGIC;
  signal \n_0_CODE_GRP[2]_i_2\ : STD_LOGIC;
  signal \n_0_CODE_GRP[3]_i_1\ : STD_LOGIC;
  signal \n_0_CODE_GRP[3]_i_2\ : STD_LOGIC;
  signal \n_0_CODE_GRP[4]_i_1\ : STD_LOGIC;
  signal \n_0_CODE_GRP[5]_i_1\ : STD_LOGIC;
  signal \n_0_CODE_GRP[6]_i_1\ : STD_LOGIC;
  signal \n_0_CODE_GRP[6]_i_2\ : STD_LOGIC;
  signal \n_0_CODE_GRP[7]_i_1\ : STD_LOGIC;
  signal \n_0_CODE_GRP[7]_i_2\ : STD_LOGIC;
  signal \n_0_CODE_GRP[7]_i_3\ : STD_LOGIC;
  signal \n_0_CODE_GRP_CNT_reg[1]\ : STD_LOGIC;
  signal \n_0_CODE_GRP_reg[0]\ : STD_LOGIC;
  signal \n_0_CONFIG_DATA[0]_i_1\ : STD_LOGIC;
  signal \n_0_CONFIG_DATA[1]_i_1\ : STD_LOGIC;
  signal \n_0_CONFIG_DATA[2]_i_1\ : STD_LOGIC;
  signal \n_0_CONFIG_DATA[3]_i_1\ : STD_LOGIC;
  signal \n_0_CONFIG_DATA[4]_i_1\ : STD_LOGIC;
  signal \n_0_CONFIG_DATA[5]_i_1\ : STD_LOGIC;
  signal \n_0_CONFIG_DATA[6]_i_1\ : STD_LOGIC;
  signal \n_0_CONFIG_DATA[7]_i_1\ : STD_LOGIC;
  signal \n_0_CONFIG_DATA_reg[0]\ : STD_LOGIC;
  signal \n_0_CONFIG_DATA_reg[1]\ : STD_LOGIC;
  signal \n_0_CONFIG_DATA_reg[2]\ : STD_LOGIC;
  signal \n_0_CONFIG_DATA_reg[3]\ : STD_LOGIC;
  signal \n_0_CONFIG_DATA_reg[4]\ : STD_LOGIC;
  signal \n_0_CONFIG_DATA_reg[5]\ : STD_LOGIC;
  signal \n_0_CONFIG_DATA_reg[6]\ : STD_LOGIC;
  signal \n_0_CONFIG_DATA_reg[7]\ : STD_LOGIC;
  signal n_0_INSERT_IDLE_i_1 : STD_LOGIC;
  signal n_0_INSERT_IDLE_reg : STD_LOGIC;
  signal n_0_K28p5_i_1 : STD_LOGIC;
  signal \n_0_NO_QSGMII_CHAR.TXCHARDISPVAL_i_1\ : STD_LOGIC;
  signal \n_0_NO_QSGMII_DATA.TXCHARISK_i_1\ : STD_LOGIC;
  signal \n_0_NO_QSGMII_DATA.TXDATA[0]_i_1\ : STD_LOGIC;
  signal \n_0_NO_QSGMII_DATA.TXDATA[1]_i_1\ : STD_LOGIC;
  signal \n_0_NO_QSGMII_DATA.TXDATA[2]_i_1\ : STD_LOGIC;
  signal \n_0_NO_QSGMII_DATA.TXDATA[3]_i_1\ : STD_LOGIC;
  signal \n_0_NO_QSGMII_DATA.TXDATA[4]_i_1\ : STD_LOGIC;
  signal \n_0_NO_QSGMII_DATA.TXDATA[5]_i_1\ : STD_LOGIC;
  signal \n_0_NO_QSGMII_DATA.TXDATA[6]_i_1\ : STD_LOGIC;
  signal \n_0_NO_QSGMII_DATA.TXDATA[7]_i_1\ : STD_LOGIC;
  signal \n_0_NO_QSGMII_DISP.DISPARITY_i_1\ : STD_LOGIC;
  signal \n_0_NO_QSGMII_DISP.DISPARITY_i_2\ : STD_LOGIC;
  signal \n_0_NO_QSGMII_DISP.DISPARITY_i_3\ : STD_LOGIC;
  signal \n_0_R_i_1__0\ : STD_LOGIC;
  signal n_0_R_reg : STD_LOGIC;
  signal n_0_SYNC_DISPARITY_i_1 : STD_LOGIC;
  signal n_0_SYNC_DISPARITY_reg : STD_LOGIC;
  signal \n_0_TX_CONFIG[0]_i_1\ : STD_LOGIC;
  signal \n_0_TX_CONFIG[11]_i_1\ : STD_LOGIC;
  signal \n_0_TX_CONFIG[14]_i_1\ : STD_LOGIC;
  signal n_0_TX_PACKET_i_1 : STD_LOGIC;
  signal n_0_TX_PACKET_reg : STD_LOGIC;
  signal n_0_V_i_1 : STD_LOGIC;
  signal n_0_V_i_2 : STD_LOGIC;
  signal n_0_V_i_3 : STD_LOGIC;
  signal n_0_V_i_4 : STD_LOGIC;
  signal n_0_V_reg : STD_LOGIC;
  signal n_0_XMIT_CONFIG_INT_i_1 : STD_LOGIC;
  signal \n_0_XMIT_DATA_INT_i_1__0\ : STD_LOGIC;
  signal n_0_XMIT_DATA_INT_reg : STD_LOGIC;
  signal p_0_in : STD_LOGIC;
  signal p_0_in18_in : STD_LOGIC;
  signal p_0_in37_in : STD_LOGIC;
  signal p_12_out : STD_LOGIC;
  signal p_1_in : STD_LOGIC;
  signal p_1_in1_in : STD_LOGIC;
  signal p_1_in36_in : STD_LOGIC;
  signal p_35_in : STD_LOGIC;
  signal p_49_in : STD_LOGIC;
  signal plusOp : STD_LOGIC_VECTOR ( 1 downto 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of C1_OR_C2_i_1 : label is "soft_lutpair54";
  attribute SOFT_HLUTNM of \CODE_GRP[2]_i_1\ : label is "soft_lutpair45";
  attribute SOFT_HLUTNM of \CODE_GRP[7]_i_1\ : label is "soft_lutpair50";
  attribute SOFT_HLUTNM of \CODE_GRP[7]_i_3\ : label is "soft_lutpair45";
  attribute SOFT_HLUTNM of \CODE_GRP_CNT[1]_i_1\ : label is "soft_lutpair70";
  attribute SOFT_HLUTNM of \CONFIG_DATA[0]_i_1\ : label is "soft_lutpair48";
  attribute SOFT_HLUTNM of \CONFIG_DATA[1]_i_1\ : label is "soft_lutpair53";
  attribute SOFT_HLUTNM of \CONFIG_DATA[2]_i_1\ : label is "soft_lutpair54";
  attribute SOFT_HLUTNM of \CONFIG_DATA[3]_i_1\ : label is "soft_lutpair51";
  attribute SOFT_HLUTNM of \CONFIG_DATA[4]_i_1\ : label is "soft_lutpair58";
  attribute SOFT_HLUTNM of \CONFIG_DATA[5]_i_1\ : label is "soft_lutpair58";
  attribute SOFT_HLUTNM of \CONFIG_DATA[6]_i_1\ : label is "soft_lutpair53";
  attribute SOFT_HLUTNM of \CONFIG_DATA[7]_i_1\ : label is "soft_lutpair62";
  attribute SOFT_HLUTNM of CONFIG_K28p5_i_1 : label is "soft_lutpair56";
  attribute SOFT_HLUTNM of K28p5_i_1 : label is "soft_lutpair50";
  attribute SOFT_HLUTNM of \NO_QSGMII_CHAR.TXCHARDISPMODE_i_1\ : label is "soft_lutpair70";
  attribute SOFT_HLUTNM of \NO_QSGMII_CHAR.TXCHARDISPVAL_i_1\ : label is "soft_lutpair62";
  attribute SOFT_HLUTNM of \NO_QSGMII_DATA.TXDATA[0]_i_1\ : label is "soft_lutpair49";
  attribute SOFT_HLUTNM of \NO_QSGMII_DATA.TXDATA[1]_i_1\ : label is "soft_lutpair46";
  attribute SOFT_HLUTNM of \NO_QSGMII_DATA.TXDATA[2]_i_1\ : label is "soft_lutpair49";
  attribute SOFT_HLUTNM of \NO_QSGMII_DATA.TXDATA[3]_i_1\ : label is "soft_lutpair52";
  attribute SOFT_HLUTNM of \NO_QSGMII_DATA.TXDATA[4]_i_1\ : label is "soft_lutpair47";
  attribute SOFT_HLUTNM of \NO_QSGMII_DATA.TXDATA[5]_i_1\ : label is "soft_lutpair52";
  attribute SOFT_HLUTNM of \NO_QSGMII_DATA.TXDATA[6]_i_1\ : label is "soft_lutpair46";
  attribute SOFT_HLUTNM of \NO_QSGMII_DATA.TXDATA[7]_i_1\ : label is "soft_lutpair47";
  attribute SOFT_HLUTNM of TRIGGER_S_i_1 : label is "soft_lutpair55";
  attribute SOFT_HLUTNM of TRIGGER_T_i_1 : label is "soft_lutpair55";
  attribute SOFT_HLUTNM of \TX_CONFIG[0]_i_1\ : label is "soft_lutpair48";
  attribute SOFT_HLUTNM of \TX_CONFIG[11]_i_1\ : label is "soft_lutpair51";
  attribute SOFT_HLUTNM of \TX_CONFIG[14]_i_1\ : label is "soft_lutpair56";
  attribute SOFT_HLUTNM of \USE_ROCKET_IO.NO_1588.RXCHARISCOMMA_INT_i_1\ : label is "soft_lutpair65";
  attribute SOFT_HLUTNM of \USE_ROCKET_IO.NO_1588.RXCHARISK_INT_i_1\ : label is "soft_lutpair65";
  attribute SOFT_HLUTNM of \USE_ROCKET_IO.NO_1588.RXDATA_INT[0]_i_1\ : label is "soft_lutpair60";
  attribute SOFT_HLUTNM of \USE_ROCKET_IO.NO_1588.RXDATA_INT[1]_i_1\ : label is "soft_lutpair61";
  attribute SOFT_HLUTNM of \USE_ROCKET_IO.NO_1588.RXDATA_INT[2]_i_1\ : label is "soft_lutpair63";
  attribute SOFT_HLUTNM of \USE_ROCKET_IO.NO_1588.RXDATA_INT[3]_i_1\ : label is "soft_lutpair69";
  attribute SOFT_HLUTNM of \USE_ROCKET_IO.NO_1588.RXDATA_INT[4]_i_1\ : label is "soft_lutpair68";
  attribute SOFT_HLUTNM of \USE_ROCKET_IO.NO_1588.RXDATA_INT[5]_i_1\ : label is "soft_lutpair64";
  attribute SOFT_HLUTNM of \USE_ROCKET_IO.NO_1588.RXDATA_INT[6]_i_1\ : label is "soft_lutpair67";
  attribute SOFT_HLUTNM of \USE_ROCKET_IO.NO_1588.RXDATA_INT[7]_i_1\ : label is "soft_lutpair66";
  attribute SOFT_HLUTNM of \USE_ROCKET_IO.TXCHARDISPMODE_i_1\ : label is "soft_lutpair59";
  attribute SOFT_HLUTNM of \USE_ROCKET_IO.TXCHARDISPVAL_i_1\ : label is "soft_lutpair69";
  attribute SOFT_HLUTNM of \USE_ROCKET_IO.TXCHARISK_i_1\ : label is "soft_lutpair59";
  attribute SOFT_HLUTNM of \USE_ROCKET_IO.TXDATA[0]_i_1\ : label is "soft_lutpair60";
  attribute SOFT_HLUTNM of \USE_ROCKET_IO.TXDATA[1]_i_1\ : label is "soft_lutpair61";
  attribute SOFT_HLUTNM of \USE_ROCKET_IO.TXDATA[2]_i_1\ : label is "soft_lutpair63";
  attribute SOFT_HLUTNM of \USE_ROCKET_IO.TXDATA[3]_i_1\ : label is "soft_lutpair68";
  attribute SOFT_HLUTNM of \USE_ROCKET_IO.TXDATA[4]_i_1\ : label is "soft_lutpair67";
  attribute SOFT_HLUTNM of \USE_ROCKET_IO.TXDATA[5]_i_1\ : label is "soft_lutpair64";
  attribute SOFT_HLUTNM of \USE_ROCKET_IO.TXDATA[6]_i_1\ : label is "soft_lutpair57";
  attribute SOFT_HLUTNM of \USE_ROCKET_IO.TXDATA[7]_i_1\ : label is "soft_lutpair57";
  attribute SOFT_HLUTNM of \USE_ROCKET_IO.TXDATA[7]_i_2\ : label is "soft_lutpair66";
begin
C1_OR_C2_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3F80"
    )
    port map (
      I0 => XMIT_CONFIG_INT_0,
      I1 => \n_0_CODE_GRP_CNT_reg[1]\,
      I2 => TX_EVEN,
      I3 => n_0_C1_OR_C2_reg,
      O => n_0_C1_OR_C2_i_1
    );
C1_OR_C2_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => n_0_C1_OR_C2_i_1,
      Q => n_0_C1_OR_C2_reg,
      R => I1
    );
CODE_GRPISK_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"30303030FFFF55FF"
    )
    port map (
      I0 => n_0_TX_PACKET_reg,
      I1 => \n_0_CODE_GRP_CNT_reg[1]\,
      I2 => TX_EVEN,
      I3 => \n_0_CODE_GRP[6]_i_2\,
      I4 => Q(2),
      I5 => XMIT_CONFIG_INT_0,
      O => n_0_CODE_GRPISK_i_1
    );
CODE_GRPISK_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => n_0_CODE_GRPISK_i_1,
      Q => CODE_GRPISK,
      R => '0'
    );
\CODE_GRP[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF000031003100"
    )
    port map (
      I0 => n_0_V_reg,
      I1 => Q(2),
      I2 => S,
      I3 => \n_0_CODE_GRP[0]_i_2\,
      I4 => \n_0_CONFIG_DATA_reg[0]\,
      I5 => XMIT_CONFIG_INT_0,
      O => \n_0_CODE_GRP[0]_i_1\
    );
\CODE_GRP[0]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFEFEFE"
    )
    port map (
      I0 => S,
      I1 => n_0_R_reg,
      I2 => T,
      I3 => TXD_REG1(0),
      I4 => n_0_TX_PACKET_reg,
      O => \n_0_CODE_GRP[0]_i_2\
    );
\CODE_GRP[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F011"
    )
    port map (
      I0 => \n_0_CODE_GRP[1]_i_2\,
      I1 => Q(2),
      I2 => \n_0_CONFIG_DATA_reg[1]\,
      I3 => XMIT_CONFIG_INT_0,
      O => \n_0_CODE_GRP[1]_i_1\
    );
\CODE_GRP[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1010101110111011"
    )
    port map (
      I0 => n_0_V_reg,
      I1 => S,
      I2 => T,
      I3 => n_0_R_reg,
      I4 => TXD_REG1(1),
      I5 => n_0_TX_PACKET_reg,
      O => \n_0_CODE_GRP[1]_i_2\
    );
\CODE_GRP[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAA20A02"
    )
    port map (
      I0 => \n_0_CODE_GRP[2]_i_2\,
      I1 => S,
      I2 => XMIT_CONFIG_INT_0,
      I3 => Q(2),
      I4 => \n_0_CONFIG_DATA_reg[2]\,
      O => \n_0_CODE_GRP[2]_i_1\
    );
\CODE_GRP[2]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFDF"
    )
    port map (
      I0 => n_0_TX_PACKET_reg,
      I1 => n_0_V_reg,
      I2 => \n_0_CODE_GRP[7]_i_3\,
      I3 => T,
      I4 => TXD_REG1(2),
      I5 => n_0_R_reg,
      O => \n_0_CODE_GRP[2]_i_2\
    );
\CODE_GRP[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"D0DDD0D0D0DDD0DD"
    )
    port map (
      I0 => XMIT_CONFIG_INT_0,
      I1 => \n_0_CONFIG_DATA_reg[3]\,
      I2 => \n_0_CODE_GRP[3]_i_2\,
      I3 => n_0_R_reg,
      I4 => TXD_REG1(3),
      I5 => n_0_TX_PACKET_reg,
      O => \n_0_CODE_GRP[3]_i_1\
    );
\CODE_GRP[3]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
    port map (
      I0 => n_0_V_reg,
      I1 => S,
      I2 => T,
      I3 => Q(2),
      I4 => XMIT_CONFIG_INT_0,
      O => \n_0_CODE_GRP[3]_i_2\
    );
\CODE_GRP[4]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"E0EE"
    )
    port map (
      I0 => \n_0_CODE_GRP[7]_i_2\,
      I1 => TXD_REG1(4),
      I2 => \n_0_CONFIG_DATA_reg[4]\,
      I3 => XMIT_CONFIG_INT_0,
      O => \n_0_CODE_GRP[4]_i_1\
    );
\CODE_GRP[5]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DDD0"
    )
    port map (
      I0 => XMIT_CONFIG_INT_0,
      I1 => \n_0_CONFIG_DATA_reg[5]\,
      I2 => \n_0_CODE_GRP[7]_i_2\,
      I3 => TXD_REG1(5),
      O => \n_0_CODE_GRP[5]_i_1\
    );
\CODE_GRP[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF000000D500D5"
    )
    port map (
      I0 => \n_0_CODE_GRP[6]_i_2\,
      I1 => TXD_REG1(6),
      I2 => n_0_TX_PACKET_reg,
      I3 => Q(2),
      I4 => \n_0_CONFIG_DATA_reg[6]\,
      I5 => XMIT_CONFIG_INT_0,
      O => \n_0_CODE_GRP[6]_i_1\
    );
\CODE_GRP[6]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => n_0_V_reg,
      I1 => T,
      I2 => n_0_R_reg,
      I3 => S,
      O => \n_0_CODE_GRP[6]_i_2\
    );
\CODE_GRP[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DDD0"
    )
    port map (
      I0 => XMIT_CONFIG_INT_0,
      I1 => \n_0_CONFIG_DATA_reg[7]\,
      I2 => \n_0_CODE_GRP[7]_i_2\,
      I3 => TXD_REG1(7),
      O => \n_0_CODE_GRP[7]_i_1\
    );
\CODE_GRP[7]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFEFFFFFFFFFF"
    )
    port map (
      I0 => S,
      I1 => n_0_R_reg,
      I2 => T,
      I3 => n_0_TX_PACKET_reg,
      I4 => n_0_V_reg,
      I5 => \n_0_CODE_GRP[7]_i_3\,
      O => \n_0_CODE_GRP[7]_i_2\
    );
\CODE_GRP[7]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => Q(2),
      I1 => XMIT_CONFIG_INT_0,
      O => \n_0_CODE_GRP[7]_i_3\
    );
\CODE_GRP_CNT[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => TX_EVEN,
      O => plusOp(0)
    );
\CODE_GRP_CNT[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \n_0_CODE_GRP_CNT_reg[1]\,
      I1 => TX_EVEN,
      O => plusOp(1)
    );
\CODE_GRP_CNT_reg[0]\: unisim.vcomponents.FDSE
    port map (
      C => userclk2,
      CE => '1',
      D => plusOp(0),
      Q => TX_EVEN,
      S => I1
    );
\CODE_GRP_CNT_reg[1]\: unisim.vcomponents.FDSE
    port map (
      C => userclk2,
      CE => '1',
      D => plusOp(1),
      Q => \n_0_CODE_GRP_CNT_reg[1]\,
      S => I1
    );
\CODE_GRP_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_CODE_GRP[0]_i_1\,
      Q => \n_0_CODE_GRP_reg[0]\,
      R => '0'
    );
\CODE_GRP_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_CODE_GRP[1]_i_1\,
      Q => p_1_in,
      R => '0'
    );
\CODE_GRP_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_CODE_GRP[2]_i_1\,
      Q => p_0_in18_in,
      R => '0'
    );
\CODE_GRP_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_CODE_GRP[3]_i_1\,
      Q => p_0_in,
      R => '0'
    );
\CODE_GRP_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_CODE_GRP[4]_i_1\,
      Q => p_1_in1_in,
      R => '0'
    );
\CODE_GRP_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_CODE_GRP[5]_i_1\,
      Q => p_1_in36_in,
      R => '0'
    );
\CODE_GRP_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_CODE_GRP[6]_i_1\,
      Q => p_35_in,
      R => '0'
    );
\CODE_GRP_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_CODE_GRP[7]_i_1\,
      Q => p_0_in37_in,
      R => '0'
    );
\CONFIG_DATA[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3404"
    )
    port map (
      I0 => n_0_C1_OR_C2_reg,
      I1 => TX_EVEN,
      I2 => \n_0_CODE_GRP_CNT_reg[1]\,
      I3 => TX_CONFIG(0),
      O => \n_0_CONFIG_DATA[0]_i_1\
    );
\CONFIG_DATA[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
    port map (
      I0 => TX_EVEN,
      I1 => \n_0_CODE_GRP_CNT_reg[1]\,
      I2 => n_0_C1_OR_C2_reg,
      O => \n_0_CONFIG_DATA[1]_i_1\
    );
\CONFIG_DATA[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"15"
    )
    port map (
      I0 => \n_0_CODE_GRP_CNT_reg[1]\,
      I1 => n_0_C1_OR_C2_reg,
      I2 => TX_EVEN,
      O => \n_0_CONFIG_DATA[2]_i_1\
    );
\CONFIG_DATA[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"83"
    )
    port map (
      I0 => TX_CONFIG(11),
      I1 => TX_EVEN,
      I2 => \n_0_CODE_GRP_CNT_reg[1]\,
      O => \n_0_CONFIG_DATA[3]_i_1\
    );
\CONFIG_DATA[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"15"
    )
    port map (
      I0 => \n_0_CODE_GRP_CNT_reg[1]\,
      I1 => n_0_C1_OR_C2_reg,
      I2 => TX_EVEN,
      O => \n_0_CONFIG_DATA[4]_i_1\
    );
\CONFIG_DATA[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"15"
    )
    port map (
      I0 => \n_0_CODE_GRP_CNT_reg[1]\,
      I1 => n_0_C1_OR_C2_reg,
      I2 => TX_EVEN,
      O => \n_0_CONFIG_DATA[5]_i_1\
    );
\CONFIG_DATA[6]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => TX_EVEN,
      I1 => n_0_C1_OR_C2_reg,
      I2 => \n_0_CODE_GRP_CNT_reg[1]\,
      I3 => TX_CONFIG(14),
      O => \n_0_CONFIG_DATA[6]_i_1\
    );
\CONFIG_DATA[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"15"
    )
    port map (
      I0 => \n_0_CODE_GRP_CNT_reg[1]\,
      I1 => n_0_C1_OR_C2_reg,
      I2 => TX_EVEN,
      O => \n_0_CONFIG_DATA[7]_i_1\
    );
\CONFIG_DATA_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_CONFIG_DATA[0]_i_1\,
      Q => \n_0_CONFIG_DATA_reg[0]\,
      R => I1
    );
\CONFIG_DATA_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_CONFIG_DATA[1]_i_1\,
      Q => \n_0_CONFIG_DATA_reg[1]\,
      R => I1
    );
\CONFIG_DATA_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_CONFIG_DATA[2]_i_1\,
      Q => \n_0_CONFIG_DATA_reg[2]\,
      R => I1
    );
\CONFIG_DATA_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_CONFIG_DATA[3]_i_1\,
      Q => \n_0_CONFIG_DATA_reg[3]\,
      R => I1
    );
\CONFIG_DATA_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_CONFIG_DATA[4]_i_1\,
      Q => \n_0_CONFIG_DATA_reg[4]\,
      R => I1
    );
\CONFIG_DATA_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_CONFIG_DATA[5]_i_1\,
      Q => \n_0_CONFIG_DATA_reg[5]\,
      R => I1
    );
\CONFIG_DATA_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_CONFIG_DATA[6]_i_1\,
      Q => \n_0_CONFIG_DATA_reg[6]\,
      R => I1
    );
\CONFIG_DATA_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_CONFIG_DATA[7]_i_1\,
      Q => \n_0_CONFIG_DATA_reg[7]\,
      R => I1
    );
CONFIG_K28p5_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \n_0_CODE_GRP_CNT_reg[1]\,
      I1 => TX_EVEN,
      O => CONFIG_K28p5_1
    );
CONFIG_K28p5_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => CONFIG_K28p5_1,
      Q => CONFIG_K28p5,
      R => I1
    );
INSERT_IDLE_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00F2"
    )
    port map (
      I0 => \n_0_CODE_GRP[6]_i_2\,
      I1 => n_0_TX_PACKET_reg,
      I2 => Q(2),
      I3 => XMIT_CONFIG_INT_0,
      O => n_0_INSERT_IDLE_i_1
    );
INSERT_IDLE_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => n_0_INSERT_IDLE_i_1,
      Q => n_0_INSERT_IDLE_reg,
      R => '0'
    );
K28p5_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => XMIT_CONFIG_INT_0,
      I1 => CONFIG_K28p5,
      O => n_0_K28p5_i_1
    );
K28p5_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => n_0_K28p5_i_1,
      Q => K28p5,
      R => '0'
    );
\NO_QSGMII_CHAR.TXCHARDISPMODE_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => n_0_SYNC_DISPARITY_reg,
      I1 => TX_EVEN,
      O => p_12_out
    );
\NO_QSGMII_CHAR.TXCHARDISPMODE_reg\: unisim.vcomponents.FDSE
    port map (
      C => userclk2,
      CE => '1',
      D => p_12_out,
      Q => TXCHARDISPMODE_INT,
      S => I1
    );
\NO_QSGMII_CHAR.TXCHARDISPVAL_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
    port map (
      I0 => TX_EVEN,
      I1 => n_0_SYNC_DISPARITY_reg,
      I2 => DISPARITY,
      O => \n_0_NO_QSGMII_CHAR.TXCHARDISPVAL_i_1\
    );
\NO_QSGMII_CHAR.TXCHARDISPVAL_reg\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_NO_QSGMII_CHAR.TXCHARDISPVAL_i_1\,
      Q => TXCHARDISPVAL,
      R => I1
    );
\NO_QSGMII_DATA.TXCHARISK_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"002A"
    )
    port map (
      I0 => CODE_GRPISK,
      I1 => TX_EVEN,
      I2 => n_0_INSERT_IDLE_reg,
      I3 => I1,
      O => \n_0_NO_QSGMII_DATA.TXCHARISK_i_1\
    );
\NO_QSGMII_DATA.TXCHARISK_reg\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_NO_QSGMII_DATA.TXCHARISK_i_1\,
      Q => TXCHARISK_INT,
      R => '0'
    );
\NO_QSGMII_DATA.TXDATA[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BF80"
    )
    port map (
      I0 => DISPARITY,
      I1 => TX_EVEN,
      I2 => n_0_INSERT_IDLE_reg,
      I3 => \n_0_CODE_GRP_reg[0]\,
      O => \n_0_NO_QSGMII_DATA.TXDATA[0]_i_1\
    );
\NO_QSGMII_DATA.TXDATA[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"002A"
    )
    port map (
      I0 => p_1_in,
      I1 => TX_EVEN,
      I2 => n_0_INSERT_IDLE_reg,
      I3 => I1,
      O => \n_0_NO_QSGMII_DATA.TXDATA[1]_i_1\
    );
\NO_QSGMII_DATA.TXDATA[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BF80"
    )
    port map (
      I0 => DISPARITY,
      I1 => TX_EVEN,
      I2 => n_0_INSERT_IDLE_reg,
      I3 => p_0_in18_in,
      O => \n_0_NO_QSGMII_DATA.TXDATA[2]_i_1\
    );
\NO_QSGMII_DATA.TXDATA[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"002A"
    )
    port map (
      I0 => p_0_in,
      I1 => TX_EVEN,
      I2 => n_0_INSERT_IDLE_reg,
      I3 => I1,
      O => \n_0_NO_QSGMII_DATA.TXDATA[3]_i_1\
    );
\NO_QSGMII_DATA.TXDATA[4]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F40"
    )
    port map (
      I0 => DISPARITY,
      I1 => TX_EVEN,
      I2 => n_0_INSERT_IDLE_reg,
      I3 => p_1_in1_in,
      O => \n_0_NO_QSGMII_DATA.TXDATA[4]_i_1\
    );
\NO_QSGMII_DATA.TXDATA[5]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"002A"
    )
    port map (
      I0 => p_1_in36_in,
      I1 => TX_EVEN,
      I2 => n_0_INSERT_IDLE_reg,
      I3 => I1,
      O => \n_0_NO_QSGMII_DATA.TXDATA[5]_i_1\
    );
\NO_QSGMII_DATA.TXDATA[6]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"5540"
    )
    port map (
      I0 => I1,
      I1 => TX_EVEN,
      I2 => n_0_INSERT_IDLE_reg,
      I3 => p_35_in,
      O => \n_0_NO_QSGMII_DATA.TXDATA[6]_i_1\
    );
\NO_QSGMII_DATA.TXDATA[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BF80"
    )
    port map (
      I0 => DISPARITY,
      I1 => TX_EVEN,
      I2 => n_0_INSERT_IDLE_reg,
      I3 => p_0_in37_in,
      O => \n_0_NO_QSGMII_DATA.TXDATA[7]_i_1\
    );
\NO_QSGMII_DATA.TXDATA_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_NO_QSGMII_DATA.TXDATA[0]_i_1\,
      Q => TXDATA(0),
      R => I1
    );
\NO_QSGMII_DATA.TXDATA_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_NO_QSGMII_DATA.TXDATA[1]_i_1\,
      Q => TXDATA(1),
      R => '0'
    );
\NO_QSGMII_DATA.TXDATA_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_NO_QSGMII_DATA.TXDATA[2]_i_1\,
      Q => TXDATA(2),
      R => I1
    );
\NO_QSGMII_DATA.TXDATA_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_NO_QSGMII_DATA.TXDATA[3]_i_1\,
      Q => TXDATA(3),
      R => '0'
    );
\NO_QSGMII_DATA.TXDATA_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_NO_QSGMII_DATA.TXDATA[4]_i_1\,
      Q => TXDATA(4),
      R => I1
    );
\NO_QSGMII_DATA.TXDATA_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_NO_QSGMII_DATA.TXDATA[5]_i_1\,
      Q => TXDATA(5),
      R => '0'
    );
\NO_QSGMII_DATA.TXDATA_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_NO_QSGMII_DATA.TXDATA[6]_i_1\,
      Q => TXDATA(6),
      R => '0'
    );
\NO_QSGMII_DATA.TXDATA_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_NO_QSGMII_DATA.TXDATA[7]_i_1\,
      Q => TXDATA(7),
      R => I1
    );
\NO_QSGMII_DISP.DISPARITY_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0009090900F6F6F6"
    )
    port map (
      I0 => \n_0_NO_QSGMII_DISP.DISPARITY_i_2\,
      I1 => \n_0_NO_QSGMII_DISP.DISPARITY_i_3\,
      I2 => K28p5,
      I3 => n_0_INSERT_IDLE_reg,
      I4 => TX_EVEN,
      I5 => DISPARITY,
      O => \n_0_NO_QSGMII_DISP.DISPARITY_i_1\
    );
\NO_QSGMII_DISP.DISPARITY_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"E8819117"
    )
    port map (
      I0 => p_1_in,
      I1 => \n_0_CODE_GRP_reg[0]\,
      I2 => p_1_in1_in,
      I3 => p_0_in,
      I4 => p_0_in18_in,
      O => \n_0_NO_QSGMII_DISP.DISPARITY_i_2\
    );
\NO_QSGMII_DISP.DISPARITY_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"83"
    )
    port map (
      I0 => p_0_in37_in,
      I1 => p_1_in36_in,
      I2 => p_35_in,
      O => \n_0_NO_QSGMII_DISP.DISPARITY_i_3\
    );
\NO_QSGMII_DISP.DISPARITY_reg\: unisim.vcomponents.FDSE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_NO_QSGMII_DISP.DISPARITY_i_1\,
      Q => DISPARITY,
      S => I1
    );
\R_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0D0D0D0C0C0C0C0C"
    )
    port map (
      I0 => S,
      I1 => T,
      I2 => I1,
      I3 => TX_ER_REG1,
      I4 => TX_EVEN,
      I5 => n_0_R_reg,
      O => \n_0_R_i_1__0\
    );
R_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_R_i_1__0\,
      Q => n_0_R_reg,
      R => '0'
    );
SYNC_DISPARITY_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2F202F2F2F202F20"
    )
    port map (
      I0 => TX_EVEN,
      I1 => \n_0_CODE_GRP_CNT_reg[1]\,
      I2 => XMIT_CONFIG_INT_0,
      I3 => Q(2),
      I4 => n_0_TX_PACKET_reg,
      I5 => \n_0_CODE_GRP[6]_i_2\,
      O => n_0_SYNC_DISPARITY_i_1
    );
SYNC_DISPARITY_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => n_0_SYNC_DISPARITY_i_1,
      Q => n_0_SYNC_DISPARITY_reg,
      R => '0'
    );
\S_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8888A8AA88888888"
    )
    port map (
      I0 => n_0_XMIT_DATA_INT_reg,
      I1 => TRIGGER_S,
      I2 => TX_ER_REG1,
      I3 => TX_EVEN,
      I4 => TX_EN_REG1,
      I5 => gmii_tx_en,
      O => S0
    );
S_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => S0,
      Q => S,
      R => I1
    );
TRIGGER_S_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0400"
    )
    port map (
      I0 => TX_EN_REG1,
      I1 => gmii_tx_en,
      I2 => TX_ER_REG1,
      I3 => TX_EVEN,
      O => TRIGGER_S0
    );
TRIGGER_S_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => TRIGGER_S0,
      Q => TRIGGER_S,
      R => I1
    );
TRIGGER_T_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => TX_EN_REG1,
      I1 => gmii_tx_en,
      O => p_49_in
    );
TRIGGER_T_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => p_49_in,
      Q => TRIGGER_T,
      R => I1
    );
\TXD_REG1_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => gmii_txd(0),
      Q => TXD_REG1(0),
      R => '0'
    );
\TXD_REG1_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => gmii_txd(1),
      Q => TXD_REG1(1),
      R => '0'
    );
\TXD_REG1_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => gmii_txd(2),
      Q => TXD_REG1(2),
      R => '0'
    );
\TXD_REG1_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => gmii_txd(3),
      Q => TXD_REG1(3),
      R => '0'
    );
\TXD_REG1_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => gmii_txd(4),
      Q => TXD_REG1(4),
      R => '0'
    );
\TXD_REG1_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => gmii_txd(5),
      Q => TXD_REG1(5),
      R => '0'
    );
\TXD_REG1_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => gmii_txd(6),
      Q => TXD_REG1(6),
      R => '0'
    );
\TXD_REG1_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => gmii_txd(7),
      Q => TXD_REG1(7),
      R => '0'
    );
\TX_CONFIG[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
    port map (
      I0 => I4,
      I1 => \n_0_CODE_GRP_CNT_reg[1]\,
      I2 => TX_EVEN,
      I3 => TX_CONFIG(0),
      O => \n_0_TX_CONFIG[0]_i_1\
    );
\TX_CONFIG[11]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
    port map (
      I0 => I3,
      I1 => \n_0_CODE_GRP_CNT_reg[1]\,
      I2 => TX_EVEN,
      I3 => TX_CONFIG(11),
      O => \n_0_TX_CONFIG[11]_i_1\
    );
\TX_CONFIG[14]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
    port map (
      I0 => I2,
      I1 => \n_0_CODE_GRP_CNT_reg[1]\,
      I2 => TX_EVEN,
      I3 => TX_CONFIG(14),
      O => \n_0_TX_CONFIG[14]_i_1\
    );
\TX_CONFIG_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_TX_CONFIG[0]_i_1\,
      Q => TX_CONFIG(0),
      R => I1
    );
\TX_CONFIG_reg[11]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_TX_CONFIG[11]_i_1\,
      Q => TX_CONFIG(11),
      R => I1
    );
\TX_CONFIG_reg[14]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_TX_CONFIG[14]_i_1\,
      Q => TX_CONFIG(14),
      R => I1
    );
TX_EN_REG1_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => gmii_tx_en,
      Q => TX_EN_REG1,
      R => '0'
    );
TX_ER_REG1_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => gmii_tx_er,
      Q => TX_ER_REG1,
      R => '0'
    );
TX_PACKET_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"5150"
    )
    port map (
      I0 => I1,
      I1 => T,
      I2 => S,
      I3 => n_0_TX_PACKET_reg,
      O => n_0_TX_PACKET_i_1
    );
TX_PACKET_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => n_0_TX_PACKET_i_1,
      Q => n_0_TX_PACKET_reg,
      R => '0'
    );
\T_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888888FFF88888"
    )
    port map (
      I0 => n_0_V_reg,
      I1 => TRIGGER_T,
      I2 => S,
      I3 => n_0_TX_PACKET_reg,
      I4 => TX_EN_REG1,
      I5 => gmii_tx_en,
      O => T0
    );
T_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => T0,
      Q => T,
      R => I1
    );
\USE_ROCKET_IO.NO_1588.RXCHARISCOMMA_INT_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => TXCHARISK_INT,
      I1 => Q(1),
      I2 => rxchariscomma(0),
      O => O8
    );
\USE_ROCKET_IO.NO_1588.RXCHARISK_INT_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => TXCHARISK_INT,
      I1 => Q(1),
      I2 => rxcharisk(0),
      O => O7
    );
\USE_ROCKET_IO.NO_1588.RXDATA_INT[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => TXDATA(0),
      I1 => Q(1),
      I2 => rxdata(0),
      O => O9(0)
    );
\USE_ROCKET_IO.NO_1588.RXDATA_INT[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => TXDATA(1),
      I1 => Q(1),
      I2 => rxdata(1),
      O => O9(1)
    );
\USE_ROCKET_IO.NO_1588.RXDATA_INT[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => TXDATA(2),
      I1 => Q(1),
      I2 => rxdata(2),
      O => O9(2)
    );
\USE_ROCKET_IO.NO_1588.RXDATA_INT[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => TXDATA(3),
      I1 => Q(1),
      I2 => rxdata(3),
      O => O9(3)
    );
\USE_ROCKET_IO.NO_1588.RXDATA_INT[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => TXDATA(4),
      I1 => Q(1),
      I2 => rxdata(4),
      O => O9(4)
    );
\USE_ROCKET_IO.NO_1588.RXDATA_INT[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => TXDATA(5),
      I1 => Q(1),
      I2 => rxdata(5),
      O => O9(5)
    );
\USE_ROCKET_IO.NO_1588.RXDATA_INT[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => TXDATA(6),
      I1 => Q(1),
      I2 => rxdata(6),
      O => O9(6)
    );
\USE_ROCKET_IO.NO_1588.RXDATA_INT[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => TXDATA(7),
      I1 => Q(1),
      I2 => rxdata(7),
      O => O9(7)
    );
\USE_ROCKET_IO.TXCHARDISPMODE_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => TX_EVEN,
      I1 => Q(1),
      I2 => TXCHARDISPMODE_INT,
      O => O1
    );
\USE_ROCKET_IO.TXCHARDISPVAL_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"02"
    )
    port map (
      I0 => TXCHARDISPVAL,
      I1 => Q(1),
      I2 => I1,
      O => O11
    );
\USE_ROCKET_IO.TXCHARISK_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => TX_EVEN,
      I1 => Q(1),
      I2 => TXCHARISK_INT,
      O => O6
    );
\USE_ROCKET_IO.TXDATA[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"02"
    )
    port map (
      I0 => TXDATA(0),
      I1 => Q(1),
      I2 => I1,
      O => D(0)
    );
\USE_ROCKET_IO.TXDATA[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"02"
    )
    port map (
      I0 => TXDATA(1),
      I1 => Q(1),
      I2 => I1,
      O => D(1)
    );
\USE_ROCKET_IO.TXDATA[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"02"
    )
    port map (
      I0 => TXDATA(2),
      I1 => Q(1),
      I2 => I1,
      O => O5
    );
\USE_ROCKET_IO.TXDATA[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"02"
    )
    port map (
      I0 => TXDATA(3),
      I1 => Q(1),
      I2 => I1,
      O => O4
    );
\USE_ROCKET_IO.TXDATA[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"54"
    )
    port map (
      I0 => I1,
      I1 => TXDATA(4),
      I2 => Q(1),
      O => D(2)
    );
\USE_ROCKET_IO.TXDATA[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"02"
    )
    port map (
      I0 => TXDATA(5),
      I1 => Q(1),
      I2 => I1,
      O => O3
    );
\USE_ROCKET_IO.TXDATA[6]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"003A"
    )
    port map (
      I0 => TXDATA(6),
      I1 => TX_EVEN,
      I2 => Q(1),
      I3 => I1,
      O => D(3)
    );
\USE_ROCKET_IO.TXDATA[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => Q(1),
      I1 => TX_EVEN,
      I2 => I1,
      O => O10
    );
\USE_ROCKET_IO.TXDATA[7]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"02"
    )
    port map (
      I0 => TXDATA(7),
      I1 => Q(1),
      I2 => I1,
      O => O2
    );
V_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00FF00D000D000D0"
    )
    port map (
      I0 => n_0_V_i_2,
      I1 => n_0_V_i_3,
      I2 => n_0_XMIT_DATA_INT_reg,
      I3 => I1,
      I4 => S,
      I5 => n_0_V_reg,
      O => n_0_V_i_1
    );
V_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"55557555FFFF7555"
    )
    port map (
      I0 => gmii_tx_er,
      I1 => n_0_V_i_4,
      I2 => gmii_txd(1),
      I3 => gmii_txd(0),
      I4 => gmii_tx_en,
      I5 => n_0_TX_PACKET_reg,
      O => n_0_V_i_2
    );
V_i_3: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
    port map (
      I0 => n_0_TX_PACKET_reg,
      I1 => TX_ER_REG1,
      I2 => TX_EN_REG1,
      O => n_0_V_i_3
    );
V_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFEFFFFFFFFFFFF"
    )
    port map (
      I0 => gmii_txd(7),
      I1 => gmii_txd(4),
      I2 => gmii_txd(6),
      I3 => gmii_txd(5),
      I4 => gmii_txd(2),
      I5 => gmii_txd(3),
      O => n_0_V_i_4
    );
V_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => n_0_V_i_1,
      Q => n_0_V_reg,
      R => '0'
    );
XMIT_CONFIG_INT_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFF8A0000008A"
    )
    port map (
      I0 => XMIT_CONFIG_INT,
      I1 => Q(3),
      I2 => Q(0),
      I3 => \n_0_CODE_GRP_CNT_reg[1]\,
      I4 => TX_EVEN,
      I5 => XMIT_CONFIG_INT_0,
      O => n_0_XMIT_CONFIG_INT_i_1
    );
XMIT_CONFIG_INT_reg: unisim.vcomponents.FDSE
    port map (
      C => userclk2,
      CE => '1',
      D => n_0_XMIT_CONFIG_INT_i_1,
      Q => XMIT_CONFIG_INT_0,
      S => I1
    );
\XMIT_DATA_INT_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFBA000000BA"
    )
    port map (
      I0 => XMIT_DATA_INT,
      I1 => Q(3),
      I2 => Q(0),
      I3 => \n_0_CODE_GRP_CNT_reg[1]\,
      I4 => TX_EVEN,
      I5 => n_0_XMIT_DATA_INT_reg,
      O => \n_0_XMIT_DATA_INT_i_1__0\
    );
XMIT_DATA_INT_reg: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_XMIT_DATA_INT_i_1__0\,
      Q => n_0_XMIT_DATA_INT_reg,
      R => I1
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gmii_to_sgmii_gmii_to_sgmii_clocking is
  port (
    AS : out STD_LOGIC_VECTOR ( 0 to 0 );
    mmcm_locked : out STD_LOGIC;
    gtrefclk : out STD_LOGIC;
    userclk : out STD_LOGIC;
    userclk2 : out STD_LOGIC;
    reset : in STD_LOGIC;
    gtrefclk_p : in STD_LOGIC;
    gtrefclk_n : in STD_LOGIC;
    txoutclk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of gmii_to_sgmii_gmii_to_sgmii_clocking : entity is "gmii_to_sgmii_clocking";
end gmii_to_sgmii_gmii_to_sgmii_clocking;

architecture STRUCTURE of gmii_to_sgmii_gmii_to_sgmii_clocking is
  signal clkfbout : STD_LOGIC;
  signal clkout0 : STD_LOGIC;
  signal clkout1 : STD_LOGIC;
  signal \^mmcm_locked\ : STD_LOGIC;
  signal txoutclk_bufg : STD_LOGIC;
  signal NLW_ibufds_gtrefclk_ODIV2_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcm_adv_inst_CLKFBOUTB_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcm_adv_inst_CLKFBSTOPPED_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcm_adv_inst_CLKINSTOPPED_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcm_adv_inst_CLKOUT0B_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcm_adv_inst_CLKOUT1B_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcm_adv_inst_CLKOUT2_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcm_adv_inst_CLKOUT2B_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcm_adv_inst_CLKOUT3_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcm_adv_inst_CLKOUT3B_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcm_adv_inst_CLKOUT4_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcm_adv_inst_CLKOUT5_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcm_adv_inst_CLKOUT6_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcm_adv_inst_DRDY_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcm_adv_inst_PSDONE_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcm_adv_inst_DO_UNCONNECTED : STD_LOGIC_VECTOR ( 15 downto 0 );
  attribute box_type : string;
  attribute box_type of bufg_txoutclk : label is "PRIMITIVE";
  attribute box_type of bufg_userclk : label is "PRIMITIVE";
  attribute box_type of bufg_userclk2 : label is "PRIMITIVE";
  attribute box_type of ibufds_gtrefclk : label is "PRIMITIVE";
  attribute box_type of mmcm_adv_inst : label is "PRIMITIVE";
begin
  mmcm_locked <= \^mmcm_locked\;
bufg_txoutclk: unisim.vcomponents.BUFG
    port map (
      I => txoutclk,
      O => txoutclk_bufg
    );
bufg_userclk: unisim.vcomponents.BUFG
    port map (
      I => clkout1,
      O => userclk
    );
bufg_userclk2: unisim.vcomponents.BUFG
    port map (
      I => clkout0,
      O => userclk2
    );
ibufds_gtrefclk: unisim.vcomponents.IBUFDS_GTE2
    generic map(
      CLKCM_CFG => true,
      CLKRCV_TRST => true,
      CLKSWING_CFG => B"11"
    )
    port map (
      CEB => '0',
      I => gtrefclk_p,
      IB => gtrefclk_n,
      O => gtrefclk,
      ODIV2 => NLW_ibufds_gtrefclk_ODIV2_UNCONNECTED
    );
mmcm_adv_inst: unisim.vcomponents.MMCME2_ADV
    generic map(
      BANDWIDTH => "OPTIMIZED",
      CLKFBOUT_MULT_F => 16.000000,
      CLKFBOUT_PHASE => 0.000000,
      CLKFBOUT_USE_FINE_PS => false,
      CLKIN1_PERIOD => 16.000000,
      CLKIN2_PERIOD => 0.000000,
      CLKOUT0_DIVIDE_F => 8.000000,
      CLKOUT0_DUTY_CYCLE => 0.500000,
      CLKOUT0_PHASE => 0.000000,
      CLKOUT0_USE_FINE_PS => false,
      CLKOUT1_DIVIDE => 16,
      CLKOUT1_DUTY_CYCLE => 0.500000,
      CLKOUT1_PHASE => 0.000000,
      CLKOUT1_USE_FINE_PS => false,
      CLKOUT2_DIVIDE => 1,
      CLKOUT2_DUTY_CYCLE => 0.500000,
      CLKOUT2_PHASE => 0.000000,
      CLKOUT2_USE_FINE_PS => false,
      CLKOUT3_DIVIDE => 1,
      CLKOUT3_DUTY_CYCLE => 0.500000,
      CLKOUT3_PHASE => 0.000000,
      CLKOUT3_USE_FINE_PS => false,
      CLKOUT4_CASCADE => false,
      CLKOUT4_DIVIDE => 1,
      CLKOUT4_DUTY_CYCLE => 0.500000,
      CLKOUT4_PHASE => 0.000000,
      CLKOUT4_USE_FINE_PS => false,
      CLKOUT5_DIVIDE => 1,
      CLKOUT5_DUTY_CYCLE => 0.500000,
      CLKOUT5_PHASE => 0.000000,
      CLKOUT5_USE_FINE_PS => false,
      CLKOUT6_DIVIDE => 1,
      CLKOUT6_DUTY_CYCLE => 0.500000,
      CLKOUT6_PHASE => 0.000000,
      CLKOUT6_USE_FINE_PS => false,
      COMPENSATION => "INTERNAL",
      DIVCLK_DIVIDE => 1,
      IS_CLKINSEL_INVERTED => '0',
      IS_PSEN_INVERTED => '0',
      IS_PSINCDEC_INVERTED => '0',
      IS_PWRDWN_INVERTED => '0',
      IS_RST_INVERTED => '0',
      REF_JITTER1 => 0.010000,
      REF_JITTER2 => 0.000000,
      SS_EN => "FALSE",
      SS_MODE => "CENTER_HIGH",
      SS_MOD_PERIOD => 10000,
      STARTUP_WAIT => false
    )
    port map (
      CLKFBIN => clkfbout,
      CLKFBOUT => clkfbout,
      CLKFBOUTB => NLW_mmcm_adv_inst_CLKFBOUTB_UNCONNECTED,
      CLKFBSTOPPED => NLW_mmcm_adv_inst_CLKFBSTOPPED_UNCONNECTED,
      CLKIN1 => txoutclk_bufg,
      CLKIN2 => '0',
      CLKINSEL => '1',
      CLKINSTOPPED => NLW_mmcm_adv_inst_CLKINSTOPPED_UNCONNECTED,
      CLKOUT0 => clkout0,
      CLKOUT0B => NLW_mmcm_adv_inst_CLKOUT0B_UNCONNECTED,
      CLKOUT1 => clkout1,
      CLKOUT1B => NLW_mmcm_adv_inst_CLKOUT1B_UNCONNECTED,
      CLKOUT2 => NLW_mmcm_adv_inst_CLKOUT2_UNCONNECTED,
      CLKOUT2B => NLW_mmcm_adv_inst_CLKOUT2B_UNCONNECTED,
      CLKOUT3 => NLW_mmcm_adv_inst_CLKOUT3_UNCONNECTED,
      CLKOUT3B => NLW_mmcm_adv_inst_CLKOUT3B_UNCONNECTED,
      CLKOUT4 => NLW_mmcm_adv_inst_CLKOUT4_UNCONNECTED,
      CLKOUT5 => NLW_mmcm_adv_inst_CLKOUT5_UNCONNECTED,
      CLKOUT6 => NLW_mmcm_adv_inst_CLKOUT6_UNCONNECTED,
      DADDR(6) => '0',
      DADDR(5) => '0',
      DADDR(4) => '0',
      DADDR(3) => '0',
      DADDR(2) => '0',
      DADDR(1) => '0',
      DADDR(0) => '0',
      DCLK => '0',
      DEN => '0',
      DI(15) => '0',
      DI(14) => '0',
      DI(13) => '0',
      DI(12) => '0',
      DI(11) => '0',
      DI(10) => '0',
      DI(9) => '0',
      DI(8) => '0',
      DI(7) => '0',
      DI(6) => '0',
      DI(5) => '0',
      DI(4) => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '0',
      DO(15 downto 0) => NLW_mmcm_adv_inst_DO_UNCONNECTED(15 downto 0),
      DRDY => NLW_mmcm_adv_inst_DRDY_UNCONNECTED,
      DWE => '0',
      LOCKED => \^mmcm_locked\,
      PSCLK => '0',
      PSDONE => NLW_mmcm_adv_inst_PSDONE_UNCONNECTED,
      PSEN => '0',
      PSINCDEC => '0',
      PWRDWN => '0',
      RST => reset
    );
\pma_reset_pipe[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => reset,
      I1 => \^mmcm_locked\,
      O => AS(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gmii_to_sgmii_gmii_to_sgmii_gt_common is
  port (
    gt0_qplloutclk_out : out STD_LOGIC;
    gt0_qplloutrefclk_out : out STD_LOGIC;
    I1 : in STD_LOGIC;
    independent_clock_bufg : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of gmii_to_sgmii_gmii_to_sgmii_gt_common : entity is "gmii_to_sgmii_gt_common";
end gmii_to_sgmii_gmii_to_sgmii_gt_common;

architecture STRUCTURE of gmii_to_sgmii_gmii_to_sgmii_gt_common is
  signal n_2_gthe2_common_i : STD_LOGIC;
  signal n_5_gthe2_common_i : STD_LOGIC;
  signal NLW_gthe2_common_i_DRPRDY_UNCONNECTED : STD_LOGIC;
  signal NLW_gthe2_common_i_QPLLFBCLKLOST_UNCONNECTED : STD_LOGIC;
  signal NLW_gthe2_common_i_REFCLKOUTMONITOR_UNCONNECTED : STD_LOGIC;
  signal NLW_gthe2_common_i_DRPDO_UNCONNECTED : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal NLW_gthe2_common_i_PMARSVDOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal NLW_gthe2_common_i_QPLLDMONITOR_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 0 );
  attribute box_type : string;
  attribute box_type of gthe2_common_i : label is "PRIMITIVE";
begin
gthe2_common_i: unisim.vcomponents.GTHE2_COMMON
    generic map(
      BIAS_CFG => X"0000040000001050",
      COMMON_CFG => X"0000001C",
      IS_DRPCLK_INVERTED => '0',
      IS_GTGREFCLK_INVERTED => '0',
      IS_QPLLLOCKDETCLK_INVERTED => '0',
      QPLL_CFG => X"04801C7",
      QPLL_CLKOUT_CFG => B"1111",
      QPLL_COARSE_FREQ_OVRD => B"010000",
      QPLL_COARSE_FREQ_OVRD_EN => '0',
      QPLL_CP => B"0000011111",
      QPLL_CP_MONITOR_EN => '0',
      QPLL_DMONITOR_SEL => '0',
      QPLL_FBDIV => B"0000100000",
      QPLL_FBDIV_MONITOR_EN => '0',
      QPLL_FBDIV_RATIO => '1',
      QPLL_INIT_CFG => X"000006",
      QPLL_LOCK_CFG => X"05E8",
      QPLL_LPF => B"1111",
      QPLL_REFCLK_DIV => 1,
      QPLL_RP_COMP => '0',
      QPLL_VTRL_RESET => B"00",
      RCAL_CFG => B"00",
      RSVD_ATTR0 => X"0000",
      RSVD_ATTR1 => X"0000",
      SIM_QPLLREFCLK_SEL => B"001",
      SIM_RESET_SPEEDUP => "FALSE",
      SIM_VERSION => "2.0"
    )
    port map (
      BGBYPASSB => '1',
      BGMONITORENB => '1',
      BGPDB => '1',
      BGRCALOVRD(4) => '1',
      BGRCALOVRD(3) => '1',
      BGRCALOVRD(2) => '1',
      BGRCALOVRD(1) => '1',
      BGRCALOVRD(0) => '1',
      BGRCALOVRDENB => '1',
      DRPADDR(7) => '0',
      DRPADDR(6) => '0',
      DRPADDR(5) => '0',
      DRPADDR(4) => '0',
      DRPADDR(3) => '0',
      DRPADDR(2) => '0',
      DRPADDR(1) => '0',
      DRPADDR(0) => '0',
      DRPCLK => '0',
      DRPDI(15) => '0',
      DRPDI(14) => '0',
      DRPDI(13) => '0',
      DRPDI(12) => '0',
      DRPDI(11) => '0',
      DRPDI(10) => '0',
      DRPDI(9) => '0',
      DRPDI(8) => '0',
      DRPDI(7) => '0',
      DRPDI(6) => '0',
      DRPDI(5) => '0',
      DRPDI(4) => '0',
      DRPDI(3) => '0',
      DRPDI(2) => '0',
      DRPDI(1) => '0',
      DRPDI(0) => '0',
      DRPDO(15 downto 0) => NLW_gthe2_common_i_DRPDO_UNCONNECTED(15 downto 0),
      DRPEN => '0',
      DRPRDY => NLW_gthe2_common_i_DRPRDY_UNCONNECTED,
      DRPWE => '0',
      GTGREFCLK => '0',
      GTNORTHREFCLK0 => '0',
      GTNORTHREFCLK1 => '0',
      GTREFCLK0 => I1,
      GTREFCLK1 => '0',
      GTSOUTHREFCLK0 => '0',
      GTSOUTHREFCLK1 => '0',
      PMARSVD(7) => '0',
      PMARSVD(6) => '0',
      PMARSVD(5) => '0',
      PMARSVD(4) => '0',
      PMARSVD(3) => '0',
      PMARSVD(2) => '0',
      PMARSVD(1) => '0',
      PMARSVD(0) => '0',
      PMARSVDOUT(15 downto 0) => NLW_gthe2_common_i_PMARSVDOUT_UNCONNECTED(15 downto 0),
      QPLLDMONITOR(7 downto 0) => NLW_gthe2_common_i_QPLLDMONITOR_UNCONNECTED(7 downto 0),
      QPLLFBCLKLOST => NLW_gthe2_common_i_QPLLFBCLKLOST_UNCONNECTED,
      QPLLLOCK => n_2_gthe2_common_i,
      QPLLLOCKDETCLK => independent_clock_bufg,
      QPLLLOCKEN => '1',
      QPLLOUTCLK => gt0_qplloutclk_out,
      QPLLOUTREFCLK => gt0_qplloutrefclk_out,
      QPLLOUTRESET => '0',
      QPLLPD => '1',
      QPLLREFCLKLOST => n_5_gthe2_common_i,
      QPLLREFCLKSEL(2) => '0',
      QPLLREFCLKSEL(1) => '0',
      QPLLREFCLKSEL(0) => '1',
      QPLLRESET => Q(0),
      QPLLRSVD1(15) => '0',
      QPLLRSVD1(14) => '0',
      QPLLRSVD1(13) => '0',
      QPLLRSVD1(12) => '0',
      QPLLRSVD1(11) => '0',
      QPLLRSVD1(10) => '0',
      QPLLRSVD1(9) => '0',
      QPLLRSVD1(8) => '0',
      QPLLRSVD1(7) => '0',
      QPLLRSVD1(6) => '0',
      QPLLRSVD1(5) => '0',
      QPLLRSVD1(4) => '0',
      QPLLRSVD1(3) => '0',
      QPLLRSVD1(2) => '0',
      QPLLRSVD1(1) => '0',
      QPLLRSVD1(0) => '0',
      QPLLRSVD2(4) => '1',
      QPLLRSVD2(3) => '1',
      QPLLRSVD2(2) => '1',
      QPLLRSVD2(1) => '1',
      QPLLRSVD2(0) => '1',
      RCALENB => '1',
      REFCLKOUTMONITOR => NLW_gthe2_common_i_REFCLKOUTMONITOR_UNCONNECTED
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gmii_to_sgmii_gmii_to_sgmii_johnson_cntr is
  port (
    clk_div10 : out STD_LOGIC;
    O1 : out STD_LOGIC;
    O2 : out STD_LOGIC;
    O3 : out STD_LOGIC;
    CLK : in STD_LOGIC;
    clk12_5_reg : in STD_LOGIC;
    speed_is_10_100_fall : in STD_LOGIC;
    speed_is_100_fall : in STD_LOGIC;
    I1 : in STD_LOGIC;
    reset_fall : in STD_LOGIC;
    reset_out : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of gmii_to_sgmii_gmii_to_sgmii_johnson_cntr : entity is "gmii_to_sgmii_johnson_cntr";
end gmii_to_sgmii_gmii_to_sgmii_johnson_cntr;

architecture STRUCTURE of gmii_to_sgmii_gmii_to_sgmii_johnson_cntr is
  signal \^clk_div10\ : STD_LOGIC;
  signal \n_0_reg1_i_1__0\ : STD_LOGIC;
  signal n_0_reg5_reg : STD_LOGIC;
  signal reg1 : STD_LOGIC;
  signal reg2 : STD_LOGIC;
  signal reg4 : STD_LOGIC;
  signal reg5 : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of clk_en_12_5_fall_i_1 : label is "soft_lutpair72";
  attribute SOFT_HLUTNM of clk_en_12_5_rise_i_1 : label is "soft_lutpair72";
begin
  clk_div10 <= \^clk_div10\;
clk_en_12_5_fall_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => clk12_5_reg,
      I1 => \^clk_div10\,
      O => O1
    );
clk_en_12_5_rise_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \^clk_div10\,
      I1 => clk12_5_reg,
      O => O2
    );
\reg1_i_1__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => n_0_reg5_reg,
      O => \n_0_reg1_i_1__0\
    );
reg1_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => \n_0_reg1_i_1__0\,
      Q => reg1,
      R => reg5
    );
reg2_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => reg1,
      Q => reg2,
      R => reg5
    );
reg3_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => reg2,
      Q => \^clk_div10\,
      R => reg5
    );
reg4_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => \^clk_div10\,
      Q => reg4,
      R => reg5
    );
reg5_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BA"
    )
    port map (
      I0 => reset_out,
      I1 => reg4,
      I2 => n_0_reg5_reg,
      O => reg5
    );
reg5_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => reg4,
      Q => n_0_reg5_reg,
      R => reg5
    );
sgmii_clk_f_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000DFD5"
    )
    port map (
      I0 => speed_is_10_100_fall,
      I1 => \^clk_div10\,
      I2 => speed_is_100_fall,
      I3 => I1,
      I4 => reset_fall,
      O => O3
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gmii_to_sgmii_gmii_to_sgmii_johnson_cntr_35 is
  port (
    O1 : out STD_LOGIC;
    O2 : out STD_LOGIC;
    sgmii_clk_r0_out : out STD_LOGIC;
    clk_en : in STD_LOGIC;
    CLK : in STD_LOGIC;
    clk1_25_reg : in STD_LOGIC;
    I1 : in STD_LOGIC;
    data_out : in STD_LOGIC;
    clk_div10 : in STD_LOGIC;
    reset_out : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of gmii_to_sgmii_gmii_to_sgmii_johnson_cntr_35 : entity is "gmii_to_sgmii_johnson_cntr";
end gmii_to_sgmii_gmii_to_sgmii_johnson_cntr_35;

architecture STRUCTURE of gmii_to_sgmii_gmii_to_sgmii_johnson_cntr_35 is
  signal \^o1\ : STD_LOGIC;
  signal n_0_reg1_i_1 : STD_LOGIC;
  signal n_0_reg1_reg : STD_LOGIC;
  signal n_0_reg2_reg : STD_LOGIC;
  signal n_0_reg5_reg : STD_LOGIC;
  signal reg4 : STD_LOGIC;
  signal reg5 : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of clk_en_1_25_fall_i_1 : label is "soft_lutpair73";
  attribute SOFT_HLUTNM of sgmii_clk_r_i_1 : label is "soft_lutpair73";
begin
  O1 <= \^o1\;
clk_en_1_25_fall_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => clk1_25_reg,
      I1 => \^o1\,
      O => O2
    );
reg1_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => n_0_reg5_reg,
      O => n_0_reg1_i_1
    );
reg1_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => clk_en,
      D => n_0_reg1_i_1,
      Q => n_0_reg1_reg,
      R => reg5
    );
reg2_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => clk_en,
      D => n_0_reg1_reg,
      Q => n_0_reg2_reg,
      R => reg5
    );
reg3_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => clk_en,
      D => n_0_reg2_reg,
      Q => \^o1\,
      R => reg5
    );
reg4_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => clk_en,
      D => \^o1\,
      Q => reg4,
      R => reg5
    );
\reg5_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BAAA"
    )
    port map (
      I0 => reset_out,
      I1 => reg4,
      I2 => n_0_reg5_reg,
      I3 => clk_en,
      O => reg5
    );
reg5_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => clk_en,
      D => reg4,
      Q => n_0_reg5_reg,
      R => reg5
    );
sgmii_clk_r_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => I1,
      I1 => \^o1\,
      I2 => data_out,
      I3 => clk_div10,
      O => sgmii_clk_r0_out
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gmii_to_sgmii_gmii_to_sgmii_reset_sync is
  port (
    reset_out : out STD_LOGIC;
    I2 : in STD_LOGIC;
    encommaalign : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of gmii_to_sgmii_gmii_to_sgmii_reset_sync : entity is "gmii_to_sgmii_reset_sync";
end gmii_to_sgmii_gmii_to_sgmii_reset_sync;

architecture STRUCTURE of gmii_to_sgmii_gmii_to_sgmii_reset_sync is
  signal reset_sync_reg1 : STD_LOGIC;
  signal reset_sync_reg2 : STD_LOGIC;
  signal reset_sync_reg3 : STD_LOGIC;
  signal reset_sync_reg4 : STD_LOGIC;
  signal reset_sync_reg5 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of reset_sync1 : label is std.standard.true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of reset_sync1 : label is "no";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of reset_sync1 : label is "FDP";
  attribute box_type : string;
  attribute box_type of reset_sync1 : label is "PRIMITIVE";
  attribute ASYNC_REG of reset_sync2 : label is std.standard.true;
  attribute SHREG_EXTRACT of reset_sync2 : label is "no";
  attribute XILINX_LEGACY_PRIM of reset_sync2 : label is "FDP";
  attribute box_type of reset_sync2 : label is "PRIMITIVE";
  attribute ASYNC_REG of reset_sync3 : label is std.standard.true;
  attribute SHREG_EXTRACT of reset_sync3 : label is "no";
  attribute XILINX_LEGACY_PRIM of reset_sync3 : label is "FDP";
  attribute box_type of reset_sync3 : label is "PRIMITIVE";
  attribute ASYNC_REG of reset_sync4 : label is std.standard.true;
  attribute SHREG_EXTRACT of reset_sync4 : label is "no";
  attribute XILINX_LEGACY_PRIM of reset_sync4 : label is "FDP";
  attribute box_type of reset_sync4 : label is "PRIMITIVE";
  attribute ASYNC_REG of reset_sync5 : label is std.standard.true;
  attribute SHREG_EXTRACT of reset_sync5 : label is "no";
  attribute XILINX_LEGACY_PRIM of reset_sync5 : label is "FDP";
  attribute box_type of reset_sync5 : label is "PRIMITIVE";
  attribute ASYNC_REG of reset_sync6 : label is std.standard.true;
  attribute SHREG_EXTRACT of reset_sync6 : label is "no";
  attribute XILINX_LEGACY_PRIM of reset_sync6 : label is "FDP";
  attribute box_type of reset_sync6 : label is "PRIMITIVE";
begin
reset_sync1: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => I2,
      CE => '1',
      D => '0',
      PRE => encommaalign,
      Q => reset_sync_reg1
    );
reset_sync2: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => I2,
      CE => '1',
      D => reset_sync_reg1,
      PRE => encommaalign,
      Q => reset_sync_reg2
    );
reset_sync3: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => I2,
      CE => '1',
      D => reset_sync_reg2,
      PRE => encommaalign,
      Q => reset_sync_reg3
    );
reset_sync4: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => I2,
      CE => '1',
      D => reset_sync_reg3,
      PRE => encommaalign,
      Q => reset_sync_reg4
    );
reset_sync5: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => I2,
      CE => '1',
      D => reset_sync_reg4,
      PRE => encommaalign,
      Q => reset_sync_reg5
    );
reset_sync6: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => I2,
      CE => '1',
      D => reset_sync_reg5,
      PRE => '0',
      Q => reset_out
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gmii_to_sgmii_gmii_to_sgmii_reset_sync_0 is
  port (
    SR : out STD_LOGIC_VECTOR ( 0 to 0 );
    reset_out : out STD_LOGIC;
    O1 : out STD_LOGIC_VECTOR ( 0 to 0 );
    initialize_ram_complete_pulse : in STD_LOGIC;
    initialize_ram_complete : in STD_LOGIC;
    I2 : in STD_LOGIC;
    reset_in : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of gmii_to_sgmii_gmii_to_sgmii_reset_sync_0 : entity is "gmii_to_sgmii_reset_sync";
end gmii_to_sgmii_gmii_to_sgmii_reset_sync_0;

architecture STRUCTURE of gmii_to_sgmii_gmii_to_sgmii_reset_sync_0 is
  signal \^reset_out\ : STD_LOGIC;
  signal reset_sync_reg1 : STD_LOGIC;
  signal reset_sync_reg2 : STD_LOGIC;
  signal reset_sync_reg3 : STD_LOGIC;
  signal reset_sync_reg4 : STD_LOGIC;
  signal reset_sync_reg5 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of reset_sync1 : label is std.standard.true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of reset_sync1 : label is "no";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of reset_sync1 : label is "FDP";
  attribute box_type : string;
  attribute box_type of reset_sync1 : label is "PRIMITIVE";
  attribute ASYNC_REG of reset_sync2 : label is std.standard.true;
  attribute SHREG_EXTRACT of reset_sync2 : label is "no";
  attribute XILINX_LEGACY_PRIM of reset_sync2 : label is "FDP";
  attribute box_type of reset_sync2 : label is "PRIMITIVE";
  attribute ASYNC_REG of reset_sync3 : label is std.standard.true;
  attribute SHREG_EXTRACT of reset_sync3 : label is "no";
  attribute XILINX_LEGACY_PRIM of reset_sync3 : label is "FDP";
  attribute box_type of reset_sync3 : label is "PRIMITIVE";
  attribute ASYNC_REG of reset_sync4 : label is std.standard.true;
  attribute SHREG_EXTRACT of reset_sync4 : label is "no";
  attribute XILINX_LEGACY_PRIM of reset_sync4 : label is "FDP";
  attribute box_type of reset_sync4 : label is "PRIMITIVE";
  attribute ASYNC_REG of reset_sync5 : label is std.standard.true;
  attribute SHREG_EXTRACT of reset_sync5 : label is "no";
  attribute XILINX_LEGACY_PRIM of reset_sync5 : label is "FDP";
  attribute box_type of reset_sync5 : label is "PRIMITIVE";
  attribute ASYNC_REG of reset_sync6 : label is std.standard.true;
  attribute SHREG_EXTRACT of reset_sync6 : label is "no";
  attribute XILINX_LEGACY_PRIM of reset_sync6 : label is "FDP";
  attribute box_type of reset_sync6 : label is "PRIMITIVE";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \wr_addr_plus2[4]_i_1\ : label is "soft_lutpair112";
  attribute SOFT_HLUTNM of \wr_data_reg[28]_i_1\ : label is "soft_lutpair112";
begin
  reset_out <= \^reset_out\;
reset_sync1: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => I2,
      CE => '1',
      D => '0',
      PRE => reset_in,
      Q => reset_sync_reg1
    );
reset_sync2: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => I2,
      CE => '1',
      D => reset_sync_reg1,
      PRE => reset_in,
      Q => reset_sync_reg2
    );
reset_sync3: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => I2,
      CE => '1',
      D => reset_sync_reg2,
      PRE => reset_in,
      Q => reset_sync_reg3
    );
reset_sync4: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => I2,
      CE => '1',
      D => reset_sync_reg3,
      PRE => reset_in,
      Q => reset_sync_reg4
    );
reset_sync5: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => I2,
      CE => '1',
      D => reset_sync_reg4,
      PRE => reset_in,
      Q => reset_sync_reg5
    );
reset_sync6: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => I2,
      CE => '1',
      D => reset_sync_reg5,
      PRE => '0',
      Q => \^reset_out\
    );
\wr_addr_plus2[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \^reset_out\,
      I1 => initialize_ram_complete_pulse,
      O => SR(0)
    );
\wr_data_reg[28]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => \^reset_out\,
      I1 => initialize_ram_complete,
      O => O1(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gmii_to_sgmii_gmii_to_sgmii_reset_sync_1 is
  port (
    reset_out : out STD_LOGIC;
    I3 : in STD_LOGIC;
    SR : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of gmii_to_sgmii_gmii_to_sgmii_reset_sync_1 : entity is "gmii_to_sgmii_reset_sync";
end gmii_to_sgmii_gmii_to_sgmii_reset_sync_1;

architecture STRUCTURE of gmii_to_sgmii_gmii_to_sgmii_reset_sync_1 is
  signal reset_sync_reg1 : STD_LOGIC;
  signal reset_sync_reg2 : STD_LOGIC;
  signal reset_sync_reg3 : STD_LOGIC;
  signal reset_sync_reg4 : STD_LOGIC;
  signal reset_sync_reg5 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of reset_sync1 : label is std.standard.true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of reset_sync1 : label is "no";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of reset_sync1 : label is "FDP";
  attribute box_type : string;
  attribute box_type of reset_sync1 : label is "PRIMITIVE";
  attribute ASYNC_REG of reset_sync2 : label is std.standard.true;
  attribute SHREG_EXTRACT of reset_sync2 : label is "no";
  attribute XILINX_LEGACY_PRIM of reset_sync2 : label is "FDP";
  attribute box_type of reset_sync2 : label is "PRIMITIVE";
  attribute ASYNC_REG of reset_sync3 : label is std.standard.true;
  attribute SHREG_EXTRACT of reset_sync3 : label is "no";
  attribute XILINX_LEGACY_PRIM of reset_sync3 : label is "FDP";
  attribute box_type of reset_sync3 : label is "PRIMITIVE";
  attribute ASYNC_REG of reset_sync4 : label is std.standard.true;
  attribute SHREG_EXTRACT of reset_sync4 : label is "no";
  attribute XILINX_LEGACY_PRIM of reset_sync4 : label is "FDP";
  attribute box_type of reset_sync4 : label is "PRIMITIVE";
  attribute ASYNC_REG of reset_sync5 : label is std.standard.true;
  attribute SHREG_EXTRACT of reset_sync5 : label is "no";
  attribute XILINX_LEGACY_PRIM of reset_sync5 : label is "FDP";
  attribute box_type of reset_sync5 : label is "PRIMITIVE";
  attribute ASYNC_REG of reset_sync6 : label is std.standard.true;
  attribute SHREG_EXTRACT of reset_sync6 : label is "no";
  attribute XILINX_LEGACY_PRIM of reset_sync6 : label is "FDP";
  attribute box_type of reset_sync6 : label is "PRIMITIVE";
begin
reset_sync1: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => I3,
      CE => '1',
      D => '0',
      PRE => SR(0),
      Q => reset_sync_reg1
    );
reset_sync2: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => I3,
      CE => '1',
      D => reset_sync_reg1,
      PRE => SR(0),
      Q => reset_sync_reg2
    );
reset_sync3: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => I3,
      CE => '1',
      D => reset_sync_reg2,
      PRE => SR(0),
      Q => reset_sync_reg3
    );
reset_sync4: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => I3,
      CE => '1',
      D => reset_sync_reg3,
      PRE => SR(0),
      Q => reset_sync_reg4
    );
reset_sync5: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => I3,
      CE => '1',
      D => reset_sync_reg4,
      PRE => SR(0),
      Q => reset_sync_reg5
    );
reset_sync6: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => I3,
      CE => '1',
      D => reset_sync_reg5,
      PRE => '0',
      Q => reset_out
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gmii_to_sgmii_gmii_to_sgmii_reset_sync_16 is
  port (
    reset_out : out STD_LOGIC;
    CLK : in STD_LOGIC;
    data_in : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of gmii_to_sgmii_gmii_to_sgmii_reset_sync_16 : entity is "gmii_to_sgmii_reset_sync";
end gmii_to_sgmii_gmii_to_sgmii_reset_sync_16;

architecture STRUCTURE of gmii_to_sgmii_gmii_to_sgmii_reset_sync_16 is
  signal reset_sync_reg1 : STD_LOGIC;
  signal reset_sync_reg2 : STD_LOGIC;
  signal reset_sync_reg3 : STD_LOGIC;
  signal reset_sync_reg4 : STD_LOGIC;
  signal reset_sync_reg5 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of reset_sync1 : label is std.standard.true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of reset_sync1 : label is "no";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of reset_sync1 : label is "FDP";
  attribute box_type : string;
  attribute box_type of reset_sync1 : label is "PRIMITIVE";
  attribute ASYNC_REG of reset_sync2 : label is std.standard.true;
  attribute SHREG_EXTRACT of reset_sync2 : label is "no";
  attribute XILINX_LEGACY_PRIM of reset_sync2 : label is "FDP";
  attribute box_type of reset_sync2 : label is "PRIMITIVE";
  attribute ASYNC_REG of reset_sync3 : label is std.standard.true;
  attribute SHREG_EXTRACT of reset_sync3 : label is "no";
  attribute XILINX_LEGACY_PRIM of reset_sync3 : label is "FDP";
  attribute box_type of reset_sync3 : label is "PRIMITIVE";
  attribute ASYNC_REG of reset_sync4 : label is std.standard.true;
  attribute SHREG_EXTRACT of reset_sync4 : label is "no";
  attribute XILINX_LEGACY_PRIM of reset_sync4 : label is "FDP";
  attribute box_type of reset_sync4 : label is "PRIMITIVE";
  attribute ASYNC_REG of reset_sync5 : label is std.standard.true;
  attribute SHREG_EXTRACT of reset_sync5 : label is "no";
  attribute XILINX_LEGACY_PRIM of reset_sync5 : label is "FDP";
  attribute box_type of reset_sync5 : label is "PRIMITIVE";
  attribute ASYNC_REG of reset_sync6 : label is std.standard.true;
  attribute SHREG_EXTRACT of reset_sync6 : label is "no";
  attribute XILINX_LEGACY_PRIM of reset_sync6 : label is "FDP";
  attribute box_type of reset_sync6 : label is "PRIMITIVE";
begin
reset_sync1: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => CLK,
      CE => '1',
      D => '0',
      PRE => data_in,
      Q => reset_sync_reg1
    );
reset_sync2: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => CLK,
      CE => '1',
      D => reset_sync_reg1,
      PRE => data_in,
      Q => reset_sync_reg2
    );
reset_sync3: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => CLK,
      CE => '1',
      D => reset_sync_reg2,
      PRE => data_in,
      Q => reset_sync_reg3
    );
reset_sync4: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => CLK,
      CE => '1',
      D => reset_sync_reg3,
      PRE => data_in,
      Q => reset_sync_reg4
    );
reset_sync5: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => CLK,
      CE => '1',
      D => reset_sync_reg4,
      PRE => data_in,
      Q => reset_sync_reg5
    );
reset_sync6: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => CLK,
      CE => '1',
      D => reset_sync_reg5,
      PRE => '0',
      Q => reset_out
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gmii_to_sgmii_gmii_to_sgmii_reset_sync_17 is
  port (
    reset_out : out STD_LOGIC;
    CLK : in STD_LOGIC;
    CPLL_RESET : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of gmii_to_sgmii_gmii_to_sgmii_reset_sync_17 : entity is "gmii_to_sgmii_reset_sync";
end gmii_to_sgmii_gmii_to_sgmii_reset_sync_17;

architecture STRUCTURE of gmii_to_sgmii_gmii_to_sgmii_reset_sync_17 is
  signal reset_sync_reg1 : STD_LOGIC;
  signal reset_sync_reg2 : STD_LOGIC;
  signal reset_sync_reg3 : STD_LOGIC;
  signal reset_sync_reg4 : STD_LOGIC;
  signal reset_sync_reg5 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of reset_sync1 : label is std.standard.true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of reset_sync1 : label is "no";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of reset_sync1 : label is "FDP";
  attribute box_type : string;
  attribute box_type of reset_sync1 : label is "PRIMITIVE";
  attribute ASYNC_REG of reset_sync2 : label is std.standard.true;
  attribute SHREG_EXTRACT of reset_sync2 : label is "no";
  attribute XILINX_LEGACY_PRIM of reset_sync2 : label is "FDP";
  attribute box_type of reset_sync2 : label is "PRIMITIVE";
  attribute ASYNC_REG of reset_sync3 : label is std.standard.true;
  attribute SHREG_EXTRACT of reset_sync3 : label is "no";
  attribute XILINX_LEGACY_PRIM of reset_sync3 : label is "FDP";
  attribute box_type of reset_sync3 : label is "PRIMITIVE";
  attribute ASYNC_REG of reset_sync4 : label is std.standard.true;
  attribute SHREG_EXTRACT of reset_sync4 : label is "no";
  attribute XILINX_LEGACY_PRIM of reset_sync4 : label is "FDP";
  attribute box_type of reset_sync4 : label is "PRIMITIVE";
  attribute ASYNC_REG of reset_sync5 : label is std.standard.true;
  attribute SHREG_EXTRACT of reset_sync5 : label is "no";
  attribute XILINX_LEGACY_PRIM of reset_sync5 : label is "FDP";
  attribute box_type of reset_sync5 : label is "PRIMITIVE";
  attribute ASYNC_REG of reset_sync6 : label is std.standard.true;
  attribute SHREG_EXTRACT of reset_sync6 : label is "no";
  attribute XILINX_LEGACY_PRIM of reset_sync6 : label is "FDP";
  attribute box_type of reset_sync6 : label is "PRIMITIVE";
begin
reset_sync1: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => CLK,
      CE => '1',
      D => '0',
      PRE => CPLL_RESET,
      Q => reset_sync_reg1
    );
reset_sync2: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => CLK,
      CE => '1',
      D => reset_sync_reg1,
      PRE => CPLL_RESET,
      Q => reset_sync_reg2
    );
reset_sync3: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => CLK,
      CE => '1',
      D => reset_sync_reg2,
      PRE => CPLL_RESET,
      Q => reset_sync_reg3
    );
reset_sync4: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => CLK,
      CE => '1',
      D => reset_sync_reg3,
      PRE => CPLL_RESET,
      Q => reset_sync_reg4
    );
reset_sync5: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => CLK,
      CE => '1',
      D => reset_sync_reg4,
      PRE => CPLL_RESET,
      Q => reset_sync_reg5
    );
reset_sync6: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => CLK,
      CE => '1',
      D => reset_sync_reg5,
      PRE => '0',
      Q => reset_out
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gmii_to_sgmii_gmii_to_sgmii_reset_sync_32 is
  port (
    reset_out : out STD_LOGIC;
    CLK : in STD_LOGIC;
    SR : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of gmii_to_sgmii_gmii_to_sgmii_reset_sync_32 : entity is "gmii_to_sgmii_reset_sync";
end gmii_to_sgmii_gmii_to_sgmii_reset_sync_32;

architecture STRUCTURE of gmii_to_sgmii_gmii_to_sgmii_reset_sync_32 is
  signal reset_sync_reg1 : STD_LOGIC;
  signal reset_sync_reg2 : STD_LOGIC;
  signal reset_sync_reg3 : STD_LOGIC;
  signal reset_sync_reg4 : STD_LOGIC;
  signal reset_sync_reg5 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of reset_sync1 : label is std.standard.true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of reset_sync1 : label is "no";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of reset_sync1 : label is "FDP";
  attribute box_type : string;
  attribute box_type of reset_sync1 : label is "PRIMITIVE";
  attribute ASYNC_REG of reset_sync2 : label is std.standard.true;
  attribute SHREG_EXTRACT of reset_sync2 : label is "no";
  attribute XILINX_LEGACY_PRIM of reset_sync2 : label is "FDP";
  attribute box_type of reset_sync2 : label is "PRIMITIVE";
  attribute ASYNC_REG of reset_sync3 : label is std.standard.true;
  attribute SHREG_EXTRACT of reset_sync3 : label is "no";
  attribute XILINX_LEGACY_PRIM of reset_sync3 : label is "FDP";
  attribute box_type of reset_sync3 : label is "PRIMITIVE";
  attribute ASYNC_REG of reset_sync4 : label is std.standard.true;
  attribute SHREG_EXTRACT of reset_sync4 : label is "no";
  attribute XILINX_LEGACY_PRIM of reset_sync4 : label is "FDP";
  attribute box_type of reset_sync4 : label is "PRIMITIVE";
  attribute ASYNC_REG of reset_sync5 : label is std.standard.true;
  attribute SHREG_EXTRACT of reset_sync5 : label is "no";
  attribute XILINX_LEGACY_PRIM of reset_sync5 : label is "FDP";
  attribute box_type of reset_sync5 : label is "PRIMITIVE";
  attribute ASYNC_REG of reset_sync6 : label is std.standard.true;
  attribute SHREG_EXTRACT of reset_sync6 : label is "no";
  attribute XILINX_LEGACY_PRIM of reset_sync6 : label is "FDP";
  attribute box_type of reset_sync6 : label is "PRIMITIVE";
begin
reset_sync1: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => CLK,
      CE => '1',
      D => '0',
      PRE => SR(0),
      Q => reset_sync_reg1
    );
reset_sync2: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => CLK,
      CE => '1',
      D => reset_sync_reg1,
      PRE => SR(0),
      Q => reset_sync_reg2
    );
reset_sync3: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => CLK,
      CE => '1',
      D => reset_sync_reg2,
      PRE => SR(0),
      Q => reset_sync_reg3
    );
reset_sync4: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => CLK,
      CE => '1',
      D => reset_sync_reg3,
      PRE => SR(0),
      Q => reset_sync_reg4
    );
reset_sync5: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => CLK,
      CE => '1',
      D => reset_sync_reg4,
      PRE => SR(0),
      Q => reset_sync_reg5
    );
reset_sync6: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => CLK,
      CE => '1',
      D => reset_sync_reg5,
      PRE => '0',
      Q => reset_out
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gmii_to_sgmii_gmii_to_sgmii_reset_wtd_timer is
  port (
    reset : out STD_LOGIC;
    independent_clock_bufg : in STD_LOGIC;
    data_out : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of gmii_to_sgmii_gmii_to_sgmii_reset_wtd_timer : entity is "gmii_to_sgmii_reset_wtd_timer";
end gmii_to_sgmii_gmii_to_sgmii_reset_wtd_timer;

architecture STRUCTURE of gmii_to_sgmii_gmii_to_sgmii_reset_wtd_timer is
  signal \counter_stg1_reg__0\ : STD_LOGIC_VECTOR ( 5 to 5 );
  signal \counter_stg1_reg__1\ : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal counter_stg2_reg : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal counter_stg30 : STD_LOGIC;
  signal counter_stg3_reg : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal eqOp : STD_LOGIC;
  signal \n_0_counter_stg1[5]_i_1\ : STD_LOGIC;
  signal \n_0_counter_stg1[5]_i_3\ : STD_LOGIC;
  signal \n_0_counter_stg2[0]_i_3\ : STD_LOGIC;
  signal \n_0_counter_stg2[0]_i_4\ : STD_LOGIC;
  signal \n_0_counter_stg2[0]_i_5\ : STD_LOGIC;
  signal \n_0_counter_stg2[0]_i_6\ : STD_LOGIC;
  signal \n_0_counter_stg2[4]_i_2\ : STD_LOGIC;
  signal \n_0_counter_stg2[4]_i_3\ : STD_LOGIC;
  signal \n_0_counter_stg2[4]_i_4\ : STD_LOGIC;
  signal \n_0_counter_stg2[4]_i_5\ : STD_LOGIC;
  signal \n_0_counter_stg2[8]_i_2\ : STD_LOGIC;
  signal \n_0_counter_stg2[8]_i_3\ : STD_LOGIC;
  signal \n_0_counter_stg2[8]_i_4\ : STD_LOGIC;
  signal \n_0_counter_stg2[8]_i_5\ : STD_LOGIC;
  signal \n_0_counter_stg2_reg[0]_i_2\ : STD_LOGIC;
  signal \n_0_counter_stg2_reg[4]_i_1\ : STD_LOGIC;
  signal \n_0_counter_stg3[0]_i_3\ : STD_LOGIC;
  signal \n_0_counter_stg3[0]_i_4\ : STD_LOGIC;
  signal \n_0_counter_stg3[0]_i_5\ : STD_LOGIC;
  signal \n_0_counter_stg3[0]_i_6\ : STD_LOGIC;
  signal \n_0_counter_stg3[0]_i_7\ : STD_LOGIC;
  signal \n_0_counter_stg3[0]_i_8\ : STD_LOGIC;
  signal \n_0_counter_stg3[4]_i_2\ : STD_LOGIC;
  signal \n_0_counter_stg3[4]_i_3\ : STD_LOGIC;
  signal \n_0_counter_stg3[4]_i_4\ : STD_LOGIC;
  signal \n_0_counter_stg3[4]_i_5\ : STD_LOGIC;
  signal \n_0_counter_stg3[8]_i_2\ : STD_LOGIC;
  signal \n_0_counter_stg3[8]_i_3\ : STD_LOGIC;
  signal \n_0_counter_stg3[8]_i_4\ : STD_LOGIC;
  signal \n_0_counter_stg3[8]_i_5\ : STD_LOGIC;
  signal \n_0_counter_stg3_reg[0]_i_2\ : STD_LOGIC;
  signal \n_0_counter_stg3_reg[4]_i_1\ : STD_LOGIC;
  signal n_0_reset_i_2 : STD_LOGIC;
  signal n_0_reset_i_3 : STD_LOGIC;
  signal n_0_reset_i_4 : STD_LOGIC;
  signal n_0_reset_i_5 : STD_LOGIC;
  signal n_0_reset_i_6 : STD_LOGIC;
  signal \n_1_counter_stg2_reg[0]_i_2\ : STD_LOGIC;
  signal \n_1_counter_stg2_reg[4]_i_1\ : STD_LOGIC;
  signal \n_1_counter_stg2_reg[8]_i_1\ : STD_LOGIC;
  signal \n_1_counter_stg3_reg[0]_i_2\ : STD_LOGIC;
  signal \n_1_counter_stg3_reg[4]_i_1\ : STD_LOGIC;
  signal \n_1_counter_stg3_reg[8]_i_1\ : STD_LOGIC;
  signal \n_2_counter_stg2_reg[0]_i_2\ : STD_LOGIC;
  signal \n_2_counter_stg2_reg[4]_i_1\ : STD_LOGIC;
  signal \n_2_counter_stg2_reg[8]_i_1\ : STD_LOGIC;
  signal \n_2_counter_stg3_reg[0]_i_2\ : STD_LOGIC;
  signal \n_2_counter_stg3_reg[4]_i_1\ : STD_LOGIC;
  signal \n_2_counter_stg3_reg[8]_i_1\ : STD_LOGIC;
  signal \n_3_counter_stg2_reg[0]_i_2\ : STD_LOGIC;
  signal \n_3_counter_stg2_reg[4]_i_1\ : STD_LOGIC;
  signal \n_3_counter_stg2_reg[8]_i_1\ : STD_LOGIC;
  signal \n_3_counter_stg3_reg[0]_i_2\ : STD_LOGIC;
  signal \n_3_counter_stg3_reg[4]_i_1\ : STD_LOGIC;
  signal \n_3_counter_stg3_reg[8]_i_1\ : STD_LOGIC;
  signal \n_4_counter_stg2_reg[0]_i_2\ : STD_LOGIC;
  signal \n_4_counter_stg2_reg[4]_i_1\ : STD_LOGIC;
  signal \n_4_counter_stg2_reg[8]_i_1\ : STD_LOGIC;
  signal \n_4_counter_stg3_reg[0]_i_2\ : STD_LOGIC;
  signal \n_4_counter_stg3_reg[4]_i_1\ : STD_LOGIC;
  signal \n_4_counter_stg3_reg[8]_i_1\ : STD_LOGIC;
  signal \n_5_counter_stg2_reg[0]_i_2\ : STD_LOGIC;
  signal \n_5_counter_stg2_reg[4]_i_1\ : STD_LOGIC;
  signal \n_5_counter_stg2_reg[8]_i_1\ : STD_LOGIC;
  signal \n_5_counter_stg3_reg[0]_i_2\ : STD_LOGIC;
  signal \n_5_counter_stg3_reg[4]_i_1\ : STD_LOGIC;
  signal \n_5_counter_stg3_reg[8]_i_1\ : STD_LOGIC;
  signal \n_6_counter_stg2_reg[0]_i_2\ : STD_LOGIC;
  signal \n_6_counter_stg2_reg[4]_i_1\ : STD_LOGIC;
  signal \n_6_counter_stg2_reg[8]_i_1\ : STD_LOGIC;
  signal \n_6_counter_stg3_reg[0]_i_2\ : STD_LOGIC;
  signal \n_6_counter_stg3_reg[4]_i_1\ : STD_LOGIC;
  signal \n_6_counter_stg3_reg[8]_i_1\ : STD_LOGIC;
  signal \n_7_counter_stg2_reg[0]_i_2\ : STD_LOGIC;
  signal \n_7_counter_stg2_reg[4]_i_1\ : STD_LOGIC;
  signal \n_7_counter_stg2_reg[8]_i_1\ : STD_LOGIC;
  signal \n_7_counter_stg3_reg[0]_i_2\ : STD_LOGIC;
  signal \n_7_counter_stg3_reg[4]_i_1\ : STD_LOGIC;
  signal \n_7_counter_stg3_reg[8]_i_1\ : STD_LOGIC;
  signal \plusOp__0\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal reset0 : STD_LOGIC;
  signal \NLW_counter_stg2_reg[8]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_counter_stg3_reg[8]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \counter_stg1[0]_i_1\ : label is "soft_lutpair115";
  attribute SOFT_HLUTNM of \counter_stg1[1]_i_1\ : label is "soft_lutpair115";
  attribute SOFT_HLUTNM of \counter_stg1[2]_i_1\ : label is "soft_lutpair114";
  attribute SOFT_HLUTNM of \counter_stg1[3]_i_1\ : label is "soft_lutpair114";
  attribute SOFT_HLUTNM of \counter_stg1[4]_i_1\ : label is "soft_lutpair113";
  attribute SOFT_HLUTNM of \counter_stg1[5]_i_3\ : label is "soft_lutpair113";
begin
\counter_stg1[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \counter_stg1_reg__1\(0),
      O => \plusOp__0\(0)
    );
\counter_stg1[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \counter_stg1_reg__1\(0),
      I1 => \counter_stg1_reg__1\(1),
      O => \plusOp__0\(1)
    );
\counter_stg1[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
    port map (
      I0 => \counter_stg1_reg__1\(1),
      I1 => \counter_stg1_reg__1\(0),
      I2 => \counter_stg1_reg__1\(2),
      O => \plusOp__0\(2)
    );
\counter_stg1[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
    port map (
      I0 => \counter_stg1_reg__1\(2),
      I1 => \counter_stg1_reg__1\(0),
      I2 => \counter_stg1_reg__1\(1),
      I3 => \counter_stg1_reg__1\(3),
      O => \plusOp__0\(3)
    );
\counter_stg1[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFF8000"
    )
    port map (
      I0 => \counter_stg1_reg__1\(3),
      I1 => \counter_stg1_reg__1\(1),
      I2 => \counter_stg1_reg__1\(0),
      I3 => \counter_stg1_reg__1\(2),
      I4 => \counter_stg1_reg__1\(4),
      O => \plusOp__0\(4)
    );
\counter_stg1[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF0080"
    )
    port map (
      I0 => n_0_reset_i_2,
      I1 => counter_stg3_reg(7),
      I2 => n_0_reset_i_3,
      I3 => \n_0_counter_stg1[5]_i_3\,
      I4 => data_out,
      O => \n_0_counter_stg1[5]_i_1\
    );
\counter_stg1[5]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFF80000000"
    )
    port map (
      I0 => \counter_stg1_reg__1\(4),
      I1 => \counter_stg1_reg__1\(2),
      I2 => \counter_stg1_reg__1\(0),
      I3 => \counter_stg1_reg__1\(1),
      I4 => \counter_stg1_reg__1\(3),
      I5 => \counter_stg1_reg__0\(5),
      O => \plusOp__0\(5)
    );
\counter_stg1[5]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFFFFFF"
    )
    port map (
      I0 => \counter_stg1_reg__1\(3),
      I1 => \counter_stg1_reg__1\(1),
      I2 => \counter_stg1_reg__1\(0),
      I3 => \counter_stg1_reg__1\(2),
      I4 => \counter_stg1_reg__1\(4),
      O => \n_0_counter_stg1[5]_i_3\
    );
\counter_stg1_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => \plusOp__0\(0),
      Q => \counter_stg1_reg__1\(0),
      R => \n_0_counter_stg1[5]_i_1\
    );
\counter_stg1_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => \plusOp__0\(1),
      Q => \counter_stg1_reg__1\(1),
      R => \n_0_counter_stg1[5]_i_1\
    );
\counter_stg1_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => \plusOp__0\(2),
      Q => \counter_stg1_reg__1\(2),
      R => \n_0_counter_stg1[5]_i_1\
    );
\counter_stg1_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => \plusOp__0\(3),
      Q => \counter_stg1_reg__1\(3),
      R => \n_0_counter_stg1[5]_i_1\
    );
\counter_stg1_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => \plusOp__0\(4),
      Q => \counter_stg1_reg__1\(4),
      R => \n_0_counter_stg1[5]_i_1\
    );
\counter_stg1_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => \plusOp__0\(5),
      Q => \counter_stg1_reg__0\(5),
      R => \n_0_counter_stg1[5]_i_1\
    );
\counter_stg2[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000000"
    )
    port map (
      I0 => \counter_stg1_reg__0\(5),
      I1 => \counter_stg1_reg__1\(4),
      I2 => \counter_stg1_reg__1\(2),
      I3 => \counter_stg1_reg__1\(0),
      I4 => \counter_stg1_reg__1\(1),
      I5 => \counter_stg1_reg__1\(3),
      O => eqOp
    );
\counter_stg2[0]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => counter_stg2_reg(3),
      O => \n_0_counter_stg2[0]_i_3\
    );
\counter_stg2[0]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => counter_stg2_reg(2),
      O => \n_0_counter_stg2[0]_i_4\
    );
\counter_stg2[0]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => counter_stg2_reg(1),
      O => \n_0_counter_stg2[0]_i_5\
    );
\counter_stg2[0]_i_6\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => counter_stg2_reg(0),
      O => \n_0_counter_stg2[0]_i_6\
    );
\counter_stg2[4]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => counter_stg2_reg(7),
      O => \n_0_counter_stg2[4]_i_2\
    );
\counter_stg2[4]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => counter_stg2_reg(6),
      O => \n_0_counter_stg2[4]_i_3\
    );
\counter_stg2[4]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => counter_stg2_reg(5),
      O => \n_0_counter_stg2[4]_i_4\
    );
\counter_stg2[4]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => counter_stg2_reg(4),
      O => \n_0_counter_stg2[4]_i_5\
    );
\counter_stg2[8]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => counter_stg2_reg(11),
      O => \n_0_counter_stg2[8]_i_2\
    );
\counter_stg2[8]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => counter_stg2_reg(10),
      O => \n_0_counter_stg2[8]_i_3\
    );
\counter_stg2[8]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => counter_stg2_reg(9),
      O => \n_0_counter_stg2[8]_i_4\
    );
\counter_stg2[8]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => counter_stg2_reg(8),
      O => \n_0_counter_stg2[8]_i_5\
    );
\counter_stg2_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => eqOp,
      D => \n_7_counter_stg2_reg[0]_i_2\,
      Q => counter_stg2_reg(0),
      R => \n_0_counter_stg1[5]_i_1\
    );
\counter_stg2_reg[0]_i_2\: unisim.vcomponents.CARRY4
    port map (
      CI => '0',
      CO(3) => \n_0_counter_stg2_reg[0]_i_2\,
      CO(2) => \n_1_counter_stg2_reg[0]_i_2\,
      CO(1) => \n_2_counter_stg2_reg[0]_i_2\,
      CO(0) => \n_3_counter_stg2_reg[0]_i_2\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '1',
      O(3) => \n_4_counter_stg2_reg[0]_i_2\,
      O(2) => \n_5_counter_stg2_reg[0]_i_2\,
      O(1) => \n_6_counter_stg2_reg[0]_i_2\,
      O(0) => \n_7_counter_stg2_reg[0]_i_2\,
      S(3) => \n_0_counter_stg2[0]_i_3\,
      S(2) => \n_0_counter_stg2[0]_i_4\,
      S(1) => \n_0_counter_stg2[0]_i_5\,
      S(0) => \n_0_counter_stg2[0]_i_6\
    );
\counter_stg2_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => eqOp,
      D => \n_5_counter_stg2_reg[8]_i_1\,
      Q => counter_stg2_reg(10),
      R => \n_0_counter_stg1[5]_i_1\
    );
\counter_stg2_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => eqOp,
      D => \n_4_counter_stg2_reg[8]_i_1\,
      Q => counter_stg2_reg(11),
      R => \n_0_counter_stg1[5]_i_1\
    );
\counter_stg2_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => eqOp,
      D => \n_6_counter_stg2_reg[0]_i_2\,
      Q => counter_stg2_reg(1),
      R => \n_0_counter_stg1[5]_i_1\
    );
\counter_stg2_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => eqOp,
      D => \n_5_counter_stg2_reg[0]_i_2\,
      Q => counter_stg2_reg(2),
      R => \n_0_counter_stg1[5]_i_1\
    );
\counter_stg2_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => eqOp,
      D => \n_4_counter_stg2_reg[0]_i_2\,
      Q => counter_stg2_reg(3),
      R => \n_0_counter_stg1[5]_i_1\
    );
\counter_stg2_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => eqOp,
      D => \n_7_counter_stg2_reg[4]_i_1\,
      Q => counter_stg2_reg(4),
      R => \n_0_counter_stg1[5]_i_1\
    );
\counter_stg2_reg[4]_i_1\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_counter_stg2_reg[0]_i_2\,
      CO(3) => \n_0_counter_stg2_reg[4]_i_1\,
      CO(2) => \n_1_counter_stg2_reg[4]_i_1\,
      CO(1) => \n_2_counter_stg2_reg[4]_i_1\,
      CO(0) => \n_3_counter_stg2_reg[4]_i_1\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '0',
      O(3) => \n_4_counter_stg2_reg[4]_i_1\,
      O(2) => \n_5_counter_stg2_reg[4]_i_1\,
      O(1) => \n_6_counter_stg2_reg[4]_i_1\,
      O(0) => \n_7_counter_stg2_reg[4]_i_1\,
      S(3) => \n_0_counter_stg2[4]_i_2\,
      S(2) => \n_0_counter_stg2[4]_i_3\,
      S(1) => \n_0_counter_stg2[4]_i_4\,
      S(0) => \n_0_counter_stg2[4]_i_5\
    );
\counter_stg2_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => eqOp,
      D => \n_6_counter_stg2_reg[4]_i_1\,
      Q => counter_stg2_reg(5),
      R => \n_0_counter_stg1[5]_i_1\
    );
\counter_stg2_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => eqOp,
      D => \n_5_counter_stg2_reg[4]_i_1\,
      Q => counter_stg2_reg(6),
      R => \n_0_counter_stg1[5]_i_1\
    );
\counter_stg2_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => eqOp,
      D => \n_4_counter_stg2_reg[4]_i_1\,
      Q => counter_stg2_reg(7),
      R => \n_0_counter_stg1[5]_i_1\
    );
\counter_stg2_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => eqOp,
      D => \n_7_counter_stg2_reg[8]_i_1\,
      Q => counter_stg2_reg(8),
      R => \n_0_counter_stg1[5]_i_1\
    );
\counter_stg2_reg[8]_i_1\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_counter_stg2_reg[4]_i_1\,
      CO(3) => \NLW_counter_stg2_reg[8]_i_1_CO_UNCONNECTED\(3),
      CO(2) => \n_1_counter_stg2_reg[8]_i_1\,
      CO(1) => \n_2_counter_stg2_reg[8]_i_1\,
      CO(0) => \n_3_counter_stg2_reg[8]_i_1\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '0',
      O(3) => \n_4_counter_stg2_reg[8]_i_1\,
      O(2) => \n_5_counter_stg2_reg[8]_i_1\,
      O(1) => \n_6_counter_stg2_reg[8]_i_1\,
      O(0) => \n_7_counter_stg2_reg[8]_i_1\,
      S(3) => \n_0_counter_stg2[8]_i_2\,
      S(2) => \n_0_counter_stg2[8]_i_3\,
      S(1) => \n_0_counter_stg2[8]_i_4\,
      S(0) => \n_0_counter_stg2[8]_i_5\
    );
\counter_stg2_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => eqOp,
      D => \n_6_counter_stg2_reg[8]_i_1\,
      Q => counter_stg2_reg(9),
      R => \n_0_counter_stg1[5]_i_1\
    );
\counter_stg3[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000080000000"
    )
    port map (
      I0 => counter_stg2_reg(10),
      I1 => counter_stg2_reg(8),
      I2 => counter_stg2_reg(7),
      I3 => \n_0_counter_stg3[0]_i_3\,
      I4 => \n_0_counter_stg3[0]_i_4\,
      I5 => \n_0_counter_stg1[5]_i_3\,
      O => counter_stg30
    );
\counter_stg3[0]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000000"
    )
    port map (
      I0 => counter_stg2_reg(2),
      I1 => counter_stg2_reg(9),
      I2 => counter_stg2_reg(6),
      I3 => counter_stg2_reg(0),
      I4 => counter_stg2_reg(1),
      I5 => counter_stg2_reg(5),
      O => \n_0_counter_stg3[0]_i_3\
    );
\counter_stg3[0]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => \counter_stg1_reg__0\(5),
      I1 => counter_stg2_reg(11),
      I2 => counter_stg2_reg(4),
      I3 => counter_stg2_reg(3),
      O => \n_0_counter_stg3[0]_i_4\
    );
\counter_stg3[0]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => counter_stg3_reg(3),
      O => \n_0_counter_stg3[0]_i_5\
    );
\counter_stg3[0]_i_6\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => counter_stg3_reg(2),
      O => \n_0_counter_stg3[0]_i_6\
    );
\counter_stg3[0]_i_7\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => counter_stg3_reg(1),
      O => \n_0_counter_stg3[0]_i_7\
    );
\counter_stg3[0]_i_8\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => counter_stg3_reg(0),
      O => \n_0_counter_stg3[0]_i_8\
    );
\counter_stg3[4]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => counter_stg3_reg(7),
      O => \n_0_counter_stg3[4]_i_2\
    );
\counter_stg3[4]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => counter_stg3_reg(6),
      O => \n_0_counter_stg3[4]_i_3\
    );
\counter_stg3[4]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => counter_stg3_reg(5),
      O => \n_0_counter_stg3[4]_i_4\
    );
\counter_stg3[4]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => counter_stg3_reg(4),
      O => \n_0_counter_stg3[4]_i_5\
    );
\counter_stg3[8]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => counter_stg3_reg(11),
      O => \n_0_counter_stg3[8]_i_2\
    );
\counter_stg3[8]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => counter_stg3_reg(10),
      O => \n_0_counter_stg3[8]_i_3\
    );
\counter_stg3[8]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => counter_stg3_reg(9),
      O => \n_0_counter_stg3[8]_i_4\
    );
\counter_stg3[8]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => counter_stg3_reg(8),
      O => \n_0_counter_stg3[8]_i_5\
    );
\counter_stg3_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => counter_stg30,
      D => \n_7_counter_stg3_reg[0]_i_2\,
      Q => counter_stg3_reg(0),
      R => \n_0_counter_stg1[5]_i_1\
    );
\counter_stg3_reg[0]_i_2\: unisim.vcomponents.CARRY4
    port map (
      CI => '0',
      CO(3) => \n_0_counter_stg3_reg[0]_i_2\,
      CO(2) => \n_1_counter_stg3_reg[0]_i_2\,
      CO(1) => \n_2_counter_stg3_reg[0]_i_2\,
      CO(0) => \n_3_counter_stg3_reg[0]_i_2\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '1',
      O(3) => \n_4_counter_stg3_reg[0]_i_2\,
      O(2) => \n_5_counter_stg3_reg[0]_i_2\,
      O(1) => \n_6_counter_stg3_reg[0]_i_2\,
      O(0) => \n_7_counter_stg3_reg[0]_i_2\,
      S(3) => \n_0_counter_stg3[0]_i_5\,
      S(2) => \n_0_counter_stg3[0]_i_6\,
      S(1) => \n_0_counter_stg3[0]_i_7\,
      S(0) => \n_0_counter_stg3[0]_i_8\
    );
\counter_stg3_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => counter_stg30,
      D => \n_5_counter_stg3_reg[8]_i_1\,
      Q => counter_stg3_reg(10),
      R => \n_0_counter_stg1[5]_i_1\
    );
\counter_stg3_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => counter_stg30,
      D => \n_4_counter_stg3_reg[8]_i_1\,
      Q => counter_stg3_reg(11),
      R => \n_0_counter_stg1[5]_i_1\
    );
\counter_stg3_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => counter_stg30,
      D => \n_6_counter_stg3_reg[0]_i_2\,
      Q => counter_stg3_reg(1),
      R => \n_0_counter_stg1[5]_i_1\
    );
\counter_stg3_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => counter_stg30,
      D => \n_5_counter_stg3_reg[0]_i_2\,
      Q => counter_stg3_reg(2),
      R => \n_0_counter_stg1[5]_i_1\
    );
\counter_stg3_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => counter_stg30,
      D => \n_4_counter_stg3_reg[0]_i_2\,
      Q => counter_stg3_reg(3),
      R => \n_0_counter_stg1[5]_i_1\
    );
\counter_stg3_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => counter_stg30,
      D => \n_7_counter_stg3_reg[4]_i_1\,
      Q => counter_stg3_reg(4),
      R => \n_0_counter_stg1[5]_i_1\
    );
\counter_stg3_reg[4]_i_1\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_counter_stg3_reg[0]_i_2\,
      CO(3) => \n_0_counter_stg3_reg[4]_i_1\,
      CO(2) => \n_1_counter_stg3_reg[4]_i_1\,
      CO(1) => \n_2_counter_stg3_reg[4]_i_1\,
      CO(0) => \n_3_counter_stg3_reg[4]_i_1\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '0',
      O(3) => \n_4_counter_stg3_reg[4]_i_1\,
      O(2) => \n_5_counter_stg3_reg[4]_i_1\,
      O(1) => \n_6_counter_stg3_reg[4]_i_1\,
      O(0) => \n_7_counter_stg3_reg[4]_i_1\,
      S(3) => \n_0_counter_stg3[4]_i_2\,
      S(2) => \n_0_counter_stg3[4]_i_3\,
      S(1) => \n_0_counter_stg3[4]_i_4\,
      S(0) => \n_0_counter_stg3[4]_i_5\
    );
\counter_stg3_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => counter_stg30,
      D => \n_6_counter_stg3_reg[4]_i_1\,
      Q => counter_stg3_reg(5),
      R => \n_0_counter_stg1[5]_i_1\
    );
\counter_stg3_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => counter_stg30,
      D => \n_5_counter_stg3_reg[4]_i_1\,
      Q => counter_stg3_reg(6),
      R => \n_0_counter_stg1[5]_i_1\
    );
\counter_stg3_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => counter_stg30,
      D => \n_4_counter_stg3_reg[4]_i_1\,
      Q => counter_stg3_reg(7),
      R => \n_0_counter_stg1[5]_i_1\
    );
\counter_stg3_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => counter_stg30,
      D => \n_7_counter_stg3_reg[8]_i_1\,
      Q => counter_stg3_reg(8),
      R => \n_0_counter_stg1[5]_i_1\
    );
\counter_stg3_reg[8]_i_1\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_counter_stg3_reg[4]_i_1\,
      CO(3) => \NLW_counter_stg3_reg[8]_i_1_CO_UNCONNECTED\(3),
      CO(2) => \n_1_counter_stg3_reg[8]_i_1\,
      CO(1) => \n_2_counter_stg3_reg[8]_i_1\,
      CO(0) => \n_3_counter_stg3_reg[8]_i_1\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '0',
      O(3) => \n_4_counter_stg3_reg[8]_i_1\,
      O(2) => \n_5_counter_stg3_reg[8]_i_1\,
      O(1) => \n_6_counter_stg3_reg[8]_i_1\,
      O(0) => \n_7_counter_stg3_reg[8]_i_1\,
      S(3) => \n_0_counter_stg3[8]_i_2\,
      S(2) => \n_0_counter_stg3[8]_i_3\,
      S(1) => \n_0_counter_stg3[8]_i_4\,
      S(0) => \n_0_counter_stg3[8]_i_5\
    );
\counter_stg3_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => counter_stg30,
      D => \n_6_counter_stg3_reg[8]_i_1\,
      Q => counter_stg3_reg(9),
      R => \n_0_counter_stg1[5]_i_1\
    );
reset_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => n_0_reset_i_2,
      I1 => counter_stg3_reg(7),
      I2 => n_0_reset_i_3,
      O => reset0
    );
reset_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000010000"
    )
    port map (
      I0 => counter_stg3_reg(9),
      I1 => counter_stg3_reg(8),
      I2 => counter_stg2_reg(0),
      I3 => counter_stg3_reg(0),
      I4 => counter_stg3_reg(11),
      I5 => counter_stg3_reg(10),
      O => n_0_reset_i_2
    );
reset_i_3: unisim.vcomponents.LUT5
    generic map(
      INIT => X"80000000"
    )
    port map (
      I0 => n_0_reset_i_4,
      I1 => n_0_reset_i_5,
      I2 => n_0_reset_i_6,
      I3 => counter_stg2_reg(4),
      I4 => counter_stg2_reg(3),
      O => n_0_reset_i_3
    );
reset_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000004"
    )
    port map (
      I0 => counter_stg2_reg(1),
      I1 => counter_stg2_reg(10),
      I2 => counter_stg2_reg(5),
      I3 => counter_stg2_reg(6),
      I4 => counter_stg2_reg(9),
      I5 => counter_stg2_reg(2),
      O => n_0_reset_i_4
    );
reset_i_5: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000010000000"
    )
    port map (
      I0 => counter_stg3_reg(2),
      I1 => counter_stg3_reg(1),
      I2 => counter_stg3_reg(5),
      I3 => counter_stg3_reg(6),
      I4 => counter_stg3_reg(4),
      I5 => counter_stg3_reg(3),
      O => n_0_reset_i_5
    );
reset_i_6: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0800"
    )
    port map (
      I0 => \counter_stg1_reg__0\(5),
      I1 => counter_stg2_reg(11),
      I2 => counter_stg2_reg(7),
      I3 => counter_stg2_reg(8),
      O => n_0_reset_i_6
    );
reset_reg: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => reset0,
      Q => reset,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gmii_to_sgmii_gmii_to_sgmii_resets is
  port (
    Q : out STD_LOGIC_VECTOR ( 0 to 0 );
    independent_clock_bufg : in STD_LOGIC;
    AS : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of gmii_to_sgmii_gmii_to_sgmii_resets : entity is "gmii_to_sgmii_resets";
end gmii_to_sgmii_gmii_to_sgmii_resets;

architecture STRUCTURE of gmii_to_sgmii_gmii_to_sgmii_resets is
  signal pma_reset_pipe : STD_LOGIC_VECTOR ( 2 downto 0 );
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of \pma_reset_pipe_reg[0]\ : label is std.standard.true;
  attribute ASYNC_REG of \pma_reset_pipe_reg[1]\ : label is std.standard.true;
  attribute ASYNC_REG of \pma_reset_pipe_reg[2]\ : label is std.standard.true;
  attribute ASYNC_REG of \pma_reset_pipe_reg[3]\ : label is std.standard.true;
begin
\pma_reset_pipe_reg[0]\: unisim.vcomponents.FDPE
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => '0',
      PRE => AS(0),
      Q => pma_reset_pipe(0)
    );
\pma_reset_pipe_reg[1]\: unisim.vcomponents.FDPE
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => pma_reset_pipe(0),
      PRE => AS(0),
      Q => pma_reset_pipe(1)
    );
\pma_reset_pipe_reg[2]\: unisim.vcomponents.FDPE
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => pma_reset_pipe(1),
      PRE => AS(0),
      Q => pma_reset_pipe(2)
    );
\pma_reset_pipe_reg[3]\: unisim.vcomponents.FDPE
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => pma_reset_pipe(2),
      PRE => AS(0),
      Q => Q(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gmii_to_sgmii_gmii_to_sgmii_rx_rate_adapt is
  port (
    gmii_rx_dv : out STD_LOGIC;
    gmii_rx_er : out STD_LOGIC;
    gmii_rxd : out STD_LOGIC_VECTOR ( 7 downto 0 );
    I1 : in STD_LOGIC;
    I2 : in STD_LOGIC;
    I3 : in STD_LOGIC;
    CLK : in STD_LOGIC;
    I4 : in STD_LOGIC;
    D : in STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of gmii_to_sgmii_gmii_to_sgmii_rx_rate_adapt : entity is "gmii_to_sgmii_rx_rate_adapt";
end gmii_to_sgmii_gmii_to_sgmii_rx_rate_adapt;

architecture STRUCTURE of gmii_to_sgmii_gmii_to_sgmii_rx_rate_adapt is
  signal muxsel : STD_LOGIC;
  signal n_0_muxsel_i_1 : STD_LOGIC;
  signal n_0_rx_dv_aligned_i_1 : STD_LOGIC;
  signal \n_0_rxd_aligned[0]_i_1\ : STD_LOGIC;
  signal \n_0_rxd_aligned[1]_i_1\ : STD_LOGIC;
  signal \n_0_rxd_aligned[2]_i_1\ : STD_LOGIC;
  signal \n_0_rxd_aligned[3]_i_1\ : STD_LOGIC;
  signal \n_0_rxd_aligned[4]_i_1\ : STD_LOGIC;
  signal \n_0_rxd_aligned[5]_i_1\ : STD_LOGIC;
  signal \n_0_rxd_aligned[6]_i_1\ : STD_LOGIC;
  signal \n_0_rxd_aligned[7]_i_1\ : STD_LOGIC;
  signal \n_0_rxd_reg1_reg[0]\ : STD_LOGIC;
  signal \n_0_rxd_reg1_reg[1]\ : STD_LOGIC;
  signal \n_0_rxd_reg1_reg[2]\ : STD_LOGIC;
  signal \n_0_rxd_reg1_reg[3]\ : STD_LOGIC;
  signal n_0_sfd_enable_i_1 : STD_LOGIC;
  signal n_0_sfd_enable_i_2 : STD_LOGIC;
  signal n_0_sfd_enable_i_3 : STD_LOGIC;
  signal n_0_sfd_enable_i_4 : STD_LOGIC;
  signal n_0_sfd_enable_i_5 : STD_LOGIC;
  signal n_0_sfd_enable_i_6 : STD_LOGIC;
  signal p_0_in : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal rx_dv_aligned : STD_LOGIC;
  signal rx_dv_reg1 : STD_LOGIC;
  signal rx_dv_reg2 : STD_LOGIC;
  signal rx_er_aligned : STD_LOGIC;
  signal rx_er_aligned_0 : STD_LOGIC;
  signal rx_er_reg1 : STD_LOGIC;
  signal rx_er_reg2 : STD_LOGIC;
  signal rxd_aligned : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal rxd_reg2 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal sfd_enable : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of rx_dv_aligned_i_1 : label is "soft_lutpair75";
  attribute SOFT_HLUTNM of rx_er_aligned_i_1 : label is "soft_lutpair75";
  attribute SOFT_HLUTNM of \rxd_aligned[0]_i_1\ : label is "soft_lutpair76";
  attribute SOFT_HLUTNM of \rxd_aligned[1]_i_1\ : label is "soft_lutpair79";
  attribute SOFT_HLUTNM of \rxd_aligned[2]_i_1\ : label is "soft_lutpair78";
  attribute SOFT_HLUTNM of \rxd_aligned[3]_i_1\ : label is "soft_lutpair77";
  attribute SOFT_HLUTNM of \rxd_aligned[4]_i_1\ : label is "soft_lutpair76";
  attribute SOFT_HLUTNM of \rxd_aligned[5]_i_1\ : label is "soft_lutpair79";
  attribute SOFT_HLUTNM of \rxd_aligned[6]_i_1\ : label is "soft_lutpair78";
  attribute SOFT_HLUTNM of \rxd_aligned[7]_i_1\ : label is "soft_lutpair77";
  attribute SOFT_HLUTNM of sfd_enable_i_2 : label is "soft_lutpair74";
  attribute SOFT_HLUTNM of sfd_enable_i_4 : label is "soft_lutpair74";
begin
gmii_rx_dv_out_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => I2,
      D => rx_dv_aligned,
      Q => gmii_rx_dv,
      R => I1
    );
gmii_rx_er_out_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => I2,
      D => rx_er_aligned,
      Q => gmii_rx_er,
      R => I1
    );
\gmii_rxd_out_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => I2,
      D => rxd_aligned(0),
      Q => gmii_rxd(0),
      R => I1
    );
\gmii_rxd_out_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => I2,
      D => rxd_aligned(1),
      Q => gmii_rxd(1),
      R => I1
    );
\gmii_rxd_out_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => I2,
      D => rxd_aligned(2),
      Q => gmii_rxd(2),
      R => I1
    );
\gmii_rxd_out_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => I2,
      D => rxd_aligned(3),
      Q => gmii_rxd(3),
      R => I1
    );
\gmii_rxd_out_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => I2,
      D => rxd_aligned(4),
      Q => gmii_rxd(4),
      R => I1
    );
\gmii_rxd_out_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => I2,
      D => rxd_aligned(5),
      Q => gmii_rxd(5),
      R => I1
    );
\gmii_rxd_out_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => I2,
      D => rxd_aligned(6),
      Q => gmii_rxd(6),
      R => I1
    );
\gmii_rxd_out_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => I2,
      D => rxd_aligned(7),
      Q => gmii_rxd(7),
      R => I1
    );
muxsel_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000000EAAAAAA"
    )
    port map (
      I0 => muxsel,
      I1 => n_0_sfd_enable_i_2,
      I2 => n_0_sfd_enable_i_4,
      I3 => sfd_enable,
      I4 => I2,
      I5 => I1,
      O => n_0_muxsel_i_1
    );
muxsel_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => n_0_muxsel_i_1,
      Q => muxsel,
      R => '0'
    );
rx_dv_aligned_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8A"
    )
    port map (
      I0 => rx_dv_reg2,
      I1 => rx_dv_reg1,
      I2 => muxsel,
      O => n_0_rx_dv_aligned_i_1
    );
rx_dv_aligned_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => I2,
      D => n_0_rx_dv_aligned_i_1,
      Q => rx_dv_aligned,
      R => I1
    );
rx_dv_reg1_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => I2,
      D => I3,
      Q => rx_dv_reg1,
      R => I1
    );
rx_dv_reg2_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => I2,
      D => rx_dv_reg1,
      Q => rx_dv_reg2,
      R => I1
    );
rx_er_aligned_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => rx_er_reg2,
      I1 => rx_er_reg1,
      I2 => muxsel,
      O => rx_er_aligned_0
    );
rx_er_aligned_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => I2,
      D => rx_er_aligned_0,
      Q => rx_er_aligned,
      R => I1
    );
rx_er_reg1_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => I2,
      D => I4,
      Q => rx_er_reg1,
      R => I1
    );
rx_er_reg2_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => I2,
      D => rx_er_reg1,
      Q => rx_er_reg2,
      R => I1
    );
\rxd_aligned[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => rxd_reg2(4),
      I1 => muxsel,
      I2 => rxd_reg2(0),
      O => \n_0_rxd_aligned[0]_i_1\
    );
\rxd_aligned[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => rxd_reg2(5),
      I1 => muxsel,
      I2 => rxd_reg2(1),
      O => \n_0_rxd_aligned[1]_i_1\
    );
\rxd_aligned[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => rxd_reg2(6),
      I1 => muxsel,
      I2 => rxd_reg2(2),
      O => \n_0_rxd_aligned[2]_i_1\
    );
\rxd_aligned[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => rxd_reg2(7),
      I1 => muxsel,
      I2 => rxd_reg2(3),
      O => \n_0_rxd_aligned[3]_i_1\
    );
\rxd_aligned[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \n_0_rxd_reg1_reg[0]\,
      I1 => muxsel,
      I2 => rxd_reg2(4),
      O => \n_0_rxd_aligned[4]_i_1\
    );
\rxd_aligned[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \n_0_rxd_reg1_reg[1]\,
      I1 => muxsel,
      I2 => rxd_reg2(5),
      O => \n_0_rxd_aligned[5]_i_1\
    );
\rxd_aligned[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \n_0_rxd_reg1_reg[2]\,
      I1 => muxsel,
      I2 => rxd_reg2(6),
      O => \n_0_rxd_aligned[6]_i_1\
    );
\rxd_aligned[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \n_0_rxd_reg1_reg[3]\,
      I1 => muxsel,
      I2 => rxd_reg2(7),
      O => \n_0_rxd_aligned[7]_i_1\
    );
\rxd_aligned_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => I2,
      D => \n_0_rxd_aligned[0]_i_1\,
      Q => rxd_aligned(0),
      R => I1
    );
\rxd_aligned_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => I2,
      D => \n_0_rxd_aligned[1]_i_1\,
      Q => rxd_aligned(1),
      R => I1
    );
\rxd_aligned_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => I2,
      D => \n_0_rxd_aligned[2]_i_1\,
      Q => rxd_aligned(2),
      R => I1
    );
\rxd_aligned_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => I2,
      D => \n_0_rxd_aligned[3]_i_1\,
      Q => rxd_aligned(3),
      R => I1
    );
\rxd_aligned_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => I2,
      D => \n_0_rxd_aligned[4]_i_1\,
      Q => rxd_aligned(4),
      R => I1
    );
\rxd_aligned_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => I2,
      D => \n_0_rxd_aligned[5]_i_1\,
      Q => rxd_aligned(5),
      R => I1
    );
\rxd_aligned_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => I2,
      D => \n_0_rxd_aligned[6]_i_1\,
      Q => rxd_aligned(6),
      R => I1
    );
\rxd_aligned_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => I2,
      D => \n_0_rxd_aligned[7]_i_1\,
      Q => rxd_aligned(7),
      R => I1
    );
\rxd_reg1_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => I2,
      D => D(0),
      Q => \n_0_rxd_reg1_reg[0]\,
      R => I1
    );
\rxd_reg1_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => I2,
      D => D(1),
      Q => \n_0_rxd_reg1_reg[1]\,
      R => I1
    );
\rxd_reg1_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => I2,
      D => D(2),
      Q => \n_0_rxd_reg1_reg[2]\,
      R => I1
    );
\rxd_reg1_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => I2,
      D => D(3),
      Q => \n_0_rxd_reg1_reg[3]\,
      R => I1
    );
\rxd_reg1_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => I2,
      D => D(4),
      Q => p_0_in(0),
      R => I1
    );
\rxd_reg1_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => I2,
      D => D(5),
      Q => p_0_in(1),
      R => I1
    );
\rxd_reg1_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => I2,
      D => D(6),
      Q => p_0_in(2),
      R => I1
    );
\rxd_reg1_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => I2,
      D => D(7),
      Q => p_0_in(3),
      R => I1
    );
\rxd_reg2_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => I2,
      D => \n_0_rxd_reg1_reg[0]\,
      Q => rxd_reg2(0),
      R => I1
    );
\rxd_reg2_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => I2,
      D => \n_0_rxd_reg1_reg[1]\,
      Q => rxd_reg2(1),
      R => I1
    );
\rxd_reg2_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => I2,
      D => \n_0_rxd_reg1_reg[2]\,
      Q => rxd_reg2(2),
      R => I1
    );
\rxd_reg2_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => I2,
      D => \n_0_rxd_reg1_reg[3]\,
      Q => rxd_reg2(3),
      R => I1
    );
\rxd_reg2_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => I2,
      D => p_0_in(0),
      Q => rxd_reg2(4),
      R => I1
    );
\rxd_reg2_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => I2,
      D => p_0_in(1),
      Q => rxd_reg2(5),
      R => I1
    );
\rxd_reg2_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => I2,
      D => p_0_in(2),
      Q => rxd_reg2(6),
      R => I1
    );
\rxd_reg2_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => I2,
      D => p_0_in(3),
      Q => rxd_reg2(7),
      R => I1
    );
sfd_enable_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5051555550500000"
    )
    port map (
      I0 => I1,
      I1 => n_0_sfd_enable_i_2,
      I2 => n_0_sfd_enable_i_3,
      I3 => n_0_sfd_enable_i_4,
      I4 => I2,
      I5 => sfd_enable,
      O => n_0_sfd_enable_i_1
    );
sfd_enable_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => n_0_sfd_enable_i_5,
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      O => n_0_sfd_enable_i_2
    );
sfd_enable_i_3: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => I3,
      I1 => rx_dv_reg1,
      O => n_0_sfd_enable_i_3
    );
sfd_enable_i_4: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => n_0_sfd_enable_i_6,
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      O => n_0_sfd_enable_i_4
    );
sfd_enable_i_5: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000040000000"
    )
    port map (
      I0 => p_0_in(3),
      I1 => p_0_in(2),
      I2 => D(2),
      I3 => D(3),
      I4 => D(0),
      I5 => D(1),
      O => n_0_sfd_enable_i_5
    );
sfd_enable_i_6: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000040000000"
    )
    port map (
      I0 => \n_0_rxd_reg1_reg[3]\,
      I1 => \n_0_rxd_reg1_reg[0]\,
      I2 => p_0_in(2),
      I3 => p_0_in(3),
      I4 => \n_0_rxd_reg1_reg[2]\,
      I5 => \n_0_rxd_reg1_reg[1]\,
      O => n_0_sfd_enable_i_6
    );
sfd_enable_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => n_0_sfd_enable_i_1,
      Q => sfd_enable,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gmii_to_sgmii_gmii_to_sgmii_sync_block is
  port (
    data_out : out STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    I2 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of gmii_to_sgmii_gmii_to_sgmii_sync_block : entity is "gmii_to_sgmii_sync_block";
end gmii_to_sgmii_gmii_to_sgmii_sync_block;

architecture STRUCTURE of gmii_to_sgmii_gmii_to_sgmii_sync_block is
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  signal data_sync4 : STD_LOGIC;
  signal data_sync5 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg1 : label is std.standard.true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of data_sync_reg1 : label is "FD";
  attribute box_type : string;
  attribute box_type of data_sync_reg1 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg2 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg2 : label is "FD";
  attribute box_type of data_sync_reg2 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg3 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg3 : label is "FD";
  attribute box_type of data_sync_reg3 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg4 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg4 : label is "FD";
  attribute box_type of data_sync_reg4 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg5 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg5 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg5 : label is "FD";
  attribute box_type of data_sync_reg5 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg6 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg6 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg6 : label is "FD";
  attribute box_type of data_sync_reg6 : label is "PRIMITIVE";
begin
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I2,
      CE => '1',
      D => Q(0),
      Q => data_sync1,
      R => '0'
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I2,
      CE => '1',
      D => data_sync1,
      Q => data_sync2,
      R => '0'
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I2,
      CE => '1',
      D => data_sync2,
      Q => data_sync3,
      R => '0'
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I2,
      CE => '1',
      D => data_sync3,
      Q => data_sync4,
      R => '0'
    );
data_sync_reg5: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I2,
      CE => '1',
      D => data_sync4,
      Q => data_sync5,
      R => '0'
    );
data_sync_reg6: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I2,
      CE => '1',
      D => data_sync5,
      Q => data_out,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gmii_to_sgmii_gmii_to_sgmii_sync_block_10 is
  port (
    data_out : out STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    CLK : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of gmii_to_sgmii_gmii_to_sgmii_sync_block_10 : entity is "gmii_to_sgmii_sync_block";
end gmii_to_sgmii_gmii_to_sgmii_sync_block_10;

architecture STRUCTURE of gmii_to_sgmii_gmii_to_sgmii_sync_block_10 is
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  signal data_sync4 : STD_LOGIC;
  signal data_sync5 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg1 : label is std.standard.true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of data_sync_reg1 : label is "FD";
  attribute box_type : string;
  attribute box_type of data_sync_reg1 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg2 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg2 : label is "FD";
  attribute box_type of data_sync_reg2 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg3 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg3 : label is "FD";
  attribute box_type of data_sync_reg3 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg4 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg4 : label is "FD";
  attribute box_type of data_sync_reg4 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg5 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg5 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg5 : label is "FD";
  attribute box_type of data_sync_reg5 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg6 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg6 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg6 : label is "FD";
  attribute box_type of data_sync_reg6 : label is "PRIMITIVE";
begin
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => Q(0),
      Q => data_sync1,
      R => '0'
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync1,
      Q => data_sync2,
      R => '0'
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync2,
      Q => data_sync3,
      R => '0'
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync3,
      Q => data_sync4,
      R => '0'
    );
data_sync_reg5: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync4,
      Q => data_sync5,
      R => '0'
    );
data_sync_reg6: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync5,
      Q => data_out,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gmii_to_sgmii_gmii_to_sgmii_sync_block_11 is
  port (
    S : out STD_LOGIC_VECTOR ( 1 downto 0 );
    data_out : out STD_LOGIC;
    data_out1_out : in STD_LOGIC;
    data_out0_out : in STD_LOGIC;
    I1 : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 1 downto 0 );
    p_0_in1_in1_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    I2 : in STD_LOGIC;
    I3 : in STD_LOGIC;
    I4 : in STD_LOGIC_VECTOR ( 0 to 0 );
    CLK : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of gmii_to_sgmii_gmii_to_sgmii_sync_block_11 : entity is "gmii_to_sgmii_sync_block";
end gmii_to_sgmii_gmii_to_sgmii_sync_block_11;

architecture STRUCTURE of gmii_to_sgmii_gmii_to_sgmii_sync_block_11 is
  signal \^data_out\ : STD_LOGIC;
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  signal data_sync4 : STD_LOGIC;
  signal data_sync5 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg1 : label is std.standard.true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of data_sync_reg1 : label is "FD";
  attribute box_type : string;
  attribute box_type of data_sync_reg1 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg2 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg2 : label is "FD";
  attribute box_type of data_sync_reg2 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg3 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg3 : label is "FD";
  attribute box_type of data_sync_reg3 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg4 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg4 : label is "FD";
  attribute box_type of data_sync_reg4 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg5 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg5 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg5 : label is "FD";
  attribute box_type of data_sync_reg5 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg6 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg6 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg6 : label is "FD";
  attribute box_type of data_sync_reg6 : label is "PRIMITIVE";
begin
  data_out <= \^data_out\;
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => I4(0),
      Q => data_sync1,
      R => '0'
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync1,
      Q => data_sync2,
      R => '0'
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync2,
      Q => data_sync3,
      R => '0'
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync3,
      Q => data_sync4,
      R => '0'
    );
data_sync_reg5: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync4,
      Q => data_sync5,
      R => '0'
    );
data_sync_reg6: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync5,
      Q => \^data_out\,
      R => '0'
    );
\rd_occupancy[3]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"69969669"
    )
    port map (
      I0 => \^data_out\,
      I1 => data_out1_out,
      I2 => I2,
      I3 => I3,
      I4 => Q(1),
      O => S(1)
    );
\rd_occupancy[3]_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9669699669969669"
    )
    port map (
      I0 => \^data_out\,
      I1 => data_out1_out,
      I2 => data_out0_out,
      I3 => I1,
      I4 => Q(0),
      I5 => p_0_in1_in1_in(0),
      O => S(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gmii_to_sgmii_gmii_to_sgmii_sync_block_12 is
  port (
    S : out STD_LOGIC_VECTOR ( 0 to 0 );
    data_out : out STD_LOGIC;
    O1 : out STD_LOGIC_VECTOR ( 1 downto 0 );
    p_0_in1_in1_in : out STD_LOGIC_VECTOR ( 1 downto 0 );
    I1 : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 2 downto 0 );
    data_out2_out : in STD_LOGIC;
    data_out1_out : in STD_LOGIC;
    data_out0_out : in STD_LOGIC;
    I2 : in STD_LOGIC;
    I3 : in STD_LOGIC_VECTOR ( 0 to 0 );
    CLK : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of gmii_to_sgmii_gmii_to_sgmii_sync_block_12 : entity is "gmii_to_sgmii_sync_block";
end gmii_to_sgmii_gmii_to_sgmii_sync_block_12;

architecture STRUCTURE of gmii_to_sgmii_gmii_to_sgmii_sync_block_12 is
  signal \^data_out\ : STD_LOGIC;
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  signal data_sync4 : STD_LOGIC;
  signal data_sync5 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg1 : label is std.standard.true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of data_sync_reg1 : label is "FD";
  attribute box_type : string;
  attribute box_type of data_sync_reg1 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg2 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg2 : label is "FD";
  attribute box_type of data_sync_reg2 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg3 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg3 : label is "FD";
  attribute box_type of data_sync_reg3 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg4 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg4 : label is "FD";
  attribute box_type of data_sync_reg4 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg5 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg5 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg5 : label is "FD";
  attribute box_type of data_sync_reg5 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg6 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg6 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg6 : label is "FD";
  attribute box_type of data_sync_reg6 : label is "PRIMITIVE";
begin
  data_out <= \^data_out\;
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => I3(0),
      Q => data_sync1,
      R => '0'
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync1,
      Q => data_sync2,
      R => '0'
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync2,
      Q => data_sync3,
      R => '0'
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync3,
      Q => data_sync4,
      R => '0'
    );
data_sync_reg5: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync4,
      Q => data_sync5,
      R => '0'
    );
data_sync_reg6: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync5,
      Q => \^data_out\,
      R => '0'
    );
\rd_occupancy[3]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
    port map (
      I0 => \^data_out\,
      I1 => I1,
      I2 => data_out1_out,
      I3 => data_out2_out,
      O => p_0_in1_in1_in(1)
    );
\rd_occupancy[3]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
    port map (
      I0 => \^data_out\,
      I1 => I1,
      I2 => data_out0_out,
      I3 => I2,
      I4 => data_out2_out,
      I5 => data_out1_out,
      O => p_0_in1_in1_in(0)
    );
\rd_occupancy[3]_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9669"
    )
    port map (
      I0 => \^data_out\,
      I1 => data_out2_out,
      I2 => I1,
      I3 => Q(1),
      O => O1(1)
    );
\rd_occupancy[3]_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9669699669969669"
    )
    port map (
      I0 => \^data_out\,
      I1 => data_out2_out,
      I2 => data_out1_out,
      I3 => data_out0_out,
      I4 => Q(0),
      I5 => I1,
      O => O1(0)
    );
\rd_occupancy[5]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"69"
    )
    port map (
      I0 => \^data_out\,
      I1 => I1,
      I2 => Q(2),
      O => S(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gmii_to_sgmii_gmii_to_sgmii_sync_block_13 is
  port (
    S : out STD_LOGIC_VECTOR ( 0 to 0 );
    data_out : out STD_LOGIC;
    p_0_in1_in1_in : out STD_LOGIC_VECTOR ( 2 downto 0 );
    O1 : out STD_LOGIC_VECTOR ( 0 to 0 );
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    data_out1_out : in STD_LOGIC;
    data_out0_out : in STD_LOGIC;
    data_out3_out : in STD_LOGIC;
    data_out2_out : in STD_LOGIC;
    I1 : in STD_LOGIC_VECTOR ( 0 to 0 );
    CLK : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of gmii_to_sgmii_gmii_to_sgmii_sync_block_13 : entity is "gmii_to_sgmii_sync_block";
end gmii_to_sgmii_gmii_to_sgmii_sync_block_13;

architecture STRUCTURE of gmii_to_sgmii_gmii_to_sgmii_sync_block_13 is
  signal \^data_out\ : STD_LOGIC;
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  signal data_sync4 : STD_LOGIC;
  signal data_sync5 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg1 : label is std.standard.true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of data_sync_reg1 : label is "FD";
  attribute box_type : string;
  attribute box_type of data_sync_reg1 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg2 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg2 : label is "FD";
  attribute box_type of data_sync_reg2 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg3 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg3 : label is "FD";
  attribute box_type of data_sync_reg3 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg4 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg4 : label is "FD";
  attribute box_type of data_sync_reg4 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg5 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg5 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg5 : label is "FD";
  attribute box_type of data_sync_reg5 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg6 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg6 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg6 : label is "FD";
  attribute box_type of data_sync_reg6 : label is "PRIMITIVE";
begin
  data_out <= \^data_out\;
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => I1(0),
      Q => data_sync1,
      R => '0'
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync1,
      Q => data_sync2,
      R => '0'
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync2,
      Q => data_sync3,
      R => '0'
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync3,
      Q => data_sync4,
      R => '0'
    );
data_sync_reg5: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync4,
      Q => data_sync5,
      R => '0'
    );
data_sync_reg6: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync5,
      Q => \^data_out\,
      R => '0'
    );
\rd_occupancy[3]_i_10\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \^data_out\,
      I1 => data_out3_out,
      O => O1(0)
    );
\rd_occupancy[3]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
    port map (
      I0 => \^data_out\,
      I1 => data_out2_out,
      I2 => data_out3_out,
      O => p_0_in1_in1_in(1)
    );
\rd_occupancy[3]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96696996"
    )
    port map (
      I0 => \^data_out\,
      I1 => data_out1_out,
      I2 => data_out0_out,
      I3 => data_out3_out,
      I4 => data_out2_out,
      O => p_0_in1_in1_in(0)
    );
\rd_occupancy[5]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \^data_out\,
      I1 => data_out3_out,
      O => p_0_in1_in1_in(2)
    );
\rd_occupancy[5]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => \^data_out\,
      I1 => Q(0),
      O => S(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gmii_to_sgmii_gmii_to_sgmii_sync_block_14 is
  port (
    O1 : out STD_LOGIC;
    data_out : out STD_LOGIC;
    initialize_ram_complete_sync_reg1 : in STD_LOGIC;
    data_in : in STD_LOGIC;
    CLK : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of gmii_to_sgmii_gmii_to_sgmii_sync_block_14 : entity is "gmii_to_sgmii_sync_block";
end gmii_to_sgmii_gmii_to_sgmii_sync_block_14;

architecture STRUCTURE of gmii_to_sgmii_gmii_to_sgmii_sync_block_14 is
  signal \^data_out\ : STD_LOGIC;
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  signal data_sync4 : STD_LOGIC;
  signal data_sync5 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg1 : label is std.standard.true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of data_sync_reg1 : label is "FD";
  attribute box_type : string;
  attribute box_type of data_sync_reg1 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg2 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg2 : label is "FD";
  attribute box_type of data_sync_reg2 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg3 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg3 : label is "FD";
  attribute box_type of data_sync_reg3 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg4 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg4 : label is "FD";
  attribute box_type of data_sync_reg4 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg5 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg5 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg5 : label is "FD";
  attribute box_type of data_sync_reg5 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg6 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg6 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg6 : label is "FD";
  attribute box_type of data_sync_reg6 : label is "PRIMITIVE";
begin
  data_out <= \^data_out\;
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_in,
      Q => data_sync1,
      R => '0'
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync1,
      Q => data_sync2,
      R => '0'
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync2,
      Q => data_sync3,
      R => '0'
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync3,
      Q => data_sync4,
      R => '0'
    );
data_sync_reg5: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync4,
      Q => data_sync5,
      R => '0'
    );
data_sync_reg6: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync5,
      Q => \^data_out\,
      R => '0'
    );
initialize_ram_complete_sync_ris_edg_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \^data_out\,
      I1 => initialize_ram_complete_sync_reg1,
      O => O1
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gmii_to_sgmii_gmii_to_sgmii_sync_block_3 is
  port (
    data_out : out STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    I2 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of gmii_to_sgmii_gmii_to_sgmii_sync_block_3 : entity is "gmii_to_sgmii_sync_block";
end gmii_to_sgmii_gmii_to_sgmii_sync_block_3;

architecture STRUCTURE of gmii_to_sgmii_gmii_to_sgmii_sync_block_3 is
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  signal data_sync4 : STD_LOGIC;
  signal data_sync5 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg1 : label is std.standard.true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of data_sync_reg1 : label is "FD";
  attribute box_type : string;
  attribute box_type of data_sync_reg1 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg2 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg2 : label is "FD";
  attribute box_type of data_sync_reg2 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg3 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg3 : label is "FD";
  attribute box_type of data_sync_reg3 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg4 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg4 : label is "FD";
  attribute box_type of data_sync_reg4 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg5 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg5 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg5 : label is "FD";
  attribute box_type of data_sync_reg5 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg6 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg6 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg6 : label is "FD";
  attribute box_type of data_sync_reg6 : label is "PRIMITIVE";
begin
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I2,
      CE => '1',
      D => Q(0),
      Q => data_sync1,
      R => '0'
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I2,
      CE => '1',
      D => data_sync1,
      Q => data_sync2,
      R => '0'
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I2,
      CE => '1',
      D => data_sync2,
      Q => data_sync3,
      R => '0'
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I2,
      CE => '1',
      D => data_sync3,
      Q => data_sync4,
      R => '0'
    );
data_sync_reg5: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I2,
      CE => '1',
      D => data_sync4,
      Q => data_sync5,
      R => '0'
    );
data_sync_reg6: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I2,
      CE => '1',
      D => data_sync5,
      Q => data_out,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gmii_to_sgmii_gmii_to_sgmii_sync_block_33 is
  port (
    data_out : out STD_LOGIC;
    speed_is_100 : in STD_LOGIC;
    CLK : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of gmii_to_sgmii_gmii_to_sgmii_sync_block_33 : entity is "gmii_to_sgmii_sync_block";
end gmii_to_sgmii_gmii_to_sgmii_sync_block_33;

architecture STRUCTURE of gmii_to_sgmii_gmii_to_sgmii_sync_block_33 is
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  signal data_sync4 : STD_LOGIC;
  signal data_sync5 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg1 : label is std.standard.true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of data_sync_reg1 : label is "FD";
  attribute box_type : string;
  attribute box_type of data_sync_reg1 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg2 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg2 : label is "FD";
  attribute box_type of data_sync_reg2 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg3 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg3 : label is "FD";
  attribute box_type of data_sync_reg3 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg4 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg4 : label is "FD";
  attribute box_type of data_sync_reg4 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg5 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg5 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg5 : label is "FD";
  attribute box_type of data_sync_reg5 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg6 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg6 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg6 : label is "FD";
  attribute box_type of data_sync_reg6 : label is "PRIMITIVE";
begin
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => speed_is_100,
      Q => data_sync1,
      R => '0'
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync1,
      Q => data_sync2,
      R => '0'
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync2,
      Q => data_sync3,
      R => '0'
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync3,
      Q => data_sync4,
      R => '0'
    );
data_sync_reg5: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync4,
      Q => data_sync5,
      R => '0'
    );
data_sync_reg6: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync5,
      Q => data_out,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gmii_to_sgmii_gmii_to_sgmii_sync_block_34 is
  port (
    data_out : out STD_LOGIC;
    speed_is_10_100 : in STD_LOGIC;
    CLK : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of gmii_to_sgmii_gmii_to_sgmii_sync_block_34 : entity is "gmii_to_sgmii_sync_block";
end gmii_to_sgmii_gmii_to_sgmii_sync_block_34;

architecture STRUCTURE of gmii_to_sgmii_gmii_to_sgmii_sync_block_34 is
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  signal data_sync4 : STD_LOGIC;
  signal data_sync5 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg1 : label is std.standard.true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of data_sync_reg1 : label is "FD";
  attribute box_type : string;
  attribute box_type of data_sync_reg1 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg2 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg2 : label is "FD";
  attribute box_type of data_sync_reg2 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg3 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg3 : label is "FD";
  attribute box_type of data_sync_reg3 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg4 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg4 : label is "FD";
  attribute box_type of data_sync_reg4 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg5 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg5 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg5 : label is "FD";
  attribute box_type of data_sync_reg5 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg6 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg6 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg6 : label is "FD";
  attribute box_type of data_sync_reg6 : label is "PRIMITIVE";
begin
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => speed_is_10_100,
      Q => data_sync1,
      R => '0'
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync1,
      Q => data_sync2,
      R => '0'
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync2,
      Q => data_sync3,
      R => '0'
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync3,
      Q => data_sync4,
      R => '0'
    );
data_sync_reg5: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync4,
      Q => data_sync5,
      R => '0'
    );
data_sync_reg6: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync5,
      Q => data_out,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gmii_to_sgmii_gmii_to_sgmii_sync_block_4 is
  port (
    data_out : out STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    I2 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of gmii_to_sgmii_gmii_to_sgmii_sync_block_4 : entity is "gmii_to_sgmii_sync_block";
end gmii_to_sgmii_gmii_to_sgmii_sync_block_4;

architecture STRUCTURE of gmii_to_sgmii_gmii_to_sgmii_sync_block_4 is
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  signal data_sync4 : STD_LOGIC;
  signal data_sync5 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg1 : label is std.standard.true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of data_sync_reg1 : label is "FD";
  attribute box_type : string;
  attribute box_type of data_sync_reg1 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg2 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg2 : label is "FD";
  attribute box_type of data_sync_reg2 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg3 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg3 : label is "FD";
  attribute box_type of data_sync_reg3 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg4 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg4 : label is "FD";
  attribute box_type of data_sync_reg4 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg5 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg5 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg5 : label is "FD";
  attribute box_type of data_sync_reg5 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg6 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg6 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg6 : label is "FD";
  attribute box_type of data_sync_reg6 : label is "PRIMITIVE";
begin
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I2,
      CE => '1',
      D => Q(0),
      Q => data_sync1,
      R => '0'
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I2,
      CE => '1',
      D => data_sync1,
      Q => data_sync2,
      R => '0'
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I2,
      CE => '1',
      D => data_sync2,
      Q => data_sync3,
      R => '0'
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I2,
      CE => '1',
      D => data_sync3,
      Q => data_sync4,
      R => '0'
    );
data_sync_reg5: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I2,
      CE => '1',
      D => data_sync4,
      Q => data_sync5,
      R => '0'
    );
data_sync_reg6: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I2,
      CE => '1',
      D => data_sync5,
      Q => data_out,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gmii_to_sgmii_gmii_to_sgmii_sync_block_5 is
  port (
    S : out STD_LOGIC_VECTOR ( 1 downto 0 );
    data_out : out STD_LOGIC;
    p_2_in21_in : in STD_LOGIC;
    p_3_in24_in : in STD_LOGIC;
    I1 : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 1 downto 0 );
    I2 : in STD_LOGIC;
    I3 : in STD_LOGIC;
    I4 : in STD_LOGIC;
    I5 : in STD_LOGIC_VECTOR ( 0 to 0 );
    I6 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of gmii_to_sgmii_gmii_to_sgmii_sync_block_5 : entity is "gmii_to_sgmii_sync_block";
end gmii_to_sgmii_gmii_to_sgmii_sync_block_5;

architecture STRUCTURE of gmii_to_sgmii_gmii_to_sgmii_sync_block_5 is
  signal \^data_out\ : STD_LOGIC;
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  signal data_sync4 : STD_LOGIC;
  signal data_sync5 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg1 : label is std.standard.true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of data_sync_reg1 : label is "FD";
  attribute box_type : string;
  attribute box_type of data_sync_reg1 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg2 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg2 : label is "FD";
  attribute box_type of data_sync_reg2 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg3 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg3 : label is "FD";
  attribute box_type of data_sync_reg3 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg4 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg4 : label is "FD";
  attribute box_type of data_sync_reg4 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg5 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg5 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg5 : label is "FD";
  attribute box_type of data_sync_reg5 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg6 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg6 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg6 : label is "FD";
  attribute box_type of data_sync_reg6 : label is "PRIMITIVE";
begin
  data_out <= \^data_out\;
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I6,
      CE => '1',
      D => I5(0),
      Q => data_sync1,
      R => '0'
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I6,
      CE => '1',
      D => data_sync1,
      Q => data_sync2,
      R => '0'
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I6,
      CE => '1',
      D => data_sync2,
      Q => data_sync3,
      R => '0'
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I6,
      CE => '1',
      D => data_sync3,
      Q => data_sync4,
      R => '0'
    );
data_sync_reg5: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I6,
      CE => '1',
      D => data_sync4,
      Q => data_sync5,
      R => '0'
    );
data_sync_reg6: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I6,
      CE => '1',
      D => data_sync5,
      Q => \^data_out\,
      R => '0'
    );
\wr_occupancy[3]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"69969669"
    )
    port map (
      I0 => Q(1),
      I1 => \^data_out\,
      I2 => p_2_in21_in,
      I3 => I3,
      I4 => I4,
      O => S(1)
    );
\wr_occupancy[3]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9669699669969669"
    )
    port map (
      I0 => \^data_out\,
      I1 => p_2_in21_in,
      I2 => p_3_in24_in,
      I3 => I1,
      I4 => Q(0),
      I5 => I2,
      O => S(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gmii_to_sgmii_gmii_to_sgmii_sync_block_6 is
  port (
    S : out STD_LOGIC_VECTOR ( 1 downto 0 );
    data_out : out STD_LOGIC;
    O1 : out STD_LOGIC_VECTOR ( 0 to 0 );
    p_1_in18_in : in STD_LOGIC;
    p_2_in21_in : in STD_LOGIC;
    p_3_in24_in : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 2 downto 0 );
    I1 : in STD_LOGIC;
    I2 : in STD_LOGIC_VECTOR ( 0 to 0 );
    I3 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of gmii_to_sgmii_gmii_to_sgmii_sync_block_6 : entity is "gmii_to_sgmii_sync_block";
end gmii_to_sgmii_gmii_to_sgmii_sync_block_6;

architecture STRUCTURE of gmii_to_sgmii_gmii_to_sgmii_sync_block_6 is
  signal \^data_out\ : STD_LOGIC;
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  signal data_sync4 : STD_LOGIC;
  signal data_sync5 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg1 : label is std.standard.true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of data_sync_reg1 : label is "FD";
  attribute box_type : string;
  attribute box_type of data_sync_reg1 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg2 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg2 : label is "FD";
  attribute box_type of data_sync_reg2 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg3 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg3 : label is "FD";
  attribute box_type of data_sync_reg3 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg4 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg4 : label is "FD";
  attribute box_type of data_sync_reg4 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg5 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg5 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg5 : label is "FD";
  attribute box_type of data_sync_reg5 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg6 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg6 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg6 : label is "FD";
  attribute box_type of data_sync_reg6 : label is "PRIMITIVE";
begin
  data_out <= \^data_out\;
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I3,
      CE => '1',
      D => I2(0),
      Q => data_sync1,
      R => '0'
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I3,
      CE => '1',
      D => data_sync1,
      Q => data_sync2,
      R => '0'
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I3,
      CE => '1',
      D => data_sync2,
      Q => data_sync3,
      R => '0'
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I3,
      CE => '1',
      D => data_sync3,
      Q => data_sync4,
      R => '0'
    );
data_sync_reg5: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I3,
      CE => '1',
      D => data_sync4,
      Q => data_sync5,
      R => '0'
    );
data_sync_reg6: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I3,
      CE => '1',
      D => data_sync5,
      Q => \^data_out\,
      R => '0'
    );
\wr_occupancy[3]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9669"
    )
    port map (
      I0 => Q(1),
      I1 => \^data_out\,
      I2 => p_1_in18_in,
      I3 => I1,
      O => S(1)
    );
\wr_occupancy[3]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9669699669969669"
    )
    port map (
      I0 => \^data_out\,
      I1 => p_1_in18_in,
      I2 => p_2_in21_in,
      I3 => p_3_in24_in,
      I4 => Q(0),
      I5 => I1,
      O => S(0)
    );
\wr_occupancy[5]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"69"
    )
    port map (
      I0 => Q(2),
      I1 => \^data_out\,
      I2 => I1,
      O => O1(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gmii_to_sgmii_gmii_to_sgmii_sync_block_7 is
  port (
    S : out STD_LOGIC_VECTOR ( 0 to 0 );
    data_out : out STD_LOGIC;
    O1 : out STD_LOGIC;
    ADDRD : in STD_LOGIC_VECTOR ( 0 to 0 );
    I1 : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    I2 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of gmii_to_sgmii_gmii_to_sgmii_sync_block_7 : entity is "gmii_to_sgmii_sync_block";
end gmii_to_sgmii_gmii_to_sgmii_sync_block_7;

architecture STRUCTURE of gmii_to_sgmii_gmii_to_sgmii_sync_block_7 is
  signal \^data_out\ : STD_LOGIC;
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  signal data_sync4 : STD_LOGIC;
  signal data_sync5 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg1 : label is std.standard.true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of data_sync_reg1 : label is "FD";
  attribute box_type : string;
  attribute box_type of data_sync_reg1 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg2 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg2 : label is "FD";
  attribute box_type of data_sync_reg2 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg3 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg3 : label is "FD";
  attribute box_type of data_sync_reg3 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg4 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg4 : label is "FD";
  attribute box_type of data_sync_reg4 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg5 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg5 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg5 : label is "FD";
  attribute box_type of data_sync_reg5 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg6 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg6 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg6 : label is "FD";
  attribute box_type of data_sync_reg6 : label is "PRIMITIVE";
begin
  data_out <= \^data_out\;
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I2,
      CE => '1',
      D => Q(0),
      Q => data_sync1,
      R => '0'
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I2,
      CE => '1',
      D => data_sync1,
      Q => data_sync2,
      R => '0'
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I2,
      CE => '1',
      D => data_sync2,
      Q => data_sync3,
      R => '0'
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I2,
      CE => '1',
      D => data_sync3,
      Q => data_sync4,
      R => '0'
    );
data_sync_reg5: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I2,
      CE => '1',
      D => data_sync4,
      Q => data_sync5,
      R => '0'
    );
data_sync_reg6: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I2,
      CE => '1',
      D => data_sync5,
      Q => \^data_out\,
      R => '0'
    );
\wr_occupancy[3]_i_6\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \^data_out\,
      I1 => I1,
      O => O1
    );
\wr_occupancy[5]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => ADDRD(0),
      I1 => \^data_out\,
      O => S(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gmii_to_sgmii_gmii_to_sgmii_sync_block_8 is
  port (
    data_out : out STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    CLK : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of gmii_to_sgmii_gmii_to_sgmii_sync_block_8 : entity is "gmii_to_sgmii_sync_block";
end gmii_to_sgmii_gmii_to_sgmii_sync_block_8;

architecture STRUCTURE of gmii_to_sgmii_gmii_to_sgmii_sync_block_8 is
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  signal data_sync4 : STD_LOGIC;
  signal data_sync5 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg1 : label is std.standard.true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of data_sync_reg1 : label is "FD";
  attribute box_type : string;
  attribute box_type of data_sync_reg1 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg2 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg2 : label is "FD";
  attribute box_type of data_sync_reg2 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg3 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg3 : label is "FD";
  attribute box_type of data_sync_reg3 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg4 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg4 : label is "FD";
  attribute box_type of data_sync_reg4 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg5 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg5 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg5 : label is "FD";
  attribute box_type of data_sync_reg5 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg6 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg6 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg6 : label is "FD";
  attribute box_type of data_sync_reg6 : label is "PRIMITIVE";
begin
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => Q(0),
      Q => data_sync1,
      R => '0'
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync1,
      Q => data_sync2,
      R => '0'
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync2,
      Q => data_sync3,
      R => '0'
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync3,
      Q => data_sync4,
      R => '0'
    );
data_sync_reg5: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync4,
      Q => data_sync5,
      R => '0'
    );
data_sync_reg6: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync5,
      Q => data_out,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gmii_to_sgmii_gmii_to_sgmii_sync_block_9 is
  port (
    data_out : out STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    CLK : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of gmii_to_sgmii_gmii_to_sgmii_sync_block_9 : entity is "gmii_to_sgmii_sync_block";
end gmii_to_sgmii_gmii_to_sgmii_sync_block_9;

architecture STRUCTURE of gmii_to_sgmii_gmii_to_sgmii_sync_block_9 is
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  signal data_sync4 : STD_LOGIC;
  signal data_sync5 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg1 : label is std.standard.true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of data_sync_reg1 : label is "FD";
  attribute box_type : string;
  attribute box_type of data_sync_reg1 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg2 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg2 : label is "FD";
  attribute box_type of data_sync_reg2 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg3 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg3 : label is "FD";
  attribute box_type of data_sync_reg3 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg4 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg4 : label is "FD";
  attribute box_type of data_sync_reg4 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg5 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg5 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg5 : label is "FD";
  attribute box_type of data_sync_reg5 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg6 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg6 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg6 : label is "FD";
  attribute box_type of data_sync_reg6 : label is "PRIMITIVE";
begin
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => Q(0),
      Q => data_sync1,
      R => '0'
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync1,
      Q => data_sync2,
      R => '0'
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync2,
      Q => data_sync3,
      R => '0'
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync3,
      Q => data_sync4,
      R => '0'
    );
data_sync_reg5: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync4,
      Q => data_sync5,
      R => '0'
    );
data_sync_reg6: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync5,
      Q => data_out,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0\ is
  port (
    resetdone : out STD_LOGIC;
    data_in : in STD_LOGIC;
    CLK : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0\ : entity is "gmii_to_sgmii_sync_block";
end \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0\;

architecture STRUCTURE of \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0\ is
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  signal data_sync4 : STD_LOGIC;
  signal data_sync5 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg1 : label is std.standard.true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of data_sync_reg1 : label is "FD";
  attribute box_type : string;
  attribute box_type of data_sync_reg1 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg2 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg2 : label is "FD";
  attribute box_type of data_sync_reg2 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg3 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg3 : label is "FD";
  attribute box_type of data_sync_reg3 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg4 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg4 : label is "FD";
  attribute box_type of data_sync_reg4 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg5 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg5 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg5 : label is "FD";
  attribute box_type of data_sync_reg5 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg6 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg6 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg6 : label is "FD";
  attribute box_type of data_sync_reg6 : label is "PRIMITIVE";
begin
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_in,
      Q => data_sync1,
      R => '0'
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync1,
      Q => data_sync2,
      R => '0'
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync2,
      Q => data_sync3,
      R => '0'
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync3,
      Q => data_sync4,
      R => '0'
    );
data_sync_reg5: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync4,
      Q => data_sync5,
      R => '0'
    );
data_sync_reg6: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync5,
      Q => resetdone,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_15\ is
  port (
    data_out : out STD_LOGIC;
    data_in : in STD_LOGIC;
    independent_clock_bufg : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_15\ : entity is "gmii_to_sgmii_sync_block";
end \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_15\;

architecture STRUCTURE of \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_15\ is
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  signal data_sync4 : STD_LOGIC;
  signal data_sync5 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg1 : label is std.standard.true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of data_sync_reg1 : label is "FD";
  attribute box_type : string;
  attribute box_type of data_sync_reg1 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg2 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg2 : label is "FD";
  attribute box_type of data_sync_reg2 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg3 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg3 : label is "FD";
  attribute box_type of data_sync_reg3 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg4 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg4 : label is "FD";
  attribute box_type of data_sync_reg4 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg5 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg5 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg5 : label is "FD";
  attribute box_type of data_sync_reg5 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg6 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg6 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg6 : label is "FD";
  attribute box_type of data_sync_reg6 : label is "PRIMITIVE";
begin
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_in,
      Q => data_sync1,
      R => '0'
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync1,
      Q => data_sync2,
      R => '0'
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync2,
      Q => data_sync3,
      R => '0'
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync3,
      Q => data_sync4,
      R => '0'
    );
data_sync_reg5: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync4,
      Q => data_sync5,
      R => '0'
    );
data_sync_reg6: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync5,
      Q => data_out,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_18\ is
  port (
    data_out : out STD_LOGIC;
    I2 : in STD_LOGIC;
    CLK : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_18\ : entity is "gmii_to_sgmii_sync_block";
end \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_18\;

architecture STRUCTURE of \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_18\ is
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  signal data_sync4 : STD_LOGIC;
  signal data_sync5 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg1 : label is std.standard.true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of data_sync_reg1 : label is "FD";
  attribute box_type : string;
  attribute box_type of data_sync_reg1 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg2 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg2 : label is "FD";
  attribute box_type of data_sync_reg2 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg3 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg3 : label is "FD";
  attribute box_type of data_sync_reg3 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg4 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg4 : label is "FD";
  attribute box_type of data_sync_reg4 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg5 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg5 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg5 : label is "FD";
  attribute box_type of data_sync_reg5 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg6 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg6 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg6 : label is "FD";
  attribute box_type of data_sync_reg6 : label is "PRIMITIVE";
begin
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => I2,
      Q => data_sync1,
      R => '0'
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync1,
      Q => data_sync2,
      R => '0'
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync2,
      Q => data_sync3,
      R => '0'
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync3,
      Q => data_sync4,
      R => '0'
    );
data_sync_reg5: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync4,
      Q => data_sync5,
      R => '0'
    );
data_sync_reg6: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_sync5,
      Q => data_out,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_19\ is
  port (
    data_out : out STD_LOGIC;
    data_in : in STD_LOGIC;
    independent_clock_bufg : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_19\ : entity is "gmii_to_sgmii_sync_block";
end \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_19\;

architecture STRUCTURE of \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_19\ is
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  signal data_sync4 : STD_LOGIC;
  signal data_sync5 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg1 : label is std.standard.true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of data_sync_reg1 : label is "FD";
  attribute box_type : string;
  attribute box_type of data_sync_reg1 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg2 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg2 : label is "FD";
  attribute box_type of data_sync_reg2 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg3 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg3 : label is "FD";
  attribute box_type of data_sync_reg3 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg4 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg4 : label is "FD";
  attribute box_type of data_sync_reg4 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg5 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg5 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg5 : label is "FD";
  attribute box_type of data_sync_reg5 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg6 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg6 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg6 : label is "FD";
  attribute box_type of data_sync_reg6 : label is "PRIMITIVE";
begin
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_in,
      Q => data_sync1,
      R => '0'
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync1,
      Q => data_sync2,
      R => '0'
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync2,
      Q => data_sync3,
      R => '0'
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync3,
      Q => data_sync4,
      R => '0'
    );
data_sync_reg5: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync4,
      Q => data_sync5,
      R => '0'
    );
data_sync_reg6: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync5,
      Q => data_out,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_2\ is
  port (
    data_out : out STD_LOGIC;
    status_vector : in STD_LOGIC_VECTOR ( 0 to 0 );
    independent_clock_bufg : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_2\ : entity is "gmii_to_sgmii_sync_block";
end \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_2\;

architecture STRUCTURE of \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_2\ is
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  signal data_sync4 : STD_LOGIC;
  signal data_sync5 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg1 : label is std.standard.true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of data_sync_reg1 : label is "FD";
  attribute box_type : string;
  attribute box_type of data_sync_reg1 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg2 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg2 : label is "FD";
  attribute box_type of data_sync_reg2 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg3 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg3 : label is "FD";
  attribute box_type of data_sync_reg3 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg4 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg4 : label is "FD";
  attribute box_type of data_sync_reg4 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg5 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg5 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg5 : label is "FD";
  attribute box_type of data_sync_reg5 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg6 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg6 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg6 : label is "FD";
  attribute box_type of data_sync_reg6 : label is "PRIMITIVE";
begin
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => status_vector(0),
      Q => data_sync1,
      R => '0'
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync1,
      Q => data_sync2,
      R => '0'
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync2,
      Q => data_sync3,
      R => '0'
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync3,
      Q => data_sync4,
      R => '0'
    );
data_sync_reg5: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync4,
      Q => data_sync5,
      R => '0'
    );
data_sync_reg6: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync5,
      Q => data_out,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_20\ is
  port (
    O1 : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    reset_time_out : in STD_LOGIC;
    \out\ : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I1 : in STD_LOGIC;
    I2 : in STD_LOGIC_VECTOR ( 0 to 0 );
    I3 : in STD_LOGIC;
    I4 : in STD_LOGIC;
    mmcm_lock_reclocked : in STD_LOGIC;
    I5 : in STD_LOGIC;
    I6 : in STD_LOGIC;
    txresetdone_s3 : in STD_LOGIC;
    I7 : in STD_LOGIC;
    I8 : in STD_LOGIC;
    independent_clock_bufg : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_20\ : entity is "gmii_to_sgmii_sync_block";
end \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_20\;

architecture STRUCTURE of \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_20\ is
  signal cplllock_sync : STD_LOGIC;
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  signal data_sync4 : STD_LOGIC;
  signal data_sync5 : STD_LOGIC;
  signal \n_0_FSM_sequential_tx_state[3]_i_6\ : STD_LOGIC;
  signal \n_0_FSM_sequential_tx_state[3]_i_7\ : STD_LOGIC;
  signal \n_0_FSM_sequential_tx_state_reg[3]_i_3\ : STD_LOGIC;
  signal n_0_reset_time_out_i_3 : STD_LOGIC;
  signal n_0_reset_time_out_i_4 : STD_LOGIC;
  signal reset_time_out_0 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg1 : label is std.standard.true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of data_sync_reg1 : label is "FD";
  attribute box_type : string;
  attribute box_type of data_sync_reg1 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg2 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg2 : label is "FD";
  attribute box_type of data_sync_reg2 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg3 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg3 : label is "FD";
  attribute box_type of data_sync_reg3 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg4 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg4 : label is "FD";
  attribute box_type of data_sync_reg4 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg5 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg5 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg5 : label is "FD";
  attribute box_type of data_sync_reg5 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg6 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg6 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg6 : label is "FD";
  attribute box_type of data_sync_reg6 : label is "PRIMITIVE";
begin
\FSM_sequential_tx_state[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00338BBB00338B88"
    )
    port map (
      I0 => \n_0_FSM_sequential_tx_state_reg[3]_i_3\,
      I1 => \out\(0),
      I2 => I2(0),
      I3 => I3,
      I4 => \out\(3),
      I5 => I1,
      O => E(0)
    );
\FSM_sequential_tx_state[3]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F400F400F4FFF400"
    )
    port map (
      I0 => reset_time_out,
      I1 => I4,
      I2 => mmcm_lock_reclocked,
      I3 => \out\(2),
      I4 => I5,
      I5 => cplllock_sync,
      O => \n_0_FSM_sequential_tx_state[3]_i_6\
    );
\FSM_sequential_tx_state[3]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F4FFF4FFF4FFF400"
    )
    port map (
      I0 => reset_time_out,
      I1 => I6,
      I2 => txresetdone_s3,
      I3 => \out\(2),
      I4 => I7,
      I5 => cplllock_sync,
      O => \n_0_FSM_sequential_tx_state[3]_i_7\
    );
\FSM_sequential_tx_state_reg[3]_i_3\: unisim.vcomponents.MUXF7
    port map (
      I0 => \n_0_FSM_sequential_tx_state[3]_i_6\,
      I1 => \n_0_FSM_sequential_tx_state[3]_i_7\,
      O => \n_0_FSM_sequential_tx_state_reg[3]_i_3\,
      S => \out\(1)
    );
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => I8,
      Q => data_sync1,
      R => '0'
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync1,
      Q => data_sync2,
      R => '0'
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync2,
      Q => data_sync3,
      R => '0'
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync3,
      Q => data_sync4,
      R => '0'
    );
data_sync_reg5: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync4,
      Q => data_sync5,
      R => '0'
    );
data_sync_reg6: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync5,
      Q => cplllock_sync,
      R => '0'
    );
reset_time_out_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => reset_time_out_0,
      I1 => n_0_reset_time_out_i_3,
      I2 => reset_time_out,
      O => O1
    );
reset_time_out_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1F0F1F0F100F1000"
    )
    port map (
      I0 => \out\(2),
      I1 => \out\(1),
      I2 => \out\(3),
      I3 => \out\(0),
      I4 => I1,
      I5 => n_0_reset_time_out_i_4,
      O => reset_time_out_0
    );
reset_time_out_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"303030302020FFFC"
    )
    port map (
      I0 => cplllock_sync,
      I1 => \out\(3),
      I2 => \out\(0),
      I3 => I1,
      I4 => \out\(1),
      I5 => \out\(2),
      O => n_0_reset_time_out_i_3
    );
reset_time_out_i_4: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
    port map (
      I0 => txresetdone_s3,
      I1 => cplllock_sync,
      I2 => \out\(1),
      I3 => \out\(2),
      I4 => mmcm_lock_reclocked,
      O => n_0_reset_time_out_i_4
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_21\ is
  port (
    O1 : out STD_LOGIC;
    SR : out STD_LOGIC_VECTOR ( 0 to 0 );
    mmcm_lock_reclocked : in STD_LOGIC;
    I1 : in STD_LOGIC;
    I2 : in STD_LOGIC;
    independent_clock_bufg : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_21\ : entity is "gmii_to_sgmii_sync_block";
end \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_21\;

architecture STRUCTURE of \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_21\ is
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  signal data_sync4 : STD_LOGIC;
  signal data_sync5 : STD_LOGIC;
  signal mmcm_lock_i : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg1 : label is std.standard.true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of data_sync_reg1 : label is "FD";
  attribute box_type : string;
  attribute box_type of data_sync_reg1 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg2 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg2 : label is "FD";
  attribute box_type of data_sync_reg2 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg3 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg3 : label is "FD";
  attribute box_type of data_sync_reg3 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg4 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg4 : label is "FD";
  attribute box_type of data_sync_reg4 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg5 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg5 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg5 : label is "FD";
  attribute box_type of data_sync_reg5 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg6 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg6 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg6 : label is "FD";
  attribute box_type of data_sync_reg6 : label is "PRIMITIVE";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \mmcm_lock_count[9]_i_1\ : label is "soft_lutpair96";
  attribute SOFT_HLUTNM of mmcm_lock_reclocked_i_1 : label is "soft_lutpair96";
begin
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => I2,
      Q => data_sync1,
      R => '0'
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync1,
      Q => data_sync2,
      R => '0'
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync2,
      Q => data_sync3,
      R => '0'
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync3,
      Q => data_sync4,
      R => '0'
    );
data_sync_reg5: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync4,
      Q => data_sync5,
      R => '0'
    );
data_sync_reg6: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync5,
      Q => mmcm_lock_i,
      R => '0'
    );
\mmcm_lock_count[9]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => mmcm_lock_i,
      O => SR(0)
    );
mmcm_lock_reclocked_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"E0"
    )
    port map (
      I0 => mmcm_lock_reclocked,
      I1 => I1,
      I2 => mmcm_lock_i,
      O => O1
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_22\ is
  port (
    data_out : out STD_LOGIC;
    data_in : in STD_LOGIC;
    I3 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_22\ : entity is "gmii_to_sgmii_sync_block";
end \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_22\;

architecture STRUCTURE of \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_22\ is
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  signal data_sync4 : STD_LOGIC;
  signal data_sync5 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg1 : label is std.standard.true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of data_sync_reg1 : label is "FD";
  attribute box_type : string;
  attribute box_type of data_sync_reg1 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg2 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg2 : label is "FD";
  attribute box_type of data_sync_reg2 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg3 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg3 : label is "FD";
  attribute box_type of data_sync_reg3 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg4 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg4 : label is "FD";
  attribute box_type of data_sync_reg4 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg5 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg5 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg5 : label is "FD";
  attribute box_type of data_sync_reg5 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg6 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg6 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg6 : label is "FD";
  attribute box_type of data_sync_reg6 : label is "PRIMITIVE";
begin
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I3,
      CE => '1',
      D => data_in,
      Q => data_sync1,
      R => '0'
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I3,
      CE => '1',
      D => data_sync1,
      Q => data_sync2,
      R => '0'
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I3,
      CE => '1',
      D => data_sync2,
      Q => data_sync3,
      R => '0'
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I3,
      CE => '1',
      D => data_sync3,
      Q => data_sync4,
      R => '0'
    );
data_sync_reg5: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I3,
      CE => '1',
      D => data_sync4,
      Q => data_sync5,
      R => '0'
    );
data_sync_reg6: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I3,
      CE => '1',
      D => data_sync5,
      Q => data_out,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_23\ is
  port (
    data_out : out STD_LOGIC;
    data_in : in STD_LOGIC;
    independent_clock_bufg : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_23\ : entity is "gmii_to_sgmii_sync_block";
end \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_23\;

architecture STRUCTURE of \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_23\ is
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  signal data_sync4 : STD_LOGIC;
  signal data_sync5 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg1 : label is std.standard.true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of data_sync_reg1 : label is "FD";
  attribute box_type : string;
  attribute box_type of data_sync_reg1 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg2 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg2 : label is "FD";
  attribute box_type of data_sync_reg2 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg3 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg3 : label is "FD";
  attribute box_type of data_sync_reg3 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg4 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg4 : label is "FD";
  attribute box_type of data_sync_reg4 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg5 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg5 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg5 : label is "FD";
  attribute box_type of data_sync_reg5 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg6 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg6 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg6 : label is "FD";
  attribute box_type of data_sync_reg6 : label is "PRIMITIVE";
begin
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_in,
      Q => data_sync1,
      R => '0'
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync1,
      Q => data_sync2,
      R => '0'
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync2,
      Q => data_sync3,
      R => '0'
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync3,
      Q => data_sync4,
      R => '0'
    );
data_sync_reg5: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync4,
      Q => data_sync5,
      R => '0'
    );
data_sync_reg6: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync5,
      Q => data_out,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_24\ is
  port (
    data_out : out STD_LOGIC;
    gt0_txresetdone_out : in STD_LOGIC;
    I3 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_24\ : entity is "gmii_to_sgmii_sync_block";
end \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_24\;

architecture STRUCTURE of \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_24\ is
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  signal data_sync4 : STD_LOGIC;
  signal data_sync5 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg1 : label is std.standard.true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of data_sync_reg1 : label is "FD";
  attribute box_type : string;
  attribute box_type of data_sync_reg1 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg2 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg2 : label is "FD";
  attribute box_type of data_sync_reg2 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg3 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg3 : label is "FD";
  attribute box_type of data_sync_reg3 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg4 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg4 : label is "FD";
  attribute box_type of data_sync_reg4 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg5 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg5 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg5 : label is "FD";
  attribute box_type of data_sync_reg5 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg6 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg6 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg6 : label is "FD";
  attribute box_type of data_sync_reg6 : label is "PRIMITIVE";
begin
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I3,
      CE => '1',
      D => gt0_txresetdone_out,
      Q => data_sync1,
      R => '0'
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I3,
      CE => '1',
      D => data_sync1,
      Q => data_sync2,
      R => '0'
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I3,
      CE => '1',
      D => data_sync2,
      Q => data_sync3,
      R => '0'
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I3,
      CE => '1',
      D => data_sync3,
      Q => data_sync4,
      R => '0'
    );
data_sync_reg5: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I3,
      CE => '1',
      D => data_sync4,
      Q => data_sync5,
      R => '0'
    );
data_sync_reg6: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I3,
      CE => '1',
      D => data_sync5,
      Q => data_out,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_25\ is
  port (
    data_out : out STD_LOGIC;
    I1 : in STD_LOGIC;
    independent_clock_bufg : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_25\ : entity is "gmii_to_sgmii_sync_block";
end \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_25\;

architecture STRUCTURE of \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_25\ is
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  signal data_sync4 : STD_LOGIC;
  signal data_sync5 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg1 : label is std.standard.true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of data_sync_reg1 : label is "FD";
  attribute box_type : string;
  attribute box_type of data_sync_reg1 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg2 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg2 : label is "FD";
  attribute box_type of data_sync_reg2 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg3 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg3 : label is "FD";
  attribute box_type of data_sync_reg3 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg4 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg4 : label is "FD";
  attribute box_type of data_sync_reg4 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg5 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg5 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg5 : label is "FD";
  attribute box_type of data_sync_reg5 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg6 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg6 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg6 : label is "FD";
  attribute box_type of data_sync_reg6 : label is "PRIMITIVE";
begin
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => I1,
      Q => data_sync1,
      R => '0'
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync1,
      Q => data_sync2,
      R => '0'
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync2,
      Q => data_sync3,
      R => '0'
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync3,
      Q => data_sync4,
      R => '0'
    );
data_sync_reg5: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync4,
      Q => data_sync5,
      R => '0'
    );
data_sync_reg6: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync5,
      Q => data_out,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_26\ is
  port (
    O1 : out STD_LOGIC;
    data_out : out STD_LOGIC;
    O2 : out STD_LOGIC;
    \out\ : in STD_LOGIC_VECTOR ( 3 downto 0 );
    recclk_mon_count_reset : in STD_LOGIC;
    I1 : in STD_LOGIC;
    I2 : in STD_LOGIC;
    I3 : in STD_LOGIC;
    I4 : in STD_LOGIC;
    independent_clock_bufg : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_26\ : entity is "gmii_to_sgmii_sync_block";
end \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_26\;

architecture STRUCTURE of \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_26\ is
  signal \^data_out\ : STD_LOGIC;
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  signal data_sync4 : STD_LOGIC;
  signal data_sync5 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg1 : label is std.standard.true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of data_sync_reg1 : label is "FD";
  attribute box_type : string;
  attribute box_type of data_sync_reg1 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg2 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg2 : label is "FD";
  attribute box_type of data_sync_reg2 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg3 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg3 : label is "FD";
  attribute box_type of data_sync_reg3 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg4 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg4 : label is "FD";
  attribute box_type of data_sync_reg4 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg5 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg5 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg5 : label is "FD";
  attribute box_type of data_sync_reg5 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg6 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg6 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg6 : label is "FD";
  attribute box_type of data_sync_reg6 : label is "PRIMITIVE";
begin
  data_out <= \^data_out\;
\FSM_sequential_rx_state[3]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000F1F1F100F1"
    )
    port map (
      I0 => I1,
      I1 => \^data_out\,
      I2 => \out\(2),
      I3 => I2,
      I4 => \out\(1),
      I5 => I3,
      O => O2
    );
adapt_count_reset_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFBFFF00000404"
    )
    port map (
      I0 => \out\(2),
      I1 => \out\(0),
      I2 => \out\(1),
      I3 => \^data_out\,
      I4 => \out\(3),
      I5 => recclk_mon_count_reset,
      O => O1
    );
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => I4,
      Q => data_sync1,
      R => '0'
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync1,
      Q => data_sync2,
      R => '0'
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync2,
      Q => data_sync3,
      R => '0'
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync3,
      Q => data_sync4,
      R => '0'
    );
data_sync_reg5: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync4,
      Q => data_sync5,
      R => '0'
    );
data_sync_reg6: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync5,
      Q => \^data_out\,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_27\ is
  port (
    O1 : out STD_LOGIC;
    O2 : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    D : out STD_LOGIC_VECTOR ( 2 downto 0 );
    \out\ : in STD_LOGIC_VECTOR ( 3 downto 0 );
    cplllock_sync : in STD_LOGIC;
    I1 : in STD_LOGIC;
    I2 : in STD_LOGIC;
    I3 : in STD_LOGIC;
    I4 : in STD_LOGIC;
    I5 : in STD_LOGIC;
    I6 : in STD_LOGIC;
    I7 : in STD_LOGIC;
    I8 : in STD_LOGIC;
    I9 : in STD_LOGIC;
    I10 : in STD_LOGIC;
    I11 : in STD_LOGIC;
    I12 : in STD_LOGIC;
    I13 : in STD_LOGIC;
    I14 : in STD_LOGIC;
    rx_state16_out : in STD_LOGIC;
    data_out : in STD_LOGIC;
    independent_clock_bufg : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_27\ : entity is "gmii_to_sgmii_sync_block";
end \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_27\;

architecture STRUCTURE of \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_27\ is
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  signal data_sync4 : STD_LOGIC;
  signal data_sync5 : STD_LOGIC;
  signal data_valid_sync : STD_LOGIC;
  signal \n_0_FSM_sequential_rx_state[0]_i_3\ : STD_LOGIC;
  signal \n_0_FSM_sequential_rx_state[3]_i_11\ : STD_LOGIC;
  signal \n_0_FSM_sequential_rx_state[3]_i_4\ : STD_LOGIC;
  signal \n_0_FSM_sequential_rx_state[3]_i_5\ : STD_LOGIC;
  signal \n_0_reset_time_out_i_2__0\ : STD_LOGIC;
  signal n_0_rx_fsm_reset_done_int_i_3 : STD_LOGIC;
  signal rx_fsm_reset_done_int : STD_LOGIC;
  signal rx_state1 : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_sequential_rx_state[3]_i_11\ : label is "soft_lutpair80";
  attribute SOFT_HLUTNM of \FSM_sequential_rx_state[3]_i_8\ : label is "soft_lutpair80";
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg1 : label is std.standard.true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of data_sync_reg1 : label is "FD";
  attribute box_type : string;
  attribute box_type of data_sync_reg1 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg2 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg2 : label is "FD";
  attribute box_type of data_sync_reg2 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg3 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg3 : label is "FD";
  attribute box_type of data_sync_reg3 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg4 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg4 : label is "FD";
  attribute box_type of data_sync_reg4 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg5 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg5 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg5 : label is "FD";
  attribute box_type of data_sync_reg5 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg6 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg6 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg6 : label is "FD";
  attribute box_type of data_sync_reg6 : label is "PRIMITIVE";
begin
\FSM_sequential_rx_state[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF05040404"
    )
    port map (
      I0 => I11,
      I1 => \out\(2),
      I2 => \out\(3),
      I3 => \out\(1),
      I4 => I12,
      I5 => \n_0_FSM_sequential_rx_state[0]_i_3\,
      O => D(0)
    );
\FSM_sequential_rx_state[0]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"13111111"
    )
    port map (
      I0 => \out\(0),
      I1 => \out\(2),
      I2 => \out\(1),
      I3 => \out\(3),
      I4 => rx_state1,
      O => \n_0_FSM_sequential_rx_state[0]_i_3\
    );
\FSM_sequential_rx_state[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000F000F00705070"
    )
    port map (
      I0 => \out\(2),
      I1 => rx_state16_out,
      I2 => \out\(0),
      I3 => \out\(3),
      I4 => rx_state1,
      I5 => \out\(1),
      O => D(1)
    );
\FSM_sequential_rx_state[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFF0FFF4FFF0FFFF"
    )
    port map (
      I0 => I8,
      I1 => \out\(0),
      I2 => \n_0_FSM_sequential_rx_state[3]_i_4\,
      I3 => \n_0_FSM_sequential_rx_state[3]_i_5\,
      I4 => \out\(3),
      I5 => I9,
      O => E(0)
    );
\FSM_sequential_rx_state[3]_i_11\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F4"
    )
    port map (
      I0 => I4,
      I1 => I7,
      I2 => data_valid_sync,
      O => \n_0_FSM_sequential_rx_state[3]_i_11\
    );
\FSM_sequential_rx_state[3]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4444444488888A88"
    )
    port map (
      I0 => \out\(3),
      I1 => I13,
      I2 => rx_state1,
      I3 => \out\(0),
      I4 => \out\(1),
      I5 => \out\(2),
      O => D(2)
    );
\FSM_sequential_rx_state[3]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000444"
    )
    port map (
      I0 => \out\(2),
      I1 => \out\(3),
      I2 => \out\(1),
      I3 => data_valid_sync,
      I4 => \out\(0),
      O => \n_0_FSM_sequential_rx_state[3]_i_4\
    );
\FSM_sequential_rx_state[3]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000A0000C00A0"
    )
    port map (
      I0 => \n_0_FSM_sequential_rx_state[3]_i_11\,
      I1 => I10,
      I2 => \out\(0),
      I3 => \out\(1),
      I4 => \out\(2),
      I5 => \out\(3),
      O => \n_0_FSM_sequential_rx_state[3]_i_5\
    );
\FSM_sequential_rx_state[3]_i_8\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"10"
    )
    port map (
      I0 => I4,
      I1 => data_valid_sync,
      I2 => I7,
      O => rx_state1
    );
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_out,
      Q => data_sync1,
      R => '0'
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync1,
      Q => data_sync2,
      R => '0'
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync2,
      Q => data_sync3,
      R => '0'
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync3,
      Q => data_sync4,
      R => '0'
    );
data_sync_reg5: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync4,
      Q => data_sync5,
      R => '0'
    );
data_sync_reg6: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync5,
      Q => data_valid_sync,
      R => '0'
    );
\reset_time_out_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FEFFFE00"
    )
    port map (
      I0 => \n_0_reset_time_out_i_2__0\,
      I1 => I1,
      I2 => I2,
      I3 => I3,
      I4 => I4,
      O => O1
    );
\reset_time_out_i_2__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0404550515155515"
    )
    port map (
      I0 => \out\(2),
      I1 => data_valid_sync,
      I2 => \out\(1),
      I3 => cplllock_sync,
      I4 => \out\(3),
      I5 => \out\(0),
      O => \n_0_reset_time_out_i_2__0\
    );
rx_fsm_reset_done_int_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BFBFBFFF80808000"
    )
    port map (
      I0 => rx_fsm_reset_done_int,
      I1 => n_0_rx_fsm_reset_done_int_i_3,
      I2 => I5,
      I3 => \out\(1),
      I4 => \out\(0),
      I5 => I6,
      O => O2
    );
rx_fsm_reset_done_int_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000008"
    )
    port map (
      I0 => I14,
      I1 => data_valid_sync,
      I2 => I4,
      I3 => \out\(2),
      I4 => \out\(0),
      O => rx_fsm_reset_done_int
    );
rx_fsm_reset_done_int_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"555F55550F4F0F4F"
    )
    port map (
      I0 => \out\(1),
      I1 => I7,
      I2 => \out\(0),
      I3 => I4,
      I4 => I14,
      I5 => data_valid_sync,
      O => n_0_rx_fsm_reset_done_int_i_3
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_28\ is
  port (
    O1 : out STD_LOGIC;
    SR : out STD_LOGIC_VECTOR ( 0 to 0 );
    mmcm_lock_reclocked : in STD_LOGIC;
    I1 : in STD_LOGIC;
    I3 : in STD_LOGIC;
    independent_clock_bufg : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_28\ : entity is "gmii_to_sgmii_sync_block";
end \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_28\;

architecture STRUCTURE of \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_28\ is
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  signal data_sync4 : STD_LOGIC;
  signal data_sync5 : STD_LOGIC;
  signal mmcm_lock_i : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg1 : label is std.standard.true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of data_sync_reg1 : label is "FD";
  attribute box_type : string;
  attribute box_type of data_sync_reg1 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg2 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg2 : label is "FD";
  attribute box_type of data_sync_reg2 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg3 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg3 : label is "FD";
  attribute box_type of data_sync_reg3 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg4 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg4 : label is "FD";
  attribute box_type of data_sync_reg4 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg5 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg5 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg5 : label is "FD";
  attribute box_type of data_sync_reg5 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg6 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg6 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg6 : label is "FD";
  attribute box_type of data_sync_reg6 : label is "PRIMITIVE";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \mmcm_lock_count[9]_i_1__0\ : label is "soft_lutpair81";
  attribute SOFT_HLUTNM of \mmcm_lock_reclocked_i_1__0\ : label is "soft_lutpair81";
begin
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => I3,
      Q => data_sync1,
      R => '0'
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync1,
      Q => data_sync2,
      R => '0'
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync2,
      Q => data_sync3,
      R => '0'
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync3,
      Q => data_sync4,
      R => '0'
    );
data_sync_reg5: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync4,
      Q => data_sync5,
      R => '0'
    );
data_sync_reg6: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync5,
      Q => mmcm_lock_i,
      R => '0'
    );
\mmcm_lock_count[9]_i_1__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => mmcm_lock_i,
      O => SR(0)
    );
\mmcm_lock_reclocked_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"E0"
    )
    port map (
      I0 => mmcm_lock_reclocked,
      I1 => I1,
      I2 => mmcm_lock_i,
      O => O1
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_29\ is
  port (
    data_out : out STD_LOGIC;
    data_in : in STD_LOGIC;
    I2 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_29\ : entity is "gmii_to_sgmii_sync_block";
end \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_29\;

architecture STRUCTURE of \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_29\ is
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  signal data_sync4 : STD_LOGIC;
  signal data_sync5 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg1 : label is std.standard.true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of data_sync_reg1 : label is "FD";
  attribute box_type : string;
  attribute box_type of data_sync_reg1 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg2 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg2 : label is "FD";
  attribute box_type of data_sync_reg2 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg3 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg3 : label is "FD";
  attribute box_type of data_sync_reg3 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg4 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg4 : label is "FD";
  attribute box_type of data_sync_reg4 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg5 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg5 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg5 : label is "FD";
  attribute box_type of data_sync_reg5 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg6 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg6 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg6 : label is "FD";
  attribute box_type of data_sync_reg6 : label is "PRIMITIVE";
begin
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I2,
      CE => '1',
      D => data_in,
      Q => data_sync1,
      R => '0'
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I2,
      CE => '1',
      D => data_sync1,
      Q => data_sync2,
      R => '0'
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I2,
      CE => '1',
      D => data_sync2,
      Q => data_sync3,
      R => '0'
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I2,
      CE => '1',
      D => data_sync3,
      Q => data_sync4,
      R => '0'
    );
data_sync_reg5: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I2,
      CE => '1',
      D => data_sync4,
      Q => data_sync5,
      R => '0'
    );
data_sync_reg6: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I2,
      CE => '1',
      D => data_sync5,
      Q => data_out,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_30\ is
  port (
    data_out : out STD_LOGIC;
    O1 : in STD_LOGIC;
    I2 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_30\ : entity is "gmii_to_sgmii_sync_block";
end \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_30\;

architecture STRUCTURE of \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_30\ is
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  signal data_sync4 : STD_LOGIC;
  signal data_sync5 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg1 : label is std.standard.true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of data_sync_reg1 : label is "FD";
  attribute box_type : string;
  attribute box_type of data_sync_reg1 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg2 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg2 : label is "FD";
  attribute box_type of data_sync_reg2 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg3 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg3 : label is "FD";
  attribute box_type of data_sync_reg3 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg4 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg4 : label is "FD";
  attribute box_type of data_sync_reg4 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg5 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg5 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg5 : label is "FD";
  attribute box_type of data_sync_reg5 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg6 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg6 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg6 : label is "FD";
  attribute box_type of data_sync_reg6 : label is "PRIMITIVE";
begin
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I2,
      CE => '1',
      D => O1,
      Q => data_sync1,
      R => '0'
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I2,
      CE => '1',
      D => data_sync1,
      Q => data_sync2,
      R => '0'
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I2,
      CE => '1',
      D => data_sync2,
      Q => data_sync3,
      R => '0'
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I2,
      CE => '1',
      D => data_sync3,
      Q => data_sync4,
      R => '0'
    );
data_sync_reg5: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I2,
      CE => '1',
      D => data_sync4,
      Q => data_sync5,
      R => '0'
    );
data_sync_reg6: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I2,
      CE => '1',
      D => data_sync5,
      Q => data_out,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_31\ is
  port (
    data_out : out STD_LOGIC;
    data_in : in STD_LOGIC;
    independent_clock_bufg : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_31\ : entity is "gmii_to_sgmii_sync_block";
end \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_31\;

architecture STRUCTURE of \gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_31\ is
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  signal data_sync4 : STD_LOGIC;
  signal data_sync5 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg1 : label is std.standard.true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of data_sync_reg1 : label is "FD";
  attribute box_type : string;
  attribute box_type of data_sync_reg1 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg2 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg2 : label is "FD";
  attribute box_type of data_sync_reg2 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg3 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg3 : label is "FD";
  attribute box_type of data_sync_reg3 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg4 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg4 : label is "FD";
  attribute box_type of data_sync_reg4 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg5 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg5 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg5 : label is "FD";
  attribute box_type of data_sync_reg5 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg6 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg6 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg6 : label is "FD";
  attribute box_type of data_sync_reg6 : label is "PRIMITIVE";
begin
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_in,
      Q => data_sync1,
      R => '0'
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync1,
      Q => data_sync2,
      R => '0'
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync2,
      Q => data_sync3,
      R => '0'
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync3,
      Q => data_sync4,
      R => '0'
    );
data_sync_reg5: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync4,
      Q => data_sync5,
      R => '0'
    );
data_sync_reg6: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => data_sync5,
      Q => data_out,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gmii_to_sgmii_gmii_to_sgmii_tx_rate_adapt is
  port (
    O2 : out STD_LOGIC;
    O3 : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 7 downto 0 );
    I1 : in STD_LOGIC;
    E : in STD_LOGIC_VECTOR ( 0 to 0 );
    gmii_tx_en : in STD_LOGIC;
    CLK : in STD_LOGIC;
    gmii_tx_er : in STD_LOGIC;
    gmii_txd : in STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of gmii_to_sgmii_gmii_to_sgmii_tx_rate_adapt : entity is "gmii_to_sgmii_tx_rate_adapt";
end gmii_to_sgmii_gmii_to_sgmii_tx_rate_adapt;

architecture STRUCTURE of gmii_to_sgmii_gmii_to_sgmii_tx_rate_adapt is
begin
gmii_tx_en_out_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => E(0),
      D => gmii_tx_en,
      Q => O2,
      R => I1
    );
gmii_tx_er_out_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => E(0),
      D => gmii_tx_er,
      Q => O3,
      R => I1
    );
\gmii_txd_out_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => E(0),
      D => gmii_txd(0),
      Q => Q(0),
      R => I1
    );
\gmii_txd_out_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => E(0),
      D => gmii_txd(1),
      Q => Q(1),
      R => I1
    );
\gmii_txd_out_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => E(0),
      D => gmii_txd(2),
      Q => Q(2),
      R => I1
    );
\gmii_txd_out_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => E(0),
      D => gmii_txd(3),
      Q => Q(3),
      R => I1
    );
\gmii_txd_out_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => E(0),
      D => gmii_txd(4),
      Q => Q(4),
      R => I1
    );
\gmii_txd_out_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => E(0),
      D => gmii_txd(5),
      Q => Q(5),
      R => I1
    );
\gmii_txd_out_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => E(0),
      D => gmii_txd(6),
      Q => Q(6),
      R => I1
    );
\gmii_txd_out_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => E(0),
      D => gmii_txd(7),
      Q => Q(7),
      R => I1
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \gmii_to_sgmii_sync_block__parameterized0\ is
  port (
    MASK_RUDI_BUFERR_TIMER0 : out STD_LOGIC;
    data_out : out STD_LOGIC;
    SIGNAL_DETECT_MOD : out STD_LOGIC;
    p_0_in : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    signal_detect : in STD_LOGIC;
    userclk2 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \gmii_to_sgmii_sync_block__parameterized0\ : entity is "sync_block";
end \gmii_to_sgmii_sync_block__parameterized0\;

architecture STRUCTURE of \gmii_to_sgmii_sync_block__parameterized0\ is
  signal \^data_out\ : STD_LOGIC;
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  signal data_sync4 : STD_LOGIC;
  signal data_sync5 : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \MASK_RUDI_BUFERR_TIMER[8]_i_3\ : label is "soft_lutpair44";
  attribute SOFT_HLUTNM of SIGNAL_DETECT_REG_i_1 : label is "soft_lutpair44";
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg1 : label is std.standard.true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of data_sync_reg1 : label is "FD";
  attribute box_type : string;
  attribute box_type of data_sync_reg1 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg2 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg2 : label is "FD";
  attribute box_type of data_sync_reg2 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg3 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg3 : label is "FD";
  attribute box_type of data_sync_reg3 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg4 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg4 : label is "FD";
  attribute box_type of data_sync_reg4 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg5 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg5 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg5 : label is "FD";
  attribute box_type of data_sync_reg5 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg6 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg6 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg6 : label is "FD";
  attribute box_type of data_sync_reg6 : label is "PRIMITIVE";
begin
  data_out <= \^data_out\;
\MASK_RUDI_BUFERR_TIMER[8]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
    port map (
      I0 => p_0_in,
      I1 => Q(0),
      I2 => \^data_out\,
      O => MASK_RUDI_BUFERR_TIMER0
    );
SIGNAL_DETECT_REG_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \^data_out\,
      I1 => Q(0),
      O => SIGNAL_DETECT_MOD
    );
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => signal_detect,
      Q => data_sync1,
      R => '0'
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => data_sync1,
      Q => data_sync2,
      R => '0'
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => data_sync2,
      Q => data_sync3,
      R => '0'
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => data_sync3,
      Q => data_sync4,
      R => '0'
    );
data_sync_reg5: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => data_sync4,
      Q => data_sync5,
      R => '0'
    );
data_sync_reg6: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => data_sync5,
      Q => \^data_out\,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gmii_to_sgmii_GPCS_PMA_GEN is
  port (
    MGT_TX_RESET : out STD_LOGIC;
    status_vector : out STD_LOGIC_VECTOR ( 12 downto 0 );
    Q : out STD_LOGIC_VECTOR ( 1 downto 0 );
    MGT_RX_RESET : out STD_LOGIC;
    enablealign : out STD_LOGIC;
    gmii_rxd : out STD_LOGIC_VECTOR ( 7 downto 0 );
    gmii_rx_er : out STD_LOGIC;
    an_interrupt : out STD_LOGIC;
    txchardispmode : out STD_LOGIC;
    txcharisk : out STD_LOGIC;
    txdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    gmii_rx_dv : out STD_LOGIC;
    txchardispval : out STD_LOGIC;
    userclk2 : in STD_LOGIC;
    reset : in STD_LOGIC;
    dcm_locked : in STD_LOGIC;
    an_restart_config : in STD_LOGIC;
    gmii_txd : in STD_LOGIC_VECTOR ( 7 downto 0 );
    signal_detect : in STD_LOGIC;
    gmii_tx_er : in STD_LOGIC;
    gmii_tx_en : in STD_LOGIC;
    userclk : in STD_LOGIC;
    configuration_vector : in STD_LOGIC_VECTOR ( 4 downto 0 );
    rxclkcorcnt : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxbufstatus : in STD_LOGIC_VECTOR ( 0 to 0 );
    txbuferr : in STD_LOGIC;
    reset_done : in STD_LOGIC;
    an_adv_config_vector : in STD_LOGIC_VECTOR ( 1 downto 0 );
    rxcharisk : in STD_LOGIC_VECTOR ( 0 to 0 );
    rxchariscomma : in STD_LOGIC_VECTOR ( 0 to 0 );
    link_timer_value : in STD_LOGIC_VECTOR ( 8 downto 0 );
    rxdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
    rxdisperr : in STD_LOGIC_VECTOR ( 0 to 0 );
    rxnotintable : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of gmii_to_sgmii_GPCS_PMA_GEN : entity is "GPCS_PMA_GEN";
end gmii_to_sgmii_GPCS_PMA_GEN;

architecture STRUCTURE of gmii_to_sgmii_GPCS_PMA_GEN is
  signal AN_ENABLE_INT : STD_LOGIC;
  signal CONSISTENCY_MATCH1 : STD_LOGIC;
  signal D : STD_LOGIC;
  signal DUPLEX_MODE_RSLVD_REG : STD_LOGIC;
  signal EOP_REG1 : STD_LOGIC;
  signal K28p5_REG1 : STD_LOGIC;
  signal LOOPBACK_INT : STD_LOGIC;
  signal MASK_RUDI_BUFERR_TIMER0 : STD_LOGIC;
  signal \^mgt_rx_reset\ : STD_LOGIC;
  signal MGT_RX_RESET_INT : STD_LOGIC;
  signal \^mgt_tx_reset\ : STD_LOGIC;
  signal MGT_TX_RESET_INT : STD_LOGIC;
  signal \^q\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal RESET_INT : STD_LOGIC;
  signal RESET_INT_PIPE : STD_LOGIC;
  signal RESTART_AN_EN : STD_LOGIC;
  signal RESTART_AN_EN_REG : STD_LOGIC;
  signal RESTART_AN_SET : STD_LOGIC;
  signal RESTART_AN_SET_0 : STD_LOGIC;
  signal RXDISPERR_SRL : STD_LOGIC;
  signal RXEVEN : STD_LOGIC;
  signal RXNOTINTABLE_INT : STD_LOGIC;
  signal RXNOTINTABLE_SRL : STD_LOGIC;
  signal RXSYNC_STATUS : STD_LOGIC;
  signal RX_CONFIG_REG : STD_LOGIC_VECTOR ( 14 to 14 );
  signal RX_CONFIG_REG_REG0 : STD_LOGIC;
  signal RX_CONFIG_VALID : STD_LOGIC;
  signal RX_IDLE : STD_LOGIC;
  signal RX_RST_SM : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal RX_RUDI_INVALID : STD_LOGIC;
  signal SIGNAL_DETECT_MOD : STD_LOGIC;
  signal SOP_REG3 : STD_LOGIC;
  signal SRESET_PIPE : STD_LOGIC;
  signal STATUS_VECTOR_0_PRE : STD_LOGIC;
  signal STATUS_VECTOR_0_PRE0 : STD_LOGIC;
  signal STAT_VEC_DUPLEX_MODE_RSLVD : STD_LOGIC;
  signal SYNC_STATUS_REG : STD_LOGIC;
  signal SYNC_STATUS_REG0 : STD_LOGIC;
  signal TXBUFERR_INT : STD_LOGIC;
  signal TX_RST_SM : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal XMIT_CONFIG_INT : STD_LOGIC;
  signal XMIT_DATA : STD_LOGIC;
  signal XMIT_DATA_INT : STD_LOGIC;
  signal data_out : STD_LOGIC;
  signal \^gmii_rx_dv\ : STD_LOGIC;
  signal \n_0_FSM_sequential_USE_ROCKET_IO.RX_RST_SM[0]_i_1\ : STD_LOGIC;
  signal \n_0_FSM_sequential_USE_ROCKET_IO.RX_RST_SM[1]_i_1\ : STD_LOGIC;
  signal \n_0_FSM_sequential_USE_ROCKET_IO.RX_RST_SM[2]_i_1\ : STD_LOGIC;
  signal \n_0_FSM_sequential_USE_ROCKET_IO.RX_RST_SM[3]_i_1\ : STD_LOGIC;
  signal \n_0_FSM_sequential_USE_ROCKET_IO.TX_RST_SM[0]_i_1\ : STD_LOGIC;
  signal \n_0_FSM_sequential_USE_ROCKET_IO.TX_RST_SM[1]_i_1\ : STD_LOGIC;
  signal \n_0_FSM_sequential_USE_ROCKET_IO.TX_RST_SM[2]_i_1\ : STD_LOGIC;
  signal \n_0_FSM_sequential_USE_ROCKET_IO.TX_RST_SM[3]_i_1\ : STD_LOGIC;
  signal \n_0_MGT_RESET.RESET_INT_PIPE_i_1\ : STD_LOGIC;
  signal \n_0_MGT_RESET.SRESET_reg\ : STD_LOGIC;
  signal \n_0_NO_MANAGEMENT.CONFIGURATION_VECTOR_REG_reg[0]\ : STD_LOGIC;
  signal \n_0_NO_MANAGEMENT.NO_MDIO_HAS_AN.RESTART_AN_EN_i_1\ : STD_LOGIC;
  signal n_0_TRANSMITTER : STD_LOGIC;
  signal \n_0_USE_ROCKET_IO.NO_1588.RXCHARISCOMMA_INT_reg\ : STD_LOGIC;
  signal \n_0_USE_ROCKET_IO.NO_1588.RXCHARISK_INT_reg\ : STD_LOGIC;
  signal \n_0_USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT[2]_i_1\ : STD_LOGIC;
  signal \n_0_USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT_reg[0]\ : STD_LOGIC;
  signal \n_0_USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT_reg[1]\ : STD_LOGIC;
  signal \n_0_USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT_reg[2]\ : STD_LOGIC;
  signal \n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[0]\ : STD_LOGIC;
  signal \n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[1]\ : STD_LOGIC;
  signal \n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[2]\ : STD_LOGIC;
  signal \n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[3]\ : STD_LOGIC;
  signal \n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[4]\ : STD_LOGIC;
  signal \n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[5]\ : STD_LOGIC;
  signal \n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[6]\ : STD_LOGIC;
  signal \n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[7]\ : STD_LOGIC;
  signal \n_0_USE_ROCKET_IO.NO_1588.RXDISPERR_INT_i_1\ : STD_LOGIC;
  signal \n_0_USE_ROCKET_IO.NO_1588.RXNOTINTABLE_INT_i_1\ : STD_LOGIC;
  signal n_10_RECEIVER : STD_LOGIC;
  signal n_10_TRANSMITTER : STD_LOGIC;
  signal n_11_RECEIVER : STD_LOGIC;
  signal n_11_TRANSMITTER : STD_LOGIC;
  signal \n_12_HAS_AUTO_NEG.AUTO_NEGOTIATION\ : STD_LOGIC;
  signal n_12_RECEIVER : STD_LOGIC;
  signal n_12_TRANSMITTER : STD_LOGIC;
  signal \n_13_HAS_AUTO_NEG.AUTO_NEGOTIATION\ : STD_LOGIC;
  signal n_13_TRANSMITTER : STD_LOGIC;
  signal \n_14_HAS_AUTO_NEG.AUTO_NEGOTIATION\ : STD_LOGIC;
  signal n_14_RECEIVER : STD_LOGIC;
  signal n_14_TRANSMITTER : STD_LOGIC;
  signal \n_15_HAS_AUTO_NEG.AUTO_NEGOTIATION\ : STD_LOGIC;
  signal n_15_TRANSMITTER : STD_LOGIC;
  signal \n_16_HAS_AUTO_NEG.AUTO_NEGOTIATION\ : STD_LOGIC;
  signal n_16_RECEIVER : STD_LOGIC;
  signal n_16_TRANSMITTER : STD_LOGIC;
  signal \n_17_HAS_AUTO_NEG.AUTO_NEGOTIATION\ : STD_LOGIC;
  signal n_17_RECEIVER : STD_LOGIC;
  signal n_17_TRANSMITTER : STD_LOGIC;
  signal \n_18_HAS_AUTO_NEG.AUTO_NEGOTIATION\ : STD_LOGIC;
  signal n_18_RECEIVER : STD_LOGIC;
  signal n_18_TRANSMITTER : STD_LOGIC;
  signal \n_19_HAS_AUTO_NEG.AUTO_NEGOTIATION\ : STD_LOGIC;
  signal n_19_RECEIVER : STD_LOGIC;
  signal n_19_TRANSMITTER : STD_LOGIC;
  signal n_1_TRANSMITTER : STD_LOGIC;
  signal \n_20_HAS_AUTO_NEG.AUTO_NEGOTIATION\ : STD_LOGIC;
  signal n_20_RECEIVER : STD_LOGIC;
  signal n_20_TRANSMITTER : STD_LOGIC;
  signal \n_21_HAS_AUTO_NEG.AUTO_NEGOTIATION\ : STD_LOGIC;
  signal n_21_RECEIVER : STD_LOGIC;
  signal n_21_TRANSMITTER : STD_LOGIC;
  signal \n_22_HAS_AUTO_NEG.AUTO_NEGOTIATION\ : STD_LOGIC;
  signal n_22_RECEIVER : STD_LOGIC;
  signal \n_23_HAS_AUTO_NEG.AUTO_NEGOTIATION\ : STD_LOGIC;
  signal n_23_RECEIVER : STD_LOGIC;
  signal \n_24_HAS_AUTO_NEG.AUTO_NEGOTIATION\ : STD_LOGIC;
  signal n_24_RECEIVER : STD_LOGIC;
  signal \n_25_HAS_AUTO_NEG.AUTO_NEGOTIATION\ : STD_LOGIC;
  signal n_25_RECEIVER : STD_LOGIC;
  signal \n_26_HAS_AUTO_NEG.AUTO_NEGOTIATION\ : STD_LOGIC;
  signal n_26_RECEIVER : STD_LOGIC;
  signal \n_27_HAS_AUTO_NEG.AUTO_NEGOTIATION\ : STD_LOGIC;
  signal n_27_RECEIVER : STD_LOGIC;
  signal \n_28_HAS_AUTO_NEG.AUTO_NEGOTIATION\ : STD_LOGIC;
  signal \n_29_HAS_AUTO_NEG.AUTO_NEGOTIATION\ : STD_LOGIC;
  signal n_2_SYNCHRONISATION : STD_LOGIC;
  signal n_2_TRANSMITTER : STD_LOGIC;
  signal \n_31_HAS_AUTO_NEG.AUTO_NEGOTIATION\ : STD_LOGIC;
  signal n_31_RECEIVER : STD_LOGIC;
  signal \n_32_HAS_AUTO_NEG.AUTO_NEGOTIATION\ : STD_LOGIC;
  signal n_32_RECEIVER : STD_LOGIC;
  signal \n_33_HAS_AUTO_NEG.AUTO_NEGOTIATION\ : STD_LOGIC;
  signal \n_34_HAS_AUTO_NEG.AUTO_NEGOTIATION\ : STD_LOGIC;
  signal \n_35_HAS_AUTO_NEG.AUTO_NEGOTIATION\ : STD_LOGIC;
  signal \n_36_HAS_AUTO_NEG.AUTO_NEGOTIATION\ : STD_LOGIC;
  signal \n_37_HAS_AUTO_NEG.AUTO_NEGOTIATION\ : STD_LOGIC;
  signal \n_38_HAS_AUTO_NEG.AUTO_NEGOTIATION\ : STD_LOGIC;
  signal \n_39_HAS_AUTO_NEG.AUTO_NEGOTIATION\ : STD_LOGIC;
  signal n_3_TRANSMITTER : STD_LOGIC;
  signal \n_40_HAS_AUTO_NEG.AUTO_NEGOTIATION\ : STD_LOGIC;
  signal \n_41_HAS_AUTO_NEG.AUTO_NEGOTIATION\ : STD_LOGIC;
  signal \n_42_HAS_AUTO_NEG.AUTO_NEGOTIATION\ : STD_LOGIC;
  signal n_4_TRANSMITTER : STD_LOGIC;
  signal n_5_SYNCHRONISATION : STD_LOGIC;
  signal n_5_TRANSMITTER : STD_LOGIC;
  signal n_6_SYNCHRONISATION : STD_LOGIC;
  signal n_6_TRANSMITTER : STD_LOGIC;
  signal \n_7_HAS_AUTO_NEG.AUTO_NEGOTIATION\ : STD_LOGIC;
  signal n_7_SYNCHRONISATION : STD_LOGIC;
  signal n_7_TRANSMITTER : STD_LOGIC;
  signal \n_8_HAS_AUTO_NEG.AUTO_NEGOTIATION\ : STD_LOGIC;
  signal n_8_RECEIVER : STD_LOGIC;
  signal n_8_TRANSMITTER : STD_LOGIC;
  signal \n_9_HAS_AUTO_NEG.AUTO_NEGOTIATION\ : STD_LOGIC;
  signal n_9_TRANSMITTER : STD_LOGIC;
  signal p_0_in : STD_LOGIC;
  signal p_0_out : STD_LOGIC;
  signal p_1_in : STD_LOGIC;
  signal p_1_out : STD_LOGIC;
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of DELAY_RXDISPERR : label is "SRL16";
  attribute box_type : string;
  attribute box_type of DELAY_RXDISPERR : label is "PRIMITIVE";
  attribute srl_name : string;
  attribute srl_name of DELAY_RXDISPERR : label is "\U0/pcs_pma_block_i/gmii_to_sgmii_core /\gpcs_pma_inst/DELAY_RXDISPERR ";
  attribute XILINX_LEGACY_PRIM of DELAY_RXNOTINTABLE : label is "SRL16";
  attribute box_type of DELAY_RXNOTINTABLE : label is "PRIMITIVE";
  attribute srl_name of DELAY_RXNOTINTABLE : label is "\U0/pcs_pma_block_i/gmii_to_sgmii_core /\gpcs_pma_inst/DELAY_RXNOTINTABLE ";
  attribute KEEP : string;
  attribute KEEP of \FSM_sequential_USE_ROCKET_IO.RX_RST_SM_reg[0]\ : label is "yes";
  attribute KEEP of \FSM_sequential_USE_ROCKET_IO.RX_RST_SM_reg[1]\ : label is "yes";
  attribute KEEP of \FSM_sequential_USE_ROCKET_IO.RX_RST_SM_reg[2]\ : label is "yes";
  attribute KEEP of \FSM_sequential_USE_ROCKET_IO.RX_RST_SM_reg[3]\ : label is "yes";
  attribute KEEP of \FSM_sequential_USE_ROCKET_IO.TX_RST_SM_reg[0]\ : label is "yes";
  attribute KEEP of \FSM_sequential_USE_ROCKET_IO.TX_RST_SM_reg[1]\ : label is "yes";
  attribute KEEP of \FSM_sequential_USE_ROCKET_IO.TX_RST_SM_reg[2]\ : label is "yes";
  attribute KEEP of \FSM_sequential_USE_ROCKET_IO.TX_RST_SM_reg[3]\ : label is "yes";
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of \MGT_RESET.RESET_INT_PIPE_reg\ : label is std.standard.true;
  attribute ASYNC_REG of \MGT_RESET.RESET_INT_reg\ : label is std.standard.true;
  attribute ASYNC_REG of \MGT_RESET.SRESET_PIPE_reg\ : label is std.standard.true;
  attribute ASYNC_REG of \MGT_RESET.SRESET_reg\ : label is std.standard.true;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \USE_ROCKET_IO.NO_1588.RXDISPERR_INT_i_1\ : label is "soft_lutpair71";
  attribute SOFT_HLUTNM of \USE_ROCKET_IO.NO_1588.RXNOTINTABLE_INT_i_1\ : label is "soft_lutpair71";
begin
  MGT_RX_RESET <= \^mgt_rx_reset\;
  MGT_TX_RESET <= \^mgt_tx_reset\;
  Q(1 downto 0) <= \^q\(1 downto 0);
  gmii_rx_dv <= \^gmii_rx_dv\;
DELAY_RXDISPERR: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => '0',
      A1 => '0',
      A2 => '1',
      A3 => '0',
      CE => '1',
      CLK => userclk2,
      D => D,
      Q => RXDISPERR_SRL
    );
DELAY_RXNOTINTABLE: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => '0',
      A1 => '0',
      A2 => '1',
      A3 => '0',
      CE => '1',
      CLK => userclk2,
      D => RXNOTINTABLE_INT,
      Q => RXNOTINTABLE_SRL
    );
DUPLEX_MODE_RSLVD_REG_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => STAT_VEC_DUPLEX_MODE_RSLVD,
      Q => DUPLEX_MODE_RSLVD_REG,
      R => '0'
    );
\FSM_sequential_USE_ROCKET_IO.RX_RST_SM[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1554"
    )
    port map (
      I0 => RX_RST_SM(0),
      I1 => RX_RST_SM(2),
      I2 => RX_RST_SM(3),
      I3 => RX_RST_SM(1),
      O => \n_0_FSM_sequential_USE_ROCKET_IO.RX_RST_SM[0]_i_1\
    );
\FSM_sequential_USE_ROCKET_IO.RX_RST_SM[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2666"
    )
    port map (
      I0 => RX_RST_SM(0),
      I1 => RX_RST_SM(1),
      I2 => RX_RST_SM(3),
      I3 => RX_RST_SM(2),
      O => \n_0_FSM_sequential_USE_ROCKET_IO.RX_RST_SM[1]_i_1\
    );
\FSM_sequential_USE_ROCKET_IO.RX_RST_SM[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"34CC"
    )
    port map (
      I0 => RX_RST_SM(3),
      I1 => RX_RST_SM(2),
      I2 => RX_RST_SM(0),
      I3 => RX_RST_SM(1),
      O => \n_0_FSM_sequential_USE_ROCKET_IO.RX_RST_SM[2]_i_1\
    );
\FSM_sequential_USE_ROCKET_IO.RX_RST_SM[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3F80"
    )
    port map (
      I0 => RX_RST_SM(0),
      I1 => RX_RST_SM(1),
      I2 => RX_RST_SM(2),
      I3 => RX_RST_SM(3),
      O => \n_0_FSM_sequential_USE_ROCKET_IO.RX_RST_SM[3]_i_1\
    );
\FSM_sequential_USE_ROCKET_IO.RX_RST_SM_reg[0]\: unisim.vcomponents.FDSE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_FSM_sequential_USE_ROCKET_IO.RX_RST_SM[0]_i_1\,
      Q => RX_RST_SM(0),
      S => p_0_out
    );
\FSM_sequential_USE_ROCKET_IO.RX_RST_SM_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_FSM_sequential_USE_ROCKET_IO.RX_RST_SM[1]_i_1\,
      Q => RX_RST_SM(1),
      R => p_0_out
    );
\FSM_sequential_USE_ROCKET_IO.RX_RST_SM_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_FSM_sequential_USE_ROCKET_IO.RX_RST_SM[2]_i_1\,
      Q => RX_RST_SM(2),
      R => p_0_out
    );
\FSM_sequential_USE_ROCKET_IO.RX_RST_SM_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_FSM_sequential_USE_ROCKET_IO.RX_RST_SM[3]_i_1\,
      Q => RX_RST_SM(3),
      R => p_0_out
    );
\FSM_sequential_USE_ROCKET_IO.TX_RST_SM[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1554"
    )
    port map (
      I0 => TX_RST_SM(0),
      I1 => TX_RST_SM(2),
      I2 => TX_RST_SM(3),
      I3 => TX_RST_SM(1),
      O => \n_0_FSM_sequential_USE_ROCKET_IO.TX_RST_SM[0]_i_1\
    );
\FSM_sequential_USE_ROCKET_IO.TX_RST_SM[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2666"
    )
    port map (
      I0 => TX_RST_SM(0),
      I1 => TX_RST_SM(1),
      I2 => TX_RST_SM(3),
      I3 => TX_RST_SM(2),
      O => \n_0_FSM_sequential_USE_ROCKET_IO.TX_RST_SM[1]_i_1\
    );
\FSM_sequential_USE_ROCKET_IO.TX_RST_SM[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"34CC"
    )
    port map (
      I0 => TX_RST_SM(3),
      I1 => TX_RST_SM(2),
      I2 => TX_RST_SM(0),
      I3 => TX_RST_SM(1),
      O => \n_0_FSM_sequential_USE_ROCKET_IO.TX_RST_SM[2]_i_1\
    );
\FSM_sequential_USE_ROCKET_IO.TX_RST_SM[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3F80"
    )
    port map (
      I0 => TX_RST_SM(0),
      I1 => TX_RST_SM(1),
      I2 => TX_RST_SM(2),
      I3 => TX_RST_SM(3),
      O => \n_0_FSM_sequential_USE_ROCKET_IO.TX_RST_SM[3]_i_1\
    );
\FSM_sequential_USE_ROCKET_IO.TX_RST_SM_reg[0]\: unisim.vcomponents.FDSE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_FSM_sequential_USE_ROCKET_IO.TX_RST_SM[0]_i_1\,
      Q => TX_RST_SM(0),
      S => p_1_out
    );
\FSM_sequential_USE_ROCKET_IO.TX_RST_SM_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_FSM_sequential_USE_ROCKET_IO.TX_RST_SM[1]_i_1\,
      Q => TX_RST_SM(1),
      R => p_1_out
    );
\FSM_sequential_USE_ROCKET_IO.TX_RST_SM_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_FSM_sequential_USE_ROCKET_IO.TX_RST_SM[2]_i_1\,
      Q => TX_RST_SM(2),
      R => p_1_out
    );
\FSM_sequential_USE_ROCKET_IO.TX_RST_SM_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_FSM_sequential_USE_ROCKET_IO.TX_RST_SM[3]_i_1\,
      Q => TX_RST_SM(3),
      R => p_1_out
    );
\HAS_AUTO_NEG.AUTO_NEGOTIATION\: entity work.\gmii_to_sgmii_AUTO_NEG__parameterized0\
    port map (
      CO(0) => n_27_RECEIVER,
      EOP_REG1 => EOP_REG1,
      I1 => \n_0_MGT_RESET.SRESET_reg\,
      I10 => n_7_SYNCHRONISATION,
      I11 => n_12_RECEIVER,
      I12 => n_19_RECEIVER,
      I13(0) => RX_CONFIG_REG_REG0,
      I14 => n_18_RECEIVER,
      I15 => n_21_RECEIVER,
      I16 => n_20_RECEIVER,
      I17 => n_16_RECEIVER,
      I18 => n_17_RECEIVER,
      I19 => n_23_RECEIVER,
      I2 => n_2_SYNCHRONISATION,
      I20 => n_22_RECEIVER,
      I21 => n_25_RECEIVER,
      I22 => n_24_RECEIVER,
      I23 => n_26_RECEIVER,
      I3 => n_31_RECEIVER,
      I4 => n_32_RECEIVER,
      I5 => n_10_RECEIVER,
      I6(0) => CONSISTENCY_MATCH1,
      I7 => n_14_RECEIVER,
      I8 => n_11_RECEIVER,
      I9(2) => \n_0_USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT_reg[2]\,
      I9(1) => \n_0_USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT_reg[1]\,
      I9(0) => \n_0_USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT_reg[0]\,
      MASK_RUDI_BUFERR_TIMER0 => MASK_RUDI_BUFERR_TIMER0,
      O1 => \n_7_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      O10(11) => \n_31_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      O10(10) => \n_32_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      O10(9) => \n_33_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      O10(8) => \n_34_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      O10(7) => \n_35_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      O10(6) => \n_36_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      O10(5) => \n_37_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      O10(4) => \n_38_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      O10(3) => \n_39_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      O10(2) => \n_40_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      O10(1) => \n_41_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      O10(0) => \n_42_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      O2 => \n_8_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      O3 => \n_9_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      O4(0) => \n_13_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      O5(11) => \n_14_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      O5(10) => \n_15_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      O5(9) => \n_16_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      O5(8) => \n_17_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      O5(7) => \n_18_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      O5(6) => \n_19_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      O5(5) => \n_20_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      O5(4) => \n_21_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      O5(3) => \n_22_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      O5(2) => \n_23_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      O5(1) => \n_24_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      O5(0) => \n_25_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      O6 => \n_26_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      O7 => \n_27_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      O8 => \n_28_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      O9 => \n_29_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      Q(3) => AN_ENABLE_INT,
      Q(2 downto 1) => \^q\(1 downto 0),
      Q(0) => \n_0_NO_MANAGEMENT.CONFIGURATION_VECTOR_REG_reg[0]\,
      RESTART_AN_SET => RESTART_AN_SET,
      RXSYNC_STATUS => RXSYNC_STATUS,
      RX_CONFIG_REG(0) => RX_CONFIG_REG(14),
      RX_CONFIG_VALID => RX_CONFIG_VALID,
      RX_IDLE => RX_IDLE,
      RX_RUDI_INVALID => RX_RUDI_INVALID,
      S(0) => \n_12_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      SOP_REG3 => SOP_REG3,
      SR(0) => \^mgt_rx_reset\,
      STAT_VEC_DUPLEX_MODE_RSLVD => STAT_VEC_DUPLEX_MODE_RSLVD,
      XMIT_CONFIG_INT => XMIT_CONFIG_INT,
      XMIT_DATA => XMIT_DATA,
      XMIT_DATA_INT => XMIT_DATA_INT,
      an_adv_config_vector(1 downto 0) => an_adv_config_vector(1 downto 0),
      an_interrupt => an_interrupt,
      data_out => data_out,
      gmii_rx_dv => \^gmii_rx_dv\,
      link_timer_value(8 downto 0) => link_timer_value(8 downto 0),
      p_0_in => p_0_in,
      p_1_in => p_1_in,
      status_vector(5) => status_vector(12),
      status_vector(4 downto 1) => status_vector(10 downto 7),
      status_vector(0) => status_vector(4),
      userclk2 => userclk2
    );
\MGT_RESET.RESET_INT_PIPE_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => reset,
      I1 => dcm_locked,
      O => \n_0_MGT_RESET.RESET_INT_PIPE_i_1\
    );
\MGT_RESET.RESET_INT_PIPE_reg\: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk,
      CE => '1',
      D => '0',
      PRE => \n_0_MGT_RESET.RESET_INT_PIPE_i_1\,
      Q => RESET_INT_PIPE
    );
\MGT_RESET.RESET_INT_reg\: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk,
      CE => '1',
      D => RESET_INT_PIPE,
      PRE => \n_0_MGT_RESET.RESET_INT_PIPE_i_1\,
      Q => RESET_INT
    );
\MGT_RESET.SRESET_PIPE_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => RESET_INT,
      Q => SRESET_PIPE,
      R => '0'
    );
\MGT_RESET.SRESET_reg\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => SRESET_PIPE,
      Q => \n_0_MGT_RESET.SRESET_reg\,
      S => RESET_INT
    );
\NO_MANAGEMENT.CONFIGURATION_VECTOR_REG_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => configuration_vector(0),
      Q => \n_0_NO_MANAGEMENT.CONFIGURATION_VECTOR_REG_reg[0]\,
      R => \n_0_MGT_RESET.SRESET_reg\
    );
\NO_MANAGEMENT.CONFIGURATION_VECTOR_REG_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => configuration_vector(1),
      Q => LOOPBACK_INT,
      R => \n_0_MGT_RESET.SRESET_reg\
    );
\NO_MANAGEMENT.CONFIGURATION_VECTOR_REG_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => configuration_vector(2),
      Q => \^q\(0),
      R => \n_0_MGT_RESET.SRESET_reg\
    );
\NO_MANAGEMENT.CONFIGURATION_VECTOR_REG_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => configuration_vector(3),
      Q => \^q\(1),
      R => \n_0_MGT_RESET.SRESET_reg\
    );
\NO_MANAGEMENT.CONFIGURATION_VECTOR_REG_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => configuration_vector(4),
      Q => AN_ENABLE_INT,
      R => \n_0_MGT_RESET.SRESET_reg\
    );
\NO_MANAGEMENT.NO_MDIO_HAS_AN.RESTART_AN_EN_REG_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => an_restart_config,
      Q => RESTART_AN_EN_REG,
      R => \n_0_MGT_RESET.SRESET_reg\
    );
\NO_MANAGEMENT.NO_MDIO_HAS_AN.RESTART_AN_EN_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => an_restart_config,
      I1 => RESTART_AN_EN_REG,
      O => \n_0_NO_MANAGEMENT.NO_MDIO_HAS_AN.RESTART_AN_EN_i_1\
    );
\NO_MANAGEMENT.NO_MDIO_HAS_AN.RESTART_AN_EN_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_NO_MANAGEMENT.NO_MDIO_HAS_AN.RESTART_AN_EN_i_1\,
      Q => RESTART_AN_EN,
      R => \n_0_MGT_RESET.SRESET_reg\
    );
\NO_MANAGEMENT.NO_MDIO_HAS_AN.RESTART_AN_SET_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => RESTART_AN_EN,
      I1 => \n_0_MGT_RESET.SRESET_reg\,
      O => RESTART_AN_SET_0
    );
\NO_MANAGEMENT.NO_MDIO_HAS_AN.RESTART_AN_SET_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => RESTART_AN_SET_0,
      Q => RESTART_AN_SET,
      R => '0'
    );
RECEIVER: entity work.\gmii_to_sgmii_RX__parameterized0\
    port map (
      CO(0) => n_27_RECEIVER,
      D => D,
      EOP_REG1 => EOP_REG1,
      I1 => \n_0_USE_ROCKET_IO.NO_1588.RXCHARISK_INT_reg\,
      I10 => n_6_SYNCHRONISATION,
      I11(2) => \n_0_USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT_reg[2]\,
      I11(1) => \n_0_USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT_reg[1]\,
      I11(0) => \n_0_USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT_reg[0]\,
      I12 => n_5_SYNCHRONISATION,
      I13(0) => RX_CONFIG_REG_REG0,
      I14 => \n_7_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      I15 => \n_8_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      I2 => \n_26_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      I3 => \n_0_MGT_RESET.SRESET_reg\,
      I4(0) => \n_13_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      I5 => \n_9_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      I6(0) => CONSISTENCY_MATCH1,
      I7(3) => AN_ENABLE_INT,
      I7(2 downto 1) => \^q\(1 downto 0),
      I7(0) => \n_0_NO_MANAGEMENT.CONFIGURATION_VECTOR_REG_reg[0]\,
      I8(11) => \n_14_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      I8(10) => \n_15_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      I8(9) => \n_16_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      I8(8) => \n_17_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      I8(7) => \n_18_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      I8(6) => \n_19_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      I8(5) => \n_20_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      I8(4) => \n_21_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      I8(3) => \n_22_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      I8(2) => \n_23_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      I8(1) => \n_24_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      I8(0) => \n_25_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      I9(11) => \n_31_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      I9(10) => \n_32_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      I9(9) => \n_33_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      I9(8) => \n_34_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      I9(7) => \n_35_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      I9(6) => \n_36_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      I9(5) => \n_37_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      I9(4) => \n_38_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      I9(3) => \n_39_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      I9(2) => \n_40_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      I9(1) => \n_41_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      I9(0) => \n_42_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      K28p5_REG1 => K28p5_REG1,
      O1 => n_8_RECEIVER,
      O10 => n_20_RECEIVER,
      O11 => n_21_RECEIVER,
      O12 => n_22_RECEIVER,
      O13 => n_23_RECEIVER,
      O14 => n_24_RECEIVER,
      O15 => n_25_RECEIVER,
      O16 => n_26_RECEIVER,
      O17 => n_31_RECEIVER,
      O18 => n_32_RECEIVER,
      O2 => n_10_RECEIVER,
      O3 => n_11_RECEIVER,
      O4 => n_12_RECEIVER,
      O5 => n_14_RECEIVER,
      O6 => n_16_RECEIVER,
      O7 => n_17_RECEIVER,
      O8 => n_18_RECEIVER,
      O9 => n_19_RECEIVER,
      Q(7) => \n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[7]\,
      Q(6) => \n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[6]\,
      Q(5) => \n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[5]\,
      Q(4) => \n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[4]\,
      Q(3) => \n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[3]\,
      Q(2) => \n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[2]\,
      Q(1) => \n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[1]\,
      Q(0) => \n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[0]\,
      RXEVEN => RXEVEN,
      RXNOTINTABLE_INT => RXNOTINTABLE_INT,
      RXSYNC_STATUS => RXSYNC_STATUS,
      RX_CONFIG_REG(0) => RX_CONFIG_REG(14),
      RX_CONFIG_VALID => RX_CONFIG_VALID,
      RX_IDLE => RX_IDLE,
      RX_RUDI_INVALID => RX_RUDI_INVALID,
      S(0) => \n_12_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      SOP_REG3 => SOP_REG3,
      SR(0) => \^mgt_rx_reset\,
      SYNC_STATUS_REG0 => SYNC_STATUS_REG0,
      XMIT_DATA => XMIT_DATA,
      XMIT_DATA_INT => XMIT_DATA_INT,
      gmii_rx_dv => \^gmii_rx_dv\,
      gmii_rx_er => gmii_rx_er,
      gmii_rxd(7 downto 0) => gmii_rxd(7 downto 0),
      p_0_in => p_0_in,
      p_1_in => p_1_in,
      status_vector(1 downto 0) => status_vector(3 downto 2),
      userclk2 => userclk2
    );
RXDISPERR_REG_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => RXDISPERR_SRL,
      Q => status_vector(5),
      R => '0'
    );
RXNOTINTABLE_REG_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => RXNOTINTABLE_SRL,
      Q => status_vector(6),
      R => '0'
    );
STATUS_VECTOR_0_PRE_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => STATUS_VECTOR_0_PRE0,
      Q => STATUS_VECTOR_0_PRE,
      R => '0'
    );
\STATUS_VECTOR_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => STATUS_VECTOR_0_PRE,
      Q => status_vector(0),
      R => '0'
    );
\STATUS_VECTOR_reg[12]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => DUPLEX_MODE_RSLVD_REG,
      Q => status_vector(11),
      R => '0'
    );
\STATUS_VECTOR_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => SYNC_STATUS_REG,
      Q => status_vector(1),
      R => '0'
    );
SYNCHRONISATION: entity work.gmii_to_sgmii_SYNCHRONISE
    port map (
      D => D,
      I1 => \n_0_USE_ROCKET_IO.NO_1588.RXCHARISCOMMA_INT_reg\,
      I2 => \n_0_MGT_RESET.SRESET_reg\,
      I3 => n_10_RECEIVER,
      I4 => \n_0_USE_ROCKET_IO.NO_1588.RXCHARISK_INT_reg\,
      I5 => n_8_RECEIVER,
      K28p5_REG1 => K28p5_REG1,
      O1 => n_2_SYNCHRONISATION,
      O2 => n_5_SYNCHRONISATION,
      O3 => n_6_SYNCHRONISATION,
      O4 => n_7_SYNCHRONISATION,
      Q(2) => AN_ENABLE_INT,
      Q(1) => LOOPBACK_INT,
      Q(0) => \n_0_NO_MANAGEMENT.CONFIGURATION_VECTOR_REG_reg[0]\,
      RXEVEN => RXEVEN,
      RXNOTINTABLE_INT => RXNOTINTABLE_INT,
      RXSYNC_STATUS => RXSYNC_STATUS,
      SIGNAL_DETECT_MOD => SIGNAL_DETECT_MOD,
      SR(0) => \^mgt_rx_reset\,
      STATUS_VECTOR_0_PRE0 => STATUS_VECTOR_0_PRE0,
      SYNC_STATUS_REG0 => SYNC_STATUS_REG0,
      XMIT_DATA_INT => XMIT_DATA_INT,
      enablealign => enablealign,
      p_0_in => p_0_in,
      reset_done => reset_done,
      userclk2 => userclk2
    );
SYNC_SIGNAL_DETECT: entity work.\gmii_to_sgmii_sync_block__parameterized0\
    port map (
      MASK_RUDI_BUFERR_TIMER0 => MASK_RUDI_BUFERR_TIMER0,
      Q(0) => \^q\(0),
      SIGNAL_DETECT_MOD => SIGNAL_DETECT_MOD,
      data_out => data_out,
      p_0_in => p_0_in,
      signal_detect => signal_detect,
      userclk2 => userclk2
    );
SYNC_STATUS_REG_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => RXSYNC_STATUS,
      Q => SYNC_STATUS_REG,
      R => '0'
    );
TRANSMITTER: entity work.\gmii_to_sgmii_TX__parameterized0\
    port map (
      D(3) => n_0_TRANSMITTER,
      D(2) => n_1_TRANSMITTER,
      D(1) => n_2_TRANSMITTER,
      D(0) => n_3_TRANSMITTER,
      I1 => \^mgt_tx_reset\,
      I2 => \n_27_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      I3 => \n_28_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      I4 => \n_29_HAS_AUTO_NEG.AUTO_NEGOTIATION\,
      O1 => n_4_TRANSMITTER,
      O10 => n_20_TRANSMITTER,
      O11 => n_21_TRANSMITTER,
      O2 => n_5_TRANSMITTER,
      O3 => n_6_TRANSMITTER,
      O4 => n_7_TRANSMITTER,
      O5 => n_8_TRANSMITTER,
      O6 => n_9_TRANSMITTER,
      O7 => n_10_TRANSMITTER,
      O8 => n_11_TRANSMITTER,
      O9(7) => n_12_TRANSMITTER,
      O9(6) => n_13_TRANSMITTER,
      O9(5) => n_14_TRANSMITTER,
      O9(4) => n_15_TRANSMITTER,
      O9(3) => n_16_TRANSMITTER,
      O9(2) => n_17_TRANSMITTER,
      O9(1) => n_18_TRANSMITTER,
      O9(0) => n_19_TRANSMITTER,
      Q(3) => AN_ENABLE_INT,
      Q(2) => \^q\(1),
      Q(1) => LOOPBACK_INT,
      Q(0) => \n_0_NO_MANAGEMENT.CONFIGURATION_VECTOR_REG_reg[0]\,
      XMIT_CONFIG_INT => XMIT_CONFIG_INT,
      XMIT_DATA_INT => XMIT_DATA_INT,
      gmii_tx_en => gmii_tx_en,
      gmii_tx_er => gmii_tx_er,
      gmii_txd(7 downto 0) => gmii_txd(7 downto 0),
      rxchariscomma(0) => rxchariscomma(0),
      rxcharisk(0) => rxcharisk(0),
      rxdata(7 downto 0) => rxdata(7 downto 0),
      userclk2 => userclk2
    );
\USE_ROCKET_IO.MGT_RX_RESET_INT_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => p_0_in,
      I1 => RESET_INT,
      O => p_0_out
    );
\USE_ROCKET_IO.MGT_RX_RESET_INT_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFE"
    )
    port map (
      I0 => RX_RST_SM(0),
      I1 => RX_RST_SM(1),
      I2 => RX_RST_SM(2),
      I3 => RX_RST_SM(3),
      O => MGT_RX_RESET_INT
    );
\USE_ROCKET_IO.MGT_RX_RESET_INT_reg\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => MGT_RX_RESET_INT,
      Q => \^mgt_rx_reset\,
      S => p_0_out
    );
\USE_ROCKET_IO.MGT_TX_RESET_INT_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => RESET_INT,
      I1 => TXBUFERR_INT,
      O => p_1_out
    );
\USE_ROCKET_IO.MGT_TX_RESET_INT_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFE"
    )
    port map (
      I0 => TX_RST_SM(0),
      I1 => TX_RST_SM(1),
      I2 => TX_RST_SM(2),
      I3 => TX_RST_SM(3),
      O => MGT_TX_RESET_INT
    );
\USE_ROCKET_IO.MGT_TX_RESET_INT_reg\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => MGT_TX_RESET_INT,
      Q => \^mgt_tx_reset\,
      S => p_1_out
    );
\USE_ROCKET_IO.NO_1588.RXBUFSTATUS_INT_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => rxbufstatus(0),
      Q => p_0_in,
      R => \n_0_USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT[2]_i_1\
    );
\USE_ROCKET_IO.NO_1588.RXCHARISCOMMA_INT_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => n_11_TRANSMITTER,
      Q => \n_0_USE_ROCKET_IO.NO_1588.RXCHARISCOMMA_INT_reg\,
      R => \^mgt_rx_reset\
    );
\USE_ROCKET_IO.NO_1588.RXCHARISK_INT_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => n_10_TRANSMITTER,
      Q => \n_0_USE_ROCKET_IO.NO_1588.RXCHARISK_INT_reg\,
      R => \^mgt_rx_reset\
    );
\USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => LOOPBACK_INT,
      I1 => \^mgt_rx_reset\,
      O => \n_0_USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT[2]_i_1\
    );
\USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => rxclkcorcnt(0),
      Q => \n_0_USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT_reg[0]\,
      R => \n_0_USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT[2]_i_1\
    );
\USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => rxclkcorcnt(1),
      Q => \n_0_USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT_reg[1]\,
      R => \n_0_USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT[2]_i_1\
    );
\USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => rxclkcorcnt(2),
      Q => \n_0_USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT_reg[2]\,
      R => \n_0_USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT[2]_i_1\
    );
\USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => n_19_TRANSMITTER,
      Q => \n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[0]\,
      R => \^mgt_rx_reset\
    );
\USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => n_18_TRANSMITTER,
      Q => \n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[1]\,
      R => \^mgt_rx_reset\
    );
\USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => n_17_TRANSMITTER,
      Q => \n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[2]\,
      R => \^mgt_rx_reset\
    );
\USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => n_16_TRANSMITTER,
      Q => \n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[3]\,
      R => \^mgt_rx_reset\
    );
\USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => n_15_TRANSMITTER,
      Q => \n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[4]\,
      R => \^mgt_rx_reset\
    );
\USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => n_14_TRANSMITTER,
      Q => \n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[5]\,
      R => \^mgt_rx_reset\
    );
\USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => n_13_TRANSMITTER,
      Q => \n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[6]\,
      R => \^mgt_rx_reset\
    );
\USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => n_12_TRANSMITTER,
      Q => \n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[7]\,
      R => \^mgt_rx_reset\
    );
\USE_ROCKET_IO.NO_1588.RXDISPERR_INT_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"02"
    )
    port map (
      I0 => rxdisperr(0),
      I1 => \^mgt_rx_reset\,
      I2 => LOOPBACK_INT,
      O => \n_0_USE_ROCKET_IO.NO_1588.RXDISPERR_INT_i_1\
    );
\USE_ROCKET_IO.NO_1588.RXDISPERR_INT_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_USE_ROCKET_IO.NO_1588.RXDISPERR_INT_i_1\,
      Q => D,
      R => '0'
    );
\USE_ROCKET_IO.NO_1588.RXNOTINTABLE_INT_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"02"
    )
    port map (
      I0 => rxnotintable(0),
      I1 => \^mgt_rx_reset\,
      I2 => LOOPBACK_INT,
      O => \n_0_USE_ROCKET_IO.NO_1588.RXNOTINTABLE_INT_i_1\
    );
\USE_ROCKET_IO.NO_1588.RXNOTINTABLE_INT_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => \n_0_USE_ROCKET_IO.NO_1588.RXNOTINTABLE_INT_i_1\,
      Q => RXNOTINTABLE_INT,
      R => '0'
    );
\USE_ROCKET_IO.TXBUFERR_INT_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => userclk2,
      CE => '1',
      D => txbuferr,
      Q => TXBUFERR_INT,
      R => \^mgt_tx_reset\
    );
\USE_ROCKET_IO.TXCHARDISPMODE_reg\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => n_4_TRANSMITTER,
      Q => txchardispmode,
      R => \^mgt_tx_reset\
    );
\USE_ROCKET_IO.TXCHARDISPVAL_reg\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => n_21_TRANSMITTER,
      Q => txchardispval,
      R => '0'
    );
\USE_ROCKET_IO.TXCHARISK_reg\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => n_9_TRANSMITTER,
      Q => txcharisk,
      R => \^mgt_tx_reset\
    );
\USE_ROCKET_IO.TXDATA_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => n_3_TRANSMITTER,
      Q => txdata(0),
      R => '0'
    );
\USE_ROCKET_IO.TXDATA_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => n_2_TRANSMITTER,
      Q => txdata(1),
      R => '0'
    );
\USE_ROCKET_IO.TXDATA_reg[2]\: unisim.vcomponents.FDSE
    port map (
      C => userclk2,
      CE => '1',
      D => n_8_TRANSMITTER,
      Q => txdata(2),
      S => n_20_TRANSMITTER
    );
\USE_ROCKET_IO.TXDATA_reg[3]\: unisim.vcomponents.FDSE
    port map (
      C => userclk2,
      CE => '1',
      D => n_7_TRANSMITTER,
      Q => txdata(3),
      S => n_20_TRANSMITTER
    );
\USE_ROCKET_IO.TXDATA_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => n_1_TRANSMITTER,
      Q => txdata(4),
      R => '0'
    );
\USE_ROCKET_IO.TXDATA_reg[5]\: unisim.vcomponents.FDSE
    port map (
      C => userclk2,
      CE => '1',
      D => n_6_TRANSMITTER,
      Q => txdata(5),
      S => n_20_TRANSMITTER
    );
\USE_ROCKET_IO.TXDATA_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => userclk2,
      CE => '1',
      D => n_0_TRANSMITTER,
      Q => txdata(6),
      R => '0'
    );
\USE_ROCKET_IO.TXDATA_reg[7]\: unisim.vcomponents.FDSE
    port map (
      C => userclk2,
      CE => '1',
      D => n_5_TRANSMITTER,
      Q => txdata(7),
      S => n_20_TRANSMITTER
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \gmii_to_sgmii_gmii_to_sgmii_RX_STARTUP_FSM__parameterized0\ is
  port (
    data_in : out STD_LOGIC;
    O1 : out STD_LOGIC;
    RXUSERRDY : out STD_LOGIC;
    RXDFELFHOLD : out STD_LOGIC;
    independent_clock_bufg : in STD_LOGIC;
    I2 : in STD_LOGIC;
    AR : in STD_LOGIC_VECTOR ( 0 to 0 );
    I1 : in STD_LOGIC;
    I3 : in STD_LOGIC;
    data_out : in STD_LOGIC;
    I4 : in STD_LOGIC;
    I5 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \gmii_to_sgmii_gmii_to_sgmii_RX_STARTUP_FSM__parameterized0\ : entity is "gmii_to_sgmii_RX_STARTUP_FSM";
end \gmii_to_sgmii_gmii_to_sgmii_RX_STARTUP_FSM__parameterized0\;

architecture STRUCTURE of \gmii_to_sgmii_gmii_to_sgmii_RX_STARTUP_FSM__parameterized0\ is
  signal \^o1\ : STD_LOGIC;
  signal \^rxdfelfhold\ : STD_LOGIC;
  signal \^rxuserrdy\ : STD_LOGIC;
  signal \adapt_wait_hw.adapt_count_reg\ : STD_LOGIC_VECTOR ( 22 downto 0 );
  signal cplllock_sync : STD_LOGIC;
  signal \^data_in\ : STD_LOGIC;
  signal data_out_0 : STD_LOGIC;
  signal \init_wait_count_reg__0\ : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal \mmcm_lock_count_reg__0\ : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal mmcm_lock_reclocked : STD_LOGIC;
  signal \n_0_FSM_sequential_rx_state[0]_i_2\ : STD_LOGIC;
  signal \n_0_FSM_sequential_rx_state[2]_i_1\ : STD_LOGIC;
  signal \n_0_FSM_sequential_rx_state[3]_i_10\ : STD_LOGIC;
  signal \n_0_FSM_sequential_rx_state[3]_i_12\ : STD_LOGIC;
  signal \n_0_FSM_sequential_rx_state[3]_i_13\ : STD_LOGIC;
  signal \n_0_FSM_sequential_rx_state[3]_i_6\ : STD_LOGIC;
  signal \n_0_FSM_sequential_rx_state[3]_i_7\ : STD_LOGIC;
  signal \n_0_FSM_sequential_rx_state[3]_i_9\ : STD_LOGIC;
  signal n_0_RXDFEAGCHOLD_i_1 : STD_LOGIC;
  signal n_0_RXUSERRDY_i_1 : STD_LOGIC;
  signal \n_0_adapt_wait_hw.adapt_count[0]_i_1\ : STD_LOGIC;
  signal \n_0_adapt_wait_hw.adapt_count[0]_i_10\ : STD_LOGIC;
  signal \n_0_adapt_wait_hw.adapt_count[0]_i_3\ : STD_LOGIC;
  signal \n_0_adapt_wait_hw.adapt_count[0]_i_4\ : STD_LOGIC;
  signal \n_0_adapt_wait_hw.adapt_count[0]_i_5\ : STD_LOGIC;
  signal \n_0_adapt_wait_hw.adapt_count[0]_i_6\ : STD_LOGIC;
  signal \n_0_adapt_wait_hw.adapt_count[0]_i_7\ : STD_LOGIC;
  signal \n_0_adapt_wait_hw.adapt_count[0]_i_8\ : STD_LOGIC;
  signal \n_0_adapt_wait_hw.adapt_count[0]_i_9\ : STD_LOGIC;
  signal \n_0_adapt_wait_hw.adapt_count[12]_i_2\ : STD_LOGIC;
  signal \n_0_adapt_wait_hw.adapt_count[12]_i_3\ : STD_LOGIC;
  signal \n_0_adapt_wait_hw.adapt_count[12]_i_4\ : STD_LOGIC;
  signal \n_0_adapt_wait_hw.adapt_count[12]_i_5\ : STD_LOGIC;
  signal \n_0_adapt_wait_hw.adapt_count[16]_i_2\ : STD_LOGIC;
  signal \n_0_adapt_wait_hw.adapt_count[16]_i_3\ : STD_LOGIC;
  signal \n_0_adapt_wait_hw.adapt_count[16]_i_4\ : STD_LOGIC;
  signal \n_0_adapt_wait_hw.adapt_count[16]_i_5\ : STD_LOGIC;
  signal \n_0_adapt_wait_hw.adapt_count[20]_i_2\ : STD_LOGIC;
  signal \n_0_adapt_wait_hw.adapt_count[20]_i_3\ : STD_LOGIC;
  signal \n_0_adapt_wait_hw.adapt_count[20]_i_4\ : STD_LOGIC;
  signal \n_0_adapt_wait_hw.adapt_count[4]_i_2\ : STD_LOGIC;
  signal \n_0_adapt_wait_hw.adapt_count[4]_i_3\ : STD_LOGIC;
  signal \n_0_adapt_wait_hw.adapt_count[4]_i_4\ : STD_LOGIC;
  signal \n_0_adapt_wait_hw.adapt_count[4]_i_5\ : STD_LOGIC;
  signal \n_0_adapt_wait_hw.adapt_count[8]_i_2\ : STD_LOGIC;
  signal \n_0_adapt_wait_hw.adapt_count[8]_i_3\ : STD_LOGIC;
  signal \n_0_adapt_wait_hw.adapt_count[8]_i_4\ : STD_LOGIC;
  signal \n_0_adapt_wait_hw.adapt_count[8]_i_5\ : STD_LOGIC;
  signal \n_0_adapt_wait_hw.adapt_count_reg[0]_i_2\ : STD_LOGIC;
  signal \n_0_adapt_wait_hw.adapt_count_reg[12]_i_1\ : STD_LOGIC;
  signal \n_0_adapt_wait_hw.adapt_count_reg[16]_i_1\ : STD_LOGIC;
  signal \n_0_adapt_wait_hw.adapt_count_reg[4]_i_1\ : STD_LOGIC;
  signal \n_0_adapt_wait_hw.adapt_count_reg[8]_i_1\ : STD_LOGIC;
  signal \n_0_adapt_wait_hw.time_out_adapt_i_1\ : STD_LOGIC;
  signal \n_0_adapt_wait_hw.time_out_adapt_i_2\ : STD_LOGIC;
  signal \n_0_adapt_wait_hw.time_out_adapt_i_3\ : STD_LOGIC;
  signal \n_0_adapt_wait_hw.time_out_adapt_i_4\ : STD_LOGIC;
  signal \n_0_adapt_wait_hw.time_out_adapt_i_5\ : STD_LOGIC;
  signal \n_0_adapt_wait_hw.time_out_adapt_reg\ : STD_LOGIC;
  signal n_0_check_tlock_max_i_1 : STD_LOGIC;
  signal n_0_check_tlock_max_reg : STD_LOGIC;
  signal n_0_gtrxreset_i_i_1 : STD_LOGIC;
  signal \n_0_init_wait_count[0]_i_1__0\ : STD_LOGIC;
  signal \n_0_init_wait_count[6]_i_1__0\ : STD_LOGIC;
  signal \n_0_init_wait_count[6]_i_3__0\ : STD_LOGIC;
  signal \n_0_init_wait_count[6]_i_4__0\ : STD_LOGIC;
  signal \n_0_init_wait_done_i_1__0\ : STD_LOGIC;
  signal \n_0_init_wait_done_i_2__0\ : STD_LOGIC;
  signal n_0_init_wait_done_reg : STD_LOGIC;
  signal \n_0_mmcm_lock_count[9]_i_2__0\ : STD_LOGIC;
  signal \n_0_mmcm_lock_count[9]_i_4__0\ : STD_LOGIC;
  signal \n_0_mmcm_lock_reclocked_i_2__0\ : STD_LOGIC;
  signal \n_0_reset_time_out_i_3__0\ : STD_LOGIC;
  signal \n_0_reset_time_out_i_4__0\ : STD_LOGIC;
  signal n_0_reset_time_out_i_5 : STD_LOGIC;
  signal n_0_reset_time_out_reg : STD_LOGIC;
  signal \n_0_run_phase_alignment_int_i_1__0\ : STD_LOGIC;
  signal n_0_run_phase_alignment_int_reg : STD_LOGIC;
  signal n_0_run_phase_alignment_int_s3_reg : STD_LOGIC;
  signal n_0_rx_fsm_reset_done_int_i_4 : STD_LOGIC;
  signal n_0_sync_cplllock : STD_LOGIC;
  signal n_0_sync_data_valid : STD_LOGIC;
  signal n_0_sync_mmcm_lock_reclocked : STD_LOGIC;
  signal n_0_time_out_100us_i_1 : STD_LOGIC;
  signal n_0_time_out_100us_i_2 : STD_LOGIC;
  signal n_0_time_out_100us_i_3 : STD_LOGIC;
  signal n_0_time_out_100us_reg : STD_LOGIC;
  signal n_0_time_out_1us_i_1 : STD_LOGIC;
  signal n_0_time_out_1us_i_2 : STD_LOGIC;
  signal n_0_time_out_1us_i_3 : STD_LOGIC;
  signal n_0_time_out_1us_i_4 : STD_LOGIC;
  signal n_0_time_out_1us_reg : STD_LOGIC;
  signal n_0_time_out_2ms_i_1 : STD_LOGIC;
  signal \n_0_time_out_2ms_i_2__0\ : STD_LOGIC;
  signal n_0_time_out_2ms_reg : STD_LOGIC;
  signal \n_0_time_out_counter[0]_i_1\ : STD_LOGIC;
  signal \n_0_time_out_counter[0]_i_3__0\ : STD_LOGIC;
  signal \n_0_time_out_counter[0]_i_4\ : STD_LOGIC;
  signal \n_0_time_out_counter[0]_i_5__0\ : STD_LOGIC;
  signal \n_0_time_out_counter[0]_i_6__0\ : STD_LOGIC;
  signal \n_0_time_out_counter[0]_i_7__0\ : STD_LOGIC;
  signal \n_0_time_out_counter[0]_i_8__0\ : STD_LOGIC;
  signal \n_0_time_out_counter[0]_i_9__0\ : STD_LOGIC;
  signal \n_0_time_out_counter[12]_i_2__0\ : STD_LOGIC;
  signal \n_0_time_out_counter[12]_i_3__0\ : STD_LOGIC;
  signal \n_0_time_out_counter[12]_i_4__0\ : STD_LOGIC;
  signal \n_0_time_out_counter[12]_i_5__0\ : STD_LOGIC;
  signal \n_0_time_out_counter[16]_i_2__0\ : STD_LOGIC;
  signal \n_0_time_out_counter[16]_i_3__0\ : STD_LOGIC;
  signal \n_0_time_out_counter[16]_i_4__0\ : STD_LOGIC;
  signal \n_0_time_out_counter[16]_i_5\ : STD_LOGIC;
  signal \n_0_time_out_counter[4]_i_2__0\ : STD_LOGIC;
  signal \n_0_time_out_counter[4]_i_3__0\ : STD_LOGIC;
  signal \n_0_time_out_counter[4]_i_4__0\ : STD_LOGIC;
  signal \n_0_time_out_counter[4]_i_5__0\ : STD_LOGIC;
  signal \n_0_time_out_counter[8]_i_2__0\ : STD_LOGIC;
  signal \n_0_time_out_counter[8]_i_3__0\ : STD_LOGIC;
  signal \n_0_time_out_counter[8]_i_4__0\ : STD_LOGIC;
  signal \n_0_time_out_counter[8]_i_5__0\ : STD_LOGIC;
  signal \n_0_time_out_counter_reg[0]_i_2__0\ : STD_LOGIC;
  signal \n_0_time_out_counter_reg[12]_i_1__0\ : STD_LOGIC;
  signal \n_0_time_out_counter_reg[4]_i_1__0\ : STD_LOGIC;
  signal \n_0_time_out_counter_reg[8]_i_1__0\ : STD_LOGIC;
  signal \n_0_time_out_wait_bypass_i_1__0\ : STD_LOGIC;
  signal n_0_time_out_wait_bypass_reg : STD_LOGIC;
  signal n_0_time_tlock_max_i_10 : STD_LOGIC;
  signal n_0_time_tlock_max_i_11 : STD_LOGIC;
  signal n_0_time_tlock_max_i_12 : STD_LOGIC;
  signal n_0_time_tlock_max_i_13 : STD_LOGIC;
  signal n_0_time_tlock_max_i_14 : STD_LOGIC;
  signal n_0_time_tlock_max_i_15 : STD_LOGIC;
  signal n_0_time_tlock_max_i_16 : STD_LOGIC;
  signal n_0_time_tlock_max_i_17 : STD_LOGIC;
  signal n_0_time_tlock_max_i_18 : STD_LOGIC;
  signal n_0_time_tlock_max_i_19 : STD_LOGIC;
  signal \n_0_time_tlock_max_i_1__0\ : STD_LOGIC;
  signal n_0_time_tlock_max_i_20 : STD_LOGIC;
  signal n_0_time_tlock_max_i_21 : STD_LOGIC;
  signal n_0_time_tlock_max_i_22 : STD_LOGIC;
  signal n_0_time_tlock_max_i_4 : STD_LOGIC;
  signal n_0_time_tlock_max_i_5 : STD_LOGIC;
  signal n_0_time_tlock_max_i_6 : STD_LOGIC;
  signal n_0_time_tlock_max_i_7 : STD_LOGIC;
  signal n_0_time_tlock_max_i_9 : STD_LOGIC;
  signal n_0_time_tlock_max_reg_i_3 : STD_LOGIC;
  signal n_0_time_tlock_max_reg_i_8 : STD_LOGIC;
  signal \n_0_wait_bypass_count[0]_i_1__0\ : STD_LOGIC;
  signal \n_0_wait_bypass_count[0]_i_2__0\ : STD_LOGIC;
  signal \n_0_wait_bypass_count[0]_i_4__0\ : STD_LOGIC;
  signal \n_0_wait_bypass_count[0]_i_5__0\ : STD_LOGIC;
  signal \n_0_wait_bypass_count[0]_i_6__0\ : STD_LOGIC;
  signal \n_0_wait_bypass_count[0]_i_7__0\ : STD_LOGIC;
  signal \n_0_wait_bypass_count[0]_i_8__0\ : STD_LOGIC;
  signal \n_0_wait_bypass_count[0]_i_9\ : STD_LOGIC;
  signal \n_0_wait_bypass_count[12]_i_2__0\ : STD_LOGIC;
  signal \n_0_wait_bypass_count[4]_i_2__0\ : STD_LOGIC;
  signal \n_0_wait_bypass_count[4]_i_3__0\ : STD_LOGIC;
  signal \n_0_wait_bypass_count[4]_i_4__0\ : STD_LOGIC;
  signal \n_0_wait_bypass_count[4]_i_5__0\ : STD_LOGIC;
  signal \n_0_wait_bypass_count[8]_i_2__0\ : STD_LOGIC;
  signal \n_0_wait_bypass_count[8]_i_3__0\ : STD_LOGIC;
  signal \n_0_wait_bypass_count[8]_i_4__0\ : STD_LOGIC;
  signal \n_0_wait_bypass_count[8]_i_5__0\ : STD_LOGIC;
  signal \n_0_wait_bypass_count_reg[0]_i_3__0\ : STD_LOGIC;
  signal \n_0_wait_bypass_count_reg[4]_i_1__0\ : STD_LOGIC;
  signal \n_0_wait_bypass_count_reg[8]_i_1__0\ : STD_LOGIC;
  signal \n_0_wait_time_cnt[6]_i_1__0\ : STD_LOGIC;
  signal \n_0_wait_time_cnt[6]_i_2__0\ : STD_LOGIC;
  signal \n_0_wait_time_cnt[6]_i_4__0\ : STD_LOGIC;
  signal \n_1_adapt_wait_hw.adapt_count_reg[0]_i_2\ : STD_LOGIC;
  signal \n_1_adapt_wait_hw.adapt_count_reg[12]_i_1\ : STD_LOGIC;
  signal \n_1_adapt_wait_hw.adapt_count_reg[16]_i_1\ : STD_LOGIC;
  signal \n_1_adapt_wait_hw.adapt_count_reg[4]_i_1\ : STD_LOGIC;
  signal \n_1_adapt_wait_hw.adapt_count_reg[8]_i_1\ : STD_LOGIC;
  signal n_1_sync_data_valid : STD_LOGIC;
  signal n_1_sync_mmcm_lock_reclocked : STD_LOGIC;
  signal \n_1_time_out_counter_reg[0]_i_2__0\ : STD_LOGIC;
  signal \n_1_time_out_counter_reg[12]_i_1__0\ : STD_LOGIC;
  signal \n_1_time_out_counter_reg[16]_i_1__0\ : STD_LOGIC;
  signal \n_1_time_out_counter_reg[4]_i_1__0\ : STD_LOGIC;
  signal \n_1_time_out_counter_reg[8]_i_1__0\ : STD_LOGIC;
  signal n_1_time_tlock_max_reg_i_3 : STD_LOGIC;
  signal n_1_time_tlock_max_reg_i_8 : STD_LOGIC;
  signal \n_1_wait_bypass_count_reg[0]_i_3__0\ : STD_LOGIC;
  signal \n_1_wait_bypass_count_reg[4]_i_1__0\ : STD_LOGIC;
  signal \n_1_wait_bypass_count_reg[8]_i_1__0\ : STD_LOGIC;
  signal \n_2_adapt_wait_hw.adapt_count_reg[0]_i_2\ : STD_LOGIC;
  signal \n_2_adapt_wait_hw.adapt_count_reg[12]_i_1\ : STD_LOGIC;
  signal \n_2_adapt_wait_hw.adapt_count_reg[16]_i_1\ : STD_LOGIC;
  signal \n_2_adapt_wait_hw.adapt_count_reg[20]_i_1\ : STD_LOGIC;
  signal \n_2_adapt_wait_hw.adapt_count_reg[4]_i_1\ : STD_LOGIC;
  signal \n_2_adapt_wait_hw.adapt_count_reg[8]_i_1\ : STD_LOGIC;
  signal n_2_sync_cplllock : STD_LOGIC;
  signal n_2_sync_data_valid : STD_LOGIC;
  signal \n_2_time_out_counter_reg[0]_i_2__0\ : STD_LOGIC;
  signal \n_2_time_out_counter_reg[12]_i_1__0\ : STD_LOGIC;
  signal \n_2_time_out_counter_reg[16]_i_1__0\ : STD_LOGIC;
  signal \n_2_time_out_counter_reg[4]_i_1__0\ : STD_LOGIC;
  signal \n_2_time_out_counter_reg[8]_i_1__0\ : STD_LOGIC;
  signal n_2_time_tlock_max_reg_i_3 : STD_LOGIC;
  signal n_2_time_tlock_max_reg_i_8 : STD_LOGIC;
  signal \n_2_wait_bypass_count_reg[0]_i_3__0\ : STD_LOGIC;
  signal \n_2_wait_bypass_count_reg[4]_i_1__0\ : STD_LOGIC;
  signal \n_2_wait_bypass_count_reg[8]_i_1__0\ : STD_LOGIC;
  signal \n_3_adapt_wait_hw.adapt_count_reg[0]_i_2\ : STD_LOGIC;
  signal \n_3_adapt_wait_hw.adapt_count_reg[12]_i_1\ : STD_LOGIC;
  signal \n_3_adapt_wait_hw.adapt_count_reg[16]_i_1\ : STD_LOGIC;
  signal \n_3_adapt_wait_hw.adapt_count_reg[20]_i_1\ : STD_LOGIC;
  signal \n_3_adapt_wait_hw.adapt_count_reg[4]_i_1\ : STD_LOGIC;
  signal \n_3_adapt_wait_hw.adapt_count_reg[8]_i_1\ : STD_LOGIC;
  signal n_3_sync_data_valid : STD_LOGIC;
  signal \n_3_time_out_counter_reg[0]_i_2__0\ : STD_LOGIC;
  signal \n_3_time_out_counter_reg[12]_i_1__0\ : STD_LOGIC;
  signal \n_3_time_out_counter_reg[16]_i_1__0\ : STD_LOGIC;
  signal \n_3_time_out_counter_reg[4]_i_1__0\ : STD_LOGIC;
  signal \n_3_time_out_counter_reg[8]_i_1__0\ : STD_LOGIC;
  signal n_3_time_tlock_max_reg_i_2 : STD_LOGIC;
  signal n_3_time_tlock_max_reg_i_3 : STD_LOGIC;
  signal n_3_time_tlock_max_reg_i_8 : STD_LOGIC;
  signal \n_3_wait_bypass_count_reg[0]_i_3__0\ : STD_LOGIC;
  signal \n_3_wait_bypass_count_reg[4]_i_1__0\ : STD_LOGIC;
  signal \n_3_wait_bypass_count_reg[8]_i_1__0\ : STD_LOGIC;
  signal \n_4_adapt_wait_hw.adapt_count_reg[0]_i_2\ : STD_LOGIC;
  signal \n_4_adapt_wait_hw.adapt_count_reg[12]_i_1\ : STD_LOGIC;
  signal \n_4_adapt_wait_hw.adapt_count_reg[16]_i_1\ : STD_LOGIC;
  signal \n_4_adapt_wait_hw.adapt_count_reg[4]_i_1\ : STD_LOGIC;
  signal \n_4_adapt_wait_hw.adapt_count_reg[8]_i_1\ : STD_LOGIC;
  signal n_4_sync_data_valid : STD_LOGIC;
  signal \n_4_time_out_counter_reg[0]_i_2__0\ : STD_LOGIC;
  signal \n_4_time_out_counter_reg[12]_i_1__0\ : STD_LOGIC;
  signal \n_4_time_out_counter_reg[16]_i_1__0\ : STD_LOGIC;
  signal \n_4_time_out_counter_reg[4]_i_1__0\ : STD_LOGIC;
  signal \n_4_time_out_counter_reg[8]_i_1__0\ : STD_LOGIC;
  signal \n_4_wait_bypass_count_reg[0]_i_3__0\ : STD_LOGIC;
  signal \n_4_wait_bypass_count_reg[4]_i_1__0\ : STD_LOGIC;
  signal \n_4_wait_bypass_count_reg[8]_i_1__0\ : STD_LOGIC;
  signal \n_5_adapt_wait_hw.adapt_count_reg[0]_i_2\ : STD_LOGIC;
  signal \n_5_adapt_wait_hw.adapt_count_reg[12]_i_1\ : STD_LOGIC;
  signal \n_5_adapt_wait_hw.adapt_count_reg[16]_i_1\ : STD_LOGIC;
  signal \n_5_adapt_wait_hw.adapt_count_reg[20]_i_1\ : STD_LOGIC;
  signal \n_5_adapt_wait_hw.adapt_count_reg[4]_i_1\ : STD_LOGIC;
  signal \n_5_adapt_wait_hw.adapt_count_reg[8]_i_1\ : STD_LOGIC;
  signal n_5_sync_data_valid : STD_LOGIC;
  signal \n_5_time_out_counter_reg[0]_i_2__0\ : STD_LOGIC;
  signal \n_5_time_out_counter_reg[12]_i_1__0\ : STD_LOGIC;
  signal \n_5_time_out_counter_reg[16]_i_1__0\ : STD_LOGIC;
  signal \n_5_time_out_counter_reg[4]_i_1__0\ : STD_LOGIC;
  signal \n_5_time_out_counter_reg[8]_i_1__0\ : STD_LOGIC;
  signal \n_5_wait_bypass_count_reg[0]_i_3__0\ : STD_LOGIC;
  signal \n_5_wait_bypass_count_reg[4]_i_1__0\ : STD_LOGIC;
  signal \n_5_wait_bypass_count_reg[8]_i_1__0\ : STD_LOGIC;
  signal \n_6_adapt_wait_hw.adapt_count_reg[0]_i_2\ : STD_LOGIC;
  signal \n_6_adapt_wait_hw.adapt_count_reg[12]_i_1\ : STD_LOGIC;
  signal \n_6_adapt_wait_hw.adapt_count_reg[16]_i_1\ : STD_LOGIC;
  signal \n_6_adapt_wait_hw.adapt_count_reg[20]_i_1\ : STD_LOGIC;
  signal \n_6_adapt_wait_hw.adapt_count_reg[4]_i_1\ : STD_LOGIC;
  signal \n_6_adapt_wait_hw.adapt_count_reg[8]_i_1\ : STD_LOGIC;
  signal \n_6_time_out_counter_reg[0]_i_2__0\ : STD_LOGIC;
  signal \n_6_time_out_counter_reg[12]_i_1__0\ : STD_LOGIC;
  signal \n_6_time_out_counter_reg[16]_i_1__0\ : STD_LOGIC;
  signal \n_6_time_out_counter_reg[4]_i_1__0\ : STD_LOGIC;
  signal \n_6_time_out_counter_reg[8]_i_1__0\ : STD_LOGIC;
  signal \n_6_wait_bypass_count_reg[0]_i_3__0\ : STD_LOGIC;
  signal \n_6_wait_bypass_count_reg[4]_i_1__0\ : STD_LOGIC;
  signal \n_6_wait_bypass_count_reg[8]_i_1__0\ : STD_LOGIC;
  signal \n_7_adapt_wait_hw.adapt_count_reg[0]_i_2\ : STD_LOGIC;
  signal \n_7_adapt_wait_hw.adapt_count_reg[12]_i_1\ : STD_LOGIC;
  signal \n_7_adapt_wait_hw.adapt_count_reg[16]_i_1\ : STD_LOGIC;
  signal \n_7_adapt_wait_hw.adapt_count_reg[20]_i_1\ : STD_LOGIC;
  signal \n_7_adapt_wait_hw.adapt_count_reg[4]_i_1\ : STD_LOGIC;
  signal \n_7_adapt_wait_hw.adapt_count_reg[8]_i_1\ : STD_LOGIC;
  signal \n_7_time_out_counter_reg[0]_i_2__0\ : STD_LOGIC;
  signal \n_7_time_out_counter_reg[12]_i_1__0\ : STD_LOGIC;
  signal \n_7_time_out_counter_reg[16]_i_1__0\ : STD_LOGIC;
  signal \n_7_time_out_counter_reg[4]_i_1__0\ : STD_LOGIC;
  signal \n_7_time_out_counter_reg[8]_i_1__0\ : STD_LOGIC;
  signal \n_7_wait_bypass_count_reg[0]_i_3__0\ : STD_LOGIC;
  signal \n_7_wait_bypass_count_reg[12]_i_1__0\ : STD_LOGIC;
  signal \n_7_wait_bypass_count_reg[4]_i_1__0\ : STD_LOGIC;
  signal \n_7_wait_bypass_count_reg[8]_i_1__0\ : STD_LOGIC;
  signal \p_0_in__1\ : STD_LOGIC_VECTOR ( 6 downto 1 );
  signal \p_0_in__2\ : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal recclk_mon_count_reset : STD_LOGIC;
  signal rx_fsm_reset_done_int_s2 : STD_LOGIC;
  signal rx_fsm_reset_done_int_s3 : STD_LOGIC;
  signal rx_state : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal rx_state16_out : STD_LOGIC;
  signal rxresetdone_s2 : STD_LOGIC;
  signal rxresetdone_s3 : STD_LOGIC;
  signal time_out_counter_reg : STD_LOGIC_VECTOR ( 19 downto 0 );
  signal time_out_wait_bypass_s2 : STD_LOGIC;
  signal time_out_wait_bypass_s3 : STD_LOGIC;
  signal time_tlock_max : STD_LOGIC;
  signal time_tlock_max1 : STD_LOGIC;
  signal wait_bypass_count_reg : STD_LOGIC_VECTOR ( 12 downto 0 );
  signal \wait_time_cnt0__0\ : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal \wait_time_cnt_reg__0\ : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal \NLW_adapt_wait_hw.adapt_count_reg[20]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_adapt_wait_hw.adapt_count_reg[20]_i_1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_time_out_counter_reg[16]_i_1__0_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal NLW_time_tlock_max_reg_i_2_CO_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal NLW_time_tlock_max_reg_i_2_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_time_tlock_max_reg_i_3_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_time_tlock_max_reg_i_8_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_wait_bypass_count_reg[12]_i_1__0_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_wait_bypass_count_reg[12]_i_1__0_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_sequential_rx_state[2]_i_2\ : label is "soft_lutpair93";
  attribute SOFT_HLUTNM of \FSM_sequential_rx_state[3]_i_12\ : label is "soft_lutpair88";
  attribute SOFT_HLUTNM of \FSM_sequential_rx_state[3]_i_13\ : label is "soft_lutpair91";
  attribute KEEP : string;
  attribute KEEP of \FSM_sequential_rx_state_reg[0]\ : label is "yes";
  attribute KEEP of \FSM_sequential_rx_state_reg[1]\ : label is "yes";
  attribute KEEP of \FSM_sequential_rx_state_reg[2]\ : label is "yes";
  attribute KEEP of \FSM_sequential_rx_state_reg[3]\ : label is "yes";
  attribute SOFT_HLUTNM of \adapt_wait_hw.adapt_count[0]_i_5\ : label is "soft_lutpair83";
  attribute SOFT_HLUTNM of \adapt_wait_hw.time_out_adapt_i_4\ : label is "soft_lutpair83";
  attribute SOFT_HLUTNM of \init_wait_count[1]_i_1__0\ : label is "soft_lutpair95";
  attribute SOFT_HLUTNM of \init_wait_count[2]_i_1__0\ : label is "soft_lutpair87";
  attribute SOFT_HLUTNM of \init_wait_count[3]_i_1__0\ : label is "soft_lutpair87";
  attribute SOFT_HLUTNM of \init_wait_count[4]_i_1__0\ : label is "soft_lutpair85";
  attribute SOFT_HLUTNM of \init_wait_count[6]_i_3__0\ : label is "soft_lutpair95";
  attribute SOFT_HLUTNM of \init_wait_count[6]_i_4__0\ : label is "soft_lutpair85";
  attribute SOFT_HLUTNM of \mmcm_lock_count[1]_i_1__0\ : label is "soft_lutpair92";
  attribute SOFT_HLUTNM of \mmcm_lock_count[2]_i_1__0\ : label is "soft_lutpair92";
  attribute SOFT_HLUTNM of \mmcm_lock_count[3]_i_1__0\ : label is "soft_lutpair82";
  attribute SOFT_HLUTNM of \mmcm_lock_count[4]_i_1__0\ : label is "soft_lutpair82";
  attribute SOFT_HLUTNM of \mmcm_lock_count[7]_i_1__0\ : label is "soft_lutpair90";
  attribute SOFT_HLUTNM of \mmcm_lock_count[8]_i_1__0\ : label is "soft_lutpair90";
  attribute SOFT_HLUTNM of \mmcm_lock_count[9]_i_3__0\ : label is "soft_lutpair84";
  attribute SOFT_HLUTNM of \mmcm_lock_reclocked_i_2__0\ : label is "soft_lutpair84";
  attribute SOFT_HLUTNM of time_out_1us_i_2 : label is "soft_lutpair89";
  attribute SOFT_HLUTNM of \time_out_counter[0]_i_5__0\ : label is "soft_lutpair89";
  attribute SOFT_HLUTNM of \time_tlock_max_i_1__0\ : label is "soft_lutpair93";
  attribute SOFT_HLUTNM of \wait_time_cnt[0]_i_1__0\ : label is "soft_lutpair94";
  attribute SOFT_HLUTNM of \wait_time_cnt[1]_i_1__0\ : label is "soft_lutpair94";
  attribute SOFT_HLUTNM of \wait_time_cnt[2]_i_1__0\ : label is "soft_lutpair91";
  attribute SOFT_HLUTNM of \wait_time_cnt[3]_i_1__0\ : label is "soft_lutpair86";
  attribute SOFT_HLUTNM of \wait_time_cnt[4]_i_1__0\ : label is "soft_lutpair86";
  attribute SOFT_HLUTNM of \wait_time_cnt[6]_i_4__0\ : label is "soft_lutpair88";
begin
  O1 <= \^o1\;
  RXDFELFHOLD <= \^rxdfelfhold\;
  RXUSERRDY <= \^rxuserrdy\;
  data_in <= \^data_in\;
\FSM_sequential_rx_state[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CF40CF4F00000000"
    )
    port map (
      I0 => n_0_time_out_2ms_reg,
      I1 => rx_state(2),
      I2 => rx_state(1),
      I3 => n_0_reset_time_out_reg,
      I4 => time_tlock_max,
      I5 => rx_state(0),
      O => \n_0_FSM_sequential_rx_state[0]_i_2\
    );
\FSM_sequential_rx_state[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000F5F00003000"
    )
    port map (
      I0 => rx_state16_out,
      I1 => n_0_time_out_2ms_reg,
      I2 => rx_state(0),
      I3 => rx_state(1),
      I4 => rx_state(3),
      I5 => rx_state(2),
      O => \n_0_FSM_sequential_rx_state[2]_i_1\
    );
\FSM_sequential_rx_state[2]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => time_tlock_max,
      I1 => n_0_reset_time_out_reg,
      O => rx_state16_out
    );
\FSM_sequential_rx_state[3]_i_10\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"88A8"
    )
    port map (
      I0 => rx_state(2),
      I1 => rxresetdone_s3,
      I2 => n_0_time_out_2ms_reg,
      I3 => n_0_reset_time_out_reg,
      O => \n_0_FSM_sequential_rx_state[3]_i_10\
    );
\FSM_sequential_rx_state[3]_i_12\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => \wait_time_cnt_reg__0\(5),
      I1 => \wait_time_cnt_reg__0\(4),
      I2 => \wait_time_cnt_reg__0\(3),
      I3 => \wait_time_cnt_reg__0\(2),
      O => \n_0_FSM_sequential_rx_state[3]_i_12\
    );
\FSM_sequential_rx_state[3]_i_13\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => \wait_time_cnt_reg__0\(0),
      I1 => \wait_time_cnt_reg__0\(1),
      I2 => \wait_time_cnt_reg__0\(6),
      O => \n_0_FSM_sequential_rx_state[3]_i_13\
    );
\FSM_sequential_rx_state[3]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FEFFFE00FEFFFEFF"
    )
    port map (
      I0 => \n_0_FSM_sequential_rx_state[3]_i_12\,
      I1 => \n_0_FSM_sequential_rx_state[3]_i_13\,
      I2 => rx_state(0),
      I3 => rx_state(1),
      I4 => rx_state(2),
      I5 => n_0_init_wait_done_reg,
      O => \n_0_FSM_sequential_rx_state[3]_i_6\
    );
\FSM_sequential_rx_state[3]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BB0000000000FF0F"
    )
    port map (
      I0 => n_0_reset_time_out_reg,
      I1 => n_0_time_out_2ms_reg,
      I2 => time_out_wait_bypass_s3,
      I3 => rx_state(1),
      I4 => rx_state(0),
      I5 => rx_state(2),
      O => \n_0_FSM_sequential_rx_state[3]_i_7\
    );
\FSM_sequential_rx_state[3]_i_9\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AEFF"
    )
    port map (
      I0 => mmcm_lock_reclocked,
      I1 => time_tlock_max,
      I2 => n_0_reset_time_out_reg,
      I3 => rx_state(2),
      O => \n_0_FSM_sequential_rx_state[3]_i_9\
    );
\FSM_sequential_rx_state_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => n_2_sync_data_valid,
      D => n_5_sync_data_valid,
      Q => rx_state(0),
      R => AR(0)
    );
\FSM_sequential_rx_state_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => n_2_sync_data_valid,
      D => n_4_sync_data_valid,
      Q => rx_state(1),
      R => AR(0)
    );
\FSM_sequential_rx_state_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => n_2_sync_data_valid,
      D => \n_0_FSM_sequential_rx_state[2]_i_1\,
      Q => rx_state(2),
      R => AR(0)
    );
\FSM_sequential_rx_state_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => n_2_sync_data_valid,
      D => n_3_sync_data_valid,
      Q => rx_state(3),
      R => AR(0)
    );
RXDFEAGCHOLD_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00400000"
    )
    port map (
      I0 => rx_state(0),
      I1 => rx_state(3),
      I2 => rx_state(1),
      I3 => rx_state(2),
      I4 => \n_0_adapt_wait_hw.time_out_adapt_reg\,
      I5 => \^rxdfelfhold\,
      O => n_0_RXDFEAGCHOLD_i_1
    );
RXDFEAGCHOLD_reg: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => n_0_RXDFEAGCHOLD_i_1,
      Q => \^rxdfelfhold\,
      R => AR(0)
    );
RXUSERRDY_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFB4000"
    )
    port map (
      I0 => rx_state(3),
      I1 => rx_state(0),
      I2 => rx_state(2),
      I3 => rx_state(1),
      I4 => \^rxuserrdy\,
      O => n_0_RXUSERRDY_i_1
    );
RXUSERRDY_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => n_0_RXUSERRDY_i_1,
      Q => \^rxuserrdy\,
      R => AR(0)
    );
adapt_count_reset_reg: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => n_0_sync_cplllock,
      Q => recclk_mon_count_reset,
      S => AR(0)
    );
\adapt_wait_hw.adapt_count[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFB"
    )
    port map (
      I0 => \n_0_adapt_wait_hw.adapt_count[0]_i_3\,
      I1 => \n_0_adapt_wait_hw.adapt_count[0]_i_4\,
      I2 => \adapt_wait_hw.adapt_count_reg\(18),
      I3 => \adapt_wait_hw.adapt_count_reg\(17),
      I4 => \n_0_adapt_wait_hw.adapt_count[0]_i_5\,
      I5 => \n_0_adapt_wait_hw.adapt_count[0]_i_6\,
      O => \n_0_adapt_wait_hw.adapt_count[0]_i_1\
    );
\adapt_wait_hw.adapt_count[0]_i_10\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \adapt_wait_hw.adapt_count_reg\(0),
      O => \n_0_adapt_wait_hw.adapt_count[0]_i_10\
    );
\adapt_wait_hw.adapt_count[0]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF7FFFFFFFFFF"
    )
    port map (
      I0 => \adapt_wait_hw.adapt_count_reg\(14),
      I1 => \adapt_wait_hw.adapt_count_reg\(13),
      I2 => \adapt_wait_hw.adapt_count_reg\(16),
      I3 => \adapt_wait_hw.adapt_count_reg\(15),
      I4 => \adapt_wait_hw.adapt_count_reg\(12),
      I5 => \adapt_wait_hw.adapt_count_reg\(11),
      O => \n_0_adapt_wait_hw.adapt_count[0]_i_3\
    );
\adapt_wait_hw.adapt_count[0]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4000"
    )
    port map (
      I0 => \adapt_wait_hw.adapt_count_reg\(19),
      I1 => \adapt_wait_hw.adapt_count_reg\(20),
      I2 => \adapt_wait_hw.adapt_count_reg\(22),
      I3 => \adapt_wait_hw.adapt_count_reg\(21),
      O => \n_0_adapt_wait_hw.adapt_count[0]_i_4\
    );
\adapt_wait_hw.adapt_count[0]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFEFFFFF"
    )
    port map (
      I0 => \adapt_wait_hw.adapt_count_reg\(8),
      I1 => \adapt_wait_hw.adapt_count_reg\(7),
      I2 => \adapt_wait_hw.adapt_count_reg\(0),
      I3 => \adapt_wait_hw.adapt_count_reg\(10),
      I4 => \adapt_wait_hw.adapt_count_reg\(9),
      O => \n_0_adapt_wait_hw.adapt_count[0]_i_5\
    );
\adapt_wait_hw.adapt_count[0]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F7FFFFFFFFFFFFFF"
    )
    port map (
      I0 => \adapt_wait_hw.adapt_count_reg\(4),
      I1 => \adapt_wait_hw.adapt_count_reg\(3),
      I2 => \adapt_wait_hw.adapt_count_reg\(6),
      I3 => \adapt_wait_hw.adapt_count_reg\(5),
      I4 => \adapt_wait_hw.adapt_count_reg\(2),
      I5 => \adapt_wait_hw.adapt_count_reg\(1),
      O => \n_0_adapt_wait_hw.adapt_count[0]_i_6\
    );
\adapt_wait_hw.adapt_count[0]_i_7\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \adapt_wait_hw.adapt_count_reg\(3),
      O => \n_0_adapt_wait_hw.adapt_count[0]_i_7\
    );
\adapt_wait_hw.adapt_count[0]_i_8\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \adapt_wait_hw.adapt_count_reg\(2),
      O => \n_0_adapt_wait_hw.adapt_count[0]_i_8\
    );
\adapt_wait_hw.adapt_count[0]_i_9\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \adapt_wait_hw.adapt_count_reg\(1),
      O => \n_0_adapt_wait_hw.adapt_count[0]_i_9\
    );
\adapt_wait_hw.adapt_count[12]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \adapt_wait_hw.adapt_count_reg\(15),
      O => \n_0_adapt_wait_hw.adapt_count[12]_i_2\
    );
\adapt_wait_hw.adapt_count[12]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \adapt_wait_hw.adapt_count_reg\(14),
      O => \n_0_adapt_wait_hw.adapt_count[12]_i_3\
    );
\adapt_wait_hw.adapt_count[12]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \adapt_wait_hw.adapt_count_reg\(13),
      O => \n_0_adapt_wait_hw.adapt_count[12]_i_4\
    );
\adapt_wait_hw.adapt_count[12]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \adapt_wait_hw.adapt_count_reg\(12),
      O => \n_0_adapt_wait_hw.adapt_count[12]_i_5\
    );
\adapt_wait_hw.adapt_count[16]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \adapt_wait_hw.adapt_count_reg\(19),
      O => \n_0_adapt_wait_hw.adapt_count[16]_i_2\
    );
\adapt_wait_hw.adapt_count[16]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \adapt_wait_hw.adapt_count_reg\(18),
      O => \n_0_adapt_wait_hw.adapt_count[16]_i_3\
    );
\adapt_wait_hw.adapt_count[16]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \adapt_wait_hw.adapt_count_reg\(17),
      O => \n_0_adapt_wait_hw.adapt_count[16]_i_4\
    );
\adapt_wait_hw.adapt_count[16]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \adapt_wait_hw.adapt_count_reg\(16),
      O => \n_0_adapt_wait_hw.adapt_count[16]_i_5\
    );
\adapt_wait_hw.adapt_count[20]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \adapt_wait_hw.adapt_count_reg\(22),
      O => \n_0_adapt_wait_hw.adapt_count[20]_i_2\
    );
\adapt_wait_hw.adapt_count[20]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \adapt_wait_hw.adapt_count_reg\(21),
      O => \n_0_adapt_wait_hw.adapt_count[20]_i_3\
    );
\adapt_wait_hw.adapt_count[20]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \adapt_wait_hw.adapt_count_reg\(20),
      O => \n_0_adapt_wait_hw.adapt_count[20]_i_4\
    );
\adapt_wait_hw.adapt_count[4]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \adapt_wait_hw.adapt_count_reg\(7),
      O => \n_0_adapt_wait_hw.adapt_count[4]_i_2\
    );
\adapt_wait_hw.adapt_count[4]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \adapt_wait_hw.adapt_count_reg\(6),
      O => \n_0_adapt_wait_hw.adapt_count[4]_i_3\
    );
\adapt_wait_hw.adapt_count[4]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \adapt_wait_hw.adapt_count_reg\(5),
      O => \n_0_adapt_wait_hw.adapt_count[4]_i_4\
    );
\adapt_wait_hw.adapt_count[4]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \adapt_wait_hw.adapt_count_reg\(4),
      O => \n_0_adapt_wait_hw.adapt_count[4]_i_5\
    );
\adapt_wait_hw.adapt_count[8]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \adapt_wait_hw.adapt_count_reg\(11),
      O => \n_0_adapt_wait_hw.adapt_count[8]_i_2\
    );
\adapt_wait_hw.adapt_count[8]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \adapt_wait_hw.adapt_count_reg\(10),
      O => \n_0_adapt_wait_hw.adapt_count[8]_i_3\
    );
\adapt_wait_hw.adapt_count[8]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \adapt_wait_hw.adapt_count_reg\(9),
      O => \n_0_adapt_wait_hw.adapt_count[8]_i_4\
    );
\adapt_wait_hw.adapt_count[8]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \adapt_wait_hw.adapt_count_reg\(8),
      O => \n_0_adapt_wait_hw.adapt_count[8]_i_5\
    );
\adapt_wait_hw.adapt_count_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => \n_0_adapt_wait_hw.adapt_count[0]_i_1\,
      D => \n_7_adapt_wait_hw.adapt_count_reg[0]_i_2\,
      Q => \adapt_wait_hw.adapt_count_reg\(0),
      R => recclk_mon_count_reset
    );
\adapt_wait_hw.adapt_count_reg[0]_i_2\: unisim.vcomponents.CARRY4
    port map (
      CI => '0',
      CO(3) => \n_0_adapt_wait_hw.adapt_count_reg[0]_i_2\,
      CO(2) => \n_1_adapt_wait_hw.adapt_count_reg[0]_i_2\,
      CO(1) => \n_2_adapt_wait_hw.adapt_count_reg[0]_i_2\,
      CO(0) => \n_3_adapt_wait_hw.adapt_count_reg[0]_i_2\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '1',
      O(3) => \n_4_adapt_wait_hw.adapt_count_reg[0]_i_2\,
      O(2) => \n_5_adapt_wait_hw.adapt_count_reg[0]_i_2\,
      O(1) => \n_6_adapt_wait_hw.adapt_count_reg[0]_i_2\,
      O(0) => \n_7_adapt_wait_hw.adapt_count_reg[0]_i_2\,
      S(3) => \n_0_adapt_wait_hw.adapt_count[0]_i_7\,
      S(2) => \n_0_adapt_wait_hw.adapt_count[0]_i_8\,
      S(1) => \n_0_adapt_wait_hw.adapt_count[0]_i_9\,
      S(0) => \n_0_adapt_wait_hw.adapt_count[0]_i_10\
    );
\adapt_wait_hw.adapt_count_reg[10]\: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => \n_0_adapt_wait_hw.adapt_count[0]_i_1\,
      D => \n_5_adapt_wait_hw.adapt_count_reg[8]_i_1\,
      Q => \adapt_wait_hw.adapt_count_reg\(10),
      R => recclk_mon_count_reset
    );
\adapt_wait_hw.adapt_count_reg[11]\: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => \n_0_adapt_wait_hw.adapt_count[0]_i_1\,
      D => \n_4_adapt_wait_hw.adapt_count_reg[8]_i_1\,
      Q => \adapt_wait_hw.adapt_count_reg\(11),
      R => recclk_mon_count_reset
    );
\adapt_wait_hw.adapt_count_reg[12]\: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => \n_0_adapt_wait_hw.adapt_count[0]_i_1\,
      D => \n_7_adapt_wait_hw.adapt_count_reg[12]_i_1\,
      Q => \adapt_wait_hw.adapt_count_reg\(12),
      R => recclk_mon_count_reset
    );
\adapt_wait_hw.adapt_count_reg[12]_i_1\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_adapt_wait_hw.adapt_count_reg[8]_i_1\,
      CO(3) => \n_0_adapt_wait_hw.adapt_count_reg[12]_i_1\,
      CO(2) => \n_1_adapt_wait_hw.adapt_count_reg[12]_i_1\,
      CO(1) => \n_2_adapt_wait_hw.adapt_count_reg[12]_i_1\,
      CO(0) => \n_3_adapt_wait_hw.adapt_count_reg[12]_i_1\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '0',
      O(3) => \n_4_adapt_wait_hw.adapt_count_reg[12]_i_1\,
      O(2) => \n_5_adapt_wait_hw.adapt_count_reg[12]_i_1\,
      O(1) => \n_6_adapt_wait_hw.adapt_count_reg[12]_i_1\,
      O(0) => \n_7_adapt_wait_hw.adapt_count_reg[12]_i_1\,
      S(3) => \n_0_adapt_wait_hw.adapt_count[12]_i_2\,
      S(2) => \n_0_adapt_wait_hw.adapt_count[12]_i_3\,
      S(1) => \n_0_adapt_wait_hw.adapt_count[12]_i_4\,
      S(0) => \n_0_adapt_wait_hw.adapt_count[12]_i_5\
    );
\adapt_wait_hw.adapt_count_reg[13]\: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => \n_0_adapt_wait_hw.adapt_count[0]_i_1\,
      D => \n_6_adapt_wait_hw.adapt_count_reg[12]_i_1\,
      Q => \adapt_wait_hw.adapt_count_reg\(13),
      R => recclk_mon_count_reset
    );
\adapt_wait_hw.adapt_count_reg[14]\: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => \n_0_adapt_wait_hw.adapt_count[0]_i_1\,
      D => \n_5_adapt_wait_hw.adapt_count_reg[12]_i_1\,
      Q => \adapt_wait_hw.adapt_count_reg\(14),
      R => recclk_mon_count_reset
    );
\adapt_wait_hw.adapt_count_reg[15]\: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => \n_0_adapt_wait_hw.adapt_count[0]_i_1\,
      D => \n_4_adapt_wait_hw.adapt_count_reg[12]_i_1\,
      Q => \adapt_wait_hw.adapt_count_reg\(15),
      R => recclk_mon_count_reset
    );
\adapt_wait_hw.adapt_count_reg[16]\: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => \n_0_adapt_wait_hw.adapt_count[0]_i_1\,
      D => \n_7_adapt_wait_hw.adapt_count_reg[16]_i_1\,
      Q => \adapt_wait_hw.adapt_count_reg\(16),
      R => recclk_mon_count_reset
    );
\adapt_wait_hw.adapt_count_reg[16]_i_1\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_adapt_wait_hw.adapt_count_reg[12]_i_1\,
      CO(3) => \n_0_adapt_wait_hw.adapt_count_reg[16]_i_1\,
      CO(2) => \n_1_adapt_wait_hw.adapt_count_reg[16]_i_1\,
      CO(1) => \n_2_adapt_wait_hw.adapt_count_reg[16]_i_1\,
      CO(0) => \n_3_adapt_wait_hw.adapt_count_reg[16]_i_1\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '0',
      O(3) => \n_4_adapt_wait_hw.adapt_count_reg[16]_i_1\,
      O(2) => \n_5_adapt_wait_hw.adapt_count_reg[16]_i_1\,
      O(1) => \n_6_adapt_wait_hw.adapt_count_reg[16]_i_1\,
      O(0) => \n_7_adapt_wait_hw.adapt_count_reg[16]_i_1\,
      S(3) => \n_0_adapt_wait_hw.adapt_count[16]_i_2\,
      S(2) => \n_0_adapt_wait_hw.adapt_count[16]_i_3\,
      S(1) => \n_0_adapt_wait_hw.adapt_count[16]_i_4\,
      S(0) => \n_0_adapt_wait_hw.adapt_count[16]_i_5\
    );
\adapt_wait_hw.adapt_count_reg[17]\: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => \n_0_adapt_wait_hw.adapt_count[0]_i_1\,
      D => \n_6_adapt_wait_hw.adapt_count_reg[16]_i_1\,
      Q => \adapt_wait_hw.adapt_count_reg\(17),
      R => recclk_mon_count_reset
    );
\adapt_wait_hw.adapt_count_reg[18]\: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => \n_0_adapt_wait_hw.adapt_count[0]_i_1\,
      D => \n_5_adapt_wait_hw.adapt_count_reg[16]_i_1\,
      Q => \adapt_wait_hw.adapt_count_reg\(18),
      R => recclk_mon_count_reset
    );
\adapt_wait_hw.adapt_count_reg[19]\: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => \n_0_adapt_wait_hw.adapt_count[0]_i_1\,
      D => \n_4_adapt_wait_hw.adapt_count_reg[16]_i_1\,
      Q => \adapt_wait_hw.adapt_count_reg\(19),
      R => recclk_mon_count_reset
    );
\adapt_wait_hw.adapt_count_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => \n_0_adapt_wait_hw.adapt_count[0]_i_1\,
      D => \n_6_adapt_wait_hw.adapt_count_reg[0]_i_2\,
      Q => \adapt_wait_hw.adapt_count_reg\(1),
      R => recclk_mon_count_reset
    );
\adapt_wait_hw.adapt_count_reg[20]\: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => \n_0_adapt_wait_hw.adapt_count[0]_i_1\,
      D => \n_7_adapt_wait_hw.adapt_count_reg[20]_i_1\,
      Q => \adapt_wait_hw.adapt_count_reg\(20),
      R => recclk_mon_count_reset
    );
\adapt_wait_hw.adapt_count_reg[20]_i_1\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_adapt_wait_hw.adapt_count_reg[16]_i_1\,
      CO(3 downto 2) => \NLW_adapt_wait_hw.adapt_count_reg[20]_i_1_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \n_2_adapt_wait_hw.adapt_count_reg[20]_i_1\,
      CO(0) => \n_3_adapt_wait_hw.adapt_count_reg[20]_i_1\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '0',
      O(3) => \NLW_adapt_wait_hw.adapt_count_reg[20]_i_1_O_UNCONNECTED\(3),
      O(2) => \n_5_adapt_wait_hw.adapt_count_reg[20]_i_1\,
      O(1) => \n_6_adapt_wait_hw.adapt_count_reg[20]_i_1\,
      O(0) => \n_7_adapt_wait_hw.adapt_count_reg[20]_i_1\,
      S(3) => '0',
      S(2) => \n_0_adapt_wait_hw.adapt_count[20]_i_2\,
      S(1) => \n_0_adapt_wait_hw.adapt_count[20]_i_3\,
      S(0) => \n_0_adapt_wait_hw.adapt_count[20]_i_4\
    );
\adapt_wait_hw.adapt_count_reg[21]\: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => \n_0_adapt_wait_hw.adapt_count[0]_i_1\,
      D => \n_6_adapt_wait_hw.adapt_count_reg[20]_i_1\,
      Q => \adapt_wait_hw.adapt_count_reg\(21),
      R => recclk_mon_count_reset
    );
\adapt_wait_hw.adapt_count_reg[22]\: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => \n_0_adapt_wait_hw.adapt_count[0]_i_1\,
      D => \n_5_adapt_wait_hw.adapt_count_reg[20]_i_1\,
      Q => \adapt_wait_hw.adapt_count_reg\(22),
      R => recclk_mon_count_reset
    );
\adapt_wait_hw.adapt_count_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => \n_0_adapt_wait_hw.adapt_count[0]_i_1\,
      D => \n_5_adapt_wait_hw.adapt_count_reg[0]_i_2\,
      Q => \adapt_wait_hw.adapt_count_reg\(2),
      R => recclk_mon_count_reset
    );
\adapt_wait_hw.adapt_count_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => \n_0_adapt_wait_hw.adapt_count[0]_i_1\,
      D => \n_4_adapt_wait_hw.adapt_count_reg[0]_i_2\,
      Q => \adapt_wait_hw.adapt_count_reg\(3),
      R => recclk_mon_count_reset
    );
\adapt_wait_hw.adapt_count_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => \n_0_adapt_wait_hw.adapt_count[0]_i_1\,
      D => \n_7_adapt_wait_hw.adapt_count_reg[4]_i_1\,
      Q => \adapt_wait_hw.adapt_count_reg\(4),
      R => recclk_mon_count_reset
    );
\adapt_wait_hw.adapt_count_reg[4]_i_1\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_adapt_wait_hw.adapt_count_reg[0]_i_2\,
      CO(3) => \n_0_adapt_wait_hw.adapt_count_reg[4]_i_1\,
      CO(2) => \n_1_adapt_wait_hw.adapt_count_reg[4]_i_1\,
      CO(1) => \n_2_adapt_wait_hw.adapt_count_reg[4]_i_1\,
      CO(0) => \n_3_adapt_wait_hw.adapt_count_reg[4]_i_1\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '0',
      O(3) => \n_4_adapt_wait_hw.adapt_count_reg[4]_i_1\,
      O(2) => \n_5_adapt_wait_hw.adapt_count_reg[4]_i_1\,
      O(1) => \n_6_adapt_wait_hw.adapt_count_reg[4]_i_1\,
      O(0) => \n_7_adapt_wait_hw.adapt_count_reg[4]_i_1\,
      S(3) => \n_0_adapt_wait_hw.adapt_count[4]_i_2\,
      S(2) => \n_0_adapt_wait_hw.adapt_count[4]_i_3\,
      S(1) => \n_0_adapt_wait_hw.adapt_count[4]_i_4\,
      S(0) => \n_0_adapt_wait_hw.adapt_count[4]_i_5\
    );
\adapt_wait_hw.adapt_count_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => \n_0_adapt_wait_hw.adapt_count[0]_i_1\,
      D => \n_6_adapt_wait_hw.adapt_count_reg[4]_i_1\,
      Q => \adapt_wait_hw.adapt_count_reg\(5),
      R => recclk_mon_count_reset
    );
\adapt_wait_hw.adapt_count_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => \n_0_adapt_wait_hw.adapt_count[0]_i_1\,
      D => \n_5_adapt_wait_hw.adapt_count_reg[4]_i_1\,
      Q => \adapt_wait_hw.adapt_count_reg\(6),
      R => recclk_mon_count_reset
    );
\adapt_wait_hw.adapt_count_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => \n_0_adapt_wait_hw.adapt_count[0]_i_1\,
      D => \n_4_adapt_wait_hw.adapt_count_reg[4]_i_1\,
      Q => \adapt_wait_hw.adapt_count_reg\(7),
      R => recclk_mon_count_reset
    );
\adapt_wait_hw.adapt_count_reg[8]\: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => \n_0_adapt_wait_hw.adapt_count[0]_i_1\,
      D => \n_7_adapt_wait_hw.adapt_count_reg[8]_i_1\,
      Q => \adapt_wait_hw.adapt_count_reg\(8),
      R => recclk_mon_count_reset
    );
\adapt_wait_hw.adapt_count_reg[8]_i_1\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_adapt_wait_hw.adapt_count_reg[4]_i_1\,
      CO(3) => \n_0_adapt_wait_hw.adapt_count_reg[8]_i_1\,
      CO(2) => \n_1_adapt_wait_hw.adapt_count_reg[8]_i_1\,
      CO(1) => \n_2_adapt_wait_hw.adapt_count_reg[8]_i_1\,
      CO(0) => \n_3_adapt_wait_hw.adapt_count_reg[8]_i_1\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '0',
      O(3) => \n_4_adapt_wait_hw.adapt_count_reg[8]_i_1\,
      O(2) => \n_5_adapt_wait_hw.adapt_count_reg[8]_i_1\,
      O(1) => \n_6_adapt_wait_hw.adapt_count_reg[8]_i_1\,
      O(0) => \n_7_adapt_wait_hw.adapt_count_reg[8]_i_1\,
      S(3) => \n_0_adapt_wait_hw.adapt_count[8]_i_2\,
      S(2) => \n_0_adapt_wait_hw.adapt_count[8]_i_3\,
      S(1) => \n_0_adapt_wait_hw.adapt_count[8]_i_4\,
      S(0) => \n_0_adapt_wait_hw.adapt_count[8]_i_5\
    );
\adapt_wait_hw.adapt_count_reg[9]\: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => \n_0_adapt_wait_hw.adapt_count[0]_i_1\,
      D => \n_6_adapt_wait_hw.adapt_count_reg[8]_i_1\,
      Q => \adapt_wait_hw.adapt_count_reg\(9),
      R => recclk_mon_count_reset
    );
\adapt_wait_hw.time_out_adapt_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000EAAAAAAA"
    )
    port map (
      I0 => \n_0_adapt_wait_hw.time_out_adapt_reg\,
      I1 => \n_0_adapt_wait_hw.time_out_adapt_i_2\,
      I2 => \n_0_adapt_wait_hw.time_out_adapt_i_3\,
      I3 => \n_0_adapt_wait_hw.time_out_adapt_i_4\,
      I4 => \n_0_adapt_wait_hw.time_out_adapt_i_5\,
      I5 => recclk_mon_count_reset,
      O => \n_0_adapt_wait_hw.time_out_adapt_i_1\
    );
\adapt_wait_hw.time_out_adapt_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0040000000000000"
    )
    port map (
      I0 => \adapt_wait_hw.adapt_count_reg\(12),
      I1 => \adapt_wait_hw.adapt_count_reg\(11),
      I2 => \adapt_wait_hw.adapt_count_reg\(15),
      I3 => \adapt_wait_hw.adapt_count_reg\(16),
      I4 => \adapt_wait_hw.adapt_count_reg\(13),
      I5 => \adapt_wait_hw.adapt_count_reg\(14),
      O => \n_0_adapt_wait_hw.time_out_adapt_i_2\
    );
\adapt_wait_hw.time_out_adapt_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000010000000"
    )
    port map (
      I0 => \adapt_wait_hw.adapt_count_reg\(18),
      I1 => \adapt_wait_hw.adapt_count_reg\(17),
      I2 => \adapt_wait_hw.adapt_count_reg\(21),
      I3 => \adapt_wait_hw.adapt_count_reg\(22),
      I4 => \adapt_wait_hw.adapt_count_reg\(20),
      I5 => \adapt_wait_hw.adapt_count_reg\(19),
      O => \n_0_adapt_wait_hw.time_out_adapt_i_3\
    );
\adapt_wait_hw.time_out_adapt_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000040"
    )
    port map (
      I0 => \adapt_wait_hw.adapt_count_reg\(10),
      I1 => \adapt_wait_hw.adapt_count_reg\(9),
      I2 => \adapt_wait_hw.adapt_count_reg\(0),
      I3 => \adapt_wait_hw.adapt_count_reg\(7),
      I4 => \adapt_wait_hw.adapt_count_reg\(8),
      O => \n_0_adapt_wait_hw.time_out_adapt_i_4\
    );
\adapt_wait_hw.time_out_adapt_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0080000000000000"
    )
    port map (
      I0 => \adapt_wait_hw.adapt_count_reg\(2),
      I1 => \adapt_wait_hw.adapt_count_reg\(1),
      I2 => \adapt_wait_hw.adapt_count_reg\(5),
      I3 => \adapt_wait_hw.adapt_count_reg\(6),
      I4 => \adapt_wait_hw.adapt_count_reg\(3),
      I5 => \adapt_wait_hw.adapt_count_reg\(4),
      O => \n_0_adapt_wait_hw.time_out_adapt_i_5\
    );
\adapt_wait_hw.time_out_adapt_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => \n_0_adapt_wait_hw.time_out_adapt_i_1\,
      Q => \n_0_adapt_wait_hw.time_out_adapt_reg\,
      R => '0'
    );
check_tlock_max_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFB0008"
    )
    port map (
      I0 => rx_state(2),
      I1 => rx_state(0),
      I2 => rx_state(1),
      I3 => rx_state(3),
      I4 => n_0_check_tlock_max_reg,
      O => n_0_check_tlock_max_i_1
    );
check_tlock_max_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => n_0_check_tlock_max_i_1,
      Q => n_0_check_tlock_max_reg,
      R => AR(0)
    );
gtrxreset_i_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFD0004"
    )
    port map (
      I0 => rx_state(2),
      I1 => rx_state(0),
      I2 => rx_state(1),
      I3 => rx_state(3),
      I4 => \^data_in\,
      O => n_0_gtrxreset_i_i_1
    );
gtrxreset_i_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => n_0_gtrxreset_i_i_1,
      Q => \^data_in\,
      R => AR(0)
    );
\init_wait_count[0]_i_1__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \init_wait_count_reg__0\(0),
      O => \n_0_init_wait_count[0]_i_1__0\
    );
\init_wait_count[1]_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \init_wait_count_reg__0\(1),
      I1 => \init_wait_count_reg__0\(0),
      O => \p_0_in__1\(1)
    );
\init_wait_count[2]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
    port map (
      I0 => \init_wait_count_reg__0\(1),
      I1 => \init_wait_count_reg__0\(0),
      I2 => \init_wait_count_reg__0\(2),
      O => \p_0_in__1\(2)
    );
\init_wait_count[3]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
    port map (
      I0 => \init_wait_count_reg__0\(2),
      I1 => \init_wait_count_reg__0\(0),
      I2 => \init_wait_count_reg__0\(1),
      I3 => \init_wait_count_reg__0\(3),
      O => \p_0_in__1\(3)
    );
\init_wait_count[4]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFF8000"
    )
    port map (
      I0 => \init_wait_count_reg__0\(3),
      I1 => \init_wait_count_reg__0\(1),
      I2 => \init_wait_count_reg__0\(0),
      I3 => \init_wait_count_reg__0\(2),
      I4 => \init_wait_count_reg__0\(4),
      O => \p_0_in__1\(4)
    );
\init_wait_count[5]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFF80000000"
    )
    port map (
      I0 => \init_wait_count_reg__0\(4),
      I1 => \init_wait_count_reg__0\(2),
      I2 => \init_wait_count_reg__0\(0),
      I3 => \init_wait_count_reg__0\(1),
      I4 => \init_wait_count_reg__0\(3),
      I5 => \init_wait_count_reg__0\(5),
      O => \p_0_in__1\(5)
    );
\init_wait_count[6]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFF7FFFFF"
    )
    port map (
      I0 => \init_wait_count_reg__0\(5),
      I1 => \init_wait_count_reg__0\(6),
      I2 => \init_wait_count_reg__0\(3),
      I3 => \init_wait_count_reg__0\(4),
      I4 => \init_wait_count_reg__0\(2),
      I5 => \n_0_init_wait_count[6]_i_3__0\,
      O => \n_0_init_wait_count[6]_i_1__0\
    );
\init_wait_count[6]_i_2__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"D2"
    )
    port map (
      I0 => \init_wait_count_reg__0\(5),
      I1 => \n_0_init_wait_count[6]_i_4__0\,
      I2 => \init_wait_count_reg__0\(6),
      O => \p_0_in__1\(6)
    );
\init_wait_count[6]_i_3__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => \init_wait_count_reg__0\(0),
      I1 => \init_wait_count_reg__0\(1),
      O => \n_0_init_wait_count[6]_i_3__0\
    );
\init_wait_count[6]_i_4__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFFFFFF"
    )
    port map (
      I0 => \init_wait_count_reg__0\(3),
      I1 => \init_wait_count_reg__0\(1),
      I2 => \init_wait_count_reg__0\(0),
      I3 => \init_wait_count_reg__0\(2),
      I4 => \init_wait_count_reg__0\(4),
      O => \n_0_init_wait_count[6]_i_4__0\
    );
\init_wait_count_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_init_wait_count[6]_i_1__0\,
      CLR => AR(0),
      D => \n_0_init_wait_count[0]_i_1__0\,
      Q => \init_wait_count_reg__0\(0)
    );
\init_wait_count_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_init_wait_count[6]_i_1__0\,
      CLR => AR(0),
      D => \p_0_in__1\(1),
      Q => \init_wait_count_reg__0\(1)
    );
\init_wait_count_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_init_wait_count[6]_i_1__0\,
      CLR => AR(0),
      D => \p_0_in__1\(2),
      Q => \init_wait_count_reg__0\(2)
    );
\init_wait_count_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_init_wait_count[6]_i_1__0\,
      CLR => AR(0),
      D => \p_0_in__1\(3),
      Q => \init_wait_count_reg__0\(3)
    );
\init_wait_count_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_init_wait_count[6]_i_1__0\,
      CLR => AR(0),
      D => \p_0_in__1\(4),
      Q => \init_wait_count_reg__0\(4)
    );
\init_wait_count_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_init_wait_count[6]_i_1__0\,
      CLR => AR(0),
      D => \p_0_in__1\(5),
      Q => \init_wait_count_reg__0\(5)
    );
\init_wait_count_reg[6]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_init_wait_count[6]_i_1__0\,
      CLR => AR(0),
      D => \p_0_in__1\(6),
      Q => \init_wait_count_reg__0\(6)
    );
\init_wait_done_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00008000"
    )
    port map (
      I0 => \n_0_init_wait_done_i_2__0\,
      I1 => \init_wait_count_reg__0\(2),
      I2 => \init_wait_count_reg__0\(6),
      I3 => \init_wait_count_reg__0\(5),
      I4 => \n_0_init_wait_count[6]_i_3__0\,
      I5 => n_0_init_wait_done_reg,
      O => \n_0_init_wait_done_i_1__0\
    );
\init_wait_done_i_2__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \init_wait_count_reg__0\(3),
      I1 => \init_wait_count_reg__0\(4),
      O => \n_0_init_wait_done_i_2__0\
    );
init_wait_done_reg: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      CLR => AR(0),
      D => \n_0_init_wait_done_i_1__0\,
      Q => n_0_init_wait_done_reg
    );
\mmcm_lock_count[0]_i_1__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \mmcm_lock_count_reg__0\(0),
      O => \p_0_in__2\(0)
    );
\mmcm_lock_count[1]_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \mmcm_lock_count_reg__0\(0),
      I1 => \mmcm_lock_count_reg__0\(1),
      O => \p_0_in__2\(1)
    );
\mmcm_lock_count[2]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
    port map (
      I0 => \mmcm_lock_count_reg__0\(1),
      I1 => \mmcm_lock_count_reg__0\(0),
      I2 => \mmcm_lock_count_reg__0\(2),
      O => \p_0_in__2\(2)
    );
\mmcm_lock_count[3]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
    port map (
      I0 => \mmcm_lock_count_reg__0\(2),
      I1 => \mmcm_lock_count_reg__0\(0),
      I2 => \mmcm_lock_count_reg__0\(1),
      I3 => \mmcm_lock_count_reg__0\(3),
      O => \p_0_in__2\(3)
    );
\mmcm_lock_count[4]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFF8000"
    )
    port map (
      I0 => \mmcm_lock_count_reg__0\(1),
      I1 => \mmcm_lock_count_reg__0\(0),
      I2 => \mmcm_lock_count_reg__0\(2),
      I3 => \mmcm_lock_count_reg__0\(3),
      I4 => \mmcm_lock_count_reg__0\(4),
      O => \p_0_in__2\(4)
    );
\mmcm_lock_count[5]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFF80000000"
    )
    port map (
      I0 => \mmcm_lock_count_reg__0\(4),
      I1 => \mmcm_lock_count_reg__0\(3),
      I2 => \mmcm_lock_count_reg__0\(2),
      I3 => \mmcm_lock_count_reg__0\(0),
      I4 => \mmcm_lock_count_reg__0\(1),
      I5 => \mmcm_lock_count_reg__0\(5),
      O => \p_0_in__2\(5)
    );
\mmcm_lock_count[6]_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => \n_0_mmcm_lock_count[9]_i_4__0\,
      I1 => \mmcm_lock_count_reg__0\(6),
      O => \p_0_in__2\(6)
    );
\mmcm_lock_count[7]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"D2"
    )
    port map (
      I0 => \mmcm_lock_count_reg__0\(6),
      I1 => \n_0_mmcm_lock_count[9]_i_4__0\,
      I2 => \mmcm_lock_count_reg__0\(7),
      O => \p_0_in__2\(7)
    );
\mmcm_lock_count[8]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DF20"
    )
    port map (
      I0 => \mmcm_lock_count_reg__0\(7),
      I1 => \n_0_mmcm_lock_count[9]_i_4__0\,
      I2 => \mmcm_lock_count_reg__0\(6),
      I3 => \mmcm_lock_count_reg__0\(8),
      O => \p_0_in__2\(8)
    );
\mmcm_lock_count[9]_i_2__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"DFFFFFFF"
    )
    port map (
      I0 => \mmcm_lock_count_reg__0\(7),
      I1 => \n_0_mmcm_lock_count[9]_i_4__0\,
      I2 => \mmcm_lock_count_reg__0\(6),
      I3 => \mmcm_lock_count_reg__0\(8),
      I4 => \mmcm_lock_count_reg__0\(9),
      O => \n_0_mmcm_lock_count[9]_i_2__0\
    );
\mmcm_lock_count[9]_i_3__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F7FF0800"
    )
    port map (
      I0 => \mmcm_lock_count_reg__0\(8),
      I1 => \mmcm_lock_count_reg__0\(6),
      I2 => \n_0_mmcm_lock_count[9]_i_4__0\,
      I3 => \mmcm_lock_count_reg__0\(7),
      I4 => \mmcm_lock_count_reg__0\(9),
      O => \p_0_in__2\(9)
    );
\mmcm_lock_count[9]_i_4__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFFFFFFFFFF"
    )
    port map (
      I0 => \mmcm_lock_count_reg__0\(4),
      I1 => \mmcm_lock_count_reg__0\(3),
      I2 => \mmcm_lock_count_reg__0\(2),
      I3 => \mmcm_lock_count_reg__0\(0),
      I4 => \mmcm_lock_count_reg__0\(1),
      I5 => \mmcm_lock_count_reg__0\(5),
      O => \n_0_mmcm_lock_count[9]_i_4__0\
    );
\mmcm_lock_count_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_mmcm_lock_count[9]_i_2__0\,
      D => \p_0_in__2\(0),
      Q => \mmcm_lock_count_reg__0\(0),
      R => n_1_sync_mmcm_lock_reclocked
    );
\mmcm_lock_count_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_mmcm_lock_count[9]_i_2__0\,
      D => \p_0_in__2\(1),
      Q => \mmcm_lock_count_reg__0\(1),
      R => n_1_sync_mmcm_lock_reclocked
    );
\mmcm_lock_count_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_mmcm_lock_count[9]_i_2__0\,
      D => \p_0_in__2\(2),
      Q => \mmcm_lock_count_reg__0\(2),
      R => n_1_sync_mmcm_lock_reclocked
    );
\mmcm_lock_count_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_mmcm_lock_count[9]_i_2__0\,
      D => \p_0_in__2\(3),
      Q => \mmcm_lock_count_reg__0\(3),
      R => n_1_sync_mmcm_lock_reclocked
    );
\mmcm_lock_count_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_mmcm_lock_count[9]_i_2__0\,
      D => \p_0_in__2\(4),
      Q => \mmcm_lock_count_reg__0\(4),
      R => n_1_sync_mmcm_lock_reclocked
    );
\mmcm_lock_count_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_mmcm_lock_count[9]_i_2__0\,
      D => \p_0_in__2\(5),
      Q => \mmcm_lock_count_reg__0\(5),
      R => n_1_sync_mmcm_lock_reclocked
    );
\mmcm_lock_count_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_mmcm_lock_count[9]_i_2__0\,
      D => \p_0_in__2\(6),
      Q => \mmcm_lock_count_reg__0\(6),
      R => n_1_sync_mmcm_lock_reclocked
    );
\mmcm_lock_count_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_mmcm_lock_count[9]_i_2__0\,
      D => \p_0_in__2\(7),
      Q => \mmcm_lock_count_reg__0\(7),
      R => n_1_sync_mmcm_lock_reclocked
    );
\mmcm_lock_count_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_mmcm_lock_count[9]_i_2__0\,
      D => \p_0_in__2\(8),
      Q => \mmcm_lock_count_reg__0\(8),
      R => n_1_sync_mmcm_lock_reclocked
    );
\mmcm_lock_count_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_mmcm_lock_count[9]_i_2__0\,
      D => \p_0_in__2\(9),
      Q => \mmcm_lock_count_reg__0\(9),
      R => n_1_sync_mmcm_lock_reclocked
    );
\mmcm_lock_reclocked_i_2__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00800000"
    )
    port map (
      I0 => \mmcm_lock_count_reg__0\(9),
      I1 => \mmcm_lock_count_reg__0\(8),
      I2 => \mmcm_lock_count_reg__0\(6),
      I3 => \n_0_mmcm_lock_count[9]_i_4__0\,
      I4 => \mmcm_lock_count_reg__0\(7),
      O => \n_0_mmcm_lock_reclocked_i_2__0\
    );
mmcm_lock_reclocked_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => n_0_sync_mmcm_lock_reclocked,
      Q => mmcm_lock_reclocked,
      R => '0'
    );
\reset_time_out_i_3__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => rx_state(2),
      I1 => rx_state(1),
      I2 => rxresetdone_s3,
      I3 => rx_state(3),
      O => \n_0_reset_time_out_i_3__0\
    );
\reset_time_out_i_4__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"000000E2"
    )
    port map (
      I0 => I5,
      I1 => rx_state(0),
      I2 => mmcm_lock_reclocked,
      I3 => rx_state(1),
      I4 => rx_state(3),
      O => \n_0_reset_time_out_i_4__0\
    );
reset_time_out_i_5: unisim.vcomponents.LUT5
    generic map(
      INIT => X"555F04AA"
    )
    port map (
      I0 => rx_state(3),
      I1 => I5,
      I2 => rx_state(1),
      I3 => rx_state(2),
      I4 => rx_state(0),
      O => n_0_reset_time_out_i_5
    );
reset_time_out_reg: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => n_0_sync_data_valid,
      Q => n_0_reset_time_out_reg,
      S => AR(0)
    );
\run_phase_alignment_int_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFD0004"
    )
    port map (
      I0 => rx_state(0),
      I1 => rx_state(3),
      I2 => rx_state(2),
      I3 => rx_state(1),
      I4 => n_0_run_phase_alignment_int_reg,
      O => \n_0_run_phase_alignment_int_i_1__0\
    );
run_phase_alignment_int_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => \n_0_run_phase_alignment_int_i_1__0\,
      Q => n_0_run_phase_alignment_int_reg,
      R => AR(0)
    );
run_phase_alignment_int_s3_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I2,
      CE => '1',
      D => data_out_0,
      Q => n_0_run_phase_alignment_int_s3_reg,
      R => '0'
    );
rx_fsm_reset_done_int_i_4: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => rx_state(3),
      I1 => rx_state(2),
      O => n_0_rx_fsm_reset_done_int_i_4
    );
rx_fsm_reset_done_int_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => n_1_sync_data_valid,
      Q => \^o1\,
      R => AR(0)
    );
rx_fsm_reset_done_int_s3_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I2,
      CE => '1',
      D => rx_fsm_reset_done_int_s2,
      Q => rx_fsm_reset_done_int_s3,
      R => '0'
    );
rxresetdone_s3_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => rxresetdone_s2,
      Q => rxresetdone_s3,
      R => '0'
    );
sync_RXRESETDONE: entity work.\gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_25\
    port map (
      I1 => I1,
      data_out => rxresetdone_s2,
      independent_clock_bufg => independent_clock_bufg
    );
sync_cplllock: entity work.\gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_26\
    port map (
      I1 => n_0_time_out_2ms_reg,
      I2 => \n_0_FSM_sequential_rx_state[3]_i_9\,
      I3 => \n_0_FSM_sequential_rx_state[3]_i_10\,
      I4 => I4,
      O1 => n_0_sync_cplllock,
      O2 => n_2_sync_cplllock,
      data_out => cplllock_sync,
      independent_clock_bufg => independent_clock_bufg,
      \out\(3 downto 0) => rx_state(3 downto 0),
      recclk_mon_count_reset => recclk_mon_count_reset
    );
sync_data_valid: entity work.\gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_27\
    port map (
      D(2) => n_3_sync_data_valid,
      D(1) => n_4_sync_data_valid,
      D(0) => n_5_sync_data_valid,
      E(0) => n_2_sync_data_valid,
      I1 => \n_0_reset_time_out_i_3__0\,
      I10 => I5,
      I11 => \n_0_FSM_sequential_rx_state[0]_i_2\,
      I12 => n_0_time_out_2ms_reg,
      I13 => \n_0_FSM_sequential_rx_state[3]_i_7\,
      I14 => n_0_time_out_1us_reg,
      I2 => \n_0_reset_time_out_i_4__0\,
      I3 => n_0_reset_time_out_i_5,
      I4 => n_0_reset_time_out_reg,
      I5 => n_0_rx_fsm_reset_done_int_i_4,
      I6 => \^o1\,
      I7 => n_0_time_out_100us_reg,
      I8 => n_2_sync_cplllock,
      I9 => \n_0_FSM_sequential_rx_state[3]_i_6\,
      O1 => n_0_sync_data_valid,
      O2 => n_1_sync_data_valid,
      cplllock_sync => cplllock_sync,
      data_out => data_out,
      independent_clock_bufg => independent_clock_bufg,
      \out\(3 downto 0) => rx_state(3 downto 0),
      rx_state16_out => rx_state16_out
    );
sync_mmcm_lock_reclocked: entity work.\gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_28\
    port map (
      I1 => \n_0_mmcm_lock_reclocked_i_2__0\,
      I3 => I3,
      O1 => n_0_sync_mmcm_lock_reclocked,
      SR(0) => n_1_sync_mmcm_lock_reclocked,
      independent_clock_bufg => independent_clock_bufg,
      mmcm_lock_reclocked => mmcm_lock_reclocked
    );
sync_run_phase_alignment_int: entity work.\gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_29\
    port map (
      I2 => I2,
      data_in => n_0_run_phase_alignment_int_reg,
      data_out => data_out_0
    );
sync_rx_fsm_reset_done_int: entity work.\gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_30\
    port map (
      I2 => I2,
      O1 => \^o1\,
      data_out => rx_fsm_reset_done_int_s2
    );
sync_time_out_wait_bypass: entity work.\gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_31\
    port map (
      data_in => n_0_time_out_wait_bypass_reg,
      data_out => time_out_wait_bypass_s2,
      independent_clock_bufg => independent_clock_bufg
    );
time_out_100us_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00010000"
    )
    port map (
      I0 => \n_0_time_out_counter[0]_i_4\,
      I1 => time_out_counter_reg(6),
      I2 => time_out_counter_reg(7),
      I3 => n_0_time_out_100us_i_2,
      I4 => n_0_time_out_100us_i_3,
      I5 => n_0_time_out_100us_reg,
      O => n_0_time_out_100us_i_1
    );
time_out_100us_i_2: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => time_out_counter_reg(18),
      I1 => time_out_counter_reg(19),
      O => n_0_time_out_100us_i_2
    );
time_out_100us_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000400000"
    )
    port map (
      I0 => time_out_counter_reg(8),
      I1 => time_out_counter_reg(14),
      I2 => time_out_counter_reg(11),
      I3 => time_out_counter_reg(13),
      I4 => time_out_counter_reg(5),
      I5 => n_0_time_out_1us_i_2,
      O => n_0_time_out_100us_i_3
    );
time_out_100us_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => n_0_time_out_100us_i_1,
      Q => n_0_time_out_100us_reg,
      R => n_0_reset_time_out_reg
    );
time_out_1us_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00010000"
    )
    port map (
      I0 => n_0_time_out_1us_i_2,
      I1 => \n_0_time_out_counter[0]_i_3__0\,
      I2 => n_0_time_out_100us_i_2,
      I3 => n_0_time_out_1us_i_3,
      I4 => n_0_time_out_1us_i_4,
      I5 => n_0_time_out_1us_reg,
      O => n_0_time_out_1us_i_1
    );
time_out_1us_i_2: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => time_out_counter_reg(16),
      I1 => time_out_counter_reg(17),
      O => n_0_time_out_1us_i_2
    );
time_out_1us_i_3: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
    port map (
      I0 => time_out_counter_reg(4),
      I1 => time_out_counter_reg(0),
      I2 => time_out_counter_reg(1),
      I3 => time_out_counter_reg(15),
      I4 => time_out_counter_reg(12),
      O => n_0_time_out_1us_i_3
    );
time_out_1us_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000010"
    )
    port map (
      I0 => time_out_counter_reg(8),
      I1 => time_out_counter_reg(13),
      I2 => time_out_counter_reg(3),
      I3 => time_out_counter_reg(10),
      I4 => time_out_counter_reg(9),
      I5 => time_out_counter_reg(2),
      O => n_0_time_out_1us_i_4
    );
time_out_1us_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => n_0_time_out_1us_i_1,
      Q => n_0_time_out_1us_reg,
      R => n_0_reset_time_out_reg
    );
time_out_2ms_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FF04"
    )
    port map (
      I0 => \n_0_time_out_counter[0]_i_4\,
      I1 => \n_0_time_out_2ms_i_2__0\,
      I2 => \n_0_time_out_counter[0]_i_3__0\,
      I3 => n_0_time_out_2ms_reg,
      O => n_0_time_out_2ms_i_1
    );
\time_out_2ms_i_2__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000200000000000"
    )
    port map (
      I0 => time_out_counter_reg(16),
      I1 => time_out_counter_reg(17),
      I2 => time_out_counter_reg(8),
      I3 => time_out_counter_reg(13),
      I4 => time_out_counter_reg(18),
      I5 => time_out_counter_reg(19),
      O => \n_0_time_out_2ms_i_2__0\
    );
time_out_2ms_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => n_0_time_out_2ms_i_1,
      Q => n_0_time_out_2ms_reg,
      R => n_0_reset_time_out_reg
    );
\time_out_counter[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFDFF"
    )
    port map (
      I0 => time_out_counter_reg(8),
      I1 => \n_0_time_out_counter[0]_i_3__0\,
      I2 => \n_0_time_out_counter[0]_i_4\,
      I3 => time_out_counter_reg(13),
      I4 => \n_0_time_out_counter[0]_i_5__0\,
      O => \n_0_time_out_counter[0]_i_1\
    );
\time_out_counter[0]_i_3__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FEFFFFFF"
    )
    port map (
      I0 => time_out_counter_reg(5),
      I1 => time_out_counter_reg(11),
      I2 => time_out_counter_reg(14),
      I3 => time_out_counter_reg(7),
      I4 => time_out_counter_reg(6),
      O => \n_0_time_out_counter[0]_i_3__0\
    );
\time_out_counter[0]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFEFFF"
    )
    port map (
      I0 => time_out_counter_reg(2),
      I1 => time_out_counter_reg(3),
      I2 => time_out_counter_reg(9),
      I3 => time_out_counter_reg(10),
      I4 => n_0_time_out_1us_i_3,
      O => \n_0_time_out_counter[0]_i_4\
    );
\time_out_counter[0]_i_5__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FBFF"
    )
    port map (
      I0 => time_out_counter_reg(17),
      I1 => time_out_counter_reg(16),
      I2 => time_out_counter_reg(18),
      I3 => time_out_counter_reg(19),
      O => \n_0_time_out_counter[0]_i_5__0\
    );
\time_out_counter[0]_i_6__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => time_out_counter_reg(3),
      O => \n_0_time_out_counter[0]_i_6__0\
    );
\time_out_counter[0]_i_7__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => time_out_counter_reg(2),
      O => \n_0_time_out_counter[0]_i_7__0\
    );
\time_out_counter[0]_i_8__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => time_out_counter_reg(1),
      O => \n_0_time_out_counter[0]_i_8__0\
    );
\time_out_counter[0]_i_9__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => time_out_counter_reg(0),
      O => \n_0_time_out_counter[0]_i_9__0\
    );
\time_out_counter[12]_i_2__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => time_out_counter_reg(15),
      O => \n_0_time_out_counter[12]_i_2__0\
    );
\time_out_counter[12]_i_3__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => time_out_counter_reg(14),
      O => \n_0_time_out_counter[12]_i_3__0\
    );
\time_out_counter[12]_i_4__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => time_out_counter_reg(13),
      O => \n_0_time_out_counter[12]_i_4__0\
    );
\time_out_counter[12]_i_5__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => time_out_counter_reg(12),
      O => \n_0_time_out_counter[12]_i_5__0\
    );
\time_out_counter[16]_i_2__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => time_out_counter_reg(19),
      O => \n_0_time_out_counter[16]_i_2__0\
    );
\time_out_counter[16]_i_3__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => time_out_counter_reg(18),
      O => \n_0_time_out_counter[16]_i_3__0\
    );
\time_out_counter[16]_i_4__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => time_out_counter_reg(17),
      O => \n_0_time_out_counter[16]_i_4__0\
    );
\time_out_counter[16]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => time_out_counter_reg(16),
      O => \n_0_time_out_counter[16]_i_5\
    );
\time_out_counter[4]_i_2__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => time_out_counter_reg(7),
      O => \n_0_time_out_counter[4]_i_2__0\
    );
\time_out_counter[4]_i_3__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => time_out_counter_reg(6),
      O => \n_0_time_out_counter[4]_i_3__0\
    );
\time_out_counter[4]_i_4__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => time_out_counter_reg(5),
      O => \n_0_time_out_counter[4]_i_4__0\
    );
\time_out_counter[4]_i_5__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => time_out_counter_reg(4),
      O => \n_0_time_out_counter[4]_i_5__0\
    );
\time_out_counter[8]_i_2__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => time_out_counter_reg(11),
      O => \n_0_time_out_counter[8]_i_2__0\
    );
\time_out_counter[8]_i_3__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => time_out_counter_reg(10),
      O => \n_0_time_out_counter[8]_i_3__0\
    );
\time_out_counter[8]_i_4__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => time_out_counter_reg(9),
      O => \n_0_time_out_counter[8]_i_4__0\
    );
\time_out_counter[8]_i_5__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => time_out_counter_reg(8),
      O => \n_0_time_out_counter[8]_i_5__0\
    );
\time_out_counter_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_time_out_counter[0]_i_1\,
      D => \n_7_time_out_counter_reg[0]_i_2__0\,
      Q => time_out_counter_reg(0),
      R => n_0_reset_time_out_reg
    );
\time_out_counter_reg[0]_i_2__0\: unisim.vcomponents.CARRY4
    port map (
      CI => '0',
      CO(3) => \n_0_time_out_counter_reg[0]_i_2__0\,
      CO(2) => \n_1_time_out_counter_reg[0]_i_2__0\,
      CO(1) => \n_2_time_out_counter_reg[0]_i_2__0\,
      CO(0) => \n_3_time_out_counter_reg[0]_i_2__0\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '1',
      O(3) => \n_4_time_out_counter_reg[0]_i_2__0\,
      O(2) => \n_5_time_out_counter_reg[0]_i_2__0\,
      O(1) => \n_6_time_out_counter_reg[0]_i_2__0\,
      O(0) => \n_7_time_out_counter_reg[0]_i_2__0\,
      S(3) => \n_0_time_out_counter[0]_i_6__0\,
      S(2) => \n_0_time_out_counter[0]_i_7__0\,
      S(1) => \n_0_time_out_counter[0]_i_8__0\,
      S(0) => \n_0_time_out_counter[0]_i_9__0\
    );
\time_out_counter_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_time_out_counter[0]_i_1\,
      D => \n_5_time_out_counter_reg[8]_i_1__0\,
      Q => time_out_counter_reg(10),
      R => n_0_reset_time_out_reg
    );
\time_out_counter_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_time_out_counter[0]_i_1\,
      D => \n_4_time_out_counter_reg[8]_i_1__0\,
      Q => time_out_counter_reg(11),
      R => n_0_reset_time_out_reg
    );
\time_out_counter_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_time_out_counter[0]_i_1\,
      D => \n_7_time_out_counter_reg[12]_i_1__0\,
      Q => time_out_counter_reg(12),
      R => n_0_reset_time_out_reg
    );
\time_out_counter_reg[12]_i_1__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_time_out_counter_reg[8]_i_1__0\,
      CO(3) => \n_0_time_out_counter_reg[12]_i_1__0\,
      CO(2) => \n_1_time_out_counter_reg[12]_i_1__0\,
      CO(1) => \n_2_time_out_counter_reg[12]_i_1__0\,
      CO(0) => \n_3_time_out_counter_reg[12]_i_1__0\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '0',
      O(3) => \n_4_time_out_counter_reg[12]_i_1__0\,
      O(2) => \n_5_time_out_counter_reg[12]_i_1__0\,
      O(1) => \n_6_time_out_counter_reg[12]_i_1__0\,
      O(0) => \n_7_time_out_counter_reg[12]_i_1__0\,
      S(3) => \n_0_time_out_counter[12]_i_2__0\,
      S(2) => \n_0_time_out_counter[12]_i_3__0\,
      S(1) => \n_0_time_out_counter[12]_i_4__0\,
      S(0) => \n_0_time_out_counter[12]_i_5__0\
    );
\time_out_counter_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_time_out_counter[0]_i_1\,
      D => \n_6_time_out_counter_reg[12]_i_1__0\,
      Q => time_out_counter_reg(13),
      R => n_0_reset_time_out_reg
    );
\time_out_counter_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_time_out_counter[0]_i_1\,
      D => \n_5_time_out_counter_reg[12]_i_1__0\,
      Q => time_out_counter_reg(14),
      R => n_0_reset_time_out_reg
    );
\time_out_counter_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_time_out_counter[0]_i_1\,
      D => \n_4_time_out_counter_reg[12]_i_1__0\,
      Q => time_out_counter_reg(15),
      R => n_0_reset_time_out_reg
    );
\time_out_counter_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_time_out_counter[0]_i_1\,
      D => \n_7_time_out_counter_reg[16]_i_1__0\,
      Q => time_out_counter_reg(16),
      R => n_0_reset_time_out_reg
    );
\time_out_counter_reg[16]_i_1__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_time_out_counter_reg[12]_i_1__0\,
      CO(3) => \NLW_time_out_counter_reg[16]_i_1__0_CO_UNCONNECTED\(3),
      CO(2) => \n_1_time_out_counter_reg[16]_i_1__0\,
      CO(1) => \n_2_time_out_counter_reg[16]_i_1__0\,
      CO(0) => \n_3_time_out_counter_reg[16]_i_1__0\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '0',
      O(3) => \n_4_time_out_counter_reg[16]_i_1__0\,
      O(2) => \n_5_time_out_counter_reg[16]_i_1__0\,
      O(1) => \n_6_time_out_counter_reg[16]_i_1__0\,
      O(0) => \n_7_time_out_counter_reg[16]_i_1__0\,
      S(3) => \n_0_time_out_counter[16]_i_2__0\,
      S(2) => \n_0_time_out_counter[16]_i_3__0\,
      S(1) => \n_0_time_out_counter[16]_i_4__0\,
      S(0) => \n_0_time_out_counter[16]_i_5\
    );
\time_out_counter_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_time_out_counter[0]_i_1\,
      D => \n_6_time_out_counter_reg[16]_i_1__0\,
      Q => time_out_counter_reg(17),
      R => n_0_reset_time_out_reg
    );
\time_out_counter_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_time_out_counter[0]_i_1\,
      D => \n_5_time_out_counter_reg[16]_i_1__0\,
      Q => time_out_counter_reg(18),
      R => n_0_reset_time_out_reg
    );
\time_out_counter_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_time_out_counter[0]_i_1\,
      D => \n_4_time_out_counter_reg[16]_i_1__0\,
      Q => time_out_counter_reg(19),
      R => n_0_reset_time_out_reg
    );
\time_out_counter_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_time_out_counter[0]_i_1\,
      D => \n_6_time_out_counter_reg[0]_i_2__0\,
      Q => time_out_counter_reg(1),
      R => n_0_reset_time_out_reg
    );
\time_out_counter_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_time_out_counter[0]_i_1\,
      D => \n_5_time_out_counter_reg[0]_i_2__0\,
      Q => time_out_counter_reg(2),
      R => n_0_reset_time_out_reg
    );
\time_out_counter_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_time_out_counter[0]_i_1\,
      D => \n_4_time_out_counter_reg[0]_i_2__0\,
      Q => time_out_counter_reg(3),
      R => n_0_reset_time_out_reg
    );
\time_out_counter_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_time_out_counter[0]_i_1\,
      D => \n_7_time_out_counter_reg[4]_i_1__0\,
      Q => time_out_counter_reg(4),
      R => n_0_reset_time_out_reg
    );
\time_out_counter_reg[4]_i_1__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_time_out_counter_reg[0]_i_2__0\,
      CO(3) => \n_0_time_out_counter_reg[4]_i_1__0\,
      CO(2) => \n_1_time_out_counter_reg[4]_i_1__0\,
      CO(1) => \n_2_time_out_counter_reg[4]_i_1__0\,
      CO(0) => \n_3_time_out_counter_reg[4]_i_1__0\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '0',
      O(3) => \n_4_time_out_counter_reg[4]_i_1__0\,
      O(2) => \n_5_time_out_counter_reg[4]_i_1__0\,
      O(1) => \n_6_time_out_counter_reg[4]_i_1__0\,
      O(0) => \n_7_time_out_counter_reg[4]_i_1__0\,
      S(3) => \n_0_time_out_counter[4]_i_2__0\,
      S(2) => \n_0_time_out_counter[4]_i_3__0\,
      S(1) => \n_0_time_out_counter[4]_i_4__0\,
      S(0) => \n_0_time_out_counter[4]_i_5__0\
    );
\time_out_counter_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_time_out_counter[0]_i_1\,
      D => \n_6_time_out_counter_reg[4]_i_1__0\,
      Q => time_out_counter_reg(5),
      R => n_0_reset_time_out_reg
    );
\time_out_counter_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_time_out_counter[0]_i_1\,
      D => \n_5_time_out_counter_reg[4]_i_1__0\,
      Q => time_out_counter_reg(6),
      R => n_0_reset_time_out_reg
    );
\time_out_counter_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_time_out_counter[0]_i_1\,
      D => \n_4_time_out_counter_reg[4]_i_1__0\,
      Q => time_out_counter_reg(7),
      R => n_0_reset_time_out_reg
    );
\time_out_counter_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_time_out_counter[0]_i_1\,
      D => \n_7_time_out_counter_reg[8]_i_1__0\,
      Q => time_out_counter_reg(8),
      R => n_0_reset_time_out_reg
    );
\time_out_counter_reg[8]_i_1__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_time_out_counter_reg[4]_i_1__0\,
      CO(3) => \n_0_time_out_counter_reg[8]_i_1__0\,
      CO(2) => \n_1_time_out_counter_reg[8]_i_1__0\,
      CO(1) => \n_2_time_out_counter_reg[8]_i_1__0\,
      CO(0) => \n_3_time_out_counter_reg[8]_i_1__0\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '0',
      O(3) => \n_4_time_out_counter_reg[8]_i_1__0\,
      O(2) => \n_5_time_out_counter_reg[8]_i_1__0\,
      O(1) => \n_6_time_out_counter_reg[8]_i_1__0\,
      O(0) => \n_7_time_out_counter_reg[8]_i_1__0\,
      S(3) => \n_0_time_out_counter[8]_i_2__0\,
      S(2) => \n_0_time_out_counter[8]_i_3__0\,
      S(1) => \n_0_time_out_counter[8]_i_4__0\,
      S(0) => \n_0_time_out_counter[8]_i_5__0\
    );
\time_out_counter_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_time_out_counter[0]_i_1\,
      D => \n_6_time_out_counter_reg[8]_i_1__0\,
      Q => time_out_counter_reg(9),
      R => n_0_reset_time_out_reg
    );
\time_out_wait_bypass_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF00FF0100000000"
    )
    port map (
      I0 => \n_0_wait_bypass_count[0]_i_4__0\,
      I1 => wait_bypass_count_reg(10),
      I2 => \n_0_wait_bypass_count[0]_i_5__0\,
      I3 => n_0_time_out_wait_bypass_reg,
      I4 => rx_fsm_reset_done_int_s3,
      I5 => n_0_run_phase_alignment_int_s3_reg,
      O => \n_0_time_out_wait_bypass_i_1__0\
    );
time_out_wait_bypass_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I2,
      CE => '1',
      D => \n_0_time_out_wait_bypass_i_1__0\,
      Q => n_0_time_out_wait_bypass_reg,
      R => '0'
    );
time_out_wait_bypass_s3_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => time_out_wait_bypass_s2,
      Q => time_out_wait_bypass_s3,
      R => '0'
    );
time_tlock_max_i_10: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => time_out_counter_reg(8),
      I1 => time_out_counter_reg(9),
      O => n_0_time_tlock_max_i_10
    );
time_tlock_max_i_11: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => time_out_counter_reg(14),
      I1 => time_out_counter_reg(15),
      O => n_0_time_tlock_max_i_11
    );
time_tlock_max_i_12: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => time_out_counter_reg(12),
      I1 => time_out_counter_reg(13),
      O => n_0_time_tlock_max_i_12
    );
time_tlock_max_i_13: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => time_out_counter_reg(10),
      I1 => time_out_counter_reg(11),
      O => n_0_time_tlock_max_i_13
    );
time_tlock_max_i_14: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => time_out_counter_reg(9),
      I1 => time_out_counter_reg(8),
      O => n_0_time_tlock_max_i_14
    );
time_tlock_max_i_15: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => time_out_counter_reg(6),
      I1 => time_out_counter_reg(7),
      O => n_0_time_tlock_max_i_15
    );
time_tlock_max_i_16: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => time_out_counter_reg(4),
      I1 => time_out_counter_reg(5),
      O => n_0_time_tlock_max_i_16
    );
time_tlock_max_i_17: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => time_out_counter_reg(2),
      I1 => time_out_counter_reg(3),
      O => n_0_time_tlock_max_i_17
    );
time_tlock_max_i_18: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => time_out_counter_reg(0),
      I1 => time_out_counter_reg(1),
      O => n_0_time_tlock_max_i_18
    );
time_tlock_max_i_19: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => time_out_counter_reg(7),
      I1 => time_out_counter_reg(6),
      O => n_0_time_tlock_max_i_19
    );
\time_tlock_max_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F8"
    )
    port map (
      I0 => n_0_check_tlock_max_reg,
      I1 => time_tlock_max1,
      I2 => time_tlock_max,
      O => \n_0_time_tlock_max_i_1__0\
    );
time_tlock_max_i_20: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => time_out_counter_reg(5),
      I1 => time_out_counter_reg(4),
      O => n_0_time_tlock_max_i_20
    );
time_tlock_max_i_21: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => time_out_counter_reg(3),
      I1 => time_out_counter_reg(2),
      O => n_0_time_tlock_max_i_21
    );
time_tlock_max_i_22: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => time_out_counter_reg(1),
      I1 => time_out_counter_reg(0),
      O => n_0_time_tlock_max_i_22
    );
time_tlock_max_i_4: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => time_out_counter_reg(18),
      I1 => time_out_counter_reg(19),
      O => n_0_time_tlock_max_i_4
    );
time_tlock_max_i_5: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => time_out_counter_reg(16),
      I1 => time_out_counter_reg(17),
      O => n_0_time_tlock_max_i_5
    );
time_tlock_max_i_6: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => time_out_counter_reg(19),
      I1 => time_out_counter_reg(18),
      O => n_0_time_tlock_max_i_6
    );
time_tlock_max_i_7: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => time_out_counter_reg(17),
      I1 => time_out_counter_reg(16),
      O => n_0_time_tlock_max_i_7
    );
time_tlock_max_i_9: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => time_out_counter_reg(12),
      I1 => time_out_counter_reg(13),
      O => n_0_time_tlock_max_i_9
    );
time_tlock_max_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => \n_0_time_tlock_max_i_1__0\,
      Q => time_tlock_max,
      R => n_0_reset_time_out_reg
    );
time_tlock_max_reg_i_2: unisim.vcomponents.CARRY4
    port map (
      CI => n_0_time_tlock_max_reg_i_3,
      CO(3 downto 2) => NLW_time_tlock_max_reg_i_2_CO_UNCONNECTED(3 downto 2),
      CO(1) => time_tlock_max1,
      CO(0) => n_3_time_tlock_max_reg_i_2,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => n_0_time_tlock_max_i_4,
      DI(0) => n_0_time_tlock_max_i_5,
      O(3 downto 0) => NLW_time_tlock_max_reg_i_2_O_UNCONNECTED(3 downto 0),
      S(3) => '0',
      S(2) => '0',
      S(1) => n_0_time_tlock_max_i_6,
      S(0) => n_0_time_tlock_max_i_7
    );
time_tlock_max_reg_i_3: unisim.vcomponents.CARRY4
    port map (
      CI => n_0_time_tlock_max_reg_i_8,
      CO(3) => n_0_time_tlock_max_reg_i_3,
      CO(2) => n_1_time_tlock_max_reg_i_3,
      CO(1) => n_2_time_tlock_max_reg_i_3,
      CO(0) => n_3_time_tlock_max_reg_i_3,
      CYINIT => '0',
      DI(3) => time_out_counter_reg(15),
      DI(2) => n_0_time_tlock_max_i_9,
      DI(1) => '0',
      DI(0) => n_0_time_tlock_max_i_10,
      O(3 downto 0) => NLW_time_tlock_max_reg_i_3_O_UNCONNECTED(3 downto 0),
      S(3) => n_0_time_tlock_max_i_11,
      S(2) => n_0_time_tlock_max_i_12,
      S(1) => n_0_time_tlock_max_i_13,
      S(0) => n_0_time_tlock_max_i_14
    );
time_tlock_max_reg_i_8: unisim.vcomponents.CARRY4
    port map (
      CI => '0',
      CO(3) => n_0_time_tlock_max_reg_i_8,
      CO(2) => n_1_time_tlock_max_reg_i_8,
      CO(1) => n_2_time_tlock_max_reg_i_8,
      CO(0) => n_3_time_tlock_max_reg_i_8,
      CYINIT => '0',
      DI(3) => n_0_time_tlock_max_i_15,
      DI(2) => n_0_time_tlock_max_i_16,
      DI(1) => n_0_time_tlock_max_i_17,
      DI(0) => n_0_time_tlock_max_i_18,
      O(3 downto 0) => NLW_time_tlock_max_reg_i_8_O_UNCONNECTED(3 downto 0),
      S(3) => n_0_time_tlock_max_i_19,
      S(2) => n_0_time_tlock_max_i_20,
      S(1) => n_0_time_tlock_max_i_21,
      S(0) => n_0_time_tlock_max_i_22
    );
\wait_bypass_count[0]_i_1__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => n_0_run_phase_alignment_int_s3_reg,
      O => \n_0_wait_bypass_count[0]_i_1__0\
    );
\wait_bypass_count[0]_i_2__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00FE"
    )
    port map (
      I0 => \n_0_wait_bypass_count[0]_i_4__0\,
      I1 => wait_bypass_count_reg(10),
      I2 => \n_0_wait_bypass_count[0]_i_5__0\,
      I3 => rx_fsm_reset_done_int_s3,
      O => \n_0_wait_bypass_count[0]_i_2__0\
    );
\wait_bypass_count[0]_i_4__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FEFFFFFFFFFFFFFF"
    )
    port map (
      I0 => wait_bypass_count_reg(5),
      I1 => wait_bypass_count_reg(3),
      I2 => wait_bypass_count_reg(6),
      I3 => wait_bypass_count_reg(0),
      I4 => wait_bypass_count_reg(8),
      I5 => wait_bypass_count_reg(7),
      O => \n_0_wait_bypass_count[0]_i_4__0\
    );
\wait_bypass_count[0]_i_5__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFF7FFF"
    )
    port map (
      I0 => wait_bypass_count_reg(1),
      I1 => wait_bypass_count_reg(12),
      I2 => wait_bypass_count_reg(9),
      I3 => wait_bypass_count_reg(2),
      I4 => wait_bypass_count_reg(4),
      I5 => wait_bypass_count_reg(11),
      O => \n_0_wait_bypass_count[0]_i_5__0\
    );
\wait_bypass_count[0]_i_6__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => wait_bypass_count_reg(3),
      O => \n_0_wait_bypass_count[0]_i_6__0\
    );
\wait_bypass_count[0]_i_7__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => wait_bypass_count_reg(2),
      O => \n_0_wait_bypass_count[0]_i_7__0\
    );
\wait_bypass_count[0]_i_8__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => wait_bypass_count_reg(1),
      O => \n_0_wait_bypass_count[0]_i_8__0\
    );
\wait_bypass_count[0]_i_9\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => wait_bypass_count_reg(0),
      O => \n_0_wait_bypass_count[0]_i_9\
    );
\wait_bypass_count[12]_i_2__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => wait_bypass_count_reg(12),
      O => \n_0_wait_bypass_count[12]_i_2__0\
    );
\wait_bypass_count[4]_i_2__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => wait_bypass_count_reg(7),
      O => \n_0_wait_bypass_count[4]_i_2__0\
    );
\wait_bypass_count[4]_i_3__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => wait_bypass_count_reg(6),
      O => \n_0_wait_bypass_count[4]_i_3__0\
    );
\wait_bypass_count[4]_i_4__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => wait_bypass_count_reg(5),
      O => \n_0_wait_bypass_count[4]_i_4__0\
    );
\wait_bypass_count[4]_i_5__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => wait_bypass_count_reg(4),
      O => \n_0_wait_bypass_count[4]_i_5__0\
    );
\wait_bypass_count[8]_i_2__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => wait_bypass_count_reg(11),
      O => \n_0_wait_bypass_count[8]_i_2__0\
    );
\wait_bypass_count[8]_i_3__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => wait_bypass_count_reg(10),
      O => \n_0_wait_bypass_count[8]_i_3__0\
    );
\wait_bypass_count[8]_i_4__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => wait_bypass_count_reg(9),
      O => \n_0_wait_bypass_count[8]_i_4__0\
    );
\wait_bypass_count[8]_i_5__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => wait_bypass_count_reg(8),
      O => \n_0_wait_bypass_count[8]_i_5__0\
    );
\wait_bypass_count_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => \n_0_wait_bypass_count[0]_i_2__0\,
      D => \n_7_wait_bypass_count_reg[0]_i_3__0\,
      Q => wait_bypass_count_reg(0),
      R => \n_0_wait_bypass_count[0]_i_1__0\
    );
\wait_bypass_count_reg[0]_i_3__0\: unisim.vcomponents.CARRY4
    port map (
      CI => '0',
      CO(3) => \n_0_wait_bypass_count_reg[0]_i_3__0\,
      CO(2) => \n_1_wait_bypass_count_reg[0]_i_3__0\,
      CO(1) => \n_2_wait_bypass_count_reg[0]_i_3__0\,
      CO(0) => \n_3_wait_bypass_count_reg[0]_i_3__0\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '1',
      O(3) => \n_4_wait_bypass_count_reg[0]_i_3__0\,
      O(2) => \n_5_wait_bypass_count_reg[0]_i_3__0\,
      O(1) => \n_6_wait_bypass_count_reg[0]_i_3__0\,
      O(0) => \n_7_wait_bypass_count_reg[0]_i_3__0\,
      S(3) => \n_0_wait_bypass_count[0]_i_6__0\,
      S(2) => \n_0_wait_bypass_count[0]_i_7__0\,
      S(1) => \n_0_wait_bypass_count[0]_i_8__0\,
      S(0) => \n_0_wait_bypass_count[0]_i_9\
    );
\wait_bypass_count_reg[10]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => \n_0_wait_bypass_count[0]_i_2__0\,
      D => \n_5_wait_bypass_count_reg[8]_i_1__0\,
      Q => wait_bypass_count_reg(10),
      R => \n_0_wait_bypass_count[0]_i_1__0\
    );
\wait_bypass_count_reg[11]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => \n_0_wait_bypass_count[0]_i_2__0\,
      D => \n_4_wait_bypass_count_reg[8]_i_1__0\,
      Q => wait_bypass_count_reg(11),
      R => \n_0_wait_bypass_count[0]_i_1__0\
    );
\wait_bypass_count_reg[12]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => \n_0_wait_bypass_count[0]_i_2__0\,
      D => \n_7_wait_bypass_count_reg[12]_i_1__0\,
      Q => wait_bypass_count_reg(12),
      R => \n_0_wait_bypass_count[0]_i_1__0\
    );
\wait_bypass_count_reg[12]_i_1__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_wait_bypass_count_reg[8]_i_1__0\,
      CO(3 downto 0) => \NLW_wait_bypass_count_reg[12]_i_1__0_CO_UNCONNECTED\(3 downto 0),
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '0',
      O(3 downto 1) => \NLW_wait_bypass_count_reg[12]_i_1__0_O_UNCONNECTED\(3 downto 1),
      O(0) => \n_7_wait_bypass_count_reg[12]_i_1__0\,
      S(3) => '0',
      S(2) => '0',
      S(1) => '0',
      S(0) => \n_0_wait_bypass_count[12]_i_2__0\
    );
\wait_bypass_count_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => \n_0_wait_bypass_count[0]_i_2__0\,
      D => \n_6_wait_bypass_count_reg[0]_i_3__0\,
      Q => wait_bypass_count_reg(1),
      R => \n_0_wait_bypass_count[0]_i_1__0\
    );
\wait_bypass_count_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => \n_0_wait_bypass_count[0]_i_2__0\,
      D => \n_5_wait_bypass_count_reg[0]_i_3__0\,
      Q => wait_bypass_count_reg(2),
      R => \n_0_wait_bypass_count[0]_i_1__0\
    );
\wait_bypass_count_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => \n_0_wait_bypass_count[0]_i_2__0\,
      D => \n_4_wait_bypass_count_reg[0]_i_3__0\,
      Q => wait_bypass_count_reg(3),
      R => \n_0_wait_bypass_count[0]_i_1__0\
    );
\wait_bypass_count_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => \n_0_wait_bypass_count[0]_i_2__0\,
      D => \n_7_wait_bypass_count_reg[4]_i_1__0\,
      Q => wait_bypass_count_reg(4),
      R => \n_0_wait_bypass_count[0]_i_1__0\
    );
\wait_bypass_count_reg[4]_i_1__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_wait_bypass_count_reg[0]_i_3__0\,
      CO(3) => \n_0_wait_bypass_count_reg[4]_i_1__0\,
      CO(2) => \n_1_wait_bypass_count_reg[4]_i_1__0\,
      CO(1) => \n_2_wait_bypass_count_reg[4]_i_1__0\,
      CO(0) => \n_3_wait_bypass_count_reg[4]_i_1__0\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '0',
      O(3) => \n_4_wait_bypass_count_reg[4]_i_1__0\,
      O(2) => \n_5_wait_bypass_count_reg[4]_i_1__0\,
      O(1) => \n_6_wait_bypass_count_reg[4]_i_1__0\,
      O(0) => \n_7_wait_bypass_count_reg[4]_i_1__0\,
      S(3) => \n_0_wait_bypass_count[4]_i_2__0\,
      S(2) => \n_0_wait_bypass_count[4]_i_3__0\,
      S(1) => \n_0_wait_bypass_count[4]_i_4__0\,
      S(0) => \n_0_wait_bypass_count[4]_i_5__0\
    );
\wait_bypass_count_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => \n_0_wait_bypass_count[0]_i_2__0\,
      D => \n_6_wait_bypass_count_reg[4]_i_1__0\,
      Q => wait_bypass_count_reg(5),
      R => \n_0_wait_bypass_count[0]_i_1__0\
    );
\wait_bypass_count_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => \n_0_wait_bypass_count[0]_i_2__0\,
      D => \n_5_wait_bypass_count_reg[4]_i_1__0\,
      Q => wait_bypass_count_reg(6),
      R => \n_0_wait_bypass_count[0]_i_1__0\
    );
\wait_bypass_count_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => \n_0_wait_bypass_count[0]_i_2__0\,
      D => \n_4_wait_bypass_count_reg[4]_i_1__0\,
      Q => wait_bypass_count_reg(7),
      R => \n_0_wait_bypass_count[0]_i_1__0\
    );
\wait_bypass_count_reg[8]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => \n_0_wait_bypass_count[0]_i_2__0\,
      D => \n_7_wait_bypass_count_reg[8]_i_1__0\,
      Q => wait_bypass_count_reg(8),
      R => \n_0_wait_bypass_count[0]_i_1__0\
    );
\wait_bypass_count_reg[8]_i_1__0\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_wait_bypass_count_reg[4]_i_1__0\,
      CO(3) => \n_0_wait_bypass_count_reg[8]_i_1__0\,
      CO(2) => \n_1_wait_bypass_count_reg[8]_i_1__0\,
      CO(1) => \n_2_wait_bypass_count_reg[8]_i_1__0\,
      CO(0) => \n_3_wait_bypass_count_reg[8]_i_1__0\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '0',
      O(3) => \n_4_wait_bypass_count_reg[8]_i_1__0\,
      O(2) => \n_5_wait_bypass_count_reg[8]_i_1__0\,
      O(1) => \n_6_wait_bypass_count_reg[8]_i_1__0\,
      O(0) => \n_7_wait_bypass_count_reg[8]_i_1__0\,
      S(3) => \n_0_wait_bypass_count[8]_i_2__0\,
      S(2) => \n_0_wait_bypass_count[8]_i_3__0\,
      S(1) => \n_0_wait_bypass_count[8]_i_4__0\,
      S(0) => \n_0_wait_bypass_count[8]_i_5__0\
    );
\wait_bypass_count_reg[9]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => \n_0_wait_bypass_count[0]_i_2__0\,
      D => \n_6_wait_bypass_count_reg[8]_i_1__0\,
      Q => wait_bypass_count_reg(9),
      R => \n_0_wait_bypass_count[0]_i_1__0\
    );
\wait_time_cnt[0]_i_1__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \wait_time_cnt_reg__0\(0),
      O => \wait_time_cnt0__0\(0)
    );
\wait_time_cnt[1]_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => \wait_time_cnt_reg__0\(1),
      I1 => \wait_time_cnt_reg__0\(0),
      O => \wait_time_cnt0__0\(1)
    );
\wait_time_cnt[2]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"A9"
    )
    port map (
      I0 => \wait_time_cnt_reg__0\(2),
      I1 => \wait_time_cnt_reg__0\(0),
      I2 => \wait_time_cnt_reg__0\(1),
      O => \wait_time_cnt0__0\(2)
    );
\wait_time_cnt[3]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE01"
    )
    port map (
      I0 => \wait_time_cnt_reg__0\(1),
      I1 => \wait_time_cnt_reg__0\(0),
      I2 => \wait_time_cnt_reg__0\(2),
      I3 => \wait_time_cnt_reg__0\(3),
      O => \wait_time_cnt0__0\(3)
    );
\wait_time_cnt[4]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAAAAAA9"
    )
    port map (
      I0 => \wait_time_cnt_reg__0\(4),
      I1 => \wait_time_cnt_reg__0\(3),
      I2 => \wait_time_cnt_reg__0\(2),
      I3 => \wait_time_cnt_reg__0\(0),
      I4 => \wait_time_cnt_reg__0\(1),
      O => \wait_time_cnt0__0\(4)
    );
\wait_time_cnt[5]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0F0F0F0F0F0F0E1"
    )
    port map (
      I0 => \wait_time_cnt_reg__0\(3),
      I1 => \wait_time_cnt_reg__0\(2),
      I2 => \wait_time_cnt_reg__0\(5),
      I3 => \wait_time_cnt_reg__0\(4),
      I4 => \wait_time_cnt_reg__0\(1),
      I5 => \wait_time_cnt_reg__0\(0),
      O => \wait_time_cnt0__0\(5)
    );
\wait_time_cnt[6]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
    port map (
      I0 => rx_state(1),
      I1 => rx_state(0),
      I2 => rx_state(3),
      O => \n_0_wait_time_cnt[6]_i_1__0\
    );
\wait_time_cnt[6]_i_2__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
    port map (
      I0 => \wait_time_cnt_reg__0\(6),
      I1 => \wait_time_cnt_reg__0\(1),
      I2 => \wait_time_cnt_reg__0\(0),
      I3 => \n_0_wait_time_cnt[6]_i_4__0\,
      I4 => \wait_time_cnt_reg__0\(4),
      I5 => \wait_time_cnt_reg__0\(5),
      O => \n_0_wait_time_cnt[6]_i_2__0\
    );
\wait_time_cnt[6]_i_3__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000001"
    )
    port map (
      I0 => \wait_time_cnt_reg__0\(5),
      I1 => \wait_time_cnt_reg__0\(4),
      I2 => \n_0_wait_time_cnt[6]_i_4__0\,
      I3 => \wait_time_cnt_reg__0\(0),
      I4 => \wait_time_cnt_reg__0\(1),
      I5 => \wait_time_cnt_reg__0\(6),
      O => \wait_time_cnt0__0\(6)
    );
\wait_time_cnt[6]_i_4__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \wait_time_cnt_reg__0\(2),
      I1 => \wait_time_cnt_reg__0\(3),
      O => \n_0_wait_time_cnt[6]_i_4__0\
    );
\wait_time_cnt_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => \n_0_wait_time_cnt[6]_i_2__0\,
      D => \wait_time_cnt0__0\(0),
      Q => \wait_time_cnt_reg__0\(0),
      R => \n_0_wait_time_cnt[6]_i_1__0\
    );
\wait_time_cnt_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => \n_0_wait_time_cnt[6]_i_2__0\,
      D => \wait_time_cnt0__0\(1),
      Q => \wait_time_cnt_reg__0\(1),
      R => \n_0_wait_time_cnt[6]_i_1__0\
    );
\wait_time_cnt_reg[2]\: unisim.vcomponents.FDSE
    port map (
      C => independent_clock_bufg,
      CE => \n_0_wait_time_cnt[6]_i_2__0\,
      D => \wait_time_cnt0__0\(2),
      Q => \wait_time_cnt_reg__0\(2),
      S => \n_0_wait_time_cnt[6]_i_1__0\
    );
\wait_time_cnt_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => \n_0_wait_time_cnt[6]_i_2__0\,
      D => \wait_time_cnt0__0\(3),
      Q => \wait_time_cnt_reg__0\(3),
      R => \n_0_wait_time_cnt[6]_i_1__0\
    );
\wait_time_cnt_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => \n_0_wait_time_cnt[6]_i_2__0\,
      D => \wait_time_cnt0__0\(4),
      Q => \wait_time_cnt_reg__0\(4),
      R => \n_0_wait_time_cnt[6]_i_1__0\
    );
\wait_time_cnt_reg[5]\: unisim.vcomponents.FDSE
    port map (
      C => independent_clock_bufg,
      CE => \n_0_wait_time_cnt[6]_i_2__0\,
      D => \wait_time_cnt0__0\(5),
      Q => \wait_time_cnt_reg__0\(5),
      S => \n_0_wait_time_cnt[6]_i_1__0\
    );
\wait_time_cnt_reg[6]\: unisim.vcomponents.FDSE
    port map (
      C => independent_clock_bufg,
      CE => \n_0_wait_time_cnt[6]_i_2__0\,
      D => \wait_time_cnt0__0\(6),
      Q => \wait_time_cnt_reg__0\(6),
      S => \n_0_wait_time_cnt[6]_i_1__0\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \gmii_to_sgmii_gmii_to_sgmii_TX_STARTUP_FSM__parameterized0\ is
  port (
    CPLL_RESET : out STD_LOGIC;
    TXUSERRDY : out STD_LOGIC;
    O1 : out STD_LOGIC;
    O2 : out STD_LOGIC;
    data_in_0 : out STD_LOGIC;
    independent_clock_bufg : in STD_LOGIC;
    I3 : in STD_LOGIC;
    AR : in STD_LOGIC_VECTOR ( 0 to 0 );
    ack_flag : in STD_LOGIC;
    data_in : in STD_LOGIC;
    I1 : in STD_LOGIC;
    I2 : in STD_LOGIC;
    I7 : in STD_LOGIC;
    gt0_rxresetdone_out : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \gmii_to_sgmii_gmii_to_sgmii_TX_STARTUP_FSM__parameterized0\ : entity is "gmii_to_sgmii_TX_STARTUP_FSM";
end \gmii_to_sgmii_gmii_to_sgmii_TX_STARTUP_FSM__parameterized0\;

architecture STRUCTURE of \gmii_to_sgmii_gmii_to_sgmii_TX_STARTUP_FSM__parameterized0\ is
  signal \^cpll_reset\ : STD_LOGIC;
  signal GTTXRESET : STD_LOGIC;
  signal \^txuserrdy\ : STD_LOGIC;
  signal clear : STD_LOGIC;
  signal data_out : STD_LOGIC;
  signal gt0_txresetdone_out : STD_LOGIC;
  signal \init_wait_count_reg__0\ : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal \mmcm_lock_count_reg__0\ : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal mmcm_lock_reclocked : STD_LOGIC;
  signal n_0_CPLL_RESET_i_1 : STD_LOGIC;
  signal \n_0_FSM_sequential_tx_state[0]_i_1\ : STD_LOGIC;
  signal \n_0_FSM_sequential_tx_state[0]_i_2\ : STD_LOGIC;
  signal \n_0_FSM_sequential_tx_state[1]_i_1\ : STD_LOGIC;
  signal \n_0_FSM_sequential_tx_state[2]_i_1\ : STD_LOGIC;
  signal \n_0_FSM_sequential_tx_state[2]_i_2\ : STD_LOGIC;
  signal \n_0_FSM_sequential_tx_state[3]_i_2\ : STD_LOGIC;
  signal \n_0_FSM_sequential_tx_state[3]_i_4\ : STD_LOGIC;
  signal \n_0_FSM_sequential_tx_state[3]_i_5\ : STD_LOGIC;
  signal n_0_TXUSERRDY_i_1 : STD_LOGIC;
  signal n_0_gttxreset_i_i_1 : STD_LOGIC;
  signal \n_0_init_wait_count[0]_i_1\ : STD_LOGIC;
  signal \n_0_init_wait_count[6]_i_1\ : STD_LOGIC;
  signal \n_0_init_wait_count[6]_i_3\ : STD_LOGIC;
  signal \n_0_init_wait_count[6]_i_4\ : STD_LOGIC;
  signal n_0_init_wait_done_i_1 : STD_LOGIC;
  signal n_0_init_wait_done_i_2 : STD_LOGIC;
  signal n_0_init_wait_done_reg : STD_LOGIC;
  signal \n_0_mmcm_lock_count[9]_i_2\ : STD_LOGIC;
  signal \n_0_mmcm_lock_count[9]_i_4\ : STD_LOGIC;
  signal n_0_mmcm_lock_reclocked_i_2 : STD_LOGIC;
  signal n_0_pll_reset_asserted_i_1 : STD_LOGIC;
  signal n_0_pll_reset_asserted_reg : STD_LOGIC;
  signal n_0_run_phase_alignment_int_i_1 : STD_LOGIC;
  signal n_0_run_phase_alignment_int_reg : STD_LOGIC;
  signal n_0_sync_cplllock : STD_LOGIC;
  signal n_0_sync_mmcm_lock_reclocked : STD_LOGIC;
  signal \n_0_time_out_2ms_i_1__0\ : STD_LOGIC;
  signal n_0_time_out_2ms_i_2 : STD_LOGIC;
  signal n_0_time_out_2ms_reg : STD_LOGIC;
  signal n_0_time_out_500us_i_1 : STD_LOGIC;
  signal n_0_time_out_500us_i_2 : STD_LOGIC;
  signal n_0_time_out_500us_reg : STD_LOGIC;
  signal \n_0_time_out_counter[0]_i_10\ : STD_LOGIC;
  signal \n_0_time_out_counter[0]_i_1__0\ : STD_LOGIC;
  signal \n_0_time_out_counter[0]_i_3\ : STD_LOGIC;
  signal \n_0_time_out_counter[0]_i_4__0\ : STD_LOGIC;
  signal \n_0_time_out_counter[0]_i_5\ : STD_LOGIC;
  signal \n_0_time_out_counter[0]_i_6\ : STD_LOGIC;
  signal \n_0_time_out_counter[0]_i_7\ : STD_LOGIC;
  signal \n_0_time_out_counter[0]_i_8\ : STD_LOGIC;
  signal \n_0_time_out_counter[0]_i_9\ : STD_LOGIC;
  signal \n_0_time_out_counter[12]_i_2\ : STD_LOGIC;
  signal \n_0_time_out_counter[12]_i_3\ : STD_LOGIC;
  signal \n_0_time_out_counter[12]_i_4\ : STD_LOGIC;
  signal \n_0_time_out_counter[12]_i_5\ : STD_LOGIC;
  signal \n_0_time_out_counter[16]_i_2\ : STD_LOGIC;
  signal \n_0_time_out_counter[16]_i_3\ : STD_LOGIC;
  signal \n_0_time_out_counter[16]_i_4\ : STD_LOGIC;
  signal \n_0_time_out_counter[4]_i_2\ : STD_LOGIC;
  signal \n_0_time_out_counter[4]_i_3\ : STD_LOGIC;
  signal \n_0_time_out_counter[4]_i_4\ : STD_LOGIC;
  signal \n_0_time_out_counter[4]_i_5\ : STD_LOGIC;
  signal \n_0_time_out_counter[8]_i_2\ : STD_LOGIC;
  signal \n_0_time_out_counter[8]_i_3\ : STD_LOGIC;
  signal \n_0_time_out_counter[8]_i_4\ : STD_LOGIC;
  signal \n_0_time_out_counter[8]_i_5\ : STD_LOGIC;
  signal \n_0_time_out_counter_reg[0]_i_2\ : STD_LOGIC;
  signal \n_0_time_out_counter_reg[12]_i_1\ : STD_LOGIC;
  signal \n_0_time_out_counter_reg[4]_i_1\ : STD_LOGIC;
  signal \n_0_time_out_counter_reg[8]_i_1\ : STD_LOGIC;
  signal n_0_time_out_wait_bypass_i_1 : STD_LOGIC;
  signal n_0_time_out_wait_bypass_reg : STD_LOGIC;
  signal n_0_time_tlock_max_i_1 : STD_LOGIC;
  signal n_0_time_tlock_max_i_2 : STD_LOGIC;
  signal n_0_time_tlock_max_i_3 : STD_LOGIC;
  signal n_0_time_tlock_max_reg : STD_LOGIC;
  signal n_0_tx_fsm_reset_done_int_i_1 : STD_LOGIC;
  signal \n_0_wait_bypass_count[0]_i_1\ : STD_LOGIC;
  signal \n_0_wait_bypass_count[0]_i_10\ : STD_LOGIC;
  signal \n_0_wait_bypass_count[0]_i_2\ : STD_LOGIC;
  signal \n_0_wait_bypass_count[0]_i_4\ : STD_LOGIC;
  signal \n_0_wait_bypass_count[0]_i_5\ : STD_LOGIC;
  signal \n_0_wait_bypass_count[0]_i_6\ : STD_LOGIC;
  signal \n_0_wait_bypass_count[0]_i_7\ : STD_LOGIC;
  signal \n_0_wait_bypass_count[0]_i_8\ : STD_LOGIC;
  signal \n_0_wait_bypass_count[0]_i_9__0\ : STD_LOGIC;
  signal \n_0_wait_bypass_count[12]_i_2\ : STD_LOGIC;
  signal \n_0_wait_bypass_count[12]_i_3\ : STD_LOGIC;
  signal \n_0_wait_bypass_count[12]_i_4\ : STD_LOGIC;
  signal \n_0_wait_bypass_count[12]_i_5\ : STD_LOGIC;
  signal \n_0_wait_bypass_count[16]_i_2\ : STD_LOGIC;
  signal \n_0_wait_bypass_count[4]_i_2\ : STD_LOGIC;
  signal \n_0_wait_bypass_count[4]_i_3\ : STD_LOGIC;
  signal \n_0_wait_bypass_count[4]_i_4\ : STD_LOGIC;
  signal \n_0_wait_bypass_count[4]_i_5\ : STD_LOGIC;
  signal \n_0_wait_bypass_count[8]_i_2\ : STD_LOGIC;
  signal \n_0_wait_bypass_count[8]_i_3\ : STD_LOGIC;
  signal \n_0_wait_bypass_count[8]_i_4\ : STD_LOGIC;
  signal \n_0_wait_bypass_count[8]_i_5\ : STD_LOGIC;
  signal \n_0_wait_bypass_count_reg[0]_i_3\ : STD_LOGIC;
  signal \n_0_wait_bypass_count_reg[12]_i_1\ : STD_LOGIC;
  signal \n_0_wait_bypass_count_reg[4]_i_1\ : STD_LOGIC;
  signal \n_0_wait_bypass_count_reg[8]_i_1\ : STD_LOGIC;
  signal \n_0_wait_time_cnt[6]_i_2\ : STD_LOGIC;
  signal \n_0_wait_time_cnt[6]_i_4\ : STD_LOGIC;
  signal n_1_sync_cplllock : STD_LOGIC;
  signal n_1_sync_mmcm_lock_reclocked : STD_LOGIC;
  signal \n_1_time_out_counter_reg[0]_i_2\ : STD_LOGIC;
  signal \n_1_time_out_counter_reg[12]_i_1\ : STD_LOGIC;
  signal \n_1_time_out_counter_reg[4]_i_1\ : STD_LOGIC;
  signal \n_1_time_out_counter_reg[8]_i_1\ : STD_LOGIC;
  signal \n_1_wait_bypass_count_reg[0]_i_3\ : STD_LOGIC;
  signal \n_1_wait_bypass_count_reg[12]_i_1\ : STD_LOGIC;
  signal \n_1_wait_bypass_count_reg[4]_i_1\ : STD_LOGIC;
  signal \n_1_wait_bypass_count_reg[8]_i_1\ : STD_LOGIC;
  signal \n_2_time_out_counter_reg[0]_i_2\ : STD_LOGIC;
  signal \n_2_time_out_counter_reg[12]_i_1\ : STD_LOGIC;
  signal \n_2_time_out_counter_reg[16]_i_1\ : STD_LOGIC;
  signal \n_2_time_out_counter_reg[4]_i_1\ : STD_LOGIC;
  signal \n_2_time_out_counter_reg[8]_i_1\ : STD_LOGIC;
  signal \n_2_wait_bypass_count_reg[0]_i_3\ : STD_LOGIC;
  signal \n_2_wait_bypass_count_reg[12]_i_1\ : STD_LOGIC;
  signal \n_2_wait_bypass_count_reg[4]_i_1\ : STD_LOGIC;
  signal \n_2_wait_bypass_count_reg[8]_i_1\ : STD_LOGIC;
  signal \n_3_time_out_counter_reg[0]_i_2\ : STD_LOGIC;
  signal \n_3_time_out_counter_reg[12]_i_1\ : STD_LOGIC;
  signal \n_3_time_out_counter_reg[16]_i_1\ : STD_LOGIC;
  signal \n_3_time_out_counter_reg[4]_i_1\ : STD_LOGIC;
  signal \n_3_time_out_counter_reg[8]_i_1\ : STD_LOGIC;
  signal \n_3_wait_bypass_count_reg[0]_i_3\ : STD_LOGIC;
  signal \n_3_wait_bypass_count_reg[12]_i_1\ : STD_LOGIC;
  signal \n_3_wait_bypass_count_reg[4]_i_1\ : STD_LOGIC;
  signal \n_3_wait_bypass_count_reg[8]_i_1\ : STD_LOGIC;
  signal \n_4_time_out_counter_reg[0]_i_2\ : STD_LOGIC;
  signal \n_4_time_out_counter_reg[12]_i_1\ : STD_LOGIC;
  signal \n_4_time_out_counter_reg[4]_i_1\ : STD_LOGIC;
  signal \n_4_time_out_counter_reg[8]_i_1\ : STD_LOGIC;
  signal \n_4_wait_bypass_count_reg[0]_i_3\ : STD_LOGIC;
  signal \n_4_wait_bypass_count_reg[12]_i_1\ : STD_LOGIC;
  signal \n_4_wait_bypass_count_reg[4]_i_1\ : STD_LOGIC;
  signal \n_4_wait_bypass_count_reg[8]_i_1\ : STD_LOGIC;
  signal \n_5_time_out_counter_reg[0]_i_2\ : STD_LOGIC;
  signal \n_5_time_out_counter_reg[12]_i_1\ : STD_LOGIC;
  signal \n_5_time_out_counter_reg[16]_i_1\ : STD_LOGIC;
  signal \n_5_time_out_counter_reg[4]_i_1\ : STD_LOGIC;
  signal \n_5_time_out_counter_reg[8]_i_1\ : STD_LOGIC;
  signal \n_5_wait_bypass_count_reg[0]_i_3\ : STD_LOGIC;
  signal \n_5_wait_bypass_count_reg[12]_i_1\ : STD_LOGIC;
  signal \n_5_wait_bypass_count_reg[4]_i_1\ : STD_LOGIC;
  signal \n_5_wait_bypass_count_reg[8]_i_1\ : STD_LOGIC;
  signal \n_6_time_out_counter_reg[0]_i_2\ : STD_LOGIC;
  signal \n_6_time_out_counter_reg[12]_i_1\ : STD_LOGIC;
  signal \n_6_time_out_counter_reg[16]_i_1\ : STD_LOGIC;
  signal \n_6_time_out_counter_reg[4]_i_1\ : STD_LOGIC;
  signal \n_6_time_out_counter_reg[8]_i_1\ : STD_LOGIC;
  signal \n_6_wait_bypass_count_reg[0]_i_3\ : STD_LOGIC;
  signal \n_6_wait_bypass_count_reg[12]_i_1\ : STD_LOGIC;
  signal \n_6_wait_bypass_count_reg[4]_i_1\ : STD_LOGIC;
  signal \n_6_wait_bypass_count_reg[8]_i_1\ : STD_LOGIC;
  signal \n_7_time_out_counter_reg[0]_i_2\ : STD_LOGIC;
  signal \n_7_time_out_counter_reg[12]_i_1\ : STD_LOGIC;
  signal \n_7_time_out_counter_reg[16]_i_1\ : STD_LOGIC;
  signal \n_7_time_out_counter_reg[4]_i_1\ : STD_LOGIC;
  signal \n_7_time_out_counter_reg[8]_i_1\ : STD_LOGIC;
  signal \n_7_wait_bypass_count_reg[0]_i_3\ : STD_LOGIC;
  signal \n_7_wait_bypass_count_reg[12]_i_1\ : STD_LOGIC;
  signal \n_7_wait_bypass_count_reg[16]_i_1\ : STD_LOGIC;
  signal \n_7_wait_bypass_count_reg[4]_i_1\ : STD_LOGIC;
  signal \n_7_wait_bypass_count_reg[8]_i_1\ : STD_LOGIC;
  signal p_0_in : STD_LOGIC_VECTOR ( 6 downto 1 );
  signal \p_0_in__0\ : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal reset_time_out : STD_LOGIC;
  signal run_phase_alignment_int_s3 : STD_LOGIC;
  signal time_out_counter_reg : STD_LOGIC_VECTOR ( 18 downto 0 );
  signal time_out_wait_bypass_s2 : STD_LOGIC;
  signal time_out_wait_bypass_s3 : STD_LOGIC;
  signal tx_fsm_reset_done_int_s2 : STD_LOGIC;
  signal tx_fsm_reset_done_int_s3 : STD_LOGIC;
  signal tx_state : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal tx_state13_out : STD_LOGIC;
  signal txresetdone_s2 : STD_LOGIC;
  signal txresetdone_s3 : STD_LOGIC;
  signal wait_bypass_count_reg : STD_LOGIC_VECTOR ( 16 downto 0 );
  signal wait_time_cnt0 : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal \wait_time_cnt_reg__0\ : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal \NLW_time_out_counter_reg[16]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_time_out_counter_reg[16]_i_1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_wait_bypass_count_reg[16]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_wait_bypass_count_reg[16]_i_1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  attribute KEEP : string;
  attribute KEEP of \FSM_sequential_tx_state_reg[0]\ : label is "yes";
  attribute KEEP of \FSM_sequential_tx_state_reg[1]\ : label is "yes";
  attribute KEEP of \FSM_sequential_tx_state_reg[2]\ : label is "yes";
  attribute KEEP of \FSM_sequential_tx_state_reg[3]\ : label is "yes";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of data_sync1_i_1 : label is "soft_lutpair103";
  attribute SOFT_HLUTNM of gthe2_i_i_4 : label is "soft_lutpair103";
  attribute SOFT_HLUTNM of \init_wait_count[1]_i_1\ : label is "soft_lutpair105";
  attribute SOFT_HLUTNM of \init_wait_count[2]_i_1\ : label is "soft_lutpair101";
  attribute SOFT_HLUTNM of \init_wait_count[3]_i_1\ : label is "soft_lutpair101";
  attribute SOFT_HLUTNM of \init_wait_count[4]_i_1\ : label is "soft_lutpair97";
  attribute SOFT_HLUTNM of \init_wait_count[6]_i_3\ : label is "soft_lutpair105";
  attribute SOFT_HLUTNM of \init_wait_count[6]_i_4\ : label is "soft_lutpair97";
  attribute SOFT_HLUTNM of \mmcm_lock_count[1]_i_1\ : label is "soft_lutpair104";
  attribute SOFT_HLUTNM of \mmcm_lock_count[2]_i_1\ : label is "soft_lutpair104";
  attribute SOFT_HLUTNM of \mmcm_lock_count[3]_i_1\ : label is "soft_lutpair98";
  attribute SOFT_HLUTNM of \mmcm_lock_count[4]_i_1\ : label is "soft_lutpair98";
  attribute SOFT_HLUTNM of \mmcm_lock_count[7]_i_1\ : label is "soft_lutpair102";
  attribute SOFT_HLUTNM of \mmcm_lock_count[8]_i_1\ : label is "soft_lutpair102";
  attribute SOFT_HLUTNM of \mmcm_lock_count[9]_i_3\ : label is "soft_lutpair99";
  attribute SOFT_HLUTNM of mmcm_lock_reclocked_i_2 : label is "soft_lutpair99";
  attribute SOFT_HLUTNM of \wait_time_cnt[0]_i_1\ : label is "soft_lutpair106";
  attribute SOFT_HLUTNM of \wait_time_cnt[1]_i_1\ : label is "soft_lutpair106";
  attribute SOFT_HLUTNM of \wait_time_cnt[3]_i_1\ : label is "soft_lutpair100";
  attribute SOFT_HLUTNM of \wait_time_cnt[4]_i_1\ : label is "soft_lutpair100";
begin
  CPLL_RESET <= \^cpll_reset\;
  TXUSERRDY <= \^txuserrdy\;
CPLL_RESET_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFDFF00000100"
    )
    port map (
      I0 => n_0_pll_reset_asserted_reg,
      I1 => tx_state(3),
      I2 => tx_state(2),
      I3 => tx_state(0),
      I4 => tx_state(1),
      I5 => \^cpll_reset\,
      O => n_0_CPLL_RESET_i_1
    );
CPLL_RESET_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => n_0_CPLL_RESET_i_1,
      Q => \^cpll_reset\,
      R => AR(0)
    );
\FSM_sequential_tx_state[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2222220222220A0A"
    )
    port map (
      I0 => \n_0_FSM_sequential_tx_state[0]_i_2\,
      I1 => tx_state(3),
      I2 => tx_state(0),
      I3 => n_0_time_out_2ms_reg,
      I4 => tx_state(2),
      I5 => tx_state(1),
      O => \n_0_FSM_sequential_tx_state[0]_i_1\
    );
\FSM_sequential_tx_state[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3B33BBBBBBBBBBBB"
    )
    port map (
      I0 => \n_0_FSM_sequential_tx_state[2]_i_2\,
      I1 => tx_state(0),
      I2 => reset_time_out,
      I3 => n_0_time_out_500us_reg,
      I4 => tx_state(1),
      I5 => tx_state(2),
      O => \n_0_FSM_sequential_tx_state[0]_i_2\
    );
\FSM_sequential_tx_state[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"11110444"
    )
    port map (
      I0 => tx_state(3),
      I1 => tx_state(0),
      I2 => tx_state13_out,
      I3 => tx_state(2),
      I4 => tx_state(1),
      O => \n_0_FSM_sequential_tx_state[1]_i_1\
    );
\FSM_sequential_tx_state[1]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"10"
    )
    port map (
      I0 => mmcm_lock_reclocked,
      I1 => reset_time_out,
      I2 => n_0_time_tlock_max_reg,
      O => tx_state13_out
    );
\FSM_sequential_tx_state[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1111004055550040"
    )
    port map (
      I0 => tx_state(3),
      I1 => tx_state(0),
      I2 => tx_state(1),
      I3 => n_0_time_out_2ms_reg,
      I4 => tx_state(2),
      I5 => \n_0_FSM_sequential_tx_state[2]_i_2\,
      O => \n_0_FSM_sequential_tx_state[2]_i_1\
    );
\FSM_sequential_tx_state[2]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FF02"
    )
    port map (
      I0 => n_0_time_tlock_max_reg,
      I1 => reset_time_out,
      I2 => mmcm_lock_reclocked,
      I3 => tx_state(1),
      O => \n_0_FSM_sequential_tx_state[2]_i_2\
    );
\FSM_sequential_tx_state[3]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00A00B00"
    )
    port map (
      I0 => \n_0_FSM_sequential_tx_state[3]_i_5\,
      I1 => time_out_wait_bypass_s3,
      I2 => tx_state(2),
      I3 => tx_state(3),
      I4 => tx_state(1),
      O => \n_0_FSM_sequential_tx_state[3]_i_2\
    );
\FSM_sequential_tx_state[3]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => tx_state(1),
      I1 => tx_state(2),
      O => \n_0_FSM_sequential_tx_state[3]_i_4\
    );
\FSM_sequential_tx_state[3]_i_5\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8A"
    )
    port map (
      I0 => tx_state(0),
      I1 => reset_time_out,
      I2 => n_0_time_out_500us_reg,
      O => \n_0_FSM_sequential_tx_state[3]_i_5\
    );
\FSM_sequential_tx_state_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => n_1_sync_cplllock,
      D => \n_0_FSM_sequential_tx_state[0]_i_1\,
      Q => tx_state(0),
      R => AR(0)
    );
\FSM_sequential_tx_state_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => n_1_sync_cplllock,
      D => \n_0_FSM_sequential_tx_state[1]_i_1\,
      Q => tx_state(1),
      R => AR(0)
    );
\FSM_sequential_tx_state_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => n_1_sync_cplllock,
      D => \n_0_FSM_sequential_tx_state[2]_i_1\,
      Q => tx_state(2),
      R => AR(0)
    );
\FSM_sequential_tx_state_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => n_1_sync_cplllock,
      D => \n_0_FSM_sequential_tx_state[3]_i_2\,
      Q => tx_state(3),
      R => AR(0)
    );
TXUSERRDY_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFB4000"
    )
    port map (
      I0 => tx_state(3),
      I1 => tx_state(0),
      I2 => tx_state(1),
      I3 => tx_state(2),
      I4 => \^txuserrdy\,
      O => n_0_TXUSERRDY_i_1
    );
TXUSERRDY_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => n_0_TXUSERRDY_i_1,
      Q => \^txuserrdy\,
      R => AR(0)
    );
data_sync1_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => gt0_txresetdone_out,
      I1 => gt0_rxresetdone_out,
      O => data_in_0
    );
flag2_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \^cpll_reset\,
      I1 => ack_flag,
      O => O1
    );
gthe2_i_i_4: unisim.vcomponents.LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => GTTXRESET,
      I1 => gt0_txresetdone_out,
      I2 => I7,
      O => O2
    );
gttxreset_i_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFD0004"
    )
    port map (
      I0 => tx_state(2),
      I1 => tx_state(0),
      I2 => tx_state(3),
      I3 => tx_state(1),
      I4 => GTTXRESET,
      O => n_0_gttxreset_i_i_1
    );
gttxreset_i_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => n_0_gttxreset_i_i_1,
      Q => GTTXRESET,
      R => AR(0)
    );
\init_wait_count[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \init_wait_count_reg__0\(0),
      O => \n_0_init_wait_count[0]_i_1\
    );
\init_wait_count[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \init_wait_count_reg__0\(1),
      I1 => \init_wait_count_reg__0\(0),
      O => p_0_in(1)
    );
\init_wait_count[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
    port map (
      I0 => \init_wait_count_reg__0\(1),
      I1 => \init_wait_count_reg__0\(0),
      I2 => \init_wait_count_reg__0\(2),
      O => p_0_in(2)
    );
\init_wait_count[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
    port map (
      I0 => \init_wait_count_reg__0\(2),
      I1 => \init_wait_count_reg__0\(0),
      I2 => \init_wait_count_reg__0\(1),
      I3 => \init_wait_count_reg__0\(3),
      O => p_0_in(3)
    );
\init_wait_count[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFF8000"
    )
    port map (
      I0 => \init_wait_count_reg__0\(3),
      I1 => \init_wait_count_reg__0\(1),
      I2 => \init_wait_count_reg__0\(0),
      I3 => \init_wait_count_reg__0\(2),
      I4 => \init_wait_count_reg__0\(4),
      O => p_0_in(4)
    );
\init_wait_count[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFF80000000"
    )
    port map (
      I0 => \init_wait_count_reg__0\(4),
      I1 => \init_wait_count_reg__0\(2),
      I2 => \init_wait_count_reg__0\(0),
      I3 => \init_wait_count_reg__0\(1),
      I4 => \init_wait_count_reg__0\(3),
      I5 => \init_wait_count_reg__0\(5),
      O => p_0_in(5)
    );
\init_wait_count[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFF7FFFFF"
    )
    port map (
      I0 => \init_wait_count_reg__0\(5),
      I1 => \init_wait_count_reg__0\(6),
      I2 => \init_wait_count_reg__0\(3),
      I3 => \init_wait_count_reg__0\(4),
      I4 => \init_wait_count_reg__0\(2),
      I5 => \n_0_init_wait_count[6]_i_3\,
      O => \n_0_init_wait_count[6]_i_1\
    );
\init_wait_count[6]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"D2"
    )
    port map (
      I0 => \init_wait_count_reg__0\(5),
      I1 => \n_0_init_wait_count[6]_i_4\,
      I2 => \init_wait_count_reg__0\(6),
      O => p_0_in(6)
    );
\init_wait_count[6]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => \init_wait_count_reg__0\(0),
      I1 => \init_wait_count_reg__0\(1),
      O => \n_0_init_wait_count[6]_i_3\
    );
\init_wait_count[6]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFFFFFF"
    )
    port map (
      I0 => \init_wait_count_reg__0\(3),
      I1 => \init_wait_count_reg__0\(1),
      I2 => \init_wait_count_reg__0\(0),
      I3 => \init_wait_count_reg__0\(2),
      I4 => \init_wait_count_reg__0\(4),
      O => \n_0_init_wait_count[6]_i_4\
    );
\init_wait_count_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_init_wait_count[6]_i_1\,
      CLR => AR(0),
      D => \n_0_init_wait_count[0]_i_1\,
      Q => \init_wait_count_reg__0\(0)
    );
\init_wait_count_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_init_wait_count[6]_i_1\,
      CLR => AR(0),
      D => p_0_in(1),
      Q => \init_wait_count_reg__0\(1)
    );
\init_wait_count_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_init_wait_count[6]_i_1\,
      CLR => AR(0),
      D => p_0_in(2),
      Q => \init_wait_count_reg__0\(2)
    );
\init_wait_count_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_init_wait_count[6]_i_1\,
      CLR => AR(0),
      D => p_0_in(3),
      Q => \init_wait_count_reg__0\(3)
    );
\init_wait_count_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_init_wait_count[6]_i_1\,
      CLR => AR(0),
      D => p_0_in(4),
      Q => \init_wait_count_reg__0\(4)
    );
\init_wait_count_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_init_wait_count[6]_i_1\,
      CLR => AR(0),
      D => p_0_in(5),
      Q => \init_wait_count_reg__0\(5)
    );
\init_wait_count_reg[6]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_init_wait_count[6]_i_1\,
      CLR => AR(0),
      D => p_0_in(6),
      Q => \init_wait_count_reg__0\(6)
    );
init_wait_done_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00008000"
    )
    port map (
      I0 => n_0_init_wait_done_i_2,
      I1 => \init_wait_count_reg__0\(2),
      I2 => \init_wait_count_reg__0\(6),
      I3 => \init_wait_count_reg__0\(5),
      I4 => \n_0_init_wait_count[6]_i_3\,
      I5 => n_0_init_wait_done_reg,
      O => n_0_init_wait_done_i_1
    );
init_wait_done_i_2: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \init_wait_count_reg__0\(3),
      I1 => \init_wait_count_reg__0\(4),
      O => n_0_init_wait_done_i_2
    );
init_wait_done_reg: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      CLR => AR(0),
      D => n_0_init_wait_done_i_1,
      Q => n_0_init_wait_done_reg
    );
\mmcm_lock_count[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \mmcm_lock_count_reg__0\(0),
      O => \p_0_in__0\(0)
    );
\mmcm_lock_count[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \mmcm_lock_count_reg__0\(0),
      I1 => \mmcm_lock_count_reg__0\(1),
      O => \p_0_in__0\(1)
    );
\mmcm_lock_count[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
    port map (
      I0 => \mmcm_lock_count_reg__0\(1),
      I1 => \mmcm_lock_count_reg__0\(0),
      I2 => \mmcm_lock_count_reg__0\(2),
      O => \p_0_in__0\(2)
    );
\mmcm_lock_count[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
    port map (
      I0 => \mmcm_lock_count_reg__0\(2),
      I1 => \mmcm_lock_count_reg__0\(0),
      I2 => \mmcm_lock_count_reg__0\(1),
      I3 => \mmcm_lock_count_reg__0\(3),
      O => \p_0_in__0\(3)
    );
\mmcm_lock_count[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFF8000"
    )
    port map (
      I0 => \mmcm_lock_count_reg__0\(1),
      I1 => \mmcm_lock_count_reg__0\(0),
      I2 => \mmcm_lock_count_reg__0\(2),
      I3 => \mmcm_lock_count_reg__0\(3),
      I4 => \mmcm_lock_count_reg__0\(4),
      O => \p_0_in__0\(4)
    );
\mmcm_lock_count[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFF80000000"
    )
    port map (
      I0 => \mmcm_lock_count_reg__0\(4),
      I1 => \mmcm_lock_count_reg__0\(3),
      I2 => \mmcm_lock_count_reg__0\(2),
      I3 => \mmcm_lock_count_reg__0\(0),
      I4 => \mmcm_lock_count_reg__0\(1),
      I5 => \mmcm_lock_count_reg__0\(5),
      O => \p_0_in__0\(5)
    );
\mmcm_lock_count[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => \n_0_mmcm_lock_count[9]_i_4\,
      I1 => \mmcm_lock_count_reg__0\(6),
      O => \p_0_in__0\(6)
    );
\mmcm_lock_count[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"D2"
    )
    port map (
      I0 => \mmcm_lock_count_reg__0\(6),
      I1 => \n_0_mmcm_lock_count[9]_i_4\,
      I2 => \mmcm_lock_count_reg__0\(7),
      O => \p_0_in__0\(7)
    );
\mmcm_lock_count[8]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DF20"
    )
    port map (
      I0 => \mmcm_lock_count_reg__0\(7),
      I1 => \n_0_mmcm_lock_count[9]_i_4\,
      I2 => \mmcm_lock_count_reg__0\(6),
      I3 => \mmcm_lock_count_reg__0\(8),
      O => \p_0_in__0\(8)
    );
\mmcm_lock_count[9]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"DFFFFFFF"
    )
    port map (
      I0 => \mmcm_lock_count_reg__0\(7),
      I1 => \n_0_mmcm_lock_count[9]_i_4\,
      I2 => \mmcm_lock_count_reg__0\(6),
      I3 => \mmcm_lock_count_reg__0\(8),
      I4 => \mmcm_lock_count_reg__0\(9),
      O => \n_0_mmcm_lock_count[9]_i_2\
    );
\mmcm_lock_count[9]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F7FF0800"
    )
    port map (
      I0 => \mmcm_lock_count_reg__0\(8),
      I1 => \mmcm_lock_count_reg__0\(6),
      I2 => \n_0_mmcm_lock_count[9]_i_4\,
      I3 => \mmcm_lock_count_reg__0\(7),
      I4 => \mmcm_lock_count_reg__0\(9),
      O => \p_0_in__0\(9)
    );
\mmcm_lock_count[9]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFFFFFFFFFF"
    )
    port map (
      I0 => \mmcm_lock_count_reg__0\(4),
      I1 => \mmcm_lock_count_reg__0\(3),
      I2 => \mmcm_lock_count_reg__0\(2),
      I3 => \mmcm_lock_count_reg__0\(0),
      I4 => \mmcm_lock_count_reg__0\(1),
      I5 => \mmcm_lock_count_reg__0\(5),
      O => \n_0_mmcm_lock_count[9]_i_4\
    );
\mmcm_lock_count_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_mmcm_lock_count[9]_i_2\,
      D => \p_0_in__0\(0),
      Q => \mmcm_lock_count_reg__0\(0),
      R => n_1_sync_mmcm_lock_reclocked
    );
\mmcm_lock_count_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_mmcm_lock_count[9]_i_2\,
      D => \p_0_in__0\(1),
      Q => \mmcm_lock_count_reg__0\(1),
      R => n_1_sync_mmcm_lock_reclocked
    );
\mmcm_lock_count_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_mmcm_lock_count[9]_i_2\,
      D => \p_0_in__0\(2),
      Q => \mmcm_lock_count_reg__0\(2),
      R => n_1_sync_mmcm_lock_reclocked
    );
\mmcm_lock_count_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_mmcm_lock_count[9]_i_2\,
      D => \p_0_in__0\(3),
      Q => \mmcm_lock_count_reg__0\(3),
      R => n_1_sync_mmcm_lock_reclocked
    );
\mmcm_lock_count_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_mmcm_lock_count[9]_i_2\,
      D => \p_0_in__0\(4),
      Q => \mmcm_lock_count_reg__0\(4),
      R => n_1_sync_mmcm_lock_reclocked
    );
\mmcm_lock_count_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_mmcm_lock_count[9]_i_2\,
      D => \p_0_in__0\(5),
      Q => \mmcm_lock_count_reg__0\(5),
      R => n_1_sync_mmcm_lock_reclocked
    );
\mmcm_lock_count_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_mmcm_lock_count[9]_i_2\,
      D => \p_0_in__0\(6),
      Q => \mmcm_lock_count_reg__0\(6),
      R => n_1_sync_mmcm_lock_reclocked
    );
\mmcm_lock_count_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_mmcm_lock_count[9]_i_2\,
      D => \p_0_in__0\(7),
      Q => \mmcm_lock_count_reg__0\(7),
      R => n_1_sync_mmcm_lock_reclocked
    );
\mmcm_lock_count_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_mmcm_lock_count[9]_i_2\,
      D => \p_0_in__0\(8),
      Q => \mmcm_lock_count_reg__0\(8),
      R => n_1_sync_mmcm_lock_reclocked
    );
\mmcm_lock_count_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_mmcm_lock_count[9]_i_2\,
      D => \p_0_in__0\(9),
      Q => \mmcm_lock_count_reg__0\(9),
      R => n_1_sync_mmcm_lock_reclocked
    );
mmcm_lock_reclocked_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00800000"
    )
    port map (
      I0 => \mmcm_lock_count_reg__0\(9),
      I1 => \mmcm_lock_count_reg__0\(8),
      I2 => \mmcm_lock_count_reg__0\(6),
      I3 => \n_0_mmcm_lock_count[9]_i_4\,
      I4 => \mmcm_lock_count_reg__0\(7),
      O => n_0_mmcm_lock_reclocked_i_2
    );
mmcm_lock_reclocked_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => n_0_sync_mmcm_lock_reclocked,
      Q => mmcm_lock_reclocked,
      R => '0'
    );
pll_reset_asserted_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EF00FF10"
    )
    port map (
      I0 => tx_state(3),
      I1 => tx_state(2),
      I2 => tx_state(0),
      I3 => n_0_pll_reset_asserted_reg,
      I4 => tx_state(1),
      O => n_0_pll_reset_asserted_i_1
    );
pll_reset_asserted_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => n_0_pll_reset_asserted_i_1,
      Q => n_0_pll_reset_asserted_reg,
      R => AR(0)
    );
reset_time_out_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => n_0_sync_cplllock,
      Q => reset_time_out,
      R => AR(0)
    );
run_phase_alignment_int_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFB0002"
    )
    port map (
      I0 => tx_state(3),
      I1 => tx_state(0),
      I2 => tx_state(2),
      I3 => tx_state(1),
      I4 => n_0_run_phase_alignment_int_reg,
      O => n_0_run_phase_alignment_int_i_1
    );
run_phase_alignment_int_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => n_0_run_phase_alignment_int_i_1,
      Q => n_0_run_phase_alignment_int_reg,
      R => AR(0)
    );
run_phase_alignment_int_s3_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I3,
      CE => '1',
      D => data_out,
      Q => run_phase_alignment_int_s3,
      R => '0'
    );
sync_TXRESETDONE: entity work.\gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_19\
    port map (
      data_in => data_in,
      data_out => txresetdone_s2,
      independent_clock_bufg => independent_clock_bufg
    );
sync_cplllock: entity work.\gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_20\
    port map (
      E(0) => n_1_sync_cplllock,
      I1 => n_0_init_wait_done_reg,
      I2(0) => \n_0_wait_time_cnt[6]_i_2\,
      I3 => \n_0_FSM_sequential_tx_state[3]_i_4\,
      I4 => n_0_time_tlock_max_reg,
      I5 => n_0_pll_reset_asserted_reg,
      I6 => n_0_time_out_500us_reg,
      I7 => n_0_time_out_2ms_reg,
      I8 => I2,
      O1 => n_0_sync_cplllock,
      independent_clock_bufg => independent_clock_bufg,
      mmcm_lock_reclocked => mmcm_lock_reclocked,
      \out\(3 downto 0) => tx_state(3 downto 0),
      reset_time_out => reset_time_out,
      txresetdone_s3 => txresetdone_s3
    );
sync_mmcm_lock_reclocked: entity work.\gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_21\
    port map (
      I1 => n_0_mmcm_lock_reclocked_i_2,
      I2 => I1,
      O1 => n_0_sync_mmcm_lock_reclocked,
      SR(0) => n_1_sync_mmcm_lock_reclocked,
      independent_clock_bufg => independent_clock_bufg,
      mmcm_lock_reclocked => mmcm_lock_reclocked
    );
sync_run_phase_alignment_int: entity work.\gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_22\
    port map (
      I3 => I3,
      data_in => n_0_run_phase_alignment_int_reg,
      data_out => data_out
    );
sync_time_out_wait_bypass: entity work.\gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_23\
    port map (
      data_in => n_0_time_out_wait_bypass_reg,
      data_out => time_out_wait_bypass_s2,
      independent_clock_bufg => independent_clock_bufg
    );
sync_tx_fsm_reset_done_int: entity work.\gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_24\
    port map (
      I3 => I3,
      data_out => tx_fsm_reset_done_int_s2,
      gt0_txresetdone_out => gt0_txresetdone_out
    );
\time_out_2ms_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00AE"
    )
    port map (
      I0 => n_0_time_out_2ms_reg,
      I1 => n_0_time_out_2ms_i_2,
      I2 => \n_0_time_out_counter[0]_i_5\,
      I3 => reset_time_out,
      O => \n_0_time_out_2ms_i_1__0\
    );
time_out_2ms_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000800"
    )
    port map (
      I0 => time_out_counter_reg(17),
      I1 => time_out_counter_reg(18),
      I2 => time_out_counter_reg(10),
      I3 => time_out_counter_reg(12),
      I4 => time_out_counter_reg(5),
      I5 => \n_0_time_out_counter[0]_i_3\,
      O => n_0_time_out_2ms_i_2
    );
time_out_2ms_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => \n_0_time_out_2ms_i_1__0\,
      Q => n_0_time_out_2ms_reg,
      R => '0'
    );
time_out_500us_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000AAAAAAAE"
    )
    port map (
      I0 => n_0_time_out_500us_reg,
      I1 => n_0_time_out_500us_i_2,
      I2 => time_out_counter_reg(17),
      I3 => time_out_counter_reg(18),
      I4 => \n_0_time_out_counter[0]_i_5\,
      I5 => reset_time_out,
      O => n_0_time_out_500us_i_1
    );
time_out_500us_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0040000000000000"
    )
    port map (
      I0 => time_out_counter_reg(12),
      I1 => time_out_counter_reg(10),
      I2 => time_out_counter_reg(5),
      I3 => time_out_counter_reg(11),
      I4 => time_out_counter_reg(15),
      I5 => time_out_counter_reg(16),
      O => n_0_time_out_500us_i_2
    );
time_out_500us_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => n_0_time_out_500us_i_1,
      Q => n_0_time_out_500us_reg,
      R => '0'
    );
\time_out_counter[0]_i_10\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
    port map (
      I0 => time_out_counter_reg(2),
      I1 => time_out_counter_reg(1),
      I2 => time_out_counter_reg(6),
      I3 => time_out_counter_reg(8),
      I4 => time_out_counter_reg(3),
      I5 => time_out_counter_reg(4),
      O => \n_0_time_out_counter[0]_i_10\
    );
\time_out_counter[0]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFBFFFF"
    )
    port map (
      I0 => \n_0_time_out_counter[0]_i_3\,
      I1 => \n_0_time_out_counter[0]_i_4__0\,
      I2 => \n_0_time_out_counter[0]_i_5\,
      I3 => time_out_counter_reg(10),
      I4 => time_out_counter_reg(12),
      I5 => time_out_counter_reg(5),
      O => \n_0_time_out_counter[0]_i_1__0\
    );
\time_out_counter[0]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"EF"
    )
    port map (
      I0 => time_out_counter_reg(16),
      I1 => time_out_counter_reg(15),
      I2 => time_out_counter_reg(11),
      O => \n_0_time_out_counter[0]_i_3\
    );
\time_out_counter[0]_i_4__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => time_out_counter_reg(17),
      I1 => time_out_counter_reg(18),
      O => \n_0_time_out_counter[0]_i_4__0\
    );
\time_out_counter[0]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFDFFFF"
    )
    port map (
      I0 => time_out_counter_reg(7),
      I1 => time_out_counter_reg(14),
      I2 => \n_0_time_out_counter[0]_i_10\,
      I3 => time_out_counter_reg(13),
      I4 => time_out_counter_reg(9),
      I5 => time_out_counter_reg(0),
      O => \n_0_time_out_counter[0]_i_5\
    );
\time_out_counter[0]_i_6\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => time_out_counter_reg(3),
      O => \n_0_time_out_counter[0]_i_6\
    );
\time_out_counter[0]_i_7\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => time_out_counter_reg(2),
      O => \n_0_time_out_counter[0]_i_7\
    );
\time_out_counter[0]_i_8\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => time_out_counter_reg(1),
      O => \n_0_time_out_counter[0]_i_8\
    );
\time_out_counter[0]_i_9\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => time_out_counter_reg(0),
      O => \n_0_time_out_counter[0]_i_9\
    );
\time_out_counter[12]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => time_out_counter_reg(15),
      O => \n_0_time_out_counter[12]_i_2\
    );
\time_out_counter[12]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => time_out_counter_reg(14),
      O => \n_0_time_out_counter[12]_i_3\
    );
\time_out_counter[12]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => time_out_counter_reg(13),
      O => \n_0_time_out_counter[12]_i_4\
    );
\time_out_counter[12]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => time_out_counter_reg(12),
      O => \n_0_time_out_counter[12]_i_5\
    );
\time_out_counter[16]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => time_out_counter_reg(18),
      O => \n_0_time_out_counter[16]_i_2\
    );
\time_out_counter[16]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => time_out_counter_reg(17),
      O => \n_0_time_out_counter[16]_i_3\
    );
\time_out_counter[16]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => time_out_counter_reg(16),
      O => \n_0_time_out_counter[16]_i_4\
    );
\time_out_counter[4]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => time_out_counter_reg(7),
      O => \n_0_time_out_counter[4]_i_2\
    );
\time_out_counter[4]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => time_out_counter_reg(6),
      O => \n_0_time_out_counter[4]_i_3\
    );
\time_out_counter[4]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => time_out_counter_reg(5),
      O => \n_0_time_out_counter[4]_i_4\
    );
\time_out_counter[4]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => time_out_counter_reg(4),
      O => \n_0_time_out_counter[4]_i_5\
    );
\time_out_counter[8]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => time_out_counter_reg(11),
      O => \n_0_time_out_counter[8]_i_2\
    );
\time_out_counter[8]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => time_out_counter_reg(10),
      O => \n_0_time_out_counter[8]_i_3\
    );
\time_out_counter[8]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => time_out_counter_reg(9),
      O => \n_0_time_out_counter[8]_i_4\
    );
\time_out_counter[8]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => time_out_counter_reg(8),
      O => \n_0_time_out_counter[8]_i_5\
    );
\time_out_counter_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_time_out_counter[0]_i_1__0\,
      D => \n_7_time_out_counter_reg[0]_i_2\,
      Q => time_out_counter_reg(0),
      R => reset_time_out
    );
\time_out_counter_reg[0]_i_2\: unisim.vcomponents.CARRY4
    port map (
      CI => '0',
      CO(3) => \n_0_time_out_counter_reg[0]_i_2\,
      CO(2) => \n_1_time_out_counter_reg[0]_i_2\,
      CO(1) => \n_2_time_out_counter_reg[0]_i_2\,
      CO(0) => \n_3_time_out_counter_reg[0]_i_2\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '1',
      O(3) => \n_4_time_out_counter_reg[0]_i_2\,
      O(2) => \n_5_time_out_counter_reg[0]_i_2\,
      O(1) => \n_6_time_out_counter_reg[0]_i_2\,
      O(0) => \n_7_time_out_counter_reg[0]_i_2\,
      S(3) => \n_0_time_out_counter[0]_i_6\,
      S(2) => \n_0_time_out_counter[0]_i_7\,
      S(1) => \n_0_time_out_counter[0]_i_8\,
      S(0) => \n_0_time_out_counter[0]_i_9\
    );
\time_out_counter_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_time_out_counter[0]_i_1__0\,
      D => \n_5_time_out_counter_reg[8]_i_1\,
      Q => time_out_counter_reg(10),
      R => reset_time_out
    );
\time_out_counter_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_time_out_counter[0]_i_1__0\,
      D => \n_4_time_out_counter_reg[8]_i_1\,
      Q => time_out_counter_reg(11),
      R => reset_time_out
    );
\time_out_counter_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_time_out_counter[0]_i_1__0\,
      D => \n_7_time_out_counter_reg[12]_i_1\,
      Q => time_out_counter_reg(12),
      R => reset_time_out
    );
\time_out_counter_reg[12]_i_1\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_time_out_counter_reg[8]_i_1\,
      CO(3) => \n_0_time_out_counter_reg[12]_i_1\,
      CO(2) => \n_1_time_out_counter_reg[12]_i_1\,
      CO(1) => \n_2_time_out_counter_reg[12]_i_1\,
      CO(0) => \n_3_time_out_counter_reg[12]_i_1\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '0',
      O(3) => \n_4_time_out_counter_reg[12]_i_1\,
      O(2) => \n_5_time_out_counter_reg[12]_i_1\,
      O(1) => \n_6_time_out_counter_reg[12]_i_1\,
      O(0) => \n_7_time_out_counter_reg[12]_i_1\,
      S(3) => \n_0_time_out_counter[12]_i_2\,
      S(2) => \n_0_time_out_counter[12]_i_3\,
      S(1) => \n_0_time_out_counter[12]_i_4\,
      S(0) => \n_0_time_out_counter[12]_i_5\
    );
\time_out_counter_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_time_out_counter[0]_i_1__0\,
      D => \n_6_time_out_counter_reg[12]_i_1\,
      Q => time_out_counter_reg(13),
      R => reset_time_out
    );
\time_out_counter_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_time_out_counter[0]_i_1__0\,
      D => \n_5_time_out_counter_reg[12]_i_1\,
      Q => time_out_counter_reg(14),
      R => reset_time_out
    );
\time_out_counter_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_time_out_counter[0]_i_1__0\,
      D => \n_4_time_out_counter_reg[12]_i_1\,
      Q => time_out_counter_reg(15),
      R => reset_time_out
    );
\time_out_counter_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_time_out_counter[0]_i_1__0\,
      D => \n_7_time_out_counter_reg[16]_i_1\,
      Q => time_out_counter_reg(16),
      R => reset_time_out
    );
\time_out_counter_reg[16]_i_1\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_time_out_counter_reg[12]_i_1\,
      CO(3 downto 2) => \NLW_time_out_counter_reg[16]_i_1_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \n_2_time_out_counter_reg[16]_i_1\,
      CO(0) => \n_3_time_out_counter_reg[16]_i_1\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '0',
      O(3) => \NLW_time_out_counter_reg[16]_i_1_O_UNCONNECTED\(3),
      O(2) => \n_5_time_out_counter_reg[16]_i_1\,
      O(1) => \n_6_time_out_counter_reg[16]_i_1\,
      O(0) => \n_7_time_out_counter_reg[16]_i_1\,
      S(3) => '0',
      S(2) => \n_0_time_out_counter[16]_i_2\,
      S(1) => \n_0_time_out_counter[16]_i_3\,
      S(0) => \n_0_time_out_counter[16]_i_4\
    );
\time_out_counter_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_time_out_counter[0]_i_1__0\,
      D => \n_6_time_out_counter_reg[16]_i_1\,
      Q => time_out_counter_reg(17),
      R => reset_time_out
    );
\time_out_counter_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_time_out_counter[0]_i_1__0\,
      D => \n_5_time_out_counter_reg[16]_i_1\,
      Q => time_out_counter_reg(18),
      R => reset_time_out
    );
\time_out_counter_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_time_out_counter[0]_i_1__0\,
      D => \n_6_time_out_counter_reg[0]_i_2\,
      Q => time_out_counter_reg(1),
      R => reset_time_out
    );
\time_out_counter_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_time_out_counter[0]_i_1__0\,
      D => \n_5_time_out_counter_reg[0]_i_2\,
      Q => time_out_counter_reg(2),
      R => reset_time_out
    );
\time_out_counter_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_time_out_counter[0]_i_1__0\,
      D => \n_4_time_out_counter_reg[0]_i_2\,
      Q => time_out_counter_reg(3),
      R => reset_time_out
    );
\time_out_counter_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_time_out_counter[0]_i_1__0\,
      D => \n_7_time_out_counter_reg[4]_i_1\,
      Q => time_out_counter_reg(4),
      R => reset_time_out
    );
\time_out_counter_reg[4]_i_1\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_time_out_counter_reg[0]_i_2\,
      CO(3) => \n_0_time_out_counter_reg[4]_i_1\,
      CO(2) => \n_1_time_out_counter_reg[4]_i_1\,
      CO(1) => \n_2_time_out_counter_reg[4]_i_1\,
      CO(0) => \n_3_time_out_counter_reg[4]_i_1\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '0',
      O(3) => \n_4_time_out_counter_reg[4]_i_1\,
      O(2) => \n_5_time_out_counter_reg[4]_i_1\,
      O(1) => \n_6_time_out_counter_reg[4]_i_1\,
      O(0) => \n_7_time_out_counter_reg[4]_i_1\,
      S(3) => \n_0_time_out_counter[4]_i_2\,
      S(2) => \n_0_time_out_counter[4]_i_3\,
      S(1) => \n_0_time_out_counter[4]_i_4\,
      S(0) => \n_0_time_out_counter[4]_i_5\
    );
\time_out_counter_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_time_out_counter[0]_i_1__0\,
      D => \n_6_time_out_counter_reg[4]_i_1\,
      Q => time_out_counter_reg(5),
      R => reset_time_out
    );
\time_out_counter_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_time_out_counter[0]_i_1__0\,
      D => \n_5_time_out_counter_reg[4]_i_1\,
      Q => time_out_counter_reg(6),
      R => reset_time_out
    );
\time_out_counter_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_time_out_counter[0]_i_1__0\,
      D => \n_4_time_out_counter_reg[4]_i_1\,
      Q => time_out_counter_reg(7),
      R => reset_time_out
    );
\time_out_counter_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_time_out_counter[0]_i_1__0\,
      D => \n_7_time_out_counter_reg[8]_i_1\,
      Q => time_out_counter_reg(8),
      R => reset_time_out
    );
\time_out_counter_reg[8]_i_1\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_time_out_counter_reg[4]_i_1\,
      CO(3) => \n_0_time_out_counter_reg[8]_i_1\,
      CO(2) => \n_1_time_out_counter_reg[8]_i_1\,
      CO(1) => \n_2_time_out_counter_reg[8]_i_1\,
      CO(0) => \n_3_time_out_counter_reg[8]_i_1\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '0',
      O(3) => \n_4_time_out_counter_reg[8]_i_1\,
      O(2) => \n_5_time_out_counter_reg[8]_i_1\,
      O(1) => \n_6_time_out_counter_reg[8]_i_1\,
      O(0) => \n_7_time_out_counter_reg[8]_i_1\,
      S(3) => \n_0_time_out_counter[8]_i_2\,
      S(2) => \n_0_time_out_counter[8]_i_3\,
      S(1) => \n_0_time_out_counter[8]_i_4\,
      S(0) => \n_0_time_out_counter[8]_i_5\
    );
\time_out_counter_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => \n_0_time_out_counter[0]_i_1__0\,
      D => \n_6_time_out_counter_reg[8]_i_1\,
      Q => time_out_counter_reg(9),
      R => reset_time_out
    );
time_out_wait_bypass_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF00FF0100000000"
    )
    port map (
      I0 => \n_0_wait_bypass_count[0]_i_4\,
      I1 => \n_0_wait_bypass_count[0]_i_5\,
      I2 => \n_0_wait_bypass_count[0]_i_6\,
      I3 => n_0_time_out_wait_bypass_reg,
      I4 => tx_fsm_reset_done_int_s3,
      I5 => run_phase_alignment_int_s3,
      O => n_0_time_out_wait_bypass_i_1
    );
time_out_wait_bypass_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I3,
      CE => '1',
      D => n_0_time_out_wait_bypass_i_1,
      Q => n_0_time_out_wait_bypass_reg,
      R => '0'
    );
time_out_wait_bypass_s3_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => time_out_wait_bypass_s2,
      Q => time_out_wait_bypass_s3,
      R => '0'
    );
time_tlock_max_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000AAAAAAAE"
    )
    port map (
      I0 => n_0_time_tlock_max_reg,
      I1 => n_0_time_tlock_max_i_2,
      I2 => time_out_counter_reg(17),
      I3 => time_out_counter_reg(18),
      I4 => n_0_time_tlock_max_i_3,
      I5 => reset_time_out,
      O => n_0_time_tlock_max_i_1
    );
time_tlock_max_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000400000"
    )
    port map (
      I0 => time_out_counter_reg(12),
      I1 => time_out_counter_reg(14),
      I2 => time_out_counter_reg(10),
      I3 => time_out_counter_reg(7),
      I4 => time_out_counter_reg(5),
      I5 => \n_0_time_out_counter[0]_i_3\,
      O => n_0_time_tlock_max_i_2
    );
time_tlock_max_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => time_out_counter_reg(0),
      I1 => time_out_counter_reg(9),
      I2 => time_out_counter_reg(13),
      I3 => \n_0_time_out_counter[0]_i_10\,
      O => n_0_time_tlock_max_i_3
    );
time_tlock_max_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => n_0_time_tlock_max_i_1,
      Q => n_0_time_tlock_max_reg,
      R => '0'
    );
tx_fsm_reset_done_int_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF0008"
    )
    port map (
      I0 => tx_state(3),
      I1 => tx_state(0),
      I2 => tx_state(2),
      I3 => tx_state(1),
      I4 => gt0_txresetdone_out,
      O => n_0_tx_fsm_reset_done_int_i_1
    );
tx_fsm_reset_done_int_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => n_0_tx_fsm_reset_done_int_i_1,
      Q => gt0_txresetdone_out,
      R => AR(0)
    );
tx_fsm_reset_done_int_s3_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I3,
      CE => '1',
      D => tx_fsm_reset_done_int_s2,
      Q => tx_fsm_reset_done_int_s3,
      R => '0'
    );
txresetdone_s3_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => txresetdone_s2,
      Q => txresetdone_s3,
      R => '0'
    );
\wait_bypass_count[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => run_phase_alignment_int_s3,
      O => \n_0_wait_bypass_count[0]_i_1\
    );
\wait_bypass_count[0]_i_10\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => wait_bypass_count_reg(0),
      O => \n_0_wait_bypass_count[0]_i_10\
    );
\wait_bypass_count[0]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00FE"
    )
    port map (
      I0 => \n_0_wait_bypass_count[0]_i_4\,
      I1 => \n_0_wait_bypass_count[0]_i_5\,
      I2 => \n_0_wait_bypass_count[0]_i_6\,
      I3 => tx_fsm_reset_done_int_s3,
      O => \n_0_wait_bypass_count[0]_i_2\
    );
\wait_bypass_count[0]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BFFFFFFF"
    )
    port map (
      I0 => wait_bypass_count_reg(15),
      I1 => wait_bypass_count_reg(1),
      I2 => wait_bypass_count_reg(2),
      I3 => wait_bypass_count_reg(16),
      I4 => wait_bypass_count_reg(0),
      O => \n_0_wait_bypass_count[0]_i_4\
    );
\wait_bypass_count[0]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFDFFFFFFFFFF"
    )
    port map (
      I0 => wait_bypass_count_reg(9),
      I1 => wait_bypass_count_reg(10),
      I2 => wait_bypass_count_reg(13),
      I3 => wait_bypass_count_reg(14),
      I4 => wait_bypass_count_reg(11),
      I5 => wait_bypass_count_reg(12),
      O => \n_0_wait_bypass_count[0]_i_5\
    );
\wait_bypass_count[0]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F7FFFFFFFFFFFFFF"
    )
    port map (
      I0 => wait_bypass_count_reg(4),
      I1 => wait_bypass_count_reg(3),
      I2 => wait_bypass_count_reg(8),
      I3 => wait_bypass_count_reg(7),
      I4 => wait_bypass_count_reg(5),
      I5 => wait_bypass_count_reg(6),
      O => \n_0_wait_bypass_count[0]_i_6\
    );
\wait_bypass_count[0]_i_7\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => wait_bypass_count_reg(3),
      O => \n_0_wait_bypass_count[0]_i_7\
    );
\wait_bypass_count[0]_i_8\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => wait_bypass_count_reg(2),
      O => \n_0_wait_bypass_count[0]_i_8\
    );
\wait_bypass_count[0]_i_9__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => wait_bypass_count_reg(1),
      O => \n_0_wait_bypass_count[0]_i_9__0\
    );
\wait_bypass_count[12]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => wait_bypass_count_reg(15),
      O => \n_0_wait_bypass_count[12]_i_2\
    );
\wait_bypass_count[12]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => wait_bypass_count_reg(14),
      O => \n_0_wait_bypass_count[12]_i_3\
    );
\wait_bypass_count[12]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => wait_bypass_count_reg(13),
      O => \n_0_wait_bypass_count[12]_i_4\
    );
\wait_bypass_count[12]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => wait_bypass_count_reg(12),
      O => \n_0_wait_bypass_count[12]_i_5\
    );
\wait_bypass_count[16]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => wait_bypass_count_reg(16),
      O => \n_0_wait_bypass_count[16]_i_2\
    );
\wait_bypass_count[4]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => wait_bypass_count_reg(7),
      O => \n_0_wait_bypass_count[4]_i_2\
    );
\wait_bypass_count[4]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => wait_bypass_count_reg(6),
      O => \n_0_wait_bypass_count[4]_i_3\
    );
\wait_bypass_count[4]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => wait_bypass_count_reg(5),
      O => \n_0_wait_bypass_count[4]_i_4\
    );
\wait_bypass_count[4]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => wait_bypass_count_reg(4),
      O => \n_0_wait_bypass_count[4]_i_5\
    );
\wait_bypass_count[8]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => wait_bypass_count_reg(11),
      O => \n_0_wait_bypass_count[8]_i_2\
    );
\wait_bypass_count[8]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => wait_bypass_count_reg(10),
      O => \n_0_wait_bypass_count[8]_i_3\
    );
\wait_bypass_count[8]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => wait_bypass_count_reg(9),
      O => \n_0_wait_bypass_count[8]_i_4\
    );
\wait_bypass_count[8]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => wait_bypass_count_reg(8),
      O => \n_0_wait_bypass_count[8]_i_5\
    );
\wait_bypass_count_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \n_0_wait_bypass_count[0]_i_2\,
      D => \n_7_wait_bypass_count_reg[0]_i_3\,
      Q => wait_bypass_count_reg(0),
      R => \n_0_wait_bypass_count[0]_i_1\
    );
\wait_bypass_count_reg[0]_i_3\: unisim.vcomponents.CARRY4
    port map (
      CI => '0',
      CO(3) => \n_0_wait_bypass_count_reg[0]_i_3\,
      CO(2) => \n_1_wait_bypass_count_reg[0]_i_3\,
      CO(1) => \n_2_wait_bypass_count_reg[0]_i_3\,
      CO(0) => \n_3_wait_bypass_count_reg[0]_i_3\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '1',
      O(3) => \n_4_wait_bypass_count_reg[0]_i_3\,
      O(2) => \n_5_wait_bypass_count_reg[0]_i_3\,
      O(1) => \n_6_wait_bypass_count_reg[0]_i_3\,
      O(0) => \n_7_wait_bypass_count_reg[0]_i_3\,
      S(3) => \n_0_wait_bypass_count[0]_i_7\,
      S(2) => \n_0_wait_bypass_count[0]_i_8\,
      S(1) => \n_0_wait_bypass_count[0]_i_9__0\,
      S(0) => \n_0_wait_bypass_count[0]_i_10\
    );
\wait_bypass_count_reg[10]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \n_0_wait_bypass_count[0]_i_2\,
      D => \n_5_wait_bypass_count_reg[8]_i_1\,
      Q => wait_bypass_count_reg(10),
      R => \n_0_wait_bypass_count[0]_i_1\
    );
\wait_bypass_count_reg[11]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \n_0_wait_bypass_count[0]_i_2\,
      D => \n_4_wait_bypass_count_reg[8]_i_1\,
      Q => wait_bypass_count_reg(11),
      R => \n_0_wait_bypass_count[0]_i_1\
    );
\wait_bypass_count_reg[12]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \n_0_wait_bypass_count[0]_i_2\,
      D => \n_7_wait_bypass_count_reg[12]_i_1\,
      Q => wait_bypass_count_reg(12),
      R => \n_0_wait_bypass_count[0]_i_1\
    );
\wait_bypass_count_reg[12]_i_1\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_wait_bypass_count_reg[8]_i_1\,
      CO(3) => \n_0_wait_bypass_count_reg[12]_i_1\,
      CO(2) => \n_1_wait_bypass_count_reg[12]_i_1\,
      CO(1) => \n_2_wait_bypass_count_reg[12]_i_1\,
      CO(0) => \n_3_wait_bypass_count_reg[12]_i_1\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '0',
      O(3) => \n_4_wait_bypass_count_reg[12]_i_1\,
      O(2) => \n_5_wait_bypass_count_reg[12]_i_1\,
      O(1) => \n_6_wait_bypass_count_reg[12]_i_1\,
      O(0) => \n_7_wait_bypass_count_reg[12]_i_1\,
      S(3) => \n_0_wait_bypass_count[12]_i_2\,
      S(2) => \n_0_wait_bypass_count[12]_i_3\,
      S(1) => \n_0_wait_bypass_count[12]_i_4\,
      S(0) => \n_0_wait_bypass_count[12]_i_5\
    );
\wait_bypass_count_reg[13]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \n_0_wait_bypass_count[0]_i_2\,
      D => \n_6_wait_bypass_count_reg[12]_i_1\,
      Q => wait_bypass_count_reg(13),
      R => \n_0_wait_bypass_count[0]_i_1\
    );
\wait_bypass_count_reg[14]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \n_0_wait_bypass_count[0]_i_2\,
      D => \n_5_wait_bypass_count_reg[12]_i_1\,
      Q => wait_bypass_count_reg(14),
      R => \n_0_wait_bypass_count[0]_i_1\
    );
\wait_bypass_count_reg[15]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \n_0_wait_bypass_count[0]_i_2\,
      D => \n_4_wait_bypass_count_reg[12]_i_1\,
      Q => wait_bypass_count_reg(15),
      R => \n_0_wait_bypass_count[0]_i_1\
    );
\wait_bypass_count_reg[16]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \n_0_wait_bypass_count[0]_i_2\,
      D => \n_7_wait_bypass_count_reg[16]_i_1\,
      Q => wait_bypass_count_reg(16),
      R => \n_0_wait_bypass_count[0]_i_1\
    );
\wait_bypass_count_reg[16]_i_1\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_wait_bypass_count_reg[12]_i_1\,
      CO(3 downto 0) => \NLW_wait_bypass_count_reg[16]_i_1_CO_UNCONNECTED\(3 downto 0),
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '0',
      O(3 downto 1) => \NLW_wait_bypass_count_reg[16]_i_1_O_UNCONNECTED\(3 downto 1),
      O(0) => \n_7_wait_bypass_count_reg[16]_i_1\,
      S(3) => '0',
      S(2) => '0',
      S(1) => '0',
      S(0) => \n_0_wait_bypass_count[16]_i_2\
    );
\wait_bypass_count_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \n_0_wait_bypass_count[0]_i_2\,
      D => \n_6_wait_bypass_count_reg[0]_i_3\,
      Q => wait_bypass_count_reg(1),
      R => \n_0_wait_bypass_count[0]_i_1\
    );
\wait_bypass_count_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \n_0_wait_bypass_count[0]_i_2\,
      D => \n_5_wait_bypass_count_reg[0]_i_3\,
      Q => wait_bypass_count_reg(2),
      R => \n_0_wait_bypass_count[0]_i_1\
    );
\wait_bypass_count_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \n_0_wait_bypass_count[0]_i_2\,
      D => \n_4_wait_bypass_count_reg[0]_i_3\,
      Q => wait_bypass_count_reg(3),
      R => \n_0_wait_bypass_count[0]_i_1\
    );
\wait_bypass_count_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \n_0_wait_bypass_count[0]_i_2\,
      D => \n_7_wait_bypass_count_reg[4]_i_1\,
      Q => wait_bypass_count_reg(4),
      R => \n_0_wait_bypass_count[0]_i_1\
    );
\wait_bypass_count_reg[4]_i_1\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_wait_bypass_count_reg[0]_i_3\,
      CO(3) => \n_0_wait_bypass_count_reg[4]_i_1\,
      CO(2) => \n_1_wait_bypass_count_reg[4]_i_1\,
      CO(1) => \n_2_wait_bypass_count_reg[4]_i_1\,
      CO(0) => \n_3_wait_bypass_count_reg[4]_i_1\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '0',
      O(3) => \n_4_wait_bypass_count_reg[4]_i_1\,
      O(2) => \n_5_wait_bypass_count_reg[4]_i_1\,
      O(1) => \n_6_wait_bypass_count_reg[4]_i_1\,
      O(0) => \n_7_wait_bypass_count_reg[4]_i_1\,
      S(3) => \n_0_wait_bypass_count[4]_i_2\,
      S(2) => \n_0_wait_bypass_count[4]_i_3\,
      S(1) => \n_0_wait_bypass_count[4]_i_4\,
      S(0) => \n_0_wait_bypass_count[4]_i_5\
    );
\wait_bypass_count_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \n_0_wait_bypass_count[0]_i_2\,
      D => \n_6_wait_bypass_count_reg[4]_i_1\,
      Q => wait_bypass_count_reg(5),
      R => \n_0_wait_bypass_count[0]_i_1\
    );
\wait_bypass_count_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \n_0_wait_bypass_count[0]_i_2\,
      D => \n_5_wait_bypass_count_reg[4]_i_1\,
      Q => wait_bypass_count_reg(6),
      R => \n_0_wait_bypass_count[0]_i_1\
    );
\wait_bypass_count_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \n_0_wait_bypass_count[0]_i_2\,
      D => \n_4_wait_bypass_count_reg[4]_i_1\,
      Q => wait_bypass_count_reg(7),
      R => \n_0_wait_bypass_count[0]_i_1\
    );
\wait_bypass_count_reg[8]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \n_0_wait_bypass_count[0]_i_2\,
      D => \n_7_wait_bypass_count_reg[8]_i_1\,
      Q => wait_bypass_count_reg(8),
      R => \n_0_wait_bypass_count[0]_i_1\
    );
\wait_bypass_count_reg[8]_i_1\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_wait_bypass_count_reg[4]_i_1\,
      CO(3) => \n_0_wait_bypass_count_reg[8]_i_1\,
      CO(2) => \n_1_wait_bypass_count_reg[8]_i_1\,
      CO(1) => \n_2_wait_bypass_count_reg[8]_i_1\,
      CO(0) => \n_3_wait_bypass_count_reg[8]_i_1\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '0',
      O(3) => \n_4_wait_bypass_count_reg[8]_i_1\,
      O(2) => \n_5_wait_bypass_count_reg[8]_i_1\,
      O(1) => \n_6_wait_bypass_count_reg[8]_i_1\,
      O(0) => \n_7_wait_bypass_count_reg[8]_i_1\,
      S(3) => \n_0_wait_bypass_count[8]_i_2\,
      S(2) => \n_0_wait_bypass_count[8]_i_3\,
      S(1) => \n_0_wait_bypass_count[8]_i_4\,
      S(0) => \n_0_wait_bypass_count[8]_i_5\
    );
\wait_bypass_count_reg[9]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \n_0_wait_bypass_count[0]_i_2\,
      D => \n_6_wait_bypass_count_reg[8]_i_1\,
      Q => wait_bypass_count_reg(9),
      R => \n_0_wait_bypass_count[0]_i_1\
    );
\wait_time_cnt[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \wait_time_cnt_reg__0\(0),
      O => wait_time_cnt0(0)
    );
\wait_time_cnt[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => \wait_time_cnt_reg__0\(1),
      I1 => \wait_time_cnt_reg__0\(0),
      O => wait_time_cnt0(1)
    );
\wait_time_cnt[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"A9"
    )
    port map (
      I0 => \wait_time_cnt_reg__0\(2),
      I1 => \wait_time_cnt_reg__0\(0),
      I2 => \wait_time_cnt_reg__0\(1),
      O => wait_time_cnt0(2)
    );
\wait_time_cnt[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AAA9"
    )
    port map (
      I0 => \wait_time_cnt_reg__0\(3),
      I1 => \wait_time_cnt_reg__0\(1),
      I2 => \wait_time_cnt_reg__0\(0),
      I3 => \wait_time_cnt_reg__0\(2),
      O => wait_time_cnt0(3)
    );
\wait_time_cnt[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAAAAAA9"
    )
    port map (
      I0 => \wait_time_cnt_reg__0\(4),
      I1 => \wait_time_cnt_reg__0\(2),
      I2 => \wait_time_cnt_reg__0\(0),
      I3 => \wait_time_cnt_reg__0\(1),
      I4 => \wait_time_cnt_reg__0\(3),
      O => wait_time_cnt0(4)
    );
\wait_time_cnt[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAAAAAAAAAAA9"
    )
    port map (
      I0 => \wait_time_cnt_reg__0\(5),
      I1 => \wait_time_cnt_reg__0\(3),
      I2 => \wait_time_cnt_reg__0\(1),
      I3 => \wait_time_cnt_reg__0\(0),
      I4 => \wait_time_cnt_reg__0\(2),
      I5 => \wait_time_cnt_reg__0\(4),
      O => wait_time_cnt0(5)
    );
\wait_time_cnt[6]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"020A"
    )
    port map (
      I0 => tx_state(0),
      I1 => tx_state(2),
      I2 => tx_state(3),
      I3 => tx_state(1),
      O => clear
    );
\wait_time_cnt[6]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \n_0_wait_time_cnt[6]_i_4\,
      I1 => \wait_time_cnt_reg__0\(6),
      O => \n_0_wait_time_cnt[6]_i_2\
    );
\wait_time_cnt[6]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => \wait_time_cnt_reg__0\(6),
      I1 => \n_0_wait_time_cnt[6]_i_4\,
      O => wait_time_cnt0(6)
    );
\wait_time_cnt[6]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
    port map (
      I0 => \wait_time_cnt_reg__0\(4),
      I1 => \wait_time_cnt_reg__0\(2),
      I2 => \wait_time_cnt_reg__0\(0),
      I3 => \wait_time_cnt_reg__0\(1),
      I4 => \wait_time_cnt_reg__0\(3),
      I5 => \wait_time_cnt_reg__0\(5),
      O => \n_0_wait_time_cnt[6]_i_4\
    );
\wait_time_cnt_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => \n_0_wait_time_cnt[6]_i_2\,
      D => wait_time_cnt0(0),
      Q => \wait_time_cnt_reg__0\(0),
      R => clear
    );
\wait_time_cnt_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => \n_0_wait_time_cnt[6]_i_2\,
      D => wait_time_cnt0(1),
      Q => \wait_time_cnt_reg__0\(1),
      R => clear
    );
\wait_time_cnt_reg[2]\: unisim.vcomponents.FDSE
    port map (
      C => independent_clock_bufg,
      CE => \n_0_wait_time_cnt[6]_i_2\,
      D => wait_time_cnt0(2),
      Q => \wait_time_cnt_reg__0\(2),
      S => clear
    );
\wait_time_cnt_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => \n_0_wait_time_cnt[6]_i_2\,
      D => wait_time_cnt0(3),
      Q => \wait_time_cnt_reg__0\(3),
      R => clear
    );
\wait_time_cnt_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => \n_0_wait_time_cnt[6]_i_2\,
      D => wait_time_cnt0(4),
      Q => \wait_time_cnt_reg__0\(4),
      R => clear
    );
\wait_time_cnt_reg[5]\: unisim.vcomponents.FDSE
    port map (
      C => independent_clock_bufg,
      CE => \n_0_wait_time_cnt[6]_i_2\,
      D => wait_time_cnt0(5),
      Q => \wait_time_cnt_reg__0\(5),
      S => clear
    );
\wait_time_cnt_reg[6]\: unisim.vcomponents.FDSE
    port map (
      C => independent_clock_bufg,
      CE => \n_0_wait_time_cnt[6]_i_2\,
      D => wait_time_cnt0(6),
      Q => \wait_time_cnt_reg__0\(6),
      S => clear
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gmii_to_sgmii_gmii_to_sgmii_clk_gen is
  port (
    sgmii_clk_r : out STD_LOGIC;
    O1 : out STD_LOGIC;
    sgmii_clk_f : out STD_LOGIC;
    data_out : in STD_LOGIC;
    CLK : in STD_LOGIC;
    I1 : in STD_LOGIC;
    reset_out : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of gmii_to_sgmii_gmii_to_sgmii_clk_gen : entity is "gmii_to_sgmii_clk_gen";
end gmii_to_sgmii_gmii_to_sgmii_clk_gen;

architecture STRUCTURE of gmii_to_sgmii_gmii_to_sgmii_clk_gen is
  signal clk12_5_reg : STD_LOGIC;
  signal clk1_25_reg : STD_LOGIC;
  signal clk_div10 : STD_LOGIC;
  signal clk_en : STD_LOGIC;
  signal clk_en_12_5_fall : STD_LOGIC;
  signal clk_en_1_25_fall : STD_LOGIC;
  signal n_0_clk_div_stage2 : STD_LOGIC;
  signal n_0_sgmii_clk_en_i_1 : STD_LOGIC;
  signal n_1_clk_div_stage1 : STD_LOGIC;
  signal n_1_clk_div_stage2 : STD_LOGIC;
  signal n_2_clk_div_stage1 : STD_LOGIC;
  signal n_3_clk_div_stage1 : STD_LOGIC;
  signal reset_fall : STD_LOGIC;
  signal sgmii_clk_r0_out : STD_LOGIC;
  signal speed_is_100_fall : STD_LOGIC;
  signal speed_is_10_100_fall : STD_LOGIC;
begin
clk12_5_reg_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => clk_div10,
      Q => clk12_5_reg,
      R => reset_out
    );
clk1_25_reg_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => n_0_clk_div_stage2,
      Q => clk1_25_reg,
      R => reset_out
    );
clk_div_stage1: entity work.gmii_to_sgmii_gmii_to_sgmii_johnson_cntr
    port map (
      CLK => CLK,
      I1 => n_0_clk_div_stage2,
      O1 => n_1_clk_div_stage1,
      O2 => n_2_clk_div_stage1,
      O3 => n_3_clk_div_stage1,
      clk12_5_reg => clk12_5_reg,
      clk_div10 => clk_div10,
      reset_fall => reset_fall,
      reset_out => reset_out,
      speed_is_100_fall => speed_is_100_fall,
      speed_is_10_100_fall => speed_is_10_100_fall
    );
clk_div_stage2: entity work.gmii_to_sgmii_gmii_to_sgmii_johnson_cntr_35
    port map (
      CLK => CLK,
      I1 => I1,
      O1 => n_0_clk_div_stage2,
      O2 => n_1_clk_div_stage2,
      clk1_25_reg => clk1_25_reg,
      clk_div10 => clk_div10,
      clk_en => clk_en,
      data_out => data_out,
      reset_out => reset_out,
      sgmii_clk_r0_out => sgmii_clk_r0_out
    );
clk_en_12_5_fall_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => n_1_clk_div_stage1,
      Q => clk_en_12_5_fall,
      R => reset_out
    );
clk_en_12_5_rise_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => n_2_clk_div_stage1,
      Q => clk_en,
      R => reset_out
    );
clk_en_1_25_fall_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => n_1_clk_div_stage2,
      Q => clk_en_1_25_fall,
      R => reset_out
    );
reset_fall_reg: unisim.vcomponents.FDRE
    generic map(
      IS_C_INVERTED => '1'
    )
    port map (
      C => CLK,
      CE => '1',
      D => reset_out,
      Q => reset_fall,
      R => '0'
    );
sgmii_clk_en_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"E2FF"
    )
    port map (
      I0 => clk_en_1_25_fall,
      I1 => data_out,
      I2 => clk_en_12_5_fall,
      I3 => I1,
      O => n_0_sgmii_clk_en_i_1
    );
sgmii_clk_en_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => n_0_sgmii_clk_en_i_1,
      Q => O1,
      R => reset_out
    );
sgmii_clk_f_reg: unisim.vcomponents.FDRE
    generic map(
      IS_C_INVERTED => '1'
    )
    port map (
      C => CLK,
      CE => '1',
      D => n_3_clk_div_stage1,
      Q => sgmii_clk_f,
      R => '0'
    );
sgmii_clk_r_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => sgmii_clk_r0_out,
      Q => sgmii_clk_r,
      R => reset_out
    );
speed_is_100_fall_reg: unisim.vcomponents.FDRE
    generic map(
      IS_C_INVERTED => '1'
    )
    port map (
      C => CLK,
      CE => '1',
      D => data_out,
      Q => speed_is_100_fall,
      R => '0'
    );
speed_is_10_100_fall_reg: unisim.vcomponents.FDRE
    generic map(
      IS_C_INVERTED => '1'
    )
    port map (
      C => CLK,
      CE => '1',
      D => I1,
      Q => speed_is_10_100_fall,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gmii_to_sgmii_gmii_to_sgmii_gtwizard_gtrxreset_seq is
  port (
    GTRXRESET_OUT : out STD_LOGIC;
    DRPADDR : out STD_LOGIC_VECTOR ( 0 to 0 );
    O1 : out STD_LOGIC;
    DRPDI : out STD_LOGIC_VECTOR ( 15 downto 0 );
    O2 : out STD_LOGIC;
    CLK : in STD_LOGIC;
    I1 : in STD_LOGIC;
    data_in : in STD_LOGIC;
    I2 : in STD_LOGIC;
    CPLL_RESET : in STD_LOGIC;
    D : in STD_LOGIC_VECTOR ( 15 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of gmii_to_sgmii_gmii_to_sgmii_gtwizard_gtrxreset_seq : entity is "gmii_to_sgmii_gtwizard_gtrxreset_seq";
end gmii_to_sgmii_gmii_to_sgmii_gtwizard_gtrxreset_seq;

architecture STRUCTURE of gmii_to_sgmii_gmii_to_sgmii_gtwizard_gtrxreset_seq is
  signal DRP_OP_DONE : STD_LOGIC;
  signal data_out : STD_LOGIC;
  signal flag : STD_LOGIC;
  signal gtrxreset_i : STD_LOGIC;
  signal gtrxreset_s : STD_LOGIC;
  signal gtrxreset_ss : STD_LOGIC;
  signal n_0_drp_op_done_o_i_1 : STD_LOGIC;
  signal n_0_flag_i_1 : STD_LOGIC;
  signal \n_0_rd_data[0]_i_1\ : STD_LOGIC;
  signal \n_0_rd_data[10]_i_1\ : STD_LOGIC;
  signal \n_0_rd_data[11]_i_1\ : STD_LOGIC;
  signal \n_0_rd_data[12]_i_1\ : STD_LOGIC;
  signal \n_0_rd_data[13]_i_1\ : STD_LOGIC;
  signal \n_0_rd_data[14]_i_1\ : STD_LOGIC;
  signal \n_0_rd_data[15]_i_1\ : STD_LOGIC;
  signal \n_0_rd_data[15]_i_2\ : STD_LOGIC;
  signal \n_0_rd_data[1]_i_1\ : STD_LOGIC;
  signal \n_0_rd_data[2]_i_1\ : STD_LOGIC;
  signal \n_0_rd_data[3]_i_1\ : STD_LOGIC;
  signal \n_0_rd_data[4]_i_1\ : STD_LOGIC;
  signal \n_0_rd_data[5]_i_1\ : STD_LOGIC;
  signal \n_0_rd_data[6]_i_1\ : STD_LOGIC;
  signal \n_0_rd_data[7]_i_1\ : STD_LOGIC;
  signal \n_0_rd_data[8]_i_1\ : STD_LOGIC;
  signal \n_0_rd_data[9]_i_1\ : STD_LOGIC;
  signal \n_0_state[0]_i_2\ : STD_LOGIC;
  signal \n_0_state_reg[0]\ : STD_LOGIC;
  signal \n_0_state_reg[1]\ : STD_LOGIC;
  signal \n_0_state_reg[2]\ : STD_LOGIC;
  signal n_0_sync_rst_sync : STD_LOGIC;
  signal next_state : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal original_rd_data : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal original_rd_data0 : STD_LOGIC;
  signal rd_data : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal reset_out : STD_LOGIC;
  signal rxpmaresetdone_s : STD_LOGIC;
  signal rxpmaresetdone_ss : STD_LOGIC;
  signal rxpmaresetdone_sss : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of drp_op_done_o_i_1 : label is "soft_lutpair107";
  attribute SOFT_HLUTNM of gthe2_i_i_15 : label is "soft_lutpair109";
  attribute SOFT_HLUTNM of gthe2_i_i_2 : label is "soft_lutpair107";
  attribute SOFT_HLUTNM of gthe2_i_i_21 : label is "soft_lutpair109";
  attribute SOFT_HLUTNM of gthe2_i_i_3 : label is "soft_lutpair108";
  attribute SOFT_HLUTNM of gthe2_i_i_6 : label is "soft_lutpair108";
  attribute SOFT_HLUTNM of gtrxreset_o_i_1 : label is "soft_lutpair110";
  attribute SOFT_HLUTNM of \state[2]_i_1\ : label is "soft_lutpair110";
begin
drp_op_done_o_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF8000"
    )
    port map (
      I0 => \n_0_state_reg[0]\,
      I1 => I1,
      I2 => \n_0_state_reg[1]\,
      I3 => \n_0_state_reg[2]\,
      I4 => DRP_OP_DONE,
      O => n_0_drp_op_done_o_i_1
    );
drp_op_done_o_reg: unisim.vcomponents.FDCE
    port map (
      C => CLK,
      CE => '1',
      CLR => gtrxreset_ss,
      D => n_0_drp_op_done_o_i_1,
      Q => DRP_OP_DONE
    );
flag_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3FEA"
    )
    port map (
      I0 => flag,
      I1 => \n_0_state_reg[1]\,
      I2 => \n_0_state_reg[0]\,
      I3 => \n_0_state_reg[2]\,
      O => n_0_flag_i_1
    );
flag_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => n_0_flag_i_1,
      Q => flag,
      R => '0'
    );
gthe2_i_i_10: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000880"
    )
    port map (
      I0 => rd_data(10),
      I1 => \n_0_state_reg[1]\,
      I2 => \n_0_state_reg[0]\,
      I3 => \n_0_state_reg[2]\,
      I4 => DRP_OP_DONE,
      O => DRPDI(10)
    );
gthe2_i_i_11: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000880"
    )
    port map (
      I0 => rd_data(9),
      I1 => \n_0_state_reg[1]\,
      I2 => \n_0_state_reg[0]\,
      I3 => \n_0_state_reg[2]\,
      I4 => DRP_OP_DONE,
      O => DRPDI(9)
    );
gthe2_i_i_12: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000880"
    )
    port map (
      I0 => rd_data(8),
      I1 => \n_0_state_reg[1]\,
      I2 => \n_0_state_reg[0]\,
      I3 => \n_0_state_reg[2]\,
      I4 => DRP_OP_DONE,
      O => DRPDI(8)
    );
gthe2_i_i_13: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000880"
    )
    port map (
      I0 => rd_data(7),
      I1 => \n_0_state_reg[1]\,
      I2 => \n_0_state_reg[0]\,
      I3 => \n_0_state_reg[2]\,
      I4 => DRP_OP_DONE,
      O => DRPDI(7)
    );
gthe2_i_i_14: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000880"
    )
    port map (
      I0 => rd_data(6),
      I1 => \n_0_state_reg[1]\,
      I2 => \n_0_state_reg[0]\,
      I3 => \n_0_state_reg[2]\,
      I4 => DRP_OP_DONE,
      O => DRPDI(6)
    );
gthe2_i_i_15: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000880"
    )
    port map (
      I0 => rd_data(5),
      I1 => \n_0_state_reg[1]\,
      I2 => \n_0_state_reg[0]\,
      I3 => \n_0_state_reg[2]\,
      I4 => DRP_OP_DONE,
      O => DRPDI(5)
    );
gthe2_i_i_16: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000880"
    )
    port map (
      I0 => rd_data(4),
      I1 => \n_0_state_reg[1]\,
      I2 => \n_0_state_reg[0]\,
      I3 => \n_0_state_reg[2]\,
      I4 => DRP_OP_DONE,
      O => DRPDI(4)
    );
gthe2_i_i_17: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000880"
    )
    port map (
      I0 => rd_data(3),
      I1 => \n_0_state_reg[1]\,
      I2 => \n_0_state_reg[0]\,
      I3 => \n_0_state_reg[2]\,
      I4 => DRP_OP_DONE,
      O => DRPDI(3)
    );
gthe2_i_i_18: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000880"
    )
    port map (
      I0 => rd_data(2),
      I1 => \n_0_state_reg[1]\,
      I2 => \n_0_state_reg[0]\,
      I3 => \n_0_state_reg[2]\,
      I4 => DRP_OP_DONE,
      O => DRPDI(2)
    );
gthe2_i_i_19: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000880"
    )
    port map (
      I0 => rd_data(1),
      I1 => \n_0_state_reg[1]\,
      I2 => \n_0_state_reg[0]\,
      I3 => \n_0_state_reg[2]\,
      I4 => DRP_OP_DONE,
      O => DRPDI(1)
    );
gthe2_i_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0062"
    )
    port map (
      I0 => \n_0_state_reg[0]\,
      I1 => \n_0_state_reg[2]\,
      I2 => \n_0_state_reg[1]\,
      I3 => DRP_OP_DONE,
      O => O1
    );
gthe2_i_i_20: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000880"
    )
    port map (
      I0 => rd_data(0),
      I1 => \n_0_state_reg[1]\,
      I2 => \n_0_state_reg[0]\,
      I3 => \n_0_state_reg[2]\,
      I4 => DRP_OP_DONE,
      O => DRPDI(0)
    );
gthe2_i_i_21: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => DRP_OP_DONE,
      O => DRPADDR(0)
    );
gthe2_i_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0028"
    )
    port map (
      I0 => \n_0_state_reg[1]\,
      I1 => \n_0_state_reg[0]\,
      I2 => \n_0_state_reg[2]\,
      I3 => DRP_OP_DONE,
      O => O2
    );
gthe2_i_i_5: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000880"
    )
    port map (
      I0 => rd_data(15),
      I1 => \n_0_state_reg[1]\,
      I2 => \n_0_state_reg[0]\,
      I3 => \n_0_state_reg[2]\,
      I4 => DRP_OP_DONE,
      O => DRPDI(15)
    );
gthe2_i_i_6: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000880"
    )
    port map (
      I0 => rd_data(14),
      I1 => \n_0_state_reg[1]\,
      I2 => \n_0_state_reg[0]\,
      I3 => \n_0_state_reg[2]\,
      I4 => DRP_OP_DONE,
      O => DRPDI(14)
    );
gthe2_i_i_7: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000880"
    )
    port map (
      I0 => rd_data(13),
      I1 => \n_0_state_reg[1]\,
      I2 => \n_0_state_reg[0]\,
      I3 => \n_0_state_reg[2]\,
      I4 => DRP_OP_DONE,
      O => DRPDI(13)
    );
gthe2_i_i_8: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000880"
    )
    port map (
      I0 => rd_data(12),
      I1 => \n_0_state_reg[1]\,
      I2 => \n_0_state_reg[0]\,
      I3 => \n_0_state_reg[2]\,
      I4 => DRP_OP_DONE,
      O => DRPDI(12)
    );
gthe2_i_i_9: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00004000"
    )
    port map (
      I0 => \n_0_state_reg[0]\,
      I1 => \n_0_state_reg[2]\,
      I2 => \n_0_state_reg[1]\,
      I3 => rd_data(11),
      I4 => DRP_OP_DONE,
      O => DRPDI(11)
    );
gtrxreset_o_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F3C"
    )
    port map (
      I0 => gtrxreset_ss,
      I1 => \n_0_state_reg[1]\,
      I2 => \n_0_state_reg[2]\,
      I3 => \n_0_state_reg[0]\,
      O => gtrxreset_i
    );
gtrxreset_o_reg: unisim.vcomponents.FDCE
    port map (
      C => CLK,
      CE => '1',
      CLR => n_0_sync_rst_sync,
      D => gtrxreset_i,
      Q => GTRXRESET_OUT
    );
gtrxreset_s_reg: unisim.vcomponents.FDCE
    port map (
      C => CLK,
      CE => '1',
      CLR => n_0_sync_rst_sync,
      D => reset_out,
      Q => gtrxreset_s
    );
gtrxreset_ss_reg: unisim.vcomponents.FDCE
    port map (
      C => CLK,
      CE => '1',
      CLR => n_0_sync_rst_sync,
      D => gtrxreset_s,
      Q => gtrxreset_ss
    );
\original_rd_data[15]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000020"
    )
    port map (
      I0 => I1,
      I1 => \n_0_state_reg[0]\,
      I2 => \n_0_state_reg[1]\,
      I3 => \n_0_state_reg[2]\,
      I4 => flag,
      O => original_rd_data0
    );
\original_rd_data_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => original_rd_data0,
      D => D(0),
      Q => original_rd_data(0),
      R => '0'
    );
\original_rd_data_reg[10]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => original_rd_data0,
      D => D(10),
      Q => original_rd_data(10),
      R => '0'
    );
\original_rd_data_reg[11]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => original_rd_data0,
      D => D(11),
      Q => original_rd_data(11),
      R => '0'
    );
\original_rd_data_reg[12]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => original_rd_data0,
      D => D(12),
      Q => original_rd_data(12),
      R => '0'
    );
\original_rd_data_reg[13]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => original_rd_data0,
      D => D(13),
      Q => original_rd_data(13),
      R => '0'
    );
\original_rd_data_reg[14]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => original_rd_data0,
      D => D(14),
      Q => original_rd_data(14),
      R => '0'
    );
\original_rd_data_reg[15]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => original_rd_data0,
      D => D(15),
      Q => original_rd_data(15),
      R => '0'
    );
\original_rd_data_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => original_rd_data0,
      D => D(1),
      Q => original_rd_data(1),
      R => '0'
    );
\original_rd_data_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => original_rd_data0,
      D => D(2),
      Q => original_rd_data(2),
      R => '0'
    );
\original_rd_data_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => original_rd_data0,
      D => D(3),
      Q => original_rd_data(3),
      R => '0'
    );
\original_rd_data_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => original_rd_data0,
      D => D(4),
      Q => original_rd_data(4),
      R => '0'
    );
\original_rd_data_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => original_rd_data0,
      D => D(5),
      Q => original_rd_data(5),
      R => '0'
    );
\original_rd_data_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => original_rd_data0,
      D => D(6),
      Q => original_rd_data(6),
      R => '0'
    );
\original_rd_data_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => original_rd_data0,
      D => D(7),
      Q => original_rd_data(7),
      R => '0'
    );
\original_rd_data_reg[8]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => original_rd_data0,
      D => D(8),
      Q => original_rd_data(8),
      R => '0'
    );
\original_rd_data_reg[9]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => original_rd_data0,
      D => D(9),
      Q => original_rd_data(9),
      R => '0'
    );
\rd_data[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
    port map (
      I0 => original_rd_data(0),
      I1 => flag,
      I2 => I1,
      I3 => D(0),
      O => \n_0_rd_data[0]_i_1\
    );
\rd_data[10]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
    port map (
      I0 => original_rd_data(10),
      I1 => flag,
      I2 => I1,
      I3 => D(10),
      O => \n_0_rd_data[10]_i_1\
    );
\rd_data[11]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
    port map (
      I0 => original_rd_data(11),
      I1 => flag,
      I2 => I1,
      I3 => D(11),
      O => \n_0_rd_data[11]_i_1\
    );
\rd_data[12]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
    port map (
      I0 => original_rd_data(12),
      I1 => flag,
      I2 => I1,
      I3 => D(12),
      O => \n_0_rd_data[12]_i_1\
    );
\rd_data[13]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
    port map (
      I0 => original_rd_data(13),
      I1 => flag,
      I2 => I1,
      I3 => D(13),
      O => \n_0_rd_data[13]_i_1\
    );
\rd_data[14]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
    port map (
      I0 => original_rd_data(14),
      I1 => flag,
      I2 => I1,
      I3 => D(14),
      O => \n_0_rd_data[14]_i_1\
    );
\rd_data[15]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0400"
    )
    port map (
      I0 => \n_0_state_reg[2]\,
      I1 => \n_0_state_reg[1]\,
      I2 => \n_0_state_reg[0]\,
      I3 => I1,
      O => \n_0_rd_data[15]_i_1\
    );
\rd_data[15]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
    port map (
      I0 => original_rd_data(15),
      I1 => flag,
      I2 => I1,
      I3 => D(15),
      O => \n_0_rd_data[15]_i_2\
    );
\rd_data[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
    port map (
      I0 => original_rd_data(1),
      I1 => flag,
      I2 => I1,
      I3 => D(1),
      O => \n_0_rd_data[1]_i_1\
    );
\rd_data[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
    port map (
      I0 => original_rd_data(2),
      I1 => flag,
      I2 => I1,
      I3 => D(2),
      O => \n_0_rd_data[2]_i_1\
    );
\rd_data[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
    port map (
      I0 => original_rd_data(3),
      I1 => flag,
      I2 => I1,
      I3 => D(3),
      O => \n_0_rd_data[3]_i_1\
    );
\rd_data[4]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
    port map (
      I0 => original_rd_data(4),
      I1 => flag,
      I2 => I1,
      I3 => D(4),
      O => \n_0_rd_data[4]_i_1\
    );
\rd_data[5]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
    port map (
      I0 => original_rd_data(5),
      I1 => flag,
      I2 => I1,
      I3 => D(5),
      O => \n_0_rd_data[5]_i_1\
    );
\rd_data[6]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
    port map (
      I0 => original_rd_data(6),
      I1 => flag,
      I2 => I1,
      I3 => D(6),
      O => \n_0_rd_data[6]_i_1\
    );
\rd_data[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
    port map (
      I0 => original_rd_data(7),
      I1 => flag,
      I2 => I1,
      I3 => D(7),
      O => \n_0_rd_data[7]_i_1\
    );
\rd_data[8]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
    port map (
      I0 => original_rd_data(8),
      I1 => flag,
      I2 => I1,
      I3 => D(8),
      O => \n_0_rd_data[8]_i_1\
    );
\rd_data[9]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
    port map (
      I0 => original_rd_data(9),
      I1 => flag,
      I2 => I1,
      I3 => D(9),
      O => \n_0_rd_data[9]_i_1\
    );
\rd_data_reg[0]\: unisim.vcomponents.FDCE
    port map (
      C => CLK,
      CE => \n_0_rd_data[15]_i_1\,
      CLR => n_0_sync_rst_sync,
      D => \n_0_rd_data[0]_i_1\,
      Q => rd_data(0)
    );
\rd_data_reg[10]\: unisim.vcomponents.FDCE
    port map (
      C => CLK,
      CE => \n_0_rd_data[15]_i_1\,
      CLR => n_0_sync_rst_sync,
      D => \n_0_rd_data[10]_i_1\,
      Q => rd_data(10)
    );
\rd_data_reg[11]\: unisim.vcomponents.FDCE
    port map (
      C => CLK,
      CE => \n_0_rd_data[15]_i_1\,
      CLR => n_0_sync_rst_sync,
      D => \n_0_rd_data[11]_i_1\,
      Q => rd_data(11)
    );
\rd_data_reg[12]\: unisim.vcomponents.FDCE
    port map (
      C => CLK,
      CE => \n_0_rd_data[15]_i_1\,
      CLR => n_0_sync_rst_sync,
      D => \n_0_rd_data[12]_i_1\,
      Q => rd_data(12)
    );
\rd_data_reg[13]\: unisim.vcomponents.FDCE
    port map (
      C => CLK,
      CE => \n_0_rd_data[15]_i_1\,
      CLR => n_0_sync_rst_sync,
      D => \n_0_rd_data[13]_i_1\,
      Q => rd_data(13)
    );
\rd_data_reg[14]\: unisim.vcomponents.FDCE
    port map (
      C => CLK,
      CE => \n_0_rd_data[15]_i_1\,
      CLR => n_0_sync_rst_sync,
      D => \n_0_rd_data[14]_i_1\,
      Q => rd_data(14)
    );
\rd_data_reg[15]\: unisim.vcomponents.FDCE
    port map (
      C => CLK,
      CE => \n_0_rd_data[15]_i_1\,
      CLR => n_0_sync_rst_sync,
      D => \n_0_rd_data[15]_i_2\,
      Q => rd_data(15)
    );
\rd_data_reg[1]\: unisim.vcomponents.FDCE
    port map (
      C => CLK,
      CE => \n_0_rd_data[15]_i_1\,
      CLR => n_0_sync_rst_sync,
      D => \n_0_rd_data[1]_i_1\,
      Q => rd_data(1)
    );
\rd_data_reg[2]\: unisim.vcomponents.FDCE
    port map (
      C => CLK,
      CE => \n_0_rd_data[15]_i_1\,
      CLR => n_0_sync_rst_sync,
      D => \n_0_rd_data[2]_i_1\,
      Q => rd_data(2)
    );
\rd_data_reg[3]\: unisim.vcomponents.FDCE
    port map (
      C => CLK,
      CE => \n_0_rd_data[15]_i_1\,
      CLR => n_0_sync_rst_sync,
      D => \n_0_rd_data[3]_i_1\,
      Q => rd_data(3)
    );
\rd_data_reg[4]\: unisim.vcomponents.FDCE
    port map (
      C => CLK,
      CE => \n_0_rd_data[15]_i_1\,
      CLR => n_0_sync_rst_sync,
      D => \n_0_rd_data[4]_i_1\,
      Q => rd_data(4)
    );
\rd_data_reg[5]\: unisim.vcomponents.FDCE
    port map (
      C => CLK,
      CE => \n_0_rd_data[15]_i_1\,
      CLR => n_0_sync_rst_sync,
      D => \n_0_rd_data[5]_i_1\,
      Q => rd_data(5)
    );
\rd_data_reg[6]\: unisim.vcomponents.FDCE
    port map (
      C => CLK,
      CE => \n_0_rd_data[15]_i_1\,
      CLR => n_0_sync_rst_sync,
      D => \n_0_rd_data[6]_i_1\,
      Q => rd_data(6)
    );
\rd_data_reg[7]\: unisim.vcomponents.FDCE
    port map (
      C => CLK,
      CE => \n_0_rd_data[15]_i_1\,
      CLR => n_0_sync_rst_sync,
      D => \n_0_rd_data[7]_i_1\,
      Q => rd_data(7)
    );
\rd_data_reg[8]\: unisim.vcomponents.FDCE
    port map (
      C => CLK,
      CE => \n_0_rd_data[15]_i_1\,
      CLR => n_0_sync_rst_sync,
      D => \n_0_rd_data[8]_i_1\,
      Q => rd_data(8)
    );
\rd_data_reg[9]\: unisim.vcomponents.FDCE
    port map (
      C => CLK,
      CE => \n_0_rd_data[15]_i_1\,
      CLR => n_0_sync_rst_sync,
      D => \n_0_rd_data[9]_i_1\,
      Q => rd_data(9)
    );
rxpmaresetdone_s_reg: unisim.vcomponents.FDCE
    port map (
      C => CLK,
      CE => '1',
      CLR => n_0_sync_rst_sync,
      D => data_out,
      Q => rxpmaresetdone_s
    );
rxpmaresetdone_ss_reg: unisim.vcomponents.FDCE
    port map (
      C => CLK,
      CE => '1',
      CLR => n_0_sync_rst_sync,
      D => rxpmaresetdone_s,
      Q => rxpmaresetdone_ss
    );
rxpmaresetdone_sss_reg: unisim.vcomponents.FDCE
    port map (
      C => CLK,
      CE => '1',
      CLR => n_0_sync_rst_sync,
      D => rxpmaresetdone_ss,
      Q => rxpmaresetdone_sss
    );
\state[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0C880C88FCF3FCC0"
    )
    port map (
      I0 => \n_0_state[0]_i_2\,
      I1 => \n_0_state_reg[2]\,
      I2 => I1,
      I3 => \n_0_state_reg[1]\,
      I4 => gtrxreset_ss,
      I5 => \n_0_state_reg[0]\,
      O => next_state(0)
    );
\state[0]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => rxpmaresetdone_ss,
      I1 => rxpmaresetdone_sss,
      O => \n_0_state[0]_i_2\
    );
\state[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"550030FFFFFF0000"
    )
    port map (
      I0 => I1,
      I1 => rxpmaresetdone_ss,
      I2 => rxpmaresetdone_sss,
      I3 => \n_0_state_reg[2]\,
      I4 => \n_0_state_reg[1]\,
      I5 => \n_0_state_reg[0]\,
      O => next_state(1)
    );
\state[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7CCC"
    )
    port map (
      I0 => I1,
      I1 => \n_0_state_reg[2]\,
      I2 => \n_0_state_reg[1]\,
      I3 => \n_0_state_reg[0]\,
      O => next_state(2)
    );
\state_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      CLR => n_0_sync_rst_sync,
      D => next_state(0),
      Q => \n_0_state_reg[0]\
    );
\state_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      CLR => n_0_sync_rst_sync,
      D => next_state(1),
      Q => \n_0_state_reg[1]\
    );
\state_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      CLR => n_0_sync_rst_sync,
      D => next_state(2),
      Q => \n_0_state_reg[2]\
    );
sync_gtrxreset_in: entity work.gmii_to_sgmii_gmii_to_sgmii_reset_sync_16
    port map (
      CLK => CLK,
      data_in => data_in,
      reset_out => reset_out
    );
sync_rst_sync: entity work.gmii_to_sgmii_gmii_to_sgmii_reset_sync_17
    port map (
      CLK => CLK,
      CPLL_RESET => CPLL_RESET,
      reset_out => n_0_sync_rst_sync
    );
sync_rxpmaresetdone: entity work.\gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_18\
    port map (
      CLK => CLK,
      I2 => I2,
      data_out => data_out
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gmii_to_sgmii_gmii_to_sgmii_rx_elastic_buffer is
  port (
    rxchariscomma : out STD_LOGIC_VECTOR ( 0 to 0 );
    rxcharisk : out STD_LOGIC_VECTOR ( 0 to 0 );
    rxdisperr : out STD_LOGIC_VECTOR ( 0 to 0 );
    rxnotintable : out STD_LOGIC_VECTOR ( 0 to 0 );
    rxrundisp : out STD_LOGIC_VECTOR ( 0 to 0 );
    initialize_ram_complete : out STD_LOGIC;
    initialize_ram_complete_pulse : out STD_LOGIC;
    rxbufstatus : out STD_LOGIC_VECTOR ( 0 to 0 );
    rxclkcorcnt : out STD_LOGIC_VECTOR ( 1 downto 0 );
    Q : out STD_LOGIC_VECTOR ( 7 downto 0 );
    CLK : in STD_LOGIC;
    I2 : in STD_LOGIC;
    rxrecreset : in STD_LOGIC;
    reset_in : in STD_LOGIC;
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    I1 : in STD_LOGIC_VECTOR ( 0 to 0 );
    D : in STD_LOGIC_VECTOR ( 23 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of gmii_to_sgmii_gmii_to_sgmii_rx_elastic_buffer : entity is "gmii_to_sgmii_rx_elastic_buffer";
end gmii_to_sgmii_gmii_to_sgmii_rx_elastic_buffer;

architecture STRUCTURE of gmii_to_sgmii_gmii_to_sgmii_rx_elastic_buffer is
  signal d16p2_wr_reg : STD_LOGIC;
  signal data_in : STD_LOGIC;
  signal data_out : STD_LOGIC;
  signal data_out0_out : STD_LOGIC;
  signal data_out1_out : STD_LOGIC;
  signal data_out2_out : STD_LOGIC;
  signal data_out3_out : STD_LOGIC;
  signal data_out4_out : STD_LOGIC;
  signal dpo : STD_LOGIC_VECTOR ( 28 downto 0 );
  signal even : STD_LOGIC;
  signal initialize_counter0 : STD_LOGIC;
  signal \initialize_counter_reg__0\ : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal initialize_ram : STD_LOGIC;
  signal initialize_ram0 : STD_LOGIC;
  signal \^initialize_ram_complete\ : STD_LOGIC;
  signal \^initialize_ram_complete_pulse\ : STD_LOGIC;
  signal initialize_ram_complete_pulse0 : STD_LOGIC;
  signal \initialize_ram_complete_reg__0\ : STD_LOGIC;
  signal initialize_ram_complete_sync_reg1 : STD_LOGIC;
  signal initialize_ram_complete_sync_ris_edg : STD_LOGIC;
  signal insert_idle : STD_LOGIC;
  signal \insert_idle_reg__0\ : STD_LOGIC;
  signal k28p5_wr_reg : STD_LOGIC;
  signal n_0_d16p2_wr_reg_i_2 : STD_LOGIC;
  signal n_0_even_i_1 : STD_LOGIC;
  signal n_0_initialize_ram_complete_i_1 : STD_LOGIC;
  signal n_0_initialize_ram_i_1 : STD_LOGIC;
  signal n_0_insert_idle_i_1 : STD_LOGIC;
  signal n_0_k28p5_wr_reg_i_2 : STD_LOGIC;
  signal n_0_ram_reg_0_63_15_17 : STD_LOGIC;
  signal \n_0_rd_addr_gray[0]_i_1\ : STD_LOGIC;
  signal \n_0_rd_addr_gray[1]_i_1\ : STD_LOGIC;
  signal \n_0_rd_addr_gray[2]_i_1\ : STD_LOGIC;
  signal \n_0_rd_addr_gray[3]_i_1\ : STD_LOGIC;
  signal \n_0_rd_addr_gray[4]_i_1\ : STD_LOGIC;
  signal \n_0_rd_addr_plus2_reg[0]\ : STD_LOGIC;
  signal \n_0_rd_addr_plus2_reg[5]\ : STD_LOGIC;
  signal \n_0_rd_addr_reg[0]\ : STD_LOGIC;
  signal \n_0_rd_addr_reg[1]\ : STD_LOGIC;
  signal \n_0_rd_addr_reg[2]\ : STD_LOGIC;
  signal \n_0_rd_addr_reg[3]\ : STD_LOGIC;
  signal \n_0_rd_addr_reg[4]\ : STD_LOGIC;
  signal \n_0_rd_addr_reg[5]\ : STD_LOGIC;
  signal \n_0_rd_data_reg_reg[0]\ : STD_LOGIC;
  signal \n_0_rd_data_reg_reg[10]\ : STD_LOGIC;
  signal \n_0_rd_data_reg_reg[11]\ : STD_LOGIC;
  signal \n_0_rd_data_reg_reg[12]\ : STD_LOGIC;
  signal \n_0_rd_data_reg_reg[13]\ : STD_LOGIC;
  signal \n_0_rd_data_reg_reg[16]\ : STD_LOGIC;
  signal \n_0_rd_data_reg_reg[17]\ : STD_LOGIC;
  signal \n_0_rd_data_reg_reg[18]\ : STD_LOGIC;
  signal \n_0_rd_data_reg_reg[19]\ : STD_LOGIC;
  signal \n_0_rd_data_reg_reg[1]\ : STD_LOGIC;
  signal \n_0_rd_data_reg_reg[20]\ : STD_LOGIC;
  signal \n_0_rd_data_reg_reg[21]\ : STD_LOGIC;
  signal \n_0_rd_data_reg_reg[22]\ : STD_LOGIC;
  signal \n_0_rd_data_reg_reg[23]\ : STD_LOGIC;
  signal \n_0_rd_data_reg_reg[24]\ : STD_LOGIC;
  signal \n_0_rd_data_reg_reg[25]\ : STD_LOGIC;
  signal \n_0_rd_data_reg_reg[26]\ : STD_LOGIC;
  signal \n_0_rd_data_reg_reg[27]\ : STD_LOGIC;
  signal \n_0_rd_data_reg_reg[28]\ : STD_LOGIC;
  signal \n_0_rd_data_reg_reg[2]\ : STD_LOGIC;
  signal \n_0_rd_data_reg_reg[3]\ : STD_LOGIC;
  signal \n_0_rd_data_reg_reg[4]\ : STD_LOGIC;
  signal \n_0_rd_data_reg_reg[5]\ : STD_LOGIC;
  signal \n_0_rd_data_reg_reg[6]\ : STD_LOGIC;
  signal \n_0_rd_data_reg_reg[7]\ : STD_LOGIC;
  signal \n_0_rd_data_reg_reg[8]\ : STD_LOGIC;
  signal \n_0_rd_data_reg_reg[9]\ : STD_LOGIC;
  signal n_0_rd_enable_i_1 : STD_LOGIC;
  signal n_0_rd_enable_i_2 : STD_LOGIC;
  signal n_0_rd_enable_i_3 : STD_LOGIC;
  signal n_0_rd_enable_i_4 : STD_LOGIC;
  signal n_0_rd_enable_i_5 : STD_LOGIC;
  signal \n_0_rd_occupancy_reg[3]_i_1\ : STD_LOGIC;
  signal \n_0_reclock_rd_addrgray[0].sync_rd_addrgray\ : STD_LOGIC;
  signal \n_0_reclock_rd_addrgray[3].sync_rd_addrgray\ : STD_LOGIC;
  signal \n_0_reclock_rd_addrgray[4].sync_rd_addrgray\ : STD_LOGIC;
  signal \n_0_reclock_rd_addrgray[5].sync_rd_addrgray\ : STD_LOGIC;
  signal \n_0_reclock_wr_addrgray[0].sync_wr_addrgray\ : STD_LOGIC;
  signal \n_0_reclock_wr_addrgray[3].sync_wr_addrgray\ : STD_LOGIC;
  signal \n_0_reclock_wr_addrgray[4].sync_wr_addrgray\ : STD_LOGIC;
  signal \n_0_reclock_wr_addrgray[5].sync_wr_addrgray\ : STD_LOGIC;
  signal n_0_remove_idle_i_1 : STD_LOGIC;
  signal n_0_reset_modified_i_1 : STD_LOGIC;
  signal n_0_rxbuferr_i_1 : STD_LOGIC;
  signal n_0_rxchariscomma_usr_i_1 : STD_LOGIC;
  signal n_0_rxcharisk_usr_i_1 : STD_LOGIC;
  signal \n_0_rxclkcorcnt[0]_i_1\ : STD_LOGIC;
  signal \n_0_rxclkcorcnt[2]_i_1\ : STD_LOGIC;
  signal \n_0_rxdata_usr[0]_i_1\ : STD_LOGIC;
  signal \n_0_rxdata_usr[1]_i_1\ : STD_LOGIC;
  signal \n_0_rxdata_usr[2]_i_1\ : STD_LOGIC;
  signal \n_0_rxdata_usr[3]_i_1\ : STD_LOGIC;
  signal \n_0_rxdata_usr[4]_i_1\ : STD_LOGIC;
  signal \n_0_rxdata_usr[5]_i_1\ : STD_LOGIC;
  signal \n_0_rxdata_usr[6]_i_1\ : STD_LOGIC;
  signal \n_0_rxdata_usr[7]_i_1\ : STD_LOGIC;
  signal n_0_rxdisperr_usr_i_1 : STD_LOGIC;
  signal n_0_rxnotintable_usr_i_1 : STD_LOGIC;
  signal n_0_rxrundisp_usr_i_1 : STD_LOGIC;
  signal n_0_sync_initialize_ram_comp : STD_LOGIC;
  signal \n_0_wr_addr[5]_i_1\ : STD_LOGIC;
  signal \n_0_wr_addr_gray_reg[0]\ : STD_LOGIC;
  signal \n_0_wr_addr_gray_reg[1]\ : STD_LOGIC;
  signal \n_0_wr_addr_gray_reg[2]\ : STD_LOGIC;
  signal \n_0_wr_addr_gray_reg[3]\ : STD_LOGIC;
  signal \n_0_wr_addr_gray_reg[4]\ : STD_LOGIC;
  signal \n_0_wr_addr_plus1[5]_i_1\ : STD_LOGIC;
  signal \n_0_wr_addr_plus2[5]_i_1\ : STD_LOGIC;
  signal \n_0_wr_addr_plus2[5]_i_2\ : STD_LOGIC;
  signal \n_0_wr_addr_plus2_reg[0]\ : STD_LOGIC;
  signal \n_0_wr_addr_plus2_reg[5]\ : STD_LOGIC;
  signal \n_0_wr_addr_reg[0]\ : STD_LOGIC;
  signal \n_0_wr_addr_reg[1]\ : STD_LOGIC;
  signal \n_0_wr_addr_reg[2]\ : STD_LOGIC;
  signal \n_0_wr_addr_reg[3]\ : STD_LOGIC;
  signal \n_0_wr_addr_reg[4]\ : STD_LOGIC;
  signal \n_0_wr_addr_reg[5]\ : STD_LOGIC;
  signal \n_0_wr_data_reg[0]\ : STD_LOGIC;
  signal \n_0_wr_data_reg[10]\ : STD_LOGIC;
  signal \n_0_wr_data_reg[11]\ : STD_LOGIC;
  signal \n_0_wr_data_reg[12]\ : STD_LOGIC;
  signal \n_0_wr_data_reg[16]\ : STD_LOGIC;
  signal \n_0_wr_data_reg[17]\ : STD_LOGIC;
  signal \n_0_wr_data_reg[18]\ : STD_LOGIC;
  signal \n_0_wr_data_reg[19]\ : STD_LOGIC;
  signal \n_0_wr_data_reg[1]\ : STD_LOGIC;
  signal \n_0_wr_data_reg[20]\ : STD_LOGIC;
  signal \n_0_wr_data_reg[21]\ : STD_LOGIC;
  signal \n_0_wr_data_reg[22]\ : STD_LOGIC;
  signal \n_0_wr_data_reg[23]\ : STD_LOGIC;
  signal \n_0_wr_data_reg[25]\ : STD_LOGIC;
  signal \n_0_wr_data_reg[26]\ : STD_LOGIC;
  signal \n_0_wr_data_reg[28]\ : STD_LOGIC;
  signal \n_0_wr_data_reg[2]\ : STD_LOGIC;
  signal \n_0_wr_data_reg[3]\ : STD_LOGIC;
  signal \n_0_wr_data_reg[4]\ : STD_LOGIC;
  signal \n_0_wr_data_reg[5]\ : STD_LOGIC;
  signal \n_0_wr_data_reg[6]\ : STD_LOGIC;
  signal \n_0_wr_data_reg[7]\ : STD_LOGIC;
  signal \n_0_wr_data_reg[9]\ : STD_LOGIC;
  signal n_0_wr_enable_i_1 : STD_LOGIC;
  signal n_0_wr_enable_i_3 : STD_LOGIC;
  signal n_0_wr_enable_i_4 : STD_LOGIC;
  signal n_0_wr_enable_i_5 : STD_LOGIC;
  signal n_0_wr_enable_i_6 : STD_LOGIC;
  signal \n_0_wr_occupancy_reg[3]_i_1\ : STD_LOGIC;
  signal \n_1_rd_occupancy_reg[3]_i_1\ : STD_LOGIC;
  signal \n_1_reclock_rd_addrgray[3].sync_rd_addrgray\ : STD_LOGIC;
  signal \n_1_reclock_rd_addrgray[4].sync_rd_addrgray\ : STD_LOGIC;
  signal \n_1_reclock_wr_addrgray[3].sync_wr_addrgray\ : STD_LOGIC;
  signal \n_1_wr_occupancy_reg[3]_i_1\ : STD_LOGIC;
  signal n_2_ram_reg_0_63_12_14 : STD_LOGIC;
  signal n_2_ram_reg_0_63_27_29 : STD_LOGIC;
  signal \n_2_rd_occupancy_reg[3]_i_1\ : STD_LOGIC;
  signal \n_2_reclock_rd_addrgray[4].sync_rd_addrgray\ : STD_LOGIC;
  signal \n_2_reclock_rd_addrgray[5].sync_rd_addrgray\ : STD_LOGIC;
  signal \n_2_reclock_wr_addrgray[4].sync_wr_addrgray\ : STD_LOGIC;
  signal \n_2_reclock_wr_addrgray[5].sync_wr_addrgray\ : STD_LOGIC;
  signal \n_2_wr_occupancy_reg[3]_i_1\ : STD_LOGIC;
  signal \n_3_rd_occupancy_reg[3]_i_1\ : STD_LOGIC;
  signal \n_3_rd_occupancy_reg[5]_i_1\ : STD_LOGIC;
  signal \n_3_reclock_rd_addrgray[4].sync_rd_addrgray\ : STD_LOGIC;
  signal \n_3_reclock_wr_addrgray[4].sync_wr_addrgray\ : STD_LOGIC;
  signal \n_3_wr_occupancy_reg[3]_i_1\ : STD_LOGIC;
  signal \n_3_wr_occupancy_reg[5]_i_1\ : STD_LOGIC;
  signal p_0_in : STD_LOGIC;
  signal p_0_in1_in1_in : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal p_0_in5_in : STD_LOGIC;
  signal p_0_in5_out : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal p_1_in : STD_LOGIC;
  signal p_1_in18_in : STD_LOGIC;
  signal p_1_in6_in : STD_LOGIC;
  signal p_2_in : STD_LOGIC;
  signal p_2_in21_in : STD_LOGIC;
  signal p_2_in8_in : STD_LOGIC;
  signal p_3_in : STD_LOGIC;
  signal p_3_in10_in : STD_LOGIC;
  signal p_3_in24_in : STD_LOGIC;
  signal p_4_in : STD_LOGIC;
  signal p_4_in12_in : STD_LOGIC;
  signal p_7_in : STD_LOGIC;
  signal p_8_in : STD_LOGIC;
  signal plusOp : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal \plusOp__1\ : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal \plusOp__2\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal rd_addr0_in : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal rd_addr_gray : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal rd_data : STD_LOGIC_VECTOR ( 28 downto 0 );
  signal rd_enable : STD_LOGIC;
  signal rd_occupancy : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal rd_occupancy02_out : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal remove_idle : STD_LOGIC;
  signal reset_modified : STD_LOGIC;
  signal rxbuferr0 : STD_LOGIC;
  signal \^rxbufstatus\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^rxclkcorcnt\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal start : STD_LOGIC;
  signal wr_addr1_in : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal \wr_data_reg__0\ : STD_LOGIC_VECTOR ( 28 downto 0 );
  signal wr_enable : STD_LOGIC;
  signal wr_enable1 : STD_LOGIC;
  signal wr_occupancy : STD_LOGIC_VECTOR ( 5 downto 1 );
  signal wr_occupancy00_out : STD_LOGIC_VECTOR ( 5 downto 1 );
  signal NLW_ram_reg_0_63_0_2_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_ram_reg_0_63_12_14_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_ram_reg_0_63_15_17_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_ram_reg_0_63_18_20_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_ram_reg_0_63_21_23_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_ram_reg_0_63_24_26_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_ram_reg_0_63_27_29_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_ram_reg_0_63_3_5_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_ram_reg_0_63_6_8_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_ram_reg_0_63_9_11_DOD_UNCONNECTED : STD_LOGIC;
  signal \NLW_rd_occupancy_reg[5]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_rd_occupancy_reg[5]_i_1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_wr_occupancy_reg[3]_i_1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \NLW_wr_occupancy_reg[5]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_wr_occupancy_reg[5]_i_1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of d16p2_wr_reg_i_1 : label is "soft_lutpair122";
  attribute SOFT_HLUTNM of \initialize_counter[1]_i_1\ : label is "soft_lutpair124";
  attribute SOFT_HLUTNM of \initialize_counter[2]_i_1\ : label is "soft_lutpair124";
  attribute SOFT_HLUTNM of \initialize_counter[3]_i_1\ : label is "soft_lutpair118";
  attribute SOFT_HLUTNM of \initialize_counter[4]_i_2\ : label is "soft_lutpair118";
  attribute SOFT_HLUTNM of k28p5_wr_reg_i_1 : label is "soft_lutpair121";
  attribute SOFT_HLUTNM of \rd_addr_gray[0]_i_1\ : label is "soft_lutpair131";
  attribute SOFT_HLUTNM of \rd_addr_gray[1]_i_1\ : label is "soft_lutpair134";
  attribute SOFT_HLUTNM of \rd_addr_gray[2]_i_1\ : label is "soft_lutpair134";
  attribute SOFT_HLUTNM of \rd_addr_gray[3]_i_1\ : label is "soft_lutpair133";
  attribute SOFT_HLUTNM of \rd_addr_gray[4]_i_1\ : label is "soft_lutpair133";
  attribute SOFT_HLUTNM of \rd_addr_plus2[2]_i_1\ : label is "soft_lutpair131";
  attribute SOFT_HLUTNM of \rd_addr_plus2[3]_i_1\ : label is "soft_lutpair117";
  attribute SOFT_HLUTNM of \rd_addr_plus2[4]_i_1\ : label is "soft_lutpair117";
  attribute SOFT_HLUTNM of remove_idle_i_1 : label is "soft_lutpair123";
  attribute SOFT_HLUTNM of rxchariscomma_usr_i_1 : label is "soft_lutpair129";
  attribute SOFT_HLUTNM of rxcharisk_usr_i_1 : label is "soft_lutpair129";
  attribute SOFT_HLUTNM of \rxdata_usr[0]_i_1\ : label is "soft_lutpair125";
  attribute SOFT_HLUTNM of \rxdata_usr[1]_i_1\ : label is "soft_lutpair125";
  attribute SOFT_HLUTNM of \rxdata_usr[2]_i_1\ : label is "soft_lutpair126";
  attribute SOFT_HLUTNM of \rxdata_usr[3]_i_1\ : label is "soft_lutpair126";
  attribute SOFT_HLUTNM of \rxdata_usr[4]_i_1\ : label is "soft_lutpair127";
  attribute SOFT_HLUTNM of \rxdata_usr[5]_i_1\ : label is "soft_lutpair127";
  attribute SOFT_HLUTNM of \rxdata_usr[6]_i_1\ : label is "soft_lutpair128";
  attribute SOFT_HLUTNM of \rxdata_usr[7]_i_1\ : label is "soft_lutpair128";
  attribute SOFT_HLUTNM of rxdisperr_usr_i_1 : label is "soft_lutpair130";
  attribute SOFT_HLUTNM of rxnotintable_usr_i_1 : label is "soft_lutpair130";
  attribute SOFT_HLUTNM of \wr_addr[5]_i_1\ : label is "soft_lutpair120";
  attribute SOFT_HLUTNM of \wr_addr_gray[2]_i_1\ : label is "soft_lutpair132";
  attribute SOFT_HLUTNM of \wr_addr_gray[3]_i_1\ : label is "soft_lutpair132";
  attribute SOFT_HLUTNM of \wr_addr_plus1[5]_i_1\ : label is "soft_lutpair120";
  attribute SOFT_HLUTNM of \wr_addr_plus2[2]_i_1\ : label is "soft_lutpair119";
  attribute SOFT_HLUTNM of \wr_addr_plus2[3]_i_1\ : label is "soft_lutpair119";
  attribute SOFT_HLUTNM of \wr_addr_plus2[4]_i_2\ : label is "soft_lutpair116";
  attribute SOFT_HLUTNM of \wr_addr_plus2[5]_i_2\ : label is "soft_lutpair116";
  attribute SOFT_HLUTNM of wr_enable_i_1 : label is "soft_lutpair123";
  attribute SOFT_HLUTNM of wr_enable_i_3 : label is "soft_lutpair121";
  attribute SOFT_HLUTNM of wr_enable_i_6 : label is "soft_lutpair122";
begin
  initialize_ram_complete <= \^initialize_ram_complete\;
  initialize_ram_complete_pulse <= \^initialize_ram_complete_pulse\;
  rxbufstatus(0) <= \^rxbufstatus\(0);
  rxclkcorcnt(1 downto 0) <= \^rxclkcorcnt\(1 downto 0);
d16p2_wr_reg_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0100"
    )
    port map (
      I0 => \n_0_wr_data_reg[0]\,
      I1 => \n_0_wr_data_reg[1]\,
      I2 => \n_0_wr_data_reg[2]\,
      I3 => n_0_d16p2_wr_reg_i_2,
      O => p_7_in
    );
d16p2_wr_reg_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000040000"
    )
    port map (
      I0 => \n_0_wr_data_reg[3]\,
      I1 => \n_0_wr_data_reg[4]\,
      I2 => \n_0_wr_data_reg[7]\,
      I3 => \n_0_wr_data_reg[11]\,
      I4 => \n_0_wr_data_reg[6]\,
      I5 => \n_0_wr_data_reg[5]\,
      O => n_0_d16p2_wr_reg_i_2
    );
d16p2_wr_reg_reg: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => p_7_in,
      Q => d16p2_wr_reg,
      R => rxrecreset
    );
even_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => even,
      O => n_0_even_i_1
    );
even_reg: unisim.vcomponents.FDSE
    port map (
      C => CLK,
      CE => '1',
      D => n_0_even_i_1,
      Q => even,
      S => reset_modified
    );
\initialize_counter[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \initialize_counter_reg__0\(0),
      O => \plusOp__1\(0)
    );
\initialize_counter[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \initialize_counter_reg__0\(0),
      I1 => \initialize_counter_reg__0\(1),
      O => \plusOp__1\(1)
    );
\initialize_counter[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
    port map (
      I0 => \initialize_counter_reg__0\(2),
      I1 => \initialize_counter_reg__0\(0),
      I2 => \initialize_counter_reg__0\(1),
      O => \plusOp__1\(2)
    );
\initialize_counter[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
    port map (
      I0 => \initialize_counter_reg__0\(1),
      I1 => \initialize_counter_reg__0\(0),
      I2 => \initialize_counter_reg__0\(2),
      I3 => \initialize_counter_reg__0\(3),
      O => \plusOp__1\(3)
    );
\initialize_counter[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2AAAAAAAAAAAAAAA"
    )
    port map (
      I0 => initialize_ram,
      I1 => \initialize_counter_reg__0\(3),
      I2 => \initialize_counter_reg__0\(2),
      I3 => \initialize_counter_reg__0\(0),
      I4 => \initialize_counter_reg__0\(1),
      I5 => \initialize_counter_reg__0\(4),
      O => initialize_counter0
    );
\initialize_counter[4]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
    port map (
      I0 => \initialize_counter_reg__0\(4),
      I1 => \initialize_counter_reg__0\(1),
      I2 => \initialize_counter_reg__0\(0),
      I3 => \initialize_counter_reg__0\(2),
      I4 => \initialize_counter_reg__0\(3),
      O => \plusOp__1\(4)
    );
\initialize_counter_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => initialize_counter0,
      D => \plusOp__1\(0),
      Q => \initialize_counter_reg__0\(0),
      R => initialize_ram0
    );
\initialize_counter_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => initialize_counter0,
      D => \plusOp__1\(1),
      Q => \initialize_counter_reg__0\(1),
      R => initialize_ram0
    );
\initialize_counter_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => initialize_counter0,
      D => \plusOp__1\(2),
      Q => \initialize_counter_reg__0\(2),
      R => initialize_ram0
    );
\initialize_counter_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => initialize_counter0,
      D => \plusOp__1\(3),
      Q => \initialize_counter_reg__0\(3),
      R => initialize_ram0
    );
\initialize_counter_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => initialize_counter0,
      D => \plusOp__1\(4),
      Q => \initialize_counter_reg__0\(4),
      R => initialize_ram0
    );
initialize_ram_complete_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF80000000"
    )
    port map (
      I0 => \initialize_counter_reg__0\(3),
      I1 => \initialize_counter_reg__0\(2),
      I2 => \initialize_counter_reg__0\(0),
      I3 => \initialize_counter_reg__0\(1),
      I4 => \initialize_counter_reg__0\(4),
      I5 => \^initialize_ram_complete\,
      O => n_0_initialize_ram_complete_i_1
    );
initialize_ram_complete_pulse_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \^initialize_ram_complete\,
      I1 => \initialize_ram_complete_reg__0\,
      O => initialize_ram_complete_pulse0
    );
initialize_ram_complete_pulse_reg: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => initialize_ram_complete_pulse0,
      Q => \^initialize_ram_complete_pulse\,
      R => initialize_ram0
    );
initialize_ram_complete_reg: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => n_0_initialize_ram_complete_i_1,
      Q => \^initialize_ram_complete\,
      R => initialize_ram0
    );
initialize_ram_complete_reg_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => start,
      I1 => rxrecreset,
      O => initialize_ram0
    );
initialize_ram_complete_reg_reg: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => \^initialize_ram_complete\,
      Q => \initialize_ram_complete_reg__0\,
      R => initialize_ram0
    );
initialize_ram_complete_sync_reg1_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => data_out,
      Q => initialize_ram_complete_sync_reg1,
      R => '0'
    );
initialize_ram_complete_sync_ris_edg_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => n_0_sync_initialize_ram_comp,
      Q => initialize_ram_complete_sync_ris_edg,
      R => '0'
    );
initialize_ram_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => \^initialize_ram_complete\,
      I1 => initialize_ram,
      O => n_0_initialize_ram_i_1
    );
initialize_ram_reg: unisim.vcomponents.FDSE
    port map (
      C => I2,
      CE => '1',
      D => n_0_initialize_ram_i_1,
      Q => initialize_ram,
      S => initialize_ram0
    );
insert_idle_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000010000"
    )
    port map (
      I0 => n_0_rd_enable_i_2,
      I1 => n_0_rd_enable_i_3,
      I2 => n_0_rd_enable_i_4,
      I3 => n_0_rd_enable_i_5,
      I4 => even,
      I5 => reset_modified,
      O => n_0_insert_idle_i_1
    );
insert_idle_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => n_0_insert_idle_i_1,
      Q => insert_idle,
      R => '0'
    );
insert_idle_reg_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => insert_idle,
      Q => \insert_idle_reg__0\,
      R => reset_modified
    );
k28p5_wr_reg_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0400"
    )
    port map (
      I0 => \n_0_wr_data_reg[16]\,
      I1 => \n_0_wr_data_reg[18]\,
      I2 => \n_0_wr_data_reg[17]\,
      I3 => n_0_k28p5_wr_reg_i_2,
      O => p_8_in
    );
k28p5_wr_reg_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000080000000"
    )
    port map (
      I0 => \n_0_wr_data_reg[20]\,
      I1 => \n_0_wr_data_reg[19]\,
      I2 => \n_0_wr_data_reg[23]\,
      I3 => p_0_in5_in,
      I4 => \n_0_wr_data_reg[21]\,
      I5 => \n_0_wr_data_reg[22]\,
      O => n_0_k28p5_wr_reg_i_2
    );
k28p5_wr_reg_reg: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => p_8_in,
      Q => k28p5_wr_reg,
      R => rxrecreset
    );
ram_reg_0_63_0_2: unisim.vcomponents.RAM64M
    port map (
      ADDRA(5) => \n_0_rd_addr_reg[5]\,
      ADDRA(4) => \n_0_rd_addr_reg[4]\,
      ADDRA(3) => \n_0_rd_addr_reg[3]\,
      ADDRA(2) => \n_0_rd_addr_reg[2]\,
      ADDRA(1) => \n_0_rd_addr_reg[1]\,
      ADDRA(0) => \n_0_rd_addr_reg[0]\,
      ADDRB(5) => \n_0_rd_addr_reg[5]\,
      ADDRB(4) => \n_0_rd_addr_reg[4]\,
      ADDRB(3) => \n_0_rd_addr_reg[3]\,
      ADDRB(2) => \n_0_rd_addr_reg[2]\,
      ADDRB(1) => \n_0_rd_addr_reg[1]\,
      ADDRB(0) => \n_0_rd_addr_reg[0]\,
      ADDRC(5) => \n_0_rd_addr_reg[5]\,
      ADDRC(4) => \n_0_rd_addr_reg[4]\,
      ADDRC(3) => \n_0_rd_addr_reg[3]\,
      ADDRC(2) => \n_0_rd_addr_reg[2]\,
      ADDRC(1) => \n_0_rd_addr_reg[1]\,
      ADDRC(0) => \n_0_rd_addr_reg[0]\,
      ADDRD(5) => \n_0_wr_addr_reg[5]\,
      ADDRD(4) => \n_0_wr_addr_reg[4]\,
      ADDRD(3) => \n_0_wr_addr_reg[3]\,
      ADDRD(2) => \n_0_wr_addr_reg[2]\,
      ADDRD(1) => \n_0_wr_addr_reg[1]\,
      ADDRD(0) => \n_0_wr_addr_reg[0]\,
      DIA => \wr_data_reg__0\(0),
      DIB => \wr_data_reg__0\(1),
      DIC => \wr_data_reg__0\(2),
      DID => '0',
      DOA => dpo(0),
      DOB => dpo(1),
      DOC => dpo(2),
      DOD => NLW_ram_reg_0_63_0_2_DOD_UNCONNECTED,
      WCLK => I2,
      WE => wr_enable
    );
ram_reg_0_63_12_14: unisim.vcomponents.RAM64M
    port map (
      ADDRA(5) => \n_0_rd_addr_reg[5]\,
      ADDRA(4) => \n_0_rd_addr_reg[4]\,
      ADDRA(3) => \n_0_rd_addr_reg[3]\,
      ADDRA(2) => \n_0_rd_addr_reg[2]\,
      ADDRA(1) => \n_0_rd_addr_reg[1]\,
      ADDRA(0) => \n_0_rd_addr_reg[0]\,
      ADDRB(5) => \n_0_rd_addr_reg[5]\,
      ADDRB(4) => \n_0_rd_addr_reg[4]\,
      ADDRB(3) => \n_0_rd_addr_reg[3]\,
      ADDRB(2) => \n_0_rd_addr_reg[2]\,
      ADDRB(1) => \n_0_rd_addr_reg[1]\,
      ADDRB(0) => \n_0_rd_addr_reg[0]\,
      ADDRC(5) => \n_0_rd_addr_reg[5]\,
      ADDRC(4) => \n_0_rd_addr_reg[4]\,
      ADDRC(3) => \n_0_rd_addr_reg[3]\,
      ADDRC(2) => \n_0_rd_addr_reg[2]\,
      ADDRC(1) => \n_0_rd_addr_reg[1]\,
      ADDRC(0) => \n_0_rd_addr_reg[0]\,
      ADDRD(5) => \n_0_wr_addr_reg[5]\,
      ADDRD(4) => \n_0_wr_addr_reg[4]\,
      ADDRD(3) => \n_0_wr_addr_reg[3]\,
      ADDRD(2) => \n_0_wr_addr_reg[2]\,
      ADDRD(1) => \n_0_wr_addr_reg[1]\,
      ADDRD(0) => \n_0_wr_addr_reg[0]\,
      DIA => \wr_data_reg__0\(12),
      DIB => \wr_data_reg__0\(13),
      DIC => '0',
      DID => '0',
      DOA => dpo(12),
      DOB => dpo(13),
      DOC => n_2_ram_reg_0_63_12_14,
      DOD => NLW_ram_reg_0_63_12_14_DOD_UNCONNECTED,
      WCLK => I2,
      WE => wr_enable
    );
ram_reg_0_63_15_17: unisim.vcomponents.RAM64M
    port map (
      ADDRA(5) => \n_0_rd_addr_reg[5]\,
      ADDRA(4) => \n_0_rd_addr_reg[4]\,
      ADDRA(3) => \n_0_rd_addr_reg[3]\,
      ADDRA(2) => \n_0_rd_addr_reg[2]\,
      ADDRA(1) => \n_0_rd_addr_reg[1]\,
      ADDRA(0) => \n_0_rd_addr_reg[0]\,
      ADDRB(5) => \n_0_rd_addr_reg[5]\,
      ADDRB(4) => \n_0_rd_addr_reg[4]\,
      ADDRB(3) => \n_0_rd_addr_reg[3]\,
      ADDRB(2) => \n_0_rd_addr_reg[2]\,
      ADDRB(1) => \n_0_rd_addr_reg[1]\,
      ADDRB(0) => \n_0_rd_addr_reg[0]\,
      ADDRC(5) => \n_0_rd_addr_reg[5]\,
      ADDRC(4) => \n_0_rd_addr_reg[4]\,
      ADDRC(3) => \n_0_rd_addr_reg[3]\,
      ADDRC(2) => \n_0_rd_addr_reg[2]\,
      ADDRC(1) => \n_0_rd_addr_reg[1]\,
      ADDRC(0) => \n_0_rd_addr_reg[0]\,
      ADDRD(5) => \n_0_wr_addr_reg[5]\,
      ADDRD(4) => \n_0_wr_addr_reg[4]\,
      ADDRD(3) => \n_0_wr_addr_reg[3]\,
      ADDRD(2) => \n_0_wr_addr_reg[2]\,
      ADDRD(1) => \n_0_wr_addr_reg[1]\,
      ADDRD(0) => \n_0_wr_addr_reg[0]\,
      DIA => '0',
      DIB => \wr_data_reg__0\(16),
      DIC => \wr_data_reg__0\(17),
      DID => '0',
      DOA => n_0_ram_reg_0_63_15_17,
      DOB => dpo(16),
      DOC => dpo(17),
      DOD => NLW_ram_reg_0_63_15_17_DOD_UNCONNECTED,
      WCLK => I2,
      WE => wr_enable
    );
ram_reg_0_63_18_20: unisim.vcomponents.RAM64M
    port map (
      ADDRA(5) => \n_0_rd_addr_reg[5]\,
      ADDRA(4) => \n_0_rd_addr_reg[4]\,
      ADDRA(3) => \n_0_rd_addr_reg[3]\,
      ADDRA(2) => \n_0_rd_addr_reg[2]\,
      ADDRA(1) => \n_0_rd_addr_reg[1]\,
      ADDRA(0) => \n_0_rd_addr_reg[0]\,
      ADDRB(5) => \n_0_rd_addr_reg[5]\,
      ADDRB(4) => \n_0_rd_addr_reg[4]\,
      ADDRB(3) => \n_0_rd_addr_reg[3]\,
      ADDRB(2) => \n_0_rd_addr_reg[2]\,
      ADDRB(1) => \n_0_rd_addr_reg[1]\,
      ADDRB(0) => \n_0_rd_addr_reg[0]\,
      ADDRC(5) => \n_0_rd_addr_reg[5]\,
      ADDRC(4) => \n_0_rd_addr_reg[4]\,
      ADDRC(3) => \n_0_rd_addr_reg[3]\,
      ADDRC(2) => \n_0_rd_addr_reg[2]\,
      ADDRC(1) => \n_0_rd_addr_reg[1]\,
      ADDRC(0) => \n_0_rd_addr_reg[0]\,
      ADDRD(5) => \n_0_wr_addr_reg[5]\,
      ADDRD(4) => \n_0_wr_addr_reg[4]\,
      ADDRD(3) => \n_0_wr_addr_reg[3]\,
      ADDRD(2) => \n_0_wr_addr_reg[2]\,
      ADDRD(1) => \n_0_wr_addr_reg[1]\,
      ADDRD(0) => \n_0_wr_addr_reg[0]\,
      DIA => \wr_data_reg__0\(18),
      DIB => \wr_data_reg__0\(19),
      DIC => \wr_data_reg__0\(20),
      DID => '0',
      DOA => dpo(18),
      DOB => dpo(19),
      DOC => dpo(20),
      DOD => NLW_ram_reg_0_63_18_20_DOD_UNCONNECTED,
      WCLK => I2,
      WE => wr_enable
    );
ram_reg_0_63_21_23: unisim.vcomponents.RAM64M
    port map (
      ADDRA(5) => \n_0_rd_addr_reg[5]\,
      ADDRA(4) => \n_0_rd_addr_reg[4]\,
      ADDRA(3) => \n_0_rd_addr_reg[3]\,
      ADDRA(2) => \n_0_rd_addr_reg[2]\,
      ADDRA(1) => \n_0_rd_addr_reg[1]\,
      ADDRA(0) => \n_0_rd_addr_reg[0]\,
      ADDRB(5) => \n_0_rd_addr_reg[5]\,
      ADDRB(4) => \n_0_rd_addr_reg[4]\,
      ADDRB(3) => \n_0_rd_addr_reg[3]\,
      ADDRB(2) => \n_0_rd_addr_reg[2]\,
      ADDRB(1) => \n_0_rd_addr_reg[1]\,
      ADDRB(0) => \n_0_rd_addr_reg[0]\,
      ADDRC(5) => \n_0_rd_addr_reg[5]\,
      ADDRC(4) => \n_0_rd_addr_reg[4]\,
      ADDRC(3) => \n_0_rd_addr_reg[3]\,
      ADDRC(2) => \n_0_rd_addr_reg[2]\,
      ADDRC(1) => \n_0_rd_addr_reg[1]\,
      ADDRC(0) => \n_0_rd_addr_reg[0]\,
      ADDRD(5) => \n_0_wr_addr_reg[5]\,
      ADDRD(4) => \n_0_wr_addr_reg[4]\,
      ADDRD(3) => \n_0_wr_addr_reg[3]\,
      ADDRD(2) => \n_0_wr_addr_reg[2]\,
      ADDRD(1) => \n_0_wr_addr_reg[1]\,
      ADDRD(0) => \n_0_wr_addr_reg[0]\,
      DIA => \wr_data_reg__0\(21),
      DIB => \wr_data_reg__0\(22),
      DIC => \wr_data_reg__0\(23),
      DID => '0',
      DOA => dpo(21),
      DOB => dpo(22),
      DOC => dpo(23),
      DOD => NLW_ram_reg_0_63_21_23_DOD_UNCONNECTED,
      WCLK => I2,
      WE => wr_enable
    );
ram_reg_0_63_24_26: unisim.vcomponents.RAM64M
    port map (
      ADDRA(5) => \n_0_rd_addr_reg[5]\,
      ADDRA(4) => \n_0_rd_addr_reg[4]\,
      ADDRA(3) => \n_0_rd_addr_reg[3]\,
      ADDRA(2) => \n_0_rd_addr_reg[2]\,
      ADDRA(1) => \n_0_rd_addr_reg[1]\,
      ADDRA(0) => \n_0_rd_addr_reg[0]\,
      ADDRB(5) => \n_0_rd_addr_reg[5]\,
      ADDRB(4) => \n_0_rd_addr_reg[4]\,
      ADDRB(3) => \n_0_rd_addr_reg[3]\,
      ADDRB(2) => \n_0_rd_addr_reg[2]\,
      ADDRB(1) => \n_0_rd_addr_reg[1]\,
      ADDRB(0) => \n_0_rd_addr_reg[0]\,
      ADDRC(5) => \n_0_rd_addr_reg[5]\,
      ADDRC(4) => \n_0_rd_addr_reg[4]\,
      ADDRC(3) => \n_0_rd_addr_reg[3]\,
      ADDRC(2) => \n_0_rd_addr_reg[2]\,
      ADDRC(1) => \n_0_rd_addr_reg[1]\,
      ADDRC(0) => \n_0_rd_addr_reg[0]\,
      ADDRD(5) => \n_0_wr_addr_reg[5]\,
      ADDRD(4) => \n_0_wr_addr_reg[4]\,
      ADDRD(3) => \n_0_wr_addr_reg[3]\,
      ADDRD(2) => \n_0_wr_addr_reg[2]\,
      ADDRD(1) => \n_0_wr_addr_reg[1]\,
      ADDRD(0) => \n_0_wr_addr_reg[0]\,
      DIA => '0',
      DIB => \wr_data_reg__0\(25),
      DIC => \wr_data_reg__0\(26),
      DID => '0',
      DOA => dpo(24),
      DOB => dpo(25),
      DOC => dpo(26),
      DOD => NLW_ram_reg_0_63_24_26_DOD_UNCONNECTED,
      WCLK => I2,
      WE => wr_enable
    );
ram_reg_0_63_27_29: unisim.vcomponents.RAM64M
    port map (
      ADDRA(5) => \n_0_rd_addr_reg[5]\,
      ADDRA(4) => \n_0_rd_addr_reg[4]\,
      ADDRA(3) => \n_0_rd_addr_reg[3]\,
      ADDRA(2) => \n_0_rd_addr_reg[2]\,
      ADDRA(1) => \n_0_rd_addr_reg[1]\,
      ADDRA(0) => \n_0_rd_addr_reg[0]\,
      ADDRB(5) => \n_0_rd_addr_reg[5]\,
      ADDRB(4) => \n_0_rd_addr_reg[4]\,
      ADDRB(3) => \n_0_rd_addr_reg[3]\,
      ADDRB(2) => \n_0_rd_addr_reg[2]\,
      ADDRB(1) => \n_0_rd_addr_reg[1]\,
      ADDRB(0) => \n_0_rd_addr_reg[0]\,
      ADDRC(5) => \n_0_rd_addr_reg[5]\,
      ADDRC(4) => \n_0_rd_addr_reg[4]\,
      ADDRC(3) => \n_0_rd_addr_reg[3]\,
      ADDRC(2) => \n_0_rd_addr_reg[2]\,
      ADDRC(1) => \n_0_rd_addr_reg[1]\,
      ADDRC(0) => \n_0_rd_addr_reg[0]\,
      ADDRD(5) => \n_0_wr_addr_reg[5]\,
      ADDRD(4) => \n_0_wr_addr_reg[4]\,
      ADDRD(3) => \n_0_wr_addr_reg[3]\,
      ADDRD(2) => \n_0_wr_addr_reg[2]\,
      ADDRD(1) => \n_0_wr_addr_reg[1]\,
      ADDRD(0) => \n_0_wr_addr_reg[0]\,
      DIA => \wr_data_reg__0\(27),
      DIB => \wr_data_reg__0\(28),
      DIC => '0',
      DID => '0',
      DOA => dpo(27),
      DOB => dpo(28),
      DOC => n_2_ram_reg_0_63_27_29,
      DOD => NLW_ram_reg_0_63_27_29_DOD_UNCONNECTED,
      WCLK => I2,
      WE => wr_enable
    );
ram_reg_0_63_3_5: unisim.vcomponents.RAM64M
    port map (
      ADDRA(5) => \n_0_rd_addr_reg[5]\,
      ADDRA(4) => \n_0_rd_addr_reg[4]\,
      ADDRA(3) => \n_0_rd_addr_reg[3]\,
      ADDRA(2) => \n_0_rd_addr_reg[2]\,
      ADDRA(1) => \n_0_rd_addr_reg[1]\,
      ADDRA(0) => \n_0_rd_addr_reg[0]\,
      ADDRB(5) => \n_0_rd_addr_reg[5]\,
      ADDRB(4) => \n_0_rd_addr_reg[4]\,
      ADDRB(3) => \n_0_rd_addr_reg[3]\,
      ADDRB(2) => \n_0_rd_addr_reg[2]\,
      ADDRB(1) => \n_0_rd_addr_reg[1]\,
      ADDRB(0) => \n_0_rd_addr_reg[0]\,
      ADDRC(5) => \n_0_rd_addr_reg[5]\,
      ADDRC(4) => \n_0_rd_addr_reg[4]\,
      ADDRC(3) => \n_0_rd_addr_reg[3]\,
      ADDRC(2) => \n_0_rd_addr_reg[2]\,
      ADDRC(1) => \n_0_rd_addr_reg[1]\,
      ADDRC(0) => \n_0_rd_addr_reg[0]\,
      ADDRD(5) => \n_0_wr_addr_reg[5]\,
      ADDRD(4) => \n_0_wr_addr_reg[4]\,
      ADDRD(3) => \n_0_wr_addr_reg[3]\,
      ADDRD(2) => \n_0_wr_addr_reg[2]\,
      ADDRD(1) => \n_0_wr_addr_reg[1]\,
      ADDRD(0) => \n_0_wr_addr_reg[0]\,
      DIA => \wr_data_reg__0\(3),
      DIB => \wr_data_reg__0\(4),
      DIC => \wr_data_reg__0\(5),
      DID => '0',
      DOA => dpo(3),
      DOB => dpo(4),
      DOC => dpo(5),
      DOD => NLW_ram_reg_0_63_3_5_DOD_UNCONNECTED,
      WCLK => I2,
      WE => wr_enable
    );
ram_reg_0_63_6_8: unisim.vcomponents.RAM64M
    port map (
      ADDRA(5) => \n_0_rd_addr_reg[5]\,
      ADDRA(4) => \n_0_rd_addr_reg[4]\,
      ADDRA(3) => \n_0_rd_addr_reg[3]\,
      ADDRA(2) => \n_0_rd_addr_reg[2]\,
      ADDRA(1) => \n_0_rd_addr_reg[1]\,
      ADDRA(0) => \n_0_rd_addr_reg[0]\,
      ADDRB(5) => \n_0_rd_addr_reg[5]\,
      ADDRB(4) => \n_0_rd_addr_reg[4]\,
      ADDRB(3) => \n_0_rd_addr_reg[3]\,
      ADDRB(2) => \n_0_rd_addr_reg[2]\,
      ADDRB(1) => \n_0_rd_addr_reg[1]\,
      ADDRB(0) => \n_0_rd_addr_reg[0]\,
      ADDRC(5) => \n_0_rd_addr_reg[5]\,
      ADDRC(4) => \n_0_rd_addr_reg[4]\,
      ADDRC(3) => \n_0_rd_addr_reg[3]\,
      ADDRC(2) => \n_0_rd_addr_reg[2]\,
      ADDRC(1) => \n_0_rd_addr_reg[1]\,
      ADDRC(0) => \n_0_rd_addr_reg[0]\,
      ADDRD(5) => \n_0_wr_addr_reg[5]\,
      ADDRD(4) => \n_0_wr_addr_reg[4]\,
      ADDRD(3) => \n_0_wr_addr_reg[3]\,
      ADDRD(2) => \n_0_wr_addr_reg[2]\,
      ADDRD(1) => \n_0_wr_addr_reg[1]\,
      ADDRD(0) => \n_0_wr_addr_reg[0]\,
      DIA => \wr_data_reg__0\(6),
      DIB => \wr_data_reg__0\(7),
      DIC => '0',
      DID => '0',
      DOA => dpo(6),
      DOB => dpo(7),
      DOC => dpo(8),
      DOD => NLW_ram_reg_0_63_6_8_DOD_UNCONNECTED,
      WCLK => I2,
      WE => wr_enable
    );
ram_reg_0_63_9_11: unisim.vcomponents.RAM64M
    port map (
      ADDRA(5) => \n_0_rd_addr_reg[5]\,
      ADDRA(4) => \n_0_rd_addr_reg[4]\,
      ADDRA(3) => \n_0_rd_addr_reg[3]\,
      ADDRA(2) => \n_0_rd_addr_reg[2]\,
      ADDRA(1) => \n_0_rd_addr_reg[1]\,
      ADDRA(0) => \n_0_rd_addr_reg[0]\,
      ADDRB(5) => \n_0_rd_addr_reg[5]\,
      ADDRB(4) => \n_0_rd_addr_reg[4]\,
      ADDRB(3) => \n_0_rd_addr_reg[3]\,
      ADDRB(2) => \n_0_rd_addr_reg[2]\,
      ADDRB(1) => \n_0_rd_addr_reg[1]\,
      ADDRB(0) => \n_0_rd_addr_reg[0]\,
      ADDRC(5) => \n_0_rd_addr_reg[5]\,
      ADDRC(4) => \n_0_rd_addr_reg[4]\,
      ADDRC(3) => \n_0_rd_addr_reg[3]\,
      ADDRC(2) => \n_0_rd_addr_reg[2]\,
      ADDRC(1) => \n_0_rd_addr_reg[1]\,
      ADDRC(0) => \n_0_rd_addr_reg[0]\,
      ADDRD(5) => \n_0_wr_addr_reg[5]\,
      ADDRD(4) => \n_0_wr_addr_reg[4]\,
      ADDRD(3) => \n_0_wr_addr_reg[3]\,
      ADDRD(2) => \n_0_wr_addr_reg[2]\,
      ADDRD(1) => \n_0_wr_addr_reg[1]\,
      ADDRD(0) => \n_0_wr_addr_reg[0]\,
      DIA => \wr_data_reg__0\(9),
      DIB => \wr_data_reg__0\(10),
      DIC => \wr_data_reg__0\(11),
      DID => '0',
      DOA => dpo(9),
      DOB => dpo(10),
      DOC => dpo(11),
      DOD => NLW_ram_reg_0_63_9_11_DOD_UNCONNECTED,
      WCLK => I2,
      WE => wr_enable
    );
\rd_addr_gray[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \n_0_rd_addr_plus2_reg[0]\,
      I1 => p_1_in,
      O => \n_0_rd_addr_gray[0]_i_1\
    );
\rd_addr_gray[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => p_1_in,
      I1 => p_2_in,
      O => \n_0_rd_addr_gray[1]_i_1\
    );
\rd_addr_gray[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => p_2_in,
      I1 => p_3_in,
      O => \n_0_rd_addr_gray[2]_i_1\
    );
\rd_addr_gray[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => p_3_in,
      I1 => p_4_in,
      O => \n_0_rd_addr_gray[3]_i_1\
    );
\rd_addr_gray[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => p_4_in,
      I1 => \n_0_rd_addr_plus2_reg[5]\,
      O => \n_0_rd_addr_gray[4]_i_1\
    );
\rd_addr_gray_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => \n_0_rd_addr_gray[0]_i_1\,
      Q => rd_addr_gray(0),
      R => reset_modified
    );
\rd_addr_gray_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => \n_0_rd_addr_gray[1]_i_1\,
      Q => rd_addr_gray(1),
      R => reset_modified
    );
\rd_addr_gray_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => \n_0_rd_addr_gray[2]_i_1\,
      Q => rd_addr_gray(2),
      R => reset_modified
    );
\rd_addr_gray_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => \n_0_rd_addr_gray[3]_i_1\,
      Q => rd_addr_gray(3),
      R => reset_modified
    );
\rd_addr_gray_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => \n_0_rd_addr_gray[4]_i_1\,
      Q => rd_addr_gray(4),
      R => reset_modified
    );
\rd_addr_gray_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => \n_0_rd_addr_plus2_reg[5]\,
      Q => rd_addr_gray(5),
      R => reset_modified
    );
\rd_addr_plus1_reg[0]\: unisim.vcomponents.FDSE
    port map (
      C => CLK,
      CE => rd_enable,
      D => \n_0_rd_addr_plus2_reg[0]\,
      Q => rd_addr0_in(0),
      S => reset_modified
    );
\rd_addr_plus1_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => p_1_in,
      Q => rd_addr0_in(1),
      R => reset_modified
    );
\rd_addr_plus1_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => p_2_in,
      Q => rd_addr0_in(2),
      R => reset_modified
    );
\rd_addr_plus1_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => p_3_in,
      Q => rd_addr0_in(3),
      R => reset_modified
    );
\rd_addr_plus1_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => p_4_in,
      Q => rd_addr0_in(4),
      R => reset_modified
    );
\rd_addr_plus1_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => \n_0_rd_addr_plus2_reg[5]\,
      Q => rd_addr0_in(5),
      R => reset_modified
    );
\rd_addr_plus2[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \n_0_rd_addr_plus2_reg[0]\,
      O => \plusOp__2\(0)
    );
\rd_addr_plus2[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
    port map (
      I0 => p_2_in,
      I1 => p_1_in,
      I2 => \n_0_rd_addr_plus2_reg[0]\,
      O => \plusOp__2\(2)
    );
\rd_addr_plus2[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6AAA"
    )
    port map (
      I0 => p_3_in,
      I1 => \n_0_rd_addr_plus2_reg[0]\,
      I2 => p_1_in,
      I3 => p_2_in,
      O => \plusOp__2\(3)
    );
\rd_addr_plus2[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
    port map (
      I0 => p_4_in,
      I1 => p_2_in,
      I2 => p_1_in,
      I3 => \n_0_rd_addr_plus2_reg[0]\,
      I4 => p_3_in,
      O => \plusOp__2\(4)
    );
\rd_addr_plus2[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6AAAAAAAAAAAAAAA"
    )
    port map (
      I0 => \n_0_rd_addr_plus2_reg[5]\,
      I1 => p_3_in,
      I2 => \n_0_rd_addr_plus2_reg[0]\,
      I3 => p_1_in,
      I4 => p_2_in,
      I5 => p_4_in,
      O => \plusOp__2\(5)
    );
\rd_addr_plus2_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => \plusOp__2\(0),
      Q => \n_0_rd_addr_plus2_reg[0]\,
      R => reset_modified
    );
\rd_addr_plus2_reg[1]\: unisim.vcomponents.FDSE
    port map (
      C => CLK,
      CE => rd_enable,
      D => \n_0_rd_addr_gray[0]_i_1\,
      Q => p_1_in,
      S => reset_modified
    );
\rd_addr_plus2_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => \plusOp__2\(2),
      Q => p_2_in,
      R => reset_modified
    );
\rd_addr_plus2_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => \plusOp__2\(3),
      Q => p_3_in,
      R => reset_modified
    );
\rd_addr_plus2_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => \plusOp__2\(4),
      Q => p_4_in,
      R => reset_modified
    );
\rd_addr_plus2_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => \plusOp__2\(5),
      Q => \n_0_rd_addr_plus2_reg[5]\,
      R => reset_modified
    );
\rd_addr_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => rd_addr0_in(0),
      Q => \n_0_rd_addr_reg[0]\,
      R => reset_modified
    );
\rd_addr_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => rd_addr0_in(1),
      Q => \n_0_rd_addr_reg[1]\,
      R => reset_modified
    );
\rd_addr_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => rd_addr0_in(2),
      Q => \n_0_rd_addr_reg[2]\,
      R => reset_modified
    );
\rd_addr_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => rd_addr0_in(3),
      Q => \n_0_rd_addr_reg[3]\,
      R => reset_modified
    );
\rd_addr_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => rd_addr0_in(4),
      Q => \n_0_rd_addr_reg[4]\,
      R => reset_modified
    );
\rd_addr_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => rd_addr0_in(5),
      Q => \n_0_rd_addr_reg[5]\,
      R => reset_modified
    );
\rd_data_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => dpo(0),
      Q => rd_data(0),
      R => reset_modified
    );
\rd_data_reg[10]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => dpo(10),
      Q => rd_data(10),
      R => reset_modified
    );
\rd_data_reg[11]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => dpo(11),
      Q => rd_data(11),
      R => reset_modified
    );
\rd_data_reg[12]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => dpo(12),
      Q => rd_data(12),
      R => reset_modified
    );
\rd_data_reg[13]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => dpo(13),
      Q => rd_data(13),
      R => reset_modified
    );
\rd_data_reg[16]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => dpo(16),
      Q => rd_data(16),
      R => reset_modified
    );
\rd_data_reg[17]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => dpo(17),
      Q => rd_data(17),
      R => reset_modified
    );
\rd_data_reg[18]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => dpo(18),
      Q => rd_data(18),
      R => reset_modified
    );
\rd_data_reg[19]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => dpo(19),
      Q => rd_data(19),
      R => reset_modified
    );
\rd_data_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => dpo(1),
      Q => rd_data(1),
      R => reset_modified
    );
\rd_data_reg[20]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => dpo(20),
      Q => rd_data(20),
      R => reset_modified
    );
\rd_data_reg[21]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => dpo(21),
      Q => rd_data(21),
      R => reset_modified
    );
\rd_data_reg[22]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => dpo(22),
      Q => rd_data(22),
      R => reset_modified
    );
\rd_data_reg[23]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => dpo(23),
      Q => rd_data(23),
      R => reset_modified
    );
\rd_data_reg[24]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => dpo(24),
      Q => rd_data(24),
      R => reset_modified
    );
\rd_data_reg[25]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => dpo(25),
      Q => rd_data(25),
      R => reset_modified
    );
\rd_data_reg[26]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => dpo(26),
      Q => rd_data(26),
      R => reset_modified
    );
\rd_data_reg[27]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => dpo(27),
      Q => rd_data(27),
      R => reset_modified
    );
\rd_data_reg[28]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => dpo(28),
      Q => rd_data(28),
      R => reset_modified
    );
\rd_data_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => dpo(2),
      Q => rd_data(2),
      R => reset_modified
    );
\rd_data_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => dpo(3),
      Q => rd_data(3),
      R => reset_modified
    );
\rd_data_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => dpo(4),
      Q => rd_data(4),
      R => reset_modified
    );
\rd_data_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => dpo(5),
      Q => rd_data(5),
      R => reset_modified
    );
\rd_data_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => dpo(6),
      Q => rd_data(6),
      R => reset_modified
    );
\rd_data_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => dpo(7),
      Q => rd_data(7),
      R => reset_modified
    );
\rd_data_reg[8]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => dpo(8),
      Q => rd_data(8),
      R => reset_modified
    );
\rd_data_reg[9]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => dpo(9),
      Q => rd_data(9),
      R => reset_modified
    );
\rd_data_reg_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => rd_data(0),
      Q => \n_0_rd_data_reg_reg[0]\,
      R => reset_modified
    );
\rd_data_reg_reg[10]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => rd_data(10),
      Q => \n_0_rd_data_reg_reg[10]\,
      R => reset_modified
    );
\rd_data_reg_reg[11]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => rd_data(11),
      Q => \n_0_rd_data_reg_reg[11]\,
      R => reset_modified
    );
\rd_data_reg_reg[12]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => rd_data(12),
      Q => \n_0_rd_data_reg_reg[12]\,
      R => reset_modified
    );
\rd_data_reg_reg[13]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => rd_data(13),
      Q => \n_0_rd_data_reg_reg[13]\,
      R => reset_modified
    );
\rd_data_reg_reg[16]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => rd_data(16),
      Q => \n_0_rd_data_reg_reg[16]\,
      R => reset_modified
    );
\rd_data_reg_reg[17]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => rd_data(17),
      Q => \n_0_rd_data_reg_reg[17]\,
      R => reset_modified
    );
\rd_data_reg_reg[18]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => rd_data(18),
      Q => \n_0_rd_data_reg_reg[18]\,
      R => reset_modified
    );
\rd_data_reg_reg[19]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => rd_data(19),
      Q => \n_0_rd_data_reg_reg[19]\,
      R => reset_modified
    );
\rd_data_reg_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => rd_data(1),
      Q => \n_0_rd_data_reg_reg[1]\,
      R => reset_modified
    );
\rd_data_reg_reg[20]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => rd_data(20),
      Q => \n_0_rd_data_reg_reg[20]\,
      R => reset_modified
    );
\rd_data_reg_reg[21]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => rd_data(21),
      Q => \n_0_rd_data_reg_reg[21]\,
      R => reset_modified
    );
\rd_data_reg_reg[22]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => rd_data(22),
      Q => \n_0_rd_data_reg_reg[22]\,
      R => reset_modified
    );
\rd_data_reg_reg[23]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => rd_data(23),
      Q => \n_0_rd_data_reg_reg[23]\,
      R => reset_modified
    );
\rd_data_reg_reg[24]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => rd_data(24),
      Q => \n_0_rd_data_reg_reg[24]\,
      R => reset_modified
    );
\rd_data_reg_reg[25]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => rd_data(25),
      Q => \n_0_rd_data_reg_reg[25]\,
      R => reset_modified
    );
\rd_data_reg_reg[26]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => rd_data(26),
      Q => \n_0_rd_data_reg_reg[26]\,
      R => reset_modified
    );
\rd_data_reg_reg[27]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => rd_data(27),
      Q => \n_0_rd_data_reg_reg[27]\,
      R => reset_modified
    );
\rd_data_reg_reg[28]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => rd_data(28),
      Q => \n_0_rd_data_reg_reg[28]\,
      R => reset_modified
    );
\rd_data_reg_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => rd_data(2),
      Q => \n_0_rd_data_reg_reg[2]\,
      R => reset_modified
    );
\rd_data_reg_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => rd_data(3),
      Q => \n_0_rd_data_reg_reg[3]\,
      R => reset_modified
    );
\rd_data_reg_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => rd_data(4),
      Q => \n_0_rd_data_reg_reg[4]\,
      R => reset_modified
    );
\rd_data_reg_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => rd_data(5),
      Q => \n_0_rd_data_reg_reg[5]\,
      R => reset_modified
    );
\rd_data_reg_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => rd_data(6),
      Q => \n_0_rd_data_reg_reg[6]\,
      R => reset_modified
    );
\rd_data_reg_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => rd_data(7),
      Q => \n_0_rd_data_reg_reg[7]\,
      R => reset_modified
    );
\rd_data_reg_reg[8]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => rd_data(8),
      Q => \n_0_rd_data_reg_reg[8]\,
      R => reset_modified
    );
\rd_data_reg_reg[9]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => rd_enable,
      D => rd_data(9),
      Q => \n_0_rd_data_reg_reg[9]\,
      R => reset_modified
    );
rd_enable_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000FFFE0000"
    )
    port map (
      I0 => n_0_rd_enable_i_2,
      I1 => n_0_rd_enable_i_3,
      I2 => n_0_rd_enable_i_4,
      I3 => n_0_rd_enable_i_5,
      I4 => even,
      I5 => reset_modified,
      O => n_0_rd_enable_i_1
    );
rd_enable_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF80000000"
    )
    port map (
      I0 => rd_occupancy(4),
      I1 => rd_occupancy(3),
      I2 => rd_occupancy(2),
      I3 => rd_occupancy(0),
      I4 => rd_occupancy(1),
      I5 => rd_data(11),
      O => n_0_rd_enable_i_2
    );
rd_enable_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFDFF"
    )
    port map (
      I0 => rd_data(18),
      I1 => rd_data(2),
      I2 => rd_data(22),
      I3 => rd_data(21),
      I4 => rd_data(5),
      I5 => rd_data(7),
      O => n_0_rd_enable_i_3
    );
rd_enable_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFDFFFFFFFFFF"
    )
    port map (
      I0 => rd_data(19),
      I1 => rd_occupancy(5),
      I2 => rd_data(16),
      I3 => rd_data(23),
      I4 => rd_data(0),
      I5 => rd_data(4),
      O => n_0_rd_enable_i_4
    );
rd_enable_i_5: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFDFFFFFFFFFF"
    )
    port map (
      I0 => rd_data(27),
      I1 => rd_data(17),
      I2 => rd_data(3),
      I3 => rd_data(6),
      I4 => rd_data(1),
      I5 => rd_data(20),
      O => n_0_rd_enable_i_5
    );
rd_enable_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => n_0_rd_enable_i_1,
      Q => rd_enable,
      R => '0'
    );
\rd_occupancy_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => rd_occupancy02_out(0),
      Q => rd_occupancy(0),
      R => reset_modified
    );
\rd_occupancy_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => rd_occupancy02_out(1),
      Q => rd_occupancy(1),
      R => reset_modified
    );
\rd_occupancy_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => rd_occupancy02_out(2),
      Q => rd_occupancy(2),
      R => reset_modified
    );
\rd_occupancy_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => rd_occupancy02_out(3),
      Q => rd_occupancy(3),
      R => reset_modified
    );
\rd_occupancy_reg[3]_i_1\: unisim.vcomponents.CARRY4
    port map (
      CI => '0',
      CO(3) => \n_0_rd_occupancy_reg[3]_i_1\,
      CO(2) => \n_1_rd_occupancy_reg[3]_i_1\,
      CO(1) => \n_2_rd_occupancy_reg[3]_i_1\,
      CO(0) => \n_3_rd_occupancy_reg[3]_i_1\,
      CYINIT => '1',
      DI(3 downto 0) => p_0_in1_in1_in(3 downto 0),
      O(3 downto 0) => rd_occupancy02_out(3 downto 0),
      S(3) => \n_2_reclock_wr_addrgray[4].sync_wr_addrgray\,
      S(2) => \n_0_reclock_wr_addrgray[3].sync_wr_addrgray\,
      S(1) => \n_3_reclock_wr_addrgray[4].sync_wr_addrgray\,
      S(0) => \n_1_reclock_wr_addrgray[3].sync_wr_addrgray\
    );
\rd_occupancy_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => rd_occupancy02_out(4),
      Q => rd_occupancy(4),
      R => reset_modified
    );
\rd_occupancy_reg[5]\: unisim.vcomponents.FDSE
    port map (
      C => CLK,
      CE => '1',
      D => rd_occupancy02_out(5),
      Q => rd_occupancy(5),
      S => reset_modified
    );
\rd_occupancy_reg[5]_i_1\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_rd_occupancy_reg[3]_i_1\,
      CO(3 downto 1) => \NLW_rd_occupancy_reg[5]_i_1_CO_UNCONNECTED\(3 downto 1),
      CO(0) => \n_3_rd_occupancy_reg[5]_i_1\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => \n_2_reclock_wr_addrgray[5].sync_wr_addrgray\,
      O(3 downto 2) => \NLW_rd_occupancy_reg[5]_i_1_O_UNCONNECTED\(3 downto 2),
      O(1 downto 0) => rd_occupancy02_out(5 downto 4),
      S(3) => '0',
      S(2) => '0',
      S(1) => \n_0_reclock_wr_addrgray[5].sync_wr_addrgray\,
      S(0) => \n_0_reclock_wr_addrgray[4].sync_wr_addrgray\
    );
\reclock_rd_addrgray[0].sync_rd_addrgray\: entity work.gmii_to_sgmii_gmii_to_sgmii_sync_block
    port map (
      I2 => I2,
      Q(0) => rd_addr_gray(0),
      data_out => \n_0_reclock_rd_addrgray[0].sync_rd_addrgray\
    );
\reclock_rd_addrgray[1].sync_rd_addrgray\: entity work.gmii_to_sgmii_gmii_to_sgmii_sync_block_3
    port map (
      I2 => I2,
      Q(0) => rd_addr_gray(1),
      data_out => p_3_in24_in
    );
\reclock_rd_addrgray[2].sync_rd_addrgray\: entity work.gmii_to_sgmii_gmii_to_sgmii_sync_block_4
    port map (
      I2 => I2,
      Q(0) => rd_addr_gray(2),
      data_out => p_2_in21_in
    );
\reclock_rd_addrgray[3].sync_rd_addrgray\: entity work.gmii_to_sgmii_gmii_to_sgmii_sync_block_5
    port map (
      I1 => \n_0_reclock_rd_addrgray[0].sync_rd_addrgray\,
      I2 => \n_2_reclock_rd_addrgray[5].sync_rd_addrgray\,
      I3 => p_0_in,
      I4 => \n_2_reclock_rd_addrgray[4].sync_rd_addrgray\,
      I5(0) => rd_addr_gray(3),
      I6 => I2,
      Q(1) => \n_0_wr_addr_reg[2]\,
      Q(0) => \n_0_wr_addr_reg[0]\,
      S(1) => \n_0_reclock_rd_addrgray[3].sync_rd_addrgray\,
      S(0) => \n_1_reclock_rd_addrgray[3].sync_rd_addrgray\,
      data_out => p_1_in18_in,
      p_2_in21_in => p_2_in21_in,
      p_3_in24_in => p_3_in24_in
    );
\reclock_rd_addrgray[4].sync_rd_addrgray\: entity work.gmii_to_sgmii_gmii_to_sgmii_sync_block_6
    port map (
      I1 => p_0_in,
      I2(0) => rd_addr_gray(4),
      I3 => I2,
      O1(0) => \n_3_reclock_rd_addrgray[4].sync_rd_addrgray\,
      Q(2) => \n_0_wr_addr_reg[4]\,
      Q(1) => \n_0_wr_addr_reg[3]\,
      Q(0) => \n_0_wr_addr_reg[1]\,
      S(1) => \n_0_reclock_rd_addrgray[4].sync_rd_addrgray\,
      S(0) => \n_1_reclock_rd_addrgray[4].sync_rd_addrgray\,
      data_out => \n_2_reclock_rd_addrgray[4].sync_rd_addrgray\,
      p_1_in18_in => p_1_in18_in,
      p_2_in21_in => p_2_in21_in,
      p_3_in24_in => p_3_in24_in
    );
\reclock_rd_addrgray[5].sync_rd_addrgray\: entity work.gmii_to_sgmii_gmii_to_sgmii_sync_block_7
    port map (
      ADDRD(0) => \n_0_wr_addr_reg[5]\,
      I1 => \n_2_reclock_rd_addrgray[4].sync_rd_addrgray\,
      I2 => I2,
      O1 => \n_2_reclock_rd_addrgray[5].sync_rd_addrgray\,
      Q(0) => rd_addr_gray(5),
      S(0) => \n_0_reclock_rd_addrgray[5].sync_rd_addrgray\,
      data_out => p_0_in
    );
\reclock_wr_addrgray[0].sync_wr_addrgray\: entity work.gmii_to_sgmii_gmii_to_sgmii_sync_block_8
    port map (
      CLK => CLK,
      Q(0) => \n_0_wr_addr_gray_reg[0]\,
      data_out => \n_0_reclock_wr_addrgray[0].sync_wr_addrgray\
    );
\reclock_wr_addrgray[1].sync_wr_addrgray\: entity work.gmii_to_sgmii_gmii_to_sgmii_sync_block_9
    port map (
      CLK => CLK,
      Q(0) => \n_0_wr_addr_gray_reg[1]\,
      data_out => data_out0_out
    );
\reclock_wr_addrgray[2].sync_wr_addrgray\: entity work.gmii_to_sgmii_gmii_to_sgmii_sync_block_10
    port map (
      CLK => CLK,
      Q(0) => \n_0_wr_addr_gray_reg[2]\,
      data_out => data_out1_out
    );
\reclock_wr_addrgray[3].sync_wr_addrgray\: entity work.gmii_to_sgmii_gmii_to_sgmii_sync_block_11
    port map (
      CLK => CLK,
      I1 => \n_0_reclock_wr_addrgray[0].sync_wr_addrgray\,
      I2 => data_out4_out,
      I3 => data_out3_out,
      I4(0) => \n_0_wr_addr_gray_reg[3]\,
      Q(1) => \n_0_rd_addr_reg[2]\,
      Q(0) => \n_0_rd_addr_reg[0]\,
      S(1) => \n_0_reclock_wr_addrgray[3].sync_wr_addrgray\,
      S(0) => \n_1_reclock_wr_addrgray[3].sync_wr_addrgray\,
      data_out => data_out2_out,
      data_out0_out => data_out0_out,
      data_out1_out => data_out1_out,
      p_0_in1_in1_in(0) => p_0_in1_in1_in(4)
    );
\reclock_wr_addrgray[4].sync_wr_addrgray\: entity work.gmii_to_sgmii_gmii_to_sgmii_sync_block_12
    port map (
      CLK => CLK,
      I1 => data_out4_out,
      I2 => \n_0_reclock_wr_addrgray[0].sync_wr_addrgray\,
      I3(0) => \n_0_wr_addr_gray_reg[4]\,
      O1(1) => \n_2_reclock_wr_addrgray[4].sync_wr_addrgray\,
      O1(0) => \n_3_reclock_wr_addrgray[4].sync_wr_addrgray\,
      Q(2) => \n_0_rd_addr_reg[4]\,
      Q(1) => \n_0_rd_addr_reg[3]\,
      Q(0) => \n_0_rd_addr_reg[1]\,
      S(0) => \n_0_reclock_wr_addrgray[4].sync_wr_addrgray\,
      data_out => data_out3_out,
      data_out0_out => data_out0_out,
      data_out1_out => data_out1_out,
      data_out2_out => data_out2_out,
      p_0_in1_in1_in(1) => p_0_in1_in1_in(2),
      p_0_in1_in1_in(0) => p_0_in1_in1_in(0)
    );
\reclock_wr_addrgray[5].sync_wr_addrgray\: entity work.gmii_to_sgmii_gmii_to_sgmii_sync_block_13
    port map (
      CLK => CLK,
      I1(0) => data_in,
      O1(0) => p_0_in1_in1_in(4),
      Q(0) => \n_0_rd_addr_reg[5]\,
      S(0) => \n_0_reclock_wr_addrgray[5].sync_wr_addrgray\,
      data_out => data_out4_out,
      data_out0_out => data_out0_out,
      data_out1_out => data_out1_out,
      data_out2_out => data_out2_out,
      data_out3_out => data_out3_out,
      p_0_in1_in1_in(2) => \n_2_reclock_wr_addrgray[5].sync_wr_addrgray\,
      p_0_in1_in1_in(1) => p_0_in1_in1_in(3),
      p_0_in1_in1_in(0) => p_0_in1_in1_in(1)
    );
remove_idle_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => wr_enable1,
      I1 => \^initialize_ram_complete\,
      I2 => remove_idle,
      O => n_0_remove_idle_i_1
    );
remove_idle_reg: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => n_0_remove_idle_i_1,
      Q => remove_idle,
      R => rxrecreset
    );
reset_modified_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"74"
    )
    port map (
      I0 => initialize_ram_complete_sync_ris_edg,
      I1 => reset_modified,
      I2 => reset_in,
      O => n_0_reset_modified_i_1
    );
reset_modified_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => n_0_reset_modified_i_1,
      Q => reset_modified,
      R => '0'
    );
rxbuferr_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => rxbuferr0,
      I1 => \^rxbufstatus\(0),
      O => n_0_rxbuferr_i_1
    );
rxbuferr_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000800180010001"
    )
    port map (
      I0 => rd_occupancy(3),
      I1 => rd_occupancy(4),
      I2 => rd_occupancy(5),
      I3 => rd_occupancy(2),
      I4 => rd_occupancy(0),
      I5 => rd_occupancy(1),
      O => rxbuferr0
    );
rxbuferr_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => n_0_rxbuferr_i_1,
      Q => \^rxbufstatus\(0),
      R => reset_modified
    );
rxchariscomma_usr_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \n_0_rd_data_reg_reg[28]\,
      I1 => even,
      I2 => \n_0_rd_data_reg_reg[12]\,
      O => n_0_rxchariscomma_usr_i_1
    );
rxchariscomma_usr_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => n_0_rxchariscomma_usr_i_1,
      Q => rxchariscomma(0),
      R => reset_modified
    );
rxcharisk_usr_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \n_0_rd_data_reg_reg[27]\,
      I1 => even,
      I2 => \n_0_rd_data_reg_reg[11]\,
      O => n_0_rxcharisk_usr_i_1
    );
rxcharisk_usr_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => n_0_rxcharisk_usr_i_1,
      Q => rxcharisk(0),
      R => reset_modified
    );
\rxclkcorcnt[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BA"
    )
    port map (
      I0 => \insert_idle_reg__0\,
      I1 => \^rxclkcorcnt\(0),
      I2 => \n_0_rd_data_reg_reg[13]\,
      O => \n_0_rxclkcorcnt[0]_i_1\
    );
\rxclkcorcnt[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00A2"
    )
    port map (
      I0 => \insert_idle_reg__0\,
      I1 => \n_0_rd_data_reg_reg[13]\,
      I2 => \^rxclkcorcnt\(0),
      I3 => reset_modified,
      O => \n_0_rxclkcorcnt[2]_i_1\
    );
\rxclkcorcnt_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => \n_0_rxclkcorcnt[0]_i_1\,
      Q => \^rxclkcorcnt\(0),
      R => reset_modified
    );
\rxclkcorcnt_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => \n_0_rxclkcorcnt[2]_i_1\,
      Q => \^rxclkcorcnt\(1),
      R => '0'
    );
\rxdata_usr[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => \n_0_rd_data_reg_reg[16]\,
      I1 => \n_0_rd_data_reg_reg[0]\,
      I2 => even,
      O => \n_0_rxdata_usr[0]_i_1\
    );
\rxdata_usr[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => \n_0_rd_data_reg_reg[17]\,
      I1 => \n_0_rd_data_reg_reg[1]\,
      I2 => even,
      O => \n_0_rxdata_usr[1]_i_1\
    );
\rxdata_usr[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => \n_0_rd_data_reg_reg[18]\,
      I1 => \n_0_rd_data_reg_reg[2]\,
      I2 => even,
      O => \n_0_rxdata_usr[2]_i_1\
    );
\rxdata_usr[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => \n_0_rd_data_reg_reg[19]\,
      I1 => \n_0_rd_data_reg_reg[3]\,
      I2 => even,
      O => \n_0_rxdata_usr[3]_i_1\
    );
\rxdata_usr[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => \n_0_rd_data_reg_reg[20]\,
      I1 => \n_0_rd_data_reg_reg[4]\,
      I2 => even,
      O => \n_0_rxdata_usr[4]_i_1\
    );
\rxdata_usr[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => \n_0_rd_data_reg_reg[21]\,
      I1 => \n_0_rd_data_reg_reg[5]\,
      I2 => even,
      O => \n_0_rxdata_usr[5]_i_1\
    );
\rxdata_usr[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => \n_0_rd_data_reg_reg[22]\,
      I1 => \n_0_rd_data_reg_reg[6]\,
      I2 => even,
      O => \n_0_rxdata_usr[6]_i_1\
    );
\rxdata_usr[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => \n_0_rd_data_reg_reg[23]\,
      I1 => \n_0_rd_data_reg_reg[7]\,
      I2 => even,
      O => \n_0_rxdata_usr[7]_i_1\
    );
\rxdata_usr_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => \n_0_rxdata_usr[0]_i_1\,
      Q => Q(0),
      R => reset_modified
    );
\rxdata_usr_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => \n_0_rxdata_usr[1]_i_1\,
      Q => Q(1),
      R => reset_modified
    );
\rxdata_usr_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => \n_0_rxdata_usr[2]_i_1\,
      Q => Q(2),
      R => reset_modified
    );
\rxdata_usr_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => \n_0_rxdata_usr[3]_i_1\,
      Q => Q(3),
      R => reset_modified
    );
\rxdata_usr_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => \n_0_rxdata_usr[4]_i_1\,
      Q => Q(4),
      R => reset_modified
    );
\rxdata_usr_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => \n_0_rxdata_usr[5]_i_1\,
      Q => Q(5),
      R => reset_modified
    );
\rxdata_usr_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => \n_0_rxdata_usr[6]_i_1\,
      Q => Q(6),
      R => reset_modified
    );
\rxdata_usr_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => \n_0_rxdata_usr[7]_i_1\,
      Q => Q(7),
      R => reset_modified
    );
rxdisperr_usr_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \n_0_rd_data_reg_reg[26]\,
      I1 => even,
      I2 => \n_0_rd_data_reg_reg[10]\,
      O => n_0_rxdisperr_usr_i_1
    );
rxdisperr_usr_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => n_0_rxdisperr_usr_i_1,
      Q => rxdisperr(0),
      R => reset_modified
    );
rxnotintable_usr_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \n_0_rd_data_reg_reg[25]\,
      I1 => even,
      I2 => \n_0_rd_data_reg_reg[9]\,
      O => n_0_rxnotintable_usr_i_1
    );
rxnotintable_usr_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => n_0_rxnotintable_usr_i_1,
      Q => rxnotintable(0),
      R => reset_modified
    );
rxrundisp_usr_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \n_0_rd_data_reg_reg[24]\,
      I1 => even,
      I2 => \n_0_rd_data_reg_reg[8]\,
      O => n_0_rxrundisp_usr_i_1
    );
rxrundisp_usr_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => n_0_rxrundisp_usr_i_1,
      Q => rxrundisp(0),
      R => reset_modified
    );
start_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
    port map (
      C => I2,
      CE => '1',
      D => '0',
      Q => start,
      R => '0'
    );
sync_initialize_ram_comp: entity work.gmii_to_sgmii_gmii_to_sgmii_sync_block_14
    port map (
      CLK => CLK,
      O1 => n_0_sync_initialize_ram_comp,
      data_in => \^initialize_ram_complete\,
      data_out => data_out,
      initialize_ram_complete_sync_reg1 => initialize_ram_complete_sync_reg1
    );
\wr_addr[5]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FBF8"
    )
    port map (
      I0 => wr_addr1_in(5),
      I1 => wr_enable,
      I2 => \^initialize_ram_complete_pulse\,
      I3 => \n_0_wr_addr_reg[5]\,
      O => \n_0_wr_addr[5]_i_1\
    );
\wr_addr_gray[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => p_1_in6_in,
      I1 => \n_0_wr_addr_plus2_reg[0]\,
      O => p_0_in5_out(0)
    );
\wr_addr_gray[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => p_2_in8_in,
      I1 => p_1_in6_in,
      O => p_0_in5_out(1)
    );
\wr_addr_gray[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => p_3_in10_in,
      I1 => p_2_in8_in,
      O => p_0_in5_out(2)
    );
\wr_addr_gray[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => p_4_in12_in,
      I1 => p_3_in10_in,
      O => p_0_in5_out(3)
    );
\wr_addr_gray[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \n_0_wr_addr_plus2_reg[5]\,
      I1 => p_4_in12_in,
      O => p_0_in5_out(4)
    );
\wr_addr_gray_reg[0]\: unisim.vcomponents.FDSE
    port map (
      C => I2,
      CE => '1',
      D => p_0_in5_out(0),
      Q => \n_0_wr_addr_gray_reg[0]\,
      S => rxrecreset
    );
\wr_addr_gray_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => p_0_in5_out(1),
      Q => \n_0_wr_addr_gray_reg[1]\,
      R => rxrecreset
    );
\wr_addr_gray_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => p_0_in5_out(2),
      Q => \n_0_wr_addr_gray_reg[2]\,
      R => rxrecreset
    );
\wr_addr_gray_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => p_0_in5_out(3),
      Q => \n_0_wr_addr_gray_reg[3]\,
      R => rxrecreset
    );
\wr_addr_gray_reg[4]\: unisim.vcomponents.FDSE
    port map (
      C => I2,
      CE => '1',
      D => p_0_in5_out(4),
      Q => \n_0_wr_addr_gray_reg[4]\,
      S => rxrecreset
    );
\wr_addr_gray_reg[5]\: unisim.vcomponents.FDSE
    port map (
      C => I2,
      CE => '1',
      D => \n_0_wr_addr_plus2_reg[5]\,
      Q => data_in,
      S => rxrecreset
    );
\wr_addr_plus1[5]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FBF8"
    )
    port map (
      I0 => \n_0_wr_addr_plus2_reg[5]\,
      I1 => wr_enable,
      I2 => \^initialize_ram_complete_pulse\,
      I3 => wr_addr1_in(5),
      O => \n_0_wr_addr_plus1[5]_i_1\
    );
\wr_addr_plus1_reg[0]\: unisim.vcomponents.FDSE
    port map (
      C => I2,
      CE => wr_enable,
      D => \n_0_wr_addr_plus2_reg[0]\,
      Q => wr_addr1_in(0),
      S => I1(0)
    );
\wr_addr_plus1_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => wr_enable,
      D => p_1_in6_in,
      Q => wr_addr1_in(1),
      R => I1(0)
    );
\wr_addr_plus1_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => wr_enable,
      D => p_2_in8_in,
      Q => wr_addr1_in(2),
      R => I1(0)
    );
\wr_addr_plus1_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => wr_enable,
      D => p_3_in10_in,
      Q => wr_addr1_in(3),
      R => I1(0)
    );
\wr_addr_plus1_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => wr_enable,
      D => p_4_in12_in,
      Q => wr_addr1_in(4),
      R => I1(0)
    );
\wr_addr_plus1_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => \n_0_wr_addr_plus1[5]_i_1\,
      Q => wr_addr1_in(5),
      R => rxrecreset
    );
\wr_addr_plus2[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \n_0_wr_addr_plus2_reg[0]\,
      O => plusOp(0)
    );
\wr_addr_plus2[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \n_0_wr_addr_plus2_reg[0]\,
      I1 => p_1_in6_in,
      O => plusOp(1)
    );
\wr_addr_plus2[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
    port map (
      I0 => \n_0_wr_addr_plus2_reg[0]\,
      I1 => p_1_in6_in,
      I2 => p_2_in8_in,
      O => plusOp(2)
    );
\wr_addr_plus2[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
    port map (
      I0 => p_1_in6_in,
      I1 => \n_0_wr_addr_plus2_reg[0]\,
      I2 => p_2_in8_in,
      I3 => p_3_in10_in,
      O => plusOp(3)
    );
\wr_addr_plus2[4]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFF8000"
    )
    port map (
      I0 => p_2_in8_in,
      I1 => \n_0_wr_addr_plus2_reg[0]\,
      I2 => p_1_in6_in,
      I3 => p_3_in10_in,
      I4 => p_4_in12_in,
      O => plusOp(4)
    );
\wr_addr_plus2[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF7FFF80"
    )
    port map (
      I0 => p_4_in12_in,
      I1 => \n_0_wr_addr_plus2[5]_i_2\,
      I2 => wr_enable,
      I3 => \^initialize_ram_complete_pulse\,
      I4 => \n_0_wr_addr_plus2_reg[5]\,
      O => \n_0_wr_addr_plus2[5]_i_1\
    );
\wr_addr_plus2[5]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => p_3_in10_in,
      I1 => p_1_in6_in,
      I2 => \n_0_wr_addr_plus2_reg[0]\,
      I3 => p_2_in8_in,
      O => \n_0_wr_addr_plus2[5]_i_2\
    );
\wr_addr_plus2_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => wr_enable,
      D => plusOp(0),
      Q => \n_0_wr_addr_plus2_reg[0]\,
      R => I1(0)
    );
\wr_addr_plus2_reg[1]\: unisim.vcomponents.FDSE
    port map (
      C => I2,
      CE => wr_enable,
      D => plusOp(1),
      Q => p_1_in6_in,
      S => I1(0)
    );
\wr_addr_plus2_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => wr_enable,
      D => plusOp(2),
      Q => p_2_in8_in,
      R => I1(0)
    );
\wr_addr_plus2_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => wr_enable,
      D => plusOp(3),
      Q => p_3_in10_in,
      R => I1(0)
    );
\wr_addr_plus2_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => wr_enable,
      D => plusOp(4),
      Q => p_4_in12_in,
      R => I1(0)
    );
\wr_addr_plus2_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => \n_0_wr_addr_plus2[5]_i_1\,
      Q => \n_0_wr_addr_plus2_reg[5]\,
      R => rxrecreset
    );
\wr_addr_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => wr_enable,
      D => wr_addr1_in(0),
      Q => \n_0_wr_addr_reg[0]\,
      R => I1(0)
    );
\wr_addr_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => wr_enable,
      D => wr_addr1_in(1),
      Q => \n_0_wr_addr_reg[1]\,
      R => I1(0)
    );
\wr_addr_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => wr_enable,
      D => wr_addr1_in(2),
      Q => \n_0_wr_addr_reg[2]\,
      R => I1(0)
    );
\wr_addr_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => wr_enable,
      D => wr_addr1_in(3),
      Q => \n_0_wr_addr_reg[3]\,
      R => I1(0)
    );
\wr_addr_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => wr_enable,
      D => wr_addr1_in(4),
      Q => \n_0_wr_addr_reg[4]\,
      R => I1(0)
    );
\wr_addr_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => \n_0_wr_addr[5]_i_1\,
      Q => \n_0_wr_addr_reg[5]\,
      R => rxrecreset
    );
\wr_data_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => D(0),
      Q => \n_0_wr_data_reg[0]\,
      R => SR(0)
    );
\wr_data_reg[10]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => D(9),
      Q => \n_0_wr_data_reg[10]\,
      R => SR(0)
    );
\wr_data_reg[11]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => D(10),
      Q => \n_0_wr_data_reg[11]\,
      R => SR(0)
    );
\wr_data_reg[12]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => D(11),
      Q => \n_0_wr_data_reg[12]\,
      R => SR(0)
    );
\wr_data_reg[16]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => D(12),
      Q => \n_0_wr_data_reg[16]\,
      R => SR(0)
    );
\wr_data_reg[17]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => D(13),
      Q => \n_0_wr_data_reg[17]\,
      R => SR(0)
    );
\wr_data_reg[18]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => D(14),
      Q => \n_0_wr_data_reg[18]\,
      R => SR(0)
    );
\wr_data_reg[19]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => D(15),
      Q => \n_0_wr_data_reg[19]\,
      R => SR(0)
    );
\wr_data_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => D(1),
      Q => \n_0_wr_data_reg[1]\,
      R => SR(0)
    );
\wr_data_reg[20]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => D(16),
      Q => \n_0_wr_data_reg[20]\,
      R => SR(0)
    );
\wr_data_reg[21]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => D(17),
      Q => \n_0_wr_data_reg[21]\,
      R => SR(0)
    );
\wr_data_reg[22]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => D(18),
      Q => \n_0_wr_data_reg[22]\,
      R => SR(0)
    );
\wr_data_reg[23]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => D(19),
      Q => \n_0_wr_data_reg[23]\,
      R => SR(0)
    );
\wr_data_reg[25]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => D(20),
      Q => \n_0_wr_data_reg[25]\,
      R => SR(0)
    );
\wr_data_reg[26]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => D(21),
      Q => \n_0_wr_data_reg[26]\,
      R => SR(0)
    );
\wr_data_reg[27]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => D(22),
      Q => p_0_in5_in,
      R => SR(0)
    );
\wr_data_reg[28]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => D(23),
      Q => \n_0_wr_data_reg[28]\,
      R => SR(0)
    );
\wr_data_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => D(2),
      Q => \n_0_wr_data_reg[2]\,
      R => SR(0)
    );
\wr_data_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => D(3),
      Q => \n_0_wr_data_reg[3]\,
      R => SR(0)
    );
\wr_data_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => D(4),
      Q => \n_0_wr_data_reg[4]\,
      R => SR(0)
    );
\wr_data_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => D(5),
      Q => \n_0_wr_data_reg[5]\,
      R => SR(0)
    );
\wr_data_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => D(6),
      Q => \n_0_wr_data_reg[6]\,
      R => SR(0)
    );
\wr_data_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => D(7),
      Q => \n_0_wr_data_reg[7]\,
      R => SR(0)
    );
\wr_data_reg[9]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => D(8),
      Q => \n_0_wr_data_reg[9]\,
      R => SR(0)
    );
\wr_data_reg_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => \n_0_wr_data_reg[0]\,
      Q => \wr_data_reg__0\(0),
      R => SR(0)
    );
\wr_data_reg_reg[10]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => \n_0_wr_data_reg[10]\,
      Q => \wr_data_reg__0\(10),
      R => SR(0)
    );
\wr_data_reg_reg[11]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => \n_0_wr_data_reg[11]\,
      Q => \wr_data_reg__0\(11),
      R => SR(0)
    );
\wr_data_reg_reg[12]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => \n_0_wr_data_reg[12]\,
      Q => \wr_data_reg__0\(12),
      R => SR(0)
    );
\wr_data_reg_reg[13]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => remove_idle,
      Q => \wr_data_reg__0\(13),
      R => SR(0)
    );
\wr_data_reg_reg[16]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => \n_0_wr_data_reg[16]\,
      Q => \wr_data_reg__0\(16),
      R => SR(0)
    );
\wr_data_reg_reg[17]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => \n_0_wr_data_reg[17]\,
      Q => \wr_data_reg__0\(17),
      R => SR(0)
    );
\wr_data_reg_reg[18]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => \n_0_wr_data_reg[18]\,
      Q => \wr_data_reg__0\(18),
      R => SR(0)
    );
\wr_data_reg_reg[19]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => \n_0_wr_data_reg[19]\,
      Q => \wr_data_reg__0\(19),
      R => SR(0)
    );
\wr_data_reg_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => \n_0_wr_data_reg[1]\,
      Q => \wr_data_reg__0\(1),
      R => SR(0)
    );
\wr_data_reg_reg[20]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => \n_0_wr_data_reg[20]\,
      Q => \wr_data_reg__0\(20),
      R => SR(0)
    );
\wr_data_reg_reg[21]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => \n_0_wr_data_reg[21]\,
      Q => \wr_data_reg__0\(21),
      R => SR(0)
    );
\wr_data_reg_reg[22]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => \n_0_wr_data_reg[22]\,
      Q => \wr_data_reg__0\(22),
      R => SR(0)
    );
\wr_data_reg_reg[23]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => \n_0_wr_data_reg[23]\,
      Q => \wr_data_reg__0\(23),
      R => SR(0)
    );
\wr_data_reg_reg[25]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => \n_0_wr_data_reg[25]\,
      Q => \wr_data_reg__0\(25),
      R => SR(0)
    );
\wr_data_reg_reg[26]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => \n_0_wr_data_reg[26]\,
      Q => \wr_data_reg__0\(26),
      R => SR(0)
    );
\wr_data_reg_reg[27]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => p_0_in5_in,
      Q => \wr_data_reg__0\(27),
      R => SR(0)
    );
\wr_data_reg_reg[28]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => \n_0_wr_data_reg[28]\,
      Q => \wr_data_reg__0\(28),
      R => SR(0)
    );
\wr_data_reg_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => \n_0_wr_data_reg[2]\,
      Q => \wr_data_reg__0\(2),
      R => SR(0)
    );
\wr_data_reg_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => \n_0_wr_data_reg[3]\,
      Q => \wr_data_reg__0\(3),
      R => SR(0)
    );
\wr_data_reg_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => \n_0_wr_data_reg[4]\,
      Q => \wr_data_reg__0\(4),
      R => SR(0)
    );
\wr_data_reg_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => \n_0_wr_data_reg[5]\,
      Q => \wr_data_reg__0\(5),
      R => SR(0)
    );
\wr_data_reg_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => \n_0_wr_data_reg[6]\,
      Q => \wr_data_reg__0\(6),
      R => SR(0)
    );
\wr_data_reg_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => \n_0_wr_data_reg[7]\,
      Q => \wr_data_reg__0\(7),
      R => SR(0)
    );
\wr_data_reg_reg[9]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => \n_0_wr_data_reg[9]\,
      Q => \wr_data_reg__0\(9),
      R => SR(0)
    );
wr_enable_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
    port map (
      I0 => \^initialize_ram_complete\,
      I1 => wr_enable1,
      O => n_0_wr_enable_i_1
    );
wr_enable_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0080000000000000"
    )
    port map (
      I0 => n_0_k28p5_wr_reg_i_2,
      I1 => n_0_wr_enable_i_3,
      I2 => n_0_wr_enable_i_4,
      I3 => n_0_wr_enable_i_5,
      I4 => n_0_wr_enable_i_6,
      I5 => n_0_d16p2_wr_reg_i_2,
      O => wr_enable1
    );
wr_enable_i_3: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
    port map (
      I0 => \n_0_wr_data_reg[17]\,
      I1 => \n_0_wr_data_reg[18]\,
      I2 => \n_0_wr_data_reg[16]\,
      O => n_0_wr_enable_i_3
    );
wr_enable_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0800"
    )
    port map (
      I0 => k28p5_wr_reg,
      I1 => d16p2_wr_reg,
      I2 => remove_idle,
      I3 => wr_occupancy(5),
      O => n_0_wr_enable_i_4
    );
wr_enable_i_5: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => wr_occupancy(2),
      I1 => wr_occupancy(1),
      I2 => wr_occupancy(3),
      I3 => wr_occupancy(4),
      O => n_0_wr_enable_i_5
    );
wr_enable_i_6: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
    port map (
      I0 => \n_0_wr_data_reg[2]\,
      I1 => \n_0_wr_data_reg[1]\,
      I2 => \n_0_wr_data_reg[0]\,
      O => n_0_wr_enable_i_6
    );
wr_enable_reg: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => n_0_wr_enable_i_1,
      Q => wr_enable,
      R => rxrecreset
    );
\wr_occupancy_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => wr_occupancy00_out(1),
      Q => wr_occupancy(1),
      R => SR(0)
    );
\wr_occupancy_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => wr_occupancy00_out(2),
      Q => wr_occupancy(2),
      R => SR(0)
    );
\wr_occupancy_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => wr_occupancy00_out(3),
      Q => wr_occupancy(3),
      R => SR(0)
    );
\wr_occupancy_reg[3]_i_1\: unisim.vcomponents.CARRY4
    port map (
      CI => '0',
      CO(3) => \n_0_wr_occupancy_reg[3]_i_1\,
      CO(2) => \n_1_wr_occupancy_reg[3]_i_1\,
      CO(1) => \n_2_wr_occupancy_reg[3]_i_1\,
      CO(0) => \n_3_wr_occupancy_reg[3]_i_1\,
      CYINIT => '1',
      DI(3) => \n_0_wr_addr_reg[3]\,
      DI(2) => \n_0_wr_addr_reg[2]\,
      DI(1) => \n_0_wr_addr_reg[1]\,
      DI(0) => \n_0_wr_addr_reg[0]\,
      O(3 downto 1) => wr_occupancy00_out(3 downto 1),
      O(0) => \NLW_wr_occupancy_reg[3]_i_1_O_UNCONNECTED\(0),
      S(3) => \n_0_reclock_rd_addrgray[4].sync_rd_addrgray\,
      S(2) => \n_0_reclock_rd_addrgray[3].sync_rd_addrgray\,
      S(1) => \n_1_reclock_rd_addrgray[4].sync_rd_addrgray\,
      S(0) => \n_1_reclock_rd_addrgray[3].sync_rd_addrgray\
    );
\wr_occupancy_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => I2,
      CE => '1',
      D => wr_occupancy00_out(4),
      Q => wr_occupancy(4),
      R => SR(0)
    );
\wr_occupancy_reg[5]\: unisim.vcomponents.FDSE
    port map (
      C => I2,
      CE => '1',
      D => wr_occupancy00_out(5),
      Q => wr_occupancy(5),
      S => SR(0)
    );
\wr_occupancy_reg[5]_i_1\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_wr_occupancy_reg[3]_i_1\,
      CO(3 downto 1) => \NLW_wr_occupancy_reg[5]_i_1_CO_UNCONNECTED\(3 downto 1),
      CO(0) => \n_3_wr_occupancy_reg[5]_i_1\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => \n_0_wr_addr_reg[4]\,
      O(3 downto 2) => \NLW_wr_occupancy_reg[5]_i_1_O_UNCONNECTED\(3 downto 2),
      O(1 downto 0) => wr_occupancy00_out(5 downto 4),
      S(3) => '0',
      S(2) => '0',
      S(1) => \n_0_reclock_rd_addrgray[5].sync_rd_addrgray\,
      S(0) => \n_3_reclock_rd_addrgray[4].sync_rd_addrgray\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \gmii_to_sgmii_gig_ethernet_pcs_pma_v14_3__parameterized0\ is
  port (
    reset : in STD_LOGIC;
    signal_detect : in STD_LOGIC;
    link_timer_value : in STD_LOGIC_VECTOR ( 8 downto 0 );
    link_timer_basex : in STD_LOGIC_VECTOR ( 8 downto 0 );
    link_timer_sgmii : in STD_LOGIC_VECTOR ( 8 downto 0 );
    mgt_rx_reset : out STD_LOGIC;
    mgt_tx_reset : out STD_LOGIC;
    userclk : in STD_LOGIC;
    userclk2 : in STD_LOGIC;
    dcm_locked : in STD_LOGIC;
    rxbufstatus : in STD_LOGIC_VECTOR ( 1 downto 0 );
    rxchariscomma : in STD_LOGIC_VECTOR ( 0 to 0 );
    rxcharisk : in STD_LOGIC_VECTOR ( 0 to 0 );
    rxclkcorcnt : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
    rxdisperr : in STD_LOGIC_VECTOR ( 0 to 0 );
    rxnotintable : in STD_LOGIC_VECTOR ( 0 to 0 );
    rxrundisp : in STD_LOGIC_VECTOR ( 0 to 0 );
    txbuferr : in STD_LOGIC;
    powerdown : out STD_LOGIC;
    txchardispmode : out STD_LOGIC;
    txchardispval : out STD_LOGIC;
    txcharisk : out STD_LOGIC;
    txdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    enablealign : out STD_LOGIC;
    gtx_clk : in STD_LOGIC;
    tx_code_group : out STD_LOGIC_VECTOR ( 9 downto 0 );
    loc_ref : out STD_LOGIC;
    ewrap : out STD_LOGIC;
    rx_code_group0 : in STD_LOGIC_VECTOR ( 9 downto 0 );
    rx_code_group1 : in STD_LOGIC_VECTOR ( 9 downto 0 );
    pma_rx_clk0 : in STD_LOGIC;
    pma_rx_clk1 : in STD_LOGIC;
    en_cdet : out STD_LOGIC;
    gmii_txd : in STD_LOGIC_VECTOR ( 7 downto 0 );
    gmii_tx_en : in STD_LOGIC;
    gmii_tx_er : in STD_LOGIC;
    gmii_rxd : out STD_LOGIC_VECTOR ( 7 downto 0 );
    gmii_rx_dv : out STD_LOGIC;
    gmii_rx_er : out STD_LOGIC;
    gmii_isolate : out STD_LOGIC;
    an_interrupt : out STD_LOGIC;
    an_enable : out STD_LOGIC;
    speed_selection : out STD_LOGIC_VECTOR ( 1 downto 0 );
    phyad : in STD_LOGIC_VECTOR ( 4 downto 0 );
    mdc : in STD_LOGIC;
    mdio_in : in STD_LOGIC;
    mdio_out : out STD_LOGIC;
    mdio_tri : out STD_LOGIC;
    an_adv_config_vector : in STD_LOGIC_VECTOR ( 15 downto 0 );
    an_adv_config_val : in STD_LOGIC;
    an_restart_config : in STD_LOGIC;
    configuration_vector : in STD_LOGIC_VECTOR ( 4 downto 0 );
    configuration_valid : in STD_LOGIC;
    status_vector : out STD_LOGIC_VECTOR ( 15 downto 0 );
    basex_or_sgmii : in STD_LOGIC;
    drp_dclk : in STD_LOGIC;
    drp_req : out STD_LOGIC;
    drp_gnt : in STD_LOGIC;
    drp_den : out STD_LOGIC;
    drp_dwe : out STD_LOGIC;
    drp_drdy : in STD_LOGIC;
    drp_daddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    drp_di : out STD_LOGIC_VECTOR ( 15 downto 0 );
    drp_do : in STD_LOGIC_VECTOR ( 15 downto 0 );
    systemtimer_s_field : in STD_LOGIC_VECTOR ( 47 downto 0 );
    systemtimer_ns_field : in STD_LOGIC_VECTOR ( 31 downto 0 );
    correction_timer : in STD_LOGIC_VECTOR ( 63 downto 0 );
    rxrecclk : in STD_LOGIC;
    rxphy_s_field : out STD_LOGIC_VECTOR ( 47 downto 0 );
    rxphy_ns_field : out STD_LOGIC_VECTOR ( 31 downto 0 );
    rxphy_correction_timer : out STD_LOGIC_VECTOR ( 63 downto 0 );
    reset_done : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \gmii_to_sgmii_gig_ethernet_pcs_pma_v14_3__parameterized0\ : entity is "gig_ethernet_pcs_pma_v14_3";
  attribute C_ELABORATION_TRANSIENT_DIR : string;
  attribute C_ELABORATION_TRANSIENT_DIR of \gmii_to_sgmii_gig_ethernet_pcs_pma_v14_3__parameterized0\ : entity is "BlankString";
  attribute C_COMPONENT_NAME : string;
  attribute C_COMPONENT_NAME of \gmii_to_sgmii_gig_ethernet_pcs_pma_v14_3__parameterized0\ : entity is "gmii_to_sgmii";
  attribute C_FAMILY : string;
  attribute C_FAMILY of \gmii_to_sgmii_gig_ethernet_pcs_pma_v14_3__parameterized0\ : entity is "virtex7";
  attribute C_IS_SGMII : string;
  attribute C_IS_SGMII of \gmii_to_sgmii_gig_ethernet_pcs_pma_v14_3__parameterized0\ : entity is "TRUE";
  attribute C_USE_TRANSCEIVER : string;
  attribute C_USE_TRANSCEIVER of \gmii_to_sgmii_gig_ethernet_pcs_pma_v14_3__parameterized0\ : entity is "TRUE";
  attribute C_HAS_TEMAC : string;
  attribute C_HAS_TEMAC of \gmii_to_sgmii_gig_ethernet_pcs_pma_v14_3__parameterized0\ : entity is "TRUE";
  attribute C_USE_TBI : string;
  attribute C_USE_TBI of \gmii_to_sgmii_gig_ethernet_pcs_pma_v14_3__parameterized0\ : entity is "FALSE";
  attribute C_USE_LVDS : string;
  attribute C_USE_LVDS of \gmii_to_sgmii_gig_ethernet_pcs_pma_v14_3__parameterized0\ : entity is "FALSE";
  attribute C_HAS_AN : string;
  attribute C_HAS_AN of \gmii_to_sgmii_gig_ethernet_pcs_pma_v14_3__parameterized0\ : entity is "TRUE";
  attribute C_HAS_MDIO : string;
  attribute C_HAS_MDIO of \gmii_to_sgmii_gig_ethernet_pcs_pma_v14_3__parameterized0\ : entity is "FALSE";
  attribute C_SGMII_PHY_MODE : string;
  attribute C_SGMII_PHY_MODE of \gmii_to_sgmii_gig_ethernet_pcs_pma_v14_3__parameterized0\ : entity is "FALSE";
  attribute C_DYNAMIC_SWITCHING : string;
  attribute C_DYNAMIC_SWITCHING of \gmii_to_sgmii_gig_ethernet_pcs_pma_v14_3__parameterized0\ : entity is "FALSE";
  attribute C_TRANSCEIVER_MODE : string;
  attribute C_TRANSCEIVER_MODE of \gmii_to_sgmii_gig_ethernet_pcs_pma_v14_3__parameterized0\ : entity is "A";
  attribute C_SGMII_FABRIC_BUFFER : string;
  attribute C_SGMII_FABRIC_BUFFER of \gmii_to_sgmii_gig_ethernet_pcs_pma_v14_3__parameterized0\ : entity is "TRUE";
  attribute C_1588 : integer;
  attribute C_1588 of \gmii_to_sgmii_gig_ethernet_pcs_pma_v14_3__parameterized0\ : entity is 0;
  attribute B_SHIFTER_ADDR : string;
  attribute B_SHIFTER_ADDR of \gmii_to_sgmii_gig_ethernet_pcs_pma_v14_3__parameterized0\ : entity is "8'b01010000";
  attribute RX_GT_NOMINAL_LATENCY : string;
  attribute RX_GT_NOMINAL_LATENCY of \gmii_to_sgmii_gig_ethernet_pcs_pma_v14_3__parameterized0\ : entity is "16'b0000000011010010";
  attribute GT_RX_BYTE_WIDTH : integer;
  attribute GT_RX_BYTE_WIDTH of \gmii_to_sgmii_gig_ethernet_pcs_pma_v14_3__parameterized0\ : entity is 1;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of \gmii_to_sgmii_gig_ethernet_pcs_pma_v14_3__parameterized0\ : entity is "yes";
end \gmii_to_sgmii_gig_ethernet_pcs_pma_v14_3__parameterized0\;

architecture STRUCTURE of \gmii_to_sgmii_gig_ethernet_pcs_pma_v14_3__parameterized0\ is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal \^status_vector\ : STD_LOGIC_VECTOR ( 13 downto 0 );
begin
  an_enable <= \<const0>\;
  drp_daddr(8) <= \<const0>\;
  drp_daddr(7) <= \<const0>\;
  drp_daddr(6) <= \<const0>\;
  drp_daddr(5) <= \<const0>\;
  drp_daddr(4) <= \<const0>\;
  drp_daddr(3) <= \<const0>\;
  drp_daddr(2) <= \<const0>\;
  drp_daddr(1) <= \<const0>\;
  drp_daddr(0) <= \<const0>\;
  drp_den <= \<const0>\;
  drp_di(15) <= \<const0>\;
  drp_di(14) <= \<const0>\;
  drp_di(13) <= \<const0>\;
  drp_di(12) <= \<const0>\;
  drp_di(11) <= \<const0>\;
  drp_di(10) <= \<const0>\;
  drp_di(9) <= \<const0>\;
  drp_di(8) <= \<const0>\;
  drp_di(7) <= \<const0>\;
  drp_di(6) <= \<const0>\;
  drp_di(5) <= \<const0>\;
  drp_di(4) <= \<const0>\;
  drp_di(3) <= \<const0>\;
  drp_di(2) <= \<const0>\;
  drp_di(1) <= \<const0>\;
  drp_di(0) <= \<const0>\;
  drp_dwe <= \<const0>\;
  drp_req <= \<const0>\;
  en_cdet <= \<const0>\;
  ewrap <= \<const0>\;
  loc_ref <= \<const0>\;
  mdio_out <= \<const1>\;
  mdio_tri <= \<const1>\;
  rxphy_correction_timer(63) <= \<const0>\;
  rxphy_correction_timer(62) <= \<const0>\;
  rxphy_correction_timer(61) <= \<const0>\;
  rxphy_correction_timer(60) <= \<const0>\;
  rxphy_correction_timer(59) <= \<const0>\;
  rxphy_correction_timer(58) <= \<const0>\;
  rxphy_correction_timer(57) <= \<const0>\;
  rxphy_correction_timer(56) <= \<const0>\;
  rxphy_correction_timer(55) <= \<const0>\;
  rxphy_correction_timer(54) <= \<const0>\;
  rxphy_correction_timer(53) <= \<const0>\;
  rxphy_correction_timer(52) <= \<const0>\;
  rxphy_correction_timer(51) <= \<const0>\;
  rxphy_correction_timer(50) <= \<const0>\;
  rxphy_correction_timer(49) <= \<const0>\;
  rxphy_correction_timer(48) <= \<const0>\;
  rxphy_correction_timer(47) <= \<const0>\;
  rxphy_correction_timer(46) <= \<const0>\;
  rxphy_correction_timer(45) <= \<const0>\;
  rxphy_correction_timer(44) <= \<const0>\;
  rxphy_correction_timer(43) <= \<const0>\;
  rxphy_correction_timer(42) <= \<const0>\;
  rxphy_correction_timer(41) <= \<const0>\;
  rxphy_correction_timer(40) <= \<const0>\;
  rxphy_correction_timer(39) <= \<const0>\;
  rxphy_correction_timer(38) <= \<const0>\;
  rxphy_correction_timer(37) <= \<const0>\;
  rxphy_correction_timer(36) <= \<const0>\;
  rxphy_correction_timer(35) <= \<const0>\;
  rxphy_correction_timer(34) <= \<const0>\;
  rxphy_correction_timer(33) <= \<const0>\;
  rxphy_correction_timer(32) <= \<const0>\;
  rxphy_correction_timer(31) <= \<const0>\;
  rxphy_correction_timer(30) <= \<const0>\;
  rxphy_correction_timer(29) <= \<const0>\;
  rxphy_correction_timer(28) <= \<const0>\;
  rxphy_correction_timer(27) <= \<const0>\;
  rxphy_correction_timer(26) <= \<const0>\;
  rxphy_correction_timer(25) <= \<const0>\;
  rxphy_correction_timer(24) <= \<const0>\;
  rxphy_correction_timer(23) <= \<const0>\;
  rxphy_correction_timer(22) <= \<const0>\;
  rxphy_correction_timer(21) <= \<const0>\;
  rxphy_correction_timer(20) <= \<const0>\;
  rxphy_correction_timer(19) <= \<const0>\;
  rxphy_correction_timer(18) <= \<const0>\;
  rxphy_correction_timer(17) <= \<const0>\;
  rxphy_correction_timer(16) <= \<const0>\;
  rxphy_correction_timer(15) <= \<const0>\;
  rxphy_correction_timer(14) <= \<const0>\;
  rxphy_correction_timer(13) <= \<const0>\;
  rxphy_correction_timer(12) <= \<const0>\;
  rxphy_correction_timer(11) <= \<const0>\;
  rxphy_correction_timer(10) <= \<const0>\;
  rxphy_correction_timer(9) <= \<const0>\;
  rxphy_correction_timer(8) <= \<const0>\;
  rxphy_correction_timer(7) <= \<const0>\;
  rxphy_correction_timer(6) <= \<const0>\;
  rxphy_correction_timer(5) <= \<const0>\;
  rxphy_correction_timer(4) <= \<const0>\;
  rxphy_correction_timer(3) <= \<const0>\;
  rxphy_correction_timer(2) <= \<const0>\;
  rxphy_correction_timer(1) <= \<const0>\;
  rxphy_correction_timer(0) <= \<const0>\;
  rxphy_ns_field(31) <= \<const0>\;
  rxphy_ns_field(30) <= \<const0>\;
  rxphy_ns_field(29) <= \<const0>\;
  rxphy_ns_field(28) <= \<const0>\;
  rxphy_ns_field(27) <= \<const0>\;
  rxphy_ns_field(26) <= \<const0>\;
  rxphy_ns_field(25) <= \<const0>\;
  rxphy_ns_field(24) <= \<const0>\;
  rxphy_ns_field(23) <= \<const0>\;
  rxphy_ns_field(22) <= \<const0>\;
  rxphy_ns_field(21) <= \<const0>\;
  rxphy_ns_field(20) <= \<const0>\;
  rxphy_ns_field(19) <= \<const0>\;
  rxphy_ns_field(18) <= \<const0>\;
  rxphy_ns_field(17) <= \<const0>\;
  rxphy_ns_field(16) <= \<const0>\;
  rxphy_ns_field(15) <= \<const0>\;
  rxphy_ns_field(14) <= \<const0>\;
  rxphy_ns_field(13) <= \<const0>\;
  rxphy_ns_field(12) <= \<const0>\;
  rxphy_ns_field(11) <= \<const0>\;
  rxphy_ns_field(10) <= \<const0>\;
  rxphy_ns_field(9) <= \<const0>\;
  rxphy_ns_field(8) <= \<const0>\;
  rxphy_ns_field(7) <= \<const0>\;
  rxphy_ns_field(6) <= \<const0>\;
  rxphy_ns_field(5) <= \<const0>\;
  rxphy_ns_field(4) <= \<const0>\;
  rxphy_ns_field(3) <= \<const0>\;
  rxphy_ns_field(2) <= \<const0>\;
  rxphy_ns_field(1) <= \<const0>\;
  rxphy_ns_field(0) <= \<const0>\;
  rxphy_s_field(47) <= \<const0>\;
  rxphy_s_field(46) <= \<const0>\;
  rxphy_s_field(45) <= \<const0>\;
  rxphy_s_field(44) <= \<const0>\;
  rxphy_s_field(43) <= \<const0>\;
  rxphy_s_field(42) <= \<const0>\;
  rxphy_s_field(41) <= \<const0>\;
  rxphy_s_field(40) <= \<const0>\;
  rxphy_s_field(39) <= \<const0>\;
  rxphy_s_field(38) <= \<const0>\;
  rxphy_s_field(37) <= \<const0>\;
  rxphy_s_field(36) <= \<const0>\;
  rxphy_s_field(35) <= \<const0>\;
  rxphy_s_field(34) <= \<const0>\;
  rxphy_s_field(33) <= \<const0>\;
  rxphy_s_field(32) <= \<const0>\;
  rxphy_s_field(31) <= \<const0>\;
  rxphy_s_field(30) <= \<const0>\;
  rxphy_s_field(29) <= \<const0>\;
  rxphy_s_field(28) <= \<const0>\;
  rxphy_s_field(27) <= \<const0>\;
  rxphy_s_field(26) <= \<const0>\;
  rxphy_s_field(25) <= \<const0>\;
  rxphy_s_field(24) <= \<const0>\;
  rxphy_s_field(23) <= \<const0>\;
  rxphy_s_field(22) <= \<const0>\;
  rxphy_s_field(21) <= \<const0>\;
  rxphy_s_field(20) <= \<const0>\;
  rxphy_s_field(19) <= \<const0>\;
  rxphy_s_field(18) <= \<const0>\;
  rxphy_s_field(17) <= \<const0>\;
  rxphy_s_field(16) <= \<const0>\;
  rxphy_s_field(15) <= \<const0>\;
  rxphy_s_field(14) <= \<const0>\;
  rxphy_s_field(13) <= \<const0>\;
  rxphy_s_field(12) <= \<const0>\;
  rxphy_s_field(11) <= \<const0>\;
  rxphy_s_field(10) <= \<const0>\;
  rxphy_s_field(9) <= \<const0>\;
  rxphy_s_field(8) <= \<const0>\;
  rxphy_s_field(7) <= \<const0>\;
  rxphy_s_field(6) <= \<const0>\;
  rxphy_s_field(5) <= \<const0>\;
  rxphy_s_field(4) <= \<const0>\;
  rxphy_s_field(3) <= \<const0>\;
  rxphy_s_field(2) <= \<const0>\;
  rxphy_s_field(1) <= \<const0>\;
  rxphy_s_field(0) <= \<const0>\;
  speed_selection(1) <= \<const1>\;
  speed_selection(0) <= \<const0>\;
  status_vector(15) <= \<const0>\;
  status_vector(14) <= \<const0>\;
  status_vector(13 downto 9) <= \^status_vector\(13 downto 9);
  status_vector(8) <= \<const0>\;
  status_vector(7 downto 0) <= \^status_vector\(7 downto 0);
  tx_code_group(9) <= \<const0>\;
  tx_code_group(8) <= \<const0>\;
  tx_code_group(7) <= \<const0>\;
  tx_code_group(6) <= \<const0>\;
  tx_code_group(5) <= \<const0>\;
  tx_code_group(4) <= \<const0>\;
  tx_code_group(3) <= \<const0>\;
  tx_code_group(2) <= \<const0>\;
  tx_code_group(1) <= \<const0>\;
  tx_code_group(0) <= \<const0>\;
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
gpcs_pma_inst: entity work.gmii_to_sgmii_GPCS_PMA_GEN
    port map (
      MGT_RX_RESET => mgt_rx_reset,
      MGT_TX_RESET => mgt_tx_reset,
      Q(1) => gmii_isolate,
      Q(0) => powerdown,
      an_adv_config_vector(1) => an_adv_config_vector(15),
      an_adv_config_vector(0) => an_adv_config_vector(11),
      an_interrupt => an_interrupt,
      an_restart_config => an_restart_config,
      configuration_vector(4 downto 0) => configuration_vector(4 downto 0),
      dcm_locked => dcm_locked,
      enablealign => enablealign,
      gmii_rx_dv => gmii_rx_dv,
      gmii_rx_er => gmii_rx_er,
      gmii_rxd(7 downto 0) => gmii_rxd(7 downto 0),
      gmii_tx_en => gmii_tx_en,
      gmii_tx_er => gmii_tx_er,
      gmii_txd(7 downto 0) => gmii_txd(7 downto 0),
      link_timer_value(8 downto 0) => link_timer_value(8 downto 0),
      reset => reset,
      reset_done => reset_done,
      rxbufstatus(0) => rxbufstatus(1),
      rxchariscomma(0) => rxchariscomma(0),
      rxcharisk(0) => rxcharisk(0),
      rxclkcorcnt(2 downto 0) => rxclkcorcnt(2 downto 0),
      rxdata(7 downto 0) => rxdata(7 downto 0),
      rxdisperr(0) => rxdisperr(0),
      rxnotintable(0) => rxnotintable(0),
      signal_detect => signal_detect,
      status_vector(12 downto 8) => \^status_vector\(13 downto 9),
      status_vector(7 downto 0) => \^status_vector\(7 downto 0),
      txbuferr => txbuferr,
      txchardispmode => txchardispmode,
      txchardispval => txchardispval,
      txcharisk => txcharisk,
      txdata(7 downto 0) => txdata(7 downto 0),
      userclk => userclk,
      userclk2 => userclk2
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \gmii_to_sgmii_gmii_to_sgmii_GTWIZARD_GT__parameterized0\ is
  port (
    O1 : out STD_LOGIC;
    txn : out STD_LOGIC;
    txp : out STD_LOGIC;
    I : out STD_LOGIC;
    O2 : out STD_LOGIC;
    txoutclk : out STD_LOGIC;
    O3 : out STD_LOGIC;
    TXBUFSTATUS : out STD_LOGIC_VECTOR ( 0 to 0 );
    D : out STD_LOGIC_VECTOR ( 23 downto 0 );
    ack_flag : out STD_LOGIC;
    independent_clock_bufg : in STD_LOGIC;
    CLK : in STD_LOGIC;
    rxn : in STD_LOGIC;
    rxp : in STD_LOGIC;
    I1 : in STD_LOGIC;
    I2 : in STD_LOGIC;
    gt0_qplloutclk_out : in STD_LOGIC;
    gt0_qplloutrefclk_out : in STD_LOGIC;
    RXDFELFHOLD : in STD_LOGIC;
    reset_out : in STD_LOGIC;
    reset : in STD_LOGIC;
    RXUSERRDY : in STD_LOGIC;
    I3 : in STD_LOGIC;
    TXPD : in STD_LOGIC_VECTOR ( 0 to 0 );
    TXUSERRDY : in STD_LOGIC;
    I4 : in STD_LOGIC;
    RXPD : in STD_LOGIC_VECTOR ( 0 to 0 );
    Q : in STD_LOGIC_VECTOR ( 15 downto 0 );
    I5 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    I6 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    I7 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    I8 : in STD_LOGIC;
    CPLL_RESET : in STD_LOGIC;
    data_in : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \gmii_to_sgmii_gmii_to_sgmii_GTWIZARD_GT__parameterized0\ : entity is "gmii_to_sgmii_GTWIZARD_GT";
end \gmii_to_sgmii_gmii_to_sgmii_GTWIZARD_GT__parameterized0\;

architecture STRUCTURE of \gmii_to_sgmii_gmii_to_sgmii_GTWIZARD_GT__parameterized0\ is
  signal CPLLPD : STD_LOGIC;
  signal CPLLREFCLKLOST : STD_LOGIC;
  signal CPLLRESET : STD_LOGIC;
  signal D0_in : STD_LOGIC;
  signal D0_in1_in : STD_LOGIC;
  signal D_0 : STD_LOGIC;
  signal GTRXRESET_OUT : STD_LOGIC;
  signal \^ack_flag\ : STD_LOGIC;
  signal ack_sync1 : STD_LOGIC;
  signal ack_sync2 : STD_LOGIC;
  signal ack_sync3 : STD_LOGIC;
  signal ack_sync4 : STD_LOGIC;
  signal ack_sync6 : STD_LOGIC;
  signal cpllreset_ovrd_i : STD_LOGIC;
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  signal data_sync4 : STD_LOGIC;
  signal flag : STD_LOGIC;
  signal flag2 : STD_LOGIC;
  signal gtrefclk0_in_bufg : STD_LOGIC;
  signal n_0_ack_flag_i_1 : STD_LOGIC;
  signal \n_0_cpllpd_wait_reg[94]_srl31\ : STD_LOGIC;
  signal \n_0_cpllreset_wait_reg[126]_srl31\ : STD_LOGIC;
  signal \n_0_flag_i_1__0\ : STD_LOGIC;
  signal n_0_gthe2_i : STD_LOGIC;
  signal n_10_gthe2_i : STD_LOGIC;
  signal n_10_gtrxreset_seq_i : STD_LOGIC;
  signal n_113_gthe2_i : STD_LOGIC;
  signal n_114_gthe2_i : STD_LOGIC;
  signal n_115_gthe2_i : STD_LOGIC;
  signal n_116_gthe2_i : STD_LOGIC;
  signal n_11_gthe2_i : STD_LOGIC;
  signal n_11_gtrxreset_seq_i : STD_LOGIC;
  signal n_12_gtrxreset_seq_i : STD_LOGIC;
  signal n_13_gtrxreset_seq_i : STD_LOGIC;
  signal n_14_gtrxreset_seq_i : STD_LOGIC;
  signal n_15_gtrxreset_seq_i : STD_LOGIC;
  signal n_16_gtrxreset_seq_i : STD_LOGIC;
  signal n_17_gthe2_i : STD_LOGIC;
  signal n_17_gtrxreset_seq_i : STD_LOGIC;
  signal n_18_gtrxreset_seq_i : STD_LOGIC;
  signal n_19_gtrxreset_seq_i : STD_LOGIC;
  signal \n_1_cpllpd_wait_reg[31]_srl32\ : STD_LOGIC;
  signal \n_1_cpllpd_wait_reg[63]_srl32\ : STD_LOGIC;
  signal \n_1_cpllreset_wait_reg[31]_srl32\ : STD_LOGIC;
  signal \n_1_cpllreset_wait_reg[63]_srl32\ : STD_LOGIC;
  signal \n_1_cpllreset_wait_reg[95]_srl32\ : STD_LOGIC;
  signal n_1_gtrxreset_seq_i : STD_LOGIC;
  signal n_205_gthe2_i : STD_LOGIC;
  signal n_206_gthe2_i : STD_LOGIC;
  signal n_207_gthe2_i : STD_LOGIC;
  signal n_208_gthe2_i : STD_LOGIC;
  signal n_209_gthe2_i : STD_LOGIC;
  signal n_210_gthe2_i : STD_LOGIC;
  signal n_211_gthe2_i : STD_LOGIC;
  signal n_2_gtrxreset_seq_i : STD_LOGIC;
  signal n_33_gthe2_i : STD_LOGIC;
  signal n_34_gthe2_i : STD_LOGIC;
  signal n_3_gthe2_i : STD_LOGIC;
  signal n_3_gtrxreset_seq_i : STD_LOGIC;
  signal n_46_gthe2_i : STD_LOGIC;
  signal n_47_gthe2_i : STD_LOGIC;
  signal n_4_gthe2_i : STD_LOGIC;
  signal n_4_gtrxreset_seq_i : STD_LOGIC;
  signal n_50_gthe2_i : STD_LOGIC;
  signal n_57_gthe2_i : STD_LOGIC;
  signal n_58_gthe2_i : STD_LOGIC;
  signal n_59_gthe2_i : STD_LOGIC;
  signal n_5_gtrxreset_seq_i : STD_LOGIC;
  signal n_60_gthe2_i : STD_LOGIC;
  signal n_61_gthe2_i : STD_LOGIC;
  signal n_62_gthe2_i : STD_LOGIC;
  signal n_63_gthe2_i : STD_LOGIC;
  signal n_64_gthe2_i : STD_LOGIC;
  signal n_65_gthe2_i : STD_LOGIC;
  signal n_66_gthe2_i : STD_LOGIC;
  signal n_67_gthe2_i : STD_LOGIC;
  signal n_68_gthe2_i : STD_LOGIC;
  signal n_69_gthe2_i : STD_LOGIC;
  signal n_6_gtrxreset_seq_i : STD_LOGIC;
  signal n_70_gthe2_i : STD_LOGIC;
  signal n_71_gthe2_i : STD_LOGIC;
  signal n_72_gthe2_i : STD_LOGIC;
  signal n_73_gthe2_i : STD_LOGIC;
  signal n_74_gthe2_i : STD_LOGIC;
  signal n_75_gthe2_i : STD_LOGIC;
  signal n_76_gthe2_i : STD_LOGIC;
  signal n_77_gthe2_i : STD_LOGIC;
  signal n_78_gthe2_i : STD_LOGIC;
  signal n_79_gthe2_i : STD_LOGIC;
  signal n_7_gtrxreset_seq_i : STD_LOGIC;
  signal n_80_gthe2_i : STD_LOGIC;
  signal n_81_gthe2_i : STD_LOGIC;
  signal n_82_gthe2_i : STD_LOGIC;
  signal n_83_gthe2_i : STD_LOGIC;
  signal n_84_gthe2_i : STD_LOGIC;
  signal n_85_gthe2_i : STD_LOGIC;
  signal n_86_gthe2_i : STD_LOGIC;
  signal n_87_gthe2_i : STD_LOGIC;
  signal n_8_gtrxreset_seq_i : STD_LOGIC;
  signal n_9_gtrxreset_seq_i : STD_LOGIC;
  signal \NLW_cpllpd_wait_reg[31]_srl32_Q_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_cpllpd_wait_reg[63]_srl32_Q_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_cpllpd_wait_reg[94]_srl31_Q31_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_cpllreset_wait_reg[126]_srl31_Q31_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_cpllreset_wait_reg[31]_srl32_Q_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_cpllreset_wait_reg[63]_srl32_Q_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_cpllreset_wait_reg[95]_srl32_Q_UNCONNECTED\ : STD_LOGIC;
  signal NLW_gthe2_i_GTREFCLKMONITOR_UNCONNECTED : STD_LOGIC;
  signal NLW_gthe2_i_PHYSTATUS_UNCONNECTED : STD_LOGIC;
  signal NLW_gthe2_i_RSOSINTDONE_UNCONNECTED : STD_LOGIC;
  signal NLW_gthe2_i_RXCDRLOCK_UNCONNECTED : STD_LOGIC;
  signal NLW_gthe2_i_RXCHANBONDSEQ_UNCONNECTED : STD_LOGIC;
  signal NLW_gthe2_i_RXCHANISALIGNED_UNCONNECTED : STD_LOGIC;
  signal NLW_gthe2_i_RXCHANREALIGN_UNCONNECTED : STD_LOGIC;
  signal NLW_gthe2_i_RXCOMINITDET_UNCONNECTED : STD_LOGIC;
  signal NLW_gthe2_i_RXCOMSASDET_UNCONNECTED : STD_LOGIC;
  signal NLW_gthe2_i_RXCOMWAKEDET_UNCONNECTED : STD_LOGIC;
  signal NLW_gthe2_i_RXDFESLIDETAPSTARTED_UNCONNECTED : STD_LOGIC;
  signal NLW_gthe2_i_RXDFESLIDETAPSTROBEDONE_UNCONNECTED : STD_LOGIC;
  signal NLW_gthe2_i_RXDFESLIDETAPSTROBESTARTED_UNCONNECTED : STD_LOGIC;
  signal NLW_gthe2_i_RXDFESTADAPTDONE_UNCONNECTED : STD_LOGIC;
  signal NLW_gthe2_i_RXDLYSRESETDONE_UNCONNECTED : STD_LOGIC;
  signal NLW_gthe2_i_RXELECIDLE_UNCONNECTED : STD_LOGIC;
  signal NLW_gthe2_i_RXOSINTSTARTED_UNCONNECTED : STD_LOGIC;
  signal NLW_gthe2_i_RXOSINTSTROBEDONE_UNCONNECTED : STD_LOGIC;
  signal NLW_gthe2_i_RXOSINTSTROBESTARTED_UNCONNECTED : STD_LOGIC;
  signal NLW_gthe2_i_RXOUTCLKFABRIC_UNCONNECTED : STD_LOGIC;
  signal NLW_gthe2_i_RXOUTCLKPCS_UNCONNECTED : STD_LOGIC;
  signal NLW_gthe2_i_RXPHALIGNDONE_UNCONNECTED : STD_LOGIC;
  signal NLW_gthe2_i_RXQPISENN_UNCONNECTED : STD_LOGIC;
  signal NLW_gthe2_i_RXQPISENP_UNCONNECTED : STD_LOGIC;
  signal NLW_gthe2_i_RXRATEDONE_UNCONNECTED : STD_LOGIC;
  signal NLW_gthe2_i_RXSYNCDONE_UNCONNECTED : STD_LOGIC;
  signal NLW_gthe2_i_RXSYNCOUT_UNCONNECTED : STD_LOGIC;
  signal NLW_gthe2_i_RXVALID_UNCONNECTED : STD_LOGIC;
  signal NLW_gthe2_i_TXCOMFINISH_UNCONNECTED : STD_LOGIC;
  signal NLW_gthe2_i_TXDLYSRESETDONE_UNCONNECTED : STD_LOGIC;
  signal NLW_gthe2_i_TXGEARBOXREADY_UNCONNECTED : STD_LOGIC;
  signal NLW_gthe2_i_TXPHALIGNDONE_UNCONNECTED : STD_LOGIC;
  signal NLW_gthe2_i_TXPHINITDONE_UNCONNECTED : STD_LOGIC;
  signal NLW_gthe2_i_TXQPISENN_UNCONNECTED : STD_LOGIC;
  signal NLW_gthe2_i_TXQPISENP_UNCONNECTED : STD_LOGIC;
  signal NLW_gthe2_i_TXRATEDONE_UNCONNECTED : STD_LOGIC;
  signal NLW_gthe2_i_TXSYNCDONE_UNCONNECTED : STD_LOGIC;
  signal NLW_gthe2_i_TXSYNCOUT_UNCONNECTED : STD_LOGIC;
  signal NLW_gthe2_i_PCSRSVDOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal NLW_gthe2_i_RXCHARISCOMMA_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 2 );
  signal NLW_gthe2_i_RXCHARISK_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 2 );
  signal NLW_gthe2_i_RXCHBONDO_UNCONNECTED : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal NLW_gthe2_i_RXCLKCORCNT_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_gthe2_i_RXDATA_UNCONNECTED : STD_LOGIC_VECTOR ( 63 downto 16 );
  signal NLW_gthe2_i_RXDATAVALID_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_gthe2_i_RXDISPERR_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 2 );
  signal NLW_gthe2_i_RXHEADER_UNCONNECTED : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal NLW_gthe2_i_RXHEADERVALID_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_gthe2_i_RXNOTINTABLE_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 2 );
  signal NLW_gthe2_i_RXPHMONITOR_UNCONNECTED : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal NLW_gthe2_i_RXPHSLIPMONITOR_UNCONNECTED : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal NLW_gthe2_i_RXSTARTOFSEQ_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_gthe2_i_RXSTATUS_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of ack_sync_reg1 : label is std.standard.true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of ack_sync_reg1 : label is "no";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of ack_sync_reg1 : label is "FD";
  attribute box_type : string;
  attribute box_type of ack_sync_reg1 : label is "PRIMITIVE";
  attribute ASYNC_REG of ack_sync_reg2 : label is std.standard.true;
  attribute SHREG_EXTRACT of ack_sync_reg2 : label is "no";
  attribute XILINX_LEGACY_PRIM of ack_sync_reg2 : label is "FD";
  attribute box_type of ack_sync_reg2 : label is "PRIMITIVE";
  attribute ASYNC_REG of ack_sync_reg3 : label is std.standard.true;
  attribute SHREG_EXTRACT of ack_sync_reg3 : label is "no";
  attribute XILINX_LEGACY_PRIM of ack_sync_reg3 : label is "FD";
  attribute box_type of ack_sync_reg3 : label is "PRIMITIVE";
  attribute ASYNC_REG of ack_sync_reg4 : label is std.standard.true;
  attribute SHREG_EXTRACT of ack_sync_reg4 : label is "no";
  attribute XILINX_LEGACY_PRIM of ack_sync_reg4 : label is "FD";
  attribute box_type of ack_sync_reg4 : label is "PRIMITIVE";
  attribute ASYNC_REG of ack_sync_reg5 : label is std.standard.true;
  attribute SHREG_EXTRACT of ack_sync_reg5 : label is "no";
  attribute XILINX_LEGACY_PRIM of ack_sync_reg5 : label is "FD";
  attribute box_type of ack_sync_reg5 : label is "PRIMITIVE";
  attribute ASYNC_REG of ack_sync_reg6 : label is std.standard.true;
  attribute SHREG_EXTRACT of ack_sync_reg6 : label is "no";
  attribute XILINX_LEGACY_PRIM of ack_sync_reg6 : label is "FD";
  attribute box_type of ack_sync_reg6 : label is "PRIMITIVE";
  attribute box_type of bufg_gtrefclk0_in : label is "PRIMITIVE";
  attribute srl_bus_name : string;
  attribute srl_bus_name of \cpllpd_wait_reg[31]_srl32\ : label is "\U0/pcs_pma_block_i/transceiver_inst/gtwizard_inst/U0/gtwizard_i/gt0_GTWIZARD_i/cpllpd_wait_reg ";
  attribute srl_name : string;
  attribute srl_name of \cpllpd_wait_reg[31]_srl32\ : label is "\U0/pcs_pma_block_i/transceiver_inst/gtwizard_inst/U0/gtwizard_i/gt0_GTWIZARD_i/cpllpd_wait_reg[31]_srl32 ";
  attribute srl_bus_name of \cpllpd_wait_reg[63]_srl32\ : label is "\U0/pcs_pma_block_i/transceiver_inst/gtwizard_inst/U0/gtwizard_i/gt0_GTWIZARD_i/cpllpd_wait_reg ";
  attribute srl_name of \cpllpd_wait_reg[63]_srl32\ : label is "\U0/pcs_pma_block_i/transceiver_inst/gtwizard_inst/U0/gtwizard_i/gt0_GTWIZARD_i/cpllpd_wait_reg[63]_srl32 ";
  attribute srl_bus_name of \cpllpd_wait_reg[94]_srl31\ : label is "\U0/pcs_pma_block_i/transceiver_inst/gtwizard_inst/U0/gtwizard_i/gt0_GTWIZARD_i/cpllpd_wait_reg ";
  attribute srl_name of \cpllpd_wait_reg[94]_srl31\ : label is "\U0/pcs_pma_block_i/transceiver_inst/gtwizard_inst/U0/gtwizard_i/gt0_GTWIZARD_i/cpllpd_wait_reg[94]_srl31 ";
  attribute srl_bus_name of \cpllreset_wait_reg[126]_srl31\ : label is "\U0/pcs_pma_block_i/transceiver_inst/gtwizard_inst/U0/gtwizard_i/gt0_GTWIZARD_i/cpllreset_wait_reg ";
  attribute srl_name of \cpllreset_wait_reg[126]_srl31\ : label is "\U0/pcs_pma_block_i/transceiver_inst/gtwizard_inst/U0/gtwizard_i/gt0_GTWIZARD_i/cpllreset_wait_reg[126]_srl31 ";
  attribute srl_bus_name of \cpllreset_wait_reg[31]_srl32\ : label is "\U0/pcs_pma_block_i/transceiver_inst/gtwizard_inst/U0/gtwizard_i/gt0_GTWIZARD_i/cpllreset_wait_reg ";
  attribute srl_name of \cpllreset_wait_reg[31]_srl32\ : label is "\U0/pcs_pma_block_i/transceiver_inst/gtwizard_inst/U0/gtwizard_i/gt0_GTWIZARD_i/cpllreset_wait_reg[31]_srl32 ";
  attribute srl_bus_name of \cpllreset_wait_reg[63]_srl32\ : label is "\U0/pcs_pma_block_i/transceiver_inst/gtwizard_inst/U0/gtwizard_i/gt0_GTWIZARD_i/cpllreset_wait_reg ";
  attribute srl_name of \cpllreset_wait_reg[63]_srl32\ : label is "\U0/pcs_pma_block_i/transceiver_inst/gtwizard_inst/U0/gtwizard_i/gt0_GTWIZARD_i/cpllreset_wait_reg[63]_srl32 ";
  attribute srl_bus_name of \cpllreset_wait_reg[95]_srl32\ : label is "\U0/pcs_pma_block_i/transceiver_inst/gtwizard_inst/U0/gtwizard_i/gt0_GTWIZARD_i/cpllreset_wait_reg ";
  attribute srl_name of \cpllreset_wait_reg[95]_srl32\ : label is "\U0/pcs_pma_block_i/transceiver_inst/gtwizard_inst/U0/gtwizard_i/gt0_GTWIZARD_i/cpllreset_wait_reg[95]_srl32 ";
  attribute ASYNC_REG of data_sync_reg1 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg1 : label is "FD";
  attribute box_type of data_sync_reg1 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg2 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg2 : label is "FD";
  attribute box_type of data_sync_reg2 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg3 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg3 : label is "FD";
  attribute box_type of data_sync_reg3 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg4 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg4 : label is "FD";
  attribute box_type of data_sync_reg4 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg5 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg5 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg5 : label is "FD";
  attribute box_type of data_sync_reg5 : label is "PRIMITIVE";
  attribute ASYNC_REG of data_sync_reg6 : label is std.standard.true;
  attribute SHREG_EXTRACT of data_sync_reg6 : label is "no";
  attribute XILINX_LEGACY_PRIM of data_sync_reg6 : label is "FD";
  attribute box_type of data_sync_reg6 : label is "PRIMITIVE";
  attribute box_type of gthe2_i : label is "PRIMITIVE";
begin
  ack_flag <= \^ack_flag\;
ack_flag_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FF90"
    )
    port map (
      I0 => D_0,
      I1 => ack_sync6,
      I2 => \^ack_flag\,
      I3 => flag2,
      O => n_0_ack_flag_i_1
    );
ack_flag_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => n_0_ack_flag_i_1,
      Q => \^ack_flag\,
      R => '0'
    );
ack_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => D0_in1_in,
      Q => ack_sync1,
      R => '0'
    );
ack_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => ack_sync1,
      Q => ack_sync2,
      R => '0'
    );
ack_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => ack_sync2,
      Q => ack_sync3,
      R => '0'
    );
ack_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => ack_sync3,
      Q => ack_sync4,
      R => '0'
    );
ack_sync_reg5: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => ack_sync4,
      Q => D_0,
      R => '0'
    );
ack_sync_reg6: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => D_0,
      Q => ack_sync6,
      R => '0'
    );
bufg_gtrefclk0_in: unisim.vcomponents.BUFG
    port map (
      I => I1,
      O => gtrefclk0_in_bufg
    );
\cpllpd_wait_reg[31]_srl32\: unisim.vcomponents.SRLC32E
    generic map(
      INIT => X"FFFFFFFF"
    )
    port map (
      A(4) => '1',
      A(3) => '1',
      A(2) => '1',
      A(1) => '1',
      A(0) => '1',
      CE => '1',
      CLK => gtrefclk0_in_bufg,
      D => '0',
      Q => \NLW_cpllpd_wait_reg[31]_srl32_Q_UNCONNECTED\,
      Q31 => \n_1_cpllpd_wait_reg[31]_srl32\
    );
\cpllpd_wait_reg[63]_srl32\: unisim.vcomponents.SRLC32E
    generic map(
      INIT => X"FFFFFFFF"
    )
    port map (
      A(4) => '1',
      A(3) => '1',
      A(2) => '1',
      A(1) => '1',
      A(0) => '1',
      CE => '1',
      CLK => gtrefclk0_in_bufg,
      D => \n_1_cpllpd_wait_reg[31]_srl32\,
      Q => \NLW_cpllpd_wait_reg[63]_srl32_Q_UNCONNECTED\,
      Q31 => \n_1_cpllpd_wait_reg[63]_srl32\
    );
\cpllpd_wait_reg[94]_srl31\: unisim.vcomponents.SRLC32E
    generic map(
      INIT => X"7FFFFFFF"
    )
    port map (
      A(4) => '1',
      A(3) => '1',
      A(2) => '1',
      A(1) => '1',
      A(0) => '0',
      CE => '1',
      CLK => gtrefclk0_in_bufg,
      D => \n_1_cpllpd_wait_reg[63]_srl32\,
      Q => \n_0_cpllpd_wait_reg[94]_srl31\,
      Q31 => \NLW_cpllpd_wait_reg[94]_srl31_Q31_UNCONNECTED\
    );
\cpllpd_wait_reg[95]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
    port map (
      C => gtrefclk0_in_bufg,
      CE => '1',
      D => \n_0_cpllpd_wait_reg[94]_srl31\,
      Q => CPLLPD,
      R => '0'
    );
\cpllreset_wait_reg[126]_srl31\: unisim.vcomponents.SRLC32E
    generic map(
      INIT => X"00000000"
    )
    port map (
      A(4) => '1',
      A(3) => '1',
      A(2) => '1',
      A(1) => '1',
      A(0) => '0',
      CE => '1',
      CLK => gtrefclk0_in_bufg,
      D => \n_1_cpllreset_wait_reg[95]_srl32\,
      Q => \n_0_cpllreset_wait_reg[126]_srl31\,
      Q31 => \NLW_cpllreset_wait_reg[126]_srl31_Q31_UNCONNECTED\
    );
\cpllreset_wait_reg[127]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtrefclk0_in_bufg,
      CE => '1',
      D => \n_0_cpllreset_wait_reg[126]_srl31\,
      Q => cpllreset_ovrd_i,
      R => '0'
    );
\cpllreset_wait_reg[31]_srl32\: unisim.vcomponents.SRLC32E
    generic map(
      INIT => X"000000FF"
    )
    port map (
      A(4) => '1',
      A(3) => '1',
      A(2) => '1',
      A(1) => '1',
      A(0) => '1',
      CE => '1',
      CLK => gtrefclk0_in_bufg,
      D => '0',
      Q => \NLW_cpllreset_wait_reg[31]_srl32_Q_UNCONNECTED\,
      Q31 => \n_1_cpllreset_wait_reg[31]_srl32\
    );
\cpllreset_wait_reg[63]_srl32\: unisim.vcomponents.SRLC32E
    generic map(
      INIT => X"00000000"
    )
    port map (
      A(4) => '1',
      A(3) => '1',
      A(2) => '1',
      A(1) => '1',
      A(0) => '1',
      CE => '1',
      CLK => gtrefclk0_in_bufg,
      D => \n_1_cpllreset_wait_reg[31]_srl32\,
      Q => \NLW_cpllreset_wait_reg[63]_srl32_Q_UNCONNECTED\,
      Q31 => \n_1_cpllreset_wait_reg[63]_srl32\
    );
\cpllreset_wait_reg[95]_srl32\: unisim.vcomponents.SRLC32E
    generic map(
      INIT => X"00000000"
    )
    port map (
      A(4) => '1',
      A(3) => '1',
      A(2) => '1',
      A(1) => '1',
      A(0) => '1',
      CE => '1',
      CLK => gtrefclk0_in_bufg,
      D => \n_1_cpllreset_wait_reg[63]_srl32\,
      Q => \NLW_cpllreset_wait_reg[95]_srl32_Q_UNCONNECTED\,
      Q31 => \n_1_cpllreset_wait_reg[95]_srl32\
    );
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtrefclk0_in_bufg,
      CE => '1',
      D => flag,
      Q => data_sync1,
      R => '0'
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtrefclk0_in_bufg,
      CE => '1',
      D => data_sync1,
      Q => data_sync2,
      R => '0'
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtrefclk0_in_bufg,
      CE => '1',
      D => data_sync2,
      Q => data_sync3,
      R => '0'
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtrefclk0_in_bufg,
      CE => '1',
      D => data_sync3,
      Q => data_sync4,
      R => '0'
    );
data_sync_reg5: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtrefclk0_in_bufg,
      CE => '1',
      D => data_sync4,
      Q => D0_in,
      R => '0'
    );
data_sync_reg6: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtrefclk0_in_bufg,
      CE => '1',
      D => D0_in,
      Q => D0_in1_in,
      R => '0'
    );
flag2_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => I8,
      Q => flag2,
      R => '0'
    );
\flag_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B4"
    )
    port map (
      I0 => \^ack_flag\,
      I1 => CPLL_RESET,
      I2 => flag,
      O => \n_0_flag_i_1__0\
    );
flag_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => \n_0_flag_i_1__0\,
      Q => flag,
      R => '0'
    );
gthe2_i: unisim.vcomponents.GTHE2_CHANNEL
    generic map(
      ACJTAG_DEBUG_MODE => '0',
      ACJTAG_MODE => '0',
      ACJTAG_RESET => '0',
      ADAPT_CFG0 => X"00C10",
      ALIGN_COMMA_DOUBLE => "FALSE",
      ALIGN_COMMA_ENABLE => B"0001111111",
      ALIGN_COMMA_WORD => 2,
      ALIGN_MCOMMA_DET => "TRUE",
      ALIGN_MCOMMA_VALUE => B"1010000011",
      ALIGN_PCOMMA_DET => "TRUE",
      ALIGN_PCOMMA_VALUE => B"0101111100",
      A_RXOSCALRESET => '0',
      CBCC_DATA_SOURCE_SEL => "DECODED",
      CFOK_CFG => X"24800040E80",
      CFOK_CFG2 => B"100000",
      CFOK_CFG3 => B"100000",
      CHAN_BOND_KEEP_ALIGN => "FALSE",
      CHAN_BOND_MAX_SKEW => 1,
      CHAN_BOND_SEQ_1_1 => B"0000000000",
      CHAN_BOND_SEQ_1_2 => B"0000000000",
      CHAN_BOND_SEQ_1_3 => B"0000000000",
      CHAN_BOND_SEQ_1_4 => B"0000000000",
      CHAN_BOND_SEQ_1_ENABLE => B"1111",
      CHAN_BOND_SEQ_2_1 => B"0000000000",
      CHAN_BOND_SEQ_2_2 => B"0000000000",
      CHAN_BOND_SEQ_2_3 => B"0000000000",
      CHAN_BOND_SEQ_2_4 => B"0000000000",
      CHAN_BOND_SEQ_2_ENABLE => B"1111",
      CHAN_BOND_SEQ_2_USE => "FALSE",
      CHAN_BOND_SEQ_LEN => 1,
      CLK_CORRECT_USE => "FALSE",
      CLK_COR_KEEP_IDLE => "FALSE",
      CLK_COR_MAX_LAT => 36,
      CLK_COR_MIN_LAT => 32,
      CLK_COR_PRECEDENCE => "TRUE",
      CLK_COR_REPEAT_WAIT => 0,
      CLK_COR_SEQ_1_1 => B"0100000000",
      CLK_COR_SEQ_1_2 => B"0000000000",
      CLK_COR_SEQ_1_3 => B"0000000000",
      CLK_COR_SEQ_1_4 => B"0000000000",
      CLK_COR_SEQ_1_ENABLE => B"1111",
      CLK_COR_SEQ_2_1 => B"0100000000",
      CLK_COR_SEQ_2_2 => B"0000000000",
      CLK_COR_SEQ_2_3 => B"0000000000",
      CLK_COR_SEQ_2_4 => B"0000000000",
      CLK_COR_SEQ_2_ENABLE => B"1111",
      CLK_COR_SEQ_2_USE => "FALSE",
      CLK_COR_SEQ_LEN => 1,
      CPLL_CFG => X"00BC07DC",
      CPLL_FBDIV => 4,
      CPLL_FBDIV_45 => 5,
      CPLL_INIT_CFG => X"00001E",
      CPLL_LOCK_CFG => X"01E8",
      CPLL_REFCLK_DIV => 1,
      DEC_MCOMMA_DETECT => "TRUE",
      DEC_PCOMMA_DETECT => "TRUE",
      DEC_VALID_COMMA_ONLY => "FALSE",
      DMONITOR_CFG => X"000A00",
      ES_CLK_PHASE_SEL => '0',
      ES_CONTROL => B"000000",
      ES_ERRDET_EN => "FALSE",
      ES_EYE_SCAN_EN => "TRUE",
      ES_HORZ_OFFSET => X"000",
      ES_PMA_CFG => B"0000000000",
      ES_PRESCALE => B"00000",
      ES_QUALIFIER => X"00000000000000000000",
      ES_QUAL_MASK => X"00000000000000000000",
      ES_SDATA_MASK => X"00000000000000000000",
      ES_VERT_OFFSET => B"000000000",
      FTS_DESKEW_SEQ_ENABLE => B"1111",
      FTS_LANE_DESKEW_CFG => B"1111",
      FTS_LANE_DESKEW_EN => "FALSE",
      GEARBOX_MODE => B"000",
      IS_CLKRSVD0_INVERTED => '0',
      IS_CLKRSVD1_INVERTED => '0',
      IS_CPLLLOCKDETCLK_INVERTED => '0',
      IS_DMONITORCLK_INVERTED => '0',
      IS_DRPCLK_INVERTED => '0',
      IS_GTGREFCLK_INVERTED => '0',
      IS_RXUSRCLK2_INVERTED => '0',
      IS_RXUSRCLK_INVERTED => '0',
      IS_SIGVALIDCLK_INVERTED => '0',
      IS_TXPHDLYTSTCLK_INVERTED => '0',
      IS_TXUSRCLK2_INVERTED => '0',
      IS_TXUSRCLK_INVERTED => '0',
      LOOPBACK_CFG => '0',
      OUTREFCLK_SEL_INV => B"11",
      PCS_PCIE_EN => "FALSE",
      PCS_RSVD_ATTR => X"000000000000",
      PD_TRANS_TIME_FROM_P2 => X"03C",
      PD_TRANS_TIME_NONE_P2 => X"19",
      PD_TRANS_TIME_TO_P2 => X"64",
      PMA_RSV => B"00000000000000011000010010000000",
      PMA_RSV2 => B"00011100000000000000000000001010",
      PMA_RSV3 => B"00",
      PMA_RSV4 => B"000000000001000",
      PMA_RSV5 => B"0000",
      RESET_POWERSAVE_DISABLE => '0',
      RXBUFRESET_TIME => B"00001",
      RXBUF_ADDR_MODE => "FAST",
      RXBUF_EIDLE_HI_CNT => B"1000",
      RXBUF_EIDLE_LO_CNT => B"0000",
      RXBUF_EN => "TRUE",
      RXBUF_RESET_ON_CB_CHANGE => "TRUE",
      RXBUF_RESET_ON_COMMAALIGN => "FALSE",
      RXBUF_RESET_ON_EIDLE => "FALSE",
      RXBUF_RESET_ON_RATE_CHANGE => "TRUE",
      RXBUF_THRESH_OVFLW => 61,
      RXBUF_THRESH_OVRD => "FALSE",
      RXBUF_THRESH_UNDFLW => 8,
      RXCDRFREQRESET_TIME => B"00001",
      RXCDRPHRESET_TIME => B"00001",
      RXCDR_CFG => X"0002007FE0800C2200018",
      RXCDR_FR_RESET_ON_EIDLE => '0',
      RXCDR_HOLD_DURING_EIDLE => '0',
      RXCDR_LOCK_CFG => B"010101",
      RXCDR_PH_RESET_ON_EIDLE => '0',
      RXDFELPMRESET_TIME => B"0001111",
      RXDLY_CFG => X"001F",
      RXDLY_LCFG => X"030",
      RXDLY_TAP_CFG => X"0000",
      RXGEARBOX_EN => "FALSE",
      RXISCANRESET_TIME => B"00001",
      RXLPM_HF_CFG => B"00001000000000",
      RXLPM_LF_CFG => B"001001000000000000",
      RXOOB_CFG => B"0000110",
      RXOOB_CLK_CFG => "PMA",
      RXOSCALRESET_TIME => B"00011",
      RXOSCALRESET_TIMEOUT => B"00000",
      RXOUT_DIV => 4,
      RXPCSRESET_TIME => B"00001",
      RXPHDLY_CFG => X"084020",
      RXPH_CFG => X"C00002",
      RXPH_MONITOR_SEL => B"00000",
      RXPI_CFG0 => B"00",
      RXPI_CFG1 => B"00",
      RXPI_CFG2 => B"00",
      RXPI_CFG3 => B"11",
      RXPI_CFG4 => '1',
      RXPI_CFG5 => '1',
      RXPI_CFG6 => B"001",
      RXPMARESET_TIME => B"00011",
      RXPRBS_ERR_LOOPBACK => '0',
      RXSLIDE_AUTO_WAIT => 7,
      RXSLIDE_MODE => "OFF",
      RXSYNC_MULTILANE => '0',
      RXSYNC_OVRD => '0',
      RXSYNC_SKIP_DA => '0',
      RX_BIAS_CFG => B"000011000000000000010000",
      RX_BUFFER_CFG => B"000000",
      RX_CLK25_DIV => 5,
      RX_CLKMUX_PD => '1',
      RX_CM_SEL => B"11",
      RX_CM_TRIM => B"1010",
      RX_DATA_WIDTH => 20,
      RX_DDI_SEL => B"000000",
      RX_DEBUG_CFG => B"00000000000000",
      RX_DEFER_RESET_BUF_EN => "TRUE",
      RX_DFELPM_CFG0 => B"0110",
      RX_DFELPM_CFG1 => '0',
      RX_DFELPM_KLKH_AGC_STUP_EN => '1',
      RX_DFE_AGC_CFG0 => B"00",
      RX_DFE_AGC_CFG1 => B"100",
      RX_DFE_AGC_CFG2 => B"0000",
      RX_DFE_AGC_OVRDEN => '1',
      RX_DFE_GAIN_CFG => X"0020C0",
      RX_DFE_H2_CFG => B"000000000000",
      RX_DFE_H3_CFG => B"000001000000",
      RX_DFE_H4_CFG => B"00011100000",
      RX_DFE_H5_CFG => B"00011100000",
      RX_DFE_H6_CFG => B"00000100000",
      RX_DFE_H7_CFG => B"00000100000",
      RX_DFE_KL_CFG => B"001000001000000000000001100010000",
      RX_DFE_KL_LPM_KH_CFG0 => B"01",
      RX_DFE_KL_LPM_KH_CFG1 => B"010",
      RX_DFE_KL_LPM_KH_CFG2 => B"0010",
      RX_DFE_KL_LPM_KH_OVRDEN => '1',
      RX_DFE_KL_LPM_KL_CFG0 => B"10",
      RX_DFE_KL_LPM_KL_CFG1 => B"010",
      RX_DFE_KL_LPM_KL_CFG2 => B"0010",
      RX_DFE_KL_LPM_KL_OVRDEN => '1',
      RX_DFE_LPM_CFG => X"0080",
      RX_DFE_LPM_HOLD_DURING_EIDLE => '0',
      RX_DFE_ST_CFG => X"00E100000C003F",
      RX_DFE_UT_CFG => B"00011100000000000",
      RX_DFE_VP_CFG => B"00011101010100011",
      RX_DISPERR_SEQ_MATCH => "TRUE",
      RX_INT_DATAWIDTH => 0,
      RX_OS_CFG => B"0000010000000",
      RX_SIG_VALID_DLY => 10,
      RX_XCLK_SEL => "RXREC",
      SAS_MAX_COM => 64,
      SAS_MIN_COM => 36,
      SATA_BURST_SEQ_LEN => B"0101",
      SATA_BURST_VAL => B"100",
      SATA_CPLL_CFG => "VCO_3000MHZ",
      SATA_EIDLE_VAL => B"100",
      SATA_MAX_BURST => 8,
      SATA_MAX_INIT => 21,
      SATA_MAX_WAKE => 7,
      SATA_MIN_BURST => 4,
      SATA_MIN_INIT => 12,
      SATA_MIN_WAKE => 4,
      SHOW_REALIGN_COMMA => "TRUE",
      SIM_CPLLREFCLK_SEL => B"001",
      SIM_RECEIVER_DETECT_PASS => "TRUE",
      SIM_RESET_SPEEDUP => "TRUE",
      SIM_TX_EIDLE_DRIVE_LEVEL => "X",
      SIM_VERSION => "2.0",
      TERM_RCAL_CFG => B"100001000010000",
      TERM_RCAL_OVRD => B"000",
      TRANS_TIME_RATE => X"0E",
      TST_RSV => X"00000000",
      TXBUF_EN => "TRUE",
      TXBUF_RESET_ON_RATE_CHANGE => "TRUE",
      TXDLY_CFG => X"001F",
      TXDLY_LCFG => X"030",
      TXDLY_TAP_CFG => X"0000",
      TXGEARBOX_EN => "FALSE",
      TXOOB_CFG => '0',
      TXOUT_DIV => 4,
      TXPCSRESET_TIME => B"00001",
      TXPHDLY_CFG => X"084020",
      TXPH_CFG => X"0780",
      TXPH_MONITOR_SEL => B"00000",
      TXPI_CFG0 => B"00",
      TXPI_CFG1 => B"00",
      TXPI_CFG2 => B"00",
      TXPI_CFG3 => '0',
      TXPI_CFG4 => '0',
      TXPI_CFG5 => B"100",
      TXPI_GREY_SEL => '0',
      TXPI_INVSTROBE_SEL => '0',
      TXPI_PPMCLK_SEL => "TXUSRCLK2",
      TXPI_PPM_CFG => B"00000000",
      TXPI_SYNFREQ_PPM => B"000",
      TXPMARESET_TIME => B"00001",
      TXSYNC_MULTILANE => '0',
      TXSYNC_OVRD => '0',
      TXSYNC_SKIP_DA => '0',
      TX_CLK25_DIV => 5,
      TX_CLKMUX_PD => '1',
      TX_DATA_WIDTH => 20,
      TX_DEEMPH0 => B"000000",
      TX_DEEMPH1 => B"000000",
      TX_DRIVE_MODE => "DIRECT",
      TX_EIDLE_ASSERT_DELAY => B"110",
      TX_EIDLE_DEASSERT_DELAY => B"100",
      TX_INT_DATAWIDTH => 0,
      TX_LOOPBACK_DRIVE_HIZ => "FALSE",
      TX_MAINCURSOR_SEL => '0',
      TX_MARGIN_FULL_0 => B"1001110",
      TX_MARGIN_FULL_1 => B"1001001",
      TX_MARGIN_FULL_2 => B"1000101",
      TX_MARGIN_FULL_3 => B"1000010",
      TX_MARGIN_FULL_4 => B"1000000",
      TX_MARGIN_LOW_0 => B"1000110",
      TX_MARGIN_LOW_1 => B"1000100",
      TX_MARGIN_LOW_2 => B"1000010",
      TX_MARGIN_LOW_3 => B"1000000",
      TX_MARGIN_LOW_4 => B"1000000",
      TX_QPI_STATUS_EN => '0',
      TX_RXDETECT_CFG => X"1832",
      TX_RXDETECT_PRECHARGE_TIME => X"155CC",
      TX_RXDETECT_REF => B"100",
      TX_XCLK_SEL => "TXOUT",
      UCODEER_CLR => '0',
      USE_PCS_CLK_PHASE_SEL => '0'
    )
    port map (
      CFGRESET => '0',
      CLKRSVD0 => '0',
      CLKRSVD1 => '0',
      CPLLFBCLKLOST => n_0_gthe2_i,
      CPLLLOCK => O1,
      CPLLLOCKDETCLK => independent_clock_bufg,
      CPLLLOCKEN => '1',
      CPLLPD => CPLLPD,
      CPLLREFCLKLOST => CPLLREFCLKLOST,
      CPLLREFCLKSEL(2) => '0',
      CPLLREFCLKSEL(1) => '0',
      CPLLREFCLKSEL(0) => '1',
      CPLLRESET => CPLLRESET,
      DMONFIFORESET => '0',
      DMONITORCLK => '0',
      DMONITOROUT(14) => n_57_gthe2_i,
      DMONITOROUT(13) => n_58_gthe2_i,
      DMONITOROUT(12) => n_59_gthe2_i,
      DMONITOROUT(11) => n_60_gthe2_i,
      DMONITOROUT(10) => n_61_gthe2_i,
      DMONITOROUT(9) => n_62_gthe2_i,
      DMONITOROUT(8) => n_63_gthe2_i,
      DMONITOROUT(7) => n_64_gthe2_i,
      DMONITOROUT(6) => n_65_gthe2_i,
      DMONITOROUT(5) => n_66_gthe2_i,
      DMONITOROUT(4) => n_67_gthe2_i,
      DMONITOROUT(3) => n_68_gthe2_i,
      DMONITOROUT(2) => n_69_gthe2_i,
      DMONITOROUT(1) => n_70_gthe2_i,
      DMONITOROUT(0) => n_71_gthe2_i,
      DRPADDR(8) => '0',
      DRPADDR(7) => '0',
      DRPADDR(6) => '0',
      DRPADDR(5) => '0',
      DRPADDR(4) => n_1_gtrxreset_seq_i,
      DRPADDR(3) => '0',
      DRPADDR(2) => '0',
      DRPADDR(1) => '0',
      DRPADDR(0) => n_1_gtrxreset_seq_i,
      DRPCLK => CLK,
      DRPDI(15) => n_3_gtrxreset_seq_i,
      DRPDI(14) => n_4_gtrxreset_seq_i,
      DRPDI(13) => n_5_gtrxreset_seq_i,
      DRPDI(12) => n_6_gtrxreset_seq_i,
      DRPDI(11) => n_7_gtrxreset_seq_i,
      DRPDI(10) => n_8_gtrxreset_seq_i,
      DRPDI(9) => n_9_gtrxreset_seq_i,
      DRPDI(8) => n_10_gtrxreset_seq_i,
      DRPDI(7) => n_11_gtrxreset_seq_i,
      DRPDI(6) => n_12_gtrxreset_seq_i,
      DRPDI(5) => n_13_gtrxreset_seq_i,
      DRPDI(4) => n_14_gtrxreset_seq_i,
      DRPDI(3) => n_15_gtrxreset_seq_i,
      DRPDI(2) => n_16_gtrxreset_seq_i,
      DRPDI(1) => n_17_gtrxreset_seq_i,
      DRPDI(0) => n_18_gtrxreset_seq_i,
      DRPDO(15) => n_72_gthe2_i,
      DRPDO(14) => n_73_gthe2_i,
      DRPDO(13) => n_74_gthe2_i,
      DRPDO(12) => n_75_gthe2_i,
      DRPDO(11) => n_76_gthe2_i,
      DRPDO(10) => n_77_gthe2_i,
      DRPDO(9) => n_78_gthe2_i,
      DRPDO(8) => n_79_gthe2_i,
      DRPDO(7) => n_80_gthe2_i,
      DRPDO(6) => n_81_gthe2_i,
      DRPDO(5) => n_82_gthe2_i,
      DRPDO(4) => n_83_gthe2_i,
      DRPDO(3) => n_84_gthe2_i,
      DRPDO(2) => n_85_gthe2_i,
      DRPDO(1) => n_86_gthe2_i,
      DRPDO(0) => n_87_gthe2_i,
      DRPEN => n_2_gtrxreset_seq_i,
      DRPRDY => n_3_gthe2_i,
      DRPWE => n_19_gtrxreset_seq_i,
      EYESCANDATAERROR => n_4_gthe2_i,
      EYESCANMODE => '0',
      EYESCANRESET => '0',
      EYESCANTRIGGER => '0',
      GTGREFCLK => '0',
      GTHRXN => rxn,
      GTHRXP => rxp,
      GTHTXN => txn,
      GTHTXP => txp,
      GTNORTHREFCLK0 => '0',
      GTNORTHREFCLK1 => '0',
      GTREFCLK0 => I1,
      GTREFCLK1 => '0',
      GTREFCLKMONITOR => NLW_gthe2_i_GTREFCLKMONITOR_UNCONNECTED,
      GTRESETSEL => '0',
      GTRSVD(15) => '0',
      GTRSVD(14) => '0',
      GTRSVD(13) => '0',
      GTRSVD(12) => '0',
      GTRSVD(11) => '0',
      GTRSVD(10) => '0',
      GTRSVD(9) => '0',
      GTRSVD(8) => '0',
      GTRSVD(7) => '0',
      GTRSVD(6) => '0',
      GTRSVD(5) => '0',
      GTRSVD(4) => '0',
      GTRSVD(3) => '0',
      GTRSVD(2) => '0',
      GTRSVD(1) => '0',
      GTRSVD(0) => '0',
      GTRXRESET => GTRXRESET_OUT,
      GTSOUTHREFCLK0 => '0',
      GTSOUTHREFCLK1 => '0',
      GTTXRESET => I2,
      LOOPBACK(2) => '0',
      LOOPBACK(1) => '0',
      LOOPBACK(0) => '0',
      PCSRSVDIN(15) => '0',
      PCSRSVDIN(14) => '0',
      PCSRSVDIN(13) => '0',
      PCSRSVDIN(12) => '0',
      PCSRSVDIN(11) => '0',
      PCSRSVDIN(10) => '0',
      PCSRSVDIN(9) => '0',
      PCSRSVDIN(8) => '0',
      PCSRSVDIN(7) => '0',
      PCSRSVDIN(6) => '0',
      PCSRSVDIN(5) => '0',
      PCSRSVDIN(4) => '0',
      PCSRSVDIN(3) => '0',
      PCSRSVDIN(2) => '0',
      PCSRSVDIN(1) => '0',
      PCSRSVDIN(0) => '0',
      PCSRSVDIN2(4) => '0',
      PCSRSVDIN2(3) => '0',
      PCSRSVDIN2(2) => '0',
      PCSRSVDIN2(1) => '0',
      PCSRSVDIN2(0) => '0',
      PCSRSVDOUT(15 downto 0) => NLW_gthe2_i_PCSRSVDOUT_UNCONNECTED(15 downto 0),
      PHYSTATUS => NLW_gthe2_i_PHYSTATUS_UNCONNECTED,
      PMARSVDIN(4) => '0',
      PMARSVDIN(3) => '0',
      PMARSVDIN(2) => '0',
      PMARSVDIN(1) => '0',
      PMARSVDIN(0) => '0',
      QPLLCLK => gt0_qplloutclk_out,
      QPLLREFCLK => gt0_qplloutrefclk_out,
      RESETOVRD => '0',
      RSOSINTDONE => NLW_gthe2_i_RSOSINTDONE_UNCONNECTED,
      RX8B10BEN => '1',
      RXADAPTSELTEST(13) => '0',
      RXADAPTSELTEST(12) => '0',
      RXADAPTSELTEST(11) => '0',
      RXADAPTSELTEST(10) => '0',
      RXADAPTSELTEST(9) => '0',
      RXADAPTSELTEST(8) => '0',
      RXADAPTSELTEST(7) => '0',
      RXADAPTSELTEST(6) => '0',
      RXADAPTSELTEST(5) => '0',
      RXADAPTSELTEST(4) => '0',
      RXADAPTSELTEST(3) => '0',
      RXADAPTSELTEST(2) => '0',
      RXADAPTSELTEST(1) => '0',
      RXADAPTSELTEST(0) => '0',
      RXBUFRESET => '0',
      RXBUFSTATUS(2) => n_114_gthe2_i,
      RXBUFSTATUS(1) => n_115_gthe2_i,
      RXBUFSTATUS(0) => n_116_gthe2_i,
      RXBYTEISALIGNED => n_10_gthe2_i,
      RXBYTEREALIGN => n_11_gthe2_i,
      RXCDRFREQRESET => '0',
      RXCDRHOLD => '0',
      RXCDRLOCK => NLW_gthe2_i_RXCDRLOCK_UNCONNECTED,
      RXCDROVRDEN => '0',
      RXCDRRESET => '0',
      RXCDRRESETRSV => '0',
      RXCHANBONDSEQ => NLW_gthe2_i_RXCHANBONDSEQ_UNCONNECTED,
      RXCHANISALIGNED => NLW_gthe2_i_RXCHANISALIGNED_UNCONNECTED,
      RXCHANREALIGN => NLW_gthe2_i_RXCHANREALIGN_UNCONNECTED,
      RXCHARISCOMMA(7 downto 2) => NLW_gthe2_i_RXCHARISCOMMA_UNCONNECTED(7 downto 2),
      RXCHARISCOMMA(1) => D(11),
      RXCHARISCOMMA(0) => D(23),
      RXCHARISK(7 downto 2) => NLW_gthe2_i_RXCHARISK_UNCONNECTED(7 downto 2),
      RXCHARISK(1) => D(10),
      RXCHARISK(0) => D(22),
      RXCHBONDEN => '0',
      RXCHBONDI(4) => '0',
      RXCHBONDI(3) => '0',
      RXCHBONDI(2) => '0',
      RXCHBONDI(1) => '0',
      RXCHBONDI(0) => '0',
      RXCHBONDLEVEL(2) => '0',
      RXCHBONDLEVEL(1) => '0',
      RXCHBONDLEVEL(0) => '0',
      RXCHBONDMASTER => '0',
      RXCHBONDO(4 downto 0) => NLW_gthe2_i_RXCHBONDO_UNCONNECTED(4 downto 0),
      RXCHBONDSLAVE => '0',
      RXCLKCORCNT(1 downto 0) => NLW_gthe2_i_RXCLKCORCNT_UNCONNECTED(1 downto 0),
      RXCOMINITDET => NLW_gthe2_i_RXCOMINITDET_UNCONNECTED,
      RXCOMMADET => n_17_gthe2_i,
      RXCOMMADETEN => '1',
      RXCOMSASDET => NLW_gthe2_i_RXCOMSASDET_UNCONNECTED,
      RXCOMWAKEDET => NLW_gthe2_i_RXCOMWAKEDET_UNCONNECTED,
      RXDATA(63 downto 16) => NLW_gthe2_i_RXDATA_UNCONNECTED(63 downto 16),
      RXDATA(15 downto 8) => D(7 downto 0),
      RXDATA(7 downto 0) => D(19 downto 12),
      RXDATAVALID(1 downto 0) => NLW_gthe2_i_RXDATAVALID_UNCONNECTED(1 downto 0),
      RXDDIEN => '0',
      RXDFEAGCHOLD => RXDFELFHOLD,
      RXDFEAGCOVRDEN => '0',
      RXDFEAGCTRL(4) => '1',
      RXDFEAGCTRL(3) => '0',
      RXDFEAGCTRL(2) => '0',
      RXDFEAGCTRL(1) => '0',
      RXDFEAGCTRL(0) => '0',
      RXDFECM1EN => '0',
      RXDFELFHOLD => RXDFELFHOLD,
      RXDFELFOVRDEN => '0',
      RXDFELPMRESET => '0',
      RXDFESLIDETAP(4) => '0',
      RXDFESLIDETAP(3) => '0',
      RXDFESLIDETAP(2) => '0',
      RXDFESLIDETAP(1) => '0',
      RXDFESLIDETAP(0) => '0',
      RXDFESLIDETAPADAPTEN => '0',
      RXDFESLIDETAPHOLD => '0',
      RXDFESLIDETAPID(5) => '0',
      RXDFESLIDETAPID(4) => '0',
      RXDFESLIDETAPID(3) => '0',
      RXDFESLIDETAPID(2) => '0',
      RXDFESLIDETAPID(1) => '0',
      RXDFESLIDETAPID(0) => '0',
      RXDFESLIDETAPINITOVRDEN => '0',
      RXDFESLIDETAPONLYADAPTEN => '0',
      RXDFESLIDETAPOVRDEN => '0',
      RXDFESLIDETAPSTARTED => NLW_gthe2_i_RXDFESLIDETAPSTARTED_UNCONNECTED,
      RXDFESLIDETAPSTROBE => '0',
      RXDFESLIDETAPSTROBEDONE => NLW_gthe2_i_RXDFESLIDETAPSTROBEDONE_UNCONNECTED,
      RXDFESLIDETAPSTROBESTARTED => NLW_gthe2_i_RXDFESLIDETAPSTROBESTARTED_UNCONNECTED,
      RXDFESTADAPTDONE => NLW_gthe2_i_RXDFESTADAPTDONE_UNCONNECTED,
      RXDFETAP2HOLD => '0',
      RXDFETAP2OVRDEN => '0',
      RXDFETAP3HOLD => '0',
      RXDFETAP3OVRDEN => '0',
      RXDFETAP4HOLD => '0',
      RXDFETAP4OVRDEN => '0',
      RXDFETAP5HOLD => '0',
      RXDFETAP5OVRDEN => '0',
      RXDFETAP6HOLD => '0',
      RXDFETAP6OVRDEN => '0',
      RXDFETAP7HOLD => '0',
      RXDFETAP7OVRDEN => '0',
      RXDFEUTHOLD => '0',
      RXDFEUTOVRDEN => '0',
      RXDFEVPHOLD => '0',
      RXDFEVPOVRDEN => '0',
      RXDFEVSEN => '0',
      RXDFEXYDEN => '1',
      RXDISPERR(7 downto 2) => NLW_gthe2_i_RXDISPERR_UNCONNECTED(7 downto 2),
      RXDISPERR(1) => D(9),
      RXDISPERR(0) => D(21),
      RXDLYBYPASS => '1',
      RXDLYEN => '0',
      RXDLYOVRDEN => '0',
      RXDLYSRESET => '0',
      RXDLYSRESETDONE => NLW_gthe2_i_RXDLYSRESETDONE_UNCONNECTED,
      RXELECIDLE => NLW_gthe2_i_RXELECIDLE_UNCONNECTED,
      RXELECIDLEMODE(1) => '1',
      RXELECIDLEMODE(0) => '1',
      RXGEARBOXSLIP => '0',
      RXHEADER(5 downto 0) => NLW_gthe2_i_RXHEADER_UNCONNECTED(5 downto 0),
      RXHEADERVALID(1 downto 0) => NLW_gthe2_i_RXHEADERVALID_UNCONNECTED(1 downto 0),
      RXLPMEN => '0',
      RXLPMHFHOLD => '0',
      RXLPMHFOVRDEN => '0',
      RXLPMLFHOLD => '0',
      RXLPMLFKLOVRDEN => '0',
      RXMCOMMAALIGNEN => reset_out,
      RXMONITOROUT(6) => n_205_gthe2_i,
      RXMONITOROUT(5) => n_206_gthe2_i,
      RXMONITOROUT(4) => n_207_gthe2_i,
      RXMONITOROUT(3) => n_208_gthe2_i,
      RXMONITOROUT(2) => n_209_gthe2_i,
      RXMONITOROUT(1) => n_210_gthe2_i,
      RXMONITOROUT(0) => n_211_gthe2_i,
      RXMONITORSEL(1) => '0',
      RXMONITORSEL(0) => '0',
      RXNOTINTABLE(7 downto 2) => NLW_gthe2_i_RXNOTINTABLE_UNCONNECTED(7 downto 2),
      RXNOTINTABLE(1) => D(8),
      RXNOTINTABLE(0) => D(20),
      RXOOBRESET => '0',
      RXOSCALRESET => '0',
      RXOSHOLD => '0',
      RXOSINTCFG(3) => '0',
      RXOSINTCFG(2) => '1',
      RXOSINTCFG(1) => '1',
      RXOSINTCFG(0) => '0',
      RXOSINTEN => '1',
      RXOSINTHOLD => '0',
      RXOSINTID0(3) => '0',
      RXOSINTID0(2) => '0',
      RXOSINTID0(1) => '0',
      RXOSINTID0(0) => '0',
      RXOSINTNTRLEN => '0',
      RXOSINTOVRDEN => '0',
      RXOSINTSTARTED => NLW_gthe2_i_RXOSINTSTARTED_UNCONNECTED,
      RXOSINTSTROBE => '0',
      RXOSINTSTROBEDONE => NLW_gthe2_i_RXOSINTSTROBEDONE_UNCONNECTED,
      RXOSINTSTROBESTARTED => NLW_gthe2_i_RXOSINTSTROBESTARTED_UNCONNECTED,
      RXOSINTTESTOVRDEN => '0',
      RXOSOVRDEN => '0',
      RXOUTCLK => I,
      RXOUTCLKFABRIC => NLW_gthe2_i_RXOUTCLKFABRIC_UNCONNECTED,
      RXOUTCLKPCS => NLW_gthe2_i_RXOUTCLKPCS_UNCONNECTED,
      RXOUTCLKSEL(2) => '0',
      RXOUTCLKSEL(1) => '1',
      RXOUTCLKSEL(0) => '0',
      RXPCOMMAALIGNEN => reset_out,
      RXPCSRESET => reset,
      RXPD(1) => RXPD(0),
      RXPD(0) => RXPD(0),
      RXPHALIGN => '0',
      RXPHALIGNDONE => NLW_gthe2_i_RXPHALIGNDONE_UNCONNECTED,
      RXPHALIGNEN => '0',
      RXPHDLYPD => '0',
      RXPHDLYRESET => '0',
      RXPHMONITOR(4 downto 0) => NLW_gthe2_i_RXPHMONITOR_UNCONNECTED(4 downto 0),
      RXPHOVRDEN => '0',
      RXPHSLIPMONITOR(4 downto 0) => NLW_gthe2_i_RXPHSLIPMONITOR_UNCONNECTED(4 downto 0),
      RXPMARESET => '0',
      RXPMARESETDONE => n_33_gthe2_i,
      RXPOLARITY => '0',
      RXPRBSCNTRESET => '0',
      RXPRBSERR => n_34_gthe2_i,
      RXPRBSSEL(2) => '0',
      RXPRBSSEL(1) => '0',
      RXPRBSSEL(0) => '0',
      RXQPIEN => '0',
      RXQPISENN => NLW_gthe2_i_RXQPISENN_UNCONNECTED,
      RXQPISENP => NLW_gthe2_i_RXQPISENP_UNCONNECTED,
      RXRATE(2) => '0',
      RXRATE(1) => '0',
      RXRATE(0) => '0',
      RXRATEDONE => NLW_gthe2_i_RXRATEDONE_UNCONNECTED,
      RXRATEMODE => '0',
      RXRESETDONE => O2,
      RXSLIDE => '0',
      RXSTARTOFSEQ(1 downto 0) => NLW_gthe2_i_RXSTARTOFSEQ_UNCONNECTED(1 downto 0),
      RXSTATUS(2 downto 0) => NLW_gthe2_i_RXSTATUS_UNCONNECTED(2 downto 0),
      RXSYNCALLIN => '0',
      RXSYNCDONE => NLW_gthe2_i_RXSYNCDONE_UNCONNECTED,
      RXSYNCIN => '0',
      RXSYNCMODE => '0',
      RXSYNCOUT => NLW_gthe2_i_RXSYNCOUT_UNCONNECTED,
      RXSYSCLKSEL(1) => '0',
      RXSYSCLKSEL(0) => '0',
      RXUSERRDY => RXUSERRDY,
      RXUSRCLK => I3,
      RXUSRCLK2 => I3,
      RXVALID => NLW_gthe2_i_RXVALID_UNCONNECTED,
      SETERRSTATUS => '0',
      SIGVALIDCLK => '0',
      TSTIN(19) => '1',
      TSTIN(18) => '1',
      TSTIN(17) => '1',
      TSTIN(16) => '1',
      TSTIN(15) => '1',
      TSTIN(14) => '1',
      TSTIN(13) => '1',
      TSTIN(12) => '1',
      TSTIN(11) => '1',
      TSTIN(10) => '1',
      TSTIN(9) => '1',
      TSTIN(8) => '1',
      TSTIN(7) => '1',
      TSTIN(6) => '1',
      TSTIN(5) => '1',
      TSTIN(4) => '1',
      TSTIN(3) => '1',
      TSTIN(2) => '1',
      TSTIN(1) => '1',
      TSTIN(0) => '1',
      TX8B10BBYPASS(7) => '0',
      TX8B10BBYPASS(6) => '0',
      TX8B10BBYPASS(5) => '0',
      TX8B10BBYPASS(4) => '0',
      TX8B10BBYPASS(3) => '0',
      TX8B10BBYPASS(2) => '0',
      TX8B10BBYPASS(1) => '0',
      TX8B10BBYPASS(0) => '0',
      TX8B10BEN => '1',
      TXBUFDIFFCTRL(2) => '1',
      TXBUFDIFFCTRL(1) => '0',
      TXBUFDIFFCTRL(0) => '0',
      TXBUFSTATUS(1) => TXBUFSTATUS(0),
      TXBUFSTATUS(0) => n_113_gthe2_i,
      TXCHARDISPMODE(7) => '0',
      TXCHARDISPMODE(6) => '0',
      TXCHARDISPMODE(5) => '0',
      TXCHARDISPMODE(4) => '0',
      TXCHARDISPMODE(3) => '0',
      TXCHARDISPMODE(2) => '0',
      TXCHARDISPMODE(1 downto 0) => I5(1 downto 0),
      TXCHARDISPVAL(7) => '0',
      TXCHARDISPVAL(6) => '0',
      TXCHARDISPVAL(5) => '0',
      TXCHARDISPVAL(4) => '0',
      TXCHARDISPVAL(3) => '0',
      TXCHARDISPVAL(2) => '0',
      TXCHARDISPVAL(1 downto 0) => I6(1 downto 0),
      TXCHARISK(7) => '0',
      TXCHARISK(6) => '0',
      TXCHARISK(5) => '0',
      TXCHARISK(4) => '0',
      TXCHARISK(3) => '0',
      TXCHARISK(2) => '0',
      TXCHARISK(1 downto 0) => I7(1 downto 0),
      TXCOMFINISH => NLW_gthe2_i_TXCOMFINISH_UNCONNECTED,
      TXCOMINIT => '0',
      TXCOMSAS => '0',
      TXCOMWAKE => '0',
      TXDATA(63) => '0',
      TXDATA(62) => '0',
      TXDATA(61) => '0',
      TXDATA(60) => '0',
      TXDATA(59) => '0',
      TXDATA(58) => '0',
      TXDATA(57) => '0',
      TXDATA(56) => '0',
      TXDATA(55) => '0',
      TXDATA(54) => '0',
      TXDATA(53) => '0',
      TXDATA(52) => '0',
      TXDATA(51) => '0',
      TXDATA(50) => '0',
      TXDATA(49) => '0',
      TXDATA(48) => '0',
      TXDATA(47) => '0',
      TXDATA(46) => '0',
      TXDATA(45) => '0',
      TXDATA(44) => '0',
      TXDATA(43) => '0',
      TXDATA(42) => '0',
      TXDATA(41) => '0',
      TXDATA(40) => '0',
      TXDATA(39) => '0',
      TXDATA(38) => '0',
      TXDATA(37) => '0',
      TXDATA(36) => '0',
      TXDATA(35) => '0',
      TXDATA(34) => '0',
      TXDATA(33) => '0',
      TXDATA(32) => '0',
      TXDATA(31) => '0',
      TXDATA(30) => '0',
      TXDATA(29) => '0',
      TXDATA(28) => '0',
      TXDATA(27) => '0',
      TXDATA(26) => '0',
      TXDATA(25) => '0',
      TXDATA(24) => '0',
      TXDATA(23) => '0',
      TXDATA(22) => '0',
      TXDATA(21) => '0',
      TXDATA(20) => '0',
      TXDATA(19) => '0',
      TXDATA(18) => '0',
      TXDATA(17) => '0',
      TXDATA(16) => '0',
      TXDATA(15 downto 0) => Q(15 downto 0),
      TXDEEMPH => '0',
      TXDETECTRX => '0',
      TXDIFFCTRL(3) => '1',
      TXDIFFCTRL(2) => '0',
      TXDIFFCTRL(1) => '0',
      TXDIFFCTRL(0) => '0',
      TXDIFFPD => '0',
      TXDLYBYPASS => '1',
      TXDLYEN => '0',
      TXDLYHOLD => '0',
      TXDLYOVRDEN => '0',
      TXDLYSRESET => '0',
      TXDLYSRESETDONE => NLW_gthe2_i_TXDLYSRESETDONE_UNCONNECTED,
      TXDLYUPDOWN => '0',
      TXELECIDLE => TXPD(0),
      TXGEARBOXREADY => NLW_gthe2_i_TXGEARBOXREADY_UNCONNECTED,
      TXHEADER(2) => '0',
      TXHEADER(1) => '0',
      TXHEADER(0) => '0',
      TXINHIBIT => '0',
      TXMAINCURSOR(6) => '0',
      TXMAINCURSOR(5) => '0',
      TXMAINCURSOR(4) => '0',
      TXMAINCURSOR(3) => '0',
      TXMAINCURSOR(2) => '0',
      TXMAINCURSOR(1) => '0',
      TXMAINCURSOR(0) => '0',
      TXMARGIN(2) => '0',
      TXMARGIN(1) => '0',
      TXMARGIN(0) => '0',
      TXOUTCLK => txoutclk,
      TXOUTCLKFABRIC => n_46_gthe2_i,
      TXOUTCLKPCS => n_47_gthe2_i,
      TXOUTCLKSEL(2) => '1',
      TXOUTCLKSEL(1) => '0',
      TXOUTCLKSEL(0) => '0',
      TXPCSRESET => '0',
      TXPD(1) => TXPD(0),
      TXPD(0) => TXPD(0),
      TXPDELECIDLEMODE => '0',
      TXPHALIGN => '0',
      TXPHALIGNDONE => NLW_gthe2_i_TXPHALIGNDONE_UNCONNECTED,
      TXPHALIGNEN => '0',
      TXPHDLYPD => '0',
      TXPHDLYRESET => '0',
      TXPHDLYTSTCLK => '0',
      TXPHINIT => '0',
      TXPHINITDONE => NLW_gthe2_i_TXPHINITDONE_UNCONNECTED,
      TXPHOVRDEN => '0',
      TXPIPPMEN => '0',
      TXPIPPMOVRDEN => '0',
      TXPIPPMPD => '0',
      TXPIPPMSEL => '0',
      TXPIPPMSTEPSIZE(4) => '0',
      TXPIPPMSTEPSIZE(3) => '0',
      TXPIPPMSTEPSIZE(2) => '0',
      TXPIPPMSTEPSIZE(1) => '0',
      TXPIPPMSTEPSIZE(0) => '0',
      TXPISOPD => '0',
      TXPMARESET => '0',
      TXPMARESETDONE => n_50_gthe2_i,
      TXPOLARITY => '0',
      TXPOSTCURSOR(4) => '0',
      TXPOSTCURSOR(3) => '0',
      TXPOSTCURSOR(2) => '0',
      TXPOSTCURSOR(1) => '0',
      TXPOSTCURSOR(0) => '0',
      TXPOSTCURSORINV => '0',
      TXPRBSFORCEERR => '0',
      TXPRBSSEL(2) => '0',
      TXPRBSSEL(1) => '0',
      TXPRBSSEL(0) => '0',
      TXPRECURSOR(4) => '0',
      TXPRECURSOR(3) => '0',
      TXPRECURSOR(2) => '0',
      TXPRECURSOR(1) => '0',
      TXPRECURSOR(0) => '0',
      TXPRECURSORINV => '0',
      TXQPIBIASEN => '0',
      TXQPISENN => NLW_gthe2_i_TXQPISENN_UNCONNECTED,
      TXQPISENP => NLW_gthe2_i_TXQPISENP_UNCONNECTED,
      TXQPISTRONGPDOWN => '0',
      TXQPIWEAKPUP => '0',
      TXRATE(2) => '0',
      TXRATE(1) => '0',
      TXRATE(0) => '0',
      TXRATEDONE => NLW_gthe2_i_TXRATEDONE_UNCONNECTED,
      TXRATEMODE => '0',
      TXRESETDONE => O3,
      TXSEQUENCE(6) => '0',
      TXSEQUENCE(5) => '0',
      TXSEQUENCE(4) => '0',
      TXSEQUENCE(3) => '0',
      TXSEQUENCE(2) => '0',
      TXSEQUENCE(1) => '0',
      TXSEQUENCE(0) => '0',
      TXSTARTSEQ => '0',
      TXSWING => '0',
      TXSYNCALLIN => '0',
      TXSYNCDONE => NLW_gthe2_i_TXSYNCDONE_UNCONNECTED,
      TXSYNCIN => '0',
      TXSYNCMODE => '0',
      TXSYNCOUT => NLW_gthe2_i_TXSYNCOUT_UNCONNECTED,
      TXSYSCLKSEL(1) => '0',
      TXSYSCLKSEL(0) => '0',
      TXUSERRDY => TXUSERRDY,
      TXUSRCLK => I4,
      TXUSRCLK2 => I4
    );
gthe2_i_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BE"
    )
    port map (
      I0 => cpllreset_ovrd_i,
      I1 => D0_in,
      I2 => D0_in1_in,
      O => CPLLRESET
    );
gtrxreset_seq_i: entity work.gmii_to_sgmii_gmii_to_sgmii_gtwizard_gtrxreset_seq
    port map (
      CLK => CLK,
      CPLL_RESET => CPLL_RESET,
      D(15) => n_72_gthe2_i,
      D(14) => n_73_gthe2_i,
      D(13) => n_74_gthe2_i,
      D(12) => n_75_gthe2_i,
      D(11) => n_76_gthe2_i,
      D(10) => n_77_gthe2_i,
      D(9) => n_78_gthe2_i,
      D(8) => n_79_gthe2_i,
      D(7) => n_80_gthe2_i,
      D(6) => n_81_gthe2_i,
      D(5) => n_82_gthe2_i,
      D(4) => n_83_gthe2_i,
      D(3) => n_84_gthe2_i,
      D(2) => n_85_gthe2_i,
      D(1) => n_86_gthe2_i,
      D(0) => n_87_gthe2_i,
      DRPADDR(0) => n_1_gtrxreset_seq_i,
      DRPDI(15) => n_3_gtrxreset_seq_i,
      DRPDI(14) => n_4_gtrxreset_seq_i,
      DRPDI(13) => n_5_gtrxreset_seq_i,
      DRPDI(12) => n_6_gtrxreset_seq_i,
      DRPDI(11) => n_7_gtrxreset_seq_i,
      DRPDI(10) => n_8_gtrxreset_seq_i,
      DRPDI(9) => n_9_gtrxreset_seq_i,
      DRPDI(8) => n_10_gtrxreset_seq_i,
      DRPDI(7) => n_11_gtrxreset_seq_i,
      DRPDI(6) => n_12_gtrxreset_seq_i,
      DRPDI(5) => n_13_gtrxreset_seq_i,
      DRPDI(4) => n_14_gtrxreset_seq_i,
      DRPDI(3) => n_15_gtrxreset_seq_i,
      DRPDI(2) => n_16_gtrxreset_seq_i,
      DRPDI(1) => n_17_gtrxreset_seq_i,
      DRPDI(0) => n_18_gtrxreset_seq_i,
      GTRXRESET_OUT => GTRXRESET_OUT,
      I1 => n_3_gthe2_i,
      I2 => n_33_gthe2_i,
      O1 => n_2_gtrxreset_seq_i,
      O2 => n_19_gtrxreset_seq_i,
      data_in => data_in
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gmii_to_sgmii_gmii_to_sgmii_sgmii_adapt is
  port (
    sgmii_clk_r : out STD_LOGIC;
    O1 : out STD_LOGIC;
    gmii_rx_dv : out STD_LOGIC;
    gmii_rx_er : out STD_LOGIC;
    O2 : out STD_LOGIC;
    O3 : out STD_LOGIC;
    sgmii_clk_f : out STD_LOGIC;
    gmii_rxd : out STD_LOGIC_VECTOR ( 7 downto 0 );
    Q : out STD_LOGIC_VECTOR ( 7 downto 0 );
    CLK : in STD_LOGIC;
    I1 : in STD_LOGIC;
    I2 : in STD_LOGIC;
    gmii_tx_en : in STD_LOGIC;
    gmii_tx_er : in STD_LOGIC;
    D : in STD_LOGIC_VECTOR ( 7 downto 0 );
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    speed_is_10_100 : in STD_LOGIC;
    speed_is_100 : in STD_LOGIC;
    gmii_txd : in STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of gmii_to_sgmii_gmii_to_sgmii_sgmii_adapt : entity is "gmii_to_sgmii_sgmii_adapt";
end gmii_to_sgmii_gmii_to_sgmii_sgmii_adapt;

architecture STRUCTURE of gmii_to_sgmii_gmii_to_sgmii_sgmii_adapt is
  signal \^o1\ : STD_LOGIC;
  signal n_0_gen_sync_reset : STD_LOGIC;
  signal n_0_resync_speed_100 : STD_LOGIC;
  signal n_0_resync_speed_10_100 : STD_LOGIC;
begin
  O1 <= \^o1\;
clock_generation: entity work.gmii_to_sgmii_gmii_to_sgmii_clk_gen
    port map (
      CLK => CLK,
      I1 => n_0_resync_speed_10_100,
      O1 => \^o1\,
      data_out => n_0_resync_speed_100,
      reset_out => n_0_gen_sync_reset,
      sgmii_clk_f => sgmii_clk_f,
      sgmii_clk_r => sgmii_clk_r
    );
gen_sync_reset: entity work.gmii_to_sgmii_gmii_to_sgmii_reset_sync_32
    port map (
      CLK => CLK,
      SR(0) => SR(0),
      reset_out => n_0_gen_sync_reset
    );
receiver: entity work.gmii_to_sgmii_gmii_to_sgmii_rx_rate_adapt
    port map (
      CLK => CLK,
      D(7 downto 0) => D(7 downto 0),
      I1 => n_0_gen_sync_reset,
      I2 => \^o1\,
      I3 => I1,
      I4 => I2,
      gmii_rx_dv => gmii_rx_dv,
      gmii_rx_er => gmii_rx_er,
      gmii_rxd(7 downto 0) => gmii_rxd(7 downto 0)
    );
resync_speed_100: entity work.gmii_to_sgmii_gmii_to_sgmii_sync_block_33
    port map (
      CLK => CLK,
      data_out => n_0_resync_speed_100,
      speed_is_100 => speed_is_100
    );
resync_speed_10_100: entity work.gmii_to_sgmii_gmii_to_sgmii_sync_block_34
    port map (
      CLK => CLK,
      data_out => n_0_resync_speed_10_100,
      speed_is_10_100 => speed_is_10_100
    );
transmitter: entity work.gmii_to_sgmii_gmii_to_sgmii_tx_rate_adapt
    port map (
      CLK => CLK,
      E(0) => \^o1\,
      I1 => n_0_gen_sync_reset,
      O2 => O2,
      O3 => O3,
      Q(7 downto 0) => Q(7 downto 0),
      gmii_tx_en => gmii_tx_en,
      gmii_tx_er => gmii_tx_er,
      gmii_txd(7 downto 0) => gmii_txd(7 downto 0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \gmii_to_sgmii_gmii_to_sgmii_GTWIZARD_multi_gt__parameterized0\ is
  port (
    O1 : out STD_LOGIC;
    txn : out STD_LOGIC;
    txp : out STD_LOGIC;
    I : out STD_LOGIC;
    O2 : out STD_LOGIC;
    txoutclk : out STD_LOGIC;
    O3 : out STD_LOGIC;
    TXBUFSTATUS : out STD_LOGIC_VECTOR ( 0 to 0 );
    D : out STD_LOGIC_VECTOR ( 23 downto 0 );
    ack_flag : out STD_LOGIC;
    independent_clock_bufg : in STD_LOGIC;
    CLK : in STD_LOGIC;
    rxn : in STD_LOGIC;
    rxp : in STD_LOGIC;
    I1 : in STD_LOGIC;
    I2 : in STD_LOGIC;
    gt0_qplloutclk_out : in STD_LOGIC;
    gt0_qplloutrefclk_out : in STD_LOGIC;
    RXDFELFHOLD : in STD_LOGIC;
    reset_out : in STD_LOGIC;
    reset : in STD_LOGIC;
    RXUSERRDY : in STD_LOGIC;
    I3 : in STD_LOGIC;
    TXPD : in STD_LOGIC_VECTOR ( 0 to 0 );
    TXUSERRDY : in STD_LOGIC;
    I4 : in STD_LOGIC;
    RXPD : in STD_LOGIC_VECTOR ( 0 to 0 );
    Q : in STD_LOGIC_VECTOR ( 15 downto 0 );
    I5 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    I6 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    I7 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    I8 : in STD_LOGIC;
    CPLL_RESET : in STD_LOGIC;
    data_in : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \gmii_to_sgmii_gmii_to_sgmii_GTWIZARD_multi_gt__parameterized0\ : entity is "gmii_to_sgmii_GTWIZARD_multi_gt";
end \gmii_to_sgmii_gmii_to_sgmii_GTWIZARD_multi_gt__parameterized0\;

architecture STRUCTURE of \gmii_to_sgmii_gmii_to_sgmii_GTWIZARD_multi_gt__parameterized0\ is
begin
gt0_GTWIZARD_i: entity work.\gmii_to_sgmii_gmii_to_sgmii_GTWIZARD_GT__parameterized0\
    port map (
      CLK => CLK,
      CPLL_RESET => CPLL_RESET,
      D(23 downto 0) => D(23 downto 0),
      I => I,
      I1 => I1,
      I2 => I2,
      I3 => I3,
      I4 => I4,
      I5(1 downto 0) => I5(1 downto 0),
      I6(1 downto 0) => I6(1 downto 0),
      I7(1 downto 0) => I7(1 downto 0),
      I8 => I8,
      O1 => O1,
      O2 => O2,
      O3 => O3,
      Q(15 downto 0) => Q(15 downto 0),
      RXDFELFHOLD => RXDFELFHOLD,
      RXPD(0) => RXPD(0),
      RXUSERRDY => RXUSERRDY,
      TXBUFSTATUS(0) => TXBUFSTATUS(0),
      TXPD(0) => TXPD(0),
      TXUSERRDY => TXUSERRDY,
      ack_flag => ack_flag,
      data_in => data_in,
      gt0_qplloutclk_out => gt0_qplloutclk_out,
      gt0_qplloutrefclk_out => gt0_qplloutrefclk_out,
      independent_clock_bufg => independent_clock_bufg,
      reset => reset,
      reset_out => reset_out,
      rxn => rxn,
      rxp => rxp,
      txn => txn,
      txoutclk => txoutclk,
      txp => txp
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \gmii_to_sgmii_gmii_to_sgmii_GTWIZARD_init__parameterized0\ is
  port (
    txn : out STD_LOGIC;
    txp : out STD_LOGIC;
    I : out STD_LOGIC;
    txoutclk : out STD_LOGIC;
    TXBUFSTATUS : out STD_LOGIC_VECTOR ( 0 to 0 );
    D : out STD_LOGIC_VECTOR ( 23 downto 0 );
    data_in_0 : out STD_LOGIC;
    independent_clock_bufg : in STD_LOGIC;
    CLK : in STD_LOGIC;
    rxn : in STD_LOGIC;
    rxp : in STD_LOGIC;
    I1 : in STD_LOGIC;
    gt0_qplloutclk_out : in STD_LOGIC;
    gt0_qplloutrefclk_out : in STD_LOGIC;
    reset_out : in STD_LOGIC;
    reset : in STD_LOGIC;
    I2 : in STD_LOGIC;
    TXPD : in STD_LOGIC_VECTOR ( 0 to 0 );
    I3 : in STD_LOGIC;
    RXPD : in STD_LOGIC_VECTOR ( 0 to 0 );
    Q : in STD_LOGIC_VECTOR ( 15 downto 0 );
    I4 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    I5 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    I6 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    AR : in STD_LOGIC_VECTOR ( 0 to 0 );
    data_in : in STD_LOGIC;
    data_out : in STD_LOGIC;
    I7 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \gmii_to_sgmii_gmii_to_sgmii_GTWIZARD_init__parameterized0\ : entity is "gmii_to_sgmii_GTWIZARD_init";
end \gmii_to_sgmii_gmii_to_sgmii_GTWIZARD_init__parameterized0\;

architecture STRUCTURE of \gmii_to_sgmii_gmii_to_sgmii_GTWIZARD_init__parameterized0\ is
  signal CPLL_RESET : STD_LOGIC;
  signal GTRXRESET : STD_LOGIC;
  signal RXDFELFHOLD : STD_LOGIC;
  signal RXUSERRDY : STD_LOGIC;
  signal TXUSERRDY : STD_LOGIC;
  signal data0 : STD_LOGIC_VECTOR ( 13 downto 1 );
  signal data_out_1 : STD_LOGIC;
  signal \gt0_GTWIZARD_i/ack_flag\ : STD_LOGIC;
  signal gt0_rx_cdrlock_counter : STD_LOGIC_VECTOR ( 13 downto 0 );
  signal gt0_rx_cdrlock_counter_0 : STD_LOGIC_VECTOR ( 13 downto 0 );
  signal gt0_rxresetdone_out : STD_LOGIC;
  signal \n_0_gt0_rx_cdrlock_counter[12]_i_3\ : STD_LOGIC;
  signal \n_0_gt0_rx_cdrlock_counter[12]_i_4\ : STD_LOGIC;
  signal \n_0_gt0_rx_cdrlock_counter[12]_i_5\ : STD_LOGIC;
  signal \n_0_gt0_rx_cdrlock_counter[12]_i_6\ : STD_LOGIC;
  signal \n_0_gt0_rx_cdrlock_counter[13]_i_2\ : STD_LOGIC;
  signal \n_0_gt0_rx_cdrlock_counter[13]_i_3\ : STD_LOGIC;
  signal \n_0_gt0_rx_cdrlock_counter[13]_i_5\ : STD_LOGIC;
  signal \n_0_gt0_rx_cdrlock_counter[4]_i_3\ : STD_LOGIC;
  signal \n_0_gt0_rx_cdrlock_counter[4]_i_4\ : STD_LOGIC;
  signal \n_0_gt0_rx_cdrlock_counter[4]_i_5\ : STD_LOGIC;
  signal \n_0_gt0_rx_cdrlock_counter[4]_i_6\ : STD_LOGIC;
  signal \n_0_gt0_rx_cdrlock_counter[8]_i_3\ : STD_LOGIC;
  signal \n_0_gt0_rx_cdrlock_counter[8]_i_4\ : STD_LOGIC;
  signal \n_0_gt0_rx_cdrlock_counter[8]_i_5\ : STD_LOGIC;
  signal \n_0_gt0_rx_cdrlock_counter[8]_i_6\ : STD_LOGIC;
  signal \n_0_gt0_rx_cdrlock_counter_reg[12]_i_2\ : STD_LOGIC;
  signal \n_0_gt0_rx_cdrlock_counter_reg[4]_i_2\ : STD_LOGIC;
  signal \n_0_gt0_rx_cdrlock_counter_reg[8]_i_2\ : STD_LOGIC;
  signal n_0_gt0_rx_cdrlocked_i_1 : STD_LOGIC;
  signal n_0_gt0_rx_cdrlocked_reg : STD_LOGIC;
  signal n_0_gtwizard_i : STD_LOGIC;
  signal \n_1_gt0_rx_cdrlock_counter_reg[12]_i_2\ : STD_LOGIC;
  signal \n_1_gt0_rx_cdrlock_counter_reg[4]_i_2\ : STD_LOGIC;
  signal \n_1_gt0_rx_cdrlock_counter_reg[8]_i_2\ : STD_LOGIC;
  signal \n_2_gt0_rx_cdrlock_counter_reg[12]_i_2\ : STD_LOGIC;
  signal \n_2_gt0_rx_cdrlock_counter_reg[4]_i_2\ : STD_LOGIC;
  signal \n_2_gt0_rx_cdrlock_counter_reg[8]_i_2\ : STD_LOGIC;
  signal n_2_gt0_txresetfsm_i : STD_LOGIC;
  signal \n_3_gt0_rx_cdrlock_counter_reg[12]_i_2\ : STD_LOGIC;
  signal \n_3_gt0_rx_cdrlock_counter_reg[4]_i_2\ : STD_LOGIC;
  signal \n_3_gt0_rx_cdrlock_counter_reg[8]_i_2\ : STD_LOGIC;
  signal n_3_gt0_txresetfsm_i : STD_LOGIC;
  signal n_4_gtwizard_i : STD_LOGIC;
  signal n_6_gtwizard_i : STD_LOGIC;
  signal \NLW_gt0_rx_cdrlock_counter_reg[13]_i_4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_gt0_rx_cdrlock_counter_reg[13]_i_4_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \gt0_rx_cdrlock_counter[0]_i_1\ : label is "soft_lutpair111";
  attribute SOFT_HLUTNM of \gt0_rx_cdrlock_counter[8]_i_1\ : label is "soft_lutpair111";
begin
\gt0_rx_cdrlock_counter[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00FE"
    )
    port map (
      I0 => \n_0_gt0_rx_cdrlock_counter[13]_i_2\,
      I1 => gt0_rx_cdrlock_counter(5),
      I2 => \n_0_gt0_rx_cdrlock_counter[13]_i_3\,
      I3 => gt0_rx_cdrlock_counter(0),
      O => gt0_rx_cdrlock_counter_0(0)
    );
\gt0_rx_cdrlock_counter[10]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF00FF01"
    )
    port map (
      I0 => \n_0_gt0_rx_cdrlock_counter[13]_i_2\,
      I1 => gt0_rx_cdrlock_counter(5),
      I2 => \n_0_gt0_rx_cdrlock_counter[13]_i_3\,
      I3 => data0(10),
      I4 => gt0_rx_cdrlock_counter(0),
      O => gt0_rx_cdrlock_counter_0(10)
    );
\gt0_rx_cdrlock_counter[11]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFE0000"
    )
    port map (
      I0 => \n_0_gt0_rx_cdrlock_counter[13]_i_2\,
      I1 => gt0_rx_cdrlock_counter(5),
      I2 => \n_0_gt0_rx_cdrlock_counter[13]_i_3\,
      I3 => gt0_rx_cdrlock_counter(0),
      I4 => data0(11),
      O => gt0_rx_cdrlock_counter_0(11)
    );
\gt0_rx_cdrlock_counter[12]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFE0000"
    )
    port map (
      I0 => \n_0_gt0_rx_cdrlock_counter[13]_i_2\,
      I1 => gt0_rx_cdrlock_counter(5),
      I2 => \n_0_gt0_rx_cdrlock_counter[13]_i_3\,
      I3 => gt0_rx_cdrlock_counter(0),
      I4 => data0(12),
      O => gt0_rx_cdrlock_counter_0(12)
    );
\gt0_rx_cdrlock_counter[12]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => gt0_rx_cdrlock_counter(12),
      O => \n_0_gt0_rx_cdrlock_counter[12]_i_3\
    );
\gt0_rx_cdrlock_counter[12]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => gt0_rx_cdrlock_counter(11),
      O => \n_0_gt0_rx_cdrlock_counter[12]_i_4\
    );
\gt0_rx_cdrlock_counter[12]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => gt0_rx_cdrlock_counter(10),
      O => \n_0_gt0_rx_cdrlock_counter[12]_i_5\
    );
\gt0_rx_cdrlock_counter[12]_i_6\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => gt0_rx_cdrlock_counter(9),
      O => \n_0_gt0_rx_cdrlock_counter[12]_i_6\
    );
\gt0_rx_cdrlock_counter[13]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF00FF01"
    )
    port map (
      I0 => \n_0_gt0_rx_cdrlock_counter[13]_i_2\,
      I1 => gt0_rx_cdrlock_counter(5),
      I2 => \n_0_gt0_rx_cdrlock_counter[13]_i_3\,
      I3 => data0(13),
      I4 => gt0_rx_cdrlock_counter(0),
      O => gt0_rx_cdrlock_counter_0(13)
    );
\gt0_rx_cdrlock_counter[13]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFDFFFFFFFF"
    )
    port map (
      I0 => gt0_rx_cdrlock_counter(10),
      I1 => gt0_rx_cdrlock_counter(12),
      I2 => gt0_rx_cdrlock_counter(2),
      I3 => gt0_rx_cdrlock_counter(3),
      I4 => gt0_rx_cdrlock_counter(1),
      I5 => gt0_rx_cdrlock_counter(13),
      O => \n_0_gt0_rx_cdrlock_counter[13]_i_2\
    );
\gt0_rx_cdrlock_counter[13]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFDFFFFFFFFFF"
    )
    port map (
      I0 => gt0_rx_cdrlock_counter(4),
      I1 => gt0_rx_cdrlock_counter(6),
      I2 => gt0_rx_cdrlock_counter(11),
      I3 => gt0_rx_cdrlock_counter(9),
      I4 => gt0_rx_cdrlock_counter(7),
      I5 => gt0_rx_cdrlock_counter(8),
      O => \n_0_gt0_rx_cdrlock_counter[13]_i_3\
    );
\gt0_rx_cdrlock_counter[13]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => gt0_rx_cdrlock_counter(13),
      O => \n_0_gt0_rx_cdrlock_counter[13]_i_5\
    );
\gt0_rx_cdrlock_counter[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFE0000"
    )
    port map (
      I0 => \n_0_gt0_rx_cdrlock_counter[13]_i_2\,
      I1 => gt0_rx_cdrlock_counter(5),
      I2 => \n_0_gt0_rx_cdrlock_counter[13]_i_3\,
      I3 => gt0_rx_cdrlock_counter(0),
      I4 => data0(1),
      O => gt0_rx_cdrlock_counter_0(1)
    );
\gt0_rx_cdrlock_counter[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFE0000"
    )
    port map (
      I0 => \n_0_gt0_rx_cdrlock_counter[13]_i_2\,
      I1 => gt0_rx_cdrlock_counter(5),
      I2 => \n_0_gt0_rx_cdrlock_counter[13]_i_3\,
      I3 => gt0_rx_cdrlock_counter(0),
      I4 => data0(2),
      O => gt0_rx_cdrlock_counter_0(2)
    );
\gt0_rx_cdrlock_counter[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFE0000"
    )
    port map (
      I0 => \n_0_gt0_rx_cdrlock_counter[13]_i_2\,
      I1 => gt0_rx_cdrlock_counter(5),
      I2 => \n_0_gt0_rx_cdrlock_counter[13]_i_3\,
      I3 => gt0_rx_cdrlock_counter(0),
      I4 => data0(3),
      O => gt0_rx_cdrlock_counter_0(3)
    );
\gt0_rx_cdrlock_counter[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF00FF01"
    )
    port map (
      I0 => \n_0_gt0_rx_cdrlock_counter[13]_i_2\,
      I1 => gt0_rx_cdrlock_counter(5),
      I2 => \n_0_gt0_rx_cdrlock_counter[13]_i_3\,
      I3 => data0(4),
      I4 => gt0_rx_cdrlock_counter(0),
      O => gt0_rx_cdrlock_counter_0(4)
    );
\gt0_rx_cdrlock_counter[4]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => gt0_rx_cdrlock_counter(4),
      O => \n_0_gt0_rx_cdrlock_counter[4]_i_3\
    );
\gt0_rx_cdrlock_counter[4]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => gt0_rx_cdrlock_counter(3),
      O => \n_0_gt0_rx_cdrlock_counter[4]_i_4\
    );
\gt0_rx_cdrlock_counter[4]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => gt0_rx_cdrlock_counter(2),
      O => \n_0_gt0_rx_cdrlock_counter[4]_i_5\
    );
\gt0_rx_cdrlock_counter[4]_i_6\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => gt0_rx_cdrlock_counter(1),
      O => \n_0_gt0_rx_cdrlock_counter[4]_i_6\
    );
\gt0_rx_cdrlock_counter[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFE0000"
    )
    port map (
      I0 => \n_0_gt0_rx_cdrlock_counter[13]_i_2\,
      I1 => gt0_rx_cdrlock_counter(5),
      I2 => \n_0_gt0_rx_cdrlock_counter[13]_i_3\,
      I3 => gt0_rx_cdrlock_counter(0),
      I4 => data0(5),
      O => gt0_rx_cdrlock_counter_0(5)
    );
\gt0_rx_cdrlock_counter[6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFE0000"
    )
    port map (
      I0 => \n_0_gt0_rx_cdrlock_counter[13]_i_2\,
      I1 => gt0_rx_cdrlock_counter(5),
      I2 => \n_0_gt0_rx_cdrlock_counter[13]_i_3\,
      I3 => gt0_rx_cdrlock_counter(0),
      I4 => data0(6),
      O => gt0_rx_cdrlock_counter_0(6)
    );
\gt0_rx_cdrlock_counter[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFE0000"
    )
    port map (
      I0 => \n_0_gt0_rx_cdrlock_counter[13]_i_2\,
      I1 => gt0_rx_cdrlock_counter(5),
      I2 => \n_0_gt0_rx_cdrlock_counter[13]_i_3\,
      I3 => gt0_rx_cdrlock_counter(0),
      I4 => data0(7),
      O => gt0_rx_cdrlock_counter_0(7)
    );
\gt0_rx_cdrlock_counter[8]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF00FF01"
    )
    port map (
      I0 => \n_0_gt0_rx_cdrlock_counter[13]_i_2\,
      I1 => gt0_rx_cdrlock_counter(5),
      I2 => \n_0_gt0_rx_cdrlock_counter[13]_i_3\,
      I3 => data0(8),
      I4 => gt0_rx_cdrlock_counter(0),
      O => gt0_rx_cdrlock_counter_0(8)
    );
\gt0_rx_cdrlock_counter[8]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => gt0_rx_cdrlock_counter(8),
      O => \n_0_gt0_rx_cdrlock_counter[8]_i_3\
    );
\gt0_rx_cdrlock_counter[8]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => gt0_rx_cdrlock_counter(7),
      O => \n_0_gt0_rx_cdrlock_counter[8]_i_4\
    );
\gt0_rx_cdrlock_counter[8]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => gt0_rx_cdrlock_counter(6),
      O => \n_0_gt0_rx_cdrlock_counter[8]_i_5\
    );
\gt0_rx_cdrlock_counter[8]_i_6\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => gt0_rx_cdrlock_counter(5),
      O => \n_0_gt0_rx_cdrlock_counter[8]_i_6\
    );
\gt0_rx_cdrlock_counter[9]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF00FF01"
    )
    port map (
      I0 => \n_0_gt0_rx_cdrlock_counter[13]_i_2\,
      I1 => gt0_rx_cdrlock_counter(5),
      I2 => \n_0_gt0_rx_cdrlock_counter[13]_i_3\,
      I3 => data0(9),
      I4 => gt0_rx_cdrlock_counter(0),
      O => gt0_rx_cdrlock_counter_0(9)
    );
\gt0_rx_cdrlock_counter_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => gt0_rx_cdrlock_counter_0(0),
      Q => gt0_rx_cdrlock_counter(0),
      R => data_out_1
    );
\gt0_rx_cdrlock_counter_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => gt0_rx_cdrlock_counter_0(10),
      Q => gt0_rx_cdrlock_counter(10),
      R => data_out_1
    );
\gt0_rx_cdrlock_counter_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => gt0_rx_cdrlock_counter_0(11),
      Q => gt0_rx_cdrlock_counter(11),
      R => data_out_1
    );
\gt0_rx_cdrlock_counter_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => gt0_rx_cdrlock_counter_0(12),
      Q => gt0_rx_cdrlock_counter(12),
      R => data_out_1
    );
\gt0_rx_cdrlock_counter_reg[12]_i_2\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_gt0_rx_cdrlock_counter_reg[8]_i_2\,
      CO(3) => \n_0_gt0_rx_cdrlock_counter_reg[12]_i_2\,
      CO(2) => \n_1_gt0_rx_cdrlock_counter_reg[12]_i_2\,
      CO(1) => \n_2_gt0_rx_cdrlock_counter_reg[12]_i_2\,
      CO(0) => \n_3_gt0_rx_cdrlock_counter_reg[12]_i_2\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '0',
      O(3 downto 0) => data0(12 downto 9),
      S(3) => \n_0_gt0_rx_cdrlock_counter[12]_i_3\,
      S(2) => \n_0_gt0_rx_cdrlock_counter[12]_i_4\,
      S(1) => \n_0_gt0_rx_cdrlock_counter[12]_i_5\,
      S(0) => \n_0_gt0_rx_cdrlock_counter[12]_i_6\
    );
\gt0_rx_cdrlock_counter_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => gt0_rx_cdrlock_counter_0(13),
      Q => gt0_rx_cdrlock_counter(13),
      R => data_out_1
    );
\gt0_rx_cdrlock_counter_reg[13]_i_4\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_gt0_rx_cdrlock_counter_reg[12]_i_2\,
      CO(3 downto 0) => \NLW_gt0_rx_cdrlock_counter_reg[13]_i_4_CO_UNCONNECTED\(3 downto 0),
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '0',
      O(3 downto 1) => \NLW_gt0_rx_cdrlock_counter_reg[13]_i_4_O_UNCONNECTED\(3 downto 1),
      O(0) => data0(13),
      S(3) => '0',
      S(2) => '0',
      S(1) => '0',
      S(0) => \n_0_gt0_rx_cdrlock_counter[13]_i_5\
    );
\gt0_rx_cdrlock_counter_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => gt0_rx_cdrlock_counter_0(1),
      Q => gt0_rx_cdrlock_counter(1),
      R => data_out_1
    );
\gt0_rx_cdrlock_counter_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => gt0_rx_cdrlock_counter_0(2),
      Q => gt0_rx_cdrlock_counter(2),
      R => data_out_1
    );
\gt0_rx_cdrlock_counter_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => gt0_rx_cdrlock_counter_0(3),
      Q => gt0_rx_cdrlock_counter(3),
      R => data_out_1
    );
\gt0_rx_cdrlock_counter_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => gt0_rx_cdrlock_counter_0(4),
      Q => gt0_rx_cdrlock_counter(4),
      R => data_out_1
    );
\gt0_rx_cdrlock_counter_reg[4]_i_2\: unisim.vcomponents.CARRY4
    port map (
      CI => '0',
      CO(3) => \n_0_gt0_rx_cdrlock_counter_reg[4]_i_2\,
      CO(2) => \n_1_gt0_rx_cdrlock_counter_reg[4]_i_2\,
      CO(1) => \n_2_gt0_rx_cdrlock_counter_reg[4]_i_2\,
      CO(0) => \n_3_gt0_rx_cdrlock_counter_reg[4]_i_2\,
      CYINIT => gt0_rx_cdrlock_counter(0),
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '0',
      O(3 downto 0) => data0(4 downto 1),
      S(3) => \n_0_gt0_rx_cdrlock_counter[4]_i_3\,
      S(2) => \n_0_gt0_rx_cdrlock_counter[4]_i_4\,
      S(1) => \n_0_gt0_rx_cdrlock_counter[4]_i_5\,
      S(0) => \n_0_gt0_rx_cdrlock_counter[4]_i_6\
    );
\gt0_rx_cdrlock_counter_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => gt0_rx_cdrlock_counter_0(5),
      Q => gt0_rx_cdrlock_counter(5),
      R => data_out_1
    );
\gt0_rx_cdrlock_counter_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => gt0_rx_cdrlock_counter_0(6),
      Q => gt0_rx_cdrlock_counter(6),
      R => data_out_1
    );
\gt0_rx_cdrlock_counter_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => gt0_rx_cdrlock_counter_0(7),
      Q => gt0_rx_cdrlock_counter(7),
      R => data_out_1
    );
\gt0_rx_cdrlock_counter_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => gt0_rx_cdrlock_counter_0(8),
      Q => gt0_rx_cdrlock_counter(8),
      R => data_out_1
    );
\gt0_rx_cdrlock_counter_reg[8]_i_2\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_gt0_rx_cdrlock_counter_reg[4]_i_2\,
      CO(3) => \n_0_gt0_rx_cdrlock_counter_reg[8]_i_2\,
      CO(2) => \n_1_gt0_rx_cdrlock_counter_reg[8]_i_2\,
      CO(1) => \n_2_gt0_rx_cdrlock_counter_reg[8]_i_2\,
      CO(0) => \n_3_gt0_rx_cdrlock_counter_reg[8]_i_2\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => '0',
      DI(1) => '0',
      DI(0) => '0',
      O(3 downto 0) => data0(8 downto 5),
      S(3) => \n_0_gt0_rx_cdrlock_counter[8]_i_3\,
      S(2) => \n_0_gt0_rx_cdrlock_counter[8]_i_4\,
      S(1) => \n_0_gt0_rx_cdrlock_counter[8]_i_5\,
      S(0) => \n_0_gt0_rx_cdrlock_counter[8]_i_6\
    );
\gt0_rx_cdrlock_counter_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => gt0_rx_cdrlock_counter_0(9),
      Q => gt0_rx_cdrlock_counter(9),
      R => data_out_1
    );
gt0_rx_cdrlocked_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF00FF01"
    )
    port map (
      I0 => \n_0_gt0_rx_cdrlock_counter[13]_i_2\,
      I1 => gt0_rx_cdrlock_counter(5),
      I2 => \n_0_gt0_rx_cdrlock_counter[13]_i_3\,
      I3 => n_0_gt0_rx_cdrlocked_reg,
      I4 => gt0_rx_cdrlock_counter(0),
      O => n_0_gt0_rx_cdrlocked_i_1
    );
gt0_rx_cdrlocked_reg: unisim.vcomponents.FDRE
    port map (
      C => independent_clock_bufg,
      CE => '1',
      D => n_0_gt0_rx_cdrlocked_i_1,
      Q => n_0_gt0_rx_cdrlocked_reg,
      R => data_out_1
    );
gt0_rxresetfsm_i: entity work.\gmii_to_sgmii_gmii_to_sgmii_RX_STARTUP_FSM__parameterized0\
    port map (
      AR(0) => AR(0),
      I1 => n_4_gtwizard_i,
      I2 => I2,
      I3 => data_in,
      I4 => n_0_gtwizard_i,
      I5 => n_0_gt0_rx_cdrlocked_reg,
      O1 => gt0_rxresetdone_out,
      RXDFELFHOLD => RXDFELFHOLD,
      RXUSERRDY => RXUSERRDY,
      data_in => GTRXRESET,
      data_out => data_out,
      independent_clock_bufg => independent_clock_bufg
    );
gt0_txresetfsm_i: entity work.\gmii_to_sgmii_gmii_to_sgmii_TX_STARTUP_FSM__parameterized0\
    port map (
      AR(0) => AR(0),
      CPLL_RESET => CPLL_RESET,
      I1 => data_in,
      I2 => n_0_gtwizard_i,
      I3 => I3,
      I7 => I7,
      O1 => n_2_gt0_txresetfsm_i,
      O2 => n_3_gt0_txresetfsm_i,
      TXUSERRDY => TXUSERRDY,
      ack_flag => \gt0_GTWIZARD_i/ack_flag\,
      data_in => n_6_gtwizard_i,
      data_in_0 => data_in_0,
      gt0_rxresetdone_out => gt0_rxresetdone_out,
      independent_clock_bufg => independent_clock_bufg
    );
gtwizard_i: entity work.\gmii_to_sgmii_gmii_to_sgmii_GTWIZARD_multi_gt__parameterized0\
    port map (
      CLK => CLK,
      CPLL_RESET => CPLL_RESET,
      D(23 downto 0) => D(23 downto 0),
      I => I,
      I1 => I1,
      I2 => n_3_gt0_txresetfsm_i,
      I3 => I2,
      I4 => I3,
      I5(1 downto 0) => I4(1 downto 0),
      I6(1 downto 0) => I5(1 downto 0),
      I7(1 downto 0) => I6(1 downto 0),
      I8 => n_2_gt0_txresetfsm_i,
      O1 => n_0_gtwizard_i,
      O2 => n_4_gtwizard_i,
      O3 => n_6_gtwizard_i,
      Q(15 downto 0) => Q(15 downto 0),
      RXDFELFHOLD => RXDFELFHOLD,
      RXPD(0) => RXPD(0),
      RXUSERRDY => RXUSERRDY,
      TXBUFSTATUS(0) => TXBUFSTATUS(0),
      TXPD(0) => TXPD(0),
      TXUSERRDY => TXUSERRDY,
      ack_flag => \gt0_GTWIZARD_i/ack_flag\,
      data_in => GTRXRESET,
      gt0_qplloutclk_out => gt0_qplloutclk_out,
      gt0_qplloutrefclk_out => gt0_qplloutrefclk_out,
      independent_clock_bufg => independent_clock_bufg,
      reset => reset,
      reset_out => reset_out,
      rxn => rxn,
      rxp => rxp,
      txn => txn,
      txoutclk => txoutclk,
      txp => txp
    );
sync_block_gtrxreset: entity work.\gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_15\
    port map (
      data_in => GTRXRESET,
      data_out => data_out_1,
      independent_clock_bufg => independent_clock_bufg
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \gmii_to_sgmii_gmii_to_sgmii_GTWIZARD__parameterized0\ is
  port (
    txn : out STD_LOGIC;
    txp : out STD_LOGIC;
    I : out STD_LOGIC;
    txoutclk : out STD_LOGIC;
    TXBUFSTATUS : out STD_LOGIC_VECTOR ( 0 to 0 );
    D : out STD_LOGIC_VECTOR ( 23 downto 0 );
    data_in_0 : out STD_LOGIC;
    independent_clock_bufg : in STD_LOGIC;
    CLK : in STD_LOGIC;
    rxn : in STD_LOGIC;
    rxp : in STD_LOGIC;
    I1 : in STD_LOGIC;
    gt0_qplloutclk_out : in STD_LOGIC;
    gt0_qplloutrefclk_out : in STD_LOGIC;
    reset_out : in STD_LOGIC;
    reset : in STD_LOGIC;
    I2 : in STD_LOGIC;
    TXPD : in STD_LOGIC_VECTOR ( 0 to 0 );
    I3 : in STD_LOGIC;
    RXPD : in STD_LOGIC_VECTOR ( 0 to 0 );
    Q : in STD_LOGIC_VECTOR ( 15 downto 0 );
    I4 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    I5 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    I6 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    AR : in STD_LOGIC_VECTOR ( 0 to 0 );
    data_in : in STD_LOGIC;
    data_out : in STD_LOGIC;
    I7 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \gmii_to_sgmii_gmii_to_sgmii_GTWIZARD__parameterized0\ : entity is "gmii_to_sgmii_GTWIZARD";
end \gmii_to_sgmii_gmii_to_sgmii_GTWIZARD__parameterized0\;

architecture STRUCTURE of \gmii_to_sgmii_gmii_to_sgmii_GTWIZARD__parameterized0\ is
begin
U0: entity work.\gmii_to_sgmii_gmii_to_sgmii_GTWIZARD_init__parameterized0\
    port map (
      AR(0) => AR(0),
      CLK => CLK,
      D(23 downto 0) => D(23 downto 0),
      I => I,
      I1 => I1,
      I2 => I2,
      I3 => I3,
      I4(1 downto 0) => I4(1 downto 0),
      I5(1 downto 0) => I5(1 downto 0),
      I6(1 downto 0) => I6(1 downto 0),
      I7 => I7,
      Q(15 downto 0) => Q(15 downto 0),
      RXPD(0) => RXPD(0),
      TXBUFSTATUS(0) => TXBUFSTATUS(0),
      TXPD(0) => TXPD(0),
      data_in => data_in,
      data_in_0 => data_in_0,
      data_out => data_out,
      gt0_qplloutclk_out => gt0_qplloutclk_out,
      gt0_qplloutrefclk_out => gt0_qplloutrefclk_out,
      independent_clock_bufg => independent_clock_bufg,
      reset => reset,
      reset_out => reset_out,
      rxn => rxn,
      rxp => rxp,
      txn => txn,
      txoutclk => txoutclk,
      txp => txp
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \gmii_to_sgmii_gmii_to_sgmii_transceiver__parameterized0\ is
  port (
    txn : out STD_LOGIC;
    txp : out STD_LOGIC;
    I : out STD_LOGIC;
    txoutclk : out STD_LOGIC;
    rxchariscomma : out STD_LOGIC_VECTOR ( 0 to 0 );
    rxcharisk : out STD_LOGIC_VECTOR ( 0 to 0 );
    rxdisperr : out STD_LOGIC_VECTOR ( 0 to 0 );
    rxnotintable : out STD_LOGIC_VECTOR ( 0 to 0 );
    rxrundisp : out STD_LOGIC_VECTOR ( 0 to 0 );
    txbuferr : out STD_LOGIC;
    rxbufstatus : out STD_LOGIC_VECTOR ( 0 to 0 );
    rxclkcorcnt : out STD_LOGIC_VECTOR ( 1 downto 0 );
    Q : out STD_LOGIC_VECTOR ( 7 downto 0 );
    data_in_0 : out STD_LOGIC;
    independent_clock_bufg : in STD_LOGIC;
    CLK : in STD_LOGIC;
    rxn : in STD_LOGIC;
    rxp : in STD_LOGIC;
    I1 : in STD_LOGIC;
    gt0_qplloutclk_out : in STD_LOGIC;
    gt0_qplloutrefclk_out : in STD_LOGIC;
    I2 : in STD_LOGIC;
    I3 : in STD_LOGIC;
    reset_in : in STD_LOGIC;
    powerdown : in STD_LOGIC;
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    D : in STD_LOGIC_VECTOR ( 0 to 0 );
    I4 : in STD_LOGIC_VECTOR ( 0 to 0 );
    I5 : in STD_LOGIC_VECTOR ( 0 to 0 );
    AR : in STD_LOGIC_VECTOR ( 0 to 0 );
    status_vector : in STD_LOGIC_VECTOR ( 0 to 0 );
    encommaalign : in STD_LOGIC;
    data_in : in STD_LOGIC;
    I6 : in STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \gmii_to_sgmii_gmii_to_sgmii_transceiver__parameterized0\ : entity is "gmii_to_sgmii_transceiver";
end \gmii_to_sgmii_gmii_to_sgmii_transceiver__parameterized0\;

architecture STRUCTURE of \gmii_to_sgmii_gmii_to_sgmii_transceiver__parameterized0\ is
  signal gt0_rxmcommaalignen_in : STD_LOGIC;
  signal initialize_ram_complete : STD_LOGIC;
  signal initialize_ram_complete_pulse : STD_LOGIC;
  signal n_0_reclock_rxreset : STD_LOGIC;
  signal n_0_sync_block_data_valid : STD_LOGIC;
  signal n_0_toggle_i_1 : STD_LOGIC;
  signal \n_0_txbufstatus_reg_reg[1]\ : STD_LOGIC;
  signal n_4_gtwizard_inst : STD_LOGIC;
  signal reset : STD_LOGIC;
  signal reset_out : STD_LOGIC;
  signal rxchariscomma_rec : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal rxcharisk_rec : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal rxdata_rec : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal rxdisperr_rec : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal rxnotintable_rec : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal rxpowerdown_reg : STD_LOGIC;
  signal rxrecreset : STD_LOGIC;
  signal toggle : STD_LOGIC;
  signal txchardispmode_double : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal txchardispmode_int : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal txchardispmode_reg : STD_LOGIC;
  signal txchardispval_double : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal txchardispval_int : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal txchardispval_reg : STD_LOGIC;
  signal txcharisk_double : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal txcharisk_int : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal txcharisk_reg : STD_LOGIC;
  signal txdata_double : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal txdata_int : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal txdata_reg : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal txpowerdown : STD_LOGIC;
  signal txpowerdown_double : STD_LOGIC;
  signal \txpowerdown_reg__0\ : STD_LOGIC;
  signal wr_data1 : STD_LOGIC;
begin
gtwizard_inst: entity work.\gmii_to_sgmii_gmii_to_sgmii_GTWIZARD__parameterized0\
    port map (
      AR(0) => AR(0),
      CLK => CLK,
      D(23) => rxchariscomma_rec(0),
      D(22) => rxcharisk_rec(0),
      D(21) => rxdisperr_rec(0),
      D(20) => rxnotintable_rec(0),
      D(19 downto 12) => rxdata_rec(7 downto 0),
      D(11) => rxchariscomma_rec(1),
      D(10) => rxcharisk_rec(1),
      D(9) => rxdisperr_rec(1),
      D(8) => rxnotintable_rec(1),
      D(7 downto 0) => rxdata_rec(15 downto 8),
      I => I,
      I1 => I1,
      I2 => I2,
      I3 => I3,
      I4(1 downto 0) => txchardispmode_int(1 downto 0),
      I5(1 downto 0) => txchardispval_int(1 downto 0),
      I6(1 downto 0) => txcharisk_int(1 downto 0),
      I7 => reset_out,
      Q(15 downto 0) => txdata_int(15 downto 0),
      RXPD(0) => rxpowerdown_reg,
      TXBUFSTATUS(0) => n_4_gtwizard_inst,
      TXPD(0) => txpowerdown,
      data_in => data_in,
      data_in_0 => data_in_0,
      data_out => n_0_sync_block_data_valid,
      gt0_qplloutclk_out => gt0_qplloutclk_out,
      gt0_qplloutrefclk_out => gt0_qplloutrefclk_out,
      independent_clock_bufg => independent_clock_bufg,
      reset => reset,
      reset_out => gt0_rxmcommaalignen_in,
      rxn => rxn,
      rxp => rxp,
      txn => txn,
      txoutclk => txoutclk,
      txp => txp
    );
reclock_encommaalign: entity work.gmii_to_sgmii_gmii_to_sgmii_reset_sync
    port map (
      I2 => I2,
      encommaalign => encommaalign,
      reset_out => gt0_rxmcommaalignen_in
    );
reclock_rxreset: entity work.gmii_to_sgmii_gmii_to_sgmii_reset_sync_0
    port map (
      I2 => I2,
      O1(0) => wr_data1,
      SR(0) => n_0_reclock_rxreset,
      initialize_ram_complete => initialize_ram_complete,
      initialize_ram_complete_pulse => initialize_ram_complete_pulse,
      reset_in => reset_in,
      reset_out => rxrecreset
    );
reclock_txreset: entity work.gmii_to_sgmii_gmii_to_sgmii_reset_sync_1
    port map (
      I3 => I3,
      SR(0) => SR(0),
      reset_out => reset_out
    );
reset_wtd_timer: entity work.gmii_to_sgmii_gmii_to_sgmii_reset_wtd_timer
    port map (
      data_out => n_0_sync_block_data_valid,
      independent_clock_bufg => independent_clock_bufg,
      reset => reset
    );
rx_elastic_buffer_inst: entity work.gmii_to_sgmii_gmii_to_sgmii_rx_elastic_buffer
    port map (
      CLK => CLK,
      D(23) => rxchariscomma_rec(0),
      D(22) => rxcharisk_rec(0),
      D(21) => rxdisperr_rec(0),
      D(20) => rxnotintable_rec(0),
      D(19 downto 12) => rxdata_rec(7 downto 0),
      D(11) => rxchariscomma_rec(1),
      D(10) => rxcharisk_rec(1),
      D(9) => rxdisperr_rec(1),
      D(8) => rxnotintable_rec(1),
      D(7 downto 0) => rxdata_rec(15 downto 8),
      I1(0) => n_0_reclock_rxreset,
      I2 => I2,
      Q(7 downto 0) => Q(7 downto 0),
      SR(0) => wr_data1,
      initialize_ram_complete => initialize_ram_complete,
      initialize_ram_complete_pulse => initialize_ram_complete_pulse,
      reset_in => reset_in,
      rxbufstatus(0) => rxbufstatus(0),
      rxchariscomma(0) => rxchariscomma(0),
      rxcharisk(0) => rxcharisk(0),
      rxclkcorcnt(1 downto 0) => rxclkcorcnt(1 downto 0),
      rxdisperr(0) => rxdisperr(0),
      rxnotintable(0) => rxnotintable(0),
      rxrecreset => rxrecreset,
      rxrundisp(0) => rxrundisp(0)
    );
rxpowerdown_reg_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => powerdown,
      Q => rxpowerdown_reg,
      R => reset_in
    );
sync_block_data_valid: entity work.\gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0_2\
    port map (
      data_out => n_0_sync_block_data_valid,
      independent_clock_bufg => independent_clock_bufg,
      status_vector(0) => status_vector(0)
    );
toggle_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => toggle,
      O => n_0_toggle_i_1
    );
toggle_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => n_0_toggle_i_1,
      Q => toggle,
      R => SR(0)
    );
txbuferr_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => \n_0_txbufstatus_reg_reg[1]\,
      Q => txbuferr,
      R => '0'
    );
\txbufstatus_reg_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => '1',
      D => n_4_gtwizard_inst,
      Q => \n_0_txbufstatus_reg_reg[1]\,
      R => '0'
    );
\txchardispmode_double_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => n_0_toggle_i_1,
      D => txchardispmode_reg,
      Q => txchardispmode_double(0),
      R => SR(0)
    );
\txchardispmode_double_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => n_0_toggle_i_1,
      D => D(0),
      Q => txchardispmode_double(1),
      R => SR(0)
    );
\txchardispmode_int_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => '1',
      D => txchardispmode_double(0),
      Q => txchardispmode_int(0),
      R => '0'
    );
\txchardispmode_int_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => '1',
      D => txchardispmode_double(1),
      Q => txchardispmode_int(1),
      R => '0'
    );
txchardispmode_reg_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => D(0),
      Q => txchardispmode_reg,
      R => SR(0)
    );
\txchardispval_double_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => n_0_toggle_i_1,
      D => txchardispval_reg,
      Q => txchardispval_double(0),
      R => SR(0)
    );
\txchardispval_double_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => n_0_toggle_i_1,
      D => I4(0),
      Q => txchardispval_double(1),
      R => SR(0)
    );
\txchardispval_int_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => '1',
      D => txchardispval_double(0),
      Q => txchardispval_int(0),
      R => '0'
    );
\txchardispval_int_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => '1',
      D => txchardispval_double(1),
      Q => txchardispval_int(1),
      R => '0'
    );
txchardispval_reg_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => I4(0),
      Q => txchardispval_reg,
      R => SR(0)
    );
\txcharisk_double_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => n_0_toggle_i_1,
      D => txcharisk_reg,
      Q => txcharisk_double(0),
      R => SR(0)
    );
\txcharisk_double_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => n_0_toggle_i_1,
      D => I5(0),
      Q => txcharisk_double(1),
      R => SR(0)
    );
\txcharisk_int_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => '1',
      D => txcharisk_double(0),
      Q => txcharisk_int(0),
      R => '0'
    );
\txcharisk_int_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => '1',
      D => txcharisk_double(1),
      Q => txcharisk_int(1),
      R => '0'
    );
txcharisk_reg_reg: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => I5(0),
      Q => txcharisk_reg,
      R => SR(0)
    );
\txdata_double_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => n_0_toggle_i_1,
      D => txdata_reg(0),
      Q => txdata_double(0),
      R => SR(0)
    );
\txdata_double_reg[10]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => n_0_toggle_i_1,
      D => I6(2),
      Q => txdata_double(10),
      R => SR(0)
    );
\txdata_double_reg[11]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => n_0_toggle_i_1,
      D => I6(3),
      Q => txdata_double(11),
      R => SR(0)
    );
\txdata_double_reg[12]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => n_0_toggle_i_1,
      D => I6(4),
      Q => txdata_double(12),
      R => SR(0)
    );
\txdata_double_reg[13]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => n_0_toggle_i_1,
      D => I6(5),
      Q => txdata_double(13),
      R => SR(0)
    );
\txdata_double_reg[14]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => n_0_toggle_i_1,
      D => I6(6),
      Q => txdata_double(14),
      R => SR(0)
    );
\txdata_double_reg[15]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => n_0_toggle_i_1,
      D => I6(7),
      Q => txdata_double(15),
      R => SR(0)
    );
\txdata_double_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => n_0_toggle_i_1,
      D => txdata_reg(1),
      Q => txdata_double(1),
      R => SR(0)
    );
\txdata_double_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => n_0_toggle_i_1,
      D => txdata_reg(2),
      Q => txdata_double(2),
      R => SR(0)
    );
\txdata_double_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => n_0_toggle_i_1,
      D => txdata_reg(3),
      Q => txdata_double(3),
      R => SR(0)
    );
\txdata_double_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => n_0_toggle_i_1,
      D => txdata_reg(4),
      Q => txdata_double(4),
      R => SR(0)
    );
\txdata_double_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => n_0_toggle_i_1,
      D => txdata_reg(5),
      Q => txdata_double(5),
      R => SR(0)
    );
\txdata_double_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => n_0_toggle_i_1,
      D => txdata_reg(6),
      Q => txdata_double(6),
      R => SR(0)
    );
\txdata_double_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => n_0_toggle_i_1,
      D => txdata_reg(7),
      Q => txdata_double(7),
      R => SR(0)
    );
\txdata_double_reg[8]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => n_0_toggle_i_1,
      D => I6(0),
      Q => txdata_double(8),
      R => SR(0)
    );
\txdata_double_reg[9]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => n_0_toggle_i_1,
      D => I6(1),
      Q => txdata_double(9),
      R => SR(0)
    );
\txdata_int_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => '1',
      D => txdata_double(0),
      Q => txdata_int(0),
      R => '0'
    );
\txdata_int_reg[10]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => '1',
      D => txdata_double(10),
      Q => txdata_int(10),
      R => '0'
    );
\txdata_int_reg[11]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => '1',
      D => txdata_double(11),
      Q => txdata_int(11),
      R => '0'
    );
\txdata_int_reg[12]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => '1',
      D => txdata_double(12),
      Q => txdata_int(12),
      R => '0'
    );
\txdata_int_reg[13]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => '1',
      D => txdata_double(13),
      Q => txdata_int(13),
      R => '0'
    );
\txdata_int_reg[14]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => '1',
      D => txdata_double(14),
      Q => txdata_int(14),
      R => '0'
    );
\txdata_int_reg[15]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => '1',
      D => txdata_double(15),
      Q => txdata_int(15),
      R => '0'
    );
\txdata_int_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => '1',
      D => txdata_double(1),
      Q => txdata_int(1),
      R => '0'
    );
\txdata_int_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => '1',
      D => txdata_double(2),
      Q => txdata_int(2),
      R => '0'
    );
\txdata_int_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => '1',
      D => txdata_double(3),
      Q => txdata_int(3),
      R => '0'
    );
\txdata_int_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => '1',
      D => txdata_double(4),
      Q => txdata_int(4),
      R => '0'
    );
\txdata_int_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => '1',
      D => txdata_double(5),
      Q => txdata_int(5),
      R => '0'
    );
\txdata_int_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => '1',
      D => txdata_double(6),
      Q => txdata_int(6),
      R => '0'
    );
\txdata_int_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => '1',
      D => txdata_double(7),
      Q => txdata_int(7),
      R => '0'
    );
\txdata_int_reg[8]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => '1',
      D => txdata_double(8),
      Q => txdata_int(8),
      R => '0'
    );
\txdata_int_reg[9]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => '1',
      D => txdata_double(9),
      Q => txdata_int(9),
      R => '0'
    );
\txdata_reg_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => I6(0),
      Q => txdata_reg(0),
      R => SR(0)
    );
\txdata_reg_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => I6(1),
      Q => txdata_reg(1),
      R => SR(0)
    );
\txdata_reg_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => I6(2),
      Q => txdata_reg(2),
      R => SR(0)
    );
\txdata_reg_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => I6(3),
      Q => txdata_reg(3),
      R => SR(0)
    );
\txdata_reg_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => I6(4),
      Q => txdata_reg(4),
      R => SR(0)
    );
\txdata_reg_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => I6(5),
      Q => txdata_reg(5),
      R => SR(0)
    );
\txdata_reg_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => I6(6),
      Q => txdata_reg(6),
      R => SR(0)
    );
\txdata_reg_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => CLK,
      CE => '1',
      D => I6(7),
      Q => txdata_reg(7),
      R => SR(0)
    );
txpowerdown_double_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => \txpowerdown_reg__0\,
      Q => txpowerdown_double,
      R => SR(0)
    );
txpowerdown_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I3,
      CE => '1',
      D => txpowerdown_double,
      Q => txpowerdown,
      R => '0'
    );
txpowerdown_reg_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => '1',
      D => powerdown,
      Q => \txpowerdown_reg__0\,
      R => SR(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gmii_to_sgmii_gmii_to_sgmii_block is
  port (
    gmii_isolate : out STD_LOGIC;
    an_interrupt : out STD_LOGIC;
    status_vector : out STD_LOGIC_VECTOR ( 15 downto 0 );
    resetdone : out STD_LOGIC;
    txn : out STD_LOGIC;
    txp : out STD_LOGIC;
    txoutclk : out STD_LOGIC;
    O1 : out STD_LOGIC;
    sgmii_clk_r : out STD_LOGIC;
    O2 : out STD_LOGIC;
    gmii_rx_dv : out STD_LOGIC;
    gmii_rx_er : out STD_LOGIC;
    sgmii_clk_f : out STD_LOGIC;
    gmii_rxd : out STD_LOGIC_VECTOR ( 7 downto 0 );
    CLK : in STD_LOGIC;
    AR : in STD_LOGIC_VECTOR ( 0 to 0 );
    signal_detect : in STD_LOGIC;
    data_in : in STD_LOGIC;
    an_adv_config_vector : in STD_LOGIC_VECTOR ( 15 downto 0 );
    an_restart_config : in STD_LOGIC;
    configuration_vector : in STD_LOGIC_VECTOR ( 4 downto 0 );
    independent_clock_bufg : in STD_LOGIC;
    rxn : in STD_LOGIC;
    rxp : in STD_LOGIC;
    I1 : in STD_LOGIC;
    gt0_qplloutclk_out : in STD_LOGIC;
    gt0_qplloutrefclk_out : in STD_LOGIC;
    I2 : in STD_LOGIC;
    gmii_tx_en : in STD_LOGIC;
    gmii_tx_er : in STD_LOGIC;
    speed_is_10_100 : in STD_LOGIC;
    speed_is_100 : in STD_LOGIC;
    gmii_txd : in STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of gmii_to_sgmii_gmii_to_sgmii_block : entity is "gmii_to_sgmii_block";
end gmii_to_sgmii_gmii_to_sgmii_block;

architecture STRUCTURE of gmii_to_sgmii_gmii_to_sgmii_block is
  signal I : STD_LOGIC;
  signal \^o1\ : STD_LOGIC;
  signal data_in_0 : STD_LOGIC;
  signal encommaalign : STD_LOGIC;
  signal mgt_tx_reset : STD_LOGIC;
  signal n_15_sgmii_logic : STD_LOGIC;
  signal n_16_sgmii_logic : STD_LOGIC;
  signal n_17_sgmii_logic : STD_LOGIC;
  signal n_18_sgmii_logic : STD_LOGIC;
  signal n_19_sgmii_logic : STD_LOGIC;
  signal n_20_sgmii_logic : STD_LOGIC;
  signal n_21_sgmii_logic : STD_LOGIC;
  signal n_22_sgmii_logic : STD_LOGIC;
  signal n_28_gmii_to_sgmii_core : STD_LOGIC;
  signal n_29_gmii_to_sgmii_core : STD_LOGIC;
  signal n_30_gmii_to_sgmii_core : STD_LOGIC;
  signal n_31_gmii_to_sgmii_core : STD_LOGIC;
  signal n_32_gmii_to_sgmii_core : STD_LOGIC;
  signal n_33_gmii_to_sgmii_core : STD_LOGIC;
  signal n_34_gmii_to_sgmii_core : STD_LOGIC;
  signal n_35_gmii_to_sgmii_core : STD_LOGIC;
  signal n_36_gmii_to_sgmii_core : STD_LOGIC;
  signal n_37_gmii_to_sgmii_core : STD_LOGIC;
  signal n_4_sgmii_logic : STD_LOGIC;
  signal n_5_sgmii_logic : STD_LOGIC;
  signal powerdown : STD_LOGIC;
  signal \^resetdone\ : STD_LOGIC;
  signal rxbuferr : STD_LOGIC;
  signal rxchariscomma : STD_LOGIC;
  signal rxcharisk : STD_LOGIC;
  signal rxclkcorcnt : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal rxdata : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal rxdisperr : STD_LOGIC;
  signal rxnotintable : STD_LOGIC;
  signal rxoutclk_bufmr : STD_LOGIC;
  signal rxreset : STD_LOGIC;
  signal rxrundisp : STD_LOGIC;
  signal \^status_vector\ : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal txbuferr : STD_LOGIC;
  signal txchardispmode : STD_LOGIC;
  signal txchardispval : STD_LOGIC;
  signal txcharisk : STD_LOGIC;
  signal txdata : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal NLW_gmii_to_sgmii_core_an_enable_UNCONNECTED : STD_LOGIC;
  signal NLW_gmii_to_sgmii_core_drp_den_UNCONNECTED : STD_LOGIC;
  signal NLW_gmii_to_sgmii_core_drp_dwe_UNCONNECTED : STD_LOGIC;
  signal NLW_gmii_to_sgmii_core_drp_req_UNCONNECTED : STD_LOGIC;
  signal NLW_gmii_to_sgmii_core_en_cdet_UNCONNECTED : STD_LOGIC;
  signal NLW_gmii_to_sgmii_core_ewrap_UNCONNECTED : STD_LOGIC;
  signal NLW_gmii_to_sgmii_core_loc_ref_UNCONNECTED : STD_LOGIC;
  signal NLW_gmii_to_sgmii_core_mdio_out_UNCONNECTED : STD_LOGIC;
  signal NLW_gmii_to_sgmii_core_mdio_tri_UNCONNECTED : STD_LOGIC;
  signal NLW_gmii_to_sgmii_core_drp_daddr_UNCONNECTED : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal NLW_gmii_to_sgmii_core_drp_di_UNCONNECTED : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal NLW_gmii_to_sgmii_core_rxphy_correction_timer_UNCONNECTED : STD_LOGIC_VECTOR ( 63 downto 0 );
  signal NLW_gmii_to_sgmii_core_rxphy_ns_field_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_gmii_to_sgmii_core_rxphy_s_field_UNCONNECTED : STD_LOGIC_VECTOR ( 47 downto 0 );
  signal NLW_gmii_to_sgmii_core_speed_selection_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_gmii_to_sgmii_core_tx_code_group_UNCONNECTED : STD_LOGIC_VECTOR ( 9 downto 0 );
  attribute B_SHIFTER_ADDR : string;
  attribute B_SHIFTER_ADDR of gmii_to_sgmii_core : label is "8'b01010000";
  attribute C_1588 : integer;
  attribute C_1588 of gmii_to_sgmii_core : label is 0;
  attribute C_COMPONENT_NAME : string;
  attribute C_COMPONENT_NAME of gmii_to_sgmii_core : label is "gmii_to_sgmii";
  attribute C_DYNAMIC_SWITCHING : string;
  attribute C_DYNAMIC_SWITCHING of gmii_to_sgmii_core : label is "FALSE";
  attribute C_ELABORATION_TRANSIENT_DIR : string;
  attribute C_ELABORATION_TRANSIENT_DIR of gmii_to_sgmii_core : label is "BlankString";
  attribute C_FAMILY : string;
  attribute C_FAMILY of gmii_to_sgmii_core : label is "virtex7";
  attribute C_HAS_AN : string;
  attribute C_HAS_AN of gmii_to_sgmii_core : label is "TRUE";
  attribute C_HAS_MDIO : string;
  attribute C_HAS_MDIO of gmii_to_sgmii_core : label is "FALSE";
  attribute C_HAS_TEMAC : string;
  attribute C_HAS_TEMAC of gmii_to_sgmii_core : label is "TRUE";
  attribute C_IS_SGMII : string;
  attribute C_IS_SGMII of gmii_to_sgmii_core : label is "TRUE";
  attribute C_SGMII_FABRIC_BUFFER : string;
  attribute C_SGMII_FABRIC_BUFFER of gmii_to_sgmii_core : label is "TRUE";
  attribute C_SGMII_PHY_MODE : string;
  attribute C_SGMII_PHY_MODE of gmii_to_sgmii_core : label is "FALSE";
  attribute C_TRANSCEIVER_MODE : string;
  attribute C_TRANSCEIVER_MODE of gmii_to_sgmii_core : label is "A";
  attribute C_USE_LVDS : string;
  attribute C_USE_LVDS of gmii_to_sgmii_core : label is "FALSE";
  attribute C_USE_TBI : string;
  attribute C_USE_TBI of gmii_to_sgmii_core : label is "FALSE";
  attribute C_USE_TRANSCEIVER : string;
  attribute C_USE_TRANSCEIVER of gmii_to_sgmii_core : label is "TRUE";
  attribute DONT_TOUCH : boolean;
  attribute DONT_TOUCH of gmii_to_sgmii_core : label is std.standard.true;
  attribute GT_RX_BYTE_WIDTH : integer;
  attribute GT_RX_BYTE_WIDTH of gmii_to_sgmii_core : label is 1;
  attribute RX_GT_NOMINAL_LATENCY : string;
  attribute RX_GT_NOMINAL_LATENCY of gmii_to_sgmii_core : label is "16'b0000000011010010";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of gmii_to_sgmii_core : label is "yes";
  attribute box_type : string;
  attribute box_type of rxrecclkbufmr : label is "PRIMITIVE";
  attribute box_type of rxrecclkbufr : label is "PRIMITIVE";
begin
  O1 <= \^o1\;
  resetdone <= \^resetdone\;
  status_vector(15 downto 0) <= \^status_vector\(15 downto 0);
gmii_to_sgmii_core: entity work.\gmii_to_sgmii_gig_ethernet_pcs_pma_v14_3__parameterized0\
    port map (
      an_adv_config_val => '0',
      an_adv_config_vector(15 downto 0) => an_adv_config_vector(15 downto 0),
      an_enable => NLW_gmii_to_sgmii_core_an_enable_UNCONNECTED,
      an_interrupt => an_interrupt,
      an_restart_config => an_restart_config,
      basex_or_sgmii => '0',
      configuration_valid => '0',
      configuration_vector(4 downto 0) => configuration_vector(4 downto 0),
      correction_timer(63) => '0',
      correction_timer(62) => '0',
      correction_timer(61) => '0',
      correction_timer(60) => '0',
      correction_timer(59) => '0',
      correction_timer(58) => '0',
      correction_timer(57) => '0',
      correction_timer(56) => '0',
      correction_timer(55) => '0',
      correction_timer(54) => '0',
      correction_timer(53) => '0',
      correction_timer(52) => '0',
      correction_timer(51) => '0',
      correction_timer(50) => '0',
      correction_timer(49) => '0',
      correction_timer(48) => '0',
      correction_timer(47) => '0',
      correction_timer(46) => '0',
      correction_timer(45) => '0',
      correction_timer(44) => '0',
      correction_timer(43) => '0',
      correction_timer(42) => '0',
      correction_timer(41) => '0',
      correction_timer(40) => '0',
      correction_timer(39) => '0',
      correction_timer(38) => '0',
      correction_timer(37) => '0',
      correction_timer(36) => '0',
      correction_timer(35) => '0',
      correction_timer(34) => '0',
      correction_timer(33) => '0',
      correction_timer(32) => '0',
      correction_timer(31) => '0',
      correction_timer(30) => '0',
      correction_timer(29) => '0',
      correction_timer(28) => '0',
      correction_timer(27) => '0',
      correction_timer(26) => '0',
      correction_timer(25) => '0',
      correction_timer(24) => '0',
      correction_timer(23) => '0',
      correction_timer(22) => '0',
      correction_timer(21) => '0',
      correction_timer(20) => '0',
      correction_timer(19) => '0',
      correction_timer(18) => '0',
      correction_timer(17) => '0',
      correction_timer(16) => '0',
      correction_timer(15) => '0',
      correction_timer(14) => '0',
      correction_timer(13) => '0',
      correction_timer(12) => '0',
      correction_timer(11) => '0',
      correction_timer(10) => '0',
      correction_timer(9) => '0',
      correction_timer(8) => '0',
      correction_timer(7) => '0',
      correction_timer(6) => '0',
      correction_timer(5) => '0',
      correction_timer(4) => '0',
      correction_timer(3) => '0',
      correction_timer(2) => '0',
      correction_timer(1) => '0',
      correction_timer(0) => '0',
      dcm_locked => data_in,
      drp_daddr(8 downto 0) => NLW_gmii_to_sgmii_core_drp_daddr_UNCONNECTED(8 downto 0),
      drp_dclk => '0',
      drp_den => NLW_gmii_to_sgmii_core_drp_den_UNCONNECTED,
      drp_di(15 downto 0) => NLW_gmii_to_sgmii_core_drp_di_UNCONNECTED(15 downto 0),
      drp_do(15) => '0',
      drp_do(14) => '0',
      drp_do(13) => '0',
      drp_do(12) => '0',
      drp_do(11) => '0',
      drp_do(10) => '0',
      drp_do(9) => '0',
      drp_do(8) => '0',
      drp_do(7) => '0',
      drp_do(6) => '0',
      drp_do(5) => '0',
      drp_do(4) => '0',
      drp_do(3) => '0',
      drp_do(2) => '0',
      drp_do(1) => '0',
      drp_do(0) => '0',
      drp_drdy => '0',
      drp_dwe => NLW_gmii_to_sgmii_core_drp_dwe_UNCONNECTED,
      drp_gnt => '0',
      drp_req => NLW_gmii_to_sgmii_core_drp_req_UNCONNECTED,
      en_cdet => NLW_gmii_to_sgmii_core_en_cdet_UNCONNECTED,
      enablealign => encommaalign,
      ewrap => NLW_gmii_to_sgmii_core_ewrap_UNCONNECTED,
      gmii_isolate => gmii_isolate,
      gmii_rx_dv => n_36_gmii_to_sgmii_core,
      gmii_rx_er => n_37_gmii_to_sgmii_core,
      gmii_rxd(7) => n_28_gmii_to_sgmii_core,
      gmii_rxd(6) => n_29_gmii_to_sgmii_core,
      gmii_rxd(5) => n_30_gmii_to_sgmii_core,
      gmii_rxd(4) => n_31_gmii_to_sgmii_core,
      gmii_rxd(3) => n_32_gmii_to_sgmii_core,
      gmii_rxd(2) => n_33_gmii_to_sgmii_core,
      gmii_rxd(1) => n_34_gmii_to_sgmii_core,
      gmii_rxd(0) => n_35_gmii_to_sgmii_core,
      gmii_tx_en => n_4_sgmii_logic,
      gmii_tx_er => n_5_sgmii_logic,
      gmii_txd(7) => n_15_sgmii_logic,
      gmii_txd(6) => n_16_sgmii_logic,
      gmii_txd(5) => n_17_sgmii_logic,
      gmii_txd(4) => n_18_sgmii_logic,
      gmii_txd(3) => n_19_sgmii_logic,
      gmii_txd(2) => n_20_sgmii_logic,
      gmii_txd(1) => n_21_sgmii_logic,
      gmii_txd(0) => n_22_sgmii_logic,
      gtx_clk => '0',
      link_timer_basex(8) => '0',
      link_timer_basex(7) => '0',
      link_timer_basex(6) => '0',
      link_timer_basex(5) => '0',
      link_timer_basex(4) => '0',
      link_timer_basex(3) => '0',
      link_timer_basex(2) => '0',
      link_timer_basex(1) => '0',
      link_timer_basex(0) => '0',
      link_timer_sgmii(8) => '0',
      link_timer_sgmii(7) => '0',
      link_timer_sgmii(6) => '0',
      link_timer_sgmii(5) => '0',
      link_timer_sgmii(4) => '0',
      link_timer_sgmii(3) => '0',
      link_timer_sgmii(2) => '0',
      link_timer_sgmii(1) => '0',
      link_timer_sgmii(0) => '0',
      link_timer_value(8) => '0',
      link_timer_value(7) => '0',
      link_timer_value(6) => '0',
      link_timer_value(5) => '1',
      link_timer_value(4) => '1',
      link_timer_value(3) => '0',
      link_timer_value(2) => '0',
      link_timer_value(1) => '1',
      link_timer_value(0) => '0',
      loc_ref => NLW_gmii_to_sgmii_core_loc_ref_UNCONNECTED,
      mdc => '0',
      mdio_in => '0',
      mdio_out => NLW_gmii_to_sgmii_core_mdio_out_UNCONNECTED,
      mdio_tri => NLW_gmii_to_sgmii_core_mdio_tri_UNCONNECTED,
      mgt_rx_reset => rxreset,
      mgt_tx_reset => mgt_tx_reset,
      phyad(4) => '0',
      phyad(3) => '0',
      phyad(2) => '0',
      phyad(1) => '0',
      phyad(0) => '0',
      pma_rx_clk0 => '0',
      pma_rx_clk1 => '0',
      powerdown => powerdown,
      reset => AR(0),
      reset_done => \^resetdone\,
      rx_code_group0(9) => '0',
      rx_code_group0(8) => '0',
      rx_code_group0(7) => '0',
      rx_code_group0(6) => '0',
      rx_code_group0(5) => '0',
      rx_code_group0(4) => '0',
      rx_code_group0(3) => '0',
      rx_code_group0(2) => '0',
      rx_code_group0(1) => '0',
      rx_code_group0(0) => '0',
      rx_code_group1(9) => '0',
      rx_code_group1(8) => '0',
      rx_code_group1(7) => '0',
      rx_code_group1(6) => '0',
      rx_code_group1(5) => '0',
      rx_code_group1(4) => '0',
      rx_code_group1(3) => '0',
      rx_code_group1(2) => '0',
      rx_code_group1(1) => '0',
      rx_code_group1(0) => '0',
      rxbufstatus(1) => rxbuferr,
      rxbufstatus(0) => '0',
      rxchariscomma(0) => rxchariscomma,
      rxcharisk(0) => rxcharisk,
      rxclkcorcnt(2) => rxclkcorcnt(2),
      rxclkcorcnt(1) => rxclkcorcnt(2),
      rxclkcorcnt(0) => rxclkcorcnt(0),
      rxdata(7 downto 0) => rxdata(7 downto 0),
      rxdisperr(0) => rxdisperr,
      rxnotintable(0) => rxnotintable,
      rxphy_correction_timer(63 downto 0) => NLW_gmii_to_sgmii_core_rxphy_correction_timer_UNCONNECTED(63 downto 0),
      rxphy_ns_field(31 downto 0) => NLW_gmii_to_sgmii_core_rxphy_ns_field_UNCONNECTED(31 downto 0),
      rxphy_s_field(47 downto 0) => NLW_gmii_to_sgmii_core_rxphy_s_field_UNCONNECTED(47 downto 0),
      rxrecclk => '0',
      rxrundisp(0) => rxrundisp,
      signal_detect => signal_detect,
      speed_selection(1 downto 0) => NLW_gmii_to_sgmii_core_speed_selection_UNCONNECTED(1 downto 0),
      status_vector(15 downto 0) => \^status_vector\(15 downto 0),
      systemtimer_ns_field(31) => '0',
      systemtimer_ns_field(30) => '0',
      systemtimer_ns_field(29) => '0',
      systemtimer_ns_field(28) => '0',
      systemtimer_ns_field(27) => '0',
      systemtimer_ns_field(26) => '0',
      systemtimer_ns_field(25) => '0',
      systemtimer_ns_field(24) => '0',
      systemtimer_ns_field(23) => '0',
      systemtimer_ns_field(22) => '0',
      systemtimer_ns_field(21) => '0',
      systemtimer_ns_field(20) => '0',
      systemtimer_ns_field(19) => '0',
      systemtimer_ns_field(18) => '0',
      systemtimer_ns_field(17) => '0',
      systemtimer_ns_field(16) => '0',
      systemtimer_ns_field(15) => '0',
      systemtimer_ns_field(14) => '0',
      systemtimer_ns_field(13) => '0',
      systemtimer_ns_field(12) => '0',
      systemtimer_ns_field(11) => '0',
      systemtimer_ns_field(10) => '0',
      systemtimer_ns_field(9) => '0',
      systemtimer_ns_field(8) => '0',
      systemtimer_ns_field(7) => '0',
      systemtimer_ns_field(6) => '0',
      systemtimer_ns_field(5) => '0',
      systemtimer_ns_field(4) => '0',
      systemtimer_ns_field(3) => '0',
      systemtimer_ns_field(2) => '0',
      systemtimer_ns_field(1) => '0',
      systemtimer_ns_field(0) => '0',
      systemtimer_s_field(47) => '0',
      systemtimer_s_field(46) => '0',
      systemtimer_s_field(45) => '0',
      systemtimer_s_field(44) => '0',
      systemtimer_s_field(43) => '0',
      systemtimer_s_field(42) => '0',
      systemtimer_s_field(41) => '0',
      systemtimer_s_field(40) => '0',
      systemtimer_s_field(39) => '0',
      systemtimer_s_field(38) => '0',
      systemtimer_s_field(37) => '0',
      systemtimer_s_field(36) => '0',
      systemtimer_s_field(35) => '0',
      systemtimer_s_field(34) => '0',
      systemtimer_s_field(33) => '0',
      systemtimer_s_field(32) => '0',
      systemtimer_s_field(31) => '0',
      systemtimer_s_field(30) => '0',
      systemtimer_s_field(29) => '0',
      systemtimer_s_field(28) => '0',
      systemtimer_s_field(27) => '0',
      systemtimer_s_field(26) => '0',
      systemtimer_s_field(25) => '0',
      systemtimer_s_field(24) => '0',
      systemtimer_s_field(23) => '0',
      systemtimer_s_field(22) => '0',
      systemtimer_s_field(21) => '0',
      systemtimer_s_field(20) => '0',
      systemtimer_s_field(19) => '0',
      systemtimer_s_field(18) => '0',
      systemtimer_s_field(17) => '0',
      systemtimer_s_field(16) => '0',
      systemtimer_s_field(15) => '0',
      systemtimer_s_field(14) => '0',
      systemtimer_s_field(13) => '0',
      systemtimer_s_field(12) => '0',
      systemtimer_s_field(11) => '0',
      systemtimer_s_field(10) => '0',
      systemtimer_s_field(9) => '0',
      systemtimer_s_field(8) => '0',
      systemtimer_s_field(7) => '0',
      systemtimer_s_field(6) => '0',
      systemtimer_s_field(5) => '0',
      systemtimer_s_field(4) => '0',
      systemtimer_s_field(3) => '0',
      systemtimer_s_field(2) => '0',
      systemtimer_s_field(1) => '0',
      systemtimer_s_field(0) => '0',
      tx_code_group(9 downto 0) => NLW_gmii_to_sgmii_core_tx_code_group_UNCONNECTED(9 downto 0),
      txbuferr => txbuferr,
      txchardispmode => txchardispmode,
      txchardispval => txchardispval,
      txcharisk => txcharisk,
      txdata(7 downto 0) => txdata(7 downto 0),
      userclk => CLK,
      userclk2 => CLK
    );
rxrecclkbufmr: unisim.vcomponents.BUFMR
    port map (
      I => I,
      O => rxoutclk_bufmr
    );
rxrecclkbufr: unisim.vcomponents.BUFR
    generic map(
      BUFR_DIVIDE => "BYPASS",
      SIM_DEVICE => "7SERIES"
    )
    port map (
      CE => '1',
      CLR => '0',
      I => rxoutclk_bufmr,
      O => \^o1\
    );
sgmii_logic: entity work.gmii_to_sgmii_gmii_to_sgmii_sgmii_adapt
    port map (
      CLK => CLK,
      D(7) => n_28_gmii_to_sgmii_core,
      D(6) => n_29_gmii_to_sgmii_core,
      D(5) => n_30_gmii_to_sgmii_core,
      D(4) => n_31_gmii_to_sgmii_core,
      D(3) => n_32_gmii_to_sgmii_core,
      D(2) => n_33_gmii_to_sgmii_core,
      D(1) => n_34_gmii_to_sgmii_core,
      D(0) => n_35_gmii_to_sgmii_core,
      I1 => n_36_gmii_to_sgmii_core,
      I2 => n_37_gmii_to_sgmii_core,
      O1 => O2,
      O2 => n_4_sgmii_logic,
      O3 => n_5_sgmii_logic,
      Q(7) => n_15_sgmii_logic,
      Q(6) => n_16_sgmii_logic,
      Q(5) => n_17_sgmii_logic,
      Q(4) => n_18_sgmii_logic,
      Q(3) => n_19_sgmii_logic,
      Q(2) => n_20_sgmii_logic,
      Q(1) => n_21_sgmii_logic,
      Q(0) => n_22_sgmii_logic,
      SR(0) => mgt_tx_reset,
      gmii_rx_dv => gmii_rx_dv,
      gmii_rx_er => gmii_rx_er,
      gmii_rxd(7 downto 0) => gmii_rxd(7 downto 0),
      gmii_tx_en => gmii_tx_en,
      gmii_tx_er => gmii_tx_er,
      gmii_txd(7 downto 0) => gmii_txd(7 downto 0),
      sgmii_clk_f => sgmii_clk_f,
      sgmii_clk_r => sgmii_clk_r,
      speed_is_100 => speed_is_100,
      speed_is_10_100 => speed_is_10_100
    );
sync_block_reset_done: entity work.\gmii_to_sgmii_gmii_to_sgmii_sync_block__parameterized0\
    port map (
      CLK => CLK,
      data_in => data_in_0,
      resetdone => \^resetdone\
    );
transceiver_inst: entity work.\gmii_to_sgmii_gmii_to_sgmii_transceiver__parameterized0\
    port map (
      AR(0) => AR(0),
      CLK => CLK,
      D(0) => txchardispmode,
      I => I,
      I1 => I1,
      I2 => \^o1\,
      I3 => I2,
      I4(0) => txchardispval,
      I5(0) => txcharisk,
      I6(7 downto 0) => txdata(7 downto 0),
      Q(7 downto 0) => rxdata(7 downto 0),
      SR(0) => mgt_tx_reset,
      data_in => data_in,
      data_in_0 => data_in_0,
      encommaalign => encommaalign,
      gt0_qplloutclk_out => gt0_qplloutclk_out,
      gt0_qplloutrefclk_out => gt0_qplloutrefclk_out,
      independent_clock_bufg => independent_clock_bufg,
      powerdown => powerdown,
      reset_in => rxreset,
      rxbufstatus(0) => rxbuferr,
      rxchariscomma(0) => rxchariscomma,
      rxcharisk(0) => rxcharisk,
      rxclkcorcnt(1) => rxclkcorcnt(2),
      rxclkcorcnt(0) => rxclkcorcnt(0),
      rxdisperr(0) => rxdisperr,
      rxn => rxn,
      rxnotintable(0) => rxnotintable,
      rxp => rxp,
      rxrundisp(0) => rxrundisp,
      status_vector(0) => \^status_vector\(1),
      txbuferr => txbuferr,
      txn => txn,
      txoutclk => txoutclk,
      txp => txp
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gmii_to_sgmii_gmii_to_sgmii_support is
  port (
    mmcm_locked_out : out STD_LOGIC;
    userclk2_out : out STD_LOGIC;
    gmii_isolate : out STD_LOGIC;
    an_interrupt : out STD_LOGIC;
    status_vector : out STD_LOGIC_VECTOR ( 15 downto 0 );
    Q : out STD_LOGIC_VECTOR ( 0 to 0 );
    resetdone : out STD_LOGIC;
    rxuserclk2_out : out STD_LOGIC;
    userclk_out : out STD_LOGIC;
    txn : out STD_LOGIC;
    txp : out STD_LOGIC;
    gtrefclk_out : out STD_LOGIC;
    gt0_qplloutclk_out : out STD_LOGIC;
    gt0_qplloutrefclk_out : out STD_LOGIC;
    sgmii_clk_r : out STD_LOGIC;
    sgmii_clk_en : out STD_LOGIC;
    gmii_rxd : out STD_LOGIC_VECTOR ( 7 downto 0 );
    gmii_rx_dv : out STD_LOGIC;
    gmii_rx_er : out STD_LOGIC;
    sgmii_clk_f : out STD_LOGIC;
    reset : in STD_LOGIC;
    speed_is_10_100 : in STD_LOGIC;
    speed_is_100 : in STD_LOGIC;
    signal_detect : in STD_LOGIC;
    an_adv_config_vector : in STD_LOGIC_VECTOR ( 15 downto 0 );
    an_restart_config : in STD_LOGIC;
    configuration_vector : in STD_LOGIC_VECTOR ( 4 downto 0 );
    independent_clock_bufg : in STD_LOGIC;
    rxn : in STD_LOGIC;
    rxp : in STD_LOGIC;
    gtrefclk_p : in STD_LOGIC;
    gtrefclk_n : in STD_LOGIC;
    gmii_txd : in STD_LOGIC_VECTOR ( 7 downto 0 );
    gmii_tx_en : in STD_LOGIC;
    gmii_tx_er : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of gmii_to_sgmii_gmii_to_sgmii_support : entity is "gmii_to_sgmii_support";
end gmii_to_sgmii_gmii_to_sgmii_support;

architecture STRUCTURE of gmii_to_sgmii_gmii_to_sgmii_support is
  signal \^q\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^gt0_qplloutclk_out\ : STD_LOGIC;
  signal \^gt0_qplloutrefclk_out\ : STD_LOGIC;
  signal \^gtrefclk_out\ : STD_LOGIC;
  signal \^mmcm_locked_out\ : STD_LOGIC;
  signal n_0_core_clocking_i : STD_LOGIC;
  signal txoutclk : STD_LOGIC;
  signal \^userclk2_out\ : STD_LOGIC;
  signal \^userclk_out\ : STD_LOGIC;
begin
  Q(0) <= \^q\(0);
  gt0_qplloutclk_out <= \^gt0_qplloutclk_out\;
  gt0_qplloutrefclk_out <= \^gt0_qplloutrefclk_out\;
  gtrefclk_out <= \^gtrefclk_out\;
  mmcm_locked_out <= \^mmcm_locked_out\;
  userclk2_out <= \^userclk2_out\;
  userclk_out <= \^userclk_out\;
core_clocking_i: entity work.gmii_to_sgmii_gmii_to_sgmii_clocking
    port map (
      AS(0) => n_0_core_clocking_i,
      gtrefclk => \^gtrefclk_out\,
      gtrefclk_n => gtrefclk_n,
      gtrefclk_p => gtrefclk_p,
      mmcm_locked => \^mmcm_locked_out\,
      reset => reset,
      txoutclk => txoutclk,
      userclk => \^userclk_out\,
      userclk2 => \^userclk2_out\
    );
core_gt_common_i: entity work.gmii_to_sgmii_gmii_to_sgmii_gt_common
    port map (
      I1 => \^gtrefclk_out\,
      Q(0) => \^q\(0),
      gt0_qplloutclk_out => \^gt0_qplloutclk_out\,
      gt0_qplloutrefclk_out => \^gt0_qplloutrefclk_out\,
      independent_clock_bufg => independent_clock_bufg
    );
core_resets_i: entity work.gmii_to_sgmii_gmii_to_sgmii_resets
    port map (
      AS(0) => n_0_core_clocking_i,
      Q(0) => \^q\(0),
      independent_clock_bufg => independent_clock_bufg
    );
pcs_pma_block_i: entity work.gmii_to_sgmii_gmii_to_sgmii_block
    port map (
      AR(0) => \^q\(0),
      CLK => \^userclk2_out\,
      I1 => \^gtrefclk_out\,
      I2 => \^userclk_out\,
      O1 => rxuserclk2_out,
      O2 => sgmii_clk_en,
      an_adv_config_vector(15 downto 0) => an_adv_config_vector(15 downto 0),
      an_interrupt => an_interrupt,
      an_restart_config => an_restart_config,
      configuration_vector(4 downto 0) => configuration_vector(4 downto 0),
      data_in => \^mmcm_locked_out\,
      gmii_isolate => gmii_isolate,
      gmii_rx_dv => gmii_rx_dv,
      gmii_rx_er => gmii_rx_er,
      gmii_rxd(7 downto 0) => gmii_rxd(7 downto 0),
      gmii_tx_en => gmii_tx_en,
      gmii_tx_er => gmii_tx_er,
      gmii_txd(7 downto 0) => gmii_txd(7 downto 0),
      gt0_qplloutclk_out => \^gt0_qplloutclk_out\,
      gt0_qplloutrefclk_out => \^gt0_qplloutrefclk_out\,
      independent_clock_bufg => independent_clock_bufg,
      resetdone => resetdone,
      rxn => rxn,
      rxp => rxp,
      sgmii_clk_f => sgmii_clk_f,
      sgmii_clk_r => sgmii_clk_r,
      signal_detect => signal_detect,
      speed_is_100 => speed_is_100,
      speed_is_10_100 => speed_is_10_100,
      status_vector(15 downto 0) => status_vector(15 downto 0),
      txn => txn,
      txoutclk => txoutclk,
      txp => txp
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gmii_to_sgmii is
  port (
    gtrefclk_p : in STD_LOGIC;
    gtrefclk_n : in STD_LOGIC;
    gtrefclk_out : out STD_LOGIC;
    txp : out STD_LOGIC;
    txn : out STD_LOGIC;
    rxp : in STD_LOGIC;
    rxn : in STD_LOGIC;
    resetdone : out STD_LOGIC;
    userclk_out : out STD_LOGIC;
    userclk2_out : out STD_LOGIC;
    rxuserclk_out : out STD_LOGIC;
    rxuserclk2_out : out STD_LOGIC;
    pma_reset_out : out STD_LOGIC;
    mmcm_locked_out : out STD_LOGIC;
    independent_clock_bufg : in STD_LOGIC;
    sgmii_clk_r : out STD_LOGIC;
    sgmii_clk_f : out STD_LOGIC;
    sgmii_clk_en : out STD_LOGIC;
    gmii_txd : in STD_LOGIC_VECTOR ( 7 downto 0 );
    gmii_tx_en : in STD_LOGIC;
    gmii_tx_er : in STD_LOGIC;
    gmii_rxd : out STD_LOGIC_VECTOR ( 7 downto 0 );
    gmii_rx_dv : out STD_LOGIC;
    gmii_rx_er : out STD_LOGIC;
    gmii_isolate : out STD_LOGIC;
    configuration_vector : in STD_LOGIC_VECTOR ( 4 downto 0 );
    an_interrupt : out STD_LOGIC;
    an_adv_config_vector : in STD_LOGIC_VECTOR ( 15 downto 0 );
    an_restart_config : in STD_LOGIC;
    speed_is_10_100 : in STD_LOGIC;
    speed_is_100 : in STD_LOGIC;
    status_vector : out STD_LOGIC_VECTOR ( 15 downto 0 );
    reset : in STD_LOGIC;
    signal_detect : in STD_LOGIC;
    gt0_qplloutclk_out : out STD_LOGIC;
    gt0_qplloutrefclk_out : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of gmii_to_sgmii : entity is true;
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of gmii_to_sgmii : entity is "yes";
  attribute core_generation_info : string;
  attribute core_generation_info of gmii_to_sgmii : entity is "gmii_to_sgmii,gig_ethernet_pcs_pma_v14_3,{x_ipProduct=Vivado 2014.4,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=gig_ethernet_pcs_pma,x_ipVersion=14.3,x_ipCoreRevision=1,x_ipLanguage=VHDL,x_ipSimLanguage=MIXED,c_elaboration_transient_dir=.,c_component_name=gmii_to_sgmii,c_family=virtex7,c_is_sgmii=true,c_use_transceiver=true,c_use_tbi=false,c_use_lvds=false,c_has_an=true,c_has_mdio=false,c_has_ext_mdio=false,c_sgmii_phy_mode=false,c_dynamic_switching=false,c_transceiver_mode=A,c_sgmii_fabric_buffer=true,c_1588=0,gt_rx_byte_width=1,C_EMAC_IF_TEMAC=true,C_PHYADDR=1,EXAMPLE_SIMULATION=0,c_support_level=true,c_sub_core_name=gmii_to_sgmii_gt,c_transceivercontrol=false,c_xdevicefamily=xc7vx690t,c_gt_dmonitorout_width=15}";
  attribute x_core_info : string;
  attribute x_core_info of gmii_to_sgmii : entity is "gig_ethernet_pcs_pma_v14_3,Vivado 2014.4";
end gmii_to_sgmii;

architecture STRUCTURE of gmii_to_sgmii is
  signal \^rxuserclk_out\ : STD_LOGIC;
begin
  rxuserclk2_out <= \^rxuserclk_out\;
  rxuserclk_out <= \^rxuserclk_out\;
U0: entity work.gmii_to_sgmii_gmii_to_sgmii_support
    port map (
      Q(0) => pma_reset_out,
      an_adv_config_vector(15 downto 0) => an_adv_config_vector(15 downto 0),
      an_interrupt => an_interrupt,
      an_restart_config => an_restart_config,
      configuration_vector(4 downto 0) => configuration_vector(4 downto 0),
      gmii_isolate => gmii_isolate,
      gmii_rx_dv => gmii_rx_dv,
      gmii_rx_er => gmii_rx_er,
      gmii_rxd(7 downto 0) => gmii_rxd(7 downto 0),
      gmii_tx_en => gmii_tx_en,
      gmii_tx_er => gmii_tx_er,
      gmii_txd(7 downto 0) => gmii_txd(7 downto 0),
      gt0_qplloutclk_out => gt0_qplloutclk_out,
      gt0_qplloutrefclk_out => gt0_qplloutrefclk_out,
      gtrefclk_n => gtrefclk_n,
      gtrefclk_out => gtrefclk_out,
      gtrefclk_p => gtrefclk_p,
      independent_clock_bufg => independent_clock_bufg,
      mmcm_locked_out => mmcm_locked_out,
      reset => reset,
      resetdone => resetdone,
      rxn => rxn,
      rxp => rxp,
      rxuserclk2_out => \^rxuserclk_out\,
      sgmii_clk_en => sgmii_clk_en,
      sgmii_clk_f => sgmii_clk_f,
      sgmii_clk_r => sgmii_clk_r,
      signal_detect => signal_detect,
      speed_is_100 => speed_is_100,
      speed_is_10_100 => speed_is_10_100,
      status_vector(15 downto 0) => status_vector(15 downto 0),
      txn => txn,
      txp => txp,
      userclk2_out => userclk2_out,
      userclk_out => userclk_out
    );
end STRUCTURE;
