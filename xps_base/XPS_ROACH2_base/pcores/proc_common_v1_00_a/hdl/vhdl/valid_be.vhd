--SINGLE_FILE_TAG
-------------------------------------------------------------------------------
-- $Id: valid_be.vhd,v 1.1 2001/09/28 22:11:15 anitas Exp $
-------------------------------------------------------------------------------
-- valid_be - entity/architecture pair
-------------------------------------------------------------------------------
--
--                  ****************************
--                  ** Copyright Xilinx, Inc. **
--                  ** All rights reserved.   **
--                  ****************************
--
-------------------------------------------------------------------------------
-- Filename:        valid_be.vhd
-- Version:         v1.00a
-- Description:     Determines valid OPB access for memory devices
--
-------------------------------------------------------------------------------
-- Structure: 
--
--              valid_be.vhd
-------------------------------------------------------------------------------
-- Author:      BLT
-- History:
--  ALS         09/21/01     -- First version
-- ^^^^^^
--      First version of valid_be created from BLT's file, valid_access. Made
--      modifications to support a target data bus width and a host data bus
--      width.
-- ~~~~~~
--
-------------------------------------------------------------------------------
-- Naming Conventions:
--      active low signals:                     "*_n"
--      clock signals:                          "clk", "clk_div#", "clk_#x" 
--      reset signals:                          "rst", "rst_n" 
--      generics:                               "C_*" 
--      user defined types:                     "*_TYPE" 
--      state machine next state:               "*_ns" 
--      state machine current state:            "*_cs" 
--      combinatorial signals:                  "*_cmb" 
--      pipelined or register delay signals:    "*_d#" 
--      counter signals:                        "*cnt*"
--      clock enable signals:                   "*_ce" 
--      internal version of output port         "*_i"
--      device pins:                            "*_pin" 
--      ports:                                  - Names begin with Uppercase 
--      processes:                              "*_PROCESS" 
--      component instantiations:               "<ENTITY_>I_<#|FUNC>
-------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_signed.all;

library proc_common_v1_00_a;
use proc_common_v1_00_a.proc_common_pkg.all;

-------------------------------------------------------------------------------
-- Port declarations
-------------------------------------------------------------------------------

entity valid_be is
  generic (
    C_HOST_DW           : integer range 8 to 256 := 32;
    C_TARGET_DW         : integer range 8 to 32  := 32
    );   
  port (
    OPB_BE_Reg     : in  std_logic_vector(0 to C_HOST_DW/8-1);
    Valid          : out std_logic
    );
end entity valid_be;


architecture implementation of valid_be is

-------------------------------------------------------------------------------
-- Constant Declarations
-------------------------------------------------------------------------------
constant HOST_LOGVAL   : integer := log2(C_HOST_DW/8);  -- log value for host bus
constant TAR_LOGVAL    : integer := log2(C_TARGET_DW/8); -- log value for target bus

-------------------------------------------------------------------------------
-- Begin architecture
-------------------------------------------------------------------------------

begin

-------------------------------------------------------------------------------
-- VALID_ACCESS_PROCESS: this is a general purpose process that returns 
-- whether or not a particular byte enable code is valid for a particular host
-- bus size and target bus size. The byte enable bus can be up to 32 bits wide, 
-- supporting host bus widths up to 256 bits.
--
-- Example:
--  HOST BUS SIZE(OPB)  TARGET BUS SIZE (SRAM)  Valid BE
--  -----------------   ----------------------  --------
--      8                       8                   '1'
--      16                      8                   "01"
--                                                  "10"
--      16                      16                  "01"
--                                                  "10"
--                                                  "11"
--      32                      8                   "0001"
--                                                  "0010"
--                                                  "0100"
--                                                  "1000"
--      32                      16                  "0001"
--                                                  "0010"
--                                                  "0100"
--                                                  "1000"
--                                                  "0011"
--                                                  "1100"
--      32                      32                  "0001"
--                                                  "0010"
--                                                  "0100"
--                                                  "1000"
--                                                  "0011"
--                                                  "1100"
--                                                  "1111"
-------------------------------------------------------------------------------

VALID_ACCESS_PROCESS: process (OPB_BE_Reg) is
  variable compare_Val : integer := 0;
begin
  Valid <= '0';
  for i in 0 to TAR_LOGVAL loop         -- loop for bits in target data bus
    compare_Val := pwr(2,pwr(2,i))-1;
    for j in 0 to pwr(2,HOST_LOGVAL-i) loop
      if Conv_integer('0' & OPB_BE_Reg) = compare_Val then Valid <= '1'; end if;
      compare_Val := compare_Val*pwr(2,pwr(2,i));
    end loop;
  end loop;
end process VALID_ACCESS_PROCESS;

end architecture implementation;