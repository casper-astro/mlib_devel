--------------------------------------------------------------------------------
--     This file is owned and controlled by Xilinx and must be used           --
--     solely for design, simulation, implementation and creation of          --
--     design files limited to Xilinx devices or technologies. Use            --
--     with non-Xilinx devices or technologies is expressly prohibited        --
--     and immediately terminates your license.                               --
--                                                                            --
--     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"          --
--     SOLELY FOR USE IN DEVELOPING PROGRAMS AND SOLUTIONS FOR                --
--     XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION        --
--     AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE, APPLICATION            --
--     OR STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS              --
--     IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,                --
--     AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE       --
--     FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY               --
--     WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE                --
--     IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR         --
--     REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF        --
--     INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS        --
--     FOR A PARTICULAR PURPOSE.                                              --
--                                                                            --
--     Xilinx products are not intended for use in life support               --
--     appliances, devices, or systems. Use in such applications are          --
--     expressly prohibited.                                                  --
--                                                                            --
--     (c) Copyright 1995-2006 Xilinx, Inc.                                   --
--     All rights reserved.                                                   --
--------------------------------------------------------------------------------
-- The following code must appear in the VHDL architecture header:

------------- Begin Cut here for COMPONENT Declaration ------ COMP_TAG
component xaui_v6_2
	port (
	reset: IN std_logic;
	xgmii_txd: IN std_logic_VECTOR(63 downto 0);
	xgmii_txc: IN std_logic_VECTOR(7 downto 0);
	xgmii_rxd: OUT std_logic_VECTOR(63 downto 0);
	xgmii_rxc: OUT std_logic_VECTOR(7 downto 0);
	usrclk: IN std_logic;
	mgt_txdata: OUT std_logic_VECTOR(63 downto 0);
	mgt_txcharisk: OUT std_logic_VECTOR(7 downto 0);
	mgt_rxdata: IN std_logic_VECTOR(63 downto 0);
	mgt_rxcharisk: IN std_logic_VECTOR(7 downto 0);
	mgt_codevalid: IN std_logic_VECTOR(7 downto 0);
	mgt_codecomma: IN std_logic_VECTOR(7 downto 0);
	mgt_enable_align: OUT std_logic_VECTOR(3 downto 0);
	mgt_enchansync: OUT std_logic;
	mgt_syncok: IN std_logic_VECTOR(3 downto 0);
	mgt_loopback: OUT std_logic;
	mgt_powerdown: OUT std_logic;
	mgt_tx_reset: IN std_logic_VECTOR(3 downto 0);
	mgt_rx_reset: IN std_logic_VECTOR(3 downto 0);
	signal_detect: IN std_logic_VECTOR(3 downto 0);
	align_status: OUT std_logic;
	sync_status: OUT std_logic_VECTOR(3 downto 0);
	configuration_vector: IN std_logic_VECTOR(6 downto 0);
	status_vector: OUT std_logic_VECTOR(7 downto 0));
end component;

-- COMP_TAG_END ------ End COMPONENT Declaration ------------

-- The following code must appear in the VHDL architecture
-- body. Substitute your own instance name and net names.

------------- Begin Cut here for INSTANTIATION Template ----- INST_TAG
your_instance_name : xaui_v6_2
		port map (
			reset => reset,
			xgmii_txd => xgmii_txd,
			xgmii_txc => xgmii_txc,
			xgmii_rxd => xgmii_rxd,
			xgmii_rxc => xgmii_rxc,
			usrclk => usrclk,
			mgt_txdata => mgt_txdata,
			mgt_txcharisk => mgt_txcharisk,
			mgt_rxdata => mgt_rxdata,
			mgt_rxcharisk => mgt_rxcharisk,
			mgt_codevalid => mgt_codevalid,
			mgt_codecomma => mgt_codecomma,
			mgt_enable_align => mgt_enable_align,
			mgt_enchansync => mgt_enchansync,
			mgt_syncok => mgt_syncok,
			mgt_loopback => mgt_loopback,
			mgt_powerdown => mgt_powerdown,
			mgt_tx_reset => mgt_tx_reset,
			mgt_rx_reset => mgt_rx_reset,
			signal_detect => signal_detect,
			align_status => align_status,
			sync_status => sync_status,
			configuration_vector => configuration_vector,
			status_vector => status_vector);
-- INST_TAG_END ------ End INSTANTIATION Template ------------

