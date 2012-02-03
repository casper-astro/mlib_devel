-------------------------------------------------------------------------------
-- $Id: opb_v20.vhd,v 1.3 2006/06/06 06:42:51 chandanm Exp $
-------------------------------------------------------------------------------
-- opb_v20.vhd - entity/architecture pair
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
-- Filename:        opb_v20.vhd
-- Version:         v1.10c
-- Description:     IBM OPB (On-chip Peripheral Bus) implementation
--                  
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:   
--                  opb_v20.vhd
--                      -- opb_arbiter.vhd
--
--VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- @BEGIN_CHANGELOG EDK_Gmm_SP2
-- Upgraded the IP with opb_ipif_v3_01_a
-- @END_CHANGELOG
-------------------------------------------------------------------------------
-- @BEGIN_CHANGELOG EDK_Im_SP1 
--  
-- Modified the files below for the processes MASTER_LOOP and MASTERLOOP to 
-- remove the latch it was creating:
-- 1) priority_register_logic.vhd
-- 2) arbitration_logic.vhd 
-- These modules are present in the opb_arbiter_v1_02_e.
--
-- @END_CHANGELOG 
-------------------------------------------------------------------------------
-- Author:          B.L. Tise
-- History:
--   BLT           2001-05-23    First Version
-- ^^^^^^
--      First version of OPB Bus.
-- ~~~~~~
--   BLT           2002-01-08    Added WDT Reset
--   BLT           2002-05-02    Added instantiation of opb_arbiter
--   ALS           2003-01-07    Instantiated opb_arbiter_v1_02_d to optimize
--                               opb_timeout (registered it)
--   bsbrao        2004-09-27    Upgraded the arbiter IP with opb_ipif_v3_01_a
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
library opb_arbiter_v1_02_e;
use opb_arbiter_v1_02_e.or_gate;
library Unisim;
use Unisim.vcomponents.all;
library opb_arbiter_v1_02_e;
use opb_arbiter_v1_02_e.opb_arbiter;

-------------------------------------------------------------------------------
-- Definition of Generics:
--      C_USE_LUT_OR            -- Use LUT-based OR instead of MUXCY-based OR
--      C_EXT_RESET_HIGH        -- External reset is active high
--      C_BASEADDR              -- OPB Arbiter base address
--      C_HIGHADDR              -- OPB Arbiter high address
--      C_NUM_MASTERS           -- number of OPB masters
--      C_NUM_SLAVES            -- number of OPB slaves (external to opb_v20)
--                                 Do not include the slave interface of the
--                                 opb_arbiter (if present) in this total.                                   
--      C_OPB_DWIDTH            -- width of OPB data bus
--      C_OPB_AWIDTH            -- width of OPB address bus
--      C_DYNAM_PRIORITY        -- dynamic or fixed priority
--      C_REG_GRANTS            -- registered or combinational grant outputs
--      C_PARK                  -- bus parking
--      C_PROC_INTRFCE          -- OPB slave interface
--      C_DEV_BLK_ID            -- device block id
--      C_DEV_MIR_ENABLE        -- IPIF mirror capability enable
--
-- Definition of Ports:
--   See OPB specification V2.0
--    
--      input  SYS_Rst          -- System reset
--      input  Debug_SYS_Rst    -- Reset from JTAG UART for reseting from debugger
--      input  WDT_Rst          -- Reset from Watchdog Timer
--      input  OPB_Clk          -- OPB Clock
--      output OPB_Rst          -- Reset out to OPB bus
--   
--      -- Master outputs
--      input  M_ABus           -- master address
--      input  M_BE             -- master byte enables
--      input  M_beXfer         -- master byte enable transfer
--      input  M_busLock        -- master buslock
--      input  M_DBus           -- master databus
--      input  M_DBusEn         -- master databus enable
--      input  M_DBusEn32_63    -- master databus enable for data bits 32:63
--      input  M_dwXfer         -- master double word transfer
--      input  M_fwXfer         -- master fullword transfer
--      input  M_hwXfer         -- master halfword transfer
--      input  M_request        -- master request
--      input  M_RNW            -- master read/not write
--      input  M_select         -- master select
--      input  M_seqAddr        -- master sequential address

