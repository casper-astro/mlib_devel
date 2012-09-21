-------------------------------------------------------------------------------
-- $Id: arbitration_logic.vhd,v 1.4 2006/06/02 06:04:03 chandanm Exp $
------------------------------------------------------------------------------
-- arbitration_logic.vhd - entity/architecture pair
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
-- Filename:        arbitration_logic.vhd
-- Version:         v1.02e
-- Description:
--                  This file contains the priority encoding for the Masters.
--                  Based on the current priority of the Masters and their
--                  requests, it determines an intermediate grant signal for
--                  the Masters. This intermediate grant signal is then input
--                  to the Park Lock Logic block to determine the final grant
--                  signal based on bus parking and locking.
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
--  ALS         11/30/01
-- ^^^^^^
--  Created version 1.02b to fix problem with registered grants in fixed priority.
--  Created a state machine to generate arb_cycle when grants are registered and
--  in fixed priority. This is not needed in dynamic priority because the internal
--  grant pipeline registers are only enabled during valid arb cycles - also not
--  needed in combinational grants because there isn't a clock delay before master
--  sees the grant and responds with select.
-- ~~~~~~
--
--  ALS         01/24/02
-- ^^^^^^
--  Created version 1.02c to fix problem with registered grants, and buslock when
--  the buslock master is holding request high and performing conversion cycles.
--  Modified the code so that the arbitration cycle and/or the internal grant
--  register enables are based off the external grants, i.e., grants output
--  to the bus taking into account buslock and park.
--  When in dynamic priority and combinational outputs, the internal grant
--  registers are like the final registers, so the state machine to control
--  the enable is based on the external grants. When in dynamic priority and
--  registered outputs, the internal state machine is enabled by using the
--  internal grants and the grant registers are enabled by arb_cycle. Arb_cycle
--  is generated from a state machine that uses the external grants. When in
--  fixed priority and registered grants, the same applies. When in fixed priority
--  and combinational grants, arb_cycle is generated by simply examining OPB_Select
--  and OPB_xferAck.
-- ~~~~~~~
--  ALS         01/09/03
-- ^^^^^^
--  Created version 1.02d to register OPB_timeout to improve timing
-- ~~~~~~
--  bsbrao      09/27/04
-- ^^^^^^
--  Created version 1.02e to upgrade IPIF from opb_ipif_v1_23_a to
--  opb_ipif_v3_01_a
-- ~~~~~~
-- LCW	02/04/05 - update library statements
-- ~~~~~~
-- chandan      05/25/06
-- ^^^^^^
-- Modified the process  MASTERLOOP to remove the latch it was creating. 
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
--
library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.std_logic_arith.conv_std_logic_vector;
--
-- library unsigned is used for overloading of "=" which allows integer to
-- be compared to std_logic_vector
use ieee.std_logic_unsigned.all;

-- The unisim library is required to instantiate Xilinx primitives.
library unisim;
use unisim.vcomponents.all;

library opb_arbiter_v1_02_e;
use opb_arbiter_v1_02_e.opb_arb_pkg.all;

library proc_common_v2_00_a;

-------------------------------------------------------------------------------
-- Port Declaration
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Definition of Generics:
--  C_NUM_MASTERS              -- number of masters
--  C_NUM_MID_BITS             -- number of bits required to encode master ids
--  C_OPBDATA_WIDTH            -- number of bits in OPB data bus
--  C_DYNAM_PRIORITY           -- dynamic or fixed priority
--  C_REG_GRANTS               -- registered or combinatorial grant outputs
--
-- Definition of Ports:
--
--  input OPB_select           -- indicates a Master is controlling the bus
--  input OPB_xferAck          -- transfer acknowledge
--  input M_request            -- bus of master request signals
--  input OPB_buslock          -- indicates the OPB is locked
--  input Bus_park             -- indicates that the bus is parked
--  input Any_mgrant           -- indicates that a Master has been granted the bus
--  input Priority_ids         -- the priority IDs of the masters
--
--  output Arb_cycle           -- arbitration cycle
--  output Grant               -- intermediate Master grant signals
--
--  -- System signals
--  input Clk
--  input Rst
--
-------------------------------------------------------------------------------

