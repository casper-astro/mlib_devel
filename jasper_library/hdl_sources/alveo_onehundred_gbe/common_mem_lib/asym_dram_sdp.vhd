--<h---------------------------------------------------------------------------
--
-- Copyright (C) 2015
-- University of Oxford <http://www.ox.ac.uk/>
-- Department of Physics
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
--
-----------------------------------------------------------------------------h>
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library common_ox_lib;
use common_ox_lib.ox_functions_pkg.all;
use common_ox_lib.ox_unsigned_functions_pkg.all;
library common_mem_lib;
use common_mem_lib.common_mem_pkg.all;

entity asym_dram_sdp is
   generic (
      g_wr_dat_width   : integer := 16;
      g_wr_adr_width   : integer := 17;
      g_rd_dat_width   : integer := 256;
      g_rd_latency     : natural := 2
   );
   port(
      wr_clk : in  std_logic;
      rd_clk : in  std_logic;
      wr_en  : in  std_logic;
      rd_en  : in  std_logic;
      wr_adr : in  std_logic_vector(g_wr_adr_width-1 downto 0);
      rd_adr : in  std_logic_vector(rd_adr_width_calc(g_wr_dat_width,g_wr_adr_width,g_rd_dat_width)-1 downto 0);
      wr_dat : in  std_logic_vector(g_wr_dat_width-1 downto 0);
      rd_dat : out std_logic_vector(g_rd_dat_width-1 downto 0)
    );
end entity;

architecture struct of asym_dram_sdp is
   
   constant c_rd_adr_width : integer := rd_adr_width_calc(g_wr_dat_width,g_wr_adr_width,g_rd_dat_width);
   constant c_max_dat_width: integer := ox_max(g_wr_dat_width,g_rd_dat_width);
   constant c_min_dat_width: integer := ox_min(g_wr_dat_width,g_rd_dat_width);
   constant c_max_adr_width: integer := ox_max(g_wr_adr_width,c_rd_adr_width);
   constant c_min_adr_width: integer := ox_min(g_wr_adr_width,c_rd_adr_width);
   constant c_nof_partition: integer := c_max_dat_width/c_min_dat_width;
   constant c_additional_lat: integer := g_rd_latency - 1;

   function ram_rd_latency_calc(rd_latency: natural) return natural is
   begin
      if rd_latency >= 2 then
         return 1;
      else
         return 0;
      end if;
   end function;
   
   constant c_ram_rd_latency: natural := ram_rd_latency_calc(g_rd_latency);
   constant c_additional_rd_latency: natural := g_rd_latency - c_ram_rd_latency;
   
   signal rd_dat_i: std_logic_vector(rd_dat'range);
   signal rd_adr_latency: std_logic_vector(rd_adr'range);
   
begin
   
   same_width_gen: if g_rd_dat_width = g_wr_dat_width generate
      mem_gen: for n in 0 to c_nof_partition-1 generate
         dram_sdp_inst: entity common_mem_lib.dram_sdp
         generic map (
            g_dat_width  => g_wr_dat_width,
            g_adr_width  => g_wr_adr_width,
            g_rd_latency => c_ram_rd_latency)
         port map (
            wr_clk => wr_clk,
            rd_clk => rd_clk,
            wr_en  => wr_en,
            wr_adr => wr_adr,
            rd_adr => rd_adr,
            wr_dat => wr_dat,
            rd_dat => rd_dat_i
         );
      end generate;
   end generate;
   
   wr_wider_gen: if g_wr_dat_width > g_rd_dat_width generate
      signal rd_adr_i: std_logic_vector(c_min_adr_width-1 downto 0);
      signal rd_dat_wide: std_logic_vector(c_max_dat_width-1 downto 0);
      signal rd_dat_mux_sel: std_logic_vector(c_max_adr_width-c_min_adr_width-1 downto 0);
   begin
      mem_gen: for n in 0 to c_nof_partition-1 generate
         dram_sdp_inst: entity common_mem_lib.dram_sdp
         generic map (
            g_dat_width  => c_min_dat_width,
            g_adr_width  => c_min_adr_width,
            g_rd_latency => c_ram_rd_latency
         )
         port map (
            wr_clk => wr_clk,
            rd_clk => rd_clk,
            wr_en  => wr_en,
            wr_adr => wr_adr,
            rd_adr => rd_adr_i,
            wr_dat => wr_dat(c_min_dat_width*(n+1)-1 downto c_min_dat_width*n),
            rd_dat => rd_dat_wide(c_min_dat_width*(n+1)-1 downto c_min_dat_width*n)
         );
      end generate;

      rd_adr_i <= rd_adr(rd_adr'length-1 downto rd_dat_mux_sel'length);
      rd_dat_mux_sel <= ox_resize(rd_adr_latency,rd_dat_mux_sel'length);
      process(rd_dat_mux_sel,rd_dat_wide)
      begin
         rd_dat_i <= (others=>'-');
         for n in 0 to c_nof_partition-1 loop
            if n = rd_dat_mux_sel then
               rd_dat_i <= rd_dat_wide(c_min_dat_width*(n+1)-1 downto c_min_dat_width*n);
            end if;
         end loop;
      end process;
   end generate;
   
   rd_wider_gen: if g_rd_dat_width > g_wr_dat_width generate
      signal wr_adr_i: std_logic_vector(c_min_adr_width-1 downto 0);
      signal wr_demux_sel: std_logic_vector(c_max_adr_width-c_min_adr_width-1 downto 0);
      signal wr_en_demux: std_logic_vector(c_nof_partition-1 downto 0);
      
      signal rd_adr_i: std_logic_vector(c_min_adr_width-1 downto 0);
      signal rd_dat_wide: std_logic_vector(c_max_dat_width-1 downto 0);
   begin
      mem_gen: for n in 0 to c_nof_partition-1 generate
         dram_sdp_inst: entity common_mem_lib.dram_sdp
         generic map (
            g_dat_width  => c_min_dat_width,
            g_adr_width  => c_min_adr_width,
            g_rd_latency => c_ram_rd_latency
         )
         port map (
            wr_clk => wr_clk,
            rd_clk => rd_clk,
            wr_en  => wr_en_demux(n),
            wr_adr => wr_adr_i,
            rd_adr => rd_adr_i,
            wr_dat => wr_dat,
            rd_dat => rd_dat_wide(c_min_dat_width*(n+1)-1 downto c_min_dat_width*n)
         );
         wr_en_demux(n) <= '1' when wr_demux_sel = n and wr_en = '1' else '0';
      end generate;

      wr_adr_i     <= wr_adr(wr_adr'length-1 downto wr_demux_sel'length);
      wr_demux_sel <= ox_resize(wr_adr,wr_demux_sel'length);
      
      rd_adr_i <= rd_adr;
      rd_dat_i <= rd_dat_wide;
   end generate;
   
   rd_adr_pipe_inst: entity common_ox_lib.ox_multibit_pipe
   generic map(
      g_width     => c_rd_adr_width,
      g_nof_stage => c_ram_rd_latency
   )
   port map(
      clk => rd_clk,
      rst => '0',
      di  => rd_adr,
      do  => rd_adr_latency
   );
   
   rd_dat_pipe_inst: entity common_ox_lib.ox_multibit_pipe
   generic map(
      g_width     => g_rd_dat_width,
      g_nof_stage => c_additional_rd_latency
   )
   port map(
      clk => rd_clk,
      rst => '0',
      di  => rd_dat_i,
      do  => rd_dat
   );

end architecture;
