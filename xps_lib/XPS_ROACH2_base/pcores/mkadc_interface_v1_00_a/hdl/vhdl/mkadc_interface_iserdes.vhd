-- ****************************************************************************
-- Name: mkadc_interface_iserdes.vhd - meerKAT ADC interface ADC1x1800-10
-- Date: 19 July 2012
-- Author: Henno 
-- email: henno@ska.ac.za
--
-- This module interfaces to the e2v AT84AS008 ADC, with demux by 2 AT84CS001 
-- This module clocks the incomming ADC demux by 2, DDR, 10bit data into the FPGA
-- The clock rate in is DDR => ADC Clock Rate / 2 (demux 2) / 2 (DDR)
-- This module further demuxes by 2 and this clock is supplied to the gateware
-- 
-- This block uses a modified version of the Asia A 5G ADC interface with ISERDES demux
--
-- ADC
-- 10b x ADC Clk
--
-- DEMUX 2
-- 10b x 2 x ADC Clk / 2
-- DDR
-- 10b x 4 x ADC Clk / 4
--
-- FPGA
-- 10b x 8 x ADC Clk / 8
-- ****************************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

--------------------------------------------------------------------------------
-- Entity section
--------------------------------------------------------------------------------

entity mkadc_interface is
    generic(
        G_GRAY_EN : std_logic := '1';
        adc_bit_width   : integer := 10
        );
    port
    (
        --------------------------------------
        -- differential signals from/to the ADC
        --------------------------------------
        -- clocks
        adc_clk_p           : in std_logic;
        adc_clk_n           : in std_logic;
        -- sync
        adc_sync_p          : in std_logic;
        adc_sync_n          : in std_logic;
        -- out of range
        adc_or_a_p          : in std_logic;
        adc_or_a_n          : in std_logic;
        adc_or_b_p          : in std_logic;
        adc_or_b_n          : in std_logic;
        -- data
        adc_data_a_p        : in std_logic_vector(9 downto 0);
        adc_data_a_n        : in std_logic_vector(9 downto 0);
        adc_data_b_p        : in std_logic_vector(9 downto 0);
        adc_data_b_n        : in std_logic_vector(9 downto 0);
        -- adc reset => Hardwire to '0', else we have no clock.....
        adc_reset           : out std_logic;
        -- Enable ADC DEMUX test pattern  
        adc_demux_bist      : out std_logic; -- Checker Board 

        --------------------------------------
        -- demuxed data from the ADC
        --------------------------------------
        -- control
        user_bist           : in std_logic;
        -- data
        user_data0          : out std_logic_vector(9 downto 0);
        user_data1          : out std_logic_vector(9 downto 0);
        user_data2          : out std_logic_vector(9 downto 0);
        user_data3          : out std_logic_vector(9 downto 0);
        user_data4          : out std_logic_vector(9 downto 0);
        user_data5          : out std_logic_vector(9 downto 0);
        user_data6          : out std_logic_vector(9 downto 0);
        user_data7          : out std_logic_vector(9 downto 0);
        -- out of range
        user_outofrange0    : out std_logic;
        user_outofrange1    : out std_logic;
        user_outofrange2    : out std_logic;
        user_outofrange3    : out std_logic;
        user_outofrange4    : out std_logic;
        user_outofrange5    : out std_logic;
        user_outofrange6    : out std_logic;
        user_outofrange7    : out std_logic;                
        -- sync
        user_sync           : out std_logic;
        -- data valid
        user_data_valid     : out std_logic;

        --------------------------------------
        -- system ports
        --------------------------------------
        power_on_rst        : in std_logic;
        mmcm_reset          : in std_logic;
        ctrl_reset          : in std_logic;
        ctrl_clk_in         : in std_logic;
        ctrl_clk_out        : out std_logic;
        ctrl_clk90_out      : out std_logic;
        ctrl_clk180_out     : out std_logic;
        ctrl_clk270_out     : out std_logic;
        ctrl_mmcm_locked    : out std_logic;
        -- dcm clock shift
        mmcm_psclk          : in std_logic := '0';
        mmcm_psen           : in std_logic := '0';
        mmcm_psincdec       : in std_logic := '0';
        mmcm_psdone         : out std_logic := '0'        
    );
end entity mkadc_interface;

--------------------------------------------------------------------------------
-- Architecture section
--------------------------------------------------------------------------------

