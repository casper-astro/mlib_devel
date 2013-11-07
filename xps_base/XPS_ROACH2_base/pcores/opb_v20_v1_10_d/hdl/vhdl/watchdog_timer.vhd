-------------------------------------------------------------------------------
-- $Id: watchdog_timer.vhd,v 1.1.2.1 2009/10/06 21:15:02 gburch Exp $
-------------------------------------------------------------------------------
-- watchdog_timer.vhd - entity/architecture pair
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
-- Filename:        watchdog_timer.vhd
-- Version:         v1.02e
-- Description:
--                  This file contains the watchdog timer and generates the
--                  OPB_timeout signal if OPB_retry, OPB_xferAck, or
--                  OPB_toutSup are not asserted within 15 clock cycles after
--                  OPB_select is asserted.
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
--  Registered Opb_timeout, therefore OPB_XferAck, OPB_Retry, and OPB_toutSup MUST
--  be asserted in 15 clocks instead of 16
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
use ieee.STD_LOGIC_ARITH.all;

--Package file that contains constant definition for RESET_ACTIVE
--and OPB_TIMEOUT_CNT
library opb_v20_v1_10_d;
use opb_v20_v1_10_d.opb_arb_pkg.all;

-------------------------------------------------------------------------------
-- Port Declaration
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Definition of Generics:
--          No Generics were used for this Entity
--
--      --  OPB Interface Signals
--      input OPB_select;               --  master select
--      input OPB_xferAck;              --  slave transfer acknowledge
--      input OPB_retry;                --  slave retry
--      input OPB_toutSup;              --  slave timeout suppress
--      output OPB_timeout;             --  timeout asserted OPB_TIMEOUT_CNT
--                                      --  clocks after OPB_select asserts
--      --  Clock and Reset
--      input Clk;
--      input Rst;
-------------------------------------------------------------------------------
-----------------------------------------------------------------------------
-- Entity section
-----------------------------------------------------------------------------
entity watchdog_timer is
  port (
        OPB_select  : in std_logic;
        OPB_xferAck : in std_logic;
        OPB_retry   : in std_logic;
        OPB_toutSup : in std_logic;
        OPB_timeout : out std_logic;
        Clk         : in std_logic;
        Rst         : in std_logic
        );

end watchdog_timer;


-----------------------------------------------------------------------------
-- Architecture section
-----------------------------------------------------------------------------
architecture implementation of watchdog_timer is

-------------------------------------------------------------------------------
--  Constant Declarations
-------------------------------------------------------------------------------
-- Constants used in this design are found in opb_arbiter_pkg.vhd

-------------------------------------------------------------------------------
-- Signal and Type Declarations
-------------------------------------------------------------------------------

  signal timeout_cnt : unsigned(0 to 3 );   -- output from counter


-----------------------------------------------------------------------------
-- Begin architecture
-----------------------------------------------------------------------------
begin

-------------------------------------------------------------------------------
-- WATCHDOG_TIMER_PROCESS
-------------------------------------------------------------------------------
-- This process counts clocks after OPB_select is asserted while OPB_xferAck
-- and OPB_retry are negated. The assertion of OPB_toutSup suspends the counter.
-------------------------------------------------------------------------------

  WATCHDOG_TIMER_PROCESS:process (Clk, Rst, OPB_select, OPB_retry, OPB_xferAck,
                                  OPB_toutSup, timeout_cnt)
  begin
    if Clk'event and Clk = '1' then
      --  active high, synchronous reset
      if Rst = RESET_ACTIVE then
        timeout_cnt <= (others => '0');
      elsif OPB_select = '1' and OPB_retry = '0' and OPB_xferAck = '0' then
      --  Enable timeout counter once OPB_select asserts
      --  and OPB_retry and OPB_xferAck are negated.
      --  Reset counter if either OPB_retry or
      --  OPB_xferAck assert while OPB_select
      --  is asserted
        if OPB_toutSup = '0' then
          timeout_cnt <= timeout_cnt + 1;
        else
          timeout_cnt <= timeout_cnt;
        end if;
      else
        timeout_cnt <= (others => '0');
      end if;
    end if;
  end process;

-------------------------------------------------------------------------------
-- TIMEOUT_PROCESS
-------------------------------------------------------------------------------
-- This process asserts the OPB_timeout signal when the output of the watchdog
-- timer is OPB_TIMEOUTCNT-2 (0-14=15 clocks) and OPB_toutSup is negated.
-- OPB_timeout is registered to improve FPGA implementation timing
-------------------------------------------------------------------------------

  TIMEOUT_PROCESS:process (Clk,Rst)
  begin   -- process
    --  Assert OPB_timeout OPB_TIMEOUT_CNT-2 clocks
    --  after OPB_select asserts if OPB_toutSup is negated
    if Clk'event and Clk = '1' then
        if Rst = RESET_ACTIVE then
            OPB_Timeout <= '0';
        elsif timeout_cnt = OPB_TIMEOUT_CNT -2 and OPB_toutSup = '0' and
             OPB_select = '1' and OPB_retry = '0' and OPB_xferAck = '0'then
            OPB_timeout <= '1';
        else
            OPB_timeout <= '0';
        end if;
    end if;
  end process;

end implementation;
