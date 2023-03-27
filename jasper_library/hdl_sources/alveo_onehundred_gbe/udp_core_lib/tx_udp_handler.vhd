-- <h---------------------------------------------------------------------------
--! @file tx_udp_handler.vhd
--! @page txudphandlerpage Tx UDP Handler
--!
--! \includedoc esdg_stfc_image.md
--!
--! ### Brief ###
--! Receives Axi4s UDP Payloads into a FIFO, calculates the IPV4/UDP lengths
--! then signals when ready to transmit. Stops accepting new packets until
--! @ref txheaderconstructorpage starts processing the current packet
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

entity tx_udp_handler is
    generic(
        G_FPGA_VENDOR           : string  := "xilinx";                  --! Selects the FPGA Vendor for Compilation
        G_FPGA_FAMILY           : string  := "all";                     --! Selects the FPGA Family for Compilation
        G_FIFO_IMPLEMENTATION   : string  := "auto";                    --! Passed to FIFO Instantiation
        G_UDP_CORE_BYTES        : natural := 8                          --! Width of Data Bus in bytes
    );
    port(
        clk                     : in  std_logic;                        --! Clk
        rst_s_n                 : in  std_logic;                        --! Active Low synchronous reset
        axi4s_udp_s_mosi        : in  t_axi4s_mosi;                     --! UDP Payload In
        axi4s_udp_s_miso        : out t_axi4s_miso;                     --! UDP Payload Backpressure
        udp_rdy                 : out std_logic;                        --! UDP Ready Signal OutS
        farm_mode_pos_out       : out std_logic_vector(7 downto 0);     --! LUT To route Packets to from TID sidechannel
        udp_tuser_out           : out std_logic_vector(31 downto 0);    --! Tuser sidechannel, can be used to source Port addresses
        udp_payload_mosi        : out t_axi4s_mosi;                     --! UDP Payload Out
        pause_data              : in  std_logic;                        --! Pause FIFO output after the first word
        udp_preparing           : in  std_logic;                        --! Header Constructor has started processing UDP Packet
        udp_start               : in  std_logic;                        --! Start UDP Payload Output
        ip_length               : out std_logic_vector(15 downto 0);    --! Calculated IP Length field
        udp_length              : out std_logic_vector(15 downto 0)     --! Calculated UDP Length field
    );
end entity tx_udp_handler;

architecture behavioural of tx_udp_handler is
    -- Calculate the FIFO Address Width Based on G_LL_BYTES and C_TOTAL_FIFO_BYTES:
    constant C_TOTAL_FIFO_BYTES : integer := C_MAX_PAYLOAD_SIZE + (20 * G_UDP_CORE_BYTES);
    constant C_FIFO_WORDS       : integer := C_TOTAL_FIFO_BYTES / G_UDP_CORE_BYTES;
    constant C_FIFO_WIDTH       : integer := log_2_ceil(C_FIFO_WORDS);

    constant C_FIFO_CAPCACITY : integer       := 2**C_FIFO_WIDTH;
    constant C_FIFO_DESC      : t_axi4s_descr := (tdata_nof_bytes => 4,
                                                  tid_width       => 8,
                                                  tuser_width     => 8,
                                                  has_tlast       => 1,
                                                  has_tkeep       => 1,
                                                  has_tid         => 1,
                                                  has_tuser       => 0);

    signal lengths_ready  : std_logic;
    signal send_frame     : std_logic;
    signal allow_input    : std_logic;
    signal ip_length_int  : std_logic_vector(15 downto 0);
    signal udp_length_int : std_logic_vector(15 downto 0);
    signal udp_m_miso_int : t_axi4s_miso;
    signal start_of_frame : std_logic;
    signal udp_s_miso_int : t_axi4s_miso;
    signal valid_last     : std_logic;
    signal udp_m_mosi_int : t_axi4s_mosi;
    signal udp_s_mosi_int : t_axi4s_mosi;
    signal farm_pos_reg   : std_logic_vector(7 downto 0);
    signal udp_tuser_reg  : std_logic_vector(31 downto 0);
    signal start_frame    : std_logic;

