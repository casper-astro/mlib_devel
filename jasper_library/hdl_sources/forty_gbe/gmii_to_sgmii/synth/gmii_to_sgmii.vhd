--------------------------------------------------------------------------------
-- File       : gmii_to_sgmii.vhd
-- Author     : Xilinx Inc.
--------------------------------------------------------------------------------
-- (c) Copyright 2009 Xilinx, Inc. All rights reserved.
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
-- 
-- 
--------------------------------------------------------------------------------
-- Description: This Core Block Level wrapper connects the core to a  
--              Series-7 Transceiver.
--
--              The SGMII adaptation module is provided to convert
--              between 1Gbps and 10/100 Mbps rates.  This is connected
--              to the MAC side of the core to provide a GMII style
--              interface.  When the core is running at 1Gbps speeds,
--              the GMII (8-bitdata pathway) is used at a clock
--              frequency of 125MHz.  When the core is running at
--              100Mbps, a clock frequency of 12.5MHz is used.  When
--              running at 100Mbps speeds, a clock frequency of 1.25MHz
--              is used.
--
--    ----------------------------------------------------------------
--    |                   Core Block Level Wrapper                   |
--    |                                                              |
--    |                                                              |
--    |                  --------------          --------------      |
--    |                  |    Core    |          | Transceiver|      |
--    |                  |            |          |            |      |
--    |    ---------     |            |          |            |      |
--    |    |       |     |            |          |            |      |
--    |    | SGMII |     |            |          |            |      |
--  ------>| Adapt |---->| GMII       |--------->|        TXP |-------->
--    |    | Module|     | Tx         |          |        TXN |      |
--    |    |       |     |            |          |            |      |
--    |    |       |     |            |          |            |      |
--    |    |       |     |            |          |            |      |
--    |    |       |     |            |          |            |      |
--    |    |       |     |            |          |            |      |
--    |    |       |     | GMII       |          |        RXP |      |
--  <------|       |<----| Rx         |<---------|        RXN |<--------
--    |    |       |     |            |          |            |      |
--    |    ---------     --------------          --------------      |
--    |                                                              |
--    ----------------------------------------------------------------
--
--


library unisim;
use unisim.vcomponents.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
library gig_ethernet_pcs_pma_v14_3;
use gig_ethernet_pcs_pma_v14_3.all;



--------------------------------------------------------------------------------
-- The entity declaration for the Core Block wrapper.
--------------------------------------------------------------------------------

entity gmii_to_sgmii is
      port(
      -- Transceiver Interface
      ---------------------

      gtrefclk_p               : in  std_logic;                           -- 125 MHz differential clock
      gtrefclk_n               : in  std_logic;                           -- 125 MHz differential clock


      gtrefclk_out             : out std_logic;                           -- Very high quality 125MHz clock for GT transceiver.
      
      txp                  : out std_logic;                    -- Differential +ve of serial transmission from PMA to PMD.
      txn                  : out std_logic;                    -- Differential -ve of serial transmission from PMA to PMD.
      rxp                  : in std_logic;                     -- Differential +ve for serial reception from PMD to PMA.
      rxn                  : in std_logic;                     -- Differential -ve for serial reception from PMD to PMA.
      resetdone                : out std_logic;                           -- The GT transceiver has completed its reset cycle
      userclk_out              : out std_logic;                           -- 125MHz global clock.
      userclk2_out             : out std_logic;                           -- 125MHz global clock.
      rxuserclk_out              : out std_logic;                           -- 125MHz global clock.
      rxuserclk2_out             : out std_logic;                           -- 125MHz global clock.
      pma_reset_out            : out std_logic;                           -- transceiver PMA reset signal
      mmcm_locked_out          : out std_logic;                           -- MMCM Locked
      independent_clock_bufg : in std_logic;                   -- 200MHz independent cloc,

      -- GMII Interface
      -----------------
      sgmii_clk_r            : out std_logic;                    -- Clock for client MAC (125Mhz, 12.5MHz or 1.25MHz).
      sgmii_clk_f            : out std_logic;                    -- Clock for client MAC (125Mhz, 12.5MHz or 1.25MHz).
      sgmii_clk_en         : out std_logic;                    -- Clock enable for client MAC
      gmii_txd             : in std_logic_vector(7 downto 0);  -- Transmit data from client MAC.
      gmii_tx_en           : in std_logic;                     -- Transmit control signal from client MAC.
      gmii_tx_er           : in std_logic;                     -- Transmit control signal from client MAC.
      gmii_rxd             : out std_logic_vector(7 downto 0); -- Received Data to client MAC.
      gmii_rx_dv           : out std_logic;                    -- Received control signal to client MAC.
      gmii_rx_er           : out std_logic;                    -- Received control signal to client MAC.
      gmii_isolate         : out std_logic;                    -- Tristate control to electrically isolate GMII.

      -- Management: Alternative to MDIO Interface
      --------------------------------------------

      configuration_vector : in std_logic_vector(4 downto 0);  -- Alternative to MDIO interface.


      an_interrupt         : out std_logic;                    -- Interrupt to processor to signal that Auto-Negotiation has completed
      an_adv_config_vector : in std_logic_vector(15 downto 0); -- Alternate interface to program REG4 (AN ADV)
      an_restart_config    : in std_logic;                     -- Alternate signal to modify AN restart bit in REG0

      -- Speed Control
      ----------------
      speed_is_10_100      : in std_logic;                     -- Core should operate at either 10Mbps or 100Mbps speeds
      speed_is_100         : in std_logic;                      -- Core should operate at 100Mbps speed


      -- General IO's
      ---------------
      status_vector        : out std_logic_vector(15 downto 0); -- Core status.
      reset                : in std_logic;                     -- Asynchronous reset for entire core.
     
      signal_detect        : in std_logic;                      -- Input from PMD to indicate presence of optical input.
      gt0_qplloutclk_out     : out std_logic;
      gt0_qplloutrefclk_out  : out std_logic

      );
