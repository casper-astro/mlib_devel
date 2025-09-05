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
--!d Useful functions including log2, shift, expand, resize."
--!d
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package ox_functions_pkg is 
    
   type t_pack_descr is record
      len: natural;
      pack: integer;
   end record;
   
   type t_pack_descr_arr is array (integer range <>) of t_pack_descr;
    
   type ox_shreg_direction_type is (left,right);
   --***************************************************************************
   -- OX_LOG2: return log2
   --***************************************************************************   
   function ox_log2(input: positive) return natural;
   --***************************************************************************
   -- OX_LOG2_NOT_0: return log2, returns 1 when argument is 1
   --***************************************************************************
   function ox_log2_not_0(input: integer) return natural;   
   --***************************************************************************
   -- OX_RESIZE: performs vector resizing trimming or adding MSBs as zeros 
   --***************************************************************************
   function ox_resize(a: std_logic_vector; b: integer) return std_logic_vector;
   --***************************************************************************
   -- OX_RESIZE: performs vector resizing trimming or adding MSBs as zeros 
   --***************************************************************************
   function ox_resize(a: integer; b: integer) return std_logic_vector; 
   --***************************************************************************
   -- OX_EXPAND: returns a vector of size b where all vector elements are 
   --            equal to b 
   --***************************************************************************
   function ox_expand(a: std_logic; b: integer) return std_logic_vector;
   --***************************************************************************
   -- OX_SHREG: shift to left including new element as LSB element 
   --***************************************************************************   
   function ox_shreg(a: std_logic_vector; b: std_logic) return std_logic_vector;
   --***************************************************************************
   -- OX_SHREG: shift to right including new element as MSB element 
   --***************************************************************************
   function ox_shreg(a: std_logic; b: std_logic_vector) return std_logic_vector;
   --***************************************************************************
   -- OX_SHREG: generic shift, shifts vector a of num position to the specified
   --           direction. New bits are specified as b vector
   --***************************************************************************
   function ox_shreg(a: std_logic_vector; b: std_logic_vector; num: positive; 
                     direction: ox_shreg_direction_type) return std_logic_vector;
   --***************************************************************************
   -- OX_MIN: returns the smaller value of a couple of integer
   --***************************************************************************                                    
   function ox_min(a: integer; b: integer) return integer;
   --***************************************************************************
   -- OX_MIN: returns the larger value of a couple of integer
   --***************************************************************************                                    
   function ox_max(a: integer; b: integer) return integer;
   --***************************************************************************
   -- OX_BIN2GRAY: binary to gray-code encoder
   --***************************************************************************                                    
   function ox_bin2gray(a: std_logic_vector) return std_logic_vector;
   --***************************************************************************
   -- OX_BIN2GRAY: gray-code to binary decoder
   --***************************************************************************                                    
   function ox_gray2bin(a: std_logic_vector) return std_logic_vector;
   --***************************************************************************
   -- OX_GET_PACK_LEN: return the length of packed signals described by descr
   --***************************************************************************     
   function ox_get_pack_len(constant descr: t_pack_descr_arr) return integer;
   --***************************************************************************
   -- OX_PACK: packs multiple signals into a single signal
   --***************************************************************************                                    
   function ox_pack(unpacked: std_logic_vector; constant descr: t_pack_descr_arr) return std_logic_vector;  
   --***************************************************************************
   -- OX_UNPACK: unpacks a signal from packed signal
   --*************************************************************************** 
   function ox_unpack(packed: std_logic_vector; constant descr: t_pack_descr_arr; idx: integer) return std_logic_vector; 
   --***************************************************************************
   -- OX_BOOL2SL: converts a boolean to std_logic
   --*************************************************************************** 
   function ox_bool2sl(a: boolean) return std_logic;   
   --***************************************************************************
   -- OX_PIPELINED_MUX_NOF_STAGE_CALC: returns the number of pipeline stage
   --*************************************************************************** 
   function ox_pipelined_mux_nof_calc(nof_selection: integer) return integer;     
   

end ox_functions_pkg; 

