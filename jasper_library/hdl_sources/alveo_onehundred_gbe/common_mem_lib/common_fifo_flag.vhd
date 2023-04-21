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
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_misc.all;
use IEEE.numeric_std.all;

library common_ox_lib;
use common_ox_lib.ox_functions_pkg.all;
use common_ox_lib.ox_unsigned_functions_pkg.all;

entity common_fifo_flag is
   generic(
      g_dual_clock     : boolean := true;
      g_nof_sync_stage : positive:= 2;
      g_wr_width       : natural := 4;
      g_rd_width       : natural := 4;
      g_prog_empty_val : natural := 1;
      g_prog_full_val  : natural := 1;
      g_wr_rst_val     : std_logic := '1';
      g_rd_rst_val     : std_logic := '1'  
   );
   port(
      rd_clk       : in  std_logic;
      wr_clk       : in  std_logic;
      rd_rst       : in  std_logic;
      wr_rst       : in  std_logic;
      we           : in  std_logic;
      wadd         : in  std_logic_vector(g_wr_width - 1 downto 0);
      wadd_pp      : in  std_logic_vector(g_wr_width - 1 downto 0);
      re           : in  std_logic;
      radd         : in  std_logic_vector(g_rd_width - 1 downto 0);
      radd_pp      : in  std_logic_vector(g_rd_width - 1 downto 0);

      empty_c      : out std_logic;
      full_c       : out std_logic;
      prog_empty_c : out std_logic;
      prog_full_c  : out std_logic;
      wstatus      : out std_logic_vector(g_wr_width - 1 downto 0);
      rstatus      : out std_logic_vector(g_rd_width - 1 downto 0)
   );
end common_fifo_flag;

architecture common_fifo_flag_a of common_fifo_flag is
   
   constant max_width : positive := ox_max(g_wr_width, g_rd_width);
   constant min_width : positive := ox_min(g_wr_width, g_rd_width);
   constant ar        : positive := 2**(max_width - min_width);
   constant log2_ar   : natural  := max_width - min_width;

   signal wadd_gray           : std_logic_vector(min_width - 1 downto 0);
   signal wadd_gray_pp        : std_logic_vector(min_width - 1 downto 0);
   signal radd_gray_wr_synced : std_logic_vector(min_width - 1 downto 0);
   signal radd_gray           : std_logic_vector(min_width - 1 downto 0);
   signal radd_gray_pp        : std_logic_vector(min_width - 1 downto 0);
   signal wadd_gray_rd_synced : std_logic_vector(min_width - 1 downto 0);
   signal radd_wr_flag_bin    : std_logic_vector(g_wr_width - 1 downto 0);
   signal wadd_rd_flag_bin    : std_logic_vector(g_rd_width - 1 downto 0);
   signal radd_wr_flag_gray   : std_logic_vector(g_wr_width - 1 downto 0);
   signal wadd_rd_flag_gray   : std_logic_vector(g_rd_width - 1 downto 0);

   signal empty_c_i: std_logic_vector(1 downto 0);
   signal full_c_i : std_logic_vector(1 downto 0);
   signal diff_r_c : std_logic_vector(g_rd_width - 1 downto 0);
   signal diff_w_c : std_logic_vector(g_wr_width - 1 downto 0);
   signal diff_r   : std_logic_vector(g_rd_width - 1 downto 0);
   signal diff_w   : std_logic_vector(g_wr_width - 1 downto 0);

