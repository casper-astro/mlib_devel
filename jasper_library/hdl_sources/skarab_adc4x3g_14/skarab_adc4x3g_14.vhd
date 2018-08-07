----------------------------------------------------------------------------------
-- Company: Peralex Electronics
-- Engineer: 
-- 
-- Create Date: 24.06.2016 10:19:42
-- Design Name: 
-- Module Name: SKARAB_ADC4x3G_14 - Behavioral
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


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

library unisim;
use unisim.vcomponents.all;

entity SKARAB_ADC4x3G_14 is
	port(
        FREE_RUN_156M25HZ_CLK_IN : in std_logic;
	   	
        MEZZANINE_RESET : out std_logic;
        MEZZANINE_CLK_SEL : out std_logic;
		
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
        ADC0_DATA_OUT : out std_logic_vector(127 downto 0);
        ADC1_DATA_VAL_OUT : out std_logic;
        ADC1_DATA_OUT : out std_logic_vector(127 downto 0);
        ADC2_DATA_VAL_OUT : out std_logic;
        ADC2_DATA_OUT : out std_logic_vector(127 downto 0);
        ADC3_DATA_VAL_OUT : out std_logic;
        ADC3_DATA_OUT : out std_logic_vector(127 downto 0);

        ADC_SYNC_START_IN : in std_logic;
        ADC_SYNC_COMPLETE_OUT : out std_logic;
        PLL_SYNC_START_IN : in std_logic;
        PLL_SYNC_COMPLETE_OUT : out std_logic;
        
        MEZZ_ID : out std_logic_vector(2 downto 0);
        MEZZ_PRESENT : out std_logic;        
        
        AUX_CLK_P : in std_logic;
        AUX_CLK_N : in std_logic;
        AUX_SYNCI_P : in std_logic;
        AUX_SYNCI_N : in std_logic;
        AUX_SYNCO_P : out std_logic;
        AUX_SYNCO_N : out std_logic);
end SKARAB_ADC4x3G_14;

architecture arch_SKARAB_ADC4x3G_14 of SKARAB_ADC4x3G_14 is

	constant C_ADC_AXIS_TDATA_WIDTH : integer := 128;
	
    component ADC32RF45_RX
    generic(
        STABLE_CLOCK_PERIOD : integer := 6;
        C_AXIS_TDATA_WIDTH  : integer := 128;
		RX_POLARITY_INVERT  : std_logic_vector(3 downto 0));
    port(
        SYS_CLK_I         : in  std_logic;
        SOFT_RESET_IN     : in  std_logic;
        GTREFCLK_IN       : in  std_logic;
        RXN_I             : in  std_logic_vector(3 downto 0);
        RXP_I             : in  std_logic_vector(3 downto 0);
        ADC_SYNC_O        : out std_logic;
        GT_RXUSRCLK2_O    : out std_logic;
        DBG_M_AXIS_TVALID : out std_logic;
        DBG_M_AXIS_TREADY : in  std_logic;
        DBG_M_AXIS_TDATA  : out std_logic_vector(C_AXIS_TDATA_WIDTH - 1 downto 0);
        DBG_M_AXIS_TLAST  : out std_logic;
        AXIS_ACLK         : in  std_logic;
        AXIS_ARESETN      : in  std_logic;
        M0_AXIS_TVALID    : out std_logic;
        M0_AXIS_TREADY    : in  std_logic;
        M0_AXIS_TDATA     : out std_logic_vector(C_AXIS_TDATA_WIDTH - 1 downto 0);
        M0_AXIS_TLAST     : out std_logic);
    end component;

    component adc_pll_sync_generator
    generic (
        NUM_ADC_CORES           : integer);
	port (
        clk                     : in std_logic;
        reset                   : in std_logic;
        adc_sysref_clk          : in std_logic;
        adc_reference_input_clk : in std_logic;
        adc_sync_start          : in std_logic;
        pll_sync_start          : in std_logic;
        sync_complete           : out std_logic;
        adc_soft_reset          : out std_logic;
        adc_sync_in             : in std_logic_vector(0 to (NUM_ADC_CORES - 1));
        adc_user_clk            : in std_logic;
        adc_user_rst            : out std_logic;
        adc_pll_sync            : out std_logic);
    end component;

    component adc_data_sync
	port (
		adc_user_clk : in std_logic;
		adc_user_rst : in std_logic;
        block_capture_data        : in std_logic_vector(127 downto 0);
        block_capture_data_val    : in std_logic;
        block_capture_data_last   : in std_logic;
        block_capture_sync_ready             : out std_logic;
        block_capture_sync_output_enable     : in std_logic;
        block_capture_data_sync              : out std_logic_vector(127 downto 0);
        block_capture_data_val_sync          : out std_logic;
        block_capture_data_last_sync         : out std_logic);
    end component;
    
    signal adc_reference_input_clk : std_logic;
    signal adc_sysref_clk : std_logic;
    signal adc_pll_sync : std_logic;
    signal sync_complete : std_logic;
    signal adc_soft_reset : std_logic;
    signal adc_sync_in : std_logic_vector(0 to 3);
    signal adc_user_rst : std_logic;
    signal adc_user_rst_n : std_logic;
    
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
    