--      -- Slave outputs
--      input  Sl_beAck         -- slave byte enable acknowledge
--      input  Sl_DBus          -- slave databus
--      input  Sl_DBusEn        -- slave databus enable
--      input  Sl_DBusEn32_63   -- slave databus enable for data bits 32:63
--      input  Sl_errAck        -- slave error acknowledge
--      input  Sl_dwAck         -- slave doubleword acknowledge
--      input  Sl_fwAck         -- slave fullword acknowledge
--      input  Sl_hwAck         -- slave halfword acknowledge
--      input  Sl_retry         -- slave retry
--      input  Sl_toutSup       -- slave timeout suppress
--      input  Sl_xferAck       -- slave transfer acknowledge
--          
--      -- OPB outputs
--      output OPB_MRequest     -- OPB request
--      output OPB_ABus         -- OPB address
--      output OPB_BE           -- OPB byte enables
--      output OPB_beXfer       -- OPB byte enable transfer
--      output OPB_beAck        -- OPB 
--      output OPB_busLock      -- OPB buslock
--      output OPB_rdDBus       -- OPB read databus
--      output OPB_wrDBus       -- OPB write databus
--      output OPB_DBus         -- OPB databus
--      output OPB_errAck       -- OPB error acknowledge
--      output OPB_dwAck        -- OPB doubleword acknowledge
--      output OPB_dwXfer       -- OPB doubleword transfer
--      output OPB_fwAck        -- OPB fullword acknowledge
--      output OPB_fwXfer       -- OPB fullword transfer
--      output OPB_hwAck        -- OPB halfword acknowledge
--      output OPB_hwXfer       -- OPB halfword transfer
--      output OPB_MGrant       -- OPB master grant
--      output OPB_pendReq      -- OPB pending request
--      output OPB_retry        -- OPB retry
--      output OPB_RNW          -- OPB read/not write
--      output OPB_select       -- OPB select
--      output OPB_seqAddr      -- OPB sequential address
--      output OPB_timeout      -- OPB timeout
--      output OPB_toutSup      -- OPB timeout suppress
--      output OPB_xferAck      -- OPB transfer acknowledge
--
-- OPB V2.0 Specification exceptions:
-- 
--  1. DMA_SlnAck and Sln_dmaReq are not used.
--  2. Mn_UABus and OPB_UABus are not used since the address bus width is
--     a parameter.
--  3. M_DBusEn, M_DBusEn32_64, Sl_DBusEn, and Sl_DBusEn32_63 have no function
--     since we require all masters and slaves to drive zero if they are
--     inactive. All AND'ing with select, etc., is done in the master or slave
--     so that the AND is not required in the bus implementation.
--  4. The OPB_DBus has been split into two intermediate buses, OPB_wrDBus and
--     OPB_rdDBus, for more efficient implementation in FPGA. The OPB_DBus is
--     the OR of these two intermediate buses.
--  5. OPB_xferAck and OPB_retry MUST be asserted within 15 clock cycles
--     cycles (by the rising edge of the 16th clock) and OPB_toutSup must be
--     asserted by the rising edge of the 14th clock so that OPB_timeout
--     can be registered and FPGA timing is improved
-------------------------------------------------------------------------------

-----------------------------------------------------------------------------
-- Entity section
-----------------------------------------------------------------------------

