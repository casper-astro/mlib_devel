-------------------------------------------------------------------------------
-- window_wdt_counter - entity/architecture pair
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
-- Filename        :window_wdt_counter.vhd
-- Company         :Xilinx
-- Version         :v3.0
-- Description     :32-bit timebase counter and Watch Dog Timer (WDT)
-- Standard        :VHDL-93
-------------------------------------------------------------------------------
-- Structure:   This section shows the hierarchical structure of
--              window_wdt_counter
--
--              axi_timebase_wdt_top.vhd
--              -- axi_timebase_windowing.vhd
--                 -- window_wdt_fail_cnt.vhd
--                 -- window_wdt_counter.vhd
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
--  C_TIMER_WIDTH    -- Counter width 
-------------------------------------------------------------------------------
--                  Definition of Ports
-------------------------------------------------------------------------------
--window_wdt_counter signals 
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

entity window_wdt_counter is
 generic 
       (
        C_FAMILY             : string    := "virtex5";
        C_TIMER_WIDTH     : integer range 1 to 32  := 7 
       );  
  port 
       (
        Clk                   : in  std_logic;
        Reset                 : in  std_logic;
        load_val              : in  std_logic_vector (C_TIMER_WIDTH-1 downto 0);
        load_cnt              : in  std_logic;
        -- Fail Counter enable bit 2nd bit of control reg 0x14
        --sst_en                : in  std_logic;
        cnt_en                : in  std_logic;
        int_clr               : in  std_logic;
        cur_cnt_val           : out  std_logic_vector (C_TIMER_WIDTH-1 downto 0);
        -- Interrupt Generation
        sbc                   : in  std_logic_vector (7 downto 0);
        bss                   : in  std_logic_vector (1 downto 0);
        sws                   : in  std_logic; -- Second Window Start
        wint                  : out  std_logic; -- WDT interrupt
        -- If cnt_val is 1 then it is bad event
        dis_wdt               : out  std_logic
       );
end entity window_wdt_counter;

architecture wc_imp of window_wdt_counter is

constant ZEROES                 : std_logic_vector(C_TIMER_WIDTH-1 downto 0) := (others  => '0');
constant ONES                 : std_logic_vector(C_TIMER_WIDTH-1 downto 0) := (others  => '1');
constant ONE                 : std_logic_vector(C_TIMER_WIDTH-1 downto 0) := ZEROES(C_TIMER_WIDTH-1 downto 1) & '1';--(0 => '1', others  => '0');

    
signal int_cnt_int        : std_logic_vector(C_TIMER_WIDTH-1 downto 0):=(others  => '0');
signal dis_wdt_int        : std_logic:='0';
signal wint_int           : std_logic:='0';
signal cnt_int            : std_logic_vector(31 downto 0):=(others  => '0');
constant ALL_ZEROES       : std_logic_vector(31 downto 0) := (others  => '0');
-------------------------------------------------------------------------------
    function intgen(bss : std_logic_vector(1 downto 0);sbc : std_logic_vector(7 downto 0);cnt_val : std_logic_vector (31 downto 0))return std_logic is
        variable val : std_logic := '0';
    begin
        case bss is
            when "00" => if(sbc = cnt_val(7 downto 0) and cnt_val(31 downto 8) = ALL_ZEROES(31 downto 8)) then
                         val := '1' ;
                         else 
                             val := '0';
                         end if;
            when "01" => if(cnt_val(7 downto 0) = ALL_ZEROES(7 downto 0) and sbc = cnt_val(15 downto 8) and cnt_val(31 downto 16) = ALL_ZEROES(31 downto 16)) then
                         val := '1' ;
                         else 
                             val := '0';
                         end if;
            when "10" => if(cnt_val(15 downto 0) = ALL_ZEROES(15 downto 0) and sbc = cnt_val(23 downto 16) and cnt_val(31 downto 24) = ALL_ZEROES(31 downto 24)) then
                         val := '1' ;
                         else 
                             val := '0';
                         end if;
            when "11" => if(cnt_val(23 downto 0) = ALL_ZEROES(23 downto 0) and sbc = cnt_val(31 downto 24)) then
                         val := '1' ;
                         else 
                             val := '0';
                         end if;
            WHEN  OTHERS =>  val := '0';        
        end case;
        return val;
    end intgen;


begin
    cnt_int(C_TIMER_WIDTH-1 downto 0) <= int_cnt_int;
      WC_PROC_I: Process (Clk)
       begin
        if (Clk'event and Clk = '1') then
            if (Reset = '1') then
                int_cnt_int <= (others => '0');
                --dis_wdt_int   <= '0';
            elsif load_cnt = '1' then
                int_cnt_int <=  load_val;
                --dis_wdt_int   <= '0';
            elsif (cnt_en = '1') then
                   int_cnt_int <=  int_cnt_int - '1';
            end if;
        end if;
     end process WC_PROC_I;
     DIS_PROC_I: Process (Clk)
       begin
        if (Clk'event and Clk = '1') then
                  if (int_cnt_int = ONE) then
                    dis_wdt_int   <= '1';
                  else
                    dis_wdt_int   <= '0';
                  end if;
        end if;
     end process DIS_PROC_I;

     WINT_PROC_I: Process (Clk)
       begin
        if (Clk'event and Clk = '1') then
            if (Reset = '1') then
                wint_int   <= '0';
            elsif (cnt_en = '1' and sws = '1' and wint_int = '0') then
                wint_int   <= intgen(bss,sbc,cnt_int);            
            elsif(int_clr = '1' and wint_int = '1') then
                wint_int   <= '0';
            elsif(cnt_en = '0' or sws = '0') then
                wint_int   <= '0';
            end if;
        end if;
     end process WINT_PROC_I;

cur_cnt_val <= int_cnt_int;
dis_wdt <= dis_wdt_int;
wint <= wint_int;
end wc_imp;
