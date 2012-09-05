------------------------------------------------------------------------------
-- mkadc_interface.vhd - meerKAT ADC interface
------------------------------------------------------------------------------
--
--  $Id$
--
--  Original author : Pierre-Yves Droz
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

--------------------------------------------------------------------------------
-- Entity section
--------------------------------------------------------------------------------

entity mkadc_interface is
    port
    (
        --------------------------------------
        -- differential signals from/to the ADC
        --------------------------------------
        -- clocks
        adc_clk_p         : in std_logic;
        adc_clk_n         : in std_logic;
        -- sync
        adc_sync_p        : in std_logic;
        adc_sync_n        : in std_logic;
        -- out of range
        adc_or_a_p : in std_logic;
        adc_or_a_n : in std_logic;
        adc_or_b_p : in std_logic;
        adc_or_b_n : in std_logic;
        -- data
        adc_data_a_p   : in std_logic_vector(9 downto 0);
        adc_data_a_n   : in std_logic_vector(9 downto 0);
        adc_data_b_p    : in std_logic_vector(9 downto 0);
        adc_data_b_n    : in std_logic_vector(9 downto 0);
        -- adc reset
        adc_reset         : out std_logic;
        -- ddr reset  
        demux_bist        : out std_logic;

        --------------------------------------
        -- demuxed data from the ADC
        --------------------------------------
        -- data
        user_data4       : out std_logic_vector(9 downto 0);
        user_data5       : out std_logic_vector(9 downto 0);
        user_data6       : out std_logic_vector(9 downto 0);
        user_data7       : out std_logic_vector(9 downto 0);
        user_data0       : out std_logic_vector(9 downto 0);
        user_data1       : out std_logic_vector(9 downto 0);
        user_data2       : out std_logic_vector(9 downto 0);
        user_data3       : out std_logic_vector(9 downto 0);
        -- out of range
        user_outofrange0 : out std_logic;
        user_outofrange1 : out std_logic;
        user_outofrange2 : out std_logic;
        user_outofrange3 : out std_logic;
        user_outofrange4 : out std_logic;
        user_outofrange5 : out std_logic;
        user_outofrange6 : out std_logic;
        user_outofrange7 : out std_logic;                
        -- sync
        user_sync0        : out std_logic;
        user_sync1        : out std_logic;
        user_sync2        : out std_logic;
        user_sync3        : out std_logic;
        user_sync4        : out std_logic;
        user_sync5        : out std_logic;
        user_sync6        : out std_logic;
        user_sync7        : out std_logic;
        -- data valid
        user_data_valid   : out std_logic;

        --------------------------------------
        -- system ports
        --------------------------------------
        mmcm_reset        : in std_logic;
        ctrl_reset        : in std_logic;
        ctrl_clk_in       : in std_logic;
        ctrl_clk_out      : out std_logic;
        ctrl_clk90_out    : out std_logic;
        ctrl_clk180_out   : out std_logic;
        ctrl_clk270_out   : out std_logic;
        ctrl_dcm_locked   : out std_logic;
        -- dcm clock shift
        dcm_psclk         : in std_logic := '0';
        dcm_psen          : in std_logic := '0';
        dcm_psincdec      : in std_logic := '0';
        mmcm_psdone       : out std_logic := '0';
        
        rst_o : out std_logic;
        tick_o : out std_logic;
        led : out std_logic;
        aux_synco_p : out std_logic; 
        aux_synco_n : out std_logic
        
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
    signal adc_sync         : std_logic;
    -- out of range
    signal adc_or_a  : std_logic;
    signal adc_or_b  : std_logic;
    -- data
    signal adc_data_a    : std_logic_vector(9 downto 0);
    signal adc_data_b     : std_logic_vector(9 downto 0);
    signal adc_dataevenq    : std_logic_vector(9 downto 0);
    signal adc_dataoddq     : std_logic_vector(9 downto 0);

    --------------------------------------
    -- half rate signals
    --------------------------------------
    -- out of range
    signal adc_or_demuxedx4    : std_logic_vector(3 downto 0);
    signal adc_or_b_recapture    : std_logic_vector(3 downto 0);
    signal adc_or_ddr          : std_logic_vector(3 downto 0);
    signal adc_or_b_ddr          : std_logic_vector(3 downto 0);
    -- data
    signal adc_data_demuxedx4          : std_logic_vector(39 downto 0);
    signal adc_dataq_recapture          : std_logic_vector(39 downto 0);
    signal adc_data_ddr                : std_logic_vector(39 downto 0);
    signal adc_dataq_ddr                : std_logic_vector(39 downto 0);
    -- sync
    signal adc_sync_demuxedx4           : std_logic_vector(3 downto 0);
    signal adc_sync_capture             : std_logic_vector(3 downto 0);
    signal adc_sync_ddr                 : std_logic_vector(3 downto 0);

    --------------------------------------
    -- fifo signals
    --------------------------------------

    signal fifo_din_even             : std_logic_vector(71 downto 0);
    signal fifo_dout_even            : std_logic_vector(71 downto 0);    
    signal fifo_empty_even           : std_logic;
    
    signal fifo_din_odd             : std_logic_vector(71 downto 0);
    signal fifo_dout_odd            : std_logic_vector(71 downto 0);
    signal fifo_empty_odd           : std_logic;
    
    signal fifo_rd_en                : std_logic := '0';

    --------------------------------------
    -- demux signals
    --------------------------------------

     
    signal adc_or_demuxedx4_odd : std_logic_vector(3 downto 0);
    signal adc_data_demuxedx4_odd : std_logic_vector(39 downto 0);
    signal adc_sync_demuxedx4_odd : std_logic_vector(3 downto 0);
    
    signal adc_or_demuxedx4_even : std_logic_vector(3 downto 0);
    signal adc_data_demuxedx4_even : std_logic_vector(39 downto 0);
    signal adc_sync_demuxedx4_even : std_logic_vector(3 downto 0);
         
    signal sEven : std_logic;
    
    signal sMMCM_locked : std_logic;
    signal sRst : std_logic;
    
    signal sTick : std_logic_vector(31 downto 0);
    signal sTicki : std_logic;
     
    
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
    signal adc_clk_mmcm         : std_logic;
    signal adc_clk90_mmcm       : std_logic;
    signal adc_clk_div2_mmcm         : std_logic;
    signal adc_clk_div2_90_mmcm       : std_logic;
    signal adc_clk_div2_180_mmcm      : std_logic;
    signal adc_clk_div2_270_mmcm      : std_logic;
    signal adc_clk_div2         : std_logic;
    signal adc_clk_div2_90       : std_logic;
    signal adc_clk_div2_180      : std_logic;
    signal adc_clk_div2_270      : std_logic;

    ----------------------------------------
    -- Keep constraints
    ----------------------------------------
    attribute keep : string;
    attribute keep of adc_sync_ddr: signal is "true";

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
            CLKIN1_PERIOD      : real    := 4.4;
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
begin

----------------------------------------
-- Capture the value of the sync on the different cloks
-- TODO: Capture 0 and 180 phases using a ddr_input component?
----------------------------------------
SYNC_CAPTURE_0_PROC : process(adc_clk) is
begin
    if adc_clk'event and adc_clk = '1' then
        adc_sync_ddr(3)             <= adc_sync;
    end if;
end process;

SYNC_CAPTURE_90_PROC : process(adc_clk90) is
begin
    if adc_clk90'event and adc_clk90 = '1' then
        adc_sync_ddr(2)             <= adc_sync;
    end if;
end process;

SYNC_CAPTURE_180_PROC : process(adc_clk) is
begin
    if adc_clk'event and adc_clk = '0' then
        adc_sync_ddr(1)             <= adc_sync;
    end if;
end process;

SYNC_CAPTURE_270_PROC : process(adc_clk90) is
begin
    if adc_clk90'event and adc_clk90 = '0' then
        adc_sync_ddr(0)             <= adc_sync;
    end if;
end process;

----------------------------------------
-- Intermediate capture to help with cross clock boundaries
----------------------------------------
SYNC_CAPTURE_0_0_PROC : process(adc_clk) is
begin
    if adc_clk'event and adc_clk = '1' then
        adc_sync_capture(3)             <= adc_sync_ddr(3);
    end if;
end process;

SYNC_CAPTURE_90_0_PROC : process(adc_clk) is
begin
    if adc_clk'event and adc_clk = '1' then
        adc_sync_capture(2)             <= adc_sync_ddr(2);
    end if;
end process;

SYNC_CAPTURE_180_90_PROC : process(adc_clk90) is
begin
    if adc_clk90'event and adc_clk90 = '1' then
        adc_sync_capture(1)             <= adc_sync_ddr(1);
    end if;
end process;

SYNC_CAPTURE_270_90_PROC : process(adc_clk90) is
begin
    if adc_clk90'event and adc_clk90 = '1' then
        adc_sync_capture(0)             <= adc_sync_ddr(0);
    end if;
end process;

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
        clk   => adc_clk,
        d     => adc_data_a(i),
        qrise => adc_data_ddr(i + 30),  -- A(R) Sample no 1
        qfall => adc_data_ddr(i +  10)  -- A(F) Sample no 3
    );
    adc_data_b_ddr: ddr_input port map (
        clk   => adc_clk,
        d     => adc_data_b(i),
        qrise => adc_data_ddr(i + 20),  -- B(R) Sample no 2
        qfall => adc_data_ddr(i +  0)   -- B(F) Sample no 3
    );
