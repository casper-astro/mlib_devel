------------------------------------------------------------------------------
-- FILE NAME            : skarab_adc4x3g_14_byp.vhd
------------------------------------------------------------------------------
-- COMPANY              : PERALEX ELECTRONICS (PTY) LTD
------------------------------------------------------------------------------
-- COPYRIGHT NOTICE :
--
-- The copyright, manufacturing and patent rights stemming from this document
-- in any form are vested in PERALEX ELECTRONICS (PTY) LTD.
--
-- (c) PERALEX ELECTRONICS (PTY) LTD 2021
--
-- PERALEX ELECTRONICS (PTY) LTD has ceded these rights to its clients
-- where contractually agreed.
------------------------------------------------------------------------------
-- DESCRIPTION :
--	 This component is a data RX for the SKARAB ADC32RF45X2 board.
--   It is intended to be used in the CASPER Toolflow.
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

library unisim;
use unisim.vcomponents.all;

entity SKARAB_ADC4x3G_14_BYP is
	port(
        FREE_RUN_156M25HZ_CLK_IN : in std_logic;
        FREE_RUN_156M25HZ_RST_IN : in std_logic;
	   	
        MEZZANINE_RESET : out std_logic;
        MEZZANINE_CLK_SEL : out std_logic;
        MEZZANINE_FAULT_N : in std_logic;
		
        ADC_MEZ_REFCLK_0_P : in std_logic;
        ADC_MEZ_REFCLK_0_N : in std_logic;       
        ADC_MEZ_PHY11_LANE_RX_P : in std_logic_vector(3 downto 0);
        ADC_MEZ_PHY11_LANE_RX_N : in std_logic_vector(3 downto 0);
       
        ADC_MEZ_REFCLK_1_P : in std_logic;
        ADC_MEZ_REFCLK_1_N : in std_logic;       
        ADC_MEZ_PHY12_LANE_RX_P : in std_logic_vector(3 downto 0);
        ADC_MEZ_PHY12_LANE_RX_N : in std_logic_vector(3 downto 0);

        ADC_MEZ_REFCLK_2_P : in std_logic;
        ADC_MEZ_REFCLK_2_N : in std_logic;       
        ADC_MEZ_PHY21_LANE_RX_P : in std_logic_vector(3 downto 0);
        ADC_MEZ_PHY21_LANE_RX_N : in std_logic_vector(3 downto 0);
       
        ADC_MEZ_REFCLK_3_P : in std_logic;
        ADC_MEZ_REFCLK_3_N : in std_logic;       
        ADC_MEZ_PHY22_LANE_RX_P : in std_logic_vector(3 downto 0);
        ADC_MEZ_PHY22_LANE_RX_N : in std_logic_vector(3 downto 0);

        DSP_CLK_IN : in std_logic;
        DSP_RST_IN : in std_logic;
		
        ADC0_DATA_VAL_OUT : out std_logic;
        ADC0_DATA_OUT : out std_logic_vector(191 downto 0);
        ADC1_DATA_VAL_OUT : out std_logic;
        ADC1_DATA_OUT : out std_logic_vector(191 downto 0);
        ADC2_DATA_VAL_OUT : out std_logic;
        ADC2_DATA_OUT : out std_logic_vector(191 downto 0);
        ADC3_DATA_VAL_OUT : out std_logic;
        ADC3_DATA_OUT : out std_logic_vector(191 downto 0);

        ADC_SYNC_START_IN : in std_logic;
		ADC_SYNC_PART2_START_IN : in std_logic;
		ADC_SYNC_PART3_START_IN : in std_logic;
        ADC_SYNC_COMPLETE_OUT : out std_logic;
		ADC_SYNC_REQUEST_OUT : out std_logic_vector(3 downto 0);
        ADC_TRIGGER_OUT : out std_logic;
        PLL_SYNC_START_IN : in std_logic;
        PLL_PULSE_GEN_START_IN  : in std_logic;
		PLL_SYNC_COMPLETE_OUT : out std_logic;
        
        MEZZ_ID : out std_logic_vector(2 downto 0);
        MEZZ_PRESENT : out std_logic; 
		
		MEZZANINE_RESET_IN : in std_logic;
        
        AUX_CLK_P : in std_logic;
        AUX_CLK_N : in std_logic;
        AUX_SYNCI_P : in std_logic;
        AUX_SYNCI_N : in std_logic;
        AUX_SYNCO_P : out std_logic;
        AUX_SYNCO_N : out std_logic;
		
        ADC_DATA_CLOCK_OUT : out std_logic;
        ADC_DATA_RESET_OUT : out std_logic;
		
		ADC0_STATUS_OUT : out std_logic_vector(31 downto 0);
		ADC1_STATUS_OUT : out std_logic_vector(31 downto 0);
		ADC2_STATUS_OUT : out std_logic_vector(31 downto 0);
		ADC3_STATUS_OUT : out std_logic_vector(31 downto 0));
