----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:    09:01:21 04/30/2007
-- Design Name:
-- Module Name:    dac_interface - Behavioral
-- Project Name:
-- Target Devices:
-- Tool versions:
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity dac_interface is
    generic (
            CTRL_CLK_PHASE   : in  INTEGER := 0
    );
    Port (
            dac_dsp_clk_p    : in  STD_LOGIC;
            dac_dsp_clk_n    : in  STD_LOGIC;
            dac_data_clk_p   : out STD_LOGIC;
            dac_data_clk_n   : out STD_LOGIC;
            dac_data_a_p     : out STD_LOGIC_VECTOR (8 downto 0);
            dac_data_a_n     : out STD_LOGIC_VECTOR (8 downto 0);
            dac_data_b_p     : out STD_LOGIC_VECTOR (8 downto 0);
            dac_data_b_n     : out STD_LOGIC_VECTOR (8 downto 0);
            dac_data_c_p     : out STD_LOGIC_VECTOR (8 downto 0);
            dac_data_c_n     : out STD_LOGIC_VECTOR (8 downto 0);
            dac_data_d_p     : out STD_LOGIC_VECTOR (8 downto 0);
            dac_data_d_n     : out STD_LOGIC_VECTOR (8 downto 0);
            user_data_clk    : out STD_LOGIC;
            user_data_clk90  : out STD_LOGIC;
            user_data_a      : in  STD_LOGIC_VECTOR (8 downto 0);
            user_data_b      : in  STD_LOGIC_VECTOR (8 downto 0);
            user_data_c      : in  STD_LOGIC_VECTOR (8 downto 0);
            user_data_d      : in  STD_LOGIC_VECTOR (8 downto 0);
--            ctrl_clk_phase   : in  STD_LOGIC;
            ctrl_dcm_locked  : out STD_LOGIC
        );
end dac_interface;