end generate;

adc_oori_ddr_a: ddr_input port map (
    clk   => adc_clk,
    d     => adc_or_a,
    qrise => adc_or_ddr(3),  -- A(R) Sample no 1
    qfall => adc_or_ddr(1)   -- A(F) Sample no 3
);

adc_oori_ddr_b: ddr_input port map (
    clk   => adc_clk,
    d     => adc_or_b,
    qrise => adc_or_ddr(2),  -- B(R) Sample no 2
    qfall => adc_or_ddr(0)   -- B(F) Sample no 3
);

-----------------------------------------------------
-- Re-capture all DDR inputs to adc_clk's rising edge
-----------------------------------------------------
ADC_RECAPTURE_PROC : process(adc_clk) is
begin
    if adc_clk'event and adc_clk = '1' then
        adc_or_demuxedx4    <= adc_or_ddr;
        adc_data_demuxedx4  <= adc_data_ddr;
        adc_sync_demuxedx4  <= adc_sync_capture;
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

DEMUX_4_TO_8 : process(adc_clk,sRst) is
begin
    if sRst = '1' then
        sEven <= '1';
    elsif adc_clk'event and adc_clk = '1' then
        sEven <= not sEven;
        if sEven = '1' then
            adc_or_demuxedx4_even <= adc_or_demuxedx4;
            adc_data_demuxedx4_even <= adc_data_demuxedx4;
            adc_sync_demuxedx4_even <= adc_sync_demuxedx4;
        else
            adc_or_demuxedx4_odd <= adc_or_demuxedx4;
            adc_data_demuxedx4_odd <= adc_data_demuxedx4;
            adc_sync_demuxedx4_odd <= adc_sync_demuxedx4;
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
        end if;
    end if;
