-- <h---------------------------------------------------------------------------
--! @file rx_path_top.vhd
--! @page rxpathtoppage Rx Path Top
--!
--! \includedoc esdg_stfc_image.md
--!
--! ### Brief ###
--! Top Level of the Receive Path. Contains a FIFO at the input which crosses
--! from Rx PHY Clk to Rx Path Clk domains. Also contains pipeline stage,
--! Ethernet, IPV4 & UDP header filter stages & Rx Axi4lite MM breakout
--!
--! \includedoc rxpathtop.md
--!
--! ### License ###
--! Copyright(c) 2021 UNITED KINGDOM RESEARCH AND INNOVATION
--! Licensed under the BSD 3-Clause license. See LICENSE file in the project
--! root for details.
-- ---------------------------------------------------------------------------h>
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library udp_core_lib;
use udp_core_lib.udp_core_pkg.all;

library common_stfc_lib;
use common_stfc_lib.common_stfc_pkg.all;

library axi4_lib;
use axi4_lib.axi4lite_pkg.all;
use axi4_lib.axi4s_pkg.all;

use udp_core_lib.axi4lite_udp_core_settings_pkg.all;

entity rx_path_top is
    generic(
        G_FPGA_VENDOR           : string  := "xilinx";                              --! Selects the FPGA Vendor for Compilation
        G_FPGA_FAMILY           : string  := "all";                                 --! Selects the FPGA Family for Compilation
        G_FIFO_IMPLEMENTATION   : string  := "auto";
        G_FIFO_TYPE             : string  := "inferred_mem";                        --! Selects how to implement the Core's FIFOs
        G_UDP_CORE_BYTES        : integer := 8;                                     --! Width of Data Bus In Bytes
        G_RX_IN_FIFO_CAP        : integer := 1024 * 8;                              --! Capacity in bits Of Input FIFO, will always generate to safe value
        G_INC_PING              : boolean := true;                                  --! Generate Ping Logic
        G_INC_ARP               : boolean := true;                                  --! Generate ARP Logic
        G_INC_ETH               : boolean := false;                                 --! Generate Unsupported Ethernet Type Logic
        G_INC_IPV4              : boolean := false                                  --! Generate Unsupported Protocol Type Logic
    );
    port(
        -- UDP Rx Clock and Reset Domain
        rx_core_clk             : in  std_logic;                                    --! Rx Path Main Clock
        rx_core_rst_n           : in  std_logic;                                    --! Rx Path Synchronous Active-Low Reset
        -- Rx Data From PHY:
        rx_in_axi4s_s_aclk      : in  std_logic;                                    --! Rx Clk Out from PHY
        rx_in_axi4s_s_areset_n  : in  std_logic;                                    --! Rx Interface Active Low synchronous reset
        rx_in_axi4s_s_mosi      : in  t_axi4s_mosi;                                 --! Axi4s Ethernet Data In
        rx_in_axi4s_s_miso      : out t_axi4s_miso;                                 --! Axi4s Ethernet Backpressure
        -- Filter Values:
        filter_mac_dst_addr     : in  std_logic_vector(47 downto 0);                --! Filter Destination MAC Address
        filter_mac_src_addr     : in  std_logic_vector(47 downto 0);                --! Filter Source MAC Address
        filter_ip_dst_addr      : in  std_logic_vector(31 downto 0);                --! Filter Destination IP Address
        filter_ip_src_addr      : in  std_logic_vector(31 downto 0);                --! Filter Source IP Address
        filter_port_dst_addr    : in  std_logic_vector(15 downto 0);                --! Filter Destination UDP Port
        filter_port_src_addr    : in  std_logic_vector(15 downto 0);                --! Filter Source UDP Port
        filter_controls         : in  t_axi4lite_udp_core_settings_filter_control;  --! Record Of Filter Controls From MM
        -- UDP AXI4s Out
        udp_axi4s_rx_out_mosi   : out t_axi4s_mosi;                                 --! Axi4s Filtered UDP Payload Data Out
        udp_axi4s_rx_out_miso   : in  t_axi4s_miso;                                 --! Axi4s Filtered UDP Payload Backpressure - Unused
        -- IPV4 Axi4s Out
        ipv4_axi4s_m_mosi       : out t_axi4s_mosi;                                 --! Axi4s Unsupported IPv4 Protocol Data
        ipv4_axi4s_m_miso       : in  t_axi4s_miso;                                 --! Axi4s Unsupported IPv4 Backpressure - Unused
        -- IPV4 Axi4s Out
        eth_axi4s_m_mosi        : out t_axi4s_mosi;                                 --! Axi4s Unsupported Ethernet Type Data
        eth_axi4s_m_miso        : in  t_axi4s_miso;                                 --! Axi4s Unsupported Ethernet Backpressure - Unused
        -- ARP Axi4s Out
        arp_axi4s_m_mosi        : out t_axi4s_mosi;                                 --! Axi4s ARP Data To Tx Path
        arp_axi4s_m_miso        : in  t_axi4s_miso;                                 --! Axi4s ARP Backpressure - Unused
        -- Ping Axi4s Out
        ping_axi4s_m_mosi       : out t_axi4s_mosi;                                 --! Axi4s Ping Data To Tx Path
        ping_axi4s_m_miso       : in  t_axi4s_miso;                                 --! Axi4s Ping Backpressure - Unused
        --Routing Addresses to Allow Ping Replies To Be Formed
        ping_dst_mac_addr_out   : out std_logic_vector(47 downto 0);                --! Ping Dst MAC Address To Tx Path, To Route Replies
        ping_dst_ip_addr_out    : out std_logic_vector(31 downto 0);                --! Ping Dst IP Address To Tx Path, To Route Replies
        ping_dst_addr_en_out    : out std_logic;                                    --! Signal Ping Addresses Are Valid
        --Debug Counts
        udp_count               : out std_logic_vector(31 downto 0);                --! UDP Packet Count
        arp_count               : out std_logic_vector(31 downto 0);                --! ARP Packet Count
        uns_etype_count         : out std_logic_vector(31 downto 0);                --! Other Ethernet Type Packet Count
        ping_count              : out std_logic_vector(31 downto 0);                --! Ping Packet Count
        uns_pro_count           : out std_logic_vector(31 downto 0);                --! Other Protocol Packet Count
        dropped_mac_count       : out std_logic_vector(31 downto 0);                --! Dropped MAC Packet Count
        dropped_ip_count        : out std_logic_vector(31 downto 0);                --! Dropped IP Packet Count
        dropped_port_count      : out std_logic_vector(31 downto 0)                 --! Dropped Port Packet Count
    );
