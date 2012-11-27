-------------------------------------------------------------------------------
-- $Id: park_lock_logic.vhd,v 1.2 2005/02/10 22:26:32 whittle Exp $
-------------------------------------------------------------------------------
-- park_lock_logic.vhd - entity/architecture pair
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

-- Filename:        park_lock_logic.vhd
-- Version:         v1.02e
-- Description:
--                  This file contains the grant_last_register logic, the park
--                  logic, and the grant_logic which determines the final grant
--                  signal to the Masters.
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
-- Author:          ALS
-- History:
--  ALS         08/28/01        -- Version 1.01a creation to include IPIF v1.22a
--  ALS         10/04/01        -- Version 1.02a creation to include IPIF v1.23a
--  ALS         11/27/01
-- ^^^^^^
--  Version 1.02b created to fix registered grant problem.
-- ~~~~~~
--  ALS         01/24/02
-- ^^^^^^
--  Created version 1.02c to fix problem with registered grants, and buslock when
--  the buslock master is holding request high and performing conversion cycles.
--  Modified the code so that the arbitration cycle and/or the internal grant
--  register enables are based off the external grants, i.e., grants output
--  to the bus taking into account buslock and park.
--  This file now generates Any_mgrant which indicates when any external grant
--  is asserted and Bus_park which indicates when the bus is parked. Also,
--  OPB_buslock now gates the internal grant signals and bus parking.
-- ~~~~~~~
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
use ieee.std_logic_arith.conv_std_logic_vector;

-- Package file that contains constant definition for RESET_ACTIVE and function
-- pad_4
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
--         C_NUM_MASTERS                -- number of Masters
--         C_NUM_MID_BITS               -- number of bits required for master IDs
--         C_PARK                       -- parking supported
--         C_REG_GRANTS                 -- register grant outputs
--
-- Definition of Ports:
--
--        input Arb_cycle               -- Valid arbitration cycle
--        input OPB_buslock             -- Bus is locked
--
--        -- Control register interface
--        input Park_master_notlast     -- Park on Master not last
--        input Park_master_id          -- Master ID to park on
--        input Park_enable             -- Enable parking
--
--        -- Intermediate grant signals from arbitration logic
--        input Grant
--
--        -- Master request signals
--        input M_request
--
--        -- Final Master grant signals
--        output Opb_mgrant             -- output grants to masters
--                                      -- may be registered if C_REG_GRANTS=true
--        output MGrant                 -- cmb grant outputs to priority reg logic
--        output MGrant_n               -- cmb active low grant signals to
--                                      -- priority reg logic
--
--        -- Clock and reset
--        input Clk;
--        input Rst;
-------------------------------------------------------------------------------

-----------------------------------------------------------------------------
-- Entity section
-----------------------------------------------------------------------------
entity park_lock_logic is
    generic(    C_NUM_MASTERS   : integer   := 8;
                C_NUM_MID_BITS  : integer   := 3;
                C_PARK          : boolean   := false;
                C_REG_GRANTS    : boolean   := true );
    port (
        Arb_cycle           : in std_logic;
        OPB_buslock         : in std_logic;
        Park_master_notlast : in std_logic;
        Park_master_id      : in std_logic_vector(0 to C_NUM_MID_BITS-1);
        Park_enable         : in std_logic;
        Grant               : in std_logic_vector(0 to C_NUM_MASTERS-1);
        M_request           : in std_logic_vector(0 to C_NUM_MASTERS-1);
        Bus_park            : out std_logic;
        Any_mgrant          : out std_logic;
        OPB_Mgrant          : out std_logic_vector(0 to C_NUM_MASTERS-1);
        Mgrant              : out std_logic_vector(0 to C_NUM_MASTERS-1);
        MGrant_n            : out std_logic_vector(0 to C_NUM_MASTERS-1);
        Clk                 : in std_logic;
        Rst                 : in std_logic
        );


end park_lock_logic;




