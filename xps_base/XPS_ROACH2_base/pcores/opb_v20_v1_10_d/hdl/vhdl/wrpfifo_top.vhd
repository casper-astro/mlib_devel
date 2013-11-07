-------------------------------------------------------------------------------
-- $Id: wrpfifo_top.vhd,v 1.1.2.1 2009/10/06 21:15:02 gburch Exp $
-------------------------------------------------------------------------------
--wrpfifo_top.vhd
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
-- Filename:        wrpfifo_top.vhd
--
-- Description:     This file is the top level vhdl design for the Write Packet
--                  FIFO module.
--
-------------------------------------------------------------------------------
-- Structure:   This is the hierarchical structure of the WPFIFO design.
--
--              wrpfifo_top.vhd
--                     |
--                     |---> ipif_control_wr.vhd
--                     |
--                     |---> wrpfifo_dp_cntl.vhd
--                     |              |
--                     |              |-- pf_counter_top.vhd
--                     |              |        |
--                     |              |        |-- pf_counter.vhd
--                     |              |                 |
--                     |              |                 |-- pf_counter_bit.vhd
--                     |              |
--                     |              |
--                     |              |-- pf_occ_counter_top.vhd
--                     |              |        |
--                     |              |        |-- pf_occ_counter.vhd
--                     |              |                 |
--                     |              |                 |-- pf_counter_bit.vhd
--                     |              |
--                     |              |-- pf_adder.vhd
--                     |              |       |
--                     |              |       |-- pf_adder_bit.vhd
--                     |              |
--                     |              |
--                     |              |-- pf_dly1_mux.vhd
--                     |
--                     |---> pf_dpram.vhd
--                     |
--                     |
--                     |
--                     |
--                     |---> srl16_fifo.vhd
--                                 |
--                                 |-- pf_counter_top.vhd
--                                 |        |
--                                 |        |-- pf_counter.vhd
--                                 |                 |
--                                 |                 |-- pf_counter_bit.vhd
--                                 |
--                                 |
--                                 |-- pf_occ_counter_top.vhd
--                                 |        |
--                                 |        |-- pf_occ_counter.vhd
--                                 |                 |
--                                 |                 |-- pf_counter_bit.vhd
--                                 |
--                                 |-- pf_adder.vhd
--                                         |
--                                         |-- pf_adder_bit.vhd
--
--
-------------------------------------------------------------------------------
-- Author:      Doug Thorpe
--
-- History:
--  DET   March 23,2001      -- V0.00a
--
--  DET   Apr-24-01
--      - Change the dual port configuration name to wdport_512x32
--        from dport_512x32.
--
--  DET   May-04-01
--      - Hardcoded the MIR_ENABLE and Block_ID constant values
--        to simplify the point design compilation into the IPIF.
--        Commented out the rpfifo_lib declarations.
--
--  DET   MAY-24-01
--      - v0.00B  Incorporated the V0.00c dual port controller module
--
--  DET   June-25-01
--      - Changed the Dual Port core to 3.2 Version and added
--        the ENB nto the core to disable the read port when the
--        FIFO is Empty. This is an attempt to eliminate read
--        warnings during MTI simulation as well as undefined
--        outputs
--      - Changed to V1.00b of the IPIF write Control module.
--      - Changed to the V1.00d version of the DP control module.
--      - Added input Generics for MIR enable and Block ID
--
--
-- DET  July 20, 2001
--      - Changed the C_MIR_ENABLE type to Boolean from std_logic.
--      - Added additional parameters (generics)
--
-- DET  Oct. 02, 2001 (part of v1.02a version)
--      - added the optimization changes
--
--
--  DET  Oct. 8, 2001  (part of v1.02a version)
--      - Changes the C_VIRTEX_II input generic to C_FAMILY of type string
--      - Changed the DP core component and instance to new parameterized
--        version (pf_dpram_select.vhd)
--
--  DET  Oct. 13, 2001  (part of v1.02a version)
--      - Added the SRL FIFO option
--
--
--  DET  Oct 31, 2001
--      - Changed the input generic C_FAMILY of type string back to the
--        C_VIRTEX_II of type boolean. Changed caused by lack of string
--        support in the XST synthesis tool.
--
--  GAB         10/05/09
-- ^^^^^^
--  Moved all helper libraries proc_common_v2_00_a, opb_ipif_v3_01_a, and
--  opb_arbiter_v1_02_e locally into opb_v20_v1_10_d
--
--  Updated legal header
-- ~~~~~~
--
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
-- Library definitions

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library opb_v20_v1_10_d;
Use opb_v20_v1_10_d.pf_dpram_select;
Use opb_v20_v1_10_d.srl16_fifo;
Use opb_v20_v1_10_d.ipif_control_wr;
Use opb_v20_v1_10_d.wrpfifo_dp_cntl;

