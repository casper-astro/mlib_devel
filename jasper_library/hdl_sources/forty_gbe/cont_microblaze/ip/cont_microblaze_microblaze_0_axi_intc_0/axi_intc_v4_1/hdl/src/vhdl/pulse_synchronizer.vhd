-------------------------------------------------------------------
-- (c) Copyright 1984 - 2012 Xilinx, Inc. All rights reserved.
--
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
--
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
--
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
--
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-------------------------------------------------------------------

-- *******************************************************************
--
-------------------------------------------------------------------------------
-- Filename   : pulse_synchronizer.vhd
-- Version    : v3.0
-- Description: The pulse_synchronizer is having the double flop synchronization logic
--
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:
-------------------------------------------------------------------------------
-- Author:     NLR
-- History:
--   NLR      3/21/2011   Initial version
-- ^^^^^^^
--  ^^^^^^^
--  SK     10/10/12
--
--  1. Added cascade mode support in v1.03.a version of the core
-- 2.  Updated major version of the core
-- ~~~~~~
-- ~~~~~~
--  SK       12/16/12      -- v3.0
--  1. up reved to major version for 2013.1 Vivado release. No logic updates.
--  2. Updated the version of AXI LITE IPIF to v2.0 in X.Y format
--  3. updated the proc common version to proc_common_v4_0
--  4. No Logic Updates
-- ^^^^^^
-------------------------------------------------------------------------------
-- Naming Conventions:
--      active low signals:                     "*N"
--      clock signals:                          "clk", "clk_div#", "clk_#x"
--      reset signals:                          "rst", "rst_n"
--      generics:                               "C_*"
--      user defined types:                     "*_TYPE"
--      state machine next state:               "*_ns"
--      state machine current state:            "*_cs"
--      counter signals:                        "*cntr*", "*count*"
--      ports:                                  - Names in Uppercase
--      processes:                              "*_REG", "*_CMB"
--      component instantiations:               "<ENTITY_>MODULE<#|_FUNC>
-------------------------------------------------------------------------------

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_unsigned.all;

library axi_intc_v4_1;
    use axi_intc_v4_1.all;

entity pulse_synchronizer is
  port (
     CLK_1             : in std_logic;
     RESET_1_n         : in std_logic;   -- active low reset
     DATA_IN           : in std_logic;
     CLK_2             : in std_logic;
     RESET_2_n         : in std_logic;   -- active low reset
     SYNC_DATA_OUT     : out std_logic
    );
end entity;

architecture RTL of pulse_synchronizer is
  signal data_in_toggle          : std_logic;
  signal data_in_toggle_sync     : std_logic;
  signal data_in_toggle_sync_d1  : std_logic;
  --------------------------------------------------------------------------------------
  -- Function to convert std_logic to std_logic_vector
  --------------------------------------------------------------------------------------
  Function scalar_to_vector (scalar_in : std_logic) return std_logic_vector is
  variable vec_out                : std_logic_vector(0 downto 0) := "0";
  begin
      vec_out(0) := scalar_in;
  return vec_out;
  end function scalar_to_vector;

  --------------------------------------------------------------------------------------
  -- Function to convert std_logic_vector to std_logic
  --------------------------------------------------------------------------------------
  Function vector_to_scalar (vec_in : std_logic_vector) return std_logic is
  variable scalar_out                : std_logic := '0';
  begin
      scalar_out := vec_in(0);
  return scalar_out;
  end function vector_to_scalar;

begin


  TOGGLE_DATA_IN_REG:process(CLK_1)
  begin
    if(CLK_1'event and CLK_1 = '1') then
      if(RESET_1_n = '0') then
        data_in_toggle <= '0';
      else
        data_in_toggle <= DATA_IN xor data_in_toggle;
      end if;
    end if;
  end process TOGGLE_DATA_IN_REG;

  DOUBLE_SYNC_I : entity axi_intc_v4_1.double_synchronizer
    generic map (
      C_DWIDTH => 1
    )
    port map (
        CLK_2                           => CLK_2,
        RESET_2_n                       => RESET_2_n,
        DATA_IN                         => scalar_to_vector(data_in_toggle),
        vector_to_scalar(SYNC_DATA_OUT) => data_in_toggle_sync
      );

  SYNC_DATA_REG:process(CLK_2)
  begin
    if(CLK_2'event and CLK_2 = '1') then
      if(RESET_2_n = '0') then
        data_in_toggle_sync_d1 <= '0';
      else
        data_in_toggle_sync_d1 <= data_in_toggle_sync;
      end if;
    end if;
  end process SYNC_DATA_REG;

  SYNC_DATA_OUT <= data_in_toggle_sync xor data_in_toggle_sync_d1;


end RTL;