end SKARAB_ADC4x3G_14_BYP;

architecture arch_SKARAB_ADC4x3G_14_BYP of SKARAB_ADC4x3G_14_BYP is

	constant C_ADC_AXIS_TDATA_WIDTH : integer := 128;
	
    component ADC32RF45_11G2_RX is
	generic(
		RX_POLARITY_INVERT : std_logic_vector(3 downto 0) := "0000"); 
	port(
		SYS_CLK_I                : in  std_logic;
		SOFT_RESET_IN            : in  std_logic;
		PLL_SYNC_START           : in  std_logic;
		GTREFCLK_IN              : in  std_logic;
		RXN_I                    : in  std_logic_vector(3 downto 0);
		RXP_I                    : in  std_logic_vector(3 downto 0);
		ADC_SYNC_O               : out std_logic;
		GT_RXUSRCLK2_O           : out std_logic;
		ADC_DATA_CLOCK           : in  std_logic;
		ADC_DATA_16X12B_OUT      : out std_logic_vector(191 downto 0);
		ADC_DATA_16X12B_VAL_OUT  : out std_logic;
		ADC_PLL_ARESET           : out std_logic;
		ADC_PLL_LOCKED           : in  std_logic;
		STATUS_O                 : out std_logic_vector(31 downto 0);
		GBXF_RDEN_OUT            : out std_logic;
		GBXF_RDEN_IN             : in  std_logic);
    end component;

	component multi_skarab_adc_pll_sync_generator is
	port (
		clk                       : in std_logic;
		reset                     : in std_logic;
		adc_sysref_clk            : in std_logic;
		adc_reference_input_clk   : in std_logic;
		adc_sync_start            : in std_logic;
		adc_sync_part2_start      : in std_logic;
		adc_sync_part3_start      : in std_logic;
		pll_sync_start            : in std_logic;
		pll_pulse_generator_start : in std_logic;
		sync_complete             : out std_logic;
		adc_soft_reset            : out std_logic;
		adc_pll_sync              : out std_logic);
	end component;
    
    component adc_pll
    port(
        clk_in1           : in     std_logic;
        clk_out1          : out    std_logic;
        reset             : in     std_logic;
        locked            : out    std_logic);
    end component;
	
	component tff is
	port(
		clk    : in  std_logic;
		async  : in  std_logic;
		synced : out std_logic);
	end component;
	
    signal adc_reference_input_clk : std_logic;
    signal adc_sysref_clk : std_logic;
    signal adc_pll_sync : std_logic;
    signal sync_complete : std_logic;
    signal sync_complete_z1 : std_logic := '0';
    signal adc_soft_reset : std_logic;
    signal adc_sync_in : std_logic_vector(3 downto 0);
    
    signal adc0_gtrefclk : std_logic;
    signal adc1_gtrefclk : std_logic;
    signal adc2_gtrefclk : std_logic;
    signal adc3_gtrefclk : std_logic;
    
    signal block_capture_data_val_0 : std_logic;
    signal block_capture_data_0 : std_logic_vector(127 downto 0);
    signal block_capture_data_last_0 : std_logic;
    signal block_capture_data_val_1 : std_logic;
    signal block_capture_data_1 : std_logic_vector(127 downto 0);
    signal block_capture_data_last_1 : std_logic;
    signal block_capture_data_val_2 : std_logic;
    signal block_capture_data_2 : std_logic_vector(127 downto 0);
    signal block_capture_data_last_2 : std_logic;
    signal block_capture_data_val_3 : std_logic;
    signal block_capture_data_3 : std_logic_vector(127 downto 0);
    signal block_capture_data_last_3 : std_logic;

    signal block_capture_sync_ready : std_logic_vector(0 to 3);
    signal block_capture_sync_output_enable : std_logic; 
	
	signal ADC_MEZ_PHY12_LANE_RX_P_swapped : std_logic_vector(3 downto 0);
    signal ADC_MEZ_PHY12_LANE_RX_N_swapped : std_logic_vector(3 downto 0);
	signal ADC_MEZ_PHY22_LANE_RX_P_swapped : std_logic_vector(3 downto 0);
    signal ADC_MEZ_PHY22_LANE_RX_N_swapped : std_logic_vector(3 downto 0);	
	
	signal adc_pll_reset  : std_logic;
	signal adc_clk_175MHz : std_logic;
	signal adc_user_clk   : std_logic;
	
	signal adc_sync_start_in_synced       : std_logic := '0';
	signal adc_sync_part2_start_in_synced : std_logic := '0';
	signal adc_sync_part3_start_in_synced : std_logic := '0';
	signal pll_sync_start_in_synced       : std_logic := '0';
	signal pll_pulse_gen_start_in_synced  : std_logic := '0';
	
	signal adc_sync_complete_async : std_logic := '0';
	signal adc_sync_request_async  : std_logic_vector(3 downto 0) := "0000";
	signal pll_sync_complete_async : std_logic := '0';
	
    signal pll_sync_start_delayed : std_logic := '0';
    signal pll_sync_start_delay_sr : std_logic_vector(31 downto 0) := x"00000000";
    
	signal adc0_status : std_logic_vector(31 downto 0);
	signal adc1_status : std_logic_vector(31 downto 0);
	signal adc2_status : std_logic_vector(31 downto 0);
	signal adc3_status : std_logic_vector(31 downto 0);

	signal adc0_status_z1     : std_logic_vector(31 downto 0) := x"00000000";
	signal adc1_status_z1     : std_logic_vector(31 downto 0) := x"00000000";
	signal adc2_status_z1     : std_logic_vector(31 downto 0) := x"00000000";
	signal adc3_status_z1     : std_logic_vector(31 downto 0) := x"00000000";	
	signal adc0_status_z2     : std_logic_vector(31 downto 0) := x"00000000";
	signal adc1_status_z2     : std_logic_vector(31 downto 0) := x"00000000";
	signal adc2_status_z2     : std_logic_vector(31 downto 0) := x"00000000";
	signal adc3_status_z2     : std_logic_vector(31 downto 0) := x"00000000";	
	signal adc0_status_z3     : std_logic_vector(31 downto 0) := x"00000000";
	signal adc1_status_z3     : std_logic_vector(31 downto 0) := x"00000000";
	signal adc2_status_z3     : std_logic_vector(31 downto 0) := x"00000000";
	signal adc3_status_z3     : std_logic_vector(31 downto 0) := x"00000000";
	signal adc0_status_synced : std_logic_vector(31 downto 0) := x"00000000";
	signal adc1_status_synced : std_logic_vector(31 downto 0) := x"00000000";
	signal adc2_status_synced : std_logic_vector(31 downto 0) := x"00000000";
	signal adc3_status_synced : std_logic_vector(31 downto 0) := x"00000000";
	
	attribute ASYNC_REG : string;
	attribute ASYNC_REG of adc0_status_z1 : signal is "TRUE";        
	attribute ASYNC_REG of adc1_status_z1 : signal is "TRUE";
	attribute ASYNC_REG of adc2_status_z1 : signal is "TRUE";
	attribute ASYNC_REG of adc3_status_z1 : signal is "TRUE";
	attribute ASYNC_REG of adc0_status_z2 : signal is "TRUE";
	attribute ASYNC_REG of adc1_status_z2 : signal is "TRUE";
	attribute ASYNC_REG of adc2_status_z2 : signal is "TRUE";
	attribute ASYNC_REG of adc3_status_z2 : signal is "TRUE";
	attribute ASYNC_REG of adc0_status_z3 : signal is "TRUE";
	attribute ASYNC_REG of adc1_status_z3 : signal is "TRUE";
	attribute ASYNC_REG of adc2_status_z3 : signal is "TRUE";
	attribute ASYNC_REG of adc3_status_z3 : signal is "TRUE";
	
	signal adc_pll_locked : std_logic;
	signal adc_rx_reset_n : std_logic;
	
	signal mezzanine_fault_n_not : std_logic;

	signal adc0_gbxf_rden_out : std_logic;
	signal adc0_gbxf_rden_in  : std_logic;
	signal adc1_gbxf_rden_out : std_logic;
	signal adc1_gbxf_rden_in  : std_logic;
	signal adc2_gbxf_rden_out : std_logic;
	signal adc2_gbxf_rden_in  : std_logic;
	signal adc3_gbxf_rden_out : std_logic;
	signal adc3_gbxf_rden_in  : std_logic;
	
	signal adc_gbxf_rden_out_anded : std_logic;
	
