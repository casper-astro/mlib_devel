-------------------------------------------------------------------------------
-- $Id: control_register_logic.vhd,v 1.1 2004/11/05 11:20:51 bommanas Exp $
-------------------------------------------------------------------------------
-- control_register_logic.vhd - entity/architecture pair
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
-- Filename:        control_register_logic.vhd
-- Version:         v1.02e
-- Description:     
--       This file contains the control register. The bits of this 
--       register determine whether dynamic priority is enabled and 
--       how parking (if enabled) is accomplished. This register is 
--       written from the OPB. The bit definitions are as follows:
--
--   BIT                DESCRIPTION                  RESET VALUE
--   ----               ---------------------       -------------------
--   0                  Dynamic Priority Enable         0 (DYNAM_PRIORITY=false)
--                                                      1 (DYNAM_PRIORITY=true)
--   1                  Dynamic Priority R/W access     0 (DYNAM_PRIORITY=false)
--                                                      1 (DYNAM_PRIORITY=true)
--   2                  Park Enable                     0 (PARK=false)
--                                                      1 (PARK=true)
--   3                  Park Enable R/W access          0 (PARK=false)
--                                                      1 (PARK=true)
--   4                  Park Master Not Last            0
--   5                  Priority Registers Valid        1
--   6:C_NUM_MID_BITS   Reserved                 
--   C_NUM_MID_BITS:C_OPBDATA_WIDTH-1   Park MasterID   Master 0 ID
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
-- 
library ieee;
use ieee.STD_LOGIC_1164.all;

--Package file that contains constant definition for RESET_ACTIVE
library opb_arbiter_v1_02_e;
use opb_arbiter_v1_02_e.opb_arb_pkg.all;

-------------------------------------------------------------------------------
-- Port Declaration
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Definition of Generics:
--      C_OPBDATA_WIDTH         -- width of OPB data bus
--      C_NUM_MID_BITS          -- number of bits required to encode master ids
--      C_DYNAM_PRIORITY        -- indicates if dynamic priority is supported
--      C_PARK                  -- indicates if bus parking is supported
--      C_PROC_INTRFCE          -- indicates if there is a processor intrfce
--
-- Definition of Ports:
--         
--    --  OPB Interface
--    input Ctrlreg_wrce        --  Control register write clock enable
--    input Bus2ip_data         --  data to be written in the control register
--    
--    output Ctrl_reg           --  Control register data
--
--    --  Clock and Reset
--    input Clk;
--    input Rst;
-------------------------------------------------------------------------------

-----------------------------------------------------------------------------
-- Entity section
-----------------------------------------------------------------------------
entity control_register_logic is
    generic (   C_OPBDATA_WIDTH     : integer   := 32;
                C_NUM_MID_BITS      : integer   := 2;
                C_DYNAM_PRIORITY    : boolean   := true;
                C_PARK              : boolean   := true;
                C_PROC_INTRFCE      : boolean   := true
            );
  port (
        Ctrlreg_wrce    : in std_logic; 
        Bus2Ip_Data     : in std_logic_vector(0 to C_OPBDATA_WIDTH-1);  
        Ctrl_reg        : out std_logic_vector(0 to C_OPBDATA_WIDTH-1); 
        Clk             : in std_logic;
        Rst             : in std_logic
        );
 
end control_register_logic;

-----------------------------------------------------------------------------
-- Architecture section
-----------------------------------------------------------------------------
architecture implementation of control_register_logic is
-------------------------------------------------------------------------------
--  Constant Declarations
-------------------------------------------------------------------------------
-- set starting bit location for Park Master ID
constant PMID_START_LOC : integer       := C_OPBDATA_WIDTH-C_NUM_MID_BITS;

-------------------------------------------------------------------------------
-- Signal and Type Declarations
------------------------------------------------------------------------------- 
-- internal version of output signal 
signal ctrl_reg_i : std_logic_vector(0 to C_OPBDATA_WIDTH-1); 
 
 
-----------------------------------------------------------------------------
-- Begin architecture
-----------------------------------------------------------------------------
begin
  
-------------------------------------------------------------------------------
-- CONTROL_REGISTER_PROCESS
-------------------------------------------------------------------------------
-- This process loads data from the OPB when there is a write request and this
-- register is enabled. Certain bits are dependant on parameters, set these
-- according to the parameter values.
-------------------------------------------------------------------------------
-- If dynamic priority is supported, set DPEN and DPENRW to 1 and allow these
-- bits to be written  if there is a processor interface
-- If there is no processor interface, set DPEN to 1 and DPENRW to 0
DYNAM_CTRL_GEN: if C_DYNAM_PRIORITY generate
    DYNAM_PI_GEN: if C_PROC_INTRFCE generate
        DYNAM_BITS_PROCESS: process(Clk)
          begin
            if Clk'event and Clk = '1' then
              if Rst = RESET_ACTIVE then
                ctrl_reg_i(DPEN_LOC) <= '1';
              elsif Ctrlreg_wrce = '1' then
                --  Load Control Register with OPB data if there is a write request
                --  and the control register is enabled
                ctrl_reg_i(DPEN_LOC) <= Bus2Ip_Data(DPEN_LOC);
              else
                ctrl_reg_i(DPEN_LOC) <= ctrl_reg_i(DPEN_LOC);
              end if;
            end if;
          end process DYNAM_BITS_PROCESS;

         ctrl_reg_i(DPENRW_LOC) <= '1';
    end generate DYNAM_PI_GEN;
    
    DYNAM_NOPI_GEN: if not(C_PROC_INTRFCE) generate
        ctrl_reg_i(DPEN_LOC) <= '1';
        ctrl_reg_i(DPENRW_LOC) <= '0';
    end generate DYNAM_NOPI_GEN;

