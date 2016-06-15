-------------------------------------------------------------------
-- (c) Copyright 1984 - 2013 Xilinx, Inc. All rights reserved.
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
-- ***************************************************************************
--
-------------------------------------------------------------------------------
-- Filename:        axi_intc.vhd
-- Version:         v3.1
-- Description:     Interrupt controller interfaced to AXI.
--
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:
--           -- axi_intc.vhd  (wrapper for top level)
--               -- axi_lite_ipif.vhd
--               -- intc_core.vhd
--
-------------------------------------------------------------------------------
-- Author:      PB
-- History:
--  PB     07/29/09
--  ^^^^^^^
--  - Initial release of v1.00.a
-- ~~~~~~
--  PB     03/26/10
--
--  - updated based on the xps_intc_v2_01_a
--  PB     09/21/10
--
--  - updated the axi_lite_ipif from v1.00.a to v1.01.a
-- ~~~~~~
--  ^^^^^^^
--  SK     10/10/12
--
--  1. Added cascade mode support
-- 2.  Updated major version of the core
-- ~~~~~~
-- ~~~~~~
--  SK       12/16/12      -- v3.0
--  1. up reved to major version for 2013.1 Vivado release. No logic updates.
--  2. Updated the version of AXI LITE IPIF to v2.0 in X.Y format
--  3. updated the proc common version to v4_0
--  4. No Logic Updates
-- ^^^^^^
--  ^^^^^^^
--  SA     03/25/13
--
--  1. Added software interrupt support
-- ~~~~~~
--  SA     09/05/13
--
--  1. Added support for nested interrupts using ILR register in v4.1
-- ~~~~~~
--
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
use ieee.std_logic_1164.all;

-------------------------------------------------------------------------
-- Library axi_lite_ipif_v3_0 is used because it contains the
-- axi_lite_ipif which interraces intc_core to AXI.
-------------------------------------------------------------------------
library axi_lite_ipif_v3_0;
    use axi_lite_ipif_v3_0.axi_lite_ipif;
    use axi_lite_ipif_v3_0.ipif_pkg.all;

-------------------------------------------------------------------------
-- Library axi_intc_v4_1 is used because it contains the intc_core.
-- The complete interrupt controller logic is designed in intc_core.
-------------------------------------------------------------------------
library axi_intc_v4_1;
use axi_intc_v4_1.intc_core;

