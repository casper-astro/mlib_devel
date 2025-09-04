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
--!d Pipeline registers
--!d
library ieee;
use ieee.std_logic_1164.all;

entity ox_multibit_pipe is
   generic (
      g_rst_active_val  : std_logic := '1';
      g_width           : integer := 1;
      g_nof_stage       : natural := 2
   );
   port (
      clk : in std_logic;
      rst : in std_logic;
      di  : in std_logic_vector(g_width-1 downto 0);
      do  : out std_logic_vector(g_width-1 downto 0)
   );
end entity;

architecture rtl of ox_multibit_pipe is
  
   type t_pipe_r_arr is array (0 to g_nof_stage-1) of std_logic_vector(g_width-1 downto 0);
   type t_pipe_c_arr is array (0 to g_nof_stage) of std_logic_vector(g_width-1 downto 0);
  
   signal stage_r: t_pipe_r_arr;
   signal stage_c: t_pipe_c_arr;
  
begin
   
   nof_stage_0_gen: if g_nof_stage = 0 generate
      do <= di;
   end generate;

   nof_stage_gr0_gen: if g_nof_stage > 0 generate
      
      stage_c(0) <= di;
      loop_gen: for n in 0 to g_nof_stage-1 generate
         stage_c(n+1) <= stage_r(n);
      end generate;
      
      process(rst,clk)
      begin
         if rst = g_rst_active_val then
            stage_r <= (others=>(others=>'0'));
         elsif rising_edge(clk) then
            for n in 0 to stage_r'length-1 loop
               stage_r(n) <= stage_c(n);
            end loop;
         end if;
      end process;
      
      do <= stage_c(g_nof_stage);

   end generate;

end architecture;