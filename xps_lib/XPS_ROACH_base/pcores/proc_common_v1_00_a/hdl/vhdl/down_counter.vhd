-------------------------------------------------------------------------------
-- $Id: down_counter.vhd,v 1.2 2001/10/26 19:54:41 anitas Exp $
------------------------------------------------------------------------------
-- PLB Arbiter
-------------------------------------------------------------------------------
-- 
--                  ****************************
--                  ** Copyright Xilinx, Inc. **
--                  ** All rights reserved.   **
--                  ****************************
-- 
------------------------------------------------------------------------------
-- Filename:        down_counter.vhd
-- 
-- Description:     Parameterizable down counter with synchronous load and 
--                  reset.
-- 
-------------------------------------------------------------------------------
-- Structure:   
--      Multi-use module
-------------------------------------------------------------------------------
-- Author:      ALS
-- History:
--  ALS         04/10/01        -- First version
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
library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.STD_LOGIC_ARITH.all;

-- PROC_COMMON_PKG contains the RESET_ACTIVE constant
library proc_common_v1_00_a;
use proc_common_v1_00_a.proc_common_pkg.all;


-------------------------------------------------------------------------------
-- Port Declaration
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Definition of Generics:
--      C_CNT_WIDTH                 -- counter width
--
-- Definition of Ports:
--      input Din                   -- data to be loaded into counter
--      input Load                  -- load control signal
--      input Cnt_en                -- count enable signal
--      input Clk                     
--      input Rst
--
--      output Cnt_out              -- counter output
-------------------------------------------------------------------------------

entity down_counter is
  generic (
           --  Select width of counter
           C_CNT_WIDTH : INTEGER := 4
           );
  port (
        Din     : in std_logic_vector(0 to C_CNT_WIDTH-1);
        Load    : in std_logic;
        Cnt_en  : in std_logic;  
        Cnt_out : out std_logic_vector(0 to C_CNT_WIDTH - 1 );
        
        Clk     : in std_logic;
        Rst     : in std_logic
        );
 
end down_counter;

architecture simulation of down_counter is

-------------------------------------------------------------------------------
-- Signal Declarations
-------------------------------------------------------------------------------
-- internal count
signal cnt : unsigned(0 to C_CNT_WIDTH - 1 );
 
 
begin

-------------------------------------------------------------------------------
-- COUNTER_PROCESS process
-------------------------------------------------------------------------------
COUNTER_PROCESS:process (Clk, Rst, Cnt_en, cnt)
begin  
  if Clk'event and Clk = '1' then
    if Rst = RESET_ACTIVE then
      cnt <= (others => '0');
    elsif Load = '1' then
      cnt <= unsigned(Din);
    elsif Cnt_en = '1' then
      cnt <= cnt - 1;
    else
      cnt <= cnt;
    end if;
  end if;
end process COUNTER_PROCESS;


CNTOUT_PROCESS:process (cnt)
begin  
  Cnt_out <= conv_std_logic_vector(cnt, C_CNT_WIDTH);
end process CNTOUT_PROCESS;
            
end simulation;
