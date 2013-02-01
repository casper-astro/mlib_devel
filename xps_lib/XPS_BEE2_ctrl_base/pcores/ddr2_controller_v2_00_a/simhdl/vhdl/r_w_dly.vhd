library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--
-- pragma translate_off
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
-- pragma translate_on
--
entity r_w_dly is
 port(
      clk     : in std_logic;
      rst     : in std_logic;
      dly_inc : in std_logic;
      dly_tc  : out std_logic;
      r_w     : out std_logic
      );
end r_w_dly;

architecture arc_r_w_dly of r_w_dly is 

signal delay_count : std_logic_vector(4 downto 0);
signal delay_tc    : std_logic;
signal read_write  : std_logic;

begin

       read_write_proc : process(clk)
	begin
	     if falling_edge(clk) then
		if (rst='1') then
		  read_write <= '0';
		else
		  if (delay_tc = '1') then
		    read_write <= not(read_write);
		  end if;
		end if;
	     end if;
	end process read_write_proc;
	
	delay_counter : process(clk)
	begin
	     if falling_edge(clk) then	 
		if (rst='1') then
		    delay_count <= "00000";
		else
		        if dly_inc = '1' then
			   delay_count <= delay_count + "0001" ;
                 	end if;
		end if;
	     end if;
	end process delay_counter;	
	
	delay_tc_proc : process(clk)
	begin
	     if falling_edge(clk) then
		if (rst='1') then
			delay_tc <= '0';
		else
			if (delay_count="11000") then -- decimal 28??
				delay_tc <= '1';
			else 
				delay_tc <= '0';
			end if;
		end if;
	     end if;
	end process delay_tc_proc;

dly_tc <= delay_tc;
r_w    <= read_write;

end arc_r_w_dly;