architecture IMP of mkadc_interface is

    --------------------------------------
    -- signals from the ADC
    -------------------------------------- 
    signal sMMCM_locked : std_logic;
    signal sRst : std_logic;
    
    signal adc_sync_i : std_logic;
    signal user_sync_i : std_logic;

    signal user_data0_i :  std_logic_vector(9 downto 0);
    signal user_data1_i :  std_logic_vector(9 downto 0);
    signal user_data2_i :  std_logic_vector(9 downto 0);
    signal user_data3_i :  std_logic_vector(9 downto 0);
    signal user_data4_i :  std_logic_vector(9 downto 0);
    signal user_data5_i :  std_logic_vector(9 downto 0);
    signal user_data6_i :  std_logic_vector(9 downto 0);
    signal user_data7_i :  std_logic_vector(9 downto 0);

    signal adc_data0_i :  std_logic_vector(9 downto 0);
    signal adc_data1_i :  std_logic_vector(9 downto 0);
    signal adc_data2_i :  std_logic_vector(9 downto 0);
    signal adc_data3_i :  std_logic_vector(9 downto 0);
    signal adc_data4_i :  std_logic_vector(9 downto 0);
    signal adc_data5_i :  std_logic_vector(9 downto 0);
    signal adc_data6_i :  std_logic_vector(9 downto 0);
    signal adc_data7_i :  std_logic_vector(9 downto 0);

    -- MMCM VCO frequency for this device of 600.000000 - 1200.000000 MHz
    component MMCM_BASE
        generic (
            BANDWIDTH          : string  := "OPTIMIZED"; -- Jitter programming ("HIGH","LOW","OPTIMIZED")
            CLKFBOUT_MULT_F    : integer := 5;           -- Multiply value for all CLKOUT (5.0-64.0). THIS IS THE MULTIPLIER
            CLKFBOUT_PHASE     : real    := 0.0;
            CLKIN1_PERIOD      : real    := 2.2;         -- ADC CLK = 1800MHz, Demux DDR Clock = 1800/4 = 450MHz, GATEWARE Clock = DDR Clock/2 = 225MHz
            CLKOUT0_DIVIDE_F   : integer := 5;           -- Divide amount for CLKOUT0 (1.000-128.000).
            CLKOUT0_DUTY_CYCLE : real    := 0.5; 
            CLKOUT1_DUTY_CYCLE : real    := 0.5;
            CLKOUT2_DUTY_CYCLE : real    := 0.5;
            CLKOUT3_DUTY_CYCLE : real    := 0.5;
            CLKOUT4_DUTY_CYCLE : real    := 0.5;
            CLKOUT5_DUTY_CYCLE : real    := 0.5;
            CLKOUT6_DUTY_CYCLE : real    := 0.5;
            CLKOUT0_PHASE      : real    := 0.0;
            CLKOUT1_PHASE      : integer := 90;
            CLKOUT2_PHASE      : integer := 180;
            CLKOUT3_PHASE      : integer := 270;
            CLKOUT4_PHASE      : real    := 0.0;
            CLKOUT5_PHASE      : real    := 0.0;
            CLKOUT6_PHASE      : real    := 0.0;
            CLKOUT1_DIVIDE     : integer := 5;            -- THIS IS THE DIVISOR 
            CLKOUT2_DIVIDE     : integer := 5;
            CLKOUT3_DIVIDE     : integer := 5;
            CLKOUT4_DIVIDE     : integer := 1;
            CLKOUT5_DIVIDE     : integer := 1;
            CLKOUT6_DIVIDE     : integer := 1;
            CLKOUT4_CASCADE    : string  := "FALSE";
            CLOCK_HOLD         : string  := "FALSE";
            DIVCLK_DIVIDE      : integer := 1;            -- Master division value (1-80)
            REF_JITTER1        : real    := 0.0;
            STARTUP_WAIT       : string  := "FALSE"
        );
        port (
            CLKIN1    : in  std_logic;
            CLKFBIN   : in  std_logic;            
            CLKFBOUT  : out std_logic;
            CLKFBOUTB : out std_logic;            
            CLKOUT0   : out std_logic;
            CLKOUT0B  : out std_logic;
            CLKOUT1   : out std_logic;
            CLKOUT1B  : out std_logic;
            CLKOUT2   : out std_logic;
            CLKOUT2B  : out std_logic;
            CLKOUT3   : out std_logic;
            CLKOUT3B  : out std_logic;
            CLKOUT4   : out std_logic;
            CLKOUT5   : out std_logic;
            CLKOUT6   : out std_logic;
            LOCKED    : out std_logic;            
            PWRDWN    : in  std_logic;
            RST       : in  std_logic
        );
    end component;

  component adc5g_dmux1_interface is
    generic (  
        adc_bit_width   : integer :=10;
        clkin_period    : real    :=2.222;  -- clock in period (ns)
        mode            : integer :=1;    -- 1-channel mode
        mmcm_m          : real    :=2.0;  -- MMCM multiplier value
        mmcm_d          : integer :=1;    -- MMCM divide value
        mmcm_o0         : integer :=2;    -- MMCM first clock divide
        mmcm_o1         : integer :=2     -- MMCM second clock divide
    );
  port (
    adc_clk_p_i     : in std_logic;
    adc_clk_n_i     : in std_logic;
    adc_sync_p      : in std_logic;
    adc_sync_n      : in std_logic;
    dcm_reset       : in std_logic;
    dcm_psclk       : in std_logic;
    dcm_psen        : in std_logic;
    dcm_psincdec    : in std_logic;
    ctrl_reset      : in std_logic;
    ctrl_clk_in     : in std_logic;
    adc_data0_p_i   : in std_logic_vector(adc_bit_width-1 downto 0); --i0:i1
    adc_data0_n_i   : in std_logic_vector(adc_bit_width-1 downto 0); --i0:i1
    adc_data1_p_i   : in std_logic_vector(adc_bit_width-1 downto 0); --q0:q1
    adc_data1_n_i   : in std_logic_vector(adc_bit_width-1 downto 0); --q0:q1
    adc_data2_p_i   : in std_logic_vector(adc_bit_width-1 downto 0); --i2:i3
    adc_data2_n_i   : in std_logic_vector(adc_bit_width-1 downto 0); --i2:i3
    adc_data3_p_i   : in std_logic_vector(adc_bit_width-1 downto 0); --q2:q3
    adc_data3_n_i   : in std_logic_vector(adc_bit_width-1 downto 0); --q2:q3
    sync            : out std_logic;
    dcm_psdone      : out std_logic;
    ctrl_clk_out    : out std_logic;
    ctrl_clk90_out  : out std_logic;
    ctrl_clk180_out : out std_logic;
    ctrl_clk270_out : out std_logic;
    ctrl_dcm_locked : out std_logic;
    fifo_full_cnt   : out std_logic_vector(15 downto 0);
    fifo_empty_cnt  : out std_logic_vector(15 downto 0);
    user_data_i0    : out std_logic_vector(adc_bit_width-1 downto 0);
    user_data_i1    : out std_logic_vector(adc_bit_width-1 downto 0);
    user_data_i2    : out std_logic_vector(adc_bit_width-1 downto 0);
    user_data_i3    : out std_logic_vector(adc_bit_width-1 downto 0);
    user_data_i4    : out std_logic_vector(adc_bit_width-1 downto 0);
    user_data_i5    : out std_logic_vector(adc_bit_width-1 downto 0);
    user_data_i6    : out std_logic_vector(adc_bit_width-1 downto 0);
    user_data_i7    : out std_logic_vector(adc_bit_width-1 downto 0);
    user_data_q0    : out std_logic_vector(adc_bit_width-1 downto 0);
    user_data_q1    : out std_logic_vector(adc_bit_width-1 downto 0);
    user_data_q2    : out std_logic_vector(adc_bit_width-1 downto 0);
    user_data_q3    : out std_logic_vector(adc_bit_width-1 downto 0);
    user_data_q4    : out std_logic_vector(adc_bit_width-1 downto 0);
    user_data_q5    : out std_logic_vector(adc_bit_width-1 downto 0);
    user_data_q6    : out std_logic_vector(adc_bit_width-1 downto 0);
    user_data_q7    : out std_logic_vector(adc_bit_width-1 downto 0);
    adc_reset_o     : out std_logic
    );
