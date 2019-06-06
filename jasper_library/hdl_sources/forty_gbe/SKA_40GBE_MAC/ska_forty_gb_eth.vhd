----------------------------------------------------------------------------------
-- Company: Peralex Electronics
-- Engineer: Gavin Teague
-- 
-- Create Date: 05.09.2014 10:19:29
-- Design Name: 
-- Module Name: ska_forty_gb_eth - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- SKA 40GBE (includes IP encapsulation and MAC)
--
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity ska_forty_gb_eth is
    generic (
        FABRIC_MAC     : std_logic_vector(47 downto 0);
        FABRIC_IP      : std_logic_vector(31 downto 0);
        FABRIC_PORT    : std_logic_vector(15 downto 0);
        FABRIC_NETMASK : std_logic_vector(31 downto 0);
        FABRIC_GATEWAY : std_logic_vector(7 downto 0);
        FABRIC_ENABLE  : std_logic;
        TTL                 : std_logic_vector(7 downto 0);
        PROMISC_MODE        : integer;
        RX_CRC_CHK_ENABLE   : integer);     
    port (
        clk : in std_logic;
        rst : in std_logic;
        -- TRANSMIT FABRIC INTERFACE
        tx_valid            : in std_logic_vector(3 downto 0);
        tx_end_of_frame     : in std_logic;
        tx_data             : in std_logic_vector(255 downto 0);
        tx_dest_ip          : in std_logic_vector(31 downto 0);
        tx_dest_port        : in std_logic_vector(15 downto 0);
        tx_overflow         : out std_logic;
        tx_afull            : out std_logic;
        
        --RECEIVE FABRIC INTERFACE
        rx_valid            : out std_logic_vector(3 downto 0);
        rx_end_of_frame     : out std_logic;
        rx_data             : out std_logic_vector(255 downto 0);
        rx_source_ip        : out std_logic_vector(31 downto 0);
        rx_source_port      : out std_logic_vector(15 downto 0);
        rx_dest_ip          : out std_logic_vector(31 downto 0);
        rx_dest_port        : out std_logic_vector(15 downto 0);
        rx_bad_frame        : out std_logic;
        rx_overrun          : out std_logic;
        rx_overrun_ack      : in std_logic;
        rx_ack : in std_logic;
        
        -- WISHBONE SLAVE INTERFACE
        CLK_I : in std_logic;
        RST_I : in std_logic;
        DAT_I : in std_logic_vector(31 downto 0);
        DAT_O : out std_logic_vector(31 downto 0);
        ACK_O : out std_logic;
        ADR_I : in std_logic_vector(13 downto 0);
        CYC_I : in std_logic;
        SEL_I : in std_logic_vector(3 downto 0);
        STB_I : in std_logic;
        WE_I  : in std_logic;
        
        -- XLGMII INTERFACE
        xlgmii_txclk    : in std_logic;
        xlgmii_txrst    : in std_logic;
        xlgmii_txd      : out std_logic_vector(255 downto 0);
        xlgmii_txc      : out std_logic_vector(31 downto 0);
        xlgmii_txled    : out std_logic_vector(1 downto 0);
        xlgmii_rxclk    : in std_logic;
        xlgmii_rxrst    : in std_logic;
        xlgmii_rxd      : in std_logic_vector(255 downto 0);
        xlgmii_rxc      : in std_logic_vector(31 downto 0);
        xlgmii_rxled    : out std_logic_vector(1 downto 0);
        phy_tx_rst      : in std_logic;
        phy_rx_up       : in std_logic;
       
        -- LOCAL CONFIG
        src_ip_address      : out std_logic_vector(31 downto 0);
        src_mac_address     : out std_logic_vector(47 downto 0);
        src_enable          : out std_logic;
        src_port            : out std_logic_vector(15 downto 0);
        --src_netmask         : out std_logic_vector(31 downto 0);
        src_gateway         : out std_logic_vector(7 downto 0);
        src_local_mc_recv_ip        : out std_logic_vector(31 downto 0);
        src_local_mc_recv_ip_mask   : out std_logic_vector(31 downto 0);
        
        debug_out   : out std_logic_vector(7 downto 0);
        debug_led   : out std_logic_vector(7 downto 0));
end ska_forty_gb_eth;

