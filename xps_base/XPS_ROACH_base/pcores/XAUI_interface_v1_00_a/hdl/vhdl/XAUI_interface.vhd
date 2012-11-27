
-- ### ###   ##    ### ###  #####             #       ##  
--  #   #     #     #   #     #                      #    
--   # #      #     #   #     #                      #    
--   # #     # #    #   #     #             ###     ####  
--    #      # #    #   #     #               #      #    
--   # #    #   #   #   #     #               #      #    
--   # #    #####   #   #     #               #      #    
--  #   #   #   #   #   #     #               #      #    
-- ### ### ### ###   ###    #####           #####   ####  

-- XAUI interface top level

-- created by Pierre-Yves Droz 2005

------------------------------------------------------------------------------
-- XAUI_interface.vhd
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

--library unisim;
--use unisim.all;

entity XAUI_interface is
	generic(
		C_BASEADDR        : std_logic_vector	:= X"00000000";
		C_HIGHADDR        : std_logic_vector	:= X"0000FFFF";
		C_OPB_AWIDTH      : integer	:= 32;
		C_OPB_DWIDTH      : integer	:= 32;
		DEMUX             : integer           := 1
	);
	port (
		-- application clock
		app_clk           : in  std_logic;

		-- rx
		rx_data           : out std_logic_vector((64/DEMUX - 1) downto 0);
		rx_outofband      : out std_logic_vector(( 8/DEMUX - 1) downto 0);
		rx_get            : in  std_logic;
		rx_almost_full    : out std_logic;
		rx_valid          : out std_logic;
		rx_empty          : out std_logic;
		rx_reset          : in  std_logic;
		rx_linkdown       : out std_logic;

		-- tx
		tx_data           : in  std_logic_vector((64/DEMUX - 1) downto 0);
		tx_outofband      : in  std_logic_vector(( 8/DEMUX - 1) downto 0);
		tx_valid          : in  std_logic;
		tx_full           : out std_logic;

    -- XAUI signals     
    xaui_clk              : in  std_logic;
    xaui_reset            : out std_logic;
    xaui_status           : in  std_logic_vector( 7 downto 0);
    xgmii_txd             : out std_logic_vector(63 downto 0);
    xgmii_txc             : out std_logic_vector( 7 downto 0);
    xgmii_rxd             : in  std_logic_vector(63 downto 0);
    xgmii_rxc             : in  std_logic_vector( 7 downto 0);

    -- mgt config signals     
    mgt_rxeqmix           : out std_logic_vector( 1 downto 0);
    mgt_rxeqpole          : out std_logic_vector( 3 downto 0);
    mgt_txpreemphasis     : out std_logic_vector( 2 downto 0);
    mgt_txdiffctrl        : out std_logic_vector( 2 downto 0);

		-- OPB attachment
		OPB_Clk	              : in	std_logic;
		OPB_Rst	              : in	std_logic;
		Sl_DBus	              : out	std_logic_vector(0 to C_OPB_DWIDTH-1);
		Sl_errAck	            : out	std_logic;
		Sl_retry	            : out	std_logic;
		Sl_toutSup	          : out	std_logic;
		Sl_xferAck	          : out	std_logic;
		OPB_ABus	            : in	std_logic_vector(0 to C_OPB_AWIDTH-1);
		OPB_BE	              : in	std_logic_vector(0 to C_OPB_DWIDTH/8-1);
		OPB_DBus	            : in	std_logic_vector(0 to C_OPB_DWIDTH-1);
		OPB_RNW	              : in	std_logic;
		OPB_select            : in	std_logic;
		OPB_seqAddr           : in	std_logic
	);
end entity XAUI_interface;

architecture XAUI_interface_arch of XAUI_interface is

