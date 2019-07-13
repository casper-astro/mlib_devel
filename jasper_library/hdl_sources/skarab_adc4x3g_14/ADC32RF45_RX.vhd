----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.06.2016 10:19:42
-- Design Name: 
-- Module Name: ADC32RF45_RX - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ADC32RF45_RX is
	generic(
		STABLE_CLOCK_PERIOD : integer := 6;
		C_AXIS_TDATA_WIDTH  : integer := 128;
		RX_POLARITY_INVERT  : std_logic_vector(3 downto 0) := "0000" -- GT 17/01/2017 PROVIDE OPTION OF SETTING INVERTING POLARITY
	);
	port(
		SYS_CLK_I         : in  std_logic;
		SOFT_RESET_IN     : in  std_logic;
		GTREFCLK_IN       : in  std_logic;
		RXN_I             : in  std_logic_vector(3 downto 0);
		RXP_I             : in  std_logic_vector(3 downto 0);
		ADC_SYNC_O        : out std_logic;
		GT_RXUSRCLK2_O    : out std_logic;
		-- Master Stream Ports.
		DBG_M_AXIS_TVALID : out std_logic;
		DBG_M_AXIS_TREADY : in  std_logic;
		DBG_M_AXIS_TDATA  : out std_logic_vector(C_AXIS_TDATA_WIDTH - 1 downto 0);
		DBG_M_AXIS_TLAST  : out std_logic;
		-- Ports of Axi Master Bus Interface M00_AXIS
		-- Global ports
		AXIS_ACLK         : in  std_logic;
		AXIS_ARESETN      : in  std_logic;
		-- Master Stream Ports.
		M0_AXIS_TVALID    : out std_logic;
		M0_AXIS_TREADY    : in  std_logic;
		M0_AXIS_TDATA     : out std_logic_vector(C_AXIS_TDATA_WIDTH - 1 downto 0);
		M0_AXIS_TLAST     : out std_logic

	--		m00_axis_tstrb   : out std_logic_vector((C_M00_AXIS_TDATA_WIDTH / 8) - 1 downto 0);
	);

end ADC32RF45_RX;

architecture Behavioral of ADC32RF45_RX is
	component ADC32RF45_RX_PHY is
		generic(
			STABLE_CLOCK_PERIOD : integer := 6;
		    RX_POLARITY_INVERT  : std_logic_vector(3 downto 0) := "0000" -- GT 17/01/2017 PROVIDE OPTION OF SETTING INVERTING POLARITY
		);
		Port(
			SYS_CLK_I                : in  std_logic;
			SOFT_RESET_IN            : in  std_logic;
			GTREFCLK_IN              : in  std_logic;
			RXN_I                    : in  std_logic_vector(3 downto 0);
			RXP_I                    : in  std_logic_vector(3 downto 0);
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
			GT_CPLL_LOCK_O           : out std_logic_vector(3 downto 0);
			GT_BYTE_ALIGNED_O        : out std_logic_vector(3 downto 0);
			GT_RX_READY_O            : out std_logic_vector(3 downto 0)
		);
	end component ADC32RF45_RX_PHY;

--	component ADC32RF45_RX_PHY_ILA
--		port(
--			clk     : in std_logic;
--			probe0  : in std_logic_vector(3 downto 0);
--			probe1  : in std_logic_vector(31 downto 0);
--			probe2  : in std_logic_vector(3 downto 0);
--			probe3  : in std_logic_vector(31 downto 0);
--			probe4  : in std_logic_vector(3 downto 0);
--			probe5  : in std_logic_vector(31 downto 0);
--			probe6  : in std_logic_vector(3 downto 0);
--			probe7  : in std_logic_vector(31 downto 0);
--			probe8  : in std_logic_vector(3 downto 0);
--			probe9  : in std_logic_vector(4 downto 0);
--			probe10 : in std_logic_vector(1 downto 0);
--			probe11 : in std_logic_vector(0 downto 0);
--			probe12 : in std_logic_vector(0 downto 0);
--			probe13 : in std_logic_vector(0 downto 0);
--			probe14 : in std_logic_vector(0 downto 0)
--		);
--	end component;