architecture arch_ska_forty_gb_eth of ska_forty_gb_eth is

    type T_CPU_RESET_STATE is (
    CPU_RESET_IDLE,
    CPU_RESET_WAIT_FOR_MAC_START,
    CPU_RESET_WAIT_FOR_MAC_FINISH);
    
    type T_MAC_RESET_STATE is (
    MAC_RESET_IDLE,
    MAC_DO_RESET);
    
    type T_MAC_RX_STATE is (
    WAIT_FOR_END_CHANNEL_1,
    WAIT_FOR_END_CHANNEL_2);

    component wishbone_forty_gb_eth_attach
    generic (
        FABRIC_MAC     : std_logic_vector(47 downto 0);
        FABRIC_IP      : std_logic_vector(31 downto 0);
        FABRIC_PORT    : std_logic_vector(15 downto 0);
        FABRIC_NETMASK : std_logic_vector(31 downto 0);
        FABRIC_GATEWAY : std_logic_vector(7 downto 0);
        FABRIC_ENABLE  : std_logic;
        MC_RECV_IP          : std_logic_vector(31 downto 0);
        MC_RECV_IP_MASK     : std_logic_vector(31 downto 0));     
	port (
		CLK_I : in std_logic;
		RST_I : in std_logic;
		DAT_I : in std_logic_vector(31 downto 0);
		DAT_O : out std_logic_vector(31 downto 0);
		ACK_O : out std_logic;
		ADR_I : in std_logic_vector(13 downto 0);
		CYC_I : in std_logic;
		SEL_I : in std_logic_vector(3 downto 0);
		STB_I : in std_logic;
		WE_I  : in std_logic;
        cpu_tx_buffer_addr      : out std_logic_vector(7 downto 0);
        cpu_tx_buffer_rd_data   : in std_logic_vector(63 downto 0);
        cpu_tx_buffer_wr_data   : out std_logic_vector(63 downto 0);
        cpu_tx_buffer_wr_en     : out std_logic;
        cpu_tx_size             : out std_logic_vector(7 downto 0);
        cpu_tx_ready            : out std_logic;
        cpu_tx_done             : in std_logic;
        cpu_rx_buffer_addr      : out std_logic_vector(7 downto 0);
        cpu_rx_buffer_rd_data   : in std_logic_vector(63 downto 0);
        cpu_rx_size             : in std_logic_vector(7 downto 0);
        cpu_rx_ack              : out std_logic;
        arp_cache_addr      : out std_logic_vector(7 downto 0);
        arp_cache_rd_data   : in std_logic_vector(47 downto 0);
        arp_cache_wr_data   : out std_logic_vector(47 downto 0);
        arp_cache_wr_en     : out std_logic;
        local_enable    : out std_logic;
        local_mac       : out std_logic_vector(47 downto 0);
        local_ip        : out std_logic_vector(31 downto 0);
        local_port      : out std_logic_vector(15 downto 0);
        local_netmask   : out std_logic_vector(31 downto 0);
        local_gateway   : out std_logic_vector(7 downto 0);
        local_mc_recv_ip        : out std_logic_vector(31 downto 0);
        local_mc_recv_ip_mask   : out std_logic_vector(31 downto 0);        
        soft_reset      : out std_logic;
        soft_reset_ack  : in std_logic);
    end component;
  
    component ska_fge_tx
    generic (
        TTL             : std_logic_vector(7 downto 0));
    port (
        local_enable    : in std_logic;
        local_mac       : in std_logic_vector(47 downto 0);
        local_ip        : in std_logic_vector(31 downto 0);
        local_port      : in std_logic_vector(15 downto 0);
        local_netmask   : in std_logic_vector(31 downto 0);
        local_gateway   : in std_logic_vector(7 downto 0);
        arp_cache_addr      : in std_logic_vector(7 downto 0);
        arp_cache_rd_data   : out std_logic_vector(47 downto 0);
        arp_cache_wr_data   : in std_logic_vector(47 downto 0);
        arp_cache_wr_en     : in std_logic;
        app_clk             : in std_logic;
        app_rst             : in std_logic;
        app_tx_valid        : in std_logic_vector(3 downto 0);
        app_tx_end_of_frame : in std_logic;
        app_tx_data         : in std_logic_vector(255 downto 0);
        app_tx_dest_ip      : in std_logic_vector(31 downto 0);
        app_tx_dest_port    : in std_logic_vector(15 downto 0);
        app_tx_overflow     : out std_logic;
        app_tx_afull        : out std_logic;
        cpu_clk                 : in std_logic;
        cpu_rst                 : in std_logic;
        cpu_tx_buffer_addr      : in std_logic_vector(7 downto 0);
        cpu_tx_buffer_rd_data   : out std_logic_vector(63 downto 0);
        cpu_tx_buffer_wr_data   : in std_logic_vector(63 downto 0);
        cpu_tx_buffer_wr_en     : in std_logic;
        cpu_tx_size             : in std_logic_vector(7 downto 0);
        cpu_tx_ready            : in std_logic;
        cpu_tx_done             : out std_logic;
        mac_clk             : in std_logic;
        mac_rst             : in std_logic;
        mac_tx_data         : out std_logic_vector(255 downto 0); 
        mac_tx_data_valid   : out std_logic_vector(31 downto 0);
        mac_tx_start        : out std_logic;
        mac_tx_ready        : in std_logic;
        debug_out           : out std_logic_vector(7 downto 0));
    end component;
  
    component ska_mac_tx
    port (
        mac_clk             : in std_logic;
        mac_rst             : in std_logic;
        mac_tx_data         : in std_logic_vector(255 downto 0); 
        mac_tx_data_valid   : in std_logic_vector(31 downto 0);
        mac_tx_start        : in std_logic;
        mac_tx_ready        : out std_logic;
        phy_tx_rst          : in std_logic;
        xlgmii_txd      : out std_logic_vector(255 downto 0);
        xlgmii_txc      : out std_logic_vector(31 downto 0);
        xlgmii_txled    : out std_logic_vector(1 downto 0));
    end component;
  
    component ska_runt_filt_rx
    port (
        mac_clk             : in std_logic;
        mac_rst             : in std_logic;
        xlgmii_rxd_in      : in std_logic_vector(255 downto 0);
        xlgmii_rxc_in      : in std_logic_vector(31 downto 0);
        xlgmii_rxd_out     : out std_logic_vector(255 downto 0);
        xlgmii_rxc_out     : out std_logic_vector(31 downto 0);
        phy_rx_up          : in std_logic;
        xlgmii_rxled       : out std_logic_vector(1 downto 0));
    end component;  
  
    component ska_mac_rx
    generic (
        RX_CRC_CHK_ENABLE   : integer); 
    port (
        xlgmii_rxd      : in std_logic_vector(255 downto 0);
        xlgmii_rxc      : in std_logic_vector(31 downto 0);
        mac_clk             : in std_logic;
        mac_rst             : in std_logic;
        mac_rx_enable       : in std_logic;
        mac_rx_busy         : out std_logic;
        mac_rx_data         : out std_logic_vector(255 downto 0); 
        mac_rx_data_valid   : out std_logic_vector(31 downto 0);
        mac_rx_good_frame   : out std_logic;
        mac_rx_bad_frame    : out std_logic);
    end component;
  
    component overlap_buffer
    port (
        clk     : in std_logic;
        rst     : in std_logic;
        din     : in std_logic_vector(289 downto 0);
        wr_en   : in std_logic;
        rd_en   : in std_logic;
        dout    : out std_logic_vector(289 downto 0);
        full    : out std_logic;
        empty   : out std_logic);
    end component;
  
    component ska_fge_rx
    generic (
        PROMISC_MODE    : integer);
    port (
        local_enable    : in std_logic;
        local_mac       : in std_logic_vector(47 downto 0);
        local_ip        : in std_logic_vector(31 downto 0);
        local_port      : in std_logic_vector(15 downto 0);
        local_gateway   : in std_logic_vector(7 downto 0);
        local_mc_recv_ip        : in std_logic_vector(31 downto 0);
        local_mc_recv_ip_mask   : in std_logic_vector(31 downto 0);        
        app_clk                 : in std_logic;
        app_rst                 : in std_logic;
        app_rx_valid            : out std_logic_vector(3 downto 0);
        app_rx_end_of_frame     : out std_logic;
        app_rx_data             : out std_logic_vector(255 downto 0);
        app_rx_source_ip        : out std_logic_vector(31 downto 0);
        app_rx_source_port      : out std_logic_vector(15 downto 0);
        app_rx_dest_ip          : out std_logic_vector(31 downto 0);
        app_rx_dest_port        : out std_logic_vector(15 downto 0);
        app_rx_bad_frame        : out std_logic;
        app_rx_overrun          : out std_logic;
        app_rx_overrun_ack      : in std_logic;
        app_rx_ack              : in std_logic;
        cpu_clk                 : in std_logic;
        cpu_rst                 : in std_logic;
        cpu_rx_buffer_addr      : in std_logic_vector(7 downto 0);
        cpu_rx_buffer_rd_data   : out std_logic_vector(63 downto 0);
        cpu_rx_size             : out std_logic_vector(7 downto 0);
        cpu_rx_ack              : in std_logic;
        mac_clk             : in std_logic;
        mac_rst             : in std_logic;
        mac_rx_data         : in std_logic_vector(255 downto 0);
        mac_rx_data_valid   : in std_logic_vector(31 downto 0);
        mac_rx_good_frame   : in std_logic;
        mac_rx_bad_frame    : in std_logic;
        phy_rx_up           : in std_logic;
        debug_port : out std_logic_vector(7 downto 0));
    end component;
  
    signal cpu_tx_buffer_addr : std_logic_vector(7 downto 0);
    signal cpu_tx_buffer_rd_data : std_logic_vector(63 downto 0);
    signal cpu_tx_buffer_wr_data : std_logic_vector(63 downto 0);
    signal cpu_tx_buffer_wr_en : std_logic;
    signal cpu_tx_size : std_logic_vector(7 downto 0);
    signal cpu_tx_ready : std_logic;
    signal cpu_tx_done : std_logic;
    signal cpu_rx_buffer_addr : std_logic_vector(7 downto 0);
    signal cpu_rx_buffer_rd_data : std_logic_vector(63 downto 0);
    signal cpu_rx_size : std_logic_vector(7 downto 0);
    signal cpu_rx_ack : std_logic;
    signal arp_cache_addr : std_logic_vector(7 downto 0);
    signal arp_cache_rd_data : std_logic_vector(47 downto 0);
    signal arp_cache_wr_data : std_logic_vector(47 downto 0);
    signal arp_cache_wr_en : std_logic;
    signal local_enable : std_logic;
    signal local_mac : std_logic_vector(47 downto 0);
    signal local_ip : std_logic_vector(31 downto 0);
    signal local_port : std_logic_vector(15 downto 0);
    signal local_netmask : std_logic_vector(31 downto 0);
    signal local_gateway : std_logic_vector(7 downto 0);
    signal soft_reset : std_logic;
    signal soft_reset_ack : std_logic;
  
    signal app_rst : std_logic;
    signal usr_rst : std_logic;
  
    signal current_cpu_reset_state : T_CPU_RESET_STATE;
    signal mac_rst_ack : std_logic;
    signal mac_rst_ack_z1 : std_logic;
    signal mac_rst_ack_z2 : std_logic;
    signal mac_rst_req : std_logic;
    signal mac_rst_req_z1 : std_logic;
    signal mac_rst_req_z2 : std_logic;
    signal current_mac_reset_state : T_MAC_RESET_STATE;
     
    signal mac_tx_data : std_logic_vector(255 downto 0); 
    signal mac_tx_data_valid : std_logic_vector(31 downto 0);
    signal mac_tx_start : std_logic;
    signal mac_tx_ready : std_logic;
     
    signal mac_rx_channel : std_logic;
     
    signal mac_rx_enable_1 : std_logic;
    signal mac_rx_busy_out_1 : std_logic;

    signal mac_rx_enable_2 : std_logic;
    signal mac_rx_busy_out_2 : std_logic;

    signal mac_rx_data_1 : std_logic_vector(255 downto 0); 
    signal mac_rx_data_valid_1 : std_logic_vector(31 downto 0);
    signal mac_rx_good_frame_1 : std_logic;
    signal mac_rx_bad_frame_1 : std_logic;

    signal mac_rx_data_2 : std_logic_vector(255 downto 0); 
    signal mac_rx_data_valid_2 : std_logic_vector(31 downto 0);
    signal mac_rx_good_frame_2 : std_logic;
    signal mac_rx_bad_frame_2 : std_logic;
    
    signal mac_rx_data : std_logic_vector(255 downto 0); 
    signal mac_rx_data_valid : std_logic_vector(31 downto 0);
    signal mac_rx_good_frame : std_logic;
    signal mac_rx_bad_frame : std_logic;
     
    signal local_mc_recv_ip : std_logic_vector(31 downto 0);
    signal local_mc_recv_ip_mask : std_logic_vector(31 downto 0);
        
    signal overlap_buffer_din_1 : std_logic_vector(289 downto 0);
    signal overlap_buffer_wrreq_1 : std_logic;
    signal overlap_buffer_rdreq_1 : std_logic;
    signal overlap_buffer_dout_1 : std_logic_vector(289 downto 0);
    signal overlap_buffer_full_1 : std_logic;
    signal overlap_buffer_empty_1 : std_logic;

    signal overlap_buffer_din_2 : std_logic_vector(289 downto 0);
    signal overlap_buffer_wrreq_2 : std_logic;
    signal overlap_buffer_rdreq_2 : std_logic;
    signal overlap_buffer_dout_2 : std_logic_vector(289 downto 0);
    signal overlap_buffer_full_2 : std_logic;
    signal overlap_buffer_empty_2 : std_logic;
      
    signal current_mac_rx_state : T_MAC_RX_STATE;
    
    signal xlgmii_rxd_filtered : std_logic_vector(255 downto 0);
    signal xlgmii_rxc_filtered : std_logic_vector(31 downto 0);
    
