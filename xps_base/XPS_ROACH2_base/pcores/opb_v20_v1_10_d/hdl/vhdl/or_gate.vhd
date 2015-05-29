-------------------------------------------------------------------------------
-- $Id: or_gate.vhd,v 1.1.2.1 2009/10/06 21:15:01 gburch Exp $
-------------------------------------------------------------------------------
-- or_gate.vhd - entity/architecture pair
-------------------------------------------------------------------------------
--
-- *************************************************************************
-- **                                                                     **
-- ** DISCLAIMER OF LIABILITY                                             **
-- **                                                                     **
-- ** This text/file contains proprietary, confidential                   **
-- ** information of Xilinx, Inc., is distributed under                   **
-- ** license from Xilinx, Inc., and may be used, copied                  **
-- ** and/or disclosed only pursuant to the terms of a valid              **
-- ** license agreement with Xilinx, Inc. Xilinx hereby                   **
-- ** grants you a license to use this text/file solely for               **
-- ** design, simulation, implementation and creation of                  **
-- ** design files limited to Xilinx devices or technologies.             **
-- ** Use with non-Xilinx devices or technologies is expressly            **
-- ** prohibited and immediately terminates your license unless           **
-- ** covered by a separate agreement.                                    **
-- **                                                                     **
-- ** Xilinx is providing this design, code, or information               **
-- ** "as-is" solely for use in developing programs and                   **
-- ** solutions for Xilinx devices, with no obligation on the             **
-- ** part of Xilinx to provide support. By providing this design,        **
-- ** code, or information as one possible implementation of              **
-- ** this feature, application or standard, Xilinx is making no          **
-- ** representation that this implementation is free from any            **
-- ** claims of infringement. You are responsible for obtaining           **
-- ** any rights you may require for your implementation.                 **
-- ** Xilinx expressly disclaims any warranty whatsoever with             **
-- ** respect to the adequacy of the implementation, including            **
-- ** but not limited to any warranties or representations that this      **
-- ** implementation is free from claims of infringement, implied         **
-- ** warranties of merchantability or fitness for a particular           **
-- ** purpose.                                                            **
-- **                                                                     **
-- ** Xilinx products are not intended for use in life support            **
-- ** appliances, devices, or systems. Use in such applications is        **
-- ** expressly prohibited.                                               **
-- **                                                                     **
-- ** Any modifications that are made to the Source Code are              **
-- ** done at the user’s sole risk and will be unsupported.               **
-- ** The Xilinx Support Hotline does not have access to source           **
-- ** code and therefore cannot answer specific questions related         **
-- ** to source HDL. The Xilinx Hotline support of original source        **
-- ** code IP shall only address issues and questions related             **
-- ** to the standard Netlist version of the core (and thus               **
-- ** indirectly, the original core source).                              **
-- **                                                                     **
-- ** Copyright (c) 2003,2009 Xilinx, Inc. All rights reserved.           **
-- **                                                                     **
-- ** This copyright and support notice must be retained as part          **
-- ** of this text at all times.                                          **
-- **                                                                     **
-- *************************************************************************
--
-------------------------------------------------------------------------------
-- Filename:        or_gate.vhd
-- Version:         v1.02e
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
--  GAB         10/05/09
-- ^^^^^^
--  Moved all helper libraries proc_common_v2_00_a, opb_ipif_v3_01_a, and
--  opb_arbiter_v1_02_e locally into opb_v20_v1_10_d
--
--  Updated legal header
-- ~~~~~~
-----------------------------------------------------------------------------
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

library unisim;
use unisim.vcomponents.all;

library opb_v20_v1_10_d;
use opb_v20_v1_10_d.all;

-------------------------------------------------------------------------------
-- Definition of Generics:
--   C_OR_WIDTH           -- Which Xilinx FPGA family to target when
--                           syntesizing, affect the RLOC string values
--   C_BUS_WIDTH          -- Which Y position the RLOC should start from
--   C_USE_LUT_OR         -- Implement OR function in LUTs or MUXCY
--
-- Definition of Ports:
--   A                    -- Input.  Input buses are concatenated together to
--                           form input A. Example: to OR buses R, S, and T,
--                           assign A <= R & S & T;
--   Y                    -- Output. Same width as input buses.
--
-------------------------------------------------------------------------------
-----------------------------------------------------------------------------
-- Entity section
-----------------------------------------------------------------------------
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


-----------------------------------------------------------------------------
-- Architecture section
-----------------------------------------------------------------------------
architecture imp of or_gate is

-------------------------------------------------------------------------------
-- Component Declarations
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Signal Declarations
-------------------------------------------------------------------------------

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
      OR_BITS_I: entity opb_v20_v1_10_d.or_muxcy
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