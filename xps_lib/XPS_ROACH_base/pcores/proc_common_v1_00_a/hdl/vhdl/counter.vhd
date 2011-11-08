-------------------------------------------------------------------------------
-- Counter - entity/architecture pair
-------------------------------------------------------------------------------
--
--                  ****************************
--                  ** Copyright Xilinx, Inc. **
--                  ** All rights reserved.   **
--                  ****************************
--
-------------------------------------------------------------------------------
-- Filename:        counter.vhd
--
-- Description:     Implements a parameterizable N-bit counter
--                      Up/Down Counter
--                      Count Enable
--                      Parallel Load
--                      Synchronous Reset
--                      1 - LUT per bit plus 3 LUTS for extra features
--
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:
--                  counter.vhd
--                      counter_bit.vhd
--
-------------------------------------------------------------------------------
-- Author:          Kurt Conover
-- History:
--   KC           2002-01-23    First Version
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
library proc_common_v1_00_a;
use proc_common_v1_00_a.counter_bit;

-----------------------------------------------------------------------------
-- Entity section
-----------------------------------------------------------------------------

entity Counter is
   generic(
            C_NUM_BITS : Integer := 9
          );

  port (
    Clk           : in  std_logic;
    Rst           : in  std_logic;
    Load_In       : in  std_logic_vector(C_NUM_BITS - 1 downto 0);
    Count_Enable  : in  std_logic;
    Count_Load    : in  std_logic;
    Count_Down    : in  std_logic;
    Count_Out     : out std_logic_vector(C_NUM_BITS - 1 downto 0);
    Carry_Out     : out std_logic
    );
end entity Counter;

-----------------------------------------------------------------------------
-- Architecture section
-----------------------------------------------------------------------------

architecture imp of Counter is

  signal alu_cy            : std_logic_vector(C_NUM_BITS downto 0);
  signal iCount_Out        : std_logic_vector(C_NUM_BITS - 1 downto 0);
  signal count_clock_en    : std_logic;
  signal carry_active_high : std_logic;

begin  -- VHDL_RTL

  -----------------------------------------------------------------------------
  -- Generate the Counter bits
  -----------------------------------------------------------------------------
  alu_cy(0) <= (Count_Down and Count_Load) or
               (not Count_Down and not Count_load);
  count_clock_en <= Count_Enable or Count_Load;

  I_ADDSUB_GEN : for I in 0 to (C_NUM_BITS - 1) generate
  begin
    Counter_Bit_I : entity proc_common_v1_00_a.counter_bit
      port map (
        Clk           => Clk,                      -- [in]
        Rst           => Rst,                      -- [in]
        Count_In      => iCount_Out(i),            -- [in]
        Load_In       => Load_In(i),               -- [in]
        Count_Load    => Count_Load,               -- [in]
        Count_Down    => Count_Down,               -- [in]
        Carry_In      => alu_cy(I),                -- [in]
        Clock_Enable  => count_clock_en,           -- [in]
        Result        => iCount_Out(I),            -- [out]
        Carry_Out     => alu_cy(I+1)               -- [out]
              );
  end generate I_ADDSUB_GEN;

  carry_active_high <= alu_cy(C_NUM_BITS) xor Count_Down;

  CARRY_OUT_I: FDRE
    port map (
      Q  => Carry_Out,                             -- [out]
      C  => Clk,                                   -- [in]
      CE => count_clock_en,                        -- [in]
      D  => carry_active_high,                     -- [in]
      R  => Rst                                    -- [in]
    );

  Count_Out <= iCount_Out;


end architecture imp;