begin

    --Axi4s Signal Assignments - Stright assignments For Axi4s Signals From/To Intermediate signals
    udp_s_mosi_int.tdata   <= axi4s_udp_s_mosi.tdata; --In
    udp_s_mosi_int.tlast   <= axi4s_udp_s_mosi.tlast;
    udp_s_mosi_int.tkeep   <= axi4s_udp_s_mosi.tkeep;
    udp_s_mosi_int.tid     <= axi4s_udp_s_mosi.tid;
    udp_payload_mosi.tdata <= udp_m_mosi_int.tdata; --Out
    udp_payload_mosi.tlast <= udp_m_mosi_int.tlast;
    udp_payload_mosi.tkeep <= udp_m_mosi_int.tkeep;

    --AXI4s CTRL Signal Adjustments - Add Logic to Ready And Valid Signals To Correctly Sequence Data Transfer
    udp_m_miso_int.tready   <= (not pause_data and send_frame) or start_frame; --Send full packet unless Tx Path has signalled pause, due to downstream backpressure (relavent for 100g)
    axi4s_udp_s_miso.tready <= udp_s_miso_int.tready and (not udp_s_miso_int.prog_full) and allow_input; --Don't allow data input when fifo is nearly full or previous packet is ready but header constructor is busy
    udp_payload_mosi.tvalid <= udp_m_mosi_int.tvalid and udp_m_miso_int.tready; --Valid data transfer when valid and ready are high
    udp_s_mosi_int.tvalid   <= axi4s_udp_s_mosi.tvalid and udp_s_miso_int.tready and (not udp_s_miso_int.prog_full) and allow_input; --Longwinded way of saying s.tvalid <= s_int.tvalid and s.tready, and not using outputs in assignment

    start_of_frame <= valid_last and udp_s_mosi_int.tvalid;

    udp_fifo_inst : entity axi4_lib.axi4s_fifo
        generic map(
            g_fpga_vendor         => G_FPGA_VENDOR,
            g_fpga_family         => G_FPGA_FAMILY,
            g_implementation      => G_FIFO_IMPLEMENTATION,
            g_dual_clock          => false,
            g_axi4s_descr         => C_FIFO_DESC,
            g_wr_adr_width        => C_FIFO_WIDTH,
            g_prog_full_val       => C_FIFO_CAPCACITY - 3,
            g_in_tdata_nof_bytes  => G_UDP_CORE_BYTES,
            g_out_tdata_nof_bytes => G_UDP_CORE_BYTES,
            g_hold_last_read      => false
        )
        port map(
            s_axi_clk    => clk,
            s_axi_rst_n  => rst_s_n,
            m_axi_clk    => clk,
            m_axi_rst_n  => rst_s_n,
            axi4s_s_mosi => udp_s_mosi_int,
            axi4s_s_miso => udp_s_miso_int,
            axi4s_m_mosi => udp_m_mosi_int,
            axi4s_m_miso => udp_m_miso_int
        );

    -- Calculates IP & UDP length Fields for UDP Packets
    inst_udp_ip_pkt_len : entity udp_core_lib.udp_ip_pkt_len
        generic map(
            G_UDP_CORE_BYTES => G_UDP_CORE_BYTES
        )
        port map(
            udp_core_clk     => clk,
            udp_core_rst_s_n => rst_s_n,
            en               => udp_s_mosi_int.tvalid,
            fxd_pkt_sze      => '0',
            keep             => axi4s_udp_s_mosi.tkeep(G_UDP_CORE_BYTES - 1 downto 0),
            last             => axi4s_udp_s_mosi.tlast,
            ip_length_base   => std_logic_vector(to_unsigned(28, 16)),
            udp_length_base  => std_logic_vector(to_unsigned(8, 16)),
            ip_length        => ip_length_int,
            udp_length       => udp_length_int,
            length_strb      => lengths_ready
        );

    tx_handling_data_proc : process(clk)
    begin
        if (rising_edge(clk)) then
            if (rst_s_n = '0') then
                --reset
                valid_last  <= '1';
                allow_input <= '1';
                send_frame  <= '0';
                ip_length   <= (others => '0');
                udp_length  <= (others => '0');
                udp_rdy     <= '0';
                farm_mode_pos_out <= (others => '0');
            else
                --Register udp start signal
                start_frame <= udp_start;

                if udp_s_mosi_int.tvalid = '1' then
                    valid_last <= axi4s_udp_s_mosi.tlast;
                end if;

                --Pause Input Once Full Packet Until Until UDP Starts Preparing
                if udp_s_mosi_int.tvalid = '1' and udp_s_mosi_int.tlast = '1' then
                    allow_input <= '0';
                elsif udp_preparing = '1' then
                    allow_input <= '1';
                end if;

                --If start of packet and not single word packet, assert continue signal
                if start_frame = '1' and udp_m_mosi_int.tlast = '0' then
                    send_frame <= '1';
                --Deassert continue signal if last
                elsif udp_m_mosi_int.tlast = '1' and udp_m_mosi_int.tvalid = '1' and udp_m_miso_int.tready = '1' then
                    send_frame <= '0';
                end if;

                if start_of_frame = '1' then
                    farm_pos_reg <= axi4s_udp_s_mosi.tid(7 downto 0);
                    udp_tuser_reg <= axi4s_udp_s_mosi.tid(31 downto 0);
                end if;

                if lengths_ready = '1' then
                    ip_length         <= ip_length_int;
                    udp_length        <= udp_length_int;
                    udp_rdy           <= '1';
                    farm_mode_pos_out <= farm_pos_reg;
                    udp_tuser_out     <= udp_tuser_reg;
                elsif udp_preparing = '1' then
                    udp_rdy <= '0';
                end if;
            end if;
        end if;
    end process;

end architecture behavioural;