-----------------------------------------------------------------------------
-- Architecture section
-----------------------------------------------------------------------------
architecture implementation of park_lock_logic is
-------------------------------------------------------------------------------
--  Constant Declarations
-------------------------------------------------------------------------------
-- pad number of masters(requests) and Park_enable to nearest multiple of 4
constant NUM_REQ_PAD    : integer   := pad_4(C_NUM_MASTERS);

-------------------------------------------------------------------------------
-- Signal and Type Declarations
-------------------------------------------------------------------------------
-- 1-hot register indicating which master was granted the bus
signal grant_last_reg : std_logic_vector(0 to C_NUM_MASTERS-1);

-- Signal indicating that a grant was asserted
signal any_grant      : std_logic;

-- 1-hot bus indicating which master has locked the bus
signal locked       : std_logic_vector(0 to C_NUM_MASTERS-1);

-- 1-hot bus indicating which master the bus is parked on
signal park         : std_logic_vector(0 to C_NUM_MASTERS-1) := (others => '0');
signal park_d1      : std_logic_vector(0 to C_NUM_MASTERS-1) := (others => '0');
signal park_fe      : std_logic_vector(0 to C_NUM_MASTERS-1) := (others => '0');

-- signal indicating if other masters are parked
signal others_park  : std_logic_vector(0 to C_NUM_MASTERS-1) := (others => '0');

-- signals indicating if other masters are requesting the bus
signal pend_req_cmb : std_logic_vector(0 to C_NUM_MASTERS-1) := (others => '0');
signal pend_req     : std_logic_vector(0 to C_NUM_MASTERS-1) := (others => '0');

-- indicates if any master is requesting the bus
signal any_request      : std_logic_vector(0 to 0) := (others => '0');

-- internal grant signals
signal mgrant_i         : std_logic_vector(0 to C_NUM_MASTERS-1) := (others => '0');
signal mgrant_n_i       : std_logic_vector(0 to C_NUM_MASTERS-1) := (others => '0');
signal mgrant_reg_i     : std_logic_vector(0 to C_NUM_MASTERS-1) := (others => '0');

-------------------------------------------------------------------------------
-- Component Declarations
-------------------------------------------------------------------------------
-- Xilinx primitives are used to generate the PARK signals

-- OR_BITS is used to OR all of the Grant signals so that the Grant_last_reg
-- can be updated.

-- OR_GATE is used to determine if there are any pending requests for the
-- park logic and to determine if any master is parked

-----------------------------------------------------------------------------
-- Begin architecture
-----------------------------------------------------------------------------
begin

-------------------------------------------------------------------------------
-- GRANT_LAST_REGISTER registers the grant signals for use in determining
-- parking and locking.
-- This register is clock enabled by the OR of all the Master grant signals,
-- i.e. only register the grant signals when a new grant has been issued.
-- Note that the GRANT_LAST_REGISTER uses registered internal grant signals
-- when design is configured for registered grant outputs. It uses combinational
-- grant signals when configured for combinational internal grant outputs
-------------------------------------------------------------------------------
REGGRNTS_LASTGRNT: if C_REG_GRANTS generate
begin
    -- use internal registered grant signals
    OR_GRANTS_I: entity proc_common_v2_00_a.or_bits
        generic map( C_NUM_BITS     => C_NUM_MASTERS,
                     C_START_BIT    => 0,
                     C_BUS_SIZE     => C_NUM_MASTERS)
        port map (   In_bus         => mgrant_reg_i,
                     Sig            => '0',
                     Or_out         => any_grant
                 );

    LASTGRNT_REG_PROCESS: process(Clk)
    begin
        if Clk'event and Clk = '1' then
            if Rst = RESET_ACTIVE then
                grant_last_reg <= (others => '0');
            elsif any_grant = '1' then
                grant_last_reg <= mgrant_reg_i;
            else
                grant_last_reg <= grant_last_reg;
            end if;
        end if;
    end process LASTGRNT_REG_PROCESS;
