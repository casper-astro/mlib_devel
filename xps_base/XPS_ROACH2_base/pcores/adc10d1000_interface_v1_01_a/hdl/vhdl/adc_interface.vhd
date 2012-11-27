------------------------------------------------------------------------------
-- adc_interface.vhd - IBOB ADC interface
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

entity adc10d1000_interface is
    port
    (
        --------------------------------------
        -- differential signals from/to the ADC
        --------------------------------------
        -- clocks
        adc_clk_p         : in std_logic;
        adc_clk_n         : in std_logic;
--        adc_clkq_p         : in std_logic;
--        adc_clkq_n         : in std_logic;
        -- out of range
        adc_outofrangei_p : in std_logic;
        adc_outofrangei_n : in std_logic;
        adc_outofrangeq_p : in std_logic;
        adc_outofrangeq_n : in std_logic;
        -- data
        adc_dataeveni_p   : in std_logic_vector(9 downto 0);
        adc_dataeveni_n   : in std_logic_vector(9 downto 0);
        adc_dataoddi_p    : in std_logic_vector(9 downto 0);
        adc_dataoddi_n    : in std_logic_vector(9 downto 0);
        adc_dataevenq_p   : in std_logic_vector(9 downto 0);
        adc_dataevenq_n   : in std_logic_vector(9 downto 0);
        adc_dataoddq_p    : in std_logic_vector(9 downto 0);
        adc_dataoddq_n    : in std_logic_vector(9 downto 0);
        -- ddr reset
--       adc_ddrb_p        : out std_logic;
--       adc_ddrb_n        : out std_logic;

        --------------------------------------
        -- demuxed data from the ADC
        --------------------------------------
        -- data
        user_datai0       : out std_logic_vector(9 downto 0);
        user_datai1       : out std_logic_vector(9 downto 0);
        user_datai2       : out std_logic_vector(9 downto 0);
        user_datai3       : out std_logic_vector(9 downto 0);
        user_dataq0       : out std_logic_vector(9 downto 0);
        user_dataq1       : out std_logic_vector(9 downto 0);
        user_dataq2       : out std_logic_vector(9 downto 0);
        user_dataq3       : out std_logic_vector(9 downto 0);
        -- out of range
        user_outofrangei : out std_logic;
        user_outofrangeq : out std_logic;
        -- sync
        user_sync        : out std_logic;

	-- data valid
        user_data_valid   : out std_logic;

        --------------------------------------
        -- system ports
        --------------------------------------
        dcm_reset         : in std_logic;
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
        dcm_psdone        : out std_logic

    );
end entity adc10d1000_interface;

--------------------------------------------------------------------------------
-- Architecture section
--------------------------------------------------------------------------------

