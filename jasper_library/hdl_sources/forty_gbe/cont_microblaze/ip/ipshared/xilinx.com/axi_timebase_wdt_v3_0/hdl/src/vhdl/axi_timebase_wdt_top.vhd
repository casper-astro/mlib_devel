-------------------------------------------------------------------------------
-- axi_timebase_wdt_top - entity/architecture pair
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
-- Filename        :axi_timebase_wdt_top.vhd
-- Company         :Xilinx
-- Version         :v2.0
-- Description     :32-bit timebase counter and Watch Dog Timer (WDT)
-- Standard        :VHDL-93
-------------------------------------------------------------------------------
-- Structure:   This section shows the hierarchical structure of
--              axi_timebase_wdt.
--
--              axi_timebase_wdt_top.vhd
--              -- axi_timebase_windowing.vhd
--              -- axi_timebase_wdt.vhd
--                 -- axi_lite_ipif.vhd
--                 -- timebase_wdt_core.vhd
--
-------------------------------------------------------------------------------
-- ^^^^^^
-- Author:      Kartheek
-- History:
--  Kartheek    23/11/2015      -- Ceated the version  v2.00
-- ^^^^^^
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
-- C_S_AXI_DATA_WIDTH    -- AXI data bus width
-- C_S_AXI_ADDR_WIDTH    -- AXI address bus width
-- C_FAMILY              -- Target FPGA family
-------------------------------------------------------------------------------
-- WDT generics
--  C_WDT_INTERVAL       -- Watchdog Timer Interval = 2**C_WDT_INTERVAL clocks
--                           Defaults to 2**31 clock cycles 
--                           (** is exponentiation)
--  C_WDT_ENABLE_ONCE    -- WDT enable behavior. If TRUE (1),once the WDT has 
--                           been enabled, it can only be disabled by RESET.
--                           Defaults to FALSE;
-------------------------------------------------------------------------------
-- WINDOW-WDT generics
--  Enable Window WDT    -- ENabling the windowing feature
--  SST Count Width      -- Second sequence timer maximum width
--  Max Count Width      -- First timer maximum width
-------------------------------------------------------------------------------
--                  Definition of Ports
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- s_axi_aclk            -- AXI Clock
-- s_axi_aresetn         -- AXI Reset
-- s_axi_awaddr          -- AXI Write address
-- s_axi_awvalid         -- Write address valid
-- s_axi_awready         -- Write address ready
-- s_axi_wdata           -- Write data
-- s_axi_wstrb           -- Write strobes
-- s_axi_wvalid          -- Write valid
-- s_axi_wready          -- Write ready
-- s_axi_bresp           -- Write response
-- s_axi_bvalid          -- Write response valid
-- s_axi_bready          -- Response ready
-- s_axi_araddr          -- Read address
-- s_axi_arvalid         -- Read address valid
-- s_axi_arready         -- Read address ready
-- s_axi_rdata           -- Read data
-- s_axi_rresp           -- Read response
-- s_axi_rvalid          -- Read valid
-- s_axi_rready          -- Read ready
-------------------------------------------------------------------------------
-- Timebase WDT signals 
-------------------------------------------------------------------------------
-- freeze                -- Freeze count value
-- wdt interface
-- wdt_reset             -- Output. Watchdog Timer Reset
-- timebase_interrupt    -- Output. Timebase Interrupt
-- wdt_interrupt         -- Output. Watchdog Timer Interrupt
-- Window Watchdog signals
-- wdt_reset_pending     -- Output, Indicates Window WDT reset will be asserted after SST count expires.
-- wdt_state_vec         -- Output, Indicates Window WDT reset will be asserted after SST count expires.
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
library axi_lite_ipif_v3_0_4;
use axi_lite_ipif_v3_0_4.ipif_pkg.SLV64_ARRAY_TYPE;
use axi_lite_ipif_v3_0_4.ipif_pkg.INTEGER_ARRAY_TYPE;
use axi_lite_ipif_v3_0_4.ipif_pkg.calc_num_ce;
library axi_lite_ipif_v3_0_4;
library axi_timebase_wdt_v3_0_1;
-------------------------------------------------------------------------------
-- Entity section
-------------------------------------------------------------------------------


entity axi_timebase_wdt_top is
 generic 
  ( C_FAMILY             : string    := "virtex5";
  -- Timebase watchdog timer generics
    C_WDT_INTERVAL       : integer range 8 to 31  := 30;
    C_WDT_ENABLE_ONCE    : integer range 0 to 1   := 1;
  -- axi lite ipif block generics
    C_S_AXI_DATA_WIDTH   : integer  range 32 to 32   := 32;
    C_S_AXI_ADDR_WIDTH   : integer  range 4 to 6   := 4;
    C_ENABLE_WINDOW_WDT    : integer range 0 to 1   := 0;-- ENabling the windowing feature
    C_SST_COUNT_WIDTH      : integer range 8 to 31  := 8;-- Second sequence timer maximum width
    C_MAX_COUNT_WIDTH      : integer range 8 to 32  := 32
  );  
  port (
    s_axi_araddr : in STD_LOGIC_VECTOR ( C_S_AXI_ADDR_WIDTH-1 downto 0 );
    s_axi_arready : out STD_LOGIC;
    s_axi_arvalid : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( C_S_AXI_ADDR_WIDTH-1 downto 0 );
    s_axi_awready : out STD_LOGIC;
    s_axi_awvalid : in STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rready : in STD_LOGIC;
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wready : out STD_LOGIC;
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    freeze : in STD_LOGIC;
    s_axi_aclk : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    timebase_interrupt : out STD_LOGIC;
    wdt_interrupt : out STD_LOGIC;
    wdt_reset : out STD_LOGIC;
    wdt_reset_pending : out STD_LOGIC;    -- Output, Indicates Window WDT reset will be asserted after SST count expires.
    wdt_state_vec : out STD_LOGIC_VECTOR ( 6 downto 0 )
  );
