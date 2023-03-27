-- <h---------------------------------------------------------------------------
--! @file   udp_ip_pkt_len.vhd
--! @page udpippktlenpage UDP Packet and IP Frame Length Calculator
--!
--! \includedoc esdg_stfc_image.md
--!
--! ### Brief ###
--! Calculates both the total Ethernet IPv4 Frame Length and the UDP Packet
--! Length.
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

library udp_core_lib;
use udp_core_lib.udp_core_pkg.all;

entity udp_ip_pkt_len is
    generic(
        G_UDP_CORE_BYTES    : integer := 8
    );
    port(
        udp_core_clk        : in  std_logic;                        --! UDP Core "core" Clock
        udp_core_rst_s_n    : in  std_logic;                        --! UDP Core "core" Synchronous Active-High Reset
        en                  : in  std_logic;                        --! Enable Signal
        fxd_pkt_sze         : in  std_logic;                        --! Use Fixed Packet Size
        keep                : in  std_logic_vector(G_UDP_CORE_BYTES - 1 downto 0);
        last                : in  std_logic;                        --! End-Of-Packet Flag
        ip_length_base      : in  std_logic_vector(15 downto 0);    --! Base Length of Ethernet IPv4 Frame (i.e. Header Length)
        udp_length_base     : in  std_logic_vector(15 downto 0);    --! Base Length of UDP Packet (i.e. UDP Header Length)
        ip_length           : out std_logic_vector(15 downto 0);    --! Calculated IP Frame Length
        udp_length          : out std_logic_vector(15 downto 0);    --! Calculated UDP Packet Length
        length_strb         : out std_logic                         --! IPv4 and UDP Lengths Valid Strobe
    );
end entity udp_ip_pkt_len;

architecture fsm of udp_ip_pkt_len is

    signal udp_count                               : std_logic_vector(15 downto 0);
    signal ip_count                                : std_logic_vector(15 downto 0);
    signal ip_length_base_reg, udp_length_base_reg : std_logic_vector(15 downto 0);

    type state_type is (
        waiting,
        running
    );

    signal next_state : state_type := waiting;

begin

    fsm_proc : process(udp_core_clk)
    begin
        if (rising_edge(udp_core_clk)) then

            length_strb         <= '0'; -- This ensures that length_strobe is only asserted for 1 Clock-Cycle.
            ip_length_base_reg  <= ip_length_base;
            udp_length_base_reg <= udp_length_base;

            if (udp_core_rst_s_n = '0') then
                ip_count    <= (others => '0');
                udp_count   <= (others => '0');
                length_strb <= '0';
                next_state  <= waiting;
            else
                case (next_state) is
                    when waiting =>
                        if en = '1' then
                            if last = '0' then
                                ip_count   <= std_logic_vector(unsigned(ip_length_base) + G_UDP_CORE_BYTES);
                                udp_count  <= std_logic_vector(unsigned(udp_length_base) + G_UDP_CORE_BYTES);
                                next_state <= running;
                            else
                                if fxd_pkt_sze = '1' then
                                    ip_count  <= byte_reverse(ip_length_base);
                                    udp_count <= byte_reverse(udp_length_base);
                                elsif G_UDP_CORE_BYTES = 1 then
                                    ip_count  <= std_logic_vector(unsigned(ip_length_base) + G_UDP_CORE_BYTES);
                                    udp_count <= std_logic_vector(unsigned(udp_length_base) + G_UDP_CORE_BYTES);
                                else
                                    ip_count  <= std_logic_vector(unsigned(ip_length_base) + tkeep_to_int(keep) + 1); --Extra 1 due to zero indexing
                                    udp_count <= std_logic_vector(unsigned(udp_length_base) + tkeep_to_int(keep) + 1);
                                end if;
                                length_strb <= '1';
                            end if;
                        end if;

                    when running =>
                        if en = '1' then
                            if last = '1' then
                                if fxd_pkt_sze = '1' then
                                    ip_count  <= byte_reverse(ip_length_base);
                                    udp_count <= byte_reverse(udp_length_base);
                                elsif G_UDP_CORE_BYTES = 1 then
                                    ip_count  <= std_logic_vector(unsigned(ip_count) + G_UDP_CORE_BYTES);
                                    udp_count <= std_logic_vector(unsigned(udp_count) + G_UDP_CORE_BYTES);
                                else
                                    ip_count  <= std_logic_vector(unsigned(ip_count) + tkeep_to_int(keep) + 1);
                                    udp_count <= std_logic_vector(unsigned(udp_count) + tkeep_to_int(keep) + 1);
                                end if;
                                length_strb <= '1';
                                next_state  <= waiting;
                            else
                                ip_count   <= std_logic_vector(unsigned(ip_count) + G_UDP_CORE_BYTES);
                                udp_count  <= std_logic_vector(unsigned(udp_count) + G_UDP_CORE_BYTES);
                                next_state <= running;
                            end if;
                        end if;

                end case;
            end if;
        end if;
    end process fsm_proc;

    ip_length  <= byte_reverse(ip_count);
    udp_length <= byte_reverse(udp_count);

end architecture fsm;
