----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.10.2015 11:54:59
-- Design Name: 
-- Module Name: FPGA_DNA_CHECKER - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity FPGA_DNA_CHECKER is
	Port(
		CLK_I            : in  std_logic;
		RST_I            : in  std_logic;

		FPGA_EMCCLK2_I   : in  std_logic;
		FPGA_DNA_O       : out std_logic_vector(63 downto 0);
		FPGA_DNA_MATCH_O : out std_logic
	);
end FPGA_DNA_CHECKER;

architecture Behavioral of FPGA_DNA_CHECKER is
	signal local_reset_sr : std_logic_vector(3 downto 0) := (others => '1');
	signal local_reset    : std_logic                    := '1';

	signal DNA_COUNT     : unsigned(5 downto 0) := (others => '0');
	signal DNA_DOUT      : std_logic            := '0';
	signal DNA_READ      : std_logic            := '0';
	signal DNA_SHIFT     : std_logic            := '0';
	signal DNA_READ_DONE : std_logic            := '0';

	signal DNA_VALUE : std_logic_vector(56 downto 0) := (others => '0');
	signal DNA_MATCH : std_logic                     := '0';

begin
	DNA_PORT_inst : DNA_PORT
		generic map(
			SIM_DNA_VALUE => X"380E92D2011508" & '1' -- Specifies a sample 57-bit DNA value for simulation
		)
		port map(
			DOUT  => DNA_DOUT,          -- 1-bit output: DNA output data.
			CLK   => FPGA_EMCCLK2_I,    -- 1-bit input: Clock input.
			DIN   => DNA_DOUT,          -- 1-bit input: User data input pin.
			READ  => DNA_READ,          -- 1-bit input: Active high load DNA, active low read input.
			SHIFT => DNA_SHIFT          -- 1-bit input: Active high shift enable input.
		);

	LOCAL_RESET_proc : process(FPGA_EMCCLK2_I) is
	begin
		if rising_edge(FPGA_EMCCLK2_I) then
			local_reset_sr(0)          <= '0';
			local_reset_sr(3 downto 1) <= local_reset_sr(2 downto 0);
		end if;
	end process LOCAL_RESET_proc;
	
	local_reset <= local_reset_sr(3);
		
	DNA_PORT_READ_proc : process(FPGA_EMCCLK2_I) is
	begin
		if rising_edge(FPGA_EMCCLK2_I) then
			if local_reset = '1' then
				DNA_COUNT     <= (others => '0');
				DNA_READ      <= '0';
				DNA_SHIFT     <= '0';
				DNA_READ_DONE <= '0';

				DNA_VALUE <= (others => '0');
				DNA_MATCH <= '0';
			else
				if (DNA_COUNT = 59) then
					DNA_READ      <= '0';
					DNA_SHIFT     <= '0';
					DNA_READ_DONE <= '1';
				--					DNA_COUNT     <= (others => '0');
				else
					DNA_COUNT <= DNA_COUNT + 1;
					if (DNA_SHIFT = '0') then
						if (DNA_READ = '0') then
							DNA_READ <= '1';
						else
							DNA_SHIFT <= '1';
							DNA_READ  <= '0';
						end if;
					else
						DNA_VALUE(56)          <= DNA_DOUT;
						DNA_VALUE(55 downto 0) <= DNA_VALUE(56 downto 1);
					end if;
				end if;

				case DNA_VALUE(56 downto 1) is
					when X"123456789ABCDE" => DNA_MATCH <= '1';
					when X"380E92D2011508" => DNA_MATCH <= '1';
					when X"380E92D201150A" => DNA_MATCH <= '1';
					when others            => DNA_MATCH <= '0';
				end case;
			end if;

		end if;
	end process DNA_PORT_READ_proc;

	fpga_dna_register_proc : process(CLK_I) is
	begin
		if rising_edge(CLK_I) then
			FPGA_DNA_O <= DNA_MATCH & DNA_READ_DONE & DNA_SHIFT & DNA_READ & "000" & DNA_VALUE;
		end if;
	end process fpga_dna_register_proc;

	FPGA_DNA_MATCH_O <= DNA_MATCH;

end Behavioral;
