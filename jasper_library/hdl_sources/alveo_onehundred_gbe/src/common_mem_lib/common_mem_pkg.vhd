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
--!d 
--!d
library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;

library common_ox_lib;
use common_ox_lib.ox_functions_pkg.all;

package common_mem_pkg is

   function rd_adr_width_calc(wr_dat_w: positive; wr_adr_w: positive; rd_dat_w: positive) return positive;

   -- function maximum_nof_partions_calc(rd_dat_w: positive; rd_adr_w: positive) return positive;
   
   function nof_partitions_calc(dat_w: positive; partition_w: integer) return positive;
   function partition_w_calc(dat_w: positive; nof_partitions: integer) return positive;
   function wr_dat_reorder(wr_dat: std_logic_vector; nof_partions: positive) return std_logic_vector;


   -- type t_port_config is record
      -- dat_width: integer;
      -- adr_width: integer;
   -- end record;
   
   -- type t_dual_port_config is array (0 to 1) of t_port_config;

   -- function get_port_config(other_port_config: t_port_config; this_port_dat_width: integer) return t_port_config;

   -- function select_primitive(user_primitive: t_primitive; user_port_a: integer; user_port_b: integer;
                             -- -- mem_port_a: integer; mem_port_b: integer; mem_addr_a: integer);

end package;

package body common_mem_pkg is

   function rd_adr_width_calc(wr_dat_w: positive; wr_adr_w: positive; rd_dat_w: positive) return positive is
      variable ret: positive;
   begin
      if wr_dat_w >= rd_dat_w then
         ret := wr_adr_w + ox_log2(wr_dat_w/rd_dat_w);
      else
         ret := wr_adr_w - ox_log2(rd_dat_w/wr_dat_w);
      end if;
      return ret;
   end function;
   
   -- function maximum_nof_partions_calc(rd_dat_w: positive; rd_adr_w: positive) return positive is
      -- variable ret: positive := 1;
   -- begin
      -- l0: loop
         -- if (rd_dat_w/ret)*(2**rd_adr_w) <= 2**16 then
            -- exit l0;
         -- end if;
         -- ret := ret * 2;
      -- end loop;
      -- return ret;
   -- end function;
   
   function nof_partitions_calc(dat_w: positive; partition_w: integer) return positive is
      variable ret: positive;
   begin
      if partition_w <= 0 then
         ret := 1;
      else
         ret := positive(ceil(real(dat_w)/real(partition_w)));
      end if;
      return ret;   
   end function;
   
   function partition_w_calc(dat_w: positive; nof_partitions: integer) return positive is
       variable ret: positive;
   begin
      if nof_partitions <= 1 then
         ret := dat_w;
      else
         ret := positive(ceil(real(dat_w)/real(nof_partitions)));
      end if;
      return ret;   
   end function;
   
   function wr_dat_reorder(wr_dat: std_logic_vector; nof_partions: positive) return std_logic_vector is
      variable ret                        : std_logic_vector(wr_dat'length-1 downto 0);
      variable wr_dat_i                   : std_logic_vector(wr_dat'length-1 downto 0) := wr_dat;
      constant c_nof_slice_per_partition  : positive := nof_partions;
      constant c_nof_slice_total          : positive := nof_partions*c_nof_slice_per_partition; 
      constant c_slice_w                  : positive := wr_dat'length/c_nof_slice_total;
      type t_slice_arr is array (0 to c_nof_slice_total-1) of std_logic_vector(c_slice_w-1 downto 0);
      variable wr_dat_slice               : t_slice_arr;
      variable wr_dat_slice_reorder       : t_slice_arr;
      variable remapped_idx               : integer := 0;
   begin
      for n in 0 to c_nof_slice_total-1 loop
         wr_dat_slice(n) := wr_dat_i(c_slice_w*(n+1)-1 downto c_slice_w*n);
      end loop;
      for n in 0 to c_nof_slice_total-1 loop
         wr_dat_slice_reorder(n) := wr_dat_slice(remapped_idx);
         remapped_idx := remapped_idx + nof_partions;
         if remapped_idx >= c_nof_slice_total then
            remapped_idx := (remapped_idx + 1) - c_nof_slice_total;
         end if;
      end loop;
      for n in 0 to c_nof_slice_total-1 loop
         ret(c_slice_w*(n+1)-1 downto c_slice_w*n) := wr_dat_slice_reorder(n);
      end loop;
      return ret;   
   end function;

   -- function get_port_config(other_port_config: t_port_config; this_port_dat_width: integer) return t_port_config is
      -- variable this_port_config: t_port_config;
   -- begin
      -- this_port_config.dat_width := this_port_dat_width;
      -- this_port_config.adr_width := integer(real(other_port_config.dat_width)/real(this_port_dat_width)*real(other_port_config.adr_width));
      -- return this_port_config;
   -- end function;
   
end package body;