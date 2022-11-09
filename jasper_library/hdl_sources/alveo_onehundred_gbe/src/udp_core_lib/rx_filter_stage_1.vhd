-----------------------------------------------------------------------------
--! @file rx_filter_stage_1.vhd
--! @page rxfilterstage1page Rx Filter Stage 1
--!
--! \includedoc esdg_stfc_image.md
--!
--! ### Brief ###
--! Reads the Ethernet Header of incoming packets and filters against the MAC
--! Address and Etype Fields, and then removes the Ethernet header. Packets are
--! sorted into IPV4, ARP or Other type outputs, or dropped.
--!
--! \includedoc rxfilterstage1.md
--!
--! ### License ###
--! Copyright(c) 2021 UNITED KINGDOM RESEARCH AND INNOVATION
--! Licensed under the BSD 3-Clause license. See LICENSE file in the project
--! root for details.
-- ---------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library common_stfc_lib;
use common_stfc_lib.common_stfc_pkg.all;

library axi4_lib;
use axi4_lib.axi4s_pkg.all;

library udp_core_lib;
use udp_core_lib.udp_core_pkg.all;

entity rx_filter_stage_1 is
    generic(
        G_UDP_CORE_BYTES        : integer := 8;                         --! Width of Data Bus In Bytes
        G_INC_ETH               : boolean := true;                      --! Include Unsupported Ethernet Type Logic
        G_INC_ARP               : boolean := true                       --! Include ARP Logic
    );
    port(
        udp_core_rx_clk         : in  std_logic;                        --! Rx Path Clock
        udp_core_rx_rst_s_n     : in  std_logic;                        --! Rx Path Active Low synchronous Reset
        --Axi4s Outputs and Inputs
        axi4s_s_mosi            : in  t_axi4s_mosi;                     --! Incoming Axi4s Ethernet Data
        axi4s_s_miso            : out t_axi4s_miso;                     --! Axi4s Ethernet Backpressure
        axi4s_ipv4_m_mosi       : out t_axi4s_mosi;                     --! Filtered IPv4 Data
        axi4s_arp_m_mosi        : out t_axi4s_mosi;                     --! Filtered ARP Data
        axi4s_eth_pass_m_mosi   : out t_axi4s_mosi;                     --! Filtered Unsupported Ethernet Type Data
        -- Filter Settings from UDP Core MM Registers
        pass_uns_ethtype        : in  std_logic;                        --! Forward Packets With an Unsupported Ethernet Type
        strip_uns_etype         : in  std_logic;                        --! Strip The Header Of Unsupported Ethernet Type Packets
        broadcast_en            : in  std_logic;                        --! Allow Non-ARP Broadcast Packets
        arp_en                  : in  std_logic;                        --! Allow ARPs
        dst_mac_chk_en          : in  std_logic;                        --! Check Dst Mac Addr Field of Incoming Packet Against Src In MM
        src_mac_chk_en          : in  std_logic;                        --! Check Src Mac Addr Field of Incoming Packet Against Dst In MM
        mac_src_addr            : in  std_logic_vector(47 downto 0);    --! Source MAC Address to Filter Incoming Ethernet Packets Against
        mac_dst_addr            : in  std_logic_vector(47 downto 0);    --! Destination MAC Address to Filter Incoming Ethernet Packets Against
        --Debugging & Verification
        count_rst_n             : in  std_logic;                        --! Reset Counters
        arp_count               : out std_logic_vector(31 downto 0);    --! Debug ARP packet counter
        uns_etype_count         : out std_logic_vector(31 downto 0);    --! Debug unsupported Ethernet packet counter
        dropped_mac_count       : out std_logic_vector(31 downto 0);    --! Debug dropped MAC address packet counter
        --Other
        done                    : in  std_logic;                        --! Ready Signal From Other Filter Stages
        dst_mac_addr_out        : out std_logic_vector(47 downto 0)     --! Needed To Give Ping Replies The Correct Return Address
    );
end entity rx_filter_stage_1;