package body ox_functions_pkg is
   --***************************************************************************
   -- OX_LOG2
   --***************************************************************************
   function ox_log2 (input: positive) return natural is
      variable log: integer:=0;
      variable res: natural;
   begin
      assert input > 0
      report "ox_functions_pkg ERROR! ox_log2 input < 0!"
      severity failure;
      while 2**log < input loop
         log := log + 1;
      end loop;
      res := log;
      return res;
   end function;      
   --***************************************************************************
   -- OX_LOG2_NOT_0
   --***************************************************************************   
   function ox_log2_not_0 (input: integer) return natural is
      variable log: integer:=0;
      variable res: natural;
   begin 
      assert input > 0
      report "ox_functions_pkg ERROR! ox_log2_not_0 input < 0!"
      severity failure;
      if input = 1 then 
         log := 1;
      else
         while 2**log < input loop
            log := log + 1;
         end loop;   
      end if;
      res := log;
      return res;
   end function;       
   --***************************************************************************
   -- OX_RESIZE
   --***************************************************************************   
   function ox_resize (a: std_logic_vector; b: integer) return std_logic_vector is
      variable ret: std_logic_vector(b-1 downto 0);
      variable int: std_logic_vector(a'length-1 downto 0):=a;
   begin
      if b <= int'length then
         ret := int(b-1 downto 0);
      else
         ret(int'length-1 downto 0) := int;
         ret(b-1 downto int'length) := (others=>'0');
      end if;
      return ret;
   end function;   
   --***************************************************************************
   -- OX_RESIZE
   --***************************************************************************   
   function ox_resize (a: integer; b: integer) return std_logic_vector is
      variable ret: std_logic_vector(b-1 downto 0);
   begin
      ret := std_logic_vector(to_unsigned(a,b));
      return ret;
   end function;    
   --***************************************************************************
   -- OX_EXPAND
   --***************************************************************************
   function ox_expand (a: std_logic; b: integer) return std_logic_vector is
      variable ret: std_logic_vector(b-1 downto 0);
   begin
      for n in 0 to b-1 loop
         ret(n) := a;
      end loop;
      return ret;
   end function;  
   --***************************************************************************
   -- OX_SHREG
   --***************************************************************************
   function ox_shreg(a: std_logic_vector; b: std_logic) return std_logic_vector is
       variable a_i: std_logic_vector(a'length-1 downto 0):=a;
    begin
      if a'length = 1 then
         a_i(0) := b;
      else
         a_i := (a_i(a_i'length-2 downto 0) & b);
      end if;
      return a_i;
   end function;      
   --***************************************************************************
   -- OX_SHREG
   --***************************************************************************
   function ox_shreg(a: std_logic; b: std_logic_vector) return std_logic_vector is
       variable b_i: std_logic_vector(b'length-1 downto 0):=b; 
    begin
      if b_i'length = 1 then
         b_i(0) := a;
      else
         b_i := (a & b_i(b_i'length-1 downto 1));
      end if;
      return b_i;
   end function;
   --***************************************************************************
   -- OX_SHREG
   --***************************************************************************    
   function ox_shreg(a: std_logic_vector; b: std_logic_vector; num: positive; 
                     direction: ox_shreg_direction_type) return std_logic_vector is
      variable a_i: std_logic_vector(a'length-1 downto 0):=a;
   begin
      assert a'length >= num
      report "ox_functions_pkg ERROR! ox_shreg input length error!"
      severity failure;  
      if direction = left then
         return (a_i(a_i'length-1-num downto 0) & b(num-1 downto 0));
      else
         return (b(num-1 downto 0) & a_i(a_i'length-1 downto num));    
      end if;
   end function; 
   --***************************************************************************
   -- OX_MIN: returns the smaller value of a couple of integer
   --***************************************************************************                                    
   function ox_min(a: integer; b: integer) return integer is
   begin
      if a < b then 
         return a;
      else 
         return b;
      end if;
   end function; 
   --***************************************************************************
   -- OX_MAX: returns the smaller value of a couple of integer
   --***************************************************************************                                    
   function ox_max(a: integer; b: integer) return integer is
   begin
      if a > b then 
         return a;
      else 
         return b;
      end if;
   end function; 
   --***************************************************************************
   -- OX_BIN2GRAY: binary to gray-code encoder
   --***************************************************************************                                    
   function ox_bin2gray(a: std_logic_vector) return std_logic_vector is
      variable a_i: std_logic_vector(a'length-1 downto 0):=a;
   begin
      assert a_i'length > 1
      report "common_ox_lib.ox_bin2gray error! Input length must be greater than 1!"
      severity failure;
      return a_i xor ("0" & a_i(a_i'length - 1 downto 1));
   end function;
   --***************************************************************************
   -- OX_GRAY2BIN: gray-code to binary decoder
   --***************************************************************************                                                                     
   function ox_gray2bin(a: std_logic_vector) return std_logic_vector is
      variable a_i: std_logic_vector(a'length-1 downto 0):=a;
      variable bin: std_logic_vector(a_i'range);
      variable int: std_logic;
   begin
      assert a_i'length > 1
      report "common_ox_lib.ox_gray2bin error! Input length must be greater than 1!"
      severity failure;      
      int := '0';
      for n in a_i'length - 1 downto 0 loop
         bin(n) := a_i(n) xor int;
         int    := bin(n);
      end loop;
      return bin;
   end function;
   --***************************************************************************
   -- OX_GET_PACK_LEN: return the length of packed signals described by descr
   --***************************************************************************     
   function ox_get_pack_len(constant descr: t_pack_descr_arr) return integer is
      variable ret: integer := 0;
   begin
      for n in 0 to descr'length-1 loop
         if descr(n).pack > 0 then
            ret := ret + descr(n).len;
         end if;
      end loop;
      return ret;
   end function;
   --***************************************************************************
   -- OX_PACK: packs multiple signals into a single signal
   --***************************************************************************                                    
   function ox_pack(unpacked: std_logic_vector; constant descr: t_pack_descr_arr) return std_logic_vector is
      variable unpacked_i: std_logic_vector(unpacked'length-1 downto 0):=unpacked;
      variable pack_len: integer := ox_get_pack_len(descr);
      variable ret: std_logic_vector(pack_len-1 downto 0):=(others=>'0');
      variable pack_lo_idx: integer := 0;
      variable pack_hi_idx: integer := 0;
      variable unpack_lo_idx: integer := 0;
      variable unpack_hi_idx: integer := 0;
      variable total_len: integer := 0;
   begin
      for n in 0 to descr'length-1 loop
         total_len := total_len + descr(n).len;
      end loop;
      assert total_len = unpacked'length
      report "ox_pack.vhd: the unpacked std_logic_vector is different from descriptor implied total length!"
      severity failure;
      for n in 0 to descr'length-1 loop
         pack_hi_idx := pack_lo_idx + descr(n).len - 1;
         unpack_hi_idx := unpack_lo_idx + descr(n).len - 1;
         if descr(n).pack > 0 then
            ret(pack_hi_idx downto pack_lo_idx) := unpacked_i(unpack_hi_idx downto unpack_lo_idx);
            pack_lo_idx := pack_lo_idx + descr(n).len;
         end if;
         unpack_lo_idx := unpack_lo_idx + descr(n).len;
      end loop;
      return ret;
   end function;
   --***************************************************************************
   -- OX_UNPACK: unpacks a signal from packed signal
   --*************************************************************************** 
   function ox_unpack(packed: std_logic_vector; constant descr: t_pack_descr_arr; idx: integer) return std_logic_vector is 
      variable int: std_logic_vector(packed'length-1 downto 0):= packed;
      variable lo_idx: integer := 0;
      variable hi_idx: integer := 0;
      variable ret: std_logic_vector(descr(idx).len-1 downto 0):=(others=>'0');
   begin
      if descr(idx).pack = 0 then
         return ox_expand('0',descr(idx).len);
      else
         for n in 0 to idx-1 loop
            if descr(n).pack > 0 then
               lo_idx := lo_idx + descr(n).len;
            end if;
         end loop;
         hi_idx := lo_idx + descr(idx).len - 1;
         ret := int(hi_idx downto lo_idx);
         return ret;
      end if;
   end function;
   --***************************************************************************
   -- OX_BOOL2SL: converts a boolean to std_logic
   --*************************************************************************** 
   function ox_bool2sl(a: boolean) return std_logic is
      variable ret: std_logic;
   begin
      if a = true then
         ret := '1';
      else
         ret := '0';
      end if;
      return ret;   
   end function;
   --***************************************************************************
   -- OX_PIPELINED_MUX_NOF_STAGE_CALC: returns the number of pipeline stage
   --*************************************************************************** 
   function ox_pipelined_mux_nof_calc(nof_selection: integer) return integer is  
      variable k: integer;
      variable ret: integer;
   begin
      ret := 0;
      k := nof_selection;
      while k >= 4 loop
         k := k / 4;
         ret := ret + 1;
      end loop;
      if ret = 0 then
         ret := 1;
      end if;
      return ret;
   end function;
end package body;     


