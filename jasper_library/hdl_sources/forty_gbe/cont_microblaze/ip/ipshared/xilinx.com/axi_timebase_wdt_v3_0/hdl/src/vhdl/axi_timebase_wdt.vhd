-------------------------------------------------------------------------------
-- axi_timebase_wdt - entity/architecture pair
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
-- Filename        :axi_timebase_wdt.vhd
-- Company         :Xilinx
-- Version         :v2.0
-- Description     :32-bit timebase counter and Watch Dog Timer (WDT)
-- Standard        :VHDL-93
-------------------------------------------------------------------------------
-- Structure:   This section shows the hierarchical structure of
--              axi_timebase_wdt.
--
--              axi_timebase_wdt.vhd
--                 -- axi_lite_ipif.vhd
--                 -- timebase_wdt_core.vhd
--
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
--                              -- Updated with axi lite ipuif v1.01.a
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

entity axi_timebase_wdt is
 generic 
  ( C_FAMILY             : string    := "virtex5";
  -- Timebase watchdog timer generics
    C_WDT_INTERVAL       : integer range 8 to 31  := 30;
    C_WDT_ENABLE_ONCE    : integer range 0 to 1   := 1;
  -- axi lite ipif block generics
    C_S_AXI_DATA_WIDTH: integer  range 32 to 32   := 32;
    C_S_AXI_ADDR_WIDTH: integer                   := 4
  );  
  port 
  (
    freeze             : in   std_logic;
  -- timebase watchdog timer interface
    wdt_reset          : out std_logic;
    timebase_interrupt : out std_logic;
    wdt_interrupt      : out std_logic;
    
    --system signals
    s_axi_aclk        : in  std_logic;
    s_axi_aresetn     : in  std_logic := '1';
    s_axi_awaddr      : in  std_logic_vector (3 downto 0);
                        --(c_s_axi_addr_width-1 downto 0);
    s_axi_awvalid     : in  std_logic;
    s_axi_awready     : out std_logic;
    s_axi_wdata       : in  std_logic_vector (31 downto 0);
                        --(c_s_axi_data_width-1 downto 0);
    s_axi_wstrb       : in  std_logic_vector (3 downto 0);
                        --((c_s_axi_data_width/8)-1 downto 0);
    s_axi_wvalid      : in  std_logic;
    s_axi_wready      : out std_logic;
    s_axi_bresp       : out std_logic_vector(1 downto 0);
    s_axi_bvalid      : out std_logic;
    s_axi_bready      : in  std_logic;
    s_axi_araddr      : in  std_logic_vector (3 downto 0);
                        --(c_s_axi_addr_width-1 downto 0);
    s_axi_arvalid     : in  std_logic;
    s_axi_arready     : out std_logic;
    s_axi_rdata       : out std_logic_vector (31 downto 0);
                        --(c_s_axi_data_width-1 downto 0);
    s_axi_rresp       : out std_logic_vector(1 downto 0);
    s_axi_rvalid      : out std_logic;
    s_axi_rready      : in  std_logic
  );

-------------------------------------------------------------------------------
-- Attributes
-------------------------------------------------------------------------------
-- Fan-Out attributes for XST
ATTRIBUTE MAX_FANOUT                     : string;
ATTRIBUTE MAX_FANOUT   of s_axi_aclk     : signal is "10000";
ATTRIBUTE MAX_FANOUT   of s_axi_aresetn  : signal is "10000";

end entity axi_timebase_wdt;

-------------------------------------------------------------------------------
-- Architecture section
-------------------------------------------------------------------------------

architecture imp of axi_timebase_wdt is
-- Pragma Added to supress synth warnings
attribute DowngradeIPIdentifiedWarnings: string;
attribute DowngradeIPIdentifiedWarnings of imp : architecture is "yes";

 --Parameters captured for webtalk
   --C_FAMILY
   --C_WDT_INTERVAL
   --C_WDT_ENABLE_ONCE
 

-------------------------------------------------------------------------------
-- Constant declarations
-------------------------------------------------------------------------------

constant ZEROES                 : std_logic_vector(0 to 31) := X"00000000";
constant C_ARD_ADDR_RANGE_ARRAY : SLV64_ARRAY_TYPE :=
        (
          -- TBWDT registers Base Address
          ZEROES & X"0000_0000",
          ZEROES & (X"0000_0000" or X"0000_000F") 
        );

constant C_ARD_NUM_CE_ARRAY     : INTEGER_ARRAY_TYPE :=
        (
          0 => 4
        );
constant C_USE_WSTRB            :integer := 1;
constant C_S_AXI_MIN_SIZE       :std_logic_vector(31 downto 0):= X"0000000F";
constant C_DPHASE_TIMEOUT       :integer range 0 to 256   := 32;
-------------------------------------------------------------------------------
--  Function Declarations
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Bitwise AND of a std_logic_vector.
-------------------------------------------------------------------------------
    function and_reduce(slv : std_logic_vector) return std_logic is
        variable r : std_logic := '1';
    begin
        for i in slv'range loop
            r := r and slv(i);
        end loop;
        return r;
    end and_reduce;
-------------------------------------------------------------------------------
-- Signal declarations
-------------------------------------------------------------------------------

signal bus2ip_clk      : std_logic;                    
signal bus2ip_reset    : std_logic; 
signal bus2ip_resetn   : std_logic;
signal ip2bus_data     : std_logic_vector(0 to C_S_AXI_DATA_WIDTH - 1):= 
                         (others  => '0');