end gmii_to_sgmii;


architecture wrapper of gmii_to_sgmii is

   attribute DowngradeIPIdentifiedWarnings: string;
   attribute DowngradeIPIdentifiedWarnings of wrapper : architecture is "yes";

   component gmii_to_sgmii_support
      port(
      -- Transceiver Interface
      ---------------------

      gtrefclk_p               : in  std_logic;                           -- 125 MHz differential clock
      gtrefclk_n               : in  std_logic;                           -- 125 MHz differential clock

      gtrefclk_out             : out std_logic;                           -- Very high quality 125MHz clock for GT transceiver.
      
      txp                  : out std_logic;                    -- Differential +ve of serial transmission from PMA to PMD.
      txn                  : out std_logic;                    -- Differential -ve of serial transmission from PMA to PMD.
      rxp                  : in std_logic;                     -- Differential +ve for serial reception from PMD to PMA.
      rxn                  : in std_logic;                     -- Differential -ve for serial reception from PMD to PMA.
      resetdone                : out std_logic;                           -- The GT transceiver has completed its reset cycle
      userclk_out              : out std_logic;                           -- 125MHz global clock.
      userclk2_out             : out std_logic;                           -- 125MHz global clock.
      rxuserclk_out              : out std_logic;                           -- 125MHz global clock.
      rxuserclk2_out             : out std_logic;                           -- 125MHz global clock.
      independent_clock_bufg : in std_logic;                   -- 200MHz independent cloc,
      pma_reset_out            : out std_logic;                           -- transceiver PMA reset signal
      mmcm_locked_out          : out std_logic;                           -- MMCM Locked
      -- GMII Interface
      -----------------
      sgmii_clk_r            : out std_logic;                    -- Clock for client MAC (125Mhz, 12.5MHz or 1.25MHz).
      sgmii_clk_f            : out std_logic;                    -- Clock for client MAC (125Mhz, 12.5MHz or 1.25MHz).
      sgmii_clk_en         : out std_logic;                    -- Clock enable for client MAC
      gmii_txd             : in std_logic_vector(7 downto 0);  -- Transmit data from client MAC.
      gmii_tx_en           : in std_logic;                     -- Transmit control signal from client MAC.
      gmii_tx_er           : in std_logic;                     -- Transmit control signal from client MAC.
      gmii_rxd             : out std_logic_vector(7 downto 0); -- Received Data to client MAC.
      gmii_rx_dv           : out std_logic;                    -- Received control signal to client MAC.
      gmii_rx_er           : out std_logic;                    -- Received control signal to client MAC.
      gmii_isolate         : out std_logic;                    -- Tristate control to electrically isolate GMII.

      -- Management: Alternative to MDIO Interface
      --------------------------------------------

      configuration_vector : in std_logic_vector(4 downto 0);  -- Alternative to MDIO interface.


      an_interrupt         : out std_logic;                    -- Interrupt to processor to signal that Auto-Negotiation has completed
      an_adv_config_vector : in std_logic_vector(15 downto 0); -- Alternate interface to program REG4 (AN ADV)
      an_restart_config    : in std_logic;                     -- Alternate signal to modify AN restart bit in REG0

      -- Speed Control
      ----------------
      speed_is_10_100      : in std_logic;                     -- Core should operate at either 10Mbps or 100Mbps speeds
      speed_is_100         : in std_logic;                      -- Core should operate at 100Mbps speed

      -- General IO's
      ---------------
      status_vector        : out std_logic_vector(15 downto 0); -- Core status.
      reset                : in std_logic;                     -- Asynchronous reset for entire core.
  
      signal_detect        : in std_logic;                      -- Input from PMD to indicate presence of optical input.

      gt0_qplloutclk_out     : out std_logic;
      gt0_qplloutrefclk_out  : out std_logic

      );
   end component;