end generate DYNAM_CTRL_GEN;

-- If dynamic priority is not supported, DPEN and DPENRW are constants
FIXED_CTRL_GEN: if not(C_DYNAM_PRIORITY)  generate
    ctrl_reg_i(DPEN_LOC)    <= '0';
    ctrl_reg_i(DPENRW_LOC)  <= '0';
end generate FIXED_CTRL_GEN;
     
-- If bus parking is supported, set PEN and PENRW to 1, PMN and PMID to 0
-- Allow these bits to be written if there is a processor interface
-- If there is no processor interface, set PEN to 1, PENRW, PMN and PMID to 0
PARK_CTRL_GEN: if C_PARK generate
    PARK_PI_GEN: if C_PROC_INTRFCE generate
        PARK_BITS_PROCESS: process(Clk)
          begin
            if Clk'event and Clk = '1' then
              if Rst = RESET_ACTIVE then
                ctrl_reg_i(PEN_LOC) <= '1';
                ctrl_reg_i(PMN_LOC) <= '0'; -- default to park on last master
                ctrl_reg_i(PMID_START_LOC to C_OPBDATA_WIDTH-1) <= (others => '0');
              elsif Ctrlreg_wrce = '1' then
                --  Load Control Register with OPB data if there is a write request
                --  and the control register is enabled
                ctrl_reg_i(PEN_LOC) <= Bus2Ip_Data(PEN_LOC);
                ctrl_reg_i(PMN_LOC) <= Bus2Ip_Data(PMN_LOC);    
                ctrl_reg_i(PMID_START_LOC to C_OPBDATA_WIDTH-1) <= 
                                Bus2IP_Data(PMID_START_LOC to C_OPBDATA_WIDTH-1);
              else
                ctrl_reg_i(PEN_LOC) <= ctrl_reg_i(PEN_LOC);
                ctrl_reg_i(PMN_LOC) <= ctrl_reg_i(PMN_LOC); 
                ctrl_reg_i(PMID_START_LOC to C_OPBDATA_WIDTH-1) <= 
                                ctrl_reg_i(PMID_START_LOC to C_OPBDATA_WIDTH-1);
              end if;
            end if;
          end process PARK_BITS_PROCESS;

          ctrl_reg_i(PENRW_LOC) <= '1';
   end generate  PARK_PI_GEN;
   
   PARK_NOPI_GEN: if not(C_PROC_INTRFCE) generate
        ctrl_reg_i(PEN_LOC)     <= '1';
        ctrl_reg_i(PENRW_LOC)   <= '0';
        ctrl_reg_i(PMN_LOC)     <= '0';
        ctrl_reg_i(PMID_START_LOC to C_OPBDATA_WIDTH-1) <= (others => '0');
   end generate PARK_NOPI_GEN;
      
end generate PARK_CTRL_GEN;

-- If bus parking is not supported, PEN, PENRW, PMN, and PMID are constants
NOPARK_CTRL_GEN: if not(C_PARK) generate
    ctrl_reg_i(PEN_LOC)     <= '0';
    ctrl_reg_i(PENRW_LOC)   <= '0';
    ctrl_reg_i(PMN_LOC)     <= '0';
    ctrl_reg_i(PMID_START_LOC to C_OPBDATA_WIDTH-1) <= (others => '0');
end generate NOPARK_CTRL_GEN;



-- If there is a processor interface, generate the PRV bit, otherwise
-- set it to '1'.
PRV_PI_GEN: if C_PROC_INTRFCE generate
    PRV_BIT_PROCESS:process (Clk, Rst, Ctrlreg_wrce, 
                                        Bus2Ip_Data, ctrl_reg_i)
      begin
        if Clk'event and Clk = '1' then
          if Rst = RESET_ACTIVE then
            ctrl_reg_i(PRV_LOC) <= '1'; -- default to priority registers valid
          elsif Ctrlreg_wrce = '1' then
            --  Load Control Register with OPB data if there is a write request
            --  and the control register is enabled
            ctrl_reg_i(PRV_LOC) <= Bus2Ip_Data(PRV_LOC);
          else
            ctrl_reg_i(PRV_LOC) <= ctrl_reg_i(PRV_LOC);
          end if;
        end if;
    end process PRV_BIT_PROCESS;
end generate PRV_PI_GEN;

PRV_NOPI_GEN: if not(C_PROC_INTRFCE) generate
    ctrl_reg_i(PRV_LOC) <= '1';
end generate PRV_NOPI_GEN;

-- Set unused bits of the control register to 0
ctrl_reg_i(CTRL_FIELD+1 to PMID_START_LOC-1) <= (others => '0');
 
-- Set output port to internal signal 
Ctrl_reg <= ctrl_reg_i;
 
end implementation;

