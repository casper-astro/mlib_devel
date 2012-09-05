-- ****************************************************************************
-- Name: mkadc_interface.vhd - meerKAT ADC interface
-- Date: 19 July 2012
-- Author: Henno 
-- email: henno@ska.ac.za
--
-- This module clocks the incomming ADC demux by 2, DDR, 10bit data into the FPGA
-- The clock rate in is DDR => ADC Clock Rate / 2 (demux 2) / 2 (DDR)
-- This module further demuxes by 2 and this clock is supplied to the gateware
-- 
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
    generic(G_GRAY_EN : std_logic := '1');
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
    -- sync
    signal adc_sync  : std_logic;
    -- out of range
    signal adc_or_a  : std_logic;
    signal adc_or_b  : std_logic;
    -- data
    signal adc_data_a       : std_logic_vector(9 downto 0);
    signal adc_data_b       : std_logic_vector(9 downto 0);
    signal adc_dataevenq    : std_logic_vector(9 downto 0);
    signal adc_dataoddq     : std_logic_vector(9 downto 0);

    --------------------------------------
    -- half rate signals
    --------------------------------------
    -- out of range
    signal adc_or_demuxed_x4_a  : std_logic_vector(1 downto 0);
    signal adc_or_demuxed_x4_b  : std_logic_vector(1 downto 0);
    signal adc_or_demuxed_x4    : std_logic_vector(3 downto 0);
    signal adc_or_demuxed_x4R   : std_logic_vector(3 downto 0);
    signal adc_or_ddr          : std_logic_vector(3 downto 0);
    -- data
    signal adc_data_demuxed_x4  : std_logic_vector(39 downto 0);
    signal adc_data_demuxed_x4R : std_logic_vector(39 downto 0);
    signal adc_data_ddr        : std_logic_vector(39 downto 0);
    -- sync
    signal adc_sync_demuxed_x4  : std_logic_vector(1 downto 0);
    signal adc_sync_demuxed_x4R : std_logic_vector(1 downto 0);
    signal adc_sync_ddr        : std_logic_vector(1 downto 0);

    --------------------------------------
    -- fifo signals
    --------------------------------------

    signal fifo_din_even       : std_logic_vector(71 downto 0);
    signal fifo_dout_even      : std_logic_vector(71 downto 0);    
    signal fifo_empty_even     : std_logic;
    
    signal fifo_din_odd        : std_logic_vector(71 downto 0);
    signal fifo_dout_odd       : std_logic_vector(71 downto 0);
    signal fifo_empty_odd      : std_logic;
    
    signal fifo_rd_en          : std_logic := '0';

    --------------------------------------
    -- demux signals
    --------------------------------------

     
    signal adc_or_demuxed_x4_odd : std_logic_vector(3 downto 0);
    signal adc_data_demuxed_x4_odd : std_logic_vector(39 downto 0);
    signal adc_sync_demuxed_x4_odd : std_logic_vector(1 downto 0);
    
    signal adc_or_demuxed_x4_even : std_logic_vector(3 downto 0);
    signal adc_data_demuxed_x4_even : std_logic_vector(39 downto 0);
    signal adc_sync_demuxed_x4_even : std_logic_vector(1 downto 0);
         
    signal sEven : std_logic;
    signal sOdd  : std_logic;
    
    signal sMMCM_locked : std_logic;
    signal sRst : std_logic;
    
    signal sTick : std_logic_vector(31 downto 0);
    signal sTicki : std_logic;

    signal user_data_valid_i : std_logic;
    signal user_data_valid_iR : std_logic;

    signal user_data0_i :  std_logic_vector(9 downto 0);
    signal user_data1_i :  std_logic_vector(9 downto 0);
    signal user_data2_i :  std_logic_vector(9 downto 0);
    signal user_data3_i :  std_logic_vector(9 downto 0);
    signal user_data4_i :  std_logic_vector(9 downto 0);
    signal user_data5_i :  std_logic_vector(9 downto 0);
    signal user_data6_i :  std_logic_vector(9 downto 0);
    signal user_data7_i :  std_logic_vector(9 downto 0);

    signal adc_clk_i : std_logic;     
    
    ----------------------------------------
    -- Clock signals
    ----------------------------------------
    signal adc_clk              : std_logic;
    signal adc_clk_fb           : std_logic;
    signal adc_clk90            : std_logic;
    signal adc_clk180           : std_logic;
    signal adc_clk270           : std_logic;
    signal adc_clk_fb_mmcm      : std_logic;
    signal adc_clk_buf          : std_logic;
    signal adc_clk_buf_i        : std_logic;
    signal adc_clk_mmcm         : std_logic;
    signal adc_clk90_mmcm       : std_logic;
    signal adc_clk180_mmcm       : std_logic;
    signal adc_clk_div2_mmcm         : std_logic;
    signal adc_clk_div2_90_mmcm       : std_logic;
    signal adc_clk_div2_180_mmcm      : std_logic;
    signal adc_clk_div2_270_mmcm      : std_logic;
    signal adc_clk270_mmcm      : std_logic;
    signal adc_clk_div2         : std_logic;
    signal adc_clk_div2_90       : std_logic;
    signal adc_clk_div2_180      : std_logic;
    signal adc_clk_div2_270      : std_logic;

    ----------------------------------------
    -- Input differential buffer
    ----------------------------------------
    component IBUFGDS
        port (
            I  : in  std_logic;
            IB : in  std_logic;
            O  : out std_logic
        );
    end component;

    ----------------------------------------
    -- Input differential buffer
    ----------------------------------------
    component IBUFDS
        port (
            I  : in  std_logic;
            IB : in  std_logic;
            O  : out std_logic
        );
    end component;

    ----------------------------------------
    -- Output differential buffer
    ----------------------------------------
    component OBUFDS
        port (
            O  : out std_logic;
            OB : out std_logic;
            I  : in  std_logic
        );
    end component;

    ----------------------------------------
    -- Global clock buffer
    ----------------------------------------
    component BUFG
        port (
            I  : in  std_logic;
            O  : out std_logic
        );
    end component;

    ----------------------------------------
    -- Asynchronous FIFO
    ----------------------------------------

    component adc_fifo
        port (
            din    : IN  std_logic_VECTOR(71 downto 0);
            rd_clk : IN  std_logic;
            rd_en  : IN  std_logic;
            rst    : IN  std_logic;
            wr_clk : IN  std_logic;
            wr_en  : IN  std_logic;
            dout   : OUT std_logic_VECTOR(71 downto 0);
            empty  : OUT std_logic;
            full   : OUT std_logic;
            valid  : OUT std_logic
        );
    end component;

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

    ----------------------------------------
    -- DDR Input Register
    ----------------------------------------

    component ddr_input
        port (
            clk   : in  std_logic;
            d     : in  std_logic;
            rst   : in  std_logic := '0';
            qrise : out std_logic;
            qfall : out std_logic
        );
    end component;   

    component IODELAYE1
        generic (
            DELAY_SRC : string  := "CLKIN";
            HIGH_PERFORMANCE_MODE : string  := "TRUE";
            IDELAY_TYPE : string  := "FIXED";
            IDELAY_VALUE : integer :=13;
            REFCLK_FREQUENCY : real := 200.0;
            SIGNAL_PATTERN : string  :="CLOCK"
        );
        port (
            DATAOUT : out  std_logic;
            CLKIN : in  std_logic;
            RST : in  std_logic
        );
    end component; 


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

