----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.10.2014 15:14:51
-- Design Name: 
-- Module Name: PRBS31_PATTERN_GENERATOR - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PRBS31_PATTERN_GENERATOR is
	Generic(
		INITIAL_SEED_VALUE : std_logic_vector(30 downto 0) := (10 => '1', others => '0');
		C_AXIS_TDATA_WIDTH : integer                       := 256
	);
	Port(
		-- Ports of Axi Master Bus Interface M00_AXIS
		-- Global ports
		AXIS_ACLK      : in  std_logic;
		AXIS_ARESETN   : in  std_logic;
		-- Master Stream Ports.
		M0_AXIS_TVALID : out std_logic;
		M0_AXIS_TREADY : in  std_logic;
		M0_AXIS_TDATA  : out std_logic_vector(C_AXIS_TDATA_WIDTH - 1 downto 0);
		M0_AXIS_TLAST  : out std_logic;
		ENABLE_I       : in  std_logic
	);
end PRBS31_PATTERN_GENERATOR;

architecture Behavioral of PRBS31_PATTERN_GENERATOR is
	signal pattern_data_valid : std_logic;
	signal pattern_data       : std_logic_vector(C_AXIS_TDATA_WIDTH - 1 downto 0);

	signal S : std_logic_vector(30 downto 0);
	signal Y : std_logic_vector(C_AXIS_TDATA_WIDTH - 1 downto 0);
begin
	S_bits : for i in 0 to 30 generate
		S(i) <= pattern_data(C_AXIS_TDATA_WIDTH - 1 - i);
	end generate S_bits;

	bits_A_Section : for i in 0 to 27 generate
	begin
		Y(i) <= '1' xor (S(27 - i) xor S(30 - i));
	end generate bits_A_Section;

	bits_B_Section : for i in 28 to 30 generate
	begin
		Y(i) <= '1' xor (Y(i - 28) xor S(30 - i));
	end generate bits_B_Section;

	bits_C_Section : for i in 31 to C_AXIS_TDATA_WIDTH - 1 generate
	begin
		Y(i) <= '1' xor (Y(i - 28) xor Y(i - 31));
	end generate bits_C_Section;

	PATTERN_GENERATOR_proc : process(AXIS_ACLK)
	begin
		if (rising_edge(AXIS_ACLK)) then
			if (AXIS_ARESETN = '0') then
				pattern_data_valid                                                  <= '0';
				pattern_data(C_AXIS_TDATA_WIDTH - 31 downto 0)                      <= (others => '0');
				pattern_data(C_AXIS_TDATA_WIDTH - 1 downto C_AXIS_TDATA_WIDTH - 31) <= INITIAL_SEED_VALUE;
			else
				pattern_data_valid <= ENABLE_I;
				if (pattern_data_valid and M0_AXIS_TREADY) = '1' then
					pattern_data <= Y;
				end if;
			end if;
		end if;
	end process PATTERN_GENERATOR_proc;

	M0_AXIS_TVALID <= pattern_data_valid;
	M0_AXIS_TDATA  <= pattern_data;
	M0_AXIS_TLAST  <= pattern_data_valid and not (ENABLE_I);

end Behavioral;
