library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ten_gb_eth_bench is

end entity;

architecture ten_gb_eth_bench_arch of ten_gb_eth_bench is

constant CONNECTOR  : integer := 0;
constant UDP_MODE   : integer := 0;

component ten_gb_eth
	generic(
		USE_XILINX_MAC        : integer              := 1;
		USE_UCB_MAC           : integer              := 0;
		CONNECTOR             : integer              := 0;
		PREEMPHASYS           : string               := "3";
		SWING                 : string               := "800";
		C_BASEADDR            : std_logic_vector     := X"FFFFFFFF";
		C_HIGHADDR            : std_logic_vector     := X"00000000";
		C_PLB_AWIDTH          : integer              := 32;
		C_PLB_DWIDTH          : integer              := 64;
		C_PLB_NUM_MASTERS     : integer              := 8;
		C_PLB_MID_WIDTH       : integer              := 3;
		C_FAMILY              : string               := "virtex2p"
	);
	port (
		-- application clock
		clk                   : in  std_logic;
		-- application reset
		rst                   : in  std_logic;

		-- tx ports
		tx_valid              : in  std_logic;
		tx_ack                : out std_logic;
		tx_end_of_frame       : in  std_logic;
		tx_discard            : in  std_logic;
		tx_data               : in  std_logic_vector(63 downto 0);
		tx_dest_ip            : in  std_logic_vector(31 downto 0);
		tx_dest_port          : in  std_logic_vector(15 downto 0);
		
		-- rx port
		rx_valid              : out std_logic;
		rx_ack                : in  std_logic;
		rx_data               : out std_logic_vector(63 downto 0);
		rx_end_of_frame       : out std_logic;
		rx_size               : out std_logic_vector(15 downto 0);
		rx_source_ip          : out std_logic_vector(31 downto 0);
		rx_source_port        : out std_logic_vector(15 downto 0);

		-- communication clocks
		mgt_clk_top_10G       : in  std_logic;
		mgt_clk_bottom_10G    : in  std_logic;
		mgt_clk_top_8G        : in  std_logic;
		mgt_clk_bottom_8G     : in  std_logic;
		xgmii_clk_top         : in  std_logic;
		xgmii_clk_bottom      : in  std_logic;
		speed_select          : in  std_logic;

		-- status led
		led_up                : out std_logic;
		led_rx                : out std_logic;
		led_tx                : out std_logic;

		-- MGT ports
		mgt_tx_l0_p           : out std_logic;
		mgt_tx_l0_n           : out std_logic;
		mgt_tx_l1_p           : out std_logic;
		mgt_tx_l1_n           : out std_logic;
		mgt_tx_l2_p           : out std_logic;
		mgt_tx_l2_n           : out std_logic;
		mgt_tx_l3_p           : out std_logic;
		mgt_tx_l3_n           : out std_logic;
		mgt_rx_l0_p           : in  std_logic;
		mgt_rx_l0_n           : in  std_logic;
		mgt_rx_l1_p           : in  std_logic;
		mgt_rx_l1_n           : in  std_logic;
		mgt_rx_l2_p           : in  std_logic;
		mgt_rx_l2_n           : in  std_logic;
		mgt_rx_l3_p           : in  std_logic;
		mgt_rx_l3_n           : in  std_logic;

		-- PLB attachment
		PLB_Clk               : in  std_logic;
		PLB_Rst               : in  std_logic;
		Sl_addrAck            : out std_logic;
		Sl_MBusy              : out std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
		Sl_MErr               : out std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
		Sl_rdBTerm            : out std_logic;
		Sl_rdComp             : out std_logic;
		Sl_rdDAck             : out std_logic;
		Sl_rdDBus             : out std_logic_vector(0 to C_PLB_DWIDTH-1);
		Sl_rdWdAddr           : out std_logic_vector(0 to 3);
		Sl_rearbitrate        : out std_logic;
		Sl_SSize              : out std_logic_vector(0 to 1);
		Sl_wait               : out std_logic;
		Sl_wrBTerm            : out std_logic;
		Sl_wrComp             : out std_logic;
		Sl_wrDAck             : out std_logic;
		PLB_abort             : in  std_logic;
		PLB_ABus              : in  std_logic_vector(0 to C_PLB_AWIDTH-1);
		PLB_BE                : in  std_logic_vector(0 to C_PLB_DWIDTH/8-1);
		PLB_busLock           : in  std_logic;
		PLB_compress          : in  std_logic;
		PLB_guarded           : in  std_logic;
		PLB_lockErr           : in  std_logic;
		PLB_masterID          : in  std_logic_vector(0 to C_PLB_MID_WIDTH-1);
		PLB_MSize             : in  std_logic_vector(0 to 1);
		PLB_ordered           : in  std_logic;
		PLB_PAValid           : in  std_logic;
		PLB_pendPri           : in  std_logic_vector(0 to 1);
		PLB_pendReq           : in  std_logic;
		PLB_rdBurst           : in  std_logic;
		PLB_rdPrim            : in  std_logic;
		PLB_reqPri            : in  std_logic_vector(0 to 1);
		PLB_RNW               : in  std_logic;
		PLB_SAValid           : in  std_logic;
		PLB_size              : in  std_logic_vector(0 to 3);
		PLB_type              : in  std_logic_vector(0 to 2);
		PLB_wrBurst           : in  std_logic;
		PLB_wrDBus            : in  std_logic_vector(0 to C_PLB_DWIDTH-1);
		PLB_wrPrim            : in  std_logic
	);
