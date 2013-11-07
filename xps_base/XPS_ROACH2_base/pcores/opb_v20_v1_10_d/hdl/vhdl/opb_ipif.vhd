-- $Id: opb_ipif.vhd,v 1.1.2.1 2009/10/06 21:15:01 gburch Exp $
-------------------------------------------------------------------------------
-- opb_ipif.vhd
-------------------------------------------------------------------------------
--
-- *************************************************************************
-- **                                                                     **
-- ** DISCLAIMER OF LIABILITY                                             **
-- **                                                                     **
-- ** This text/file contains proprietary, confidential                   **
-- ** information of Xilinx, Inc., is distributed under                   **
-- ** license from Xilinx, Inc., and may be used, copied                  **
-- ** and/or disclosed only pursuant to the terms of a valid              **
-- ** license agreement with Xilinx, Inc. Xilinx hereby                   **
-- ** grants you a license to use this text/file solely for               **
-- ** design, simulation, implementation and creation of                  **
-- ** design files limited to Xilinx devices or technologies.             **
-- ** Use with non-Xilinx devices or technologies is expressly            **
-- ** prohibited and immediately terminates your license unless           **
-- ** covered by a separate agreement.                                    **
-- **                                                                     **
-- ** Xilinx is providing this design, code, or information               **
-- ** "as-is" solely for use in developing programs and                   **
-- ** solutions for Xilinx devices, with no obligation on the             **
-- ** part of Xilinx to provide support. By providing this design,        **
-- ** code, or information as one possible implementation of              **
-- ** this feature, application or standard, Xilinx is making no          **
-- ** representation that this implementation is free from any            **
-- ** claims of infringement. You are responsible for obtaining           **
-- ** any rights you may require for your implementation.                 **
-- ** Xilinx expressly disclaims any warranty whatsoever with             **
-- ** respect to the adequacy of the implementation, including            **
-- ** but not limited to any warranties or representations that this      **
-- ** implementation is free from claims of infringement, implied         **
-- ** warranties of merchantability or fitness for a particular           **
-- ** purpose.                                                            **
-- **                                                                     **
-- ** Xilinx products are not intended for use in life support            **
-- ** appliances, devices, or systems. Use in such applications is        **
-- ** expressly prohibited.                                               **
-- **                                                                     **
-- ** Any modifications that are made to the Source Code are              **
-- ** done at the user’s sole risk and will be unsupported.               **
-- ** The Xilinx Support Hotline does not have access to source           **
-- ** code and therefore cannot answer specific questions related         **
-- ** to source HDL. The Xilinx Hotline support of original source        **
-- ** code IP shall only address issues and questions related             **
-- ** to the standard Netlist version of the core (and thus               **
-- ** indirectly, the original core source).                              **
-- **                                                                     **
-- ** Copyright (c) 2003,2009 Xilinx, Inc. All rights reserved.           **
-- **                                                                     **
-- ** This copyright and support notice must be retained as part          **
-- ** of this text at all times.                                          **
-- **                                                                     **
-- *************************************************************************
--
-------------------------------------------------------------------------------
-- Filename:        opb_ipif.vhd
-- Version:         v3.01a
-- Description:     Slave OPB IPIF with the following services:
--                      MIR/Reset register
--                      Interrupts
--                      Read and Write Packet FIFOs
--
-------------------------------------------------------------------------------
-- Structure:       opb_ipif
--                      -- opb_bam
--                          -- reset_mir
--                          -- interrupt_control
--                          -- rdpfifo_top
--                          -- wrpfifo_top
--                          -- opb_be_gen
--                          -- write_buffer
--                              -- srl_fifo3
--                          -- brst_addr_cntr
--                          -- brst_addr_cntr_reg
--                              -- opb_flex_addr_cntr
--
-------------------------------------------------------------------------------
-- BEGIN_CHANGELOG EDK_Gmm_SP1
--
--  Version 3.01.a is an update to use new common libraries and
--  incorporates write buffer logic and address counter logic.
--  This version also fixes various functionality issues.
--
--  Fixed various issues with IPIC signals when Write Buffer services
--  were used.  Also, fixed issues with dynamic switching of IP2Bus_PostedWrInh
--
-- END_CHANGELOG
-------------------------------------------------------------------------------
-- BEGIN_CHANGELOG EDK_Gmm_SP2
--
--  Fixed IP2RFIFO_Data and WFIFO2IP_Data size to be based on C_ARD_DWIDTH_ARRAY
--  generic instead of being hard coded to a size of 32 bits.
--
-- END_CHANGELOG
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- BEGIN_CHANGELOG EDK_I_SP1
--
--  Removed a long combinatorial path on Sln_xferAck to help improve Fmax
--  timing.
--
--  Removed a long combinatorial path on Sln_Retry to help improve Fmax
--  timing.
--
--  Broke up a long timing path through the address decode stage to help
--  improve Fmax timing.
--
--  Fixed issue with IP2Bus_Postedwrinh_s2 negating incorrectly which would
--  in certain cases cause a write cycle to no be acknowledged.
--
-- END_CHANGELOG
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- BEGIN_CHANGELOG EDK_Im_SP1
--
--      Removed some unused signals and added a missing signal to a sensitiviy
--      list for minor code clean up.
--
-- END_CHANGELOG
-------------------------------------------------------------------------------
-- Author:      Farrell Ostler
--
-- History:
--
--      FLO     05/19/03
-- ^^^^^^
--      Initial version.
-- ~~~~~~
--
--      ALS     10/21/03
-- ^^^^^^
--  Creation of version v3_00_b to include read and write packet FIFOs.
--  Also modified code for direct entity instantiation.
-- ~~~~~~
--      ALS     11/18/03
-- ^^^^^^
--  Creation of version v3_01_a to modify generics and some ports to align
--  with the PLB IPIF. Added look-ahead address counter for read bursts and write
--  buffer for write bursts.
-- ~~~~~~~
--
--      ALS         04/09/04
-- ^^^^^^
--  Removed vectorization of IP2Bus signals
-- ~~~~~~~
--      GAB         04/15/04
-- ^^^^^^
--  Updated to use proc_common_v2_00_a
--  Added change log
-- ~~~~~~~
--      GAB         08/10/04
-- ^^^^^^
--  - Modified port range for IP2RFIFO_Data and WFIFO2IP_Data to be based on
--  the C_ARD_DWIDTH_ARRAY generic and not hard coded.  Fixes CR191551
-- ~~~~~~~
--      GAB         07/06/05
-- ^^^^^^
--  Removed xfer_abort signal from Sln_xferack logic to help improve timing.
-- ~~~~~~~
--      GAB         08/05/05
-- ^^^^^^
--  Fixed issue with IP2Bus_Postedwrinh_s2 getting reset with OPB_Select would
--  negate. IP2Bus_Postedwrinh_s2 should only negat based on UserIP.
-- ~~~~~~~
--      GAB         09/21/05
-- ^^^^^^
--  Fixed long timing path issue with Sln_Retry signal and cycle aborts.  Modified
--  logic to suppress sln_xferack_s1 with cycle_abort for models where out-pipe was
--  included.
-- ~~~~~~~
--      GAB         10/12/05
-- ^^^^^^
--  Incorperated rev C mods into rev A to fix slow timing path with the address
--  decode.  The modification simply shifts the input pipe stage for the address
--  to after the address decode.  Therefore the functionality does not change
--  nor does the latency.  This fix only improves pipeline 5 and 7 (i.e. any
--  with a model with a input pipeline stage).
-- ~~~~~~~
--      GAB      5/19/06
-- ^^^^^^
--      Removed unused last_wr_xferack, last_wr_xferack_d1,
--      and last_wr_xferack_d2 from opb_bam.vhd
--      Added bus2ip_rnw_s1 signal to SLN_XFERACK_PROC process's sinsitivity list
--      in opb_bam.vhd
--      This fixes CR231744.
-- ~~~~~~~
--  GAB         10/05/09
-- ^^^^^^
--  Moved all helper libraries proc_common_v2_00_a, opb_ipif_v3_01_a, and
--  opb_arbiter_v1_02_e locally into opb_v20_v1_10_d
--
--  Updated legal header
-- ~~~~~~
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
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