begin
   
	--ADC ID = 011 (uBlaze needs to know this is an ADC card)
	MEZZ_ID <= "011";
	--MEZZ_PRESENT <= '1' (if Mezzanine is present then this will be high always)
	MEZZ_PRESENT <= '1';
	MEZZANINE_CLK_SEL <= '1'; -- DEFAULT '1' = MEZZANINE CLOCK
	
---------------------------------------------------------------------------------------------------------
-- CORRECT FOR SWAP IN YAML FILE, SAME FOR ALL MEZZANINE SITES
---------------------------------------------------------------------------------------------------------
	
	ADC_MEZ_PHY12_LANE_RX_P_swapped(0) <= ADC_MEZ_PHY12_LANE_RX_P(3);
	ADC_MEZ_PHY12_LANE_RX_P_swapped(1) <= ADC_MEZ_PHY12_LANE_RX_P(2);
	ADC_MEZ_PHY12_LANE_RX_P_swapped(2) <= ADC_MEZ_PHY12_LANE_RX_P(1);
	ADC_MEZ_PHY12_LANE_RX_P_swapped(3) <= ADC_MEZ_PHY12_LANE_RX_P(0);

	ADC_MEZ_PHY12_LANE_RX_N_swapped(0) <= ADC_MEZ_PHY12_LANE_RX_N(3);
	ADC_MEZ_PHY12_LANE_RX_N_swapped(1) <= ADC_MEZ_PHY12_LANE_RX_N(2);
	ADC_MEZ_PHY12_LANE_RX_N_swapped(2) <= ADC_MEZ_PHY12_LANE_RX_N(1);
	ADC_MEZ_PHY12_LANE_RX_N_swapped(3) <= ADC_MEZ_PHY12_LANE_RX_N(0);
	
	ADC_MEZ_PHY22_LANE_RX_P_swapped(0) <= ADC_MEZ_PHY22_LANE_RX_P(3);
	ADC_MEZ_PHY22_LANE_RX_P_swapped(1) <= ADC_MEZ_PHY22_LANE_RX_P(2);
	ADC_MEZ_PHY22_LANE_RX_P_swapped(2) <= ADC_MEZ_PHY22_LANE_RX_P(1);
	ADC_MEZ_PHY22_LANE_RX_P_swapped(3) <= ADC_MEZ_PHY22_LANE_RX_P(0);

	ADC_MEZ_PHY22_LANE_RX_N_swapped(0) <= ADC_MEZ_PHY22_LANE_RX_N(3);
	ADC_MEZ_PHY22_LANE_RX_N_swapped(1) <= ADC_MEZ_PHY22_LANE_RX_N(2);
	ADC_MEZ_PHY22_LANE_RX_N_swapped(2) <= ADC_MEZ_PHY22_LANE_RX_N(1);
	ADC_MEZ_PHY22_LANE_RX_N_swapped(3) <= ADC_MEZ_PHY22_LANE_RX_N(0);	
	
