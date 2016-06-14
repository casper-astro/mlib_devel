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
-- Filename   : double_synchronizer.vhd
-- Version    : v3.0
-- Description: The double_synchronizer is having the double flop synchronization logic
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
--      RESET_2 signals:                          "rst", "rst_n"
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

library unisim;
use unisim.vcomponents.FDR;
-------------------------------------------------------------------------------

entity double_synchronizer is
  generic (
      C_DWIDTH : integer range 1 to 32 := 1
  );
  port (
     CLK_2             : in std_logic;
     RESET_2_n         : in std_logic;   -- active_low
     DATA_IN           : in std_logic_vector(C_DWIDTH-1 downto 0);
     SYNC_DATA_OUT     : out std_logic_vector(C_DWIDTH-1 downto 0)
    );
end entity;
-------------------------------------------------------------------------------

architecture RTL of double_synchronizer is

  signal RESET_2_p      : std_logic;
  signal data_in_d1     : std_logic_vector(C_DWIDTH-1 downto 0);
-----
begin
-----
 -- active high Reset
 RESET_2_p <= not RESET_2_n;

    REG_GEN : for i in 0 to (C_DWIDTH - 1) generate

         BLOCK_GEN: block

                 attribute ASYNC_REG : string;
                 attribute ASYNC_REG of FIRST_FLOP_i : label is "TRUE";
         begin

                 FIRST_FLOP_i: component FDR
                   port map (
                              Q  => data_in_d1(i),
                              C  => CLK_2,
                              D  => DATA_IN(i),
                              R  => RESET_2_p
                            );

                 SECOND_FLOP_i: component FDR
                   port map (
                              Q  => SYNC_DATA_OUT(i),
                              C  => CLK_2,
                              D  => data_in_d1(i),
                              R  => RESET_2_p
                            );

         end block BLOCK_GEN;

    end generate REG_GEN;
-------------------------------------------------------------------------------
end RTL;
-------------------------------------------------------------------------------