architecture fsm of rx_filter_stage_1 is
    --------------------------------------------------------------------------------
    -- Constants:
    --------------------------------------------------------------------------------
    constant C_MAC_HEADER         : integer := 14;
    constant C_HEADER_WORDS       : integer := header_words(C_MAC_HEADER, G_UDP_CORE_BYTES) + 1; --Includes partial words if present
    constant C_HEADER_TOTAL_BYTES : integer := C_HEADER_WORDS * G_UDP_CORE_BYTES;
    constant C_PARTIAL_WORD_SIZE  : integer := C_MAC_HEADER rem G_UDP_CORE_BYTES;

    constant C_WORD_BITS        : integer := G_UDP_CORE_BYTES * 8;
    constant C_RIGHT_SHIFT_BITS : integer := C_PARTIAL_WORD_SIZE * 8;
    constant C_LEFT_SHIFT_BITS  : integer := C_WORD_BITS - C_RIGHT_SHIFT_BITS;

    constant C_HDR_BITS_HIGH : integer := C_HEADER_TOTAL_BYTES * 8;
    constant C_HDR_BITS_LOW  : integer := C_HDR_BITS_HIGH - C_WORD_BITS;

    constant C_EF_TYPE_IP4 : std_logic_vector(15 downto 0) := X"0008";
    constant C_EF_TYPE_ARP : std_logic_vector(15 downto 0) := X"0608";
    constant C_BROAD_MAC   : std_logic_vector(47 downto 0) := (others => '1');

    constant C_PASS_ARP : boolean := G_INC_ETH and not G_INC_ARP;

    type t_rx_1_next_state is (
        idle,
        rx_header,
        rx_sort_packet,
        rx_sort_100g,
        rx_valid_packet,
        rx_pass_packet,
        rx_last_word,
        rx_wait_for_tlast
    );

    --------------------------------------------------------------------------------
    -- Signals:
    --------------------------------------------------------------------------------

    --Delay Shift Registers, Used If Core WIdth Is Less Than Layer 2 Header (14 Bytes)
    signal delay_reg : std_logic_vector(C_HDR_BITS_HIGH - 1 downto 0); --Shift Reg Stores Data While Etype & Filtering Fields are Read/Populated

    --Data & Control, and Header Fields. The Sources Of These Depend on Core Width, Assigned In Generate Statements
    signal dst_mac : std_logic_vector(6 * 8 - 1 downto 0);
    signal src_mac : std_logic_vector(6 * 8 - 1 downto 0);
    signal etype   : std_logic_vector(2 * 8 - 1 downto 0);

    --Axi4s Records Used In Module
    signal axi4s_in_mosi            : t_axi4s_mosi;
    signal axi4s_remove_header_mosi : t_axi4s_mosi;
    signal axi4s_keep_header_mosi   : t_axi4s_mosi;

    --Filtering Signals
    signal packet_ipv4    : std_logic;
    signal packet_arp     : std_logic;
    signal packet_pass    : std_logic;
    signal pass_dst_mac   : std_logic;
    signal pass_src_mac   : std_logic;
    signal pass_broadcast : std_logic;

    --Count Signals for debugging and verification
    signal arp_count_int         : unsigned(31 downto 0);
    signal uns_etype_count_int   : unsigned(31 downto 0);
    signal dropped_mac_count_int : unsigned(31 downto 0);
    signal arp_count_inc         : std_logic;
    signal uns_etype_count_inc   : std_logic;
    signal dropped_mac_count_inc : std_logic;

    --Snapshot of header of packet, used for debugging, never read
    signal header_data : std_logic_vector(C_HDR_BITS_HIGH - 1 downto 0);

    signal extra_word                                           : std_logic;
    signal rx_eng_next_state                                    : t_rx_1_next_state := idle;
    signal prev_eof                                             : std_logic;
    signal prev_last_index                                      : integer range 0 to G_UDP_CORE_BYTES - 1;
    signal arp_flag, ipv4_flag, pass_flag                       : std_logic;
    signal packet_arp_pass, packet_pass_full, packet_pass_strip : std_logic;
    signal axi4s_in_miso_tready                                 : std_logic;
    signal axi4s_in_mosi_tvalid                                 : std_logic;

