-------------------------------------------------------------------------------
-- $Id: ipif_regonly_slave.vhd,v 1.2 2005/07/21 19:15:21 gburch Exp $
-------------------------------------------------------------------------------
-- ipif_regonly_slave.vhd - entity/architecture pair 
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
-- Filename:        ipif_regonly_slave.vhd
-- Version:         v1.02e 
-- Description:     This file provides the OPB Slave interface to the arbiter
--                  registers. Note that if the parameter, C_PROC_INTRFCE is
--                  false, this logic is not instantiated.
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
--
--  ALS         08/30/01
-- ^^^^^^
--  Updated IPIF component instantiation to change VERTEXII to VIRTEXII.
-- ~~~~~~
--
--  ALS         10/04/01        -- Version 1.02a creation to include IPIF v1.23a
--
--  ALS         10/08/01
-- ^^^^^^
--  Updated IPIF library to opb_ipif_v1_23_a
-- ~~~~~~
--
--  ALS         10/12/01
-- ^^^^^^
--  The width of the IPIF address bus is now set to 9 by the constant 
--  IPIF_ABUS_WIDTH which is defined in opb_arb_pkg.
-- ~~~~~~
--  
--  ALS         10/16/01
-- ^^^^^^
--  Updated component instantiation of IPIF.
-- ~~~~~~
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
--  GAB         07/05/05
-- ^^^^^^
--  Fixed XST issue with adding an integer to a std_logic_vector.  This
--  fixes CR211277.
--  Removed library ieee.std_logic_unsigned and ieee.std_logic_arith
--  Added library ieee.numeric_std
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
use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;      -- Removed (GAB)
use ieee.numeric_std.all;               -- Added (GAB)

-- opb_arb_pkg defines RESET_ACTIVE and IPIF_ABUS_WIDTH
library opb_arbiter_v1_02_e;
use opb_arbiter_v1_02_e.opb_arb_pkg.all;


library opb_ipif_v3_01_a;
use opb_ipif_v3_01_a.all;

library proc_common_v2_00_a;
use proc_common_v2_00_a.ipif_pkg.all;


--library ieee;                         -- Removed (GAB)
--use ieee.STD_LOGIC_ARITH.all;         -- Removed (GAB)


-------------------------------------------------------------------------------
-- Port Declaration
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Definition of Generics:
--      C_OPB_ABUS_WIDTH        -- width of OPB address bus
--      C_OPB_DBUS_WIDTH        -- width of OPB data bus
--      C_BASEADDR              -- OPB Arbiter base address
--      C_NUM_MASTERS           -- number of OPB masters
--      C_NUM_MID_BITS          -- number of bits to encode master id
--      C_DEV_BLK_ID            -- device block id
--      C_DEV_MIR_ENABLE        -- IPIF mirror capability enable
--      C_DEV_ADDR_DECODE_WIDTH -- width of device address
--
-- Definition of Ports:
--         
--      Bus2IP_Data             -- OPB data to processor bus
--      Bus2IP_Reg_RdCE         -- read register clock enables
--      Bus2IP_Reg_WrCE         -- write register clock enables
--      Bus2IP_Clk              -- clock
--      Bus2IP_Reset            -- reset
--      IP2Bus_Data             -- IP data to processor bus
--      IP2Bus_RdAck            -- IP read acknowledge
--      IP2Bus_WrAck            -- IP write acknowledge
--      OPB_ABus                -- OPB address bus
--      OPB_BE                  -- OPB byte enables
--      OPB_Clk                 -- OPB clock
--      OPB_DBus                -- OPB data bus
--      OPB_RNW                 -- Read not Write
--      OPB_Select              -- Master has control of bus
--      OPB_seqAddr             -- Sequential Address
--      Rst                     -- Reset
--      Sln_DBus                -- Slave data bus
--      Sln_ErrAck              -- Slave error acknowledge
--      Sln_Retry               -- Slave retry
--      Sln_ToutSup             -- Slave timeout suppress
--      Sln_XferAck             -- Slave transfer acknowledge
--
-------------------------------------------------------------------------------


