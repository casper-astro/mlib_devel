library ieee;
use ieee.std_logic_1164.all;
use work.parameter.all;
--
-- pragma translate_off
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
-- pragma translate_on
--
--library synplify; 
--use synplify.attributes.all; 



entity cal_top is
port(
     clk         : in std_logic;
     clk0        : in std_logic;
     clk0dcmlock : in std_logic;
     reset       : in std_logic;
     okToSelTap  : in std_logic;
     tapForDqs   : out std_logic_vector( 4 downto 0)
     );
end cal_top;

architecture arc_cal_top of cal_top is

attribute syn_noprune :boolean;


component DCM
-- pragma translate_off
  generic (
    CLKOUT_PHASE_SHIFT : string := "VARIABLE";
    DLL_FREQUENCY_MODE : string := "LOW";
    DUTY_CYCLE_CORRECTION : boolean := TRUE;
    PHASE_SHIFT : integer := 128
    );
-- pragma translate_on
 port (    CLKIN     : in  std_logic;
           CLKFB     : in  std_logic;
           DSSEN     : in  std_logic;
           PSINCDEC  : in  std_logic;
           PSEN      : in  std_logic;
           PSCLK     : in  std_logic;
           RST       : in  std_logic;
           CLK0      : out std_logic;
           CLK90     : out std_logic;
           CLK180    : out std_logic;
           CLK270    : out std_logic;
           CLK2X     : out std_logic;
           CLK2X180  : out std_logic;
           CLKDV     : out std_logic;
           CLKFX     : out std_logic;
           CLKFX180  : out std_logic;
           LOCKED    : out std_logic;
           PSDONE    : out std_logic;
           STATUS    : out std_logic_vector(7 downto 0)
          );
end component;


component BUFG 
	port(
	     O    :	out std_logic;
	     I    :	in  std_logic
	     );
end component;

component dqs_delay                                             
              port (
		    clk_in   : in std_logic;
		    sel_in   : in std_logic_vector(4 downto 0);
		    clk_out  : out std_logic
		  );                                           
end component;

component cal_ctl
             port (
                   clk          : in std_logic;
                   okToSelTap   : in std_logic;
                   psDone       : in std_logic;
                   reset        : in std_logic;
                   hxSamp1      : in std_logic;
                   phSamp1      : in std_logic;
                   dcmlocked    : in std_logic;
                   locReset     : out std_logic;
                   psEn         : out std_logic;
                   psInc        : out std_logic;
                   selTap       : out std_logic_vector( 4 downto 0);
                   tapForDqs    : out std_logic_vector( 4 downto 0)
                  );
end component;

component cal_div2
              port (
                    reset      : in std_logic;
                    iclk       : in std_logic;
                    oclk       : out std_logic
                   );
end component;


component cal_div2f
              port (
                    reset      : in std_logic;
                    iclk       : in std_logic;
                    oclk       : out std_logic
                   );
end component;


component cal_reg 
             port (
                   clk       : in std_logic;
                   dInp      : in std_logic;
                   iReg      : out std_logic;
                   dReg      : out std_logic
                  );
end component;
 
constant noMuxF5: std_logic := '1';

signal fpga_rst     : std_logic;
signal divRst       : std_logic;
signal gnd          : std_logic;
signal phShftClk    : std_logic;
signal phShftClkDcm : std_logic;
signal psInc        : std_logic;
signal psEn         : std_logic;
signal dcmlocked    : std_logic;
signal psDone       : std_logic;
signal hexClk       : std_logic;
signal clkDiv2      : std_logic;
signal phClkDiv2    : std_logic;
signal selTap       : std_logic_vector( 4 downto 0);
signal locReset     : std_logic;
signal hxSamp1      : std_logic;
signal phSamp1      : std_logic;
signal reset_not    : std_logic;
signal hxSamp0      : std_logic;
signal suClkDiv2    : std_logic;
signal suPhClkDiv2  : std_logic;
signal phSamp0      : std_logic;

signal hexClk_defer : std_logic;
signal phclk_defer  : std_logic;

attribute CLKOUT_PHASE_SHIFT : string;
attribute DLL_FREQUENCY_MODE : string;
attribute DUTY_CYCLE_CORRECTION : string; 
attribute PHASE_SHIFT : integer;