--                                   #    
--                                   #    
--  #####   #####  ## ##    #####   ####  
-- #     # #     #  ##  #  #     #   #    
-- #       #     #  #   #   ###      #    
-- #       #     #  #   #      ##    #    
-- #     # #     #  #   #  #     #   #  # 
--  #####   #####  ### ###  #####     ##  

	type monitor_state_type is (
		NORMAL_OPERATION,
		IN_RESET,
		WAIT_SYNC,
		WAIT_PACKET
	);


	type tx_state_type is (
		SEND_IDLE,
		SEND_UPACKET,
		SEND_DATA
	);

	type rx_state_type is (
		RECEIVE_IDLE,
		RECEIVE_DATA
	);

	constant DATA  : std_logic                    := '0';
	constant CTRL  : std_logic                    := '1';
	constant IDLE  : std_logic_vector(7 downto 0) := X"07";
	constant START : std_logic_vector(7 downto 0) := X"FB";
	constant TERM  : std_logic_vector(7 downto 0) := X"FD";
	constant ERROR : std_logic_vector(7 downto 0) := X"FE";

--	constant PACKET_SIZE   : integer                       := 8;
--	constant PACKET_START0 : std_logic_vector(7 downto 0)  := "00000000";
--	constant PACKET_START1 : std_logic_vector(7 downto 0)  := "00000001";
--	constant PACKET_END0   : std_logic_vector(7 downto 0)  := "11111110";
--	constant PACKET_END1   : std_logic_vector(7 downto 0)  := "11111111";

	constant PACKET_SIZE   : integer                       := 12;
	constant PACKET_START0 : std_logic_vector(11 downto 0) := "000000000000";
	constant PACKET_START1 : std_logic_vector(11 downto 0) := "000000000001";
	constant PACKET_END0   : std_logic_vector(11 downto 0) := "111111111110";
	constant PACKET_END1   : std_logic_vector(11 downto 0) := "111111111111";

--  ####    ####   #    #  #####    ####   #    #  ######  #    #   #####   ####
-- #    #  #    #  ##  ##  #    #  #    #  ##   #  #       ##   #     #    #
-- #       #    #  # ## #  #    #  #    #  # #  #  #####   # #  #     #     ####
-- #       #    #  #    #  #####   #    #  #  # #  #       #  # #     #         #
-- #    #  #    #  #    #  #       #    #  #   ##  #       #   ##     #    #    #
--  ####    ####   #    #  #        ####   #    #  ######  #    #     #     ####

  -- OPB Attachment
	-- 
	component opb_attach
		generic(
	    C_BASEADDR             : std_logic_vector	:= X"00000000";
	    C_HIGHADDR             : std_logic_vector	:= X"0000FFFF";
	    C_OPB_AWIDTH           : integer	:= 32;
	    C_OPB_DWIDTH           : integer	:= 32
		);
		port (
	    -- OPB attachment
	    OPB_Clk	              : in	std_logic;
	    OPB_Rst	              : in	std_logic;
	    Sl_DBus	              : out	std_logic_vector(0 to C_OPB_DWIDTH-1);
	    Sl_errAck	            : out	std_logic;
	    Sl_retry	            : out	std_logic;
	    Sl_toutSup	          : out	std_logic;
	    Sl_xferAck	          : out	std_logic;
	    OPB_ABus	            : in	std_logic_vector(0 to C_OPB_AWIDTH-1);
	    OPB_BE	              : in	std_logic_vector(0 to C_OPB_DWIDTH/8-1);
	    OPB_DBus	            : in	std_logic_vector(0 to C_OPB_DWIDTH-1);
	    OPB_RNW	              : in	std_logic;
	    OPB_select            : in	std_logic;
	    OPB_seqAddr           : in	std_logic;
    -- mgt config signals     
      rxeqmix               : out std_logic_vector( 1 downto 0);
      rxeqpole              : out std_logic_vector( 3 downto 0);
      txpreemphasis         : out std_logic_vector( 2 downto 0);
      txdiffctrl            : out std_logic_vector( 2 downto 0);
      xaui_status           : in  std_logic_vector( 7 downto 0)
		);
	end component;