--
-- ADC Sample Sequence
-- 1    2    3    4 
-- A(R) B(R) A(F) B(F) 

----------------------------------------
-- Capture the value of the DDR data pins
--
-- This uses the ddr_input component as recommended in the
-- Virtex-II Pro User Guide [UG012 (v4.0) 23 March 2005, pp 250-1]
----------------------------------------
ADC_DATA_DDR_i: for i in adc_data_a'range generate
    adc_data_a_ddr: ddr_input port map (
        clk   => adc_clk_i,
        d     => adc_data_a(i),
        qrise => adc_data_ddr(i + 30),  -- A(R) Sample no 1
        qfall => adc_data_ddr(i +  10)  -- A(F) Sample no 3
    );
    adc_data_b_ddr: ddr_input port map (
        clk   => adc_clk_i,
        d     => adc_data_b(i),
        qrise => adc_data_ddr(i + 20),  -- B(R) Sample no 2
        qfall => adc_data_ddr(i +  0)   -- B(F) Sample no 4
    );
end generate;

adc_oori_ddr_a: ddr_input port map (
    clk   => adc_clk_i,
    d     => adc_or_a,
    qrise => adc_or_ddr(3),  -- A(R) Sample no 1
    qfall => adc_or_ddr(1)   -- A(F) Sample no 3
);

