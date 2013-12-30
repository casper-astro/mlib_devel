-------------------------------------------------------------------------------
-- $Id: opb_arbiter_core.vhd,v 1.1.2.1 2009/10/06 21:15:01 gburch Exp $
-------------------------------------------------------------------------------
-- opb_arbiter_core.vhd - entity/architecture pair
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
-- Filename:        opb_arbiter_core.vhd
-- Version:         v1.02e
-- Description:     This is the top-level design file for the OPB Arbiter core.
--                  It supports 1-16 masters and both fixed and dynamic priority
--                  algorithms via user-configurable parameters. The user can
--                  also include support for bus parking and the OPB slave
--                  interface by setting parameters.
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
--  GAB         07/05/05
-- ^^^^^^
--  Fixed XST issue in ipif_regonly_slave.vhd.  This fixes CR211277.
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
use ieee.STD_LOGIC_SIGNED.all;

-- OPB_ARB_PKG contains the necessary constants and functions for the
-- OPB Arbiter
library opb_v20_v1_10_d;
use opb_v20_v1_10_d.opb_arb_pkg.all;
use opb_v20_v1_10_d.all;

-------------------------------------------------------------------------------
-- Port Declaration
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Definition of Generics:
--      C_BASEADDR              -- OPB Arbiter base address
--      C_HIGHADDR              -- OPB Arbiter high address
--      C_NUM_MASTERS           -- number of OPB masters
--      C_OPBDATA_WIDTH         -- width of OPB data bus
--      C_OPBADDR_WIDTH         -- width of OPB address bus
--      C_DYNAM_PRIORITY        -- dynamic or fixed priority
--      C_REG_GRANTS            -- registered or combinational grant outputs
--      C_PARK                  -- bus parking
--      C_PROC_INTRFCE          -- OPB slave interface
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
--      input OPB_Rst         -- Reset
--
-------------------------------------------------------------------------------

