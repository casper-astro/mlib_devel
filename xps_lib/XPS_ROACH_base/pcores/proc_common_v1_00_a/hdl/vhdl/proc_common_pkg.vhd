-------------------------------------------------------------------------------
-- $Id: proc_common_pkg.vhd,v 1.1 2001/09/28 22:11:15 anitas Exp $
-------------------------------------------------------------------------------
-- Processor Common Library Package
-------------------------------------------------------------------------------
--
--                  ****************************
--                  ** Copyright Xilinx, Inc. **
--                  ** All rights reserved.   **
--                  ****************************
--
-------------------------------------------------------------------------------
-- Filename:        proc_common_pkg.vhd
-- Version:         v1.21b
-- Description:     This file contains the constants and functions used in the 
--                  processor common library components.
--
-------------------------------------------------------------------------------
-- Structure:       
--
-------------------------------------------------------------------------------
-- Author:      ALS
-- History:
--  ALS         09/12/01      -- Created from opb_arb_pkg.vhd
--
--  ALS         09/21/01        
-- ^^^^^^
--  Added pwr function. Replaced log2 function with one that works for XST.
-- ~~~~~~
-------------------------------------------------------------------------------
-- Naming Conventions:
--      active low signals:                     "*_n"
--      clock signals:                          "clk", "clk_div#", "clk_#x" 
--      reset signals:                          "rst", "rst_n" 
--      generics:                               "C_*" 
--      user defined types:                     "*_TYPE" 
--      state machine next state:               "*_ns" 
--      state machine current state:            "*_cs" 
--      combinatorial signals:                  "*_com" 
--      pipelined or register delay signals:    "*_d#" 
--      counter signals:                        "*cnt*"
--      clock enable signals:                   "*_ce" 
--      internal version of output port         "*_i"
--      device pins:                            "*_pin" 
--      ports:                                  - Names begin with Uppercase 
--      processes:                              "*_PROCESS" 
--      component instantiations:               "<ENTITY_>I_<#|FUNC>
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
-- need conversion function to convert reals/integers to std logic vectors
use ieee.std_logic_arith.conv_std_logic_vector;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


package proc_common_pkg is

-------------------------------------------------------------------------------
-- Type Declarations
-------------------------------------------------------------------------------
type TARGET_FAMILY_TYPE is (VIRTEX, VIRTEXII);
type CHAR_TO_INT_TYPE is array (character) of integer;

-------------------------------------------------------------------------------
-- Function and Procedure Declarations
-------------------------------------------------------------------------------
function pad_power2 ( in_num : integer )  return integer;
function pad_4 ( in_num : integer )  return integer;
function log2(x : natural) return integer;
function pwr(x: integer; y: integer) return integer;
function Get_RLOC_Name (Target : TARGET_FAMILY_TYPE;
                          Y      : integer;
                          X      : integer) return string;
function Get_Reg_File_Area (Target : TARGET_FAMILY_TYPE) return natural;
function String_To_Int(S : string) return integer;
function itoa (int : integer) return string;
                          
-------------------------------------------------------------------------------
-- Constant Declarations
-------------------------------------------------------------------------------
-- the RESET_ACTIVE constant should denote the logic level of an active reset
constant RESET_ACTIVE       : std_logic         := '1'; 

-- table containing strings representing hex characters for conversion to
-- integers
constant STRHEX_TO_INT_TABLE : CHAR_TO_INT_TYPE :=
    ('0'     => 0,
     '1'     => 1,
     '2'     => 2,
     '3'     => 3,
     '4'     => 4,
     '5'     => 5,
     '6'     => 6,
     '7'     => 7,
     '8'     => 8,
     '9'     => 9,
     'A'|'a' => 10,
     'B'|'b' => 11,
     'C'|'c' => 12,
     'D'|'d' => 13,
     'E'|'e' => 14,
     'F'|'f' => 15,
     others  => -1);

 
end proc_common_pkg;

package body proc_common_pkg is
-------------------------------------------------------------------------------
-- Function Definitions
-------------------------------------------------------------------------------
-- Function pad_power2
--
-- This function returns the next power of 2 from the input number. If the 
-- input number is a power of 2, this function returns the input number.
--
-- This function is used to round up the number of masters to the next power
-- of 2 if the number of masters is not already a power of 2
-------------------------------------------------------------------------------
-- 
function pad_power2 (in_num : integer  ) return integer is

variable i          : integer := 0;
variable out_num    : integer;

begin
    if in_num = 0 then
        out_num := 0;
    else
        while 2**i < in_num loop
            i := i+1;
        end loop;
        
        out_num := 2**i;
    end if;
    
    return out_num;
end pad_power2;


-------------------------------------------------------------------------------
-- Function pad_4
--
-- This function returns the next multiple of 4 from the input number. If the 
-- input number is a multiple of 4, this function returns the input number.
--
-------------------------------------------------------------------------------
-- 
function pad_4 (in_num : integer  ) return integer is

variable out_num     : integer;

begin
    out_num := (((in_num-1)/4) + 1)*4;
    return out_num;
    
end pad_4;

-------------------------------------------------------------------------------
-- Function log2 -- returns number of bits needed to encode x choices
--   x = 0  returns 0
--   x = 1  returns 0
--   x = 2  returns 1
--   x = 4  returns 2, etc.
-------------------------------------------------------------------------------
--
function log2(x : natural) return integer is
  variable i  : integer := 0; 
  variable val: integer := 1;
