-- This file is part of XML2VHDL
-- Copyright (C) 2015
-- University of Oxford <http://www.ox.ac.uk/>
-- Department of Physics
-- 
-- This program is free software: you can redistribute it and/or modify  
-- it under the terms of the GNU General Public License as published by  
-- the Free Software Foundation, version 3.
--
-- This program is distributed in the hope that it will be useful, but 
-- WITHOUT ANY WARRANTY; without even the implied warranty of 
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU 
-- General Public License for more details.
--
-- You should have received a copy of the GNU General Public License 
-- along with this program. If not, see <http://www.gnu.org/licenses/>.

library ieee;
use ieee.std_logic_1164.all;

library axi4_lib;
use axi4_lib.axi4lite_pkg.all;

package axi4lite_udp_core_top_mmap_pkg is  
   --##########################################################################
   -- The AXI4 Lite subsystem is defined by
   --    * number of slaves
   --    * slave names
   --    * slave base addresses
   --
   -- Number of slaves, their names and base addresses are specified in 
   -- t_axi4lite_mmap_slave enum type. This must have a number of elements
   -- equal to the number of implemented slaves. Each element defines a slave
   -- name and corresponding slave id (positionally). Although it seems weird,
   -- base addresses are specified as element of an enum type, this permits to
   -- completely specify the AXI4 Lite subsystem in a single place, and we get
   -- some error checks for free, e.g. no slave can have the same base address
   -- without generating an error.
   --##########################################################################
   type t_axi4lite_mmap_slaves is (
      id_udp_core_control ,
      id_arp_mode_control ,
      id_farm_mode_lut    
   );

   constant c_axi4lite_mmap_nof_slave: positive := (t_axi4lite_mmap_slaves'pos(t_axi4lite_mmap_slaves'right) - 
                                                    t_axi4lite_mmap_slaves'pos(t_axi4lite_mmap_slaves'left)  + 1);
   
   type t_axi4lite_mmap_addr_arr is array (0 to c_axi4lite_mmap_nof_slave-1) of std_logic_vector(c_axi4lite_addr_w-1 downto 0);
   --
   -- THIS CONSTANT HOLDS BASE ADDRESSES. DO NOT MODIFY!
   --
   constant c_axi4lite_mmap_baddr: t_axi4lite_mmap_addr_arr;
   --
   -- THIS CONSTANT HOLDS DECODING MASKS. DO NOT MODIFY!
   --
   constant c_axi4lite_mmap_mask: t_axi4lite_mmap_addr_arr;
   --
   -- THIS FUNCTION CONVERTS BETWEEN SLAVE NAME AND SLAVE ID. DO NOT MODIFY!
   --
   function axi4lite_mmap_get_id(str_id: t_axi4lite_mmap_slaves) return integer;
   --
   -- THIS FUNCTION PERFORMS A SIMPLE ADDRESS DECODER. MODIFY IF NEEDED.
   --
   function axi4lite_mmap_decoder(addr: std_logic_vector) return std_logic_vector;

end package; 

package body axi4lite_udp_core_top_mmap_pkg is
        
   function axi4lite_mmap_get_id(str_id: t_axi4lite_mmap_slaves) return integer is
      variable ret: integer := -1;
   begin
      ret := t_axi4lite_mmap_slaves'pos(str_id); 
      return ret;     
   end function;
   
   function axi4lite_mmap_decoder(addr: std_logic_vector) return std_logic_vector is
      variable addr_i: std_logic_vector(addr'length-1 downto 0):=addr;
      variable slave_hit: std_logic_vector(c_axi4lite_mmap_nof_slave-1 downto 0);
   begin
      slave_hit := (others=>'1');
      for n in 0 to c_axi4lite_mmap_nof_slave-1 loop
         loop_b:for b in 0 to addr'length-1 loop
            if c_axi4lite_mmap_mask(n)(b) = '1' then
               if c_axi4lite_mmap_baddr(n)(b) /= addr_i(b) then
                  slave_hit(n) := '0';
                  exit loop_b;
               end if;
            end if;
         end loop;
      end loop;
      return slave_hit;
   end function;
   
   constant c_axi4lite_mmap_baddr: t_axi4lite_mmap_addr_arr := (X"00000000",X"00000800",X"00001000");
   constant c_axi4lite_mmap_mask: t_axi4lite_mmap_addr_arr := (X"00001800",X"00001800",X"00001000");

end package body;
