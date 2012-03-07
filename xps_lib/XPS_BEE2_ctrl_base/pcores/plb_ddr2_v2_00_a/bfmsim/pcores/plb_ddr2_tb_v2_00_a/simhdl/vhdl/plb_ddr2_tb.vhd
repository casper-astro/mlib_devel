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
-- plb_ddr2_tb.vhd - entity/architecture pair
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
-- Filename:          plb_ddr2_tb.vhd
-- Version:           2.00.a
-- Description:       IP testbench
-- Date:              Wed Feb  1 23:04:20 2006 (by Create and Import Peripheral Wizard)
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

library plb_ddr2_v2_00_a;
library opb_framebuffer_v2_00_a;
library multiport_ddr2_v2_00_a;
library async_ddr2_v2_00_a;
library ddr2_controller_v2_00_a;
library ddr2_infrastructure_v2_00_a;

------------------------------------------------------------------------------
-- Entity section
------------------------------------------------------------------------------

entity plb_ddr2_tb is

  ------------------------------------------
  -- DO NOT CHANGE THIS GENERIC DECLARATION
  ------------------------------------------
  generic
  (
    C_WIDE_DATA                    : integer              := 0;
    C_HALF_BURST                   : integer              := 1;
    C_SUPPORT_SHARED               : integer              := 0;
    C_BANK_MANAGEMENT              : integer              := 0;
    C_BURST_WINDOW                 : integer              := 0;
    C_BWIND_WIDTH                  : integer              := 0;
    -- Bus protocol parameters, do not add to or delete
    C_BASEADDR                     : std_logic_vector     := X"FFFFFFFF";
    C_HIGHADDR                     : std_logic_vector     := X"00000000";
    C_PLB_AWIDTH                   : integer              := 32;
    C_PLB_DWIDTH                   : integer              := 64;
    C_PLB_NUM_MASTERS              : integer              := 8;
    C_PLB_MID_WIDTH                : integer              := 3;
    C_FAMILY                       : string               := "virtex2p"
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

end entity plb_ddr2_tb;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

architecture testbench of plb_ddr2_tb is
  
  signal sys_reset_in                   : std_logic;
  signal sys_clk_in                     : std_logic;
  signal sys_dcmlock_in                 : std_logic;

  signal ddr_clk                        : std_logic;
  signal ddr_clk90                      : std_logic;
  signal ddr_delay_sel                  : std_logic_vector(4 downto 0);
  signal ddr_inf_reset                  : std_logic;

  signal DDR_input_data                 : std_logic_vector(143 downto 0);
  signal DDR_byte_enable                : std_logic_vector(17 downto 0);
  signal DDR_get_data                   : std_logic;
  signal DDR_output_data                : std_logic_vector(143 downto 0);
  signal DDR_data_valid                 : std_logic;
  signal DDR_address                    : std_logic_vector(31 downto 0);
  signal DDR_read                       : std_logic;
  signal DDR_write                      : std_logic;
  signal DDR_half_burst                 : std_logic;
  signal DDR_ready                      : std_logic;
  signal DDR_reset                      : std_logic;

  signal In0_Cmd_Address                : std_logic_vector(31 downto 0);
  signal In0_Cmd_RNW                    : std_logic;
  signal In0_Cmd_Valid                  : std_logic;
  signal In0_Cmd_Tag                    : std_logic_vector(31 downto 0);
  signal In0_Cmd_Ack                    : std_logic;
  signal In0_Rd_Dout                    : std_logic_vector((144*(C_WIDE_DATA+1))-1 downto 0);
  signal In0_Rd_Tag                     : std_logic_vector(31 downto 0);
  signal In0_Rd_Ack                     : std_logic;
  signal In0_Rd_Valid                   : std_logic;
  signal In0_Wr_Din                     : std_logic_vector((144*(C_WIDE_DATA+1))-1 downto 0);
  signal In0_Wr_BE                      : std_logic_vector((18*(C_WIDE_DATA+1))-1 downto 0);

  signal In1_Cmd_Address                : std_logic_vector(31 downto 0);
  signal In1_Cmd_RNW                    : std_logic;
  signal In1_Cmd_Valid                  : std_logic;
  signal In1_Cmd_Tag                    : std_logic_vector(31 downto 0);
  signal In1_Cmd_Ack                    : std_logic;
  signal In1_Rd_Dout                    : std_logic_vector((144*(C_WIDE_DATA+1))-1 downto 0);
  signal In1_Rd_Tag                     : std_logic_vector(31 downto 0);
  signal In1_Rd_Ack                     : std_logic;
  signal In1_Rd_Valid                   : std_logic;
  signal In1_Wr_Din                     : std_logic_vector((144*(C_WIDE_DATA+1))-1 downto 0);
  signal In1_Wr_BE                      : std_logic_vector((18*(C_WIDE_DATA+1))-1 downto 0);

  signal Out_Cmd_Address                : std_logic_vector(31 downto 0);
  signal Out_Cmd_RNW                    : std_logic;
  signal Out_Cmd_Valid                  : std_logic;
  signal Out_Cmd_Tag                    : std_logic_vector(31 downto 0);
  signal Out_Cmd_Ack                    : std_logic;
  signal Out_Rd_Dout                    : std_logic_vector((144*(C_WIDE_DATA+1))-1 downto 0);
  signal Out_Rd_Tag                     : std_logic_vector(31 downto 0);
  signal Out_Rd_Ack                     : std_logic;
  signal Out_Rd_Valid                   : std_logic;
  signal Out_Wr_Din                     : std_logic_vector((144*(C_WIDE_DATA+1))-1 downto 0);
  signal Out_Wr_BE                      : std_logic_vector((18*(C_WIDE_DATA+1))-1 downto 0);
  
  signal dvi_data                       : std_logic_vector(0 to 11);
  signal dvi_idck_p                     : std_logic;
  signal dvi_idck_m                     : std_logic;
  signal dvi_vsync                      : std_logic;
  signal dvi_hsync                      : std_logic;
  signal dvi_de                         : std_logic;
  signal pixel_clk                      : std_logic;
  signal pixel_clk90                    : std_logic;
  signal ZERO_four                      : std_logic_vector(3 downto 0)  := (others => '0');
  signal ZERO_thirtytwo                 : std_logic_vector(31 downto 0) := (others => '0');
  
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
    -- Instance of opb framebuffer
    ------------------------------------------
    gen_fb_shared: if C_SUPPORT_SHARED = 1 generate  
      opb_framebuffer_0 : entity opb_framebuffer_v2_00_a.opb_framebuffer
        generic map
        (
          C_WIDE_DATA     => C_WIDE_DATA     ,
          C_HALF_BURST    => C_HALF_BURST    ,
          C_BASEADDR      => X"00000000"     ,
          C_HIGHADDR      => X"0000FFFF"
          )
        port map
        (
          dvi_data        => dvi_data        ,
          dvi_idck_p      => dvi_idck_p      ,
          dvi_idck_m      => dvi_idck_m      ,
          dvi_vsync       => dvi_vsync       ,
          dvi_hsync       => dvi_hsync       ,
          dvi_de          => dvi_de          ,
          pixel_clk       => pixel_clk       ,
          pixel_clk90     => pixel_clk90     ,
          Mem_Cmd_Address => In1_Cmd_Address ,
          Mem_Cmd_RNW     => In1_Cmd_RNW     ,
          Mem_Cmd_Valid   => In1_Cmd_Valid   ,
          Mem_Cmd_Tag     => In1_Cmd_Tag     ,
          Mem_Cmd_Ack     => In1_Cmd_Ack     ,
          Mem_Rd_Dout     => In1_Rd_Dout     ,
          Mem_Rd_Tag      => In1_Rd_Tag      ,
          Mem_Rd_Ack      => In1_Rd_Ack      ,
          Mem_Rd_Valid    => In1_Rd_Valid    ,
          Mem_Wr_Din      => In1_Wr_Din      ,
          Mem_Wr_BE       => In1_Wr_BE       ,
          OPB_Clk         => PLB_Clk         ,
          OPB_Rst         => PLB_Rst         ,
          Sl_DBus         => open            ,
          Sl_errAck       => open            ,
          Sl_retry        => open            ,
          Sl_toutSup      => open            ,
          Sl_xferAck      => open            ,
          OPB_ABus        => ZERO_thirtytwo  ,
          OPB_BE          => ZERO_four       ,
          OPB_DBus        => ZERO_thirtytwo  ,
          OPB_RNW         => '0'             ,
          OPB_select      => '0'             ,
          OPB_seqAddr     => '0'
          );    
    end generate gen_fb_shared;
      
    ------------------------------------------
    -- Instance of multiport DDR2
    ------------------------------------------
    gen_multiport_shared: if C_SUPPORT_SHARED = 1 generate      
      multiport_ddr2_0 : entity multiport_ddr2_v2_00_a.multiport_ddr2
        generic map
        (
          C_WIDE_DATA    => C_WIDE_DATA      ,
          C_HALF_BURST   => C_HALF_BURST     ,
          C_BURST_WINDOW => C_BURST_WINDOW   ,
          C_BWIND_WIDTH  => C_BWIND_WIDTH
          )
        port map
        (
          Clk             => PLB_Clk         ,
          Rst             => PLB_Rst         ,
          In0_Cmd_Address => In0_Cmd_Address ,
          In0_Cmd_RNW     => In0_Cmd_RNW     ,
          In0_Cmd_Valid   => In0_Cmd_Valid   ,
          In0_Cmd_Tag     => In0_Cmd_Tag     ,
          In0_Cmd_Ack     => In0_Cmd_Ack     ,
          In0_Rd_Dout     => In0_Rd_Dout     ,
          In0_Rd_Tag      => In0_Rd_Tag      ,
          In0_Rd_Ack      => In0_Rd_Ack      ,
          In0_Rd_Valid    => In0_Rd_Valid    ,
          In0_Wr_Din      => In0_Wr_Din      ,
          In0_Wr_BE       => In0_Wr_BE       ,
          In1_Cmd_Address => In1_Cmd_Address ,
          In1_Cmd_RNW     => In1_Cmd_RNW     ,
          In1_Cmd_Valid   => In1_Cmd_Valid   ,
          In1_Cmd_Tag     => In1_Cmd_Tag     ,
          In1_Cmd_Ack     => In1_Cmd_Ack     ,
          In1_Rd_Dout     => In1_Rd_Dout     ,
          In1_Rd_Tag      => In1_Rd_Tag      ,
          In1_Rd_Ack      => In1_Rd_Ack      ,
          In1_Rd_Valid    => In1_Rd_Valid    ,
          In1_Wr_Din      => In1_Wr_Din      ,
          In1_Wr_BE       => In1_Wr_BE       ,
          Out_Cmd_Address => Out_Cmd_Address ,
          Out_Cmd_RNW     => Out_Cmd_RNW     ,
          Out_Cmd_Valid   => Out_Cmd_Valid   ,
          Out_Cmd_Tag     => Out_Cmd_Tag     ,
          Out_Cmd_Ack     => Out_Cmd_Ack     ,
          Out_Rd_Dout     => Out_Rd_Dout     ,
          Out_Rd_Tag      => Out_Rd_Tag      ,
          Out_Rd_Ack      => Out_Rd_Ack      ,
          Out_Rd_Valid    => Out_Rd_Valid    ,
          Out_Wr_Din      => Out_Wr_Din      ,
          Out_Wr_BE       => Out_Wr_BE
          );
    end generate gen_multiport_shared;

    ------------------------------------------
    -- Instance of Async DDR2
    ------------------------------------------
    gen_async_no_shared: if C_SUPPORT_SHARED = 0 generate
      async_ddr2_0 : entity async_ddr2_v2_00_a.async_ddr2
        generic map
        (
          C_WIDE_DATA     => C_WIDE_DATA      ,
          C_HALF_BURST    => C_HALF_BURST
          )
        port map
        (
          -- mem interface
          Mem_Clk          => PLB_Clk         ,
          Mem_Rst          => PLB_Rst         ,
          Mem_Cmd_Address  => In0_Cmd_Address , 
          Mem_Cmd_RNW      => In0_Cmd_RNW     ,
          Mem_Cmd_Valid    => In0_Cmd_Valid   ,
          Mem_Cmd_Tag      => In0_Cmd_Tag     ,
          Mem_Cmd_Ack      => In0_Cmd_Ack     ,
          Mem_Rd_Dout      => In0_Rd_Dout     ,
          Mem_Rd_Tag       => In0_Rd_Tag      ,
          Mem_Rd_Ack       => In0_Rd_Ack      ,
          Mem_Rd_Valid     => In0_Rd_Valid    ,
          Mem_Wr_Din       => In0_Wr_Din      ,
          Mem_Wr_BE        => In0_Wr_BE       ,
          
          -- ddr interface
          DDR_clk          => sys_clk_in      ,
          DDR_input_data   => DDR_input_data  ,
          DDR_byte_enable  => DDR_byte_enable ,
          DDR_get_data     => DDR_get_data    ,
          DDR_output_data  => DDR_output_data ,
          DDR_data_valid   => DDR_data_valid  ,
          DDR_address      => DDR_address     ,
          DDR_read         => DDR_read        ,
          DDR_write        => DDR_write       ,
          DDR_half_burst   => DDR_half_burst  ,
          DDR_ready        => DDR_ready       ,
          DDR_reset        => DDR_reset      
          );
    end generate gen_async_no_shared;
        
    gen_async_shared: if C_SUPPORT_SHARED = 1 generate
      async_ddr2_0 : entity async_ddr2_v2_00_a.async_ddr2
        generic map
        (
          C_WIDE_DATA     => C_WIDE_DATA      ,
          C_HALF_BURST    => C_HALF_BURST
          )
        port map
        (
          -- mem interface
          Mem_Clk          => PLB_Clk         ,
          Mem_Rst          => PLB_Rst         ,
          Mem_Cmd_Address  => Out_Cmd_Address , 
          Mem_Cmd_RNW      => Out_Cmd_RNW     ,
          Mem_Cmd_Valid    => Out_Cmd_Valid   ,
          Mem_Cmd_Tag      => Out_Cmd_Tag     ,
          Mem_Cmd_Ack      => Out_Cmd_Ack     ,
          Mem_Rd_Dout      => Out_Rd_Dout     ,
          Mem_Rd_Tag       => Out_Rd_Tag      ,
          Mem_Rd_Ack       => Out_Rd_Ack      ,
          Mem_Rd_Valid     => Out_Rd_Valid    ,
          Mem_Wr_Din       => Out_Wr_Din      ,
          Mem_Wr_BE        => Out_Wr_BE       ,
          
          -- ddr interface
          DDR_clk          => sys_clk_in      ,
          DDR_input_data   => DDR_input_data  ,
          DDR_byte_enable  => DDR_byte_enable ,
          DDR_get_data     => DDR_get_data    ,
          DDR_output_data  => DDR_output_data ,
          DDR_data_valid   => DDR_data_valid  ,
          DDR_address      => DDR_address     ,
          DDR_read         => DDR_read        ,
          DDR_write        => DDR_write       ,
          DDR_half_burst   => DDR_half_burst  ,
          DDR_ready        => DDR_ready       ,
          DDR_reset        => DDR_reset      
          );
    end generate gen_async_shared;
    
    ------------------------------------------
    -- Instance of DDR2 infrastructure
    ------------------------------------------
    sys_reset_in   <= PLB_Rst;
    sys_dcmlock_in <= '1';
        
    ddr2_infrastructure_0 : entity ddr2_infrastructure_v2_00_a.ddr2_infrastructure
      port map
      (
        reset_in               =>   sys_reset_in   ,
        clk_in                 =>   sys_clk_in     ,
        dcmlock_in             =>   sys_dcmlock_in ,
        ddr_inf_reset          =>   ddr_inf_reset  ,
        ddr_delay_sel          =>   ddr_delay_sel  ,
        ddr_clk                =>   ddr_clk        ,
        ddr_clk90              =>   ddr_clk90
        );

    ------------------------------------------
    -- Instance of DDR2 controller
    ------------------------------------------
    ddr2_controller_0 : entity ddr2_controller_v2_00_a.ddr2_controller
      generic map
      (
        bank_management        =>   C_BANK_MANAGEMENT
        )
      port map
      (
        -- user interface
        user_input_data        =>   DDR_input_data  ,
        user_byte_enable       =>   DDR_byte_enable ,
        user_get_data          =>   DDR_get_data    ,
        user_output_data       =>   DDR_output_data ,
        user_data_valid        =>   DDR_data_valid  ,
        user_address           =>   DDR_address     ,
        user_read              =>   DDR_read        ,
        user_write             =>   DDR_write       ,
        user_half_burst        =>   DDR_half_burst  ,
        user_ready             =>   DDR_ready       ,
        user_reset             =>   DDR_reset       ,

        -- system interface
        sys_clk                =>   ddr_clk         ,
        sys_clk90              =>   ddr_clk90       ,
        sys_delay_sel          =>   ddr_delay_sel   ,
        sys_inf_reset          =>   ddr_inf_reset
        );
        
  ------------------------------------------
  -- Instance of IP under test.
  -- Communication with the BFL is by using SYNCH_IN/SYNCH_OUT signals.
  ------------------------------------------
  UUT : entity plb_ddr2_v2_00_a.plb_ddr2
    generic map
    (   
      -- MAP USER GENERICS BELOW THIS LINE ---------------
      C_WIDE_DATA                    => C_WIDE_DATA,
      C_HALF_BURST                   => C_HALF_BURST,
      C_SUPPORT_SHARED               => C_SUPPORT_SHARED,
      -- MAP USER GENERICS ABOVE THIS LINE ---------------

      C_BASEADDR                     => C_BASEADDR,
      C_HIGHADDR                     => C_HIGHADDR,
      C_PLB_AWIDTH                   => C_PLB_AWIDTH,
      C_PLB_DWIDTH                   => C_PLB_DWIDTH,
      C_PLB_NUM_MASTERS              => C_PLB_NUM_MASTERS,
      C_PLB_MID_WIDTH                => C_PLB_MID_WIDTH,
      C_FAMILY                       => C_FAMILY
    )
    port map
    (
      -- MAP USER PORTS BELOW THIS LINE ------------------
      Mem_Cmd_Address                => In0_Cmd_Address,
      Mem_Cmd_RNW                    => In0_Cmd_RNW,
      Mem_Cmd_Valid                  => In0_Cmd_Valid,
      Mem_Cmd_Tag                    => In0_Cmd_Tag,
      Mem_Cmd_Ack                    => In0_Cmd_Ack,
      Mem_Rd_Dout                    => In0_Rd_Dout,
      Mem_Rd_Tag                     => In0_Rd_Tag,
      Mem_Rd_Ack                     => In0_Rd_Ack,
      Mem_Rd_Valid                   => In0_Rd_Valid,
      Mem_Wr_Din                     => In0_Wr_Din,
      Mem_Wr_BE                      => In0_Wr_BE,
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
    -- Test User I/Os and other features
    ------------------------------------------
    --USER code added here to stimulate any user I/Os

    wait;

  end process TEST_PROCESS;

end architecture testbench;
