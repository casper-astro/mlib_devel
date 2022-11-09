-- <h---------------------------------------------------------------------------
--! @file tx_header_contructor.vhd
--! @page txheaderconstructorpage Tx Header Constructor
--!
--! \includedoc esdg_stfc_image.md
--!
--! ### Brief ###
--! Generates and outputs packet headers depending on the packet type dictated
--! by the packet type input. Calculates UDP & IPV4 header checksums and signals
--! to the relevant packet handlers to start data transmission.
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

library axi4_lib;
use axi4_lib.axi4s_pkg.all;

library common_stfc_lib;
use common_stfc_lib.common_stfc_pkg.all;

library common_mem_lib;
use common_mem_lib.common_mem_pkg.all;

entity tx_header_constructor is
    generic(
        G_UDP_CORE_BYTES        : natural := 8
    );
    port(
        clk                     : in  std_logic;                        --! Clk
        rst_s_n                 : in  std_logic;                        --! Active Low synchronous Reset
        tx_type                 : in  std_logic_vector(3 downto 0);     --! Type Of Packet
        arbitrator_rdy          : in  std_logic;                        --! Start Input Signal
        dst_mac_addr            : in  std_logic_vector(47 downto 0);    --! Dst Mac Addr Of Core
        src_mac_addr            : in  std_logic_vector(47 downto 0);    --! Src Mac Addr Of Core
        dst_ip_addr             : in  std_logic_vector(31 downto 0);    --! Dst IP Addr Of Core
        src_ip_addr             : in  std_logic_vector(31 downto 0);    --! Src IP Addr Of Core
        dst_port_addr           : in  std_logic_vector(15 downto 0);    --! Dst Port Addr Of Core
        src_port_addr           : in  std_logic_vector(15 downto 0);    --! Src Port Addr Of Core
        ping_dst_mac_addr       : in  std_logic_vector(47 downto 0);    --! MAC Addr To Route Ping Replies To, passed from Tx Path via Ping handler
        ping_ip_dst_addr        : in  std_logic_vector(31 downto 0);    --! IP Addr To Route Ping Replies To, passed from Tx Path via Ping handler
        arp_dst_mac_addr        : in  std_logic_vector(47 downto 0);    --! MAC Addr To Route ARP Packets To, passed from ARP handler
        lut_dst_mac_addr        : in  std_logic_vector(47 downto 0);    --! LUT Dst Mac Addr
        lut_dst_ip_addr         : in  std_logic_vector(31 downto 0);    --! LUT Dst IP Addr
        lut_dst_port_addr       : in  std_logic_vector(15 downto 0);    --! LUT Dst Port Addr
        farm_mode               : in  std_logic;                        --! Enables Farm Mode
        lut_pos_from_data       : in  std_logic_vector(7 downto 0);     --! LUT Position To Retrieve Addresses From, Passed from UDP Handler
        lut_pos_reading         : in  std_logic_vector(7 downto 0);     --! Position Of LUT Currently Valid
        ip_length               : in  std_logic_vector(15 downto 0);    --! Length Of IPV4 For UDP
        ip_ping_length          : in  std_logic_vector(15 downto 0);    --! Length Of IPV4 For Ping
        udp_length              : in  std_logic_vector(15 downto 0);    --! Length of UDP Data
        ext_ipv4_protocol       : in  std_logic_vector(7 downto 0);     --! Protocol For Ext IPV4 Packets
        ext_ipv4_length         : in  std_logic_vector(15 downto 0);    --! Length For External IPV4 Packets
        ext_eth_etype           : in  std_logic_vector(15 downto 0);    --! Etype For External Ethernet Packets
        axi4s_header_out_mosi   : out t_axi4s_mosi;                     --! Axi4s Header Data Out
        axi4s_header_out_miso   : in  t_axi4s_miso;                     --! Axi4s Header Backpressure - Unused
        udp_preparing           : out std_logic;                        --! UDP Handler Can Accept New Data (As FIFO Will Be Emptying)
        udp_start_data          : out std_logic;                        --! Start Signal To UDP Handler
        arp_start_data          : out std_logic;                        --! Start Signal To Arp Handler
        ping_start_data         : out std_logic;                        --! Start Signal To Ping Handler
        ipv4_start_data         : out std_logic;                        --! Start Signal To IPV4 Handler
        eth_start_data          : out std_logic;                        --! Start Signal To Ethernet Handler
        packet_type             : in  std_logic_vector(15 downto 0);    --! Header Type To Construct
        ip_ver_hdr_len          : in  std_logic_vector(7 downto 0);     --! IPV4 Header Fields
        ip_service              : in  std_logic_vector(7 downto 0);     --! IPV4 Header Fields
        ip_ident_count          : in  std_logic_vector(15 downto 0);    --! IPV4 Header Fields
        ip_flag_frag             : in  std_logic_vector(15 downto 0);    --! IPV4 Header Fields
        ip_time_to_live         : in  std_logic_vector(7 downto 0);     --! IPV4 Header Fields
        ip_protocol             : in  std_logic_vector(7 downto 0)      --! IPV4 Header Fields
    );
