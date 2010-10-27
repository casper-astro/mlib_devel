-- The synopsys directives "translate_off/translate_on" specified
-- below are supported by XST, FPGA Compiler II, Mentor Graphics and Synplicity
-- synthesis tools. Ensure they are correct for your synthesis tool(s).

-- synopsys translate_off

--------------------------------------------------------------------------------
-- Copyright (c) 1995-2005 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor: Xilinx
-- \   \   \/     Version: H.42
--  \   \         Application: netgen
--  /   /         Filename: xaui_if.vhd
-- /___/   /\     Timestamp: Thu Dec  8 17:08:43 2005
-- \   \  /  \ 
--  \___\/\___\
--             
-- Command	: -intstyle ise -w -sim -ofmt vhdl /vol/hitz/home/droz/XAUI_interface/Coregen/XAUI/coregen/tmp/_cg/xaui_if.ngc /vol/hitz/home/droz/XAUI_interface/Coregen/XAUI/coregen/tmp/_cg/xaui_if.vhd 
-- Device	: 2vp70ff1704-7
-- Input file	: /vol/hitz/home/droz/XAUI_interface/Coregen/XAUI/coregen/tmp/_cg/xaui_if.ngc
-- Output file	: /vol/hitz/home/droz/XAUI_interface/Coregen/XAUI/coregen/tmp/_cg/xaui_if.vhd
-- # of Entities	: 1
-- Design Name	: xaui_if
-- Xilinx	: /tools/commercial/xilinx/ISE7.1i
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
--     Synthesis and Verification Design Guide, Chapter 6
--             
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity XAUI_IF is
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
end XAUI_IF;

architecture STRUCTURE of XAUI_IF is

  type STD_LOGIC_VECTOR1 is array (natural range <>) of STD_LOGIC;
  type STD_LOGIC_VECTOR2 is array (natural range <>, natural range <>) of STD_LOGIC;
  type STD_LOGIC_VECTOR3 is array (natural range <>, natural range <>, natural range <>) of STD_LOGIC;
  type STD_LOGIC_VECTOR4 is array (natural range <>, natural range <>, natural range <>, natural range <>) of STD_LOGIC;

  signal N0 : STD_LOGIC; 
  signal N1 : STD_LOGIC; 
  signal NlwRenamedSig_OI_align_status : STD_LOGIC; 
  signal BU2_N3646 : STD_LOGIC; 
  signal BU2_N3647 : STD_LOGIC; 
  signal BU2_N3556 : STD_LOGIC; 
  signal BU2_CHOICE1076 : STD_LOGIC; 
  signal BU2_N3698 : STD_LOGIC; 
  signal BU2_CHOICE1466 : STD_LOGIC; 
  signal BU2_N3695 : STD_LOGIC; 
  signal BU2_N3554 : STD_LOGIC; 
  signal BU2_CHOICE1067 : STD_LOGIC; 
  signal BU2_CHOICE1452 : STD_LOGIC; 
  signal BU2_CHOICE1648 : STD_LOGIC; 
  signal BU2_CHOICE1606 : STD_LOGIC; 
  signal BU2_CHOICE1056 : STD_LOGIC; 
  signal BU2_N3696 : STD_LOGIC; 
  signal BU2_CHOICE1584 : STD_LOGIC; 
  signal BU2_N3137 : STD_LOGIC; 
  signal BU2_N3694 : STD_LOGIC; 
  signal BU2_CHOICE1050 : STD_LOGIC; 
  signal BU2_CHOICE1406 : STD_LOGIC; 
  signal BU2_CHOICE1401 : STD_LOGIC; 
  signal BU2_CHOICE1395 : STD_LOGIC; 
  signal BU2_CHOICE1640 : STD_LOGIC; 
  signal BU2_N3690 : STD_LOGIC; 
  signal BU2_CHOICE1522 : STD_LOGIC; 
  signal BU2_CHOICE1556 : STD_LOGIC; 
  signal BU2_CHOICE1550 : STD_LOGIC; 
  signal BU2_CHOICE1438 : STD_LOGIC; 
  signal BU2_N3693 : STD_LOGIC; 
  signal BU2_CHOICE1578 : STD_LOGIC; 
  signal BU2_CHOICE1048 : STD_LOGIC; 
  signal BU2_CHOICE1528 : STD_LOGIC; 
  signal BU2_N3687 : STD_LOGIC; 
  signal BU2_CHOICE1612 : STD_LOGIC; 
  signal BU2_N3157 : STD_LOGIC; 
  signal BU2_N3686 : STD_LOGIC; 
  signal BU2_CHOICE2029 : STD_LOGIC; 
  signal BU2_CHOICE1043 : STD_LOGIC; 
  signal BU2_CHOICE1444 : STD_LOGIC; 
  signal BU2_N3699 : STD_LOGIC; 
  signal BU2_CHOICE1634 : STD_LOGIC; 
  signal BU2_N3684 : STD_LOGIC; 
  signal BU2_CHOICE1508 : STD_LOGIC; 
  signal BU2_CHOICE1500 : STD_LOGIC; 
  signal BU2_CHOICE1039 : STD_LOGIC; 
  signal BU2_CHOICE1253 : STD_LOGIC; 
  signal BU2_CHOICE1085 : STD_LOGIC; 
  signal BU2_CHOICE1924 : STD_LOGIC; 
  signal BU2_CHOICE1926 : STD_LOGIC; 
  signal BU2_CHOICE1033 : STD_LOGIC; 
  signal BU2_N3680 : STD_LOGIC; 
  signal BU2_CHOICE1233 : STD_LOGIC; 
  signal BU2_N3552 : STD_LOGIC; 
  signal BU2_CHOICE1029 : STD_LOGIC; 
  signal BU2_CHOICE1838 : STD_LOGIC; 
  signal BU2_CHOICE1842 : STD_LOGIC; 
  signal BU2_CHOICE1023 : STD_LOGIC; 
  signal BU2_CHOICE1337 : STD_LOGIC; 
  signal BU2_N3679 : STD_LOGIC; 
  signal BU2_CHOICE1935 : STD_LOGIC; 
  signal BU2_CHOICE1929 : STD_LOGIC; 
  signal BU2_CHOICE1365 : STD_LOGIC; 
  signal BU2_CHOICE1019 : STD_LOGIC; 
  signal BU2_CHOICE1152 : STD_LOGIC; 
  signal BU2_CHOICE1933 : STD_LOGIC; 
  signal BU2_CHOICE1288 : STD_LOGIC; 
  signal BU2_N3450 : STD_LOGIC; 
  signal BU2_N3448 : STD_LOGIC; 
  signal BU2_N1817 : STD_LOGIC; 
  signal BU2_CHOICE1232 : STD_LOGIC; 
  signal BU2_CHOICE1013 : STD_LOGIC; 
  signal BU2_CHOICE1851 : STD_LOGIC; 
  signal BU2_CHOICE1847 : STD_LOGIC; 
  signal BU2_N3550 : STD_LOGIC; 
  signal BU2_CHOICE1112 : STD_LOGIC; 
  signal BU2_N3546 : STD_LOGIC; 
  signal BU2_CHOICE1009 : STD_LOGIC; 
  signal BU2_CHOICE1316 : STD_LOGIC; 
  signal BU2_N3642 : STD_LOGIC; 
  signal BU2_CHOICE1318 : STD_LOGIC; 
  signal BU2_CHOICE1309 : STD_LOGIC; 
  signal BU2_N3548 : STD_LOGIC; 
  signal BU2_CHOICE1130 : STD_LOGIC; 
  signal BU2_N3683 : STD_LOGIC; 
  signal BU2_CHOICE1290 : STD_LOGIC; 
  signal BU2_CHOICE1857 : STD_LOGIC; 
  signal BU2_CHOICE1003 : STD_LOGIC; 
  signal BU2_CHOICE1094 : STD_LOGIC; 
  signal BU2_CHOICE2071 : STD_LOGIC; 
  signal BU2_N3494 : STD_LOGIC; 
  signal BU2_CHOICE1281 : STD_LOGIC; 
  signal BU2_N3446 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n04681 : STD_LOGIC; 
  signal BU2_N3702 : STD_LOGIC; 
  signal BU2_CHOICE1861 : STD_LOGIC; 
  signal BU2_CHOICE1177 : STD_LOGIC; 
  signal BU2_CHOICE999 : STD_LOGIC; 
  signal BU2_CHOICE1058 : STD_LOGIC; 
  signal BU2_N3688 : STD_LOGIC; 
  signal BU2_CHOICE1374 : STD_LOGIC; 
  signal BU2_N971 : STD_LOGIC; 
  signal BU2_N3540 : STD_LOGIC; 
  signal BU2_CHOICE993 : STD_LOGIC; 
  signal BU2_N3675 : STD_LOGIC; 
  signal BU2_CHOICE1372 : STD_LOGIC; 
  signal BU2_CHOICE1262 : STD_LOGIC; 
  signal BU2_CHOICE1260 : STD_LOGIC; 
  signal BU2_CHOICE1800 : STD_LOGIC; 
  signal BU2_CHOICE1807 : STD_LOGIC; 
  signal BU2_N3538 : STD_LOGIC; 
  signal BU2_CHOICE1197 : STD_LOGIC; 
  signal BU2_CHOICE2059 : STD_LOGIC; 
  signal BU2_CHOICE2052 : STD_LOGIC; 
  signal BU2_CHOICE989 : STD_LOGIC; 
  signal BU2_CHOICE1103 : STD_LOGIC; 
  signal BU2_N3326 : STD_LOGIC; 
  signal BU2_CHOICE2064 : STD_LOGIC; 
  signal BU2_CHOICE1954 : STD_LOGIC; 
  signal BU2_CHOICE1948 : STD_LOGIC; 
  signal BU2_N361 : STD_LOGIC; 
  signal BU2_N3480 : STD_LOGIC; 
  signal BU2_N2049 : STD_LOGIC; 
  signal BU2_U0_transmitter_align_n0005 : STD_LOGIC; 
  signal BU2_U0_transmitter_align_extra_a : STD_LOGIC; 
  signal BU2_N3544 : STD_LOGIC; 
  signal BU2_CHOICE1121 : STD_LOGIC; 
  signal BU2_N30 : STD_LOGIC; 
  signal BU2_N154 : STD_LOGIC; 
  signal BU2_N133 : STD_LOGIC; 
  signal BU2_N112 : STD_LOGIC; 
  signal BU2_N3139 : STD_LOGIC; 
  signal BU2_CHOICE1844 : STD_LOGIC; 
  signal BU2_CHOICE1853 : STD_LOGIC; 
  signal BU2_N28 : STD_LOGIC; 
  signal BU2_N91 : STD_LOGIC; 
  signal BU2_N70 : STD_LOGIC; 
  signal BU2_N49 : STD_LOGIC; 
  signal BU2_CHOICE1952 : STD_LOGIC; 
  signal BU2_CHOICE1346 : STD_LOGIC; 
  signal BU2_CHOICE1344 : STD_LOGIC; 
  signal BU2_U0_receiver_non_iee_deskew_state_n0022 : STD_LOGIC; 
  signal BU2_U0_receiver_non_iee_deskew_state_n0023 : STD_LOGIC; 
  signal BU2_N172 : STD_LOGIC; 
  signal BU2_N188 : STD_LOGIC; 
  signal BU2_N3120 : STD_LOGIC; 
  signal BU2_N3161 : STD_LOGIC; 
  signal BU2_N3700 : STD_LOGIC; 
  signal BU2_N3164 : STD_LOGIC; 
  signal BU2_CHOICE2115 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_n0060 : STD_LOGIC; 
  signal BU2_N3665 : STD_LOGIC; 
  signal BU2_CHOICE2153 : STD_LOGIC; 
  signal BU2_CHOICE2148 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_N12 : STD_LOGIC; 
  signal BU2_N3558 : STD_LOGIC; 
  signal BU2_N3566 : STD_LOGIC; 
  signal BU2_CHOICE1176 : STD_LOGIC; 
  signal BU2_N3664 : STD_LOGIC; 
  signal BU2_N1109 : STD_LOGIC; 
  signal BU2_N1108 : STD_LOGIC; 
  signal BU2_N3663 : STD_LOGIC; 
  signal BU2_CHOICE1388 : STD_LOGIC; 
  signal BU2_CHOICE1382 : STD_LOGIC; 
  signal BU2_N3667 : STD_LOGIC; 
  signal BU2_N3662 : STD_LOGIC; 
  signal BU2_N3661 : STD_LOGIC; 
  signal BU2_N3466 : STD_LOGIC; 
  signal BU2_U0_transmitter_k_r_prbs_i_n0008 : STD_LOGIC; 
  signal BU2_U0_transmitter_k_r_prbs_i_n0009 : STD_LOGIC; 
  signal BU2_N3141 : STD_LOGIC; 
  signal BU2_CHOICE1943 : STD_LOGIC; 
  signal BU2_CHOICE1939 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0421 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0416 : STD_LOGIC; 
  signal BU2_N3626 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0404 : STD_LOGIC; 
  signal BU2_N3624 : STD_LOGIC; 
  signal BU2_N3112 : STD_LOGIC; 
  signal BU2_N3622 : STD_LOGIC; 
  signal BU2_N3564 : STD_LOGIC; 
  signal BU2_N3562 : STD_LOGIC; 
  signal BU2_N3560 : STD_LOGIC; 
  signal BU2_N3514 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0393 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0392 : STD_LOGIC; 
  signal BU2_U0_transmitter_align_n0007 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0394 : STD_LOGIC; 
  signal BU2_N1065 : STD_LOGIC; 
  signal BU2_N3113 : STD_LOGIC; 
  signal BU2_CHOICE1833 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0398 : STD_LOGIC; 
  signal BU2_N3596 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0399 : STD_LOGIC; 
  signal BU2_N1088 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0415 : STD_LOGIC; 
  signal BU2_N1805 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0401 : STD_LOGIC; 
  signal BU2_N3114 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0403 : STD_LOGIC; 
  signal BU2_N3594 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0410 : STD_LOGIC; 
  signal BU2_N969 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0405 : STD_LOGIC; 
  signal BU2_N2856 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0406 : STD_LOGIC; 
  signal BU2_N1085 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0407 : STD_LOGIC; 
  signal BU2_N3115 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0409 : STD_LOGIC; 
  signal BU2_N3592 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0453 : STD_LOGIC; 
  signal BU2_N959 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0411 : STD_LOGIC; 
  signal BU2_N2854 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0412 : STD_LOGIC; 
  signal BU2_N3508 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0413 : STD_LOGIC; 
  signal BU2_N3590 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0414 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0448 : STD_LOGIC; 
  signal BU2_N1803 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0419 : STD_LOGIC; 
  signal BU2_N3640 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0417 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0418 : STD_LOGIC; 
  signal BU2_N3506 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0422 : STD_LOGIC; 
  signal BU2_N3638 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0420 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0427 : STD_LOGIC; 
  signal BU2_N1815 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0426 : STD_LOGIC; 
  signal BU2_N3636 : STD_LOGIC; 
  signal BU2_N3116 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0424 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0425 : STD_LOGIC; 
  signal BU2_N3606 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0428 : STD_LOGIC; 
  signal BU2_N3634 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0435 : STD_LOGIC; 
  signal BU2_N1813 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0432 : STD_LOGIC; 
  signal BU2_N3632 : STD_LOGIC; 
  signal BU2_N3117 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0430 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0431 : STD_LOGIC; 
  signal BU2_N3604 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0441 : STD_LOGIC; 
  signal BU2_N3630 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0433 : STD_LOGIC; 
  signal BU2_N1076 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0434 : STD_LOGIC; 
  signal BU2_N3504 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0444 : STD_LOGIC; 
  signal BU2_N1811 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0436 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0437 : STD_LOGIC; 
  signal BU2_N3118 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0439 : STD_LOGIC; 
  signal BU2_N3588 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0440 : STD_LOGIC; 
  signal BU2_N3602 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0449 : STD_LOGIC; 
  signal BU2_N3628 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0442 : STD_LOGIC; 
  signal BU2_N2852 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0443 : STD_LOGIC; 
  signal BU2_N3502 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0397 : STD_LOGIC; 
  signal BU2_N973 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0445 : STD_LOGIC; 
  signal BU2_N3586 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0446 : STD_LOGIC; 
  signal BU2_N3678 : STD_LOGIC; 
  signal BU2_CHOICE1649 : STD_LOGIC; 
  signal BU2_N2858 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0450 : STD_LOGIC; 
  signal BU2_N3600 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_N13 : STD_LOGIC; 
  signal BU2_N3668 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0452 : STD_LOGIC; 
  signal BU2_N2780 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_N34 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0395 : STD_LOGIC; 
  signal BU2_N1809 : STD_LOGIC; 
  signal BU2_N1115 : STD_LOGIC; 
  signal BU2_N3510 : STD_LOGIC; 
  signal BU2_N1089 : STD_LOGIC; 
  signal BU2_N1067 : STD_LOGIC; 
  signal BU2_N3618 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0457 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0458 : STD_LOGIC; 
  signal BU2_N3616 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0459 : STD_LOGIC; 
  signal BU2_N3614 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0460 : STD_LOGIC; 
  signal BU2_N3644 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0461 : STD_LOGIC; 
  signal BU2_N3612 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0462 : STD_LOGIC; 
  signal BU2_N3610 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0463 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_N33 : STD_LOGIC; 
  signal BU2_CHOICE1975 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0464 : STD_LOGIC; 
  signal BU2_N3584 : STD_LOGIC; 
  signal BU2_N3608 : STD_LOGIC; 
  signal BU2_N3492 : STD_LOGIC; 
  signal BU2_N3524 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_state_1_2 : STD_LOGIC; 
  signal BU2_N3444 : STD_LOGIC; 
  signal BU2_N3659 : STD_LOGIC; 
  signal BU2_U0_transmitter_n0263 : STD_LOGIC; 
  signal BU2_CHOICE1813 : STD_LOGIC; 
  signal BU2_CHOICE1820 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_N35 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0454 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0455 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0456 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0478 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0479 : STD_LOGIC; 
  signal BU2_N3673 : STD_LOGIC; 
  signal BU2_CHOICE2069 : STD_LOGIC; 
  signal BU2_U0_transmitter_tqmsg_capture_1_n0005 : STD_LOGIC; 
  signal BU2_N3689 : STD_LOGIC; 
  signal BU2_CHOICE1620 : STD_LOGIC; 
  signal BU2_U0_transmitter_tqmsg_capture_1_n0013602 : STD_LOGIC; 
  signal BU2_U0_transmitter_tqmsg_capture_1_n0013 : STD_LOGIC; 
  signal BU2_U0_transmitter_tqmsg_capture_1_n000543 : STD_LOGIC; 
  signal BU2_CHOICE1424 : STD_LOGIC; 
  signal BU2_CHOICE1413 : STD_LOGIC; 
  signal BU2_U0_transmitter_clear_q_det : STD_LOGIC; 
  signal BU2_U0_transmitter_tqmsg_capture_1_n001360 : STD_LOGIC; 
  signal BU2_U0_transmitter_tqmsg_capture_1_n0013603 : STD_LOGIC; 
  signal BU2_U0_transmitter_seq_detect_i0_n0000 : STD_LOGIC; 
  signal BU2_U0_transmitter_seq_detect_i1_n0000 : STD_LOGIC; 
  signal BU2_U0_transmitter_idle_detect_i0_n0009 : STD_LOGIC; 
  signal BU2_U0_transmitter_idle_detect_i0_n0000 : STD_LOGIC; 
  signal BU2_U0_transmitter_idle_detect_i1_n0009 : STD_LOGIC; 
  signal BU2_U0_transmitter_idle_detect_i1_n0000 : STD_LOGIC; 
  signal BU2_CHOICE1593 : STD_LOGIC; 
  signal BU2_N3149 : STD_LOGIC; 
  signal BU2_N3125 : STD_LOGIC; 
  signal BU2_N3660 : STD_LOGIC; 
  signal BU2_CHOICE1592 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter0_n0001 : STD_LOGIC; 
  signal BU2_N3420 : STD_LOGIC; 
  signal BU2_CHOICE1537 : STD_LOGIC; 
  signal BU2_N3332 : STD_LOGIC; 
  signal BU2_N3674 : STD_LOGIC; 
  signal BU2_CHOICE1536 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter1_n0001 : STD_LOGIC; 
  signal BU2_N3414 : STD_LOGIC; 
  signal BU2_CHOICE1565 : STD_LOGIC; 
  signal BU2_N3542 : STD_LOGIC; 
  signal BU2_CHOICE1141 : STD_LOGIC; 
  signal BU2_N3658 : STD_LOGIC; 
  signal BU2_N3656 : STD_LOGIC; 
  signal BU2_CHOICE1480 : STD_LOGIC; 
  signal BU2_CHOICE1472 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter2_n0001 : STD_LOGIC; 
  signal BU2_N3398 : STD_LOGIC; 
  signal BU2_CHOICE1509 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter3_n0001 : STD_LOGIC; 
  signal BU2_CHOICE1481 : STD_LOGIC; 
  signal BU2_CHOICE2119 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_state_1_2_1 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_state_1_0_2 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_next_ifg_is_a : STD_LOGIC; 
  signal BU2_CHOICE1748 : STD_LOGIC; 
  signal BU2_CHOICE1755 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter4_n0001 : STD_LOGIC; 
  signal BU2_CHOICE1453 : STD_LOGIC; 
  signal BU2_CHOICE1564 : STD_LOGIC; 
  signal BU2_N3119 : STD_LOGIC; 
  signal BU2_N3620 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0481 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter5_n0001 : STD_LOGIC; 
  signal BU2_CHOICE1621 : STD_LOGIC; 
  signal BU2_CHOICE1494 : STD_LOGIC; 
  signal BU2_N3655 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter6_n0001 : STD_LOGIC; 
  signal BU2_N3350 : STD_LOGIC; 
  signal BU2_CHOICE1419 : STD_LOGIC; 
  signal BU2_N3654 : STD_LOGIC; 
  signal BU2_CHOICE1206 : STD_LOGIC; 
  signal BU2_CHOICE1204 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter7_n0001 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0491 : STD_LOGIC; 
  signal BU2_N3598 : STD_LOGIC; 
  signal BU2_N3129 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0475 : STD_LOGIC; 
  signal BU2_CHOICE1730 : STD_LOGIC; 
  signal BU2_N3133 : STD_LOGIC; 
  signal BU2_N3676 : STD_LOGIC; 
  signal BU2_CHOICE1690 : STD_LOGIC; 
  signal BU2_CHOICE2183 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0496 : STD_LOGIC; 
  signal BU2_N3169 : STD_LOGIC; 
  signal BU2_N3168 : STD_LOGIC; 
  signal BU2_N3436 : STD_LOGIC; 
  signal BU2_N3670 : STD_LOGIC; 
  signal BU2_N3482 : STD_LOGIC; 
  signal BU2_N3452 : STD_LOGIC; 
  signal BU2_N3701 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n04691 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0490 : STD_LOGIC; 
  signal BU2_N3143 : STD_LOGIC; 
  signal BU2_N3432 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0492 : STD_LOGIC; 
  signal BU2_N3344 : STD_LOGIC; 
  signal BU2_N3653 : STD_LOGIC; 
  signal BU2_CHOICE1735 : STD_LOGIC; 
  signal BU2_CHOICE1742 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0494 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0495 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0498 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0497 : STD_LOGIC; 
  signal BU2_N3652 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_state_0_0_1 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_state_1_1_1 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_state_1_0_1 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_state_0_1_1 : STD_LOGIC; 
  signal BU2_N3434 : STD_LOGIC; 
  signal BU2_U0_usrclk_reset_1 : STD_LOGIC; 
  signal BU2_CHOICE2065 : STD_LOGIC; 
  signal BU2_CHOICE2077 : STD_LOGIC; 
  signal BU2_U0_n00101 : STD_LOGIC; 
  signal BU2_N3672 : STD_LOGIC; 
  signal BU2_N3666 : STD_LOGIC; 
  signal BU2_N3145 : STD_LOGIC; 
  signal BU2_N3370 : STD_LOGIC; 
  signal BU2_N3651 : STD_LOGIC; 
  signal BU2_CHOICE1774 : STD_LOGIC; 
  signal BU2_CHOICE1781 : STD_LOGIC; 
  signal BU2_CHOICE2205 : STD_LOGIC; 
  signal BU2_N3127 : STD_LOGIC; 
  signal BU2_N3681 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0484 : STD_LOGIC; 
  signal BU2_N3691 : STD_LOGIC; 
  signal BU2_N3328 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0487 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0486 : STD_LOGIC; 
  signal BU2_N3692 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0488 : STD_LOGIC; 
  signal BU2_N3685 : STD_LOGIC; 
  signal BU2_N3697 : STD_LOGIC; 
  signal BU2_N3330 : STD_LOGIC; 
  signal BU2_N319 : STD_LOGIC; 
  signal BU2_N243 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0545 : STD_LOGIC; 
  signal BU2_N3522 : STD_LOGIC; 
  signal BU2_N996 : STD_LOGIC; 
  signal BU2_N262 : STD_LOGIC; 
  signal BU2_N3516 : STD_LOGIC; 
  signal BU2_CHOICE1909 : STD_LOGIC; 
  signal BU2_N300 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0549 : STD_LOGIC; 
  signal BU2_N994 : STD_LOGIC; 
  signal BU2_N281 : STD_LOGIC; 
  signal BU2_N992 : STD_LOGIC; 
  signal BU2_N224 : STD_LOGIC; 
  signal BU2_N3155 : STD_LOGIC; 
  signal BU2_N3123 : STD_LOGIC; 
  signal BU2_N1096 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0485 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0499 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0501 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0477 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0479 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0503 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0502 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0481 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0504 : STD_LOGIC; 
  signal BU2_U0_transmitter_align_n0006 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_state_1_0 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_state_1_1 : STD_LOGIC; 
  signal BU2_CHOICE2026 : STD_LOGIC; 
  signal BU2_CHOICE2024 : STD_LOGIC; 
  signal BU2_CHOICE2012 : STD_LOGIC; 
  signal BU2_N3131 : STD_LOGIC; 
  signal BU2_N3135 : STD_LOGIC; 
  signal BU2_N3159 : STD_LOGIC; 
  signal BU2_N3438 : STD_LOGIC; 
  signal BU2_N3358 : STD_LOGIC; 
  signal BU2_N3682 : STD_LOGIC; 
  signal BU2_CHOICE1761 : STD_LOGIC; 
  signal BU2_CHOICE1768 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0471 : STD_LOGIC; 
  signal BU2_CHOICE2046 : STD_LOGIC; 
  signal BU2_N3650 : STD_LOGIC; 
  signal BU2_CHOICE2043 : STD_LOGIC; 
  signal BU2_CHOICE2036 : STD_LOGIC; 
  signal BU2_CHOICE2035 : STD_LOGIC; 
  signal BU2_N2802 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0472 : STD_LOGIC; 
  signal BU2_N2800 : STD_LOGIC; 
  signal BU2_N2798 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0473 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0474 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0512 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0510 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0511 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0529 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0508 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_N40 : STD_LOGIC; 
  signal BU2_N1132 : STD_LOGIC; 
  signal BU2_N3520 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0551 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0507 : STD_LOGIC; 
  signal BU2_N1130 : STD_LOGIC; 
  signal BU2_N338 : STD_LOGIC; 
  signal BU2_N205 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_N39 : STD_LOGIC; 
  signal BU2_N1128 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0470 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0620 : STD_LOGIC; 
  signal BU2_N3166 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0469 : STD_LOGIC; 
  signal BU2_N3467 : STD_LOGIC; 
  signal BU2_N1138 : STD_LOGIC; 
  signal BU2_CHOICE2155 : STD_LOGIC; 
  signal BU2_U0_transmitter_tqmsg_capture_1_q_det : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0514 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0627 : STD_LOGIC; 
  signal BU2_CHOICE2007 : STD_LOGIC; 
  signal BU2_CHOICE2001 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_error_lane_5_Q : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0505 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0513 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0537 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0476 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0473 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_error_lane_6_Q : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0506 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0482 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0518 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0519 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0520 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0521 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0522 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0523 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0509 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0524 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0533 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0525 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0515 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0468 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0478 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0483 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0489 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0927 : STD_LOGIC; 
  signal BU2_N3677 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_N38 : STD_LOGIC; 
  signal BU2_CHOICE2142 : STD_LOGIC; 
  signal BU2_N3657 : STD_LOGIC; 
  signal BU2_CHOICE2201 : STD_LOGIC; 
  signal BU2_CHOICE2196 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0493 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_error_lane_2_Q : STD_LOGIC; 
  signal BU2_N3671 : STD_LOGIC; 
  signal BU2_CHOICE2179 : STD_LOGIC; 
  signal BU2_CHOICE2173 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0500 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0517 : STD_LOGIC; 
  signal BU2_CHOICE2108 : STD_LOGIC; 
  signal BU2_N3649 : STD_LOGIC; 
  signal BU2_CHOICE2111 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_error_lane_4_Q : STD_LOGIC; 
  signal BU2_N3648 : STD_LOGIC; 
  signal BU2_CHOICE1910 : STD_LOGIC; 
  signal BU2_CHOICE1915 : STD_LOGIC; 
  signal BU2_CHOICE1897 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0516 : STD_LOGIC; 
  signal BU2_U0_transmitter_recoder_n0400 : STD_LOGIC; 
  signal BU2_N1807 : STD_LOGIC; 
  signal BU2_CHOICE1890 : STD_LOGIC; 
  signal BU2_CHOICE1876 : STD_LOGIC; 
  signal BU2_CHOICE1881 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0480 : STD_LOGIC; 
  signal BU2_N3518 : STD_LOGIC; 
  signal BU2_N1126 : STD_LOGIC; 
  signal BU2_U0_transmitter_filter7_txc_out : STD_LOGIC; 
  signal BU2_U0_transmitter_filter6_txc_out : STD_LOGIC; 
  signal BU2_U0_transmitter_filter5_txc_out : STD_LOGIC; 
  signal BU2_U0_transmitter_filter4_txc_out : STD_LOGIC; 
  signal BU2_U0_transmitter_filter3_txc_out : STD_LOGIC; 
  signal BU2_U0_transmitter_filter2_txc_out : STD_LOGIC; 
  signal BU2_U0_transmitter_filter1_txc_out : STD_LOGIC; 
  signal BU2_U0_transmitter_filter0_txc_out : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_n0011 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_state_0_2 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_state_0_1 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_state_0_0 : STD_LOGIC; 
  signal BU2_U0_transmitter_state_machine_N4 : STD_LOGIC; 
  signal BU2_N922 : STD_LOGIC; 
  signal BU2_N3390 : STD_LOGIC; 
  signal BU2_N3669 : STD_LOGIC; 
  signal BU2_CHOICE1787 : STD_LOGIC; 
  signal BU2_CHOICE1794 : STD_LOGIC; 
  signal BU2_U0_transmitter_tqmsg_capture_1_n0013601 : STD_LOGIC; 
  signal BU2_U0_transmitter_seq_detect_i1_n0003 : STD_LOGIC; 
  signal BU2_U0_transmitter_seq_detect_i0_n0003 : STD_LOGIC; 
  signal BU2_U0_transmitter_n0095 : STD_LOGIC; 
  signal BU2_U0_transmitter_n0099 : STD_LOGIC; 
  signal BU2_CHOICE1920 : STD_LOGIC; 
  signal BU2_CHOICE1826 : STD_LOGIC; 
  signal BU2_CHOICE1375 : STD_LOGIC; 
  signal BU2_CHOICE1358 : STD_LOGIC; 
  signal BU2_CHOICE1347 : STD_LOGIC; 
  signal BU2_CHOICE1330 : STD_LOGIC; 
  signal BU2_N701 : STD_LOGIC; 
  signal BU2_CHOICE1291 : STD_LOGIC; 
  signal BU2_CHOICE1274 : STD_LOGIC; 
  signal BU2_CHOICE1319 : STD_LOGIC; 
  signal BU2_CHOICE1302 : STD_LOGIC; 
  signal BU2_CHOICE1263 : STD_LOGIC; 
  signal BU2_CHOICE1246 : STD_LOGIC; 
  signal BU2_N3512 : STD_LOGIC; 
  signal BU2_CHOICE1207 : STD_LOGIC; 
  signal BU2_CHOICE1190 : STD_LOGIC; 
  signal BU2_N3121 : STD_LOGIC; 
  signal BU2_CHOICE1235 : STD_LOGIC; 
  signal BU2_CHOICE1218 : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_error_lane_1_Q : STD_LOGIC; 
  signal BU2_U0_receiver_recoder_n0474 : STD_LOGIC; 
  signal BU2_CHOICE1179 : STD_LOGIC; 
  signal BU2_CHOICE1162 : STD_LOGIC; 
  signal BU2_U0_receiver_sync_status : STD_LOGIC; 
  signal BU2_N383 : STD_LOGIC; 
  signal BU2_N3536 : STD_LOGIC; 
  signal BU2_N2981 : STD_LOGIC; 
  signal BU2_U0_N4 : STD_LOGIC; 
  signal BU2_U0_n0010 : STD_LOGIC; 
  signal BU2_CHOICE1872 : STD_LOGIC; 
  signal BU2_CHOICE1870 : STD_LOGIC; 
  signal BU2_CHOICE1866 : STD_LOGIC; 
  signal BU2_U0_n0013 : STD_LOGIC; 
  signal BU2_U0_usrclk_reset_pipe : STD_LOGIC; 
  signal BU2_U0_clear_local_fault_edge : STD_LOGIC; 
  signal BU2_U0_usrclk_reset_pipe_N0 : STD_LOGIC; 
  signal BU2_U0_last_value0 : STD_LOGIC; 
  signal BU2_U0_transmitter_align_N4 : STD_LOGIC; 
  signal BU2_U0_clear_aligned_edge : STD_LOGIC; 
  signal BU2_U0_n0009 : STD_LOGIC; 
  signal BU2_U0_receiver_sync_status_int : STD_LOGIC; 
  signal BU2_U0_n0019 : STD_LOGIC; 
  signal BU2_U0_transmitter_align_n0024 : STD_LOGIC; 
  signal BU2_U0_transmitter_align_N3 : STD_LOGIC; 
  signal BU2_U0_n0014 : STD_LOGIC; 
  signal BU2_U0_last_value : STD_LOGIC; 
  signal BU2_U0_usrclk_reset : STD_LOGIC; 
  signal BU2_mdio_tri : STD_LOGIC; 
  signal NlwRenamedSignal_status_vector : STD_LOGIC_VECTOR ( 5 downto 2 ); 
  signal xgmii_rxd_0 : STD_LOGIC_VECTOR ( 63 downto 0 ); 
  signal xgmii_rxc_1 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal mgt_txdata_2 : STD_LOGIC_VECTOR ( 63 downto 0 ); 
  signal mgt_txcharisk_3 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal NlwRenamedSig_OI_mgt_enable_align : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal xgmii_txd_4 : STD_LOGIC_VECTOR ( 63 downto 0 ); 
  signal xgmii_txc_5 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal mgt_rxdata_6 : STD_LOGIC_VECTOR ( 63 downto 0 ); 
  signal mgt_rxcharisk_7 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal mgt_codevalid_8 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal mgt_codecomma_9 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal mgt_syncok_10 : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal mgt_tx_reset_11 : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal mgt_rx_reset_12 : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal signal_detect_13 : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal configuration_vector_14 : STD_LOGIC_VECTOR ( 6 downto 2 ); 
  signal NlwRenamedSignal_configuration_vector : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal BU2_U0_transmitter_align_count : STD_LOGIC_VECTOR ( 4 downto 0 ); 
  signal BU2_U0_transmitter_align_n0003 : STD_LOGIC_VECTOR ( 4 downto 0 ); 
  signal BU2_U0_transmitter_align_prbs : STD_LOGIC_VECTOR ( 7 downto 1 ); 
  signal BU2_U0_receiver_non_iee_deskew_state_deskew_error : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal BU2_U0_receiver_non_iee_deskew_state_got_align : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal BU2_U0_transmitter_tx_code_a : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal BU2_U0_transmitter_state_machine_next_state : STD_LOGIC_VECTOR2 ( 1 downto 1 , 2 downto 1 ); 
  signal BU2_U0_transmitter_state_machine_n0003 : STD_LOGIC_VECTOR ( 2 downto 0 ); 
  signal BU2_U0_transmitter_a_due : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal BU2_U0_transmitter_k_r_prbs_i_prbs : STD_LOGIC_VECTOR ( 8 downto 1 ); 
  signal BU2_U0_transmitter_tx_code_q : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal BU2_U0_transmitter_tx_code_d : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal BU2_U0_transmitter_tqmsg_capture_1_last_qmsg : STD_LOGIC_VECTOR ( 31 downto 0 ); 
  signal BU2_U0_transmitter_tqmsg_capture_1_n0004 : STD_LOGIC_VECTOR ( 31 downto 0 ); 
  signal BU2_U0_transmitter_seq_detect_i0_comp : STD_LOGIC_VECTOR ( 2 downto 1 ); 
  signal BU2_U0_transmitter_seq_detect_i1_comp : STD_LOGIC_VECTOR ( 2 downto 1 ); 
  signal BU2_U0_transmitter_idle_detect_i0_muxcyo : STD_LOGIC_VECTOR ( 7 downto 1 ); 
  signal BU2_U0_transmitter_idle_detect_i0_comp : STD_LOGIC_VECTOR ( 8 downto 1 ); 
  signal BU2_U0_transmitter_idle_detect_i1_muxcyo : STD_LOGIC_VECTOR ( 7 downto 1 ); 
  signal BU2_U0_transmitter_idle_detect_i1_comp : STD_LOGIC_VECTOR ( 8 downto 1 ); 
  signal BU2_U0_transmitter_filter0_txd_out : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_transmitter_filter0_n0007 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_transmitter_filter1_txd_out : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_transmitter_filter1_n0007 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_transmitter_filter2_txd_out : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_transmitter_filter2_n0007 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_transmitter_filter3_txd_out : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_transmitter_filter3_n0007 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_transmitter_filter4_txd_out : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_transmitter_filter4_n0007 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_transmitter_filter5_txd_out : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_transmitter_filter5_n0007 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_transmitter_filter6_txd_out : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_transmitter_filter6_n0007 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_transmitter_filter7_txd_out : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_transmitter_filter7_n0007 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_receiver_recoder_lane_term_pipe : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal BU2_U0_receiver_recoder_rxd_half_pipe : STD_LOGIC_VECTOR ( 31 downto 0 ); 
  signal BU2_U0_transmitter_is_terminate : STD_LOGIC_VECTOR ( 1 downto 1 ); 
  signal BU2_U0_receiver_recoder_code_error_pipe : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_receiver_recoder_lane_terminate : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_receiver_recoder_rxd_pipe : STD_LOGIC_VECTOR ( 63 downto 0 ); 
  signal BU2_U0_receiver_recoder_rxc_pipe : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_receiver_recoder_n0923 : STD_LOGIC_VECTOR ( 2 downto 1 ); 
  signal BU2_U0_receiver_recoder_rxc_half_pipe : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal BU2_U0_receiver_recoder_code_error_delay : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal BU2_U0_receiver_recoder_n0921 : STD_LOGIC_VECTOR ( 2 downto 1 ); 
  signal BU2_U0_transmitter_txd_pipe : STD_LOGIC_VECTOR ( 63 downto 0 ); 
  signal BU2_U0_transmitter_txc_pipe : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_transmitter_seq_detect_i1_muxcyo : STD_LOGIC_VECTOR ( 1 downto 1 ); 
  signal BU2_U0_transmitter_seq_detect_i0_muxcyo : STD_LOGIC_VECTOR ( 1 downto 1 ); 
  signal BU2_U0_transmitter_tx_is_q : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal BU2_U0_transmitter_tx_is_q_comb : STD_LOGIC_VECTOR ( 1 downto 1 ); 
  signal BU2_U0_transmitter_tx_is_idle : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal BU2_U0_transmitter_tx_is_idle_comb : STD_LOGIC_VECTOR ( 1 downto 1 ); 
  signal BU2_U0_receiver_code_error : STD_LOGIC_VECTOR ( 7 downto 1 ); 
  signal BU2_U0_receiver_non_iee_deskew_state_next_state : STD_LOGIC_VECTOR ( 1 downto 1 ); 
begin
  mgt_rxdata_6(63) <= mgt_rxdata(63);
  mgt_rxdata_6(62) <= mgt_rxdata(62);
  mgt_rxdata_6(61) <= mgt_rxdata(61);
  mgt_rxdata_6(60) <= mgt_rxdata(60);
  mgt_rxdata_6(59) <= mgt_rxdata(59);
  mgt_rxdata_6(58) <= mgt_rxdata(58);
  mgt_rxdata_6(57) <= mgt_rxdata(57);
  mgt_rxdata_6(56) <= mgt_rxdata(56);
  mgt_rxdata_6(55) <= mgt_rxdata(55);
  mgt_rxdata_6(54) <= mgt_rxdata(54);
  mgt_rxdata_6(53) <= mgt_rxdata(53);
  mgt_rxdata_6(52) <= mgt_rxdata(52);
  mgt_rxdata_6(51) <= mgt_rxdata(51);
  mgt_rxdata_6(50) <= mgt_rxdata(50);
  mgt_rxdata_6(49) <= mgt_rxdata(49);
  mgt_rxdata_6(48) <= mgt_rxdata(48);
  mgt_rxdata_6(47) <= mgt_rxdata(47);
  mgt_rxdata_6(46) <= mgt_rxdata(46);
  mgt_rxdata_6(45) <= mgt_rxdata(45);
  mgt_rxdata_6(44) <= mgt_rxdata(44);
  mgt_rxdata_6(43) <= mgt_rxdata(43);
  mgt_rxdata_6(42) <= mgt_rxdata(42);
  mgt_rxdata_6(41) <= mgt_rxdata(41);
  mgt_rxdata_6(40) <= mgt_rxdata(40);
  mgt_rxdata_6(39) <= mgt_rxdata(39);
  mgt_rxdata_6(38) <= mgt_rxdata(38);
  mgt_rxdata_6(37) <= mgt_rxdata(37);
  mgt_rxdata_6(36) <= mgt_rxdata(36);
  mgt_rxdata_6(35) <= mgt_rxdata(35);
  mgt_rxdata_6(34) <= mgt_rxdata(34);
  mgt_rxdata_6(33) <= mgt_rxdata(33);
  mgt_rxdata_6(32) <= mgt_rxdata(32);
  mgt_rxdata_6(31) <= mgt_rxdata(31);
  mgt_rxdata_6(30) <= mgt_rxdata(30);
  mgt_rxdata_6(29) <= mgt_rxdata(29);
  mgt_rxdata_6(28) <= mgt_rxdata(28);
  mgt_rxdata_6(27) <= mgt_rxdata(27);
  mgt_rxdata_6(26) <= mgt_rxdata(26);
  mgt_rxdata_6(25) <= mgt_rxdata(25);
  mgt_rxdata_6(24) <= mgt_rxdata(24);
  mgt_rxdata_6(23) <= mgt_rxdata(23);
  mgt_rxdata_6(22) <= mgt_rxdata(22);
  mgt_rxdata_6(21) <= mgt_rxdata(21);
  mgt_rxdata_6(20) <= mgt_rxdata(20);
  mgt_rxdata_6(19) <= mgt_rxdata(19);
  mgt_rxdata_6(18) <= mgt_rxdata(18);
  mgt_rxdata_6(17) <= mgt_rxdata(17);
  mgt_rxdata_6(16) <= mgt_rxdata(16);
  mgt_rxdata_6(15) <= mgt_rxdata(15);
  mgt_rxdata_6(14) <= mgt_rxdata(14);
  mgt_rxdata_6(13) <= mgt_rxdata(13);
  mgt_rxdata_6(12) <= mgt_rxdata(12);
  mgt_rxdata_6(11) <= mgt_rxdata(11);
  mgt_rxdata_6(10) <= mgt_rxdata(10);
  mgt_rxdata_6(9) <= mgt_rxdata(9);
  mgt_rxdata_6(8) <= mgt_rxdata(8);
  mgt_rxdata_6(7) <= mgt_rxdata(7);
  mgt_rxdata_6(6) <= mgt_rxdata(6);
  mgt_rxdata_6(5) <= mgt_rxdata(5);
  mgt_rxdata_6(4) <= mgt_rxdata(4);
  mgt_rxdata_6(3) <= mgt_rxdata(3);
  mgt_rxdata_6(2) <= mgt_rxdata(2);
  mgt_rxdata_6(1) <= mgt_rxdata(1);
  mgt_rxdata_6(0) <= mgt_rxdata(0);
  mgt_txcharisk(7) <= mgt_txcharisk_3(7);
  mgt_txcharisk(6) <= mgt_txcharisk_3(6);
  mgt_txcharisk(5) <= mgt_txcharisk_3(5);
  mgt_txcharisk(4) <= mgt_txcharisk_3(4);
  mgt_txcharisk(3) <= mgt_txcharisk_3(3);
  mgt_txcharisk(2) <= mgt_txcharisk_3(2);
  mgt_txcharisk(1) <= mgt_txcharisk_3(1);
  mgt_txcharisk(0) <= mgt_txcharisk_3(0);
  sync_status(3) <= NlwRenamedSignal_status_vector(5);
  sync_status(2) <= NlwRenamedSignal_status_vector(4);
  sync_status(1) <= NlwRenamedSignal_status_vector(3);
  sync_status(0) <= NlwRenamedSignal_status_vector(2);
  mgt_rxcharisk_7(7) <= mgt_rxcharisk(7);
  mgt_rxcharisk_7(6) <= mgt_rxcharisk(6);
  mgt_rxcharisk_7(5) <= mgt_rxcharisk(5);
  mgt_rxcharisk_7(4) <= mgt_rxcharisk(4);
  mgt_rxcharisk_7(3) <= mgt_rxcharisk(3);
  mgt_rxcharisk_7(2) <= mgt_rxcharisk(2);
  mgt_rxcharisk_7(1) <= mgt_rxcharisk(1);
  mgt_rxcharisk_7(0) <= mgt_rxcharisk(0);
  mgt_txdata(63) <= mgt_txdata_2(63);
  mgt_txdata(62) <= mgt_txdata_2(62);
  mgt_txdata(61) <= mgt_txdata_2(61);
  mgt_txdata(60) <= mgt_txdata_2(60);
  mgt_txdata(59) <= mgt_txdata_2(59);
  mgt_txdata(58) <= mgt_txdata_2(58);
  mgt_txdata(57) <= mgt_txdata_2(57);
  mgt_txdata(56) <= mgt_txdata_2(56);
  mgt_txdata(55) <= mgt_txdata_2(55);
  mgt_txdata(54) <= mgt_txdata_2(54);
  mgt_txdata(53) <= mgt_txdata_2(53);
  mgt_txdata(52) <= mgt_txdata_2(52);
  mgt_txdata(51) <= mgt_txdata_2(51);
  mgt_txdata(50) <= mgt_txdata_2(50);
  mgt_txdata(49) <= mgt_txdata_2(49);
  mgt_txdata(48) <= mgt_txdata_2(48);
  mgt_txdata(47) <= mgt_txdata_2(47);
  mgt_txdata(46) <= mgt_txdata_2(46);
  mgt_txdata(45) <= mgt_txdata_2(45);
  mgt_txdata(44) <= mgt_txdata_2(44);
  mgt_txdata(43) <= mgt_txdata_2(43);
  mgt_txdata(42) <= mgt_txdata_2(42);
  mgt_txdata(41) <= mgt_txdata_2(41);
  mgt_txdata(40) <= mgt_txdata_2(40);
  mgt_txdata(39) <= mgt_txdata_2(39);
  mgt_txdata(38) <= mgt_txdata_2(38);
  mgt_txdata(37) <= mgt_txdata_2(37);
  mgt_txdata(36) <= mgt_txdata_2(36);
  mgt_txdata(35) <= mgt_txdata_2(35);
  mgt_txdata(34) <= mgt_txdata_2(34);
  mgt_txdata(33) <= mgt_txdata_2(33);
  mgt_txdata(32) <= mgt_txdata_2(32);
  mgt_txdata(31) <= mgt_txdata_2(31);
  mgt_txdata(30) <= mgt_txdata_2(30);
  mgt_txdata(29) <= mgt_txdata_2(29);
  mgt_txdata(28) <= mgt_txdata_2(28);
  mgt_txdata(27) <= mgt_txdata_2(27);
  mgt_txdata(26) <= mgt_txdata_2(26);
  mgt_txdata(25) <= mgt_txdata_2(25);
  mgt_txdata(24) <= mgt_txdata_2(24);
  mgt_txdata(23) <= mgt_txdata_2(23);
  mgt_txdata(22) <= mgt_txdata_2(22);
  mgt_txdata(21) <= mgt_txdata_2(21);
  mgt_txdata(20) <= mgt_txdata_2(20);
  mgt_txdata(19) <= mgt_txdata_2(19);
  mgt_txdata(18) <= mgt_txdata_2(18);
  mgt_txdata(17) <= mgt_txdata_2(17);
  mgt_txdata(16) <= mgt_txdata_2(16);
  mgt_txdata(15) <= mgt_txdata_2(15);
  mgt_txdata(14) <= mgt_txdata_2(14);
  mgt_txdata(13) <= mgt_txdata_2(13);
  mgt_txdata(12) <= mgt_txdata_2(12);
  mgt_txdata(11) <= mgt_txdata_2(11);
  mgt_txdata(10) <= mgt_txdata_2(10);
  mgt_txdata(9) <= mgt_txdata_2(9);
  mgt_txdata(8) <= mgt_txdata_2(8);
  mgt_txdata(7) <= mgt_txdata_2(7);
  mgt_txdata(6) <= mgt_txdata_2(6);
  mgt_txdata(5) <= mgt_txdata_2(5);
  mgt_txdata(4) <= mgt_txdata_2(4);
  mgt_txdata(3) <= mgt_txdata_2(3);
  mgt_txdata(2) <= mgt_txdata_2(2);
  mgt_txdata(1) <= mgt_txdata_2(1);
  mgt_txdata(0) <= mgt_txdata_2(0);
  mgt_enable_align(3) <= NlwRenamedSig_OI_mgt_enable_align(0);
  mgt_enable_align(2) <= NlwRenamedSig_OI_mgt_enable_align(0);
  mgt_enable_align(1) <= NlwRenamedSig_OI_mgt_enable_align(0);
  mgt_enable_align(0) <= NlwRenamedSig_OI_mgt_enable_align(0);
  mgt_powerdown <= NlwRenamedSignal_configuration_vector(1);
  xgmii_rxc(7) <= xgmii_rxc_1(7);
  xgmii_rxc(6) <= xgmii_rxc_1(6);
  xgmii_rxc(5) <= xgmii_rxc_1(5);
  xgmii_rxc(4) <= xgmii_rxc_1(4);
  xgmii_rxc(3) <= xgmii_rxc_1(3);
  xgmii_rxc(2) <= xgmii_rxc_1(2);
  xgmii_rxc(1) <= xgmii_rxc_1(1);
  xgmii_rxc(0) <= xgmii_rxc_1(0);
  xgmii_rxd(63) <= xgmii_rxd_0(63);
  xgmii_rxd(62) <= xgmii_rxd_0(62);
  xgmii_rxd(61) <= xgmii_rxd_0(61);
  xgmii_rxd(60) <= xgmii_rxd_0(60);
  xgmii_rxd(59) <= xgmii_rxd_0(59);
  xgmii_rxd(58) <= xgmii_rxd_0(58);
  xgmii_rxd(57) <= xgmii_rxd_0(57);
  xgmii_rxd(56) <= xgmii_rxd_0(56);
  xgmii_rxd(55) <= xgmii_rxd_0(55);
  xgmii_rxd(54) <= xgmii_rxd_0(54);
  xgmii_rxd(53) <= xgmii_rxd_0(53);
  xgmii_rxd(52) <= xgmii_rxd_0(52);
  xgmii_rxd(51) <= xgmii_rxd_0(51);
  xgmii_rxd(50) <= xgmii_rxd_0(50);
  xgmii_rxd(49) <= xgmii_rxd_0(49);
  xgmii_rxd(48) <= xgmii_rxd_0(48);
  xgmii_rxd(47) <= xgmii_rxd_0(47);
  xgmii_rxd(46) <= xgmii_rxd_0(46);
  xgmii_rxd(45) <= xgmii_rxd_0(45);
  xgmii_rxd(44) <= xgmii_rxd_0(44);
  xgmii_rxd(43) <= xgmii_rxd_0(43);
  xgmii_rxd(42) <= xgmii_rxd_0(42);
  xgmii_rxd(41) <= xgmii_rxd_0(41);
  xgmii_rxd(40) <= xgmii_rxd_0(40);
  xgmii_rxd(39) <= xgmii_rxd_0(39);
  xgmii_rxd(38) <= xgmii_rxd_0(38);
  xgmii_rxd(37) <= xgmii_rxd_0(37);
  xgmii_rxd(36) <= xgmii_rxd_0(36);
  xgmii_rxd(35) <= xgmii_rxd_0(35);
  xgmii_rxd(34) <= xgmii_rxd_0(34);
  xgmii_rxd(33) <= xgmii_rxd_0(33);
  xgmii_rxd(32) <= xgmii_rxd_0(32);
  xgmii_rxd(31) <= xgmii_rxd_0(31);
  xgmii_rxd(30) <= xgmii_rxd_0(30);
  xgmii_rxd(29) <= xgmii_rxd_0(29);
  xgmii_rxd(28) <= xgmii_rxd_0(28);
  xgmii_rxd(27) <= xgmii_rxd_0(27);
  xgmii_rxd(26) <= xgmii_rxd_0(26);
  xgmii_rxd(25) <= xgmii_rxd_0(25);
  xgmii_rxd(24) <= xgmii_rxd_0(24);
  xgmii_rxd(23) <= xgmii_rxd_0(23);
  xgmii_rxd(22) <= xgmii_rxd_0(22);
  xgmii_rxd(21) <= xgmii_rxd_0(21);
  xgmii_rxd(20) <= xgmii_rxd_0(20);
  xgmii_rxd(19) <= xgmii_rxd_0(19);
  xgmii_rxd(18) <= xgmii_rxd_0(18);
  xgmii_rxd(17) <= xgmii_rxd_0(17);
  xgmii_rxd(16) <= xgmii_rxd_0(16);
  xgmii_rxd(15) <= xgmii_rxd_0(15);
  xgmii_rxd(14) <= xgmii_rxd_0(14);
  xgmii_rxd(13) <= xgmii_rxd_0(13);
  xgmii_rxd(12) <= xgmii_rxd_0(12);
  xgmii_rxd(11) <= xgmii_rxd_0(11);
  xgmii_rxd(10) <= xgmii_rxd_0(10);
  xgmii_rxd(9) <= xgmii_rxd_0(9);
  xgmii_rxd(8) <= xgmii_rxd_0(8);
  xgmii_rxd(7) <= xgmii_rxd_0(7);
  xgmii_rxd(6) <= xgmii_rxd_0(6);
  xgmii_rxd(5) <= xgmii_rxd_0(5);
  xgmii_rxd(4) <= xgmii_rxd_0(4);
  xgmii_rxd(3) <= xgmii_rxd_0(3);
  xgmii_rxd(2) <= xgmii_rxd_0(2);
  xgmii_rxd(1) <= xgmii_rxd_0(1);
  xgmii_rxd(0) <= xgmii_rxd_0(0);
  signal_detect_13(3) <= signal_detect(3);
  signal_detect_13(2) <= signal_detect(2);
  signal_detect_13(1) <= signal_detect(1);
  signal_detect_13(0) <= signal_detect(0);
  mgt_loopback <= NlwRenamedSignal_configuration_vector(0);
  configuration_vector_14(6) <= configuration_vector(6);
  configuration_vector_14(5) <= configuration_vector(5);
  configuration_vector_14(4) <= configuration_vector(4);
  configuration_vector_14(3) <= configuration_vector(3);
  configuration_vector_14(2) <= configuration_vector(2);
  NlwRenamedSignal_configuration_vector(1) <= configuration_vector(1);
  NlwRenamedSignal_configuration_vector(0) <= configuration_vector(0);
  mgt_syncok_10(3) <= mgt_syncok(3);
  mgt_syncok_10(2) <= mgt_syncok(2);
  mgt_syncok_10(1) <= mgt_syncok(1);
  mgt_syncok_10(0) <= mgt_syncok(0);
  mgt_codecomma_9(7) <= mgt_codecomma(7);
  mgt_codecomma_9(6) <= mgt_codecomma(6);
  mgt_codecomma_9(5) <= mgt_codecomma(5);
  mgt_codecomma_9(4) <= mgt_codecomma(4);
  mgt_codecomma_9(3) <= mgt_codecomma(3);
  mgt_codecomma_9(2) <= mgt_codecomma(2);
  mgt_codecomma_9(1) <= mgt_codecomma(1);
  mgt_codecomma_9(0) <= mgt_codecomma(0);
  mgt_rx_reset_12(3) <= mgt_rx_reset(3);
  mgt_rx_reset_12(2) <= mgt_rx_reset(2);
  mgt_rx_reset_12(1) <= mgt_rx_reset(1);
  mgt_rx_reset_12(0) <= mgt_rx_reset(0);
  align_status <= NlwRenamedSig_OI_align_status;
  status_vector(6) <= NlwRenamedSig_OI_align_status;
  status_vector(5) <= NlwRenamedSignal_status_vector(5);
  status_vector(4) <= NlwRenamedSignal_status_vector(4);
  status_vector(3) <= NlwRenamedSignal_status_vector(3);
  status_vector(2) <= NlwRenamedSignal_status_vector(2);
  mgt_codevalid_8(7) <= mgt_codevalid(7);
  mgt_codevalid_8(6) <= mgt_codevalid(6);
  mgt_codevalid_8(5) <= mgt_codevalid(5);
  mgt_codevalid_8(4) <= mgt_codevalid(4);
  mgt_codevalid_8(3) <= mgt_codevalid(3);
  mgt_codevalid_8(2) <= mgt_codevalid(2);
  mgt_codevalid_8(1) <= mgt_codevalid(1);
  mgt_codevalid_8(0) <= mgt_codevalid(0);
  mgt_tx_reset_11(3) <= mgt_tx_reset(3);
  mgt_tx_reset_11(2) <= mgt_tx_reset(2);
  mgt_tx_reset_11(1) <= mgt_tx_reset(1);
  mgt_tx_reset_11(0) <= mgt_tx_reset(0);
  xgmii_txc_5(7) <= xgmii_txc(7);
  xgmii_txc_5(6) <= xgmii_txc(6);
  xgmii_txc_5(5) <= xgmii_txc(5);
  xgmii_txc_5(4) <= xgmii_txc(4);
  xgmii_txc_5(3) <= xgmii_txc(3);
  xgmii_txc_5(2) <= xgmii_txc(2);
  xgmii_txc_5(1) <= xgmii_txc(1);
  xgmii_txc_5(0) <= xgmii_txc(0);
  xgmii_txd_4(63) <= xgmii_txd(63);
  xgmii_txd_4(62) <= xgmii_txd(62);
  xgmii_txd_4(61) <= xgmii_txd(61);
  xgmii_txd_4(60) <= xgmii_txd(60);
  xgmii_txd_4(59) <= xgmii_txd(59);
  xgmii_txd_4(58) <= xgmii_txd(58);
  xgmii_txd_4(57) <= xgmii_txd(57);
  xgmii_txd_4(56) <= xgmii_txd(56);
  xgmii_txd_4(55) <= xgmii_txd(55);
  xgmii_txd_4(54) <= xgmii_txd(54);
  xgmii_txd_4(53) <= xgmii_txd(53);
  xgmii_txd_4(52) <= xgmii_txd(52);
  xgmii_txd_4(51) <= xgmii_txd(51);
  xgmii_txd_4(50) <= xgmii_txd(50);
  xgmii_txd_4(49) <= xgmii_txd(49);
  xgmii_txd_4(48) <= xgmii_txd(48);
  xgmii_txd_4(47) <= xgmii_txd(47);
  xgmii_txd_4(46) <= xgmii_txd(46);
  xgmii_txd_4(45) <= xgmii_txd(45);
  xgmii_txd_4(44) <= xgmii_txd(44);
  xgmii_txd_4(43) <= xgmii_txd(43);
  xgmii_txd_4(42) <= xgmii_txd(42);
  xgmii_txd_4(41) <= xgmii_txd(41);
  xgmii_txd_4(40) <= xgmii_txd(40);
  xgmii_txd_4(39) <= xgmii_txd(39);
  xgmii_txd_4(38) <= xgmii_txd(38);
  xgmii_txd_4(37) <= xgmii_txd(37);
  xgmii_txd_4(36) <= xgmii_txd(36);
  xgmii_txd_4(35) <= xgmii_txd(35);
  xgmii_txd_4(34) <= xgmii_txd(34);
  xgmii_txd_4(33) <= xgmii_txd(33);
  xgmii_txd_4(32) <= xgmii_txd(32);
  xgmii_txd_4(31) <= xgmii_txd(31);
  xgmii_txd_4(30) <= xgmii_txd(30);
  xgmii_txd_4(29) <= xgmii_txd(29);
  xgmii_txd_4(28) <= xgmii_txd(28);
  xgmii_txd_4(27) <= xgmii_txd(27);
  xgmii_txd_4(26) <= xgmii_txd(26);
  xgmii_txd_4(25) <= xgmii_txd(25);
  xgmii_txd_4(24) <= xgmii_txd(24);
  xgmii_txd_4(23) <= xgmii_txd(23);
  xgmii_txd_4(22) <= xgmii_txd(22);
  xgmii_txd_4(21) <= xgmii_txd(21);
  xgmii_txd_4(20) <= xgmii_txd(20);
  xgmii_txd_4(19) <= xgmii_txd(19);
  xgmii_txd_4(18) <= xgmii_txd(18);
  xgmii_txd_4(17) <= xgmii_txd(17);
  xgmii_txd_4(16) <= xgmii_txd(16);
  xgmii_txd_4(15) <= xgmii_txd(15);
  xgmii_txd_4(14) <= xgmii_txd(14);
  xgmii_txd_4(13) <= xgmii_txd(13);
  xgmii_txd_4(12) <= xgmii_txd(12);
  xgmii_txd_4(11) <= xgmii_txd(11);
  xgmii_txd_4(10) <= xgmii_txd(10);
  xgmii_txd_4(9) <= xgmii_txd(9);
  xgmii_txd_4(8) <= xgmii_txd(8);
  xgmii_txd_4(7) <= xgmii_txd(7);
  xgmii_txd_4(6) <= xgmii_txd(6);
  xgmii_txd_4(5) <= xgmii_txd(5);
  xgmii_txd_4(4) <= xgmii_txd(4);
  xgmii_txd_4(3) <= xgmii_txd(3);
  xgmii_txd_4(2) <= xgmii_txd(2);
  xgmii_txd_4(1) <= xgmii_txd(1);
  xgmii_txd_4(0) <= xgmii_txd(0);
  VCC_15 : VCC
    port map (
      P => N1
    );
  GND_16 : GND
    port map (
      G => N0
    );
  BU2_U0_transmitter_state_machine_n0003_0_17_F : LUT4_L
    generic map(
      INIT => X"55D5"
    )
    port map (
      I0 => BU2_U0_transmitter_tx_is_idle(0),
      I1 => BU2_U0_transmitter_state_machine_state_1_1,
      I2 => BU2_U0_transmitter_tqmsg_capture_1_q_det,
      I3 => BU2_U0_transmitter_state_machine_state_1_0,
      LO => BU2_N3646
    );
  BU2_U0_transmitter_state_machine_n0003_0_17 : MUXF5
    port map (
      I0 => BU2_N3646,
      I1 => BU2_N3647,
      S => BU2_U0_transmitter_tx_is_q(0),
      O => BU2_CHOICE2153
    );
  BU2_U0_usrclk_reset_1_17 : FDS
    generic map(
      INIT => '1'
    )
    port map (
      D => BU2_U0_usrclk_reset_pipe,
      S => reset,
      C => usrclk,
      Q => BU2_U0_usrclk_reset_1
    );
  BU2_U0_transmitter_recoder_n04691_1 : LUT3_D
    generic map(
      INIT => X"02"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_0,
      I1 => BU2_U0_transmitter_state_machine_state_0_1,
      I2 => BU2_U0_transmitter_state_machine_state_0_2,
      LO => BU2_N3702,
      O => BU2_U0_transmitter_recoder_n04691
    );
  BU2_U0_transmitter_tqmsg_capture_1_n001360_4 : LUT4
    generic map(
      INIT => X"FF80"
    )
    port map (
      I0 => BU2_CHOICE1413,
      I1 => BU2_CHOICE1419,
      I2 => BU2_CHOICE1424,
      I3 => BU2_U0_transmitter_tqmsg_capture_1_n000543,
      O => BU2_U0_transmitter_tqmsg_capture_1_n0013603
    );
  BU2_U0_transmitter_tqmsg_capture_1_n001360_3 : LUT4
    generic map(
      INIT => X"FF80"
    )
    port map (
      I0 => BU2_CHOICE1413,
      I1 => BU2_CHOICE1419,
      I2 => BU2_CHOICE1424,
      I3 => BU2_U0_transmitter_tqmsg_capture_1_n000543,
      O => BU2_U0_transmitter_tqmsg_capture_1_n0013602
    );
  BU2_U0_transmitter_tqmsg_capture_1_n001360_2 : LUT4
    generic map(
      INIT => X"FF80"
    )
    port map (
      I0 => BU2_CHOICE1413,
      I1 => BU2_CHOICE1419,
      I2 => BU2_N3698,
      I3 => BU2_U0_transmitter_tqmsg_capture_1_n000543,
      O => BU2_U0_transmitter_tqmsg_capture_1_n0013601
    );
  BU2_U0_transmitter_recoder_n04681_1 : LUT2_D
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_0,
      I1 => BU2_U0_transmitter_state_machine_state_0_1,
      LO => BU2_N3701,
      O => BU2_U0_transmitter_recoder_n04681
    );
  BU2_U0_transmitter_state_machine_state_1_0_2_18 : FDRS
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_N3120,
      R => BU2_U0_usrclk_reset,
      S => BU2_U0_transmitter_state_machine_N13,
      C => usrclk,
      Q => BU2_U0_transmitter_state_machine_state_1_0_2
    );
  BU2_U0_transmitter_state_machine_state_0_0_1_19 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_transmitter_state_machine_n0003(0),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_state_machine_state_0_0_1
    );
  BU2_U0_transmitter_state_machine_state_1_2_1_20 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_transmitter_state_machine_next_state(1, 2),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_state_machine_state_1_2_1
    );
  BU2_U0_transmitter_tqmsg_capture_1_n000543_1 : LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => BU2_N3695,
      I1 => BU2_CHOICE1401,
      I2 => BU2_CHOICE1406,
      O => BU2_U0_transmitter_tqmsg_capture_1_n000543
    );
  BU2_U0_transmitter_state_machine_state_1_1_1_21 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_transmitter_state_machine_next_state(1, 1),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_state_machine_state_1_1_1
    );
  BU2_U0_transmitter_state_machine_n0003_0_17_G : LUT4_L
    generic map(
      INIT => X"3010"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_2,
      I1 => BU2_U0_transmitter_state_machine_state_1_0,
      I2 => BU2_U0_transmitter_state_machine_state_1_1,
      I3 => BU2_U0_transmitter_tqmsg_capture_1_q_det,
      LO => BU2_N3647
    );
  BU2_U0_transmitter_state_machine_state_1_0_1_22 : FDRS
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_N3120,
      R => BU2_U0_usrclk_reset,
      S => BU2_U0_transmitter_state_machine_N13,
      C => usrclk,
      Q => BU2_U0_transmitter_state_machine_state_1_0_1
    );
  BU2_U0_transmitter_recoder_n0433_SW0 : LUT4_L
    generic map(
      INIT => X"FF20"
    )
    port map (
      I0 => BU2_U0_transmitter_filter0_txd_out(0),
      I1 => BU2_U0_transmitter_recoder_n0481,
      I2 => BU2_U0_transmitter_tx_code_d(0),
      I3 => BU2_U0_transmitter_recoder_n0479,
      LO => BU2_N1076
    );
  BU2_U0_receiver_recoder_n058811 : LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => mgt_rxdata_6(31),
      I1 => mgt_rxcharisk_7(3),
      I2 => mgt_rxdata_6(24),
      O => BU2_CHOICE1121
    );
  BU2_U0_transmitter_recoder_n0418_SW0 : LUT4_L
    generic map(
      INIT => X"FF20"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(8),
      I1 => BU2_U0_transmitter_recoder_n0481,
      I2 => BU2_U0_transmitter_recoder_n0473,
      I3 => BU2_U0_transmitter_recoder_n0479,
      LO => BU2_N3506
    );
  BU2_U0_receiver_non_iee_deskew_state_Ker214 : LUT3
    generic map(
      INIT => X"02"
    )
    port map (
      I0 => mgt_rxcharisk_7(1),
      I1 => mgt_rxdata_6(8),
      I2 => mgt_rxdata_6(9),
      O => BU2_CHOICE1152
    );
  BU2_U0_transmitter_recoder_n0412_SW0 : LUT4_L
    generic map(
      INIT => X"FF20"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(0),
      I1 => BU2_U0_transmitter_recoder_n0481,
      I2 => BU2_U0_transmitter_recoder_n0473,
      I3 => BU2_U0_transmitter_recoder_n0479,
      LO => BU2_N3508
    );
  BU2_U0_receiver_n002454_SW0 : LUT4
    generic map(
      INIT => X"135F"
    )
    port map (
      I0 => mgt_rxdata_6(32),
      I1 => mgt_rxdata_6(34),
      I2 => mgt_rxdata_6(33),
      I3 => mgt_rxdata_6(35),
      O => BU2_N3552
    );
  BU2_U0_receiver_recoder_n059416_SW0 : LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => mgt_rxdata_6(12),
      I1 => mgt_rxdata_6(11),
      I2 => mgt_rxdata_6(10),
      I3 => BU2_CHOICE1085,
      O => BU2_N3558
    );
  BU2_U0_transmitter_recoder_n0406_SW0 : LUT4_L
    generic map(
      INIT => X"FF20"
    )
    port map (
      I0 => BU2_U0_transmitter_filter3_txd_out(0),
      I1 => BU2_U0_transmitter_recoder_n0481,
      I2 => BU2_U0_transmitter_tx_code_d(0),
      I3 => BU2_U0_transmitter_recoder_n0479,
      LO => BU2_N1085
    );
  BU2_U0_receiver_n002444 : LUT4
    generic map(
      INIT => X"2AAA"
    )
    port map (
      I0 => BU2_CHOICE1232,
      I1 => mgt_rxdata_6(39),
      I2 => mgt_rxdata_6(37),
      I3 => mgt_rxdata_6(38),
      O => BU2_CHOICE1233
    );
  BU2_U0_transmitter_recoder_n0399_SW0 : LUT4_L
    generic map(
      INIT => X"FF20"
    )
    port map (
      I0 => BU2_U0_transmitter_filter2_txd_out(0),
      I1 => BU2_U0_transmitter_recoder_n0481,
      I2 => BU2_U0_transmitter_tx_code_d(0),
      I3 => BU2_U0_transmitter_recoder_n0479,
      LO => BU2_N1088
    );
  BU2_U0_transmitter_recoder_n0454_SW1 : LUT3
    generic map(
      INIT => X"EF"
    )
    port map (
      I0 => configuration_vector_14(6),
      I1 => configuration_vector_14(5),
      I2 => configuration_vector_14(4),
      O => BU2_N1115
    );
  BU2_U0_receiver_recoder_n0557_SW0 : LUT3
    generic map(
      INIT => X"F6"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(30),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(29),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(31),
      O => BU2_N1096
    );
  BU2_U0_transmitter_recoder_n0425_SW1 : LUT3
    generic map(
      INIT => X"AD"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_0,
      I1 => BU2_U0_transmitter_filter4_txd_out(7),
      I2 => BU2_U0_transmitter_state_machine_state_1_2,
      O => BU2_N3606
    );
  BU2_U0_transmitter_recoder_n0443_SW0 : LUT4_L
    generic map(
      INIT => X"FF20"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(24),
      I1 => BU2_U0_transmitter_recoder_n0481,
      I2 => BU2_U0_transmitter_recoder_n0473,
      I3 => BU2_U0_transmitter_recoder_n0479,
      LO => BU2_N3502
    );
  BU2_U0_transmitter_state_machine_n0003_2_SW0 : LUT4_L
    generic map(
      INIT => X"FFA7"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1_1,
      I1 => BU2_U0_transmitter_tqmsg_capture_1_q_det,
      I2 => BU2_U0_transmitter_state_machine_state_1_0_2,
      I3 => BU2_U0_transmitter_state_machine_state_1_2_1,
      LO => BU2_N1108
    );
  BU2_U0_transmitter_state_machine_n0003_2_SW1 : LUT3
    generic map(
      INIT => X"F9"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_0_1,
      I1 => BU2_U0_transmitter_state_machine_state_1_1_1,
      I2 => BU2_U0_transmitter_state_machine_state_1_2_1,
      O => BU2_N1109
    );
  BU2_U0_receiver_recoder_n0545_SW1 : LUT4_L
    generic map(
      INIT => X"F7FF"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxc_pipe(0),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(4),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(0),
      I3 => BU2_U0_receiver_recoder_rxd_pipe(2),
      LO => BU2_N3522
    );
  BU2_U0_receiver_n002254 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_CHOICE1365,
      I1 => BU2_CHOICE1374,
      O => BU2_CHOICE1375
    );
  BU2_U0_transmitter_recoder_n0454_SW0 : LUT4
    generic map(
      INIT => X"FF32"
    )
    port map (
      I0 => BU2_N3662,
      I1 => BU2_U0_transmitter_recoder_n0481,
      I2 => BU2_U0_transmitter_recoder_N35,
      I3 => BU2_U0_transmitter_recoder_N33,
      O => BU2_N3510
    );
  BU2_U0_transmitter_recoder_n0421_23 : LUT4
    generic map(
      INIT => X"FFA2"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1,
      I1 => BU2_U0_transmitter_state_machine_state_1_0,
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(5),
      I3 => BU2_N1817,
      O => BU2_U0_transmitter_recoder_n0421
    );
  BU2_U0_receiver_recoder_n059616 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => mgt_rxdata_6(37),
      I1 => BU2_N3556,
      I2 => mgt_rxdata_6(36),
      I3 => mgt_rxdata_6(38),
      O => BU2_N224
    );
  BU2_U0_receiver_recoder_Ker41_SW0 : LUT2
    generic map(
      INIT => X"7"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(27),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(26),
      O => BU2_N1126
    );
  BU2_U0_receiver_recoder_Ker39_SW0 : LUT2_L
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(16),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(18),
      LO => BU2_N1128
    );
  BU2_U0_receiver_n001839 : LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => mgt_rxdata_6(15),
      I1 => mgt_rxdata_6(13),
      I2 => mgt_rxdata_6(14),
      O => BU2_CHOICE1288
    );
  BU2_U0_receiver_recoder_Ker38_SW0 : LUT2_L
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(1),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(3),
      LO => BU2_N1130
    );
  BU2_U0_receiver_recoder_Ker40_SW0 : LUT2_L
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(8),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(11),
      LO => BU2_N1132
    );
  BU2_U0_receiver_recoder_n059611 : LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => mgt_rxdata_6(39),
      I1 => mgt_rxcharisk_7(4),
      I2 => mgt_rxdata_6(32),
      O => BU2_CHOICE1076
    );
  BU2_U0_receiver_recoder_n0553_SW0_SW0 : LUT2_L
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(22),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(21),
      LO => BU2_N3123
    );
  BU2_U0_receiver_recoder_n0547_SW0_SW0 : LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(14),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(13),
      O => BU2_N3125
    );
  BU2_U0_transmitter_state_machine_Ker13_SW0 : LUT2_D
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_n0003(2),
      I1 => BU2_U0_transmitter_tx_is_q(1),
      LO => BU2_N3700,
      O => BU2_N1138
    );
  BU2_U0_transmitter_state_machine_n0069_2_4 : LUT2_L
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_n0003(0),
      I1 => BU2_U0_transmitter_state_machine_n0003(1),
      LO => BU2_CHOICE1382
    );
  BU2_U0_transmitter_state_machine_n0069_2_18 : LUT4
    generic map(
      INIT => X"F100"
    )
    port map (
      I0 => BU2_U0_transmitter_tx_is_q(1),
      I1 => BU2_U0_transmitter_tqmsg_capture_1_q_det,
      I2 => BU2_U0_transmitter_state_machine_n0003(0),
      I3 => BU2_U0_transmitter_state_machine_n0003(1),
      O => BU2_CHOICE1388
    );
  BU2_U0_transmitter_filter7_n00227 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(58),
      I1 => BU2_U0_transmitter_txd_pipe(63),
      I2 => BU2_U0_transmitter_txd_pipe(57),
      I3 => BU2_U0_transmitter_txd_pipe(56),
      O => BU2_CHOICE1735
    );
  BU2_U0_receiver_recoder_n059616_SW0 : LUT4
    generic map(
      INIT => X"F7FF"
    )
    port map (
      I0 => mgt_rxdata_6(35),
      I1 => mgt_rxdata_6(34),
      I2 => mgt_rxdata_6(33),
      I3 => BU2_CHOICE1076,
      O => BU2_N3556
    );
  BU2_U0_transmitter_filter1_n000164 : LUT4_D
    generic map(
      INIT => X"FCF8"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(9),
      I1 => BU2_CHOICE1640,
      I2 => BU2_CHOICE1648,
      I3 => BU2_U0_transmitter_txd_pipe(8),
      LO => BU2_N3699,
      O => BU2_CHOICE1649
    );
  BU2_U0_transmitter_filter6_n000130 : LUT4
    generic map(
      INIT => X"9555"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(51),
      I1 => BU2_U0_transmitter_txd_pipe(49),
      I2 => BU2_U0_transmitter_txd_pipe(48),
      I3 => BU2_U0_transmitter_txd_pipe(50),
      O => BU2_CHOICE1466
    );
  BU2_U0_receiver_recoder_n0557_SW1 : LUT4_L
    generic map(
      INIT => X"FFF7"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(26),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(27),
      I2 => BU2_N1096,
      I3 => BU2_N3524,
      LO => BU2_N3145
    );
  BU2_U0_transmitter_tqmsg_capture_1_n001331 : LUT4_D
    generic map(
      INIT => X"0008"
    )
    port map (
      I0 => BU2_U0_transmitter_filter0_txd_out(2),
      I1 => BU2_U0_transmitter_filter0_txd_out(3),
      I2 => BU2_U0_transmitter_filter0_txd_out(0),
      I3 => BU2_U0_transmitter_filter0_txd_out(1),
      LO => BU2_N3698,
      O => BU2_CHOICE1424
    );
  BU2_U0_receiver_n001954 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_CHOICE1253,
      I1 => BU2_CHOICE1262,
      O => BU2_CHOICE1263
    );
  BU2_U0_receiver_recoder_n054048_SW1 : LUT4_D
    generic map(
      INIT => X"B6FF"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(31),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(29),
      I2 => BU2_U0_receiver_recoder_rxd_half_pipe(30),
      I3 => BU2_U0_receiver_recoder_rxd_half_pipe(26),
      LO => BU2_N3697,
      O => BU2_N3480
    );
  BU2_U0_transmitter_filter6_n000195 : LUT3
    generic map(
      INIT => X"C8"
    )
    port map (
      I0 => BU2_CHOICE1466,
      I1 => BU2_U0_transmitter_txc_pipe(6),
      I2 => BU2_N3656,
      O => BU2_U0_transmitter_filter6_n0001
    );
  BU2_U0_transmitter_filter0_n000130 : LUT4
    generic map(
      INIT => X"9555"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(3),
      I1 => BU2_U0_transmitter_txd_pipe(1),
      I2 => BU2_U0_transmitter_txd_pipe(0),
      I3 => BU2_U0_transmitter_txd_pipe(2),
      O => BU2_CHOICE1606
    );
  BU2_U0_receiver_recoder_n094379_SW0 : LUT3
    generic map(
      INIT => X"FB"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_pipe(0),
      I1 => NlwRenamedSig_OI_align_status,
      I2 => BU2_U0_usrclk_reset_1,
      O => BU2_N3436
    );
  BU2_U0_transmitter_filter4_n000164 : LUT4_D
    generic map(
      INIT => X"FCF8"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(33),
      I1 => BU2_CHOICE1556,
      I2 => BU2_CHOICE1564,
      I3 => BU2_U0_transmitter_txd_pipe(32),
      LO => BU2_N3696,
      O => BU2_CHOICE1565
    );
  BU2_U0_transmitter_filter1_n000130 : LUT4
    generic map(
      INIT => X"9555"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(11),
      I1 => BU2_U0_transmitter_txd_pipe(9),
      I2 => BU2_U0_transmitter_txd_pipe(8),
      I3 => BU2_U0_transmitter_txd_pipe(10),
      O => BU2_CHOICE1634
    );
  BU2_U0_transmitter_filter3_n000130 : LUT4
    generic map(
      INIT => X"9555"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(27),
      I1 => BU2_U0_transmitter_txd_pipe(25),
      I2 => BU2_U0_transmitter_txd_pipe(24),
      I3 => BU2_U0_transmitter_txd_pipe(26),
      O => BU2_CHOICE1522
    );
  BU2_U0_transmitter_align_a_cnt_1_SW0 : LUT4
    generic map(
      INIT => X"AA8A"
    )
    port map (
      I0 => BU2_U0_transmitter_align_count(2),
      I1 => BU2_U0_transmitter_align_count(0),
      I2 => BU2_U0_transmitter_align_extra_a,
      I3 => BU2_U0_transmitter_align_count(1),
      O => BU2_N2049
    );
  BU2_U0_receiver_recoder_n059716 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => mgt_rxdata_6(53),
      I1 => BU2_N3554,
      I2 => mgt_rxdata_6(52),
      I3 => mgt_rxdata_6(54),
      O => BU2_N205
    );
  BU2_U0_transmitter_recoder_n0398_SW1 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_2,
      I1 => BU2_U0_transmitter_filter2_txd_out(4),
      O => BU2_N3596
    );
  BU2_U0_transmitter_tqmsg_capture_1_n000510 : LUT4_D
    generic map(
      INIT => X"0008"
    )
    port map (
      I0 => BU2_U0_transmitter_filter4_txd_out(7),
      I1 => BU2_U0_transmitter_filter4_txd_out(4),
      I2 => BU2_U0_transmitter_filter4_txd_out(5),
      I3 => BU2_U0_transmitter_filter4_txd_out(6),
      LO => BU2_N3695,
      O => BU2_CHOICE1395
    );
  BU2_U0_transmitter_state_machine_n0069_0_SW0_SW0 : LUT4_L
    generic map(
      INIT => X"AF8C"
    )
    port map (
      I0 => BU2_U0_transmitter_k_r_prbs_i_prbs(7),
      I1 => BU2_U0_transmitter_tx_is_q(1),
      I2 => BU2_U0_transmitter_state_machine_n0003(2),
      I3 => BU2_U0_transmitter_tx_is_idle(1),
      LO => BU2_N3161
    );
  BU2_U0_transmitter_filter5_n00227 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(42),
      I1 => BU2_U0_transmitter_txd_pipe(47),
      I2 => BU2_U0_transmitter_txd_pipe(41),
      I3 => BU2_U0_transmitter_txd_pipe(40),
      O => BU2_CHOICE1761
    );
  BU2_U0_transmitter_recoder_n0403_SW1 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_2,
      I1 => BU2_U0_transmitter_filter2_txd_out(2),
      O => BU2_N3594
    );
  BU2_U0_receiver_recoder_n059711 : LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => mgt_rxdata_6(55),
      I1 => mgt_rxcharisk_7(6),
      I2 => mgt_rxdata_6(48),
      O => BU2_CHOICE1067
    );
  BU2_U0_transmitter_recoder_n0413_SW1 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_2,
      I1 => BU2_U0_transmitter_filter3_txd_out(4),
      O => BU2_N3590
    );
  BU2_U0_transmitter_recoder_n0409_SW1 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_2,
      I1 => BU2_U0_transmitter_filter3_txd_out(2),
      O => BU2_N3592
    );
  BU2_U0_transmitter_recoder_n0439_SW1 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_2,
      I1 => BU2_U0_transmitter_filter0_txd_out(2),
      O => BU2_N3588
    );
  BU2_U0_transmitter_recoder_n04381_SW0 : LUT4
    generic map(
      INIT => X"7277"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1,
      I1 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(22),
      I2 => BU2_U0_transmitter_state_machine_state_1_2,
      I3 => BU2_U0_transmitter_filter6_txd_out(6),
      O => BU2_N3562
    );
  BU2_U0_transmitter_recoder_n0419_SW0 : LUT3
    generic map(
      INIT => X"F1"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_2,
      I1 => BU2_U0_transmitter_filter4_txd_out(4),
      I2 => BU2_U0_transmitter_state_machine_state_1_1,
      O => BU2_N3640
    );
  BU2_U0_transmitter_recoder_n0422_SW0 : LUT3
    generic map(
      INIT => X"F1"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_2,
      I1 => BU2_U0_transmitter_filter5_txd_out(2),
      I2 => BU2_U0_transmitter_state_machine_state_1_1,
      O => BU2_N3638
    );
  BU2_U0_receiver_recoder_n059716_SW0 : LUT4
    generic map(
      INIT => X"F7FF"
    )
    port map (
      I0 => mgt_rxdata_6(51),
      I1 => mgt_rxdata_6(50),
      I2 => mgt_rxdata_6(49),
      I3 => BU2_CHOICE1067,
      O => BU2_N3554
    );
  BU2_U0_transmitter_recoder_n0426_SW0 : LUT3
    generic map(
      INIT => X"F1"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_2,
      I1 => BU2_U0_transmitter_filter5_txd_out(4),
      I2 => BU2_U0_transmitter_state_machine_state_1_1,
      O => BU2_N3636
    );
  BU2_U0_transmitter_recoder_n0428_SW0 : LUT3
    generic map(
      INIT => X"F1"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_2,
      I1 => BU2_U0_transmitter_filter6_txd_out(2),
      I2 => BU2_U0_transmitter_state_machine_state_1_1,
      O => BU2_N3634
    );
  BU2_U0_transmitter_recoder_n0432_SW0 : LUT3
    generic map(
      INIT => X"F1"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_2,
      I1 => BU2_U0_transmitter_filter6_txd_out(4),
      I2 => BU2_U0_transmitter_state_machine_state_1_1,
      O => BU2_N3632
    );
  BU2_U0_transmitter_recoder_n0441_SW0 : LUT3
    generic map(
      INIT => X"F1"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_2,
      I1 => BU2_U0_transmitter_filter7_txd_out(4),
      I2 => BU2_U0_transmitter_state_machine_state_1_1,
      O => BU2_N3630
    );
  BU2_U0_receiver_recoder_n0547_SW0 : LUT3
    generic map(
      INIT => X"BF"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_pipe(1),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(15),
      I2 => BU2_U0_receiver_recoder_rxc_pipe(1),
      O => BU2_N3149
    );
  BU2_U0_transmitter_recoder_n0445_SW1 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_2,
      I1 => BU2_U0_transmitter_filter0_txd_out(4),
      O => BU2_N3586
    );
  BU2_U0_transmitter_recoder_n0464_SW1 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_2,
      I1 => BU2_U0_transmitter_filter1_txd_out(2),
      O => BU2_N3584
    );
  BU2_U0_transmitter_recoder_n0449_SW0 : LUT3
    generic map(
      INIT => X"F1"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_2,
      I1 => BU2_U0_transmitter_filter7_txd_out(2),
      I2 => BU2_U0_transmitter_state_machine_state_1_1,
      O => BU2_N3628
    );
  BU2_U0_transmitter_recoder_n045816_SW0 : LUT3
    generic map(
      INIT => X"F1"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_2,
      I1 => BU2_U0_transmitter_filter2_txc_out,
      I2 => BU2_U0_transmitter_state_machine_state_0_1,
      O => BU2_N3616
    );
  BU2_U0_transmitter_tqmsg_capture_1_n000522 : LUT4
    generic map(
      INIT => X"0002"
    )
    port map (
      I0 => BU2_U0_transmitter_filter4_txc_out,
      I1 => BU2_U0_transmitter_filter5_txc_out,
      I2 => BU2_U0_transmitter_filter6_txc_out,
      I3 => BU2_U0_transmitter_filter7_txc_out,
      O => BU2_CHOICE1401
    );
  BU2_U0_transmitter_filter5_n000195 : LUT3
    generic map(
      INIT => X"C8"
    )
    port map (
      I0 => BU2_CHOICE1494,
      I1 => BU2_U0_transmitter_txc_pipe(5),
      I2 => BU2_N3684,
      O => BU2_U0_transmitter_filter5_n0001
    );
  BU2_U0_receiver_non_iee_deskew_state_n002517 : LUT3
    generic map(
      INIT => X"32"
    )
    port map (
      I0 => BU2_CHOICE1056,
      I1 => BU2_U0_receiver_non_iee_deskew_state_n0023,
      I2 => BU2_CHOICE1058,
      O => BU2_N188
    );
  BU2_U0_transmitter_filter7_n000162 : LUT4
    generic map(
      INIT => X"13FF"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(57),
      I1 => BU2_U0_transmitter_txd_pipe(58),
      I2 => BU2_U0_transmitter_txd_pipe(56),
      I3 => BU2_U0_transmitter_txd_pipe(60),
      O => BU2_CHOICE1452
    );
  BU2_U0_transmitter_filter6_n002220 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(51),
      I1 => BU2_U0_transmitter_txd_pipe(52),
      I2 => BU2_U0_transmitter_txd_pipe(53),
      I3 => BU2_U0_transmitter_txd_pipe(54),
      O => BU2_CHOICE1755
    );
  BU2_U0_transmitter_filter5_n000140 : LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(46),
      I1 => BU2_U0_transmitter_txd_pipe(45),
      I2 => BU2_U0_transmitter_txd_pipe(47),
      O => BU2_CHOICE1500
    );
  BU2_U0_transmitter_filter7_n000164 : LUT4_D
    generic map(
      INIT => X"FCF8"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(57),
      I1 => BU2_CHOICE1444,
      I2 => BU2_CHOICE1452,
      I3 => BU2_U0_transmitter_txd_pipe(56),
      LO => BU2_N3694,
      O => BU2_CHOICE1453
    );
  BU2_U0_transmitter_filter2_n000164 : LUT4_D
    generic map(
      INIT => X"FCF8"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(17),
      I1 => BU2_CHOICE1584,
      I2 => BU2_CHOICE1592,
      I3 => BU2_U0_transmitter_txd_pipe(16),
      LO => BU2_N3693,
      O => BU2_CHOICE1593
    );
  BU2_U0_transmitter_tqmsg_capture_1_n001360_1 : LUT4
    generic map(
      INIT => X"FF80"
    )
    port map (
      I0 => BU2_N3686,
      I1 => BU2_CHOICE1419,
      I2 => BU2_CHOICE1424,
      I3 => BU2_U0_transmitter_tqmsg_capture_1_n000543,
      O => BU2_U0_transmitter_tqmsg_capture_1_n001360
    );
  BU2_U0_receiver_recoder_n053346 : LUT4_D
    generic map(
      INIT => X"1000"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(8),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(9),
      I2 => BU2_N3137,
      I3 => BU2_U0_receiver_recoder_rxd_half_pipe(12),
      LO => BU2_N3692,
      O => BU2_CHOICE1730
    );
  BU2_U0_receiver_non_iee_deskew_state_n00248 : LUT4
    generic map(
      INIT => X"FF80"
    )
    port map (
      I0 => BU2_CHOICE1019,
      I1 => BU2_CHOICE1023,
      I2 => mgt_rxcharisk_7(7),
      I3 => BU2_N383,
      O => BU2_CHOICE1050
    );
  BU2_U0_transmitter_filter1_n000162 : LUT4
    generic map(
      INIT => X"13FF"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(9),
      I1 => BU2_U0_transmitter_txd_pipe(10),
      I2 => BU2_U0_transmitter_txd_pipe(8),
      I3 => BU2_U0_transmitter_txd_pipe(12),
      O => BU2_CHOICE1648
    );
  BU2_U0_receiver_recoder_n093176_SW1 : LUT4_L
    generic map(
      INIT => X"EAAA"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_delay(1),
      I1 => BU2_N3444,
      I2 => BU2_N3157,
      I3 => BU2_N3137,
      LO => BU2_N3129
    );
  BU2_U0_transmitter_filter0_n000195 : LUT3
    generic map(
      INIT => X"C8"
    )
    port map (
      I0 => BU2_CHOICE1606,
      I1 => BU2_U0_transmitter_txc_pipe(0),
      I2 => BU2_N3687,
      O => BU2_U0_transmitter_filter0_n0001
    );
  BU2_U0_transmitter_filter6_n000140 : LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(54),
      I1 => BU2_U0_transmitter_txd_pipe(53),
      I2 => BU2_U0_transmitter_txd_pipe(55),
      O => BU2_CHOICE1472
    );
  BU2_U0_receiver_non_iee_deskew_state_n00255 : LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_N91,
      I1 => mgt_rxcharisk_7(2),
      I2 => BU2_N70,
      I3 => mgt_rxcharisk_7(4),
      O => BU2_CHOICE1056
    );
  BU2_U0_transmitter_filter4_n000195 : LUT3
    generic map(
      INIT => X"C8"
    )
    port map (
      I0 => BU2_CHOICE1550,
      I1 => BU2_U0_transmitter_txc_pipe(4),
      I2 => BU2_N3696,
      O => BU2_U0_transmitter_filter4_n0001
    );
  BU2_U0_transmitter_tqmsg_capture_1_n000531 : LUT4
    generic map(
      INIT => X"0008"
    )
    port map (
      I0 => BU2_U0_transmitter_filter4_txd_out(2),
      I1 => BU2_U0_transmitter_filter4_txd_out(3),
      I2 => BU2_U0_transmitter_filter4_txd_out(0),
      I3 => BU2_U0_transmitter_filter4_txd_out(1),
      O => BU2_CHOICE1406
    );
  BU2_U0_receiver_recoder_n052948_SW1 : LUT4_D
    generic map(
      INIT => X"B6FF"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(7),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(5),
      I2 => BU2_U0_receiver_recoder_rxd_half_pipe(6),
      I3 => BU2_U0_receiver_recoder_rxd_half_pipe(2),
      LO => BU2_N3691,
      O => BU2_N3482
    );
  BU2_U0_transmitter_filter2_n000140 : LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(22),
      I1 => BU2_U0_transmitter_txd_pipe(21),
      I2 => BU2_U0_transmitter_txd_pipe(23),
      O => BU2_CHOICE1584
    );
  BU2_U0_transmitter_filter3_n000164 : LUT4_D
    generic map(
      INIT => X"FCF8"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(25),
      I1 => BU2_CHOICE1528,
      I2 => BU2_CHOICE1536,
      I3 => BU2_U0_transmitter_txd_pipe(24),
      LO => BU2_N3690,
      O => BU2_CHOICE1537
    );
  BU2_U0_transmitter_filter0_n000140 : LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(6),
      I1 => BU2_U0_transmitter_txd_pipe(5),
      I2 => BU2_U0_transmitter_txd_pipe(7),
      O => BU2_CHOICE1612
    );
  BU2_U0_receiver_recoder_n053346_SW0 : LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(11),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(10),
      I2 => BU2_U0_receiver_recoder_rxc_half_pipe(1),
      O => BU2_N3137
    );
  BU2_U0_transmitter_filter7_n000195 : LUT3
    generic map(
      INIT => X"C8"
    )
    port map (
      I0 => BU2_CHOICE1438,
      I1 => BU2_U0_transmitter_txc_pipe(7),
      I2 => BU2_N3694,
      O => BU2_U0_transmitter_filter7_n0001
    );
  BU2_U0_receiver_recoder_n054048_SW0 : LUT3
    generic map(
      INIT => X"EF"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(25),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(24),
      I2 => BU2_U0_receiver_recoder_rxc_half_pipe(3),
      O => BU2_N3330
    );
  BU2_U0_receiver_non_iee_deskew_state_n002417 : LUT3
    generic map(
      INIT => X"32"
    )
    port map (
      I0 => BU2_CHOICE1048,
      I1 => BU2_U0_receiver_non_iee_deskew_state_n0022,
      I2 => BU2_CHOICE1050,
      O => BU2_N172
    );
  BU2_U0_transmitter_tqmsg_capture_1_n000543_24 : LUT3_D
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => BU2_CHOICE1395,
      I1 => BU2_CHOICE1401,
      I2 => BU2_CHOICE1406,
      LO => BU2_N3689,
      O => BU2_U0_transmitter_tqmsg_capture_1_n0005
    );
  BU2_U0_transmitter_filter1_n000140 : LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(14),
      I1 => BU2_U0_transmitter_txd_pipe(13),
      I2 => BU2_U0_transmitter_txd_pipe(15),
      O => BU2_CHOICE1640
    );
  BU2_U0_transmitter_filter2_n000130 : LUT4
    generic map(
      INIT => X"9555"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(19),
      I1 => BU2_U0_transmitter_txd_pipe(17),
      I2 => BU2_U0_transmitter_txd_pipe(16),
      I3 => BU2_U0_transmitter_txd_pipe(18),
      O => BU2_CHOICE1578
    );
  BU2_U0_transmitter_filter6_n00227 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(50),
      I1 => BU2_U0_transmitter_txd_pipe(55),
      I2 => BU2_U0_transmitter_txd_pipe(49),
      I3 => BU2_U0_transmitter_txd_pipe(48),
      O => BU2_CHOICE1748
    );
  BU2_U0_transmitter_filter3_n000195 : LUT3
    generic map(
      INIT => X"C8"
    )
    port map (
      I0 => BU2_CHOICE1522,
      I1 => BU2_U0_transmitter_txc_pipe(3),
      I2 => BU2_N3690,
      O => BU2_U0_transmitter_filter3_n0001
    );
  BU2_U0_transmitter_filter4_n000140 : LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(38),
      I1 => BU2_U0_transmitter_txd_pipe(37),
      I2 => BU2_U0_transmitter_txd_pipe(39),
      O => BU2_CHOICE1556
    );
  BU2_U0_transmitter_filter4_n000130 : LUT4
    generic map(
      INIT => X"9555"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(35),
      I1 => BU2_U0_transmitter_txd_pipe(33),
      I2 => BU2_U0_transmitter_txd_pipe(32),
      I3 => BU2_U0_transmitter_txd_pipe(34),
      O => BU2_CHOICE1550
    );
  BU2_U0_transmitter_recoder_n0399_SW1 : LUT3
    generic map(
      INIT => X"9F"
    )
    port map (
      I0 => configuration_vector_14(5),
      I1 => configuration_vector_14(6),
      I2 => configuration_vector_14(4),
      O => BU2_N1089
    );
  BU2_U0_transmitter_filter7_n000130 : LUT4
    generic map(
      INIT => X"9555"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(59),
      I1 => BU2_U0_transmitter_txd_pipe(57),
      I2 => BU2_U0_transmitter_txd_pipe(56),
      I3 => BU2_U0_transmitter_txd_pipe(58),
      O => BU2_CHOICE1438
    );
  BU2_U0_transmitter_filter2_n000195 : LUT3
    generic map(
      INIT => X"C8"
    )
    port map (
      I0 => BU2_CHOICE1578,
      I1 => BU2_U0_transmitter_txc_pipe(2),
      I2 => BU2_N3693,
      O => BU2_U0_transmitter_filter2_n0001
    );
  BU2_U0_receiver_recoder_n059111 : LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => mgt_rxdata_6(7),
      I1 => mgt_rxcharisk_7(0),
      I2 => mgt_rxdata_6(0),
      O => BU2_CHOICE1094
    );
  BU2_U0_transmitter_recoder_n0453_SW0 : LUT4_L
    generic map(
      INIT => X"B5BF"
    )
    port map (
      I0 => BU2_U0_transmitter_tx_code_d(0),
      I1 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(7),
      I2 => BU2_U0_transmitter_tx_code_q(0),
      I3 => BU2_U0_transmitter_filter0_txd_out(7),
      LO => BU2_N959
    );
  BU2_U0_receiver_non_iee_deskew_state_n00245 : LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_N154,
      I1 => mgt_rxcharisk_7(3),
      I2 => BU2_N133,
      I3 => mgt_rxcharisk_7(5),
      O => BU2_CHOICE1048
    );
  BU2_U0_receiver_recoder_n094759 : LUT4_D
    generic map(
      INIT => X"0302"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_lane_terminate(3),
      I1 => BU2_U0_receiver_recoder_lane_terminate(0),
      I2 => BU2_U0_receiver_recoder_lane_terminate(1),
      I3 => BU2_U0_receiver_recoder_lane_terminate(2),
      LO => BU2_N3688,
      O => BU2_CHOICE2029
    );
  BU2_U0_transmitter_filter3_n000140 : LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(30),
      I1 => BU2_U0_transmitter_txd_pipe(29),
      I2 => BU2_U0_transmitter_txd_pipe(31),
      O => BU2_CHOICE1528
    );
  BU2_U0_receiver_recoder_n052948_SW0 : LUT3
    generic map(
      INIT => X"EF"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(1),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(0),
      I2 => BU2_U0_receiver_recoder_rxc_half_pipe(0),
      O => BU2_N3328
    );
  BU2_U0_transmitter_filter0_n000164 : LUT4_D
    generic map(
      INIT => X"FCF8"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(1),
      I1 => BU2_CHOICE1612,
      I2 => BU2_CHOICE1620,
      I3 => BU2_U0_transmitter_txd_pipe(0),
      LO => BU2_N3687,
      O => BU2_CHOICE1621
    );
  BU2_U0_receiver_recoder_n053363_SW0 : LUT3
    generic map(
      INIT => X"29"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(13),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(15),
      I2 => BU2_U0_receiver_recoder_rxd_half_pipe(14),
      O => BU2_N3157
    );
  BU2_U0_transmitter_tqmsg_capture_1_n001310 : LUT4_D
    generic map(
      INIT => X"0008"
    )
    port map (
      I0 => BU2_U0_transmitter_filter0_txd_out(7),
      I1 => BU2_U0_transmitter_filter0_txd_out(4),
      I2 => BU2_U0_transmitter_filter0_txd_out(5),
      I3 => BU2_U0_transmitter_filter0_txd_out(6),
      LO => BU2_N3686,
      O => BU2_CHOICE1413
    );
  BU2_U0_receiver_recoder_n053748 : LUT4_D
    generic map(
      INIT => X"0800"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(20),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(18),
      I2 => BU2_N3135,
      I3 => BU2_U0_receiver_recoder_rxd_half_pipe(19),
      LO => BU2_N3685,
      O => BU2_CHOICE1690
    );
  BU2_U0_transmitter_recoder_n0427_SW0 : LUT4
    generic map(
      INIT => X"3211"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_2,
      I1 => BU2_U0_transmitter_state_machine_state_1_1,
      I2 => BU2_U0_transmitter_filter5_txd_out(5),
      I3 => BU2_U0_transmitter_state_machine_state_1_0,
      O => BU2_N1815
    );
  BU2_U0_receiver_recoder_n0947144 : LUT4
    generic map(
      INIT => X"FFEA"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_pipe(1),
      I1 => BU2_CHOICE2026,
      I2 => BU2_CHOICE2029,
      I3 => BU2_N3650,
      O => BU2_U0_receiver_recoder_error_lane_5_Q
    );
  BU2_U0_transmitter_recoder_n0435_SW0 : LUT4
    generic map(
      INIT => X"3211"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_2,
      I1 => BU2_U0_transmitter_state_machine_state_1_1,
      I2 => BU2_U0_transmitter_filter6_txd_out(5),
      I3 => BU2_U0_transmitter_state_machine_state_1_0,
      O => BU2_N1813
    );
  BU2_U0_transmitter_recoder_n0444_SW0 : LUT4
    generic map(
      INIT => X"3211"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_2,
      I1 => BU2_U0_transmitter_state_machine_state_1_1,
      I2 => BU2_U0_transmitter_filter7_txd_out(5),
      I3 => BU2_U0_transmitter_state_machine_state_1_0,
      O => BU2_N1811
    );
  BU2_U0_receiver_non_iee_deskew_state_n003817 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => BU2_CHOICE1039,
      I1 => BU2_CHOICE1043,
      O => BU2_N154
    );
  BU2_U0_transmitter_recoder_n046116_SW0 : LUT3
    generic map(
      INIT => X"F1"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_2,
      I1 => BU2_U0_transmitter_filter5_txc_out,
      I2 => BU2_U0_transmitter_state_machine_state_1_1,
      O => BU2_N3612
    );
  BU2_U0_receiver_non_iee_deskew_state_n003816 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => mgt_rxdata_6(29),
      I1 => mgt_rxdata_6(31),
      I2 => mgt_rxdata_6(30),
      I3 => mgt_rxdata_6(28),
      O => BU2_CHOICE1043
    );
  BU2_U0_transmitter_filter7_n002220 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(59),
      I1 => BU2_U0_transmitter_txd_pipe(60),
      I2 => BU2_U0_transmitter_txd_pipe(61),
      I3 => BU2_U0_transmitter_txd_pipe(62),
      O => BU2_CHOICE1742
    );
  BU2_U0_transmitter_recoder_n0395_SW0 : LUT4
    generic map(
      INIT => X"B5BF"
    )
    port map (
      I0 => BU2_U0_transmitter_tx_code_q(0),
      I1 => BU2_U0_transmitter_filter1_txd_out(5),
      I2 => BU2_U0_transmitter_tx_code_d(0),
      I3 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(13),
      O => BU2_N1809
    );
  BU2_U0_transmitter_recoder_n0400_SW0 : LUT4
    generic map(
      INIT => X"B5BF"
    )
    port map (
      I0 => BU2_U0_transmitter_tx_code_q(0),
      I1 => BU2_U0_transmitter_filter2_txd_out(5),
      I2 => BU2_U0_transmitter_tx_code_d(0),
      I3 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(21),
      O => BU2_N1807
    );
  BU2_U0_transmitter_filter7_n000140 : LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(62),
      I1 => BU2_U0_transmitter_txd_pipe(61),
      I2 => BU2_U0_transmitter_txd_pipe(63),
      O => BU2_CHOICE1444
    );
  BU2_U0_transmitter_recoder_n0415_SW0 : LUT4
    generic map(
      INIT => X"B5BF"
    )
    port map (
      I0 => BU2_U0_transmitter_tx_code_q(0),
      I1 => BU2_U0_transmitter_filter3_txd_out(5),
      I2 => BU2_U0_transmitter_tx_code_d(0),
      I3 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(29),
      O => BU2_N1805
    );
  BU2_U0_transmitter_recoder_n0448_SW0 : LUT4
    generic map(
      INIT => X"B5BF"
    )
    port map (
      I0 => BU2_U0_transmitter_tx_code_q(0),
      I1 => BU2_U0_transmitter_filter0_txd_out(5),
      I2 => BU2_N3659,
      I3 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(5),
      O => BU2_N1803
    );
  BU2_U0_transmitter_filter1_n000195 : LUT3
    generic map(
      INIT => X"C8"
    )
    port map (
      I0 => BU2_CHOICE1634,
      I1 => BU2_U0_transmitter_txc_pipe(1),
      I2 => BU2_N3699,
      O => BU2_U0_transmitter_filter1_n0001
    );
  BU2_U0_receiver_n002154 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_CHOICE1337,
      I1 => BU2_CHOICE1346,
      O => BU2_CHOICE1347
    );
  BU2_U0_transmitter_filter5_n000162 : LUT4
    generic map(
      INIT => X"13FF"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(41),
      I1 => BU2_U0_transmitter_txd_pipe(42),
      I2 => BU2_U0_transmitter_txd_pipe(40),
      I3 => BU2_U0_transmitter_txd_pipe(44),
      O => BU2_CHOICE1508
    );
  BU2_U0_transmitter_filter5_n000164 : LUT4_D
    generic map(
      INIT => X"FCF8"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(41),
      I1 => BU2_CHOICE1500,
      I2 => BU2_CHOICE1508,
      I3 => BU2_U0_transmitter_txd_pipe(40),
      LO => BU2_N3684,
      O => BU2_CHOICE1509
    );
  BU2_U0_transmitter_filter6_n000162 : LUT4
    generic map(
      INIT => X"13FF"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(49),
      I1 => BU2_U0_transmitter_txd_pipe(50),
      I2 => BU2_U0_transmitter_txd_pipe(48),
      I3 => BU2_U0_transmitter_txd_pipe(52),
      O => BU2_CHOICE1480
    );
  BU2_U0_receiver_non_iee_deskew_state_n00388 : LUT4
    generic map(
      INIT => X"0008"
    )
    port map (
      I0 => mgt_rxdata_6(26),
      I1 => mgt_rxdata_6(27),
      I2 => mgt_rxdata_6(24),
      I3 => mgt_rxdata_6(25),
      O => BU2_CHOICE1039
    );
  BU2_U0_transmitter_state_machine_n0069_1_20_SW0 : LUT4
    generic map(
      INIT => X"A888"
    )
    port map (
      I0 => BU2_N3680,
      I1 => BU2_U0_transmitter_state_machine_n0003(2),
      I2 => BU2_U0_transmitter_state_machine_n0003(0),
      I3 => BU2_U0_transmitter_state_machine_next_ifg_is_a,
      O => BU2_N3466
    );
  BU2_U0_receiver_n002039 : LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => mgt_rxdata_6(47),
      I1 => mgt_rxdata_6(45),
      I2 => mgt_rxdata_6(46),
      O => BU2_CHOICE1316
    );
  BU2_U0_receiver_n001928 : LUT4
    generic map(
      INIT => X"135F"
    )
    port map (
      I0 => mgt_rxdata_6(25),
      I1 => mgt_rxdata_6(27),
      I2 => mgt_rxdata_6(24),
      I3 => mgt_rxdata_6(26),
      O => BU2_CHOICE1253
    );
  BU2_U0_transmitter_recoder_n0411_SW0_SW0 : LUT4
    generic map(
      INIT => X"F35F"
    )
    port map (
      I0 => BU2_U0_transmitter_filter3_txd_out(3),
      I1 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(27),
      I2 => BU2_U0_transmitter_recoder_n04691,
      I3 => BU2_U0_transmitter_recoder_n04681,
      O => BU2_N3448
    );
  BU2_U0_receiver_recoder_n095120 : LUT4
    generic map(
      INIT => X"7FFF"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(51),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(52),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(53),
      I3 => BU2_U0_receiver_recoder_rxd_pipe(54),
      O => BU2_CHOICE2059
    );
  BU2_U0_receiver_recoder_n059411 : LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => mgt_rxdata_6(15),
      I1 => mgt_rxcharisk_7(1),
      I2 => mgt_rxdata_6(8),
      O => BU2_CHOICE1085
    );
  BU2_U0_transmitter_n026417 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(53),
      I1 => BU2_U0_transmitter_txd_pipe(49),
      I2 => BU2_CHOICE1920,
      I3 => BU2_CHOICE1924,
      O => BU2_CHOICE1926
    );
  BU2_U0_transmitter_align_n0042_SW0 : LUT4_D
    generic map(
      INIT => X"FF40"
    )
    port map (
      I0 => BU2_U0_transmitter_align_extra_a,
      I1 => BU2_U0_transmitter_align_count(0),
      I2 => BU2_U0_transmitter_align_count(1),
      I3 => BU2_U0_transmitter_align_count(2),
      LO => BU2_N3683,
      O => BU2_N2981
    );
  BU2_U0_receiver_recoder_n0545_SW0 : LUT3
    generic map(
      INIT => X"B6"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(6),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(5),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(7),
      O => BU2_N996
    );
  BU2_U0_receiver_n001939 : LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => mgt_rxdata_6(31),
      I1 => mgt_rxdata_6(29),
      I2 => mgt_rxdata_6(30),
      O => BU2_CHOICE1260
    );
  BU2_U0_transmitter_n026410 : LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(54),
      I1 => BU2_U0_transmitter_txd_pipe(55),
      I2 => BU2_U0_transmitter_txc_pipe(6),
      O => BU2_CHOICE1924
    );
  BU2_U0_transmitter_filter4_n00227 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(34),
      I1 => BU2_U0_transmitter_txd_pipe(39),
      I2 => BU2_U0_transmitter_txd_pipe(33),
      I3 => BU2_U0_transmitter_txd_pipe(32),
      O => BU2_CHOICE1774
    );
  BU2_U0_transmitter_filter0_n002220 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(3),
      I1 => BU2_U0_transmitter_txd_pipe(4),
      I2 => BU2_U0_transmitter_txd_pipe(5),
      I3 => BU2_U0_transmitter_txd_pipe(6),
      O => BU2_CHOICE1833
    );
  BU2_U0_transmitter_n0264123 : LUT4_D
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => BU2_CHOICE1954,
      I1 => BU2_CHOICE1935,
      I2 => BU2_CHOICE1926,
      I3 => BU2_N3141,
      LO => BU2_N3682,
      O => BU2_U0_transmitter_is_terminate(1)
    );
  BU2_U0_receiver_recoder_n093148 : LUT4_D
    generic map(
      INIT => X"0302"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_lane_term_pipe(2),
      I1 => BU2_U0_receiver_recoder_lane_term_pipe(0),
      I2 => BU2_U0_receiver_recoder_lane_term_pipe(1),
      I3 => BU2_U0_receiver_recoder_lane_term_pipe(3),
      LO => BU2_N3681,
      O => BU2_CHOICE2201
    );
  BU2_U0_receiver_non_iee_deskew_state_n003917 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => BU2_CHOICE1029,
      I1 => BU2_CHOICE1033,
      O => BU2_N133
    );
  BU2_U0_transmitter_state_machine_state_0_1_1_25 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_transmitter_state_machine_n0003(1),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_state_machine_state_0_1_1
    );
  BU2_U0_receiver_non_iee_deskew_state_n003916 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => mgt_rxdata_6(45),
      I1 => mgt_rxdata_6(47),
      I2 => mgt_rxdata_6(46),
      I3 => mgt_rxdata_6(44),
      O => BU2_CHOICE1033
    );
  BU2_U0_receiver_n001915 : LUT4
    generic map(
      INIT => X"9111"
    )
    port map (
      I0 => mgt_rxdata_6(26),
      I1 => mgt_rxdata_6(27),
      I2 => mgt_rxdata_6(24),
      I3 => mgt_rxdata_6(25),
      O => BU2_CHOICE1246
    );
  BU2_U0_transmitter_state_machine_n0003_1_0 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_transmitter_tx_is_idle(0),
      I1 => BU2_U0_transmitter_tx_is_q(0),
      O => BU2_CHOICE2115
    );
  BU2_U0_transmitter_recoder_n045616_SW0 : LUT3
    generic map(
      INIT => X"F1"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_2,
      I1 => BU2_U0_transmitter_filter1_txc_out,
      I2 => BU2_U0_transmitter_state_machine_state_0_1,
      O => BU2_N3618
    );
  BU2_U0_transmitter_state_machine_n0069_0_SW0_SW1 : LUT2_D
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_transmitter_tx_is_q(1),
      I1 => BU2_U0_transmitter_tx_is_idle(1),
      LO => BU2_N3680,
      O => BU2_CHOICE2155
    );
  BU2_U0_transmitter_recoder_n0404_SW0 : LUT4_L
    generic map(
      INIT => X"B5BF"
    )
    port map (
      I0 => BU2_U0_transmitter_tx_code_d(0),
      I1 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(23),
      I2 => BU2_U0_transmitter_tx_code_q(0),
      I3 => BU2_U0_transmitter_filter2_txd_out(7),
      LO => BU2_N971
    );
  BU2_U0_transmitter_recoder_n0431_SW1 : LUT3
    generic map(
      INIT => X"AD"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_0,
      I1 => BU2_U0_transmitter_filter5_txd_out(7),
      I2 => BU2_U0_transmitter_state_machine_state_1_2,
      O => BU2_N3604
    );
  BU2_U0_receiver_recoder_n059316_SW0 : LUT4
    generic map(
      INIT => X"F7FF"
    )
    port map (
      I0 => mgt_rxdata_6(19),
      I1 => mgt_rxdata_6(18),
      I2 => mgt_rxdata_6(17),
      I3 => BU2_CHOICE1103,
      O => BU2_N3540
    );
  BU2_U0_receiver_n002454 : LUT3
    generic map(
      INIT => X"EF"
    )
    port map (
      I0 => BU2_N3552,
      I1 => BU2_CHOICE1233,
      I2 => mgt_rxdata_6(36),
      O => BU2_CHOICE1235
    );
  BU2_U0_receiver_recoder_n059016 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => mgt_rxdata_6(61),
      I1 => BU2_N3550,
      I2 => mgt_rxdata_6(60),
      I3 => mgt_rxdata_6(62),
      O => BU2_N300
    );
  BU2_U0_transmitter_n026317 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(21),
      I1 => BU2_U0_transmitter_txd_pipe(17),
      I2 => BU2_CHOICE1838,
      I3 => BU2_CHOICE1842,
      O => BU2_CHOICE1844
    );
  BU2_U0_transmitter_recoder_n0396181_SW0 : LUT4
    generic map(
      INIT => X"7277"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_1,
      I1 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(14),
      I2 => BU2_U0_transmitter_state_machine_state_0_2,
      I3 => BU2_U0_transmitter_filter1_txd_out(6),
      O => BU2_N3624
    );
  BU2_U0_receiver_non_iee_deskew_state_n00398 : LUT4
    generic map(
      INIT => X"0008"
    )
    port map (
      I0 => mgt_rxdata_6(42),
      I1 => mgt_rxdata_6(43),
      I2 => mgt_rxdata_6(40),
      I3 => mgt_rxdata_6(41),
      O => BU2_CHOICE1029
    );
  BU2_U0_receiver_recoder_n058916 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => mgt_rxdata_6(45),
      I1 => BU2_N3548,
      I2 => mgt_rxdata_6(44),
      I3 => mgt_rxdata_6(46),
      O => BU2_N338
    );
  BU2_U0_receiver_recoder_n093134 : LUT4
    generic map(
      INIT => X"FFFD"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(11),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(8),
      I2 => BU2_N3514,
      I3 => BU2_N3494,
      O => BU2_CHOICE2196
    );
  BU2_U0_transmitter_n02634 : LUT4_L
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(16),
      I1 => BU2_U0_transmitter_txd_pipe(19),
      I2 => BU2_U0_transmitter_txd_pipe(20),
      I3 => BU2_U0_transmitter_txd_pipe(18),
      LO => BU2_CHOICE1838
    );
  BU2_U0_receiver_n002654 : LUT3
    generic map(
      INIT => X"EF"
    )
    port map (
      I0 => BU2_N3546,
      I1 => BU2_CHOICE1177,
      I2 => mgt_rxdata_6(52),
      O => BU2_CHOICE1179
    );
  BU2_U0_transmitter_filter4_n002220 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(35),
      I1 => BU2_U0_transmitter_txd_pipe(36),
      I2 => BU2_U0_transmitter_txd_pipe(37),
      I3 => BU2_U0_transmitter_txd_pipe(38),
      O => BU2_CHOICE1781
    );
  BU2_U0_receiver_n002615 : LUT4
    generic map(
      INIT => X"9111"
    )
    port map (
      I0 => mgt_rxdata_6(50),
      I1 => mgt_rxdata_6(51),
      I2 => mgt_rxdata_6(48),
      I3 => mgt_rxdata_6(49),
      O => BU2_CHOICE1162
    );
  BU2_U0_receiver_n002028 : LUT4
    generic map(
      INIT => X"135F"
    )
    port map (
      I0 => mgt_rxdata_6(41),
      I1 => mgt_rxdata_6(43),
      I2 => mgt_rxdata_6(40),
      I3 => mgt_rxdata_6(42),
      O => BU2_CHOICE1309
    );
  BU2_U0_transmitter_align_n0003_3_SW0 : LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => BU2_U0_transmitter_align_count(2),
      I1 => BU2_U0_transmitter_align_count(1),
      O => BU2_N922
    );
  BU2_U0_transmitter_recoder_n0405_SW0_SW0 : LUT4
    generic map(
      INIT => X"F35F"
    )
    port map (
      I0 => BU2_U0_transmitter_filter2_txd_out(3),
      I1 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(19),
      I2 => BU2_U0_transmitter_recoder_n04691,
      I3 => BU2_U0_transmitter_recoder_n04681,
      O => BU2_N3450
    );
  BU2_U0_receiver_recoder_n095529 : LUT4_L
    generic map(
      INIT => X"FFEF"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(57),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(62),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(58),
      I3 => BU2_N3332,
      LO => BU2_CHOICE1890
    );
  BU2_U0_transmitter_state_machine_n0003_0_5 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_transmitter_k_r_prbs_i_prbs(8),
      I1 => BU2_U0_transmitter_state_machine_state_1_2,
      O => BU2_CHOICE2148
    );
  BU2_U0_receiver_recoder_n053766_SW0 : LUT3
    generic map(
      INIT => X"29"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(21),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(23),
      I2 => BU2_U0_receiver_recoder_rxd_half_pipe(22),
      O => BU2_N3159
    );
  BU2_U0_transmitter_recoder_n0434_SW0 : LUT4_L
    generic map(
      INIT => X"FF20"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(16),
      I1 => BU2_U0_transmitter_recoder_n0481,
      I2 => BU2_U0_transmitter_recoder_n0473,
      I3 => BU2_U0_transmitter_recoder_n0479,
      LO => BU2_N3504
    );
  BU2_U0_transmitter_recoder_n0452_SW0 : LUT4_L
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_n0474,
      I1 => BU2_U0_transmitter_filter7_txd_out(3),
      I2 => BU2_U0_transmitter_recoder_n0473,
      I3 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(27),
      LO => BU2_N2780
    );
  BU2_U0_transmitter_n026310 : LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(22),
      I1 => BU2_U0_transmitter_txd_pipe(23),
      I2 => BU2_U0_transmitter_txc_pipe(2),
      O => BU2_CHOICE1842
    );
  BU2_U0_receiver_non_iee_deskew_state_n004017 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => BU2_CHOICE1019,
      I1 => BU2_CHOICE1023,
      O => BU2_N112
    );
  BU2_U0_transmitter_n026429 : LUT4_L
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(56),
      I1 => BU2_U0_transmitter_txd_pipe(59),
      I2 => BU2_U0_transmitter_txd_pipe(60),
      I3 => BU2_U0_transmitter_txd_pipe(58),
      LO => BU2_CHOICE1929
    );
  BU2_U0_receiver_non_iee_deskew_state_n004016 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => mgt_rxdata_6(61),
      I1 => mgt_rxdata_6(63),
      I2 => mgt_rxdata_6(62),
      I3 => mgt_rxdata_6(60),
      O => BU2_CHOICE1023
    );
  BU2_U0_receiver_recoder_n0951109 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => BU2_N3679,
      I1 => BU2_CHOICE2065,
      I2 => BU2_CHOICE2069,
      O => BU2_U0_receiver_recoder_error_lane_6_Q
    );
  BU2_U0_receiver_recoder_n09396 : LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_pipe(3),
      I1 => BU2_U0_receiver_recoder_rxc_pipe(3),
      O => BU2_CHOICE2111
    );
  BU2_U0_receiver_recoder_n059011 : LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => mgt_rxdata_6(63),
      I1 => mgt_rxcharisk_7(7),
      I2 => mgt_rxdata_6(56),
      O => BU2_CHOICE1112
    );
  BU2_U0_receiver_n002128 : LUT4
    generic map(
      INIT => X"135F"
    )
    port map (
      I0 => mgt_rxdata_6(57),
      I1 => mgt_rxdata_6(59),
      I2 => mgt_rxdata_6(56),
      I3 => mgt_rxdata_6(58),
      O => BU2_CHOICE1337
    );
  BU2_U0_receiver_recoder_n0951104 : LUT4_D
    generic map(
      INIT => X"EEAE"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_pipe(2),
      I1 => BU2_CHOICE2071,
      I2 => BU2_U0_receiver_recoder_n0627,
      I3 => BU2_CHOICE2064,
      LO => BU2_N3679,
      O => BU2_CHOICE2077
    );
  BU2_U0_transmitter_n026442 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(61),
      I1 => BU2_U0_transmitter_txd_pipe(57),
      I2 => BU2_CHOICE1929,
      I3 => BU2_CHOICE1933,
      O => BU2_CHOICE1935
    );
  BU2_U0_receiver_recoder_n04891 : LUT4
    generic map(
      INIT => X"FFEF"
    )
    port map (
      I0 => BU2_U0_usrclk_reset,
      I1 => BU2_U0_receiver_recoder_n0545,
      I2 => NlwRenamedSig_OI_align_status,
      I3 => BU2_N3648,
      O => BU2_U0_receiver_recoder_n0489
    );
  BU2_U0_transmitter_filter3_n00227 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(26),
      I1 => BU2_U0_transmitter_txd_pipe(31),
      I2 => BU2_U0_transmitter_txd_pipe(25),
      I3 => BU2_U0_transmitter_txd_pipe(24),
      O => BU2_CHOICE1787
    );
  BU2_U0_receiver_recoder_n053748_SW1 : LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(20),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(19),
      I2 => BU2_U0_receiver_recoder_rxd_half_pipe(18),
      O => BU2_N3438
    );
  BU2_U0_receiver_n002139 : LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => mgt_rxdata_6(63),
      I1 => mgt_rxdata_6(61),
      I2 => mgt_rxdata_6(62),
      O => BU2_CHOICE1344
    );
  BU2_U0_receiver_n002228 : LUT4
    generic map(
      INIT => X"135F"
    )
    port map (
      I0 => mgt_rxdata_6(1),
      I1 => mgt_rxdata_6(3),
      I2 => mgt_rxdata_6(0),
      I3 => mgt_rxdata_6(2),
      O => BU2_CHOICE1365
    );
  BU2_U0_receiver_non_iee_deskew_state_n00408 : LUT4
    generic map(
      INIT => X"0008"
    )
    port map (
      I0 => mgt_rxdata_6(58),
      I1 => mgt_rxdata_6(59),
      I2 => mgt_rxdata_6(56),
      I3 => mgt_rxdata_6(57),
      O => BU2_CHOICE1019
    );
  BU2_U0_receiver_recoder_n09392 : LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_lane_terminate(0),
      I1 => BU2_U0_receiver_recoder_lane_terminate(1),
      I2 => BU2_U0_receiver_recoder_lane_terminate(2),
      O => BU2_CHOICE2108
    );
  BU2_U0_receiver_non_iee_deskew_state_Ker221_SW0 : LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => mgt_rxdata_6(12),
      I1 => mgt_rxdata_6(11),
      I2 => mgt_rxdata_6(10),
      I3 => BU2_CHOICE1152,
      O => BU2_N3536
    );
  BU2_U0_receiver_recoder_n058911 : LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => mgt_rxdata_6(47),
      I1 => mgt_rxcharisk_7(5),
      I2 => mgt_rxdata_6(40),
      O => BU2_CHOICE1130
    );
  BU2_U0_transmitter_n026435 : LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(62),
      I1 => BU2_U0_transmitter_txd_pipe(63),
      I2 => BU2_U0_transmitter_txc_pipe(7),
      O => BU2_CHOICE1933
    );
  BU2_U0_receiver_n001849 : LUT4
    generic map(
      INIT => X"AF8F"
    )
    port map (
      I0 => BU2_CHOICE1288,
      I1 => mgt_rxdata_6(8),
      I2 => mgt_rxdata_6(12),
      I3 => mgt_rxdata_6(9),
      O => BU2_CHOICE1290
    );
  BU2_U0_transmitter_n026329 : LUT4_L
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(24),
      I1 => BU2_U0_transmitter_txd_pipe(27),
      I2 => BU2_U0_transmitter_txd_pipe(28),
      I3 => BU2_U0_transmitter_txd_pipe(26),
      LO => BU2_CHOICE1847
    );
  BU2_U0_receiver_recoder_n092765 : LUT4
    generic map(
      INIT => X"3332"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_lane_term_pipe(1),
      I1 => BU2_U0_receiver_recoder_lane_term_pipe(0),
      I2 => BU2_U0_receiver_recoder_lane_term_pipe(2),
      I3 => BU2_U0_receiver_recoder_lane_term_pipe(3),
      O => BU2_CHOICE2142
    );
  BU2_U0_transmitter_recoder_n0405_SW0 : LUT4_L
    generic map(
      INIT => X"0C04"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_2,
      I1 => BU2_U0_transmitter_state_machine_state_0_0,
      I2 => BU2_N3450,
      I3 => BU2_U0_transmitter_state_machine_state_0_1,
      LO => BU2_N2856
    );
  BU2_U0_transmitter_recoder_n0411_SW0 : LUT4_L
    generic map(
      INIT => X"0C04"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_2,
      I1 => BU2_U0_transmitter_state_machine_state_0_0,
      I2 => BU2_N3448,
      I3 => BU2_U0_transmitter_state_machine_state_0_1,
      LO => BU2_N2854
    );
  BU2_U0_transmitter_recoder_n0442_SW0 : LUT4_L
    generic map(
      INIT => X"0C04"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_2,
      I1 => BU2_U0_transmitter_state_machine_state_0_0,
      I2 => BU2_N3446,
      I3 => BU2_U0_transmitter_state_machine_state_0_1,
      LO => BU2_N2852
    );
  BU2_U0_transmitter_recoder_n0473_26 : LUT2_D
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_0,
      I1 => BU2_U0_transmitter_state_machine_state_1_1,
      LO => BU2_N3678,
      O => BU2_U0_transmitter_recoder_n0473
    );
  BU2_U0_transmitter_recoder_n0421_SW0 : LUT4
    generic map(
      INIT => X"3211"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_2,
      I1 => BU2_U0_transmitter_state_machine_state_1_1,
      I2 => BU2_U0_transmitter_filter4_txd_out(5),
      I3 => BU2_U0_transmitter_state_machine_state_1_0,
      O => BU2_N1817
    );
  BU2_U0_receiver_n002439 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => mgt_rxdata_6(32),
      I1 => mgt_rxdata_6(33),
      O => BU2_CHOICE1232
    );
  BU2_U0_receiver_n002215 : LUT4
    generic map(
      INIT => X"9111"
    )
    port map (
      I0 => mgt_rxdata_6(2),
      I1 => mgt_rxdata_6(3),
      I2 => mgt_rxdata_6(0),
      I3 => mgt_rxdata_6(1),
      O => BU2_CHOICE1358
    );
  BU2_U0_receiver_recoder_n09437 : LUT4
    generic map(
      INIT => X"FFEF"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(33),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(32),
      I2 => BU2_U0_receiver_recoder_rxc_pipe(4),
      I3 => BU2_U0_receiver_recoder_code_error_pipe(4),
      O => BU2_CHOICE1897
    );
  BU2_U0_receiver_non_iee_deskew_state_n004217 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => BU2_CHOICE1009,
      I1 => BU2_CHOICE1013,
      O => BU2_N91
    );
  BU2_U0_transmitter_n026335 : LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(30),
      I1 => BU2_U0_transmitter_txd_pipe(31),
      I2 => BU2_U0_transmitter_txc_pipe(3),
      O => BU2_CHOICE1851
    );
  BU2_U0_receiver_non_iee_deskew_state_n004216 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => mgt_rxdata_6(21),
      I1 => mgt_rxdata_6(23),
      I2 => mgt_rxdata_6(22),
      I3 => mgt_rxdata_6(20),
      O => BU2_CHOICE1013
    );
  BU2_U0_transmitter_filter3_n002220 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(27),
      I1 => BU2_U0_transmitter_txd_pipe(28),
      I2 => BU2_U0_transmitter_txd_pipe(29),
      I3 => BU2_U0_transmitter_txd_pipe(30),
      O => BU2_CHOICE1794
    );
  BU2_U0_transmitter_recoder_n046216_SW0 : LUT3
    generic map(
      INIT => X"F1"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_2,
      I1 => BU2_U0_transmitter_filter6_txc_out,
      I2 => BU2_U0_transmitter_state_machine_state_1_1,
      O => BU2_N3610
    );
  BU2_U0_receiver_recoder_n09477 : LUT4
    generic map(
      INIT => X"FFEF"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(41),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(40),
      I2 => BU2_U0_receiver_recoder_rxc_pipe(5),
      I3 => BU2_U0_receiver_recoder_code_error_pipe(5),
      O => BU2_CHOICE2012
    );
  BU2_U0_transmitter_recoder_n045916_SW0 : LUT3
    generic map(
      INIT => X"F1"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_2,
      I1 => BU2_U0_transmitter_filter3_txc_out,
      I2 => BU2_U0_transmitter_state_machine_state_0_1,
      O => BU2_N3614
    );
  BU2_U0_transmitter_n026342 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(29),
      I1 => BU2_U0_transmitter_txd_pipe(25),
      I2 => BU2_CHOICE1847,
      I3 => BU2_CHOICE1851,
      O => BU2_CHOICE1853
    );
  BU2_U0_receiver_recoder_n094783 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(41),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(46),
      O => BU2_CHOICE2036
    );
  BU2_U0_transmitter_recoder_n0416_SW0 : LUT3
    generic map(
      INIT => X"F1"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_2,
      I1 => BU2_U0_transmitter_filter4_txd_out(2),
      I2 => BU2_U0_transmitter_state_machine_state_1_1,
      O => BU2_N3642
    );
  BU2_U0_receiver_recoder_Ker41_SW1 : LUT4
    generic map(
      INIT => X"FFDF"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(31),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(30),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(29),
      I3 => BU2_U0_receiver_recoder_rxd_pipe(24),
      O => BU2_N3166
    );
  BU2_U0_transmitter_n0263113_SW0 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(5),
      I1 => BU2_U0_transmitter_txd_pipe(1),
      I2 => BU2_CHOICE1857,
      I3 => BU2_CHOICE1861,
      O => BU2_N3139
    );
  BU2_U0_receiver_recoder_n059016_SW0 : LUT4
    generic map(
      INIT => X"F7FF"
    )
    port map (
      I0 => mgt_rxdata_6(59),
      I1 => mgt_rxdata_6(58),
      I2 => mgt_rxdata_6(57),
      I3 => BU2_CHOICE1112,
      O => BU2_N3550
    );
  BU2_U0_receiver_n002654_SW0 : LUT4
    generic map(
      INIT => X"135F"
    )
    port map (
      I0 => mgt_rxdata_6(48),
      I1 => mgt_rxdata_6(50),
      I2 => mgt_rxdata_6(49),
      I3 => mgt_rxdata_6(51),
      O => BU2_N3546
    );
  BU2_U0_receiver_non_iee_deskew_state_n00428 : LUT4
    generic map(
      INIT => X"0008"
    )
    port map (
      I0 => mgt_rxdata_6(18),
      I1 => mgt_rxdata_6(19),
      I2 => mgt_rxdata_6(16),
      I3 => mgt_rxdata_6(17),
      O => BU2_CHOICE1009
    );
  BU2_U0_receiver_recoder_n093176_SW0 : LUT3
    generic map(
      INIT => X"FB"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_delay(1),
      I1 => NlwRenamedSig_OI_align_status,
      I2 => BU2_U0_usrclk_reset_1,
      O => BU2_N3127
    );
  BU2_U0_receiver_n002049 : LUT4
    generic map(
      INIT => X"AF8F"
    )
    port map (
      I0 => BU2_CHOICE1316,
      I1 => mgt_rxdata_6(40),
      I2 => mgt_rxdata_6(44),
      I3 => mgt_rxdata_6(41),
      O => BU2_CHOICE1318
    );
  BU2_U0_receiver_recoder_n058816 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => mgt_rxdata_6(29),
      I1 => BU2_N3544,
      I2 => mgt_rxdata_6(28),
      I3 => mgt_rxdata_6(30),
      O => BU2_N319
    );
  BU2_U0_transmitter_recoder_n0416_27 : LUT4
    generic map(
      INIT => X"F777"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_0,
      I1 => BU2_N3642,
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(2),
      I3 => BU2_U0_transmitter_state_machine_state_1_1,
      O => BU2_U0_transmitter_recoder_n0416
    );
  BU2_U0_receiver_n002015 : LUT4
    generic map(
      INIT => X"9111"
    )
    port map (
      I0 => mgt_rxdata_6(42),
      I1 => mgt_rxdata_6(43),
      I2 => mgt_rxdata_6(40),
      I3 => mgt_rxdata_6(41),
      O => BU2_CHOICE1302
    );
  BU2_U0_receiver_n002054 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_CHOICE1309,
      I1 => BU2_CHOICE1318,
      O => BU2_CHOICE1319
    );
  BU2_U0_receiver_recoder_n058916_SW0 : LUT4
    generic map(
      INIT => X"F7FF"
    )
    port map (
      I0 => mgt_rxdata_6(43),
      I1 => mgt_rxdata_6(42),
      I2 => mgt_rxdata_6(41),
      I3 => BU2_CHOICE1130,
      O => BU2_N3548
    );
  BU2_U0_transmitter_recoder_n0402181_SW0 : LUT4
    generic map(
      INIT => X"7277"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_1,
      I1 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(22),
      I2 => BU2_U0_transmitter_state_machine_state_0_2,
      I3 => BU2_U0_transmitter_filter2_txd_out(6),
      O => BU2_N3626
    );
  BU2_U0_transmitter_filter1_n00227 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(10),
      I1 => BU2_U0_transmitter_txd_pipe(15),
      I2 => BU2_U0_transmitter_txd_pipe(9),
      I3 => BU2_U0_transmitter_txd_pipe(8),
      O => BU2_CHOICE1800
    );
  BU2_U0_transmitter_align_n0042_SW1 : LUT4
    generic map(
      INIT => X"FEFF"
    )
    port map (
      I0 => BU2_U0_transmitter_align_count(4),
      I1 => BU2_U0_transmitter_align_count(3),
      I2 => BU2_N3683,
      I3 => BU2_CHOICE2119,
      O => BU2_N3164
    );
  BU2_U0_receiver_n001854 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_CHOICE1281,
      I1 => BU2_CHOICE1290,
      O => BU2_CHOICE1291
    );
  BU2_U0_receiver_n002415 : LUT4
    generic map(
      INIT => X"9111"
    )
    port map (
      I0 => mgt_rxdata_6(34),
      I1 => mgt_rxdata_6(35),
      I2 => mgt_rxdata_6(32),
      I3 => mgt_rxdata_6(33),
      O => BU2_CHOICE1218
    );
  BU2_U0_transmitter_n026365 : LUT4_L
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(0),
      I1 => BU2_U0_transmitter_txd_pipe(3),
      I2 => BU2_U0_transmitter_txd_pipe(4),
      I3 => BU2_U0_transmitter_txd_pipe(2),
      LO => BU2_CHOICE1857
    );
  BU2_U0_receiver_recoder_n092732_SW0 : LUT4_D
    generic map(
      INIT => X"F9FF"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(7),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(6),
      I2 => BU2_N3326,
      I3 => BU2_U0_receiver_recoder_rxd_pipe(5),
      LO => BU2_N3677,
      O => BU2_N3143
    );
  BU2_U0_transmitter_n026465 : LUT4_L
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(32),
      I1 => BU2_U0_transmitter_txd_pipe(35),
      I2 => BU2_U0_transmitter_txd_pipe(36),
      I3 => BU2_U0_transmitter_txd_pipe(34),
      LO => BU2_CHOICE1939
    );
  BU2_U0_receiver_non_iee_deskew_state_n004317 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => BU2_CHOICE999,
      I1 => BU2_CHOICE1003,
      O => BU2_N70
    );
  BU2_U0_receiver_recoder_n093551 : LUT4_D
    generic map(
      INIT => X"0002"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_lane_term_pipe(3),
      I1 => BU2_U0_receiver_recoder_lane_term_pipe(2),
      I2 => BU2_U0_receiver_recoder_lane_term_pipe(0),
      I3 => BU2_U0_receiver_recoder_lane_term_pipe(1),
      LO => BU2_N3676,
      O => BU2_CHOICE2179
    );
  BU2_U0_receiver_non_iee_deskew_state_n004316 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => mgt_rxdata_6(37),
      I1 => mgt_rxdata_6(39),
      I2 => mgt_rxdata_6(38),
      I3 => mgt_rxdata_6(36),
      O => BU2_CHOICE1003
    );
  BU2_U0_receiver_recoder_n059116_SW0 : LUT4
    generic map(
      INIT => X"F7FF"
    )
    port map (
      I0 => mgt_rxdata_6(3),
      I1 => mgt_rxdata_6(2),
      I2 => mgt_rxdata_6(1),
      I3 => BU2_CHOICE1094,
      O => BU2_N3538
    );
  BU2_U0_receiver_recoder_n095186 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_lane_terminate(4),
      I1 => BU2_U0_receiver_recoder_lane_terminate(5),
      O => BU2_CHOICE2071
    );
  BU2_U0_receiver_recoder_Ker40_SW1 : LUT4_L
    generic map(
      INIT => X"FFDF"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(12),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(9),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(10),
      I3 => BU2_U0_receiver_recoder_code_error_pipe(1),
      LO => BU2_N3494
    );
  BU2_U0_receiver_non_iee_deskew_state_Ker320 : LUT4
    generic map(
      INIT => X"0008"
    )
    port map (
      I0 => mgt_rxdata_6(4),
      I1 => mgt_rxdata_6(5),
      I2 => mgt_rxdata_6(7),
      I3 => BU2_N3542,
      O => BU2_N361
    );
  BU2_U0_receiver_n001828 : LUT4
    generic map(
      INIT => X"135F"
    )
    port map (
      I0 => mgt_rxdata_6(9),
      I1 => mgt_rxdata_6(11),
      I2 => mgt_rxdata_6(8),
      I3 => mgt_rxdata_6(10),
      O => BU2_CHOICE1281
    );
  BU2_U0_receiver_recoder_n09517 : LUT4
    generic map(
      INIT => X"FFEF"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(55),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(49),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(50),
      I3 => BU2_U0_receiver_recoder_rxd_pipe(48),
      O => BU2_CHOICE2052
    );
  BU2_U0_transmitter_recoder_n0442_SW0_SW0 : LUT4
    generic map(
      INIT => X"F53F"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(3),
      I1 => BU2_U0_transmitter_filter0_txd_out(3),
      I2 => BU2_N3702,
      I3 => BU2_U0_transmitter_recoder_n04681,
      O => BU2_N3446
    );
  BU2_U0_transmitter_n026371 : LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(6),
      I1 => BU2_U0_transmitter_txd_pipe(7),
      I2 => BU2_U0_transmitter_txc_pipe(0),
      O => BU2_CHOICE1861
    );
  BU2_U0_receiver_n002644 : LUT4
    generic map(
      INIT => X"2AAA"
    )
    port map (
      I0 => BU2_CHOICE1176,
      I1 => mgt_rxdata_6(55),
      I2 => mgt_rxdata_6(53),
      I3 => mgt_rxdata_6(54),
      O => BU2_CHOICE1177
    );
  BU2_U0_receiver_n002315 : LUT4
    generic map(
      INIT => X"9111"
    )
    port map (
      I0 => mgt_rxdata_6(18),
      I1 => mgt_rxdata_6(19),
      I2 => mgt_rxdata_6(16),
      I3 => mgt_rxdata_6(17),
      O => BU2_CHOICE1190
    );
  BU2_U0_n00101_1 : LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => BU2_U0_usrclk_reset_1,
      I1 => NlwRenamedSig_OI_align_status,
      O => BU2_U0_n00101
    );
  BU2_U0_receiver_non_iee_deskew_state_n00438 : LUT4
    generic map(
      INIT => X"0008"
    )
    port map (
      I0 => mgt_rxdata_6(34),
      I1 => mgt_rxdata_6(35),
      I2 => mgt_rxdata_6(32),
      I3 => mgt_rxdata_6(33),
      O => BU2_CHOICE999
    );
  BU2_U0_receiver_non_iee_deskew_state_n00258 : LUT4
    generic map(
      INIT => X"FF80"
    )
    port map (
      I0 => BU2_CHOICE989,
      I1 => BU2_CHOICE993,
      I2 => mgt_rxcharisk_7(6),
      I3 => BU2_N361,
      O => BU2_CHOICE1058
    );
  BU2_U0_transmitter_filter1_n002220 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(11),
      I1 => BU2_U0_transmitter_txd_pipe(12),
      I2 => BU2_U0_transmitter_txd_pipe(13),
      I3 => BU2_U0_transmitter_txd_pipe(14),
      O => BU2_CHOICE1807
    );
  BU2_U0_receiver_recoder_n04911 : LUT4
    generic map(
      INIT => X"FFF8"
    )
    port map (
      I0 => BU2_N3688,
      I1 => BU2_CHOICE2026,
      I2 => BU2_N3434,
      I3 => BU2_CHOICE2046,
      O => BU2_U0_receiver_recoder_n0491
    );
  BU2_U0_transmitter_n026471 : LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(38),
      I1 => BU2_U0_transmitter_txd_pipe(39),
      I2 => BU2_U0_transmitter_txc_pipe(4),
      O => BU2_CHOICE1943
    );
  BU2_U0_receiver_n002328 : LUT4
    generic map(
      INIT => X"135F"
    )
    port map (
      I0 => mgt_rxdata_6(17),
      I1 => mgt_rxdata_6(19),
      I2 => mgt_rxdata_6(16),
      I3 => mgt_rxdata_6(18),
      O => BU2_CHOICE1197
    );
  BU2_U0_receiver_n002249 : LUT4
    generic map(
      INIT => X"AF8F"
    )
    port map (
      I0 => BU2_CHOICE1372,
      I1 => mgt_rxdata_6(0),
      I2 => mgt_rxdata_6(4),
      I3 => mgt_rxdata_6(1),
      O => BU2_CHOICE1374
    );
  BU2_U0_transmitter_recoder_n0404_28 : LUT4_L
    generic map(
      INIT => X"21AB"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_0,
      I1 => BU2_U0_transmitter_state_machine_state_0_1,
      I2 => BU2_U0_transmitter_state_machine_state_0_2,
      I3 => BU2_N971,
      LO => BU2_U0_transmitter_recoder_n0404
    );
  BU2_U0_receiver_recoder_n093534 : LUT4
    generic map(
      INIT => X"FFF9"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(22),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(23),
      I2 => BU2_N3492,
      I3 => BU2_N3512,
      O => BU2_CHOICE2173
    );
  BU2_U0_receiver_recoder_n0551_SW0 : LUT3
    generic map(
      INIT => X"B6"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(22),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(21),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(23),
      O => BU2_N992
    );
  BU2_U0_receiver_recoder_n094782 : LUT4
    generic map(
      INIT => X"FFDF"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(43),
      I1 => BU2_U0_receiver_recoder_code_error_pipe(5),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(44),
      I3 => BU2_U0_receiver_recoder_rxd_pipe(40),
      O => BU2_CHOICE2035
    );
  BU2_U0_receiver_recoder_n094329 : LUT4_D
    generic map(
      INIT => X"7FFF"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(34),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(35),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(36),
      I3 => BU2_U0_receiver_recoder_rxd_pipe(37),
      LO => BU2_N3675,
      O => BU2_CHOICE1909
    );
  BU2_U0_receiver_recoder_n094796 : LUT4
    generic map(
      INIT => X"7FFF"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(45),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(47),
      I2 => BU2_U0_receiver_recoder_rxc_pipe(5),
      I3 => BU2_U0_receiver_recoder_rxd_pipe(42),
      O => BU2_CHOICE2043
    );
  BU2_U0_receiver_recoder_n06273 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(54),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(55),
      O => BU2_CHOICE2001
    );
  BU2_U0_transmitter_recoder_n0408181_SW0 : LUT4
    generic map(
      INIT => X"7277"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_1,
      I1 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(30),
      I2 => BU2_U0_transmitter_state_machine_state_0_2,
      I3 => BU2_U0_transmitter_filter3_txd_out(6),
      O => BU2_N3620
    );
  BU2_U0_receiver_recoder_n059316 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => mgt_rxdata_6(21),
      I1 => BU2_N3540,
      I2 => mgt_rxdata_6(20),
      I3 => mgt_rxdata_6(22),
      O => BU2_N281
    );
  BU2_U0_receiver_non_iee_deskew_state_n004417 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => BU2_CHOICE989,
      I1 => BU2_CHOICE993,
      O => BU2_N49
    );
  BU2_U0_transmitter_n026390 : LUT4_L
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(8),
      I1 => BU2_U0_transmitter_txd_pipe(11),
      I2 => BU2_U0_transmitter_txd_pipe(12),
      I3 => BU2_U0_transmitter_txd_pipe(10),
      LO => BU2_CHOICE1866
    );
  BU2_U0_receiver_non_iee_deskew_state_n004416 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => mgt_rxdata_6(53),
      I1 => mgt_rxdata_6(55),
      I2 => mgt_rxdata_6(54),
      I3 => mgt_rxdata_6(52),
      O => BU2_CHOICE993
    );
  BU2_U0_receiver_recoder_n094334 : LUT3
    generic map(
      INIT => X"F9"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(38),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(39),
      I2 => BU2_N3675,
      O => BU2_CHOICE1910
    );
  BU2_U0_receiver_n002239 : LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => mgt_rxdata_6(7),
      I1 => mgt_rxdata_6(5),
      I2 => mgt_rxdata_6(6),
      O => BU2_CHOICE1372
    );
  BU2_U0_receiver_n001949 : LUT4
    generic map(
      INIT => X"AF8F"
    )
    port map (
      I0 => BU2_CHOICE1260,
      I1 => mgt_rxdata_6(24),
      I2 => mgt_rxdata_6(28),
      I3 => mgt_rxdata_6(25),
      O => BU2_CHOICE1262
    );
  BU2_U0_transmitter_filter1_n0007_0_1_SW0 : LUT3_D
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => BU2_CHOICE1807,
      I1 => BU2_CHOICE1800,
      I2 => BU2_U0_transmitter_n0263,
      LO => BU2_N3674,
      O => BU2_N3414
    );
  BU2_U0_transmitter_filter2_n00227 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(18),
      I1 => BU2_U0_transmitter_txd_pipe(23),
      I2 => BU2_U0_transmitter_txd_pipe(17),
      I3 => BU2_U0_transmitter_txd_pipe(16),
      O => BU2_CHOICE1813
    );
  BU2_U0_receiver_recoder_n059116 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => mgt_rxdata_6(5),
      I1 => BU2_N3538,
      I2 => mgt_rxdata_6(4),
      I3 => mgt_rxdata_6(6),
      O => BU2_N262
    );
  BU2_U0_receiver_n002354 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_CHOICE1197,
      I1 => BU2_CHOICE1206,
      O => BU2_CHOICE1207
    );
  BU2_U0_receiver_n002115 : LUT4
    generic map(
      INIT => X"9111"
    )
    port map (
      I0 => mgt_rxdata_6(58),
      I1 => mgt_rxdata_6(59),
      I2 => mgt_rxdata_6(56),
      I3 => mgt_rxdata_6(57),
      O => BU2_CHOICE1330
    );
  BU2_U0_receiver_recoder_n095150 : LUT4_D
    generic map(
      INIT => X"FF0E"
    )
    port map (
      I0 => BU2_CHOICE2052,
      I1 => BU2_CHOICE2059,
      I2 => BU2_U0_receiver_recoder_n0627,
      I3 => BU2_CHOICE2064,
      LO => BU2_N3673,
      O => BU2_CHOICE2065
    );
  BU2_U0_receiver_non_iee_deskew_state_Ker313 : LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => mgt_rxdata_6(6),
      I1 => mgt_rxcharisk_7(0),
      I2 => mgt_rxdata_6(0),
      O => BU2_CHOICE1141
    );
  BU2_U0_transmitter_n026396 : LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(14),
      I1 => BU2_U0_transmitter_txd_pipe(15),
      I2 => BU2_U0_transmitter_txc_pipe(1),
      O => BU2_CHOICE1870
    );
  BU2_U0_receiver_non_iee_deskew_state_n00448 : LUT4
    generic map(
      INIT => X"0008"
    )
    port map (
      I0 => mgt_rxdata_6(50),
      I1 => mgt_rxdata_6(51),
      I2 => mgt_rxdata_6(48),
      I3 => mgt_rxdata_6(49),
      O => BU2_CHOICE989
    );
  BU2_U0_receiver_recoder_n059311 : LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => mgt_rxdata_6(23),
      I1 => mgt_rxcharisk_7(2),
      I2 => mgt_rxdata_6(16),
      O => BU2_CHOICE1103
    );
  BU2_U0_receiver_recoder_n092732_SW0_SW0 : LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_pipe(0),
      I1 => BU2_U0_receiver_recoder_rxc_pipe(0),
      O => BU2_N3326
    );
  BU2_U0_receiver_recoder_n095169 : LUT4_D
    generic map(
      INIT => X"0002"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_lane_terminate(3),
      I1 => BU2_U0_receiver_recoder_lane_terminate(2),
      I2 => BU2_U0_receiver_recoder_lane_terminate(0),
      I3 => BU2_U0_receiver_recoder_lane_terminate(1),
      LO => BU2_N3672,
      O => BU2_CHOICE2069
    );
  BU2_U0_transmitter_recoder_n04567 : LUT3
    generic map(
      INIT => X"8F"
    )
    port map (
      I0 => configuration_vector_14(5),
      I1 => configuration_vector_14(6),
      I2 => configuration_vector_14(4),
      O => BU2_CHOICE1975
    );
  BU2_U0_transmitter_n026490 : LUT4_L
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(40),
      I1 => BU2_U0_transmitter_txd_pipe(43),
      I2 => BU2_U0_transmitter_txd_pipe(44),
      I3 => BU2_U0_transmitter_txd_pipe(42),
      LO => BU2_CHOICE1948
    );
  BU2_U0_receiver_recoder_n062716 : LUT4_L
    generic map(
      INIT => X"0008"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(50),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(51),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(48),
      I3 => BU2_U0_receiver_recoder_rxd_pipe(49),
      LO => BU2_CHOICE2007
    );
  BU2_U0_receiver_recoder_n095146 : LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_pipe(6),
      I1 => BU2_U0_receiver_recoder_rxc_pipe(6),
      O => BU2_CHOICE2064
    );
  BU2_U0_transmitter_n0264103 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(45),
      I1 => BU2_U0_transmitter_txd_pipe(41),
      I2 => BU2_CHOICE1948,
      I3 => BU2_CHOICE1952,
      O => BU2_CHOICE1954
    );
  BU2_U0_receiver_recoder_n094729 : LUT4_L
    generic map(
      INIT => X"7FFF"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(42),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(43),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(44),
      I3 => BU2_U0_receiver_recoder_rxd_pipe(45),
      LO => BU2_CHOICE2024
    );
  BU2_U0_transmitter_recoder_n04471_SW0 : LUT4
    generic map(
      INIT => X"7277"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1,
      I1 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(30),
      I2 => BU2_U0_transmitter_state_machine_state_1_2,
      I3 => BU2_U0_transmitter_filter7_txd_out(6),
      O => BU2_N3560
    );
  BU2_U0_receiver_n001815 : LUT4
    generic map(
      INIT => X"9111"
    )
    port map (
      I0 => mgt_rxdata_6(10),
      I1 => mgt_rxdata_6(11),
      I2 => mgt_rxdata_6(8),
      I3 => mgt_rxdata_6(9),
      O => BU2_CHOICE1274
    );
  BU2_U0_receiver_recoder_n093573 : LUT4_D
    generic map(
      INIT => X"E0EE"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_lane_terminate(1),
      I1 => BU2_U0_receiver_recoder_lane_terminate(0),
      I2 => BU2_N3155,
      I3 => BU2_U0_receiver_recoder_N39,
      LO => BU2_N3671,
      O => BU2_CHOICE2183
    );
  BU2_U0_transmitter_recoder_n0397_SW0 : LUT4_L
    generic map(
      INIT => X"B5BF"
    )
    port map (
      I0 => BU2_U0_transmitter_tx_code_d(0),
      I1 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(15),
      I2 => BU2_U0_transmitter_tx_code_q(0),
      I3 => BU2_U0_transmitter_filter1_txd_out(7),
      LO => BU2_N973
    );
  BU2_U0_receiver_non_iee_deskew_state_n0022_SW0 : LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => BU2_N383,
      I1 => mgt_rxcharisk_7(7),
      I2 => mgt_rxcharisk_7(5),
      I3 => mgt_rxcharisk_7(3),
      O => BU2_N30
    );
  BU2_U0_receiver_non_iee_deskew_state_n0023_SW0 : LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => BU2_N361,
      I1 => mgt_rxcharisk_7(6),
      I2 => mgt_rxcharisk_7(4),
      I3 => mgt_rxcharisk_7(2),
      O => BU2_N28
    );
  BU2_U0_receiver_recoder_n04881 : LUT4
    generic map(
      INIT => X"AA8A"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(28),
      I1 => BU2_N3330,
      I2 => BU2_U0_receiver_recoder_rxd_half_pipe(27),
      I3 => BU2_N3480,
      O => BU2_U0_receiver_recoder_n0488
    );
  BU2_U0_transmitter_recoder_n0451181_SW0 : LUT4
    generic map(
      INIT => X"7277"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_1,
      I1 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(6),
      I2 => BU2_U0_transmitter_state_machine_state_0_2,
      I3 => BU2_U0_transmitter_filter0_txd_out(6),
      O => BU2_N3622
    );
  BU2_U0_transmitter_align_n0003_0_1 : LUT4
    generic map(
      INIT => X"ABA8"
    )
    port map (
      I0 => BU2_U0_transmitter_align_prbs(1),
      I1 => BU2_U0_transmitter_tx_code_a(0),
      I2 => BU2_U0_transmitter_tx_code_a(1),
      I3 => BU2_U0_transmitter_align_count(0),
      O => BU2_U0_transmitter_align_n0003(0)
    );
  BU2_U0_transmitter_align_n0003_1_1 : LUT4
    generic map(
      INIT => X"A8AB"
    )
    port map (
      I0 => BU2_U0_transmitter_align_prbs(2),
      I1 => BU2_U0_transmitter_tx_code_a(1),
      I2 => BU2_U0_transmitter_tx_code_a(0),
      I3 => BU2_U0_transmitter_align_count(1),
      O => BU2_U0_transmitter_align_n0003(1)
    );
  BU2_U0_receiver_n002339 : LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => mgt_rxdata_6(23),
      I1 => mgt_rxdata_6(21),
      I2 => mgt_rxdata_6(22),
      O => BU2_CHOICE1204
    );
  BU2_U0_transmitter_align_count_2 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_transmitter_align_n0003(2),
      R => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_align_n0024,
      C => usrclk,
      Q => BU2_U0_transmitter_align_count(2)
    );
  BU2_U0_transmitter_align_count_0 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_transmitter_align_n0003(0),
      R => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_align_n0024,
      C => usrclk,
      Q => BU2_U0_transmitter_align_count(0)
    );
  BU2_U0_transmitter_align_prbs_1 : FDSE
    generic map(
      INIT => '1'
    )
    port map (
      D => BU2_U0_transmitter_align_n0005,
      S => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_align_N4,
      C => usrclk,
      Q => BU2_U0_transmitter_align_prbs(1)
    );
  BU2_U0_transmitter_align_prbs_6 : FDSE
    generic map(
      INIT => '1'
    )
    port map (
      D => BU2_U0_transmitter_align_prbs(5),
      S => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_align_N4,
      C => usrclk,
      Q => BU2_U0_transmitter_align_prbs(6)
    );
  BU2_U0_transmitter_align_prbs_4 : FDSE
    generic map(
      INIT => '1'
    )
    port map (
      D => BU2_U0_transmitter_align_prbs(3),
      S => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_align_N4,
      C => usrclk,
      Q => BU2_U0_transmitter_align_prbs(4)
    );
  BU2_U0_transmitter_align_n00241 : LUT4_L
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => BU2_U0_transmitter_align_count(3),
      I1 => BU2_U0_transmitter_align_count(4),
      I2 => BU2_U0_transmitter_tx_code_a(0),
      I3 => BU2_U0_transmitter_tx_code_a(1),
      LO => BU2_U0_transmitter_align_N3
    );
  BU2_U0_transmitter_align_a_cnt_1_Q : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => BU2_N3652,
      I1 => BU2_U0_transmitter_align_count(4),
      I2 => BU2_U0_transmitter_align_count(3),
      I3 => BU2_N2049,
      O => BU2_U0_transmitter_a_due(1)
    );
  BU2_U0_transmitter_align_count_4 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_transmitter_align_n0003(4),
      R => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_align_n0024,
      C => usrclk,
      Q => BU2_U0_transmitter_align_count(4)
    );
  BU2_U0_transmitter_align_count_1 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_transmitter_align_n0003(1),
      R => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_align_n0024,
      C => usrclk,
      Q => BU2_U0_transmitter_align_count(1)
    );
  BU2_U0_transmitter_align_prbs_2 : FDSE
    generic map(
      INIT => '1'
    )
    port map (
      D => BU2_U0_transmitter_align_prbs(1),
      S => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_align_N4,
      C => usrclk,
      Q => BU2_U0_transmitter_align_prbs(2)
    );
  BU2_U0_transmitter_align_count_3 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_transmitter_align_n0003(3),
      R => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_align_n0024,
      C => usrclk,
      Q => BU2_U0_transmitter_align_count(3)
    );
  BU2_U0_transmitter_align_n0003_2_2 : LUT4
    generic map(
      INIT => X"B88B"
    )
    port map (
      I0 => BU2_U0_transmitter_align_prbs(3),
      I1 => BU2_U0_transmitter_align_N4,
      I2 => BU2_U0_transmitter_align_count(2),
      I3 => BU2_U0_transmitter_align_count(1),
      O => BU2_U0_transmitter_align_n0003(2)
    );
  BU2_U0_transmitter_align_Mxor_n0005_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_transmitter_align_prbs(7),
      I1 => BU2_U0_transmitter_align_prbs(6),
      O => BU2_U0_transmitter_align_n0005
    );
  BU2_U0_transmitter_align_n0003_4_Q : LUT4
    generic map(
      INIT => X"FF9C"
    )
    port map (
      I0 => BU2_U0_transmitter_align_count(3),
      I1 => BU2_U0_transmitter_align_count(4),
      I2 => BU2_N922,
      I3 => BU2_U0_transmitter_align_N4,
      O => BU2_U0_transmitter_align_n0003(4)
    );
  BU2_U0_transmitter_align_extra_a_29 : FDRE
    port map (
      D => NlwRenamedSig_OI_mgt_enable_align(0),
      R => BU2_U0_transmitter_align_n0006,
      CE => BU2_U0_transmitter_align_n0007,
      C => usrclk,
      Q => BU2_U0_transmitter_align_extra_a
    );
  BU2_U0_receiver_recoder_n058816_SW0 : LUT4
    generic map(
      INIT => X"F7FF"
    )
    port map (
      I0 => mgt_rxdata_6(27),
      I1 => mgt_rxdata_6(26),
      I2 => mgt_rxdata_6(25),
      I3 => BU2_CHOICE1121,
      O => BU2_N3544
    );
  BU2_U0_transmitter_filter2_n002220 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(19),
      I1 => BU2_U0_transmitter_txd_pipe(20),
      I2 => BU2_U0_transmitter_txd_pipe(21),
      I3 => BU2_U0_transmitter_txd_pipe(22),
      O => BU2_CHOICE1820
    );
  BU2_U0_transmitter_recoder_n04291_SW0 : LUT4
    generic map(
      INIT => X"7277"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1,
      I1 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(14),
      I2 => BU2_U0_transmitter_state_machine_state_1_2,
      I3 => BU2_U0_transmitter_filter5_txd_out(6),
      O => BU2_N3564
    );
  BU2_U0_receiver_non_iee_deskew_state_n0022_30 : LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => BU2_N112,
      I1 => BU2_N133,
      I2 => BU2_N154,
      I3 => BU2_N30,
      O => BU2_U0_receiver_non_iee_deskew_state_n0022
    );
  BU2_U0_receiver_recoder_n094362 : LUT4_D
    generic map(
      INIT => X"3332"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_lane_terminate(1),
      I1 => BU2_U0_receiver_recoder_lane_terminate(0),
      I2 => BU2_U0_receiver_recoder_lane_terminate(2),
      I3 => BU2_U0_receiver_recoder_lane_terminate(3),
      LO => BU2_N3670,
      O => BU2_CHOICE1915
    );
  BU2_U0_transmitter_n0263123 : LUT4_D
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => BU2_CHOICE1872,
      I1 => BU2_CHOICE1853,
      I2 => BU2_CHOICE1844,
      I3 => BU2_N3139,
      LO => BU2_N3669,
      O => BU2_U0_transmitter_n0263
    );
  BU2_U0_transmitter_recoder_n04231_SW0 : LUT4
    generic map(
      INIT => X"7277"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1,
      I1 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(6),
      I2 => BU2_U0_transmitter_state_machine_state_1_2,
      I3 => BU2_U0_transmitter_filter4_txd_out(6),
      O => BU2_N3566
    );
  BU2_U0_receiver_non_iee_deskew_state_n0023_31 : LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => BU2_N49,
      I1 => BU2_N70,
      I2 => BU2_N91,
      I3 => BU2_N28,
      O => BU2_U0_receiver_non_iee_deskew_state_n0023
    );
  BU2_U0_transmitter_recoder_Ker341 : LUT3
    generic map(
      INIT => X"2F"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_2,
      I1 => BU2_U0_transmitter_state_machine_state_1_1,
      I2 => BU2_U0_transmitter_state_machine_state_1_0,
      O => BU2_U0_transmitter_recoder_N34
    );
  BU2_U0_transmitter_n026496 : LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(46),
      I1 => BU2_U0_transmitter_txd_pipe(47),
      I2 => BU2_U0_transmitter_txc_pipe(5),
      O => BU2_CHOICE1952
    );
  BU2_U0_receiver_n002149 : LUT4
    generic map(
      INIT => X"AF8F"
    )
    port map (
      I0 => BU2_CHOICE1344,
      I1 => mgt_rxdata_6(56),
      I2 => mgt_rxdata_6(60),
      I3 => mgt_rxdata_6(57),
      O => BU2_CHOICE1346
    );
  BU2_U0_transmitter_recoder_n0450_SW1 : LUT3
    generic map(
      INIT => X"AD"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_0,
      I1 => BU2_U0_transmitter_filter7_txd_out(7),
      I2 => BU2_U0_transmitter_state_machine_state_1_2,
      O => BU2_N3600
    );
  BU2_U0_receiver_non_iee_deskew_state_n00261 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => NlwRenamedSig_OI_align_status,
      I1 => BU2_U0_receiver_sync_status,
      O => mgt_enchansync
    );
  BU2_U0_receiver_recoder_n09552 : LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_lane_terminate(4),
      I1 => BU2_U0_receiver_recoder_lane_terminate(5),
      I2 => BU2_U0_receiver_recoder_lane_terminate(6),
      O => BU2_CHOICE1876
    );
  BU2_U0_receiver_non_iee_deskew_state_got_align_0 : FDR
    port map (
      D => BU2_U0_receiver_non_iee_deskew_state_n0022,
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_non_iee_deskew_state_got_align(0)
    );
  BU2_U0_receiver_non_iee_deskew_state_got_align_1 : FDR
    port map (
      D => BU2_U0_receiver_non_iee_deskew_state_n0023,
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_non_iee_deskew_state_got_align(1)
    );
  BU2_U0_receiver_non_iee_deskew_state_deskew_error_0 : FDR
    port map (
      D => BU2_N172,
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_non_iee_deskew_state_deskew_error(0)
    );
  BU2_U0_receiver_non_iee_deskew_state_deskew_error_1 : FDR
    port map (
      D => BU2_N188,
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_non_iee_deskew_state_deskew_error(1)
    );
  BU2_U0_receiver_non_iee_deskew_state_state_1 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_U0_receiver_non_iee_deskew_state_next_state(1),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => NlwRenamedSig_OI_align_status
    );
  BU2_U0_receiver_non_iee_deskew_state_n00661_SW0 : LUT3
    generic map(
      INIT => X"4E"
    )
    port map (
      I0 => NlwRenamedSig_OI_align_status,
      I1 => BU2_U0_receiver_non_iee_deskew_state_got_align(0),
      I2 => BU2_U0_receiver_non_iee_deskew_state_deskew_error(0),
      O => BU2_N3121
    );
  BU2_U0_transmitter_state_machine_n00121 : LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_0,
      I1 => BU2_U0_transmitter_state_machine_state_0_1,
      I2 => BU2_U0_transmitter_state_machine_state_1_0,
      I3 => BU2_U0_transmitter_state_machine_state_1_1,
      O => BU2_U0_transmitter_clear_q_det
    );
  BU2_U0_receiver_recoder_n092785_SW0 : LUT3_L
    generic map(
      INIT => X"FB"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_delay(0),
      I1 => NlwRenamedSig_OI_align_status,
      I2 => BU2_U0_usrclk_reset_1,
      LO => BU2_N3432
    );
  BU2_U0_transmitter_state_machine_state_1_1_32 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_N3661,
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_state_machine_state_1_1
    );
  BU2_U0_transmitter_state_machine_state_1_2_33 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_N3663,
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_state_machine_state_1_2
    );
  BU2_U0_transmitter_state_machine_state_0_2_34 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_N3664,
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_state_machine_state_0_2
    );
  BU2_U0_transmitter_state_machine_n0069_0_1 : LUT4_D
    generic map(
      INIT => X"04F7"
    )
    port map (
      I0 => BU2_CHOICE2155,
      I1 => BU2_U0_transmitter_a_due(1),
      I2 => BU2_U0_transmitter_state_machine_n0003(1),
      I3 => BU2_N3161,
      LO => BU2_N3668,
      O => BU2_N3120
    );
  BU2_U0_transmitter_state_machine_n00601 : LUT4
    generic map(
      INIT => X"111F"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_2,
      I1 => BU2_U0_transmitter_state_machine_state_1_0,
      I2 => BU2_U0_transmitter_state_machine_state_0_2,
      I3 => BU2_U0_transmitter_state_machine_state_0_0,
      O => BU2_U0_transmitter_state_machine_n0060
    );
  BU2_U0_transmitter_state_machine_Ker13 : LUT4
    generic map(
      INIT => X"0C08"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_q_det,
      I1 => BU2_U0_transmitter_state_machine_n0003(1),
      I2 => BU2_U0_transmitter_state_machine_n0003(0),
      I3 => BU2_N3700,
      O => BU2_U0_transmitter_state_machine_N13
    );
  BU2_U0_transmitter_state_machine_n0003_1_22 : LUT4_D
    generic map(
      INIT => X"AA02"
    )
    port map (
      I0 => BU2_CHOICE2115,
      I1 => BU2_U0_transmitter_align_N4,
      I2 => BU2_N3164,
      I3 => BU2_U0_transmitter_state_machine_N12,
      LO => BU2_N3667,
      O => BU2_U0_transmitter_state_machine_n0003(1)
    );
  BU2_U0_transmitter_state_machine_next_ifg_is_a_35 : FDSE
    port map (
      D => BU2_U0_transmitter_state_machine_n0011,
      S => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_state_machine_n0060,
      C => usrclk,
      Q => BU2_U0_transmitter_state_machine_next_ifg_is_a
    );
  BU2_U0_receiver_recoder_n0549_SW0 : LUT3_D
    generic map(
      INIT => X"B6"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(14),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(13),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(15),
      LO => BU2_N3666,
      O => BU2_N994
    );
  BU2_U0_transmitter_state_machine_state_0_0_36 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_N3665,
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_state_machine_state_0_0
    );
  BU2_U0_transmitter_state_machine_n00211 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_0,
      I1 => BU2_U0_transmitter_state_machine_state_0_1,
      O => BU2_U0_transmitter_tx_code_a(0)
    );
  BU2_U0_transmitter_state_machine_n0003_0_21 : LUT4_D
    generic map(
      INIT => X"FF8C"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1,
      I1 => BU2_CHOICE2148,
      I2 => BU2_U0_transmitter_a_due(0),
      I3 => BU2_CHOICE2153,
      LO => BU2_N3665,
      O => BU2_U0_transmitter_state_machine_n0003(0)
    );
  BU2_U0_transmitter_state_machine_Ker12 : LUT4_L
    generic map(
      INIT => X"0C08"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_q_det,
      I1 => BU2_U0_transmitter_state_machine_state_1_1,
      I2 => BU2_U0_transmitter_state_machine_state_1_0,
      I3 => BU2_N1065,
      LO => BU2_U0_transmitter_state_machine_N12
    );
  BU2_U0_receiver_recoder_n059416 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => mgt_rxdata_6(14),
      I1 => mgt_rxdata_6(9),
      I2 => mgt_rxdata_6(13),
      I3 => BU2_N3558,
      O => BU2_N243
    );
  BU2_U0_transmitter_recoder_n04231 : LUT4
    generic map(
      INIT => X"1032"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_0,
      I1 => BU2_U0_transmitter_recoder_n0481,
      I2 => BU2_U0_transmitter_state_machine_state_1_1,
      I3 => BU2_N3566,
      O => BU2_N3116
    );
  BU2_U0_receiver_n002639 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => mgt_rxdata_6(48),
      I1 => mgt_rxdata_6(49),
      O => BU2_CHOICE1176
    );
  BU2_U0_transmitter_recoder_n0440_SW1 : LUT3
    generic map(
      INIT => X"AD"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_0,
      I1 => BU2_U0_transmitter_filter6_txd_out(7),
      I2 => BU2_U0_transmitter_state_machine_state_1_2,
      O => BU2_N3602
    );
  BU2_U0_transmitter_state_machine_n00251 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_0,
      I1 => BU2_U0_transmitter_state_machine_state_1_1,
      O => BU2_U0_transmitter_tx_code_a(1)
    );
  BU2_U0_transmitter_state_machine_n0003_2_Q : LUT4_D
    generic map(
      INIT => X"EA40"
    )
    port map (
      I0 => BU2_U0_transmitter_tx_is_q(0),
      I1 => BU2_U0_transmitter_tx_is_idle(0),
      I2 => BU2_N1108,
      I3 => BU2_N1109,
      LO => BU2_N3664,
      O => BU2_U0_transmitter_state_machine_n0003(2)
    );
  BU2_U0_transmitter_state_machine_n00111 : LUT3
    generic map(
      INIT => X"EF"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_2,
      I1 => BU2_U0_transmitter_state_machine_state_1_0,
      I2 => BU2_U0_transmitter_state_machine_state_1_1,
      O => BU2_U0_transmitter_state_machine_N4
    );
  BU2_U0_transmitter_state_machine_n0069_2_29 : LUT4_D
    generic map(
      INIT => X"AAA8"
    )
    port map (
      I0 => BU2_CHOICE2155,
      I1 => BU2_U0_transmitter_state_machine_n0003(2),
      I2 => BU2_CHOICE1382,
      I3 => BU2_CHOICE1388,
      LO => BU2_N3663,
      O => BU2_U0_transmitter_state_machine_next_state(1, 2)
    );
  BU2_U0_transmitter_state_machine_state_0_1_37 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_N3667,
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_state_machine_state_0_1
    );
  BU2_U0_transmitter_recoder_n04681_38 : LUT2_D
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_0,
      I1 => BU2_U0_transmitter_state_machine_state_0_1,
      LO => BU2_N3662,
      O => BU2_U0_transmitter_tx_code_q(0)
    );
  BU2_U0_transmitter_state_machine_n0069_1_20 : LUT4_D
    generic map(
      INIT => X"2E0C"
    )
    port map (
      I0 => BU2_U0_transmitter_a_due(1),
      I1 => BU2_U0_transmitter_state_machine_n0003(1),
      I2 => BU2_N3467,
      I3 => BU2_N3466,
      LO => BU2_N3661,
      O => BU2_U0_transmitter_state_machine_next_state(1, 1)
    );
  BU2_U0_transmitter_recoder_n0455_SW0 : LUT4_L
    generic map(
      INIT => X"FF20"
    )
    port map (
      I0 => BU2_U0_transmitter_filter1_txd_out(0),
      I1 => BU2_U0_transmitter_recoder_n0481,
      I2 => BU2_U0_transmitter_tx_code_d(0),
      I3 => BU2_U0_transmitter_recoder_n0479,
      LO => BU2_N1067
    );
  BU2_U0_transmitter_recoder_txd_out_6 : FDRS
    port map (
      D => BU2_N3112,
      R => BU2_U0_usrclk_reset,
      S => BU2_U0_transmitter_recoder_n0478,
      C => usrclk,
      Q => mgt_txdata_2(14)
    );
  BU2_U0_transmitter_k_r_prbs_i_prbs_4 : FDS
    port map (
      D => BU2_U0_transmitter_k_r_prbs_i_prbs(2),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_k_r_prbs_i_prbs(4)
    );
  BU2_U0_transmitter_k_r_prbs_i_prbs_3 : FDS
    port map (
      D => BU2_U0_transmitter_k_r_prbs_i_prbs(1),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_k_r_prbs_i_prbs(3)
    );
  BU2_U0_transmitter_k_r_prbs_i_prbs_2 : FDS
    port map (
      D => BU2_U0_transmitter_k_r_prbs_i_n0009,
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_k_r_prbs_i_prbs(2)
    );
  BU2_U0_transmitter_k_r_prbs_i_prbs_1 : FDS
    port map (
      D => BU2_U0_transmitter_k_r_prbs_i_n0008,
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_k_r_prbs_i_prbs(1)
    );
  BU2_U0_transmitter_k_r_prbs_i_prbs_6 : FDS
    port map (
      D => BU2_U0_transmitter_k_r_prbs_i_prbs(4),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_k_r_prbs_i_prbs(6)
    );
  BU2_U0_transmitter_k_r_prbs_i_prbs_7 : FDS
    port map (
      D => BU2_U0_transmitter_k_r_prbs_i_prbs(5),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_k_r_prbs_i_prbs(7)
    );
  BU2_U0_transmitter_k_r_prbs_i_prbs_8 : FDS
    port map (
      D => BU2_U0_transmitter_k_r_prbs_i_prbs(6),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_k_r_prbs_i_prbs(8)
    );
  BU2_U0_transmitter_k_r_prbs_i_Mxor_n0008_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_transmitter_k_r_prbs_i_prbs(5),
      I1 => BU2_U0_transmitter_k_r_prbs_i_prbs(6),
      O => BU2_U0_transmitter_k_r_prbs_i_n0008
    );
  BU2_U0_transmitter_k_r_prbs_i_Mxor_n0009_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_transmitter_k_r_prbs_i_prbs(6),
      I1 => BU2_U0_transmitter_k_r_prbs_i_prbs(7),
      O => BU2_U0_transmitter_k_r_prbs_i_n0009
    );
  BU2_U0_transmitter_recoder_n0410_SW0 : LUT4_L
    generic map(
      INIT => X"B5BF"
    )
    port map (
      I0 => BU2_U0_transmitter_tx_code_d(0),
      I1 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(31),
      I2 => BU2_U0_transmitter_tx_code_q(0),
      I3 => BU2_U0_transmitter_filter3_txd_out(7),
      LO => BU2_N969
    );
  BU2_U0_transmitter_recoder_Ker331 : LUT3
    generic map(
      INIT => X"28"
    )
    port map (
      I0 => configuration_vector_14(4),
      I1 => configuration_vector_14(5),
      I2 => configuration_vector_14(6),
      O => BU2_U0_transmitter_recoder_N33
    );
  BU2_U0_receiver_recoder_n093921_SW1 : LUT4_L
    generic map(
      INIT => X"EAFA"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_delay(3),
      I1 => BU2_U0_receiver_recoder_code_error_pipe(3),
      I2 => BU2_CHOICE2108,
      I3 => BU2_U0_receiver_recoder_rxc_pipe(3),
      LO => BU2_N3169
    );
  BU2_U0_transmitter_n0264113_SW0 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(37),
      I1 => BU2_U0_transmitter_txd_pipe(33),
      I2 => BU2_CHOICE1939,
      I3 => BU2_CHOICE1943,
      O => BU2_N3141
    );
  BU2_U0_transmitter_recoder_n03931 : LUT4
    generic map(
      INIT => X"FF2A"
    )
    port map (
      I0 => configuration_vector_14(4),
      I1 => configuration_vector_14(5),
      I2 => configuration_vector_14(6),
      I3 => BU2_U0_usrclk_reset,
      O => BU2_U0_transmitter_recoder_n0393
    );
  BU2_U0_transmitter_recoder_txd_out_37 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0421,
      S => BU2_U0_transmitter_recoder_n0393,
      C => usrclk,
      Q => mgt_txdata_2(5)
    );
  BU2_U0_transmitter_recoder_txd_out_41 : FDR
    port map (
      D => BU2_U0_transmitter_recoder_n0420,
      R => BU2_U0_transmitter_recoder_n0393,
      C => usrclk,
      Q => mgt_txdata_2(17)
    );
  BU2_U0_transmitter_recoder_txd_out_36 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0419,
      S => BU2_U0_transmitter_recoder_n0393,
      C => usrclk,
      Q => mgt_txdata_2(4)
    );
  BU2_U0_transmitter_recoder_txd_out_40 : FDR
    port map (
      D => BU2_U0_transmitter_recoder_n0418,
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => mgt_txdata_2(16)
    );
  BU2_U0_transmitter_recoder_txd_out_35 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0417,
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => mgt_txdata_2(3)
    );
  BU2_U0_transmitter_recoder_txd_out_34 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0416,
      S => BU2_U0_transmitter_recoder_n0393,
      C => usrclk,
      Q => mgt_txdata_2(2)
    );
  BU2_U0_transmitter_recoder_txd_out_29 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0415,
      S => BU2_U0_transmitter_recoder_n0393,
      C => usrclk,
      Q => mgt_txdata_2(61)
    );
  BU2_U0_transmitter_recoder_txd_out_33 : FDR
    port map (
      D => BU2_U0_transmitter_recoder_n0414,
      R => BU2_U0_transmitter_recoder_n0393,
      C => usrclk,
      Q => mgt_txdata_2(1)
    );
  BU2_U0_transmitter_recoder_txd_out_28 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0413,
      S => BU2_U0_transmitter_recoder_n0393,
      C => usrclk,
      Q => mgt_txdata_2(60)
    );
  BU2_U0_transmitter_recoder_txd_out_32 : FDR
    port map (
      D => BU2_U0_transmitter_recoder_n0412,
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => mgt_txdata_2(0)
    );
  BU2_U0_transmitter_recoder_txd_out_27 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0411,
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => mgt_txdata_2(59)
    );
  BU2_U0_transmitter_recoder_txd_out_31 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0410,
      S => BU2_U0_transmitter_recoder_n0393,
      C => usrclk,
      Q => mgt_txdata_2(63)
    );
  BU2_U0_transmitter_recoder_txd_out_26 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0409,
      S => BU2_U0_transmitter_recoder_n0393,
      C => usrclk,
      Q => mgt_txdata_2(58)
    );
  BU2_U0_transmitter_recoder_n0402181 : LUT4
    generic map(
      INIT => X"1032"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_0,
      I1 => BU2_U0_transmitter_recoder_n0481,
      I2 => BU2_U0_transmitter_state_machine_state_0_1,
      I3 => BU2_N3626,
      O => BU2_N3118
    );
  BU2_U0_transmitter_recoder_txd_out_25 : FDR
    port map (
      D => BU2_U0_transmitter_recoder_n0407,
      R => BU2_U0_transmitter_recoder_n0393,
      C => usrclk,
      Q => mgt_txdata_2(57)
    );
  BU2_U0_transmitter_recoder_txd_out_24 : FDR
    port map (
      D => BU2_U0_transmitter_recoder_n0406,
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => mgt_txdata_2(56)
    );
  BU2_U0_transmitter_recoder_txd_out_19 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0405,
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => mgt_txdata_2(43)
    );
  BU2_U0_transmitter_recoder_txd_out_23 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0404,
      S => BU2_U0_transmitter_recoder_n0393,
      C => usrclk,
      Q => mgt_txdata_2(47)
    );
  BU2_U0_transmitter_recoder_txd_out_18 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0403,
      S => BU2_U0_transmitter_recoder_n0393,
      C => usrclk,
      Q => mgt_txdata_2(42)
    );
  BU2_U0_transmitter_recoder_n0396181 : LUT4
    generic map(
      INIT => X"1032"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_0,
      I1 => BU2_U0_transmitter_recoder_n0481,
      I2 => BU2_U0_transmitter_state_machine_state_0_1,
      I3 => BU2_N3624,
      O => BU2_N3117
    );
  BU2_U0_transmitter_recoder_txd_out_17 : FDR
    port map (
      D => BU2_U0_transmitter_recoder_n0401,
      R => BU2_U0_transmitter_recoder_n0393,
      C => usrclk,
      Q => mgt_txdata_2(41)
    );
  BU2_U0_transmitter_recoder_txd_out_21 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0400,
      S => BU2_U0_transmitter_recoder_n0393,
      C => usrclk,
      Q => mgt_txdata_2(45)
    );
  BU2_U0_transmitter_recoder_txd_out_16 : FDR
    port map (
      D => BU2_U0_transmitter_recoder_n0399,
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => mgt_txdata_2(40)
    );
  BU2_U0_transmitter_recoder_txd_out_20 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0398,
      S => BU2_U0_transmitter_recoder_n0393,
      C => usrclk,
      Q => mgt_txdata_2(44)
    );
  BU2_U0_transmitter_recoder_txd_out_15 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0397,
      S => BU2_U0_transmitter_recoder_n0393,
      C => usrclk,
      Q => mgt_txdata_2(31)
    );
  BU2_U0_transmitter_recoder_n0451181 : LUT4
    generic map(
      INIT => X"1032"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_0,
      I1 => BU2_U0_transmitter_recoder_n0481,
      I2 => BU2_U0_transmitter_state_machine_state_0_1,
      I3 => BU2_N3622,
      O => BU2_N3112
    );
  BU2_U0_transmitter_recoder_txd_out_13 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0395,
      S => BU2_U0_transmitter_recoder_n0393,
      C => usrclk,
      Q => mgt_txdata_2(29)
    );
  BU2_U0_transmitter_recoder_txd_out_12 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0394,
      S => BU2_U0_transmitter_recoder_n0393,
      C => usrclk,
      Q => mgt_txdata_2(28)
    );
  BU2_U0_transmitter_recoder_txd_out_11 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0392,
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => mgt_txdata_2(27)
    );
  BU2_U0_transmitter_recoder_txd_out_9 : FDR
    port map (
      D => BU2_U0_transmitter_recoder_n0457,
      R => BU2_U0_transmitter_recoder_n0393,
      C => usrclk,
      Q => mgt_txdata_2(25)
    );
  BU2_U0_transmitter_recoder_txc_out_2 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0458,
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => mgt_txcharisk_3(5)
    );
  BU2_U0_transmitter_recoder_txc_out_3 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0459,
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => mgt_txcharisk_3(7)
    );
  BU2_U0_transmitter_recoder_txc_out_4 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0460,
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => mgt_txcharisk_3(0)
    );
  BU2_U0_transmitter_recoder_txc_out_5 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0461,
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => mgt_txcharisk_3(2)
    );
  BU2_U0_transmitter_recoder_txc_out_6 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0462,
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => mgt_txcharisk_3(4)
    );
  BU2_U0_transmitter_recoder_txc_out_7 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0463,
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => mgt_txcharisk_3(6)
    );
  BU2_U0_transmitter_recoder_txd_out_10 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0464,
      S => BU2_U0_transmitter_recoder_n0393,
      C => usrclk,
      Q => mgt_txdata_2(26)
    );
  BU2_U0_transmitter_recoder_txd_out_42 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0422,
      S => BU2_U0_transmitter_recoder_n0393,
      C => usrclk,
      Q => mgt_txdata_2(18)
    );
  BU2_U0_transmitter_recoder_n04291 : LUT4
    generic map(
      INIT => X"1032"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_0,
      I1 => BU2_U0_transmitter_recoder_n0481,
      I2 => BU2_U0_transmitter_state_machine_state_1_1,
      I3 => BU2_N3564,
      O => BU2_N3115
    );
  BU2_U0_transmitter_recoder_txd_out_43 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0424,
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => mgt_txdata_2(19)
    );
  BU2_U0_transmitter_recoder_txd_out_39 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0425,
      S => BU2_U0_transmitter_recoder_n0393,
      C => usrclk,
      Q => mgt_txdata_2(7)
    );
  BU2_U0_transmitter_recoder_txd_out_44 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0426,
      S => BU2_U0_transmitter_recoder_n0393,
      C => usrclk,
      Q => mgt_txdata_2(20)
    );
  BU2_U0_transmitter_recoder_txd_out_45 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0427,
      S => BU2_U0_transmitter_recoder_n0393,
      C => usrclk,
      Q => mgt_txdata_2(21)
    );
  BU2_U0_transmitter_recoder_txd_out_50 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0428,
      S => BU2_U0_transmitter_recoder_n0393,
      C => usrclk,
      Q => mgt_txdata_2(34)
    );
  BU2_U0_transmitter_recoder_n04381 : LUT4
    generic map(
      INIT => X"1032"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_0,
      I1 => BU2_U0_transmitter_recoder_n0481,
      I2 => BU2_U0_transmitter_state_machine_state_1_1,
      I3 => BU2_N3562,
      O => BU2_N3114
    );
  BU2_U0_transmitter_recoder_txd_out_51 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0430,
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => mgt_txdata_2(35)
    );
  BU2_U0_transmitter_recoder_txd_out_47 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0431,
      S => BU2_U0_transmitter_recoder_n0393,
      C => usrclk,
      Q => mgt_txdata_2(23)
    );
  BU2_U0_transmitter_recoder_txd_out_52 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0432,
      S => BU2_U0_transmitter_recoder_n0393,
      C => usrclk,
      Q => mgt_txdata_2(36)
    );
  BU2_U0_transmitter_recoder_txd_out_0 : FDR
    port map (
      D => BU2_U0_transmitter_recoder_n0433,
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => mgt_txdata_2(8)
    );
  BU2_U0_transmitter_recoder_txd_out_48 : FDR
    port map (
      D => BU2_U0_transmitter_recoder_n0434,
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => mgt_txdata_2(32)
    );
  BU2_U0_transmitter_recoder_txd_out_53 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0435,
      S => BU2_U0_transmitter_recoder_n0393,
      C => usrclk,
      Q => mgt_txdata_2(37)
    );
  BU2_U0_transmitter_recoder_txd_out_1 : FDR
    port map (
      D => BU2_U0_transmitter_recoder_n0436,
      R => BU2_U0_transmitter_recoder_n0393,
      C => usrclk,
      Q => mgt_txdata_2(9)
    );
  BU2_U0_transmitter_recoder_txd_out_49 : FDR
    port map (
      D => BU2_U0_transmitter_recoder_n0437,
      R => BU2_U0_transmitter_recoder_n0393,
      C => usrclk,
      Q => mgt_txdata_2(33)
    );
  BU2_U0_transmitter_recoder_n04471 : LUT4
    generic map(
      INIT => X"1032"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_0,
      I1 => BU2_U0_transmitter_recoder_n0481,
      I2 => BU2_U0_transmitter_state_machine_state_1_1,
      I3 => BU2_N3560,
      O => BU2_N3113
    );
  BU2_U0_transmitter_recoder_txd_out_2 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0439,
      S => BU2_U0_transmitter_recoder_n0393,
      C => usrclk,
      Q => mgt_txdata_2(10)
    );
  BU2_U0_transmitter_recoder_txd_out_55 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0440,
      S => BU2_U0_transmitter_recoder_n0393,
      C => usrclk,
      Q => mgt_txdata_2(39)
    );
  BU2_U0_transmitter_recoder_txd_out_60 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0441,
      S => BU2_U0_transmitter_recoder_n0393,
      C => usrclk,
      Q => mgt_txdata_2(52)
    );
  BU2_U0_transmitter_recoder_txd_out_3 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0442,
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => mgt_txdata_2(11)
    );
  BU2_U0_transmitter_recoder_txd_out_56 : FDR
    port map (
      D => BU2_U0_transmitter_recoder_n0443,
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => mgt_txdata_2(48)
    );
  BU2_U0_transmitter_recoder_txd_out_61 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0444,
      S => BU2_U0_transmitter_recoder_n0393,
      C => usrclk,
      Q => mgt_txdata_2(53)
    );
  BU2_U0_transmitter_recoder_txd_out_4 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0445,
      S => BU2_U0_transmitter_recoder_n0393,
      C => usrclk,
      Q => mgt_txdata_2(12)
    );
  BU2_U0_transmitter_recoder_txd_out_57 : FDR
    port map (
      D => BU2_U0_transmitter_recoder_n0446,
      R => BU2_U0_transmitter_recoder_n0393,
      C => usrclk,
      Q => mgt_txdata_2(49)
    );
  BU2_U0_transmitter_recoder_n0460_SW1 : LUT3
    generic map(
      INIT => X"EF"
    )
    port map (
      I0 => BU2_U0_transmitter_filter4_txc_out,
      I1 => BU2_U0_transmitter_state_machine_state_1_1,
      I2 => BU2_U0_transmitter_state_machine_state_1_0,
      O => BU2_N3644
    );
  BU2_U0_transmitter_recoder_txd_out_5 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0448,
      S => BU2_U0_transmitter_recoder_n0393,
      C => usrclk,
      Q => mgt_txdata_2(13)
    );
  BU2_U0_transmitter_recoder_txd_out_58 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0449,
      S => BU2_U0_transmitter_recoder_n0393,
      C => usrclk,
      Q => mgt_txdata_2(50)
    );
  BU2_U0_transmitter_recoder_txd_out_63 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0450,
      S => BU2_U0_transmitter_recoder_n0393,
      C => usrclk,
      Q => mgt_txdata_2(55)
    );
  BU2_U0_receiver_recoder_n093134_SW0 : LUT4
    generic map(
      INIT => X"D7FF"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(13),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(14),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(15),
      I3 => BU2_U0_receiver_recoder_rxc_pipe(1),
      O => BU2_N3514
    );
  BU2_U0_transmitter_recoder_txd_out_59 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0452,
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => mgt_txdata_2(51)
    );
  BU2_U0_transmitter_recoder_txd_out_7 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0453,
      S => BU2_U0_transmitter_recoder_n0393,
      C => usrclk,
      Q => mgt_txdata_2(15)
    );
  BU2_U0_transmitter_recoder_n0392_39 : LUT4_L
    generic map(
      INIT => X"FF32"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_N35,
      I1 => BU2_U0_transmitter_recoder_n0481,
      I2 => BU2_N2858,
      I3 => BU2_U0_transmitter_recoder_N33,
      LO => BU2_U0_transmitter_recoder_n0392
    );
  BU2_U0_transmitter_align_n00071 : LUT4
    generic map(
      INIT => X"3010"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1,
      I1 => BU2_U0_transmitter_state_machine_state_0_0,
      I2 => BU2_U0_transmitter_state_machine_state_0_1,
      I3 => BU2_U0_transmitter_state_machine_state_1_0,
      O => BU2_U0_transmitter_align_n0007
    );
  BU2_U0_transmitter_recoder_n0394_40 : LUT4
    generic map(
      INIT => X"FD75"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_0,
      I1 => BU2_U0_transmitter_state_machine_state_0_1,
      I2 => BU2_N3598,
      I3 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(12),
      O => BU2_U0_transmitter_recoder_n0394
    );
  BU2_U0_transmitter_state_machine_Ker12_SW0 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_2_1,
      I1 => BU2_U0_transmitter_tx_is_q(0),
      O => BU2_N1065
    );
  BU2_U0_transmitter_recoder_txd_out_62 : FDRS
    port map (
      D => BU2_N3113,
      R => BU2_U0_usrclk_reset,
      S => BU2_U0_transmitter_recoder_n0478,
      C => usrclk,
      Q => mgt_txdata_2(54)
    );
  BU2_U0_transmitter_filter0_n0007_7_1_SW0 : LUT3_D
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => BU2_CHOICE1833,
      I1 => BU2_CHOICE1826,
      I2 => BU2_U0_transmitter_n0263,
      LO => BU2_N3660,
      O => BU2_N3420
    );
  BU2_U0_transmitter_recoder_n0398_41 : LUT4
    generic map(
      INIT => X"FD75"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_0,
      I1 => BU2_U0_transmitter_state_machine_state_0_1,
      I2 => BU2_N3596,
      I3 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(20),
      O => BU2_U0_transmitter_recoder_n0398
    );
  BU2_U0_transmitter_recoder_n0399_42 : LUT4_L
    generic map(
      INIT => X"EC4C"
    )
    port map (
      I0 => BU2_U0_transmitter_tx_code_q(0),
      I1 => BU2_N1088,
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(16),
      I3 => BU2_N1089,
      LO => BU2_U0_transmitter_recoder_n0399
    );
  BU2_U0_transmitter_recoder_n0415_43 : LUT4_L
    generic map(
      INIT => X"5F9B"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_0,
      I1 => BU2_U0_transmitter_state_machine_state_0_2,
      I2 => BU2_N1805,
      I3 => BU2_U0_transmitter_state_machine_state_0_1,
      LO => BU2_U0_transmitter_recoder_n0415
    );
  BU2_U0_transmitter_recoder_n04011 : LUT4_L
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_U0_transmitter_tx_code_q(0),
      I1 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(17),
      I2 => BU2_U0_transmitter_tx_code_d(0),
      I3 => BU2_U0_transmitter_filter2_txd_out(1),
      LO => BU2_U0_transmitter_recoder_n0401
    );
  BU2_U0_transmitter_recoder_txd_out_54 : FDRS
    port map (
      D => BU2_N3114,
      R => BU2_U0_usrclk_reset,
      S => BU2_U0_transmitter_recoder_n0478,
      C => usrclk,
      Q => mgt_txdata_2(38)
    );
  BU2_U0_transmitter_recoder_n0403_44 : LUT4
    generic map(
      INIT => X"FD75"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_0,
      I1 => BU2_U0_transmitter_state_machine_state_0_1,
      I2 => BU2_N3594,
      I3 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(18),
      O => BU2_U0_transmitter_recoder_n0403
    );
  BU2_U0_transmitter_recoder_n0410_45 : LUT4_L
    generic map(
      INIT => X"21AB"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_0,
      I1 => BU2_U0_transmitter_state_machine_state_0_1,
      I2 => BU2_U0_transmitter_state_machine_state_0_2,
      I3 => BU2_N969,
      LO => BU2_U0_transmitter_recoder_n0410
    );
  BU2_U0_transmitter_recoder_n0405_46 : LUT4_L
    generic map(
      INIT => X"FF32"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_N35,
      I1 => BU2_U0_transmitter_recoder_n0481,
      I2 => BU2_N2856,
      I3 => BU2_U0_transmitter_recoder_N33,
      LO => BU2_U0_transmitter_recoder_n0405
    );
  BU2_U0_transmitter_recoder_n0406_47 : LUT4_L
    generic map(
      INIT => X"EC4C"
    )
    port map (
      I0 => BU2_U0_transmitter_tx_code_q(0),
      I1 => BU2_N1085,
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(24),
      I3 => BU2_N1089,
      LO => BU2_U0_transmitter_recoder_n0406
    );
  BU2_U0_transmitter_recoder_n04071 : LUT4_L
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_U0_transmitter_tx_code_q(0),
      I1 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(25),
      I2 => BU2_U0_transmitter_tx_code_d(0),
      I3 => BU2_U0_transmitter_filter3_txd_out(1),
      LO => BU2_U0_transmitter_recoder_n0407
    );
  BU2_U0_transmitter_recoder_txd_out_46 : FDRS
    port map (
      D => BU2_N3115,
      R => BU2_U0_usrclk_reset,
      S => BU2_U0_transmitter_recoder_n0478,
      C => usrclk,
      Q => mgt_txdata_2(22)
    );
  BU2_U0_transmitter_recoder_n0409_48 : LUT4
    generic map(
      INIT => X"FD75"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_0,
      I1 => BU2_U0_transmitter_state_machine_state_0_1,
      I2 => BU2_N3592,
      I3 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(26),
      O => BU2_U0_transmitter_recoder_n0409
    );
  BU2_U0_transmitter_recoder_n0453_49 : LUT4_L
    generic map(
      INIT => X"21AB"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_0,
      I1 => BU2_U0_transmitter_state_machine_state_0_1,
      I2 => BU2_U0_transmitter_state_machine_state_0_2,
      I3 => BU2_N959,
      LO => BU2_U0_transmitter_recoder_n0453
    );
  BU2_U0_transmitter_recoder_n0411_50 : LUT4_L
    generic map(
      INIT => X"FF32"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_N35,
      I1 => BU2_U0_transmitter_recoder_n0481,
      I2 => BU2_N2854,
      I3 => BU2_U0_transmitter_recoder_N33,
      LO => BU2_U0_transmitter_recoder_n0411
    );
  BU2_U0_transmitter_recoder_n0412_51 : LUT4_L
    generic map(
      INIT => X"EC4C"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_n0474,
      I1 => BU2_N3508,
      I2 => BU2_U0_transmitter_filter4_txd_out(0),
      I3 => BU2_N1089,
      LO => BU2_U0_transmitter_recoder_n0412
    );
  BU2_U0_transmitter_recoder_n0413_52 : LUT4
    generic map(
      INIT => X"FD75"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_0,
      I1 => BU2_U0_transmitter_state_machine_state_0_1,
      I2 => BU2_N3590,
      I3 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(28),
      O => BU2_U0_transmitter_recoder_n0413
    );
  BU2_U0_transmitter_recoder_n04141 : LUT4_L
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_n0473,
      I1 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(1),
      I2 => BU2_U0_transmitter_recoder_n0474,
      I3 => BU2_U0_transmitter_filter4_txd_out(1),
      LO => BU2_U0_transmitter_recoder_n0414
    );
  BU2_U0_transmitter_recoder_n0448_53 : LUT4_L
    generic map(
      INIT => X"5F9B"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_0,
      I1 => BU2_U0_transmitter_state_machine_state_0_2,
      I2 => BU2_N1803,
      I3 => BU2_U0_transmitter_state_machine_state_0_1,
      LO => BU2_U0_transmitter_recoder_n0448
    );
  BU2_U0_transmitter_recoder_n0419_54 : LUT4
    generic map(
      INIT => X"F777"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_0,
      I1 => BU2_N3640,
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(4),
      I3 => BU2_U0_transmitter_state_machine_state_1_1,
      O => BU2_U0_transmitter_recoder_n0419
    );
  BU2_U0_transmitter_recoder_n0417_55 : LUT4_L
    generic map(
      INIT => X"FF32"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_N34,
      I1 => BU2_U0_transmitter_recoder_n0481,
      I2 => BU2_N2802,
      I3 => BU2_U0_transmitter_recoder_N33,
      LO => BU2_U0_transmitter_recoder_n0417
    );
  BU2_U0_transmitter_recoder_n0418_56 : LUT4_L
    generic map(
      INIT => X"EC4C"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_n0474,
      I1 => BU2_N3506,
      I2 => BU2_U0_transmitter_filter5_txd_out(0),
      I3 => BU2_N1089,
      LO => BU2_U0_transmitter_recoder_n0418
    );
  BU2_U0_transmitter_recoder_n0422_57 : LUT4
    generic map(
      INIT => X"F777"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_0,
      I1 => BU2_N3638,
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(10),
      I3 => BU2_U0_transmitter_state_machine_state_1_1,
      O => BU2_U0_transmitter_recoder_n0422
    );
  BU2_U0_transmitter_recoder_n04201 : LUT4_L
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_n0473,
      I1 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(9),
      I2 => BU2_U0_transmitter_recoder_n0474,
      I3 => BU2_U0_transmitter_filter5_txd_out(1),
      LO => BU2_U0_transmitter_recoder_n0420
    );
  BU2_U0_transmitter_recoder_n0427_58 : LUT4
    generic map(
      INIT => X"FFA2"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1,
      I1 => BU2_U0_transmitter_state_machine_state_1_0,
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(13),
      I3 => BU2_N1815,
      O => BU2_U0_transmitter_recoder_n0427
    );
  BU2_U0_transmitter_recoder_n0426_59 : LUT4
    generic map(
      INIT => X"F777"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_0,
      I1 => BU2_N3636,
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(12),
      I3 => BU2_U0_transmitter_state_machine_state_1_1,
      O => BU2_U0_transmitter_recoder_n0426
    );
  BU2_U0_transmitter_recoder_txd_out_38 : FDRS
    port map (
      D => BU2_N3116,
      R => BU2_U0_usrclk_reset,
      S => BU2_U0_transmitter_recoder_n0478,
      C => usrclk,
      Q => mgt_txdata_2(6)
    );
  BU2_U0_transmitter_recoder_n0424_60 : LUT4_L
    generic map(
      INIT => X"FF32"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_N34,
      I1 => BU2_U0_transmitter_recoder_n0481,
      I2 => BU2_N2800,
      I3 => BU2_U0_transmitter_recoder_N33,
      LO => BU2_U0_transmitter_recoder_n0424
    );
  BU2_U0_transmitter_recoder_n0425_61 : LUT4
    generic map(
      INIT => X"E444"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1,
      I1 => BU2_N3606,
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(7),
      I3 => BU2_U0_transmitter_state_machine_state_1_0,
      O => BU2_U0_transmitter_recoder_n0425
    );
  BU2_U0_transmitter_recoder_n0428_62 : LUT4
    generic map(
      INIT => X"F777"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_0,
      I1 => BU2_N3634,
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(18),
      I3 => BU2_U0_transmitter_state_machine_state_1_1,
      O => BU2_U0_transmitter_recoder_n0428
    );
  BU2_U0_transmitter_recoder_n0435_63 : LUT4
    generic map(
      INIT => X"FFA2"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1,
      I1 => BU2_U0_transmitter_state_machine_state_1_0,
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(21),
      I3 => BU2_N1813,
      O => BU2_U0_transmitter_recoder_n0435
    );
  BU2_U0_transmitter_recoder_n0432_64 : LUT4
    generic map(
      INIT => X"F777"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_0,
      I1 => BU2_N3632,
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(20),
      I3 => BU2_U0_transmitter_state_machine_state_1_1,
      O => BU2_U0_transmitter_recoder_n0432
    );
  BU2_U0_transmitter_recoder_txd_out_14 : FDRS
    port map (
      D => BU2_N3117,
      R => BU2_U0_usrclk_reset,
      S => BU2_U0_transmitter_recoder_n0478,
      C => usrclk,
      Q => mgt_txdata_2(30)
    );
  BU2_U0_transmitter_recoder_n0430_65 : LUT4_L
    generic map(
      INIT => X"FF32"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_N34,
      I1 => BU2_U0_transmitter_recoder_n0481,
      I2 => BU2_N2798,
      I3 => BU2_U0_transmitter_recoder_N33,
      LO => BU2_U0_transmitter_recoder_n0430
    );
  BU2_U0_transmitter_recoder_n0431_66 : LUT4
    generic map(
      INIT => X"E444"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1,
      I1 => BU2_N3604,
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(15),
      I3 => BU2_U0_transmitter_state_machine_state_1_0,
      O => BU2_U0_transmitter_recoder_n0431
    );
  BU2_U0_transmitter_recoder_n0441_67 : LUT4
    generic map(
      INIT => X"F777"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_0,
      I1 => BU2_N3630,
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(28),
      I3 => BU2_U0_transmitter_state_machine_state_1_1,
      O => BU2_U0_transmitter_recoder_n0441
    );
  BU2_U0_transmitter_recoder_n0433_68 : LUT4_L
    generic map(
      INIT => X"EC4C"
    )
    port map (
      I0 => BU2_U0_transmitter_tx_code_q(0),
      I1 => BU2_N1076,
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(0),
      I3 => BU2_N1089,
      LO => BU2_U0_transmitter_recoder_n0433
    );
  BU2_U0_transmitter_recoder_n0434_69 : LUT4_L
    generic map(
      INIT => X"EC4C"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_n0474,
      I1 => BU2_N3504,
      I2 => BU2_U0_transmitter_filter6_txd_out(0),
      I3 => BU2_N1089,
      LO => BU2_U0_transmitter_recoder_n0434
    );
  BU2_U0_transmitter_recoder_n0444_70 : LUT4
    generic map(
      INIT => X"FFA2"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1,
      I1 => BU2_U0_transmitter_state_machine_state_1_0,
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(29),
      I3 => BU2_N1811,
      O => BU2_U0_transmitter_recoder_n0444
    );
  BU2_U0_transmitter_recoder_n04361 : LUT4_L
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_U0_transmitter_tx_code_q(0),
      I1 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(1),
      I2 => BU2_U0_transmitter_tx_code_d(0),
      I3 => BU2_U0_transmitter_filter0_txd_out(1),
      LO => BU2_U0_transmitter_recoder_n0436
    );
  BU2_U0_transmitter_recoder_n04371 : LUT4_L
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_n0473,
      I1 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(17),
      I2 => BU2_U0_transmitter_recoder_n0474,
      I3 => BU2_U0_transmitter_filter6_txd_out(1),
      LO => BU2_U0_transmitter_recoder_n0437
    );
  BU2_U0_transmitter_recoder_txd_out_22 : FDRS
    port map (
      D => BU2_N3118,
      R => BU2_U0_usrclk_reset,
      S => BU2_U0_transmitter_recoder_n0478,
      C => usrclk,
      Q => mgt_txdata_2(46)
    );
  BU2_U0_transmitter_recoder_n0439_71 : LUT4
    generic map(
      INIT => X"FD75"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_0,
      I1 => BU2_U0_transmitter_state_machine_state_0_1,
      I2 => BU2_N3588,
      I3 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(2),
      O => BU2_U0_transmitter_recoder_n0439
    );
  BU2_U0_transmitter_recoder_n0440_72 : LUT4
    generic map(
      INIT => X"E444"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1,
      I1 => BU2_N3602,
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(23),
      I3 => BU2_U0_transmitter_state_machine_state_1_0,
      O => BU2_U0_transmitter_recoder_n0440
    );
  BU2_U0_transmitter_recoder_n0449_73 : LUT4
    generic map(
      INIT => X"F777"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_0,
      I1 => BU2_N3628,
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(26),
      I3 => BU2_U0_transmitter_state_machine_state_1_1,
      O => BU2_U0_transmitter_recoder_n0449
    );
  BU2_U0_transmitter_recoder_n0442_74 : LUT4_L
    generic map(
      INIT => X"FF32"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_N35,
      I1 => BU2_U0_transmitter_recoder_n0481,
      I2 => BU2_N2852,
      I3 => BU2_U0_transmitter_recoder_N33,
      LO => BU2_U0_transmitter_recoder_n0442
    );
  BU2_U0_transmitter_recoder_n0443_75 : LUT4_L
    generic map(
      INIT => X"EC4C"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_n0474,
      I1 => BU2_N3502,
      I2 => BU2_U0_transmitter_filter7_txd_out(0),
      I3 => BU2_N1089,
      LO => BU2_U0_transmitter_recoder_n0443
    );
  BU2_U0_transmitter_recoder_n0397_76 : LUT4_L
    generic map(
      INIT => X"21AB"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_0,
      I1 => BU2_U0_transmitter_state_machine_state_0_1,
      I2 => BU2_U0_transmitter_state_machine_state_0_2,
      I3 => BU2_N973,
      LO => BU2_U0_transmitter_recoder_n0397
    );
  BU2_U0_transmitter_recoder_n0445_77 : LUT4
    generic map(
      INIT => X"FD75"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_0,
      I1 => BU2_U0_transmitter_state_machine_state_0_1,
      I2 => BU2_N3586,
      I3 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(4),
      O => BU2_U0_transmitter_recoder_n0445
    );
  BU2_U0_transmitter_recoder_n04461 : LUT4_L
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_N3678,
      I1 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(25),
      I2 => BU2_U0_transmitter_recoder_n0474,
      I3 => BU2_U0_transmitter_filter7_txd_out(1),
      LO => BU2_U0_transmitter_recoder_n0446
    );
  BU2_U0_transmitter_recoder_txd_out_30 : FDRS
    port map (
      D => BU2_N3119,
      R => BU2_U0_usrclk_reset,
      S => BU2_U0_transmitter_recoder_n0478,
      C => usrclk,
      Q => mgt_txdata_2(62)
    );
  BU2_U0_transmitter_filter1_n0007_2_1 : LUT4_L
    generic map(
      INIT => X"FFA2"
    )
    port map (
      I0 => BU2_U0_transmitter_txc_pipe(1),
      I1 => BU2_U0_transmitter_txd_pipe(11),
      I2 => BU2_CHOICE1649,
      I3 => BU2_U0_transmitter_txd_pipe(10),
      LO => BU2_U0_transmitter_filter1_n0007(2)
    );
  BU2_U0_transmitter_recoder_n0392_SW0 : LUT4_L
    generic map(
      INIT => X"0C04"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_2,
      I1 => BU2_U0_transmitter_state_machine_state_0_0,
      I2 => BU2_N3452,
      I3 => BU2_U0_transmitter_state_machine_state_0_1,
      LO => BU2_N2858
    );
  BU2_U0_transmitter_recoder_n0450_78 : LUT4
    generic map(
      INIT => X"E444"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1,
      I1 => BU2_N3600,
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(31),
      I3 => BU2_U0_transmitter_state_machine_state_1_0,
      O => BU2_U0_transmitter_recoder_n0450
    );
  BU2_U0_transmitter_state_machine_state_1_0_79 : FDRS
    generic map(
      INIT => '0'
    )
    port map (
      D => BU2_N3668,
      R => BU2_U0_usrclk_reset,
      S => BU2_U0_transmitter_state_machine_N13,
      C => usrclk,
      Q => BU2_U0_transmitter_state_machine_state_1_0
    );
  BU2_U0_transmitter_recoder_n0452_80 : LUT4_L
    generic map(
      INIT => X"FF32"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_N34,
      I1 => BU2_U0_transmitter_recoder_n0481,
      I2 => BU2_N2780,
      I3 => BU2_U0_transmitter_recoder_N33,
      LO => BU2_U0_transmitter_recoder_n0452
    );
  BU2_U0_transmitter_recoder_n0395_81 : LUT4_L
    generic map(
      INIT => X"5F9B"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_0,
      I1 => BU2_U0_transmitter_state_machine_state_0_2,
      I2 => BU2_N1809,
      I3 => BU2_U0_transmitter_state_machine_state_0_1,
      LO => BU2_U0_transmitter_recoder_n0395
    );
  BU2_U0_transmitter_recoder_n0454_82 : LUT4_L
    generic map(
      INIT => X"EC4C"
    )
    port map (
      I0 => BU2_U0_transmitter_tx_code_d(0),
      I1 => BU2_N3510,
      I2 => BU2_U0_transmitter_filter0_txc_out,
      I3 => BU2_N1115,
      LO => BU2_U0_transmitter_recoder_n0454
    );
  BU2_U0_transmitter_recoder_n0455_83 : LUT4_L
    generic map(
      INIT => X"EC4C"
    )
    port map (
      I0 => BU2_U0_transmitter_tx_code_q(0),
      I1 => BU2_N1067,
      I2 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(8),
      I3 => BU2_N1089,
      LO => BU2_U0_transmitter_recoder_n0455
    );
  BU2_U0_transmitter_recoder_n045616 : LUT4
    generic map(
      INIT => X"FF2A"
    )
    port map (
      I0 => BU2_CHOICE1975,
      I1 => BU2_U0_transmitter_state_machine_state_0_0,
      I2 => BU2_N3618,
      I3 => BU2_U0_transmitter_recoder_N33,
      O => BU2_U0_transmitter_recoder_n0456
    );
  BU2_U0_transmitter_recoder_n04571 : LUT4_L
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_U0_transmitter_tx_code_q(0),
      I1 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(9),
      I2 => BU2_U0_transmitter_tx_code_d(0),
      I3 => BU2_U0_transmitter_filter1_txd_out(1),
      LO => BU2_U0_transmitter_recoder_n0457
    );
  BU2_U0_transmitter_recoder_n045816 : LUT4
    generic map(
      INIT => X"FF2A"
    )
    port map (
      I0 => BU2_CHOICE1975,
      I1 => BU2_U0_transmitter_state_machine_state_0_0,
      I2 => BU2_N3616,
      I3 => BU2_U0_transmitter_recoder_N33,
      O => BU2_U0_transmitter_recoder_n0458
    );
  BU2_U0_transmitter_recoder_n045916 : LUT4
    generic map(
      INIT => X"FF2A"
    )
    port map (
      I0 => BU2_CHOICE1975,
      I1 => BU2_U0_transmitter_state_machine_state_0_0,
      I2 => BU2_N3614,
      I3 => BU2_U0_transmitter_recoder_N33,
      O => BU2_U0_transmitter_recoder_n0459
    );
  BU2_U0_transmitter_recoder_n0460_84 : LUT4
    generic map(
      INIT => X"FF32"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_2,
      I1 => BU2_U0_transmitter_recoder_n0481,
      I2 => BU2_N3644,
      I3 => BU2_U0_transmitter_recoder_N33,
      O => BU2_U0_transmitter_recoder_n0460
    );
  BU2_U0_transmitter_recoder_n046116 : LUT4
    generic map(
      INIT => X"FF2A"
    )
    port map (
      I0 => BU2_CHOICE1975,
      I1 => BU2_U0_transmitter_state_machine_state_1_0,
      I2 => BU2_N3612,
      I3 => BU2_U0_transmitter_recoder_N33,
      O => BU2_U0_transmitter_recoder_n0461
    );
  BU2_U0_transmitter_recoder_n046216 : LUT4
    generic map(
      INIT => X"FF2A"
    )
    port map (
      I0 => BU2_CHOICE1975,
      I1 => BU2_U0_transmitter_state_machine_state_1_0,
      I2 => BU2_N3610,
      I3 => BU2_U0_transmitter_recoder_N33,
      O => BU2_U0_transmitter_recoder_n0462
    );
  BU2_U0_transmitter_recoder_n046316 : LUT4
    generic map(
      INIT => X"FF2A"
    )
    port map (
      I0 => BU2_CHOICE1975,
      I1 => BU2_U0_transmitter_state_machine_state_1_0,
      I2 => BU2_N3608,
      I3 => BU2_U0_transmitter_recoder_N33,
      O => BU2_U0_transmitter_recoder_n0463
    );
  BU2_U0_transmitter_recoder_n0464_85 : LUT4
    generic map(
      INIT => X"FD75"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_0,
      I1 => BU2_U0_transmitter_state_machine_state_0_1,
      I2 => BU2_N3584,
      I3 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(10),
      O => BU2_U0_transmitter_recoder_n0464
    );
  BU2_U0_transmitter_recoder_n046316_SW0 : LUT3
    generic map(
      INIT => X"F1"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_2,
      I1 => BU2_U0_transmitter_filter7_txc_out,
      I2 => BU2_U0_transmitter_state_machine_state_1_1,
      O => BU2_N3608
    );
  BU2_U0_receiver_recoder_Ker39_SW2 : LUT4
    generic map(
      INIT => X"FFDF"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(20),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(17),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(19),
      I3 => BU2_U0_receiver_recoder_code_error_pipe(2),
      O => BU2_N3492
    );
  BU2_U0_receiver_recoder_n0557_SW1_SW0 : LUT3
    generic map(
      INIT => X"EF"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(25),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(24),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(28),
      O => BU2_N3524
    );
  BU2_U0_transmitter_recoder_n04741 : LUT3
    generic map(
      INIT => X"02"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_0,
      I1 => BU2_U0_transmitter_state_machine_state_1_1,
      I2 => BU2_U0_transmitter_state_machine_state_1_2,
      O => BU2_U0_transmitter_recoder_n0474
    );
  BU2_U0_receiver_recoder_n093921_SW0 : LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_lane_terminate(0),
      I1 => BU2_U0_receiver_recoder_lane_terminate(1),
      I2 => BU2_U0_receiver_recoder_lane_terminate(2),
      I3 => BU2_U0_receiver_recoder_code_error_delay(3),
      O => BU2_N3168
    );
  BU2_U0_receiver_recoder_n053346_SW1 : LUT3
    generic map(
      INIT => X"02"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(12),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(9),
      I2 => BU2_U0_receiver_recoder_rxd_half_pipe(8),
      O => BU2_N3444
    );
  BU2_U0_transmitter_recoder_n04691_86 : LUT3_D
    generic map(
      INIT => X"02"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_0,
      I1 => BU2_U0_transmitter_state_machine_state_0_1,
      I2 => BU2_U0_transmitter_state_machine_state_0_2,
      LO => BU2_N3659,
      O => BU2_U0_transmitter_tx_code_d(0)
    );
  BU2_U0_transmitter_filter2_n0007_6_1_SW0 : LUT3_D
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => BU2_CHOICE1820,
      I1 => BU2_CHOICE1813,
      I2 => BU2_U0_transmitter_n0263,
      LO => BU2_N3658,
      O => BU2_N3398
    );
  BU2_U0_receiver_recoder_n093580_SW1 : LUT3
    generic map(
      INIT => X"FB"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_delay(2),
      I1 => NlwRenamedSig_OI_align_status,
      I2 => BU2_U0_usrclk_reset_1,
      O => BU2_N3133
    );
  BU2_U0_transmitter_recoder_Ker351 : LUT3
    generic map(
      INIT => X"2F"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_2,
      I1 => BU2_U0_transmitter_state_machine_state_0_1,
      I2 => BU2_U0_transmitter_state_machine_state_0_0,
      O => BU2_U0_transmitter_recoder_N35
    );
  BU2_U0_transmitter_recoder_txc_out_0 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0454,
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => mgt_txcharisk_3(1)
    );
  BU2_U0_transmitter_recoder_txd_out_8 : FDR
    port map (
      D => BU2_U0_transmitter_recoder_n0455,
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => mgt_txdata_2(24)
    );
  BU2_U0_transmitter_recoder_txc_out_1 : FDS
    port map (
      D => BU2_U0_transmitter_recoder_n0456,
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => mgt_txcharisk_3(3)
    );
  BU2_U0_transmitter_recoder_n04781 : LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => configuration_vector_14(5),
      I1 => configuration_vector_14(4),
      I2 => configuration_vector_14(6),
      O => BU2_U0_transmitter_recoder_n0478
    );
  BU2_U0_transmitter_recoder_n04791 : LUT3
    generic map(
      INIT => X"02"
    )
    port map (
      I0 => configuration_vector_14(4),
      I1 => configuration_vector_14(6),
      I2 => configuration_vector_14(5),
      O => BU2_U0_transmitter_recoder_n0479
    );
  BU2_U0_receiver_recoder_n05001 : LUT4
    generic map(
      INIT => X"FEFC"
    )
    port map (
      I0 => BU2_CHOICE2069,
      I1 => BU2_U0_receiver_recoder_n0551,
      I2 => BU2_CHOICE2077,
      I3 => BU2_N3673,
      O => BU2_U0_receiver_recoder_n0500
    );
  BU2_U0_transmitter_recoder_n04811 : LUT3
    generic map(
      INIT => X"4C"
    )
    port map (
      I0 => configuration_vector_14(5),
      I1 => configuration_vector_14(4),
      I2 => configuration_vector_14(6),
      O => BU2_U0_transmitter_recoder_n0481
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_21 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_n0004(21),
      R => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_tqmsg_capture_1_n0013601,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(21)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_20 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_n0004(20),
      R => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_tqmsg_capture_1_n0013601,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(20)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_19 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_n0004(19),
      R => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_tqmsg_capture_1_n0013601,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(19)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_18 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_n0004(18),
      R => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_tqmsg_capture_1_n0013601,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(18)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_17 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_n0004(17),
      R => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_tqmsg_capture_1_n0013601,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(17)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_16 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_n0004(16),
      R => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_tqmsg_capture_1_n0013601,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(16)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_15 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_n0004(15),
      R => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_tqmsg_capture_1_n0013,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(15)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_14 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_n0004(14),
      R => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_tqmsg_capture_1_n0013,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(14)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_13 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_n0004(13),
      R => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_tqmsg_capture_1_n0013,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(13)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_12 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_n0004(12),
      R => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_tqmsg_capture_1_n0013,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(12)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_11 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_n0004(11),
      R => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_tqmsg_capture_1_n0013,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(11)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_10 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_n0004(10),
      R => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_tqmsg_capture_1_n0013,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(10)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_9 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_n0004(9),
      R => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_tqmsg_capture_1_n0013603,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(9)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_8 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_n0004(8),
      R => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_tqmsg_capture_1_n0013603,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(8)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_7 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_n0004(7),
      R => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_tqmsg_capture_1_n0013603,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(7)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_6 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_n0004(6),
      R => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_tqmsg_capture_1_n0013603,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(6)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_5 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_n0004(5),
      R => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_tqmsg_capture_1_n0013603,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(5)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_4 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_n0004(4),
      R => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_tqmsg_capture_1_n0013603,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(4)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_3 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_n0004(3),
      R => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_tqmsg_capture_1_n0013602,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(3)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_2 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_n0004(2),
      R => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_tqmsg_capture_1_n0013601,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(2)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_1 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_n0004(1),
      R => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_tqmsg_capture_1_n0013,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(1)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_0 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_n0004(0),
      R => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_tqmsg_capture_1_n0013,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(0)
    );
  BU2_U0_transmitter_tqmsg_capture_1_n0004_4_1 : LUT3_L
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_n0005,
      I1 => BU2_U0_transmitter_filter0_txd_out(4),
      I2 => BU2_U0_transmitter_filter4_txd_out(4),
      LO => BU2_U0_transmitter_tqmsg_capture_1_n0004(4)
    );
  BU2_U0_transmitter_tqmsg_capture_1_n0004_5_1 : LUT3_L
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_n0005,
      I1 => BU2_U0_transmitter_filter0_txd_out(5),
      I2 => BU2_U0_transmitter_filter4_txd_out(5),
      LO => BU2_U0_transmitter_tqmsg_capture_1_n0004(5)
    );
  BU2_U0_transmitter_tqmsg_capture_1_n0004_6_1 : LUT3_L
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_n0005,
      I1 => BU2_U0_transmitter_filter0_txd_out(6),
      I2 => BU2_U0_transmitter_filter4_txd_out(6),
      LO => BU2_U0_transmitter_tqmsg_capture_1_n0004(6)
    );
  BU2_U0_transmitter_tqmsg_capture_1_n0004_7_1 : LUT3_L
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_n0005,
      I1 => BU2_U0_transmitter_filter0_txd_out(7),
      I2 => BU2_U0_transmitter_filter4_txd_out(7),
      LO => BU2_U0_transmitter_tqmsg_capture_1_n0004(7)
    );
  BU2_U0_transmitter_tqmsg_capture_1_n0004_8_1 : LUT3_L
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_n0005,
      I1 => BU2_U0_transmitter_filter1_txd_out(0),
      I2 => BU2_U0_transmitter_filter5_txd_out(0),
      LO => BU2_U0_transmitter_tqmsg_capture_1_n0004(8)
    );
  BU2_U0_transmitter_tqmsg_capture_1_n0004_9_1 : LUT3_L
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_n0005,
      I1 => BU2_U0_transmitter_filter1_txd_out(1),
      I2 => BU2_U0_transmitter_filter5_txd_out(1),
      LO => BU2_U0_transmitter_tqmsg_capture_1_n0004(9)
    );
  BU2_U0_transmitter_tqmsg_capture_1_n0004_10_1 : LUT3_L
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_n0005,
      I1 => BU2_U0_transmitter_filter1_txd_out(2),
      I2 => BU2_U0_transmitter_filter5_txd_out(2),
      LO => BU2_U0_transmitter_tqmsg_capture_1_n0004(10)
    );
  BU2_U0_transmitter_tqmsg_capture_1_n0004_11_1 : LUT3_L
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_n0005,
      I1 => BU2_U0_transmitter_filter1_txd_out(3),
      I2 => BU2_U0_transmitter_filter5_txd_out(3),
      LO => BU2_U0_transmitter_tqmsg_capture_1_n0004(11)
    );
  BU2_U0_transmitter_tqmsg_capture_1_n0004_12_1 : LUT3_L
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_n0005,
      I1 => BU2_U0_transmitter_filter1_txd_out(4),
      I2 => BU2_U0_transmitter_filter5_txd_out(4),
      LO => BU2_U0_transmitter_tqmsg_capture_1_n0004(12)
    );
  BU2_U0_transmitter_tqmsg_capture_1_n0004_13_1 : LUT3_L
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_n0005,
      I1 => BU2_U0_transmitter_filter1_txd_out(5),
      I2 => BU2_U0_transmitter_filter5_txd_out(5),
      LO => BU2_U0_transmitter_tqmsg_capture_1_n0004(13)
    );
  BU2_U0_transmitter_tqmsg_capture_1_n0004_14_1 : LUT3_L
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_n0005,
      I1 => BU2_U0_transmitter_filter1_txd_out(6),
      I2 => BU2_U0_transmitter_filter5_txd_out(6),
      LO => BU2_U0_transmitter_tqmsg_capture_1_n0004(14)
    );
  BU2_U0_transmitter_tqmsg_capture_1_n0004_15_1 : LUT3_L
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_n0005,
      I1 => BU2_U0_transmitter_filter1_txd_out(7),
      I2 => BU2_U0_transmitter_filter5_txd_out(7),
      LO => BU2_U0_transmitter_tqmsg_capture_1_n0004(15)
    );
  BU2_U0_transmitter_tqmsg_capture_1_n0004_16_1 : LUT3_L
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_n0005,
      I1 => BU2_U0_transmitter_filter2_txd_out(0),
      I2 => BU2_U0_transmitter_filter6_txd_out(0),
      LO => BU2_U0_transmitter_tqmsg_capture_1_n0004(16)
    );
  BU2_U0_transmitter_tqmsg_capture_1_n0004_17_1 : LUT3_L
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_n0005,
      I1 => BU2_U0_transmitter_filter2_txd_out(1),
      I2 => BU2_U0_transmitter_filter6_txd_out(1),
      LO => BU2_U0_transmitter_tqmsg_capture_1_n0004(17)
    );
  BU2_U0_transmitter_tqmsg_capture_1_n0004_18_1 : LUT3_L
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_n0005,
      I1 => BU2_U0_transmitter_filter2_txd_out(2),
      I2 => BU2_U0_transmitter_filter6_txd_out(2),
      LO => BU2_U0_transmitter_tqmsg_capture_1_n0004(18)
    );
  BU2_U0_transmitter_tqmsg_capture_1_n0004_19_1 : LUT3_L
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_n0005,
      I1 => BU2_U0_transmitter_filter2_txd_out(3),
      I2 => BU2_U0_transmitter_filter6_txd_out(3),
      LO => BU2_U0_transmitter_tqmsg_capture_1_n0004(19)
    );
  BU2_U0_transmitter_tqmsg_capture_1_n0004_20_1 : LUT3_L
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_n0005,
      I1 => BU2_U0_transmitter_filter2_txd_out(4),
      I2 => BU2_U0_transmitter_filter6_txd_out(4),
      LO => BU2_U0_transmitter_tqmsg_capture_1_n0004(20)
    );
  BU2_U0_transmitter_tqmsg_capture_1_n0004_21_1 : LUT3_L
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_n0005,
      I1 => BU2_U0_transmitter_filter2_txd_out(5),
      I2 => BU2_U0_transmitter_filter6_txd_out(5),
      LO => BU2_U0_transmitter_tqmsg_capture_1_n0004(21)
    );
  BU2_U0_transmitter_tqmsg_capture_1_n0004_22_1 : LUT3_L
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_n0005,
      I1 => BU2_U0_transmitter_filter2_txd_out(6),
      I2 => BU2_U0_transmitter_filter6_txd_out(6),
      LO => BU2_U0_transmitter_tqmsg_capture_1_n0004(22)
    );
  BU2_U0_transmitter_tqmsg_capture_1_n0004_23_1 : LUT3_L
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_n0005,
      I1 => BU2_U0_transmitter_filter2_txd_out(7),
      I2 => BU2_U0_transmitter_filter6_txd_out(7),
      LO => BU2_U0_transmitter_tqmsg_capture_1_n0004(23)
    );
  BU2_U0_transmitter_tqmsg_capture_1_n0004_24_1 : LUT3_L
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_n0005,
      I1 => BU2_U0_transmitter_filter3_txd_out(0),
      I2 => BU2_U0_transmitter_filter7_txd_out(0),
      LO => BU2_U0_transmitter_tqmsg_capture_1_n0004(24)
    );
  BU2_U0_transmitter_tqmsg_capture_1_n0004_25_1 : LUT3_L
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_n0005,
      I1 => BU2_U0_transmitter_filter3_txd_out(1),
      I2 => BU2_U0_transmitter_filter7_txd_out(1),
      LO => BU2_U0_transmitter_tqmsg_capture_1_n0004(25)
    );
  BU2_U0_transmitter_tqmsg_capture_1_n0004_26_1 : LUT3_L
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_n0005,
      I1 => BU2_U0_transmitter_filter3_txd_out(2),
      I2 => BU2_U0_transmitter_filter7_txd_out(2),
      LO => BU2_U0_transmitter_tqmsg_capture_1_n0004(26)
    );
  BU2_U0_transmitter_tqmsg_capture_1_n0004_27_1 : LUT3_L
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_n0005,
      I1 => BU2_U0_transmitter_filter3_txd_out(3),
      I2 => BU2_U0_transmitter_filter7_txd_out(3),
      LO => BU2_U0_transmitter_tqmsg_capture_1_n0004(27)
    );
  BU2_U0_transmitter_tqmsg_capture_1_n0004_28_1 : LUT3_L
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_n0005,
      I1 => BU2_U0_transmitter_filter3_txd_out(4),
      I2 => BU2_U0_transmitter_filter7_txd_out(4),
      LO => BU2_U0_transmitter_tqmsg_capture_1_n0004(28)
    );
  BU2_U0_transmitter_tqmsg_capture_1_n0004_29_1 : LUT3_L
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_n0005,
      I1 => BU2_U0_transmitter_filter3_txd_out(5),
      I2 => BU2_U0_transmitter_filter7_txd_out(5),
      LO => BU2_U0_transmitter_tqmsg_capture_1_n0004(29)
    );
  BU2_U0_transmitter_tqmsg_capture_1_n0004_30_1 : LUT3_L
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_n0005,
      I1 => BU2_U0_transmitter_filter3_txd_out(6),
      I2 => BU2_U0_transmitter_filter7_txd_out(6),
      LO => BU2_U0_transmitter_tqmsg_capture_1_n0004(30)
    );
  BU2_U0_transmitter_tqmsg_capture_1_n0004_31_1 : LUT3_L
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_n0005,
      I1 => BU2_U0_transmitter_filter3_txd_out(7),
      I2 => BU2_U0_transmitter_filter7_txd_out(7),
      LO => BU2_U0_transmitter_tqmsg_capture_1_n0004(31)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_25 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_n0004(25),
      R => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_tqmsg_capture_1_n0013602,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(25)
    );
  BU2_U0_transmitter_tqmsg_capture_1_n0004_3_1 : LUT3_L
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_n0005,
      I1 => BU2_U0_transmitter_filter0_txd_out(3),
      I2 => BU2_U0_transmitter_filter4_txd_out(3),
      LO => BU2_U0_transmitter_tqmsg_capture_1_n0004(3)
    );
  BU2_U0_transmitter_tqmsg_capture_1_n0004_2_1 : LUT3_L
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_n0005,
      I1 => BU2_U0_transmitter_filter0_txd_out(2),
      I2 => BU2_U0_transmitter_filter4_txd_out(2),
      LO => BU2_U0_transmitter_tqmsg_capture_1_n0004(2)
    );
  BU2_U0_transmitter_tqmsg_capture_1_n0004_1_1 : LUT3_L
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_n0005,
      I1 => BU2_U0_transmitter_filter0_txd_out(1),
      I2 => BU2_U0_transmitter_filter4_txd_out(1),
      LO => BU2_U0_transmitter_tqmsg_capture_1_n0004(1)
    );
  BU2_U0_transmitter_tqmsg_capture_1_n0004_0_1 : LUT3_L
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => BU2_N3689,
      I1 => BU2_U0_transmitter_filter0_txd_out(0),
      I2 => BU2_U0_transmitter_filter4_txd_out(0),
      LO => BU2_U0_transmitter_tqmsg_capture_1_n0004(0)
    );
  BU2_U0_transmitter_filter0_n000162 : LUT4
    generic map(
      INIT => X"13FF"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(1),
      I1 => BU2_U0_transmitter_txd_pipe(2),
      I2 => BU2_U0_transmitter_txd_pipe(0),
      I3 => BU2_U0_transmitter_txd_pipe(4),
      O => BU2_CHOICE1620
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_24 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_n0004(24),
      R => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_tqmsg_capture_1_n0013602,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(24)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_27 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_n0004(27),
      R => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_tqmsg_capture_1_n0013602,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(27)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_26 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_n0004(26),
      R => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_tqmsg_capture_1_n0013602,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(26)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_29 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_n0004(29),
      R => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_tqmsg_capture_1_n0013602,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(29)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_28 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_n0004(28),
      R => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_tqmsg_capture_1_n0013602,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(28)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_30 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_n0004(30),
      R => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_tqmsg_capture_1_n0013603,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(30)
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_23 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_n0004(23),
      R => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_tqmsg_capture_1_n0013602,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(23)
    );
  BU2_U0_transmitter_tqmsg_capture_1_n001360_87 : LUT4
    generic map(
      INIT => X"FF80"
    )
    port map (
      I0 => BU2_CHOICE1413,
      I1 => BU2_N3654,
      I2 => BU2_CHOICE1424,
      I3 => BU2_U0_transmitter_tqmsg_capture_1_n000543,
      O => BU2_U0_transmitter_tqmsg_capture_1_n0013
    );
  BU2_U0_transmitter_tqmsg_capture_1_q_det_88 : FDRSE
    port map (
      D => BU2_mdio_tri,
      R => BU2_U0_usrclk_reset,
      S => BU2_U0_transmitter_tqmsg_capture_1_n001360,
      CE => BU2_U0_transmitter_clear_q_det,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_q_det
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_31 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_n0004(31),
      R => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_tqmsg_capture_1_n0013603,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(31)
    );
  BU2_U0_transmitter_seq_detect_i0_muxcy_i0 : MUXCY_L
    port map (
      CI => NlwRenamedSig_OI_mgt_enable_align(0),
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_seq_detect_i0_n0000,
      LO => BU2_U0_transmitter_seq_detect_i0_n0003
    );
  BU2_U0_transmitter_seq_detect_i0_muxcy_i2 : MUXCY_L
    port map (
      CI => BU2_U0_transmitter_seq_detect_i0_muxcyo(1),
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_seq_detect_i0_comp(2),
      LO => BU2_U0_transmitter_n0099
    );
  BU2_U0_transmitter_seq_detect_i0_n00001 : LUT4
    generic map(
      INIT => X"0008"
    )
    port map (
      I0 => xgmii_txd_4(2),
      I1 => xgmii_txd_4(3),
      I2 => xgmii_txd_4(0),
      I3 => xgmii_txd_4(1),
      O => BU2_U0_transmitter_seq_detect_i0_n0000
    );
  BU2_U0_transmitter_seq_detect_i0_n00011 : LUT4
    generic map(
      INIT => X"0008"
    )
    port map (
      I0 => xgmii_txd_4(4),
      I1 => xgmii_txd_4(7),
      I2 => xgmii_txd_4(5),
      I3 => xgmii_txd_4(6),
      O => BU2_U0_transmitter_seq_detect_i0_comp(1)
    );
  BU2_U0_transmitter_seq_detect_i0_n00021 : LUT4
    generic map(
      INIT => X"0002"
    )
    port map (
      I0 => xgmii_txc_5(0),
      I1 => xgmii_txc_5(1),
      I2 => xgmii_txc_5(2),
      I3 => xgmii_txc_5(3),
      O => BU2_U0_transmitter_seq_detect_i0_comp(2)
    );
  BU2_U0_transmitter_seq_detect_i1_muxcy_i0 : MUXCY_L
    port map (
      CI => NlwRenamedSig_OI_mgt_enable_align(0),
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_seq_detect_i1_n0000,
      LO => BU2_U0_transmitter_seq_detect_i1_n0003
    );
  BU2_U0_transmitter_seq_detect_i1_muxcy_i2 : MUXCY_L
    port map (
      CI => BU2_U0_transmitter_seq_detect_i1_muxcyo(1),
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_seq_detect_i1_comp(2),
      LO => BU2_U0_transmitter_tx_is_q_comb(1)
    );
  BU2_U0_transmitter_seq_detect_i1_n00001 : LUT4
    generic map(
      INIT => X"0008"
    )
    port map (
      I0 => xgmii_txd_4(34),
      I1 => xgmii_txd_4(35),
      I2 => xgmii_txd_4(32),
      I3 => xgmii_txd_4(33),
      O => BU2_U0_transmitter_seq_detect_i1_n0000
    );
  BU2_U0_transmitter_seq_detect_i1_n00011 : LUT4
    generic map(
      INIT => X"0008"
    )
    port map (
      I0 => xgmii_txd_4(36),
      I1 => xgmii_txd_4(39),
      I2 => xgmii_txd_4(37),
      I3 => xgmii_txd_4(38),
      O => BU2_U0_transmitter_seq_detect_i1_comp(1)
    );
  BU2_U0_transmitter_seq_detect_i1_n00021 : LUT4
    generic map(
      INIT => X"0002"
    )
    port map (
      I0 => xgmii_txc_5(4),
      I1 => xgmii_txc_5(5),
      I2 => xgmii_txc_5(6),
      I3 => xgmii_txc_5(7),
      O => BU2_U0_transmitter_seq_detect_i1_comp(2)
    );
  BU2_U0_transmitter_idle_detect_i0_muxcy_i7 : MUXCY_L
    port map (
      CI => BU2_U0_transmitter_idle_detect_i0_muxcyo(6),
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_idle_detect_i0_comp(7),
      LO => BU2_U0_transmitter_idle_detect_i0_muxcyo(7)
    );
  BU2_U0_transmitter_idle_detect_i0_muxcy_i8 : MUXCY_L
    port map (
      CI => BU2_U0_transmitter_idle_detect_i0_muxcyo(7),
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_idle_detect_i0_comp(8),
      LO => BU2_U0_transmitter_n0095
    );
  BU2_U0_transmitter_idle_detect_i0_muxcy_i1 : MUXCY_L
    port map (
      CI => BU2_U0_transmitter_idle_detect_i0_n0009,
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_idle_detect_i0_comp(1),
      LO => BU2_U0_transmitter_idle_detect_i0_muxcyo(1)
    );
  BU2_U0_transmitter_idle_detect_i0_muxcy_i0 : MUXCY_L
    port map (
      CI => NlwRenamedSig_OI_mgt_enable_align(0),
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_idle_detect_i0_n0000,
      LO => BU2_U0_transmitter_idle_detect_i0_n0009
    );
  BU2_U0_transmitter_idle_detect_i0_muxcy_i2 : MUXCY_L
    port map (
      CI => BU2_U0_transmitter_idle_detect_i0_muxcyo(1),
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_idle_detect_i0_comp(2),
      LO => BU2_U0_transmitter_idle_detect_i0_muxcyo(2)
    );
  BU2_U0_transmitter_idle_detect_i0_muxcy_i3 : MUXCY_L
    port map (
      CI => BU2_U0_transmitter_idle_detect_i0_muxcyo(2),
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_idle_detect_i0_comp(3),
      LO => BU2_U0_transmitter_idle_detect_i0_muxcyo(3)
    );
  BU2_U0_transmitter_idle_detect_i0_muxcy_i4 : MUXCY_L
    port map (
      CI => BU2_U0_transmitter_idle_detect_i0_muxcyo(3),
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_idle_detect_i0_comp(4),
      LO => BU2_U0_transmitter_idle_detect_i0_muxcyo(4)
    );
  BU2_U0_transmitter_idle_detect_i0_muxcy_i5 : MUXCY_L
    port map (
      CI => BU2_U0_transmitter_idle_detect_i0_muxcyo(4),
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_idle_detect_i0_comp(5),
      LO => BU2_U0_transmitter_idle_detect_i0_muxcyo(5)
    );
  BU2_U0_transmitter_idle_detect_i0_n00001 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => xgmii_txd_4(1),
      I1 => xgmii_txd_4(3),
      I2 => xgmii_txd_4(2),
      I3 => xgmii_txd_4(0),
      O => BU2_U0_transmitter_idle_detect_i0_n0000
    );
  BU2_U0_transmitter_idle_detect_i0_n00011 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => xgmii_txd_4(4),
      I1 => xgmii_txd_4(5),
      I2 => xgmii_txd_4(6),
      I3 => xgmii_txd_4(7),
      O => BU2_U0_transmitter_idle_detect_i0_comp(1)
    );
  BU2_U0_transmitter_idle_detect_i0_n00021 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => xgmii_txd_4(9),
      I1 => xgmii_txd_4(11),
      I2 => xgmii_txd_4(10),
      I3 => xgmii_txd_4(8),
      O => BU2_U0_transmitter_idle_detect_i0_comp(2)
    );
  BU2_U0_transmitter_idle_detect_i0_n00031 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => xgmii_txd_4(12),
      I1 => xgmii_txd_4(13),
      I2 => xgmii_txd_4(14),
      I3 => xgmii_txd_4(15),
      O => BU2_U0_transmitter_idle_detect_i0_comp(3)
    );
  BU2_U0_transmitter_idle_detect_i0_n00041 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => xgmii_txd_4(17),
      I1 => xgmii_txd_4(19),
      I2 => xgmii_txd_4(18),
      I3 => xgmii_txd_4(16),
      O => BU2_U0_transmitter_idle_detect_i0_comp(4)
    );
  BU2_U0_transmitter_idle_detect_i0_n00051 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => xgmii_txd_4(20),
      I1 => xgmii_txd_4(21),
      I2 => xgmii_txd_4(22),
      I3 => xgmii_txd_4(23),
      O => BU2_U0_transmitter_idle_detect_i0_comp(5)
    );
  BU2_U0_transmitter_idle_detect_i0_n00061 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => xgmii_txd_4(25),
      I1 => xgmii_txd_4(27),
      I2 => xgmii_txd_4(26),
      I3 => xgmii_txd_4(24),
      O => BU2_U0_transmitter_idle_detect_i0_comp(6)
    );
  BU2_U0_transmitter_idle_detect_i0_n00071 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => xgmii_txd_4(28),
      I1 => xgmii_txd_4(29),
      I2 => xgmii_txd_4(30),
      I3 => xgmii_txd_4(31),
      O => BU2_U0_transmitter_idle_detect_i0_comp(7)
    );
  BU2_U0_transmitter_idle_detect_i0_n00081 : LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => xgmii_txc_5(0),
      I1 => xgmii_txc_5(1),
      I2 => xgmii_txc_5(2),
      I3 => xgmii_txc_5(3),
      O => BU2_U0_transmitter_idle_detect_i0_comp(8)
    );
  BU2_U0_transmitter_idle_detect_i1_muxcy_i7 : MUXCY_L
    port map (
      CI => BU2_U0_transmitter_idle_detect_i1_muxcyo(6),
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_idle_detect_i1_comp(7),
      LO => BU2_U0_transmitter_idle_detect_i1_muxcyo(7)
    );
  BU2_U0_transmitter_idle_detect_i1_muxcy_i8 : MUXCY_L
    port map (
      CI => BU2_U0_transmitter_idle_detect_i1_muxcyo(7),
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_idle_detect_i1_comp(8),
      LO => BU2_U0_transmitter_tx_is_idle_comb(1)
    );
  BU2_U0_transmitter_idle_detect_i1_muxcy_i1 : MUXCY_L
    port map (
      CI => BU2_U0_transmitter_idle_detect_i1_n0009,
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_idle_detect_i1_comp(1),
      LO => BU2_U0_transmitter_idle_detect_i1_muxcyo(1)
    );
  BU2_U0_transmitter_idle_detect_i1_muxcy_i0 : MUXCY_L
    port map (
      CI => NlwRenamedSig_OI_mgt_enable_align(0),
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_idle_detect_i1_n0000,
      LO => BU2_U0_transmitter_idle_detect_i1_n0009
    );
  BU2_U0_transmitter_idle_detect_i1_muxcy_i2 : MUXCY_L
    port map (
      CI => BU2_U0_transmitter_idle_detect_i1_muxcyo(1),
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_idle_detect_i1_comp(2),
      LO => BU2_U0_transmitter_idle_detect_i1_muxcyo(2)
    );
  BU2_U0_transmitter_idle_detect_i1_muxcy_i3 : MUXCY_L
    port map (
      CI => BU2_U0_transmitter_idle_detect_i1_muxcyo(2),
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_idle_detect_i1_comp(3),
      LO => BU2_U0_transmitter_idle_detect_i1_muxcyo(3)
    );
  BU2_U0_transmitter_idle_detect_i1_muxcy_i4 : MUXCY_L
    port map (
      CI => BU2_U0_transmitter_idle_detect_i1_muxcyo(3),
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_idle_detect_i1_comp(4),
      LO => BU2_U0_transmitter_idle_detect_i1_muxcyo(4)
    );
  BU2_U0_transmitter_idle_detect_i1_muxcy_i5 : MUXCY_L
    port map (
      CI => BU2_U0_transmitter_idle_detect_i1_muxcyo(4),
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_idle_detect_i1_comp(5),
      LO => BU2_U0_transmitter_idle_detect_i1_muxcyo(5)
    );
  BU2_U0_transmitter_idle_detect_i1_n00001 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => xgmii_txd_4(33),
      I1 => xgmii_txd_4(35),
      I2 => xgmii_txd_4(34),
      I3 => xgmii_txd_4(32),
      O => BU2_U0_transmitter_idle_detect_i1_n0000
    );
  BU2_U0_transmitter_idle_detect_i1_n00011 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => xgmii_txd_4(36),
      I1 => xgmii_txd_4(37),
      I2 => xgmii_txd_4(38),
      I3 => xgmii_txd_4(39),
      O => BU2_U0_transmitter_idle_detect_i1_comp(1)
    );
  BU2_U0_transmitter_idle_detect_i1_n00021 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => xgmii_txd_4(41),
      I1 => xgmii_txd_4(43),
      I2 => xgmii_txd_4(42),
      I3 => xgmii_txd_4(40),
      O => BU2_U0_transmitter_idle_detect_i1_comp(2)
    );
  BU2_U0_transmitter_idle_detect_i1_n00031 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => xgmii_txd_4(44),
      I1 => xgmii_txd_4(45),
      I2 => xgmii_txd_4(46),
      I3 => xgmii_txd_4(47),
      O => BU2_U0_transmitter_idle_detect_i1_comp(3)
    );
  BU2_U0_transmitter_idle_detect_i1_n00041 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => xgmii_txd_4(49),
      I1 => xgmii_txd_4(51),
      I2 => xgmii_txd_4(50),
      I3 => xgmii_txd_4(48),
      O => BU2_U0_transmitter_idle_detect_i1_comp(4)
    );
  BU2_U0_transmitter_idle_detect_i1_n00051 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => xgmii_txd_4(52),
      I1 => xgmii_txd_4(53),
      I2 => xgmii_txd_4(54),
      I3 => xgmii_txd_4(55),
      O => BU2_U0_transmitter_idle_detect_i1_comp(5)
    );
  BU2_U0_transmitter_idle_detect_i1_n00061 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => xgmii_txd_4(57),
      I1 => xgmii_txd_4(59),
      I2 => xgmii_txd_4(58),
      I3 => xgmii_txd_4(56),
      O => BU2_U0_transmitter_idle_detect_i1_comp(6)
    );
  BU2_U0_transmitter_idle_detect_i1_n00071 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => xgmii_txd_4(60),
      I1 => xgmii_txd_4(61),
      I2 => xgmii_txd_4(62),
      I3 => xgmii_txd_4(63),
      O => BU2_U0_transmitter_idle_detect_i1_comp(7)
    );
  BU2_U0_transmitter_idle_detect_i1_n00081 : LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => xgmii_txc_5(4),
      I1 => xgmii_txc_5(5),
      I2 => xgmii_txc_5(6),
      I3 => xgmii_txc_5(7),
      O => BU2_U0_transmitter_idle_detect_i1_comp(8)
    );
  BU2_U0_transmitter_filter2_n0007_2_1 : LUT4_L
    generic map(
      INIT => X"FFA2"
    )
    port map (
      I0 => BU2_U0_transmitter_txc_pipe(2),
      I1 => BU2_U0_transmitter_txd_pipe(19),
      I2 => BU2_CHOICE1593,
      I3 => BU2_U0_transmitter_txd_pipe(18),
      LO => BU2_U0_transmitter_filter2_n0007(2)
    );
  BU2_U0_transmitter_filter0_n0007_5_1 : LUT4_L
    generic map(
      INIT => X"FCF8"
    )
    port map (
      I0 => BU2_U0_transmitter_filter0_n0001,
      I1 => BU2_U0_transmitter_txc_pipe(0),
      I2 => BU2_U0_transmitter_txd_pipe(5),
      I3 => BU2_N3420,
      LO => BU2_U0_transmitter_filter0_n0007(5)
    );
  BU2_U0_transmitter_filter0_n0007_0_1 : LUT4_L
    generic map(
      INIT => X"222A"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(0),
      I1 => BU2_U0_transmitter_txc_pipe(0),
      I2 => BU2_N3420,
      I3 => BU2_U0_transmitter_filter0_n0001,
      LO => BU2_U0_transmitter_filter0_n0007(0)
    );
  BU2_U0_transmitter_filter0_txd_out_3 : FDS
    port map (
      D => BU2_U0_transmitter_filter0_n0007(3),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter0_txd_out(3)
    );
  BU2_U0_transmitter_filter0_txd_out_2 : FDS
    port map (
      D => BU2_U0_transmitter_filter0_n0007(2),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter0_txd_out(2)
    );
  BU2_U0_transmitter_filter0_txd_out_1 : FDR
    port map (
      D => BU2_U0_transmitter_filter0_n0007(1),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter0_txd_out(1)
    );
  BU2_U0_transmitter_filter0_txd_out_0 : FDR
    port map (
      D => BU2_U0_transmitter_filter0_n0007(0),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter0_txd_out(0)
    );
  BU2_U0_transmitter_filter0_txd_out_6 : FDR
    port map (
      D => BU2_U0_transmitter_filter0_n0007(6),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter0_txd_out(6)
    );
  BU2_U0_transmitter_filter0_txd_out_7 : FDS
    port map (
      D => BU2_U0_transmitter_filter0_n0007(7),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter0_txd_out(7)
    );
  BU2_U0_transmitter_filter0_n0007_3_1 : LUT4_L
    generic map(
      INIT => X"FCF8"
    )
    port map (
      I0 => BU2_U0_transmitter_filter0_n0001,
      I1 => BU2_U0_transmitter_txc_pipe(0),
      I2 => BU2_U0_transmitter_txd_pipe(3),
      I3 => BU2_N3420,
      LO => BU2_U0_transmitter_filter0_n0007(3)
    );
  BU2_U0_transmitter_filter0_n0007_4_1 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_transmitter_txc_pipe(0),
      I1 => BU2_U0_transmitter_txd_pipe(4),
      O => BU2_U0_transmitter_filter0_n0007(4)
    );
  BU2_U0_receiver_recoder_n093169 : LUT4_D
    generic map(
      INIT => X"AA8A"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_lane_terminate(0),
      I1 => BU2_N3125,
      I2 => BU2_U0_receiver_recoder_N40,
      I3 => BU2_N3149,
      LO => BU2_N3657,
      O => BU2_CHOICE2205
    );
  BU2_U0_transmitter_filter0_n0007_6_1 : LUT4_L
    generic map(
      INIT => X"2E2A"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(6),
      I1 => BU2_U0_transmitter_txc_pipe(0),
      I2 => BU2_N3420,
      I3 => BU2_U0_transmitter_filter0_n0001,
      LO => BU2_U0_transmitter_filter0_n0007(6)
    );
  BU2_U0_transmitter_filter0_n0007_7_1 : LUT4_L
    generic map(
      INIT => X"FCF8"
    )
    port map (
      I0 => BU2_U0_transmitter_filter0_n0001,
      I1 => BU2_U0_transmitter_txc_pipe(0),
      I2 => BU2_U0_transmitter_txd_pipe(7),
      I3 => BU2_N3660,
      LO => BU2_U0_transmitter_filter0_n0007(7)
    );
  BU2_U0_transmitter_filter2_n000162 : LUT4
    generic map(
      INIT => X"13FF"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(17),
      I1 => BU2_U0_transmitter_txd_pipe(18),
      I2 => BU2_U0_transmitter_txd_pipe(16),
      I3 => BU2_U0_transmitter_txd_pipe(20),
      O => BU2_CHOICE1592
    );
  BU2_U0_transmitter_filter0_txd_out_4 : FDS
    port map (
      D => BU2_U0_transmitter_filter0_n0007(4),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter0_txd_out(4)
    );
  BU2_U0_transmitter_filter0_txd_out_5 : FDS
    port map (
      D => BU2_U0_transmitter_filter0_n0007(5),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter0_txd_out(5)
    );
  BU2_U0_transmitter_filter0_n0007_1_1 : LUT4_L
    generic map(
      INIT => X"2E2A"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(1),
      I1 => BU2_U0_transmitter_txc_pipe(0),
      I2 => BU2_N3420,
      I3 => BU2_U0_transmitter_filter0_n0001,
      LO => BU2_U0_transmitter_filter0_n0007(1)
    );
  BU2_U0_transmitter_filter3_n0007_2_1 : LUT4_L
    generic map(
      INIT => X"FFA2"
    )
    port map (
      I0 => BU2_U0_transmitter_txc_pipe(3),
      I1 => BU2_U0_transmitter_txd_pipe(27),
      I2 => BU2_CHOICE1537,
      I3 => BU2_U0_transmitter_txd_pipe(26),
      LO => BU2_U0_transmitter_filter3_n0007(2)
    );
  BU2_U0_transmitter_filter1_n0007_5_1 : LUT4_L
    generic map(
      INIT => X"FCF8"
    )
    port map (
      I0 => BU2_U0_transmitter_filter1_n0001,
      I1 => BU2_U0_transmitter_txc_pipe(1),
      I2 => BU2_U0_transmitter_txd_pipe(13),
      I3 => BU2_N3414,
      LO => BU2_U0_transmitter_filter1_n0007(5)
    );
  BU2_U0_transmitter_filter1_n0007_0_1 : LUT4_L
    generic map(
      INIT => X"222A"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(8),
      I1 => BU2_U0_transmitter_txc_pipe(1),
      I2 => BU2_N3414,
      I3 => BU2_U0_transmitter_filter1_n0001,
      LO => BU2_U0_transmitter_filter1_n0007(0)
    );
  BU2_U0_transmitter_filter1_txd_out_3 : FDS
    port map (
      D => BU2_U0_transmitter_filter1_n0007(3),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter1_txd_out(3)
    );
  BU2_U0_transmitter_filter1_txd_out_2 : FDS
    port map (
      D => BU2_U0_transmitter_filter1_n0007(2),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter1_txd_out(2)
    );
  BU2_U0_transmitter_filter1_txd_out_1 : FDR
    port map (
      D => BU2_U0_transmitter_filter1_n0007(1),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter1_txd_out(1)
    );
  BU2_U0_transmitter_filter1_txd_out_0 : FDR
    port map (
      D => BU2_U0_transmitter_filter1_n0007(0),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter1_txd_out(0)
    );
  BU2_U0_transmitter_filter1_txd_out_6 : FDR
    port map (
      D => BU2_U0_transmitter_filter1_n0007(6),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter1_txd_out(6)
    );
  BU2_U0_transmitter_filter1_txd_out_7 : FDS
    port map (
      D => BU2_U0_transmitter_filter1_n0007(7),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter1_txd_out(7)
    );
  BU2_U0_transmitter_filter1_n0007_3_1 : LUT4_L
    generic map(
      INIT => X"FCF8"
    )
    port map (
      I0 => BU2_U0_transmitter_filter1_n0001,
      I1 => BU2_U0_transmitter_txc_pipe(1),
      I2 => BU2_U0_transmitter_txd_pipe(11),
      I3 => BU2_N3414,
      LO => BU2_U0_transmitter_filter1_n0007(3)
    );
  BU2_U0_transmitter_filter1_n0007_4_1 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_transmitter_txc_pipe(1),
      I1 => BU2_U0_transmitter_txd_pipe(12),
      O => BU2_U0_transmitter_filter1_n0007(4)
    );
  BU2_U0_receiver_recoder_n095529_SW0 : LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxc_pipe(7),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(63),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(61),
      O => BU2_N3332
    );
  BU2_U0_transmitter_filter1_n0007_6_1 : LUT4_L
    generic map(
      INIT => X"2E2A"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(14),
      I1 => BU2_U0_transmitter_txc_pipe(1),
      I2 => BU2_N3414,
      I3 => BU2_U0_transmitter_filter1_n0001,
      LO => BU2_U0_transmitter_filter1_n0007(6)
    );
  BU2_U0_transmitter_filter1_n0007_7_1 : LUT4_L
    generic map(
      INIT => X"FCF8"
    )
    port map (
      I0 => BU2_U0_transmitter_filter1_n0001,
      I1 => BU2_U0_transmitter_txc_pipe(1),
      I2 => BU2_U0_transmitter_txd_pipe(15),
      I3 => BU2_N3674,
      LO => BU2_U0_transmitter_filter1_n0007(7)
    );
  BU2_U0_transmitter_filter3_n000162 : LUT4
    generic map(
      INIT => X"13FF"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(25),
      I1 => BU2_U0_transmitter_txd_pipe(26),
      I2 => BU2_U0_transmitter_txd_pipe(24),
      I3 => BU2_U0_transmitter_txd_pipe(28),
      O => BU2_CHOICE1536
    );
  BU2_U0_transmitter_filter1_txd_out_4 : FDS
    port map (
      D => BU2_U0_transmitter_filter1_n0007(4),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter1_txd_out(4)
    );
  BU2_U0_transmitter_filter1_txd_out_5 : FDS
    port map (
      D => BU2_U0_transmitter_filter1_n0007(5),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter1_txd_out(5)
    );
  BU2_U0_transmitter_filter1_n0007_1_1 : LUT4_L
    generic map(
      INIT => X"2E2A"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(9),
      I1 => BU2_U0_transmitter_txc_pipe(1),
      I2 => BU2_N3414,
      I3 => BU2_U0_transmitter_filter1_n0001,
      LO => BU2_U0_transmitter_filter1_n0007(1)
    );
  BU2_U0_transmitter_filter4_n0007_2_1 : LUT4_L
    generic map(
      INIT => X"FFA2"
    )
    port map (
      I0 => BU2_U0_transmitter_txc_pipe(4),
      I1 => BU2_U0_transmitter_txd_pipe(35),
      I2 => BU2_CHOICE1565,
      I3 => BU2_U0_transmitter_txd_pipe(34),
      LO => BU2_U0_transmitter_filter4_n0007(2)
    );
  BU2_U0_transmitter_filter2_n0007_5_1 : LUT4_L
    generic map(
      INIT => X"FCF8"
    )
    port map (
      I0 => BU2_U0_transmitter_filter2_n0001,
      I1 => BU2_U0_transmitter_txc_pipe(2),
      I2 => BU2_U0_transmitter_txd_pipe(21),
      I3 => BU2_N3398,
      LO => BU2_U0_transmitter_filter2_n0007(5)
    );
  BU2_U0_transmitter_filter2_n0007_0_1 : LUT4_L
    generic map(
      INIT => X"222A"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(16),
      I1 => BU2_U0_transmitter_txc_pipe(2),
      I2 => BU2_N3398,
      I3 => BU2_U0_transmitter_filter2_n0001,
      LO => BU2_U0_transmitter_filter2_n0007(0)
    );
  BU2_U0_transmitter_filter2_txd_out_3 : FDS
    port map (
      D => BU2_U0_transmitter_filter2_n0007(3),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter2_txd_out(3)
    );
  BU2_U0_transmitter_filter2_txd_out_2 : FDS
    port map (
      D => BU2_U0_transmitter_filter2_n0007(2),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter2_txd_out(2)
    );
  BU2_U0_transmitter_filter2_txd_out_1 : FDR
    port map (
      D => BU2_U0_transmitter_filter2_n0007(1),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter2_txd_out(1)
    );
  BU2_U0_transmitter_filter2_txd_out_0 : FDR
    port map (
      D => BU2_U0_transmitter_filter2_n0007(0),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter2_txd_out(0)
    );
  BU2_U0_transmitter_filter2_txd_out_6 : FDR
    port map (
      D => BU2_U0_transmitter_filter2_n0007(6),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter2_txd_out(6)
    );
  BU2_U0_transmitter_filter2_txd_out_7 : FDS
    port map (
      D => BU2_U0_transmitter_filter2_n0007(7),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter2_txd_out(7)
    );
  BU2_U0_transmitter_filter2_n0007_3_1 : LUT4_L
    generic map(
      INIT => X"FCF8"
    )
    port map (
      I0 => BU2_U0_transmitter_filter2_n0001,
      I1 => BU2_U0_transmitter_txc_pipe(2),
      I2 => BU2_U0_transmitter_txd_pipe(19),
      I3 => BU2_N3398,
      LO => BU2_U0_transmitter_filter2_n0007(3)
    );
  BU2_U0_transmitter_filter2_n0007_4_1 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_transmitter_txc_pipe(2),
      I1 => BU2_U0_transmitter_txd_pipe(20),
      O => BU2_U0_transmitter_filter2_n0007(4)
    );
  BU2_U0_receiver_non_iee_deskew_state_Ker320_SW0 : LUT4
    generic map(
      INIT => X"F7FF"
    )
    port map (
      I0 => mgt_rxdata_6(3),
      I1 => mgt_rxdata_6(2),
      I2 => mgt_rxdata_6(1),
      I3 => BU2_CHOICE1141,
      O => BU2_N3542
    );
  BU2_U0_transmitter_filter2_n0007_6_1 : LUT4_L
    generic map(
      INIT => X"2E2A"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(22),
      I1 => BU2_U0_transmitter_txc_pipe(2),
      I2 => BU2_N3398,
      I3 => BU2_U0_transmitter_filter2_n0001,
      LO => BU2_U0_transmitter_filter2_n0007(6)
    );
  BU2_U0_transmitter_filter2_n0007_7_1 : LUT4_L
    generic map(
      INIT => X"FCF8"
    )
    port map (
      I0 => BU2_U0_transmitter_filter2_n0001,
      I1 => BU2_U0_transmitter_txc_pipe(2),
      I2 => BU2_U0_transmitter_txd_pipe(23),
      I3 => BU2_N3658,
      LO => BU2_U0_transmitter_filter2_n0007(7)
    );
  BU2_U0_transmitter_filter6_n000164 : LUT4_D
    generic map(
      INIT => X"FCF8"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(49),
      I1 => BU2_CHOICE1472,
      I2 => BU2_CHOICE1480,
      I3 => BU2_U0_transmitter_txd_pipe(48),
      LO => BU2_N3656,
      O => BU2_CHOICE1481
    );
  BU2_U0_transmitter_filter2_txd_out_4 : FDS
    port map (
      D => BU2_U0_transmitter_filter2_n0007(4),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter2_txd_out(4)
    );
  BU2_U0_transmitter_filter2_txd_out_5 : FDS
    port map (
      D => BU2_U0_transmitter_filter2_n0007(5),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter2_txd_out(5)
    );
  BU2_U0_transmitter_filter2_n0007_1_1 : LUT4_L
    generic map(
      INIT => X"2E2A"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(17),
      I1 => BU2_U0_transmitter_txc_pipe(2),
      I2 => BU2_N3398,
      I3 => BU2_U0_transmitter_filter2_n0001,
      LO => BU2_U0_transmitter_filter2_n0007(1)
    );
  BU2_U0_transmitter_filter5_n0007_2_1 : LUT4_L
    generic map(
      INIT => X"FFA2"
    )
    port map (
      I0 => BU2_U0_transmitter_txc_pipe(5),
      I1 => BU2_U0_transmitter_txd_pipe(43),
      I2 => BU2_CHOICE1509,
      I3 => BU2_U0_transmitter_txd_pipe(42),
      LO => BU2_U0_transmitter_filter5_n0007(2)
    );
  BU2_U0_transmitter_filter3_n0007_5_1 : LUT4_L
    generic map(
      INIT => X"FCF8"
    )
    port map (
      I0 => BU2_U0_transmitter_filter3_n0001,
      I1 => BU2_U0_transmitter_txc_pipe(3),
      I2 => BU2_U0_transmitter_txd_pipe(29),
      I3 => BU2_N3390,
      LO => BU2_U0_transmitter_filter3_n0007(5)
    );
  BU2_U0_transmitter_filter3_n0007_0_1 : LUT4_L
    generic map(
      INIT => X"222A"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(24),
      I1 => BU2_U0_transmitter_txc_pipe(3),
      I2 => BU2_N3390,
      I3 => BU2_U0_transmitter_filter3_n0001,
      LO => BU2_U0_transmitter_filter3_n0007(0)
    );
  BU2_U0_transmitter_filter3_txd_out_3 : FDS
    port map (
      D => BU2_U0_transmitter_filter3_n0007(3),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter3_txd_out(3)
    );
  BU2_U0_transmitter_filter3_txd_out_2 : FDS
    port map (
      D => BU2_U0_transmitter_filter3_n0007(2),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter3_txd_out(2)
    );
  BU2_U0_transmitter_filter3_txd_out_1 : FDR
    port map (
      D => BU2_U0_transmitter_filter3_n0007(1),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter3_txd_out(1)
    );
  BU2_U0_transmitter_filter3_txd_out_0 : FDR
    port map (
      D => BU2_U0_transmitter_filter3_n0007(0),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter3_txd_out(0)
    );
  BU2_U0_transmitter_filter3_txd_out_6 : FDR
    port map (
      D => BU2_U0_transmitter_filter3_n0007(6),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter3_txd_out(6)
    );
  BU2_U0_transmitter_filter3_txd_out_7 : FDS
    port map (
      D => BU2_U0_transmitter_filter3_n0007(7),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter3_txd_out(7)
    );
  BU2_U0_transmitter_filter3_n0007_3_1 : LUT4_L
    generic map(
      INIT => X"FCF8"
    )
    port map (
      I0 => BU2_U0_transmitter_filter3_n0001,
      I1 => BU2_U0_transmitter_txc_pipe(3),
      I2 => BU2_U0_transmitter_txd_pipe(27),
      I3 => BU2_N3390,
      LO => BU2_U0_transmitter_filter3_n0007(3)
    );
  BU2_U0_transmitter_filter3_n0007_4_1 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_transmitter_txc_pipe(3),
      I1 => BU2_U0_transmitter_txd_pipe(28),
      O => BU2_U0_transmitter_filter3_n0007(4)
    );
  BU2_U0_receiver_recoder_n095511 : LUT4
    generic map(
      INIT => X"FFDF"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(59),
      I1 => BU2_U0_receiver_recoder_code_error_pipe(7),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(60),
      I3 => BU2_U0_receiver_recoder_rxd_pipe(56),
      O => BU2_CHOICE1881
    );
  BU2_U0_transmitter_filter3_n0007_6_1 : LUT4_L
    generic map(
      INIT => X"2E2A"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(30),
      I1 => BU2_U0_transmitter_txc_pipe(3),
      I2 => BU2_N3390,
      I3 => BU2_U0_transmitter_filter3_n0001,
      LO => BU2_U0_transmitter_filter3_n0007(6)
    );
  BU2_U0_transmitter_filter3_n0007_7_1 : LUT4_L
    generic map(
      INIT => X"FCF8"
    )
    port map (
      I0 => BU2_U0_transmitter_filter3_n0001,
      I1 => BU2_U0_transmitter_txc_pipe(3),
      I2 => BU2_U0_transmitter_txd_pipe(31),
      I3 => BU2_N3390,
      LO => BU2_U0_transmitter_filter3_n0007(7)
    );
  BU2_U0_transmitter_filter5_n002220 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(43),
      I1 => BU2_U0_transmitter_txd_pipe(44),
      I2 => BU2_U0_transmitter_txd_pipe(45),
      I3 => BU2_U0_transmitter_txd_pipe(46),
      O => BU2_CHOICE1768
    );
  BU2_U0_transmitter_filter3_txd_out_4 : FDS
    port map (
      D => BU2_U0_transmitter_filter3_n0007(4),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter3_txd_out(4)
    );
  BU2_U0_transmitter_filter3_txd_out_5 : FDS
    port map (
      D => BU2_U0_transmitter_filter3_n0007(5),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter3_txd_out(5)
    );
  BU2_U0_transmitter_filter3_n0007_1_1 : LUT4_L
    generic map(
      INIT => X"2E2A"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(25),
      I1 => BU2_U0_transmitter_txc_pipe(3),
      I2 => BU2_N3390,
      I3 => BU2_U0_transmitter_filter3_n0001,
      LO => BU2_U0_transmitter_filter3_n0007(1)
    );
  BU2_U0_transmitter_filter6_n0007_2_1 : LUT4_L
    generic map(
      INIT => X"FFA2"
    )
    port map (
      I0 => BU2_U0_transmitter_txc_pipe(6),
      I1 => BU2_U0_transmitter_txd_pipe(51),
      I2 => BU2_CHOICE1481,
      I3 => BU2_U0_transmitter_txd_pipe(50),
      LO => BU2_U0_transmitter_filter6_n0007(2)
    );
  BU2_U0_transmitter_filter4_n0007_5_1 : LUT4_L
    generic map(
      INIT => X"FCF8"
    )
    port map (
      I0 => BU2_U0_transmitter_filter4_n0001,
      I1 => BU2_U0_transmitter_txc_pipe(4),
      I2 => BU2_U0_transmitter_txd_pipe(37),
      I3 => BU2_N3370,
      LO => BU2_U0_transmitter_filter4_n0007(5)
    );
  BU2_U0_transmitter_filter4_n0007_0_1 : LUT4_L
    generic map(
      INIT => X"222A"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(32),
      I1 => BU2_U0_transmitter_txc_pipe(4),
      I2 => BU2_N3370,
      I3 => BU2_U0_transmitter_filter4_n0001,
      LO => BU2_U0_transmitter_filter4_n0007(0)
    );
  BU2_U0_transmitter_filter4_txd_out_3 : FDS
    port map (
      D => BU2_U0_transmitter_filter4_n0007(3),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter4_txd_out(3)
    );
  BU2_U0_transmitter_filter4_txd_out_2 : FDS
    port map (
      D => BU2_U0_transmitter_filter4_n0007(2),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter4_txd_out(2)
    );
  BU2_U0_transmitter_filter4_txd_out_1 : FDR
    port map (
      D => BU2_U0_transmitter_filter4_n0007(1),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter4_txd_out(1)
    );
  BU2_U0_transmitter_filter4_txd_out_0 : FDR
    port map (
      D => BU2_U0_transmitter_filter4_n0007(0),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter4_txd_out(0)
    );
  BU2_U0_transmitter_filter4_txd_out_6 : FDR
    port map (
      D => BU2_U0_transmitter_filter4_n0007(6),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter4_txd_out(6)
    );
  BU2_U0_transmitter_filter4_txd_out_7 : FDS
    port map (
      D => BU2_U0_transmitter_filter4_n0007(7),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter4_txd_out(7)
    );
  BU2_U0_transmitter_filter4_n0007_3_1 : LUT4_L
    generic map(
      INIT => X"FCF8"
    )
    port map (
      I0 => BU2_U0_transmitter_filter4_n0001,
      I1 => BU2_U0_transmitter_txc_pipe(4),
      I2 => BU2_U0_transmitter_txd_pipe(35),
      I3 => BU2_N3370,
      LO => BU2_U0_transmitter_filter4_n0007(3)
    );
  BU2_U0_transmitter_filter4_n0007_4_1 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_transmitter_txc_pipe(4),
      I1 => BU2_U0_transmitter_txd_pipe(36),
      O => BU2_U0_transmitter_filter4_n0007(4)
    );
  BU2_U0_transmitter_state_machine_n0003_1_8 : LUT4
    generic map(
      INIT => X"3320"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_next_ifg_is_a,
      I1 => BU2_U0_transmitter_state_machine_state_1_1_1,
      I2 => BU2_U0_transmitter_state_machine_state_1_0_2,
      I3 => BU2_U0_transmitter_state_machine_state_1_2_1,
      O => BU2_CHOICE2119
    );
  BU2_U0_transmitter_filter4_n0007_6_1 : LUT4_L
    generic map(
      INIT => X"2E2A"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(38),
      I1 => BU2_U0_transmitter_txc_pipe(4),
      I2 => BU2_N3370,
      I3 => BU2_U0_transmitter_filter4_n0001,
      LO => BU2_U0_transmitter_filter4_n0007(6)
    );
  BU2_U0_transmitter_filter4_n0007_7_1 : LUT4_L
    generic map(
      INIT => X"FCF8"
    )
    port map (
      I0 => BU2_U0_transmitter_filter4_n0001,
      I1 => BU2_U0_transmitter_txc_pipe(4),
      I2 => BU2_U0_transmitter_txd_pipe(39),
      I3 => BU2_N3651,
      LO => BU2_U0_transmitter_filter4_n0007(7)
    );
  BU2_U0_transmitter_filter6_n0007_6_1_SW0 : LUT3_D
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => BU2_CHOICE1755,
      I1 => BU2_CHOICE1748,
      I2 => BU2_U0_transmitter_is_terminate(1),
      LO => BU2_N3655,
      O => BU2_N3350
    );
  BU2_U0_transmitter_filter4_txd_out_4 : FDS
    port map (
      D => BU2_U0_transmitter_filter4_n0007(4),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter4_txd_out(4)
    );
  BU2_U0_transmitter_filter4_txd_out_5 : FDS
    port map (
      D => BU2_U0_transmitter_filter4_n0007(5),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter4_txd_out(5)
    );
  BU2_U0_transmitter_filter4_n0007_1_1 : LUT4_L
    generic map(
      INIT => X"2E2A"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(33),
      I1 => BU2_U0_transmitter_txc_pipe(4),
      I2 => BU2_N3370,
      I3 => BU2_U0_transmitter_filter4_n0001,
      LO => BU2_U0_transmitter_filter4_n0007(1)
    );
  BU2_U0_transmitter_filter7_n0007_2_1 : LUT4_L
    generic map(
      INIT => X"FFA2"
    )
    port map (
      I0 => BU2_U0_transmitter_txc_pipe(7),
      I1 => BU2_U0_transmitter_txd_pipe(59),
      I2 => BU2_CHOICE1453,
      I3 => BU2_U0_transmitter_txd_pipe(58),
      LO => BU2_U0_transmitter_filter7_n0007(2)
    );
  BU2_U0_transmitter_filter5_n0007_5_1 : LUT4_L
    generic map(
      INIT => X"FCF8"
    )
    port map (
      I0 => BU2_U0_transmitter_filter5_n0001,
      I1 => BU2_U0_transmitter_txc_pipe(5),
      I2 => BU2_U0_transmitter_txd_pipe(45),
      I3 => BU2_N3358,
      LO => BU2_U0_transmitter_filter5_n0007(5)
    );
  BU2_U0_transmitter_filter5_n0007_0_1 : LUT4_L
    generic map(
      INIT => X"222A"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(40),
      I1 => BU2_U0_transmitter_txc_pipe(5),
      I2 => BU2_N3358,
      I3 => BU2_U0_transmitter_filter5_n0001,
      LO => BU2_U0_transmitter_filter5_n0007(0)
    );
  BU2_U0_transmitter_filter5_txd_out_3 : FDS
    port map (
      D => BU2_U0_transmitter_filter5_n0007(3),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter5_txd_out(3)
    );
  BU2_U0_transmitter_filter5_txd_out_2 : FDS
    port map (
      D => BU2_U0_transmitter_filter5_n0007(2),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter5_txd_out(2)
    );
  BU2_U0_transmitter_filter5_txd_out_1 : FDR
    port map (
      D => BU2_U0_transmitter_filter5_n0007(1),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter5_txd_out(1)
    );
  BU2_U0_transmitter_filter5_txd_out_0 : FDR
    port map (
      D => BU2_U0_transmitter_filter5_n0007(0),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter5_txd_out(0)
    );
  BU2_U0_transmitter_filter5_txd_out_6 : FDR
    port map (
      D => BU2_U0_transmitter_filter5_n0007(6),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter5_txd_out(6)
    );
  BU2_U0_transmitter_filter5_txd_out_7 : FDS
    port map (
      D => BU2_U0_transmitter_filter5_n0007(7),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter5_txd_out(7)
    );
  BU2_U0_transmitter_filter5_n0007_3_1 : LUT4_L
    generic map(
      INIT => X"FCF8"
    )
    port map (
      I0 => BU2_U0_transmitter_filter5_n0001,
      I1 => BU2_U0_transmitter_txc_pipe(5),
      I2 => BU2_U0_transmitter_txd_pipe(43),
      I3 => BU2_N3358,
      LO => BU2_U0_transmitter_filter5_n0007(3)
    );
  BU2_U0_transmitter_filter5_n0007_4_1 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_transmitter_txc_pipe(5),
      I1 => BU2_U0_transmitter_txd_pipe(44),
      O => BU2_U0_transmitter_filter5_n0007(4)
    );
  BU2_U0_transmitter_filter4_n000162 : LUT4
    generic map(
      INIT => X"13FF"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(33),
      I1 => BU2_U0_transmitter_txd_pipe(34),
      I2 => BU2_U0_transmitter_txd_pipe(32),
      I3 => BU2_U0_transmitter_txd_pipe(36),
      O => BU2_CHOICE1564
    );
  BU2_U0_transmitter_filter5_n0007_6_1 : LUT4_L
    generic map(
      INIT => X"2E2A"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(46),
      I1 => BU2_U0_transmitter_txc_pipe(5),
      I2 => BU2_N3358,
      I3 => BU2_U0_transmitter_filter5_n0001,
      LO => BU2_U0_transmitter_filter5_n0007(6)
    );
  BU2_U0_transmitter_filter5_n0007_7_1 : LUT4_L
    generic map(
      INIT => X"FCF8"
    )
    port map (
      I0 => BU2_U0_transmitter_filter5_n0001,
      I1 => BU2_U0_transmitter_txc_pipe(5),
      I2 => BU2_U0_transmitter_txd_pipe(47),
      I3 => BU2_N3358,
      LO => BU2_U0_transmitter_filter5_n0007(7)
    );
  BU2_U0_transmitter_recoder_n0408181 : LUT4
    generic map(
      INIT => X"1032"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_0,
      I1 => BU2_U0_transmitter_recoder_n0481,
      I2 => BU2_U0_transmitter_state_machine_state_0_1,
      I3 => BU2_N3620,
      O => BU2_N3119
    );
  BU2_U0_transmitter_filter5_txd_out_4 : FDS
    port map (
      D => BU2_U0_transmitter_filter5_n0007(4),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter5_txd_out(4)
    );
  BU2_U0_transmitter_filter5_txd_out_5 : FDS
    port map (
      D => BU2_U0_transmitter_filter5_n0007(5),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter5_txd_out(5)
    );
  BU2_U0_transmitter_filter5_n0007_1_1 : LUT4_L
    generic map(
      INIT => X"2E2A"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(41),
      I1 => BU2_U0_transmitter_txc_pipe(5),
      I2 => BU2_N3358,
      I3 => BU2_U0_transmitter_filter5_n0001,
      LO => BU2_U0_transmitter_filter5_n0007(1)
    );
  BU2_U0_transmitter_filter0_n0007_2_1 : LUT4_L
    generic map(
      INIT => X"FFA2"
    )
    port map (
      I0 => BU2_U0_transmitter_txc_pipe(0),
      I1 => BU2_U0_transmitter_txd_pipe(3),
      I2 => BU2_CHOICE1621,
      I3 => BU2_U0_transmitter_txd_pipe(2),
      LO => BU2_U0_transmitter_filter0_n0007(2)
    );
  BU2_U0_transmitter_filter6_n0007_5_1 : LUT4_L
    generic map(
      INIT => X"FCF8"
    )
    port map (
      I0 => BU2_U0_transmitter_filter6_n0001,
      I1 => BU2_U0_transmitter_txc_pipe(6),
      I2 => BU2_U0_transmitter_txd_pipe(53),
      I3 => BU2_N3350,
      LO => BU2_U0_transmitter_filter6_n0007(5)
    );
  BU2_U0_transmitter_filter6_n0007_0_1 : LUT4_L
    generic map(
      INIT => X"222A"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(48),
      I1 => BU2_U0_transmitter_txc_pipe(6),
      I2 => BU2_N3350,
      I3 => BU2_U0_transmitter_filter6_n0001,
      LO => BU2_U0_transmitter_filter6_n0007(0)
    );
  BU2_U0_transmitter_filter6_txd_out_3 : FDS
    port map (
      D => BU2_U0_transmitter_filter6_n0007(3),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter6_txd_out(3)
    );
  BU2_U0_transmitter_filter6_txd_out_2 : FDS
    port map (
      D => BU2_U0_transmitter_filter6_n0007(2),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter6_txd_out(2)
    );
  BU2_U0_transmitter_filter6_txd_out_1 : FDR
    port map (
      D => BU2_U0_transmitter_filter6_n0007(1),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter6_txd_out(1)
    );
  BU2_U0_transmitter_filter6_txd_out_0 : FDR
    port map (
      D => BU2_U0_transmitter_filter6_n0007(0),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter6_txd_out(0)
    );
  BU2_U0_transmitter_filter6_txd_out_6 : FDR
    port map (
      D => BU2_U0_transmitter_filter6_n0007(6),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter6_txd_out(6)
    );
  BU2_U0_transmitter_filter6_txd_out_7 : FDS
    port map (
      D => BU2_U0_transmitter_filter6_n0007(7),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter6_txd_out(7)
    );
  BU2_U0_transmitter_filter6_n0007_3_1 : LUT4_L
    generic map(
      INIT => X"FCF8"
    )
    port map (
      I0 => BU2_U0_transmitter_filter6_n0001,
      I1 => BU2_U0_transmitter_txc_pipe(6),
      I2 => BU2_U0_transmitter_txd_pipe(51),
      I3 => BU2_N3350,
      LO => BU2_U0_transmitter_filter6_n0007(3)
    );
  BU2_U0_transmitter_filter6_n0007_4_1 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_transmitter_txc_pipe(6),
      I1 => BU2_U0_transmitter_txd_pipe(52),
      O => BU2_U0_transmitter_filter6_n0007(4)
    );
  BU2_U0_transmitter_filter5_n000130 : LUT4
    generic map(
      INIT => X"9555"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(43),
      I1 => BU2_U0_transmitter_txd_pipe(41),
      I2 => BU2_U0_transmitter_txd_pipe(40),
      I3 => BU2_U0_transmitter_txd_pipe(42),
      O => BU2_CHOICE1494
    );
  BU2_U0_transmitter_filter6_n0007_6_1 : LUT4_L
    generic map(
      INIT => X"2E2A"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(54),
      I1 => BU2_U0_transmitter_txc_pipe(6),
      I2 => BU2_N3350,
      I3 => BU2_U0_transmitter_filter6_n0001,
      LO => BU2_U0_transmitter_filter6_n0007(6)
    );
  BU2_U0_transmitter_filter6_n0007_7_1 : LUT4_L
    generic map(
      INIT => X"FCF8"
    )
    port map (
      I0 => BU2_U0_transmitter_filter6_n0001,
      I1 => BU2_U0_transmitter_txc_pipe(6),
      I2 => BU2_U0_transmitter_txd_pipe(55),
      I3 => BU2_N3655,
      LO => BU2_U0_transmitter_filter6_n0007(7)
    );
  BU2_U0_receiver_recoder_n053748_SW0 : LUT3
    generic map(
      INIT => X"EF"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(17),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(16),
      I2 => BU2_U0_receiver_recoder_rxc_half_pipe(2),
      O => BU2_N3135
    );
  BU2_U0_transmitter_filter6_txd_out_4 : FDS
    port map (
      D => BU2_U0_transmitter_filter6_n0007(4),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter6_txd_out(4)
    );
  BU2_U0_transmitter_filter6_txd_out_5 : FDS
    port map (
      D => BU2_U0_transmitter_filter6_n0007(5),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter6_txd_out(5)
    );
  BU2_U0_transmitter_filter6_n0007_1_1 : LUT4_L
    generic map(
      INIT => X"2E2A"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(49),
      I1 => BU2_U0_transmitter_txc_pipe(6),
      I2 => BU2_N3350,
      I3 => BU2_U0_transmitter_filter6_n0001,
      LO => BU2_U0_transmitter_filter6_n0007(1)
    );
  BU2_U0_receiver_recoder_n04711 : LUT4_L
    generic map(
      INIT => X"82AA"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(13),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(14),
      I2 => BU2_U0_receiver_recoder_rxd_half_pipe(15),
      I3 => BU2_CHOICE1730,
      LO => BU2_U0_receiver_recoder_n0471
    );
  BU2_U0_transmitter_filter7_n0007_5_1 : LUT4_L
    generic map(
      INIT => X"FCF8"
    )
    port map (
      I0 => BU2_U0_transmitter_filter7_n0001,
      I1 => BU2_U0_transmitter_txc_pipe(7),
      I2 => BU2_U0_transmitter_txd_pipe(61),
      I3 => BU2_N3344,
      LO => BU2_U0_transmitter_filter7_n0007(5)
    );
  BU2_U0_transmitter_filter7_n0007_0_1 : LUT4_L
    generic map(
      INIT => X"222A"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(56),
      I1 => BU2_U0_transmitter_txc_pipe(7),
      I2 => BU2_N3344,
      I3 => BU2_U0_transmitter_filter7_n0001,
      LO => BU2_U0_transmitter_filter7_n0007(0)
    );
  BU2_U0_transmitter_filter7_txd_out_3 : FDS
    port map (
      D => BU2_U0_transmitter_filter7_n0007(3),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter7_txd_out(3)
    );
  BU2_U0_transmitter_filter7_txd_out_2 : FDS
    port map (
      D => BU2_U0_transmitter_filter7_n0007(2),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter7_txd_out(2)
    );
  BU2_U0_transmitter_filter7_txd_out_1 : FDR
    port map (
      D => BU2_U0_transmitter_filter7_n0007(1),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter7_txd_out(1)
    );
  BU2_U0_transmitter_filter7_txd_out_0 : FDR
    port map (
      D => BU2_U0_transmitter_filter7_n0007(0),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter7_txd_out(0)
    );
  BU2_U0_transmitter_filter7_txd_out_6 : FDR
    port map (
      D => BU2_U0_transmitter_filter7_n0007(6),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter7_txd_out(6)
    );
  BU2_U0_transmitter_filter7_txd_out_7 : FDS
    port map (
      D => BU2_U0_transmitter_filter7_n0007(7),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter7_txd_out(7)
    );
  BU2_U0_transmitter_filter7_n0007_3_1 : LUT4_L
    generic map(
      INIT => X"FCF8"
    )
    port map (
      I0 => BU2_U0_transmitter_filter7_n0001,
      I1 => BU2_U0_transmitter_txc_pipe(7),
      I2 => BU2_U0_transmitter_txd_pipe(59),
      I3 => BU2_N3653,
      LO => BU2_U0_transmitter_filter7_n0007(3)
    );
  BU2_U0_transmitter_filter7_n0007_4_1 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_transmitter_txc_pipe(7),
      I1 => BU2_U0_transmitter_txd_pipe(60),
      O => BU2_U0_transmitter_filter7_n0007(4)
    );
  BU2_U0_transmitter_tqmsg_capture_1_n001322 : LUT4_D
    generic map(
      INIT => X"0002"
    )
    port map (
      I0 => BU2_U0_transmitter_filter0_txc_out,
      I1 => BU2_U0_transmitter_filter1_txc_out,
      I2 => BU2_U0_transmitter_filter2_txc_out,
      I3 => BU2_U0_transmitter_filter3_txc_out,
      LO => BU2_N3654,
      O => BU2_CHOICE1419
    );
  BU2_U0_transmitter_filter7_n0007_6_1 : LUT4_L
    generic map(
      INIT => X"2E2A"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(62),
      I1 => BU2_U0_transmitter_txc_pipe(7),
      I2 => BU2_N3344,
      I3 => BU2_U0_transmitter_filter7_n0001,
      LO => BU2_U0_transmitter_filter7_n0007(6)
    );
  BU2_U0_transmitter_filter7_n0007_7_1 : LUT4_L
    generic map(
      INIT => X"FCF8"
    )
    port map (
      I0 => BU2_U0_transmitter_filter7_n0001,
      I1 => BU2_U0_transmitter_txc_pipe(7),
      I2 => BU2_U0_transmitter_txd_pipe(63),
      I3 => BU2_N3344,
      LO => BU2_U0_transmitter_filter7_n0007(7)
    );
  BU2_U0_receiver_n002349 : LUT4
    generic map(
      INIT => X"AF8F"
    )
    port map (
      I0 => BU2_CHOICE1204,
      I1 => mgt_rxdata_6(16),
      I2 => mgt_rxdata_6(20),
      I3 => mgt_rxdata_6(17),
      O => BU2_CHOICE1206
    );
  BU2_U0_transmitter_filter7_txd_out_4 : FDS
    port map (
      D => BU2_U0_transmitter_filter7_n0007(4),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter7_txd_out(4)
    );
  BU2_U0_transmitter_filter7_txd_out_5 : FDS
    port map (
      D => BU2_U0_transmitter_filter7_n0007(5),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter7_txd_out(5)
    );
  BU2_U0_transmitter_filter7_n0007_1_1 : LUT4_L
    generic map(
      INIT => X"2E2A"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(57),
      I1 => BU2_U0_transmitter_txc_pipe(7),
      I2 => BU2_N3344,
      I3 => BU2_U0_transmitter_filter7_n0001,
      LO => BU2_U0_transmitter_filter7_n0007(1)
    );
  BU2_U0_receiver_recoder_rxd_out_34 : FDS
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(2),
      S => BU2_U0_receiver_recoder_n0489,
      C => usrclk,
      Q => xgmii_rxd_0(34)
    );
  BU2_U0_receiver_recoder_rxd_out_29 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_n0490,
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_n0921(2),
      C => usrclk,
      Q => xgmii_rxd_0(29)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_29 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(61),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(29)
    );
  BU2_U0_receiver_recoder_rxc_pipe_6 : FDR
    port map (
      D => mgt_rxcharisk_7(4),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxc_pipe(6)
    );
  BU2_U0_receiver_recoder_rxd_out_18 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxd_half_pipe(18),
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_n0478,
      C => usrclk,
      Q => xgmii_rxd_0(18)
    );
  BU2_U0_receiver_recoder_rxd_out_17 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxd_half_pipe(17),
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_n0478,
      C => usrclk,
      Q => xgmii_rxd_0(17)
    );
  BU2_U0_receiver_recoder_rxd_out_40 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(8),
      R => BU2_U0_receiver_recoder_n0491,
      S => BU2_U0_receiver_recoder_n0549,
      C => usrclk,
      Q => xgmii_rxd_0(40)
    );
  BU2_U0_receiver_recoder_rxd_out_35 : FDS
    port map (
      D => BU2_U0_receiver_recoder_n0492,
      S => BU2_U0_receiver_recoder_n0485,
      C => usrclk,
      Q => xgmii_rxd_0(35)
    );
  BU2_U0_receiver_recoder_rxd_out_41 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(9),
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_n0493,
      C => usrclk,
      Q => xgmii_rxd_0(41)
    );
  BU2_U0_receiver_recoder_rxd_out_36 : FDS
    port map (
      D => BU2_U0_receiver_recoder_n0494,
      S => BU2_U0_receiver_recoder_n0485,
      C => usrclk,
      Q => xgmii_rxd_0(36)
    );
  BU2_U0_receiver_recoder_rxd_out_25 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxd_half_pipe(25),
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_n0483,
      C => usrclk,
      Q => xgmii_rxd_0(25)
    );
  BU2_U0_receiver_recoder_rxd_out_24 : FDS
    port map (
      D => BU2_U0_receiver_recoder_n0480,
      S => BU2_U0_n0010,
      C => usrclk,
      Q => xgmii_rxd_0(24)
    );
  BU2_U0_receiver_recoder_rxd_out_42 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(10),
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_n0493,
      C => usrclk,
      Q => xgmii_rxd_0(42)
    );
  BU2_U0_receiver_recoder_rxd_out_37 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_n0495,
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_error_lane_4_Q,
      C => usrclk,
      Q => xgmii_rxd_0(37)
    );
  BU2_U0_receiver_recoder_rxd_pipe_0 : FDR
    port map (
      D => mgt_rxdata_6(8),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(0)
    );
  BU2_U0_receiver_recoder_rxd_out_21 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_n0475,
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_error_lane_2_Q,
      C => usrclk,
      Q => xgmii_rxd_0(21)
    );
  BU2_U0_receiver_recoder_rxc_pipe_1 : FDR
    port map (
      D => mgt_rxcharisk_7(3),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxc_pipe(1)
    );
  BU2_U0_receiver_recoder_lane_term_pipe_3 : FDR
    port map (
      D => BU2_U0_receiver_recoder_lane_terminate(7),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_lane_term_pipe(3)
    );
  BU2_U0_receiver_recoder_rxd_out_43 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_n0496,
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_error_lane_5_Q,
      C => usrclk,
      Q => xgmii_rxd_0(43)
    );
  BU2_U0_receiver_recoder_rxd_out_38 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_n0497,
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_error_lane_4_Q,
      C => usrclk,
      Q => xgmii_rxd_0(38)
    );
  BU2_U0_receiver_recoder_rxd_pipe_1 : FDR
    port map (
      D => mgt_rxdata_6(9),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(1)
    );
  BU2_U0_receiver_recoder_rxd_out_44 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_n0498,
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_error_lane_5_Q,
      C => usrclk,
      Q => xgmii_rxd_0(44)
    );
  BU2_U0_transmitter_recoder_n0394_SW1 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_2,
      I1 => BU2_U0_transmitter_filter1_txd_out(4),
      O => BU2_N3598
    );
  BU2_U0_receiver_recoder_n04681 : LUT4
    generic map(
      INIT => X"FEFC"
    )
    port map (
      I0 => BU2_CHOICE2201,
      I1 => BU2_N3129,
      I2 => BU2_CHOICE2205,
      I3 => BU2_CHOICE2196,
      O => BU2_U0_receiver_recoder_n0468
    );
  BU2_U0_receiver_recoder_n04691 : LUT2_L
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_n0533,
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(11),
      LO => BU2_U0_receiver_recoder_n0469
    );
  BU2_U0_receiver_recoder_n04701 : LUT2_L
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_n0533,
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(12),
      LO => BU2_U0_receiver_recoder_n0470
    );
  BU2_U0_receiver_recoder_n04751 : LUT4_L
    generic map(
      INIT => X"82AA"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(21),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(22),
      I2 => BU2_U0_receiver_recoder_rxd_half_pipe(23),
      I3 => BU2_CHOICE1690,
      LO => BU2_U0_receiver_recoder_n0475
    );
  BU2_U0_receiver_recoder_n04741 : LUT4_L
    generic map(
      INIT => X"8CCC"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(14),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(15),
      I2 => BU2_U0_receiver_recoder_rxd_half_pipe(13),
      I3 => BU2_CHOICE1730,
      LO => BU2_U0_receiver_recoder_n0474
    );
  BU2_U0_receiver_recoder_n04731 : LUT2_L
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_n0537,
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(20),
      LO => BU2_U0_receiver_recoder_n0473
    );
  BU2_U0_receiver_recoder_n04771 : LUT4_L
    generic map(
      INIT => X"8CCC"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(23),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(22),
      I2 => BU2_U0_receiver_recoder_rxd_half_pipe(21),
      I3 => BU2_CHOICE1690,
      LO => BU2_U0_receiver_recoder_n0477
    );
  BU2_U0_receiver_recoder_n04721 : LUT4_L
    generic map(
      INIT => X"8CCC"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(15),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(14),
      I2 => BU2_U0_receiver_recoder_rxd_half_pipe(13),
      I3 => BU2_CHOICE1730,
      LO => BU2_U0_receiver_recoder_n0472
    );
  BU2_U0_receiver_recoder_n04761 : LUT4
    generic map(
      INIT => X"FFF8"
    )
    port map (
      I0 => BU2_N3676,
      I1 => BU2_CHOICE2173,
      I2 => BU2_CHOICE2183,
      I3 => BU2_N3133,
      O => BU2_U0_receiver_recoder_n0476
    );
  BU2_U0_receiver_recoder_n04791 : LUT4_L
    generic map(
      INIT => X"8CCC"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(22),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(23),
      I2 => BU2_U0_receiver_recoder_rxd_half_pipe(21),
      I3 => BU2_CHOICE1690,
      LO => BU2_U0_receiver_recoder_n0479
    );
  BU2_U0_receiver_recoder_n04781 : LUT4
    generic map(
      INIT => X"FFF8"
    )
    port map (
      I0 => BU2_CHOICE2179,
      I1 => BU2_CHOICE2173,
      I2 => BU2_CHOICE2183,
      I3 => BU2_N3131,
      O => BU2_U0_receiver_recoder_n0478
    );
  BU2_U0_receiver_recoder_n04961 : LUT4_L
    generic map(
      INIT => X"8CCC"
    )
    port map (
      I0 => BU2_N994,
      I1 => BU2_U0_receiver_recoder_rxd_pipe(11),
      I2 => BU2_U0_receiver_recoder_N40,
      I3 => BU2_U0_receiver_recoder_rxc_pipe(1),
      LO => BU2_U0_receiver_recoder_n0496
    );
  BU2_U0_receiver_recoder_n04811 : LUT2_L
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_n0537,
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(19),
      LO => BU2_U0_receiver_recoder_n0481
    );
  BU2_U0_receiver_recoder_n04821 : LUT2_L
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_n0921(1),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(30),
      LO => BU2_U0_receiver_recoder_n0482
    );
  BU2_U0_receiver_recoder_n04831 : LUT4
    generic map(
      INIT => X"FCEE"
    )
    port map (
      I0 => BU2_N3168,
      I1 => BU2_U0_receiver_recoder_n0921(1),
      I2 => BU2_N3169,
      I3 => BU2_U0_receiver_recoder_n0620,
      O => BU2_U0_receiver_recoder_n0483
    );
  BU2_U0_receiver_recoder_n04841 : LUT2_L
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_n0921(1),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(31),
      LO => BU2_U0_receiver_recoder_n0484
    );
  BU2_U0_receiver_recoder_n04851 : LUT4
    generic map(
      INIT => X"FFC8"
    )
    port map (
      I0 => BU2_CHOICE1897,
      I1 => BU2_N3670,
      I2 => BU2_CHOICE1910,
      I3 => BU2_N3436,
      O => BU2_U0_receiver_recoder_n0485
    );
  BU2_U0_receiver_recoder_n04861 : LUT2_L
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_n0921(1),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(27),
      LO => BU2_U0_receiver_recoder_n0486
    );
  BU2_U0_receiver_recoder_n04871 : LUT4
    generic map(
      INIT => X"FFEA"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_pipe(0),
      I1 => BU2_CHOICE1915,
      I2 => BU2_N3516,
      I3 => BU2_U0_receiver_recoder_n0545,
      O => BU2_U0_receiver_recoder_n0487
    );
  BU2_U0_receiver_recoder_n05201 : LUT4
    generic map(
      INIT => X"AA8A"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(4),
      I1 => BU2_N3328,
      I2 => BU2_U0_receiver_recoder_rxd_half_pipe(3),
      I3 => BU2_N3482,
      O => BU2_U0_receiver_recoder_n0520
    );
  BU2_U0_transmitter_recoder_n0392_SW0_SW0 : LUT4
    generic map(
      INIT => X"F35F"
    )
    port map (
      I0 => BU2_U0_transmitter_filter1_txd_out(3),
      I1 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(11),
      I2 => BU2_U0_transmitter_recoder_n04691,
      I3 => BU2_N3701,
      O => BU2_N3452
    );
  BU2_U0_receiver_recoder_n04901 : LUT2_L
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_n0921(1),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(29),
      LO => BU2_U0_receiver_recoder_n0490
    );
  BU2_U0_receiver_recoder_n05091 : LUT4
    generic map(
      INIT => X"EECE"
    )
    port map (
      I0 => BU2_CHOICE2142,
      I1 => BU2_N3432,
      I2 => BU2_U0_receiver_recoder_N38,
      I3 => BU2_N3143,
      O => BU2_U0_receiver_recoder_n0509
    );
  BU2_U0_receiver_recoder_n04921 : LUT2_L
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_n0545,
      I1 => BU2_U0_receiver_recoder_rxd_pipe(3),
      LO => BU2_U0_receiver_recoder_n0492
    );
  BU2_U0_transmitter_filter7_n0007_5_1_SW0 : LUT3_D
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => BU2_CHOICE1742,
      I1 => BU2_CHOICE1735,
      I2 => BU2_U0_transmitter_is_terminate(1),
      LO => BU2_N3653,
      O => BU2_N3344
    );
  BU2_U0_receiver_recoder_n04941 : LUT2_L
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_n0545,
      I1 => BU2_U0_receiver_recoder_rxd_pipe(4),
      LO => BU2_U0_receiver_recoder_n0494
    );
  BU2_U0_receiver_recoder_n04951 : LUT2_L
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_n0545,
      I1 => BU2_U0_receiver_recoder_rxd_pipe(5),
      LO => BU2_U0_receiver_recoder_n0495
    );
  BU2_U0_receiver_recoder_n04981 : LUT4_L
    generic map(
      INIT => X"8CCC"
    )
    port map (
      I0 => BU2_N994,
      I1 => BU2_U0_receiver_recoder_rxd_pipe(12),
      I2 => BU2_U0_receiver_recoder_N40,
      I3 => BU2_U0_receiver_recoder_rxc_pipe(1),
      LO => BU2_U0_receiver_recoder_n0498
    );
  BU2_U0_receiver_recoder_n04971 : LUT2_L
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_n0545,
      I1 => BU2_U0_receiver_recoder_rxd_pipe(6),
      LO => BU2_U0_receiver_recoder_n0497
    );
  BU2_U0_receiver_recoder_n05011 : LUT4_L
    generic map(
      INIT => X"8CCC"
    )
    port map (
      I0 => BU2_N994,
      I1 => BU2_U0_receiver_recoder_rxd_pipe(13),
      I2 => BU2_U0_receiver_recoder_N40,
      I3 => BU2_U0_receiver_recoder_rxc_pipe(1),
      LO => BU2_U0_receiver_recoder_n0501
    );
  BU2_U0_receiver_recoder_n04991 : LUT2_L
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_n0545,
      I1 => BU2_U0_receiver_recoder_rxd_pipe(7),
      LO => BU2_U0_receiver_recoder_n0499
    );
  BU2_U0_transmitter_align_Ker41 : LUT4_D
    generic map(
      INIT => X"30BA"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_1_1,
      I1 => BU2_U0_transmitter_state_machine_state_1_0_1,
      I2 => BU2_U0_transmitter_state_machine_state_1_1_1,
      I3 => BU2_U0_transmitter_state_machine_state_0_0_1,
      LO => BU2_N3652,
      O => BU2_U0_transmitter_align_N4
    );
  BU2_U0_receiver_recoder_n05031 : LUT4_L
    generic map(
      INIT => X"8CCC"
    )
    port map (
      I0 => BU2_N994,
      I1 => BU2_U0_receiver_recoder_rxd_pipe(14),
      I2 => BU2_U0_receiver_recoder_N40,
      I3 => BU2_U0_receiver_recoder_rxc_pipe(1),
      LO => BU2_U0_receiver_recoder_n0503
    );
  BU2_U0_receiver_recoder_n05021 : LUT2_L
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_n0551,
      I1 => BU2_U0_receiver_recoder_rxd_pipe(19),
      LO => BU2_U0_receiver_recoder_n0502
    );
  BU2_U0_receiver_recoder_n05051 : LUT4_L
    generic map(
      INIT => X"8CCC"
    )
    port map (
      I0 => BU2_N994,
      I1 => BU2_U0_receiver_recoder_rxd_pipe(15),
      I2 => BU2_U0_receiver_recoder_N40,
      I3 => BU2_U0_receiver_recoder_rxc_pipe(1),
      LO => BU2_U0_receiver_recoder_n0505
    );
  BU2_U0_receiver_recoder_n05041 : LUT2_L
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_n0551,
      I1 => BU2_U0_receiver_recoder_rxd_pipe(20),
      LO => BU2_U0_receiver_recoder_n0504
    );
  BU2_U0_receiver_recoder_n0947144_SW0 : LUT3
    generic map(
      INIT => X"FB"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_pipe(1),
      I1 => NlwRenamedSig_OI_align_status,
      I2 => BU2_U0_usrclk_reset_1,
      O => BU2_N3434
    );
  BU2_U0_receiver_recoder_n05061 : LUT2_L
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_n0551,
      I1 => BU2_U0_receiver_recoder_rxd_pipe(21),
      LO => BU2_U0_receiver_recoder_n0506
    );
  BU2_U0_receiver_recoder_n05071 : LUT4
    generic map(
      INIT => X"FEFC"
    )
    port map (
      I0 => BU2_N3672,
      I1 => BU2_U0_n00101,
      I2 => BU2_CHOICE2077,
      I3 => BU2_CHOICE2065,
      O => BU2_U0_receiver_recoder_n0507
    );
  BU2_U0_receiver_recoder_n05081 : LUT2_L
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_n0551,
      I1 => BU2_U0_receiver_recoder_rxd_pipe(22),
      LO => BU2_U0_receiver_recoder_n0508
    );
  BU2_U0_receiver_recoder_n05151 : LUT4
    generic map(
      INIT => X"FFEF"
    )
    port map (
      I0 => BU2_U0_usrclk_reset,
      I1 => BU2_U0_receiver_recoder_n0529,
      I2 => NlwRenamedSig_OI_align_status,
      I3 => BU2_U0_receiver_recoder_n0927,
      O => BU2_U0_receiver_recoder_n0515
    );
  BU2_U0_receiver_recoder_n05101 : LUT2_L
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_n0923(1),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(28),
      LO => BU2_U0_receiver_recoder_n0510
    );
  BU2_U0_receiver_recoder_n05111 : LUT2_L
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_n0551,
      I1 => BU2_U0_receiver_recoder_rxd_pipe(23),
      LO => BU2_U0_receiver_recoder_n0511
    );
  BU2_U0_receiver_recoder_n05121 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_n0927,
      I1 => BU2_U0_receiver_recoder_n0529,
      O => BU2_U0_receiver_recoder_n0512
    );
  BU2_U0_receiver_recoder_n05131 : LUT2_L
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_n0923(1),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(29),
      LO => BU2_U0_receiver_recoder_n0513
    );
  BU2_U0_receiver_recoder_n04931 : LUT4
    generic map(
      INIT => X"FF20"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxc_pipe(1),
      I1 => BU2_N3666,
      I2 => BU2_U0_receiver_recoder_N40,
      I3 => BU2_U0_receiver_recoder_error_lane_5_Q,
      O => BU2_U0_receiver_recoder_n0493
    );
  BU2_U0_receiver_recoder_n05161 : LUT2_L
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_n0923(1),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(30),
      LO => BU2_U0_receiver_recoder_n0516
    );
  BU2_U0_receiver_recoder_n05171 : LUT4
    generic map(
      INIT => X"FFA2"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxc_pipe(3),
      I1 => BU2_N3145,
      I2 => BU2_U0_receiver_recoder_n0620,
      I3 => BU2_U0_receiver_recoder_n0923(2),
      O => BU2_U0_receiver_recoder_n0517
    );
  BU2_U0_receiver_recoder_n05181 : LUT2_L
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_n0529,
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(3),
      LO => BU2_U0_receiver_recoder_n0518
    );
  BU2_U0_receiver_recoder_n05191 : LUT2_L
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_n0923(1),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(31),
      LO => BU2_U0_receiver_recoder_n0519
    );
  BU2_U0_transmitter_filter4_n0007_1_1_SW0 : LUT3_D
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => BU2_CHOICE1781,
      I1 => BU2_CHOICE1774,
      I2 => BU2_U0_transmitter_is_terminate(1),
      LO => BU2_N3651,
      O => BU2_N3370
    );
  BU2_U0_receiver_recoder_n05211 : LUT2_L
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_n0923(1),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(27),
      LO => BU2_U0_receiver_recoder_n0521
    );
  BU2_U0_receiver_recoder_n05221 : LUT2_L
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_n0529,
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(5),
      LO => BU2_U0_receiver_recoder_n0522
    );
  BU2_U0_receiver_recoder_n05231 : LUT2_L
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_n0529,
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(6),
      LO => BU2_U0_receiver_recoder_n0523
    );
  BU2_U0_receiver_recoder_n05241 : LUT2_L
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_n0529,
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(7),
      LO => BU2_U0_receiver_recoder_n0524
    );
  BU2_U0_receiver_recoder_n05251 : LUT4
    generic map(
      INIT => X"FEFC"
    )
    port map (
      I0 => BU2_N3681,
      I1 => BU2_N3127,
      I2 => BU2_CHOICE2205,
      I3 => BU2_CHOICE2196,
      O => BU2_U0_receiver_recoder_n0525
    );
  BU2_U0_receiver_recoder_rxd_out_26 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxd_half_pipe(26),
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_n0483,
      C => usrclk,
      Q => xgmii_rxd_0(26)
    );
  BU2_U0_receiver_recoder_rxd_out_31 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_n0484,
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_n0921(2),
      C => usrclk,
      Q => xgmii_rxd_0(31)
    );
  BU2_U0_receiver_recoder_rxc_pipe_7 : FDR
    port map (
      D => mgt_rxcharisk_7(6),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxc_pipe(7)
    );
  BU2_U0_receiver_recoder_n052966 : LUT4
    generic map(
      INIT => X"0008"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(3),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(4),
      I2 => BU2_N3328,
      I3 => BU2_N3691,
      O => BU2_U0_receiver_recoder_n0529
    );
  BU2_U0_receiver_recoder_rxd_out_33 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(1),
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_n0487,
      C => usrclk,
      Q => xgmii_rxd_0(33)
    );
  BU2_U0_receiver_recoder_rxd_out_27 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_n0486,
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_n0921(2),
      C => usrclk,
      Q => xgmii_rxd_0(27)
    );
  BU2_U0_receiver_recoder_rxd_out_32 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(0),
      R => BU2_U0_receiver_recoder_n0485,
      S => BU2_U0_receiver_recoder_n0545,
      C => usrclk,
      Q => xgmii_rxd_0(32)
    );
  BU2_U0_receiver_recoder_n053363 : LUT4
    generic map(
      INIT => X"2900"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(13),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(14),
      I2 => BU2_U0_receiver_recoder_rxd_half_pipe(15),
      I3 => BU2_N3692,
      O => BU2_U0_receiver_recoder_n0533
    );
  BU2_U0_receiver_recoder_code_error_pipe_1 : FDR
    port map (
      D => BU2_U0_receiver_code_error(1),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_code_error_pipe(1)
    );
  BU2_U0_receiver_recoder_code_error_pipe_0 : FDR
    port map (
      D => BU2_N701,
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_code_error_pipe(0)
    );
  BU2_U0_receiver_recoder_rxd_out_28 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_n0488,
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_n0921(2),
      C => usrclk,
      Q => xgmii_rxd_0(28)
    );
  BU2_U0_receiver_recoder_n053766 : LUT4
    generic map(
      INIT => X"2900"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(21),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(22),
      I2 => BU2_U0_receiver_recoder_rxd_half_pipe(23),
      I3 => BU2_N3685,
      O => BU2_U0_receiver_recoder_n0537
    );
  BU2_U0_receiver_recoder_code_error_pipe_3 : FDR
    port map (
      D => BU2_U0_receiver_code_error(3),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_code_error_pipe(3)
    );
  BU2_U0_receiver_recoder_code_error_pipe_2 : FDR
    port map (
      D => BU2_U0_receiver_code_error(2),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_code_error_pipe(2)
    );
  BU2_U0_receiver_recoder_n054066 : LUT4
    generic map(
      INIT => X"0008"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(27),
      I1 => BU2_U0_receiver_recoder_rxd_half_pipe(28),
      I2 => BU2_N3330,
      I3 => BU2_N3697,
      O => BU2_U0_receiver_recoder_n0921(1)
    );
  BU2_U0_receiver_recoder_code_error_pipe_4 : FDR
    port map (
      D => BU2_U0_receiver_code_error(4),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_code_error_pipe(4)
    );
  BU2_U0_receiver_recoder_lane_terminate_1 : FDR
    port map (
      D => BU2_N319,
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_lane_terminate(1)
    );
  BU2_U0_receiver_recoder_lane_terminate_0 : FDR
    port map (
      D => BU2_N243,
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_lane_terminate(0)
    );
  BU2_U0_receiver_recoder_code_error_pipe_6 : FDR
    port map (
      D => BU2_U0_receiver_code_error(6),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_code_error_pipe(6)
    );
  BU2_U0_receiver_recoder_n0545_89 : LUT4
    generic map(
      INIT => X"0004"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(1),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(3),
      I2 => BU2_N996,
      I3 => BU2_N3522,
      O => BU2_U0_receiver_recoder_n0545
    );
  BU2_U0_receiver_recoder_lane_terminate_4 : FDR
    port map (
      D => BU2_N262,
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_lane_terminate(4)
    );
  BU2_U0_receiver_recoder_n04871_SW0 : LUT4_L
    generic map(
      INIT => X"FFF9"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(39),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(38),
      I2 => BU2_CHOICE1909,
      I3 => BU2_CHOICE1897,
      LO => BU2_N3516
    );
  BU2_U0_receiver_recoder_lane_terminate_3 : FDR
    port map (
      D => BU2_N300,
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_lane_terminate(3)
    );
  BU2_U0_receiver_recoder_n0549_90 : LUT3
    generic map(
      INIT => X"20"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxc_pipe(1),
      I1 => BU2_N994,
      I2 => BU2_U0_receiver_recoder_N40,
      O => BU2_U0_receiver_recoder_n0549
    );
  BU2_U0_receiver_recoder_lane_terminate_5 : FDR
    port map (
      D => BU2_N281,
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_lane_terminate(5)
    );
  BU2_U0_receiver_recoder_n0551_91 : LUT4
    generic map(
      INIT => X"0004"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(16),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(18),
      I2 => BU2_N992,
      I3 => BU2_N3520,
      O => BU2_U0_receiver_recoder_n0551
    );
  BU2_U0_receiver_recoder_lane_terminate_6 : FDR
    port map (
      D => BU2_N224,
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_lane_terminate(6)
    );
  BU2_U0_receiver_recoder_n0553_SW1 : LUT4
    generic map(
      INIT => X"FBFF"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_pipe(2),
      I1 => BU2_U0_receiver_recoder_rxc_pipe(2),
      I2 => BU2_N3123,
      I3 => BU2_U0_receiver_recoder_rxd_pipe(23),
      O => BU2_N3155
    );
  BU2_U0_receiver_recoder_rxc_half_pipe_3 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxc_pipe(7),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxc_half_pipe(3)
    );
  BU2_U0_receiver_recoder_lane_term_pipe_2 : FDR
    port map (
      D => BU2_U0_receiver_recoder_lane_terminate(6),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_lane_term_pipe(2)
    );
  BU2_U0_receiver_recoder_lane_term_pipe_1 : FDR
    port map (
      D => BU2_U0_receiver_recoder_lane_terminate(5),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_lane_term_pipe(1)
    );
  BU2_U0_receiver_recoder_n0557 : LUT4
    generic map(
      INIT => X"010F"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(24),
      I1 => BU2_N1096,
      I2 => BU2_N3518,
      I3 => BU2_N3166,
      O => BU2_U0_receiver_recoder_n0923(1)
    );
  BU2_U0_receiver_recoder_rxc_pipe_2 : FDR
    port map (
      D => mgt_rxcharisk_7(5),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxc_pipe(2)
    );
  BU2_U0_receiver_recoder_rxd_pipe_2 : FDS
    port map (
      D => mgt_rxdata_6(10),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(2)
    );
  BU2_U0_receiver_recoder_rxd_out_39 : FDS
    port map (
      D => BU2_U0_receiver_recoder_n0499,
      S => BU2_U0_receiver_recoder_n0485,
      C => usrclk,
      Q => xgmii_rxd_0(39)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_21 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(53),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(21)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_19 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(51),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(19)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_22 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(54),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(22)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_17 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(49),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(17)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_20 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(52),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(20)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_18 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(50),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(18)
    );
  BU2_U0_receiver_recoder_rxd_out_45 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_n0501,
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_error_lane_5_Q,
      C => usrclk,
      Q => xgmii_rxd_0(45)
    );
  BU2_U0_receiver_recoder_rxd_out_22 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_n0477,
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_error_lane_2_Q,
      C => usrclk,
      Q => xgmii_rxd_0(22)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_13 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(45),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(13)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_12 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(44),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(12)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_11 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(43),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(11)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_10 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(42),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(10)
    );
  BU2_U0_receiver_recoder_rxd_out_23 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_n0479,
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_error_lane_2_Q,
      C => usrclk,
      Q => xgmii_rxd_0(23)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_15 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(47),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(15)
    );
  BU2_U0_receiver_recoder_rxd_out_46 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_n0503,
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_error_lane_5_Q,
      C => usrclk,
      Q => xgmii_rxd_0(46)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_14 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(46),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(14)
    );
  BU2_U0_receiver_recoder_rxd_out_51 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_n0502,
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_error_lane_6_Q,
      C => usrclk,
      Q => xgmii_rxd_0(51)
    );
  BU2_U0_receiver_recoder_rxd_out_19 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_n0481,
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_error_lane_2_Q,
      C => usrclk,
      Q => xgmii_rxd_0(19)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_27 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(59),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(27)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_25 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(57),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(25)
    );
  BU2_U0_receiver_recoder_rxd_out_52 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_n0504,
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_error_lane_6_Q,
      C => usrclk,
      Q => xgmii_rxd_0(52)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_16 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(48),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(16)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_23 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(55),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(23)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_26 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(58),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(26)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_24 : FDS
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(56),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(24)
    );
  BU2_U0_receiver_recoder_rxd_pipe_5 : FDR
    port map (
      D => mgt_rxdata_6(13),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(5)
    );
  BU2_U0_receiver_recoder_n05141 : LUT3_L
    generic map(
      INIT => X"32"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(24),
      I1 => BU2_U0_receiver_recoder_n0923(2),
      I2 => BU2_U0_receiver_recoder_n0923(1),
      LO => BU2_U0_receiver_recoder_n0514
    );
  BU2_U0_transmitter_align_n00061 : LUT3
    generic map(
      INIT => X"F2"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_1_1,
      I1 => BU2_U0_transmitter_state_machine_state_1_0,
      I2 => BU2_U0_usrclk_reset,
      O => BU2_U0_transmitter_align_n0006
    );
  BU2_U0_receiver_recoder_n094745 : LUT4
    generic map(
      INIT => X"FFF9"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(46),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(47),
      I2 => BU2_CHOICE2012,
      I3 => BU2_CHOICE2024,
      O => BU2_CHOICE2026
    );
  BU2_U0_receiver_recoder_n093580_SW0 : LUT4_L
    generic map(
      INIT => X"AAEA"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_delay(2),
      I1 => BU2_N3438,
      I2 => BU2_N3159,
      I3 => BU2_N3135,
      LO => BU2_N3131
    );
  BU2_U0_transmitter_filter5_n0007_1_1_SW0 : LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => BU2_CHOICE1768,
      I1 => BU2_CHOICE1761,
      I2 => BU2_N3682,
      O => BU2_N3358
    );
  BU2_U0_receiver_recoder_rxd_out_13 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_n0471,
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_error_lane_1_Q,
      C => usrclk,
      Q => xgmii_rxd_0(13)
    );
  BU2_U0_receiver_recoder_n0947118 : LUT4_D
    generic map(
      INIT => X"AAA8"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_lane_terminate(4),
      I1 => BU2_CHOICE2035,
      I2 => BU2_CHOICE2036,
      I3 => BU2_CHOICE2043,
      LO => BU2_N3650,
      O => BU2_CHOICE2046
    );
  BU2_U0_transmitter_recoder_n0417_SW0 : LUT4_L
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_n0474,
      I1 => BU2_U0_transmitter_filter4_txd_out(3),
      I2 => BU2_U0_transmitter_recoder_n0473,
      I3 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(3),
      LO => BU2_N2802
    );
  BU2_U0_receiver_recoder_rxd_out_14 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_n0472,
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_error_lane_1_Q,
      C => usrclk,
      Q => xgmii_rxd_0(14)
    );
  BU2_U0_transmitter_recoder_n0424_SW0 : LUT4_L
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_n0474,
      I1 => BU2_U0_transmitter_filter5_txd_out(3),
      I2 => BU2_U0_transmitter_recoder_n0473,
      I3 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(11),
      LO => BU2_N2800
    );
  BU2_U0_transmitter_recoder_n0430_SW0 : LUT4_L
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => BU2_U0_transmitter_recoder_n0474,
      I1 => BU2_U0_transmitter_filter6_txd_out(3),
      I2 => BU2_U0_transmitter_recoder_n0473,
      I3 => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(19),
      LO => BU2_N2798
    );
  BU2_U0_receiver_recoder_rxd_out_1 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxd_half_pipe(1),
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_n0512,
      C => usrclk,
      Q => xgmii_rxd_0(1)
    );
  BU2_U0_receiver_recoder_rxd_pipe_8 : FDR
    port map (
      D => mgt_rxdata_6(24),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(8)
    );
  BU2_U0_receiver_recoder_code_error_delay_1 : FDR
    port map (
      D => BU2_U0_receiver_recoder_code_error_pipe(5),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_code_error_delay(1)
    );
  BU2_U0_receiver_recoder_code_error_delay_0 : FDR
    port map (
      D => BU2_U0_receiver_recoder_code_error_pipe(4),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_code_error_delay(0)
    );
  BU2_U0_receiver_recoder_rxd_out_60 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_n0510,
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_n0923(2),
      C => usrclk,
      Q => xgmii_rxd_0(60)
    );
  BU2_U0_receiver_recoder_rxd_out_55 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_n0511,
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_error_lane_6_Q,
      C => usrclk,
      Q => xgmii_rxd_0(55)
    );
  BU2_U0_receiver_recoder_rxd_out_49 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(17),
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_n0500,
      C => usrclk,
      Q => xgmii_rxd_0(49)
    );
  BU2_U0_receiver_recoder_rxd_out_0 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxd_half_pipe(0),
      R => BU2_U0_receiver_recoder_n0509,
      S => BU2_U0_receiver_recoder_n0529,
      C => usrclk,
      Q => xgmii_rxd_0(0)
    );
  BU2_U0_receiver_recoder_rxd_pipe_7 : FDS
    port map (
      D => mgt_rxdata_6(15),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(7)
    );
  BU2_U0_receiver_recoder_rxd_pipe_6 : FDR
    port map (
      D => mgt_rxdata_6(14),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(6)
    );
  BU2_U0_receiver_recoder_rxd_out_54 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_n0508,
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_error_lane_6_Q,
      C => usrclk,
      Q => xgmii_rxd_0(54)
    );
  BU2_U0_receiver_recoder_code_error_pipe_5 : FDR
    port map (
      D => BU2_U0_receiver_code_error(5),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_code_error_pipe(5)
    );
  BU2_U0_receiver_recoder_Ker40 : LUT4
    generic map(
      INIT => X"0008"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(12),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(10),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(9),
      I3 => BU2_N1132,
      O => BU2_U0_receiver_recoder_N40
    );
  BU2_U0_receiver_recoder_n0551_SW1 : LUT4_L
    generic map(
      INIT => X"F7FF"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(20),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(19),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(17),
      I3 => BU2_U0_receiver_recoder_rxc_pipe(2),
      LO => BU2_N3520
    );
  BU2_U0_receiver_recoder_rxd_out_48 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(16),
      R => BU2_U0_receiver_recoder_n0507,
      S => BU2_U0_receiver_recoder_n0551,
      C => usrclk,
      Q => xgmii_rxd_0(48)
    );
  BU2_U0_receiver_recoder_Ker38 : LUT4
    generic map(
      INIT => X"0008"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(4),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(2),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(0),
      I3 => BU2_N1130,
      O => BU2_U0_receiver_recoder_N38
    );
  BU2_U0_receiver_recoder_lane_terminate_2 : FDR
    port map (
      D => BU2_N338,
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_lane_terminate(2)
    );
  BU2_U0_receiver_recoder_rxd_out_10 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxd_half_pipe(10),
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_n0468,
      C => usrclk,
      Q => xgmii_rxd_0(10)
    );
  BU2_U0_receiver_recoder_lane_terminate_7 : FDR
    port map (
      D => BU2_N205,
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_lane_terminate(7)
    );
  BU2_U0_receiver_recoder_Ker39 : LUT4
    generic map(
      INIT => X"0008"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(19),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(20),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(17),
      I3 => BU2_N1128,
      O => BU2_U0_receiver_recoder_N39
    );
  BU2_U0_receiver_recoder_lane_term_pipe_0 : FDR
    port map (
      D => BU2_U0_receiver_recoder_lane_terminate(4),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_lane_term_pipe(0)
    );
  BU2_U0_receiver_recoder_rxd_out_12 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_n0470,
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_error_lane_1_Q,
      C => usrclk,
      Q => xgmii_rxd_0(12)
    );
  BU2_U0_receiver_recoder_n06201 : LUT4_D
    generic map(
      INIT => X"0004"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(25),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(28),
      I2 => BU2_N1126,
      I3 => BU2_N3166,
      LO => BU2_N3649,
      O => BU2_U0_receiver_recoder_n0620
    );
  BU2_U0_receiver_recoder_rxd_out_11 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_n0469,
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_error_lane_1_Q,
      C => usrclk,
      Q => xgmii_rxd_0(11)
    );
  BU2_U0_receiver_recoder_rxd_out_2 : FDS
    port map (
      D => BU2_U0_receiver_recoder_rxd_half_pipe(2),
      S => BU2_U0_receiver_recoder_n0515,
      C => usrclk,
      Q => xgmii_rxd_0(2)
    );
  BU2_U0_transmitter_state_machine_n0069_1_20_SW1 : LUT4_L
    generic map(
      INIT => X"F3F7"
    )
    port map (
      I0 => BU2_U0_transmitter_tqmsg_capture_1_q_det,
      I1 => BU2_CHOICE2155,
      I2 => BU2_U0_transmitter_state_machine_n0003(0),
      I3 => BU2_N1138,
      LO => BU2_N3467
    );
  BU2_U0_receiver_recoder_rxd_pipe_9 : FDR
    port map (
      D => mgt_rxdata_6(25),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(9)
    );
  BU2_U0_receiver_recoder_code_error_delay_2 : FDR
    port map (
      D => BU2_U0_receiver_recoder_code_error_pipe(6),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_code_error_delay(2)
    );
  BU2_U0_receiver_recoder_rxd_out_56 : FDS
    port map (
      D => BU2_U0_receiver_recoder_n0514,
      S => BU2_U0_n0010,
      C => usrclk,
      Q => xgmii_rxd_0(56)
    );
  BU2_U0_receiver_recoder_n062719 : LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(52),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(53),
      I2 => BU2_CHOICE2001,
      I3 => BU2_CHOICE2007,
      O => BU2_U0_receiver_recoder_n0627
    );
  BU2_U0_receiver_recoder_rxd_out_47 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_n0505,
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_error_lane_5_Q,
      C => usrclk,
      Q => xgmii_rxd_0(47)
    );
  BU2_U0_receiver_recoder_rxd_out_61 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_n0513,
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_n0923(2),
      C => usrclk,
      Q => xgmii_rxd_0(61)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_0 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(32),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(0)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_1 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(33),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(1)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_2 : FDS
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(34),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(2)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_3 : FDS
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(35),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(3)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_5 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(37),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(5)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_6 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(38),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(6)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_8 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(40),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(8)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_9 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(41),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(9)
    );
  BU2_U0_receiver_recoder_rxc_half_pipe_2 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxc_pipe(6),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxc_half_pipe(2)
    );
  BU2_U0_receiver_recoder_rxd_out_50 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(18),
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_n0500,
      C => usrclk,
      Q => xgmii_rxd_0(50)
    );
  BU2_U0_receiver_recoder_rxd_out_16 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxd_half_pipe(16),
      R => BU2_U0_receiver_recoder_n0476,
      S => BU2_U0_receiver_recoder_n0537,
      C => usrclk,
      Q => xgmii_rxd_0(16)
    );
  BU2_U0_receiver_recoder_rxd_out_20 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_n0473,
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_error_lane_2_Q,
      C => usrclk,
      Q => xgmii_rxd_0(20)
    );
  BU2_U0_receiver_recoder_rxc_pipe_0 : FDS
    port map (
      D => mgt_rxcharisk_7(1),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxc_pipe(0)
    );
  BU2_U0_receiver_recoder_rxd_pipe_3 : FDS
    port map (
      D => mgt_rxdata_6(11),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(3)
    );
  BU2_U0_receiver_recoder_rxc_half_pipe_0 : FDS
    port map (
      D => BU2_U0_receiver_recoder_rxc_pipe(4),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxc_half_pipe(0)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_31 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(63),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(31)
    );
  BU2_U0_receiver_recoder_rxd_pipe_4 : FDS
    port map (
      D => mgt_rxdata_6(12),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(4)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_30 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(62),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(30)
    );
  BU2_U0_receiver_recoder_rxc_pipe_5 : FDR
    port map (
      D => mgt_rxcharisk_7(2),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxc_pipe(5)
    );
  BU2_U0_receiver_recoder_rxc_pipe_4 : FDS
    port map (
      D => mgt_rxcharisk_7(0),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxc_pipe(4)
    );
  BU2_U0_receiver_recoder_rxd_out_53 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_n0506,
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_error_lane_6_Q,
      C => usrclk,
      Q => xgmii_rxd_0(53)
    );
  BU2_U0_receiver_recoder_rxd_out_30 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_n0482,
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_n0921(2),
      C => usrclk,
      Q => xgmii_rxd_0(30)
    );
  BU2_U0_receiver_recoder_rxd_out_57 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(25),
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_n0517,
      C => usrclk,
      Q => xgmii_rxd_0(57)
    );
  BU2_U0_receiver_recoder_rxd_out_3 : FDS
    port map (
      D => BU2_U0_receiver_recoder_n0518,
      S => BU2_U0_receiver_recoder_n0509,
      C => usrclk,
      Q => xgmii_rxd_0(3)
    );
  BU2_U0_receiver_recoder_code_error_delay_3 : FDR
    port map (
      D => BU2_U0_receiver_recoder_code_error_pipe(7),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_code_error_delay(3)
    );
  BU2_U0_receiver_recoder_rxd_out_63 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_n0519,
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_n0923(2),
      C => usrclk,
      Q => xgmii_rxd_0(63)
    );
  BU2_U0_receiver_recoder_rxd_out_58 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(26),
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_n0517,
      C => usrclk,
      Q => xgmii_rxd_0(58)
    );
  BU2_U0_receiver_recoder_rxd_out_4 : FDS
    port map (
      D => BU2_U0_receiver_recoder_n0520,
      S => BU2_U0_receiver_recoder_n0509,
      C => usrclk,
      Q => xgmii_rxd_0(4)
    );
  BU2_U0_receiver_recoder_rxd_out_59 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_n0521,
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_n0923(2),
      C => usrclk,
      Q => xgmii_rxd_0(59)
    );
  BU2_U0_receiver_recoder_rxd_out_5 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_n0522,
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_n0927,
      C => usrclk,
      Q => xgmii_rxd_0(5)
    );
  BU2_U0_receiver_recoder_rxd_out_6 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_n0523,
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_n0927,
      C => usrclk,
      Q => xgmii_rxd_0(6)
    );
  BU2_U0_receiver_recoder_rxd_out_7 : FDS
    port map (
      D => BU2_U0_receiver_recoder_n0524,
      S => BU2_U0_receiver_recoder_n0509,
      C => usrclk,
      Q => xgmii_rxd_0(7)
    );
  BU2_U0_receiver_recoder_rxd_out_8 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxd_half_pipe(8),
      R => BU2_U0_receiver_recoder_n0525,
      S => BU2_U0_receiver_recoder_n0533,
      C => usrclk,
      Q => xgmii_rxd_0(8)
    );
  BU2_U0_receiver_recoder_rxd_out_9 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxd_half_pipe(9),
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_n0468,
      C => usrclk,
      Q => xgmii_rxd_0(9)
    );
  BU2_U0_receiver_recoder_rxc_out_0 : FDS
    port map (
      D => BU2_U0_receiver_recoder_rxc_half_pipe(0),
      S => BU2_U0_receiver_recoder_n0515,
      C => usrclk,
      Q => xgmii_rxc_1(0)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_4 : FDS
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(36),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(4)
    );
  BU2_U0_receiver_recoder_rxc_out_1 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxc_half_pipe(1),
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_n0468,
      C => usrclk,
      Q => xgmii_rxc_1(1)
    );
  BU2_U0_receiver_recoder_rxc_out_2 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxc_half_pipe(2),
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_n0478,
      C => usrclk,
      Q => xgmii_rxc_1(2)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_7 : FDS
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(39),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(7)
    );
  BU2_U0_receiver_recoder_rxc_out_3 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxc_half_pipe(3),
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_n0483,
      C => usrclk,
      Q => xgmii_rxc_1(3)
    );
  BU2_U0_receiver_recoder_rxd_pipe_10 : FDR
    port map (
      D => mgt_rxdata_6(26),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(10)
    );
  BU2_U0_receiver_recoder_rxc_out_4 : FDS
    port map (
      D => BU2_U0_receiver_recoder_rxc_pipe(0),
      S => BU2_U0_receiver_recoder_n0489,
      C => usrclk,
      Q => xgmii_rxc_1(4)
    );
  BU2_U0_receiver_recoder_n092785 : LUT4
    generic map(
      INIT => X"EEAE"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_delay(0),
      I1 => BU2_CHOICE2142,
      I2 => BU2_U0_receiver_recoder_N38,
      I3 => BU2_N3677,
      O => BU2_U0_receiver_recoder_n0927
    );
  BU2_U0_receiver_recoder_n093176 : LUT4
    generic map(
      INIT => X"FFEA"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_delay(1),
      I1 => BU2_CHOICE2196,
      I2 => BU2_CHOICE2201,
      I3 => BU2_N3657,
      O => BU2_U0_receiver_recoder_error_lane_1_Q
    );
  BU2_U0_receiver_recoder_rxd_pipe_11 : FDR
    port map (
      D => mgt_rxdata_6(27),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(11)
    );
  BU2_U0_receiver_recoder_rxc_out_5 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxc_pipe(1),
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_n0493,
      C => usrclk,
      Q => xgmii_rxc_1(5)
    );
  BU2_U0_receiver_recoder_rxd_pipe_12 : FDR
    port map (
      D => mgt_rxdata_6(28),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(12)
    );
  BU2_U0_receiver_recoder_n093580 : LUT4
    generic map(
      INIT => X"FFEA"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_delay(2),
      I1 => BU2_CHOICE2173,
      I2 => BU2_CHOICE2179,
      I3 => BU2_N3671,
      O => BU2_U0_receiver_recoder_error_lane_2_Q
    );
  BU2_U0_receiver_recoder_rxc_out_6 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxc_pipe(2),
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_n0500,
      C => usrclk,
      Q => xgmii_rxc_1(6)
    );
  BU2_U0_receiver_recoder_rxd_pipe_13 : FDR
    port map (
      D => mgt_rxdata_6(29),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(13)
    );
  BU2_U0_receiver_recoder_code_error_pipe_7 : FDR
    port map (
      D => BU2_U0_receiver_code_error(7),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_code_error_pipe(7)
    );
  BU2_U0_receiver_recoder_rxc_out_7 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_rxc_pipe(3),
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_n0517,
      C => usrclk,
      Q => xgmii_rxc_1(7)
    );
  BU2_U0_receiver_recoder_rxd_pipe_14 : FDR
    port map (
      D => mgt_rxdata_6(30),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(14)
    );
  BU2_U0_receiver_recoder_rxd_pipe_20 : FDR
    port map (
      D => mgt_rxdata_6(44),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(20)
    );
  BU2_U0_receiver_recoder_rxd_pipe_15 : FDR
    port map (
      D => mgt_rxdata_6(31),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(15)
    );
  BU2_U0_receiver_recoder_rxd_pipe_21 : FDR
    port map (
      D => mgt_rxdata_6(45),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(21)
    );
  BU2_U0_receiver_recoder_rxd_pipe_16 : FDR
    port map (
      D => mgt_rxdata_6(40),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(16)
    );
  BU2_U0_receiver_recoder_rxd_pipe_22 : FDR
    port map (
      D => mgt_rxdata_6(46),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(22)
    );
  BU2_U0_receiver_recoder_rxd_pipe_17 : FDR
    port map (
      D => mgt_rxdata_6(41),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(17)
    );
  BU2_U0_receiver_recoder_rxd_pipe_23 : FDR
    port map (
      D => mgt_rxdata_6(47),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(23)
    );
  BU2_U0_receiver_recoder_rxd_pipe_18 : FDR
    port map (
      D => mgt_rxdata_6(42),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(18)
    );
  BU2_U0_receiver_recoder_rxd_pipe_24 : FDS
    port map (
      D => mgt_rxdata_6(56),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(24)
    );
  BU2_U0_receiver_recoder_rxd_pipe_19 : FDR
    port map (
      D => mgt_rxdata_6(43),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(19)
    );
  BU2_U0_receiver_recoder_n093921 : LUT4
    generic map(
      INIT => X"EFAA"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_code_error_delay(3),
      I1 => BU2_CHOICE2111,
      I2 => BU2_N3649,
      I3 => BU2_CHOICE2108,
      O => BU2_U0_receiver_recoder_n0921(2)
    );
  BU2_U0_receiver_recoder_n094379 : LUT4_D
    generic map(
      INIT => X"FCF8"
    )
    port map (
      I0 => BU2_CHOICE1897,
      I1 => BU2_CHOICE1915,
      I2 => BU2_U0_receiver_recoder_code_error_pipe(0),
      I3 => BU2_CHOICE1910,
      LO => BU2_N3648,
      O => BU2_U0_receiver_recoder_error_lane_4_Q
    );
  BU2_U0_receiver_recoder_rxd_out_62 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_n0516,
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_n0923(2),
      C => usrclk,
      Q => xgmii_rxd_0(62)
    );
  BU2_U0_transmitter_recoder_n0400_92 : LUT4_L
    generic map(
      INIT => X"5F9B"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_state_0_0,
      I1 => BU2_U0_transmitter_state_machine_state_0_2,
      I2 => BU2_N1807,
      I3 => BU2_U0_transmitter_state_machine_state_0_1,
      LO => BU2_U0_transmitter_recoder_n0400
    );
  BU2_U0_receiver_recoder_n095561 : LUT4
    generic map(
      INIT => X"FCF8"
    )
    port map (
      I0 => BU2_CHOICE1881,
      I1 => BU2_CHOICE1876,
      I2 => BU2_U0_receiver_recoder_code_error_pipe(3),
      I3 => BU2_CHOICE1890,
      O => BU2_U0_receiver_recoder_n0923(2)
    );
  BU2_U0_receiver_recoder_rxd_pipe_30 : FDR
    port map (
      D => mgt_rxdata_6(62),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(30)
    );
  BU2_U0_receiver_recoder_rxd_pipe_25 : FDR
    port map (
      D => mgt_rxdata_6(57),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(25)
    );
  BU2_U0_receiver_recoder_rxd_pipe_31 : FDR
    port map (
      D => mgt_rxdata_6(63),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(31)
    );
  BU2_U0_receiver_recoder_rxc_pipe_3 : FDR
    port map (
      D => mgt_rxcharisk_7(7),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxc_pipe(3)
    );
  BU2_U0_receiver_recoder_rxd_pipe_26 : FDR
    port map (
      D => mgt_rxdata_6(58),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(26)
    );
  BU2_U0_receiver_recoder_rxd_pipe_32 : FDR
    port map (
      D => mgt_rxdata_6(0),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(32)
    );
  BU2_U0_receiver_recoder_rxd_pipe_27 : FDR
    port map (
      D => mgt_rxdata_6(59),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(27)
    );
  BU2_U0_receiver_recoder_rxd_pipe_33 : FDR
    port map (
      D => mgt_rxdata_6(1),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(33)
    );
  BU2_U0_receiver_recoder_rxd_pipe_28 : FDR
    port map (
      D => mgt_rxdata_6(60),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(28)
    );
  BU2_U0_receiver_recoder_rxd_pipe_34 : FDS
    port map (
      D => mgt_rxdata_6(2),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(34)
    );
  BU2_U0_receiver_recoder_rxd_pipe_29 : FDR
    port map (
      D => mgt_rxdata_6(61),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(29)
    );
  BU2_U0_receiver_recoder_rxd_pipe_40 : FDR
    port map (
      D => mgt_rxdata_6(16),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(40)
    );
  BU2_U0_receiver_recoder_rxd_pipe_35 : FDS
    port map (
      D => mgt_rxdata_6(3),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(35)
    );
  BU2_U0_receiver_recoder_rxd_pipe_41 : FDR
    port map (
      D => mgt_rxdata_6(17),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(41)
    );
  BU2_U0_receiver_recoder_rxd_pipe_36 : FDS
    port map (
      D => mgt_rxdata_6(4),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(36)
    );
  BU2_U0_receiver_recoder_rxd_pipe_42 : FDR
    port map (
      D => mgt_rxdata_6(18),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(42)
    );
  BU2_U0_receiver_recoder_rxd_pipe_37 : FDR
    port map (
      D => mgt_rxdata_6(5),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(37)
    );
  BU2_U0_receiver_recoder_rxd_pipe_43 : FDR
    port map (
      D => mgt_rxdata_6(19),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(43)
    );
  BU2_U0_receiver_recoder_rxd_pipe_38 : FDR
    port map (
      D => mgt_rxdata_6(6),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(38)
    );
  BU2_U0_receiver_recoder_rxc_half_pipe_1 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxc_pipe(5),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxc_half_pipe(1)
    );
  BU2_U0_receiver_recoder_rxd_pipe_44 : FDR
    port map (
      D => mgt_rxdata_6(20),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(44)
    );
  BU2_U0_receiver_recoder_rxd_pipe_39 : FDS
    port map (
      D => mgt_rxdata_6(7),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(39)
    );
  BU2_U0_receiver_recoder_rxd_pipe_50 : FDR
    port map (
      D => mgt_rxdata_6(34),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(50)
    );
  BU2_U0_receiver_recoder_rxd_pipe_45 : FDR
    port map (
      D => mgt_rxdata_6(21),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(45)
    );
  BU2_U0_receiver_recoder_rxd_pipe_51 : FDR
    port map (
      D => mgt_rxdata_6(35),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(51)
    );
  BU2_U0_receiver_recoder_rxd_pipe_46 : FDR
    port map (
      D => mgt_rxdata_6(22),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(46)
    );
  BU2_U0_receiver_recoder_rxd_pipe_52 : FDR
    port map (
      D => mgt_rxdata_6(36),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(52)
    );
  BU2_U0_receiver_recoder_rxd_pipe_47 : FDR
    port map (
      D => mgt_rxdata_6(23),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(47)
    );
  BU2_U0_receiver_recoder_rxd_pipe_53 : FDR
    port map (
      D => mgt_rxdata_6(37),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(53)
    );
  BU2_U0_receiver_recoder_rxd_pipe_48 : FDR
    port map (
      D => mgt_rxdata_6(32),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(48)
    );
  BU2_U0_receiver_recoder_rxd_pipe_54 : FDR
    port map (
      D => mgt_rxdata_6(38),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(54)
    );
  BU2_U0_receiver_recoder_rxd_pipe_49 : FDR
    port map (
      D => mgt_rxdata_6(33),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(49)
    );
  BU2_U0_receiver_recoder_rxd_pipe_60 : FDR
    port map (
      D => mgt_rxdata_6(52),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(60)
    );
  BU2_U0_receiver_recoder_rxd_pipe_55 : FDR
    port map (
      D => mgt_rxdata_6(39),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(55)
    );
  BU2_U0_receiver_recoder_rxd_pipe_61 : FDR
    port map (
      D => mgt_rxdata_6(53),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(61)
    );
  BU2_U0_receiver_recoder_rxd_pipe_56 : FDS
    port map (
      D => mgt_rxdata_6(48),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(56)
    );
  BU2_U0_receiver_recoder_rxd_pipe_62 : FDR
    port map (
      D => mgt_rxdata_6(54),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(62)
    );
  BU2_U0_receiver_recoder_rxd_pipe_57 : FDR
    port map (
      D => mgt_rxdata_6(49),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(57)
    );
  BU2_U0_receiver_recoder_rxd_pipe_63 : FDR
    port map (
      D => mgt_rxdata_6(55),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(63)
    );
  BU2_U0_receiver_recoder_rxd_pipe_58 : FDR
    port map (
      D => mgt_rxdata_6(50),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(58)
    );
  BU2_U0_receiver_recoder_rxd_pipe_59 : FDR
    port map (
      D => mgt_rxdata_6(51),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_pipe(59)
    );
  BU2_U0_receiver_recoder_rxd_half_pipe_28 : FDR
    port map (
      D => BU2_U0_receiver_recoder_rxd_pipe(60),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_recoder_rxd_half_pipe(28)
    );
  BU2_U0_receiver_recoder_n04801 : LUT3_L
    generic map(
      INIT => X"0E"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_half_pipe(24),
      I1 => BU2_U0_receiver_recoder_n0921(1),
      I2 => BU2_U0_receiver_recoder_n0921(2),
      LO => BU2_U0_receiver_recoder_n0480
    );
  BU2_U0_receiver_recoder_n0557_SW2 : LUT4_L
    generic map(
      INIT => X"FFDF"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(28),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(25),
      I2 => BU2_U0_receiver_recoder_rxc_pipe(3),
      I3 => BU2_N1126,
      LO => BU2_N3518
    );
  BU2_U0_transmitter_txd_pipe_37 : FDR
    port map (
      D => xgmii_txd_4(37),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(37)
    );
  BU2_U0_transmitter_txd_pipe_42 : FDS
    port map (
      D => xgmii_txd_4(42),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(42)
    );
  BU2_U0_transmitter_txd_pipe_36 : FDR
    port map (
      D => xgmii_txd_4(36),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(36)
    );
  BU2_U0_transmitter_txd_pipe_41 : FDS
    port map (
      D => xgmii_txd_4(41),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(41)
    );
  BU2_U0_transmitter_txd_pipe_35 : FDR
    port map (
      D => xgmii_txd_4(35),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(35)
    );
  BU2_U0_transmitter_txd_pipe_40 : FDS
    port map (
      D => xgmii_txd_4(40),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(40)
    );
  BU2_U0_transmitter_txd_pipe_29 : FDR
    port map (
      D => xgmii_txd_4(29),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(29)
    );
  BU2_U0_transmitter_txd_pipe_34 : FDS
    port map (
      D => xgmii_txd_4(34),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(34)
    );
  BU2_U0_transmitter_txd_pipe_28 : FDR
    port map (
      D => xgmii_txd_4(28),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(28)
    );
  BU2_U0_transmitter_txd_pipe_33 : FDS
    port map (
      D => xgmii_txd_4(33),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(33)
    );
  BU2_U0_transmitter_txd_pipe_27 : FDR
    port map (
      D => xgmii_txd_4(27),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(27)
    );
  BU2_U0_transmitter_txd_pipe_32 : FDS
    port map (
      D => xgmii_txd_4(32),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(32)
    );
  BU2_U0_transmitter_txd_pipe_31 : FDR
    port map (
      D => xgmii_txd_4(31),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(31)
    );
  BU2_U0_transmitter_txd_pipe_26 : FDS
    port map (
      D => xgmii_txd_4(26),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(26)
    );
  BU2_U0_transmitter_txc_pipe_7 : FDS
    port map (
      D => xgmii_txc_5(7),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txc_pipe(7)
    );
  BU2_U0_transmitter_txd_pipe_30 : FDR
    port map (
      D => xgmii_txd_4(30),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(30)
    );
  BU2_U0_transmitter_txd_pipe_25 : FDS
    port map (
      D => xgmii_txd_4(25),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(25)
    );
  BU2_U0_transmitter_txd_pipe_19 : FDR
    port map (
      D => xgmii_txd_4(19),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(19)
    );
  BU2_U0_transmitter_txd_pipe_24 : FDS
    port map (
      D => xgmii_txd_4(24),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(24)
    );
  BU2_U0_transmitter_txd_pipe_23 : FDR
    port map (
      D => xgmii_txd_4(23),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(23)
    );
  BU2_U0_transmitter_txd_pipe_18 : FDS
    port map (
      D => xgmii_txd_4(18),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(18)
    );
  BU2_U0_transmitter_txd_pipe_22 : FDR
    port map (
      D => xgmii_txd_4(22),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(22)
    );
  BU2_U0_transmitter_txd_pipe_17 : FDS
    port map (
      D => xgmii_txd_4(17),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(17)
    );
  BU2_U0_transmitter_txd_pipe_21 : FDR
    port map (
      D => xgmii_txd_4(21),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(21)
    );
  BU2_U0_transmitter_txd_pipe_16 : FDS
    port map (
      D => xgmii_txd_4(16),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(16)
    );
  BU2_U0_transmitter_txd_pipe_15 : FDR
    port map (
      D => xgmii_txd_4(15),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(15)
    );
  BU2_U0_transmitter_txd_pipe_20 : FDR
    port map (
      D => xgmii_txd_4(20),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(20)
    );
  BU2_U0_transmitter_txd_pipe_14 : FDR
    port map (
      D => xgmii_txd_4(14),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(14)
    );
  BU2_U0_transmitter_filter7_txc_out_93 : FDS
    port map (
      D => BU2_U0_transmitter_txc_pipe(7),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter7_txc_out
    );
  BU2_U0_transmitter_filter6_txc_out_94 : FDS
    port map (
      D => BU2_U0_transmitter_txc_pipe(6),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter6_txc_out
    );
  BU2_U0_transmitter_filter5_txc_out_95 : FDS
    port map (
      D => BU2_U0_transmitter_txc_pipe(5),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter5_txc_out
    );
  BU2_U0_transmitter_filter4_txc_out_96 : FDS
    port map (
      D => BU2_U0_transmitter_txc_pipe(4),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter4_txc_out
    );
  BU2_U0_transmitter_filter3_txc_out_97 : FDS
    port map (
      D => BU2_U0_transmitter_txc_pipe(3),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter3_txc_out
    );
  BU2_U0_transmitter_filter2_txc_out_98 : FDS
    port map (
      D => BU2_U0_transmitter_txc_pipe(2),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter2_txc_out
    );
  BU2_U0_transmitter_filter1_txc_out_99 : FDS
    port map (
      D => BU2_U0_transmitter_txc_pipe(1),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter1_txc_out
    );
  BU2_U0_transmitter_filter0_txc_out_100 : FDS
    port map (
      D => BU2_U0_transmitter_txc_pipe(0),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_filter0_txc_out
    );
  BU2_U0_transmitter_state_machine_n00112 : LUT4
    generic map(
      INIT => X"AA8A"
    )
    port map (
      I0 => BU2_U0_transmitter_state_machine_N4,
      I1 => BU2_U0_transmitter_state_machine_state_0_0,
      I2 => BU2_U0_transmitter_state_machine_state_0_1,
      I3 => BU2_U0_transmitter_state_machine_state_0_2,
      O => BU2_U0_transmitter_state_machine_n0011
    );
  BU2_U0_transmitter_k_r_prbs_i_prbs_5 : FDS
    port map (
      D => BU2_U0_transmitter_k_r_prbs_i_prbs(3),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_k_r_prbs_i_prbs(5)
    );
  BU2_U0_transmitter_align_n0003_3_Q : LUT4
    generic map(
      INIT => X"BE14"
    )
    port map (
      I0 => BU2_U0_transmitter_align_N4,
      I1 => BU2_U0_transmitter_align_count(3),
      I2 => BU2_N922,
      I3 => BU2_U0_transmitter_align_prbs(4),
      O => BU2_U0_transmitter_align_n0003(3)
    );
  BU2_U0_transmitter_filter3_n0007_0_1_SW0 : LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => BU2_CHOICE1794,
      I1 => BU2_CHOICE1787,
      I2 => BU2_N3669,
      O => BU2_N3390
    );
  BU2_U0_transmitter_tqmsg_capture_1_last_qmsg_22 : FDRE
    port map (
      D => BU2_U0_transmitter_tqmsg_capture_1_n0004(22),
      R => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_tqmsg_capture_1_n0013601,
      C => usrclk,
      Q => BU2_U0_transmitter_tqmsg_capture_1_last_qmsg(22)
    );
  BU2_U0_transmitter_seq_detect_i1_muxcy_i1 : MUXCY_L
    port map (
      CI => BU2_U0_transmitter_seq_detect_i1_n0003,
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_seq_detect_i1_comp(1),
      LO => BU2_U0_transmitter_seq_detect_i1_muxcyo(1)
    );
  BU2_U0_transmitter_seq_detect_i0_muxcy_i1 : MUXCY_L
    port map (
      CI => BU2_U0_transmitter_seq_detect_i0_n0003,
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_seq_detect_i0_comp(1),
      LO => BU2_U0_transmitter_seq_detect_i0_muxcyo(1)
    );
  BU2_U0_transmitter_idle_detect_i1_muxcy_i6 : MUXCY_L
    port map (
      CI => BU2_U0_transmitter_idle_detect_i1_muxcyo(5),
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_idle_detect_i1_comp(6),
      LO => BU2_U0_transmitter_idle_detect_i1_muxcyo(6)
    );
  BU2_U0_transmitter_idle_detect_i0_muxcy_i6 : MUXCY_L
    port map (
      CI => BU2_U0_transmitter_idle_detect_i0_muxcyo(5),
      DI => BU2_mdio_tri,
      S => BU2_U0_transmitter_idle_detect_i0_comp(6),
      LO => BU2_U0_transmitter_idle_detect_i0_muxcyo(6)
    );
  BU2_U0_transmitter_txd_pipe_48 : FDS
    port map (
      D => xgmii_txd_4(48),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(48)
    );
  BU2_U0_transmitter_txd_pipe_59 : FDR
    port map (
      D => xgmii_txd_4(59),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(59)
    );
  BU2_U0_transmitter_txd_pipe_0 : FDS
    port map (
      D => xgmii_txd_4(0),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(0)
    );
  BU2_U0_transmitter_txd_pipe_1 : FDS
    port map (
      D => xgmii_txd_4(1),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(1)
    );
  BU2_U0_transmitter_txd_pipe_2 : FDS
    port map (
      D => xgmii_txd_4(2),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(2)
    );
  BU2_U0_transmitter_txd_pipe_3 : FDR
    port map (
      D => xgmii_txd_4(3),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(3)
    );
  BU2_U0_transmitter_txd_pipe_4 : FDR
    port map (
      D => xgmii_txd_4(4),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(4)
    );
  BU2_U0_transmitter_tx_is_q_1 : FDR
    port map (
      D => BU2_U0_transmitter_tx_is_q_comb(1),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_tx_is_q(1)
    );
  BU2_U0_transmitter_txd_pipe_5 : FDR
    port map (
      D => xgmii_txd_4(5),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(5)
    );
  BU2_U0_transmitter_txd_pipe_53 : FDR
    port map (
      D => xgmii_txd_4(53),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(53)
    );
  BU2_U0_transmitter_txd_pipe_49 : FDS
    port map (
      D => xgmii_txd_4(49),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(49)
    );
  BU2_U0_transmitter_txd_pipe_54 : FDR
    port map (
      D => xgmii_txd_4(54),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(54)
    );
  BU2_U0_transmitter_tx_is_idle_1 : FDS
    port map (
      D => BU2_U0_transmitter_tx_is_idle_comb(1),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_tx_is_idle(1)
    );
  BU2_U0_transmitter_txd_pipe_60 : FDR
    port map (
      D => xgmii_txd_4(60),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(60)
    );
  BU2_U0_transmitter_txd_pipe_55 : FDR
    port map (
      D => xgmii_txd_4(55),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(55)
    );
  BU2_U0_transmitter_txd_pipe_56 : FDS
    port map (
      D => xgmii_txd_4(56),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(56)
    );
  BU2_U0_transmitter_txd_pipe_61 : FDR
    port map (
      D => xgmii_txd_4(61),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(61)
    );
  BU2_U0_transmitter_txd_pipe_57 : FDS
    port map (
      D => xgmii_txd_4(57),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(57)
    );
  BU2_U0_transmitter_txd_pipe_62 : FDR
    port map (
      D => xgmii_txd_4(62),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(62)
    );
  BU2_U0_transmitter_txd_pipe_58 : FDS
    port map (
      D => xgmii_txd_4(58),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(58)
    );
  BU2_U0_transmitter_txd_pipe_63 : FDR
    port map (
      D => xgmii_txd_4(63),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(63)
    );
  BU2_U0_transmitter_txd_pipe_38 : FDR
    port map (
      D => xgmii_txd_4(38),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(38)
    );
  BU2_U0_transmitter_txd_pipe_44 : FDR
    port map (
      D => xgmii_txd_4(44),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(44)
    );
  BU2_U0_transmitter_txd_pipe_39 : FDR
    port map (
      D => xgmii_txd_4(39),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(39)
    );
  BU2_U0_transmitter_tx_is_idle_0 : FDS
    port map (
      D => BU2_U0_transmitter_n0095,
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_tx_is_idle(0)
    );
  BU2_U0_transmitter_txd_pipe_47 : FDR
    port map (
      D => xgmii_txd_4(47),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(47)
    );
  BU2_U0_transmitter_txd_pipe_51 : FDR
    port map (
      D => xgmii_txd_4(51),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(51)
    );
  BU2_U0_transmitter_txd_pipe_52 : FDR
    port map (
      D => xgmii_txd_4(52),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(52)
    );
  BU2_U0_transmitter_txd_pipe_45 : FDR
    port map (
      D => xgmii_txd_4(45),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(45)
    );
  BU2_U0_transmitter_txd_pipe_46 : FDR
    port map (
      D => xgmii_txd_4(46),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(46)
    );
  BU2_U0_transmitter_txd_pipe_50 : FDS
    port map (
      D => xgmii_txd_4(50),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(50)
    );
  BU2_U0_transmitter_tx_is_q_0 : FDR
    port map (
      D => BU2_U0_transmitter_n0099,
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_tx_is_q(0)
    );
  BU2_U0_transmitter_txc_pipe_0 : FDS
    port map (
      D => xgmii_txc_5(0),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txc_pipe(0)
    );
  BU2_U0_transmitter_txc_pipe_1 : FDS
    port map (
      D => xgmii_txc_5(1),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txc_pipe(1)
    );
  BU2_U0_transmitter_txc_pipe_2 : FDS
    port map (
      D => xgmii_txc_5(2),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txc_pipe(2)
    );
  BU2_U0_transmitter_txc_pipe_3 : FDS
    port map (
      D => xgmii_txc_5(3),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txc_pipe(3)
    );
  BU2_U0_transmitter_txc_pipe_4 : FDS
    port map (
      D => xgmii_txc_5(4),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txc_pipe(4)
    );
  BU2_U0_transmitter_txc_pipe_5 : FDS
    port map (
      D => xgmii_txc_5(5),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txc_pipe(5)
    );
  BU2_U0_transmitter_txc_pipe_6 : FDS
    port map (
      D => xgmii_txc_5(6),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txc_pipe(6)
    );
  BU2_U0_transmitter_n02644 : LUT4_L
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(48),
      I1 => BU2_U0_transmitter_txd_pipe(51),
      I2 => BU2_U0_transmitter_txd_pipe(52),
      I3 => BU2_U0_transmitter_txd_pipe(50),
      LO => BU2_CHOICE1920
    );
  BU2_U0_transmitter_txd_pipe_6 : FDR
    port map (
      D => xgmii_txd_4(6),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(6)
    );
  BU2_U0_transmitter_txd_pipe_7 : FDR
    port map (
      D => xgmii_txd_4(7),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(7)
    );
  BU2_U0_transmitter_txd_pipe_8 : FDS
    port map (
      D => xgmii_txd_4(8),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(8)
    );
  BU2_U0_transmitter_txd_pipe_10 : FDS
    port map (
      D => xgmii_txd_4(10),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(10)
    );
  BU2_U0_transmitter_txd_pipe_9 : FDS
    port map (
      D => xgmii_txd_4(9),
      S => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(9)
    );
  BU2_U0_transmitter_txd_pipe_11 : FDR
    port map (
      D => xgmii_txd_4(11),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(11)
    );
  BU2_U0_transmitter_txd_pipe_12 : FDR
    port map (
      D => xgmii_txd_4(12),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(12)
    );
  BU2_U0_transmitter_txd_pipe_13 : FDR
    port map (
      D => xgmii_txd_4(13),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(13)
    );
  BU2_U0_transmitter_filter0_n00227 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(2),
      I1 => BU2_U0_transmitter_txd_pipe(7),
      I2 => BU2_U0_transmitter_txd_pipe(1),
      I3 => BU2_U0_transmitter_txd_pipe(0),
      O => BU2_CHOICE1826
    );
  BU2_U0_receiver_n0022100 : LUT4
    generic map(
      INIT => X"AF8F"
    )
    port map (
      I0 => mgt_rxcharisk_7(0),
      I1 => BU2_CHOICE1358,
      I2 => mgt_codevalid_8(0),
      I3 => BU2_CHOICE1375,
      O => BU2_U0_receiver_code_error(4)
    );
  BU2_U0_receiver_n0021100 : LUT4
    generic map(
      INIT => X"AF8F"
    )
    port map (
      I0 => mgt_rxcharisk_7(7),
      I1 => BU2_CHOICE1330,
      I2 => mgt_codevalid_8(7),
      I3 => BU2_CHOICE1347,
      O => BU2_U0_receiver_code_error(3)
    );
  BU2_U0_receiver_n0018100 : LUT4
    generic map(
      INIT => X"AF8F"
    )
    port map (
      I0 => mgt_rxcharisk_7(1),
      I1 => BU2_CHOICE1274,
      I2 => mgt_codevalid_8(1),
      I3 => BU2_CHOICE1291,
      O => BU2_N701
    );
  BU2_U0_receiver_n0020100 : LUT4
    generic map(
      INIT => X"AF8F"
    )
    port map (
      I0 => mgt_rxcharisk_7(5),
      I1 => BU2_CHOICE1302,
      I2 => mgt_codevalid_8(5),
      I3 => BU2_CHOICE1319,
      O => BU2_U0_receiver_code_error(2)
    );
  BU2_U0_receiver_n0019100 : LUT4
    generic map(
      INIT => X"AF8F"
    )
    port map (
      I0 => mgt_rxcharisk_7(3),
      I1 => BU2_CHOICE1246,
      I2 => mgt_codevalid_8(3),
      I3 => BU2_CHOICE1263,
      O => BU2_U0_receiver_code_error(1)
    );
  BU2_U0_receiver_recoder_n093534_SW0 : LUT4_L
    generic map(
      INIT => X"F7FF"
    )
    port map (
      I0 => BU2_U0_receiver_recoder_rxd_pipe(21),
      I1 => BU2_U0_receiver_recoder_rxd_pipe(18),
      I2 => BU2_U0_receiver_recoder_rxd_pipe(16),
      I3 => BU2_U0_receiver_recoder_rxc_pipe(2),
      LO => BU2_N3512
    );
  BU2_U0_receiver_n0023100 : LUT4
    generic map(
      INIT => X"AF8F"
    )
    port map (
      I0 => mgt_rxcharisk_7(2),
      I1 => BU2_CHOICE1190,
      I2 => mgt_codevalid_8(2),
      I3 => BU2_CHOICE1207,
      O => BU2_U0_receiver_code_error(5)
    );
  BU2_U0_receiver_non_iee_deskew_state_n00661 : LUT4
    generic map(
      INIT => X"7020"
    )
    port map (
      I0 => BU2_N3121,
      I1 => BU2_U0_receiver_non_iee_deskew_state_deskew_error(1),
      I2 => BU2_U0_receiver_sync_status,
      I3 => BU2_U0_receiver_non_iee_deskew_state_got_align(1),
      O => BU2_U0_receiver_non_iee_deskew_state_next_state(1)
    );
  BU2_U0_receiver_n0024100 : LUT4
    generic map(
      INIT => X"AF8F"
    )
    port map (
      I0 => mgt_rxcharisk_7(4),
      I1 => BU2_CHOICE1218,
      I2 => mgt_codevalid_8(4),
      I3 => BU2_CHOICE1235,
      O => BU2_U0_receiver_code_error(6)
    );
  BU2_U0_receiver_sync_ok_0 : FDR
    port map (
      D => mgt_syncok_10(0),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => NlwRenamedSignal_status_vector(2)
    );
  BU2_U0_receiver_recoder_rxd_out_15 : FDRS
    port map (
      D => BU2_U0_receiver_recoder_n0474,
      R => BU2_U0_n0010,
      S => BU2_U0_receiver_recoder_error_lane_1_Q,
      C => usrclk,
      Q => xgmii_rxd_0(15)
    );
  BU2_U0_receiver_n0026100 : LUT4
    generic map(
      INIT => X"AF8F"
    )
    port map (
      I0 => mgt_rxcharisk_7(6),
      I1 => BU2_CHOICE1162,
      I2 => mgt_codevalid_8(6),
      I3 => BU2_CHOICE1179,
      O => BU2_U0_receiver_code_error(7)
    );
  BU2_U0_receiver_sync_ok_3 : FDR
    port map (
      D => mgt_syncok_10(3),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => NlwRenamedSignal_status_vector(5)
    );
  BU2_U0_receiver_sync_status_101 : FDR
    port map (
      D => BU2_U0_receiver_sync_status_int,
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_receiver_sync_status
    );
  BU2_U0_receiver_sync_ok_1 : FDR
    port map (
      D => mgt_syncok_10(1),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => NlwRenamedSignal_status_vector(3)
    );
  BU2_U0_receiver_sync_ok_2 : FDR
    port map (
      D => mgt_syncok_10(2),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => NlwRenamedSignal_status_vector(4)
    );
  BU2_U0_n00131 : LUT4_L
    generic map(
      INIT => X"FFEF"
    )
    port map (
      I0 => mgt_rx_reset_12(3),
      I1 => mgt_rx_reset_12(2),
      I2 => NlwRenamedSig_OI_align_status,
      I3 => mgt_rx_reset_12(1),
      LO => BU2_U0_N4
    );
  BU2_U0_receiver_non_iee_deskew_state_Ker221 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => mgt_rxdata_6(14),
      I1 => mgt_rxdata_6(15),
      I2 => mgt_rxdata_6(13),
      I3 => BU2_N3536,
      O => BU2_N383
    );
  BU2_U0_tx_local_fault : FDRSE
    port map (
      D => BU2_mdio_tri,
      R => BU2_U0_usrclk_reset,
      S => BU2_U0_n0019,
      CE => BU2_U0_clear_local_fault_edge,
      C => usrclk,
      Q => status_vector(0)
    );
  BU2_U0_aligned_sticky : FDRE
    port map (
      D => NlwRenamedSig_OI_mgt_enable_align(0),
      R => BU2_U0_n0010,
      CE => BU2_U0_clear_aligned_edge,
      C => usrclk,
      Q => status_vector(7)
    );
  BU2_U0_last_value_102 : FDR
    port map (
      D => configuration_vector_14(2),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_last_value
    );
  BU2_U0_transmitter_align_n0042 : LUT4_L
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => BU2_U0_transmitter_align_count(4),
      I1 => BU2_U0_transmitter_align_count(3),
      I2 => BU2_U0_transmitter_align_N4,
      I3 => BU2_N2981,
      LO => BU2_U0_transmitter_a_due(0)
    );
  BU2_U0_n00132 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => mgt_rx_reset_12(0),
      I1 => BU2_U0_N4,
      O => BU2_U0_n0013
    );
  BU2_U0_n00101_103 : LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => BU2_U0_usrclk_reset,
      I1 => NlwRenamedSig_OI_align_status,
      O => BU2_U0_n0010
    );
  BU2_U0_usrclk_reset_104 : FDS
    generic map(
      INIT => '1'
    )
    port map (
      D => BU2_U0_usrclk_reset_pipe,
      S => reset,
      C => usrclk,
      Q => BU2_U0_usrclk_reset
    );
  BU2_U0_transmitter_align_prbs_5 : FDSE
    generic map(
      INIT => '1'
    )
    port map (
      D => BU2_U0_transmitter_align_prbs(4),
      S => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_align_N4,
      C => usrclk,
      Q => BU2_U0_transmitter_align_prbs(5)
    );
  BU2_U0_transmitter_n0263103 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => BU2_U0_transmitter_txd_pipe(13),
      I1 => BU2_U0_transmitter_txd_pipe(9),
      I2 => BU2_CHOICE1866,
      I3 => BU2_CHOICE1870,
      O => BU2_CHOICE1872
    );
  BU2_U0_n00091 : LUT3
    generic map(
      INIT => X"EF"
    )
    port map (
      I0 => BU2_U0_usrclk_reset,
      I1 => BU2_U0_last_value0,
      I2 => configuration_vector_14(3),
      O => BU2_U0_n0009
    );
  BU2_U0_rx_local_fault : FDRSE
    port map (
      D => BU2_mdio_tri,
      R => BU2_U0_usrclk_reset,
      S => BU2_U0_n0013,
      CE => BU2_U0_clear_local_fault_edge,
      C => usrclk,
      Q => status_vector(1)
    );
  BU2_U0_usrclk_reset_pipe_105 : FDR
    generic map(
      INIT => '1'
    )
    port map (
      D => NlwRenamedSig_OI_mgt_enable_align(0),
      R => BU2_U0_usrclk_reset_pipe_N0,
      C => usrclk,
      Q => BU2_U0_usrclk_reset_pipe
    );
  BU2_U0_clear_local_fault_edge_106 : FDR
    port map (
      D => NlwRenamedSig_OI_mgt_enable_align(0),
      R => BU2_U0_n0014,
      C => usrclk,
      Q => BU2_U0_clear_local_fault_edge
    );
  BU2_U0_usrclk_reset_pipe_Sclr_INV1_INV_0 : INV
    port map (
      I => reset,
      O => BU2_U0_usrclk_reset_pipe_N0
    );
  BU2_U0_last_value0_107 : FDR
    port map (
      D => configuration_vector_14(3),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_last_value0
    );
  BU2_U0_transmitter_align_prbs_7 : FDSE
    generic map(
      INIT => '1'
    )
    port map (
      D => BU2_U0_transmitter_align_prbs(6),
      S => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_align_N4,
      C => usrclk,
      Q => BU2_U0_transmitter_align_prbs(7)
    );
  BU2_U0_transmitter_align_prbs_3 : FDSE
    generic map(
      INIT => '1'
    )
    port map (
      D => BU2_U0_transmitter_align_prbs(2),
      S => BU2_U0_usrclk_reset,
      CE => BU2_U0_transmitter_align_N4,
      C => usrclk,
      Q => BU2_U0_transmitter_align_prbs(3)
    );
  BU2_U0_clear_aligned_edge_108 : FDR
    port map (
      D => NlwRenamedSig_OI_mgt_enable_align(0),
      R => BU2_U0_n0009,
      C => usrclk,
      Q => BU2_U0_clear_aligned_edge
    );
  BU2_U0_receiver_n00251 : LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => mgt_syncok_10(0),
      I1 => mgt_syncok_10(1),
      I2 => mgt_syncok_10(2),
      I3 => mgt_syncok_10(3),
      O => BU2_U0_receiver_sync_status_int
    );
  BU2_U0_transmitter_txd_pipe_43 : FDR
    port map (
      D => xgmii_txd_4(43),
      R => BU2_U0_usrclk_reset,
      C => usrclk,
      Q => BU2_U0_transmitter_txd_pipe(43)
    );
  BU2_U0_n00191 : LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => mgt_tx_reset_11(0),
      I1 => mgt_tx_reset_11(1),
      I2 => mgt_tx_reset_11(2),
      I3 => mgt_tx_reset_11(3),
      O => BU2_U0_n0019
    );
  BU2_U0_transmitter_align_n00242 : LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => BU2_U0_transmitter_align_count(1),
      I1 => BU2_U0_transmitter_align_count(2),
      I2 => BU2_U0_transmitter_align_N3,
      O => BU2_U0_transmitter_align_n0024
    );
  BU2_XST_VCC : VCC
    port map (
      P => NlwRenamedSig_OI_mgt_enable_align(0)
    );
  BU2_XST_GND : GND
    port map (
      G => BU2_mdio_tri
    );
  BU2_U0_n00141 : LUT3
    generic map(
      INIT => X"EF"
    )
    port map (
      I0 => BU2_U0_usrclk_reset,
      I1 => BU2_U0_last_value,
      I2 => configuration_vector_14(2),
      O => BU2_U0_n0014
    );

end STRUCTURE;



-- synopsys translate_on

