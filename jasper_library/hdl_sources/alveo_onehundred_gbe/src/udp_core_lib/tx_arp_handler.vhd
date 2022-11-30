-- <h---------------------------------------------------------------------------
--! @file tx_arp_handler.vhd
--! @page txarphandlerpage Tx ARP Handler
--!
--! \includedoc esdg_stfc_image.md
--!
--! ### Brief ###
--! Module to send and receive ARP requests and replies. Interfaces with LUT
--! mem to read MAC address to ARP request to, and write IP address received in
--! reply. Interfaces with the ARP control & status memory maps.
--!
--! \includedoc txarphandler.md
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
use axi4_lib.axi4lite_pkg.all;

use udp_core_lib.axi4lite_arp_mode_control_pkg.all;

entity tx_arp_handler is
    generic(
        G_FPGA_VENDOR           : string  := "xilinx";                      --! Selects the FPGA Vendor for Compilation
        G_FPGA_FAMILY           : string  := "all";                         --! Selects the FPGA Family for Compilation
        G_FIFO_IMPLEMENTATION   : string  := "auto";                        --! Selects how the Fitter implements the FIFO Memory
        G_UDP_CORE_BYTES        : natural := 8;                             --! Width of the Data Bus in Bytes
        G_NUM_OF_POS            : integer := 4;                             --! Number Of ARP Positions In Use
        G_CORE_FREQ_KHZ         : integer := 156250                         --! Used to Calibrate the Refresh Timers
    );
    port(
        axi4lite_aclk           : in  std_logic;                            --! AXI4-Lite Clock
        axi4lite_aresetn        : in  std_logic;                            --! AXI4-Lite Asyncrounous Active Low Reset
        clk                     : in  std_logic;                            --! Main Tx Path Clk
        rst_s_n                 : in  std_logic;                            --! Active Low synchronous Reset
        tx_arp_s_mosi           : in  t_axi4s_mosi;                         --! Axi4s ARP Data From Rx to Tx Path FIFO
        tx_arp_s_miso           : out t_axi4s_miso;                         --! Axi4s ARP Backpressure To Rx to Tx Path FIFO
        tx_arp_m_mosi           : out t_axi4s_mosi;                         --! Axi4s ARP Data Out To Tx
        tx_arp_m_miso           : in  t_axi4s_miso;                         --! Axi4s ARP Backpressure From Tx
        arp_rdy                 : out std_logic;                            --! ARP Packet Is Ready To Send
        arp_done                : out std_logic;                            --! ARP Packet Has Finished
        arp_start               : in  std_logic;                            --! Signal From Arbitrator That Queued ARP Packet Can Start Sending
        core_mac_addr           : in  std_logic_vector(6 * 8 - 1 downto 0); --! Core MAC Address, passed from Axi4lite Memory Map
        core_ip_addr            : in  std_logic_vector(4 * 8 - 1 downto 0); --! Core IP Address, passed from Axi4lite Memory Map
        lut_ip_addr             : in  std_logic_vector(4 * 8 - 1 downto 0); --! Read IP Address From LUT, Set In Control Plane 7 Used To Request MAC Addresses
        mac_addr_out            : out std_logic_vector(6 * 8 - 1 downto 0); --! MAC Address to Header Constructor module for Layer 2 Header in Requests and Replies
        arp_axi4lite_mosi       : in  t_axi4lite_mosi;                      --! Axi4lite MM Arrays for Control and Status Regs
        arp_axi4lite_miso       : out t_axi4lite_miso;                      --! Axi4lite MM Arrays for Control and Status Regs
        arp_lut_addr            : out std_logic_vector(7 downto 0);         --! Position in LUT
        arp_read_lut            : out std_logic;                            --! Start LUT Read
        arp_write_lut           : out std_logic;                            --! Start LUT Write
        lower_mac_addr_wr       : out std_logic_vector(31 downto 0);        --! Lower MAC Address To Write To LUT, split up due to 32 bit size of MM reg
        upper_mac_addr_wr       : out std_logic_vector(15 downto 0)         --! Upper MAC Address To Write To LUT, split up due to 32 bit size of MM reg

    );
