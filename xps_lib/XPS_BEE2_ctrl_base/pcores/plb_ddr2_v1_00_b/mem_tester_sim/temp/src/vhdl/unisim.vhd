!TCL! if $synthesize {
library IEEE;
library synplify;
use synplify.attributes.all;
use IEEE.STD_LOGIC_1164.all;
-- synopsys translate_off

library IEEE;
library synplify;
use synplify.attributes.all;
use IEEE.VITAL_Timing.all;
-- synopsys translate_on

package VCOMPONENTS is

attribute BOX_TYPE : string;

constant DefaultTimingChecksOn : Boolean := False;
constant DefaultXon : Boolean := True;
constant DefaultMsgOn : Boolean := False;

  component AND2
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic
      );
  end component;
attribute syn_black_box of AND2 : component is true;

  component AND2B1
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic
      );
  end component;
attribute syn_black_box of AND2B1 : component is true;

  component AND2B2
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic
      );
  end component;
attribute syn_black_box of AND2B2 : component is true;

  component AND3
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic
      );
  end component;
attribute syn_black_box of AND3 : component is true;

  component AND3B1
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic
      );
  end component;
attribute syn_black_box of AND3B1 : component is true;

  component AND3B2
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic
      );
  end component;
attribute syn_black_box of AND3B2 : component is true;

  component AND3B3
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic
      );
  end component;
attribute syn_black_box of AND3B3 : component is true;

  component AND4
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic
      );
  end component;
attribute syn_black_box of AND4 : component is true;

  component AND4B1
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic
      );
  end component;
attribute syn_black_box of AND4B1 : component is true;

  component AND4B2
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic
      );
  end component;
attribute syn_black_box of AND4B2 : component is true;

  component AND4B3
    port(
      O  : out std_ulogic;
      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic
      );
  end component;
attribute syn_black_box of AND4B3 : component is true;

  component AND4B4
    port(
      O  : out std_ulogic;
      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic
      );
  end component;
attribute syn_black_box of AND4B4 : component is true;

  component AND5
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic;
      I4 : in  std_ulogic
      );
  end component;
attribute syn_black_box of AND5 : component is true;

  component AND5B1
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic;
      I4 : in  std_ulogic
      );
  end component;
attribute syn_black_box of AND5B1 : component is true;

  component AND5B2
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic;
      I4 : in  std_ulogic
      );
  end component;
attribute syn_black_box of AND5B2 : component is true;

  component AND5B3
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic;
      I4 : in  std_ulogic
      );
  end component;
attribute syn_black_box of AND5B3 : component is true;

  component AND5B4
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic;
      I4 : in  std_ulogic
      );
  end component;
attribute syn_black_box of AND5B4 : component is true;

  component AND5B5
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic;
      I4 : in  std_ulogic
      );
  end component;
attribute syn_black_box of AND5B5 : component is true;

  component AND6
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic;
      I4 : in  std_ulogic;
      I5 : in  std_ulogic
      );
  end component;
attribute syn_black_box of AND6 : component is true;

  component AND7
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic;
      I4 : in  std_ulogic;
      I5 : in  std_ulogic;
      I6 : in  std_ulogic
      );
  end component;
attribute syn_black_box of AND7 : component is true;

  component AND8
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic;
      I4 : in  std_ulogic;
      I5 : in  std_ulogic;
      I6 : in  std_ulogic;
      I7 : in  std_ulogic
      );
  end component;
attribute syn_black_box of AND8 : component is true;

  component BSCAN_FPGACORE
    port(
      CAPTURE : out std_ulogic := 'H';
      DRCK1   : out std_ulogic := 'H';
      DRCK2   : out std_ulogic := 'H';
      RESET   : out std_ulogic := 'H';
      SEL1    : out std_ulogic := 'L';
      SEL2    : out std_ulogic := 'L';
      SHIFT   : out std_ulogic := 'L';
      TDI     : out std_ulogic := 'L';
      UPDATE  : out std_ulogic := 'L';

      TDO1    : in  std_ulogic := 'X';
      TDO2    : in  std_ulogic := 'X'
      );
  end component;
attribute syn_black_box of BSCAN_FPGACORE : component is true;

  component BSCAN_SPARTAN2
    port(
      DRCK1  : out std_ulogic := 'H';
      DRCK2  : out std_ulogic := 'H';
      RESET  : out std_ulogic := 'H';
      SEL1   : out std_ulogic := 'L';
      SEL2   : out std_ulogic := 'L';
      SHIFT  : out std_ulogic := 'L';
      TDI    : out std_ulogic := 'L';
      UPDATE : out std_ulogic := 'L';

      TDO1   : in  std_ulogic := 'X';
      TDO2   : in  std_ulogic := 'X'
      );
  end component;
attribute syn_black_box of BSCAN_SPARTAN2 : component is true;

  component BSCAN_SPARTAN3
    port(
      CAPTURE : out std_ulogic := 'H';
      DRCK1   : out std_ulogic := 'L';
      DRCK2   : out std_ulogic := 'L';
      RESET   : out std_ulogic := 'L';
      SEL1    : out std_ulogic := 'L';
      SEL2    : out std_ulogic := 'L';
      SHIFT   : out std_ulogic := 'L';
      TDI     : out std_ulogic := 'L';
      UPDATE  : out std_ulogic := 'L';

      TDO1    : in  std_ulogic;
      TDO2    : in  std_ulogic
      );
  end component;
attribute syn_black_box of BSCAN_SPARTAN3 : component is true;

  component BSCAN_VIRTEX
    port(
      DRCK1  : out std_ulogic := 'H';
      DRCK2  : out std_ulogic := 'H';
      RESET  : out std_ulogic := 'H';
      SEL1   : out std_ulogic := 'L';
      SEL2   : out std_ulogic := 'L';
      SHIFT  : out std_ulogic := 'L';
      TDI    : out std_ulogic := 'L';
      UPDATE : out std_ulogic := 'L';

      TDO1   : in  std_ulogic := 'X';
      TDO2   : in  std_ulogic := 'X'
      );
  end component;
attribute syn_black_box of BSCAN_VIRTEX : component is true;

  component BSCAN_VIRTEX2
    port(
      CAPTURE : out std_ulogic := 'H';
      DRCK1   : out std_ulogic := 'H';
      DRCK2   : out std_ulogic := 'H';
      RESET   : out std_ulogic := 'H';
      SEL1    : out std_ulogic := 'L';
      SEL2    : out std_ulogic := 'L';
      SHIFT   : out std_ulogic := 'L';
      TDI     : out std_ulogic := 'L';
      UPDATE  : out std_ulogic := 'L';

      TDO1    : in  std_ulogic := 'X';
      TDO2    : in  std_ulogic := 'X'
      );
  end component;
attribute syn_black_box of BSCAN_VIRTEX2 : component is true;

  component BUF
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of BUF : component is true;

  component BUFCF
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of BUFCF : component is true;

  component BUFE
    port(
      O : out std_ulogic;

      E : in  std_ulogic;
      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of BUFE : component is true;
attribute black_box_tri_pins of BUFE : component is "O";

  component BUFFOE
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of BUFFOE : component is true;

  component BUFG
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of BUFG : component is true;

  component BUFGCE
    port(
      O  : out std_ulogic;

      CE : in  std_ulogic;
      I  : in  std_ulogic
      );
  end component;
attribute syn_black_box of BUFGCE : component is true;

  component BUFGCE_1
    port(
      O  : out std_ulogic;

      CE : in  std_ulogic;
      I  : in  std_ulogic
      );
  end component;
attribute syn_black_box of BUFGCE_1 : component is true;

  component BUFGCTRL
  generic(
      INIT_OUT     : integer := 0;
      PRESELECT_I0 : boolean := false;
      PRESELECT_I1 : boolean := false
    );

  port(
    O		: out std_ulogic;

    CE0		: in  std_ulogic;
    CE1		: in  std_ulogic;
    I0	        : in  std_ulogic;
    I1        	: in  std_ulogic;
    IGNORE0	: in  std_ulogic;
    IGNORE1	: in  std_ulogic;
    S0		: in  std_ulogic;
    S1		: in  std_ulogic
    );
  end component;
attribute syn_black_box of BUFGCTRL : component is true;

  component BUFGDLL
    generic(
      DUTY_CYCLE_CORRECTION : boolean    := true
      );    
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of BUFGDLL : component is true;

  component BUFGMUX
    port(
      O  : out std_ulogic := '0';

      I0 : in  std_ulogic := '0';
      I1 : in  std_ulogic := '0';
      S  : in  std_ulogic := '0'
      );
  end component;
attribute syn_black_box of BUFGMUX : component is true;

  component BUFGMUX_1
    port (
      O  : out std_ulogic := '0';

      I0 : in  std_ulogic := '0';
      I1 : in  std_ulogic := '0';
      S  : in  std_ulogic := '0'
      );
  end component;
attribute syn_black_box of BUFGMUX_1 : component is true;

  component BUFGMUX_VIRTEX4
  port(
      O                 : out std_ulogic;

      I0                : in std_ulogic;
      I1                : in std_ulogic;
      S                 : in std_ulogic
    );
  end component;
attribute syn_black_box of BUFGMUX_VIRTEX4 : component is true;

  component BUFGP
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of BUFGP : component is true;

  component BUFGSR
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of BUFGSR : component is true;

  component BUFGTS
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of BUFGTS : component is true;

  component BUFIO
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of BUFIO : component is true;

  component BUFR
  generic(
      BUFR_DIVIDE   : string := "BYPASS"
      );
  port(
      O           : out std_ulogic;

      CE          : in  std_ulogic;
      CLR         : in  std_ulogic;
      I           : in  std_ulogic
      );
  end component;
attribute syn_black_box of BUFR : component is true;

  component BUFT
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of BUFT : component is true;
attribute black_box_tri_pins of BUFT : component is "O";

  component CAPTURE_FPGACORE
    port(
      CAP : in std_ulogic;
      CLK : in std_ulogic
      );
  end component;
attribute syn_black_box of CAPTURE_FPGACORE : component is true;

  component CAPTURE_SPARTAN2
    port(
      CAP : in std_ulogic;
      CLK : in std_ulogic
      );
  end component;
attribute syn_black_box of CAPTURE_SPARTAN2 : component is true;

  component CAPTURE_SPARTAN3
    port(
      CAP : in std_ulogic;
      CLK : in std_ulogic
      );
  end component;
attribute syn_black_box of CAPTURE_SPARTAN3 : component is true;

  component CAPTURE_VIRTEX
    port(
      CAP : in std_ulogic;
      CLK : in std_ulogic
      );
  end component;
attribute syn_black_box of CAPTURE_VIRTEX : component is true;

  component CAPTURE_VIRTEX2
    port(
      CAP : in std_ulogic;
      CLK : in std_ulogic
      );
  end component;
attribute syn_black_box of CAPTURE_VIRTEX2 : component is true;

  component CLKDLL
    generic(
      CLKDV_DIVIDE            : real       := 2.0;
      DUTY_CYCLE_CORRECTION   : boolean    := true;
      FACTORY_JF              : bit_vector := X"C080";   --non-simulatable
-- synopsys translate_off
      MAXPERCLKIN             : time       := 40000 ps;  --simulation parameter
      SIM_CLKIN_CYCLE_JITTER  : time       := 300 ps;    --simulation parameter
      SIM_CLKIN_PERIOD_JITTER : time       := 1000 ps;   --simulation parameter
-- synopsys translate_on
      STARTUP_WAIT            : boolean    := false      --non-simulatable
      );

    port(
      CLK0   : out std_ulogic := '0';
      CLK180 : out std_ulogic := '0';
      CLK270 : out std_ulogic := '0';
      CLK2X  : out std_ulogic := '0';
      CLK90  : out std_ulogic := '0';
      CLKDV  : out std_ulogic := '0';
      LOCKED : out std_ulogic := '0';
      
      CLKFB  : in  std_ulogic := '0';
      CLKIN  : in  std_ulogic := '0';
      RST    : in  std_ulogic := '0'
      );
  end component;
attribute syn_black_box of CLKDLL : component is true;

  component CLKDLLE
    generic (
      CLKDV_DIVIDE            : real       := 2.0;
      DUTY_CYCLE_CORRECTION   : boolean    := true;
      FACTORY_JF              : bit_vector := X"C080";   --non-simulatable
-- synopsys translate_off
      MAXPERCLKIN             : time       := 40000 ps;  --simulation parameter
      SIM_CLKIN_CYCLE_JITTER  : time       := 300 ps;    --simulation parameter
      SIM_CLKIN_PERIOD_JITTER : time       := 1000 ps;   --simulation parameter
-- synopsys translate_on
      STARTUP_WAIT            : boolean    := false      --non-simulatable
      );

    port (
      CLK0     : out std_ulogic := '0';
      CLK180   : out std_ulogic := '0';
      CLK270   : out std_ulogic := '0';
      CLK2X    : out std_ulogic := '0';
      CLK2X180 : out std_ulogic := '0';
      CLK90    : out std_ulogic := '0';
      CLKDV    : out std_ulogic := '0';
      LOCKED   : out std_ulogic := '0';
      
      CLKFB    : in  std_ulogic := '0';
      CLKIN    : in  std_ulogic := '0';
      RST      : in  std_ulogic := '0'
      );
  end component;
attribute syn_black_box of CLKDLLE : component is true;

component CLKDLLHF
  generic (
    CLKDV_DIVIDE            : real       := 2.0;
    DUTY_CYCLE_CORRECTION   : boolean    := true;
    FACTORY_JF              : bit_vector := X"FFF0";   --non-simulatable
-- synopsys translate_off
    MAXPERCLKIN             : time       := 40000 ps;  --simulation parameter
    SIM_CLKIN_CYCLE_JITTER  : time       := 300 ps;    --simulation parameter
    SIM_CLKIN_PERIOD_JITTER : time       := 1000 ps;   --simulation parameter
-- synopsys translate_on
    STARTUP_WAIT            : boolean    := false      --non-simulatable
    );

  port (
    CLK0   : out std_ulogic := '0';
    CLK180 : out std_ulogic := '0';
    CLKDV  : out std_ulogic := '0';
    LOCKED : out std_ulogic := '0';
    CLKFB  : in  std_ulogic := '0';
    CLKIN  : in  std_ulogic := '0';
    RST    : in  std_ulogic := '0'
    );
end component;
attribute syn_black_box of CLKDLLHF : component is true;

  component CONFIG
  end component;
attribute syn_black_box of CONFIG : component is true;

  component DCIRESET

  port(
      LOCKED	: out std_ulogic;

      RST	: in  std_ulogic
    );
  end component;
attribute syn_black_box of DCIRESET : component is true;

component DCM
  generic (
    CLKDV_DIVIDE : real := 2.0;
    CLKFX_DIVIDE : integer := 1;
    CLKFX_MULTIPLY : integer := 4;
    CLKIN_DIVIDE_BY_2 : boolean := false;
    CLKIN_PERIOD : real := 0.0;                         --non-simulatable
    CLKOUT_PHASE_SHIFT : string := "NONE";
    CLK_FEEDBACK : string := "1X";
    DESKEW_ADJUST : string := "SYSTEM_SYNCHRONOUS";     --non-simulatable
    DFS_FREQUENCY_MODE : string := "LOW";
    DLL_FREQUENCY_MODE : string := "LOW";
    DSS_MODE : string := "NONE";                        --non-simulatable
    DUTY_CYCLE_CORRECTION : boolean := true;
    FACTORY_JF : bit_vector := X"C080";                 --non-simulatable
-- synopsys translate_off
    MAXPERCLKIN : time := 1000000 ps;                   --simulation parameter
    MAXPERPSCLK : time := 100000000 ps;                 --simulation parameter
-- synopsys translate_on
    PHASE_SHIFT : integer := 0;
-- synopsys translate_off
    SIM_CLKIN_CYCLE_JITTER : time := 300 ps;            --simulation parameter
    SIM_CLKIN_PERIOD_JITTER : time := 1000 ps;          --simulation parameter
-- synopsys translate_on
    STARTUP_WAIT : boolean := false                     --non-simulatable
    );

  port (
    CLK0     : out std_ulogic                   := '0';
    CLK180   : out std_ulogic                   := '0';
    CLK270   : out std_ulogic                   := '0';
    CLK2X    : out std_ulogic                   := '0';
    CLK2X180 : out std_ulogic                   := '0';
    CLK90    : out std_ulogic                   := '0';
    CLKDV    : out std_ulogic                   := '0';
    CLKFX    : out std_ulogic                   := '0';
    CLKFX180 : out std_ulogic                   := '0';
    LOCKED   : out std_ulogic                   := '0';
    PSDONE   : out std_ulogic                   := '0';
    STATUS   : out std_logic_vector(7 downto 0) := "00000000";

    CLKFB    : in std_ulogic := '0';
    CLKIN    : in std_ulogic := '0';
    DSSEN    : in std_ulogic := '0';
    PSCLK    : in std_ulogic := '0';
    PSEN     : in std_ulogic := '0';
    PSINCDEC : in std_ulogic := '0';
    RST      : in std_ulogic := '0'
    );
end component;
attribute syn_black_box of DCM : component is true;

component DCM_ADV
  generic (
    CLKDV_DIVIDE : real := 2.0;
    CLKFX_DIVIDE : integer := 1;
    CLKFX_MULTIPLY : integer := 4;
    CLKIN_DIVIDE_BY_2 : boolean := false;
    CLKIN_PERIOD : real := 0.0;                         --non-simulatable
    CLKOUT_PHASE_SHIFT : string := "NONE";
    CLK_FEEDBACK : string := "1X";
    DCM_PERFORMANCE_MODE : string := "MAX_SPEED";	-- non-simulatable    
    DESKEW_ADJUST : string := "SYSTEM_SYNCHRONOUS";     --non-simulatable
    DFS_FREQUENCY_MODE : string := "LOW";
    DLL_FREQUENCY_MODE : string := "LOW";
    DUTY_CYCLE_CORRECTION : boolean := true;
    FACTORY_JF : bit_vector := X"C080";                 --non-simulatable
-- synopsys translate_off
    MAXPERCLKIN : time := 1000000 ps;                   --simulation parameter
    MAXPERPSCLK : time := 100000000 ps;                 --simulation parameter
-- synopsys translate_on
    PHASE_SHIFT : integer := 0;
-- synopsys translate_off
    SIM_CLKIN_CYCLE_JITTER : time := 300 ps;            --simulation parameter
    SIM_CLKIN_PERIOD_JITTER : time := 1000 ps;          --simulation parameter
-- synopsys translate_on
    STARTUP_WAIT : boolean := false                     --non-simulatable
    );

  port (
    CLK0 : out std_ulogic := '0';
    CLK180 : out std_ulogic := '0';
    CLK270 : out std_ulogic := '0';
    CLK2X : out std_ulogic := '0';
    CLK2X180 : out std_ulogic := '0';
    CLK90 : out std_ulogic := '0';
    CLKDV : out std_ulogic := '0';
    CLKFX : out std_ulogic := '0';
    CLKFX180 : out std_ulogic := '0';
    DO : out std_logic_vector(15 downto 0) := "0000000000000000";
    DRDY : out std_ulogic := '0';    
    LOCKED : out std_ulogic := '0';
    PSDONE : out std_ulogic := '0';

    
    CLKFB : in std_ulogic := '0';
    CLKIN : in std_ulogic := '0';
    DADDR : in std_logic_vector(6 downto 0) := "0000000";
    DCLK : in std_ulogic := '0';    
    DEN : in std_ulogic := '0';
    DI : in std_logic_vector(15 downto 0) := "0000000000000000";
    DWE : in std_ulogic := '0';    
    PSCLK : in std_ulogic := '0';
    PSEN : in std_ulogic := '0';
    PSINCDEC : in std_ulogic := '0';
    RST : in std_ulogic := '0'
    );
end component;
attribute syn_black_box of DCM_ADV : component is true;

component DCM_BASE
generic (
  CLKDV_DIVIDE : real := 2.0;
  CLKFX_DIVIDE : integer := 1;
  CLKFX_MULTIPLY : integer := 4;                                
  CLKIN_DIVIDE_BY_2 : boolean := FALSE;
  CLKIN_PERIOD : real := 10.0;
  CLKOUT_PHASE_SHIFT : string := "NONE";
  CLK_FEEDBACK : string := "1X";
  DCM_PERFORMANCE_MODE : string := "MAX_SPEED";
  DESKEW_ADJUST : string := "SYSTEM_SYNCHRONOUS";
  DFS_FREQUENCY_MODE : string := "LOW";                
  DLL_FREQUENCY_MODE : string := "LOW";
  DUTY_CYCLE_CORRECTION : boolean := TRUE;
  FACTORY_JF : bit_vector := X"C080";
  PHASE_SHIFT : integer := 0;
  STARTUP_WAIT : boolean := false
  );

port (
  CLK0 : out std_ulogic;
  CLK180 : out std_ulogic;
  CLK270 : out std_ulogic;
  CLK2X : out std_ulogic;
  CLK2X180 : out std_ulogic;
  CLK90 : out std_ulogic;
  CLKDV : out std_ulogic;
  CLKFX : out std_ulogic;
  CLKFX180 : out std_ulogic;
  LOCKED : out std_ulogic;
  
  CLKFB : in std_ulogic;
  CLKIN : in std_ulogic;
  RST : in std_ulogic
     );
end component;
attribute syn_black_box of DCM_BASE : component is true;

component DCM_PS
generic (
		CLKDV_DIVIDE : real := 2.0;
		CLKFX_DIVIDE : integer := 1;
		CLKFX_MULTIPLY : integer := 4;
		CLKIN_DIVIDE_BY_2 : boolean := FALSE;
		CLKIN_PERIOD : real := 10.0;
		CLKOUT_PHASE_SHIFT : string := "NONE";
		CLK_FEEDBACK : string := "1X";                
		DCM_PERFORMANCE_MODE : string := "MAX_SPEED";
		DESKEW_ADJUST : string := "SYSTEM_SYNCHRONOUS";
		DFS_FREQUENCY_MODE : string := "LOW";
		DLL_FREQUENCY_MODE : string := "LOW";
		DUTY_CYCLE_CORRECTION : boolean := TRUE;
                FACTORY_JF : bit_vector := X"C080";                 --non-simulatable                
		PHASE_SHIFT : integer := 0;
		STARTUP_WAIT : boolean := FALSE
  );

port (
		CLK0 : out std_ulogic;
		CLK180 : out std_ulogic;
		CLK270 : out std_ulogic;
		CLK2X : out std_ulogic;
		CLK2X180 : out std_ulogic;
		CLK90 : out std_ulogic;
		CLKDV : out std_ulogic;
		CLKFX : out std_ulogic;
		CLKFX180 : out std_ulogic;
		DO : out std_logic_vector(15 downto 0);
		LOCKED : out std_ulogic;
		PSDONE : out std_ulogic;

		CLKFB : in std_ulogic;
		CLKIN : in std_ulogic;
		PSCLK : in std_ulogic;
		PSEN : in std_ulogic;
		PSINCDEC : in std_ulogic;
		RST : in std_ulogic
     );  

end component;
attribute syn_black_box of DCM_PS : component is true;

  component DSP48
  generic(
        AREG            : integer       := 1;
        B_INPUT         : string        := "DIRECT";
        BREG            : integer       := 1;
        CARRYINREG      : integer       := 1;
        CARRYINSELREG   : integer       := 1;
        CREG            : integer       := 1;
        LEGACY_MODE     : string        := "MULT18X18S";
        MREG            : integer       := 1;
        OPMODEREG       : integer       := 1;
        PREG            : integer       := 1;
        SUBTRACTREG     : integer       := 1
        );
  port(
        BCOUT                   : out std_logic_vector(17 downto 0);
        P                       : out std_logic_vector(47 downto 0);
        PCOUT                   : out std_logic_vector(47 downto 0);

        A                       : in  std_logic_vector(17 downto 0);
        B                       : in  std_logic_vector(17 downto 0);
        BCIN                    : in  std_logic_vector(17 downto 0);
        C                       : in  std_logic_vector(47 downto 0);
        CARRYIN                 : in  std_ulogic;
        CARRYINSEL              : in  std_logic_vector(1 downto 0);
        CEA                     : in  std_ulogic;
        CEB                     : in  std_ulogic;
        CEC                     : in  std_ulogic;
        CECARRYIN               : in  std_ulogic;
        CECINSUB                : in  std_ulogic;
        CECTRL                  : in  std_ulogic;
        CEM                     : in  std_ulogic;
        CEP                     : in  std_ulogic;
        CLK                     : in  std_ulogic;
        OPMODE                  : in  std_logic_vector(6 downto 0);
        PCIN                    : in  std_logic_vector(47 downto 0);
        RSTA                    : in  std_ulogic;
        RSTB                    : in  std_ulogic;
        RSTC                    : in  std_ulogic;
        RSTCARRYIN              : in  std_ulogic;
        RSTCTRL                 : in  std_ulogic;
        RSTM                    : in  std_ulogic;
        RSTP                    : in  std_ulogic;
        SUBTRACT                : in  std_ulogic
      );
  end component;
attribute syn_black_box of DSP48 : component is true;

component EMAC

port (
		DCRHOSTDONEIR : out std_ulogic;
		EMAC0CLIENTANINTERRUPT : out std_ulogic;
		EMAC0CLIENTRXBADFRAME : out std_ulogic;
		EMAC0CLIENTRXCLIENTCLKOUT : out std_ulogic;
		EMAC0CLIENTRXD : out std_logic_vector(15 downto 0);
		EMAC0CLIENTRXDVLD : out std_ulogic;
		EMAC0CLIENTRXDVLDMSW : out std_ulogic;
		EMAC0CLIENTRXDVREG6 : out std_ulogic;
		EMAC0CLIENTRXFRAMEDROP : out std_ulogic;
		EMAC0CLIENTRXGOODFRAME : out std_ulogic;
		EMAC0CLIENTRXSTATS : out std_logic_vector(6 downto 0);
		EMAC0CLIENTRXSTATSBYTEVLD : out std_ulogic;
		EMAC0CLIENTRXSTATSVLD : out std_ulogic;
		EMAC0CLIENTTXACK : out std_ulogic;
		EMAC0CLIENTTXCLIENTCLKOUT : out std_ulogic;
		EMAC0CLIENTTXCOLLISION : out std_ulogic;
		EMAC0CLIENTTXGMIIMIICLKOUT : out std_ulogic;
		EMAC0CLIENTTXRETRANSMIT : out std_ulogic;
		EMAC0CLIENTTXSTATS : out std_ulogic;
		EMAC0CLIENTTXSTATSBYTEVLD : out std_ulogic;
		EMAC0CLIENTTXSTATSVLD : out std_ulogic;
		EMAC0PHYENCOMMAALIGN : out std_ulogic;
		EMAC0PHYLOOPBACKMSB : out std_ulogic;
		EMAC0PHYMCLKOUT : out std_ulogic;
		EMAC0PHYMDOUT : out std_ulogic;
		EMAC0PHYMDTRI : out std_ulogic;
		EMAC0PHYMGTRXRESET : out std_ulogic;
		EMAC0PHYMGTTXRESET : out std_ulogic;
		EMAC0PHYPOWERDOWN : out std_ulogic;
		EMAC0PHYSYNCACQSTATUS : out std_ulogic;
		EMAC0PHYTXCHARDISPMODE : out std_ulogic;
		EMAC0PHYTXCHARDISPVAL : out std_ulogic;
		EMAC0PHYTXCHARISK : out std_ulogic;
		EMAC0PHYTXCLK : out std_ulogic;
		EMAC0PHYTXD : out std_logic_vector(7 downto 0);
		EMAC0PHYTXEN : out std_ulogic;
		EMAC0PHYTXER : out std_ulogic;
		EMAC1CLIENTANINTERRUPT : out std_ulogic;
		EMAC1CLIENTRXBADFRAME : out std_ulogic;
		EMAC1CLIENTRXCLIENTCLKOUT : out std_ulogic;
		EMAC1CLIENTRXD : out std_logic_vector(15 downto 0);
		EMAC1CLIENTRXDVLD : out std_ulogic;
		EMAC1CLIENTRXDVLDMSW : out std_ulogic;
		EMAC1CLIENTRXDVREG6 : out std_ulogic;
		EMAC1CLIENTRXFRAMEDROP : out std_ulogic;
		EMAC1CLIENTRXGOODFRAME : out std_ulogic;
		EMAC1CLIENTRXSTATS : out std_logic_vector(6 downto 0);
		EMAC1CLIENTRXSTATSBYTEVLD : out std_ulogic;
		EMAC1CLIENTRXSTATSVLD : out std_ulogic;
		EMAC1CLIENTTXACK : out std_ulogic;
		EMAC1CLIENTTXCLIENTCLKOUT : out std_ulogic;
		EMAC1CLIENTTXCOLLISION : out std_ulogic;
		EMAC1CLIENTTXGMIIMIICLKOUT : out std_ulogic;
		EMAC1CLIENTTXRETRANSMIT : out std_ulogic;
		EMAC1CLIENTTXSTATS : out std_ulogic;
		EMAC1CLIENTTXSTATSBYTEVLD : out std_ulogic;
		EMAC1CLIENTTXSTATSVLD : out std_ulogic;
		EMAC1PHYENCOMMAALIGN : out std_ulogic;
		EMAC1PHYLOOPBACKMSB : out std_ulogic;
		EMAC1PHYMCLKOUT : out std_ulogic;
		EMAC1PHYMDOUT : out std_ulogic;
		EMAC1PHYMDTRI : out std_ulogic;
		EMAC1PHYMGTRXRESET : out std_ulogic;
		EMAC1PHYMGTTXRESET : out std_ulogic;
		EMAC1PHYPOWERDOWN : out std_ulogic;
		EMAC1PHYSYNCACQSTATUS : out std_ulogic;
		EMAC1PHYTXCHARDISPMODE : out std_ulogic;
		EMAC1PHYTXCHARDISPVAL : out std_ulogic;
		EMAC1PHYTXCHARISK : out std_ulogic;
		EMAC1PHYTXCLK : out std_ulogic;
		EMAC1PHYTXD : out std_logic_vector(7 downto 0);
		EMAC1PHYTXEN : out std_ulogic;
		EMAC1PHYTXER : out std_ulogic;
		EMACDCRACK : out std_ulogic;
		EMACDCRDBUS : out std_logic_vector(0 to 31);
		HOSTMIIMRDY : out std_ulogic;
		HOSTRDDATA : out std_logic_vector(31 downto 0);

		CLIENTEMAC0DCMLOCKED : in std_ulogic;
		CLIENTEMAC0PAUSEREQ : in std_ulogic;
		CLIENTEMAC0PAUSEVAL : in std_logic_vector(15 downto 0);
		CLIENTEMAC0RXCLIENTCLKIN : in std_ulogic;
		CLIENTEMAC0TXCLIENTCLKIN : in std_ulogic;
		CLIENTEMAC0TXD : in std_logic_vector(15 downto 0);
		CLIENTEMAC0TXDVLD : in std_ulogic;
		CLIENTEMAC0TXDVLDMSW : in std_ulogic;
		CLIENTEMAC0TXFIRSTBYTE : in std_ulogic;
		CLIENTEMAC0TXGMIIMIICLKIN : in std_ulogic;
		CLIENTEMAC0TXIFGDELAY : in std_logic_vector(7 downto 0);
		CLIENTEMAC0TXUNDERRUN : in std_ulogic;
		CLIENTEMAC1DCMLOCKED : in std_ulogic;
		CLIENTEMAC1PAUSEREQ : in std_ulogic;
		CLIENTEMAC1PAUSEVAL : in std_logic_vector(15 downto 0);
		CLIENTEMAC1RXCLIENTCLKIN : in std_ulogic;
		CLIENTEMAC1TXCLIENTCLKIN : in std_ulogic;
		CLIENTEMAC1TXD : in std_logic_vector(15 downto 0);
		CLIENTEMAC1TXDVLD : in std_ulogic;
		CLIENTEMAC1TXDVLDMSW : in std_ulogic;
		CLIENTEMAC1TXFIRSTBYTE : in std_ulogic;
		CLIENTEMAC1TXGMIIMIICLKIN : in std_ulogic;
		CLIENTEMAC1TXIFGDELAY : in std_logic_vector(7 downto 0);
		CLIENTEMAC1TXUNDERRUN : in std_ulogic;
		DCREMACABUS : in std_logic_vector(8 to 9);
		DCREMACCLK : in std_ulogic;
		DCREMACDBUS : in std_logic_vector(0 to 31);
		DCREMACENABLE : in std_ulogic;
		DCREMACREAD : in std_ulogic;
		DCREMACWRITE : in std_ulogic;
		HOSTADDR : in std_logic_vector(9 downto 0);
		HOSTCLK : in std_ulogic;
		HOSTEMAC1SEL : in std_ulogic;
		HOSTMIIMSEL : in std_ulogic;
		HOSTOPCODE : in std_logic_vector(1 downto 0);
		HOSTREQ : in std_ulogic;
		HOSTWRDATA : in std_logic_vector(31 downto 0);
		PHYEMAC0COL : in std_ulogic;
		PHYEMAC0CRS : in std_ulogic;
		PHYEMAC0GTXCLK : in std_ulogic;
		PHYEMAC0MCLKIN : in std_ulogic;
		PHYEMAC0MDIN : in std_ulogic;
		PHYEMAC0MIITXCLK : in std_ulogic;
		PHYEMAC0PHYAD : in std_logic_vector(4 downto 0);
		PHYEMAC0RXBUFERR : in std_ulogic;
		PHYEMAC0RXBUFSTATUS : in std_logic_vector(1 downto 0);
		PHYEMAC0RXCHARISCOMMA : in std_ulogic;
		PHYEMAC0RXCHARISK : in std_ulogic;
		PHYEMAC0RXCHECKINGCRC : in std_ulogic;
		PHYEMAC0RXCLK : in std_ulogic;
		PHYEMAC0RXCLKCORCNT : in std_logic_vector(2 downto 0);
		PHYEMAC0RXCOMMADET : in std_ulogic;
		PHYEMAC0RXD : in std_logic_vector(7 downto 0);
		PHYEMAC0RXDISPERR : in std_ulogic;
		PHYEMAC0RXDV : in std_ulogic;
		PHYEMAC0RXER : in std_ulogic;
		PHYEMAC0RXLOSSOFSYNC : in std_logic_vector(1 downto 0);
		PHYEMAC0RXNOTINTABLE : in std_ulogic;
		PHYEMAC0RXRUNDISP : in std_ulogic;
		PHYEMAC0SIGNALDET : in std_ulogic;
		PHYEMAC0TXBUFERR : in std_ulogic;
		PHYEMAC1COL : in std_ulogic;
		PHYEMAC1CRS : in std_ulogic;
		PHYEMAC1GTXCLK : in std_ulogic;
		PHYEMAC1MCLKIN : in std_ulogic;
		PHYEMAC1MDIN : in std_ulogic;
		PHYEMAC1MIITXCLK : in std_ulogic;
		PHYEMAC1PHYAD : in std_logic_vector(4 downto 0);
		PHYEMAC1RXBUFERR : in std_ulogic;
		PHYEMAC1RXBUFSTATUS : in std_logic_vector(1 downto 0);
		PHYEMAC1RXCHARISCOMMA : in std_ulogic;
		PHYEMAC1RXCHARISK : in std_ulogic;
		PHYEMAC1RXCHECKINGCRC : in std_ulogic;
		PHYEMAC1RXCLK : in std_ulogic;
		PHYEMAC1RXCLKCORCNT : in std_logic_vector(2 downto 0);
		PHYEMAC1RXCOMMADET : in std_ulogic;
		PHYEMAC1RXD : in std_logic_vector(7 downto 0);
		PHYEMAC1RXDISPERR : in std_ulogic;
		PHYEMAC1RXDV : in std_ulogic;
		PHYEMAC1RXER : in std_ulogic;
		PHYEMAC1RXLOSSOFSYNC : in std_logic_vector(1 downto 0);
		PHYEMAC1RXNOTINTABLE : in std_ulogic;
		PHYEMAC1RXRUNDISP : in std_ulogic;
		PHYEMAC1SIGNALDET : in std_ulogic;
		PHYEMAC1TXBUFERR : in std_ulogic;
		RESET : in std_ulogic;
		TIEEMAC0CONFIGVEC : in std_logic_vector(79 downto 0);
		TIEEMAC0UNICASTADDR : in std_logic_vector(47 downto 0);
		TIEEMAC1CONFIGVEC : in std_logic_vector(79 downto 0);
		TIEEMAC1UNICASTADDR : in std_logic_vector(47 downto 0)
     );
end component;
attribute syn_black_box of EMAC : component is true;

  component FD
    generic(
      INIT : bit := '0' 
      );

    port(
      Q : out std_ulogic;

      C : in  std_ulogic;
      D : in  std_ulogic
      );
  end component;
attribute syn_black_box of FD : component is true;

  component FD_1
    generic(
      INIT : bit := '0' 
      );

    port(
      Q : out std_ulogic;

      C : in  std_ulogic;
      D : in  std_ulogic
      );
  end component;
attribute syn_black_box of FD_1 : component is true;

  component FDC
    generic(
      INIT : bit := '0' 
      );

    port(
      Q   : out std_ulogic;

      C   : in  std_ulogic;
      CLR : in  std_ulogic;
      D   : in  std_ulogic
      );
  end component;
attribute syn_black_box of FDC : component is true;

  component FDC_1
    generic(
      INIT : bit := '0' 
      );

    port(
      Q   : out std_ulogic;

      C   : in  std_ulogic;
      CLR : in  std_ulogic;
      D   : in  std_ulogic
      );
  end component;
attribute syn_black_box of FDC_1 : component is true;

  component FDCE
    generic(
      INIT : bit := '0'
      );

    port(
      Q   : out std_ulogic;

      C   : in  std_ulogic;
      CE  : in  std_ulogic;
      CLR : in  std_ulogic;
      D   : in  std_ulogic
      );
  end component;
attribute syn_black_box of FDCE : component is true;

  component FDCE_1
    generic(
      INIT : bit := '0' 
      );

    port(
      Q   : out std_ulogic;

      C   : in  std_ulogic;
      CE  : in  std_ulogic;
      CLR : in  std_ulogic;
      D   : in  std_ulogic
      );
  end component;
attribute syn_black_box of FDCE_1 : component is true;

  component FDCP
    generic(
      INIT : bit := '0'
      );

    port(
      Q   : out std_ulogic;

      C   : in  std_ulogic;
      CLR : in  std_ulogic;
      D   : in  std_ulogic;
      PRE : in  std_ulogic
      );
  end component;
attribute syn_black_box of FDCP : component is true;

  component FDCP_1
    generic(
      INIT : bit := '0' 
      );

    port(
      Q   : out std_ulogic;

      C   : in  std_ulogic;
      CLR : in  std_ulogic;
      D   : in  std_ulogic;
      PRE : in  std_ulogic
      );
  end component;
attribute syn_black_box of FDCP_1 : component is true;

  component FDCPE
    generic(
      INIT : bit := '0' 
      );

    port(
      Q   : out std_ulogic;

      C   : in  std_ulogic;
      CE  : in  std_ulogic;
      CLR : in  std_ulogic;
      D   : in  std_ulogic;
      PRE : in  std_ulogic
      );
  end component;
attribute syn_black_box of FDCPE : component is true;

  component FDCPE_1
    generic(
      INIT : bit := '0' 
      );

    port(
      Q   : out std_ulogic;

      C   : in  std_ulogic;
      CE  : in  std_ulogic;
      CLR : in  std_ulogic;
      D   : in  std_ulogic;
      PRE : in  std_ulogic
      );
  end component;
attribute syn_black_box of FDCPE_1 : component is true;

  component FDCPX1
    generic(
      INIT : bit := '0' 
      );

    port(
      Q   : out std_ulogic;

      C   : in  std_ulogic;
      CLR : in  std_ulogic;
      D   : in  std_ulogic;
      PRE : in  std_ulogic
      );
  end component;
attribute syn_black_box of FDCPX1 : component is true;

  component FDDRCPE
    generic(
      INIT :     bit := '0'
      );
    port(
      Q    : out std_ulogic;
      C0   : in  std_ulogic;
      C1   : in  std_ulogic;
      CE   : in  std_ulogic;
      CLR  : in  std_ulogic;
      D0   : in  std_ulogic;
      D1   : in  std_ulogic;
      PRE  : in  std_ulogic
      );
  end component;
attribute syn_black_box of FDDRCPE : component is true;

  component FDDRRSE
    generic(
      INIT :     bit := '0'
      );
    port(
      Q    : out std_ulogic;
      C0   : in  std_ulogic;
      C1   : in  std_ulogic;
      CE   : in  std_ulogic;
      D0   : in  std_ulogic;
      D1   : in  std_ulogic;
      R    : in  std_ulogic;
      S    : in  std_ulogic
      );
  end component;
attribute syn_black_box of FDDRRSE : component is true;

  component FDE
    generic(
      INIT : bit := '0' 
      );

    port(
      Q  : out std_ulogic;

      C  : in  std_ulogic;
      CE : in  std_ulogic;
      D  : in  std_ulogic
      );
  end component;
attribute syn_black_box of FDE : component is true;

  component FDE_1
    generic(
      INIT : bit := '0' 
      );

    port(
      Q  : out std_ulogic;

      C  : in  std_ulogic;
      CE : in  std_ulogic;
      D  : in  std_ulogic
      );
  end component;
attribute syn_black_box of FDE_1 : component is true;

  component FDP
    generic(
      INIT : bit := '1' 
      );

    port(
      Q   : out std_ulogic;

      C   : in  std_ulogic;
      D   : in  std_ulogic;
      PRE : in  std_ulogic
      );
  end component;
attribute syn_black_box of FDP : component is true;

  component FDP_1
    generic(
      INIT : bit := '1' 
      );

    port(
      Q   : out std_ulogic;

      C   : in  std_ulogic;
      D   : in  std_ulogic;
      PRE : in  std_ulogic
      );
  end component;
attribute syn_black_box of FDP_1 : component is true;

  component FDPE
    generic(
      INIT : bit := '1' 
      );

    port(
      Q   : out std_ulogic;

      C   : in  std_ulogic;
      CE  : in  std_ulogic;
      D   : in  std_ulogic;
      PRE : in  std_ulogic
      );
  end component;
attribute syn_black_box of FDPE : component is true;

  component FDPE_1
    generic(
      INIT : bit := '1' 
      );

    port(
      Q   : out std_ulogic;

      C   : in  std_ulogic;
      CE  : in  std_ulogic;
      D   : in  std_ulogic;
      PRE : in  std_ulogic
      );
  end component;
attribute syn_black_box of FDPE_1 : component is true;

  component FDR
    generic(
      INIT : bit := '0' 
      );

    port(
      Q : out std_ulogic;

      C : in  std_ulogic;
      D : in  std_ulogic;
      R : in  std_ulogic
      );
  end component;
attribute syn_black_box of FDR : component is true;

  component FDR_1
    generic(
      INIT : bit := '0' 
      );

    port(
      Q : out std_ulogic;

      C : in  std_ulogic;
      D : in  std_ulogic;
      R : in  std_ulogic
      );
  end component;
attribute syn_black_box of FDR_1 : component is true;

  component FDRE
    generic(
      INIT : bit := '0' 
      );

    port(
      Q  : out std_ulogic;

      C  : in  std_ulogic;
      CE : in  std_ulogic;
      D  : in  std_ulogic;
      R  : in  std_ulogic
      );
  end component;
attribute syn_black_box of FDRE : component is true;

  component FDRE_1
    generic(
      INIT : bit := '0' 
      );

    port(
      Q  : out std_ulogic;

      C  : in  std_ulogic;
      CE : in  std_ulogic;
      D  : in  std_ulogic;
      R  : in  std_ulogic
      );
  end component;
attribute syn_black_box of FDRE_1 : component is true;

  component FDRS
    generic(
      INIT : bit := '0' 
      );

    port(
      Q : out std_ulogic;

      C : in  std_ulogic;
      D : in  std_ulogic;
      R : in  std_ulogic;
      S : in  std_ulogic
      );
  end component;
attribute syn_black_box of FDRS : component is true;

  component FDRS_1
    generic(
      INIT : bit := '0' 
      );

    port(
      Q : out std_ulogic;

      C : in  std_ulogic;
      D : in  std_ulogic;
      R : in  std_ulogic;
      S : in  std_ulogic
      );
  end component;
attribute syn_black_box of FDRS_1 : component is true;

  component FDRSE
    generic(
      INIT : bit := '0' 
      );

    port(
      Q  : out std_ulogic;

      C  : in  std_ulogic;
      CE : in  std_ulogic;
      D  : in  std_ulogic;
      R  : in  std_ulogic;
      S  : in  std_ulogic
      );
  end component;
attribute syn_black_box of FDRSE : component is true;

  component FDRSE_1
    generic(
      INIT : bit := '0' 
      );

    port(
      Q  : out std_ulogic;

      C  : in  std_ulogic;
      CE : in  std_ulogic;
      D  : in  std_ulogic;
      R  : in  std_ulogic;
      S  : in  std_ulogic
      );
  end component;
attribute syn_black_box of FDRSE_1 : component is true;

  component FDS
    generic(
      INIT : bit := '1' 
      );

    port(
      Q : out std_ulogic;

      C : in  std_ulogic;
      D : in  std_ulogic;
      S : in  std_ulogic
      );
  end component;
attribute syn_black_box of FDS : component is true;

  component FDS_1
    generic(
      INIT : bit := '1' 
      );

    port(
      Q : out std_ulogic;

      C : in  std_ulogic;
      D : in  std_ulogic;
      S : in  std_ulogic
      );
  end component;
attribute syn_black_box of FDS_1 : component is true;

  component FDSE
    generic(
      INIT : bit := '1' 
      );

    port(
      Q  : out std_ulogic;

      C  : in  std_ulogic;
      CE : in  std_ulogic;
      D  : in  std_ulogic;
      S  : in  std_ulogic
      );
  end component;
attribute syn_black_box of FDSE : component is true;

  component FDSE_1
    generic(
      INIT : bit := '1' 
      );

    port(
      Q  : out std_ulogic;

      C  : in  std_ulogic;
      CE : in  std_ulogic;
      D  : in  std_ulogic;
      S  : in  std_ulogic
      );
  end component;
attribute syn_black_box of FDSE_1 : component is true;

  component FIFO16
  generic(
    ALMOST_FULL_OFFSET      : bit_vector := X"080";
    ALMOST_EMPTY_OFFSET     : bit_vector := X"080"; 
    DATA_WIDTH              : integer    := 36;
    FIRST_WORD_FALL_THROUGH : boolean    := false
    );
  port(
    ALMOSTEMPTY : out std_ulogic;
    ALMOSTFULL  : out std_ulogic;
    DO          : out std_logic_vector (31 downto 0);
    DOP         : out std_logic_vector (3 downto 0);
    EMPTY       : out std_ulogic;
    FULL        : out std_ulogic;
    RDCOUNT     : out std_logic_vector (11 downto 0);
    RDERR       : out std_ulogic;
    WRCOUNT     : out std_logic_vector (11 downto 0);
    WRERR       : out std_ulogic;

    DI          : in  std_logic_vector (31 downto 0);
    DIP         : in  std_logic_vector (3 downto 0);
    RDCLK       : in  std_ulogic;
    RDEN        : in  std_ulogic;
    RST         : in  std_ulogic;
    WRCLK       : in  std_ulogic;
    WREN        : in  std_ulogic
    );
  end component;
attribute syn_black_box of FIFO16 : component is true;

  component FMAP
    port(
      O  : in std_ulogic := 'X';

      I1 : in std_ulogic := 'X';
      I2 : in std_ulogic := 'X';
      I3 : in std_ulogic := 'X';
      I4 : in std_ulogic := 'X'
      );
  end component;
attribute syn_black_box of FMAP : component is true;

  component FRAME_ECC_VIRTEX4
    port(
      ERROR		: in std_ulogic;
      SYNDROME		: out std_logic_vector(11 downto 0);
      SYNDROMEVALID	: out std_ulogic
      );
  end component;
attribute syn_black_box of FRAME_ECC_VIRTEX4 : component is true;

  component FTC
    port(
      Q   : out std_ulogic;

      C   : in  std_ulogic;
      CLR : in  std_ulogic;
      T   : in  std_ulogic
      );
  end component;
attribute syn_black_box of FTC : component is true;

  component FTCP
    port(
      Q   : out std_ulogic;

      C   : in  std_ulogic;
      CLR : in  std_ulogic;
      PRE : in  std_ulogic;
      T   : in  std_ulogic
      );
  end component;
attribute syn_black_box of FTCP : component is true;

  component FTP
    generic(
      INIT : bit := '1' 
      );

    port(
      Q   : out std_ulogic;

      C   : in  std_ulogic;
      PRE : in  std_ulogic;
      T   : in  std_ulogic
      );
  end component;
attribute syn_black_box of FTP : component is true;

  component GND
    port(
      G : out std_ulogic := '0'
      );
  end component;
attribute syn_black_box of GND : component is true;
attribute syn_noprune of GND : component is true;

  component IBUF
    generic(
      CAPACITANCE : string := "DONT_CARE";
      IOSTANDARD  : string := "DEFAULT"
      );

    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF : component is true;

  component IBUF_AGP
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_AGP : component is true;

  component IBUF_CTT
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_CTT : component is true;

  component IBUF_GTL
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_GTL : component is true;

  component IBUF_GTL_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_GTL_DCI : component is true;

  component IBUF_GTLP
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_GTLP : component is true;

  component IBUF_GTLP_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_GTLP_DCI : component is true;

  component IBUF_HSTL_I
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_HSTL_I : component is true;

  component IBUF_HSTL_I_18
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_HSTL_I_18 : component is true;

  component IBUF_HSTL_I_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_HSTL_I_DCI : component is true;

  component IBUF_HSTL_I_DCI_18
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_HSTL_I_DCI_18 : component is true;

  component IBUF_HSTL_II
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_HSTL_II : component is true;

  component IBUF_HSTL_II_18
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_HSTL_II_18 : component is true;

  component IBUF_HSTL_II_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_HSTL_II_DCI : component is true;

  component IBUF_HSTL_II_DCI_18
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_HSTL_II_DCI_18 : component is true;

  component IBUF_HSTL_III
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_HSTL_III : component is true;

  component IBUF_HSTL_III_18
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_HSTL_III_18 : component is true;

  component IBUF_HSTL_III_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_HSTL_III_DCI : component is true;

  component IBUF_HSTL_III_DCI_18
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_HSTL_III_DCI_18 : component is true;

  component IBUF_HSTL_IV
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_HSTL_IV : component is true;

  component IBUF_HSTL_IV_18
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_HSTL_IV_18 : component is true;

  component IBUF_HSTL_IV_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_HSTL_IV_DCI : component is true;

  component IBUF_HSTL_IV_DCI_18
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_HSTL_IV_DCI_18 : component is true;

  component IBUF_LVCMOS12
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_LVCMOS12 : component is true;

  component IBUF_LVCMOS15
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_LVCMOS15 : component is true;

  component IBUF_LVCMOS18
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_LVCMOS18 : component is true;

  component IBUF_LVCMOS2
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_LVCMOS2 : component is true;

  component IBUF_LVCMOS25
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_LVCMOS25 : component is true;

  component IBUF_LVCMOS33
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_LVCMOS33 : component is true;

  component IBUF_LVDCI_15
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_LVDCI_15 : component is true;

  component IBUF_LVDCI_18
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_LVDCI_18 : component is true;

  component IBUF_LVDCI_25
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_LVDCI_25 : component is true;

  component IBUF_LVDCI_33
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_LVDCI_33 : component is true;

  component IBUF_LVDCI_DV2_15
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_LVDCI_DV2_15 : component is true;

  component IBUF_LVDCI_DV2_18
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_LVDCI_DV2_18 : component is true;

  component IBUF_LVDCI_DV2_25
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_LVDCI_DV2_25 : component is true;

  component IBUF_LVDCI_DV2_33
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_LVDCI_DV2_33 : component is true;

  component IBUF_LVDS
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_LVDS : component is true;

  component IBUF_LVPECL
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_LVPECL : component is true;

  component IBUF_LVTTL
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_LVTTL : component is true;

  component IBUF_PCI33_3
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_PCI33_3 : component is true;

  component IBUF_PCI33_5
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_PCI33_5 : component is true;

  component IBUF_PCI66_3
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_PCI66_3 : component is true;

  component IBUF_PCIX
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_PCIX : component is true;

  component IBUF_PCIX66_3
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_PCIX66_3 : component is true;

  component IBUF_SSTL18_I
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_SSTL18_I : component is true;

  component IBUF_SSTL18_I_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_SSTL18_I_DCI : component is true;

  component IBUF_SSTL18_II
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_SSTL18_II : component is true;

  component IBUF_SSTL18_II_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_SSTL18_II_DCI : component is true;

  component IBUF_SSTL2_I
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_SSTL2_I : component is true;

  component IBUF_SSTL2_I_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_SSTL2_I_DCI : component is true;

  component IBUF_SSTL2_II
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_SSTL2_II : component is true;

  component IBUF_SSTL2_II_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_SSTL2_II_DCI : component is true;

  component IBUF_SSTL3_I
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_SSTL3_I : component is true;

  component IBUF_SSTL3_I_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_SSTL3_I_DCI : component is true;

  component IBUF_SSTL3_II
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_SSTL3_II : component is true;

  component IBUF_SSTL3_II_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUF_SSTL3_II_DCI : component is true;

  component IBUFDS
    generic(
      CAPACITANCE : string  := "DONT_CARE";
      DIFF_TERM   : boolean :=  FALSE;
      IOSTANDARD  : string  := "DEFAULT"
      );

    port(
      O  : out std_ulogic;

      I  : in  std_ulogic;
      IB : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFDS : component is true;

  component IBUFDS_BLVDS_25
    port(
      O  : out std_ulogic;

      I  : in  std_ulogic;
      IB : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFDS_BLVDS_25 : component is true;

component IBUFDS_DIFF_OUT
-- synopsys translate_off
   generic(
--      TimingChecksOn: Boolean := TRUE;
--      InstancePath: STRING := "*";
--      Xon: Boolean := True;
--      MsgOn: Boolean := False;
--      tpd_I_O                        :	VitalDelayType01 := (0.100 ns, 0.100 ns);
--      tpd_IB_O                       :	VitalDelayType01 := (0.100 ns, 0.100 ns);
--      tpd_I_OB                       :	VitalDelayType01 := (0.100 ns, 0.100 ns);
--      tpd_IB_OB                      :	VitalDelayType01 := (0.100 ns, 0.100 ns);            
--      tipd_I                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
--      tipd_IB                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);      
      IOSTANDARD                     : string := "LVCMOS25"          
      );

-- synopsys translate_on   
   port(
      O                              :	out   STD_ULOGIC;
      OB                              :	out   STD_ULOGIC;      
      
      I                              :	in    STD_ULOGIC;
      IB                              :	in    STD_ULOGIC      
      );  
end component;
attribute syn_black_box of IBUFDS_DIFF_OUT : component is true;

  component IBUFDS_LDT_25
    port(
      O  : out std_ulogic;

      I  : in  std_ulogic;
      IB : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFDS_LDT_25 : component is true;

  component IBUFDS_LVDS_25
    port(
      O  : out std_ulogic;

      I  : in  std_ulogic;
      IB : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFDS_LVDS_25 : component is true;

  component IBUFDS_LVDS_25_DCI
    port(
      O  : out std_ulogic;

      I  : in  std_ulogic;
      IB : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFDS_LVDS_25_DCI : component is true;

  component IBUFDS_LVDS_33
    port(
      O  : out std_ulogic;

      I  : in  std_ulogic;
      IB : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFDS_LVDS_33 : component is true;

  component IBUFDS_LVDS_33_DCI
    port(
      O  : out std_ulogic;

      I  : in  std_ulogic;
      IB : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFDS_LVDS_33_DCI : component is true;

  component IBUFDS_LVDSEXT_25
    port(
      O  : out std_ulogic;

      I  : in  std_ulogic;
      IB : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFDS_LVDSEXT_25 : component is true;

  component IBUFDS_LVDSEXT_25_DCI
    port(
      O  : out std_ulogic;

      I  : in  std_ulogic;
      IB : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFDS_LVDSEXT_25_DCI : component is true;

  component IBUFDS_LVDSEXT_33
    port(
      O  : out std_ulogic;

      I  : in  std_ulogic;
      IB : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFDS_LVDSEXT_33 : component is true;

  component IBUFDS_LVDSEXT_33_DCI
    port(
      O  : out std_ulogic;

      I  : in  std_ulogic;
      IB : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFDS_LVDSEXT_33_DCI : component is true;

  component IBUFDS_LVPECL_25
    port(
      O  : out std_ulogic;

      I  : in  std_ulogic;
      IB : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFDS_LVPECL_25 : component is true;

  component IBUFDS_LVPECL_33
    port(
      O  : out std_ulogic;

      I  : in  std_ulogic;
      IB : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFDS_LVPECL_33 : component is true;

  component IBUFDS_ULVDS_25
    port(
      O  : out std_ulogic;

      I  : in  std_ulogic;
      IB : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFDS_ULVDS_25 : component is true;

  component IBUFG
    generic(
      CAPACITANCE : string := "DONT_CARE";
      IOSTANDARD  : string := "DEFAULT"
      );

    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG : component is true;

  component IBUFG_AGP
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_AGP : component is true;

  component IBUFG_CTT
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_CTT : component is true;

  component IBUFG_GTL
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_GTL : component is true;

  component IBUFG_GTL_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_GTL_DCI : component is true;

  component IBUFG_GTLP
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_GTLP : component is true;

  component IBUFG_GTLP_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_GTLP_DCI : component is true;

  component IBUFG_HSTL_I
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_HSTL_I : component is true;

  component IBUFG_HSTL_I_18
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_HSTL_I_18 : component is true;

  component IBUFG_HSTL_I_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_HSTL_I_DCI : component is true;

  component IBUFG_HSTL_I_DCI_18
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_HSTL_I_DCI_18 : component is true;

  component IBUFG_HSTL_II
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_HSTL_II : component is true;

  component IBUFG_HSTL_II_18
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_HSTL_II_18 : component is true;

  component IBUFG_HSTL_II_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_HSTL_II_DCI : component is true;

  component IBUFG_HSTL_II_DCI_18
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_HSTL_II_DCI_18 : component is true;

  component IBUFG_HSTL_III
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_HSTL_III : component is true;

  component IBUFG_HSTL_III_18
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_HSTL_III_18 : component is true;

  component IBUFG_HSTL_III_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_HSTL_III_DCI : component is true;

  component IBUFG_HSTL_III_DCI_18
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_HSTL_III_DCI_18 : component is true;

  component IBUFG_HSTL_IV
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_HSTL_IV : component is true;

  component IBUFG_HSTL_IV_18
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_HSTL_IV_18 : component is true;

  component IBUFG_HSTL_IV_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_HSTL_IV_DCI : component is true;

  component IBUFG_HSTL_IV_DCI_18
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_HSTL_IV_DCI_18 : component is true;

  component IBUFG_LVCMOS12
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_LVCMOS12 : component is true;

  component IBUFG_LVCMOS15
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_LVCMOS15 : component is true;

  component IBUFG_LVCMOS18
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_LVCMOS18 : component is true;

  component IBUFG_LVCMOS2
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_LVCMOS2 : component is true;

  component IBUFG_LVCMOS25
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_LVCMOS25 : component is true;

  component IBUFG_LVCMOS33
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_LVCMOS33 : component is true;

  component IBUFG_LVDCI_15
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_LVDCI_15 : component is true;

  component IBUFG_LVDCI_18
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_LVDCI_18 : component is true;

  component IBUFG_LVDCI_25
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_LVDCI_25 : component is true;

  component IBUFG_LVDCI_33
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_LVDCI_33 : component is true;

  component IBUFG_LVDCI_DV2_15
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_LVDCI_DV2_15 : component is true;

  component IBUFG_LVDCI_DV2_18
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_LVDCI_DV2_18 : component is true;

  component IBUFG_LVDCI_DV2_25
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_LVDCI_DV2_25 : component is true;

  component IBUFG_LVDCI_DV2_33
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_LVDCI_DV2_33 : component is true;

  component IBUFG_LVDS
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_LVDS : component is true;

  component IBUFG_LVPECL
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_LVPECL : component is true;

  component IBUFG_LVTTL
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_LVTTL : component is true;

  component IBUFG_PCI33_3
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_PCI33_3 : component is true;

  component IBUFG_PCI33_5
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_PCI33_5 : component is true;

  component IBUFG_PCI66_3
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_PCI66_3 : component is true;

  component IBUFG_PCIX
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_PCIX : component is true;

  component IBUFG_PCIX66_3
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_PCIX66_3 : component is true;

  component IBUFG_SSTL18_I
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_SSTL18_I : component is true;

  component IBUFG_SSTL18_I_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_SSTL18_I_DCI : component is true;

  component IBUFG_SSTL18_II
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_SSTL18_II : component is true;

  component IBUFG_SSTL18_II_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_SSTL18_II_DCI : component is true;

  component IBUFG_SSTL2_I
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_SSTL2_I : component is true;

  component IBUFG_SSTL2_I_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_SSTL2_I_DCI : component is true;

  component IBUFG_SSTL2_II
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_SSTL2_II : component is true;

  component IBUFG_SSTL2_II_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_SSTL2_II_DCI : component is true;

  component IBUFG_SSTL3_I
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_SSTL3_I : component is true;

  component IBUFG_SSTL3_I_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_SSTL3_I_DCI : component is true;

  component IBUFG_SSTL3_II
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_SSTL3_II : component is true;

  component IBUFG_SSTL3_II_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFG_SSTL3_II_DCI : component is true;

  component IBUFGDS
    generic(
      CAPACITANCE : string  := "DONT_CARE";
      DIFF_TERM   : boolean :=  FALSE;
      IOSTANDARD  : string  := "DEFAULT"
      );

    port(
      O  : out std_ulogic;

      I  : in  std_ulogic;
      IB : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFGDS : component is true;

  component IBUFGDS_BLVDS_25
    port(
      O  : out std_ulogic;

      I  : in  std_ulogic;
      IB : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFGDS_BLVDS_25 : component is true;

component IBUFGDS_DIFF_OUT
-- synopsys translate_off
   generic(
--      TimingChecksOn: Boolean := TRUE;
--      InstancePath: STRING := "*";
--      Xon: Boolean := True;
--      MsgOn: Boolean := False;
--      tpd_I_O                        :	VitalDelayType01 := (0.100 ns, 0.100 ns);
--      tpd_IB_O                       :	VitalDelayType01 := (0.100 ns, 0.100 ns);
--      tpd_I_OB                       :	VitalDelayType01 := (0.100 ns, 0.100 ns);
--      tpd_IB_OB                      :	VitalDelayType01 := (0.100 ns, 0.100 ns);            
--      tipd_I                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
--      tipd_IB                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);      
      IOSTANDARD                     :  string := "LVCMOS25"          
      );

-- synopsys translate_on   
   port(
      O                              :	out   STD_ULOGIC;
      OB                              :	out   STD_ULOGIC;      
      
      I                              :	in    STD_ULOGIC;
      IB                              :	in    STD_ULOGIC      
      );  
end component;
attribute syn_black_box of IBUFGDS_DIFF_OUT : component is true;

  component IBUFGDS_LDT_25
    port(
      O  : out std_ulogic;

      I  : in  std_ulogic;
      IB : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFGDS_LDT_25 : component is true;

  component IBUFGDS_LVDS_25
    port(
      O  : out std_ulogic;

      I  : in  std_ulogic;
      IB : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFGDS_LVDS_25 : component is true;

  component IBUFGDS_LVDS_25_DCI
    port(
      O  : out std_ulogic;

      I  : in  std_ulogic;
      IB : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFGDS_LVDS_25_DCI : component is true;

  component IBUFGDS_LVDS_33
    port(
      O  : out std_ulogic;

      I  : in  std_ulogic;
      IB : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFGDS_LVDS_33 : component is true;

  component IBUFGDS_LVDS_33_DCI
    port(
      O  : out std_ulogic;

      I  : in  std_ulogic;
      IB : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFGDS_LVDS_33_DCI : component is true;

  component IBUFGDS_LVDSEXT_25
    port(
      O  : out std_ulogic;

      I  : in  std_ulogic;
      IB : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFGDS_LVDSEXT_25 : component is true;

  component IBUFGDS_LVDSEXT_25_DCI
    port(
      O  : out std_ulogic;

      I  : in  std_ulogic;
      IB : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFGDS_LVDSEXT_25_DCI : component is true;

  component IBUFGDS_LVDSEXT_33
    port(
      O  : out std_ulogic;

      I  : in  std_ulogic;
      IB : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFGDS_LVDSEXT_33 : component is true;

  component IBUFGDS_LVDSEXT_33_DCI
    port(
      O  : out std_ulogic;

      I  : in  std_ulogic;
      IB : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFGDS_LVDSEXT_33_DCI : component is true;

  component IBUFGDS_LVPECL_25
    port(
      O  : out std_ulogic;

      I  : in  std_ulogic;
      IB : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFGDS_LVPECL_25 : component is true;

  component IBUFGDS_LVPECL_33
    port(
      O  : out std_ulogic;

      I  : in  std_ulogic;
      IB : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFGDS_LVPECL_33 : component is true;

  component IBUFGDS_ULVDS_25
    port(
      O  : out std_ulogic;

      I  : in  std_ulogic;
      IB : in  std_ulogic
      );
  end component;
attribute syn_black_box of IBUFGDS_ULVDS_25 : component is true;

  component ICAP_VIRTEX2
    port(

      BUSY  : out std_ulogic;
      O     : out std_logic_vector(7 downto 0);

      CE    : in  std_ulogic;
      CLK   : in  std_ulogic;
      I     : in  std_logic_vector(7 downto 0);
      WRITE : in  std_ulogic
      );
  end component;
attribute syn_black_box of ICAP_VIRTEX2 : component is true;

  component IDDR
  generic(
      DDR_CLK_EDGE : string := "OPPOSITE_EDGE";
      INIT_Q1      : bit    := '0';
      INIT_Q2      : bit    := '0';
      SRTYPE       : string := "SYNC"
      );
  port(
      Q1          : out std_ulogic;
      Q2          : out std_ulogic;

      C           : in  std_ulogic;
      CE          : in  std_ulogic;
      D           : in  std_ulogic;
      R           : in  std_ulogic;
      S           : in  std_ulogic
    );
  end component;
attribute syn_black_box of IDDR : component is true;

  component IDDR2
  generic(
      DDR_ALIGNMENT : string := "NONE";
      INIT_Q0       : bit    := '0';
      INIT_Q1       : bit    := '0';
      SRTYPE        : string := "SYNC"
      );
  port(
      Q0          : out std_ulogic;
      Q1          : out std_ulogic;

      C0          : in  std_ulogic;
      C1          : in  std_ulogic;
      CE          : in  std_ulogic;
      D           : in  std_ulogic;
      R           : in  std_ulogic;
      S           : in  std_ulogic
    );
  end component;
attribute syn_black_box of IDDR2 : component is true;

  component IDELAY
  generic(
      IOBDELAY_TYPE  : string := "DEFAULT";
      IOBDELAY_VALUE : integer := 0
      );

  port(
      O      : out std_ulogic;

      C      : in  std_ulogic;
      CE     : in  std_ulogic;
      I      : in  std_ulogic;
      INC    : in  std_ulogic;
      RST    : in  std_ulogic
      );
  end component;
attribute syn_black_box of IDELAY : component is true;

  component IDELAYCTRL
  port(
      RDY	: out std_ulogic;

      REFCLK	: in  std_ulogic;
      RST	: in  std_ulogic
  );
  end component;
attribute syn_black_box of IDELAYCTRL : component is true;

  component IFDDRCPE
    port(
      Q0  : out std_ulogic;
      Q1  : out std_ulogic;

      C0  : in  std_ulogic;
      C1  : in  std_ulogic;
      CE  : in  std_ulogic;
      CLR : in  std_ulogic;
      D   : in  std_ulogic;
      PRE : in  std_ulogic
      );
  end component;
attribute syn_black_box of IFDDRCPE : component is true;

  component IFDDRRSE
    port(
      Q0 : out std_ulogic;
      Q1 : out std_ulogic;

      C0 : in  std_ulogic;
      C1 : in  std_ulogic;
      CE : in  std_ulogic;
      D  : in  std_ulogic;
      R  : in  std_ulogic;
      S  : in  std_ulogic
      );
  end component;
attribute syn_black_box of IFDDRRSE : component is true;

  component ILD
    generic(
      INIT : bit := '0' 
      );

    port(
      Q : out std_ulogic;

      D : in  std_ulogic;
      G : in  std_ulogic
      );
  end component;
attribute syn_black_box of ILD : component is true;

  component INV
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of INV : component is true;

  component IOBUF
    generic(
      CAPACITANCE : string     := "DONT_CARE";
      DRIVE       : integer    := 12;
      IOSTANDARD  : string     := "DEFAULT";
      SLEW        : string     := "SLOW"
      );

    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF : component is true;

  component IOBUF_AGP
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_AGP : component is true;

  component IOBUF_CTT
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_CTT : component is true;

  component IOBUF_F_12
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_F_12 : component is true;

  component IOBUF_F_16
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_F_16 : component is true;

  component IOBUF_F_2
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_F_2 : component is true;

  component IOBUF_F_24
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_F_24 : component is true;

  component IOBUF_F_4
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_F_4 : component is true;

  component IOBUF_F_6
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_F_6 : component is true;

  component IOBUF_F_8
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_F_8 : component is true;

  component IOBUF_GTL
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_GTL : component is true;

  component IOBUF_GTL_DCI
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_GTL_DCI : component is true;

  component IOBUF_GTLP
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_GTLP : component is true;

  component IOBUF_GTLP_DCI
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_GTLP_DCI : component is true;

  component IOBUF_HSTL_I
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_HSTL_I : component is true;

  component IOBUF_HSTL_I_18
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_HSTL_I_18 : component is true;

  component IOBUF_HSTL_II
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_HSTL_II : component is true;

  component IOBUF_HSTL_II_18
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_HSTL_II_18 : component is true;

  component IOBUF_HSTL_II_DCI
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_HSTL_II_DCI : component is true;

  component IOBUF_HSTL_II_DCI_18
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_HSTL_II_DCI_18 : component is true;

  component IOBUF_HSTL_III
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_HSTL_III : component is true;

  component IOBUF_HSTL_III_18
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_HSTL_III_18 : component is true;

  component IOBUF_HSTL_IV
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_HSTL_IV : component is true;

  component IOBUF_HSTL_IV_18
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_HSTL_IV_18 : component is true;

  component IOBUF_HSTL_IV_DCI
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_HSTL_IV_DCI : component is true;

  component IOBUF_HSTL_IV_DCI_18
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_HSTL_IV_DCI_18 : component is true;

  component IOBUF_LVCMOS12
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS12 : component is true;

  component IOBUF_LVCMOS12_F_2
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS12_F_2 : component is true;

  component IOBUF_LVCMOS12_F_4
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS12_F_4 : component is true;

  component IOBUF_LVCMOS12_F_6
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS12_F_6 : component is true;

  component IOBUF_LVCMOS12_F_8
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS12_F_8 : component is true;

  component IOBUF_LVCMOS12_S_2
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS12_S_2 : component is true;

  component IOBUF_LVCMOS12_S_4
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS12_S_4 : component is true;

  component IOBUF_LVCMOS12_S_6
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS12_S_6 : component is true;

  component IOBUF_LVCMOS12_S_8
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS12_S_8 : component is true;

  component IOBUF_LVCMOS15
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS15 : component is true;

  component IOBUF_LVCMOS15_F_12
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS15_F_12 : component is true;

  component IOBUF_LVCMOS15_F_16
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS15_F_16 : component is true;

  component IOBUF_LVCMOS15_F_2
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS15_F_2 : component is true;

  component IOBUF_LVCMOS15_F_4
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS15_F_4 : component is true;

  component IOBUF_LVCMOS15_F_6
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS15_F_6 : component is true;

  component IOBUF_LVCMOS15_F_8
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS15_F_8 : component is true;

  component IOBUF_LVCMOS15_S_12
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS15_S_12 : component is true;

  component IOBUF_LVCMOS15_S_16
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS15_S_16 : component is true;

  component IOBUF_LVCMOS15_S_2
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS15_S_2 : component is true;

  component IOBUF_LVCMOS15_S_4
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS15_S_4 : component is true;

  component IOBUF_LVCMOS15_S_6
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS15_S_6 : component is true;

  component IOBUF_LVCMOS15_S_8
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS15_S_8 : component is true;

  component IOBUF_LVCMOS18
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS18 : component is true;

  component IOBUF_LVCMOS18_F_12
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS18_F_12 : component is true;

  component IOBUF_LVCMOS18_F_16
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS18_F_16 : component is true;

  component IOBUF_LVCMOS18_F_2
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS18_F_2 : component is true;

  component IOBUF_LVCMOS18_F_4
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS18_F_4 : component is true;

  component IOBUF_LVCMOS18_F_6
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS18_F_6 : component is true;

  component IOBUF_LVCMOS18_F_8
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS18_F_8 : component is true;

  component IOBUF_LVCMOS18_S_12
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS18_S_12 : component is true;

  component IOBUF_LVCMOS18_S_16
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS18_S_16 : component is true;

  component IOBUF_LVCMOS18_S_2
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS18_S_2 : component is true;

  component IOBUF_LVCMOS18_S_4
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS18_S_4 : component is true;

  component IOBUF_LVCMOS18_S_6
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS18_S_6 : component is true;

  component IOBUF_LVCMOS18_S_8
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS18_S_8 : component is true;

  component IOBUF_LVCMOS2
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS2 : component is true;

  component IOBUF_LVCMOS25
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS25 : component is true;

  component IOBUF_LVCMOS25_F_12
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS25_F_12 : component is true;

  component IOBUF_LVCMOS25_F_16
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS25_F_16 : component is true;

  component IOBUF_LVCMOS25_F_2
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS25_F_2 : component is true;

  component IOBUF_LVCMOS25_F_24
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS25_F_24 : component is true;

  component IOBUF_LVCMOS25_F_4
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS25_F_4 : component is true;

  component IOBUF_LVCMOS25_F_6
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS25_F_6 : component is true;

  component IOBUF_LVCMOS25_F_8
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS25_F_8 : component is true;

  component IOBUF_LVCMOS25_S_12
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS25_S_12 : component is true;

  component IOBUF_LVCMOS25_S_16
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS25_S_16 : component is true;

  component IOBUF_LVCMOS25_S_2
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS25_S_2 : component is true;

  component IOBUF_LVCMOS25_S_24
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS25_S_24 : component is true;

  component IOBUF_LVCMOS25_S_4
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS25_S_4 : component is true;

  component IOBUF_LVCMOS25_S_6
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS25_S_6 : component is true;

  component IOBUF_LVCMOS25_S_8
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS25_S_8 : component is true;

  component IOBUF_LVCMOS33
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS33 : component is true;

  component IOBUF_LVCMOS33_F_12
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS33_F_12 : component is true;

  component IOBUF_LVCMOS33_F_16
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS33_F_16 : component is true;

  component IOBUF_LVCMOS33_F_2
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS33_F_2 : component is true;

  component IOBUF_LVCMOS33_F_24
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS33_F_24 : component is true;

  component IOBUF_LVCMOS33_F_4
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS33_F_4 : component is true;

  component IOBUF_LVCMOS33_F_6
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS33_F_6 : component is true;

  component IOBUF_LVCMOS33_F_8
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS33_F_8 : component is true;

  component IOBUF_LVCMOS33_S_12
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS33_S_12 : component is true;

  component IOBUF_LVCMOS33_S_16
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS33_S_16 : component is true;

  component IOBUF_LVCMOS33_S_2
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS33_S_2 : component is true;

  component IOBUF_LVCMOS33_S_24
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS33_S_24 : component is true;

  component IOBUF_LVCMOS33_S_4
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS33_S_4 : component is true;

  component IOBUF_LVCMOS33_S_6
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS33_S_6 : component is true;

  component IOBUF_LVCMOS33_S_8
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVCMOS33_S_8 : component is true;

  component IOBUF_LVDCI_15
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVDCI_15 : component is true;

  component IOBUF_LVDCI_18
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVDCI_18 : component is true;

  component IOBUF_LVDCI_25
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVDCI_25 : component is true;

  component IOBUF_LVDCI_33
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVDCI_33 : component is true;

  component IOBUF_LVDCI_DV2_15
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVDCI_DV2_15 : component is true;

  component IOBUF_LVDCI_DV2_18
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVDCI_DV2_18 : component is true;

  component IOBUF_LVDCI_DV2_25
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVDCI_DV2_25 : component is true;

  component IOBUF_LVDCI_DV2_33
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVDCI_DV2_33 : component is true;

  component IOBUF_LVDS
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVDS : component is true;

  component IOBUF_LVPECL
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVPECL : component is true;

  component IOBUF_LVTTL
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVTTL : component is true;

  component IOBUF_LVTTL_F_12
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVTTL_F_12 : component is true;

  component IOBUF_LVTTL_F_16
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVTTL_F_16 : component is true;

  component IOBUF_LVTTL_F_2
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVTTL_F_2 : component is true;

  component IOBUF_LVTTL_F_24
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVTTL_F_24 : component is true;

  component IOBUF_LVTTL_F_4
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVTTL_F_4 : component is true;

  component IOBUF_LVTTL_F_6
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVTTL_F_6 : component is true;

  component IOBUF_LVTTL_F_8
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVTTL_F_8 : component is true;

  component IOBUF_LVTTL_S_12
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVTTL_S_12 : component is true;

  component IOBUF_LVTTL_S_16
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVTTL_S_16 : component is true;

  component IOBUF_LVTTL_S_2
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVTTL_S_2 : component is true;

  component IOBUF_LVTTL_S_24
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVTTL_S_24 : component is true;

  component IOBUF_LVTTL_S_4
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVTTL_S_4 : component is true;

  component IOBUF_LVTTL_S_6
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVTTL_S_6 : component is true;

  component IOBUF_LVTTL_S_8
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_LVTTL_S_8 : component is true;

  component IOBUF_PCI33_3
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_PCI33_3 : component is true;

  component IOBUF_PCI33_5
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_PCI33_5 : component is true;

  component IOBUF_PCI66_3
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_PCI66_3 : component is true;

  component IOBUF_PCIX
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_PCIX : component is true;

  component IOBUF_PCIX66_3
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_PCIX66_3 : component is true;

  component IOBUF_S_12
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_S_12 : component is true;

  component IOBUF_S_16
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_S_16 : component is true;

  component IOBUF_S_2
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_S_2 : component is true;

  component IOBUF_S_24
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_S_24 : component is true;

  component IOBUF_S_4
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_S_4 : component is true;

  component IOBUF_S_6
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_S_6 : component is true;

  component IOBUF_S_8
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_S_8 : component is true;

  component IOBUF_SSTL18_I
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_SSTL18_I : component is true;

  component IOBUF_SSTL18_II
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_SSTL18_II : component is true;

  component IOBUF_SSTL18_II_DCI
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_SSTL18_II_DCI : component is true;

  component IOBUF_SSTL2_I
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_SSTL2_I : component is true;

  component IOBUF_SSTL2_II
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_SSTL2_II : component is true;

  component IOBUF_SSTL2_II_DCI
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_SSTL2_II_DCI : component is true;

  component IOBUF_SSTL3_I
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_SSTL3_I : component is true;

  component IOBUF_SSTL3_II
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_SSTL3_II : component is true;

  component IOBUF_SSTL3_II_DCI
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      I  : in    std_ulogic;
      T  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUF_SSTL3_II_DCI : component is true;

  component IOBUFDS
    generic(
      CAPACITANCE : string     := "DONT_CARE";
      DRIVE : integer	:= 12;
      IOSTANDARD  : string     := "DEFAULT"
      );

    port(
      O   : out   std_ulogic;

      IO  : inout std_ulogic;
      IOB : inout std_ulogic;

      I   : in    std_ulogic;
      T   : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUFDS : component is true;

  component IOBUFDS_BLVDS_25
    port(
      O   : out   std_ulogic;

      IO  : inout std_ulogic;
      IOB : inout std_ulogic;

      I   : in    std_ulogic;
      T   : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUFDS_BLVDS_25 : component is true;

  component IOBUFE
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      E  : in    std_ulogic;
      I  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUFE : component is true;

  component IOBUFE_F
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      E  : in    std_ulogic;
      I  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUFE_F : component is true;

  component IOBUFE_S
    port(
      O  : out   std_ulogic;

      IO : inout std_ulogic;

      E  : in    std_ulogic;
      I  : in    std_ulogic
      );
  end component;
attribute syn_black_box of IOBUFE_S : component is true;

  component ISERDES
  generic(
      BITSLIP_ENABLE	: boolean	:= false;
      DATA_RATE		: string	:= "DDR";
      DATA_WIDTH	: integer	:= 4;
      INIT_Q1		: bit		:= '0';
      INIT_Q2		: bit		:= '0';
      INIT_Q3		: bit		:= '0';
      INIT_Q4		: bit		:= '0';
      INTERFACE_TYPE	: string	:= "MEMORY";
      IOBDELAY		: string	:= "NONE";
      IOBDELAY_TYPE	: string	:= "DEFAULT";
      IOBDELAY_VALUE	: integer	:= 0;
      NUM_CE		: integer	:= 2;
      SERDES_MODE	: string	:= "MASTER";
      SRVAL_Q1		: bit		:= '0';
      SRVAL_Q2		: bit		:= '0';
      SRVAL_Q3		: bit		:= '0';
      SRVAL_Q4		: bit		:= '0'
      );

  port(
      O			: out std_ulogic;
      Q1		: out std_ulogic;
      Q2		: out std_ulogic;
      Q3		: out std_ulogic;
      Q4		: out std_ulogic;
      Q5		: out std_ulogic;
      Q6		: out std_ulogic;
      SHIFTOUT1		: out std_ulogic;
      SHIFTOUT2		: out std_ulogic;

      BITSLIP		: in std_ulogic;
      CE1		: in std_ulogic;
      CE2		: in std_ulogic;
      CLK		: in std_ulogic;
      CLKDIV		: in std_ulogic;
      D			: in std_ulogic;
      DLYCE		: in std_ulogic;
      DLYINC		: in std_ulogic;
      DLYRST		: in std_ulogic;
      OCLK		: in std_ulogic;
      REV		: in std_ulogic;
      SHIFTIN1		: in std_ulogic;
      SHIFTIN2		: in std_ulogic;
      SR		: in std_ulogic
    );
  end component;
attribute syn_black_box of ISERDES : component is true;

  component KEEP
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of KEEP : component is true;

  component KEEPER
    port(
      O : inout std_ulogic
      );
  end component;
attribute syn_black_box of KEEPER : component is true;
attribute syn_noprune of KEEPER : component is true;

  component LD
    generic(
      INIT : bit := '0' 
      );

    port(
      Q : out std_ulogic;

      D : in  std_ulogic;
      G : in  std_ulogic
      );
  end component;
attribute syn_black_box of LD : component is true;

  component LD_1
    generic(
      INIT : bit := '0' 
      );

    port(
      Q : out std_ulogic;

      D : in  std_ulogic;
      G : in  std_ulogic
      );
  end component;
attribute syn_black_box of LD_1 : component is true;

  component LDC
    generic(
      INIT : bit := '0' 
      );

    port(
      Q   : out std_ulogic;

      CLR : in  std_ulogic;
      D   : in  std_ulogic;
      G   : in  std_ulogic
      );
  end component;
attribute syn_black_box of LDC : component is true;

  component LDC_1
    generic(
      INIT : bit := '0' 
      );

    port(
      Q   : out std_ulogic;

      CLR : in  std_ulogic;
      D   : in  std_ulogic;
      G   : in  std_ulogic
      );
  end component;
attribute syn_black_box of LDC_1 : component is true;

  component LDCE
    generic(
      INIT : bit := '0' 
      );

    port(
      Q   : out std_ulogic;

      CLR : in  std_ulogic;
      D   : in  std_ulogic;
      G   : in  std_ulogic;
      GE  : in  std_ulogic
      );
  end component;
attribute syn_black_box of LDCE : component is true;

  component LDCE_1
    generic(
      INIT : bit := '0' 
      );

    port(
      Q   : out std_ulogic;

      CLR : in  std_ulogic;
      D   : in  std_ulogic;
      G   : in  std_ulogic;
      GE  : in  std_ulogic
      );
  end component;
attribute syn_black_box of LDCE_1 : component is true;

  component LDCP
    generic(
      INIT : bit := '0' 
      );

    port(
      Q   : out std_ulogic;

      CLR : in  std_ulogic;
      D   : in  std_ulogic;
      G   : in  std_ulogic;
      PRE : in  std_ulogic
      );
  end component;
attribute syn_black_box of LDCP : component is true;

  component LDCP_1
    generic(
      INIT : bit := '0' 
      );

    port(
      Q   : out std_ulogic;

      CLR : in  std_ulogic;
      D   : in  std_ulogic;
      G   : in  std_ulogic;
      PRE : in  std_ulogic
      );
  end component;
attribute syn_black_box of LDCP_1 : component is true;

  component LDCPE
    generic(
      INIT : bit := '0' 
      );

    port(
      Q   : out std_ulogic;

      CLR : in  std_ulogic;
      D   : in  std_ulogic;
      G   : in  std_ulogic;
      GE  : in  std_ulogic;
      PRE : in  std_ulogic
      );
  end component;
attribute syn_black_box of LDCPE : component is true;

  component LDCPE_1
    generic(
      INIT : bit := '0' 
      );

    port(
      Q   : out std_ulogic;

      CLR : in  std_ulogic;
      D   : in  std_ulogic;
      G   : in  std_ulogic;
      GE  : in  std_ulogic;
      PRE : in  std_ulogic
      );
  end component;
attribute syn_black_box of LDCPE_1 : component is true;

  component LDE
    generic(
      INIT : bit := '0' 
      );

    port(
      Q  : out std_ulogic;

      D  : in  std_ulogic;
      G  : in  std_ulogic;
      GE : in  std_ulogic
      );
  end component;
attribute syn_black_box of LDE : component is true;

  component LDE_1
    generic(
      INIT : bit := '0' 
      );

    port(
      Q  : out std_ulogic;

      D  : in  std_ulogic;
      G  : in  std_ulogic;
      GE : in  std_ulogic
      );
  end component;
attribute syn_black_box of LDE_1 : component is true;

  component LDP
    generic(
      INIT : bit := '1' 
      );

    port(
      Q   : out std_ulogic;

      D   : in  std_ulogic;
      G   : in  std_ulogic;
      PRE : in  std_ulogic
      );
  end component;
attribute syn_black_box of LDP : component is true;

  component LDP_1
    generic(
      INIT : bit := '1' 
      );

    port(
      Q   : out std_ulogic;

      D   : in  std_ulogic;
      G   : in  std_ulogic;
      PRE : in  std_ulogic
      );
  end component;
attribute syn_black_box of LDP_1 : component is true;

  component LDPE
    generic(
      INIT : bit := '1' 
      );

    port(
      Q   : out std_ulogic;

      D   : in  std_ulogic;
      G   : in  std_ulogic;
      GE  : in  std_ulogic;
      PRE : in  std_ulogic
      );
  end component;
attribute syn_black_box of LDPE : component is true;

  component LDPE_1
    generic(
      INIT : bit := '1' 
      );

    port(
      Q   : out std_ulogic;

      D   : in  std_ulogic;
      G   : in  std_ulogic;
      GE  : in  std_ulogic;
      PRE : in  std_ulogic
      );
  end component;
attribute syn_black_box of LDPE_1 : component is true;

  component LUT1
    generic(
      INIT : bit_vector := "00"
      );

    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic
      );
  end component;
attribute syn_black_box of LUT1 : component is true;
attribute xc_map of LUT1 : component is "lut";

  component LUT1_D
    generic(
      INIT : bit_vector := "00"
      );

    port(
      LO : out std_ulogic;
      O  : out std_ulogic;

      I0 : in  std_ulogic
      );
  end component;
attribute syn_black_box of LUT1_D : component is true;
attribute xc_map of LUT1_D : component is "lut";

  component LUT1_L
    generic(
      INIT : bit_vector := "00"
      );

    port(
      LO : out std_ulogic;

      I0 : in  std_ulogic
      );
  end component;
attribute syn_black_box of LUT1_L : component is true;
attribute xc_map of LUT1_L : component is "lut";

  component LUT2
    generic(
      INIT : bit_vector := X"0"
      );

    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic
      );
  end component;
attribute syn_black_box of LUT2 : component is true;
attribute xc_map of LUT2 : component is "lut";

  component LUT2_D
    generic(
      INIT : bit_vector := X"0"
      );

    port(
      LO : out std_ulogic;
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic
      );
  end component;
attribute syn_black_box of LUT2_D : component is true;
attribute xc_map of LUT2_D : component is "lut";

  component LUT2_L
    generic(
      INIT : bit_vector := X"0"
      );

    port(
      LO : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic
      );
  end component;
attribute syn_black_box of LUT2_L : component is true;
attribute xc_map of LUT2_L : component is "lut";

  component LUT3
    generic(
      INIT : bit_vector := X"00"
      );

    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic
      );
  end component;
attribute syn_black_box of LUT3 : component is true;
attribute xc_map of LUT3 : component is "lut";

  component LUT3_D
    generic(
      INIT : bit_vector := X"00"
      );

    port(
      LO : out std_ulogic;
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic
      );
  end component;
attribute syn_black_box of LUT3_D : component is true;
attribute xc_map of LUT3_D : component is "lut";

  component LUT3_L
    generic(
      INIT : bit_vector := X"00"
      );

    port(
      LO : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic
      );
  end component;
attribute syn_black_box of LUT3_L : component is true;
attribute xc_map of LUT3_L : component is "lut";

  component LUT4
    generic(
      INIT : bit_vector := X"0000"
      );

    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic
      );
  end component;
attribute syn_black_box of LUT4 : component is true;
attribute xc_map of LUT4 : component is "lut";

  component LUT4_D
    generic(
      INIT : bit_vector := X"0000"
      );

    port(
      LO : out std_ulogic;
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic
      );
  end component;
attribute syn_black_box of LUT4_D : component is true;
attribute xc_map of LUT4_D : component is "lut";

  component LUT4_L
    generic(
      INIT : bit_vector := X"0000"
      );

    port(
      LO : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic
      );
  end component;
attribute syn_black_box of LUT4_L : component is true;
attribute xc_map of LUT4_L : component is "lut";

  component MERGE
    port(
      I : in std_ulogic
      );
  end component;
attribute syn_black_box of MERGE : component is true;

  component MIN_OFF
    port(
      I : in std_ulogic
      );
  end component;
attribute syn_black_box of MIN_OFF : component is true;

  component MULT18X18
    port (
      P : out std_logic_vector (35 downto 0);

      A : in  std_logic_vector (17 downto 0);
      B : in  std_logic_vector (17 downto 0)
      );

  end component;
attribute syn_black_box of MULT18X18 : component is true;

  component MULT18X18S
    port (
      P  : out std_logic_vector (35 downto 0);

      A  : in  std_logic_vector (17 downto 0);
      B  : in  std_logic_vector (17 downto 0);
      C  : in  std_ulogic ;
      CE : in  std_ulogic ;
      R  : in  std_ulogic
      );

  end component;
attribute syn_black_box of MULT18X18S : component is true;

  component MULT18X18SIO
  generic (
	AREG            : integer       := 1;
	BREG            : integer       := 1;
	B_INPUT         : string        := "DIRECT";
	PREG            : integer       := 1
        );

  port (
	BCOUT	: out std_logic_vector (17 downto 0);
	P	: out std_logic_vector (35 downto 0);

	A	: in  std_logic_vector (17 downto 0);
	B	: in  std_logic_vector (17 downto 0);
	BCIN	: in  std_logic_vector (17 downto 0);
	CEA	: in  std_ulogic;
	CEB	: in  std_ulogic;
	CEP	: in  std_ulogic;
	CLK	: in  std_ulogic;
	RSTA	: in  std_ulogic;
	RSTB	: in  std_ulogic;
	RSTP	: in  std_ulogic
	);
  end component;
attribute syn_black_box of MULT18X18SIO : component is true;

  component MULT_AND
    port(
      LO : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic
      );
  end component;
attribute syn_black_box of MULT_AND : component is true;

  component MUXCY
    port(
      O  : out std_ulogic;

      CI : in  std_ulogic;
      DI : in  std_ulogic;
      S  : in  std_ulogic
      );
  end component;
attribute syn_black_box of MUXCY : component is true;

  component MUXCY_D
    port(
      LO : out std_ulogic;
      O  : out std_ulogic;

      CI : in  std_ulogic;
      DI : in  std_ulogic;
      S  : in  std_ulogic
      );
  end component;
attribute syn_black_box of MUXCY_D : component is true;

  component MUXCY_L
    port(
      LO : out std_ulogic;

      CI : in  std_ulogic;
      DI : in  std_ulogic;
      S  : in  std_ulogic
      );
  end component;
attribute syn_black_box of MUXCY_L : component is true;

  component MUXF5
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      S  : in  std_ulogic
      );
  end component;
attribute syn_black_box of MUXF5 : component is true;

  component MUXF5_D
    port(
      LO : out std_ulogic;
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      S  : in  std_ulogic
      );
  end component;
attribute syn_black_box of MUXF5_D : component is true;

  component MUXF5_L
    port(
      LO : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      S  : in  std_ulogic
      );
  end component;
attribute syn_black_box of MUXF5_L : component is true;

  component MUXF6
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      S  : in  std_ulogic
      );
  end component;
attribute syn_black_box of MUXF6 : component is true;

  component MUXF6_D
    port(
      LO : out std_ulogic;
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      S  : in  std_ulogic
      );
  end component;
attribute syn_black_box of MUXF6_D : component is true;

  component MUXF6_L
    port(
      LO : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      S  : in  std_ulogic
      );
  end component;
attribute syn_black_box of MUXF6_L : component is true;

  component MUXF7
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      S  : in  std_ulogic
      );
  end component;
attribute syn_black_box of MUXF7 : component is true;

  component MUXF7_D
    port(
      LO : out std_ulogic;
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      S  : in  std_ulogic
      );
  end component;
attribute syn_black_box of MUXF7_D : component is true;

  component MUXF7_L
    port(
      LO : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      S  : in  std_ulogic
      );
  end component;
attribute syn_black_box of MUXF7_L : component is true;

  component MUXF8
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      S  : in  std_ulogic
      );
  end component;
attribute syn_black_box of MUXF8 : component is true;

  component MUXF8_D
    port(
      LO : out std_ulogic;
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      S  : in  std_ulogic
      );
  end component;
attribute syn_black_box of MUXF8_D : component is true;

  component MUXF8_L
    port(
      LO : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      S  : in  std_ulogic
      );
  end component;
attribute syn_black_box of MUXF8_L : component is true;

  component NAND2
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic
      );
  end component;
attribute syn_black_box of NAND2 : component is true;

  component NAND2B1
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic
      );
  end component;
attribute syn_black_box of NAND2B1 : component is true;

  component NAND2B2
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic
      );
  end component;
attribute syn_black_box of NAND2B2 : component is true;

  component NAND3
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic
      );
  end component;
attribute syn_black_box of NAND3 : component is true;

  component NAND3B1
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic
      );
  end component;
attribute syn_black_box of NAND3B1 : component is true;

  component NAND3B2
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic
      );
  end component;
attribute syn_black_box of NAND3B2 : component is true;

  component NAND3B3
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic
      );
  end component;
attribute syn_black_box of NAND3B3 : component is true;

  component NAND4
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic
      );
  end component;
attribute syn_black_box of NAND4 : component is true;

  component NAND4B1
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic
      );
  end component;
attribute syn_black_box of NAND4B1 : component is true;

  component NAND4B2
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic
      );
  end component;
attribute syn_black_box of NAND4B2 : component is true;

  component NAND4B3
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic
      );
  end component;
attribute syn_black_box of NAND4B3 : component is true;

  component NAND4B4
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic
      );
  end component;
attribute syn_black_box of NAND4B4 : component is true;

  component NAND5
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic;
      I4 : in  std_ulogic
      );
  end component;
attribute syn_black_box of NAND5 : component is true;

  component NAND5B1
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic;
      I4 : in  std_ulogic
      );
  end component;
attribute syn_black_box of NAND5B1 : component is true;

  component NAND5B2
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic;
      I4 : in  std_ulogic
      );
  end component;
attribute syn_black_box of NAND5B2 : component is true;

  component NAND5B3
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic;
      I4 : in  std_ulogic
      );
  end component;
attribute syn_black_box of NAND5B3 : component is true;

  component NAND5B4
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic;
      I4 : in  std_ulogic
      );
  end component;
attribute syn_black_box of NAND5B4 : component is true;

  component NAND5B5
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic;
      I4 : in  std_ulogic
      );
  end component;
attribute syn_black_box of NAND5B5 : component is true;

  component NOR2
    port(
      O  : out std_ulogic;
  
      I0 : in  std_ulogic;
      I1 : in  std_ulogic
      );
  end component;
attribute syn_black_box of NOR2 : component is true;

  component NOR2B1
    port(
      O  : out std_ulogic;
  
      I0 : in  std_ulogic;
      I1 : in  std_ulogic
      );
  end component;
attribute syn_black_box of NOR2B1 : component is true;

  component NOR2B2
    port(
      O  : out std_ulogic;
  
      I0 : in  std_ulogic;
      I1 : in  std_ulogic
      );
  end component;
attribute syn_black_box of NOR2B2 : component is true;

  component NOR3
    port(
      O  : out std_ulogic;
  
      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic
      );
  end component;
attribute syn_black_box of NOR3 : component is true;

  component NOR3B1
    port(
      O  : out std_ulogic;
      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic
      );
  end component;
attribute syn_black_box of NOR3B1 : component is true;

  component NOR3B2
    port(
      O  : out std_ulogic;
      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic
      );
  end component;
attribute syn_black_box of NOR3B2 : component is true;

  component NOR3B3
    port(
      O  : out std_ulogic;
      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic
      );
  end component;
attribute syn_black_box of NOR3B3 : component is true;

  component NOR4
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic
      );
  end component;
attribute syn_black_box of NOR4 : component is true;

  component NOR4B1
    port(
      O  : out std_ulogic;
      
      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic
      );
  end component;
attribute syn_black_box of NOR4B1 : component is true;

  component NOR4B2
    port(
      O  : out std_ulogic;
      
      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic
      );
  end component;
attribute syn_black_box of NOR4B2 : component is true;

  component NOR4B3
    port(
      O  : out std_ulogic;
      
      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic
      );
  end component;
attribute syn_black_box of NOR4B3 : component is true;

  component NOR4B4
    port(
      O  : out std_ulogic;
      
      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic
      );
  end component;
attribute syn_black_box of NOR4B4 : component is true;

  component NOR5
    port(
      O  : out std_ulogic;
      
      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic;
      I4 : in  std_ulogic
      );
  end component;
attribute syn_black_box of NOR5 : component is true;

  component NOR5B1
    port(
      O  : out std_ulogic;
      
      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic;
      I4 : in  std_ulogic
      );
  end component;
attribute syn_black_box of NOR5B1 : component is true;

  component NOR5B2
    port(
      O  : out std_ulogic;
      
      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic;
      I4 : in  std_ulogic
      );
  end component;
attribute syn_black_box of NOR5B2 : component is true;

  component NOR5B3
    port(
      O  : out std_ulogic;
      
      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic;
      I4 : in  std_ulogic
      );
  end component;
attribute syn_black_box of NOR5B3 : component is true;

  component NOR5B4
    port(
      O  : out std_ulogic;
      
      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic;
      I4 : in  std_ulogic
      );
  end component;
attribute syn_black_box of NOR5B4 : component is true;

  component NOR5B5
    port(
      O  : out std_ulogic;
      
      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic;
      I4 : in  std_ulogic
      );
  end component;
attribute syn_black_box of NOR5B5 : component is true;

  component OBUF
    generic(
      CAPACITANCE : string     := "DONT_CARE";
      DRIVE       : integer    := 12;
      IOSTANDARD  : string     := "DEFAULT";
      SLEW        : string     := "SLOW"
      );
  
    port(
      O : out std_ulogic;
  
      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF : component is true;

  component OBUF_AGP
    port(
      O : out std_ulogic;
      
      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_AGP : component is true;

  component OBUF_CTT
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_CTT : component is true;

  component OBUF_F_12
    port(
      O : out std_ulogic;
      
      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_F_12 : component is true;

  component OBUF_F_16
    port(
      O : out std_ulogic;
      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_F_16 : component is true;

  component OBUF_F_2
    port(
      O : out std_ulogic;
      
      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_F_2 : component is true;

  component OBUF_F_24
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_F_24 : component is true;

  component OBUF_F_4
    port(
      O : out std_ulogic;
  
      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_F_4 : component is true;

  component OBUF_F_6
    port(
      O : out std_ulogic;
      
      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_F_6 : component is true;

  component OBUF_F_8
    port(
      O : out std_ulogic;
      
      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_F_8 : component is true;

  component OBUF_GTL
    port(
      O : out std_ulogic;
      
      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_GTL : component is true;

  component OBUF_GTL_DCI
    port(
      O : out std_ulogic;
  
      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_GTL_DCI : component is true;

  component OBUF_GTLP
    port(
      O : out std_ulogic;
  
      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_GTLP : component is true;

  component OBUF_GTLP_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_GTLP_DCI : component is true;

  component OBUF_HSTL_I
    port(
      O : out std_ulogic;
      
      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_HSTL_I : component is true;

  component OBUF_HSTL_I_18
    port(
      O : out std_ulogic;
      
      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_HSTL_I_18 : component is true;

  component OBUF_HSTL_I_DCI
    port(
      O : out std_ulogic;
      
      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_HSTL_I_DCI : component is true;

  component OBUF_HSTL_I_DCI_18
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_HSTL_I_DCI_18 : component is true;

  component OBUF_HSTL_II
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_HSTL_II : component is true;

  component OBUF_HSTL_II_18
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_HSTL_II_18 : component is true;

  component OBUF_HSTL_II_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_HSTL_II_DCI : component is true;

  component OBUF_HSTL_II_DCI_18
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_HSTL_II_DCI_18 : component is true;

  component OBUF_HSTL_III
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_HSTL_III : component is true;

  component OBUF_HSTL_III_18
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_HSTL_III_18 : component is true;

  component OBUF_HSTL_III_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_HSTL_III_DCI : component is true;

  component OBUF_HSTL_III_DCI_18
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_HSTL_III_DCI_18 : component is true;

  component OBUF_HSTL_IV
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_HSTL_IV : component is true;

  component OBUF_HSTL_IV_18
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_HSTL_IV_18 : component is true;

  component OBUF_HSTL_IV_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_HSTL_IV_DCI : component is true;

  component OBUF_HSTL_IV_DCI_18
    port(
      O : out std_ulogic;
      
      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_HSTL_IV_DCI_18 : component is true;

  component OBUF_LVCMOS12
    port(
      O : out std_ulogic;
      
      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS12 : component is true;

  component OBUF_LVCMOS12_F_2
    port(
      O : out std_ulogic;
      
      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS12_F_2 : component is true;

  component OBUF_LVCMOS12_F_4
    port(
      O : out std_ulogic;
      
      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS12_F_4 : component is true;

  component OBUF_LVCMOS12_F_6
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS12_F_6 : component is true;

  component OBUF_LVCMOS12_F_8
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS12_F_8 : component is true;

  component OBUF_LVCMOS12_S_2
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS12_S_2 : component is true;

  component OBUF_LVCMOS12_S_4
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS12_S_4 : component is true;

  component OBUF_LVCMOS12_S_6
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS12_S_6 : component is true;

  component OBUF_LVCMOS12_S_8
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS12_S_8 : component is true;

  component OBUF_LVCMOS15
    port(
      O : out std_ulogic;
      
      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS15 : component is true;

  component OBUF_LVCMOS15_F_12
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS15_F_12 : component is true;

  component OBUF_LVCMOS15_F_16
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS15_F_16 : component is true;

  component OBUF_LVCMOS15_F_2
    port(
      O : out std_ulogic;
      
      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS15_F_2 : component is true;

  component OBUF_LVCMOS15_F_4
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS15_F_4 : component is true;

  component OBUF_LVCMOS15_F_6
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS15_F_6 : component is true;

  component OBUF_LVCMOS15_F_8
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS15_F_8 : component is true;

  component OBUF_LVCMOS15_S_12
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS15_S_12 : component is true;

  component OBUF_LVCMOS15_S_16
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS15_S_16 : component is true;

  component OBUF_LVCMOS15_S_2
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS15_S_2 : component is true;

  component OBUF_LVCMOS15_S_4
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS15_S_4 : component is true;

  component OBUF_LVCMOS15_S_6
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS15_S_6 : component is true;

  component OBUF_LVCMOS15_S_8
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS15_S_8 : component is true;

  component OBUF_LVCMOS18
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS18 : component is true;

  component OBUF_LVCMOS18_F_12
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS18_F_12 : component is true;

  component OBUF_LVCMOS18_F_16
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS18_F_16 : component is true;

  component OBUF_LVCMOS18_F_2
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS18_F_2 : component is true;

  component OBUF_LVCMOS18_F_4
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS18_F_4 : component is true;

  component OBUF_LVCMOS18_F_6
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS18_F_6 : component is true;

  component OBUF_LVCMOS18_F_8
    port(
      O : out std_ulogic;
      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS18_F_8 : component is true;

  component OBUF_LVCMOS18_S_12
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS18_S_12 : component is true;

  component OBUF_LVCMOS18_S_16
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS18_S_16 : component is true;

  component OBUF_LVCMOS18_S_2
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS18_S_2 : component is true;

  component OBUF_LVCMOS18_S_4
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS18_S_4 : component is true;

  component OBUF_LVCMOS18_S_6
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS18_S_6 : component is true;

  component OBUF_LVCMOS18_S_8
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS18_S_8 : component is true;

  component OBUF_LVCMOS2
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS2 : component is true;

  component OBUF_LVCMOS25
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS25 : component is true;

  component OBUF_LVCMOS25_F_12
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS25_F_12 : component is true;

  component OBUF_LVCMOS25_F_16
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS25_F_16 : component is true;

  component OBUF_LVCMOS25_F_2
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS25_F_2 : component is true;

  component OBUF_LVCMOS25_F_24
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS25_F_24 : component is true;

  component OBUF_LVCMOS25_F_4
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS25_F_4 : component is true;

  component OBUF_LVCMOS25_F_6
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS25_F_6 : component is true;

  component OBUF_LVCMOS25_F_8
    port(
      O : out std_ulogic;
      
      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS25_F_8 : component is true;

  component OBUF_LVCMOS25_S_12
    port(
      O : out std_ulogic;
      
      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS25_S_12 : component is true;

  component OBUF_LVCMOS25_S_16
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS25_S_16 : component is true;

  component OBUF_LVCMOS25_S_2
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS25_S_2 : component is true;

  component OBUF_LVCMOS25_S_24
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS25_S_24 : component is true;

  component OBUF_LVCMOS25_S_4
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS25_S_4 : component is true;

  component OBUF_LVCMOS25_S_6
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS25_S_6 : component is true;

  component OBUF_LVCMOS25_S_8
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS25_S_8 : component is true;

  component OBUF_LVCMOS33
    port(
      O : out std_ulogic;
  
      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS33 : component is true;

  component OBUF_LVCMOS33_F_12
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS33_F_12 : component is true;

  component OBUF_LVCMOS33_F_16
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS33_F_16 : component is true;

  component OBUF_LVCMOS33_F_2
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS33_F_2 : component is true;

  component OBUF_LVCMOS33_F_24
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS33_F_24 : component is true;

  component OBUF_LVCMOS33_F_4
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS33_F_4 : component is true;

  component OBUF_LVCMOS33_F_6
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS33_F_6 : component is true;

  component OBUF_LVCMOS33_F_8
    port(
      O : out std_ulogic;
      
      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS33_F_8 : component is true;

  component OBUF_LVCMOS33_S_12
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS33_S_12 : component is true;

  component OBUF_LVCMOS33_S_16
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS33_S_16 : component is true;

  component OBUF_LVCMOS33_S_2
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS33_S_2 : component is true;

  component OBUF_LVCMOS33_S_24
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS33_S_24 : component is true;

  component OBUF_LVCMOS33_S_4
    port(
      O : out std_ulogic;
      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS33_S_4 : component is true;

  component OBUF_LVCMOS33_S_6
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS33_S_6 : component is true;

  component OBUF_LVCMOS33_S_8
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVCMOS33_S_8 : component is true;

  component OBUF_LVDCI_15
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVDCI_15 : component is true;

  component OBUF_LVDCI_18
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVDCI_18 : component is true;

  component OBUF_LVDCI_25
    port(
      O : out std_ulogic;
      
      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVDCI_25 : component is true;

  component OBUF_LVDCI_33
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVDCI_33 : component is true;

  component OBUF_LVDCI_DV2_15
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVDCI_DV2_15 : component is true;

  component OBUF_LVDCI_DV2_18
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVDCI_DV2_18 : component is true;

  component OBUF_LVDCI_DV2_25
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVDCI_DV2_25 : component is true;

  component OBUF_LVDCI_DV2_33
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVDCI_DV2_33 : component is true;

  component OBUF_LVDS
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVDS : component is true;

  component OBUF_LVPECL
    port(
      O : out std_ulogic;
      
      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVPECL : component is true;

  component OBUF_LVTTL
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVTTL : component is true;

  component OBUF_LVTTL_F_12
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVTTL_F_12 : component is true;

  component OBUF_LVTTL_F_16
    port(
      O : out std_ulogic;
      
      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVTTL_F_16 : component is true;

  component OBUF_LVTTL_F_2
    port(
      O : out std_ulogic;
      
      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVTTL_F_2 : component is true;

  component OBUF_LVTTL_F_24
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVTTL_F_24 : component is true;

  component OBUF_LVTTL_F_4
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVTTL_F_4 : component is true;

  component OBUF_LVTTL_F_6
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVTTL_F_6 : component is true;

  component OBUF_LVTTL_F_8
    port(
      O : out std_ulogic;
  
      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVTTL_F_8 : component is true;

  component OBUF_LVTTL_S_12
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVTTL_S_12 : component is true;

  component OBUF_LVTTL_S_16
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVTTL_S_16 : component is true;

  component OBUF_LVTTL_S_2
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVTTL_S_2 : component is true;

  component OBUF_LVTTL_S_24
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVTTL_S_24 : component is true;

  component OBUF_LVTTL_S_4
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVTTL_S_4 : component is true;

  component OBUF_LVTTL_S_6
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVTTL_S_6 : component is true;

  component OBUF_LVTTL_S_8
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_LVTTL_S_8 : component is true;

  component OBUF_PCI33_3
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_PCI33_3 : component is true;

  component OBUF_PCI33_5
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_PCI33_5 : component is true;

  component OBUF_PCI66_3
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_PCI66_3 : component is true;

  component OBUF_PCIX
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_PCIX : component is true;

  component OBUF_PCIX66_3
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_PCIX66_3 : component is true;

  component OBUF_S_12
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_S_12 : component is true;

  component OBUF_S_16
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_S_16 : component is true;

  component OBUF_S_2
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_S_2 : component is true;

  component OBUF_S_24
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_S_24 : component is true;

  component OBUF_S_4
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_S_4 : component is true;

  component OBUF_S_6
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_S_6 : component is true;

  component OBUF_S_8
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_S_8 : component is true;

  component OBUF_SSTL18_I
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_SSTL18_I : component is true;

  component OBUF_SSTL18_I_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_SSTL18_I_DCI : component is true;

  component OBUF_SSTL18_II
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_SSTL18_II : component is true;

  component OBUF_SSTL18_II_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_SSTL18_II_DCI : component is true;

  component OBUF_SSTL2_I
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_SSTL2_I : component is true;

  component OBUF_SSTL2_I_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_SSTL2_I_DCI : component is true;

  component OBUF_SSTL2_II
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_SSTL2_II : component is true;

  component OBUF_SSTL2_II_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_SSTL2_II_DCI : component is true;

  component OBUF_SSTL3_I
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_SSTL3_I : component is true;

  component OBUF_SSTL3_I_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_SSTL3_I_DCI : component is true;

  component OBUF_SSTL3_II
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_SSTL3_II : component is true;

  component OBUF_SSTL3_II_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUF_SSTL3_II_DCI : component is true;

  component OBUFDS
    generic(
      CAPACITANCE : string     := "DONT_CARE";
	DRIVE : integer	:= 12;
      IOSTANDARD  : string     := "DEFAULT"
      );
    
    port(
      O  : out std_ulogic;
      OB : out std_ulogic;
      
      I  : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFDS : component is true;

  component OBUFDS_BLVDS_25
    port(
      O  : out std_ulogic;
      OB : out std_ulogic;

      I  : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFDS_BLVDS_25 : component is true;

  component OBUFDS_LDT_25
    port(
      O  : out std_ulogic;
      OB : out std_ulogic;

      I  : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFDS_LDT_25 : component is true;

  component OBUFDS_LVDS_25
    port(
      O  : out std_ulogic;
      OB : out std_ulogic;

      I  : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFDS_LVDS_25 : component is true;

  component OBUFDS_LVDS_33
    port(
      O  : out std_ulogic;
      OB : out std_ulogic;
      
      I  : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFDS_LVDS_33 : component is true;

  component OBUFDS_LVDSEXT_25
    port(
      O  : out std_ulogic;
      OB : out std_ulogic;
      
      I  : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFDS_LVDSEXT_25 : component is true;

  component OBUFDS_LVDSEXT_33
    port(
      O  : out std_ulogic;
      OB : out std_ulogic;
      
      I  : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFDS_LVDSEXT_33 : component is true;

  component OBUFDS_LVPECL_25
    port(
      O  : out std_ulogic;
      OB : out std_ulogic;
      
      I  : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFDS_LVPECL_25 : component is true;

  component OBUFDS_LVPECL_33
    port(
      O  : out std_ulogic;
      OB : out std_ulogic;

      I  : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFDS_LVPECL_33 : component is true;

  component OBUFDS_ULVDS_25
    port(
      O  : out std_ulogic;
      OB : out std_ulogic;

      I  : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFDS_ULVDS_25 : component is true;

component OBUFE
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_I_O : VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_E_O : VitalDelayType01z := (0.000 ns, 0.000 ns, 0.000 ns, 0.000 ns, 0.000 ns, 0.000 ns);
      tipd_I : VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_E : VitalDelayType01 := (0.000 ns, 0.000 ns));

-- synopsys translate_on
   port(
      O                              :  out   STD_ULOGIC;
      I                              :  in    STD_ULOGIC;
      E                              :  in    STD_ULOGIC);
end component;
attribute syn_black_box of OBUFE : component is true;

  component OBUFT
    generic(
      CAPACITANCE : string     := "DONT_CARE";
      DRIVE       : integer    := 12;
      IOSTANDARD  : string     := "DEFAULT";
      SLEW        : string     := "SLOW"
      );
  
    port(
      O : out std_ulogic;
      
      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT : component is true;
attribute black_box_tri_pins of OBUFT : component is "O";

  component OBUFT_AGP
    port(
      O : out std_ulogic;
      
      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_AGP : component is true;
attribute black_box_tri_pins of OBUFT_AGP : component is "O";

  component OBUFT_CTT
    port(
      O : out std_ulogic;
      
      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_CTT : component is true;
attribute black_box_tri_pins of OBUFT_CTT : component is "O";

  component OBUFT_F_12
    port(
      O : out std_ulogic;
      
      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_F_12 : component is true;
attribute black_box_tri_pins of OBUFT_F_12 : component is "O";

  component OBUFT_F_16
    port(
      O : out std_ulogic;
      
      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_F_16 : component is true;
attribute black_box_tri_pins of OBUFT_F_16 : component is "O";

  component OBUFT_F_2
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_F_2 : component is true;
attribute black_box_tri_pins of OBUFT_F_2 : component is "O";

  component OBUFT_F_24
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_F_24 : component is true;
attribute black_box_tri_pins of OBUFT_F_24 : component is "O";

  component OBUFT_F_4
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_F_4 : component is true;
attribute black_box_tri_pins of OBUFT_F_4 : component is "O";

  component OBUFT_F_6
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_F_6 : component is true;
attribute black_box_tri_pins of OBUFT_F_6 : component is "O";

  component OBUFT_F_8
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_F_8 : component is true;
attribute black_box_tri_pins of OBUFT_F_8 : component is "O";

  component OBUFT_GTL
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_GTL : component is true;
attribute black_box_tri_pins of OBUFT_GTL : component is "O";

  component OBUFT_GTL_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_GTL_DCI : component is true;
attribute black_box_tri_pins of OBUFT_GTL_DCI : component is "O";

  component OBUFT_GTLP
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_GTLP : component is true;
attribute black_box_tri_pins of OBUFT_GTLP : component is "O";

  component OBUFT_GTLP_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_GTLP_DCI : component is true;
attribute black_box_tri_pins of OBUFT_GTLP_DCI : component is "O";

  component OBUFT_HSTL_I
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_HSTL_I : component is true;
attribute black_box_tri_pins of OBUFT_HSTL_I : component is "O";

  component OBUFT_HSTL_I_18
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_HSTL_I_18 : component is true;
attribute black_box_tri_pins of OBUFT_HSTL_I_18 : component is "O";

  component OBUFT_HSTL_I_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_HSTL_I_DCI : component is true;
attribute black_box_tri_pins of OBUFT_HSTL_I_DCI : component is "O";

  component OBUFT_HSTL_I_DCI_18
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_HSTL_I_DCI_18 : component is true;
attribute black_box_tri_pins of OBUFT_HSTL_I_DCI_18 : component is "O";

  component OBUFT_HSTL_II
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_HSTL_II : component is true;
attribute black_box_tri_pins of OBUFT_HSTL_II : component is "O";

  component OBUFT_HSTL_II_18
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_HSTL_II_18 : component is true;
attribute black_box_tri_pins of OBUFT_HSTL_II_18 : component is "O";

  component OBUFT_HSTL_II_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_HSTL_II_DCI : component is true;
attribute black_box_tri_pins of OBUFT_HSTL_II_DCI : component is "O";

  component OBUFT_HSTL_II_DCI_18
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_HSTL_II_DCI_18 : component is true;
attribute black_box_tri_pins of OBUFT_HSTL_II_DCI_18 : component is "O";

  component OBUFT_HSTL_III
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_HSTL_III : component is true;
attribute black_box_tri_pins of OBUFT_HSTL_III : component is "O";

  component OBUFT_HSTL_III_18
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_HSTL_III_18 : component is true;
attribute black_box_tri_pins of OBUFT_HSTL_III_18 : component is "O";

  component OBUFT_HSTL_III_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_HSTL_III_DCI : component is true;
attribute black_box_tri_pins of OBUFT_HSTL_III_DCI : component is "O";

  component OBUFT_HSTL_III_DCI_18
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_HSTL_III_DCI_18 : component is true;
attribute black_box_tri_pins of OBUFT_HSTL_III_DCI_18 : component is "O";

  component OBUFT_HSTL_IV
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_HSTL_IV : component is true;
attribute black_box_tri_pins of OBUFT_HSTL_IV : component is "O";

  component OBUFT_HSTL_IV_18
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_HSTL_IV_18 : component is true;
attribute black_box_tri_pins of OBUFT_HSTL_IV_18 : component is "O";

  component OBUFT_HSTL_IV_DCI
    port(
      O : out std_ulogic;
      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_HSTL_IV_DCI : component is true;
attribute black_box_tri_pins of OBUFT_HSTL_IV_DCI : component is "O";

  component OBUFT_HSTL_IV_DCI_18
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_HSTL_IV_DCI_18 : component is true;
attribute black_box_tri_pins of OBUFT_HSTL_IV_DCI_18 : component is "O";

  component OBUFT_LVCMOS12
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS12 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS12 : component is "O";

  component OBUFT_LVCMOS12_F_2
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS12_F_2 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS12_F_2 : component is "O";

  component OBUFT_LVCMOS12_F_4
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS12_F_4 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS12_F_4 : component is "O";

  component OBUFT_LVCMOS12_F_6
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS12_F_6 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS12_F_6 : component is "O";

  component OBUFT_LVCMOS12_F_8
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS12_F_8 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS12_F_8 : component is "O";

  component OBUFT_LVCMOS12_S_2
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS12_S_2 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS12_S_2 : component is "O";

  component OBUFT_LVCMOS12_S_4
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS12_S_4 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS12_S_4 : component is "O";

  component OBUFT_LVCMOS12_S_6
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS12_S_6 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS12_S_6 : component is "O";

  component OBUFT_LVCMOS12_S_8
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS12_S_8 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS12_S_8 : component is "O";

  component OBUFT_LVCMOS15
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS15 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS15 : component is "O";

  component OBUFT_LVCMOS15_F_12
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS15_F_12 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS15_F_12 : component is "O";

  component OBUFT_LVCMOS15_F_16
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS15_F_16 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS15_F_16 : component is "O";

  component OBUFT_LVCMOS15_F_2
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS15_F_2 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS15_F_2 : component is "O";

  component OBUFT_LVCMOS15_F_4
    port(
      O : out std_ulogic;
      
      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS15_F_4 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS15_F_4 : component is "O";

  component OBUFT_LVCMOS15_F_6
    port(
      O : out std_ulogic;
      
      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS15_F_6 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS15_F_6 : component is "O";

  component OBUFT_LVCMOS15_F_8
    port(
      O : out std_ulogic;
      
      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS15_F_8 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS15_F_8 : component is "O";

  component OBUFT_LVCMOS15_S_12
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS15_S_12 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS15_S_12 : component is "O";

  component OBUFT_LVCMOS15_S_16
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS15_S_16 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS15_S_16 : component is "O";

  component OBUFT_LVCMOS15_S_2
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS15_S_2 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS15_S_2 : component is "O";

  component OBUFT_LVCMOS15_S_4
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS15_S_4 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS15_S_4 : component is "O";

  component OBUFT_LVCMOS15_S_6
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS15_S_6 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS15_S_6 : component is "O";

  component OBUFT_LVCMOS15_S_8
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS15_S_8 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS15_S_8 : component is "O";

  component OBUFT_LVCMOS18
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS18 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS18 : component is "O";

  component OBUFT_LVCMOS18_F_12
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS18_F_12 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS18_F_12 : component is "O";

  component OBUFT_LVCMOS18_F_16
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS18_F_16 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS18_F_16 : component is "O";

  component OBUFT_LVCMOS18_F_2
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS18_F_2 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS18_F_2 : component is "O";

  component OBUFT_LVCMOS18_F_4
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS18_F_4 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS18_F_4 : component is "O";

  component OBUFT_LVCMOS18_F_6
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS18_F_6 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS18_F_6 : component is "O";

  component OBUFT_LVCMOS18_F_8
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS18_F_8 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS18_F_8 : component is "O";

  component OBUFT_LVCMOS18_S_12
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS18_S_12 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS18_S_12 : component is "O";

  component OBUFT_LVCMOS18_S_16
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS18_S_16 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS18_S_16 : component is "O";

  component OBUFT_LVCMOS18_S_2
    port(
      O : out std_ulogic;
      
      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS18_S_2 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS18_S_2 : component is "O";

  component OBUFT_LVCMOS18_S_4
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS18_S_4 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS18_S_4 : component is "O";

  component OBUFT_LVCMOS18_S_6
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS18_S_6 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS18_S_6 : component is "O";

  component OBUFT_LVCMOS18_S_8
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS18_S_8 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS18_S_8 : component is "O";

  component OBUFT_LVCMOS2
    port(
      O : out std_ulogic;
      
      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS2 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS2 : component is "O";

  component OBUFT_LVCMOS25
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS25 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS25 : component is "O";

  component OBUFT_LVCMOS25_F_12
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS25_F_12 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS25_F_12 : component is "O";

  component OBUFT_LVCMOS25_F_16
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS25_F_16 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS25_F_16 : component is "O";

  component OBUFT_LVCMOS25_F_2
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS25_F_2 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS25_F_2 : component is "O";

  component OBUFT_LVCMOS25_F_24
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS25_F_24 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS25_F_24 : component is "O";

  component OBUFT_LVCMOS25_F_4
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS25_F_4 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS25_F_4 : component is "O";

  component OBUFT_LVCMOS25_F_6
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS25_F_6 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS25_F_6 : component is "O";

  component OBUFT_LVCMOS25_F_8
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS25_F_8 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS25_F_8 : component is "O";

  component OBUFT_LVCMOS25_S_12
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS25_S_12 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS25_S_12 : component is "O";

  component OBUFT_LVCMOS25_S_16
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS25_S_16 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS25_S_16 : component is "O";

  component OBUFT_LVCMOS25_S_2
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS25_S_2 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS25_S_2 : component is "O";

  component OBUFT_LVCMOS25_S_24
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS25_S_24 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS25_S_24 : component is "O";

  component OBUFT_LVCMOS25_S_4
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS25_S_4 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS25_S_4 : component is "O";

  component OBUFT_LVCMOS25_S_6
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS25_S_6 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS25_S_6 : component is "O";

  component OBUFT_LVCMOS25_S_8
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS25_S_8 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS25_S_8 : component is "O";

  component OBUFT_LVCMOS33
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS33 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS33 : component is "O";

  component OBUFT_LVCMOS33_F_12
    port(
      O : out std_ulogic;
      
      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS33_F_12 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS33_F_12 : component is "O";

  component OBUFT_LVCMOS33_F_16
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS33_F_16 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS33_F_16 : component is "O";

  component OBUFT_LVCMOS33_F_2
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS33_F_2 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS33_F_2 : component is "O";

  component OBUFT_LVCMOS33_F_24
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS33_F_24 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS33_F_24 : component is "O";

  component OBUFT_LVCMOS33_F_4
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS33_F_4 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS33_F_4 : component is "O";

  component OBUFT_LVCMOS33_F_6
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS33_F_6 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS33_F_6 : component is "O";

  component OBUFT_LVCMOS33_F_8
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS33_F_8 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS33_F_8 : component is "O";

  component OBUFT_LVCMOS33_S_12
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS33_S_12 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS33_S_12 : component is "O";

  component OBUFT_LVCMOS33_S_16
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS33_S_16 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS33_S_16 : component is "O";

  component OBUFT_LVCMOS33_S_2
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS33_S_2 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS33_S_2 : component is "O";

  component OBUFT_LVCMOS33_S_24
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS33_S_24 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS33_S_24 : component is "O";

  component OBUFT_LVCMOS33_S_4
    port(
      O : out std_ulogic;
  
      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS33_S_4 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS33_S_4 : component is "O";

  component OBUFT_LVCMOS33_S_6
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS33_S_6 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS33_S_6 : component is "O";

  component OBUFT_LVCMOS33_S_8
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVCMOS33_S_8 : component is true;
attribute black_box_tri_pins of OBUFT_LVCMOS33_S_8 : component is "O";

  component OBUFT_LVDCI_15
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVDCI_15 : component is true;
attribute black_box_tri_pins of OBUFT_LVDCI_15 : component is "O";

  component OBUFT_LVDCI_18
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVDCI_18 : component is true;
attribute black_box_tri_pins of OBUFT_LVDCI_18 : component is "O";

  component OBUFT_LVDCI_25
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVDCI_25 : component is true;
attribute black_box_tri_pins of OBUFT_LVDCI_25 : component is "O";

  component OBUFT_LVDCI_33
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVDCI_33 : component is true;
attribute black_box_tri_pins of OBUFT_LVDCI_33 : component is "O";

  component OBUFT_LVDCI_DV2_15
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVDCI_DV2_15 : component is true;
attribute black_box_tri_pins of OBUFT_LVDCI_DV2_15 : component is "O";

  component OBUFT_LVDCI_DV2_18
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVDCI_DV2_18 : component is true;
attribute black_box_tri_pins of OBUFT_LVDCI_DV2_18 : component is "O";

  component OBUFT_LVDCI_DV2_25
    port(
      O : out std_ulogic;
      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVDCI_DV2_25 : component is true;
attribute black_box_tri_pins of OBUFT_LVDCI_DV2_25 : component is "O";

  component OBUFT_LVDCI_DV2_33
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVDCI_DV2_33 : component is true;
attribute black_box_tri_pins of OBUFT_LVDCI_DV2_33 : component is "O";

  component OBUFT_LVDS
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVDS : component is true;
attribute black_box_tri_pins of OBUFT_LVDS : component is "O";

  component OBUFT_LVPECL
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVPECL : component is true;
attribute black_box_tri_pins of OBUFT_LVPECL : component is "O";

  component OBUFT_LVTTL
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVTTL : component is true;
attribute black_box_tri_pins of OBUFT_LVTTL : component is "O";

  component OBUFT_LVTTL_F_12
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVTTL_F_12 : component is true;
attribute black_box_tri_pins of OBUFT_LVTTL_F_12 : component is "O";

  component OBUFT_LVTTL_F_16
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVTTL_F_16 : component is true;
attribute black_box_tri_pins of OBUFT_LVTTL_F_16 : component is "O";

  component OBUFT_LVTTL_F_2
    port(
      O : out std_ulogic;
      
      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVTTL_F_2 : component is true;
attribute black_box_tri_pins of OBUFT_LVTTL_F_2 : component is "O";

  component OBUFT_LVTTL_F_24
    port(
      O : out std_ulogic;
      
      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVTTL_F_24 : component is true;
attribute black_box_tri_pins of OBUFT_LVTTL_F_24 : component is "O";

  component OBUFT_LVTTL_F_4
    port(
      O : out std_ulogic;
      
      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVTTL_F_4 : component is true;
attribute black_box_tri_pins of OBUFT_LVTTL_F_4 : component is "O";

  component OBUFT_LVTTL_F_6
    port(
      O : out std_ulogic;
      
      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVTTL_F_6 : component is true;
attribute black_box_tri_pins of OBUFT_LVTTL_F_6 : component is "O";

  component OBUFT_LVTTL_F_8
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVTTL_F_8 : component is true;
attribute black_box_tri_pins of OBUFT_LVTTL_F_8 : component is "O";

  component OBUFT_LVTTL_S_12
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVTTL_S_12 : component is true;
attribute black_box_tri_pins of OBUFT_LVTTL_S_12 : component is "O";

  component OBUFT_LVTTL_S_16
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVTTL_S_16 : component is true;
attribute black_box_tri_pins of OBUFT_LVTTL_S_16 : component is "O";

  component OBUFT_LVTTL_S_2
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVTTL_S_2 : component is true;
attribute black_box_tri_pins of OBUFT_LVTTL_S_2 : component is "O";

  component OBUFT_LVTTL_S_24
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVTTL_S_24 : component is true;
attribute black_box_tri_pins of OBUFT_LVTTL_S_24 : component is "O";

  component OBUFT_LVTTL_S_4
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVTTL_S_4 : component is true;
attribute black_box_tri_pins of OBUFT_LVTTL_S_4 : component is "O";

  component OBUFT_LVTTL_S_6
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVTTL_S_6 : component is true;
attribute black_box_tri_pins of OBUFT_LVTTL_S_6 : component is "O";

  component OBUFT_LVTTL_S_8
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_LVTTL_S_8 : component is true;
attribute black_box_tri_pins of OBUFT_LVTTL_S_8 : component is "O";

  component OBUFT_PCI33_3
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_PCI33_3 : component is true;
attribute black_box_tri_pins of OBUFT_PCI33_3 : component is "O";

  component OBUFT_PCI33_5
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_PCI33_5 : component is true;
attribute black_box_tri_pins of OBUFT_PCI33_5 : component is "O";

  component OBUFT_PCI66_3
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_PCI66_3 : component is true;
attribute black_box_tri_pins of OBUFT_PCI66_3 : component is "O";

  component OBUFT_PCIX
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_PCIX : component is true;
attribute black_box_tri_pins of OBUFT_PCIX : component is "O";

  component OBUFT_PCIX66_3
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_PCIX66_3 : component is true;
attribute black_box_tri_pins of OBUFT_PCIX66_3 : component is "O";

  component OBUFT_S_12
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_S_12 : component is true;
attribute black_box_tri_pins of OBUFT_S_12 : component is "O";

  component OBUFT_S_16
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_S_16 : component is true;
attribute black_box_tri_pins of OBUFT_S_16 : component is "O";

  component OBUFT_S_2
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_S_2 : component is true;
attribute black_box_tri_pins of OBUFT_S_2 : component is "O";

  component OBUFT_S_24
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_S_24 : component is true;
attribute black_box_tri_pins of OBUFT_S_24 : component is "O";

  component OBUFT_S_4
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_S_4 : component is true;
attribute black_box_tri_pins of OBUFT_S_4 : component is "O";

  component OBUFT_S_6
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_S_6 : component is true;
attribute black_box_tri_pins of OBUFT_S_6 : component is "O";

  component OBUFT_S_8
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_S_8 : component is true;
attribute black_box_tri_pins of OBUFT_S_8 : component is "O";

  component OBUFT_SSTL18_I
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_SSTL18_I : component is true;
attribute black_box_tri_pins of OBUFT_SSTL18_I : component is "O";

  component OBUFT_SSTL18_I_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_SSTL18_I_DCI : component is true;
attribute black_box_tri_pins of OBUFT_SSTL18_I_DCI : component is "O";

  component OBUFT_SSTL18_II
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_SSTL18_II : component is true;
attribute black_box_tri_pins of OBUFT_SSTL18_II : component is "O";

  component OBUFT_SSTL18_II_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_SSTL18_II_DCI : component is true;
attribute black_box_tri_pins of OBUFT_SSTL18_II_DCI : component is "O";

  component OBUFT_SSTL2_I
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_SSTL2_I : component is true;
attribute black_box_tri_pins of OBUFT_SSTL2_I : component is "O";

  component OBUFT_SSTL2_I_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_SSTL2_I_DCI : component is true;
attribute black_box_tri_pins of OBUFT_SSTL2_I_DCI : component is "O";

  component OBUFT_SSTL2_II
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_SSTL2_II : component is true;
attribute black_box_tri_pins of OBUFT_SSTL2_II : component is "O";

  component OBUFT_SSTL2_II_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_SSTL2_II_DCI : component is true;
attribute black_box_tri_pins of OBUFT_SSTL2_II_DCI : component is "O";

  component OBUFT_SSTL3_I
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_SSTL3_I : component is true;
attribute black_box_tri_pins of OBUFT_SSTL3_I : component is "O";

  component OBUFT_SSTL3_I_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_SSTL3_I_DCI : component is true;
attribute black_box_tri_pins of OBUFT_SSTL3_I_DCI : component is "O";

  component OBUFT_SSTL3_II
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_SSTL3_II : component is true;
attribute black_box_tri_pins of OBUFT_SSTL3_II : component is "O";

  component OBUFT_SSTL3_II_DCI
    port(
      O : out std_ulogic;

      I : in  std_ulogic;
      T : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFT_SSTL3_II_DCI : component is true;
attribute black_box_tri_pins of OBUFT_SSTL3_II_DCI : component is "O";

  component OBUFTDS
    generic(
      CAPACITANCE : string     := "DONT_CARE";
 	DRIVE : integer	:= 12;
      IOSTANDARD  : string     := "DEFAULT"
      );
  
    port(
      O  : out std_ulogic;
      OB : out std_ulogic;
      I  : in  std_ulogic;
      T  : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFTDS : component is true;
attribute black_box_tri_pins of OBUFTDS : component is "O,OB";

  component OBUFTDS_BLVDS_25
    port(
      O  : out std_ulogic;
      OB : out std_ulogic;
      
      I  : in  std_ulogic;
      T  : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFTDS_BLVDS_25 : component is true;
attribute black_box_tri_pins of OBUFTDS_BLVDS_25 : component is "O,OB";

  component OBUFTDS_LDT_25
    port(
      O  : out std_ulogic;
      OB : out std_ulogic;

      I  : in  std_ulogic;
      T  : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFTDS_LDT_25 : component is true;
attribute black_box_tri_pins of OBUFTDS_LDT_25 : component is "O,OB";

  component OBUFTDS_LVDS_25
    port(
      O  : out std_ulogic;
      OB : out std_ulogic;

      I  : in  std_ulogic;
      T  : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFTDS_LVDS_25 : component is true;
attribute black_box_tri_pins of OBUFTDS_LVDS_25 : component is "O,OB";

  component OBUFTDS_LVDS_33
    port(
      O  : out std_ulogic;
      OB : out std_ulogic;

      I  : in  std_ulogic;
      T  : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFTDS_LVDS_33 : component is true;
attribute black_box_tri_pins of OBUFTDS_LVDS_33 : component is "O,OB";

  component OBUFTDS_LVDSEXT_25
    port(
      O  : out std_ulogic;
      OB : out std_ulogic;
      
      I  : in  std_ulogic;
      T  : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFTDS_LVDSEXT_25 : component is true;
attribute black_box_tri_pins of OBUFTDS_LVDSEXT_25 : component is "O,OB";

  component OBUFTDS_LVDSEXT_33
    port(
      O  : out std_ulogic;
      OB : out std_ulogic;

      I  : in  std_ulogic;
      T  : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFTDS_LVDSEXT_33 : component is true;
attribute black_box_tri_pins of OBUFTDS_LVDSEXT_33 : component is "O,OB";

  component OBUFTDS_LVPECL_25
    port(
      O  : out std_ulogic;
      OB : out std_ulogic;

      I  : in  std_ulogic;
      T  : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFTDS_LVPECL_25 : component is true;
attribute black_box_tri_pins of OBUFTDS_LVPECL_25 : component is "O,OB";

  component OBUFTDS_LVPECL_33
    port(
      O  : out std_ulogic;
      OB : out std_ulogic;

      I  : in  std_ulogic;
      T  : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFTDS_LVPECL_33 : component is true;
attribute black_box_tri_pins of OBUFTDS_LVPECL_33 : component is "O,OB";

  component OBUFTDS_ULVDS_25
    port(
      O  : out std_ulogic;
      OB : out std_ulogic;

      I  : in  std_ulogic;
      T  : in  std_ulogic
      );
  end component;
attribute syn_black_box of OBUFTDS_ULVDS_25 : component is true;
attribute black_box_tri_pins of OBUFTDS_ULVDS_25 : component is "O,OB";

  component ODDR
  generic(
      DDR_CLK_EDGE : string := "OPPOSITE_EDGE";
      INIT         : bit    := '0';
      SRTYPE       : string := "SYNC"
      );
  port(
      Q           : out std_ulogic;

      C           : in  std_ulogic;
      CE          : in  std_ulogic;
      D1          : in  std_ulogic;
      D2          : in  std_ulogic;
      R           : in  std_ulogic;
      S           : in  std_ulogic
    );
  end component;
attribute syn_black_box of ODDR : component is true;

  component ODDR2
  generic(
      DDR_ALIGNMENT : string := "NONE";
      INIT          : bit    := '0';
      SRTYPE        : string := "SYNC"
      );
  port(
      Q           : out std_ulogic;

      C0          : in  std_ulogic;
      C1          : in  std_ulogic;
      CE          : in  std_ulogic;
      D0          : in  std_ulogic;
      D1          : in  std_ulogic;
      R           : in  std_ulogic;
      S           : in  std_ulogic
    );
  end component;
attribute syn_black_box of ODDR2 : component is true;

  component OFDDRCPE
    port(
      Q   : out std_ulogic;

      C0  : in  std_ulogic;
      C1  : in  std_ulogic;
      CE  : in  std_ulogic;
      CLR : in  std_ulogic;
      D0  : in  std_ulogic;
      D1  : in  std_ulogic;
      PRE : in  std_ulogic
      );
  end component;
attribute syn_black_box of OFDDRCPE : component is true;

  component OFDDRRSE
    port(
      Q  : out std_ulogic;

      C0 : in  std_ulogic;
      C1 : in  std_ulogic;
      CE : in  std_ulogic;
      D0 : in  std_ulogic;
      D1 : in  std_ulogic;
      R  : in  std_ulogic;
      S  : in  std_ulogic
      );
  end component;
attribute syn_black_box of OFDDRRSE : component is true;

  component OFDDRTCPE
    port(
      O   : out std_ulogic;
      
      C0  : in  std_ulogic;
      C1  : in  std_ulogic;
      CE  : in  std_ulogic;
      CLR : in  std_ulogic;
      D0  : in  std_ulogic;
      D1  : in  std_ulogic;
      PRE : in  std_ulogic;
      T   : in  std_ulogic
      );
  end component;
attribute syn_black_box of OFDDRTCPE : component is true;

  component OFDDRTRSE
    port(
      O  : out std_ulogic;

      C0 : in  std_ulogic;
      C1 : in  std_ulogic;
      CE : in  std_ulogic;
      D0 : in  std_ulogic;
      D1 : in  std_ulogic;
      R  : in  std_ulogic;
      S  : in  std_ulogic;
      T  : in  std_ulogic
      );
  end component;
attribute syn_black_box of OFDDRTRSE : component is true;

  component OPT_OFF
    port(
      I : in std_ulogic
      );
  end component;
attribute syn_black_box of OPT_OFF : component is true;

  component OPT_UIM
    port(
      I : in std_ulogic
      );
  end component;
attribute syn_black_box of OPT_UIM : component is true;

  component OR2
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic
      );
  end component;
attribute syn_black_box of OR2 : component is true;

  component OR2B1
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic
      );
  end component;
attribute syn_black_box of OR2B1 : component is true;

  component OR2B2
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic
      );
  end component;
attribute syn_black_box of OR2B2 : component is true;

  component OR3
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic
      );
  end component;
attribute syn_black_box of OR3 : component is true;

  component OR3B1
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic
      );
  end component;
attribute syn_black_box of OR3B1 : component is true;

  component OR3B2
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic
      );
  end component;
attribute syn_black_box of OR3B2 : component is true;

  component OR3B3
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic
      );
  end component;
attribute syn_black_box of OR3B3 : component is true;

  component OR4
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic
      );
  end component;
attribute syn_black_box of OR4 : component is true;

  component OR4B1
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic
      );
  end component;
attribute syn_black_box of OR4B1 : component is true;

  component OR4B2
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic
      );
  end component;
attribute syn_black_box of OR4B2 : component is true;

  component OR4B3
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic
      );
  end component;
attribute syn_black_box of OR4B3 : component is true;

  component OR4B4
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic
      );
  end component;
attribute syn_black_box of OR4B4 : component is true;

  component OR5
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic;
      I4 : in  std_ulogic
      );
  end component;
attribute syn_black_box of OR5 : component is true;

  component OR5B1
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic;
      I4 : in  std_ulogic
      );
  end component;
attribute syn_black_box of OR5B1 : component is true;

  component OR5B2
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic;
      I4 : in  std_ulogic
      );
  end component;
attribute syn_black_box of OR5B2 : component is true;

  component OR5B3
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic;
      I4 : in  std_ulogic
      );
  end component;
attribute syn_black_box of OR5B3 : component is true;

  component OR5B4
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic;
      I4 : in  std_ulogic
      );
  end component;
attribute syn_black_box of OR5B4 : component is true;

  component OR5B5
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic;
      I4 : in  std_ulogic
      );
  end component;
attribute syn_black_box of OR5B5 : component is true;

  component OR6
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic;
      I4 : in  std_ulogic;
      I5 : in  std_ulogic
      );
  end component;
attribute syn_black_box of OR6 : component is true;

  component OR7
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic;
      I4 : in  std_ulogic;
      I5 : in  std_ulogic;
      I6 : in  std_ulogic
      );
  end component;
attribute syn_black_box of OR7 : component is true;

  component OR8
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic;
      I4 : in  std_ulogic;
      I5 : in  std_ulogic;
      I6 : in  std_ulogic;
      I7 : in  std_ulogic
      );
  end component;
attribute syn_black_box of OR8 : component is true;

  component ORCY
    port(
      O  : out std_ulogic;
      
      CI : in  std_ulogic;
      I  : in  std_ulogic
      );
  end component;
attribute syn_black_box of ORCY : component is true;

  component OSERDES
  generic(
      DATA_RATE_OQ	: string	:= "DDR";
      DATA_RATE_TQ	: string	:= "DDR";
      DATA_WIDTH	: integer	:= 4;
      INIT_OQ		: bit		:= '0';
      INIT_TQ		: bit		:= '0';
      SERDES_MODE	: string	:= "MASTER";
      SRVAL_OQ		: bit		:= '0';
      SRVAL_TQ		: bit		:= '0';
      TRISTATE_WIDTH	: integer	:= 4
      );

  port(
      OQ		: out std_ulogic;
      SHIFTOUT1		: out std_ulogic;
      SHIFTOUT2		: out std_ulogic;
      TQ		: out std_ulogic;

      CLK		: in std_ulogic;
      CLKDIV		: in std_ulogic;
      D1		: in std_ulogic;
      D2		: in std_ulogic;
      D3		: in std_ulogic;
      D4		: in std_ulogic;
      D5		: in std_ulogic;
      D6		: in std_ulogic;
      OCE		: in std_ulogic;
      REV	        : in std_ulogic;
      SHIFTIN1		: in std_ulogic;
      SHIFTIN2		: in std_ulogic;
      SR	        : in std_ulogic;
      T1		: in std_ulogic;
      T2		: in std_ulogic;
      T3		: in std_ulogic;
      T4		: in std_ulogic;
      TCE		: in std_ulogic
      );
  end component;
attribute syn_black_box of OSERDES : component is true;

  component PIPEBUF
   port (
     O : out std_logic;
     I : in std_logic
   );
  end component;
attribute syn_black_box of PIPEBUF : component is true;

  component PMCD
  generic(
      EN_REL           : boolean := FALSE;
      RST_DEASSERT_CLK : string  := "CLKA"
      );
  port(
      CLKA1   : out std_ulogic;
      CLKA1D2 : out std_ulogic;
      CLKA1D4 : out std_ulogic;
      CLKA1D8 : out std_ulogic;
      CLKB1   : out std_ulogic;
      CLKC1   : out std_ulogic;
      CLKD1   : out std_ulogic;

      CLKA    : in  std_ulogic;
      CLKB    : in  std_ulogic;
      CLKC    : in  std_ulogic;
      CLKD    : in  std_ulogic;
      REL     : in  std_ulogic;
      RST     : in  std_ulogic
      );
  end component;
attribute syn_black_box of PMCD : component is true;

component PPC405_ADV
port (
		APUFCMDECODED : out std_ulogic;
		APUFCMDECUDI : out std_logic_vector(0 to 2);
		APUFCMDECUDIVALID : out std_ulogic;
		APUFCMENDIAN : out std_ulogic;
		APUFCMFLUSH : out std_ulogic;
		APUFCMINSTRUCTION : out std_logic_vector(0 to 31);
		APUFCMINSTRVALID : out std_ulogic;
		APUFCMLOADBYTEEN : out std_logic_vector(0 to 3);
		APUFCMLOADDATA : out std_logic_vector(0 to 31);
		APUFCMLOADDVALID : out std_ulogic;
		APUFCMOPERANDVALID : out std_ulogic;
		APUFCMRADATA : out std_logic_vector(0 to 31);
		APUFCMRBDATA : out std_logic_vector(0 to 31);
		APUFCMWRITEBACKOK : out std_ulogic;
		APUFCMXERCA : out std_ulogic;
		C405CPMCORESLEEPREQ : out std_ulogic;
		C405CPMMSRCE : out std_ulogic;
		C405CPMMSREE : out std_ulogic;
		C405CPMTIMERIRQ : out std_ulogic;
		C405CPMTIMERRESETREQ : out std_ulogic;
		C405DBGLOADDATAONAPUDBUS : out std_ulogic;
		C405DBGMSRWE : out std_ulogic;
		C405DBGSTOPACK : out std_ulogic;
		C405DBGWBCOMPLETE : out std_ulogic;
		C405DBGWBFULL : out std_ulogic;
		C405DBGWBIAR : out std_logic_vector(0 to 29);
		C405JTGCAPTUREDR : out std_ulogic;
		C405JTGEXTEST : out std_ulogic;
		C405JTGPGMOUT : out std_ulogic;
		C405JTGSHIFTDR : out std_ulogic;
		C405JTGTDO : out std_ulogic;
		C405JTGTDOEN : out std_ulogic;
		C405JTGUPDATEDR : out std_ulogic;
		C405PLBDCUABORT : out std_ulogic;
		C405PLBDCUABUS : out std_logic_vector(0 to 31);
		C405PLBDCUBE : out std_logic_vector(0 to 7);
		C405PLBDCUCACHEABLE : out std_ulogic;
		C405PLBDCUGUARDED : out std_ulogic;
		C405PLBDCUPRIORITY : out std_logic_vector(0 to 1);
		C405PLBDCUREQUEST : out std_ulogic;
		C405PLBDCURNW : out std_ulogic;
		C405PLBDCUSIZE2 : out std_ulogic;
		C405PLBDCUU0ATTR : out std_ulogic;
		C405PLBDCUWRDBUS : out std_logic_vector(0 to 63);
		C405PLBDCUWRITETHRU : out std_ulogic;
		C405PLBICUABORT : out std_ulogic;
		C405PLBICUABUS : out std_logic_vector(0 to 29);
		C405PLBICUCACHEABLE : out std_ulogic;
		C405PLBICUPRIORITY : out std_logic_vector(0 to 1);
		C405PLBICUREQUEST : out std_ulogic;
		C405PLBICUSIZE : out std_logic_vector(2 to 3);
		C405PLBICUU0ATTR : out std_ulogic;
		C405RSTCHIPRESETREQ : out std_ulogic;
		C405RSTCORERESETREQ : out std_ulogic;
		C405RSTSYSRESETREQ : out std_ulogic;
		C405TRCCYCLE : out std_ulogic;
		C405TRCEVENEXECUTIONSTATUS : out std_logic_vector(0 to 1);
		C405TRCODDEXECUTIONSTATUS : out std_logic_vector(0 to 1);
		C405TRCTRACESTATUS : out std_logic_vector(0 to 3);
		C405TRCTRIGGEREVENTOUT : out std_ulogic;
		C405TRCTRIGGEREVENTTYPE : out std_logic_vector(0 to 10);
		C405XXXMACHINECHECK : out std_ulogic;
		DCREMACABUS : out std_logic_vector(8 to 9);
		DCREMACCLK : out std_ulogic;
		DCREMACDBUS : out std_logic_vector(0 to 31);
		DCREMACENABLER : out std_ulogic;
		DCREMACREAD : out std_ulogic;
		DCREMACWRITE : out std_ulogic;
		DSOCMBRAMABUS : out std_logic_vector(8 to 29);
		DSOCMBRAMBYTEWRITE : out std_logic_vector(0 to 3);
		DSOCMBRAMEN : out std_ulogic;
		DSOCMBRAMWRDBUS : out std_logic_vector(0 to 31);
		DSOCMBUSY : out std_ulogic;
		DSOCMRDADDRVALID : out std_ulogic;
		DSOCMWRADDRVALID : out std_ulogic;
		EXTDCRABUS : out std_logic_vector(0 to 9);
		EXTDCRDBUSOUT : out std_logic_vector(0 to 31);
		EXTDCRREAD : out std_ulogic;
		EXTDCRWRITE : out std_ulogic;
		ISOCMBRAMEN : out std_ulogic;
		ISOCMBRAMEVENWRITEEN : out std_ulogic;
		ISOCMBRAMODDWRITEEN : out std_ulogic;
		ISOCMBRAMRDABUS : out std_logic_vector(8 to 28);
		ISOCMBRAMWRABUS : out std_logic_vector(8 to 28);
		ISOCMBRAMWRDBUS : out std_logic_vector(0 to 31);
		ISOCMDCRBRAMEVENEN : out std_ulogic;
		ISOCMDCRBRAMODDEN : out std_ulogic;
		ISOCMDCRBRAMRDSELECT : out std_ulogic;

		BRAMDSOCMCLK : in std_ulogic;
		BRAMDSOCMRDDBUS : in std_logic_vector(0 to 31);
		BRAMISOCMCLK : in std_ulogic;
		BRAMISOCMDCRRDDBUS : in std_logic_vector(0 to 31);
		BRAMISOCMRDDBUS : in std_logic_vector(0 to 63);
		CPMC405CLOCK : in std_ulogic;
		CPMC405CORECLKINACTIVE : in std_ulogic;
		CPMC405CPUCLKEN : in std_ulogic;
		CPMC405JTAGCLKEN : in std_ulogic;
		CPMC405SYNCBYPASS : in std_ulogic;
		CPMC405TIMERCLKEN : in std_ulogic;
		CPMC405TIMERTICK : in std_ulogic;
		CPMDCRCLK : in std_ulogic;
		CPMFCMCLK : in std_ulogic;
		DBGC405DEBUGHALT : in std_ulogic;
		DBGC405EXTBUSHOLDACK : in std_ulogic;
		DBGC405UNCONDDEBUGEVENT : in std_ulogic;
		DSARCVALUE : in std_logic_vector(0 to 7);
		DSCNTLVALUE : in std_logic_vector(0 to 7);
		DSOCMRWCOMPLETE : in std_ulogic;
		EICC405CRITINPUTIRQ : in std_ulogic;
		EICC405EXTINPUTIRQ : in std_ulogic;
		EMACDCRACK : in std_ulogic;
		EMACDCRDBUS : in std_logic_vector(0 to 31);
		EXTDCRACK : in std_ulogic;
		EXTDCRDBUSIN : in std_logic_vector(0 to 31);
		FCMAPUCR : in std_logic_vector(0 to 3);
		FCMAPUDCDCREN : in std_ulogic;
		FCMAPUDCDFORCEALIGN : in std_ulogic;
		FCMAPUDCDFORCEBESTEERING : in std_ulogic;
		FCMAPUDCDFPUOP : in std_ulogic;
		FCMAPUDCDGPRWRITE : in std_ulogic;
		FCMAPUDCDLDSTBYTE : in std_ulogic;
		FCMAPUDCDLDSTDW : in std_ulogic;
		FCMAPUDCDLDSTHW : in std_ulogic;
		FCMAPUDCDLDSTQW : in std_ulogic;
		FCMAPUDCDLDSTWD : in std_ulogic;
		FCMAPUDCDLOAD : in std_ulogic;
		FCMAPUDCDPRIVOP : in std_ulogic;
		FCMAPUDCDRAEN : in std_ulogic;
		FCMAPUDCDRBEN : in std_ulogic;
		FCMAPUDCDSTORE : in std_ulogic;
		FCMAPUDCDTRAPBE : in std_ulogic;
		FCMAPUDCDTRAPLE : in std_ulogic;
		FCMAPUDCDUPDATE : in std_ulogic;
		FCMAPUDCDXERCAEN : in std_ulogic;
		FCMAPUDCDXEROVEN : in std_ulogic;
		FCMAPUDECODEBUSY : in std_ulogic;
		FCMAPUDONE : in std_ulogic;
		FCMAPUEXCEPTION : in std_ulogic;
		FCMAPUEXEBLOCKINGMCO : in std_ulogic;
		FCMAPUEXECRFIELD : in std_logic_vector(0 to 2);
		FCMAPUEXENONBLOCKINGMCO : in std_ulogic;
		FCMAPUINSTRACK : in std_ulogic;
		FCMAPULOADWAIT : in std_ulogic;
		FCMAPURESULT : in std_logic_vector(0 to 31);
		FCMAPURESULTVALID : in std_ulogic;
		FCMAPUSLEEPNOTREADY : in std_ulogic;
		FCMAPUXERCA : in std_ulogic;
		FCMAPUXEROV : in std_ulogic;
		ISARCVALUE : in std_logic_vector(0 to 7);
		ISCNTLVALUE : in std_logic_vector(0 to 7);
		JTGC405BNDSCANTDO : in std_ulogic;
		JTGC405TCK : in std_ulogic;
		JTGC405TDI : in std_ulogic;
		JTGC405TMS : in std_ulogic;
		JTGC405TRSTNEG : in std_ulogic;
		MCBCPUCLKEN : in std_ulogic;
		MCBJTAGEN : in std_ulogic;
		MCBTIMEREN : in std_ulogic;
		MCPPCRST : in std_ulogic;
		PLBC405DCUADDRACK : in std_ulogic;
		PLBC405DCUBUSY : in std_ulogic;
		PLBC405DCUERR : in std_ulogic;
		PLBC405DCURDDACK : in std_ulogic;
		PLBC405DCURDDBUS : in std_logic_vector(0 to 63);
		PLBC405DCURDWDADDR : in std_logic_vector(1 to 3);
		PLBC405DCUSSIZE1 : in std_ulogic;
		PLBC405DCUWRDACK : in std_ulogic;
		PLBC405ICUADDRACK : in std_ulogic;
		PLBC405ICUBUSY : in std_ulogic;
		PLBC405ICUERR : in std_ulogic;
		PLBC405ICURDDACK : in std_ulogic;
		PLBC405ICURDDBUS : in std_logic_vector(0 to 63);
		PLBC405ICURDWDADDR : in std_logic_vector(1 to 3);
		PLBC405ICUSSIZE1 : in std_ulogic;
		PLBCLK : in std_ulogic;
		RSTC405RESETCHIP : in std_ulogic;
		RSTC405RESETCORE : in std_ulogic;
		RSTC405RESETSYS : in std_ulogic;
		TIEAPUCONTROL : in std_logic_vector(0 to 15);
		TIEAPUUDI1 : in std_logic_vector(0 to 23);
		TIEAPUUDI2 : in std_logic_vector(0 to 23);
		TIEAPUUDI3 : in std_logic_vector(0 to 23);
		TIEAPUUDI4 : in std_logic_vector(0 to 23);
		TIEAPUUDI5 : in std_logic_vector(0 to 23);
		TIEAPUUDI6 : in std_logic_vector(0 to 23);
		TIEAPUUDI7 : in std_logic_vector(0 to 23);
		TIEAPUUDI8 : in std_logic_vector(0 to 23);
		TIEC405DETERMINISTICMULT : in std_ulogic;
		TIEC405DISOPERANDFWD : in std_ulogic;
		TIEC405MMUEN : in std_ulogic;
		TIEDCRADDR : in std_logic_vector(0 to 5);
		TIEPVRBIT10 : in std_ulogic;
		TIEPVRBIT11 : in std_ulogic;
		TIEPVRBIT28 : in std_ulogic;
		TIEPVRBIT29 : in std_ulogic;
		TIEPVRBIT30 : in std_ulogic;
		TIEPVRBIT31 : in std_ulogic;
		TIEPVRBIT8 : in std_ulogic;
		TIEPVRBIT9 : in std_ulogic;
		TRCC405TRACEDISABLE : in std_ulogic;
		TRCC405TRIGGEREVENTIN : in std_ulogic
     );
end component;
attribute syn_black_box of PPC405_ADV : component is true;

  component PULLDOWN
    port(
      O : out std_ulogic := 'L'
      );
  end component;
attribute syn_black_box of PULLDOWN : component is true;
attribute syn_noprune of PULLDOWN : component is true;

  component PULLUP
    port(
      O : out std_ulogic := 'H'
      );
  end component;
attribute syn_black_box of PULLUP : component is true;
attribute syn_noprune of PULLUP : component is true;

  component RAM128X1S
    generic (
      INIT : bit_vector := X"00000000000000000000000000000000"
      );
  
    port (
      O    : out std_ulogic;
  
      A0   : in  std_ulogic;
      A1   : in  std_ulogic;
      A2   : in  std_ulogic;
      A3   : in  std_ulogic;
      A4   : in  std_ulogic;
      A5   : in  std_ulogic;
      A6   : in  std_ulogic;
      D    : in  std_ulogic;
      WCLK : in  std_ulogic;
      WE   : in  std_ulogic
      );
  end component;
attribute syn_black_box of RAM128X1S : component is true;

  component RAM128X1S_1
    generic(
      INIT : bit_vector := X"00000000000000000000000000000000"
      );
  
    port(
      O    : out std_ulogic;

      A0   : in  std_ulogic;
      A1   : in  std_ulogic;
      A2   : in  std_ulogic;
      A3   : in  std_ulogic;
      A4   : in  std_ulogic;
      A5   : in  std_ulogic;
      A6   : in  std_ulogic;
      D    : in  std_ulogic;
      WCLK : in  std_ulogic;
      WE   : in  std_ulogic
      );
  end component;
attribute syn_black_box of RAM128X1S_1 : component is true;

  component RAM16X1D
    generic (
      INIT : bit_vector := X"0000"
      );
  
    port (
      DPO   : out std_ulogic;
      SPO   : out std_ulogic;
      
      A0    : in  std_ulogic;
      A1    : in  std_ulogic;
      A2    : in  std_ulogic;
      A3    : in  std_ulogic;
      D     : in  std_ulogic;
      DPRA0 : in  std_ulogic;
      DPRA1 : in  std_ulogic;
      DPRA2 : in  std_ulogic;
      DPRA3 : in  std_ulogic;
      WCLK  : in  std_ulogic;
      WE    : in  std_ulogic
      );
  end component;
attribute syn_black_box of RAM16X1D : component is true;

  component RAM16X1D_1
    generic (
      INIT : bit_vector := X"0000"
      );
  
    port (
      DPO   : out std_ulogic;
      SPO   : out std_ulogic;
      
      A0    : in  std_ulogic;
      A1    : in  std_ulogic;
      A2    : in  std_ulogic;
      A3    : in  std_ulogic;
      D     : in  std_ulogic;
      DPRA0 : in  std_ulogic;
      DPRA1 : in  std_ulogic;
      DPRA2 : in  std_ulogic;
      DPRA3 : in  std_ulogic;
      WCLK  : in  std_ulogic;
      WE    : in  std_ulogic
      );
  end component;
attribute syn_black_box of RAM16X1D_1 : component is true;

  component RAM16X1S
    generic (
      INIT : bit_vector := X"0000"
      );
  
    port (
      O    : out std_ulogic;
      
      A0   : in  std_ulogic;
      A1   : in  std_ulogic;
      A2   : in  std_ulogic;
      A3   : in  std_ulogic;
      D    : in  std_ulogic;
      WCLK : in  std_ulogic;
      WE   : in  std_ulogic
      );
  end component;
attribute syn_black_box of RAM16X1S : component is true;

  component RAM16X1S_1
    generic (
      INIT : bit_vector := X"0000"
      );
  
    port (
      O    : out std_ulogic;

      A0   : in  std_ulogic;
      A1   : in  std_ulogic;
      A2   : in  std_ulogic;
      A3   : in  std_ulogic;
      D    : in  std_ulogic;
      WCLK : in  std_ulogic;
      WE   : in  std_ulogic
      );
  end component;
attribute syn_black_box of RAM16X1S_1 : component is true;

  component RAM16X2S
    generic (
      INIT_00 : bit_vector(15 downto 0) := X"0000";
      INIT_01 : bit_vector(15 downto 0) := X"0000"
      );

    port (
      O0   : out std_ulogic;
      O1   : out std_ulogic;
      
      A0   : in  std_ulogic;
      A1   : in  std_ulogic;
      A2   : in  std_ulogic;
      A3   : in  std_ulogic;
      D0   : in  std_ulogic;
      D1   : in  std_ulogic;
      WCLK : in  std_ulogic;
      WE   : in  std_ulogic
      );
  end component;
attribute syn_black_box of RAM16X2S : component is true;

  component RAM16X4S
    generic (
      INIT_00 : bit_vector(15 downto 0) := X"0000";
      INIT_01 : bit_vector(15 downto 0) := X"0000";
      INIT_02 : bit_vector(15 downto 0) := X"0000";
      INIT_03 : bit_vector(15 downto 0) := X"0000"
      );
    port (
      O0   : out std_ulogic;
      O1   : out std_ulogic;
      O2   : out std_ulogic;
      O3   : out std_ulogic;
      
      A0   : in  std_ulogic;
      A1   : in  std_ulogic;
      A2   : in  std_ulogic;
      A3   : in  std_ulogic;
      D0   : in  std_ulogic;
      D1   : in  std_ulogic;
      D2   : in  std_ulogic;
      D3   : in  std_ulogic;
      WCLK : in  std_ulogic;
      WE   : in  std_ulogic
      );
  end component;
attribute syn_black_box of RAM16X4S : component is true;

  component RAM16X8S
    generic (
      INIT_00 : bit_vector(15 downto 0) := X"0000";
      INIT_01 : bit_vector(15 downto 0) := X"0000";
      INIT_02 : bit_vector(15 downto 0) := X"0000";
      INIT_03 : bit_vector(15 downto 0) := X"0000";
      INIT_04 : bit_vector(15 downto 0) := X"0000";
      INIT_05 : bit_vector(15 downto 0) := X"0000";
      INIT_06 : bit_vector(15 downto 0) := X"0000";
      INIT_07 : bit_vector(15 downto 0) := X"0000"
      );
    port (
      O    : out std_logic_vector ( 7 downto 0);
      
      A0   : in  std_ulogic;
      A1   : in  std_ulogic;
      A2   : in  std_ulogic;
      A3   : in  std_ulogic;
      D    : in  std_logic_vector ( 7 downto 0);
      WCLK : in  std_ulogic;
      WE   : in  std_ulogic
      );
  end component;
attribute syn_black_box of RAM16X8S : component is true;

component RAM32X1D
  generic (
       INIT : bit_vector := X"00000000"
       );

  port (
        DPO   : out std_ulogic;
        SPO   : out std_ulogic;

        A0    : in  std_ulogic;
        A1    : in  std_ulogic;
        A2    : in  std_ulogic;
        A3    : in  std_ulogic;
        A4    : in  std_ulogic;
        D     : in  std_ulogic;
        DPRA0 : in  std_ulogic;
        DPRA1 : in  std_ulogic;
        DPRA2 : in  std_ulogic;
        DPRA3 : in  std_ulogic;
        DPRA4 : in  std_ulogic;
        WCLK  : in  std_ulogic;
        WE    : in  std_ulogic
        );
end component;
attribute syn_black_box of RAM32X1D : component is true;

  component RAM32X1D_1
    generic (
      INIT : bit_vector := X"00000000"
      );
  
    port (
      DPO   : out std_ulogic;
      SPO   : out std_ulogic;
  
      A0    : in  std_ulogic;
      A1    : in  std_ulogic;
      A2    : in  std_ulogic;
      A3    : in  std_ulogic;
      A4    : in  std_ulogic;
      D     : in  std_ulogic;
      DPRA0 : in  std_ulogic;
      DPRA1 : in  std_ulogic;
      DPRA2 : in  std_ulogic;
      DPRA3 : in  std_ulogic;
      DPRA4 : in  std_ulogic;
      WCLK  : in  std_ulogic;
      WE    : in  std_ulogic
      );
  end component;
attribute syn_black_box of RAM32X1D_1 : component is true;

  component RAM32X1S
    generic (
      INIT : bit_vector := X"00000000"
      );
  
    port (
      O    : out std_ulogic;
      
      A0   : in  std_ulogic;
      A1   : in  std_ulogic;
      A2   : in  std_ulogic;
      A3   : in  std_ulogic;
      A4   : in  std_ulogic;
      D    : in  std_ulogic;
      WCLK : in  std_ulogic;
      WE   : in  std_ulogic
      );
  end component;
attribute syn_black_box of RAM32X1S : component is true;

  component RAM32X1S_1
    generic (
      INIT : bit_vector := X"00000000"
      );
  
    port (
      O    : out std_ulogic;
      
      A0   : in  std_ulogic;
      A1   : in  std_ulogic;
      A2   : in  std_ulogic;
      A3   : in  std_ulogic;
      A4   : in  std_ulogic;
      D    : in  std_ulogic;
      WCLK : in  std_ulogic;
      WE   : in  std_ulogic
      );
  end component;
attribute syn_black_box of RAM32X1S_1 : component is true;

  component RAM32X2S
    generic (
      INIT_00 : bit_vector(31 downto 0) := X"00000000";
      INIT_01 : bit_vector(31 downto 0) := X"00000000"
      );
    port (
      O0   : out std_ulogic;
      O1   : out std_ulogic;
      
      A0   : in  std_ulogic;
      A1   : in  std_ulogic;
      A2   : in  std_ulogic;
      A3   : in  std_ulogic;
      A4   : in  std_ulogic;
      D0   : in  std_ulogic;
      D1   : in  std_ulogic;
      WCLK : in  std_ulogic;
      WE   : in  std_ulogic
      );
  end component;
attribute syn_black_box of RAM32X2S : component is true;

  component RAM32X4S
    generic (
      INIT_00 : bit_vector(31 downto 0) := X"00000000";
      INIT_01 : bit_vector(31 downto 0) := X"00000000";
      INIT_02 : bit_vector(31 downto 0) := X"00000000";
      INIT_03 : bit_vector(31 downto 0) := X"00000000"
      );
    port (
      O0   : out std_ulogic;
      O1   : out std_ulogic;
      O2   : out std_ulogic;
      O3   : out std_ulogic;
      
      A0   : in  std_ulogic;
      A1   : in  std_ulogic;
      A2   : in  std_ulogic;
      A3   : in  std_ulogic;
      A4   : in  std_ulogic;
      D0   : in  std_ulogic;
      D1   : in  std_ulogic;
      D2   : in  std_ulogic;
      D3   : in  std_ulogic;
      WCLK : in  std_ulogic;
      WE   : in  std_ulogic
      );
  end component;
attribute syn_black_box of RAM32X4S : component is true;

  component RAM32X8S
    generic (
      INIT_00 : bit_vector(31 downto 0) := X"00000000";
      INIT_01 : bit_vector(31 downto 0) := X"00000000";
      INIT_02 : bit_vector(31 downto 0) := X"00000000";
      INIT_03 : bit_vector(31 downto 0) := X"00000000";
      INIT_04 : bit_vector(31 downto 0) := X"00000000";
      INIT_05 : bit_vector(31 downto 0) := X"00000000";
      INIT_06 : bit_vector(31 downto 0) := X"00000000";
      INIT_07 : bit_vector(31 downto 0) := X"00000000"
      );
    port (
      O    : out std_logic_vector ( 7 downto 0);
  
      A0   : in  std_ulogic;
      A1   : in  std_ulogic;
      A2   : in  std_ulogic;
      A3   : in  std_ulogic;
      A4   : in  std_ulogic;
      D    : in  std_logic_vector ( 7 downto 0);
      WCLK : in  std_ulogic;
      WE   : in  std_ulogic
      );
  end component;
attribute syn_black_box of RAM32X8S : component is true;

  component RAM64X1D
    generic (
      INIT : bit_vector := X"0000000000000000"
      );
  
    port (
      DPO : out std_ulogic;
      SPO : out std_ulogic;
  
      A0    : in std_ulogic;
      A1    : in std_ulogic;
      A2    : in std_ulogic;
      A3    : in std_ulogic;
      A4    : in std_ulogic;
      A5    : in std_ulogic;
      D     : in std_ulogic;
      DPRA0 : in std_ulogic;
      DPRA1 : in std_ulogic;
      DPRA2 : in std_ulogic;
      DPRA3 : in std_ulogic;
      DPRA4 : in std_ulogic;
      DPRA5 : in std_ulogic;
      WCLK  : in std_ulogic;
      WE    : in std_ulogic
      );
  end component;
attribute syn_black_box of RAM64X1D : component is true;

  component RAM64X1D_1
    generic (
      INIT : bit_vector := X"0000000000000000"
      );
  
    port (
      DPO   : out std_ulogic;
      SPO   : out std_ulogic;

      A0    : in  std_ulogic;
      A1    : in  std_ulogic;
      A2    : in  std_ulogic;
      A3    : in  std_ulogic;
      A4    : in  std_ulogic;
      A5    : in  std_ulogic;
      D     : in  std_ulogic;
      DPRA0 : in  std_ulogic;
      DPRA1 : in  std_ulogic;
      DPRA2 : in  std_ulogic;
      DPRA3 : in  std_ulogic;
      DPRA4 : in  std_ulogic;
      DPRA5 : in  std_ulogic;
      WCLK  : in  std_ulogic;
      WE    : in  std_ulogic
      );
  end component;
attribute syn_black_box of RAM64X1D_1 : component is true;

  component RAM64X1S
    generic (
      INIT : bit_vector := X"0000000000000000"
      );
  
    port (
      O    : out std_ulogic;

      A0   : in  std_ulogic;
      A1   : in  std_ulogic;
      A2   : in  std_ulogic;
      A3   : in  std_ulogic;
      A4   : in  std_ulogic;
      A5   : in  std_ulogic;
      D    : in  std_ulogic;
      WCLK : in  std_ulogic;
      WE   : in  std_ulogic
      );
  end component;
attribute syn_black_box of RAM64X1S : component is true;

  component RAM64X1S_1
    generic (
      INIT : bit_vector := X"0000000000000000"
      );
  
    port (
      O    : out std_ulogic;

      A0   : in  std_ulogic;
      A1   : in  std_ulogic;
      A2   : in  std_ulogic;
      A3   : in  std_ulogic;
      A4   : in  std_ulogic;
      A5   : in  std_ulogic;
      D    : in  std_ulogic;
      WCLK : in  std_ulogic;
      WE   : in  std_ulogic
      );
  end component;
attribute syn_black_box of RAM64X1S_1 : component is true;

  component RAM64X2S
    generic (
      INIT_00 :     bit_vector(63 downto 0) := X"0000000000000000";
      INIT_01 :     bit_vector(63 downto 0) := X"0000000000000000"
      );
    port (
      O0     : out std_ulogic;
      O1     : out std_ulogic;

      A0     : in  std_ulogic;
      A1     : in  std_ulogic;
      A2     : in  std_ulogic;
      A3     : in  std_ulogic;
      A4     : in  std_ulogic;
      A5     : in  std_ulogic;
      D0     : in  std_ulogic;
      D1     : in  std_ulogic;
      WCLK   : in  std_ulogic;
      WE     : in  std_ulogic
      );
  
  end component;
attribute syn_black_box of RAM64X2S : component is true;

  component RAMB16
  generic (
    DOA_REG : integer := 0 ;
    DOB_REG : integer := 0 ;

    INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";

    INIT_A : bit_vector := X"000000000";
    INIT_B : bit_vector := X"000000000";

    INITP_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";

    INVERT_CLK_DOA_REG : boolean := false;
    INVERT_CLK_DOB_REG : boolean := false;

    RAM_EXTENSION_A : string := "NONE";
    RAM_EXTENSION_B : string := "NONE";

    READ_WIDTH_A : integer := 0;
    READ_WIDTH_B : integer := 0;

    SIM_COLLISION_CHECK : string := "ALL";

    SRVAL_A  : bit_vector := X"000000000";
    SRVAL_B  : bit_vector := X"000000000";

    WRITE_MODE_A : string := "WRITE_FIRST";
    WRITE_MODE_B : string := "WRITE_FIRST";

    WRITE_WIDTH_A : integer := 0;
    WRITE_WIDTH_B : integer := 0
    );

  port(
    CASCADEOUTA  : out  std_ulogic;
    CASCADEOUTB  : out  std_ulogic;
    DOA          : out std_logic_vector (31 downto 0);
    DOB          : out std_logic_vector (31 downto 0);
    DOPA         : out std_logic_vector (3 downto 0);
    DOPB         : out std_logic_vector (3 downto 0);

    ADDRA        : in  std_logic_vector (14 downto 0);
    ADDRB        : in  std_logic_vector (14 downto 0);
    CASCADEINA   : in  std_ulogic;
    CASCADEINB   : in  std_ulogic;
    CLKA         : in  std_ulogic;
    CLKB         : in  std_ulogic;
    DIA          : in  std_logic_vector (31 downto 0);
    DIB          : in  std_logic_vector (31 downto 0);
    DIPA         : in  std_logic_vector (3 downto 0);
    DIPB         : in  std_logic_vector (3 downto 0);
    ENA          : in  std_ulogic;
    ENB          : in  std_ulogic;
    REGCEA       : in  std_ulogic;
    REGCEB       : in  std_ulogic;
    SSRA         : in  std_ulogic;
    SSRB         : in  std_ulogic;
    WEA          : in  std_logic_vector (3 downto 0);
    WEB          : in  std_logic_vector (3 downto 0)
    );
  end component;
attribute syn_black_box of RAMB16 : component is true;

  component RAMB16_S1
    generic (
      write_mode : string     := "WRITE_FIRST";
      INIT       : bit_vector := X"0";
      SRVAL      : bit_vector := X"0";
  
      INIT_00 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_01 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_02 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_03 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_04 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_05 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_06 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_07 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_08 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_09 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0A :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0B :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0C :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0D :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0E :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0F :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_10 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_11 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_12 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_13 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_14 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_15 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_16 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_17 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_18 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_19 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1A :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1B :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1C :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1D :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1E :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1F :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_20 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_21 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_22 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_23 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_24 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_25 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_26 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_27 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_28 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_29 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2A :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2B :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2C :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2D :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2E :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2F :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_30 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_31 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_32 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_33 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_34 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_35 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_36 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_37 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_38 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_39 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3A :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3B :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3C :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3D :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3E :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3F :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000"
      );
    port (
      DO     : out std_logic_vector (0 downto 0);
  
      ADDR   : in  std_logic_vector (13 downto 0);
      CLK    : in  std_ulogic;
      DI     : in  std_logic_vector (0 downto 0);
      EN     : in  std_ulogic;
      SSR    : in  std_ulogic;
      WE     : in  std_ulogic
      );
  
  end component;
attribute syn_black_box of RAMB16_S1 : component is true;

  component RAMB16_S18
    generic (
      INIT       : bit_vector := X"00000";
      SRVAL      : bit_vector := X"00000";
      write_mode : string     := "WRITE_FIRST";

      INITP_00 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INITP_01 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INITP_02 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INITP_03 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INITP_04 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INITP_05 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INITP_06 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INITP_07 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_00  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_01  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_02  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_03  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_04  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_05  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_06  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_07  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_08  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_09  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0A  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0B  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0C  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0D  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0E  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0F  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_10  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_11  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_12  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_13  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_14  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_15  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_16  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_17  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_18  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_19  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1A  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1B  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1C  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1D  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1E  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1F  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_20  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_21  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_22  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_23  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_24  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_25  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_26  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_27  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_28  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_29  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2A  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2B  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2C  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2D  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2E  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2F  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_30  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_31  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_32  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_33  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_34  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_35  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_36  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_37  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_38  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_39  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3A  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3B  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3C  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3D  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3E  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3F  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000"
      );

    port (
      DO      : out std_logic_vector (15 downto 0);
      DOP     : out std_logic_vector (1 downto 0);
      ADDR    : in  std_logic_vector (9 downto 0);
      CLK     : in  std_ulogic;
      DI      : in  std_logic_vector (15 downto 0);
      DIP     : in  std_logic_vector (1 downto 0);
      EN      : in  std_ulogic;
      SSR     : in  std_ulogic;
      WE      : in  std_ulogic
      );
  end component;
attribute syn_black_box of RAMB16_S18 : component is true;

  component RAMB16_S18_S18 
    generic (

    INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";

    INITP_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";


      INIT_A : bit_vector  := X"00000";
      INIT_B : bit_vector  := X"00000";
      SRVAL_A : bit_vector  := X"00000";
      SRVAL_B : bit_vector  := X"00000";

      WRITE_MODE_A : string := "WRITE_FIRST";
      WRITE_MODE_B : string := "WRITE_FIRST"
      );

    port(
      DOA   : out std_logic_vector(15 downto 0);
      DOB   : out std_logic_vector(15 downto 0);
      DOPA  : out std_logic_vector(1 downto 0);
      DOPB  : out std_logic_vector(1 downto 0);
      ADDRA : in  std_logic_vector(9 downto 0);
      ADDRB : in  std_logic_vector(9 downto 0);
      CLKA  : in  std_ulogic;
      CLKB  : in  std_ulogic;
      DIA   : in  std_logic_vector(15 downto 0);
      DIB   : in  std_logic_vector(15 downto 0);
      DIPA  : in  std_logic_vector(1 downto 0);
      DIPB  : in  std_logic_vector(1 downto 0);
      ENA   : in  std_ulogic;
      ENB   : in  std_ulogic;
      SSRA  : in  std_ulogic;
      SSRB  : in  std_ulogic;
      WEA   : in  std_ulogic;
      WEB   : in  std_ulogic
      );
  end component; 
attribute syn_black_box of RAMB16_S18_S18 : component is true;

  component RAMB16_S18_S36 
    generic (

    INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";

    INITP_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";


      INIT_A : bit_vector  := X"00000";
      INIT_B : bit_vector  := X"000000000";
      SRVAL_A : bit_vector  := X"00000";
      SRVAL_B : bit_vector  := X"000000000";

      WRITE_MODE_A : string := "WRITE_FIRST";
      WRITE_MODE_B : string := "WRITE_FIRST"
      );

    port(
      DOA   : out std_logic_vector(15 downto 0);
      DOB   : out std_logic_vector(31 downto 0);
      DOPA  : out std_logic_vector(1 downto 0);
      DOPB  : out std_logic_vector(3 downto 0);
      ADDRA : in  std_logic_vector(9 downto 0);
      ADDRB : in  std_logic_vector(8 downto 0);
      CLKA  : in  std_ulogic;
      CLKB  : in  std_ulogic;
      DIA   : in  std_logic_vector(15 downto 0);
      DIB   : in  std_logic_vector(31 downto 0);
      DIPA  : in  std_logic_vector(1 downto 0);
      DIPB  : in  std_logic_vector(3 downto 0);
      ENA   : in  std_ulogic;
      ENB   : in  std_ulogic;
      SSRA  : in  std_ulogic;
      SSRB  : in  std_ulogic;
      WEA   : in  std_ulogic;
      WEB   : in  std_ulogic
      );
  end component; 
attribute syn_black_box of RAMB16_S18_S36 : component is true;

  component RAMB16_S1_S1 
    generic (

    INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";


      INIT_A : bit_vector  := X"0";
      INIT_B : bit_vector  := X"0";
      SRVAL_A : bit_vector  := X"0";
      SRVAL_B : bit_vector  := X"0";

      WRITE_MODE_A : string := "WRITE_FIRST";
      WRITE_MODE_B : string := "WRITE_FIRST"
      );

    port(
      DOA   : out std_logic_vector(0 downto 0);
      DOB   : out std_logic_vector(0 downto 0);
      ADDRA : in  std_logic_vector(13 downto 0);
      ADDRB : in  std_logic_vector(13 downto 0);
      CLKA  : in  std_ulogic;
      CLKB  : in  std_ulogic;
      DIA   : in  std_logic_vector(0 downto 0);
      DIB   : in  std_logic_vector(0 downto 0);
      ENA   : in  std_ulogic;
      ENB   : in  std_ulogic;
      SSRA  : in  std_ulogic;
      SSRB  : in  std_ulogic;
      WEA   : in  std_ulogic;
      WEB   : in  std_ulogic
      );
  end component; 
attribute syn_black_box of RAMB16_S1_S1 : component is true;

  component RAMB16_S1_S18 
    generic (

    INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";

    INITP_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";


      INIT_A : bit_vector  := X"0";
      INIT_B : bit_vector  := X"00000";
      SRVAL_A : bit_vector  := X"0";
      SRVAL_B : bit_vector  := X"00000";

      WRITE_MODE_A : string := "WRITE_FIRST";
      WRITE_MODE_B : string := "WRITE_FIRST"
      );

    port(
      DOA   : out std_logic_vector(0 downto 0);
      DOB   : out std_logic_vector(15 downto 0);
      DOPB  : out std_logic_vector(1 downto 0);
      ADDRA : in  std_logic_vector(13 downto 0);
      ADDRB : in  std_logic_vector(9 downto 0);
      CLKA  : in  std_ulogic;
      CLKB  : in  std_ulogic;
      DIA   : in  std_logic_vector(0 downto 0);
      DIB   : in  std_logic_vector(15 downto 0);
      DIPB  : in  std_logic_vector(1 downto 0);
      ENA   : in  std_ulogic;
      ENB   : in  std_ulogic;
      SSRA  : in  std_ulogic;
      SSRB  : in  std_ulogic;
      WEA   : in  std_ulogic;
      WEB   : in  std_ulogic
      );
  end component; 
attribute syn_black_box of RAMB16_S1_S18 : component is true;

  component RAMB16_S1_S2 
    generic (

    INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";


      INIT_A : bit_vector  := X"0";
      INIT_B : bit_vector  := X"0";
      SRVAL_A : bit_vector  := X"0";
      SRVAL_B : bit_vector  := X"0";

      WRITE_MODE_A : string := "WRITE_FIRST";
      WRITE_MODE_B : string := "WRITE_FIRST"
      );

    port(
      DOA   : out std_logic_vector(0 downto 0);
      DOB   : out std_logic_vector(1 downto 0);
      ADDRA : in  std_logic_vector(13 downto 0);
      ADDRB : in  std_logic_vector(12 downto 0);
      CLKA  : in  std_ulogic;
      CLKB  : in  std_ulogic;
      DIA   : in  std_logic_vector(0 downto 0);
      DIB   : in  std_logic_vector(1 downto 0);
      ENA   : in  std_ulogic;
      ENB   : in  std_ulogic;
      SSRA  : in  std_ulogic;
      SSRB  : in  std_ulogic;
      WEA   : in  std_ulogic;
      WEB   : in  std_ulogic
      );
  end component; 
attribute syn_black_box of RAMB16_S1_S2 : component is true;

  component RAMB16_S1_S36 
    generic (

    INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";

    INITP_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";


      INIT_A : bit_vector  := X"0";
      INIT_B : bit_vector  := X"000000000";
      SRVAL_A : bit_vector  := X"0";
      SRVAL_B : bit_vector  := X"000000000";

      WRITE_MODE_A : string := "WRITE_FIRST";
      WRITE_MODE_B : string := "WRITE_FIRST"
      );

    port(
      DOA   : out std_logic_vector(0 downto 0);
      DOB   : out std_logic_vector(31 downto 0);
      DOPB  : out std_logic_vector(3 downto 0);
      ADDRA : in  std_logic_vector(13 downto 0);
      ADDRB : in  std_logic_vector(8 downto 0);
      CLKA  : in  std_ulogic;
      CLKB  : in  std_ulogic;
      DIA   : in  std_logic_vector(0 downto 0);
      DIB   : in  std_logic_vector(31 downto 0);
      DIPB  : in  std_logic_vector(3 downto 0);
      ENA   : in  std_ulogic;
      ENB   : in  std_ulogic;
      SSRA  : in  std_ulogic;
      SSRB  : in  std_ulogic;
      WEA   : in  std_ulogic;
      WEB   : in  std_ulogic
      );
  end component; 
attribute syn_black_box of RAMB16_S1_S36 : component is true;

  component RAMB16_S1_S4 
    generic (

    INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";


      INIT_A : bit_vector  := X"0";
      INIT_B : bit_vector  := X"0";
      SRVAL_A : bit_vector  := X"0";
      SRVAL_B : bit_vector  := X"0";

      WRITE_MODE_A : string := "WRITE_FIRST";
      WRITE_MODE_B : string := "WRITE_FIRST"
      );

    port(
      DOA   : out std_logic_vector(0 downto 0);
      DOB   : out std_logic_vector(3 downto 0);
      ADDRA : in  std_logic_vector(13 downto 0);
      ADDRB : in  std_logic_vector(11 downto 0);
      CLKA  : in  std_ulogic;
      CLKB  : in  std_ulogic;
      DIA   : in  std_logic_vector(0 downto 0);
      DIB   : in  std_logic_vector(3 downto 0);
      ENA   : in  std_ulogic;
      ENB   : in  std_ulogic;
      SSRA  : in  std_ulogic;
      SSRB  : in  std_ulogic;
      WEA   : in  std_ulogic;
      WEB   : in  std_ulogic
      );
  end component; 
attribute syn_black_box of RAMB16_S1_S4 : component is true;

  component RAMB16_S1_S9 
    generic (

    INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";

    INITP_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";


      INIT_A : bit_vector  := X"0";
      INIT_B : bit_vector  := X"000";
      SRVAL_A : bit_vector  := X"0";
      SRVAL_B : bit_vector  := X"000";

      WRITE_MODE_A : string := "WRITE_FIRST";
      WRITE_MODE_B : string := "WRITE_FIRST"
      );

    port(
      DOA   : out std_logic_vector(0 downto 0);
      DOB   : out std_logic_vector(7 downto 0);
      DOPB  : out std_logic_vector(0 downto 0);
      ADDRA : in  std_logic_vector(13 downto 0);
      ADDRB : in  std_logic_vector(10 downto 0);
      CLKA  : in  std_ulogic;
      CLKB  : in  std_ulogic;
      DIA   : in  std_logic_vector(0 downto 0);
      DIB   : in  std_logic_vector(7 downto 0);
      DIPB  : in  std_logic_vector(0 downto 0);
      ENA   : in  std_ulogic;
      ENB   : in  std_ulogic;
      SSRA  : in  std_ulogic;
      SSRB  : in  std_ulogic;
      WEA   : in  std_ulogic;
      WEB   : in  std_ulogic
      );
  end component; 
attribute syn_black_box of RAMB16_S1_S9 : component is true;

  component RAMB16_S2
    generic (
      INIT       : bit_vector := X"0";
      SRVAL      : bit_vector := X"0";
      write_mode : string     := "WRITE_FIRST";
  
      INIT_00 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_01 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_02 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_03 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_04 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_05 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_06 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_07 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_08 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_09 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0A :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0B :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0C :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0D :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0E :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0F :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_10 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_11 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_12 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_13 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_14 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_15 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_16 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_17 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_18 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_19 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1A :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1B :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1C :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1D :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1E :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1F :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_20 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_21 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_22 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_23 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_24 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_25 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_26 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_27 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_28 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_29 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2A :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2B :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2C :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2D :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2E :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2F :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_30 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_31 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_32 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_33 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_34 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_35 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_36 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_37 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_38 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_39 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3A :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3B :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3C :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3D :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3E :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3F :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000"
      );
  
    port (
      DO     : out std_logic_vector (1 downto 0);
      ADDR   : in  std_logic_vector (12 downto 0);
      CLK    : in  std_ulogic;
      DI     : in  std_logic_vector (1 downto 0);
      EN     : in  std_ulogic;
      SSR    : in  std_ulogic;
      WE     : in  std_ulogic
      );
  end component;
attribute syn_black_box of RAMB16_S2 : component is true;

  component RAMB16_S2_S18 
    generic (

    INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";

    INITP_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";


      INIT_A : bit_vector  := X"0";
      INIT_B : bit_vector  := X"00000";
      SRVAL_A : bit_vector  := X"0";
      SRVAL_B : bit_vector  := X"00000";

      WRITE_MODE_A : string := "WRITE_FIRST";
      WRITE_MODE_B : string := "WRITE_FIRST"
      );

    port(
      DOA   : out std_logic_vector(1 downto 0);
      DOB   : out std_logic_vector(15 downto 0);
      DOPB  : out std_logic_vector(1 downto 0);
      ADDRA : in  std_logic_vector(12 downto 0);
      ADDRB : in  std_logic_vector(9 downto 0);
      CLKA  : in  std_ulogic;
      CLKB  : in  std_ulogic;
      DIA   : in  std_logic_vector(1 downto 0);
      DIB   : in  std_logic_vector(15 downto 0);
      DIPB  : in  std_logic_vector(1 downto 0);
      ENA   : in  std_ulogic;
      ENB   : in  std_ulogic;
      SSRA  : in  std_ulogic;
      SSRB  : in  std_ulogic;
      WEA   : in  std_ulogic;
      WEB   : in  std_ulogic
      );
  end component; 
attribute syn_black_box of RAMB16_S2_S18 : component is true;

  component RAMB16_S2_S2 
    generic (

    INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";


      INIT_A : bit_vector  := X"0";
      INIT_B : bit_vector  := X"0";
      SRVAL_A : bit_vector  := X"0";
      SRVAL_B : bit_vector  := X"0";

      WRITE_MODE_A : string := "WRITE_FIRST";
      WRITE_MODE_B : string := "WRITE_FIRST"
      );

    port(
      DOA   : out std_logic_vector(1 downto 0);
      DOB   : out std_logic_vector(1 downto 0);
      ADDRA : in  std_logic_vector(12 downto 0);
      ADDRB : in  std_logic_vector(12 downto 0);
      CLKA  : in  std_ulogic;
      CLKB  : in  std_ulogic;
      DIA   : in  std_logic_vector(1 downto 0);
      DIB   : in  std_logic_vector(1 downto 0);
      ENA   : in  std_ulogic;
      ENB   : in  std_ulogic;
      SSRA  : in  std_ulogic;
      SSRB  : in  std_ulogic;
      WEA   : in  std_ulogic;
      WEB   : in  std_ulogic
      );
  end component; 
attribute syn_black_box of RAMB16_S2_S2 : component is true;

  component RAMB16_S2_S36 
    generic (

    INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";

    INITP_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";


      INIT_A : bit_vector  := X"0";
      INIT_B : bit_vector  := X"000000000";
      SRVAL_A : bit_vector  := X"0";
      SRVAL_B : bit_vector  := X"000000000";

      WRITE_MODE_A : string := "WRITE_FIRST";
      WRITE_MODE_B : string := "WRITE_FIRST"
      );

    port(
      DOA   : out std_logic_vector(1 downto 0);
      DOB   : out std_logic_vector(31 downto 0);
      DOPB  : out std_logic_vector(3 downto 0);
      ADDRA : in  std_logic_vector(12 downto 0);
      ADDRB : in  std_logic_vector(8 downto 0);
      CLKA  : in  std_ulogic;
      CLKB  : in  std_ulogic;
      DIA   : in  std_logic_vector(1 downto 0);
      DIB   : in  std_logic_vector(31 downto 0);
      DIPB  : in  std_logic_vector(3 downto 0);
      ENA   : in  std_ulogic;
      ENB   : in  std_ulogic;
      SSRA  : in  std_ulogic;
      SSRB  : in  std_ulogic;
      WEA   : in  std_ulogic;
      WEB   : in  std_ulogic
      );
  end component; 
attribute syn_black_box of RAMB16_S2_S36 : component is true;

  component RAMB16_S2_S4 
    generic (

    INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";


      INIT_A : bit_vector  := X"0";
      INIT_B : bit_vector  := X"0";
      SRVAL_A : bit_vector  := X"0";
      SRVAL_B : bit_vector  := X"0";

      WRITE_MODE_A : string := "WRITE_FIRST";
      WRITE_MODE_B : string := "WRITE_FIRST"
      );

    port(
      DOA   : out std_logic_vector(1 downto 0);
      DOB   : out std_logic_vector(3 downto 0);
      ADDRA : in  std_logic_vector(12 downto 0);
      ADDRB : in  std_logic_vector(11 downto 0);
      CLKA  : in  std_ulogic;
      CLKB  : in  std_ulogic;
      DIA   : in  std_logic_vector(1 downto 0);
      DIB   : in  std_logic_vector(3 downto 0);
      ENA   : in  std_ulogic;
      ENB   : in  std_ulogic;
      SSRA  : in  std_ulogic;
      SSRB  : in  std_ulogic;
      WEA   : in  std_ulogic;
      WEB   : in  std_ulogic
      );
  end component; 
attribute syn_black_box of RAMB16_S2_S4 : component is true;

  component RAMB16_S2_S9 
    generic (

    INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";

    INITP_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";


      INIT_A : bit_vector  := X"0";
      INIT_B : bit_vector  := X"000";
      SRVAL_A : bit_vector  := X"0";
      SRVAL_B : bit_vector  := X"000";

      WRITE_MODE_A : string := "WRITE_FIRST";
      WRITE_MODE_B : string := "WRITE_FIRST"
      );

    port(
      DOA   : out std_logic_vector(1 downto 0);
      DOB   : out std_logic_vector(7 downto 0);
      DOPB  : out std_logic_vector(0 downto 0);
      ADDRA : in  std_logic_vector(12 downto 0);
      ADDRB : in  std_logic_vector(10 downto 0);
      CLKA  : in  std_ulogic;
      CLKB  : in  std_ulogic;
      DIA   : in  std_logic_vector(1 downto 0);
      DIB   : in  std_logic_vector(7 downto 0);
      DIPB  : in  std_logic_vector(0 downto 0);
      ENA   : in  std_ulogic;
      ENB   : in  std_ulogic;
      SSRA  : in  std_ulogic;
      SSRB  : in  std_ulogic;
      WEA   : in  std_ulogic;
      WEB   : in  std_ulogic
      );
  end component; 
attribute syn_black_box of RAMB16_S2_S9 : component is true;

  component RAMB16_S36
    generic (
      INIT       : bit_vector := X"000000000";
      SRVAL      : bit_vector := X"000000000";
      write_mode : string     := "WRITE_FIRST";
  
      INITP_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INITP_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INITP_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INITP_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INITP_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INITP_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INITP_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INITP_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_00  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_01  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_02  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_03  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_04  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_05  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_06  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_07  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_08  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_09  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0A  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0B  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0C  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0D  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0E  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0F  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_10  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_11  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_12  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_13  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_14  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_15  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_16  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_17  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_18  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_19  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1A  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1B  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1C  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1D  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1E  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1F  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_20  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_21  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_22  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_23  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_24  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_25  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_26  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_27  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_28  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_29  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2A  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2B  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2C  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2D  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2E  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2F  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_30  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_31  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_32  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_33  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_34  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_35  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_36  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_37  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_38  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_39  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3A  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3B  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3C  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3D  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3E  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3F  : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000"
      );
  
    port (
      DO   : out std_logic_vector (31 downto 0);
      DOP  : out std_logic_vector (3 downto 0);
      
      ADDR : in  std_logic_vector (8 downto 0);
      CLK  : in  std_ulogic;
      DI   : in  std_logic_vector (31 downto 0);
      DIP  : in  std_logic_vector (3 downto 0);
      EN   : in  std_ulogic;
      SSR  : in  std_ulogic;
      WE   : in  std_ulogic
      );
  
  end component;
attribute syn_black_box of RAMB16_S36 : component is true;

  component RAMB16_S36_S36 
    generic (

    INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";

    INITP_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";


      INIT_A : bit_vector  := X"000000000";
      INIT_B : bit_vector  := X"000000000";
      SRVAL_A : bit_vector  := X"000000000";
      SRVAL_B : bit_vector  := X"000000000";

      WRITE_MODE_A : string := "WRITE_FIRST";
      WRITE_MODE_B : string := "WRITE_FIRST"
      );

    port(
      DOA   : out std_logic_vector(31 downto 0);
      DOB   : out std_logic_vector(31 downto 0);
      DOPA  : out std_logic_vector(3 downto 0);
      DOPB  : out std_logic_vector(3 downto 0);
      ADDRA : in  std_logic_vector(8 downto 0);
      ADDRB : in  std_logic_vector(8 downto 0);
      CLKA  : in  std_ulogic;
      CLKB  : in  std_ulogic;
      DIA   : in  std_logic_vector(31 downto 0);
      DIB   : in  std_logic_vector(31 downto 0);
      DIPA  : in  std_logic_vector(3 downto 0);
      DIPB  : in  std_logic_vector(3 downto 0);
      ENA   : in  std_ulogic;
      ENB   : in  std_ulogic;
      SSRA  : in  std_ulogic;
      SSRB  : in  std_ulogic;
      WEA   : in  std_ulogic;
      WEB   : in  std_ulogic
      );
  end component; 
attribute syn_black_box of RAMB16_S36_S36 : component is true;

  component RAMB16_S4
    generic (
      INIT       : bit_vector := X"0";
      SRVAL      : bit_vector := X"0";
      write_mode : string     := "WRITE_FIRST";
  
      INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000"
      );
  
    port (
      DO   : out std_logic_vector (3 downto 0);
  
      ADDR : in  std_logic_vector (11 downto 0);
      CLK  : in  std_ulogic;
      DI   : in  std_logic_vector (3 downto 0);
      EN   : in  std_ulogic;
      SSR  : in  std_ulogic;
      WE   : in  std_ulogic
      );
  end component;
attribute syn_black_box of RAMB16_S4 : component is true;

  component RAMB16_S4_S18 
    generic (

    INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";

    INITP_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";


      INIT_A : bit_vector  := X"0";
      INIT_B : bit_vector  := X"00000";
      SRVAL_A : bit_vector  := X"0";
      SRVAL_B : bit_vector  := X"00000";

      WRITE_MODE_A : string := "WRITE_FIRST";
      WRITE_MODE_B : string := "WRITE_FIRST"
      );

    port(
      DOA   : out std_logic_vector(3 downto 0);
      DOB   : out std_logic_vector(15 downto 0);
      DOPB  : out std_logic_vector(1 downto 0);
      ADDRA : in  std_logic_vector(11 downto 0);
      ADDRB : in  std_logic_vector(9 downto 0);
      CLKA  : in  std_ulogic;
      CLKB  : in  std_ulogic;
      DIA   : in  std_logic_vector(3 downto 0);
      DIB   : in  std_logic_vector(15 downto 0);
      DIPB  : in  std_logic_vector(1 downto 0);
      ENA   : in  std_ulogic;
      ENB   : in  std_ulogic;
      SSRA  : in  std_ulogic;
      SSRB  : in  std_ulogic;
      WEA   : in  std_ulogic;
      WEB   : in  std_ulogic
      );
  end component; 
attribute syn_black_box of RAMB16_S4_S18 : component is true;

  component RAMB16_S4_S36 
    generic (

    INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";

    INITP_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";


      INIT_A : bit_vector  := X"0";
      INIT_B : bit_vector  := X"000000000";
      SRVAL_A : bit_vector  := X"0";
      SRVAL_B : bit_vector  := X"000000000";

      WRITE_MODE_A : string := "WRITE_FIRST";
      WRITE_MODE_B : string := "WRITE_FIRST"
      );

    port(
      DOA   : out std_logic_vector(3 downto 0);
      DOB   : out std_logic_vector(31 downto 0);
      DOPB  : out std_logic_vector(3 downto 0);
      ADDRA : in  std_logic_vector(11 downto 0);
      ADDRB : in  std_logic_vector(8 downto 0);
      CLKA  : in  std_ulogic;
      CLKB  : in  std_ulogic;
      DIA   : in  std_logic_vector(3 downto 0);
      DIB   : in  std_logic_vector(31 downto 0);
      DIPB  : in  std_logic_vector(3 downto 0);
      ENA   : in  std_ulogic;
      ENB   : in  std_ulogic;
      SSRA  : in  std_ulogic;
      SSRB  : in  std_ulogic;
      WEA   : in  std_ulogic;
      WEB   : in  std_ulogic
      );
  end component; 
attribute syn_black_box of RAMB16_S4_S36 : component is true;

  component RAMB16_S4_S4 
    generic (

    INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";


      INIT_A : bit_vector  := X"0";
      INIT_B : bit_vector  := X"0";
      SRVAL_A : bit_vector  := X"0";
      SRVAL_B : bit_vector  := X"0";

      WRITE_MODE_A : string := "WRITE_FIRST";
      WRITE_MODE_B : string := "WRITE_FIRST"
      );

    port(
      DOA   : out std_logic_vector(3 downto 0);
      DOB   : out std_logic_vector(3 downto 0);
      ADDRA : in  std_logic_vector(11 downto 0);
      ADDRB : in  std_logic_vector(11 downto 0);
      CLKA  : in  std_ulogic;
      CLKB  : in  std_ulogic;
      DIA   : in  std_logic_vector(3 downto 0);
      DIB   : in  std_logic_vector(3 downto 0);
      ENA   : in  std_ulogic;
      ENB   : in  std_ulogic;
      SSRA  : in  std_ulogic;
      SSRB  : in  std_ulogic;
      WEA   : in  std_ulogic;
      WEB   : in  std_ulogic
      );
  end component; 
attribute syn_black_box of RAMB16_S4_S4 : component is true;

  component RAMB16_S4_S9 
    generic (

    INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";

    INITP_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";


      INIT_A : bit_vector  := X"0";
      INIT_B : bit_vector  := X"000";
      SRVAL_A : bit_vector  := X"0";
      SRVAL_B : bit_vector  := X"000";

      WRITE_MODE_A : string := "WRITE_FIRST";
      WRITE_MODE_B : string := "WRITE_FIRST"
      );

    port(
      DOA   : out std_logic_vector(3 downto 0);
      DOB   : out std_logic_vector(7 downto 0);
      DOPB  : out std_logic_vector(0 downto 0);
      ADDRA : in  std_logic_vector(11 downto 0);
      ADDRB : in  std_logic_vector(10 downto 0);
      CLKA  : in  std_ulogic;
      CLKB  : in  std_ulogic;
      DIA   : in  std_logic_vector(3 downto 0);
      DIB   : in  std_logic_vector(7 downto 0);
      DIPB  : in  std_logic_vector(0 downto 0);
      ENA   : in  std_ulogic;
      ENB   : in  std_ulogic;
      SSRA  : in  std_ulogic;
      SSRB  : in  std_ulogic;
      WEA   : in  std_ulogic;
      WEB   : in  std_ulogic
      );
  end component; 
attribute syn_black_box of RAMB16_S4_S9 : component is true;

  component RAMB16_S9
    generic (
      INIT       : bit_vector := X"000";
      SRVAL      : bit_vector := X"000";
      write_mode : string     := "WRITE_FIRST";
  
      INIT_00  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_01  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_02  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_03  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_04  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_05  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_06  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_07  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_08  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_09  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0A  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0B  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0C  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0D  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0E  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0F  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_10  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_11  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_12  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_13  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_14  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_15  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_16  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_17  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_18  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_19  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1A  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1B  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1C  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1D  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1E  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_1F  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_20  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_21  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_22  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_23  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_24  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_25  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_26  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_27  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_28  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_29  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2A  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2B  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2C  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2D  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2E  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_2F  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_30  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_31  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_32  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_33  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_34  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_35  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_36  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_37  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_38  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_39  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3A  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3B  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3C  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3D  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3E  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_3F  :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
  
      INITP_00 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INITP_01 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INITP_02 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INITP_03 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INITP_04 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INITP_05 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INITP_06 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INITP_07 :     bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000"
      );
    port (
      DO      : out std_logic_vector (7 downto 0);
      DOP     : out std_logic_vector (0 downto 0);
  
      ADDR    : in  std_logic_vector (10 downto 0);
      CLK     : in  std_ulogic;
      DI      : in  std_logic_vector (7 downto 0);
      DIP     : in  std_logic_vector (0 downto 0);
      EN      : in  std_ulogic;
      SSR     : in  std_ulogic;
      WE      : in  std_ulogic
      );
  
  end component;
attribute syn_black_box of RAMB16_S9 : component is true;

  component RAMB16_S9_S18 
    generic (

    INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";

    INITP_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";


      INIT_A : bit_vector  := X"000";
      INIT_B : bit_vector  := X"00000";
      SRVAL_A : bit_vector  := X"000";
      SRVAL_B : bit_vector  := X"00000";

      WRITE_MODE_A : string := "WRITE_FIRST";
      WRITE_MODE_B : string := "WRITE_FIRST"
      );

    port(
      DOA   : out std_logic_vector(7 downto 0);
      DOB   : out std_logic_vector(15 downto 0);
      DOPA  : out std_logic_vector(0 downto 0);
      DOPB  : out std_logic_vector(1 downto 0);
      ADDRA : in  std_logic_vector(10 downto 0);
      ADDRB : in  std_logic_vector(9 downto 0);
      CLKA  : in  std_ulogic;
      CLKB  : in  std_ulogic;
      DIA   : in  std_logic_vector(7 downto 0);
      DIB   : in  std_logic_vector(15 downto 0);
      DIPA  : in  std_logic_vector(0 downto 0);
      DIPB  : in  std_logic_vector(1 downto 0);
      ENA   : in  std_ulogic;
      ENB   : in  std_ulogic;
      SSRA  : in  std_ulogic;
      SSRB  : in  std_ulogic;
      WEA   : in  std_ulogic;
      WEB   : in  std_ulogic
      );
  end component; 
attribute syn_black_box of RAMB16_S9_S18 : component is true;

  component RAMB16_S9_S36 
    generic (

    INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";

    INITP_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";


      INIT_A : bit_vector  := X"000";
      INIT_B : bit_vector  := X"000000000";
      SRVAL_A : bit_vector  := X"000";
      SRVAL_B : bit_vector  := X"000000000";

      WRITE_MODE_A : string := "WRITE_FIRST";
      WRITE_MODE_B : string := "WRITE_FIRST"
      );

    port(
      DOA   : out std_logic_vector(7 downto 0);
      DOB   : out std_logic_vector(31 downto 0);
      DOPA  : out std_logic_vector(0 downto 0);
      DOPB  : out std_logic_vector(3 downto 0);
      ADDRA : in  std_logic_vector(10 downto 0);
      ADDRB : in  std_logic_vector(8 downto 0);
      CLKA  : in  std_ulogic;
      CLKB  : in  std_ulogic;
      DIA   : in  std_logic_vector(7 downto 0);
      DIB   : in  std_logic_vector(31 downto 0);
      DIPA  : in  std_logic_vector(0 downto 0);
      DIPB  : in  std_logic_vector(3 downto 0);
      ENA   : in  std_ulogic;
      ENB   : in  std_ulogic;
      SSRA  : in  std_ulogic;
      SSRB  : in  std_ulogic;
      WEA   : in  std_ulogic;
      WEB   : in  std_ulogic
      );
  end component; 
attribute syn_black_box of RAMB16_S9_S36 : component is true;

  component RAMB16_S9_S9 
    generic (

    INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";

    INITP_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INITP_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";


      INIT_A : bit_vector  := X"000";
      INIT_B : bit_vector  := X"000";
      SRVAL_A : bit_vector  := X"000";
      SRVAL_B : bit_vector  := X"000";

      WRITE_MODE_A : string := "WRITE_FIRST";
      WRITE_MODE_B : string := "WRITE_FIRST"
      );

    port(
      DOA   : out std_logic_vector(7 downto 0);
      DOB   : out std_logic_vector(7 downto 0);
      DOPA  : out std_logic_vector(0 downto 0);
      DOPB  : out std_logic_vector(0 downto 0);
      ADDRA : in  std_logic_vector(10 downto 0);
      ADDRB : in  std_logic_vector(10 downto 0);
      CLKA  : in  std_ulogic;
      CLKB  : in  std_ulogic;
      DIA   : in  std_logic_vector(7 downto 0);
      DIB   : in  std_logic_vector(7 downto 0);
      DIPA  : in  std_logic_vector(0 downto 0);
      DIPB  : in  std_logic_vector(0 downto 0);
      ENA   : in  std_ulogic;
      ENB   : in  std_ulogic;
      SSRA  : in  std_ulogic;
      SSRB  : in  std_ulogic;
      WEA   : in  std_ulogic;
      WEB   : in  std_ulogic
      );
  end component; 
attribute syn_black_box of RAMB16_S9_S9 : component is true;

component RAMB32_S64_ECC

port (
		DO : out std_logic_vector(63 downto 0);
		STATUS : out std_logic_vector(1 downto 0);

		DI : in std_logic_vector(63 downto 0);
		RDADDR : in std_logic_vector(8 downto 0);
		RDCLK : in std_ulogic;
		RDEN : in std_ulogic;
		SSR : in std_ulogic;
		WRADDR : in std_logic_vector(8 downto 0);
		WRCLK : in std_ulogic;
		WREN : in std_ulogic

     );
end component;
attribute syn_black_box of RAMB32_S64_ECC : component is true;

  component RAMB4_S1
    generic (
      INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000"
      );
  
    port (
      DO   : out std_logic_vector (0 downto 0);
  
      ADDR : in  std_logic_vector (11 downto 0);
      CLK  : in  std_ulogic;
      DI   : in  std_logic_vector (0 downto 0);
      EN   : in  std_ulogic;
      RST  : in  std_ulogic;
      WE   : in  std_ulogic
      );
  end component;
attribute syn_black_box of RAMB4_S1 : component is true;

  component RAMB4_S16
    generic (
      INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000"
      );
  
    port (
      DO   : out std_logic_vector (15 downto 0);
  
      ADDR : in  std_logic_vector (7 downto 0);
      CLK  : in  std_ulogic;
      DI   : in  std_logic_vector (15 downto 0);
      EN   : in  std_ulogic;
      RST  : in  std_ulogic;
      WE   : in  std_ulogic
      );
  end component;
attribute syn_black_box of RAMB4_S16 : component is true;

  component RAMB4_S16_S16 
    generic (

    INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000"

      );

    port(
      DOA   : out std_logic_vector(15 downto 0);
      DOB   : out std_logic_vector(15 downto 0);

      ADDRA : in  std_logic_vector(7 downto 0);
      ADDRB : in  std_logic_vector(7 downto 0);
      CLKA  : in  std_ulogic;
      CLKB  : in  std_ulogic;
      DIA   : in  std_logic_vector(15 downto 0);
      DIB   : in  std_logic_vector(15 downto 0);
      ENA   : in  std_ulogic;
      ENB   : in  std_ulogic;
      RSTA  : in  std_ulogic;
      RSTB  : in  std_ulogic;
      WEA   : in  std_ulogic;
      WEB   : in  std_ulogic
      );
  end component; 
attribute syn_black_box of RAMB4_S16_S16 : component is true;

  component RAMB4_S1_S1 
    generic (

    INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000"

      );

    port(
      DOA   : out std_logic_vector(0 downto 0);
      DOB   : out std_logic_vector(0 downto 0);

      ADDRA : in  std_logic_vector(11 downto 0);
      ADDRB : in  std_logic_vector(11 downto 0);
      CLKA  : in  std_ulogic;
      CLKB  : in  std_ulogic;
      DIA   : in  std_logic_vector(0 downto 0);
      DIB   : in  std_logic_vector(0 downto 0);
      ENA   : in  std_ulogic;
      ENB   : in  std_ulogic;
      RSTA  : in  std_ulogic;
      RSTB  : in  std_ulogic;
      WEA   : in  std_ulogic;
      WEB   : in  std_ulogic
      );
  end component; 
attribute syn_black_box of RAMB4_S1_S1 : component is true;

  component RAMB4_S1_S16 
    generic (

    INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000"

      );

    port(
      DOA   : out std_logic_vector(0 downto 0);
      DOB   : out std_logic_vector(15 downto 0);

      ADDRA : in  std_logic_vector(11 downto 0);
      ADDRB : in  std_logic_vector(7 downto 0);
      CLKA  : in  std_ulogic;
      CLKB  : in  std_ulogic;
      DIA   : in  std_logic_vector(0 downto 0);
      DIB   : in  std_logic_vector(15 downto 0);
      ENA   : in  std_ulogic;
      ENB   : in  std_ulogic;
      RSTA  : in  std_ulogic;
      RSTB  : in  std_ulogic;
      WEA   : in  std_ulogic;
      WEB   : in  std_ulogic
      );
  end component; 
attribute syn_black_box of RAMB4_S1_S16 : component is true;

  component RAMB4_S1_S2 
    generic (

    INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000"

      );

    port(
      DOA   : out std_logic_vector(0 downto 0);
      DOB   : out std_logic_vector(1 downto 0);

      ADDRA : in  std_logic_vector(11 downto 0);
      ADDRB : in  std_logic_vector(10 downto 0);
      CLKA  : in  std_ulogic;
      CLKB  : in  std_ulogic;
      DIA   : in  std_logic_vector(0 downto 0);
      DIB   : in  std_logic_vector(1 downto 0);
      ENA   : in  std_ulogic;
      ENB   : in  std_ulogic;
      RSTA  : in  std_ulogic;
      RSTB  : in  std_ulogic;
      WEA   : in  std_ulogic;
      WEB   : in  std_ulogic
      );
  end component; 
attribute syn_black_box of RAMB4_S1_S2 : component is true;

  component RAMB4_S1_S4 
    generic (

    INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000"

      );

    port(
      DOA   : out std_logic_vector(0 downto 0);
      DOB   : out std_logic_vector(3 downto 0);

      ADDRA : in  std_logic_vector(11 downto 0);
      ADDRB : in  std_logic_vector(9 downto 0);
      CLKA  : in  std_ulogic;
      CLKB  : in  std_ulogic;
      DIA   : in  std_logic_vector(0 downto 0);
      DIB   : in  std_logic_vector(3 downto 0);
      ENA   : in  std_ulogic;
      ENB   : in  std_ulogic;
      RSTA  : in  std_ulogic;
      RSTB  : in  std_ulogic;
      WEA   : in  std_ulogic;
      WEB   : in  std_ulogic
      );
  end component; 
attribute syn_black_box of RAMB4_S1_S4 : component is true;

  component RAMB4_S1_S8 
    generic (

    INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000"

      );

    port(
      DOA   : out std_logic_vector(0 downto 0);
      DOB   : out std_logic_vector(7 downto 0);

      ADDRA : in  std_logic_vector(11 downto 0);
      ADDRB : in  std_logic_vector(8 downto 0);
      CLKA  : in  std_ulogic;
      CLKB  : in  std_ulogic;
      DIA   : in  std_logic_vector(0 downto 0);
      DIB   : in  std_logic_vector(7 downto 0);
      ENA   : in  std_ulogic;
      ENB   : in  std_ulogic;
      RSTA  : in  std_ulogic;
      RSTB  : in  std_ulogic;
      WEA   : in  std_ulogic;
      WEB   : in  std_ulogic
      );
  end component; 
attribute syn_black_box of RAMB4_S1_S8 : component is true;

  component RAMB4_S2
    generic (
      INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000"
      );
  
    port (
      DO   : out std_logic_vector (1 downto 0);
      
      ADDR : in  std_logic_vector (10 downto 0);
      CLK  : in  std_ulogic;
      DI   : in  std_logic_vector (1 downto 0);
      EN   : in  std_ulogic;
      RST  : in  std_ulogic;
      WE   : in  std_ulogic
      );
  end component;
attribute syn_black_box of RAMB4_S2 : component is true;

  component RAMB4_S2_S16 
    generic (

    INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000"

      );

    port(
      DOA   : out std_logic_vector(1 downto 0);
      DOB   : out std_logic_vector(15 downto 0);

      ADDRA : in  std_logic_vector(10 downto 0);
      ADDRB : in  std_logic_vector(7 downto 0);
      CLKA  : in  std_ulogic;
      CLKB  : in  std_ulogic;
      DIA   : in  std_logic_vector(1 downto 0);
      DIB   : in  std_logic_vector(15 downto 0);
      ENA   : in  std_ulogic;
      ENB   : in  std_ulogic;
      RSTA  : in  std_ulogic;
      RSTB  : in  std_ulogic;
      WEA   : in  std_ulogic;
      WEB   : in  std_ulogic
      );
  end component; 
attribute syn_black_box of RAMB4_S2_S16 : component is true;

  component RAMB4_S2_S2 
    generic (

    INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000"

      );

    port(
      DOA   : out std_logic_vector(1 downto 0);
      DOB   : out std_logic_vector(1 downto 0);

      ADDRA : in  std_logic_vector(10 downto 0);
      ADDRB : in  std_logic_vector(10 downto 0);
      CLKA  : in  std_ulogic;
      CLKB  : in  std_ulogic;
      DIA   : in  std_logic_vector(1 downto 0);
      DIB   : in  std_logic_vector(1 downto 0);
      ENA   : in  std_ulogic;
      ENB   : in  std_ulogic;
      RSTA  : in  std_ulogic;
      RSTB  : in  std_ulogic;
      WEA   : in  std_ulogic;
      WEB   : in  std_ulogic
      );
  end component; 
attribute syn_black_box of RAMB4_S2_S2 : component is true;

  component RAMB4_S2_S4 
    generic (

    INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000"

      );

    port(
      DOA   : out std_logic_vector(1 downto 0);
      DOB   : out std_logic_vector(3 downto 0);

      ADDRA : in  std_logic_vector(10 downto 0);
      ADDRB : in  std_logic_vector(9 downto 0);
      CLKA  : in  std_ulogic;
      CLKB  : in  std_ulogic;
      DIA   : in  std_logic_vector(1 downto 0);
      DIB   : in  std_logic_vector(3 downto 0);
      ENA   : in  std_ulogic;
      ENB   : in  std_ulogic;
      RSTA  : in  std_ulogic;
      RSTB  : in  std_ulogic;
      WEA   : in  std_ulogic;
      WEB   : in  std_ulogic
      );
  end component; 
attribute syn_black_box of RAMB4_S2_S4 : component is true;

  component RAMB4_S2_S8 
    generic (

    INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000"

      );

    port(
      DOA   : out std_logic_vector(1 downto 0);
      DOB   : out std_logic_vector(7 downto 0);

      ADDRA : in  std_logic_vector(10 downto 0);
      ADDRB : in  std_logic_vector(8 downto 0);
      CLKA  : in  std_ulogic;
      CLKB  : in  std_ulogic;
      DIA   : in  std_logic_vector(1 downto 0);
      DIB   : in  std_logic_vector(7 downto 0);
      ENA   : in  std_ulogic;
      ENB   : in  std_ulogic;
      RSTA  : in  std_ulogic;
      RSTB  : in  std_ulogic;
      WEA   : in  std_ulogic;
      WEB   : in  std_ulogic
      );
  end component; 
attribute syn_black_box of RAMB4_S2_S8 : component is true;

  component RAMB4_S4
    generic (
      INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000"
      );
  
    port (
      DO   : out std_logic_vector (3 downto 0);
      
      ADDR : in  std_logic_vector (9 downto 0);
      CLK  : in  std_ulogic;
      DI   : in  std_logic_vector (3 downto 0);
      EN   : in  std_ulogic;
      RST  : in  std_ulogic;
      WE   : in  std_ulogic
      );
  end component;
attribute syn_black_box of RAMB4_S4 : component is true;

  component RAMB4_S4_S16 
    generic (

    INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000"

      );

    port(
      DOA   : out std_logic_vector(3 downto 0);
      DOB   : out std_logic_vector(15 downto 0);

      ADDRA : in  std_logic_vector(9 downto 0);
      ADDRB : in  std_logic_vector(7 downto 0);
      CLKA  : in  std_ulogic;
      CLKB  : in  std_ulogic;
      DIA   : in  std_logic_vector(3 downto 0);
      DIB   : in  std_logic_vector(15 downto 0);
      ENA   : in  std_ulogic;
      ENB   : in  std_ulogic;
      RSTA  : in  std_ulogic;
      RSTB  : in  std_ulogic;
      WEA   : in  std_ulogic;
      WEB   : in  std_ulogic
      );
  end component; 
attribute syn_black_box of RAMB4_S4_S16 : component is true;

  component RAMB4_S4_S4 
    generic (

    INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000"

      );

    port(
      DOA   : out std_logic_vector(3 downto 0);
      DOB   : out std_logic_vector(3 downto 0);

      ADDRA : in  std_logic_vector(9 downto 0);
      ADDRB : in  std_logic_vector(9 downto 0);
      CLKA  : in  std_ulogic;
      CLKB  : in  std_ulogic;
      DIA   : in  std_logic_vector(3 downto 0);
      DIB   : in  std_logic_vector(3 downto 0);
      ENA   : in  std_ulogic;
      ENB   : in  std_ulogic;
      RSTA  : in  std_ulogic;
      RSTB  : in  std_ulogic;
      WEA   : in  std_ulogic;
      WEB   : in  std_ulogic
      );
  end component; 
attribute syn_black_box of RAMB4_S4_S4 : component is true;

  component RAMB4_S4_S8 
    generic (

    INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000"

      );

    port(
      DOA   : out std_logic_vector(3 downto 0);
      DOB   : out std_logic_vector(7 downto 0);

      ADDRA : in  std_logic_vector(9 downto 0);
      ADDRB : in  std_logic_vector(8 downto 0);
      CLKA  : in  std_ulogic;
      CLKB  : in  std_ulogic;
      DIA   : in  std_logic_vector(3 downto 0);
      DIB   : in  std_logic_vector(7 downto 0);
      ENA   : in  std_ulogic;
      ENB   : in  std_ulogic;
      RSTA  : in  std_ulogic;
      RSTB  : in  std_ulogic;
      WEA   : in  std_ulogic;
      WEB   : in  std_ulogic
      );
  end component; 
attribute syn_black_box of RAMB4_S4_S8 : component is true;

  component RAMB4_S8
    generic (
      INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
      INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000"
      );
  
    port (
      DO   : out std_logic_vector (7 downto 0);
      
      ADDR : in  std_logic_vector (8 downto 0);
      CLK  : in  std_ulogic;
      DI   : in  std_logic_vector (7 downto 0);
      EN   : in  std_ulogic;
      RST  : in  std_ulogic;
      WE   : in  std_ulogic
      );
  end component;
attribute syn_black_box of RAMB4_S8 : component is true;

  component RAMB4_S8_S16 
    generic (

    INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000"

      );

    port(
      DOA   : out std_logic_vector(7 downto 0);
      DOB   : out std_logic_vector(15 downto 0);

      ADDRA : in  std_logic_vector(8 downto 0);
      ADDRB : in  std_logic_vector(7 downto 0);
      CLKA  : in  std_ulogic;
      CLKB  : in  std_ulogic;
      DIA   : in  std_logic_vector(7 downto 0);
      DIB   : in  std_logic_vector(15 downto 0);
      ENA   : in  std_ulogic;
      ENB   : in  std_ulogic;
      RSTA  : in  std_ulogic;
      RSTB  : in  std_ulogic;
      WEA   : in  std_ulogic;
      WEB   : in  std_ulogic
      );
  end component; 
attribute syn_black_box of RAMB4_S8_S16 : component is true;

  component RAMB4_S8_S8 
    generic (

    INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000"

      );

    port(
      DOA   : out std_logic_vector(7 downto 0);
      DOB   : out std_logic_vector(7 downto 0);

      ADDRA : in  std_logic_vector(8 downto 0);
      ADDRB : in  std_logic_vector(8 downto 0);
      CLKA  : in  std_ulogic;
      CLKB  : in  std_ulogic;
      DIA   : in  std_logic_vector(7 downto 0);
      DIB   : in  std_logic_vector(7 downto 0);
      ENA   : in  std_ulogic;
      ENB   : in  std_ulogic;
      RSTA  : in  std_ulogic;
      RSTB  : in  std_ulogic;
      WEA   : in  std_ulogic;
      WEB   : in  std_ulogic
      );
  end component; 
attribute syn_black_box of RAMB4_S8_S8 : component is true;

  component ROC
    generic (
      WIDTH :     time       := 100 ns
      );
    
    port (
      O        : out std_ulogic := '1'
      );
  end component;
attribute syn_black_box of ROC : component is true;

  component ROCBUF
    port(
      O : out std_ulogic;
      
      I     : in  std_ulogic
      );
  end component;
attribute syn_black_box of ROCBUF : component is true;

  component ROM128X1
    generic (
      INIT : bit_vector := X"00000000000000000000000000000000"
      );
  
    port (
      O  : out std_ulogic;
      
      A0 : in  std_ulogic;
      A1 : in  std_ulogic;
      A2 : in  std_ulogic;
      A3 : in  std_ulogic;
      A4 : in  std_ulogic;
      A5 : in  std_ulogic;
      A6 : in  std_ulogic
      );
  end component;
attribute syn_black_box of ROM128X1 : component is true;

  component ROM16X1
    generic (
      INIT : bit_vector := X"0000"
      );
  
    port (
      O  : out std_ulogic;
      
      A0 : in  std_ulogic;
      A1 : in  std_ulogic;
      A2 : in  std_ulogic;
      A3 : in  std_ulogic
      );
  end component;
attribute syn_black_box of ROM16X1 : component is true;

  component ROM256X1
    generic (
      INIT : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000"
      );
  
    port (
      O  : out std_ulogic;
      
      A0 : in  std_ulogic;
      A1 : in  std_ulogic;
      A2 : in  std_ulogic;
      A3 : in  std_ulogic;
      A4 : in  std_ulogic;
      A5 : in  std_ulogic;
      A6 : in  std_ulogic;
      A7 : in  std_ulogic
      );
  end component;
attribute syn_black_box of ROM256X1 : component is true;

  component ROM32X1
    generic (
      INIT : bit_vector := X"00000000"
      );
  
    port (
      O  : out std_ulogic;
      
      A0 : in  std_ulogic;
      A1 : in  std_ulogic;
      A2 : in  std_ulogic;
      A3 : in  std_ulogic;
      A4 : in  std_ulogic
      );
  end component;
attribute syn_black_box of ROM32X1 : component is true;

  component ROM64X1
    generic (
      INIT : bit_vector := X"0000000000000000"
      );
  
    port (
      O  : out std_ulogic;
      
      A0 : in  std_ulogic;
      A1 : in  std_ulogic;
      A2 : in  std_ulogic;
      A3 : in  std_ulogic;
      A4 : in  std_ulogic;
      A5 : in  std_ulogic
      );
  end component;
attribute syn_black_box of ROM64X1 : component is true;

  component SRL16
    generic (
      INIT : bit_vector := X"0000"
      );
  
    port (
      Q   : out std_ulogic;
      
      A0  : in  std_ulogic;
      A1  : in  std_ulogic;
      A2  : in  std_ulogic;
      A3  : in  std_ulogic;
      CLK : in  std_ulogic;
      D   : in  std_ulogic
      );
  end component;
attribute syn_black_box of SRL16 : component is true;

  component SRL16_1
    generic (
      INIT : bit_vector := X"0000"
      );
  
    port (
      Q   : out std_ulogic;
      
      A0  : in  std_ulogic;
      A1  : in  std_ulogic;
      A2  : in  std_ulogic;
      A3  : in  std_ulogic;
      CLK : in  std_ulogic;
      D   : in  std_ulogic
      );
  end component;
attribute syn_black_box of SRL16_1 : component is true;

  component SRL16E
    generic (
      INIT : bit_vector := X"0000"
      );
  
    port (
      Q   : out std_ulogic;

      A0  : in  std_ulogic;
      A1  : in  std_ulogic;
      A2  : in  std_ulogic;
      A3  : in  std_ulogic;
      CE  : in  std_ulogic;
      CLK : in  std_ulogic;
      D   : in  std_ulogic
      );
  end component;
attribute syn_black_box of SRL16E : component is true;

  component SRL16E_1
    generic (
      INIT : bit_vector := X"0000"
      );
  
    port (
      Q   : out std_ulogic;
  
      A0  : in  std_ulogic;
      A1  : in  std_ulogic;
      A2  : in  std_ulogic;
      A3  : in  std_ulogic;
      CE  : in  std_ulogic;
      CLK : in  std_ulogic;
      D   : in  std_ulogic
      );
  end component;
attribute syn_black_box of SRL16E_1 : component is true;

  component SRLC16
    generic (
      INIT : bit_vector := X"0000"
      );
  
    port (
      Q   : out std_ulogic;
      Q15 : out std_ulogic;
      
      A0  : in  std_ulogic;
      A1  : in  std_ulogic;
      A2  : in  std_ulogic;
      A3  : in  std_ulogic;
      CLK : in  std_ulogic;
      D   : in  std_ulogic
      );
  end component;
attribute syn_black_box of SRLC16 : component is true;

  component SRLC16_1
    generic (
      INIT : bit_vector := X"0000"
      );
  
    port (
      Q   : out std_ulogic;
      Q15 : out std_ulogic;
  
      A0  : in  std_ulogic;
      A1  : in  std_ulogic;
      A2  : in  std_ulogic;
      A3  : in  std_ulogic;
      CLK : in  std_ulogic;
      D   : in  std_ulogic
      );
  end component;
attribute syn_black_box of SRLC16_1 : component is true;

  component SRLC16E
    generic (
      INIT : bit_vector := X"0000"
      );
  
    port (
      Q   : out std_ulogic;
      Q15 : out std_ulogic;
      
      A0  : in  std_ulogic;
      A1  : in  std_ulogic;
      A2  : in  std_ulogic;
      A3  : in  std_ulogic;
      CE  : in  std_ulogic;
      CLK : in  std_ulogic;
      D   : in  std_ulogic
      );
  end component;
attribute syn_black_box of SRLC16E : component is true;

  component SRLC16E_1
    generic (
      INIT : bit_vector := X"0000"
      );
  
    port (
      Q   : out std_ulogic;
      Q15 : out std_ulogic;
  
      A0  : in  std_ulogic;
      A1  : in  std_ulogic;
      A2  : in  std_ulogic;
      A3  : in  std_ulogic;
      CE  : in  std_ulogic;
      CLK : in  std_ulogic;
      D   : in  std_ulogic
      );
  end component;
attribute syn_black_box of SRLC16E_1 : component is true;

  component STARTBUF_FPGACORE
    port(
      GSROUT : out std_ulogic;
      
      CLKIN  : in  std_ulogic := 'X';
      GSRIN  : in  std_ulogic := 'X'
      );
  end component;
attribute syn_black_box of STARTBUF_FPGACORE : component is true;
attribute syn_noprune of STARTBUF_FPGACORE : component is true;

  component STARTBUF_SPARTAN2
    port(
      GSROUT : out std_ulogic;
      GTSOUT : out std_ulogic;
     
      CLKIN  : in  std_ulogic := 'X';
      GSRIN  : in  std_ulogic := 'X';
      GTSIN  : in  std_ulogic := 'X'
      );
  end component;
attribute syn_black_box of STARTBUF_SPARTAN2 : component is true;
attribute syn_noprune of STARTBUF_SPARTAN2 : component is true;

component STARTBUF_SPARTAN3
-- synopsys translate_off
  generic (
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_GTSIN_GTSOUT : VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_GSRIN_GSROUT : VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_GSRIN : VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_GTSIN : VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLKIN : VitalDelayType01 := (0.000 ns, 0.000 ns)
      );

-- synopsys translate_on
  port(
        GSROUT    : out std_ulogic;                
        GTSOUT    : out std_ulogic;
        CLKIN     : in std_ulogic := 'X';
    GSRIN     : in std_ulogic := 'X';
        GTSIN     : in std_ulogic := 'X'
  );
end component;
attribute syn_black_box of STARTBUF_SPARTAN3 : component is true;
attribute syn_noprune of STARTBUF_SPARTAN3 : component is true;

  component STARTBUF_VIRTEX
    port(
      GTSOUT : out std_ulogic;
      GSROUT : out std_ulogic;
      
      CLKIN  : in  std_ulogic := 'X';
      GSRIN  : in  std_ulogic := 'X';
      GTSIN  : in  std_ulogic := 'X'
      );
  end component;
attribute syn_black_box of STARTBUF_VIRTEX : component is true;
attribute syn_noprune of STARTBUF_VIRTEX : component is true;

  component STARTBUF_VIRTEX2
    port(
      GSROUT : out std_ulogic;
      GTSOUT : out std_ulogic;
      
      CLKIN  : in  std_ulogic := 'X';
      GSRIN  : in  std_ulogic := 'X';
      GTSIN  : in  std_ulogic := 'X'
      );
  end component;
attribute syn_black_box of STARTBUF_VIRTEX2 : component is true;
attribute syn_noprune of STARTBUF_VIRTEX2 : component is true;

  component STARTUP_FPGACORE
    port(
      CLK : in std_ulogic := 'X';
      GSR : in std_ulogic := 'X'
      );
  end component;
attribute syn_black_box of STARTUP_FPGACORE : component is true;
attribute syn_noprune of STARTUP_FPGACORE : component is true;

  component STARTUP_SPARTAN2
    port(
      CLK : in std_ulogic := 'X';
      GSR : in std_ulogic := 'X';
      GTS : in std_ulogic := 'X'
      );
  end component;
attribute syn_black_box of STARTUP_SPARTAN2 : component is true;
attribute syn_noprune of STARTUP_SPARTAN2 : component is true;

  component STARTUP_SPARTAN3
    port(
      CLK : in std_ulogic;
      GSR : in std_ulogic;
      GTS : in std_ulogic
      );
  end component;
attribute syn_black_box of STARTUP_SPARTAN3 : component is true;
attribute syn_noprune of STARTUP_SPARTAN3 : component is true;


  component STARTUP_VIRTEX
    port(
      CLK : in std_ulogic := 'X';
      GSR : in std_ulogic := 'X';
      GTS : in std_ulogic := 'X'
      );
  end component;
attribute syn_black_box of STARTUP_VIRTEX : component is true;
attribute syn_noprune of STARTUP_VIRTEX : component is true;

  component STARTUP_VIRTEX2
    port(
      CLK : in std_ulogic := 'X';
      GSR : in std_ulogic := 'X';
      GTS : in std_ulogic := 'X'
      );
  end component;
attribute syn_black_box of STARTUP_VIRTEX2 : component is true;
attribute syn_noprune of STARTUP_VIRTEX2: component is true;

  component TBLOCK
  end component;
attribute syn_black_box of TBLOCK : component is true;

  component TIMEGRP
  end component;
attribute syn_black_box of TIMEGRP : component is true;

  component TIMESPEC
  end component;
attribute syn_black_box of TIMESPEC : component is true;

  component TOC
    generic (
      WIDTH : time := 100 ns
      );
  
    port(
      O : out std_ulogic := '0'
      );
  end component;
attribute syn_black_box of TOC : component is true;

  component TOCBUF
    port(
      O : out std_ulogic;
      
      I : in  std_ulogic
      );
  end component;
attribute syn_black_box of TOCBUF : component is true;

  component USR_ACCESS_VIRTEX4
    port(
      DATA	: out std_logic_vector(31 downto 0);
      DATAVALID	: out std_ulogic
      );
  end component;
attribute syn_black_box of USR_ACCESS_VIRTEX4 : component is true;

  component VCC
    port(
      P : out std_ulogic := '1'
      );
  end component;
attribute syn_black_box of VCC : component is true;
attribute syn_noprune of VCC : component is true;

  component WIREAND
    port(
      I : in std_ulogic
      );
  end component;
attribute syn_black_box of WIREAND : component is true;

  component XNOR2
    port(
      O  : out std_ulogic;
      
      I0 : in  std_ulogic;
      I1 : in  std_ulogic
      );
  end component;
attribute syn_black_box of XNOR2 : component is true;

  component XNOR3
    port(
      O  : out std_ulogic;
      
      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic
      );
  end component;
attribute syn_black_box of XNOR3 : component is true;

  component XNOR4
    port(
      O  : out std_ulogic;
      
      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic
      );
  end component;
attribute syn_black_box of XNOR4 : component is true;

  component XNOR5
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic;
      I4 : in  std_ulogic
      );
  end component;
attribute syn_black_box of XNOR5 : component is true;

  component XOR2
    port(
      O  : out std_ulogic;

      I0 : in  std_ulogic;
      I1 : in  std_ulogic
      );
  end component;
attribute syn_black_box of XOR2 : component is true;

  component XOR3
    port(
      O  : out std_ulogic;
      
      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic
      );
  end component;
attribute syn_black_box of XOR3 : component is true;

  component XOR4
    port(
      O  : out std_ulogic;
      
      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic
      );
  end component;
attribute syn_black_box of XOR4 : component is true;

  component XOR5
    port(
      O  : out std_ulogic;
      
      I0 : in  std_ulogic;
      I1 : in  std_ulogic;
      I2 : in  std_ulogic;
      I3 : in  std_ulogic;
      I4 : in  std_ulogic
      );
  end component;
attribute syn_black_box of XOR5 : component is true;

  component XORCY
    port(
      O  : out std_ulogic;
      
      CI : in  std_ulogic;
      LI : in  std_ulogic
      );
  end component;
attribute syn_black_box of XORCY : component is true;

  component XORCY_D
    port(
      LO : out std_ulogic;
      O  : out std_ulogic;

      CI : in  std_ulogic;
      LI : in  std_ulogic
      );
  end component;
attribute syn_black_box of XORCY_D : component is true;

  component XORCY_L
    port(
      LO : out std_ulogic;

      CI : in  std_ulogic;
      LI : in  std_ulogic
      );
  end component;
attribute syn_black_box of XORCY_L : component is true;

component GT10

generic (
-- synopsys translate_off
        TimingChecksOn : boolean := TRUE;
        InstancePath   : string  := "*";
        Xon            : boolean := TRUE;
        MsgOn          : boolean := FALSE;
-- synopsys translate_on
		ALIGN_COMMA_WORD : integer := 1;
		CHAN_BOND_LIMIT : integer := 16;
		CHAN_BOND_MODE : string := "OFF";
		CHAN_BOND_ONE_SHOT : boolean := FALSE;
		CHAN_BOND_SEQ_1_1 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_1_2 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_1_3 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_1_4 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_1_MASK : bit_vector := "0000";
		CHAN_BOND_SEQ_2_1 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_2_2 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_2_3 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_2_4 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_2_MASK : bit_vector := "0000";
		CHAN_BOND_SEQ_2_USE : boolean := FALSE;
		CHAN_BOND_SEQ_LEN : integer := 1;
		CHAN_BOND_64B66B_SV : boolean := FALSE;
		CLK_COR_8B10B_DE : boolean := FALSE;
		CLK_COR_MAX_LAT : integer := 36;
		CLK_COR_MIN_LAT : integer := 28;
		CLK_COR_SEQ_1_1 : bit_vector := "00000000000";
		CLK_COR_SEQ_1_2 : bit_vector := "00000000000";
		CLK_COR_SEQ_1_3 : bit_vector := "00000000000";
		CLK_COR_SEQ_1_4 : bit_vector := "00000000000";
		CLK_COR_SEQ_1_MASK : bit_vector := "0000";
		CLK_COR_SEQ_2_1 : bit_vector := "00000000000";
		CLK_COR_SEQ_2_2 : bit_vector := "00000000000";
		CLK_COR_SEQ_2_3 : bit_vector := "00000000000";
		CLK_COR_SEQ_2_4 : bit_vector := "00000000000";
		CLK_COR_SEQ_2_MASK : bit_vector := "0000";
		CLK_COR_SEQ_2_USE : boolean := FALSE;
		CLK_COR_SEQ_DROP : boolean := FALSE;
		CLK_COR_SEQ_LEN : integer := 1;
		CLK_CORRECT_USE : boolean := TRUE;
		COMMA_10B_MASK : bit_vector := "0001111111";
		DEC_MCOMMA_DETECT : boolean := TRUE;
		DEC_PCOMMA_DETECT : boolean := TRUE;
		DEC_VALID_COMMA_ONLY : boolean := TRUE;
		MCOMMA_10B_VALUE : bit_vector := "1010000011";
		MCOMMA_DETECT : boolean := TRUE;
		PCOMMA_10B_VALUE : bit_vector := "0101111100";
		PCOMMA_DETECT : boolean := TRUE;
		PMA_PWR_CNTRL : bit_vector := "11111111";
		PMA_SPEED : string := "0_32";
		RX_BUFFER_USE : boolean := TRUE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		SH_CNT_MAX : integer := 64;
		SH_INVALID_CNT_MAX : integer := 16;
		TX_BUFFER_USE : boolean := TRUE

  );


port (
		CHBONDDONE : out std_ulogic;
		CHBONDO : out std_logic_vector(4 downto 0);
		PMARXLOCK : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(7 downto 0);
		RXCHARISK : out std_logic_vector(7 downto 0);
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXDATA : out std_logic_vector(63 downto 0);
		RXDISPERR : out std_logic_vector(7 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(7 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(7 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(7 downto 0);
		TXN : out std_ulogic;
		TXOUTCLK : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(7 downto 0);

		BREFCLKNIN : in std_ulogic;
		BREFCLKPIN : in std_ulogic;
		CHBONDI : in std_logic_vector(4 downto 0);
		ENCHANSYNC : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		PMAINIT : in std_ulogic;
		PMAREGADDR : in std_logic_vector(5 downto 0);
		PMAREGDATAIN : in std_logic_vector(7 downto 0);
		PMAREGRW : in std_ulogic;
		PMAREGSTROBE : in std_ulogic;
		PMARXLOCKSEL : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK : in std_ulogic;
		REFCLK2 : in std_ulogic;
		REFCLKBSEL : in std_ulogic;
		REFCLKSEL : in std_ulogic;
		RXBLOCKSYNC64B66BUSE : in std_ulogic;
		RXCOMMADETUSE : in std_ulogic;
		RXDATAWIDTH : in std_logic_vector(1 downto 0);
		RXDEC64B66BUSE : in std_ulogic;
		RXDEC8B10BUSE : in std_ulogic;
		RXDESCRAM64B66BUSE : in std_ulogic;
		RXIGNOREBTF : in std_ulogic;
		RXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXSLIDE : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(7 downto 0);
		TXCHARDISPMODE : in std_logic_vector(7 downto 0);
		TXCHARDISPVAL : in std_logic_vector(7 downto 0);
		TXCHARISK : in std_logic_vector(7 downto 0);
		TXDATA : in std_logic_vector(63 downto 0);
		TXDATAWIDTH : in std_logic_vector(1 downto 0);
		TXENC64B66BUSE : in std_ulogic;
		TXENC8B10BUSE : in std_ulogic;
		TXGEARBOX64B66BUSE : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXSCRAM64B66BUSE : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT10 : component is true;
attribute black_box_pad_pin of GT10 : component is "RXN,RXP,TXN,TXP";

component GT10_10GE_4

generic (
		CHAN_BOND_LIMIT : integer := 16;
		CHAN_BOND_MODE : string := "OFF";
		CHAN_BOND_ONE_SHOT : boolean := FALSE;
		CHAN_BOND_SEQ_1_MASK : bit_vector := "0000";
		CHAN_BOND_SEQ_2_MASK : bit_vector := "0000";
		CHAN_BOND_SEQ_2_USE : boolean := TRUE;
		CHAN_BOND_64B66B_SV : boolean := FALSE;
		CLK_COR_MAX_LAT : integer := 36;
		CLK_COR_MIN_LAT : integer := 28;
		CLK_COR_SEQ_1_MASK : bit_vector := "0000";
		CLK_COR_SEQ_2_MASK : bit_vector := "0000";
		CLK_COR_SEQ_2_USE : boolean := TRUE;
		CLK_COR_SEQ_DROP : boolean := FALSE;
		CLK_CORRECT_USE : boolean := TRUE;
		PMA_PWR_CNTRL : bit_vector := "11111111";
		RX_BUFFER_USE : boolean := TRUE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		SH_CNT_MAX : integer := 64;
		SH_INVALID_CNT_MAX : integer := 16;
		TX_BUFFER_USE : boolean := TRUE

  );


port (
		CHBONDDONE : out std_ulogic;
		CHBONDO : out std_logic_vector(4 downto 0);
		PMARXLOCK : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(3 downto 0);
		RXCHARISK : out std_logic_vector(3 downto 0);
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXDATA : out std_logic_vector(31 downto 0);
		RXDISPERR : out std_logic_vector(3 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(3 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(3 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(3 downto 0);
		TXN : out std_ulogic;
		TXOUTCLK : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(3 downto 0);

		BREFCLKNIN : in std_ulogic;
		BREFCLKPIN : in std_ulogic;
		CHBONDI : in std_logic_vector(4 downto 0);
		ENCHANSYNC : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		PMAINIT : in std_ulogic;
		PMAREGADDR : in std_logic_vector(5 downto 0);
		PMAREGDATAIN : in std_logic_vector(7 downto 0);
		PMAREGRW : in std_ulogic;
		PMAREGSTROBE : in std_ulogic;
		PMARXLOCKSEL : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK : in std_ulogic;
		REFCLK2 : in std_ulogic;
		REFCLKBSEL : in std_ulogic;
		REFCLKSEL : in std_ulogic;
		RXBLOCKSYNC64B66BUSE : in std_ulogic;
		RXCOMMADETUSE : in std_ulogic;
		RXDATAWIDTH : in std_logic_vector(1 downto 0);
		RXDEC64B66BUSE : in std_ulogic;
		RXDEC8B10BUSE : in std_ulogic;
		RXDESCRAM64B66BUSE : in std_ulogic;
		RXIGNOREBTF : in std_ulogic;
		RXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXSLIDE : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(3 downto 0);
		TXCHARDISPMODE : in std_logic_vector(3 downto 0);
		TXCHARDISPVAL : in std_logic_vector(3 downto 0);
		TXCHARISK : in std_logic_vector(3 downto 0);
		TXDATA : in std_logic_vector(31 downto 0);
		TXDATAWIDTH : in std_logic_vector(1 downto 0);
		TXENC64B66BUSE : in std_ulogic;
		TXENC8B10BUSE : in std_ulogic;
		TXGEARBOX64B66BUSE : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXSCRAM64B66BUSE : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT10_10GE_4 : component is true;
attribute black_box_pad_pin of GT10_10GE_4 : component is "RXN,RXP,TXN,TXP";

component GT10_10GE_8
generic (
		CHAN_BOND_LIMIT : integer := 16;
		CHAN_BOND_MODE : string := "OFF";
		CHAN_BOND_ONE_SHOT : boolean := FALSE;
		CHAN_BOND_SEQ_1_MASK : bit_vector := "0000";
		CHAN_BOND_SEQ_2_MASK : bit_vector := "0000";
		CHAN_BOND_SEQ_2_USE : boolean := TRUE;
		CHAN_BOND_64B66B_SV : boolean := FALSE;
		CLK_COR_MAX_LAT : integer := 36;
		CLK_COR_MIN_LAT : integer := 28;
		CLK_COR_SEQ_1_MASK : bit_vector := "0000";
		CLK_COR_SEQ_2_MASK : bit_vector := "0000";
		CLK_COR_SEQ_2_USE : boolean := TRUE;
		CLK_COR_SEQ_DROP : boolean := FALSE;
		CLK_CORRECT_USE : boolean := TRUE;
		PMA_PWR_CNTRL : bit_vector := "11111111";
		RX_BUFFER_USE : boolean := TRUE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		SH_CNT_MAX : integer := 64;
		SH_INVALID_CNT_MAX : integer := 16;
		TX_BUFFER_USE : boolean := TRUE

  );

port (
		CHBONDDONE : out std_ulogic;
		CHBONDO : out std_logic_vector(4 downto 0);
		PMARXLOCK : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(7 downto 0);
		RXCHARISK : out std_logic_vector(7 downto 0);
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXDATA : out std_logic_vector(63 downto 0);
		RXDISPERR : out std_logic_vector(7 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(7 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(7 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(7 downto 0);
		TXN : out std_ulogic;
		TXOUTCLK : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(7 downto 0);

		BREFCLKNIN : in std_ulogic;
		BREFCLKPIN : in std_ulogic;
		CHBONDI : in std_logic_vector(4 downto 0);
		ENCHANSYNC : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		PMAINIT : in std_ulogic;
		PMAREGADDR : in std_logic_vector(5 downto 0);
		PMAREGDATAIN : in std_logic_vector(7 downto 0);
		PMAREGRW : in std_ulogic;
		PMAREGSTROBE : in std_ulogic;
		PMARXLOCKSEL : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK : in std_ulogic;
		REFCLK2 : in std_ulogic;
		REFCLKBSEL : in std_ulogic;
		REFCLKSEL : in std_ulogic;
		RXBLOCKSYNC64B66BUSE : in std_ulogic;
		RXCOMMADETUSE : in std_ulogic;
		RXDATAWIDTH : in std_logic_vector(1 downto 0);
		RXDEC64B66BUSE : in std_ulogic;
		RXDEC8B10BUSE : in std_ulogic;
		RXDESCRAM64B66BUSE : in std_ulogic;
		RXIGNOREBTF : in std_ulogic;
		RXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXSLIDE : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(7 downto 0);
		TXCHARDISPMODE : in std_logic_vector(7 downto 0);
		TXCHARDISPVAL : in std_logic_vector(7 downto 0);
		TXCHARISK : in std_logic_vector(7 downto 0);
		TXDATA : in std_logic_vector(63 downto 0);
		TXDATAWIDTH : in std_logic_vector(1 downto 0);
		TXENC64B66BUSE : in std_ulogic;
		TXENC8B10BUSE : in std_ulogic;
		TXGEARBOX64B66BUSE : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXSCRAM64B66BUSE : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT10_10GE_8 : component is true;
attribute black_box_pad_pin of GT10_10GE_8 : component is "RXN,RXP,TXN,TXP";

component GT10_10GFC_4
generic (
		CHAN_BOND_LIMIT : integer := 16;
		CHAN_BOND_MODE : string := "OFF";
		CHAN_BOND_ONE_SHOT : boolean := FALSE;
		CHAN_BOND_SEQ_1_MASK : bit_vector := "0000";
		CHAN_BOND_SEQ_2_MASK : bit_vector := "0000";
		CHAN_BOND_SEQ_2_USE : boolean := TRUE;
		CHAN_BOND_64B66B_SV : boolean := FALSE;
		CLK_COR_MAX_LAT : integer := 36;
		CLK_COR_MIN_LAT : integer := 28;
		CLK_COR_SEQ_1_MASK : bit_vector := "0000";
		CLK_COR_SEQ_2_MASK : bit_vector := "0000";
		CLK_COR_SEQ_2_USE : boolean := TRUE;
		CLK_COR_SEQ_DROP : boolean := FALSE;
		CLK_CORRECT_USE : boolean := TRUE;
		PMA_PWR_CNTRL : bit_vector := "11111111";
		RX_BUFFER_USE : boolean := TRUE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		SH_CNT_MAX : integer := 64;
		SH_INVALID_CNT_MAX : integer := 16;
		TX_BUFFER_USE : boolean := TRUE

  );

port (
		CHBONDDONE : out std_ulogic;
		CHBONDO : out std_logic_vector(4 downto 0);
		PMARXLOCK : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(3 downto 0);
		RXCHARISK : out std_logic_vector(3 downto 0);
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXDATA : out std_logic_vector(31 downto 0);
		RXDISPERR : out std_logic_vector(3 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(3 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(3 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(3 downto 0);
		TXN : out std_ulogic;
		TXOUTCLK : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(3 downto 0);

		BREFCLKNIN : in std_ulogic;
		BREFCLKPIN : in std_ulogic;
		CHBONDI : in std_logic_vector(4 downto 0);
		ENCHANSYNC : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		PMAINIT : in std_ulogic;
		PMAREGADDR : in std_logic_vector(5 downto 0);
		PMAREGDATAIN : in std_logic_vector(7 downto 0);
		PMAREGRW : in std_ulogic;
		PMAREGSTROBE : in std_ulogic;
		PMARXLOCKSEL : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK : in std_ulogic;
		REFCLK2 : in std_ulogic;
		REFCLKBSEL : in std_ulogic;
		REFCLKSEL : in std_ulogic;
		RXBLOCKSYNC64B66BUSE : in std_ulogic;
		RXCOMMADETUSE : in std_ulogic;
		RXDATAWIDTH : in std_logic_vector(1 downto 0);
		RXDEC64B66BUSE : in std_ulogic;
		RXDEC8B10BUSE : in std_ulogic;
		RXDESCRAM64B66BUSE : in std_ulogic;
		RXIGNOREBTF : in std_ulogic;
		RXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXSLIDE : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(3 downto 0);
		TXCHARDISPMODE : in std_logic_vector(3 downto 0);
		TXCHARDISPVAL : in std_logic_vector(3 downto 0);
		TXCHARISK : in std_logic_vector(3 downto 0);
		TXDATA : in std_logic_vector(31 downto 0);
		TXDATAWIDTH : in std_logic_vector(1 downto 0);
		TXENC64B66BUSE : in std_ulogic;
		TXENC8B10BUSE : in std_ulogic;
		TXGEARBOX64B66BUSE : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXSCRAM64B66BUSE : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT10_10GFC_4 : component is true;
attribute black_box_pad_pin of GT10_10GFC_4 : component is "RXN,RXP,TXN,TXP";

component GT10_10GFC_8
generic (
		CHAN_BOND_LIMIT : integer := 16;
		CHAN_BOND_MODE : string := "OFF";
		CHAN_BOND_ONE_SHOT : boolean := FALSE;
		CHAN_BOND_SEQ_1_MASK : bit_vector := "0000";
		CHAN_BOND_SEQ_2_MASK : bit_vector := "0000";
		CHAN_BOND_SEQ_2_USE : boolean := TRUE;
		CHAN_BOND_64B66B_SV : boolean := FALSE;
		CLK_COR_MAX_LAT : integer := 36;
		CLK_COR_MIN_LAT : integer := 28;
		CLK_COR_SEQ_1_MASK : bit_vector := "0000";
		CLK_COR_SEQ_2_MASK : bit_vector := "0000";
		CLK_COR_SEQ_2_USE : boolean := TRUE;
		CLK_COR_SEQ_DROP : boolean := FALSE;
		CLK_CORRECT_USE : boolean := TRUE;
		PMA_PWR_CNTRL : bit_vector := "11111111";
		RX_BUFFER_USE : boolean := TRUE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		SH_CNT_MAX : integer := 64;
		SH_INVALID_CNT_MAX : integer := 16;
		TX_BUFFER_USE : boolean := TRUE

  );

port (
		CHBONDDONE : out std_ulogic;
		CHBONDO : out std_logic_vector(4 downto 0);
		PMARXLOCK : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(7 downto 0);
		RXCHARISK : out std_logic_vector(7 downto 0);
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXDATA : out std_logic_vector(63 downto 0);
		RXDISPERR : out std_logic_vector(7 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(7 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(7 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(7 downto 0);
		TXN : out std_ulogic;
		TXOUTCLK : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(7 downto 0);

		BREFCLKNIN : in std_ulogic;
		BREFCLKPIN : in std_ulogic;
		CHBONDI : in std_logic_vector(4 downto 0);
		ENCHANSYNC : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		PMAINIT : in std_ulogic;
		PMAREGADDR : in std_logic_vector(5 downto 0);
		PMAREGDATAIN : in std_logic_vector(7 downto 0);
		PMAREGRW : in std_ulogic;
		PMAREGSTROBE : in std_ulogic;
		PMARXLOCKSEL : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK : in std_ulogic;
		REFCLK2 : in std_ulogic;
		REFCLKBSEL : in std_ulogic;
		REFCLKSEL : in std_ulogic;
		RXBLOCKSYNC64B66BUSE : in std_ulogic;
		RXCOMMADETUSE : in std_ulogic;
		RXDATAWIDTH : in std_logic_vector(1 downto 0);
		RXDEC64B66BUSE : in std_ulogic;
		RXDEC8B10BUSE : in std_ulogic;
		RXDESCRAM64B66BUSE : in std_ulogic;
		RXIGNOREBTF : in std_ulogic;
		RXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXSLIDE : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(7 downto 0);
		TXCHARDISPMODE : in std_logic_vector(7 downto 0);
		TXCHARDISPVAL : in std_logic_vector(7 downto 0);
		TXCHARISK : in std_logic_vector(7 downto 0);
		TXDATA : in std_logic_vector(63 downto 0);
		TXDATAWIDTH : in std_logic_vector(1 downto 0);
		TXENC64B66BUSE : in std_ulogic;
		TXENC8B10BUSE : in std_ulogic;
		TXGEARBOX64B66BUSE : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXSCRAM64B66BUSE : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT10_10GFC_8 : component is true;
attribute black_box_pad_pin of GT10_10GFC_8 : component is "RXN,RXP,TXN,TXP";

component GT10_AURORA_1
generic (
		ALIGN_COMMA_WORD : integer := 1;
		CHAN_BOND_LIMIT : integer := 16;
		CHAN_BOND_MODE : string := "OFF";
		CHAN_BOND_ONE_SHOT : boolean := FALSE;
		CHAN_BOND_SEQ_1_MASK : bit_vector := "0000";
		CHAN_BOND_SEQ_2_MASK : bit_vector := "0000";
		CLK_COR_8B10B_DE : boolean := FALSE;
		CLK_COR_MAX_LAT : integer := 36;
		CLK_COR_MIN_LAT : integer := 28;
		CLK_COR_SEQ_1_MASK : bit_vector := "0000";
		CLK_COR_SEQ_2_MASK : bit_vector := "0000";
		CLK_COR_SEQ_DROP : boolean := FALSE;
		CLK_CORRECT_USE : boolean := TRUE;
		PMA_PWR_CNTRL : bit_vector := "11111111";
		RX_BUFFER_USE : boolean := TRUE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		TX_BUFFER_USE : boolean := TRUE

  );

port (
		CHBONDDONE : out std_ulogic;
		CHBONDO : out std_logic_vector(4 downto 0);
		PMARXLOCK : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(0 downto 0);
		RXCHARISK : out std_logic_vector(0 downto 0);
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXDATA : out std_logic_vector(7 downto 0);
		RXDISPERR : out std_logic_vector(0 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(0 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(0 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(0 downto 0);
		TXN : out std_ulogic;
		TXOUTCLK : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(0 downto 0);

		BREFCLKNIN : in std_ulogic;
		BREFCLKPIN : in std_ulogic;
		CHBONDI : in std_logic_vector(4 downto 0);
		ENCHANSYNC : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		PMAINIT : in std_ulogic;
		PMAREGADDR : in std_logic_vector(5 downto 0);
		PMAREGDATAIN : in std_logic_vector(7 downto 0);
		PMAREGRW : in std_ulogic;
		PMAREGSTROBE : in std_ulogic;
		PMARXLOCKSEL : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK : in std_ulogic;
		REFCLK2 : in std_ulogic;
		REFCLKBSEL : in std_ulogic;
		REFCLKSEL : in std_ulogic;
		RXBLOCKSYNC64B66BUSE : in std_ulogic;
		RXCOMMADETUSE : in std_ulogic;
		RXDATAWIDTH : in std_logic_vector(1 downto 0);
		RXDEC64B66BUSE : in std_ulogic;
		RXDEC8B10BUSE : in std_ulogic;
		RXDESCRAM64B66BUSE : in std_ulogic;
		RXIGNOREBTF : in std_ulogic;
		RXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXSLIDE : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(0 downto 0);
		TXCHARDISPMODE : in std_logic_vector(0 downto 0);
		TXCHARDISPVAL : in std_logic_vector(0 downto 0);
		TXCHARISK : in std_logic_vector(0 downto 0);
		TXDATA : in std_logic_vector(7 downto 0);
		TXDATAWIDTH : in std_logic_vector(1 downto 0);
		TXENC64B66BUSE : in std_ulogic;
		TXENC8B10BUSE : in std_ulogic;
		TXGEARBOX64B66BUSE : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXSCRAM64B66BUSE : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT10_AURORA_1 : component is true;
attribute black_box_pad_pin of GT10_AURORA_1 : component is "RXN,RXP,TXN,TXP";

component GT10_AURORA_2
generic (
		ALIGN_COMMA_WORD : integer := 1;
		CHAN_BOND_LIMIT : integer := 16;
		CHAN_BOND_MODE : string := "OFF";
		CHAN_BOND_ONE_SHOT : boolean := FALSE;
		CHAN_BOND_SEQ_1_MASK : bit_vector := "0000";
		CHAN_BOND_SEQ_2_MASK : bit_vector := "0000";
		CLK_COR_8B10B_DE : boolean := FALSE;
		CLK_COR_MAX_LAT : integer := 36;
		CLK_COR_MIN_LAT : integer := 28;
		CLK_COR_SEQ_1_MASK : bit_vector := "0000";
		CLK_COR_SEQ_2_MASK : bit_vector := "0000";
		CLK_COR_SEQ_DROP : boolean := FALSE;
		CLK_CORRECT_USE : boolean := TRUE;
		PMA_PWR_CNTRL : bit_vector := "11111111";
		RX_BUFFER_USE : boolean := TRUE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		TX_BUFFER_USE : boolean := TRUE

  );

port (
		CHBONDDONE : out std_ulogic;
		CHBONDO : out std_logic_vector(4 downto 0);
		PMARXLOCK : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(1 downto 0);
		RXCHARISK : out std_logic_vector(1 downto 0);
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXDATA : out std_logic_vector(15 downto 0);
		RXDISPERR : out std_logic_vector(1 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(1 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(1 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(1 downto 0);
		TXN : out std_ulogic;
		TXOUTCLK : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(1 downto 0);

		BREFCLKNIN : in std_ulogic;
		BREFCLKPIN : in std_ulogic;
		CHBONDI : in std_logic_vector(4 downto 0);
		ENCHANSYNC : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		PMAINIT : in std_ulogic;
		PMAREGADDR : in std_logic_vector(5 downto 0);
		PMAREGDATAIN : in std_logic_vector(7 downto 0);
		PMAREGRW : in std_ulogic;
		PMAREGSTROBE : in std_ulogic;
		PMARXLOCKSEL : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK : in std_ulogic;
		REFCLK2 : in std_ulogic;
		REFCLKBSEL : in std_ulogic;
		REFCLKSEL : in std_ulogic;
		RXBLOCKSYNC64B66BUSE : in std_ulogic;
		RXCOMMADETUSE : in std_ulogic;
		RXDATAWIDTH : in std_logic_vector(1 downto 0);
		RXDEC64B66BUSE : in std_ulogic;
		RXDEC8B10BUSE : in std_ulogic;
		RXDESCRAM64B66BUSE : in std_ulogic;
		RXIGNOREBTF : in std_ulogic;
		RXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXSLIDE : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(1 downto 0);
		TXCHARDISPMODE : in std_logic_vector(1 downto 0);
		TXCHARDISPVAL : in std_logic_vector(1 downto 0);
		TXCHARISK : in std_logic_vector(1 downto 0);
		TXDATA : in std_logic_vector(15 downto 0);
		TXDATAWIDTH : in std_logic_vector(1 downto 0);
		TXENC64B66BUSE : in std_ulogic;
		TXENC8B10BUSE : in std_ulogic;
		TXGEARBOX64B66BUSE : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXSCRAM64B66BUSE : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT10_AURORA_2 : component is true;
attribute black_box_pad_pin of GT10_AURORA_2 : component is "RXN,RXP,TXN,TXP";

component GT10_AURORA_4
generic (
		ALIGN_COMMA_WORD : integer := 1;
		CHAN_BOND_LIMIT : integer := 16;
		CHAN_BOND_MODE : string := "OFF";
		CHAN_BOND_ONE_SHOT : boolean := FALSE;
		CHAN_BOND_SEQ_1_MASK : bit_vector := "0000";
		CHAN_BOND_SEQ_2_MASK : bit_vector := "0000";
		CLK_COR_8B10B_DE : boolean := FALSE;
		CLK_COR_MAX_LAT : integer := 36;
		CLK_COR_MIN_LAT : integer := 28;
		CLK_COR_SEQ_1_MASK : bit_vector := "0000";
		CLK_COR_SEQ_2_MASK : bit_vector := "0000";
		CLK_COR_SEQ_DROP : boolean := FALSE;
		CLK_CORRECT_USE : boolean := TRUE;
		PMA_PWR_CNTRL : bit_vector := "11111111";
		RX_BUFFER_USE : boolean := TRUE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		TX_BUFFER_USE : boolean := TRUE

  );

port (
		CHBONDDONE : out std_ulogic;
		CHBONDO : out std_logic_vector(4 downto 0);
		PMARXLOCK : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(3 downto 0);
		RXCHARISK : out std_logic_vector(3 downto 0);
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXDATA : out std_logic_vector(31 downto 0);
		RXDISPERR : out std_logic_vector(3 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(3 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(3 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(3 downto 0);
		TXN : out std_ulogic;
		TXOUTCLK : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(3 downto 0);

		BREFCLKNIN : in std_ulogic;
		BREFCLKPIN : in std_ulogic;
		CHBONDI : in std_logic_vector(4 downto 0);
		ENCHANSYNC : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		PMAINIT : in std_ulogic;
		PMAREGADDR : in std_logic_vector(5 downto 0);
		PMAREGDATAIN : in std_logic_vector(7 downto 0);
		PMAREGRW : in std_ulogic;
		PMAREGSTROBE : in std_ulogic;
		PMARXLOCKSEL : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK : in std_ulogic;
		REFCLK2 : in std_ulogic;
		REFCLKBSEL : in std_ulogic;
		REFCLKSEL : in std_ulogic;
		RXBLOCKSYNC64B66BUSE : in std_ulogic;
		RXCOMMADETUSE : in std_ulogic;
		RXDATAWIDTH : in std_logic_vector(1 downto 0);
		RXDEC64B66BUSE : in std_ulogic;
		RXDEC8B10BUSE : in std_ulogic;
		RXDESCRAM64B66BUSE : in std_ulogic;
		RXIGNOREBTF : in std_ulogic;
		RXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXSLIDE : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(3 downto 0);
		TXCHARDISPMODE : in std_logic_vector(3 downto 0);
		TXCHARDISPVAL : in std_logic_vector(3 downto 0);
		TXCHARISK : in std_logic_vector(3 downto 0);
		TXDATA : in std_logic_vector(31 downto 0);
		TXDATAWIDTH : in std_logic_vector(1 downto 0);
		TXENC64B66BUSE : in std_ulogic;
		TXENC8B10BUSE : in std_ulogic;
		TXGEARBOX64B66BUSE : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXSCRAM64B66BUSE : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT10_AURORA_4 : component is true;
attribute black_box_pad_pin of GT10_AURORA_4 : component is "RXN,RXP,TXN,TXP";

component GT10_AURORAX_4
generic (
		CHAN_BOND_LIMIT : integer := 16;
		CHAN_BOND_MODE : string := "OFF";
		CHAN_BOND_ONE_SHOT : boolean := FALSE;
		CHAN_BOND_SEQ_1_MASK : bit_vector := "0000";
		CHAN_BOND_SEQ_2_MASK : bit_vector := "0000";
		CHAN_BOND_64B66B_SV : boolean := FALSE;
		CLK_COR_MAX_LAT : integer := 36;
		CLK_COR_MIN_LAT : integer := 28;
		CLK_COR_SEQ_1_MASK : bit_vector := "0000";
		CLK_COR_SEQ_2_MASK : bit_vector := "0000";
		CLK_COR_SEQ_DROP : boolean := FALSE;
		CLK_CORRECT_USE : boolean := TRUE;
		PMA_PWR_CNTRL : bit_vector := "11111111";
		RX_BUFFER_USE : boolean := TRUE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		SH_CNT_MAX : integer := 64;
		SH_INVALID_CNT_MAX : integer := 16;
		TX_BUFFER_USE : boolean := TRUE

  );

port (
		CHBONDDONE : out std_ulogic;
		CHBONDO : out std_logic_vector(4 downto 0);
		PMARXLOCK : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(3 downto 0);
		RXCHARISK : out std_logic_vector(3 downto 0);
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXDATA : out std_logic_vector(31 downto 0);
		RXDISPERR : out std_logic_vector(3 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(3 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(3 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(3 downto 0);
		TXN : out std_ulogic;
		TXOUTCLK : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(3 downto 0);

		BREFCLKNIN : in std_ulogic;
		BREFCLKPIN : in std_ulogic;
		CHBONDI : in std_logic_vector(4 downto 0);
		ENCHANSYNC : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		PMAINIT : in std_ulogic;
		PMAREGADDR : in std_logic_vector(5 downto 0);
		PMAREGDATAIN : in std_logic_vector(7 downto 0);
		PMAREGRW : in std_ulogic;
		PMAREGSTROBE : in std_ulogic;
		PMARXLOCKSEL : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK : in std_ulogic;
		REFCLK2 : in std_ulogic;
		REFCLKBSEL : in std_ulogic;
		REFCLKSEL : in std_ulogic;
		RXBLOCKSYNC64B66BUSE : in std_ulogic;
		RXCOMMADETUSE : in std_ulogic;
		RXDATAWIDTH : in std_logic_vector(1 downto 0);
		RXDEC64B66BUSE : in std_ulogic;
		RXDEC8B10BUSE : in std_ulogic;
		RXDESCRAM64B66BUSE : in std_ulogic;
		RXIGNOREBTF : in std_ulogic;
		RXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXSLIDE : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(3 downto 0);
		TXCHARDISPMODE : in std_logic_vector(3 downto 0);
		TXCHARDISPVAL : in std_logic_vector(3 downto 0);
		TXCHARISK : in std_logic_vector(3 downto 0);
		TXDATA : in std_logic_vector(31 downto 0);
		TXDATAWIDTH : in std_logic_vector(1 downto 0);
		TXENC64B66BUSE : in std_ulogic;
		TXENC8B10BUSE : in std_ulogic;
		TXGEARBOX64B66BUSE : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXSCRAM64B66BUSE : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT10_AURORAX_4 : component is true;
attribute black_box_pad_pin of GT10_AURORAX_4 : component is "RXN,RXP,TXN,TXP";

component GT10_AURORAX_8
generic (
		CHAN_BOND_LIMIT : integer := 16;
		CHAN_BOND_MODE : string := "OFF";
		CHAN_BOND_ONE_SHOT : boolean := FALSE;
		CHAN_BOND_SEQ_1_MASK : bit_vector := "0000";
		CHAN_BOND_SEQ_2_MASK : bit_vector := "0000";
		CHAN_BOND_64B66B_SV : boolean := FALSE;
		CLK_COR_MAX_LAT : integer := 36;
		CLK_COR_MIN_LAT : integer := 28;
		CLK_COR_SEQ_1_MASK : bit_vector := "0000";
		CLK_COR_SEQ_2_MASK : bit_vector := "0000";
		CLK_COR_SEQ_DROP : boolean := FALSE;
		CLK_CORRECT_USE : boolean := TRUE;
		PMA_PWR_CNTRL : bit_vector := "11111111";
		RX_BUFFER_USE : boolean := TRUE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		SH_CNT_MAX : integer := 64;
		SH_INVALID_CNT_MAX : integer := 16;
		TX_BUFFER_USE : boolean := TRUE

  );

port (
		CHBONDDONE : out std_ulogic;
		CHBONDO : out std_logic_vector(4 downto 0);
		PMARXLOCK : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(7 downto 0);
		RXCHARISK : out std_logic_vector(7 downto 0);
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXDATA : out std_logic_vector(63 downto 0);
		RXDISPERR : out std_logic_vector(7 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(7 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(7 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(7 downto 0);
		TXN : out std_ulogic;
		TXOUTCLK : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(7 downto 0);

		BREFCLKNIN : in std_ulogic;
		BREFCLKPIN : in std_ulogic;
		CHBONDI : in std_logic_vector(4 downto 0);
		ENCHANSYNC : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		PMAINIT : in std_ulogic;
		PMAREGADDR : in std_logic_vector(5 downto 0);
		PMAREGDATAIN : in std_logic_vector(7 downto 0);
		PMAREGRW : in std_ulogic;
		PMAREGSTROBE : in std_ulogic;
		PMARXLOCKSEL : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK : in std_ulogic;
		REFCLK2 : in std_ulogic;
		REFCLKBSEL : in std_ulogic;
		REFCLKSEL : in std_ulogic;
		RXBLOCKSYNC64B66BUSE : in std_ulogic;
		RXCOMMADETUSE : in std_ulogic;
		RXDATAWIDTH : in std_logic_vector(1 downto 0);
		RXDEC64B66BUSE : in std_ulogic;
		RXDEC8B10BUSE : in std_ulogic;
		RXDESCRAM64B66BUSE : in std_ulogic;
		RXIGNOREBTF : in std_ulogic;
		RXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXSLIDE : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(7 downto 0);
		TXCHARDISPMODE : in std_logic_vector(7 downto 0);
		TXCHARDISPVAL : in std_logic_vector(7 downto 0);
		TXCHARISK : in std_logic_vector(7 downto 0);
		TXDATA : in std_logic_vector(63 downto 0);
		TXDATAWIDTH : in std_logic_vector(1 downto 0);
		TXENC64B66BUSE : in std_ulogic;
		TXENC8B10BUSE : in std_ulogic;
		TXGEARBOX64B66BUSE : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXSCRAM64B66BUSE : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT10_AURORAX_8 : component is true;
attribute black_box_pad_pin of GT10_AURORAX_8 : component is "RXN,RXP,TXN,TXP";

component GT10_CUSTOM
generic (
		ALIGN_COMMA_WORD : integer := 1;
		CHAN_BOND_LIMIT : integer := 16;
		CHAN_BOND_MODE : string := "OFF";
		CHAN_BOND_ONE_SHOT : boolean := FALSE;
		CHAN_BOND_SEQ_1_1 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_1_2 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_1_3 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_1_4 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_1_MASK : bit_vector := "0000";
		CHAN_BOND_SEQ_2_1 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_2_2 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_2_3 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_2_4 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_2_MASK : bit_vector := "0000";
		CHAN_BOND_SEQ_2_USE : boolean := FALSE;
		CHAN_BOND_SEQ_LEN : integer := 1;
		CHAN_BOND_64B66B_SV : boolean := FALSE;
		CLK_COR_8B10B_DE : boolean := FALSE;
		CLK_COR_MAX_LAT : integer := 36;
		CLK_COR_MIN_LAT : integer := 28;
		CLK_COR_SEQ_1_1 : bit_vector := "00000000000";
		CLK_COR_SEQ_1_2 : bit_vector := "00000000000";
		CLK_COR_SEQ_1_3 : bit_vector := "00000000000";
		CLK_COR_SEQ_1_4 : bit_vector := "00000000000";
		CLK_COR_SEQ_1_MASK : bit_vector := "0000";
		CLK_COR_SEQ_2_1 : bit_vector := "00000000000";
		CLK_COR_SEQ_2_2 : bit_vector := "00000000000";
		CLK_COR_SEQ_2_3 : bit_vector := "00000000000";
		CLK_COR_SEQ_2_4 : bit_vector := "00000000000";
		CLK_COR_SEQ_2_MASK : bit_vector := "0000";
		CLK_COR_SEQ_2_USE : boolean := FALSE;
		CLK_COR_SEQ_DROP : boolean := FALSE;
		CLK_COR_SEQ_LEN : integer := 1;
		CLK_CORRECT_USE : boolean := TRUE;
		COMMA_10B_MASK : bit_vector := "0001111111";
		DEC_MCOMMA_DETECT : boolean := TRUE;
		DEC_PCOMMA_DETECT : boolean := TRUE;
		DEC_VALID_COMMA_ONLY : boolean := TRUE;
		MCOMMA_10B_VALUE : bit_vector := "1010000011";
		MCOMMA_DETECT : boolean := TRUE;
		PCOMMA_10B_VALUE : bit_vector := "0101111100";
		PCOMMA_DETECT : boolean := TRUE;
		PMA_PWR_CNTRL : bit_vector := "11111111";
		PMA_SPEED : string := "0_32";
		RX_BUFFER_USE : boolean := TRUE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		SH_CNT_MAX : integer := 64;
		SH_INVALID_CNT_MAX : integer := 16;
		TX_BUFFER_USE : boolean := TRUE

  );

port (
		CHBONDDONE : out std_ulogic;
		CHBONDO : out std_logic_vector(4 downto 0);
		PMARXLOCK : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(7 downto 0);
		RXCHARISK : out std_logic_vector(7 downto 0);
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXDATA : out std_logic_vector(63 downto 0);
		RXDISPERR : out std_logic_vector(7 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(7 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(7 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(7 downto 0);
		TXN : out std_ulogic;
		TXOUTCLK : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(7 downto 0);

		BREFCLKNIN : in std_ulogic;
		BREFCLKPIN : in std_ulogic;
		CHBONDI : in std_logic_vector(4 downto 0);
		ENCHANSYNC : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		PMAINIT : in std_ulogic;
		PMAREGADDR : in std_logic_vector(5 downto 0);
		PMAREGDATAIN : in std_logic_vector(7 downto 0);
		PMAREGRW : in std_ulogic;
		PMAREGSTROBE : in std_ulogic;
		PMARXLOCKSEL : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK : in std_ulogic;
		REFCLK2 : in std_ulogic;
		REFCLKBSEL : in std_ulogic;
		REFCLKSEL : in std_ulogic;
		RXBLOCKSYNC64B66BUSE : in std_ulogic;
		RXCOMMADETUSE : in std_ulogic;
		RXDATAWIDTH : in std_logic_vector(1 downto 0);
		RXDEC64B66BUSE : in std_ulogic;
		RXDEC8B10BUSE : in std_ulogic;
		RXDESCRAM64B66BUSE : in std_ulogic;
		RXIGNOREBTF : in std_ulogic;
		RXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXSLIDE : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(7 downto 0);
		TXCHARDISPMODE : in std_logic_vector(7 downto 0);
		TXCHARDISPVAL : in std_logic_vector(7 downto 0);
		TXCHARISK : in std_logic_vector(7 downto 0);
		TXDATA : in std_logic_vector(63 downto 0);
		TXDATAWIDTH : in std_logic_vector(1 downto 0);
		TXENC64B66BUSE : in std_ulogic;
		TXENC8B10BUSE : in std_ulogic;
		TXGEARBOX64B66BUSE : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXSCRAM64B66BUSE : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT10_CUSTOM : component is true;
attribute black_box_pad_pin of GT10_CUSTOM : component is "RXN,RXP,TXN,TXP";

component GT10_INFINIBAND_1
generic (
		ALIGN_COMMA_WORD : integer := 2;
		CHAN_BOND_LIMIT : integer := 16;
		CHAN_BOND_MODE : string := "OFF";
		CHAN_BOND_ONE_SHOT : boolean := FALSE;
		CHAN_BOND_SEQ_1_MASK : bit_vector := "0000";
		CHAN_BOND_SEQ_2_MASK : bit_vector := "0000";
		CHAN_BOND_SEQ_LEN : integer := 2;
		CLK_COR_8B10B_DE : boolean := FALSE;
		CLK_COR_MAX_LAT : integer := 36;
		CLK_COR_MIN_LAT : integer := 28;
		CLK_COR_SEQ_1_MASK : bit_vector := "0000";
		CLK_COR_SEQ_2_MASK : bit_vector := "0000";
		CLK_COR_SEQ_2_USE : boolean := FALSE;
		CLK_COR_SEQ_DROP : boolean := FALSE;
		CLK_COR_SEQ_LEN : integer := 2;
		CLK_CORRECT_USE : boolean := TRUE;
		DEC_MCOMMA_DETECT : boolean := TRUE;
		DEC_PCOMMA_DETECT : boolean := TRUE;
		DEC_VALID_COMMA_ONLY : boolean := TRUE;
		LANE_ID : bit_vector := "00000000000";
		PMA_PWR_CNTRL : bit_vector := "11111111";
		RX_BUFFER_USE : boolean := TRUE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		TX_BUFFER_USE : boolean := TRUE

  );

port (
		CHBONDDONE : out std_ulogic;
		CHBONDO : out std_logic_vector(4 downto 0);
		PMARXLOCK : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(0 downto 0);
		RXCHARISK : out std_logic_vector(0 downto 0);
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXDATA : out std_logic_vector(7 downto 0);
		RXDISPERR : out std_logic_vector(0 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(0 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(0 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(0 downto 0);
		TXN : out std_ulogic;
		TXOUTCLK : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(0 downto 0);

		BREFCLKNIN : in std_ulogic;
		BREFCLKPIN : in std_ulogic;
		CHBONDI : in std_logic_vector(4 downto 0);
		ENCHANSYNC : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		PMAINIT : in std_ulogic;
		PMAREGADDR : in std_logic_vector(5 downto 0);
		PMAREGDATAIN : in std_logic_vector(7 downto 0);
		PMAREGRW : in std_ulogic;
		PMAREGSTROBE : in std_ulogic;
		PMARXLOCKSEL : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK : in std_ulogic;
		REFCLK2 : in std_ulogic;
		REFCLKBSEL : in std_ulogic;
		REFCLKSEL : in std_ulogic;
		RXBLOCKSYNC64B66BUSE : in std_ulogic;
		RXCOMMADETUSE : in std_ulogic;
		RXDATAWIDTH : in std_logic_vector(1 downto 0);
		RXDEC64B66BUSE : in std_ulogic;
		RXDEC8B10BUSE : in std_ulogic;
		RXDESCRAM64B66BUSE : in std_ulogic;
		RXIGNOREBTF : in std_ulogic;
		RXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXSLIDE : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(0 downto 0);
		TXCHARDISPMODE : in std_logic_vector(0 downto 0);
		TXCHARDISPVAL : in std_logic_vector(0 downto 0);
		TXCHARISK : in std_logic_vector(0 downto 0);
		TXDATA : in std_logic_vector(7 downto 0);
		TXDATAWIDTH : in std_logic_vector(1 downto 0);
		TXENC64B66BUSE : in std_ulogic;
		TXENC8B10BUSE : in std_ulogic;
		TXGEARBOX64B66BUSE : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXSCRAM64B66BUSE : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT10_INFINIBAND_1 : component is true;
attribute black_box_pad_pin of GT10_INFINIBAND_1 : component is "RXN,RXP,TXN,TXP";

component GT10_INFINIBAND_2
generic (
		ALIGN_COMMA_WORD : integer := 2;
		CHAN_BOND_LIMIT : integer := 16;
		CHAN_BOND_MODE : string := "OFF";
		CHAN_BOND_ONE_SHOT : boolean := FALSE;
		CHAN_BOND_SEQ_1_MASK : bit_vector := "0000";
		CHAN_BOND_SEQ_2_MASK : bit_vector := "0000";
		CHAN_BOND_SEQ_LEN : integer := 2;
		CLK_COR_8B10B_DE : boolean := FALSE;
		CLK_COR_MAX_LAT : integer := 36;
		CLK_COR_MIN_LAT : integer := 28;
		CLK_COR_SEQ_1_MASK : bit_vector := "0000";
		CLK_COR_SEQ_2_MASK : bit_vector := "0000";
		CLK_COR_SEQ_2_USE : boolean := FALSE;
		CLK_COR_SEQ_DROP : boolean := FALSE;
		CLK_COR_SEQ_LEN : integer := 2;
		CLK_CORRECT_USE : boolean := TRUE;
		DEC_MCOMMA_DETECT : boolean := TRUE;
		DEC_PCOMMA_DETECT : boolean := TRUE;
		DEC_VALID_COMMA_ONLY : boolean := TRUE;
		LANE_ID : bit_vector := "00000000000";
		PMA_PWR_CNTRL : bit_vector := "11111111";
		RX_BUFFER_USE : boolean := TRUE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		TX_BUFFER_USE : boolean := TRUE

  );

port (
		CHBONDDONE : out std_ulogic;
		CHBONDO : out std_logic_vector(4 downto 0);
		PMARXLOCK : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(1 downto 0);
		RXCHARISK : out std_logic_vector(1 downto 0);
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXDATA : out std_logic_vector(15 downto 0);
		RXDISPERR : out std_logic_vector(1 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(1 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(1 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(1 downto 0);
		TXN : out std_ulogic;
		TXOUTCLK : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(1 downto 0);

		BREFCLKNIN : in std_ulogic;
		BREFCLKPIN : in std_ulogic;
		CHBONDI : in std_logic_vector(4 downto 0);
		ENCHANSYNC : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		PMAINIT : in std_ulogic;
		PMAREGADDR : in std_logic_vector(5 downto 0);
		PMAREGDATAIN : in std_logic_vector(7 downto 0);
		PMAREGRW : in std_ulogic;
		PMAREGSTROBE : in std_ulogic;
		PMARXLOCKSEL : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK : in std_ulogic;
		REFCLK2 : in std_ulogic;
		REFCLKBSEL : in std_ulogic;
		REFCLKSEL : in std_ulogic;
		RXBLOCKSYNC64B66BUSE : in std_ulogic;
		RXCOMMADETUSE : in std_ulogic;
		RXDATAWIDTH : in std_logic_vector(1 downto 0);
		RXDEC64B66BUSE : in std_ulogic;
		RXDEC8B10BUSE : in std_ulogic;
		RXDESCRAM64B66BUSE : in std_ulogic;
		RXIGNOREBTF : in std_ulogic;
		RXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXSLIDE : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(1 downto 0);
		TXCHARDISPMODE : in std_logic_vector(1 downto 0);
		TXCHARDISPVAL : in std_logic_vector(1 downto 0);
		TXCHARISK : in std_logic_vector(1 downto 0);
		TXDATA : in std_logic_vector(15 downto 0);
		TXDATAWIDTH : in std_logic_vector(1 downto 0);
		TXENC64B66BUSE : in std_ulogic;
		TXENC8B10BUSE : in std_ulogic;
		TXGEARBOX64B66BUSE : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXSCRAM64B66BUSE : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT10_INFINIBAND_2 : component is true;
attribute black_box_pad_pin of GT10_INFINIBAND_2 : component is "RXN,RXP,TXN,TXP";

component GT10_INFINIBAND_4
generic (
		ALIGN_COMMA_WORD : integer := 2;
		CHAN_BOND_LIMIT : integer := 16;
		CHAN_BOND_MODE : string := "OFF";
		CHAN_BOND_ONE_SHOT : boolean := FALSE;
		CHAN_BOND_SEQ_1_MASK : bit_vector := "0000";
		CHAN_BOND_SEQ_2_MASK : bit_vector := "0000";
		CHAN_BOND_SEQ_LEN : integer := 2;
		CLK_COR_8B10B_DE : boolean := FALSE;
		CLK_COR_MAX_LAT : integer := 36;
		CLK_COR_MIN_LAT : integer := 28;
		CLK_COR_SEQ_1_MASK : bit_vector := "0000";
		CLK_COR_SEQ_2_MASK : bit_vector := "0000";
		CLK_COR_SEQ_2_USE : boolean := FALSE;
		CLK_COR_SEQ_DROP : boolean := FALSE;
		CLK_COR_SEQ_LEN : integer := 2;
		CLK_CORRECT_USE : boolean := TRUE;
		DEC_MCOMMA_DETECT : boolean := TRUE;
		DEC_PCOMMA_DETECT : boolean := TRUE;
		DEC_VALID_COMMA_ONLY : boolean := TRUE;
		LANE_ID : bit_vector := "00000000000";
		PMA_PWR_CNTRL : bit_vector := "11111111";
		RX_BUFFER_USE : boolean := TRUE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		TX_BUFFER_USE : boolean := TRUE

  );

port (
		CHBONDDONE : out std_ulogic;
		CHBONDO : out std_logic_vector(4 downto 0);
		PMARXLOCK : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(3 downto 0);
		RXCHARISK : out std_logic_vector(3 downto 0);
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXDATA : out std_logic_vector(31 downto 0);
		RXDISPERR : out std_logic_vector(3 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(3 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(3 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(3 downto 0);
		TXN : out std_ulogic;
		TXOUTCLK : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(3 downto 0);

		BREFCLKNIN : in std_ulogic;
		BREFCLKPIN : in std_ulogic;
		CHBONDI : in std_logic_vector(4 downto 0);
		ENCHANSYNC : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		PMAINIT : in std_ulogic;
		PMAREGADDR : in std_logic_vector(5 downto 0);
		PMAREGDATAIN : in std_logic_vector(7 downto 0);
		PMAREGRW : in std_ulogic;
		PMAREGSTROBE : in std_ulogic;
		PMARXLOCKSEL : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK : in std_ulogic;
		REFCLK2 : in std_ulogic;
		REFCLKBSEL : in std_ulogic;
		REFCLKSEL : in std_ulogic;
		RXBLOCKSYNC64B66BUSE : in std_ulogic;
		RXCOMMADETUSE : in std_ulogic;
		RXDATAWIDTH : in std_logic_vector(1 downto 0);
		RXDEC64B66BUSE : in std_ulogic;
		RXDEC8B10BUSE : in std_ulogic;
		RXDESCRAM64B66BUSE : in std_ulogic;
		RXIGNOREBTF : in std_ulogic;
		RXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXSLIDE : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(3 downto 0);
		TXCHARDISPMODE : in std_logic_vector(3 downto 0);
		TXCHARDISPVAL : in std_logic_vector(3 downto 0);
		TXCHARISK : in std_logic_vector(3 downto 0);
		TXDATA : in std_logic_vector(31 downto 0);
		TXDATAWIDTH : in std_logic_vector(1 downto 0);
		TXENC64B66BUSE : in std_ulogic;
		TXENC8B10BUSE : in std_ulogic;
		TXGEARBOX64B66BUSE : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXSCRAM64B66BUSE : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT10_INFINIBAND_4 : component is true;
attribute black_box_pad_pin of GT10_INFINIBAND_4 : component is "RXN,RXP,TXN,TXP";

component GT10_OC192_4
generic (
		ALIGN_COMMA_WORD : integer := 1;
		DEC_MCOMMA_DETECT : boolean := TRUE;
		DEC_PCOMMA_DETECT : boolean := TRUE;
		MCOMMA_10B_VALUE : bit_vector := "0010101010";
		MCOMMA_DETECT : boolean := TRUE;
		PCOMMA_10B_VALUE : bit_vector := "0010101010";
		PCOMMA_DETECT : boolean := TRUE;
		PMA_PWR_CNTRL : bit_vector := "11111111";
		RX_BUFFER_USE : boolean := TRUE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		TX_BUFFER_USE : boolean := TRUE

  );

port (
		CHBONDDONE : out std_ulogic;
		CHBONDO : out std_logic_vector(4 downto 0);
		PMARXLOCK : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(3 downto 0);
		RXCHARISK : out std_logic_vector(3 downto 0);
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXDATA : out std_logic_vector(31 downto 0);
		RXDISPERR : out std_logic_vector(3 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(3 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(3 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(3 downto 0);
		TXN : out std_ulogic;
		TXOUTCLK : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(3 downto 0);

		BREFCLKNIN : in std_ulogic;
		BREFCLKPIN : in std_ulogic;
		CHBONDI : in std_logic_vector(4 downto 0);
		ENCHANSYNC : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		PMAINIT : in std_ulogic;
		PMAREGADDR : in std_logic_vector(5 downto 0);
		PMAREGDATAIN : in std_logic_vector(7 downto 0);
		PMAREGRW : in std_ulogic;
		PMAREGSTROBE : in std_ulogic;
		PMARXLOCKSEL : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLKBSEL : in std_ulogic;
		RXBLOCKSYNC64B66BUSE : in std_ulogic;
		RXCOMMADETUSE : in std_ulogic;
		RXDATAWIDTH : in std_logic_vector(1 downto 0);
		RXDEC64B66BUSE : in std_ulogic;
		RXDEC8B10BUSE : in std_ulogic;
		RXDESCRAM64B66BUSE : in std_ulogic;
		RXIGNOREBTF : in std_ulogic;
		RXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXSLIDE : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(3 downto 0);
		TXCHARDISPMODE : in std_logic_vector(3 downto 0);
		TXCHARDISPVAL : in std_logic_vector(3 downto 0);
		TXCHARISK : in std_logic_vector(3 downto 0);
		TXDATA : in std_logic_vector(31 downto 0);
		TXDATAWIDTH : in std_logic_vector(1 downto 0);
		TXENC64B66BUSE : in std_ulogic;
		TXENC8B10BUSE : in std_ulogic;
		TXGEARBOX64B66BUSE : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXSCRAM64B66BUSE : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT10_OC192_4 : component is true;
attribute black_box_pad_pin of GT10_OC192_4 : component is "RXN,RXP,TXN,TXP";

component GT10_OC192_8
generic (
		ALIGN_COMMA_WORD : integer := 1;
		DEC_MCOMMA_DETECT : boolean := TRUE;
		DEC_PCOMMA_DETECT : boolean := TRUE;
		MCOMMA_10B_VALUE : bit_vector := "0010101010";
		MCOMMA_DETECT : boolean := TRUE;
		PCOMMA_10B_VALUE : bit_vector := "0010101010";
		PCOMMA_DETECT : boolean := TRUE;
		PMA_PWR_CNTRL : bit_vector := "11111111";
		RX_BUFFER_USE : boolean := TRUE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		TX_BUFFER_USE : boolean := TRUE

  );

port (
		CHBONDDONE : out std_ulogic;
		CHBONDO : out std_logic_vector(4 downto 0);
		PMARXLOCK : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(7 downto 0);
		RXCHARISK : out std_logic_vector(7 downto 0);
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXDATA : out std_logic_vector(63 downto 0);
		RXDISPERR : out std_logic_vector(7 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(7 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(7 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(7 downto 0);
		TXN : out std_ulogic;
		TXOUTCLK : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(7 downto 0);

		BREFCLKNIN : in std_ulogic;
		BREFCLKPIN : in std_ulogic;
		CHBONDI : in std_logic_vector(4 downto 0);
		ENCHANSYNC : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		PMAINIT : in std_ulogic;
		PMAREGADDR : in std_logic_vector(5 downto 0);
		PMAREGDATAIN : in std_logic_vector(7 downto 0);
		PMAREGRW : in std_ulogic;
		PMAREGSTROBE : in std_ulogic;
		PMARXLOCKSEL : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLKBSEL : in std_ulogic;
		RXBLOCKSYNC64B66BUSE : in std_ulogic;
		RXCOMMADETUSE : in std_ulogic;
		RXDATAWIDTH : in std_logic_vector(1 downto 0);
		RXDEC64B66BUSE : in std_ulogic;
		RXDEC8B10BUSE : in std_ulogic;
		RXDESCRAM64B66BUSE : in std_ulogic;
		RXIGNOREBTF : in std_ulogic;
		RXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXSLIDE : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(7 downto 0);
		TXCHARDISPMODE : in std_logic_vector(7 downto 0);
		TXCHARDISPVAL : in std_logic_vector(7 downto 0);
		TXCHARISK : in std_logic_vector(7 downto 0);
		TXDATA : in std_logic_vector(63 downto 0);
		TXDATAWIDTH : in std_logic_vector(1 downto 0);
		TXENC64B66BUSE : in std_ulogic;
		TXENC8B10BUSE : in std_ulogic;
		TXGEARBOX64B66BUSE : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXSCRAM64B66BUSE : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT10_OC192_8 : component is true;
attribute black_box_pad_pin of GT10_OC192_8 : component is "RXN,RXP,TXN,TXP";

component GT10_OC48_1
generic (
		ALIGN_COMMA_WORD : integer := 1;
		DEC_MCOMMA_DETECT : boolean := TRUE;
		DEC_PCOMMA_DETECT : boolean := TRUE;
		MCOMMA_10B_VALUE : bit_vector := "0010101010";
		MCOMMA_DETECT : boolean := TRUE;
		PCOMMA_10B_VALUE : bit_vector := "0010101010";
		PCOMMA_DETECT : boolean := TRUE;
		PMA_PWR_CNTRL : bit_vector := "11111111";
		RX_BUFFER_USE : boolean := TRUE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		TX_BUFFER_USE : boolean := TRUE

  );

port (
		CHBONDDONE : out std_ulogic;
		CHBONDO : out std_logic_vector(4 downto 0);
		PMARXLOCK : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(0 downto 0);
		RXCHARISK : out std_logic_vector(0 downto 0);
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXDATA : out std_logic_vector(7 downto 0);
		RXDISPERR : out std_logic_vector(0 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(0 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(0 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(0 downto 0);
		TXN : out std_ulogic;
		TXOUTCLK : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(0 downto 0);

		BREFCLKNIN : in std_ulogic;
		BREFCLKPIN : in std_ulogic;
		CHBONDI : in std_logic_vector(4 downto 0);
		ENCHANSYNC : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		PMAINIT : in std_ulogic;
		PMAREGADDR : in std_logic_vector(5 downto 0);
		PMAREGDATAIN : in std_logic_vector(7 downto 0);
		PMAREGRW : in std_ulogic;
		PMAREGSTROBE : in std_ulogic;
		PMARXLOCKSEL : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK : in std_ulogic;
		REFCLK2 : in std_ulogic;
		REFCLKBSEL : in std_ulogic;
		REFCLKSEL : in std_ulogic;
		RXBLOCKSYNC64B66BUSE : in std_ulogic;
		RXCOMMADETUSE : in std_ulogic;
		RXDATAWIDTH : in std_logic_vector(1 downto 0);
		RXDEC64B66BUSE : in std_ulogic;
		RXDEC8B10BUSE : in std_ulogic;
		RXDESCRAM64B66BUSE : in std_ulogic;
		RXIGNOREBTF : in std_ulogic;
		RXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXSLIDE : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(0 downto 0);
		TXCHARDISPMODE : in std_logic_vector(0 downto 0);
		TXCHARDISPVAL : in std_logic_vector(0 downto 0);
		TXCHARISK : in std_logic_vector(0 downto 0);
		TXDATA : in std_logic_vector(7 downto 0);
		TXDATAWIDTH : in std_logic_vector(1 downto 0);
		TXENC64B66BUSE : in std_ulogic;
		TXENC8B10BUSE : in std_ulogic;
		TXGEARBOX64B66BUSE : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXSCRAM64B66BUSE : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT10_OC48_1 : component is true;
attribute black_box_pad_pin of GT10_OC48_1 : component is "RXN,RXP,TXN,TXP";

component GT10_OC48_2
generic (
		ALIGN_COMMA_WORD : integer := 1;
		DEC_MCOMMA_DETECT : boolean := TRUE;
		DEC_PCOMMA_DETECT : boolean := TRUE;
		MCOMMA_10B_VALUE : bit_vector := "0010101010";
		MCOMMA_DETECT : boolean := TRUE;
		PCOMMA_10B_VALUE : bit_vector := "0010101010";
		PCOMMA_DETECT : boolean := TRUE;
		PMA_PWR_CNTRL : bit_vector := "11111111";
		RX_BUFFER_USE : boolean := TRUE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		TX_BUFFER_USE : boolean := TRUE

  );

port (
		CHBONDDONE : out std_ulogic;
		CHBONDO : out std_logic_vector(4 downto 0);
		PMARXLOCK : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(1 downto 0);
		RXCHARISK : out std_logic_vector(1 downto 0);
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXDATA : out std_logic_vector(15 downto 0);
		RXDISPERR : out std_logic_vector(1 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(1 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(1 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(1 downto 0);
		TXN : out std_ulogic;
		TXOUTCLK : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(1 downto 0);

		BREFCLKNIN : in std_ulogic;
		BREFCLKPIN : in std_ulogic;
		CHBONDI : in std_logic_vector(4 downto 0);
		ENCHANSYNC : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		PMAINIT : in std_ulogic;
		PMAREGADDR : in std_logic_vector(5 downto 0);
		PMAREGDATAIN : in std_logic_vector(7 downto 0);
		PMAREGRW : in std_ulogic;
		PMAREGSTROBE : in std_ulogic;
		PMARXLOCKSEL : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK : in std_ulogic;
		REFCLK2 : in std_ulogic;
		REFCLKBSEL : in std_ulogic;
		REFCLKSEL : in std_ulogic;
		RXBLOCKSYNC64B66BUSE : in std_ulogic;
		RXCOMMADETUSE : in std_ulogic;
		RXDATAWIDTH : in std_logic_vector(1 downto 0);
		RXDEC64B66BUSE : in std_ulogic;
		RXDEC8B10BUSE : in std_ulogic;
		RXDESCRAM64B66BUSE : in std_ulogic;
		RXIGNOREBTF : in std_ulogic;
		RXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXSLIDE : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(1 downto 0);
		TXCHARDISPMODE : in std_logic_vector(1 downto 0);
		TXCHARDISPVAL : in std_logic_vector(1 downto 0);
		TXCHARISK : in std_logic_vector(1 downto 0);
		TXDATA : in std_logic_vector(15 downto 0);
		TXDATAWIDTH : in std_logic_vector(1 downto 0);
		TXENC64B66BUSE : in std_ulogic;
		TXENC8B10BUSE : in std_ulogic;
		TXGEARBOX64B66BUSE : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXSCRAM64B66BUSE : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT10_OC48_2 : component is true;
attribute black_box_pad_pin of GT10_OC48_2 : component is "RXN,RXP,TXN,TXP";

component GT10_OC48_4
generic (
		ALIGN_COMMA_WORD : integer := 1;
		DEC_MCOMMA_DETECT : boolean := TRUE;
		DEC_PCOMMA_DETECT : boolean := TRUE;
		MCOMMA_10B_VALUE : bit_vector := "0010101010";
		MCOMMA_DETECT : boolean := TRUE;
		PCOMMA_10B_VALUE : bit_vector := "0010101010";
		PCOMMA_DETECT : boolean := TRUE;
		PMA_PWR_CNTRL : bit_vector := "11111111";
		RX_BUFFER_USE : boolean := TRUE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		TX_BUFFER_USE : boolean := TRUE

  );

port (
		CHBONDDONE : out std_ulogic;
		CHBONDO : out std_logic_vector(4 downto 0);
		PMARXLOCK : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(3 downto 0);
		RXCHARISK : out std_logic_vector(3 downto 0);
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXDATA : out std_logic_vector(31 downto 0);
		RXDISPERR : out std_logic_vector(3 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(3 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(3 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(3 downto 0);
		TXN : out std_ulogic;
		TXOUTCLK : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(3 downto 0);

		BREFCLKNIN : in std_ulogic;
		BREFCLKPIN : in std_ulogic;
		CHBONDI : in std_logic_vector(4 downto 0);
		ENCHANSYNC : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		PMAINIT : in std_ulogic;
		PMAREGADDR : in std_logic_vector(5 downto 0);
		PMAREGDATAIN : in std_logic_vector(7 downto 0);
		PMAREGRW : in std_ulogic;
		PMAREGSTROBE : in std_ulogic;
		PMARXLOCKSEL : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK : in std_ulogic;
		REFCLK2 : in std_ulogic;
		REFCLKBSEL : in std_ulogic;
		REFCLKSEL : in std_ulogic;
		RXBLOCKSYNC64B66BUSE : in std_ulogic;
		RXCOMMADETUSE : in std_ulogic;
		RXDATAWIDTH : in std_logic_vector(1 downto 0);
		RXDEC64B66BUSE : in std_ulogic;
		RXDEC8B10BUSE : in std_ulogic;
		RXDESCRAM64B66BUSE : in std_ulogic;
		RXIGNOREBTF : in std_ulogic;
		RXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXSLIDE : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(3 downto 0);
		TXCHARDISPMODE : in std_logic_vector(3 downto 0);
		TXCHARDISPVAL : in std_logic_vector(3 downto 0);
		TXCHARISK : in std_logic_vector(3 downto 0);
		TXDATA : in std_logic_vector(31 downto 0);
		TXDATAWIDTH : in std_logic_vector(1 downto 0);
		TXENC64B66BUSE : in std_ulogic;
		TXENC8B10BUSE : in std_ulogic;
		TXGEARBOX64B66BUSE : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXSCRAM64B66BUSE : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT10_OC48_4 : component is true;
attribute black_box_pad_pin of GT10_OC48_4 : component is "RXN,RXP,TXN,TXP";

component GT10_PCI_EXPRESS_1
generic (
		ALIGN_COMMA_WORD : integer := 2;
		CHAN_BOND_LIMIT : integer := 16;
		CHAN_BOND_MODE : string := "OFF";
		CHAN_BOND_ONE_SHOT : boolean := FALSE;
		CHAN_BOND_SEQ_1_MASK : bit_vector := "0000";
		CHAN_BOND_SEQ_2_MASK : bit_vector := "0000";
		CHAN_BOND_SEQ_2_USE : boolean := FALSE;
		CHAN_BOND_SEQ_LEN : integer := 2;
		CLK_COR_8B10B_DE : boolean := FALSE;
		CLK_COR_MAX_LAT : integer := 36;
		CLK_COR_MIN_LAT : integer := 28;
		CLK_COR_SEQ_1_MASK : bit_vector := "0000";
		CLK_COR_SEQ_2_MASK : bit_vector := "0000";
		CLK_COR_SEQ_2_USE : boolean := FALSE;
		CLK_COR_SEQ_DROP : boolean := FALSE;
		CLK_COR_SEQ_LEN : integer := 2;
		CLK_CORRECT_USE : boolean := TRUE;
		DEC_MCOMMA_DETECT : boolean := TRUE;
		DEC_PCOMMA_DETECT : boolean := TRUE;
		DEC_VALID_COMMA_ONLY : boolean := TRUE;
		PMA_PWR_CNTRL : bit_vector := "11111111";
		RX_BUFFER_USE : boolean := TRUE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		TX_BUFFER_USE : boolean := TRUE

  );

port (
		CHBONDDONE : out std_ulogic;
		CHBONDO : out std_logic_vector(4 downto 0);
		PMARXLOCK : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(0 downto 0);
		RXCHARISK : out std_logic_vector(0 downto 0);
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXDATA : out std_logic_vector(7 downto 0);
		RXDISPERR : out std_logic_vector(0 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(0 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(0 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(0 downto 0);
		TXN : out std_ulogic;
		TXOUTCLK : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(0 downto 0);

		BREFCLKNIN : in std_ulogic;
		BREFCLKPIN : in std_ulogic;
		CHBONDI : in std_logic_vector(4 downto 0);
		ENCHANSYNC : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		PMAINIT : in std_ulogic;
		PMAREGADDR : in std_logic_vector(5 downto 0);
		PMAREGDATAIN : in std_logic_vector(7 downto 0);
		PMAREGRW : in std_ulogic;
		PMAREGSTROBE : in std_ulogic;
		PMARXLOCKSEL : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK : in std_ulogic;
		REFCLK2 : in std_ulogic;
		REFCLKBSEL : in std_ulogic;
		REFCLKSEL : in std_ulogic;
		RXBLOCKSYNC64B66BUSE : in std_ulogic;
		RXCOMMADETUSE : in std_ulogic;
		RXDATAWIDTH : in std_logic_vector(1 downto 0);
		RXDEC64B66BUSE : in std_ulogic;
		RXDEC8B10BUSE : in std_ulogic;
		RXDESCRAM64B66BUSE : in std_ulogic;
		RXIGNOREBTF : in std_ulogic;
		RXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXSLIDE : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(0 downto 0);
		TXCHARDISPMODE : in std_logic_vector(0 downto 0);
		TXCHARDISPVAL : in std_logic_vector(0 downto 0);
		TXCHARISK : in std_logic_vector(0 downto 0);
		TXDATA : in std_logic_vector(7 downto 0);
		TXDATAWIDTH : in std_logic_vector(1 downto 0);
		TXENC64B66BUSE : in std_ulogic;
		TXENC8B10BUSE : in std_ulogic;
		TXGEARBOX64B66BUSE : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXSCRAM64B66BUSE : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT10_PCI_EXPRESS_1 : component is true;
attribute black_box_pad_pin of GT10_PCI_EXPRESS_1 : component is "RXN,RXP,TXN,TXP";

component GT10_PCI_EXPRESS_2
generic (
		ALIGN_COMMA_WORD : integer := 2;
		CHAN_BOND_LIMIT : integer := 16;
		CHAN_BOND_MODE : string := "OFF";
		CHAN_BOND_ONE_SHOT : boolean := FALSE;
		CHAN_BOND_SEQ_1_MASK : bit_vector := "0000";
		CHAN_BOND_SEQ_2_MASK : bit_vector := "0000";
		CHAN_BOND_SEQ_2_USE : boolean := FALSE;
		CHAN_BOND_SEQ_LEN : integer := 2;
		CLK_COR_8B10B_DE : boolean := FALSE;
		CLK_COR_MAX_LAT : integer := 36;
		CLK_COR_MIN_LAT : integer := 28;
		CLK_COR_SEQ_1_MASK : bit_vector := "0000";
		CLK_COR_SEQ_2_MASK : bit_vector := "0000";
		CLK_COR_SEQ_2_USE : boolean := FALSE;
		CLK_COR_SEQ_DROP : boolean := FALSE;
		CLK_COR_SEQ_LEN : integer := 2;
		CLK_CORRECT_USE : boolean := TRUE;
		DEC_MCOMMA_DETECT : boolean := TRUE;
		DEC_PCOMMA_DETECT : boolean := TRUE;
		DEC_VALID_COMMA_ONLY : boolean := TRUE;
		PMA_PWR_CNTRL : bit_vector := "11111111";
		RX_BUFFER_USE : boolean := TRUE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		TX_BUFFER_USE : boolean := TRUE

  );

port (
		CHBONDDONE : out std_ulogic;
		CHBONDO : out std_logic_vector(4 downto 0);
		PMARXLOCK : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(1 downto 0);
		RXCHARISK : out std_logic_vector(1 downto 0);
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXDATA : out std_logic_vector(15 downto 0);
		RXDISPERR : out std_logic_vector(1 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(1 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(1 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(1 downto 0);
		TXN : out std_ulogic;
		TXOUTCLK : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(1 downto 0);

		BREFCLKNIN : in std_ulogic;
		BREFCLKPIN : in std_ulogic;
		CHBONDI : in std_logic_vector(4 downto 0);
		ENCHANSYNC : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		PMAINIT : in std_ulogic;
		PMAREGADDR : in std_logic_vector(5 downto 0);
		PMAREGDATAIN : in std_logic_vector(7 downto 0);
		PMAREGRW : in std_ulogic;
		PMAREGSTROBE : in std_ulogic;
		PMARXLOCKSEL : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK : in std_ulogic;
		REFCLK2 : in std_ulogic;
		REFCLKBSEL : in std_ulogic;
		REFCLKSEL : in std_ulogic;
		RXBLOCKSYNC64B66BUSE : in std_ulogic;
		RXCOMMADETUSE : in std_ulogic;
		RXDATAWIDTH : in std_logic_vector(1 downto 0);
		RXDEC64B66BUSE : in std_ulogic;
		RXDEC8B10BUSE : in std_ulogic;
		RXDESCRAM64B66BUSE : in std_ulogic;
		RXIGNOREBTF : in std_ulogic;
		RXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXSLIDE : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(1 downto 0);
		TXCHARDISPMODE : in std_logic_vector(1 downto 0);
		TXCHARDISPVAL : in std_logic_vector(1 downto 0);
		TXCHARISK : in std_logic_vector(1 downto 0);
		TXDATA : in std_logic_vector(15 downto 0);
		TXDATAWIDTH : in std_logic_vector(1 downto 0);
		TXENC64B66BUSE : in std_ulogic;
		TXENC8B10BUSE : in std_ulogic;
		TXGEARBOX64B66BUSE : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXSCRAM64B66BUSE : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT10_PCI_EXPRESS_2 : component is true;
attribute black_box_pad_pin of GT10_PCI_EXPRESS_2 : component is "RXN,RXP,TXN,TXP";

component GT10_PCI_EXPRESS_4
generic (
		ALIGN_COMMA_WORD : integer := 2;
		CHAN_BOND_LIMIT : integer := 16;
		CHAN_BOND_MODE : string := "OFF";
		CHAN_BOND_ONE_SHOT : boolean := FALSE;
		CHAN_BOND_SEQ_1_MASK : bit_vector := "0000";
		CHAN_BOND_SEQ_2_MASK : bit_vector := "0000";
		CHAN_BOND_SEQ_2_USE : boolean := FALSE;
		CHAN_BOND_SEQ_LEN : integer := 2;
		CLK_COR_8B10B_DE : boolean := FALSE;
		CLK_COR_MAX_LAT : integer := 36;
		CLK_COR_MIN_LAT : integer := 28;
		CLK_COR_SEQ_1_MASK : bit_vector := "0000";
		CLK_COR_SEQ_2_MASK : bit_vector := "0000";
		CLK_COR_SEQ_2_USE : boolean := FALSE;
		CLK_COR_SEQ_DROP : boolean := FALSE;
		CLK_COR_SEQ_LEN : integer := 2;
		CLK_CORRECT_USE : boolean := TRUE;
		DEC_MCOMMA_DETECT : boolean := TRUE;
		DEC_PCOMMA_DETECT : boolean := TRUE;
		DEC_VALID_COMMA_ONLY : boolean := TRUE;
		PMA_PWR_CNTRL : bit_vector := "11111111";
		RX_BUFFER_USE : boolean := TRUE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		TX_BUFFER_USE : boolean := TRUE

  );

port (
		CHBONDDONE : out std_ulogic;
		CHBONDO : out std_logic_vector(4 downto 0);
		PMARXLOCK : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(3 downto 0);
		RXCHARISK : out std_logic_vector(3 downto 0);
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXDATA : out std_logic_vector(31 downto 0);
		RXDISPERR : out std_logic_vector(3 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(3 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(3 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(3 downto 0);
		TXN : out std_ulogic;
		TXOUTCLK : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(3 downto 0);

		BREFCLKNIN : in std_ulogic;
		BREFCLKPIN : in std_ulogic;
		CHBONDI : in std_logic_vector(4 downto 0);
		ENCHANSYNC : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		PMAINIT : in std_ulogic;
		PMAREGADDR : in std_logic_vector(5 downto 0);
		PMAREGDATAIN : in std_logic_vector(7 downto 0);
		PMAREGRW : in std_ulogic;
		PMAREGSTROBE : in std_ulogic;
		PMARXLOCKSEL : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK : in std_ulogic;
		REFCLK2 : in std_ulogic;
		REFCLKBSEL : in std_ulogic;
		REFCLKSEL : in std_ulogic;
		RXBLOCKSYNC64B66BUSE : in std_ulogic;
		RXCOMMADETUSE : in std_ulogic;
		RXDATAWIDTH : in std_logic_vector(1 downto 0);
		RXDEC64B66BUSE : in std_ulogic;
		RXDEC8B10BUSE : in std_ulogic;
		RXDESCRAM64B66BUSE : in std_ulogic;
		RXIGNOREBTF : in std_ulogic;
		RXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXSLIDE : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(3 downto 0);
		TXCHARDISPMODE : in std_logic_vector(3 downto 0);
		TXCHARDISPVAL : in std_logic_vector(3 downto 0);
		TXCHARISK : in std_logic_vector(3 downto 0);
		TXDATA : in std_logic_vector(31 downto 0);
		TXDATAWIDTH : in std_logic_vector(1 downto 0);
		TXENC64B66BUSE : in std_ulogic;
		TXENC8B10BUSE : in std_ulogic;
		TXGEARBOX64B66BUSE : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXSCRAM64B66BUSE : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT10_PCI_EXPRESS_4 : component is true;
attribute black_box_pad_pin of GT10_PCI_EXPRESS_4 : component is "RXN,RXP,TXN,TXP";

component GT10_XAUI_1

generic (
		ALIGN_COMMA_WORD : integer := 2;
		CHAN_BOND_LIMIT : integer := 16;
		CHAN_BOND_MODE : string := "OFF";
		CHAN_BOND_ONE_SHOT : boolean := FALSE;
		CHAN_BOND_SEQ_1_MASK : bit_vector := "0000";
		CHAN_BOND_SEQ_2_MASK : bit_vector := "0000";
		CHAN_BOND_SEQ_2_USE : boolean := FALSE;
		CHAN_BOND_SEQ_LEN : integer := 2;
		CLK_COR_8B10B_DE : boolean := FALSE;
		CLK_COR_MAX_LAT : integer := 36;
		CLK_COR_MIN_LAT : integer := 28;
		CLK_COR_SEQ_1_MASK : bit_vector := "0000";
		CLK_COR_SEQ_2_MASK : bit_vector := "0000";
		CLK_COR_SEQ_2_USE : boolean := FALSE;
		CLK_COR_SEQ_DROP : boolean := FALSE;
		CLK_COR_SEQ_LEN : integer := 2;
		CLK_CORRECT_USE : boolean := TRUE;
		DEC_MCOMMA_DETECT : boolean := TRUE;
		DEC_PCOMMA_DETECT : boolean := TRUE;
		DEC_VALID_COMMA_ONLY : boolean := TRUE;
		PMA_PWR_CNTRL : bit_vector := "11111111";
		RX_BUFFER_USE : boolean := TRUE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		TX_BUFFER_USE : boolean := TRUE

  );


port (
		CHBONDDONE : out std_ulogic;
		CHBONDO : out std_logic_vector(4 downto 0);
		PMARXLOCK : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(0 downto 0);
		RXCHARISK : out std_logic_vector(0 downto 0);
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXDATA : out std_logic_vector(7 downto 0);
		RXDISPERR : out std_logic_vector(0 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(0 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(0 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(0 downto 0);
		TXN : out std_ulogic;
		TXOUTCLK : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(0 downto 0);

		BREFCLKNIN : in std_ulogic;
		BREFCLKPIN : in std_ulogic;
		CHBONDI : in std_logic_vector(4 downto 0);
		ENCHANSYNC : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		PMAINIT : in std_ulogic;
		PMAREGADDR : in std_logic_vector(5 downto 0);
		PMAREGDATAIN : in std_logic_vector(7 downto 0);
		PMAREGRW : in std_ulogic;
		PMAREGSTROBE : in std_ulogic;
		PMARXLOCKSEL : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK : in std_ulogic;
		REFCLK2 : in std_ulogic;
		REFCLKBSEL : in std_ulogic;
		REFCLKSEL : in std_ulogic;
		RXBLOCKSYNC64B66BUSE : in std_ulogic;
		RXCOMMADETUSE : in std_ulogic;
		RXDATAWIDTH : in std_logic_vector(1 downto 0);
		RXDEC64B66BUSE : in std_ulogic;
		RXDEC8B10BUSE : in std_ulogic;
		RXDESCRAM64B66BUSE : in std_ulogic;
		RXIGNOREBTF : in std_ulogic;
		RXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXSLIDE : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(0 downto 0);
		TXCHARDISPMODE : in std_logic_vector(0 downto 0);
		TXCHARDISPVAL : in std_logic_vector(0 downto 0);
		TXCHARISK : in std_logic_vector(0 downto 0);
		TXDATA : in std_logic_vector(7 downto 0);
		TXDATAWIDTH : in std_logic_vector(1 downto 0);
		TXENC64B66BUSE : in std_ulogic;
		TXENC8B10BUSE : in std_ulogic;
		TXGEARBOX64B66BUSE : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXSCRAM64B66BUSE : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT10_XAUI_1 : component is true;
attribute black_box_pad_pin of GT10_XAUI_1 : component is "RXN,RXP,TXN,TXP";

component GT10_XAUI_2
generic (
		ALIGN_COMMA_WORD : integer := 2;
		CHAN_BOND_LIMIT : integer := 16;
		CHAN_BOND_MODE : string := "OFF";
		CHAN_BOND_ONE_SHOT : boolean := FALSE;
		CHAN_BOND_SEQ_1_MASK : bit_vector := "0000";
		CHAN_BOND_SEQ_2_MASK : bit_vector := "0000";
		CHAN_BOND_SEQ_2_USE : boolean := FALSE;
		CHAN_BOND_SEQ_LEN : integer := 2;
		CLK_COR_8B10B_DE : boolean := FALSE;
		CLK_COR_MAX_LAT : integer := 36;
		CLK_COR_MIN_LAT : integer := 28;
		CLK_COR_SEQ_1_MASK : bit_vector := "0000";
		CLK_COR_SEQ_2_MASK : bit_vector := "0000";
		CLK_COR_SEQ_2_USE : boolean := FALSE;
		CLK_COR_SEQ_DROP : boolean := FALSE;
		CLK_COR_SEQ_LEN : integer := 2;
		CLK_CORRECT_USE : boolean := TRUE;
		DEC_MCOMMA_DETECT : boolean := TRUE;
		DEC_PCOMMA_DETECT : boolean := TRUE;
		DEC_VALID_COMMA_ONLY : boolean := TRUE;
		PMA_PWR_CNTRL : bit_vector := "11111111";
		RX_BUFFER_USE : boolean := TRUE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		TX_BUFFER_USE : boolean := TRUE

  );

port (
		CHBONDDONE : out std_ulogic;
		CHBONDO : out std_logic_vector(4 downto 0);
		PMARXLOCK : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(1 downto 0);
		RXCHARISK : out std_logic_vector(1 downto 0);
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXDATA : out std_logic_vector(15 downto 0);
		RXDISPERR : out std_logic_vector(1 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(1 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(1 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(1 downto 0);
		TXN : out std_ulogic;
		TXOUTCLK : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(1 downto 0);

		BREFCLKNIN : in std_ulogic;
		BREFCLKPIN : in std_ulogic;
		CHBONDI : in std_logic_vector(4 downto 0);
		ENCHANSYNC : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		PMAINIT : in std_ulogic;
		PMAREGADDR : in std_logic_vector(5 downto 0);
		PMAREGDATAIN : in std_logic_vector(7 downto 0);
		PMAREGRW : in std_ulogic;
		PMAREGSTROBE : in std_ulogic;
		PMARXLOCKSEL : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK : in std_ulogic;
		REFCLK2 : in std_ulogic;
		REFCLKBSEL : in std_ulogic;
		REFCLKSEL : in std_ulogic;
		RXBLOCKSYNC64B66BUSE : in std_ulogic;
		RXCOMMADETUSE : in std_ulogic;
		RXDATAWIDTH : in std_logic_vector(1 downto 0);
		RXDEC64B66BUSE : in std_ulogic;
		RXDEC8B10BUSE : in std_ulogic;
		RXDESCRAM64B66BUSE : in std_ulogic;
		RXIGNOREBTF : in std_ulogic;
		RXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXSLIDE : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(1 downto 0);
		TXCHARDISPMODE : in std_logic_vector(1 downto 0);
		TXCHARDISPVAL : in std_logic_vector(1 downto 0);
		TXCHARISK : in std_logic_vector(1 downto 0);
		TXDATA : in std_logic_vector(15 downto 0);
		TXDATAWIDTH : in std_logic_vector(1 downto 0);
		TXENC64B66BUSE : in std_ulogic;
		TXENC8B10BUSE : in std_ulogic;
		TXGEARBOX64B66BUSE : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXSCRAM64B66BUSE : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT10_XAUI_2 : component is true;
attribute black_box_pad_pin of GT10_XAUI_2 : component is "RXN,RXP,TXN,TXP";

component GT10_XAUI_4
generic (
		ALIGN_COMMA_WORD : integer := 2;
		CHAN_BOND_LIMIT : integer := 16;
		CHAN_BOND_MODE : string := "OFF";
		CHAN_BOND_ONE_SHOT : boolean := FALSE;
		CHAN_BOND_SEQ_1_MASK : bit_vector := "0000";
		CHAN_BOND_SEQ_2_MASK : bit_vector := "0000";
		CHAN_BOND_SEQ_2_USE : boolean := FALSE;
		CHAN_BOND_SEQ_LEN : integer := 2;
		CLK_COR_8B10B_DE : boolean := FALSE;
		CLK_COR_MAX_LAT : integer := 36;
		CLK_COR_MIN_LAT : integer := 28;
		CLK_COR_SEQ_1_MASK : bit_vector := "0000";
		CLK_COR_SEQ_2_MASK : bit_vector := "0000";
		CLK_COR_SEQ_2_USE : boolean := FALSE;
		CLK_COR_SEQ_DROP : boolean := FALSE;
		CLK_COR_SEQ_LEN : integer := 2;
		CLK_CORRECT_USE : boolean := TRUE;
		DEC_MCOMMA_DETECT : boolean := TRUE;
		DEC_PCOMMA_DETECT : boolean := TRUE;
		DEC_VALID_COMMA_ONLY : boolean := TRUE;
		PMA_PWR_CNTRL : bit_vector := "11111111";
		RX_BUFFER_USE : boolean := TRUE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		TX_BUFFER_USE : boolean := TRUE

  );

port (
		CHBONDDONE : out std_ulogic;
		CHBONDO : out std_logic_vector(4 downto 0);
		PMARXLOCK : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(3 downto 0);
		RXCHARISK : out std_logic_vector(3 downto 0);
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXDATA : out std_logic_vector(31 downto 0);
		RXDISPERR : out std_logic_vector(3 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(3 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(3 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(3 downto 0);
		TXN : out std_ulogic;
		TXOUTCLK : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(3 downto 0);

		BREFCLKNIN : in std_ulogic;
		BREFCLKPIN : in std_ulogic;
		CHBONDI : in std_logic_vector(4 downto 0);
		ENCHANSYNC : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		PMAINIT : in std_ulogic;
		PMAREGADDR : in std_logic_vector(5 downto 0);
		PMAREGDATAIN : in std_logic_vector(7 downto 0);
		PMAREGRW : in std_ulogic;
		PMAREGSTROBE : in std_ulogic;
		PMARXLOCKSEL : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK : in std_ulogic;
		REFCLK2 : in std_ulogic;
		REFCLKBSEL : in std_ulogic;
		REFCLKSEL : in std_ulogic;
		RXBLOCKSYNC64B66BUSE : in std_ulogic;
		RXCOMMADETUSE : in std_ulogic;
		RXDATAWIDTH : in std_logic_vector(1 downto 0);
		RXDEC64B66BUSE : in std_ulogic;
		RXDEC8B10BUSE : in std_ulogic;
		RXDESCRAM64B66BUSE : in std_ulogic;
		RXIGNOREBTF : in std_ulogic;
		RXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXSLIDE : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(3 downto 0);
		TXCHARDISPMODE : in std_logic_vector(3 downto 0);
		TXCHARDISPVAL : in std_logic_vector(3 downto 0);
		TXCHARISK : in std_logic_vector(3 downto 0);
		TXDATA : in std_logic_vector(31 downto 0);
		TXDATAWIDTH : in std_logic_vector(1 downto 0);
		TXENC64B66BUSE : in std_ulogic;
		TXENC8B10BUSE : in std_ulogic;
		TXGEARBOX64B66BUSE : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXSCRAM64B66BUSE : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT10_XAUI_4 : component is true;
attribute black_box_pad_pin of GT10_XAUI_4 : component is "RXN,RXP,TXN,TXP";

component GT

generic (
-- synopsys translate_off
        TimingChecksOn : boolean := TRUE;
        InstancePath   : string  := "*";
        Xon            : boolean := TRUE;
        MsgOn          : boolean := FALSE;
-- synopsys translate_on
		ALIGN_COMMA_MSB : boolean := FALSE;
		CHAN_BOND_LIMIT : integer := 16;
		CHAN_BOND_MODE : string := "OFF";
		CHAN_BOND_OFFSET : integer := 8;
		CHAN_BOND_ONE_SHOT : boolean := FALSE;
		CHAN_BOND_SEQ_1_1 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_1_2 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_1_3 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_1_4 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_2_1 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_2_2 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_2_3 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_2_4 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_2_USE : boolean := FALSE;
		CHAN_BOND_SEQ_LEN : integer := 1;
		CHAN_BOND_WAIT : integer := 8;
		CLK_COR_INSERT_IDLE_FLAG : boolean := FALSE;
		CLK_COR_KEEP_IDLE : boolean := FALSE;
		CLK_COR_REPEAT_WAIT : integer := 1;
		CLK_COR_SEQ_1_1 : bit_vector := "00000000000";
		CLK_COR_SEQ_1_2 : bit_vector := "00000000000";
		CLK_COR_SEQ_1_3 : bit_vector := "00000000000";
		CLK_COR_SEQ_1_4 : bit_vector := "00000000000";
		CLK_COR_SEQ_2_1 : bit_vector := "00000000000";
		CLK_COR_SEQ_2_2 : bit_vector := "00000000000";
		CLK_COR_SEQ_2_3 : bit_vector := "00000000000";
		CLK_COR_SEQ_2_4 : bit_vector := "00000000000";
		CLK_COR_SEQ_2_USE : boolean := FALSE;
		CLK_COR_SEQ_LEN : integer := 1;
		CLK_CORRECT_USE : boolean := TRUE;
		COMMA_10B_MASK : bit_vector := "1111111000";
		CRC_END_OF_PKT : string := "K29_7";
		CRC_FORMAT : string := "USER_MODE";
		CRC_START_OF_PKT : string := "K27_7";
		DEC_MCOMMA_DETECT : boolean := TRUE;
		DEC_PCOMMA_DETECT : boolean := TRUE;
		DEC_VALID_COMMA_ONLY : boolean := TRUE;
		MCOMMA_10B_VALUE : bit_vector := "1100000000";
		MCOMMA_DETECT : boolean := TRUE;
		PCOMMA_10B_VALUE : bit_vector := "0011111000";
		PCOMMA_DETECT : boolean := TRUE;
		REF_CLK_V_SEL : integer := 0;
		RX_BUFFER_USE : boolean := TRUE;
		RX_CRC_USE : boolean := FALSE;
		RX_DATA_WIDTH : integer := 2;
		RX_DECODE_USE : boolean := TRUE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		SERDES_10B : boolean := FALSE;
		TERMINATION_IMP : integer := 50;
		TX_BUFFER_USE : boolean := TRUE;
		TX_CRC_FORCE_VALUE : bit_vector := "11010110";
		TX_CRC_USE : boolean := FALSE;
		TX_DATA_WIDTH : integer := 2;
		TX_DIFF_CTRL : integer := 500;
		TX_PREEMPHASIS : integer := 0

  );


port (
		CHBONDDONE : out std_ulogic;
		CHBONDO : out std_logic_vector(3 downto 0);
		CONFIGOUT : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(3 downto 0);
		RXCHARISK : out std_logic_vector(3 downto 0);
		RXCHECKINGCRC : out std_ulogic;
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXCRCERR : out std_ulogic;
		RXDATA : out std_logic_vector(31 downto 0);
		RXDISPERR : out std_logic_vector(3 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(3 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(3 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(3 downto 0);
		TXN : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(3 downto 0);

		BREFCLK : in std_ulogic := 'X';
		BREFCLK2 : in std_ulogic := 'X';
		CHBONDI : in std_logic_vector(3 downto 0);
		CONFIGENABLE : in std_ulogic;
		CONFIGIN : in std_ulogic;
		ENCHANSYNC : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK : in std_ulogic;
		REFCLK2 : in std_ulogic;
		REFCLKSEL : in std_ulogic;
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(3 downto 0);
		TXCHARDISPMODE : in std_logic_vector(3 downto 0);
		TXCHARDISPVAL : in std_logic_vector(3 downto 0);
		TXCHARISK : in std_logic_vector(3 downto 0);
		TXDATA : in std_logic_vector(31 downto 0);
		TXFORCECRCERR : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT : component is true;
attribute black_box_pad_pin of GT : component is "RXN,RXP,TXN,TXP";

component GT11
generic (
		ALIGN_COMMA_WORD : integer := 1;
		BANDGAPSEL : boolean := FALSE;
		CCCB_ARBITRATOR_DISABLE : boolean := FALSE;
		CHAN_BOND_LIMIT : integer := 16;
		CHAN_BOND_MODE : string := "NONE";
		CHAN_BOND_ONE_SHOT : boolean := FALSE;
		CHAN_BOND_SEQ_1_1 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_1_2 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_1_3 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_1_4 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_1_MASK : bit_vector := "0000";
		CHAN_BOND_SEQ_2_1 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_2_2 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_2_3 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_2_4 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_2_MASK : bit_vector := "0000";
		CHAN_BOND_SEQ_2_USE : boolean := FALSE;
		CHAN_BOND_SEQ_LEN : integer := 1;
		CLK_CORRECT_USE : boolean := TRUE;
		CLK_COR_8B10B_DE : boolean := FALSE;
		CLK_COR_MAX_LAT : integer := 36;
		CLK_COR_MIN_LAT : integer := 28;
		CLK_COR_SEQ_1_2 : bit_vector := "00000000000";
		CLK_COR_SEQ_1_3 : bit_vector := "00000000000";
		CLK_COR_SEQ_1_4 : bit_vector := "00000000000";
		CLK_COR_SEQ_1_MASK : bit_vector := "0000";
		CLK_COR_SEQ_2_1 : bit_vector := "00000000000";
		CLK_COR_SEQ_2_2 : bit_vector := "00000000000";
		CLK_COR_SEQ_2_3 : bit_vector := "00000000000";
		CLK_COR_SEQ_2_4 : bit_vector := "00000000000";
		CLK_COR_SEQ_2_MASK : bit_vector := "0000";
		CLK_COR_SEQ_2_USE : boolean := FALSE;
		CLK_COR_SEQ_DROP : boolean := FALSE;
		CLK_COR_SEQ_LEN : integer := 1;
		COMMA32 : boolean := FALSE;
		COMMA_10B_MASK : bit_vector := X"3FF";
		CYCLE_LIMIT_SEL : bit_vector := "00";
		DCDR_FILTER : bit_vector := "010";
		DEC_MCOMMA_DETECT : boolean := TRUE;
		DEC_PCOMMA_DETECT : boolean := TRUE;
		DEC_VALID_COMMA_ONLY : boolean := TRUE;
		DIGRX_FWDCLK : bit_vector := "00";
		DIGRX_SYNC_MODE : boolean := FALSE;
		ENABLE_DCDR : boolean := FALSE;
		FDET_HYS_CAL : bit_vector := "110";
		FDET_HYS_SEL : bit_vector := "110";
		FDET_LCK_CAL : bit_vector := "101";
		FDET_LCK_SEL : bit_vector := "101";
		LOOPCAL_WAIT : bit_vector := "00";
		MCOMMA_32B_VALUE : bit_vector := X"A1A1A2A2";
		MCOMMA_DETECT : boolean := TRUE;
		OPPOSITE_SELECT : boolean := FALSE;
		PCOMMA_32B_VALUE : bit_vector := X"A1A1A2A2";
		PCOMMA_DETECT : boolean := TRUE;
		PCS_BIT_SLIP : boolean := FALSE;
		PMACLKENABLE : boolean := TRUE;
		PMACOREPWRENABLE : boolean := TRUE;
		PMA_BIT_SLIP : boolean := FALSE;
		POWER_ENABLE : boolean := TRUE;
		REPEATER : boolean := FALSE;
		RXAFEEQ : bit_vector := "000000000";
		RXASYNCDIVIDE : bit_vector := "00";
		RXBY_32 : boolean := TRUE;
		RXCDRLOS : bit_vector := "000000";
		RXCLK0_FORCE_PMACLK : boolean := FALSE;
		RXCLKMODE : bit_vector := "110001";
		RXCPSEL : boolean := TRUE;
		RXCRCCLOCKDOUBLE : boolean := FALSE;
		RXCRCENABLE : boolean := FALSE;
		RXCRCINITVAL : bit_vector := X"00000000";
		RXCRCINVERTGEN : boolean := FALSE;
		RXCRCSAMECLOCK : boolean := FALSE;
		RXCYCLE_LIMIT_SEL : bit_vector := "00";
		RXDATA_SEL : bit_vector := "00";
		RXDCCOUPLE : boolean := FALSE;
		RXDIGRESET : boolean := FALSE;
		RXDIGRX : boolean := FALSE;
		RXENABLE : boolean := TRUE;
		RXEQ : bit_vector := X"4000000000000000";
		RXFDCAL_CLOCK_DIVIDE : string := "NONE";
		RXFDET_HYS_CAL : bit_vector := "110";
		RXFDET_HYS_SEL : bit_vector := "110";
		RXFDET_LCK_CAL : bit_vector := "101";
		RXFDET_LCK_SEL : bit_vector := "101";
		RXLB : boolean := FALSE;
		RXLKADJ : bit_vector := "00000";
		RXLOOPCAL_WAIT : bit_vector := "00";
		RXLOOPFILT : bit_vector := "0111";
		RXOUTDIV2SEL_A : bit_vector := "0000";
		RXOUTDIV2SEL_B : bit_vector := "0000";
		RXPD : boolean := FALSE;
		RXPLLNDIVSEL : bit_vector := "0000";
		RXPMACLKSEL : string := "REFCLK1";
		RXRCPADJ : bit_vector := "011";
		RXRECCLK1_USE_SYNC : boolean := FALSE;
		RXSLOWDOWN_CAL : bit_vector := "00";
		RXTADJ : boolean := FALSE;
		RXUSRDIVISOR : integer := 1;
		RXVCODAC_INIT : bit_vector := "1010110011";
		RXVCO_CTRL_ENABLE : boolean := TRUE;
		RX_BUFFER_USE : boolean := TRUE;
		RX_CLOCK_DIVIDER : bit_vector := "00";
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		SAMPLE_8X : boolean := FALSE;
		SH_CNT_MAX : integer := 64;
		SH_INVALID_CNT_MAX : integer := 16;
		SLOWDOWN_CAL : bit_vector := "00";
		TXABPMACLKSEL : string := "REFCLK1";
		TXASYNCDIVIDE : bit_vector := "00";
		TXCLK0_FORCE_PMACLK : boolean := FALSE;
		TXCLKMODE : bit_vector := "1001";
		TXCPSEL : boolean := TRUE;
		TXCRCCLOCKDOUBLE : boolean := FALSE;
		TXCRCENABLE : boolean := FALSE;
		TXCRCINITVAL : bit_vector := X"00000000";
		TXCRCINVERTGEN : boolean := FALSE;
		TXCRCSAMECLOCK : boolean := FALSE;
		TXDATA_SEL : bit_vector := "00";
		TXDAT_PRDRV_DAC : bit_vector := "111";
		TXDAT_TAP_DAC : bit_vector := "10110";
		TXENABLE : boolean := TRUE;
		TXFDCAL_CLOCK_DIVIDE : string := "NONE";
		TXHIGHSIGNALEN : boolean := TRUE;
		TXLOOPFILT : bit_vector := "0111";
		TXOUTCLK1_USE_SYNC : boolean := FALSE;
		TXOUTDIV2SEL : bit_vector := "0000";
		TXPD : boolean := FALSE;
		TXPHASESEL : boolean := FALSE;
		TXPLLNDIVSEL : bit_vector := "0000";
		TXPOST_PRDRV_DAC : bit_vector := "111";
		TXPOST_TAP_DAC : bit_vector := "01110";
		TXPOST_TAP_PD : boolean := TRUE;
		TXPRE_PRDRV_DAC : bit_vector := "111";
		TXPRE_TAP_DAC : bit_vector := "00000";
		TXPRE_TAP_PD : boolean := TRUE;
		TXSLEWRATE : boolean := FALSE;
		TXTERMTRIM : bit_vector := "1100";
		TX_BUFFER_USE : boolean := TRUE;
		TX_CLOCK_DIVIDER : bit_vector := "00";
		VCODAC_INIT : bit_vector := "1010110011";
		VCO_CTRL_ENABLE : boolean := TRUE

  );

port (
		CHBONDO : out std_logic_vector(4 downto 0);
		DO : out std_logic_vector(15 downto 0);
		DRDY : out std_ulogic;
		RXBUFERR : out std_ulogic;
		RXCALFAIL : out std_ulogic;
		RXCHARISCOMMA : out std_logic_vector(7 downto 0);
		RXCHARISK : out std_logic_vector(7 downto 0);
		RXCOMMADET : out std_ulogic;
		RXCRCOUT : out std_logic_vector(31 downto 0);
		RXCYCLELIMIT : out std_ulogic;
		RXDATA : out std_logic_vector(63 downto 0);
		RXDISPERR : out std_logic_vector(7 downto 0);
		RXLOCK : out std_ulogic;
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXMCLK : out std_ulogic;
		RXNOTINTABLE : out std_logic_vector(7 downto 0);
		RXPCSHCLKOUT : out std_ulogic;
		RXREALIGN : out std_ulogic;
		RXRECCLK1 : out std_ulogic;
		RXRECCLK2 : out std_ulogic;
		RXRUNDISP : out std_logic_vector(7 downto 0);
		RXSIGDET : out std_ulogic;
		RXSTATUS : out std_logic_vector(5 downto 0);
		TX1N : out std_ulogic;
		TX1P : out std_ulogic;
		TXBUFERR : out std_ulogic;
		TXCALFAIL : out std_ulogic;
		TXCRCOUT : out std_logic_vector(31 downto 0);
		TXCYCLELIMIT : out std_ulogic;
		TXKERR : out std_logic_vector(7 downto 0);
		TXLOCK : out std_ulogic;
		TXOUTCLK1 : out std_ulogic;
		TXOUTCLK2 : out std_ulogic;
		TXPCSHCLKOUT : out std_ulogic;
		TXRUNDISP : out std_logic_vector(7 downto 0);

		CHBONDI : in std_logic_vector(4 downto 0);
		DADDR : in std_logic_vector(7 downto 0);
		DCLK : in std_ulogic;
		DEN : in std_ulogic;
		DI : in std_logic_vector(15 downto 0);
		DWE : in std_ulogic;
		ENCHANSYNC : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		GREFCLK : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK1 : in std_ulogic;
		REFCLK2 : in std_ulogic;
		RX1N : in std_ulogic;
		RX1P : in std_ulogic;
		RXBLOCKSYNC64B66BUSE : in std_ulogic;
		RXCLKSTABLE : in std_ulogic;
		RXCOMMADETUSE : in std_ulogic;
		RXCRCCLK : in std_ulogic;
		RXCRCDATAVALID : in std_ulogic;
		RXCRCDATAWIDTH : in std_logic_vector(2 downto 0);
		RXCRCIN : in std_logic_vector(63 downto 0);
		RXCRCINIT : in std_ulogic;
		RXCRCINTCLK : in std_ulogic;
		RXCRCPD : in std_ulogic;
		RXCRCRESET : in std_ulogic;
		RXDATAWIDTH : in std_logic_vector(1 downto 0);
		RXDEC64B66BUSE : in std_ulogic;
		RXDEC8B10BUSE : in std_ulogic;
		RXDESCRAM64B66BUSE : in std_ulogic;
		RXIGNOREBTF : in std_ulogic;
		RXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		RXPMARESET : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXSLIDE : in std_ulogic;
		RXSYNC : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(7 downto 0);
		TXCHARDISPMODE : in std_logic_vector(7 downto 0);
		TXCHARDISPVAL : in std_logic_vector(7 downto 0);
		TXCHARISK : in std_logic_vector(7 downto 0);
		TXCLKSTABLE : in std_ulogic;
		TXCRCCLK : in std_ulogic;
		TXCRCDATAVALID : in std_ulogic;
		TXCRCDATAWIDTH : in std_logic_vector(2 downto 0);
		TXCRCIN : in std_logic_vector(63 downto 0);
		TXCRCINIT : in std_ulogic;
		TXCRCINTCLK : in std_ulogic;
		TXCRCPD : in std_ulogic;
		TXCRCRESET : in std_ulogic;
		TXDATA : in std_logic_vector(63 downto 0);
		TXDATAWIDTH : in std_logic_vector(1 downto 0);
		TXENC64B66BUSE : in std_ulogic;
		TXENC8B10BUSE : in std_ulogic;
		TXENOOB : in std_ulogic;
		TXGEARBOX64B66BUSE : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		TXPMARESET : in std_ulogic;
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXSCRAM64B66BUSE : in std_ulogic;
		TXSYNC : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT11 : component is true;
attribute black_box_pad_pin of GT11 : component is "RXN,RXP,TXN,TXP";

component GT11_CUSTOM
generic (
		ALIGN_COMMA_WORD : integer := 1;
		BANDGAPSEL : boolean := FALSE;
		CCCB_ARBITRATOR_DISABLE : boolean := FALSE;
		CHAN_BOND_LIMIT : integer := 16;
		CHAN_BOND_MODE : string := "NONE";
		CHAN_BOND_ONE_SHOT : boolean := FALSE;
		CHAN_BOND_SEQ_1_1 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_1_2 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_1_3 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_1_4 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_1_MASK : bit_vector := "0000";
		CHAN_BOND_SEQ_2_1 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_2_2 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_2_3 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_2_4 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_2_MASK : bit_vector := "0000";
		CHAN_BOND_SEQ_2_USE : boolean := FALSE;
		CHAN_BOND_SEQ_LEN : integer := 1;
		CLK_CORRECT_USE : boolean := TRUE;
		CLK_COR_8B10B_DE : boolean := FALSE;
		CLK_COR_MAX_LAT : integer := 36;
		CLK_COR_MIN_LAT : integer := 28;
		CLK_COR_SEQ_1_2 : bit_vector := "00000000000";
		CLK_COR_SEQ_1_3 : bit_vector := "00000000000";
		CLK_COR_SEQ_1_4 : bit_vector := "00000000000";
		CLK_COR_SEQ_1_MASK : bit_vector := "0000";
		CLK_COR_SEQ_2_1 : bit_vector := "00000000000";
		CLK_COR_SEQ_2_2 : bit_vector := "00000000000";
		CLK_COR_SEQ_2_3 : bit_vector := "00000000000";
		CLK_COR_SEQ_2_4 : bit_vector := "00000000000";
		CLK_COR_SEQ_2_MASK : bit_vector := "0000";
		CLK_COR_SEQ_2_USE : boolean := FALSE;
		CLK_COR_SEQ_DROP : boolean := FALSE;
		CLK_COR_SEQ_LEN : integer := 1;
		COMMA32 : boolean := FALSE;
		COMMA_10B_MASK : bit_vector := X"3FF";
		CYCLE_LIMIT_SEL : bit_vector := "00";
		DCDR_FILTER : bit_vector := "010";
		DEC_MCOMMA_DETECT : boolean := TRUE;
		DEC_PCOMMA_DETECT : boolean := TRUE;
		DEC_VALID_COMMA_ONLY : boolean := TRUE;
		DIGRX_FWDCLK : bit_vector := "00";
		DIGRX_SYNC_MODE : boolean := FALSE;
		ENABLE_DCDR : boolean := FALSE;
		FDET_HYS_CAL : bit_vector := "110";
		FDET_HYS_SEL : bit_vector := "110";
		FDET_LCK_CAL : bit_vector := "101";
		FDET_LCK_SEL : bit_vector := "101";
		LOOPCAL_WAIT : bit_vector := "00";
		MCOMMA_32B_VALUE : bit_vector := X"A1A1A2A2";
		MCOMMA_DETECT : boolean := TRUE;
		OPPOSITE_SELECT : boolean := FALSE;
		PCOMMA_32B_VALUE : bit_vector := X"A1A1A2A2";
		PCOMMA_DETECT : boolean := TRUE;
		PCS_BIT_SLIP : boolean := FALSE;
		PMACLKENABLE : boolean := TRUE;
		PMACOREPWRENABLE : boolean := TRUE;
		PMA_BIT_SLIP : boolean := FALSE;
		POWER_ENABLE : boolean := TRUE;
		REPEATER : boolean := FALSE;
		RXAFEEQ : bit_vector := "000000000";
		RXASYNCDIVIDE : bit_vector := "00";
		RXBY_32 : boolean := TRUE;
		RXCDRLOS : bit_vector := "000000";
		RXCLK0_FORCE_PMACLK : boolean := FALSE;
		RXCLKMODE : bit_vector := "110001";
		RXCPSEL : boolean := TRUE;
		RXCRCCLOCKDOUBLE : boolean := FALSE;
		RXCRCENABLE : boolean := FALSE;
		RXCRCINITVAL : bit_vector := X"00000000";
		RXCRCINVERTGEN : boolean := FALSE;
		RXCRCSAMECLOCK : boolean := FALSE;
		RXCYCLE_LIMIT_SEL : bit_vector := "00";
		RXDATA_SEL : bit_vector := "00";
		RXDCCOUPLE : boolean := FALSE;
		RXDIGRESET : boolean := FALSE;
		RXDIGRX : boolean := FALSE;
		RXENABLE : boolean := TRUE;
		RXEQ : bit_vector := X"4000000000000000";
		RXFDCAL_CLOCK_DIVIDE : string := "NONE";
		RXFDET_HYS_CAL : bit_vector := "110";
		RXFDET_HYS_SEL : bit_vector := "110";
		RXFDET_LCK_CAL : bit_vector := "101";
		RXFDET_LCK_SEL : bit_vector := "101";
		RXLB : boolean := FALSE;
		RXLKADJ : bit_vector := "00000";
		RXLOOPCAL_WAIT : bit_vector := "00";
		RXLOOPFILT : bit_vector := "0111";
		RXOUTDIV2SEL_A : bit_vector := "0000";
		RXOUTDIV2SEL_B : bit_vector := "0000";
		RXPD : boolean := FALSE;
		RXPLLNDIVSEL : bit_vector := "0000";
		RXPMACLKSEL : string := "REFCLK1";
		RXRCPADJ : bit_vector := "011";
		RXRECCLK1_USE_SYNC : boolean := FALSE;
		RXSLOWDOWN_CAL : bit_vector := "00";
		RXTADJ : boolean := FALSE;
		RXUSRDIVISOR : integer := 1;
		RXVCODAC_INIT : bit_vector := "1010110011";
		RXVCO_CTRL_ENABLE : boolean := TRUE;
		RX_BUFFER_USE : boolean := TRUE;
		RX_CLOCK_DIVIDER : bit_vector := "00";
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		SAMPLE_8X : boolean := FALSE;
		SH_CNT_MAX : integer := 64;
		SH_INVALID_CNT_MAX : integer := 16;
		SLOWDOWN_CAL : bit_vector := "00";
		TXABPMACLKSEL : string := "REFCLK1";
		TXASYNCDIVIDE : bit_vector := "00";
		TXCLK0_FORCE_PMACLK : boolean := FALSE;
		TXCLKMODE : bit_vector := "1001";
		TXCPSEL : boolean := TRUE;
		TXCRCCLOCKDOUBLE : boolean := FALSE;
		TXCRCENABLE : boolean := FALSE;
		TXCRCINITVAL : bit_vector := X"00000000";
		TXCRCINVERTGEN : boolean := FALSE;
		TXCRCSAMECLOCK : boolean := FALSE;
		TXDATA_SEL : bit_vector := "00";
		TXDAT_PRDRV_DAC : bit_vector := "111";
		TXDAT_TAP_DAC : bit_vector := "10110";
		TXENABLE : boolean := TRUE;
		TXFDCAL_CLOCK_DIVIDE : string := "NONE";
		TXHIGHSIGNALEN : boolean := TRUE;
		TXLOOPFILT : bit_vector := "0111";
		TXOUTCLK1_USE_SYNC : boolean := FALSE;
		TXOUTDIV2SEL : bit_vector := "0000";
		TXPD : boolean := FALSE;
		TXPHASESEL : boolean := FALSE;
		TXPLLNDIVSEL : bit_vector := "0000";
		TXPOST_PRDRV_DAC : bit_vector := "111";
		TXPOST_TAP_DAC : bit_vector := "01110";
		TXPOST_TAP_PD : boolean := TRUE;
		TXPRE_PRDRV_DAC : bit_vector := "111";
		TXPRE_TAP_DAC : bit_vector := "00000";
		TXPRE_TAP_PD : boolean := TRUE;
		TXSLEWRATE : boolean := FALSE;
		TXTERMTRIM : bit_vector := "1100";
		TX_BUFFER_USE : boolean := TRUE;
		TX_CLOCK_DIVIDER : bit_vector := "00";
		VCODAC_INIT : bit_vector := "1010110011";
		VCO_CTRL_ENABLE : boolean := TRUE


  );

port (
		CHBONDO : out std_logic_vector(4 downto 0);
		DO : out std_logic_vector(15 downto 0);
		DRDY : out std_ulogic;
		RXBUFERR : out std_ulogic;
		RXCALFAIL : out std_ulogic;
		RXCHARISCOMMA : out std_logic_vector(7 downto 0);
		RXCHARISK : out std_logic_vector(7 downto 0);
		RXCOMMADET : out std_ulogic;
		RXCRCOUT : out std_logic_vector(31 downto 0);
		RXCYCLELIMIT : out std_ulogic;
		RXDATA : out std_logic_vector(63 downto 0);
		RXDISPERR : out std_logic_vector(7 downto 0);
		RXLOCK : out std_ulogic;
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXMCLK : out std_ulogic;
		RXNOTINTABLE : out std_logic_vector(7 downto 0);
		RXPCSHCLKOUT : out std_ulogic;
		RXREALIGN : out std_ulogic;
		RXRECCLK1 : out std_ulogic;
		RXRECCLK2 : out std_ulogic;
		RXRUNDISP : out std_logic_vector(7 downto 0);
		RXSIGDET : out std_ulogic;
		RXSTATUS : out std_logic_vector(5 downto 0);
		TX1N : out std_ulogic;
		TX1P : out std_ulogic;
		TXBUFERR : out std_ulogic;
		TXCALFAIL : out std_ulogic;
		TXCRCOUT : out std_logic_vector(31 downto 0);
		TXCYCLELIMIT : out std_ulogic;
		TXKERR : out std_logic_vector(7 downto 0);
		TXLOCK : out std_ulogic;
		TXOUTCLK1 : out std_ulogic;
		TXOUTCLK2 : out std_ulogic;
		TXPCSHCLKOUT : out std_ulogic;
		TXRUNDISP : out std_logic_vector(7 downto 0);

		CHBONDI : in std_logic_vector(4 downto 0);
		DADDR : in std_logic_vector(7 downto 0);
		DCLK : in std_ulogic;
		DEN : in std_ulogic;
		DI : in std_logic_vector(15 downto 0);
		DWE : in std_ulogic;
		ENCHANSYNC : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		GREFCLK : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK1 : in std_ulogic;
		REFCLK2 : in std_ulogic;
		RX1N : in std_ulogic;
		RX1P : in std_ulogic;
		RXBLOCKSYNC64B66BUSE : in std_ulogic;
		RXCLKSTABLE : in std_ulogic;
		RXCOMMADETUSE : in std_ulogic;
		RXCRCCLK : in std_ulogic;
		RXCRCDATAVALID : in std_ulogic;
		RXCRCDATAWIDTH : in std_logic_vector(2 downto 0);
		RXCRCIN : in std_logic_vector(63 downto 0);
		RXCRCINIT : in std_ulogic;
		RXCRCINTCLK : in std_ulogic;
		RXCRCPD : in std_ulogic;
		RXCRCRESET : in std_ulogic;
		RXDATAWIDTH : in std_logic_vector(1 downto 0);
		RXDEC64B66BUSE : in std_ulogic;
		RXDEC8B10BUSE : in std_ulogic;
		RXDESCRAM64B66BUSE : in std_ulogic;
		RXIGNOREBTF : in std_ulogic;
		RXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		RXPMARESET : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXSLIDE : in std_ulogic;
		RXSYNC : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(7 downto 0);
		TXCHARDISPMODE : in std_logic_vector(7 downto 0);
		TXCHARDISPVAL : in std_logic_vector(7 downto 0);
		TXCHARISK : in std_logic_vector(7 downto 0);
		TXCLKSTABLE : in std_ulogic;
		TXCRCCLK : in std_ulogic;
		TXCRCDATAVALID : in std_ulogic;
		TXCRCDATAWIDTH : in std_logic_vector(2 downto 0);
		TXCRCIN : in std_logic_vector(63 downto 0);
		TXCRCINIT : in std_ulogic;
		TXCRCINTCLK : in std_ulogic;
		TXCRCPD : in std_ulogic;
		TXCRCRESET : in std_ulogic;
		TXDATA : in std_logic_vector(63 downto 0);
		TXDATAWIDTH : in std_logic_vector(1 downto 0);
		TXENC64B66BUSE : in std_ulogic;
		TXENC8B10BUSE : in std_ulogic;
		TXENOOB : in std_ulogic;
		TXGEARBOX64B66BUSE : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		TXPMARESET : in std_ulogic;
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXSCRAM64B66BUSE : in std_ulogic;
		TXSYNC : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic
     );
end component;
attribute syn_black_box of GT11_CUSTOM : component is true;
attribute black_box_pad_pin of GT11_CUSTOM : component is "RXN,RXP,TXN,TXP";

component GT11CLK
-- synopsys translate_off
generic (
		REFCLKSEL : string := "MGTCLK";
		SYNCLK1OUTEN : string := "ENABLE";
		SYNCLK2OUTEN : string := "DISABLE"

  );

-- synopsys translate_on
port (
		SYNCLK1OUT : out std_ulogic;
		SYNCLK2OUT : out std_ulogic;

		MGTCLKN : in std_ulogic;
		MGTCLKP : in std_ulogic;
		REFCLK : in std_ulogic;
		RXBCLK : in std_ulogic;
		SYNCLK1IN : in std_ulogic;
		SYNCLK2IN : in std_ulogic

     );
end component;
attribute syn_black_box of GT11CLK : component is true;
attribute black_box_pad_pin of GT11CLK : component is "RXN,RXP,TXN,TXP";

component GT11CLK_MGT
generic (
    SYNCLK1OUTEN : string := "ENABLE";
    SYNCLK2OUTEN : string := "DISABLE"

  );

port (
		SYNCLK1OUT : out std_ulogic;
		SYNCLK2OUT : out std_ulogic;

		MGTCLKN : in std_ulogic;
		MGTCLKP : in std_ulogic

     );
end component;
attribute syn_black_box of GT11CLK_MGT : component is true;
attribute black_box_pad_pin of GT11CLK_MGT : component is "RXN,RXP,TXN,TXP";

component GT_AURORA_1
generic (
		CHAN_BOND_MODE : string := "OFF";
		CHAN_BOND_ONE_SHOT : boolean := FALSE;
		CLK_COR_INSERT_IDLE_FLAG : boolean := FALSE;
		CLK_COR_KEEP_IDLE : boolean := FALSE;
		CLK_COR_REPEAT_WAIT : integer := 1;
		REF_CLK_V_SEL : integer := 0;
		RX_CRC_USE : boolean := FALSE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		SERDES_10B : boolean := FALSE;
		TERMINATION_IMP : integer := 50;
		TX_CRC_FORCE_VALUE : bit_vector := "11010110";
		TX_CRC_USE : boolean := FALSE;
		TX_DIFF_CTRL : integer := 500;
		TX_PREEMPHASIS : integer := 0

  );

port (
		CHBONDDONE : out std_ulogic;
		CHBONDO : out std_logic_vector(3 downto 0);
		CONFIGOUT : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(0 downto 0);
		RXCHARISK : out std_logic_vector(0 downto 0);
		RXCHECKINGCRC : out std_ulogic;
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXCRCERR : out std_ulogic;
		RXDATA : out std_logic_vector(7 downto 0);
		RXDISPERR : out std_logic_vector(0 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(0 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(0 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(0 downto 0);
		TXN : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(0 downto 0);

		BREFCLK : in std_ulogic := 'X';
		BREFCLK2 : in std_ulogic := 'X';
		CHBONDI : in std_logic_vector(3 downto 0);
		CONFIGENABLE : in std_ulogic;
		CONFIGIN : in std_ulogic;
		ENCHANSYNC : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK : in std_ulogic;
		REFCLK2 : in std_ulogic;
		REFCLKSEL : in std_ulogic;
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(0 downto 0);
		TXCHARDISPMODE : in std_logic_vector(0 downto 0);
		TXCHARDISPVAL : in std_logic_vector(0 downto 0);
		TXCHARISK : in std_logic_vector(0 downto 0);
		TXDATA : in std_logic_vector(7 downto 0);
		TXFORCECRCERR : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT_AURORA_1 : component is true;
attribute black_box_pad_pin of GT_AURORA_1 : component is "RXN,RXP,TXN,TXP";

component GT_AURORA_2
generic (
		CHAN_BOND_MODE : string := "OFF";
		CHAN_BOND_ONE_SHOT : boolean := FALSE;
		CLK_COR_INSERT_IDLE_FLAG : boolean := FALSE;
		CLK_COR_KEEP_IDLE : boolean := FALSE;
		CLK_COR_REPEAT_WAIT : integer := 1;
		REF_CLK_V_SEL : integer := 0;
		RX_CRC_USE : boolean := FALSE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		SERDES_10B : boolean := FALSE;
		TERMINATION_IMP : integer := 50;
		TX_CRC_FORCE_VALUE : bit_vector := "11010110";
		TX_CRC_USE : boolean := FALSE;
		TX_DIFF_CTRL : integer := 500;
		TX_PREEMPHASIS : integer := 0

  );

port (
		CHBONDDONE : out std_ulogic;
		CHBONDO : out std_logic_vector(3 downto 0);
		CONFIGOUT : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(1 downto 0);
		RXCHARISK : out std_logic_vector(1 downto 0);
		RXCHECKINGCRC : out std_ulogic;
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXCRCERR : out std_ulogic;
		RXDATA : out std_logic_vector(15 downto 0);
		RXDISPERR : out std_logic_vector(1 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(1 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(1 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(1 downto 0);
		TXN : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(1 downto 0);

		BREFCLK : in std_ulogic := 'X';
		BREFCLK2 : in std_ulogic := 'X';
		CHBONDI : in std_logic_vector(3 downto 0);
		CONFIGENABLE : in std_ulogic;
		CONFIGIN : in std_ulogic;
		ENCHANSYNC : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK : in std_ulogic;
		REFCLK2 : in std_ulogic;
		REFCLKSEL : in std_ulogic;
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(1 downto 0);
		TXCHARDISPMODE : in std_logic_vector(1 downto 0);
		TXCHARDISPVAL : in std_logic_vector(1 downto 0);
		TXCHARISK : in std_logic_vector(1 downto 0);
		TXDATA : in std_logic_vector(15 downto 0);
		TXFORCECRCERR : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT_AURORA_2 : component is true;
attribute black_box_pad_pin of GT_AURORA_2 : component is "RXN,RXP,TXN,TXP";

component GT_AURORA_4
generic (
		CHAN_BOND_MODE : string := "OFF";
		CHAN_BOND_ONE_SHOT : boolean := FALSE;
		CLK_COR_INSERT_IDLE_FLAG : boolean := FALSE;
		CLK_COR_KEEP_IDLE : boolean := FALSE;
		CLK_COR_REPEAT_WAIT : integer := 1;
		REF_CLK_V_SEL : integer := 0;
		RX_CRC_USE : boolean := FALSE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		SERDES_10B : boolean := FALSE;
		TERMINATION_IMP : integer := 50;
		TX_CRC_FORCE_VALUE : bit_vector := "11010110";
		TX_CRC_USE : boolean := FALSE;
		TX_DIFF_CTRL : integer := 500;
		TX_PREEMPHASIS : integer := 0

  );

port (
		CHBONDDONE : out std_ulogic;
		CHBONDO : out std_logic_vector(3 downto 0);
		CONFIGOUT : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(3 downto 0);
		RXCHARISK : out std_logic_vector(3 downto 0);
		RXCHECKINGCRC : out std_ulogic;
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXCRCERR : out std_ulogic;
		RXDATA : out std_logic_vector(31 downto 0);
		RXDISPERR : out std_logic_vector(3 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(3 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(3 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(3 downto 0);
		TXN : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(3 downto 0);

		BREFCLK : in std_ulogic := 'X';
		BREFCLK2 : in std_ulogic := 'X';
		CHBONDI : in std_logic_vector(3 downto 0);
		CONFIGENABLE : in std_ulogic;
		CONFIGIN : in std_ulogic;
		ENCHANSYNC : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK : in std_ulogic;
		REFCLK2 : in std_ulogic;
		REFCLKSEL : in std_ulogic;
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(3 downto 0);
		TXCHARDISPMODE : in std_logic_vector(3 downto 0);
		TXCHARDISPVAL : in std_logic_vector(3 downto 0);
		TXCHARISK : in std_logic_vector(3 downto 0);
		TXDATA : in std_logic_vector(31 downto 0);
		TXFORCECRCERR : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT_AURORA_4 : component is true;
attribute black_box_pad_pin of GT_AURORA_4 : component is "RXN,RXP,TXN,TXP";

component GT_CUSTOM
generic (
		ALIGN_COMMA_MSB : boolean := FALSE;
		CHAN_BOND_LIMIT : integer := 16;
		CHAN_BOND_MODE : string := "OFF";
		CHAN_BOND_OFFSET : integer := 8;
		CHAN_BOND_ONE_SHOT : boolean := FALSE;
		CHAN_BOND_SEQ_1_1 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_1_2 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_1_3 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_1_4 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_2_1 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_2_2 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_2_3 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_2_4 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_2_USE : boolean := FALSE;
		CHAN_BOND_SEQ_LEN : integer := 1;
		CHAN_BOND_WAIT : integer := 8;
		CLK_COR_INSERT_IDLE_FLAG : boolean := FALSE;
		CLK_COR_KEEP_IDLE : boolean := FALSE;
		CLK_COR_REPEAT_WAIT : integer := 1;
		CLK_COR_SEQ_1_1 : bit_vector := "00000000000";
		CLK_COR_SEQ_1_2 : bit_vector := "00000000000";
		CLK_COR_SEQ_1_3 : bit_vector := "00000000000";
		CLK_COR_SEQ_1_4 : bit_vector := "00000000000";
		CLK_COR_SEQ_2_1 : bit_vector := "00000000000";
		CLK_COR_SEQ_2_2 : bit_vector := "00000000000";
		CLK_COR_SEQ_2_3 : bit_vector := "00000000000";
		CLK_COR_SEQ_2_4 : bit_vector := "00000000000";
		CLK_COR_SEQ_2_USE : boolean := FALSE;
		CLK_COR_SEQ_LEN : integer := 1;
		CLK_CORRECT_USE : boolean := TRUE;
		COMMA_10B_MASK : bit_vector := "1111111000";
		CRC_END_OF_PKT : string := "K29_7";
		CRC_FORMAT : string := "USER_MODE";
		CRC_START_OF_PKT : string := "K27_7";
		DEC_MCOMMA_DETECT : boolean := TRUE;
		DEC_PCOMMA_DETECT : boolean := TRUE;
		DEC_VALID_COMMA_ONLY : boolean := TRUE;
		MCOMMA_10B_VALUE : bit_vector := "1100000000";
		MCOMMA_DETECT : boolean := TRUE;
		PCOMMA_10B_VALUE : bit_vector := "0011111000";
		PCOMMA_DETECT : boolean := TRUE;
		REF_CLK_V_SEL : integer := 0;
		RX_BUFFER_USE : boolean := TRUE;
		RX_CRC_USE : boolean := FALSE;
		RX_DATA_WIDTH : integer := 2;
		RX_DECODE_USE : boolean := TRUE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		SERDES_10B : boolean := FALSE;
		TERMINATION_IMP : integer := 50;
		TX_BUFFER_USE : boolean := TRUE;
		TX_CRC_FORCE_VALUE : bit_vector := "11010110";
		TX_CRC_USE : boolean := FALSE;
		TX_DATA_WIDTH : integer := 2;
		TX_DIFF_CTRL : integer := 500;
		TX_PREEMPHASIS : integer := 0

  );

port (
		CHBONDDONE : out std_ulogic;
		CHBONDO : out std_logic_vector(3 downto 0);
		CONFIGOUT : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(3 downto 0);
		RXCHARISK : out std_logic_vector(3 downto 0);
		RXCHECKINGCRC : out std_ulogic;
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXCRCERR : out std_ulogic;
		RXDATA : out std_logic_vector(31 downto 0);
		RXDISPERR : out std_logic_vector(3 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(3 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(3 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(3 downto 0);
		TXN : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(3 downto 0);

		BREFCLK : in std_ulogic := 'X';
		BREFCLK2 : in std_ulogic := 'X';
		CHBONDI : in std_logic_vector(3 downto 0);
		CONFIGENABLE : in std_ulogic;
		CONFIGIN : in std_ulogic;
		ENCHANSYNC : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK : in std_ulogic;
		REFCLK2 : in std_ulogic;
		REFCLKSEL : in std_ulogic;
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(3 downto 0);
		TXCHARDISPMODE : in std_logic_vector(3 downto 0);
		TXCHARDISPVAL : in std_logic_vector(3 downto 0);
		TXCHARISK : in std_logic_vector(3 downto 0);
		TXDATA : in std_logic_vector(31 downto 0);
		TXFORCECRCERR : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT_CUSTOM : component is true;
attribute black_box_pad_pin of GT_CUSTOM : component is "RXN,RXP,TXN,TXP";

component GT_ETHERNET_1
generic (
		CLK_COR_INSERT_IDLE_FLAG : boolean := FALSE;
		CLK_COR_KEEP_IDLE : boolean := FALSE;
		CLK_COR_REPEAT_WAIT : integer := 1;
		REF_CLK_V_SEL : integer := 0;
		RX_CRC_USE : boolean := FALSE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		SERDES_10B : boolean := FALSE;
		TERMINATION_IMP : integer := 50;
		TX_CRC_FORCE_VALUE : bit_vector := "11010110";
		TX_CRC_USE : boolean := FALSE;
		TX_DIFF_CTRL : integer := 500;
		TX_PREEMPHASIS : integer := 0

  );

port (
		CONFIGOUT : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(0 downto 0);
		RXCHARISK : out std_logic_vector(0 downto 0);
		RXCHECKINGCRC : out std_ulogic;
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXCRCERR : out std_ulogic;
		RXDATA : out std_logic_vector(7 downto 0);
		RXDISPERR : out std_logic_vector(0 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(0 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(0 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(0 downto 0);
		TXN : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(0 downto 0);

		BREFCLK : in std_ulogic := 'X';
		BREFCLK2 : in std_ulogic := 'X';
		CONFIGENABLE : in std_ulogic;
		CONFIGIN : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK : in std_ulogic;
		REFCLK2 : in std_ulogic;
		REFCLKSEL : in std_ulogic;
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(0 downto 0);
		TXCHARDISPMODE : in std_logic_vector(0 downto 0);
		TXCHARDISPVAL : in std_logic_vector(0 downto 0);
		TXCHARISK : in std_logic_vector(0 downto 0);
		TXDATA : in std_logic_vector(7 downto 0);
		TXFORCECRCERR : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT_ETHERNET_1 : component is true;
attribute black_box_pad_pin of GT_ETHERNET_1 : component is "RXN,RXP,TXN,TXP";

component GT_ETHERNET_2
generic (
		CLK_COR_INSERT_IDLE_FLAG : boolean := FALSE;
		CLK_COR_KEEP_IDLE : boolean := FALSE;
		CLK_COR_REPEAT_WAIT : integer := 1;
		REF_CLK_V_SEL : integer := 0;
		RX_CRC_USE : boolean := FALSE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		SERDES_10B : boolean := FALSE;
		TERMINATION_IMP : integer := 50;
		TX_CRC_FORCE_VALUE : bit_vector := "11010110";
		TX_CRC_USE : boolean := FALSE;
		TX_DIFF_CTRL : integer := 500;
		TX_PREEMPHASIS : integer := 0

  );

port (
		CONFIGOUT : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(1 downto 0);
		RXCHARISK : out std_logic_vector(1 downto 0);
		RXCHECKINGCRC : out std_ulogic;
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXCRCERR : out std_ulogic;
		RXDATA : out std_logic_vector(15 downto 0);
		RXDISPERR : out std_logic_vector(1 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(1 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(1 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(1 downto 0);
		TXN : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(1 downto 0);

		BREFCLK : in std_ulogic := 'X';
		BREFCLK2 : in std_ulogic := 'X';
		CONFIGENABLE : in std_ulogic;
		CONFIGIN : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK : in std_ulogic;
		REFCLK2 : in std_ulogic;
		REFCLKSEL : in std_ulogic;
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(1 downto 0);
		TXCHARDISPMODE : in std_logic_vector(1 downto 0);
		TXCHARDISPVAL : in std_logic_vector(1 downto 0);
		TXCHARISK : in std_logic_vector(1 downto 0);
		TXDATA : in std_logic_vector(15 downto 0);
		TXFORCECRCERR : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT_ETHERNET_2 : component is true;
attribute black_box_pad_pin of GT_ETHERNET_2 : component is "RXN,RXP,TXN,TXP";

component GT_ETHERNET_4
generic (
		CLK_COR_INSERT_IDLE_FLAG : boolean := FALSE;
		CLK_COR_KEEP_IDLE : boolean := FALSE;
		CLK_COR_REPEAT_WAIT : integer := 1;
		REF_CLK_V_SEL : integer := 0;
		RX_CRC_USE : boolean := FALSE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		SERDES_10B : boolean := FALSE;
		TERMINATION_IMP : integer := 50;
		TX_CRC_FORCE_VALUE : bit_vector := "11010110";
		TX_CRC_USE : boolean := FALSE;
		TX_DIFF_CTRL : integer := 500;
		TX_PREEMPHASIS : integer := 0

  );

port (
		CONFIGOUT : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(3 downto 0);
		RXCHARISK : out std_logic_vector(3 downto 0);
		RXCHECKINGCRC : out std_ulogic;
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXCRCERR : out std_ulogic;
		RXDATA : out std_logic_vector(31 downto 0);
		RXDISPERR : out std_logic_vector(3 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(3 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(3 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(3 downto 0);
		TXN : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(3 downto 0);

		BREFCLK : in std_ulogic := 'X';
		BREFCLK2 : in std_ulogic := 'X';
		CONFIGENABLE : in std_ulogic;
		CONFIGIN : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK : in std_ulogic;
		REFCLK2 : in std_ulogic;
		REFCLKSEL : in std_ulogic;
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(3 downto 0);
		TXCHARDISPMODE : in std_logic_vector(3 downto 0);
		TXCHARDISPVAL : in std_logic_vector(3 downto 0);
		TXCHARISK : in std_logic_vector(3 downto 0);
		TXDATA : in std_logic_vector(31 downto 0);
		TXFORCECRCERR : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT_ETHERNET_4 : component is true;
attribute black_box_pad_pin of GT_ETHERNET_4 : component is "RXN,RXP,TXN,TXP";

component GT_FIBRE_CHAN_1
generic (
		CLK_COR_INSERT_IDLE_FLAG : boolean := FALSE;
		CLK_COR_KEEP_IDLE : boolean := FALSE;
		CLK_COR_REPEAT_WAIT : integer := 2;
		REF_CLK_V_SEL : integer := 0;
		RX_CRC_USE : boolean := FALSE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		SERDES_10B : boolean := FALSE;
		TERMINATION_IMP : integer := 50;
		TX_CRC_FORCE_VALUE : bit_vector := "11010110";
		TX_CRC_USE : boolean := FALSE;
		TX_DIFF_CTRL : integer := 500;
		TX_PREEMPHASIS : integer := 0

  );

port (
		CONFIGOUT : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(0 downto 0);
		RXCHARISK : out std_logic_vector(0 downto 0);
		RXCHECKINGCRC : out std_ulogic;
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXCRCERR : out std_ulogic;
		RXDATA : out std_logic_vector(7 downto 0);
		RXDISPERR : out std_logic_vector(0 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(0 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(0 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(0 downto 0);
		TXN : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(0 downto 0);

		BREFCLK : in std_ulogic := 'X';
		BREFCLK2 : in std_ulogic := 'X';
		CONFIGENABLE : in std_ulogic;
		CONFIGIN : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK : in std_ulogic;
		REFCLK2 : in std_ulogic;
		REFCLKSEL : in std_ulogic;
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(0 downto 0);
		TXCHARDISPMODE : in std_logic_vector(0 downto 0);
		TXCHARDISPVAL : in std_logic_vector(0 downto 0);
		TXCHARISK : in std_logic_vector(0 downto 0);
		TXDATA : in std_logic_vector(7 downto 0);
		TXFORCECRCERR : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT_FIBRE_CHAN_1 : component is true;
attribute black_box_pad_pin of GT_FIBRE_CHAN_1 : component is "RXN,RXP,TXN,TXP";

component GT_FIBRE_CHAN_2
generic (
		CLK_COR_INSERT_IDLE_FLAG : boolean := FALSE;
		CLK_COR_KEEP_IDLE : boolean := FALSE;
		CLK_COR_REPEAT_WAIT : integer := 2;
		REF_CLK_V_SEL : integer := 0;
		RX_CRC_USE : boolean := FALSE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		SERDES_10B : boolean := FALSE;
		TERMINATION_IMP : integer := 50;
		TX_CRC_FORCE_VALUE : bit_vector := "11010110";
		TX_CRC_USE : boolean := FALSE;
		TX_DIFF_CTRL : integer := 500;
		TX_PREEMPHASIS : integer := 0

  );

port (
		CONFIGOUT : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(1 downto 0);
		RXCHARISK : out std_logic_vector(1 downto 0);
		RXCHECKINGCRC : out std_ulogic;
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXCRCERR : out std_ulogic;
		RXDATA : out std_logic_vector(15 downto 0);
		RXDISPERR : out std_logic_vector(1 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(1 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(1 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(1 downto 0);
		TXN : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(1 downto 0);

		BREFCLK : in std_ulogic := 'X';
		BREFCLK2 : in std_ulogic := 'X';
		CONFIGENABLE : in std_ulogic;
		CONFIGIN : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK : in std_ulogic;
		REFCLK2 : in std_ulogic;
		REFCLKSEL : in std_ulogic;
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(1 downto 0);
		TXCHARDISPMODE : in std_logic_vector(1 downto 0);
		TXCHARDISPVAL : in std_logic_vector(1 downto 0);
		TXCHARISK : in std_logic_vector(1 downto 0);
		TXDATA : in std_logic_vector(15 downto 0);
		TXFORCECRCERR : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT_FIBRE_CHAN_2 : component is true;
attribute black_box_pad_pin of GT_FIBRE_CHAN_2 : component is "RXN,RXP,TXN,TXP";

component GT_FIBRE_CHAN_4
generic (
		CLK_COR_INSERT_IDLE_FLAG : boolean := FALSE;
		CLK_COR_KEEP_IDLE : boolean := FALSE;
		CLK_COR_REPEAT_WAIT : integer := 2;
		REF_CLK_V_SEL : integer := 0;
		RX_CRC_USE : boolean := FALSE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		SERDES_10B : boolean := FALSE;
		TERMINATION_IMP : integer := 50;
		TX_CRC_FORCE_VALUE : bit_vector := "11010110";
		TX_CRC_USE : boolean := FALSE;
		TX_DIFF_CTRL : integer := 500;
		TX_PREEMPHASIS : integer := 0

  );

port (
		CONFIGOUT : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(3 downto 0);
		RXCHARISK : out std_logic_vector(3 downto 0);
		RXCHECKINGCRC : out std_ulogic;
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXCRCERR : out std_ulogic;
		RXDATA : out std_logic_vector(31 downto 0);
		RXDISPERR : out std_logic_vector(3 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(3 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(3 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(3 downto 0);
		TXN : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(3 downto 0);

		BREFCLK : in std_ulogic := 'X';
		BREFCLK2 : in std_ulogic := 'X';
		CONFIGENABLE : in std_ulogic;
		CONFIGIN : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK : in std_ulogic;
		REFCLK2 : in std_ulogic;
		REFCLKSEL : in std_ulogic;
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(3 downto 0);
		TXCHARDISPMODE : in std_logic_vector(3 downto 0);
		TXCHARDISPVAL : in std_logic_vector(3 downto 0);
		TXCHARISK : in std_logic_vector(3 downto 0);
		TXDATA : in std_logic_vector(31 downto 0);
		TXFORCECRCERR : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT_FIBRE_CHAN_4 : component is true;
attribute black_box_pad_pin of GT_FIBRE_CHAN_4 : component is "RXN,RXP,TXN,TXP";

component GT_INFINIBAND_1
generic (
		CHAN_BOND_MODE : string := "OFF";
		CHAN_BOND_ONE_SHOT : boolean := FALSE;
		CLK_COR_INSERT_IDLE_FLAG : boolean := FALSE;
		CLK_COR_KEEP_IDLE : boolean := FALSE;
		CLK_COR_REPEAT_WAIT : integer := 1;
		LANE_ID : bit_vector := "00000000000";
		REF_CLK_V_SEL : integer := 0;
		RX_CRC_USE : boolean := FALSE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		SERDES_10B : boolean := FALSE;
		TERMINATION_IMP : integer := 50;
		TX_CRC_FORCE_VALUE : bit_vector := "11010110";
		TX_CRC_USE : boolean := FALSE;
		TX_DIFF_CTRL : integer := 500;
		TX_PREEMPHASIS : integer := 0

  );

port (
		CHBONDDONE : out std_ulogic;
		CHBONDO : out std_logic_vector(3 downto 0);
		CONFIGOUT : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(0 downto 0);
		RXCHARISK : out std_logic_vector(0 downto 0);
		RXCHECKINGCRC : out std_ulogic;
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXCRCERR : out std_ulogic;
		RXDATA : out std_logic_vector(7 downto 0);
		RXDISPERR : out std_logic_vector(0 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(0 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(0 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(0 downto 0);
		TXN : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(0 downto 0);

		BREFCLK : in std_ulogic := 'X';
		BREFCLK2 : in std_ulogic := 'X';
		CHBONDI : in std_logic_vector(3 downto 0);
		CONFIGENABLE : in std_ulogic;
		CONFIGIN : in std_ulogic;
		ENCHANSYNC : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK : in std_ulogic;
		REFCLK2 : in std_ulogic;
		REFCLKSEL : in std_ulogic;
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(0 downto 0);
		TXCHARDISPMODE : in std_logic_vector(0 downto 0);
		TXCHARDISPVAL : in std_logic_vector(0 downto 0);
		TXCHARISK : in std_logic_vector(0 downto 0);
		TXDATA : in std_logic_vector(7 downto 0);
		TXFORCECRCERR : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT_INFINIBAND_1 : component is true;
attribute black_box_pad_pin of GT_INFINIBAND_1 : component is "RXN,RXP,TXN,TXP";

component GT_INFINIBAND_2
generic (
		CHAN_BOND_MODE : string := "OFF";
		CHAN_BOND_ONE_SHOT : boolean := FALSE;
		CLK_COR_INSERT_IDLE_FLAG : boolean := FALSE;
		CLK_COR_KEEP_IDLE : boolean := FALSE;
		CLK_COR_REPEAT_WAIT : integer := 1;
		LANE_ID : bit_vector := "00000000000";
		REF_CLK_V_SEL : integer := 0;
		RX_CRC_USE : boolean := FALSE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		SERDES_10B : boolean := FALSE;
		TERMINATION_IMP : integer := 50;
		TX_CRC_FORCE_VALUE : bit_vector := "11010110";
		TX_CRC_USE : boolean := FALSE;
		TX_DIFF_CTRL : integer := 500;
		TX_PREEMPHASIS : integer := 0

  );

port (
		CHBONDDONE : out std_ulogic;
		CHBONDO : out std_logic_vector(3 downto 0);
		CONFIGOUT : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(1 downto 0);
		RXCHARISK : out std_logic_vector(1 downto 0);
		RXCHECKINGCRC : out std_ulogic;
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXCRCERR : out std_ulogic;
		RXDATA : out std_logic_vector(15 downto 0);
		RXDISPERR : out std_logic_vector(1 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(1 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(1 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(1 downto 0);
		TXN : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(1 downto 0);

		BREFCLK : in std_ulogic := 'X';
		BREFCLK2 : in std_ulogic := 'X';
		CHBONDI : in std_logic_vector(3 downto 0);
		CONFIGENABLE : in std_ulogic;
		CONFIGIN : in std_ulogic;
		ENCHANSYNC : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK : in std_ulogic;
		REFCLK2 : in std_ulogic;
		REFCLKSEL : in std_ulogic;
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(1 downto 0);
		TXCHARDISPMODE : in std_logic_vector(1 downto 0);
		TXCHARDISPVAL : in std_logic_vector(1 downto 0);
		TXCHARISK : in std_logic_vector(1 downto 0);
		TXDATA : in std_logic_vector(15 downto 0);
		TXFORCECRCERR : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT_INFINIBAND_2 : component is true;
attribute black_box_pad_pin of GT_INFINIBAND_2 : component is "RXN,RXP,TXN,TXP";

component GT_INFINIBAND_4
generic (
		CHAN_BOND_MODE : string := "OFF";
		CHAN_BOND_ONE_SHOT : boolean := FALSE;
		CLK_COR_INSERT_IDLE_FLAG : boolean := FALSE;
		CLK_COR_KEEP_IDLE : boolean := FALSE;
		CLK_COR_REPEAT_WAIT : integer := 1;
		LANE_ID : bit_vector := "00000000000";
		REF_CLK_V_SEL : integer := 0;
		RX_CRC_USE : boolean := FALSE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		SERDES_10B : boolean := FALSE;
		TERMINATION_IMP : integer := 50;
		TX_CRC_FORCE_VALUE : bit_vector := "11010110";
		TX_CRC_USE : boolean := FALSE;
		TX_DIFF_CTRL : integer := 500;
		TX_PREEMPHASIS : integer := 0

  );

port (
		CHBONDDONE : out std_ulogic;
		CHBONDO : out std_logic_vector(3 downto 0);
		CONFIGOUT : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(3 downto 0);
		RXCHARISK : out std_logic_vector(3 downto 0);
		RXCHECKINGCRC : out std_ulogic;
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXCRCERR : out std_ulogic;
		RXDATA : out std_logic_vector(31 downto 0);
		RXDISPERR : out std_logic_vector(3 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(3 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(3 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(3 downto 0);
		TXN : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(3 downto 0);

		BREFCLK : in std_ulogic := 'X';
		BREFCLK2 : in std_ulogic := 'X';
		CHBONDI : in std_logic_vector(3 downto 0);
		CONFIGENABLE : in std_ulogic;
		CONFIGIN : in std_ulogic;
		ENCHANSYNC : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK : in std_ulogic;
		REFCLK2 : in std_ulogic;
		REFCLKSEL : in std_ulogic;
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(3 downto 0);
		TXCHARDISPMODE : in std_logic_vector(3 downto 0);
		TXCHARDISPVAL : in std_logic_vector(3 downto 0);
		TXCHARISK : in std_logic_vector(3 downto 0);
		TXDATA : in std_logic_vector(31 downto 0);
		TXFORCECRCERR : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT_INFINIBAND_4 : component is true;
attribute black_box_pad_pin of GT_INFINIBAND_4 : component is "RXN,RXP,TXN,TXP";

component GT_XAUI_1
generic (
		CHAN_BOND_MODE : string := "OFF";
		CHAN_BOND_ONE_SHOT : boolean := FALSE;
		CLK_COR_INSERT_IDLE_FLAG : boolean := FALSE;
		CLK_COR_KEEP_IDLE : boolean := FALSE;
		CLK_COR_REPEAT_WAIT : integer := 1;
		CRC_END_OF_PKT : string := "K29_7";
		CRC_FORMAT : string := "USER_MODE";
		CRC_START_OF_PKT : string := "K27_7";
		REF_CLK_V_SEL : integer := 0;
		RX_CRC_USE : boolean := FALSE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		SERDES_10B : boolean := FALSE;
		TERMINATION_IMP : integer := 50;
		TX_CRC_FORCE_VALUE : bit_vector := "11010110";
		TX_CRC_USE : boolean := FALSE;
		TX_DIFF_CTRL : integer := 500;
		TX_PREEMPHASIS : integer := 0

  );

port (
		CHBONDDONE : out std_ulogic;
		CHBONDO : out std_logic_vector(3 downto 0);
		CONFIGOUT : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(0 downto 0);
		RXCHARISK : out std_logic_vector(0 downto 0);
		RXCHECKINGCRC : out std_ulogic;
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXCRCERR : out std_ulogic;
		RXDATA : out std_logic_vector(7 downto 0);
		RXDISPERR : out std_logic_vector(0 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(0 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(0 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(0 downto 0);
		TXN : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(0 downto 0);

		BREFCLK : in std_ulogic := 'X';
		BREFCLK2 : in std_ulogic := 'X';
		CHBONDI : in std_logic_vector(3 downto 0);
		CONFIGENABLE : in std_ulogic;
		CONFIGIN : in std_ulogic;
		ENCHANSYNC : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK : in std_ulogic;
		REFCLK2 : in std_ulogic;
		REFCLKSEL : in std_ulogic;
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(0 downto 0);
		TXCHARDISPMODE : in std_logic_vector(0 downto 0);
		TXCHARDISPVAL : in std_logic_vector(0 downto 0);
		TXCHARISK : in std_logic_vector(0 downto 0);
		TXDATA : in std_logic_vector(7 downto 0);
		TXFORCECRCERR : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT_XAUI_1 : component is true;
attribute black_box_pad_pin of GT_XAUI_1 : component is "RXN,RXP,TXN,TXP";

component GT_XAUI_2
generic (
		CHAN_BOND_MODE : string := "OFF";
		CHAN_BOND_ONE_SHOT : boolean := FALSE;
		CLK_COR_INSERT_IDLE_FLAG : boolean := FALSE;
		CLK_COR_KEEP_IDLE : boolean := FALSE;
		CLK_COR_REPEAT_WAIT : integer := 1;
		CRC_END_OF_PKT : string := "K29_7";
		CRC_FORMAT : string := "USER_MODE";
		CRC_START_OF_PKT : string := "K27_7";
		REF_CLK_V_SEL : integer := 0;
		RX_CRC_USE : boolean := FALSE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		SERDES_10B : boolean := FALSE;
		TERMINATION_IMP : integer := 50;
		TX_CRC_FORCE_VALUE : bit_vector := "11010110";
		TX_CRC_USE : boolean := FALSE;
		TX_DIFF_CTRL : integer := 500;
		TX_PREEMPHASIS : integer := 0

  );

port (
		CHBONDDONE : out std_ulogic;
		CHBONDO : out std_logic_vector(3 downto 0);
		CONFIGOUT : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(1 downto 0);
		RXCHARISK : out std_logic_vector(1 downto 0);
		RXCHECKINGCRC : out std_ulogic;
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXCRCERR : out std_ulogic;
		RXDATA : out std_logic_vector(15 downto 0);
		RXDISPERR : out std_logic_vector(1 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(1 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(1 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(1 downto 0);
		TXN : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(1 downto 0);

		BREFCLK : in std_ulogic := 'X';
		BREFCLK2 : in std_ulogic := 'X';
		CHBONDI : in std_logic_vector(3 downto 0);
		CONFIGENABLE : in std_ulogic;
		CONFIGIN : in std_ulogic;
		ENCHANSYNC : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK : in std_ulogic;
		REFCLK2 : in std_ulogic;
		REFCLKSEL : in std_ulogic;
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(1 downto 0);
		TXCHARDISPMODE : in std_logic_vector(1 downto 0);
		TXCHARDISPVAL : in std_logic_vector(1 downto 0);
		TXCHARISK : in std_logic_vector(1 downto 0);
		TXDATA : in std_logic_vector(15 downto 0);
		TXFORCECRCERR : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT_XAUI_2 : component is true;
attribute black_box_pad_pin of GT_XAUI_2 : component is "RXN,RXP,TXN,TXP";

component GT_XAUI_4
generic (
		CHAN_BOND_MODE : string := "OFF";
		CHAN_BOND_ONE_SHOT : boolean := FALSE;
		CLK_COR_INSERT_IDLE_FLAG : boolean := FALSE;
		CLK_COR_KEEP_IDLE : boolean := FALSE;
		CLK_COR_REPEAT_WAIT : integer := 1;
		CRC_END_OF_PKT : string := "K29_7";
		CRC_FORMAT : string := "USER_MODE";
		CRC_START_OF_PKT : string := "K27_7";
		REF_CLK_V_SEL : integer := 0;
		RX_CRC_USE : boolean := FALSE;
		RX_LOS_INVALID_INCR : integer := 1;
		RX_LOS_THRESHOLD : integer := 4;
		RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
		SERDES_10B : boolean := FALSE;
		TERMINATION_IMP : integer := 50;
		TX_CRC_FORCE_VALUE : bit_vector := "11010110";
		TX_CRC_USE : boolean := FALSE;
		TX_DIFF_CTRL : integer := 500;
		TX_PREEMPHASIS : integer := 0

  );

port (
		CHBONDDONE : out std_ulogic;
		CHBONDO : out std_logic_vector(3 downto 0);
		CONFIGOUT : out std_ulogic;
		RXBUFSTATUS : out std_logic_vector(1 downto 0);
		RXCHARISCOMMA : out std_logic_vector(3 downto 0);
		RXCHARISK : out std_logic_vector(3 downto 0);
		RXCHECKINGCRC : out std_ulogic;
		RXCLKCORCNT : out std_logic_vector(2 downto 0);
		RXCOMMADET : out std_ulogic;
		RXCRCERR : out std_ulogic;
		RXDATA : out std_logic_vector(31 downto 0);
		RXDISPERR : out std_logic_vector(3 downto 0);
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXNOTINTABLE : out std_logic_vector(3 downto 0);
		RXREALIGN : out std_ulogic;
		RXRECCLK : out std_ulogic;
		RXRUNDISP : out std_logic_vector(3 downto 0);
		TXBUFERR : out std_ulogic;
		TXKERR : out std_logic_vector(3 downto 0);
		TXN : out std_ulogic;
		TXP : out std_ulogic;
		TXRUNDISP : out std_logic_vector(3 downto 0);

		BREFCLK : in std_ulogic := 'X';
		BREFCLK2 : in std_ulogic := 'X';
		CHBONDI : in std_logic_vector(3 downto 0);
		CONFIGENABLE : in std_ulogic;
		CONFIGIN : in std_ulogic;
		ENCHANSYNC : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK : in std_ulogic;
		REFCLK2 : in std_ulogic;
		REFCLKSEL : in std_ulogic;
		RXN : in std_ulogic;
		RXP : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(3 downto 0);
		TXCHARDISPMODE : in std_logic_vector(3 downto 0);
		TXCHARDISPVAL : in std_logic_vector(3 downto 0);
		TXCHARISK : in std_logic_vector(3 downto 0);
		TXDATA : in std_logic_vector(31 downto 0);
		TXFORCECRCERR : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic

     );
end component;
attribute syn_black_box of GT_XAUI_4 : component is true;
attribute black_box_pad_pin of GT_XAUI_4 : component is "RXN,RXP,TXN,TXP";

component FPGA_startup
  port (
    bus_reset : out std_ulogic;
    done      : out std_ulogic;
    ghigh_b   : out std_ulogic;
    gsr       : out std_ulogic;
    gts_b     : out std_ulogic;
    gwe       : out std_ulogic;

    cclk      : in  std_ulogic;
    por       : in  std_ulogic;
    shutdown  : in  std_ulogic
    );
end component;
attribute syn_black_box of FPGA_startup : component is true;
attribute syn_noprune of FPGA_startup : component is true;

  component PPC405
    generic(
      PPCUSER : std_logic_vector(0 to 3) := "0000"
      ) ;
    
    port(
      C405CPMCORESLEEPREQ        : out std_ulogic;
      C405CPMMSRCE               : out std_ulogic;
      C405CPMMSREE               : out std_ulogic;
      C405CPMTIMERIRQ            : out std_ulogic;
      C405CPMTIMERRESETREQ       : out std_ulogic;
      C405DBGMSRWE               : out std_ulogic;
      C405DBGSTOPACK             : out std_ulogic;
      C405DBGWBCOMPLETE          : out std_ulogic;
      C405DBGWBFULL              : out std_ulogic;
      C405DBGWBIAR               : out std_logic_vector(0 to 29);
      C405DCRABUS                : out std_logic_vector(0 to 9);
      C405DCRDBUSOUT             : out std_logic_vector(0 to 31);
      C405DCRREAD                : out std_ulogic;
      C405DCRWRITE               : out std_ulogic;
      C405JTGCAPTUREDR           : out std_ulogic;
      C405JTGEXTEST              : out std_ulogic;
      C405JTGPGMOUT              : out std_ulogic;
      C405JTGSHIFTDR             : out std_ulogic;
      C405JTGTDO                 : out std_ulogic;
      C405JTGTDOEN               : out std_ulogic;
      C405JTGUPDATEDR            : out std_ulogic;
      C405PLBDCUABORT            : out std_ulogic;
      C405PLBDCUABUS             : out std_logic_vector(0 to 31);
      C405PLBDCUBE               : out std_logic_vector(0 to 7);
      C405PLBDCUCACHEABLE        : out std_ulogic;
      C405PLBDCUGUARDED          : out std_ulogic;
      C405PLBDCUPRIORITY         : out std_logic_vector(0 to 1);
      C405PLBDCUREQUEST          : out std_ulogic;
      C405PLBDCURNW              : out std_ulogic;
      C405PLBDCUSIZE2            : out std_ulogic;
      C405PLBDCUU0ATTR           : out std_ulogic;
      C405PLBDCUWRDBUS           : out std_logic_vector(0 to 63);
      C405PLBDCUWRITETHRU        : out std_ulogic;
      C405PLBICUABORT            : out std_ulogic;
      C405PLBICUABUS             : out std_logic_vector(0 to 29);
      C405PLBICUCACHEABLE        : out std_ulogic;
      C405PLBICUPRIORITY         : out std_logic_vector(0 to 1);
      C405PLBICUREQUEST          : out std_ulogic;
      C405PLBICUSIZE             : out std_logic_vector(2 to 3);
      C405PLBICUU0ATTR           : out std_ulogic;
      C405RSTCHIPRESETREQ        : out std_ulogic;
      C405RSTCORERESETREQ        : out std_ulogic;
      C405RSTSYSRESETREQ         : out std_ulogic;
      C405TRCCYCLE               : out std_ulogic;
      C405TRCEVENEXECUTIONSTATUS : out std_logic_vector(0 to 1);
      C405TRCODDEXECUTIONSTATUS  : out std_logic_vector(0 to 1);
      C405TRCTRACESTATUS         : out std_logic_vector(0 to 3);
      C405TRCTRIGGEREVENTOUT     : out std_ulogic;
      C405TRCTRIGGEREVENTTYPE    : out std_logic_vector(0 to 10);
      C405XXXMACHINECHECK        : out std_ulogic;
      DSOCMBRAMABUS              : out std_logic_vector(8 to 29);
      DSOCMBRAMBYTEWRITE         : out std_logic_vector(0 to 3);
      DSOCMBRAMEN                : out std_ulogic;
      DSOCMBRAMWRDBUS            : out std_logic_vector(0 to 31);
      DSOCMBUSY                  : out std_ulogic;
      ISOCMBRAMEN                : out std_ulogic;
      ISOCMBRAMEVENWRITEEN       : out std_ulogic;
      ISOCMBRAMODDWRITEEN        : out std_ulogic;
      ISOCMBRAMRDABUS            : out std_logic_vector(8 to 28);
      ISOCMBRAMWRABUS            : out std_logic_vector(8 to 28);
      ISOCMBRAMWRDBUS            : out std_logic_vector(0 to 31);
      
      BRAMDSOCMCLK               : in  std_ulogic;
      BRAMDSOCMRDDBUS            : in  std_logic_vector(0 to 31);
      BRAMISOCMCLK               : in  std_ulogic;
      BRAMISOCMRDDBUS            : in  std_logic_vector(0 to 63);
      CPMC405CLOCK               : in  std_ulogic;
      CPMC405CORECLKINACTIVE     : in  std_ulogic;
      CPMC405CPUCLKEN            : in  std_ulogic;
      CPMC405JTAGCLKEN           : in  std_ulogic;
      CPMC405TIMERCLKEN          : in  std_ulogic;
      CPMC405TIMERTICK           : in  std_ulogic;
      DBGC405DEBUGHALT           : in  std_ulogic;
      DBGC405EXTBUSHOLDACK       : in  std_ulogic;
      DBGC405UNCONDDEBUGEVENT    : in  std_ulogic;
      DCRC405ACK                 : in  std_ulogic;
      DCRC405DBUSIN              : in  std_logic_vector(0 to 31);
      DSARCVALUE                 : in  std_logic_vector(0 to 7);
      DSCNTLVALUE                : in  std_logic_vector(0 to 7);
      EICC405CRITINPUTIRQ        : in  std_ulogic;
      EICC405EXTINPUTIRQ         : in  std_ulogic;
      ISARCVALUE                 : in  std_logic_vector(0 to 7);
      ISCNTLVALUE                : in  std_logic_vector(0 to 7);
      JTGC405BNDSCANTDO          : in  std_ulogic;
      JTGC405TCK                 : in  std_ulogic;
      JTGC405TDI                 : in  std_ulogic;
      JTGC405TMS                 : in  std_ulogic;
      JTGC405TRSTNEG             : in  std_ulogic;
      MCBCPUCLKEN                : in  std_ulogic;
      MCBJTAGEN                  : in  std_ulogic;
      MCBTIMEREN                 : in  std_ulogic;
      MCPPCRST                   : in  std_ulogic;
      PLBC405DCUADDRACK          : in  std_ulogic;
      PLBC405DCUBUSY             : in  std_ulogic;
      PLBC405DCUERR              : in  std_ulogic;
      PLBC405DCURDDACK           : in  std_ulogic;
      PLBC405DCURDDBUS           : in  std_logic_vector(0 to 63);
      PLBC405DCURDWDADDR         : in  std_logic_vector(1 to 3);
      PLBC405DCUSSIZE1           : in  std_ulogic;
      PLBC405DCUWRDACK           : in  std_ulogic;
      PLBC405ICUADDRACK          : in  std_ulogic;
      PLBC405ICUBUSY             : in  std_ulogic;
      PLBC405ICUERR              : in  std_ulogic;
      PLBC405ICURDDACK           : in  std_ulogic;
      PLBC405ICURDDBUS           : in  std_logic_vector(0 to 63);
      PLBC405ICURDWDADDR         : in  std_logic_vector(1 to 3);
      PLBC405ICUSSIZE1           : in  std_ulogic;
      PLBCLK                     : in  std_ulogic;
      RSTC405RESETCHIP           : in  std_ulogic;
      RSTC405RESETCORE           : in  std_ulogic;
      RSTC405RESETSYS            : in  std_ulogic;
      TIEC405DETERMINISTICMULT   : in  std_ulogic;
      TIEC405DISOPERANDFWD       : in  std_ulogic;
      TIEC405MMUEN               : in  std_ulogic;
      TIEDSOCMDCRADDR            : in  std_logic_vector(0 to 7);
      TIEISOCMDCRADDR            : in  std_logic_vector(0 to 7);
      TRCC405TRACEDISABLE        : in  std_ulogic;
      TRCC405TRIGGEREVENTIN      : in  std_ulogic
      );
  end component ;
attribute syn_black_box of PPC405 : component is true;

  component JTAGPPC
    port (
      TCK    : out std_ulogic;
      TDIPPC : out std_ulogic;
      TMS    : out std_ulogic;
  
      TDOPPC   : in std_ulogic;
      TDOTSPPC : in std_ulogic
      );
  end component;
attribute syn_black_box of JTAGPPC : component is true;

component DCC_FPGACORE
generic (
		DEVICE_SIZE : integer := 10

  );

port (
		BCLK : out std_ulogic;
		DONEOUT : out std_ulogic;
		DOUT0 : out std_ulogic;
		DOUT1 : out std_ulogic;
		DOUT2 : out std_ulogic;
		DOUT3 : out std_ulogic;
		DOUT4 : out std_ulogic;
		DOUT5 : out std_ulogic;
		DOUT6 : out std_ulogic;
		DOUT7 : out std_ulogic;
		GSR : out std_ulogic;
		GTS : out std_ulogic;
		GWE : out std_ulogic;
		INITBOUT : out std_ulogic;
		TDO : out std_ulogic;

		CCLK : in std_ulogic;
		CSB : in std_ulogic;
		DIN0 : in std_ulogic;
		DIN1 : in std_ulogic;
		DIN2 : in std_ulogic;
		DIN3 : in std_ulogic;
		DIN4 : in std_ulogic;
		DIN5 : in std_ulogic;
		DIN6 : in std_ulogic;
		DIN7 : in std_ulogic;
		DONEIN : in std_ulogic;
		LBISTISOLATEB : in std_ulogic;
		M0 : in std_ulogic;
		M1 : in std_ulogic;
		M2 : in std_ulogic;
		PROGB : in std_ulogic;
		TCK : in std_ulogic;
		TDI : in std_ulogic;
		TMS : in std_ulogic;
		WRITEB : in std_ulogic

     );
end component;
attribute syn_black_box of DCC_FPGACORE : component is true;

component GT10_SWIFT_BUS
-- synopsys translate_off  
	port (

		CHBONDDONE : out STD_ULOGIC;
		CHBONDO : out STD_LOGIC_VECTOR(4 downto 0);
		PMARXLOCK : out STD_ULOGIC;
		RXBUFSTATUS : out STD_LOGIC_VECTOR(1 downto 0);
		RXCHARISCOMMA : out STD_LOGIC_VECTOR(7 downto 0);
		RXCHARISK : out STD_LOGIC_VECTOR(7 downto 0);
		RXCLKCORCNT : out STD_LOGIC_VECTOR(2 downto 0);
		RXCOMMADET : out STD_ULOGIC;
		RXDATA : out STD_LOGIC_VECTOR(63 downto 0);
		RXDISPERR : out STD_LOGIC_VECTOR(7 downto 0);
		RXLOSSOFSYNC : out STD_LOGIC_VECTOR(1 downto 0);
		RXNOTINTABLE : out STD_LOGIC_VECTOR(7 downto 0);
		RXREALIGN : out STD_ULOGIC;
		RXRECCLK : out STD_ULOGIC;
		RXRUNDISP : out STD_LOGIC_VECTOR(7 downto 0);
		TXBUFERR : out STD_ULOGIC;
		TXKERR : out STD_LOGIC_VECTOR(7 downto 0);
		TXN : out STD_ULOGIC;
		TXOUTCLK : out STD_ULOGIC;
		TXP : out STD_ULOGIC;
		TXRUNDISP : out STD_LOGIC_VECTOR(7 downto 0);

		BREFCLKNIN : in STD_ULOGIC;
		BREFCLKPIN : in STD_ULOGIC;
		CHBONDI : in STD_LOGIC_VECTOR(4 downto 0);
		ENCHANSYNC : in STD_ULOGIC;
		ENMCOMMAALIGN : in STD_ULOGIC;
		ENPCOMMAALIGN : in STD_ULOGIC;
		LOOPBACK : in STD_LOGIC_VECTOR(1 downto 0);
		PMAINIT : in STD_ULOGIC;
		PMAREGADDR : in STD_LOGIC_VECTOR(5 downto 0);
		PMAREGDATAIN : in STD_LOGIC_VECTOR(7 downto 0);
		PMAREGRW : in STD_ULOGIC;
		PMAREGSTROBE : in STD_ULOGIC;
		PMARXLOCKSEL : in STD_LOGIC_VECTOR(1 downto 0);
		POWERDOWN : in STD_ULOGIC;
		REFCLK : in STD_ULOGIC;
		REFCLK2 : in STD_ULOGIC;
		REFCLKBSEL : in STD_ULOGIC;
		REFCLKSEL : in STD_ULOGIC;
		RXBLOCKSYNC64B66BUSE : in STD_ULOGIC;
		RXCOMMADETUSE : in STD_ULOGIC;
		RXDATAWIDTH : in STD_LOGIC_VECTOR(1 downto 0);
		RXDEC64B66BUSE : in STD_ULOGIC;
		RXDEC8B10BUSE : in STD_ULOGIC;
		RXDESCRAM64B66BUSE : in STD_ULOGIC;
		RXIGNOREBTF : in STD_ULOGIC;
		RXINTDATAWIDTH : in STD_LOGIC_VECTOR(1 downto 0);
		RXN : in STD_ULOGIC;
		RXP : in STD_ULOGIC;
		RXPOLARITY : in STD_ULOGIC;
		RXRESET : in STD_ULOGIC;
		RXSLIDE : in STD_ULOGIC;
		RXUSRCLK : in STD_ULOGIC;
		RXUSRCLK2 : in STD_ULOGIC;
		TXBYPASS8B10B : in STD_LOGIC_VECTOR(7 downto 0);
		TXCHARDISPMODE : in STD_LOGIC_VECTOR(7 downto 0);
		TXCHARDISPVAL : in STD_LOGIC_VECTOR(7 downto 0);
		TXCHARISK : in STD_LOGIC_VECTOR(7 downto 0);
		TXDATA : in STD_LOGIC_VECTOR(63 downto 0);
		TXDATAWIDTH : in STD_LOGIC_VECTOR(1 downto 0);
		TXENC64B66BUSE : in STD_ULOGIC;
		TXENC8B10BUSE : in STD_ULOGIC;
		TXGEARBOX64B66BUSE : in STD_ULOGIC;
		TXINHIBIT : in STD_ULOGIC;
		TXINTDATAWIDTH : in STD_LOGIC_VECTOR(1 downto 0);
		TXPOLARITY : in STD_ULOGIC;
		TXRESET : in STD_ULOGIC;
		TXSCRAM64B66BUSE : in STD_ULOGIC;
		TXUSRCLK : in STD_ULOGIC;
		TXUSRCLK2 : in STD_ULOGIC;
		ALIGN_COMMA_WORD : in STD_LOGIC_VECTOR(1 downto 0);
		CHAN_BOND_LIMIT : in STD_LOGIC_VECTOR(5 downto 0);
		CHAN_BOND_MODE : in STD_LOGIC_VECTOR(1 downto 0);
		CHAN_BOND_ONE_SHOT : in STD_ULOGIC;
		CHAN_BOND_SEQ_1_1 : in STD_LOGIC_VECTOR(10 downto 0);
		CHAN_BOND_SEQ_1_2 : in STD_LOGIC_VECTOR(10 downto 0);
		CHAN_BOND_SEQ_1_3 : in STD_LOGIC_VECTOR(10 downto 0);
		CHAN_BOND_SEQ_1_4 : in STD_LOGIC_VECTOR(10 downto 0);
		CHAN_BOND_SEQ_1_MASK : in STD_LOGIC_VECTOR(3 downto 0);
		CHAN_BOND_SEQ_2_1 : in STD_LOGIC_VECTOR(10 downto 0);
		CHAN_BOND_SEQ_2_2 : in STD_LOGIC_VECTOR(10 downto 0);
		CHAN_BOND_SEQ_2_3 : in STD_LOGIC_VECTOR(10 downto 0);
		CHAN_BOND_SEQ_2_4 : in STD_LOGIC_VECTOR(10 downto 0);
		CHAN_BOND_SEQ_2_MASK : in STD_LOGIC_VECTOR(3 downto 0);
		CHAN_BOND_SEQ_2_USE : in STD_ULOGIC;
		CHAN_BOND_SEQ_LEN : in STD_LOGIC_VECTOR(2 downto 0);
                CHAN_BOND_64B66B_SV : in std_ulogic;                
		CLK_COR_8B10B_DE : in STD_ULOGIC;
		CLK_COR_MAX_LAT : in STD_LOGIC_VECTOR(5 downto 0);
		CLK_COR_MIN_LAT : in STD_LOGIC_VECTOR(5 downto 0);
		CLK_COR_SEQ_1_1 : in STD_LOGIC_VECTOR(10 downto 0);
		CLK_COR_SEQ_1_2 : in STD_LOGIC_VECTOR(10 downto 0);
		CLK_COR_SEQ_1_3 : in STD_LOGIC_VECTOR(10 downto 0);
		CLK_COR_SEQ_1_4 : in STD_LOGIC_VECTOR(10 downto 0);
		CLK_COR_SEQ_1_MASK : in STD_LOGIC_VECTOR(3 downto 0);
		CLK_COR_SEQ_2_1 : in STD_LOGIC_VECTOR(10 downto 0);
		CLK_COR_SEQ_2_2 : in STD_LOGIC_VECTOR(10 downto 0);
		CLK_COR_SEQ_2_3 : in STD_LOGIC_VECTOR(10 downto 0);
		CLK_COR_SEQ_2_4 : in STD_LOGIC_VECTOR(10 downto 0);
		CLK_COR_SEQ_2_MASK : in STD_LOGIC_VECTOR(3 downto 0);
		CLK_COR_SEQ_2_USE : in STD_ULOGIC;
		CLK_COR_SEQ_DROP : in STD_ULOGIC;
		CLK_COR_SEQ_LEN : in STD_LOGIC_VECTOR(2 downto 0);
		CLK_CORRECT_USE : in STD_ULOGIC;
		COMMA_10B_MASK : in STD_LOGIC_VECTOR(9 downto 0);
		DEC_MCOMMA_DETECT : in STD_ULOGIC;
		DEC_PCOMMA_DETECT : in STD_ULOGIC;
		DEC_VALID_COMMA_ONLY : in STD_ULOGIC;
		MCOMMA_10B_VALUE : in STD_LOGIC_VECTOR(9 downto 0);
		MCOMMA_DETECT : in STD_ULOGIC;
		PCOMMA_10B_VALUE : in STD_LOGIC_VECTOR(9 downto 0);
		PCOMMA_DETECT : in STD_ULOGIC;
		PMA_SPEED : in STD_LOGIC_VECTOR(119 downto 0);
		PMA_PWR_CNTRL : in STD_LOGIC_VECTOR(7 downto 0);
		RX_BUFFER_USE : in STD_ULOGIC;
		RX_LOS_INVALID_INCR : in STD_LOGIC_VECTOR(7 downto 0);
		RX_LOS_THRESHOLD : in STD_LOGIC_VECTOR(7 downto 0);
		RX_LOSS_OF_SYNC_FSM : in STD_ULOGIC;
		SH_CNT_MAX : in STD_LOGIC_VECTOR(7 downto 0);
		SH_INVALID_CNT_MAX : in STD_LOGIC_VECTOR(7 downto 0);
		TX_BUFFER_USE : in STD_ULOGIC;
		GSR : in STD_ULOGIC

	);
-- synopsys translate_on        
end component;
attribute syn_black_box of GT10_SWIFT_BUS : component is true;
attribute black_box_pad_pin of GT10_SWIFT_BUS : component is "RXN,RXP,TXN,TXP";

component GT_SWIFT_BUS
-- synopsys translate_off
  port(
    ALIGN_COMMA_MSB : in std_ulogic ;
    CHAN_BOND_LIMIT : in std_logic_vector(4 downto 0) ;
    CHAN_BOND_MODE : in std_logic_vector(1 downto 0) ;
    CHAN_BOND_OFFSET : in std_logic_vector(3 downto 0) ;
    CHAN_BOND_ONE_SHOT : in std_ulogic;
    CHAN_BOND_SEQ_1_1 : in std_logic_vector(10 downto 0) ;
    CHAN_BOND_SEQ_1_2 : in std_logic_vector(10 downto 0) ;
    CHAN_BOND_SEQ_1_3 : in std_logic_vector(10 downto 0) ;
    CHAN_BOND_SEQ_1_4 : in std_logic_vector(10 downto 0) ;
    CHAN_BOND_SEQ_2_1 : in std_logic_vector(10 downto 0) ;
    CHAN_BOND_SEQ_2_2 : in std_logic_vector(10 downto 0) ;
    CHAN_BOND_SEQ_2_3 : in std_logic_vector(10 downto 0) ;
    CHAN_BOND_SEQ_2_4 : in std_logic_vector(10 downto 0) ;
    CHAN_BOND_SEQ_2_USE : in std_ulogic;
    CHAN_BOND_SEQ_LEN : in std_logic_vector(1 downto 0) ;
    CHAN_BOND_WAIT : in std_logic_vector(3 downto 0) ;
    CLK_CORRECT_USE	: in std_ulogic;
    CLK_COR_INSERT_IDLE_FLAG : in std_ulogic;
    CLK_COR_KEEP_IDLE : in std_ulogic;
    CLK_COR_REPEAT_WAIT : in std_logic_vector(4 downto 0);
    CLK_COR_SEQ_1_1 : in std_logic_vector(10 downto 0) ;
    CLK_COR_SEQ_1_2 : in std_logic_vector(10 downto 0) ;
    CLK_COR_SEQ_1_3 : in std_logic_vector(10 downto 0) ;
    CLK_COR_SEQ_1_4 : in std_logic_vector(10 downto 0) ;
    CLK_COR_SEQ_2_1 : in std_logic_vector(10 downto 0) ;
    CLK_COR_SEQ_2_2 : in std_logic_vector(10 downto 0) ;
    CLK_COR_SEQ_2_3 : in std_logic_vector(10 downto 0) ;
    CLK_COR_SEQ_2_4 : in std_logic_vector(10 downto 0) ;
    CLK_COR_SEQ_2_USE : in std_ulogic;
    CLK_COR_SEQ_LEN	: in std_logic_vector(1 downto 0) ;
    COMMA_10B_MASK : in std_logic_vector(9 downto 0) ;
    CRC_END_OF_PKT : in std_logic_vector(7 downto 0) ;
    CRC_FORMAT : in std_logic_vector(1 downto 0) ;
    CRC_START_OF_PKT : in std_logic_vector(7 downto 0) ;
    DEC_MCOMMA_DETECT  : in std_ulogic;
    DEC_PCOMMA_DETECT : in std_ulogic;
    DEC_VALID_COMMA_ONLY : in std_ulogic;
    MCOMMA_10B_VALUE : in std_logic_vector(9 downto 0) ;
    MCOMMA_DETECT : in std_ulogic;                     
    PCOMMA_10B_VALUE : in std_logic_vector(9 downto 0) ;
    PCOMMA_DETECT : in std_ulogic;
    RX_BUFFER_USE : in std_ulogic;
    RX_CRC_USE : in std_ulogic;
    RX_DATA_WIDTH : in std_logic_vector(1 downto 0);
    RX_DECODE_USE : in std_ulogic;
    RX_LOSS_OF_SYNC_FSM : in std_ulogic;
    RX_LOS_INVALID_INCR : in std_logic_vector(2 downto 0);
    RX_LOS_THRESHOLD : in std_logic_vector(2 downto 0);
    TERMINATION_IMP : in std_ulogic ;
    SERDES_10B : in std_ulogic;
    TX_BUFFER_USE : in std_ulogic;
    TX_CRC_FORCE_VALUE : in std_logic_vector(7 downto 0) ;
    TX_CRC_USE : in std_ulogic;
    TX_DATA_WIDTH : in std_logic_vector(1 downto 0);
    TX_DIFF_CTRL : in std_logic_vector(2 downto 0) ;
    TX_PREEMPHASIS : in std_logic_vector(1 downto 0);

    BREFCLK : in std_ulogic;
    BREFCLK2 : in std_ulogic;    
    CHBONDI : in std_logic_vector(3 DOWNTO 0);
    CONFIGENABLE : in std_ulogic;
    CONFIGIN : in std_ulogic;
    ENCHANSYNC : in std_ulogic;
    ENMCOMMAALIGN : in std_ulogic;
    ENPCOMMAALIGN : in std_ulogic;                                
    LOOPBACK : in std_logic_vector(1 DOWNTO 0);
    POWERDOWN : in std_ulogic;
    REFCLK : in std_ulogic;
    REFCLK2 : in std_ulogic;
    REFCLKSEL : in std_ulogic;
    RXN : in std_ulogic;
    RXP : in std_ulogic;
    RXPOLARITY : in std_ulogic;
    RXRESET : in std_ulogic;
    RXUSRCLK : in std_ulogic;
    RXUSRCLK2 : in std_ulogic;
    TXBYPASS8B10B : in std_logic_vector(3 DOWNTO 0);
    TXCHARDISPMODE : in std_logic_vector(3 DOWNTO 0);
    TXCHARDISPVAL : in std_logic_vector(3 DOWNTO 0);
    TXCHARISK : in std_logic_vector(3 DOWNTO 0);
    TXDATA : in std_logic_vector(31 DOWNTO 0);
    TXFORCECRCERR : in std_ulogic;
    TXINHIBIT : in std_ulogic;
    TXPOLARITY : in std_ulogic;
    TXRESET : in std_ulogic;
    TXUSRCLK : in std_ulogic;
    TXUSRCLK2 : in std_ulogic;
    
    CHBONDDONE : out std_ulogic;
    CHBONDO : out std_logic_vector(3 DOWNTO 0);
    CONFIGOUT : out std_ulogic;
    RXBUFSTATUS : out std_logic_vector(1 DOWNTO 0);
    RXCHARISCOMMA : out std_logic_vector(3 DOWNTO 0);
    RXCHARISK : out std_logic_vector(3 DOWNTO 0);
    RXCHECKINGCRC : out std_ulogic;
    RXCLKCORCNT : out std_logic_vector(2 DOWNTO 0);
    RXCOMMADET : out std_ulogic;
    RXCRCERR : out std_ulogic;
    RXDATA : out std_logic_vector(31 DOWNTO 0);
    RXDISPERR : out std_logic_vector(3 DOWNTO 0);
    RXLOSSOFSYNC : out std_logic_vector(1 DOWNTO 0);
    RXNOTINTABLE : out std_logic_vector(3 DOWNTO 0);
    RXREALIGN : out std_ulogic;
    RXRECCLK : out std_ulogic;
    RXRUNDISP : out std_logic_vector(3 DOWNTO 0);
    TXBUFERR : out std_ulogic;
    TXKERR : out std_logic_vector(3 DOWNTO 0);
    TXN : out std_ulogic;
    TXP : out std_ulogic;
    TXRUNDISP : out std_logic_vector(3 DOWNTO 0);
    GSR : in std_ulogic;
    REF_CLK_V_SEL : in std_ulogic    
    );  

-- synopsys translate_on
end component;
attribute syn_black_box of GT_SWIFT_BUS : component is true;
attribute black_box_pad_pin of GT_SWIFT_BUS : component is "RXN,RXP,TXN,TXP";

  component PPC405_SWIFT_BUS
-- synopsys translate_off
    port (
      C405CPMCORESLEEPREQ        : out std_ulogic;
      C405CPMMSRCE               : out std_ulogic;
      C405CPMMSREE               : out std_ulogic;
      C405CPMTIMERIRQ            : out std_ulogic;
      C405CPMTIMERRESETREQ       : out std_ulogic;
      C405DBGMSRWE               : out std_ulogic;
      C405DBGSTOPACK             : out std_ulogic;
      C405DBGWBCOMPLETE          : out std_ulogic;
      C405DBGWBFULL              : out std_ulogic;
      C405DBGWBIAR               : out std_logic_vector(0 to 29);
      C405DCRABUS                : out std_logic_vector(0 to 9);
      C405DCRDBUSOUT             : out std_logic_vector(0 to 31);
      C405DCRREAD                : out std_ulogic;
      C405DCRWRITE               : out std_ulogic;
      C405JTGCAPTUREDR           : out std_ulogic;
      C405JTGEXTEST              : out std_ulogic;
      C405JTGPGMOUT              : out std_ulogic;
      C405JTGSHIFTDR             : out std_ulogic;
      C405JTGTDO                 : out std_ulogic;
      C405JTGTDOEN               : out std_ulogic;
      C405JTGUPDATEDR            : out std_ulogic;
      C405PLBDCUABORT            : out std_ulogic;
      C405PLBDCUABUS             : out std_logic_vector(0 to 31);
      C405PLBDCUBE               : out std_logic_vector(0 to 7);
      C405PLBDCUCACHEABLE        : out std_ulogic;
      C405PLBDCUGUARDED          : out std_ulogic;
      C405PLBDCUPRIORITY         : out std_logic_vector(0 to 1);
      C405PLBDCUREQUEST          : out std_ulogic;
      C405PLBDCURNW              : out std_ulogic;
      C405PLBDCUSIZE2            : out std_ulogic;
      C405PLBDCUU0ATTR           : out std_ulogic;
      C405PLBDCUWRDBUS           : out std_logic_vector(0 to 63);
      C405PLBDCUWRITETHRU        : out std_ulogic;
      C405PLBICUABORT            : out std_ulogic;
      C405PLBICUABUS             : out std_logic_vector(0 to 29);
      C405PLBICUCACHEABLE        : out std_ulogic;
      C405PLBICUPRIORITY         : out std_logic_vector(0 to 1);
      C405PLBICUREQUEST          : out std_ulogic;
      C405PLBICUSIZE             : out std_logic_vector(2 to 3);
      C405PLBICUU0ATTR           : out std_ulogic;
      C405RSTCHIPRESETREQ        : out std_ulogic;
      C405RSTCORERESETREQ        : out std_ulogic;
      C405RSTSYSRESETREQ         : out std_ulogic;
      C405TRCCYCLE               : out std_ulogic;
      C405TRCEVENEXECUTIONSTATUS : out std_logic_vector(0 to 1);
      C405TRCODDEXECUTIONSTATUS  : out std_logic_vector(0 to 1);
      C405TRCTRACESTATUS         : out std_logic_vector(0 to 3);
      C405TRCTRIGGEREVENTOUT     : out std_ulogic;
      C405TRCTRIGGEREVENTTYPE    : out std_logic_vector(0 to 10);
      C405XXXMACHINECHECK        : out std_ulogic;
      DSOCMBRAMABUS              : out std_logic_vector(8 to 29);
      DSOCMBRAMBYTEWRITE         : out std_logic_vector(0 to 3);
      DSOCMBRAMEN                : out std_ulogic;
      DSOCMBRAMWRDBUS            : out std_logic_vector(0 to 31);
      DSOCMBUSY                  : out std_ulogic;
      ISOCMBRAMEN                : out std_ulogic;
      ISOCMBRAMEVENWRITEEN       : out std_ulogic;
      ISOCMBRAMODDWRITEEN        : out std_ulogic;
      ISOCMBRAMRDABUS            : out std_logic_vector(8 to 28);
      ISOCMBRAMWRABUS            : out std_logic_vector(8 to 28);
      ISOCMBRAMWRDBUS            : out std_logic_vector(0 to 31);

      BRAMDSOCMCLK               : in  std_ulogic;
      BRAMDSOCMRDDBUS            : in  std_logic_vector(0 to 31);
      BRAMISOCMCLK               : in  std_ulogic;
      BRAMISOCMRDDBUS            : in  std_logic_vector(0 to 63);
      BUS_CLK                    : in  std_ulogic;
      BUS_RESET                  : in  std_ulogic;
      CPMC405CLOCK               : in  std_ulogic;
      CPMC405CORECLKINACTIVE     : in  std_ulogic;
      CPMC405CPUCLKEN            : in  std_ulogic;
      CPMC405JTAGCLKEN           : in  std_ulogic;
      CPMC405TIMERCLKEN          : in  std_ulogic;
      CPMC405TIMERTICK           : in  std_ulogic;
      DBGC405DEBUGHALT           : in  std_ulogic;
      DBGC405EXTBUSHOLDACK       : in  std_ulogic;
      DBGC405UNCONDDEBUGEVENT    : in  std_ulogic;
      DCRC405ACK                 : in  std_ulogic;
      DCRC405DBUSIN              : in  std_logic_vector(0 to 31);
      DSARCVALUE                 : in  std_logic_vector(0 to 7);
      DSCNTLVALUE                : in  std_logic_vector(0 to 7);
      EICC405CRITINPUTIRQ        : in  std_ulogic;
      EICC405EXTINPUTIRQ         : in  std_ulogic;
      GHIGHB                     : in  std_ulogic;
      GSR                        : in  std_ulogic;
      GWE                        : in  std_ulogic;
      ISARCVALUE                 : in  std_logic_vector(0 to 7);
      ISCNTLVALUE                : in  std_logic_vector(0 to 7);
      JTGC405BNDSCANTDO          : in  std_ulogic;
      JTGC405TCK                 : in  std_ulogic;
      JTGC405TDI                 : in  std_ulogic;
      JTGC405TMS                 : in  std_ulogic;
      JTGC405TRSTNEG             : in  std_ulogic;
      MCBCPUCLKEN                : in  std_ulogic;
      MCBJTAGEN                  : in  std_ulogic;
      MCBTIMEREN                 : in  std_ulogic;
      MCPPCRST                   : in  std_ulogic;
      PLBC405DCUADDRACK          : in  std_ulogic;
      PLBC405DCUBUSY             : in  std_ulogic;
      PLBC405DCUERR              : in  std_ulogic;
      PLBC405DCURDDACK           : in  std_ulogic;
      PLBC405DCURDDBUS           : in  std_logic_vector(0 to 63);
      PLBC405DCURDWDADDR         : in  std_logic_vector(1 to 3);
      PLBC405DCUSSIZE1           : in  std_ulogic;
      PLBC405DCUWRDACK           : in  std_ulogic;
      PLBC405ICUADDRACK          : in  std_ulogic;
      PLBC405ICUBUSY             : in  std_ulogic;
      PLBC405ICUERR              : in  std_ulogic;
      PLBC405ICURDDACK           : in  std_ulogic;
      PLBC405ICURDDBUS           : in  std_logic_vector(0 to 63);
      PLBC405ICURDWDADDR         : in  std_logic_vector(1 to 3);
      PLBC405ICUSSIZE1           : in  std_ulogic;
      PLBCLK                     : in  std_ulogic;
      RSTC405RESETCHIP           : in  std_ulogic;
      RSTC405RESETCORE           : in  std_ulogic;
      RSTC405RESETSYS            : in  std_ulogic;
      TIEC405DETERMINISTICMULT   : in  std_ulogic;
      TIEC405DISOPERANDFWD       : in  std_ulogic;
      TIEC405MMUEN               : in  std_ulogic;
      TIEC405PVR                 : in  std_logic_vector(28 to 31);
      TIEDSOCMDCRADDR            : in  std_logic_vector(0 to 7);
      TIEISOCMDCRADDR            : in  std_logic_vector(0 to 7);
      TRCC405TRACEDISABLE        : in  std_ulogic;
      TRCC405TRIGGEREVENTIN      : in  std_ulogic

      );
-- synopsys translate_on    
  end component ;
attribute syn_black_box of PPC405_SWIFT_BUS : component is true;

  component DCC_FPGACORE_SWIFT_BUS
-- synopsys translate_off
port (
		BCLK : out std_ulogic;
		DONEOUT : out std_ulogic;
		DOUT0 : out std_ulogic;
		DOUT1 : out std_ulogic;
		DOUT2 : out std_ulogic;
		DOUT3 : out std_ulogic;
		DOUT4 : out std_ulogic;
		DOUT5 : out std_ulogic;
		DOUT6 : out std_ulogic;
		DOUT7 : out std_ulogic;
		GSR : out std_ulogic;
		GTS : out std_ulogic;
		GWE : out std_ulogic;
		INITBOUT : out std_ulogic;
		TDO : out std_ulogic;

		CCLK : in std_ulogic;
		CSB : in std_ulogic;
		DIN0 : in std_ulogic;
		DIN1 : in std_ulogic;
		DIN2 : in std_ulogic;
		DIN3 : in std_ulogic;
		DIN4 : in std_ulogic;
		DIN5 : in std_ulogic;
		DIN6 : in std_ulogic;
		DIN7 : in std_ulogic;
		DONEIN : in std_ulogic;
		LBISTISOLATEB : in std_ulogic;
		M0 : in std_ulogic;
		M1 : in std_ulogic;
		M2 : in std_ulogic;
		PROGB : in std_ulogic;
		TCK : in std_ulogic;
		TDI : in std_ulogic;
		TMS : in std_ulogic;
		WRITEB : in std_ulogic;
		XBID : in std_logic_vector(8 downto 0)
     );
-- synopsys translate_on
  end component ;
attribute syn_black_box of DCC_FPGACORE_SWIFT_BUS : component is true;

  component FDD
    generic(
      INIT : bit := '0' 
      );

    port(
      Q : out std_ulogic;
      C : in  std_ulogic;
      D : in  std_ulogic
       );
  end component;
attribute syn_black_box of FDD : component is true;

  component FDDC
    generic(
      INIT : bit := '0'
      );

    port(
       Q   : out std_ulogic;

       C   : in  std_ulogic;
       CLR : in  std_ulogic;
       D   : in  std_ulogic
       );
  end component;
attribute syn_black_box of FDDC : component is true;

  component FDDCE
    generic(
       INIT : bit := '0'
       );

    port(
       Q   : out std_ulogic;

       C   : in  std_ulogic;
       CE  : in  std_ulogic;
       CLR : in  std_ulogic;
       D   : in  std_ulogic
       );
  end component;
attribute syn_black_box of FDDCE : component is true;

  component FDDCP
    generic(
      INIT : bit := '0' 
      );

    port(
      Q   : out std_ulogic;

      C   : in  std_ulogic;
      CLR : in  std_ulogic;
      D   : in  std_ulogic;
      PRE : in  std_ulogic
      );
  end component;
attribute syn_black_box of FDDCP : component is true;

  component FDDCPE
    generic(
      INIT : bit := '0'
      );

    port(
       Q   : out std_ulogic;

       C   : in  std_ulogic;
       CE  : in  std_ulogic;
       CLR : in  std_ulogic;
       D   : in  std_ulogic;
       PRE : in  std_ulogic
       );
  end component;
attribute syn_black_box of FDDCPE : component is true;

  component FDDP
    generic(
      INIT : bit := '1' 
      );

    port(
      Q   : out std_ulogic;

      C   : in  std_ulogic;
      D   : in  std_ulogic;
      PRE : in  std_ulogic
      );
  end component;
attribute syn_black_box of FDDP : component is true;

  component FDDPE
    generic(
      INIT : bit := '1' 
      );

    port(
       Q   : out std_ulogic;

       C   : in  std_ulogic;
       CE  : in  std_ulogic;
       D   : in  std_ulogic;
       PRE : in  std_ulogic
       );
  end component;
attribute syn_black_box of FDDPE : component is true;

  component CLK_DIV2
    generic(
      DIVIDE_BY   : integer := 2;
      MAXPERCLKIN : time    := 100 ns
      );
  
    port(
      CLKDV : out std_ulogic := '0';
      CLKIN : in  std_ulogic := '0'
      );
  end component;
attribute syn_black_box of CLK_DIV2 : component is true;

component CLK_DIV4
  generic(
    DIVIDE_BY   : integer := 4;
    MAXPERCLKIN : time    := 100 ns
    );

  port(
    CLKDV : out std_ulogic := '0';
    CLKIN : in  std_ulogic := '0'
    );
end component;
attribute syn_black_box of CLK_DIV4 : component is true;

  component CLK_DIV6
    generic(
      MAXPERCLKIN : time    := 100 ns;
      DIVIDE_BY   : integer := 6
      );
  
    port(
      CLKDV : out std_ulogic := '0';
      CLKIN : in  std_ulogic := '0'
      );
  end component;
attribute syn_black_box of CLK_DIV6 : component is true;

  component CLK_DIV8
    generic (
      MAXPERCLKIN : time    := 100 ns;
      DIVIDE_BY   : integer := 8
      );
  
    port (
      CLKDV : out std_ulogic := '0';
      CLKIN : in  std_ulogic := '0'
      );
  end component;
attribute syn_black_box of CLK_DIV8 : component is true;

  component CLK_DIV10
    generic(
      DIVIDE_BY   : integer := 10;
      MAXPERCLKIN : time    := 100 ns
      );

    port(
      CLKDV : out std_ulogic := '0';

      CLKIN : in  std_ulogic := '0'
      );
  end component;
attribute syn_black_box of CLK_DIV10 : component is true;

  component CLK_DIV12
    generic(
      DIVIDE_BY   : integer := 12;
      MAXPERCLKIN : time    := 100 ns
      );

    port(
      CLKDV : out std_ulogic := '0';

      CLKIN : in  std_ulogic := '0'
      );
 end component;
attribute syn_black_box of CLK_DIV12 : component is true;

  component CLK_DIV14
    generic(
      DIVIDE_BY   : integer := 14;
      MAXPERCLKIN : time    := 100 ns
      );

    port(
      CLKDV : out std_ulogic := '0';

      CLKIN : in  std_ulogic := '0'
      );
 end component;
attribute syn_black_box of CLK_DIV14 : component is true;

  component CLK_DIV16
    generic(
      DIVIDE_BY   : integer := 16;
      MAXPERCLKIN : time := 100 ns
      );

    port(
      CLKDV : out std_ulogic := '0';
      CLKIN : in  std_ulogic := '0'
       );
  end component;
attribute syn_black_box of CLK_DIV16 : component is true;

  component CLK_DIV2R
    generic (
      DIVIDE_BY   : integer := 2;
      MAXPERCLKIN : time    := 100 ns
      );
  
    port (
      CLKDV : out std_ulogic := '0';
  
      CDRST : in std_ulogic := '0';
      CLKIN : in std_ulogic := '0'
      );
  end component;
attribute syn_black_box of CLK_DIV2R : component is true;

  component CLK_DIV4R
    generic (
      MAXPERCLKIN : time    := 100 ns;
      DIVIDE_BY   : integer := 4
      );
  
    port (
      CLKDV : out std_ulogic := '0';
      CDRST : in  std_ulogic := '0';
      CLKIN : in  std_ulogic := '0'
      );
  end component;
attribute syn_black_box of CLK_DIV4R : component is true;

  component CLK_DIV6R
    generic (
      DIVIDE_BY   : integer := 6;
      MAXPERCLKIN : time    := 100 ns
      );
  
    port (
      CLKDV : out std_ulogic := '0';
      CDRST : in  std_ulogic := '0';
      CLKIN : in  std_ulogic := '0'
      );
  end component;
attribute syn_black_box of CLK_DIV6R : component is true;

  component CLK_DIV8R
    generic (
      MAXPERCLKIN : time    := 100 ns;
      DIVIDE_BY   : integer := 8
      );
  
    port (
      CLKDV : out std_ulogic := '0';
      CDRST : in  std_ulogic := '0';
      CLKIN : in  std_ulogic := '0'
      );
  end component;
attribute syn_black_box of CLK_DIV8R : component is true;

  component CLK_DIV10R
    generic(
      DIVIDE_BY   : integer := 10;
      MAXPERCLKIN : time    := 100 ns
      );

    port(
      CLKDV : out std_ulogic := '0';

      CDRST : in  std_ulogic := '0';
      CLKIN : in  std_ulogic := '0'
      );
 end component;
attribute syn_black_box of CLK_DIV10R : component is true;

  component CLK_DIV12R
    generic(
      MAXPERCLKIN : time    := 100 ns;
      DIVIDE_BY   : integer := 12
      );

    port(
      CLKDV : out std_ulogic := '0';

      CDRST : in  std_ulogic := '0';
      CLKIN : in  std_ulogic := '0'
      );
  end component;
attribute syn_black_box of CLK_DIV12R : component is true;

  component CLK_DIV14R
    generic(
      MAXPERCLKIN : time    := 100 ns;
      DIVIDE_BY   : integer := 14
      );

    port(
      CLKDV : out std_ulogic := '0';

      CDRST : in  std_ulogic := '0';
      CLKIN : in  std_ulogic := '0'
      );
 end component;
attribute syn_black_box of CLK_DIV14R : component is true;

  component CLK_DIV16R
    generic(
      DIVIDE_BY   : integer := 16;
      MAXPERCLKIN : time    := 100 ns
      );

    port(
      CLKDV : out std_ulogic := '0';

      CDRST : in  std_ulogic := '0';
      CLKIN : in  std_ulogic := '0'
      );
  end component;
attribute syn_black_box of CLK_DIV16R : component is true;

  component CLK_DIV2SD
    generic(
      MAXPERCLKIN   : time    := 100 ns;
      DIVIDE_BY     : integer := 2;
      DIVIDER_DELAY : integer := 1
      );
  
    port(
      CLKDV : out std_ulogic := '0';
      CLKIN : in  std_ulogic := '0'
      );
  end component;
attribute syn_black_box of CLK_DIV2SD : component is true;

  component CLK_DIV4SD
    generic(
      DIVIDER_DELAY : integer := 1;
      DIVIDE_BY     : integer := 4;
      MAXPERCLKIN   : time    := 100 ns
      );
  
    port(
      CLKDV : out std_ulogic := '0';
      CLKIN : in  std_ulogic := '0'
      );
  end component;
attribute syn_black_box of CLK_DIV4SD : component is true;

  component CLK_DIV6SD
    generic (
      MAXPERCLKIN   : time    := 100 ns;
      DIVIDE_BY     : integer := 6;
      DIVIDER_DELAY : integer := 1
      );
  
    port (
      CLKDV : out std_ulogic := '0';
      CLKIN : in  std_ulogic := '0'
      );
  end component;
attribute syn_black_box of CLK_DIV6SD : component is true;

component CLK_DIV8SD
  generic(
    DIVIDER_DELAY : integer := 1;
    DIVIDE_BY     : integer := 8;
    MAXPERCLKIN   : time    := 100 ns
    );

  port(
    CLKDV : out std_ulogic := '0';
    CLKIN : in  std_ulogic := '0'
    );
end component;
attribute syn_black_box of CLK_DIV8SD : component is true;

  component CLK_DIV10SD
    generic(
      DIVIDER_DELAY : integer := 1;
      DIVIDE_BY     : integer := 10;
      MAXPERCLKIN   : time := 100 ns
      );

    port(
       CLKDV : out std_ulogic := '0';
       CLKIN : in  std_ulogic := '0'
       );
  end component;
attribute syn_black_box of CLK_DIV10SD : component is true;

  component CLK_DIV12SD
    generic(
      DIVIDER_DELAY : integer := 1;
      DIVIDE_BY     : integer := 12;
      MAXPERCLKIN   : time    := 100 ns
      );

    port(
      CLKDV : out std_ulogic := '0';

      CLKIN : in  std_ulogic := '0'

       );
 end component;
attribute syn_black_box of CLK_DIV12SD : component is true;

  component CLK_DIV14SD
    generic(
      MAXPERCLKIN   : time    := 100 ns;
      DIVIDE_BY     : integer := 14;
      DIVIDER_DELAY : integer := 1
      );

    port(
      CLKDV : out std_ulogic := '0';
      CLKIN : in  std_ulogic := '0'
      );
 end component;
attribute syn_black_box of CLK_DIV14SD : component is true;

  component CLK_DIV16SD
    generic(
      DIVIDER_DELAY : integer := 1;
      DIVIDE_BY     : integer := 16;
      MAXPERCLKIN   : time := 100 ns
      );
  
    port(
      CLKDV : out std_ulogic := '0';
      CLKIN : in  std_ulogic := '0'
      );
  end component;
attribute syn_black_box of CLK_DIV16SD : component is true;

  component CLK_DIV2RSD
    generic(
      DIVIDER_DELAY : integer := 1;
      DIVIDE_BY     : integer := 2;
      MAXPERCLKIN   : time    := 100 ns
      );
  
    port(
      CLKDV : out std_ulogic := '0';
      CDRST : in  std_ulogic := '0';
      CLKIN : in  std_ulogic := '0'
      );
  end component;
attribute syn_black_box of CLK_DIV2RSD : component is true;

  component CLK_DIV4RSD
    generic (
      DIVIDER_DELAY : integer := 1;
      DIVIDE_BY     : integer := 4;
      MAXPERCLKIN   : time    := 100 ns
      );
  
    port (
      CLKDV : out std_ulogic := '0';
      CDRST : in  std_ulogic := '0';
      CLKIN : in  std_ulogic := '0'
      );
  end component;
attribute syn_black_box of CLK_DIV4RSD : component is true;

  component CLK_DIV6RSD
    generic (
      MAXPERCLKIN   : time    := 100 ns;
      DIVIDE_BY     : integer := 6;
      DIVIDER_DELAY : integer := 1
      );
  
    port (
      CLKDV : out std_ulogic := '0';
      CDRST : in  std_ulogic := '0';
      CLKIN : in  std_ulogic := '0'
      );
  end component;
attribute syn_black_box of CLK_DIV6RSD : component is true;

  component CLK_DIV8RSD
    generic (
      DIVIDER_DELAY : integer := 1;
      DIVIDE_BY     : integer := 8;
      MAXPERCLKIN : time := 100 ns
      );
  
    port (
      CLKDV : out std_ulogic := '0';
      CDRST : in  std_ulogic := '0';
      CLKIN : in  std_ulogic := '0'
      );
  end component;
attribute syn_black_box of CLK_DIV8RSD : component is true;

  component CLK_DIV10RSD
    generic(
      MAXPERCLKIN   : time    := 100 ns;
      DIVIDE_BY     : integer := 10;
      DIVIDER_DELAY : integer := 1
      );
    port(
      CLKDV : out std_ulogic := '0';

      CDRST : in  std_ulogic := '0';
      CLKIN : in  std_ulogic := '0'
      );
 end component;
attribute syn_black_box of CLK_DIV10RSD : component is true;

  component CLK_DIV12RSD
    generic(
      DIVIDER_DELAY : integer := 1;
      DIVIDE_BY     : integer := 12;
      MAXPERCLKIN   : time    := 100 ns
      );

    port(
      CLKDV : out std_ulogic := '0';

      CDRST : in  std_ulogic := '0';
      CLKIN : in  std_ulogic := '0'
       );
 end component;
attribute syn_black_box of CLK_DIV12RSD : component is true;

  component CLK_DIV14RSD
    generic(
      DIVIDER_DELAY : integer := 1;
      DIVIDE_BY     : integer := 14;
      MAXPERCLKIN   : time    := 100 ns
      );

    port(
      CLKDV : out std_ulogic := '0';

      CDRST : in  std_ulogic := '0';
      CLKIN : in  std_ulogic := '0'
      );
 end component;
attribute syn_black_box of CLK_DIV14RSD : component is true;

  component CLK_DIV16RSD
    generic(
      DIVIDER_DELAY : integer := 1;
      DIVIDE_BY     : integer := 16;
      MAXPERCLKIN   : time    := 100 ns
      );

    port(
      CLKDV : out std_ulogic := '0';

      CDRST : in  std_ulogic := '0';
      CLKIN : in  std_ulogic := '0'
       );
  end component;
attribute syn_black_box of CLK_DIV16RSD : component is true;

  component LDG
    generic(
      INIT : bit := '0' 
      ); 	
    port(
      Q : out std_ulogic;

      D : in  std_ulogic;
      G : in  std_ulogic
      );
   end component;
attribute syn_black_box of LDG : component is true;

  component BSCAN_VIRTEX4
    generic(
      JTAG_CHAIN : integer       := 1);

    port(
      CAPTURE : out std_ulogic := 'H';
      DRCK    : out std_ulogic := 'H';
      RESET   : out std_ulogic := 'H';
      SEL     : out std_ulogic := 'L';
      SHIFT   : out std_ulogic := 'L';
      TDI     : out std_ulogic := 'L';
      UPDATE  : out std_ulogic := 'L';

      TDO     : in  std_ulogic := 'X'
      );
  end component;
attribute syn_black_box of BSCAN_VIRTEX4 : component is true;

  component CAPTURE_VIRTEX4
    port(
      CAP : in std_ulogic;
      CLK : in std_ulogic
      );
  end component;
attribute syn_black_box of CAPTURE_VIRTEX4 : component is true;

  component ICAP_VIRTEX4
    generic(
      ICAP_WIDTH : string := "X8"
    );

    port(

      BUSY  : out std_ulogic;
      O     : out std_logic_vector(31 downto 0);

      CE    : in  std_ulogic;
      CLK   : in  std_ulogic;
      I     : in  std_logic_vector(31 downto 0);
      WRITE : in  std_ulogic
      );
  end component;
attribute syn_black_box of ICAP_VIRTEX4 : component is true;

  component STARTBUF_VIRTEX4
    port(
      EOSOUT : out std_ulogic;
      GSROUT : out std_ulogic;
      GTSOUT : out std_ulogic;
      
      CLKIN  : in  std_ulogic := 'X';
      GSRIN  : in  std_ulogic := 'X';
      GTSIN  : in  std_ulogic := 'X';
      USRCCLKOIN  : in std_ulogic := 'X';
      USRCCLKTSIN : in std_ulogic := 'X';
      USRDONEOIN  : in std_ulogic := 'X';
      USRDONETSIN : in std_ulogic := 'X'
      );
  end component;
attribute syn_black_box of STARTBUF_VIRTEX4 : component is true;

  component STARTUP_VIRTEX4
    port(
      EOS : out std_ulogic;
      CLK : in  std_ulogic := 'X';
      GSR : in  std_ulogic := 'X';
      GTS : in  std_ulogic := 'X';
      USRCCLKO  : in std_ulogic := 'X';
      USRCCLKTS : in std_ulogic := 'X';
      USRDONEO  : in std_ulogic := 'X';
      USRDONETS : in std_ulogic := 'X'
      );
  end component;
attribute syn_black_box of STARTUP_VIRTEX4 : component is true;
attribute syn_noprune of STARTUP_VIRTEX4 : component is true;

-- Components for Backward compatibility #####
component STARTUP_VIRTEX_GTS
   port(GTS: in std_logic);
end component;
attribute syn_black_box of STARTUP_VIRTEX_GTS : component is true;
attribute syn_noprune of STARTUP_VIRTEX_GTS: component is true;
attribute xc_alias of STARTUP_VIRTEX_GTS : component is "STARTUP_VIRTEX";

component STARTUP_VIRTEX_GSR
   port(GSR: in std_logic);
end component;
attribute syn_black_box of STARTUP_VIRTEX_GSR : component is true;
attribute syn_noprune of STARTUP_VIRTEX_GSR: component is true;
attribute xc_alias of STARTUP_VIRTEX_GSR : component is "STARTUP_VIRTEX";

component STARTUP_VIRTEX_CLK
   port( CLK: in std_logic);
end component;
attribute syn_black_box of STARTUP_VIRTEX_CLK : component is true;
attribute syn_noprune of STARTUP_VIRTEX_CLK: component is true;
attribute xc_alias of STARTUP_VIRTEX_CLK: component is "STARTUP_VIRTEX";

component STARTUP_VIRTEX_ALL
   port(GSR,GTS,CLK: in std_logic);
end component;
attribute syn_noprune of STARTUP_VIRTEX_ALL: component is true;
attribute xc_alias of STARTUP_VIRTEX_ALL: component is "STARTUP_VIRTEX";

component STARTUP_SPARTAN2
   port( GSR, GTS, CLK: in std_logic);
end component;

component STARTUP_SPARTAN2_GTS
   port(GTS: in std_logic);
end component;
attribute syn_black_box of STARTUP_SPARTAN2_GTS : component is true;
attribute syn_noprune of STARTUP_SPARTAN2_GTS: component is true;
attribute xc_alias of STARTUP_SPARTAN2_GTS : component is "STARTUP_SPARTAN2";

component STARTUP_SPARTAN2_GSR
   port(GSR: in std_logic);
end component;
attribute syn_black_box of STARTUP_SPARTAN2_GSR : component is true;
attribute syn_noprune of STARTUP_SPARTAN2_GSR: component is true;
attribute xc_alias of STARTUP_SPARTAN2_GSR : component is "STARTUP_SPARTAN2";

component STARTUP_SPARTAN2_CLK
   port( CLK: in std_logic);
end component;
attribute syn_black_box of STARTUP_SPARTAN2_CLK : component is true;
attribute syn_noprune of STARTUP_SPARTAN2_CLK: component is true;
attribute xc_alias of STARTUP_SPARTAN2_CLK: component is "STARTUP_SPARTAN2";

component STARTUP_SPARTAN2_ALL
   port(GSR,GTS,CLK: in std_logic);
end component;
attribute syn_noprune of STARTUP_SPARTAN2_ALL: component is true;
attribute xc_alias of STARTUP_SPARTAN2_ALL: component is "STARTUP_SPARTAN2";

attribute syn_black_box of SRLC16_1 : component is true;
component STARTUP_VIRTEX2_CLK
 port (
   CLK : in std_logic
 );
end component;
attribute syn_black_box of STARTUP_VIRTEX2_CLK : component is true;
attribute syn_noprune of STARTUP_VIRTEX2_CLK : component is true;
attribute xc_alias of STARTUP_VIRTEX2_CLK : component is "STARTUP_VIRTEX2";
component STARTUP_VIRTEX2_GSR
 port (
   GSR : in std_logic
 );
end component;
attribute syn_black_box of STARTUP_VIRTEX2_GSR : component is true;
attribute syn_noprune of STARTUP_VIRTEX2_GSR : component is true;
attribute xc_alias of STARTUP_VIRTEX2_GSR : component is "STARTUP_VIRTEX2";
component STARTUP_VIRTEX2_GTS
 port (
   GTS : in std_logic
 );
end component;
attribute syn_black_box of STARTUP_VIRTEX2_GTS : component is true;
attribute syn_noprune of STARTUP_VIRTEX2_GTS : component is true;
attribute xc_alias of STARTUP_VIRTEX2_GTS : component is "STARTUP_VIRTEX2";

component STARTUP_VIRTEX2_ALL
 port (
   CLK,GSR,GTS : in std_logic := '0'
 );
end component;
attribute syn_black_box of STARTUP_VIRTEX2_ALL : component is true;
attribute syn_noprune of STARTUP_VIRTEX2_ALL : component is true;
attribute xc_alias of STARTUP_VIRTEX2_ALL : component is "STARTUP_VIRTEX2";

-- End backward compatibility components
end VCOMPONENTS;

--#### Start Entity-Architectures for legacy support #####

-- The following Entity-Architectures are for 
-- Supporting Legacy Synplify designs

library IEEE;
use IEEE.std_logic_1164.all;
library synplify;
use synplify.attributes.all;
entity PULLUP is
 port (
   O : out std_logic
 );
 attribute syn_not_a_driver : boolean;
 attribute syn_not_a_driver of O : signal is true;
end entity PULLUP;

architecture bb of PULLUP is
attribute syn_black_box of bb : architecture is true;
attribute syn_noprune of bb : architecture is true;
begin
end architecture bb;

library ieee;
use ieee.std_logic_1164.all;
library synplify;
use synplify.attributes.all;
entity PULLDOWN is
 port (
   O : out std_logic
 );
 attribute syn_not_a_driver : boolean;
 attribute syn_not_a_driver of O : signal is true;
end entity PULLDOWN;

architecture bb of PULLDOWN is
attribute syn_black_box of bb : architecture is true;
attribute syn_noprune of bb : architecture is true;
begin
end architecture bb;

library ieee;
use ieee.std_logic_1164.all;
library synplify;
use synplify.attributes.all;
entity LUT1 is
 generic (INIT : bit_vector(1 downto 0));
 port (
   O : out std_logic;
   I0 : in std_logic
 );
end entity LUT1;

architecture lut of LUT1 is
attribute xc_map of lut : architecture is "lut";
attribute syn_black_box of lut : architecture is true;
begin
--O <= To_StdULogic(INIT(1)) when I0 = '1' else To_StdULogic(INIT(0));
end architecture lut;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
library synplify;
use synplify.attributes.all;
entity LUT2 is
 generic (INIT : bit_vector(3 downto 0));
 port (
   O : out std_logic;
  I0 : in std_logic;
  I1 : in std_logic
 );
end entity LUT2;

architecture lut of LUT2 is
attribute xc_map of lut : architecture is "lut";
attribute syn_black_box of lut : architecture is true;
--signal b : std_logic_vector(1 downto 0);
--signal tmp : integer range 0 to 7;
begin
--   b <= (I1, I0);
--   tmp <= conv_integer(b);
--   O <= To_StdULogic(INIT(tmp));
end architecture lut;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
library synplify;
use synplify.attributes.all;
entity LUT3 is
 generic (INIT : bit_vector(7 downto 0));
 port (
   O : out std_logic;
  I0 : in std_logic;
  I1 : in std_logic;
  I2 : in std_logic
 );
end entity LUT3;

architecture lut of LUT3 is
attribute xc_map of lut : architecture is "lut";
attribute syn_black_box of lut : architecture is true;
--signal b : std_logic_vector(2 downto 0);
--signal tmp : integer range 0 to 7;
begin
--   b <= (I2, I1, I0);
--   tmp <= conv_integer(b);
--   O <= To_StdULogic(INIT(tmp));
end architecture lut;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
library synplify;
use synplify.attributes.all;
entity LUT4 is
 generic (INIT : bit_vector(15 downto 0));
 port (
   O : out std_logic;
  I0 : in std_logic;
  I1 : in std_logic;
  I2 : in std_logic;
  I3 : in std_logic
  );
end entity LUT4;

architecture lut of LUT4 is
attribute xc_map of lut : architecture is "lut";
attribute syn_black_box of lut : architecture is true;
--signal b : std_logic_vector(3 downto 0);
--signal tmp : integer range 0 to 15;
begin
--  b <= (I3, I2, I1, I0);
--  tmp <= conv_integer(b);
--  O <= To_StdUlogic(INIT(tmp));
end architecture lut;

library IEEE;
use IEEE.std_logic_1164.all;
library virtex;
use virtex.components.all;
library synplify;
use synplify.attributes.all;
entity STARTUP_VIRTEX is
   port(GSR, GTS, CLK: in std_logic := '0');
end STARTUP_VIRTEX;

architecture struct of STARTUP_VIRTEX is
attribute syn_noprune of struct : architecture is true;
begin
  gsr0 : STARTUP_VIRTEX_GSR port map ( GSR => GSR );
  gts0 : STARTUP_VIRTEX_GTS port map ( GTS => GTS );
  clk0 : STARTUP_VIRTEX_CLK port map ( CLK => CLK);
end struct;

library IEEE;
use IEEE.std_logic_1164.all;
library virtex;
use virtex.components.all;
library synplify;
use synplify.attributes.all;
entity STARTUP_SPARTAN2 is
   port(GSR, GTS, CLK: in std_logic := '0');
end STARTUP_SPARTAN2;

architecture struct of STARTUP_SPARTAN2 is
attribute syn_noprune of struct : architecture is true;
begin
  gsr0 : STARTUP_SPARTAN2_GSR port map ( GSR => GSR );
  gts0 : STARTUP_SPARTAN2_GTS port map ( GTS => GTS );
  clk0 : STARTUP_SPARTAN2_CLK port map ( CLK => CLK);
end struct;

library IEEE;
use IEEE.std_logic_1164.all;
library virtex2;
use virtex2.components.all;
library synplify;
use synplify.attributes.all;
entity STARTUP_VIRTEX2 is
   port(CLK, GSR, GTS: in std_logic := '0');
end STARTUP_VIRTEX2;

architecture struct of STARTUP_VIRTEX2 is
attribute syn_noprune of struct : architecture is true;
begin
  gsr0 : STARTUP_VIRTEX2_GSR port map ( GSR => GSR );
  gts0 : STARTUP_VIRTEX2_GTS port map ( GTS => GTS );
  clk0 : STARTUP_VIRTEX2_CLK port map ( CLK => CLK);
end struct;


--------------------------------
!TCL! } else {
entity unisim_void is
end unisim_void;
!TCL! }