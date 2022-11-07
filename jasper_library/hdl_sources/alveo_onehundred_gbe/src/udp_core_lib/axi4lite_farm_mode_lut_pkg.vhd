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

package axi4lite_farm_mode_lut_pkg is 

   --##########################################################################
   --
   -- Register Records
   --
   --##########################################################################
   --##########################################################################
   --
   -- Register Decoded Records
   --
   --##########################################################################
   type t_axi4lite_farm_mode_lut_decoded is record
      lower_mac_addr: std_logic;
      upper_mac_addr: std_logic;
      ip_addr: std_logic;
      dst_port: std_logic;
   end record;

   --##########################################################################
   --
   -- Register Descriptors
   --
   --##########################################################################
   type t_access_type is (r,w,rw);
   type t_reset_type is (async_reset,no_reset);
   
   type t_reg_descr is record
      offset: std_logic_vector(31 downto 0);
      bit_hi: natural;
      bit_lo: natural;
      rst_val: std_logic_vector(31 downto 0);
      reset_type: t_reset_type;
      decoder_mask: std_logic_vector(31 downto 0);
      access_type: t_access_type;
   end record;
   
   type t_axi4lite_farm_mode_lut_descr is record
      lower_mac_addr: t_reg_descr;
      upper_mac_addr: t_reg_descr;
      ip_addr: t_reg_descr;
      dst_port: t_reg_descr;
   end record;

   
   constant axi4lite_farm_mode_lut_descr: t_axi4lite_farm_mode_lut_descr := (
      lower_mac_addr  => (X"00000000",31, 0,X"00000000",async_reset,X"00000c00",rw),
      upper_mac_addr  => (X"00000400",15, 0,X"00000000",async_reset,X"00000c00",rw),
      ip_addr         => (X"00000800",31, 0,X"00000000",async_reset,X"00000c00",rw),
      dst_port        => (X"00000c00",15, 0,X"00000000",async_reset,X"00000c00",rw)
   );

   --##########################################################################
   --
   -- Constants
   --
   --##########################################################################
   constant c_nof_register_blocks: integer := 0;
   constant c_nof_memory_blocks: integer := 4;
   constant c_total_nof_blocks: integer := c_nof_memory_blocks+c_nof_register_blocks;
   
   type t_ipb_farm_mode_lut_mosi_arr is array (0 to c_total_nof_blocks-1) of t_ipb_mosi;
   type t_ipb_farm_mode_lut_miso_arr is array (0 to c_total_nof_blocks-1) of t_ipb_miso;
   
   type t_ipb_farm_mode_lut_mapping is record
      lower_mac_addr: integer;
      upper_mac_addr: integer;
      ip_addr: integer;
      dst_port: integer;
   end record;

   constant c_ipb_farm_mode_lut_mapping: t_ipb_farm_mode_lut_mapping := (
      lower_mac_addr=> 0,
      upper_mac_addr=> 1,
      ip_addr=> 2,
      dst_port=> 3
   );

   --##########################################################################
   --
   -- Functions
   --
   --##########################################################################
   function axi4lite_farm_mode_lut_decoder(descr: t_reg_descr; addr: std_logic_vector) return boolean;
   
   function axi4lite_farm_mode_lut_full_decoder(addr: std_logic_vector; en: std_logic) return t_axi4lite_farm_mode_lut_decoded;
   
   
   function axi4lite_farm_mode_lut_demux(addr: std_logic_vector) return std_logic_vector;

end package;

package body axi4lite_farm_mode_lut_pkg is
   
   function axi4lite_farm_mode_lut_decoder(descr: t_reg_descr; addr: std_logic_vector) return boolean is
      variable ret: boolean:=true;
      variable bus_addr_i: std_logic_vector(addr'length-1 downto 0) := addr;
      variable mask_i: std_logic_vector(descr.decoder_mask'length-1 downto 0) := descr.decoder_mask;
      variable reg_addr_i: std_logic_vector(descr.offset'length-1 downto 0) := descr.offset;
   begin
      for n in 0 to bus_addr_i'length-1 loop
         if mask_i(n) = '1' and bus_addr_i(n) /= reg_addr_i(n) then
            ret := false;
         end if;
      end loop;
      return ret;
   end function;
   
   function axi4lite_farm_mode_lut_full_decoder(addr: std_logic_vector; en: std_logic) return t_axi4lite_farm_mode_lut_decoded is
      variable farm_mode_lut_decoded: t_axi4lite_farm_mode_lut_decoded;
   begin
   
      farm_mode_lut_decoded.lower_mac_addr := '0';
      if axi4lite_farm_mode_lut_decoder(axi4lite_farm_mode_lut_descr.lower_mac_addr,addr) = true and en = '1' then
         farm_mode_lut_decoded.lower_mac_addr := '1';
      end if;
      
      farm_mode_lut_decoded.upper_mac_addr := '0';
      if axi4lite_farm_mode_lut_decoder(axi4lite_farm_mode_lut_descr.upper_mac_addr,addr) = true and en = '1' then
         farm_mode_lut_decoded.upper_mac_addr := '1';
      end if;
      
      farm_mode_lut_decoded.ip_addr := '0';
      if axi4lite_farm_mode_lut_decoder(axi4lite_farm_mode_lut_descr.ip_addr,addr) = true and en = '1' then
         farm_mode_lut_decoded.ip_addr := '1';
      end if;
      
      farm_mode_lut_decoded.dst_port := '0';
      if axi4lite_farm_mode_lut_decoder(axi4lite_farm_mode_lut_descr.dst_port,addr) = true and en = '1' then
         farm_mode_lut_decoded.dst_port := '1';
      end if;
      
      
      return farm_mode_lut_decoded;
   end function;
     
   
   function axi4lite_farm_mode_lut_demux(addr: std_logic_vector) return std_logic_vector is
      variable ret: std_logic_vector(c_total_nof_blocks-1 downto 0);
   begin
      ret := (others=>'0');
      if c_total_nof_blocks = 1 then
         ret := (others=>'1');
      else

         if axi4lite_farm_mode_lut_decoder(axi4lite_farm_mode_lut_descr.lower_mac_addr,addr) = true then
            ret(0) := '1';
         end if;
         
         if axi4lite_farm_mode_lut_decoder(axi4lite_farm_mode_lut_descr.upper_mac_addr,addr) = true then
            ret(1) := '1';
         end if;
         
         if axi4lite_farm_mode_lut_decoder(axi4lite_farm_mode_lut_descr.ip_addr,addr) = true then
            ret(2) := '1';
         end if;
         
         if axi4lite_farm_mode_lut_decoder(axi4lite_farm_mode_lut_descr.dst_port,addr) = true then
            ret(3) := '1';
         end if;
         
  
      end if;
      return ret;
   end function;

end package body;