--    signal rx_start_count_filtered_i : std_logic_vector(7 downto 0);
--    signal rx_count_good_i : std_logic_vector(7 downto 0);
--    signal rx_count_bad_i : std_logic_vector(7 downto 0);
    
begin

--    debug_out(0) <= '0';
--    debug_out(1) <= '0';
--    debug_out(2) <= '0';
--    debug_out(3) <= '0';
--    debug_out(4) <= '0';
--    debug_out(5) <= '0';
--    debug_out(6) <= '0';
--    debug_out(7) <= '0';

    debug_led(0) <= '0';
    debug_led(1) <= '0';
    debug_led(2) <= '0';
    debug_led(3) <= '0';
    debug_led(4) <= '0';
    debug_led(5) <= '0';
    debug_led(6) <= '0';
    debug_led(7) <= '0';

    src_ip_address <= local_ip;
    src_mac_address <= local_mac;
    src_enable <= local_enable;
    src_port <= local_port;
    -- src_netmask <= local_netmask;
    src_gateway <= local_gateway;
    src_local_mc_recv_ip <= local_mc_recv_ip;
    src_local_mc_recv_ip_mask <= local_mc_recv_ip_mask;

    --mac_rst <= xlgmii_rst;
    --mac_clk <= xlgmii_clk;
    
