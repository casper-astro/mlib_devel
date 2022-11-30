--------------------------------------------------------------------------------
--! @file   rx_filter_stage_2.vhd
--! @page rxfilterstage2page Rx Filter Stage 2
--!
--! \includedoc esdg_stfc_image.md
--!
--! ## Brief ##
--! Filters Against IPV4 Protocol and Address Fields & Removes the IPV4 Header.
--! Packets are sorted into UDP, Ping or Other Axi4s outputs, or dropped. Has
--! the option to cut packets off after the IPV4 length to remove padding.
--!
--! \includedoc rxfilterstage2.md
--!
--! ### License ###
--! Copyright(c) 2021 UNITED KINGDOM RESEARCH AND INNOVATION
--! Licensed under the BSD 3-Clause license. See LICENSE file in the project
--! root for details.
-- -----------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library common_stfc_lib;
use common_stfc_lib.common_stfc_pkg.all;

library axi4_lib;
use axi4_lib.axi4s_pkg.all;

library udp_core_lib;
use udp_core_lib.udp_core_pkg.all;

entity rx_filter_stage_2 is
    generic(
        G_UDP_CORE_BYTES        : integer := 8;                         --! Width of Data Bus In Bytes
        G_INC_IPV4              : boolean := true;                      --! Include Unsupported Ethernet Type Logic
        G_INC_PING              : boolean := true                       --! Include ARP Logic
    );
    port(
        udp_core_clk            : in  std_logic;                        --! Rx Path Clk
        udp_core_rst_s_n        : in  std_logic;                        --! Rx Path Synchronous Reset
        --Axi4s Inputs and Outputs
        axi4s_ipv4_s_mosi       : in  t_axi4s_mosi;                     --! Input IPV4 Axi4s Bus
        axi4s_udp_m_mosi        : out t_axi4s_mosi;                     --! Output UDP Axi4s Bus
        axi4s_ping_m_mosi       : out t_axi4s_mosi;                     --! Output Ping Axi4s Bus
        axi4s_ipv4_pass_m_mosi  : out t_axi4s_mosi;                     --! Output Unsupported Protocol Axi4s Bus
        -- Filter Settings from UDP Core Registers
        ip_src_addr             : in  std_logic_vector(31 downto 0);    --! Src Ip Addr Of Incoming Packet, assigned from Dst Axi4lite MM field
        ip_dst_addr             : in  std_logic_vector(31 downto 0);    --! Dst Ip Addr Of Incoming Packet, assigned from Src Axi4lite MM field
        pass_uns_protocol       : in  std_logic;                        --! Enables Pass Unsupported Protocol
        ping_en                 : in  std_logic;                        --! Enables Pings
        dst_ip_chk_en           : in  std_logic;                        --! Enables Dst Ip Addr Checks
        src_ip_chk_en           : in  std_logic;                        --! Enables Src Ip Addr Checks
        strip_uns_pro           : in  std_logic := '1';                 --! Whether To Keep Or Strip Header Of Unsopported Protocol Packets
        check_ip_length         : in  std_logic;
        --Debugging & Verification
        ping_count              : out std_logic_vector(31 downto 0);    --! Counts number of ping packets passed
        uns_pro_count           : out std_logic_vector(31 downto 0);    --! Counts number of unsupported protocol packets passed
        dropped_ip_count        : out std_logic_vector(31 downto 0);    --! Counts of dropped IP Packets
        count_rst_n             : in  std_logic;                        --! Reset Counters
        --Other
        ping_dst_mac            : in  std_logic_vector(47 downto 0);    --! Dst Mac Address From Filter Stage 1 To Route Ping Replies
        ping_dst_mac_addr       : out std_logic_vector(47 downto 0);    --! Dst Mac Address To Tx Path To Route Ping Replies
        ping_dst_ip_addr        : out std_logic_vector(31 downto 0);    --! Dst IP Address To Tx Path To Route Ping Replies
        ping_dst_addr_en        : out std_logic;                        --! Ping Dst Addresses Are Valid
        busy                    : out std_logic                         --! Prevents Filter 1 From Accepting New Packets When High
    );
end entity rx_filter_stage_2;