---------------------------------------------------------------------------------------------------------
-- ADC SYNC BUFFERS
---------------------------------------------------------------------------------------------------------
    
    aux_clk_ibufds : IBUFDS
    generic map (
        DIFF_TERM => TRUE)
    port map (
        O  => adc_reference_input_clk,
        I  => AUX_CLK_P,
        IB => AUX_CLK_N);

    aux_synci_ibufds : IBUFDS
    generic map (
        DIFF_TERM => TRUE)
    port map (
        O  => adc_sysref_clk,
        I  => AUX_SYNCI_P,
        IB => AUX_SYNCI_N);

    aux_synco_obufds : OBUFDS
    port map (
        I  => adc_pll_sync,
        O  => AUX_SYNCO_P,
        OB => AUX_SYNCO_N);

---------------------------------------------------------------------------------------------------------
-- CDC
---------------------------------------------------------------------------------------------------------

	tff_adc_sync_start_in       : tff port map (FREE_RUN_156M25HZ_CLK_IN, ADC_SYNC_START_IN         , adc_sync_start_in_synced       );
	tff_adc_sync_part2_start_in : tff port map (FREE_RUN_156M25HZ_CLK_IN, ADC_SYNC_PART2_START_IN   , adc_sync_part2_start_in_synced );
	tff_adc_sync_part3_start_in : tff port map (FREE_RUN_156M25HZ_CLK_IN, ADC_SYNC_PART3_START_IN   , adc_sync_part3_start_in_synced );
	tff_pll_sync_start_in       : tff port map (FREE_RUN_156M25HZ_CLK_IN, PLL_SYNC_START_IN         , pll_sync_start_in_synced       );
	tff_pll_pulse_gen_start_in  : tff port map (FREE_RUN_156M25HZ_CLK_IN, PLL_PULSE_GEN_START_IN    , pll_pulse_gen_start_in_synced  );
	tff_adc_sync_complete_out   : tff port map (DSP_CLK_IN,               adc_sync_complete_async   , ADC_SYNC_COMPLETE_OUT          );
	tff_adc_sync_request_out_0  : tff port map (DSP_CLK_IN,               adc_sync_request_async(0) , ADC_SYNC_REQUEST_OUT(0)        );
	tff_adc_sync_request_out_1  : tff port map (DSP_CLK_IN,               adc_sync_request_async(1) , ADC_SYNC_REQUEST_OUT(1)        );
	tff_adc_sync_request_out_2  : tff port map (DSP_CLK_IN,               adc_sync_request_async(2) , ADC_SYNC_REQUEST_OUT(2)        );
	tff_adc_sync_request_out_3  : tff port map (DSP_CLK_IN,               adc_sync_request_async(3) , ADC_SYNC_REQUEST_OUT(3)        );
	tff_pll_sync_complete_out   : tff port map (DSP_CLK_IN,               pll_sync_complete_async   , PLL_SYNC_COMPLETE_OUT          );
	tff_mezzanine_reset         : tff port map (DSP_CLK_IN,               MEZZANINE_RESET_IN,         MEZZANINE_RESET                );
	
	--Fault line is now the ADC trigger line
	mezzanine_fault_n_not <= not(MEZZANINE_FAULT_N);
	tff_adc_trigger_out         : tff port map (DSP_CLK_IN,               mezzanine_fault_n_not     , ADC_TRIGGER_OUT                );

	-- ADC RX STATUS REGISTERS
	process (DSP_CLK_IN)
	begin
		if rising_edge(DSP_CLK_IN) then
			if (DSP_RST_IN = '1') then
				adc0_status_z1     <= x"00000000";
				adc1_status_z1     <= x"00000000";
				adc2_status_z1     <= x"00000000";
				adc3_status_z1     <= x"00000000";	
				adc0_status_z2     <= x"00000000";
				adc1_status_z2     <= x"00000000";
				adc2_status_z2     <= x"00000000";
				adc3_status_z2     <= x"00000000";	
				adc0_status_z3     <= x"00000000";
				adc1_status_z3     <= x"00000000";
				adc2_status_z3     <= x"00000000";
				adc3_status_z3     <= x"00000000";
				adc0_status_synced <= x"00000000";
				adc1_status_synced <= x"00000000";
				adc2_status_synced <= x"00000000";
				adc3_status_synced <= x"00000000";
			else
				adc0_status_synced <= adc0_status_z3;
				adc0_status_z3     <= adc0_status_z2;
				adc0_status_z2     <= adc0_status_z1;
				adc0_status_z1     <= adc0_status;
				adc1_status_synced <= adc1_status_z3;
				adc1_status_z3     <= adc1_status_z2;
				adc1_status_z2     <= adc1_status_z1;
				adc1_status_z1     <= adc1_status;
				adc2_status_synced <= adc2_status_z3;
				adc2_status_z3     <= adc2_status_z2;
				adc2_status_z2     <= adc2_status_z1;
				adc2_status_z1     <= adc2_status;
				adc3_status_synced <= adc3_status_z3;
				adc3_status_z3     <= adc3_status_z2;
				adc3_status_z2     <= adc3_status_z1;
				adc3_status_z1     <= adc3_status;
			end if;
		end if;
	end process;
	
	ADC0_STATUS_OUT <= adc0_status_synced;
	ADC1_STATUS_OUT <= adc1_status_synced;
	ADC2_STATUS_OUT <= adc2_status_synced;
	ADC3_STATUS_OUT <= adc3_status_synced;
	
