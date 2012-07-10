-------------------------------------------------------------------------------
-- $Id: opb_arb_pkg.vhd,v 1.1 2004/11/05 11:20:51 bommanas Exp $
-------------------------------------------------------------------------------
-- opb_arb_pkg.vhd - Package
-------------------------------------------------------------------------------
--
--  ***************************************************************************
--  **  Copyright(C) 2003 by Xilinx, Inc. All rights reserved.               **
--  **                                                                       **
--  **  This text contains proprietary, confidential                         **
--  **  information of Xilinx, Inc. , is distributed by                      **
--  **  under license from Xilinx, Inc., and may be used,                    **
--  **  copied and/or disclosed only pursuant to the terms                   **
--  **  of a valid license agreement with Xilinx, Inc.                       **
--  **                                                                       **
--  **  Unmodified source code is guaranteed to place and route,             **
--  **  function and run at speed according to the datasheet                 **
--  **  specification. Source code is provided "as-is", with no              **
--  **  obligation on the part of Xilinx to provide support.                 **
--  **                                                                       **
--  **  Xilinx Hotline support of source code IP shall only include          **
--  **  standard level Xilinx Hotline support, and will only address         **
--  **  issues and questions related to the standard released Netlist        **
--  **  version of the core (and thus indirectly, the original core source). **
--  **                                                                       **
--  **  The Xilinx Support Hotline does not have access to source            **
--  **  code and therefore cannot answer specific questions related          **
--  **  to source HDL. The Xilinx Support Hotline will only be able          **
--  **  to confirm the problem in the Netlist version of the core.           **
--  **                                                                       **
--  **  This copyright and support notice must be retained as part           **
--  **  of this text at all times.                                           **
--  ***************************************************************************
--
-------------------------------------------------------------------------------
-- Filename:        opb_arb_pkg.vhd
-- Version:         v1.02e
-- Description:     This file contains the constants used in the design of the
--                  OPB bus arbiter.
--
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:       This is a global file used throughout the hierarchy of the
--                  OPB bus arbiter design
--
-------------------------------------------------------------------------------
-- Author:      ALS
-- History:
--  ALS         08/28/01        -- Version 1.01a creation to include IPIF v1.22a
--  ALS         10/04/01        -- Version 1.02a creation to include IPIF v1.23a
--  ALS         10/12/01        
-- ^^^^^^
--  Added Addr_bits function and constant IPIF_ABUS_WIDTH.
-- ~~~~~~
--  ALS         10/16/01
-- ^^^^^^
--  Modified Addr_Bits function to pass in the size of the address bus.
-- ~~~~~~
--  ALS         10/17/01
-- ^^^^^^
--  Added MAX2 function which returns the greater of two numbers.
-- ~~~~~~
--  ALS         11/27/01
-- ^^^^^^
--  Version 1.02b created to fix registered grant problem.
-- ~~~~~~
--  ALS         01/26/02
-- ^^^^^^
--  Created version 1.02c to fix problem with registered grants, and buslock when
--  the buslock master is holding request high and performing conversion cycles.
-- ~~~~~~
--  ALS         01/09/03
-- ^^^^^^
--  Created version 1.02d to register OPB_timeout to improve timing
-- ~~~~~~
--  bsbrao      09/27/04
-- ^^^^^^
--  Created version 1.02e to upgrade IPIF from opb_ipif_v1_23_a to 
--  opb_ipif_v3_01_a 
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


package opb_arb_pkg is

-------------------------------------------------------------------------------
-- Type Declarations
-------------------------------------------------------------------------------
type TARGET_FAMILY_TYPE is (VIRTEX, VIRTEXII);
type CHAR_TO_INT_TYPE is array (character) of integer;

-------------------------------------------------------------------------------
-- Function and Procedure Declarations
-------------------------------------------------------------------------------
function max2 (num1, num2 : integer) return integer;
function Addr_Bits (x,y : std_logic_vector; addr_width : integer) return integer;
function pad_power2 ( in_num : integer )  return integer;
function pad_4 ( in_num : integer )  return integer;
function log2(x : natural) return integer;
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

-- set the size of the IPIF Address bus
-- since the register offset is 256 and each address range has to be a power
-- of two, the address range of the opb arbiter is 512, therefore the
-- IPIF address bus size is 9 bits.
constant IPIF_ABUS_WIDTH    : integer   := 9;

-- set control register bit locations
-- Note that the parked master ID is right justified in the register and the
-- size of this field varies with the number of masters and is therefore not
-- set in this package. CTRL_FIELD indicates the number of bits in the control
-- register that are left justified and don't vary with the number of masters
constant CTRL_FIELD     : integer       := 5;

constant DPEN_LOC       : integer       := 0;   -- dynamic priority enable
constant DPENRW_LOC     : integer       := 1;   -- dpe read/write
constant PEN_LOC        : integer       := 2;   -- park enable
constant PENRW_LOC      : integer       := 3;   -- pen read/write
constant PMN_LOC        : integer       := 4;   -- park on master not last
constant PRV_LOC        : integer       := 5;   -- priority registers valid



-- number of clock cycles after OPB_select asserts before arbiter times out if
-- OPB_xferAck or OPB_retry are not asserted
constant OPB_TIMEOUT_CNT    : integer       := 16;

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

 
end opb_arb_pkg;

package body opb_arb_pkg is
-------------------------------------------------------------------------------
-- Function Definitions
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Function max2
--
-- This function returns the greater of two numbers.
-------------------------------------------------------------------------------
function max2 (num1, num2 : integer) return integer is
begin
    if num1 >= num2 then
        return num1;
    else
        return num2;
    end if;
end function max2;
-------------------------------------------------------------------------------
-- Function Addr_bits
--
-- This function converts an address range (base address and an upper address)
-- into the number of upper address bits needed for decoding a device
-- select signal
-------------------------------------------------------------------------------
function Addr_Bits (x,y : std_logic_vector; addr_width:integer)
 return integer is
  variable addr_nor : std_logic_vector(0 to addr_width-1);
begin
  addr_nor := x xor y;
  for i in 0 to addr_width-1
  loop
    if addr_nor(i) = '1' then return i;
    end if;
  end loop;
  return addr_width;
end function Addr_Bits;
-------------------------------------------------------------------------------
-- Function pad_power2
--
-- This function returns the next power of 2 from the input number. If the 
-- input number is a power of 2, this function returns the input number.
--
-- This function is used to round up the number of masters to the next power
-- of 2 if the number of masters is not already a power of 2
--
-- The for loop is a workaround for the bug in XST in which variables set in 
-- a loop with an exit statement can't be returned as a constant.
-------------------------------------------------------------------------------
-- 
function pad_power2 (in_num : integer  ) return integer is

variable out_num    : integer := 0;
variable val        : integer := 1;

begin
    if in_num = 0 then
        out_num := 0;
    else
        for j in 0 to 8 loop -- for loop for XST 
           if val >= in_num then null;
           else
             val := val*2;
           end if;
        end loop;        
        out_num := val;
    end if;
    return out_num;
end function pad_power2;


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
-- Function log2
-- 
-- The log2 function returns the number of bits required to encode x choices.
-- This function is used to determine the number of bits required to encode the
-- master IDs.
-------------------------------------------------------------------------------
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

end package body opb_arb_pkg;
