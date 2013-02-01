-------------------------------------------------------------------------------
-- $Id: or_muxcy.vhd,v 1.1 2004/11/05 11:20:52 bommanas Exp $
-------------------------------------------------------------------------------
-- or_muxcy
-------------------------------------------------------------------------------
--
--  ***************************************************************************
--  **  Copyright(C) 2003 by Xilinx, Inc. All rights reserved.               **
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
-- Filename:        or_muxcy.vhd
-- Version:         v1.02e
-- Description:     This file is used to implement an OR function using
--                  carry chain muxes.
--                  
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:       Common use module
-------------------------------------------------------------------------------

-- Author:      ALS
-- History:
--  ALS         08/28/01        -- Version 1.01a creation to include IPIF v1.22a
--  ALS         10/04/01        -- Version 1.02a creation to include IPIF v1.23a
--  ALS         11/27/01
-- ^^^^^^
--  Version 1.02b created to fix registered grant problem.
-- ~~~~~~
--  ALS         01/26/02
-- ^^^^^^
--  Created version 1.02c to fix problem with registered grants, and buslock when
--  the buslock master is holding request high and performing conversion cycles.
-- ~~~~~~
--  ALS         01/09/03
-- ^^^^^^
--  Created version 1.02d to register OPB_timeout to improve timing
-- ~~~~~~
--  bsbrao      09/27/04
-- ^^^^^^
--  Created version 1.02e to upgrade IPIF from opb_ipif_v1_23_a to 
--  opb_ipif_v3_01_a 
-- ~~~~~~
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
use ieee.std_logic_1164.all;

-- Unisim library contains Xilinx primitives
library unisim;
use unisim.all;
-------------------------------------------------------------------------------
-- Port Declaration
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Definition of Generics:
--          C_NUM_BITS              -- number of bits to OR in bus section
--
-- Definition of Ports:
--          input  In_Bus           -- bus containing bits to be ORd
--          output Or_out           -- OR result
--
-------------------------------------------------------------------------------
-----------------------------------------------------------------------------
-- Entity section
-----------------------------------------------------------------------------
entity or_muxcy is
    generic (
            C_NUM_BITS      : integer   := 8
            );
    port    (
            In_bus          : in std_logic_vector(0 to C_NUM_BITS-1);
            Or_out          : out std_logic     
            );
end or_muxcy;


-----------------------------------------------------------------------------
-- Architecture section
-----------------------------------------------------------------------------
architecture implementation of or_muxcy is

-------------------------------------------------------------------------------
-- Constant Declarations
-------------------------------------------------------------------------------
-- Pad the number of bits to OR to the next multiple of 4 
constant NUM_BITS_PAD       : integer   := ((C_NUM_BITS-1)/4+1)*4;
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Signal Declarations
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Component Declarations
-------------------------------------------------------------------------------
-- Carry Chain muxes are used to implement OR of 4 bits or more
component MUXCY
  port (
    O : out std_logic;
    CI : in std_logic;
    DI : in std_logic;
    S : in std_logic
  );
end component;

-----------------------------------------------------------------------------
-- Begin architecture
-----------------------------------------------------------------------------
begin


-- If the number of bits to OR is 4 or less, a simple LUT can be used
LESSTHAN4_GEN: if C_NUM_BITS < 5 generate
-- define output of OR chain
signal or_tmp   : std_logic_vector(0 to C_NUM_BITS-1) := (others => '0');
begin
    BIT_LOOP: for i in 0 to C_NUM_BITS-1 generate
        FIRST: if i = 0 generate
            or_tmp(i) <= In_bus(0);
        end generate FIRST;
        
        REST: if i /= 0 generate
            or_tmp(i) <= or_tmp(i-1) or In_bus(i);
        end generate REST;
    end generate BIT_LOOP;
    
    Or_out <= or_tmp(C_NUM_BITS-1);
end generate LESSTHAN4_GEN;

-- If the number of bits to OR is 4 or more, then use LUTs and
-- carry chain. Pad the number of bits to the nearest multiple of 4
MORETHAN4_GEN: if C_NUM_BITS >= 5 generate

-- define output of LUTs
signal lut_out  : std_logic_vector(0 to NUM_BITS_PAD/4-1) := (others => '0');
-- define padded input bus
signal in_bus_pad   : std_logic_vector(0 to NUM_BITS_PAD-1) := (others => '0');
-- define output of OR chain
signal or_tmp  : std_logic_vector(0 to NUM_BITS_PAD/4-1) := (others => '0');


begin

    -- pad input bus
    in_bus_pad(0 to C_NUM_BITS-1) <= In_bus(0 to C_NUM_BITS-1);

    OR_GENERATE: for i in 0 to NUM_BITS_PAD/4-1 generate
        
        lut_out(i) <= not( in_bus_pad(i*4) or
                           in_bus_pad(i*4+1) or
                           in_bus_pad(i*4+2) or 
                           in_bus_pad(i*4+3) );
    
        FIRST:  if i = 0 generate
            FIRSTMUX_I: MUXCY
              port map (
                O   => or_tmp(i),   --[out]
                CI  => '0' ,        --[in]
                DI  => '1' ,        --[in]
                S   => lut_out(i)   --[in]
              );
        end generate FIRST;
    
        REST: if i /= 0 generate
            RESTMUX_I: MUXCY
              port map (
                O   => or_tmp(i),   --[out]
                CI  => or_tmp(i-1), --[in]
                DI  => '1' ,        --[in]
                S   => lut_out(i)   --[in]
              );
        end generate REST;
        
    end generate OR_GENERATE;
Or_out <= or_tmp(NUM_BITS_PAD/4-1);

end generate MORETHAN4_GEN;


end implementation;