ATTRIBUTE CORE_GENERATION_INFO : STRING;
ATTRIBUTE CORE_GENERATION_INFO OF wrapper : ARCHITECTURE IS "gmii_to_sgmii,gig_ethernet_pcs_pma_v14_3,{x_ipProduct=Vivado 2014.4,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=gig_ethernet_pcs_pma,x_ipVersion=14.3,x_ipCoreRevision=1,x_ipLanguage=VHDL,x_ipSimLanguage=MIXED,c_elaboration_transient_dir=.,c_component_name=gmii_to_sgmii,c_family=virtex7,c_is_sgmii=true,c_use_transceiver=true,c_use_tbi=false,c_use_lvds=false,c_has_an=true,c_has_mdio=false,c_has_ext_mdio=false,c_sgmii_phy_mode=false,c_dynamic_switching=false,c_transceiver_mode=A,c_sgmii_fabric_buffer=true,c_1588=0,gt_rx_byte_width=1,C_EMAC_IF_TEMAC=true,C_PHYADDR=1,EXAMPLE_SIMULATION=0,c_support_level=true,c_sub_core_name=gmii_to_sgmii_gt,c_transceivercontrol=false,c_xdevicefamily=xc7vx690t,c_gt_dmonitorout_width=15}";
ATTRIBUTE X_CORE_INFO : STRING;
ATTRIBUTE X_CORE_INFO OF wrapper: ARCHITECTURE IS "gig_ethernet_pcs_pma_v14_3,Vivado 2014.4";

begin



   U0 : gmii_to_sgmii_support
      port map(
      -- Transceiver Interface
      ---------------------

      gtrefclk_p               => gtrefclk_p,
      gtrefclk_n               => gtrefclk_n,

      gtrefclk_out             => gtrefclk_out,
      
          txp                  => txp,
          txn                  => txn,
          rxp                  => rxp,
          rxn                  => rxn,
      resetdone                => resetdone,
      userclk_out              => userclk_out,
      userclk2_out             => userclk2_out,
      rxuserclk_out              => rxuserclk_out,
      rxuserclk2_out             => rxuserclk2_out,
          independent_clock_bufg => independent_clock_bufg,
      pma_reset_out            => pma_reset_out,
      mmcm_locked_out          => mmcm_locked_out,
      -- GMII Interface
      -----------------
          sgmii_clk_r            => sgmii_clk_r,
          sgmii_clk_f            => sgmii_clk_f,
          sgmii_clk_en         => sgmii_clk_en,
          gmii_txd             => gmii_txd,
          gmii_tx_en           => gmii_tx_en,
          gmii_tx_er           => gmii_tx_er,
          gmii_rxd             => gmii_rxd,
          gmii_rx_dv           => gmii_rx_dv,
          gmii_rx_er           => gmii_rx_er,
          gmii_isolate         => gmii_isolate,

      -- Management: Alternative to MDIO Interface
      --------------------------------------------

          configuration_vector => configuration_vector,


          an_interrupt         => an_interrupt,
          an_adv_config_vector => an_adv_config_vector,
          an_restart_config    => an_restart_config,

      -- Speed Control
      ----------------
          speed_is_10_100      => speed_is_10_100,
          speed_is_100         => speed_is_100,

      -- General IO's
      ---------------
          status_vector        => status_vector,
          reset                => reset,

   
   

          signal_detect        => signal_detect,

      gt0_qplloutclk_out     => gt0_qplloutclk_out,
      gt0_qplloutrefclk_out  => gt0_qplloutrefclk_out

      );
end wrapper;