----------------------------------------------------------------------------------------
-- MOVE RESET FROM CPU TO MAC CLOCK DOMAIN
----------------------------------------------------------------------------------------

    -- DIFFERENT TO 10GBE CORE
    gen_app_rst : process(clk)
    begin
        if (rising_edge(clk))then
            if ((current_cpu_reset_state = CPU_RESET_WAIT_FOR_MAC_START)or(current_cpu_reset_state = CPU_RESET_WAIT_FOR_MAC_FINISH)or(rst = '1'))then
                app_rst <= '1';
            else
                app_rst <= '0';
            end if;
        end if;
    end process;

--    -- SAME AS 10GBE CORE
--    gen_app_rst : process(clk)
--    begin
--        if (rising_edge(clk))then 
--            app_rst <= rst or usr_rst;
--        end if; 
--    end process;

    gen_current_cpu_reset_state :  process(rst, clk)
    begin
        if (rst = '1')then
            soft_reset_ack <= '0';
            mac_rst_ack_z1 <= '0';
            mac_rst_ack_z2 <= '0';           
            current_cpu_reset_state <= CPU_RESET_IDLE;
        elsif (rising_edge(clk))then
            soft_reset_ack <= '0';
            mac_rst_ack_z1 <= mac_rst_ack;
            mac_rst_ack_z2 <= mac_rst_ack_z1;           

            case current_cpu_reset_state is
                when CPU_RESET_IDLE =>
                current_cpu_reset_state <= CPU_RESET_IDLE;
                
                if (soft_reset = '1')then
                    current_cpu_reset_state <= CPU_RESET_WAIT_FOR_MAC_START;
                end if;
                
                when CPU_RESET_WAIT_FOR_MAC_START =>
                current_cpu_reset_state <= CPU_RESET_WAIT_FOR_MAC_START;

                if (mac_rst_ack_z2 = '1')then
                    current_cpu_reset_state <= CPU_RESET_WAIT_FOR_MAC_FINISH;
                end if;                
                
                when CPU_RESET_WAIT_FOR_MAC_FINISH =>
                current_cpu_reset_state <= CPU_RESET_WAIT_FOR_MAC_FINISH;
                
                if (mac_rst_ack_z2 = '0')then
                    soft_reset_ack <= '1';
                    current_cpu_reset_state <= CPU_RESET_IDLE;
                end if;
    
            end case;
        end if;
    end process;
    
    mac_rst_req <= '1' when (current_cpu_reset_state = CPU_RESET_WAIT_FOR_MAC_START) else '0';
    
    gen_current_mac_reset_state : process(xlgmii_txrst, xlgmii_txclk)
    begin
        if (xlgmii_txrst = '1')then
            mac_rst_req_z1 <= '0';
            mac_rst_req_z2 <= '0';       
            current_mac_reset_state <= MAC_RESET_IDLE;
        elsif (rising_edge(xlgmii_txclk))then
            mac_rst_req_z1 <= mac_rst_req;
            mac_rst_req_z2 <= mac_rst_req_z1;       

            case current_mac_reset_state is
                when MAC_RESET_IDLE =>
                current_mac_reset_state <= MAC_RESET_IDLE;
                
                if (mac_rst_req_z2 = '1')then
                    current_mac_reset_state <= MAC_DO_RESET;
                end if;
                
                when MAC_DO_RESET =>
                current_mac_reset_state <= MAC_DO_RESET;
                
                if (mac_rst_req_z2 = '0')then
                    current_mac_reset_state <= MAC_RESET_IDLE;
                end if;
                
            end case;
        end if;
    end process;
    
    mac_rst_ack <= '1' when (current_mac_reset_state = MAC_DO_RESET) else '0';
    
    usr_rst <= '1' when ((current_mac_reset_state = MAC_DO_RESET)and(mac_rst_req_z2 = '0'))else '0';
    
    -- SHOULD THERE NOT BE A RESET OF MAC (XLGMII) WHEN GET A SOFT RESET?
    -- MAY NEED TO REPLICATE ABOVE FOR xlgmii_rxrst, xlgmii_rxclk
    
