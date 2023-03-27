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
library common_mem_lib;
use common_mem_lib.common_mem_pkg.all;

entity asym_bram_sdp is
   generic (
      g_wr_dat_width    : integer := 16;
      g_wr_adr_width    : integer := 17;
      g_rd_dat_width    : integer := 256;
      g_rd_latency      : positive:= 2;
      g_partition_width : integer := -1     -- -1 implies no BRAM partitions
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

architecture struct of asym_bram_sdp is

   function ram_rd_latency_calc(rd_latency: positive) return positive is
   begin
      if rd_latency <= 2 then
         return rd_latency;
      else
         return 2;
      end if;
   end function;
   
   constant c_rd_adr_width          : integer := rd_adr'length;
   constant c_ram_rd_latency        : positive := ram_rd_latency_calc(g_rd_latency);
   constant c_additional_rd_latency : natural := g_rd_latency - c_ram_rd_latency;

   constant c_nof_partitions        : positive := nof_partitions_calc(g_rd_dat_width,g_partition_width);
   constant c_rd_partition_width    : positive := partition_w_calc(g_rd_dat_width,c_nof_partitions);  
   constant c_ceil_rd_dat_width     : positive := c_nof_partitions*c_rd_partition_width;
   constant c_wr_partition_width    : positive := partition_w_calc(g_wr_dat_width,c_nof_partitions);  
   constant c_ceil_wr_dat_width     : positive := c_nof_partitions*c_wr_partition_width;
      
   signal rd_dat_resize             : std_logic_vector(c_ceil_rd_dat_width-1 downto 0);
   signal wr_dat_resize             : std_logic_vector(c_ceil_wr_dat_width-1 downto 0);
   signal rd_dat_i                  : std_logic_vector(rd_dat'range);
begin
   
   wr_dat_resize <= ox_resize(wr_dat,wr_dat_resize'length);
   
   g_partition_gen: for n in 0 to c_nof_partitions-1 generate
      rd_wider_gen: if g_rd_dat_width >= g_wr_dat_width generate
         asym_bram_sdp_read_wider_inst: entity common_mem_lib.asym_bram_sdp_read_wider
         generic map(
            WIDTHA     => c_wr_partition_width,
            SIZEA      => 2**g_wr_adr_width,
            ADDRWIDTHA => g_wr_adr_width,
            WIDTHB     => c_rd_partition_width,
            SIZEB      => 2**c_rd_adr_width,
            ADDRWIDTHB => c_rd_adr_width,
            READLAT    => g_rd_latency
         )
         port map(
            clkA  => wr_clk,
            clkB  => rd_clk,
            enA   => '1',
            enB   => rd_en,
            weA   => wr_en,
            addrA => wr_adr,
            addrB => rd_adr,
            diA   => wr_dat_resize(c_wr_partition_width*(n+1)-1 downto c_wr_partition_width*n),
            doB   => rd_dat_resize(c_rd_partition_width*(n+1)-1 downto c_rd_partition_width*n)
         );
      end generate;
      
      wr_wider_gen: if g_rd_dat_width < g_wr_dat_width generate
         asym_bram_sdp_write_wider_inst: entity common_mem_lib.asym_bram_sdp_write_wider
         generic map(
            WIDTHA     => c_rd_partition_width,
            SIZEA      => 2**c_rd_adr_width,
            ADDRWIDTHA => c_rd_adr_width,
            WIDTHB     => c_wr_partition_width,
            SIZEB      => 2**g_wr_adr_width,
            ADDRWIDTHB => g_wr_adr_width,
            READLAT    => g_rd_latency
         )
         port map(
            clkA  => rd_clk,
            clkB  => wr_clk,
            enA   => rd_en,
            enB   => '1',
            weB   => wr_en,
            addrA => rd_adr,
            addrB => wr_adr,
            doA   => rd_dat_resize(c_rd_partition_width*(n+1)-1 downto c_rd_partition_width*n),
            diB   => wr_dat_resize(c_wr_partition_width*(n+1)-1 downto c_wr_partition_width*n)
         );
      end generate;
   end generate;
   
   rd_dat_i <= ox_resize(rd_dat_resize,rd_dat_i'length);
   
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
