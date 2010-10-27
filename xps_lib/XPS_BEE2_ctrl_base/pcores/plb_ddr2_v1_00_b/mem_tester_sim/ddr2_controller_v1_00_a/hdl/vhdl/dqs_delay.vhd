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

begin

	clk_out <= clk_in after 1250 ps;

end arc_dqs_delay;