----------------------------------------------------------------------------------------
-- WISHBONE SLAVE
----------------------------------------------------------------------------------------

    wishbone_forty_gb_eth_attach_0 : wishbone_forty_gb_eth_attach
    generic map(
        FABRIC_MAC     => FABRIC_MAC,
        FABRIC_IP      => FABRIC_IP,
        FABRIC_PORT    => FABRIC_PORT,
        FABRIC_NETMASK => FABRIC_NETMASK,
        FABRIC_GATEWAY => FABRIC_GATEWAY,
        FABRIC_ENABLE  => FABRIC_ENABLE,
        MC_RECV_IP          => X"FFFFFFFF",
        MC_RECV_IP_MASK     => X"FFFFFFFF")
	port map(
		CLK_I => CLK_I,
		RST_I => RST_I,
		DAT_I => DAT_I,
		DAT_O => DAT_O,
		ACK_O => ACK_O,
		ADR_I => ADR_I,
		CYC_I => CYC_I,
		SEL_I => SEL_I,
		STB_I => STB_I,
		WE_I  => WE_I,
        cpu_tx_buffer_addr      => cpu_tx_buffer_addr,
        cpu_tx_buffer_rd_data   => cpu_tx_buffer_rd_data,
        cpu_tx_buffer_wr_data   => cpu_tx_buffer_wr_data,
        cpu_tx_buffer_wr_en     => cpu_tx_buffer_wr_en,
        cpu_tx_size             => cpu_tx_size,
        cpu_tx_ready            => cpu_tx_ready,
        cpu_tx_done             => cpu_tx_done,
        cpu_rx_buffer_addr      => cpu_rx_buffer_addr,
        cpu_rx_buffer_rd_data   => cpu_rx_buffer_rd_data,
        cpu_rx_size             => cpu_rx_size,
        cpu_rx_ack              => cpu_rx_ack,
        arp_cache_addr      => arp_cache_addr,
        arp_cache_rd_data   => arp_cache_rd_data,
        arp_cache_wr_data   => arp_cache_wr_data,
        arp_cache_wr_en     => arp_cache_wr_en,
        local_enable    => local_enable,
        local_mac       => local_mac,
        local_ip        => local_ip,
        local_port      => local_port,
        local_netmask   => local_netmask,
        local_gateway   => local_gateway,
        local_mc_recv_ip        => local_mc_recv_ip,
        local_mc_recv_ip_mask   => local_mc_recv_ip_mask,        
        soft_reset      => soft_reset,
        soft_reset_ack  => soft_reset_ack); 

