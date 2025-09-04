-----------------------------------------------------------------------------
--! @file   rx_filter_stage_3.vhd
--! @page rxfilterstage3page Rx Filter Stage 3
--!
--! \includedoc esdg_stfc_image.md
--!
--! ### Brief ###
--! Reads the UDP Header of incoming packets and filters against the UDP Ports.
--! The filtering is set by input ports passed from the memory maps.
--!
--! ### License ###
--! Copyright(c) 2021 UNITED KINGDOM RESEARCH AND INNOVATION
--! Licensed under the BSD 3-Clause license. See LICENSE file in the project
--! root for details.
-- ---------------------------------------------------------------------------h>
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library common_stfc_lib;
use common_stfc_lib.common_stfc_pkg.all;

library axi4_lib;
use axi4_lib.axi4s_pkg.all;

library udp_core_lib;
use udp_core_lib.udp_core_pkg.all;

entity rx_filter_stage_3 is
    generic(
        G_UDP_CORE_BYTES            : integer := 8
    );
    port(
        udp_core_rx_clk             : in  std_logic;                        --! Clk
        udp_core_rx_rst_s_n         : in  std_logic;                        --! Active Low Reset
        axi4s_udp_full_s_mosi       : in  t_axi4s_mosi;                     --! Input UDP Axi4s With Header
        axi4s_udp_payload_m_mosi    : out t_axi4s_mosi;                     --! Output UDP Payload Axi4s
        port_src_addr               : in  std_logic_vector(15 downto 0);    --! Src Port Address Of Incoming Packet, assigned from Dst Axi4lite MM field
        port_dst_addr               : in  std_logic_vector(15 downto 0);    --! Dst Port Address Of Incoming Packet, assigned from Src Axi4lite MM field
        dst_port_chk_en             : in  std_logic;                        --! Enable Filtering of Packet Dst Port Field against Cores Src Port Address
        src_port_chk_en             : in  std_logic;                        --! Enable Filtering of Packet Src Port Field against Cores Dst Port Address
        udp_count                   : out std_logic_vector(31 downto 0);    --! Debug UDP Packet Counter
        dropped_port_count          : out std_logic_vector(31 downto 0);    --! Debug Dropped Port Packet Counter
        count_rst_n                 : in  std_logic;                        --! Reset Counters
        busy                        : out std_logic                         --! Busy Signal To Upstream Filter Stages

    );
end entity rx_filter_stage_3;

architecture fsm of rx_filter_stage_3 is
    --------------------------------------------------------------------------------
    -- Constants:
    --------------------------------------------------------------------------------
    constant C_UDP_HEADER            : integer := 8;
    constant C_FULL_HEADER           : boolean := G_UDP_CORE_BYTES >= C_UDP_HEADER;
    constant C_SLIP_WORD             : boolean := G_UDP_CORE_BYTES > C_UDP_HEADER;
    constant C_COMPLETE_HEADER_WORDS : integer := header_words(C_UDP_HEADER, G_UDP_CORE_BYTES) + 1; --Includes partial words if present C_UDP_HEADER/G_UDP_CORE_BYTES;
    constant C_DATA_BYTE_SLIP        : integer := C_UDP_HEADER rem G_UDP_CORE_BYTES;
    constant C_SLIP_BITS             : integer := C_DATA_BYTE_SLIP * 8;
    constant C_WORD_BITS             : integer := G_UDP_CORE_BYTES * 8;
    constant C_HEADER_TOTAL_BYTES    : integer := eth_header_trailer_total_bytes(C_COMPLETE_HEADER_WORDS, C_DATA_BYTE_SLIP, G_UDP_CORE_BYTES);

    type t_rx_3_next_state is (
        idle,
        rx_header,
        rx_data,
        rx_extra_word,
        rx_finished,
        rx_wait_for_tlast
    );

    --------------------------------------------------------------------------------
    --Signals:
    --------------------------------------------------------------------------------
    signal rx_eng_next_state      : t_rx_3_next_state := idle;
    signal header_delay_reg       : std_logic_vector(C_HEADER_TOTAL_BYTES * 8 - 1 downto 0);
    signal prev_last              : std_logic;
    signal prev_keep              : integer range 0 to G_UDP_CORE_BYTES - 1;
    signal passed_sort            : std_logic;
    alias dst_port_addr           : std_logic_vector(15 downto 0) is header_delay_reg(31 downto 16);
    alias src_port_addr           : std_logic_vector(15 downto 0) is header_delay_reg(15 downto 0);
    signal udp_count_int          : std_logic_vector(31 downto 0);
    signal dropped_port_count_int : std_logic_vector(31 downto 0);
    signal counts_inc             : std_logic_vector(1 downto 0);
    alias udp_count_inc           : std_logic is counts_inc(0);
    alias dropped_port_count_inc  : std_logic is counts_inc(1);
    signal dst_port_addr_int      : std_logic_vector(15 downto 0); --Added to simulate in Vivado, wasn't happy with alias indexing