-----------------------------------------------------------------------------
-- Entity section
-----------------------------------------------------------------------------
entity arbitration_logic is
  generic(  C_NUM_MASTERS   : integer   := 16;
            C_NUM_MID_BITS  : integer   := 4;
            C_OPBDATA_WIDTH : integer   := 32;
            C_DYNAM_PRIORITY: boolean   := false;
            C_REG_GRANTS    : boolean   := false
         );
  port (
        OPB_select  : in std_logic;
        OPB_xferAck : in std_logic;
        M_request   : in std_logic_vector(0 to C_NUM_MASTERS-1);
        OPB_buslock : in std_logic;
        Bus_park    : in std_logic;
        Any_mgrant  : in std_logic;
        Priority_ids : in std_logic_vector(0 to C_NUM_MASTERS*C_NUM_MID_BITS-1);
        Arb_cycle   : out std_logic;
        Grant       : out std_logic_vector(0 to C_NUM_MASTERS-1);
        Clk         : in std_logic;
        Rst         : in std_logic
        );


end arbitration_logic;


-----------------------------------------------------------------------------
-- Architecture section
-----------------------------------------------------------------------------
architecture implementation of arbitration_logic is
-------------------------------------------------------------------------------
--  Constant Declarations
-------------------------------------------------------------------------------
-- number of priority levels is equal to the number of masters
constant NUM_LVLS   : integer   := C_NUM_MASTERS;

-- pad number of masters to nearest power of 2 for mux_encode_sel
constant NUM_MSTRS_PAD  : integer   := pad_power2(C_NUM_MASTERS);

-------------------------------------------------------------------------------
-- Signal and Type Declarations
-------------------------------------------------------------------------------

-- Need active low request signals to properly drive select lines of muxes
-- this bus will use NUM_MSTRS_PAD so that bus is sized to nearest power of 2
-- for mux_encode_sel. Bus defaults to '0', only the bits up to C_NUM_MASTERS
-- will get assigned a real value.
signal m_request_n      : std_logic_vector(0 to NUM_MSTRS_PAD-1) := (others => '0');

-- declare a 2-dimensional array for each master's priority level and mux chain
type MASTER_LVL_TYPE is array(0 to C_NUM_MASTERS-1) of std_logic_vector(0 to NUM_LVLS-1);

signal M_req_lvl  : MASTER_LVL_TYPE;  -- holds master's priority levels
signal M_muxout     : MASTER_LVL_TYPE;  -- output of each MUXCY

-- declare a signal to hold decode requests
-- active low bus where if the bit location =0, a request was received at that priority
-- level
signal request_lvl_n    : std_logic_vector(0 to NUM_LVLS-1);

-- internal intermediate grant signals
signal grant_i          : std_logic_vector(0 to C_NUM_MASTERS-1);

-- OR of all intermediate grant signals
signal any_grant        : std_logic;

-- enables grant registers
signal en_grant_reg         : std_logic := '0';


-- Enable Grant State Machine signals for dynamic priority, registered outputs
type ENGRNTREG_STATE_TYPE  is (IDLE, WAIT1, WAIT2, CHK_SELECT);
signal engrntreg_cs       : ENGRNTREG_STATE_TYPE := IDLE;
signal engrntreg_ns       : ENGRNTREG_STATE_TYPE := IDLE;

-- Enable Grant State Machine signals for dynamic priority, combinational outputs
type ENGRNTCMB_STATE_TYPE  is (IDLE, CHK_SELECT);
signal engrntcmb_cs       : ENGRNTCMB_STATE_TYPE := IDLE;
signal engrntcmb_ns       : ENGRNTCMB_STATE_TYPE := IDLE;

