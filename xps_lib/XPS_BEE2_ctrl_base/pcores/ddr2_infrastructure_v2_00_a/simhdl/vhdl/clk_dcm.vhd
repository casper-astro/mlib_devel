library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
--
-- pragma translate_off
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
-- pragma translate_on
--
--library synplify; 
--use synplify.attributes.all; 

--library work;
--use work.hispdclks_pkg_2vp20.all;

entity clk_dcm is 

port(
   input_clk   : in std_logic;
   rst         : in std_logic;
   clk         : out std_logic;
   clk90       : out std_logic;
   dcm_lock    : out std_logic
   );
end clk_dcm;

architecture arc_clk_dcm of clk_dcm is

--attribute syn_hier : string;
--attribute syn_hier of arc_clk_dcm: architecture is "hard";

component DCM
-- pragma translate_off
    generic ( 
             DLL_FREQUENCY_MODE    : string := "LOW";
             DUTY_CYCLE_CORRECTION : boolean := TRUE
            );  
-- pragma translate_on

    port ( CLKIN     : in  std_logic;
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
  port ( I : in std_logic;
         O : out std_logic);
 end component;


 component dcmx3y0_2vp70_sim
   port (  clock1_in     : in std_logic;   
           clock2_in     : in std_logic;   
           clock1_out    : out std_logic;   
           clock2_out    : out std_logic);   
end component;

signal clk0dcm             : std_logic;
signal clk90dcm            : std_logic;
signal clk0d2inv           : std_logic;
signal clk90d2inv          : std_logic;
signal clk0_buf            : std_logic;
signal clk90_buf           : std_logic;
signal vcc                 : std_logic;
signal gnd                 : std_logic;
signal dcm1_lock           : std_logic;


attribute DLL_FREQUENCY_MODE : string; 
attribute DUTY_CYCLE_CORRECTION : string;
attribute CLKIN_DIVIDE_BY_2     : string;

---attribute syn_noclockbuf : boolean;
----attribute syn_noclockbuf of clk0_buf: signal is true;
----attribute syn_noclockbuf of clk90_buf: signal is true;

attribute DLL_FREQUENCY_MODE of DCM_INST1    : label is "LOW";
attribute DUTY_CYCLE_CORRECTION of DCM_INST1 : label is "TRUE";

begin

vcc <= '1';
gnd <= '0';

clk    <= clk0_buf;
clk90  <= clk90_buf;

DCM_INST1 :  DCM 
                 port map ( CLKIN    => input_clk,
                            CLKFB    => clk0_buf,
                            DSSEN    => gnd,
                            PSINCDEC => gnd,
                            PSEN     => gnd,
                            PSCLK    => gnd,
                            RST      => RST,
                            CLK0     => clk0dcm,
                            CLK90    => clk90dcm,
                            CLK180   => open,
                            CLK270   => open,
                            CLK2X    => open,
                            CLK2X180 => open,
                            CLKDV    => open,
                            CLKFX    => open,
                            CLKFX180 => open,
                            LOCKED   => dcm1_lock,
                            PSDONE   => open,
                            STATUS   => open);

DCD0    : dcmx3y0_2vp70_sim
        port map ( clock1_in   =>   clk0dcm,
                   clock2_in   =>   clk90dcm,
                   clock1_out  =>   clk0d2inv,
                   clock2_out  =>   clk90d2inv);

BUFG_CLK0    : BUFG port map ( I => clk0d2inv ,
                               O => clk0_buf);
                                                              
BUFG_CLK90   : BUFG port map ( I => clk90d2inv,
                               O => clk90_buf); 

dcm_lock <= dcm1_lock;                                 

end arc_clk_dcm;




