-------------------------------------------------------------------------------
-- $Revision: 1.1 $ $Date: 2006/09/06 18:13:22 $
-------------------------------------------------------------------------------
-- File       : physical_if.vhd  
-- Author     : Xilinx Inc.
-------------------------------------------------------------------------------
-- Description: This is the Physical interface vhdl code for the 
-- Ten Gigabit Etherent MAC. It may contain the Recieve clock
-- generation depending on the configuration options when 
-- generated.
-------------------------------------------------------------------------------
-- Copyright (c) 2001-2006 by Xilinx, Inc. All rights reserved.
-- This text/file contains proprietary, confidential
-- information of Xilinx, Inc., is distributed under license
-- from Xilinx, Inc., and may be used, copied and/or
-- disclosed only pursuant to the terms of a valid license
-- agreement with Xilinx, Inc. Xilinx hereby grants you
-- a license to use this text/file solely for design, simulation,
-- implementation and creation of design files limited
-- to Xilinx devices or technologies. Use with non-Xilinx
-- devices or technologies is expressly prohibited and
-- immediately terminates your license unless covered by
-- a separate agreement.
--
-- Xilinx is providing this design, code, or information
-- "as is" solely for use in developing programs and
-- solutions for Xilinx devices. By providing this design,
-- code, or information as one possible implementation of
-- this feature, application or standard, Xilinx is making no
-- representation that this implementation is free from any
-- claims of infringement. You are responsible for
-- obtaining any rights you may require for your implementation.
-- Xilinx expressly disclaims any warranty whatsoever with
-- respect to the adequacy of the implementation, including
-- but not limited to any warranties or representations that this
-- implementation is free from claims of infringement, implied
-- warranties of merchantability or fitness for a particular
-- purpose.
--
-- Xilinx products are not intended for use in life support
-- appliances, devices, or systems. Use in such applications are
-- expressly prohibited.
--
-- This copyright and support notice must be retained as part
-- of this text at all times. (c) Copyright 2001-2006 Xilinx, Inc.
-- All rights reserved.
-------------------------------------------------------------------------------
library unisim;
use unisim.vcomponents.all;

library ieee;
use ieee.std_logic_1164.all;

entity physical_if is
    port (
    reset          : in std_logic;
    tx_clk0        : in  std_logic;
    tx_clk90       : in  std_logic;
    tx_clk180      : in std_logic;
    tx_clk270      : in std_logic;
    xgmii_txd_core : in std_logic_vector(63 downto 0);
    xgmii_txc_core : in std_logic_vector(7 downto 0);
    xgmii_txd      : out std_logic_vector(63 downto 0);
    xgmii_txc      : out std_logic_vector(7 downto 0)

;
    rx_clk0        : out  std_logic;
    rx_dcm_locked  : out std_logic;
    xgmii_rx_clk   : in  std_logic;
    xgmii_rxd      : in  std_logic_vector(63 downto 0);
    xgmii_rxc      : in  std_logic_vector(7 downto 0);
    xgmii_rxd_core : out  std_logic_vector(63 downto 0); 
    xgmii_rxc_core : out  std_logic_vector(7 downto 0)
    ); 
end physical_if;


architecture wrapper of physical_if is
 
  constant D_LOCAL_FAULT : bit_vector(63 downto 0) := X"0100009C0100009C";
  constant C_LOCAL_FAULT : bit_vector(7 downto 0) := "00010001";
  -----------------------------------------------------------------------------
  -- Internal Signal Declaration for XGMAC (the 10Gb/E MAC core).
  -----------------------------------------------------------------------------  

  signal vcc, gnd : std_logic;

  signal rx_dcm_locked_reg  : std_logic;  -- registered version (RX_CLK0)

  signal xgmii_rx_clk_dcm : std_logic;
  signal rx_clk0_int : std_logic;
  signal rx_clk180 : std_logic;
  signal rx_dcm_clk0 : std_logic;
  signal rx_dcm_clk180 : std_logic;
  signal rxd_sdr : std_logic_vector(63 downto 0);
  signal rxc_sdr : std_logic_vector(7 downto 0);

  attribute INIT : string;
  attribute KEEP : string;
  attribute KEEP of rx_clk0 : signal is "true";

  function bit_to_string (
    constant b : bit)
    return string is
  begin  -- bit_to_string
    if b = '1' then
      return "1";
    else
      return "0";
    end if;
  end bit_to_string;


begin
  vcc <= '1';
  gnd <= '0';

  -- receive clock management
  --  Global input clock buffer for Receiver Clock
  xgmii_rx_clk_ibufg : IBUFG
    port map (
      I => xgmii_rx_clk,
      O => xgmii_rx_clk_dcm);
  
  rx_dcm : DCM
    port map (
      CLKIN    => xgmii_rx_clk_dcm,
      CLKFB    => rx_clk0_int,
      RST      => reset,
      DSSEN    => gnd,
      PSINCDEC => gnd,
      PSEN     => gnd,
      PSCLK    => gnd,
      CLK0     => rx_dcm_clk0,
      CLK90    => open,
      CLK180   => rx_dcm_clk180,
      CLK270   => open,
      CLK2X    => open,
      CLK2X180 => open,
      CLKDV    => open,
      CLKFX    => open,
      CLKFX180 => open,
      LOCKED   => rx_dcm_locked,
      STATUS   => open,
      PSDONE   => open);                                   

  rx_bufg0 : BUFG
    port map(
      I => rx_dcm_clk0,
      O => rx_clk0_int);

  rx_clk0 <= rx_clk0_int;

  rx_bufg180 : BUFG
   port map (
      I => rx_dcm_clk180,
      O => rx_clk180);



  -- infer some registers which should go into the IOBs
  P_INPUT_FF : process (rx_clk0_int)
  begin
    if rx_clk0_int'event and rx_clk0_int = '1' then
      xgmii_rxd_core <= xgmii_rxd;
      xgmii_rxc_core <= xgmii_rxc;
    end if;
  end process P_INPUT_FF;

  G_OUTPUT_FF_D : for I in 0 to 63 generate
    attribute INIT of txd_oreg : label is bit_to_string(D_LOCAL_FAULT(I));
  begin
    txd_oreg : FD
      -- synthesis translate_off
      generic map (
        INIT => D_LOCAL_FAULT(I))
      -- synthesis translate_on
      port map (
        Q  => xgmii_txd(I),
        C  => tx_clk0,
        D  => xgmii_txd_core(I));
  end generate;

  G_OUTPUT_FF_C : for I in 0 to 7 generate
    attribute INIT of txc_oreg : label is bit_to_string(C_LOCAL_FAULT(I));
  begin
    txc_oreg : FD
      -- synthesis translate_off
      generic map (
        INIT => C_LOCAL_FAULT(I))
      -- synthesis translate_on
      port map (
        Q  => xgmii_txc(I),
        C  => tx_clk0,
        D  => xgmii_txc_core(I));
  end generate;


end wrapper;


