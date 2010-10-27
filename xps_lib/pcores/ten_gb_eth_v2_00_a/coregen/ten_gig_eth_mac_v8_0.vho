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
component ten_gig_eth_mac_v8_0
	port (
	reset: IN std_logic;
	tx_underrun: IN std_logic;
	tx_data: IN std_logic_VECTOR(63 downto 0);
	tx_data_valid: IN std_logic_VECTOR(7 downto 0);
	tx_start: IN std_logic;
	tx_ack: OUT std_logic;
	tx_ifg_delay: IN std_logic_VECTOR(7 downto 0);
	tx_statistics_vector: OUT std_logic_VECTOR(24 downto 0);
	tx_statistics_valid: OUT std_logic;
	rx_data: OUT std_logic_VECTOR(63 downto 0);
	rx_data_valid: OUT std_logic_VECTOR(7 downto 0);
	rx_good_frame: OUT std_logic;
	rx_bad_frame: OUT std_logic;
	rx_statistics_vector: OUT std_logic_VECTOR(28 downto 0);
	rx_statistics_valid: OUT std_logic;
	pause_val: IN std_logic_VECTOR(15 downto 0);
	pause_req: IN std_logic;
	configuration_vector: IN std_logic_VECTOR(66 downto 0);
	tx_clk0: IN std_logic;
	tx_dcm_lock: IN std_logic;
	xgmii_txd: OUT std_logic_VECTOR(63 downto 0);
	xgmii_txc: OUT std_logic_VECTOR(7 downto 0);
	rx_clk0: IN std_logic;
	rx_dcm_lock: IN std_logic;
	xgmii_rxd: IN std_logic_VECTOR(63 downto 0);
	xgmii_rxc: IN std_logic_VECTOR(7 downto 0));
end component;

-- COMP_TAG_END ------ End COMPONENT Declaration ------------

-- The following code must appear in the VHDL architecture
-- body. Substitute your own instance name and net names.

------------- Begin Cut here for INSTANTIATION Template ----- INST_TAG
your_instance_name : ten_gig_eth_mac_v8_0
		port map (
			reset => reset,
			tx_underrun => tx_underrun,
			tx_data => tx_data,
			tx_data_valid => tx_data_valid,
			tx_start => tx_start,
			tx_ack => tx_ack,
			tx_ifg_delay => tx_ifg_delay,
			tx_statistics_vector => tx_statistics_vector,
			tx_statistics_valid => tx_statistics_valid,
			rx_data => rx_data,
			rx_data_valid => rx_data_valid,
			rx_good_frame => rx_good_frame,
			rx_bad_frame => rx_bad_frame,
			rx_statistics_vector => rx_statistics_vector,
			rx_statistics_valid => rx_statistics_valid,
			pause_val => pause_val,
			pause_req => pause_req,
			configuration_vector => configuration_vector,
			tx_clk0 => tx_clk0,
			tx_dcm_lock => tx_dcm_lock,
			xgmii_txd => xgmii_txd,
			xgmii_txc => xgmii_txc,
			rx_clk0 => rx_clk0,
			rx_dcm_lock => rx_dcm_lock,
			xgmii_rxd => xgmii_rxd,
			xgmii_rxc => xgmii_rxc);
-- INST_TAG_END ------ End INSTANTIATION Template ------------