---------------------------------------------------------------------------------------------------------
-- GENERATE ADC AND PLL SYNCS
---------------------------------------------------------------------------------------------------------

    adc_sync_complete_async <= sync_complete_z1;
    pll_sync_complete_async <= sync_complete_z1;
	
	-- DELAY PLL SYNC
	process (FREE_RUN_156M25HZ_CLK_IN)
	begin
		if rising_edge(FREE_RUN_156M25HZ_CLK_IN) then
			if (FREE_RUN_156M25HZ_RST_IN = '1') then
				pll_sync_start_delay_sr <= x"00000000";
				pll_sync_start_delayed  <= '0';
			else
				pll_sync_start_delayed <= pll_sync_start_delay_sr(31);
				for i in 30 downto 0 loop
					pll_sync_start_delay_sr(i+1) <= pll_sync_start_delay_sr(i);
				end loop;
				pll_sync_start_delay_sr(0) <= pll_sync_start_in_synced;
				
				sync_complete_z1 <= sync_complete;
			end if;
		end if;
	end process;

	multi_skarab_adc_pll_sync_generator_i : multi_skarab_adc_pll_sync_generator port map (
		clk                       => FREE_RUN_156M25HZ_CLK_IN,
		reset                     => FREE_RUN_156M25HZ_RST_IN,
		adc_sysref_clk            => adc_sysref_clk,
		adc_reference_input_clk   => adc_reference_input_clk,
		adc_sync_start            => adc_sync_start_in_synced,
		adc_sync_part2_start      => adc_sync_part2_start_in_synced,
		adc_sync_part3_start      => adc_sync_part3_start_in_synced,
		pll_sync_start            => pll_sync_start_delayed,
		pll_pulse_generator_start => pll_pulse_gen_start_in_synced,
		sync_complete             => sync_complete,
		adc_soft_reset            => adc_soft_reset,
		adc_pll_sync              => adc_pll_sync);