end process;

-- FIFO signals assignment
fifo_din_even(47 downto 0) <= adc_sync_demuxedx4_even & adc_or_demuxedx4_even & adc_data_demuxedx4_even; -- ADC Sample No 3 - 1
fifo_din_odd(47 downto 0)  <=  adc_sync_demuxedx4_odd &  adc_or_demuxedx4_odd &  adc_data_demuxedx4_odd; -- ADC Sample No 8 - 4

user_data7         <= fifo_din_odd(39 downto 30);  -- ADC Sample No 8
user_data6         <= fifo_din_odd(29 downto 20);  -- ADC Sample No 7
user_data5         <= fifo_din_odd(19 downto 10);  -- ADC Sample No 6 
user_data4         <= fifo_din_odd( 9 downto 0 );  -- ADC Sample No 5
user_data3         <= fifo_din_even( 9 downto 0 ); -- ADC Sample No 4
user_data2         <= fifo_din_even(19 downto 10); -- ADC Sample No 3
user_data1         <= fifo_din_even(29 downto 20); -- ADC Sample No 2
user_data0         <= fifo_din_even(39 downto 30); -- ADC Sample No 1
user_outofrange7           <= fifo_din_odd(43);  -- ADC Sample No 8
user_outofrange6           <= fifo_din_odd(42);  -- ADC Sample No 7
user_outofrange5           <= fifo_din_odd(41);  -- ADC Sample No 6
user_outofrange4           <= fifo_din_odd(40);  -- ADC Sample No 5
user_outofrange3           <= fifo_din_even(43); -- ADC Sample No 4
user_outofrange2           <= fifo_din_even(42); -- ADC Sample No 3
user_outofrange1           <= fifo_din_even(41); -- ADC Sample No 2
user_outofrange0           <= fifo_din_even(40); -- ADC Sample No 1
user_sync7         <= fifo_din_odd(47);  -- ADC Sample No 8
user_sync6         <= fifo_din_odd(46);  -- ADC Sample No 7
user_sync5         <= fifo_din_odd(45);  -- ADC Sample No 6
user_sync4         <= fifo_din_odd(44);  -- ADC Sample No 5
user_sync3         <= fifo_din_even(47); -- ADC Sample No 4
user_sync2         <= fifo_din_even(46); -- ADC Sample No 3
user_sync1         <= fifo_din_even(45); -- ADC Sample No 2
user_sync0         <= fifo_din_even(44); -- ADC Sample No 1