begin 
  if x = 0 then return 0;
  else
    for j in 0 to 8 loop -- for loop for XST 
      if val >= x then null; 
      else
        i := i+1;
        val := val*2;
      end if;
    end loop;
    return i;
  end if;  
end function log2; 

-------------------------------------------------------------------------------
-- Function pwr -- x**y
-- negative numbers not allowed for y
-------------------------------------------------------------------------------

function pwr(x: integer; y: integer) return integer is
  variable z : integer := 1;
begin
  if y = 0 then return 1; 
  else
    for i in 1 to y loop
      z := z * x;
    end loop;
    return z;
  end if;
end function pwr;

-------------------------------------------------------------------------------
-- Function itoa
-- 
-- The itoa function converts an integer to a text string.
-- This function is required since `image doesn't work in Synplicity
-- Valid input range is -9999 to 9999
-------------------------------------------------------------------------------
--  
  function itoa (int : integer) return string is
    type table is array (0 to 9) of string (1 to 1);
    constant LUT     : table :=
      ("0", "1", "2", "3", "4", "5", "6", "7", "8", "9");
    variable str1            : string(1 to 1);
    variable str2            : string(1 to 2);
    variable str3            : string(1 to 3);
    variable str4            : string(1 to 4);
    variable str5            : string(1 to 5);
    variable abs_int         : natural;
    
    variable thousands_place : natural;
    variable hundreds_place  : natural;
    variable tens_place      : natural;
    variable ones_place      : natural;
    variable sign            : integer;
    
  begin
    abs_int := abs(int);
    if abs_int > int then sign := -1;
    else sign := 1;
    end if;
    thousands_place :=  abs_int/1000;
    hundreds_place :=  (abs_int-thousands_place*1000)/100;
    tens_place :=      (abs_int-thousands_place*1000-hundreds_place*100)/10;
    ones_place :=      
      (abs_int-thousands_place*1000-hundreds_place*100-tens_place*10);
    
    if sign>0 then
      if thousands_place>0 then
        str4 := LUT(thousands_place) & LUT(hundreds_place) & LUT(tens_place) &
                LUT(ones_place);
        return str4;
      elsif hundreds_place>0 then 
        str3 := LUT(hundreds_place) & LUT(tens_place) & LUT(ones_place);
        return str3;
      elsif tens_place>0 then
        str2 := LUT(tens_place) & LUT(ones_place);
        return str2;
      else
        str1 := LUT(ones_place);
        return str1;
      end if;
    else
      if thousands_place>0 then
        str5 := "-" & LUT(thousands_place) & LUT(hundreds_place) & 
          LUT(tens_place) & LUT(ones_place);
        return str5;
      elsif hundreds_place>0 then 
        str4 := "-" & LUT(hundreds_place) & LUT(tens_place) & LUT(ones_place);
        return str4;
      elsif tens_place>0 then
        str3 := "-" & LUT(tens_place) & LUT(ones_place);
        return str3;
      else
        str2 := "-" & LUT(ones_place);
        return str2;
      end if;
    end if;  
  end itoa; 
  
  
-------------------------------------------------------------------------------
-- Function Get_RLOC_Name
-- 
-- This function calculates the proper RLOC value based on the FPGA target
-- family.
-------------------------------------------------------------------------------
--  

  function Get_RLOC_Name (Target : TARGET_FAMILY_TYPE;
                          Y      : integer;
                          X      : integer) return string is
    variable Col : integer;
    variable Row : integer;
    variable S : integer;
  begin
    if Target = VIRTEX then
      Row := -Y;
      Col := X/2;
      S   := 1 - (X mod 2);
      return 'R' & itoa(Row) &
             'C' & itoa(Col) &
             ".S" & itoa(S);
    elsif Target = VIRTEXII then
      return 'X' & itoa(X) & 'Y' & itoa(Y);
    end if;
  end Get_RLOC_Name;

-------------------------------------------------------------------------------
-- Function Get_Reg_File_Area
-- 
-- This function returns the number of slices in x that each bit of the 
-- Register_File occupies
-------------------------------------------------------------------------------
  function Get_Reg_File_Area (Target : TARGET_FAMILY_TYPE) return natural is
  begin  -- function Get_Y_Area
    if Target = VIRTEX then
      return 6;
    elsif target = VIRTEXII then
      return 4;
    end if;
  end function Get_Reg_File_Area;


-----------------------------------------------------------------------------
-- Function String_To_Int
--
-- Converts a string of hex character to an integer
-- accept negative numbers
-----------------------------------------------------------------------------
  function String_To_Int(S : String) return Integer is
    variable Result : integer := 0;
    variable Temp   : integer := S'Left;
    variable Negative : integer := 1;
  begin
    for I in S'Left to S'Right loop
      -- ASCII value - 42 TBD
      if (S(I) = '-') then
        Temp     := 0;
        Negative := -1;
      else
        Temp := STRHEX_TO_INT_TABLE(S(I));
        if (Temp = -1) then
          assert false
            report "Wrong value in String_To_Int conversion " & S(I)
            severity error;
        end if;
      end if;
      Result := Result * 16 + Temp;
    end loop;
    return (Negative * Result);
  end String_To_Int;

end package body proc_common_pkg;
