-- <h---------------------------------------------------------------------------
--! @file tx_byte_slip.vhd
--! @page txbyteslippage Tx Byte Slip
--!
--! \includedoc esdg_stfc_image.md
--!
--! ### Brief ####
--! Combines header and payload data streams, slipping the data by a set number
--! of bytes depending on the packet type to ensure continuous data. A second
--! process pads the packet to the minimum ethernet requirements if necessary.
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

entity tx_byte_slip is
    generic(
        G_FPGA_VENDOR           : string  := "xilinx";                                      --! Selects the FPGA Vendor for Compilation
        G_FPGA_FAMILY           : string  := "all";                                         --! Selects the FPGA Family for Compilation
        G_FIFO_IMPLEMENTATION   : string  := "auto";                                        --! Selects how the Fitter implements the FIFO Memory
        G_UDP_CORE_BYTES        : natural := 8                                              --! Width of Data Bus In Bytes
    );
    port(
        clk                     : in  std_logic;                                            --! Clk
        rst_s_n                 : in  std_logic;                                            --! Active Low synchronous Reset
        header_data             : in  std_logic_vector(G_UDP_CORE_BYTES * 8 - 1 downto 0);  --! Header Data From Header Constructor
        header_last             : in  std_logic;                                            --! Tlast Flag Of Header Data
        header_valid            : in  std_logic;                                            --! Tvalid Flag Of Header Data
        payload_data            : in  std_logic_vector(G_UDP_CORE_BYTES * 8 - 1 downto 0);  --! Payload Data From One Of the Packet Handlers
        payload_keep            : in  std_logic_vector(G_UDP_CORE_BYTES - 1 downto 0);      --! TKeep Of Payload, Identifies the Last Valid Byte
        payload_last            : in  std_logic;                                            --! Tlast Flag of Payload Data
        payload_valid           : in  std_logic;                                            --! Tvalid Flag of Payload Data
        out_data                : out std_logic_vector(G_UDP_CORE_BYTES * 8 - 1 downto 0);  --! Slipped Full Packet Data
        out_keep                : out std_logic_vector(G_UDP_CORE_BYTES - 1 downto 0);      --! Slipped Full Packet TKeep
        out_last                : out std_logic;                                            --! Slipped Full Packet Tlast
        out_valid               : out std_logic;                                            --! Slipped Full Packet Tvalid
        type_frame              : in  std_logic_vector(3 downto 0)                          --! Type Frame Dictates How Many Bytes To Slip By
    );
end entity tx_byte_slip;

architecture behavioural of tx_byte_slip is

    type t_tx_udp_handler_next_state is (
        idle,
        header,
        slipping_word,
        no_slip_word,
        extra_word,
        final_word
    );

    constant C_HEADER_UDP  : integer                                             := 42;
    constant C_HEADER_ARP  : integer                                             := 14;
    constant C_HEADER_PING : integer                                             := 34;
    constant C_UDP_SLIP    : integer                                             := C_HEADER_UDP rem G_UDP_CORE_BYTES;
    constant C_ARP_SLIP    : integer                                             := C_HEADER_ARP rem G_UDP_CORE_BYTES;
    constant C_PING_SLIP   : integer                                             := C_HEADER_PING rem G_UDP_CORE_BYTES;
    constant C_ONES        : std_logic_vector(G_UDP_CORE_BYTES * 8 - 1 downto 0) := (others => '1');
    constant C_MIN_LENGTH  : integer                                             := 60; --Ethernet Minimum Requirement Not including 4 byte CRC
    constant C_MIN_WORDS   : integer                                             := C_MIN_LENGTH / G_UDP_CORE_BYTES; --How many Full Words To Hit Ethernet Min Requirement
    constant C_MIN_REM     : integer                                             := C_MIN_LENGTH mod G_UDP_CORE_BYTES; --Partial Bytes of Last Word To Hit Ethernet Min Requirement

    signal tx_byte_slip_next_state : t_tx_udp_handler_next_state := idle;
    signal type_frame_int          : std_logic_vector(3 downto 0);
    signal header_data_reg         : std_logic_vector(G_UDP_CORE_BYTES * 8 - 1 downto 0);
    signal header_valid_reg        : std_logic;
    signal header_last_reg         : std_logic;
    signal payload_data_reg        : std_logic_vector(G_UDP_CORE_BYTES * 8 - 1 downto 0);
    signal payload_keep_reg        : std_logic_vector(G_UDP_CORE_BYTES - 1 downto 0);
    signal payload_valid_reg       : std_logic;
    signal payload_last_reg        : std_logic;
    signal payload_data_old        : std_logic_vector(G_UDP_CORE_BYTES * 8 - 1 downto 0);
    signal payload_keep_old        : std_logic_vector(G_UDP_CORE_BYTES - 1 downto 0);
    signal payload_valid_old       : std_logic;
    signal payload_last_old        : std_logic;
    signal slip_value              : integer range 0 to G_UDP_CORE_BYTES - 1;
    signal padd_word_count         : integer range 0 to C_MIN_WORDS + 1;
    signal padding                 : std_logic;
    signal int_data                : std_logic_vector(G_UDP_CORE_BYTES * 8 - 1 downto 0); --! Slipped Full Packet Data
    signal int_keep                : std_logic_vector(G_UDP_CORE_BYTES - 1 downto 0); --! Slipped Full Packet TKeep
    signal int_last                : std_logic; --! Slipped Full Packet Tlast
    signal int_valid               : std_logic; --! Slipped Full Packet Tvalid

