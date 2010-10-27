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
-- opb_selectmap_tb.vhd - entity/architecture pair
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
-- Filename:          opb_selectmap_tb.vhd
-- Version:           1.00.a
-- Description:       IP testbench
-- Date:              Thu Oct  6 12:05:53 2005 (by Create and Import Peripheral Wizard)
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

library opb_selectmap_v1_01_a;
library opb_selectmap_fifo_v1_01_a;

------------------------------------------------------------------------------
-- Entity section
------------------------------------------------------------------------------

entity opb_selectmap_tb is

  ------------------------------------------
  -- DO NOT CHANGE THIS GENERIC DECLARATION
  ------------------------------------------
  generic
  (
    -- Bus protocol parameters, do not add to or delete
    C_BASEADDR                     : std_logic_vector     := X"00000000";
    C_HIGHADDR                     : std_logic_vector     := X"0000FFFF";
    C_OPB_AWIDTH                   : integer              := 32;
    C_OPB_DWIDTH                   : integer              := 32;
    C_FAMILY                       : string               := "virtex2p"
  );

  ------------------------------------------
  -- DO NOT CHANGE THIS PORT DECLARATION
  ------------------------------------------
  port
  (
    -- OPB bus interface, do not add or delete
    OPB_Clk                        : in  std_logic;
    OPB_Rst                        : in  std_logic;
    Sl_DBus                        : out std_logic_vector(0 to C_OPB_DWIDTH-1);
    Sl_errAck                      : out std_logic;
    Sl_retry                       : out std_logic;
    Sl_toutSup                     : out std_logic;
    Sl_xferAck                     : out std_logic;
    OPB_ABus                       : in  std_logic_vector(0 to C_OPB_AWIDTH-1);
    OPB_BE                         : in  std_logic_vector(0 to C_OPB_DWIDTH/8-1);
    OPB_DBus                       : in  std_logic_vector(0 to C_OPB_DWIDTH-1);
    OPB_RNW                        : in  std_logic;
    OPB_select                     : in  std_logic;
    OPB_seqAddr                    : in  std_logic;
    -- BFM synchronization bus interface
    SYNCH_IN                       : in  std_logic_vector(0 to 31) := (others => '0');
    SYNCH_OUT                      : out std_logic_vector(0 to 31) := (others => '0')
  );

end entity opb_selectmap_tb;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