entity opb_v20 is
  generic (
    -- Bus interconnect generics
    C_OPB_AWIDTH       : integer  := 32;
    C_OPB_DWIDTH       : integer  := 32;
    C_NUM_MASTERS      : integer  := 8;
    C_NUM_SLAVES       : integer  := 4;
    C_USE_LUT_OR       : integer  := 0;
    C_EXT_RESET_HIGH   : integer  := 1;
    -- Arbiter generics
    C_BASEADDR         : std_logic_vector := X"10000000";
    C_HIGHADDR         : std_logic_vector := X"100001FF";
    C_DYNAM_PRIORITY   : integer := 1;
    C_PARK             : integer := 1;
    C_PROC_INTRFCE     : integer := 1;
    C_REG_GRANTS       : integer := 1;
    C_DEV_BLK_ID       : integer := 0;
    C_DEV_MIR_ENABLE   : integer := 0
    );  
  port (
    -- Clock and reset
    SYS_Rst        : in  std_logic;
    Debug_SYS_Rst  : in  std_logic;
    WDT_Rst        : in  std_logic;
    OPB_Clk        : in  std_logic;
    OPB_Rst        : out std_logic;
  
    -- Master outputs
    M_ABus         : in  std_logic_vector(0 to C_OPB_AWIDTH*C_NUM_MASTERS-1)
                         := (others => '0');
    M_BE           : in  std_logic_vector(0 to 
                         (C_OPB_DWIDTH+7)/8*C_NUM_MASTERS-1) := (others => '0');
    M_beXfer       : in  std_logic_vector(0 to C_NUM_MASTERS-1)
                         := (others => '0');
    M_busLock      : in  std_logic_vector(0 to C_NUM_MASTERS-1)
                         := (others => '0');
    M_DBus         : in  std_logic_vector(0 to C_OPB_DWIDTH*C_NUM_MASTERS-1)
                         := (others => '0');
    M_DBusEn       : in  std_logic_vector(0 to C_NUM_MASTERS-1)
                         := (others => '1');
    M_DBusEn32_63  : in  std_logic_vector(0 to C_NUM_MASTERS-1)
                         := (others => '1');
    M_dwXfer       : in  std_logic_vector(0 to C_NUM_MASTERS-1)
                         := (others => '0');
    M_fwXfer       : in  std_logic_vector(0 to C_NUM_MASTERS-1)
                         := (others => '0');
    M_hwXfer       : in  std_logic_vector(0 to C_NUM_MASTERS-1)
                         := (others => '0');
    M_request      : in  std_logic_vector(0 to C_NUM_MASTERS-1)
                         := (others => '0');
    M_RNW          : in  std_logic_vector(0 to C_NUM_MASTERS-1)
                         := (others => '0');
    M_select       : in  std_logic_vector(0 to C_NUM_MASTERS-1)
                         := (others => '0');
    M_seqAddr      : in  std_logic_vector(0 to C_NUM_MASTERS-1)
                         := (others => '0');
  
    -- Slave outputs
    Sl_beAck       : in  std_logic_vector(0 to C_NUM_SLAVES-1)
                         := (others => '0');
    Sl_DBus        : in  std_logic_vector(0 to C_OPB_DWIDTH*
                                               C_NUM_SLAVES-1)
                         := (others => '0');
    Sl_DBusEn      : in  std_logic_vector(0 to C_NUM_SLAVES-1)
                         := (others => '1');
    Sl_DBusEn32_63 : in  std_logic_vector(0 to C_NUM_SLAVES-1)
                         := (others => '1');
    Sl_errAck      : in  std_logic_vector(0 to C_NUM_SLAVES-1)
                         := (others => '0');
    Sl_dwAck       : in  std_logic_vector(0 to C_NUM_SLAVES-1)
                         := (others => '0');
    Sl_fwAck       : in  std_logic_vector(0 to C_NUM_SLAVES-1)
                         := (others => '0');
    Sl_hwAck       : in  std_logic_vector(0 to C_NUM_SLAVES-1)
                         := (others => '0');
    Sl_retry       : in  std_logic_vector(0 to C_NUM_SLAVES-1)
                         := (others => '0');
    Sl_toutSup     : in  std_logic_vector(0 to C_NUM_SLAVES-1)
                         := (others => '0');
    Sl_xferAck     : in  std_logic_vector(0 to C_NUM_SLAVES-1)
                           := (others => '0');
        
    -- OPB outputs
    OPB_MRequest   : out std_logic_vector(0 to C_NUM_MASTERS-1);
    OPB_ABus       : out std_logic_vector(0 to C_OPB_AWIDTH-1);
    OPB_BE         : out std_logic_vector(0 to (C_OPB_DWIDTH+7)/8-1);
    OPB_beXfer     : out std_logic;
    OPB_beAck      : out std_logic;
    OPB_busLock    : out std_logic;
    OPB_rdDBus     : out std_logic_vector(0 to C_OPB_DWIDTH-1); -- extra
    OPB_wrDBus     : out std_logic_vector(0 to C_OPB_DWIDTH-1); -- extra
    OPB_DBus       : out std_logic_vector(0 to C_OPB_DWIDTH-1);
    OPB_errAck     : out std_logic;
    OPB_dwAck      : out std_logic;
    OPB_dwXfer     : out std_logic;
    OPB_fwAck      : out std_logic;
    OPB_fwXfer     : out std_logic;
    OPB_hwAck      : out std_logic;
    OPB_hwXfer     : out std_logic;
    OPB_MGrant     : out std_logic_vector(0 to C_NUM_MASTERS-1);
    OPB_pendReq    : out std_logic_vector(0 to C_NUM_MASTERS-1);
    OPB_retry      : out std_logic;
    OPB_RNW        : out std_logic;
    OPB_select     : out std_logic;
    OPB_seqAddr    : out std_logic;
    OPB_timeout    : out std_logic;
    OPB_toutSup    : out std_logic;
    OPB_xferAck    : out std_logic
    );