--	component ADC32RF45_RX_PHY_VIO
--		port(
--			clk        : in  std_logic;
--			probe_in0  : in  std_logic_vector(3 downto 0);
--			probe_in1  : in  std_logic_vector(0 downto 0);
--			probe_in2  : in  std_logic_vector(0 downto 0);
--			probe_in3  : in  std_logic_vector(0 downto 0);
--			probe_in4  : in  std_logic_vector(0 downto 0);
--			probe_in5  : in  std_logic_vector(5 downto 0);
--			probe_in6  : in  std_logic_vector(7 downto 0);
--			probe_in7  : in  std_logic_vector(4 downto 0);
--			probe_in8  : in  std_logic_vector(4 downto 0);
--			probe_in9  : in  std_logic_vector(4 downto 0);
--			probe_in10 : in  std_logic_vector(4 downto 0);
--			probe_out0 : out std_logic_vector(0 downto 0);
--			probe_out1 : out std_logic_vector(0 downto 0);
--			probe_out2 : out std_logic_vector(0 downto 0)
--		);
--	end component;

	component PRBS31_PATTERN_GENERATOR is
		Generic(
			INITIAL_SEED_VALUE : std_logic_vector(30 downto 0) := (10 => '1', others => '0');
			C_AXIS_TDATA_WIDTH : integer                       := 256
		);
		Port(
			-- Ports of Axi Master Bus Interface M00_AXIS
			-- Global ports
			AXIS_ACLK      : in  std_logic;
			AXIS_ARESETN   : in  std_logic;
			-- Master Stream Ports.
			M0_AXIS_TVALID : out std_logic;
			M0_AXIS_TREADY : in  std_logic;
			M0_AXIS_TDATA  : out std_logic_vector(C_AXIS_TDATA_WIDTH - 1 downto 0);
			M0_AXIS_TLAST  : out std_logic;
			ENABLE_I       : in  std_logic
		);
	end component PRBS31_PATTERN_GENERATOR;

	component ADC_AXIS_ASYNC_FIFO
		port(
			s_axis_aclk        : in  std_logic;
			s_axis_aresetn     : in  std_logic;
			s_axis_tvalid      : in  std_logic;
			s_axis_tready      : out std_logic;
			s_axis_tdata       : in  std_logic_vector(127 downto 0);
			s_axis_tlast       : in  std_logic;
			m_axis_aclk        : in  std_logic;
			m_axis_aresetn     : in  std_logic;
			m_axis_tvalid      : out std_logic;
			m_axis_tready      : in  std_logic;
			m_axis_tdata       : out std_logic_vector(127 downto 0);
			m_axis_tlast       : out std_logic;
			axis_data_count    : out std_logic_vector(31 downto 0);
			axis_wr_data_count : out std_logic_vector(31 downto 0);
			axis_rd_data_count : out std_logic_vector(31 downto 0)
		);
	end component;

	signal ADC_RX_PHY_soft_reset_chipscope : std_logic;
	signal ADC_RX_PHY_soft_reset           : std_logic;
	signal ADC_RX_PHY_soft_reset_SR        : std_logic_vector(3 downto 0);

	signal gt_rxusrclk2 : std_logic;

	signal gt_cpll_lock    : std_logic_vector(3 downto 0);
	signal gt_byte_aligned : std_logic_vector(3 downto 0);
	signal gt_rx_ready     : std_logic_vector(3 downto 0);

	signal LANE0_RX_DATA_IS_K : std_logic_vector(3 downto 0);
	signal LANE0_RX_DATA      : std_logic_vector(31 downto 0);
	signal LANE1_RX_DATA_IS_K : std_logic_vector(3 downto 0);
	signal LANE1_RX_DATA      : std_logic_vector(31 downto 0);
	signal LANE2_RX_DATA_IS_K : std_logic_vector(3 downto 0);
	signal LANE2_RX_DATA      : std_logic_vector(31 downto 0);
	signal LANE3_RX_DATA_IS_K : std_logic_vector(3 downto 0);
	signal LANE3_RX_DATA      : std_logic_vector(31 downto 0);

	signal reset_RX_SYNC      : std_logic;
	signal reset_RX_SYNC_SR   : std_logic_vector(2 downto 0);
	signal adc_sync           : std_logic;
	signal adc_sync_chipscope : std_logic;

	signal LANE0_ALL_K : boolean;
	signal LANE1_ALL_K : boolean;
	signal LANE2_ALL_K : boolean;
	signal LANE3_ALL_K : boolean;

	signal LANE0123_ALL_K : std_logic;

	signal reset_K_count : std_logic;
	signal K_count       : unsigned(5 downto 0);

	signal inc_not_K_count : std_logic;
	signal not_K_count     : unsigned(7 downto 0);

	signal LANE0_RX_DATA_IS_K_ext : std_logic_vector(4 downto 0);

	signal LANE0_RX_Q_DETECTED_SR : std_logic_vector(4 downto 0);

	signal LANE0_JESD204_LID : std_logic_vector(4 downto 0);
	signal LANE1_JESD204_LID : std_logic_vector(4 downto 0);
	signal LANE2_JESD204_LID : std_logic_vector(4 downto 0);
	signal LANE3_JESD204_LID : std_logic_vector(4 downto 0);

	signal RX_DATA_K28_0_DETECTED : std_logic_vector(3 downto 0);

	signal word_alignment_ptr : unsigned(1 downto 0) := (others => '0');

	subtype BYTE_t is std_logic_vector(7 downto 0); -- Equivalent to an Octet
	type BYTE_ARRAY_t is array (natural range <>) of BYTE_t;

	signal LANE0_RX_DATA_IS_K_d0 : std_logic_vector(3 downto 0);
	signal LANE1_RX_DATA_IS_K_d0 : std_logic_vector(3 downto 0);
	signal LANE2_RX_DATA_IS_K_d0 : std_logic_vector(3 downto 0);
	signal LANE3_RX_DATA_IS_K_d0 : std_logic_vector(3 downto 0);
	signal LANE0_RX_DATA_d0      : BYTE_ARRAY_t(3 downto 0);
	signal LANE1_RX_DATA_d0      : BYTE_ARRAY_t(3 downto 0);
	signal LANE2_RX_DATA_d0      : BYTE_ARRAY_t(3 downto 0);
	signal LANE3_RX_DATA_d0      : BYTE_ARRAY_t(3 downto 0);

	signal LANE0_RX_DATA_IS_K_d1 : std_logic_vector(3 downto 0);
	signal LANE1_RX_DATA_IS_K_d1 : std_logic_vector(3 downto 0);
	signal LANE2_RX_DATA_IS_K_d1 : std_logic_vector(3 downto 0);
	signal LANE3_RX_DATA_IS_K_d1 : std_logic_vector(3 downto 0);
	signal LANE0_RX_DATA_d1      : BYTE_ARRAY_t(3 downto 0);
	signal LANE1_RX_DATA_d1      : BYTE_ARRAY_t(3 downto 0);
	signal LANE2_RX_DATA_d1      : BYTE_ARRAY_t(3 downto 0);
	signal LANE3_RX_DATA_d1      : BYTE_ARRAY_t(3 downto 0);

	signal LANE0_RX_DATA_IS_K_8byte : std_logic_vector(7 downto 0);
	signal LANE1_RX_DATA_IS_K_8byte : std_logic_vector(7 downto 0);
	signal LANE2_RX_DATA_IS_K_8byte : std_logic_vector(7 downto 0);
	signal LANE3_RX_DATA_IS_K_8byte : std_logic_vector(7 downto 0);
	signal LANE0_RX_DATA_8byte      : BYTE_ARRAY_t(7 downto 0);
	signal LANE1_RX_DATA_8byte      : BYTE_ARRAY_t(7 downto 0);
	signal LANE2_RX_DATA_8byte      : BYTE_ARRAY_t(7 downto 0);
	signal LANE3_RX_DATA_8byte      : BYTE_ARRAY_t(7 downto 0);

	signal LANE0_RX_DATA_IS_K_d2 : std_logic_vector(3 downto 0);
	signal LANE1_RX_DATA_IS_K_d2 : std_logic_vector(3 downto 0);
	signal LANE2_RX_DATA_IS_K_d2 : std_logic_vector(3 downto 0);
	signal LANE3_RX_DATA_IS_K_d2 : std_logic_vector(3 downto 0);
	signal LANE0_RX_DATA_d2      : std_logic_vector(31 downto 0);
	signal LANE1_RX_DATA_d2      : std_logic_vector(31 downto 0);
	signal LANE2_RX_DATA_d2      : std_logic_vector(31 downto 0);
	signal LANE3_RX_DATA_d2      : std_logic_vector(31 downto 0);

	signal LMFC : std_logic;

	signal frame_octet_count : unsigned(15 downto 0);

	signal USE_PRBS : std_logic;

	signal PRBS_axis_tvalid : std_logic;
	signal PRBS_axis_tready : std_logic := '0';
	signal PRBS_axis_tdata  : std_logic_vector(C_AXIS_TDATA_WIDTH - 1 downto 0);
	signal PRBS_axis_tlast  : std_logic;

	signal s_axis_tvalid : std_logic;
	signal s_axis_tready : std_logic;
	signal s_axis_tdata  : std_logic_vector(C_AXIS_TDATA_WIDTH - 1 downto 0);
	signal s_axis_tlast  : std_logic;

