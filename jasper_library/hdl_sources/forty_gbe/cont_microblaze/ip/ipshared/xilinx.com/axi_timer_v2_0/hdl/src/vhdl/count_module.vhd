-------------------------------------------------------------------------------
-- count_module - entity/architecture pair
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
-- Filename:        count_module.vhd
-- Version:         v2.0
-- Description:     Module with one counter and load register
--
-------------------------------------------------------------------------------
-- Structure:
--
--              count_module.vhd
--              -- counter_f.vhd

-------------------------------------------------------------------------------
-- ^^^^^^
-- Author:      BSB
-- History:
--  BSB         03/18/2010      -- Ceated the version  v1.00.a
-- ^^^^^^
-- ^^^^^^
-- Author:      BSB
-- History:
--  BSB         09/18/2010      -- Ceated the version  v1.01.a
--                              -- axi lite ipif v1.01.a used
-- ^^^^^^
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
-------------------------------------------------------------------------------
--                     Definition of Generics
-------------------------------------------------------------------------------
-- C_FAMILY          -- Default family
-- C_COUNT_WIDTH     -- Width of the counter
-------------------------------------------------------------------------------
--                  Definition of Ports
-------------------------------------------------------------------------------
-- Clk               -- clock
-- Reset             -- reset
-- Load_DBus         -- Count Load bus
-- Load_Counter_Reg  -- Counter load control
-- Load_Load_Reg     -- Load register control
-- Write_Load_Reg    -- Write Control of TLR reg
-- CaptGen_Mux_Sel   -- Mux select for capture and generate data
-- Counter_En        -- Counter enable
-- Count_Down        -- Count down
-- BE                -- Byte enable
-- LoadReg_DBus      -- Load reg bus
-- CounterReg_DBus   -- Counter reg bus
-- Counter_TC        -- counter Carry out signal
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.FDRE;

library axi_timer_v2_0_11;


-------------------------------------------------------------------------------
-- Entity declarations
-------------------------------------------------------------------------------
entity count_module is
  generic (
    C_FAMILY          : string   := "virtex5";
    C_COUNT_WIDTH     : integer  := 32   
    );
  port (
    Clk               : in  std_logic;
    Reset             : in  std_logic;
    Load_DBus         : in  std_logic_vector(0 to C_COUNT_WIDTH-1);
    Load_Counter_Reg  : in  std_logic;
    Load_Load_Reg     : in  std_logic;
    Write_Load_Reg    : in  std_logic;  
    CaptGen_Mux_Sel   : in  std_logic;
    Counter_En        : in  std_logic;
    Count_Down        : in  std_logic;
    BE                : in  std_Logic_vector(0 to 3);
    LoadReg_DBus      : out std_logic_vector(0 to C_COUNT_WIDTH-1);
    CounterReg_DBus   : out std_logic_vector(0 to C_COUNT_WIDTH-1);
    Counter_TC        : out std_logic
    );
end entity count_module;

-------------------------------------------------------------------------------
-- Architecture section
-------------------------------------------------------------------------------
architecture imp of count_module is

-- Pragma Added to supress synth warnings
attribute DowngradeIPIdentifiedWarnings: string;
attribute DowngradeIPIdentifiedWarnings of imp : architecture is "yes";
--Signal Declaration
signal iCounterReg_DBus   : std_logic_vector(0 to C_COUNT_WIDTH-1);
signal loadRegIn          : std_logic_vector(0 to C_COUNT_WIDTH-1);
signal load_Reg           : std_logic_vector(0 to C_COUNT_WIDTH-1);
signal load_load_reg_be   : std_logic_vector(0 to C_COUNT_WIDTH-1);
signal carry_out          : std_logic;

-------------------------------------------------------------------------------
-- Begin architecture
-------------------------------------------------------------------------------
begin -- Architecture imp

-------------------------------------------------------------------------------
--CAPTGEN_MUX_PROCESS : Process to implement mux the Load_DBus and
--iCounterReg_DBus
-------------------------------------------------------------------------------
    CAPTGEN_MUX_PROCESS: process (CaptGen_Mux_Sel,Load_DBus,iCounterReg_DBus ) is
    begin
      if CaptGen_Mux_Sel='1' then
        loadRegIn <= Load_DBus;
      else
        loadRegIn <= iCounterReg_DBus;
      end if;
    end process CAPTGEN_MUX_PROCESS;

-------------------------------------------------------------------------------
--LOAD_REG_GEN: To generate load register
-------------------------------------------------------------------------------
    LOAD_REG_GEN: for i in 0 to C_COUNT_WIDTH-1 generate
      load_load_reg_be(i) <= Load_Load_Reg or
                             (Write_Load_Reg and BE((i-C_COUNT_WIDTH+32)/8));
      LOAD_REG_I: component FDRE
        port map (
          Q  => load_Reg(i),                -- [out]
          C  => Clk,                        -- [in]
          CE => load_load_reg_be(i),        -- [in]
          D  => loadRegIn(i),               -- [in]
          R  => Reset                       -- [in]
        );
    end generate LOAD_REG_GEN;

-------------------------------------------------------------------------------
--counter_f module is instantiated
-------------------------------------------------------------------------------
    COUNTER_I: entity axi_timer_v2_0_11.counter_f
    generic map (
                C_NUM_BITS => C_COUNT_WIDTH, -- [integer]
                C_FAMILY   => C_FAMILY       -- [string]
               )
        port map(
             Clk           => Clk,              -- [in  std_logic]
             Rst           => Reset,            -- [in  std_logic]
             Load_In       => load_Reg,         -- [in  std_logic_vector]
             Count_Enable  => Counter_En,       -- [in  std_logic]
             Count_Load    => Load_Counter_Reg, -- [in  std_logic]
             Count_Down    => Count_Down,       -- [in  std_logic]
             Count_Out     => iCounterReg_DBus, -- [out std_logic_vector]
             Carry_Out     => carry_out         -- [out std_logic]
            );

    Counter_TC       <= carry_out;
    LoadReg_DBus     <= load_Reg;
    CounterReg_DBus  <= iCounterReg_DBus;

end architecture imp;


