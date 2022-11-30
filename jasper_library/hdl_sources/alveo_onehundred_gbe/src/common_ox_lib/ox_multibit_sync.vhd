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
--!d Bit synchronizer and edge detector.
--!d
library ieee;
use ieee.std_logic_1164.all;

library common_ox_lib;

entity ox_multibit_sync is
   generic (
      g_rst_in_active_val: std_logic:='1';
      g_rst_val: std_logic:='0';
      g_nof_sync_stage : natural := 2;
      g_width: integer := 2
   );
   port (
      rst_in      : in  std_logic := '0';
      clk         : in  std_logic;
      di          : in std_logic_vector(g_width-1 downto 0);
      do_sync     : out std_logic_vector(g_width-1 downto 0)
   );
end entity;

architecture rtl of ox_multibit_sync is
  
begin

   reg_gen: for b in 0 to g_width-1 generate
      ox_bit_sync_inst: entity common_ox_lib.ox_bit_sync
      generic map (
         g_rst_in_active_val => g_rst_in_active_val,
         g_rst_val           => g_rst_val,
         g_nof_sync_stage    => g_nof_sync_stage)
      port map (
         rst_in      => rst_in,
         clk         => clk,
         di          => di(b),
         do_sync     => do_sync(b)
      );
   end generate;
      
end rtl;