-------------------------------------------------------------------------------

entity wrpfifo_top is
  Generic (
      C_MIR_ENABLE          : Boolean := true;
            -- Enable for MIR synthesis (default for enable)

      C_BLOCK_ID            : integer range 0 to 255 := 255;
            -- Platform Generator assigned ID number

      C_FIFO_DEPTH_LOG2X    : Integer range 2 to 14 := 9;
           -- The number of needed address bits for the
                   -- required FIFO depth (= log2(fifo_depth)
           -- 9 = 512 wds deep, 8 = 256 wds deep, etc.

      C_FIFO_WIDTH          : Integer range 1 to 128 := 32;
           -- Width of FIFO data in bits

      C_INCLUDE_PACKET_MODE : Boolean := true;
           -- Select for inclusion/omission of packet mode
           -- features

      C_INCLUDE_VACANCY     : Boolean := true;
           -- Enable for Vacancy calc feature

      C_SUPPORT_BURST       : Boolean := true;
           -- Enable for IPIF Bus burst support

      C_IPIF_DBUS_WIDTH     : Integer range 8 to 128 := 32;
            -- Width of the IPIF data bus in bits

      C_VIRTEX_II           : boolean := true
           -- Selection of target FPGA technology
      );
  port(
    -- Inputs From the IPIF Bus
      Bus_rst               : In  std_logic;
      Bus_clk               : In  std_logic;
      Bus_RdReq             : In  std_logic;
      Bus_WrReq             : In  std_logic;
      Bus2FIFO_RdCE1        : In  std_logic;
      Bus2FIFO_RdCE2        : In  std_logic;
      Bus2FIFO_RdCE3        : In  std_logic;
      Bus2FIFO_WrCE1        : In  std_logic;
      Bus2FIFO_WrCE2        : In  std_logic;
      Bus2FIFO_WrCE3        : In  std_logic;
      Bus_DBus              : In  std_logic_vector(0 to C_IPIF_DBUS_WIDTH-1);

    -- Inputs from the IP
      IP2WFIFO_RdReq        : In std_logic;
      IP2WFIFO_RdMark       : In std_logic;
      IP2WFIFO_RdRestore    : In std_logic;
      IP2WFIFO_RdRelease    : In std_logic;

    -- Outputs to the IP
      WFIFO2IP_Data         : Out std_logic_vector(0 to C_FIFO_WIDTH-1);
      WFIFO2IP_RdAck        : Out std_logic;
      WFIFO2IP_AlmostEmpty  : Out std_logic;
      WFIFO2IP_Empty        : Out std_logic;
      WFIFO2IP_Occupancy    : Out std_logic_vector(0 to C_FIFO_DEPTH_LOG2X);

    -- Outputs to the IPIF DMA/SG function
      WFIFO2DMA_AlmostFull  : Out std_logic;
      WFIFO2DMA_Full        : Out std_logic;
      WFIFO2DMA_Vacancy     : Out std_logic_vector(0 to C_FIFO_DEPTH_LOG2X);

    -- Interrupt Output to IPIF Interrupt Register
      FIFO2IRPT_DeadLock    : Out std_logic;

    -- Outputs to the IPIF Bus
      FIFO2Bus_DBus         : Out std_logic_vector(0 to C_IPIF_DBUS_WIDTH-1);
      FIFO2Bus_WrAck        : Out std_logic;
      FIFO2Bus_RdAck        : Out std_logic;
      FIFO2Bus_Error        : Out std_logic;
      FIFO2Bus_Retry        : Out std_logic;
      FIFO2Bus_ToutSup      : Out std_logic
    );
  end wrpfifo_top ;

-------------------------------------------------------------------------------

architecture implementation of wrpfifo_top is



-- COMPONENTS


--TYPES

  -- no types



-- CONSTANTS


   ----------------------------------------------------------------------------
   -- IMPORTANT!!!!!!!!!!!!!!!!!!!
   -- Set MODULE Versioning Information Here!!!
   --
   -- The following three constants indicate the versioning read via the MIR
   ----------------------------------------------------------------------------
   constant VERSION_MAJOR :  integer range 0 to 9 := 1;
                -- Major versioning the WrPFIFO design
                -- (0 = engineering release,
                -- 1 = major release 1, etc.)

   constant VERSION_MINOR :  integer range 0 to 99:= 1;
                -- Minor Version of the WrPFIFO design

   constant VERSION_REV   :  integer range 0 to 25:= 1;
                -- Revision letter of the WrPFIFO design
                -- (0 = a, 1 = b, 2 = c, etc)


   ----------------------------------------------------------------------------
   -- Set IPIF Block Protocol Type Here!!!!
   --
   -- IPIF block protocol Type  (Read Packet FIFO = 2, Write PFIFO = 3)
   ----------------------------------------------------------------------------
   Constant PFIFO_INTFC_TYPE :  integer range 0 to 31 := 3;


   ----------------------------------------------------------------------------
   -- General Use Constants
   ----------------------------------------------------------------------------
   Constant LOGIC_LOW    : std_logic := '0';
   Constant LOGIC_HIGH   : std_logic := '1';



--INTERNAL SIGNALS

  -- Dual Port interconnect
   signal   sig_mem_wrreq:         std_logic;
   signal   sig_mem_wr_enable:     std_logic;
   signal   sig_mem_wr_data:       std_logic_vector(0 to C_FIFO_WIDTH-1);
   signal   sig_mem_wr_addr:       std_logic_vector(0 to C_FIFO_DEPTH_LOG2X-1);
   signal   sig_mem_rd_addr:       std_logic_vector(0 to C_FIFO_DEPTH_LOG2X-1);
   signal   sig_mem_rd_data:       std_logic_vector(0 to C_FIFO_WIDTH-1);
   Signal   sig_fifo_wrack:        std_logic;


   Signal   sig_fifo_rdack:        std_logic;
   signal   sig_fifo_full:         std_logic;
   signal   sig_fifo_empty:        std_logic;
   signal   sig_fifo_almost_full:  std_logic;
   signal   sig_fifo_almost_empty: std_logic;
   signal   sig_fifo_occupancy:    std_logic_vector(0 to C_FIFO_DEPTH_LOG2X);
   signal   sig_fifo_vacancy:      std_logic_vector(0 to C_FIFO_DEPTH_LOG2X);
   Signal   sig_burst_wr_xfer:     std_logic;
   Signal   sig_fifo_logic_reset:  std_logic;
   signal   sig_fifo_deadlock :    std_logic;
   Signal   sig_mem_rdreq :        std_logic;
   signal   sig_mem_rd_enable :    std_logic;


-------------------------------------------------------------------------------
------------------------------- start processes -------------------------------

  begin


-- connect I/O signals to internals
 WFIFO2IP_RdAck         <=  sig_fifo_rdack;
 WFIFO2IP_Empty         <=  sig_fifo_empty;
 WFIFO2IP_AlmostEmpty   <=  sig_fifo_almost_empty;
 WFIFO2IP_Occupancy     <=  sig_fifo_occupancy;
 WFIFO2DMA_AlmostFull   <=  sig_fifo_almost_full;
 WFIFO2DMA_Full         <=  sig_fifo_full ;
 WFIFO2DMA_Vacancy      <=  sig_fifo_vacancy;


-- Some Dual Port signal assignments (vhdl wrapper)
 --sig_mem_wr_enable       <=  not(sig_fifo_full);
 sig_mem_rdreq           <=  IP2WFIFO_RdReq;
 WFIFO2IP_Data          <=  sig_mem_rd_data;


I_IPIF_INTERFACE_BLOCK : entity opb_v20_v1_10_d.ipif_control_wr
  Generic map (
     C_MIR_ENABLE        =>  C_MIR_ENABLE   ,
     C_BLOCK_ID          =>  C_BLOCK_ID     ,
     C_INTFC_TYPE        =>  PFIFO_INTFC_TYPE,
     C_VERSION_MAJOR     =>  VERSION_MAJOR,
     C_VERSION_MINOR     =>  VERSION_MINOR,
     C_VERSION_REV       =>  VERSION_REV,
     C_FIFO_WIDTH        =>  C_FIFO_WIDTH,
     C_DP_ADDRESS_WIDTH  =>  C_FIFO_DEPTH_LOG2X,
     C_SUPPORT_BURST     =>  C_SUPPORT_BURST,
     C_IPIF_DBUS_WIDTH   =>  C_IPIF_DBUS_WIDTH
    )
  port map (

  -- Inputs From the IPIF Bus
    Bus_rst             =>  Bus_rst       ,
    Bus_clk             =>  Bus_clk       ,
    Bus_RdReq           =>  Bus_RdReq     ,
    Bus_WrReq           =>  Bus_WrReq     ,
    Bus2FIFO_RdCE1      =>  Bus2FIFO_RdCE1,
    Bus2FIFO_RdCE2      =>  Bus2FIFO_RdCE2,
    Bus2FIFO_RdCE3      =>  Bus2FIFO_RdCE3,
    Bus2FIFO_WrCE1      =>  Bus2FIFO_WrCE1,
    Bus2FIFO_WrCE2      =>  Bus2FIFO_WrCE2,
    Bus2FIFO_WrCE3      =>  Bus2FIFO_WrCE3,
    Bus_DBus            =>  Bus_DBus      ,

  -- Inputs from the FIFO Interface Logic
    Fifo_WrAck          =>  sig_fifo_wrack,
    Vacancy             =>  sig_fifo_vacancy,
    AlmostFull          =>  sig_fifo_almost_full,
    Full                =>  sig_fifo_full,

    Deadlock            =>  sig_fifo_deadlock,

  -- Outputs to the FIFO
    Fifo_wr_data        =>  sig_mem_wr_data,
    Fifo_Reset          =>  sig_fifo_logic_reset,
    Fifo_WrReq          =>  sig_mem_wrreq,
    Fifo_burst_wr_xfer  =>  sig_burst_wr_xfer,

  -- Outputs to the IPIF Bus
    FIFO2IRPT_DeadLock  =>  FIFO2IRPT_DeadLock ,
    FIFO2Bus_DBus       =>  FIFO2Bus_DBus      ,
    FIFO2Bus_WrAck      =>  FIFO2Bus_WrAck     ,
    FIFO2Bus_RdAck      =>  FIFO2Bus_RdAck     ,
    FIFO2Bus_Error      =>  FIFO2Bus_Error     ,
    FIFO2Bus_Retry      =>  FIFO2Bus_Retry     ,
    FIFO2Bus_ToutSup    =>  FIFO2Bus_ToutSup
    );






   USE_BLOCK_RAM : if (C_FIFO_DEPTH_LOG2X > 4 or
                       C_INCLUDE_PACKET_MODE = true) generate

   begin


-- Connect the Dual Port Address Controller the VHDL wrapper
I_DP_CONTROLLER: entity opb_v20_v1_10_d.wrpfifo_dp_cntl
  Generic map (
    C_DP_ADDRESS_WIDTH    =>  C_FIFO_DEPTH_LOG2X,
    C_INCLUDE_PACKET_MODE =>  C_INCLUDE_PACKET_MODE,
    C_INCLUDE_VACANCY     =>  C_INCLUDE_VACANCY
    )
  port map(

  -- Inputs
    Bus_rst       =>   sig_fifo_logic_reset,
    Bus_clk       =>   Bus_clk,
    Rdreq         =>   sig_mem_rdreq,
    Wrreq         =>   sig_mem_wrreq,
    Burst_wr_xfer =>   sig_burst_wr_xfer,
    Mark          =>   IP2WFIFO_RdMark,
    Restore       =>   IP2WFIFO_RdRestore,
    Release       =>   IP2WFIFO_RdRelease,

  -- Outputs
    WrAck         =>   sig_fifo_wrack,
    RdAck         =>   sig_fifo_rdack,
    Full          =>   sig_fifo_full,
    Empty         =>   sig_fifo_empty,
    Almost_Full   =>   sig_fifo_almost_full,
    Almost_Empty  =>   sig_fifo_almost_empty,
    DeadLock      =>   sig_fifo_deadlock,
    Occupancy     =>   sig_fifo_occupancy,
    Vacancy       =>   sig_fifo_vacancy,
    DP_core_wren  =>   sig_mem_wr_enable,
    Wr_Addr       =>   sig_mem_wr_addr,
    DP_core_rden  =>   sig_mem_rd_enable,
    Rd_Addr       =>   sig_mem_rd_addr
    );




 -- Dual Port Core connection
 I_DP_CORE : entity opb_v20_v1_10_d.pf_dpram_select
   generic map(
     C_DP_DATA_WIDTH     =>  C_FIFO_WIDTH,
     C_DP_ADDRESS_WIDTH  =>  C_FIFO_DEPTH_LOG2X,
     C_VIRTEX_II         =>  C_VIRTEX_II
     )
   port map(

     -- Write Port signals
     Wr_rst      =>  sig_fifo_logic_reset,
     Wr_Clk      =>  Bus_Clk,
     Wr_Enable   =>  sig_mem_wr_enable,
     Wr_Req      =>  sig_mem_wrreq,
     Wr_Address  =>  sig_mem_wr_addr,
     Wr_Data     =>  sig_mem_wr_data,

     -- Read Port Signals
     Rd_rst      =>  sig_fifo_logic_reset,
     Rd_Clk      =>  Bus_Clk,
     Rd_Enable   =>  sig_mem_rd_enable,
     Rd_Address  =>  sig_mem_rd_addr,
     Rd_Data     =>  sig_mem_rd_data
     );

   end generate USE_BLOCK_RAM;





   USE_SRL_CORE : if (C_FIFO_DEPTH_LOG2X <= 4 and
                      C_INCLUDE_PACKET_MODE = False) generate




     begin

       sig_fifo_deadlock <= '0';
       sig_fifo_rdack    <=  sig_mem_rdreq and not(sig_fifo_empty);
       sig_fifo_wrack    <=  sig_mem_wrreq and not(sig_fifo_full);


       I_SRL_MEM : entity opb_v20_v1_10_d.srl16_fifo
          generic map (
            C_FIFO_WIDTH       =>  C_FIFO_WIDTH,
            C_FIFO_DEPTH_LOG2X =>  C_FIFO_DEPTH_LOG2X,
            C_INCLUDE_VACANCY  =>  C_INCLUDE_VACANCY
            )
          port map (
            Bus_clk     =>   Bus_Clk,
            Bus_rst     =>   sig_fifo_logic_reset,
            Wr_Req      =>   sig_mem_wrreq,
            Wr_Data     =>   sig_mem_wr_data,
            Rd_Req      =>   sig_mem_rdreq,
            Rd_Data     =>   sig_mem_rd_data,
            Full        =>   sig_fifo_full,
            Almostfull  =>   sig_fifo_almost_full,
            Empty       =>   sig_fifo_empty,
            Almostempty =>   sig_fifo_almost_empty,
            Occupancy   =>   sig_fifo_occupancy,
            Vacancy     =>   sig_fifo_vacancy
            );


     end generate USE_SRL_CORE;





  end implementation;