end entity rx_path_top;

architecture struct of rx_path_top is

    constant C_INPUT_FIFO_WIDTH    : integer := udp_maximum(log_2_ceil(G_RX_IN_FIFO_CAP / (G_UDP_CORE_BYTES * 8)), C_FIFO_MIN_WIDTH);
    signal filter_pass_uns_ethtype : std_logic;
    signal filter_arp_en           : std_logic;
    signal filter_broadcast_en     : std_logic;
    signal filter_dst_mac_chk_en   : std_logic;
    signal filter_src_mac_chk_en   : std_logic;
    signal filter_pass_uns_ipv4    : std_logic;
    signal filter_ping_en          : std_logic;
    signal filter_dst_ip_chk_en    : std_logic;
    signal filter_src_ip_chk_en    : std_logic;
    signal filter_dst_port_chk_en  : std_logic;
    signal filter_src_port_chk_en  : std_logic;
    signal filter_strip_uns_pro    : std_logic;
    signal filter_strip_uns_eth    : std_logic;

    signal stage_2_busy         : std_logic;
    signal stage_3_busy         : std_logic;
    signal dst_mac_side_channel : std_logic_vector(47 downto 0);
    signal count_rst_n          : std_logic;

    signal axi4s_ipv4_m_mosi          : t_axi4s_mosi;
    signal axi4s_udp_m_mosi           : t_axi4s_mosi;
    signal axi4s_s_mosi, axi4s_m_mosi : t_axi4s_mosi;
    signal axi4s_s_miso, axi4s_m_miso : t_axi4s_miso;
    signal lower_filters_ready        : std_logic;
    signal filter_chk_ip_length       : std_logic;

