-------------------------------------------------------------------------------
-- window_wdt_fail_cnt - entity/architecture pair
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
-- Filename        :window_wdt_fail_cnt.vhd
-- Company         :Xilinx
-- Version         :v3.0
-- Description     :32-bit timebase counter and Watch Dog Timer (WDT)
-- Standard        :VHDL-93
-------------------------------------------------------------------------------
-- Structure:   This section shows the hierarchical structure of
--              window_wdt_fail_cnt
--
--              axi_timebase_wdt_top.vhd
--              -- axi_timebase_windowing.vhd
--                 -- window_wdt_fail_cnt.vhd
--              -- axi_timebase_wdt.vhd
--                 -- axi_lite_ipif.vhd
--                 -- timebase_wdt_core.vhd
--
-------------------------------------------------------------------------------
-- ^^^^^^
-- Author:      Kartheek
-- History:
--  Kartheek    25/11/2015      -- Ceated the version  v3.00
-- ^^^^^^
-- ^^^^^^
--
-------------------------------------------------------------------------------
--------------------------------------------------------------------------------
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
-- C_FAMILY              -- Target FPGA family
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- WINDOW-WDT generics
--  C_FAIL_CNT_WIDTH    -- Fail Counter width 
-------------------------------------------------------------------------------
--                  Definition of Ports
-------------------------------------------------------------------------------
--window_wdt_fail_cnt signals 
-------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------  fail_cnt             -- Fail Counter Value
--  dis_wdt              -- Disbale wdt


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned."+";
use IEEE.std_logic_unsigned."-";
library axi_timebase_wdt_v3_0_1;
-------------------------------------------------------------------------------
-- Entity section
-------------------------------------------------------------------------------

entity window_wdt_fail_cnt is
 generic 
       (
        C_FAMILY             : string    := "virtex5";
        C_FAIL_CNT_WIDTH     : integer range 1 to 7  := 3 
       );  
  port 
       (
        Clk                   : in  std_logic;
        Reset                 : in  std_logic;
        fail_cnt              : out std_logic_vector (C_FAIL_CNT_WIDTH-1 downto 0);
        fc_en                 : in  std_logic;
        -- Fail Counter enable bit 2nd bit of control reg 0x14
        cnt_en                : in  std_logic;
        cnt_val               : in  std_logic;
        -- If cnt_val is 1 then it is bad event
        dis_wdt               : out  std_logic
       );
end entity window_wdt_fail_cnt;

architecture fc_imp of window_wdt_fail_cnt is

constant ZEROES                 : std_logic_vector(C_FAIL_CNT_WIDTH-1 downto 0) := (others  => '0');
constant ONES                 : std_logic_vector(C_FAIL_CNT_WIDTH-1 downto 0) := (others  => '1');

    
signal fail_cnt_int        : std_logic_vector(C_FAIL_CNT_WIDTH-1 downto 0):="101";
signal fc_en_d             : std_logic:='0';
signal fc_en_edge          : std_logic;
signal dis_wdt_int          : std_logic:='0';

begin

FC_END_I: Process (Clk)
begin
   if (Clk'event and Clk = '1') then
       if (Reset = '1') then
           fc_en_d   <= '0';
       else
           --fail_cnt_int <=  ZEROES;
           fc_en_d   <= fc_en;
        end if;
    end if;
end process FC_END_I;
fc_en_edge <= '1' when (fc_en = '1' and fc_en_d = '0') else '0';

FC_PROC_I: Process (Clk)
begin
   if (Clk'event and Clk = '1') then
       if (Reset = '1') then
           fail_cnt_int <=  "101";
           dis_wdt_int   <= '0';
       elsif fc_en = '0' then
           --fail_cnt_int <=  ZEROES;
           dis_wdt_int   <= '1';
       elsif fc_en_edge = '1' then
           --fail_cnt_int <=  ZEROES;
           dis_wdt_int   <= '0';
       elsif cnt_en = '1' then
           dis_wdt_int   <= '0';
           if (cnt_val = '1') then
             if (fail_cnt_int = ONES) then
               fail_cnt_int <=  ONES;
             else
               fail_cnt_int <= fail_cnt_int+"001";
               --dis_wdt_int   <= '0';
             end if;
           else
               --dis_wdt_int   <= '0';
             if (fail_cnt_int = ZEROES) then
               fail_cnt_int <=  ZEROES;
             else
               fail_cnt_int <= fail_cnt_int-"001";
             end if;
           end if;
       end if;
   end if;
end process FC_PROC_I;

fail_cnt <= fail_cnt_int;
dis_wdt <= '1' when (fail_cnt_int = ONES) else dis_wdt_int;

end fc_imp;