-------------------------------------------------------------------------
-- ADC RX reference clocks 
-------------------------------------------------------------------------
	
    gen_adc0_gtrefclk : IBUFDS_GTE2
    port map(
        O     => adc0_gtrefclk,
        ODIV2 => open,
        CEB   => '0',
        I     => ADC_MEZ_REFCLK_0_P,
        IB    => ADC_MEZ_REFCLK_0_N);
		
    gen_adc1_gtrefclk : IBUFDS_GTE2
    port map(
        O     => adc1_gtrefclk,
        ODIV2 => open,
        CEB   => '0',
        I     => ADC_MEZ_REFCLK_1_P,
        IB    => ADC_MEZ_REFCLK_1_N);
		
    gen_adc2_gtrefclk : IBUFDS_GTE2
    port map(
        O     => adc2_gtrefclk,
        ODIV2 => open,
        CEB   => '0',
        I     => ADC_MEZ_REFCLK_2_P,
        IB    => ADC_MEZ_REFCLK_2_N);
		
    gen_adc3_gtrefclk : IBUFDS_GTE2
    port map(
        O     => adc3_gtrefclk,
        ODIV2 => open,
        CEB   => '0',
        I     => ADC_MEZ_REFCLK_3_P,
        IB    => ADC_MEZ_REFCLK_3_N);

