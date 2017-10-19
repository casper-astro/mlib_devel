-------------------------------------------------------------------------------
-- axi_uartlite - entity/architecture pair
-------------------------------------------------------------------------------
--
   -- *******************************************************************
-- -- ** (c) Copyright [2007] - [2011] Xilinx, Inc. All rights reserved.*
-- -- **                                                                *
-- -- ** This file contains confidential and proprietary information    *
-- -- ** of Xilinx, Inc. and is protected under U.S. and                *
-- -- ** international copyright and other intellectual property        *
-- -- ** laws.                                                          *
-- -- **                                                                *
-- -- ** DISCLAIMER                                                     *
-- -- ** This disclaimer is not a license and does not grant any        *
-- -- ** rights to the materials distributed herewith. Except as        *
-- -- ** otherwise provided in a valid license issued to you by         *
-- -- ** Xilinx, and to the maximum extent permitted by applicable      *
-- -- ** law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND        *
-- -- ** WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES    *
-- -- ** AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING      *
-- -- ** BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-         *
-- -- ** INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and       *
-- -- ** (2) Xilinx shall not be liable (whether in contract or tort,   *
-- -- ** including negligence, or under any other theory of             *
-- -- ** liability) for any loss or damage of any kind or nature        *
-- -- ** related to, arising under or in connection with these          *
-- -- ** materials, including for any direct, or any indirect,          *
-- -- ** special, incidental, or consequential loss or damage           *
-- -- ** (including loss of data, profits, goodwill, or any type of     *
-- -- ** loss or damage suffered as a result of any action brought      *
-- -- ** by a third party) even if such damage or loss was              *
-- -- ** reasonably foreseeable or Xilinx had been advised of the       *
-- -- ** possibility of the same.                                       *
-- -- **                                                                *
-- -- ** CRITICAL APPLICATIONS                                          *
-- -- ** Xilinx products are not designed or intended to be fail-       *
-- -- ** safe, or for use in any application requiring fail-safe        *
-- -- ** performance, such as life-support or safety devices or         *
-- -- ** systems, Class III medical devices, nuclear facilities,        *
-- -- ** applications related to the deployment of airbags, or any      *
-- -- ** other applications that could lead to death, personal          *
-- -- ** injury, or severe property or environmental damage             *
-- -- ** (individually and collectively, "Critical                      *
-- -- ** Applications"). Customer assumes the sole risk and             *
-- -- ** liability of any use of Xilinx products in Critical            *
-- -- ** Applications, subject only to applicable laws and              *
-- -- ** regulations governing limitations on product liability.        *
-- -- **                                                                *
-- -- ** THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS       *
-- -- ** PART OF THIS FILE AT ALL TIMES.                                *
   -- *******************************************************************
--
-------------------------------------------------------------------------------
-- Filename:        axi_uartlite.vhd
-- Version:         v1.02.a
-- Description:     AXI UART Lite Interface
--
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Naming Conventions:
--      active low signals:                     "*_n"
--      clock signals:                          "clk", "clk_div#", "clk_#x"
--      reset signals:                          "rst", "rst_n"
--      generics:                               "C_*"
--      user defined types:                     "*_TYPE"
--      state machine next state:               "*_ns"
--      state machine current state:            "*_cs"
--      combinatorial signals:                  "*_com"
--      pipelined or register delay signals:    "*_d#"
--      counter signals:                        "*cnt*"
--      clock enable signals:                   "*_ce"
--      internal version of output port         "*_i"
--      device pins:                            "*_pin"
--      ports:                                  - Names begin with Uppercase
--      processes:                              "*_PROCESS"
--      component instantiations:               "<ENTITY_>I_<#|FUNC>
-------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

library axi_lite_ipif_v3_0_4;
-- SLV64_ARRAY_TYPE refered from ipif_pkg
use axi_lite_ipif_v3_0_4.ipif_pkg.SLV64_ARRAY_TYPE;
-- INTEGER_ARRAY_TYPE refered from ipif_pkg
use axi_lite_ipif_v3_0_4.ipif_pkg.INTEGER_ARRAY_TYPE;
-- calc_num_ce comoponent refered from ipif_pkg
use axi_lite_ipif_v3_0_4.ipif_pkg.calc_num_ce;

-- axi_lite_ipif refered from axi_lite_ipif_v2_0
    use axi_lite_ipif_v3_0_4.axi_lite_ipif;

library axi_uartlite_v2_0_13;
-- uartlite_core refered from axi_uartlite_v2_0_13
use axi_uartlite_v2_0_13.uartlite_core;

-------------------------------------------------------------------------------
-- Port Declaration
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Definition of Generics :
-------------------------------------------------------------------------------
-- System generics
--  C_FAMILY              -- Xilinx FPGA Family
--  C_S_AXI_ACLK_FREQ_HZ  -- System clock frequency driving UART lite
--                           peripheral in Hz
-- AXI generics
--  C_S_AXI_ADDR_WIDTH    -- Width of AXI Address Bus (in bits)
--  C_S_AXI_DATA_WIDTH    -- Width of the AXI Data Bus (in bits)
--
-- UART Lite generics
--  C_BAUDRATE            -- Baud rate of UART Lite in bits per second
--  C_DATA_BITS           -- The number of data bits in the serial frame
--  C_USE_PARITY          -- Determines whether parity is used or not
--  C_ODD_PARITY          -- If parity is used determines whether parity
--                           is even or odd
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Definition of Ports :
-------------------------------------------------------------------------------
--System signals
-- s_axi_aclk           -- AXI Clock
-- s_axi_aresetn         -- AXI Reset
-- Interrupt             --  UART Interrupt
--AXI signals
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
--UARTLite Interface Signals
--  rx                   --  Receive Data
--  tx                   --  Transmit Data
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--                  Entity Section
-------------------------------------------------------------------------------
entity axi_uartlite is
  generic
   (
--  -- System Parameter
    C_FAMILY              : string                        := "virtex7";
    C_S_AXI_ACLK_FREQ_HZ  : integer                       := 100_000_000;
--  -- AXI Parameters
    C_S_AXI_ADDR_WIDTH    : integer                       := 4;
    C_S_AXI_DATA_WIDTH    : integer range 32 to 128       := 32;
--  -- UARTLite Parameters
    C_BAUDRATE            : integer                       := 9600;
    C_DATA_BITS           : integer range 5 to 8          := 8;
    C_USE_PARITY          : integer range 0 to 1          := 0;
    C_ODD_PARITY          : integer range 0 to 1          := 0
   );
  port
   (

-- System signals
      s_axi_aclk           : in  std_logic;
      s_axi_aresetn         : in  std_logic;
      interrupt             : out std_logic;

-- AXI signals
      s_axi_awaddr          : in  std_logic_vector
                              (3 downto 0);
      s_axi_awvalid         : in  std_logic;
      s_axi_awready         : out std_logic;
      s_axi_wdata           : in  std_logic_vector
                              (31 downto 0);
      s_axi_wstrb           : in  std_logic_vector
                              (3 downto 0);
      s_axi_wvalid          : in  std_logic;
      s_axi_wready          : out std_logic;
      s_axi_bresp           : out std_logic_vector(1 downto 0);
      s_axi_bvalid          : out std_logic;
      s_axi_bready          : in  std_logic;
      s_axi_araddr          : in  std_logic_vector
                              (3 downto 0);
      s_axi_arvalid         : in  std_logic;
      s_axi_arready         : out std_logic;
      s_axi_rdata           : out std_logic_vector
                              (31 downto 0);
      s_axi_rresp           : out std_logic_vector(1 downto 0);
      s_axi_rvalid          : out std_logic;
      s_axi_rready          : in  std_logic;

-- UARTLite Interface Signals
      rx                    : in  std_logic;
      tx                    : out std_logic
   );

-------------------------------------------------------------------------------
-- Attributes
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
  -- Fan-Out attributes for XST
-------------------------------------------------------------------------------

    ATTRIBUTE MAX_FANOUT                   : string;
    ATTRIBUTE MAX_FANOUT  of s_axi_aclk   : signal is "10000";
    ATTRIBUTE MAX_FANOUT  of s_axi_aresetn : signal is "10000";

end entity axi_uartlite;

-------------------------------------------------------------------------------
-- Architecture Section
-------------------------------------------------------------------------------

architecture RTL of axi_uartlite is
-- Pragma Added to supress synth warnings
attribute DowngradeIPIdentifiedWarnings: string;
attribute DowngradeIPIdentifiedWarnings of RTL : architecture is "yes";


    --------------------------------------------------------------------------
    -- Constant declarations
    --------------------------------------------------------------------------

    constant ZEROES                 : std_logic_vector(31 downto 0)
                                    := X"00000000";

    constant C_ARD_ADDR_RANGE_ARRAY : SLV64_ARRAY_TYPE :=
            (
              -- UARTLite registers Base Address
              ZEROES & X"00000000",
              ZEROES & (X"00000000" or X"0000000F")
            );

    constant C_ARD_NUM_CE_ARRAY     : INTEGER_ARRAY_TYPE :=
            (
              0 => 4
            );

    constant C_S_AXI_MIN_SIZE       : std_logic_vector(31 downto 0)
                                    := X"0000000F";

    constant C_USE_WSTRB            : integer := 0;

    constant C_DPHASE_TIMEOUT       : integer := 0;

    --------------------------------------------------------------------------
    -- Signal declarations
    --------------------------------------------------------------------------
    signal bus2ip_clk    : std_logic;
    signal bus2ip_reset  : std_logic;
    signal bus2ip_resetn : std_logic;
    signal ip2bus_data   : std_logic_vector((C_S_AXI_DATA_WIDTH-1)  downto 0)
                           := (others  => '0');
    signal ip2bus_error  : std_logic := '0';
    signal ip2bus_wrack  : std_logic := '0';
    signal ip2bus_rdack  : std_logic := '0';
    signal bus2ip_data   : std_logic_vector
                           (C_S_AXI_DATA_WIDTH - 1 downto 0);
    signal bus2ip_cs     : std_logic_vector
                           (((C_ARD_ADDR_RANGE_ARRAY'LENGTH)/2)-1 downto 0);
    signal bus2ip_rdce   : std_logic_vector
                           (calc_num_ce(C_ARD_NUM_CE_ARRAY)-1 downto 0);
    signal bus2ip_wrce   : std_logic_vector
                           (calc_num_ce(C_ARD_NUM_CE_ARRAY)-1 downto 0);

begin  -- architecture IMP

    --------------------------------------------------------------------------
    -- RESET signal assignment - IPIC RESET is active low
    --------------------------------------------------------------------------

         bus2ip_reset <= not bus2ip_resetn;

    --------------------------------------------------------------------------
    -- ip2bus_data assignment - as core is using maximum upto 8 bits
    --------------------------------------------------------------------------

    ip2bus_data((C_S_AXI_DATA_WIDTH-1)  downto 8) <= (others => '0');

    --------------------------------------------------------------------------
    -- Instansiating the UART core
    --------------------------------------------------------------------------
    UARTLITE_CORE_I : entity axi_uartlite_v2_0_13.uartlite_core
      generic map
       (
        C_FAMILY             => C_FAMILY,
        C_S_AXI_ACLK_FREQ_HZ => C_S_AXI_ACLK_FREQ_HZ,
        C_BAUDRATE           => C_BAUDRATE,
        C_DATA_BITS          => C_DATA_BITS,
        C_USE_PARITY         => C_USE_PARITY,
        C_ODD_PARITY         => C_ODD_PARITY
       )
      port map
       (
        Clk          => bus2ip_clk,
        Reset        => bus2ip_reset,
        bus2ip_data  => bus2ip_data(7 downto 0),
        bus2ip_rdce  => bus2ip_rdce(3 downto 0),
        bus2ip_wrce  => bus2ip_wrce(3 downto 0),
        bus2ip_cs    => bus2ip_cs(0),
        ip2bus_rdack => ip2bus_rdack,
        ip2bus_wrack => ip2bus_wrack,
        ip2bus_error => ip2bus_error,
        SIn_DBus     => ip2bus_data(7 downto 0),
        RX           => rx,
        TX           => tx,
        Interrupt    => Interrupt
       );

    --------------------------------------------------------------------------
    -- Instantiate AXI lite IPIF
    --------------------------------------------------------------------------
    AXI_LITE_IPIF_I : entity axi_lite_ipif_v3_0_4.axi_lite_ipif
      generic map
       (
        C_FAMILY                  => C_FAMILY,
        C_S_AXI_ADDR_WIDTH        => 4,
        C_S_AXI_DATA_WIDTH        => C_S_AXI_DATA_WIDTH,
        C_S_AXI_MIN_SIZE          => C_S_AXI_MIN_SIZE,
        C_USE_WSTRB               => C_USE_WSTRB,
        C_DPHASE_TIMEOUT          => C_DPHASE_TIMEOUT,
        C_ARD_ADDR_RANGE_ARRAY    => C_ARD_ADDR_RANGE_ARRAY,
        C_ARD_NUM_CE_ARRAY        => C_ARD_NUM_CE_ARRAY
       )
     port map
       (
        S_AXI_ACLK          =>  s_axi_aclk,
        S_AXI_ARESETN        =>  s_axi_aresetn,
        S_AXI_AWADDR        =>  s_axi_awaddr,
        S_AXI_AWVALID       =>  s_axi_awvalid,
        S_AXI_AWREADY       =>  s_axi_awready,
        S_AXI_WDATA         =>  s_axi_wdata,
        S_AXI_WSTRB         =>  s_axi_wstrb,
        S_AXI_WVALID        =>  s_axi_wvalid,
        S_AXI_WREADY         =>  s_axi_wready,
        S_AXI_BRESP         =>  s_axi_bresp,
        S_AXI_BVALID        =>  s_axi_bvalid,
        S_AXI_BREADY        =>  s_axi_bready,
        S_AXI_ARADDR        =>  s_axi_araddr,
        S_AXI_ARVALID        =>  s_axi_arvalid,
        S_AXI_ARREADY       =>  s_axi_arready,
        S_AXI_RDATA          =>  s_axi_rdata,
        S_AXI_RRESP          =>  s_axi_rresp,
        S_AXI_RVALID        =>  s_axi_rvalid,
        S_AXI_RREADY        =>  s_axi_rready,

     -- IP Interconnect (IPIC) port signals
        Bus2IP_Clk     => bus2ip_clk,
        Bus2IP_Resetn  => bus2ip_resetn,
        IP2Bus_Data    => ip2bus_data,
        IP2Bus_WrAck   => ip2bus_wrack,
        IP2Bus_RdAck   => ip2bus_rdack,
        IP2Bus_Error   => ip2bus_error,
        Bus2IP_Addr    => open,
        Bus2IP_Data    => bus2ip_data,
        Bus2IP_RNW     => open,
        Bus2IP_BE      => open,
        Bus2IP_CS      => bus2ip_cs,
        Bus2IP_RdCE    => bus2ip_rdce,
        Bus2IP_WrCE    => bus2ip_wrce
       );

end architecture RTL;