end  component adc5g_dmux1_interface ;


function gray_to_bin (gray_bus: std_logic_vector(9 downto 0))
return std_logic_vector is
variable bin_bus: std_logic_vector(9 downto 0);

begin
    bin_bus(9) := gray_bus(9);
    bin_bus(8) := gray_bus(9) xor gray_bus(8);
    bin_bus(7) := (gray_bus(9) xor gray_bus(8)) xor gray_bus(7);
    bin_bus(6) := ((gray_bus(9) xor gray_bus(8)) xor gray_bus(7)) xor gray_bus(6);
    bin_bus(5) := (((gray_bus(9) xor gray_bus(8)) xor gray_bus(7)) xor gray_bus(6)) xor gray_bus(5);
    bin_bus(4) := ((((gray_bus(9) xor gray_bus(8)) xor gray_bus(7)) xor gray_bus(6)) xor gray_bus(5)) xor gray_bus(4);
    bin_bus(3) := (((((gray_bus(9) xor gray_bus(8)) xor gray_bus(7)) xor gray_bus(6)) xor gray_bus(5)) xor gray_bus(4)) xor gray_bus(3);
    bin_bus(2) := ((((((gray_bus(9) xor gray_bus(8)) xor gray_bus(7)) xor gray_bus(6)) xor gray_bus(5)) xor gray_bus(4)) xor gray_bus(3)) xor gray_bus(2);
    bin_bus(1) := (((((((gray_bus(9) xor gray_bus(8)) xor gray_bus(7)) xor gray_bus(6)) xor gray_bus(5)) xor gray_bus(4)) xor gray_bus(3)) xor gray_bus(2)) xor gray_bus(1);
    bin_bus(0) := ((((((((gray_bus(9) xor gray_bus(8)) xor gray_bus(7)) xor gray_bus(6)) xor gray_bus(5)) xor gray_bus(4)) xor gray_bus(3)) xor gray_bus(2)) xor gray_bus(1)) xor gray_bus(0);
    return bin_bus;