begin
    axi4s_s_miso.tready  <= axi4s_in_miso_tready;
    axi4s_in_mosi_tvalid <= axi4s_in_mosi.tvalid and axi4s_in_miso_tready;
    axi4s_in_mosi        <= axi4s_s_mosi;

    --Demux valid data by packet type process
    proc_demux_data : process(udp_core_rx_clk)
    begin
        if (rising_edge(udp_core_rx_clk)) then
            if (udp_core_rx_rst_s_n = '0') then
                axi4s_ipv4_m_mosi.tvalid     <= '0';
                axi4s_eth_pass_m_mosi.tvalid <= '0';
                axi4s_arp_m_mosi.tvalid      <= '0';
            else
                if arp_flag = '1' and axi4s_remove_header_mosi.tvalid = '1' then
                    axi4s_arp_m_mosi <= axi4s_remove_header_mosi;
                else
                    axi4s_arp_m_mosi.tvalid <= '0';
                end if;
                if ipv4_flag = '1' and axi4s_remove_header_mosi.tvalid = '1' then
                    axi4s_ipv4_m_mosi <= axi4s_remove_header_mosi;
                else
                    axi4s_ipv4_m_mosi.tvalid <= '0';
                end if;

                if pass_flag = '1' and axi4s_remove_header_mosi.tvalid = '1' then
                    axi4s_eth_pass_m_mosi <= axi4s_remove_header_mosi;
                elsif axi4s_keep_header_mosi.tvalid = '1' then
                    axi4s_eth_pass_m_mosi <= axi4s_keep_header_mosi;
                else
                    axi4s_eth_pass_m_mosi.tvalid <= '0';
                end if;
            end if;
        end if;
    end process;

    --Combinational Filtering
    packet_ipv4       <= '1' when etype = C_EF_TYPE_IP4 else '0';
    packet_arp        <= '1' when etype = C_EF_TYPE_ARP and G_INC_ARP and arp_en = '1' else '0';
    packet_arp_pass   <= '1' when etype = C_EF_TYPE_ARP and C_PASS_ARP and arp_en = '1' else '0';
    packet_pass_full  <= '1' when G_INC_ETH and ((etype /= C_EF_TYPE_ARP and etype /= C_EF_TYPE_IP4) or packet_arp_pass = '1') and pass_uns_ethtype = '1' and strip_uns_etype = '0' else '0';
    packet_pass_strip <= '1' when G_INC_ETH and ((etype /= C_EF_TYPE_ARP and etype /= C_EF_TYPE_IP4) or packet_arp_pass = '1') and pass_uns_ethtype = '1' and strip_uns_etype = '1' else '0';
    pass_dst_mac      <= '1' when dst_mac = mac_dst_addr or dst_mac_chk_en = '0' else '0';
    pass_src_mac      <= '1' when src_mac = mac_src_addr or src_mac_chk_en = '0' else '0';
    pass_broadcast    <= '1' when dst_mac = C_BROAD_MAC and (packet_arp or broadcast_en) = '1' else '0';
    dst_mac           <= header_data(6 * 8 - 1 downto 0);
    src_mac           <= header_data(12 * 8 - 1 downto 6 * 8);
    etype             <= header_data(14 * 8 - 1 downto 12 * 8);

    rx_engine_fsm_proc : process(udp_core_rx_clk)
        variable header_idx_i    : integer range 0 to C_HEADER_TOTAL_BYTES := 0;
        variable trailer_idx_i   : integer;
        variable last_byte_index : integer range 0 to 2 * G_UDP_CORE_BYTES;
    begin
        if (rising_edge(udp_core_rx_clk)) then
            if (udp_core_rx_rst_s_n = '0') then
                header_idx_i                    := 0;
                trailer_idx_i                   := 0;
                axi4s_remove_header_mosi.tvalid <= '0';
                axi4s_keep_header_mosi.tvalid   <= '0';
                axi4s_in_miso_tready            <= '0';
                header_data                     <= (others => '0');
                delay_reg                       <= (others => '0');
                extra_word                      <= '0';
                arp_count_inc                   <= '0';
                uns_etype_count_inc             <= '0';
                dropped_mac_count_inc           <= '0';
                pass_flag                       <= '0';
                arp_flag                        <= '0';
                ipv4_flag                       <= '0';
                rx_eng_next_state               <= idle;
            else
                case rx_eng_next_state is
                    when idle =>
                        header_data                     <= (others => '0');
                        extra_word                      <= '0';
                        header_idx_i                    := 0;
                        trailer_idx_i                   := 0;
                        axi4s_remove_header_mosi.tvalid <= '0';
                        axi4s_keep_header_mosi.tvalid   <= '0';
                        axi4s_in_miso_tready            <= '1';
                        arp_flag                        <= '0';
                        ipv4_flag                       <= '0';
                        pass_flag                       <= '0';
                        delay_reg                       <= (others => '0');
                        arp_count_inc                   <= '0';
                        uns_etype_count_inc             <= '0';
                        dropped_mac_count_inc           <= '0';

                        if axi4s_in_mosi_tvalid = '1' then --SOF
                            if G_UDP_CORE_BYTES >= 32 then
                                prev_eof                           <= axi4s_in_mosi.tlast;
                                prev_last_index                    <= tkeep_to_int(axi4s_in_mosi.tkeep(G_UDP_CORE_BYTES - 1 downto 0));
                                delay_reg(delay_reg'left downto 0) <= axi4s_in_mosi.tdata(G_UDP_CORE_BYTES * 8 - 1 downto 0);
                                header_data                        <= axi4s_in_mosi.tdata(G_UDP_CORE_BYTES * 8 - 1 downto 0);
                                rx_eng_next_state                  <= rx_sort_100g;
                                if axi4s_in_mosi.tlast = '1' then --Stop new data if Single Word Packet
                                    axi4s_in_miso_tready <= '0';
                                end if;
                            elsif C_HEADER_WORDS = 1 then --Header only takes 1 word, sort packet
                                delay_reg(delay_reg'left downto 0) <= axi4s_in_mosi.tdata(G_UDP_CORE_BYTES * 8 - 1 downto 0);
                                header_data                        <= axi4s_in_mosi.tdata(G_UDP_CORE_BYTES * 8 - 1 downto 0);
                                rx_eng_next_state                  <= rx_sort_packet;
                            else        --Header over multiple words
                                delay_reg(delay_reg'left downto 0) <= axi4s_in_mosi.tdata(G_UDP_CORE_BYTES * 8 - 1 downto 0) & delay_reg(delay_reg'left downto C_WORD_BITS); --Store Input Word Delay shift Reg
                                header_idx_i                       := header_idx_i + 1;
                                rx_eng_next_state                  <= rx_header;
                            end if;
                        end if;

                    when rx_header =>
                        if axi4s_in_mosi_tvalid = '1' then --Add Header Words To Shift Reg
                            delay_reg(delay_reg'left downto 0) <= axi4s_in_mosi.tdata(G_UDP_CORE_BYTES * 8 - 1 downto 0) & delay_reg(delay_reg'left downto C_WORD_BITS);
                            header_idx_i                       := header_idx_i + 1;
                            if (header_idx_i = C_HEADER_WORDS) then
                                rx_eng_next_state <= rx_sort_packet; --Sort & Filter When All Header Words Are Available
                                header_data       <= axi4s_in_mosi.tdata(G_UDP_CORE_BYTES * 8 - 1 downto 0) & delay_reg(delay_reg'left downto C_WORD_BITS);
                            end if;
                        else
                            axi4s_remove_header_mosi.tvalid <= '0';
                            axi4s_keep_header_mosi.tvalid   <= '0';
                        end if;

                    when rx_sort_100g =>
                        --Large State Logic as Can Be Any Packet Type, Any Filtering Outcome, and Any Length at this Point
                        if axi4s_in_mosi_tvalid = '1' or prev_eof = '1' then
                            prev_eof                                     <= '0';
                            delay_reg(G_UDP_CORE_BYTES * 8 - 1 downto 0) <= axi4s_in_mosi.tdata(G_UDP_CORE_BYTES * 8 - 1 downto 0);
                            if (packet_ipv4 or packet_arp or packet_pass_strip) = '1' then
                                if ((pass_dst_mac or pass_broadcast) and (pass_src_mac or packet_arp)) = '1' then
                                    dst_mac_addr_out                                         <= src_mac;
                                    ipv4_flag                                                <= packet_ipv4;
                                    arp_flag                                                 <= packet_arp;
                                    pass_flag                                                <= packet_pass_strip;
                                    arp_count_inc                                            <= packet_arp;
                                    axi4s_remove_header_mosi.tdata(C_WORD_BITS - 1 downto 0) <= std_logic_vector(shift_left(unsigned(axi4s_in_mosi.tdata(C_WORD_BITS - 1 downto 0)), C_LEFT_SHIFT_BITS) OR
                                                                                                shift_right(unsigned(delay_reg(delay_reg'left downto C_HDR_BITS_LOW)), C_RIGHT_SHIFT_BITS));
                                    axi4s_remove_header_mosi.tvalid                          <= '1';
                                    axi4s_remove_header_mosi.tlast                           <= '0';
                                    if prev_eof = '1' then --Whole Packet contained In 1 Word
                                        rx_eng_next_state                                             <= rx_last_word;
                                        last_byte_index                                               := prev_last_index - C_PARTIAL_WORD_SIZE;
                                        axi4s_remove_header_mosi.tlast                                <= '1';
                                        axi4s_remove_header_mosi.tkeep(G_UDP_CORE_BYTES - 1 downto 0) <= int_to_tkeep(last_byte_index, G_UDP_CORE_BYTES);
                                    elsif axi4s_in_mosi.tlast = '1' then --Whole Packet Contained In 2 words
                                        last_byte_index := G_UDP_CORE_BYTES + tkeep_to_int(axi4s_in_mosi.tkeep(G_UDP_CORE_BYTES - 1 downto 0)) - C_PARTIAL_WORD_SIZE;
                                        if last_byte_index < G_UDP_CORE_BYTES then
                                            rx_eng_next_state                                             <= rx_last_word;
                                            axi4s_remove_header_mosi.tlast                                <= '1';
                                            axi4s_remove_header_mosi.tkeep(G_UDP_CORE_BYTES - 1 downto 0) <= int_to_tkeep(last_byte_index, G_UDP_CORE_BYTES);
                                        else
                                            extra_word        <= '1';
                                            rx_eng_next_state <= rx_valid_packet;
                                        end if;
                                    else
                                        rx_eng_next_state <= rx_valid_packet; --Not The End Of Packet
                                    end if;
                                else    --Right Packet Type But Failed Address Checks
                                    if (pass_dst_mac = '0' and pass_broadcast = '0') or pass_src_mac = '0' then
                                        dropped_mac_count_inc <= '1';
                                    end if;
                                    axi4s_remove_header_mosi.tvalid <= '0';
                                    axi4s_keep_header_mosi.tvalid   <= '0';
                                    if prev_eof = '1' or axi4s_in_mosi.tlast = '1' then
                                        rx_eng_next_state <= idle;
                                    else
                                        rx_eng_next_state <= rx_wait_for_tlast;
                                    end if;
                                end if;
                            elsif packet_pass_full = '1' then --Unsupported Etype Forwarded On
                                axi4s_keep_header_mosi.tdata(C_WORD_BITS - 1 downto 0) <= delay_reg(C_WORD_BITS - 1 downto 0);
                                axi4s_keep_header_mosi.tvalid                          <= '1';
                                uns_etype_count_inc                                    <= '1';
                                rx_eng_next_state                                      <= rx_pass_packet;
                                if prev_eof = '1' then
                                    axi4s_keep_header_mosi.tlast                                <= '1';
                                    axi4s_keep_header_mosi.tkeep(G_UDP_CORE_BYTES - 1 downto 0) <= int_to_tkeep(last_byte_index, G_UDP_CORE_BYTES);
                                    rx_eng_next_state                                           <= rx_last_word;
                                elsif axi4s_in_mosi.tlast = '1' then
                                    trailer_idx_i     := 1;
                                    last_byte_index   := tkeep_to_int(axi4s_in_mosi.tkeep(G_UDP_CORE_BYTES - 1 downto 0));
                                    rx_eng_next_state <= rx_pass_packet;
                                else
                                    rx_eng_next_state <= rx_pass_packet;
                                end if;
                            else        --Other Packets Ignored
                                if prev_eof = '1' or axi4s_in_mosi.tlast = '1' then
                                    rx_eng_next_state <= idle;
                                else
                                    rx_eng_next_state <= rx_wait_for_tlast;
                                end if;
                                axi4s_remove_header_mosi.tvalid <= '0';
                                axi4s_keep_header_mosi.tvalid   <= '0';
                            end if;
                        end if;

                    when rx_sort_packet =>
                        if axi4s_in_mosi_tvalid = '1' then
                            if C_HEADER_WORDS = 1 then
                                delay_reg(delay_reg'left downto 0) <= axi4s_in_mosi.tdata(G_UDP_CORE_BYTES * 8 - 1 downto 0);
                            else
                                delay_reg(delay_reg'left downto 0) <= axi4s_in_mosi.tdata(G_UDP_CORE_BYTES * 8 - 1 downto 0) & delay_reg(delay_reg'left downto C_WORD_BITS);
                            end if;

                            if (packet_ipv4 or packet_arp or packet_pass_strip) = '1' then
                                if ((pass_dst_mac or pass_broadcast) and (pass_src_mac or packet_arp)) = '1' then
                                    dst_mac_addr_out                <= src_mac;
                                    ipv4_flag                       <= packet_ipv4;
                                    arp_flag                        <= packet_arp;
                                    pass_flag                       <= packet_pass_strip;
                                    arp_count_inc                   <= packet_arp;
                                    axi4s_remove_header_mosi.tvalid <= '1';
                                    rx_eng_next_state               <= rx_valid_packet;
                                    if C_PARTIAL_WORD_SIZE = 0 then --Only Header Data on this word, no byte slip necessary
                                        axi4s_remove_header_mosi.tdata(C_WORD_BITS - 1 downto 0) <= axi4s_in_mosi.tdata(G_UDP_CORE_BYTES * 8 - 1 downto 0);
                                    else --Payload Data As Well
                                        axi4s_remove_header_mosi.tdata(C_WORD_BITS - 1 downto 0) <= std_logic_vector(shift_left(unsigned(axi4s_in_mosi.tdata(C_WORD_BITS - 1 downto 0)), C_LEFT_SHIFT_BITS) OR shift_right(unsigned(delay_reg(delay_reg'left downto C_HDR_BITS_LOW)), C_RIGHT_SHIFT_BITS));
                                    end if;
                                else    --FAILS MAC TESTS
                                    if (pass_dst_mac = '0' and pass_broadcast = '0') or pass_src_mac = '0' then
                                        dropped_mac_count_inc <= '1';
                                    end if;
                                    rx_eng_next_state <= rx_wait_for_tlast;
                                end if;
                            elsif packet_pass_full = '1' then --Unsupported Etype Forwarded On
                                axi4s_keep_header_mosi.tdata(C_WORD_BITS - 1 downto 0) <= delay_reg(C_WORD_BITS - 1 downto 0);
                                axi4s_keep_header_mosi.tvalid                          <= '1';
                                uns_etype_count_inc                                    <= '1';
                                rx_eng_next_state                                      <= rx_pass_packet;
                            else        --Other Packets Ignored
                                rx_eng_next_state               <= rx_wait_for_tlast;
                                axi4s_remove_header_mosi.tvalid <= '0';
                                axi4s_keep_header_mosi.tvalid   <= '0';
                            end if;
                        else
                            axi4s_remove_header_mosi.tvalid <= '0';
                            axi4s_keep_header_mosi.tvalid   <= '0';
                        end if;

                    when rx_valid_packet =>
                        if axi4s_in_mosi_tvalid = '1' or extra_word = '1' then --Continue To Align ARP or IPv4 Data
                            delay_reg(delay_reg'left downto 0) <= axi4s_in_mosi.tdata(C_WORD_BITS - 1 downto 0) & delay_reg(delay_reg'left downto C_WORD_BITS);
                            axi4s_remove_header_mosi.tvalid    <= '1';

                            if C_PARTIAL_WORD_SIZE = 0 then --No SLIP
                                axi4s_remove_header_mosi.tdata(C_WORD_BITS - 1 downto 0) <= axi4s_in_mosi.tdata(C_WORD_BITS - 1 downto 0);
                                if axi4s_in_mosi.tlast = '1' then
                                    axi4s_remove_header_mosi.tkeep(G_UDP_CORE_BYTES - 1 downto 0) <= axi4s_in_mosi.tkeep(G_UDP_CORE_BYTES - 1 downto 0);
                                    axi4s_remove_header_mosi.tlast                                <= '1';
                                    rx_eng_next_state                                             <= rx_last_word;
                                    axi4s_in_miso_tready                                          <= '0';
                                end if;
                            else        --SLIP NEEDED
                                axi4s_remove_header_mosi.tdata(C_WORD_BITS - 1 downto 0) <= std_logic_vector(shift_left(unsigned(axi4s_in_mosi.tdata(C_WORD_BITS - 1 downto 0)), C_LEFT_SHIFT_BITS) OR shift_right(unsigned(delay_reg(delay_reg'left downto C_HDR_BITS_LOW)), C_RIGHT_SHIFT_BITS));
                                if extra_word = '1' then --EOF May Be 1 Cycle Early Due To SLIP, Depending on Last Byte Of PAcket
                                    last_byte_index                                               := last_byte_index - G_UDP_CORE_BYTES;
                                    extra_word                                                    <= '0';
                                    axi4s_remove_header_mosi.tlast                                <= '1';
                                    axi4s_in_miso_tready                                          <= '0';
                                    rx_eng_next_state                                             <= rx_last_word;
                                    axi4s_remove_header_mosi.tkeep(G_UDP_CORE_BYTES - 1 downto 0) <= int_to_tkeep(last_byte_index, G_UDP_CORE_BYTES);
                                elsif axi4s_in_mosi.tlast = '1' then
                                    axi4s_in_miso_tready <= '0';
                                    last_byte_index      := G_UDP_CORE_BYTES + tkeep_to_int(axi4s_in_mosi.tkeep(G_UDP_CORE_BYTES - 1 downto 0)) - C_PARTIAL_WORD_SIZE;
                                    if last_byte_index < G_UDP_CORE_BYTES then
                                        axi4s_remove_header_mosi.tlast                                <= '1';
                                        axi4s_remove_header_mosi.tkeep(G_UDP_CORE_BYTES - 1 downto 0) <= int_to_tkeep(last_byte_index, G_UDP_CORE_BYTES);
                                        rx_eng_next_state                                             <= rx_last_word;
                                    else
                                        extra_word <= '1';
                                    end if;
                                end if;
                            end if;
                        else
                            axi4s_remove_header_mosi.tvalid <= '0';
                        end if;

                    when rx_pass_packet =>
                        uns_etype_count_inc <= '0';
                        if axi4s_in_mosi_tvalid = '1' or trailer_idx_i /= 0 then --Continue To Pass Unsupported Etype Data
                            if C_HEADER_WORDS = 1 then
                                delay_reg(delay_reg'left downto 0) <= axi4s_in_mosi.tdata(C_WORD_BITS - 1 downto 0);
                            else
                                delay_reg(delay_reg'left downto 0) <= axi4s_in_mosi.tdata(C_WORD_BITS - 1 downto 0) & delay_reg(delay_reg'left downto C_WORD_BITS);
                            end if;
                            axi4s_keep_header_mosi.tvalid                          <= '1';
                            axi4s_keep_header_mosi.tdata(C_WORD_BITS - 1 downto 0) <= delay_reg(C_WORD_BITS - 1 downto 0);

                            if axi4s_in_mosi.tlast = '1' and axi4s_in_mosi_tvalid = '1' then
                                axi4s_in_miso_tready <= '0';
                                trailer_idx_i        := 1;
                                last_byte_index      := tkeep_to_int(axi4s_in_mosi.tkeep(G_UDP_CORE_BYTES - 1 downto 0));
                            elsif trailer_idx_i /= 0 then
                                if trailer_idx_i = C_HEADER_WORDS then
                                    axi4s_keep_header_mosi.tlast                                <= '1';
                                    axi4s_keep_header_mosi.tkeep(G_UDP_CORE_BYTES - 1 downto 0) <= int_to_tkeep(last_byte_index, G_UDP_CORE_BYTES);
                                    rx_eng_next_state                                           <= rx_last_word;
                                end if;
                                trailer_idx_i := trailer_idx_i + 1;
                            end if;
                        else
                            axi4s_keep_header_mosi.tvalid <= '0';
                        end if;

                    when rx_last_word =>
                        axi4s_keep_header_mosi.tvalid   <= '0';
                        axi4s_keep_header_mosi.tlast    <= '0';
                        axi4s_remove_header_mosi.tvalid <= '0';
                        axi4s_remove_header_mosi.tlast  <= '0';
                        arp_count_inc                   <= '0';
                        arp_flag                        <= '0';
                        ipv4_flag                       <= '0';
                        pass_flag                       <= '0';
                        uns_etype_count_inc             <= '0';
                        if (done = '1') then
                            rx_eng_next_state    <= idle;
                            axi4s_in_miso_tready <= '1';
                        end if;

                    when rx_wait_for_tlast =>
                        axi4s_keep_header_mosi.tvalid   <= '0';
                        axi4s_remove_header_mosi.tvalid <= '0';
                        dropped_mac_count_inc           <= '0';
                        arp_flag                        <= '0';
                        ipv4_flag                       <= '0';
                        pass_flag                       <= '0';
                        delay_reg                       <= (others => '0');
                        if axi4s_in_mosi.tlast = '1' then
                            rx_eng_next_state <= idle;
                        end if;

                end case;
            end if;
        end if;
    end process rx_engine_fsm_proc;

    --Count Signals & Inc Process For Debugging & Verification
    count_update : process(udp_core_rx_clk)
    begin
        if (rising_edge(udp_core_rx_clk)) then
            if count_rst_n = '1' and udp_core_rx_rst_s_n = '1' then
                if (arp_count_inc = '1') then
                    arp_count_int <= arp_count_int + 1;
                end if;
                if (uns_etype_count_inc = '1') then
                    uns_etype_count_int <= uns_etype_count_int + 1;
                end if;
                if (dropped_mac_count_inc = '1') then
                    dropped_mac_count_int <= dropped_mac_count_int + 1;
                end if;
            else
                uns_etype_count_int   <= (others => '0');
                arp_count_int         <= (others => '0');
                dropped_mac_count_int <= (others => '0');
            end if;
        end if;
    end process;

    arp_count         <= std_logic_vector(arp_count_int);
    uns_etype_count   <= std_logic_vector(uns_etype_count_int);
    dropped_mac_count <= std_logic_vector(dropped_mac_count_int);

end architecture fsm;