architecture fsm of rx_filter_stage_2 is
    --------------------------------------------------------------------------------
    -- Constants:
    --------------------------------------------------------------------------------

    constant C_IP_HEADER           : integer                      := 20;
    constant C_HEADER_WORDS        : integer                      := header_words(C_IP_HEADER, G_UDP_CORE_BYTES) + 1; --Includes partial words if present
    constant C_HEADER_TOTAL_BYTES  : integer                      := C_HEADER_WORDS * G_UDP_CORE_BYTES;
    constant C_PARTIAL_WORD_SIZE   : integer                      := C_IP_HEADER rem G_UDP_CORE_BYTES;
    constant C_WORD_BITS           : integer                      := G_UDP_CORE_BYTES * 8;
    constant C_RIGHT_SHIFT_BITS    : integer                      := C_PARTIAL_WORD_SIZE * 8;
    constant C_LEFT_SHIFT_BITS     : integer                      := C_WORD_BITS - C_RIGHT_SHIFT_BITS;
    constant C_PROTOCOL_UDP        : std_logic_vector(7 downto 0) := X"11";
    constant C_PROTOCOL_PING       : std_logic_vector(7 downto 0) := X"01";
    constant C_PASS_PING           : boolean                      := G_INC_IPV4 and not G_INC_PING;
    constant C_MAX_IP_LENGTH_FIELD : integer                      := C_MAX_PAYLOAD_SIZE + 20 + 8;

    --------------------------------------------------------------------------------
    -- States:
    --------------------------------------------------------------------------------
    type t_rx_2_next_state is (
        idle,
        rx_header,
        rx_sort_packet,
        rx_sort_100g,
        rx_valid_data,
        rx_pass_data,
        rx_last_word,
        rx_wait_for_tlast
    );

    --------------------------------------------------------------------------------
    -- Signals:
    --------------------------------------------------------------------------------

    --Data & Control, and Header Fields
    signal ping_dst_mac_int : std_logic_vector(47 downto 0);
    signal dst_ip_addr      : std_logic_vector(31 downto 0);
    signal src_ip_addr      : std_logic_vector(31 downto 0);
    signal protocol         : std_logic_vector(7 downto 0);
    signal total_length     : std_logic_vector(15 downto 0);

    --Filtering Signals
    signal pass_src_ip       : std_logic;
    signal pass_dst_ip       : std_logic;
    signal packet_udp        : std_logic;
    signal packet_ping       : std_logic;
    signal packet_pass_full  : std_logic;
    signal packet_pass_strip : std_logic;
    signal packet_ping_pass  : std_logic;

    --Axi4s Registers
    signal axi4s_valid_mosi, axi4s_valid_mosi_reg : t_axi4s_mosi;
    signal axi4s_full_header_mosi                 : t_axi4s_mosi;
    signal axi4s_full_header_mosi_reg             : t_axi4s_mosi;

    --Delay Shift Registers
    signal delay_reg : std_logic_vector(C_HEADER_TOTAL_BYTES * 8 - 1 downto 0);

    --Count Signals for debugging and verification
    signal ping_count_int       : std_logic_vector(31 downto 0) := (others => '0');
    signal uns_pro_count_int    : std_logic_vector(31 downto 0) := (others => '0');
    signal dropped_ip_count_int : std_logic_vector(31 downto 0) := (others => '0');
    signal ping_count_inc       : std_logic;
    signal uns_pro_count_inc    : std_logic;
    signal dropped_ip_count_inc : std_logic;

    signal header_reg        : std_logic_vector(C_HEADER_TOTAL_BYTES * 8 - 1 downto 0);
    signal rx_eng_next_state : t_rx_2_next_state := idle;

    signal extra_word                                 : std_logic;
    signal prev_eof                                   : std_logic;
    signal prev_last_index                            : integer range 0 to G_UDP_CORE_BYTES - 1;
    signal udp_flag, ping_flag, pass_flag             : std_logic;
    signal udp_flag_reg, ping_flag_reg, pass_flag_reg : std_logic;
    signal busy_int                                   : std_logic;

    signal check_length      : std_logic;
    signal length_chk_ignore : std_logic;
    signal length_expected   : integer range 0 to C_MAX_IP_LENGTH_FIELD;
    signal length_counter    : integer range 0 to C_MAX_IP_LENGTH_FIELD;