-----------------------------------------------------------------------------
-- Entity section
-----------------------------------------------------------------------------
entity opb_arbiter_core is
    generic (
             C_BASEADDR                 : std_logic_vector;
             C_HIGHADDR                 : std_logic_vector;
             C_NUM_MASTERS              : integer := 4;
             C_OPBDATA_WIDTH            : integer := 32;
             C_OPBADDR_WIDTH            : integer := 32;
             C_DYNAM_PRIORITY           : boolean := False;
             C_REG_GRANTS               : boolean := True;
             C_PARK                     : boolean := False;
             C_PROC_INTRFCE             : boolean := False;
             C_DEV_BLK_ID               : integer := 0;
             C_DEV_MIR_ENABLE           : integer := 0
             );
    port (
          ARB_DBus      : out std_logic_vector(0 to C_OPBDATA_WIDTH-1);
          ARB_ErrAck    : out std_logic;
          ARB_Retry     : out std_logic;
          ARB_ToutSup   : out std_logic;
          ARB_XferAck   : out std_logic;
          OPB_Clk       : in std_logic;
          M_request     : in std_logic_vector(0 to C_NUM_MASTERS-1);
          OPB_Abus      : in std_logic_vector(0 to C_OPBADDR_WIDTH-1);
          OPB_BE        : in std_logic_vector(0 to C_OPBDATA_WIDTH/8-1);
          OPB_buslock   : in std_logic;
          OPB_Dbus      : in std_logic_vector(0 to C_OPBDATA_WIDTH-1);
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


end opb_arbiter_core;



-----------------------------------------------------------------------------
-- Architecture section
-----------------------------------------------------------------------------
architecture implementation of opb_arbiter_core is

-------------------------------------------------------------------------------
--  Constant Declarations
-------------------------------------------------------------------------------
constant NUM_MID_BITS   : integer := max2(1,log2(C_NUM_MASTERS));
constant PMID_START_LOC : integer := C_OPBDATA_WIDTH - NUM_MID_BITS;
constant DEV_ADDR_DECODE_WIDTH : integer :=
                            Addr_Bits(C_BASEADDR,C_HIGHADDR,C_OPBADDR_WIDTH);

-------------------------------------------------------------------------------
--  Signal and Type Declarations
-------------------------------------------------------------------------------
-- internal connections
signal arb2bus_data     : std_logic_vector(0 to C_OPBDATA_WIDTH-1);
signal arb2bus_rdack    : std_logic;
signal arb2bus_wrack    : std_logic;
signal arb_cycle        : std_logic;
signal any_mgrant       : std_logic;
signal bus2ip_data      : std_logic_vector(0 to C_OPBDATA_WIDTH-1);
signal bus2ip_reg_rdce  : std_logic_vector(0 to C_NUM_MASTERS);
signal bus2ip_reg_wrce  : std_logic_vector(0 to C_NUM_MASTERS);
signal bus_park         : std_logic;
signal ctrl_reg         : std_logic_vector(0 to C_OPBDATA_WIDTH-1);
signal grant            : std_logic_vector(0 to C_NUM_MASTERS-1);
signal mgrant           : std_logic_vector(0 to C_NUM_MASTERS-1);
signal mgrant_n         : std_logic_vector(0 to C_NUM_MASTERS-1);
signal opb_mgrant_i     : std_logic_vector(0 to C_NUM_MASTERS-1);
signal opb_timeout_i    : std_logic;
signal priority_IDs     : std_logic_vector(0 to C_NUM_MASTERS * NUM_MID_BITS-1);
signal priority_register: std_logic_vector(0 to C_NUM_MASTERS * C_OPBDATA_WIDTH-1);

signal clk              : std_logic;
signal rst              : std_logic;

-------------------------------------------------------------------------------
-- Component Declarations
-------------------------------------------------------------------------------
  -- none
-----------------------------------------------------------------------------
-- Begin architecture
-----------------------------------------------------------------------------
begin
-------------------------------------------------------------------------------
--  Assign internal grant signals to output port
-------------------------------------------------------------------------------
OPB_MGrant <= opb_mgrant_i;
OPB_timeout <= opb_timeout_i;

-------------------------------------------------------------------------------
-- Instantiate logic as determined by parameter values. Note that the
-- OPB Arbiter will always contain a watchdog timer, regardless of the number
-- of masters on the bus or the other features specified.
-------------------------------------------------------------------------------
WATCHDOG_TIMER_I: entity opb_v20_v1_10_d.watchdog_timer
    port map (
              OPB_select    => OPB_select,
              OPB_xferAck   => OPB_xferAck,
              OPB_retry     => OPB_retry,
              OPB_toutSup   => OPB_toutSup,
              OPB_timeout   => opb_timeout_i,
              Clk           => clk,
              Rst           => rst);

-------------------------------------------------------------------------------
-- Number of Masters
-- If the number of masters is 1, then simply assign the OPB_MGrant output of
-- the OPB Arbiter to '1'.
-------------------------------------------------------------------------------
SINGLE_MASTER_GEN: if C_NUM_MASTERS = 1 generate
    opb_mgrant_i <= (others => '1');
    ARB_DBus        <= (others => '0');
    ARB_ErrAck      <= '0';
    ARB_Retry       <= '0';
    ARB_ToutSup     <= '0';
    ARB_XferAck     <= '0';
    clk             <= OPB_Clk;
    rst             <= OPB_Rst;
end generate SINGLE_MASTER_GEN;

-------------------------------------------------------------------------------
-- Number of Masters
-- If the number of masters is > 1, then the arbiter needs the logic components
-- define below.
-------------------------------------------------------------------------------
MULTI_MASTER_GEN: if C_NUM_MASTERS > 1 generate

    ---------------------------------------------------------------------------
    -- CONTROL_REGISTER_LOGIC contains the control register
    ---------------------------------------------------------------------------
    CTRLREG_I: entity opb_v20_v1_10_d.control_register_logic
        generic map (C_OPBDATA_WIDTH    => C_OPBDATA_WIDTH,
                     C_NUM_MID_BITS     => NUM_MID_BITS,
                     C_DYNAM_PRIORITY   => C_DYNAM_PRIORITY,
                     C_PARK             => C_PARK,
                     C_PROC_INTRFCE     => C_PROC_INTRFCE)
        port map (
                  Ctrlreg_wrce  => bus2ip_reg_wrce(0),
                  Bus2Ip_Data   => bus2ip_data(0 to C_OPBDATA_WIDTH - 1),
                  Ctrl_reg      => ctrl_reg(0 to C_OPBDATA_WIDTH - 1),
                  Clk           => clk,
                  Rst           => rst);

    ---------------------------------------------------------------------------
    -- PRIORITY_REGISTER_LOGIC contains the priority register and update logic
    ---------------------------------------------------------------------------
    PRIORITY_REGS_I: entity opb_v20_v1_10_d.priority_register_logic
        generic map (C_NUM_MASTERS      => C_NUM_MASTERS,
                     C_OPBDATA_WIDTH    => C_OPBDATA_WIDTH,
                     C_NUM_MID_BITS     => NUM_MID_BITS,
                     C_DYNAM_PRIORITY   => C_DYNAM_PRIORITY)
        port map (
                  MGrant            => mgrant(0 to C_NUM_MASTERS-1),
                  MGrant_n          => mgrant_n(0 to C_NUM_MASTERS-1),
                  Bus2IP_Data       => bus2ip_data(0 to C_OPBDATA_WIDTH-1),
                  Bus2IP_Reg_WrCE   => bus2ip_reg_wrce(1 to C_NUM_MASTERS),
                  Dpen              => ctrl_reg(DPEN_LOC),
                  Prv               => ctrl_reg(PRV_LOC),
                  Priority_register => priority_register,
                  Priority_IDs      => Priority_IDs,
                  Clk               => clk,
                  Rst               => rst);

    ---------------------------------------------------------------------------
    -- Only instantiate the OPB Bus slave components if the design has been
    -- parameterized to support a processor interface
    -- Otherwise, set ports and interface signals to GND
    ---------------------------------------------------------------------------
    OPBSLAVE_GEN: if C_PROC_INTRFCE generate

        IPIF_I: entity opb_v20_v1_10_d.ipif_regonly_slave
            generic map (C_OPB_ABUS_WIDTH       => C_OPBADDR_WIDTH,
                         C_OPB_DBUS_WIDTH       => C_OPBDATA_WIDTH,
                         C_BASEADDR              => C_BASEADDR,
                         C_NUM_MASTERS          => C_NUM_MASTERS,
                         C_NUM_MID_BITS         => NUM_MID_BITS,
                         C_DEV_BLK_ID           => C_DEV_BLK_ID,
                         C_DEV_MIR_ENABLE       => C_DEV_MIR_ENABLE,
                         C_DEV_ADDR_DECODE_WIDTH => DEV_ADDR_DECODE_WIDTH)
            port map (
                      Bus2IP_Data       => bus2ip_data,
                      Bus2IP_Reg_RdCE   => bus2ip_reg_rdce,
                      Bus2IP_Reg_WrCE   => bus2ip_reg_wrce,
                      Bus2IP_Clk        => clk,
                      Bus2IP_Reset      => rst,
                      IP2Bus_Data       => arb2bus_data,
                      IP2Bus_RdAck      => arb2bus_rdack,
                      IP2Bus_WrAck      => arb2bus_wrack,
                      OPB_ABus          => OPB_Abus,
                      OPB_BE            => OPB_BE,
                      OPB_Clk           => OPB_Clk,
                      OPB_DBus          => OPB_Dbus,
                      OPB_RNW           => OPB_RNW,
                      OPB_Select        => OPB_select,
                      OPB_seqAddr       => OPB_seqAddr,
                      Rst               => OPB_Rst,
                      Sln_DBus          => ARB_DBus,
                      Sln_ErrAck        => ARB_ErrAck,
                      Sln_Retry         => ARB_Retry,
                      Sln_ToutSup       => ARB_ToutSup,
                      Sln_XferAck       => ARB_XferAck);



        ARB2BUS_DATAMUX_I: entity opb_v20_v1_10_d.arb2bus_data_mux
            generic map (C_NUM_MASTERS  => C_NUM_MASTERS,
                         C_OPBDATA_WIDTH=> C_OPBDATA_WIDTH)
            port map (
                      Bus2IP_Reg_RdCE   => bus2ip_reg_rdce(0 to C_NUM_MASTERS),
                      Bus2IP_Reg_WrCE   => bus2ip_reg_wrce(0 to C_NUM_MASTERS),
                      Ctrl_reg          => ctrl_reg,
                      Priority_regs     => priority_register,
                      Arb2bus_wrack     => arb2bus_wrack,
                      Arb2bus_rdack     => arb2bus_rdack,
                      Arb2bus_data      => arb2bus_data);

    end generate OPBSLAVE_GEN;

    NO_OPBSLAVE_GEN: if not(C_PROC_INTRFCE) generate
        bus2ip_data     <= (others => '0');
        bus2ip_reg_rdce <= (others => '0');
        bus2ip_reg_wrce <= (others => '0');
        ARB_DBus        <= (others => '0');
        ARB_ErrAck      <= '0';
        ARB_Retry       <= '0';
        ARB_ToutSup     <= '0';
        ARB_XferAck     <= '0';
        clk             <= OPB_Clk;
        rst             <= OPB_Rst;
    end generate NO_OPBSLAVE_GEN;


    ------------------------------------------------------------------------
    -- ARBITRATION_LOGIC determines the priority level of each recieved
    -- Master's request and determines the intermediate grant signal for
    -- each Master.
    ------------------------------------------------------------------------

    ARB_LOGIC_I: entity opb_v20_v1_10_d.arbitration_logic
        generic map (C_NUM_MASTERS      => C_NUM_MASTERS,
                     C_NUM_MID_BITS     => NUM_MID_BITS,
                     C_OPBDATA_WIDTH    => C_OPBDATA_WIDTH,
                     C_DYNAM_PRIORITY   => C_DYNAM_PRIORITY,
                     C_REG_GRANTS       => C_REG_GRANTS)
        port map (
                  OPB_select    => OPB_select,
                  OPB_xferAck   => OPB_xferAck,
                  M_request     => M_request(0 to C_NUM_MASTERS-1),
                  Bus_park      => bus_park,
                  Any_mgrant    => any_mgrant,
                  OPB_buslock   => OPB_buslock,
                  Priority_ids  => Priority_IDs(0 to
                                        C_NUM_MASTERS * NUM_MID_BITS-1),
                  Arb_cycle     => arb_cycle,
                  Grant         => grant(0 to C_NUM_MASTERS-1),
                  Clk           => clk,
                  Rst           => rst);

    ---------------------------------------------------------------------------
    -- PARK_LOCK_LOGIC determines which Master has locked the bus (if any) and
    -- which Master the bus should park on (if enabled). It then determines the
    -- final grant signal for each Master based on the intermediate grants from
    -- the arbitration logic and the park/lock status of the bus. If parking is
    -- not supported, this block eliminates the park logic.
    ---------------------------------------------------------------------------
    PARK_LOCK_I: entity opb_v20_v1_10_d.park_lock_logic
        generic map (C_NUM_MASTERS  => C_NUM_MASTERS,
                     C_NUM_MID_BITS => NUM_MID_BITS,
                     C_PARK         => C_PARK,
                     C_REG_GRANTS   => C_REG_GRANTS)
        port map (
                  Arb_cycle             => arb_cycle,
                  OPB_buslock           => OPB_buslock,
                  Park_master_notlast   => ctrl_reg(PMN_LOC),
                  Park_master_id        => ctrl_reg(PMID_START_LOC to C_OPBDATA_WIDTH-1),
                  Park_enable           => ctrl_reg(PEN_LOC),
                  Grant                 => grant(0 to C_NUM_MASTERS-1),
                  M_request             => M_request(0 to C_NUM_MASTERS-1),
                  Bus_park              => bus_park,
                  Any_mgrant            => any_mgrant,
                  OPB_Mgrant            => opb_mgrant_i(0 to C_NUM_MASTERS-1),
                  Mgrant                => mgrant(0 to C_NUM_MASTERS-1),
                  MGrant_n              => mgrant_n(0 to C_NUM_MASTERS-1),
                  Clk                   => clk,
                  Rst                   => rst);

end generate MULTI_MASTER_GEN;

end implementation;

