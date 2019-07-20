----------------------------------------------------------------------------------
-- Company: Peralex
-- Engineers: Matthew Bridges and Francois Tolmie
-- Create Date: 24/06/2016
-- Last Modified Date: 13/11/2018
-- Module Name: ADC32RF45_11G2_RX
-- Project Name: FRM123701U1R4
-- Target Device: xc7vx690tffg1927-2
-- Description: JESD204B receiver for ADC32RF45 (LMFS=82820, 2.8 GSPS)
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ADC32RF45_11G2_RX is
	generic(
		RX_POLARITY_INVERT  : std_logic_vector(3 downto 0) := "0000"); 
	port(
		SYS_CLK_I         : in  std_logic;
		SOFT_RESET_IN     : in  std_logic;
		GTREFCLK_IN       : in  std_logic;
		RXN_I             : in  std_logic_vector(3 downto 0);
		RXP_I             : in  std_logic_vector(3 downto 0);
		ADC_SYNC_O        : out std_logic;
		GT_RXUSRCLK2_O    : out std_logic;
		AXIS_ACLK         : in  std_logic;
		AXIS_ARESETN      : in  std_logic;
		M0_AXIS_TVALID    : out std_logic;
		M0_AXIS_TREADY    : in  std_logic;
		M0_AXIS_TDATA     : out std_logic_vector(128 - 1 downto 0);
		M0_AXIS_TLAST     : out std_logic);
end ADC32RF45_11G2_RX;

architecture Behavioral of ADC32RF45_11G2_RX is

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
    axis_rd_data_count : out std_logic_vector(31 downto 0));
	end component;
	
  component ADC32RF45_11G2_RX_PHY is
  generic(RX_POLARITY_INVERT          : std_logic_vector(3 downto 0) := "0000"; 
          EXAMPLE_SIM_GTRESET_SPEEDUP : string                       := "TRUE";
          STABLE_CLOCK_PERIOD         : integer                      := 6);
  port(GTREFCLK_IN              : in  std_logic;
       SYSCLK_IN                : in  std_logic;
       SOFT_RESET_IN            : in  std_logic;
       RXP_IN                   : in  std_logic_vector(3 downto 0);
       RXN_IN                   : in  std_logic_vector(3 downto 0);     
       LANE0_RX_DATA_O          : out std_logic_vector(31 downto 0);
       LANE1_RX_DATA_O          : out std_logic_vector(31 downto 0);
       LANE2_RX_DATA_O          : out std_logic_vector(31 downto 0);
       LANE3_RX_DATA_O          : out std_logic_vector(31 downto 0);
       LANE0_RX_DATA_IS_K_O     : out std_logic_vector(3 downto 0);
       LANE1_RX_DATA_IS_K_O     : out std_logic_vector(3 downto 0);
       LANE2_RX_DATA_IS_K_O     : out std_logic_vector(3 downto 0);
       LANE3_RX_DATA_IS_K_O     : out std_logic_vector(3 downto 0);
       RX_DATA_K28_0_DETECTED_O : out std_logic_vector(3 downto 0);
       GT_BYTE_ALIGNED_O        : out std_logic_vector(3 downto 0);
       GT_RX_READY_O            : out std_logic_vector(3 downto 0);
       GT_RXUSRCLK2_O           : out std_logic);
  end component;

	signal ADC_RX_PHY_soft_reset           : std_logic;
	signal ADC_RX_PHY_soft_reset_SR        : std_logic_vector(3 downto 0);
	signal gt_rxusrclk2 : std_logic;


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
  
	signal LANE0_RX_DATA_IS_K_d2 : std_logic_vector(3 downto 0);
	signal LANE1_RX_DATA_IS_K_d2 : std_logic_vector(3 downto 0);
	signal LANE2_RX_DATA_IS_K_d2 : std_logic_vector(3 downto 0);
	signal LANE3_RX_DATA_IS_K_d2 : std_logic_vector(3 downto 0);
	signal LANE0_RX_DATA_d2      : std_logic_vector(31 downto 0);
	signal LANE1_RX_DATA_d2      : std_logic_vector(31 downto 0);
	signal LANE2_RX_DATA_d2      : std_logic_vector(31 downto 0);
	signal LANE3_RX_DATA_d2      : std_logic_vector(31 downto 0);
  
	signal LANE0_RX_DATA_d3 : std_logic_vector(31 downto 0);
	signal LANE1_RX_DATA_d3 : std_logic_vector(31 downto 0);
	signal LANE2_RX_DATA_d3 : std_logic_vector(31 downto 0);
	signal LANE3_RX_DATA_d3 : std_logic_vector(31 downto 0);
  
	signal LANE0_RX_DATA_IS_K_8byte : std_logic_vector(7 downto 0);
	signal LANE1_RX_DATA_IS_K_8byte : std_logic_vector(7 downto 0);
	signal LANE2_RX_DATA_IS_K_8byte : std_logic_vector(7 downto 0);
	signal LANE3_RX_DATA_IS_K_8byte : std_logic_vector(7 downto 0);
	signal LANE0_RX_DATA_8byte      : BYTE_ARRAY_t(7 downto 0);
	signal LANE1_RX_DATA_8byte      : BYTE_ARRAY_t(7 downto 0);
	signal LANE2_RX_DATA_8byte      : BYTE_ARRAY_t(7 downto 0);
	signal LANE3_RX_DATA_8byte      : BYTE_ARRAY_t(7 downto 0);

	signal LMFC : std_logic;
	signal frame_octet_count : unsigned(15 downto 0);

	signal s_axis_tvalid : std_logic;
	signal s_axis_tready : std_logic;
	signal s_axis_tdata  : std_logic_vector(128 - 1 downto 0);
	signal s_axis_tlast  : std_logic;
  
  signal retrieve_adc_samples : std_logic;  
  type std_logic_vector_12b_array is array (natural range <>) of std_logic_vector(11 downto 0);  
  signal adc_samples : std_logic_vector_12b_array(19 downto 0);

