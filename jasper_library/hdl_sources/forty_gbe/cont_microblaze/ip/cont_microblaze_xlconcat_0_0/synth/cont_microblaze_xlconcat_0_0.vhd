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

-- IP VLNV: xilinx.com:ip:xlconcat:2.1
-- IP Revision: 2

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

LIBRARY work;
USE work.xlconcat;

ENTITY cont_microblaze_xlconcat_0_0 IS
  PORT (
    In0 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    In1 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    dout : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
  );
END cont_microblaze_xlconcat_0_0;

ARCHITECTURE cont_microblaze_xlconcat_0_0_arch OF cont_microblaze_xlconcat_0_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF cont_microblaze_xlconcat_0_0_arch: ARCHITECTURE IS "yes";
  COMPONENT xlconcat IS
    GENERIC (
      IN0_WIDTH : INTEGER;
      IN1_WIDTH : INTEGER;
      IN2_WIDTH : INTEGER;
      IN3_WIDTH : INTEGER;
      IN4_WIDTH : INTEGER;
      IN5_WIDTH : INTEGER;
      IN6_WIDTH : INTEGER;
      IN7_WIDTH : INTEGER;
      IN8_WIDTH : INTEGER;
      IN9_WIDTH : INTEGER;
      IN10_WIDTH : INTEGER;
      IN11_WIDTH : INTEGER;
      IN12_WIDTH : INTEGER;
      IN13_WIDTH : INTEGER;
      IN14_WIDTH : INTEGER;
      IN15_WIDTH : INTEGER;
      IN16_WIDTH : INTEGER;
      IN17_WIDTH : INTEGER;
      IN18_WIDTH : INTEGER;
      IN19_WIDTH : INTEGER;
      IN20_WIDTH : INTEGER;
      IN21_WIDTH : INTEGER;
      IN22_WIDTH : INTEGER;
      IN23_WIDTH : INTEGER;
      IN24_WIDTH : INTEGER;
      IN25_WIDTH : INTEGER;
      IN26_WIDTH : INTEGER;
      IN27_WIDTH : INTEGER;
      IN28_WIDTH : INTEGER;
      IN29_WIDTH : INTEGER;
      IN30_WIDTH : INTEGER;
      IN31_WIDTH : INTEGER;
      dout_width : INTEGER;
      NUM_PORTS : INTEGER
    );
    PORT (
      In0 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      In1 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      In2 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      In3 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      In4 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      In5 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      In6 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      In7 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      In8 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      In9 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      In10 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      In11 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      In12 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      In13 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      In14 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      In15 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      In16 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      In17 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      In18 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      In19 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      In20 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      In21 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      In22 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      In23 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      In24 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      In25 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      In26 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      In27 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      In28 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      In29 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      In30 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      In31 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      dout : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
  END COMPONENT xlconcat;
  ATTRIBUTE X_CORE_INFO : STRING;
  ATTRIBUTE X_CORE_INFO OF cont_microblaze_xlconcat_0_0_arch: ARCHITECTURE IS "xlconcat,Vivado 2016.2";
  ATTRIBUTE CHECK_LICENSE_TYPE : STRING;
  ATTRIBUTE CHECK_LICENSE_TYPE OF cont_microblaze_xlconcat_0_0_arch : ARCHITECTURE IS "cont_microblaze_xlconcat_0_0,xlconcat,{}";
  ATTRIBUTE CORE_GENERATION_INFO : STRING;
  ATTRIBUTE CORE_GENERATION_INFO OF cont_microblaze_xlconcat_0_0_arch: ARCHITECTURE IS "cont_microblaze_xlconcat_0_0,xlconcat,{x_ipProduct=Vivado 2016.2,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=xlconcat,x_ipVersion=2.1,x_ipCoreRevision=2,x_ipLanguage=VHDL,x_ipSimLanguage=MIXED,IN0_WIDTH=1,IN1_WIDTH=1,IN2_WIDTH=1,IN3_WIDTH=1,IN4_WIDTH=1,IN5_WIDTH=1,IN6_WIDTH=1,IN7_WIDTH=1,IN8_WIDTH=1,IN9_WIDTH=1,IN10_WIDTH=1,IN11_WIDTH=1,IN12_WIDTH=1,IN13_WIDTH=1,IN14_WIDTH=1,IN15_WIDTH=1,IN16_WIDTH=1,IN17_WIDTH=1,IN18_WIDTH=1,IN19_WIDTH=1,IN20_WIDTH=1,IN21_WIDTH=1,IN22_WIDTH=1,IN23_WIDTH=1,IN2" & 
"4_WIDTH=1,IN25_WIDTH=1,IN26_WIDTH=1,IN27_WIDTH=1,IN28_WIDTH=1,IN29_WIDTH=1,IN30_WIDTH=1,IN31_WIDTH=1,dout_width=2,NUM_PORTS=2}";
BEGIN
  U0 : xlconcat
    GENERIC MAP (
      IN0_WIDTH => 1,
      IN1_WIDTH => 1,
      IN2_WIDTH => 1,
      IN3_WIDTH => 1,
      IN4_WIDTH => 1,
      IN5_WIDTH => 1,
      IN6_WIDTH => 1,
      IN7_WIDTH => 1,
      IN8_WIDTH => 1,
      IN9_WIDTH => 1,
      IN10_WIDTH => 1,
      IN11_WIDTH => 1,
      IN12_WIDTH => 1,
      IN13_WIDTH => 1,
      IN14_WIDTH => 1,
      IN15_WIDTH => 1,
      IN16_WIDTH => 1,
      IN17_WIDTH => 1,
      IN18_WIDTH => 1,
      IN19_WIDTH => 1,
      IN20_WIDTH => 1,
      IN21_WIDTH => 1,
      IN22_WIDTH => 1,
      IN23_WIDTH => 1,
      IN24_WIDTH => 1,
      IN25_WIDTH => 1,
      IN26_WIDTH => 1,
      IN27_WIDTH => 1,
      IN28_WIDTH => 1,
      IN29_WIDTH => 1,
      IN30_WIDTH => 1,
      IN31_WIDTH => 1,
      dout_width => 2,
      NUM_PORTS => 2
    )
    PORT MAP (
      In0 => In0,
      In1 => In1,
      In2 => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 1)),
      In3 => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 1)),
      In4 => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 1)),
      In5 => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 1)),
      In6 => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 1)),
      In7 => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 1)),
      In8 => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 1)),
      In9 => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 1)),
      In10 => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 1)),
      In11 => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 1)),
      In12 => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 1)),
      In13 => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 1)),
      In14 => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 1)),
      In15 => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 1)),
      In16 => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 1)),
      In17 => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 1)),
      In18 => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 1)),
      In19 => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 1)),
      In20 => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 1)),
      In21 => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 1)),
      In22 => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 1)),
      In23 => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 1)),
      In24 => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 1)),
      In25 => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 1)),
      In26 => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 1)),
      In27 => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 1)),
      In28 => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 1)),
      In29 => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 1)),
      In30 => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 1)),
      In31 => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 1)),
      dout => dout
    );
END cont_microblaze_xlconcat_0_0_arch;
