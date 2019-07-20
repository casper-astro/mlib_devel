----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.06.2016 14:12:53
-- Design Name: 
-- Module Name: ADC32RF45_RX_PHY - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ADC32RF45_RX_PHY is
	generic(
		STABLE_CLOCK_PERIOD : integer := 8;
		RX_POLARITY_INVERT  : std_logic_vector(3 downto 0) := "0000" -- GT 17/01/2017 PROVIDE OPTION OF SETTING INVERTING POLARITY
	);
	Port(
		SYS_CLK_I                : in  std_logic;

		SOFT_RESET_IN            : in  std_logic;

		GTREFCLK_IN              : in  std_logic;

		GT_RXUSRCLK2_O           : out std_logic;

		LANE0_RX_DATA_IS_K_O     : out std_logic_vector(3 downto 0);
		LANE0_RX_DATA_O          : out std_logic_vector(31 downto 0);

		LANE1_RX_DATA_IS_K_O     : out std_logic_vector(3 downto 0);
		LANE1_RX_DATA_O          : out std_logic_vector(31 downto 0);

		LANE2_RX_DATA_IS_K_O     : out std_logic_vector(3 downto 0);
		LANE2_RX_DATA_O          : out std_logic_vector(31 downto 0);

		LANE3_RX_DATA_IS_K_O     : out std_logic_vector(3 downto 0);
		LANE3_RX_DATA_O          : out std_logic_vector(31 downto 0);

		RX_DATA_K28_0_DETECTED_O : out std_logic_vector(3 downto 0);

		RXN_I                    : in  std_logic_vector(3 downto 0);
		RXP_I                    : in  std_logic_vector(3 downto 0);

		GT_CPLL_LOCK_O           : out std_logic_vector(3 downto 0);
		GT_BYTE_ALIGNED_O        : out std_logic_vector(3 downto 0);
		GT_RX_READY_O            : out std_logic_vector(3 downto 0)
	);
end ADC32RF45_RX_PHY;