begin
    -- 1st A State Machine Process Filters Incoming Packet, outputs an Axi4s and Flags what type of packet it is
    -- 2nd A Check Length Process optionally cuts the Axi4s off after the number of bytes specified in the IP Length Header field
    -- 3rd A demux process Outputs the Axi4s to the correct port

    busy             <= busy_int;
    ping_count       <= ping_count_int;
    uns_pro_count    <= uns_pro_count_int;
    dropped_ip_count <= dropped_ip_count_int;

    --Combinational Filtering, With 1 & 10G only valid on the cycle the header data becomes available
    dst_ip_addr  <= header_reg(20 * 8 - 1 downto 16 * 8);
    src_ip_addr  <= header_reg(16 * 8 - 1 downto 12 * 8);
    total_length <= header_reg(3 * 8 - 1 downto 2 * 8) & header_reg(4 * 8 - 1 downto 3 * 8);
    protocol     <= header_reg(10 * 8 - 1 downto 9 * 8);
    pass_src_ip  <= '1' when (dst_ip_addr = ip_dst_addr or dst_ip_chk_en = '0') else '0';
    pass_dst_ip  <= '1' when (src_ip_addr = ip_src_addr or src_ip_chk_en = '0') else '0';

    packet_udp        <= '1' when protocol = C_PROTOCOL_UDP else '0';
    packet_ping       <= '1' when protocol = C_PROTOCOL_PING and G_INC_PING and ping_en = '1' else '0';
    packet_ping_pass  <= '1' when protocol = C_PROTOCOL_PING and C_PASS_PING and ping_en = '1' else '0';
    packet_pass_full  <= '1' when G_INC_IPV4 and ((protocol /= C_PROTOCOL_PING and protocol /= C_PROTOCOL_UDP) or packet_ping_pass = '1') and pass_uns_protocol = '1' and strip_uns_pro = '0' else '0';
    packet_pass_strip <= '1' when G_INC_IPV4 and ((protocol /= C_PROTOCOL_PING and protocol /= C_PROTOCOL_UDP) or packet_ping_pass = '1') and pass_uns_protocol = '1' and strip_uns_pro = '1' else '0';

    rx_engine_fsm_proc : process(udp_core_clk)
        variable header_idx_i   : integer range 0 to C_HEADER_TOTAL_BYTES / G_UDP_CORE_BYTES := 0;
        variable trailer_idx_i  : integer;
        variable last_bit_index : integer range 0 to 2 * G_UDP_CORE_BYTES;
    begin
        if (rising_edge(udp_core_clk)) then
            if (udp_core_rst_s_n = '0') then
                extra_word                    <= '0';
                busy_int                      <= '0';
                header_idx_i                  := 0;
                trailer_idx_i                 := 0;
                udp_flag                      <= '0';
                ping_flag                     <= '0';
                pass_flag                     <= '0';
                axi4s_valid_mosi.tvalid       <= '0';
                axi4s_full_header_mosi.tvalid <= '0';
                axi4s_valid_mosi.tlast        <= '0';
                axi4s_full_header_mosi.tlast  <= '0';
                rx_eng_next_state             <= idle;
                ping_count_inc                <= '0';
                uns_pro_count_inc             <= '0';
                dropped_ip_count_inc          <= '0';
                ping_dst_addr_en              <= '0';
            else
                ping_count_inc       <= '0';
                uns_pro_count_inc    <= '0';
                dropped_ip_count_inc <= '0';

                case rx_eng_next_state is
                    when idle =>
                        udp_flag                      <= '0';
                        ping_flag                     <= '0';
                        pass_flag                     <= '0';
                        extra_word                    <= '0';
                        busy_int                      <= '0';
                        header_idx_i                  := 0;
                        trailer_idx_i                 := 0;
                        axi4s_valid_mosi.tvalid       <= '0';
                        axi4s_full_header_mosi.tvalid <= '0';
                        axi4s_valid_mosi.tlast        <= '0';
                        axi4s_full_header_mosi.tlast  <= '0';
                        ping_count_inc                <= '0';
                        dropped_ip_count_inc          <= '0';
                        ping_dst_addr_en              <= '0';

                        if axi4s_ipv4_s_mosi.tvalid = '1' then
                            ping_dst_mac_int <= ping_dst_mac;
                            busy_int         <= '1';
                            if G_UDP_CORE_BYTES >= 32 then
                                --Header only takes 1 word, sort packet
                                prev_eof                           <= axi4s_ipv4_s_mosi.tlast;
                                prev_last_index                    <= tkeep_to_int(axi4s_ipv4_s_mosi.tkeep(G_UDP_CORE_BYTES - 1 downto 0));
                                delay_reg(delay_reg'left downto 0) <= axi4s_ipv4_s_mosi.tdata(C_WORD_BITS - 1 downto 0);
                                header_reg                         <= axi4s_ipv4_s_mosi.tdata(C_WORD_BITS - 1 downto 0);
                                rx_eng_next_state                  <= rx_sort_100g;
                            else
                                --Header over multiple words
                                delay_reg(delay_reg'left downto 0) <= axi4s_ipv4_s_mosi.tdata(C_WORD_BITS - 1 downto 0) & delay_reg(delay_reg'left downto C_WORD_BITS);
                                header_idx_i                       := header_idx_i + 1;
                                rx_eng_next_state                  <= rx_header;
                            end if;
                        end if;

                    when rx_header =>
                        if axi4s_ipv4_s_mosi.tvalid = '1' then
                            delay_reg(delay_reg'left downto 0) <= axi4s_ipv4_s_mosi.tdata(C_WORD_BITS - 1 downto 0) & delay_reg(delay_reg'left downto C_WORD_BITS);
                            header_idx_i                       := header_idx_i + 1;
                            if header_idx_i = C_HEADER_WORDS then
                                rx_eng_next_state <= rx_sort_packet;
                                header_reg        <= axi4s_ipv4_s_mosi.tdata(C_WORD_BITS - 1 downto 0) & delay_reg(delay_reg'left downto C_WORD_BITS);
                            end if;
                        else
                            axi4s_valid_mosi.tvalid       <= '0';
                            axi4s_full_header_mosi.tvalid <= '0';
                        end if;

                    when rx_sort_100g =>
                        if axi4s_ipv4_s_mosi.tvalid = '1' or prev_eof = '1' then
                            prev_eof                                     <= '0';
                            delay_reg(G_UDP_CORE_BYTES * 8 - 1 downto 0) <= axi4s_ipv4_s_mosi.tdata(C_WORD_BITS - 1 downto 0);
                            if (packet_ping or packet_udp or packet_pass_strip) = '1' then
                                --UDP, Ping or Stripped other IPv4 Packet
                                busy_int <= '0';
                                if (pass_dst_ip and pass_src_ip) = '1' then
                                    --Passes Filtering
                                    ping_flag                                        <= packet_ping;
                                    udp_flag                                         <= packet_udp;
                                    pass_flag                                        <= packet_pass_strip;
                                    ping_dst_mac_addr                                <= ping_dst_mac_int;
                                    ping_dst_ip_addr                                 <= src_ip_addr;
                                    ping_dst_addr_en                                 <= packet_ping;
                                    check_length                                     <= check_ip_length;
                                    if check_ip_length = '1' then
                                        length_expected <= udp_minimum(8192 + 8, to_integer(unsigned(total_length)) - 20);
                                    end if;
                                    axi4s_valid_mosi.tdata(C_WORD_BITS - 1 downto 0) <= std_logic_vector(shift_left(unsigned(axi4s_ipv4_s_mosi.tdata(C_WORD_BITS - 1 downto 0)), C_LEFT_SHIFT_BITS) OR shift_right(unsigned(delay_reg(delay_reg'left downto delay_reg'left - C_WORD_BITS + 1)), C_RIGHT_SHIFT_BITS));
                                    axi4s_valid_mosi.tvalid                          <= '1';
                                    axi4s_valid_mosi.tlast                           <= '0';
                                    if prev_eof = '1' then
                                        --Whole Packet contained In 1 Word
                                        rx_eng_next_state                                     <= rx_last_word;
                                        last_bit_index                                        := prev_last_index - C_PARTIAL_WORD_SIZE;
                                        axi4s_valid_mosi.tlast                                <= '1';
                                        axi4s_valid_mosi.tkeep(G_UDP_CORE_BYTES - 1 downto 0) <= int_to_tkeep(last_bit_index, G_UDP_CORE_BYTES);
                                    elsif axi4s_ipv4_s_mosi.tlast = '1' then
                                        --Whole Packet in 2 Words
                                        last_bit_index := G_UDP_CORE_BYTES + tkeep_to_int(axi4s_ipv4_s_mosi.tkeep(G_UDP_CORE_BYTES - 1 downto 0)) - C_PARTIAL_WORD_SIZE;
                                        if last_bit_index < G_UDP_CORE_BYTES then
                                            --Slipped Down To 1 Total Word
                                            rx_eng_next_state                                     <= rx_last_word;
                                            axi4s_valid_mosi.tlast                                <= '1';
                                            axi4s_valid_mosi.tkeep(G_UDP_CORE_BYTES - 1 downto 0) <= int_to_tkeep(last_bit_index, G_UDP_CORE_BYTES);
                                        else
                                            --Stays 2 Words Despite Header Slip
                                            extra_word        <= '1';
                                            rx_eng_next_state <= rx_valid_data;
                                        end if;
                                    else
                                        --Not The End Of Packet
                                        rx_eng_next_state <= rx_valid_data;
                                    end if;
                                else
                                    --Fails IP Addr Check
                                    if prev_eof = '1' or axi4s_ipv4_s_mosi.tlast = '1' then
                                        rx_eng_next_state <= idle;
                                    else
                                        rx_eng_next_state <= rx_wait_for_tlast;
                                    end if;
                                    axi4s_valid_mosi.tvalid       <= '0';
                                    axi4s_full_header_mosi.tvalid <= '0';
                                    dropped_ip_count_inc          <= '1';
                                end if;
                            elsif packet_pass_full = '1' then
                                axi4s_full_header_mosi.tdata(C_WORD_BITS - 1 downto 0) <= delay_reg(C_WORD_BITS - 1 downto 0);
                                axi4s_full_header_mosi.tvalid                          <= '1';

                                rx_eng_next_state <= rx_pass_data;
                                if prev_eof = '1' then
                                    axi4s_full_header_mosi.tlast                                <= '1';
                                    axi4s_full_header_mosi.tkeep(G_UDP_CORE_BYTES - 1 downto 0) <= int_to_tkeep(prev_last_index, G_UDP_CORE_BYTES);
                                    rx_eng_next_state                                           <= rx_last_word;
                                    busy_int                                                    <= '0';
                                elsif axi4s_ipv4_s_mosi.tlast = '1' then
                                    trailer_idx_i     := 1;
                                    busy_int          <= '0';
                                    last_bit_index    := tkeep_to_int(axi4s_ipv4_s_mosi.tkeep(G_UDP_CORE_BYTES - 1 downto 0));
                                    rx_eng_next_state <= rx_pass_data;
                                else
                                    rx_eng_next_state <= rx_pass_data;
                                end if;
                            else
                                --None Type (i.e. if Ping not accepted)
                                if prev_eof = '1' or axi4s_ipv4_s_mosi.tlast = '1' then
                                    rx_eng_next_state <= idle;
                                else
                                    rx_eng_next_state <= rx_wait_for_tlast;
                                end if;
                                axi4s_valid_mosi.tvalid       <= '0';
                                axi4s_full_header_mosi.tvalid <= '0';
                            end if;
                        end if;

                    when rx_sort_packet =>
                        if axi4s_ipv4_s_mosi.tvalid = '1' then
                            if C_HEADER_WORDS = 1 then
                                delay_reg(delay_reg'left downto 0) <= axi4s_ipv4_s_mosi.tdata(C_WORD_BITS - 1 downto 0);
                            else
                                delay_reg(delay_reg'left downto 0) <= axi4s_ipv4_s_mosi.tdata(C_WORD_BITS - 1 downto 0) & delay_reg(delay_reg'left downto C_WORD_BITS);
                            end if;

                            ping_count_inc    <= packet_ping;
                            uns_pro_count_inc <= packet_pass_full or packet_pass_strip;

                            if packet_pass_full = '1' then
                                --Pass Packet
                                axi4s_full_header_mosi.tdata(C_WORD_BITS - 1 downto 0) <= delay_reg(C_WORD_BITS - 1 downto 0);
                                axi4s_full_header_mosi.tvalid                          <= '1';
                                rx_eng_next_state                                      <= rx_pass_data;

                            elsif (packet_ping or packet_udp or packet_pass_strip) = '1' then
                                if (pass_dst_ip and pass_src_ip) = '1' then
                                    --Passes IP Addr checks
                                    busy_int                <= '0';
                                    ping_flag               <= packet_ping;
                                    udp_flag                <= packet_udp;
                                    pass_flag               <= packet_pass_strip;
                                    check_length            <= check_ip_length;
                                    if check_ip_length = '1' then
                                        length_expected <= udp_minimum(8192 + 8, to_integer(unsigned(total_length)) - 20);
                                    end if;
                                    ping_dst_mac_addr       <= ping_dst_mac_int;
                                    ping_dst_ip_addr        <= src_ip_addr;
                                    ping_dst_addr_en        <= packet_ping;
                                    rx_eng_next_state       <= rx_valid_data;
                                    axi4s_valid_mosi.tvalid <= '1';
                                    if C_PARTIAL_WORD_SIZE = 0 then
                                        axi4s_valid_mosi.tdata(C_WORD_BITS - 1 downto 0) <= axi4s_ipv4_s_mosi.tdata(C_WORD_BITS - 1 downto 0);
                                    else
                                        axi4s_valid_mosi.tdata(C_WORD_BITS - 1 downto 0) <= std_logic_vector(shift_left(unsigned(axi4s_ipv4_s_mosi.tdata(C_WORD_BITS - 1 downto 0)), C_LEFT_SHIFT_BITS) OR shift_right(unsigned(delay_reg(delay_reg'left downto delay_reg'left - C_WORD_BITS + 1)), C_RIGHT_SHIFT_BITS));
                                    end if;
                                else
                                    --Fails IP Addr Check
                                    dropped_ip_count_inc <= '1';
                                    rx_eng_next_state    <= rx_wait_for_tlast;
                                end if;
                            else
                                --None Type (i.e. if Ping not accepted)
                                rx_eng_next_state <= rx_wait_for_tlast;
                            end if;
                        else
                            axi4s_valid_mosi.tvalid       <= '0';
                            axi4s_full_header_mosi.tvalid <= '0';
                        end if;

                    when rx_valid_data =>
                        ping_count_inc   <= '0';
                        ping_dst_addr_en <= '0';
                        if axi4s_ipv4_s_mosi.tvalid = '1' or extra_word = '1' then
                            axi4s_valid_mosi.tvalid <= '1';

                            if C_HEADER_WORDS = 1 then --Update delay register
                                delay_reg(delay_reg'left downto 0) <= axi4s_ipv4_s_mosi.tdata(C_WORD_BITS - 1 downto 0);
                            else
                                delay_reg(delay_reg'left downto 0) <= axi4s_ipv4_s_mosi.tdata(C_WORD_BITS - 1 downto 0) & delay_reg(delay_reg'left downto C_WORD_BITS);
                            end if;

                            if C_PARTIAL_WORD_SIZE = 0 then
                                --No Slipping, widths 1, 2, 4
                                axi4s_valid_mosi.tdata(C_WORD_BITS - 1 downto 0) <= axi4s_ipv4_s_mosi.tdata(C_WORD_BITS - 1 downto 0);
                                if axi4s_ipv4_s_mosi.tlast = '1' then
                                    axi4s_valid_mosi.tkeep(G_UDP_CORE_BYTES - 1 downto 0) <= axi4s_ipv4_s_mosi.tkeep(G_UDP_CORE_BYTES - 1 downto 0);
                                    axi4s_valid_mosi.tlast                                <= '1';
                                    rx_eng_next_state                                     <= rx_last_word;
                                end if;
                            else
                                --Slipping
                                axi4s_valid_mosi.tdata(C_WORD_BITS - 1 downto 0) <= std_logic_vector(shift_left(unsigned(axi4s_ipv4_s_mosi.tdata(C_WORD_BITS - 1 downto 0)), C_LEFT_SHIFT_BITS) OR shift_right(unsigned(delay_reg(delay_reg'left downto delay_reg'left - C_WORD_BITS + 1)), C_RIGHT_SHIFT_BITS));

                                --This deals with EOF and slipping. The header slip can cause the EOF to occur 1 cycle early if the last byte of data is slipped forward into the preceeding frame
                                if extra_word = '1' then
                                    last_bit_index                                        := last_bit_index - G_UDP_CORE_BYTES;
                                    extra_word                                            <= '0';
                                    axi4s_valid_mosi.tlast                                <= '1';
                                    rx_eng_next_state                                     <= rx_last_word;
                                    axi4s_valid_mosi.tkeep(G_UDP_CORE_BYTES - 1 downto 0) <= int_to_tkeep(last_bit_index, G_UDP_CORE_BYTES);
                                elsif axi4s_ipv4_s_mosi.tlast = '1' then
                                    last_bit_index := G_UDP_CORE_BYTES + tkeep_to_int(axi4s_ipv4_s_mosi.tkeep(G_UDP_CORE_BYTES - 1 downto 0)) - C_PARTIAL_WORD_SIZE;
                                    if last_bit_index < G_UDP_CORE_BYTES then
                                        axi4s_valid_mosi.tlast                                <= '1';
                                        axi4s_valid_mosi.tkeep(G_UDP_CORE_BYTES - 1 downto 0) <= int_to_tkeep(last_bit_index, G_UDP_CORE_BYTES);
                                        rx_eng_next_state                                     <= rx_last_word;
                                    else
                                        extra_word <= '1';
                                    end if;
                                end if;
                            end if;
                        else
                            axi4s_valid_mosi.tvalid <= '0';
                        end if;

                    when rx_pass_data =>
                        if axi4s_ipv4_s_mosi.tvalid = '1' or trailer_idx_i /= 0 then --Continue To Pass Unsupported Etype Data
                            delay_reg(delay_reg'left downto 0)                     <= axi4s_ipv4_s_mosi.tdata(C_WORD_BITS - 1 downto 0) & delay_reg(delay_reg'left downto C_WORD_BITS);
                            axi4s_full_header_mosi.tvalid                          <= '1';
                            axi4s_full_header_mosi.tdata(C_WORD_BITS - 1 downto 0) <= delay_reg(C_WORD_BITS - 1 downto 0);

                            if axi4s_ipv4_s_mosi.tvalid = '1' and axi4s_ipv4_s_mosi.tlast = '1' then
                                trailer_idx_i  := 1;
                                last_bit_index := tkeep_to_int(axi4s_ipv4_s_mosi.tkeep(G_UDP_CORE_BYTES - 1 downto 0));
                            elsif trailer_idx_i /= 0 then
                                if trailer_idx_i = C_HEADER_WORDS then
                                    axi4s_full_header_mosi.tlast                                <= '1';
                                    axi4s_full_header_mosi.tkeep(G_UDP_CORE_BYTES - 1 downto 0) <= std_logic_vector(to_unsigned(last_bit_index, G_UDP_CORE_BYTES));
                                    rx_eng_next_state                                           <= rx_last_word;
                                end if;
                                trailer_idx_i := trailer_idx_i + 1;
                            end if;

                            if busy_int = '1' and trailer_idx_i >= (6 / G_UDP_CORE_BYTES + 1) then
                                busy_int <= '0';
                            end if;

                        else
                            axi4s_full_header_mosi.tvalid <= '0';
                        end if;

                    when rx_last_word =>
                        udp_flag                      <= '0';
                        ping_flag                     <= '0';
                        pass_flag                     <= '0';
                        delay_reg                     <= (others => '0');
                        axi4s_full_header_mosi.tvalid <= '0';
                        axi4s_valid_mosi.tvalid       <= '0';
                        axi4s_valid_mosi.tlast        <= '0';
                        axi4s_full_header_mosi.tlast  <= '0';
                        extra_word                    <= '0';
                        trailer_idx_i                 := 0;
                        header_idx_i                  := 0;
                        rx_eng_next_state             <= idle;
                        busy_int                      <= '0';
                        ping_dst_addr_en              <= '0';

                    when rx_wait_for_tlast =>
                        dropped_ip_count_inc          <= '0';
                        delay_reg                     <= (others => '0');
                        axi4s_full_header_mosi.tvalid <= '0';
                        axi4s_valid_mosi.tvalid       <= '0';
                        extra_word                    <= '0';
                        trailer_idx_i                 := 0;
                        header_idx_i                  := 0;
                        if axi4s_ipv4_s_mosi.tlast = '1' then
                            rx_eng_next_state <= idle;
                            busy_int          <= '0';
                        end if;

                end case;
            end if;
        end if;
    end process rx_engine_fsm_proc;

    proc_check_length : process(udp_core_clk)
    begin
        if (rising_edge(udp_core_clk)) then
            if (udp_core_rst_s_n = '0') then
                length_chk_ignore <= '0';
                length_counter    <= 0;
            else
                --Register flags and unaffected Axi4s
                udp_flag_reg               <= udp_flag;
                ping_flag_reg              <= ping_flag;
                pass_flag_reg              <= pass_flag;
                axi4s_full_header_mosi_reg <= axi4s_full_header_mosi;

                --Length Check Logic:
                if axi4s_valid_mosi.tvalid = '1' then
                    if check_length = '0' then
                        --Check Length Disabled (Sampled from input port in state machine 'sort' or 'sort_100g' state)
                        axi4s_valid_mosi_reg <= axi4s_valid_mosi;
                    else
                        if length_chk_ignore = '0' then -- Length Check is ongoing
                            -- Update Length Counter
                            if axi4s_valid_mosi.tlast = '0' then
                                length_counter <= length_counter + G_UDP_CORE_BYTES;
                            elsif axi4s_valid_mosi.tlast = '1' then
                                length_counter <= 0;
                            end if;

                            -- Register Base Record (covers data, tid, tuser etc.), valid and last are sequentially overwritten in following logic
                            axi4s_valid_mosi_reg <= axi4s_valid_mosi;

                            if length_counter + G_UDP_CORE_BYTES >= length_expected then
                                --Correct Byte have been output
                                axi4s_valid_mosi_reg.tlast <= '1';
                                for i in 0 to G_UDP_CORE_BYTES - 1 loop
                                    if i <= length_expected - length_counter - 1 then
                                        axi4s_valid_mosi_reg.tkeep(i) <= '1';
                                    else
                                        axi4s_valid_mosi_reg.tkeep(i) <= '0';
                                    end if;
                                end loop;
                                if axi4s_valid_mosi.tlast = '0' then
                                    --If No Axi4s last then extra data is padding and should be ignored
                                    length_chk_ignore <= '1';
                                end if;
                            end if;
                        else
                            --Bytes of Total Header Field Have Been Output, Ignore Rest Of Packet
                            axi4s_valid_mosi_reg.tvalid <= '0';
                            if axi4s_valid_mosi.tlast = '1' then
                                length_chk_ignore <= '0';
                                length_counter    <= 0;
                            end if;
                        end if;
                    end if;
                else
                    axi4s_valid_mosi_reg.tvalid <= '0';
                end if;
            end if;
        end if;
    end process;

    proc_demux_data : process(udp_core_clk)
    begin
        if (rising_edge(udp_core_clk)) then
            if (udp_core_rst_s_n = '0') then
                axi4s_udp_m_mosi.tvalid       <= '0';
                axi4s_ipv4_pass_m_mosi.tvalid <= '0';
                axi4s_ping_m_mosi.tvalid      <= '0';
            else
                if udp_flag_reg = '1' and axi4s_valid_mosi_reg.tvalid = '1' then
                    axi4s_udp_m_mosi <= axi4s_valid_mosi_reg;
                else
                    axi4s_udp_m_mosi.tvalid <= '0';
                end if;
                if ping_flag_reg = '1' and axi4s_valid_mosi_reg.tvalid = '1' then
                    axi4s_ping_m_mosi <= axi4s_valid_mosi_reg;
                else
                    axi4s_ping_m_mosi.tvalid <= '0';
                end if;
                if pass_flag_reg = '1' and axi4s_valid_mosi_reg.tvalid = '1' then
                    axi4s_ipv4_pass_m_mosi <= axi4s_valid_mosi_reg;
                elsif axi4s_full_header_mosi_reg.tvalid = '1' then
                    axi4s_ipv4_pass_m_mosi <= axi4s_full_header_mosi_reg;
                else
                    axi4s_ipv4_pass_m_mosi.tvalid <= '0';
                end if;
            end if;
        end if;
    end process;

    --Count Signals & Inc Process For Debugging & Verification
    count_update : process(udp_core_clk)
    begin
        if (rising_edge(udp_core_clk)) then
            if count_rst_n = '1' and udp_core_rst_s_n = '1' then
                if (ping_count_inc = '1') then
                    ping_count_int <= std_logic_vector(unsigned(ping_count_int) + 1);
                end if;
                if (uns_pro_count_inc = '1') then
                    uns_pro_count_int <= std_logic_vector(unsigned(uns_pro_count_int) + 1);
                end if;
                if (dropped_ip_count_inc = '1') then
                    dropped_ip_count_int <= std_logic_vector(unsigned(dropped_ip_count_int) + 1);
                end if;
            else
                ping_count_int       <= (others => '0');
                uns_pro_count_int    <= (others => '0');
                dropped_ip_count_int <= (others => '0');
            end if;
        end if;
    end process;

end architecture fsm;
