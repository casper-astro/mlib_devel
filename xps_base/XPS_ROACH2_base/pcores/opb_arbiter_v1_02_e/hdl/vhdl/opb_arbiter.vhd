-------------------------------------------------------------------------------
-- $Id: opb_arbiter.vhd,v 1.5 2006/06/06 06:45:47 chandanm Exp $
-------------------------------------------------------------------------------
-- opb_arbiter.vhd - entity/architecture pair 
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
-- Filename:        opb_arbiter.vhd
-- Version:         v1.02e 
-- Description:     This is the top-level design file for the OPB Arbiter. It 
--                  supports 1-16 masters and both fixed and dynamic priority 
--                  algorithms via user-configurable parameters. The user can
--                  also include support for bus parking and the OPB slave 
--                  interface by setting parameters. 
--
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:   
--
--         opb_arbiter.vhd
--            -- opb_arbiter_core.vhd
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
-------------------------------------------------------------------------------
-- @BEGIN_CHANGELOG EDK_I_SP1 
--  
-- Fixed issue with REG_HIGHADDR constant not being defined correctly.  This
-- issue was causing a synthesis error.
--
-- @END_CHANGELOG 
-------------------------------------------------------------------------------
-- @BEGIN_CHANGELOG EDK_Im_SP1 
--  
-- Modified the processes MASTER_LOOP and MASTERLOOP to remove the latch it was
-- creating in priority_register_logic.vhd and arbitration_logic.vhd 
-- modules respectively.
--
-- @END_CHANGELOG 
-------------------------------------------------------------------------------
-- Author:      JAC
-- History:
--  JAC         09/25/01        
-- ^^^^^^
-- Version 1.01a creation to create COREGEN simple wrapper.
-- ~~~~~~
--
--  ALS         10/04/01        
-- ^^^^^^
--  Version 1.02a creation to include IPIF v1.23a. Also changed C_BASEADDR 
--  back to std_logic_vector.
-- ~~~~~~
-- 
--  ALS         10/12/01
-- ^^^^^^
--  Replaced generic C_DEV_ADDR_DECODE_WIDTH with C_HIGHADDR. 
--  C_DEV_ADDR_DECODE_WIDTH will be calcuated from C_HIGHADDR and C_BASEADDR.
-- ~~~~~~
--
--  ALS         11/27/01
-- ^^^^^^
--  Version 1.02b created to fix registered grant problem. Also, replaced
--  C_OPBDATA_WIDTH and C_OPBADDR_WIDTH with C_OPB_DWIDTH and 
--  C_OPB_AWIDTH.
-- ~~~~~~
--
--  ALS         12/04/01
-- ^^^^^^
--  Replaced C_OPBDATA_WIDTH and C_OPBADDR_WIDTH with C_OPB_DWIDTH and  
--  C_OPB_AWIDTH. 
-- ~~~~~~
--  ALS         12/06/01
-- ^^^^^^
--  Modified default values for C_BASEADDR and C_HIGHADDR to the values
--  required by the system build environment.
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
--  GAB         07/05/05
-- ^^^^^^
--  Fixed XST issue in ipif_regonly_slave.vhd.  This fixes CR211277.
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
-- 
 
library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.STD_LOGIC_SIGNED.all;

-- CONV_FUNS_PKG containts functions to convert simple generic types to more
-- complex data types (ie: strings to std_logic_vector).
library proc_utils_v1_00_a;
use proc_utils_v1_00_a.conv_funs_pkg.all;

-- OPB_ARB_PKG contains the necessary constants and functions for the 
-- OPB Arbiter
library opb_arbiter_v1_02_e;
use opb_arbiter_v1_02_e.opb_arb_pkg.all;