end generate REGGRNTS_LASTGRNT;

CMBGRNTS_LASTGRNT: if not(C_REG_GRANTS) generate
begin
    -- use internal combinational grant signals
    OR_GRANTS_I: entity proc_common_v2_00_a.or_bits
        generic map( C_NUM_BITS     => C_NUM_MASTERS,
                     C_START_BIT    => 0,
                     C_BUS_SIZE     => C_NUM_MASTERS)
        port map (   In_bus         => mgrant_i,
                     Sig            => '0',
                     Or_out         => any_grant
                 );

    LASTGRNT_REG_PROCESS: process(Clk)
    begin
        if Clk'event and Clk = '1' then
            if Rst = RESET_ACTIVE then
                grant_last_reg <= (others => '0');
            elsif any_grant = '1' then
                grant_last_reg <= mgrant_i;
            else
                grant_last_reg <= grant_last_reg;
            end if;
        end if;
    end process LASTGRNT_REG_PROCESS;
end generate CMBGRNTS_LASTGRNT;


-------------------------------------------------------------------------------
-- LOCK signals indicate which Master (if any) has locked the bus. Only a Master
-- which has been granted the bus and is still requesting can lock it.
-------------------------------------------------------------------------------

LOCK_GEN: for i in 0 to C_NUM_MASTERS-1 generate
      locked(i) <= '1' when grant_last_reg(i) = '1' and OPB_buslock = '1'
                     else '0';
end generate LOCK_GEN;


-------------------------------------------------------------------------------
-- PARK signals indicate which Master to park the bus on based on the Park
-- Enable, Park Master Not Last, and Park Master ID bits in the Control
-- Register. This code is only implemented if C_PARK=true indicating that
-- parking is supported. If C_PARK=false, the park bus and all OPB park signals
-- stay at their default values of 0.
-------------------------------------------------------------------------------
PARKLOGIC_GEN: if C_PARK generate

    --  For each master, must determine if there are any other requests and if parking is enabled
    PENDREQ_GEN: for i in 0 to C_NUM_MASTERS-1 generate
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
      PENDREQ_I: entity proc_common_v2_00_a.or_gate generic map (C_NUM_MASTERS-1,1,TRUE)
                             port    map (or_gate_input,pend_req(i to i));
    end generate PENDREQ_GEN;


    -- If parking is enabled and there are no pending requests, then determine
    -- which master to park on based on the PMNL bit.
    -- If park on master not last = 0, then park on last master, i.e, park =
    -- grant_last_reg. Otherwise, park on master whose ID is set in control register.
    -- Register the master's park signals
    PARK_GEN: for i in 0 to C_NUM_MASTERS-1 generate

        signal park_or_gate_input : std_logic_vector(0 to C_NUM_MASTERS-2);

        begin

        PARK_PROCESS: process (Clk)
        begin

            if Clk'event and Clk = '1' then
                if Rst = RESET_ACTIVE then
                    park(i) <= '0';
                elsif pend_req(i) = '0' and Park_enable = '1' then
                    if Park_master_notlast = '1' then
                        if Park_master_id = conv_std_logic_vector(i, C_NUM_MID_BITS) then
                            park(i) <= '1';
                        else
                            park(i) <= '0';
                        end if;
                    else
                        park(i) <= grant_last_reg(i);
                    end if;
                else
                    park(i) <= '0';
                end if;
            end if;
        end process PARK_PROCESS;

         -- When the grant outputs are registered, the parked master's grant won't negate
         -- until a clock after parking is disabled. Since the park bus is registered,
         -- the grant signal must negate as soon as possible after the park bus negates,
         -- therefore, use the falling edge of each masters' park to asynchronously reset
         -- that master's OPB_MGrant register.

         PARK_D1_PROCESS: process(Clk)
         begin
             if Clk'event and Clk = '1' then
                 if Rst = RESET_ACTIVE then
                     park_d1(i) <= '0';
                 else
                     park_d1(i) <= park(i);
                 end if;
             end if;
         end process PARK_D1_PROCESS;

         park_fe(i) <= '1' when park(i) = '0' and park_d1(i) = '1'
                   else '0';

         -- determine if other masters are parked so that the grant from the arbitration
         -- logic can be properly gated.
         OR_ALLPARK_BUT_SELF_PROCESS: process (park) is
           variable k : integer := 0;
         begin
           for j in 0 to i-1 loop
             park_or_gate_input(j)   <= park(j);
           end loop;
           for j in i+1 to C_NUM_MASTERS-1 loop
             park_or_gate_input(j-1) <= park(j);
           end loop;
         end process OR_ALLPARK_BUT_SELF_PROCESS;
         OTHERSPARK_I: entity proc_common_v2_00_a.or_gate generic map (C_NUM_MASTERS-1,1,TRUE)
                                port    map (park_or_gate_input,others_park(i to i));
    end generate PARK_GEN;

        -- determine if parked on any master
    OR_PARK_I: entity proc_common_v2_00_a.or_bits
        generic map( C_NUM_BITS     => C_NUM_MASTERS,
                     C_START_BIT    => 0,
                     C_BUS_SIZE     => C_NUM_MASTERS)
        port map (   In_bus         => park,
                     Sig            => '0',
                     Or_out         => Bus_park
                 );
