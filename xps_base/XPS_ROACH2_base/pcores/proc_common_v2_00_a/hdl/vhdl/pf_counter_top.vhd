-------------------------------------------------------------------------------
-- $Id: pf_counter_top.vhd,v 1.2 2004/11/23 01:17:43 jcanaris Exp $
-------------------------------------------------------------------------------
-- pf_counter_top - entity/architecture pair
-------------------------------------------------------------------------------
--
--                  ****************************
--                  ** Copyright Xilinx, Inc. **
--                  ** All rights reserved.   **
--                  ****************************
--
-------------------------------------------------------------------------------
-- Filename:        pf_counter_top.vhd
--
-- Description:     Implements parameterized up/down counter
--
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:
--                  pf_counter_top.vhd
--
-------------------------------------------------------------------------------
-- Author:          D. Thorpe
-- Revision:        $Revision: 1.2 $
-- Date:            $Date: 2004/11/23 01:17:43 $
--
-- History:
--   DET            2001-08-30    First Version
--
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
--Use IEEE.numeric_std.all;

library unisim;
use unisim.vcomponents.all;
library proc_common_v2_00_a;
use proc_common_v2_00_a.pf_counter;

-----------------------------------------------------------------------------
-- Entity section
-----------------------------------------------------------------------------

entity pf_counter_top is
  generic (
    C_COUNT_WIDTH : integer := 10
    );
  port (
    Clk           : in  std_logic;
    Rst           : in  std_logic;
    Load_Enable   : in  std_logic;
    Load_value    : in  std_logic_vector(0 to C_COUNT_WIDTH-1);
    Count_Down    : in  std_logic;
    Count_Up      : in  std_logic;
    --Carry_Out     : out std_logic;
    Count_Out     : out std_logic_vector(0 to C_COUNT_WIDTH-1)
    );
end entity pf_counter_top;

-----------------------------------------------------------------------------
-- Architecture section
-----------------------------------------------------------------------------

architecture implementation of pf_counter_top is


 Signal  sig_cnt_enable   : std_logic;
 Signal  sig_cnt_up_n_dwn : std_logic;
 Signal  sig_carry_out    : std_logic;
 Signal  sig_count_out    : std_logic_vector(0 to C_COUNT_WIDTH-1);




begin  -- VHDL_RTL



 -- Misc signal assignments
  Count_Out        <= sig_count_out;
  --Carry_Out        <= sig_carry_Out;

  sig_cnt_enable   <=  Count_Up xor Count_Down;
  sig_cnt_up_n_dwn <=  not(Count_Up);





  I_UP_DWN_COUNTER : entity proc_common_v2_00_a.pf_counter

    generic map (
      C_COUNT_WIDTH => C_COUNT_WIDTH
      )
    port map(
      Clk           =>  Clk,             -- : in  std_logic;
      Rst           =>  Rst,             -- : in  std_logic;
      Carry_Out     =>  sig_carry_out,   -- : out std_logic;
      Load_In       =>  Load_value,      -- : in  std_logic_vector(0 to C_COUNT_WIDTH-1);
      Count_Enable  =>  sig_cnt_enable,  -- : in  std_logic;
      Count_Load    =>  Load_Enable,     -- : in  std_logic;
      Count_Down    =>  sig_cnt_up_n_dwn,-- : in  std_logic;
      Count_Out     =>  sig_count_out    -- : out std_logic_vector(0 to C_COUNT_WIDTH-1)
      );



end architecture implementation;