end component;

-- constants
constant C_BASEADDR          : std_logic_vector     := X"FFFFFFFF";
constant C_HIGHADDR          : std_logic_vector     := X"00000000";
constant C_PLB_AWIDTH        : integer              := 32;
constant C_PLB_DWIDTH        : integer              := 64;
constant C_PLB_NUM_MASTERS   : integer              := 8;
constant C_PLB_MID_WIDTH     : integer              := 3;
constant C_FAMILY            : string               := "virtex2p";

-- user clock and reset
signal app_clk           : std_logic := '0';
signal app_rst           : std_logic := '1';

-- rx
signal rx_valid          : std_logic;
signal rx_ack            : std_logic := '0';
signal rx_data           : std_logic_vector(63 downto 0);
signal rx_end_of_frame   : std_logic;
signal rx_size           : std_logic_vector(15 downto 0);
signal rx_source_ip      : std_logic_vector(31 downto 0);
signal rx_source_port    : std_logic_vector(15 downto 0);

-- tx
signal tx_valid          : std_logic := '0';
signal tx_data           : std_logic_vector(63 downto 0) := (others => '0');
signal tx_end_of_frame   : std_logic := '0';
signal tx_discard        : std_logic := '0';
signal tx_ack            : std_logic;
signal tx_dest_ip        : std_logic_vector(31 downto 0) := X"FEEDBEE2";
signal tx_dest_port      : std_logic_vector(15 downto 0) := X"1234";

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

-- PLB attachment
signal PLB_Clk           : std_logic := '0';
signal PLB_Rst           : std_logic;
signal Sl_addrAck        : std_logic;
signal Sl_MBusy          : std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
signal Sl_MErr           : std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
signal Sl_rdBTerm        : std_logic;
signal Sl_rdComp         : std_logic;
signal Sl_rdDAck         : std_logic;
signal Sl_rdDBus         : std_logic_vector(0 to C_PLB_DWIDTH-1);
signal Sl_rdWdAddr       : std_logic_vector(0 to 3);
signal Sl_rearbitrate    : std_logic;
signal Sl_SSize          : std_logic_vector(0 to 1);
signal Sl_wait           : std_logic;
signal Sl_wrBTerm        : std_logic;
signal Sl_wrComp         : std_logic;
signal Sl_wrDAck         : std_logic;
signal PLB_abort         : std_logic;
signal PLB_ABus          : std_logic_vector(0 to C_PLB_AWIDTH-1);
signal PLB_BE            : std_logic_vector(0 to C_PLB_DWIDTH/8-1);
signal PLB_busLock       : std_logic;
signal PLB_compress      : std_logic;
signal PLB_guarded       : std_logic;
signal PLB_lockErr       : std_logic;
signal PLB_masterID      : std_logic_vector(0 to C_PLB_MID_WIDTH-1);
signal PLB_MSize         : std_logic_vector(0 to 1);
signal PLB_ordered       : std_logic;
signal PLB_PAValid       : std_logic;
signal PLB_pendPri       : std_logic_vector(0 to 1);
signal PLB_pendReq       : std_logic;
signal PLB_rdBurst       : std_logic;
signal PLB_rdPrim        : std_logic;
signal PLB_reqPri        : std_logic_vector(0 to 1);
signal PLB_RNW           : std_logic;
signal PLB_SAValid       : std_logic;
signal PLB_size          : std_logic_vector(0 to 3);
signal PLB_type          : std_logic_vector(0 to 2);
signal PLB_wrBurst       : std_logic;
signal PLB_wrDBus        : std_logic_vector(0 to C_PLB_DWIDTH-1);
signal PLB_wrPrim        : std_logic;