end entity tx_arp_handler;

architecture behavioural of tx_arp_handler is
    constant C_MAX_NO_POS          : integer                       := 256;
    constant C_MAX_WIDTH           : integer                       := 64;
    constant C_OUTPUT_LENGTH       : integer                       := 28;
    constant C_TOTAL_FIFO_BYTES    : integer                       := 129; -- Store Over 2 * 64 byte Packets
    constant C_FIFO_WIDTH          : integer                       := udp_maximum(C_FIFO_MIN_WIDTH, log_2_ceil(C_TOTAL_FIFO_BYTES / G_UDP_CORE_BYTES));
    constant C_FIFO_CAPCACITY      : integer                       := 2**C_FIFO_WIDTH;
    constant C_OUTPUT_REG_LENGTH   : integer                       := header_words(C_OUTPUT_LENGTH, G_UDP_CORE_BYTES) + 1;
    constant C_TOTAL_REG_LENGTH    : integer                       := header_words((64 - 14), G_UDP_CORE_BYTES) + 1;
    constant C_LAST_BYTE_POS       : integer                       := udp_maximum(((64 - 14) rem G_UDP_CORE_BYTES) - 1, 0);
    constant C_REG_LENGTH          : integer                       := 64;
    constant C_REFRESH_DEFAULT     : std_logic_vector(15 downto 0) := X"0007";
    constant C_REQ_HTYPE           : std_logic_vector(15 downto 0) := X"0100";
    constant C_REQ_PTYPE           : std_logic_vector(15 downto 0) := X"0008";
    constant C_REQ_HLEN            : std_logic_vector(7 downto 0)  := X"06";
    constant C_REQ_PLEN            : std_logic_vector(7 downto 0)  := X"04";
    constant C_REQ_OPER            : std_logic_vector(15 downto 0) := X"0100";
    constant C_ARP_REFRESH_TIME_MS : integer                       := 100; --The order of time units that the Refresh Timeout CTRL Register Sets
    constant C_ARP_REQ_LENGTH      : integer                       := 12;
    constant C_ARP_REF_LENGTH      : integer                       := 16;

    constant C_ARP_ENTRY_RST : t_axi4lite_arp_mode_control_arp_mode_entry_status := (active => '0',
                                                                                     timed_out => '0',
                                                                                     seen_response => '0',
                                                                                     request_sent => '0',
                                                                                     request_timeout => X"000",
                                                                                     refresh_timeout => C_REFRESH_DEFAULT);

    --Intermediate MOSI/MISO signals
    signal axi4s_arp_out_int_mosi : t_axi4s_mosi;
    signal axi4s_arp_out_int_miso : t_axi4s_miso;
    signal axi4s_arp_in_int_mosi  : t_axi4s_mosi;
    signal axi4s_arp_in_int_miso  : t_axi4s_miso;

    --Input and Queued Output ARP Registers & Aliases
    signal arp_into_complete   : std_logic_vector(C_REG_LENGTH * 8 - 1 downto 0)                           := (others => '0');
    signal arp_output_complete : std_logic_vector(C_OUTPUT_REG_LENGTH * G_UDP_CORE_BYTES * 8 - 1 downto 0) := (others => '0');
    alias arp_into_htype       : std_logic_vector(15 downto 0) is arp_into_complete(2 * 8 - 1 downto 0 * 8);
    alias arp_into_ptype       : std_logic_vector(15 downto 0) is arp_into_complete(4 * 8 - 1 downto 2 * 8);
    alias arp_into_hlen        : std_logic_vector(7 downto 0) is arp_into_complete(5 * 8 - 1 downto 4 * 8);
    alias arp_into_plen        : std_logic_vector(7 downto 0) is arp_into_complete(6 * 8 - 1 downto 5 * 8);
    alias arp_into_oper        : std_logic_vector(15 downto 0) is arp_into_complete(8 * 8 - 1 downto 6 * 8);
    alias arp_into_sha         : std_logic_vector(47 downto 0) is arp_into_complete(14 * 8 - 1 downto 8 * 8);
    alias arp_into_spa         : std_logic_vector(31 downto 0) is arp_into_complete(18 * 8 - 1 downto 14 * 8);
    alias arp_into_tha         : std_logic_vector(47 downto 0) is arp_into_complete(24 * 8 - 1 downto 18 * 8);
    alias arp_into_tpa         : std_logic_vector(31 downto 0) is arp_into_complete(28 * 8 - 1 downto 24 * 8);
    alias arp_output_htype     : std_logic_vector(15 downto 0) is arp_output_complete(2 * 8 - 1 downto 0 * 8);
    alias arp_output_ptype     : std_logic_vector(15 downto 0) is arp_output_complete(4 * 8 - 1 downto 2 * 8);
    alias arp_output_hlen      : std_logic_vector(7 downto 0) is arp_output_complete(5 * 8 - 1 downto 4 * 8);
    alias arp_output_plen      : std_logic_vector(7 downto 0) is arp_output_complete(6 * 8 - 1 downto 5 * 8);
    alias arp_output_oper      : std_logic_vector(15 downto 0) is arp_output_complete(8 * 8 - 1 downto 6 * 8);
    alias arp_output_sha       : std_logic_vector(47 downto 0) is arp_output_complete(14 * 8 - 1 downto 8 * 8);
    alias arp_output_spa       : std_logic_vector(31 downto 0) is arp_output_complete(18 * 8 - 1 downto 14 * 8);
    alias arp_output_tha       : std_logic_vector(47 downto 0) is arp_output_complete(24 * 8 - 1 downto 18 * 8);
    alias arp_output_tpa       : std_logic_vector(31 downto 0) is arp_output_complete(28 * 8 - 1 downto 24 * 8);

    --LUT and status signals
    signal request_lut_pos : integer range 0 to G_NUM_OF_POS - 1;
    signal ip_addr_request : std_logic_vector(31 downto 0);
    signal arp_sending     : std_logic := '0';

    signal axi4lite_arp_mode_control_out_we : t_axi4lite_arp_mode_control_decoded;
    signal axi4lite_arp_mode_control_out    : t_axi4lite_arp_mode_control;
    signal axi4lite_arp_mode_control_in_we  : t_axi4lite_arp_mode_control_decoded;
    signal axi4lite_arp_mode_control_in     : t_axi4lite_arp_mode_control;

    signal arp_status_array_in                  : t_axi4lite_arp_mode_control_arp_mode_entry; -- := (others => C_ARP_ENTRY_RST);
    signal request_sent                         : std_logic_vector(G_NUM_OF_POS - 1 downto 0);
    signal pos_active_ctrl, pos_active_ctrl_reg : std_logic_vector(C_MAX_NO_POS - 1 downto 0);
    signal rst_timers_n, rst_timers_n_reg       : std_logic_vector(G_NUM_OF_POS - 1 downto 0);
    signal need_request, need_request_reg       : std_logic_vector(G_NUM_OF_POS - 1 downto 0);
    signal arp_active, arp_active_reg           : std_logic;
    signal refresh_counting                     : std_logic_vector(G_NUM_OF_POS - 1 downto 0);
    signal position_timed_out                   : std_logic_vector(G_NUM_OF_POS - 1 downto 0);
    signal stop_request_timer                   : std_logic_vector(G_NUM_OF_POS - 1 downto 0);
    signal seen_response                        : std_logic_vector(G_NUM_OF_POS - 1 downto 0);
    signal request_start                        : std_logic_vector(G_NUM_OF_POS - 1 downto 0);
    signal refresh_start                        : std_logic_vector(G_NUM_OF_POS - 1 downto 0);
    signal output_request                       : std_logic := '1';
    signal reply_delay_toggle                   : std_logic;
    signal mac_addr                             : std_logic_vector(47 downto 0);
    signal int_arp_s_miso                       : t_axi4s_miso;
    signal int_arp_s_mosi                       : t_axi4s_mosi;
    signal count_increment                      : std_logic;

    --States
    type t_tx_arp_handler_next_state is (
        idle,
        check_positions,
        check_incoming,
        wait_for_lut,
        arp_receiving,
        verify_address,
        handle_request,
        generating_request,
        handle_reply,
        reply_delay,
        output
    );

    ----------------------------------------------------------------------------------
    ---- Vendor Specific Attributes:
    ----------------------------------------------------------------------------------
    attribute syn_encoding : string;
    attribute fsm_encoding : string;
    -- Xilinx Attributes:
    attribute fsm_encoding of t_tx_arp_handler_next_state : type is "one_hot";
    -- Altera Attributes:
    attribute syn_encoding of t_tx_arp_handler_next_state : type is "safe, one-hot";

    signal tx_arp_handler_next_state : t_tx_arp_handler_next_state := idle;

