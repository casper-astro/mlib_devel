--------------------------------------------------------------------------------
--! @file reset_sync.vhd
--!
--! ### Brief ###
--! Asynchronous Reset with Synchronous (Rising Edge) De-assert This component
--! generates both Active Low and Active High Synchronised Reset Outputs.
--!
--! ### License ###
--! Copyright(c) 2021 UNITED KINGDOM RESEARCH AND INNOVATION
--! Licensed under the BSD 3-Clause license. See LICENSE file in the project
--! root for details.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reset_sync is
    generic(
        g_rst_extend            : boolean := false;     --! Delay the reset deassertion
        g_rst_extend_msb        : natural := 20         --! A counter is used to delay the deassertion until the counter MSB is asserted
    );
    port(
        clk                     : in    std_logic;
        reset_n                 : in    std_logic;
        synced_reset            : out   std_logic;
        synced_reset_n          : out   std_logic
    );
end entity reset_sync;

architecture rtl of reset_sync is

signal meta_reset_n             : std_logic;

signal int_synced_reset_n       : std_logic;

begin

    reset_sync_proc : process(clk, reset_n)
    begin
        if(reset_n = '0') then
            --! Active Low Reset:
            meta_reset_n <= '0';
            int_synced_reset_n <= '0';
        elsif(rising_edge(clk)) then
            --! Active Low Reset:
            meta_reset_n <= '1';
            int_synced_reset_n <= meta_reset_n;
        end if;
    end process reset_sync_proc;

    output_gen_ext : if g_rst_extend generate
        reset_extender_proc : process(clk)
            variable v_extend_counter     : unsigned(g_rst_extend_msb downto 0);
        begin

            synced_reset_n <= not v_extend_counter(g_rst_extend_msb);
            synced_reset <= v_extend_counter(g_rst_extend_msb);
            if(rising_edge(clk)) then
                if(int_synced_reset_n = '0') then
                    v_extend_counter := (others => '0');
                elsif(v_extend_counter(g_rst_extend_msb) = '0') then
                    v_extend_counter := v_extend_counter + 1;
                else

                end if;
            end if;
        end process reset_extender_proc;
    end generate output_gen_ext;
    output_gen_no_ext : if not g_rst_extend generate
        synced_reset_n <= int_synced_reset_n;
        synced_reset <= not int_synced_reset_n;
    end generate output_gen_no_ext;

end architecture rtl;