-------------------------------------------------------------------------------
-- Definition of Generics:
--  System Parameter
--   C_FAMILY           -- Target FPGA family
--  AXI Parameters
--   C_S_AXI_ADDR_WIDTH -- AXI address bus width
--   C_S_AXI_DATA_WIDTH -- AXI data bus width
--  Intc Parameters
--   C_NUM_INTR_INPUTS  -- Number of interrupt inputs
--   C_NUM_SW_INTR      -- Number of software interrupts
--   C_KIND_OF_INTR     -- Kind of interrupt (0-Level/1-Edge)
--   C_KIND_OF_EDGE     -- Kind of edge (0-falling/1-rising)
--   C_KIND_OF_LVL      -- Kind of level (0-low/1-high)
--   C_ASYNC_INTR       -- Interrupt is asynchronous (0-sync/1-async)
--   C_NUM_SYNC_FF      -- Number of synchronization flip-flops for async interrupts
--   C_HAS_IPR          -- Set to 1 if has Interrupt Pending Register
--   C_HAS_SIE          -- Set to 1 if has Set Interrupt Enable Bits Register
--   C_HAS_CIE          -- Set to 1 if has Clear Interrupt Enable Bits Register
--   C_HAS_IVR          -- Set to 1 if has Interrupt Vector Register
--   C_HAS_ILR          -- Set to 1 if has Interrupt Level Register for nested interupt support
--   C_IRQ_IS_LEVEL     -- If set to 0 generates edge interrupt
--                      -- If set to 1 generates level interrupt
--   C_IRQ_ACTIVE       -- Defines the edge for output interrupt if
--                      -- C_IRQ_IS_LEVEL=0 (0-FALLING/1-RISING)
--                      -- Defines the level for output interrupt if
--                      -- C_IRQ_IS_LEVEL=1 (0-LOW/1-HIGH)
--   C_IVR_RESET_VALUE  -- Reset value for the vectroed interrupt registers in RAM
--   C_DISABLE_SYNCHRONIZERS -- If the processor clock and axi clock are of same
--                              value then user can decide to disable this
--   C_MB_CLK_NOT_CONNECTED  -- If the processor clock is not connected or used in design
--   C_HAS_FAST              -- If user wants to choose the fast interrupt mode of the core
--                           -- then it is needed to have this paraemter set. Default is Standard Mode interrupt
--   C_ENABLE_ASYNC          -- This parameter is used only for Vivado standalone mode of the core, not used in RTL
--   C_EN_CASCADE_MODE       -- If no. of interrupts goes beyond 32, then this parameter need to set
--   C_CASCADE_MASTER        -- If cascade mode is set, then this parameter should be set to the first instance
--                           -- of the core which is connected to the processor
-------------------------------------------------------------------------------
-- Definition of Ports:
-- Clocks and reset
--  s_axi_aclk          -- AXI Clock
--  s_axi_aresetn       -- AXI Reset - Active Low Reset
-- Axi interface signals
--  s_axi_awaddr        -- AXI Write address
--  s_axi_awvalid       -- Write address valid
--  s_axi_awready       -- Write address ready
--  s_axi_wdata         -- Write data
--  s_axi_wstrb         -- Write strobes
--  s_axi_wvalid        -- Write valid
--  s_axi_wready        -- Write ready
--  s_axi_bresp         -- Write response
--  s_axi_bvalid        -- Write response valid
--  s_axi_bready        -- Response ready
--  s_axi_araddr        -- Read address
--  s_axi_arvalid       -- Read address valid
--  s_axi_arready       -- Read address ready
--  s_axi_rdata         -- Read data
--  s_axi_rresp         -- Read response
--  s_axi_rvalid        -- Read valid
--  s_axi_rready        -- Read ready
-- Intc Interface Signals
--  intr                -- Input Interruput request
--  irq                 -- Output Interruput request
--  processor_clk       -- in put same as processor clock
--  processor_rst       -- in put same as processor reset
--  processor_ack       -- input Connected to processor ACK
--  interrupt_address   -- output Connected to processor interrupt address pins
--  interrupt_address_in-- Input this is coming from lower level module in case
--                      -- the cascade mode is set and all AXI INTC instances are marked
--                      -- as C_HAS_FAST = 1
--  processor_ack_out   -- Output this is going to lower level module in case
--                      -- the cascade mode is set and all AXI INTC instances are marked
--                      -- as C_HAS_FAST = 1
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Entity
-------------------------------------------------------------------------------
entity axi_intc is
  generic
  (
  -- System Parameter
   C_FAMILY           : string  := "virtex6";
   C_INSTANCE         : string  := "axi_intc_inst";
  -- AXI Parameters
   C_S_AXI_ADDR_WIDTH      : integer := 9; -- 9
   C_S_AXI_DATA_WIDTH      : integer := 32;
  -- Intc Parameters
   C_NUM_INTR_INPUTS       : integer range 1 to 32 := 2;
   C_NUM_SW_INTR           : integer range 0 to 31 := 0;
   C_KIND_OF_INTR          : std_logic_vector(31 downto 0) :=
                                       "11111111111111111111111111111111";
   C_KIND_OF_EDGE          : std_logic_vector(31 downto 0) :=
                                       "11111111111111111111111111111111";
   C_KIND_OF_LVL           : std_logic_vector(31 downto 0) :=
                                       "11111111111111111111111111111111";
   C_ASYNC_INTR            : std_logic_vector(31 downto 0) :=
                                       "11111111111111111111111111111111";
   C_NUM_SYNC_FF           : integer range 0 to 7 := 2;
  -- IVR Reset value parameter
   C_IVAR_RESET_VALUE      : std_logic_vector(31 downto 0) :=
                                       "00000000000000000000000000010000";
   C_HAS_IPR               : integer range 0 to 1 := 1;
   C_HAS_SIE               : integer range 0 to 1 := 1;
   C_HAS_CIE               : integer range 0 to 1 := 1;
   C_HAS_IVR               : integer range 0 to 1 := 1;
   C_HAS_ILR               : integer range 0 to 1 := 0;
   C_IRQ_IS_LEVEL          : integer range 0 to 1 := 1;
   C_IRQ_ACTIVE            : std_logic            := '1';
   C_DISABLE_SYNCHRONIZERS : integer range 0 to 1 := 0;
   C_MB_CLK_NOT_CONNECTED  : integer range 0 to 1 := 1;
   C_HAS_FAST              : integer range 0 to 1 := 0;

   -- The below parameter is unused in RTL but required in Vivado Native
   C_ENABLE_ASYNC          : integer range 0 to 1 := 0; --not used for EDK, used only for Vivado
   --
   C_EN_CASCADE_MODE       : integer range 0 to 1 := 0; -- default no cascade mode, if set enable cascade mode
   C_CASCADE_MASTER        : integer range 0 to 1 := 0  -- default slave, if set become cascade master and connects ports to Processor
   --
   );
   port
   (
   -- system signals
    s_axi_aclk      : in  std_logic;
    s_axi_aresetn   : in  std_logic;
   -- axi interface signals
    s_axi_awaddr    : in  std_logic_vector (8 downto 0);
    s_axi_awvalid   : in  std_logic;
    s_axi_awready   : out std_logic;
    s_axi_wdata     : in  std_logic_vector (31 downto 0);
    s_axi_wstrb     : in  std_logic_vector (3 downto 0);
    s_axi_wvalid    : in  std_logic;
    s_axi_wready    : out std_logic;
    s_axi_bresp     : out std_logic_vector(1 downto 0);
    s_axi_bvalid    : out std_logic;
    s_axi_bready    : in  std_logic;
    s_axi_araddr    : in  std_logic_vector (8 downto 0);
    s_axi_arvalid   : in  std_logic;
    s_axi_arready   : out std_logic;
    s_axi_rdata     : out std_logic_vector (31 downto 0);
    s_axi_rresp     : out std_logic_vector(1 downto 0);
    s_axi_rvalid    : out std_logic;
    s_axi_rready    : in  std_logic;
   -- Intc iInterface signals
    intr              : in  std_logic_vector(C_NUM_INTR_INPUTS-1 downto 0);
    processor_clk     : in  std_logic;                 --- MB Clk, clock from MicroBlaze
    processor_rst     : in  std_logic;                 --- MB rst, reset from MicroBlaze
    irq               : out std_logic;
    processor_ack     : in  std_logic_vector(1 downto 0);  --- newly added port
    interrupt_address : out std_logic_vector(31 downto 0); --- newly added port
    --
    interrupt_address_in : in std_logic_vector(31 downto 0);
    processor_ack_out    : out std_logic_vector(1 downto 0)
    --
   );