end gray_to_bin;

begin

-- Read enable managment
gen_user_data : process(ctrl_clk_in, sRst) is
begin
    if sRst = '1' then
      user_data7_i <= (others=>'0'); 
      user_data6_i <= (others=>'0');
      user_data5_i <= (others=>'0');
      user_data4_i <= (others=>'0');
      user_data3_i <= (others=>'0');
      user_data2_i <= (others=>'0');
      user_data1_i <= (others=>'0');
      user_data0_i <= (others=>'0');

      user_data7 <= (others=>'0'); 
      user_data6 <= (others=>'0');
      user_data5 <= (others=>'0');
      user_data4 <= (others=>'0');
      user_data3 <= (others=>'0');
      user_data2 <= (others=>'0');
      user_data1 <= (others=>'0');
      user_data0 <= (others=>'0');

      user_outofrange7 <= '0';
      user_outofrange6 <= '0';
      user_outofrange5 <= '0';
      user_outofrange4 <= '0';
      user_outofrange3 <= '0';
      user_outofrange2 <= '0';
      user_outofrange1 <= '0';
      user_outofrange0 <= '0';

      user_sync_i <= '0';
      user_sync   <= '0';

    else
        if ctrl_clk_in'event and ctrl_clk_in = '1' then 
                                            
            if user_bist = '0' then
                -- decode gray when not in checker board mode
                user_data7_i <= gray_to_bin(adc_data7_i);  -- ADC Sample No 8
                user_data6_i <= gray_to_bin(adc_data6_i);  -- ADC Sample No 7
                user_data5_i <= gray_to_bin(adc_data5_i);  -- ADC Sample No 6 
                user_data4_i <= gray_to_bin(adc_data4_i);  -- ADC Sample No 5
                user_data3_i <= gray_to_bin(adc_data3_i);  -- ADC Sample No 4
                user_data2_i <= gray_to_bin(adc_data2_i);  -- ADC Sample No 3
                user_data1_i <= gray_to_bin(adc_data1_i);  -- ADC Sample No 2
                user_data0_i <= gray_to_bin(adc_data0_i);  -- ADC Sample No 1
            else
                -- do NOT gray decode => checker board data
                user_data7_i <= adc_data7_i;  -- ADC Sample No 8
                user_data6_i <= adc_data6_i;  -- ADC Sample No 7
                user_data5_i <= adc_data5_i;  -- ADC Sample No 6 
                user_data4_i <= adc_data4_i;  -- ADC Sample No 5
                user_data3_i <= adc_data3_i;  -- ADC Sample No 4
                user_data2_i <= adc_data2_i;  -- ADC Sample No 3
                user_data1_i <= adc_data1_i;  -- ADC Sample No 2
                user_data0_i <= adc_data0_i;  -- ADC Sample No 1
            end if;

            user_data7 <= user_data7_i;
            user_data6 <= user_data6_i;
            user_data5 <= user_data5_i;
            user_data4 <= user_data4_i;
            user_data3 <= user_data3_i;
            user_data2 <= user_data2_i;
            user_data1 <= user_data1_i;
            user_data0 <= user_data0_i;

            -- default overrange to 0
            user_outofrange7 <= '0';
            user_outofrange6 <= '0';
            user_outofrange5 <= '0';
            user_outofrange4 <= '0';
            user_outofrange3 <= '0';
            user_outofrange2 <= '0';
            user_outofrange1 <= '0';
            user_outofrange0 <= '0';

            -- Generate over range signals, since the timing on the pins are bad

            -- ADC Sample No 8
            if user_data7_i = "1111111111" then
                user_outofrange7   <= '1';
            elsif user_data7_i = "0000000000" then
                user_outofrange7   <= '1'; 
            end if;

            -- ADC Sample No 7
            if user_data6_i = "1111111111" then
                user_outofrange6   <= '1';
            elsif user_data6_i = "0000000000" then
                user_outofrange6   <= '1';
            end if;

            -- ADC Sample No 6
            if user_data5_i = "1111111111" then
                user_outofrange5  <= '1';
            elsif user_data5_i = "0000000000" then
                user_outofrange5   <= '1';
            end if;

            -- ADC Sample No 5
            if user_data4_i = "1111111111" then
                user_outofrange4   <= '1';
            elsif user_data4_i = "0000000000" then
                user_outofrange4   <= '1';
            end if;

            -- ADC Sample No 4
            if user_data3_i = "1111111111" then
                user_outofrange3   <= '1';
            elsif user_data3_i = "0000000000" then
                user_outofrange3   <= '1'; 
            end if;

            -- ADC Sample No 3
            if user_data2_i = "1111111111" then
                user_outofrange2   <= '1';
            elsif user_data2_i = "0000000000" then
                user_outofrange2   <= '1';
            end if;

            -- ADC Sample No 2
            if user_data1_i = "1111111111" then
                user_outofrange1  <= '1';
            elsif user_data1_i = "0000000000" then
                user_outofrange1   <= '1';
            end if;

            -- ADC Sample No 1
            if user_data0_i = "1111111111" then
                user_outofrange0   <= '1';
            elsif user_data0_i = "0000000000" then
                user_outofrange0   <= '1';
            end if;

            user_sync_i        <= adc_sync_i;
            user_sync          <= user_sync_i;
            user_data_valid    <= '1';
        end if;        
    end if;