begin
   ----------------------------------------------------------------------------
   -- write side gray-coded counter                                          --
   ----------------------------------------------------------------------------
   process(wr_clk, wr_rst)
   begin
      if wr_rst = g_wr_rst_val then
         diff_w      <= (others => '0');
         wadd_gray   <= (others => '0');
      elsif rising_edge(wr_clk) then
         diff_w <= diff_w_c;
         if we = '1' then
            wadd_gray <= wadd_gray_pp;
         end if;
      end if;
   end process;
   ----------------------------------------------------------------------------
   -- read side gray-coded counter                                           --
   ----------------------------------------------------------------------------
   process(rd_clk, rd_rst)
   begin
      if rd_rst = g_rd_rst_val then
         diff_r      <= (others => '0');
         radd_gray   <= (others => '0');
      elsif rising_edge(rd_clk) then
         diff_r <= diff_r_c;
         if re = '1' then
            radd_gray <= radd_gray_pp;
         end if;
      end if;
   end process;
   ----------------------------------------------------------------------------
   -- write counter to read clock domain sync                                --
   ----------------------------------------------------------------------------
   wadd_to_rd_sync_inst: entity common_ox_lib.ox_multibit_sync
   generic map (
      g_rst_in_active_val => g_rd_rst_val,
      g_rst_val           => '0',
      g_nof_sync_stage    => g_nof_sync_stage,
      g_width             => min_width)
   port map (
      rst_in  => rd_rst,
      clk     => rd_clk,
      di      => wadd_gray,
      do_sync => wadd_gray_rd_synced);
   ----------------------------------------------------------------------------
   -- read counter to write clock domain sync                                --
   ----------------------------------------------------------------------------
   radd_to_wr_sync_inst: entity common_ox_lib.ox_multibit_sync
   generic map (
      g_rst_in_active_val => g_wr_rst_val,
      g_rst_val           => '0',
      g_nof_sync_stage    => g_nof_sync_stage,
      g_width             => min_width)
   port map (
      rst_in  => wr_rst,
      clk     => wr_clk,
      di      => radd_gray,
      do_sync => radd_gray_wr_synced);
   ----------------------------------------------------------------------------
   -- gray-bin / bin-gray conversion                                         --
   ----------------------------------------------------------------------------
   wr_ar1_gen : if g_wr_width = g_rd_width generate
      wadd_gray_pp <= ox_bin2gray(wadd_pp);
      radd_gray_pp <= ox_bin2gray(radd_pp);
      cc_gen_0 : if g_dual_clock = true generate
         radd_wr_flag_bin <= ox_gray2bin(radd_gray_wr_synced);
         wadd_rd_flag_bin <= ox_gray2bin(wadd_gray_rd_synced);
      end generate;
      cc_gen_1 : if g_dual_clock = false generate
         radd_wr_flag_bin <= radd;
         wadd_rd_flag_bin <= wadd;
      end generate;
   end generate;

   wr_ar2_gen : if g_wr_width > g_rd_width generate
      wadd_gray_pp <= ox_bin2gray(wadd_pp(wadd_pp'length - 1 downto log2_ar));
      radd_gray_pp <= ox_bin2gray(radd_pp);
      cc_gen_0 : if g_dual_clock = true generate
         radd_wr_flag_bin <= ox_gray2bin(radd_gray_wr_synced) & ox_expand('0', log2_ar);
         wadd_rd_flag_bin <= ox_gray2bin(wadd_gray_rd_synced);
      end generate;
      cc_gen_1 : if g_dual_clock = false generate
         radd_wr_flag_bin <= radd & ox_expand('0', log2_ar);
         wadd_rd_flag_bin <= wadd(wadd'length - 1 downto log2_ar);
      end generate;
   end generate;

   wr_ar3_gen : if g_rd_width > g_wr_width generate
      wadd_gray_pp <= ox_bin2gray(wadd_pp);
      radd_gray_pp <= ox_bin2gray(radd_pp(radd_pp'length - 1 downto log2_ar));
      cc_gen_0 : if g_dual_clock = true generate
         radd_wr_flag_bin <= ox_gray2bin(radd_gray_wr_synced);
         wadd_rd_flag_bin <= ox_gray2bin(wadd_gray_rd_synced) & ox_expand('0', log2_ar);
      end generate;
      cc_gen_1 : if g_dual_clock = false generate
         radd_wr_flag_bin <= radd(radd'length - 1 downto log2_ar);
         wadd_rd_flag_bin <= wadd & ox_expand('0', log2_ar);
      end generate;
   end generate;
   ---------------------------------------------------------------------------- 
   -- full                                                                   --
   ---------------------------------------------------------------------------- 
   -- full_gen_0 : if g_dual_clock = true generate
      -- full_c_i(0) <= '1' when wadd_gray(g_wr_width - 1) /= wadd_gray_rd_synced(g_wr_width - 1) and 
                              -- wadd_gray(g_wr_width - 2 downto 0) = wadd_gray_rd_synced(g_wr_width - 2 downto 0) else '0';
      -- full_c_i(1) <= '1' when wadd_gray_pp(g_wr_width - 1) /= wadd_gray_rd_synced(g_wr_width - 1) and 
                              -- wadd_gray_pp(g_wr_width - 2 downto 0) = wadd_gray_rd_synced(g_wr_width - 2 downto 0) and we = '1' else '0';
   -- end generate;
   -- full_gen_1: if g_dual_clock = false generate
      full_c_i(0) <= '1' when wadd(g_wr_width - 1) /= radd_wr_flag_bin(g_wr_width - 1) and 
                              wadd(g_wr_width - 2 downto 0) = radd_wr_flag_bin(g_wr_width - 2 downto 0) else '0';
      full_c_i(1) <= '1' when wadd_pp(g_wr_width - 1) /= radd_wr_flag_bin(g_wr_width - 1) and 
                              wadd_pp(g_wr_width - 2 downto 0) = radd_wr_flag_bin(g_wr_width - 2 downto 0) and we = '1' else '0';
   -- end generate;
   full_c <= or_reduce(full_c_i);
   ---------------------------------------------------------------------------- 
   -- empty                                                                  --
   ---------------------------------------------------------------------------- 
   -- empty_gen_0 : if g_dual_clock = true generate
      -- empty_c_i(0) <= '1' when radd_gray = wadd_gray_rd_synced else '0';
      -- empty_c_i(1) <= '1' when radd_gray_pp = wadd_gray_rd_synced and re = '1' else '0';
   -- end generate;
   -- empty_gen_1 : if g_dual_clock = false generate
      empty_c_i(0) <= '1' when radd = wadd_rd_flag_bin else '0';
      empty_c_i(1) <= '1' when radd_pp = wadd_rd_flag_bin and re = '1' else '0';
   -- end generate;
   empty_c <= or_reduce(empty_c_i);
   ----------------------------------------------------------------------------
   -- programmable flags                                                     --
   ----------------------------------------------------------------------------
   diff_w_c <= wadd - radd_wr_flag_bin;
   diff_r_c <= wadd_rd_flag_bin - radd;
   
   prog_empty_c <= '1' when (diff_r_c <= g_prog_empty_val+1) else '0';
   prog_full_c  <= '1' when (diff_w_c >= g_prog_full_val-1) and g_prog_full_val > 1 else
                   '1' when ((diff_w_c >= g_prog_full_val) or (diff_w_c = 0 and we = '1')) and g_prog_full_val = 1 else '0';
   rstatus <= diff_r;
   wstatus <= diff_w;
end architecture;