adc_oori_ddr_b: ddr_input port map (
    clk   => adc_clk_i,
    d     => adc_or_b,
    qrise => adc_or_ddr(2),  -- B(R) Sample no 2
    qfall => adc_or_ddr(0)   -- B(F) Sample no 3
);

adc_sync_ddr_inst: ddr_input port map (
    clk   => adc_clk_i,
    d     => adc_sync,
    qrise => adc_sync_ddr(1), 
    qfall => adc_sync_ddr(0)   
);

-----------------------------------------------------
-- Re-capture all DDR inputs to adc_clk's rising edge
-----------------------------------------------------
ADC_RECAPTURE_PROC : process(adc_clk_i) is
begin
    if adc_clk_i'event and adc_clk_i = '1' then
        adc_sync_demuxed_x4   <= adc_sync_ddr;
        adc_or_demuxed_x4_a   <= adc_or_ddr(3) & adc_or_ddr(1);
        adc_or_demuxed_x4_b   <= adc_or_ddr(2) & adc_or_ddr(0);
        adc_data_demuxed_x4   <= adc_data_ddr;
        adc_sync_demuxed_x4R  <= adc_sync_demuxed_x4;
        adc_or_demuxed_x4R    <= adc_or_demuxed_x4_a(1) & adc_or_demuxed_x4_b(1) & adc_or_demuxed_x4_a(0) & adc_or_demuxed_x4_b(0);
        adc_data_demuxed_x4R  <= adc_data_demuxed_x4;
    end if;
end process;

---------------------------------------------------------------------------------------------------------------
-- Demux 4 to 8

--
-- ADC Sample Sequence
--
-- R - Rising, F - Falling, E - Even, O - Odd
-- 
-- 1            2              3             4           5             6             7             8   
-- A(R)         B(R)           A(F)          B(F)        A(R)          B(R)          A(F)          B(F)
-- 39 - 30 (E)  29 - 20 (E)    19 - 10 (E)   9 - 0 (E)   39 - 30 (O)   29 - 20 (O)   19 - 10 (O)   9 - 0 (O)
-- 
----------------------------------------------------------------------------------------------------------------

DEMUX_4_TO_8 : process(adc_clk_i,sRst) is
begin
    if sRst = '1' then
        sEven <= '1';
        sOdd  <= '1';
    elsif adc_clk_i'event and adc_clk_i = '1' then
        sEven <= not sEven;
        sOdd <= not sOdd;
        if sEven = '1' then
            adc_or_demuxed_x4_even <= adc_or_demuxed_x4R;
            adc_data_demuxed_x4_even <= adc_data_demuxed_x4R;
            adc_sync_demuxed_x4_even <= adc_sync_demuxed_x4R;
        end if;
        if sOdd = '0' then
            adc_or_demuxed_x4_odd <= adc_or_demuxed_x4R;
            adc_data_demuxed_x4_odd <= adc_data_demuxed_x4R;
            adc_sync_demuxed_x4_odd <= adc_sync_demuxed_x4R;
        end if;
    end if;
end process;

--------------------------------------------------------------------------------
-- Asynchronous FIFO for clock boundary crossing from ADC Clock to ADC Clock / 2
--------------------------------------------------------------------------------