end entity opb_v20;

-----------------------------------------------------------------------------
-- Architecture section
-----------------------------------------------------------------------------

architecture imp of opb_v20 is
    
-----------------------------------------------------------------------------
-- Component declarations
-----------------------------------------------------------------------------

component or_gate is
  generic (
    C_OR_WIDTH   : natural range 1 to 32;
    C_BUS_WIDTH  : natural range 1 to 64;
    C_USE_LUT_OR : boolean := TRUE
    );
  port (
    A : in  std_logic_vector(0 to C_OR_WIDTH*C_BUS_WIDTH-1);
    Y : out std_logic_vector(0 to C_BUS_WIDTH-1)
    );
end component or_gate;
for all : or_gate use entity opb_arbiter_v1_02_e.or_gate(imp);

component SRL16 is
-- synthesis translate_off
  generic (
        INIT : bit_vector );
-- synthesis translate_on
  port (D    : in  std_logic;
        CLK  : in  std_logic;
        A0   : in  std_logic;
        A1   : in  std_logic;
        A2   : in  std_logic;
        A3   : in  std_logic;
        Q    : out std_logic); 
end component SRL16;

component FDS is
   port(
      Q : out std_logic;
      D : in  std_logic;
      C : in  std_logic;
      S : in  std_logic);
end component FDS;

component opb_arbiter is
  generic (
    C_BASEADDR       : std_logic_vector := X"10000000";
    C_HIGHADDR       : std_logic_vector := X"100001FF";
    C_NUM_MASTERS    : integer := 4;
    C_OPB_DWIDTH     : integer := 32;
    C_OPB_AWIDTH     : integer := 32;
    C_DYNAM_PRIORITY : integer := 0;
    C_PARK           : integer := 0;
    C_PROC_INTRFCE   : integer := 0;
    C_REG_GRANTS     : integer := 1;
    C_DEV_BLK_ID     : integer := 0;
    C_DEV_MIR_ENABLE : integer := 0
    );
  port (
    ARB_DBus         : out std_logic_vector(0 to C_OPB_DWIDTH-1);
    ARB_ErrAck       : out std_logic;
    ARB_Retry        : out std_logic;
    ARB_ToutSup      : out std_logic;
    ARB_XferAck      : out std_logic;
    OPB_Clk          : in std_logic;
    M_request        : in std_logic_vector(0 to C_NUM_MASTERS-1);
    OPB_Abus         : in std_logic_vector(0 to C_OPB_AWIDTH-1);
    OPB_BE           : in std_logic_vector(0 to C_OPB_DWIDTH/8-1);
    OPB_buslock      : in std_logic;
    OPB_Dbus         : in std_logic_vector(0 to C_OPB_DWIDTH-1);
    OPB_MGrant       : out std_logic_vector(0 to C_NUM_MASTERS-1);
    OPB_retry        : in std_logic;
    OPB_RNW          : in std_logic;
    OPB_select       : in std_logic;
    OPB_seqAddr      : in std_logic;
    OPB_timeout      : out std_logic;
    OPB_toutSup      : in std_logic;
    OPB_xferAck      : in std_logic;
    OPB_Rst          : in std_logic
    );
end component opb_arbiter;

-----------------------------------------------------------------------------
-- Function declarations
-----------------------------------------------------------------------------
function Integer_to_Boolean (x: integer) return boolean is
begin
  if x=0 then return false;
  else return true;
  end if;
