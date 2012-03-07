------------------------------------------------------------------------------
--
--   This vhdl module is a template for creating IP testbenches using the IBM
--   BFM toolkits. It provides a fixed interface to the subsystem testbench.
--
--   DO NOT CHANGE THE entity name, architecture name, generic parameter
--   declaration or port declaration of this file. You may add components,
--   instances, constants, signals, etc. as you wish.
--
--   See IBM Bus Functional Model Toolkit User's Manual for more information
--   on the BFMs.
--
------------------------------------------------------------------------------
-- plb_sram_tb.vhd - entity/architecture pair
------------------------------------------------------------------------------
--
-- ***************************************************************************
-- ** Copyright (c) 1995-2005 Xilinx, Inc.  All rights reserved.            **
-- **                                                                       **
-- ** Xilinx, Inc.                                                          **
-- ** XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"         **
-- ** AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND       **
-- ** SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,        **
-- ** OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,        **
-- ** APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION           **
-- ** THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,     **
-- ** AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE      **
-- ** FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY              **
-- ** WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE               **
-- ** IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR        **
-- ** REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF       **
-- ** INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS       **
-- ** FOR A PARTICULAR PURPOSE.                                             **
-- **                                                                       **
-- ** YOU MAY COPY AND MODIFY THESE FILES FOR YOUR OWN INTERNAL USE SOLELY  **
-- ** WITH XILINX PROGRAMMABLE LOGIC DEVICES AND XILINX EDK SYSTEM OR       **
-- ** CREATE IP MODULES SOLELY FOR XILINX PROGRAMMABLE LOGIC DEVICES AND    **
-- ** XILINX EDK SYSTEM. NO RIGHTS ARE GRANTED TO DISTRIBUTE ANY FILES      **
-- ** UNLESS THEY ARE DISTRIBUTED IN XILINX PROGRAMMABLE LOGIC DEVICES.     **
-- **                                                                       **
-- ***************************************************************************
--
------------------------------------------------------------------------------
-- Filename:          plb_sram_tb.vhd
-- Version:           1.00.a
-- Description:       IP testbench
-- Date:              Tue May 23 16:27:57 2006 (by Create and Import Peripheral Wizard)
-- VHDL Standard:     VHDL'93
------------------------------------------------------------------------------
-- Naming Conventions:
--   active low signals:                    "*_n"
--   clock signals:                         "clk", "clk_div#", "clk_#x"
--   reset signals:                         "rst", "rst_n"
--   generics:                              "C_*"
--   user defined types:                    "*_TYPE"
--   state machine next state:              "*_ns"
--   state machine current state:           "*_cs"
--   combinatorial signals:                 "*_com"
--   pipelined or register delay signals:   "*_d#"
--   counter signals:                       "*cnt*"
--   clock enable signals:                  "*_ce"
--   internal version of output port:       "*_i"
--   device pins:                           "*_pin"
--   ports:                                 "- Names begin with Uppercase"
--   processes:                             "*_PROCESS"
--   component instantiations:              "<ENTITY_>I_<#|FUNC>"
------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library plb_sram_v1_00_a;

--USER libraries added here

------------------------------------------------------------------------------
-- Entity section
------------------------------------------------------------------------------