----------------------------------------------------------------------------------------
-- TRANSMIT DATA PATH
----------------------------------------------------------------------------------------

    ska_fge_tx_0 : ska_fge_tx
    generic map (
        TTL            => TTL)
    port map(
        local_enable    => local_enable,
        local_mac       => local_mac,
        local_ip        => local_ip,
        local_port      => local_port,
        local_netmask   => local_netmask,
        local_gateway   => local_gateway,
        arp_cache_addr      => arp_cache_addr,
        arp_cache_rd_data   => arp_cache_rd_data,
        arp_cache_wr_data   => arp_cache_wr_data,
        arp_cache_wr_en     => arp_cache_wr_en,
        app_clk             => clk,
        app_rst             => app_rst,
        app_tx_valid        => tx_valid,
        app_tx_end_of_frame => tx_end_of_frame,
        app_tx_data         => tx_data,
        app_tx_dest_ip      => tx_dest_ip,
        app_tx_dest_port    => tx_dest_port,
        app_tx_overflow     => tx_overflow,
        app_tx_afull        => tx_afull,
        cpu_clk                 => CLK_I,
        cpu_rst                 => RST_I,
        cpu_tx_buffer_addr      => cpu_tx_buffer_addr,
        cpu_tx_buffer_rd_data   => cpu_tx_buffer_rd_data,
        cpu_tx_buffer_wr_data   => cpu_tx_buffer_wr_data,
        cpu_tx_buffer_wr_en     => cpu_tx_buffer_wr_en,
        cpu_tx_size             => cpu_tx_size,
        cpu_tx_ready            => cpu_tx_ready,
        cpu_tx_done             => cpu_tx_done,
        mac_clk             => xlgmii_txclk,
        mac_rst             => xlgmii_txrst,
        mac_tx_data         => mac_tx_data, 
        mac_tx_data_valid   => mac_tx_data_valid,
        mac_tx_start        => mac_tx_start,
        mac_tx_ready        => mac_tx_ready,
        debug_out           => open);

----------------------------------------------------------------------------------------
-- TX MAC
----------------------------------------------------------------------------------------

    ska_mac_tx_0 : ska_mac_tx
    port map(
        mac_clk             => xlgmii_txclk,
        mac_rst             => xlgmii_txrst,
        mac_tx_data         => mac_tx_data, 
        mac_tx_data_valid   => mac_tx_data_valid,
        mac_tx_start        => mac_tx_start,
        mac_tx_ready        => mac_tx_ready,
        phy_tx_rst          => phy_tx_rst,
        xlgmii_txd      => xlgmii_txd,
        xlgmii_txc      => xlgmii_txc,
        xlgmii_txled    => xlgmii_txled);

----------------------------------------------------------------------------------------
-- RX MAC CAN'T HANDLE RUNT PACKETS SO FILTER THEM OUT FIRST
----------------------------------------------------------------------------------------

    ska_runt_filt_rx_0 : ska_runt_filt_rx
    port map(
        mac_clk             => xlgmii_rxclk,
        mac_rst             => xlgmii_rxrst,
        xlgmii_rxd_in      => xlgmii_rxd,
        xlgmii_rxc_in      => xlgmii_rxc,
        xlgmii_rxd_out     => xlgmii_rxd_filtered,
        xlgmii_rxc_out     => xlgmii_rxc_filtered,
        phy_rx_up          => phy_rx_up,
        xlgmii_rxled       => xlgmii_rxled);

--    gen_rx_start_count_filtered : process(xlgmii_rxrst, xlgmii_rxclk)
--    begin
--        if (xlgmii_rxrst = '1')then
--            rx_start_count_filtered_i <= (others => '0');
--        elsif (rising_edge(xlgmii_rxclk))then
--            if (((xlgmii_rxc_filtered(0) = '1')and(xlgmii_rxd_filtered(7 downto 0) = X"FB"))or
--            ((xlgmii_rxc_filtered(8) = '1')and(xlgmii_rxd_filtered(71 downto 64) = X"FB"))or
--            ((xlgmii_rxc_filtered(16) = '1')and(xlgmii_rxd_filtered(135 downto 128) = X"FB"))or
--            ((xlgmii_rxc_filtered(24) = '1')and(xlgmii_rxd_filtered(199 downto 192) = X"FB")))then
--                rx_start_count_filtered_i <= rx_start_count_filtered_i + X"01";
--            end if;
--        end if;
--    end process;

--    rx_start_count_filtered <= rx_start_count_filtered_i;

    --xlgmii_rxd_filtered <= xlgmii_rxd;
    --xlgmii_rxc_filtered <= xlgmii_rxc;