end axi_timebase_wdt_top;

architecture top_arch of axi_timebase_wdt_top is
begin

    
LEGACY_WDT : if(C_ENABLE_WINDOW_WDT = 0) 
generate
   -----
    begin
   -----

axi_timebase_wdt_i: entity axi_timebase_wdt_v3_0_1.axi_timebase_wdt
generic map 
  ( C_FAMILY              =>    C_FAMILY,
  -- Timebase watchdog timer generics
    C_WDT_INTERVAL        =>     C_WDT_INTERVAL,
    C_WDT_ENABLE_ONCE     =>     C_WDT_ENABLE_ONCE,
  -- axi lite ipif block generics
    C_S_AXI_DATA_WIDTH =>     C_S_AXI_DATA_WIDTH,
    C_S_AXI_ADDR_WIDTH =>     C_S_AXI_ADDR_WIDTH
  ) 
    port map (
      s_axi_araddr => s_axi_araddr,
      s_axi_arready => s_axi_arready,
      s_axi_arvalid => s_axi_arvalid,
      s_axi_awaddr => s_axi_awaddr,
      s_axi_awready => s_axi_awready,
      s_axi_awvalid => s_axi_awvalid,
      s_axi_bready => s_axi_bready,
      s_axi_bresp => s_axi_bresp,
      s_axi_bvalid => s_axi_bvalid,
      s_axi_rdata => s_axi_rdata,
      s_axi_rready => s_axi_rready,
      s_axi_rresp => s_axi_rresp,
      s_axi_rvalid => s_axi_rvalid,
      s_axi_wdata => s_axi_wdata,
      s_axi_wready => s_axi_wready,
      s_axi_wstrb => s_axi_wstrb,
      s_axi_wvalid => s_axi_wvalid,
      freeze => freeze,
      s_axi_aclk => s_axi_aclk,
      s_axi_aresetn => s_axi_aresetn,
      timebase_interrupt => timebase_interrupt,
      wdt_interrupt => wdt_interrupt,
      wdt_reset => wdt_reset
    );
end generate LEGACY_WDT;
 
    WINDOW_WDT : if(C_ENABLE_WINDOW_WDT = 1) 
generate
   -----
    begin
   -----
timebase_interrupt <= '0';
axi_window_wdt_i: entity axi_timebase_wdt_v3_0_1.axi_window_wdt
generic map 
  ( C_FAMILY              =>    C_FAMILY,
  -- Timebase watchdog timer generics
    C_WDT_INTERVAL        =>     C_WDT_INTERVAL,
    C_WDT_ENABLE_ONCE     =>     C_WDT_ENABLE_ONCE,
  -- axi lite ipif block generics
    C_S_AXI_DATA_WIDTH    =>     C_S_AXI_DATA_WIDTH,
    C_S_AXI_ADDR_WIDTH    =>     C_S_AXI_ADDR_WIDTH,
    SST_Count_Width       =>     C_SST_COUNT_WIDTH,
    Max_Count_Width       =>     C_MAX_COUNT_WIDTH
  ) 
    port map (
      s_axi_araddr => s_axi_araddr,
      s_axi_arready => s_axi_arready,
      s_axi_arvalid => s_axi_arvalid,
      s_axi_awaddr => s_axi_awaddr,
      s_axi_awready => s_axi_awready,
      s_axi_awvalid => s_axi_awvalid,
      s_axi_bready => s_axi_bready,
      s_axi_bresp => s_axi_bresp,
      s_axi_bvalid => s_axi_bvalid,
      s_axi_rdata => s_axi_rdata,
      s_axi_rready => s_axi_rready,
      s_axi_rresp => s_axi_rresp,
      s_axi_rvalid => s_axi_rvalid,
      s_axi_wdata => s_axi_wdata,
      s_axi_wready => s_axi_wready,
      s_axi_wstrb => s_axi_wstrb,
      s_axi_wvalid => s_axi_wvalid,
      freeze => freeze,
      s_axi_aclk => s_axi_aclk,
      s_axi_aresetn => s_axi_aresetn,
      --timebase_interrupt => timebase_interrupt,
      wdt_interrupt => wdt_interrupt,
      wdt_reset => wdt_reset,
      wdt_reset_pending => wdt_reset_pending,
      wdt_state_vec    => wdt_state_vec
    );
end generate WINDOW_WDT;

end top_arch;