begin
	ADC_PHY_inst : component ADC32RF45_RX_PHY
		generic map(
			STABLE_CLOCK_PERIOD => 8,
		    RX_POLARITY_INVERT  => RX_POLARITY_INVERT -- GT 17/01/2017 PROVIDE OPTION OF SETTING INVERTING POLARITY
		)
		port map(
			SYS_CLK_I                => SYS_CLK_I,
			SOFT_RESET_IN            => ADC_RX_PHY_soft_reset_SR(3),
			GTREFCLK_IN              => GTREFCLK_IN,
			RXN_I                    => RXN_I,
			RXP_I                    => RXP_I,
			GT_RXUSRCLK2_O           => gt_rxusrclk2,
			LANE0_RX_DATA_IS_K_O     => LANE0_RX_DATA_IS_K,
			LANE0_RX_DATA_O          => LANE0_RX_DATA,
			LANE1_RX_DATA_IS_K_O     => LANE1_RX_DATA_IS_K,
			LANE1_RX_DATA_O          => LANE1_RX_DATA,
			LANE2_RX_DATA_IS_K_O     => LANE2_RX_DATA_IS_K,
			LANE2_RX_DATA_O          => LANE2_RX_DATA,
			LANE3_RX_DATA_IS_K_O     => LANE3_RX_DATA_IS_K,
			LANE3_RX_DATA_O          => LANE3_RX_DATA,
			RX_DATA_K28_0_DETECTED_O => RX_DATA_K28_0_DETECTED,
			GT_CPLL_LOCK_O           => gt_cpll_lock,
			GT_BYTE_ALIGNED_O        => gt_byte_aligned,
			GT_RX_READY_O            => gt_rx_ready
		);

	GT_RXUSRCLK2_O <= gt_rxusrclk2;

	LANE0_RX_DATA_IS_K_ext(4 downto 1) <= LANE0_RX_DATA_IS_K;

	WORD_ALIGNMENT_PTR_proc : process(gt_rxusrclk2) is
	begin
		if rising_edge(gt_rxusrclk2) then
			LANE0_RX_DATA_IS_K_ext(0) <= LANE0_RX_DATA_IS_K(3);
			if gt_byte_aligned(0) = '0' then
				word_alignment_ptr <= "00";
			else
				if (RX_DATA_K28_0_DETECTED(0) = '1') then
					case LANE0_RX_DATA_IS_K_ext is
						when "11111" => word_alignment_ptr <= "11"; --=RKKKK,
						when "01111" => word_alignment_ptr <= "10"; --=DRKKK,
						when "00111" => word_alignment_ptr <= "00"; --!DDRKK, =DDQRA
						when "00011" => word_alignment_ptr <= "00"; --=DDDRK, =DDDRA
						when "00110" => word_alignment_ptr <= "01"; --=DDRAD
						when "01110" => word_alignment_ptr <= "01"; --=DQRAD
						when "01100" => word_alignment_ptr <= "10"; --=DRADD
						when "11100" => word_alignment_ptr <= "10"; --=QRADD
						when "11000" => word_alignment_ptr <= "11"; --=RADDD
						when others  => word_alignment_ptr <= word_alignment_ptr;
					end case;
				end if;
			end if;

			case LANE0_RX_DATA_IS_K_ext is
				--when "00011" => LANE0_RX_Q_DETECTED <= RX_DATA_K28_0_DETECTED_d1(0); --=DDDQR
				when "00111" => LANE0_RX_Q_DETECTED_SR(0) <= RX_DATA_K28_0_DETECTED(0); --!DDRKK, =DDQRA
				when "01110" => LANE0_RX_Q_DETECTED_SR(0) <= RX_DATA_K28_0_DETECTED(0); --=DQRAD
				when "11100" => LANE0_RX_Q_DETECTED_SR(0) <= RX_DATA_K28_0_DETECTED(0); --=QRADD
				when others  => LANE0_RX_Q_DETECTED_SR(0) <= '0';
			end case;

			LANE0_RX_Q_DETECTED_SR(4 downto 1) <= LANE0_RX_Q_DETECTED_SR(3 downto 0);
		end if;
	end process WORD_ALIGNMENT_PTR_proc;

	bytes : for i in 0 to 3 generate
	begin
		LANE0_RX_DATA_IS_K_d0(i) <= LANE0_RX_DATA_IS_K(3 - i);
		LANE1_RX_DATA_IS_K_d0(i) <= LANE1_RX_DATA_IS_K(3 - i);
		LANE2_RX_DATA_IS_K_d0(i) <= LANE2_RX_DATA_IS_K(3 - i);
		LANE3_RX_DATA_IS_K_d0(i) <= LANE3_RX_DATA_IS_K(3 - i);
		LANE0_RX_DATA_d0(i)      <= LANE0_RX_DATA((((3 - i) * 8) + 7) downto (3 - i) * 8);
		LANE1_RX_DATA_d0(i)      <= LANE1_RX_DATA((((3 - i) * 8) + 7) downto (3 - i) * 8);
		LANE2_RX_DATA_d0(i)      <= LANE2_RX_DATA((((3 - i) * 8) + 7) downto (3 - i) * 8);
		LANE3_RX_DATA_d0(i)      <= LANE3_RX_DATA((((3 - i) * 8) + 7) downto (3 - i) * 8);
	end generate bytes;

	RX_DATA_d1_REG_proc : process(gt_rxusrclk2) is
	begin
		if rising_edge(gt_rxusrclk2) then
			LANE0_RX_DATA_IS_K_d1 <= LANE0_RX_DATA_IS_K_d0;
			LANE1_RX_DATA_IS_K_d1 <= LANE1_RX_DATA_IS_K_d0;
			LANE2_RX_DATA_IS_K_d1 <= LANE2_RX_DATA_IS_K_d0;
			LANE3_RX_DATA_IS_K_d1 <= LANE3_RX_DATA_IS_K_d0;
			LANE0_RX_DATA_d1      <= LANE0_RX_DATA_d0;
			LANE1_RX_DATA_d1      <= LANE1_RX_DATA_d0;
			LANE2_RX_DATA_d1      <= LANE2_RX_DATA_d0;
			LANE3_RX_DATA_d1      <= LANE3_RX_DATA_d0;
		end if;
	end process RX_DATA_d1_REG_proc;

	LANE0_RX_DATA_IS_K_8byte <= LANE0_RX_DATA_IS_K_d1 & LANE0_RX_DATA_IS_K_d0;
	LANE1_RX_DATA_IS_K_8byte <= LANE1_RX_DATA_IS_K_d1 & LANE1_RX_DATA_IS_K_d0;
	LANE2_RX_DATA_IS_K_8byte <= LANE2_RX_DATA_IS_K_d1 & LANE2_RX_DATA_IS_K_d0;
	LANE3_RX_DATA_IS_K_8byte <= LANE3_RX_DATA_IS_K_d1 & LANE3_RX_DATA_IS_K_d0;
	LANE0_RX_DATA_8byte      <= LANE0_RX_DATA_d1 & LANE0_RX_DATA_d0;
	LANE1_RX_DATA_8byte      <= LANE1_RX_DATA_d1 & LANE1_RX_DATA_d0;
	LANE2_RX_DATA_8byte      <= LANE2_RX_DATA_d1 & LANE2_RX_DATA_d0;
	LANE3_RX_DATA_8byte      <= LANE3_RX_DATA_d1 & LANE3_RX_DATA_d0;

	RX_DATA_d2_REG_bytes : for i in 0 to 3 generate
	begin
		RX_DATA_d2_REG_proc : process(gt_rxusrclk2) is
		begin
			if rising_edge(gt_rxusrclk2) then
				LANE0_RX_DATA_IS_K_d2(i)                     <= LANE0_RX_DATA_IS_K_8byte(4 + i - to_integer(word_alignment_ptr));
				LANE1_RX_DATA_IS_K_d2(i)                     <= LANE1_RX_DATA_IS_K_8byte(4 + i - to_integer(word_alignment_ptr));
				LANE2_RX_DATA_IS_K_d2(i)                     <= LANE2_RX_DATA_IS_K_8byte(4 + i - to_integer(word_alignment_ptr));
				LANE3_RX_DATA_IS_K_d2(i)                     <= LANE3_RX_DATA_IS_K_8byte(4 + i - to_integer(word_alignment_ptr));
				LANE0_RX_DATA_d2(((i * 8) + 7) downto i * 8) <= LANE0_RX_DATA_8byte(4 + i - to_integer(word_alignment_ptr));
				LANE1_RX_DATA_d2(((i * 8) + 7) downto i * 8) <= LANE1_RX_DATA_8byte(4 + i - to_integer(word_alignment_ptr));
				LANE2_RX_DATA_d2(((i * 8) + 7) downto i * 8) <= LANE2_RX_DATA_8byte(4 + i - to_integer(word_alignment_ptr));
				LANE3_RX_DATA_d2(((i * 8) + 7) downto i * 8) <= LANE3_RX_DATA_8byte(4 + i - to_integer(word_alignment_ptr));
			end if;
		end process RX_DATA_d2_REG_proc;
	end generate RX_DATA_d2_REG_bytes;

	--	ADC_PHY_DEBUG_ILA_inst : component ADC32RF45_RX_PHY_ILA
	--		port map(
	--			clk        => gt_rxusrclk2,
	--			probe0     => LANE0_RX_DATA_IS_K_d2,
	--			probe1     => LANE0_RX_DATA_d2,
	--			probe2     => LANE1_RX_DATA_IS_K_d2,
	--			probe3     => LANE1_RX_DATA_d2,
	--			probe4     => LANE2_RX_DATA_IS_K_d2,
	--			probe5     => LANE2_RX_DATA_d2,
	--			probe6     => LANE3_RX_DATA_IS_K_d2,
	--			probe7     => LANE3_RX_DATA_d2,
	--			probe8     => RX_DATA_K28_0_DETECTED,
	--			probe9     => LANE0_RX_DATA_IS_K_ext,
	--			probe10    => std_logic_vector(word_alignment_ptr),
	--			probe11(0) => LMFC,
	--			probe12(0) => s_axis_tlast,
	--			probe13(0) => LANE0_RX_Q_DETECTED_SR(2), --s_axis_tready,
	--			probe14(0) => s_axis_tvalid
	--		);

	JESD204_CONFIG_DATA_CAPTURE_proc : process(gt_rxusrclk2) is
	begin
		if rising_edge(gt_rxusrclk2) then
			if LANE0_RX_Q_DETECTED_SR(2) = '1' then
				LANE0_JESD204_LID <= LANE0_RX_DATA_d2(4 * 8 - 4 downto 3 * 8);
				LANE1_JESD204_LID <= LANE1_RX_DATA_d2(4 * 8 - 4 downto 3 * 8);
				LANE2_JESD204_LID <= LANE2_RX_DATA_d2(4 * 8 - 4 downto 3 * 8);
				LANE3_JESD204_LID <= LANE3_RX_DATA_d2(4 * 8 - 4 downto 3 * 8);

			end if;
		end if;
	end process JESD204_CONFIG_DATA_CAPTURE_proc;