----------------------------------------------------------------------------------------
-- RX MAC
----------------------------------------------------------------------------------------

    -- TWO MAC RX DATA PATHS OPERATE IN PARALLEL IN ORDER TO BE
    -- ABLE TO SATISFY MINIMUM IFG
	
    ska_mac_rx_0 : ska_mac_rx
    generic map(
        RX_CRC_CHK_ENABLE   => RX_CRC_CHK_ENABLE) 
    port map(
        xlgmii_rxd      => xlgmii_rxd_filtered,
        xlgmii_rxc      => xlgmii_rxc_filtered,
        mac_clk             => xlgmii_rxclk,
        mac_rst             => xlgmii_rxrst,
        mac_rx_enable       => mac_rx_enable_1,
        mac_rx_busy         => mac_rx_busy_out_1,
        mac_rx_data         => mac_rx_data_1, 
        mac_rx_data_valid   => mac_rx_data_valid_1,
        mac_rx_good_frame   => mac_rx_good_frame_1,
        mac_rx_bad_frame    => mac_rx_bad_frame_1);

    ska_mac_rx_1 : ska_mac_rx
    generic map(
        RX_CRC_CHK_ENABLE   => RX_CRC_CHK_ENABLE) 
    port map(
        xlgmii_rxd      => xlgmii_rxd_filtered,
        xlgmii_rxc      => xlgmii_rxc_filtered,
        mac_clk             => xlgmii_rxclk,
        mac_rst             => xlgmii_rxrst,
        mac_rx_enable       => mac_rx_enable_2,
        mac_rx_busy         => mac_rx_busy_out_2,
        mac_rx_data         => mac_rx_data_2, 
        mac_rx_data_valid   => mac_rx_data_valid_2,
        mac_rx_good_frame   => mac_rx_good_frame_2,
        mac_rx_bad_frame    => mac_rx_bad_frame_2);

    mac_rx_enable_1 <= '1' when (mac_rx_channel = '0') else '0';
    mac_rx_enable_2 <= '1' when (mac_rx_channel = '1') else '0';

    gen_mac_rx_channel : process(xlgmii_rxrst, xlgmii_rxclk)
    begin
        if (xlgmii_rxrst = '1')then
            mac_rx_channel <= '0';
        elsif (rising_edge(xlgmii_rxclk))then
            if (mac_rx_channel = '0')then
                if ((mac_rx_busy_out_1 = '1')and(mac_rx_busy_out_2 = '0'))then
                    mac_rx_channel <= '1';
                end if;
            else
                if ((mac_rx_busy_out_2 = '1')and(mac_rx_busy_out_1 = '0'))then
                    mac_rx_channel <= '0';
                end if;    
            end if;
        end if;
    end process;

    -- IN A SPECIFIC SCENARIO, IT IS POSSIBLE FOR THE START OF THE OUTPUT OF
    -- THE SECOND MAC RX DATA CHANNEL TO OVERLAP THE END OF THE OUTPUT OF THE FIRST
    -- MAC RX DATA CHANNEL	
    overlap_buffer_din_1(255 downto 0) <= mac_rx_data_1;
    overlap_buffer_din_1(287 downto 256) <= mac_rx_data_valid_1;
    overlap_buffer_din_1(288) <= mac_rx_good_frame_1;
    overlap_buffer_din_1(289) <= mac_rx_bad_frame_1;
    
    overlap_buffer_wrreq_1 <= '1' when ((mac_rx_data_valid_1 /= X"00000000")and(overlap_buffer_full_1 = '0')) else '0';

    overlap_buffer_0 : overlap_buffer
    port map(
        clk     => xlgmii_rxclk,
        rst     => xlgmii_rxrst,
        din     => overlap_buffer_din_1,
        wr_en   => overlap_buffer_wrreq_1,
        rd_en   => overlap_buffer_rdreq_1,
        dout    => overlap_buffer_dout_1,
        full    => overlap_buffer_full_1,
        empty   => overlap_buffer_empty_1);

    overlap_buffer_rdreq_1 <= not overlap_buffer_empty_1 when (current_mac_rx_state = WAIT_FOR_END_CHANNEL_1) else '0';

    overlap_buffer_din_2(255 downto 0) <= mac_rx_data_2;
    overlap_buffer_din_2(287 downto 256) <= mac_rx_data_valid_2;
    overlap_buffer_din_2(288) <= mac_rx_good_frame_2;
    overlap_buffer_din_2(289) <= mac_rx_bad_frame_2;
    
    overlap_buffer_wrreq_2 <= '1' when ((mac_rx_data_valid_2 /= X"00000000")and(overlap_buffer_full_2 = '0')) else '0';

    overlap_buffer_1 : overlap_buffer
    port map(
        clk     => xlgmii_rxclk,
        rst     => xlgmii_rxrst,
        din     => overlap_buffer_din_2,
        wr_en   => overlap_buffer_wrreq_2,
        rd_en   => overlap_buffer_rdreq_2,
        dout    => overlap_buffer_dout_2,
        full    => overlap_buffer_full_2,
        empty   => overlap_buffer_empty_2);

    overlap_buffer_rdreq_2 <= not overlap_buffer_empty_2 when (current_mac_rx_state = WAIT_FOR_END_CHANNEL_2) else '0';

    gen_current_mac_rx_state : process(xlgmii_rxrst, xlgmii_rxclk)
    begin
        if (xlgmii_rxrst = '1')then
            current_mac_rx_state <= WAIT_FOR_END_CHANNEL_1;
        elsif (rising_edge(xlgmii_rxclk))then
            case current_mac_rx_state is
                when WAIT_FOR_END_CHANNEL_1 =>
                current_mac_rx_state <= WAIT_FOR_END_CHANNEL_1;
                
                if ((overlap_buffer_empty_1 = '0')and(overlap_buffer_dout_1(287 downto 256) /= X"00000000")and
                (overlap_buffer_dout_1(289 downto 288) /= "00"))then
                    current_mac_rx_state <= WAIT_FOR_END_CHANNEL_2;
                end if;
                
                when WAIT_FOR_END_CHANNEL_2 =>
                current_mac_rx_state <= WAIT_FOR_END_CHANNEL_2;
                
                if ((overlap_buffer_empty_2 = '0')and(overlap_buffer_dout_2(287 downto 256) /= X"00000000")and
                (overlap_buffer_dout_2(289 downto 288) /= "00"))then
                    current_mac_rx_state <= WAIT_FOR_END_CHANNEL_1;
                end if;
    
            end case;
        end if;
    end process;	
	
	mac_rx_data <= overlap_buffer_dout_1(255 downto 0) when (current_mac_rx_state = WAIT_FOR_END_CHANNEL_1) else
	   overlap_buffer_dout_2(255 downto 0);
	
	mac_rx_data_valid <= 
	    overlap_buffer_dout_1(287 downto 256) when ((current_mac_rx_state = WAIT_FOR_END_CHANNEL_1)and(overlap_buffer_empty_1 = '0')) else
        overlap_buffer_dout_2(287 downto 256) when ((current_mac_rx_state = WAIT_FOR_END_CHANNEL_2)and(overlap_buffer_empty_2 = '0')) else
        (others => '0');
        
    mac_rx_good_frame <= overlap_buffer_dout_1(288) when (current_mac_rx_state = WAIT_FOR_END_CHANNEL_1) else
        overlap_buffer_dout_2(288);   

    mac_rx_bad_frame <= overlap_buffer_dout_1(289) when (current_mac_rx_state = WAIT_FOR_END_CHANNEL_1) else
        overlap_buffer_dout_2(289);   
   