begin

        --ADC ID = 011 (uBlaze needs to know this is an ADC card)
        MEZZ_ID <= "011";
        --MEZZ_PRESENT <= '1' (if Mezzanine is present then this will be high always)
        MEZZ_PRESENT <= '1';
   
	MEZZANINE_CLK_SEL <= '1'; -- DEFAULT '1' = MEZZANINE CLOCK
	MEZZANINE_RESET <= '0'; -- NO EXTRA RESET REQUIRED
	
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
-- GENERATE ADC AND PLL SYNCS
---------------------------------------------------------------------------------------------------------

    ADC_SYNC_COMPLETE_OUT <= sync_complete;
    PLL_SYNC_COMPLETE_OUT <= sync_complete;

    adc_pll_sync_generator_0 : adc_pll_sync_generator
    generic map(
        NUM_ADC_CORES           => 4)
    port map(
        clk                     => DSP_CLK_IN,
        reset                   => DSP_RST_IN,
        adc_sysref_clk          => adc_sysref_clk,
        adc_reference_input_clk => adc_reference_input_clk,
        adc_sync_start          => ADC_SYNC_START_IN,
        pll_sync_start          => PLL_SYNC_START_IN,
        sync_complete           => sync_complete,
        adc_soft_reset          => adc_soft_reset,
        adc_sync_in             => adc_sync_in,
        adc_user_clk            => DSP_CLK_IN,
        adc_user_rst            => adc_user_rst,
        adc_pll_sync            => adc_pll_sync);

    adc_user_rst_n <= not adc_user_rst; 
        