--	ADC_PHY_DEBUG_VIO_inst : component ADC32RF45_RX_PHY_VIO
--		port map(
--			clk           => gt_rxusrclk2,
--			probe_in0     => gt_cpll_lock,
--			probe_in1(0)  => reset_RX_SYNC_SR(2),
--			probe_in2(0)  => reset_K_count,
--			probe_in3(0)  => inc_not_K_count,
--			probe_in4(0)  => adc_sync,
--			probe_in5     => std_logic_vector(K_count),
--			probe_in6     => std_logic_vector(not_K_count),
--			probe_in7     => LANE0_JESD204_LID,
--			probe_in8     => LANE1_JESD204_LID,
--			probe_in9     => LANE2_JESD204_LID,
--			probe_in10    => LANE3_JESD204_LID,
--			probe_out0(0) => ADC_RX_PHY_soft_reset_chipscope,
--			probe_out1(0) => adc_sync_chipscope,
--			probe_out2(0) => USE_PRBS
--		);

    ADC_RX_PHY_soft_reset_chipscope <= '0';
    adc_sync_chipscope <= '0';
    USE_PRBS <= '0';

	reset_RX_SYNC_proc : process(SYS_CLK_I) is
	begin
		if rising_edge(SYS_CLK_I) then
			if (gt_rx_ready = x"F") then
				reset_RX_SYNC <= '0';
			else
				reset_RX_SYNC <= '1';
			end if;
		end if;
	end process reset_RX_SYNC_proc;

	reset_RX_SYNC_SR_proc : process(gt_rxusrclk2, reset_RX_SYNC) is
	begin
		if reset_RX_SYNC = '1' then
			reset_RX_SYNC_SR <= (others => '1');
		elsif rising_edge(gt_rxusrclk2) then
			reset_RX_SYNC_SR(0)          <= '0';
			reset_RX_SYNC_SR(2 downto 1) <= reset_RX_SYNC_SR(1 downto 0);
		end if;
	end process reset_RX_SYNC_SR_proc;

	ADC_RX_PHY_soft_reset_SR_proc : process(SYS_CLK_I, ADC_RX_PHY_soft_reset) is
	begin
		if ADC_RX_PHY_soft_reset = '1' then
			ADC_RX_PHY_soft_reset_SR <= (others => '1');
		elsif rising_edge(SYS_CLK_I) then
			ADC_RX_PHY_soft_reset_SR(0)          <= SOFT_RESET_IN;
			ADC_RX_PHY_soft_reset_SR(3 downto 1) <= ADC_RX_PHY_soft_reset_SR(2 downto 0);
		end if;
	end process ADC_RX_PHY_soft_reset_SR_proc;

	RX_SYNC_proc : process(gt_rxusrclk2) is
	begin
		if rising_edge(gt_rxusrclk2) then
			LANE0_ALL_K <= (LANE0_RX_DATA_IS_K = x"F");
			LANE1_ALL_K <= (LANE0_RX_DATA_IS_K = x"F");
			LANE2_ALL_K <= (LANE0_RX_DATA_IS_K = x"F");
			LANE3_ALL_K <= (LANE0_RX_DATA_IS_K = x"F");

			if (LANE0_ALL_K and LANE0_ALL_K and LANE0_ALL_K and LANE0_ALL_K) then
				LANE0123_ALL_K <= '1';
			else
				LANE0123_ALL_K <= '0';
			end if;

			if reset_RX_SYNC_SR(2) = '1' then
				reset_K_count   <= '1';
				inc_not_K_count <= '0';
				adc_sync        <= '1';
				not_K_count     <= (others => '0');
			else
				if (LANE0123_ALL_K = '1') then
					reset_K_count   <= '0';
					inc_not_K_count <= '0';
				else
					reset_K_count   <= '1';
					inc_not_K_count <= adc_sync;
				end if;

				if (K_count > 15) then
					adc_sync <= '0';
				end if;

				if (inc_not_K_count = '1') then
					not_K_count <= not_K_count + 1;
				end if;

			end if;

			if (not_K_count = "11111111") then
				ADC_RX_PHY_soft_reset <= adc_sync;
			else
				ADC_RX_PHY_soft_reset <= ADC_RX_PHY_soft_reset_chipscope;
			end if;

			if (reset_K_count = '1') then
				K_count <= (others => '0');
			else
				K_count <= K_count + 1;
			end if;
		end if;
	end process RX_SYNC_proc;

	ADC_SYNC_O <= adc_sync or adc_sync_chipscope;

	name : process(gt_rxusrclk2) is
	begin
		if rising_edge(gt_rxusrclk2) then
			if RX_DATA_K28_0_DETECTED(0) = '1' then
				frame_octet_count <= (3 => '1', 4 => '1', others => '0');
			else
				if frame_octet_count = ((64 * (16 / 2)) - 1) then
					frame_octet_count <= (others => '0');
				else
					frame_octet_count <= frame_octet_count + 1;
				end if;
			end if;
			if frame_octet_count(2 downto 0) = (16 / 2 - 1) then
				LMFC <= '0';
			else
				LMFC <= '1';
			end if;

			if frame_octet_count = (64 * (16 / 2) - 1) then
				s_axis_tlast <= '1';
			else
				s_axis_tlast <= '0';
			end if;

			if (s_axis_tlast) = '1' then
				s_axis_tvalid <= s_axis_tready;
			end if;
		end if;
	end process name;

	-- Check order and check for 1 cycle latency
	name2 : process(gt_rxusrclk2) is
	begin
		if rising_edge(gt_rxusrclk2) then
			if (USE_PRBS = '1') then
				s_axis_tdata <= PRBS_axis_tdata;
			else
				s_axis_tdata(15 downto 0)    <= LANE0_RX_DATA_d2(31 downto 16);
				s_axis_tdata(31 downto 16)   <= LANE2_RX_DATA_d2(31 downto 16);
				s_axis_tdata(47 downto 32)   <= LANE1_RX_DATA_d2(31 downto 16);
				s_axis_tdata(63 downto 48)   <= LANE3_RX_DATA_d2(31 downto 16);
				s_axis_tdata(79 downto 64)   <= LANE0_RX_DATA_d2(15 downto 0);
				s_axis_tdata(95 downto 80)   <= LANE2_RX_DATA_d2(15 downto 0);
				s_axis_tdata(111 downto 96)  <= LANE1_RX_DATA_d2(15 downto 0);
				s_axis_tdata(127 downto 112) <= LANE3_RX_DATA_d2(15 downto 0);
			end if;
		end if;
	end process name2;

	DEBUG_PRBS_inst : component PRBS31_PATTERN_GENERATOR
		generic map(
			C_AXIS_TDATA_WIDTH => C_AXIS_TDATA_WIDTH
		)
		port map(
			AXIS_ACLK      => gt_rxusrclk2,
			AXIS_ARESETN   => '1',
			M0_AXIS_TVALID => PRBS_axis_tvalid,
			M0_AXIS_TREADY => PRBS_axis_tready,
			M0_AXIS_TDATA  => PRBS_axis_tdata,
			M0_AXIS_TLAST  => PRBS_axis_tlast,
			ENABLE_I       => '1'
		);

	PRBS_axis_tready <= '1';

	ADC_AXIS_ASYNC_FIFO_inst : component ADC_AXIS_ASYNC_FIFO
		port map(
			s_axis_aclk        => gt_rxusrclk2,
			s_axis_aresetn     => '1',
			s_axis_tvalid      => s_axis_tvalid,
			s_axis_tready      => s_axis_tready,
			s_axis_tdata       => s_axis_tdata,
			s_axis_tlast       => s_axis_tlast,
			m_axis_aclk        => AXIS_ACLK,
			m_axis_aresetn     => AXIS_ARESETN,
			m_axis_tvalid      => M0_AXIS_TVALID,
			m_axis_tready      => M0_AXIS_TREADY,
			m_axis_tdata       => M0_AXIS_TDATA,
			m_axis_tlast       => M0_AXIS_TLAST,
			axis_data_count    => open,
			axis_wr_data_count => open,
			axis_rd_data_count => open
		);

	DBG_AXIS_REGISTER_proc : process(gt_rxusrclk2) is
	begin
		if rising_edge(gt_rxusrclk2) then
			DBG_M_AXIS_TVALID <= s_axis_tvalid;
			DBG_M_AXIS_TDATA  <= s_axis_tdata;
			DBG_M_AXIS_TLAST  <= s_axis_tlast;
		end if;
	end process DBG_AXIS_REGISTER_proc;

end Behavioral;