-- MGT clock
signal mgt_clk_8G        : std_logic := '0';
signal mgt_clk_10G       : std_logic := '0';

signal cycle_count       : std_logic_vector(31 downto 0) := (others => '0');

signal fault             : std_logic := '0';

signal start_transmit    : std_logic := '0';

begin


ten_gb_eth_0 : ten_gb_eth
	generic map(
		USE_XILINX_MAC        => 0,
		USE_UCB_MAC           => 1,
		CONNECTOR             => 0     ,
		PREEMPHASYS           => "3"   ,
		SWING                 => "800" ,
		C_BASEADDR            => C_BASEADDR       ,
		C_HIGHADDR            => C_HIGHADDR       ,
		C_PLB_AWIDTH          => C_PLB_AWIDTH     ,
		C_PLB_DWIDTH          => C_PLB_DWIDTH     ,
		C_PLB_NUM_MASTERS     => C_PLB_NUM_MASTERS,
		C_PLB_MID_WIDTH       => C_PLB_MID_WIDTH  ,
		C_FAMILY              => C_FAMILY         
	)
	port map(
		-- user clock and reset
		clk                   => app_clk    ,
		rst                   => app_rst    ,

		-- communication clocks
		mgt_clk_top_10G       => mgt_clk_10G,
		mgt_clk_bottom_10G    => mgt_clk_10G,
		mgt_clk_top_8G        => mgt_clk_8G,
		mgt_clk_bottom_8G     => mgt_clk_8G,
		xgmii_clk_top         => mgt_clk_10G,
		xgmii_clk_bottom      => mgt_clk_10G,
		speed_select          => '1',
		
		-- tx ports
		tx_valid              => tx_valid              ,
		tx_ack                => tx_ack                ,
		tx_end_of_frame       => tx_end_of_frame       ,
		tx_discard            => tx_discard            ,
		tx_data               => tx_data               ,
		tx_dest_ip            => tx_dest_ip            ,
		tx_dest_port          => tx_dest_port          ,
		
		-- rx port
		rx_valid              => rx_valid              ,
		rx_ack                => rx_ack                ,
		rx_data               => rx_data               ,
		rx_end_of_frame       => rx_end_of_frame       ,
		rx_size               => rx_size               ,
		rx_source_ip          => rx_source_ip          ,
		rx_source_port        => rx_source_port        ,

		-- status
		led_up                => open                  ,
		led_rx                => open                  ,
		led_tx                => open                  ,

		-- MGT ports
		mgt_tx_l0_p           => mgt_tx_l0_p           ,
		mgt_tx_l0_n           => mgt_tx_l0_n           ,
		mgt_tx_l1_p           => mgt_tx_l1_p           ,
		mgt_tx_l1_n           => mgt_tx_l1_n           ,
		mgt_tx_l2_p           => mgt_tx_l2_p           ,
		mgt_tx_l2_n           => mgt_tx_l2_n           ,
		mgt_tx_l3_p           => mgt_tx_l3_p           ,
		mgt_tx_l3_n           => mgt_tx_l3_n           ,
		mgt_rx_l0_p           => mgt_rx_l0_p           ,
		mgt_rx_l0_n           => mgt_rx_l0_n           ,
		mgt_rx_l1_p           => mgt_rx_l1_p           ,
		mgt_rx_l1_n           => mgt_rx_l1_n           ,
		mgt_rx_l2_p           => mgt_rx_l2_p           ,
		mgt_rx_l2_n           => mgt_rx_l2_n           ,
		mgt_rx_l3_p           => mgt_rx_l3_p           ,
		mgt_rx_l3_n           => mgt_rx_l3_n           ,

		-- PLB attachment
		PLB_Clk               => PLB_Clk               ,
		PLB_Rst               => PLB_Rst               ,
		Sl_addrAck            => Sl_addrAck            ,
		Sl_MBusy              => Sl_MBusy              ,
		Sl_MErr               => Sl_MErr               ,
		Sl_rdBTerm            => Sl_rdBTerm            ,
		Sl_rdComp             => Sl_rdComp             ,
		Sl_rdDAck             => Sl_rdDAck             ,
		Sl_rdDBus             => Sl_rdDBus             ,
		Sl_rdWdAddr           => Sl_rdWdAddr           ,
		Sl_rearbitrate        => Sl_rearbitrate        ,
		Sl_SSize              => Sl_SSize              ,
		Sl_wait               => Sl_wait               ,
		Sl_wrBTerm            => Sl_wrBTerm            ,
		Sl_wrComp             => Sl_wrComp             ,
		Sl_wrDAck             => Sl_wrDAck             ,
		PLB_abort             => PLB_abort             ,
		PLB_ABus              => PLB_ABus              ,
		PLB_BE                => PLB_BE                ,
		PLB_busLock           => PLB_busLock           ,
		PLB_compress          => PLB_compress          ,
		PLB_guarded           => PLB_guarded           ,
		PLB_lockErr           => PLB_lockErr           ,
		PLB_masterID          => PLB_masterID          ,
		PLB_MSize             => PLB_MSize             ,
		PLB_ordered           => PLB_ordered           ,
		PLB_PAValid           => PLB_PAValid           ,
		PLB_pendPri           => PLB_pendPri           ,
		PLB_pendReq           => PLB_pendReq           ,
		PLB_rdBurst           => PLB_rdBurst           ,
		PLB_rdPrim            => PLB_rdPrim            ,
		PLB_reqPri            => PLB_reqPri            ,
		PLB_RNW               => PLB_RNW               ,
		PLB_SAValid           => PLB_SAValid           ,
		PLB_size              => PLB_size              ,
		PLB_type              => PLB_type              ,
		PLB_wrBurst           => PLB_wrBurst           ,
		PLB_wrDBus            => PLB_wrDBus            ,
		PLB_wrPrim            => PLB_wrPrim        
	);


