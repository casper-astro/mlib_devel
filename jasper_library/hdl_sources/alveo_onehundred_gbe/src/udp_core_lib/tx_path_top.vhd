-- <h---------------------------------------------------------------------------
--! @file tx_path_top.vhd
--! @page txpathtoppage Tx Path Top
--!
--! \includedoc esdg_stfc_image.md
--!
--! ### Brief ###
--! Top level of the transmit path. Data enters respective handlers, which
--! signal when ready to transmit. A process arbitrates between ready packets,
--! and a module prepares a header, which is slipped with the payload data.
--!
--! \includedoc txpathtop.md
--!
--! ### License ###
--! Copyright(c) 2021 UNITED KINGDOM RESEARCH AND INNOVATION
--! Licensed under the BSD 3-Clause license. See LICENSE file in the project
--! root for details.
--! ---------------------------------------------------------------------------h>

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library udp_core_lib;
use udp_core_lib.udp_core_pkg.all;

library common_stfc_lib;
use common_stfc_lib.common_stfc_pkg.all;

library common_mem_lib;
use common_mem_lib.common_mem_pkg.all;

library axi4_lib;
use axi4_lib.axi4lite_pkg.all;
use axi4_lib.axi4s_pkg.all;

entity tx_path_top is
    generic(
        G_FPGA_VENDOR           : string  := "xilinx";                          --! Selects the FPGA Vendor for Compilation
        G_FPGA_FAMILY           : string  := "all";                             --! Selects the FPGA Family for Compilation
        G_FIFO_IMPLEMENTATION   : string  := "auto";                            --! Selects how the Fitter implements the FIFO Memory
        G_UDP_CORE_BYTES        : natural := 8;                                 --! Width of Data Bus in Bytes
        G_NUM_OF_ARP_POS        : natural := 8;                                 --! Number Of ARP Entry Positions in the LUT
        G_INC_PING              : boolean := true;                              --! Include Ping Logic
        G_INC_ARP               : boolean := true;                              --! Include ARP Logic
        G_TX_BACKPRESSURE       : boolean := false;                             --! Whether Tx Path Needs To Respond To Backpressure
        G_CORE_FREQ_KHZ         : integer := 156250;                            --! Frequency Of Core To Calibrate ARP Timers
        G_TX_EXT_ETH_FIFO_CAP   : integer := (64 * 4 * 8);                      --! Capacity Of External Ethernet Handler FIFOs
        G_TX_EXT_IP_FIFO_CAP    : integer := (64 * 4 * 8);                      --! Capacity Of External IPV4 Handler FIFOs
        G_TX_OUT_FIFO_CAP       : integer := (64 * 4 * 8);                      --! Capacity Of FIFO at Output Of Tx PAth
        G_INC_ETH               : boolean := false;                             --! Generate Logic To Transmit Externally Provided Ethernet Payloads
        G_INC_IPV4              : boolean := false                              --! Generate Logic To Transmit Externally Provided IPV4 Payloads
    );
    port(
        tx_path_clk             : in  std_logic;                                --! General Tx Path Clock
        tx_path_rst_s_n         : in  std_logic;                                --! Active Low Synchronous Reset
        axi4lite_aclk           : in  std_logic;                                --! AXI4-Lite Clock
        axi4lite_aresetn        : in  std_logic;                                --! AXI4-Lite Active-Low Asynchronous Reset
        lut_axi4lite_mosi       : in  t_axi4lite_mosi;                          --! Axi4lite Master For Address LUT
        lut_axi4lite_miso       : out t_axi4lite_miso;                          --! Axi4lite Slave For Address LUT
        arp_axi4lite_mosi       : in  t_axi4lite_mosi;                          --! Axi4lite Master For ARP Control
        arp_axi4lite_miso       : out t_axi4lite_miso;                          --! Axi4lite Slave For ARP Control
        tx_axi4s_m_aclk         : in  std_logic;                                --! Tx PHY Axi4s Clk
        tx_axi4s_m_areset_n     : in  std_logic;                                --! Tx PHY Axi4s Reset
        tx_out_axi4s_s_mosi     : out t_axi4s_mosi;                             --! Axi4s Packet Data Out
        tx_out_axi4s_s_miso     : in  t_axi4s_miso;                             --! Axi4s Packet Backpressure
        udp_axi4s_s_mosi        : in  t_axi4s_mosi;                             --! Axi4s UDP In Data
        udp_axi4s_s_miso        : out t_axi4s_miso;                             --! Axi4s UDP In Backpressure, Used
        ping_axi4s_s_mosi       : in  t_axi4s_mosi;                             --! Axi4s Ping In Data
        ping_axi4s_s_miso       : out t_axi4s_miso;                             --! Axi4s Ping In Backpressre, Feeds FIFO
        arp_axi4s_s_mosi        : in  t_axi4s_mosi;                             --! Axi4s ARP In Data
        arp_axi4s_s_miso        : out t_axi4s_miso;                             --! Axi4s ARP In Backpressure, Feeds FIFO
        ping_addr_s_mosi        : in  t_axi4s_mosi;                             --! Ping Addresses From Rx Path To Route Reply
        ping_addr_s_miso        : out t_axi4s_miso;                             --! Ping Address Backpressure, Feeds FIFO
        --Signals from the axi4lite memory maps
        farm_mode_active        : in  std_logic;                                --! Enables Farm Mode - Routing Packets via LUT entries
        tuser_dst_prt           : in  std_logic;
        tuser_src_prt           : in  std_logic;
        dst_mac_addr            : in  std_logic_vector(47 downto 0);            --! Dst Mac Addr of Core
        src_mac_addr            : in  std_logic_vector(47 downto 0);            --! Src MAC Addr of Core
        dst_ip_addr             : in  std_logic_vector(31 downto 0);            --! Dst IP Addr Of Core
        src_ip_addr             : in  std_logic_vector(31 downto 0);            --! Src IP Addr Of Core
        dst_port_addr           : in  std_logic_vector(15 downto 0);            --! Dst Port Addr Of Core
        src_port_addr           : in  std_logic_vector(15 downto 0);            --! Src Port Addr Of Core
        ifg_val                 : in  std_logic_vector(7 downto 0);             --! Insert additional Interframe gaps between packets
        packet_type             : in  std_logic_vector(15 downto 0);            --! Used to Construct header fields
        ip_ver_hdr_len          : in  std_logic_vector(7 downto 0);             --! Used to Construct header fields
        ip_service              : in  std_logic_vector(7 downto 0);             --! Used to Construct header fields
        ip_ident_count          : in  std_logic_vector(15 downto 0);            --! Used to Construct header fields
        ip_flag_frag            : in  std_logic_vector(15 downto 0);            --! Used to Construct header fields
        ip_time_to_live         : in  std_logic_vector(7 downto 0);             --! Used to Construct header fields
        ip_protocol             : in  std_logic_vector(7 downto 0);             --! Used to Construct header fields
        --Optional Eth Packet AXI4-Stream Slave Side (UDP Core Transmit Data):
        eth_axi4s_s_aclk        : in  std_logic    := '0';                      --! Uns Ethernet Packet Tx In Clk
        eth_axi4s_s_areset_n    : in  std_logic    := '0';                      --! Uns Ethernet Packet Tx In Reset
        eth_axis_s_mosi         : in  t_axi4s_mosi := c_axi4s_mosi_default;   --! Axi4s External Ethernet Data
        eth_axis_s_miso         : out t_axi4s_miso;                             --! Axi4s External Ethernet Backpressure
        -- Optional IPV4 Packet AXI4-Stream Slave Side (UDP Core Transmit Data):
        ipv4_axi4s_s_aclk       : in  std_logic    := '0';                      --! Uns IPV4 Packet Tx In Clk
        ipv4_axi4s_s_areset_n   : in  std_logic    := '0';                      --! Uns IPV4 Packet Tx In Reset
        ipv4_axis_s_mosi        : in  t_axi4s_mosi := c_axi4s_mosi_default;   --! Axi4s External IPV4 Data
        ipv4_axis_s_miso        : out t_axi4s_miso                              --! Axi4s External IPV4 Backpressure
    );
