-- <h---------------------------------------------------------------------------
--! @file tx_ping_chksm_1bytew.vhd
--! @page txpingchksm1bytewpage Tx Ping Checksum 1 Byte
--!
--! \includedoc esdg_stfc_image.md
--!
--! ### Brief ###
--! Calculates Ping checksum for Data Widths of 1 Byte
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

entity tx_ping_chksm_1bytew is
    port(
        clk         : in  std_logic;                    --! Clk
        rst_s_n     : in  std_logic;                    --! Active Low synchronous reset
        data_in     : in  std_logic_vector(7 downto 0); --! Ping Data in
        valid       : in  std_logic;                    --! Valid in
        sof         : in  std_logic;                    --! Start of Packet
        eof         : in  std_logic;                    --! End of Packet
        done        : out std_logic;                    --! Calculations Finished
        out_chksm   : out std_logic_vector(15 downto 0) --! Checksum Out
    );
end entity tx_ping_chksm_1bytew;

architecture behavioural of tx_ping_chksm_1bytew is

    constant C_EMPTY_BYTE : std_logic_vector(7 downto 0) := (others => '0');

    type t_tx_ping_chksm_next_state is (
        idle,
        tx_lower_byte,
        tx_upper_byte,
        tx_finished
    );

    signal lower_byte               : std_logic_vector(7 downto 0);
    signal data_2byte_input         : std_logic_vector(15 downto 0);
    signal data_1byte_input         : std_logic_vector(15 downto 0);
    signal prev_sum                 : std_logic_vector(15 downto 0);
    signal tx_ping_chksm_next_state : t_tx_ping_chksm_next_state := idle;

    -- Altera Attributes:
    attribute enum_encoding : string;
    attribute enum_encoding of t_tx_ping_chksm_next_state : type is "one-hot";
    -- Xilinx Attributes:
    attribute fsm_encoding  : string;
    attribute fsm_encoding of t_tx_ping_chksm_next_state : type is "one_hot";

begin

    out_chksm        <= prev_sum;
    data_2byte_input <= data_in & lower_byte;
    data_1byte_input <= C_EMPTY_BYTE & data_in;

    fsm_proc : process(clk)
    begin
        if (rising_edge(clk)) then
            if (rst_s_n = '0') then
                prev_sum   <= (others => '0');
                lower_byte <= (others => '0');
                done       <= '0';
            else
                case (tx_ping_chksm_next_state) is
                    when idle =>
                        done <= '0';
                        if (valid = '1' and sof = '1') then
                            lower_byte <= data_in;

                            prev_sum                 <= (others => '0');
                            tx_ping_chksm_next_state <= tx_upper_byte;
                        end if;

                    when tx_lower_byte =>
                        if valid = '1' then
                            lower_byte(7 downto 0) <= data_in;

                            if eof = '1' then
                                done                     <= '1';
                                prev_sum                 <= ones_comp_add_16bit(prev_sum, data_1byte_input);
                                done                     <= '1';
                                tx_ping_chksm_next_state <= tx_finished;
                            elsif eof = '0' then
                                tx_ping_chksm_next_state <= tx_upper_byte;
                            end if;
                        end if;

                    when tx_upper_byte =>
                        if valid = '1' then
                            prev_sum <= ones_comp_add_16bit(prev_sum, data_2byte_input);
                            if eof = '1' then
                                done                     <= '1';
                                tx_ping_chksm_next_state <= tx_finished;
                            elsif eof = '0' then
                                tx_ping_chksm_next_state <= tx_lower_byte;
                            end if;
                        end if;

                    when tx_finished =>
                        tx_ping_chksm_next_state <= idle;
                        done                     <= '0';
                        prev_sum                 <= (others => '0');

                end case;
            end if;
        end if;
    end process;

end architecture behavioural;