-- Arb Cycle State Machine signals
type ARBCYCLE_STATE_TYPE  is (IDLE, CHK_SELECT);
signal arbcycle_cs      : ARBCYCLE_STATE_TYPE := IDLE;
signal arbcycle_ns      : ARBCYCLE_STATE_TYPE := IDLE;

-------------------------------------------------------------------------------
-- Component Declarations
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- MUXCY - carry chain multiplexors
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- OR_BITS is used to OR all of the intermediate Grant signals so that the
-- enable can be generated to the grant registers (only used when C_DYNAM_PRIORITY
-- =1)
-------------------------------------------------------------------------------

-----------------------------------------------------------------------------
-- Begin architecture
-----------------------------------------------------------------------------
begin

-- If Dynamic priority with registered outputs, determine
-- if any grant has been asserted. This is to used to enable the
-- internal grant registers at the proper time.
ANY_GRNT_GEN: if (C_DYNAM_PRIORITY and C_REG_GRANTS)  generate

    OR_IGRNTS_I: entity proc_common_v2_00_a.or_bits
    generic map( C_NUM_BITS     => C_NUM_MASTERS,
                 C_START_BIT    => 0,
                 C_BUS_SIZE     => C_NUM_MASTERS)
    port map (   In_bus         => grant_i,
                 Sig            => '0',
                 Or_out         => any_grant
            );
end generate ANY_GRNT_GEN;

-------------------------------------------------------------------------------
-- Set output grants to internal grants
-- If parameterized for dynamic priority, register these signals
-- have to generate the correct clock enables for these internal registers
-- If parameterized for fixed priority, simply assign them
-------------------------------------------------------------------------------

FIXED_GRANT_GENERATE: if not(C_DYNAM_PRIORITY) generate
         Grant <= grant_i;
end generate FIXED_GRANT_GENERATE;