--            #                              ##           
--                                            #           
--                                            #           
--  #####   ###     ###### ## ##    ####      #     ##### 
-- #     #    #    #    #   ##  #       #     #    #     #
--  ###       #    #    #   #   #   #####     #     ###   
--     ##     #    #    #   #   #  #    #     #        ## 
-- #     #    #     #####   #   #  #    #     #    #     #
--  #####   #####       #  ### ###  #### #  #####   ##### 
--                      #                                 
--                  ####                                  

  --intermediate xgmii_tx signals
  signal xgmii_txd_int                   : std_logic_vector(63 downto 0);
  signal xgmii_txc_int                   : std_logic_vector( 7 downto 0);

	-- one and zero
	signal one                             : std_logic := '1';
	signal zero                            : std_logic := '0';

	-- monitor signals
	signal monitor_state                   : monitor_state_type := IN_RESET;
	signal rx_up                           : std_logic;
	signal xaui_reset_cnt                  : std_logic_vector(3 downto 0) := X"0";
	signal xaui_reset_int                  : std_logic := '1';
	signal xaui_reset_reg                  : std_logic := '1';
	signal rx_linkdown_int                 : std_logic := '1';

	-- application signals
	signal rx_out                          : std_logic_vector((72/DEMUX - 1) downto 0) := (others => '0');
	signal tx_in                           : std_logic_vector((72/DEMUX - 1) downto 0) := (others => '0');

	-- tx controller signals
	signal tx_state                        : tx_state_type := SEND_IDLE;
	signal packet_counter                  : std_logic_vector((PACKET_SIZE-1) downto 0) := (others => '0');
	signal xaui_tx_outofband_last          : std_logic_vector(7 downto 0)  := (others => '0');
	signal xaui_tx_fifo_ack                : std_logic := '0';
	signal xaui_tx_fifo_packet_ack         : std_logic := '0';
	signal xaui_tx_fifo_state_ack          : std_logic := '0';
	signal xaui_tx_fifo_outofband_ack      : std_logic := '0';
	signal xaui_tx_fifo_out                : std_logic_vector(71 downto 0) := (others => '0');
	signal xaui_tx_fifo_data               : std_logic_vector(63 downto 0) := (others => '0');
	signal xaui_tx_fifo_outofband          : std_logic_vector(7 downto 0)  := (others => '0');
	signal xaui_tx_fifo_valid              : std_logic := '0';

	-- rx controller signals
	signal rx_state                        : rx_state_type := RECEIVE_IDLE;
	signal rx_data_is_aligned              : std_logic := '0';
	signal xaui_rx_data_R                  : std_logic_vector(63 downto 0) := (others => '0');
	signal xaui_rx_ctrl_R                  : std_logic_vector(7 downto 0) := (others => '0');
	signal xaui_rx_fifo_valid              : std_logic := '0';
	signal xaui_rx_fifo_full               : std_logic := '0';
	signal xaui_rx_fifo_in                 : std_logic_vector(71 downto 0) := (others => '0');
	signal xaui_rx_fifo_data               : std_logic_vector(63 downto 0) := (others => '0');
	signal xaui_rx_fifo_outofband          : std_logic_vector( 7 downto 0) := (others => '0');
	signal xaui_rx_fifo_reset              : std_logic := '0';

begin

-- MAIN PROCESS

xaui_fsm: process(xaui_clk)
begin
	if xaui_clk'event and xaui_clk = '1' then

--                            #                           
--                                   #                    
--                                   #                    
-- ### #    #####  ## ##    ###     ####    #####  ### ## 
--  # # #  #     #  ##  #     #      #     #     #   ##  #
--  # # #  #     #  #   #     #      #     #     #   #    
--  # # #  #     #  #   #     #      #     #     #   #    
--  # # #  #     #  #   #     #      #  #  #     #   #    
-- ## # ##  #####  ### ###  #####     ##    #####  #####  