-----------------------------------------------------------------------------
-- Entity section
-----------------------------------------------------------------------------
entity ipif_regonly_slave is
    generic (
             C_OPB_ABUS_WIDTH           : integer := 32;
             C_OPB_DBUS_WIDTH           : integer := 32;
             C_BASEADDR                 : std_logic_vector;
             C_NUM_MASTERS              : integer := 4;
             C_NUM_MID_BITS             : integer := 2;
             C_DEV_BLK_ID               : integer :=0;
             C_DEV_MIR_ENABLE           : integer := 0;
             C_DEV_ADDR_DECODE_WIDTH    : integer := 4
             );
    port (
          Bus2IP_Data       : out std_logic_vector(0 to C_OPB_DBUS_WIDTH - 1 );
          Bus2IP_Reg_RdCE   : out std_logic_vector(0 to C_NUM_MASTERS );
          Bus2IP_Reg_WrCE   : out std_logic_vector(0 to C_NUM_MASTERS );
          Bus2IP_Clk        : out std_logic;
          Bus2IP_Reset      : out std_logic;
          IP2Bus_Data       : in std_logic_vector(0 to C_OPB_DBUS_WIDTH - 1 );
          IP2Bus_RdAck      : in std_logic;
          IP2Bus_WrAck      : in std_logic;
          OPB_ABus          : in std_logic_vector(0 to C_OPB_ABUS_WIDTH - 1 );
          OPB_BE            : in std_logic_vector(0 to C_OPB_DBUS_WIDTH / 8 - 1 );
          OPB_Clk           : in std_logic;
          OPB_DBus          : in std_logic_vector(0 to C_OPB_DBUS_WIDTH - 1 );
          OPB_RNW           : in std_logic;
          OPB_Select        : in std_logic;
          OPB_seqAddr       : in std_logic;
          Rst               : in std_logic;
          Sln_DBus          : out std_logic_vector(0 to C_OPB_DBUS_WIDTH - 1 );
          Sln_ErrAck        : out std_logic;
          Sln_Retry         : out std_logic;
          Sln_ToutSup       : out std_logic;
          Sln_XferAck       : out std_logic
          ); 
end ipif_regonly_slave;
 
-----------------------------------------------------------------------------
-- Architecture section
-----------------------------------------------------------------------------
architecture implementation of ipif_regonly_slave is

-----------------------------------------------------------------------------
-- Begin architecture
-----------------------------------------------------------------------------

constant ZEROES              :  std_logic_vector := X"00000000";

constant ARD_ID_ARRAY : INTEGER_ARRAY_TYPE :=
        (
         0 => USER_00        -- OPB_V20 priority registers
         );

constant REG_BASEADDR    : std_logic_vector := C_BASEADDR or x"00000100"; 

-- Fixed XST issue with adding an integer to a std_logic_vetor (GAB)
--constant REG_HIGHADDR    : std_logic_vector := C_BASEADDR + x"00000100" + C_NUM_MASTERS*4; 
constant REG_HIGHADDR    : std_logic_vector := REG_BASEADDR or
                                               (std_logic_vector(to_unsigned(
                                               C_NUM_MASTERS*4,32))); 

constant ARD_ADDR_RANGE_ARRAY  : SLV64_ARRAY_TYPE :=
       (
        ZEROES & REG_BASEADDR,        -- registers Base Address
        ZEROES & REG_HIGHADDR         -- registers High Address
       );

constant ARD_DWIDTH_ARRAY     : INTEGER_ARRAY_TYPE :=
        (
         0 => C_OPB_DBUS_WIDTH    --  User Logic data width
        );

constant ARD_NUM_CE_ARRAY   : INTEGER_ARRAY_TYPE :=
        (
         0 => C_NUM_MASTERS + 1   --  register CEs
       );

constant ARD_DEPENDENT_PROPS_ARRAY : DEPENDENT_PROPS_ARRAY_TYPE := 
        (
     0 => (others => 0)
        );

-- Set the pipeline model
-- 1 = include OPB-In pipeline registers
-- 2 = include IP pipeline registers
-- 3 = include OPB-In and IP pipeline registers
-- 4 = include OPB-Out pipeline registers
-- 5 = include OPB-In and OPB-Out pipeline registers
-- 6 = include IP and OPB-Out pipeline registers
-- 7 = include OPB-In, IP, and OPB-Out pipeline registers
constant PIPELINE_MODEL         : integer := 6; 

-- Include IP interrupts, don't need Device ISC or IID
constant IP_INTR_MODE_ARRAY     : integer_array_type := 
         populate_intr_mode_array(1, 0);       

-- No bursting
constant DEV_BURST_ENABLE       : integer := 0;

-- Index for user logic
constant USER00_CS_INDEX     : integer := 
                                get_id_index(ARD_ID_ARRAY, USER_00);

