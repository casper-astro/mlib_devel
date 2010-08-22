
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- pragma translate_off
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
-- pragma translate_on
--

entity infrastructure is
port(
	clk                    : in std_logic;
	clk90                  : in std_logic;
	inf_reset              : in std_logic;
	user_reset             : in std_logic;
	reset0                 : out std_logic;
	reset90                : out std_logic;
	reset180               : out std_logic;
	reset270               : out std_logic
);  
end   infrastructure;

architecture arc_infrastructure of infrastructure is

signal reset                 : std_logic := '1';
signal reset_reg0            : std_logic := '1';
signal reset_reg90           : std_logic := '1';
signal reset_reg180          : std_logic := '1';
signal reset_reg270          : std_logic := '1';
signal reset_reg0_resamp     : std_logic := '1';
signal reset_reg90_resamp    : std_logic := '1';
signal reset_reg180_resamp   : std_logic := '1';
signal reset_reg270_resamp   : std_logic := '1';
signal reset0_0              : std_logic := '1';
signal reset90_0             : std_logic := '1';
signal reset180_0            : std_logic := '1';
signal reset270_0            : std_logic := '1';
signal reset0_1              : std_logic := '1';
signal reset90_1             : std_logic := '1';
signal reset180_1            : std_logic := '1';
signal reset270_1            : std_logic := '1';

attribute syn_noprune : boolean;
attribute syn_noprune of reset_reg0      : signal is true;
attribute syn_noprune of reset_reg90     : signal is true;
attribute syn_noprune of reset_reg180    : signal is true;
attribute syn_noprune of reset_reg270    : signal is true;

begin


-- register the reset a first time
process(clk)
begin
	if clk'event and clk = '1' then
		reset       <= user_reset or inf_reset;
	end if;
end process;

-- register the reset a second time with a different register for each clock
process(clk)
begin
	if clk'event and clk = '1' then
		reset_reg0    <= reset;
		reset_reg90   <= reset;
		reset_reg180  <= reset;
		reset_reg270  <= reset;
	end if;
end process;

-- resample the reset on each clock
process(clk)
begin
	if clk'event and clk = '1' then
		if reset_reg0 = '1' then
			reset0_0    <= '1';
			reset0_1    <= '1';
			reset0      <= '1';
		else
			reset0_0    <= '0';
			reset0_1    <= reset0_0;
			reset0      <= reset0_1;
		end if;
	end if;
end process;

process(clk90)
begin
	if clk90'event and clk90 = '1' then
		if reset_reg90_resamp = '1' then
			reset90_0   <= '1';
			reset90_1   <= '1';
			reset90     <= '1';
		else
			reset90_0   <= '0';
			reset90_1   <= reset90_0;
			reset90     <= reset90_1;
		end if;
		reset_reg90_resamp <= reset_reg90;
	end if;
end process;

process(clk)
begin
	if clk'event and clk = '0' then
		if reset_reg180_resamp = '1' then
			reset180_0  <= '1';
			reset180_1  <= '1';
			reset180    <= '1';
		else
			reset180_0  <= '0';
			reset180_1  <= reset180_0;
			reset180    <= reset180_1;
		end if;
		reset_reg180_resamp <= reset_reg180;
	end if;
end process;

process(clk90)
begin
	if clk90'event and clk90 = '0' then
		if reset_reg270_resamp = '1' then
			reset270_0  <= '1';
			reset270_1  <= '1';
			reset270    <= '1';
		else
			reset270_0  <= '0';
			reset270_1  <= reset270_0;
			reset270    <= reset270_1;
		end if;
		reset_reg270_resamp <= reset_reg270;
	end if;
end process;



end arc_infrastructure;