library opb_v20_v1_10_d;
use opb_v20_v1_10_d.opb_bam;
use opb_v20_v1_10_d.ipif_pkg.all;
use opb_v20_v1_10_d.proc_common_pkg.all;

-----------------------------------------------------------------------------
-- Entity section
-----------------------------------------------------------------------------

entity opb_ipif is
  generic
  (
    C_ARD_ID_ARRAY              : INTEGER_ARRAY_TYPE
                                    :=( 0 => IPIF_INTR,
                                        1 => IPIF_RST,
                                        2 => USER_00 );

    C_ARD_ADDR_RANGE_ARRAY      : SLV64_ARRAY_TYPE
                                    :=( x"0000_0000_6000_0000",
                                        x"0000_0000_6000_003F",
                                        x"0000_0000_6000_0040",
                                        x"0000_0000_6000_0043",
                                        x"0000_0000_6000_0100",
                                        x"0000_0000_6000_01FF" );

    C_ARD_DWIDTH_ARRAY          : INTEGER_ARRAY_TYPE
                                    :=( 32,
                                        32,
                                        32 );

    C_ARD_NUM_CE_ARRAY          : INTEGER_ARRAY_TYPE
                                    :=( 16,
                                        1,
                                        8 );

    C_ARD_DEPENDENT_PROPS_ARRAY : DEPENDENT_PROPS_ARRAY_TYPE
                                    :=( 0 => (others => 0),
                                        1 => (others => 0),
                                        2 => (others => 0) );

    C_PIPELINE_MODEL            : integer   := 7;

    C_DEV_BLK_ID                : integer   := 1;

    C_DEV_MIR_ENABLE            : integer   := 0;

    C_OPB_AWIDTH                : integer   := 32;

    C_OPB_DWIDTH                : integer   := 32;

    C_FAMILY                    : string
                                    := "virtexe";

    C_IP_INTR_MODE_ARRAY        : INTEGER_ARRAY_TYPE
                                    :=( 5,
                                        1 );

    C_DEV_BURST_ENABLE          : integer   := 0;

    C_INCLUDE_ADDR_CNTR         : integer   := 0;

    C_INCLUDE_WR_BUF            : integer   := 0
  );
  port
  (
    -- OPB signals
    OPB_select         : in  std_logic;
    OPB_DBus           : in  std_logic_vector(0 to C_OPB_DWIDTH-1);
    OPB_ABus           : in  std_logic_vector(0 to C_OPB_AWIDTH-1);
    OPB_BE             : in  std_logic_vector(0 to C_OPB_DWIDTH/8-1);
    OPB_RNW            : in  std_logic;
    OPB_seqAddr        : in  std_logic;
    Sln_DBus           : out std_logic_vector(0 to C_OPB_DWIDTH-1);
    Sln_xferAck        : out std_logic;
    Sln_errAck         : out std_logic;
    Sln_retry          : out std_logic;
    Sln_toutSup        : out std_logic;

    -- IPIC signals (address, data, acknowledge)
    Bus2IP_CS          : out std_logic_vector(0 to C_ARD_ID_ARRAY'length-1);
    Bus2IP_CE          : out std_logic_vector(0 to calc_num_ce(C_ARD_NUM_CE_ARRAY)-1);
    Bus2IP_RdCE        : out std_logic_vector(0 to calc_num_ce(C_ARD_NUM_CE_ARRAY)-1);
    Bus2IP_WrCE        : out std_logic_vector(0 to calc_num_ce(C_ARD_NUM_CE_ARRAY)-1);
    Bus2IP_Data        : out std_logic_vector(0 to C_OPB_DWIDTH-1);
    Bus2IP_Addr        : out std_logic_vector(0 to C_OPB_AWIDTH-1);
    Bus2IP_AddrValid   : out std_logic;
    Bus2IP_BE          : out std_logic_vector(0 to C_OPB_DWIDTH/8-1);
    Bus2IP_RNW         : out std_logic;
    Bus2IP_Burst       : out std_logic;
    IP2Bus_Data        : in  std_logic_vector(0 to C_OPB_DWIDTH-1);
    IP2Bus_Ack         : in  std_logic;
    IP2Bus_AddrAck     : in  std_logic;
    IP2Bus_Error       : in  std_logic;
    IP2Bus_Retry       : in  std_logic;
    IP2Bus_ToutSup     : in  std_logic;
    IP2Bus_PostedWrInh : in  std_logic_vector(0 to C_ARD_ID_ARRAY'length-1);

    -- IPIC signals (Read Packet FIFO)
    IP2RFIFO_Data       : in std_logic_vector(0 to C_ARD_DWIDTH_ARRAY(
                                get_id_index_iboe(C_ARD_ID_ARRAY,
                                IPIF_RDFIFO_DATA)) - 1) := (others => '0');
    IP2RFIFO_WrMark     : in std_logic := '0';
    IP2RFIFO_WrRelease  : in std_logic := '0';
    IP2RFIFO_WrReq      : in std_logic := '0';
    IP2RFIFO_WrRestore  : in std_logic := '0';
    RFIFO2IP_AlmostFull : out std_logic;
    RFIFO2IP_Full       : out std_logic;
    RFIFO2IP_Vacancy    : out std_logic_vector(0 to bits_needed_for_vac(
                                find_ard_id(C_ARD_ID_ARRAY, IPIF_RDFIFO_DATA),
                                C_ARD_DEPENDENT_PROPS_ARRAY(get_id_index_iboe
                                (C_ARD_ID_ARRAY, IPIF_RDFIFO_DATA))) - 1);

    RFIFO2IP_WrAck      : out std_logic;

    -- IPIC signals (Write Packet FIFO)
    IP2WFIFO_RdMark     : in std_logic := '0';
    IP2WFIFO_RdRelease  : in std_logic := '0';
    IP2WFIFO_RdReq      : in std_logic := '0';
    IP2WFIFO_RdRestore  : in std_logic := '0';
    WFIFO2IP_AlmostEmpty: out std_logic;
    WFIFO2IP_Data       : out std_logic_vector(0 to C_ARD_DWIDTH_ARRAY(
                                get_id_index_iboe(C_ARD_ID_ARRAY,
                                IPIF_WRFIFO_DATA)) - 1);
    WFIFO2IP_Empty      : out std_logic;
    WFIFO2IP_Occupancy  : out std_logic_vector(0 to bits_needed_for_occ(
                                find_ard_id(C_ARD_ID_ARRAY, IPIF_WRFIFO_DATA),
                                C_ARD_DEPENDENT_PROPS_ARRAY(get_id_index_iboe
                                (C_ARD_ID_ARRAY, IPIF_WRFIFO_DATA))) - 1);

    WFIFO2IP_RdAck      : out std_logic;

    -- interrupts
    IP2Bus_IntrEvent    : in  std_logic_vector(0 to C_IP_INTR_MODE_ARRAY'length-1);
    IP2INTC_Irpt        : out std_logic;

    -- Software test breakpoint signal
    Freeze              : in  std_logic;
    Bus2IP_Freeze       : out std_logic;

    -- clocks and reset
    OPB_Clk             : in  std_logic;
    Bus2IP_Clk          : out std_logic;
    IP2Bus_Clk          : in  std_logic;
    Reset               : in  std_logic;
    Bus2IP_Reset        : out std_logic
  );

end entity opb_ipif;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------
architecture imp of opb_ipif is

begin  ------------------------------------------------------------------------

  OPB_BAM_I : entity opb_v20_v1_10_d.opb_bam
    generic map
    (
      C_ARD_ID_ARRAY              => C_ARD_ID_ARRAY,
      C_ARD_ADDR_RANGE_ARRAY      => C_ARD_ADDR_RANGE_ARRAY,
      C_ARD_DWIDTH_ARRAY          => C_ARD_DWIDTH_ARRAY,
      C_ARD_NUM_CE_ARRAY          => C_ARD_NUM_CE_ARRAY,
      C_ARD_DEPENDENT_PROPS_ARRAY => C_ARD_DEPENDENT_PROPS_ARRAY,
      C_PIPELINE_MODEL            => C_PIPELINE_MODEL,
      C_DEV_BLK_ID                => C_DEV_BLK_ID,
      C_DEV_MIR_ENABLE            => C_DEV_MIR_ENABLE,
      C_OPB_AWIDTH                => C_OPB_AWIDTH,
      C_OPB_DWIDTH                => C_OPB_DWIDTH,
      C_FAMILY                    => C_FAMILY,
      C_IP_INTR_MODE_ARRAY        => C_IP_INTR_MODE_ARRAY,
      C_DEV_BURST_ENABLE          => C_DEV_BURST_ENABLE,
      -- set this just for initial testing
      C_INCLUDE_ADDR_CNTR         => C_INCLUDE_ADDR_CNTR,
      C_INCLUDE_WR_BUF            => C_INCLUDE_WR_BUF
    )
    port map
    (
      OPB_select           => OPB_select,
      OPB_DBus             => OPB_DBus,
      OPB_ABus             => OPB_ABus,
      OPB_BE               => OPB_BE,
      OPB_RNW              => OPB_RNW,
      OPB_seqAddr          => OPB_seqAddr,
      Sln_DBus             => Sln_DBus,
      Sln_xferAck          => Sln_xferAck,
      Sln_errAck           => Sln_errAck,
      Sln_retry            => Sln_retry,
      Sln_toutSup          => Sln_toutSup,
      Bus2IP_CS            => Bus2IP_CS,
      Bus2IP_CE            => Bus2IP_CE,
      Bus2IP_RdCE          => Bus2IP_RdCE,
      Bus2IP_WrCE          => Bus2IP_WrCE,
      Bus2IP_Data          => Bus2IP_Data,
      Bus2IP_Addr          => Bus2IP_Addr,
      Bus2IP_AddrValid     => Bus2IP_AddrValid,
      Bus2IP_BE            => Bus2IP_BE,
      Bus2IP_RNW           => Bus2IP_RNW,
      Bus2IP_Burst         => Bus2IP_Burst,
      IP2Bus_Data          => IP2Bus_Data,
      IP2Bus_Ack           => IP2Bus_Ack,
      IP2Bus_AddrAck       => IP2Bus_AddrAck,
      IP2Bus_Error         => IP2Bus_Error,
      IP2Bus_Retry         => IP2Bus_Retry,
      IP2Bus_ToutSup       => IP2Bus_ToutSup,
      IP2Bus_PostedWrInh   => IP2Bus_PostedWrInh,
      IP2RFIFO_Data        => IP2RFIFO_Data,
      IP2RFIFO_WrMark      => IP2RFIFO_WrMark,
      IP2RFIFO_WrRelease   => IP2RFIFO_WrRelease,
      IP2RFIFO_WrReq       => IP2RFIFO_WrReq,
      IP2RFIFO_WrRestore   => IP2RFIFO_WrRestore,
      RFIFO2IP_AlmostFull  => RFIFO2IP_AlmostFull,
      RFIFO2IP_Full        => RFIFO2IP_Full,
      RFIFO2IP_Vacancy     => RFIFO2IP_Vacancy,
      RFIFO2IP_WrAck       => RFIFO2IP_WrAck,
      IP2WFIFO_RdMark      => IP2WFIFO_RdMark,
      IP2WFIFO_RdRelease   => IP2WFIFO_RdRelease,
      IP2WFIFO_RdReq       => IP2WFIFO_RdReq,
      IP2WFIFO_RdRestore   => IP2WFIFO_RdRestore,
      WFIFO2IP_AlmostEmpty => WFIFO2IP_AlmostEmpty,
      WFIFO2IP_Data        => WFIFO2IP_Data,
      WFIFO2IP_Empty       => WFIFO2IP_Empty,
      WFIFO2IP_Occupancy   => WFIFO2IP_Occupancy,
      WFIFO2IP_RdAck       => WFIFO2IP_RdAck,
      IP2Bus_IntrEvent     => IP2Bus_IntrEvent,
      IP2INTC_Irpt         => IP2INTC_Irpt,
      Freeze               => Freeze,
      Bus2IP_Freeze        => Bus2IP_Freeze,
      OPB_Clk              => OPB_Clk,
      Bus2IP_Clk           => Bus2IP_Clk,
      IP2Bus_Clk           => IP2Bus_Clk,
      Reset                => Reset,
      Bus2IP_Reset         => Bus2IP_Reset
    );

end architecture imp;