-- Read enable managment
FIFO_RD_EN_PROC : process(ctrl_clk_in, sRst) is
begin
    if sRst = '1' then
        fifo_rd_en <= '0';
    else
        if ctrl_clk_in'event and ctrl_clk_in = '1' then            
            if fifo_empty_even = '0' and fifo_empty_odd = '0' then
              fifo_rd_en <= '1';
            else
              fifo_rd_en <= '0';
            end if;

            if G_GRAY_EN = '1' then
                user_data7_i <= gray_to_bin(fifo_dout_odd( 9 downto 0 ));  -- ADC Sample No 8
                user_data6_i <= gray_to_bin(fifo_dout_odd(19 downto 10));  -- ADC Sample No 7
                user_data5_i <= gray_to_bin(fifo_dout_odd(29 downto 20));  -- ADC Sample No 6 
                user_data4_i <= gray_to_bin(fifo_dout_odd(39 downto 30));  -- ADC Sample No 5
                user_data3_i <= gray_to_bin(fifo_dout_even( 9 downto 0 )); -- ADC Sample No 4
                user_data2_i <= gray_to_bin(fifo_dout_even(19 downto 10)); -- ADC Sample No 3
                user_data1_i <= gray_to_bin(fifo_dout_even(29 downto 20)); -- ADC Sample No 2
                user_data0_i <= gray_to_bin(fifo_dout_even(39 downto 30)); -- ADC Sample No 1
            else
                user_data7_i <= fifo_dout_odd( 9 downto 0 );  -- ADC Sample No 8
                user_data6_i <= fifo_dout_odd(19 downto 10);  -- ADC Sample No 7
                user_data5_i <= fifo_dout_odd(29 downto 20);  -- ADC Sample No 6 
                user_data4_i <= fifo_dout_odd(39 downto 30);  -- ADC Sample No 5
                user_data3_i <= fifo_dout_even( 9 downto 0 ); -- ADC Sample No 4
                user_data2_i <= fifo_dout_even(19 downto 10); -- ADC Sample No 3
                user_data1_i <= fifo_dout_even(29 downto 20); -- ADC Sample No 2
                user_data0_i <= fifo_dout_even(39 downto 30); -- ADC Sample No 1
            end if;

            user_data7 <= user_data7_i;
            user_data6 <= user_data6_i;
            user_data5 <= user_data5_i;
            user_data4 <= user_data4_i;
            user_data3 <= user_data3_i;
            user_data2 <= user_data2_i;
            user_data1 <= user_data1_i;
            user_data0 <= user_data0_i;

            user_outofrange7 <= '0';
            user_outofrange6 <= '0';
            user_outofrange5 <= '0';
            user_outofrange4 <= '0';
            user_outofrange3 <= '0';
            user_outofrange2 <= '0';
            user_outofrange1 <= '0';
            user_outofrange0 <= '0';

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

            user_sync          <= fifo_dout_even(45) or fifo_dout_even(44) or fifo_dout_odd(45) or fifo_dout_odd(44);
            user_data_valid_iR <= user_data_valid_i;
            user_data_valid    <= user_data_valid_iR;
        end if;        
    end if;
end process;

-- FIFO signals assignment
fifo_din_even(45 downto 0) <= adc_sync_demuxed_x4_even & adc_or_demuxed_x4_even & adc_data_demuxed_x4_even; -- ADC Sample No 3 - 1
fifo_din_odd(45 downto 0)  <= adc_sync_demuxed_x4_odd & adc_or_demuxed_x4_odd &  adc_data_demuxed_x4_odd; -- ADC Sample No 8 - 4



-- Async FIFO
ADC_ASYNC_FIFO_EVEN : adc_fifo
    port map (
        wr_clk => adc_clk_i, 
        wr_en  => sEven,
        din    => fifo_din_even,
        full   => open,

        rd_clk => ctrl_clk_in, -- adc_clk/2
        rd_en  => fifo_rd_en,
        dout   => fifo_dout_even,
        empty  => fifo_empty_even,
        valid  => open,

        rst    => sRst
    );

-- Async FIFO
ADC_ASYNC_FIFO_ODD : adc_fifo
    port map (
        wr_clk => adc_clk_i,
        wr_en  => sOdd,
        din    => fifo_din_odd,
        full   => open,

        rd_clk => ctrl_clk_in, -- adc_clk/2
        rd_en  => fifo_rd_en,
        dout   => fifo_dout_odd,
        empty  => fifo_empty_odd,
        valid  => user_data_valid_i,

        rst    => sRst
    );

    
----------------------------------------
-- Sync differential input buffer
----------------------------------------

IBUFDS_SYNC : IBUFDS
    port map ( I => adc_sync_p, IB => adc_sync_n, O => adc_sync);