-------------------------------------------------------------------------------
-- Attributes
-------------------------------------------------------------------------------
  -- Fan-Out attributes for XST
    ATTRIBUTE MAX_FANOUT                   : string;
    ATTRIBUTE MAX_FANOUT  of S_AXI_ACLK    : signal is "10000";
    ATTRIBUTE MAX_FANOUT  of S_AXI_ARESETN : signal is "10000";

-----------------------------------------------------------------
  -- Start of PSFUtil MPD attributes
-----------------------------------------------------------------
    -- SIGIS attribute for specifying clocks,interrupts,resets for EDK
    ATTRIBUTE IP_GROUP                    : string;
    ATTRIBUTE IP_GROUP of axi_intc        : entity is "LOGICORE";

    ATTRIBUTE IPTYPE                      : string;
    ATTRIBUTE IPTYPE of axi_intc          : entity is "PERIPHERAL";

    ATTRIBUTE HDL                         : string;
    ATTRIBUTE HDL of axi_intc             : entity is "VHDL";

    ATTRIBUTE STYLE                       : string;
    ATTRIBUTE STYLE of axi_intc           : entity is "HDL";

    ATTRIBUTE IMP_NETLIST                 : string;
    ATTRIBUTE IMP_NETLIST of axi_intc     : entity is "TRUE";

    ATTRIBUTE RUN_NGCBUILD                : string;
    ATTRIBUTE RUN_NGCBUILD of axi_intc    : entity is "TRUE";

    ATTRIBUTE SIGIS                       : string;
    ATTRIBUTE SIGIS of S_AXI_ACLK         : signal is "Clk";
    ATTRIBUTE SIGIS of S_AXI_ARESETN      : signal is "Rstn";