-- link status monitoring

		rx_up <= '1';
		-- check if the xaui core is reporting a problem with the link
		if xaui_status(6 downto 2) /= "11111" then
			-- All lanes synchronized ---------1111
			-- All lanes aligned      --------1
			rx_up <= '0';
		end if;

		-- monitor state machine
		case monitor_state is
			-- resetting the core
			when IN_RESET =>
				-- keeps the reset high for a while and then goes out of reset
				if xaui_reset_cnt = X"F" then
					xaui_reset_int <= '0';
					monitor_state <= WAIT_SYNC;
				else
					xaui_reset_cnt <= xaui_reset_cnt + 1;
				end if;
				-- signal that the link is down
				rx_linkdown_int <= '1';
			-- wainting for RX to be up
			when WAIT_SYNC =>
				-- if the receive syncs then start sending micropackets
				if rx_up = '1' then
					monitor_state <= WAIT_PACKET;
				end if;
				-- signal that the link is down
				rx_linkdown_int <= '1';
			-- waiting first packet from transmitter
			when WAIT_PACKET =>
				-- if we receive a packet, then we can start transmitting (means that the other receive is up and running)
				if rx_state = RECEIVE_DATA then
					monitor_state <= NORMAL_OPERATION;
				end if;
				-- signal that the link is down
				rx_linkdown_int <= '1';
			when NORMAL_OPERATION =>
				-- signal that the link is up
				rx_linkdown_int <= '0';
				-- in case of a rx fault, bring the core to reset
				if rx_up = '0' then
					xaui_reset_cnt <= X"0";
					xaui_reset_int <= '1';
					monitor_state  <= IN_RESET;
					-- signal that the link is down
					rx_linkdown_int <= '1';
				end if;
		end case;

--                                                   ##   
--                                   #                #   
--                                   #                #   
-- ### ##  ### ###          #####   ####   ### ##     #   
--   ##  #  #   #          #     #   #       ##  #    #   
--   #       ###           #         #       #        #   
--   #       ###           #         #       #        #   
--   #      #   #          #     #   #  #    #        #   
-- #####   ### ###          #####     ##   #####    ##### 

-- receIVe controller
		if xaui_reset_int = '1' then
			rx_state                        <= RECEIVE_IDLE;
			rx_data_is_aligned              <= '0';
			xaui_rx_fifo_outofband          <= (others => '0');
		else
			-- defaults the fifo write enable to 0
			xaui_rx_fifo_valid <= '0';
			-- delay signals for pipelining
			xaui_rx_data_R <= xgmii_rxd;
			xaui_rx_ctrl_R <= xgmii_rxc;
			-- receive state machine
			case rx_state is
				when RECEIVE_IDLE =>
					-- check if we get an aligned packet start
					if xaui_rx_data_R(7 downto 0)   = START and xaui_rx_ctrl_R(0) = '1' then
						rx_data_is_aligned <= '1';
						rx_state           <= RECEIVE_DATA;
					end if;
					-- check if we get a non-aligned packet start
					if xaui_rx_data_R(39 downto 32) = START and xaui_rx_ctrl_R(4) = '1' then
						rx_data_is_aligned <= '0';
						rx_state           <= RECEIVE_DATA;
					end if;
				when RECEIVE_DATA =>
					-- output correct data depending on the alignement
					if rx_data_is_aligned = '1' then
						-- check if we are receiving the end of a packet, in that case we go back to idle state
						if xaui_rx_data_R(7 downto 0)   = TERM and xaui_rx_ctrl_R(1 downto 0) = "11" then
							rx_state           <= RECEIVE_IDLE;
						else
							-- if we receive an outofband signal, update the oob value 
							if xaui_rx_ctrl_R(1 downto 0) = "10" then
								xaui_rx_fifo_outofband <= xaui_rx_data_R(7 downto 0);
							else
								xaui_rx_fifo_data      <= xaui_rx_data_R;
								xaui_rx_fifo_valid     <= '1';
							end if;
						end if;
					else
						-- check if we are receving the end of a packet, in that case we go back to idle state
						if xaui_rx_data_R(39 downto 32) = TERM and xaui_rx_ctrl_R(5 downto 4) = "11" then
							rx_state           <= RECEIVE_IDLE;
						else
							-- if we receive an outofband signal, update the oob value 
							if xaui_rx_ctrl_R(5 downto 4) = "10" then
								xaui_rx_fifo_outofband <= xaui_rx_data_R(39 downto 32);
							else
								xaui_rx_fifo_data  <= xgmii_rxd(31 downto 0) & xaui_rx_data_R(63 downto 32);
								xaui_rx_fifo_valid <= '1';
							end if;
						end if;
					end if;
			end case;
		end if;