entity plb_sram_tb is

  ------------------------------------------
  -- DO NOT CHANGE THIS GENERIC DECLARATION
  ------------------------------------------
  generic
  (
    -- Bus protocol parameters, do not add to or delete
    C_BASEADDR                     : std_logic_vector     := X"FFFFFFFF";
    C_HIGHADDR                     : std_logic_vector     := X"00000000";
    C_PLB_AWIDTH                   : integer              := 32;
    C_PLB_DWIDTH                   : integer              := 64;
    C_PLB_NUM_MASTERS              : integer              := 8;
    C_PLB_MID_WIDTH                : integer              := 3;
    C_FAMILY                       : string               := "virtex2p";
    C_AR0_BASEADDR                 : std_logic_vector     := X"FFFFFFFF";
    C_AR0_HIGHADDR                 : std_logic_vector     := X"00000000"
  );

  ------------------------------------------
  -- DO NOT CHANGE THIS PORT DECLARATION
  ------------------------------------------
  port
  (
    -- PLB bus interface, do not add or delete
    PLB_Clk                        : in  std_logic;
    PLB_Rst                        : in  std_logic;
    Sl_addrAck                     : out std_logic;
    Sl_MBusy                       : out std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
    Sl_MErr                        : out std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
    Sl_rdBTerm                     : out std_logic;
    Sl_rdComp                      : out std_logic;
    Sl_rdDAck                      : out std_logic;
    Sl_rdDBus                      : out std_logic_vector(0 to C_PLB_DWIDTH-1);
    Sl_rdWdAddr                    : out std_logic_vector(0 to 3);
    Sl_rearbitrate                 : out std_logic;
    Sl_SSize                       : out std_logic_vector(0 to 1);
    Sl_wait                        : out std_logic;
    Sl_wrBTerm                     : out std_logic;
    Sl_wrComp                      : out std_logic;
    Sl_wrDAck                      : out std_logic;
    PLB_abort                      : in  std_logic;
    PLB_ABus                       : in  std_logic_vector(0 to C_PLB_AWIDTH-1);
    PLB_BE                         : in  std_logic_vector(0 to C_PLB_DWIDTH/8-1);
    PLB_busLock                    : in  std_logic;
    PLB_compress                   : in  std_logic;
    PLB_guarded                    : in  std_logic;
    PLB_lockErr                    : in  std_logic;
    PLB_masterID                   : in  std_logic_vector(0 to C_PLB_MID_WIDTH-1);
    PLB_MSize                      : in  std_logic_vector(0 to 1);
    PLB_ordered                    : in  std_logic;
    PLB_PAValid                    : in  std_logic;
    PLB_pendPri                    : in  std_logic_vector(0 to 1);
    PLB_pendReq                    : in  std_logic;
    PLB_rdBurst                    : in  std_logic;
    PLB_rdPrim                     : in  std_logic;
    PLB_reqPri                     : in  std_logic_vector(0 to 1);
    PLB_RNW                        : in  std_logic;
    PLB_SAValid                    : in  std_logic;
    PLB_size                       : in  std_logic_vector(0 to 3);
    PLB_type                       : in  std_logic_vector(0 to 2);
    PLB_wrBurst                    : in  std_logic;
    PLB_wrDBus                     : in  std_logic_vector(0 to C_PLB_DWIDTH-1);
    PLB_wrPrim                     : in  std_logic;
    -- BFM synchronization bus interface
    SYNCH_IN                       : in  std_logic_vector(0 to 31) := (others => '0');
    SYNCH_OUT                      : out std_logic_vector(0 to 31) := (others => '0')
  );

end entity plb_sram_tb;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

architecture testbench of plb_sram_tb is

  --USER testbench signal declarations added here as you wish

  ------------------------------------------
  -- Standard constants for bfl/vhdl communication
  ------------------------------------------
  constant NOP        : integer := 0;
  constant START      : integer := 1;
  constant STOP       : integer := 2;
  constant WAIT_IN    : integer := 3;
  constant WAIT_OUT   : integer := 4;
  constant ASSERT_IN  : integer := 5;
  constant ASSERT_OUT : integer := 6;
  constant ASSIGN_IN  : integer := 7;
  constant ASSIGN_OUT : integer := 8;
  constant RESET_WDT  : integer := 9;
  constant INTERRUPT  : integer := 31;