DYNAM_GRANT_GENERATE: if C_DYNAM_PRIORITY generate

    -- when dyanmic priority and combinational outputs, generate enables to
    -- internal grant registers based on the external bus grants (any_mgrant).
  DYNAM_CMB_GRANT_GEN: if not(C_REG_GRANTS) generate
    ---------------------------------------------------------------------------
    --ENGRNTCMB_CMB_PROCESS
    --ENGRNTCMB_REG_PROCESS
    --
    -- This state machine generates the enable for the grant registers. When
    -- any bus grant is asserted, the grant registers are enabled. Then the state
    -- machine checks OPB_select. If its
    -- negated, the master has aborted the transaction and the grant registers
    -- are enabled if any_mgrant is still asserted. If select is asserted, then
    -- the state machine waits for OPB_xferAck and enables
    -- the grant registers when these are asserted.
    ---------------------------------------------------------------------------
    ENGRNTCMB_CMB_PROCESS: process (OPB_select, any_mgrant, OPB_xferAck, engrntcmb_cs)
    begin
        -- set defaults
         en_grant_reg<= '0';
         engrntcmb_ns <= engrntcmb_cs;

         case engrntcmb_cs is
            -------------------------- IDLE State -----------------------------
            -- wait in this state until OPB_Select or any_mgrant asserts
            -- negate en_grant_reg and either wait for OPB_select to assert or
            -- if its asserted, wait for XferAck.
            when IDLE =>
                en_grant_reg<= '1';
                if OPB_Select = '1' or
                    any_mgrant = '1' then
                    en_grant_reg<= '0';
                    engrntcmb_ns <= CHK_SELECT;
                end if;

            -------------------------- CHK_SELECT State -----------------------
            -- OPB_Select should be asserted in this state
            -- if its not asserted, the master has aborted the transaction,so
            -- en_grant_reg should be asserted. If OPB_select is asserted, wait
            -- for OPB_xferAck to assert en_grant_reg. If any_mgrant
            -- is asserted, return to IDLE, otherwise stay in this
            -- state
            when CHK_SELECT =>
                if OPB_select = '0' then
                    if any_mgrant = '0' then
                        en_grant_reg<= '1';
                        engrntcmb_ns <= IDLE;
                    end if;
                elsif OPB_xferAck = '1'then
                    if any_mgrant = '0' then
                        en_grant_reg<= '1';
                        engrntcmb_ns <= IDLE;
                    end if;
                end if;
            -------------------------- DEFAULT State --------------------------
            when others =>
                engrntcmb_ns <= IDLE;
         end case;
    end process ENGRNTCMB_CMB_PROCESS;

    -- ENGRNTCMB_REG_PROCESS
    ENGRNTCMB_REG_PROCESS:
    process (Clk)
     begin
        if (Clk'event and Clk = '1') then
           if (Rst = RESET_ACTIVE) then
                engrntcmb_cs <= IDLE;
           else
                engrntcmb_cs <= engrntcmb_ns;
           end if;
        end if;
    end process ENGRNTCMB_REG_PROCESS;
  end generate DYNAM_CMB_GRANT_GEN;

  -- when dyanmic priority and registered outputs, generate enables to
  -- internal grant registers based on the internal bus grants (any_grant).

  DYNAM_REG_GRANT_GEN: if C_REG_GRANTS generate

    ENGRNTREG_CMB_PROCESS: process (OPB_select, any_grant, OPB_xferAck, engrntreg_cs)
        -- set defaults
    begin
         en_grant_reg <= '0';
         engrntreg_ns <= engrntreg_cs;

         case engrntreg_cs is
            -------------------------- IDLE State -----------------------------
            -- wait in this state until any_grant asserts, then enable the
            -- grant registers and begin waiting through the grant pipeline
            when IDLE =>
                if OPB_select = '1' then
                    engrntreg_ns <= CHK_SELECT;
                elsif any_grant = '1' then
                    engrntreg_ns <= WAIT1;
                    en_grant_reg <= '1';
                end if;

            -------------------------- WAIT1 State ----------------------------
            -- this state represents the internal grant registers
            -- wait another state before checking OPB_select
            when WAIT1 =>
                    engrntreg_ns <= WAIT2;

            -------------------------- WAIT2 State ----------------------------
            -- this state represents the registers on the grant outputs
            -- check OPB_select in the next clock
            when WAIT2 =>
                engrntreg_ns <= CHK_SELECT;

            -------------------------- CHK_SELECT State -----------------------
            -- OPB_Select should be asserted in this state
            -- if its not asserted, the master has aborted the transaction,so
            -- the grant registers need to be enabled to allow the next grant
            -- to flow through the pipeline. If OPB_select is asserted, wait
            -- for OPB_xferAck assert. When asserted, enable the grant registers.
            -- If any_grant is asserted, return to the WAIT1 state, otherwise
            -- return to the IDLE state.
            when CHK_SELECT =>
                if OPB_select = '0' then
                    if any_grant = '1' then
                       en_grant_reg <= '1';
                       engrntreg_ns <= WAIT1;
                    else
                        engrntreg_ns <= IDLE;
                    end if;
                elsif OPB_xferAck = '1' then
                    if any_grant = '1' then
                       en_grant_reg <= '1';
                       engrntreg_ns <= WAIT1;
                    else
                        engrntreg_ns <= IDLE;
                    end if;
                end if;

            -------------------------- DEFAULT State --------------------------
            when others =>
                engrntreg_ns <= IDLE;
         end case;
    end process ENGRNTREG_CMB_PROCESS;

    -- ENGRNTREG_REG_PROCESS
    ENGRNTREG_REG_PROCESS:
    process (Clk)
     begin
        if (Clk'event and Clk = '1') then
           if (Rst = RESET_ACTIVE) then
                engrntreg_cs <= IDLE;
           else
                engrntreg_cs <= engrntreg_ns;
           end if;
        end if;
    end process ENGRNTREG_REG_PROCESS;
  end generate DYNAM_REG_GRANT_GEN;

    ---------------------------------------------------------------------------
    -- REGGRNT_PROCESS defines the registes on the arbiter grant outputs
    ---------------------------------------------------------------------------
     REGGRNT_PROCESS: process (Clk)
     begin
         if Clk'event and Clk='1' then
             if Rst = RESET_ACTIVE then
                 Grant <= (others => '0');
             elsif en_grant_reg = '1' then
                Grant <= grant_i;
             else
                Grant <= (others => '0');
             end if;
         end if;
     end process;

end generate DYNAM_GRANT_GENERATE;

-------------------------------------------------------------------------------
-- Set arbitration cycle signal
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- When combinational grant outputs, valid arbitration cycles
-- are when OPB_select = 0 or OPB_xferAck = 1
-------------------------------------------------------------------------------
CMB_ARBCYCLE_GEN: if not(C_REG_GRANTS) generate
    Arb_cycle <= '1' when OPB_select = '0' or OPB_xferAck = '1'
                else '0';
end generate CMB_ARBCYCLE_GEN;

-------------------------------------------------------------------------------
-- When registered grant outputs, arb_cycle is determined by
-- a state machine which waits the external bus grants to be output
-- and then checks select. Since it uses the output of the grant registers,
-- parking and locking are accounted for.
-------------------------------------------------------------------------------
REG_ARBCYCLE_GEN: if C_REG_GRANTS generate
  ARBCYCLE_CMB_PROCESS: process (OPB_select, any_mgrant, OPB_xferAck,
                                    arbcycle_cs, Bus_park)
    begin

        -- set defaults
         Arb_cycle<= '0';
         arbcycle_ns <= arbcycle_cs;

         case arbcycle_cs is
            -------------------------- IDLE State -----------------------------
            -- wait in this state until OPB_Select or any_mgrant asserts
            -- negate Arb_cycle and either wait for OPB_select to assert or
            -- if its asserted, wait for XferAck.
            when IDLE =>
                Arb_cycle<= '1';
                if (OPB_Select = '1' and OPB_xferAck = '0') or
                    (any_mgrant = '1') then
                    Arb_cycle<= '0';
                    arbcycle_ns <= CHK_SELECT;
                end if;

            -------------------------- CHK_SELECT State -----------------------
            -- OPB_Select should be asserted in this state
            -- if its not asserted, the master has aborted the transaction,so
            -- Arb_cycle should be asserted. If OPB_select is asserted, wait
            -- for OPB_xferAck to assert arb_cycle.
            when CHK_SELECT =>
                if OPB_select = '0' then
                    Arb_cycle<= '1';
                    if bus_park = '0' then
                        arbcycle_ns <= IDLE;
                    end if;
                elsif OPB_xferAck = '1'then
                    Arb_cycle<= '1';
                    arbcycle_ns <= IDLE;
                end if;
            -------------------------- DEFAULT State --------------------------
            when others =>
                arbcycle_ns <= IDLE;
         end case;
    end process ARBCYCLE_CMB_PROCESS;

    -- ARBCYCLE_REG_PROCESS
    ARBCYCLE_REG_PROCESS:
    process (Clk)
     begin
        if (Clk'event and Clk = '1') then
           if (Rst = RESET_ACTIVE) then
                arbcycle_cs <= IDLE;
           else
                arbcycle_cs <= arbcycle_ns;
           end if;
        end if;
    end process ARBCYCLE_REG_PROCESS;
end generate REG_ARBCYCLE_GEN;
--
-------------------------------------------------------------------------------
-- LOGIC DESCRIPTION
-------------------------------------------------------------------------------
-- The arbitration logic was designed using the Xilinx FPGA primitives so that
-- the fastest speed could be achieved. LUTs (Look-Up Tables) were used as MUXs
-- and OR/AND gates to determine the request level of each Master. The outputs
-- of the LUTs were then input to the carry chain muxes to determine whether
-- grant signal for that Master would be asserted. The MUX select signals were
-- signals indicating whether any Master had asserted a request for each
-- priority level.The inputs to the muxes were signals indicating
-- the level of each master's request. For example, the
-- first mux in the carry chain for Master 0 had the LVL3_0 and the LVL2_0
-- signals as inputs and the select signal was LVL2_REQ_N indicating that a
-- LVL2 request had been received. If this signal was asserted (active low)
-- then the output of the mux would be LVL2_0 and this would be an input to the
-- next mux in the priority carry chain which would select between LVL1 and
-- LVL2 requests, etc.
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Mux Selects
-------------------------------------------------------------------------------
-- The mux selects are used in the carry chain for all masters. These signals
-- indicate whether any master had a request at a particular priority level.
-- This is essentially an encoded mux with each priority ID being the selects
-- and the Master requests being the data.
-------------------------------------------------------------------------------

MASTERLOOP: for i in 0 to C_NUM_MASTERS-1 generate --4

        -- need active low request signals to properly drive mux select lines
        -- if bus lock is not asserted
        m_request_n(i) <= not(M_request(i))
                          when OPB_buslock = '0'
                          else '1';
   
 MASTER_4 : if C_NUM_MID_BITS = 4 generate
      signal priority_ids_int : std_logic_vector(0 to 3);
      begin
   
        priority_ids_int  <= priority_ids(i*C_NUM_MID_BITS to (i*C_NUM_MID_BITS)+C_NUM_MID_BITS-1);
         
        DECODE_REQ_PROCESS: process(m_request_n, priority_ids_int)
        begin
          case priority_ids_int is
            when "0000"  => request_lvl_n(i) <= m_request_n(0);
            when "0001"  => request_lvl_n(i) <= m_request_n(1);
            when "0010"  => request_lvl_n(i) <= m_request_n(2);
            when "0011"  => request_lvl_n(i) <= m_request_n(3);
            when "0100"  => request_lvl_n(i) <= m_request_n(4);
            when "0101"  => request_lvl_n(i) <= m_request_n(5);
            when "0110"  => request_lvl_n(i) <= m_request_n(6);
            when "0111"  => request_lvl_n(i) <= m_request_n(7);
            when "1000"  => request_lvl_n(i) <= m_request_n(8);
            when "1001"  => request_lvl_n(i) <= m_request_n(9);
            when "1010"  => request_lvl_n(i) <= m_request_n(10);
            when "1011"  => request_lvl_n(i) <= m_request_n(11);
            when "1100"  => request_lvl_n(i) <= m_request_n(12);
            when "1101"  => request_lvl_n(i) <= m_request_n(13);
            when "1110"  => request_lvl_n(i) <= m_request_n(14);
            when others  => request_lvl_n(i) <= m_request_n(15);
          end case;
        end process DECODE_REQ_PROCESS;
       
  end generate MASTER_4;
  
  MASTER_3 : if C_NUM_MID_BITS = 3 generate
        signal priority_ids_int : std_logic_vector(0 to 2);
        begin
     
          priority_ids_int  <= priority_ids(i*C_NUM_MID_BITS to (i*C_NUM_MID_BITS)+C_NUM_MID_BITS-1);
           
          DECODE_REQ_PROCESS: process(m_request_n, priority_ids_int)
          begin
            case priority_ids_int is
              when "000"  => request_lvl_n(i) <= m_request_n(0);
              when "001"  => request_lvl_n(i) <= m_request_n(1);
              when "010"  => request_lvl_n(i) <= m_request_n(2);
              when "011"  => request_lvl_n(i) <= m_request_n(3);
              when "100"  => request_lvl_n(i) <= m_request_n(4);
              when "101"  => request_lvl_n(i) <= m_request_n(5);
              when "110"  => request_lvl_n(i) <= m_request_n(6);
              when others  => request_lvl_n(i) <= m_request_n(7);
            end case;
          end process DECODE_REQ_PROCESS;
         
  end generate MASTER_3;
  
  MASTER_2 : if C_NUM_MID_BITS = 2 generate
        signal priority_ids_int : std_logic_vector(0 to 1);
        begin
     
          priority_ids_int  <= priority_ids(i*C_NUM_MID_BITS to (i*C_NUM_MID_BITS)+C_NUM_MID_BITS-1);
           
          DECODE_REQ_PROCESS: process(m_request_n, priority_ids_int)
          begin
            case priority_ids_int is
              when "00"  => request_lvl_n(i) <= m_request_n(0);
              when "01"  => request_lvl_n(i) <= m_request_n(1);
              when "10"  => request_lvl_n(i) <= m_request_n(2);
              when others  => request_lvl_n(i) <= m_request_n(3);
            end case;
          end process DECODE_REQ_PROCESS;
         
  end generate MASTER_2;
  
  MASTER_1 : if C_NUM_MID_BITS = 1 generate
        signal priority_ids_int : std_logic_vector (0 to 0);
        begin
     
          priority_ids_int  <= priority_ids(i*C_NUM_MID_BITS to (i*C_NUM_MID_BITS)+C_NUM_MID_BITS-1);
           
          DECODE_REQ_PROCESS: process(m_request_n, priority_ids_int)
          begin
            case priority_ids_int is
              when "0"  => request_lvl_n(i) <= m_request_n(0);
              when others  => request_lvl_n(i) <= m_request_n(1);
            end case;
          end process DECODE_REQ_PROCESS;
         
  end generate MASTER_1;

        -- for each master, determine its priority level and if its request
        -- is asserted

        MASTERREQ_LVL: for j in 0 to NUM_LVLS-1 generate

        REQPROC: process (m_request_n(i),
                Priority_ids(j*C_NUM_MID_BITS to j*C_NUM_MID_BITS+C_NUM_MID_BITS-1))
        begin
            if m_request_n(i) = '0' then
                if Priority_ids(j*C_NUM_MID_BITS to j*C_NUM_MID_BITS+C_NUM_MID_BITS-1)
                    = conv_std_logic_vector(i, C_NUM_MID_BITS) then
                    M_req_lvl(i)(j) <= '1';
                else
                    M_req_lvl(i)(j) <= '0';
                end if;
            else
                M_req_lvl(i)(j) <= '0';
            end if;
        end process REQPROC;

        end generate MASTERREQ_LVL;

        -- for each master, set up carry chain

        MASTER_CHAIN: for j in NUM_LVLS-2 downto 0 generate

            FIRSTMUX_GEN: if j = NUM_LVLS-2 generate

                FIRST_I: MUXCY
                  port map (
                    O   =>  M_muxout(i)(j),     --[out]
                    CI  =>  M_req_lvl(i)(j+1),--[in]
                    DI  =>  M_req_lvl(i)(j),  --[in]
                    S   =>  request_lvl_n(j)    --[in]
                  );
            end generate FIRSTMUX_GEN;

            OTHERMUX_GEN: if j /= NUM_LVLS-2 generate

                OTHERS_I: MUXCY
                  port map (
                    O   =>  M_muxout(i)(j),     --[out]
                    CI  =>  M_muxout(i)(j+1), --[in]
                    DI  =>  M_req_lvl(i)(j),--[in]
                    S   =>  request_lvl_n(j)  --[in]
                  );
            end generate OTHERMUX_GEN;

         end generate MASTER_CHAIN;

        grant_i(i) <= M_muxout(i)(0);
end generate MASTERLOOP;

end implementation;