begin

    tx_arp_m_mosi          <= axi4s_arp_out_int_mosi;
    axi4s_arp_out_int_miso <= tx_arp_m_miso;

    --Double Register Top Control Signals Used in State Machine Which Rely On Slow Clk MM Registers
    metastab_top_proc : process(clk)
    begin
        if rising_edge(clk) then
            --ARP Master Control
            arp_active_reg <= axi4lite_arp_mode_control_out.arp_control.arp_active;
            arp_active     <= arp_active_reg;
            --ARP Positions
            for i in 0 to 7 loop
                pos_active_ctrl_reg((i + 1) * 32 - 1 downto i * 32) <= axi4lite_arp_mode_control_out.positions_active(i);
                pos_active_ctrl((i + 1) * 32 - 1 downto i * 32)     <= pos_active_ctrl_reg((i + 1) * 32 - 1 downto i * 32);
            end loop;
        end if;
    end process;

    --Status Of ARP Table Positions
    generate_mm_status_signals : for i in 0 to G_NUM_OF_POS - 1 generate
        --Double Register Entry Control Signals Used in State Machine Which Rely On Slow Clk MM Registers
        metastab_pos_proc : process(clk)
        begin
            if rising_edge(clk) then
                rst_timers_n_reg(i) <= rst_s_n and pos_active_ctrl(i) and arp_active;
                rst_timers_n(i)     <= rst_timers_n_reg(i);
                need_request_reg(i) <= position_timed_out(i) and pos_active_ctrl(i);
                need_request(i)     <= need_request_reg(i);
            end if;
        end process;

        position_timed_out(i)                <= not refresh_counting(i);
        arp_status_array_in(i).timed_out     <= not refresh_counting(i);
        arp_status_array_in(i).request_sent  <= request_sent(i);
        arp_status_array_in(i).active        <= arp_active and pos_active_ctrl(i);
        arp_status_array_in(i).seen_response <= seen_response(i);
    end generate;

    --Control and Status Memory Maps
    axi4lite_arp_mode_control_inst : entity udp_core_lib.axi4lite_arp_mode_control
        port map(
            axi4lite_arp_mode_control_in_we  => axi4lite_arp_mode_control_in_we,
            axi4lite_arp_mode_control_in     => axi4lite_arp_mode_control_in,
            axi4lite_aclk                    => axi4lite_aclk,
            axi4lite_aresetn                 => axi4lite_aresetn,
            axi4lite_mosi                    => arp_axi4lite_mosi,
            axi4lite_miso                    => arp_axi4lite_miso,
            axi4lite_arp_mode_control_out_we => axi4lite_arp_mode_control_out_we,
            axi4lite_arp_mode_control_out    => axi4lite_arp_mode_control_out
        );

    axi4lite_arp_mode_control_in.arp_mode_entry <= arp_status_array_in;

    timer_inst : entity udp_core_lib.udp_core_timer
        generic map(
            clk_freq_in_khz  => G_CORE_FREQ_KHZ,
            pulse_time_in_ms => C_ARP_REFRESH_TIME_MS
        )
        port map(
            clk             => clk,
            rst_n           => rst_s_n,
            end_of_interval => count_increment
        );

    --Timers For Request and Refresh Timeouts
    generate_req_timers : for i in 0 to G_NUM_OF_POS - 1 generate
        constant c_fan_index       : integer := i / 16;
        signal refresh_time_out    : std_logic_vector(15 downto 0);
        signal request_time_out    : std_logic_vector(11 downto 0);
        signal request_timer_rst_n : std_logic;
    begin

        arp_status_array_in(i).refresh_timeout <= refresh_time_out;
        arp_status_array_in(i).request_timeout <= request_time_out;
        request_timer_rst_n                    <= rst_timers_n(i) and not stop_request_timer(i);

        refresh_timout_proc : process(clk) is
        begin
            if rising_edge(clk) then
                if rst_timers_n(i) = '0' then
                    refresh_time_out    <= (others => '0');
                    refresh_counting(i) <= '0';
                else
                    if refresh_start(i) = '1' then
                        refresh_counting(i) <= '1';
                        refresh_time_out    <= std_logic_vector(unsigned(axi4lite_arp_mode_control_out.arp_timeout_lengths.refresh_timeout) + 1);
                    else
                        if refresh_counting(i) = '1' then
                            if count_increment = '1' then
                                if (unsigned(refresh_time_out) = 0) then
                                    refresh_counting(i) <= '0';
                                else
                                    refresh_time_out <= std_logic_vector(unsigned(refresh_time_out) - 1);
                                end if;
                            end if;
                        end if;
                    end if;
                end if;
            end if;
        end process refresh_timout_proc;

        request_timout_proc : process(clk) is
        begin
            if rising_edge(clk) then
                if request_timer_rst_n = '0' then
                    request_time_out <= (others => '0');
                    request_sent(i)  <= '0';
                else
                    if request_start(i) = '1' then
                        request_sent(i)  <= '1';
                        request_time_out <= std_logic_vector(unsigned(axi4lite_arp_mode_control_out.arp_timeout_lengths.request_timeout) + 1);
                    else
                        if request_sent(i) = '1' then
                            if count_increment = '1' then
                                if (unsigned(request_time_out) = 0) then
                                    request_sent(i) <= '0';
                                else
                                    request_time_out <= std_logic_vector(unsigned(request_time_out) - 1);
                                end if;
                            end if;
                        end if;
                    end if;
                end if;
            end if;
        end process request_timout_proc;
    end generate;

    --State Machine Process
    tx_arp_handler_fsm_proc : process(clk)
        variable header_idx_i : integer range 0 to 64 / G_UDP_CORE_BYTES + 1 := 0;
        variable output_idx_i : integer range 0 to C_TOTAL_REG_LENGTH        := 0;
        variable check_index  : integer range 0 to G_NUM_OF_POS - 1;
    begin
        if (rising_edge(clk)) then
            if (rst_s_n = '0') then
                arp_sending                   <= '0';
                header_idx_i                  := 1;
                check_index                   := 0;
                axi4s_arp_out_int_mosi.tvalid <= '0';
                axi4s_arp_in_int_miso.tready  <= '0';
                arp_into_complete             <= (others => '0');
                arp_output_complete           <= (others => '0');
                refresh_start                 <= (others => '0');
                request_start                 <= (others => '0');
                stop_request_timer            <= (others => '0');
                seen_response                 <= (others => '0');
                arp_rdy                       <= '0';
                arp_done                      <= '0';
                arp_write_lut                 <= '0';
                arp_read_lut                  <= '0';
                tx_arp_handler_next_state     <= idle;
                arp_lut_addr                  <= (others => '0');

            else
                case tx_arp_handler_next_state is
                    when idle =>
                        arp_sending                   <= '0';
                        header_idx_i                  := 1;
                        axi4s_arp_out_int_mosi.tvalid <= '0';
                        axi4s_arp_in_int_miso.tready  <= '0';
                        axi4s_arp_out_int_mosi.tlast  <= '0';
                        arp_into_complete             <= (others => '0');
                        arp_output_complete           <= (others => '0');
                        refresh_start                 <= (others => '0');
                        request_start                 <= (others => '0');
                        stop_request_timer            <= (others => '0');
                        arp_done                      <= '0';
                        arp_rdy                       <= '0';
                        arp_write_lut                 <= '0';
                        arp_read_lut                  <= '0';
                        check_index                   := 0;

                        if axi4s_arp_in_int_mosi.tvalid = '1' then
                            tx_arp_handler_next_state    <= check_incoming;
                            axi4s_arp_in_int_miso.tready <= '1';
                        else
                            --No Request Has Been Sent, Check For Any Timed Out Positions
                            if arp_sending = '0' and unsigned(request_sent) = 0 and unsigned(need_request) /= 0 and arp_active = '1' then
                                tx_arp_handler_next_state <= check_positions;
                            end if;
                        end if;

                    when check_positions =>
                        --ARP Mode Is Active & Module Is NOT Already Waiting For A Reply
                        request_loop : for i in 0 to G_NUM_OF_POS - 1 loop
                            --Loop Through Every ARP Position & Check Status
                            if i >= check_index and need_request(i) = '1' then
                                --If A Position Is Both Timed Out & Active, Prepare To Send Request
                                request_lut_pos              <= i;
                                check_index                  := (i + 1) mod G_NUM_OF_POS;
                                arp_lut_addr                 <= std_logic_vector(to_unsigned(i, 8));
                                arp_read_lut                 <= '1';
                                axi4s_arp_in_int_miso.tready <= '0';
                                tx_arp_handler_next_state    <= wait_for_lut;
                                exit request_loop;
                            elsif i = G_NUM_OF_POS - 1 then
                                check_index               := 0;
                                tx_arp_handler_next_state <= idle;
                            end if;
                        end loop request_loop;

                    when check_incoming =>
                        if axi4s_arp_in_int_mosi.tvalid = '1' then
                            axi4s_arp_in_int_miso.tready <= '1';
                            --Handle incoming packet if there is one
                            if (G_UDP_CORE_BYTES = C_MAX_WIDTH) then
                                --Whole ARP Packet Will Fit In 1 Frame If Width Is 32, or 64
                                arp_into_complete(G_UDP_CORE_BYTES * 8 - 1 downto 0) <= axi4s_arp_in_int_mosi.tdata(G_UDP_CORE_BYTES * 8 - 1 downto 0);
                                axi4s_arp_in_int_miso.tready                         <= '0';
                                if axi4s_arp_in_int_mosi.tdata(8 * 8 - 1 downto 6 * 8) = X"0100" then
                                    --Replies Are Always Sent to Incoming Requests
                                    tx_arp_handler_next_state <= handle_request;
                                else
                                    --Replies Are Only Expected If ARP Ise Set To Active
                                    tx_arp_handler_next_state <= verify_address;
                                end if;
                            else
                                --The incoming packet is read over several CLK cycles
                                arp_into_complete(G_UDP_CORE_BYTES * 8 - 1 downto 0) <= axi4s_arp_in_int_mosi.tdata(G_UDP_CORE_BYTES * 8 - 1 downto 0);
                                tx_arp_handler_next_state                            <= arp_receiving;
                                header_idx_i                                         := header_idx_i + 1;
                                arp_rdy                                              <= '0';
                            end if;
                        else
                            axi4s_arp_in_int_miso.tready <= '0';
                            tx_arp_handler_next_state    <= idle;
                        end if;

                    when wait_for_lut =>
                        --Wait Cycle To Allow LUT IP Address To Be Read
                        tx_arp_handler_next_state <= generating_request;
                        arp_read_lut              <= '0';

                    when generating_request =>
                        --Set ARP Request Fields
                        arp_output_htype          <= C_REQ_HTYPE;
                        arp_output_ptype          <= C_REQ_PTYPE;
                        arp_output_hlen           <= C_REQ_HLEN;
                        arp_output_plen           <= C_REQ_PLEN;
                        arp_output_oper           <= C_REQ_OPER;
                        arp_output_sha            <= core_mac_addr;
                        arp_output_spa            <= core_ip_addr;
                        arp_output_tha            <= (others => '1');
                        arp_output_tpa            <= byte_reverse(lut_ip_addr);
                        ip_addr_request           <= byte_reverse(lut_ip_addr);
                        mac_addr_out              <= (others => '1');
                        output_idx_i              := 0;
                        output_request            <= '1';
                        arp_rdy                   <= '1';
                        tx_arp_handler_next_state <= output;

                    when arp_receiving =>
                        --Receive Rest Of Incoming ARP Packet
                        if axi4s_arp_in_int_mosi.tvalid = '1' then
                            arp_into_complete((G_UDP_CORE_BYTES * header_idx_i) * 8 - 1 downto (G_UDP_CORE_BYTES * (header_idx_i - 1) * 8)) <= axi4s_arp_in_int_mosi.tdata(G_UDP_CORE_BYTES * 8 - 1 downto 0);

                            if axi4s_arp_in_int_mosi.tlast = '1' then
                                axi4s_arp_in_int_miso.tready <= '0';
                                if (arp_into_oper = X"0100") then
                                    tx_arp_handler_next_state <= handle_request; --Request
                                else
                                    tx_arp_handler_next_state <= verify_address; --Reply
                                end if;
                            else
                                header_idx_i := header_idx_i + 1;
                            end if;
                        end if;

                    when verify_address =>
                        --This State was split from handle reply to meet timing
                        mac_addr <= byte_reverse(arp_into_sha);
                        if (arp_into_tha = core_mac_addr and arp_into_tpa = core_ip_addr and arp_into_spa = ip_addr_request) then
                            tx_arp_handler_next_state <= handle_reply;
                        else
                            tx_arp_handler_next_state <= idle;
                        end if;

                    when handle_reply =>
                        --Deal With Incoming Reply
                        --If ARP Networking Addresses Match This Core's Own, and The Requested IP, Then Write LUT Entry
                        refresh_start(request_lut_pos)      <= '1';
                        stop_request_timer(request_lut_pos) <= '1';
                        arp_lut_addr                        <= std_logic_vector(to_unsigned(request_lut_pos, 8));
                        arp_write_lut                       <= '1';
                        lower_mac_addr_wr                   <= mac_addr(31 downto 0);
                        upper_mac_addr_wr                   <= mac_addr(47 downto 32);
                        seen_response(request_lut_pos)      <= '1';
                        arp_rdy                             <= '0';
                        axi4s_arp_in_int_miso.tready        <= '0';
                        reply_delay_toggle                  <= '0';
                        tx_arp_handler_next_state           <= reply_delay;

                    when reply_delay =>
                        --Delay to allow status registers to update before returning to idle, prevents duplicate requests
                        reply_delay_toggle <= '1';
                        if reply_delay_toggle = '1' then
                            tx_arp_handler_next_state <= idle;
                        end if;

                    when handle_request =>
                        --Deal With Incoming Request
                        if arp_into_tpa = core_ip_addr then
                            --If Requested IP Matches Core's Own, Send Reply
                            arp_output_htype          <= arp_into_htype;
                            arp_output_ptype          <= arp_into_ptype;
                            arp_output_hlen           <= arp_into_hlen;
                            arp_output_plen           <= arp_into_plen;
                            arp_output_oper           <= X"0200";
                            arp_output_sha            <= core_mac_addr;
                            arp_output_spa            <= core_ip_addr;
                            arp_output_tha            <= arp_into_sha;
                            arp_output_tpa            <= arp_into_spa;
                            mac_addr_out              <= arp_into_sha;
                            arp_rdy                   <= '1';
                            output_idx_i              := 0;
                            tx_arp_handler_next_state <= output;
                            output_request            <= '0';
                        else
                            tx_arp_handler_next_state <= idle;
                        end if;

                    when output =>
                        --Wait For Arbitrator To Say The Tx Path Is Free
                        request_start(request_lut_pos) <= arp_start and output_request;
                        if arp_start = '1' or arp_sending = '1' then
                            arp_rdy     <= '0';
                            arp_sending <= '1';
                            if output_idx_i = 0 then
                                --Start of output
                                axi4s_arp_out_int_mosi.tdata(G_UDP_CORE_BYTES * 8 - 1 downto 0) <= arp_output_complete(8 * (G_UDP_CORE_BYTES * (output_idx_i + 1)) - 1 downto 8 * G_UDP_CORE_BYTES * output_idx_i);
                                output_idx_i                                                    := output_idx_i + 1;
                                axi4s_arp_out_int_mosi.tvalid                                   <= '1';
                                if C_TOTAL_REG_LENGTH <= 1 then
                                    --Wide Core Width Mean ARP Packet Only Requires 1 CLK Cycle
                                    axi4s_arp_out_int_mosi.tlast                                <= '1';
                                    axi4s_arp_out_int_mosi.tkeep(G_UDP_CORE_BYTES - 1 downto 0) <= int_to_tkeep(C_LAST_BYTE_POS, G_UDP_CORE_BYTES);
                                    tx_arp_handler_next_state                                   <= idle;
                                    axi4s_arp_in_int_miso.tready                                <= '0';
                                    arp_done                                                    <= '1';
                                end if;
                            elsif output_idx_i < C_OUTPUT_REG_LENGTH then
                                --Keep outputting ARP request or reply
                                axi4s_arp_out_int_mosi.tdata(G_UDP_CORE_BYTES * 8 - 1 downto 0) <= arp_output_complete(8 * (G_UDP_CORE_BYTES * (output_idx_i + 1)) - 1 downto 8 * G_UDP_CORE_BYTES * output_idx_i);
                                output_idx_i                                                    := output_idx_i + 1;
                                axi4s_arp_out_int_mosi.tvalid                                   <= '1';
                            else
                                --Continue To Pad Out Packet With Zeros Until Required Minimum Length (64 Bytes Including the Layer 2 Header)
                                axi4s_arp_out_int_mosi.tdata(G_UDP_CORE_BYTES * 8 - 1 downto 0) <= (others => '0');

                                if output_idx_i = (C_TOTAL_REG_LENGTH - 1) then
                                    --Finished output, Set Last Byte Position
                                    output_idx_i                                                := 0;
                                    axi4s_arp_out_int_mosi.tlast                                <= '1';
                                    axi4s_arp_out_int_mosi.tkeep(G_UDP_CORE_BYTES - 1 downto 0) <= int_to_tkeep(C_LAST_BYTE_POS, G_UDP_CORE_BYTES);
                                    axi4s_arp_in_int_miso.tready                                <= '0';
                                    arp_rdy                                                     <= '0';
                                    arp_done                                                    <= '1';
                                    tx_arp_handler_next_state                                   <= idle;
                                else
                                    output_idx_i := (output_idx_i + 1) mod C_TOTAL_REG_LENGTH;
                                end if;
                            end if;
                        end if;
                end case;
            end if;
        end if;
    end process;

    --Incoming ARP Data FIFO
    arp_axi4s_fifo_inst : entity axi4_lib.axi4s_fifo
        generic map(
            g_fpga_vendor         => G_FPGA_VENDOR,
            g_fpga_family         => G_FPGA_FAMILY,
            g_implementation      => G_FIFO_IMPLEMENTATION,
            g_dual_clock          => false,
            g_wr_adr_width        => C_FIFO_WIDTH,
            g_prog_full_val       => C_FIFO_CAPCACITY - 3,
            g_in_tdata_nof_bytes  => G_UDP_CORE_BYTES,
            g_out_tdata_nof_bytes => G_UDP_CORE_BYTES
        )
        port map(
            s_axi_clk    => clk,
            s_axi_rst_n  => rst_s_n,
            m_axi_clk    => clk,
            m_axi_rst_n  => rst_s_n,
            axi4s_s_mosi => int_arp_s_mosi,
            axi4s_s_miso => int_arp_s_miso,
            axi4s_m_mosi => axi4s_arp_in_int_mosi,
            axi4s_m_miso => axi4s_arp_in_int_miso
        );

    tx_arp_s_miso.tready    <= int_arp_s_miso.tready and not int_arp_s_miso.prog_full;
    tx_arp_s_miso.prog_full <= int_arp_s_miso.prog_full;
    --Manually Assign tvalid to reflect different outgoing tready
    int_arp_s_mosi.tvalid   <= tx_arp_s_mosi.tvalid and int_arp_s_miso.tready and not int_arp_s_miso.prog_full;
    int_arp_s_mosi.tdata    <= tx_arp_s_mosi.tdata;
    int_arp_s_mosi.tkeep    <= tx_arp_s_mosi.tkeep;
    int_arp_s_mosi.tlast    <= tx_arp_s_mosi.tlast;

end architecture behavioural;