architecture Behavioral of dac_interface is
    signal dsp_clk_0    : std_logic;
    signal dsp_clk_180  : std_logic;
    signal data_clk     : std_logic;
    signal dac_data_clk : std_logic;
    signal dac_clk_dcm  : std_logic;
    signal dac_clk      : std_logic;

    signal data_clk_dcm   : std_logic;
    signal data_clk90_dcm : std_logic;

    signal data_a : std_logic_vector (8 downto 0);
    signal data_b : std_logic_vector (8 downto 0);
    signal data_c : std_logic_vector (8 downto 0);
    signal data_d : std_logic_vector (8 downto 0);

    attribute IOB : string;

    ----------------------------------------
    -- differential input buffer
    ----------------------------------------
    component IBUFGDS
        generic  (
            IOSTANDARD  :   string := "LVDS_25"
        );
        port (
            O           :   out std_logic;
            I           :   in  std_logic;
            IB          :   in  std_logic
        );
    end component;

    ----------------------------------------
    -- differential output buffer
    ----------------------------------------
    component OBUFDS
        generic (
            IOSTANDARD  :   string := "LVDS_25"
        );
        port (
            O           :   out std_logic;
            OB          :   out std_logic;
            I           :   in  std_logic
        );
    end component;

    ----------------------------------------
    -- global clock mux
    ----------------------------------------
    component BUFGMUX
        port (
            O       : out std_logic;
            I0      : in  std_logic;
            I1      : in  std_logic;
            S       : in  std_logic
        );
    end component;

    ----------------------------------------
    -- global clock buffer
    ----------------------------------------
    component BUFG
        port (
            I  : in  std_logic;
            O  : out std_logic
        );
    end component;

    ----------------------------------------------
    -- IOB register
    ----------------------------------------------
    component FD
        port (
            C : in  std_logic;
            D : in  std_logic;
            Q : out std_logic
        );
    end component;

    ----------------------------------------------
    -- DDR IOB register
    ----------------------------------------------
    component FDDRRSE
        port (
            Q   : out std_logic := '0';
            D0  : in  std_logic := '0';
            D1  : in  std_logic := '0';
            C0  : in  std_logic := '0';
            C1  : in  std_logic := '0';
            R   : in  std_logic := '0';
            S   : in  std_logic := '0';
            CE  : in  std_logic := '0'
        );
    end component;

    ----------------------------------------
    -- clock DCM
    ----------------------------------------

    component DCM
        generic (
            CLK_FEEDBACK            : string        := "1X";
            CLKDV_DIVIDE            : real          := 2.000000;
            CLKFX_DIVIDE            : integer       := 1;
            CLKFX_MULTIPLY          : integer       := 4;
            CLKIN_DIVIDE_BY_2       : boolean       := false;
            CLKIN_PERIOD            : real          := 0.000000;
            CLKOUT_PHASE_SHIFT      : string        := "NONE";
            DESKEW_ADJUST           : string        := "SYSTEM_SYNCHRONOUS";
            DFS_FREQUENCY_MODE      : string        := "LOW";
            DLL_FREQUENCY_MODE      : string        := "LOW";
            DUTY_CYCLE_CORRECTION   : boolean       := true;
            FACTORY_JF              : bit_vector    := x"C080";
            PHASE_SHIFT             : integer       := 0;
            STARTUP_WAIT            : boolean       := false;
            DSS_MODE                : string        := "NONE"
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

    attribute IOB of FDDR_inst_dac_data_clk : label is "TRUE";

begin
    IBUFDS_inst_dsp_clk : IBUFGDS
    generic map (
       IOSTANDARD => "LVDS_25") -- no DT, resistor is on DAC board
    port map (
       O => dsp_clk_0,
       I => dac_dsp_clk_p,
       IB => dac_dsp_clk_n
    );

--    dsp_clk_180 <= not (dsp_clk_0);

--    BUFGMUX_inst : BUFGMUX
--    port map (
--       O => data_clk,
--       I0 => dsp_clk_0,
--       I1 => dsp_clk_180,
--       S => ctrl_clk_phase
--    );

    BUFG_user0 : BUFG
    port map (
        I => dac_clk_dcm,
        O => dac_clk
    );

    clk_phase_0_gen : if CTRL_CLK_PHASE = 0 generate
    begin
        data_clk <= dac_clk;
    end generate;

    clk_phase_180_gen : if CTRL_CLK_PHASE = 1 generate
    begin
        data_clk <= not dac_clk;
    end generate;

    BUFG_user90 : BUFG
    port map (
        I => data_clk90_dcm,
        O => user_data_clk90
    );

    FDDR_inst_dac_data_clk : FDDRRSE
    port map (
        Q   => dac_data_clk,
        D0  => '0',
        D1  => '1',
        C0  => data_clk,
        C1  => not data_clk
    );

    OBUFDS_inst_data_clk : OBUFDS
    generic map (
       IOSTANDARD => "LVDS_25")
    port map (
       O =>  dac_data_clk_p,
       OB => dac_data_clk_n,
       I =>  dac_data_clk
    );

    user_data_clk <= data_clk;

    OBUFDS_inst_generate_data_a : for i in 0 to 8 generate
        OBUFDS_inst_data_a : OBUFDS
        generic map (
           IOSTANDARD => "LVDS_25")
        port map (
           O => dac_data_a_p(i),
           OB => dac_data_a_n(i),
           I => data_a(i)
        );
    end generate;

    OBUFDS_inst_generate_data_b : for i in 0 to 8 generate
        OBUFDS_inst_data_b : OBUFDS
        generic map (
           IOSTANDARD => "LVDS_25")
        port map (
           O => dac_data_b_p(i),
           OB => dac_data_b_n(i),
           I => data_b(i)
        );
    end generate;

    OBUFDS_inst_generate_data_c : for i in 0 to 8 generate
        OBUFDS_inst_data_c : OBUFDS
        generic map (
           IOSTANDARD => "LVDS_25")
        port map (
           O => dac_data_c_p(i),
           OB => dac_data_c_n(i),
           I => data_c(i)
        );
    end generate;

    OBUFDS_inst_generate_data_d : for i in 0 to 8 generate
        OBUFDS_inst_data_d : OBUFDS
        generic map (
           IOSTANDARD => "LVDS_25")
        port map (
           O => dac_data_d_p(i),
           OB => dac_data_d_n(i),
           I => data_d(i)
        );
    end generate;

    FD_inst_generate_data_a : for i in 0 to 8 generate
        attribute IOB of FD_inst_data_a : label is "TRUE";
    begin
        FD_inst_data_a : FD
          port map (
             Q => data_a(i),
              C => data_clk,
              D => user_data_a(i)
          );
     end generate;

    FD_inst_generate_data_b : for i in 0 to 8 generate
        attribute IOB of FD_inst_data_b : label is "TRUE";
    begin
        FD_inst_data_b : FD
          port map (
             Q => data_b(i),
              C => data_clk,
              D => user_data_b(i)
          );
     end generate;

    FD_inst_generate_data_c : for i in 0 to 8 generate
        attribute IOB of FD_inst_data_c : label is "TRUE";
    begin
        FD_inst_data_c : FD
          port map (
             Q => data_c(i),
              C => data_clk,
              D => user_data_c(i)
          );
     end generate;

    FD_inst_generate_data_d : for i in 0 to 8 generate
        attribute IOB of FD_inst_data_d : label is "TRUE";
    begin
        FD_inst_data_d : FD
          port map (
             Q => data_d(i),
              C => data_clk,
              D => user_data_d(i)
          );
     end generate;

    DAC_DCM : DCM
    generic map(
        CLK_FEEDBACK          => "1X",
        CLKDV_DIVIDE          => 2.000000,
        CLKFX_DIVIDE          => 1,
        CLKFX_MULTIPLY        => 4,
        CLKIN_DIVIDE_BY_2     => FALSE,
        CLKIN_PERIOD          => 3.906250,
        CLKOUT_PHASE_SHIFT    => "NONE",
        DESKEW_ADJUST         => "SYSTEM_SYNCHRONOUS",
        DFS_FREQUENCY_MODE    => "LOW",
        DLL_FREQUENCY_MODE    => "LOW",
        DUTY_CYCLE_CORRECTION => TRUE,
        FACTORY_JF            => x"C080",
        PHASE_SHIFT           => 0,
        STARTUP_WAIT          => FALSE)
    port map (
        CLKFB                 => dac_clk,
        CLKIN                 => dsp_clk_0,
        DSSEN                 => '0',
        PSCLK                 => '0',
        PSEN                  => '0',
        PSINCDEC              => '0',
        RST                   => '0',
        CLKDV                 => open,
        CLKFX                 => open,
        CLKFX180              => open,
        CLK0                  => dac_clk_dcm,
        CLK2X                 => open,
        CLK2X180              => open,
        CLK90                 => open,
        CLK180                => data_clk90_dcm,
        CLK270                => open,
        LOCKED                => ctrl_dcm_locked,
        PSDONE                => open,
        STATUS                => open
    );

end Behavioral;
