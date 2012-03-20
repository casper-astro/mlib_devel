library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--
-- pragma translate_off
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
-- pragma translate_on

entity cal_div2f is
port(
		reset : in std_logic;
		iclk  : in std_logic;
		oclk  : out std_logic
		);

end cal_div2f;

architecture arc_cal_div2f of cal_div2f is

signal  poclk        : std_logic;
   
begin

process (iclk)
begin
 if iclk'event and iclk = '0' then
	if reset = '1' then
		 poclk <= '0';
		 oclk <= '0';
	else 
		 poclk <= not poclk;
		 oclk <= poclk;
	end if;
 end if;
end process;	


end arc_cal_div2f;
