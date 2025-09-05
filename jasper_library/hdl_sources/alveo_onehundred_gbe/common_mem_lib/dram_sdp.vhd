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

-- library unisim;
-- use unisim.vcomponents.all;
library common_ox_lib;
use common_ox_lib.ox_functions_pkg.all;
use common_ox_lib.ox_unsigned_functions_pkg.all;

entity dram_sdp is
   generic (
      g_dat_width : integer := 4; 
      g_adr_width : integer := 5;
      g_rd_latency: natural range 0 to 1 := 1
   );
   port(
      wr_clk : in std_logic;
      rd_clk : in std_logic;
      wr_en  : in std_logic;
      wr_adr : in std_logic_vector(g_adr_width-1 downto 0);
      rd_adr : in std_logic_vector(g_adr_width-1 downto 0);
      wr_dat : in std_logic_vector(g_dat_width-1 downto 0);
      rd_dat : out std_logic_vector(g_dat_width-1 downto 0)
    );
end entity;

architecture struct of dram_sdp is
   
   --constant c_adr_width_int: integer := ox_max(5,g_adr_width);
   
   --signal wr_adr_i : std_logic_vector(c_adr_width_int-1 downto 0);
   --signal rd_adr_i : std_logic_vector(c_adr_width_int-1 downto 0);
   signal rd_dat_i : std_logic_vector(rd_dat'range);
   
   type t_dist_ram is array (0 to 2**g_adr_width-1) of std_logic_vector(g_dat_width-1 downto 0);
   signal dist_ram: t_dist_ram;
   
   attribute ram_style: string;
   attribute ram_style of dist_ram: signal is "distributed"; 
   
   
begin
   
   process(wr_clk)
   begin
      if rising_edge(wr_clk) then
         if wr_en = '1' then
            dist_ram(to_integer(unsigned(wr_adr))) <= wr_dat;
         end if;
      end if;
   end process;
   
   rd_dat_i <= dist_ram(to_integer(unsigned(rd_adr)));
   
   -- wr_adr_i <= ox_resize(wr_adr,wr_adr_i'length);
   -- rd_adr_i <= ox_resize(rd_adr,rd_adr_i'length);
   
   -- mem_gen_5: if g_adr_width <= 5 generate
      -- depth_gen: for n in 0 to 0 generate
         -- bit_gen: for b in 0 to g_dat_width-1 generate
            -- RAM32X1D_inst: RAM32X1D
            -- generic map(
               -- INIT => X"00000000",
               -- IS_WCLK_INVERTED => '0'
            -- )
            -- port map(
               -- DPO   => rd_dat_i(b), 
               -- SPO   => open,
               -- A0    => wr_adr_i(0),
               -- A1    => wr_adr_i(1),
               -- A2    => wr_adr_i(2),
               -- A3    => wr_adr_i(3),
               -- A4    => wr_adr_i(4), 
               -- D     => wr_dat(b), 
               -- DPRA0 => rd_adr_i(0),
               -- DPRA1 => rd_adr_i(1),
               -- DPRA2 => rd_adr_i(2),
               -- DPRA3 => rd_adr_i(3),
               -- DPRA4 => rd_adr_i(4), 
               -- WCLK  => wr_clk,    
               -- WE    => wr_en
             -- );
         -- end generate;
      -- end generate;
   -- end generate;
   
   -- mem_gen_6: if g_adr_width = 6 generate
      -- depth_gen: for n in 0 to 0 generate
         -- bit_gen: for b in 0 to g_dat_width-1 generate
            -- RAM64X1D_inst: RAM64X1D
            -- generic map(
               -- INIT => X"00000000_00000000",
               -- IS_WCLK_INVERTED => '0'
            -- )
            -- port map(
               -- DPO   => rd_dat_i(b), 
               -- SPO   => open,
               -- A0    => wr_adr_i(0),
               -- A1    => wr_adr_i(1),
               -- A2    => wr_adr_i(2),
               -- A3    => wr_adr_i(3),
               -- A4    => wr_adr_i(4), 
               -- A5    => wr_adr_i(5),
               -- D     => wr_dat(b), 
               -- DPRA0 => rd_adr_i(0),
               -- DPRA1 => rd_adr_i(1),
               -- DPRA2 => rd_adr_i(2),
               -- DPRA3 => rd_adr_i(3),
               -- DPRA4 => rd_adr_i(4), 
               -- DPRA5 => rd_adr_i(5),
               -- WCLK  => wr_clk,    
               -- WE    => wr_en
             -- );
         -- end generate;   
      -- end generate;
   -- end generate;
   
   -- mem_gen_7: if g_adr_width = 7 generate
      -- depth_gen: for n in 0 to 0 generate
         -- bit_gen: for b in 0 to g_dat_width-1 generate
            -- RAM128X1D_inst: RAM128X1D
            -- generic map(
               -- INIT => X"00000000_00000000_00000000_00000000",
               -- IS_WCLK_INVERTED => '0'
            -- )
            -- port map(
               -- DPO   => rd_dat_i(b), 
               -- SPO   => open,
               -- A     => wr_adr_i,
               -- D     => wr_dat(b), 
               -- DPRA  => rd_adr_i,
               -- WCLK  => wr_clk,    
               -- WE    => wr_en
             -- );
         -- end generate;
      -- end generate;      
   -- end generate;
   
   -- mem_gen_8: if g_adr_width = 8 generate
      -- depth_gen: for n in 0 to 0 generate
         -- bit_gen: for b in 0 to g_dat_width-1 generate
            -- RAM256X1D_inst: RAM256X1D
            -- generic map(
               -- INIT => X"00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000",
               -- IS_WCLK_INVERTED => '0'
            -- )
            -- port map(
               -- DPO   => rd_dat_i(b), 
               -- SPO   => open,
               -- A     => wr_adr_i,
               -- D     => wr_dat(b), 
               -- DPRA  => rd_adr_i,
               -- WCLK  => wr_clk,    
               -- WE    => wr_en
             -- );
         -- end generate;  
      -- end generate;
   -- end generate;
   
   -- mem_gen_m8: if g_adr_width >= 8 generate
      -- constant c_mux_depth: integer := 2**(g_adr_width-8);
      -- type t_dat_arr is array (0 to c_mux_depth-1) of std_logic_vector(wr_dat'length-1 downto 0);
      -- signal rd_dat_arr: t_dat_arr;
      -- signal wr_demux: std_logic_vector(c_mux_depth-1 downto 0);
      -- signal rd_mux  : std_logic_vector(rd_adr_i'length-1 downto 8);
   -- begin
      -- depth_gen: for n in 0 to c_mux_depth-1 generate
         -- wr_demux(n) <= '1' when wr_adr_i(wr_adr_i'length-1 downto 8) = n else '0';
         -- bit_gen: for b in 0 to g_dat_width-1 generate
            -- RAM256X1D_inst: RAM256X1D
            -- generic map(
               -- INIT => X"00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000",
               -- IS_WCLK_INVERTED => '0'
            -- )
            -- port map(
               -- DPO   => rd_dat_arr(n)(b), 
               -- SPO   => open,
               -- A     => wr_adr_i(7 downto 0),
               -- D     => wr_dat(b), 
               -- DPRA  => rd_adr_i(7 downto 0),
               -- WCLK  => wr_clk,    
               -- WE    => wr_demux(n)
             -- );
         -- end generate;
      -- end generate;
      -- rd_mux <= rd_adr_i(rd_adr_i'length-1 downto 8);
      -- rd_dat_i <= rd_dat_arr(to_integer(unsigned(rd_mux)));
   -- end generate;
   
   rd_dat_pipe_inst: entity common_ox_lib.ox_multibit_pipe
   generic map (
      g_width     => g_dat_width,
      g_nof_stage => g_rd_latency)
   port map (
      clk => rd_clk,
      rst => '0',
      di  => rd_dat_i,
      do  => rd_dat
   );
end architecture;
