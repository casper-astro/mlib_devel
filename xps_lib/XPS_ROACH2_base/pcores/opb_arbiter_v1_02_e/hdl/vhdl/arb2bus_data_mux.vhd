-------------------------------------------------------------------------------
-- $Id: arb2bus_data_mux.vhd,v 1.2 2005/02/10 22:26:32 whittle Exp $
-------------------------------------------------------------------------------
-- arb2bus_data_mux.vhd - entity/architecture pair
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
-- Filename:        arb2bus_data_mux.vhd
-- Version:         v1.02e
-- Description:
--                  This file muxes the priority register and control register
--                  data to the IP2BUS data bus during a read cycle.
--
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:
--
--              opb_arbiter.vhd
--                --opb_arbiter_core.vhd
--                  -- ipif_regonly_slave.vhd
--                  -- priority_register_logic.vhd
--                      -- priority_reg.vhd
--                      -- onehot2encoded.vhd
--                          -- or_bits.vhd
--                  -- control_register.vhd
--                  -- arb2bus_data_mux.vhd
--                      -- mux_onehot.vhd
--                      -- or_bits.vhd
--                  -- watchdog_timer.vhd
--                  -- arbitration_logic.vhd
--                      -- or_bits.vhd
--                  -- park_lock_logic.vhd
--                      -- or_bits.vhd
--                      -- or_gate.vhd
--                          -- or_muxcy.vhd
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
-- bsbrao      09/27/04
-- ^^^^^^
--  Created version 1.02e to upgrade IPIF from opb_ipif_v1_23_a to
--  opb_ipif_v3_01_a
-- ~~~~~~
-- LCW	02/04/05 - update library statements
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
--
library ieee;
use ieee.STD_LOGIC_1164.all;

library unisim;
use unisim.vcomponents.all;

library opb_arbiter_v1_02_e;
use opb_arbiter_v1_02_e.all;

library proc_common_v2_00_a;
-------------------------------------------------------------------------------
-- Port Declaration
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Definition of Generics:
--      C_NUM_MASTERS                   -- number of masters
--      C_OPBDATA_WIDTH                 -- width of OPB data bus
--
-- Definition of Ports:
--
--      -- IPIF interface signals
--      input Bus2IP_Reg_RdCE           -- Read clock enables for registers
--      input Bus2IP_Reg_WrCE           -- Write clock enables for registers
--
--      -- Data from control register
--      input Ctrl_reg
--
--      -- Data from priority registers
--      input Priority_regs
--
--      -- Multiplexed outputs based on register clock enables and
--      -- read/write requests
--      output Arb2bus_wrack            -- mux'd output from register wracks
--      output Arb2bus_rdack            -- register read acknowledge
--      output Arb2bus_data             -- mux'd output data
--
-------------------------------------------------------------------------------

-----------------------------------------------------------------------------
-- Entity section
-----------------------------------------------------------------------------

entity  arb2bus_data_mux  is
    generic (   C_NUM_MASTERS       : integer := 4;
                C_OPBDATA_WIDTH     : integer := 32
            );
    port (  Bus2IP_Reg_RdCE : in std_logic_vector(0 to C_NUM_MASTERS);
            Bus2IP_Reg_WrCE : in std_logic_vector(0 to C_NUM_MASTERS);
            Ctrl_reg        : in std_logic_vector(0 to C_OPBDATA_WIDTH-1);
            Priority_regs   : in std_logic_vector (0 to C_NUM_MASTERS*C_OPBDATA_WIDTH-1);
            Arb2bus_wrack   : out std_logic ;
            Arb2bus_rdack   : out std_logic ;
            Arb2bus_data    : out std_logic_vector (0 to C_OPBDATA_WIDTH-1)

        );
end arb2bus_data_mux;

-----------------------------------------------------------------------------
-- Architecture section
-----------------------------------------------------------------------------
architecture implementation of arb2bus_data_mux is

-------------------------------------------------------------------------------
-- Signal and Type Declarations
-------------------------------------------------------------------------------
signal all_registers    : std_logic_vector(0 to (C_NUM_MASTERS+1)*C_OPBDATA_WIDTH -1);

-------------------------------------------------------------------------------
-- Component Declarations
-------------------------------------------------------------------------------
-- MUX_ONEHOT is used to pick which register is being read
-- The register read chip enables are used as the select lines


-- OR_BITS is used OR together sections of a bus
-- It will be used to determine when to generate Arb2bus_rdack and Arb2bus_wrack

-----------------------------------------------------------------------------
-- Begin architecture
-----------------------------------------------------------------------------
begin
-------------------------------------------------------------------------------
-- ARB2BUS_DATA_PROCESS
-------------------------------------------------------------------------------
-- This process multiplexes the data from the priority registers and the
-- control register based on the register chip enables to generate
-- ARB2BUS_DATA
-------------------------------------------------------------------------------
all_registers <= Ctrl_reg & Priority_regs;

ARB2BUS_DATAMUX_I: entity proc_common_v2_00_a.mux_onehot
    generic map (   C_DW => C_OPBDATA_WIDTH,
                    C_NB => C_NUM_MASTERS+1)
    port map (
                D     => all_registers,
                S     => Bus2IP_Reg_RdCE,
                Y     => Arb2bus_data
            );


-------------------------------------------------------------------------------
-- ARB2BUS_RDACK
-------------------------------------------------------------------------------
-- ARB2BUS_RDACK is simply the OR of all Bus2IP read register chip enables
-- Use the OR_BITS component to perform the OR of these bits most efficiently
-------------------------------------------------------------------------------
ARB2BUS_RDACK_I: entity proc_common_v2_00_a.or_bits
    generic map (   C_NUM_BITS  => C_NUM_MASTERS+1,
                    C_START_BIT => 0,
                    C_BUS_SIZE  => C_NUM_MASTERS+1)
    port map    (
                    In_bus      => Bus2Ip_Reg_RdCE,
                    Sig         => '0',
                    Or_out      => Arb2bus_rdack
                );
-------------------------------------------------------------------------------
-- ARB2BUS_WRACK generation
-------------------------------------------------------------------------------
-- This process ORs the wrack from the priority register logic and the
-- control register logic to generate ARB2BUS_WRACK
-------------------------------------------------------------------------------
ARB2BUS_WRACK_I: entity proc_common_v2_00_a.or_bits
    generic map (   C_NUM_BITS  => C_NUM_MASTERS+1,
                    C_START_BIT => 0,
                    C_BUS_SIZE  => C_NUM_MASTERS+1)
    port map    (
                    In_bus      => Bus2Ip_Reg_WrCE,
                    Sig         => '0',
                    Or_out      => Arb2bus_wrack
                );
end implementation;