begin

  ADC32RF45_11G2_RX_PHY_i : ADC32RF45_11G2_RX_PHY generic map (
    RX_POLARITY_INVERT  => RX_POLARITY_INVERT)
  port map  (
    GTREFCLK_IN              => GTREFCLK_IN,
    SYSCLK_IN                => SYS_CLK_I,
    SOFT_RESET_IN            => SOFT_RESET_IN,
    RXP_IN                   => RXP_I,        
    RXN_IN                   => RXN_I,
    LANE0_RX_DATA_O          => LANE0_RX_DATA,
    LANE1_RX_DATA_O          => LANE1_RX_DATA,
    LANE2_RX_DATA_O          => LANE2_RX_DATA,
    LANE3_RX_DATA_O          => LANE3_RX_DATA,
    LANE0_RX_DATA_IS_K_O     => LANE0_RX_DATA_IS_K,
    LANE1_RX_DATA_IS_K_O     => LANE1_RX_DATA_IS_K,
    LANE2_RX_DATA_IS_K_O     => LANE2_RX_DATA_IS_K,
    LANE3_RX_DATA_IS_K_O     => LANE3_RX_DATA_IS_K,
    RX_DATA_K28_0_DETECTED_O => RX_DATA_K28_0_DETECTED,
    GT_BYTE_ALIGNED_O        => gt_byte_aligned,
    GT_RX_READY_O            => gt_rx_ready,
    GT_RXUSRCLK2_O           => gt_rxusrclk2);

	GT_RXUSRCLK2_O <= gt_rxusrclk2;

  -- <word allignment implemented by Matthew Bridges 
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
			if (LANE0_ALL_K and LANE0_ALL_K and LANE0_ALL_K and LANE0_ALL_K) then --FIX
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
				ADC_RX_PHY_soft_reset <= '0';
			end if;
			if (reset_K_count = '1') then
				K_count <= (others => '0');
			else
				K_count <= K_count + 1;
			end if;
		end if;
	end process RX_SYNC_proc;
	ADC_SYNC_O <= adc_sync;
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
  -- word allignment implemented by Matthew Bridges>

	-- delay alligned ADC data 
  ProcDelayAllignedData : process(gt_rxusrclk2) is
	begin
		if rising_edge(gt_rxusrclk2) then
      LANE0_RX_DATA_d3 <= LANE0_RX_DATA_d2;
      LANE1_RX_DATA_d3 <= LANE1_RX_DATA_d2;
      LANE2_RX_DATA_d3 <= LANE2_RX_DATA_d2;
      LANE3_RX_DATA_d3 <= LANE3_RX_DATA_d2;
		end if;
	end process ProcDelayAllignedData;
  
  -- retrieve ADC sample data from "raw" JESD204B data every second clock cycle (gt_rxusrclk2)
    -- Example:
    -- | LANE_RX_DATA_d3 | LANE_RX_DATA_d2 |
    -- |   6d 56 d6 6d   |   76 d8 6d 90   | 
    -- |   6d a6 db 6d   |   c6 dd 6d e0   | 
    -- |   6d f6 e0 6e   |   16 e2 6e 30   | 
    -- |   6e 46 e5 6e   |   66 e7 6e 80   | 
    -- Samples: 6d5 6d6 6d7 6d8 6d9 6da 6db 6dc 6dd 6de
    --          6df 6e0 6e1 6e2 6e3 6e4 6e5 6e6 6e7 6e8
  ProcRetrieveAdcSamples : process(gt_rxusrclk2) is
	begin
		if rising_edge(gt_rxusrclk2) then
      if retrieve_adc_samples = '1' then
        adc_samples(0)  <= LANE0_RX_DATA_d3(31 downto 20);
        adc_samples(1)  <= LANE0_RX_DATA_d3(19 downto 8);
        adc_samples(2)  <= LANE0_RX_DATA_d3(7  downto 0) & LANE0_RX_DATA_d2(31 downto 28);
        adc_samples(3)  <= LANE0_RX_DATA_d2(27 downto 16);
        adc_samples(4)  <= LANE0_RX_DATA_d2(15 downto 4);
        adc_samples(5)  <= LANE1_RX_DATA_d3(31 downto 20);
        adc_samples(6)  <= LANE1_RX_DATA_d3(19 downto 8);
        adc_samples(7)  <= LANE1_RX_DATA_d3(7  downto 0) & LANE1_RX_DATA_d2(31 downto 28);
        adc_samples(8)  <= LANE1_RX_DATA_d2(27 downto 16);
        adc_samples(9)  <= LANE1_RX_DATA_d2(15 downto 4);
        adc_samples(10) <= LANE2_RX_DATA_d3(31 downto 20);
        adc_samples(11) <= LANE2_RX_DATA_d3(19 downto 8);
        adc_samples(12) <= LANE2_RX_DATA_d3(7  downto 0) & LANE2_RX_DATA_d2(31 downto 28);
        adc_samples(13) <= LANE2_RX_DATA_d2(27 downto 16);
        adc_samples(14) <= LANE2_RX_DATA_d2(15 downto 4);
        adc_samples(15) <= LANE3_RX_DATA_d3(31 downto 20);
        adc_samples(16) <= LANE3_RX_DATA_d3(19 downto 8);
        adc_samples(17) <= LANE3_RX_DATA_d3(7  downto 0) & LANE3_RX_DATA_d2(31 downto 28);
        adc_samples(18) <= LANE3_RX_DATA_d2(27 downto 16);
        adc_samples(19) <= LANE3_RX_DATA_d2(15 downto 4);
      end if;     
     -- allign retrieve_adc_samples signal edge
     if (LANE0_RX_DATA_d2(7 downto 0) = X"7C" and LANE0_RX_DATA_IS_K_d2(0) = '1') then
       retrieve_adc_samples <= '0';
     else
       retrieve_adc_samples <= not retrieve_adc_samples;
     end if;
		end if;
	end process ProcRetrieveAdcSamples;

  -- select ADC samples that should be provided to FIFO
  ProcSelAdcSamples : process(gt_rxusrclk2) is
	begin
		if rising_edge(gt_rxusrclk2) then
      if retrieve_adc_samples = '0' then
        s_axis_tdata(11  downto 0)   <= adc_samples(0);
        s_axis_tdata(23  downto 12)  <= adc_samples(1);
        s_axis_tdata(35  downto 24)  <= adc_samples(2);
        s_axis_tdata(47  downto 36)  <= adc_samples(3);
        s_axis_tdata(59  downto 48)  <= adc_samples(4);
        s_axis_tdata(71  downto 60)  <= adc_samples(5);
        s_axis_tdata(83  downto 72)  <= adc_samples(6);
        s_axis_tdata(95  downto 84)  <= adc_samples(7);
        s_axis_tdata(107 downto 96)  <= adc_samples(8);
        s_axis_tdata(119 downto 108) <= adc_samples(9);
      else
        s_axis_tdata(11  downto 0)   <= adc_samples(10);
        s_axis_tdata(23  downto 12)  <= adc_samples(11);
        s_axis_tdata(35  downto 24)  <= adc_samples(12);
        s_axis_tdata(47  downto 36)  <= adc_samples(13);
        s_axis_tdata(59  downto 48)  <= adc_samples(14);
        s_axis_tdata(71  downto 60)  <= adc_samples(15);
        s_axis_tdata(83  downto 72)  <= adc_samples(16);
        s_axis_tdata(95  downto 84)  <= adc_samples(17);
        s_axis_tdata(107 downto 96)  <= adc_samples(18);
        s_axis_tdata(119 downto 108) <= adc_samples(19);
      end if;
		end if;
	end process ProcSelAdcSamples;
  
  -- FIFO used to synchronise multiple ADC32RF45_11G2_RX cores
	ADC_AXIS_ASYNC_FIFO_inst : component ADC_AXIS_ASYNC_FIFO port map(
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
    axis_rd_data_count => open);
    
end Behavioral;