-------------------------------------------------------------------------------
-- $Id: reset_mir.vhd,v 1.1 2003/05/19 22:14:03 anitas Exp $
-------------------------------------------------------------------------------
--reset_mir.vhd
-------------------------------------------------------------------------------
--
--                  ****************************
--                  ** Copyright Xilinx, Inc. **
--                  ** All rights reserved.   **
--                  ****************************
--
-------------------------------------------------------------------------------
-- Filename:        reset_mir.vhd
--
-- Description:     SW reset / MIR register.
--
-------------------------------------------------------------------------------
-- Structure:   
--              reset_mir.vhd
--                  
-------------------------------------------------------------------------------
-- Author:      F.Ostler
--
-- History:
--  FLO          Aug 16, 2001
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
---------------------------------------------------------------------
-- Library definitions

library ieee;
use ieee.std_logic_1164.all;


library ieee;
use ieee.std_logic_arith.conv_std_logic_vector;

----------------------------------------------------------------------

entity reset_mir is
  Generic (
    C_DWIDTH               : integer  := 32;
    C_INCLUDE_SW_RST       : integer  := 1;  
    C_INCLUDE_MIR          : integer  := 0;
    C_MIR_MAJOR_VERSION    : integer  := 0;
    C_MIR_MINOR_VERSION    : integer  := 0;
    C_MIR_REVISION         : integer  := 1;
    C_MIR_BLK_ID           : integer  := 1;
    C_MIR_TYPE             : integer  := 1
  ); 
  port (
    Reset                  : in  std_logic;
    Bus2IP_Clk             : in  std_logic;
    SW_Reset_WrCE          : in  std_logic;
    Bus2IP_Data            : in  std_logic_vector(0 to C_DWIDTH-1);
    Bus2IP_Reset           : out std_logic;
    Reset2Bus_Data         : out std_logic_vector(0 to C_DWIDTH-1);
    Reset2Bus_Ack          : out std_logic;
    Reset2Bus_Error        : out std_logic;
    Reset2Bus_Retry        : out std_logic;
    Reset2Bus_ToutSup      : out std_logic
  );
end reset_mir;


architecture implementation of reset_mir is

    --------------------------------------------------------------------------------
    -- Value of data LSBs required for a reset-register write to be valid.
    --------------------------------------------------------------------------------
    constant RESET_MATCH : std_logic_vector(0 to 3) := "1010";

    signal sw_reset                : std_logic;
    signal sw_rst_cond             : std_logic;
    signal sw_rst_cond_d1          : std_logic;
    signal data_is_non_reset_match : std_logic;

begin

    ----------------------------------------------------------------------------
    -- Response signal generation
    ----------------------------------------------------------------------------
    Reset2Bus_Ack       <= '1' -- Always acknowledge immediately
                           when C_INCLUDE_SW_RST = 1 or C_INCLUDE_MIR = 1
                           else '0';
    Reset2Bus_Error     <= SW_Reset_WrCE and data_is_non_reset_match
                           when C_INCLUDE_SW_RST = 1
                           else '0';
    Reset2Bus_Retry     <= '0';
    Reset2Bus_ToutSup   <= '0';

    data_is_non_reset_match <=
        '0' when Bus2IP_Data(C_DWIDTH-4 to C_DWIDTH-1) = RESET_MATCH
        else '1';

--------------------------------------------------------------------------------
-- SW Reset
--------------------------------------------------------------------------------
  INCLUDE_SW_RESET_GEN : if C_INCLUDE_SW_RST = 1 generate
    ----------------------------------------------------------------------------
    -- ToDo, sw_reset could be implemented by instantiating a LUT, muxcy,
    -- orcy and two FFs.
    ----------------------------------------------------------------------------
    sw_rst_cond <= SW_Reset_WrCE and not data_is_non_reset_match;
    --
    RST_PULSE_PROC : process (Bus2IP_Clk)
    Begin
       if (Bus2IP_Clk'EVENT and Bus2IP_Clk = '1') Then
           if (Reset = '1') Then
              sw_rst_cond_d1 <= '0';
              sw_reset <= '0';
           else
              sw_rst_cond_d1 <= sw_rst_cond;
              sw_reset <= sw_rst_cond or sw_rst_cond_d1;
           end if;
       end if;
    End process;
    --
    Bus2IP_Reset <=  Reset or sw_reset;
  end generate;
  --
  --
  EXCLUDE_SW_RESET : if C_INCLUDE_SW_RST = 0 generate
    Bus2IP_Reset <=  Reset;
  end generate;


--------------------------------------------------------------------------------
-- MIR
--------------------------------------------------------------------------------
  EXCLUDE_MIR_GEN : if C_INCLUDE_MIR = 0 generate
      Reset2Bus_Data <= (others => '0');
  end generate; 
  --
  --
  INCLUDE_MIR_GEN : if C_INCLUDE_MIR = 1 generate
      signal  mir_value : std_logic_vector(0 to 31);
  begin
      ---------------------------------------------------------------------- 
      -- assemble the MIR fields from the Applicable Generics
      ----------------------------------------------------------------------
      mir_value(0 to 3)   <= CONV_STD_LOGIC_VECTOR(C_MIR_MAJOR_VERSION, 4);
      mir_value(4 to 10)  <= CONV_STD_LOGIC_VECTOR(C_MIR_MINOR_VERSION, 7);
      mir_value(11 to 15) <= CONV_STD_LOGIC_VECTOR(C_MIR_REVISION, 5);
      mir_value(16 to 23) <= CONV_STD_LOGIC_VECTOR(C_MIR_BLK_ID, 8);
      mir_value(24 to 31) <= CONV_STD_LOGIC_VECTOR(C_MIR_TYPE, 8);
      Reset2Bus_Data <= mir_value;
  end generate; 

end implementation;






