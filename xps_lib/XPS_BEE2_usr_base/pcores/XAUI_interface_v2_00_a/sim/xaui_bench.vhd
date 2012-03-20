library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity xaui_bench is

end entity;

architecture xaui_bench_arch of xaui_bench is

constant DEMUX      : integer := 1;
constant LINK_SPEED : integer := 0;
constant CONNECTOR  : integer := 0;

component XAUI_interface
	generic(
		DEMUX             : integer           := 1;
		LINK_SPEED        : integer           := 1;
		CONNECTOR         : integer           := 0
	);
	port (
		-- application clock
		clk               : in  std_logic;

		-- communication clocks
		mgt_clk_top_10G       : in std_logic;
		xaui_clk_top_10G      : in std_logic;
		mgt_clk_bottom_10G    : in std_logic;
		xaui_clk_bottom_10G   : in std_logic;
		mgt_clk_top_8G        : in std_logic;
		xaui_clk_top_8G       : in std_logic;
		mgt_clk_bottom_8G     : in std_logic;
		xaui_clk_bottom_8G    : in std_logic;

		-- rx
		rx_data           : out std_logic_vector((64/DEMUX - 1) downto 0);
		rx_outofband      : out std_logic_vector(( 8/DEMUX - 1) downto 0);
		rx_ack            : in  std_logic;
		rx_empty          : out std_logic;
		rx_valid          : out std_logic;
		rx_full_slots     : out std_logic_vector(15 downto 0);

		-- tx
		tx_data           : in  std_logic_vector((64/DEMUX - 1) downto 0);
		tx_outofband      : in  std_logic_vector(( 8/DEMUX - 1) downto 0);
		tx_valid          : in  std_logic;
		tx_full           : out std_logic;
		tx_ack            : out std_logic;
		tx_empty_slots    : out std_logic_vector(15 downto 0);

		-- status
		linkdown          : out std_logic;
		data_lost         : out std_logic;

		-- MGT ports
		mgt_tx_l0_p       : out std_logic;
		mgt_tx_l0_n       : out std_logic;
		mgt_tx_l1_p       : out std_logic;
		mgt_tx_l1_n       : out std_logic;
		mgt_tx_l2_p       : out std_logic;
		mgt_tx_l2_n       : out std_logic;
		mgt_tx_l3_p       : out std_logic;
		mgt_tx_l3_n       : out std_logic;
		mgt_rx_l0_p       : in  std_logic;
		mgt_rx_l0_n       : in  std_logic;
		mgt_rx_l1_p       : in  std_logic;
		mgt_rx_l1_n       : in  std_logic;
		mgt_rx_l2_p       : in  std_logic;
		mgt_rx_l2_n       : in  std_logic;
		mgt_rx_l3_p       : in  std_logic;
		mgt_rx_l3_n       : in  std_logic		
	);
end component;

-- user clock
signal app_clk           : std_logic := '0';

-- rx
signal rx_data           : std_logic_vector((64/DEMUX - 1) downto 0) := (others => '0');
signal rx_outofband      : std_logic_vector(( 8/DEMUX - 1) downto 0) := (others => '0');
signal rx_ack            : std_logic                                 := '0';
signal rx_valid          : std_logic                                 := '1';
signal rx_full_slots     : std_logic_vector(15 downto 0)             := (others => '0');

-- tx
signal tx_data           : std_logic_vector((64/DEMUX - 1) downto 0) := (others => '0');
signal tx_outofband      : std_logic_vector(( 8/DEMUX - 1) downto 0) := (others => '0');
signal tx_valid          : std_logic                                 := '0';
signal tx_ack            : std_logic;
signal tx_empty_slots    : std_logic_vector(15 downto 0)             := (others => '0');

-- test
signal test_diff         : std_logic_vector((64/DEMUX - 1) downto 0) := (others => '0');
signal test_last         : std_logic_vector((64/DEMUX - 1) downto 0) := (others => '0');

-- status
signal linkdown          : std_logic;
signal data_lost         : std_logic;

-- MGT ports
signal mgt_tx_l0_p       : std_logic;
signal mgt_tx_l0_n       : std_logic;
signal mgt_tx_l1_p       : std_logic;
signal mgt_tx_l1_n       : std_logic;
signal mgt_tx_l2_p       : std_logic;
signal mgt_tx_l2_n       : std_logic;
signal mgt_tx_l3_p       : std_logic;
signal mgt_tx_l3_n       : std_logic;
signal mgt_rx_l0_p       : std_logic;
signal mgt_rx_l0_n       : std_logic;
signal mgt_rx_l1_p       : std_logic;
signal mgt_rx_l1_n       : std_logic;
signal mgt_rx_l2_p       : std_logic;
signal mgt_rx_l2_n       : std_logic;
signal mgt_rx_l3_p       : std_logic;
signal mgt_rx_l3_n       : std_logic;

