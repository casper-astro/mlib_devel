-- (c) Copyright 1995-2018 Xilinx, Inc. All rights reserved.
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
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: xilinx.com:ip:gtwizard_ultrascale:1.7
-- IP Revision: 2

-- The following code must appear in the VHDL architecture header.

------------- Begin Cut here for COMPONENT Declaration ------ COMP_TAG
COMPONENT cmac_usplus_0_gt
  PORT (
    gtwiz_userclk_tx_active_in : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    gtwiz_userclk_rx_active_in : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    gtwiz_reset_clk_freerun_in : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    gtwiz_reset_all_in : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    gtwiz_reset_tx_pll_and_datapath_in : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    gtwiz_reset_tx_datapath_in : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    gtwiz_reset_rx_pll_and_datapath_in : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    gtwiz_reset_rx_datapath_in : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    gtwiz_reset_qpll0lock_in : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    gtwiz_reset_rx_cdr_stable_out : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    gtwiz_reset_tx_done_out : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    gtwiz_reset_rx_done_out : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    gtwiz_reset_qpll0reset_out : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    drpaddr_in : IN STD_LOGIC_VECTOR(39 DOWNTO 0);
    drpclk_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    drpdi_in : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
    drpen_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    drpwe_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    eyescanreset_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    eyescantrigger_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    gtyrxn_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    gtyrxp_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    loopback_in : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
    qpll0clk_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    qpll0refclk_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    qpll1clk_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    qpll1refclk_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    rxcdrhold_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    rxdfelfhold_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    rxdfelpmreset_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    rxlpmen_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    rxpolarity_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    rxprbscntreset_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    rxprbssel_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    rxrate_in : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
    rxusrclk_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    rxusrclk2_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    txctrl0_in : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
    txctrl1_in : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
    txdata_in : IN STD_LOGIC_VECTOR(511 DOWNTO 0);
    txdiffctrl_in : IN STD_LOGIC_VECTOR(19 DOWNTO 0);
    txinhibit_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    txpolarity_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    txpostcursor_in : IN STD_LOGIC_VECTOR(19 DOWNTO 0);
    txprbsforceerr_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    txprbssel_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    txprecursor_in : IN STD_LOGIC_VECTOR(19 DOWNTO 0);
    txusrclk_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    txusrclk2_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    drpdo_out : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
    drprdy_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    eyescandataerror_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    gtpowergood_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    gtytxn_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    gtytxp_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    rxbufstatus_out : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
    rxctrl0_out : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
    rxctrl1_out : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
    rxdata_out : OUT STD_LOGIC_VECTOR(511 DOWNTO 0);
    rxoutclk_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    rxpmaresetdone_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    rxprbserr_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    rxrecclkout_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    rxresetdone_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    txbufstatus_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    txoutclk_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    txpmaresetdone_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    txprgdivresetdone_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    txresetdone_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
  );
END COMPONENT;
-- COMP_TAG_END ------ End COMPONENT Declaration ------------

-- The following code must appear in the VHDL architecture
-- body. Substitute your own instance name and net names.

------------- Begin Cut here for INSTANTIATION Template ----- INST_TAG
your_instance_name : cmac_usplus_0_gt
  PORT MAP (
    gtwiz_userclk_tx_active_in => gtwiz_userclk_tx_active_in,
    gtwiz_userclk_rx_active_in => gtwiz_userclk_rx_active_in,
    gtwiz_reset_clk_freerun_in => gtwiz_reset_clk_freerun_in,
    gtwiz_reset_all_in => gtwiz_reset_all_in,
    gtwiz_reset_tx_pll_and_datapath_in => gtwiz_reset_tx_pll_and_datapath_in,
    gtwiz_reset_tx_datapath_in => gtwiz_reset_tx_datapath_in,
    gtwiz_reset_rx_pll_and_datapath_in => gtwiz_reset_rx_pll_and_datapath_in,
    gtwiz_reset_rx_datapath_in => gtwiz_reset_rx_datapath_in,
    gtwiz_reset_qpll0lock_in => gtwiz_reset_qpll0lock_in,
    gtwiz_reset_rx_cdr_stable_out => gtwiz_reset_rx_cdr_stable_out,
    gtwiz_reset_tx_done_out => gtwiz_reset_tx_done_out,
    gtwiz_reset_rx_done_out => gtwiz_reset_rx_done_out,
    gtwiz_reset_qpll0reset_out => gtwiz_reset_qpll0reset_out,
    drpaddr_in => drpaddr_in,
    drpclk_in => drpclk_in,
    drpdi_in => drpdi_in,
    drpen_in => drpen_in,
    drpwe_in => drpwe_in,
    eyescanreset_in => eyescanreset_in,
    eyescantrigger_in => eyescantrigger_in,
    gtyrxn_in => gtyrxn_in,
    gtyrxp_in => gtyrxp_in,
    loopback_in => loopback_in,
    qpll0clk_in => qpll0clk_in,
    qpll0refclk_in => qpll0refclk_in,
    qpll1clk_in => qpll1clk_in,
    qpll1refclk_in => qpll1refclk_in,
    rxcdrhold_in => rxcdrhold_in,
    rxdfelfhold_in => rxdfelfhold_in,
    rxdfelpmreset_in => rxdfelpmreset_in,
    rxlpmen_in => rxlpmen_in,
    rxpolarity_in => rxpolarity_in,
    rxprbscntreset_in => rxprbscntreset_in,
    rxprbssel_in => rxprbssel_in,
    rxrate_in => rxrate_in,
    rxusrclk_in => rxusrclk_in,
    rxusrclk2_in => rxusrclk2_in,
    txctrl0_in => txctrl0_in,
    txctrl1_in => txctrl1_in,
    txdata_in => txdata_in,
    txdiffctrl_in => txdiffctrl_in,
    txinhibit_in => txinhibit_in,
    txpolarity_in => txpolarity_in,
    txpostcursor_in => txpostcursor_in,
    txprbsforceerr_in => txprbsforceerr_in,
    txprbssel_in => txprbssel_in,
    txprecursor_in => txprecursor_in,
    txusrclk_in => txusrclk_in,
    txusrclk2_in => txusrclk2_in,
    drpdo_out => drpdo_out,
    drprdy_out => drprdy_out,
    eyescandataerror_out => eyescandataerror_out,
    gtpowergood_out => gtpowergood_out,
    gtytxn_out => gtytxn_out,
    gtytxp_out => gtytxp_out,
    rxbufstatus_out => rxbufstatus_out,
    rxctrl0_out => rxctrl0_out,
    rxctrl1_out => rxctrl1_out,
    rxdata_out => rxdata_out,
    rxoutclk_out => rxoutclk_out,
    rxpmaresetdone_out => rxpmaresetdone_out,
    rxprbserr_out => rxprbserr_out,
    rxrecclkout_out => rxrecclkout_out,
    rxresetdone_out => rxresetdone_out,
    txbufstatus_out => txbufstatus_out,
    txoutclk_out => txoutclk_out,
    txpmaresetdone_out => txpmaresetdone_out,
    txprgdivresetdone_out => txprgdivresetdone_out,
    txresetdone_out => txresetdone_out
  );
-- INST_TAG_END ------ End INSTANTIATION Template ---------

-- You must compile the wrapper file cmac_usplus_0_gt.vhd when simulating
-- the core, cmac_usplus_0_gt. When compiling the wrapper file, be sure to
-- reference the VHDL simulation library.

