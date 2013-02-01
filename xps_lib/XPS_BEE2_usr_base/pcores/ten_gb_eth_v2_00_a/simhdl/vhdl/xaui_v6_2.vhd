--------------------------------------------------------------------------------
-- Copyright (c) 1995-2006 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor: Xilinx
-- \   \   \/     Version: I.32
--  \   \         Application: netgen
--  /   /         Filename: xaui_v6_2.vhd
-- /___/   /\     Timestamp: Thu Jul 27 06:38:45 2006
-- \   \  /  \ 
--  \___\/\___\
--             
-- Command	: -intstyle ise -w -sim -ofmt vhdl /home/droz/10GbE/ten_Gb_eth/tmp/_cg/xaui_v6_2.ngc /home/droz/10GbE/ten_Gb_eth/tmp/_cg/xaui_v6_2.vhd 
-- Device	: 2vp70ff1704-7
-- Input file	: /home/droz/10GbE/ten_Gb_eth/tmp/_cg/xaui_v6_2.ngc
-- Output file	: /home/droz/10GbE/ten_Gb_eth/tmp/_cg/xaui_v6_2.vhd
-- # of Entities	: 1
-- Design Name	: xaui_v6_2
-- Xilinx	: /opt/Xilinx82
--             
-- Purpose:    
--     This VHDL netlist is a verification model and uses simulation 
--     primitives which may not represent the true implementation of the 
--     device, however the netlist is functionally correct and should not 
--     be modified. This file cannot be synthesized and should only be used 
--     with supported simulation tools.
--             
-- Reference:  
--     Development System Reference Guide, Chapter 23
--     Synthesis and Simulation Design Guide, Chapter 6
--             
--------------------------------------------------------------------------------


-- The synopsys directives "translate_off/translate_on" specified
-- below are supported by XST, FPGA Compiler II, Mentor Graphics and Synplicity
-- synthesis tools. Ensure they are correct for your synthesis tool(s).

-- synopsys translate_off
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
use UNISIM.VPKG.ALL;

entity xaui_v6_2 is
  port (
    reset : in STD_LOGIC := 'X'; 
    mgt_enchansync : out STD_LOGIC; 
    mgt_powerdown : out STD_LOGIC; 
    usrclk : in STD_LOGIC := 'X'; 
    mgt_loopback : out STD_LOGIC; 
    align_status : out STD_LOGIC; 
    mgt_rxdata : in STD_LOGIC_VECTOR ( 63 downto 0 ); 
    mgt_txcharisk : out STD_LOGIC_VECTOR ( 7 downto 0 ); 
    sync_status : out STD_LOGIC_VECTOR ( 3 downto 0 ); 
    mgt_rxcharisk : in STD_LOGIC_VECTOR ( 7 downto 0 ); 
    mgt_txdata : out STD_LOGIC_VECTOR ( 63 downto 0 ); 
    mgt_enable_align : out STD_LOGIC_VECTOR ( 3 downto 0 ); 
    xgmii_rxc : out STD_LOGIC_VECTOR ( 7 downto 0 ); 
    xgmii_rxd : out STD_LOGIC_VECTOR ( 63 downto 0 ); 
    signal_detect : in STD_LOGIC_VECTOR ( 3 downto 0 ); 
    configuration_vector : in STD_LOGIC_VECTOR ( 6 downto 0 ); 
    mgt_syncok : in STD_LOGIC_VECTOR ( 3 downto 0 ); 
    mgt_codecomma : in STD_LOGIC_VECTOR ( 7 downto 0 ); 
    mgt_rx_reset : in STD_LOGIC_VECTOR ( 3 downto 0 ); 
    status_vector : out STD_LOGIC_VECTOR ( 7 downto 0 ); 
    mgt_codevalid : in STD_LOGIC_VECTOR ( 7 downto 0 ); 
    mgt_tx_reset : in STD_LOGIC_VECTOR ( 3 downto 0 ); 
    xgmii_txc : in STD_LOGIC_VECTOR ( 7 downto 0 ); 
    xgmii_txd : in STD_LOGIC_VECTOR ( 63 downto 0 ) 
  );
end xaui_v6_2;

architecture STRUCTURE of xaui_v6_2 is
  signal N0 : STD_LOGIC; 
  signal N1 : STD_LOGIC; 
  signal NlwRenamedSig_OI_align_status : STD_LOGIC; 
  signal BU2_N4428 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_N01 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_and0040 : STD_LOGIC; 
  signal BU2_N3300 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_N9 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_N9 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_N9 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_N9 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_mux0008_10_Q : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_mux0008_10_Q : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_mux0008_10_Q : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_mux0008_10_Q : STD_LOGIC; 
  signal BU2_U0_transmitter_tqmsg_capture_1_and0000_map1678 : STD_LOGIC; 
  signal BU2_N5193 : STD_LOGIC; 
  signal BU2_N5192 : STD_LOGIC; 
  signal BU2_N5191 : STD_LOGIC; 
  signal BU2_N5190 : STD_LOGIC; 
  signal BU2_N5189 : STD_LOGIC; 
  signal BU2_N5188 : STD_LOGIC; 
  signal BU2_N5187 : STD_LOGIC; 
  signal BU2_N5186 : STD_LOGIC; 
  signal BU2_N5185 : STD_LOGIC; 
  signal BU2_N5184 : STD_LOGIC; 
  signal BU2_N5183 : STD_LOGIC; 
  signal BU2_N5182 : STD_LOGIC; 
  signal BU2_N5181 : STD_LOGIC; 
  signal BU2_N5180 : STD_LOGIC; 
  signal BU2_N5179 : STD_LOGIC; 
  signal BU2_N5178 : STD_LOGIC; 
  signal BU2_N5177 : STD_LOGIC; 
  signal BU2_N5176 : STD_LOGIC; 
  signal BU2_N5175 : STD_LOGIC; 
  signal BU2_N5174 : STD_LOGIC; 
  signal BU2_N5173 : STD_LOGIC; 
  signal BU2_N5172 : STD_LOGIC; 
  signal BU2_N5171 : STD_LOGIC; 
  signal BU2_N5170 : STD_LOGIC; 
  signal BU2_N5169 : STD_LOGIC; 
  signal BU2_N5168 : STD_LOGIC; 
  signal BU2_N5167 : STD_LOGIC; 
  signal BU2_N5166 : STD_LOGIC; 
  signal BU2_N5165 : STD_LOGIC; 
  signal BU2_N5164 : STD_LOGIC; 
  signal BU2_N5163 : STD_LOGIC; 
  signal BU2_N5162 : STD_LOGIC; 
  signal BU2_N5161 : STD_LOGIC; 
  signal BU2_N5160 : STD_LOGIC; 
  signal BU2_N5159 : STD_LOGIC; 
  signal BU2_N5158 : STD_LOGIC; 
  signal BU2_N5157 : STD_LOGIC; 
  signal BU2_N5156 : STD_LOGIC; 
  signal BU2_N5155 : STD_LOGIC; 
  signal BU2_N5154 : STD_LOGIC; 
  signal BU2_N5153 : STD_LOGIC; 
  signal BU2_N5152 : STD_LOGIC; 
  signal BU2_N5151 : STD_LOGIC; 
  signal BU2_N5150 : STD_LOGIC; 
  signal BU2_N5149 : STD_LOGIC; 
  signal BU2_N5148 : STD_LOGIC; 
  signal BU2_N5147 : STD_LOGIC; 
  signal BU2_N5146 : STD_LOGIC; 
  signal BU2_N5145 : STD_LOGIC; 
  signal BU2_N5144 : STD_LOGIC; 
  signal BU2_N5143 : STD_LOGIC; 
  signal BU2_N5142 : STD_LOGIC; 
  signal BU2_N5141 : STD_LOGIC; 
  signal BU2_N5140 : STD_LOGIC; 
  signal BU2_N5139 : STD_LOGIC; 
  signal BU2_N5138 : STD_LOGIC; 
  signal BU2_N5137 : STD_LOGIC; 
  signal BU2_N5136 : STD_LOGIC; 
  signal BU2_N5135 : STD_LOGIC; 
  signal BU2_N5134 : STD_LOGIC; 
  signal BU2_N5133 : STD_LOGIC; 
  signal BU2_N5132 : STD_LOGIC; 
  signal BU2_N5131 : STD_LOGIC; 
  signal BU2_N5130 : STD_LOGIC; 
  signal BU2_N5129 : STD_LOGIC; 
  signal BU2_N5128 : STD_LOGIC; 
  signal BU2_N4488 : STD_LOGIC; 
  signal BU2_N5115 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0031_map2652 : STD_LOGIC; 
  signal BU2_N5104 : STD_LOGIC; 
  signal BU2_N5094 : STD_LOGIC; 
  signal BU2_N5093 : STD_LOGIC; 
  signal BU2_N5091 : STD_LOGIC; 
  signal BU2_N5090 : STD_LOGIC; 
  signal BU2_N5089 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_mux00341_map1447 : STD_LOGIC; 
  signal BU2_N5088 : STD_LOGIC; 
  signal BU2_N5087 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_mux00351_map1436 : STD_LOGIC; 
  signal BU2_N5086 : STD_LOGIC; 
  signal BU2_N5085 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_and0062_map1425 : STD_LOGIC; 
  signal BU2_N5084 : STD_LOGIC; 
  signal BU2_N5083 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_and0060_map1416 : STD_LOGIC; 
  signal BU2_N5082 : STD_LOGIC; 
  signal BU2_N5081 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_and0058_map1407 : STD_LOGIC; 
  signal BU2_N5080 : STD_LOGIC; 
  signal BU2_N5079 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_and0059_map1398 : STD_LOGIC; 
  signal BU2_N5078 : STD_LOGIC; 
  signal BU2_N5077 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_and0057_map1389 : STD_LOGIC; 
  signal BU2_N5076 : STD_LOGIC; 
  signal BU2_N5075 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_and0056_map1380 : STD_LOGIC; 
  signal BU2_N5074 : STD_LOGIC; 
  signal BU2_N5073 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_and0055_map1371 : STD_LOGIC; 
  signal BU2_N5072 : STD_LOGIC; 
  signal BU2_N5071 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_and0054_map1362 : STD_LOGIC; 
  signal BU2_N5070 : STD_LOGIC; 
  signal BU2_N5068 : STD_LOGIC; 
  signal BU2_N5069 : STD_LOGIC; 
  signal BU2_N5066 : STD_LOGIC; 
  signal BU2_N5067 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_next_state_1_0_map2901 : STD_LOGIC; 
  signal BU2_N5065 : STD_LOGIC; 
  signal BU2_N5064 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_next_state_1_0_map2850 : STD_LOGIC; 
  signal BU2_N5063 : STD_LOGIC; 
  signal BU2_N5062 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_next_state_1_0_map2799 : STD_LOGIC; 
  signal BU2_N5061 : STD_LOGIC; 
  signal BU2_N5060 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_next_state_1_0_map2748 : STD_LOGIC; 
  signal BU2_N5059 : STD_LOGIC; 
  signal BU2_N5058 : STD_LOGIC; 
  signal BU2_N5057 : STD_LOGIC; 
  signal BU2_N5056 : STD_LOGIC; 
  signal BU2_N5055 : STD_LOGIC; 
  signal BU2_N5054 : STD_LOGIC; 
  signal BU2_N5053 : STD_LOGIC; 
  signal BU2_N5052 : STD_LOGIC; 
  signal BU2_N5050 : STD_LOGIC; 
  signal BU2_N5048 : STD_LOGIC; 
  signal BU2_N5046 : STD_LOGIC; 
  signal BU2_N5044 : STD_LOGIC; 
  signal BU2_N5042 : STD_LOGIC; 
  signal BU2_N5040 : STD_LOGIC; 
  signal BU2_N5038 : STD_LOGIC; 
  signal BU2_N5036 : STD_LOGIC; 
  signal BU2_N2149 : STD_LOGIC; 
  signal BU2_N2157 : STD_LOGIC; 
  signal BU2_N2155 : STD_LOGIC; 
  signal BU2_N2161 : STD_LOGIC; 
  signal BU2_N2159 : STD_LOGIC; 
  signal BU2_N2147 : STD_LOGIC; 
  signal BU2_N2153 : STD_LOGIC; 
  signal BU2_N2151 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_N7 : STD_LOGIC; 
  signal BU2_N4970 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_N7 : STD_LOGIC; 
  signal BU2_N4968 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_N7 : STD_LOGIC; 
  signal BU2_N4966 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_N7 : STD_LOGIC; 
  signal BU2_N4964 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_N29 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_N28 : STD_LOGIC; 
  signal BU2_N5259 : STD_LOGIC; 
  signal BU2_N2442 : STD_LOGIC; 
  signal BU2_N4545 : STD_LOGIC; 
  signal BU2_N5261 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_mux0044_0_map2171 : STD_LOGIC; 
  signal BU2_N4529 : STD_LOGIC; 
  signal BU2_N4950 : STD_LOGIC; 
  signal BU2_N4535 : STD_LOGIC; 
  signal BU2_N4948 : STD_LOGIC; 
  signal BU2_N4946 : STD_LOGIC; 
  signal BU2_N4531 : STD_LOGIC; 
  signal BU2_N4944 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_mux0044_1_map2694 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_mux0044_1_map2711 : STD_LOGIC; 
  signal BU2_N4943 : STD_LOGIC; 
  signal BU2_N4942 : STD_LOGIC; 
  signal BU2_N4940 : STD_LOGIC; 
  signal BU2_N4938 : STD_LOGIC; 
  signal BU2_N4494 : STD_LOGIC; 
  signal BU2_N4937 : STD_LOGIC; 
  signal BU2_N4936 : STD_LOGIC; 
  signal BU2_N4934 : STD_LOGIC; 
  signal BU2_N4933 : STD_LOGIC; 
  signal BU2_N5207 : STD_LOGIC; 
  signal BU2_N4930 : STD_LOGIC; 
  signal BU2_N4931 : STD_LOGIC; 
  signal BU2_N4928 : STD_LOGIC; 
  signal BU2_N5258 : STD_LOGIC; 
  signal BU2_N4926 : STD_LOGIC; 
  signal BU2_N4924 : STD_LOGIC; 
  signal BU2_N5257 : STD_LOGIC; 
  signal BU2_N4922 : STD_LOGIC; 
  signal BU2_N5256 : STD_LOGIC; 
  signal BU2_N4920 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_next_state_1_3_map2376 : STD_LOGIC; 
  signal BU2_N4916 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_next_state_1_3_map2363 : STD_LOGIC; 
  signal BU2_N4914 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_next_state_1_3_map2350 : STD_LOGIC; 
  signal BU2_N4912 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_next_state_1_3_map2337 : STD_LOGIC; 
  signal BU2_N4910 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_next_state_1_0_map2888 : STD_LOGIC; 
  signal BU2_N4908 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_next_state_1_0_map2837 : STD_LOGIC; 
  signal BU2_N4906 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_next_state_1_0_map2786 : STD_LOGIC; 
  signal BU2_N4904 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_next_state_1_0_map2735 : STD_LOGIC; 
  signal BU2_N4902 : STD_LOGIC; 
  signal BU2_N4900 : STD_LOGIC; 
  signal BU2_U0_usrclk_reset_1_2 : STD_LOGIC; 
  signal BU2_N1564 : STD_LOGIC; 
  signal BU2_N4898 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_mux0044_0_map2209 : STD_LOGIC; 
  signal BU2_N4896 : STD_LOGIC; 
  signal BU2_N4895 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter0_mux00011_map1895 : STD_LOGIC; 
  signal BU2_N4893 : STD_LOGIC; 
  signal BU2_N4892 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter1_mux00011_map1870 : STD_LOGIC; 
  signal BU2_N4890 : STD_LOGIC; 
  signal BU2_N4889 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter2_mux00011_map1845 : STD_LOGIC; 
  signal BU2_N4887 : STD_LOGIC; 
  signal BU2_N4886 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter3_mux00011_map1820 : STD_LOGIC; 
  signal BU2_N4884 : STD_LOGIC; 
  signal BU2_N4883 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter4_mux00011_map1795 : STD_LOGIC; 
  signal BU2_N4881 : STD_LOGIC; 
  signal BU2_N4880 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter5_mux00011_map1770 : STD_LOGIC; 
  signal BU2_N4878 : STD_LOGIC; 
  signal BU2_N4877 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter6_mux00011_map1745 : STD_LOGIC; 
  signal BU2_N4875 : STD_LOGIC; 
  signal BU2_N4874 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter7_mux00011_map1720 : STD_LOGIC; 
  signal BU2_N4872 : STD_LOGIC; 
  signal BU2_N4871 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_mux0044_1_map2724 : STD_LOGIC; 
  signal BU2_N4869 : STD_LOGIC; 
  signal BU2_N4867 : STD_LOGIC; 
  signal BU2_N4851 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_N43 : STD_LOGIC; 
  signal BU2_N4835 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_N46 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_next_state_1_0_map2884 : STD_LOGIC; 
  signal BU2_N5215 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_next_state_1_0_map2833 : STD_LOGIC; 
  signal BU2_N5213 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_next_state_1_0_map2782 : STD_LOGIC; 
  signal BU2_N5211 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_next_state_1_0_map2731 : STD_LOGIC; 
  signal BU2_N5209 : STD_LOGIC; 
  signal BU2_N4817 : STD_LOGIC; 
  signal BU2_N4815 : STD_LOGIC; 
  signal BU2_N4813 : STD_LOGIC; 
  signal BU2_N4811 : STD_LOGIC; 
  signal BU2_N4492 : STD_LOGIC; 
  signal BU2_N4808 : STD_LOGIC; 
  signal BU2_N5267 : STD_LOGIC; 
  signal BU2_N4805 : STD_LOGIC; 
  signal BU2_N4806 : STD_LOGIC; 
  signal BU2_N5262 : STD_LOGIC; 
  signal BU2_N4803 : STD_LOGIC; 
  signal BU2_N5246 : STD_LOGIC; 
  signal BU2_N4802 : STD_LOGIC; 
  signal BU2_N5260 : STD_LOGIC; 
  signal BU2_N4800 : STD_LOGIC; 
  signal BU2_N4799 : STD_LOGIC; 
  signal BU2_N5208 : STD_LOGIC; 
  signal BU2_N2440 : STD_LOGIC; 
  signal BU2_N4797 : STD_LOGIC; 
  signal BU2_N4795 : STD_LOGIC; 
  signal BU2_N4444 : STD_LOGIC; 
  signal BU2_N4440 : STD_LOGIC; 
  signal BU2_N4436 : STD_LOGIC; 
  signal BU2_N4432 : STD_LOGIC; 
  signal BU2_N4777 : STD_LOGIC; 
  signal BU2_N4775 : STD_LOGIC; 
  signal BU2_N4773 : STD_LOGIC; 
  signal BU2_N4771 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_N111 : STD_LOGIC; 
  signal BU2_N4769 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_N111 : STD_LOGIC; 
  signal BU2_N4767 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_N111 : STD_LOGIC; 
  signal BU2_N4765 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_N111 : STD_LOGIC; 
  signal BU2_N4763 : STD_LOGIC; 
  signal BU2_N4761 : STD_LOGIC; 
  signal BU2_N4759 : STD_LOGIC; 
  signal BU2_N4757 : STD_LOGIC; 
  signal BU2_N4755 : STD_LOGIC; 
  signal BU2_N4753 : STD_LOGIC; 
  signal BU2_N4751 : STD_LOGIC; 
  signal BU2_N4749 : STD_LOGIC; 
  signal BU2_N4747 : STD_LOGIC; 
  signal BU2_N4745 : STD_LOGIC; 
  signal BU2_N4519 : STD_LOGIC; 
  signal BU2_N3011 : STD_LOGIC; 
  signal BU2_N4517 : STD_LOGIC; 
  signal BU2_N3009 : STD_LOGIC; 
  signal BU2_N4515 : STD_LOGIC; 
  signal BU2_N3007 : STD_LOGIC; 
  signal BU2_N4513 : STD_LOGIC; 
  signal BU2_N3005 : STD_LOGIC; 
  signal BU2_N4694 : STD_LOGIC; 
  signal BU2_N4695 : STD_LOGIC; 
  signal BU2_N4691 : STD_LOGIC; 
  signal BU2_N4692 : STD_LOGIC; 
  signal BU2_N4689 : STD_LOGIC; 
  signal BU2_N4688 : STD_LOGIC; 
  signal BU2_N4686 : STD_LOGIC; 
  signal BU2_N4685 : STD_LOGIC; 
  signal BU2_N4683 : STD_LOGIC; 
  signal BU2_N5197 : STD_LOGIC; 
  signal BU2_N4682 : STD_LOGIC; 
  signal BU2_N4679 : STD_LOGIC; 
  signal BU2_N4680 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter7_xor0001_map2015 : STD_LOGIC; 
  signal BU2_N4676 : STD_LOGIC; 
  signal BU2_N4677 : STD_LOGIC; 
  signal BU2_N4673 : STD_LOGIC; 
  signal BU2_N4674 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter6_xor0001_map2028 : STD_LOGIC; 
  signal BU2_N4671 : STD_LOGIC; 
  signal BU2_N4670 : STD_LOGIC; 
  signal BU2_N4668 : STD_LOGIC; 
  signal BU2_N4667 : STD_LOGIC; 
  signal BU2_N4665 : STD_LOGIC; 
  signal BU2_N4664 : STD_LOGIC; 
  signal BU2_N4661 : STD_LOGIC; 
  signal BU2_N4662 : STD_LOGIC; 
  signal BU2_N5198 : STD_LOGIC; 
  signal BU2_N4658 : STD_LOGIC; 
  signal BU2_N4659 : STD_LOGIC; 
  signal BU2_N4655 : STD_LOGIC; 
  signal BU2_N4656 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter5_xor0001_map2041 : STD_LOGIC; 
  signal BU2_N4653 : STD_LOGIC; 
  signal BU2_N4652 : STD_LOGIC; 
  signal BU2_N4650 : STD_LOGIC; 
  signal BU2_N4649 : STD_LOGIC; 
  signal BU2_N4647 : STD_LOGIC; 
  signal BU2_N4646 : STD_LOGIC; 
  signal BU2_N4643 : STD_LOGIC; 
  signal BU2_N4644 : STD_LOGIC; 
  signal BU2_N5199 : STD_LOGIC; 
  signal BU2_N4640 : STD_LOGIC; 
  signal BU2_N4641 : STD_LOGIC; 
  signal BU2_N4637 : STD_LOGIC; 
  signal BU2_N4638 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter4_xor0001_map2054 : STD_LOGIC; 
  signal BU2_N4635 : STD_LOGIC; 
  signal BU2_N4634 : STD_LOGIC; 
  signal BU2_N4632 : STD_LOGIC; 
  signal BU2_N4631 : STD_LOGIC; 
  signal BU2_N4629 : STD_LOGIC; 
  signal BU2_N4628 : STD_LOGIC; 
  signal BU2_N4625 : STD_LOGIC; 
  signal BU2_N4626 : STD_LOGIC; 
  signal BU2_N5200 : STD_LOGIC; 
  signal BU2_N4622 : STD_LOGIC; 
  signal BU2_N4623 : STD_LOGIC; 
  signal BU2_N4619 : STD_LOGIC; 
  signal BU2_N4620 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter3_xor0001_map2067 : STD_LOGIC; 
  signal BU2_N4617 : STD_LOGIC; 
  signal BU2_N4616 : STD_LOGIC; 
  signal BU2_N4614 : STD_LOGIC; 
  signal BU2_N4613 : STD_LOGIC; 
  signal BU2_N4611 : STD_LOGIC; 
  signal BU2_N4610 : STD_LOGIC; 
  signal BU2_N4607 : STD_LOGIC; 
  signal BU2_N4608 : STD_LOGIC; 
  signal BU2_N5201 : STD_LOGIC; 
  signal BU2_N4604 : STD_LOGIC; 
  signal BU2_N4605 : STD_LOGIC; 
  signal BU2_N4601 : STD_LOGIC; 
  signal BU2_N4602 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter2_xor0001_map2080 : STD_LOGIC; 
  signal BU2_N4599 : STD_LOGIC; 
  signal BU2_N4598 : STD_LOGIC; 
  signal BU2_N4596 : STD_LOGIC; 
  signal BU2_N4595 : STD_LOGIC; 
  signal BU2_N4593 : STD_LOGIC; 
  signal BU2_N4592 : STD_LOGIC; 
  signal BU2_N4589 : STD_LOGIC; 
  signal BU2_N4590 : STD_LOGIC; 
  signal BU2_N5202 : STD_LOGIC; 
  signal BU2_N4586 : STD_LOGIC; 
  signal BU2_N4587 : STD_LOGIC; 
  signal BU2_N4583 : STD_LOGIC; 
  signal BU2_N4584 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter1_xor0001_map2093 : STD_LOGIC; 
  signal BU2_N4581 : STD_LOGIC; 
  signal BU2_N4580 : STD_LOGIC; 
  signal BU2_N4578 : STD_LOGIC; 
  signal BU2_N4577 : STD_LOGIC; 
  signal BU2_N4575 : STD_LOGIC; 
  signal BU2_N4574 : STD_LOGIC; 
  signal BU2_N4571 : STD_LOGIC; 
  signal BU2_N4572 : STD_LOGIC; 
  signal BU2_N5203 : STD_LOGIC; 
  signal BU2_N4568 : STD_LOGIC; 
  signal BU2_N4569 : STD_LOGIC; 
  signal BU2_N4565 : STD_LOGIC; 
  signal BU2_N4566 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter0_xor0001_map2216 : STD_LOGIC; 
  signal BU2_N4563 : STD_LOGIC; 
  signal BU2_N4562 : STD_LOGIC; 
  signal BU2_N4560 : STD_LOGIC; 
  signal BU2_N4559 : STD_LOGIC; 
  signal BU2_N4557 : STD_LOGIC; 
  signal BU2_N4556 : STD_LOGIC; 
  signal BU2_N4553 : STD_LOGIC; 
  signal BU2_N4554 : STD_LOGIC; 
  signal BU2_N5204 : STD_LOGIC; 
  signal BU2_N4551 : STD_LOGIC; 
  signal BU2_N4170 : STD_LOGIC; 
  signal BU2_N4549 : STD_LOGIC; 
  signal BU2_N4547 : STD_LOGIC; 
  signal BU2_N4543 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0030_map2481 : STD_LOGIC; 
  signal BU2_N4541 : STD_LOGIC; 
  signal BU2_N4539 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_next_state_1_0_map2898 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_next_state_1_0_map2847 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_next_state_1_0_map2796 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_next_state_1_0_map2745 : STD_LOGIC; 
  signal BU2_N4537 : STD_LOGIC; 
  signal BU2_N4533 : STD_LOGIC; 
  signal BU2_N4527 : STD_LOGIC; 
  signal BU2_U0_transmitter_mux0075_map2256 : STD_LOGIC; 
  signal BU2_U0_transmitter_mux0075_map2247 : STD_LOGIC; 
  signal BU2_U0_transmitter_mux0075_map2237 : STD_LOGIC; 
  signal BU2_U0_transmitter_mux0076_map2133 : STD_LOGIC; 
  signal BU2_U0_transmitter_mux0076_map2124 : STD_LOGIC; 
  signal BU2_U0_transmitter_mux0076_map2114 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0030_map2459 : STD_LOGIC; 
  signal BU2_N4525 : STD_LOGIC; 
  signal BU2_N4523 : STD_LOGIC; 
  signal BU2_N4521 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_mux0008_5_Q_3 : STD_LOGIC; 
  signal BU2_N4511 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_N01 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_mux0008_5_Q_4 : STD_LOGIC; 
  signal BU2_N4509 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_N01 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_mux0008_5_Q_5 : STD_LOGIC; 
  signal BU2_N4507 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_N01 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_mux0008_5_Q_6 : STD_LOGIC; 
  signal BU2_N4505 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_N01 : STD_LOGIC; 
  signal BU2_N4413 : STD_LOGIC; 
  signal BU2_N4503 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_mux0008_11_Q : STD_LOGIC; 
  signal BU2_N4411 : STD_LOGIC; 
  signal BU2_N4501 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_mux0008_11_Q : STD_LOGIC; 
  signal BU2_N4409 : STD_LOGIC; 
  signal BU2_N4499 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_mux0008_11_Q : STD_LOGIC; 
  signal BU2_N4407 : STD_LOGIC; 
  signal BU2_N4497 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_mux0008_11_Q : STD_LOGIC; 
  signal BU2_N4495 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_state_1_1_3_7 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_mux0017_1_map3007 : STD_LOGIC; 
  signal BU2_N5250 : STD_LOGIC; 
  signal BU2_N4490 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0031_map2662 : STD_LOGIC; 
  signal BU2_N4486 : STD_LOGIC; 
  signal BU2_N4484 : STD_LOGIC; 
  signal BU2_N5263 : STD_LOGIC; 
  signal BU2_N4482 : STD_LOGIC; 
  signal BU2_N5264 : STD_LOGIC; 
  signal BU2_N4480 : STD_LOGIC; 
  signal BU2_N5265 : STD_LOGIC; 
  signal BU2_N4478 : STD_LOGIC; 
  signal BU2_N5266 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_mux0008_6_Q : STD_LOGIC; 
  signal BU2_N5224 : STD_LOGIC; 
  signal BU2_N5225 : STD_LOGIC; 
  signal BU2_N4474 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_mux0008_6_Q : STD_LOGIC; 
  signal BU2_N5222 : STD_LOGIC; 
  signal BU2_N5223 : STD_LOGIC; 
  signal BU2_N4470 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_mux0008_6_Q : STD_LOGIC; 
  signal BU2_N5220 : STD_LOGIC; 
  signal BU2_N5221 : STD_LOGIC; 
  signal BU2_N4466 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_mux0008_6_Q : STD_LOGIC; 
  signal BU2_N5218 : STD_LOGIC; 
  signal BU2_N5219 : STD_LOGIC; 
  signal BU2_N4462 : STD_LOGIC; 
  signal BU2_N4460 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_next_state_1_0_map2905 : STD_LOGIC; 
  signal BU2_N4458 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_next_state_1_0_map2854 : STD_LOGIC; 
  signal BU2_N4456 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_next_state_1_0_map2803 : STD_LOGIC; 
  signal BU2_N4454 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_next_state_1_0_map2752 : STD_LOGIC; 
  signal BU2_N5235 : STD_LOGIC; 
  signal BU2_N4452 : STD_LOGIC; 
  signal BU2_N5234 : STD_LOGIC; 
  signal BU2_N4450 : STD_LOGIC; 
  signal BU2_N5233 : STD_LOGIC; 
  signal BU2_N4448 : STD_LOGIC; 
  signal BU2_N5232 : STD_LOGIC; 
  signal BU2_N4446 : STD_LOGIC; 
  signal BU2_N4442 : STD_LOGIC; 
  signal BU2_N4438 : STD_LOGIC; 
  signal BU2_N4434 : STD_LOGIC; 
  signal BU2_N4430 : STD_LOGIC; 
  signal BU2_N4426 : STD_LOGIC; 
  signal BU2_N4425 : STD_LOGIC; 
  signal BU2_N4423 : STD_LOGIC; 
  signal BU2_N5247 : STD_LOGIC; 
  signal BU2_N3003 : STD_LOGIC; 
  signal BU2_N3001 : STD_LOGIC; 
  signal BU2_N2999 : STD_LOGIC; 
  signal BU2_N2997 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_state_1_1_1_8 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_state_1_1_1_9 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_state_1_1_1_10 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_state_1_1_1_11 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0026_map2952 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0026_map2937 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_mux0003_0_map3000 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_mux0003_0_map3002 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_next_state_1_0_map2913 : STD_LOGIC; 
  signal BU2_N4388 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_mux0008_16_Q_12 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_next_state_1_0_map2862 : STD_LOGIC; 
  signal BU2_N4386 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_mux0008_16_Q_13 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_next_state_1_0_map2811 : STD_LOGIC; 
  signal BU2_N4384 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_mux0008_16_Q_14 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_next_state_1_0_map2760 : STD_LOGIC; 
  signal BU2_N4382 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_mux0008_16_Q_15 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_N37 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_N47 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_N38 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_N35 : STD_LOGIC; 
  signal BU2_N4390 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_state_0_0_1_16 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_state_0_1_1_17 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_state_1_0_1_18 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_state_1_1_1_19 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0027_map2621 : STD_LOGIC; 
  signal BU2_N4381 : STD_LOGIC; 
  signal BU2_N4380 : STD_LOGIC; 
  signal BU2_N4379 : STD_LOGIC; 
  signal BU2_N4378 : STD_LOGIC; 
  signal BU2_N4377 : STD_LOGIC; 
  signal BU2_N4376 : STD_LOGIC; 
  signal BU2_N4375 : STD_LOGIC; 
  signal BU2_N4374 : STD_LOGIC; 
  signal BU2_N4373 : STD_LOGIC; 
  signal BU2_N4372 : STD_LOGIC; 
  signal BU2_N4371 : STD_LOGIC; 
  signal BU2_N4370 : STD_LOGIC; 
  signal BU2_N4369 : STD_LOGIC; 
  signal BU2_N4368 : STD_LOGIC; 
  signal BU2_N4367 : STD_LOGIC; 
  signal BU2_N4366 : STD_LOGIC; 
  signal BU2_N4365 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_mux0017_0_map2983 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_N2 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_mux0017_0_map2982 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_mux0017_2_map2965 : STD_LOGIC; 
  signal BU2_N5255 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_mux0003_1_map2961 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_mux0003_1_map2957 : STD_LOGIC; 
  signal BU2_N5240 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_mux0003_1_map2954 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0026_map2951 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_N15 : STD_LOGIC; 
  signal BU2_N5241 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_next_state_1_0_map2903 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_next_state_1_0_map2852 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_next_state_1_0_map2801 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_next_state_1_0_map2750 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_mux0044_1_map2701 : STD_LOGIC; 
  signal BU2_N3519 : STD_LOGIC; 
  signal BU2_N3517 : STD_LOGIC; 
  signal BU2_N3515 : STD_LOGIC; 
  signal BU2_N3513 : STD_LOGIC; 
  signal BU2_N3510 : STD_LOGIC; 
  signal BU2_N3511 : STD_LOGIC; 
  signal BU2_N3507 : STD_LOGIC; 
  signal BU2_N3508 : STD_LOGIC; 
  signal BU2_N3504 : STD_LOGIC; 
  signal BU2_N3505 : STD_LOGIC; 
  signal BU2_N3501 : STD_LOGIC; 
  signal BU2_N3502 : STD_LOGIC; 
  signal BU2_N3490 : STD_LOGIC; 
  signal BU2_N3491 : STD_LOGIC; 
  signal BU2_N3485 : STD_LOGIC; 
  signal BU2_N3486 : STD_LOGIC; 
  signal BU2_N3480 : STD_LOGIC; 
  signal BU2_N3481 : STD_LOGIC; 
  signal BU2_N3475 : STD_LOGIC; 
  signal BU2_N3476 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_N13 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_N13 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_N13 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_N13 : STD_LOGIC; 
  signal BU2_U0_transmitter_align_or0002_20 : STD_LOGIC; 
  signal BU2_N3454 : STD_LOGIC; 
  signal BU2_N5231 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0031_map2666 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0031_map2658 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0031_map2644 : STD_LOGIC; 
  signal BU2_N5248 : STD_LOGIC; 
  signal BU2_N5249 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0027_map2639 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_and0020_21 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0027_map2629 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0027_map2638 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_and0040_map2615 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_and0040_map2610 : STD_LOGIC; 
  signal BU2_N5230 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_next_state_1_2_map2603 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_signal_detect_change : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_next_state_1_2_map2597 : STD_LOGIC; 
  signal BU2_N5254 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_next_state_1_2_map2594 : STD_LOGIC; 
  signal BU2_N5216 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_N91 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_next_state_1_2_map2588 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_signal_detect_change : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_next_state_1_2_map2582 : STD_LOGIC; 
  signal BU2_N5253 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_next_state_1_2_map2579 : STD_LOGIC; 
  signal BU2_N5214 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_N91 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_next_state_1_2_map2573 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_signal_detect_change : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_next_state_1_2_map2567 : STD_LOGIC; 
  signal BU2_N5252 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_next_state_1_2_map2564 : STD_LOGIC; 
  signal BU2_N5212 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_N91 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_next_state_1_2_map2558 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_signal_detect_change : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_next_state_1_2_map2552 : STD_LOGIC; 
  signal BU2_N5251 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_next_state_1_2_map2549 : STD_LOGIC; 
  signal BU2_N5210 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_N91 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0398_map2487 : STD_LOGIC; 
  signal BU2_N3014 : STD_LOGIC; 
  signal BU2_N3013 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_state_1_2_1_22 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_state_1_0_2_23 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_state_1_1_2_24 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_N11 : STD_LOGIC; 
  signal BU2_N5217 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0030_map2463 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0030_map2460 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0030_map2479 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0030_map2471 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0030_map2468 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0030_map2446 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_next_state_1_1_map2437 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_next_state_1_1_map2441 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_next_state_1_1_map2434 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_mux0008_3_Q_25 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_next_state_1_1_map2431 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_mux0008_2_Q_26 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_mux0008_1_Q_27 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_next_state_1_1_map2423 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_next_state_1_1_map2427 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_next_state_1_1_map2420 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_mux0008_3_Q_28 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_next_state_1_1_map2417 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_mux0008_2_Q_29 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_mux0008_1_Q_30 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_next_state_1_1_map2409 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_next_state_1_1_map2413 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_next_state_1_1_map2406 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_mux0008_3_Q_31 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_next_state_1_1_map2403 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_mux0008_2_Q_32 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_mux0008_1_Q_33 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_next_state_1_1_map2395 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_next_state_1_1_map2399 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_next_state_1_1_map2392 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_mux0008_3_Q_34 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_next_state_1_1_map2389 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_mux0008_2_Q_35 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_mux0008_1_Q_36 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_next_state_1_3_map2379 : STD_LOGIC; 
  signal BU2_N5229 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_mux0008_14_Q : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_mux0008_13_Q_37 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_next_state_1_3_map2366 : STD_LOGIC; 
  signal BU2_N5228 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_mux0008_14_Q : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_mux0008_13_Q_38 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_next_state_1_3_map2353 : STD_LOGIC; 
  signal BU2_N5227 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_mux0008_14_Q : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_mux0008_13_Q_39 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_next_state_1_3_map2340 : STD_LOGIC; 
  signal BU2_N5226 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_mux0008_14_Q : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_mux0008_13_Q_40 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_mux0008_12_Q : STD_LOGIC; 
  signal BU2_N5239 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_N8 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_mux0008_12_Q : STD_LOGIC; 
  signal BU2_N5238 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_N8 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_mux0008_12_Q : STD_LOGIC; 
  signal BU2_N5237 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_N8 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_mux0008_12_Q : STD_LOGIC; 
  signal BU2_N5236 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_N8 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0029_map2333 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0029_map2327 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0029_map2332 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0029_map2319 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0029_map2314 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0032_map2300 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0032_map2307 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0032_map2293 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0025_map2289 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0025_map2283 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0028_map2271 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0028_map2266 : STD_LOGIC; 
  signal BU2_N5206 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_N16 : STD_LOGIC; 
  signal BU2_N5205 : STD_LOGIC; 
  signal BU2_U0_transmitter_mux0075_map2262 : STD_LOGIC; 
  signal BU2_U0_transmitter_mux0075_map2253 : STD_LOGIC; 
  signal BU2_U0_transmitter_mux0075_map2243 : STD_LOGIC; 
  signal BU2_U0_transmitter_mux0075_map2234 : STD_LOGIC; 
  signal BU2_U0_transmitter_mux0075_map2260 : STD_LOGIC; 
  signal BU2_U0_transmitter_mux0075_map2251 : STD_LOGIC; 
  signal BU2_U0_transmitter_mux0075_map2241 : STD_LOGIC; 
  signal BU2_U0_transmitter_mux0075_map2232 : STD_LOGIC; 
  signal BU2_U0_transmitter_mux0075_map2228 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter0_xor0001_map2223 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_mux0044_0_map2210 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_mux0044_0_map2177 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_mux0044_0_map2208 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_state_1_2_1_41 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_mux0044_0_map2179 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_mux0044_0_map2162 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_mux0044_0_map2147 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_mux0044_0_map2160 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_mux0044_0_map2154 : STD_LOGIC; 
  signal BU2_U0_transmitter_mux0076_map2139 : STD_LOGIC; 
  signal BU2_U0_transmitter_mux0076_map2130 : STD_LOGIC; 
  signal BU2_U0_transmitter_mux0076_map2120 : STD_LOGIC; 
  signal BU2_U0_transmitter_mux0076_map2111 : STD_LOGIC; 
  signal BU2_U0_transmitter_mux0076_map2137 : STD_LOGIC; 
  signal BU2_U0_transmitter_mux0076_map2128 : STD_LOGIC; 
  signal BU2_U0_transmitter_mux0076_map2118 : STD_LOGIC; 
  signal BU2_U0_transmitter_mux0076_map2109 : STD_LOGIC; 
  signal BU2_U0_transmitter_mux0076_map2105 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter1_xor0001_map2100 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter2_xor0001_map2087 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter3_xor0001_map2074 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter4_xor0001_map2061 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter5_xor0001_map2048 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter6_xor0001_map2035 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter7_xor0001_map2022 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_N17 : STD_LOGIC; 
  signal BU2_N5196 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_N18 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_mux0044_2_map1929 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_mux0044_2_map1926 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_mux0044_2_map1921 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_mux0044_2_map1915 : STD_LOGIC; 
  signal BU2_N5245 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_N33 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_N44 : STD_LOGIC; 
  signal BU2_N5242 : STD_LOGIC; 
  signal BU2_N5244 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_N40 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_N41 : STD_LOGIC; 
  signal BU2_N5243 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter0_N01 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter1_N01 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter2_N01 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter3_N01 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter4_N01 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter5_N01 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter6_N01 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter7_N01 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0024 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0020 : STD_LOGIC; 
  signal BU2_U0_transmitter_tqmsg_capture_1_and000043_42 : STD_LOGIC; 
  signal BU2_U0_transmitter_tqmsg_capture_1_or0000_map1706 : STD_LOGIC; 
  signal BU2_U0_transmitter_tqmsg_capture_1_or0000_map1701 : STD_LOGIC; 
  signal BU2_U0_transmitter_tqmsg_capture_1_or0000_map1696 : STD_LOGIC; 
  signal BU2_N5195 : STD_LOGIC; 
  signal BU2_U0_transmitter_tqmsg_capture_1_and0000_map1688 : STD_LOGIC; 
  signal BU2_U0_transmitter_tqmsg_capture_1_and0000_map1683 : STD_LOGIC; 
  signal BU2_N5194 : STD_LOGIC; 
  signal BU2_N944 : STD_LOGIC; 
  signal BU2_U0_transmitter_align_N31 : STD_LOGIC; 
  signal BU2_U0_transmitter_tqmsg_capture_1_and0000 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_N37 : STD_LOGIC; 
  signal BU2_N882 : STD_LOGIC; 
  signal BU2_N880 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_state_1_0_43 : STD_LOGIC; 
  signal BU2_U0_receiver_or0007_map1669 : STD_LOGIC; 
  signal BU2_U0_receiver_or0007_map1668 : STD_LOGIC; 
  signal BU2_U0_receiver_or0007_map1661 : STD_LOGIC; 
  signal BU2_U0_receiver_or0007_map1658 : STD_LOGIC; 
  signal BU2_U0_receiver_or0007_map1652 : STD_LOGIC; 
  signal BU2_U0_receiver_or0006_map1641 : STD_LOGIC; 
  signal BU2_U0_receiver_or0006_map1640 : STD_LOGIC; 
  signal BU2_U0_receiver_or0006_map1633 : STD_LOGIC; 
  signal BU2_U0_receiver_or0006_map1630 : STD_LOGIC; 
  signal BU2_U0_receiver_or0006_map1624 : STD_LOGIC; 
  signal BU2_U0_receiver_or0005_map1613 : STD_LOGIC; 
  signal BU2_U0_receiver_or0005_map1612 : STD_LOGIC; 
  signal BU2_U0_receiver_or0005_map1605 : STD_LOGIC; 
  signal BU2_U0_receiver_or0005_map1602 : STD_LOGIC; 
  signal BU2_U0_receiver_or0005_map1596 : STD_LOGIC; 
  signal BU2_U0_receiver_or0003_map1585 : STD_LOGIC; 
  signal BU2_U0_receiver_or0003_map1584 : STD_LOGIC; 
  signal BU2_U0_receiver_or0003_map1577 : STD_LOGIC; 
  signal BU2_U0_receiver_or0003_map1574 : STD_LOGIC; 
  signal BU2_U0_receiver_or0003_map1568 : STD_LOGIC; 
  signal BU2_U0_receiver_or0004_map1557 : STD_LOGIC; 
  signal BU2_U0_receiver_or0004_map1556 : STD_LOGIC; 
  signal BU2_U0_receiver_or0004_map1549 : STD_LOGIC; 
  signal BU2_U0_receiver_or0004_map1546 : STD_LOGIC; 
  signal BU2_U0_receiver_or0004_map1540 : STD_LOGIC; 
  signal BU2_U0_receiver_or0002_map1529 : STD_LOGIC; 
  signal BU2_U0_receiver_or0002_map1528 : STD_LOGIC; 
  signal BU2_U0_receiver_or0002_map1521 : STD_LOGIC; 
  signal BU2_U0_receiver_or0002_map1518 : STD_LOGIC; 
  signal BU2_U0_receiver_or0002_map1512 : STD_LOGIC; 
  signal BU2_U0_receiver_or0001_map1501 : STD_LOGIC; 
  signal BU2_U0_receiver_or0001_map1491 : STD_LOGIC; 
  signal BU2_U0_receiver_or0001_map1500 : STD_LOGIC; 
  signal BU2_U0_receiver_or0001_map1484 : STD_LOGIC; 
  signal BU2_U0_receiver_or0000_map1473 : STD_LOGIC; 
  signal BU2_U0_receiver_or0000_map1463 : STD_LOGIC; 
  signal BU2_U0_receiver_or0000_map1472 : STD_LOGIC; 
  signal BU2_U0_receiver_or0000_map1456 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_mux0034_map1352 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_mux0035_map1344 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_cmp_eq0015_map1337 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_cmp_eq0015_map1333 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_cmp_eq0014_map1327 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_cmp_eq0014_map1323 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_cmp_eq0013_map1317 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_cmp_eq0013_map1313 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_cmp_eq0010_map1307 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_cmp_eq0010_map1303 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_cmp_eq0011_map1297 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_cmp_eq0011_map1293 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_cmp_eq0009_map1287 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_cmp_eq0009_map1283 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_cmp_eq0009 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_cmp_eq0010 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_cmp_eq0011 : STD_LOGIC; 
  signal BU2_N37 : STD_LOGIC; 
  signal BU2_N379 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_cmp_eq0013 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_cmp_eq0014 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_cmp_eq0015 : STD_LOGIC; 
  signal BU2_N35 : STD_LOGIC; 
  signal BU2_N355 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_xor0003 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_N19 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_state_1_1_44 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_state_1_0_45 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_mux0035 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_and0001_46 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_and0000_47 : STD_LOGIC; 
  signal BU2_U0_receiver_deskew_state_mux0034 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_state_1_4_48 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_state_1_3_49 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_state_1_2_50 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_state_1_1_51 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_state_1_0_52 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_or0000 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state0_signal_detect_last_53 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_state_1_4_54 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_state_1_3_55 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_state_1_2_56 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_state_1_1_57 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_state_1_0_58 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_or0000 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state1_signal_detect_last_59 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_state_1_4_60 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_state_1_3_61 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_state_1_2_62 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_state_1_1_63 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_state_1_0_64 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_or0000 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state2_signal_detect_last_65 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_state_1_4_66 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_state_1_3_67 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_state_1_2_68 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_state_1_1_69 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_state_1_0_70 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_or0000 : STD_LOGIC; 
  signal BU2_U0_receiver_pcs_sync_state3_signal_detect_last_71 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_state_1_2_72 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_next_state_1_2_Q : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_state_1_1_73 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_next_state_1_1_Q : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_state_0_2_74 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_next_state_0_2_Q : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_state_0_1_75 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_next_state_0_1_Q : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_state_0_0_76 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_next_state_0_0_Q : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_next_ifg_is_a_77 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_not0003 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_mux0010_78 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter0_txc_out_79 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter1_txc_out_80 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter2_txc_out_81 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter3_txc_out_82 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter4_txc_out_83 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter5_txc_out_84 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter6_txc_out_85 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter7_txc_out_86 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0463 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0462 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0461 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0460 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0459 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0458 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0456 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0455 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0457 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0453 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0452 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0451_87 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0449 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0447 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0448 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0445 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0444 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0443 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0441_88 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0440 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0438 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0439 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0436 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0435 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0434 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0431 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0429_89 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0430 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0427 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0426 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0425 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0424 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0423_90 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0420 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0419 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0421 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0418 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0416_91 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0415 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0414 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0413 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0410_92 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0412 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0409 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0408 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0406 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0404_93 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0402 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0403 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0400 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0399 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0397 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0396 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0393 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0392_94 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_or0000 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_mux0394 : STD_LOGIC; 
  signal BU2_U0_transmitter_tqmsg_capture_1_q_det_95 : STD_LOGIC; 
  signal BU2_U0_transmitter_clear_q_det : STD_LOGIC; 
  signal BU2_U0_transmitter_tqmsg_capture_1_or0000 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0472 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0018 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0016 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0014 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0496 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0013 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0017 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0004 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0003 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0019 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0002 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0001 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0015 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0023_96 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0011 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0010 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0009 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0022 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0008 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0007 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0006 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0021 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0504 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0502 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0501 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0503 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0500 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0012 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0498 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0499 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0497 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0495 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0494 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0493 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0492 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0491 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0489 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0490 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0488 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0487 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0486 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0485 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0483 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0484 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0482 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0480 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0481 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_or0005 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0479 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0478 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0476 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0477 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0475 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0474 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0473 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0471 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0470 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0468 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0469 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0467 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0466 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0465 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0464 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_and0058 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_and0056 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_and0054 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_and0062 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_and0060 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_and0059 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_and0057 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_and0055 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_mux0463 : STD_LOGIC; 
  signal BU2_U0_receiver_sync_status_97 : STD_LOGIC; 
  signal BU2_U0_receiver_sync_status_int : STD_LOGIC; 
  signal BU2_U0_transmitter_align_xor0000 : STD_LOGIC; 
  signal BU2_U0_transmitter_align_extra_a_98 : STD_LOGIC; 
  signal BU2_U0_transmitter_align_cmp_eq0000 : STD_LOGIC; 
  signal BU2_U0_transmitter_align_or0000 : STD_LOGIC; 
  signal BU2_U0_transmitter_align_not0002 : STD_LOGIC; 
  signal BU2_U0_transmitter_align_not0001 : STD_LOGIC; 
  signal BU2_U0_transmitter_k_r_prbs_i_xor0000 : STD_LOGIC; 
  signal BU2_U0_transmitter_k_r_prbs_i_xor0001 : STD_LOGIC; 
  signal BU2_U0_or0002_99 : STD_LOGIC; 
  signal BU2_U0_type_sel_reg_done_100 : STD_LOGIC; 
  signal BU2_U0_type_sel_reg_done_inv : STD_LOGIC; 
  signal BU2_U0_last_value0_101 : STD_LOGIC; 
  signal BU2_U0_not0000 : STD_LOGIC; 
  signal BU2_U0_last_value_102 : STD_LOGIC; 
  signal BU2_U0_usrclk_reset_2_103 : STD_LOGIC; 
  signal BU2_U0_usrclk_reset_104 : STD_LOGIC; 
  signal BU2_U0_or0001 : STD_LOGIC; 
  signal BU2_U0_usrclk_reset_pipe_105 : STD_LOGIC; 
  signal BU2_U0_reset_inv : STD_LOGIC; 
  signal BU2_U0_clear_local_fault_edge_106 : STD_LOGIC; 
  signal BU2_U0_or0003 : STD_LOGIC; 
  signal BU2_U0_clear_aligned_edge_107 : STD_LOGIC; 
  signal BU2_U0_or0000 : STD_LOGIC; 
  signal BU2_N1 : STD_LOGIC; 
  signal BU2_mdio_tri : STD_LOGIC; 
  signal NlwRenamedSignal_status_vector : STD_LOGIC_VECTOR ( 5 downto 2 ); 
  signal xgmii_rxd_108 : STD_LOGIC_VECTOR ( 63 downto 0 ); 
  signal xgmii_rxc_109 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal mgt_txdata_110 : STD_LOGIC_VECTOR ( 63 downto 0 ); 
  signal mgt_txcharisk_111 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal mgt_enable_align_112 : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal xgmii_txd_113 : STD_LOGIC_VECTOR ( 63 downto 0 ); 
  signal xgmii_txc_114 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal mgt_rxdata_115 : STD_LOGIC_VECTOR ( 63 downto 0 ); 
  signal mgt_rxcharisk_116 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal mgt_codevalid_117 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal mgt_codecomma_118 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal mgt_syncok_119 : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal mgt_tx_reset_120 : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal mgt_rx_reset_121 : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal signal_detect_122 : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal configuration_vector_123 : STD_LOGIC_VECTOR ( 6 downto 2 ); 
  signal NlwRenamedSignal_configuration_vector : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal BU2_U0_receiver_pcs_sync_state0_mux0019 : STD_LOGIC_VECTOR ( 9 downto 7 ); 
  signal BU2_U0_receiver_pcs_sync_state1_mux0019 : STD_LOGIC_VECTOR ( 9 downto 7 ); 
  signal BU2_U0_receiver_pcs_sync_state2_mux0019 : STD_LOGIC_VECTOR ( 9 downto 7 ); 
  signal BU2_U0_receiver_pcs_sync_state3_mux0019 : STD_LOGIC_VECTOR ( 9 downto 7 ); 
  signal BU2_U0_transmitter_a_due : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal BU2_U0_transmitter_is_terminate : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal BU2_U0_transmitter_idle_detect_i0_comp : STD_LOGIC_VECTOR ( 8 downto 0 ); 
  signal BU2_U0_transmitter_idle_detect_i0_muxcyo : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_transmitter_idle_detect_i1_comp : STD_LOGIC_VECTOR ( 8 downto 0 ); 
  signal BU2_U0_transmitter_idle_detect_i1_muxcyo : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_receiver_deskew_state_next_state : STD_LOGIC_VECTOR2 ( 1 downto 1 , 2 downto 0 ); 
  signal BU2_U0_receiver_deskew_state_deskew_error : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal BU2_U0_receiver_deskew_state_got_align : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal BU2_U0_receiver_pcs_sync_state0_next_state : STD_LOGIC_VECTOR2 ( 1 downto 1 , 4 downto 0 ); 
  signal BU2_U0_receiver_pcs_sync_state0_code_valid_pipe : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal BU2_U0_receiver_pcs_sync_state0_code_comma_pipe : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal BU2_U0_receiver_pcs_sync_state1_next_state : STD_LOGIC_VECTOR2 ( 1 downto 1 , 4 downto 0 ); 
  signal BU2_U0_receiver_pcs_sync_state1_code_valid_pipe : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal BU2_U0_receiver_pcs_sync_state1_code_comma_pipe : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal BU2_U0_receiver_pcs_sync_state2_next_state : STD_LOGIC_VECTOR2 ( 1 downto 1 , 4 downto 0 ); 
  signal BU2_U0_receiver_pcs_sync_state2_code_valid_pipe : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal BU2_U0_receiver_pcs_sync_state2_code_comma_pipe : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal BU2_U0_receiver_pcs_sync_state3_next_state : STD_LOGIC_VECTOR2 ( 1 downto 1 , 4 downto 0 ); 
  signal BU2_U0_receiver_pcs_sync_state3_code_valid_pipe : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal BU2_U0_receiver_pcs_sync_state3_code_comma_pipe : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal BU2_U0_transmitter_filter0_txd_out : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_transmitter_filter0_mux0007 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_transmitter_filter1_txd_out : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_transmitter_filter1_mux0007 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_transmitter_filter2_txd_out : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_transmitter_filter2_mux0007 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_transmitter_filter3_txd_out : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_transmitter_filter3_mux0007 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_transmitter_filter4_txd_out : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_transmitter_filter4_mux0007 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_transmitter_filter5_txd_out : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_transmitter_filter5_mux0007 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_transmitter_filter6_txd_out : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_transmitter_filter6_mux0007 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_transmitter_filter7_txd_out : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_transmitter_filter7_mux0007 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_transmitter_tqmsg_capture_1_last_qmsg : STD_LOGIC_VECTOR ( 31 downto 0 ); 
  signal BU2_U0_transmitter_tqmsg_capture_1_mux0002 : STD_LOGIC_VECTOR ( 63 downto 32 ); 
  signal BU2_U0_receiver_recoder_rxd_half_pipe : STD_LOGIC_VECTOR ( 31 downto 0 ); 
  signal BU2_U0_receiver_recoder_rxc_half_pipe : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal BU2_U0_receiver_recoder_code_error_delay : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal BU2_U0_receiver_recoder_lane_term_pipe : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal BU2_U0_receiver_recoder_rxd_pipe : STD_LOGIC_VECTOR ( 63 downto 0 ); 
  signal BU2_U0_receiver_recoder_code_error_pipe : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_receiver_code_error : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_receiver_recoder_error_lane : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_receiver_recoder_rxc_pipe : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_receiver_recoder_lane_terminate : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_receiver_sync_ok_int : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal BU2_U0_transmitter_align_prbs : STD_LOGIC_VECTOR ( 7 downto 1 ); 
  signal BU2_U0_transmitter_align_count : STD_LOGIC_VECTOR ( 4 downto 0 ); 
  signal BU2_U0_transmitter_align_mux0002 : STD_LOGIC_VECTOR ( 4 downto 0 ); 
  signal BU2_U0_transmitter_seq_detect_i0_comp : STD_LOGIC_VECTOR ( 2 downto 0 ); 
  signal BU2_U0_transmitter_seq_detect_i0_muxcyo : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal BU2_U0_transmitter_seq_detect_i1_comp : STD_LOGIC_VECTOR ( 2 downto 0 ); 
  signal BU2_U0_transmitter_seq_detect_i1_muxcyo : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal BU2_U0_transmitter_k_r_prbs_i_prbs : STD_LOGIC_VECTOR ( 8 downto 1 ); 
  signal BU2_U0_transmitter_tx_is_q : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal BU2_U0_transmitter_tx_is_q_comb : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal BU2_U0_transmitter_tx_is_idle : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal BU2_U0_transmitter_tx_is_idle_comb : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal BU2_U0_transmitter_txd_pipe : STD_LOGIC_VECTOR ( 63 downto 0 ); 
  signal BU2_U0_transmitter_txc_pipe : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_signal_detect_int : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal BU2_U0_type_sel_reg : STD_LOGIC_VECTOR ( 1 downto 1 ); 
begin
  mgt_rxdata_115(63) <= mgt_rxdata(63);
  mgt_rxdata_115(62) <= mgt_rxdata(62);
  mgt_rxdata_115(61) <= mgt_rxdata(61);
  mgt_rxdata_115(60) <= mgt_rxdata(60);
  mgt_rxdata_115(59) <= mgt_rxdata(59);
  mgt_rxdata_115(58) <= mgt_rxdata(58);
  mgt_rxdata_115(57) <= mgt_rxdata(57);
  mgt_rxdata_115(56) <= mgt_rxdata(56);
  mgt_rxdata_115(55) <= mgt_rxdata(55);
  mgt_rxdata_115(54) <= mgt_rxdata(54);
  mgt_rxdata_115(53) <= mgt_rxdata(53);
  mgt_rxdata_115(52) <= mgt_rxdata(52);
  mgt_rxdata_115(51) <= mgt_rxdata(51);
  mgt_rxdata_115(50) <= mgt_rxdata(50);
  mgt_rxdata_115(49) <= mgt_rxdata(49);
  mgt_rxdata_115(48) <= mgt_rxdata(48);
  mgt_rxdata_115(47) <= mgt_rxdata(47);
  mgt_rxdata_115(46) <= mgt_rxdata(46);
  mgt_rxdata_115(45) <= mgt_rxdata(45);
  mgt_rxdata_115(44) <= mgt_rxdata(44);
  mgt_rxdata_115(43) <= mgt_rxdata(43);
  mgt_rxdata_115(42) <= mgt_rxdata(42);
  mgt_rxdata_115(41) <= mgt_rxdata(41);
  mgt_rxdata_115(40) <= mgt_rxdata(40);
  mgt_rxdata_115(39) <= mgt_rxdata(39);
  mgt_rxdata_115(38) <= mgt_rxdata(38);
  mgt_rxdata_115(37) <= mgt_rxdata(37);
  mgt_rxdata_115(36) <= mgt_rxdata(36);
  mgt_rxdata_115(35) <= mgt_rxdata(35);
  mgt_rxdata_115(34) <= mgt_rxdata(34);
  mgt_rxdata_115(33) <= mgt_rxdata(33);
  mgt_rxdata_115(32) <= mgt_rxdata(32);
  mgt_rxdata_115(31) <= mgt_rxdata(31);
  mgt_rxdata_115(30) <= mgt_rxdata(30);
  mgt_rxdata_115(29) <= mgt_rxdata(29);
  mgt_rxdata_115(28) <= mgt_rxdata(28);
  mgt_rxdata_115(27) <= mgt_rxdata(27);
  mgt_rxdata_115(26) <= mgt_rxdata(26);
  mgt_rxdata_115(25) <= mgt_rxdata(25);
  mgt_rxdata_115(24) <= mgt_rxdata(24);
  mgt_rxdata_115(23) <= mgt_rxdata(23);
  mgt_rxdata_115(22) <= mgt_rxdata(22);
  mgt_rxdata_115(21) <= mgt_rxdata(21);
  mgt_rxdata_115(20) <= mgt_rxdata(20);
  mgt_rxdata_115(19) <= mgt_rxdata(19);
  mgt_rxdata_115(18) <= mgt_rxdata(18);
  mgt_rxdata_115(17) <= mgt_rxdata(17);
  mgt_rxdata_115(16) <= mgt_rxdata(16);
  mgt_rxdata_115(15) <= mgt_rxdata(15);
  mgt_rxdata_115(14) <= mgt_rxdata(14);
  mgt_rxdata_115(13) <= mgt_rxdata(13);
  mgt_rxdata_115(12) <= mgt_rxdata(12);
  mgt_rxdata_115(11) <= mgt_rxdata(11);
  mgt_rxdata_115(10) <= mgt_rxdata(10);
  mgt_rxdata_115(9) <= mgt_rxdata(9);
  mgt_rxdata_115(8) <= mgt_rxdata(8);
  mgt_rxdata_115(7) <= mgt_rxdata(7);
  mgt_rxdata_115(6) <= mgt_rxdata(6);
  mgt_rxdata_115(5) <= mgt_rxdata(5);
  mgt_rxdata_115(4) <= mgt_rxdata(4);
  mgt_rxdata_115(3) <= mgt_rxdata(3);
  mgt_rxdata_115(2) <= mgt_rxdata(2);
  mgt_rxdata_115(1) <= mgt_rxdata(1);
  mgt_rxdata_115(0) <= mgt_rxdata(0);
  mgt_txcharisk(7) <= mgt_txcharisk_111(7);
  mgt_txcharisk(6) <= mgt_txcharisk_111(6);
  mgt_txcharisk(5) <= mgt_txcharisk_111(5);
  mgt_txcharisk(4) <= mgt_txcharisk_111(4);
  mgt_txcharisk(3) <= mgt_txcharisk_111(3);
  mgt_txcharisk(2) <= mgt_txcharisk_111(2);
  mgt_txcharisk(1) <= mgt_txcharisk_111(1);
  mgt_txcharisk(0) <= mgt_txcharisk_111(0);
  sync_status(3) <= NlwRenamedSignal_status_vector(5);
  sync_status(2) <= NlwRenamedSignal_status_vector(4);
  sync_status(1) <= NlwRenamedSignal_status_vector(3);
  sync_status(0) <= NlwRenamedSignal_status_vector(2);
  mgt_rxcharisk_116(7) <= mgt_rxcharisk(7);
  mgt_rxcharisk_116(6) <= mgt_rxcharisk(6);
  mgt_rxcharisk_116(5) <= mgt_rxcharisk(5);
  mgt_rxcharisk_116(4) <= mgt_rxcharisk(4);
  mgt_rxcharisk_116(3) <= mgt_rxcharisk(3);
  mgt_rxcharisk_116(2) <= mgt_rxcharisk(2);
  mgt_rxcharisk_116(1) <= mgt_rxcharisk(1);
  mgt_rxcharisk_116(0) <= mgt_rxcharisk(0);
  mgt_txdata(63) <= mgt_txdata_110(63);
  mgt_txdata(62) <= mgt_txdata_110(62);
  mgt_txdata(61) <= mgt_txdata_110(61);
  mgt_txdata(60) <= mgt_txdata_110(60);
  mgt_txdata(59) <= mgt_txdata_110(59);
  mgt_txdata(58) <= mgt_txdata_110(58);
  mgt_txdata(57) <= mgt_txdata_110(57);
  mgt_txdata(56) <= mgt_txdata_110(56);
  mgt_txdata(55) <= mgt_txdata_110(55);
  mgt_txdata(54) <= mgt_txdata_110(54);
  mgt_txdata(53) <= mgt_txdata_110(53);
  mgt_txdata(52) <= mgt_txdata_110(52);
  mgt_txdata(51) <= mgt_txdata_110(51);
  mgt_txdata(50) <= mgt_txdata_110(50);
  mgt_txdata(49) <= mgt_txdata_110(49);
  mgt_txdata(48) <= mgt_txdata_110(48);
  mgt_txdata(47) <= mgt_txdata_110(47);
  mgt_txdata(46) <= mgt_txdata_110(46);
  mgt_txdata(45) <= mgt_txdata_110(45);
  mgt_txdata(44) <= mgt_txdata_110(44);
  mgt_txdata(43) <= mgt_txdata_110(43);
  mgt_txdata(42) <= mgt_txdata_110(42);
  mgt_txdata(41) <= mgt_txdata_110(41);
  mgt_txdata(40) <= mgt_txdata_110(40);
  mgt_txdata(39) <= mgt_txdata_110(39);
  mgt_txdata(38) <= mgt_txdata_110(38);
  mgt_txdata(37) <= mgt_txdata_110(37);
  mgt_txdata(36) <= mgt_txdata_110(36);
  mgt_txdata(35) <= mgt_txdata_110(35);
  mgt_txdata(34) <= mgt_txdata_110(34);
  mgt_txdata(33) <= mgt_txdata_110(33);
  mgt_txdata(32) <= mgt_txdata_110(32);
  mgt_txdata(31) <= mgt_txdata_110(31);
  mgt_txdata(30) <= mgt_txdata_110(30);
  mgt_txdata(29) <= mgt_txdata_110(29);
  mgt_txdata(28) <= mgt_txdata_110(28);
  mgt_txdata(27) <= mgt_txdata_110(27);
  mgt_txdata(26) <= mgt_txdata_110(26);
  mgt_txdata(25) <= mgt_txdata_110(25);
  mgt_txdata(24) <= mgt_txdata_110(24);
  mgt_txdata(23) <= mgt_txdata_110(23);
  mgt_txdata(22) <= mgt_txdata_110(22);
  mgt_txdata(21) <= mgt_txdata_110(21);
  mgt_txdata(20) <= mgt_txdata_110(20);
  mgt_txdata(19) <= mgt_txdata_110(19);
  mgt_txdata(18) <= mgt_txdata_110(18);
  mgt_txdata(17) <= mgt_txdata_110(17);
  mgt_txdata(16) <= mgt_txdata_110(16);
  mgt_txdata(15) <= mgt_txdata_110(15);
  mgt_txdata(14) <= mgt_txdata_110(14);
  mgt_txdata(13) <= mgt_txdata_110(13);
  mgt_txdata(12) <= mgt_txdata_110(12);
  mgt_txdata(11) <= mgt_txdata_110(11);
  mgt_txdata(10) <= mgt_txdata_110(10);
  mgt_txdata(9) <= mgt_txdata_110(9);
  mgt_txdata(8) <= mgt_txdata_110(8);
  mgt_txdata(7) <= mgt_txdata_110(7);
  mgt_txdata(6) <= mgt_txdata_110(6);
  mgt_txdata(5) <= mgt_txdata_110(5);
  mgt_txdata(4) <= mgt_txdata_110(4);
  mgt_txdata(3) <= mgt_txdata_110(3);
  mgt_txdata(2) <= mgt_txdata_110(2);
  mgt_txdata(1) <= mgt_txdata_110(1);
  mgt_txdata(0) <= mgt_txdata_110(0);
  mgt_enable_align(3) <= mgt_enable_align_112(3);
  mgt_enable_align(2) <= mgt_enable_align_112(2);
  mgt_enable_align(1) <= mgt_enable_align_112(1);
  mgt_enable_align(0) <= mgt_enable_align_112(0);
  mgt_powerdown <= NlwRenamedSignal_configuration_vector(1);
  xgmii_rxc(7) <= xgmii_rxc_109(7);
  xgmii_rxc(6) <= xgmii_rxc_109(6);
  xgmii_rxc(5) <= xgmii_rxc_109(5);
  xgmii_rxc(4) <= xgmii_rxc_109(4);
  xgmii_rxc(3) <= xgmii_rxc_109(3);
  xgmii_rxc(2) <= xgmii_rxc_109(2);
  xgmii_rxc(1) <= xgmii_rxc_109(1);
  xgmii_rxc(0) <= xgmii_rxc_109(0);
  xgmii_rxd(63) <= xgmii_rxd_108(63);
  xgmii_rxd(62) <= xgmii_rxd_108(62);
  xgmii_rxd(61) <= xgmii_rxd_108(61);
  xgmii_rxd(60) <= xgmii_rxd_108(60);
  xgmii_rxd(59) <= xgmii_rxd_108(59);
  xgmii_rxd(58) <= xgmii_rxd_108(58);
  xgmii_rxd(57) <= xgmii_rxd_108(57);
  xgmii_rxd(56) <= xgmii_rxd_108(56);
  xgmii_rxd(55) <= xgmii_rxd_108(55);
  xgmii_rxd(54) <= xgmii_rxd_108(54);
  xgmii_rxd(53) <= xgmii_rxd_108(53);
  xgmii_rxd(52) <= xgmii_rxd_108(52);
  xgmii_rxd(51) <= xgmii_rxd_108(51);
  xgmii_rxd(50) <= xgmii_rxd_108(50);
  xgmii_rxd(49) <= xgmii_rxd_108(49);
  xgmii_rxd(48) <= xgmii_rxd_108(48);
  xgmii_rxd(47) <= xgmii_rxd_108(47);
  xgmii_rxd(46) <= xgmii_rxd_108(46);
  xgmii_rxd(45) <= xgmii_rxd_108(45);
  xgmii_rxd(44) <= xgmii_rxd_108(44);
  xgmii_rxd(43) <= xgmii_rxd_108(43);
  xgmii_rxd(42) <= xgmii_rxd_108(42);
  xgmii_rxd(41) <= xgmii_rxd_108(41);
  xgmii_rxd(40) <= xgmii_rxd_108(40);
  xgmii_rxd(39) <= xgmii_rxd_108(39);
  xgmii_rxd(38) <= xgmii_rxd_108(38);
  xgmii_rxd(37) <= xgmii_rxd_108(37);
  xgmii_rxd(36) <= xgmii_rxd_108(36);
  xgmii_rxd(35) <= xgmii_rxd_108(35);
  xgmii_rxd(34) <= xgmii_rxd_108(34);
  xgmii_rxd(33) <= xgmii_rxd_108(33);
  xgmii_rxd(32) <= xgmii_rxd_108(32);
  xgmii_rxd(31) <= xgmii_rxd_108(31);
  xgmii_rxd(30) <= xgmii_rxd_108(30);
  xgmii_rxd(29) <= xgmii_rxd_108(29);
  xgmii_rxd(28) <= xgmii_rxd_108(28);
  xgmii_rxd(27) <= xgmii_rxd_108(27);
  xgmii_rxd(26) <= xgmii_rxd_108(26);
  xgmii_rxd(25) <= xgmii_rxd_108(25);
  xgmii_rxd(24) <= xgmii_rxd_108(24);
  xgmii_rxd(23) <= xgmii_rxd_108(23);
  xgmii_rxd(22) <= xgmii_rxd_108(22);
  xgmii_rxd(21) <= xgmii_rxd_108(21);
  xgmii_rxd(20) <= xgmii_rxd_108(20);
  xgmii_rxd(19) <= xgmii_rxd_108(19);
  xgmii_rxd(18) <= xgmii_rxd_108(18);
  xgmii_rxd(17) <= xgmii_rxd_108(17);
  xgmii_rxd(16) <= xgmii_rxd_108(16);
  xgmii_rxd(15) <= xgmii_rxd_108(15);
  xgmii_rxd(14) <= xgmii_rxd_108(14);
  xgmii_rxd(13) <= xgmii_rxd_108(13);
  xgmii_rxd(12) <= xgmii_rxd_108(12);
  xgmii_rxd(11) <= xgmii_rxd_108(11);
  xgmii_rxd(10) <= xgmii_rxd_108(10);
  xgmii_rxd(9) <= xgmii_rxd_108(9);
  xgmii_rxd(8) <= xgmii_rxd_108(8);
  xgmii_rxd(7) <= xgmii_rxd_108(7);
  xgmii_rxd(6) <= xgmii_rxd_108(6);
  xgmii_rxd(5) <= xgmii_rxd_108(5);
  xgmii_rxd(4) <= xgmii_rxd_108(4);
  xgmii_rxd(3) <= xgmii_rxd_108(3);
  xgmii_rxd(2) <= xgmii_rxd_108(2);
  xgmii_rxd(1) <= xgmii_rxd_108(1);
  xgmii_rxd(0) <= xgmii_rxd_108(0);
  signal_detect_122(3) <= signal_detect(3);
  signal_detect_122(2) <= signal_detect(2);
  signal_detect_122(1) <= signal_detect(1);
  signal_detect_122(0) <= signal_detect(0);
  mgt_loopback <= NlwRenamedSignal_configuration_vector(0);
  configuration_vector_123(6) <= configuration_vector(6);
  configuration_vector_123(5) <= configuration_vector(5);
  configuration_vector_123(4) <= configuration_vector(4);
  configuration_vector_123(3) <= configuration_vector(3);
  configuration_vector_123(2) <= configuration_vector(2);
  NlwRenamedSignal_configuration_vector(1) <= configuration_vector(1);
  NlwRenamedSignal_configuration_vector(0) <= configuration_vector(0);
  mgt_syncok_119(3) <= mgt_syncok(3);
  mgt_syncok_119(2) <= mgt_syncok(2);
  mgt_syncok_119(1) <= mgt_syncok(1);
  mgt_syncok_119(0) <= mgt_syncok(0);
  mgt_codecomma_118(7) <= mgt_codecomma(7);
  mgt_codecomma_118(6) <= mgt_codecomma(6);
  mgt_codecomma_118(5) <= mgt_codecomma(5);
  mgt_codecomma_118(4) <= mgt_codecomma(4);
  mgt_codecomma_118(3) <= mgt_codecomma(3);
  mgt_codecomma_118(2) <= mgt_codecomma(2);
  mgt_codecomma_118(1) <= mgt_codecomma(1);
  mgt_codecomma_118(0) <= mgt_codecomma(0);
  mgt_rx_reset_121(3) <= mgt_rx_reset(3);
  mgt_rx_reset_121(2) <= mgt_rx_reset(2);
  mgt_rx_reset_121(1) <= mgt_rx_reset(1);
  mgt_rx_reset_121(0) <= mgt_rx_reset(0);
  align_status <= NlwRenamedSig_OI_align_status;
  status_vector(6) <= NlwRenamedSig_OI_align_status;
  status_vector(5) <= NlwRenamedSignal_status_vector(5);
  status_vector(4) <= NlwRenamedSignal_status_vector(4);
  status_vector(3) <= NlwRenamedSignal_status_vector(3);
  status_vector(2) <= NlwRenamedSignal_status_vector(2);
  mgt_codevalid_117(7) <= mgt_codevalid(7);
  mgt_codevalid_117(6) <= mgt_codevalid(6);
  mgt_codevalid_117(5) <= mgt_codevalid(5);
  mgt_codevalid_117(4) <= mgt_codevalid(4);
  mgt_codevalid_117(3) <= mgt_codevalid(3);
  mgt_codevalid_117(2) <= mgt_codevalid(2);
  mgt_codevalid_117(1) <= mgt_codevalid(1);
  mgt_codevalid_117(0) <= mgt_codevalid(0);
  mgt_tx_reset_120(3) <= mgt_tx_reset(3);
  mgt_tx_reset_120(2) <= mgt_tx_reset(2);
  mgt_tx_reset_120(1) <= mgt_tx_reset(1);
  mgt_tx_reset_120(0) <= mgt_tx_reset(0);
  xgmii_txc_114(7) <= xgmii_txc(7);
  xgmii_txc_114(6) <= xgmii_txc(6);
  xgmii_txc_114(5) <= xgmii_txc(5);
  xgmii_txc_114(4) <= xgmii_txc(4);
  xgmii_txc_114(3) <= xgmii_txc(3);
  xgmii_txc_114(2) <= xgmii_txc(2);
  xgmii_txc_114(1) <= xgmii_txc(1);
  xgmii_txc_114(0) <= xgmii_txc(0);
  xgmii_txd_113(63) <= xgmii_txd(63);
  xgmii_txd_113(62) <= xgmii_txd(62);
  xgmii_txd_113(61) <= xgmii_txd(61);
  xgmii_txd_113(60) <= xgmii_txd(60);
  xgmii_txd_113(59) <= xgmii_txd(59);
  xgmii_txd_113(58) <= xgmii_txd(58);
  xgmii_txd_113(57) <= xgmii_txd(57);
  xgmii_txd_113(56) <= xgmii_txd(56);
  xgmii_txd_113(55) <= xgmii_txd(55);
  xgmii_txd_113(54) <= xgmii_txd(54);
  xgmii_txd_113(53) <= xgmii_txd(53);
  xgmii_txd_113(52) <= xgmii_txd(52);
  xgmii_txd_113(51) <= xgmii_txd(51);
  xgmii_txd_113(50) <= xgmii_txd(50);
  xgmii_txd_113(49) <= xgmii_txd(49);
  xgmii_txd_113(48) <= xgmii_txd(48);
  xgmii_txd_113(47) <= xgmii_txd(47);
  xgmii_txd_113(46) <= xgmii_txd(46);
  xgmii_txd_113(45) <= xgmii_txd(45);
  xgmii_txd_113(44) <= xgmii_txd(44);
  xgmii_txd_113(43) <= xgmii_txd(43);
  xgmii_txd_113(42) <= xgmii_txd(42);
  xgmii_txd_113(41) <= xgmii_txd(41);
  xgmii_txd_113(40) <= xgmii_txd(40);
  xgmii_txd_113(39) <= xgmii_txd(39);
  xgmii_txd_113(38) <= xgmii_txd(38);
  xgmii_txd_113(37) <= xgmii_txd(37);
  xgmii_txd_113(36) <= xgmii_txd(36);
  xgmii_txd_113(35) <= xgmii_txd(35);
  xgmii_txd_113(34) <= xgmii_txd(34);
  xgmii_txd_113(33) <= xgmii_txd(33);
  xgmii_txd_113(32) <= xgmii_txd(32);
  xgmii_txd_113(31) <= xgmii_txd(31);
  xgmii_txd_113(30) <= xgmii_txd(30);
  xgmii_txd_113(29) <= xgmii_txd(29);
  xgmii_txd_113(28) <= xgmii_txd(28);
  xgmii_txd_113(27) <= xgmii_txd(27);
  xgmii_txd_113(26) <= xgmii_txd(26);
  xgmii_txd_113(25) <= xgmii_txd(25);
  xgmii_txd_113(24) <= xgmii_txd(24);
  xgmii_txd_113(23) <= xgmii_txd(23);
  xgmii_txd_113(22) <= xgmii_txd(22);
  xgmii_txd_113(21) <= xgmii_txd(21);
  xgmii_txd_113(20) <= xgmii_txd(20);
  xgmii_txd_113(19) <= xgmii_txd(19);
  xgmii_txd_113(18) <= xgmii_txd(18);
  xgmii_txd_113(17) <= xgmii_txd(17);
  xgmii_txd_113(16) <= xgmii_txd(16);
  xgmii_txd_113(15) <= xgmii_txd(15);
  xgmii_txd_113(14) <= xgmii_txd(14);
  xgmii_txd_113(13) <= xgmii_txd(13);
  xgmii_txd_113(12) <= xgmii_txd(12);
  xgmii_txd_113(11) <= xgmii_txd(11);
  xgmii_txd_113(10) <= xgmii_txd(10);
  xgmii_txd_113(9) <= xgmii_txd(9);
  xgmii_txd_113(8) <= xgmii_txd(8);
  xgmii_txd_113(7) <= xgmii_txd(7);
  xgmii_txd_113(6) <= xgmii_txd(6);
  xgmii_txd_113(5) <= xgmii_txd(5);
  xgmii_txd_113(4) <= xgmii_txd(4);
  xgmii_txd_113(3) <= xgmii_txd(3);
  xgmii_txd_113(2) <= xgmii_txd(2);
  xgmii_txd_113(1) <= xgmii_txd(1);
  xgmii_txd_113(0) <= xgmii_txd(0);
  VCC_0 : VCC
    port map (
      P => N1
    );
  GND_1 : GND
    port map (
      G => N0
    );
  BU2_U0_receiver_deskew_state_mux0034161_INV_0 : INV
    port map (
      I => BU2_U0_receiver_deskew_state_and0000_47,
      O => BU2_N5068
    );
  BU2_U0_receiver_deskew_state_mux0035161_INV_0 : INV
    port map (
      I => BU2_U0_receiver_deskew_state_and0001_46,
      O => BU2_N5066
    );
  BU2_U0_transmitter_tqmsg_capture_1_and000043_1 : LUT3_L
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_and0000_map1678,
      I1 => BU2_U0_transmitter_tqmsg_capture_1_and0000_map1683,
      I2 => BU2_U0_transmitter_tqmsg_capture_1_and0000_map1688,
      LO => BU2_U0_transmitter_tqmsg_capture_1_and000043_42
    );
  BU2_U0_receiver_recoder_or002554_SW2 : LUT3_L
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_delay(0),
      I1 => BU2_U0_receiver_recoder_or0025_map2289,
      I2 => BU2_U0_receiver_recoder_or0025_map2283,
      LO => BU2_N4934
    );
  BU2_U0_receiver_recoder_or002831_SW1 : LUT3_L
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_delay(3),
      I1 => BU2_U0_receiver_recoder_or0028_map2271,
      I2 => BU2_U0_receiver_recoder_or0028_map2266,
      LO => BU2_N4931
    );
  BU2_U0_receiver_deskew_state_mux0044_0_245 : LUT4_L
    generic map(
      INIT => X"FF23"
    )
    port map (
      I0 => BU2_U0_receiver_deskew_state_mux0044_0_map2179,
      I1 => BU2_N4928,
      I2 => BU2_N4867,
      I3 => BU2_U0_receiver_deskew_state_mux0044_0_map2209,
      LO => BU2_U0_receiver_deskew_state_mux0044_0_map2210
    );
  BU2_U0_transmitter_recoder_mux0392211 : LUT3_L
    generic map(
      INIT => X"5D"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_0_76,
      I1 => BU2_U0_transmitter_state_machine_state_0_2_74,
      I2 => BU2_U0_transmitter_state_machine_state_0_1_75,
      LO => BU2_U0_transmitter_recoder_N46
    );
  BU2_U0_transmitter_recoder_mux0416211 : LUT3_L
    generic map(
      INIT => X"5D"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_0_43,
      I1 => BU2_U0_transmitter_state_machine_state_1_2_72,
      I2 => BU2_U0_transmitter_state_machine_state_1_1_73,
      LO => BU2_U0_transmitter_recoder_N43
    );
  BU2_U0_receiver_pcs_sync_state0_next_state_1_0_12_SW0 : LUT4_L
    generic map(
      INIT => X"666F"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_state_1_3_49,
      I1 => BU2_U0_receiver_pcs_sync_state0_state_1_2_50,
      I2 => BU2_U0_receiver_pcs_sync_state0_state_1_1_51,
      I3 => BU2_U0_receiver_pcs_sync_state0_state_1_0_52,
      LO => BU2_N4908
    );
  BU2_U0_receiver_pcs_sync_state1_next_state_1_0_12_SW0 : LUT4_L
    generic map(
      INIT => X"666F"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_state_1_3_55,
      I1 => BU2_U0_receiver_pcs_sync_state1_state_1_2_56,
      I2 => BU2_U0_receiver_pcs_sync_state1_state_1_1_57,
      I3 => BU2_U0_receiver_pcs_sync_state1_state_1_0_58,
      LO => BU2_N4906
    );
  BU2_U0_receiver_pcs_sync_state2_next_state_1_0_12_SW0 : LUT4_L
    generic map(
      INIT => X"666F"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_state_1_3_61,
      I1 => BU2_U0_receiver_pcs_sync_state2_state_1_2_62,
      I2 => BU2_U0_receiver_pcs_sync_state2_state_1_1_63,
      I3 => BU2_U0_receiver_pcs_sync_state2_state_1_0_64,
      LO => BU2_N4904
    );
  BU2_U0_receiver_pcs_sync_state3_next_state_1_0_12_SW0 : LUT4_L
    generic map(
      INIT => X"666F"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_state_1_3_67,
      I1 => BU2_U0_receiver_pcs_sync_state3_state_1_2_68,
      I2 => BU2_U0_receiver_pcs_sync_state3_state_1_1_69,
      I3 => BU2_U0_receiver_pcs_sync_state3_state_1_0_70,
      LO => BU2_N4902
    );
  BU2_U0_receiver_deskew_state_mux0044_0_11 : LUT3_L
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => BU2_U0_receiver_deskew_state_state_1_1_44,
      I1 => BU2_U0_receiver_deskew_state_got_align(0),
      I2 => BU2_N4898,
      LO => BU2_U0_receiver_deskew_state_mux0044_0_map2147
    );
  BU2_U0_transmitter_state_machine_mux0017_0_24_SW0 : LUT2_L
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_next_state_0_2_Q,
      I1 => BU2_U0_transmitter_k_r_prbs_i_prbs(7),
      LO => BU2_N4390
    );
  BU2_U0_receiver_deskew_state_mux0044_0_235_SW1 : LUT4_L
    generic map(
      INIT => X"FFAB"
    )
    port map (
      I0 => BU2_U0_receiver_deskew_state_got_align(0),
      I1 => BU2_U0_receiver_deskew_state_got_align(1),
      I2 => BU2_U0_receiver_deskew_state_deskew_error(1),
      I3 => BU2_U0_receiver_deskew_state_state_1_0_45,
      LO => BU2_N4896
    );
  BU2_U0_receiver_deskew_state_mux0044_1_219_SW0 : LUT4_L
    generic map(
      INIT => X"F717"
    )
    port map (
      I0 => BU2_U0_receiver_deskew_state_got_align(1),
      I1 => BU2_U0_receiver_deskew_state_got_align(0),
      I2 => BU2_U0_receiver_deskew_state_state_1_0_45,
      I3 => BU2_U0_receiver_deskew_state_deskew_error(0),
      LO => BU2_N4869
    );
  BU2_U0_receiver_pcs_sync_state0_mux0018_2_111_SW0_SW0 : LUT3_L
    generic map(
      INIT => X"B6"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_state_1_0_52,
      I1 => BU2_U0_receiver_pcs_sync_state0_code_valid_pipe(0),
      I2 => BU2_U0_receiver_pcs_sync_state0_state_1_3_49,
      LO => BU2_N4817
    );
  BU2_U0_receiver_pcs_sync_state1_mux0018_2_111_SW0_SW0 : LUT3_L
    generic map(
      INIT => X"B6"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_state_1_0_58,
      I1 => BU2_U0_receiver_pcs_sync_state1_code_valid_pipe(0),
      I2 => BU2_U0_receiver_pcs_sync_state1_state_1_3_55,
      LO => BU2_N4815
    );
  BU2_U0_receiver_pcs_sync_state2_mux0018_2_111_SW0_SW0 : LUT3_L
    generic map(
      INIT => X"B6"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_state_1_0_64,
      I1 => BU2_U0_receiver_pcs_sync_state2_code_valid_pipe(0),
      I2 => BU2_U0_receiver_pcs_sync_state2_state_1_3_61,
      LO => BU2_N4813
    );
  BU2_U0_receiver_pcs_sync_state3_mux0018_2_111_SW0_SW0 : LUT3_L
    generic map(
      INIT => X"B6"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_state_1_0_70,
      I1 => BU2_U0_receiver_pcs_sync_state3_code_valid_pipe(0),
      I2 => BU2_U0_receiver_pcs_sync_state3_state_1_3_67,
      LO => BU2_N4811
    );
  BU2_U0_transmitter_align_Mrom_a_cnt_0_1_SW2 : LUT3_D
    generic map(
      INIT => X"EF"
    )
    port map (
      I0 => BU2_U0_transmitter_k_r_prbs_i_prbs(8),
      I1 => BU2_U0_transmitter_state_machine_state_1_1_2_24,
      I2 => BU2_U0_transmitter_state_machine_state_1_2_1_22,
      LO => BU2_N5267,
      O => BU2_N4806
    );
  BU2_U0_receiver_recoder_and0020 : LUT4_L
    generic map(
      INIT => X"0004"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(22),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(23),
      I2 => BU2_N4525,
      I3 => BU2_N4795,
      LO => BU2_U0_receiver_recoder_and0020_21
    );
  BU2_U0_receiver_pcs_sync_state3_mux0008_3_Q : LUT4_D
    generic map(
      INIT => X"0021"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(3),
      I1 => BU2_N4442,
      I2 => BU2_U0_receiver_pcs_sync_state3_signal_detect_last_71,
      I3 => BU2_U0_receiver_sync_ok_int(3),
      LO => BU2_N5266,
      O => BU2_U0_receiver_pcs_sync_state3_mux0008_3_Q_34
    );
  BU2_U0_receiver_pcs_sync_state2_mux0008_3_Q : LUT4_D
    generic map(
      INIT => X"0021"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(2),
      I1 => BU2_N4438,
      I2 => BU2_U0_receiver_pcs_sync_state2_signal_detect_last_65,
      I3 => BU2_U0_receiver_sync_ok_int(2),
      LO => BU2_N5265,
      O => BU2_U0_receiver_pcs_sync_state2_mux0008_3_Q_31
    );
  BU2_U0_receiver_pcs_sync_state1_mux0008_3_Q : LUT4_D
    generic map(
      INIT => X"0021"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(1),
      I1 => BU2_N4434,
      I2 => BU2_U0_receiver_pcs_sync_state1_signal_detect_last_59,
      I3 => BU2_U0_receiver_sync_ok_int(1),
      LO => BU2_N5264,
      O => BU2_U0_receiver_pcs_sync_state1_mux0008_3_Q_28
    );
  BU2_U0_receiver_pcs_sync_state0_mux0008_3_Q : LUT4_D
    generic map(
      INIT => X"0021"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(0),
      I1 => BU2_N4430,
      I2 => BU2_U0_receiver_pcs_sync_state0_signal_detect_last_53,
      I3 => BU2_U0_receiver_sync_ok_int(0),
      LO => BU2_N5263,
      O => BU2_U0_receiver_pcs_sync_state0_mux0008_3_Q_25
    );
  BU2_U0_receiver_pcs_sync_state0_mux0008_1_SW1 : LUT4_L
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_state_1_4_48,
      I1 => BU2_U0_receiver_pcs_sync_state0_state_1_3_49,
      I2 => BU2_U0_receiver_pcs_sync_state0_state_1_2_50,
      I3 => BU2_U0_receiver_pcs_sync_state0_state_1_1_51,
      LO => BU2_N4777
    );
  BU2_U0_receiver_pcs_sync_state1_mux0008_1_SW1 : LUT4_L
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_state_1_4_54,
      I1 => BU2_U0_receiver_pcs_sync_state1_state_1_3_55,
      I2 => BU2_U0_receiver_pcs_sync_state1_state_1_2_56,
      I3 => BU2_U0_receiver_pcs_sync_state1_state_1_1_57,
      LO => BU2_N4775
    );
  BU2_U0_receiver_pcs_sync_state2_mux0008_1_SW1 : LUT4_L
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_state_1_4_60,
      I1 => BU2_U0_receiver_pcs_sync_state2_state_1_3_61,
      I2 => BU2_U0_receiver_pcs_sync_state2_state_1_2_62,
      I3 => BU2_U0_receiver_pcs_sync_state2_state_1_1_63,
      LO => BU2_N4773
    );
  BU2_U0_receiver_pcs_sync_state3_mux0008_1_SW1 : LUT4_L
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_state_1_4_66,
      I1 => BU2_U0_receiver_pcs_sync_state3_state_1_3_67,
      I2 => BU2_U0_receiver_pcs_sync_state3_state_1_2_68,
      I3 => BU2_U0_receiver_pcs_sync_state3_state_1_1_69,
      LO => BU2_N4771
    );
  BU2_U0_receiver_pcs_sync_state0_next_state_1_0_150_SW1_SW0 : LUT3_L
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_code_valid_pipe(0),
      I1 => BU2_U0_receiver_pcs_sync_state0_state_1_1_51,
      I2 => BU2_U0_receiver_pcs_sync_state0_N9,
      LO => BU2_N4761
    );
  BU2_U0_receiver_pcs_sync_state1_next_state_1_0_150_SW1_SW0 : LUT3_L
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_code_valid_pipe(0),
      I1 => BU2_U0_receiver_pcs_sync_state1_state_1_1_57,
      I2 => BU2_U0_receiver_pcs_sync_state1_N9,
      LO => BU2_N4759
    );
  BU2_U0_receiver_pcs_sync_state2_next_state_1_0_150_SW1_SW0 : LUT3_L
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_code_valid_pipe(0),
      I1 => BU2_U0_receiver_pcs_sync_state2_state_1_1_63,
      I2 => BU2_U0_receiver_pcs_sync_state2_N9,
      LO => BU2_N4757
    );
  BU2_U0_receiver_pcs_sync_state3_next_state_1_0_150_SW1_SW0 : LUT3_L
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_code_valid_pipe(0),
      I1 => BU2_U0_receiver_pcs_sync_state3_state_1_1_69,
      I2 => BU2_U0_receiver_pcs_sync_state3_N9,
      LO => BU2_N4755
    );
  BU2_U0_receiver_pcs_sync_state0_next_state_1_3_39_SW0 : LUT4_L
    generic map(
      INIT => X"00AB"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_code_valid_pipe(1),
      I1 => BU2_U0_receiver_pcs_sync_state0_mux0008_12_Q,
      I2 => BU2_U0_receiver_pcs_sync_state0_N111,
      I3 => BU2_U0_receiver_pcs_sync_state0_next_state_1_3_map2376,
      LO => BU2_N4753
    );
  BU2_U0_receiver_pcs_sync_state1_next_state_1_3_39_SW0 : LUT4_L
    generic map(
      INIT => X"00AB"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_code_valid_pipe(1),
      I1 => BU2_U0_receiver_pcs_sync_state1_mux0008_12_Q,
      I2 => BU2_U0_receiver_pcs_sync_state1_N111,
      I3 => BU2_U0_receiver_pcs_sync_state1_next_state_1_3_map2363,
      LO => BU2_N4751
    );
  BU2_U0_receiver_pcs_sync_state2_next_state_1_3_39_SW0 : LUT4_L
    generic map(
      INIT => X"00AB"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_code_valid_pipe(1),
      I1 => BU2_U0_receiver_pcs_sync_state2_mux0008_12_Q,
      I2 => BU2_U0_receiver_pcs_sync_state2_N111,
      I3 => BU2_U0_receiver_pcs_sync_state2_next_state_1_3_map2350,
      LO => BU2_N4749
    );
  BU2_U0_receiver_pcs_sync_state3_next_state_1_3_39_SW0 : LUT4_L
    generic map(
      INIT => X"00AB"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_code_valid_pipe(1),
      I1 => BU2_U0_receiver_pcs_sync_state3_mux0008_12_Q,
      I2 => BU2_U0_receiver_pcs_sync_state3_N111,
      I3 => BU2_U0_receiver_pcs_sync_state3_next_state_1_3_map2337,
      LO => BU2_N4747
    );
  BU2_U0_receiver_recoder_or002727_SW0 : LUT3_L
    generic map(
      INIT => X"BF"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(16),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(19),
      I2 => BU2_U0_receiver_recoder_rxc_pipe(2),
      LO => BU2_N4745
    );
  BU2_U0_transmitter_state_machine_Mrom_mux00111 : LUT3_L
    generic map(
      INIT => X"45"
    )
    port map (
      I0 => BU2_U0_transmitter_k_r_prbs_i_prbs(7),
      I1 => BU2_U0_transmitter_align_not0002,
      I2 => BU2_U0_transmitter_align_or0002_20,
      LO => BU2_U0_transmitter_state_machine_N2
    );
  BU2_U0_transmitter_filter7_xor000132_SW10 : LUT3_L
    generic map(
      INIT => X"15"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(57),
      I1 => BU2_U0_transmitter_txc_pipe(7),
      I2 => BU2_U0_transmitter_filter7_N01,
      LO => BU2_N4694
    );
  BU2_U0_transmitter_filter7_xor000132_SW8 : LUT3_L
    generic map(
      INIT => X"15"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(62),
      I1 => BU2_U0_transmitter_txc_pipe(7),
      I2 => BU2_U0_transmitter_filter7_N01,
      LO => BU2_N4691
    );
  BU2_U0_transmitter_filter7_xor000132_SW7 : LUT4_L
    generic map(
      INIT => X"EEEA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(59),
      I1 => BU2_U0_transmitter_txc_pipe(7),
      I2 => BU2_U0_transmitter_filter7_N01,
      I3 => BU2_U0_transmitter_filter7_xor0001_map2015,
      LO => BU2_N4689
    );
  BU2_U0_transmitter_filter7_xor000132_SW5 : LUT4_L
    generic map(
      INIT => X"EEEA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(61),
      I1 => BU2_U0_transmitter_txc_pipe(7),
      I2 => BU2_U0_transmitter_filter7_N01,
      I3 => BU2_U0_transmitter_filter7_xor0001_map2015,
      LO => BU2_N4686
    );
  BU2_U0_transmitter_filter7_xor000132_SW0 : LUT3_L
    generic map(
      INIT => X"D5"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(56),
      I1 => BU2_U0_transmitter_txc_pipe(7),
      I2 => BU2_U0_transmitter_filter7_N01,
      LO => BU2_N4679
    );
  BU2_U0_transmitter_filter6_xor000132_SW10 : LUT3_L
    generic map(
      INIT => X"15"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(49),
      I1 => BU2_U0_transmitter_txc_pipe(6),
      I2 => BU2_U0_transmitter_filter6_N01,
      LO => BU2_N4676
    );
  BU2_U0_transmitter_filter6_xor000132_SW8 : LUT3_L
    generic map(
      INIT => X"15"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(54),
      I1 => BU2_U0_transmitter_txc_pipe(6),
      I2 => BU2_U0_transmitter_filter6_N01,
      LO => BU2_N4673
    );
  BU2_U0_transmitter_filter6_xor000132_SW7 : LUT4_L
    generic map(
      INIT => X"EEEA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(51),
      I1 => BU2_U0_transmitter_txc_pipe(6),
      I2 => BU2_U0_transmitter_filter6_N01,
      I3 => BU2_U0_transmitter_filter6_xor0001_map2028,
      LO => BU2_N4671
    );
  BU2_U0_transmitter_filter6_xor000132_SW5 : LUT4_L
    generic map(
      INIT => X"EEEA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(55),
      I1 => BU2_U0_transmitter_txc_pipe(6),
      I2 => BU2_U0_transmitter_filter6_N01,
      I3 => BU2_U0_transmitter_filter6_xor0001_map2028,
      LO => BU2_N4668
    );
  BU2_U0_transmitter_filter6_xor000132_SW3 : LUT4_L
    generic map(
      INIT => X"EEEA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(53),
      I1 => BU2_U0_transmitter_txc_pipe(6),
      I2 => BU2_U0_transmitter_filter6_N01,
      I3 => BU2_U0_transmitter_filter6_xor0001_map2028,
      LO => BU2_N4665
    );
  BU2_U0_transmitter_filter6_xor000132_SW0 : LUT3_L
    generic map(
      INIT => X"D5"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(48),
      I1 => BU2_U0_transmitter_txc_pipe(6),
      I2 => BU2_U0_transmitter_filter6_N01,
      LO => BU2_N4661
    );
  BU2_U0_transmitter_filter5_xor000132_SW10 : LUT3_L
    generic map(
      INIT => X"15"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(41),
      I1 => BU2_U0_transmitter_txc_pipe(5),
      I2 => BU2_U0_transmitter_filter5_N01,
      LO => BU2_N4658
    );
  BU2_U0_transmitter_filter5_xor000132_SW8 : LUT3_L
    generic map(
      INIT => X"15"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(46),
      I1 => BU2_U0_transmitter_txc_pipe(5),
      I2 => BU2_U0_transmitter_filter5_N01,
      LO => BU2_N4655
    );
  BU2_U0_transmitter_filter5_xor000132_SW7 : LUT4_L
    generic map(
      INIT => X"EEEA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(43),
      I1 => BU2_U0_transmitter_txc_pipe(5),
      I2 => BU2_U0_transmitter_filter5_N01,
      I3 => BU2_U0_transmitter_filter5_xor0001_map2041,
      LO => BU2_N4653
    );
  BU2_U0_transmitter_filter5_xor000132_SW5 : LUT4_L
    generic map(
      INIT => X"EEEA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(45),
      I1 => BU2_U0_transmitter_txc_pipe(5),
      I2 => BU2_U0_transmitter_filter5_N01,
      I3 => BU2_U0_transmitter_filter5_xor0001_map2041,
      LO => BU2_N4650
    );
  BU2_U0_transmitter_filter5_xor000132_SW3 : LUT4_L
    generic map(
      INIT => X"EEEA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(47),
      I1 => BU2_U0_transmitter_txc_pipe(5),
      I2 => BU2_U0_transmitter_filter5_N01,
      I3 => BU2_U0_transmitter_filter5_xor0001_map2041,
      LO => BU2_N4647
    );
  BU2_U0_transmitter_filter5_xor000132_SW0 : LUT3_L
    generic map(
      INIT => X"D5"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(40),
      I1 => BU2_U0_transmitter_txc_pipe(5),
      I2 => BU2_U0_transmitter_filter5_N01,
      LO => BU2_N4643
    );
  BU2_U0_transmitter_filter4_xor000132_SW10 : LUT3_L
    generic map(
      INIT => X"15"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(33),
      I1 => BU2_U0_transmitter_txc_pipe(4),
      I2 => BU2_U0_transmitter_filter4_N01,
      LO => BU2_N4640
    );
  BU2_U0_transmitter_filter4_xor000132_SW8 : LUT3_L
    generic map(
      INIT => X"15"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(38),
      I1 => BU2_U0_transmitter_txc_pipe(4),
      I2 => BU2_U0_transmitter_filter4_N01,
      LO => BU2_N4637
    );
  BU2_U0_transmitter_filter4_xor000132_SW7 : LUT4_L
    generic map(
      INIT => X"EEEA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(35),
      I1 => BU2_U0_transmitter_txc_pipe(4),
      I2 => BU2_U0_transmitter_filter4_N01,
      I3 => BU2_U0_transmitter_filter4_xor0001_map2054,
      LO => BU2_N4635
    );
  BU2_U0_transmitter_filter4_xor000132_SW5 : LUT4_L
    generic map(
      INIT => X"EEEA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(39),
      I1 => BU2_U0_transmitter_txc_pipe(4),
      I2 => BU2_U0_transmitter_filter4_N01,
      I3 => BU2_U0_transmitter_filter4_xor0001_map2054,
      LO => BU2_N4632
    );
  BU2_U0_transmitter_filter4_xor000132_SW3 : LUT4_L
    generic map(
      INIT => X"EEEA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(37),
      I1 => BU2_U0_transmitter_txc_pipe(4),
      I2 => BU2_U0_transmitter_filter4_N01,
      I3 => BU2_U0_transmitter_filter4_xor0001_map2054,
      LO => BU2_N4629
    );
  BU2_U0_transmitter_filter4_xor000132_SW0 : LUT3_L
    generic map(
      INIT => X"D5"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(32),
      I1 => BU2_U0_transmitter_txc_pipe(4),
      I2 => BU2_U0_transmitter_filter4_N01,
      LO => BU2_N4625
    );
  BU2_U0_transmitter_filter3_xor000132_SW10 : LUT3_L
    generic map(
      INIT => X"15"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(25),
      I1 => BU2_U0_transmitter_txc_pipe(3),
      I2 => BU2_U0_transmitter_filter3_N01,
      LO => BU2_N4622
    );
  BU2_U0_transmitter_filter3_xor000132_SW8 : LUT3_L
    generic map(
      INIT => X"15"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(30),
      I1 => BU2_U0_transmitter_txc_pipe(3),
      I2 => BU2_U0_transmitter_filter3_N01,
      LO => BU2_N4619
    );
  BU2_U0_transmitter_filter3_xor000132_SW7 : LUT4_L
    generic map(
      INIT => X"EEEA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(27),
      I1 => BU2_U0_transmitter_txc_pipe(3),
      I2 => BU2_U0_transmitter_filter3_N01,
      I3 => BU2_U0_transmitter_filter3_xor0001_map2067,
      LO => BU2_N4617
    );
  BU2_U0_transmitter_filter3_xor000132_SW5 : LUT4_L
    generic map(
      INIT => X"EEEA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(29),
      I1 => BU2_U0_transmitter_txc_pipe(3),
      I2 => BU2_U0_transmitter_filter3_N01,
      I3 => BU2_U0_transmitter_filter3_xor0001_map2067,
      LO => BU2_N4614
    );
  BU2_U0_transmitter_filter3_xor000132_SW3 : LUT4_L
    generic map(
      INIT => X"EEEA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(31),
      I1 => BU2_U0_transmitter_txc_pipe(3),
      I2 => BU2_U0_transmitter_filter3_N01,
      I3 => BU2_U0_transmitter_filter3_xor0001_map2067,
      LO => BU2_N4611
    );
  BU2_U0_transmitter_filter3_xor000132_SW0 : LUT3_L
    generic map(
      INIT => X"D5"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(24),
      I1 => BU2_U0_transmitter_txc_pipe(3),
      I2 => BU2_U0_transmitter_filter3_N01,
      LO => BU2_N4607
    );
  BU2_U0_transmitter_filter2_xor000132_SW10 : LUT3_L
    generic map(
      INIT => X"15"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(17),
      I1 => BU2_U0_transmitter_txc_pipe(2),
      I2 => BU2_U0_transmitter_filter2_N01,
      LO => BU2_N4604
    );
  BU2_U0_transmitter_filter2_xor000132_SW8 : LUT3_L
    generic map(
      INIT => X"15"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(22),
      I1 => BU2_U0_transmitter_txc_pipe(2),
      I2 => BU2_U0_transmitter_filter2_N01,
      LO => BU2_N4601
    );
  BU2_U0_transmitter_filter2_xor000132_SW7 : LUT4_L
    generic map(
      INIT => X"EEEA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(19),
      I1 => BU2_U0_transmitter_txc_pipe(2),
      I2 => BU2_U0_transmitter_filter2_N01,
      I3 => BU2_U0_transmitter_filter2_xor0001_map2080,
      LO => BU2_N4599
    );
  BU2_U0_transmitter_filter2_xor000132_SW5 : LUT4_L
    generic map(
      INIT => X"EEEA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(21),
      I1 => BU2_U0_transmitter_txc_pipe(2),
      I2 => BU2_U0_transmitter_filter2_N01,
      I3 => BU2_U0_transmitter_filter2_xor0001_map2080,
      LO => BU2_N4596
    );
  BU2_U0_transmitter_filter2_xor000132_SW3 : LUT4_L
    generic map(
      INIT => X"EEEA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(23),
      I1 => BU2_U0_transmitter_txc_pipe(2),
      I2 => BU2_U0_transmitter_filter2_N01,
      I3 => BU2_U0_transmitter_filter2_xor0001_map2080,
      LO => BU2_N4593
    );
  BU2_U0_transmitter_filter2_xor000132_SW0 : LUT3_L
    generic map(
      INIT => X"D5"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(16),
      I1 => BU2_U0_transmitter_txc_pipe(2),
      I2 => BU2_U0_transmitter_filter2_N01,
      LO => BU2_N4589
    );
  BU2_U0_transmitter_filter1_xor000132_SW10 : LUT3_L
    generic map(
      INIT => X"15"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(9),
      I1 => BU2_U0_transmitter_txc_pipe(1),
      I2 => BU2_U0_transmitter_filter1_N01,
      LO => BU2_N4586
    );
  BU2_U0_transmitter_filter1_xor000132_SW8 : LUT3_L
    generic map(
      INIT => X"15"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(14),
      I1 => BU2_U0_transmitter_txc_pipe(1),
      I2 => BU2_U0_transmitter_filter1_N01,
      LO => BU2_N4583
    );
  BU2_U0_transmitter_filter1_xor000132_SW7 : LUT4_L
    generic map(
      INIT => X"EEEA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(11),
      I1 => BU2_U0_transmitter_txc_pipe(1),
      I2 => BU2_U0_transmitter_filter1_N01,
      I3 => BU2_U0_transmitter_filter1_xor0001_map2093,
      LO => BU2_N4581
    );
  BU2_U0_transmitter_filter1_xor000132_SW5 : LUT4_L
    generic map(
      INIT => X"EEEA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(15),
      I1 => BU2_U0_transmitter_txc_pipe(1),
      I2 => BU2_U0_transmitter_filter1_N01,
      I3 => BU2_U0_transmitter_filter1_xor0001_map2093,
      LO => BU2_N4578
    );
  BU2_U0_transmitter_filter1_xor000132_SW3 : LUT4_L
    generic map(
      INIT => X"EEEA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(13),
      I1 => BU2_U0_transmitter_txc_pipe(1),
      I2 => BU2_U0_transmitter_filter1_N01,
      I3 => BU2_U0_transmitter_filter1_xor0001_map2093,
      LO => BU2_N4575
    );
  BU2_U0_transmitter_filter1_xor000132_SW0 : LUT3_L
    generic map(
      INIT => X"D5"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(8),
      I1 => BU2_U0_transmitter_txc_pipe(1),
      I2 => BU2_U0_transmitter_filter1_N01,
      LO => BU2_N4571
    );
  BU2_U0_transmitter_filter0_xor000132_SW10 : LUT3_L
    generic map(
      INIT => X"15"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(1),
      I1 => BU2_U0_transmitter_txc_pipe(0),
      I2 => BU2_U0_transmitter_filter0_N01,
      LO => BU2_N4568
    );
  BU2_U0_transmitter_filter0_xor000132_SW8 : LUT3_L
    generic map(
      INIT => X"15"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(6),
      I1 => BU2_U0_transmitter_txc_pipe(0),
      I2 => BU2_U0_transmitter_filter0_N01,
      LO => BU2_N4565
    );
  BU2_U0_transmitter_filter0_xor000132_SW7 : LUT4_L
    generic map(
      INIT => X"EEEA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(3),
      I1 => BU2_U0_transmitter_txc_pipe(0),
      I2 => BU2_U0_transmitter_filter0_N01,
      I3 => BU2_U0_transmitter_filter0_xor0001_map2216,
      LO => BU2_N4563
    );
  BU2_U0_transmitter_filter0_xor000132_SW5 : LUT4_L
    generic map(
      INIT => X"EEEA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(5),
      I1 => BU2_U0_transmitter_txc_pipe(0),
      I2 => BU2_U0_transmitter_filter0_N01,
      I3 => BU2_U0_transmitter_filter0_xor0001_map2216,
      LO => BU2_N4560
    );
  BU2_U0_transmitter_filter0_xor000132_SW3 : LUT4_L
    generic map(
      INIT => X"EEEA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(7),
      I1 => BU2_U0_transmitter_txc_pipe(0),
      I2 => BU2_U0_transmitter_filter0_N01,
      I3 => BU2_U0_transmitter_filter0_xor0001_map2216,
      LO => BU2_N4557
    );
  BU2_U0_transmitter_filter0_xor000132_SW0 : LUT3_L
    generic map(
      INIT => X"D5"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(0),
      I1 => BU2_U0_transmitter_txc_pipe(0),
      I2 => BU2_U0_transmitter_filter0_N01,
      LO => BU2_N4553
    );
  BU2_U0_receiver_recoder_or002655 : LUT4_D
    generic map(
      INIT => X"AAA8"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_or0026_map2951,
      I1 => BU2_N4170,
      I2 => BU2_N4423,
      I3 => BU2_N4551,
      LO => BU2_N5262,
      O => BU2_U0_receiver_recoder_or0026_map2952
    );
  BU2_U0_receiver_recoder_or00221_SW1 : LUT4_D
    generic map(
      INIT => X"BF6F"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(15),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(13),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(10),
      I3 => BU2_U0_receiver_recoder_rxd_pipe(14),
      LO => BU2_N5261,
      O => BU2_N4549
    );
  BU2_U0_receiver_recoder_or0031115_SW1 : LUT4_L
    generic map(
      INIT => X"ABAA"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_pipe(2),
      I1 => BU2_N3300,
      I2 => BU2_N1564,
      I3 => BU2_N4547,
      LO => BU2_N4521
    );
  BU2_U0_receiver_recoder_or00241 : LUT4_D
    generic map(
      INIT => X"0008"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(28),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(27),
      I2 => BU2_N4545,
      I3 => BU2_N2442,
      LO => BU2_N5260,
      O => BU2_U0_receiver_recoder_or0024
    );
  BU2_U0_receiver_recoder_and00221_SW1 : LUT4_D
    generic map(
      INIT => X"BF6F"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(31),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(29),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(26),
      I3 => BU2_U0_receiver_recoder_rxd_pipe(30),
      LO => BU2_N5259,
      O => BU2_N4545
    );
  BU2_U0_receiver_recoder_or002554_SW0 : LUT3_L
    generic map(
      INIT => X"FB"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_delay(0),
      I1 => NlwRenamedSig_OI_align_status,
      I2 => BU2_U0_usrclk_reset_2_103,
      LO => BU2_N4543
    );
  BU2_U0_receiver_recoder_or0030141_SW0 : LUT3_L
    generic map(
      INIT => X"FB"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_pipe(1),
      I1 => NlwRenamedSig_OI_align_status,
      I2 => BU2_U0_usrclk_reset_104,
      LO => BU2_N4541
    );
  BU2_U0_receiver_recoder_or00061_SW0 : LUT3_L
    generic map(
      INIT => X"29"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(5),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(7),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(6),
      LO => BU2_N4539
    );
  BU2_U0_receiver_recoder_or003214_SW0 : LUT3_L
    generic map(
      INIT => X"FB"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(56),
      I1 => BU2_U0_receiver_recoder_rxc_pipe(7),
      I2 => BU2_U0_receiver_recoder_code_error_pipe(7),
      LO => BU2_N4537
    );
  BU2_U0_receiver_recoder_or002051_SW0 : LUT3_D
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxc_half_pipe(3),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(28),
      I2 => BU2_U0_receiver_recoder_rxd_half_pipe(27),
      LO => BU2_N5258,
      O => BU2_N4535
    );
  BU2_U0_receiver_recoder_or001848_SW0 : LUT3_D
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxc_half_pipe(1),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(12),
      I2 => BU2_U0_receiver_recoder_rxd_half_pipe(11),
      LO => BU2_N5257,
      O => BU2_N4531
    );
  BU2_U0_receiver_recoder_or001751_SW0 : LUT3_D
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxc_half_pipe(0),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(4),
      I2 => BU2_U0_receiver_recoder_rxd_half_pipe(3),
      LO => BU2_N5256,
      O => BU2_N4529
    );
  BU2_U0_transmitter_align_Mrom_a_cnt_0_1 : LUT4_D
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => BU2_U0_transmitter_align_count(3),
      I1 => BU2_U0_transmitter_align_count(4),
      I2 => BU2_U0_transmitter_align_not0002,
      I3 => BU2_N4527,
      LO => BU2_N5255,
      O => BU2_U0_transmitter_a_due(0)
    );
  BU2_U0_transmitter_mux007517 : LUT4_L
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(18),
      I1 => BU2_U0_transmitter_txd_pipe(19),
      I2 => BU2_U0_transmitter_mux0075_map2228,
      I3 => BU2_U0_transmitter_mux0075_map2232,
      LO => BU2_U0_transmitter_mux0075_map2234
    );
  BU2_U0_transmitter_mux007617 : LUT4_L
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(50),
      I1 => BU2_U0_transmitter_txd_pipe(51),
      I2 => BU2_U0_transmitter_mux0076_map2105,
      I3 => BU2_U0_transmitter_mux0076_map2109,
      LO => BU2_U0_transmitter_mux0076_map2111
    );
  BU2_U0_receiver_pcs_sync_state0_mux0008_10_1 : LUT4_D
    generic map(
      INIT => X"0400"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_state_1_1_51,
      I1 => BU2_U0_receiver_pcs_sync_state0_state_1_0_52,
      I2 => BU2_U0_receiver_pcs_sync_state0_signal_detect_change,
      I3 => BU2_U0_receiver_pcs_sync_state0_N8,
      LO => BU2_N5254,
      O => BU2_U0_receiver_pcs_sync_state0_mux0008_10_Q
    );
  BU2_U0_receiver_pcs_sync_state1_mux0008_10_1 : LUT4_D
    generic map(
      INIT => X"0400"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_state_1_1_57,
      I1 => BU2_U0_receiver_pcs_sync_state1_state_1_0_58,
      I2 => BU2_U0_receiver_pcs_sync_state1_signal_detect_change,
      I3 => BU2_U0_receiver_pcs_sync_state1_N8,
      LO => BU2_N5253,
      O => BU2_U0_receiver_pcs_sync_state1_mux0008_10_Q
    );
  BU2_U0_receiver_pcs_sync_state2_mux0008_10_1 : LUT4_D
    generic map(
      INIT => X"0400"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_state_1_1_63,
      I1 => BU2_U0_receiver_pcs_sync_state2_state_1_0_64,
      I2 => BU2_U0_receiver_pcs_sync_state2_signal_detect_change,
      I3 => BU2_U0_receiver_pcs_sync_state2_N8,
      LO => BU2_N5252,
      O => BU2_U0_receiver_pcs_sync_state2_mux0008_10_Q
    );
  BU2_U0_receiver_pcs_sync_state3_mux0008_10_1 : LUT4_D
    generic map(
      INIT => X"0400"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_state_1_1_69,
      I1 => BU2_U0_receiver_pcs_sync_state3_state_1_0_70,
      I2 => BU2_U0_receiver_pcs_sync_state3_signal_detect_change,
      I3 => BU2_U0_receiver_pcs_sync_state3_N8,
      LO => BU2_N5251,
      O => BU2_U0_receiver_pcs_sync_state3_mux0008_10_Q
    );
  BU2_U0_receiver_pcs_sync_state0_mux0008_5_SW1 : LUT4_L
    generic map(
      INIT => X"FF7D"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_state_1_2_50,
      I1 => BU2_U0_receiver_pcs_sync_state0_state_1_3_49,
      I2 => BU2_U0_receiver_pcs_sync_state0_code_valid_pipe(0),
      I3 => BU2_U0_receiver_pcs_sync_state0_state_1_4_48,
      LO => BU2_N4511
    );
  BU2_U0_receiver_pcs_sync_state1_mux0008_5_SW1 : LUT4_L
    generic map(
      INIT => X"FF7D"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_state_1_2_56,
      I1 => BU2_U0_receiver_pcs_sync_state1_state_1_3_55,
      I2 => BU2_U0_receiver_pcs_sync_state1_code_valid_pipe(0),
      I3 => BU2_U0_receiver_pcs_sync_state1_state_1_4_54,
      LO => BU2_N4509
    );
  BU2_U0_receiver_pcs_sync_state2_mux0008_5_SW1 : LUT4_L
    generic map(
      INIT => X"FF7D"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_state_1_2_62,
      I1 => BU2_U0_receiver_pcs_sync_state2_state_1_3_61,
      I2 => BU2_U0_receiver_pcs_sync_state2_code_valid_pipe(0),
      I3 => BU2_U0_receiver_pcs_sync_state2_state_1_4_60,
      LO => BU2_N4507
    );
  BU2_U0_receiver_pcs_sync_state3_mux0008_5_SW1 : LUT4_L
    generic map(
      INIT => X"FF7D"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_state_1_2_68,
      I1 => BU2_U0_receiver_pcs_sync_state3_state_1_3_67,
      I2 => BU2_U0_receiver_pcs_sync_state3_code_valid_pipe(0),
      I3 => BU2_U0_receiver_pcs_sync_state3_state_1_4_66,
      LO => BU2_N4505
    );
  BU2_U0_transmitter_state_machine_mux0003_0_22 : LUT4_D
    generic map(
      INIT => X"02DF"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_N01,
      I1 => BU2_U0_transmitter_state_machine_state_1_0_43,
      I2 => BU2_N4495,
      I3 => BU2_N4494,
      LO => BU2_N5250,
      O => BU2_U0_transmitter_state_machine_mux0003_0_map3000
    );
  BU2_U0_receiver_recoder_or00279 : LUT4_D
    generic map(
      INIT => X"EEAE"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_delay(2),
      I1 => BU2_U0_receiver_recoder_N18,
      I2 => BU2_U0_receiver_recoder_N17,
      I3 => BU2_N4488,
      LO => BU2_N5249,
      O => BU2_U0_receiver_recoder_or0027_map2621
    );
  BU2_U0_receiver_recoder_or0031115_SW0 : LUT3_L
    generic map(
      INIT => X"FB"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_pipe(2),
      I1 => NlwRenamedSig_OI_align_status,
      I2 => BU2_U0_usrclk_reset_2_103,
      LO => BU2_N4486
    );
  BU2_U0_receiver_pcs_sync_state0_next_state_1_2_27 : LUT4_L
    generic map(
      INIT => X"AAA8"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_code_valid_pipe(1),
      I1 => BU2_U0_receiver_pcs_sync_state0_N111,
      I2 => BU2_U0_receiver_pcs_sync_state0_mux0008_14_Q,
      I3 => BU2_N4484,
      LO => BU2_U0_receiver_pcs_sync_state0_next_state_1_2_map2603
    );
  BU2_U0_receiver_pcs_sync_state1_next_state_1_2_27 : LUT4_L
    generic map(
      INIT => X"AAA8"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_code_valid_pipe(1),
      I1 => BU2_U0_receiver_pcs_sync_state1_N111,
      I2 => BU2_U0_receiver_pcs_sync_state1_mux0008_14_Q,
      I3 => BU2_N4482,
      LO => BU2_U0_receiver_pcs_sync_state1_next_state_1_2_map2588
    );
  BU2_U0_receiver_pcs_sync_state2_next_state_1_2_27 : LUT4_L
    generic map(
      INIT => X"AAA8"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_code_valid_pipe(1),
      I1 => BU2_U0_receiver_pcs_sync_state2_N111,
      I2 => BU2_U0_receiver_pcs_sync_state2_mux0008_14_Q,
      I3 => BU2_N4480,
      LO => BU2_U0_receiver_pcs_sync_state2_next_state_1_2_map2573
    );
  BU2_U0_receiver_pcs_sync_state3_next_state_1_2_27 : LUT4_L
    generic map(
      INIT => X"AAA8"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_code_valid_pipe(1),
      I1 => BU2_U0_receiver_pcs_sync_state3_N111,
      I2 => BU2_U0_receiver_pcs_sync_state3_mux0008_14_Q,
      I3 => BU2_N4478,
      LO => BU2_U0_receiver_pcs_sync_state3_next_state_1_2_map2558
    );
  BU2_U0_receiver_recoder_and004023 : LUT4_D
    generic map(
      INIT => X"4000"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(48),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(53),
      I2 => BU2_U0_receiver_recoder_and0040_map2615,
      I3 => BU2_U0_receiver_recoder_and0040_map2610,
      LO => BU2_N5248,
      O => BU2_U0_receiver_recoder_and0040
    );
  BU2_U0_receiver_pcs_sync_state3_mux0008_3_SW0_SW1 : LUT4_L
    generic map(
      INIT => X"EF7F"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_code_comma_pipe(0),
      I1 => BU2_U0_receiver_pcs_sync_state3_state_1_0_70,
      I2 => BU2_U0_receiver_pcs_sync_state3_code_valid_pipe(0),
      I3 => BU2_U0_receiver_pcs_sync_state3_state_1_1_69,
      LO => BU2_N4444
    );
  BU2_U0_receiver_pcs_sync_state2_mux0008_3_SW0_SW1 : LUT4_L
    generic map(
      INIT => X"EF7F"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_code_comma_pipe(0),
      I1 => BU2_U0_receiver_pcs_sync_state2_state_1_0_64,
      I2 => BU2_U0_receiver_pcs_sync_state2_code_valid_pipe(0),
      I3 => BU2_U0_receiver_pcs_sync_state2_state_1_1_63,
      LO => BU2_N4440
    );
  BU2_U0_receiver_pcs_sync_state1_mux0008_3_SW0_SW1 : LUT4_L
    generic map(
      INIT => X"EF7F"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_code_comma_pipe(0),
      I1 => BU2_U0_receiver_pcs_sync_state1_state_1_0_58,
      I2 => BU2_U0_receiver_pcs_sync_state1_code_valid_pipe(0),
      I3 => BU2_U0_receiver_pcs_sync_state1_state_1_1_57,
      LO => BU2_N4436
    );
  BU2_U0_receiver_pcs_sync_state0_mux0008_3_SW0_SW1 : LUT4_L
    generic map(
      INIT => X"EF7F"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_code_comma_pipe(0),
      I1 => BU2_U0_receiver_pcs_sync_state0_state_1_0_52,
      I2 => BU2_U0_receiver_pcs_sync_state0_code_valid_pipe(0),
      I3 => BU2_U0_receiver_pcs_sync_state0_state_1_1_51,
      LO => BU2_N4432
    );
  BU2_U0_receiver_recoder_or00269 : LUT4_D
    generic map(
      INIT => X"EEAE"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_delay(1),
      I1 => BU2_U0_receiver_recoder_lane_terminate(0),
      I2 => BU2_U0_receiver_recoder_N15,
      I3 => BU2_N4428,
      LO => BU2_N5247,
      O => BU2_U0_receiver_recoder_or0026_map2937
    );
  BU2_U0_receiver_recoder_and00161_SW0 : LUT4_D
    generic map(
      INIT => X"FFBF"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(14),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(15),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(13),
      I3 => BU2_U0_receiver_recoder_code_error_pipe(1),
      LO => BU2_N5246,
      O => BU2_N4428
    );
  BU2_U0_transmitter_state_machine_mux0017_2_29_SW3 : LUT2_L
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_next_state_0_1_Q,
      I1 => BU2_U0_transmitter_state_machine_next_state_0_2_Q,
      LO => BU2_N4426
    );
  BU2_U0_transmitter_recoder_mux0392311 : LUT2_D
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I1 => BU2_U0_transmitter_state_machine_state_0_0_76,
      LO => BU2_N5245,
      O => BU2_U0_transmitter_recoder_N44
    );
  BU2_U0_transmitter_recoder_mux0416311 : LUT2_D
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I1 => BU2_U0_transmitter_state_machine_state_1_0_43,
      LO => BU2_N5244,
      O => BU2_U0_transmitter_recoder_N41
    );
  BU2_U0_receiver_pcs_sync_state0_mux0019_12_1_SW0 : LUT3_L
    generic map(
      INIT => X"F9"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_state_1_2_50,
      I1 => BU2_U0_receiver_pcs_sync_state0_state_1_3_49,
      I2 => BU2_U0_receiver_pcs_sync_state0_state_1_4_48,
      LO => BU2_N3490
    );
  BU2_U0_receiver_pcs_sync_state1_mux0019_12_1_SW0 : LUT3_L
    generic map(
      INIT => X"F9"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_state_1_2_56,
      I1 => BU2_U0_receiver_pcs_sync_state1_state_1_3_55,
      I2 => BU2_U0_receiver_pcs_sync_state1_state_1_4_54,
      LO => BU2_N3485
    );
  BU2_U0_receiver_pcs_sync_state2_mux0019_12_1_SW0 : LUT3_L
    generic map(
      INIT => X"F9"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_state_1_2_62,
      I1 => BU2_U0_receiver_pcs_sync_state2_state_1_3_61,
      I2 => BU2_U0_receiver_pcs_sync_state2_state_1_4_60,
      LO => BU2_N3480
    );
  BU2_U0_receiver_pcs_sync_state3_mux0019_12_1_SW0 : LUT3_L
    generic map(
      INIT => X"F9"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_state_1_2_68,
      I1 => BU2_U0_receiver_pcs_sync_state3_state_1_3_67,
      I2 => BU2_U0_receiver_pcs_sync_state3_state_1_4_66,
      LO => BU2_N3475
    );
  BU2_U0_receiver_pcs_sync_state0_mux0019_7_SW0 : LUT4_L
    generic map(
      INIT => X"DDDB"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_state_1_2_50,
      I1 => BU2_U0_receiver_pcs_sync_state0_state_1_3_49,
      I2 => BU2_U0_receiver_pcs_sync_state0_state_1_1_1_8,
      I3 => BU2_U0_receiver_pcs_sync_state0_state_1_0_52,
      LO => BU2_N3510
    );
  BU2_U0_receiver_pcs_sync_state1_mux0019_7_SW0 : LUT4_L
    generic map(
      INIT => X"DDDB"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_state_1_2_56,
      I1 => BU2_U0_receiver_pcs_sync_state1_state_1_3_55,
      I2 => BU2_U0_receiver_pcs_sync_state1_state_1_1_1_9,
      I3 => BU2_U0_receiver_pcs_sync_state1_state_1_0_58,
      LO => BU2_N3507
    );
  BU2_U0_receiver_pcs_sync_state2_mux0019_7_SW0 : LUT4_L
    generic map(
      INIT => X"DDDB"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_state_1_2_62,
      I1 => BU2_U0_receiver_pcs_sync_state2_state_1_3_61,
      I2 => BU2_U0_receiver_pcs_sync_state2_state_1_1_1_10,
      I3 => BU2_U0_receiver_pcs_sync_state2_state_1_0_64,
      LO => BU2_N3504
    );
  BU2_U0_receiver_pcs_sync_state3_mux0019_7_SW0 : LUT4_L
    generic map(
      INIT => X"DDDB"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_state_1_2_68,
      I1 => BU2_U0_receiver_pcs_sync_state3_state_1_3_67,
      I2 => BU2_U0_receiver_pcs_sync_state3_state_1_1_1_11,
      I3 => BU2_U0_receiver_pcs_sync_state3_state_1_0_70,
      LO => BU2_N3501
    );
  BU2_U0_transmitter_recoder_mux0411111 : LUT3_D
    generic map(
      INIT => X"10"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I1 => BU2_U0_transmitter_state_machine_state_1_2_72,
      I2 => BU2_U0_transmitter_state_machine_state_1_0_43,
      LO => BU2_N5243,
      O => BU2_U0_transmitter_recoder_N40
    );
  BU2_U0_transmitter_recoder_mux0395131 : LUT3_D
    generic map(
      INIT => X"10"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I1 => BU2_U0_transmitter_state_machine_state_0_2_74,
      I2 => BU2_U0_transmitter_state_machine_state_0_0_76,
      LO => BU2_N5242,
      O => BU2_U0_transmitter_recoder_N33
    );
  BU2_U0_receiver_pcs_sync_state0_next_state_1_0_169_SW0 : LUT3_L
    generic map(
      INIT => X"13"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_N91,
      I1 => BU2_U0_receiver_pcs_sync_state0_mux0019(7),
      I2 => BU2_U0_receiver_pcs_sync_state0_code_valid_pipe(0),
      LO => BU2_N4413
    );
  BU2_U0_receiver_pcs_sync_state1_next_state_1_0_169_SW0 : LUT3_L
    generic map(
      INIT => X"13"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_N91,
      I1 => BU2_U0_receiver_pcs_sync_state1_mux0019(7),
      I2 => BU2_U0_receiver_pcs_sync_state1_code_valid_pipe(0),
      LO => BU2_N4411
    );
  BU2_U0_receiver_pcs_sync_state2_next_state_1_0_169_SW0 : LUT3_L
    generic map(
      INIT => X"13"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_N91,
      I1 => BU2_U0_receiver_pcs_sync_state2_mux0019(7),
      I2 => BU2_U0_receiver_pcs_sync_state2_code_valid_pipe(0),
      LO => BU2_N4409
    );
  BU2_U0_receiver_pcs_sync_state3_next_state_1_0_169_SW0 : LUT3_L
    generic map(
      INIT => X"13"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_N91,
      I1 => BU2_U0_receiver_pcs_sync_state3_mux0019(7),
      I2 => BU2_U0_receiver_pcs_sync_state3_code_valid_pipe(0),
      LO => BU2_N4407
    );
  BU2_U0_receiver_pcs_sync_state0_next_state_1_0_118_SW0 : LUT4_L
    generic map(
      INIT => X"FE54"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_code_comma_pipe(1),
      I1 => BU2_U0_receiver_pcs_sync_state0_mux0008_1_Q_27,
      I2 => BU2_U0_receiver_pcs_sync_state0_mux0008_3_Q_25,
      I3 => BU2_U0_receiver_pcs_sync_state0_mux0008_2_Q_26,
      LO => BU2_N4388
    );
  BU2_U0_receiver_pcs_sync_state1_next_state_1_0_118_SW0 : LUT4_L
    generic map(
      INIT => X"FE54"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_code_comma_pipe(1),
      I1 => BU2_U0_receiver_pcs_sync_state1_mux0008_1_Q_30,
      I2 => BU2_U0_receiver_pcs_sync_state1_mux0008_3_Q_28,
      I3 => BU2_U0_receiver_pcs_sync_state1_mux0008_2_Q_29,
      LO => BU2_N4386
    );
  BU2_U0_receiver_pcs_sync_state2_next_state_1_0_118_SW0 : LUT4_L
    generic map(
      INIT => X"FE54"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_code_comma_pipe(1),
      I1 => BU2_U0_receiver_pcs_sync_state2_mux0008_1_Q_33,
      I2 => BU2_U0_receiver_pcs_sync_state2_mux0008_3_Q_31,
      I3 => BU2_U0_receiver_pcs_sync_state2_mux0008_2_Q_32,
      LO => BU2_N4384
    );
  BU2_U0_receiver_pcs_sync_state3_next_state_1_0_118_SW0 : LUT4_L
    generic map(
      INIT => X"FE54"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_code_comma_pipe(1),
      I1 => BU2_U0_receiver_pcs_sync_state3_mux0008_1_Q_36,
      I2 => BU2_U0_receiver_pcs_sync_state3_mux0008_3_Q_34,
      I3 => BU2_U0_receiver_pcs_sync_state3_mux0008_2_Q_35,
      LO => BU2_N4382
    );
  BU2_U0_transmitter_state_machine_mux0003_0_32 : LUT2_L
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_2_72,
      I1 => BU2_U0_transmitter_state_machine_state_1_1_73,
      LO => BU2_U0_transmitter_state_machine_mux0003_0_map3002
    );
  BU2_U0_receiver_recoder_or00221_SW0 : LUT3_D
    generic map(
      INIT => X"FB"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(9),
      I1 => BU2_U0_receiver_recoder_rxc_pipe(1),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(8),
      LO => BU2_N5241,
      O => BU2_N4170
    );
  BU2_U0_receiver_pcs_sync_state0_next_state_1_0_88 : LUT4_L
    generic map(
      INIT => X"FFA8"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_next_state_1_0_map2903,
      I1 => BU2_U0_receiver_pcs_sync_state0_next_state_1_0_map2888,
      I2 => BU2_U0_receiver_pcs_sync_state0_next_state_1_0_map2901,
      I3 => BU2_U0_receiver_pcs_sync_state0_next_state_1_0_map2884,
      LO => BU2_U0_receiver_pcs_sync_state0_next_state_1_0_map2905
    );
  BU2_U0_receiver_pcs_sync_state1_next_state_1_0_88 : LUT4_L
    generic map(
      INIT => X"FFA8"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_next_state_1_0_map2852,
      I1 => BU2_U0_receiver_pcs_sync_state1_next_state_1_0_map2837,
      I2 => BU2_U0_receiver_pcs_sync_state1_next_state_1_0_map2850,
      I3 => BU2_U0_receiver_pcs_sync_state1_next_state_1_0_map2833,
      LO => BU2_U0_receiver_pcs_sync_state1_next_state_1_0_map2854
    );
  BU2_U0_receiver_pcs_sync_state2_next_state_1_0_88 : LUT4_L
    generic map(
      INIT => X"FFA8"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_next_state_1_0_map2801,
      I1 => BU2_U0_receiver_pcs_sync_state2_next_state_1_0_map2786,
      I2 => BU2_U0_receiver_pcs_sync_state2_next_state_1_0_map2799,
      I3 => BU2_U0_receiver_pcs_sync_state2_next_state_1_0_map2782,
      LO => BU2_U0_receiver_pcs_sync_state2_next_state_1_0_map2803
    );
  BU2_U0_receiver_pcs_sync_state3_next_state_1_0_88 : LUT4_L
    generic map(
      INIT => X"FFA8"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_next_state_1_0_map2750,
      I1 => BU2_U0_receiver_pcs_sync_state3_next_state_1_0_map2735,
      I2 => BU2_U0_receiver_pcs_sync_state3_next_state_1_0_map2748,
      I3 => BU2_U0_receiver_pcs_sync_state3_next_state_1_0_map2731,
      LO => BU2_U0_receiver_pcs_sync_state3_next_state_1_0_map2752
    );
  BU2_U0_transmitter_state_machine_mux0003_1_11 : LUT3_D
    generic map(
      INIT => X"AE"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_q_det_95,
      I1 => BU2_U0_transmitter_tx_is_q(0),
      I2 => BU2_U0_transmitter_state_machine_state_1_2_1_22,
      LO => BU2_N5240,
      O => BU2_U0_transmitter_state_machine_N01
    );
  BU2_U0_receiver_pcs_sync_state0_Mxor_signal_detect_change_Result1 : LUT2_D
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_signal_detect_last_53,
      I1 => BU2_U0_signal_detect_int(0),
      LO => BU2_N5239,
      O => BU2_U0_receiver_pcs_sync_state0_signal_detect_change
    );
  BU2_U0_receiver_pcs_sync_state1_Mxor_signal_detect_change_Result1 : LUT2_D
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_signal_detect_last_59,
      I1 => BU2_U0_signal_detect_int(1),
      LO => BU2_N5238,
      O => BU2_U0_receiver_pcs_sync_state1_signal_detect_change
    );
  BU2_U0_receiver_pcs_sync_state2_Mxor_signal_detect_change_Result1 : LUT2_D
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_signal_detect_last_65,
      I1 => BU2_U0_signal_detect_int(2),
      LO => BU2_N5237,
      O => BU2_U0_receiver_pcs_sync_state2_signal_detect_change
    );
  BU2_U0_receiver_pcs_sync_state3_Mxor_signal_detect_change_Result1 : LUT2_D
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_signal_detect_last_71,
      I1 => BU2_U0_signal_detect_int(3),
      LO => BU2_N5236,
      O => BU2_U0_receiver_pcs_sync_state3_signal_detect_change
    );
  BU2_U0_receiver_pcs_sync_state0_mux0019_16_11 : LUT2_D
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_state_1_0_52,
      I1 => BU2_U0_receiver_pcs_sync_state0_state_1_1_1_8,
      LO => BU2_N5235,
      O => BU2_U0_receiver_pcs_sync_state0_N01
    );
  BU2_U0_receiver_pcs_sync_state1_mux0019_16_11 : LUT2_D
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_state_1_0_58,
      I1 => BU2_U0_receiver_pcs_sync_state1_state_1_1_1_9,
      LO => BU2_N5234,
      O => BU2_U0_receiver_pcs_sync_state1_N01
    );
  BU2_U0_receiver_pcs_sync_state2_mux0019_16_11 : LUT2_D
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_state_1_0_64,
      I1 => BU2_U0_receiver_pcs_sync_state2_state_1_1_1_10,
      LO => BU2_N5233,
      O => BU2_U0_receiver_pcs_sync_state2_N01
    );
  BU2_U0_receiver_pcs_sync_state3_mux0019_16_11 : LUT2_D
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_state_1_0_70,
      I1 => BU2_U0_receiver_pcs_sync_state3_state_1_1_1_11,
      LO => BU2_N5232,
      O => BU2_U0_receiver_pcs_sync_state3_N01
    );
  BU2_U0_transmitter_align_or0002_SW0 : LUT3_L
    generic map(
      INIT => X"FD"
    )
    port map (
      I0 => BU2_U0_transmitter_align_extra_a_98,
      I1 => BU2_U0_transmitter_align_count(0),
      I2 => BU2_U0_transmitter_align_count(1),
      LO => BU2_N3454
    );
  BU2_U0_receiver_recoder_or003175 : LUT4_D
    generic map(
      INIT => X"AFAE"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_pipe(6),
      I1 => BU2_U0_receiver_recoder_or0031_map2658,
      I2 => BU2_U0_receiver_recoder_and0040,
      I3 => BU2_U0_receiver_recoder_or0031_map2652,
      LO => BU2_N5231,
      O => BU2_U0_receiver_recoder_or0031_map2662
    );
  BU2_U0_receiver_recoder_or00231_SW0 : LUT2_D
    generic map(
      INIT => X"D"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(19),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(16),
      LO => BU2_N5230,
      O => BU2_N3300
    );
  BU2_U0_transmitter_state_machine_mux0003_2_SW1 : LUT3_L
    generic map(
      INIT => X"F9"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1_2_24,
      I1 => BU2_U0_transmitter_state_machine_state_1_0_2_23,
      I2 => BU2_U0_transmitter_state_machine_state_1_2_1_22,
      LO => BU2_N3014
    );
  BU2_U0_receiver_pcs_sync_state0_mux0008_5_SW0 : LUT3_L
    generic map(
      INIT => X"F6"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_state_1_3_49,
      I1 => BU2_U0_receiver_pcs_sync_state0_code_valid_pipe(0),
      I2 => BU2_U0_receiver_pcs_sync_state0_state_1_4_48,
      LO => BU2_N3011
    );
  BU2_U0_receiver_pcs_sync_state1_mux0008_5_SW0 : LUT3_L
    generic map(
      INIT => X"F6"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_state_1_3_55,
      I1 => BU2_U0_receiver_pcs_sync_state1_code_valid_pipe(0),
      I2 => BU2_U0_receiver_pcs_sync_state1_state_1_4_54,
      LO => BU2_N3009
    );
  BU2_U0_receiver_pcs_sync_state2_mux0008_5_SW0 : LUT3_L
    generic map(
      INIT => X"F6"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_state_1_3_61,
      I1 => BU2_U0_receiver_pcs_sync_state2_code_valid_pipe(0),
      I2 => BU2_U0_receiver_pcs_sync_state2_state_1_4_60,
      LO => BU2_N3007
    );
  BU2_U0_receiver_pcs_sync_state3_mux0008_5_SW0 : LUT3_L
    generic map(
      INIT => X"F6"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_state_1_3_67,
      I1 => BU2_U0_receiver_pcs_sync_state3_code_valid_pipe(0),
      I2 => BU2_U0_receiver_pcs_sync_state3_state_1_4_66,
      LO => BU2_N3005
    );
  BU2_U0_receiver_pcs_sync_state0_mux0008_16_Q : LUT4_D
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => BU2_N3003,
      I1 => BU2_U0_receiver_pcs_sync_state0_state_1_1_51,
      I2 => BU2_U0_receiver_pcs_sync_state0_state_1_0_52,
      I3 => BU2_U0_receiver_pcs_sync_state0_signal_detect_change,
      LO => BU2_N5229,
      O => BU2_U0_receiver_pcs_sync_state0_mux0008_16_Q_12
    );
  BU2_U0_receiver_pcs_sync_state1_mux0008_16_Q : LUT4_D
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => BU2_N3001,
      I1 => BU2_U0_receiver_pcs_sync_state1_state_1_1_57,
      I2 => BU2_U0_receiver_pcs_sync_state1_state_1_0_58,
      I3 => BU2_U0_receiver_pcs_sync_state1_signal_detect_change,
      LO => BU2_N5228,
      O => BU2_U0_receiver_pcs_sync_state1_mux0008_16_Q_13
    );
  BU2_U0_receiver_pcs_sync_state2_mux0008_16_Q : LUT4_D
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => BU2_N2999,
      I1 => BU2_U0_receiver_pcs_sync_state2_state_1_1_63,
      I2 => BU2_U0_receiver_pcs_sync_state2_state_1_0_64,
      I3 => BU2_U0_receiver_pcs_sync_state2_signal_detect_change,
      LO => BU2_N5227,
      O => BU2_U0_receiver_pcs_sync_state2_mux0008_16_Q_14
    );
  BU2_U0_receiver_pcs_sync_state3_mux0008_16_Q : LUT4_D
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => BU2_N2997,
      I1 => BU2_U0_receiver_pcs_sync_state3_state_1_1_69,
      I2 => BU2_U0_receiver_pcs_sync_state3_state_1_0_70,
      I3 => BU2_U0_receiver_pcs_sync_state3_signal_detect_change,
      LO => BU2_N5226,
      O => BU2_U0_receiver_pcs_sync_state3_mux0008_16_Q_15
    );
  BU2_U0_receiver_pcs_sync_state0_mux0019_9_1 : LUT4_L
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_code_valid_pipe(0),
      I1 => BU2_U0_receiver_pcs_sync_state0_state_1_0_52,
      I2 => BU2_U0_receiver_pcs_sync_state0_N9,
      I3 => BU2_U0_receiver_pcs_sync_state0_state_1_1_51,
      LO => BU2_U0_receiver_pcs_sync_state0_mux0019(9)
    );
  BU2_U0_receiver_pcs_sync_state0_mux0019_8_1 : LUT4_L
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_code_valid_pipe(0),
      I1 => BU2_U0_receiver_pcs_sync_state0_state_1_1_51,
      I2 => BU2_U0_receiver_pcs_sync_state0_N9,
      I3 => BU2_U0_receiver_pcs_sync_state0_state_1_0_52,
      LO => BU2_U0_receiver_pcs_sync_state0_mux0019(8)
    );
  BU2_U0_receiver_pcs_sync_state1_mux0019_9_1 : LUT4_L
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_code_valid_pipe(0),
      I1 => BU2_U0_receiver_pcs_sync_state1_state_1_0_58,
      I2 => BU2_U0_receiver_pcs_sync_state1_N9,
      I3 => BU2_U0_receiver_pcs_sync_state1_state_1_1_57,
      LO => BU2_U0_receiver_pcs_sync_state1_mux0019(9)
    );
  BU2_U0_receiver_pcs_sync_state1_mux0019_8_1 : LUT4_L
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_code_valid_pipe(0),
      I1 => BU2_U0_receiver_pcs_sync_state1_state_1_1_57,
      I2 => BU2_U0_receiver_pcs_sync_state1_N9,
      I3 => BU2_U0_receiver_pcs_sync_state1_state_1_0_58,
      LO => BU2_U0_receiver_pcs_sync_state1_mux0019(8)
    );
  BU2_U0_receiver_pcs_sync_state2_mux0019_9_1 : LUT4_L
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_code_valid_pipe(0),
      I1 => BU2_U0_receiver_pcs_sync_state2_state_1_0_64,
      I2 => BU2_U0_receiver_pcs_sync_state2_N9,
      I3 => BU2_U0_receiver_pcs_sync_state2_state_1_1_63,
      LO => BU2_U0_receiver_pcs_sync_state2_mux0019(9)
    );
  BU2_U0_receiver_pcs_sync_state2_mux0019_8_1 : LUT4_L
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_code_valid_pipe(0),
      I1 => BU2_U0_receiver_pcs_sync_state2_state_1_1_63,
      I2 => BU2_U0_receiver_pcs_sync_state2_N9,
      I3 => BU2_U0_receiver_pcs_sync_state2_state_1_0_64,
      LO => BU2_U0_receiver_pcs_sync_state2_mux0019(8)
    );
  BU2_U0_receiver_pcs_sync_state3_mux0019_9_1 : LUT4_L
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_code_valid_pipe(0),
      I1 => BU2_U0_receiver_pcs_sync_state3_state_1_0_70,
      I2 => BU2_U0_receiver_pcs_sync_state3_N9,
      I3 => BU2_U0_receiver_pcs_sync_state3_state_1_1_69,
      LO => BU2_U0_receiver_pcs_sync_state3_mux0019(9)
    );
  BU2_U0_receiver_pcs_sync_state3_mux0019_8_1 : LUT4_L
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_code_valid_pipe(0),
      I1 => BU2_U0_receiver_pcs_sync_state3_state_1_1_69,
      I2 => BU2_U0_receiver_pcs_sync_state3_N9,
      I3 => BU2_U0_receiver_pcs_sync_state3_state_1_0_70,
      LO => BU2_U0_receiver_pcs_sync_state3_mux0019(8)
    );
  BU2_U0_receiver_pcs_sync_state0_mux0019_11_11 : LUT3_D
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_state_1_2_50,
      I1 => BU2_U0_receiver_pcs_sync_state0_state_1_3_49,
      I2 => BU2_U0_receiver_pcs_sync_state0_state_1_4_48,
      LO => BU2_N5225,
      O => BU2_U0_receiver_pcs_sync_state0_N7
    );
  BU2_U0_receiver_pcs_sync_state0_mux0019_7_11 : LUT3_D
    generic map(
      INIT => X"10"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_state_1_3_49,
      I1 => BU2_U0_receiver_pcs_sync_state0_state_1_4_48,
      I2 => BU2_U0_receiver_pcs_sync_state0_state_1_2_50,
      LO => BU2_N5224,
      O => BU2_U0_receiver_pcs_sync_state0_N9
    );
  BU2_U0_receiver_pcs_sync_state1_mux0019_11_11 : LUT3_D
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_state_1_2_56,
      I1 => BU2_U0_receiver_pcs_sync_state1_state_1_3_55,
      I2 => BU2_U0_receiver_pcs_sync_state1_state_1_4_54,
      LO => BU2_N5223,
      O => BU2_U0_receiver_pcs_sync_state1_N7
    );
  BU2_U0_receiver_pcs_sync_state1_mux0019_7_11 : LUT3_D
    generic map(
      INIT => X"10"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_state_1_3_55,
      I1 => BU2_U0_receiver_pcs_sync_state1_state_1_4_54,
      I2 => BU2_U0_receiver_pcs_sync_state1_state_1_2_56,
      LO => BU2_N5222,
      O => BU2_U0_receiver_pcs_sync_state1_N9
    );
  BU2_U0_receiver_pcs_sync_state2_mux0019_11_11 : LUT3_D
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_state_1_2_62,
      I1 => BU2_U0_receiver_pcs_sync_state2_state_1_3_61,
      I2 => BU2_U0_receiver_pcs_sync_state2_state_1_4_60,
      LO => BU2_N5221,
      O => BU2_U0_receiver_pcs_sync_state2_N7
    );
  BU2_U0_receiver_pcs_sync_state2_mux0019_7_11 : LUT3_D
    generic map(
      INIT => X"10"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_state_1_3_61,
      I1 => BU2_U0_receiver_pcs_sync_state2_state_1_4_60,
      I2 => BU2_U0_receiver_pcs_sync_state2_state_1_2_62,
      LO => BU2_N5220,
      O => BU2_U0_receiver_pcs_sync_state2_N9
    );
  BU2_U0_receiver_pcs_sync_state3_mux0019_11_11 : LUT3_D
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_state_1_2_68,
      I1 => BU2_U0_receiver_pcs_sync_state3_state_1_3_67,
      I2 => BU2_U0_receiver_pcs_sync_state3_state_1_4_66,
      LO => BU2_N5219,
      O => BU2_U0_receiver_pcs_sync_state3_N7
    );
  BU2_U0_receiver_pcs_sync_state3_mux0019_7_11 : LUT3_D
    generic map(
      INIT => X"10"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_state_1_3_67,
      I1 => BU2_U0_receiver_pcs_sync_state3_state_1_4_66,
      I2 => BU2_U0_receiver_pcs_sync_state3_state_1_2_68,
      LO => BU2_N5218,
      O => BU2_U0_receiver_pcs_sync_state3_N9
    );
  BU2_U0_receiver_recoder_or0030128 : LUT4_D
    generic map(
      INIT => X"AAA8"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_lane_terminate(4),
      I1 => BU2_U0_receiver_recoder_or0030_map2468,
      I2 => BU2_U0_receiver_recoder_or0030_map2471,
      I3 => BU2_U0_receiver_recoder_or0030_map2479,
      LO => BU2_N5217,
      O => BU2_U0_receiver_recoder_or0030_map2481
    );
  BU2_U0_receiver_recoder_or003038 : LUT4_L
    generic map(
      INIT => X"7FFF"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(42),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(43),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(44),
      I3 => BU2_U0_receiver_recoder_rxd_pipe(45),
      LO => BU2_U0_receiver_recoder_or0030_map2459
    );
  BU2_U0_receiver_pcs_sync_state0_next_state_1_1_15 : LUT4_L
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_mux0008_6_Q,
      I1 => BU2_U0_receiver_pcs_sync_state0_mux0008_5_Q_3,
      I2 => BU2_U0_receiver_pcs_sync_state0_mux0008_10_Q,
      I3 => BU2_U0_receiver_pcs_sync_state0_mux0008_14_Q,
      LO => BU2_U0_receiver_pcs_sync_state0_next_state_1_1_map2437
    );
  BU2_U0_receiver_pcs_sync_state1_next_state_1_1_15 : LUT4_L
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_mux0008_6_Q,
      I1 => BU2_U0_receiver_pcs_sync_state1_mux0008_5_Q_4,
      I2 => BU2_U0_receiver_pcs_sync_state1_mux0008_10_Q,
      I3 => BU2_U0_receiver_pcs_sync_state1_mux0008_14_Q,
      LO => BU2_U0_receiver_pcs_sync_state1_next_state_1_1_map2423
    );
  BU2_U0_receiver_pcs_sync_state2_next_state_1_1_15 : LUT4_L
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_mux0008_6_Q,
      I1 => BU2_U0_receiver_pcs_sync_state2_mux0008_5_Q_5,
      I2 => BU2_U0_receiver_pcs_sync_state2_mux0008_10_Q,
      I3 => BU2_U0_receiver_pcs_sync_state2_mux0008_14_Q,
      LO => BU2_U0_receiver_pcs_sync_state2_next_state_1_1_map2409
    );
  BU2_U0_receiver_pcs_sync_state3_next_state_1_1_15 : LUT4_L
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_mux0008_6_Q,
      I1 => BU2_U0_receiver_pcs_sync_state3_mux0008_5_Q_6,
      I2 => BU2_U0_receiver_pcs_sync_state3_mux0008_10_Q,
      I3 => BU2_U0_receiver_pcs_sync_state3_mux0008_14_Q,
      LO => BU2_U0_receiver_pcs_sync_state3_next_state_1_1_map2395
    );
  BU2_U0_receiver_pcs_sync_state0_mux0008_11_1 : LUT4_D
    generic map(
      INIT => X"0200"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_state_1_1_51,
      I1 => BU2_U0_receiver_pcs_sync_state0_state_1_0_52,
      I2 => BU2_U0_receiver_pcs_sync_state0_signal_detect_change,
      I3 => BU2_U0_receiver_pcs_sync_state0_N8,
      LO => BU2_N5216,
      O => BU2_U0_receiver_pcs_sync_state0_mux0008_11_Q
    );
  BU2_U0_receiver_pcs_sync_state0_mux0019_4_11 : LUT4_D
    generic map(
      INIT => X"1000"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_state_1_2_50,
      I1 => BU2_U0_receiver_pcs_sync_state0_state_1_4_48,
      I2 => BU2_U0_receiver_pcs_sync_state0_state_1_3_49,
      I3 => BU2_U0_receiver_pcs_sync_state0_code_valid_pipe(0),
      LO => BU2_N5215,
      O => BU2_U0_receiver_pcs_sync_state0_N8
    );
  BU2_U0_receiver_pcs_sync_state1_mux0008_11_1 : LUT4_D
    generic map(
      INIT => X"0200"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_state_1_1_57,
      I1 => BU2_U0_receiver_pcs_sync_state1_state_1_0_58,
      I2 => BU2_U0_receiver_pcs_sync_state1_signal_detect_change,
      I3 => BU2_U0_receiver_pcs_sync_state1_N8,
      LO => BU2_N5214,
      O => BU2_U0_receiver_pcs_sync_state1_mux0008_11_Q
    );
  BU2_U0_receiver_pcs_sync_state1_mux0019_4_11 : LUT4_D
    generic map(
      INIT => X"1000"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_state_1_2_56,
      I1 => BU2_U0_receiver_pcs_sync_state1_state_1_4_54,
      I2 => BU2_U0_receiver_pcs_sync_state1_state_1_3_55,
      I3 => BU2_U0_receiver_pcs_sync_state1_code_valid_pipe(0),
      LO => BU2_N5213,
      O => BU2_U0_receiver_pcs_sync_state1_N8
    );
  BU2_U0_receiver_pcs_sync_state2_mux0008_11_1 : LUT4_D
    generic map(
      INIT => X"0200"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_state_1_1_63,
      I1 => BU2_U0_receiver_pcs_sync_state2_state_1_0_64,
      I2 => BU2_U0_receiver_pcs_sync_state2_signal_detect_change,
      I3 => BU2_U0_receiver_pcs_sync_state2_N8,
      LO => BU2_N5212,
      O => BU2_U0_receiver_pcs_sync_state2_mux0008_11_Q
    );
  BU2_U0_receiver_pcs_sync_state2_mux0019_4_11 : LUT4_D
    generic map(
      INIT => X"1000"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_state_1_2_62,
      I1 => BU2_U0_receiver_pcs_sync_state2_state_1_4_60,
      I2 => BU2_U0_receiver_pcs_sync_state2_state_1_3_61,
      I3 => BU2_U0_receiver_pcs_sync_state2_code_valid_pipe(0),
      LO => BU2_N5211,
      O => BU2_U0_receiver_pcs_sync_state2_N8
    );
  BU2_U0_receiver_pcs_sync_state3_mux0008_11_1 : LUT4_D
    generic map(
      INIT => X"0200"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_state_1_1_69,
      I1 => BU2_U0_receiver_pcs_sync_state3_state_1_0_70,
      I2 => BU2_U0_receiver_pcs_sync_state3_signal_detect_change,
      I3 => BU2_U0_receiver_pcs_sync_state3_N8,
      LO => BU2_N5210,
      O => BU2_U0_receiver_pcs_sync_state3_mux0008_11_Q
    );
  BU2_U0_receiver_pcs_sync_state3_mux0019_4_11 : LUT4_D
    generic map(
      INIT => X"1000"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_state_1_2_68,
      I1 => BU2_U0_receiver_pcs_sync_state3_state_1_4_66,
      I2 => BU2_U0_receiver_pcs_sync_state3_state_1_3_67,
      I3 => BU2_U0_receiver_pcs_sync_state3_code_valid_pipe(0),
      LO => BU2_N5209,
      O => BU2_U0_receiver_pcs_sync_state3_N8
    );
  BU2_U0_receiver_recoder_or002938 : LUT4_L
    generic map(
      INIT => X"7FFF"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(34),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(35),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(36),
      I3 => BU2_U0_receiver_recoder_rxd_pipe(37),
      LO => BU2_U0_receiver_recoder_or0029_map2327
    );
  BU2_U0_receiver_recoder_or003230 : LUT4_D
    generic map(
      INIT => X"7FFF"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(59),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(60),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(61),
      I3 => BU2_U0_receiver_recoder_rxd_pipe(63),
      LO => BU2_N5208,
      O => BU2_U0_receiver_recoder_or0032_map2307
    );
  BU2_U0_receiver_recoder_or002536 : LUT4_D
    generic map(
      INIT => X"3332"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_lane_term_pipe(2),
      I1 => BU2_U0_receiver_recoder_lane_term_pipe(0),
      I2 => BU2_U0_receiver_recoder_lane_term_pipe(3),
      I3 => BU2_U0_receiver_recoder_lane_term_pipe(1),
      LO => BU2_N5207,
      O => BU2_U0_receiver_recoder_or0025_map2289
    );
  BU2_U0_receiver_recoder_and00221_SW0 : LUT3_D
    generic map(
      INIT => X"FB"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(25),
      I1 => BU2_U0_receiver_recoder_rxc_pipe(3),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(24),
      LO => BU2_N5206,
      O => BU2_N2442
    );
  BU2_U0_receiver_recoder_or00211_SW0 : LUT3_D
    generic map(
      INIT => X"FB"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(1),
      I1 => BU2_U0_receiver_recoder_rxc_pipe(0),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(0),
      LO => BU2_N5205,
      O => BU2_N2440
    );
  BU2_U0_transmitter_mux007592 : LUT4_L
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(12),
      I1 => BU2_U0_transmitter_txd_pipe(15),
      I2 => BU2_U0_transmitter_txc_pipe(1),
      I3 => BU2_U0_transmitter_txd_pipe(8),
      LO => BU2_U0_transmitter_mux0075_map2256
    );
  BU2_U0_transmitter_mux007567 : LUT4_L
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(4),
      I1 => BU2_U0_transmitter_txd_pipe(7),
      I2 => BU2_U0_transmitter_txc_pipe(0),
      I3 => BU2_U0_transmitter_txd_pipe(0),
      LO => BU2_U0_transmitter_mux0075_map2247
    );
  BU2_U0_transmitter_mux007529 : LUT4_L
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(28),
      I1 => BU2_U0_transmitter_txd_pipe(31),
      I2 => BU2_U0_transmitter_txc_pipe(3),
      I3 => BU2_U0_transmitter_txd_pipe(24),
      LO => BU2_U0_transmitter_mux0075_map2237
    );
  BU2_U0_transmitter_filter0_xor00017 : LUT4_D
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(0),
      I1 => BU2_U0_transmitter_txd_pipe(2),
      I2 => BU2_U0_transmitter_txd_pipe(1),
      I3 => BU2_U0_transmitter_txd_pipe(7),
      LO => BU2_N5204,
      O => BU2_U0_transmitter_filter0_xor0001_map2216
    );
  BU2_U0_receiver_deskew_state_mux0044_0_105 : LUT4_L
    generic map(
      INIT => X"EA4C"
    )
    port map (
      I0 => BU2_U0_receiver_deskew_state_deskew_error(0),
      I1 => BU2_U0_receiver_deskew_state_got_align(0),
      I2 => BU2_U0_receiver_deskew_state_state_1_1_44,
      I3 => NlwRenamedSig_OI_align_status,
      LO => BU2_U0_receiver_deskew_state_mux0044_0_map2171
    );
  BU2_U0_transmitter_recoder_mux0428_SW0 : LUT4_L
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_U0_transmitter_filter5_txd_out(6),
      I1 => BU2_U0_transmitter_recoder_N40,
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(14),
      I3 => BU2_U0_transmitter_recoder_N41,
      LO => BU2_N2161
    );
  BU2_U0_transmitter_recoder_mux0422_SW0 : LUT4_L
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_U0_transmitter_filter4_txd_out(6),
      I1 => BU2_U0_transmitter_recoder_N40,
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(6),
      I3 => BU2_U0_transmitter_recoder_N41,
      LO => BU2_N2159
    );
  BU2_U0_transmitter_recoder_mux0446_SW0 : LUT4_L
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_U0_transmitter_filter7_txd_out(6),
      I1 => BU2_U0_transmitter_recoder_N40,
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(30),
      I3 => BU2_U0_transmitter_recoder_N41,
      LO => BU2_N2157
    );
  BU2_U0_transmitter_recoder_mux0437_SW0 : LUT4_L
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_U0_transmitter_filter6_txd_out(6),
      I1 => BU2_U0_transmitter_recoder_N40,
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(22),
      I3 => BU2_U0_transmitter_recoder_N41,
      LO => BU2_N2155
    );
  BU2_U0_transmitter_recoder_mux0401_SW0 : LUT4_L
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_U0_transmitter_filter2_txd_out(6),
      I1 => BU2_U0_transmitter_recoder_N33,
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(22),
      I3 => BU2_U0_transmitter_recoder_N44,
      LO => BU2_N2153
    );
  BU2_U0_transmitter_recoder_mux0395_SW0 : LUT4_L
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_U0_transmitter_filter1_txd_out(6),
      I1 => BU2_U0_transmitter_recoder_N33,
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(14),
      I3 => BU2_U0_transmitter_recoder_N44,
      LO => BU2_N2151
    );
  BU2_U0_transmitter_recoder_mux0450_SW0 : LUT4_L
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_U0_transmitter_filter0_txd_out(6),
      I1 => BU2_U0_transmitter_recoder_N33,
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(6),
      I3 => BU2_U0_transmitter_recoder_N44,
      LO => BU2_N2149
    );
  BU2_U0_transmitter_recoder_mux0407_SW0 : LUT4_L
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_U0_transmitter_filter3_txd_out(6),
      I1 => BU2_U0_transmitter_recoder_N33,
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(30),
      I3 => BU2_U0_transmitter_recoder_N44,
      LO => BU2_N2147
    );
  BU2_U0_transmitter_mux007692 : LUT4_L
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(44),
      I1 => BU2_U0_transmitter_txd_pipe(47),
      I2 => BU2_U0_transmitter_txc_pipe(5),
      I3 => BU2_U0_transmitter_txd_pipe(40),
      LO => BU2_U0_transmitter_mux0076_map2133
    );
  BU2_U0_transmitter_mux007667 : LUT4_L
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(36),
      I1 => BU2_U0_transmitter_txd_pipe(39),
      I2 => BU2_U0_transmitter_txc_pipe(4),
      I3 => BU2_U0_transmitter_txd_pipe(32),
      LO => BU2_U0_transmitter_mux0076_map2124
    );
  BU2_U0_transmitter_mux007629 : LUT4_L
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(60),
      I1 => BU2_U0_transmitter_txd_pipe(63),
      I2 => BU2_U0_transmitter_txc_pipe(7),
      I3 => BU2_U0_transmitter_txd_pipe(56),
      LO => BU2_U0_transmitter_mux0076_map2114
    );
  BU2_U0_transmitter_filter1_xor00017 : LUT4_D
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(8),
      I1 => BU2_U0_transmitter_txd_pipe(10),
      I2 => BU2_U0_transmitter_txd_pipe(9),
      I3 => BU2_U0_transmitter_txd_pipe(15),
      LO => BU2_N5203,
      O => BU2_U0_transmitter_filter1_xor0001_map2093
    );
  BU2_U0_transmitter_filter2_xor00017 : LUT4_D
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(16),
      I1 => BU2_U0_transmitter_txd_pipe(18),
      I2 => BU2_U0_transmitter_txd_pipe(17),
      I3 => BU2_U0_transmitter_txd_pipe(23),
      LO => BU2_N5202,
      O => BU2_U0_transmitter_filter2_xor0001_map2080
    );
  BU2_U0_transmitter_filter3_xor00017 : LUT4_D
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(24),
      I1 => BU2_U0_transmitter_txd_pipe(26),
      I2 => BU2_U0_transmitter_txd_pipe(25),
      I3 => BU2_U0_transmitter_txd_pipe(31),
      LO => BU2_N5201,
      O => BU2_U0_transmitter_filter3_xor0001_map2067
    );
  BU2_U0_transmitter_filter4_xor00017 : LUT4_D
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(32),
      I1 => BU2_U0_transmitter_txd_pipe(34),
      I2 => BU2_U0_transmitter_txd_pipe(33),
      I3 => BU2_U0_transmitter_txd_pipe(39),
      LO => BU2_N5200,
      O => BU2_U0_transmitter_filter4_xor0001_map2054
    );
  BU2_U0_transmitter_filter5_xor00017 : LUT4_D
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(40),
      I1 => BU2_U0_transmitter_txd_pipe(42),
      I2 => BU2_U0_transmitter_txd_pipe(41),
      I3 => BU2_U0_transmitter_txd_pipe(47),
      LO => BU2_N5199,
      O => BU2_U0_transmitter_filter5_xor0001_map2041
    );
  BU2_U0_transmitter_filter6_xor00017 : LUT4_D
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(48),
      I1 => BU2_U0_transmitter_txd_pipe(50),
      I2 => BU2_U0_transmitter_txd_pipe(49),
      I3 => BU2_U0_transmitter_txd_pipe(55),
      LO => BU2_N5198,
      O => BU2_U0_transmitter_filter6_xor0001_map2028
    );
  BU2_U0_transmitter_filter7_xor00017 : LUT4_D
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(56),
      I1 => BU2_U0_transmitter_txd_pipe(58),
      I2 => BU2_U0_transmitter_txd_pipe(57),
      I3 => BU2_U0_transmitter_txd_pipe(63),
      LO => BU2_N5197,
      O => BU2_U0_transmitter_filter7_xor0001_map2015
    );
  BU2_U0_receiver_recoder_or0023_SW0 : LUT3_D
    generic map(
      INIT => X"B6"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(22),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(21),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(23),
      LO => BU2_N5196,
      O => BU2_N1564
    );
  BU2_U0_receiver_deskew_state_mux0044_2_58 : LUT4_L
    generic map(
      INIT => X"0F08"
    )
    port map (
      I0 => BU2_U0_receiver_deskew_state_state_1_1_44,
      I1 => BU2_U0_receiver_deskew_state_mux0044_2_map1921,
      I2 => BU2_U0_receiver_deskew_state_deskew_error(0),
      I3 => BU2_U0_receiver_deskew_state_mux0044_2_map1926,
      LO => BU2_U0_receiver_deskew_state_mux0044_2_map1929
    );
  BU2_U0_transmitter_filter0_mux0001118 : LUT3_L
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(6),
      I1 => BU2_U0_transmitter_txd_pipe(5),
      I2 => BU2_U0_transmitter_txd_pipe(7),
      LO => BU2_U0_transmitter_filter0_mux00011_map1895
    );
  BU2_U0_transmitter_filter1_mux0001118 : LUT3_L
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(14),
      I1 => BU2_U0_transmitter_txd_pipe(13),
      I2 => BU2_U0_transmitter_txd_pipe(15),
      LO => BU2_U0_transmitter_filter1_mux00011_map1870
    );
  BU2_U0_transmitter_filter2_mux0001118 : LUT3_L
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(22),
      I1 => BU2_U0_transmitter_txd_pipe(21),
      I2 => BU2_U0_transmitter_txd_pipe(23),
      LO => BU2_U0_transmitter_filter2_mux00011_map1845
    );
  BU2_U0_transmitter_filter3_mux0001118 : LUT3_L
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(30),
      I1 => BU2_U0_transmitter_txd_pipe(29),
      I2 => BU2_U0_transmitter_txd_pipe(31),
      LO => BU2_U0_transmitter_filter3_mux00011_map1820
    );
  BU2_U0_transmitter_filter4_mux0001118 : LUT3_L
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(38),
      I1 => BU2_U0_transmitter_txd_pipe(37),
      I2 => BU2_U0_transmitter_txd_pipe(39),
      LO => BU2_U0_transmitter_filter4_mux00011_map1795
    );
  BU2_U0_transmitter_filter5_mux0001118 : LUT3_L
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(46),
      I1 => BU2_U0_transmitter_txd_pipe(45),
      I2 => BU2_U0_transmitter_txd_pipe(47),
      LO => BU2_U0_transmitter_filter5_mux00011_map1770
    );
  BU2_U0_transmitter_filter6_mux0001118 : LUT3_L
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(54),
      I1 => BU2_U0_transmitter_txd_pipe(53),
      I2 => BU2_U0_transmitter_txd_pipe(55),
      LO => BU2_U0_transmitter_filter6_mux00011_map1745
    );
  BU2_U0_transmitter_filter7_mux0001118 : LUT3_L
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(62),
      I1 => BU2_U0_transmitter_txd_pipe(61),
      I2 => BU2_U0_transmitter_txd_pipe(63),
      LO => BU2_U0_transmitter_filter7_mux00011_map1720
    );
  BU2_U0_transmitter_tqmsg_capture_1_and000011 : LUT4_D
    generic map(
      INIT => X"0004"
    )
    port map (
      I0 => BU2_U0_transmitter_filter5_txc_out_84,
      I1 => BU2_U0_transmitter_filter4_txc_out_83,
      I2 => BU2_U0_transmitter_filter7_txc_out_86,
      I3 => BU2_U0_transmitter_filter6_txc_out_85,
      LO => BU2_N5195,
      O => BU2_U0_transmitter_tqmsg_capture_1_and0000_map1678
    );
  BU2_U0_transmitter_align_mux0002_4_11 : LUT3_D
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => BU2_U0_transmitter_align_count(3),
      I1 => BU2_U0_transmitter_align_count(2),
      I2 => BU2_U0_transmitter_align_count(1),
      LO => BU2_N5194,
      O => BU2_U0_transmitter_align_N31
    );
  BU2_U0_transmitter_recoder_mux0409_f5 : MUXF5
    port map (
      I0 => BU2_N5193,
      I1 => BU2_N5192,
      S => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(31),
      O => BU2_U0_transmitter_recoder_mux0409
    );
  BU2_U0_transmitter_recoder_mux04092 : LUT4
    generic map(
      INIT => X"5141"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I1 => BU2_U0_transmitter_state_machine_state_0_2_74,
      I2 => BU2_U0_transmitter_state_machine_state_0_0_76,
      I3 => BU2_U0_transmitter_filter3_txd_out(7),
      O => BU2_N5193
    );
  BU2_U0_transmitter_recoder_mux04091 : LUT4
    generic map(
      INIT => X"F1E1"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I1 => BU2_U0_transmitter_state_machine_state_0_2_74,
      I2 => BU2_U0_transmitter_state_machine_state_0_0_76,
      I3 => BU2_U0_transmitter_filter3_txd_out(7),
      O => BU2_N5192
    );
  BU2_U0_transmitter_recoder_mux0452_f5 : MUXF5
    port map (
      I0 => BU2_N5191,
      I1 => BU2_N5190,
      S => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(7),
      O => BU2_U0_transmitter_recoder_mux0452
    );
  BU2_U0_transmitter_recoder_mux04522 : LUT4
    generic map(
      INIT => X"5141"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I1 => BU2_U0_transmitter_state_machine_state_0_2_74,
      I2 => BU2_U0_transmitter_state_machine_state_0_0_76,
      I3 => BU2_U0_transmitter_filter0_txd_out(7),
      O => BU2_N5191
    );
  BU2_U0_transmitter_recoder_mux04521 : LUT4
    generic map(
      INIT => X"F1E1"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I1 => BU2_U0_transmitter_state_machine_state_0_2_74,
      I2 => BU2_U0_transmitter_state_machine_state_0_0_76,
      I3 => BU2_U0_transmitter_filter0_txd_out(7),
      O => BU2_N5190
    );
  BU2_U0_transmitter_recoder_mux0403_f5 : MUXF5
    port map (
      I0 => BU2_N5189,
      I1 => BU2_N5188,
      S => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(23),
      O => BU2_U0_transmitter_recoder_mux0403
    );
  BU2_U0_transmitter_recoder_mux04032 : LUT4
    generic map(
      INIT => X"5141"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I1 => BU2_U0_transmitter_state_machine_state_0_2_74,
      I2 => BU2_U0_transmitter_state_machine_state_0_0_76,
      I3 => BU2_U0_transmitter_filter2_txd_out(7),
      O => BU2_N5189
    );
  BU2_U0_transmitter_recoder_mux04031 : LUT4
    generic map(
      INIT => X"F1E1"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I1 => BU2_U0_transmitter_state_machine_state_0_2_74,
      I2 => BU2_U0_transmitter_state_machine_state_0_0_76,
      I3 => BU2_U0_transmitter_filter2_txd_out(7),
      O => BU2_N5188
    );
  BU2_U0_transmitter_recoder_mux0396_f5 : MUXF5
    port map (
      I0 => BU2_N5187,
      I1 => BU2_N5186,
      S => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(15),
      O => BU2_U0_transmitter_recoder_mux0396
    );
  BU2_U0_transmitter_recoder_mux03962 : LUT4
    generic map(
      INIT => X"5141"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I1 => BU2_U0_transmitter_state_machine_state_0_2_74,
      I2 => BU2_U0_transmitter_state_machine_state_0_0_76,
      I3 => BU2_U0_transmitter_filter1_txd_out(7),
      O => BU2_N5187
    );
  BU2_U0_transmitter_recoder_mux03961 : LUT4
    generic map(
      INIT => X"F1E1"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I1 => BU2_U0_transmitter_state_machine_state_0_2_74,
      I2 => BU2_U0_transmitter_state_machine_state_0_0_76,
      I3 => BU2_U0_transmitter_filter1_txd_out(7),
      O => BU2_N5186
    );
  BU2_U0_transmitter_recoder_mux0399_f5 : MUXF5
    port map (
      I0 => BU2_N5185,
      I1 => BU2_N5184,
      S => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(21),
      O => BU2_U0_transmitter_recoder_mux0399
    );
  BU2_U0_transmitter_recoder_mux03992 : LUT4
    generic map(
      INIT => X"3D39"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_2_74,
      I1 => BU2_U0_transmitter_state_machine_state_0_0_76,
      I2 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I3 => BU2_U0_transmitter_filter2_txd_out(5),
      O => BU2_N5185
    );
  BU2_U0_transmitter_recoder_mux03991 : LUT4
    generic map(
      INIT => X"FFD9"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_2_74,
      I1 => BU2_U0_transmitter_state_machine_state_0_0_76,
      I2 => BU2_U0_transmitter_filter2_txd_out(5),
      I3 => BU2_U0_transmitter_state_machine_state_0_1_75,
      O => BU2_N5184
    );
  BU2_U0_transmitter_recoder_mux0414_f5 : MUXF5
    port map (
      I0 => BU2_N5183,
      I1 => BU2_N5182,
      S => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(29),
      O => BU2_U0_transmitter_recoder_mux0414
    );
  BU2_U0_transmitter_recoder_mux04142 : LUT4
    generic map(
      INIT => X"3D39"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_2_74,
      I1 => BU2_U0_transmitter_state_machine_state_0_0_76,
      I2 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I3 => BU2_U0_transmitter_filter3_txd_out(5),
      O => BU2_N5183
    );
  BU2_U0_transmitter_recoder_mux04141 : LUT4
    generic map(
      INIT => X"FFD9"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_2_74,
      I1 => BU2_U0_transmitter_state_machine_state_0_0_76,
      I2 => BU2_U0_transmitter_filter3_txd_out(5),
      I3 => BU2_U0_transmitter_state_machine_state_0_1_75,
      O => BU2_N5182
    );
  BU2_U0_transmitter_recoder_mux0447_f5 : MUXF5
    port map (
      I0 => BU2_N5181,
      I1 => BU2_N5180,
      S => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(5),
      O => BU2_U0_transmitter_recoder_mux0447
    );
  BU2_U0_transmitter_recoder_mux04472 : LUT4
    generic map(
      INIT => X"3D39"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_2_74,
      I1 => BU2_U0_transmitter_state_machine_state_0_0_76,
      I2 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I3 => BU2_U0_transmitter_filter0_txd_out(5),
      O => BU2_N5181
    );
  BU2_U0_transmitter_recoder_mux04471 : LUT4
    generic map(
      INIT => X"FFD9"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_2_74,
      I1 => BU2_U0_transmitter_state_machine_state_0_0_76,
      I2 => BU2_U0_transmitter_filter0_txd_out(5),
      I3 => BU2_U0_transmitter_state_machine_state_0_1_75,
      O => BU2_N5180
    );
  BU2_U0_transmitter_recoder_mux0394_f5 : MUXF5
    port map (
      I0 => BU2_N5179,
      I1 => BU2_N5178,
      S => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(13),
      O => BU2_U0_transmitter_recoder_mux0394
    );
  BU2_U0_transmitter_recoder_mux03942 : LUT4
    generic map(
      INIT => X"3D39"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_2_74,
      I1 => BU2_U0_transmitter_state_machine_state_0_0_76,
      I2 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I3 => BU2_U0_transmitter_filter1_txd_out(5),
      O => BU2_N5179
    );
  BU2_U0_transmitter_recoder_mux03941 : LUT4
    generic map(
      INIT => X"FFD9"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_2_74,
      I1 => BU2_U0_transmitter_state_machine_state_0_0_76,
      I2 => BU2_U0_transmitter_filter1_txd_out(5),
      I3 => BU2_U0_transmitter_state_machine_state_0_1_75,
      O => BU2_N5178
    );
  BU2_U0_transmitter_recoder_mux0449_f5 : MUXF5
    port map (
      I0 => BU2_N5177,
      I1 => BU2_N5176,
      S => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(31),
      O => BU2_U0_transmitter_recoder_mux0449
    );
  BU2_U0_transmitter_recoder_mux04492 : LUT4
    generic map(
      INIT => X"5141"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I1 => BU2_U0_transmitter_state_machine_state_1_2_72,
      I2 => BU2_U0_transmitter_state_machine_state_1_0_43,
      I3 => BU2_U0_transmitter_filter7_txd_out(7),
      O => BU2_N5177
    );
  BU2_U0_transmitter_recoder_mux04491 : LUT4
    generic map(
      INIT => X"F1E1"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I1 => BU2_U0_transmitter_state_machine_state_1_2_72,
      I2 => BU2_U0_transmitter_state_machine_state_1_0_43,
      I3 => BU2_U0_transmitter_filter7_txd_out(7),
      O => BU2_N5176
    );
  BU2_U0_transmitter_recoder_mux0439_f5 : MUXF5
    port map (
      I0 => BU2_N5175,
      I1 => BU2_N5174,
      S => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(23),
      O => BU2_U0_transmitter_recoder_mux0439
    );
  BU2_U0_transmitter_recoder_mux04392 : LUT4
    generic map(
      INIT => X"5141"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I1 => BU2_U0_transmitter_state_machine_state_1_2_72,
      I2 => BU2_U0_transmitter_state_machine_state_1_0_43,
      I3 => BU2_U0_transmitter_filter6_txd_out(7),
      O => BU2_N5175
    );
  BU2_U0_transmitter_recoder_mux04391 : LUT4
    generic map(
      INIT => X"F1E1"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I1 => BU2_U0_transmitter_state_machine_state_1_2_72,
      I2 => BU2_U0_transmitter_state_machine_state_1_0_43,
      I3 => BU2_U0_transmitter_filter6_txd_out(7),
      O => BU2_N5174
    );
  BU2_U0_transmitter_recoder_mux0430_f5 : MUXF5
    port map (
      I0 => BU2_N5173,
      I1 => BU2_N5172,
      S => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(15),
      O => BU2_U0_transmitter_recoder_mux0430
    );
  BU2_U0_transmitter_recoder_mux04302 : LUT4
    generic map(
      INIT => X"5141"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I1 => BU2_U0_transmitter_state_machine_state_1_2_72,
      I2 => BU2_U0_transmitter_state_machine_state_1_0_43,
      I3 => BU2_U0_transmitter_filter5_txd_out(7),
      O => BU2_N5173
    );
  BU2_U0_transmitter_recoder_mux04301 : LUT4
    generic map(
      INIT => X"F1E1"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I1 => BU2_U0_transmitter_state_machine_state_1_2_72,
      I2 => BU2_U0_transmitter_state_machine_state_1_0_43,
      I3 => BU2_U0_transmitter_filter5_txd_out(7),
      O => BU2_N5172
    );
  BU2_U0_transmitter_recoder_mux0424_f5 : MUXF5
    port map (
      I0 => BU2_N5171,
      I1 => BU2_N5170,
      S => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(7),
      O => BU2_U0_transmitter_recoder_mux0424
    );
  BU2_U0_transmitter_recoder_mux04242 : LUT4
    generic map(
      INIT => X"5141"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I1 => BU2_U0_transmitter_state_machine_state_1_2_72,
      I2 => BU2_U0_transmitter_state_machine_state_1_0_43,
      I3 => BU2_U0_transmitter_filter4_txd_out(7),
      O => BU2_N5171
    );
  BU2_U0_transmitter_recoder_mux04241 : LUT4
    generic map(
      INIT => X"F1E1"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I1 => BU2_U0_transmitter_state_machine_state_1_2_72,
      I2 => BU2_U0_transmitter_state_machine_state_1_0_43,
      I3 => BU2_U0_transmitter_filter4_txd_out(7),
      O => BU2_N5170
    );
  BU2_U0_transmitter_recoder_mux0443_f5 : MUXF5
    port map (
      I0 => BU2_N5169,
      I1 => BU2_N5168,
      S => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(29),
      O => BU2_U0_transmitter_recoder_mux0443
    );
  BU2_U0_transmitter_recoder_mux04432 : LUT4
    generic map(
      INIT => X"3D39"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_2_72,
      I1 => BU2_U0_transmitter_state_machine_state_1_0_43,
      I2 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I3 => BU2_U0_transmitter_filter7_txd_out(5),
      O => BU2_N5169
    );
  BU2_U0_transmitter_recoder_mux04431 : LUT4
    generic map(
      INIT => X"FFD9"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_2_72,
      I1 => BU2_U0_transmitter_state_machine_state_1_0_43,
      I2 => BU2_U0_transmitter_filter7_txd_out(5),
      I3 => BU2_U0_transmitter_state_machine_state_1_1_73,
      O => BU2_N5168
    );
  BU2_U0_transmitter_recoder_mux0434_f5 : MUXF5
    port map (
      I0 => BU2_N5167,
      I1 => BU2_N5166,
      S => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(21),
      O => BU2_U0_transmitter_recoder_mux0434
    );
  BU2_U0_transmitter_recoder_mux04342 : LUT4
    generic map(
      INIT => X"3D39"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_2_72,
      I1 => BU2_U0_transmitter_state_machine_state_1_0_43,
      I2 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I3 => BU2_U0_transmitter_filter6_txd_out(5),
      O => BU2_N5167
    );
  BU2_U0_transmitter_recoder_mux04341 : LUT4
    generic map(
      INIT => X"FFD9"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_2_72,
      I1 => BU2_U0_transmitter_state_machine_state_1_0_43,
      I2 => BU2_U0_transmitter_filter6_txd_out(5),
      I3 => BU2_U0_transmitter_state_machine_state_1_1_73,
      O => BU2_N5166
    );
  BU2_U0_transmitter_recoder_mux0426_f5 : MUXF5
    port map (
      I0 => BU2_N5165,
      I1 => BU2_N5164,
      S => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(13),
      O => BU2_U0_transmitter_recoder_mux0426
    );
  BU2_U0_transmitter_recoder_mux04262 : LUT4
    generic map(
      INIT => X"3D39"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_2_72,
      I1 => BU2_U0_transmitter_state_machine_state_1_0_43,
      I2 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I3 => BU2_U0_transmitter_filter5_txd_out(5),
      O => BU2_N5165
    );
  BU2_U0_transmitter_recoder_mux04261 : LUT4
    generic map(
      INIT => X"FFD9"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_2_72,
      I1 => BU2_U0_transmitter_state_machine_state_1_0_43,
      I2 => BU2_U0_transmitter_filter5_txd_out(5),
      I3 => BU2_U0_transmitter_state_machine_state_1_1_73,
      O => BU2_N5164
    );
  BU2_U0_transmitter_recoder_mux0420_f5 : MUXF5
    port map (
      I0 => BU2_N5163,
      I1 => BU2_N5162,
      S => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(5),
      O => BU2_U0_transmitter_recoder_mux0420
    );
  BU2_U0_transmitter_recoder_mux04202 : LUT4
    generic map(
      INIT => X"3D39"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_2_72,
      I1 => BU2_U0_transmitter_state_machine_state_1_0_43,
      I2 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I3 => BU2_U0_transmitter_filter4_txd_out(5),
      O => BU2_N5163
    );
  BU2_U0_transmitter_recoder_mux04201 : LUT4
    generic map(
      INIT => X"FFD9"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_2_72,
      I1 => BU2_U0_transmitter_state_machine_state_1_0_43,
      I2 => BU2_U0_transmitter_filter4_txd_out(5),
      I3 => BU2_U0_transmitter_state_machine_state_1_1_73,
      O => BU2_N5162
    );
  BU2_U0_transmitter_recoder_mux0397_f5 : MUXF5
    port map (
      I0 => BU2_N5161,
      I1 => BU2_N5160,
      S => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(20),
      O => BU2_U0_transmitter_recoder_mux0397
    );
  BU2_U0_transmitter_recoder_mux03972 : LUT4
    generic map(
      INIT => X"54FF"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I1 => BU2_U0_transmitter_filter2_txd_out(4),
      I2 => BU2_U0_transmitter_state_machine_state_0_2_74,
      I3 => BU2_U0_transmitter_state_machine_state_0_0_76,
      O => BU2_N5161
    );
  BU2_U0_transmitter_recoder_mux03971 : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I1 => BU2_U0_transmitter_state_machine_state_0_0_76,
      I2 => BU2_U0_transmitter_state_machine_state_0_2_74,
      I3 => BU2_U0_transmitter_filter2_txd_out(4),
      O => BU2_N5160
    );
  BU2_U0_transmitter_recoder_mux0402_f5 : MUXF5
    port map (
      I0 => BU2_N5159,
      I1 => BU2_N5158,
      S => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(18),
      O => BU2_U0_transmitter_recoder_mux0402
    );
  BU2_U0_transmitter_recoder_mux04022 : LUT4
    generic map(
      INIT => X"54FF"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I1 => BU2_U0_transmitter_filter2_txd_out(2),
      I2 => BU2_U0_transmitter_state_machine_state_0_2_74,
      I3 => BU2_U0_transmitter_state_machine_state_0_0_76,
      O => BU2_N5159
    );
  BU2_U0_transmitter_recoder_mux04021 : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I1 => BU2_U0_transmitter_state_machine_state_0_0_76,
      I2 => BU2_U0_transmitter_state_machine_state_0_2_74,
      I3 => BU2_U0_transmitter_filter2_txd_out(2),
      O => BU2_N5158
    );
  BU2_U0_transmitter_recoder_mux0408_f5 : MUXF5
    port map (
      I0 => BU2_N5157,
      I1 => BU2_N5156,
      S => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(26),
      O => BU2_U0_transmitter_recoder_mux0408
    );
  BU2_U0_transmitter_recoder_mux04082 : LUT4
    generic map(
      INIT => X"54FF"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I1 => BU2_U0_transmitter_filter3_txd_out(2),
      I2 => BU2_U0_transmitter_state_machine_state_0_2_74,
      I3 => BU2_U0_transmitter_state_machine_state_0_0_76,
      O => BU2_N5157
    );
  BU2_U0_transmitter_recoder_mux04081 : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I1 => BU2_U0_transmitter_state_machine_state_0_0_76,
      I2 => BU2_U0_transmitter_state_machine_state_0_2_74,
      I3 => BU2_U0_transmitter_filter3_txd_out(2),
      O => BU2_N5156
    );
  BU2_U0_transmitter_recoder_mux0412_f5 : MUXF5
    port map (
      I0 => BU2_N5155,
      I1 => BU2_N5154,
      S => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(28),
      O => BU2_U0_transmitter_recoder_mux0412
    );
  BU2_U0_transmitter_recoder_mux04122 : LUT4
    generic map(
      INIT => X"54FF"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I1 => BU2_U0_transmitter_filter3_txd_out(4),
      I2 => BU2_U0_transmitter_state_machine_state_0_2_74,
      I3 => BU2_U0_transmitter_state_machine_state_0_0_76,
      O => BU2_N5155
    );
  BU2_U0_transmitter_recoder_mux04121 : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I1 => BU2_U0_transmitter_state_machine_state_0_0_76,
      I2 => BU2_U0_transmitter_state_machine_state_0_2_74,
      I3 => BU2_U0_transmitter_filter3_txd_out(4),
      O => BU2_N5154
    );
  BU2_U0_transmitter_recoder_mux0438_f5 : MUXF5
    port map (
      I0 => BU2_N5153,
      I1 => BU2_N5152,
      S => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(2),
      O => BU2_U0_transmitter_recoder_mux0438
    );
  BU2_U0_transmitter_recoder_mux04382 : LUT4
    generic map(
      INIT => X"54FF"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I1 => BU2_U0_transmitter_filter0_txd_out(2),
      I2 => BU2_U0_transmitter_state_machine_state_0_2_74,
      I3 => BU2_U0_transmitter_state_machine_state_0_0_76,
      O => BU2_N5153
    );
  BU2_U0_transmitter_recoder_mux04381 : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I1 => BU2_U0_transmitter_state_machine_state_0_0_76,
      I2 => BU2_U0_transmitter_state_machine_state_0_2_74,
      I3 => BU2_U0_transmitter_filter0_txd_out(2),
      O => BU2_N5152
    );
  BU2_U0_transmitter_recoder_mux0444_f5 : MUXF5
    port map (
      I0 => BU2_N5151,
      I1 => BU2_N5150,
      S => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(4),
      O => BU2_U0_transmitter_recoder_mux0444
    );
  BU2_U0_transmitter_recoder_mux04442 : LUT4
    generic map(
      INIT => X"54FF"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I1 => BU2_U0_transmitter_filter0_txd_out(4),
      I2 => BU2_U0_transmitter_state_machine_state_0_2_74,
      I3 => BU2_U0_transmitter_state_machine_state_0_0_76,
      O => BU2_N5151
    );
  BU2_U0_transmitter_recoder_mux04441 : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I1 => BU2_U0_transmitter_state_machine_state_0_0_76,
      I2 => BU2_U0_transmitter_state_machine_state_0_2_74,
      I3 => BU2_U0_transmitter_filter0_txd_out(4),
      O => BU2_N5150
    );
  BU2_U0_transmitter_recoder_mux0463_f5 : MUXF5
    port map (
      I0 => BU2_N5149,
      I1 => BU2_N5148,
      S => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(10),
      O => BU2_U0_transmitter_recoder_mux0463
    );
  BU2_U0_transmitter_recoder_mux04632 : LUT4
    generic map(
      INIT => X"54FF"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I1 => BU2_U0_transmitter_filter1_txd_out(2),
      I2 => BU2_U0_transmitter_state_machine_state_0_2_74,
      I3 => BU2_U0_transmitter_state_machine_state_0_0_76,
      O => BU2_N5149
    );
  BU2_U0_transmitter_recoder_mux04631 : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I1 => BU2_U0_transmitter_state_machine_state_0_0_76,
      I2 => BU2_U0_transmitter_state_machine_state_0_2_74,
      I3 => BU2_U0_transmitter_filter1_txd_out(2),
      O => BU2_N5148
    );
  BU2_U0_transmitter_recoder_mux0393_f5 : MUXF5
    port map (
      I0 => BU2_N5147,
      I1 => BU2_N5146,
      S => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(12),
      O => BU2_U0_transmitter_recoder_mux0393
    );
  BU2_U0_transmitter_recoder_mux03932 : LUT4
    generic map(
      INIT => X"54FF"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I1 => BU2_U0_transmitter_filter1_txd_out(4),
      I2 => BU2_U0_transmitter_state_machine_state_0_2_74,
      I3 => BU2_U0_transmitter_state_machine_state_0_0_76,
      O => BU2_N5147
    );
  BU2_U0_transmitter_recoder_mux03931 : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I1 => BU2_U0_transmitter_state_machine_state_0_0_76,
      I2 => BU2_U0_transmitter_state_machine_state_0_2_74,
      I3 => BU2_U0_transmitter_filter1_txd_out(4),
      O => BU2_N5146
    );
  BU2_U0_transmitter_recoder_mux0448_f5 : MUXF5
    port map (
      I0 => BU2_N5145,
      I1 => BU2_N5144,
      S => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(26),
      O => BU2_U0_transmitter_recoder_mux0448
    );
  BU2_U0_transmitter_recoder_mux04482 : LUT4
    generic map(
      INIT => X"54FF"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I1 => BU2_U0_transmitter_filter7_txd_out(2),
      I2 => BU2_U0_transmitter_state_machine_state_1_2_72,
      I3 => BU2_U0_transmitter_state_machine_state_1_0_43,
      O => BU2_N5145
    );
  BU2_U0_transmitter_recoder_mux04481 : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I1 => BU2_U0_transmitter_state_machine_state_1_0_43,
      I2 => BU2_U0_transmitter_state_machine_state_1_2_72,
      I3 => BU2_U0_transmitter_filter7_txd_out(2),
      O => BU2_N5144
    );
  BU2_U0_transmitter_recoder_mux0440_f5 : MUXF5
    port map (
      I0 => BU2_N5143,
      I1 => BU2_N5142,
      S => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(28),
      O => BU2_U0_transmitter_recoder_mux0440
    );
  BU2_U0_transmitter_recoder_mux04402 : LUT4
    generic map(
      INIT => X"54FF"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I1 => BU2_U0_transmitter_filter7_txd_out(4),
      I2 => BU2_U0_transmitter_state_machine_state_1_2_72,
      I3 => BU2_U0_transmitter_state_machine_state_1_0_43,
      O => BU2_N5143
    );
  BU2_U0_transmitter_recoder_mux04401 : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I1 => BU2_U0_transmitter_state_machine_state_1_0_43,
      I2 => BU2_U0_transmitter_state_machine_state_1_2_72,
      I3 => BU2_U0_transmitter_filter7_txd_out(4),
      O => BU2_N5142
    );
  BU2_U0_transmitter_recoder_mux0431_f5 : MUXF5
    port map (
      I0 => BU2_N5141,
      I1 => BU2_N5140,
      S => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(20),
      O => BU2_U0_transmitter_recoder_mux0431
    );
  BU2_U0_transmitter_recoder_mux04312 : LUT4
    generic map(
      INIT => X"54FF"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I1 => BU2_U0_transmitter_filter6_txd_out(4),
      I2 => BU2_U0_transmitter_state_machine_state_1_2_72,
      I3 => BU2_U0_transmitter_state_machine_state_1_0_43,
      O => BU2_N5141
    );
  BU2_U0_transmitter_recoder_mux04311 : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I1 => BU2_U0_transmitter_state_machine_state_1_0_43,
      I2 => BU2_U0_transmitter_state_machine_state_1_2_72,
      I3 => BU2_U0_transmitter_filter6_txd_out(4),
      O => BU2_N5140
    );
  BU2_U0_transmitter_recoder_mux0425_f5 : MUXF5
    port map (
      I0 => BU2_N5139,
      I1 => BU2_N5138,
      S => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(12),
      O => BU2_U0_transmitter_recoder_mux0425
    );
  BU2_U0_transmitter_recoder_mux04252 : LUT4
    generic map(
      INIT => X"54FF"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I1 => BU2_U0_transmitter_filter5_txd_out(4),
      I2 => BU2_U0_transmitter_state_machine_state_1_2_72,
      I3 => BU2_U0_transmitter_state_machine_state_1_0_43,
      O => BU2_N5139
    );
  BU2_U0_transmitter_recoder_mux04251 : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I1 => BU2_U0_transmitter_state_machine_state_1_0_43,
      I2 => BU2_U0_transmitter_state_machine_state_1_2_72,
      I3 => BU2_U0_transmitter_filter5_txd_out(4),
      O => BU2_N5138
    );
  BU2_U0_transmitter_recoder_mux0427_f5 : MUXF5
    port map (
      I0 => BU2_N5137,
      I1 => BU2_N5136,
      S => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(18),
      O => BU2_U0_transmitter_recoder_mux0427
    );
  BU2_U0_transmitter_recoder_mux04272 : LUT4
    generic map(
      INIT => X"54FF"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I1 => BU2_U0_transmitter_filter6_txd_out(2),
      I2 => BU2_U0_transmitter_state_machine_state_1_2_72,
      I3 => BU2_U0_transmitter_state_machine_state_1_0_43,
      O => BU2_N5137
    );
  BU2_U0_transmitter_recoder_mux04271 : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I1 => BU2_U0_transmitter_state_machine_state_1_0_43,
      I2 => BU2_U0_transmitter_state_machine_state_1_2_72,
      I3 => BU2_U0_transmitter_filter6_txd_out(2),
      O => BU2_N5136
    );
  BU2_U0_transmitter_recoder_mux0421_f5 : MUXF5
    port map (
      I0 => BU2_N5135,
      I1 => BU2_N5134,
      S => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(10),
      O => BU2_U0_transmitter_recoder_mux0421
    );
  BU2_U0_transmitter_recoder_mux04212 : LUT4
    generic map(
      INIT => X"54FF"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I1 => BU2_U0_transmitter_filter5_txd_out(2),
      I2 => BU2_U0_transmitter_state_machine_state_1_2_72,
      I3 => BU2_U0_transmitter_state_machine_state_1_0_43,
      O => BU2_N5135
    );
  BU2_U0_transmitter_recoder_mux04211 : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I1 => BU2_U0_transmitter_state_machine_state_1_0_43,
      I2 => BU2_U0_transmitter_state_machine_state_1_2_72,
      I3 => BU2_U0_transmitter_filter5_txd_out(2),
      O => BU2_N5134
    );
  BU2_U0_transmitter_recoder_mux0418_f5 : MUXF5
    port map (
      I0 => BU2_N5133,
      I1 => BU2_N5132,
      S => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(4),
      O => BU2_U0_transmitter_recoder_mux0418
    );
  BU2_U0_transmitter_recoder_mux04182 : LUT4
    generic map(
      INIT => X"54FF"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I1 => BU2_U0_transmitter_filter4_txd_out(4),
      I2 => BU2_U0_transmitter_state_machine_state_1_2_72,
      I3 => BU2_U0_transmitter_state_machine_state_1_0_43,
      O => BU2_N5133
    );
  BU2_U0_transmitter_recoder_mux04181 : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I1 => BU2_U0_transmitter_state_machine_state_1_0_43,
      I2 => BU2_U0_transmitter_state_machine_state_1_2_72,
      I3 => BU2_U0_transmitter_filter4_txd_out(4),
      O => BU2_N5132
    );
  BU2_U0_transmitter_recoder_mux0415_f5 : MUXF5
    port map (
      I0 => BU2_N5131,
      I1 => BU2_N5130,
      S => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(2),
      O => BU2_U0_transmitter_recoder_mux0415
    );
  BU2_U0_transmitter_recoder_mux04152 : LUT4
    generic map(
      INIT => X"54FF"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I1 => BU2_U0_transmitter_filter4_txd_out(2),
      I2 => BU2_U0_transmitter_state_machine_state_1_2_72,
      I3 => BU2_U0_transmitter_state_machine_state_1_0_43,
      O => BU2_N5131
    );
  BU2_U0_transmitter_recoder_mux04151 : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I1 => BU2_U0_transmitter_state_machine_state_1_0_43,
      I2 => BU2_U0_transmitter_state_machine_state_1_2_72,
      I3 => BU2_U0_transmitter_filter4_txd_out(2),
      O => BU2_N5130
    );
  BU2_U0_receiver_deskew_state_mux0044_0_51_f5 : MUXF5
    port map (
      I0 => BU2_N5129,
      I1 => BU2_N5128,
      S => BU2_U0_receiver_deskew_state_state_1_1_44,
      O => BU2_U0_receiver_deskew_state_mux0044_0_map2160
    );
  BU2_U0_receiver_deskew_state_mux0044_0_512 : LUT4
    generic map(
      INIT => X"F080"
    )
    port map (
      I0 => NlwRenamedSig_OI_align_status,
      I1 => BU2_U0_receiver_deskew_state_deskew_error(1),
      I2 => BU2_U0_receiver_deskew_state_deskew_error(0),
      I3 => BU2_U0_receiver_deskew_state_got_align(1),
      O => BU2_N5129
    );
  BU2_U0_receiver_deskew_state_mux0044_0_511 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => BU2_U0_receiver_deskew_state_deskew_error(0),
      I1 => BU2_U0_receiver_deskew_state_got_align(1),
      O => BU2_N5128
    );
  BU2_U0_receiver_recoder_and0020_SW0_f5 : MUXF5
    port map (
      I0 => BU2_N1,
      I1 => BU2_N5115,
      S => BU2_U0_receiver_recoder_rxd_pipe(23),
      O => BU2_N4488
    );
  BU2_U0_receiver_recoder_and0020_SW01 : LUT4
    generic map(
      INIT => X"FFBF"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(22),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(21),
      I2 => BU2_U0_receiver_recoder_rxc_pipe(2),
      I3 => BU2_U0_receiver_recoder_code_error_pipe(2),
      O => BU2_N5115
    );
  BU2_U0_receiver_recoder_or003128_f5 : MUXF5
    port map (
      I0 => BU2_N5104,
      I1 => BU2_N1,
      S => BU2_U0_receiver_recoder_rxd_pipe(55),
      O => BU2_U0_receiver_recoder_or0031_map2652
    );
  BU2_U0_receiver_recoder_or0031281 : LUT4
    generic map(
      INIT => X"FF7F"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxc_pipe(6),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(53),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(52),
      I3 => BU2_U0_receiver_recoder_rxd_pipe(48),
      O => BU2_N5104
    );
  BU2_U0_receiver_or000130_f5 : MUXF5
    port map (
      I0 => BU2_N5094,
      I1 => BU2_N5093,
      S => mgt_rxdata_115(31),
      O => BU2_U0_receiver_or0001_map1491
    );
  BU2_U0_receiver_or0001302 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => mgt_rxdata_115(24),
      I1 => mgt_rxdata_115(25),
      O => BU2_N5094
    );
  BU2_U0_receiver_or0001301 : LUT4
    generic map(
      INIT => X"5F4C"
    )
    port map (
      I0 => mgt_rxdata_115(30),
      I1 => mgt_rxdata_115(25),
      I2 => mgt_rxdata_115(29),
      I3 => mgt_rxdata_115(24),
      O => BU2_N5093
    );
  BU2_U0_receiver_or000030_f5 : MUXF5
    port map (
      I0 => BU2_N5091,
      I1 => BU2_N5090,
      S => mgt_rxdata_115(9),
      O => BU2_U0_receiver_or0000_map1463
    );
  BU2_U0_receiver_or0000302 : LUT4
    generic map(
      INIT => X"4CCC"
    )
    port map (
      I0 => mgt_rxdata_115(15),
      I1 => mgt_rxdata_115(8),
      I2 => mgt_rxdata_115(14),
      I3 => mgt_rxdata_115(13),
      O => BU2_N5091
    );
  BU2_U0_receiver_or0000301 : LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => mgt_rxdata_115(15),
      I1 => mgt_rxdata_115(14),
      I2 => mgt_rxdata_115(13),
      O => BU2_N5090
    );
  BU2_U0_receiver_deskew_state_mux0034123_f5 : MUXF5
    port map (
      I0 => BU2_mdio_tri,
      I1 => BU2_N5089,
      S => BU2_U0_receiver_deskew_state_mux00341_map1447,
      O => BU2_N379
    );
  BU2_U0_receiver_deskew_state_mux00341231 : LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => mgt_rxdata_115(10),
      I1 => mgt_rxdata_115(12),
      I2 => mgt_rxdata_115(14),
      I3 => mgt_rxdata_115(13),
      O => BU2_N5089
    );
  BU2_U0_receiver_deskew_state_mux0034120_f5 : MUXF5
    port map (
      I0 => BU2_N5088,
      I1 => BU2_mdio_tri,
      S => mgt_rxdata_115(9),
      O => BU2_U0_receiver_deskew_state_mux00341_map1447
    );
  BU2_U0_receiver_deskew_state_mux00341201 : LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      I0 => mgt_rxdata_115(15),
      I1 => mgt_rxdata_115(8),
      I2 => mgt_rxcharisk_116(1),
      I3 => mgt_rxdata_115(11),
      O => BU2_N5088
    );
  BU2_U0_receiver_deskew_state_mux0035122_f5 : MUXF5
    port map (
      I0 => BU2_mdio_tri,
      I1 => BU2_N5087,
      S => BU2_U0_receiver_deskew_state_mux00351_map1436,
      O => BU2_N355
    );
  BU2_U0_receiver_deskew_state_mux00351221 : LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => mgt_rxdata_115(4),
      I1 => mgt_rxdata_115(3),
      I2 => mgt_rxdata_115(5),
      I3 => mgt_rxdata_115(7),
      O => BU2_N5087
    );
  BU2_U0_receiver_deskew_state_mux0035119_f5 : MUXF5
    port map (
      I0 => BU2_mdio_tri,
      I1 => BU2_N5086,
      S => mgt_rxdata_115(6),
      O => BU2_U0_receiver_deskew_state_mux00351_map1436
    );
  BU2_U0_receiver_deskew_state_mux00351191 : LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      I0 => mgt_rxdata_115(0),
      I1 => mgt_rxdata_115(1),
      I2 => mgt_rxcharisk_116(0),
      I3 => mgt_rxdata_115(2),
      O => BU2_N5086
    );
  BU2_U0_receiver_recoder_and006216_f5 : MUXF5
    port map (
      I0 => BU2_mdio_tri,
      I1 => BU2_N5085,
      S => BU2_U0_receiver_recoder_and0062_map1425,
      O => BU2_U0_receiver_recoder_and0062
    );
  BU2_U0_receiver_recoder_and0062161 : LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => mgt_rxdata_115(4),
      I1 => mgt_rxdata_115(3),
      I2 => mgt_rxdata_115(2),
      I3 => mgt_rxdata_115(1),
      O => BU2_N5085
    );
  BU2_U0_receiver_recoder_and006214_f5 : MUXF5
    port map (
      I0 => BU2_mdio_tri,
      I1 => BU2_N5084,
      S => mgt_rxdata_115(7),
      O => BU2_U0_receiver_recoder_and0062_map1425
    );
  BU2_U0_receiver_recoder_and0062141 : LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => mgt_rxdata_115(0),
      I1 => mgt_rxcharisk_116(0),
      I2 => mgt_rxdata_115(6),
      I3 => mgt_rxdata_115(5),
      O => BU2_N5084
    );
  BU2_U0_receiver_recoder_and006016_f5 : MUXF5
    port map (
      I0 => BU2_mdio_tri,
      I1 => BU2_N5083,
      S => BU2_U0_receiver_recoder_and0060_map1416,
      O => BU2_U0_receiver_recoder_and0060
    );
  BU2_U0_receiver_recoder_and0060161 : LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => mgt_rxdata_115(60),
      I1 => mgt_rxdata_115(59),
      I2 => mgt_rxdata_115(58),
      I3 => mgt_rxdata_115(57),
      O => BU2_N5083
    );
  BU2_U0_receiver_recoder_and006014_f5 : MUXF5
    port map (
      I0 => BU2_mdio_tri,
      I1 => BU2_N5082,
      S => mgt_rxdata_115(63),
      O => BU2_U0_receiver_recoder_and0060_map1416
    );
  BU2_U0_receiver_recoder_and0060141 : LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => mgt_rxdata_115(56),
      I1 => mgt_rxcharisk_116(7),
      I2 => mgt_rxdata_115(62),
      I3 => mgt_rxdata_115(61),
      O => BU2_N5082
    );
  BU2_U0_receiver_recoder_and005816_f5 : MUXF5
    port map (
      I0 => BU2_mdio_tri,
      I1 => BU2_N5081,
      S => BU2_U0_receiver_recoder_and0058_map1407,
      O => BU2_U0_receiver_recoder_and0058
    );
  BU2_U0_receiver_recoder_and0058161 : LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => mgt_rxdata_115(52),
      I1 => mgt_rxdata_115(51),
      I2 => mgt_rxdata_115(50),
      I3 => mgt_rxdata_115(49),
      O => BU2_N5081
    );
  BU2_U0_receiver_recoder_and005814_f5 : MUXF5
    port map (
      I0 => BU2_mdio_tri,
      I1 => BU2_N5080,
      S => mgt_rxdata_115(55),
      O => BU2_U0_receiver_recoder_and0058_map1407
    );
  BU2_U0_receiver_recoder_and0058141 : LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => mgt_rxdata_115(48),
      I1 => mgt_rxcharisk_116(6),
      I2 => mgt_rxdata_115(54),
      I3 => mgt_rxdata_115(53),
      O => BU2_N5080
    );
  BU2_U0_receiver_recoder_and005916_f5 : MUXF5
    port map (
      I0 => BU2_mdio_tri,
      I1 => BU2_N5079,
      S => BU2_U0_receiver_recoder_and0059_map1398,
      O => BU2_U0_receiver_recoder_and0059
    );
  BU2_U0_receiver_recoder_and0059161 : LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => mgt_rxdata_115(44),
      I1 => mgt_rxdata_115(43),
      I2 => mgt_rxdata_115(42),
      I3 => mgt_rxdata_115(41),
      O => BU2_N5079
    );
  BU2_U0_receiver_recoder_and005914_f5 : MUXF5
    port map (
      I0 => BU2_mdio_tri,
      I1 => BU2_N5078,
      S => mgt_rxdata_115(47),
      O => BU2_U0_receiver_recoder_and0059_map1398
    );
  BU2_U0_receiver_recoder_and0059141 : LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => mgt_rxdata_115(40),
      I1 => mgt_rxcharisk_116(5),
      I2 => mgt_rxdata_115(46),
      I3 => mgt_rxdata_115(45),
      O => BU2_N5078
    );
  BU2_U0_receiver_recoder_and005716_f5 : MUXF5
    port map (
      I0 => BU2_mdio_tri,
      I1 => BU2_N5077,
      S => BU2_U0_receiver_recoder_and0057_map1389,
      O => BU2_U0_receiver_recoder_and0057
    );
  BU2_U0_receiver_recoder_and0057161 : LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => mgt_rxdata_115(28),
      I1 => mgt_rxdata_115(27),
      I2 => mgt_rxdata_115(26),
      I3 => mgt_rxdata_115(25),
      O => BU2_N5077
    );
  BU2_U0_receiver_recoder_and005714_f5 : MUXF5
    port map (
      I0 => BU2_mdio_tri,
      I1 => BU2_N5076,
      S => mgt_rxdata_115(31),
      O => BU2_U0_receiver_recoder_and0057_map1389
    );
  BU2_U0_receiver_recoder_and0057141 : LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => mgt_rxdata_115(24),
      I1 => mgt_rxcharisk_116(3),
      I2 => mgt_rxdata_115(30),
      I3 => mgt_rxdata_115(29),
      O => BU2_N5076
    );
  BU2_U0_receiver_recoder_and005616_f5 : MUXF5
    port map (
      I0 => BU2_mdio_tri,
      I1 => BU2_N5075,
      S => BU2_U0_receiver_recoder_and0056_map1380,
      O => BU2_U0_receiver_recoder_and0056
    );
  BU2_U0_receiver_recoder_and0056161 : LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => mgt_rxdata_115(36),
      I1 => mgt_rxdata_115(35),
      I2 => mgt_rxdata_115(34),
      I3 => mgt_rxdata_115(33),
      O => BU2_N5075
    );
  BU2_U0_receiver_recoder_and005614_f5 : MUXF5
    port map (
      I0 => BU2_mdio_tri,
      I1 => BU2_N5074,
      S => mgt_rxdata_115(39),
      O => BU2_U0_receiver_recoder_and0056_map1380
    );
  BU2_U0_receiver_recoder_and0056141 : LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => mgt_rxdata_115(32),
      I1 => mgt_rxcharisk_116(4),
      I2 => mgt_rxdata_115(38),
      I3 => mgt_rxdata_115(37),
      O => BU2_N5074
    );
  BU2_U0_receiver_recoder_and005516_f5 : MUXF5
    port map (
      I0 => BU2_mdio_tri,
      I1 => BU2_N5073,
      S => BU2_U0_receiver_recoder_and0055_map1371,
      O => BU2_U0_receiver_recoder_and0055
    );
  BU2_U0_receiver_recoder_and0055161 : LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => mgt_rxdata_115(12),
      I1 => mgt_rxdata_115(11),
      I2 => mgt_rxdata_115(10),
      I3 => mgt_rxdata_115(9),
      O => BU2_N5073
    );
  BU2_U0_receiver_recoder_and005514_f5 : MUXF5
    port map (
      I0 => BU2_mdio_tri,
      I1 => BU2_N5072,
      S => mgt_rxdata_115(8),
      O => BU2_U0_receiver_recoder_and0055_map1371
    );
  BU2_U0_receiver_recoder_and0055141 : LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => mgt_rxcharisk_116(1),
      I1 => mgt_rxdata_115(15),
      I2 => mgt_rxdata_115(14),
      I3 => mgt_rxdata_115(13),
      O => BU2_N5072
    );
  BU2_U0_receiver_recoder_and005416_f5 : MUXF5
    port map (
      I0 => BU2_mdio_tri,
      I1 => BU2_N5071,
      S => BU2_U0_receiver_recoder_and0054_map1362,
      O => BU2_U0_receiver_recoder_and0054
    );
  BU2_U0_receiver_recoder_and0054161 : LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => mgt_rxdata_115(20),
      I1 => mgt_rxdata_115(19),
      I2 => mgt_rxdata_115(18),
      I3 => mgt_rxdata_115(17),
      O => BU2_N5071
    );
  BU2_U0_receiver_recoder_and005414_f5 : MUXF5
    port map (
      I0 => BU2_mdio_tri,
      I1 => BU2_N5070,
      S => mgt_rxdata_115(23),
      O => BU2_U0_receiver_recoder_and0054_map1362
    );
  BU2_U0_receiver_recoder_and0054141 : LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => mgt_rxdata_115(16),
      I1 => mgt_rxcharisk_116(2),
      I2 => mgt_rxdata_115(22),
      I3 => mgt_rxdata_115(21),
      O => BU2_N5070
    );
  BU2_U0_receiver_deskew_state_mux003416_f5 : MUXF5
    port map (
      I0 => BU2_N5069,
      I1 => BU2_N5068,
      S => BU2_U0_receiver_deskew_state_mux0034_map1352,
      O => BU2_U0_receiver_deskew_state_mux0034
    );
  BU2_U0_receiver_deskew_state_mux0034162 : LUT4
    generic map(
      INIT => X"0F08"
    )
    port map (
      I0 => BU2_U0_receiver_deskew_state_cmp_eq0009,
      I1 => mgt_rxcharisk_116(3),
      I2 => BU2_U0_receiver_deskew_state_and0000_47,
      I3 => BU2_N379,
      O => BU2_N5069
    );
  BU2_U0_receiver_deskew_state_mux003516_f5 : MUXF5
    port map (
      I0 => BU2_N5067,
      I1 => BU2_N5066,
      S => BU2_U0_receiver_deskew_state_mux0035_map1344,
      O => BU2_U0_receiver_deskew_state_mux0035
    );
  BU2_U0_receiver_deskew_state_mux0035162 : LUT4
    generic map(
      INIT => X"0F08"
    )
    port map (
      I0 => BU2_U0_receiver_deskew_state_cmp_eq0013,
      I1 => mgt_rxcharisk_116(2),
      I2 => BU2_U0_receiver_deskew_state_and0001_46,
      I3 => BU2_N355,
      O => BU2_N5067
    );
  BU2_U0_type_sel_reg_done_inv1_INV_0 : INV
    port map (
      I => BU2_U0_type_sel_reg_done_100,
      O => BU2_U0_type_sel_reg_done_inv
    );
  BU2_U0_reset_inv1_INV_0 : INV
    port map (
      I => reset,
      O => BU2_U0_reset_inv
    );
  BU2_U0_usrclk_reset_2 : FDS
    generic map(
      INIT => '1'
    )
    port map (
      D => BU2_U0_usrclk_reset_pipe_105,
      S => reset,
      C => usrclk,
      Q => BU2_U0_usrclk_reset_2_103
    );
  BU2_U0_transmitter_state_machine_state_1_1_3 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_transmitter_state_machine_next_state_1_1_Q,
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_state_machine_state_1_1_3_7
    );
  BU2_U0_receiver_pcs_sync_state0_next_state_1_0_47_G : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_state_1_0_52,
      I1 => BU2_U0_receiver_pcs_sync_state0_code_valid_pipe(0),
      I2 => BU2_U0_receiver_pcs_sync_state0_state_1_1_51,
      I3 => BU2_U0_receiver_pcs_sync_state0_N13,
      O => BU2_N5065
    );
  BU2_U0_receiver_pcs_sync_state0_next_state_1_0_47_F : LUT3
    generic map(
      INIT => X"10"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_state_1_2_50,
      I1 => BU2_U0_receiver_pcs_sync_state0_state_1_3_49,
      I2 => BU2_U0_receiver_pcs_sync_state0_next_state_1_0_map2898,
      O => BU2_N5064
    );
  BU2_U0_receiver_pcs_sync_state0_next_state_1_0_47 : MUXF5
    port map (
      I0 => BU2_N5064,
      I1 => BU2_N5065,
      S => BU2_U0_receiver_pcs_sync_state0_state_1_4_48,
      O => BU2_U0_receiver_pcs_sync_state0_next_state_1_0_map2901
    );
  BU2_U0_receiver_pcs_sync_state1_next_state_1_0_47_G : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_state_1_0_58,
      I1 => BU2_U0_receiver_pcs_sync_state1_code_valid_pipe(0),
      I2 => BU2_U0_receiver_pcs_sync_state1_state_1_1_57,
      I3 => BU2_U0_receiver_pcs_sync_state1_N13,
      O => BU2_N5063
    );
  BU2_U0_receiver_pcs_sync_state1_next_state_1_0_47_F : LUT3
    generic map(
      INIT => X"10"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_state_1_2_56,
      I1 => BU2_U0_receiver_pcs_sync_state1_state_1_3_55,
      I2 => BU2_U0_receiver_pcs_sync_state1_next_state_1_0_map2847,
      O => BU2_N5062
    );
  BU2_U0_receiver_pcs_sync_state1_next_state_1_0_47 : MUXF5
    port map (
      I0 => BU2_N5062,
      I1 => BU2_N5063,
      S => BU2_U0_receiver_pcs_sync_state1_state_1_4_54,
      O => BU2_U0_receiver_pcs_sync_state1_next_state_1_0_map2850
    );
  BU2_U0_receiver_pcs_sync_state2_next_state_1_0_47_G : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_state_1_0_64,
      I1 => BU2_U0_receiver_pcs_sync_state2_code_valid_pipe(0),
      I2 => BU2_U0_receiver_pcs_sync_state2_state_1_1_63,
      I3 => BU2_U0_receiver_pcs_sync_state2_N13,
      O => BU2_N5061
    );
  BU2_U0_receiver_pcs_sync_state2_next_state_1_0_47_F : LUT3
    generic map(
      INIT => X"10"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_state_1_2_62,
      I1 => BU2_U0_receiver_pcs_sync_state2_state_1_3_61,
      I2 => BU2_U0_receiver_pcs_sync_state2_next_state_1_0_map2796,
      O => BU2_N5060
    );
  BU2_U0_receiver_pcs_sync_state2_next_state_1_0_47 : MUXF5
    port map (
      I0 => BU2_N5060,
      I1 => BU2_N5061,
      S => BU2_U0_receiver_pcs_sync_state2_state_1_4_60,
      O => BU2_U0_receiver_pcs_sync_state2_next_state_1_0_map2799
    );
  BU2_U0_receiver_pcs_sync_state3_next_state_1_0_47_G : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_state_1_0_70,
      I1 => BU2_U0_receiver_pcs_sync_state3_code_valid_pipe(0),
      I2 => BU2_U0_receiver_pcs_sync_state3_state_1_1_69,
      I3 => BU2_U0_receiver_pcs_sync_state3_N13,
      O => BU2_N5059
    );
  BU2_U0_receiver_pcs_sync_state3_next_state_1_0_47_F : LUT3
    generic map(
      INIT => X"10"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_state_1_2_68,
      I1 => BU2_U0_receiver_pcs_sync_state3_state_1_3_67,
      I2 => BU2_U0_receiver_pcs_sync_state3_next_state_1_0_map2745,
      O => BU2_N5058
    );
  BU2_U0_receiver_pcs_sync_state3_next_state_1_0_47 : MUXF5
    port map (
      I0 => BU2_N5058,
      I1 => BU2_N5059,
      S => BU2_U0_receiver_pcs_sync_state3_state_1_4_66,
      O => BU2_U0_receiver_pcs_sync_state3_next_state_1_0_map2748
    );
  BU2_U0_transmitter_state_machine_mux0017_1_28_G : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_mux0017_2_map2965,
      I1 => BU2_U0_transmitter_state_machine_mux0003_0_map3000,
      I2 => BU2_U0_transmitter_state_machine_N11,
      I3 => BU2_N4492,
      O => BU2_N5057
    );
  BU2_U0_transmitter_state_machine_mux0017_1_28_F : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_mux0017_2_map2965,
      I1 => BU2_U0_transmitter_align_not0002,
      I2 => BU2_U0_transmitter_state_machine_mux0017_1_map3007,
      I3 => BU2_U0_transmitter_align_or0002_20,
      O => BU2_N5056
    );
  BU2_U0_transmitter_state_machine_mux0017_1_28 : MUXF5
    port map (
      I0 => BU2_N5056,
      I1 => BU2_N5057,
      S => BU2_U0_transmitter_state_machine_next_state_0_1_Q,
      O => BU2_U0_transmitter_state_machine_next_state_1_1_Q
    );
  BU2_U0_receiver_deskew_state_mux0044_1_176_G : LUT4
    generic map(
      INIT => X"A2F2"
    )
    port map (
      I0 => BU2_U0_receiver_deskew_state_deskew_error(1),
      I1 => BU2_U0_receiver_deskew_state_got_align(0),
      I2 => BU2_U0_receiver_deskew_state_deskew_error(0),
      I3 => BU2_U0_receiver_deskew_state_got_align(1),
      O => BU2_N5055
    );
  BU2_U0_receiver_deskew_state_mux0044_1_176_F : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => BU2_U0_receiver_deskew_state_deskew_error(0),
      I1 => BU2_U0_receiver_deskew_state_deskew_error(1),
      O => BU2_N5054
    );
  BU2_U0_receiver_deskew_state_mux0044_1_176 : MUXF5
    port map (
      I0 => BU2_N5054,
      I1 => BU2_N5055,
      S => BU2_U0_receiver_deskew_state_state_1_0_45,
      O => BU2_U0_receiver_deskew_state_mux0044_1_map2711
    );
  BU2_U0_receiver_deskew_state_mux0044_1_94_G : LUT4
    generic map(
      INIT => X"828B"
    )
    port map (
      I0 => NlwRenamedSig_OI_align_status,
      I1 => BU2_U0_receiver_deskew_state_got_align(0),
      I2 => BU2_U0_receiver_deskew_state_deskew_error(1),
      I3 => BU2_U0_receiver_deskew_state_got_align(1),
      O => BU2_N5053
    );
  BU2_U0_receiver_deskew_state_mux0044_1_94_F : LUT4
    generic map(
      INIT => X"AB15"
    )
    port map (
      I0 => BU2_U0_receiver_deskew_state_deskew_error(1),
      I1 => BU2_U0_receiver_deskew_state_got_align(0),
      I2 => BU2_U0_receiver_deskew_state_got_align(1),
      I3 => NlwRenamedSig_OI_align_status,
      O => BU2_N5052
    );
  BU2_U0_receiver_deskew_state_mux0044_1_94 : MUXF5
    port map (
      I0 => BU2_N5052,
      I1 => BU2_N5053,
      S => BU2_U0_receiver_deskew_state_state_1_0_45,
      O => BU2_U0_receiver_deskew_state_mux0044_1_map2694
    );
  BU2_U0_usrclk_reset_1 : FDS
    generic map(
      INIT => '1'
    )
    port map (
      D => BU2_U0_usrclk_reset_pipe_105,
      S => reset,
      C => usrclk,
      Q => BU2_U0_usrclk_reset_1_2
    );
  BU2_U0_receiver_deskew_state_state_1_2_1 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_receiver_deskew_state_next_state(1, 2),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_deskew_state_state_1_2_1_41
    );
  BU2_U0_transmitter_state_machine_state_1_0_2 : FDRS
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_N4381,
      R => BU2_U0_usrclk_reset_2_103,
      S => BU2_U0_transmitter_state_machine_mux0017_0_map2983,
      C => usrclk,
      Q => BU2_U0_transmitter_state_machine_state_1_0_2_23
    );
  BU2_U0_transmitter_state_machine_state_1_2_1 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_transmitter_state_machine_next_state_1_2_Q,
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_state_machine_state_1_2_1_22
    );
  BU2_U0_transmitter_state_machine_state_0_1_1 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_transmitter_state_machine_next_state_0_1_Q,
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_state_machine_state_0_1_1_17
    );
  BU2_U0_transmitter_state_machine_state_1_1_2 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_transmitter_state_machine_next_state_1_1_Q,
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_state_machine_state_1_1_2_24
    );
  BU2_U0_receiver_pcs_sync_state0_state_1_1_1 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_receiver_pcs_sync_state0_next_state(1, 1),
      R => BU2_U0_receiver_pcs_sync_state0_or0000,
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state0_state_1_1_1_8
    );
  BU2_U0_receiver_pcs_sync_state1_state_1_1_1 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_receiver_pcs_sync_state1_next_state(1, 1),
      R => BU2_U0_receiver_pcs_sync_state1_or0000,
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state1_state_1_1_1_9
    );
  BU2_U0_receiver_pcs_sync_state2_state_1_1_1 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_receiver_pcs_sync_state2_next_state(1, 1),
      R => BU2_U0_receiver_pcs_sync_state2_or0000,
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state2_state_1_1_1_10
    );
  BU2_U0_receiver_pcs_sync_state3_state_1_1_1 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_receiver_pcs_sync_state3_next_state(1, 1),
      R => BU2_U0_receiver_pcs_sync_state3_or0000,
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state3_state_1_1_1_11
    );
  BU2_U0_transmitter_state_machine_state_0_0_1 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_transmitter_state_machine_next_state_0_0_Q,
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_state_machine_state_0_0_1_16
    );
  BU2_U0_transmitter_state_machine_state_1_0_1 : FDRS
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_N4381,
      R => BU2_U0_usrclk_reset_2_103,
      S => BU2_U0_transmitter_state_machine_mux0017_0_map2983,
      C => usrclk,
      Q => BU2_U0_transmitter_state_machine_state_1_0_1_18
    );
  BU2_U0_transmitter_state_machine_state_1_1_1 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_transmitter_state_machine_next_state_1_1_Q,
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_state_machine_state_1_1_1_19
    );
  BU2_U0_transmitter_recoder_mux0423 : LUT4
    generic map(
      INIT => X"FF02"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_0_43,
      I1 => BU2_U0_transmitter_recoder_xor0003,
      I2 => BU2_N5050,
      I3 => BU2_N4851,
      O => BU2_U0_transmitter_recoder_mux0423_90
    );
  BU2_U0_transmitter_recoder_mux0423_SW0 : LUT4
    generic map(
      INIT => X"3F1D"
    )
    port map (
      I0 => BU2_U0_transmitter_filter5_txd_out(3),
      I1 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(11),
      I3 => BU2_U0_transmitter_state_machine_state_1_2_72,
      O => BU2_N5050
    );
  BU2_U0_transmitter_recoder_mux0451 : LUT4
    generic map(
      INIT => X"FF02"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_0_43,
      I1 => BU2_U0_transmitter_recoder_xor0003,
      I2 => BU2_N5048,
      I3 => BU2_N4851,
      O => BU2_U0_transmitter_recoder_mux0451_87
    );
  BU2_U0_transmitter_recoder_mux0451_SW0 : LUT4
    generic map(
      INIT => X"3F1D"
    )
    port map (
      I0 => BU2_U0_transmitter_filter7_txd_out(3),
      I1 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(27),
      I3 => BU2_U0_transmitter_state_machine_state_1_2_72,
      O => BU2_N5048
    );
  BU2_U0_transmitter_recoder_mux0429 : LUT4
    generic map(
      INIT => X"FF02"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_0_43,
      I1 => BU2_U0_transmitter_recoder_xor0003,
      I2 => BU2_N5046,
      I3 => BU2_N4851,
      O => BU2_U0_transmitter_recoder_mux0429_89
    );
  BU2_U0_transmitter_recoder_mux0429_SW0 : LUT4
    generic map(
      INIT => X"3F1D"
    )
    port map (
      I0 => BU2_U0_transmitter_filter6_txd_out(3),
      I1 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(19),
      I3 => BU2_U0_transmitter_state_machine_state_1_2_72,
      O => BU2_N5046
    );
  BU2_U0_transmitter_recoder_mux0410 : LUT4
    generic map(
      INIT => X"FF02"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_0_76,
      I1 => BU2_U0_transmitter_recoder_xor0003,
      I2 => BU2_N5044,
      I3 => BU2_N4835,
      O => BU2_U0_transmitter_recoder_mux0410_92
    );
  BU2_U0_transmitter_recoder_mux0410_SW0 : LUT4
    generic map(
      INIT => X"3F1D"
    )
    port map (
      I0 => BU2_U0_transmitter_filter3_txd_out(3),
      I1 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(27),
      I3 => BU2_U0_transmitter_state_machine_state_0_2_74,
      O => BU2_N5044
    );
  BU2_U0_transmitter_recoder_mux0404 : LUT4
    generic map(
      INIT => X"FF02"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_0_76,
      I1 => BU2_U0_transmitter_recoder_xor0003,
      I2 => BU2_N5042,
      I3 => BU2_N4835,
      O => BU2_U0_transmitter_recoder_mux0404_93
    );
  BU2_U0_transmitter_recoder_mux0404_SW0 : LUT4
    generic map(
      INIT => X"3F1D"
    )
    port map (
      I0 => BU2_U0_transmitter_filter2_txd_out(3),
      I1 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(19),
      I3 => BU2_U0_transmitter_state_machine_state_0_2_74,
      O => BU2_N5042
    );
  BU2_U0_transmitter_recoder_mux0392 : LUT4
    generic map(
      INIT => X"FF02"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_0_76,
      I1 => BU2_U0_transmitter_recoder_xor0003,
      I2 => BU2_N5040,
      I3 => BU2_N4835,
      O => BU2_U0_transmitter_recoder_mux0392_94
    );
  BU2_U0_transmitter_recoder_mux0392_SW0 : LUT4
    generic map(
      INIT => X"3F1D"
    )
    port map (
      I0 => BU2_U0_transmitter_filter1_txd_out(3),
      I1 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(11),
      I3 => BU2_U0_transmitter_state_machine_state_0_2_74,
      O => BU2_N5040
    );
  BU2_U0_transmitter_recoder_mux0416 : LUT4
    generic map(
      INIT => X"FF02"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_0_43,
      I1 => BU2_U0_transmitter_recoder_xor0003,
      I2 => BU2_N5038,
      I3 => BU2_N4851,
      O => BU2_U0_transmitter_recoder_mux0416_91
    );
  BU2_U0_transmitter_recoder_mux0416_SW2 : LUT4
    generic map(
      INIT => X"3F1D"
    )
    port map (
      I0 => BU2_U0_transmitter_filter4_txd_out(3),
      I1 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(3),
      I3 => BU2_U0_transmitter_state_machine_state_1_2_72,
      O => BU2_N5038
    );
  BU2_U0_transmitter_recoder_mux0441 : LUT4
    generic map(
      INIT => X"FF02"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_0_76,
      I1 => BU2_U0_transmitter_recoder_xor0003,
      I2 => BU2_N5036,
      I3 => BU2_N4835,
      O => BU2_U0_transmitter_recoder_mux0441_88
    );
  BU2_U0_transmitter_recoder_mux0441_SW2 : LUT4
    generic map(
      INIT => X"3F1D"
    )
    port map (
      I0 => BU2_U0_transmitter_filter0_txd_out(3),
      I1 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(3),
      I3 => BU2_U0_transmitter_state_machine_state_0_2_74,
      O => BU2_N5036
    );
  BU2_U0_transmitter_recoder_mux04501 : LUT4
    generic map(
      INIT => X"88A8"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_N28,
      I1 => BU2_N2149,
      I2 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I3 => BU2_U0_transmitter_state_machine_state_0_0_76,
      O => BU2_N4379
    );
  BU2_U0_transmitter_recoder_mux04461 : LUT4
    generic map(
      INIT => X"88A8"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_N29,
      I1 => BU2_N2157,
      I2 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I3 => BU2_U0_transmitter_state_machine_state_1_0_43,
      O => BU2_N4378
    );
  BU2_U0_transmitter_recoder_mux04371 : LUT4
    generic map(
      INIT => X"88A8"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_N29,
      I1 => BU2_N2155,
      I2 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I3 => BU2_U0_transmitter_state_machine_state_1_0_43,
      O => BU2_N4376
    );
  BU2_U0_transmitter_recoder_mux04281 : LUT4
    generic map(
      INIT => X"88A8"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_N29,
      I1 => BU2_N2161,
      I2 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I3 => BU2_U0_transmitter_state_machine_state_1_0_43,
      O => BU2_N4373
    );
  BU2_U0_transmitter_recoder_mux04221 : LUT4
    generic map(
      INIT => X"88A8"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_N29,
      I1 => BU2_N2159,
      I2 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I3 => BU2_U0_transmitter_state_machine_state_1_0_43,
      O => BU2_N4372
    );
  BU2_U0_transmitter_recoder_mux04071 : LUT4
    generic map(
      INIT => X"88A8"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_N28,
      I1 => BU2_N2147,
      I2 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I3 => BU2_U0_transmitter_state_machine_state_0_0_76,
      O => BU2_N4369
    );
  BU2_U0_transmitter_recoder_mux04011 : LUT4
    generic map(
      INIT => X"88A8"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_N28,
      I1 => BU2_N2153,
      I2 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I3 => BU2_U0_transmitter_state_machine_state_0_0_76,
      O => BU2_N4367
    );
  BU2_U0_transmitter_recoder_mux03951 : LUT4
    generic map(
      INIT => X"88A8"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_N28,
      I1 => BU2_N2151,
      I2 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I3 => BU2_U0_transmitter_state_machine_state_0_0_76,
      O => BU2_N4365
    );
  BU2_U0_receiver_pcs_sync_state0_cmp_eq00001 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_state_1_2_50,
      I1 => BU2_U0_receiver_pcs_sync_state0_state_1_3_49,
      I2 => BU2_U0_receiver_pcs_sync_state0_state_1_4_48,
      I3 => BU2_U0_receiver_pcs_sync_state0_N01,
      O => mgt_enable_align_112(0)
    );
  BU2_U0_receiver_pcs_sync_state1_cmp_eq00001 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_state_1_2_56,
      I1 => BU2_U0_receiver_pcs_sync_state1_state_1_3_55,
      I2 => BU2_U0_receiver_pcs_sync_state1_state_1_4_54,
      I3 => BU2_U0_receiver_pcs_sync_state1_N01,
      O => mgt_enable_align_112(1)
    );
  BU2_U0_receiver_pcs_sync_state2_cmp_eq00001 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_state_1_2_62,
      I1 => BU2_U0_receiver_pcs_sync_state2_state_1_3_61,
      I2 => BU2_U0_receiver_pcs_sync_state2_state_1_4_60,
      I3 => BU2_U0_receiver_pcs_sync_state2_N01,
      O => mgt_enable_align_112(2)
    );
  BU2_U0_receiver_pcs_sync_state3_cmp_eq00001 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_state_1_2_68,
      I1 => BU2_U0_receiver_pcs_sync_state3_state_1_3_67,
      I2 => BU2_U0_receiver_pcs_sync_state3_state_1_4_66,
      I3 => BU2_U0_receiver_pcs_sync_state3_N01,
      O => mgt_enable_align_112(3)
    );
  BU2_U0_receiver_pcs_sync_state0_next_state_1_4_Q : LUT4
    generic map(
      INIT => X"0082"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_N7,
      I1 => BU2_U0_signal_detect_int(0),
      I2 => BU2_U0_receiver_pcs_sync_state0_signal_detect_last_53,
      I3 => BU2_N4970,
      O => BU2_U0_receiver_pcs_sync_state0_next_state(1, 4)
    );
  BU2_U0_receiver_pcs_sync_state0_next_state_1_4_SW1 : LUT4
    generic map(
      INIT => X"FF7F"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_state_1_1_51,
      I1 => BU2_U0_receiver_pcs_sync_state0_code_valid_pipe(0),
      I2 => BU2_U0_receiver_pcs_sync_state0_code_valid_pipe(1),
      I3 => BU2_U0_receiver_pcs_sync_state0_state_1_0_52,
      O => BU2_N4970
    );
  BU2_U0_receiver_pcs_sync_state1_next_state_1_4_Q : LUT4
    generic map(
      INIT => X"0082"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_N7,
      I1 => BU2_U0_signal_detect_int(1),
      I2 => BU2_U0_receiver_pcs_sync_state1_signal_detect_last_59,
      I3 => BU2_N4968,
      O => BU2_U0_receiver_pcs_sync_state1_next_state(1, 4)
    );
  BU2_U0_receiver_pcs_sync_state1_next_state_1_4_SW1 : LUT4
    generic map(
      INIT => X"FF7F"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_state_1_1_57,
      I1 => BU2_U0_receiver_pcs_sync_state1_code_valid_pipe(0),
      I2 => BU2_U0_receiver_pcs_sync_state1_code_valid_pipe(1),
      I3 => BU2_U0_receiver_pcs_sync_state1_state_1_0_58,
      O => BU2_N4968
    );
  BU2_U0_receiver_pcs_sync_state2_next_state_1_4_Q : LUT4
    generic map(
      INIT => X"0082"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_N7,
      I1 => BU2_U0_signal_detect_int(2),
      I2 => BU2_U0_receiver_pcs_sync_state2_signal_detect_last_65,
      I3 => BU2_N4966,
      O => BU2_U0_receiver_pcs_sync_state2_next_state(1, 4)
    );
  BU2_U0_receiver_pcs_sync_state2_next_state_1_4_SW1 : LUT4
    generic map(
      INIT => X"FF7F"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_state_1_1_63,
      I1 => BU2_U0_receiver_pcs_sync_state2_code_valid_pipe(0),
      I2 => BU2_U0_receiver_pcs_sync_state2_code_valid_pipe(1),
      I3 => BU2_U0_receiver_pcs_sync_state2_state_1_0_64,
      O => BU2_N4966
    );
  BU2_U0_receiver_pcs_sync_state3_next_state_1_4_Q : LUT4
    generic map(
      INIT => X"0082"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_N7,
      I1 => BU2_U0_signal_detect_int(3),
      I2 => BU2_U0_receiver_pcs_sync_state3_signal_detect_last_71,
      I3 => BU2_N4964,
      O => BU2_U0_receiver_pcs_sync_state3_next_state(1, 4)
    );
  BU2_U0_receiver_pcs_sync_state3_next_state_1_4_SW1 : LUT4
    generic map(
      INIT => X"FF7F"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_state_1_1_69,
      I1 => BU2_U0_receiver_pcs_sync_state3_code_valid_pipe(0),
      I2 => BU2_U0_receiver_pcs_sync_state3_code_valid_pipe(1),
      I3 => BU2_U0_receiver_pcs_sync_state3_state_1_0_70,
      O => BU2_N4964
    );
  BU2_U0_transmitter_align_or00001 : LUT3
    generic map(
      INIT => X"F2"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I1 => BU2_U0_transmitter_state_machine_state_1_0_43,
      I2 => BU2_U0_usrclk_reset_104,
      O => BU2_U0_transmitter_align_or0000
    );
  BU2_U0_receiver_pcs_sync_state0_next_state_1_1_36 : LUT3
    generic map(
      INIT => X"82"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_code_valid_pipe(1),
      I1 => BU2_U0_receiver_pcs_sync_state0_signal_detect_last_53,
      I2 => BU2_U0_signal_detect_int(0),
      O => BU2_U0_receiver_pcs_sync_state0_next_state_1_1_map2441
    );
  BU2_U0_receiver_pcs_sync_state1_next_state_1_1_36 : LUT3
    generic map(
      INIT => X"82"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_code_valid_pipe(1),
      I1 => BU2_U0_receiver_pcs_sync_state1_signal_detect_last_59,
      I2 => BU2_U0_signal_detect_int(1),
      O => BU2_U0_receiver_pcs_sync_state1_next_state_1_1_map2427
    );
  BU2_U0_receiver_pcs_sync_state2_next_state_1_1_36 : LUT3
    generic map(
      INIT => X"82"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_code_valid_pipe(1),
      I1 => BU2_U0_receiver_pcs_sync_state2_signal_detect_last_65,
      I2 => BU2_U0_signal_detect_int(2),
      O => BU2_U0_receiver_pcs_sync_state2_next_state_1_1_map2413
    );
  BU2_U0_receiver_pcs_sync_state3_next_state_1_1_36 : LUT3
    generic map(
      INIT => X"82"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_code_valid_pipe(1),
      I1 => BU2_U0_receiver_pcs_sync_state3_signal_detect_last_71,
      I2 => BU2_U0_signal_detect_int(3),
      O => BU2_U0_receiver_pcs_sync_state3_next_state_1_1_map2399
    );
  BU2_U0_receiver_recoder_or002831_SW0 : LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_lane_terminate(0),
      I1 => BU2_U0_receiver_recoder_lane_terminate(1),
      I2 => BU2_U0_receiver_recoder_lane_terminate(2),
      I3 => BU2_U0_receiver_recoder_code_error_delay(3),
      O => BU2_N4930
    );
  BU2_U0_transmitter_recoder_mux043721 : LUT4
    generic map(
      INIT => X"2232"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I1 => BU2_U0_transmitter_recoder_xor0003,
      I2 => BU2_U0_transmitter_state_machine_state_1_0_43,
      I3 => BU2_U0_transmitter_state_machine_state_1_2_72,
      O => BU2_U0_transmitter_recoder_N29
    );
  BU2_U0_transmitter_recoder_mux040721 : LUT4
    generic map(
      INIT => X"2232"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I1 => BU2_U0_transmitter_recoder_xor0003,
      I2 => BU2_U0_transmitter_state_machine_state_0_0_76,
      I3 => BU2_U0_transmitter_state_machine_state_0_2_74,
      O => BU2_U0_transmitter_recoder_N28
    );
  BU2_U0_transmitter_align_cmp_eq00001 : LUT4
    generic map(
      INIT => X"0C04"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I1 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I2 => BU2_U0_transmitter_state_machine_state_0_0_76,
      I3 => BU2_U0_transmitter_state_machine_state_1_0_43,
      O => BU2_U0_transmitter_align_cmp_eq0000
    );
  BU2_U0_receiver_recoder_mux05011 : LUT4
    generic map(
      INIT => X"AAA2"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(27),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(28),
      I2 => BU2_N5259,
      I3 => BU2_N2442,
      O => BU2_U0_receiver_recoder_mux0501
    );
  BU2_U0_receiver_recoder_mux04931 : LUT4
    generic map(
      INIT => X"AAA2"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(28),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(27),
      I2 => BU2_N4545,
      I3 => BU2_N2442,
      O => BU2_U0_receiver_recoder_mux0493
    );
  BU2_U0_receiver_recoder_mux04841 : LUT4
    generic map(
      INIT => X"AAA2"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(12),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(11),
      I2 => BU2_N4549,
      I3 => BU2_N4170,
      O => BU2_U0_receiver_recoder_mux0484
    );
  BU2_U0_receiver_recoder_mux04821 : LUT4
    generic map(
      INIT => X"AAA2"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(11),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(12),
      I2 => BU2_N5261,
      I3 => BU2_N4170,
      O => BU2_U0_receiver_recoder_mux0482
    );
  BU2_U0_receiver_recoder_mux04801 : LUT4
    generic map(
      INIT => X"AAA2"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(4),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(3),
      I2 => BU2_N4797,
      I3 => BU2_N2440,
      O => BU2_U0_receiver_recoder_mux0480
    );
  BU2_U0_receiver_recoder_mux04791 : LUT4
    generic map(
      INIT => X"AAA2"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(3),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(4),
      I2 => BU2_N4797,
      I3 => BU2_N2440,
      O => BU2_U0_receiver_recoder_mux0479
    );
  BU2_U0_receiver_deskew_state_mux0044_0_115 : LUT4
    generic map(
      INIT => X"0004"
    )
    port map (
      I0 => BU2_U0_receiver_deskew_state_got_align(1),
      I1 => BU2_U0_receiver_deskew_state_mux0044_0_map2171,
      I2 => BU2_U0_receiver_deskew_state_state_1_0_45,
      I3 => BU2_U0_receiver_deskew_state_deskew_error(1),
      O => BU2_U0_receiver_deskew_state_mux0044_0_map2177
    );
  BU2_U0_receiver_recoder_mux05021 : LUT4
    generic map(
      INIT => X"AAA8"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(5),
      I1 => BU2_N4529,
      I2 => BU2_U0_receiver_recoder_rxd_half_pipe(0),
      I3 => BU2_N4950,
      O => BU2_U0_receiver_recoder_mux0502
    );
  BU2_U0_receiver_recoder_mux05021_SW0 : LUT4
    generic map(
      INIT => X"FFD7"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(2),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(6),
      I2 => BU2_U0_receiver_recoder_rxd_half_pipe(7),
      I3 => BU2_U0_receiver_recoder_rxd_half_pipe(1),
      O => BU2_N4950
    );
  BU2_U0_receiver_recoder_mux04781 : LUT4
    generic map(
      INIT => X"AAA8"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(29),
      I1 => BU2_N4535,
      I2 => BU2_U0_receiver_recoder_rxd_half_pipe(24),
      I3 => BU2_N4948,
      O => BU2_U0_receiver_recoder_mux0478
    );
  BU2_U0_receiver_recoder_mux04781_SW0 : LUT4
    generic map(
      INIT => X"FFD7"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(26),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(30),
      I2 => BU2_U0_receiver_recoder_rxd_half_pipe(31),
      I3 => BU2_U0_receiver_recoder_rxd_half_pipe(25),
      O => BU2_N4948
    );
  BU2_U0_receiver_recoder_mux04691 : LUT4
    generic map(
      INIT => X"AAA8"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(21),
      I1 => BU2_N4533,
      I2 => BU2_U0_receiver_recoder_rxd_half_pipe(16),
      I3 => BU2_N4946,
      O => BU2_U0_receiver_recoder_mux0469
    );
  BU2_U0_receiver_recoder_mux04691_SW0 : LUT4
    generic map(
      INIT => X"FFD7"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(18),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(22),
      I2 => BU2_U0_receiver_recoder_rxd_half_pipe(23),
      I3 => BU2_U0_receiver_recoder_rxd_half_pipe(17),
      O => BU2_N4946
    );
  BU2_U0_receiver_recoder_mux04651 : LUT4
    generic map(
      INIT => X"AA2A"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(13),
      I1 => BU2_N4531,
      I2 => BU2_U0_receiver_recoder_rxd_half_pipe(10),
      I3 => BU2_N4944,
      O => BU2_U0_receiver_recoder_mux0465
    );
  BU2_U0_receiver_recoder_mux04651_SW0 : LUT4
    generic map(
      INIT => X"FFF9"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(15),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(14),
      I2 => BU2_U0_receiver_recoder_rxd_half_pipe(9),
      I3 => BU2_U0_receiver_recoder_rxd_half_pipe(8),
      O => BU2_N4944
    );
  BU2_U0_receiver_deskew_state_mux0044_1_270_G : LUT4
    generic map(
      INIT => X"88A8"
    )
    port map (
      I0 => BU2_U0_receiver_sync_status_97,
      I1 => BU2_U0_receiver_deskew_state_mux0044_1_map2701,
      I2 => BU2_U0_receiver_deskew_state_mux0044_1_map2694,
      I3 => BU2_U0_receiver_deskew_state_deskew_error(0),
      O => BU2_N4943
    );
  BU2_U0_receiver_deskew_state_mux0044_1_270_F : LUT4
    generic map(
      INIT => X"F080"
    )
    port map (
      I0 => NlwRenamedSig_OI_align_status,
      I1 => BU2_U0_receiver_deskew_state_mux0044_1_map2711,
      I2 => BU2_U0_receiver_sync_status_97,
      I3 => BU2_U0_receiver_deskew_state_mux0044_1_map2724,
      O => BU2_N4942
    );
  BU2_U0_receiver_deskew_state_mux0044_1_270 : MUXF5
    port map (
      I0 => BU2_N4942,
      I1 => BU2_N4943,
      S => BU2_U0_receiver_deskew_state_state_1_1_44,
      O => BU2_U0_receiver_deskew_state_next_state(1, 1)
    );
  BU2_U0_transmitter_align_Mrom_a_cnt_0_1_SW3_F : LUT4
    generic map(
      INIT => X"F1FF"
    )
    port map (
      I0 => BU2_U0_transmitter_align_count(3),
      I1 => BU2_U0_transmitter_align_count(4),
      I2 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I3 => BU2_U0_transmitter_state_machine_state_1_2_72,
      O => BU2_N4940
    );
  BU2_U0_transmitter_align_Mrom_a_cnt_0_1_SW3 : MUXF5
    port map (
      I0 => BU2_N4940,
      I1 => BU2_N1,
      S => BU2_U0_transmitter_k_r_prbs_i_prbs(8),
      O => BU2_N4808
    );
  BU2_U0_transmitter_align_Mrom_a_cnt_0_1_SW1_F : LUT4
    generic map(
      INIT => X"F1FF"
    )
    port map (
      I0 => BU2_U0_transmitter_align_count(3),
      I1 => BU2_U0_transmitter_align_count(4),
      I2 => BU2_U0_transmitter_state_machine_state_1_1_2_24,
      I3 => BU2_U0_transmitter_state_machine_state_1_2_1_22,
      O => BU2_N4938
    );
  BU2_U0_transmitter_align_Mrom_a_cnt_0_1_SW1 : MUXF5
    port map (
      I0 => BU2_N4938,
      I1 => BU2_N1,
      S => BU2_U0_transmitter_k_r_prbs_i_prbs(8),
      O => BU2_N4805
    );
  BU2_U0_transmitter_state_machine_mux0003_0_10_SW0_G : LUT4
    generic map(
      INIT => X"AF8C"
    )
    port map (
      I0 => BU2_U0_transmitter_k_r_prbs_i_prbs(8),
      I1 => BU2_U0_transmitter_tx_is_idle(0),
      I2 => BU2_U0_transmitter_state_machine_state_1_2_1_22,
      I3 => BU2_U0_transmitter_tx_is_q(0),
      O => BU2_N4937
    );
  BU2_U0_transmitter_state_machine_mux0003_0_10_SW0_F : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_transmitter_tx_is_q(0),
      I1 => BU2_U0_transmitter_tx_is_idle(0),
      O => BU2_N4936
    );
  BU2_U0_transmitter_state_machine_mux0003_0_10_SW0 : MUXF5
    port map (
      I0 => BU2_N4936,
      I1 => BU2_N4937,
      S => BU2_U0_transmitter_state_machine_state_1_1_2_24,
      O => BU2_N4494
    );
  BU2_U0_receiver_recoder_or00131 : LUT4
    generic map(
      INIT => X"FFD8"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_N16,
      I1 => BU2_N4934,
      I2 => BU2_N4933,
      I3 => BU2_U0_receiver_recoder_or0017,
      O => BU2_U0_receiver_recoder_or0013
    );
  BU2_U0_receiver_recoder_or002554_SW1 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_N5207,
      I1 => BU2_U0_receiver_recoder_code_error_delay(0),
      O => BU2_N4933
    );
  BU2_U0_receiver_recoder_or00041 : LUT4
    generic map(
      INIT => X"FFD8"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_N37,
      I1 => BU2_N4931,
      I2 => BU2_N4930,
      I3 => BU2_U0_receiver_recoder_or0020,
      O => BU2_U0_receiver_recoder_or0004
    );
  BU2_U0_receiver_deskew_state_mux0044_0_189_SW1 : LUT2
    generic map(
      INIT => X"D"
    )
    port map (
      I0 => BU2_U0_receiver_deskew_state_got_align(1),
      I1 => NlwRenamedSig_OI_align_status,
      O => BU2_N4928
    );
  BU2_U0_receiver_recoder_or002058 : LUT4
    generic map(
      INIT => X"0004"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(25),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(26),
      I2 => BU2_N5258,
      I3 => BU2_N4926,
      O => BU2_U0_receiver_recoder_or0020
    );
  BU2_U0_receiver_recoder_or002058_SW0 : LUT4
    generic map(
      INIT => X"EFBE"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(24),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(30),
      I2 => BU2_U0_receiver_recoder_rxd_half_pipe(29),
      I3 => BU2_U0_receiver_recoder_rxd_half_pipe(31),
      O => BU2_N4926
    );
  BU2_U0_receiver_recoder_or001958 : LUT4
    generic map(
      INIT => X"0004"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(17),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(18),
      I2 => BU2_N4533,
      I3 => BU2_N4924,
      O => BU2_U0_receiver_recoder_or0019
    );
  BU2_U0_receiver_recoder_or001958_SW0 : LUT4
    generic map(
      INIT => X"EFBE"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(16),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(22),
      I2 => BU2_U0_receiver_recoder_rxd_half_pipe(21),
      I3 => BU2_U0_receiver_recoder_rxd_half_pipe(23),
      O => BU2_N4924
    );
  BU2_U0_receiver_recoder_or001854 : LUT4
    generic map(
      INIT => X"0010"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(8),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(9),
      I2 => BU2_N5257,
      I3 => BU2_N4922,
      O => BU2_U0_receiver_recoder_or0018
    );
  BU2_U0_receiver_recoder_or001854_SW0 : LUT4
    generic map(
      INIT => X"BF6F"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(15),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(13),
      I2 => BU2_U0_receiver_recoder_rxd_half_pipe(10),
      I3 => BU2_U0_receiver_recoder_rxd_half_pipe(14),
      O => BU2_N4922
    );
  BU2_U0_receiver_recoder_or001758 : LUT4
    generic map(
      INIT => X"0004"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(1),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(2),
      I2 => BU2_N5256,
      I3 => BU2_N4920,
      O => BU2_U0_receiver_recoder_or0017
    );
  BU2_U0_receiver_recoder_or001758_SW0 : LUT4
    generic map(
      INIT => X"EFBE"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(0),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(6),
      I2 => BU2_U0_receiver_recoder_rxd_half_pipe(5),
      I3 => BU2_U0_receiver_recoder_rxd_half_pipe(7),
      O => BU2_N4920
    );
  BU2_U0_receiver_pcs_sync_state0_next_state_1_3_5 : LUT4
    generic map(
      INIT => X"FFF4"
    )
    port map (
      I0 => BU2_N4916,
      I1 => BU2_U0_receiver_pcs_sync_state0_N8,
      I2 => BU2_U0_receiver_pcs_sync_state0_mux0019(9),
      I3 => BU2_U0_receiver_pcs_sync_state0_mux0019(7),
      O => BU2_U0_receiver_pcs_sync_state0_next_state_1_3_map2376
    );
  BU2_U0_receiver_pcs_sync_state0_next_state_1_3_5_SW1 : LUT4
    generic map(
      INIT => X"F66F"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(0),
      I1 => BU2_U0_receiver_pcs_sync_state0_signal_detect_last_53,
      I2 => BU2_U0_receiver_pcs_sync_state0_state_1_1_51,
      I3 => BU2_U0_receiver_pcs_sync_state0_state_1_0_52,
      O => BU2_N4916
    );
  BU2_U0_receiver_pcs_sync_state1_next_state_1_3_5 : LUT4
    generic map(
      INIT => X"FFF4"
    )
    port map (
      I0 => BU2_N4914,
      I1 => BU2_U0_receiver_pcs_sync_state1_N8,
      I2 => BU2_U0_receiver_pcs_sync_state1_mux0019(9),
      I3 => BU2_U0_receiver_pcs_sync_state1_mux0019(7),
      O => BU2_U0_receiver_pcs_sync_state1_next_state_1_3_map2363
    );
  BU2_U0_receiver_pcs_sync_state1_next_state_1_3_5_SW1 : LUT4
    generic map(
      INIT => X"F66F"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(1),
      I1 => BU2_U0_receiver_pcs_sync_state1_signal_detect_last_59,
      I2 => BU2_U0_receiver_pcs_sync_state1_state_1_1_57,
      I3 => BU2_U0_receiver_pcs_sync_state1_state_1_0_58,
      O => BU2_N4914
    );
  BU2_U0_receiver_pcs_sync_state2_next_state_1_3_5 : LUT4
    generic map(
      INIT => X"FFF4"
    )
    port map (
      I0 => BU2_N4912,
      I1 => BU2_U0_receiver_pcs_sync_state2_N8,
      I2 => BU2_U0_receiver_pcs_sync_state2_mux0019(9),
      I3 => BU2_U0_receiver_pcs_sync_state2_mux0019(7),
      O => BU2_U0_receiver_pcs_sync_state2_next_state_1_3_map2350
    );
  BU2_U0_receiver_pcs_sync_state2_next_state_1_3_5_SW1 : LUT4
    generic map(
      INIT => X"F66F"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(2),
      I1 => BU2_U0_receiver_pcs_sync_state2_signal_detect_last_65,
      I2 => BU2_U0_receiver_pcs_sync_state2_state_1_1_63,
      I3 => BU2_U0_receiver_pcs_sync_state2_state_1_0_64,
      O => BU2_N4912
    );
  BU2_U0_receiver_pcs_sync_state3_next_state_1_3_5 : LUT4
    generic map(
      INIT => X"FFF4"
    )
    port map (
      I0 => BU2_N4910,
      I1 => BU2_U0_receiver_pcs_sync_state3_N8,
      I2 => BU2_U0_receiver_pcs_sync_state3_mux0019(9),
      I3 => BU2_U0_receiver_pcs_sync_state3_mux0019(7),
      O => BU2_U0_receiver_pcs_sync_state3_next_state_1_3_map2337
    );
  BU2_U0_receiver_pcs_sync_state3_next_state_1_3_5_SW1 : LUT4
    generic map(
      INIT => X"F66F"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(3),
      I1 => BU2_U0_receiver_pcs_sync_state3_signal_detect_last_71,
      I2 => BU2_U0_receiver_pcs_sync_state3_state_1_1_69,
      I3 => BU2_U0_receiver_pcs_sync_state3_state_1_0_70,
      O => BU2_N4910
    );
  BU2_U0_receiver_pcs_sync_state0_next_state_1_0_12 : LUT4
    generic map(
      INIT => X"666F"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(0),
      I1 => BU2_U0_receiver_pcs_sync_state0_signal_detect_last_53,
      I2 => BU2_U0_receiver_pcs_sync_state0_code_valid_pipe(0),
      I3 => BU2_N4908,
      O => BU2_U0_receiver_pcs_sync_state0_next_state_1_0_map2888
    );
  BU2_U0_receiver_pcs_sync_state1_next_state_1_0_12 : LUT4
    generic map(
      INIT => X"666F"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(1),
      I1 => BU2_U0_receiver_pcs_sync_state1_signal_detect_last_59,
      I2 => BU2_U0_receiver_pcs_sync_state1_code_valid_pipe(0),
      I3 => BU2_N4906,
      O => BU2_U0_receiver_pcs_sync_state1_next_state_1_0_map2837
    );
  BU2_U0_receiver_pcs_sync_state2_next_state_1_0_12 : LUT4
    generic map(
      INIT => X"666F"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(2),
      I1 => BU2_U0_receiver_pcs_sync_state2_signal_detect_last_65,
      I2 => BU2_U0_receiver_pcs_sync_state2_code_valid_pipe(0),
      I3 => BU2_N4904,
      O => BU2_U0_receiver_pcs_sync_state2_next_state_1_0_map2786
    );
  BU2_U0_receiver_pcs_sync_state3_next_state_1_0_12 : LUT4
    generic map(
      INIT => X"666F"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(3),
      I1 => BU2_U0_receiver_pcs_sync_state3_signal_detect_last_71,
      I2 => BU2_U0_receiver_pcs_sync_state3_code_valid_pipe(0),
      I3 => BU2_N4902,
      O => BU2_U0_receiver_pcs_sync_state3_next_state_1_0_map2735
    );
  BU2_U0_receiver_recoder_or00071 : LUT4
    generic map(
      INIT => X"FFFD"
    )
    port map (
      I0 => NlwRenamedSig_OI_align_status,
      I1 => BU2_N4900,
      I2 => BU2_U0_receiver_recoder_or0021,
      I3 => BU2_U0_receiver_recoder_or0029_map2333,
      O => BU2_U0_receiver_recoder_or0007
    );
  BU2_U0_receiver_recoder_or002975_SW0 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_pipe(0),
      I1 => BU2_U0_usrclk_reset_1_2,
      O => BU2_N4900
    );
  BU2_U0_transmitter_recoder_mux039241 : LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I1 => BU2_U0_transmitter_state_machine_state_0_0_76,
      I2 => BU2_U0_transmitter_recoder_xor0003,
      O => BU2_U0_transmitter_recoder_N38
    );
  BU2_U0_transmitter_recoder_mux041651 : LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I1 => BU2_U0_transmitter_state_machine_state_1_0_43,
      I2 => BU2_U0_transmitter_recoder_xor0003,
      O => BU2_U0_transmitter_recoder_N37
    );
  BU2_U0_receiver_recoder_or003195 : LUT4
    generic map(
      INIT => X"0004"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_lane_terminate(2),
      I1 => BU2_U0_receiver_recoder_lane_terminate(3),
      I2 => BU2_U0_receiver_recoder_lane_terminate(0),
      I3 => BU2_U0_receiver_recoder_lane_terminate(1),
      O => BU2_U0_receiver_recoder_or0031_map2666
    );
  BU2_U0_transmitter_recoder_mux046211 : LUT4
    generic map(
      INIT => X"0004"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I1 => BU2_U0_transmitter_state_machine_state_1_0_43,
      I2 => BU2_U0_transmitter_state_machine_state_1_2_72,
      I3 => BU2_U0_transmitter_recoder_xor0003,
      O => BU2_U0_transmitter_recoder_N47
    );
  BU2_U0_transmitter_recoder_mux039821 : LUT4
    generic map(
      INIT => X"0004"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I1 => BU2_U0_transmitter_state_machine_state_0_0_76,
      I2 => BU2_U0_transmitter_state_machine_state_0_2_74,
      I3 => BU2_U0_transmitter_recoder_xor0003,
      O => BU2_U0_transmitter_recoder_N35
    );
  BU2_U0_receiver_recoder_or003258_SW1 : LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_lane_terminate(4),
      I1 => BU2_U0_receiver_recoder_lane_terminate(5),
      I2 => BU2_U0_receiver_recoder_lane_terminate(6),
      I3 => BU2_U0_receiver_recoder_code_error_pipe(3),
      O => BU2_N4800
    );
  BU2_U0_receiver_recoder_mux04941 : LUT4
    generic map(
      INIT => X"AA2A"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(23),
      I1 => BU2_U0_receiver_recoder_N17,
      I2 => BU2_U0_receiver_recoder_rxc_pipe(2),
      I3 => BU2_N1564,
      O => BU2_U0_receiver_recoder_mux0494
    );
  BU2_U0_receiver_recoder_mux04921 : LUT4
    generic map(
      INIT => X"AA2A"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(22),
      I1 => BU2_U0_receiver_recoder_N17,
      I2 => BU2_U0_receiver_recoder_rxc_pipe(2),
      I3 => BU2_N1564,
      O => BU2_U0_receiver_recoder_mux0492
    );
  BU2_U0_receiver_recoder_mux04911 : LUT4
    generic map(
      INIT => X"AA2A"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(21),
      I1 => BU2_U0_receiver_recoder_N17,
      I2 => BU2_U0_receiver_recoder_rxc_pipe(2),
      I3 => BU2_N1564,
      O => BU2_U0_receiver_recoder_mux0491
    );
  BU2_U0_receiver_recoder_mux04891 : LUT4
    generic map(
      INIT => X"AA2A"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(20),
      I1 => BU2_U0_receiver_recoder_N17,
      I2 => BU2_U0_receiver_recoder_rxc_pipe(2),
      I3 => BU2_N1564,
      O => BU2_U0_receiver_recoder_mux0489
    );
  BU2_U0_receiver_recoder_mux04871 : LUT4
    generic map(
      INIT => X"AA2A"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(19),
      I1 => BU2_U0_receiver_recoder_N17,
      I2 => BU2_U0_receiver_recoder_rxc_pipe(2),
      I3 => BU2_N1564,
      O => BU2_U0_receiver_recoder_mux0487
    );
  BU2_U0_receiver_deskew_state_mux0044_0_11_SW0 : LUT4
    generic map(
      INIT => X"D5C0"
    )
    port map (
      I0 => BU2_U0_receiver_deskew_state_deskew_error(0),
      I1 => BU2_U0_receiver_deskew_state_got_align(1),
      I2 => BU2_U0_receiver_deskew_state_state_1_2_1_41,
      I3 => BU2_U0_receiver_deskew_state_deskew_error(1),
      O => BU2_N4898
    );
  BU2_U0_receiver_deskew_state_mux0044_0_235 : LUT4
    generic map(
      INIT => X"2070"
    )
    port map (
      I0 => BU2_U0_receiver_deskew_state_state_1_1_44,
      I1 => BU2_N4896,
      I2 => BU2_U0_receiver_deskew_state_mux0044_0_map2208,
      I3 => BU2_N4895,
      O => BU2_U0_receiver_deskew_state_mux0044_0_map2209
    );
  BU2_U0_receiver_deskew_state_mux0044_0_235_SW0 : LUT3
    generic map(
      INIT => X"4F"
    )
    port map (
      I0 => BU2_U0_receiver_deskew_state_got_align(0),
      I1 => BU2_U0_receiver_deskew_state_state_1_0_45,
      I2 => BU2_U0_receiver_deskew_state_deskew_error(1),
      O => BU2_N4895
    );
  BU2_U0_transmitter_filter0_mux0001165 : LUT4
    generic map(
      INIT => X"FD75"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(4),
      I1 => BU2_U0_transmitter_filter0_mux00011_map1895,
      I2 => BU2_N4892,
      I3 => BU2_N4893,
      O => BU2_U0_transmitter_filter0_N01
    );
  BU2_U0_transmitter_filter0_mux0001165_SW1 : LUT4
    generic map(
      INIT => X"FFBF"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(1),
      I1 => BU2_U0_transmitter_txd_pipe(3),
      I2 => BU2_U0_transmitter_txd_pipe(2),
      I3 => BU2_U0_transmitter_txd_pipe(0),
      O => BU2_N4893
    );
  BU2_U0_transmitter_filter0_mux0001165_SW0 : LUT4
    generic map(
      INIT => X"957F"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(3),
      I1 => BU2_U0_transmitter_txd_pipe(0),
      I2 => BU2_U0_transmitter_txd_pipe(1),
      I3 => BU2_U0_transmitter_txd_pipe(2),
      O => BU2_N4892
    );
  BU2_U0_transmitter_filter1_mux0001165 : LUT4
    generic map(
      INIT => X"FD75"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(12),
      I1 => BU2_U0_transmitter_filter1_mux00011_map1870,
      I2 => BU2_N4889,
      I3 => BU2_N4890,
      O => BU2_U0_transmitter_filter1_N01
    );
  BU2_U0_transmitter_filter1_mux0001165_SW1 : LUT4
    generic map(
      INIT => X"FFBF"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(9),
      I1 => BU2_U0_transmitter_txd_pipe(11),
      I2 => BU2_U0_transmitter_txd_pipe(10),
      I3 => BU2_U0_transmitter_txd_pipe(8),
      O => BU2_N4890
    );
  BU2_U0_transmitter_filter1_mux0001165_SW0 : LUT4
    generic map(
      INIT => X"957F"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(11),
      I1 => BU2_U0_transmitter_txd_pipe(8),
      I2 => BU2_U0_transmitter_txd_pipe(9),
      I3 => BU2_U0_transmitter_txd_pipe(10),
      O => BU2_N4889
    );
  BU2_U0_transmitter_filter2_mux0001165 : LUT4
    generic map(
      INIT => X"FD75"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(20),
      I1 => BU2_U0_transmitter_filter2_mux00011_map1845,
      I2 => BU2_N4886,
      I3 => BU2_N4887,
      O => BU2_U0_transmitter_filter2_N01
    );
  BU2_U0_transmitter_filter2_mux0001165_SW1 : LUT4
    generic map(
      INIT => X"FFBF"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(17),
      I1 => BU2_U0_transmitter_txd_pipe(19),
      I2 => BU2_U0_transmitter_txd_pipe(18),
      I3 => BU2_U0_transmitter_txd_pipe(16),
      O => BU2_N4887
    );
  BU2_U0_transmitter_filter2_mux0001165_SW0 : LUT4
    generic map(
      INIT => X"957F"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(19),
      I1 => BU2_U0_transmitter_txd_pipe(16),
      I2 => BU2_U0_transmitter_txd_pipe(17),
      I3 => BU2_U0_transmitter_txd_pipe(18),
      O => BU2_N4886
    );
  BU2_U0_transmitter_filter3_mux0001165 : LUT4
    generic map(
      INIT => X"FD75"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(28),
      I1 => BU2_U0_transmitter_filter3_mux00011_map1820,
      I2 => BU2_N4883,
      I3 => BU2_N4884,
      O => BU2_U0_transmitter_filter3_N01
    );
  BU2_U0_transmitter_filter3_mux0001165_SW1 : LUT4
    generic map(
      INIT => X"FFBF"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(25),
      I1 => BU2_U0_transmitter_txd_pipe(27),
      I2 => BU2_U0_transmitter_txd_pipe(26),
      I3 => BU2_U0_transmitter_txd_pipe(24),
      O => BU2_N4884
    );
  BU2_U0_transmitter_filter3_mux0001165_SW0 : LUT4
    generic map(
      INIT => X"957F"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(27),
      I1 => BU2_U0_transmitter_txd_pipe(24),
      I2 => BU2_U0_transmitter_txd_pipe(25),
      I3 => BU2_U0_transmitter_txd_pipe(26),
      O => BU2_N4883
    );
  BU2_U0_transmitter_filter4_mux0001165 : LUT4
    generic map(
      INIT => X"FD75"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(36),
      I1 => BU2_U0_transmitter_filter4_mux00011_map1795,
      I2 => BU2_N4880,
      I3 => BU2_N4881,
      O => BU2_U0_transmitter_filter4_N01
    );
  BU2_U0_transmitter_filter4_mux0001165_SW1 : LUT4
    generic map(
      INIT => X"FFBF"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(33),
      I1 => BU2_U0_transmitter_txd_pipe(35),
      I2 => BU2_U0_transmitter_txd_pipe(34),
      I3 => BU2_U0_transmitter_txd_pipe(32),
      O => BU2_N4881
    );
  BU2_U0_transmitter_filter4_mux0001165_SW0 : LUT4
    generic map(
      INIT => X"957F"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(35),
      I1 => BU2_U0_transmitter_txd_pipe(32),
      I2 => BU2_U0_transmitter_txd_pipe(33),
      I3 => BU2_U0_transmitter_txd_pipe(34),
      O => BU2_N4880
    );
  BU2_U0_transmitter_filter5_mux0001165 : LUT4
    generic map(
      INIT => X"FD75"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(44),
      I1 => BU2_U0_transmitter_filter5_mux00011_map1770,
      I2 => BU2_N4877,
      I3 => BU2_N4878,
      O => BU2_U0_transmitter_filter5_N01
    );
  BU2_U0_transmitter_filter5_mux0001165_SW1 : LUT4
    generic map(
      INIT => X"FFBF"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(41),
      I1 => BU2_U0_transmitter_txd_pipe(43),
      I2 => BU2_U0_transmitter_txd_pipe(42),
      I3 => BU2_U0_transmitter_txd_pipe(40),
      O => BU2_N4878
    );
  BU2_U0_transmitter_filter5_mux0001165_SW0 : LUT4
    generic map(
      INIT => X"957F"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(43),
      I1 => BU2_U0_transmitter_txd_pipe(40),
      I2 => BU2_U0_transmitter_txd_pipe(41),
      I3 => BU2_U0_transmitter_txd_pipe(42),
      O => BU2_N4877
    );
  BU2_U0_transmitter_filter6_mux0001165 : LUT4
    generic map(
      INIT => X"FD75"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(52),
      I1 => BU2_U0_transmitter_filter6_mux00011_map1745,
      I2 => BU2_N4874,
      I3 => BU2_N4875,
      O => BU2_U0_transmitter_filter6_N01
    );
  BU2_U0_transmitter_filter6_mux0001165_SW1 : LUT4
    generic map(
      INIT => X"FFBF"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(49),
      I1 => BU2_U0_transmitter_txd_pipe(51),
      I2 => BU2_U0_transmitter_txd_pipe(50),
      I3 => BU2_U0_transmitter_txd_pipe(48),
      O => BU2_N4875
    );
  BU2_U0_transmitter_filter6_mux0001165_SW0 : LUT4
    generic map(
      INIT => X"957F"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(51),
      I1 => BU2_U0_transmitter_txd_pipe(48),
      I2 => BU2_U0_transmitter_txd_pipe(49),
      I3 => BU2_U0_transmitter_txd_pipe(50),
      O => BU2_N4874
    );
  BU2_U0_transmitter_filter7_mux0001165 : LUT4
    generic map(
      INIT => X"FD75"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(60),
      I1 => BU2_U0_transmitter_filter7_mux00011_map1720,
      I2 => BU2_N4871,
      I3 => BU2_N4872,
      O => BU2_U0_transmitter_filter7_N01
    );
  BU2_U0_transmitter_filter7_mux0001165_SW1 : LUT4
    generic map(
      INIT => X"FFBF"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(57),
      I1 => BU2_U0_transmitter_txd_pipe(59),
      I2 => BU2_U0_transmitter_txd_pipe(58),
      I3 => BU2_U0_transmitter_txd_pipe(56),
      O => BU2_N4872
    );
  BU2_U0_transmitter_filter7_mux0001165_SW0 : LUT4
    generic map(
      INIT => X"957F"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(59),
      I1 => BU2_U0_transmitter_txd_pipe(56),
      I2 => BU2_U0_transmitter_txd_pipe(57),
      I3 => BU2_U0_transmitter_txd_pipe(58),
      O => BU2_N4871
    );
  BU2_U0_receiver_deskew_state_mux0044_1_219 : LUT3
    generic map(
      INIT => X"01"
    )
    port map (
      I0 => NlwRenamedSig_OI_align_status,
      I1 => BU2_U0_receiver_deskew_state_deskew_error(1),
      I2 => BU2_N4869,
      O => BU2_U0_receiver_deskew_state_mux0044_1_map2724
    );
  BU2_U0_receiver_deskew_state_mux0044_0_189_SW0 : LUT4
    generic map(
      INIT => X"FEE6"
    )
    port map (
      I0 => BU2_U0_receiver_deskew_state_state_1_0_45,
      I1 => BU2_U0_receiver_deskew_state_got_align(0),
      I2 => BU2_U0_receiver_deskew_state_state_1_1_44,
      I3 => BU2_U0_receiver_deskew_state_deskew_error(1),
      O => BU2_N4867
    );
  BU2_U0_transmitter_recoder_mux04591 : LUT4
    generic map(
      INIT => X"FFEA"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_N37,
      I1 => BU2_U0_transmitter_recoder_N47,
      I2 => BU2_U0_transmitter_filter4_txc_out_83,
      I3 => BU2_N4851,
      O => BU2_U0_transmitter_recoder_mux0459
    );
  BU2_U0_transmitter_recoder_mux04601 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_N4851,
      I1 => BU2_U0_transmitter_recoder_N47,
      I2 => BU2_U0_transmitter_filter5_txc_out_84,
      O => BU2_U0_transmitter_recoder_mux0460
    );
  BU2_U0_transmitter_recoder_mux04611 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_N4851,
      I1 => BU2_U0_transmitter_recoder_N47,
      I2 => BU2_U0_transmitter_filter6_txc_out_85,
      O => BU2_U0_transmitter_recoder_mux0461
    );
  BU2_U0_transmitter_recoder_mux04621 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_N4851,
      I1 => BU2_U0_transmitter_recoder_N47,
      I2 => BU2_U0_transmitter_filter7_txc_out_86,
      O => BU2_U0_transmitter_recoder_mux0462
    );
  BU2_U0_transmitter_recoder_mux04621_SW0 : LUT4
    generic map(
      INIT => X"CEE4"
    )
    port map (
      I0 => configuration_vector_123(4),
      I1 => BU2_U0_transmitter_recoder_N43,
      I2 => configuration_vector_123(5),
      I3 => configuration_vector_123(6),
      O => BU2_N4851
    );
  BU2_U0_transmitter_recoder_mux04531 : LUT4
    generic map(
      INIT => X"FFEA"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_N38,
      I1 => BU2_U0_transmitter_recoder_N35,
      I2 => BU2_U0_transmitter_filter0_txc_out_79,
      I3 => BU2_N4835,
      O => BU2_U0_transmitter_recoder_mux0453
    );
  BU2_U0_transmitter_recoder_mux04551 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_N4835,
      I1 => BU2_U0_transmitter_recoder_N35,
      I2 => BU2_U0_transmitter_filter1_txc_out_80,
      O => BU2_U0_transmitter_recoder_mux0455
    );
  BU2_U0_transmitter_recoder_mux04571 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_N4835,
      I1 => BU2_U0_transmitter_recoder_N35,
      I2 => BU2_U0_transmitter_filter2_txc_out_81,
      O => BU2_U0_transmitter_recoder_mux0457
    );
  BU2_U0_transmitter_recoder_mux04581 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_N4835,
      I1 => BU2_U0_transmitter_recoder_N35,
      I2 => BU2_U0_transmitter_filter3_txc_out_82,
      O => BU2_U0_transmitter_recoder_mux0458
    );
  BU2_U0_transmitter_recoder_mux04581_SW0 : LUT4
    generic map(
      INIT => X"CEE4"
    )
    port map (
      I0 => configuration_vector_123(4),
      I1 => BU2_U0_transmitter_recoder_N46,
      I2 => configuration_vector_123(5),
      I3 => configuration_vector_123(6),
      O => BU2_N4835
    );
  BU2_U0_receiver_pcs_sync_state0_next_state_1_0_2 : LUT4
    generic map(
      INIT => X"F0F8"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_state_1_0_52,
      I1 => BU2_N5215,
      I2 => BU2_U0_receiver_pcs_sync_state0_mux0008_6_Q,
      I3 => BU2_U0_receiver_pcs_sync_state0_signal_detect_change,
      O => BU2_U0_receiver_pcs_sync_state0_next_state_1_0_map2884
    );
  BU2_U0_receiver_pcs_sync_state1_next_state_1_0_2 : LUT4
    generic map(
      INIT => X"F0F8"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_state_1_0_58,
      I1 => BU2_N5213,
      I2 => BU2_U0_receiver_pcs_sync_state1_mux0008_6_Q,
      I3 => BU2_U0_receiver_pcs_sync_state1_signal_detect_change,
      O => BU2_U0_receiver_pcs_sync_state1_next_state_1_0_map2833
    );
  BU2_U0_receiver_pcs_sync_state2_next_state_1_0_2 : LUT4
    generic map(
      INIT => X"F0F8"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_state_1_0_64,
      I1 => BU2_N5211,
      I2 => BU2_U0_receiver_pcs_sync_state2_mux0008_6_Q,
      I3 => BU2_U0_receiver_pcs_sync_state2_signal_detect_change,
      O => BU2_U0_receiver_pcs_sync_state2_next_state_1_0_map2782
    );
  BU2_U0_receiver_pcs_sync_state3_next_state_1_0_2 : LUT4
    generic map(
      INIT => X"F0F8"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_state_1_0_70,
      I1 => BU2_N5209,
      I2 => BU2_U0_receiver_pcs_sync_state3_mux0008_6_Q,
      I3 => BU2_U0_receiver_pcs_sync_state3_signal_detect_change,
      O => BU2_U0_receiver_pcs_sync_state3_next_state_1_0_map2731
    );
  BU2_U0_receiver_pcs_sync_state0_mux0018_2_111_SW0 : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_state_1_4_48,
      I1 => BU2_U0_receiver_pcs_sync_state0_state_1_2_50,
      I2 => BU2_U0_receiver_pcs_sync_state0_state_1_1_51,
      I3 => BU2_N4817,
      O => BU2_N4769
    );
  BU2_U0_receiver_pcs_sync_state1_mux0018_2_111_SW0 : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_state_1_4_54,
      I1 => BU2_U0_receiver_pcs_sync_state1_state_1_2_56,
      I2 => BU2_U0_receiver_pcs_sync_state1_state_1_1_57,
      I3 => BU2_N4815,
      O => BU2_N4767
    );
  BU2_U0_receiver_pcs_sync_state2_mux0018_2_111_SW0 : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_state_1_4_60,
      I1 => BU2_U0_receiver_pcs_sync_state2_state_1_2_62,
      I2 => BU2_U0_receiver_pcs_sync_state2_state_1_1_63,
      I3 => BU2_N4813,
      O => BU2_N4765
    );
  BU2_U0_receiver_pcs_sync_state3_mux0018_2_111_SW0 : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_state_1_4_66,
      I1 => BU2_U0_receiver_pcs_sync_state3_state_1_2_68,
      I2 => BU2_U0_receiver_pcs_sync_state3_state_1_1_69,
      I3 => BU2_N4811,
      O => BU2_N4763
    );
  BU2_U0_transmitter_state_machine_mux0003_0_37_SW1 : LUT4
    generic map(
      INIT => X"ABA8"
    )
    port map (
      I0 => BU2_N5267,
      I1 => BU2_U0_transmitter_align_not0002,
      I2 => BU2_N4527,
      I3 => BU2_N4808,
      O => BU2_N4492
    );
  BU2_U0_transmitter_state_machine_mux0003_0_37_SW0 : LUT4
    generic map(
      INIT => X"ABA8"
    )
    port map (
      I0 => BU2_N4806,
      I1 => BU2_U0_transmitter_align_not0002,
      I2 => BU2_N4527,
      I3 => BU2_N4805,
      O => BU2_N4490
    );
  BU2_U0_receiver_recoder_or002666 : LUT4
    generic map(
      INIT => X"FFD8"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_N15,
      I1 => BU2_N4803,
      I2 => BU2_N4802,
      I3 => BU2_N5262,
      O => BU2_U0_receiver_recoder_error_lane(1)
    );
  BU2_U0_receiver_recoder_or00269_SW1 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_delay(1),
      I1 => BU2_U0_receiver_recoder_lane_terminate(0),
      I2 => BU2_N5246,
      O => BU2_N4803
    );
  BU2_U0_receiver_recoder_or00269_SW0 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_lane_terminate(0),
      I1 => BU2_U0_receiver_recoder_code_error_delay(1),
      O => BU2_N4802
    );
  BU2_U0_receiver_recoder_or00151 : LUT4
    generic map(
      INIT => X"FFD8"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_or0032_map2300,
      I1 => BU2_N4800,
      I2 => BU2_N4799,
      I3 => BU2_N5260,
      O => BU2_U0_receiver_recoder_or0015
    );
  BU2_U0_receiver_recoder_or003258_SW0 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_pipe(3),
      I1 => BU2_N5208,
      I2 => BU2_U0_receiver_recoder_or0032_map2293,
      O => BU2_N4799
    );
  BU2_U0_receiver_recoder_or00212 : LUT4
    generic map(
      INIT => X"0008"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(4),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(3),
      I2 => BU2_N4797,
      I3 => BU2_N2440,
      O => BU2_U0_receiver_recoder_or0021
    );
  BU2_U0_receiver_recoder_or00211_SW1 : LUT4
    generic map(
      INIT => X"BF6F"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(7),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(5),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(2),
      I3 => BU2_U0_receiver_recoder_rxd_pipe(6),
      O => BU2_N4797
    );
  BU2_U0_receiver_recoder_and0020_SW1 : LUT3
    generic map(
      INIT => X"F7"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(21),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(19),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(16),
      O => BU2_N4795
    );
  BU2_U0_receiver_pcs_sync_state3_mux0008_2_Q : LUT4
    generic map(
      INIT => X"0021"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(3),
      I1 => BU2_N4444,
      I2 => BU2_U0_receiver_pcs_sync_state3_signal_detect_last_71,
      I3 => BU2_U0_receiver_sync_ok_int(3),
      O => BU2_U0_receiver_pcs_sync_state3_mux0008_2_Q_35
    );
  BU2_U0_receiver_pcs_sync_state2_mux0008_2_Q : LUT4
    generic map(
      INIT => X"0021"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(2),
      I1 => BU2_N4440,
      I2 => BU2_U0_receiver_pcs_sync_state2_signal_detect_last_65,
      I3 => BU2_U0_receiver_sync_ok_int(2),
      O => BU2_U0_receiver_pcs_sync_state2_mux0008_2_Q_32
    );
  BU2_U0_receiver_pcs_sync_state1_mux0008_2_Q : LUT4
    generic map(
      INIT => X"0021"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(1),
      I1 => BU2_N4436,
      I2 => BU2_U0_receiver_pcs_sync_state1_signal_detect_last_59,
      I3 => BU2_U0_receiver_sync_ok_int(1),
      O => BU2_U0_receiver_pcs_sync_state1_mux0008_2_Q_29
    );
  BU2_U0_receiver_pcs_sync_state0_mux0008_2_Q : LUT4
    generic map(
      INIT => X"0021"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(0),
      I1 => BU2_N4432,
      I2 => BU2_U0_receiver_pcs_sync_state0_signal_detect_last_53,
      I3 => BU2_U0_receiver_sync_ok_int(0),
      O => BU2_U0_receiver_pcs_sync_state0_mux0008_2_Q_26
    );
  BU2_U0_receiver_pcs_sync_state0_mux0008_1_Q : LUT4
    generic map(
      INIT => X"0021"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(0),
      I1 => BU2_N3519,
      I2 => BU2_U0_receiver_pcs_sync_state0_signal_detect_last_53,
      I3 => BU2_N4777,
      O => BU2_U0_receiver_pcs_sync_state0_mux0008_1_Q_27
    );
  BU2_U0_receiver_pcs_sync_state1_mux0008_1_Q : LUT4
    generic map(
      INIT => X"0021"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(1),
      I1 => BU2_N3517,
      I2 => BU2_U0_receiver_pcs_sync_state1_signal_detect_last_59,
      I3 => BU2_N4775,
      O => BU2_U0_receiver_pcs_sync_state1_mux0008_1_Q_30
    );
  BU2_U0_receiver_pcs_sync_state2_mux0008_1_Q : LUT4
    generic map(
      INIT => X"0021"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(2),
      I1 => BU2_N3515,
      I2 => BU2_U0_receiver_pcs_sync_state2_signal_detect_last_65,
      I3 => BU2_N4773,
      O => BU2_U0_receiver_pcs_sync_state2_mux0008_1_Q_33
    );
  BU2_U0_receiver_pcs_sync_state3_mux0008_1_Q : LUT4
    generic map(
      INIT => X"0021"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(3),
      I1 => BU2_N3513,
      I2 => BU2_U0_receiver_pcs_sync_state3_signal_detect_last_71,
      I3 => BU2_N4771,
      O => BU2_U0_receiver_pcs_sync_state3_mux0008_1_Q_36
    );
  BU2_U0_receiver_pcs_sync_state0_mux0018_2_111 : LUT4
    generic map(
      INIT => X"9099"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(0),
      I1 => BU2_U0_receiver_pcs_sync_state0_signal_detect_last_53,
      I2 => BU2_U0_receiver_pcs_sync_state0_mux0019(8),
      I3 => BU2_N4769,
      O => BU2_U0_receiver_pcs_sync_state0_N111
    );
  BU2_U0_receiver_pcs_sync_state1_mux0018_2_111 : LUT4
    generic map(
      INIT => X"9099"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(1),
      I1 => BU2_U0_receiver_pcs_sync_state1_signal_detect_last_59,
      I2 => BU2_U0_receiver_pcs_sync_state1_mux0019(8),
      I3 => BU2_N4767,
      O => BU2_U0_receiver_pcs_sync_state1_N111
    );
  BU2_U0_receiver_pcs_sync_state2_mux0018_2_111 : LUT4
    generic map(
      INIT => X"9099"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(2),
      I1 => BU2_U0_receiver_pcs_sync_state2_signal_detect_last_65,
      I2 => BU2_U0_receiver_pcs_sync_state2_mux0019(8),
      I3 => BU2_N4765,
      O => BU2_U0_receiver_pcs_sync_state2_N111
    );
  BU2_U0_receiver_pcs_sync_state3_mux0018_2_111 : LUT4
    generic map(
      INIT => X"9099"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(3),
      I1 => BU2_U0_receiver_pcs_sync_state3_signal_detect_last_71,
      I2 => BU2_U0_receiver_pcs_sync_state3_mux0019(8),
      I3 => BU2_N4763,
      O => BU2_U0_receiver_pcs_sync_state3_N111
    );
  BU2_U0_receiver_pcs_sync_state0_next_state_1_0_150_SW1 : LUT4
    generic map(
      INIT => X"F666"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(0),
      I1 => BU2_U0_receiver_pcs_sync_state0_signal_detect_last_53,
      I2 => BU2_N4519,
      I3 => BU2_N4761,
      O => BU2_N4503
    );
  BU2_U0_receiver_pcs_sync_state1_next_state_1_0_150_SW1 : LUT4
    generic map(
      INIT => X"F666"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(1),
      I1 => BU2_U0_receiver_pcs_sync_state1_signal_detect_last_59,
      I2 => BU2_N4517,
      I3 => BU2_N4759,
      O => BU2_N4501
    );
  BU2_U0_receiver_pcs_sync_state2_next_state_1_0_150_SW1 : LUT4
    generic map(
      INIT => X"F666"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(2),
      I1 => BU2_U0_receiver_pcs_sync_state2_signal_detect_last_65,
      I2 => BU2_N4515,
      I3 => BU2_N4757,
      O => BU2_N4499
    );
  BU2_U0_receiver_pcs_sync_state3_next_state_1_0_150_SW1 : LUT4
    generic map(
      INIT => X"F666"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(3),
      I1 => BU2_U0_receiver_pcs_sync_state3_signal_detect_last_71,
      I2 => BU2_N4513,
      I3 => BU2_N4755,
      O => BU2_N4497
    );
  BU2_U0_receiver_pcs_sync_state0_next_state_1_3_39 : LUT4
    generic map(
      INIT => X"82C3"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_next_state_1_3_map2379,
      I1 => BU2_U0_signal_detect_int(0),
      I2 => BU2_U0_receiver_pcs_sync_state0_signal_detect_last_53,
      I3 => BU2_N4753,
      O => BU2_U0_receiver_pcs_sync_state0_next_state(1, 3)
    );
  BU2_U0_receiver_pcs_sync_state1_next_state_1_3_39 : LUT4
    generic map(
      INIT => X"82C3"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_next_state_1_3_map2366,
      I1 => BU2_U0_signal_detect_int(1),
      I2 => BU2_U0_receiver_pcs_sync_state1_signal_detect_last_59,
      I3 => BU2_N4751,
      O => BU2_U0_receiver_pcs_sync_state1_next_state(1, 3)
    );
  BU2_U0_receiver_pcs_sync_state2_next_state_1_3_39 : LUT4
    generic map(
      INIT => X"82C3"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_next_state_1_3_map2353,
      I1 => BU2_U0_signal_detect_int(2),
      I2 => BU2_U0_receiver_pcs_sync_state2_signal_detect_last_65,
      I3 => BU2_N4749,
      O => BU2_U0_receiver_pcs_sync_state2_next_state(1, 3)
    );
  BU2_U0_receiver_pcs_sync_state3_next_state_1_3_39 : LUT4
    generic map(
      INIT => X"82C3"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_next_state_1_3_map2340,
      I1 => BU2_U0_signal_detect_int(3),
      I2 => BU2_U0_receiver_pcs_sync_state3_signal_detect_last_71,
      I3 => BU2_N4747,
      O => BU2_U0_receiver_pcs_sync_state3_next_state(1, 3)
    );
  BU2_U0_receiver_recoder_or002727 : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(23),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(21),
      I2 => BU2_N4523,
      I3 => BU2_N4745,
      O => BU2_U0_receiver_recoder_or0027_map2629
    );
  BU2_U0_receiver_pcs_sync_state0_next_state_1_0_150_SW0_SW0 : LUT4
    generic map(
      INIT => X"FFFD"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_state_1_2_50,
      I1 => BU2_U0_receiver_pcs_sync_state0_state_1_1_51,
      I2 => BU2_N3011,
      I3 => BU2_U0_receiver_pcs_sync_state0_state_1_0_52,
      O => BU2_N4519
    );
  BU2_U0_receiver_pcs_sync_state1_next_state_1_0_150_SW0_SW0 : LUT4
    generic map(
      INIT => X"FFFD"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_state_1_2_56,
      I1 => BU2_U0_receiver_pcs_sync_state1_state_1_1_57,
      I2 => BU2_N3009,
      I3 => BU2_U0_receiver_pcs_sync_state1_state_1_0_58,
      O => BU2_N4517
    );
  BU2_U0_receiver_pcs_sync_state2_next_state_1_0_150_SW0_SW0 : LUT4
    generic map(
      INIT => X"FFFD"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_state_1_2_62,
      I1 => BU2_U0_receiver_pcs_sync_state2_state_1_1_63,
      I2 => BU2_N3007,
      I3 => BU2_U0_receiver_pcs_sync_state2_state_1_0_64,
      O => BU2_N4515
    );
  BU2_U0_receiver_pcs_sync_state3_next_state_1_0_150_SW0_SW0 : LUT4
    generic map(
      INIT => X"FFFD"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_state_1_2_68,
      I1 => BU2_U0_receiver_pcs_sync_state3_state_1_1_69,
      I2 => BU2_N3005,
      I3 => BU2_U0_receiver_pcs_sync_state3_state_1_0_70,
      O => BU2_N4513
    );
  BU2_U0_transmitter_filter7_mux0007_6_1 : LUT4
    generic map(
      INIT => X"13B3"
    )
    port map (
      I0 => BU2_U0_transmitter_filter7_xor0001_map2022,
      I1 => BU2_N4694,
      I2 => BU2_U0_transmitter_is_terminate(1),
      I3 => BU2_N4695,
      O => BU2_U0_transmitter_filter7_mux0007(6)
    );
  BU2_U0_transmitter_filter7_xor000132_SW11 : LUT4
    generic map(
      INIT => X"DD15"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(57),
      I1 => BU2_U0_transmitter_txc_pipe(7),
      I2 => BU2_U0_transmitter_filter7_N01,
      I3 => BU2_U0_transmitter_filter7_xor0001_map2015,
      O => BU2_N4695
    );
  BU2_U0_transmitter_filter7_mux0007_1_1 : LUT4
    generic map(
      INIT => X"13B3"
    )
    port map (
      I0 => BU2_U0_transmitter_filter7_xor0001_map2022,
      I1 => BU2_N4691,
      I2 => BU2_U0_transmitter_is_terminate(1),
      I3 => BU2_N4692,
      O => BU2_U0_transmitter_filter7_mux0007(1)
    );
  BU2_U0_transmitter_filter7_xor000132_SW9 : LUT4
    generic map(
      INIT => X"DD15"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(62),
      I1 => BU2_U0_transmitter_txc_pipe(7),
      I2 => BU2_U0_transmitter_filter7_N01,
      I3 => BU2_U0_transmitter_filter7_xor0001_map2015,
      O => BU2_N4692
    );
  BU2_U0_transmitter_filter7_mux0007_4_1 : LUT4
    generic map(
      INIT => X"DF80"
    )
    port map (
      I0 => BU2_U0_transmitter_filter7_xor0001_map2022,
      I1 => BU2_N4689,
      I2 => BU2_U0_transmitter_is_terminate(1),
      I3 => BU2_N4688,
      O => BU2_U0_transmitter_filter7_mux0007(4)
    );
  BU2_U0_transmitter_filter7_xor000132_SW6 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(59),
      I1 => BU2_U0_transmitter_txc_pipe(7),
      I2 => BU2_U0_transmitter_filter7_N01,
      O => BU2_N4688
    );
  BU2_U0_transmitter_filter7_mux0007_2_1 : LUT4
    generic map(
      INIT => X"DF80"
    )
    port map (
      I0 => BU2_U0_transmitter_filter7_xor0001_map2022,
      I1 => BU2_N4686,
      I2 => BU2_U0_transmitter_is_terminate(1),
      I3 => BU2_N4685,
      O => BU2_U0_transmitter_filter7_mux0007(2)
    );
  BU2_U0_transmitter_filter7_xor000132_SW4 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(61),
      I1 => BU2_U0_transmitter_txc_pipe(7),
      I2 => BU2_U0_transmitter_filter7_N01,
      O => BU2_N4685
    );
  BU2_U0_transmitter_filter7_mux0007_0_1 : LUT4
    generic map(
      INIT => X"DF80"
    )
    port map (
      I0 => BU2_U0_transmitter_filter7_xor0001_map2022,
      I1 => BU2_N4683,
      I2 => BU2_U0_transmitter_is_terminate(1),
      I3 => BU2_N4682,
      O => BU2_U0_transmitter_filter7_mux0007(0)
    );
  BU2_U0_transmitter_filter7_xor000132_SW3 : LUT4
    generic map(
      INIT => X"EEEA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(63),
      I1 => BU2_U0_transmitter_txc_pipe(7),
      I2 => BU2_U0_transmitter_filter7_N01,
      I3 => BU2_N5197,
      O => BU2_N4683
    );
  BU2_U0_transmitter_filter7_xor000132_SW2 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(63),
      I1 => BU2_U0_transmitter_txc_pipe(7),
      I2 => BU2_U0_transmitter_filter7_N01,
      O => BU2_N4682
    );
  BU2_U0_transmitter_filter7_mux0007_7_1 : LUT4
    generic map(
      INIT => X"13B3"
    )
    port map (
      I0 => BU2_U0_transmitter_filter7_xor0001_map2022,
      I1 => BU2_N4679,
      I2 => BU2_U0_transmitter_is_terminate(1),
      I3 => BU2_N4680,
      O => BU2_U0_transmitter_filter7_mux0007(7)
    );
  BU2_U0_transmitter_filter7_xor000132_SW1 : LUT4
    generic map(
      INIT => X"DDD5"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(56),
      I1 => BU2_U0_transmitter_txc_pipe(7),
      I2 => BU2_U0_transmitter_filter7_N01,
      I3 => BU2_U0_transmitter_filter7_xor0001_map2015,
      O => BU2_N4680
    );
  BU2_U0_transmitter_filter6_mux0007_6_1 : LUT4
    generic map(
      INIT => X"13B3"
    )
    port map (
      I0 => BU2_U0_transmitter_filter6_xor0001_map2035,
      I1 => BU2_N4676,
      I2 => BU2_U0_transmitter_is_terminate(1),
      I3 => BU2_N4677,
      O => BU2_U0_transmitter_filter6_mux0007(6)
    );
  BU2_U0_transmitter_filter6_xor000132_SW11 : LUT4
    generic map(
      INIT => X"DD15"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(49),
      I1 => BU2_U0_transmitter_txc_pipe(6),
      I2 => BU2_U0_transmitter_filter6_N01,
      I3 => BU2_U0_transmitter_filter6_xor0001_map2028,
      O => BU2_N4677
    );
  BU2_U0_transmitter_filter6_mux0007_1_1 : LUT4
    generic map(
      INIT => X"13B3"
    )
    port map (
      I0 => BU2_U0_transmitter_filter6_xor0001_map2035,
      I1 => BU2_N4673,
      I2 => BU2_U0_transmitter_is_terminate(1),
      I3 => BU2_N4674,
      O => BU2_U0_transmitter_filter6_mux0007(1)
    );
  BU2_U0_transmitter_filter6_xor000132_SW9 : LUT4
    generic map(
      INIT => X"DD15"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(54),
      I1 => BU2_U0_transmitter_txc_pipe(6),
      I2 => BU2_U0_transmitter_filter6_N01,
      I3 => BU2_U0_transmitter_filter6_xor0001_map2028,
      O => BU2_N4674
    );
  BU2_U0_transmitter_filter6_mux0007_4_1 : LUT4
    generic map(
      INIT => X"DF80"
    )
    port map (
      I0 => BU2_U0_transmitter_filter6_xor0001_map2035,
      I1 => BU2_N4671,
      I2 => BU2_U0_transmitter_is_terminate(1),
      I3 => BU2_N4670,
      O => BU2_U0_transmitter_filter6_mux0007(4)
    );
  BU2_U0_transmitter_filter6_xor000132_SW6 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(51),
      I1 => BU2_U0_transmitter_txc_pipe(6),
      I2 => BU2_U0_transmitter_filter6_N01,
      O => BU2_N4670
    );
  BU2_U0_transmitter_filter6_mux0007_0_1 : LUT4
    generic map(
      INIT => X"DF80"
    )
    port map (
      I0 => BU2_U0_transmitter_filter6_xor0001_map2035,
      I1 => BU2_N4668,
      I2 => BU2_U0_transmitter_is_terminate(1),
      I3 => BU2_N4667,
      O => BU2_U0_transmitter_filter6_mux0007(0)
    );
  BU2_U0_transmitter_filter6_xor000132_SW4 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(55),
      I1 => BU2_U0_transmitter_txc_pipe(6),
      I2 => BU2_U0_transmitter_filter6_N01,
      O => BU2_N4667
    );
  BU2_U0_transmitter_filter6_mux0007_2_1 : LUT4
    generic map(
      INIT => X"DF80"
    )
    port map (
      I0 => BU2_U0_transmitter_filter6_xor0001_map2035,
      I1 => BU2_N4665,
      I2 => BU2_U0_transmitter_is_terminate(1),
      I3 => BU2_N4664,
      O => BU2_U0_transmitter_filter6_mux0007(2)
    );
  BU2_U0_transmitter_filter6_xor000132_SW2 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(53),
      I1 => BU2_U0_transmitter_txc_pipe(6),
      I2 => BU2_U0_transmitter_filter6_N01,
      O => BU2_N4664
    );
  BU2_U0_transmitter_filter6_mux0007_7_1 : LUT4
    generic map(
      INIT => X"13B3"
    )
    port map (
      I0 => BU2_U0_transmitter_filter6_xor0001_map2035,
      I1 => BU2_N4661,
      I2 => BU2_U0_transmitter_is_terminate(1),
      I3 => BU2_N4662,
      O => BU2_U0_transmitter_filter6_mux0007(7)
    );
  BU2_U0_transmitter_filter6_xor000132_SW1 : LUT4
    generic map(
      INIT => X"DDD5"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(48),
      I1 => BU2_U0_transmitter_txc_pipe(6),
      I2 => BU2_U0_transmitter_filter6_N01,
      I3 => BU2_N5198,
      O => BU2_N4662
    );
  BU2_U0_transmitter_filter5_mux0007_6_1 : LUT4
    generic map(
      INIT => X"13B3"
    )
    port map (
      I0 => BU2_U0_transmitter_filter5_xor0001_map2048,
      I1 => BU2_N4658,
      I2 => BU2_U0_transmitter_is_terminate(1),
      I3 => BU2_N4659,
      O => BU2_U0_transmitter_filter5_mux0007(6)
    );
  BU2_U0_transmitter_filter5_xor000132_SW11 : LUT4
    generic map(
      INIT => X"DD15"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(41),
      I1 => BU2_U0_transmitter_txc_pipe(5),
      I2 => BU2_U0_transmitter_filter5_N01,
      I3 => BU2_U0_transmitter_filter5_xor0001_map2041,
      O => BU2_N4659
    );
  BU2_U0_transmitter_filter5_mux0007_1_1 : LUT4
    generic map(
      INIT => X"13B3"
    )
    port map (
      I0 => BU2_U0_transmitter_filter5_xor0001_map2048,
      I1 => BU2_N4655,
      I2 => BU2_U0_transmitter_is_terminate(1),
      I3 => BU2_N4656,
      O => BU2_U0_transmitter_filter5_mux0007(1)
    );
  BU2_U0_transmitter_filter5_xor000132_SW9 : LUT4
    generic map(
      INIT => X"DD15"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(46),
      I1 => BU2_U0_transmitter_txc_pipe(5),
      I2 => BU2_U0_transmitter_filter5_N01,
      I3 => BU2_U0_transmitter_filter5_xor0001_map2041,
      O => BU2_N4656
    );
  BU2_U0_transmitter_filter5_mux0007_4_1 : LUT4
    generic map(
      INIT => X"DF80"
    )
    port map (
      I0 => BU2_U0_transmitter_filter5_xor0001_map2048,
      I1 => BU2_N4653,
      I2 => BU2_U0_transmitter_is_terminate(1),
      I3 => BU2_N4652,
      O => BU2_U0_transmitter_filter5_mux0007(4)
    );
  BU2_U0_transmitter_filter5_xor000132_SW6 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(43),
      I1 => BU2_U0_transmitter_txc_pipe(5),
      I2 => BU2_U0_transmitter_filter5_N01,
      O => BU2_N4652
    );
  BU2_U0_transmitter_filter5_mux0007_2_1 : LUT4
    generic map(
      INIT => X"DF80"
    )
    port map (
      I0 => BU2_U0_transmitter_filter5_xor0001_map2048,
      I1 => BU2_N4650,
      I2 => BU2_U0_transmitter_is_terminate(1),
      I3 => BU2_N4649,
      O => BU2_U0_transmitter_filter5_mux0007(2)
    );
  BU2_U0_transmitter_filter5_xor000132_SW4 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(45),
      I1 => BU2_U0_transmitter_txc_pipe(5),
      I2 => BU2_U0_transmitter_filter5_N01,
      O => BU2_N4649
    );
  BU2_U0_transmitter_filter5_mux0007_0_1 : LUT4
    generic map(
      INIT => X"DF80"
    )
    port map (
      I0 => BU2_U0_transmitter_filter5_xor0001_map2048,
      I1 => BU2_N4647,
      I2 => BU2_U0_transmitter_is_terminate(1),
      I3 => BU2_N4646,
      O => BU2_U0_transmitter_filter5_mux0007(0)
    );
  BU2_U0_transmitter_filter5_xor000132_SW2 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(47),
      I1 => BU2_U0_transmitter_txc_pipe(5),
      I2 => BU2_U0_transmitter_filter5_N01,
      O => BU2_N4646
    );
  BU2_U0_transmitter_filter5_mux0007_7_1 : LUT4
    generic map(
      INIT => X"13B3"
    )
    port map (
      I0 => BU2_U0_transmitter_filter5_xor0001_map2048,
      I1 => BU2_N4643,
      I2 => BU2_U0_transmitter_is_terminate(1),
      I3 => BU2_N4644,
      O => BU2_U0_transmitter_filter5_mux0007(7)
    );
  BU2_U0_transmitter_filter5_xor000132_SW1 : LUT4
    generic map(
      INIT => X"DDD5"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(40),
      I1 => BU2_U0_transmitter_txc_pipe(5),
      I2 => BU2_U0_transmitter_filter5_N01,
      I3 => BU2_N5199,
      O => BU2_N4644
    );
  BU2_U0_transmitter_filter4_mux0007_6_1 : LUT4
    generic map(
      INIT => X"13B3"
    )
    port map (
      I0 => BU2_U0_transmitter_filter4_xor0001_map2061,
      I1 => BU2_N4640,
      I2 => BU2_U0_transmitter_is_terminate(1),
      I3 => BU2_N4641,
      O => BU2_U0_transmitter_filter4_mux0007(6)
    );
  BU2_U0_transmitter_filter4_xor000132_SW11 : LUT4
    generic map(
      INIT => X"DD15"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(33),
      I1 => BU2_U0_transmitter_txc_pipe(4),
      I2 => BU2_U0_transmitter_filter4_N01,
      I3 => BU2_U0_transmitter_filter4_xor0001_map2054,
      O => BU2_N4641
    );
  BU2_U0_transmitter_filter4_mux0007_1_1 : LUT4
    generic map(
      INIT => X"13B3"
    )
    port map (
      I0 => BU2_U0_transmitter_filter4_xor0001_map2061,
      I1 => BU2_N4637,
      I2 => BU2_U0_transmitter_is_terminate(1),
      I3 => BU2_N4638,
      O => BU2_U0_transmitter_filter4_mux0007(1)
    );
  BU2_U0_transmitter_filter4_xor000132_SW9 : LUT4
    generic map(
      INIT => X"DD15"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(38),
      I1 => BU2_U0_transmitter_txc_pipe(4),
      I2 => BU2_U0_transmitter_filter4_N01,
      I3 => BU2_U0_transmitter_filter4_xor0001_map2054,
      O => BU2_N4638
    );
  BU2_U0_transmitter_filter4_mux0007_4_1 : LUT4
    generic map(
      INIT => X"DF80"
    )
    port map (
      I0 => BU2_U0_transmitter_filter4_xor0001_map2061,
      I1 => BU2_N4635,
      I2 => BU2_U0_transmitter_is_terminate(1),
      I3 => BU2_N4634,
      O => BU2_U0_transmitter_filter4_mux0007(4)
    );
  BU2_U0_transmitter_filter4_xor000132_SW6 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(35),
      I1 => BU2_U0_transmitter_txc_pipe(4),
      I2 => BU2_U0_transmitter_filter4_N01,
      O => BU2_N4634
    );
  BU2_U0_transmitter_filter4_mux0007_0_1 : LUT4
    generic map(
      INIT => X"DF80"
    )
    port map (
      I0 => BU2_U0_transmitter_filter4_xor0001_map2061,
      I1 => BU2_N4632,
      I2 => BU2_U0_transmitter_is_terminate(1),
      I3 => BU2_N4631,
      O => BU2_U0_transmitter_filter4_mux0007(0)
    );
  BU2_U0_transmitter_filter4_xor000132_SW4 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(39),
      I1 => BU2_U0_transmitter_txc_pipe(4),
      I2 => BU2_U0_transmitter_filter4_N01,
      O => BU2_N4631
    );
  BU2_U0_transmitter_filter4_mux0007_2_1 : LUT4
    generic map(
      INIT => X"DF80"
    )
    port map (
      I0 => BU2_U0_transmitter_filter4_xor0001_map2061,
      I1 => BU2_N4629,
      I2 => BU2_U0_transmitter_is_terminate(1),
      I3 => BU2_N4628,
      O => BU2_U0_transmitter_filter4_mux0007(2)
    );
  BU2_U0_transmitter_filter4_xor000132_SW2 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(37),
      I1 => BU2_U0_transmitter_txc_pipe(4),
      I2 => BU2_U0_transmitter_filter4_N01,
      O => BU2_N4628
    );
  BU2_U0_transmitter_filter4_mux0007_7_1 : LUT4
    generic map(
      INIT => X"13B3"
    )
    port map (
      I0 => BU2_U0_transmitter_filter4_xor0001_map2061,
      I1 => BU2_N4625,
      I2 => BU2_U0_transmitter_is_terminate(1),
      I3 => BU2_N4626,
      O => BU2_U0_transmitter_filter4_mux0007(7)
    );
  BU2_U0_transmitter_filter4_xor000132_SW1 : LUT4
    generic map(
      INIT => X"DDD5"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(32),
      I1 => BU2_U0_transmitter_txc_pipe(4),
      I2 => BU2_U0_transmitter_filter4_N01,
      I3 => BU2_N5200,
      O => BU2_N4626
    );
  BU2_U0_transmitter_filter3_mux0007_6_1 : LUT4
    generic map(
      INIT => X"13B3"
    )
    port map (
      I0 => BU2_U0_transmitter_filter3_xor0001_map2074,
      I1 => BU2_N4622,
      I2 => BU2_U0_transmitter_is_terminate(0),
      I3 => BU2_N4623,
      O => BU2_U0_transmitter_filter3_mux0007(6)
    );
  BU2_U0_transmitter_filter3_xor000132_SW11 : LUT4
    generic map(
      INIT => X"DD15"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(25),
      I1 => BU2_U0_transmitter_txc_pipe(3),
      I2 => BU2_U0_transmitter_filter3_N01,
      I3 => BU2_U0_transmitter_filter3_xor0001_map2067,
      O => BU2_N4623
    );
  BU2_U0_transmitter_filter3_mux0007_1_1 : LUT4
    generic map(
      INIT => X"13B3"
    )
    port map (
      I0 => BU2_U0_transmitter_filter3_xor0001_map2074,
      I1 => BU2_N4619,
      I2 => BU2_U0_transmitter_is_terminate(0),
      I3 => BU2_N4620,
      O => BU2_U0_transmitter_filter3_mux0007(1)
    );
  BU2_U0_transmitter_filter3_xor000132_SW9 : LUT4
    generic map(
      INIT => X"DD15"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(30),
      I1 => BU2_U0_transmitter_txc_pipe(3),
      I2 => BU2_U0_transmitter_filter3_N01,
      I3 => BU2_U0_transmitter_filter3_xor0001_map2067,
      O => BU2_N4620
    );
  BU2_U0_transmitter_filter3_mux0007_4_1 : LUT4
    generic map(
      INIT => X"DF80"
    )
    port map (
      I0 => BU2_U0_transmitter_filter3_xor0001_map2074,
      I1 => BU2_N4617,
      I2 => BU2_U0_transmitter_is_terminate(0),
      I3 => BU2_N4616,
      O => BU2_U0_transmitter_filter3_mux0007(4)
    );
  BU2_U0_transmitter_filter3_xor000132_SW6 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(27),
      I1 => BU2_U0_transmitter_txc_pipe(3),
      I2 => BU2_U0_transmitter_filter3_N01,
      O => BU2_N4616
    );
  BU2_U0_transmitter_filter3_mux0007_2_1 : LUT4
    generic map(
      INIT => X"DF80"
    )
    port map (
      I0 => BU2_U0_transmitter_filter3_xor0001_map2074,
      I1 => BU2_N4614,
      I2 => BU2_U0_transmitter_is_terminate(0),
      I3 => BU2_N4613,
      O => BU2_U0_transmitter_filter3_mux0007(2)
    );
  BU2_U0_transmitter_filter3_xor000132_SW4 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(29),
      I1 => BU2_U0_transmitter_txc_pipe(3),
      I2 => BU2_U0_transmitter_filter3_N01,
      O => BU2_N4613
    );
  BU2_U0_transmitter_filter3_mux0007_0_1 : LUT4
    generic map(
      INIT => X"DF80"
    )
    port map (
      I0 => BU2_U0_transmitter_filter3_xor0001_map2074,
      I1 => BU2_N4611,
      I2 => BU2_U0_transmitter_is_terminate(0),
      I3 => BU2_N4610,
      O => BU2_U0_transmitter_filter3_mux0007(0)
    );
  BU2_U0_transmitter_filter3_xor000132_SW2 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(31),
      I1 => BU2_U0_transmitter_txc_pipe(3),
      I2 => BU2_U0_transmitter_filter3_N01,
      O => BU2_N4610
    );
  BU2_U0_transmitter_filter3_mux0007_7_1 : LUT4
    generic map(
      INIT => X"13B3"
    )
    port map (
      I0 => BU2_U0_transmitter_filter3_xor0001_map2074,
      I1 => BU2_N4607,
      I2 => BU2_U0_transmitter_is_terminate(0),
      I3 => BU2_N4608,
      O => BU2_U0_transmitter_filter3_mux0007(7)
    );
  BU2_U0_transmitter_filter3_xor000132_SW1 : LUT4
    generic map(
      INIT => X"DDD5"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(24),
      I1 => BU2_U0_transmitter_txc_pipe(3),
      I2 => BU2_U0_transmitter_filter3_N01,
      I3 => BU2_N5201,
      O => BU2_N4608
    );
  BU2_U0_transmitter_filter2_mux0007_6_1 : LUT4
    generic map(
      INIT => X"13B3"
    )
    port map (
      I0 => BU2_U0_transmitter_filter2_xor0001_map2087,
      I1 => BU2_N4604,
      I2 => BU2_U0_transmitter_is_terminate(0),
      I3 => BU2_N4605,
      O => BU2_U0_transmitter_filter2_mux0007(6)
    );
  BU2_U0_transmitter_filter2_xor000132_SW11 : LUT4
    generic map(
      INIT => X"DD15"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(17),
      I1 => BU2_U0_transmitter_txc_pipe(2),
      I2 => BU2_U0_transmitter_filter2_N01,
      I3 => BU2_U0_transmitter_filter2_xor0001_map2080,
      O => BU2_N4605
    );
  BU2_U0_transmitter_filter2_mux0007_1_1 : LUT4
    generic map(
      INIT => X"13B3"
    )
    port map (
      I0 => BU2_U0_transmitter_filter2_xor0001_map2087,
      I1 => BU2_N4601,
      I2 => BU2_U0_transmitter_is_terminate(0),
      I3 => BU2_N4602,
      O => BU2_U0_transmitter_filter2_mux0007(1)
    );
  BU2_U0_transmitter_filter2_xor000132_SW9 : LUT4
    generic map(
      INIT => X"DD15"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(22),
      I1 => BU2_U0_transmitter_txc_pipe(2),
      I2 => BU2_U0_transmitter_filter2_N01,
      I3 => BU2_U0_transmitter_filter2_xor0001_map2080,
      O => BU2_N4602
    );
  BU2_U0_transmitter_filter2_mux0007_4_1 : LUT4
    generic map(
      INIT => X"DF80"
    )
    port map (
      I0 => BU2_U0_transmitter_filter2_xor0001_map2087,
      I1 => BU2_N4599,
      I2 => BU2_U0_transmitter_is_terminate(0),
      I3 => BU2_N4598,
      O => BU2_U0_transmitter_filter2_mux0007(4)
    );
  BU2_U0_transmitter_filter2_xor000132_SW6 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(19),
      I1 => BU2_U0_transmitter_txc_pipe(2),
      I2 => BU2_U0_transmitter_filter2_N01,
      O => BU2_N4598
    );
  BU2_U0_transmitter_filter2_mux0007_2_1 : LUT4
    generic map(
      INIT => X"DF80"
    )
    port map (
      I0 => BU2_U0_transmitter_filter2_xor0001_map2087,
      I1 => BU2_N4596,
      I2 => BU2_U0_transmitter_is_terminate(0),
      I3 => BU2_N4595,
      O => BU2_U0_transmitter_filter2_mux0007(2)
    );
  BU2_U0_transmitter_filter2_xor000132_SW4 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(21),
      I1 => BU2_U0_transmitter_txc_pipe(2),
      I2 => BU2_U0_transmitter_filter2_N01,
      O => BU2_N4595
    );
  BU2_U0_transmitter_filter2_mux0007_0_1 : LUT4
    generic map(
      INIT => X"DF80"
    )
    port map (
      I0 => BU2_U0_transmitter_filter2_xor0001_map2087,
      I1 => BU2_N4593,
      I2 => BU2_U0_transmitter_is_terminate(0),
      I3 => BU2_N4592,
      O => BU2_U0_transmitter_filter2_mux0007(0)
    );
  BU2_U0_transmitter_filter2_xor000132_SW2 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(23),
      I1 => BU2_U0_transmitter_txc_pipe(2),
      I2 => BU2_U0_transmitter_filter2_N01,
      O => BU2_N4592
    );
  BU2_U0_transmitter_filter2_mux0007_7_1 : LUT4
    generic map(
      INIT => X"13B3"
    )
    port map (
      I0 => BU2_U0_transmitter_filter2_xor0001_map2087,
      I1 => BU2_N4589,
      I2 => BU2_U0_transmitter_is_terminate(0),
      I3 => BU2_N4590,
      O => BU2_U0_transmitter_filter2_mux0007(7)
    );
  BU2_U0_transmitter_filter2_xor000132_SW1 : LUT4
    generic map(
      INIT => X"DDD5"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(16),
      I1 => BU2_U0_transmitter_txc_pipe(2),
      I2 => BU2_U0_transmitter_filter2_N01,
      I3 => BU2_N5202,
      O => BU2_N4590
    );
  BU2_U0_transmitter_filter1_mux0007_6_1 : LUT4
    generic map(
      INIT => X"13B3"
    )
    port map (
      I0 => BU2_U0_transmitter_filter1_xor0001_map2100,
      I1 => BU2_N4586,
      I2 => BU2_U0_transmitter_is_terminate(0),
      I3 => BU2_N4587,
      O => BU2_U0_transmitter_filter1_mux0007(6)
    );
  BU2_U0_transmitter_filter1_xor000132_SW11 : LUT4
    generic map(
      INIT => X"DD15"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(9),
      I1 => BU2_U0_transmitter_txc_pipe(1),
      I2 => BU2_U0_transmitter_filter1_N01,
      I3 => BU2_U0_transmitter_filter1_xor0001_map2093,
      O => BU2_N4587
    );
  BU2_U0_transmitter_filter1_mux0007_1_1 : LUT4
    generic map(
      INIT => X"13B3"
    )
    port map (
      I0 => BU2_U0_transmitter_filter1_xor0001_map2100,
      I1 => BU2_N4583,
      I2 => BU2_U0_transmitter_is_terminate(0),
      I3 => BU2_N4584,
      O => BU2_U0_transmitter_filter1_mux0007(1)
    );
  BU2_U0_transmitter_filter1_xor000132_SW9 : LUT4
    generic map(
      INIT => X"DD15"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(14),
      I1 => BU2_U0_transmitter_txc_pipe(1),
      I2 => BU2_U0_transmitter_filter1_N01,
      I3 => BU2_U0_transmitter_filter1_xor0001_map2093,
      O => BU2_N4584
    );
  BU2_U0_transmitter_filter1_mux0007_4_1 : LUT4
    generic map(
      INIT => X"DF80"
    )
    port map (
      I0 => BU2_U0_transmitter_filter1_xor0001_map2100,
      I1 => BU2_N4581,
      I2 => BU2_U0_transmitter_is_terminate(0),
      I3 => BU2_N4580,
      O => BU2_U0_transmitter_filter1_mux0007(4)
    );
  BU2_U0_transmitter_filter1_xor000132_SW6 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(11),
      I1 => BU2_U0_transmitter_txc_pipe(1),
      I2 => BU2_U0_transmitter_filter1_N01,
      O => BU2_N4580
    );
  BU2_U0_transmitter_filter1_mux0007_0_1 : LUT4
    generic map(
      INIT => X"DF80"
    )
    port map (
      I0 => BU2_U0_transmitter_filter1_xor0001_map2100,
      I1 => BU2_N4578,
      I2 => BU2_U0_transmitter_is_terminate(0),
      I3 => BU2_N4577,
      O => BU2_U0_transmitter_filter1_mux0007(0)
    );
  BU2_U0_transmitter_filter1_xor000132_SW4 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(15),
      I1 => BU2_U0_transmitter_txc_pipe(1),
      I2 => BU2_U0_transmitter_filter1_N01,
      O => BU2_N4577
    );
  BU2_U0_transmitter_filter1_mux0007_2_1 : LUT4
    generic map(
      INIT => X"DF80"
    )
    port map (
      I0 => BU2_U0_transmitter_filter1_xor0001_map2100,
      I1 => BU2_N4575,
      I2 => BU2_U0_transmitter_is_terminate(0),
      I3 => BU2_N4574,
      O => BU2_U0_transmitter_filter1_mux0007(2)
    );
  BU2_U0_transmitter_filter1_xor000132_SW2 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(13),
      I1 => BU2_U0_transmitter_txc_pipe(1),
      I2 => BU2_U0_transmitter_filter1_N01,
      O => BU2_N4574
    );
  BU2_U0_transmitter_filter1_mux0007_7_1 : LUT4
    generic map(
      INIT => X"13B3"
    )
    port map (
      I0 => BU2_U0_transmitter_filter1_xor0001_map2100,
      I1 => BU2_N4571,
      I2 => BU2_U0_transmitter_is_terminate(0),
      I3 => BU2_N4572,
      O => BU2_U0_transmitter_filter1_mux0007(7)
    );
  BU2_U0_transmitter_filter1_xor000132_SW1 : LUT4
    generic map(
      INIT => X"DDD5"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(8),
      I1 => BU2_U0_transmitter_txc_pipe(1),
      I2 => BU2_U0_transmitter_filter1_N01,
      I3 => BU2_N5203,
      O => BU2_N4572
    );
  BU2_U0_transmitter_filter0_mux0007_6_1 : LUT4
    generic map(
      INIT => X"13B3"
    )
    port map (
      I0 => BU2_U0_transmitter_filter0_xor0001_map2223,
      I1 => BU2_N4568,
      I2 => BU2_U0_transmitter_is_terminate(0),
      I3 => BU2_N4569,
      O => BU2_U0_transmitter_filter0_mux0007(6)
    );
  BU2_U0_transmitter_filter0_xor000132_SW11 : LUT4
    generic map(
      INIT => X"DD15"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(1),
      I1 => BU2_U0_transmitter_txc_pipe(0),
      I2 => BU2_U0_transmitter_filter0_N01,
      I3 => BU2_U0_transmitter_filter0_xor0001_map2216,
      O => BU2_N4569
    );
  BU2_U0_transmitter_filter0_mux0007_1_1 : LUT4
    generic map(
      INIT => X"13B3"
    )
    port map (
      I0 => BU2_U0_transmitter_filter0_xor0001_map2223,
      I1 => BU2_N4565,
      I2 => BU2_U0_transmitter_is_terminate(0),
      I3 => BU2_N4566,
      O => BU2_U0_transmitter_filter0_mux0007(1)
    );
  BU2_U0_transmitter_filter0_xor000132_SW9 : LUT4
    generic map(
      INIT => X"DD15"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(6),
      I1 => BU2_U0_transmitter_txc_pipe(0),
      I2 => BU2_U0_transmitter_filter0_N01,
      I3 => BU2_U0_transmitter_filter0_xor0001_map2216,
      O => BU2_N4566
    );
  BU2_U0_transmitter_filter0_mux0007_4_1 : LUT4
    generic map(
      INIT => X"DF80"
    )
    port map (
      I0 => BU2_U0_transmitter_filter0_xor0001_map2223,
      I1 => BU2_N4563,
      I2 => BU2_U0_transmitter_is_terminate(0),
      I3 => BU2_N4562,
      O => BU2_U0_transmitter_filter0_mux0007(4)
    );
  BU2_U0_transmitter_filter0_xor000132_SW6 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(3),
      I1 => BU2_U0_transmitter_txc_pipe(0),
      I2 => BU2_U0_transmitter_filter0_N01,
      O => BU2_N4562
    );
  BU2_U0_transmitter_filter0_mux0007_2_1 : LUT4
    generic map(
      INIT => X"DF80"
    )
    port map (
      I0 => BU2_U0_transmitter_filter0_xor0001_map2223,
      I1 => BU2_N4560,
      I2 => BU2_U0_transmitter_is_terminate(0),
      I3 => BU2_N4559,
      O => BU2_U0_transmitter_filter0_mux0007(2)
    );
  BU2_U0_transmitter_filter0_xor000132_SW4 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(5),
      I1 => BU2_U0_transmitter_txc_pipe(0),
      I2 => BU2_U0_transmitter_filter0_N01,
      O => BU2_N4559
    );
  BU2_U0_transmitter_filter0_mux0007_0_1 : LUT4
    generic map(
      INIT => X"DF80"
    )
    port map (
      I0 => BU2_U0_transmitter_filter0_xor0001_map2223,
      I1 => BU2_N4557,
      I2 => BU2_U0_transmitter_is_terminate(0),
      I3 => BU2_N4556,
      O => BU2_U0_transmitter_filter0_mux0007(0)
    );
  BU2_U0_transmitter_filter0_xor000132_SW2 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(7),
      I1 => BU2_U0_transmitter_txc_pipe(0),
      I2 => BU2_U0_transmitter_filter0_N01,
      O => BU2_N4556
    );
  BU2_U0_transmitter_filter0_mux0007_7_1 : LUT4
    generic map(
      INIT => X"13B3"
    )
    port map (
      I0 => BU2_U0_transmitter_filter0_xor0001_map2223,
      I1 => BU2_N4553,
      I2 => BU2_U0_transmitter_is_terminate(0),
      I3 => BU2_N4554,
      O => BU2_U0_transmitter_filter0_mux0007(7)
    );
  BU2_U0_transmitter_filter0_xor000132_SW1 : LUT4
    generic map(
      INIT => X"DDD5"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(0),
      I1 => BU2_U0_transmitter_txc_pipe(0),
      I2 => BU2_U0_transmitter_filter0_N01,
      I3 => BU2_N5204,
      O => BU2_N4554
    );
  BU2_U0_receiver_recoder_or00221_SW2 : LUT4
    generic map(
      INIT => X"7FFF"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(13),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(12),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(11),
      I3 => BU2_U0_receiver_recoder_rxd_pipe(10),
      O => BU2_N4551
    );
  BU2_U0_receiver_recoder_or00222 : LUT4
    generic map(
      INIT => X"0008"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(12),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(11),
      I2 => BU2_N4549,
      I3 => BU2_N4170,
      O => BU2_U0_receiver_recoder_or0022
    );
  BU2_U0_receiver_recoder_or00231_SW3 : LUT4
    generic map(
      INIT => X"4000"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(17),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(20),
      I2 => BU2_U0_receiver_recoder_rxc_pipe(2),
      I3 => BU2_U0_receiver_recoder_rxd_pipe(18),
      O => BU2_N4547
    );
  BU2_U0_receiver_recoder_or00121 : LUT4
    generic map(
      INIT => X"F8FC"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_or0025_map2283,
      I1 => BU2_U0_receiver_recoder_or0025_map2289,
      I2 => BU2_N4543,
      I3 => BU2_U0_receiver_recoder_N16,
      O => BU2_U0_receiver_recoder_or0012
    );
  BU2_U0_receiver_recoder_or00081 : LUT4
    generic map(
      INIT => X"FEFC"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_or0030_map2463,
      I1 => BU2_N4541,
      I2 => BU2_U0_receiver_recoder_or0030_map2481,
      I3 => BU2_U0_receiver_recoder_or0030_map2460,
      O => BU2_U0_receiver_recoder_or0008
    );
  BU2_U0_receiver_recoder_or00061 : LUT4
    generic map(
      INIT => X"FEFA"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_pipe(0),
      I1 => BU2_N4539,
      I2 => BU2_U0_receiver_recoder_or0029_map2333,
      I3 => BU2_U0_receiver_recoder_N16,
      O => BU2_U0_receiver_recoder_or0006
    );
  BU2_U0_receiver_recoder_or003058 : LUT4
    generic map(
      INIT => X"000E"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_lane_terminate(3),
      I1 => BU2_U0_receiver_recoder_lane_terminate(2),
      I2 => BU2_U0_receiver_recoder_lane_terminate(0),
      I3 => BU2_U0_receiver_recoder_lane_terminate(1),
      O => BU2_U0_receiver_recoder_or0030_map2463
    );
  BU2_U0_receiver_pcs_sync_state0_next_state_1_0_36 : LUT4
    generic map(
      INIT => X"0103"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(0),
      I1 => BU2_U0_receiver_pcs_sync_state0_state_1_0_52,
      I2 => BU2_U0_receiver_pcs_sync_state0_state_1_1_51,
      I3 => BU2_U0_receiver_pcs_sync_state0_code_comma_pipe(0),
      O => BU2_U0_receiver_pcs_sync_state0_next_state_1_0_map2898
    );
  BU2_U0_receiver_pcs_sync_state1_next_state_1_0_36 : LUT4
    generic map(
      INIT => X"0103"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(1),
      I1 => BU2_U0_receiver_pcs_sync_state1_state_1_0_58,
      I2 => BU2_U0_receiver_pcs_sync_state1_state_1_1_57,
      I3 => BU2_U0_receiver_pcs_sync_state1_code_comma_pipe(0),
      O => BU2_U0_receiver_pcs_sync_state1_next_state_1_0_map2847
    );
  BU2_U0_receiver_pcs_sync_state2_next_state_1_0_36 : LUT4
    generic map(
      INIT => X"0103"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(2),
      I1 => BU2_U0_receiver_pcs_sync_state2_state_1_0_64,
      I2 => BU2_U0_receiver_pcs_sync_state2_state_1_1_63,
      I3 => BU2_U0_receiver_pcs_sync_state2_code_comma_pipe(0),
      O => BU2_U0_receiver_pcs_sync_state2_next_state_1_0_map2796
    );
  BU2_U0_receiver_pcs_sync_state3_next_state_1_0_36 : LUT4
    generic map(
      INIT => X"0103"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(3),
      I1 => BU2_U0_receiver_pcs_sync_state3_state_1_0_70,
      I2 => BU2_U0_receiver_pcs_sync_state3_state_1_1_69,
      I3 => BU2_U0_receiver_pcs_sync_state3_code_comma_pipe(0),
      O => BU2_U0_receiver_pcs_sync_state3_next_state_1_0_map2745
    );
  BU2_U0_receiver_recoder_or00051 : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => BU2_U0_usrclk_reset_104,
      I1 => NlwRenamedSig_OI_align_status,
      I2 => BU2_U0_receiver_recoder_code_error_pipe(0),
      I3 => BU2_U0_receiver_recoder_or0029_map2333,
      O => BU2_U0_receiver_recoder_or0005
    );
  BU2_U0_receiver_recoder_or003214 : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(62),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(58),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(57),
      I3 => BU2_N4537,
      O => BU2_U0_receiver_recoder_or0032_map2300
    );
  BU2_U0_receiver_recoder_or001951_SW0 : LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxc_half_pipe(2),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(20),
      I2 => BU2_U0_receiver_recoder_rxd_half_pipe(19),
      O => BU2_N4533
    );
  BU2_U0_transmitter_align_Mrom_a_cnt_0_1_SW0 : LUT4
    generic map(
      INIT => X"FF40"
    )
    port map (
      I0 => BU2_U0_transmitter_align_extra_a_98,
      I1 => BU2_U0_transmitter_align_count(0),
      I2 => BU2_U0_transmitter_align_count(1),
      I3 => BU2_U0_transmitter_align_count(2),
      O => BU2_N4527
    );
  BU2_U0_transmitter_mux0075105 : LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(10),
      I1 => BU2_U0_transmitter_txd_pipe(11),
      I2 => BU2_U0_transmitter_mux0075_map2256,
      I3 => BU2_U0_transmitter_mux0075_map2260,
      O => BU2_U0_transmitter_mux0075_map2262
    );
  BU2_U0_transmitter_mux007580 : LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(2),
      I1 => BU2_U0_transmitter_txd_pipe(3),
      I2 => BU2_U0_transmitter_mux0075_map2247,
      I3 => BU2_U0_transmitter_mux0075_map2251,
      O => BU2_U0_transmitter_mux0075_map2253
    );
  BU2_U0_transmitter_mux007542 : LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(26),
      I1 => BU2_U0_transmitter_txd_pipe(27),
      I2 => BU2_U0_transmitter_mux0075_map2237,
      I3 => BU2_U0_transmitter_mux0075_map2241,
      O => BU2_U0_transmitter_mux0075_map2243
    );
  BU2_U0_transmitter_mux0076105 : LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(42),
      I1 => BU2_U0_transmitter_txd_pipe(43),
      I2 => BU2_U0_transmitter_mux0076_map2133,
      I3 => BU2_U0_transmitter_mux0076_map2137,
      O => BU2_U0_transmitter_mux0076_map2139
    );
  BU2_U0_transmitter_mux007680 : LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(34),
      I1 => BU2_U0_transmitter_txd_pipe(35),
      I2 => BU2_U0_transmitter_mux0076_map2124,
      I3 => BU2_U0_transmitter_mux0076_map2128,
      O => BU2_U0_transmitter_mux0076_map2130
    );
  BU2_U0_transmitter_mux007642 : LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(58),
      I1 => BU2_U0_transmitter_txd_pipe(59),
      I2 => BU2_U0_transmitter_mux0076_map2114,
      I3 => BU2_U0_transmitter_mux0076_map2118,
      O => BU2_U0_transmitter_mux0076_map2120
    );
  BU2_U0_receiver_recoder_or003040 : LUT4
    generic map(
      INIT => X"FFF9"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(46),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(47),
      I2 => BU2_U0_receiver_recoder_or0030_map2446,
      I3 => BU2_U0_receiver_recoder_or0030_map2459,
      O => BU2_U0_receiver_recoder_or0030_map2460
    );
  BU2_U0_receiver_recoder_or00231_SW2 : LUT4
    generic map(
      INIT => X"FF7F"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(20),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(18),
      I2 => BU2_U0_receiver_recoder_rxc_pipe(2),
      I3 => BU2_U0_receiver_recoder_rxd_pipe(17),
      O => BU2_N4525
    );
  BU2_U0_receiver_recoder_or00231_SW1 : LUT4
    generic map(
      INIT => X"FF7F"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(22),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(20),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(18),
      I3 => BU2_U0_receiver_recoder_rxd_pipe(17),
      O => BU2_N4523
    );
  BU2_U0_receiver_recoder_or00101 : LUT4
    generic map(
      INIT => X"FEFC"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_or0031_map2666,
      I1 => BU2_N4521,
      I2 => BU2_U0_receiver_recoder_or0031_map2644,
      I3 => BU2_U0_receiver_recoder_or0031_map2662,
      O => BU2_U0_receiver_recoder_or0010
    );
  BU2_U0_receiver_pcs_sync_state0_mux0008_5_Q : LUT4
    generic map(
      INIT => X"0009"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(0),
      I1 => BU2_U0_receiver_pcs_sync_state0_signal_detect_last_53,
      I2 => BU2_U0_receiver_pcs_sync_state0_N01,
      I3 => BU2_N4511,
      O => BU2_U0_receiver_pcs_sync_state0_mux0008_5_Q_3
    );
  BU2_U0_receiver_pcs_sync_state1_mux0008_5_Q : LUT4
    generic map(
      INIT => X"0009"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(1),
      I1 => BU2_U0_receiver_pcs_sync_state1_signal_detect_last_59,
      I2 => BU2_U0_receiver_pcs_sync_state1_N01,
      I3 => BU2_N4509,
      O => BU2_U0_receiver_pcs_sync_state1_mux0008_5_Q_4
    );
  BU2_U0_receiver_pcs_sync_state2_mux0008_5_Q : LUT4
    generic map(
      INIT => X"0009"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(2),
      I1 => BU2_U0_receiver_pcs_sync_state2_signal_detect_last_65,
      I2 => BU2_U0_receiver_pcs_sync_state2_N01,
      I3 => BU2_N4507,
      O => BU2_U0_receiver_pcs_sync_state2_mux0008_5_Q_5
    );
  BU2_U0_receiver_pcs_sync_state3_mux0008_5_Q : LUT4
    generic map(
      INIT => X"0009"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(3),
      I1 => BU2_U0_receiver_pcs_sync_state3_signal_detect_last_71,
      I2 => BU2_U0_receiver_pcs_sync_state3_N01,
      I3 => BU2_N4505,
      O => BU2_U0_receiver_pcs_sync_state3_mux0008_5_Q_6
    );
  BU2_U0_receiver_pcs_sync_state0_next_state_1_0_187_SW0 : LUT4
    generic map(
      INIT => X"BAAA"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_code_valid_pipe(1),
      I1 => BU2_U0_receiver_pcs_sync_state0_mux0008_11_Q,
      I2 => BU2_N4503,
      I3 => BU2_N4413,
      O => BU2_N4460
    );
  BU2_U0_receiver_pcs_sync_state1_next_state_1_0_187_SW0 : LUT4
    generic map(
      INIT => X"BAAA"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_code_valid_pipe(1),
      I1 => BU2_U0_receiver_pcs_sync_state1_mux0008_11_Q,
      I2 => BU2_N4501,
      I3 => BU2_N4411,
      O => BU2_N4458
    );
  BU2_U0_receiver_pcs_sync_state2_next_state_1_0_187_SW0 : LUT4
    generic map(
      INIT => X"BAAA"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_code_valid_pipe(1),
      I1 => BU2_U0_receiver_pcs_sync_state2_mux0008_11_Q,
      I2 => BU2_N4499,
      I3 => BU2_N4409,
      O => BU2_N4456
    );
  BU2_U0_receiver_pcs_sync_state3_next_state_1_0_187_SW0 : LUT4
    generic map(
      INIT => X"BAAA"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_code_valid_pipe(1),
      I1 => BU2_U0_receiver_pcs_sync_state3_mux0008_11_Q,
      I2 => BU2_N4497,
      I3 => BU2_N4407,
      O => BU2_N4454
    );
  BU2_U0_transmitter_state_machine_mux0003_0_10_SW1 : LUT3
    generic map(
      INIT => X"0E"
    )
    port map (
      I0 => BU2_U0_transmitter_tx_is_idle(0),
      I1 => BU2_U0_transmitter_tx_is_q(0),
      I2 => BU2_U0_transmitter_state_machine_state_1_1_3_7,
      O => BU2_N4495
    );
  BU2_U0_transmitter_state_machine_mux0017_1_3 : LUT4
    generic map(
      INIT => X"EEAE"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_next_state_0_2_Q,
      I1 => BU2_U0_transmitter_state_machine_next_ifg_is_a_77,
      I2 => BU2_N4490,
      I3 => BU2_N5250,
      O => BU2_U0_transmitter_state_machine_mux0017_1_map3007
    );
  BU2_U0_receiver_recoder_or00111 : LUT4
    generic map(
      INIT => X"FEFC"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_or0031_map2666,
      I1 => BU2_N4486,
      I2 => BU2_U0_receiver_recoder_or0031_map2644,
      I3 => BU2_U0_receiver_recoder_or0031_map2662,
      O => BU2_U0_receiver_recoder_or0011
    );
  BU2_U0_receiver_pcs_sync_state0_next_state_1_2_18_SW0_SW0 : LUT3
    generic map(
      INIT => X"F8"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_code_comma_pipe(1),
      I1 => BU2_N5263,
      I2 => BU2_U0_receiver_pcs_sync_state0_mux0008_13_Q_37,
      O => BU2_N4484
    );
  BU2_U0_receiver_pcs_sync_state1_next_state_1_2_18_SW0_SW0 : LUT3
    generic map(
      INIT => X"F8"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_code_comma_pipe(1),
      I1 => BU2_N5264,
      I2 => BU2_U0_receiver_pcs_sync_state1_mux0008_13_Q_38,
      O => BU2_N4482
    );
  BU2_U0_receiver_pcs_sync_state2_next_state_1_2_18_SW0_SW0 : LUT3
    generic map(
      INIT => X"F8"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_code_comma_pipe(1),
      I1 => BU2_N5265,
      I2 => BU2_U0_receiver_pcs_sync_state2_mux0008_13_Q_39,
      O => BU2_N4480
    );
  BU2_U0_receiver_pcs_sync_state3_next_state_1_2_18_SW0_SW0 : LUT3
    generic map(
      INIT => X"F8"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_code_comma_pipe(1),
      I1 => BU2_N5266,
      I2 => BU2_U0_receiver_pcs_sync_state3_mux0008_13_Q_40,
      O => BU2_N4478
    );
  BU2_U0_receiver_pcs_sync_state0_mux0008_6_1 : LUT4
    generic map(
      INIT => X"0090"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(0),
      I1 => BU2_U0_receiver_pcs_sync_state0_signal_detect_last_53,
      I2 => BU2_N5224,
      I3 => BU2_N4474,
      O => BU2_U0_receiver_pcs_sync_state0_mux0008_6_Q
    );
  BU2_U0_receiver_pcs_sync_state0_mux0008_14_1 : LUT4
    generic map(
      INIT => X"0900"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(0),
      I1 => BU2_U0_receiver_pcs_sync_state0_signal_detect_last_53,
      I2 => BU2_N4474,
      I3 => BU2_N5225,
      O => BU2_U0_receiver_pcs_sync_state0_mux0008_14_Q
    );
  BU2_U0_receiver_pcs_sync_state0_mux0008_14_1_SW0 : LUT3
    generic map(
      INIT => X"BF"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_state_1_1_1_8,
      I1 => BU2_U0_receiver_pcs_sync_state0_code_valid_pipe(0),
      I2 => BU2_U0_receiver_pcs_sync_state0_state_1_0_52,
      O => BU2_N4474
    );
  BU2_U0_receiver_pcs_sync_state1_mux0008_6_1 : LUT4
    generic map(
      INIT => X"0090"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(1),
      I1 => BU2_U0_receiver_pcs_sync_state1_signal_detect_last_59,
      I2 => BU2_N5222,
      I3 => BU2_N4470,
      O => BU2_U0_receiver_pcs_sync_state1_mux0008_6_Q
    );
  BU2_U0_receiver_pcs_sync_state1_mux0008_14_1 : LUT4
    generic map(
      INIT => X"0900"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(1),
      I1 => BU2_U0_receiver_pcs_sync_state1_signal_detect_last_59,
      I2 => BU2_N4470,
      I3 => BU2_N5223,
      O => BU2_U0_receiver_pcs_sync_state1_mux0008_14_Q
    );
  BU2_U0_receiver_pcs_sync_state1_mux0008_14_1_SW0 : LUT3
    generic map(
      INIT => X"BF"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_state_1_1_1_9,
      I1 => BU2_U0_receiver_pcs_sync_state1_code_valid_pipe(0),
      I2 => BU2_U0_receiver_pcs_sync_state1_state_1_0_58,
      O => BU2_N4470
    );
  BU2_U0_receiver_pcs_sync_state2_mux0008_6_1 : LUT4
    generic map(
      INIT => X"0090"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(2),
      I1 => BU2_U0_receiver_pcs_sync_state2_signal_detect_last_65,
      I2 => BU2_N5220,
      I3 => BU2_N4466,
      O => BU2_U0_receiver_pcs_sync_state2_mux0008_6_Q
    );
  BU2_U0_receiver_pcs_sync_state2_mux0008_14_1 : LUT4
    generic map(
      INIT => X"0900"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(2),
      I1 => BU2_U0_receiver_pcs_sync_state2_signal_detect_last_65,
      I2 => BU2_N4466,
      I3 => BU2_N5221,
      O => BU2_U0_receiver_pcs_sync_state2_mux0008_14_Q
    );
  BU2_U0_receiver_pcs_sync_state2_mux0008_14_1_SW0 : LUT3
    generic map(
      INIT => X"BF"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_state_1_1_1_10,
      I1 => BU2_U0_receiver_pcs_sync_state2_code_valid_pipe(0),
      I2 => BU2_U0_receiver_pcs_sync_state2_state_1_0_64,
      O => BU2_N4466
    );
  BU2_U0_receiver_pcs_sync_state3_mux0008_6_1 : LUT4
    generic map(
      INIT => X"0090"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(3),
      I1 => BU2_U0_receiver_pcs_sync_state3_signal_detect_last_71,
      I2 => BU2_N5218,
      I3 => BU2_N4462,
      O => BU2_U0_receiver_pcs_sync_state3_mux0008_6_Q
    );
  BU2_U0_receiver_pcs_sync_state3_mux0008_14_1 : LUT4
    generic map(
      INIT => X"0900"
    )
    port map (
      I0 => BU2_U0_signal_detect_int(3),
      I1 => BU2_U0_receiver_pcs_sync_state3_signal_detect_last_71,
      I2 => BU2_N4462,
      I3 => BU2_N5219,
      O => BU2_U0_receiver_pcs_sync_state3_mux0008_14_Q
    );
  BU2_U0_receiver_pcs_sync_state3_mux0008_14_1_SW0 : LUT3
    generic map(
      INIT => X"BF"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_state_1_1_1_11,
      I1 => BU2_U0_receiver_pcs_sync_state3_code_valid_pipe(0),
      I2 => BU2_U0_receiver_pcs_sync_state3_state_1_0_70,
      O => BU2_N4462
    );
  BU2_U0_receiver_pcs_sync_state0_next_state_1_0_217 : LUT4
    generic map(
      INIT => X"5545"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_signal_detect_change,
      I1 => BU2_U0_receiver_pcs_sync_state0_next_state_1_0_map2905,
      I2 => BU2_N4460,
      I3 => BU2_U0_receiver_pcs_sync_state0_next_state_1_0_map2913,
      O => BU2_U0_receiver_pcs_sync_state0_next_state(1, 0)
    );
  BU2_U0_receiver_pcs_sync_state1_next_state_1_0_217 : LUT4
    generic map(
      INIT => X"5545"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_signal_detect_change,
      I1 => BU2_U0_receiver_pcs_sync_state1_next_state_1_0_map2854,
      I2 => BU2_N4458,
      I3 => BU2_U0_receiver_pcs_sync_state1_next_state_1_0_map2862,
      O => BU2_U0_receiver_pcs_sync_state1_next_state(1, 0)
    );
  BU2_U0_receiver_pcs_sync_state2_next_state_1_0_217 : LUT4
    generic map(
      INIT => X"5545"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_signal_detect_change,
      I1 => BU2_U0_receiver_pcs_sync_state2_next_state_1_0_map2803,
      I2 => BU2_N4456,
      I3 => BU2_U0_receiver_pcs_sync_state2_next_state_1_0_map2811,
      O => BU2_U0_receiver_pcs_sync_state2_next_state(1, 0)
    );
  BU2_U0_receiver_pcs_sync_state3_next_state_1_0_217 : LUT4
    generic map(
      INIT => X"5545"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_signal_detect_change,
      I1 => BU2_U0_receiver_pcs_sync_state3_next_state_1_0_map2752,
      I2 => BU2_N4454,
      I3 => BU2_U0_receiver_pcs_sync_state3_next_state_1_0_map2760,
      O => BU2_U0_receiver_pcs_sync_state3_next_state(1, 0)
    );
  BU2_U0_receiver_pcs_sync_state0_mux0008_13_Q : LUT4
    generic map(
      INIT => X"0012"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_state_1_2_50,
      I1 => BU2_U0_receiver_pcs_sync_state0_state_1_4_48,
      I2 => BU2_N5235,
      I3 => BU2_N4452,
      O => BU2_U0_receiver_pcs_sync_state0_mux0008_13_Q_37
    );
  BU2_U0_receiver_pcs_sync_state0_mux0008_13_SW1 : LUT4
    generic map(
      INIT => X"FF7D"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_state_1_3_49,
      I1 => BU2_U0_signal_detect_int(0),
      I2 => BU2_U0_receiver_pcs_sync_state0_signal_detect_last_53,
      I3 => BU2_U0_receiver_pcs_sync_state0_code_valid_pipe(0),
      O => BU2_N4452
    );
  BU2_U0_receiver_pcs_sync_state1_mux0008_13_Q : LUT4
    generic map(
      INIT => X"0012"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_state_1_2_56,
      I1 => BU2_U0_receiver_pcs_sync_state1_state_1_4_54,
      I2 => BU2_N5234,
      I3 => BU2_N4450,
      O => BU2_U0_receiver_pcs_sync_state1_mux0008_13_Q_38
    );
  BU2_U0_receiver_pcs_sync_state1_mux0008_13_SW1 : LUT4
    generic map(
      INIT => X"FF7D"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_state_1_3_55,
      I1 => BU2_U0_signal_detect_int(1),
      I2 => BU2_U0_receiver_pcs_sync_state1_signal_detect_last_59,
      I3 => BU2_U0_receiver_pcs_sync_state1_code_valid_pipe(0),
      O => BU2_N4450
    );
  BU2_U0_receiver_pcs_sync_state2_mux0008_13_Q : LUT4
    generic map(
      INIT => X"0012"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_state_1_2_62,
      I1 => BU2_U0_receiver_pcs_sync_state2_state_1_4_60,
      I2 => BU2_N5233,
      I3 => BU2_N4448,
      O => BU2_U0_receiver_pcs_sync_state2_mux0008_13_Q_39
    );
  BU2_U0_receiver_pcs_sync_state2_mux0008_13_SW1 : LUT4
    generic map(
      INIT => X"FF7D"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_state_1_3_61,
      I1 => BU2_U0_signal_detect_int(2),
      I2 => BU2_U0_receiver_pcs_sync_state2_signal_detect_last_65,
      I3 => BU2_U0_receiver_pcs_sync_state2_code_valid_pipe(0),
      O => BU2_N4448
    );
  BU2_U0_receiver_pcs_sync_state3_mux0008_13_Q : LUT4
    generic map(
      INIT => X"0012"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_state_1_2_68,
      I1 => BU2_U0_receiver_pcs_sync_state3_state_1_4_66,
      I2 => BU2_N5232,
      I3 => BU2_N4446,
      O => BU2_U0_receiver_pcs_sync_state3_mux0008_13_Q_40
    );
  BU2_U0_receiver_pcs_sync_state3_mux0008_13_SW1 : LUT4
    generic map(
      INIT => X"FF7D"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_state_1_3_67,
      I1 => BU2_U0_signal_detect_int(3),
      I2 => BU2_U0_receiver_pcs_sync_state3_signal_detect_last_71,
      I3 => BU2_U0_receiver_pcs_sync_state3_code_valid_pipe(0),
      O => BU2_N4446
    );
  BU2_U0_receiver_pcs_sync_state3_mux0008_3_SW0_SW0 : LUT4
    generic map(
      INIT => X"B7FF"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_code_comma_pipe(0),
      I1 => BU2_U0_receiver_pcs_sync_state3_state_1_1_1_11,
      I2 => BU2_U0_receiver_pcs_sync_state3_state_1_0_70,
      I3 => BU2_U0_receiver_pcs_sync_state3_code_valid_pipe(0),
      O => BU2_N4442
    );
  BU2_U0_receiver_pcs_sync_state2_mux0008_3_SW0_SW0 : LUT4
    generic map(
      INIT => X"B7FF"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_code_comma_pipe(0),
      I1 => BU2_U0_receiver_pcs_sync_state2_state_1_1_1_10,
      I2 => BU2_U0_receiver_pcs_sync_state2_state_1_0_64,
      I3 => BU2_U0_receiver_pcs_sync_state2_code_valid_pipe(0),
      O => BU2_N4438
    );
  BU2_U0_receiver_pcs_sync_state1_mux0008_3_SW0_SW0 : LUT4
    generic map(
      INIT => X"B7FF"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_code_comma_pipe(0),
      I1 => BU2_U0_receiver_pcs_sync_state1_state_1_1_1_9,
      I2 => BU2_U0_receiver_pcs_sync_state1_state_1_0_58,
      I3 => BU2_U0_receiver_pcs_sync_state1_code_valid_pipe(0),
      O => BU2_N4434
    );
  BU2_U0_receiver_pcs_sync_state0_mux0008_3_SW0_SW0 : LUT4
    generic map(
      INIT => X"B7FF"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_code_comma_pipe(0),
      I1 => BU2_U0_receiver_pcs_sync_state0_state_1_1_1_8,
      I2 => BU2_U0_receiver_pcs_sync_state0_state_1_0_52,
      I3 => BU2_U0_receiver_pcs_sync_state0_code_valid_pipe(0),
      O => BU2_N4430
    );
  BU2_U0_transmitter_state_machine_mux0017_2_29 : LUT4
    generic map(
      INIT => X"A820"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_mux0017_2_map2965,
      I1 => BU2_U0_transmitter_state_machine_next_state_0_0_Q,
      I2 => BU2_N4425,
      I3 => BU2_N4426,
      O => BU2_U0_transmitter_state_machine_next_state_1_2_Q
    );
  BU2_U0_transmitter_state_machine_mux0017_2_29_SW2 : LUT4
    generic map(
      INIT => X"FF1F"
    )
    port map (
      I0 => BU2_U0_transmitter_tx_is_q(1),
      I1 => BU2_U0_transmitter_tqmsg_capture_1_q_det_95,
      I2 => BU2_U0_transmitter_state_machine_next_state_0_1_Q,
      I3 => BU2_U0_transmitter_state_machine_next_state_0_2_Q,
      O => BU2_N4425
    );
  BU2_U0_receiver_recoder_or002655_SW0 : LUT3
    generic map(
      INIT => X"F9"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(15),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(14),
      I2 => BU2_U0_receiver_recoder_code_error_pipe(1),
      O => BU2_N4423
    );
  BU2_U0_receiver_pcs_sync_state0_sync_ok1 : LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_state_1_2_50,
      I1 => BU2_U0_receiver_pcs_sync_state0_state_1_3_49,
      I2 => BU2_U0_receiver_pcs_sync_state0_state_1_4_48,
      O => BU2_U0_receiver_sync_ok_int(0)
    );
  BU2_U0_receiver_pcs_sync_state1_sync_ok1 : LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_state_1_2_56,
      I1 => BU2_U0_receiver_pcs_sync_state1_state_1_3_55,
      I2 => BU2_U0_receiver_pcs_sync_state1_state_1_4_54,
      O => BU2_U0_receiver_sync_ok_int(1)
    );
  BU2_U0_receiver_pcs_sync_state2_sync_ok1 : LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_state_1_2_62,
      I1 => BU2_U0_receiver_pcs_sync_state2_state_1_3_61,
      I2 => BU2_U0_receiver_pcs_sync_state2_state_1_4_60,
      O => BU2_U0_receiver_sync_ok_int(2)
    );
  BU2_U0_receiver_pcs_sync_state3_sync_ok1 : LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_state_1_2_68,
      I1 => BU2_U0_receiver_pcs_sync_state3_state_1_3_67,
      I2 => BU2_U0_receiver_pcs_sync_state3_state_1_4_66,
      O => BU2_U0_receiver_sync_ok_int(3)
    );
  BU2_U0_receiver_recoder_or00011 : LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_or0018,
      I1 => BU2_U0_receiver_recoder_or0026_map2952,
      I2 => BU2_N5247,
      O => BU2_U0_receiver_recoder_or0001
    );
  BU2_U0_receiver_pcs_sync_state0_mux0019_12_1_SW1 : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_state_1_3_49,
      I1 => BU2_U0_receiver_pcs_sync_state0_code_comma_pipe(0),
      I2 => BU2_U0_receiver_pcs_sync_state0_state_1_2_50,
      I3 => BU2_U0_receiver_pcs_sync_state0_state_1_4_48,
      O => BU2_N3491
    );
  BU2_U0_receiver_pcs_sync_state1_mux0019_12_1_SW1 : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_state_1_3_55,
      I1 => BU2_U0_receiver_pcs_sync_state1_code_comma_pipe(0),
      I2 => BU2_U0_receiver_pcs_sync_state1_state_1_2_56,
      I3 => BU2_U0_receiver_pcs_sync_state1_state_1_4_54,
      O => BU2_N3486
    );
  BU2_U0_receiver_pcs_sync_state2_mux0019_12_1_SW1 : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_state_1_3_61,
      I1 => BU2_U0_receiver_pcs_sync_state2_code_comma_pipe(0),
      I2 => BU2_U0_receiver_pcs_sync_state2_state_1_2_62,
      I3 => BU2_U0_receiver_pcs_sync_state2_state_1_4_60,
      O => BU2_N3481
    );
  BU2_U0_receiver_pcs_sync_state3_mux0019_12_1_SW1 : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_state_1_3_67,
      I1 => BU2_U0_receiver_pcs_sync_state3_code_comma_pipe(0),
      I2 => BU2_U0_receiver_pcs_sync_state3_state_1_2_68,
      I3 => BU2_U0_receiver_pcs_sync_state3_state_1_4_66,
      O => BU2_N3476
    );
  BU2_U0_receiver_pcs_sync_state0_mux0008_16_SW0 : LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_code_valid_pipe(0),
      I1 => BU2_U0_receiver_pcs_sync_state0_state_1_2_50,
      I2 => BU2_U0_receiver_pcs_sync_state0_state_1_3_49,
      I3 => BU2_U0_receiver_pcs_sync_state0_state_1_4_48,
      O => BU2_N3003
    );
  BU2_U0_receiver_pcs_sync_state1_mux0008_16_SW0 : LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_code_valid_pipe(0),
      I1 => BU2_U0_receiver_pcs_sync_state1_state_1_2_56,
      I2 => BU2_U0_receiver_pcs_sync_state1_state_1_3_55,
      I3 => BU2_U0_receiver_pcs_sync_state1_state_1_4_54,
      O => BU2_N3001
    );
  BU2_U0_receiver_pcs_sync_state2_mux0008_16_SW0 : LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_code_valid_pipe(0),
      I1 => BU2_U0_receiver_pcs_sync_state2_state_1_2_62,
      I2 => BU2_U0_receiver_pcs_sync_state2_state_1_3_61,
      I3 => BU2_U0_receiver_pcs_sync_state2_state_1_4_60,
      O => BU2_N2999
    );
  BU2_U0_receiver_pcs_sync_state3_mux0008_16_SW0 : LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_code_valid_pipe(0),
      I1 => BU2_U0_receiver_pcs_sync_state3_state_1_2_68,
      I2 => BU2_U0_receiver_pcs_sync_state3_state_1_3_67,
      I3 => BU2_U0_receiver_pcs_sync_state3_state_1_4_66,
      O => BU2_N2997
    );
  BU2_U0_receiver_pcs_sync_state0_mux0019_7_SW1 : LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_state_1_2_50,
      I1 => BU2_U0_receiver_pcs_sync_state0_state_1_3_49,
      I2 => BU2_U0_receiver_pcs_sync_state0_state_1_0_52,
      I3 => BU2_U0_receiver_pcs_sync_state0_state_1_1_1_8,
      O => BU2_N3511
    );
  BU2_U0_receiver_pcs_sync_state1_mux0019_7_SW1 : LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_state_1_2_56,
      I1 => BU2_U0_receiver_pcs_sync_state1_state_1_3_55,
      I2 => BU2_U0_receiver_pcs_sync_state1_state_1_0_58,
      I3 => BU2_U0_receiver_pcs_sync_state1_state_1_1_1_9,
      O => BU2_N3508
    );
  BU2_U0_receiver_pcs_sync_state2_mux0019_7_SW1 : LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_state_1_2_62,
      I1 => BU2_U0_receiver_pcs_sync_state2_state_1_3_61,
      I2 => BU2_U0_receiver_pcs_sync_state2_state_1_0_64,
      I3 => BU2_U0_receiver_pcs_sync_state2_state_1_1_1_10,
      O => BU2_N3505
    );
  BU2_U0_receiver_pcs_sync_state3_mux0019_7_SW1 : LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_state_1_2_68,
      I1 => BU2_U0_receiver_pcs_sync_state3_state_1_3_67,
      I2 => BU2_U0_receiver_pcs_sync_state3_state_1_0_70,
      I3 => BU2_U0_receiver_pcs_sync_state3_state_1_1_1_11,
      O => BU2_N3502
    );
  BU2_U0_receiver_recoder_or00161 : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => BU2_U0_usrclk_reset_104,
      I1 => NlwRenamedSig_OI_align_status,
      I2 => BU2_U0_receiver_recoder_or0026_map2937,
      I3 => BU2_U0_receiver_recoder_or0026_map2952,
      O => BU2_U0_receiver_recoder_or0016
    );
  BU2_U0_transmitter_state_machine_mux0003_0_37 : LUT4
    generic map(
      INIT => X"FF02"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_mux0003_0_map3002,
      I1 => BU2_U0_transmitter_k_r_prbs_i_prbs(8),
      I2 => BU2_U0_transmitter_a_due(0),
      I3 => BU2_U0_transmitter_state_machine_mux0003_0_map3000,
      O => BU2_U0_transmitter_state_machine_next_state_0_0_Q
    );
  BU2_U0_receiver_pcs_sync_state0_next_state_1_0_118 : LUT4
    generic map(
      INIT => X"AAA8"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_code_valid_pipe(1),
      I1 => BU2_U0_receiver_pcs_sync_state0_mux0008_14_Q,
      I2 => BU2_U0_receiver_pcs_sync_state0_mux0008_16_Q_12,
      I3 => BU2_N4388,
      O => BU2_U0_receiver_pcs_sync_state0_next_state_1_0_map2913
    );
  BU2_U0_receiver_pcs_sync_state1_next_state_1_0_118 : LUT4
    generic map(
      INIT => X"AAA8"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_code_valid_pipe(1),
      I1 => BU2_U0_receiver_pcs_sync_state1_mux0008_14_Q,
      I2 => BU2_U0_receiver_pcs_sync_state1_mux0008_16_Q_13,
      I3 => BU2_N4386,
      O => BU2_U0_receiver_pcs_sync_state1_next_state_1_0_map2862
    );
  BU2_U0_receiver_pcs_sync_state2_next_state_1_0_118 : LUT4
    generic map(
      INIT => X"AAA8"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_code_valid_pipe(1),
      I1 => BU2_U0_receiver_pcs_sync_state2_mux0008_14_Q,
      I2 => BU2_U0_receiver_pcs_sync_state2_mux0008_16_Q_14,
      I3 => BU2_N4384,
      O => BU2_U0_receiver_pcs_sync_state2_next_state_1_0_map2811
    );
  BU2_U0_receiver_pcs_sync_state3_next_state_1_0_118 : LUT4
    generic map(
      INIT => X"AAA8"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_code_valid_pipe(1),
      I1 => BU2_U0_receiver_pcs_sync_state3_mux0008_14_Q,
      I2 => BU2_U0_receiver_pcs_sync_state3_mux0008_16_Q_15,
      I3 => BU2_N4382,
      O => BU2_U0_receiver_pcs_sync_state3_next_state_1_0_map2760
    );
  BU2_U0_transmitter_recoder_mux0454181 : LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_N35,
      I1 => BU2_U0_transmitter_filter1_txd_out(0),
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(8),
      I3 => BU2_U0_transmitter_recoder_N38,
      O => BU2_N4380
    );
  BU2_U0_transmitter_recoder_mux0442181 : LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_N47,
      I1 => BU2_U0_transmitter_filter7_txd_out(0),
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(24),
      I3 => BU2_U0_transmitter_recoder_N37,
      O => BU2_N4377
    );
  BU2_U0_transmitter_recoder_mux0433181 : LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_N47,
      I1 => BU2_U0_transmitter_filter6_txd_out(0),
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(16),
      I3 => BU2_U0_transmitter_recoder_N37,
      O => BU2_N4375
    );
  BU2_U0_transmitter_recoder_mux0432181 : LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_N35,
      I1 => BU2_U0_transmitter_filter0_txd_out(0),
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(0),
      I3 => BU2_U0_transmitter_recoder_N38,
      O => BU2_N4374
    );
  BU2_U0_transmitter_recoder_mux0417181 : LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_N47,
      I1 => BU2_U0_transmitter_filter5_txd_out(0),
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(8),
      I3 => BU2_U0_transmitter_recoder_N37,
      O => BU2_N4371
    );
  BU2_U0_transmitter_recoder_mux0411181 : LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_N47,
      I1 => BU2_U0_transmitter_filter4_txd_out(0),
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(0),
      I3 => BU2_U0_transmitter_recoder_N37,
      O => BU2_N4370
    );
  BU2_U0_transmitter_recoder_mux0405181 : LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_N35,
      I1 => BU2_U0_transmitter_filter3_txd_out(0),
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(24),
      I3 => BU2_U0_transmitter_recoder_N38,
      O => BU2_N4368
    );
  BU2_U0_transmitter_recoder_mux0398181 : LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_N35,
      I1 => BU2_U0_transmitter_filter2_txd_out(0),
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(16),
      I3 => BU2_U0_transmitter_recoder_N38,
      O => BU2_N4366
    );
  BU2_U0_transmitter_state_machine_mux0017_0_331 : LUT4
    generic map(
      INIT => X"A0E0"
    )
    port map (
      I0 => BU2_N4390,
      I1 => BU2_U0_transmitter_state_machine_N11,
      I2 => BU2_U0_transmitter_state_machine_next_state_0_1_Q,
      I3 => BU2_U0_transmitter_state_machine_next_state_0_0_Q,
      O => BU2_N4381
    );
  BU2_U0_receiver_recoder_or00031 : LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_or0019,
      I1 => BU2_U0_receiver_recoder_or0027_map2639,
      I2 => BU2_U0_receiver_recoder_or0027_map2621,
      O => BU2_U0_receiver_recoder_or0003
    );
  BU2_U0_transmitter_align_not00021 : LUT4
    generic map(
      INIT => X"22F2"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1_1_19,
      I1 => BU2_U0_transmitter_state_machine_state_1_0_1_18,
      I2 => BU2_U0_transmitter_state_machine_state_0_1_1_17,
      I3 => BU2_U0_transmitter_state_machine_state_0_0_1_16,
      O => BU2_U0_transmitter_align_not0002
    );
  BU2_U0_receiver_recoder_or00021 : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => BU2_U0_usrclk_reset_104,
      I1 => NlwRenamedSig_OI_align_status,
      I2 => BU2_U0_receiver_recoder_or0027_map2621,
      I3 => BU2_U0_receiver_recoder_or0027_map2639,
      O => BU2_U0_receiver_recoder_or0002
    );
  BU2_U0_transmitter_state_machine_state_1_0 : FDRS
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_N4381,
      R => BU2_U0_usrclk_reset_2_103,
      S => BU2_U0_transmitter_state_machine_mux0017_0_map2983,
      C => usrclk,
      Q => BU2_U0_transmitter_state_machine_state_1_0_43
    );
  BU2_U0_transmitter_recoder_txd_out_8 : FDRS
    port map (
      D => BU2_N4380,
      R => BU2_U0_usrclk_reset_2_103,
      S => BU2_U0_transmitter_recoder_mux0398_map2487,
      C => usrclk,
      Q => mgt_txdata_110(24)
    );
  BU2_U0_transmitter_recoder_txd_out_6 : FDRS
    port map (
      D => BU2_N4379,
      R => BU2_U0_usrclk_reset_2_103,
      S => BU2_U0_transmitter_recoder_N19,
      C => usrclk,
      Q => mgt_txdata_110(14)
    );
  BU2_U0_transmitter_recoder_txd_out_62 : FDRS
    port map (
      D => BU2_N4378,
      R => BU2_U0_usrclk_reset_2_103,
      S => BU2_U0_transmitter_recoder_N19,
      C => usrclk,
      Q => mgt_txdata_110(54)
    );
  BU2_U0_transmitter_recoder_txd_out_56 : FDRS
    port map (
      D => BU2_N4377,
      R => BU2_U0_usrclk_reset_2_103,
      S => BU2_U0_transmitter_recoder_mux0398_map2487,
      C => usrclk,
      Q => mgt_txdata_110(48)
    );
  BU2_U0_transmitter_recoder_txd_out_54 : FDRS
    port map (
      D => BU2_N4376,
      R => BU2_U0_usrclk_reset_2_103,
      S => BU2_U0_transmitter_recoder_N19,
      C => usrclk,
      Q => mgt_txdata_110(38)
    );
  BU2_U0_transmitter_recoder_txd_out_48 : FDRS
    port map (
      D => BU2_N4375,
      R => BU2_U0_usrclk_reset_2_103,
      S => BU2_U0_transmitter_recoder_mux0398_map2487,
      C => usrclk,
      Q => mgt_txdata_110(32)
    );
  BU2_U0_transmitter_recoder_txd_out_0 : FDRS
    port map (
      D => BU2_N4374,
      R => BU2_U0_usrclk_reset_2_103,
      S => BU2_U0_transmitter_recoder_mux0398_map2487,
      C => usrclk,
      Q => mgt_txdata_110(8)
    );
  BU2_U0_transmitter_recoder_txd_out_46 : FDRS
    port map (
      D => BU2_N4373,
      R => BU2_U0_usrclk_reset_2_103,
      S => BU2_U0_transmitter_recoder_N19,
      C => usrclk,
      Q => mgt_txdata_110(22)
    );
  BU2_U0_transmitter_recoder_txd_out_38 : FDRS
    port map (
      D => BU2_N4372,
      R => BU2_U0_usrclk_reset_2_103,
      S => BU2_U0_transmitter_recoder_N19,
      C => usrclk,
      Q => mgt_txdata_110(6)
    );
  BU2_U0_transmitter_recoder_txd_out_40 : FDRS
    port map (
      D => BU2_N4371,
      R => BU2_U0_usrclk_reset_2_103,
      S => BU2_U0_transmitter_recoder_mux0398_map2487,
      C => usrclk,
      Q => mgt_txdata_110(16)
    );
  BU2_U0_transmitter_recoder_txd_out_32 : FDRS
    port map (
      D => BU2_N4370,
      R => BU2_U0_usrclk_reset_2_103,
      S => BU2_U0_transmitter_recoder_mux0398_map2487,
      C => usrclk,
      Q => mgt_txdata_110(0)
    );
  BU2_U0_transmitter_recoder_txd_out_30 : FDRS
    port map (
      D => BU2_N4369,
      R => BU2_U0_usrclk_reset_2_103,
      S => BU2_U0_transmitter_recoder_N19,
      C => usrclk,
      Q => mgt_txdata_110(62)
    );
  BU2_U0_transmitter_recoder_txd_out_24 : FDRS
    port map (
      D => BU2_N4368,
      R => BU2_U0_usrclk_reset_2_103,
      S => BU2_U0_transmitter_recoder_mux0398_map2487,
      C => usrclk,
      Q => mgt_txdata_110(56)
    );
  BU2_U0_transmitter_recoder_txd_out_22 : FDRS
    port map (
      D => BU2_N4367,
      R => BU2_U0_usrclk_reset_2_103,
      S => BU2_U0_transmitter_recoder_N19,
      C => usrclk,
      Q => mgt_txdata_110(46)
    );
  BU2_U0_transmitter_recoder_txd_out_16 : FDRS
    port map (
      D => BU2_N4366,
      R => BU2_U0_usrclk_reset_2_103,
      S => BU2_U0_transmitter_recoder_mux0398_map2487,
      C => usrclk,
      Q => mgt_txdata_110(40)
    );
  BU2_U0_transmitter_recoder_txd_out_14 : FDRS
    port map (
      D => BU2_N4365,
      R => BU2_U0_usrclk_reset_2_103,
      S => BU2_U0_transmitter_recoder_N19,
      C => usrclk,
      Q => mgt_txdata_110(30)
    );
  BU2_U0_transmitter_state_machine_mux0017_0_12 : LUT4
    generic map(
      INIT => X"AAEA"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_mux0017_0_map2982,
      I1 => BU2_U0_transmitter_state_machine_N2,
      I2 => BU2_U0_transmitter_state_machine_next_state_0_2_Q,
      I3 => BU2_U0_transmitter_state_machine_next_state_0_1_Q,
      O => BU2_U0_transmitter_state_machine_mux0017_0_map2983
    );
  BU2_U0_transmitter_state_machine_mux0017_0_8 : LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => BU2_U0_transmitter_tx_is_idle(1),
      I1 => BU2_U0_transmitter_tx_is_q(1),
      O => BU2_U0_transmitter_state_machine_mux0017_0_map2982
    );
  BU2_U0_transmitter_state_machine_mux0017_2_0 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_transmitter_tx_is_idle(1),
      I1 => BU2_U0_transmitter_tx_is_q(1),
      O => BU2_U0_transmitter_state_machine_mux0017_2_map2965
    );
  BU2_U0_transmitter_state_machine_mux0003_1_31 : LUT4
    generic map(
      INIT => X"AA80"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_mux0003_1_map2954,
      I1 => BU2_U0_transmitter_state_machine_mux0003_1_map2961,
      I2 => BU2_N5255,
      I3 => BU2_U0_transmitter_state_machine_mux0003_1_map2957,
      O => BU2_U0_transmitter_state_machine_next_state_0_1_Q
    );
  BU2_U0_transmitter_state_machine_mux0003_1_14 : LUT4
    generic map(
      INIT => X"0F08"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_next_ifg_is_a_77,
      I1 => BU2_U0_transmitter_state_machine_state_1_0_43,
      I2 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I3 => BU2_U0_transmitter_state_machine_state_1_2_72,
      O => BU2_U0_transmitter_state_machine_mux0003_1_map2961
    );
  BU2_U0_transmitter_state_machine_mux0003_1_6 : LUT3
    generic map(
      INIT => X"20"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I1 => BU2_U0_transmitter_state_machine_state_1_0_43,
      I2 => BU2_N5240,
      O => BU2_U0_transmitter_state_machine_mux0003_1_map2957
    );
  BU2_U0_transmitter_state_machine_mux0003_1_0 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_transmitter_tx_is_idle(0),
      I1 => BU2_U0_transmitter_tx_is_q(0),
      O => BU2_U0_transmitter_state_machine_mux0003_1_map2954
    );
  BU2_U0_receiver_recoder_or002651 : LUT4
    generic map(
      INIT => X"0302"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_lane_term_pipe(2),
      I1 => BU2_U0_receiver_recoder_lane_term_pipe(0),
      I2 => BU2_U0_receiver_recoder_lane_term_pipe(1),
      I3 => BU2_U0_receiver_recoder_lane_term_pipe(3),
      O => BU2_U0_receiver_recoder_or0026_map2951
    );
  BU2_U0_receiver_recoder_or00221 : LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(12),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(11),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(10),
      I3 => BU2_N5241,
      O => BU2_U0_receiver_recoder_N15
    );
  BU2_U0_receiver_pcs_sync_state0_next_state_1_0_71 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_code_comma_pipe(1),
      I1 => BU2_U0_signal_detect_int(0),
      O => BU2_U0_receiver_pcs_sync_state0_next_state_1_0_map2903
    );
  BU2_U0_receiver_pcs_sync_state1_next_state_1_0_71 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_code_comma_pipe(1),
      I1 => BU2_U0_signal_detect_int(1),
      O => BU2_U0_receiver_pcs_sync_state1_next_state_1_0_map2852
    );
  BU2_U0_receiver_pcs_sync_state2_next_state_1_0_71 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_code_comma_pipe(1),
      I1 => BU2_U0_signal_detect_int(2),
      O => BU2_U0_receiver_pcs_sync_state2_next_state_1_0_map2801
    );
  BU2_U0_receiver_pcs_sync_state3_next_state_1_0_71 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_code_comma_pipe(1),
      I1 => BU2_U0_signal_detect_int(3),
      O => BU2_U0_receiver_pcs_sync_state3_next_state_1_0_map2750
    );
  BU2_U0_receiver_deskew_state_mux0044_1_130 : LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      I0 => BU2_U0_receiver_deskew_state_deskew_error(1),
      I1 => BU2_U0_receiver_deskew_state_state_1_0_45,
      I2 => NlwRenamedSig_OI_align_status,
      I3 => BU2_U0_receiver_deskew_state_deskew_error(0),
      O => BU2_U0_receiver_deskew_state_mux0044_1_map2701
    );
  BU2_U0_receiver_pcs_sync_state0_mux0008_1_SW0 : LUT4
    generic map(
      INIT => X"B5BF"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_code_comma_pipe(0),
      I1 => BU2_U0_receiver_pcs_sync_state0_code_valid_pipe(0),
      I2 => BU2_U0_receiver_pcs_sync_state0_state_1_0_52,
      I3 => BU2_U0_signal_detect_int(0),
      O => BU2_N3519
    );
  BU2_U0_receiver_pcs_sync_state1_mux0008_1_SW0 : LUT4
    generic map(
      INIT => X"B5BF"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_code_comma_pipe(0),
      I1 => BU2_U0_receiver_pcs_sync_state1_code_valid_pipe(0),
      I2 => BU2_U0_receiver_pcs_sync_state1_state_1_0_58,
      I3 => BU2_U0_signal_detect_int(1),
      O => BU2_N3517
    );
  BU2_U0_receiver_pcs_sync_state2_mux0008_1_SW0 : LUT4
    generic map(
      INIT => X"B5BF"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_code_comma_pipe(0),
      I1 => BU2_U0_receiver_pcs_sync_state2_code_valid_pipe(0),
      I2 => BU2_U0_receiver_pcs_sync_state2_state_1_0_64,
      I3 => BU2_U0_signal_detect_int(2),
      O => BU2_N3515
    );
  BU2_U0_receiver_pcs_sync_state3_mux0008_1_SW0 : LUT4
    generic map(
      INIT => X"B5BF"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_code_comma_pipe(0),
      I1 => BU2_U0_receiver_pcs_sync_state3_code_valid_pipe(0),
      I2 => BU2_U0_receiver_pcs_sync_state3_state_1_0_70,
      I3 => BU2_U0_signal_detect_int(3),
      O => BU2_N3513
    );
  BU2_U0_receiver_pcs_sync_state0_mux0019_7_Q : LUT4
    generic map(
      INIT => X"0819"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_code_valid_pipe(0),
      I1 => BU2_U0_receiver_pcs_sync_state0_state_1_4_48,
      I2 => BU2_N3511,
      I3 => BU2_N3510,
      O => BU2_U0_receiver_pcs_sync_state0_mux0019(7)
    );
  BU2_U0_receiver_pcs_sync_state1_mux0019_7_Q : LUT4
    generic map(
      INIT => X"0819"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_code_valid_pipe(0),
      I1 => BU2_U0_receiver_pcs_sync_state1_state_1_4_54,
      I2 => BU2_N3508,
      I3 => BU2_N3507,
      O => BU2_U0_receiver_pcs_sync_state1_mux0019(7)
    );
  BU2_U0_receiver_pcs_sync_state2_mux0019_7_Q : LUT4
    generic map(
      INIT => X"0819"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_code_valid_pipe(0),
      I1 => BU2_U0_receiver_pcs_sync_state2_state_1_4_60,
      I2 => BU2_N3505,
      I3 => BU2_N3504,
      O => BU2_U0_receiver_pcs_sync_state2_mux0019(7)
    );
  BU2_U0_receiver_pcs_sync_state3_mux0019_7_Q : LUT4
    generic map(
      INIT => X"0819"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_code_valid_pipe(0),
      I1 => BU2_U0_receiver_pcs_sync_state3_state_1_4_66,
      I2 => BU2_N3502,
      I3 => BU2_N3501,
      O => BU2_U0_receiver_pcs_sync_state3_mux0019(7)
    );
  BU2_U0_receiver_pcs_sync_state0_mux0019_12_1 : LUT4
    generic map(
      INIT => X"0819"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_state_1_1_51,
      I1 => BU2_U0_receiver_pcs_sync_state0_state_1_0_52,
      I2 => BU2_N3491,
      I3 => BU2_N3490,
      O => BU2_U0_receiver_pcs_sync_state0_N91
    );
  BU2_U0_receiver_pcs_sync_state1_mux0019_12_1 : LUT4
    generic map(
      INIT => X"0819"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_state_1_1_57,
      I1 => BU2_U0_receiver_pcs_sync_state1_state_1_0_58,
      I2 => BU2_N3486,
      I3 => BU2_N3485,
      O => BU2_U0_receiver_pcs_sync_state1_N91
    );
  BU2_U0_receiver_pcs_sync_state2_mux0019_12_1 : LUT4
    generic map(
      INIT => X"0819"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_state_1_1_63,
      I1 => BU2_U0_receiver_pcs_sync_state2_state_1_0_64,
      I2 => BU2_N3481,
      I3 => BU2_N3480,
      O => BU2_U0_receiver_pcs_sync_state2_N91
    );
  BU2_U0_receiver_pcs_sync_state3_mux0019_12_1 : LUT4
    generic map(
      INIT => X"0819"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_state_1_1_69,
      I1 => BU2_U0_receiver_pcs_sync_state3_state_1_0_70,
      I2 => BU2_N3476,
      I3 => BU2_N3475,
      O => BU2_U0_receiver_pcs_sync_state3_N91
    );
  BU2_U0_receiver_pcs_sync_state0_mux0019_7_31 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_state_1_2_50,
      I1 => BU2_U0_receiver_pcs_sync_state0_state_1_3_49,
      O => BU2_U0_receiver_pcs_sync_state0_N13
    );
  BU2_U0_receiver_pcs_sync_state1_mux0019_7_31 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_state_1_2_56,
      I1 => BU2_U0_receiver_pcs_sync_state1_state_1_3_55,
      O => BU2_U0_receiver_pcs_sync_state1_N13
    );
  BU2_U0_receiver_pcs_sync_state2_mux0019_7_31 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_state_1_2_62,
      I1 => BU2_U0_receiver_pcs_sync_state2_state_1_3_61,
      O => BU2_U0_receiver_pcs_sync_state2_N13
    );
  BU2_U0_receiver_pcs_sync_state3_mux0019_7_31 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_state_1_2_68,
      I1 => BU2_U0_receiver_pcs_sync_state3_state_1_3_67,
      O => BU2_U0_receiver_pcs_sync_state3_N13
    );
  BU2_U0_transmitter_align_or0002 : LUT4
    generic map(
      INIT => X"0103"
    )
    port map (
      I0 => BU2_U0_transmitter_align_count(2),
      I1 => BU2_U0_transmitter_align_count(4),
      I2 => BU2_U0_transmitter_align_count(3),
      I3 => BU2_N3454,
      O => BU2_U0_transmitter_align_or0002_20
    );
  BU2_U0_receiver_recoder_or0031115 : LUT4
    generic map(
      INIT => X"FFEA"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_pipe(2),
      I1 => BU2_U0_receiver_recoder_or0031_map2666,
      I2 => BU2_N5231,
      I3 => BU2_U0_receiver_recoder_or0031_map2644,
      O => BU2_U0_receiver_recoder_error_lane(6)
    );
  BU2_U0_receiver_recoder_or003142 : LUT4
    generic map(
      INIT => X"FF7F"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(54),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(50),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(51),
      I3 => BU2_U0_receiver_recoder_rxd_pipe(49),
      O => BU2_U0_receiver_recoder_or0031_map2658
    );
  BU2_U0_receiver_recoder_or00317 : LUT4
    generic map(
      INIT => X"AF8C"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_pipe(6),
      I1 => BU2_U0_receiver_recoder_lane_terminate(5),
      I2 => BU2_N5248,
      I3 => BU2_U0_receiver_recoder_lane_terminate(4),
      O => BU2_U0_receiver_recoder_or0031_map2644
    );
  BU2_U0_receiver_recoder_or002778 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_N5249,
      I1 => BU2_U0_receiver_recoder_or0027_map2639,
      O => BU2_U0_receiver_recoder_error_lane(2)
    );
  BU2_U0_receiver_recoder_or002765 : LUT4
    generic map(
      INIT => X"88A8"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_or0027_map2638,
      I1 => BU2_U0_receiver_recoder_code_error_pipe(2),
      I2 => BU2_U0_receiver_recoder_or0027_map2629,
      I3 => BU2_U0_receiver_recoder_and0020_21,
      O => BU2_U0_receiver_recoder_or0027_map2639
    );
  BU2_U0_receiver_recoder_or002761 : LUT4
    generic map(
      INIT => X"0004"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_lane_term_pipe(2),
      I1 => BU2_U0_receiver_recoder_lane_term_pipe(3),
      I2 => BU2_U0_receiver_recoder_lane_term_pipe(0),
      I3 => BU2_U0_receiver_recoder_lane_term_pipe(1),
      O => BU2_U0_receiver_recoder_or0027_map2638
    );
  BU2_U0_receiver_recoder_and004015 : LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(51),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(52),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(54),
      O => BU2_U0_receiver_recoder_and0040_map2615
    );
  BU2_U0_receiver_recoder_and00407 : LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxc_pipe(6),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(55),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(50),
      I3 => BU2_U0_receiver_recoder_rxd_pipe(49),
      O => BU2_U0_receiver_recoder_and0040_map2610
    );
  BU2_U0_receiver_recoder_or00231 : LUT4
    generic map(
      INIT => X"0008"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(18),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(20),
      I2 => BU2_N5230,
      I3 => BU2_U0_receiver_recoder_rxd_pipe(17),
      O => BU2_U0_receiver_recoder_N17
    );
  BU2_U0_receiver_pcs_sync_state0_next_state_1_2_46 : LUT4
    generic map(
      INIT => X"3332"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_next_state_1_2_map2597,
      I1 => BU2_U0_receiver_pcs_sync_state0_signal_detect_change,
      I2 => BU2_U0_receiver_pcs_sync_state0_next_state_1_2_map2603,
      I3 => BU2_U0_receiver_pcs_sync_state0_next_state_1_2_map2594,
      O => BU2_U0_receiver_pcs_sync_state0_next_state(1, 2)
    );
  BU2_U0_receiver_pcs_sync_state0_next_state_1_2_9 : LUT3
    generic map(
      INIT => X"32"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_mux0019(7),
      I1 => BU2_U0_receiver_pcs_sync_state0_code_valid_pipe(1),
      I2 => BU2_N5254,
      O => BU2_U0_receiver_pcs_sync_state0_next_state_1_2_map2597
    );
  BU2_U0_receiver_pcs_sync_state0_next_state_1_2_4 : LUT4
    generic map(
      INIT => X"FFF8"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_code_valid_pipe(0),
      I1 => BU2_U0_receiver_pcs_sync_state0_N91,
      I2 => BU2_N5216,
      I3 => BU2_U0_receiver_pcs_sync_state0_mux0008_12_Q,
      O => BU2_U0_receiver_pcs_sync_state0_next_state_1_2_map2594
    );
  BU2_U0_receiver_pcs_sync_state1_next_state_1_2_46 : LUT4
    generic map(
      INIT => X"3332"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_next_state_1_2_map2582,
      I1 => BU2_U0_receiver_pcs_sync_state1_signal_detect_change,
      I2 => BU2_U0_receiver_pcs_sync_state1_next_state_1_2_map2588,
      I3 => BU2_U0_receiver_pcs_sync_state1_next_state_1_2_map2579,
      O => BU2_U0_receiver_pcs_sync_state1_next_state(1, 2)
    );
  BU2_U0_receiver_pcs_sync_state1_next_state_1_2_9 : LUT3
    generic map(
      INIT => X"32"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_mux0019(7),
      I1 => BU2_U0_receiver_pcs_sync_state1_code_valid_pipe(1),
      I2 => BU2_N5253,
      O => BU2_U0_receiver_pcs_sync_state1_next_state_1_2_map2582
    );
  BU2_U0_receiver_pcs_sync_state1_next_state_1_2_4 : LUT4
    generic map(
      INIT => X"FFF8"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_code_valid_pipe(0),
      I1 => BU2_U0_receiver_pcs_sync_state1_N91,
      I2 => BU2_N5214,
      I3 => BU2_U0_receiver_pcs_sync_state1_mux0008_12_Q,
      O => BU2_U0_receiver_pcs_sync_state1_next_state_1_2_map2579
    );
  BU2_U0_receiver_pcs_sync_state2_next_state_1_2_46 : LUT4
    generic map(
      INIT => X"3332"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_next_state_1_2_map2567,
      I1 => BU2_U0_receiver_pcs_sync_state2_signal_detect_change,
      I2 => BU2_U0_receiver_pcs_sync_state2_next_state_1_2_map2573,
      I3 => BU2_U0_receiver_pcs_sync_state2_next_state_1_2_map2564,
      O => BU2_U0_receiver_pcs_sync_state2_next_state(1, 2)
    );
  BU2_U0_receiver_pcs_sync_state2_next_state_1_2_9 : LUT3
    generic map(
      INIT => X"32"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_mux0019(7),
      I1 => BU2_U0_receiver_pcs_sync_state2_code_valid_pipe(1),
      I2 => BU2_N5252,
      O => BU2_U0_receiver_pcs_sync_state2_next_state_1_2_map2567
    );
  BU2_U0_receiver_pcs_sync_state2_next_state_1_2_4 : LUT4
    generic map(
      INIT => X"FFF8"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_code_valid_pipe(0),
      I1 => BU2_U0_receiver_pcs_sync_state2_N91,
      I2 => BU2_N5212,
      I3 => BU2_U0_receiver_pcs_sync_state2_mux0008_12_Q,
      O => BU2_U0_receiver_pcs_sync_state2_next_state_1_2_map2564
    );
  BU2_U0_receiver_pcs_sync_state3_next_state_1_2_46 : LUT4
    generic map(
      INIT => X"3332"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_next_state_1_2_map2552,
      I1 => BU2_U0_receiver_pcs_sync_state3_signal_detect_change,
      I2 => BU2_U0_receiver_pcs_sync_state3_next_state_1_2_map2558,
      I3 => BU2_U0_receiver_pcs_sync_state3_next_state_1_2_map2549,
      O => BU2_U0_receiver_pcs_sync_state3_next_state(1, 2)
    );
  BU2_U0_receiver_pcs_sync_state3_next_state_1_2_9 : LUT3
    generic map(
      INIT => X"32"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_mux0019(7),
      I1 => BU2_U0_receiver_pcs_sync_state3_code_valid_pipe(1),
      I2 => BU2_N5251,
      O => BU2_U0_receiver_pcs_sync_state3_next_state_1_2_map2552
    );
  BU2_U0_receiver_pcs_sync_state3_next_state_1_2_4 : LUT4
    generic map(
      INIT => X"FFF8"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_code_valid_pipe(0),
      I1 => BU2_U0_receiver_pcs_sync_state3_N91,
      I2 => BU2_N5210,
      I3 => BU2_U0_receiver_pcs_sync_state3_mux0008_12_Q,
      O => BU2_U0_receiver_pcs_sync_state3_next_state_1_2_map2549
    );
  BU2_U0_transmitter_recoder_mux03988 : LUT3
    generic map(
      INIT => X"10"
    )
    port map (
      I0 => configuration_vector_123(6),
      I1 => configuration_vector_123(5),
      I2 => configuration_vector_123(4),
      O => BU2_U0_transmitter_recoder_mux0398_map2487
    );
  BU2_U0_transmitter_state_machine_mux0003_2_Q : LUT4
    generic map(
      INIT => X"EA40"
    )
    port map (
      I0 => BU2_U0_transmitter_tx_is_q(0),
      I1 => BU2_U0_transmitter_tx_is_idle(0),
      I2 => BU2_N3013,
      I3 => BU2_N3014,
      O => BU2_U0_transmitter_state_machine_next_state_0_2_Q
    );
  BU2_U0_transmitter_state_machine_mux0003_2_SW0 : LUT4
    generic map(
      INIT => X"FFC7"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_q_det_95,
      I1 => BU2_U0_transmitter_state_machine_state_1_1_2_24,
      I2 => BU2_U0_transmitter_state_machine_state_1_0_2_23,
      I3 => BU2_U0_transmitter_state_machine_state_1_2_1_22,
      O => BU2_N3013
    );
  BU2_U0_transmitter_state_machine_mux0017_1_11 : LUT3
    generic map(
      INIT => X"AE"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_q_det_95,
      I1 => BU2_U0_transmitter_tx_is_q(1),
      I2 => BU2_U0_transmitter_state_machine_next_state_0_2_Q,
      O => BU2_U0_transmitter_state_machine_N11
    );
  BU2_U0_receiver_recoder_or0030141 : LUT4
    generic map(
      INIT => X"FFEA"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_pipe(1),
      I1 => BU2_U0_receiver_recoder_or0030_map2460,
      I2 => BU2_U0_receiver_recoder_or0030_map2463,
      I3 => BU2_N5217,
      O => BU2_U0_receiver_recoder_error_lane(5)
    );
  BU2_U0_receiver_recoder_or0030113 : LUT4
    generic map(
      INIT => X"7FFF"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(43),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(44),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(45),
      I3 => BU2_U0_receiver_recoder_rxd_pipe(47),
      O => BU2_U0_receiver_recoder_or0030_map2479
    );
  BU2_U0_receiver_recoder_or003094 : LUT2
    generic map(
      INIT => X"7"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxc_pipe(5),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(42),
      O => BU2_U0_receiver_recoder_or0030_map2471
    );
  BU2_U0_receiver_recoder_or003090 : LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_pipe(5),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(40),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(41),
      I3 => BU2_U0_receiver_recoder_rxd_pipe(46),
      O => BU2_U0_receiver_recoder_or0030_map2468
    );
  BU2_U0_receiver_recoder_or00307 : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(40),
      I1 => BU2_U0_receiver_recoder_rxc_pipe(5),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(41),
      I3 => BU2_U0_receiver_recoder_code_error_pipe(5),
      O => BU2_U0_receiver_recoder_or0030_map2446
    );
  BU2_U0_receiver_recoder_or00091 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_error_lane(5),
      I1 => BU2_U0_receiver_recoder_or0022,
      O => BU2_U0_receiver_recoder_or0009
    );
  BU2_U0_receiver_pcs_sync_state0_next_state_1_1_39 : LUT4
    generic map(
      INIT => X"AAA8"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_next_state_1_1_map2441,
      I1 => BU2_U0_receiver_pcs_sync_state0_next_state_1_1_map2431,
      I2 => BU2_U0_receiver_pcs_sync_state0_next_state_1_1_map2434,
      I3 => BU2_U0_receiver_pcs_sync_state0_next_state_1_1_map2437,
      O => BU2_U0_receiver_pcs_sync_state0_next_state(1, 1)
    );
  BU2_U0_receiver_pcs_sync_state0_next_state_1_1_10 : LUT3
    generic map(
      INIT => X"DC"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_code_comma_pipe(1),
      I1 => BU2_U0_receiver_pcs_sync_state0_mux0019(7),
      I2 => BU2_U0_receiver_pcs_sync_state0_mux0008_3_Q_25,
      O => BU2_U0_receiver_pcs_sync_state0_next_state_1_1_map2434
    );
  BU2_U0_receiver_pcs_sync_state0_next_state_1_1_4 : LUT4
    generic map(
      INIT => X"FFF8"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_code_comma_pipe(1),
      I1 => BU2_U0_receiver_pcs_sync_state0_mux0008_1_Q_27,
      I2 => BU2_U0_receiver_pcs_sync_state0_mux0008_13_Q_37,
      I3 => BU2_U0_receiver_pcs_sync_state0_mux0008_2_Q_26,
      O => BU2_U0_receiver_pcs_sync_state0_next_state_1_1_map2431
    );
  BU2_U0_receiver_pcs_sync_state1_next_state_1_1_39 : LUT4
    generic map(
      INIT => X"AAA8"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_next_state_1_1_map2427,
      I1 => BU2_U0_receiver_pcs_sync_state1_next_state_1_1_map2417,
      I2 => BU2_U0_receiver_pcs_sync_state1_next_state_1_1_map2420,
      I3 => BU2_U0_receiver_pcs_sync_state1_next_state_1_1_map2423,
      O => BU2_U0_receiver_pcs_sync_state1_next_state(1, 1)
    );
  BU2_U0_receiver_pcs_sync_state1_next_state_1_1_10 : LUT3
    generic map(
      INIT => X"DC"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_code_comma_pipe(1),
      I1 => BU2_U0_receiver_pcs_sync_state1_mux0019(7),
      I2 => BU2_U0_receiver_pcs_sync_state1_mux0008_3_Q_28,
      O => BU2_U0_receiver_pcs_sync_state1_next_state_1_1_map2420
    );
  BU2_U0_receiver_pcs_sync_state1_next_state_1_1_4 : LUT4
    generic map(
      INIT => X"FFF8"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_code_comma_pipe(1),
      I1 => BU2_U0_receiver_pcs_sync_state1_mux0008_1_Q_30,
      I2 => BU2_U0_receiver_pcs_sync_state1_mux0008_13_Q_38,
      I3 => BU2_U0_receiver_pcs_sync_state1_mux0008_2_Q_29,
      O => BU2_U0_receiver_pcs_sync_state1_next_state_1_1_map2417
    );
  BU2_U0_receiver_pcs_sync_state2_next_state_1_1_39 : LUT4
    generic map(
      INIT => X"AAA8"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_next_state_1_1_map2413,
      I1 => BU2_U0_receiver_pcs_sync_state2_next_state_1_1_map2403,
      I2 => BU2_U0_receiver_pcs_sync_state2_next_state_1_1_map2406,
      I3 => BU2_U0_receiver_pcs_sync_state2_next_state_1_1_map2409,
      O => BU2_U0_receiver_pcs_sync_state2_next_state(1, 1)
    );
  BU2_U0_receiver_pcs_sync_state2_next_state_1_1_10 : LUT3
    generic map(
      INIT => X"DC"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_code_comma_pipe(1),
      I1 => BU2_U0_receiver_pcs_sync_state2_mux0019(7),
      I2 => BU2_U0_receiver_pcs_sync_state2_mux0008_3_Q_31,
      O => BU2_U0_receiver_pcs_sync_state2_next_state_1_1_map2406
    );
  BU2_U0_receiver_pcs_sync_state2_next_state_1_1_4 : LUT4
    generic map(
      INIT => X"FFF8"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_code_comma_pipe(1),
      I1 => BU2_U0_receiver_pcs_sync_state2_mux0008_1_Q_33,
      I2 => BU2_U0_receiver_pcs_sync_state2_mux0008_13_Q_39,
      I3 => BU2_U0_receiver_pcs_sync_state2_mux0008_2_Q_32,
      O => BU2_U0_receiver_pcs_sync_state2_next_state_1_1_map2403
    );
  BU2_U0_receiver_pcs_sync_state3_next_state_1_1_39 : LUT4
    generic map(
      INIT => X"AAA8"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_next_state_1_1_map2399,
      I1 => BU2_U0_receiver_pcs_sync_state3_next_state_1_1_map2389,
      I2 => BU2_U0_receiver_pcs_sync_state3_next_state_1_1_map2392,
      I3 => BU2_U0_receiver_pcs_sync_state3_next_state_1_1_map2395,
      O => BU2_U0_receiver_pcs_sync_state3_next_state(1, 1)
    );
  BU2_U0_receiver_pcs_sync_state3_next_state_1_1_10 : LUT3
    generic map(
      INIT => X"DC"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_code_comma_pipe(1),
      I1 => BU2_U0_receiver_pcs_sync_state3_mux0019(7),
      I2 => BU2_U0_receiver_pcs_sync_state3_mux0008_3_Q_34,
      O => BU2_U0_receiver_pcs_sync_state3_next_state_1_1_map2392
    );
  BU2_U0_receiver_pcs_sync_state3_next_state_1_1_4 : LUT4
    generic map(
      INIT => X"FFF8"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_code_comma_pipe(1),
      I1 => BU2_U0_receiver_pcs_sync_state3_mux0008_1_Q_36,
      I2 => BU2_U0_receiver_pcs_sync_state3_mux0008_13_Q_40,
      I3 => BU2_U0_receiver_pcs_sync_state3_mux0008_2_Q_35,
      O => BU2_U0_receiver_pcs_sync_state3_next_state_1_1_map2389
    );
  BU2_U0_receiver_pcs_sync_state0_next_state_1_3_11 : LUT4
    generic map(
      INIT => X"AAA8"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_code_valid_pipe(1),
      I1 => BU2_U0_receiver_pcs_sync_state0_mux0008_13_Q_37,
      I2 => BU2_U0_receiver_pcs_sync_state0_mux0008_14_Q,
      I3 => BU2_N5229,
      O => BU2_U0_receiver_pcs_sync_state0_next_state_1_3_map2379
    );
  BU2_U0_receiver_pcs_sync_state1_next_state_1_3_11 : LUT4
    generic map(
      INIT => X"AAA8"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_code_valid_pipe(1),
      I1 => BU2_U0_receiver_pcs_sync_state1_mux0008_13_Q_38,
      I2 => BU2_U0_receiver_pcs_sync_state1_mux0008_14_Q,
      I3 => BU2_N5228,
      O => BU2_U0_receiver_pcs_sync_state1_next_state_1_3_map2366
    );
  BU2_U0_receiver_pcs_sync_state2_next_state_1_3_11 : LUT4
    generic map(
      INIT => X"AAA8"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_code_valid_pipe(1),
      I1 => BU2_U0_receiver_pcs_sync_state2_mux0008_13_Q_39,
      I2 => BU2_U0_receiver_pcs_sync_state2_mux0008_14_Q,
      I3 => BU2_N5227,
      O => BU2_U0_receiver_pcs_sync_state2_next_state_1_3_map2353
    );
  BU2_U0_receiver_pcs_sync_state3_next_state_1_3_11 : LUT4
    generic map(
      INIT => X"AAA8"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_code_valid_pipe(1),
      I1 => BU2_U0_receiver_pcs_sync_state3_mux0008_13_Q_40,
      I2 => BU2_U0_receiver_pcs_sync_state3_mux0008_14_Q,
      I3 => BU2_N5226,
      O => BU2_U0_receiver_pcs_sync_state3_next_state_1_3_map2340
    );
  BU2_U0_receiver_pcs_sync_state0_mux0008_12_1 : LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state0_state_1_1_51,
      I1 => BU2_U0_receiver_pcs_sync_state0_N8,
      I2 => BU2_U0_receiver_pcs_sync_state0_state_1_0_52,
      I3 => BU2_N5239,
      O => BU2_U0_receiver_pcs_sync_state0_mux0008_12_Q
    );
  BU2_U0_receiver_pcs_sync_state1_mux0008_12_1 : LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state1_state_1_1_57,
      I1 => BU2_U0_receiver_pcs_sync_state1_N8,
      I2 => BU2_U0_receiver_pcs_sync_state1_state_1_0_58,
      I3 => BU2_N5238,
      O => BU2_U0_receiver_pcs_sync_state1_mux0008_12_Q
    );
  BU2_U0_receiver_pcs_sync_state2_mux0008_12_1 : LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state2_state_1_1_63,
      I1 => BU2_U0_receiver_pcs_sync_state2_N8,
      I2 => BU2_U0_receiver_pcs_sync_state2_state_1_0_64,
      I3 => BU2_N5237,
      O => BU2_U0_receiver_pcs_sync_state2_mux0008_12_Q
    );
  BU2_U0_receiver_pcs_sync_state3_mux0008_12_1 : LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => BU2_U0_receiver_pcs_sync_state3_state_1_1_69,
      I1 => BU2_U0_receiver_pcs_sync_state3_N8,
      I2 => BU2_U0_receiver_pcs_sync_state3_state_1_0_70,
      I3 => BU2_N5236,
      O => BU2_U0_receiver_pcs_sync_state3_mux0008_12_Q
    );
  BU2_U0_receiver_recoder_or002975 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_pipe(0),
      I1 => BU2_U0_receiver_recoder_or0029_map2333,
      O => BU2_U0_receiver_recoder_error_lane(4)
    );
  BU2_U0_receiver_recoder_or002964 : LUT4
    generic map(
      INIT => X"F0E0"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_or0029_map2327,
      I1 => BU2_U0_receiver_recoder_or0029_map2319,
      I2 => BU2_U0_receiver_recoder_or0029_map2332,
      I3 => BU2_U0_receiver_recoder_or0029_map2314,
      O => BU2_U0_receiver_recoder_or0029_map2333
    );
  BU2_U0_receiver_recoder_or002961 : LUT4
    generic map(
      INIT => X"0F0E"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_lane_terminate(3),
      I1 => BU2_U0_receiver_recoder_lane_terminate(2),
      I2 => BU2_U0_receiver_recoder_lane_terminate(0),
      I3 => BU2_U0_receiver_recoder_lane_terminate(1),
      O => BU2_U0_receiver_recoder_or0029_map2332
    );
  BU2_U0_receiver_recoder_or002916 : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(38),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(39),
      O => BU2_U0_receiver_recoder_or0029_map2319
    );
  BU2_U0_receiver_recoder_or00297 : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(32),
      I1 => BU2_U0_receiver_recoder_rxc_pipe(4),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(33),
      I3 => BU2_U0_receiver_recoder_code_error_pipe(4),
      O => BU2_U0_receiver_recoder_or0029_map2314
    );
  BU2_U0_receiver_recoder_or003258 : LUT4
    generic map(
      INIT => X"FEAA"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_pipe(3),
      I1 => BU2_U0_receiver_recoder_or0032_map2307,
      I2 => BU2_U0_receiver_recoder_or0032_map2300,
      I3 => BU2_U0_receiver_recoder_or0032_map2293,
      O => BU2_U0_receiver_recoder_error_lane(7)
    );
  BU2_U0_receiver_recoder_or00322 : LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_lane_terminate(4),
      I1 => BU2_U0_receiver_recoder_lane_terminate(5),
      I2 => BU2_U0_receiver_recoder_lane_terminate(6),
      O => BU2_U0_receiver_recoder_or0032_map2293
    );
  BU2_U0_receiver_recoder_or002554 : LUT4
    generic map(
      INIT => X"EEAE"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_delay(0),
      I1 => BU2_U0_receiver_recoder_or0025_map2289,
      I2 => BU2_U0_receiver_recoder_N16,
      I3 => BU2_U0_receiver_recoder_or0025_map2283,
      O => BU2_U0_receiver_recoder_error_lane(0)
    );
  BU2_U0_receiver_recoder_or002518 : LUT4
    generic map(
      INIT => X"FFD7"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(5),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(6),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(7),
      I3 => BU2_U0_receiver_recoder_code_error_pipe(0),
      O => BU2_U0_receiver_recoder_or0025_map2283
    );
  BU2_U0_receiver_recoder_or002831 : LUT4
    generic map(
      INIT => X"EEAE"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_delay(3),
      I1 => BU2_U0_receiver_recoder_or0028_map2266,
      I2 => BU2_U0_receiver_recoder_N37,
      I3 => BU2_U0_receiver_recoder_or0028_map2271,
      O => BU2_U0_receiver_recoder_error_lane(3)
    );
  BU2_U0_receiver_recoder_or002811 : LUT4
    generic map(
      INIT => X"FFBF"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_pipe(3),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(29),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(31),
      I3 => BU2_U0_receiver_recoder_rxd_pipe(30),
      O => BU2_U0_receiver_recoder_or0028_map2271
    );
  BU2_U0_receiver_recoder_or00282 : LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_lane_terminate(2),
      I1 => BU2_U0_receiver_recoder_lane_terminate(1),
      I2 => BU2_U0_receiver_recoder_lane_terminate(0),
      O => BU2_U0_receiver_recoder_or0028_map2266
    );
  BU2_U0_receiver_recoder_and00221 : LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(28),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(27),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(26),
      I3 => BU2_N5206,
      O => BU2_U0_receiver_recoder_N37
    );
  BU2_U0_receiver_recoder_or00211 : LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(4),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(3),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(2),
      I3 => BU2_N5205,
      O => BU2_U0_receiver_recoder_N16
    );
  BU2_U0_receiver_recoder_or00141 : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_or0017,
      I1 => NlwRenamedSig_OI_align_status,
      I2 => BU2_U0_usrclk_reset_104,
      I3 => BU2_U0_receiver_recoder_error_lane(0),
      O => BU2_U0_receiver_recoder_or0014
    );
  BU2_U0_transmitter_mux0075128 : LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => BU2_U0_transmitter_mux0075_map2234,
      I1 => BU2_U0_transmitter_mux0075_map2243,
      I2 => BU2_U0_transmitter_mux0075_map2253,
      I3 => BU2_U0_transmitter_mux0075_map2262,
      O => BU2_U0_transmitter_is_terminate(0)
    );
  BU2_U0_transmitter_mux007598 : LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(13),
      I1 => BU2_U0_transmitter_txd_pipe(14),
      I2 => BU2_U0_transmitter_txd_pipe(9),
      O => BU2_U0_transmitter_mux0075_map2260
    );
  BU2_U0_transmitter_mux007573 : LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(5),
      I1 => BU2_U0_transmitter_txd_pipe(6),
      I2 => BU2_U0_transmitter_txd_pipe(1),
      O => BU2_U0_transmitter_mux0075_map2251
    );
  BU2_U0_transmitter_mux007535 : LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(29),
      I1 => BU2_U0_transmitter_txd_pipe(30),
      I2 => BU2_U0_transmitter_txd_pipe(25),
      O => BU2_U0_transmitter_mux0075_map2241
    );
  BU2_U0_transmitter_mux007510 : LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(21),
      I1 => BU2_U0_transmitter_txd_pipe(22),
      I2 => BU2_U0_transmitter_txd_pipe(17),
      O => BU2_U0_transmitter_mux0075_map2232
    );
  BU2_U0_transmitter_mux00754 : LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(20),
      I1 => BU2_U0_transmitter_txd_pipe(23),
      I2 => BU2_U0_transmitter_txc_pipe(2),
      I3 => BU2_U0_transmitter_txd_pipe(16),
      O => BU2_U0_transmitter_mux0075_map2228
    );
  BU2_U0_transmitter_filter0_xor000120 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(3),
      I1 => BU2_U0_transmitter_txd_pipe(4),
      I2 => BU2_U0_transmitter_txd_pipe(5),
      I3 => BU2_U0_transmitter_txd_pipe(6),
      O => BU2_U0_transmitter_filter0_xor0001_map2223
    );
  BU2_U0_receiver_deskew_state_mux0044_0_269 : LUT4
    generic map(
      INIT => X"AAA8"
    )
    port map (
      I0 => BU2_U0_receiver_sync_status_97,
      I1 => BU2_U0_receiver_deskew_state_mux0044_0_map2177,
      I2 => BU2_U0_receiver_deskew_state_mux0044_0_map2210,
      I3 => BU2_U0_receiver_deskew_state_mux0044_0_map2162,
      O => BU2_U0_receiver_deskew_state_next_state(1, 0)
    );
  BU2_U0_receiver_deskew_state_mux0044_0_232 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_receiver_deskew_state_state_1_2_1_41,
      I1 => BU2_U0_receiver_deskew_state_deskew_error(0),
      O => BU2_U0_receiver_deskew_state_mux0044_0_map2208
    );
  BU2_U0_receiver_deskew_state_mux0044_0_139 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => BU2_U0_receiver_deskew_state_deskew_error(0),
      I1 => BU2_U0_receiver_deskew_state_state_1_1_44,
      O => BU2_U0_receiver_deskew_state_mux0044_0_map2179
    );
  BU2_U0_receiver_deskew_state_mux0044_0_69 : LUT4
    generic map(
      INIT => X"AAA8"
    )
    port map (
      I0 => BU2_U0_receiver_deskew_state_state_1_0_45,
      I1 => BU2_U0_receiver_deskew_state_mux0044_0_map2154,
      I2 => BU2_U0_receiver_deskew_state_mux0044_0_map2160,
      I3 => BU2_U0_receiver_deskew_state_mux0044_0_map2147,
      O => BU2_U0_receiver_deskew_state_mux0044_0_map2162
    );
  BU2_U0_receiver_deskew_state_mux0044_0_27 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => BU2_U0_receiver_deskew_state_deskew_error(0),
      I1 => BU2_U0_receiver_deskew_state_deskew_error(1),
      I2 => BU2_U0_receiver_deskew_state_got_align(0),
      I3 => BU2_U0_receiver_deskew_state_got_align(1),
      O => BU2_U0_receiver_deskew_state_mux0044_0_map2154
    );
  BU2_U0_transmitter_mux0076128 : LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => BU2_U0_transmitter_mux0076_map2111,
      I1 => BU2_U0_transmitter_mux0076_map2120,
      I2 => BU2_U0_transmitter_mux0076_map2130,
      I3 => BU2_U0_transmitter_mux0076_map2139,
      O => BU2_U0_transmitter_is_terminate(1)
    );
  BU2_U0_transmitter_mux007698 : LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(45),
      I1 => BU2_U0_transmitter_txd_pipe(46),
      I2 => BU2_U0_transmitter_txd_pipe(41),
      O => BU2_U0_transmitter_mux0076_map2137
    );
  BU2_U0_transmitter_mux007673 : LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(37),
      I1 => BU2_U0_transmitter_txd_pipe(38),
      I2 => BU2_U0_transmitter_txd_pipe(33),
      O => BU2_U0_transmitter_mux0076_map2128
    );
  BU2_U0_transmitter_mux007635 : LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(61),
      I1 => BU2_U0_transmitter_txd_pipe(62),
      I2 => BU2_U0_transmitter_txd_pipe(57),
      O => BU2_U0_transmitter_mux0076_map2118
    );
  BU2_U0_transmitter_mux007610 : LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(53),
      I1 => BU2_U0_transmitter_txd_pipe(54),
      I2 => BU2_U0_transmitter_txd_pipe(49),
      O => BU2_U0_transmitter_mux0076_map2109
    );
  BU2_U0_transmitter_mux00764 : LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(52),
      I1 => BU2_U0_transmitter_txd_pipe(55),
      I2 => BU2_U0_transmitter_txc_pipe(6),
      I3 => BU2_U0_transmitter_txd_pipe(48),
      O => BU2_U0_transmitter_mux0076_map2105
    );
  BU2_U0_transmitter_filter1_xor000120 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(11),
      I1 => BU2_U0_transmitter_txd_pipe(12),
      I2 => BU2_U0_transmitter_txd_pipe(13),
      I3 => BU2_U0_transmitter_txd_pipe(14),
      O => BU2_U0_transmitter_filter1_xor0001_map2100
    );
  BU2_U0_transmitter_filter2_xor000120 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(19),
      I1 => BU2_U0_transmitter_txd_pipe(20),
      I2 => BU2_U0_transmitter_txd_pipe(21),
      I3 => BU2_U0_transmitter_txd_pipe(22),
      O => BU2_U0_transmitter_filter2_xor0001_map2087
    );
  BU2_U0_transmitter_filter3_xor000120 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(27),
      I1 => BU2_U0_transmitter_txd_pipe(28),
      I2 => BU2_U0_transmitter_txd_pipe(29),
      I3 => BU2_U0_transmitter_txd_pipe(30),
      O => BU2_U0_transmitter_filter3_xor0001_map2074
    );
  BU2_U0_transmitter_filter4_xor000120 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(35),
      I1 => BU2_U0_transmitter_txd_pipe(36),
      I2 => BU2_U0_transmitter_txd_pipe(37),
      I3 => BU2_U0_transmitter_txd_pipe(38),
      O => BU2_U0_transmitter_filter4_xor0001_map2061
    );
  BU2_U0_transmitter_filter5_xor000120 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(43),
      I1 => BU2_U0_transmitter_txd_pipe(44),
      I2 => BU2_U0_transmitter_txd_pipe(45),
      I3 => BU2_U0_transmitter_txd_pipe(46),
      O => BU2_U0_transmitter_filter5_xor0001_map2048
    );
  BU2_U0_transmitter_filter6_xor000120 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(51),
      I1 => BU2_U0_transmitter_txd_pipe(52),
      I2 => BU2_U0_transmitter_txd_pipe(53),
      I3 => BU2_U0_transmitter_txd_pipe(54),
      O => BU2_U0_transmitter_filter6_xor0001_map2035
    );
  BU2_U0_transmitter_filter7_xor000120 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(59),
      I1 => BU2_U0_transmitter_txd_pipe(60),
      I2 => BU2_U0_transmitter_txd_pipe(61),
      I3 => BU2_U0_transmitter_txd_pipe(62),
      O => BU2_U0_transmitter_filter7_xor0001_map2022
    );
  BU2_U0_receiver_recoder_or0023 : LUT3
    generic map(
      INIT => X"20"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxc_pipe(2),
      I1 => BU2_N5196,
      I2 => BU2_U0_receiver_recoder_N17,
      O => BU2_U0_receiver_recoder_or0023_96
    );
  BU2_U0_receiver_recoder_or003121 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_lane_terminate(0),
      I1 => BU2_U0_receiver_recoder_lane_terminate(1),
      O => BU2_U0_receiver_recoder_N18
    );
  BU2_U0_receiver_deskew_state_mux0044_2_83 : LUT3
    generic map(
      INIT => X"A8"
    )
    port map (
      I0 => BU2_U0_receiver_sync_status_97,
      I1 => BU2_U0_receiver_deskew_state_mux0044_2_map1915,
      I2 => BU2_U0_receiver_deskew_state_mux0044_2_map1929,
      O => BU2_U0_receiver_deskew_state_next_state(1, 2)
    );
  BU2_U0_receiver_deskew_state_mux0044_2_42 : LUT3
    generic map(
      INIT => X"4C"
    )
    port map (
      I0 => BU2_U0_receiver_deskew_state_deskew_error(1),
      I1 => NlwRenamedSig_OI_align_status,
      I2 => BU2_U0_receiver_deskew_state_state_1_0_45,
      O => BU2_U0_receiver_deskew_state_mux0044_2_map1926
    );
  BU2_U0_receiver_deskew_state_mux0044_2_28 : LUT4
    generic map(
      INIT => X"AE08"
    )
    port map (
      I0 => BU2_U0_receiver_deskew_state_got_align(0),
      I1 => BU2_U0_receiver_deskew_state_got_align(1),
      I2 => BU2_U0_receiver_deskew_state_deskew_error(1),
      I3 => BU2_U0_receiver_deskew_state_state_1_0_45,
      O => BU2_U0_receiver_deskew_state_mux0044_2_map1921
    );
  BU2_U0_receiver_deskew_state_mux0044_2_13 : LUT4
    generic map(
      INIT => X"02AA"
    )
    port map (
      I0 => NlwRenamedSig_OI_align_status,
      I1 => BU2_U0_receiver_deskew_state_deskew_error(1),
      I2 => BU2_U0_receiver_deskew_state_state_1_0_45,
      I3 => BU2_U0_receiver_deskew_state_state_1_1_44,
      O => BU2_U0_receiver_deskew_state_mux0044_2_map1915
    );
  BU2_U0_transmitter_recoder_mux04001 : LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_N33,
      I1 => BU2_U0_transmitter_filter2_txd_out(1),
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(17),
      I3 => BU2_U0_transmitter_recoder_N44,
      O => BU2_U0_transmitter_recoder_mux0400
    );
  BU2_U0_transmitter_recoder_mux04351 : LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_N33,
      I1 => BU2_U0_transmitter_filter0_txd_out(1),
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(1),
      I3 => BU2_U0_transmitter_recoder_N44,
      O => BU2_U0_transmitter_recoder_mux0435
    );
  BU2_U0_transmitter_recoder_mux04061 : LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_N33,
      I1 => BU2_U0_transmitter_filter3_txd_out(1),
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(25),
      I3 => BU2_N5245,
      O => BU2_U0_transmitter_recoder_mux0406
    );
  BU2_U0_transmitter_recoder_mux04561 : LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_N5242,
      I1 => BU2_U0_transmitter_filter1_txd_out(1),
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(9),
      I3 => BU2_U0_transmitter_recoder_N44,
      O => BU2_U0_transmitter_recoder_mux0456
    );
  BU2_U0_transmitter_recoder_mux04451 : LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_N40,
      I1 => BU2_U0_transmitter_filter7_txd_out(1),
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(25),
      I3 => BU2_U0_transmitter_recoder_N41,
      O => BU2_U0_transmitter_recoder_mux0445
    );
  BU2_U0_transmitter_recoder_mux04361 : LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_N40,
      I1 => BU2_U0_transmitter_filter6_txd_out(1),
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(17),
      I3 => BU2_U0_transmitter_recoder_N41,
      O => BU2_U0_transmitter_recoder_mux0436
    );
  BU2_U0_transmitter_recoder_mux04191 : LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_N40,
      I1 => BU2_U0_transmitter_filter5_txd_out(1),
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(9),
      I3 => BU2_N5244,
      O => BU2_U0_transmitter_recoder_mux0419
    );
  BU2_U0_transmitter_recoder_mux04131 : LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_N5243,
      I1 => BU2_U0_transmitter_filter4_txd_out(1),
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(1),
      I3 => BU2_U0_transmitter_recoder_N41,
      O => BU2_U0_transmitter_recoder_mux0413
    );
  BU2_U0_receiver_recoder_mux04721 : LUT3
    generic map(
      INIT => X"0E"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(24),
      I1 => BU2_U0_receiver_recoder_or0020,
      I2 => BU2_U0_receiver_recoder_error_lane(3),
      O => BU2_U0_receiver_recoder_mux0472
    );
  BU2_U0_receiver_recoder_mux04961 : LUT3
    generic map(
      INIT => X"0E"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(24),
      I1 => BU2_U0_receiver_recoder_or0024,
      I2 => BU2_U0_receiver_recoder_error_lane(7),
      O => BU2_U0_receiver_recoder_mux0496
    );
  BU2_U0_transmitter_filter0_mux0007_5_1 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(2),
      I1 => BU2_U0_transmitter_txc_pipe(0),
      I2 => BU2_U0_transmitter_filter0_N01,
      O => BU2_U0_transmitter_filter0_mux0007(5)
    );
  BU2_U0_transmitter_filter1_mux0007_5_1 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(10),
      I1 => BU2_U0_transmitter_txc_pipe(1),
      I2 => BU2_U0_transmitter_filter1_N01,
      O => BU2_U0_transmitter_filter1_mux0007(5)
    );
  BU2_U0_transmitter_filter2_mux0007_5_1 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(18),
      I1 => BU2_U0_transmitter_txc_pipe(2),
      I2 => BU2_U0_transmitter_filter2_N01,
      O => BU2_U0_transmitter_filter2_mux0007(5)
    );
  BU2_U0_transmitter_filter3_mux0007_5_1 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(26),
      I1 => BU2_U0_transmitter_txc_pipe(3),
      I2 => BU2_U0_transmitter_filter3_N01,
      O => BU2_U0_transmitter_filter3_mux0007(5)
    );
  BU2_U0_transmitter_filter4_mux0007_5_1 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(34),
      I1 => BU2_U0_transmitter_txc_pipe(4),
      I2 => BU2_U0_transmitter_filter4_N01,
      O => BU2_U0_transmitter_filter4_mux0007(5)
    );
  BU2_U0_transmitter_filter5_mux0007_5_1 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(42),
      I1 => BU2_U0_transmitter_txc_pipe(5),
      I2 => BU2_U0_transmitter_filter5_N01,
      O => BU2_U0_transmitter_filter5_mux0007(5)
    );
  BU2_U0_transmitter_filter6_mux0007_5_1 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(50),
      I1 => BU2_U0_transmitter_txc_pipe(6),
      I2 => BU2_U0_transmitter_filter6_N01,
      O => BU2_U0_transmitter_filter6_mux0007(5)
    );
  BU2_U0_transmitter_filter7_mux0007_5_1 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(58),
      I1 => BU2_U0_transmitter_txc_pipe(7),
      I2 => BU2_U0_transmitter_filter7_N01,
      O => BU2_U0_transmitter_filter7_mux0007(5)
    );
  BU2_U0_receiver_recoder_mux05041 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(7),
      I1 => BU2_U0_receiver_recoder_or0017,
      O => BU2_U0_receiver_recoder_mux0504
    );
  BU2_U0_receiver_recoder_mux05031 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(6),
      I1 => BU2_U0_receiver_recoder_or0017,
      O => BU2_U0_receiver_recoder_mux0503
    );
  BU2_U0_receiver_recoder_mux05001 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(4),
      I1 => BU2_U0_receiver_recoder_or0017,
      O => BU2_U0_receiver_recoder_mux0500
    );
  BU2_U0_receiver_recoder_mux04981 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(3),
      I1 => BU2_U0_receiver_recoder_or0017,
      O => BU2_U0_receiver_recoder_mux0498
    );
  BU2_U0_receiver_recoder_mux04971 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(30),
      I1 => BU2_U0_receiver_recoder_or0024,
      O => BU2_U0_receiver_recoder_mux0497
    );
  BU2_U0_receiver_recoder_mux04951 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(29),
      I1 => BU2_U0_receiver_recoder_or0024,
      O => BU2_U0_receiver_recoder_mux0495
    );
  BU2_U0_receiver_recoder_mux04901 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(15),
      I1 => BU2_U0_receiver_recoder_or0022,
      O => BU2_U0_receiver_recoder_mux0490
    );
  BU2_U0_receiver_recoder_mux04881 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(14),
      I1 => BU2_U0_receiver_recoder_or0022,
      O => BU2_U0_receiver_recoder_mux0488
    );
  BU2_U0_receiver_recoder_mux04861 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(13),
      I1 => BU2_U0_receiver_recoder_or0022,
      O => BU2_U0_receiver_recoder_mux0486
    );
  BU2_U0_receiver_recoder_mux04851 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(7),
      I1 => BU2_U0_receiver_recoder_or0021,
      O => BU2_U0_receiver_recoder_mux0485
    );
  BU2_U0_receiver_recoder_mux04831 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(6),
      I1 => BU2_U0_receiver_recoder_or0021,
      O => BU2_U0_receiver_recoder_mux0483
    );
  BU2_U0_receiver_recoder_mux04811 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(5),
      I1 => BU2_U0_receiver_recoder_or0021,
      O => BU2_U0_receiver_recoder_mux0481
    );
  BU2_U0_receiver_recoder_mux04771 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(28),
      I1 => BU2_U0_receiver_recoder_or0020,
      O => BU2_U0_receiver_recoder_mux0477
    );
  BU2_U0_receiver_recoder_mux04761 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(27),
      I1 => BU2_U0_receiver_recoder_or0020,
      O => BU2_U0_receiver_recoder_mux0476
    );
  BU2_U0_receiver_recoder_mux04751 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(31),
      I1 => BU2_U0_receiver_recoder_or0020,
      O => BU2_U0_receiver_recoder_mux0475
    );
  BU2_U0_receiver_recoder_mux04741 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(30),
      I1 => BU2_U0_receiver_recoder_or0020,
      O => BU2_U0_receiver_recoder_mux0474
    );
  BU2_U0_receiver_recoder_mux04731 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(19),
      I1 => BU2_U0_receiver_recoder_or0019,
      O => BU2_U0_receiver_recoder_mux0473
    );
  BU2_U0_receiver_recoder_mux04711 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(23),
      I1 => BU2_U0_receiver_recoder_or0019,
      O => BU2_U0_receiver_recoder_mux0471
    );
  BU2_U0_receiver_recoder_mux04701 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(22),
      I1 => BU2_U0_receiver_recoder_or0019,
      O => BU2_U0_receiver_recoder_mux0470
    );
  BU2_U0_receiver_recoder_mux04681 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(15),
      I1 => BU2_U0_receiver_recoder_or0018,
      O => BU2_U0_receiver_recoder_mux0468
    );
  BU2_U0_receiver_recoder_mux04671 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(20),
      I1 => BU2_U0_receiver_recoder_or0019,
      O => BU2_U0_receiver_recoder_mux0467
    );
  BU2_U0_receiver_recoder_mux04661 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(14),
      I1 => BU2_U0_receiver_recoder_or0018,
      O => BU2_U0_receiver_recoder_mux0466
    );
  BU2_U0_receiver_recoder_mux04641 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(12),
      I1 => BU2_U0_receiver_recoder_or0018,
      O => BU2_U0_receiver_recoder_mux0464
    );
  BU2_U0_receiver_recoder_mux04631 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(11),
      I1 => BU2_U0_receiver_recoder_or0018,
      O => BU2_U0_receiver_recoder_mux0463
    );
  BU2_U0_transmitter_tqmsg_capture_1_or000060 : LUT4
    generic map(
      INIT => X"F8F0"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_or0000_map1696,
      I1 => BU2_U0_transmitter_tqmsg_capture_1_or0000_map1706,
      I2 => BU2_U0_transmitter_tqmsg_capture_1_and000043_42,
      I3 => BU2_U0_transmitter_tqmsg_capture_1_or0000_map1701,
      O => BU2_U0_transmitter_tqmsg_capture_1_or0000
    );
  BU2_U0_transmitter_tqmsg_capture_1_or000031 : LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      I0 => BU2_U0_transmitter_filter0_txd_out(6),
      I1 => BU2_U0_transmitter_filter0_txd_out(5),
      I2 => BU2_U0_transmitter_filter0_txd_out(4),
      I3 => BU2_U0_transmitter_filter0_txd_out(7),
      O => BU2_U0_transmitter_tqmsg_capture_1_or0000_map1706
    );
  BU2_U0_transmitter_tqmsg_capture_1_or000020 : LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      I0 => BU2_U0_transmitter_filter0_txd_out(1),
      I1 => BU2_U0_transmitter_filter0_txd_out(0),
      I2 => BU2_U0_transmitter_filter0_txd_out(3),
      I3 => BU2_U0_transmitter_filter0_txd_out(2),
      O => BU2_U0_transmitter_tqmsg_capture_1_or0000_map1701
    );
  BU2_U0_transmitter_tqmsg_capture_1_or000011 : LUT4
    generic map(
      INIT => X"0004"
    )
    port map (
      I0 => BU2_U0_transmitter_filter1_txc_out_80,
      I1 => BU2_U0_transmitter_filter0_txc_out_79,
      I2 => BU2_U0_transmitter_filter3_txc_out_82,
      I3 => BU2_U0_transmitter_filter2_txc_out_81,
      O => BU2_U0_transmitter_tqmsg_capture_1_or0000_map1696
    );
  BU2_U0_transmitter_tqmsg_capture_1_and000043 : LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => BU2_N5195,
      I1 => BU2_U0_transmitter_tqmsg_capture_1_and0000_map1683,
      I2 => BU2_U0_transmitter_tqmsg_capture_1_and0000_map1688,
      O => BU2_U0_transmitter_tqmsg_capture_1_and0000
    );
  BU2_U0_transmitter_tqmsg_capture_1_and000031 : LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      I0 => BU2_U0_transmitter_filter4_txd_out(6),
      I1 => BU2_U0_transmitter_filter4_txd_out(5),
      I2 => BU2_U0_transmitter_filter4_txd_out(4),
      I3 => BU2_U0_transmitter_filter4_txd_out(7),
      O => BU2_U0_transmitter_tqmsg_capture_1_and0000_map1688
    );
  BU2_U0_transmitter_tqmsg_capture_1_and000020 : LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      I0 => BU2_U0_transmitter_filter4_txd_out(1),
      I1 => BU2_U0_transmitter_filter4_txd_out(0),
      I2 => BU2_U0_transmitter_filter4_txd_out(3),
      I3 => BU2_U0_transmitter_filter4_txd_out(2),
      O => BU2_U0_transmitter_tqmsg_capture_1_and0000_map1683
    );
  BU2_U0_transmitter_align_not00011 : LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => BU2_N5194,
      I1 => BU2_U0_transmitter_align_count(4),
      I2 => BU2_U0_transmitter_align_not0002,
      O => BU2_U0_transmitter_align_not0001
    );
  BU2_U0_transmitter_align_mux0002_3_Q : LUT4
    generic map(
      INIT => X"BE14"
    )
    port map (
      I0 => BU2_U0_transmitter_align_not0002,
      I1 => BU2_U0_transmitter_align_count(3),
      I2 => BU2_N944,
      I3 => BU2_U0_transmitter_align_prbs(4),
      O => BU2_U0_transmitter_align_mux0002(3)
    );
  BU2_U0_transmitter_align_mux0002_3_SW0 : LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => BU2_U0_transmitter_align_count(2),
      I1 => BU2_U0_transmitter_align_count(1),
      O => BU2_N944
    );
  BU2_U0_transmitter_align_mux0002_2_1 : LUT4
    generic map(
      INIT => X"EB41"
    )
    port map (
      I0 => BU2_U0_transmitter_align_not0002,
      I1 => BU2_U0_transmitter_align_count(1),
      I2 => BU2_U0_transmitter_align_count(2),
      I3 => BU2_U0_transmitter_align_prbs(3),
      O => BU2_U0_transmitter_align_mux0002(2)
    );
  BU2_U0_receiver_cmp_eq00001 : LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => BU2_U0_receiver_sync_ok_int(1),
      I1 => BU2_U0_receiver_sync_ok_int(0),
      I2 => BU2_U0_receiver_sync_ok_int(3),
      I3 => BU2_U0_receiver_sync_ok_int(2),
      O => BU2_U0_receiver_sync_status_int
    );
  BU2_U0_transmitter_align_mux0002_4_1 : LUT3
    generic map(
      INIT => X"F9"
    )
    port map (
      I0 => BU2_U0_transmitter_align_count(4),
      I1 => BU2_U0_transmitter_align_N31,
      I2 => BU2_U0_transmitter_align_not0002,
      O => BU2_U0_transmitter_align_mux0002(4)
    );
  BU2_U0_transmitter_tqmsg_capture_1_mux0002_32_1 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_and0000,
      I1 => BU2_U0_transmitter_filter0_txd_out(0),
      I2 => BU2_U0_transmitter_filter4_txd_out(0),
      O => BU2_U0_transmitter_tqmsg_capture_1_mux0002(32)
    );
  BU2_U0_transmitter_tqmsg_capture_1_mux0002_33_1 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_and0000,
      I1 => BU2_U0_transmitter_filter0_txd_out(1),
      I2 => BU2_U0_transmitter_filter4_txd_out(1),
      O => BU2_U0_transmitter_tqmsg_capture_1_mux0002(33)
    );
  BU2_U0_transmitter_tqmsg_capture_1_mux0002_34_1 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_and0000,
      I1 => BU2_U0_transmitter_filter0_txd_out(2),
      I2 => BU2_U0_transmitter_filter4_txd_out(2),
      O => BU2_U0_transmitter_tqmsg_capture_1_mux0002(34)
    );
  BU2_U0_transmitter_tqmsg_capture_1_mux0002_35_1 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_and0000,
      I1 => BU2_U0_transmitter_filter0_txd_out(3),
      I2 => BU2_U0_transmitter_filter4_txd_out(3),
      O => BU2_U0_transmitter_tqmsg_capture_1_mux0002(35)
    );
  BU2_U0_transmitter_tqmsg_capture_1_mux0002_36_1 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_and0000,
      I1 => BU2_U0_transmitter_filter0_txd_out(4),
      I2 => BU2_U0_transmitter_filter4_txd_out(4),
      O => BU2_U0_transmitter_tqmsg_capture_1_mux0002(36)
    );
  BU2_U0_transmitter_tqmsg_capture_1_mux0002_37_1 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_and0000,
      I1 => BU2_U0_transmitter_filter0_txd_out(5),
      I2 => BU2_U0_transmitter_filter4_txd_out(5),
      O => BU2_U0_transmitter_tqmsg_capture_1_mux0002(37)
    );
  BU2_U0_transmitter_tqmsg_capture_1_mux0002_38_1 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_and0000,
      I1 => BU2_U0_transmitter_filter0_txd_out(6),
      I2 => BU2_U0_transmitter_filter4_txd_out(6),
      O => BU2_U0_transmitter_tqmsg_capture_1_mux0002(38)
    );
  BU2_U0_transmitter_tqmsg_capture_1_mux0002_39_1 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_and0000,
      I1 => BU2_U0_transmitter_filter0_txd_out(7),
      I2 => BU2_U0_transmitter_filter4_txd_out(7),
      O => BU2_U0_transmitter_tqmsg_capture_1_mux0002(39)
    );
  BU2_U0_transmitter_tqmsg_capture_1_mux0002_40_1 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_and0000,
      I1 => BU2_U0_transmitter_filter1_txd_out(0),
      I2 => BU2_U0_transmitter_filter5_txd_out(0),
      O => BU2_U0_transmitter_tqmsg_capture_1_mux0002(40)
    );
  BU2_U0_transmitter_tqmsg_capture_1_mux0002_41_1 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_and0000,
      I1 => BU2_U0_transmitter_filter1_txd_out(1),
      I2 => BU2_U0_transmitter_filter5_txd_out(1),
      O => BU2_U0_transmitter_tqmsg_capture_1_mux0002(41)
    );
  BU2_U0_transmitter_tqmsg_capture_1_mux0002_42_1 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_and0000,
      I1 => BU2_U0_transmitter_filter1_txd_out(2),
      I2 => BU2_U0_transmitter_filter5_txd_out(2),
      O => BU2_U0_transmitter_tqmsg_capture_1_mux0002(42)
    );
  BU2_U0_transmitter_tqmsg_capture_1_mux0002_43_1 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_and0000,
      I1 => BU2_U0_transmitter_filter1_txd_out(3),
      I2 => BU2_U0_transmitter_filter5_txd_out(3),
      O => BU2_U0_transmitter_tqmsg_capture_1_mux0002(43)
    );
  BU2_U0_transmitter_tqmsg_capture_1_mux0002_44_1 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_and0000,
      I1 => BU2_U0_transmitter_filter1_txd_out(4),
      I2 => BU2_U0_transmitter_filter5_txd_out(4),
      O => BU2_U0_transmitter_tqmsg_capture_1_mux0002(44)
    );
  BU2_U0_transmitter_tqmsg_capture_1_mux0002_45_1 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_and0000,
      I1 => BU2_U0_transmitter_filter1_txd_out(5),
      I2 => BU2_U0_transmitter_filter5_txd_out(5),
      O => BU2_U0_transmitter_tqmsg_capture_1_mux0002(45)
    );
  BU2_U0_transmitter_tqmsg_capture_1_mux0002_46_1 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_and0000,
      I1 => BU2_U0_transmitter_filter1_txd_out(6),
      I2 => BU2_U0_transmitter_filter5_txd_out(6),
      O => BU2_U0_transmitter_tqmsg_capture_1_mux0002(46)
    );
  BU2_U0_transmitter_tqmsg_capture_1_mux0002_47_1 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_and0000,
      I1 => BU2_U0_transmitter_filter1_txd_out(7),
      I2 => BU2_U0_transmitter_filter5_txd_out(7),
      O => BU2_U0_transmitter_tqmsg_capture_1_mux0002(47)
    );
  BU2_U0_transmitter_tqmsg_capture_1_mux0002_48_1 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_and0000,
      I1 => BU2_U0_transmitter_filter2_txd_out(0),
      I2 => BU2_U0_transmitter_filter6_txd_out(0),
      O => BU2_U0_transmitter_tqmsg_capture_1_mux0002(48)
    );
  BU2_U0_transmitter_tqmsg_capture_1_mux0002_49_1 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_and0000,
      I1 => BU2_U0_transmitter_filter2_txd_out(1),
      I2 => BU2_U0_transmitter_filter6_txd_out(1),
      O => BU2_U0_transmitter_tqmsg_capture_1_mux0002(49)
    );
  BU2_U0_transmitter_tqmsg_capture_1_mux0002_50_1 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_and0000,
      I1 => BU2_U0_transmitter_filter2_txd_out(2),
      I2 => BU2_U0_transmitter_filter6_txd_out(2),
      O => BU2_U0_transmitter_tqmsg_capture_1_mux0002(50)
    );
  BU2_U0_transmitter_tqmsg_capture_1_mux0002_51_1 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_and0000,
      I1 => BU2_U0_transmitter_filter2_txd_out(3),
      I2 => BU2_U0_transmitter_filter6_txd_out(3),
      O => BU2_U0_transmitter_tqmsg_capture_1_mux0002(51)
    );
  BU2_U0_transmitter_tqmsg_capture_1_mux0002_52_1 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_and0000,
      I1 => BU2_U0_transmitter_filter2_txd_out(4),
      I2 => BU2_U0_transmitter_filter6_txd_out(4),
      O => BU2_U0_transmitter_tqmsg_capture_1_mux0002(52)
    );
  BU2_U0_transmitter_tqmsg_capture_1_mux0002_53_1 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_and0000,
      I1 => BU2_U0_transmitter_filter2_txd_out(5),
      I2 => BU2_U0_transmitter_filter6_txd_out(5),
      O => BU2_U0_transmitter_tqmsg_capture_1_mux0002(53)
    );
  BU2_U0_transmitter_tqmsg_capture_1_mux0002_54_1 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_and0000,
      I1 => BU2_U0_transmitter_filter2_txd_out(6),
      I2 => BU2_U0_transmitter_filter6_txd_out(6),
      O => BU2_U0_transmitter_tqmsg_capture_1_mux0002(54)
    );
  BU2_U0_transmitter_tqmsg_capture_1_mux0002_55_1 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_and0000,
      I1 => BU2_U0_transmitter_filter2_txd_out(7),
      I2 => BU2_U0_transmitter_filter6_txd_out(7),
      O => BU2_U0_transmitter_tqmsg_capture_1_mux0002(55)
    );
  BU2_U0_transmitter_tqmsg_capture_1_mux0002_56_1 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_and0000,
      I1 => BU2_U0_transmitter_filter3_txd_out(0),
      I2 => BU2_U0_transmitter_filter7_txd_out(0),
      O => BU2_U0_transmitter_tqmsg_capture_1_mux0002(56)
    );
  BU2_U0_transmitter_tqmsg_capture_1_mux0002_57_1 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_and0000,
      I1 => BU2_U0_transmitter_filter3_txd_out(1),
      I2 => BU2_U0_transmitter_filter7_txd_out(1),
      O => BU2_U0_transmitter_tqmsg_capture_1_mux0002(57)
    );
  BU2_U0_transmitter_tqmsg_capture_1_mux0002_58_1 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_and0000,
      I1 => BU2_U0_transmitter_filter3_txd_out(2),
      I2 => BU2_U0_transmitter_filter7_txd_out(2),
      O => BU2_U0_transmitter_tqmsg_capture_1_mux0002(58)
    );
  BU2_U0_transmitter_tqmsg_capture_1_mux0002_59_1 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_and0000,
      I1 => BU2_U0_transmitter_filter3_txd_out(3),
      I2 => BU2_U0_transmitter_filter7_txd_out(3),
      O => BU2_U0_transmitter_tqmsg_capture_1_mux0002(59)
    );
  BU2_U0_transmitter_tqmsg_capture_1_mux0002_60_1 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_and0000,
      I1 => BU2_U0_transmitter_filter3_txd_out(4),
      I2 => BU2_U0_transmitter_filter7_txd_out(4),
      O => BU2_U0_transmitter_tqmsg_capture_1_mux0002(60)
    );
  BU2_U0_transmitter_tqmsg_capture_1_mux0002_61_1 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_and0000,
      I1 => BU2_U0_transmitter_filter3_txd_out(5),
      I2 => BU2_U0_transmitter_filter7_txd_out(5),
      O => BU2_U0_transmitter_tqmsg_capture_1_mux0002(61)
    );
  BU2_U0_transmitter_tqmsg_capture_1_mux0002_62_1 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_and0000,
      I1 => BU2_U0_transmitter_filter3_txd_out(6),
      I2 => BU2_U0_transmitter_filter7_txd_out(6),
      O => BU2_U0_transmitter_tqmsg_capture_1_mux0002(62)
    );
  BU2_U0_transmitter_tqmsg_capture_1_mux0002_63_1 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_and0000,
      I1 => BU2_U0_transmitter_filter3_txd_out(7),
      I2 => BU2_U0_transmitter_filter7_txd_out(7),
      O => BU2_U0_transmitter_tqmsg_capture_1_mux0002(63)
    );
  BU2_U0_transmitter_align_mux0002_1_1 : LUT3
    generic map(
      INIT => X"B1"
    )
    port map (
      I0 => BU2_U0_transmitter_align_not0002,
      I1 => BU2_U0_transmitter_align_count(1),
      I2 => BU2_U0_transmitter_align_prbs(2),
      O => BU2_U0_transmitter_align_mux0002(1)
    );
  BU2_U0_transmitter_align_mux0002_0_1 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_align_not0002,
      I1 => BU2_U0_transmitter_align_count(0),
      I2 => BU2_U0_transmitter_align_prbs(1),
      O => BU2_U0_transmitter_align_mux0002(0)
    );
  BU2_U0_receiver_recoder_mux04991 : LUT4
    generic map(
      INIT => X"AA2A"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(31),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(29),
      I2 => BU2_U0_receiver_recoder_N37,
      I3 => BU2_U0_receiver_recoder_rxd_pipe(30),
      O => BU2_U0_receiver_recoder_mux0499
    );
  BU2_U0_transmitter_recoder_or00001 : LUT4
    generic map(
      INIT => X"FF4C"
    )
    port map (
      I0 => configuration_vector_123(5),
      I1 => configuration_vector_123(4),
      I2 => configuration_vector_123(6),
      I3 => BU2_U0_usrclk_reset_104,
      O => BU2_U0_transmitter_recoder_or0000
    );
  BU2_U0_or00031 : LUT3
    generic map(
      INIT => X"FB"
    )
    port map (
      I0 => BU2_U0_usrclk_reset_104,
      I1 => configuration_vector_123(2),
      I2 => BU2_U0_last_value_102,
      O => BU2_U0_or0003
    );
  BU2_U0_or00001 : LUT3
    generic map(
      INIT => X"FB"
    )
    port map (
      I0 => BU2_U0_usrclk_reset_104,
      I1 => configuration_vector_123(3),
      I2 => BU2_U0_last_value0_101,
      O => BU2_U0_or0000
    );
  BU2_U0_receiver_pcs_sync_state0_or00001 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_usrclk_reset_104,
      I1 => mgt_rx_reset_121(0),
      O => BU2_U0_receiver_pcs_sync_state0_or0000
    );
  BU2_U0_receiver_pcs_sync_state1_or00001 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_usrclk_reset_104,
      I1 => mgt_rx_reset_121(1),
      O => BU2_U0_receiver_pcs_sync_state1_or0000
    );
  BU2_U0_receiver_pcs_sync_state2_or00001 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_usrclk_reset_104,
      I1 => mgt_rx_reset_121(2),
      O => BU2_U0_receiver_pcs_sync_state2_or0000
    );
  BU2_U0_receiver_pcs_sync_state3_or00001 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_usrclk_reset_104,
      I1 => mgt_rx_reset_121(3),
      O => BU2_U0_receiver_pcs_sync_state3_or0000
    );
  BU2_U0_or00011 : LUT2
    generic map(
      INIT => X"D"
    )
    port map (
      I0 => NlwRenamedSig_OI_align_status,
      I1 => BU2_U0_usrclk_reset_104,
      O => BU2_U0_or0001
    );
  BU2_U0_transmitter_state_machine_mux0010 : LUT4
    generic map(
      INIT => X"AAA2"
    )
    port map (
      I0 => BU2_N882,
      I1 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I2 => BU2_U0_transmitter_state_machine_state_1_0_43,
      I3 => BU2_U0_transmitter_state_machine_state_1_2_72,
      O => BU2_U0_transmitter_state_machine_mux0010_78
    );
  BU2_U0_transmitter_state_machine_mux0010_SW0 : LUT3
    generic map(
      INIT => X"FB"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_0_76,
      I1 => BU2_U0_transmitter_state_machine_state_0_1_75,
      I2 => BU2_U0_transmitter_state_machine_state_0_2_74,
      O => BU2_N882
    );
  BU2_U0_or0002 : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => mgt_rx_reset_121(3),
      I1 => NlwRenamedSig_OI_align_status,
      I2 => mgt_rx_reset_121(2),
      I3 => BU2_N880,
      O => BU2_U0_or0002_99
    );
  BU2_U0_or0002_SW0 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => mgt_rx_reset_121(1),
      I1 => mgt_rx_reset_121(0),
      O => BU2_N880
    );
  BU2_U0_transmitter_state_machine_not00031 : LUT4
    generic map(
      INIT => X"111F"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_0_43,
      I1 => BU2_U0_transmitter_state_machine_state_1_2_72,
      I2 => BU2_U0_transmitter_state_machine_state_0_0_76,
      I3 => BU2_U0_transmitter_state_machine_state_0_2_74,
      O => BU2_U0_transmitter_state_machine_not0003
    );
  BU2_U0_transmitter_state_machine_or00001 : LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_0_43,
      I1 => BU2_U0_transmitter_state_machine_state_1_1_73,
      I2 => BU2_U0_transmitter_state_machine_state_0_0_76,
      I3 => BU2_U0_transmitter_state_machine_state_0_1_75,
      O => BU2_U0_transmitter_clear_q_det
    );
  BU2_U0_transmitter_align_Mxor_xor0000_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_transmitter_align_prbs(7),
      I1 => BU2_U0_transmitter_align_prbs(6),
      O => BU2_U0_transmitter_align_xor0000
    );
  BU2_U0_transmitter_k_r_prbs_i_Mxor_xor0000_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_transmitter_k_r_prbs_i_prbs(6),
      I1 => BU2_U0_transmitter_k_r_prbs_i_prbs(5),
      O => BU2_U0_transmitter_k_r_prbs_i_xor0000
    );
  BU2_U0_transmitter_k_r_prbs_i_Mxor_xor0001_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_transmitter_k_r_prbs_i_prbs(7),
      I1 => BU2_U0_transmitter_k_r_prbs_i_prbs(6),
      O => BU2_U0_transmitter_k_r_prbs_i_xor0001
    );
  BU2_U0_transmitter_filter1_mux0007_3_1 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_transmitter_txc_pipe(1),
      I1 => BU2_U0_transmitter_txd_pipe(12),
      O => BU2_U0_transmitter_filter1_mux0007(3)
    );
  BU2_U0_transmitter_filter0_mux0007_3_1 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_transmitter_txc_pipe(0),
      I1 => BU2_U0_transmitter_txd_pipe(4),
      O => BU2_U0_transmitter_filter0_mux0007(3)
    );
  BU2_U0_transmitter_filter2_mux0007_3_1 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_transmitter_txc_pipe(2),
      I1 => BU2_U0_transmitter_txd_pipe(20),
      O => BU2_U0_transmitter_filter2_mux0007(3)
    );
  BU2_U0_transmitter_filter3_mux0007_3_1 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_transmitter_txc_pipe(3),
      I1 => BU2_U0_transmitter_txd_pipe(28),
      O => BU2_U0_transmitter_filter3_mux0007(3)
    );
  BU2_U0_transmitter_filter4_mux0007_3_1 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_transmitter_txc_pipe(4),
      I1 => BU2_U0_transmitter_txd_pipe(36),
      O => BU2_U0_transmitter_filter4_mux0007(3)
    );
  BU2_U0_transmitter_filter5_mux0007_3_1 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_transmitter_txc_pipe(5),
      I1 => BU2_U0_transmitter_txd_pipe(44),
      O => BU2_U0_transmitter_filter5_mux0007(3)
    );
  BU2_U0_transmitter_filter6_mux0007_3_1 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_transmitter_txc_pipe(6),
      I1 => BU2_U0_transmitter_txd_pipe(52),
      O => BU2_U0_transmitter_filter6_mux0007(3)
    );
  BU2_U0_transmitter_filter7_mux0007_3_1 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_transmitter_txc_pipe(7),
      I1 => BU2_U0_transmitter_txd_pipe(60),
      O => BU2_U0_transmitter_filter7_mux0007(3)
    );
  BU2_U0_receiver_or000798 : LUT4
    generic map(
      INIT => X"AF8F"
    )
    port map (
      I0 => mgt_rxcharisk_116(6),
      I1 => BU2_U0_receiver_or0007_map1652,
      I2 => mgt_codevalid_117(6),
      I3 => BU2_U0_receiver_or0007_map1669,
      O => BU2_U0_receiver_code_error(7)
    );
  BU2_U0_receiver_or000754 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_receiver_or0007_map1661,
      I1 => BU2_U0_receiver_or0007_map1668,
      O => BU2_U0_receiver_or0007_map1669
    );
  BU2_U0_receiver_or000753 : LUT4
    generic map(
      INIT => X"135F"
    )
    port map (
      I0 => mgt_rxdata_115(49),
      I1 => mgt_rxdata_115(51),
      I2 => mgt_rxdata_115(48),
      I3 => mgt_rxdata_115(50),
      O => BU2_U0_receiver_or0007_map1668
    );
  BU2_U0_receiver_or000736 : LUT4
    generic map(
      INIT => X"AF8F"
    )
    port map (
      I0 => BU2_U0_receiver_or0007_map1658,
      I1 => mgt_rxdata_115(49),
      I2 => mgt_rxdata_115(52),
      I3 => mgt_rxdata_115(48),
      O => BU2_U0_receiver_or0007_map1661
    );
  BU2_U0_receiver_or000725 : LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => mgt_rxdata_115(55),
      I1 => mgt_rxdata_115(54),
      I2 => mgt_rxdata_115(53),
      O => BU2_U0_receiver_or0007_map1658
    );
  BU2_U0_receiver_or000715 : LUT4
    generic map(
      INIT => X"9111"
    )
    port map (
      I0 => mgt_rxdata_115(51),
      I1 => mgt_rxdata_115(50),
      I2 => mgt_rxdata_115(49),
      I3 => mgt_rxdata_115(48),
      O => BU2_U0_receiver_or0007_map1652
    );
  BU2_U0_receiver_or000698 : LUT4
    generic map(
      INIT => X"AF8F"
    )
    port map (
      I0 => mgt_rxcharisk_116(4),
      I1 => BU2_U0_receiver_or0006_map1624,
      I2 => mgt_codevalid_117(4),
      I3 => BU2_U0_receiver_or0006_map1641,
      O => BU2_U0_receiver_code_error(6)
    );
  BU2_U0_receiver_or000654 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_receiver_or0006_map1633,
      I1 => BU2_U0_receiver_or0006_map1640,
      O => BU2_U0_receiver_or0006_map1641
    );
  BU2_U0_receiver_or000653 : LUT4
    generic map(
      INIT => X"135F"
    )
    port map (
      I0 => mgt_rxdata_115(33),
      I1 => mgt_rxdata_115(35),
      I2 => mgt_rxdata_115(32),
      I3 => mgt_rxdata_115(34),
      O => BU2_U0_receiver_or0006_map1640
    );
  BU2_U0_receiver_or000636 : LUT4
    generic map(
      INIT => X"AF8F"
    )
    port map (
      I0 => BU2_U0_receiver_or0006_map1630,
      I1 => mgt_rxdata_115(33),
      I2 => mgt_rxdata_115(36),
      I3 => mgt_rxdata_115(32),
      O => BU2_U0_receiver_or0006_map1633
    );
  BU2_U0_receiver_or000625 : LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => mgt_rxdata_115(39),
      I1 => mgt_rxdata_115(38),
      I2 => mgt_rxdata_115(37),
      O => BU2_U0_receiver_or0006_map1630
    );
  BU2_U0_receiver_or000615 : LUT4
    generic map(
      INIT => X"9111"
    )
    port map (
      I0 => mgt_rxdata_115(35),
      I1 => mgt_rxdata_115(34),
      I2 => mgt_rxdata_115(33),
      I3 => mgt_rxdata_115(32),
      O => BU2_U0_receiver_or0006_map1624
    );
  BU2_U0_receiver_or000598 : LUT4
    generic map(
      INIT => X"AF8F"
    )
    port map (
      I0 => mgt_rxcharisk_116(2),
      I1 => BU2_U0_receiver_or0005_map1596,
      I2 => mgt_codevalid_117(2),
      I3 => BU2_U0_receiver_or0005_map1613,
      O => BU2_U0_receiver_code_error(5)
    );
  BU2_U0_receiver_or000554 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_receiver_or0005_map1605,
      I1 => BU2_U0_receiver_or0005_map1612,
      O => BU2_U0_receiver_or0005_map1613
    );
  BU2_U0_receiver_or000553 : LUT4
    generic map(
      INIT => X"135F"
    )
    port map (
      I0 => mgt_rxdata_115(17),
      I1 => mgt_rxdata_115(19),
      I2 => mgt_rxdata_115(16),
      I3 => mgt_rxdata_115(18),
      O => BU2_U0_receiver_or0005_map1612
    );
  BU2_U0_receiver_or000536 : LUT4
    generic map(
      INIT => X"AF8F"
    )
    port map (
      I0 => BU2_U0_receiver_or0005_map1602,
      I1 => mgt_rxdata_115(17),
      I2 => mgt_rxdata_115(20),
      I3 => mgt_rxdata_115(16),
      O => BU2_U0_receiver_or0005_map1605
    );
  BU2_U0_receiver_or000525 : LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => mgt_rxdata_115(23),
      I1 => mgt_rxdata_115(22),
      I2 => mgt_rxdata_115(21),
      O => BU2_U0_receiver_or0005_map1602
    );
  BU2_U0_receiver_or000515 : LUT4
    generic map(
      INIT => X"9111"
    )
    port map (
      I0 => mgt_rxdata_115(19),
      I1 => mgt_rxdata_115(18),
      I2 => mgt_rxdata_115(17),
      I3 => mgt_rxdata_115(16),
      O => BU2_U0_receiver_or0005_map1596
    );
  BU2_U0_receiver_or000398 : LUT4
    generic map(
      INIT => X"AF8F"
    )
    port map (
      I0 => mgt_rxcharisk_116(7),
      I1 => BU2_U0_receiver_or0003_map1568,
      I2 => mgt_codevalid_117(7),
      I3 => BU2_U0_receiver_or0003_map1585,
      O => BU2_U0_receiver_code_error(3)
    );
  BU2_U0_receiver_or000354 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_receiver_or0003_map1577,
      I1 => BU2_U0_receiver_or0003_map1584,
      O => BU2_U0_receiver_or0003_map1585
    );
  BU2_U0_receiver_or000353 : LUT4
    generic map(
      INIT => X"135F"
    )
    port map (
      I0 => mgt_rxdata_115(57),
      I1 => mgt_rxdata_115(59),
      I2 => mgt_rxdata_115(56),
      I3 => mgt_rxdata_115(58),
      O => BU2_U0_receiver_or0003_map1584
    );
  BU2_U0_receiver_or000336 : LUT4
    generic map(
      INIT => X"AF8F"
    )
    port map (
      I0 => BU2_U0_receiver_or0003_map1574,
      I1 => mgt_rxdata_115(57),
      I2 => mgt_rxdata_115(60),
      I3 => mgt_rxdata_115(56),
      O => BU2_U0_receiver_or0003_map1577
    );
  BU2_U0_receiver_or000325 : LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => mgt_rxdata_115(63),
      I1 => mgt_rxdata_115(62),
      I2 => mgt_rxdata_115(61),
      O => BU2_U0_receiver_or0003_map1574
    );
  BU2_U0_receiver_or000315 : LUT4
    generic map(
      INIT => X"9111"
    )
    port map (
      I0 => mgt_rxdata_115(59),
      I1 => mgt_rxdata_115(58),
      I2 => mgt_rxdata_115(57),
      I3 => mgt_rxdata_115(56),
      O => BU2_U0_receiver_or0003_map1568
    );
  BU2_U0_receiver_or000498 : LUT4
    generic map(
      INIT => X"AF8F"
    )
    port map (
      I0 => mgt_rxcharisk_116(0),
      I1 => BU2_U0_receiver_or0004_map1540,
      I2 => mgt_codevalid_117(0),
      I3 => BU2_U0_receiver_or0004_map1557,
      O => BU2_U0_receiver_code_error(4)
    );
  BU2_U0_receiver_or000454 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_receiver_or0004_map1549,
      I1 => BU2_U0_receiver_or0004_map1556,
      O => BU2_U0_receiver_or0004_map1557
    );
  BU2_U0_receiver_or000453 : LUT4
    generic map(
      INIT => X"135F"
    )
    port map (
      I0 => mgt_rxdata_115(1),
      I1 => mgt_rxdata_115(3),
      I2 => mgt_rxdata_115(0),
      I3 => mgt_rxdata_115(2),
      O => BU2_U0_receiver_or0004_map1556
    );
  BU2_U0_receiver_or000436 : LUT4
    generic map(
      INIT => X"AF8F"
    )
    port map (
      I0 => BU2_U0_receiver_or0004_map1546,
      I1 => mgt_rxdata_115(1),
      I2 => mgt_rxdata_115(4),
      I3 => mgt_rxdata_115(0),
      O => BU2_U0_receiver_or0004_map1549
    );
  BU2_U0_receiver_or000425 : LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => mgt_rxdata_115(7),
      I1 => mgt_rxdata_115(6),
      I2 => mgt_rxdata_115(5),
      O => BU2_U0_receiver_or0004_map1546
    );
  BU2_U0_receiver_or000415 : LUT4
    generic map(
      INIT => X"9111"
    )
    port map (
      I0 => mgt_rxdata_115(3),
      I1 => mgt_rxdata_115(2),
      I2 => mgt_rxdata_115(1),
      I3 => mgt_rxdata_115(0),
      O => BU2_U0_receiver_or0004_map1540
    );
  BU2_U0_receiver_or000298 : LUT4
    generic map(
      INIT => X"AF8F"
    )
    port map (
      I0 => mgt_rxcharisk_116(5),
      I1 => BU2_U0_receiver_or0002_map1512,
      I2 => mgt_codevalid_117(5),
      I3 => BU2_U0_receiver_or0002_map1529,
      O => BU2_U0_receiver_code_error(2)
    );
  BU2_U0_receiver_or000254 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_receiver_or0002_map1521,
      I1 => BU2_U0_receiver_or0002_map1528,
      O => BU2_U0_receiver_or0002_map1529
    );
  BU2_U0_receiver_or000253 : LUT4
    generic map(
      INIT => X"135F"
    )
    port map (
      I0 => mgt_rxdata_115(41),
      I1 => mgt_rxdata_115(43),
      I2 => mgt_rxdata_115(40),
      I3 => mgt_rxdata_115(42),
      O => BU2_U0_receiver_or0002_map1528
    );
  BU2_U0_receiver_or000236 : LUT4
    generic map(
      INIT => X"AF8F"
    )
    port map (
      I0 => BU2_U0_receiver_or0002_map1518,
      I1 => mgt_rxdata_115(41),
      I2 => mgt_rxdata_115(44),
      I3 => mgt_rxdata_115(40),
      O => BU2_U0_receiver_or0002_map1521
    );
  BU2_U0_receiver_or000225 : LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => mgt_rxdata_115(47),
      I1 => mgt_rxdata_115(46),
      I2 => mgt_rxdata_115(45),
      O => BU2_U0_receiver_or0002_map1518
    );
  BU2_U0_receiver_or000215 : LUT4
    generic map(
      INIT => X"9111"
    )
    port map (
      I0 => mgt_rxdata_115(43),
      I1 => mgt_rxdata_115(42),
      I2 => mgt_rxdata_115(41),
      I3 => mgt_rxdata_115(40),
      O => BU2_U0_receiver_or0002_map1512
    );
  BU2_U0_receiver_or0001100 : LUT4
    generic map(
      INIT => X"AF8F"
    )
    port map (
      I0 => mgt_rxcharisk_116(3),
      I1 => BU2_U0_receiver_or0001_map1484,
      I2 => mgt_codevalid_117(3),
      I3 => BU2_U0_receiver_or0001_map1501,
      O => BU2_U0_receiver_code_error(1)
    );
  BU2_U0_receiver_or000156 : LUT3
    generic map(
      INIT => X"FB"
    )
    port map (
      I0 => BU2_U0_receiver_or0001_map1491,
      I1 => mgt_rxdata_115(28),
      I2 => BU2_U0_receiver_or0001_map1500,
      O => BU2_U0_receiver_or0001_map1501
    );
  BU2_U0_receiver_or000153 : LUT4
    generic map(
      INIT => X"135F"
    )
    port map (
      I0 => mgt_rxdata_115(25),
      I1 => mgt_rxdata_115(27),
      I2 => mgt_rxdata_115(24),
      I3 => mgt_rxdata_115(26),
      O => BU2_U0_receiver_or0001_map1500
    );
  BU2_U0_receiver_or000115 : LUT4
    generic map(
      INIT => X"9111"
    )
    port map (
      I0 => mgt_rxdata_115(27),
      I1 => mgt_rxdata_115(26),
      I2 => mgt_rxdata_115(25),
      I3 => mgt_rxdata_115(24),
      O => BU2_U0_receiver_or0001_map1484
    );
  BU2_U0_receiver_or0000100 : LUT4
    generic map(
      INIT => X"AF8F"
    )
    port map (
      I0 => mgt_rxcharisk_116(1),
      I1 => BU2_U0_receiver_or0000_map1456,
      I2 => mgt_codevalid_117(1),
      I3 => BU2_U0_receiver_or0000_map1473,
      O => BU2_U0_receiver_code_error(0)
    );
  BU2_U0_receiver_or000056 : LUT3
    generic map(
      INIT => X"FB"
    )
    port map (
      I0 => BU2_U0_receiver_or0000_map1463,
      I1 => mgt_rxdata_115(12),
      I2 => BU2_U0_receiver_or0000_map1472,
      O => BU2_U0_receiver_or0000_map1473
    );
  BU2_U0_receiver_or000053 : LUT4
    generic map(
      INIT => X"135F"
    )
    port map (
      I0 => mgt_rxdata_115(9),
      I1 => mgt_rxdata_115(11),
      I2 => mgt_rxdata_115(8),
      I3 => mgt_rxdata_115(10),
      O => BU2_U0_receiver_or0000_map1472
    );
  BU2_U0_receiver_or000015 : LUT4
    generic map(
      INIT => X"9111"
    )
    port map (
      I0 => mgt_rxdata_115(11),
      I1 => mgt_rxdata_115(10),
      I2 => mgt_rxdata_115(9),
      I3 => mgt_rxdata_115(8),
      O => BU2_U0_receiver_or0000_map1456
    );
  BU2_U0_receiver_deskew_state_mux00348 : LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_U0_receiver_deskew_state_cmp_eq0011,
      I1 => mgt_rxcharisk_116(7),
      I2 => BU2_U0_receiver_deskew_state_cmp_eq0010,
      I3 => mgt_rxcharisk_116(5),
      O => BU2_U0_receiver_deskew_state_mux0034_map1352
    );
  BU2_U0_receiver_deskew_state_mux00358 : LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_U0_receiver_deskew_state_cmp_eq0015,
      I1 => mgt_rxcharisk_116(6),
      I2 => BU2_U0_receiver_deskew_state_cmp_eq0014,
      I3 => mgt_rxcharisk_116(4),
      O => BU2_U0_receiver_deskew_state_mux0035_map1344
    );
  BU2_U0_receiver_deskew_state_cmp_eq001517 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => BU2_U0_receiver_deskew_state_cmp_eq0015_map1333,
      I1 => BU2_U0_receiver_deskew_state_cmp_eq0015_map1337,
      O => BU2_U0_receiver_deskew_state_cmp_eq0015
    );
  BU2_U0_receiver_deskew_state_cmp_eq001516 : LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => mgt_rxdata_115(52),
      I1 => mgt_rxdata_115(54),
      I2 => mgt_rxdata_115(53),
      I3 => mgt_rxdata_115(55),
      O => BU2_U0_receiver_deskew_state_cmp_eq0015_map1337
    );
  BU2_U0_receiver_deskew_state_cmp_eq00158 : LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      I0 => mgt_rxdata_115(49),
      I1 => mgt_rxdata_115(48),
      I2 => mgt_rxdata_115(51),
      I3 => mgt_rxdata_115(50),
      O => BU2_U0_receiver_deskew_state_cmp_eq0015_map1333
    );
  BU2_U0_receiver_deskew_state_cmp_eq001417 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => BU2_U0_receiver_deskew_state_cmp_eq0014_map1323,
      I1 => BU2_U0_receiver_deskew_state_cmp_eq0014_map1327,
      O => BU2_U0_receiver_deskew_state_cmp_eq0014
    );
  BU2_U0_receiver_deskew_state_cmp_eq001416 : LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => mgt_rxdata_115(36),
      I1 => mgt_rxdata_115(38),
      I2 => mgt_rxdata_115(37),
      I3 => mgt_rxdata_115(39),
      O => BU2_U0_receiver_deskew_state_cmp_eq0014_map1327
    );
  BU2_U0_receiver_deskew_state_cmp_eq00148 : LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      I0 => mgt_rxdata_115(33),
      I1 => mgt_rxdata_115(32),
      I2 => mgt_rxdata_115(35),
      I3 => mgt_rxdata_115(34),
      O => BU2_U0_receiver_deskew_state_cmp_eq0014_map1323
    );
  BU2_U0_receiver_deskew_state_cmp_eq001317 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => BU2_U0_receiver_deskew_state_cmp_eq0013_map1313,
      I1 => BU2_U0_receiver_deskew_state_cmp_eq0013_map1317,
      O => BU2_U0_receiver_deskew_state_cmp_eq0013
    );
  BU2_U0_receiver_deskew_state_cmp_eq001316 : LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => mgt_rxdata_115(20),
      I1 => mgt_rxdata_115(22),
      I2 => mgt_rxdata_115(21),
      I3 => mgt_rxdata_115(23),
      O => BU2_U0_receiver_deskew_state_cmp_eq0013_map1317
    );
  BU2_U0_receiver_deskew_state_cmp_eq00138 : LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      I0 => mgt_rxdata_115(17),
      I1 => mgt_rxdata_115(16),
      I2 => mgt_rxdata_115(19),
      I3 => mgt_rxdata_115(18),
      O => BU2_U0_receiver_deskew_state_cmp_eq0013_map1313
    );
  BU2_U0_receiver_deskew_state_cmp_eq001017 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => BU2_U0_receiver_deskew_state_cmp_eq0010_map1303,
      I1 => BU2_U0_receiver_deskew_state_cmp_eq0010_map1307,
      O => BU2_U0_receiver_deskew_state_cmp_eq0010
    );
  BU2_U0_receiver_deskew_state_cmp_eq001016 : LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => mgt_rxdata_115(44),
      I1 => mgt_rxdata_115(46),
      I2 => mgt_rxdata_115(45),
      I3 => mgt_rxdata_115(47),
      O => BU2_U0_receiver_deskew_state_cmp_eq0010_map1307
    );
  BU2_U0_receiver_deskew_state_cmp_eq00108 : LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      I0 => mgt_rxdata_115(41),
      I1 => mgt_rxdata_115(40),
      I2 => mgt_rxdata_115(43),
      I3 => mgt_rxdata_115(42),
      O => BU2_U0_receiver_deskew_state_cmp_eq0010_map1303
    );
  BU2_U0_receiver_deskew_state_cmp_eq001117 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => BU2_U0_receiver_deskew_state_cmp_eq0011_map1293,
      I1 => BU2_U0_receiver_deskew_state_cmp_eq0011_map1297,
      O => BU2_U0_receiver_deskew_state_cmp_eq0011
    );
  BU2_U0_receiver_deskew_state_cmp_eq001116 : LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => mgt_rxdata_115(60),
      I1 => mgt_rxdata_115(62),
      I2 => mgt_rxdata_115(61),
      I3 => mgt_rxdata_115(63),
      O => BU2_U0_receiver_deskew_state_cmp_eq0011_map1297
    );
  BU2_U0_receiver_deskew_state_cmp_eq00118 : LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      I0 => mgt_rxdata_115(57),
      I1 => mgt_rxdata_115(56),
      I2 => mgt_rxdata_115(59),
      I3 => mgt_rxdata_115(58),
      O => BU2_U0_receiver_deskew_state_cmp_eq0011_map1293
    );
  BU2_U0_receiver_deskew_state_cmp_eq000917 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => BU2_U0_receiver_deskew_state_cmp_eq0009_map1283,
      I1 => BU2_U0_receiver_deskew_state_cmp_eq0009_map1287,
      O => BU2_U0_receiver_deskew_state_cmp_eq0009
    );
  BU2_U0_receiver_deskew_state_cmp_eq000916 : LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => mgt_rxdata_115(28),
      I1 => mgt_rxdata_115(30),
      I2 => mgt_rxdata_115(29),
      I3 => mgt_rxdata_115(31),
      O => BU2_U0_receiver_deskew_state_cmp_eq0009_map1287
    );
  BU2_U0_receiver_deskew_state_cmp_eq00098 : LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      I0 => mgt_rxdata_115(25),
      I1 => mgt_rxdata_115(24),
      I2 => mgt_rxdata_115(27),
      I3 => mgt_rxdata_115(26),
      O => BU2_U0_receiver_deskew_state_cmp_eq0009_map1283
    );
  BU2_U0_receiver_deskew_state_and0000 : LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => BU2_U0_receiver_deskew_state_cmp_eq0011,
      I1 => BU2_U0_receiver_deskew_state_cmp_eq0010,
      I2 => BU2_U0_receiver_deskew_state_cmp_eq0009,
      I3 => BU2_N37,
      O => BU2_U0_receiver_deskew_state_and0000_47
    );
  BU2_U0_receiver_deskew_state_and0000_SW0 : LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => BU2_N379,
      I1 => mgt_rxcharisk_116(7),
      I2 => mgt_rxcharisk_116(5),
      I3 => mgt_rxcharisk_116(3),
      O => BU2_N37
    );
  BU2_U0_receiver_deskew_state_and0001 : LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => BU2_U0_receiver_deskew_state_cmp_eq0015,
      I1 => BU2_U0_receiver_deskew_state_cmp_eq0014,
      I2 => BU2_U0_receiver_deskew_state_cmp_eq0013,
      I3 => BU2_N35,
      O => BU2_U0_receiver_deskew_state_and0001_46
    );
  BU2_U0_receiver_deskew_state_and0001_SW0 : LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => BU2_N355,
      I1 => mgt_rxcharisk_116(6),
      I2 => mgt_rxcharisk_116(4),
      I3 => mgt_rxcharisk_116(2),
      O => BU2_N35
    );
  BU2_U0_transmitter_idle_detect_i0_cmp_eq00081 : LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => xgmii_txc_114(1),
      I1 => xgmii_txc_114(0),
      I2 => xgmii_txc_114(3),
      I3 => xgmii_txc_114(2),
      O => BU2_U0_transmitter_idle_detect_i0_comp(8)
    );
  BU2_U0_transmitter_idle_detect_i0_cmp_eq00071 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => xgmii_txd_113(29),
      I1 => xgmii_txd_113(28),
      I2 => xgmii_txd_113(31),
      I3 => xgmii_txd_113(30),
      O => BU2_U0_transmitter_idle_detect_i0_comp(7)
    );
  BU2_U0_transmitter_idle_detect_i0_cmp_eq00061 : LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => xgmii_txd_113(26),
      I1 => xgmii_txd_113(24),
      I2 => xgmii_txd_113(25),
      I3 => xgmii_txd_113(27),
      O => BU2_U0_transmitter_idle_detect_i0_comp(6)
    );
  BU2_U0_transmitter_idle_detect_i0_cmp_eq00051 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => xgmii_txd_113(21),
      I1 => xgmii_txd_113(20),
      I2 => xgmii_txd_113(23),
      I3 => xgmii_txd_113(22),
      O => BU2_U0_transmitter_idle_detect_i0_comp(5)
    );
  BU2_U0_transmitter_idle_detect_i0_cmp_eq00041 : LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => xgmii_txd_113(18),
      I1 => xgmii_txd_113(16),
      I2 => xgmii_txd_113(17),
      I3 => xgmii_txd_113(19),
      O => BU2_U0_transmitter_idle_detect_i0_comp(4)
    );
  BU2_U0_transmitter_idle_detect_i0_cmp_eq00031 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => xgmii_txd_113(13),
      I1 => xgmii_txd_113(12),
      I2 => xgmii_txd_113(15),
      I3 => xgmii_txd_113(14),
      O => BU2_U0_transmitter_idle_detect_i0_comp(3)
    );
  BU2_U0_transmitter_idle_detect_i0_cmp_eq00021 : LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => xgmii_txd_113(10),
      I1 => xgmii_txd_113(8),
      I2 => xgmii_txd_113(9),
      I3 => xgmii_txd_113(11),
      O => BU2_U0_transmitter_idle_detect_i0_comp(2)
    );
  BU2_U0_transmitter_idle_detect_i0_cmp_eq00011 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => xgmii_txd_113(5),
      I1 => xgmii_txd_113(4),
      I2 => xgmii_txd_113(7),
      I3 => xgmii_txd_113(6),
      O => BU2_U0_transmitter_idle_detect_i0_comp(1)
    );
  BU2_U0_transmitter_idle_detect_i0_cmp_eq00001 : LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => xgmii_txd_113(2),
      I1 => xgmii_txd_113(0),
      I2 => xgmii_txd_113(1),
      I3 => xgmii_txd_113(3),
      O => BU2_U0_transmitter_idle_detect_i0_comp(0)
    );
  BU2_U0_transmitter_idle_detect_i1_cmp_eq00081 : LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => xgmii_txc_114(5),
      I1 => xgmii_txc_114(4),
      I2 => xgmii_txc_114(7),
      I3 => xgmii_txc_114(6),
      O => BU2_U0_transmitter_idle_detect_i1_comp(8)
    );
  BU2_U0_transmitter_idle_detect_i1_cmp_eq00071 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => xgmii_txd_113(61),
      I1 => xgmii_txd_113(60),
      I2 => xgmii_txd_113(63),
      I3 => xgmii_txd_113(62),
      O => BU2_U0_transmitter_idle_detect_i1_comp(7)
    );
  BU2_U0_transmitter_idle_detect_i1_cmp_eq00061 : LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => xgmii_txd_113(58),
      I1 => xgmii_txd_113(56),
      I2 => xgmii_txd_113(57),
      I3 => xgmii_txd_113(59),
      O => BU2_U0_transmitter_idle_detect_i1_comp(6)
    );
  BU2_U0_transmitter_idle_detect_i1_cmp_eq00051 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => xgmii_txd_113(53),
      I1 => xgmii_txd_113(52),
      I2 => xgmii_txd_113(55),
      I3 => xgmii_txd_113(54),
      O => BU2_U0_transmitter_idle_detect_i1_comp(5)
    );
  BU2_U0_transmitter_idle_detect_i1_cmp_eq00041 : LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => xgmii_txd_113(50),
      I1 => xgmii_txd_113(48),
      I2 => xgmii_txd_113(49),
      I3 => xgmii_txd_113(51),
      O => BU2_U0_transmitter_idle_detect_i1_comp(4)
    );
  BU2_U0_transmitter_idle_detect_i1_cmp_eq00021 : LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => xgmii_txd_113(42),
      I1 => xgmii_txd_113(40),
      I2 => xgmii_txd_113(41),
      I3 => xgmii_txd_113(43),
      O => BU2_U0_transmitter_idle_detect_i1_comp(2)
    );
  BU2_U0_transmitter_idle_detect_i1_cmp_eq00031 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => xgmii_txd_113(45),
      I1 => xgmii_txd_113(44),
      I2 => xgmii_txd_113(47),
      I3 => xgmii_txd_113(46),
      O => BU2_U0_transmitter_idle_detect_i1_comp(3)
    );
  BU2_U0_transmitter_idle_detect_i1_cmp_eq00011 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => xgmii_txd_113(37),
      I1 => xgmii_txd_113(36),
      I2 => xgmii_txd_113(39),
      I3 => xgmii_txd_113(38),
      O => BU2_U0_transmitter_idle_detect_i1_comp(1)
    );
  BU2_U0_transmitter_idle_detect_i1_cmp_eq00001 : LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => xgmii_txd_113(34),
      I1 => xgmii_txd_113(32),
      I2 => xgmii_txd_113(33),
      I3 => xgmii_txd_113(35),
      O => BU2_U0_transmitter_idle_detect_i1_comp(0)
    );
  BU2_U0_receiver_deskew_state_and00021 : LUT4
    generic map(
      INIT => X"0004"
    )
    port map (
      I0 => BU2_U0_receiver_deskew_state_state_1_0_45,
      I1 => BU2_U0_receiver_sync_status_97,
      I2 => NlwRenamedSig_OI_align_status,
      I3 => BU2_U0_receiver_deskew_state_state_1_1_44,
      O => mgt_enchansync
    );
  BU2_U0_transmitter_seq_detect_i0_cmp_eq00021 : LUT4
    generic map(
      INIT => X"0004"
    )
    port map (
      I0 => xgmii_txc_114(1),
      I1 => xgmii_txc_114(0),
      I2 => xgmii_txc_114(3),
      I3 => xgmii_txc_114(2),
      O => BU2_U0_transmitter_seq_detect_i0_comp(2)
    );
  BU2_U0_transmitter_seq_detect_i0_cmp_eq00011 : LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      I0 => xgmii_txd_113(5),
      I1 => xgmii_txd_113(6),
      I2 => xgmii_txd_113(7),
      I3 => xgmii_txd_113(4),
      O => BU2_U0_transmitter_seq_detect_i0_comp(1)
    );
  BU2_U0_transmitter_seq_detect_i0_cmp_eq00001 : LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      I0 => xgmii_txd_113(1),
      I1 => xgmii_txd_113(0),
      I2 => xgmii_txd_113(3),
      I3 => xgmii_txd_113(2),
      O => BU2_U0_transmitter_seq_detect_i0_comp(0)
    );
  BU2_U0_transmitter_seq_detect_i1_cmp_eq00021 : LUT4
    generic map(
      INIT => X"0004"
    )
    port map (
      I0 => xgmii_txc_114(5),
      I1 => xgmii_txc_114(4),
      I2 => xgmii_txc_114(7),
      I3 => xgmii_txc_114(6),
      O => BU2_U0_transmitter_seq_detect_i1_comp(2)
    );
  BU2_U0_transmitter_seq_detect_i1_cmp_eq00011 : LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      I0 => xgmii_txd_113(37),
      I1 => xgmii_txd_113(38),
      I2 => xgmii_txd_113(39),
      I3 => xgmii_txd_113(36),
      O => BU2_U0_transmitter_seq_detect_i1_comp(1)
    );
  BU2_U0_transmitter_seq_detect_i1_cmp_eq00001 : LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      I0 => xgmii_txd_113(33),
      I1 => xgmii_txd_113(32),
      I2 => xgmii_txd_113(35),
      I3 => xgmii_txd_113(34),
      O => BU2_U0_transmitter_seq_detect_i1_comp(0)
    );
  BU2_U0_not00001 : LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => mgt_tx_reset_120(3),
      I1 => mgt_tx_reset_120(2),
      I2 => mgt_tx_reset_120(1),
      I3 => mgt_tx_reset_120(0),
      O => BU2_U0_not0000
    );
  BU2_U0_transmitter_recoder_xor00031 : LUT3
    generic map(
      INIT => X"4C"
    )
    port map (
      I0 => configuration_vector_123(5),
      I1 => configuration_vector_123(4),
      I2 => configuration_vector_123(6),
      O => BU2_U0_transmitter_recoder_xor0003
    );
  BU2_U0_transmitter_recoder_mux042821 : LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => configuration_vector_123(4),
      I1 => configuration_vector_123(5),
      I2 => configuration_vector_123(6),
      O => BU2_U0_transmitter_recoder_N19
    );
  BU2_U0_transmitter_idle_detect_i0_muxcy_i8 : MUXCY_L
    port map (
      CI => BU2_U0_transmitter_idle_detect_i0_muxcyo(7),
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_idle_detect_i0_comp(8),
      LO => BU2_U0_transmitter_tx_is_idle_comb(0)
    );
  BU2_U0_transmitter_idle_detect_i0_muxcy_i7 : MUXCY_L
    port map (
      CI => BU2_U0_transmitter_idle_detect_i0_muxcyo(6),
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_idle_detect_i0_comp(7),
      LO => BU2_U0_transmitter_idle_detect_i0_muxcyo(7)
    );
  BU2_U0_transmitter_idle_detect_i0_muxcy_i6 : MUXCY_L
    port map (
      CI => BU2_U0_transmitter_idle_detect_i0_muxcyo(5),
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_idle_detect_i0_comp(6),
      LO => BU2_U0_transmitter_idle_detect_i0_muxcyo(6)
    );
  BU2_U0_transmitter_idle_detect_i0_muxcy_i5 : MUXCY_L
    port map (
      CI => BU2_U0_transmitter_idle_detect_i0_muxcyo(4),
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_idle_detect_i0_comp(5),
      LO => BU2_U0_transmitter_idle_detect_i0_muxcyo(5)
    );
  BU2_U0_transmitter_idle_detect_i0_muxcy_i4 : MUXCY_L
    port map (
      CI => BU2_U0_transmitter_idle_detect_i0_muxcyo(3),
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_idle_detect_i0_comp(4),
      LO => BU2_U0_transmitter_idle_detect_i0_muxcyo(4)
    );
  BU2_U0_transmitter_idle_detect_i0_muxcy_i3 : MUXCY_L
    port map (
      CI => BU2_U0_transmitter_idle_detect_i0_muxcyo(2),
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_idle_detect_i0_comp(3),
      LO => BU2_U0_transmitter_idle_detect_i0_muxcyo(3)
    );
  BU2_U0_transmitter_idle_detect_i0_muxcy_i2 : MUXCY_L
    port map (
      CI => BU2_U0_transmitter_idle_detect_i0_muxcyo(1),
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_idle_detect_i0_comp(2),
      LO => BU2_U0_transmitter_idle_detect_i0_muxcyo(2)
    );
  BU2_U0_transmitter_idle_detect_i0_muxcy_i1 : MUXCY_L
    port map (
      CI => BU2_U0_transmitter_idle_detect_i0_muxcyo(0),
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_idle_detect_i0_comp(1),
      LO => BU2_U0_transmitter_idle_detect_i0_muxcyo(1)
    );
  BU2_U0_transmitter_idle_detect_i0_muxcy_i0 : MUXCY_L
    port map (
      CI => BU2_N1,
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_idle_detect_i0_comp(0),
      LO => BU2_U0_transmitter_idle_detect_i0_muxcyo(0)
    );
  BU2_U0_transmitter_idle_detect_i1_muxcy_i8 : MUXCY_L
    port map (
      CI => BU2_U0_transmitter_idle_detect_i1_muxcyo(7),
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_idle_detect_i1_comp(8),
      LO => BU2_U0_transmitter_tx_is_idle_comb(1)
    );
  BU2_U0_transmitter_idle_detect_i1_muxcy_i7 : MUXCY_L
    port map (
      CI => BU2_U0_transmitter_idle_detect_i1_muxcyo(6),
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_idle_detect_i1_comp(7),
      LO => BU2_U0_transmitter_idle_detect_i1_muxcyo(7)
    );
  BU2_U0_transmitter_idle_detect_i1_muxcy_i6 : MUXCY_L
    port map (
      CI => BU2_U0_transmitter_idle_detect_i1_muxcyo(5),
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_idle_detect_i1_comp(6),
      LO => BU2_U0_transmitter_idle_detect_i1_muxcyo(6)
    );
  BU2_U0_transmitter_idle_detect_i1_muxcy_i5 : MUXCY_L
    port map (
      CI => BU2_U0_transmitter_idle_detect_i1_muxcyo(4),
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_idle_detect_i1_comp(5),
      LO => BU2_U0_transmitter_idle_detect_i1_muxcyo(5)
    );
  BU2_U0_transmitter_idle_detect_i1_muxcy_i4 : MUXCY_L
    port map (
      CI => BU2_U0_transmitter_idle_detect_i1_muxcyo(3),
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_idle_detect_i1_comp(4),
      LO => BU2_U0_transmitter_idle_detect_i1_muxcyo(4)
    );
  BU2_U0_transmitter_idle_detect_i1_muxcy_i3 : MUXCY_L
    port map (
      CI => BU2_U0_transmitter_idle_detect_i1_muxcyo(2),
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_idle_detect_i1_comp(3),
      LO => BU2_U0_transmitter_idle_detect_i1_muxcyo(3)
    );
  BU2_U0_transmitter_idle_detect_i1_muxcy_i2 : MUXCY_L
    port map (
      CI => BU2_U0_transmitter_idle_detect_i1_muxcyo(1),
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_idle_detect_i1_comp(2),
      LO => BU2_U0_transmitter_idle_detect_i1_muxcyo(2)
    );
  BU2_U0_transmitter_idle_detect_i1_muxcy_i1 : MUXCY_L
    port map (
      CI => BU2_U0_transmitter_idle_detect_i1_muxcyo(0),
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_idle_detect_i1_comp(1),
      LO => BU2_U0_transmitter_idle_detect_i1_muxcyo(1)
    );
  BU2_U0_transmitter_idle_detect_i1_muxcy_i0 : MUXCY_L
    port map (
      CI => BU2_N1,
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_idle_detect_i1_comp(0),
      LO => BU2_U0_transmitter_idle_detect_i1_muxcyo(0)
    );
  BU2_U0_receiver_deskew_state_state_1_2 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_receiver_deskew_state_next_state(1, 2),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => NlwRenamedSig_OI_align_status
    );
  BU2_U0_receiver_deskew_state_state_1_1 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_receiver_deskew_state_next_state(1, 1),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_deskew_state_state_1_1_44
    );
  BU2_U0_receiver_deskew_state_state_1_0 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_receiver_deskew_state_next_state(1, 0),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_deskew_state_state_1_0_45
    );
  BU2_U0_receiver_deskew_state_deskew_error_1 : FDR
    port map (
      D => BU2_U0_receiver_deskew_state_mux0035,
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_deskew_state_deskew_error(1)
    );
  BU2_U0_receiver_deskew_state_got_align_1 : FDR
    port map (
      D => BU2_U0_receiver_deskew_state_and0001_46,
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_deskew_state_got_align(1)
    );
  BU2_U0_receiver_deskew_state_got_align_0 : FDR
    port map (
      D => BU2_U0_receiver_deskew_state_and0000_47,
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_deskew_state_got_align(0)
    );
  BU2_U0_receiver_deskew_state_deskew_error_0 : FDR
    port map (
      D => BU2_U0_receiver_deskew_state_mux0034,
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_deskew_state_deskew_error(0)
    );
  BU2_U0_receiver_pcs_sync_state0_state_1_4 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_receiver_pcs_sync_state0_next_state(1, 4),
      R => BU2_U0_receiver_pcs_sync_state0_or0000,
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state0_state_1_4_48
    );
  BU2_U0_receiver_pcs_sync_state0_state_1_3 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_receiver_pcs_sync_state0_next_state(1, 3),
      R => BU2_U0_receiver_pcs_sync_state0_or0000,
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state0_state_1_3_49
    );
  BU2_U0_receiver_pcs_sync_state0_state_1_2 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_receiver_pcs_sync_state0_next_state(1, 2),
      R => BU2_U0_receiver_pcs_sync_state0_or0000,
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state0_state_1_2_50
    );
  BU2_U0_receiver_pcs_sync_state0_state_1_1 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_receiver_pcs_sync_state0_next_state(1, 1),
      R => BU2_U0_receiver_pcs_sync_state0_or0000,
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state0_state_1_1_51
    );
  BU2_U0_receiver_pcs_sync_state0_state_1_0 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_receiver_pcs_sync_state0_next_state(1, 0),
      R => BU2_U0_receiver_pcs_sync_state0_or0000,
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state0_state_1_0_52
    );
  BU2_U0_receiver_pcs_sync_state0_signal_detect_last : FD
    port map (
      D => BU2_U0_signal_detect_int(0),
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state0_signal_detect_last_53
    );
  BU2_U0_receiver_pcs_sync_state0_code_valid_pipe_1 : FDR
    port map (
      D => mgt_codevalid_117(0),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state0_code_valid_pipe(1)
    );
  BU2_U0_receiver_pcs_sync_state0_code_valid_pipe_0 : FDR
    port map (
      D => mgt_codevalid_117(1),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state0_code_valid_pipe(0)
    );
  BU2_U0_receiver_pcs_sync_state0_code_comma_pipe_1 : FDR
    port map (
      D => mgt_codecomma_118(0),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state0_code_comma_pipe(1)
    );
  BU2_U0_receiver_pcs_sync_state0_code_comma_pipe_0 : FDR
    port map (
      D => mgt_codecomma_118(1),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state0_code_comma_pipe(0)
    );
  BU2_U0_receiver_pcs_sync_state1_state_1_4 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_receiver_pcs_sync_state1_next_state(1, 4),
      R => BU2_U0_receiver_pcs_sync_state1_or0000,
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state1_state_1_4_54
    );
  BU2_U0_receiver_pcs_sync_state1_state_1_3 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_receiver_pcs_sync_state1_next_state(1, 3),
      R => BU2_U0_receiver_pcs_sync_state1_or0000,
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state1_state_1_3_55
    );
  BU2_U0_receiver_pcs_sync_state1_state_1_2 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_receiver_pcs_sync_state1_next_state(1, 2),
      R => BU2_U0_receiver_pcs_sync_state1_or0000,
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state1_state_1_2_56
    );
  BU2_U0_receiver_pcs_sync_state1_state_1_1 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_receiver_pcs_sync_state1_next_state(1, 1),
      R => BU2_U0_receiver_pcs_sync_state1_or0000,
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state1_state_1_1_57
    );
  BU2_U0_receiver_pcs_sync_state1_state_1_0 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_receiver_pcs_sync_state1_next_state(1, 0),
      R => BU2_U0_receiver_pcs_sync_state1_or0000,
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state1_state_1_0_58
    );
  BU2_U0_receiver_pcs_sync_state1_signal_detect_last : FD
    port map (
      D => BU2_U0_signal_detect_int(1),
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state1_signal_detect_last_59
    );
  BU2_U0_receiver_pcs_sync_state1_code_valid_pipe_1 : FDR
    port map (
      D => mgt_codevalid_117(2),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state1_code_valid_pipe(1)
    );
  BU2_U0_receiver_pcs_sync_state1_code_valid_pipe_0 : FDR
    port map (
      D => mgt_codevalid_117(3),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state1_code_valid_pipe(0)
    );
  BU2_U0_receiver_pcs_sync_state1_code_comma_pipe_1 : FDR
    port map (
      D => mgt_codecomma_118(2),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state1_code_comma_pipe(1)
    );
  BU2_U0_receiver_pcs_sync_state1_code_comma_pipe_0 : FDR
    port map (
      D => mgt_codecomma_118(3),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state1_code_comma_pipe(0)
    );
  BU2_U0_receiver_pcs_sync_state2_state_1_4 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_receiver_pcs_sync_state2_next_state(1, 4),
      R => BU2_U0_receiver_pcs_sync_state2_or0000,
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state2_state_1_4_60
    );
  BU2_U0_receiver_pcs_sync_state2_state_1_3 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_receiver_pcs_sync_state2_next_state(1, 3),
      R => BU2_U0_receiver_pcs_sync_state2_or0000,
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state2_state_1_3_61
    );
  BU2_U0_receiver_pcs_sync_state2_state_1_2 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_receiver_pcs_sync_state2_next_state(1, 2),
      R => BU2_U0_receiver_pcs_sync_state2_or0000,
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state2_state_1_2_62
    );
  BU2_U0_receiver_pcs_sync_state2_state_1_1 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_receiver_pcs_sync_state2_next_state(1, 1),
      R => BU2_U0_receiver_pcs_sync_state2_or0000,
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state2_state_1_1_63
    );
  BU2_U0_receiver_pcs_sync_state2_state_1_0 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_receiver_pcs_sync_state2_next_state(1, 0),
      R => BU2_U0_receiver_pcs_sync_state2_or0000,
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state2_state_1_0_64
    );
  BU2_U0_receiver_pcs_sync_state2_signal_detect_last : FD
    port map (
      D => BU2_U0_signal_detect_int(2),
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state2_signal_detect_last_65
    );
  BU2_U0_receiver_pcs_sync_state2_code_valid_pipe_1 : FDR
    port map (
      D => mgt_codevalid_117(4),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state2_code_valid_pipe(1)
    );
  BU2_U0_receiver_pcs_sync_state2_code_valid_pipe_0 : FDR
    port map (
      D => mgt_codevalid_117(5),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state2_code_valid_pipe(0)
    );
  BU2_U0_receiver_pcs_sync_state2_code_comma_pipe_1 : FDR
    port map (
      D => mgt_codecomma_118(4),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state2_code_comma_pipe(1)
    );
  BU2_U0_receiver_pcs_sync_state2_code_comma_pipe_0 : FDR
    port map (
      D => mgt_codecomma_118(5),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state2_code_comma_pipe(0)
    );
  BU2_U0_receiver_pcs_sync_state3_state_1_4 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_receiver_pcs_sync_state3_next_state(1, 4),
      R => BU2_U0_receiver_pcs_sync_state3_or0000,
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state3_state_1_4_66
    );
  BU2_U0_receiver_pcs_sync_state3_state_1_3 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_receiver_pcs_sync_state3_next_state(1, 3),
      R => BU2_U0_receiver_pcs_sync_state3_or0000,
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state3_state_1_3_67
    );
  BU2_U0_receiver_pcs_sync_state3_state_1_2 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_receiver_pcs_sync_state3_next_state(1, 2),
      R => BU2_U0_receiver_pcs_sync_state3_or0000,
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state3_state_1_2_68
    );
  BU2_U0_receiver_pcs_sync_state3_state_1_1 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_receiver_pcs_sync_state3_next_state(1, 1),
      R => BU2_U0_receiver_pcs_sync_state3_or0000,
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state3_state_1_1_69
    );
  BU2_U0_receiver_pcs_sync_state3_state_1_0 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_receiver_pcs_sync_state3_next_state(1, 0),
      R => BU2_U0_receiver_pcs_sync_state3_or0000,
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state3_state_1_0_70
    );
  BU2_U0_receiver_pcs_sync_state3_signal_detect_last : FD
    port map (
      D => BU2_U0_signal_detect_int(3),
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state3_signal_detect_last_71
    );
  BU2_U0_receiver_pcs_sync_state3_code_valid_pipe_1 : FDR
    port map (
      D => mgt_codevalid_117(6),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state3_code_valid_pipe(1)
    );
  BU2_U0_receiver_pcs_sync_state3_code_valid_pipe_0 : FDR
    port map (
      D => mgt_codevalid_117(7),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state3_code_valid_pipe(0)
    );
  BU2_U0_receiver_pcs_sync_state3_code_comma_pipe_1 : FDR
    port map (
      D => mgt_codecomma_118(6),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state3_code_comma_pipe(1)
    );
  BU2_U0_receiver_pcs_sync_state3_code_comma_pipe_0 : FDR
    port map (
      D => mgt_codecomma_118(7),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_pcs_sync_state3_code_comma_pipe(0)
    );
  BU2_U0_transmitter_state_machine_state_1_2 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_transmitter_state_machine_next_state_1_2_Q,
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_state_machine_state_1_2_72
    );
  BU2_U0_transmitter_state_machine_state_1_1 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_transmitter_state_machine_next_state_1_1_Q,
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_state_machine_state_1_1_73
    );
  BU2_U0_transmitter_state_machine_state_0_2 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_transmitter_state_machine_next_state_0_2_Q,
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_state_machine_state_0_2_74
    );
  BU2_U0_transmitter_state_machine_state_0_1 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_transmitter_state_machine_next_state_0_1_Q,
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_state_machine_state_0_1_75
    );
  BU2_U0_transmitter_state_machine_state_0_0 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_transmitter_state_machine_next_state_0_0_Q,
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_state_machine_state_0_0_76
    );
  BU2_U0_transmitter_state_machine_next_ifg_is_a : FDSE
    port map (
      D => BU2_U0_transmitter_state_machine_mux0010_78,
      S => BU2_U0_usrclk_reset_104,
      CE => BU2_U0_transmitter_state_machine_not0003,
      C => usrclk,
      Q => BU2_U0_transmitter_state_machine_next_ifg_is_a_77
    );
  BU2_U0_transmitter_filter0_txd_out_7 : FDS
    port map (
      D => BU2_U0_transmitter_filter0_mux0007(0),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter0_txd_out(7)
    );
  BU2_U0_transmitter_filter0_txd_out_6 : FDR
    port map (
      D => BU2_U0_transmitter_filter0_mux0007(1),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter0_txd_out(6)
    );
  BU2_U0_transmitter_filter0_txd_out_5 : FDS
    port map (
      D => BU2_U0_transmitter_filter0_mux0007(2),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter0_txd_out(5)
    );
  BU2_U0_transmitter_filter0_txd_out_4 : FDS
    port map (
      D => BU2_U0_transmitter_filter0_mux0007(3),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter0_txd_out(4)
    );
  BU2_U0_transmitter_filter0_txd_out_3 : FDS
    port map (
      D => BU2_U0_transmitter_filter0_mux0007(4),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter0_txd_out(3)
    );
  BU2_U0_transmitter_filter0_txd_out_2 : FDS
    port map (
      D => BU2_U0_transmitter_filter0_mux0007(5),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter0_txd_out(2)
    );
  BU2_U0_transmitter_filter0_txd_out_1 : FDR
    port map (
      D => BU2_U0_transmitter_filter0_mux0007(6),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter0_txd_out(1)
    );
  BU2_U0_transmitter_filter0_txd_out_0 : FDR
    port map (
      D => BU2_U0_transmitter_filter0_mux0007(7),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter0_txd_out(0)
    );
  BU2_U0_transmitter_filter0_txc_out : FDS
    port map (
      D => BU2_U0_transmitter_txc_pipe(0),
      S => BU2_U0_usrclk_reset_104,
      C => usrclk,
      Q => BU2_U0_transmitter_filter0_txc_out_79
    );
  BU2_U0_transmitter_filter1_txd_out_7 : FDS
    port map (
      D => BU2_U0_transmitter_filter1_mux0007(0),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter1_txd_out(7)
    );
  BU2_U0_transmitter_filter1_txd_out_6 : FDR
    port map (
      D => BU2_U0_transmitter_filter1_mux0007(1),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter1_txd_out(6)
    );
  BU2_U0_transmitter_filter1_txd_out_5 : FDS
    port map (
      D => BU2_U0_transmitter_filter1_mux0007(2),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter1_txd_out(5)
    );
  BU2_U0_transmitter_filter1_txd_out_4 : FDS
    port map (
      D => BU2_U0_transmitter_filter1_mux0007(3),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter1_txd_out(4)
    );
  BU2_U0_transmitter_filter1_txd_out_3 : FDS
    port map (
      D => BU2_U0_transmitter_filter1_mux0007(4),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter1_txd_out(3)
    );
  BU2_U0_transmitter_filter1_txd_out_2 : FDS
    port map (
      D => BU2_U0_transmitter_filter1_mux0007(5),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter1_txd_out(2)
    );
  BU2_U0_transmitter_filter1_txd_out_1 : FDR
    port map (
      D => BU2_U0_transmitter_filter1_mux0007(6),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter1_txd_out(1)
    );
  BU2_U0_transmitter_filter1_txd_out_0 : FDR
    port map (
      D => BU2_U0_transmitter_filter1_mux0007(7),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter1_txd_out(0)
    );
  BU2_U0_transmitter_filter1_txc_out : FDS
    port map (
      D => BU2_U0_transmitter_txc_pipe(1),
      S => BU2_U0_usrclk_reset_104,
      C => usrclk,
      Q => BU2_U0_transmitter_filter1_txc_out_80
    );
  BU2_U0_transmitter_filter2_txd_out_7 : FDS
    port map (
      D => BU2_U0_transmitter_filter2_mux0007(0),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter2_txd_out(7)
    );
  BU2_U0_transmitter_filter2_txd_out_6 : FDR
    port map (
      D => BU2_U0_transmitter_filter2_mux0007(1),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter2_txd_out(6)
    );
  BU2_U0_transmitter_filter2_txd_out_5 : FDS
    port map (
      D => BU2_U0_transmitter_filter2_mux0007(2),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter2_txd_out(5)
    );
  BU2_U0_transmitter_filter2_txd_out_4 : FDS
    port map (
      D => BU2_U0_transmitter_filter2_mux0007(3),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter2_txd_out(4)
    );
  BU2_U0_transmitter_filter2_txd_out_3 : FDS
    port map (
      D => BU2_U0_transmitter_filter2_mux0007(4),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter2_txd_out(3)
    );
  BU2_U0_transmitter_filter2_txd_out_2 : FDS
    port map (
      D => BU2_U0_transmitter_filter2_mux0007(5),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter2_txd_out(2)
    );
  BU2_U0_transmitter_filter2_txd_out_1 : FDR
    port map (
      D => BU2_U0_transmitter_filter2_mux0007(6),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter2_txd_out(1)
    );
  BU2_U0_transmitter_filter2_txd_out_0 : FDR
    port map (
      D => BU2_U0_transmitter_filter2_mux0007(7),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter2_txd_out(0)
    );
  BU2_U0_transmitter_filter2_txc_out : FDS
    port map (
      D => BU2_U0_transmitter_txc_pipe(2),
      S => BU2_U0_usrclk_reset_104,
      C => usrclk,
      Q => BU2_U0_transmitter_filter2_txc_out_81
    );
  BU2_U0_transmitter_filter3_txd_out_7 : FDS
    port map (
      D => BU2_U0_transmitter_filter3_mux0007(0),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter3_txd_out(7)
    );
  BU2_U0_transmitter_filter3_txd_out_6 : FDR
    port map (
      D => BU2_U0_transmitter_filter3_mux0007(1),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter3_txd_out(6)
    );
  BU2_U0_transmitter_filter3_txd_out_5 : FDS
    port map (
      D => BU2_U0_transmitter_filter3_mux0007(2),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter3_txd_out(5)
    );
  BU2_U0_transmitter_filter3_txd_out_4 : FDS
    port map (
      D => BU2_U0_transmitter_filter3_mux0007(3),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter3_txd_out(4)
    );
  BU2_U0_transmitter_filter3_txd_out_3 : FDS
    port map (
      D => BU2_U0_transmitter_filter3_mux0007(4),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter3_txd_out(3)
    );
  BU2_U0_transmitter_filter3_txd_out_2 : FDS
    port map (
      D => BU2_U0_transmitter_filter3_mux0007(5),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter3_txd_out(2)
    );
  BU2_U0_transmitter_filter3_txd_out_1 : FDR
    port map (
      D => BU2_U0_transmitter_filter3_mux0007(6),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter3_txd_out(1)
    );
  BU2_U0_transmitter_filter3_txd_out_0 : FDR
    port map (
      D => BU2_U0_transmitter_filter3_mux0007(7),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter3_txd_out(0)
    );
  BU2_U0_transmitter_filter3_txc_out : FDS
    port map (
      D => BU2_U0_transmitter_txc_pipe(3),
      S => BU2_U0_usrclk_reset_104,
      C => usrclk,
      Q => BU2_U0_transmitter_filter3_txc_out_82
    );
  BU2_U0_transmitter_filter4_txd_out_7 : FDS
    port map (
      D => BU2_U0_transmitter_filter4_mux0007(0),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter4_txd_out(7)
    );
  BU2_U0_transmitter_filter4_txd_out_6 : FDR
    port map (
      D => BU2_U0_transmitter_filter4_mux0007(1),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter4_txd_out(6)
    );
  BU2_U0_transmitter_filter4_txd_out_5 : FDS
    port map (
      D => BU2_U0_transmitter_filter4_mux0007(2),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter4_txd_out(5)
    );
  BU2_U0_transmitter_filter4_txd_out_4 : FDS
    port map (
      D => BU2_U0_transmitter_filter4_mux0007(3),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter4_txd_out(4)
    );
  BU2_U0_transmitter_filter4_txd_out_3 : FDS
    port map (
      D => BU2_U0_transmitter_filter4_mux0007(4),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter4_txd_out(3)
    );
  BU2_U0_transmitter_filter4_txd_out_2 : FDS
    port map (
      D => BU2_U0_transmitter_filter4_mux0007(5),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter4_txd_out(2)
    );
  BU2_U0_transmitter_filter4_txd_out_1 : FDR
    port map (
      D => BU2_U0_transmitter_filter4_mux0007(6),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter4_txd_out(1)
    );
  BU2_U0_transmitter_filter4_txd_out_0 : FDR
    port map (
      D => BU2_U0_transmitter_filter4_mux0007(7),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter4_txd_out(0)
    );
  BU2_U0_transmitter_filter4_txc_out : FDS
    port map (
      D => BU2_U0_transmitter_txc_pipe(4),
      S => BU2_U0_usrclk_reset_104,
      C => usrclk,
      Q => BU2_U0_transmitter_filter4_txc_out_83
    );
  BU2_U0_transmitter_filter5_txd_out_7 : FDS
    port map (
      D => BU2_U0_transmitter_filter5_mux0007(0),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter5_txd_out(7)
    );
  BU2_U0_transmitter_filter5_txd_out_6 : FDR
    port map (
      D => BU2_U0_transmitter_filter5_mux0007(1),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter5_txd_out(6)
    );
  BU2_U0_transmitter_filter5_txd_out_5 : FDS
    port map (
      D => BU2_U0_transmitter_filter5_mux0007(2),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter5_txd_out(5)
    );
  BU2_U0_transmitter_filter5_txd_out_4 : FDS
    port map (
      D => BU2_U0_transmitter_filter5_mux0007(3),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter5_txd_out(4)
    );
  BU2_U0_transmitter_filter5_txd_out_3 : FDS
    port map (
      D => BU2_U0_transmitter_filter5_mux0007(4),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter5_txd_out(3)
    );
  BU2_U0_transmitter_filter5_txd_out_2 : FDS
    port map (
      D => BU2_U0_transmitter_filter5_mux0007(5),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter5_txd_out(2)
    );
  BU2_U0_transmitter_filter5_txd_out_1 : FDR
    port map (
      D => BU2_U0_transmitter_filter5_mux0007(6),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter5_txd_out(1)
    );
  BU2_U0_transmitter_filter5_txd_out_0 : FDR
    port map (
      D => BU2_U0_transmitter_filter5_mux0007(7),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter5_txd_out(0)
    );
  BU2_U0_transmitter_filter5_txc_out : FDS
    port map (
      D => BU2_U0_transmitter_txc_pipe(5),
      S => BU2_U0_usrclk_reset_104,
      C => usrclk,
      Q => BU2_U0_transmitter_filter5_txc_out_84
    );
  BU2_U0_transmitter_filter6_txd_out_7 : FDS
    port map (
      D => BU2_U0_transmitter_filter6_mux0007(0),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter6_txd_out(7)
    );
  BU2_U0_transmitter_filter6_txd_out_6 : FDR
    port map (
      D => BU2_U0_transmitter_filter6_mux0007(1),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter6_txd_out(6)
    );
  BU2_U0_transmitter_filter6_txd_out_5 : FDS
    port map (
      D => BU2_U0_transmitter_filter6_mux0007(2),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter6_txd_out(5)
    );
  BU2_U0_transmitter_filter6_txd_out_4 : FDS
    port map (
      D => BU2_U0_transmitter_filter6_mux0007(3),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter6_txd_out(4)
    );
  BU2_U0_transmitter_filter6_txd_out_3 : FDS
    port map (
      D => BU2_U0_transmitter_filter6_mux0007(4),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter6_txd_out(3)
    );
  BU2_U0_transmitter_filter6_txd_out_2 : FDS
    port map (
      D => BU2_U0_transmitter_filter6_mux0007(5),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter6_txd_out(2)
    );
  BU2_U0_transmitter_filter6_txd_out_1 : FDR
    port map (
      D => BU2_U0_transmitter_filter6_mux0007(6),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter6_txd_out(1)
    );
  BU2_U0_transmitter_filter6_txd_out_0 : FDR
    port map (
      D => BU2_U0_transmitter_filter6_mux0007(7),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter6_txd_out(0)
    );
  BU2_U0_transmitter_filter6_txc_out : FDS
    port map (
      D => BU2_U0_transmitter_txc_pipe(6),
      S => BU2_U0_usrclk_reset_104,
      C => usrclk,
      Q => BU2_U0_transmitter_filter6_txc_out_85
    );
  BU2_U0_transmitter_filter7_txd_out_7 : FDS
    port map (
      D => BU2_U0_transmitter_filter7_mux0007(0),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter7_txd_out(7)
    );
  BU2_U0_transmitter_filter7_txd_out_6 : FDR
    port map (
      D => BU2_U0_transmitter_filter7_mux0007(1),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter7_txd_out(6)
    );
  BU2_U0_transmitter_filter7_txd_out_5 : FDS
    port map (
      D => BU2_U0_transmitter_filter7_mux0007(2),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter7_txd_out(5)
    );
  BU2_U0_transmitter_filter7_txd_out_4 : FDS
    port map (
      D => BU2_U0_transmitter_filter7_mux0007(3),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter7_txd_out(4)
    );
  BU2_U0_transmitter_filter7_txd_out_3 : FDS
    port map (
      D => BU2_U0_transmitter_filter7_mux0007(4),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter7_txd_out(3)
    );
  BU2_U0_transmitter_filter7_txd_out_2 : FDS
    port map (
      D => BU2_U0_transmitter_filter7_mux0007(5),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter7_txd_out(2)
    );
  BU2_U0_transmitter_filter7_txd_out_1 : FDR
    port map (
      D => BU2_U0_transmitter_filter7_mux0007(6),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter7_txd_out(1)
    );
  BU2_U0_transmitter_filter7_txd_out_0 : FDR
    port map (
      D => BU2_U0_transmitter_filter7_mux0007(7),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_filter7_txd_out(0)
    );
  BU2_U0_transmitter_filter7_txc_out : FDS
    port map (
      D => BU2_U0_transmitter_txc_pipe(7),
      S => BU2_U0_usrclk_reset_104,
      C => usrclk,
      Q => BU2_U0_transmitter_filter7_txc_out_86
    );
  BU2_U0_transmitter_recoder_txd_out_10 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0463,
      S => BU2_U0_transmitter_recoder_or0000,
      C => usrclk,
      Q => mgt_txdata_110(26)
    );
  BU2_U0_transmitter_recoder_txc_out_7 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0462,
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => mgt_txcharisk_111(6)
    );
  BU2_U0_transmitter_recoder_txc_out_6 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0461,
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => mgt_txcharisk_111(4)
    );
  BU2_U0_transmitter_recoder_txc_out_5 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0460,
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => mgt_txcharisk_111(2)
    );
  BU2_U0_transmitter_recoder_txc_out_4 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0459,
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => mgt_txcharisk_111(0)
    );
  BU2_U0_transmitter_recoder_txc_out_3 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0458,
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => mgt_txcharisk_111(7)
    );
  BU2_U0_transmitter_recoder_txd_out_9 : FDR
    port map (
      D => BU2_U0_transmitter_recoder_mux0456,
      R => BU2_U0_transmitter_recoder_or0000,
      C => usrclk,
      Q => mgt_txdata_110(25)
    );
  BU2_U0_transmitter_recoder_txc_out_1 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0455,
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => mgt_txcharisk_111(3)
    );
  BU2_U0_transmitter_recoder_txc_out_2 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0457,
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => mgt_txcharisk_111(5)
    );
  BU2_U0_transmitter_recoder_txc_out_0 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0453,
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => mgt_txcharisk_111(1)
    );
  BU2_U0_transmitter_recoder_txd_out_7 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0452,
      S => BU2_U0_transmitter_recoder_or0000,
      C => usrclk,
      Q => mgt_txdata_110(15)
    );
  BU2_U0_transmitter_recoder_txd_out_59 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0451_87,
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => mgt_txdata_110(51)
    );
  BU2_U0_transmitter_recoder_txd_out_63 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0449,
      S => BU2_U0_transmitter_recoder_or0000,
      C => usrclk,
      Q => mgt_txdata_110(55)
    );
  BU2_U0_transmitter_recoder_txd_out_5 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0447,
      S => BU2_U0_transmitter_recoder_or0000,
      C => usrclk,
      Q => mgt_txdata_110(13)
    );
  BU2_U0_transmitter_recoder_txd_out_58 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0448,
      S => BU2_U0_transmitter_recoder_or0000,
      C => usrclk,
      Q => mgt_txdata_110(50)
    );
  BU2_U0_transmitter_recoder_txd_out_57 : FDR
    port map (
      D => BU2_U0_transmitter_recoder_mux0445,
      R => BU2_U0_transmitter_recoder_or0000,
      C => usrclk,
      Q => mgt_txdata_110(49)
    );
  BU2_U0_transmitter_recoder_txd_out_4 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0444,
      S => BU2_U0_transmitter_recoder_or0000,
      C => usrclk,
      Q => mgt_txdata_110(12)
    );
  BU2_U0_transmitter_recoder_txd_out_61 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0443,
      S => BU2_U0_transmitter_recoder_or0000,
      C => usrclk,
      Q => mgt_txdata_110(53)
    );
  BU2_U0_transmitter_recoder_txd_out_3 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0441_88,
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => mgt_txdata_110(11)
    );
  BU2_U0_transmitter_recoder_txd_out_60 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0440,
      S => BU2_U0_transmitter_recoder_or0000,
      C => usrclk,
      Q => mgt_txdata_110(52)
    );
  BU2_U0_transmitter_recoder_txd_out_2 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0438,
      S => BU2_U0_transmitter_recoder_or0000,
      C => usrclk,
      Q => mgt_txdata_110(10)
    );
  BU2_U0_transmitter_recoder_txd_out_55 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0439,
      S => BU2_U0_transmitter_recoder_or0000,
      C => usrclk,
      Q => mgt_txdata_110(39)
    );
  BU2_U0_transmitter_recoder_txd_out_49 : FDR
    port map (
      D => BU2_U0_transmitter_recoder_mux0436,
      R => BU2_U0_transmitter_recoder_or0000,
      C => usrclk,
      Q => mgt_txdata_110(33)
    );
  BU2_U0_transmitter_recoder_txd_out_1 : FDR
    port map (
      D => BU2_U0_transmitter_recoder_mux0435,
      R => BU2_U0_transmitter_recoder_or0000,
      C => usrclk,
      Q => mgt_txdata_110(9)
    );
  BU2_U0_transmitter_recoder_txd_out_53 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0434,
      S => BU2_U0_transmitter_recoder_or0000,
      C => usrclk,
      Q => mgt_txdata_110(37)
    );
  BU2_U0_transmitter_recoder_txd_out_52 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0431,
      S => BU2_U0_transmitter_recoder_or0000,
      C => usrclk,
      Q => mgt_txdata_110(36)
    );
  BU2_U0_transmitter_recoder_txd_out_51 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0429_89,
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => mgt_txdata_110(35)
    );
  BU2_U0_transmitter_recoder_txd_out_47 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0430,
      S => BU2_U0_transmitter_recoder_or0000,
      C => usrclk,
      Q => mgt_txdata_110(23)
    );
  BU2_U0_transmitter_recoder_txd_out_50 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0427,
      S => BU2_U0_transmitter_recoder_or0000,
      C => usrclk,
      Q => mgt_txdata_110(34)
    );
  BU2_U0_transmitter_recoder_txd_out_45 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0426,
      S => BU2_U0_transmitter_recoder_or0000,
      C => usrclk,
      Q => mgt_txdata_110(21)
    );
  BU2_U0_transmitter_recoder_txd_out_44 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0425,
      S => BU2_U0_transmitter_recoder_or0000,
      C => usrclk,
      Q => mgt_txdata_110(20)
    );
  BU2_U0_transmitter_recoder_txd_out_39 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0424,
      S => BU2_U0_transmitter_recoder_or0000,
      C => usrclk,
      Q => mgt_txdata_110(7)
    );
  BU2_U0_transmitter_recoder_txd_out_43 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0423_90,
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => mgt_txdata_110(19)
    );
  BU2_U0_transmitter_recoder_txd_out_37 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0420,
      S => BU2_U0_transmitter_recoder_or0000,
      C => usrclk,
      Q => mgt_txdata_110(5)
    );
  BU2_U0_transmitter_recoder_txd_out_41 : FDR
    port map (
      D => BU2_U0_transmitter_recoder_mux0419,
      R => BU2_U0_transmitter_recoder_or0000,
      C => usrclk,
      Q => mgt_txdata_110(17)
    );
  BU2_U0_transmitter_recoder_txd_out_42 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0421,
      S => BU2_U0_transmitter_recoder_or0000,
      C => usrclk,
      Q => mgt_txdata_110(18)
    );
  BU2_U0_transmitter_recoder_txd_out_36 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0418,
      S => BU2_U0_transmitter_recoder_or0000,
      C => usrclk,
      Q => mgt_txdata_110(4)
    );
  BU2_U0_transmitter_recoder_txd_out_35 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0416_91,
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => mgt_txdata_110(3)
    );
  BU2_U0_transmitter_recoder_txd_out_34 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0415,
      S => BU2_U0_transmitter_recoder_or0000,
      C => usrclk,
      Q => mgt_txdata_110(2)
    );
  BU2_U0_transmitter_recoder_txd_out_29 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0414,
      S => BU2_U0_transmitter_recoder_or0000,
      C => usrclk,
      Q => mgt_txdata_110(61)
    );
  BU2_U0_transmitter_recoder_txd_out_33 : FDR
    port map (
      D => BU2_U0_transmitter_recoder_mux0413,
      R => BU2_U0_transmitter_recoder_or0000,
      C => usrclk,
      Q => mgt_txdata_110(1)
    );
  BU2_U0_transmitter_recoder_txd_out_27 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0410_92,
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => mgt_txdata_110(59)
    );
  BU2_U0_transmitter_recoder_txd_out_28 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0412,
      S => BU2_U0_transmitter_recoder_or0000,
      C => usrclk,
      Q => mgt_txdata_110(60)
    );
  BU2_U0_transmitter_recoder_txd_out_31 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0409,
      S => BU2_U0_transmitter_recoder_or0000,
      C => usrclk,
      Q => mgt_txdata_110(63)
    );
  BU2_U0_transmitter_recoder_txd_out_26 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0408,
      S => BU2_U0_transmitter_recoder_or0000,
      C => usrclk,
      Q => mgt_txdata_110(58)
    );
  BU2_U0_transmitter_recoder_txd_out_25 : FDR
    port map (
      D => BU2_U0_transmitter_recoder_mux0406,
      R => BU2_U0_transmitter_recoder_or0000,
      C => usrclk,
      Q => mgt_txdata_110(57)
    );
  BU2_U0_transmitter_recoder_txd_out_19 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0404_93,
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => mgt_txdata_110(43)
    );
  BU2_U0_transmitter_recoder_txd_out_18 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0402,
      S => BU2_U0_transmitter_recoder_or0000,
      C => usrclk,
      Q => mgt_txdata_110(42)
    );
  BU2_U0_transmitter_recoder_txd_out_23 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0403,
      S => BU2_U0_transmitter_recoder_or0000,
      C => usrclk,
      Q => mgt_txdata_110(47)
    );
  BU2_U0_transmitter_recoder_txd_out_17 : FDR
    port map (
      D => BU2_U0_transmitter_recoder_mux0400,
      R => BU2_U0_transmitter_recoder_or0000,
      C => usrclk,
      Q => mgt_txdata_110(41)
    );
  BU2_U0_transmitter_recoder_txd_out_21 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0399,
      S => BU2_U0_transmitter_recoder_or0000,
      C => usrclk,
      Q => mgt_txdata_110(45)
    );
  BU2_U0_transmitter_recoder_txd_out_20 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0397,
      S => BU2_U0_transmitter_recoder_or0000,
      C => usrclk,
      Q => mgt_txdata_110(44)
    );
  BU2_U0_transmitter_recoder_txd_out_15 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0396,
      S => BU2_U0_transmitter_recoder_or0000,
      C => usrclk,
      Q => mgt_txdata_110(31)
    );
  BU2_U0_transmitter_recoder_txd_out_12 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0393,
      S => BU2_U0_transmitter_recoder_or0000,
      C => usrclk,
      Q => mgt_txdata_110(28)
    );
  BU2_U0_transmitter_recoder_txd_out_11 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0392_94,
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => mgt_txdata_110(27)
    );
  BU2_U0_transmitter_recoder_txd_out_13 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_mux0394,
      S => BU2_U0_transmitter_recoder_or0000,
      C => usrclk,
      Q => mgt_txdata_110(29)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_31 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_mux0002(63),
      R => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_tqmsg_capture_1_or0000,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(31)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_30 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_mux0002(62),
      R => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_tqmsg_capture_1_or0000,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(30)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_29 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_mux0002(61),
      R => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_tqmsg_capture_1_or0000,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(29)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_28 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_mux0002(60),
      R => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_tqmsg_capture_1_or0000,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(28)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_27 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_mux0002(59),
      R => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_tqmsg_capture_1_or0000,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(27)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_26 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_mux0002(58),
      R => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_tqmsg_capture_1_or0000,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(26)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_25 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_mux0002(57),
      R => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_tqmsg_capture_1_or0000,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(25)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_24 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_mux0002(56),
      R => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_tqmsg_capture_1_or0000,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(24)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_23 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_mux0002(55),
      R => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_tqmsg_capture_1_or0000,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(23)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_22 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_mux0002(54),
      R => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_tqmsg_capture_1_or0000,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(22)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_21 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_mux0002(53),
      R => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_tqmsg_capture_1_or0000,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(21)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_20 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_mux0002(52),
      R => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_tqmsg_capture_1_or0000,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(20)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_19 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_mux0002(51),
      R => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_tqmsg_capture_1_or0000,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(19)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_18 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_mux0002(50),
      R => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_tqmsg_capture_1_or0000,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(18)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_17 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_mux0002(49),
      R => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_tqmsg_capture_1_or0000,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(17)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_16 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_mux0002(48),
      R => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_tqmsg_capture_1_or0000,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(16)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_15 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_mux0002(47),
      R => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_tqmsg_capture_1_or0000,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(15)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_14 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_mux0002(46),
      R => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_tqmsg_capture_1_or0000,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(14)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_13 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_mux0002(45),
      R => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_tqmsg_capture_1_or0000,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(13)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_12 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_mux0002(44),
      R => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_tqmsg_capture_1_or0000,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(12)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_11 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_mux0002(43),
      R => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_tqmsg_capture_1_or0000,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(11)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_10 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_mux0002(42),
      R => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_tqmsg_capture_1_or0000,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(10)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_9 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_mux0002(41),
      R => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_tqmsg_capture_1_or0000,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(9)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_8 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_mux0002(40),
      R => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_tqmsg_capture_1_or0000,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(8)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_7 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_mux0002(39),
      R => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_tqmsg_capture_1_or0000,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(7)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_6 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_mux0002(38),
      R => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_tqmsg_capture_1_or0000,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(6)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_5 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_mux0002(37),
      R => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_tqmsg_capture_1_or0000,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(5)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_4 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_mux0002(36),
      R => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_tqmsg_capture_1_or0000,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(4)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_3 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_mux0002(35),
      R => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_tqmsg_capture_1_or0000,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(3)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_2 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_mux0002(34),
      R => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_tqmsg_capture_1_or0000,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(2)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_1 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_mux0002(33),
      R => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_tqmsg_capture_1_or0000,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(1)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_0 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_mux0002(32),
      R => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_tqmsg_capture_1_or0000,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(0)
    );
  BU2_U0_transmitter_tqmsg_capture_1_q_det : FDRSE
    port map (
      D => BU2_mdio_tri,
      R => BU2_U0_usrclk_reset_104,
      S => BU2_U0_transmitter_tqmsg_capture_1_or0000,
      CE => BU2_U0_transmitter_clear_q_det,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_q_det_95
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_31 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(63),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(31)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_30 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(62),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(30)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_29 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(61),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(29)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_28 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(60),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(28)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_27 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(59),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(27)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_26 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(58),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(26)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_25 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(57),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(25)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_24 : FDS
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(56),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(24)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_23 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(55),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(23)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_22 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(54),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(22)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_21 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(53),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(21)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_20 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(52),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(20)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_19 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(51),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(19)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_18 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(50),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(18)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_17 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(49),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(17)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_16 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(48),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(16)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_15 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(47),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(15)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_14 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(46),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(14)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_13 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(45),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(13)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_12 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(44),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(12)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_11 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(43),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(11)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_10 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(42),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(10)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_9 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(41),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(9)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_8 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(40),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(8)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_7 : FDS
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(39),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(7)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_6 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(38),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(6)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_5 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(37),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(5)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_4 : FDS
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(36),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(4)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_3 : FDS
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(35),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(3)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_2 : FDS
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(34),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(2)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_1 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(33),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(1)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_0 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(32),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(0)
    );
  BU2_U0_receiver_recoder_rxc_half_pipe_3 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxc_pipe(7),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxc_half_pipe(3)
    );
  BU2_U0_receiver_recoder_rxc_half_pipe_2 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxc_pipe(6),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxc_half_pipe(2)
    );
  BU2_U0_receiver_recoder_rxc_half_pipe_1 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxc_pipe(5),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxc_half_pipe(1)
    );
  BU2_U0_receiver_recoder_rxc_half_pipe_0 : FDS
    port map (
      D => BU2_U0_receiver_recoder_rxc_pipe(4),
      S => BU2_U0_usrclk_reset_104,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxc_half_pipe(0)
    );
  BU2_U0_receiver_recoder_rxd_out_24 : FDS
    port map (
      D => BU2_U0_receiver_recoder_mux0472,
      S => BU2_U0_or0001,
      C => usrclk,
      Q => xgmii_rxd_108(24)
    );
  BU2_U0_receiver_recoder_rxc_out_3 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxc_half_pipe(3),
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_or0004,
      C => usrclk,
      Q => xgmii_rxc_109(3)
    );
  BU2_U0_receiver_recoder_rxc_out_2 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxc_half_pipe(2),
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_or0003,
      C => usrclk,
      Q => xgmii_rxc_109(2)
    );
  BU2_U0_receiver_recoder_rxc_out_0 : FDS
    port map (
      D => BU2_U0_receiver_recoder_rxc_half_pipe(0),
      S => BU2_U0_receiver_recoder_or0014,
      C => usrclk,
      Q => xgmii_rxc_109(0)
    );
  BU2_U0_receiver_recoder_rxd_out_9 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxd_half_pipe(9),
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_or0001,
      C => usrclk,
      Q => xgmii_rxd_108(9)
    );
  BU2_U0_receiver_recoder_rxc_out_1 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxc_half_pipe(1),
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_or0001,
      C => usrclk,
      Q => xgmii_rxc_109(1)
    );
  BU2_U0_receiver_recoder_rxd_out_8 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxd_half_pipe(8),
      R => BU2_U0_receiver_recoder_or0016,
      S => BU2_U0_receiver_recoder_or0018,
      C => usrclk,
      Q => xgmii_rxd_108(8)
    );
  BU2_U0_receiver_recoder_rxd_out_2 : FDS
    port map (
      D => BU2_U0_receiver_recoder_rxd_half_pipe(2),
      S => BU2_U0_receiver_recoder_or0014,
      C => usrclk,
      Q => xgmii_rxd_108(2)
    );
  BU2_U0_receiver_recoder_rxd_out_56 : FDS
    port map (
      D => BU2_U0_receiver_recoder_mux0496,
      S => BU2_U0_or0001,
      C => usrclk,
      Q => xgmii_rxd_108(56)
    );
  BU2_U0_receiver_recoder_rxd_out_1 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxd_half_pipe(1),
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_or0013,
      C => usrclk,
      Q => xgmii_rxd_108(1)
    );
  BU2_U0_receiver_recoder_rxd_out_0 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxd_half_pipe(0),
      R => BU2_U0_receiver_recoder_or0012,
      S => BU2_U0_receiver_recoder_or0017,
      C => usrclk,
      Q => xgmii_rxd_108(0)
    );
  BU2_U0_receiver_recoder_rxd_out_26 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxd_half_pipe(26),
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_or0004,
      C => usrclk,
      Q => xgmii_rxd_108(26)
    );
  BU2_U0_receiver_recoder_rxd_out_25 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxd_half_pipe(25),
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_or0004,
      C => usrclk,
      Q => xgmii_rxd_108(25)
    );
  BU2_U0_receiver_recoder_rxd_out_18 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxd_half_pipe(18),
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_or0003,
      C => usrclk,
      Q => xgmii_rxd_108(18)
    );
  BU2_U0_receiver_recoder_rxd_out_17 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxd_half_pipe(17),
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_or0003,
      C => usrclk,
      Q => xgmii_rxd_108(17)
    );
  BU2_U0_receiver_recoder_rxd_out_16 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxd_half_pipe(16),
      R => BU2_U0_receiver_recoder_or0002,
      S => BU2_U0_receiver_recoder_or0019,
      C => usrclk,
      Q => xgmii_rxd_108(16)
    );
  BU2_U0_receiver_recoder_rxd_out_10 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxd_half_pipe(10),
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_or0001,
      C => usrclk,
      Q => xgmii_rxd_108(10)
    );
  BU2_U0_receiver_recoder_rxc_out_7 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxc_pipe(3),
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_or0015,
      C => usrclk,
      Q => xgmii_rxc_109(7)
    );
  BU2_U0_receiver_recoder_rxc_out_6 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxc_pipe(2),
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_or0010,
      C => usrclk,
      Q => xgmii_rxc_109(6)
    );
  BU2_U0_receiver_recoder_rxc_out_5 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxc_pipe(1),
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_or0009,
      C => usrclk,
      Q => xgmii_rxc_109(5)
    );
  BU2_U0_receiver_recoder_rxc_out_4 : FDS
    port map (
      D => BU2_U0_receiver_recoder_rxc_pipe(0),
      S => BU2_U0_receiver_recoder_or0007,
      C => usrclk,
      Q => xgmii_rxc_109(4)
    );
  BU2_U0_receiver_recoder_rxd_out_58 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(26),
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_or0015,
      C => usrclk,
      Q => xgmii_rxd_108(58)
    );
  BU2_U0_receiver_recoder_code_error_delay_3 : FDR
    port map (
      D => BU2_U0_receiver_recoder_code_error_pipe(7),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_code_error_delay(3)
    );
  BU2_U0_receiver_recoder_rxd_out_57 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(25),
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_or0015,
      C => usrclk,
      Q => xgmii_rxd_108(57)
    );
  BU2_U0_receiver_recoder_code_error_delay_2 : FDR
    port map (
      D => BU2_U0_receiver_recoder_code_error_pipe(6),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_code_error_delay(2)
    );
  BU2_U0_receiver_recoder_code_error_delay_1 : FDR
    port map (
      D => BU2_U0_receiver_recoder_code_error_pipe(5),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_code_error_delay(1)
    );
  BU2_U0_receiver_recoder_code_error_delay_0 : FDR
    port map (
      D => BU2_U0_receiver_recoder_code_error_pipe(4),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_code_error_delay(0)
    );
  BU2_U0_receiver_recoder_rxd_out_49 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(17),
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_or0010,
      C => usrclk,
      Q => xgmii_rxd_108(49)
    );
  BU2_U0_receiver_recoder_rxd_out_48 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(16),
      R => BU2_U0_receiver_recoder_or0011,
      S => BU2_U0_receiver_recoder_or0023_96,
      C => usrclk,
      Q => xgmii_rxd_108(48)
    );
  BU2_U0_receiver_recoder_rxd_out_50 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(18),
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_or0010,
      C => usrclk,
      Q => xgmii_rxd_108(50)
    );
  BU2_U0_receiver_recoder_rxd_out_42 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(10),
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_or0009,
      C => usrclk,
      Q => xgmii_rxd_108(42)
    );
  BU2_U0_receiver_recoder_rxd_out_41 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(9),
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_or0009,
      C => usrclk,
      Q => xgmii_rxd_108(41)
    );
  BU2_U0_receiver_recoder_rxd_out_40 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(8),
      R => BU2_U0_receiver_recoder_or0008,
      S => BU2_U0_receiver_recoder_or0022,
      C => usrclk,
      Q => xgmii_rxd_108(40)
    );
  BU2_U0_receiver_recoder_rxd_out_34 : FDS
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(2),
      S => BU2_U0_receiver_recoder_or0007,
      C => usrclk,
      Q => xgmii_rxd_108(34)
    );
  BU2_U0_receiver_recoder_rxd_out_33 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(1),
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_or0006,
      C => usrclk,
      Q => xgmii_rxd_108(33)
    );
  BU2_U0_receiver_recoder_rxd_out_32 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(0),
      R => BU2_U0_receiver_recoder_or0005,
      S => BU2_U0_receiver_recoder_or0021,
      C => usrclk,
      Q => xgmii_rxd_108(32)
    );
  BU2_U0_receiver_recoder_lane_term_pipe_3 : FDR
    port map (
      D => BU2_U0_receiver_recoder_lane_terminate(7),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_lane_term_pipe(3)
    );
  BU2_U0_receiver_recoder_lane_term_pipe_2 : FDR
    port map (
      D => BU2_U0_receiver_recoder_lane_terminate(6),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_lane_term_pipe(2)
    );
  BU2_U0_receiver_recoder_lane_term_pipe_1 : FDR
    port map (
      D => BU2_U0_receiver_recoder_lane_terminate(5),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_lane_term_pipe(1)
    );
  BU2_U0_receiver_recoder_lane_term_pipe_0 : FDR
    port map (
      D => BU2_U0_receiver_recoder_lane_terminate(4),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_lane_term_pipe(0)
    );
  BU2_U0_receiver_recoder_rxd_pipe_59 : FDR
    port map (
      D => mgt_rxdata_115(51),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(59)
    );
  BU2_U0_receiver_recoder_rxd_pipe_58 : FDR
    port map (
      D => mgt_rxdata_115(50),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(58)
    );
  BU2_U0_receiver_recoder_rxd_pipe_63 : FDR
    port map (
      D => mgt_rxdata_115(55),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(63)
    );
  BU2_U0_receiver_recoder_rxd_pipe_57 : FDR
    port map (
      D => mgt_rxdata_115(49),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(57)
    );
  BU2_U0_receiver_recoder_rxd_pipe_56 : FDS
    port map (
      D => mgt_rxdata_115(48),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(56)
    );
  BU2_U0_receiver_recoder_rxd_pipe_61 : FDR
    port map (
      D => mgt_rxdata_115(53),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(61)
    );
  BU2_U0_receiver_recoder_rxd_pipe_62 : FDR
    port map (
      D => mgt_rxdata_115(54),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(62)
    );
  BU2_U0_receiver_recoder_rxd_pipe_55 : FDR
    port map (
      D => mgt_rxdata_115(39),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(55)
    );
  BU2_U0_receiver_recoder_rxd_pipe_60 : FDR
    port map (
      D => mgt_rxdata_115(52),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(60)
    );
  BU2_U0_receiver_recoder_rxd_pipe_54 : FDR
    port map (
      D => mgt_rxdata_115(38),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(54)
    );
  BU2_U0_receiver_recoder_rxd_pipe_48 : FDR
    port map (
      D => mgt_rxdata_115(32),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(48)
    );
  BU2_U0_receiver_recoder_rxd_pipe_49 : FDR
    port map (
      D => mgt_rxdata_115(33),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(49)
    );
  BU2_U0_receiver_recoder_rxd_pipe_53 : FDR
    port map (
      D => mgt_rxdata_115(37),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(53)
    );
  BU2_U0_receiver_recoder_rxd_pipe_47 : FDR
    port map (
      D => mgt_rxdata_115(23),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(47)
    );
  BU2_U0_receiver_recoder_rxd_pipe_46 : FDR
    port map (
      D => mgt_rxdata_115(22),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(46)
    );
  BU2_U0_receiver_recoder_rxd_pipe_51 : FDR
    port map (
      D => mgt_rxdata_115(35),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(51)
    );
  BU2_U0_receiver_recoder_rxd_pipe_52 : FDR
    port map (
      D => mgt_rxdata_115(36),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(52)
    );
  BU2_U0_receiver_recoder_rxd_pipe_45 : FDR
    port map (
      D => mgt_rxdata_115(21),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(45)
    );
  BU2_U0_receiver_recoder_rxd_pipe_50 : FDR
    port map (
      D => mgt_rxdata_115(34),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(50)
    );
  BU2_U0_receiver_recoder_rxd_pipe_39 : FDS
    port map (
      D => mgt_rxdata_115(7),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(39)
    );
  BU2_U0_receiver_recoder_rxd_pipe_44 : FDR
    port map (
      D => mgt_rxdata_115(20),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(44)
    );
  BU2_U0_receiver_recoder_rxd_pipe_38 : FDR
    port map (
      D => mgt_rxdata_115(6),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(38)
    );
  BU2_U0_receiver_recoder_rxd_pipe_37 : FDR
    port map (
      D => mgt_rxdata_115(5),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(37)
    );
  BU2_U0_receiver_recoder_rxd_pipe_42 : FDR
    port map (
      D => mgt_rxdata_115(18),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(42)
    );
  BU2_U0_receiver_recoder_rxd_pipe_43 : FDR
    port map (
      D => mgt_rxdata_115(19),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(43)
    );
  BU2_U0_receiver_recoder_rxd_pipe_36 : FDS
    port map (
      D => mgt_rxdata_115(4),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(36)
    );
  BU2_U0_receiver_recoder_rxd_pipe_41 : FDR
    port map (
      D => mgt_rxdata_115(17),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(41)
    );
  BU2_U0_receiver_recoder_rxd_pipe_40 : FDR
    port map (
      D => mgt_rxdata_115(16),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(40)
    );
  BU2_U0_receiver_recoder_rxd_pipe_29 : FDR
    port map (
      D => mgt_rxdata_115(61),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(29)
    );
  BU2_U0_receiver_recoder_rxd_pipe_35 : FDS
    port map (
      D => mgt_rxdata_115(3),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(35)
    );
  BU2_U0_receiver_recoder_rxd_pipe_34 : FDS
    port map (
      D => mgt_rxdata_115(2),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(34)
    );
  BU2_U0_receiver_recoder_rxd_pipe_28 : FDR
    port map (
      D => mgt_rxdata_115(60),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(28)
    );
  BU2_U0_receiver_recoder_rxd_pipe_27 : FDR
    port map (
      D => mgt_rxdata_115(59),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(27)
    );
  BU2_U0_receiver_recoder_rxd_pipe_32 : FDR
    port map (
      D => mgt_rxdata_115(0),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(32)
    );
  BU2_U0_receiver_recoder_rxd_pipe_33 : FDR
    port map (
      D => mgt_rxdata_115(1),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(33)
    );
  BU2_U0_receiver_recoder_rxd_pipe_26 : FDR
    port map (
      D => mgt_rxdata_115(58),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(26)
    );
  BU2_U0_receiver_recoder_rxd_pipe_31 : FDR
    port map (
      D => mgt_rxdata_115(63),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(31)
    );
  BU2_U0_receiver_recoder_rxd_pipe_25 : FDR
    port map (
      D => mgt_rxdata_115(57),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(25)
    );
  BU2_U0_receiver_recoder_rxd_pipe_30 : FDR
    port map (
      D => mgt_rxdata_115(62),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(30)
    );
  BU2_U0_receiver_recoder_rxd_pipe_19 : FDR
    port map (
      D => mgt_rxdata_115(43),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(19)
    );
  BU2_U0_receiver_recoder_rxd_pipe_24 : FDS
    port map (
      D => mgt_rxdata_115(56),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(24)
    );
  BU2_U0_receiver_recoder_rxd_pipe_23 : FDR
    port map (
      D => mgt_rxdata_115(47),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(23)
    );
  BU2_U0_receiver_recoder_rxd_pipe_17 : FDR
    port map (
      D => mgt_rxdata_115(41),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(17)
    );
  BU2_U0_receiver_recoder_rxd_pipe_18 : FDR
    port map (
      D => mgt_rxdata_115(42),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(18)
    );
  BU2_U0_receiver_recoder_rxd_pipe_22 : FDR
    port map (
      D => mgt_rxdata_115(46),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(22)
    );
  BU2_U0_receiver_recoder_rxd_pipe_16 : FDR
    port map (
      D => mgt_rxdata_115(40),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(16)
    );
  BU2_U0_receiver_recoder_rxd_pipe_15 : FDR
    port map (
      D => mgt_rxdata_115(31),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(15)
    );
  BU2_U0_receiver_recoder_rxd_pipe_20 : FDR
    port map (
      D => mgt_rxdata_115(44),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(20)
    );
  BU2_U0_receiver_recoder_rxd_pipe_21 : FDR
    port map (
      D => mgt_rxdata_115(45),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(21)
    );
  BU2_U0_receiver_recoder_rxd_pipe_14 : FDR
    port map (
      D => mgt_rxdata_115(30),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(14)
    );
  BU2_U0_receiver_recoder_rxd_pipe_13 : FDR
    port map (
      D => mgt_rxdata_115(29),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(13)
    );
  BU2_U0_receiver_recoder_code_error_pipe_7 : FDR
    port map (
      D => BU2_U0_receiver_code_error(7),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_code_error_pipe(7)
    );
  BU2_U0_receiver_recoder_code_error_pipe_6 : FDR
    port map (
      D => BU2_U0_receiver_code_error(6),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_code_error_pipe(6)
    );
  BU2_U0_receiver_recoder_code_error_pipe_5 : FDR
    port map (
      D => BU2_U0_receiver_code_error(5),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_code_error_pipe(5)
    );
  BU2_U0_receiver_recoder_code_error_pipe_4 : FDR
    port map (
      D => BU2_U0_receiver_code_error(4),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_code_error_pipe(4)
    );
  BU2_U0_receiver_recoder_code_error_pipe_3 : FDR
    port map (
      D => BU2_U0_receiver_code_error(3),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_code_error_pipe(3)
    );
  BU2_U0_receiver_recoder_code_error_pipe_2 : FDR
    port map (
      D => BU2_U0_receiver_code_error(2),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_code_error_pipe(2)
    );
  BU2_U0_receiver_recoder_code_error_pipe_1 : FDR
    port map (
      D => BU2_U0_receiver_code_error(1),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_code_error_pipe(1)
    );
  BU2_U0_receiver_recoder_code_error_pipe_0 : FDR
    port map (
      D => BU2_U0_receiver_code_error(0),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_code_error_pipe(0)
    );
  BU2_U0_receiver_recoder_rxd_pipe_12 : FDR
    port map (
      D => mgt_rxdata_115(28),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(12)
    );
  BU2_U0_receiver_recoder_rxd_pipe_10 : FDR
    port map (
      D => mgt_rxdata_115(26),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(10)
    );
  BU2_U0_receiver_recoder_rxd_pipe_11 : FDR
    port map (
      D => mgt_rxdata_115(27),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(11)
    );
  BU2_U0_receiver_recoder_rxd_out_7 : FDS
    port map (
      D => BU2_U0_receiver_recoder_mux0504,
      S => BU2_U0_receiver_recoder_or0012,
      C => usrclk,
      Q => xgmii_rxd_108(7)
    );
  BU2_U0_receiver_recoder_rxd_out_5 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_mux0502,
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_error_lane(0),
      C => usrclk,
      Q => xgmii_rxd_108(5)
    );
  BU2_U0_receiver_recoder_rxd_out_59 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_mux0501,
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_error_lane(7),
      C => usrclk,
      Q => xgmii_rxd_108(59)
    );
  BU2_U0_receiver_recoder_rxd_out_6 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_mux0503,
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_error_lane(0),
      C => usrclk,
      Q => xgmii_rxd_108(6)
    );
  BU2_U0_receiver_recoder_rxd_out_4 : FDS
    port map (
      D => BU2_U0_receiver_recoder_mux0500,
      S => BU2_U0_receiver_recoder_or0012,
      C => usrclk,
      Q => xgmii_rxd_108(4)
    );
  BU2_U0_receiver_recoder_rxd_out_3 : FDS
    port map (
      D => BU2_U0_receiver_recoder_mux0498,
      S => BU2_U0_receiver_recoder_or0012,
      C => usrclk,
      Q => xgmii_rxd_108(3)
    );
  BU2_U0_receiver_recoder_rxd_out_63 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_mux0499,
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_error_lane(7),
      C => usrclk,
      Q => xgmii_rxd_108(63)
    );
  BU2_U0_receiver_recoder_rxd_out_62 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_mux0497,
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_error_lane(7),
      C => usrclk,
      Q => xgmii_rxd_108(62)
    );
  BU2_U0_receiver_recoder_rxd_pipe_9 : FDR
    port map (
      D => mgt_rxdata_115(25),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(9)
    );
  BU2_U0_receiver_recoder_rxd_pipe_8 : FDR
    port map (
      D => mgt_rxdata_115(24),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(8)
    );
  BU2_U0_receiver_recoder_rxd_out_61 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_mux0495,
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_error_lane(7),
      C => usrclk,
      Q => xgmii_rxd_108(61)
    );
  BU2_U0_receiver_recoder_rxd_out_55 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_mux0494,
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_error_lane(6),
      C => usrclk,
      Q => xgmii_rxd_108(55)
    );
  BU2_U0_receiver_recoder_rxd_pipe_7 : FDS
    port map (
      D => mgt_rxdata_115(15),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(7)
    );
  BU2_U0_receiver_recoder_rxd_out_60 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_mux0493,
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_error_lane(7),
      C => usrclk,
      Q => xgmii_rxd_108(60)
    );
  BU2_U0_receiver_recoder_rxd_pipe_6 : FDR
    port map (
      D => mgt_rxdata_115(14),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(6)
    );
  BU2_U0_receiver_recoder_rxd_out_54 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_mux0492,
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_error_lane(6),
      C => usrclk,
      Q => xgmii_rxd_108(54)
    );
  BU2_U0_receiver_recoder_rxd_out_53 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_mux0491,
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_error_lane(6),
      C => usrclk,
      Q => xgmii_rxd_108(53)
    );
  BU2_U0_receiver_recoder_rxd_pipe_5 : FDR
    port map (
      D => mgt_rxdata_115(13),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(5)
    );
  BU2_U0_receiver_recoder_rxd_out_52 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_mux0489,
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_error_lane(6),
      C => usrclk,
      Q => xgmii_rxd_108(52)
    );
  BU2_U0_receiver_recoder_rxd_pipe_4 : FDS
    port map (
      D => mgt_rxdata_115(12),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(4)
    );
  BU2_U0_receiver_recoder_rxd_out_47 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_mux0490,
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_error_lane(5),
      C => usrclk,
      Q => xgmii_rxd_108(47)
    );
  BU2_U0_receiver_recoder_rxd_out_46 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_mux0488,
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_error_lane(5),
      C => usrclk,
      Q => xgmii_rxd_108(46)
    );
  BU2_U0_receiver_recoder_rxd_out_51 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_mux0487,
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_error_lane(6),
      C => usrclk,
      Q => xgmii_rxd_108(51)
    );
  BU2_U0_receiver_recoder_rxd_out_45 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_mux0486,
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_error_lane(5),
      C => usrclk,
      Q => xgmii_rxd_108(45)
    );
  BU2_U0_receiver_recoder_rxd_pipe_3 : FDS
    port map (
      D => mgt_rxdata_115(11),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(3)
    );
  BU2_U0_receiver_recoder_rxd_pipe_2 : FDS
    port map (
      D => mgt_rxdata_115(10),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(2)
    );
  BU2_U0_receiver_recoder_rxd_out_39 : FDS
    port map (
      D => BU2_U0_receiver_recoder_mux0485,
      S => BU2_U0_receiver_recoder_or0005,
      C => usrclk,
      Q => xgmii_rxd_108(39)
    );
  BU2_U0_receiver_recoder_rxd_pipe_1 : FDR
    port map (
      D => mgt_rxdata_115(9),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(1)
    );
  BU2_U0_receiver_recoder_rxd_out_38 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_mux0483,
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_error_lane(4),
      C => usrclk,
      Q => xgmii_rxd_108(38)
    );
  BU2_U0_receiver_recoder_rxd_out_44 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_mux0484,
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_error_lane(5),
      C => usrclk,
      Q => xgmii_rxd_108(44)
    );
  BU2_U0_receiver_recoder_rxd_out_43 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_mux0482,
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_error_lane(5),
      C => usrclk,
      Q => xgmii_rxd_108(43)
    );
  BU2_U0_receiver_recoder_rxd_pipe_0 : FDR
    port map (
      D => mgt_rxdata_115(8),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(0)
    );
  BU2_U0_receiver_recoder_rxd_out_36 : FDS
    port map (
      D => BU2_U0_receiver_recoder_mux0480,
      S => BU2_U0_receiver_recoder_or0005,
      C => usrclk,
      Q => xgmii_rxd_108(36)
    );
  BU2_U0_receiver_recoder_rxd_out_37 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_mux0481,
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_error_lane(4),
      C => usrclk,
      Q => xgmii_rxd_108(37)
    );
  BU2_U0_receiver_recoder_rxd_out_35 : FDS
    port map (
      D => BU2_U0_receiver_recoder_mux0479,
      S => BU2_U0_receiver_recoder_or0005,
      C => usrclk,
      Q => xgmii_rxd_108(35)
    );
  BU2_U0_receiver_recoder_rxd_out_29 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_mux0478,
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_error_lane(3),
      C => usrclk,
      Q => xgmii_rxd_108(29)
    );
  BU2_U0_receiver_recoder_rxd_out_27 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_mux0476,
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_error_lane(3),
      C => usrclk,
      Q => xgmii_rxd_108(27)
    );
  BU2_U0_receiver_recoder_rxd_out_28 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_mux0477,
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_error_lane(3),
      C => usrclk,
      Q => xgmii_rxd_108(28)
    );
  BU2_U0_receiver_recoder_rxc_pipe_7 : FDR
    port map (
      D => mgt_rxcharisk_116(6),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxc_pipe(7)
    );
  BU2_U0_receiver_recoder_rxd_out_31 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_mux0475,
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_error_lane(3),
      C => usrclk,
      Q => xgmii_rxd_108(31)
    );
  BU2_U0_receiver_recoder_rxd_out_30 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_mux0474,
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_error_lane(3),
      C => usrclk,
      Q => xgmii_rxd_108(30)
    );
  BU2_U0_receiver_recoder_rxc_pipe_6 : FDR
    port map (
      D => mgt_rxcharisk_116(4),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxc_pipe(6)
    );
  BU2_U0_receiver_recoder_rxc_pipe_5 : FDR
    port map (
      D => mgt_rxcharisk_116(2),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxc_pipe(5)
    );
  BU2_U0_receiver_recoder_rxd_out_19 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_mux0473,
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_error_lane(2),
      C => usrclk,
      Q => xgmii_rxd_108(19)
    );
  BU2_U0_receiver_recoder_rxd_out_23 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_mux0471,
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_error_lane(2),
      C => usrclk,
      Q => xgmii_rxd_108(23)
    );
  BU2_U0_receiver_recoder_rxd_out_22 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_mux0470,
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_error_lane(2),
      C => usrclk,
      Q => xgmii_rxd_108(22)
    );
  BU2_U0_receiver_recoder_rxc_pipe_4 : FDS
    port map (
      D => mgt_rxcharisk_116(0),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxc_pipe(4)
    );
  BU2_U0_receiver_recoder_rxc_pipe_3 : FDR
    port map (
      D => mgt_rxcharisk_116(7),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxc_pipe(3)
    );
  BU2_U0_receiver_recoder_rxc_pipe_2 : FDR
    port map (
      D => mgt_rxcharisk_116(5),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxc_pipe(2)
    );
  BU2_U0_receiver_recoder_rxd_out_15 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_mux0468,
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_error_lane(1),
      C => usrclk,
      Q => xgmii_rxd_108(15)
    );
  BU2_U0_receiver_recoder_rxd_out_21 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_mux0469,
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_error_lane(2),
      C => usrclk,
      Q => xgmii_rxd_108(21)
    );
  BU2_U0_receiver_recoder_rxd_out_20 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_mux0467,
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_error_lane(2),
      C => usrclk,
      Q => xgmii_rxd_108(20)
    );
  BU2_U0_receiver_recoder_rxc_pipe_1 : FDR
    port map (
      D => mgt_rxcharisk_116(3),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxc_pipe(1)
    );
  BU2_U0_receiver_recoder_rxc_pipe_0 : FDS
    port map (
      D => mgt_rxcharisk_116(1),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxc_pipe(0)
    );
  BU2_U0_receiver_recoder_rxd_out_14 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_mux0466,
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_error_lane(1),
      C => usrclk,
      Q => xgmii_rxd_108(14)
    );
  BU2_U0_receiver_recoder_rxd_out_13 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_mux0465,
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_error_lane(1),
      C => usrclk,
      Q => xgmii_rxd_108(13)
    );
  BU2_U0_receiver_recoder_rxd_out_12 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_mux0464,
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_error_lane(1),
      C => usrclk,
      Q => xgmii_rxd_108(12)
    );
  BU2_U0_receiver_recoder_lane_terminate_7 : FDR
    port map (
      D => BU2_U0_receiver_recoder_and0058,
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_lane_terminate(7)
    );
  BU2_U0_receiver_recoder_lane_terminate_6 : FDR
    port map (
      D => BU2_U0_receiver_recoder_and0056,
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_lane_terminate(6)
    );
  BU2_U0_receiver_recoder_lane_terminate_5 : FDR
    port map (
      D => BU2_U0_receiver_recoder_and0054,
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_lane_terminate(5)
    );
  BU2_U0_receiver_recoder_lane_terminate_4 : FDR
    port map (
      D => BU2_U0_receiver_recoder_and0062,
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_lane_terminate(4)
    );
  BU2_U0_receiver_recoder_lane_terminate_3 : FDR
    port map (
      D => BU2_U0_receiver_recoder_and0060,
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_lane_terminate(3)
    );
  BU2_U0_receiver_recoder_lane_terminate_2 : FDR
    port map (
      D => BU2_U0_receiver_recoder_and0059,
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_lane_terminate(2)
    );
  BU2_U0_receiver_recoder_lane_terminate_1 : FDR
    port map (
      D => BU2_U0_receiver_recoder_and0057,
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_lane_terminate(1)
    );
  BU2_U0_receiver_recoder_lane_terminate_0 : FDR
    port map (
      D => BU2_U0_receiver_recoder_and0055,
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_lane_terminate(0)
    );
  BU2_U0_receiver_recoder_rxd_out_11 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_mux0463,
      R => BU2_U0_or0001,
      S => BU2_U0_receiver_recoder_error_lane(1),
      C => usrclk,
      Q => xgmii_rxd_108(11)
    );
  BU2_U0_receiver_sync_ok_3 : FDR
    port map (
      D => BU2_U0_receiver_sync_ok_int(3),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => NlwRenamedSignal_status_vector(5)
    );
  BU2_U0_receiver_sync_ok_2 : FDR
    port map (
      D => BU2_U0_receiver_sync_ok_int(2),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => NlwRenamedSignal_status_vector(4)
    );
  BU2_U0_receiver_sync_ok_1 : FDR
    port map (
      D => BU2_U0_receiver_sync_ok_int(1),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => NlwRenamedSignal_status_vector(3)
    );
  BU2_U0_receiver_sync_ok_0 : FDR
    port map (
      D => BU2_U0_receiver_sync_ok_int(0),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => NlwRenamedSignal_status_vector(2)
    );
  BU2_U0_receiver_sync_status : FDR
    port map (
      D => BU2_U0_receiver_sync_status_int,
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_receiver_sync_status_97
    );
  BU2_U0_transmitter_align_prbs_1 : FDSE
    generic map(
      INIT => '1'
    )
    port map (
      D => BU2_U0_transmitter_align_xor0000,
      S => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_align_not0002,
      C => usrclk,
      Q => BU2_U0_transmitter_align_prbs(1)
    );
  BU2_U0_transmitter_align_prbs_7 : FDSE
    generic map(
      INIT => '1'
    )
    port map (
      D => BU2_U0_transmitter_align_prbs(6),
      S => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_align_not0002,
      C => usrclk,
      Q => BU2_U0_transmitter_align_prbs(7)
    );
  BU2_U0_transmitter_align_prbs_6 : FDSE
    generic map(
      INIT => '1'
    )
    port map (
      D => BU2_U0_transmitter_align_prbs(5),
      S => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_align_not0002,
      C => usrclk,
      Q => BU2_U0_transmitter_align_prbs(6)
    );
  BU2_U0_transmitter_align_prbs_5 : FDSE
    generic map(
      INIT => '1'
    )
    port map (
      D => BU2_U0_transmitter_align_prbs(4),
      S => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_align_not0002,
      C => usrclk,
      Q => BU2_U0_transmitter_align_prbs(5)
    );
  BU2_U0_transmitter_align_prbs_4 : FDSE
    generic map(
      INIT => '1'
    )
    port map (
      D => BU2_U0_transmitter_align_prbs(3),
      S => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_align_not0002,
      C => usrclk,
      Q => BU2_U0_transmitter_align_prbs(4)
    );
  BU2_U0_transmitter_align_prbs_3 : FDSE
    generic map(
      INIT => '1'
    )
    port map (
      D => BU2_U0_transmitter_align_prbs(2),
      S => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_align_not0002,
      C => usrclk,
      Q => BU2_U0_transmitter_align_prbs(3)
    );
  BU2_U0_transmitter_align_extra_a : FDRE
    port map (
      D => BU2_N1,
      R => BU2_U0_transmitter_align_or0000,
      CE => BU2_U0_transmitter_align_cmp_eq0000,
      C => usrclk,
      Q => BU2_U0_transmitter_align_extra_a_98
    );
  BU2_U0_transmitter_align_prbs_2 : FDSE
    generic map(
      INIT => '1'
    )
    port map (
      D => BU2_U0_transmitter_align_prbs(1),
      S => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_align_not0002,
      C => usrclk,
      Q => BU2_U0_transmitter_align_prbs(2)
    );
  BU2_U0_transmitter_align_count_4 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_transmitter_align_mux0002(4),
      R => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_align_not0001,
      C => usrclk,
      Q => BU2_U0_transmitter_align_count(4)
    );
  BU2_U0_transmitter_align_count_3 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_transmitter_align_mux0002(3),
      R => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_align_not0001,
      C => usrclk,
      Q => BU2_U0_transmitter_align_count(3)
    );
  BU2_U0_transmitter_align_count_2 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_transmitter_align_mux0002(2),
      R => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_align_not0001,
      C => usrclk,
      Q => BU2_U0_transmitter_align_count(2)
    );
  BU2_U0_transmitter_align_count_1 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_transmitter_align_mux0002(1),
      R => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_align_not0001,
      C => usrclk,
      Q => BU2_U0_transmitter_align_count(1)
    );
  BU2_U0_transmitter_align_count_0 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_transmitter_align_mux0002(0),
      R => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_transmitter_align_not0001,
      C => usrclk,
      Q => BU2_U0_transmitter_align_count(0)
    );
  BU2_U0_transmitter_seq_detect_i0_muxcy_i2 : MUXCY_L
    port map (
      CI => BU2_U0_transmitter_seq_detect_i0_muxcyo(1),
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_seq_detect_i0_comp(2),
      LO => BU2_U0_transmitter_tx_is_q_comb(0)
    );
  BU2_U0_transmitter_seq_detect_i0_muxcy_i1 : MUXCY_L
    port map (
      CI => BU2_U0_transmitter_seq_detect_i0_muxcyo(0),
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_seq_detect_i0_comp(1),
      LO => BU2_U0_transmitter_seq_detect_i0_muxcyo(1)
    );
  BU2_U0_transmitter_seq_detect_i0_muxcy_i0 : MUXCY_L
    port map (
      CI => BU2_N1,
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_seq_detect_i0_comp(0),
      LO => BU2_U0_transmitter_seq_detect_i0_muxcyo(0)
    );
  BU2_U0_transmitter_seq_detect_i1_muxcy_i2 : MUXCY_L
    port map (
      CI => BU2_U0_transmitter_seq_detect_i1_muxcyo(1),
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_seq_detect_i1_comp(2),
      LO => BU2_U0_transmitter_tx_is_q_comb(1)
    );
  BU2_U0_transmitter_seq_detect_i1_muxcy_i1 : MUXCY_L
    port map (
      CI => BU2_U0_transmitter_seq_detect_i1_muxcyo(0),
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_seq_detect_i1_comp(1),
      LO => BU2_U0_transmitter_seq_detect_i1_muxcyo(1)
    );
  BU2_U0_transmitter_seq_detect_i1_muxcy_i0 : MUXCY_L
    port map (
      CI => BU2_N1,
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_seq_detect_i1_comp(0),
      LO => BU2_U0_transmitter_seq_detect_i1_muxcyo(0)
    );
  BU2_U0_transmitter_k_r_prbs_i_prbs_1 : FDS
    port map (
      D => BU2_U0_transmitter_k_r_prbs_i_xor0000,
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_k_r_prbs_i_prbs(1)
    );
  BU2_U0_transmitter_k_r_prbs_i_prbs_8 : FDS
    port map (
      D => BU2_U0_transmitter_k_r_prbs_i_prbs(6),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_k_r_prbs_i_prbs(8)
    );
  BU2_U0_transmitter_k_r_prbs_i_prbs_6 : FDS
    port map (
      D => BU2_U0_transmitter_k_r_prbs_i_prbs(4),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_k_r_prbs_i_prbs(6)
    );
  BU2_U0_transmitter_k_r_prbs_i_prbs_4 : FDS
    port map (
      D => BU2_U0_transmitter_k_r_prbs_i_prbs(2),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_k_r_prbs_i_prbs(4)
    );
  BU2_U0_transmitter_k_r_prbs_i_prbs_2 : FDS
    port map (
      D => BU2_U0_transmitter_k_r_prbs_i_xor0001,
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_k_r_prbs_i_prbs(2)
    );
  BU2_U0_transmitter_k_r_prbs_i_prbs_7 : FDS
    port map (
      D => BU2_U0_transmitter_k_r_prbs_i_prbs(5),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_k_r_prbs_i_prbs(7)
    );
  BU2_U0_transmitter_k_r_prbs_i_prbs_5 : FDS
    port map (
      D => BU2_U0_transmitter_k_r_prbs_i_prbs(3),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_k_r_prbs_i_prbs(5)
    );
  BU2_U0_transmitter_k_r_prbs_i_prbs_3 : FDS
    port map (
      D => BU2_U0_transmitter_k_r_prbs_i_prbs(1),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_k_r_prbs_i_prbs(3)
    );
  BU2_U0_transmitter_tx_is_q_1 : FDR
    port map (
      D => BU2_U0_transmitter_tx_is_q_comb(1),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_tx_is_q(1)
    );
  BU2_U0_transmitter_tx_is_q_0 : FDR
    port map (
      D => BU2_U0_transmitter_tx_is_q_comb(0),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_tx_is_q(0)
    );
  BU2_U0_transmitter_tx_is_idle_1 : FDS
    port map (
      D => BU2_U0_transmitter_tx_is_idle_comb(1),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_tx_is_idle(1)
    );
  BU2_U0_transmitter_tx_is_idle_0 : FDS
    port map (
      D => BU2_U0_transmitter_tx_is_idle_comb(0),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_tx_is_idle(0)
    );
  BU2_U0_transmitter_txd_pipe_13 : FDR
    port map (
      D => xgmii_txd_113(13),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(13)
    );
  BU2_U0_transmitter_txd_pipe_12 : FDR
    port map (
      D => xgmii_txd_113(12),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(12)
    );
  BU2_U0_transmitter_txd_pipe_9 : FDS
    port map (
      D => xgmii_txd_113(9),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(9)
    );
  BU2_U0_transmitter_txd_pipe_10 : FDS
    port map (
      D => xgmii_txd_113(10),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(10)
    );
  BU2_U0_transmitter_txd_pipe_11 : FDR
    port map (
      D => xgmii_txd_113(11),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(11)
    );
  BU2_U0_transmitter_txd_pipe_8 : FDS
    port map (
      D => xgmii_txd_113(8),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(8)
    );
  BU2_U0_transmitter_txd_pipe_7 : FDR
    port map (
      D => xgmii_txd_113(7),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(7)
    );
  BU2_U0_transmitter_txd_pipe_5 : FDR
    port map (
      D => xgmii_txd_113(5),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(5)
    );
  BU2_U0_transmitter_txd_pipe_6 : FDR
    port map (
      D => xgmii_txd_113(6),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(6)
    );
  BU2_U0_transmitter_txd_pipe_4 : FDR
    port map (
      D => xgmii_txd_113(4),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(4)
    );
  BU2_U0_transmitter_txd_pipe_3 : FDR
    port map (
      D => xgmii_txd_113(3),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(3)
    );
  BU2_U0_transmitter_txd_pipe_1 : FDS
    port map (
      D => xgmii_txd_113(1),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(1)
    );
  BU2_U0_transmitter_txd_pipe_0 : FDS
    port map (
      D => xgmii_txd_113(0),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(0)
    );
  BU2_U0_transmitter_txd_pipe_2 : FDS
    port map (
      D => xgmii_txd_113(2),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(2)
    );
  BU2_U0_transmitter_txd_pipe_63 : FDR
    port map (
      D => xgmii_txd_113(63),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(63)
    );
  BU2_U0_transmitter_txd_pipe_58 : FDS
    port map (
      D => xgmii_txd_113(58),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(58)
    );
  BU2_U0_transmitter_txd_pipe_59 : FDR
    port map (
      D => xgmii_txd_113(59),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(59)
    );
  BU2_U0_transmitter_txd_pipe_57 : FDS
    port map (
      D => xgmii_txd_113(57),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(57)
    );
  BU2_U0_transmitter_txd_pipe_61 : FDR
    port map (
      D => xgmii_txd_113(61),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(61)
    );
  BU2_U0_transmitter_txd_pipe_62 : FDR
    port map (
      D => xgmii_txd_113(62),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(62)
    );
  BU2_U0_transmitter_txd_pipe_56 : FDS
    port map (
      D => xgmii_txd_113(56),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(56)
    );
  BU2_U0_transmitter_txd_pipe_55 : FDR
    port map (
      D => xgmii_txd_113(55),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(55)
    );
  BU2_U0_transmitter_txd_pipe_54 : FDR
    port map (
      D => xgmii_txd_113(54),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(54)
    );
  BU2_U0_transmitter_txd_pipe_60 : FDR
    port map (
      D => xgmii_txd_113(60),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(60)
    );
  BU2_U0_transmitter_txd_pipe_49 : FDS
    port map (
      D => xgmii_txd_113(49),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(49)
    );
  BU2_U0_transmitter_txd_pipe_53 : FDR
    port map (
      D => xgmii_txd_113(53),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(53)
    );
  BU2_U0_transmitter_txd_pipe_47 : FDR
    port map (
      D => xgmii_txd_113(47),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(47)
    );
  BU2_U0_transmitter_txd_pipe_52 : FDR
    port map (
      D => xgmii_txd_113(52),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(52)
    );
  BU2_U0_transmitter_txd_pipe_48 : FDS
    port map (
      D => xgmii_txd_113(48),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(48)
    );
  BU2_U0_transmitter_txd_pipe_46 : FDR
    port map (
      D => xgmii_txd_113(46),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(46)
    );
  BU2_U0_transmitter_txd_pipe_51 : FDR
    port map (
      D => xgmii_txd_113(51),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(51)
    );
  BU2_U0_transmitter_txd_pipe_50 : FDS
    port map (
      D => xgmii_txd_113(50),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(50)
    );
  BU2_U0_transmitter_txd_pipe_39 : FDR
    port map (
      D => xgmii_txd_113(39),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(39)
    );
  BU2_U0_transmitter_txd_pipe_45 : FDR
    port map (
      D => xgmii_txd_113(45),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(45)
    );
  BU2_U0_transmitter_txd_pipe_38 : FDR
    port map (
      D => xgmii_txd_113(38),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(38)
    );
  BU2_U0_transmitter_txd_pipe_43 : FDR
    port map (
      D => xgmii_txd_113(43),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(43)
    );
  BU2_U0_transmitter_txd_pipe_44 : FDR
    port map (
      D => xgmii_txd_113(44),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(44)
    );
  BU2_U0_transmitter_txd_pipe_42 : FDS
    port map (
      D => xgmii_txd_113(42),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(42)
    );
  BU2_U0_transmitter_txd_pipe_36 : FDR
    port map (
      D => xgmii_txd_113(36),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(36)
    );
  BU2_U0_transmitter_txd_pipe_37 : FDR
    port map (
      D => xgmii_txd_113(37),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(37)
    );
  BU2_U0_transmitter_txd_pipe_41 : FDS
    port map (
      D => xgmii_txd_113(41),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(41)
    );
  BU2_U0_transmitter_txd_pipe_35 : FDR
    port map (
      D => xgmii_txd_113(35),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(35)
    );
  BU2_U0_transmitter_txd_pipe_29 : FDR
    port map (
      D => xgmii_txd_113(29),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(29)
    );
  BU2_U0_transmitter_txd_pipe_34 : FDS
    port map (
      D => xgmii_txd_113(34),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(34)
    );
  BU2_U0_transmitter_txd_pipe_40 : FDS
    port map (
      D => xgmii_txd_113(40),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(40)
    );
  BU2_U0_transmitter_txd_pipe_28 : FDR
    port map (
      D => xgmii_txd_113(28),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(28)
    );
  BU2_U0_transmitter_txd_pipe_33 : FDS
    port map (
      D => xgmii_txd_113(33),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(33)
    );
  BU2_U0_transmitter_txd_pipe_32 : FDS
    port map (
      D => xgmii_txd_113(32),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(32)
    );
  BU2_U0_transmitter_txd_pipe_31 : FDR
    port map (
      D => xgmii_txd_113(31),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(31)
    );
  BU2_U0_transmitter_txd_pipe_27 : FDR
    port map (
      D => xgmii_txd_113(27),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(27)
    );
  BU2_U0_transmitter_txd_pipe_26 : FDS
    port map (
      D => xgmii_txd_113(26),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(26)
    );
  BU2_U0_transmitter_txc_pipe_7 : FDS
    port map (
      D => xgmii_txc_114(7),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txc_pipe(7)
    );
  BU2_U0_transmitter_txc_pipe_6 : FDS
    port map (
      D => xgmii_txc_114(6),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txc_pipe(6)
    );
  BU2_U0_transmitter_txc_pipe_5 : FDS
    port map (
      D => xgmii_txc_114(5),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txc_pipe(5)
    );
  BU2_U0_transmitter_txc_pipe_4 : FDS
    port map (
      D => xgmii_txc_114(4),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txc_pipe(4)
    );
  BU2_U0_transmitter_txc_pipe_3 : FDS
    port map (
      D => xgmii_txc_114(3),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txc_pipe(3)
    );
  BU2_U0_transmitter_txc_pipe_2 : FDS
    port map (
      D => xgmii_txc_114(2),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txc_pipe(2)
    );
  BU2_U0_transmitter_txc_pipe_1 : FDS
    port map (
      D => xgmii_txc_114(1),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txc_pipe(1)
    );
  BU2_U0_transmitter_txc_pipe_0 : FDS
    port map (
      D => xgmii_txc_114(0),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txc_pipe(0)
    );
  BU2_U0_transmitter_txd_pipe_25 : FDS
    port map (
      D => xgmii_txd_113(25),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(25)
    );
  BU2_U0_transmitter_txd_pipe_19 : FDR
    port map (
      D => xgmii_txd_113(19),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(19)
    );
  BU2_U0_transmitter_txd_pipe_30 : FDR
    port map (
      D => xgmii_txd_113(30),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(30)
    );
  BU2_U0_transmitter_txd_pipe_23 : FDR
    port map (
      D => xgmii_txd_113(23),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(23)
    );
  BU2_U0_transmitter_txd_pipe_18 : FDS
    port map (
      D => xgmii_txd_113(18),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(18)
    );
  BU2_U0_transmitter_txd_pipe_24 : FDS
    port map (
      D => xgmii_txd_113(24),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(24)
    );
  BU2_U0_transmitter_txd_pipe_17 : FDS
    port map (
      D => xgmii_txd_113(17),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(17)
    );
  BU2_U0_transmitter_txd_pipe_21 : FDR
    port map (
      D => xgmii_txd_113(21),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(21)
    );
  BU2_U0_transmitter_txd_pipe_22 : FDR
    port map (
      D => xgmii_txd_113(22),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(22)
    );
  BU2_U0_transmitter_txd_pipe_16 : FDS
    port map (
      D => xgmii_txd_113(16),
      S => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(16)
    );
  BU2_U0_transmitter_txd_pipe_15 : FDR
    port map (
      D => xgmii_txd_113(15),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(15)
    );
  BU2_U0_transmitter_txd_pipe_14 : FDR
    port map (
      D => xgmii_txd_113(14),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(14)
    );
  BU2_U0_transmitter_txd_pipe_20 : FDR
    port map (
      D => xgmii_txd_113(20),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(20)
    );
  BU2_U0_signal_detect_int_3 : FDS
    port map (
      D => signal_detect_122(3),
      S => BU2_U0_type_sel_reg(1),
      C => usrclk,
      Q => BU2_U0_signal_detect_int(3)
    );
  BU2_U0_signal_detect_int_2 : FDS
    port map (
      D => signal_detect_122(2),
      S => BU2_U0_type_sel_reg(1),
      C => usrclk,
      Q => BU2_U0_signal_detect_int(2)
    );
  BU2_U0_signal_detect_int_1 : FDS
    port map (
      D => signal_detect_122(1),
      S => BU2_U0_type_sel_reg(1),
      C => usrclk,
      Q => BU2_U0_signal_detect_int(1)
    );
  BU2_U0_signal_detect_int_0 : FDS
    port map (
      D => signal_detect_122(0),
      S => BU2_U0_type_sel_reg(1),
      C => usrclk,
      Q => BU2_U0_signal_detect_int(0)
    );
  BU2_U0_type_sel_reg_1 : FDRE
    port map (
      D => N0,
      R => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_type_sel_reg_done_inv,
      C => usrclk,
      Q => BU2_U0_type_sel_reg(1)
    );
  BU2_U0_rx_local_fault : FDRSE
    port map (
      D => BU2_mdio_tri,
      R => BU2_U0_usrclk_reset_104,
      S => BU2_U0_or0002_99,
      CE => BU2_U0_clear_local_fault_edge_106,
      C => usrclk,
      Q => status_vector(1)
    );
  BU2_U0_type_sel_reg_done : FDRE
    port map (
      D => BU2_N1,
      R => BU2_U0_usrclk_reset_2_103,
      CE => BU2_U0_type_sel_reg_done_inv,
      C => usrclk,
      Q => BU2_U0_type_sel_reg_done_100
    );
  BU2_U0_last_value0 : FDR
    port map (
      D => configuration_vector_123(3),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_last_value0_101
    );
  BU2_U0_tx_local_fault : FDRSE
    port map (
      D => BU2_mdio_tri,
      R => BU2_U0_usrclk_reset_104,
      S => BU2_U0_not0000,
      CE => BU2_U0_clear_local_fault_edge_106,
      C => usrclk,
      Q => status_vector(0)
    );
  BU2_U0_last_value : FDR
    port map (
      D => configuration_vector_123(2),
      R => BU2_U0_usrclk_reset_2_103,
      C => usrclk,
      Q => BU2_U0_last_value_102
    );
  BU2_U0_usrclk_reset : FDS
    generic map(
      INIT => '1'
    )
    port map (
      D => BU2_U0_usrclk_reset_pipe_105,
      S => reset,
      C => usrclk,
      Q => BU2_U0_usrclk_reset_104
    );
  BU2_U0_aligned_sticky : FDRE
    port map (
      D => BU2_N1,
      R => BU2_U0_or0001,
      CE => BU2_U0_clear_aligned_edge_107,
      C => usrclk,
      Q => status_vector(7)
    );
  BU2_U0_usrclk_reset_pipe : FDR
    generic map(
      INIT => '1'
    )
    port map (
      D => BU2_N1,
      R => BU2_U0_reset_inv,
      C => usrclk,
      Q => BU2_U0_usrclk_reset_pipe_105
    );
  BU2_U0_clear_local_fault_edge : FDR
    port map (
      D => BU2_N1,
      R => BU2_U0_or0003,
      C => usrclk,
      Q => BU2_U0_clear_local_fault_edge_106
    );
  BU2_U0_clear_aligned_edge : FDR
    port map (
      D => BU2_N1,
      R => BU2_U0_or0000,
      C => usrclk,
      Q => BU2_U0_clear_aligned_edge_107
    );
  BU2_XST_VCC : VCC
    port map (
      P => BU2_N1
    );
  BU2_XST_GND : GND
    port map (
      G => BU2_mdio_tri
    );

end STRUCTURE;

-- synopsys translate_on
