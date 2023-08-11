------------------------------------------------------------------------------
--! @file udp_core_timer.vhd
--! @page udpcoretimerpage UDP Coe Timer
--!
--! \includedoc esdg_stfc_image.md
--!
--! ### Brief ###
--! Simple timer which signals pulses on the order of ms to update ARP timer
--! counters in the @ref txarphandlerpage of the Tx Path
--!
--! ### License ###
--! Copyright(c) 2021 UNITED KINGDOM RESEARCH AND INNOVATION
--! Licensed under the BSD 3-Clause license. See LICENSE file in the project
--! root for details.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity udp_core_timer is
    generic(
        clk_freq_in_khz     : integer := 100_000;   --! Khz of input clock, used to configure the timer
        pulse_time_in_ms    : integer := 1          --! How long between pulses
    );
    port(
        clk                 : in  std_logic;        --! Clk
        rst_n               : in  std_logic;        --! Active Low Synchronous Reset
        end_of_interval     : out std_logic         --! Pulse Signal Out
    );
end entity udp_core_timer;

architecture RTL of udp_core_timer is
    constant clk_cycles_per_interval : integer := clk_freq_in_khz * pulse_time_in_ms;
    constant tick_count_large        : integer := clk_cycles_per_interval / 1024;
    constant tick_count_rem          : integer := clk_cycles_per_interval mod 1024;
    signal small_tick_count          : integer range 0 to 1023;
    signal large_tick_count          : integer range 0 to tick_count_large - 1;
    signal end_of_interval_int       : std_logic;
begin

    end_of_interval_int <= '1' when (small_tick_count = tick_count_rem - 1) and (large_tick_count = tick_count_large - 1) else '0';

    tick_proc : process(clk) is
    begin
        if rising_edge(clk) then
            if rst_n = '0' then
                small_tick_count <= 0;
                large_tick_count <= 0;
            else
                if end_of_interval_int = '1' then
                    small_tick_count <= 0;
                    large_tick_count <= 0;
                else
                    small_tick_count <= (small_tick_count + 1) mod 1024;
                    if small_tick_count = 1023 then
                        large_tick_count <= (large_tick_count + 1) mod tick_count_large;
                    end if;
                end if;
            end if;
        end if;
    end process tick_proc;

    reg_interval : process(clk) is
    begin
        if rising_edge(clk) then
            end_of_interval <= end_of_interval_int;
        end if;
    end process reg_interval;

end architecture RTL;