architecture Behavioral of ADC32RF45_RX_PHY is
	component JESD204B_4LaneRX_7500MHz_support is
		generic(
			EXAMPLE_SIM_GTRESET_SPEEDUP : string  := "TRUE"; -- simulation setting for GT SecureIP model
			STABLE_CLOCK_PERIOD         : integer := 10
		);
		port(
			--____________________________COMMON PORTS________________________________
			SYS_CLK_I                   : in  std_logic;

			SOFT_RESET_IN               : in  std_logic;
			DONT_RESET_ON_DATA_ERROR_IN : in  std_logic;

			GTREFCLK_IN                 : in  std_logic;

			GT_RXUSRCLK2_OUT            : out std_logic;

			GT0_RX_FSM_RESET_DONE_OUT   : out std_logic;
			GT0_DATA_VALID_IN           : in  std_logic;
			GT1_RX_FSM_RESET_DONE_OUT   : out std_logic;
			GT1_DATA_VALID_IN           : in  std_logic;
			GT2_RX_FSM_RESET_DONE_OUT   : out std_logic;
			GT2_DATA_VALID_IN           : in  std_logic;
			GT3_RX_FSM_RESET_DONE_OUT   : out std_logic;
			GT3_DATA_VALID_IN           : in  std_logic;

			--_________________________________________________________________________
			--GT0
			--____________________________CHANNEL PORTS________________________________
			--------------------------------- CPLL Ports -------------------------------
			gt0_cplllock_out            : out std_logic;
			------------------ Receive Ports - FPGA RX interface Ports -----------------
			gt0_rxdata_out              : out std_logic_vector(31 downto 0);
			------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
			gt0_rxdisperr_out           : out std_logic_vector(3 downto 0);
			gt0_rxnotintable_out        : out std_logic_vector(3 downto 0);
			------------------------ Receive Ports - RX AFE Ports ----------------------
			gt0_gthrxn_in               : in  std_logic;
			------------------- Receive Ports - RX Buffer Bypass Ports -----------------
			gt0_rxbufreset_in           : in  std_logic;
			gt0_rxbufstatus_out         : out std_logic_vector(2 downto 0);
			-------------- Receive Ports - RX Byte and Word Alignment Ports ------------
			gt0_rxbyteisaligned_out     : out std_logic;
			gt0_rxbyterealign_out       : out std_logic;
			gt0_rxcommadet_out          : out std_logic;
			gt0_rxmcommaalignen_in      : in  std_logic;
			gt0_rxpcommaalignen_in      : in  std_logic;
			------------------ Receive Ports - RX Channel Bonding Ports ----------------
			gt0_rxchanbondseq_out       : out std_logic;
			gt0_rxchbonden_in           : in  std_logic;
			gt0_rxchbondlevel_in        : in  std_logic_vector(2 downto 0);
			gt0_rxchbondmaster_in       : in  std_logic;
			gt0_rxchbondo_out           : out std_logic_vector(4 downto 0);
			gt0_rxchbondslave_in        : in  std_logic;
			----------------- Receive Ports - RX Channel Bonding Ports  ----------------
			gt0_rxchanisaligned_out     : out std_logic;
			gt0_rxchanrealign_out       : out std_logic;
			------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
			gt0_rxchariscomma_out       : out std_logic_vector(3 downto 0);
			gt0_rxcharisk_out           : out std_logic_vector(3 downto 0);
			------------------ Receive Ports - Rx Channel Bonding Ports ----------------
			gt0_rxchbondi_in            : in  std_logic_vector(4 downto 0);
			------------------------ Receive Ports -RX AFE Ports -----------------------
			gt0_gthrxp_in               : in  std_logic;
            ----------------- Receive Ports - RX Polarity Control Ports ----------------
            gt0_rxpolarity_in           : in  std_logic; -- GT 17/01/2017 PROVIDE OPTION OF SETTING INVERTING POLARITY

			--GT1
			--____________________________CHANNEL PORTS________________________________
			--------------------------------- CPLL Ports -------------------------------
			gt1_cplllock_out            : out std_logic;
			------------------ Receive Ports - FPGA RX interface Ports -----------------
			gt1_rxdata_out              : out std_logic_vector(31 downto 0);
			------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
			gt1_rxdisperr_out           : out std_logic_vector(3 downto 0);
			gt1_rxnotintable_out        : out std_logic_vector(3 downto 0);
			------------------------ Receive Ports - RX AFE Ports ----------------------
			gt1_gthrxn_in               : in  std_logic;
			------------------- Receive Ports - RX Buffer Bypass Ports -----------------
			gt1_rxbufreset_in           : in  std_logic;
			gt1_rxbufstatus_out         : out std_logic_vector(2 downto 0);
			-------------- Receive Ports - RX Byte and Word Alignment Ports ------------
			gt1_rxbyteisaligned_out     : out std_logic;
			gt1_rxbyterealign_out       : out std_logic;
			gt1_rxcommadet_out          : out std_logic;
			gt1_rxmcommaalignen_in      : in  std_logic;
			gt1_rxpcommaalignen_in      : in  std_logic;
			------------------ Receive Ports - RX Channel Bonding Ports ----------------
			gt1_rxchanbondseq_out       : out std_logic;
			gt1_rxchbonden_in           : in  std_logic;
			gt1_rxchbondlevel_in        : in  std_logic_vector(2 downto 0);
			gt1_rxchbondmaster_in       : in  std_logic;
			gt1_rxchbondo_out           : out std_logic_vector(4 downto 0);
			gt1_rxchbondslave_in        : in  std_logic;
			----------------- Receive Ports - RX Channel Bonding Ports  ----------------
			gt1_rxchanisaligned_out     : out std_logic;
			gt1_rxchanrealign_out       : out std_logic;
			------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
			gt1_rxchariscomma_out       : out std_logic_vector(3 downto 0);
			gt1_rxcharisk_out           : out std_logic_vector(3 downto 0);
			------------------ Receive Ports - Rx Channel Bonding Ports ----------------
			gt1_rxchbondi_in            : in  std_logic_vector(4 downto 0);
			------------------------ Receive Ports -RX AFE Ports -----------------------
			gt1_gthrxp_in               : in  std_logic;
            ----------------- Receive Ports - RX Polarity Control Ports ----------------
            gt1_rxpolarity_in           : in  std_logic; -- GT 17/01/2017 PROVIDE OPTION OF SETTING INVERTING POLARITY
			
			--GT2
			--____________________________CHANNEL PORTS________________________________
			--------------------------------- CPLL Ports -------------------------------
			gt2_cplllock_out            : out std_logic;
			------------------ Receive Ports - FPGA RX interface Ports -----------------
			gt2_rxdata_out              : out std_logic_vector(31 downto 0);
			------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
			gt2_rxdisperr_out           : out std_logic_vector(3 downto 0);
			gt2_rxnotintable_out        : out std_logic_vector(3 downto 0);
			------------------------ Receive Ports - RX AFE Ports ----------------------
			gt2_gthrxn_in               : in  std_logic;
			------------------- Receive Ports - RX Buffer Bypass Ports -----------------
			gt2_rxbufreset_in           : in  std_logic;
			gt2_rxbufstatus_out         : out std_logic_vector(2 downto 0);
			-------------- Receive Ports - RX Byte and Word Alignment Ports ------------
			gt2_rxbyteisaligned_out     : out std_logic;
			gt2_rxbyterealign_out       : out std_logic;
			gt2_rxcommadet_out          : out std_logic;
			gt2_rxmcommaalignen_in      : in  std_logic;
			gt2_rxpcommaalignen_in      : in  std_logic;
			------------------ Receive Ports - RX Channel Bonding Ports ----------------
			gt2_rxchanbondseq_out       : out std_logic;
			gt2_rxchbonden_in           : in  std_logic;
			gt2_rxchbondlevel_in        : in  std_logic_vector(2 downto 0);
			gt2_rxchbondmaster_in       : in  std_logic;
			gt2_rxchbondo_out           : out std_logic_vector(4 downto 0);
			gt2_rxchbondslave_in        : in  std_logic;
			----------------- Receive Ports - RX Channel Bonding Ports  ----------------
			gt2_rxchanisaligned_out     : out std_logic;
			gt2_rxchanrealign_out       : out std_logic;
			------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
			gt2_rxchariscomma_out       : out std_logic_vector(3 downto 0);
			gt2_rxcharisk_out           : out std_logic_vector(3 downto 0);
			------------------ Receive Ports - Rx Channel Bonding Ports ----------------
			gt2_rxchbondi_in            : in  std_logic_vector(4 downto 0);
			------------------------ Receive Ports -RX AFE Ports -----------------------
			gt2_gthrxp_in               : in  std_logic;
            ----------------- Receive Ports - RX Polarity Control Ports ----------------
            gt2_rxpolarity_in           : in  std_logic; -- GT 17/01/2017 PROVIDE OPTION OF SETTING INVERTING POLARITY
			
			--GT3
			--____________________________CHANNEL PORTS________________________________
			--------------------------------- CPLL Ports -------------------------------
			gt3_cplllock_out            : out std_logic;
			------------------ Receive Ports - FPGA RX interface Ports -----------------
			gt3_rxdata_out              : out std_logic_vector(31 downto 0);
			------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
			gt3_rxdisperr_out           : out std_logic_vector(3 downto 0);
			gt3_rxnotintable_out        : out std_logic_vector(3 downto 0);
			------------------------ Receive Ports - RX AFE Ports ----------------------
			gt3_gthrxn_in               : in  std_logic;
			------------------- Receive Ports - RX Buffer Bypass Ports -----------------
			gt3_rxbufreset_in           : in  std_logic;
			gt3_rxbufstatus_out         : out std_logic_vector(2 downto 0);
			-------------- Receive Ports - RX Byte and Word Alignment Ports ------------
			gt3_rxbyteisaligned_out     : out std_logic;
			gt3_rxbyterealign_out       : out std_logic;
			gt3_rxcommadet_out          : out std_logic;
			gt3_rxmcommaalignen_in      : in  std_logic;
			gt3_rxpcommaalignen_in      : in  std_logic;
			------------------ Receive Ports - RX Channel Bonding Ports ----------------
			gt3_rxchanbondseq_out       : out std_logic;
			gt3_rxchbonden_in           : in  std_logic;
			gt3_rxchbondlevel_in        : in  std_logic_vector(2 downto 0);
			gt3_rxchbondmaster_in       : in  std_logic;
			gt3_rxchbondo_out           : out std_logic_vector(4 downto 0);
			gt3_rxchbondslave_in        : in  std_logic;
			----------------- Receive Ports - RX Channel Bonding Ports  ----------------
			gt3_rxchanisaligned_out     : out std_logic;
			gt3_rxchanrealign_out       : out std_logic;
			------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
			gt3_rxchariscomma_out       : out std_logic_vector(3 downto 0);
			gt3_rxcharisk_out           : out std_logic_vector(3 downto 0);
			------------------ Receive Ports - Rx Channel Bonding Ports ----------------
			gt3_rxchbondi_in            : in  std_logic_vector(4 downto 0);
			------------------------ Receive Ports -RX AFE Ports -----------------------
			gt3_gthrxp_in               : in  std_logic;
            ----------------- Receive Ports - RX Polarity Control Ports ----------------
            gt3_rxpolarity_in           : in  std_logic -- GT 17/01/2017 PROVIDE OPTION OF SETTING INVERTING POLARITY
			
		);
	end component JESD204B_4LaneRX_7500MHz_support;

	signal tied_to_ground_i : std_logic;
	signal tied_to_vcc_i    : std_logic;

	signal gt_rxusrclk2 : std_logic;

	signal gt_cpll_lock    : std_logic_vector(3 downto 0);
	signal gt_byte_aligned : std_logic_vector(3 downto 0);
	signal gt_rx_ready     : std_logic_vector(3 downto 0);

	signal gt0_rxchbondo : std_logic_vector(4 downto 0);

	signal gt0_rxbufstatus : std_logic_vector(2 downto 0);
	signal gt1_rxbufstatus : std_logic_vector(2 downto 0);
	signal gt2_rxbufstatus : std_logic_vector(2 downto 0);
	signal gt3_rxbufstatus : std_logic_vector(2 downto 0);

	signal gt0_rxbufreset : std_logic;
	signal gt1_rxbufreset : std_logic;
	signal gt2_rxbufreset : std_logic;
	signal gt3_rxbufreset : std_logic;

