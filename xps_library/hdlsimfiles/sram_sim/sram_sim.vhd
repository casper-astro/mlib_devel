-------------------------------------------------------------------------------
--                                                                           --
--  Center for Astronomy Signal Processing and Electronics Research          --
--  http://seti.ssl.berkeley.edu/casper/                                     --
--  Copyright (C) 2006 University of California, Berkeley                    --
--                                                                           --
--  This program is free software; you can redistribute it and/or modify     --
--  it under the terms of the GNU General Public License as published by     --
--  the Free Software Foundation; either version 2 of the License, or        --
--  (at your option) any later version.                                      --
--                                                                           --
--  This program is distributed in the hope that it will be useful,          --
--  but WITHOUT ANY WARRANTY; without even the implied warranty of           --
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            --
--  GNU General Public License for more details.                             --
--                                                                           --
--  You should have received a copy of the GNU General Public License along  --
--  with this program; if not, write to the Free Software Foundation, Inc.,  --
--  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.              --
--                                                                           --
-------------------------------------------------------------------------------

library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_textio.all;
	use ieee.numeric_std.all;

entity sram_sim is

    port(
        clk         : in  std_logic;
        ce          : in  std_logic;
        we          : in  std_logic_vector(0  downto 0);
        be          : in  std_logic_vector(3  downto 0);
        address     : in  std_logic_vector(18 downto 0);
        data_in     : in  std_logic_vector(35 downto 0);
        data_out    : out std_logic_vector(35 downto 0) := (others => '0');
        data_valid  : out std_logic_vector(0  downto 0) := (others => '0')
    );

end entity;

architecture sram_sim_arch of sram_sim is

    signal net_gnd      : std_logic := '0';

    signal if_clk       : std_logic := '0';
    signal if_we_b      : std_logic := '1';
    signal if_adv_ld_b  : std_logic := '1';
    signal if_ce        : std_logic := '0';
    signal if_oe_b      : std_logic := '1';
    signal if_cen_b     : std_logic := '1';
    signal if_mode      : std_logic := '0';
    signal if_zz        : std_logic := '0';
    signal if_address   : std_logic_vector(18 downto 0) := (others => '0');
    signal if_bw_b      : std_logic_vector(3  downto 0) := (others => '0');
    signal if_dq_T      : std_logic_vector(35 downto 0) := (others => '1');
    signal if_dq_O      : std_logic_vector(35 downto 0) := (others => '0');

    signal dq_bus       : std_logic_vector(35 downto 0) := (others => '0');
    signal data_out_int : std_logic_vector(35 downto 0) := (others => '0');

    component sram_interface
        port (
            clk             : in  std_logic := '0';
            we              : in  std_logic := '0';
            be              : in  std_logic_vector(3  downto 0) := (others => '0');
            address         : in  std_logic_vector(18 downto 0) := (others => '0');
            data_in         : in  std_logic_vector(35 downto 0) := (others => '0');
            data_out        : out std_logic_vector(35 downto 0) := (others => '0');
            data_valid      : out std_logic := '0';

            pads_address    : out std_logic_vector(18 downto 0) := (others => '0');
            pads_bw_b       : out std_logic_vector(3  downto 0) := (others => '0');
            pads_we_b       : out std_logic := '1';
            pads_adv_ld_b   : out std_logic := '1';
            pads_clk        : out std_logic := '0';
            pads_ce         : out std_logic := '0';
            pads_oe_b       : out std_logic := '1';
            pads_cen_b      : out std_logic := '1';
            pads_dq_T       : out std_logic_vector(35 downto 0) := (others => '1');
            pads_dq_I       : in  std_logic_vector(35 downto 0) := (others => '0');
            pads_dq_O       : out std_logic_vector(35 downto 0) := (others => '0');
            pads_mode       : out std_logic := '0';
            pads_zz         : out std_logic := '0'
        );
    end component;

    component cy7c1370
        port (
            Dq              : inout std_logic_vector (35 downto 0) := (others => '0');  -- data i/o
            Addr            : in    std_logic_vector (18 downto 0) := (others => '0');  -- address
            Mode            : in    std_logic := '0';   -- burst mode
            Clk             : in    std_logic := '0';   -- clk
            CEN_n           : in    std_logic := '1';   -- cen#
            AdvLd_n         : in    std_logic := '1';   -- adv/ld#
            Bwa_n           : in    std_logic := '1';   -- bwa#
            Bwb_n           : in    std_logic := '1';   -- bwb#
            Bwc_n           : in    std_logic := '1';   -- bwc#
            Bwd_n           : in    std_logic := '1';   -- bwd#
            Rw_n            : in    std_logic := '1';   -- rw#
            Oe_n            : in    std_logic := '1';   -- oe#
            Ce1_n           : in    std_logic := '1';   -- ce1#
            Ce2             : in    std_logic := '0';   -- ce2
            Ce3_n           : in    std_logic := '1';   -- ce3#
            Zz              : in    std_logic := '0'    -- snooze mode
        );
    end component;

begin

    net_gnd <= '0';

    controller : sram_interface
        port map (
            clk             => clk,
            we              => we(0),
            be              => be,
            address         => address,
            data_in         => data_in,
            data_out        => data_out_int,
            data_valid      => data_valid(0),

            pads_address    => if_address,
            pads_bw_b       => if_bw_b,
            pads_we_b       => if_we_b,
            pads_adv_ld_b   => if_adv_ld_b,
            pads_clk        => if_clk,
            pads_ce         => if_ce,
            pads_oe_b       => if_oe_b,
            pads_cen_b      => if_cen_b,
            pads_dq_T       => if_dq_T,
            pads_dq_I       => dq_bus,
            pads_dq_O       => if_dq_O,
            pads_mode       => if_mode,
            pads_zz         => if_zz
        );

    sram : cy7c1370
        port map (
            Dq      => dq_bus,
            Addr    => if_address,
            Mode    => if_mode,
            Clk     => if_clk,
            CEN_n   => if_cen_b,
            AdvLd_n => if_adv_ld_b,
            Bwa_n   => if_bw_b(0),
            Bwb_n   => if_bw_b(1),
            Bwc_n   => if_bw_b(2),
            Bwd_n   => if_bw_b(3),
            Rw_n    => if_we_b,
            Oe_n    => if_oe_b,
            Ce1_n   => net_gnd,
            Ce2     => if_ce,
            Ce3_n   => net_gnd,
            Zz      => if_zz
        );

    DQ_BUS_TRISTATE : process (if_dq_T, if_dq_O)
    begin
        for bit_index in 0 to 35 loop
            if ( if_dq_T(bit_index) = '0') then
                dq_bus(bit_index) <= if_dq_O(bit_index);
            else
                dq_bus(bit_index) <= 'Z';
            end if;
        end loop;
    end process DQ_BUS_TRISTATE;

    DATA_OUT_SAFE : process (data_out_int)
    begin
        for bit_index in 0 to 35 loop
            if (data_out_int(bit_index) /= '0' and data_out_int(bit_index) /= '1') then
                data_out(bit_index) <= '0';
            else
                data_out(bit_index) <= data_out_int(bit_index);
            end if;
        end loop;
    end process DATA_OUT_SAFE;

end architecture;
