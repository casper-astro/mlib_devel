-- (c) Copyright 1995-2016 Xilinx, Inc. All rights reserved.
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

-- IP VLNV: peralex.com:user:axi_slave_wishbone_classic_master:1.0
-- IP Revision: 3

-- The following code must appear in the VHDL architecture header.

------------- Begin Cut here for COMPONENT Declaration ------ COMP_TAG
COMPONENT cont_microblaze_axi_slave_wishbone_classic_master_0_0
  PORT (
    RST_O : OUT STD_LOGIC;
    DAT_O : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    DAT_I : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    ACK_I : IN STD_LOGIC;
    ADR_O : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    CYC_O : OUT STD_LOGIC;
    SEL_O : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    STB_O : OUT STD_LOGIC;
    WE_O : OUT STD_LOGIC;
    S_AXI_ACLK : IN STD_LOGIC;
    S_AXI_ARESETN : IN STD_LOGIC;
    S_AXI_AWID : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    S_AXI_AWADDR : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    S_AXI_AWLEN : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    S_AXI_AWSIZE : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    S_AXI_AWBURST : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    S_AXI_AWLOCK : IN STD_LOGIC;
    S_AXI_AWCACHE : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    S_AXI_AWPROT : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    S_AXI_AWQOS : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    S_AXI_AWREGION : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    S_AXI_AWUSER : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    S_AXI_AWVALID : IN STD_LOGIC;
    S_AXI_AWREADY : OUT STD_LOGIC;
    S_AXI_WDATA : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    S_AXI_WSTRB : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    S_AXI_WLAST : IN STD_LOGIC;
    S_AXI_WUSER : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    S_AXI_WVALID : IN STD_LOGIC;
    S_AXI_WREADY : OUT STD_LOGIC;
    S_AXI_BID : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    S_AXI_BRESP : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    S_AXI_BUSER : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    S_AXI_BVALID : OUT STD_LOGIC;
    S_AXI_BREADY : IN STD_LOGIC;
    S_AXI_ARID : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    S_AXI_ARADDR : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    S_AXI_ARLEN : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    S_AXI_ARSIZE : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    S_AXI_ARBURST : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    S_AXI_ARLOCK : IN STD_LOGIC;
    S_AXI_ARCACHE : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    S_AXI_ARPROT : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    S_AXI_ARQOS : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    S_AXI_ARREGION : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    S_AXI_ARUSER : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    S_AXI_ARVALID : IN STD_LOGIC;
    S_AXI_ARREADY : OUT STD_LOGIC;
    S_AXI_RID : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    S_AXI_RDATA : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    S_AXI_RRESP : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    S_AXI_RLAST : OUT STD_LOGIC;
    S_AXI_RUSER : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    S_AXI_RVALID : OUT STD_LOGIC;
    S_AXI_RREADY : IN STD_LOGIC
  );
END COMPONENT;
-- COMP_TAG_END ------ End COMPONENT Declaration ------------

-- The following code must appear in the VHDL architecture
-- body. Substitute your own instance name and net names.

------------- Begin Cut here for INSTANTIATION Template ----- INST_TAG
your_instance_name : cont_microblaze_axi_slave_wishbone_classic_master_0_0
  PORT MAP (
    RST_O => RST_O,
    DAT_O => DAT_O,
    DAT_I => DAT_I,
    ACK_I => ACK_I,
    ADR_O => ADR_O,
    CYC_O => CYC_O,
    SEL_O => SEL_O,
    STB_O => STB_O,
    WE_O => WE_O,
    S_AXI_ACLK => S_AXI_ACLK,
    S_AXI_ARESETN => S_AXI_ARESETN,
    S_AXI_AWID => S_AXI_AWID,
    S_AXI_AWADDR => S_AXI_AWADDR,
    S_AXI_AWLEN => S_AXI_AWLEN,
    S_AXI_AWSIZE => S_AXI_AWSIZE,
    S_AXI_AWBURST => S_AXI_AWBURST,
    S_AXI_AWLOCK => S_AXI_AWLOCK,
    S_AXI_AWCACHE => S_AXI_AWCACHE,
    S_AXI_AWPROT => S_AXI_AWPROT,
    S_AXI_AWQOS => S_AXI_AWQOS,
    S_AXI_AWREGION => S_AXI_AWREGION,
    S_AXI_AWUSER => S_AXI_AWUSER,
    S_AXI_AWVALID => S_AXI_AWVALID,
    S_AXI_AWREADY => S_AXI_AWREADY,
    S_AXI_WDATA => S_AXI_WDATA,
    S_AXI_WSTRB => S_AXI_WSTRB,
    S_AXI_WLAST => S_AXI_WLAST,
    S_AXI_WUSER => S_AXI_WUSER,
    S_AXI_WVALID => S_AXI_WVALID,
    S_AXI_WREADY => S_AXI_WREADY,
    S_AXI_BID => S_AXI_BID,
    S_AXI_BRESP => S_AXI_BRESP,
    S_AXI_BUSER => S_AXI_BUSER,
    S_AXI_BVALID => S_AXI_BVALID,
    S_AXI_BREADY => S_AXI_BREADY,
    S_AXI_ARID => S_AXI_ARID,
    S_AXI_ARADDR => S_AXI_ARADDR,
    S_AXI_ARLEN => S_AXI_ARLEN,
    S_AXI_ARSIZE => S_AXI_ARSIZE,
    S_AXI_ARBURST => S_AXI_ARBURST,
    S_AXI_ARLOCK => S_AXI_ARLOCK,
    S_AXI_ARCACHE => S_AXI_ARCACHE,
    S_AXI_ARPROT => S_AXI_ARPROT,
    S_AXI_ARQOS => S_AXI_ARQOS,
    S_AXI_ARREGION => S_AXI_ARREGION,
    S_AXI_ARUSER => S_AXI_ARUSER,
    S_AXI_ARVALID => S_AXI_ARVALID,
    S_AXI_ARREADY => S_AXI_ARREADY,
    S_AXI_RID => S_AXI_RID,
    S_AXI_RDATA => S_AXI_RDATA,
    S_AXI_RRESP => S_AXI_RRESP,
    S_AXI_RLAST => S_AXI_RLAST,
    S_AXI_RUSER => S_AXI_RUSER,
    S_AXI_RVALID => S_AXI_RVALID,
    S_AXI_RREADY => S_AXI_RREADY
  );
-- INST_TAG_END ------ End INSTANTIATION Template ---------