architecture testbench of opb_selectmap_tb is

  signal FPGA1_LoopData                 : std_logic_vector(0 to 7);
  signal FPGA1_LoopFull                 : std_logic;
  signal FPGA1_LoopEmpty                : std_logic;
  signal FPGA1_WrFifo_WrCnt             : std_logic_vector(0 to 7);
  signal FPGA1_RdFifo_RdCnt             : std_logic_vector(0 to 7);
  signal FPGA1_WrEn                     : std_logic;
  signal FPGA1_RdEn                     : std_logic;
  signal FPGA2_LoopData                 : std_logic_vector(0 to 7);
  signal FPGA2_LoopFull                 : std_logic;
  signal FPGA2_LoopEmpty                : std_logic;
  signal FPGA2_WrFifo_WrCnt             : std_logic_vector(0 to 7);
  signal FPGA2_RdFifo_RdCnt             : std_logic_vector(0 to 7);
  signal FPGA2_WrEn                     : std_logic;
  signal FPGA2_RdEn                     : std_logic;
  signal FPGA3_LoopData                 : std_logic_vector(0 to 7);
  signal FPGA3_LoopFull                 : std_logic;
  signal FPGA3_LoopEmpty                : std_logic;
  signal FPGA3_WrFifo_WrCnt             : std_logic_vector(0 to 7);
  signal FPGA3_RdFifo_RdCnt             : std_logic_vector(0 to 7);
  signal FPGA3_WrEn                     : std_logic;
  signal FPGA3_RdEn                     : std_logic;
  signal FPGA4_LoopData                 : std_logic_vector(0 to 7);
  signal FPGA4_LoopFull                 : std_logic;
  signal FPGA4_LoopEmpty                : std_logic;
  signal FPGA4_WrFifo_WrCnt             : std_logic_vector(0 to 7);
  signal FPGA4_RdFifo_RdCnt             : std_logic_vector(0 to 7);
  signal FPGA4_WrEn                     : std_logic;
  signal FPGA4_RdEn                     : std_logic;
  
  signal CCLK                           : std_logic;
  signal FPGA1_D_I                      : std_logic_vector(0 to 7);
  signal FPGA1_D_O                      : std_logic_vector(0 to 7);
  signal FPGA1_D_T                      : std_logic_vector(0 to 7);
  signal FPGA1_RDWR_B                   : std_logic;
  signal FPGA1_CS_B                     : std_logic;
  signal FPGA1_INIT_B                   : std_logic;
  signal FPGA1_DONE                     : std_logic;
  signal FPGA1_PROG_B                   : std_logic;
  signal FPGA2_D_I                      : std_logic_vector(0 to 7);
  signal FPGA2_D_O                      : std_logic_vector(0 to 7);
  signal FPGA2_D_T                      : std_logic_vector(0 to 7);    
  signal FPGA2_RDWR_B                   : std_logic;
  signal FPGA2_CS_B                     : std_logic;
  signal FPGA2_INIT_B                   : std_logic;
  signal FPGA2_DONE                     : std_logic;
  signal FPGA2_PROG_B                   : std_logic;
  signal FPGA3_D_I                      : std_logic_vector(0 to 7);
  signal FPGA3_D_O                      : std_logic_vector(0 to 7);
  signal FPGA3_D_T                      : std_logic_vector(0 to 7);    
  signal FPGA3_RDWR_B                   : std_logic;
  signal FPGA3_CS_B                     : std_logic;
  signal FPGA3_INIT_B                   : std_logic;
  signal FPGA3_DONE                     : std_logic;
  signal FPGA3_PROG_B                   : std_logic;
  signal FPGA4_D_I                      : std_logic_vector(0 to 7);
  signal FPGA4_D_O                      : std_logic_vector(0 to 7);
  signal FPGA4_D_T                      : std_logic_vector(0 to 7);    
  signal FPGA4_RDWR_B                   : std_logic;
  signal FPGA4_CS_B                     : std_logic;
  signal FPGA4_INIT_B                   : std_logic;
  signal FPGA4_DONE                     : std_logic;
  signal FPGA4_PROG_B                   : std_logic;
  
  ------------------------------------------
  -- Signal to hook up interrupt and synch bus
  ------------------------------------------
  signal sig_dev_intr                   : std_logic;

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

  FPGA1_WrEn <= (not FPGA1_LoopFull) and (not FPGA1_LoopEmpty);
  FPGA1_RdEn <= (not FPGA1_LoopFull) and (not FPGA1_LoopEmpty);
  FPGA1_DONE <= '1';
  FPGA2_WrEn <= (not FPGA2_LoopFull) and (not FPGA2_LoopEmpty);
  FPGA2_RdEn <= (not FPGA2_LoopFull) and (not FPGA2_LoopEmpty);
  FPGA2_DONE <= '1';  
  FPGA3_WrEn <= (not FPGA3_LoopFull) and (not FPGA3_LoopEmpty);
  FPGA3_RdEn <= (not FPGA3_LoopFull) and (not FPGA3_LoopEmpty);
  FPGA3_DONE <= '1';  
  FPGA4_WrEn <= (not FPGA4_LoopFull) and (not FPGA4_LoopEmpty);
  FPGA4_RdEn <= (not FPGA4_LoopFull) and (not FPGA4_LoopEmpty);
  FPGA4_DONE <= '1';  
  
  ------------------------------------------
  -- SelectMAP FIFO 1
  ------------------------------------------
  SMF1 : entity opb_selectmap_fifo_v1_01_a.user_fifo
    port map
    (
      WrFifo_Din                     => FPGA1_LoopData,
      WrFifo_WrEn                    => FPGA1_WrEn,
      WrFifo_Full                    => FPGA1_LoopFull,
      WrFifo_WrCnt                   => FPGA1_WrFifo_WrCnt,
      RdFifo_Dout                    => FPGA1_LoopData,
      RdFifo_RdEn                    => FPGA1_RdEn,
      RdFifo_Empty                   => FPGA1_LoopEmpty,
      RdFifo_RdCnt                   => FPGA1_RdFifo_RdCnt,
      User_Rst                       => OPB_Rst,
      User_Clk                       => OPB_Clk,
      Sys_Rst                        => OPB_Rst,
      Sys_Clk                        => OPB_Clk,
      D_I                            => FPGA1_D_O,
      D_O                            => FPGA1_D_I,
      D_T                            => FPGA1_D_T,
      RDWR_B                         => FPGA1_RDWR_B,
      CS_B                           => FPGA1_CS_B,
      INIT_B                         => FPGA1_INIT_B,
      CCLK                           => CCLK
      );

  ------------------------------------------
  -- SelectMAP FIFO 2
  ------------------------------------------
  SMF2 : entity opb_selectmap_fifo_v1_01_a.user_fifo
    port map
    (
      WrFifo_Din                     => FPGA2_LoopData,
      WrFifo_WrEn                    => FPGA2_WrEn,
      WrFifo_Full                    => FPGA2_LoopFull,
      WrFifo_WrCnt                   => FPGA2_WrFifo_WrCnt,
      RdFifo_Dout                    => FPGA2_LoopData,
      RdFifo_RdEn                    => FPGA2_RdEn,
      RdFifo_Empty                   => FPGA2_LoopEmpty,
      RdFifo_RdCnt                   => FPGA2_RdFifo_RdCnt,
      User_Rst                       => OPB_Rst,
      User_Clk                       => OPB_Clk,
      Sys_Rst                        => OPB_Rst,
      Sys_Clk                        => OPB_Clk,
      D_I                            => FPGA2_D_O,
      D_O                            => FPGA2_D_I,
      D_T                            => FPGA2_D_T,
      RDWR_B                         => FPGA2_RDWR_B,
      CS_B                           => FPGA2_CS_B,
      INIT_B                         => FPGA2_INIT_B,
      CCLK                           => CCLK
      );

  ------------------------------------------
  -- SelectMAP FIFO 3
  ------------------------------------------
  SMF3 : entity opb_selectmap_fifo_v1_01_a.user_fifo
    port map
    (
      WrFifo_Din                     => FPGA3_LoopData,
      WrFifo_WrEn                    => FPGA3_WrEn,
      WrFifo_Full                    => FPGA3_LoopFull,
      WrFifo_WrCnt                   => FPGA3_WrFifo_WrCnt,
      RdFifo_Dout                    => FPGA3_LoopData,
      RdFifo_RdEn                    => FPGA3_RdEn,
      RdFifo_Empty                   => FPGA3_LoopEmpty,
      RdFifo_RdCnt                   => FPGA3_RdFifo_RdCnt,
      User_Rst                       => OPB_Rst,
      User_Clk                       => OPB_Clk,
      Sys_Rst                        => OPB_Rst,
      Sys_Clk                        => OPB_Clk,
      D_I                            => FPGA3_D_O,
      D_O                            => FPGA3_D_I,
      D_T                            => FPGA3_D_T,
      RDWR_B                         => FPGA3_RDWR_B,
      CS_B                           => FPGA3_CS_B,
      INIT_B                         => FPGA3_INIT_B,
      CCLK                           => CCLK
      );

  ------------------------------------------
  -- SelectMAP FIFO 4
  ------------------------------------------
  SMF4 : entity opb_selectmap_fifo_v1_01_a.user_fifo
    port map
    (
      WrFifo_Din                     => FPGA4_LoopData,
      WrFifo_WrEn                    => FPGA4_WrEn,
      WrFifo_Full                    => FPGA4_LoopFull,
      WrFifo_WrCnt                   => FPGA4_WrFifo_WrCnt,
      RdFifo_Dout                    => FPGA4_LoopData,
      RdFifo_RdEn                    => FPGA4_RdEn,
      RdFifo_Empty                   => FPGA4_LoopEmpty,
      RdFifo_RdCnt                   => FPGA4_RdFifo_RdCnt,
      User_Rst                       => OPB_Rst,
      User_Clk                       => OPB_Clk,
      Sys_Rst                        => OPB_Rst,
      Sys_Clk                        => OPB_Clk,
      D_I                            => FPGA4_D_O,
      D_O                            => FPGA4_D_I,
      D_T                            => FPGA4_D_T,
      RDWR_B                         => FPGA4_RDWR_B,
      CS_B                           => FPGA4_CS_B,
      INIT_B                         => FPGA4_INIT_B,
      CCLK                           => CCLK
      );
  
  ------------------------------------------
  -- Instance of IP under test.
  -- Communication with the BFL is by using SYNCH_IN/SYNCH_OUT signals.
  ------------------------------------------
  UUT : entity opb_selectmap_v1_01_a.opb_selectmap
    generic map
    (
      -- MAP USER GENERICS BELOW THIS LINE ---------------
      --USER generics mapped here
      -- MAP USER GENERICS ABOVE THIS LINE ---------------

      C_BASEADDR                     => C_BASEADDR,
      C_HIGHADDR                     => C_HIGHADDR,
      C_OPB_AWIDTH                   => C_OPB_AWIDTH,
      C_OPB_DWIDTH                   => C_OPB_DWIDTH,
      C_FAMILY                       => C_FAMILY
    )
    port map
    (
      -- MAP USER PORTS BELOW THIS LINE ------------------
      CCLK                           => CCLK,
      FPGA1_D_I                      => FPGA1_D_I,
      FPGA1_D_O                      => FPGA1_D_O,
      FPGA1_D_T                      => FPGA1_D_T,            
      FPGA1_RDWR_B                   => FPGA1_RDWR_B,
      FPGA1_CS_B                     => FPGA1_CS_B,
      FPGA1_INIT_B                   => FPGA1_INIT_B,
      FPGA1_DONE                     => FPGA1_DONE,
      FPGA1_PROG_B                   => FPGA1_PROG_B,
      FPGA2_D_I                      => FPGA2_D_I,
      FPGA2_D_O                      => FPGA2_D_O,
      FPGA2_D_T                      => FPGA2_D_T,            
      FPGA2_RDWR_B                   => FPGA2_RDWR_B,
      FPGA2_CS_B                     => FPGA2_CS_B,
      FPGA2_INIT_B                   => FPGA2_INIT_B,
      FPGA2_DONE                     => FPGA2_DONE,
      FPGA2_PROG_B                   => FPGA2_PROG_B,
      FPGA3_D_I                      => FPGA3_D_I,
      FPGA3_D_O                      => FPGA3_D_O,
      FPGA3_D_T                      => FPGA3_D_T,            
      FPGA3_RDWR_B                   => FPGA3_RDWR_B,
      FPGA3_CS_B                     => FPGA3_CS_B,
      FPGA3_INIT_B                   => FPGA3_INIT_B,
      FPGA3_DONE                     => FPGA3_DONE,
      FPGA3_PROG_B                   => FPGA3_PROG_B,
      FPGA4_D_I                      => FPGA4_D_I,
      FPGA4_D_O                      => FPGA4_D_O,
      FPGA4_D_T                      => FPGA4_D_T,            
      FPGA4_RDWR_B                   => FPGA4_RDWR_B,
      FPGA4_CS_B                     => FPGA4_CS_B,
      FPGA4_INIT_B                   => FPGA4_INIT_B,
      FPGA4_DONE                     => FPGA4_DONE,
      FPGA4_PROG_B                   => FPGA4_PROG_B,
      -- MAP USER PORTS ABOVE THIS LINE ------------------

      OPB_Clk                        => OPB_Clk,
      OPB_Rst                        => OPB_Rst,
      Sl_DBus                        => Sl_DBus,
      Sl_errAck                      => Sl_errAck,
      Sl_retry                       => Sl_retry,
      Sl_toutSup                     => Sl_toutSup,
      Sl_xferAck                     => Sl_xferAck,
      OPB_ABus                       => OPB_ABus,
      OPB_BE                         => OPB_BE,
      OPB_DBus                       => OPB_DBus,
      OPB_RNW                        => OPB_RNW,
      OPB_select                     => OPB_select,
      OPB_seqAddr                    => OPB_seqAddr,
      IP2INTC_Irpt                   => sig_dev_intr
    );

  ------------------------------------------
  -- Hook up UUT interrupt to synch_out bit that is used for interrupt synchronization
  ------------------------------------------
  SYNCH_OUT(INTERRUPT) <= sig_dev_intr;

  ------------------------------------------
  -- Zero out the unused synch_out bits
  ------------------------------------------
  SYNCH_OUT(10 to 30)  <= (others => '0');

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
    wait until (OPB_Rst'EVENT and OPB_Rst = '0');
    assert FALSE report "*** Real simulation starts here ***" severity NOTE;
    -- wait for reset to be completed
    wait for 200 ns;

    ------------------------------------------
    -- Test User Logic Slave Register
    ------------------------------------------
    -- send out start signal to begin testing ...
    wait until (OPB_Clk'EVENT and OPB_Clk = '1');
    SYNCH_OUT(START) <= '1';
    assert FALSE report "*** Start User Logic Slave Register Test ***" severity NOTE;
    wait until (OPB_Clk'EVENT and OPB_Clk = '1');
    SYNCH_OUT(START) <= '0';

    -- wait stop signal for end of testing ...
    wait until (SYNCH_IN(STOP)'EVENT and SYNCH_IN(STOP) = '1');
    assert FALSE report "*** User Logic Slave Register Test Complete ***" severity NOTE;
    wait for 1 us;

    ------------------------------------------
    -- Test User Logic Interrupt
    ------------------------------------------
    -- send out start signal to begin testing ...
    wait until (OPB_Clk'EVENT and OPB_Clk = '1');
    SYNCH_OUT(START) <= '1';
    assert FALSE report "*** Start User Logic Interrupt Test ***" severity NOTE;
    wait until (OPB_Clk'EVENT and OPB_Clk = '1');
    SYNCH_OUT(START) <= '0';

    -- wait for interrupt ...
    wait until (sig_dev_intr = '1');
    assert FALSE report "*** User Logic Interrupt Occurred ***" severity NOTE;
    wait until (sig_dev_intr = '0');

    -- wait stop signal for end of testing ...
    wait until (SYNCH_IN(STOP)'EVENT and SYNCH_IN(STOP) = '1');
    assert FALSE report "*** User Logic Interrupt Test Complete ***" severity NOTE;
    wait for 1 us;

    ------------------------------------------
    -- Test User I/Os and other features
    ------------------------------------------
    --USER code added here to stimulate any user I/Os

    wait;

  end process TEST_PROCESS;

end architecture testbench;