begin

	--  Static signal Assigments
	tied_to_ground_i <= '0';
	tied_to_vcc_i    <= '1';

	ADC_GT_SUPPPORT_inst : component JESD204B_4LaneRX_7500MHz_support
		generic map(
			EXAMPLE_SIM_GTRESET_SPEEDUP => "TRUE",
			STABLE_CLOCK_PERIOD         => STABLE_CLOCK_PERIOD
		)
		port map(
			SYS_CLK_I                   => SYS_CLK_I,
			SOFT_RESET_IN               => SOFT_RESET_IN,
			DONT_RESET_ON_DATA_ERROR_IN => tied_to_ground_i,
			GTREFCLK_IN                 => GTREFCLK_IN,
			GT_RXUSRCLK2_OUT            => gt_rxusrclk2,
			GT0_RX_FSM_RESET_DONE_OUT   => gt_rx_ready(0),
			GT0_DATA_VALID_IN           => '1',
			GT1_RX_FSM_RESET_DONE_OUT   => gt_rx_ready(1),
			GT1_DATA_VALID_IN           => '1',
			GT2_RX_FSM_RESET_DONE_OUT   => gt_rx_ready(2),
			GT2_DATA_VALID_IN           => '1',
			GT3_RX_FSM_RESET_DONE_OUT   => gt_rx_ready(3),
			GT3_DATA_VALID_IN           => '1',
			gt0_cplllock_out            => gt_cpll_lock(0),
			gt0_rxdata_out              => LANE0_RX_DATA_O,
			gt0_rxdisperr_out           => open,
			gt0_rxnotintable_out        => open,
			gt0_gthrxn_in               => RXN_I(0),
			gt0_rxbufreset_in           => gt0_rxbufreset,
			gt0_rxbufstatus_out         => gt0_rxbufstatus,
			gt0_rxbyteisaligned_out     => gt_byte_aligned(0),
			gt0_rxbyterealign_out       => open,
			gt0_rxcommadet_out          => open,
			gt0_rxmcommaalignen_in      => '1',
			gt0_rxpcommaalignen_in      => '1',
			gt0_rxchanbondseq_out       => RX_DATA_K28_0_DETECTED_O(0),
			gt0_rxchbonden_in           => '1',
			gt0_rxchbondlevel_in        => "001",
			gt0_rxchbondmaster_in       => '1',
			gt0_rxchbondo_out           => gt0_rxchbondo,
			gt0_rxchbondslave_in        => '0',
			gt0_rxchanisaligned_out     => open,
			gt0_rxchanrealign_out       => open,
			gt0_rxchariscomma_out       => open,
			gt0_rxcharisk_out           => LANE0_RX_DATA_IS_K_O,
			gt0_rxchbondi_in            => "00000",
			gt0_gthrxp_in               => RXP_I(0),
            gt0_rxpolarity_in           => RX_POLARITY_INVERT(0),
			gt1_cplllock_out            => gt_cpll_lock(1),
			gt1_rxdata_out              => LANE1_RX_DATA_O,
			gt1_rxdisperr_out           => open,
			gt1_rxnotintable_out        => open,
			gt1_gthrxn_in               => RXN_I(1),
			gt1_rxbufreset_in           => gt1_rxbufreset,
			gt1_rxbufstatus_out         => gt1_rxbufstatus,
			gt1_rxbyteisaligned_out     => gt_byte_aligned(1),
			gt1_rxbyterealign_out       => open,
			gt1_rxcommadet_out          => open,
			gt1_rxmcommaalignen_in      => '1',
			gt1_rxpcommaalignen_in      => '1',
			gt1_rxchanbondseq_out       => RX_DATA_K28_0_DETECTED_O(1),
			gt1_rxchbonden_in           => '1',
			gt1_rxchbondlevel_in        => "000",
			gt1_rxchbondmaster_in       => '0',
			gt1_rxchbondo_out           => open,
			gt1_rxchbondslave_in        => '1',
			gt1_rxchanisaligned_out     => open,
			gt1_rxchanrealign_out       => open,
			gt1_rxchariscomma_out       => open,
			gt1_rxcharisk_out           => LANE1_RX_DATA_IS_K_O,
			gt1_rxchbondi_in            => gt0_rxchbondo,
			gt1_gthrxp_in               => RXP_I(1),
            gt1_rxpolarity_in           => RX_POLARITY_INVERT(1),
			gt2_cplllock_out            => gt_cpll_lock(2),
			gt2_rxdata_out              => LANE2_RX_DATA_O,
			gt2_rxdisperr_out           => open,
			gt2_rxnotintable_out        => open,
			gt2_gthrxn_in               => RXN_I(2),
			gt2_rxbufreset_in           => gt2_rxbufreset,
			gt2_rxbufstatus_out         => gt2_rxbufstatus,
			gt2_rxbyteisaligned_out     => gt_byte_aligned(2),
			gt2_rxbyterealign_out       => open,
			gt2_rxcommadet_out          => open,
			gt2_rxmcommaalignen_in      => '1',
			gt2_rxpcommaalignen_in      => '1',
			gt2_rxchanbondseq_out       => RX_DATA_K28_0_DETECTED_O(2),
			gt2_rxchbonden_in           => '1',
			gt2_rxchbondlevel_in        => "000",
			gt2_rxchbondmaster_in       => '0',
			gt2_rxchbondo_out           => open,
			gt2_rxchbondslave_in        => '1',
			gt2_rxchanisaligned_out     => open,
			gt2_rxchanrealign_out       => open,
			gt2_rxchariscomma_out       => open,
			gt2_rxcharisk_out           => LANE2_RX_DATA_IS_K_O,
			gt2_rxchbondi_in            => gt0_rxchbondo,
			gt2_gthrxp_in               => RXP_I(2),
            gt2_rxpolarity_in           => RX_POLARITY_INVERT(2),
			gt3_cplllock_out            => gt_cpll_lock(3),
			gt3_rxdata_out              => LANE3_RX_DATA_O,
			gt3_rxdisperr_out           => open,
			gt3_rxnotintable_out        => open,
			gt3_gthrxn_in               => RXN_I(3),
			gt3_rxbufreset_in           => gt3_rxbufreset,
			gt3_rxbufstatus_out         => gt3_rxbufstatus,
			gt3_rxbyteisaligned_out     => gt_byte_aligned(3),
			gt3_rxbyterealign_out       => open,
			gt3_rxcommadet_out          => open,
			gt3_rxmcommaalignen_in      => '1',
			gt3_rxpcommaalignen_in      => '1',
			gt3_rxchanbondseq_out       => RX_DATA_K28_0_DETECTED_O(3),
			gt3_rxchbonden_in           => '1',
			gt3_rxchbondlevel_in        => "000",
			gt3_rxchbondmaster_in       => '0',
			gt3_rxchbondo_out           => open,
			gt3_rxchbondslave_in        => '1',
			gt3_rxchanisaligned_out     => open,
			gt3_rxchanrealign_out       => open,
			gt3_rxchariscomma_out       => open,
			gt3_rxcharisk_out           => LANE3_RX_DATA_IS_K_O,
			gt3_rxchbondi_in            => gt0_rxchbondo,
			gt3_gthrxp_in               => RXP_I(3),
            gt3_rxpolarity_in           => RX_POLARITY_INVERT(3)
		);

	GT_RXUSRCLK2_O <= gt_rxusrclk2;

	GT_CPLL_LOCK_O    <= gt_cpll_lock;
	GT_BYTE_ALIGNED_O <= gt_byte_aligned;
	GT_RX_READY_O     <= gt_rx_ready;

	gt0_rxbufreset <= '0';
	gt1_rxbufreset <= '0';
	gt2_rxbufreset <= '0';
	gt3_rxbufreset <= '0';

end Behavioral;