end generate PARKLOGIC_GEN;

NOPARK_GEN: if not(C_PARK) generate
    Bus_park <= '0';
    park <= (others => '0');
    others_park <= (others => '0');
    park_fe <= (others => '0');
end generate NOPARK_GEN;
-------------------------------------------------------------------------------
-- GRANT_LOGIC determines the final Master grant signals based on the park/lock
-- signals and the intermediate grant signals from the arbitration logic.
-- The MGrant signals are always combinatorial and are used by the priority
-- register logic.
-------------------------------------------------------------------------------
GRANT_GEN: for i in 0 to C_NUM_MASTERS-1 generate
        mgrant_i(i) <= '1' when arb_cycle = '1' and
                     ((grant(i)='1' and others_park(i)='0' and OPB_buslock = '0')
                     or (park(i) = '1' and OPB_buslock = '0')
                     or (locked(i) = '1' and M_request(i)='1'))
                     else '0';
        mgrant_n_i(i) <= '0' when arb_cycle = '1' and
                     ((grant(i)='1' and others_park(i)='0' and OPB_buslock = '0')
                     or (park(i) = '1' and OPB_buslock = '0')
                     or (locked(i) = '1' and M_request(i)='1'))
                     else '1';

        -- Register the grant signals if registered grant outputs
        -- reset this register with park_fe
        REGGRNT_GEN: if (C_REG_GRANTS) generate
            REGGRNT_PROCESS: process (Clk, park_fe(i))
            begin
                -- asynchronously reset when park negates
                if park_fe(i) = '1' then
                    mgrant_reg_i(i) <= '0';
                elsif Clk'event and Clk='1' then
                    if Rst = RESET_ACTIVE then
                        mgrant_reg_i(i) <= '0';
                    else
                        mgrant_reg_i(i) <= mgrant_i(i);
                    end if;
                end if;
            end process REGGRNT_PROCESS;
        end generate REGGRNT_GEN;
end generate GRANT_GEN;

-------------------------------------------------------------------------------
-- Assign internal signals to outputs
-- Master grant signal outputs are registered or combinatorial based on the
-- C_REG_GRANTS parameter.
-------------------------------------------------------------------------------
MGrant <= mgrant_i;
MGrant_n <= mgrant_n_i;
Any_mgrant <= any_grant;

REGGRANT_GEN: if C_REG_GRANTS generate
    OPB_MGrant <= mgrant_reg_i;
end generate REGGRANT_GEN;

CMBGRANT_GEN: if not(C_REG_GRANTS) generate
        OPB_MGrant <= mgrant_i;
end generate CMBGRANT_GEN;

end implementation;