-------------------------------------------------------------------------------
-- Port Declaration
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Definition of Generics:
--      C_BASEADDR              -- OPB Arbiter base address
--      C_HIGHADDR              -- OPB Arbiter high address
--      C_NUM_MASTERS           -- number of OPB masters
--      C_OPB_DWIDTH            -- width of OPB data bus
--      C_OPB_AWIDTH            -- width of OPB address bus
--      C_DYNAM_PRIORITY        -- dynamic or fixed priority
--      C_PARK                  -- bus parking
--      C_PROC_INTRFCE          -- OPB slave interface
--      C_REG_GRANTS            -- registered or combinational grant outputs
--      C_DEV_BLK_ID            -- device block id
--      C_DEV_MIR_ENABLE        -- IPIF mirror capability enable
--
-- Definition of Ports:
--         
--      output ARB_DBus         -- Arbiter's data bus to OPB
--      output ARB_ErrAck       -- Arbiter's error acknowledge - unused
--      output ARB_Retry        -- Arbiter's retry signal - unused
--      output ARB_XferAck      -- Arbiter's xfer acknowledge
--      input OPB_Clk           -- Clock
--      input M_request         -- Masters' request signals
--      input OPB_Abus          -- OPB Address bus
--      input OPB_BE            -- OPB Byte Enables
--      input OPB_buslock       -- Bus lock
--      input OPB_Dbus          -- OPB Data bus
--      output OPB_MGrant       -- Masters' grant signals
--      input OPB_retry         -- Retry
--      input OPB_RNW           -- Read not Write
--      input OPB_select        -- Master has control of bus
--      input OPB_seqAddr       -- Sequential Address
--      output OPB_timeout      -- Timeout
--      input OPB_toutSup       -- Timeout suppress
--      input OPB_xferAck       -- OPB xfer acknowledge
--      input OPB_Rst           -- Reset
--
-------------------------------------------------------------------------------

-----------------------------------------------------------------------------
-- Entity section
-----------------------------------------------------------------------------
entity opb_arbiter is
    generic (
             C_BASEADDR                 : std_logic_vector := X"FFFFFFFF";
             C_HIGHADDR                 : std_logic_vector := X"00000000";
             C_NUM_MASTERS              : integer := 4;
             C_OPB_DWIDTH               : integer := 32;
             C_OPB_AWIDTH               : integer := 32;
             C_DYNAM_PRIORITY           : integer := 0;
             C_PARK                     : integer := 0;
             C_PROC_INTRFCE             : integer := 0;
             C_REG_GRANTS               : integer := 1;
             C_DEV_BLK_ID               : integer := 0;
             C_DEV_MIR_ENABLE           : integer := 0
             );
    port (
          ARB_DBus      : out std_logic_vector(0 to C_OPB_DWIDTH-1);
          ARB_ErrAck    : out std_logic;
          ARB_Retry     : out std_logic;
          ARB_ToutSup   : out std_logic;
          ARB_XferAck   : out std_logic;
          OPB_Clk       : in std_logic;
          M_request     : in std_logic_vector(0 to C_NUM_MASTERS-1);
          OPB_Abus      : in std_logic_vector(0 to C_OPB_AWIDTH-1);
          OPB_BE        : in std_logic_vector(0 to C_OPB_DWIDTH/8-1);
          OPB_buslock   : in std_logic;
          OPB_Dbus      : in std_logic_vector(0 to C_OPB_DWIDTH-1);
          OPB_MGrant    : out std_logic_vector(0 to C_NUM_MASTERS-1);
          OPB_retry     : in std_logic;
          OPB_RNW       : in std_logic;
          OPB_select    : in std_logic;
          OPB_seqAddr   : in std_logic;
          OPB_timeout   : out std_logic;
          OPB_toutSup   : in std_logic;
          OPB_xferAck   : in std_logic;
          OPB_Rst       : in std_logic
          );

end entity opb_arbiter;
 
 

-----------------------------------------------------------------------------
-- Architecture section
-----------------------------------------------------------------------------
architecture implementation of opb_arbiter is

-------------------------------------------------------------------------------
--  Constant Declarations
-------------------------------------------------------------------------------
    -- none
-------------------------------------------------------------------------------
--  Signal and Type Declarations
-------------------------------------------------------------------------------
  -- none