end function Integer_to_Boolean;

-----------------------------------------------------------------------------
-- Constant declarations
-----------------------------------------------------------------------------
constant C_USE_LUT_OR_B : boolean := Integer_to_Boolean(C_USE_LUT_OR);
 
-----------------------------------------------------------------------------
-- Signal declarations
-----------------------------------------------------------------------------
signal arb_timeout     : std_logic := '0';
signal arb_mgrant      : std_logic_vector(0 to C_NUM_MASTERS-1);
signal arb_dbus        : std_logic_vector(0 to C_OPB_DWIDTH-1);
signal arb_errack      : std_logic;
signal arb_retry       : std_logic;
signal arb_toutsup     : std_logic;
signal arb_xferack     : std_logic;

signal opb_DBus_inputs : std_logic_vector(0 to 2*C_OPB_DWIDTH-1);
signal iOPB_wrDBus     : std_logic_vector(0 to C_OPB_DWIDTH-1);
signal iOPB_rdDBus     : std_logic_vector(0 to C_OPB_DWIDTH-1);

signal iOPB_beXfer     : std_logic_vector(0 to 0);
signal iOPB_beAck      : std_logic_vector(0 to 0);
signal iOPB_busLock    : std_logic_vector(0 to 0);
signal iOPB_errAck     : std_logic_vector(0 to 0);
signal iOPB_dwAck      : std_logic_vector(0 to 0);
signal iOPB_dwXfer     : std_logic_vector(0 to 0);
signal iOPB_fwAck      : std_logic_vector(0 to 0);
signal iOPB_fwXfer     : std_logic_vector(0 to 0);
signal iOPB_hwAck      : std_logic_vector(0 to 0);
signal iOPB_hwXfer     : std_logic_vector(0 to 0);
signal iOPB_retry      : std_logic_vector(0 to 0);
signal iOPB_RNW        : std_logic_vector(0 to 0);
signal iOPB_select     : std_logic_vector(0 to 0);
signal iOPB_seqAddr    : std_logic_vector(0 to 0);
signal iOPB_toutSup    : std_logic_vector(0 to 0);
signal iOPB_xferAck    : std_logic_vector(0 to 0);

signal iOPB_Rst        : std_logic;
signal iOPB_ABus       : std_logic_vector(0 to C_OPB_AWIDTH-1);
signal iOPB_BE         : std_logic_vector(0 to C_OPB_DWIDTH/8-1);
 
signal srl_time_out    : std_logic;
signal sys_rst_i       : std_logic;

-----------------------------------------------------------------------------
-- Attribute declarations
-----------------------------------------------------------------------------
attribute INIT : string;
attribute INIT of POR_SRL_I : label is "FFFF";

-----------------------------------------------------------------------------
-- Begin architecture
-----------------------------------------------------------------------------

begin  -- architecture imp

  --------------------------------------------------------------------------------
  -- Power On Reset to OPB
  --------------------------------------------------------------------------------

  SYS_RST_PROC: process (SYS_Rst,WDT_Rst,Debug_SYS_Rst) is
    variable sys_rst_input : std_logic;
  begin
    if C_EXT_RESET_HIGH = 0 then
      sys_rst_input := not SYS_Rst;
    else
      sys_rst_input := SYS_Rst;
    end if;
    sys_rst_i <= sys_rst_input or WDT_Rst or Debug_SYS_Rst;
  end process SYS_RST_PROC;
  
  POR_SRL_I: SRL16 
-- synthesis translate_off
    generic map (
      INIT => X"FFFF") 
