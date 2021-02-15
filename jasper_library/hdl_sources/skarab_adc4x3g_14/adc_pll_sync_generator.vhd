----------------------------------------------------------------------------------
-- Company: Peralex Electronics
-- Engineer: GT
-- 
-- Create Date: 05.09.2014 10:19:29
-- Design Name: 
-- Module Name: adc_pll_sync_generator - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Generate SYNC signals with correct timing for ADC32RF45X2 mezzanine.
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
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity adc_pll_sync_generator is
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
end adc_pll_sync_generator;

architecture arch_adc_pll_sync_generator of adc_pll_sync_generator is

    type T_GEN_SYNC_STATE is (
    IDLE,
    WAIT_UNTIL_FALLING_EDGE_REFERENCE_INPUT_CLK_ASSERT_SYNC,    -- MAYBE CHANGE TO RISING EDGE BECAUSE OF REGISTERING DELAY
    WAIT_UNTIL_FALLING_EDGE_REFERENCE_INPUT_CLK_DEASSERT_SYNC,
    GEN_ADC_CORE_RESET,
    WAIT_FOR_ALL_ADC_CORE_SYNC_HIGH,
    WAIT_UNTIL_FALLING_EDGE_SYSREF_CLK_ASSERT_SYNC,
    WAIT_FOR_ALL_ADC_CORE_SYNC_LOW,
    WAIT_UNTIL_FALLING_EDGE_SYSREF_CLK_DEASSERT_SYNC,
    WAIT_UNTIL_RISING_EDGE_SYSREF_CLK_DEASSERT_RST);

    signal adc_sync_start_z1 : std_logic := '0';
    signal pll_sync_start_z1 : std_logic := '0';
    
    signal adc_sysref_clk_z1 : std_logic := '0';
    signal adc_sysref_clk_z2 : std_logic := '0';
    signal adc_sysref_clk_z3 : std_logic := '0';
    signal adc_sysref_clk_z4 : std_logic := '0';
    
    signal adc_reference_input_clk_z1 : std_logic := '0';
    signal adc_reference_input_clk_z2 : std_logic := '0';
    signal adc_reference_input_clk_z3 : std_logic := '0';
    signal adc_reference_input_clk_z4 : std_logic := '0';
    
    signal adc_sync_in_z1 : std_logic_vector(0 to (NUM_ADC_CORES - 1));
    signal adc_sync_in_z2 : std_logic_vector(0 to (NUM_ADC_CORES - 1));
    signal adc_sync_in_z3 : std_logic_vector(0 to (NUM_ADC_CORES - 1));
    
    signal current_gen_sync_state : T_GEN_SYNC_STATE;
    signal adc_pll_sync_i : std_logic;
    
    signal adc_reset_counter : std_logic_vector(7 downto 0);
    signal adc_reset_counter_reset : std_logic;
    
    signal adc_user_rst_i : std_logic;
    signal adc_user_rst_i_z : std_logic;
    signal adc_user_rst_i_z2 : std_logic;
    signal adc_user_rst_i_z3 : std_logic;
    
begin

----------------------------------------------------------------------------------------------
-- REGISTER START SIGNALS TO DETECT START
----------------------------------------------------------------------------------------------

    gen_adc_pll_sync_start_z : process(clk)
    begin
        if (rising_edge(clk))then
            adc_sync_start_z1 <= adc_sync_start;
            pll_sync_start_z1 <= pll_sync_start;   
        end if;
    end process;

----------------------------------------------------------------------------------------------
-- TRIPLE REGISTER TIMING REFERENCE CLOCKS TO PREVENT METASTABILITY - MAY NEED A FIFO
----------------------------------------------------------------------------------------------

    gen_sync_timing_clks_z : process(clk)
    begin
        if (rising_edge(clk))then
            adc_sysref_clk_z1 <= adc_sysref_clk;
            adc_sysref_clk_z2 <= adc_sysref_clk_z1;
            adc_sysref_clk_z3 <= adc_sysref_clk_z2;
            adc_sysref_clk_z4 <= adc_sysref_clk_z3;

            adc_reference_input_clk_z1 <= adc_reference_input_clk;
            adc_reference_input_clk_z2 <= adc_reference_input_clk_z1;
            adc_reference_input_clk_z3 <= adc_reference_input_clk_z2;
            adc_reference_input_clk_z4 <= adc_reference_input_clk_z3;
        end if;
    end process;    