--    gen_rx_count_good : process(xlgmii_rxrst, xlgmii_rxclk)
--    begin
--        if (xlgmii_rxrst = '1')then
--            rx_count_good_i <= (others => '0');
--        elsif (rising_edge(xlgmii_rxclk))then
--            if ((mac_rx_data_valid /= "0000")and(mac_rx_good_frame = '1'))then
--                rx_count_good_i <= rx_count_good_i + X"01";
--            end if;
--        end if;
--    end process;

--    rx_count_good <= rx_count_good_i;

--    gen_rx_count_bad : process(xlgmii_rxrst, xlgmii_rxclk)
--    begin
--        if (xlgmii_rxrst = '1')then
--            rx_count_bad_i <= (others => '0');
--        elsif (rising_edge(xlgmii_rxclk))then
--            if ((mac_rx_data_valid /= "0000")and(mac_rx_bad_frame = '1'))then
--                rx_count_bad_i <= rx_count_bad_i + X"01";
--            end if;
--        end if;
--    end process;

--    rx_count_bad <= rx_count_bad_i;

----------------------------------------------------------------------------------------
-- RECEIVE DATA PATH
----------------------------------------------------------------------------------------
    
    ska_fge_rx_0 : ska_fge_rx
    generic map(
        PROMISC_MODE    => PROMISC_MODE)
    port map(
        local_enable    => local_enable,
        local_mac       => local_mac,
        local_ip        => local_ip,
        local_port      => local_port,
        local_gateway   => local_gateway,
        local_mc_recv_ip        => local_mc_recv_ip,
        local_mc_recv_ip_mask   => local_mc_recv_ip_mask,        
        app_clk                 => clk,
        app_rst                 => app_rst,
        app_rx_valid            => rx_valid,
        app_rx_end_of_frame     => rx_end_of_frame,
        app_rx_data             => rx_data,
        app_rx_source_ip        => rx_source_ip,
        app_rx_source_port      => rx_source_port,
        app_rx_dest_ip          => rx_dest_ip,
        app_rx_dest_port        => rx_dest_port,
        app_rx_bad_frame        => rx_bad_frame,
        app_rx_overrun          => rx_overrun,
        app_rx_overrun_ack      => rx_overrun_ack,
        app_rx_ack              => rx_ack,
        cpu_clk                 => CLK_I,
        cpu_rst                 => RST_I,
        cpu_rx_buffer_addr      => cpu_rx_buffer_addr,
        cpu_rx_buffer_rd_data   => cpu_rx_buffer_rd_data,
        cpu_rx_size             => cpu_rx_size,
        cpu_rx_ack              => cpu_rx_ack,
        mac_clk             => xlgmii_rxclk,
        mac_rst             => xlgmii_rxrst,
        mac_rx_data         => mac_rx_data,
        mac_rx_data_valid   => mac_rx_data_valid,
        mac_rx_good_frame   => mac_rx_good_frame,
        mac_rx_bad_frame    => mac_rx_bad_frame, 
        phy_rx_up           => phy_rx_up,
        debug_port => debug_out);

end arch_ska_forty_gb_eth;