-- synthesis translate_on
    port map (
      D   => '0',
      CLK => OPB_Clk,
      A0  => '1',
      A1  => '1',
      A2  => '1',
      A3  => '1',
      Q   => srl_time_out);
      
  POR_FF_I: FDS
    port map (
      Q   => iOPB_Rst,
      D   => srl_time_out,
      C   => OPB_Clk,
      S   => sys_rst_i);
      
  OPB_MRequest <= M_request; -- pass the Master request through
 
   OPB_ABus_I:   entity opb_arbiter_v1_02_e.or_gate generic map (C_NUM_MASTERS,C_OPB_AWIDTH,C_USE_LUT_OR_B) 
                          port    map (M_ABus,iOPB_ABus);
  OPB_BE_I:       entity opb_arbiter_v1_02_e.or_gate generic map (C_NUM_MASTERS,(C_OPB_DWIDTH+7)/8,
                                       C_USE_LUT_OR_B) 
                          port    map (M_BE,iOPB_BE);
  OPB_beXfer_I:   entity opb_arbiter_v1_02_e.or_gate generic map (C_NUM_MASTERS,1,C_USE_LUT_OR_B)
                          port    map (M_beXfer,iOPB_beXfer);
  OPB_busLock_I:  entity opb_arbiter_v1_02_e.or_gate generic map (C_NUM_MASTERS,1,C_USE_LUT_OR_B)
                          port    map (M_busLock,iOPB_busLock);
  
  -- The following two signals are not part of the V2.0 spec but are
  -- intermediate buses that are OR'ed to form OPB_DBus. They can be
  -- used in an implementation to optimize the master and slave OR
  -- functions by breaking up the OPB_DBus OR gate.
  
  OPB_wrDBus_I:   entity opb_arbiter_v1_02_e.or_gate generic map (C_NUM_MASTERS,C_OPB_DWIDTH,C_USE_LUT_OR_B)
                          port    map (M_DBus,iOPB_wrDBus);
  
  opb_DBus_inputs <= iOPB_wrDBus & iOPB_rdDBus;
  OPB_rdDBus <= iOPB_rdDBus;
  OPB_wrDBus <= iOPB_wrDBus;

  OPB_DBus_I:     entity opb_arbiter_v1_02_e.or_gate generic map (2,C_OPB_DWIDTH,C_USE_LUT_OR_B)
                          port    map (opb_DBus_inputs,OPB_DBus);
  OPB_dwXfer_I:   entity opb_arbiter_v1_02_e.or_gate generic map (C_NUM_MASTERS,1,C_USE_LUT_OR_B)
                          port    map (M_dwXfer,iOPB_dwXfer);
  OPB_fwXfer_I:   entity opb_arbiter_v1_02_e.or_gate generic map (C_NUM_MASTERS,1,C_USE_LUT_OR_B)
                          port    map (M_fwXfer,iOPB_fwXfer);
  OPB_hwXfer_I:   entity opb_arbiter_v1_02_e.or_gate generic map (C_NUM_MASTERS,1,C_USE_LUT_OR_B)
                          port    map (M_hwXfer,iOPB_hwXfer);
  
  OPB_MGrant <= arb_mgrant;
  
  -- OPB_pendReq is generated by OR'ing all master requests except
  -- a master's own request. It indicates to a master that one or
  -- more of the other masters attached to the bus is requesting
  -- access.
  
  MORE_THAN_ONE_MASTER_GEN: if C_NUM_MASTERS > 1 generate
    OPB_pendReq_GEN: for i in 0 to C_NUM_MASTERS-1 generate
      signal or_gate_input : std_logic_vector(0 to C_NUM_MASTERS-2);
    begin
      OR_ALL_BUT_SELF_PROCESS: process (M_request) is
        variable k : integer := 0; 
      begin
        for j in 0 to i-1 loop
          or_gate_input(j)   <= M_request(j);
        end loop;
        for j in i+1 to C_NUM_MASTERS-1 loop
          or_gate_input(j-1) <= M_request(j);
        end loop;
      end process OR_ALL_BUT_SELF_PROCESS;
      OPB_pendReq_I: entity opb_arbiter_v1_02_e.or_gate generic map (C_NUM_MASTERS-1,1,C_USE_LUT_OR_B)
                             port    map (or_gate_input,OPB_pendReq(i to i));
    end generate OPB_pendReq_GEN;
  end generate MORE_THAN_ONE_MASTER_GEN;
  
  ONLY_ONE_MASTER_GEN: if C_NUM_MASTERS = 1 generate
    OPB_pendReq(0) <= '0';
  end generate ONLY_ONE_MASTER_GEN;
  
  OPB_RNW_I:      entity opb_arbiter_v1_02_e.or_gate generic map (C_NUM_MASTERS,1,C_USE_LUT_OR_B)
                          port    map (M_RNW,iOPB_RNW);
  OPB_select_I:   entity opb_arbiter_v1_02_e.or_gate generic map (C_NUM_MASTERS,1,C_USE_LUT_OR_B)
                          port    map (M_select,iOPB_select);
  OPB_seqAddr_I:  entity opb_arbiter_v1_02_e.or_gate generic map (C_NUM_MASTERS,1,C_USE_LUT_OR_B)
                          port    map (M_seqAddr,iOPB_seqAddr);
  OPB_hwAck_I:    entity opb_arbiter_v1_02_e.or_gate generic map (C_NUM_SLAVES,1,C_USE_LUT_OR_B)
                          port    map (Sl_hwAck,iOPB_hwAck);
  OPB_fwAck_I:    entity opb_arbiter_v1_02_e.or_gate generic map (C_NUM_SLAVES,1,C_USE_LUT_OR_B)
                          port    map (Sl_fwAck,iOPB_fwAck);
  OPB_dwAck_I:    entity opb_arbiter_v1_02_e.or_gate generic map (C_NUM_SLAVES,1,C_USE_LUT_OR_B)
                          port    map (Sl_dwAck,iOPB_dwAck);
  OPB_beAck_I:    entity opb_arbiter_v1_02_e.or_gate generic map (C_NUM_SLAVES,1,C_USE_LUT_OR_B)
                          port    map (Sl_beAck,iOPB_beAck);
  
  OPB_timeout <= Arb_timeout; -- pass the Timeout through
  
  --------------------------------------------------------------------------------
  -- The following signals must be generated conditionally based on the
  -- state of C_PROC_INTRFCE
  --------------------------------------------------------------------------------

  ARBITER_HAS_PROC_INTF: if C_PROC_INTRFCE /= 0 generate  
    signal sl_plus_arb_dbus    : std_logic_vector(0 to ((C_NUM_SLAVES+1)*C_OPB_DWIDTH)-1);
    signal sl_plus_arb_errack  : std_logic_vector(0 to C_NUM_SLAVES);
    signal sl_plus_arb_retry   : std_logic_vector(0 to C_NUM_SLAVES);
    signal sl_plus_arb_toutsup : std_logic_vector(0 to C_NUM_SLAVES);
    signal sl_plus_arb_xferack : std_logic_vector(0 to C_NUM_SLAVES);
  begin
    sl_plus_arb_dbus     <=  Sl_DBus    & arb_dbus;
    sl_plus_arb_errack   <=  Sl_errAck  & arb_errack;
    sl_plus_arb_retry    <=  Sl_retry   & arb_retry;
    sl_plus_arb_toutsup  <=  Sl_toutSup & arb_toutsup;
    sl_plus_arb_xferack  <=  Sl_xferAck & arb_xferack;
  
    OPB_toutSup_I:  entity opb_arbiter_v1_02_e.or_gate generic map (C_NUM_SLAVES+1,1,C_USE_LUT_OR_B)
                            port    map (sl_plus_arb_toutsup,iOPB_toutSup);
    OPB_xferAck_I:  entity opb_arbiter_v1_02_e.or_gate generic map (C_NUM_SLAVES+1,1,C_USE_LUT_OR_B)
                            port    map (sl_plus_arb_xferack,iOPB_xferAck);
    OPB_retry_I:    entity opb_arbiter_v1_02_e.or_gate generic map (C_NUM_SLAVES+1,1,C_USE_LUT_OR_B)
                            port    map (sl_plus_arb_retry,iOPB_retry);
    OPB_errAck_I:   entity opb_arbiter_v1_02_e.or_gate generic map (C_NUM_SLAVES+1,1,C_USE_LUT_OR_B)
                            port    map (sl_plus_arb_errack,iOPB_errAck);
    OPB_rdDBus_I:   entity opb_arbiter_v1_02_e.or_gate generic map (C_NUM_SLAVES+1,C_OPB_DWIDTH,C_USE_LUT_OR_B)
                            port    map (sl_plus_arb_dbus,iOPB_rdDBus);  
  end generate ARBITER_HAS_PROC_INTF;
  
  ARBITER_HAS_NO_PROC_INTF: if C_PROC_INTRFCE = 0 generate
  begin
    OPB_toutSup_I:  entity opb_arbiter_v1_02_e.or_gate generic map (C_NUM_SLAVES,1,C_USE_LUT_OR_B)
                            port    map (Sl_toutSup,iOPB_toutSup);
    OPB_xferAck_I:  entity opb_arbiter_v1_02_e.or_gate generic map (C_NUM_SLAVES,1,C_USE_LUT_OR_B)
                            port    map (Sl_xferAck,iOPB_xferAck);
    OPB_retry_I:    entity opb_arbiter_v1_02_e.or_gate generic map (C_NUM_SLAVES,1,C_USE_LUT_OR_B)
                            port    map (Sl_retry,iOPB_retry);
    OPB_errAck_I:   entity opb_arbiter_v1_02_e.or_gate generic map (C_NUM_SLAVES,1,C_USE_LUT_OR_B)
                            port    map (Sl_errAck,iOPB_errAck);
    OPB_rdDBus_I:   entity opb_arbiter_v1_02_e.or_gate generic map (C_NUM_SLAVES,C_OPB_DWIDTH,C_USE_LUT_OR_B)
                            port    map (Sl_DBus,iOPB_rdDBus);    
  end generate ARBITER_HAS_NO_PROC_INTF;

  OPB_beXfer  <= iOPB_beXfer(0); 
  OPB_beAck   <= iOPB_beAck(0);  
  OPB_busLock <= iOPB_busLock(0);
  OPB_errAck  <= iOPB_errAck(0); 
  OPB_dwAck   <= iOPB_dwAck(0);  
  OPB_dwXfer  <= iOPB_dwXfer(0); 
  OPB_fwAck   <= iOPB_fwAck(0);  
  OPB_fwXfer  <= iOPB_fwXfer(0); 
  OPB_hwAck   <= iOPB_hwAck(0);  
  OPB_hwXfer  <= iOPB_hwXfer(0); 
  OPB_retry   <= iOPB_retry(0);  
  OPB_RNW     <= iOPB_RNW(0);    
  OPB_select  <= iOPB_select(0); 
  OPB_seqAddr <= iOPB_seqAddr(0);
  OPB_toutSup <= iOPB_toutSup(0);
  OPB_xferAck <= iOPB_xferAck(0);
  
  OPB_Rst     <= iOPB_Rst; 
  OPB_ABus    <= iOPB_ABus;
  OPB_BE      <= iOPB_BE; 

  OPB_ARBITER_I : entity opb_arbiter_v1_02_e.opb_arbiter
    generic map (
      C_BASEADDR       => C_BASEADDR,
      C_HIGHADDR       => C_HIGHADDR,
      C_NUM_MASTERS    => C_NUM_MASTERS,
      C_OPB_DWIDTH     => C_OPB_DWIDTH,
      C_OPB_AWIDTH     => C_OPB_AWIDTH,
      C_DYNAM_PRIORITY => C_DYNAM_PRIORITY,
      C_REG_GRANTS     => C_REG_GRANTS,
      C_PARK           => C_PARK,
      C_PROC_INTRFCE   => C_PROC_INTRFCE,
      C_DEV_BLK_ID     => C_DEV_BLK_ID,
      C_DEV_MIR_ENABLE => C_DEV_MIR_ENABLE)
    port map (
      ARB_DBus         => arb_dbus,
      ARB_ErrAck       => arb_errack,
      ARB_Retry        => arb_retry,
      ARB_ToutSup      => arb_toutsup,
      ARB_XferAck      => arb_xferack,
      OPB_Clk          => OPB_clk,
      M_request        => M_request,
      OPB_Abus         => iOPB_ABus,
      OPB_BE           => iOPB_BE,
      OPB_buslock      => iOPB_busLock(0),
      OPB_Dbus         => iOPB_wrDBus,
      OPB_MGrant       => arb_mgrant,
      OPB_retry        => iOPB_retry(0),
      OPB_RNW          => iOPB_rnw(0),
      OPB_select       => iOPB_select(0),
      OPB_seqAddr      => iOPB_seqaddr(0),
      OPB_timeout      => arb_timeout,
      OPB_toutSup      => iOPB_toutsup(0),
      OPB_xferAck      => iOPB_xferack(0),
      OPB_Rst          => iOPB_Rst);
      
end architecture imp;