attribute CLKOUT_PHASE_SHIFT of cal_dcm : label is "VARIABLE";
attribute DLL_FREQUENCY_MODE of cal_dcm : label is "LOW";
attribute DUTY_CYCLE_CORRECTION of cal_dcm  : label is "TRUE"; 
attribute PHASE_SHIFT of cal_dcm : label is 128;

attribute syn_noprune of cal_clkd2 : label is true;
attribute syn_noprune of cal_phClkd2 : label is true;
--attribute syn_noprune of cal_suclkd2 : label is true;
--attribute syn_noprune of cal_suphClkd2 : label is true;

begin

reset_not <= not reset;
gnd      <= '0';


cal_dcm : DCM         
port map (
                        CLKIN    =>  clk,
                        CLKFB    =>  phShftClk,
                        DSSEN    =>  gnd,
                        PSINCDEC =>  psInc,
                        PSEN     =>  psEn,
                        PSCLK    =>  clk0,
                        RST      =>  reset_not,
                        CLK0     =>  phShftClkDcm,
                        CLK90    =>  open,
                        CLK180   =>  open,
                        CLK270   =>  open,
                        CLK2X    =>  open,
                        CLK2X180 =>  open,
                        CLKDV    =>  open,
                        CLKFX    =>  open,
                        CLKFX180 =>  open,
                        LOCKED   =>  dcmlocked,
                        PSDONE   =>  psDone,
                        STATUS   =>  open );


process (clk0)
begin
  if clk0'event and clk0 = '1' then
--     if reset = '0' then
--        fpga_rst <= '1';
--     else
--        fpga_rst <= not (dcmlocked and clk0dcmlock) after 1 ps ;
        fpga_rst <= not (reset and dcmlocked and clk0dcmlock) after 1 ps ;
--   end if;
 end if;
end process;

divRst   <= not (dcmlocked and clk0dcmlock) after 1 ps ;



phclk_bufg : BUFG port map (
                            I    =>  phShftClkDcm,
                            O    =>  phShftClk);

cal_ctl0   : cal_ctl port map (
                               clk         =>   clk0,
                               psDone      =>   psDone,
                               reset       =>   fpga_rst,
                               okToSelTap  =>   okToSelTap,
                               locReset    =>   locReset,
                               hxSamp1     =>   hxSamp1,
                               phSamp1     =>   phSamp1,
                               selTap      =>   SelTap,
                               psEn        =>   psEn,
                               psInc       =>   psInc,
                               dcmlocked   =>   dcmlocked,
                               tapForDqs   =>   tapForDqs);


cal_clkd2  : cal_div2 port map (
                                reset    =>  divRst,
                                iclk     =>  clk0,
                                oclk     =>  clkDiv2);

cal_phClkd2 : cal_div2f port map (
                                 reset   => divRst,
                                 iclk    => phShftClk,
                                 oclk    => phClkDiv2);

hexClk_defer <= hexClk after 2 ps;

hxSampReg0 : cal_reg port map (
                                clk      =>   hexClk,
                                --clk      =>   hexClk_defer,
                                dInp     =>   clkDiv2,
                                iReg     =>   hxSamp0,
                                dReg     =>   hxSamp1);

cal_suClkd2  : cal_div2 port map (
                                  reset   => divRst,
                                  iclk    => clk0,
                                  oclk    => suClkDiv2);

cal_suPhClkd2 : cal_div2f port map (
                                   reset   =>  divRst,
                                   iclk    =>  phShftClk,
                                   oclk    =>  suPhClkDiv2);

phclk_defer <= suPhClkDiv2 after 2 ps;

phSampReg0   : cal_reg port map (
                                 clk      =>   suPhClkDiv2,
                                 --clk      =>   phclk_defer,
                                 dInp     =>   suClkDiv2,
                                 iReg     =>   phSamp0,
                                 dReg     =>   phSamp1);


ckt_to_cal  : dqs_delay port map (
                                  clk_in    =>   phClkDiv2,
                                  sel_in    =>   selTap,
                                  clk_out   =>   hexClk);
	
end arc_cal_top;