end entity tx_header_constructor;

architecture behavioral of tx_header_constructor is

    constant C_HEADER_TOTAL_BYTES : integer                       := 42;
    constant C_HEADER_EMPTY_BYTES : integer                       := 64;
    constant C_HEADER_UDP         : integer                       := 42;
    constant C_HEADER_ARP         : integer                       := 14;
    constant C_HEADER_PING        : integer                       := 34;
    constant C_ETPYE_ARP          : std_logic_vector(15 downto 0) := X"0608";
    constant C_UDP_CYCLES         : integer                       := C_HEADER_UDP / G_UDP_CORE_BYTES;
    constant C_ARP_CYCLES         : integer                       := C_HEADER_ARP / G_UDP_CORE_BYTES;
    constant C_PING_CYCLES        : integer                       := C_HEADER_PING / G_UDP_CORE_BYTES;

    type t_tx_header_const_next_state is (
        idle,
        insert_chksm,
        first_header,
        output,
        finished
    );

    signal tx_header_const_next_state : t_tx_header_const_next_state := idle;
    signal udp_header                 : std_logic;
    signal ping_header                : std_logic;
    signal arp_header                 : std_logic;
    signal ipv4_header                : std_logic;
    signal eth_header                 : std_logic;
    signal header_cycles              : integer range 0 to 63;

    signal complete_header_int : std_logic_vector(C_HEADER_EMPTY_BYTES * 8 - 1 downto 0);
    signal hdr_dst_mac_addr     : std_logic_vector(47 downto 0);
    signal hdr_src_mac_addr     : std_logic_vector(47 downto 0);
    signal hdr_ef_type          : std_logic_vector(15 downto 0);
    signal hdr_ip_ver           : std_logic_vector(7 downto 0) ;
    signal hdr_ip_type          : std_logic_vector(7 downto 0) ;
    signal hdr_ip_length        : std_logic_vector(15 downto 0);
    signal hdr_ip_id            : std_logic_vector(15 downto 0);
    signal hdr_ip_flags         : std_logic_vector(15 downto 0);
    signal hdr_ip_ttl           : std_logic_vector(7 downto 0) ;
    signal hdr_ip_pro           : std_logic_vector(7 downto 0) ;
    signal hdr_ip_chskm         : std_logic_vector(15 downto 0);
    signal hdr_ip_src_addr      : std_logic_vector(31 downto 0);
    signal hdr_ip_dst_addr      : std_logic_vector(31 downto 0);
    signal hdr_udp_src_addr     : std_logic_vector(15 downto 0);
    signal hdr_udp_dst_addr     : std_logic_vector(15 downto 0);
    signal hdr_udp_length       : std_logic_vector(15 downto 0);
    signal hdr_udp_chksm        : std_logic_vector(15 downto 0);

    signal chksum_calculation_start   : std_logic;
    signal chksum_calculation_busy    : std_logic;
    signal chksum_calculation_done    : std_logic;
    signal calculated_ipv4_hdr_chksum : std_logic_vector(15 downto 0);
    signal calculated_udp_hdr_chksum  : std_logic_vector(15 downto 0);
    signal header_int_mosi            : t_axi4s_mosi;
    signal start_payload              : std_logic := '0';
    signal udp_dst_mac                : std_logic_vector(47 downto 0);
    signal udp_dst_ip                 : std_logic_vector(31 downto 0);
    signal udp_dst_port               : std_logic_vector(15 downto 0);
    signal header_idx_adjust          : integer range 0 to 1;

