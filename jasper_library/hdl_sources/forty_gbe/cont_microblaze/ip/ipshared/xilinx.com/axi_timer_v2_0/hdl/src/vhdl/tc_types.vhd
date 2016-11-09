-------------------------------------------------------------------------------
-- TC_TYPES - package
-------------------------------------------------------------------------------
--
-- ***************************************************************************
-- DISCLAIMER OF LIABILITY
--
-- This file contains proprietary and confidential information of
-- Xilinx, Inc. ("Xilinx"), that is distributed under a license
-- from Xilinx, and may be used, copied and/or disclosed only
-- pursuant to the terms of a valid license agreement with Xilinx.
--
-- XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION
-- ("MATERIALS") "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
-- EXPRESSED, IMPLIED, OR STATUTORY, INCLUDING WITHOUT
-- LIMITATION, ANY WARRANTY WITH RESPECT TO NONINFRINGEMENT,
-- MERCHANTABILITY OR FITNESS FOR ANY PARTICULAR PURPOSE. Xilinx
-- does not warrant that functions included in the Materials will
-- meet the requirements of Licensee, or that the operation of the
-- Materials will be uninterrupted or error-free, or that defects
-- in the Materials will be corrected. Furthermore, Xilinx does
-- not warrant or make any representations regarding use, or the
-- results of the use, of the Materials in terms of correctness,
-- accuracy, reliability or otherwise.
--
-- Xilinx products are not designed or intended to be fail-safe,
-- or for use in any application requiring fail-safe performance,
-- such as life-support or safety devices or systems, Class III
-- medical devices, nuclear facilities, applications related to
-- the deployment of airbags, or any other applications that could
-- lead to death, personal injury or severe property or
-- environmental damage (individually and collectively, "critical
-- applications"). Customer assumes the sole risk and liability
-- of any use of Xilinx products in critical applications,
-- subject only to applicable laws and regulations governing
-- limitations on product liability.
--
-- Copyright 2001, 2002, 2003, 2004, 2008, 2009 Xilinx, Inc.
-- All rights reserved.
--
-- This disclaimer and copyright notice must be retained as part
-- of this file at all times.
-- ***************************************************************************
--
-------------------------------------------------------------------------------
-- Filename        :tc_types.vhd
-- Company         :Xilinx
-- Version         :v2.0
-- Description     :Type definitions for Timer/Counter
-- Standard        :VHDL-93
--
-------------------------------------------------------------------------------
-- Structure:
--
--              tc_types.vhd
-------------------------------------------------------------------------------
-- ^^^^^^
-- Author:      BSB
-- History:
--  BSB         03/18/2010      -- Ceated the version  v1.00.a
-- ^^^^^^
-- Author:      BSB
-- History:
--  BSB         09/18/2010      -- Ceated the version  v1.01.a
--                              -- axi lite ipif v1.01.a used
-- ^^^
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
library IEEE;
use IEEE.std_logic_1164.all;

-------------------------------------------------------------------------------
--Package Declaration
-------------------------------------------------------------------------------
package TC_Types is

  subtype  QUADLET_TYPE             is std_logic_vector(0 to 31);
  subtype  ELEVEN_BIT_TYPE          is std_logic_vector(21 to 31);
  subtype  TWELVE_BIT_TYPE          is std_logic_vector(20 to 31);
  subtype  QUADLET_PLUS1_TYPE       is std_logic_vector(0 to 32);
  subtype  BYTE_TYPE                is std_logic_vector(0 to 7);
  subtype  ALU_OP_TYPE              is std_logic_vector(0 to 1);
  subtype  ADDR_WORD_TYPE           is std_logic_vector(0 to 31);
  subtype  BYTE_ENABLE_TYPE         is std_logic_vector(0 to 3);
  subtype  DATA_WORD_TYPE           is QUADLET_TYPE;
  subtype  INSTRUCTION_WORD_TYPE    is QUADLET_TYPE;

  -- Bus interface data types
  subtype  PLB_DWIDTH_TYPE          is QUADLET_TYPE;
  subtype  PLB_AWIDTH_TYPE          is QUADLET_TYPE;
  subtype  PLB_BEWIDTH_TYPE         is std_logic_vector(0 to 3);
  subtype  BYTE_PLUS1_TYPE          is std_logic_vector(0 to 8);
  subtype  NIBBLE_TYPE              is std_logic_vector(0 to 3);
  type     TWO_QUADLET_TYPE         is array (0 to 1) of QUADLET_TYPE;

  constant CASC_POS     : integer := 20;
  constant ENALL_POS    : integer := 21;
  constant PWMA0_POS    : integer := 22;
  constant T0INT_POS    : integer := 23;
  constant ENT0_POS     : integer := 24;
  constant ENIT0_POS    : integer := 25;
  constant LOAD0_POS    : integer := 26;
  constant ARHT0_POS    : integer := 27;
  constant CAPT0_POS    : integer := 28;
  constant CMPT0_POS    : integer := 29;
  constant UDT0_POS     : integer := 30;
  constant MDT0_POS     : integer := 31;

  constant PWMB0_POS    : integer := 22;
  constant T1INT_POS    : integer := 23;
  constant ENT1_POS     : integer := 24;
  constant ENIT1_POS    : integer := 25;
  constant LOAD1_POS    : integer := 26;
  constant ARHT1_POS    : integer := 27;
  constant CAPT1_POS    : integer := 28;
  constant CMPT1_POS    : integer := 29;
  constant UDT1_POS     : integer := 30;
  constant MDT1_POS     : integer := 31;

  constant LS_ADDR      : std_logic_vector(0 to 1) := "11";

  constant NEXT_MSB_BIT : integer := -1;
  constant NEXT_LSB_BIT : integer := 1;

  -- The following four constants arer reversed from what's
  -- in microblaze_isa_be_pkg.vhd
  constant BYTE_ENABLE_BYTE_0 : natural := 0;
  constant BYTE_ENABLE_BYTE_1 : natural := 1;
  constant BYTE_ENABLE_BYTE_2 : natural := 2;
  constant BYTE_ENABLE_BYTE_3 : natural := 3;

end package TC_TYPES;