--                                                   ##   
--   #                               #                #   
--   #                               #                #   
--  ####   ### ###          #####   ####   ### ##     #   
--   #      #   #          #     #   #       ##  #    #   
--   #       ###           #         #       #        #   
--   #       ###           #         #       #        #   
--   #  #   #   #          #     #   #  #    #        #   
--    ##   ### ###          #####     ##   #####    ##### 

-- transmit controller
		if xaui_reset_int = '1' then
			tx_state                     <= SEND_IDLE;
			packet_counter               <= PACKET_START0;
			xaui_tx_outofband_last       <= (others => '0');
			xgmii_txd_int                    <= IDLE  & IDLE  & IDLE  & IDLE  & IDLE  & IDLE  & IDLE  & IDLE ; 
			xgmii_txc_int                    <= CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL ;
		else
			-- tx fsm
			case tx_state is
				when SEND_IDLE =>
					-- send idle until the monitor asks for sending micropackets
					xgmii_txd_int                    <= IDLE  & IDLE  & IDLE  & IDLE  & IDLE  & IDLE  & IDLE  & IDLE ; 
					xgmii_txc_int                    <= CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL ;
					if monitor_state = WAIT_PACKET then
						tx_state <= SEND_UPACKET;
					end if;
				when SEND_UPACKET =>
					-- counter to send the packet limits
					packet_counter <= packet_counter + 1;
					-- packet shaping
					case packet_counter is
						when PACKET_START0 =>
							-- start of a packet
							xgmii_txd_int <= ERROR & ERROR & ERROR & ERROR & ERROR & ERROR & ERROR & START;
							xgmii_txc_int <= CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL ;
						when PACKET_START1 =>
							-- end of a packet
							xgmii_txd_int <= IDLE  & IDLE  & IDLE  & IDLE  & IDLE  & IDLE  & IDLE  & TERM ;
							xgmii_txc_int <= CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL ;
						when others =>
							-- idle between packets
							xgmii_txd_int <= IDLE  & IDLE  & IDLE  & IDLE  & IDLE  & IDLE  & IDLE  & IDLE;
							xgmii_txc_int <= CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL ;
							-- if the monitor asks for it, starts transmitting
							if monitor_state = NORMAL_OPERATION then
								packet_counter       <= PACKET_START0;
								tx_state             <= SEND_DATA;
							end if;
					end case;
				when SEND_DATA =>
					-- packet index counter
					packet_counter <= packet_counter + 1;
					-- packet shaping
					case packet_counter is
						when PACKET_START0 =>
							-- start of a packet
							xgmii_txd_int <= ERROR & ERROR & ERROR & ERROR & ERROR & ERROR & ERROR & START;
							xgmii_txc_int <= CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL ;
						when PACKET_END0 =>
							-- at the end of a packet
							xgmii_txd_int <= IDLE  & IDLE  & IDLE  & IDLE  & IDLE  & IDLE  & IDLE  & TERM ;
							xgmii_txc_int <= CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL ;
						when PACKET_END1 =>
							-- idle between packets
							xgmii_txd_int <= IDLE  & IDLE  & IDLE  & IDLE  & IDLE  & IDLE  & IDLE  & IDLE;
							xgmii_txc_int <= CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL ;
						when others =>
							-- send data or outofband
							if (xaui_tx_fifo_outofband = xaui_tx_outofband_last) and xaui_tx_fifo_valid = '1' then
								xgmii_txd_int <= xaui_tx_fifo_data;
								xgmii_txc_int <= DATA & DATA & DATA & DATA & DATA & DATA & DATA & DATA; 
							else
								xaui_tx_outofband_last <= xaui_tx_fifo_outofband;
								xgmii_txd_int <= ERROR & ERROR & ERROR & ERROR & ERROR & ERROR & ERROR & xaui_tx_fifo_outofband;
								xgmii_txc_int <= CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & DATA ;
							end if;
							-- detect the presence of a change in the outofband signals
					end case;
			end case;
		end if;
	end if;
