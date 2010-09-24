--#############################################################################//
--         Internal dqs delay structure for ddr sdram controller               //                          
--#############################################################################//

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- pragma translate_off     
library UNISIM;             
use UNISIM.VCOMPONENTS.ALL; 
-- pragma translate_on      

entity dqs_delay is 
              port (
		    clk_in   : in std_logic;
		    sel_in   : in std_logic_vector(4 downto 0);
		    clk_out  : out std_logic
		  );
end dqs_delay;

architecture arc_dqs_delay of dqs_delay is

!TCL! if $synthesize {
attribute syn_hier : string;
attribute syn_noprune : boolean;
attribute syn_hier of arc_dqs_delay: architecture is "hard";
attribute syn_noprune of arc_dqs_delay: architecture is true;


component LUT4
   generic(
      INIT                           :  bit_vector(15 downto 0) := x"0000" );
   port(
      O                              :	out   STD_ULOGIC;
      I0                             :	in    STD_ULOGIC;
      I1                             :	in    STD_ULOGIC;
      I2                             :	in    STD_ULOGIC;
      I3                             :	in    STD_ULOGIC
      );
end component;		  
    
signal delay1     : std_logic;
signal delay2     : std_logic;
signal delay3     : std_logic;
signal delay4     : std_logic;
signal delay5     : std_logic;
signal high       : std_logic;

begin

high <= '1';   
   
one :  LUT4  generic map (INIT => x"f3c0")  
port map   ( I0 => high, 
             I1 => sel_in(4), 
             I2 => delay5, 
             I3 => clk_in, 
             O  => clk_out
            );
  
   
two :  LUT4  generic map (INIT => x"ee22")   
port map   ( 
            I0 => clk_in, 
            I1 => sel_in(2), 
            I2 => high, 
            I3 => delay3, 
            O  => delay4
           );
   
three :  LUT4  generic map (INIT => x"e2e2")    
port map     ( 
              I0 => clk_in, 
              I1 => sel_in(0), 
              I2 => delay1, 
              I3 => high, 
              O  => delay2 
             );
   
four :  LUT4  generic map (INIT => x"ff00")    
port map    ( 
             I0 => high, 
             I1 => high, 
             I2 => high, 
             I3 => clk_in, 
             O  => delay1 
            );
   
five :  LUT4  generic map (INIT => x"f3c0")    
port map    ( 
             I0 => high, 
             I1 => sel_in(3), 
             I2 => delay4, 
             I3 => clk_in, 
             O  => delay5 
            );
   
six :  LUT4  generic map (INIT => x"e2e2")    
port map  ( 
            I0 => clk_in, 
            I1 => sel_in(1), 
            I2 => delay2, 
            I3 => high, 
            O  => delay3 
           );
   
!TCL! } else {
begin

	clk_out <= clk_in after 1250 ps;
!TCL! }

end arc_dqs_delay;