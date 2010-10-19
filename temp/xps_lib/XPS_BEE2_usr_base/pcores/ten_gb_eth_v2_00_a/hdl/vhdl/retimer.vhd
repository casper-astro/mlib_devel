--  File name :       retimer.vhd
--
--  Description :     
--                    Handshake retimer to transmit data through a clock boundary
--
--  Date - revision : 08/05/2006
--
--  Author :          Pierre-Yves Droz
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity retimer is
	generic(
		WIDTH                 : integer           := 32
	);
	port (
		-- source clock
		src_clk               : in  std_logic;
		-- source data
		src_data              : in  std_logic_vector(WIDTH-1 downto 0);

		-- destination clock
		dest_clk              : in  std_logic;
		-- destination data
		dest_data             : out std_logic_vector(WIDTH-1 downto 0);
		-- new destination data
		dest_new_data         : out std_logic
	);
end entity retimer;

architecture retimer_arch of retimer is

	signal frozen_data    : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
	signal data_ready     : std_logic := '0';
	signal data_ready_R   : std_logic := '0';
	signal data_ready_pre : std_logic := '0';
	signal data_ack       : std_logic := '0';
	signal data_ack_R     : std_logic := '0';
	signal data_ack_pre   : std_logic := '0';

	attribute keep        : string;
	attribute keep of data_ready_pre : signal is "true";
	attribute keep of data_ready_R   : signal is "true";
	attribute keep of data_ack_pre   : signal is "true";
	attribute keep of data_ack_R     : signal is "true";

begin

-- source clock process
process(src_clk)
begin
	if src_clk'event and src_clk = '1' then
		data_ack_pre <= data_ack    ;
		data_ack_R   <= data_ack_pre;
		if data_ready = '0' and data_ack_R = '0' then
			frozen_data  <= src_data;
			data_ready   <= '1';
		end if;
		if data_ready = '1' and data_ack_R = '1' then
			data_ready   <= '0';
		end if;
	end if;
end process;

-- destination clock process
process(dest_clk)
begin
	if dest_clk'event and dest_clk = '1' then
		dest_new_data <= '0';
		data_ready_pre <= data_ready    ;
		data_ready_R   <= data_ready_pre;
		if data_ready_R = '1' and data_ack = '0' then
			dest_data     <= frozen_data;
			dest_new_data <= '1';
			data_ack      <= '1';
		end if;
		if data_ready_R = '0' and data_ack = '1' then
			data_ack      <= '0';
		end if;
	end if;
end process;

end architecture retimer_arch;
