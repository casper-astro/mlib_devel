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
-- This package contains wrapper functions for using UNSIGNED arithmetic 
-- and relational operators on STD_LOGIC_VECTOR types with ieee.numeric_std package 
-- without requiring types conversions.
-- NOTE: UNSIGNED ARITHEMTIC ONLY!
--!d
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package ox_unsigned_functions_pkg is

   function conv_uint(slv: std_logic_vector) return integer;
   
   function "+" (L: std_logic_vector; R: natural) return std_logic_vector;
   function "+" (L: natural; R: std_logic_vector) return std_logic_vector;
   function "+" (L: std_logic_vector; R: std_logic_vector) return std_logic_vector;
   
   function "-" (L: std_logic_vector; R: natural) return std_logic_vector;
   function "-" (L: natural; R: std_logic_vector) return std_logic_vector;
   function "-" (L: std_logic_vector; R: std_logic_vector) return std_logic_vector;
   
   function "*" (L: std_logic_vector; R: natural) return std_logic_vector;
   function "*" (L: natural; R: std_logic_vector) return std_logic_vector;
   function "*" (L: std_logic_vector; R: std_logic_vector) return std_logic_vector;
   
   function "=" (L: std_logic_vector; R: natural) return boolean;
   function "=" (L: natural; R: std_logic_vector) return boolean;
   function "=" (L: std_logic_vector; R: std_logic_vector) return boolean;
   
   function "/=" (L: std_logic_vector; R: natural) return boolean;
   function "/=" (L: natural; R: std_logic_vector) return boolean;
   function "/=" (L: std_logic_vector; R: std_logic_vector) return boolean;
   
   function ">=" (L: std_logic_vector; R: natural) return boolean;
   function ">=" (L: natural; R: std_logic_vector) return boolean;
   function ">=" (L: std_logic_vector; R: std_logic_vector) return boolean;
   
   function ">" (L: std_logic_vector; R: natural) return boolean;
   function ">" (L: natural; R: std_logic_vector) return boolean;
   function ">" (L: std_logic_vector; R: std_logic_vector) return boolean;
   
   function "<=" (L: std_logic_vector; R: natural) return boolean;
   function "<=" (L: natural; R: std_logic_vector) return boolean;
   function "<=" (L: std_logic_vector; R: std_logic_vector) return boolean;
   
   function "<" (L: std_logic_vector; R: natural) return boolean;
   function "<" (L: natural; R: std_logic_vector) return boolean;
   function "<" (L: std_logic_vector; R: std_logic_vector) return boolean;

end ox_unsigned_functions_pkg; 

package body ox_unsigned_functions_pkg is
   
   function conv_uint(slv: std_logic_vector) return integer is
   begin
      return to_integer(unsigned(slv));
   end function;
   
   function "+" (L: std_logic_vector; R: natural) return std_logic_vector is
   begin
      return std_logic_vector(unsigned(L) + R);
   end function;
   function "+" (L: natural; R: std_logic_vector) return std_logic_vector is
   begin
      return std_logic_vector(L + unsigned(R));
   end function;
   function "+" (L: std_logic_vector; R: std_logic_vector) return std_logic_vector is
   begin
      return std_logic_vector(unsigned(L) + unsigned(R));
   end function;
   --
   --
   --
   function "-" (L: std_logic_vector; R: natural) return std_logic_vector is
   begin
      return std_logic_vector(unsigned(L) - R);
   end function;
   function "-" (L: natural; R: std_logic_vector) return std_logic_vector is
   begin
      return std_logic_vector(L - unsigned(R));
   end function;
   function "-" (L: std_logic_vector; R: std_logic_vector) return std_logic_vector is
   begin
      return std_logic_vector(unsigned(L) - unsigned(R));
   end function;
   --
   --
   --
   function "*" (L: std_logic_vector; R: natural) return std_logic_vector is
   begin
      return std_logic_vector(unsigned(L) * R);
   end function;
   function "*" (L: natural; R: std_logic_vector) return std_logic_vector is
   begin
      return std_logic_vector(L * unsigned(R));
   end function;
   function "*" (L: std_logic_vector; R: std_logic_vector) return std_logic_vector is
   begin
      return std_logic_vector(unsigned(L) * unsigned(R));
   end function;
   --
   --
   --
   function "=" (L: std_logic_vector; R: natural) return boolean is
   begin
      return (unsigned(L) = R);
   end function;
   function "=" (L: natural; R: std_logic_vector) return boolean is
   begin
      return (L = unsigned(R));
   end function;
   function "=" (L: std_logic_vector; R: std_logic_vector) return boolean is
   begin
      return (unsigned(L) = unsigned(R));
   end function;
   --
   --
   --
   function "/=" (L: std_logic_vector; R: natural) return boolean is
   begin
      return (unsigned(L) /= R);
   end function;
   function "/=" (L: natural; R: std_logic_vector) return boolean is
   begin
      return (L /= unsigned(R));
   end function;
   function "/=" (L: std_logic_vector; R: std_logic_vector) return boolean is
   begin
      return (unsigned(L) /= unsigned(R));
   end function;
   --
   --
   --
   function ">=" (L: std_logic_vector; R: natural) return boolean is
   begin
      return (unsigned(L) >= R);
   end function;
   function ">=" (L: natural; R: std_logic_vector) return boolean is
   begin
      return (L >= unsigned(R));
   end function;
   function ">=" (L: std_logic_vector; R: std_logic_vector) return boolean is
   begin
      return (unsigned(L) >= unsigned(R));
   end function;
   --
   --
   --
   function ">" (L: std_logic_vector; R: natural) return boolean is
   begin
      return (unsigned(L) > R);
   end function;
   function ">" (L: natural; R: std_logic_vector) return boolean is
   begin
      return (L > unsigned(R));
   end function;
   function ">" (L: std_logic_vector; R: std_logic_vector) return boolean is
   begin
      return (unsigned(L) > unsigned(R));
   end function;
   --
   --
   --
   function "<=" (L: std_logic_vector; R: natural) return boolean is
   begin
      return (unsigned(L) <= R);
   end function;
   function "<=" (L: natural; R: std_logic_vector) return boolean is
   begin
      return (L <= unsigned(R));
   end function;
   function "<=" (L: std_logic_vector; R: std_logic_vector) return boolean is
   begin
      return (unsigned(L) <= unsigned(R));
   end function;
   --
   --
   --
   function "<" (L: std_logic_vector; R: natural) return boolean is
   begin
      return (unsigned(L) < R);
   end function;
   function "<" (L: natural; R: std_logic_vector) return boolean is
   begin
      return (L < unsigned(R));
   end function;
   function "<" (L: std_logic_vector; R: std_logic_vector) return boolean is
   begin
      return (unsigned(L) < unsigned(R));
   end function;

end package body;