-------------------------------------------------------------------------------
-- Signal and Type Declarations
-------------------------------------------------------------------------------
-- IPIC Used Signals
signal iP2Bus_IntrEvent    :std_logic_vector(0 to IP_INTR_MODE_ARRAY'length-1) := (others => '0');
signal iP2Bus_Ack : std_logic;
signal iP2Bus_PostedWrInh_vec :std_logic_vector(0 to ARD_ID_ARRAY'length-1)
                                := (others => '1');
signal bus2IP_CS_vec   :std_logic_vector(0 to ARD_ID_ARRAY'length-1);
signal bus2IP_RdCE_vec :std_logic_vector(0 to calc_num_ce(ARD_NUM_CE_ARRAY)-1);
signal bus2IP_WrCE_vec :std_logic_vector(0 to calc_num_ce(ARD_NUM_CE_ARRAY)-1);
--------------------------------------------------------------------------------
begin  
--------------------------------------------------------------------------------
-- assign IP inputs/output to correct vector value

  iP2Bus_Ack <= IP2Bus_RdAck or IP2Bus_WrAck ;
  iP2Bus_PostedWrInh_vec(USER00_CS_INDEX) <= '1';
  Bus2IP_Reg_RdCE          <= bus2IP_RdCE_vec;
  Bus2IP_Reg_WrCE          <= bus2IP_WrCE_vec;

-- instantiate the OPB IPIF
  OPB_IPIF_I : entity opb_ipif_v3_01_a.opb_ipif
    
    generic map
           (
              C_ARD_ID_ARRAY              => ARD_ID_ARRAY,
              C_ARD_ADDR_RANGE_ARRAY      => ARD_ADDR_RANGE_ARRAY,
              C_ARD_DWIDTH_ARRAY          => ARD_DWIDTH_ARRAY,
              C_ARD_NUM_CE_ARRAY          => ARD_NUM_CE_ARRAY,
              C_ARD_DEPENDENT_PROPS_ARRAY => ARD_DEPENDENT_PROPS_ARRAY,
              C_PIPELINE_MODEL            => PIPELINE_MODEL,
              C_DEV_BLK_ID                => C_DEV_BLK_ID,
              C_DEV_MIR_ENABLE            => C_DEV_MIR_ENABLE,
              C_OPB_AWIDTH                => C_OPB_ABUS_WIDTH,
              C_OPB_DWIDTH                => C_OPB_DBUS_WIDTH,
              C_FAMILY                    => "virtex2",
              C_IP_INTR_MODE_ARRAY        => IP_INTR_MODE_ARRAY,
              C_DEV_BURST_ENABLE          => DEV_BURST_ENABLE,
              C_INCLUDE_ADDR_CNTR         => 0,
              C_INCLUDE_WR_BUF            => 0
        )
    
    port map
        (
        -- OPB signals
          OPB_select          => OPB_select,
          OPB_DBus            => OPB_DBus,
          OPB_ABus            => OPB_ABus,
          OPB_BE              => OPB_BE,
          OPB_RNW             => OPB_RNW,
          OPB_seqAddr         => OPB_seqAddr,
          Sln_DBus            => Sln_DBus,
          Sln_xferAck         => Sln_XferAck,
          Sln_errAck          => Sln_ErrAck,
          Sln_retry           => Sln_Retry,
          Sln_toutSup         => Sln_ToutSup,
  
        
        -- IPIC signals (address, data, acknowledge)
          Bus2IP_CS           => bus2IP_CS_vec,
          Bus2IP_CE           => open,
          Bus2IP_RdCE         => bus2IP_RdCE_vec,
          Bus2IP_WrCE         => bus2IP_WrCE_vec,
          Bus2IP_Data         => Bus2IP_Data,
          Bus2IP_Addr         => open,
          Bus2IP_AddrValid    => open,
          Bus2IP_BE           => open,
          Bus2IP_RNW          => open,
          Bus2IP_Burst        => open,
          IP2Bus_Data         => IP2Bus_Data,
          IP2Bus_Ack          => iP2Bus_Ack,
          IP2Bus_AddrAck      => '0',     -- new signal
          IP2Bus_Error        => '0',
          IP2Bus_Retry        => '0',
          IP2Bus_ToutSup      => '0',
          IP2Bus_PostedWrInh  => iP2Bus_PostedWrInh_vec,
      
        -- IPIC signals (Read Packet FIFO)
          IP2RFIFO_Data       => open,
          IP2RFIFO_WrMark     => open,
          IP2RFIFO_WrRelease  => open,
          IP2RFIFO_WrReq      => open,
          IP2RFIFO_WrRestore  => open,
          RFIFO2IP_AlmostFull => open,  
          RFIFO2IP_Full       => open,   
          RFIFO2IP_Vacancy    => open,
          RFIFO2IP_WrAck      => open,
    
        -- IPIC signals (Write Packet FIFO)
          IP2WFIFO_RdMark     => '0',
          IP2WFIFO_RdRelease  => '0',
          IP2WFIFO_RdReq      => '0',
          IP2WFIFO_RdRestore  => '0',
          WFIFO2IP_AlmostEmpty=> open,
          WFIFO2IP_Data       => open,
          WFIFO2IP_Empty      => open,
          WFIFO2IP_Occupancy  => open,
          WFIFO2IP_RdAck      => open,
  
        -- interrupts
          IP2Bus_IntrEvent    => iP2Bus_IntrEvent,
          IP2INTC_Irpt        => open,
    
    
        -- Software test breakpoint signal
          Freeze              => '0',
          Bus2IP_Freeze       => open,
   
        -- clocks and reset     
          OPB_Clk             => OPB_Clk,
          Bus2IP_Clk          => Bus2IP_Clk,
          IP2Bus_Clk          => '0',
          Reset               => Rst,
          Bus2IP_Reset        => Bus2IP_Reset
        );

 end implementation;                                     

