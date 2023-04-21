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
library common_mem_lib;
use common_mem_lib.common_mem_pkg.all;

entity asym_ram_sdp is
   generic (
      g_wr_dat_width   : integer := 16;
      g_wr_adr_width   : integer := 17;
      g_rd_dat_width   : integer := 256;
      g_rd_latency     : positive:= 2;
      g_fpga_family    : string  := "all";
      g_fpga_vendor    : string  := "xilinx";
      g_implementation : string  := "block"; --"distributed"
      g_partition_width: integer := 0
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

architecture struct of asym_ram_sdp is

   function implementation_calc(impl: string) return string is
   begin
      if impl = "auto" then
         if g_wr_dat_width*(2**g_wr_adr_width) > 512 then
            return "block";
         else
            return "distributed";
         end if;
      else
         return impl;
      end if;
   end function;

begin
   
   impl_block_gen: if implementation_calc(g_implementation) = "block" generate
      asym_bram_sdp_inst: entity common_mem_lib.asym_bram_sdp
      generic map (
         g_wr_dat_width    => g_wr_dat_width,
         g_wr_adr_width    => g_wr_adr_width,
         g_rd_dat_width    => g_rd_dat_width,
         g_rd_latency      => g_rd_latency,
         g_partition_width => g_partition_width)
      port map (
         wr_clk => wr_clk,
         rd_clk => rd_clk,
         wr_en  => wr_en,
         rd_en  => rd_en,
         wr_adr => wr_adr,
         rd_adr => rd_adr,
         wr_dat => wr_dat,
         rd_dat => rd_dat
      );
   end generate;
   
   impl_distributed_gen: if implementation_calc(g_implementation) = "distributed" generate
      asym_dram_sdp_inst: entity common_mem_lib.asym_dram_sdp
      generic map (
         g_wr_dat_width => g_wr_dat_width,
         g_wr_adr_width => g_wr_adr_width,
         g_rd_dat_width => g_rd_dat_width,
         g_rd_latency   => g_rd_latency)
      port map (
         wr_clk => wr_clk,
         rd_clk => rd_clk,
         wr_en  => wr_en,
         rd_en  => rd_en,
         wr_adr => wr_adr,
         rd_adr => rd_adr,
         wr_dat => wr_dat,
         rd_dat => rd_dat
      );
   end generate;
   
end architecture;
