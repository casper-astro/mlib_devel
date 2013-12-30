-------------------------------------------------------------------------------
-- $Id: priority_reg.vhd,v 1.1.2.1 2009/10/06 21:15:02 gburch Exp $
-------------------------------------------------------------------------------
-- priority_reg.vhd - entity/architecture pair
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
-- Filename:        priority_reg.vhd
-- Version:         v1.02e
-- Description:
--                  This file contains a priority register for each priority
--                  level. A generic is passed in to specify the reset value
--                  of the register. This register is either loaded with data
--                  from the OPB or new data is shifted in based on the
--                  priority of the master last granted the bus.
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
library opb_v20_v1_10_d;
use opb_v20_v1_10_d.proc_common_pkg.all;

-------------------------------------------------------------------------------
-- Port Declaration
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Definition of Generics:
--          C_RESET_VALUE       -- Reset value for the register
--          C_NUM_MID_BITS      -- number of bits required to encode master IDs
--          C_OPBDATA_WIDTH     -- width of OPB data bus
--
-- Definition of Ports:
--
--      --  OPB Interface
--      input Priorreg_wrce     -- Priority register write clock enable
--      input Bus2ip_data       -- data to be loaded into priority register
--
--      --  Control Register bits
--      input Dpen              -- Dynamic Priority Enable
--
--      --  Shift Signals
--      input Shift             -- Shift enable
--      input Master_id_in      -- Data to be shifted in
--      output Master_id_out    -- Data for next priority register
--      output Priority         --  Priority register output
--
--      --  Clock and Reset
--      input Clk;
--      input Rst;
-------------------------------------------------------------------------------

-----------------------------------------------------------------------------
-- Entity section
-----------------------------------------------------------------------------
entity priority_reg is
  generic (
           C_RESET_VALUE    : std_logic_vector;
           C_NUM_MID_BITS   : integer   := 2;
           C_OPBDATA_WIDTH  : integer   := 32
           );
  port (
        Priorreg_wrce   : in std_logic;
        Bus2ip_data     : in std_logic_vector(0 to C_OPBDATA_WIDTH-1);
        Dpen            : in std_logic;
        Shift           : in std_logic;
        Master_id_in    : in std_logic_vector(0 to C_NUM_MID_BITS-1);
        Master_id_out   : out std_logic_vector(0 to C_NUM_MID_BITS-1);
        Priority        : out std_logic_vector(0 to C_OPBDATA_WIDTH-1);
        Clk             : in std_logic;
        Rst             : in std_logic
        );

end priority_reg;


-----------------------------------------------------------------------------
-- Architecture section
-----------------------------------------------------------------------------
architecture implementation of priority_reg is

-------------------------------------------------------------------------------
--  Constant Declarations
-------------------------------------------------------------------------------
-- data is right justified in register data, calculate bit location to store
-- actual data
constant BIT_INDEX : integer := C_OPBDATA_WIDTH - C_NUM_MID_BITS;

-------------------------------------------------------------------------------
-- Signal and Type Declarations
-------------------------------------------------------------------------------

-- internal master id signal that will be assigned to output ports
signal master_id : std_logic_vector(0 to C_NUM_MID_BITS-1);

-- zero sig is used to pad the priority output with leading zeros
signal zero_sig : std_logic_vector(0 to BIT_INDEX-1);

-----------------------------------------------------------------------------
-- Begin architecture
-----------------------------------------------------------------------------
begin

-------------------------------------------------------------------------------
-- PRIORITY_REG_PROCESS
-------------------------------------------------------------------------------
-- This process loads data from the OPB when there is a write request and this
-- register is enabled. If there is not a load from the OPB and dynamic
-- priority is enabled, the shift input from the SHIFT_LVLx logic will allow
-- a new Master ID to be loaded into the register.
-------------------------------------------------------------------------------

  PRIORITY_REG_PROCESS:process (Clk, Rst, Priorreg_wrce, Dpen, Shift,
                                Bus2ip_data, Master_id_in, master_id)
  begin   -- process
    if Clk'event and Clk = '1' then
      if Rst = RESET_ACTIVE then
            master_id <= C_RESET_VALUE;
      elsif Priorreg_wrce = '1' then
            master_id <= Bus2ip_data(BIT_INDEX to C_OPBDATA_WIDTH-1);
      elsif (Dpen = '1' and Shift = '1') then
            master_id <= Master_id_in;
      else
            master_id <= master_id;
      end if;
    end if;
  end process;


-------------------------------------------------------------------------------
-- Output Generation
-------------------------------------------------------------------------------
zero_sig <= (others => '0');
Priority <= zero_sig & master_id;

Master_id_out <= master_id;

end implementation;