begin

    --------------------------------------------------------------------------------
    -- UDP Core Receive Path:
    --------------------------------------------------------------------------------
    filter_broadcast_en     <= filter_controls.broadcast_en;
    filter_arp_en           <= filter_controls.arp_en;
    filter_ping_en          <= filter_controls.ping_en;
    filter_pass_uns_ethtype <= filter_controls.pass_uns_ethtype;
    filter_pass_uns_ipv4    <= filter_controls.pass_uns_ipv4;
    filter_dst_mac_chk_en   <= filter_controls.dst_mac_chk_en;
    filter_src_mac_chk_en   <= filter_controls.src_mac_chk_en;
    filter_dst_ip_chk_en    <= filter_controls.dst_ip_chk_en;
    filter_src_ip_chk_en    <= filter_controls.src_ip_chk_en;
    filter_dst_port_chk_en  <= filter_controls.dst_port_chk_en;
    filter_src_port_chk_en  <= filter_controls.src_port_chk_en;
    count_rst_n             <= filter_controls.packet_count_rst_n;
    filter_strip_uns_pro    <= filter_controls.strip_uns_pro;
    filter_strip_uns_eth    <= filter_controls.strip_uns_eth;
    filter_chk_ip_length    <= filter_controls.chk_ip_length;

    lower_filters_ready <= '1' when G_UDP_CORE_BYTES = 64 else (not stage_2_busy and not stage_3_busy);

    rx_in_fifo_inst : entity axi4_lib.axi4s_fifo
        generic map(
            g_fpga_vendor         => G_FPGA_VENDOR,
            g_fpga_family         => G_FPGA_FAMILY,
            g_implementation      => G_FIFO_IMPLEMENTATION,
            g_dual_clock          => true,
            g_wr_adr_width        => C_INPUT_FIFO_WIDTH,
            g_axi4s_descr         => (tdata_nof_bytes => G_UDP_CORE_BYTES,
                                      tid_width       => 8,
                                      tuser_width     => 1,
                                      has_tlast       => 1,
                                      has_tkeep       => 1,
                                      has_tid         => 1,
                                      has_tuser       => 0),
            g_in_tdata_nof_bytes  => G_UDP_CORE_BYTES,
            g_out_tdata_nof_bytes => G_UDP_CORE_BYTES,
            g_hold_last_read      => false
        )
        port map(
            s_axi_clk    => rx_in_axi4s_s_aclk,
            s_axi_rst_n  => rx_in_axi4s_s_areset_n,
            m_axi_clk    => rx_core_clk,
            m_axi_rst_n  => rx_core_rst_n,
            axi4s_s_mosi => rx_in_axi4s_s_mosi,
            axi4s_s_miso => rx_in_axi4s_s_miso,
            axi4s_m_mosi => axi4s_s_mosi,
            axi4s_m_miso => axi4s_s_miso
        );

    rx_in_pipe_inst : entity udp_core_lib.udp_axi4s_pipe
        generic map(
            G_STAGES       => 2,
            G_BACKPRESSURE => true
        )
        port map(
            axi_clk      => rx_core_clk,
            axi_rst_n    => rx_core_rst_n,
            axi4s_s_mosi => axi4s_s_mosi,
            axi4s_s_miso => axi4s_s_miso,
            axi4s_m_mosi => axi4s_m_mosi,
            axi4s_m_miso => axi4s_m_miso
        );

    filter_stage_1_inst : entity udp_core_lib.rx_filter_stage_1
        generic map(
            G_UDP_CORE_BYTES => G_UDP_CORE_BYTES,
            G_INC_ETH        => G_INC_ETH,
            G_INC_ARP        => G_INC_ARP
        )
        port map(
            udp_core_rx_clk       => rx_core_clk,
            udp_core_rx_rst_s_n   => rx_core_rst_n,
            axi4s_s_mosi          => axi4s_m_mosi,
            axi4s_s_miso          => axi4s_m_miso,
            axi4s_ipv4_m_mosi     => axi4s_ipv4_m_mosi,
            axi4s_arp_m_mosi      => arp_axi4s_m_mosi,
            axi4s_eth_pass_m_mosi => eth_axi4s_m_mosi,
            pass_uns_ethtype      => filter_pass_uns_ethtype,
            strip_uns_etype       => filter_strip_uns_eth,
            broadcast_en          => filter_broadcast_en,
            arp_en                => filter_arp_en,
            dst_mac_chk_en        => filter_dst_mac_chk_en,
            src_mac_chk_en        => filter_src_mac_chk_en,
            mac_src_addr          => filter_mac_dst_addr,
            mac_dst_addr          => filter_mac_src_addr,
            count_rst_n           => count_rst_n,
            arp_count             => arp_count,
            uns_etype_count       => uns_etype_count,
            dropped_mac_count     => dropped_mac_count,
            done                  => lower_filters_ready,
            dst_mac_addr_out      => dst_mac_side_channel
        );

    filter_stage_2_inst : entity udp_core_lib.rx_filter_stage_2
        generic map(
            G_INC_IPV4       => G_INC_IPV4,
            G_INC_PING       => G_INC_PING,
            G_UDP_CORE_BYTES => G_UDP_CORE_BYTES
        )
        port map(
            udp_core_clk           => rx_core_clk,
            udp_core_rst_s_n       => rx_core_rst_n,
            axi4s_ipv4_s_mosi      => axi4s_ipv4_m_mosi,
            axi4s_udp_m_mosi       => axi4s_udp_m_mosi,
            axi4s_ping_m_mosi      => ping_axi4s_m_mosi,
            axi4s_ipv4_pass_m_mosi => ipv4_axi4s_m_mosi,
            ip_src_addr            => filter_ip_dst_addr,
            ip_dst_addr            => filter_ip_src_addr,
            pass_uns_protocol      => filter_pass_uns_ipv4,
            ping_en                => filter_ping_en,
            dst_ip_chk_en          => filter_dst_ip_chk_en,
            src_ip_chk_en          => filter_src_ip_chk_en,
            strip_uns_pro          => filter_strip_uns_pro,
            check_ip_length        => filter_chk_ip_length,
            ping_count             => ping_count,
            uns_pro_count          => uns_pro_count,
            dropped_ip_count       => dropped_ip_count,
            count_rst_n            => count_rst_n,
            ping_dst_mac           => dst_mac_side_channel,
            ping_dst_mac_addr      => ping_dst_mac_addr_out,
            ping_dst_ip_addr       => ping_dst_ip_addr_out,
            ping_dst_addr_en       => ping_dst_addr_en_out,
            busy                   => stage_2_busy
        );

    filter_stage_3_inst : entity udp_core_lib.rx_filter_stage_3
        generic map(
            G_UDP_CORE_BYTES => G_UDP_CORE_BYTES
        )
        port map(
            udp_core_rx_clk          => rx_core_clk,
            udp_core_rx_rst_s_n      => rx_core_rst_n,
            axi4s_udp_full_s_mosi    => axi4s_udp_m_mosi,
            axi4s_udp_payload_m_mosi => udp_axi4s_rx_out_mosi,
            port_src_addr            => filter_port_dst_addr,
            port_dst_addr            => filter_port_src_addr,
            dst_port_chk_en          => filter_dst_port_chk_en,
            src_port_chk_en          => filter_src_port_chk_en,
            udp_count                => udp_count,
            dropped_port_count       => dropped_port_count,
            count_rst_n              => count_rst_n,
            busy                     => stage_3_busy
        );

        --------------------------------------------------------------------------------
        -- End of UDP Core Receive Path
        --------------------------------------------------------------------------------
end architecture struct;
