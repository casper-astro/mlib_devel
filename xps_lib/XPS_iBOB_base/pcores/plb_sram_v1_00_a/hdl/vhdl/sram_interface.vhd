
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


library unisim;
use unisim.vcomponents.all;

entity sram_interface is
port (
	clk           : in  std_logic;
	we            : in  std_logic;
	be            : in  std_logic_vector(3  downto 0);
	address       : in  std_logic_vector(18 downto 0);
	data_in       : in  std_logic_vector(35 downto 0);
	data_out      : out std_logic_vector(35 downto 0);
	data_valid    : out std_logic;

	pads_address  : out std_logic_vector(18 downto 0);
	pads_bw_b     : out std_logic_vector(3  downto 0);
	pads_we_b     : out std_logic;
	pads_adv_ld_b : out std_logic;
	pads_clk      : out std_logic;
	pads_ce       : out std_logic;
	pads_oe_b     : out std_logic;
	pads_cen_b    : out std_logic;
	pads_dq_T     : out std_logic_vector(35 downto 0);
	pads_dq_I     : in  std_logic_vector(35 downto 0);
	pads_dq_O     : out std_logic_vector(35 downto 0);
	pads_mode     : out std_logic;
	pads_zz       : out std_logic
);
end entity;

architecture sram_interface_arch of sram_interface is

-- components
component FDDRRSE
	port (
		Q  : out std_logic;
		C0 : in  std_logic;
		C1 : in  std_logic;
		CE : in  std_logic;
		D0 : in  std_logic;
		D1 : in  std_logic;
		R  : in  std_logic;
		S  : in  std_logic
	);
end component;

	signal clk_n      : std_logic := '0';
	signal one        : std_logic := '1';
	signal zero       : std_logic := '0';
	signal we0        : std_logic := '0';
	signal we1        : std_logic := '0';
	signal we2        : std_logic := '0';

	signal data_in_R  : std_logic_vector(35 downto 0) := (others => '0');
	signal data_in_RR : std_logic_vector(35 downto 0) := (others => '0');

-- constraints
attribute equivalent_register_removal : string;
attribute equivalent_register_removal of pads_dq_T : signal is "false";


begin
	-- constants
	one  <= '1';
	zero <= '0';

	-- constant outputs
	pads_adv_ld_b <= '0';
	pads_ce       <= '1';
	pads_oe_b     <= '0';
	pads_cen_b    <= '0';
	pads_mode     <= '0';
	pads_zz       <= '0';

	-- clock output
	clk_n <= not clk;

	DDR_OUT : FDDRRSE port map (
		Q  => pads_clk   ,
		C0 => clk        ,
		C1 => clk_n      ,
		CE => one        ,
		D0 => zero       ,
		D1 => one        ,
		R  => zero       ,
		S  => zero       
	);

	-- output/inputs registering
	OUT_REGISTER_PROC : process(clk)
	begin
		if clk'event and clk = '1' then
			-- delay data by two cycles
			data_in_R    <= data_in;
			data_in_RR   <= data_in_R;
			-- address
			pads_address <= address;
			-- byte enables
			pads_bw_b    <= not be;
			-- write enable
			pads_we_b    <= not we;
			-- data out
			data_out     <= pads_dq_I;
			-- data in
			pads_dq_O    <= data_in_RR;
			-- tristate control
			we0          <= we;
			we1          <= we0;
			we2          <= we1;
			for bit_index in 0 to 35 loop
				pads_dq_T(bit_index)  <= not we1;
			end loop;
			data_valid   <= not we2;
		end if;
	end process;

end architecture;