-------------------------------------------------------------------------
-- JESD ADC INTERFACE     
-------------------------------------------------------------------------

    gen_adc0_gtrefclk : IBUFDS_GTE2
    port map(
        O     => adc0_gtrefclk,
        ODIV2 => open,
        CEB   => '0',
        I     => ADC_MEZ_REFCLK_0_P,
        IB    => ADC_MEZ_REFCLK_0_N);

    -- ADC_MEZ_PHY11 IS ADC0 CHANNEL B
    -- NOTE: POLARITY IS SWAPPED
    -- LANE ORDER: 0 to 0, 1 to 1, 2 to 2, 3 to 3
    ADC32RF45_RX_0 : component ADC32RF45_RX
    generic map(
        STABLE_CLOCK_PERIOD => 8,
        C_AXIS_TDATA_WIDTH  => C_ADC_AXIS_TDATA_WIDTH,
        RX_POLARITY_INVERT  => "1111")
    port map(
        SYS_CLK_I         => FREE_RUN_156M25HZ_CLK_IN,
        SOFT_RESET_IN     => adc_soft_reset,
        GTREFCLK_IN       => adc0_gtrefclk,
        RXN_I             => ADC_MEZ_PHY11_LANE_RX_N,
        RXP_I             => ADC_MEZ_PHY11_LANE_RX_P,
        ADC_SYNC_O        => adc_sync_in(0),
        GT_RXUSRCLK2_O    => open,
        DBG_M_AXIS_TVALID => open,
        DBG_M_AXIS_TREADY => '1',
        DBG_M_AXIS_TDATA  => open,
        DBG_M_AXIS_TLAST  => open,
        AXIS_ACLK         => DSP_CLK_IN,
        AXIS_ARESETN      => adc_user_rst_n,
        M0_AXIS_TVALID    => block_capture_data_val_0,
        M0_AXIS_TREADY    => '1',
        M0_AXIS_TDATA     => block_capture_data_0,
        M0_AXIS_TLAST     => block_capture_data_last_0);

    adc_data_sync_0 : adc_data_sync
	port map(
		adc_user_clk => DSP_CLK_IN,
		adc_user_rst => adc_user_rst,
        block_capture_data        => block_capture_data_0,
        block_capture_data_val    => block_capture_data_val_0,
        block_capture_data_last   => block_capture_data_last_0,
        block_capture_sync_ready             => block_capture_sync_ready(0),
        block_capture_sync_output_enable     => block_capture_sync_output_enable,
        block_capture_data_sync              => ADC0_DATA_OUT,
        block_capture_data_val_sync          => ADC0_DATA_VAL_OUT,
        block_capture_data_last_sync         => open);

    gen_adc1_gtrefclk : IBUFDS_GTE2
    port map(
        O     => adc1_gtrefclk,
        ODIV2 => open,
        CEB   => '0',
        I     => ADC_MEZ_REFCLK_1_P,
        IB    => ADC_MEZ_REFCLK_1_N);

    -- ADC_MEZ_PHY12 IS ADC0 CHANNEL A 
    -- NOTE: POLARITY IS NOT SWAPPED
    -- LANE ORDER: 3 to 0, 2 to 1, 1 to 2, 0 to 3
    ADC32RF45_RX_1 : component ADC32RF45_RX
    generic map(
        STABLE_CLOCK_PERIOD => 8,
        C_AXIS_TDATA_WIDTH  => C_ADC_AXIS_TDATA_WIDTH,
        RX_POLARITY_INVERT  => "0000")
    port map(
        SYS_CLK_I         => FREE_RUN_156M25HZ_CLK_IN,
        SOFT_RESET_IN     => adc_soft_reset,
        GTREFCLK_IN       => adc1_gtrefclk,
        RXN_I             => ADC_MEZ_PHY12_LANE_RX_N_swapped,
        RXP_I             => ADC_MEZ_PHY12_LANE_RX_P_swapped,
        ADC_SYNC_O        => adc_sync_in(1),
        GT_RXUSRCLK2_O    => open,
        DBG_M_AXIS_TVALID => open,
        DBG_M_AXIS_TREADY => '1',
        DBG_M_AXIS_TDATA  => open,
        DBG_M_AXIS_TLAST  => open,
        AXIS_ACLK         => DSP_CLK_IN,
        AXIS_ARESETN      => adc_user_rst_n,
        M0_AXIS_TVALID    => block_capture_data_val_1,
        M0_AXIS_TREADY    => '1',
        M0_AXIS_TDATA     => block_capture_data_1,
        M0_AXIS_TLAST     => block_capture_data_last_1);

    adc_data_sync_1 : adc_data_sync
	port map(
		adc_user_clk => DSP_CLK_IN,
		adc_user_rst => adc_user_rst,
        block_capture_data        => block_capture_data_1,
        block_capture_data_val    => block_capture_data_val_1,
        block_capture_data_last   => block_capture_data_last_1,
        block_capture_sync_ready             => block_capture_sync_ready(1),
        block_capture_sync_output_enable     => block_capture_sync_output_enable,
        block_capture_data_sync              => ADC1_DATA_OUT,
        block_capture_data_val_sync          => ADC1_DATA_VAL_OUT,
        block_capture_data_last_sync         => open);

    gen_adc2_gtrefclk : IBUFDS_GTE2
    port map(
        O     => adc2_gtrefclk,
        ODIV2 => open,
        CEB   => '0',
        I     => ADC_MEZ_REFCLK_2_P,
        IB    => ADC_MEZ_REFCLK_2_N);

    -- ADC_MEZ_PHY21 IS ADC1 CHANNEL B
    -- NOTE: POLARITY IS SWAPPED
    -- LANE ORDER: 0 to 0, 1 to 1, 2 to 2, 3 to 3    
    ADC32RF45_RX_2 : component ADC32RF45_RX
    generic map(
        STABLE_CLOCK_PERIOD => 8,
        C_AXIS_TDATA_WIDTH  => C_ADC_AXIS_TDATA_WIDTH,
        RX_POLARITY_INVERT  => "1111")
    port map(
        SYS_CLK_I         => FREE_RUN_156M25HZ_CLK_IN,
        SOFT_RESET_IN     => adc_soft_reset,
        GTREFCLK_IN       => adc2_gtrefclk,
        RXN_I             => ADC_MEZ_PHY21_LANE_RX_N,
        RXP_I             => ADC_MEZ_PHY21_LANE_RX_P,
        ADC_SYNC_O        => adc_sync_in(2),
        GT_RXUSRCLK2_O    => open,
        DBG_M_AXIS_TVALID => open,
        DBG_M_AXIS_TREADY => '1',
        DBG_M_AXIS_TDATA  => open,
        DBG_M_AXIS_TLAST  => open,
        AXIS_ACLK         => DSP_CLK_IN,
        AXIS_ARESETN      => adc_user_rst_n,
        M0_AXIS_TVALID    => block_capture_data_val_2,
        M0_AXIS_TREADY    => '1',
        M0_AXIS_TDATA     => block_capture_data_2,
        M0_AXIS_TLAST     => block_capture_data_last_2);

    adc_data_sync_2 : adc_data_sync
	port map(
		adc_user_clk => DSP_CLK_IN,
		adc_user_rst => adc_user_rst,
        block_capture_data        => block_capture_data_2,
        block_capture_data_val    => block_capture_data_val_2,
        block_capture_data_last   => block_capture_data_last_2,
        block_capture_sync_ready             => block_capture_sync_ready(2),
        block_capture_sync_output_enable     => block_capture_sync_output_enable,
        block_capture_data_sync              => ADC2_DATA_OUT,
        block_capture_data_val_sync          => ADC2_DATA_VAL_OUT,
        block_capture_data_last_sync         => open);

    gen_adc3_gtrefclk : IBUFDS_GTE2
    port map(
        O     => adc3_gtrefclk,
        ODIV2 => open,
        CEB   => '0',
        I     => ADC_MEZ_REFCLK_3_P,
        IB    => ADC_MEZ_REFCLK_3_N);

    -- ADC_MEZ_PHY22 IS ADC1 CHANNEL A
    -- NOTE: POLARITY IS NOT SWAPPED
    -- LANE ORDER: 3 to 0, 2 to 1, 1 to 2, 0 to 3 
    ADC32RF45_RX_3 : component ADC32RF45_RX
    generic map(
        STABLE_CLOCK_PERIOD => 8,
        C_AXIS_TDATA_WIDTH  => C_ADC_AXIS_TDATA_WIDTH,
        RX_POLARITY_INVERT  => "0000")
    port map(
        SYS_CLK_I         => FREE_RUN_156M25HZ_CLK_IN,
        SOFT_RESET_IN     => adc_soft_reset,
        GTREFCLK_IN       => adc3_gtrefclk,
        RXN_I             => ADC_MEZ_PHY22_LANE_RX_N_swapped,
        RXP_I             => ADC_MEZ_PHY22_LANE_RX_P_swapped,
        ADC_SYNC_O        => adc_sync_in(3),
        GT_RXUSRCLK2_O    => open,
        DBG_M_AXIS_TVALID => open,
        DBG_M_AXIS_TREADY => '1',
        DBG_M_AXIS_TDATA  => open,
        DBG_M_AXIS_TLAST  => open,
        AXIS_ACLK         => DSP_CLK_IN,
        AXIS_ARESETN      => adc_user_rst_n,
        M0_AXIS_TVALID    => block_capture_data_val_3,
        M0_AXIS_TREADY    => '1',
        M0_AXIS_TDATA     => block_capture_data_3,
        M0_AXIS_TLAST     => block_capture_data_last_3);
    
    adc_data_sync_3 : adc_data_sync
    port map(
        adc_user_clk => DSP_CLK_IN,
        adc_user_rst => adc_user_rst,
        block_capture_data        => block_capture_data_3,
        block_capture_data_val    => block_capture_data_val_3,
        block_capture_data_last   => block_capture_data_last_3,
        block_capture_sync_ready             => block_capture_sync_ready(3),
        block_capture_sync_output_enable     => block_capture_sync_output_enable,
        block_capture_data_sync              => ADC3_DATA_OUT,
        block_capture_data_val_sync          => ADC3_DATA_VAL_OUT,
        block_capture_data_last_sync         => open);

    gen_block_capture_sync_output_enable : process(adc_user_rst, DSP_CLK_IN)
    begin
        if (adc_user_rst = '1')then
            block_capture_sync_output_enable <= '0';
        elsif (rising_edge(DSP_CLK_IN))then
            if (block_capture_sync_ready = "1111")then
                block_capture_sync_output_enable <= '1';
            else   
                block_capture_sync_output_enable <= '0';
            end if;
        end if;
    end process;

end arch_SKARAB_ADC4x3G_14;