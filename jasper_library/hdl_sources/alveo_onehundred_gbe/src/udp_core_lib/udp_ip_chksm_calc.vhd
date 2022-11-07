-- <h---------------------------------------------------------------------------
--! @file   udp_ip_chksm_calc.vhd
--! @page udpipchksmcalcpage UDP IP Checksum Calc
--!
--! \includedoc esdg_stfc_image.md
--!
--! ### Brief ###
--! Calculates the IPv4 Checksum from input header fields
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

entity udp_ip_chksm_calc is
    port(
        clk                 : in  std_logic;                        --! Clk
        rst_s_n             : in  std_logic;                        --! Active Low synchronous Reset
        -- Control
        start               : in  STD_LOGIC;                        --! Start Signal
        busy                : out std_logic;                        --! Calc in Progress
        done                : out std_logic;                        --! Calc Finished
        -- IP
        ip_ver_hdr_len      : in  std_logic_vector(7 downto 0);     --! IPV4 fields
        ip_service          : in  std_logic_vector(7 downto 0);     --! IPV4 fields
        ip_pkt_length       : in  std_logic_vector(15 downto 0);    --! IPV4 fields
        ip_ident_count      : in  std_logic_vector(15 downto 0);    --! IPV4 fields
        ip_flag_frag        : in  std_logic_vector(15 downto 0);    --! IPV4 fields
        ip_time_to_live     : in  std_logic_vector(7 downto 0);     --! IPV4 fields
        ip_protocol         : in  std_logic_vector(7 downto 0);     --! IPV4 fields
        ip_dst_addr         : in  std_logic_vector(31 downto 0);    --! IPV4 fields
        ip_src_addr         : in  std_logic_vector(31 downto 0);    --! IPV4 fields
        -- UDP
        udp_dst_port_addr   : in  std_logic_vector(15 downto 0);    --! UDP fields
        udp_src_port_addr   : in  std_logic_vector(15 downto 0);    --! UDP fields
        udp_length          : in  std_logic_vector(15 downto 0);    --! UDP fields
        udp_data_checksum   : in  std_logic_vector(31 downto 0);    --! UDP fields
        -- UDP checksum zero
        udp_chk_sum_zero    : in  std_logic;                        --! Unused
        -- checksums
        ip_chksm            : out std_logic_vector(15 downto 0);    --! IPv4 Header Checksum Out
        udp_chksm           : out std_logic_vector(15 downto 0)     --! UDP Header Checksum Out
    );
end entity udp_ip_chksm_calc;

architecture behavioral of udp_ip_chksm_calc is

    constant UP_SIZE : integer := 29;

    -- padded copies
    signal up_chk_sum_20_pad : std_logic_vector(UP_SIZE - 1 downto 0) := (others => '0');
    -- signal ip_chk_sum_30_pad                : std_logic_vector(15 downto 0);
    -- signal up_chk_sum_30_pad                : std_logic_vector(15 downto 0);
    signal up_chk_sum_03_pad : std_logic_vector(UP_SIZE - 1 downto 0) := (others => '0');
    signal udp_length_pad    : std_logic_vector(UP_SIZE - 1 downto 0) := (others => '0');

    -- combine signals
    signal ip_ver_hdr_len_srv : std_logic_vector(15 downto 0);
    signal ip_prt_ttl         : std_logic_vector(18 downto 0);

    type t_next_state is (
        idle,
        calc1
    );

    signal next_state : t_next_state := idle;

begin

    ip_ver_hdr_len_srv <= ip_ver_hdr_len & ip_service;
    ip_prt_ttl         <= "000" & ip_time_to_live & ip_protocol;

    udp_length_pad <= zeropad(UP_SIZE - 16) & udp_length;


    fsm_proc : process(clk)
        variable ip_chk_sum_01 : unsigned(16 downto 0);
        variable ip_chk_sum_02 : unsigned(16 downto 0);
        variable ip_chk_sum_03 : unsigned(16 downto 0);
        variable ip_chk_sum_04 : unsigned(16 downto 0);
        variable ip_chk_sum_10 : unsigned(17 downto 0);
        variable ip_chk_sum_11 : unsigned(17 downto 0);
        variable ip_chk_sum_20 : unsigned(18 downto 0);
        variable ip_chk_sum_30 : unsigned(19 downto 0);
        variable ip_chk_sum_40 : unsigned(16 downto 0);

    begin
        if (rising_edge(clk)) then
            done <= '0';
            busy <= '0';
            if (rst_s_n = '0') then
                ip_chk_sum_01 := (others => '0');
                ip_chk_sum_02 := (others => '0');
                ip_chk_sum_03 := (others => '0');
                ip_chk_sum_04 := (others => '0');
                ip_chk_sum_10 := (others => '0');
                ip_chk_sum_11 := (others => '0');
                ip_chk_sum_20 := (others => '0');
                ip_chk_sum_30 := (others => '0');
                ip_chk_sum_40 := (others => '0');

                done       <= '0';
                busy       <= '0';
                next_state <= idle;
            else
                case (next_state) is
                    when idle =>
                        if (start = '1') then
                            ip_chk_sum_01 := unsigned('0' & ip_pkt_length) + unsigned('0' & ip_ver_hdr_len_srv);
                            ip_chk_sum_02 := unsigned('0' & ip_ident_count) + unsigned('0' & ip_flag_frag);
                            ip_chk_sum_03 := unsigned('0' & ip_dst_addr(31 downto 16)) + unsigned('0' & ip_dst_addr(15 downto 0));
                            ip_chk_sum_04 := unsigned('0' & ip_src_addr(31 downto 16)) + unsigned('0' & ip_src_addr(15 downto 0));
                            ip_chk_sum_10 := ('0' & ip_chk_sum_01) + ('0' & ip_chk_sum_02);
                            ip_chk_sum_11 := ('0' & ip_chk_sum_03) + ('0' & ip_chk_sum_04);
                            ip_chk_sum_20 := ('0' & ip_chk_sum_11) + ('0' & ip_chk_sum_10);
                            next_state    <= calc1;
                        else
                            next_state <= idle;
                        end if;
                    when calc1 =>

                        ip_chk_sum_30 := ('0' & ip_chk_sum_20) + unsigned('0' & ip_prt_ttl);
                        ip_chk_sum_40 := ('0' & ip_chk_sum_30(15 downto 0)) + ('0' & ip_chk_sum_30(19 downto 16)); -- Add in the carries, note this might make 1 more carry
                        ip_chksm      <= not std_logic_vector(ip_chk_sum_40(15 downto 0) + (X"000" & "000" & ip_chk_sum_40(16 downto 16))); -- Add in last possible carry here
                        udp_chksm     <= (others => '0');
                        done          <= '1';
                        if (start = '0') then
                            next_state <= idle;
                        end if;
                end case;
            end if;
        end if;
    end process fsm_proc;

end architecture behavioral;