end process xaui_fsm;

-- control the stat fifo ack signal
with tx_state select xaui_tx_fifo_state_ack <=
	'1' when SEND_DATA,
	'0' when others;

-- control the packet fifo ack signal
with packet_counter select xaui_tx_fifo_packet_ack <=
	'0' when PACKET_START0,
	'0' when PACKET_END0,
	'0' when PACKET_END1,
	'1' when others;

-- control the outofband ack signal
xaui_tx_fifo_outofband_ack <= '0' when (xaui_tx_fifo_outofband /= xaui_tx_outofband_last) and (xaui_tx_fifo_valid = '1') else '1';

--           XX    XX                  XX                             X
--            X     X                   X
--            X     X                   X
--  XXXXX     X     X  XX           XXXXX   XXXXX  XXX X    XXXX    XXX    XX XX
-- X     X    X     X  X           X    X  X     X  X X X       X     X     XX  X
-- X          X     X X            X    X  X     X  X X X   XXXXX     X     X   X
-- X          X     XXX            X    X  X     X  X X X  X    X     X     X   X
-- X     X    X     X  X           X    X  X     X  X X X  X    X     X     X   X
--  XXXXX   XXXXX  XX   XX          XXXXXX  XXXXX  XX X XX  XXXX X  XXXXX  XXX XXX

clk_boundary: process(app_clk)
begin
	if app_clk'event and app_clk = '1' then
		-- recapture the link_down signal on the application clock
		rx_linkdown <= rx_linkdown_int;

		-- puts the fifo async reset on application clock to prevent application signals to
		-- transition on the xaui clock
		xaui_reset_reg <= xaui_reset_int;
	end if;
end process clk_boundary;
xaui_reset <= xaui_reset_reg;


--                            ##      #       ##          
--   #                       #               #            
--   #                       #               #            
--  ####   ### ###          ####    ###     ####    ##### 
--   #      #   #            #        #      #     #     #
--   #       ###             #        #      #     #     #
--   #       ###             #        #      #     #     #
--   #  #   #   #            #        #      #     #     #
--    ##   ### ###          ####    #####   ####    ##### 

-- transmit FIFO instantiation

-- DEMUX = 1

TX_FIFO_GEN_DEMUX1: if DEMUX = 1 generate
	component tx_fifo
		port (
			din    : IN  std_logic_VECTOR(71 downto 0);
			rd_clk : IN  std_logic;
			rd_en  : IN  std_logic;
			rst    : IN  std_logic;
			wr_clk : IN  std_logic;
			wr_en  : IN  std_logic;
			dout   : OUT std_logic_VECTOR(71 downto 0);
			empty  : OUT std_logic;
			full   : OUT std_logic;
			valid  : OUT std_logic);
	end component;
