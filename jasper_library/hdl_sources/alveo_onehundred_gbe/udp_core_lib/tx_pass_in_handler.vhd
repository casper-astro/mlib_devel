-- <h---------------------------------------------------------------------------
--! @file tx_pass_in_handler.vhd
--! @page txpassinhandler Tx Pass In Handler
--!
--! \includedoc esdg_stfc_image.md
--!
--! ### Brief ###
--! Receives & Buffers external IPV4 or Ethernet Packets & prepares them to be
--! transmitted. Sidechannel data to construct the packet headers are passed
--! using tuser & tid and presented with the packet ready signal.
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

library common_mem_lib;
use common_mem_lib.common_mem_pkg.all;

library axi4_lib;
use axi4_lib.axi4s_pkg.all;

entity tx_pass_in_handler is
    generic(
        G_FPGA_VENDOR           : string  := "xilinx";                              --! Selects the FPGA Vendor for Compilation
        G_FPGA_FAMILY           : string  := "all";                                 --! Selects the FPGA Family for Compilation
        G_FIFO_IMPLEMENTATION   : string  := "auto";                                --! Selects how the Fitter implements the FIFO Memory
        G_UDP_CORE_BYTES        : natural := 8;                                     --! Width Of Data Bus In Bytes
        G_TUSER_WIDTH           : natural := 32;                                    --! TUSER Is Used To Pass Side Channel Data Depending On IPV4 Or Ethernet Packet (eg. Type, Length)
        G_TID_WIDTH             : natural := 8;                                     --! TID
        G_EXT_FIFO_CAP          : integer := (64 * 8)                               --! How much FIFO Space To Allocate TO Incoming Packets
    );
    port(
        core_clk                : in  std_logic;                                    --! Tx Path Clk
        core_rst_s_n            : in  std_logic;                                    --! Tx Path active low synchronous reset
        payload_in_clk          : in  std_logic;                                    --! Data in Clk
        payload_in_rst_n        : in  std_logic;                                    --! Data in active low synchronous reset
        payload_in_axi4s_mosi   : in  t_axi4s_mosi;                                 --! Data in
        payload_in_axi4s_miso   : out t_axi4s_miso;                                 --! Data in Backpressure
        pass_in_rdy             : out std_logic;                                    --! Output ready Signal out
        start_frame             : in  std_logic;                                    --! Start Output Signal in
        pass_tid                : out std_logic_vector(G_TID_WIDTH - 1 downto 0);   --! Sidechannel TID Out
        pass_tuser              : out std_logic_vector(G_TUSER_WIDTH - 1 downto 0); --! Sidechannel TUSER Out
        payload_out_mosi        : out t_axi4s_mosi                                  --! Axi4s Packet Data Out
    );
end entity tx_pass_in_handler;

architecture behavioural of tx_pass_in_handler is
    -- Calculate the FIFO Address Width Based on G_LL_BYTES and C_TOTAL_FIFO_BYTES:
    constant C_FIFO_ADDR_WIDTH : integer       := udp_maximum(3, log_2_ceil(G_EXT_FIFO_CAP / (G_UDP_CORE_BYTES * 8)));
    constant C_FIFO_DESC       : t_axi4s_descr := (tdata_nof_bytes => G_UDP_CORE_BYTES,
                                                   tid_width       => G_TID_WIDTH,
                                                   tuser_width     => G_TUSER_WIDTH,
                                                   has_tlast       => 1,
                                                   has_tkeep       => 1,
                                                   has_tid         => 1,
                                                   has_tuser       => 1);

    type t_tx_pass_in_next_state is (
        idle,
        data
    );

    signal tx_pass_in_next_state : t_tx_pass_in_next_state := idle;
    signal last_valid_was_last   : std_logic;
    signal axi4s_mosi_int        : t_axi4s_mosi;
    signal axi4s_miso_int        : t_axi4s_miso;
    signal sending_frame         : std_logic;

begin
    axi4s_miso_int.tready <= start_frame or sending_frame;

    ipvr_fifo_inst : entity axi4_lib.axi4s_fifo
        generic map(
            g_fpga_vendor         => G_FPGA_VENDOR,
            g_fpga_family         => G_FPGA_FAMILY,
            g_implementation      => G_FIFO_IMPLEMENTATION,
            g_dual_clock          => false,
            g_wr_adr_width        => C_FIFO_ADDR_WIDTH,
            g_axi4s_descr         => C_FIFO_DESC,
            g_in_tdata_nof_bytes  => G_UDP_CORE_BYTES,
            g_out_tdata_nof_bytes => G_UDP_CORE_BYTES
        )
        port map(
            s_axi_clk    => payload_in_clk,
            s_axi_rst_n  => payload_in_rst_n,
            m_axi_clk    => core_clk,
            m_axi_rst_n  => core_rst_s_n,
            axi4s_s_mosi => payload_in_axi4s_mosi,
            axi4s_s_miso => payload_in_axi4s_miso,
            axi4s_m_mosi => axi4s_mosi_int,
            axi4s_m_miso => axi4s_miso_int
        );

    proc_sof : process(core_clk)
    begin
        if rising_edge(core_clk) then
            if core_rst_s_n = '0' then
                last_valid_was_last <= '0';
            else
                if axi4s_mosi_int.tvalid = '1' then
                    last_valid_was_last <= axi4s_mosi_int.tlast;
                end if;
            end if;
        end if;
    end process;

    tx_incoming_udp_data_proc : process(core_clk)
    begin
        if (rising_edge(core_clk)) then
            if (core_rst_s_n = '0') then
                tx_pass_in_next_state <= idle;
                sending_frame         <= '0';
                pass_in_rdy <= '0';
            else
                case tx_pass_in_next_state is
                    when idle =>
                        sending_frame           <= '0';
                        payload_out_mosi.tvalid <= '0';
                        if axi4s_mosi_int.tvalid = '1' then
                            pass_in_rdy           <= '1';
                            pass_tuser            <= std_logic_vector(axi4s_mosi_int.tuser(G_TUSER_WIDTH - 1 downto 0));
                            pass_tid              <= std_logic_vector(axi4s_mosi_int.tid(G_TID_WIDTH - 1 downto 0));
                            tx_pass_in_next_state <= data;
                        end if;

                    when data =>
                        if (start_frame or sending_frame) = '1' then
                            pass_in_rdy                                               <= '0';
                            sending_frame                                             <= '1';
                            tx_pass_in_next_state                                     <= data;
                            payload_out_mosi.tvalid                                   <= '1';
                            payload_out_mosi.tdata(G_UDP_CORE_BYTES * 8 - 1 downto 0) <= axi4s_mosi_int.tdata(G_UDP_CORE_BYTES * 8 - 1 downto 0);
                            payload_out_mosi.tkeep(G_UDP_CORE_BYTES - 1 downto 0)     <= axi4s_mosi_int.tkeep(G_UDP_CORE_BYTES - 1 downto 0);
                            payload_out_mosi.tlast                                    <= '0';
                            if axi4s_mosi_int.tlast = '1' then
                                sending_frame          <= '0';
                                tx_pass_in_next_state  <= idle;
                                payload_out_mosi.tlast <= '1';
                            end if;
                        end if;

                end case;
            end if;
        end if;
    end process;

end architecture behavioural;