begin

    complete_header_int(47 downto 0)      <= hdr_dst_mac_addr;
    complete_header_int(95 downto 48)     <= hdr_src_mac_addr;
    complete_header_int(111 downto 96)    <= hdr_ef_type     ;
    complete_header_int(119 downto 112)   <= hdr_ip_ver      ;
    complete_header_int(127 downto 120)   <= hdr_ip_type     ;
    complete_header_int(143 downto 128)   <= hdr_ip_length   ;
    complete_header_int(159 downto 144)   <= hdr_ip_id       ;
    complete_header_int(175 downto 160)   <= hdr_ip_flags    ;
    complete_header_int(183 downto 176)   <= hdr_ip_ttl      ;
    complete_header_int(191 downto 184)   <= hdr_ip_pro      ;
    complete_header_int(207 downto 192)   <= hdr_ip_chskm    ;
    complete_header_int(239 downto 208)   <= hdr_ip_src_addr ;
    complete_header_int(271 downto 240)   <= hdr_ip_dst_addr ;
    complete_header_int(287 downto 272)   <= hdr_udp_src_addr;
    complete_header_int(303 downto 288)   <= hdr_udp_dst_addr;
    complete_header_int(319 downto 304)   <= hdr_udp_length  ;
    complete_header_int(335 downto 320)   <= hdr_udp_chksm   ;


    --Adjust Header Index Count When No byte Slipping Is Required, 1B & 2B Widths
    header_idx_adjust <= 1 when G_UDP_CORE_BYTES = 1
                         else 1 when G_UDP_CORE_BYTES = 2
                         else 0;

    udp_header  <= '1' when tx_type = X"0" else '0';
    arp_header  <= '1' when tx_type = X"1" else '0';
    ping_header <= '1' when tx_type = X"2" else '0';
    ipv4_header <= '1' when tx_type = X"3" else '0';
    eth_header  <= '1' when tx_type = X"4" else '0';

    udp_start_data  <= start_payload and udp_header;
    ping_start_data <= start_payload and ping_header;
    arp_start_data  <= start_payload and arp_header;
    ipv4_start_data <= start_payload and ipv4_header;
    eth_start_data  <= start_payload and eth_header;

    udp_dst_mac  <= dst_mac_addr when farm_mode = '0' else lut_dst_mac_addr;
    udp_dst_ip   <= dst_ip_addr when farm_mode = '0' else lut_dst_ip_addr;
    udp_dst_port <= dst_port_addr when farm_mode = '0' else lut_dst_port_addr;

    axi4s_header_out_mosi <= header_int_mosi;

    with tx_type select header_cycles <=
        C_UDP_CYCLES when X"0",
        C_ARP_CYCLES when X"1",
             C_PING_CYCLES  when X"2",
             C_PING_CYCLES  when X"3",
             C_ARP_CYCLES   when X"4",
             0 when others;

    rx_engine_fsm_proc : process(clk)
        variable header_idx_i : integer range 0 to C_HEADER_TOTAL_BYTES / G_UDP_CORE_BYTES + 1 := 0;
    begin
        if (rising_edge(clk)) then
            if (rst_s_n = '0') then
                header_idx_i               := 0;
                udp_preparing              <= '0';
                start_payload              <= '0';
                tx_header_const_next_state <= idle;
                chksum_calculation_start   <= '0';
                header_int_mosi.tvalid     <= '0';
            else

                case tx_header_const_next_state is
                    when idle =>
                        header_int_mosi.tvalid <= '0';
                        udp_preparing          <= '0';
                        if (arbitrator_rdy = '1') then
                            --Header contained in 1 cycle and no internet checksum calculations, start payload data signal
                            if ((header_cycles = 0) and (arp_header or eth_header) = '1') then
                                start_payload <= '1';
                            else
                                start_payload <= '0';
                            end if;
                            header_idx_i := 0;

                            if (udp_header = '1') then
                                if (farm_mode = '1' and lut_pos_from_data /= lut_pos_reading) then
                                    tx_header_const_next_state <= idle;
                                else
                                    tx_header_const_next_state <= insert_chksm;
                                    chksum_calculation_start   <= '1';
                                    hdr_dst_mac_addr           <= udp_dst_mac;
                                    hdr_src_mac_addr           <= src_mac_addr;
                                    hdr_ef_type                <= packet_type;
                                    hdr_ip_ver                 <= ip_ver_hdr_len;
                                    hdr_ip_type                <= ip_service;
                                    hdr_ip_length              <= ip_length;
                                    hdr_ip_id                  <= ip_ident_count;
                                    hdr_ip_flags                <= ip_flag_frag;
                                    hdr_ip_ttl                 <= ip_time_to_live;
                                    hdr_ip_pro                 <= ip_protocol;
                                    hdr_ip_src_addr            <= src_ip_addr;
                                    hdr_ip_dst_addr            <= udp_dst_ip;
                                    hdr_udp_src_addr           <= src_port_addr;
                                    hdr_udp_dst_addr           <= udp_dst_port;
                                    hdr_udp_length             <= udp_length;
                                    udp_preparing              <= '1';
                                end if;
                            elsif arp_header = '1' then
                                tx_header_const_next_state <= first_header;
                                chksum_calculation_start   <= '0';
                                hdr_dst_mac_addr           <= arp_dst_mac_addr;
                                hdr_src_mac_addr           <= src_mac_addr;
                                hdr_ef_type                <= C_ETPYE_ARP;

                            elsif ping_header = '1' then
                                tx_header_const_next_state <= insert_chksm;
                                chksum_calculation_start   <= '1';
                                hdr_dst_mac_addr           <= ping_dst_mac_addr;
                                hdr_src_mac_addr           <= src_mac_addr;
                                hdr_ef_type                <= packet_type;
                                hdr_ip_ver                 <= ip_ver_hdr_len;
                                hdr_ip_type                <= ip_service;
                                hdr_ip_length              <= ip_ping_length;
                                hdr_ip_id                  <= ip_ident_count;
                                hdr_ip_flags                <= ip_flag_frag;
                                hdr_ip_ttl                 <= ip_time_to_live;
                                hdr_ip_pro                 <= X"01";
                                hdr_ip_src_addr            <= src_ip_addr;
                                hdr_ip_dst_addr            <= ping_ip_dst_addr;

                            elsif ipv4_header = '1' then
                                tx_header_const_next_state <= insert_chksm;
                                chksum_calculation_start   <= '1';
                                hdr_dst_mac_addr           <= dst_mac_addr;
                                hdr_src_mac_addr           <= src_mac_addr;
                                hdr_ef_type                <= packet_type;
                                hdr_ip_ver                 <= ip_ver_hdr_len;
                                hdr_ip_type                <= ip_service;
                                hdr_ip_length              <= ext_ipv4_length;
                                hdr_ip_id                  <= ip_ident_count;
                                hdr_ip_flags                <= ip_flag_frag;
                                hdr_ip_ttl                 <= ip_time_to_live;
                                hdr_ip_pro                 <= ext_ipv4_protocol;
                                hdr_ip_src_addr            <= src_ip_addr;
                                hdr_ip_dst_addr            <= dst_ip_addr;
                            elsif eth_header = '1' then
                                tx_header_const_next_state <= first_header;
                                chksum_calculation_start   <= '0';
                                hdr_dst_mac_addr           <= dst_mac_addr;
                                hdr_src_mac_addr           <= src_mac_addr;
                                hdr_ef_type                <= ext_eth_etype;

                            end if;
                        end if;

                    when insert_chksm =>
                        udp_preparing            <= '0';
                        chksum_calculation_start <= '0';
                        if (chksum_calculation_done = '1') then
                            hdr_ip_chskm           <= byte_reverse(calculated_ipv4_hdr_chksum);
                            if (tx_type(3) = '0') then
                                hdr_udp_chksm <= calculated_udp_hdr_chksum;
                            else
                                hdr_ip_chskm <= byte_reverse(calculated_ipv4_hdr_chksum);
                            end if;
                            header_int_mosi.tlast  <= '0';
                            header_int_mosi.tvalid <= '0';

                            if header_cycles = 0 then
                                start_payload         <= '1';
                                header_int_mosi.tlast <= '1';
                            end if;

                            udp_preparing              <= '0';
                            tx_header_const_next_state <= first_header;
                        end if;

                    when first_header =>
                        header_int_mosi.tdata(G_UDP_CORE_BYTES * 8 - 1 downto 0) <= complete_header_int((header_idx_i + 1) * G_UDP_CORE_BYTES * 8 - 1 downto header_idx_i * G_UDP_CORE_BYTES * 8);
                        header_int_mosi.tvalid                                   <= '1';
                        header_int_mosi.tlast                                    <= '0';

                        if (header_idx_i = header_cycles - 1) then
                            start_payload              <= '1';
                            header_idx_i               := header_idx_i + 1;
                            tx_header_const_next_state <= output;
                        elsif (header_idx_i = header_cycles) then
                            start_payload              <= '0';
                            tx_header_const_next_state <= finished;
                            header_int_mosi.tlast      <= '1';
                        else
                            header_idx_i               := header_idx_i + 1;
                            tx_header_const_next_state <= output;
                        end if;

                    when output =>
                        header_int_mosi.tdata(G_UDP_CORE_BYTES * 8 - 1 downto 0) <= complete_header_int((header_idx_i + 1) * G_UDP_CORE_BYTES * 8 - 1 downto header_idx_i * G_UDP_CORE_BYTES * 8);
                        header_int_mosi.tvalid                                   <= '1';

                        if header_idx_i = header_cycles - 1 - header_idx_adjust then
                            start_payload <= '1';
                            header_idx_i  := header_idx_i + 1;
                        elsif header_idx_i = header_cycles - header_idx_adjust then
                            tx_header_const_next_state <= finished;
                            header_int_mosi.tlast      <= '1';
                            start_payload              <= '0';
                        else
                            header_idx_i := header_idx_i + 1;
                        end if;

                    when finished =>
                        header_int_mosi.tvalid     <= '0';
                        header_int_mosi.tlast      <= '0';
                        start_payload              <= '0';
                        tx_header_const_next_state <= idle;

                end case;
            end if;
        end if;
    end process;

    checksum_calculations_inst : entity udp_core_lib.udp_ip_chksm_calc
        port map(
            clk               => clk,
            rst_s_n           => rst_s_n,
            start             => chksum_calculation_start,
            busy              => chksum_calculation_busy,
            done              => chksum_calculation_done,
            ip_ver_hdr_len    => hdr_ip_ver,
            ip_service        => hdr_ip_type,
            ip_pkt_length     => byte_reverse(hdr_ip_length),
            ip_ident_count    => byte_reverse(hdr_ip_id),
            ip_flag_frag      => byte_reverse(hdr_ip_flags),
            ip_time_to_live   => hdr_ip_ttl,
            --ip_flag_frag                        => X"4000",
            --ip_time_to_live                     => X"40",
            ip_protocol       => byte_reverse(hdr_ip_pro),
            ip_dst_addr       => byte_reverse(hdr_ip_dst_addr),
            ip_src_addr       => byte_reverse(hdr_ip_src_addr),
            udp_dst_port_addr => byte_reverse(hdr_udp_dst_addr),
            udp_src_port_addr => byte_reverse(hdr_udp_src_addr),
            udp_length        => byte_reverse(hdr_udp_length),
            udp_data_checksum => X"0000_0000",
            udp_chk_sum_zero  => '1',
            ip_chksm          => calculated_ipv4_hdr_chksum,
            udp_chksm         => calculated_udp_hdr_chksum
        );

end architecture behavioral;
