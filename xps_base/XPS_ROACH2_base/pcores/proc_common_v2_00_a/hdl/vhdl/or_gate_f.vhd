-------------------------------------------------------------------------------
-- $Id: or_gate_f.vhd,v 1.2 2006/12/13 17:37:19 ostlerf Exp $
-------------------------------------------------------------------------------
-- or_gate_f.vhd - entity/architecture pair
-------------------------------------------------------------------------------
--
--  ***************************************************************************
--  **  Copyright(C) 2006 Xilinx, Inc. All rights reserved.                  **
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
-- Filename:        or_gate_f.vhd
--
-- Description:     OR gates. The width of each OR gate (C_OR_WIDTH)
--                  and the number of or gates (C_BUS_WIDTH) are
--                  parameterizable.
--                  
--                  Y(j) <= A(j) OR A(C_BUS_WIDTH+j)
--                               OR A(2*C_BUS_WIDTH+j)
--                               ...
--                               OR A((C_OR_WIDTH-1)*C_BUS_WIDTH+j),
--
--                    for 0 <= j < C_BUS_WIDTH
--
--                  If C_FAMILY is set (or left defaulted) to "nofamily"
--                  then the implementation will be by synthesis inference.
--                  Otherwise, a structural implementation optimized to
--                  C_FAMILY may be generated, depending on whether
--                  C_FAMILY supports the needed primtives.
--
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:   
--                  or_gate_f.vhd
--
-------------------------------------------------------------------------------
-- Author:         FLO
-- History:
--   FLO           2006-12-11
-- ^^^^^^
--   First Version, derived from or_gate by BLT
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
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
library proc_common_v2_00_a;

-------------------------------------------------------------------------------
-- Definition of Generics:
--   C_OR_WIDTH           -- Which Xilinx FPGA family to target when
--                           syntesizing, affect the RLOC string values 
--   C_BUS_WIDTH          -- Which Y position the RLOC should start from
--
-- Definition of Ports:
--   A                    -- Input.  Input buses are concatenated together to
--                           form input A. Example: to OR buses R, S, and T,
--                           assign A <= R & S & T;
--   Y                    -- Output. Same width as input buses.
--
-------------------------------------------------------------------------------
entity or_gate_f is
  generic (
    C_OR_WIDTH   : natural := 17;
    C_BUS_WIDTH  : natural := 1;
    C_FAMILY     : string := "nofamily"
    );
  port (
    A : in  std_logic_vector(0 to C_OR_WIDTH*C_BUS_WIDTH-1);
    Y : out std_logic_vector(0 to C_BUS_WIDTH-1)
    );
end entity or_gate_f;

    
architecture imp of or_gate_f is

-------------------------------------------------------------------------------
-- Component Declarations
-------------------------------------------------------------------------------

signal test : std_logic_vector(0 to C_BUS_WIDTH-1);
-------------------------------------------------------------------------------
-- Begin architecture
-------------------------------------------------------------------------------

begin

    BUS_WIDTH_FOR_GEN: for i in 0 to C_BUS_WIDTH-1 generate
      signal in_Bus : std_logic_vector(0 to C_OR_WIDTH-1);
    begin

      ORDER_INPUT_BUS_PROCESS: process( A ) is
      begin
        for k in 0 to C_OR_WIDTH-1 loop
          in_Bus(k) <=  A(k*C_BUS_WIDTH+i);
        end loop;
      end process ORDER_INPUT_BUS_PROCESS;

      OR_BITS_I: entity proc_common_v2_00_a.or_muxcy_f
        generic map (
          C_NUM_BITS      => C_OR_WIDTH,
          C_FAMILY        => C_FAMILY
          )  
        port map (
          In_bus          => in_Bus,    --[in]
          Or_out          => Y(i)       --[out]
          );

    end generate BUS_WIDTH_FOR_GEN;

end architecture imp;
