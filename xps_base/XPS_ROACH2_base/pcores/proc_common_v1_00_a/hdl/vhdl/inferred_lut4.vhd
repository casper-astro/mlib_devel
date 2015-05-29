-------------------------------------------------------------------------------
-- $Id: inferred_lut4.vhd,v 1.1 2001/11/05 23:17:03 dougt Exp $
-------------------------------------------------------------------------------
--  inferred_lut4.vhd
-------------------------------------------------------------------------------
--
--                  ****************************
--                  ** Copyright Xilinx, Inc. **
--                  ** All rights reserved.   **
--                  ****************************
--
-------------------------------------------------------------------------------
-- Filename:        inferred_lut4.vhd
--
-- Description:     This module is used to infer a LUT4 instantiation in 
--                  structural VHDL. It is compatable with Synplicity and xst
--                  synthesis tools.
--                  
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:   
--               inferred_lut4.vhd
--
-------------------------------------------------------------------------------
-- Author:          D.Thorpe
--
-- History:
--   DET  2001-10-11   LUT4 implementation to work around xst lut4 problem with
--                     INIT generic. Adapted from XST France work-around
--                     solution sent to Bert Tise.
--
-------------------------------------------------------------------------------
-- Naming Conventions:
--      active low signals:                     "*_n"
--      clock signals:                          "Bus_clk", "Bus_clk_div#", "Bus_clk_#x" 
--      Bus_rst signals:                          "rst", "rst_n" 
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

library ieee;
use ieee.std_logic_arith.all;

library ieee;
use ieee.std_logic_unsigned.all;

------------------------------------------------------------------------------- 
 

  entity inferred_lut4 is 
   generic (INIT : bit_vector(15 downto 0)); 
   port ( 
     O : out std_logic; 
     I0 : in std_logic; 
     I1 : in std_logic; 
     I2 : in std_logic; 
     I3 : in std_logic 
   ); 
  end entity inferred_lut4; 

-------------------------------------------------------------------------------
  
  architecture implementation of inferred_lut4 is 
  
  
  signal b : std_logic_vector(3 downto 0); 
  signal tmp : integer range 0 to 15; 
  
  
  
  
  begin 
      
      b <= (I3, I2, I1, I0); 
      tmp <= conv_integer(b); 
      O <= To_StdUlogic(INIT(tmp)); 
  
  
  
  end architecture implementation; 
 
 
