-------------------------------------------------------------------------------
-- $Id: pf_adder.vhd,v 1.1 2004/04/01 23:19:18 dougt Exp $
-------------------------------------------------------------------------------
-- pf_adder - entity/architecture pair
-------------------------------------------------------------------------------
--
--                  ****************************
--                  ** Copyright Xilinx, Inc. **
--                  ** All rights reserved.   **
--                  ****************************
--
-------------------------------------------------------------------------------
-- Filename:        pf_adder.vhd
--
-- Description:     Parameterized adder/subtractor for Mauna Loa Packet FIFO
--                  vacancy calculation. This design has a combinational
--                  output. The carry out is not used by the PFIFO so it has
--                  been removed.
--                  
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:   
--                  pf_adder.vhd
--
-------------------------------------------------------------------------------
-- Author:          D. Thorpe
-- Revision:        $Revision: 1.1 $
-- Date:            $Date: 2004/04/01 23:19:18 $
--
-- History:
--   DET            2001-08-30    First Version
--                  - adapted from B Tise MicroBlaze timer counters
--
--  DET             2001-09-11 
--                  - Added the Rst input to the pf_adder_bit component
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
use unisim.all;

-----------------------------------------------------------------------------
-- Entity section
-----------------------------------------------------------------------------

entity pf_adder is
  generic (
    C_REGISTERED_RESULT : Boolean := false;
    C_COUNT_WIDTH       : integer := 10
    );  
  port (
    Clk           : in  std_logic;
    Rst           : in  std_logic;  
    --Carry_Out     : out std_logic;
    Ain           : in  std_logic_vector(0 to C_COUNT_WIDTH-1);
    Bin           : in  std_logic_vector(0 to C_COUNT_WIDTH-1);
    Add_sub_n     : in  std_logic;
    result_out    : out std_logic_vector(0 to C_COUNT_WIDTH-1)
    );
end entity pf_adder;

-----------------------------------------------------------------------------
-- Architecture section
-----------------------------------------------------------------------------

architecture implementation of pf_adder is

  component pf_adder_bit is  
    generic (
      C_REGISTERED_RESULT : Boolean
      );  
    port (
       Clk           : in  std_logic;
       Rst           : In  std_logic;
       Ain           : in  std_logic;
       Bin           : in  std_logic;
       Add_sub_n     : in  std_logic;
       Carry_In      : in  std_logic;
       Clock_Enable  : in  std_logic;
       Result        : out std_logic;
       Carry_Out     : out std_logic);
  end component pf_adder_bit;
  
  
  -- component FDRE is
  --   port (
  --     Q  : out std_logic;
  --     C  : in  std_logic;
  --     CE : in  std_logic;
  --     D  : in  std_logic;
  --     R  : in  std_logic
  --   );
  -- end component FDRE;
  -- 
  
  constant CY_START : integer := 1;
  

  signal alu_cy            : std_logic_vector(0 to C_COUNT_WIDTH);
  signal iresult_out       : std_logic_vector(0 to C_COUNT_WIDTH-1);
  signal count_clock_en    : std_logic;
  --signal carry_active_high : std_logic; 
  
                                       
                                       
begin  -- VHDL_RTL

  -----------------------------------------------------------------------------
  -- Generate the Counter bits
  -----------------------------------------------------------------------------
  
  alu_cy(C_COUNT_WIDTH) <= not(Add_sub_n); -- initial carry-in to adder LSB
                           
                           
  count_clock_en <= '1';
  
    
  I_ADDSUB_GEN : for i in 0 to C_COUNT_WIDTH-1 generate
  begin
    Counter_Bit_I : pf_adder_bit
      Generic map(
        C_REGISTERED_RESULT => C_REGISTERED_RESULT
      )
      port map (
        Clk           => Clk,                       -- [in]
        Rst           => Rst,                       -- [in]
        Ain           => Ain(i),                    -- [in]
        Bin           => Bin(i),                    -- [in]
        Add_sub_n     => Add_sub_n,                 -- [in]
        Carry_In      => alu_cy(i+CY_Start),        -- [in]
        Clock_Enable  => count_clock_en,            -- [in]
        Result        => iresult_out(i),            -- [out]
        Carry_Out     => alu_cy(i+(1-CY_Start)));   -- [out]
  end generate I_ADDSUB_GEN;

  
  
                            
  -- carry_active_high <= alu_cy(0) xor not(Add_sub_n);
  -- 
  -- 
  -- 
  -- I_CARRY_OUT: FDRE
  --   port map (
  --     Q  => Carry_Out,                             -- [out]
  --     C  => Clk,                                   -- [in]
  --     CE => count_clock_en,                        -- [in]
  --     D  => carry_active_high,                     -- [in]
  --     R  => Rst                                    -- [in]
  --   );      
    
  result_out <= iresult_out;
  
  
  
end architecture implementation;