end entity tx_path_top;

architecture behavioral of tx_path_top is

    --CONSTANTS AND SIGNALS
    constant C_FIFO_WIDTH      : integer       := udp_maximum(log_2_ceil(G_TX_OUT_FIFO_CAP / (8 * G_UDP_CORE_BYTES)), C_FIFO_MIN_WIDTH);
    constant C_FIFO_CAPACITY   : integer       := 2**C_FIFO_WIDTH; --Capacity in data words
    constant C_PACKET_BYTES    : integer       := 64;
    constant C_PACKET_WORDS    : integer       := sel_if_true(G_TX_BACKPRESSURE, C_PACKET_BYTES / G_UDP_CORE_BYTES + 4, 2);
    constant C_PROG_FULL_VAL   : integer       := C_FIFO_CAPACITY - C_PACKET_WORDS;
    constant C_1G_DELAY_INSERT : integer       := 18; --Delay Introduced At 1G to Acieve Min IFG
    constant C_OUT_FIFO_DESC   : t_axi4s_descr := (tdata_nof_bytes => G_UDP_CORE_BYTES,
                                                   tid_width       => 8,
                                                   tuser_width     => 1,
                                                   has_tlast       => 1,
                                                   has_tkeep       => 1,
                                                   has_tid         => 0,
                                                   has_tuser       => 0);

    type t_tx_path_next_state is (
        idle,
        waiting,
        delay
    );
    signal tx_path_top_next_state                     : t_tx_path_next_state := idle;
    signal axi4s_udp_payload_mosi, axi4s_payload_mosi : t_axi4s_mosi;
    signal axi4s_arp_payload_mosi                     : t_axi4s_mosi;
    signal axi4s_arp_payload_miso                     : t_axi4s_miso;
    signal axi4s_ping_payload_mosi                    : t_axi4s_mosi;
    signal axi4s_ping_payload_miso                    : t_axi4s_miso;
    signal axi4s_header_mosi                          : t_axi4s_mosi;
    signal axi4s_header_miso                          : t_axi4s_miso;
    signal axi4s_aligned_miso                         : t_axi4s_miso;
    signal axi4s_aligned_mosi                         : t_axi4s_mosi;
    signal axi4s_eth_payload_mosi                     : t_axi4s_mosi;
    signal axi4s_ipv4_payload_mosi                    : t_axi4s_mosi;
    signal udp_rdy                                    : std_logic;
    signal arp_rdy                                    : std_logic;
    signal ping_rdy                                   : std_logic;
    signal ip_length                                  : std_logic_vector(15 downto 0);
    signal udp_length                                 : std_logic_vector(15 downto 0);
    signal type_frame                                 : std_logic_vector(3 downto 0);
    signal arp_done                                   : std_logic;
    signal ping_done                                  : std_logic;
    signal arbitrator_rdy                             : std_logic            := '0';
    signal finished                                   : std_logic;
    signal ping_dst_mac                               : std_logic_vector(47 downto 0);
    signal ip_ping_length                             : std_logic_vector(15 downto 0);
    signal udp_start_data                             : std_logic;
    signal arp_start_data                             : std_logic;
    signal ping_start_data                            : std_logic;
    signal arp_dst_mac_addr                           : std_logic_vector(6 * 8 - 1 downto 0);
    signal arp_lut_addr                               : std_logic_vector(7 downto 0);
    signal lut_pos_from_data                          : std_logic_vector(7 downto 0);
    signal lut_pos_reading                            : std_logic_vector(7 downto 0);
    signal lut_dst_mac_addr                           : std_logic_vector(47 downto 0);
    signal lut_dst_ip_addr                            : std_logic_vector(31 downto 0);
    signal lut_port_addr                              : std_logic_vector(31 downto 0);
    signal arp_read_lut                               : std_logic;
    signal arp_write_lut                              : std_logic;
    signal lower_mac_addr_wr                          : std_logic_vector(31 downto 0);
    signal upper_mac_addr_wr                          : std_logic_vector(15 downto 0);
    signal lut_dst_port_addr                          : std_logic_vector(15 downto 0);
    signal ping_ip_dst_addr                           : std_logic_vector(31 downto 0);
    signal udp_preparing                              : std_logic;
    signal ipv4_rdy                                   : std_logic;
    signal ipv4_start_data                            : std_logic;
    signal pass_ipv4_protocol                         : std_logic_vector(7 downto 0);
    signal pass_ipv4_length                           : std_logic_vector(15 downto 0);
    signal pass_ipv4_tuser                            : std_logic_vector(24 - 1 downto 0);
    signal eth_rdy                                    : std_logic;
    signal eth_start_data                             : std_logic;
    signal pass_eth_tuser                             : std_logic_vector(16 - 1 downto 0);
    signal pass_eth_etype                             : std_logic_vector(16 - 1 downto 0);
    signal tx_path_pause, tx_path_pause_reg           : std_logic;
    signal ifg_extra_delays                           : integer range 0 to 255;
    signal delay_count                                : integer range 0 to 255;
    signal finished_1g                                : std_logic;
    signal inserting_delay_1g                         : std_logic;
    signal finish_count_1g                            : integer range 0 to C_1G_DELAY_INSERT - 1;
    signal udp_tuser_out                              : std_logic_vector(31 downto 0);
    signal udp_tuser_src_prt, udp_tuser_dst_prt       : std_logic_vector(15 downto 0);
    signal dst_port_addr_in, src_port_addr_in         : std_logic_vector(15 downto 0);
    signal port_dst_mux_pipe, port_src_mux_pipe       : std_logic_vector(1 downto 0);
    signal farm_mode_en_pipe                          : std_logic_vector(1 downto 0);
    signal farm_mode_en : std_logic;