-----------------------------------------------
-- Over Range (OR) differential input buffers
-----------------------------------------------

IBUFDS_OUTOFRANGEI : IBUFDS
    port map ( I => adc_or_a_p, IB => adc_or_a_n, O => adc_or_a);  -- Demux Port A OR
IBUFDS_OUTOFRANGEQ : IBUFDS
    port map ( I  => adc_or_b_p, IB => adc_or_b_n, O => adc_or_b); -- Demux Port B OR

---------------------------------------------------
-- Data differential input buffers from ADC Demux
---------------------------------------------------

IBUFDC_DATA: for i in adc_data_a'range generate
    -- Even samples, Demux Port A
    IBUFDS_DATAEVENI : IBUFDS port map (
        I  => adc_data_a_p(i),
        IB => adc_data_a_n(i),
        O  => adc_data_a(i)
    );

    -- Odd samples, Demux Port B
    IBUFDS_DATAODDI : IBUFDS port map (
        I  => adc_data_b_p(i),
        IB => adc_data_b_n(i),
        O  => adc_data_b(i)
    );
end generate;

----------------------------------------
-- Clock buffers
----------------------------------------

-------------------------------------------
-- Global Clock Input Differential Buffer
-------------------------------------------
IBUFDS_CLK : IBUFGDS
    port map ( I => adc_clk_p, IB => adc_clk_n, O => adc_clk_buf);

--IODELAYE1_inst : IODELAYE1
--generic map (
--    DELAY_SRC => "CLKIN",
--    HIGH_PERFORMANCE_MODE => "TRUE",
--    IDELAY_TYPE => "FIXED",
--    IDELAY_VALUE => 1,
--    REFCLK_FREQUENCY => 200.0,
--    SIGNAL_PATTERN => "CLOCK"
--)
--port map (
--    DATAOUT => adc_clk_i,
--    CLKIN => adc_clk,
--    RST => power_on_rst
--);

-------------------------------------------
-- Global Clock Buffers
-------------------------------------------
CLK_CLKBUF : BUFG
    port map ( I => adc_clk_mmcm,    O => adc_clk);
CLKFB_CLKBUF : BUFG
    port map ( I => adc_clk_fb_mmcm, O => adc_clk_fb);
CLK_DIV2_CLKBUF : BUFG
    port map ( I => adc_clk_div2_mmcm,    O => adc_clk_div2);
CLK_DIV2_90_CLKBUF : BUFG
    port map ( I => adc_clk_div2_90_mmcm,  O => adc_clk_div2_90);
CLK_DIV2_180_CLKBUF : BUFG
    port map ( I => adc_clk_div2_180_mmcm, O => adc_clk_div2_180);
CLK_DIV2_270_CLKBUF : BUFG
    port map ( I => adc_clk_div2_270_mmcm, O => adc_clk_div2_270);
CLK_90_CLKBUF : BUFG
    port map ( I => adc_clk90_mmcm,  O => adc_clk90);
CLK_180_CLKBUF : BUFG
    port map ( I => adc_clk180_mmcm,  O => adc_clk180);

adc_clk_i <= adc_clk180;

ctrl_clk_out    <= adc_clk_div2;
ctrl_clk90_out  <= adc_clk_div2_90;
ctrl_clk180_out <= adc_clk_div2_180;
ctrl_clk270_out <= adc_clk_div2_270;

-- MMCM VCO frequency for this device of 600.000000 - 1200.000000 MHz