-- MGT clock
signal mgt_clk_8G        : std_logic := '0';
signal mgt_clk_10G       : std_logic := '0';

signal cycle_count       : std_logic_vector(31 downto 0) := (others => '0');

signal fault             : std_logic := '0';

begin

xaui_if_0 : XAUI_interface
	generic map(
		DEMUX             => DEMUX,
		LINK_SPEED        => LINK_SPEED,
		CONNECTOR         => CONNECTOR 
	)
	port map(
		-- user clock
		clk           => app_clk      ,

		-- communication clocks
		mgt_clk_top_10G     => mgt_clk_10G,
		xaui_clk_top_10G    => mgt_clk_10G,
		mgt_clk_bottom_10G  => mgt_clk_10G,
		xaui_clk_bottom_10G => mgt_clk_10G,
		mgt_clk_top_8G      => mgt_clk_8G,
		xaui_clk_top_8G     => mgt_clk_8G,
		mgt_clk_bottom_8G   => mgt_clk_8G,
		xaui_clk_bottom_8G  => mgt_clk_8G,

		-- rx
		rx_data           => rx_data        ,
		rx_outofband      => rx_outofband   ,
		rx_ack            => rx_ack         ,
		rx_empty          => open           ,
		rx_valid          => rx_valid       ,
		rx_full_slots     => rx_full_slots  ,

		-- tx
		tx_data           => tx_data        ,
		tx_outofband      => tx_outofband   ,
		tx_valid          => tx_valid       ,
		tx_full           => open           ,
		tx_ack            => tx_ack         ,
		tx_empty_slots    => tx_empty_slots ,

		-- status
		linkdown          => linkdown       ,
		data_lost         => data_lost      ,

		-- MGT ports
		mgt_tx_l0_p       => mgt_tx_l0_p    ,
		mgt_tx_l0_n       => mgt_tx_l0_n    ,
		mgt_tx_l1_p       => mgt_tx_l1_p    ,
		mgt_tx_l1_n       => mgt_tx_l1_n    ,
		mgt_tx_l2_p       => mgt_tx_l2_p    ,
		mgt_tx_l2_n       => mgt_tx_l2_n    ,
		mgt_tx_l3_p       => mgt_tx_l3_p    ,
		mgt_tx_l3_n       => mgt_tx_l3_n    ,
		mgt_rx_l0_p       => mgt_rx_l0_p    ,
		mgt_rx_l0_n       => mgt_rx_l0_n    ,
		mgt_rx_l1_p       => mgt_rx_l1_p    ,
		mgt_rx_l1_n       => mgt_rx_l1_n    ,
		mgt_rx_l2_p       => mgt_rx_l2_p    ,
		mgt_rx_l2_n       => mgt_rx_l2_n    ,
		mgt_rx_l3_p       => mgt_rx_l3_p    ,
		mgt_rx_l3_n       => mgt_rx_l3_n
	);


-- CLOCKS

app_clock_proc: process
    begin    
        while true loop
            app_clk <= not app_clk;
            wait for 5000 ps;
			cycle_count <= cycle_count + 1;
        end loop;
        wait;
end process;

mgt_clock_10G_proc: process
    begin    
        while true loop
            mgt_clk_10G <= not mgt_clk_10G;
            wait for 3200 ps;
        end loop;
        wait;
end process;

mgt_clock_8G_proc: process
    begin    
        while true loop
            mgt_clk_8G <= not mgt_clk_8G;
            wait for 4000 ps;
        end loop;
        wait;
end process;

-- DATA input

process(app_clk)
begin
	if app_clk'event and app_clk = '1' then
		tx_valid <= '1';
		if tx_ack = '1' then
			tx_data <= tx_data + 1;
		end if;
		if tx_data(31 downto 0) = X"00000100" then
			tx_outofband <= (0 => '1', others => '0');
		end if;
		if tx_data(31 downto 0) = X"00000101" then
			tx_outofband <= (others => '0');
		end if;
		
		if rx_valid = '1' and rx_ack = '1' then
			test_last <= rx_data;
			test_diff <= rx_data - test_last;
		end if;
	end if;
end process;

process
begin
	wait for 1 us;
--	fault <= '1';
	wait for 1000 ps;
	fault <= '0';
end process;

rx_ack <= '1' after 17 us;

-- High speed loopback
mgt_rx_l0_p <= mgt_tx_l0_p xor fault;
mgt_rx_l0_n <= mgt_tx_l0_n;
mgt_rx_l1_p <= mgt_tx_l1_p;
mgt_rx_l1_n <= mgt_tx_l1_n;
mgt_rx_l2_p <= mgt_tx_l2_p;
mgt_rx_l2_n <= mgt_tx_l2_n;
mgt_rx_l3_p <= mgt_tx_l3_p;
mgt_rx_l3_n <= mgt_tx_l3_n;



end xaui_bench_arch;