begin
	xaui_tx_fifo : tx_fifo
		port map (
			-- read clock domain
			rd_clk   => xaui_clk,
			rd_en    => xaui_tx_fifo_ack,
			dout     => xaui_tx_fifo_out,
			empty    => open,
			valid    => xaui_tx_fifo_valid,
			rst      => xaui_reset_reg,
	
			-- write clock domain
			wr_clk   => app_clk,
			wr_en    => tx_valid,
			din      => tx_in,
			full     => tx_full
		);

	-- transmit fifo signals mapping
	xaui_tx_fifo_ack       <= xaui_tx_fifo_outofband_ack and xaui_tx_fifo_packet_ack and xaui_tx_fifo_state_ack;
	xaui_tx_fifo_outofband <= xaui_tx_fifo_out(71 downto 64)   ;
	xaui_tx_fifo_data      <= xaui_tx_fifo_out(63 downto  0)   ;
	tx_in                  <= tx_outofband                     &
	                          tx_data                          ;
end generate TX_FIFO_GEN_DEMUX1;

-- DEMUX = 2

TX_FIFO_GEN_DEMUX2: if DEMUX = 2 generate
	component tx_fifo_2x
		port (
			din    : IN  std_logic_VECTOR(35 downto 0);
			rd_clk : IN  std_logic;
			rd_en  : IN  std_logic;
			rst    : IN  std_logic;
			wr_clk : IN  std_logic;
			wr_en  : IN  std_logic;
			dout   : OUT std_logic_VECTOR(71 downto 0);
			empty  : OUT std_logic;
			full   : OUT std_logic;
			valid  : OUT std_logic);
	end component;
begin
	xaui_tx_fifo : tx_fifo_2x
		port map (
			-- read clock domain
			rd_clk   => xaui_clk,
			rd_en    => xaui_tx_fifo_ack,
			dout     => xaui_tx_fifo_out,
			empty    => open,
			valid    => xaui_tx_fifo_valid,
			rst      => xaui_reset_reg,
	
			-- write clock domain
			wr_clk   => app_clk,
			wr_en    => tx_valid,
			din      => tx_in,
			full     => tx_full
		);

	-- transmit fifo signals mapping
	xaui_tx_fifo_ack       <= xaui_tx_fifo_outofband_ack and xaui_tx_fifo_packet_ack and xaui_tx_fifo_state_ack;
	xaui_tx_fifo_outofband <= xaui_tx_fifo_out(71 downto 68)   &
	                          xaui_tx_fifo_out(35 downto 32)   ;
	xaui_tx_fifo_data      <= xaui_tx_fifo_out(67 downto 36)   &
	                          xaui_tx_fifo_out(31 downto  0)   ;
	tx_in                  <= tx_outofband                &
	                          tx_data                     ;
end generate TX_FIFO_GEN_DEMUX2;


--                            ##      #       ##          
--                           #               #            
--                           #               #            
-- ### ##  ### ###          ####    ###     ####    ##### 
--   ##  #  #   #            #        #      #     #     #
--   #       ###             #        #      #     #     #
--   #       ###             #        #      #     #     #
--   #      #   #            #        #      #     #     #
-- #####   ### ###          ####    #####   ####    ##### 

-- receive FIFO instantiation

-- DEMUX = 1

RX_FIFO_GEN_DEMUX1: if DEMUX = 1 generate
	component rx_fifo
		port (
		din         : IN  std_logic_VECTOR(71 downto 0);
		rd_clk      : IN  std_logic;
		rd_en       : IN  std_logic;
		rst         : IN  std_logic;
		wr_clk      : IN  std_logic;
		wr_en       : IN  std_logic;
		dout        : OUT std_logic_VECTOR(71 downto 0);
		empty       : OUT std_logic;
		full        : OUT std_logic;
		valid       : OUT std_logic;
		almost_full : OUT std_logic
);
	end component;