begin

    --Select Slip Value To Use By Packet Type
    with type_frame_int select slip_value <=
        C_UDP_SLIP when "0000",
        C_ARP_SLIP when "0001",
                    C_PING_SLIP when "0010",
                    C_PING_SLIP when "0011",
                    C_ARP_SLIP when  "0100",
                    C_UDP_SLIP when others;

    --Process To Register Inputs From Header and Various Payload Sources
    reg_inputs_proc : process(clk)
    begin
        if (rising_edge(clk)) then
            --Header Reg
            if header_valid = '1' then
                type_frame_int   <= type_frame;
                header_data_reg  <= header_data;
                header_valid_reg <= header_valid;
                header_last_reg  <= header_last;
            else
                header_valid_reg <= '0';
            end if;
            --Payload Data Reg
            if payload_valid = '1' then
                payload_data_reg  <= payload_data;
                payload_keep_reg  <= payload_keep;
                payload_valid_reg <= payload_valid;
                payload_last_reg  <= payload_last;
            else
                payload_valid_reg <= '0';
            end if;
            --Additional Payload Reg Used When No Slipping (widths 4 and under)
            if payload_valid_reg = '1' then
                payload_data_old  <= payload_data_reg;
                payload_valid_old <= '1';
                payload_last_old  <= payload_last_reg;
                payload_keep_old  <= payload_keep_reg;
            else
                payload_valid_old <= '0';
            end if;
        end if;
    end process;

    --Process To Slip Header and Payload Data
    tx_byte_aligner_fsm_proc : process(clk)
        variable new_byte_location : integer range 0 to (2 * G_UDP_CORE_BYTES) - 1;

    begin
        if (rising_edge(clk)) then
            if (rst_s_n = '0') then
                tx_byte_slip_next_state <= idle;
                int_valid               <= '0';
                new_byte_location       := 0;
            else
                case tx_byte_slip_next_state is
                    when idle =>
                        if header_valid_reg = '1' then
                            int_valid <= '1';
                            int_last  <= '0';

                            if header_last_reg = '0' then
                                --Header spans more than one word
                                int_data                <= header_data_reg;
                                tx_byte_slip_next_state <= header;
                                int_keep                <= (others => '1');
                            elsif header_last_reg = '1' then
                                --Full header is less than one word
                                if slip_value mod G_UDP_CORE_BYTES /= 0 then
                                    int_data(G_UDP_CORE_BYTES * 8 - 1 downto 0) <= std_logic_vector(shift_left(unsigned(payload_data_reg), slip_value * 8));
                                    int_data(slip_value * 8 - 1 downto 0) <= header_data_reg(slip_value*8-1 downto 0);

                                    if payload_last_reg = '0' then
                                        --Full data spans more than one word
                                        tx_byte_slip_next_state <= slipping_word;
                                        int_keep                <= (others => '1');
                                    elsif payload_last_reg = '1' then
                                        --Full data also fit into the first word (can happen with ARPs or Pings & 64 byte width)
                                        new_byte_location := (slip_value mod G_UDP_CORE_BYTES) + tkeep_to_int(payload_keep_reg(G_UDP_CORE_BYTES - 1 downto 0));

                                        if new_byte_location >= G_UDP_CORE_BYTES then
                                            --Last data Byte is slipped to extra word with header slip
                                            tx_byte_slip_next_state <= extra_word;
                                            int_keep                <= (others => '1');
                                        else
                                            --Last data Byte remains on same word
                                            int_keep(G_UDP_CORE_BYTES - 1 downto 0) <= int_to_tkeep(new_byte_location, G_UDP_CORE_BYTES);
                                            int_last                                <= '1';
                                            tx_byte_slip_next_state                 <= final_word;
                                        end if;
                                    end if;
                                else
                                    int_data                <= header_data_reg(G_UDP_CORE_BYTES * 8 - 1 downto 0);
                                    tx_byte_slip_next_state <= no_slip_word;
                                end if;
                            end if;
                        else
                            int_valid <= '0';
                        end if;

                    when header =>
                        int_valid <= '1';
                        if header_last_reg = '0' then
                            --Not end of header
                            int_data <= header_data_reg;
                            int_keep <= (others => '1');
                        elsif header_last_reg = '1' then
                            --End of Header
                            if slip_value mod G_UDP_CORE_BYTES /= 0 then
                                int_data(G_UDP_CORE_BYTES * 8 - 1 downto 0) <= std_logic_vector(shift_left(unsigned(payload_data_reg), slip_value * 8));
                                int_data(slip_value * 8 - 1 downto 0) <= header_data_reg(slip_value*8-1 downto 0);
                                --Full data spans more than one word

                                new_byte_location := tkeep_to_int(payload_keep_reg(G_UDP_CORE_BYTES - 1 downto 0)) + slip_value;

                                if payload_last_reg = '1' and new_byte_location <= G_UDP_CORE_BYTES - 1 then
                                    --64 B PAcket with a width of 32 B Triggers this
                                    int_keep(G_UDP_CORE_BYTES - 1 downto 0) <= int_to_tkeep(new_byte_location, G_UDP_CORE_BYTES);
                                    tx_byte_slip_next_state                 <= final_word;
                                    int_last                                <= '1';
                                elsif payload_last_reg = '1' then
                                    new_byte_location       := (slip_value mod G_UDP_CORE_BYTES) + tkeep_to_int(payload_keep_reg(G_UDP_CORE_BYTES - 1 downto 0));
                                    tx_byte_slip_next_state <= extra_word;
                                    int_keep                <= (others => '1');
                                else
                                    tx_byte_slip_next_state <= slipping_word;
                                    int_keep                <= (others => '1');
                                end if;

                            else
                                int_data                <= header_data_reg(G_UDP_CORE_BYTES * 8 - 1 downto 0);
                                tx_byte_slip_next_state <= no_slip_word;
                            end if;
                        end if;

                    when slipping_word =>
                        if payload_valid_reg = '1' then
                            int_valid <= '1';
                            --Slipping data
                            int_data  <= std_logic_vector(shift_left(unsigned(payload_data_reg), slip_value * 8) or shift_right(unsigned(payload_data_old), (G_UDP_CORE_BYTES - slip_value) * 8));
                            if payload_last_reg = '1' then
                                --Get Old Byte Location
                                new_byte_location := (slip_value mod G_UDP_CORE_BYTES) + tkeep_to_int(payload_keep_reg(G_UDP_CORE_BYTES - 1 downto 0));
                                if new_byte_location > G_UDP_CORE_BYTES - 1 then
                                    tx_byte_slip_next_state <= extra_word;
                                    int_keep                <= (others => '1');
                                else
                                    --Last data Byte remains on same word, finish
                                    int_data(G_UDP_CORE_BYTES * 8 - 1 downto 0) <= std_logic_vector(shift_left(unsigned(payload_data_reg), slip_value * 8) or shift_right(unsigned(payload_data_old), (G_UDP_CORE_BYTES - slip_value) * 8));
                                    for i in 0 to G_UDP_CORE_BYTES - 1 loop
                                        if new_byte_location >= i then
                                            int_keep(i) <= '1';
                                        else
                                            int_keep(i) <= '0';
                                        end if;
                                    end loop;
                                    int_last                                    <= '1';
                                    tx_byte_slip_next_state                     <= final_word;
                                end if;
                            else
                                int_keep <= (others => '1');
                            end if;
                        else
                            int_valid <= '0';
                        end if;

                    when no_slip_word =>
                        if payload_valid_old = '1' then
                            int_valid <= '1';
                            int_data  <= payload_data_old(G_UDP_CORE_BYTES * 8 - 1 downto 0);
                            if payload_last_old = '1' then
                                int_keep                <= payload_keep_old;
                                int_last                <= '1';
                                tx_byte_slip_next_state <= final_word;
                            end if;
                        else
                            int_valid <= '0';
                        end if;

                    when extra_word =>
                        new_byte_location                           := new_byte_location - G_UDP_CORE_BYTES;
                        int_data(G_UDP_CORE_BYTES * 8 - 1 downto 0) <= std_logic_vector(shift_left(unsigned(payload_data_reg), slip_value * 8) or shift_right(unsigned(payload_data_old), (G_UDP_CORE_BYTES - slip_value) * 8));
                        int_last                                    <= '1';
                        int_valid                                   <= '1';
                        for i in 0 to G_UDP_CORE_BYTES - 1 loop
                            if new_byte_location >= i then
                                int_keep(i) <= '1';
                            else
                                int_keep(i) <= '0';
                            end if;
                        end loop;
                        tx_byte_slip_next_state                     <= final_word;

                    when final_word =>
                        int_valid               <= '0';
                        int_last                <= '0';
                        tx_byte_slip_next_state <= idle;
                end case;

            end if;
        end if;
    end process;

    --Process to pad small packets up to ethernet minimum
    padding_proc : process(clk)
    begin
        if (rising_edge(clk)) then
            if (rst_s_n = '0') then
                padd_word_count <= 0;
                padding         <= '0';
                out_valid       <= '0';
            else
                if int_valid = '1' then
                    out_valid <= '1';
                    if int_last = '0' then
                        --Not the last word of data, normal output
                        out_data <= int_data;
                        out_keep <= int_keep;
                        out_last <= int_last;
                        padding  <= '0';
                        if padd_word_count < C_MIN_WORDS + 1 then
                            --Increment word counter if minimum requirement has not already been exceeded
                            padd_word_count <= (padd_word_count + 1);
                        end if;

                    elsif int_last = '1' then
                        --Last word of slipped data, check if padding is needed
                        if (padd_word_count < C_MIN_WORDS and C_MIN_REM /= 0) or (padd_word_count < C_MIN_WORDS - 1 and C_MIN_REM = 0) then
                            --Padding is needed for more Words
                            out_data        <= (others => '0');
                            for i in 1 to G_UDP_CORE_BYTES loop
                                if i <= tkeep_to_int(int_keep(G_UDP_CORE_BYTES - 1 downto 0)) + 1 then
                                    out_data(i * 8 - 1 downto (i - 1) * 8) <= int_data(i * 8 - 1 downto (i - 1) * 8);
                                end if;
                            end loop;
                            out_last        <= '0';
                            out_keep        <= (others => '1');
                            padding         <= '1';
                            padd_word_count <= padd_word_count + 1;

                        elsif (padd_word_count = C_MIN_WORDS and C_MIN_REM /= 0) or (padd_word_count = C_MIN_WORDS - 1 and C_MIN_REM = 0) then
                            --Padding Only Needed For This Word
                            padd_word_count <= 0;
                            out_last        <= int_last;
                            out_data        <= (others => '0');
                            for i in 1 to G_UDP_CORE_BYTES loop
                                if i <= tkeep_to_int(int_keep(G_UDP_CORE_BYTES - 1 downto 0)) + 1 then
                                    out_data(i * 8 - 1 downto (i - 1) * 8) <= int_data(i * 8 - 1 downto (i - 1) * 8);
                                end if;
                            end loop;
                            for i in 0 to G_UDP_CORE_BYTES - 1 loop
                                if C_MIN_REM >= i or tkeep_to_int(int_keep(G_UDP_CORE_BYTES - 1 downto 0)) >= i then
                                    out_keep(i) <= '1';
                                else
                                    out_keep(i) <= '0';
                                end if;
                            end loop;

                        else
                            --No Padding Needed
                            padd_word_count <= 0;
                            out_data        <= int_data;
                            out_keep        <= int_keep;
                            out_last        <= int_last;
                        end if;
                    end if;

                elsif padding = '1' then
                    out_valid <= '1';
                    out_data  <= (others => '0');

                    if (padd_word_count = C_MIN_WORDS and C_MIN_REM /= 0) or (padd_word_count = C_MIN_WORDS - 1 and C_MIN_REM = 0) then
                        --Last Word
                        padding         <= '0';
                        padd_word_count <= 0;
                        out_last        <= '1';
                        for i in 0 to G_UDP_CORE_BYTES - 1 loop
                            if C_MIN_REM >= i then
                                out_keep(i) <= '1';
                            else
                                out_keep(i) <= '0';
                            end if;
                        end loop;
                    else
                        padd_word_count <= padd_word_count + 1;
                        padding         <= '1';
                        out_last        <= '0';
                        out_keep        <= (others => '1');
                    end if;
                else
                    out_valid <= '0';
                end if;
            end if;
        end if;
    end process;

end architecture behavioural;