begin

  ------------------------------------------
  -- Instance of IP under test.
  -- Communication with the BFL is by using SYNCH_IN/SYNCH_OUT signals.
  ------------------------------------------
  UUT : entity plb_sram_v1_00_a.plb_sram
    generic map
    (
      -- MAP USER GENERICS BELOW THIS LINE ---------------
      --USER generics mapped here
      -- MAP USER GENERICS ABOVE THIS LINE ---------------

      C_BASEADDR                     => C_BASEADDR,
      C_HIGHADDR                     => C_HIGHADDR,
      C_PLB_AWIDTH                   => C_PLB_AWIDTH,
      C_PLB_DWIDTH                   => C_PLB_DWIDTH,
      C_PLB_NUM_MASTERS              => C_PLB_NUM_MASTERS,
      C_PLB_MID_WIDTH                => C_PLB_MID_WIDTH,
      C_FAMILY                       => C_FAMILY,
      C_AR0_BASEADDR                 => C_AR0_BASEADDR,
      C_AR0_HIGHADDR                 => C_AR0_HIGHADDR
    )
    port map
    (
      -- MAP USER PORTS BELOW THIS LINE ------------------
      --USER ports mapped here
      -- MAP USER PORTS ABOVE THIS LINE ------------------

      PLB_Clk                        => PLB_Clk,
      PLB_Rst                        => PLB_Rst,
      Sl_addrAck                     => Sl_addrAck,
      Sl_MBusy                       => Sl_MBusy,
      Sl_MErr                        => Sl_MErr,
      Sl_rdBTerm                     => Sl_rdBTerm,
      Sl_rdComp                      => Sl_rdComp,
      Sl_rdDAck                      => Sl_rdDAck,
      Sl_rdDBus                      => Sl_rdDBus,
      Sl_rdWdAddr                    => Sl_rdWdAddr,
      Sl_rearbitrate                 => Sl_rearbitrate,
      Sl_SSize                       => Sl_SSize,
      Sl_wait                        => Sl_wait,
      Sl_wrBTerm                     => Sl_wrBTerm,
      Sl_wrComp                      => Sl_wrComp,
      Sl_wrDAck                      => Sl_wrDAck,
      PLB_abort                      => PLB_abort,
      PLB_ABus                       => PLB_ABus,
      PLB_BE                         => PLB_BE,
      PLB_busLock                    => PLB_busLock,
      PLB_compress                   => PLB_compress,
      PLB_guarded                    => PLB_guarded,
      PLB_lockErr                    => PLB_lockErr,
      PLB_masterID                   => PLB_masterID,
      PLB_MSize                      => PLB_MSize,
      PLB_ordered                    => PLB_ordered,
      PLB_PAValid                    => PLB_PAValid,
      PLB_pendPri                    => PLB_pendPri,
      PLB_pendReq                    => PLB_pendReq,
      PLB_rdBurst                    => PLB_rdBurst,
      PLB_rdPrim                     => PLB_rdPrim,
      PLB_reqPri                     => PLB_reqPri,
      PLB_RNW                        => PLB_RNW,
      PLB_SAValid                    => PLB_SAValid,
      PLB_size                       => PLB_size,
      PLB_type                       => PLB_type,
      PLB_wrBurst                    => PLB_wrBurst,
      PLB_wrDBus                     => PLB_wrDBus,
      PLB_wrPrim                     => PLB_wrPrim
    );

  ------------------------------------------
  -- Zero out the unused synch_out bits
  ------------------------------------------
  SYNCH_OUT(10 to 31)  <= (others => '0');

  ------------------------------------------
  -- Test bench code itself
  --
  -- The test bench itself can be arbitrarily complex and may include
  -- hierarchy as the designer sees fit
  ------------------------------------------
  TEST_PROCESS : process
  begin

    SYNCH_OUT(NOP)        <= '0';
    SYNCH_OUT(START)      <= '0';
    SYNCH_OUT(STOP)       <= '0';
    SYNCH_OUT(WAIT_IN)    <= '0';
    SYNCH_OUT(WAIT_OUT)   <= '0';
    SYNCH_OUT(ASSERT_IN)  <= '0';
    SYNCH_OUT(ASSERT_OUT) <= '0';
    SYNCH_OUT(ASSIGN_IN)  <= '0';
    SYNCH_OUT(ASSIGN_OUT) <= '0';
    SYNCH_OUT(RESET_WDT)  <= '0';

    -- initializations
    -- wait for reset to stabalize after power-up
    wait for 200 ns;
    -- wait for end of reset
    wait until (PLB_Rst'EVENT and PLB_Rst = '0');
    assert FALSE report "*** Real simulation starts here ***" severity NOTE;
    -- wait for reset to be completed
    wait for 200 ns;

    ------------------------------------------
    -- Test User Logic BRAM (single transaction)
    ------------------------------------------
    -- send out start signal to begin testing ...
    wait until (PLB_Clk'EVENT and PLB_Clk = '1');
    SYNCH_OUT(START) <= '1';
    assert FALSE report "*** Start User Logic BRAM (single transaction) Test ***" severity NOTE;
    wait until (PLB_Clk'EVENT and PLB_Clk = '1');
    SYNCH_OUT(START) <= '0';

    -- wait stop signal for end of testing ...
    wait until (SYNCH_IN(STOP)'EVENT and SYNCH_IN(STOP) = '1');
    assert FALSE report "*** User Logic BRAM (single transaction) Test Complete ***" severity NOTE;
    wait for 1 us;

    ------------------------------------------
    -- Test User I/Os and other features
    ------------------------------------------
    --USER code added here to stimulate any user I/Os

    wait;

  end process TEST_PROCESS;

end architecture testbench;
