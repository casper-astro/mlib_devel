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

entity ox_bit_sync is
   generic (
      g_rst_in_active_val: std_logic:='1';
      g_rst_val: std_logic:='0';
      g_nof_sync_stage : natural := 2
   );
   port (
      rst_in      : in  std_logic := '0';
      clk         : in  std_logic;
      di          : in std_logic;
      
      do_sync     : out std_logic;
      do_sync_all : out std_logic_vector(g_nof_sync_stage downto 0);
      edge_fall   : out std_logic;     
      edge_rise   : out std_logic;
      edge_both   : out std_logic
   );
end entity;

architecture rtl of ox_bit_sync is
  
   signal edge_detect_0: std_logic;
   signal edge_detect_1: std_logic;

begin
   
   nof_stage_0_gen: if g_nof_sync_stage = 0 generate
      process(rst_in,clk)
      begin
         if rst_in = g_rst_in_active_val then
            edge_detect_1  <= g_rst_val;
         elsif rising_edge(clk) then
            edge_detect_1 <= di; 
         end if;
      end process;

      edge_detect_0  <= di;
      do_sync        <= di;
      do_sync_all(0) <= di; 

   end generate;
   
   nof_stage_gr0_gen: if g_nof_sync_stage > 0 generate
      signal sync_stage_r: std_logic_vector(g_nof_sync_stage-1 downto 0);
      signal sync_stage_c: std_logic_vector(g_nof_sync_stage downto 0);
      attribute syn_keep: boolean;
      attribute syn_keep of sync_stage_r: signal is true;
      attribute keep: string;
      attribute keep of sync_stage_r: signal is "hard";
      attribute DONT_TOUCH: string;
      attribute DONT_TOUCH of sync_stage_r: signal is "true";
   begin
      
      sync_stage_c(0) <= di;
      sync_stage_c(sync_stage_c'length-1 downto 1) <= sync_stage_r;

      process(rst_in,clk)
      begin
         if rst_in = g_rst_in_active_val then
            sync_stage_r <= (others=>g_rst_val);
            edge_detect_1  <= g_rst_val;
         elsif rising_edge(clk) then
            sync_stage_r <= sync_stage_c(sync_stage_r'range);
            edge_detect_1 <= sync_stage_c(sync_stage_c'length-1); 
         end if;
      end process;
   
      edge_detect_0  <= sync_stage_c(g_nof_sync_stage);
      do_sync        <= sync_stage_c(g_nof_sync_stage);
      do_sync_all    <= sync_stage_c;
      
   end generate;
   
   edge_rise   <= '1' when edge_detect_0 = '1' and edge_detect_1 = '0' else '0';
   edge_fall   <= '1' when edge_detect_0 = '0' and edge_detect_1 = '1' else '0';
   edge_both   <= '1' when edge_detect_0 /= edge_detect_1              else '0';
      
end rtl;