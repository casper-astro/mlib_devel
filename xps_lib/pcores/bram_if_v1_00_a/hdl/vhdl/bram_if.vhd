library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity bram_if is
    Generic (
    		  ADDR_SIZE : integer := 11);
	 Port ( 
		bram_rst  : out std_logic;
		bram_clk  : out std_logic;
		bram_en   : out std_logic;
		bram_wen  : out std_logic_vector(0 to 3); 
		bram_addr : out std_logic_vector(0 to 31);
		bram_din  : in  std_logic_vector(0 to 31);
		bram_dout : out std_logic_vector(0 to 31);

		clk_in    : in  std_logic;

		addr      : in  std_logic_vector((ADDR_SIZE-1) downto 0);
		data_in   : in  std_logic_vector(31 downto 0);
		data_out  : out std_logic_vector(31 downto 0);
		we        : in  std_logic
	 );
end bram_if;

architecture Behavioral of bram_if is

constant pad_zeros : std_logic_vector(29 - ADDR_SIZE downto 0) := (others => '0');

begin

	bram_rst  <= '0';
	bram_clk  <= clk_in;
	bram_en   <= '1';
	bram_wen  <= we&we&we&we;
	bram_addr <= pad_zeros & addr & "00";
	bram_dout <= data_in;
	data_out  <= bram_din;

end Behavioral;