begin

    dst_port_addr_int <= dst_port_addr;

    --------------------------------------------------------------------------------
    -- UDP Header filter and Removal State Machine
    --------------------------------------------------------------------------------
    rx_engine_fsm_proc : process(udp_core_rx_clk)
        variable header_idx_i : integer range 0 to C_HEADER_TOTAL_BYTES / G_UDP_CORE_BYTES;
        variable temp_index   : integer range 0 to G_UDP_CORE_BYTES - 1;
    begin
        if (rising_edge(udp_core_rx_clk)) then
            if (udp_core_rx_rst_s_n = '0') then
                header_idx_i                    := 0;
                header_delay_reg                <= (others => '0');
                axi4s_udp_payload_m_mosi.tvalid <= '0';
                rx_eng_next_state               <= idle;
                busy                            <= '0';
                prev_last                       <= '0';
            else
                case rx_eng_next_state is
                    when idle =>
                        busy                            <= '0';
                        counts_inc                      <= "00";
                        prev_last                       <= '0';
                        header_idx_i                    := 0;
                        passed_sort                     <= '0';
                        axi4s_udp_payload_m_mosi.tvalid <= '0';
                        if axi4s_udp_full_s_mosi.tvalid = '1' then
                            if C_FULL_HEADER then
                                --Whole Header in first Word
                                header_delay_reg(G_UDP_CORE_BYTES * 8 - 1 downto 0) <= axi4s_udp_full_s_mosi.tdata(G_UDP_CORE_BYTES * 8 - 1 downto 0);
                                rx_eng_next_state                                   <= rx_data;
                                if axi4s_udp_full_s_mosi.tlast = '1' then
                                    prev_last <= '1';
                                    prev_keep <= tkeep_to_int(axi4s_udp_full_s_mosi.tkeep(G_UDP_CORE_BYTES - 1 downto 0));
                                else
                                    prev_last <= '0';
                                end if;
                            else
                                --Header takes more than 1 word
                                header_delay_reg((header_idx_i + 1) * G_UDP_CORE_BYTES * 8 - 1 downto header_idx_i * G_UDP_CORE_BYTES * 8) <= axi4s_udp_full_s_mosi.tdata(G_UDP_CORE_BYTES * 8 - 1 downto 0);
                                header_idx_i                                                                                               := header_idx_i + 1;
                                rx_eng_next_state                                                                                          <= rx_header;
                            end if;
                        end if;

                    when rx_header =>
                        --Populate header register
                        if (axi4s_udp_full_s_mosi.tvalid = '1') then
                            header_delay_reg((header_idx_i + 1) * G_UDP_CORE_BYTES * 8 - 1 downto header_idx_i * G_UDP_CORE_BYTES * 8) <= axi4s_udp_full_s_mosi.tdata(G_UDP_CORE_BYTES * 8 - 1 downto 0);
                            if header_idx_i = C_COMPLETE_HEADER_WORDS - 1 then
                                rx_eng_next_state                          <= rx_data;
                            else
                                header_idx_i := (header_idx_i + 1) mod C_COMPLETE_HEADER_WORDS;
                            end if;
                        else
                            axi4s_udp_payload_m_mosi.tvalid <= '0';
                        end if;

                    when rx_data =>
                        header_idx_i := 0;
                        if axi4s_udp_full_s_mosi.tvalid = '1' or prev_last = '1' then
                            if (((port_dst_addr /= dst_port_addr) and dst_port_chk_en = '1') or ((port_src_addr /= src_port_addr) and src_port_chk_en = '1')) and passed_sort = '0' then
                                --Fails Header Checks, Drop Packet
                                dropped_port_count_inc <= '1';
                                passed_sort            <= '0';
                                rx_eng_next_state      <= rx_wait_for_tlast;
                            else
                                if passed_sort = '0' then
                                    axi4s_udp_payload_m_mosi.tuser(15 downto 0)  <= byte_reverse(dst_port_addr_int);
                                    axi4s_udp_payload_m_mosi.tuser(31 downto 16) <= byte_reverse(src_port_addr);
                                end if;


                                --Passed Header Checks, Output Data
                                udp_count_inc                   <= not passed_sort;
                                passed_sort                     <= '1'; --Register pass filter sorting
                                axi4s_udp_payload_m_mosi.tvalid <= '1';

                                if C_SLIP_WORD then
                                    --Data slipping required: Use input and delay reg to construct slipped word
                                    axi4s_udp_payload_m_mosi.tdata(G_UDP_CORE_BYTES * 8 - 1 downto 0) <= axi4s_udp_full_s_mosi.tdata(C_SLIP_BITS - 1 downto 0) & header_delay_reg(C_WORD_BITS - 1 downto C_SLIP_BITS);
                                    header_delay_reg(G_UDP_CORE_BYTES * 8 - 1 downto 0)               <= axi4s_udp_full_s_mosi.tdata(G_UDP_CORE_BYTES * 8 - 1 downto 0);

                                    if prev_last = '1' then
                                        --Previous word was last word, high when only 1 data word in packet
                                        axi4s_udp_payload_m_mosi.tlast                                <= '1';
                                        axi4s_udp_payload_m_mosi.tkeep(G_UDP_CORE_BYTES - 1 downto 0) <= int_to_tkeep(prev_keep - 8, G_UDP_CORE_BYTES);
                                        rx_eng_next_state                                             <= rx_finished;
                                    elsif axi4s_udp_full_s_mosi.tlast = '1' then
                                        --Current word is last word
                                        temp_index := tkeep_to_int(axi4s_udp_full_s_mosi.tkeep(G_UDP_CORE_BYTES - 1 downto 0));
                                        if temp_index - 8 < 0 then
                                            --Slip means this output word is the last word
                                            axi4s_udp_payload_m_mosi.tlast                                <= '1';
                                            rx_eng_next_state                                             <= rx_finished;
                                            axi4s_udp_payload_m_mosi.tkeep(G_UDP_CORE_BYTES - 1 downto 0) <= int_to_tkeep(temp_index - 8 + G_UDP_CORE_BYTES, G_UDP_CORE_BYTES);
                                        else
                                            --Slip means that 1 more output word is required
                                            rx_eng_next_state <= rx_extra_word;
                                            prev_keep         <= temp_index - 8;
                                        end if;
                                    else
                                        axi4s_udp_payload_m_mosi.tlast <= '0';
                                    end if;
                                else
                                    --No Data slipping needed, Word size = Header Size = 8B
                                    axi4s_udp_payload_m_mosi.tdata(C_WORD_BITS - 1 downto 0) <= axi4s_udp_full_s_mosi.tdata(C_WORD_BITS - 1 downto 0);
                                    if axi4s_udp_full_s_mosi.tlast = '1' then
                                        rx_eng_next_state                                             <= rx_finished;
                                        axi4s_udp_payload_m_mosi.tlast                                <= '1';
                                        axi4s_udp_payload_m_mosi.tkeep(G_UDP_CORE_BYTES - 1 downto 0) <= axi4s_udp_full_s_mosi.tkeep(G_UDP_CORE_BYTES - 1 downto 0);
                                    else
                                        axi4s_udp_payload_m_mosi.tlast <= '0';
                                    end if;
                                end if;
                            end if;
                        else
                            axi4s_udp_payload_m_mosi.tvalid <= '0';
                        end if;

                    when rx_extra_word =>
                        counts_inc                                                    <= "00";
                        prev_last                                                     <= '0';
                        axi4s_udp_payload_m_mosi.tdata(C_WORD_BITS - 1 downto 0)      <= axi4s_udp_full_s_mosi.tdata(C_SLIP_BITS - 1 downto 0) & header_delay_reg(C_WORD_BITS - 1 downto C_SLIP_BITS);
                        axi4s_udp_payload_m_mosi.tkeep(G_UDP_CORE_BYTES - 1 downto 0) <= int_to_tkeep(prev_keep, G_UDP_CORE_BYTES);
                        axi4s_udp_payload_m_mosi.tlast                                <= '1';
                        axi4s_udp_payload_m_mosi.tvalid                               <= '1';
                        rx_eng_next_state                                             <= rx_finished;

                    when rx_finished =>
                        passed_sort                     <= '0';
                        counts_inc                      <= "00";
                        header_delay_reg                <= (others => '0');
                        axi4s_udp_payload_m_mosi.tlast  <= '0';
                        axi4s_udp_payload_m_mosi.tvalid <= '0';
                        rx_eng_next_state               <= idle;

                    when rx_wait_for_tlast =>
                        prev_last  <= '0';
                        counts_inc <= (others => '0');
                        if axi4s_udp_full_s_mosi.tlast = '1' then
                            rx_eng_next_state <= idle;
                            busy              <= '0';
                        end if;
                end case;
            end if;
        end if;
    end process rx_engine_fsm_proc;

    --------------------------------------------------------------------------------
    --Debugging Packet Counter Process:
    --------------------------------------------------------------------------------
    udp_count          <= udp_count_int;
    dropped_port_count <= dropped_port_count_int;

    count_update : process(udp_core_rx_clk)
    begin
        if (rising_edge(udp_core_rx_clk)) then
            if count_rst_n = '1' and udp_core_rx_rst_s_n = '1' then
                if (udp_count_inc = '1') then
                    udp_count_int <= std_logic_vector(unsigned(udp_count_int) + 1);
                end if;
                if (dropped_port_count_inc = '1') then
                    dropped_port_count_int <= std_logic_vector(unsigned(dropped_port_count_int) + 1);
                end if;
            else
                udp_count_int          <= (others => '0');
                dropped_port_count_int <= (others => '0');
            end if;
        end if;
    end process;

end architecture fsm;