signal ip2bus_error    : std_logic := '0';
signal ip2bus_wrack    : std_logic := '0';
signal ip2bus_rdack    : std_logic := '0';

signal bus2ip_data     : std_logic_vector
                         (0 to C_S_AXI_DATA_WIDTH - 1);
signal bus2ip_addr     : std_logic_vector(0 to C_S_AXI_ADDR_WIDTH - 1 );
signal bus2ip_be       : std_logic_vector
                         (0 to C_S_AXI_DATA_WIDTH / 8 - 1 );
signal bus2ip_cs       : std_logic_vector
                         (0 to ((C_ARD_ADDR_RANGE_ARRAY'LENGTH)/2)-1);
signal bus2ip_rdce     : std_logic_vector
                         (0 to calc_num_ce(C_ARD_NUM_CE_ARRAY)-1);
signal bus2ip_wrce     : std_logic_vector
                         (0 to calc_num_ce(C_ARD_NUM_CE_ARRAY)-1);

begin  -- VHDL_RTL

ip2bus_error <= bus2ip_cs(0) and not and_reduce(bus2ip_be);

-------------------------------------------------------------------------------
-- Instantiate the Timebase Watchdog Timer core
-------------------------------------------------------------------------------

TIMEBASE_WDT_CORE_I: entity axi_timebase_wdt_v3_0_1.timebase_wdt_core
  generic map 
       (
        C_FAMILY              => C_FAMILY,
        C_WDT_INTERVAL        => C_WDT_INTERVAL,
        C_WDT_ENABLE_ONCE     => C_WDT_ENABLE_ONCE /= 0,
        C_NATIVE_DWIDTH       => C_S_AXI_DATA_WIDTH
       )  
  port map 
       (
        Clk                   => bus2ip_clk,
        Reset                 => bus2ip_reset,
        Freeze                => freeze,
        IP2Bus_Data           => ip2bus_data,
        IP2Bus_WrAck          => ip2bus_wrack,
        IP2Bus_RdAck          => ip2bus_rdack,
        Bus2IP_Data           => bus2ip_data,
        Bus2IP_RdCE           => bus2ip_rdce,
        Bus2IP_WrCE           => bus2ip_wrce,                                
        WDT_Reset             => wdt_reset,          --[out]
        Timebase_Interrupt    => timebase_interrupt, --[out]
        WDT_Interrupt         => wdt_interrupt       --[out]
       );

    ---------------------------------------------------------------------
    -- INSTANTIATE AXI Lite IPIF
    ---------------------------------------------------------------------
    AXI4_LITE_I : entity axi_lite_ipif_v3_0_4.axi_lite_ipif
      generic map
           (
        C_S_AXI_DATA_WIDTH    => C_S_AXI_DATA_WIDTH,
        C_S_AXI_ADDR_WIDTH    => C_S_AXI_ADDR_WIDTH,
        C_S_AXI_MIN_SIZE      => C_S_AXI_MIN_SIZE,
        C_USE_WSTRB           => C_USE_WSTRB,
        C_DPHASE_TIMEOUT      => C_DPHASE_TIMEOUT,
        C_ARD_ADDR_RANGE_ARRAY=> C_ARD_ADDR_RANGE_ARRAY,
        C_ARD_NUM_CE_ARRAY    => C_ARD_NUM_CE_ARRAY,
        C_FAMILY              => C_FAMILY
           )
     port map
        (
        S_AXI_ACLK            => s_axi_aclk,
        S_AXI_ARESETN         => s_axi_aresetn,
        S_AXI_AWADDR          => s_axi_awaddr,
        S_AXI_AWVALID         => s_axi_awvalid,
        S_AXI_AWREADY         => s_axi_awready,
        S_AXI_WDATA           => s_axi_wdata,
        S_AXI_WSTRB           => s_axi_wstrb,
        S_AXI_WVALID          => s_axi_wvalid,
        S_AXI_WREADY          => s_axi_wready,
        S_AXI_BRESP           => s_axi_bresp,
        S_AXI_BVALID          => s_axi_bvalid,
        S_AXI_BREADY          => s_axi_bready,
        S_AXI_ARADDR          => s_axi_araddr,
        S_AXI_ARVALID         => s_axi_arvalid,
        S_AXI_ARREADY         => s_axi_arready,
        S_AXI_RDATA           => s_axi_rdata,
        S_AXI_RRESP           => s_axi_rresp,
        S_AXI_RVALID          => s_axi_rvalid,
        S_AXI_RREADY          => s_axi_rready,
         -- IP Interconnect (IPIC) port signals --------------------------------
        Bus2IP_Clk            => bus2ip_clk,
        Bus2IP_Resetn         => bus2ip_resetn,
        IP2Bus_Data           => ip2bus_data,
        IP2Bus_WrAck          => ip2bus_wrack,
        IP2Bus_RdAck          => ip2bus_rdack,
        IP2Bus_Error          => ip2bus_error,
        Bus2IP_Addr           => bus2ip_addr,
        Bus2IP_Data           => bus2ip_data,
        Bus2IP_RNW            => open,
        Bus2IP_BE             => bus2ip_be,
        Bus2IP_CS             => bus2ip_cs,
        Bus2IP_RdCE           => bus2ip_rdce,
        Bus2IP_WrCE           => bus2ip_wrce                                
    );
bus2ip_reset <= not bus2ip_resetn;
end imp;
-------------------------------------------------------------------------------
--END OF FILE
-------------------------------------------------------------------------------