-------------------------------------------------------------------------------
-- Component Declarations
-------------------------------------------------------------------------------
-- OPB Arbiter Core

component opb_arbiter_core is
  generic (
    C_BASEADDR              : std_logic_vector;
    C_HIGHADDR              : std_logic_vector;
    C_NUM_MASTERS           : integer;
    C_OPBDATA_WIDTH         : integer;
    C_OPBADDR_WIDTH         : integer;
    C_DYNAM_PRIORITY        : boolean;
    C_REG_GRANTS            : boolean;
    C_PARK                  : boolean;
    C_PROC_INTRFCE          : boolean;
    C_DEV_BLK_ID            : integer;
    C_DEV_MIR_ENABLE        : integer);
  port (
      ARB_DBus    : out std_logic_vector(0 to C_OPBDATA_WIDTH-1);
      ARB_ErrAck  : out std_logic;
      ARB_Retry   : out std_logic;
      ARB_ToutSup : out std_logic;
      ARB_XferAck : out std_logic;
      OPB_Clk     : in  std_logic;
      M_request   : in  std_logic_vector(0 to C_NUM_MASTERS-1);
      OPB_Abus    : in  std_logic_vector(0 to C_OPBADDR_WIDTH-1);
      OPB_BE      : in  std_logic_vector(0 to C_OPBDATA_WIDTH/8-1);
      OPB_buslock : in  std_logic;
      OPB_Dbus    : in  std_logic_vector(0 to C_OPBDATA_WIDTH-1);
      OPB_MGrant  : out std_logic_vector(0 to C_NUM_MASTERS-1);
      OPB_retry   : in  std_logic;
      OPB_RNW     : in  std_logic;
      OPB_select  : in  std_logic;
      OPB_seqAddr : in  std_logic;
      OPB_timeout : out std_logic;
      OPB_toutSup : in  std_logic;
      OPB_xferAck : in  std_logic;
      OPB_Rst     : in  std_logic);
end component opb_arbiter_core;

-----------------------------------------------------------------------------
-- Begin architecture
-----------------------------------------------------------------------------
begin
  OPB_ARBITER_CORE_I: opb_arbiter_core
    generic map (
      C_BASEADDR              => C_BASEADDR,
      C_HIGHADDR              => C_HIGHADDR,
      C_NUM_MASTERS           => C_NUM_MASTERS,
      C_OPBDATA_WIDTH         => C_OPB_DWIDTH,
      C_OPBADDR_WIDTH         => C_OPB_AWIDTH,
      C_DYNAM_PRIORITY        => C_DYNAM_PRIORITY /= 0,
      C_REG_GRANTS            => C_REG_GRANTS /= 0,
      C_PARK                  => C_PARK /= 0,
      C_PROC_INTRFCE          => C_PROC_INTRFCE /= 0,
      C_DEV_BLK_ID            => C_DEV_BLK_ID,
      C_DEV_MIR_ENABLE        => C_DEV_MIR_ENABLE)
    port map (
      ARB_DBus    => ARB_DBus,
      ARB_ErrAck  => ARB_ErrAck,
      ARB_Retry   => ARB_Retry,
      ARB_ToutSup => ARB_ToutSup,
      ARB_XferAck => ARB_XferAck,
      OPB_Clk     => OPB_Clk,
      M_request   => M_request,
      OPB_Abus    => OPB_Abus,
      OPB_BE      => OPB_BE,
      OPB_buslock => OPB_buslock,
      OPB_Dbus    => OPB_Dbus,
      OPB_MGrant  => OPB_MGrant,
      OPB_retry   => OPB_retry,
      OPB_RNW     => OPB_RNW,
      OPB_select  => OPB_select,
      OPB_seqAddr => OPB_seqAddr,
      OPB_timeout => OPB_timeout,
      OPB_toutSup => OPB_toutSup,
      OPB_xferAck => OPB_xferAck,
      OPB_Rst     => OPB_Rst);


end implementation;