architecture IMP of adc10d1000_interface is

    --------------------------------------
    -- signals from the ADC
    --------------------------------------
    -- sync
    signal adc_sync         : std_logic;
    -- out of range
    signal adc_outofrangei  : std_logic;
    signal adc_outofrangeq  : std_logic;
    -- data
    signal adc_dataeveni    : std_logic_vector(9 downto 0);
    signal adc_dataoddi     : std_logic_vector(9 downto 0);
    signal adc_dataevenq    : std_logic_vector(9 downto 0);
    signal adc_dataoddq     : std_logic_vector(9 downto 0);

    --------------------------------------
    -- half rate signals
    --------------------------------------
    -- out of range
    signal adc_outofrangei_recapture    : std_logic_vector(1 downto 0);
    signal adc_outofrangeq_recapture    : std_logic_vector(1 downto 0);
    signal adc_outofrangei_ddr          : std_logic_vector(1 downto 0);
    signal adc_outofrangeq_ddr          : std_logic_vector(1 downto 0);
    -- data
    signal adc_datai_recapture          : std_logic_vector(39 downto 0);
    signal adc_dataq_recapture          : std_logic_vector(39 downto 0);
    signal adc_datai_ddr                : std_logic_vector(39 downto 0);
    signal adc_dataq_ddr                : std_logic_vector(39 downto 0);
    -- sync
    signal adc_sync_recapture           : std_logic;
    signal adc_sync_capture             : std_logic_vector(3 downto 0);
    signal adc_sync_ddr                 : std_logic_vector(3 downto 0);

    --------------------------------------
    -- fifo signals
    --------------------------------------

    signal fifo_din             : std_logic_vector(84 downto 0);
    signal fifo_dout            : std_logic_vector(84 downto 0);
    signal fifo_rd_en           : std_logic := '0';
    signal fifo_empty           : std_logic;

    ----------------------------------------
    -- Clock signals
    ----------------------------------------
    signal adc_clk              : std_logic;
    signal adc_clk90            : std_logic;
    signal adc_clk180           : std_logic;
    signal adc_clk270           : std_logic;
    signal adc_clk_buf          : std_logic;
    signal adc_clk_dcm          : std_logic;
    signal adc_clk90_dcm        : std_logic;
    signal adc_clk180_dcm       : std_logic;
    signal adc_clk270_dcm       : std_logic;

    ----------------------------------------
    -- Keep constraints
    ----------------------------------------
    attribute keep : string;
    attribute keep of adc_sync_ddr: signal is "true";

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

    component fifo_generator_v4_4
        port (
            din    : IN  std_logic_VECTOR(84 downto 0);
            rd_clk : IN  std_logic;
            rd_en  : IN  std_logic;
            rst    : IN  std_logic;
            wr_clk : IN  std_logic;
            wr_en  : IN  std_logic;
            dout   : OUT std_logic_VECTOR(84 downto 0);
            empty  : OUT std_logic;
            full   : OUT std_logic;
            valid  : OUT std_logic
        );
    end component;

    ----------------------------------------
    -- clock DCM
    ----------------------------------------

    component DCM
        generic (
            CLK_FEEDBACK          :     string     := "1X";
            CLKDV_DIVIDE          :     real       := 2.000000;
            CLKFX_DIVIDE          :     integer    := 1;
            CLKFX_MULTIPLY        :     integer    := 4;
            CLKIN_DIVIDE_BY_2     :     boolean    := false;
            CLKIN_PERIOD          :     real       := 0.000000;
            CLKOUT_PHASE_SHIFT    :     string     := "NONE";
            DESKEW_ADJUST         :     string     := "SYSTEM_SYNCHRONOUS";
            DFS_FREQUENCY_MODE    :     string     := "HIGH";
            DLL_FREQUENCY_MODE    :     string     := "HIGH";
            DUTY_CYCLE_CORRECTION :     boolean    := true;
            FACTORY_JF            :     bit_vector := x"C080";
            PHASE_SHIFT           :     integer    := 0;
            STARTUP_WAIT          :     boolean    := false;
            DSS_MODE              :     string     := "NONE"
        );
        port (
            CLKIN                   : in  std_logic;
            CLKFB                   : in  std_logic;
            RST                     : in  std_logic;
            PSEN                    : in  std_logic;
            PSINCDEC                : in  std_logic;
            PSCLK                   : in  std_logic;
            DSSEN                   : in  std_logic;
            CLK0                    : out std_logic;
            CLK90                   : out std_logic;
            CLK180                  : out std_logic;
            CLK270                  : out std_logic;
            CLKDV                   : out std_logic;
            CLK2X                   : out std_logic;
            CLK2X180                : out std_logic;
            CLKFX                   : out std_logic;
            CLKFX180                : out std_logic;
            STATUS                  : out std_logic_vector (7 downto 0);
            LOCKED                  : out std_logic;
            PSDONE                  : out std_logic
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

    signal outofrangei		: std_logic_vector(1 downto 0);
    signal outofrangeq		: std_logic_vector(1 downto 0);
    signal terminal             : std_logic_vector(2 downto 0);

begin

----------------------------------------
-- Capture the value of the DDR data pins
--
-- This uses the ddr_input component as recommended in the
-- Virtex-II Pro User Guide [UG012 (v4.0) 23 March 2005, pp 250-1]
----------------------------------------
ADC_DATA_DDR: for i in adc_dataeveni'range generate
    adc_dataeveni_ddr: ddr_input port map (
        clk   => adc_clk,
        d     => adc_dataeveni(i),
        qrise => adc_datai_ddr(i + 10),
        qfall => adc_datai_ddr(i + 30)
    );
    adc_dataoddi_ddr: ddr_input port map (
        clk   => adc_clk,
        d     => adc_dataoddi(i),
        qrise => adc_datai_ddr(i + 0),
        qfall => adc_datai_ddr(i + 20)
    );

    adc_dataevenq_ddr: ddr_input port map (
        clk   => adc_clk,
        d     => adc_dataevenq(i),
        qrise => adc_dataq_ddr(i + 10),
        qfall => adc_dataq_ddr(i + 30)
    );
    adc_dataoddq_ddr: ddr_input port map (
        clk   => adc_clk,
        d     => adc_dataoddq(i),
        qrise => adc_dataq_ddr(i + 0),
        qfall => adc_dataq_ddr(i + 20)
    );
end generate;

adc_oori_ddr: ddr_input port map (
    clk   => adc_clk,
    d     => adc_outofrangei,
    qrise => adc_outofrangei_ddr(1),
    qfall => adc_outofrangei_ddr(0)
);
adc_oorq_ddr: ddr_input port map (
    clk   => adc_clk,
    d     => adc_outofrangeq,
    qrise => adc_outofrangeq_ddr(1),
    qfall => adc_outofrangeq_ddr(0)
);

-----------------------------------------------------
-- Re-capture all DDR inputs to adc_clk's rising edge
-----------------------------------------------------
ADC_RECAPTURE_PROC : process(adc_clk) is
begin
    if adc_clk'event and adc_clk = '1' then
        adc_outofrangei_recapture   <= adc_outofrangei_ddr;
        adc_outofrangeq_recapture   <= adc_outofrangeq_ddr;
        adc_datai_recapture         <= adc_datai_ddr;
        adc_dataq_recapture         <= adc_dataq_ddr;
    end if;
end process;


adc_sync_recapture <= '0';

----------------------------------------
-- Asynchronous FIFO for clock boundary crossing
----------------------------------------

-- Read enable managment
FIFO_RD_EN_PROC : process(ctrl_clk_in, dcm_reset) is
begin
    if dcm_reset = '1' then
        fifo_rd_en <= '0';
    else
        if ctrl_clk_in'event and ctrl_clk_in = '1' then
            fifo_rd_en <= not(fifo_empty);
        end if;
    end if;
end process;

-- FIFO signals assignment
fifo_din <= adc_datai_recapture & adc_dataq_recapture & adc_outofrangei_recapture & adc_outofrangeq_recapture & adc_sync_recapture;
user_datai3        <= fifo_dout(84 downto 75);
user_datai2        <= fifo_dout(74 downto 65);
user_datai1        <= fifo_dout(64 downto 55);
user_datai0        <= fifo_dout(54 downto 45);
user_dataq3        <= fifo_dout(44 downto 35);
user_dataq2        <= fifo_dout(34 downto 25);
user_dataq1        <= fifo_dout(24 downto 15);
user_dataq0        <= fifo_dout(14 downto 5);
outofrangei	   <= fifo_dout(4 downto 3);
outofrangeq	   <= fifo_dout(2 downto 1);
user_sync          <= fifo_dout(0);

BUFF_PROC : process(ctrl_clk_in, dcm_reset) is
begin
	if dcm_reset = '1' then
		user_outofrangei <= '0';
		user_outofrangeq <= '0';
	else
		if ctrl_clk_in'event and ctrl_clk_in = '1' then
			user_outofrangei <= outofrangei(0) or outofrangei(1);
			user_outofrangeq <= outofrangeq(0) or outofrangeq(1);
		end if;
	end if;
end process;

-- Async FIFO
ADC_ASYNC_FIFO : fifo_generator_v4_4
    port map (
        wr_clk => adc_clk,
        wr_en  => '1',
        din    => fifo_din,
        full   => open,

        rd_clk => ctrl_clk_in,
        rd_en  => fifo_rd_en,
        dout   => fifo_dout,
        empty  => fifo_empty,
        valid  => user_data_valid,

        rst    => dcm_reset
    );

----------------------------------------
-- Differential ADC DDR output reset
----------------------------------------
--OBUFDS_ADC_DDRB : OBUFDS
--    port map (
--        O  => adc_ddrb_p,
--        OB => adc_ddrb_n,
--        I  => ctrl_reset
--    );

----------------------------------------
-- Sync differential input buffer
----------------------------------------

--IBUFDS_SYNC : IBUFDS
--    port map ( I => adc_sync_p, IB => adc_sync_n, O => adc_sync);

----------------------------------------
-- Out of range differential input buffers
----------------------------------------

IBUFDS_OUTOFRANGEI : IBUFDS
    port map ( I => adc_outofrangei_p, IB => adc_outofrangei_n, O => adc_outofrangei);
IBUFDS_OUTOFRANGEQ : IBUFDS
    port map ( I  => adc_outofrangeq_p, IB => adc_outofrangeq_n, O => adc_outofrangeq);

----------------------------------------
-- Data differential input buffers
----------------------------------------

IBUFDC_DATA: for i in adc_dataeveni'range generate
    -- Even samples, Channel I
    IBUFDS_DATAEVENI : IBUFDS port map (
        I  => adc_dataeveni_p(i),
        IB => adc_dataeveni_n(i),
        O  => adc_dataeveni(i)
    );

    -- Odd samples, Channel I
    IBUFDS_DATAODDI : IBUFDS port map (
        I  => adc_dataoddi_p(i),
        IB => adc_dataoddi_n(i),
        O  => adc_dataoddi(i)
    );

    -- Even samples, Channel Q
    IBUFDS_DATAEVENQ : IBUFDS port map (
        I  => adc_dataevenq_p(i),
        IB => adc_dataevenq_n(i),
        O  => adc_dataevenq(i)
    );

    -- Odd samples, Channel Q
    IBUFDS_DATAODDQ : IBUFDS port map (
        I  => adc_dataoddq_p(i),
        IB => adc_dataoddq_n(i),
        O  => adc_dataoddq(i)
    );
end generate;

----------------------------------------
-- Clock buffer
----------------------------------------

IBUFDS_CLK : IBUFDS
    port map ( I => adc_clk_p, IB => adc_clk_n, O => adc_clk_buf);

CLK_CLKBUF : BUFG
    port map ( I => adc_clk_dcm,    O => adc_clk);
CLK90_CLKBUF : BUFG
    port map ( I => adc_clk90_dcm,  O => adc_clk90);
CLK180_CLKBUF : BUFG
    port map ( I => adc_clk180_dcm, O => adc_clk180);
CLK270_CLKBUF : BUFG
    port map ( I => adc_clk270_dcm, O => adc_clk270);

ctrl_clk_out    <= adc_clk;
ctrl_clk90_out  <= adc_clk90;
ctrl_clk180_out <= adc_clk180;
ctrl_clk270_out <= adc_clk270;

----------------------------------------
-- Clock DCM for phase shifting
----------------------------------------

CLKSHIFT_DCM : DCM
    generic map(
        CLK_FEEDBACK          => "1X",
        CLKDV_DIVIDE          => 2.000000,
        CLKFX_DIVIDE          => 1,
        CLKFX_MULTIPLY        => 4,
        CLKIN_DIVIDE_BY_2     => FALSE,
        CLKIN_PERIOD          => 3.906250,
        CLKOUT_PHASE_SHIFT    => "VARIABLE_CENTER",
        DESKEW_ADJUST         => "SYSTEM_SYNCHRONOUS",
        DFS_FREQUENCY_MODE    => "HIGH",
        DLL_FREQUENCY_MODE    => "HIGH",
        DUTY_CYCLE_CORRECTION => TRUE,
        FACTORY_JF            => x"C080",
        PHASE_SHIFT           => 0,
        STARTUP_WAIT          => FALSE)
    port map (
        CLKFB                 => adc_clk,
        CLKIN                 => adc_clk_buf,
        DSSEN                 => '0',
        PSCLK                 => dcm_psclk,
        PSEN                  => dcm_psen,
        PSINCDEC              => dcm_psincdec,
        RST                   => dcm_reset,
        CLKDV                 => open,
        CLKFX                 => open,
        CLKFX180              => open,
        CLK0                  => adc_clk_dcm,
        CLK2X                 => open,
        CLK2X180              => open,
        CLK90                 => adc_clk90_dcm,
        CLK180                => adc_clk180_dcm,
        CLK270                => adc_clk270_dcm,
        LOCKED                => ctrl_dcm_locked,
        PSDONE                => dcm_psdone,
        STATUS                => open);

end IMP;
