-------------------------------------------------------------------------------
-- $Id: or_gate.vhd,v 1.2 2003/12/16 22:36:27 lesters Exp $
-------------------------------------------------------------------------------
-- or_gate.vhd - entity/architecture pair
-------------------------------------------------------------------------------
--
--                  ****************************
--                  ** Copyright Xilinx, Inc. **
--                  ** All rights reserved.   **
--                  ****************************
--
-------------------------------------------------------------------------------
-- Filename:        or_gate.vhd
-- Version:         v1.00a
-- Description:     OR gate implementation
--                  
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:   
--                  or_gate.vhd
--
-------------------------------------------------------------------------------
-- Author:          B.L. Tise
-- History:
--   BLT           2001-05-23    First Version
-- ^^^^^^
--      First version of OPB Bus.
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
use proc_common_v2_00_a.all;

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
entity or_gate is
  generic (
    C_OR_WIDTH   : natural range 1 to 32 := 17;
    C_BUS_WIDTH  : natural range 1 to 64 := 1;
    C_USE_LUT_OR : boolean := TRUE
    );
  port (
    A : in  std_logic_vector(0 to C_OR_WIDTH*C_BUS_WIDTH-1);
    Y : out std_logic_vector(0 to C_BUS_WIDTH-1)
    );
end entity or_gate;

    
architecture imp of or_gate is

-------------------------------------------------------------------------------
-- Component Declarations
-------------------------------------------------------------------------------

component or_muxcy 
    generic (
            C_NUM_BITS      : integer   := 8
            );
    port    (
            In_bus          : in std_logic_vector(0 to C_NUM_BITS-1);
            Or_out          : out std_logic     
            );
end component or_muxcy;

signal test : std_logic_vector(0 to C_BUS_WIDTH-1);
-------------------------------------------------------------------------------
-- Begin architecture
-------------------------------------------------------------------------------

begin
  USE_LUT_OR_GEN: if C_USE_LUT_OR generate
    OR_PROCESS: process( A ) is
    variable yi : std_logic_vector(0 to (C_OR_WIDTH));
    begin
      for j in 0 to C_BUS_WIDTH-1 loop
        yi(0) := '0';
        for i in 0 to C_OR_WIDTH-1 loop
          yi(i+1) := yi(i) or A(i*C_BUS_WIDTH+j);
        end loop;
        Y(j) <= yi(C_OR_WIDTH);
      end loop;
    end process OR_PROCESS;
  end generate USE_LUT_OR_GEN;

  USE_MUXCY_OR_GEN: if not C_USE_LUT_OR generate
    BUS_WIDTH_FOR_GEN: for i in 0 to C_BUS_WIDTH-1 generate
      signal in_Bus : std_logic_vector(0 to C_OR_WIDTH-1);
    begin
      ORDER_INPUT_BUS_PROCESS: process( A ) is
      begin
        for k in 0 to C_OR_WIDTH-1 loop
          in_Bus(k) <=  A(k*C_BUS_WIDTH+i);
        end loop;
      end process ORDER_INPUT_BUS_PROCESS;
      OR_BITS_I: or_muxcy
        generic map (
          C_NUM_BITS      => C_OR_WIDTH
          )  
        port map (
          In_bus          => in_Bus,    --[in]
          Or_out          => Y(i)       --[out]
          );
     end generate BUS_WIDTH_FOR_GEN;
   end generate USE_MUXCY_OR_GEN;

end architecture imp;