begin
	xaui_rx_fifo : rx_fifo
		port map (
			-- read clock domain
			rd_clk      => app_clk,
			rd_en       => rx_get,
			almost_full => rx_almost_full,
			dout        => rx_out,
			empty       => rx_empty,
			valid       => rx_valid,
	
			-- write clock domain
			wr_clk      => xaui_clk,
			wr_en       => xaui_rx_fifo_valid,
			din         => xaui_rx_fifo_in,
			full        => xaui_rx_fifo_full,
			rst         => xaui_rx_fifo_reset
		);

	-- receive fifo signals mapping
	xaui_rx_fifo_in        <= xaui_rx_fifo_outofband            &
	                          xaui_rx_fifo_data                 ;
	xaui_rx_fifo_reset     <= xaui_reset_reg or rx_reset            ;
	rx_outofband           <= rx_out(71 downto 64)              ;
	rx_data                <= rx_out(63 downto  0)              ;
end generate RX_FIFO_GEN_DEMUX1;

-- DEMUX = 2

RX_FIFO_GEN_DEMUX2: if DEMUX = 2 generate
	component rx_fifo_2x
		port (
		din         : IN  std_logic_VECTOR(71 downto 0);
		rd_clk      : IN  std_logic;
		rd_en       : IN  std_logic;
		rst         : IN  std_logic;
		wr_clk      : IN  std_logic;
		wr_en       : IN  std_logic;
		dout        : OUT std_logic_VECTOR(35 downto 0);
		empty       : OUT std_logic;
		full        : OUT std_logic;
		valid       : OUT std_logic;
		almost_full : OUT std_logic
		);
	end component;
begin
	xaui_rx_fifo : rx_fifo_2x
		port map (
			-- read clock domain
			rd_clk      => app_clk,
			rd_en       => rx_get,
			almost_full => rx_almost_full,
			dout        => rx_out,
			empty       => rx_empty,
			valid       => rx_valid,
	
			-- write clock domain
			wr_clk      => xaui_clk,
			wr_en       => xaui_rx_fifo_valid,
			din         => xaui_rx_fifo_in,
			full        => xaui_rx_fifo_full,
			rst         => xaui_rx_fifo_reset
		);

	-- receive fifo signals mapping
	xaui_rx_fifo_in        <= xaui_rx_fifo_outofband(7 downto 4) &
	                          xaui_rx_fifo_data(63 downto 32)    &
	                          xaui_rx_fifo_outofband(3 downto 0) &
	                          xaui_rx_fifo_data(31 downto 0)     ;
	xaui_rx_fifo_reset     <= xaui_reset_reg or rx_reset             ;
	rx_outofband           <= rx_out(35 downto 32)               ;
	rx_data                <= rx_out(31 downto  0)               ;
end generate RX_FIFO_GEN_DEMUX2;

opb_attach_inst : opb_attach
		generic map(
	    C_BASEADDR    => C_BASEADDR,
	    C_HIGHADDR    => C_HIGHADDR
		)
    port map (
	    -- OPB attachment
	    OPB_Clk	      => OPB_Clk,
	    OPB_Rst	      => OPB_Rst,
	    Sl_DBus	      => Sl_DBus,
	    Sl_errAck	    => Sl_errAck,
	    Sl_retry	    => Sl_retry,
	    Sl_toutSup	  => Sl_toutSup,
	    Sl_xferAck	  => Sl_xferAck,
	    OPB_ABus	    => OPB_ABus,
	    OPB_BE	      => OPB_BE,
	    OPB_DBus	    => OPB_DBus,
	    OPB_RNW	      => OPB_RNW,
	    OPB_select    => OPB_select,
	    OPB_seqAddr   => OPB_seqAddr,
    -- mgt config signals     
      rxeqmix       => mgt_rxeqmix,
      rxeqpole      => mgt_rxeqpole,
      txpreemphasis => mgt_txpreemphasis,
      txdiffctrl    => mgt_txdiffctrl,
      xaui_status   => xaui_status
		);

xgmii_txd         <= xgmii_txd_int;
xgmii_txc         <= xgmii_txc_int;

end architecture XAUI_interface_arch;