end process;

adc5g_inst: adc5g_dmux1_interface
  generic map(  
    adc_bit_width  => 10,
    clkin_period   => 2.222,  -- clock in period (ns)
    mode           => 1,    -- 1-channel mode
    mmcm_m         => 12.0,  -- MMCM multiplier value
    mmcm_d         => 6,    -- MMCM divide value
    mmcm_o0        => 2,    -- MMCM first clock divide
    mmcm_o1        => 4     -- MMCM second clock divide
    )
  port map (
    adc_clk_p_i     => adc_clk_p,
    adc_clk_n_i     => adc_clk_n,
    adc_sync_p      => adc_sync_p,
    adc_sync_n      => adc_sync_n,
    dcm_reset       => power_on_rst,
    dcm_psclk       => '0',
    dcm_psen        => '0',
    dcm_psincdec    => '0',
    ctrl_reset      => power_on_rst,
    ctrl_clk_in     => ctrl_clk_in,
    adc_data0_p_i   => adc_data_a_p,
    adc_data0_n_i   => adc_data_a_n,
    adc_data1_p_i   => adc_data_a_p, -- not used
    adc_data1_n_i   => adc_data_a_n, -- not used
    adc_data2_p_i   => adc_data_b_p,
    adc_data2_n_i   => adc_data_b_n,
    adc_data3_p_i   => adc_data_b_p, -- not used
    adc_data3_n_i   => adc_data_b_n, -- not used

    sync            => adc_sync_i,
    dcm_psdone      => mmcm_psdone,
    ctrl_clk_out    => ctrl_clk_out,    
    ctrl_clk90_out  => ctrl_clk90_out,  
    ctrl_clk180_out => ctrl_clk180_out, 
    ctrl_clk270_out => ctrl_clk270_out, 
    ctrl_dcm_locked => sMMCM_locked,
    fifo_full_cnt   => open,
    fifo_empty_cnt  => open,
    user_data_i0    => adc_data0_i,
    user_data_i1    => adc_data1_i,
    user_data_i2    => adc_data2_i,
    user_data_i3    => adc_data3_i,
    user_data_i4    => adc_data4_i,
    user_data_i5    => adc_data5_i,
    user_data_i6    => adc_data6_i,
    user_data_i7    => adc_data7_i,
    user_data_q0    => open,
    user_data_q1    => open,
    user_data_q2    => open,
    user_data_q3    => open,
    user_data_q4    => open,
    user_data_q5    => open,
    user_data_q6    => open,
    user_data_q7    => open,
    adc_reset_o     => open
    );    

    adc_demux_bist <= '0' when (user_bist = '1') else 
                      '1';
    adc_reset <= '0'; -- do NOT reset => no ADC clock.....
    sRst <= not sMMCM_locked;
    ctrl_mmcm_locked <= sMMCM_locked;
    
end IMP;
