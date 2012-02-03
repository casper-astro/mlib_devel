-------------------------------------------------------------------------------
-- counter_bit_imp.vhd - entity/architecture pair
-------------------------------------------------------------------------------
--
--                  ****************************
--                  ** Copyright Xilinx, Inc. **
--                  ** All rights reserved.   **
--                  ****************************
--
-------------------------------------------------------------------------------
-- Filename:        counter_bit.vhd
--
-- Description:     Implements 1 bit of the counter/timer
--                  
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:   
--                  counter_bit.vhd
--
-------------------------------------------------------------------------------
-- Author:          B.L. Tise
-- Revision:        $Revision: 1.2 $
-- Date:            $Date: 2003/06/29 21:49:43 $
--
-- History:
--   tise           2001-04-04    First Version
--
--   KC             2002-01-23    Remove used generics and removed unused code
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
library IEEE;
use IEEE.std_logic_1164.all;
library Unisim;
use Unisim.all;

-----------------------------------------------------------------------------
-- Entity section
-----------------------------------------------------------------------------

entity counter_bit is
  
  port (
    Clk           : in  std_logic;
    Rst           : in  std_logic;
    Count_In      : in  std_logic;
    Load_In       : in  std_logic;
    Count_Load    : in  std_logic;
    Count_Down    : in  std_logic;
    Carry_In      : in  std_logic;
    Clock_Enable  : in  std_logic;
    Result        : out std_logic;
    Carry_Out     : out std_logic);

end entity counter_bit;

-----------------------------------------------------------------------------
-- Architecture section
-----------------------------------------------------------------------------

architecture imp of counter_bit is
  
  component LUT4 is
    generic(
      INIT : bit_vector := X"0000"
      );
    port (
      O  : out std_logic;
      I0 : in  std_logic;
      I1 : in  std_logic;
      I2 : in  std_logic;
      I3 : in  std_logic);
  end component LUT4;

  component MUXCY_L is
    port (
      DI : in  std_logic;
      CI : in  std_logic;
      S  : in  std_logic;
      LO : out std_logic);
  end component MUXCY_L;

  component XORCY is
    port (
      LI : in  std_logic;
      CI : in  std_logic;
      O  : out std_logic);
  end component XORCY;
  
  component FDRE is
    port (
      Q  : out std_logic;
      C  : in  std_logic;
      CE : in  std_logic;
      D  : in  std_logic;
      R  : in  std_logic
    );
  end component FDRE;
  
  signal    count_AddSub     : std_logic;
  signal    count_Result     : std_logic;
  signal    count_Result_Reg : std_logic;

  attribute INIT       : string;
  
begin  -- VHDL_RTL

  
  I_ALU_LUT : LUT4
    generic map(
      INIT => X"36C6"
      )
    port map (
      O  => count_AddSub,               -- [out]
      I0 => Count_In,                   -- [in]
      I1 => Count_Down,                 -- [in]
      I2 => Count_Load,                 -- [in]
      I3 => Load_In);                   -- [in]

  MUXCY_I : MUXCY_L
    port map (
      DI => Count_Down,
      CI => Carry_In,
      S  => count_AddSub,
      LO => Carry_Out);

  XOR_I : XORCY
    port map (
      LI => count_AddSub,
      CI => Carry_In,
      O  => count_Result);

  FDRE_I: FDRE
    port map (
      Q  => count_Result_Reg,           -- [out]
      C  => Clk,                        -- [in]
      CE => Clock_Enable,               -- [in]
      D  => count_Result,               -- [in]
      R  => Rst                         -- [in]
    );      

  Result <= count_Result_Reg;
        
end imp;