CLKSHIFT_MMCM : MMCM_BASE
    generic map(
        BANDWIDTH          => "OPTIMIZED",  -- Jitter programming ("HIGH","LOW","OPTIMIZED")
        CLKFBOUT_MULT_F    => 12,            -- Multiply value for all CLKOUT (5.0-64.0). THIS IS THE MULTIPLIER
        CLKFBOUT_PHASE     => 0.0,
        CLKIN1_PERIOD      => 1000.0/450.0, -- ADC CLK = 1800MHz, Demux DDR Clock = 1800/4 = 450MHz (2.2ns), GATEWARE Clock = DDR Clock/2 = 225MHz(4.4ns) 
        CLKOUT0_DIVIDE_F   => 2,            -- Divide amount for CLKOUT0 (1.000-128.000).
        CLKOUT0_DUTY_CYCLE => 0.5,
        CLKOUT1_DUTY_CYCLE => 0.5,
        CLKOUT2_DUTY_CYCLE => 0.5,
        CLKOUT3_DUTY_CYCLE => 0.5,
        CLKOUT4_DUTY_CYCLE => 0.5,
        CLKOUT5_DUTY_CYCLE => 0.5,
        CLKOUT6_DUTY_CYCLE => 0.5,
        CLKOUT0_PHASE      => 0.0,
        CLKOUT1_PHASE      => 90,
        CLKOUT2_PHASE      => 180,
        CLKOUT3_PHASE      => 270,
        CLKOUT4_PHASE      => 0.0,
        CLKOUT5_PHASE      => 278.0,
        CLKOUT6_PHASE      => 188.0,
        --                                 F = ((Fin * CLKFBOUT_MULT_F) / DIVCLK_DIVIDE) / CLKOUTx_DIVIDE
        CLKOUT1_DIVIDE     => 4,           -- THIS IS THE DIVISOR (((450MHz * 12)/6) / 4) = 225MHz
        CLKOUT2_DIVIDE     => 4,
        CLKOUT3_DIVIDE     => 4,
        CLKOUT4_DIVIDE     => 4,
        CLKOUT5_DIVIDE     => 2,           -- THIS IS THE DIVISOR (((450MHz * 12)/6) / 2) = 450MHz
        CLKOUT6_DIVIDE     => 2,
        CLKOUT4_CASCADE    => "FALSE",
        CLOCK_HOLD         => "FALSE",
        DIVCLK_DIVIDE      => 6,            -- Master division value (1-80)
        REF_JITTER1        => 0.0,
        STARTUP_WAIT       => "FALSE")
    port map(
        CLKIN1    => adc_clk_buf,
        CLKFBIN   => adc_clk_fb,
        
        CLKFBOUT  => adc_clk_fb_mmcm,
        CLKFBOUTB => open,
        
        CLKOUT0   => adc_clk_mmcm,
        CLKOUT0B  => open,
        CLKOUT1   => adc_clk_div2_90_mmcm,
        CLKOUT1B  => open,
        CLKOUT2   => adc_clk_div2_180_mmcm,
        CLKOUT2B  => open,
        CLKOUT3   => adc_clk_div2_270_mmcm,
        CLKOUT3B  => open,
        CLKOUT4   => adc_clk_div2_mmcm,
        CLKOUT5   => adc_clk270_mmcm,
        CLKOUT6   => adc_clk180_mmcm,
        LOCKED    => sMMCM_locked,
        
        PWRDWN    => '0',
        RST       => power_on_rst
    );
    
    mmcm_psdone <= sMMCM_locked;
    ctrl_mmcm_locked <= sMMCM_locked;

    
    adc_demux_bist <= not user_bist;
    adc_reset <= '0';   
    sRst <= not sMMCM_locked;

--     -- Read enable managment
-- READ_IIC_TEMP : process(ctrl_clk_in, sRst) is
-- begin
--     if sRst = '1' then
--         clk_en <= '0';
--         scl <= '1';
--         bit_clk <= '1';
--         clk_cnt <= (others=>'0');
--         edge_detect <= "11";
--         sIICdata <= '0' & x"4c" & '1' & x"00" & x"1"   &   '0' & x"4d" & '1' & x"ff" & '0' & x"1";
--     else
--         if ctrl_clk_in'event and ctrl_clk_in = '1' then 
--             clk_cnt <= clk_cnt + '1';
--             if clk_cnt = 100e3 then
--                 clk_cnt <= (others=>'0');
--                 bit_clk <= not bit_clk;
--             end if; 

--             edge_detect <= edge_detect(0) & bit_clk;

--             if edge_detect = "10" then
--                 bit_idx <= bit_idx + '1';
--             end if;

--             if bit_idx <= 32 then
--               sda <= '1';              
--             end if;

--             if (bit_idx > 33) and (bit_idx <) then
--               sda <= sIICdata(bit_idx-33);
--               clk_en <= '1';
--             end if;
--         end if;
--     end if;
-- end process;

-- scl <= '1' when (clk_en = '0') else bit_clk;
    
end IMP;