end axi_intc;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------
architecture imp of axi_intc is

 ---------------------------------------------------------------------------
 -- Component Declarations
 ---------------------------------------------------------------------------
 constant ZERO_ADDR_PAD     : std_logic_vector(31 downto 0)
                            := (others => '0');
 constant ARD_ID_ARRAY      : INTEGER_ARRAY_TYPE := (0 => 1);
 constant ARD_ADDR_RANGE_ARRAY : SLV64_ARRAY_TYPE
                            := (
                               ZERO_ADDR_PAD & X"00000000",
                               ZERO_ADDR_PAD & (X"00000000" or X"0000003F"),    --- changed the high address
                               ZERO_ADDR_PAD & (X"00000000" or X"00000100"),    --- changed the high address
                               ZERO_ADDR_PAD & (X"00000000" or X"0000017F")     --- changed the high address
                               );
 constant ARD_NUM_CE_ARRAY  : INTEGER_ARRAY_TYPE := (16, 1);                    --- changed no. of chip enables
 constant C_S_AXI_MIN_SIZE  : std_logic_vector(31 downto 0):= X"0000017F";      --- changed min memory size required
 constant C_USE_WSTRB       : integer := 1;
 constant C_DPHASE_TIMEOUT  : integer := 8;
 constant RESET_ACTIVE      : std_logic := '0';
 ---------------------------------------------------------------------------
 -- Signal Declarations
 ---------------------------------------------------------------------------
 signal register_addr       : std_logic_vector(6 downto 0);                     -- changed
 signal read_data           : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
 signal write_data          : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
 signal bus2ip_clk          : std_logic;
 signal bus2ip_resetn       : std_logic;
 signal bus2ip_addr         : std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
 signal bus2ip_rnw          : std_logic;
 signal bus2ip_cs           : std_logic_vector((
                                (ARD_ADDR_RANGE_ARRAY'LENGTH)/2)-1 downto 0);
 signal bus2ip_rdce         : std_logic_vector(
 				calc_num_ce(ARD_NUM_CE_ARRAY)-1 downto 0);
 signal bus2ip_wrce         : std_logic_vector(
				calc_num_ce(ARD_NUM_CE_ARRAY)-1 downto 0);
 signal bus2ip_be           : std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
 signal ip2bus_wrack        : std_logic;
 signal ip2bus_rdack        : std_logic;
 signal ip2bus_error        : std_logic;
 signal word_access         : std_logic;
 signal ip2bus_rdack_int    : std_logic;
 signal ip2bus_wrack_int    : std_logic;
 signal ip2bus_rdack_int_d1 : std_logic;
 signal ip2bus_wrack_int_d1 : std_logic;
 signal ip2bus_rdack_prev2  : std_logic;
 signal ip2bus_wrack_prev2  : std_logic;

 function Or128_vec2stdlogic (vec_in : std_logic_vector) return std_logic is
 variable or_out            : std_logic := '0';
 begin
   for i in 0 to 16 loop
      or_out := vec_in(i) or or_out;
   end loop;
   return or_out;
 end function Or128_vec2stdlogic;
------------------------------------------------------------------------------
-----
begin
-----
   assert C_NUM_SW_INTR + C_NUM_INTR_INPUTS <= 32
     report "C_NUM_SW_INTR + C_NUM_INTR_INPUTS must be less than or equal to 32"
     severity error;

   register_addr     <= bus2ip_addr(8 downto 2);				-- changed the range as no. of register increased
   --- Internal ack signals
   ip2bus_rdack_int  <= Or128_vec2stdlogic(bus2ip_rdce);                        -- changed, utilized function as no. chip enables increased
   ip2bus_wrack_int  <= Or128_vec2stdlogic(bus2ip_wrce);                        -- changed, utilized function as no. chip enables increased
   -- Error signal generation
   word_access <= bus2ip_be(0) and
                  bus2ip_be(1) and
                  bus2ip_be(2) and
                  bus2ip_be(3);

   ip2bus_error <= not word_access;

    --------------------------------------------------------------------------
    -- Process DACK_DELAY_P for generating write and read data acknowledge
    -- signals.
    --------------------------------------------------------------------------
    DACK_DELAY_P: process (bus2ip_clk) is
    begin
        if bus2ip_clk'event and bus2ip_clk='1' then
            if bus2ip_resetn = RESET_ACTIVE then
                ip2bus_rdack_int_d1 <= '0';
                ip2bus_wrack_int_d1 <= '0';
                ip2bus_rdack        <= '0';
                ip2bus_wrack        <= '0';
            else
                ip2bus_rdack_int_d1 <= ip2bus_rdack_int;
                ip2bus_wrack_int_d1 <= ip2bus_wrack_int;
                ip2bus_rdack        <= ip2bus_rdack_prev2;
                ip2bus_wrack        <= ip2bus_wrack_prev2;
            end if;
        end if;
    end process DACK_DELAY_P;

    -- Detecting rising edge by creating one shot
    ip2bus_rdack_prev2 <= ip2bus_rdack_int and (not ip2bus_rdack_int_d1);
    ip2bus_wrack_prev2 <= ip2bus_wrack_int and (not ip2bus_wrack_int_d1);

   ---------------------------------------------------------------------------
   -- Component Instantiations
   ---------------------------------------------------------------------------
   -----------------------------------------------------------------
   -- Instantiating intc_core from axi_intc_v4_1
   -----------------------------------------------------------------
   INTC_CORE_I : entity axi_intc_v4_1.intc_core
     generic map
     (
      C_FAMILY                => C_FAMILY,
      C_DWIDTH                => C_S_AXI_DATA_WIDTH,
      C_NUM_INTR_INPUTS       => C_NUM_INTR_INPUTS,
      C_NUM_SW_INTR           => C_NUM_SW_INTR,
      C_KIND_OF_INTR          => C_KIND_OF_INTR,
      C_KIND_OF_EDGE          => C_KIND_OF_EDGE,
      C_KIND_OF_LVL           => C_KIND_OF_LVL,
      C_ASYNC_INTR            => C_ASYNC_INTR,
      C_NUM_SYNC_FF           => C_NUM_SYNC_FF,
      C_HAS_IPR               => C_HAS_IPR,
      C_HAS_SIE               => C_HAS_SIE,
      C_HAS_CIE               => C_HAS_CIE,
      C_HAS_IVR               => C_HAS_IVR,
      C_HAS_ILR               => C_HAS_ILR,
      C_IRQ_IS_LEVEL          => C_IRQ_IS_LEVEL,
      C_IRQ_ACTIVE            => C_IRQ_ACTIVE,
      C_DISABLE_SYNCHRONIZERS => C_DISABLE_SYNCHRONIZERS,
      C_MB_CLK_NOT_CONNECTED  => C_MB_CLK_NOT_CONNECTED,
      C_HAS_FAST              => C_HAS_FAST,
      C_IVAR_RESET_VALUE      => C_IVAR_RESET_VALUE,
      --
      C_EN_CASCADE_MODE       => C_EN_CASCADE_MODE,
      C_CASCADE_MASTER        => C_CASCADE_MASTER
      --
     )
     port map
     (
     -- Intc Interface Signals
      Clk               => bus2ip_clk,
      Rst_n             => bus2ip_resetn,
      Intr              => intr,
      Reg_addr          => register_addr,
      Bus2ip_rdce       => bus2ip_rdce,
      Bus2ip_wrce       => bus2ip_wrce,
      Wr_data           => write_data,
      Rd_data           => read_data,
      Processor_clk     => processor_clk,
      Processor_rst     => processor_rst,
      Irq               => Irq,
      Processor_ack     => processor_ack,
      Interrupt_address => interrupt_address,
      Interrupt_address_in => interrupt_address_in,
      Processor_ack_out => processor_ack_out
     );
   -----------------------------------------------------------------
   --Instantiating axi_lite_ipif from axi_lite_ipif_v3_0
   -----------------------------------------------------------------
   AXI_LITE_IPIF_I : entity axi_lite_ipif_v3_0.axi_lite_ipif
    generic map
     (
      C_S_AXI_DATA_WIDTH    => C_S_AXI_DATA_WIDTH,
      C_S_AXI_ADDR_WIDTH    => C_S_AXI_ADDR_WIDTH,
      C_S_AXI_MIN_SIZE      => C_S_AXI_MIN_SIZE,
      C_USE_WSTRB           => C_USE_WSTRB,
      C_DPHASE_TIMEOUT      => C_DPHASE_TIMEOUT,
      C_ARD_ADDR_RANGE_ARRAY=> ARD_ADDR_RANGE_ARRAY,
      C_ARD_NUM_CE_ARRAY    => ARD_NUM_CE_ARRAY,
      C_FAMILY              => C_FAMILY
     )
     port map
     (
     --System signals
      S_AXI_ACLK            => s_axi_aclk,
      S_AXI_ARESETN         => s_axi_aresetn,
     -- AXI interface signals
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
     -- Controls to the IP/IPIF modules
      Bus2IP_Clk            => bus2ip_clk,
      Bus2IP_Resetn         => bus2ip_resetn,
      Bus2IP_Addr           => bus2ip_addr,
      Bus2IP_RNW            => bus2ip_rnw,
      Bus2IP_BE             => bus2ip_be,
      Bus2IP_CS             => bus2ip_cs,
      Bus2IP_RdCE           => bus2ip_rdce,
      Bus2IP_WrCE           => bus2ip_wrce,
      Bus2IP_Data           => write_data,
      IP2Bus_Data           => read_data,
      IP2Bus_WrAck          => ip2bus_wrack,
      IP2Bus_RdAck          => ip2bus_rdack,
      IP2Bus_Error          => ip2bus_error
     );

end imp;