-- CLOCKS

plb_clock_proc: process
    begin    
        while true loop
            PLB_Clk <= not PLB_Clk;
            wait for 5000 ps;
        end loop;
        wait;
end process;

app_clock_proc: process
    begin    
        while true loop
            app_clk <= not app_clk;
            wait for 1000 ps;
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
		if start_transmit = '1' then
			tx_valid        <= '1';
			if tx_ack = '1' then
				tx_end_of_frame <= '0';
				tx_data <= tx_data + 1;
				if tx_data(2 downto 0) = "000" then
--					tx_dest_ip   <= tx_dest_ip   + 1;
--					tx_dest_port <= tx_dest_port + 1;
				end if;
				if tx_data(7 downto 0) = "00000001" then
					tx_end_of_frame <= '1';
				end if;
				if tx_data = X"000000000000003F" then
					tx_discard      <= '1';
				else
					tx_discard      <= '0';
				end if;				
			end if;
		end if;
	end if;
end process;

process
begin
	wait for 50 ns;
	app_rst <= '0';
end process;

process
begin
	wait for 1500 ns;
	start_transmit <= '1';
end process;


process
begin
	wait for 33 us;
	fault <= '1';
	wait for 1000 ps;
	fault <= '0';
end process;

--rx_ack <= '1' after 20001 ns;
rx_ack <= '1';

-- High speed loopback
mgt_rx_l0_p <= mgt_tx_l0_p xor fault;
mgt_rx_l0_n <= mgt_tx_l0_n;
mgt_rx_l1_p <= mgt_tx_l1_p;
mgt_rx_l1_n <= mgt_tx_l1_n;
mgt_rx_l2_p <= mgt_tx_l2_p;
mgt_rx_l2_n <= mgt_tx_l2_n;
mgt_rx_l3_p <= mgt_tx_l3_p;
mgt_rx_l3_n <= mgt_tx_l3_n;



end ten_gb_eth_bench_arch;