----------------------------------------------------------------------------------------------
-- TRIPLE REGISTER SYNC INPUTS TO PREVENT METASTABILITY - MAY NEED A FIFO
----------------------------------------------------------------------------------------------

    gen_adc_sync_in_z : process(reset, clk)
    begin
        if (reset = '1')then
            for a in 0 to NUM_ADC_CORES - 1 loop
                adc_sync_in_z1(a) <= '0'; 
                adc_sync_in_z2(a) <= '0'; 
                adc_sync_in_z3(a) <= '0';
            end loop;
        elsif (rising_edge(clk))then
            for a in 0 to NUM_ADC_CORES - 1 loop
                adc_sync_in_z1(a) <= adc_sync_in(a); 
                adc_sync_in_z2(a) <= adc_sync_in_z1(a); 
                adc_sync_in_z3(a) <= adc_sync_in_z2(a);
            end loop;
        end if;
    end process;

----------------------------------------------------------------------------------------------
-- STATE MACHINE TO GENERATE THE REQUIRED TIMING
----------------------------------------------------------------------------------------------

    gen_current_gen_sync_state : process(reset, clk)
    begin
        if (reset = '1')then
            adc_pll_sync_i <= '0';
            adc_user_rst_i <= '1';
            current_gen_sync_state <= IDLE;
        elsif (rising_edge(clk))then
            case current_gen_sync_state is
                when IDLE =>
                current_gen_sync_state <= IDLE;
    
                if ((pll_sync_start_z1 = '0')and(pll_sync_start = '1'))then
                    current_gen_sync_state <= WAIT_UNTIL_FALLING_EDGE_REFERENCE_INPUT_CLK_ASSERT_SYNC;
                elsif ((adc_sync_start_z1 = '0')and(adc_sync_start = '1'))then
                    adc_user_rst_i <= '1';
                    current_gen_sync_state <= GEN_ADC_CORE_RESET;
                end if;
                
                when WAIT_UNTIL_FALLING_EDGE_REFERENCE_INPUT_CLK_ASSERT_SYNC =>
                current_gen_sync_state <= WAIT_UNTIL_FALLING_EDGE_REFERENCE_INPUT_CLK_ASSERT_SYNC;
    
                -- FALLING EDGE OF REFERENCE CLOCK INPUT
                -- INVERSION RESULT OF HARDWARE
                if ((adc_reference_input_clk_z4 = '0')and(adc_reference_input_clk_z3 = '1'))then
                    adc_pll_sync_i <= '1';
                    current_gen_sync_state <= WAIT_UNTIL_FALLING_EDGE_REFERENCE_INPUT_CLK_DEASSERT_SYNC;
                end if;
                
                when WAIT_UNTIL_FALLING_EDGE_REFERENCE_INPUT_CLK_DEASSERT_SYNC =>
                current_gen_sync_state <= WAIT_UNTIL_FALLING_EDGE_REFERENCE_INPUT_CLK_DEASSERT_SYNC;
    
                -- FALLING EDGE OF REFERENCE CLOCK INPUT
                if ((adc_reference_input_clk_z4 = '0')and(adc_reference_input_clk_z3 = '1'))then
                    adc_pll_sync_i <= '0';
                    current_gen_sync_state <= IDLE;
                end if;
        
                when GEN_ADC_CORE_RESET =>
                current_gen_sync_state <= GEN_ADC_CORE_RESET;
    
                if (adc_reset_counter = X"FF")then
                    current_gen_sync_state <= WAIT_FOR_ALL_ADC_CORE_SYNC_HIGH;
                end if;
                
                when WAIT_FOR_ALL_ADC_CORE_SYNC_HIGH =>
                current_gen_sync_state <= WAIT_FOR_ALL_ADC_CORE_SYNC_HIGH;
                
                if (adc_sync_in_z3 = std_logic_vector(to_unsigned(2**NUM_ADC_CORES - 1, NUM_ADC_CORES)))then
                    current_gen_sync_state <= WAIT_UNTIL_FALLING_EDGE_SYSREF_CLK_ASSERT_SYNC;
                end if;
                
                when WAIT_UNTIL_FALLING_EDGE_SYSREF_CLK_ASSERT_SYNC =>
                current_gen_sync_state <= WAIT_UNTIL_FALLING_EDGE_SYSREF_CLK_ASSERT_SYNC;
                
                -- FALLING EDGE OF SYSREF
                if ((adc_sysref_clk_z4 = '1')and(adc_sysref_clk_z3 = '0'))then
                    adc_pll_sync_i <= '1';
                    current_gen_sync_state <= WAIT_FOR_ALL_ADC_CORE_SYNC_LOW;
                end if;
                
                when WAIT_FOR_ALL_ADC_CORE_SYNC_LOW =>
                current_gen_sync_state <= WAIT_FOR_ALL_ADC_CORE_SYNC_LOW;
                
                if (adc_sync_in_z3 = std_logic_vector(to_unsigned(0, NUM_ADC_CORES)))then
                    current_gen_sync_state <= WAIT_UNTIL_FALLING_EDGE_SYSREF_CLK_DEASSERT_SYNC;
                end if;
                
                when WAIT_UNTIL_FALLING_EDGE_SYSREF_CLK_DEASSERT_SYNC =>
                current_gen_sync_state <= WAIT_UNTIL_FALLING_EDGE_SYSREF_CLK_DEASSERT_SYNC;
                
                -- FALLING EDGE OF SYSREF
                if ((adc_sysref_clk_z4 = '1')and(adc_sysref_clk_z3 = '0'))then
                    adc_pll_sync_i <= '0';
                    current_gen_sync_state <= WAIT_UNTIL_RISING_EDGE_SYSREF_CLK_DEASSERT_RST;
                end if;
    
                when WAIT_UNTIL_RISING_EDGE_SYSREF_CLK_DEASSERT_RST =>
                current_gen_sync_state <= WAIT_UNTIL_RISING_EDGE_SYSREF_CLK_DEASSERT_RST;
                
                -- RISING EDGE OF SYSREF
                if ((adc_sysref_clk_z4 = '0')and(adc_sysref_clk_z3 = '1'))then
                    adc_user_rst_i <= '0';
                    current_gen_sync_state <= IDLE;
                end if;
    
            end case;
        end if;
    end process;

    sync_complete <= '1' when (current_gen_sync_state = IDLE) else '0';    
    adc_reset_counter_reset <= '0' when (current_gen_sync_state = GEN_ADC_CORE_RESET) else '1';
    adc_soft_reset <= '1' when (current_gen_sync_state = GEN_ADC_CORE_RESET) else '0';
    
    gen_adc_reset_counter : process(reset, clk)
    begin
        if (reset = '1')then
            adc_reset_counter <= (others => '0');
        elsif (rising_edge(clk))then
            if (adc_reset_counter_reset = '1')then
                adc_reset_counter <= (others => '0');
            else
                adc_reset_counter <= adc_reset_counter + X"01";
            end if;
        end if;
    end process;

----------------------------------------------------------------------------------------------
-- REGISTER OUTPUT TO IMPROVE TIMING
----------------------------------------------------------------------------------------------

    gen_adc_pll_sync : process(clk)
    begin
        if (rising_edge(clk))then
            adc_pll_sync <= adc_pll_sync_i;
        end if;
    end process;

----------------------------------------------------------------------------------------------
-- TRIPLE REGISTER RESET
----------------------------------------------------------------------------------------------

    gen_adc_user_rst : process(adc_user_clk)
    begin
        if (rising_edge(adc_user_clk))then
            adc_user_rst_i_z <= adc_user_rst_i;
            adc_user_rst_i_z2 <= adc_user_rst_i_z;
            adc_user_rst_i_z3 <= adc_user_rst_i_z2;
            adc_user_rst <= adc_user_rst_i_z3;
        end if;
    end process;  
    
end arch_adc_pll_sync_generator;