-------------------------------------------------------------------------
-- JESD ADC INTERFACE     
-------------------------------------------------------------------------

    -- ADC_MEZ_PHY11 IS ADC0 CHANNEL B
    -- NOTE: POLARITY IS SWAPPED
    -- LANE ORDER: 0 to 0, 1 to 1, 2 to 2, 3 to 3
	ADC32RF45_11G2_RX_0 : ADC32RF45_11G2_RX
	generic map(
		RX_POLARITY_INVERT => "1111")
	port map(
		SYS_CLK_I                => FREE_RUN_156M25HZ_CLK_IN,
		SOFT_RESET_IN            => adc_soft_reset,
		PLL_SYNC_START           => pll_sync_start_in_synced,
		GTREFCLK_IN              => adc0_gtrefclk,
		RXN_I                    => ADC_MEZ_PHY11_LANE_RX_N,
		RXP_I                    => ADC_MEZ_PHY11_LANE_RX_P,
		ADC_SYNC_O               => adc_sync_in(0),
		GT_RXUSRCLK2_O           => adc_user_clk,
		ADC_DATA_CLOCK           => DSP_CLK_IN,
		ADC_DATA_16X12B_OUT      => ADC0_DATA_OUT,
		ADC_DATA_16X12B_VAL_OUT  => ADC0_DATA_VAL_OUT,
		ADC_PLL_ARESET           => adc_pll_reset,
		ADC_PLL_LOCKED           => adc_rx_reset_n,
		STATUS_O                 => adc0_status,
		GBXF_RDEN_OUT            => adc0_gbxf_rden_out,
		GBXF_RDEN_IN             => adc0_gbxf_rden_in);

    -- ADC_MEZ_PHY12 IS ADC0 CHANNEL A 
    -- NOTE: POLARITY IS NOT SWAPPED
    -- LANE ORDER: 3 to 0, 2 to 1, 1 to 2, 0 to 3
	ADC32RF45_11G2_RX_1 : ADC32RF45_11G2_RX
	generic map(
		RX_POLARITY_INVERT => "0000")
	port map(
		SYS_CLK_I                => FREE_RUN_156M25HZ_CLK_IN,
		SOFT_RESET_IN            => adc_soft_reset,
		PLL_SYNC_START           => pll_sync_start_in_synced,
		GTREFCLK_IN              => adc1_gtrefclk,
		RXN_I                    => ADC_MEZ_PHY12_LANE_RX_N_swapped,
		RXP_I                    => ADC_MEZ_PHY12_LANE_RX_P_swapped,
		ADC_SYNC_O               => adc_sync_in(1),
		GT_RXUSRCLK2_O           => open,
		ADC_DATA_CLOCK           => DSP_CLK_IN,
		ADC_DATA_16X12B_OUT      => ADC1_DATA_OUT,
		ADC_DATA_16X12B_VAL_OUT  => ADC1_DATA_VAL_OUT,
		ADC_PLL_ARESET           => open,
		ADC_PLL_LOCKED           => adc_rx_reset_n,
		STATUS_O                 => adc1_status,
		GBXF_RDEN_OUT            => adc1_gbxf_rden_out,
		GBXF_RDEN_IN             => adc1_gbxf_rden_in);

    -- ADC_MEZ_PHY21 IS ADC1 CHANNEL B
    -- NOTE: POLARITY IS SWAPPED
    -- LANE ORDER: 0 to 0, 1 to 1, 2 to 2, 3 to 3    
	ADC32RF45_11G2_RX_2 : ADC32RF45_11G2_RX
	generic map(
		RX_POLARITY_INVERT => "1111")
	port map(                    
		SYS_CLK_I                => FREE_RUN_156M25HZ_CLK_IN,
		SOFT_RESET_IN            => adc_soft_reset,
		PLL_SYNC_START           => pll_sync_start_in_synced,
		GTREFCLK_IN              => adc2_gtrefclk,
		RXN_I                    => ADC_MEZ_PHY21_LANE_RX_N,
		RXP_I                    => ADC_MEZ_PHY21_LANE_RX_P,
		ADC_SYNC_O               => adc_sync_in(2),
		GT_RXUSRCLK2_O           => open,
		ADC_DATA_CLOCK           => DSP_CLK_IN,
		ADC_DATA_16X12B_OUT      => ADC2_DATA_OUT,
		ADC_DATA_16X12B_VAL_OUT  => ADC2_DATA_VAL_OUT,
		ADC_PLL_ARESET           => open,
		ADC_PLL_LOCKED           => adc_rx_reset_n,
		STATUS_O                 => adc2_status,
		GBXF_RDEN_OUT            => adc2_gbxf_rden_out,
		GBXF_RDEN_IN             => adc2_gbxf_rden_in);

    -- ADC_MEZ_PHY22 IS ADC1 CHANNEL A
    -- NOTE: POLARITY IS NOT SWAPPED
    -- LANE ORDER: 3 to 0, 2 to 1, 1 to 2, 0 to 3 
	ADC32RF45_11G2_RX_3 : ADC32RF45_11G2_RX
	generic map(
		RX_POLARITY_INVERT => "0000")
	port map(
		SYS_CLK_I                => FREE_RUN_156M25HZ_CLK_IN,
		SOFT_RESET_IN            => adc_soft_reset,
		PLL_SYNC_START           => pll_sync_start_in_synced,
		GTREFCLK_IN              => adc3_gtrefclk,
		RXN_I                    => ADC_MEZ_PHY22_LANE_RX_N_swapped,
		RXP_I                    => ADC_MEZ_PHY22_LANE_RX_P_swapped,
		ADC_SYNC_O               => adc_sync_in(3),
		GT_RXUSRCLK2_O           => open,
		ADC_DATA_CLOCK           => DSP_CLK_IN,
		ADC_DATA_16X12B_OUT      => ADC3_DATA_OUT,
		ADC_DATA_16X12B_VAL_OUT  => ADC3_DATA_VAL_OUT,
		ADC_PLL_ARESET           => open,
		ADC_PLL_LOCKED           => adc_rx_reset_n,
		STATUS_O                 => adc3_status,
		GBXF_RDEN_OUT            => adc3_gbxf_rden_out,
		GBXF_RDEN_IN             => adc3_gbxf_rden_in);
	adc0_gbxf_rden_in       <= adc_gbxf_rden_out_anded;
	adc1_gbxf_rden_in       <= adc_gbxf_rden_out_anded;
	adc2_gbxf_rden_in       <= adc_gbxf_rden_out_anded;
	adc3_gbxf_rden_in       <= adc_gbxf_rden_out_anded;
	adc_gbxf_rden_out_anded <= adc0_gbxf_rden_out and adc1_gbxf_rden_out and adc2_gbxf_rden_out and adc3_gbxf_rden_out;
	adc_rx_reset_n          <= not DSP_RST_IN;
	adc_sync_request_async  <= adc_sync_in;
	
-------------------------------------------------------------------------
-- ADC PLL
-------------------------------------------------------------------------
	-- adc_pll_i : adc_pll
    -- port map ( 
        -- clk_in1  => adc_user_clk,
        -- clk_out1 => adc_clk_175MHz,
        -- reset    => adc_pll_reset,
        -- locked   => adc_pll_locked);
	-- ADC_DATA_CLOCK_OUT <= adc_clk_175MHz;
	-- ADC_DATA_RESET_OUT <= not adc_pll_locked;
	ADC_DATA_CLOCK_OUT <= '0';
	ADC_DATA_RESET_OUT <= '0';
	
end arch_SKARAB_ADC4x3G_14_BYP;