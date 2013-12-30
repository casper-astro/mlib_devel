-------------------------------------------------------------------------------
-- $Id: pf_counter.vhd,v 1.2 2004/11/23 01:17:43 jcanaris Exp $
-------------------------------------------------------------------------------
-- pf_counter - entity/architecture pair
-------------------------------------------------------------------------------
--
--                  ****************************
--                  ** Copyright Xilinx, Inc. **
--                  ** All rights reserved.   **
--                  ****************************
--
-------------------------------------------------------------------------------
-- Filename:        pf_counter.vhd
--
-- Description:     Implements 32-bit timer/counter
--
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:
--                  pf_counter.vhd
--
-------------------------------------------------------------------------------
-- Author:          B.L. Tise
-- Revision:        $Revision: 1.2 $
-- Date:            $Date: 2004/11/23 01:17:43 $
--
-- History:
--   D. Thorpe      2001-08-30    First Version
--                  - adapted from B Tise MicroBlaze counters
--
--  DET             2001-09-11
--                  - Added the Rst input to the pf_counter_bit component
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

library unisim;
use unisim.vcomponents.all;
library proc_common_v2_00_a;
use proc_common_v2_00_a.pf_counter_bit;

-----------------------------------------------------------------------------
-- Entity section
-----------------------------------------------------------------------------

entity pf_counter is
  generic (
    C_COUNT_WIDTH : integer := 9
    );
  port (
    Clk           : in  std_logic;
    Rst           : in  std_logic;
    Carry_Out     : out std_logic;
    Load_In       : in  std_logic_vector(0 to C_COUNT_WIDTH-1);
    Count_Enable  : in  std_logic;
    Count_Load    : in  std_logic;
    Count_Down    : in  std_logic;
    Count_Out     : out std_logic_vector(0 to C_COUNT_WIDTH-1)
    );
end entity pf_counter;

-----------------------------------------------------------------------------
-- Architecture section
-----------------------------------------------------------------------------

architecture implementation of pf_counter is

  constant CY_START : integer := 1;


  signal alu_cy            : std_logic_vector(0 to C_COUNT_WIDTH);
  signal iCount_Out        : std_logic_vector(0 to C_COUNT_WIDTH-1);
  signal count_clock_en    : std_logic;
  signal carry_active_high : std_logic;



begin  -- VHDL_RTL

  -----------------------------------------------------------------------------
  -- Generate the Counter bits
  -----------------------------------------------------------------------------
  alu_cy(C_COUNT_WIDTH) <= (Count_Down and Count_Load) or
                           (not Count_Down and not Count_load);

  count_clock_en <= Count_Enable or Count_Load;


  I_ADDSUB_GEN : for i in 0 to C_COUNT_WIDTH-1 generate
  begin
    Counter_Bit_I : entity proc_common_v2_00_a.pf_counter_bit
      port map (
        Clk           => Clk,                      -- [in]
        Rst           => Rst,                      -- [in]
        Count_In      => iCount_Out(i),            -- [in]
        Load_In       => Load_In(i),               -- [in]
        Count_Load    => Count_Load,               -- [in]
        Count_Down    => Count_Down,               -- [in]
        Carry_In      => alu_cy(i+CY_Start),       -- [in]
        Clock_Enable  => count_clock_en,           -- [in]
        Result        => iCount_Out(i),            -- [out]
        Carry_Out     => alu_cy(i+(1-CY_Start)));  -- [out]
  end generate I_ADDSUB_GEN;




  carry_active_high <= alu_cy(0) xor Count_Down;



  I_CARRY_OUT: FDRE
    port map (
      Q  => Carry_Out,                             -- [out]
      C  => Clk,                                   -- [in]
      CE => count_clock_en,                        -- [in]
      D  => carry_active_high,                     -- [in]
      R  => Rst                                    -- [in]
    );

  Count_Out <= iCount_Out;



end architecture implementation;