-- Async FIFO
ADC_ASYNC_FIFO_EVEN : adc_fifo
    port map (
        wr_clk => adc_clk, 
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
        wr_clk => adc_clk,
        wr_en  => not(sEven),
        din    => fifo_din_odd,
        full   => open,

        rd_clk => ctrl_clk_in, -- adc_clk/2
        rd_en  => fifo_rd_en,
        dout   => fifo_dout_odd,
        empty  => fifo_empty_odd,
        valid  => user_data_valid,

        rst    => sRst
    );

    
adc_reset <= ctrl_reset;

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
-- Clock buffer
----------------------------------------

IBUFDS_CLK : IBUFGDS
    port map ( I => adc_clk_p, IB => adc_clk_n, O => adc_clk_buf);

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


ctrl_clk_out    <= adc_clk_div2;
ctrl_clk90_out  <= adc_clk_div2_90;
ctrl_clk180_out <= adc_clk_div2_180;
ctrl_clk270_out <= adc_clk_div2_270;

CLKSHIFT_MMCM : MMCM_BASE
    generic map(
        BANDWIDTH          => "OPTIMIZED", -- Jitter programming ("HIGH","LOW","OPTIMIZED")
        CLKFBOUT_MULT_F    => 5,           -- Multiply value for all CLKOUT (5.0-64.0). THIS IS THE MULTIPLIER
        CLKFBOUT_PHASE     => 0.0,
        CLKIN1_PERIOD      => 4.4,
        CLKOUT0_DIVIDE_F   => 5,           -- Divide amount for CLKOUT0 (1.000-128.000).
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
        CLKOUT5_PHASE      => 90.0,
        CLKOUT6_PHASE      => 0.0,
        CLKOUT1_DIVIDE     => 5,            -- THIS IS THE DIVISOR (5/10 = 0.5)
        CLKOUT2_DIVIDE     => 5,
        CLKOUT3_DIVIDE     => 5,
        CLKOUT4_DIVIDE     => 5,
        CLKOUT5_DIVIDE     => 5,
        CLKOUT6_DIVIDE     => 5,
        CLKOUT4_CASCADE    => "FALSE",
        CLOCK_HOLD         => "FALSE",
        DIVCLK_DIVIDE      => 1,            -- Master division value (1-80)
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
        CLKOUT5   => adc_clk90_mmcm,
        CLKOUT6   => open,
        LOCKED    => sMMCM_locked,
        
        PWRDWN    => '0',
        RST       => mmcm_reset
    );
    
    mmcm_psdone <= sMMCM_locked;
    
    demux_bist <= '0';
    
    rst_o <= sRst;
    
    sRst <= not sMMCM_locked;
    
pTick : process(adc_clk_buf) is
begin
    if rising_edge(adc_clk_buf) then
        sTick <= sTick + '1';
--     	if sTick = 225e6 then       		
--        		sTicki <= not sTicki;
--        		sTick <= (others => '0');
--        	else
--        	    sTick <= sTick + '1';
--        	end if;
    end if;

end process;
   
tick_o <= not sTick(25);--sTicki;

led <= '1';

aux_synco_p <=  sTick(0);
aux_synco_n <= '0';
    

end IMP;