begin

    -- Double Register Control Signals from Slow Clk domain
    metastab_proc : process(tx_path_clk) begin
        if rising_edge(tx_path_clk) then
            farm_mode_en_pipe <= farm_mode_active & farm_mode_en_pipe(farm_mode_en_pipe'left downto 1);
            port_dst_mux_pipe <= tuser_dst_prt & port_dst_mux_pipe(port_dst_mux_pipe'left downto 1);
            port_src_mux_pipe <= tuser_src_prt & port_src_mux_pipe(port_src_mux_pipe'left downto 1);
        end if;
    end process;

    farm_mode_en <= farm_mode_en_pipe(0);
    udp_tuser_dst_prt <= udp_tuser_out(15 downto 0);
    udp_tuser_src_prt <= udp_tuser_out(31 downto 16);
    dst_port_addr_in <= dst_port_addr when port_dst_mux_pipe(0) = '0' else byte_reverse(udp_tuser_dst_prt);
    src_port_addr_in <= src_port_addr when port_src_mux_pipe(0) = '0' else byte_reverse(udp_tuser_src_prt);
    lut_dst_port_addr <= lut_port_addr(15 downto 0);
    ifg_extra_delays  <= to_integer(unsigned(ifg_val));

    --Module Reads and Writes to Farm mode LUT
    tx_lut_poller_inst : entity udp_core_lib.tx_path_farm_mode_poller
        port map(
            clk               => tx_path_clk,
            axi4lite_aclk     => axi4lite_aclk,
            axi4lite_aresetn  => axi4lite_aresetn,
            axi4lite_mosi     => lut_axi4lite_mosi,
            axi4lite_miso     => lut_axi4lite_miso,
            header_lut_addr   => lut_pos_from_data,
            arp_lut_addr      => arp_lut_addr,
            arp_read_data     => arp_read_lut,
            arp_write_data    => arp_write_lut,
            current_pos       => lut_pos_reading,
            lower_mac_addr_in => lower_mac_addr_wr,
            upper_mac_addr_in => upper_mac_addr_wr,
            mac_addr_out      => lut_dst_mac_addr,
            ip_addr_out       => lut_dst_ip_addr,
            port_out          => lut_port_addr
        );

    --Constructs a Header for the various packet types
    tx_header_constructor_inst : entity udp_core_lib.tx_header_constructor
        generic map(
            G_UDP_CORE_BYTES => G_UDP_CORE_BYTES
        )
        port map(
            ext_ipv4_protocol     => pass_ipv4_protocol,
            ext_ipv4_length       => pass_ipv4_length,
            ext_eth_etype         => pass_eth_etype,
            clk                   => tx_path_clk,
            rst_s_n               => tx_path_rst_s_n,
            packet_type           => packet_type,
            ip_ver_hdr_len        => ip_ver_hdr_len,
            ip_service            => ip_service,
            ip_ident_count        => ip_ident_count,
            ip_flag_frag           => ip_flag_frag,
            ip_time_to_live       => ip_time_to_live,
            ip_protocol           => ip_protocol,
            udp_preparing         => udp_preparing,
            tx_type               => type_frame,
            arbitrator_rdy        => arbitrator_rdy,
            dst_mac_addr          => dst_mac_addr,
            src_mac_addr          => src_mac_addr,
            dst_ip_addr           => dst_ip_addr,
            src_ip_addr           => src_ip_addr,
            dst_port_addr         => dst_port_addr_in,
            src_port_addr         => src_port_addr_in,
            ping_dst_mac_addr     => ping_dst_mac,
            ping_ip_dst_addr      => ping_ip_dst_addr,
            arp_dst_mac_addr      => arp_dst_mac_addr,
            lut_dst_mac_addr      => byte_reverse(lut_dst_mac_addr),
            lut_dst_ip_addr       => byte_reverse(lut_dst_ip_addr),
            lut_dst_port_addr     => byte_reverse(lut_dst_port_addr),
            farm_mode             => farm_mode_en,
            lut_pos_from_data     => lut_pos_from_data,
            lut_pos_reading       => lut_pos_reading,
            ip_length             => ip_length,
            ip_ping_length        => ip_ping_length,
            udp_length            => udp_length,
            axi4s_header_out_mosi => axi4s_header_mosi,
            axi4s_header_out_miso => axi4s_header_miso,
            udp_start_data        => udp_start_data,
            arp_start_data        => arp_start_data,
            ping_start_data       => ping_start_data,
            ipv4_start_data       => ipv4_start_data,
            eth_start_data        => eth_start_data
        );

    --Handles incoming UDP data and stores in a FIFO, so lengths can be calculated
    tx_path_udp_inst : entity udp_core_lib.tx_udp_handler
        generic map(
            G_FPGA_VENDOR         => G_FPGA_VENDOR,
            G_FPGA_FAMILY         => G_FPGA_FAMILY,
            G_FIFO_IMPLEMENTATION => G_FIFO_IMPLEMENTATION,
            G_UDP_CORE_BYTES      => G_UDP_CORE_BYTES
        )
        port map(
            udp_preparing     => udp_preparing,
            clk               => tx_path_clk,
            rst_s_n           => tx_path_rst_s_n,
            axi4s_udp_s_mosi  => udp_axi4s_s_mosi,
            axi4s_udp_s_miso  => udp_axi4s_s_miso,
            udp_rdy           => udp_rdy,
            farm_mode_pos_out => lut_pos_from_data,
            udp_tuser_out     => udp_tuser_out,
            udp_payload_mosi  => axi4s_udp_payload_mosi,
            pause_data        => tx_path_pause_reg,
            udp_start         => udp_start_data,
            ip_length         => ip_length,
            udp_length        => udp_length
        );

    gen_ping : if G_INC_PING generate
        --Handles ping packets
        tx_path_ping_inst : entity udp_core_lib.tx_ping_handler
            generic map(
                G_FPGA_VENDOR         => G_FPGA_VENDOR,
                G_FPGA_FAMILY         => G_FPGA_FAMILY,
                G_FIFO_IMPLEMENTATION => G_FIFO_IMPLEMENTATION,
                G_UDP_CORE_BYTES      => G_UDP_CORE_BYTES
            )
            port map(
                tx_ping_addr_miso => ping_addr_s_miso,
                tx_ping_addr_mosi => ping_addr_s_mosi,
                ping_dst_ip_out   => ping_ip_dst_addr,
                clk               => tx_path_clk,
                rst_s_n           => tx_path_rst_s_n,
                tx_ping_s_mosi    => ping_axi4s_s_mosi,
                tx_ping_s_miso    => ping_axi4s_s_miso,
                ping_rdy          => ping_rdy,
                ping_done         => ping_done,
                ping_start        => ping_start_data,
                ping_dst_mac_out  => ping_dst_mac,
                tx_ping_m_mosi    => axi4s_ping_payload_mosi,
                tx_ping_m_miso    => axi4s_ping_payload_miso,
                ip_length         => ip_ping_length
            );
    end generate;
    gen_no_ping : if not G_INC_PING generate
        ping_rdy  <= '0';
        ping_done <= '0';
    end generate;

    gen_arp : if G_INC_ARP generate
        --Handles ARP requests and replies, outputs signals to update the relevant LUT position
        tx_path_arp_inst : entity udp_core_lib.tx_arp_handler
            generic map(
                G_NUM_OF_POS          => G_NUM_OF_ARP_POS,
                G_FPGA_VENDOR         => G_FPGA_VENDOR,
                G_FPGA_FAMILY         => G_FPGA_FAMILY,
                G_FIFO_IMPLEMENTATION => G_FIFO_IMPLEMENTATION,
                G_UDP_CORE_BYTES      => G_UDP_CORE_BYTES,
                G_CORE_FREQ_KHZ       => G_CORE_FREQ_KHZ
            )
            port map(
                axi4lite_aclk     => axi4lite_aclk,
                axi4lite_aresetn  => axi4lite_aresetn,
                clk               => tx_path_clk,
                rst_s_n           => tx_path_rst_s_n,
                tx_arp_s_mosi     => arp_axi4s_s_mosi,
                tx_arp_s_miso     => arp_axi4s_s_miso,
                arp_rdy           => arp_rdy,
                arp_done          => arp_done,
                arp_start         => arp_start_data,
                core_mac_addr     => src_mac_addr,
                core_ip_addr      => src_ip_addr,
                lut_ip_addr       => lut_dst_ip_addr,
                mac_addr_out      => arp_dst_mac_addr,
                tx_arp_m_mosi     => axi4s_arp_payload_mosi,
                tx_arp_m_miso     => axi4s_arp_payload_miso,
                arp_axi4lite_mosi => arp_axi4lite_mosi,
                arp_axi4lite_miso => arp_axi4lite_miso,
                arp_lut_addr      => arp_lut_addr,
                arp_read_lut      => arp_read_lut,
                arp_write_lut     => arp_write_lut,
                lower_mac_addr_wr => lower_mac_addr_wr,
                upper_mac_addr_wr => upper_mac_addr_wr
            );
    end generate;
    gen_no_arp : if not G_INC_ARP generate
        arp_rdy       <= '0';
        arp_done      <= '0';
        arp_read_lut  <= '0';
        arp_write_lut <= '0';
    end generate;

    --Handles other IPv4 Protocol Packets (ie. other than UDP and Pings)
    gen_tx_ipv4_packet : if G_INC_IPV4 generate
        tx_path_ipv4_inst : entity udp_core_lib.tx_pass_in_handler
            generic map(
                G_TUSER_WIDTH         => 24,
                G_TID_WIDTH           => 8,
                G_FPGA_VENDOR         => G_FPGA_VENDOR,
                G_FPGA_FAMILY         => G_FPGA_FAMILY,
                G_FIFO_IMPLEMENTATION => G_FIFO_IMPLEMENTATION,
                G_UDP_CORE_BYTES      => G_UDP_CORE_BYTES,
                G_EXT_FIFO_CAP        => G_TX_EXT_IP_FIFO_CAP
            )
            port map(
                payload_in_clk        => ipv4_axi4s_s_aclk,
                payload_in_rst_n      => ipv4_axi4s_s_areset_n,
                core_clk              => tx_path_clk,
                core_rst_s_n          => tx_path_rst_s_n,
                payload_in_axi4s_mosi => ipv4_axis_s_mosi,
                payload_in_axi4s_miso => ipv4_axis_s_miso,
                pass_in_rdy           => ipv4_rdy,
                start_frame           => ipv4_start_data,
                pass_tid              => open,
                pass_tuser            => pass_ipv4_tuser,
                payload_out_mosi      => axi4s_ipv4_payload_mosi
            );
    end generate;

    --Handles other Ethernet Type PAckets (ie. other than IPv4 and ARPs)
    gen_tx_eth_packet : if G_INC_ETH generate
        tx_path_eth_inst : entity udp_core_lib.tx_pass_in_handler
            generic map(
                G_TUSER_WIDTH         => 16,
                G_TID_WIDTH           => 8,
                G_FPGA_VENDOR         => G_FPGA_VENDOR,
                G_FPGA_FAMILY         => G_FPGA_FAMILY,
                G_FIFO_IMPLEMENTATION => G_FIFO_IMPLEMENTATION,
                G_UDP_CORE_BYTES      => G_UDP_CORE_BYTES,
                G_EXT_FIFO_CAP        => G_TX_EXT_ETH_FIFO_CAP
            )
            port map(
                payload_in_clk        => eth_axi4s_s_aclk,
                payload_in_rst_n      => eth_axi4s_s_areset_n,
                core_clk              => tx_path_clk,
                core_rst_s_n          => tx_path_rst_s_n,
                payload_in_axi4s_mosi => eth_axis_s_mosi,
                payload_in_axi4s_miso => eth_axis_s_miso,
                pass_in_rdy           => eth_rdy,
                start_frame           => eth_start_data,
                pass_tid              => open,
                pass_tuser            => pass_eth_tuser,
                payload_out_mosi      => axi4s_eth_payload_mosi
            );
    end generate;

    --These are used to provide additional sidechannel information to construct the external packet headers
    pass_ipv4_protocol <= pass_ipv4_tuser(7 downto 0);
    pass_ipv4_length   <= pass_ipv4_tuser(15 downto 8) & pass_ipv4_tuser(23 downto 16);
    pass_eth_etype     <= pass_eth_tuser(7 downto 0) & pass_eth_tuser(15 downto 8);

    --Multiplex payload data to header & data slip depending on active packet type
    with type_frame select axi4s_payload_mosi <=
        axi4s_udp_payload_mosi when "0000",
        axi4s_arp_payload_mosi when "0001",
                    axi4s_ping_payload_mosi when "0010",
                    axi4s_ipv4_payload_mosi when "0011",
                    axi4s_eth_payload_mosi  when "0100",
                    axi4s_ping_payload_mosi when others;

    --Packet has finished sending
    finished <= axi4s_payload_mosi.tlast and axi4s_payload_mosi.tvalid when G_UDP_CORE_BYTES /= 1 else finished_1g;

    --Additional process for 1GbE to ensure 12Byte IFG between packets
    gen_1g_delay : if G_UDP_CORE_BYTES = 1 generate
        delay_finish_proc : process(tx_path_clk)
        begin
            if rising_edge(tx_path_clk) then
                if tx_path_rst_s_n = '0' then
                    inserting_delay_1g <= '0';
                    finished_1g        <= '0';
                else
                    finished_1g <= '0';
                    if axi4s_aligned_mosi.tlast = '1' and axi4s_aligned_mosi.tvalid = '1' then
                        finish_count_1g    <= 1;
                        inserting_delay_1g <= '1';
                    elsif inserting_delay_1g = '1' then
                        finish_count_1g <= (finish_count_1g + 1) mod C_1G_DELAY_INSERT;
                        if finish_count_1g = C_1G_DELAY_INSERT - 1 then
                            finished_1g        <= '1';
                            inserting_delay_1g <= '0';
                        end if;
                    end if;
                end if;
            end if;
        end process;
    end generate;

    --Aligns Payload and Header Data to form full packet
    tx_path_byte_align_inst : entity udp_core_lib.tx_byte_slip
        generic map(
            G_FPGA_VENDOR         => G_FPGA_VENDOR,
            G_FPGA_FAMILY         => G_FPGA_FAMILY,
            G_FIFO_IMPLEMENTATION => G_FIFO_IMPLEMENTATION,
            G_UDP_CORE_BYTES      => G_UDP_CORE_BYTES
        )
        port map(
            clk           => tx_path_clk,
            rst_s_n       => tx_path_rst_s_n,
            header_data   => axi4s_header_mosi.tdata(G_UDP_CORE_BYTES * 8 - 1 downto 0),
            header_last   => axi4s_header_mosi.tlast,
            header_valid  => axi4s_header_mosi.tvalid,
            payload_data  => axi4s_payload_mosi.tdata(G_UDP_CORE_BYTES * 8 - 1 downto 0),
            payload_keep  => axi4s_payload_mosi.tkeep(G_UDP_CORE_BYTES - 1 downto 0),
            payload_last  => axi4s_payload_mosi.tlast,
            payload_valid => axi4s_payload_mosi.tvalid,
            out_data      => axi4s_aligned_mosi.tdata(G_UDP_CORE_BYTES * 8 - 1 downto 0),
            out_keep      => axi4s_aligned_mosi.tkeep(G_UDP_CORE_BYTES - 1 downto 0),
            out_last      => axi4s_aligned_mosi.tlast,
            out_valid     => axi4s_aligned_mosi.tvalid,
            type_frame    => type_frame
        );

    tx_out_fifo_inst : entity axi4_lib.axi4s_fifo
        generic map(
            g_fpga_vendor         => G_FPGA_VENDOR,
            g_fpga_family         => G_FPGA_FAMILY,
            g_implementation      => G_FIFO_IMPLEMENTATION,
            g_dual_clock          => true,
            g_wr_adr_width        => C_FIFO_WIDTH,
            g_axi4s_descr         => C_OUT_FIFO_DESC,
            g_in_tdata_nof_bytes  => G_UDP_CORE_BYTES,
            g_out_tdata_nof_bytes => G_UDP_CORE_BYTES,
            g_hold_last_read      => false,
            g_prog_full_val       => C_PROG_FULL_VAL
        )
        port map(
            s_axi_clk    => tx_path_clk,
            s_axi_rst_n  => tx_path_rst_s_n,
            m_axi_clk    => tx_axi4s_m_aclk,
            m_axi_rst_n  => tx_axi4s_m_areset_n,
            axi4s_s_mosi => axi4s_aligned_mosi,
            axi4s_s_miso => axi4s_aligned_miso,
            axi4s_m_mosi => tx_out_axi4s_s_mosi,
            axi4s_m_miso => tx_out_axi4s_s_miso
        );
    tx_path_pause <= (not axi4s_aligned_miso.tready) or axi4s_aligned_miso.prog_full when G_TX_BACKPRESSURE else not axi4s_aligned_miso.tready;

    --Packet arbitation state machine process
    tx_path_top_fsm_proc : process(tx_path_clk)
    begin
        if (rising_edge(tx_path_clk)) then
            if (tx_path_rst_s_n = '0') then
                tx_path_top_next_state <= idle;
                arbitrator_rdy         <= '0';
                tx_path_pause_reg      <= '0';

            else
                tx_path_pause_reg <= tx_path_pause;

                case tx_path_top_next_state is
                    when idle =>
                        if tx_path_pause_reg = '0' then
                            if (udp_rdy = '1') then
                                type_frame             <= X"0";
                                arbitrator_rdy         <= '1';
                                tx_path_top_next_state <= waiting;
                            elsif (arp_rdy = '1' and G_INC_ARP) then
                                type_frame             <= X"1";
                                arbitrator_rdy         <= '1';
                                tx_path_top_next_state <= waiting;
                            elsif (ping_rdy = '1' and G_INC_PING) then
                                type_frame             <= X"2";
                                arbitrator_rdy         <= '1';
                                tx_path_top_next_state <= waiting;
                            elsif ipv4_rdy = '1' and G_INC_IPV4 then
                                type_frame             <= X"3";
                                arbitrator_rdy         <= '1';
                                tx_path_top_next_state <= waiting;
                            elsif eth_rdy = '1' and G_INC_ETH then
                                type_frame             <= X"4";
                                arbitrator_rdy         <= '1';
                                tx_path_top_next_state <= waiting;
                            else
                                arbitrator_rdy <= '0';
                            end if;
                        end if;

                    when waiting =>
                        arbitrator_rdy <= '0';
                        if finished = '1' and ifg_extra_delays = 0 then
                            arbitrator_rdy         <= '0';
                            tx_path_top_next_state <= idle;
                        elsif finished = '1' and ifg_extra_delays /= 0 then
                            arbitrator_rdy         <= '0';
                            delay_count            <= 0;
                            tx_path_top_next_state <= delay;
                        end if;

                    when delay =>
                        if delay_count + 1 = ifg_extra_delays or ifg_extra_delays = 0 then
                            arbitrator_rdy         <= '0';
                            delay_count            <= 0;
                            tx_path_top_next_state <= idle;
                        else
                            delay_count <= delay_count + 1;
                        end if;

                end case;
            end if;
        end if;
    end process;

end architecture behavioral;
