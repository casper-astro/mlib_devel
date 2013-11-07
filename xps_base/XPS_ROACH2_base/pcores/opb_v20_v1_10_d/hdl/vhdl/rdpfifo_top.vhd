-------------------------------------------------------------------------------
-- $Id: rdpfifo_top.vhd,v 1.1.2.1 2009/10/06 21:15:02 gburch Exp $
-------------------------------------------------------------------------------
--rdpfifo_top.vhd
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
-- Filename:        rdpfifo_top.vhd
--
-- Description:     This file is the top level vhdl design for the Read Packet
--                  FIFO module.
--
-------------------------------------------------------------------------------
-- Structure:   This is the hierarchical structure of the RPFIFO design.
--
--              rdpfifo_top.vhd
--                     |
--                     |---> ipif_control_rd.vhd
--                     |
--                     |---> rdpfifo_dp_cntl.vhd
--                     |          |
--                     |          |
--                     |          |-- pf_counter_top.vhd
--                     |          |        |
--                     |          |        |-- pf_counter.vhd
--                     |          |                 |
--                     |          |                 |-- pf_counter_bit.vhd
--                     |          |
--                     |          |
--                     |          |-- pf_occ_counter_top.vhd
--                     |          |        |
--                     |          |        |-- pf_occ_counter.vhd
--                     |          |                 |
--                     |          |                 |-- pf_counter_bit.vhd
--                     |          |
--                     |          |-- pf_adder.vhd
--                     |                  |
--                     |                  |-- pf_adder_bit.vhd
--                     |
--                     |---> pf_dpram_select.vhd
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
--  DET   APR-24-01
--      - Changed dual port configuration name to
--        rdport_512x32 from dport_512x32.
--
--
--  DET   May-04-01
--      - Hardcoded the MIR_ENABLE and Block_ID constant values
--        to simplify the point design compilation into the IPIF.
--      - Commented out the rpfifo_lib declarations.
--
--  DET   June-11-01   V1.00b
--      - Modified the IPIF Interface callout for the version b.
--
--  DET   June-23-01   V1.00b
--      - Changed the Dual Port core to 3.2 Version and added
--        the ENB nto the core to disable the read port when the
--        FIFO is Empty. This is an attempt to eliminate read
--        warnings during MTI simulation as well as undefined
--        outputs
--
--  DET   June-25-01  V1.00b
--      - Upadated the IPIF read control module to version c as part of the
--        removal of redundant logic warnings from Synplicity synthesis.
--      - Updated the Dual Port control module to version d as part of the
--        removal of redundant logic warnings from Synplicity synthesis.
--
--
-- DET  July 20, 2001
--      - Changed the C_MIR_ENABLE type to Boolean from std_logic.
--
--
-- DET  Aug 19, 2001   v1.01a
--      - Platform Generator compilancy modifications
--      - Added generic to select Virtex E or Virtex II DP core
--      - Imbedded configurations for DP simulation in the design
--        body.
--
--
--  DET  Sept. 26, 2001 (part of v1.02a version)
--      - Added the optimization changes
--      - Added additional parameters (generics)
--
--
--  DET  Oct. 7, 2001  (part of v1.02a version)
--      - Changes the C_VIRTEX_II input generic to C_FAMILY of type string
--      - Changed the DP core component and instance to new parameterized
--        version (pf_dpram_select.vhd)
--
--  DET  Oct. 13, 2001  (part of v1.02a version)
--      - Added the SRL FIFO option
--
--  DET  Oct 31, 2001
--      - Changed the input generic C_FAMILY of type string back to the
--        C_VIRTEX_II of type boolean. Changed caused by lack of string
--        support in the XST synthesis tool.
--
--
--     DET     4/1/2004     proc_common_v2 conversion
-- ~~~~~~
--     - Added library reference to proc_common_v2_00_a.
-- ^^^^^^
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
Use opb_v20_v1_10_d.ipif_control_rd;

-------------------------------------------------------------------------------

entity rdpfifo_top is
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
           -- True = virtex ii family
           -- False = virtex family
        );
    port(
    -- Inputs From the IPIF Bus
      Bus_rst               : In  std_logic;  -- Master Reset from the IPIF
      Bus_Clk               : In  std_logic;  -- Master clock from the IPIF
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
      IP2RFIFO_WrReq        : In std_logic;
      IP2RFIFO_WrMark       : In std_logic;
      IP2RFIFO_WrRestore    : In std_logic;
      IP2RFIFO_WrRelease    : In std_logic;
      IP2RFIFO_Data         : In std_logic_vector(0 to C_FIFO_WIDTH-1);

    -- Outputs to the IP
      RFIFO2IP_WrAck        : Out std_logic;
      RFIFO2IP_AlmostFull   : Out std_logic;
      RFIFO2IP_Full         : Out std_logic;
      RFIFO2IP_Vacancy      : Out std_logic_vector(0 to C_FIFO_DEPTH_LOG2X);

    -- Outputs to the IPIF DMA/SG function
      RFIFO2DMA_AlmostEmpty : Out std_logic;
      RFIFO2DMA_Empty       : Out std_logic;
      RFIFO2DMA_Occupancy   : Out std_logic_vector(0 to C_FIFO_DEPTH_LOG2X);

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
  end rdpfifo_top ;

-------------------------------------------------------------------------------

architecture implementation of rdpfifo_top is



-- COMPONENTS




--TYPES

  -- no types



-- CONSTANTS


   ----------------------------------------------------------------------------
   -- IMPORTANT!!!!!!!!!!!!!!!!!!!!!
   -- Set MODULE Versioning Information Here!!!
   --
   -- The following three constants indicate the versioning read via the MIR
   ----------------------------------------------------------------------------
   constant VERSION_MAJOR :  integer range 0 to 9 := 1;
                -- Major versioning the RPFIFO design

   constant VERSION_MINOR :  integer range 0 to 99:= 1;
                -- Minor Version of the RPFIFO design

   constant VERSION_REV   :  integer range 0 to 25:= 1;
                -- Revision letter (0 = a, 1 = b, 2 = c, etc)




   ----------------------------------------------------------------------------
   -- Set IPIF Block Protocol Type Here!!!!
   --

   ----------------------------------------------------------------------------
   Constant PFIFO_INTFC_TYPE :  integer range 0 to 31 := 2;
                -- IPIF block protocol Type
                -- (Read Packet FIFO = 2, Write PFIFO = 3)





   -- General Use Constants
   Constant LOGIC_LOW    : std_logic := '0';
   Constant LOGIC_HIGH   : std_logic := '1';




--INTERNAL SIGNALS

  -- Dual Port interconnect
   signal   sig_mem_wrreq:          std_logic;
   signal   sig_mem_wr_enable:      std_logic;
   signal   sig_mem_wr_data:        std_logic_vector(0 to
                                                     C_FIFO_WIDTH-1);

   signal   sig_mem_wr_addr:        std_logic_vector(0 to
                                                     C_FIFO_DEPTH_LOG2X-1);

   signal   sig_mem_rd_addr:        std_logic_vector(0 to
                                                     C_FIFO_DEPTH_LOG2X-1);

   signal   sig_mem_rd_data:        std_logic_vector(0 to C_FIFO_WIDTH-1);
   Signal   sig_data_wrack:         std_logic;

   Signal   sig_bramfifo_rdack:     std_logic;
   Signal   sig_srlfifo_rdack:      std_logic;
   signal   sig_fifo_full:          std_logic;
   signal   sig_fifo_empty:         std_logic;
   signal   sig_fifo_almost_full:   std_logic;
   signal   sig_fifo_almost_empty:  std_logic;
   signal   sig_fifo_occupancy:     std_logic_vector(0 to C_FIFO_DEPTH_LOG2X);
   signal   sig_fifo_vacancy:       std_logic_vector(0 to C_FIFO_DEPTH_LOG2X);
   Signal   sig_burst_rd_xfer:      std_logic;
   Signal   sig_fifo_logic_reset:   std_logic;
   signal   sig_fifo_deadlock :     std_logic;
   Signal   sig_bram_rdreq :        std_logic;
   Signal   sig_srl_rdreq :         std_logic;
   signal   sig_mem_rd_enable :     std_logic;
   Signal   sig_bus_dbus_lsnib:     std_logic_vector(0 to 3);

-------------------------------------------------------------------------------
------------- start processes -------------------------------------------------

  begin


 sig_bus_dbus_lsnib <=  Bus_DBus(C_IPIF_DBUS_WIDTH-4 to C_IPIF_DBUS_WIDTH-1);


-- connect I/O signals to internals
 RFIFO2IP_WrAck          <=  sig_data_wrack;
 RFIFO2IP_Full           <=  sig_fifo_full;
 RFIFO2IP_AlmostFull     <=  sig_fifo_almost_full;
 RFIFO2DMA_AlmostEmpty   <=  sig_fifo_almost_empty;
 RFIFO2DMA_Empty         <=  sig_fifo_empty;

 RFIFO2IP_Vacancy        <=  sig_fifo_vacancy;
 RFIFO2DMA_Occupancy     <=  sig_fifo_occupancy;


-- Some Dual Port signal assignments (vhdl wrapper)
 --sig_mem_wr_enable       <=  not(sig_fifo_full);
 sig_mem_wrreq           <=  IP2RFIFO_WrReq;
 sig_mem_wr_data         <=  IP2RFIFO_Data;









   I_IPIF_INTERFACE_BLOCK : entity opb_v20_v1_10_d.ipif_control_rd
     Generic map (
       C_MIR_ENABLE       =>  C_MIR_ENABLE   ,
       C_BLOCK_ID         =>  C_BLOCK_ID     ,
       C_INTFC_TYPE       =>  PFIFO_INTFC_TYPE,
       C_VERSION_MAJOR    =>  VERSION_MAJOR,
       C_VERSION_MINOR    =>  VERSION_MINOR,
       C_VERSION_REV      =>  VERSION_REV,
       C_FIFO_WIDTH       =>  C_FIFO_WIDTH,
       C_DP_ADDRESS_WIDTH =>  C_FIFO_DEPTH_LOG2X,
       C_SUPPORT_BURST    =>  C_SUPPORT_BURST,
       C_IPIF_DBUS_WIDTH  =>  C_IPIF_DBUS_WIDTH
       )
     port map (

     -- Inputs From the IPIF Bus
       Bus_rst             =>  Bus_rst       ,
       Bus_Clk             =>  Bus_Clk       ,
       Bus_RdReq           =>  Bus_RdReq     ,
       Bus_WrReq           =>  Bus_WrReq     ,
       Bus2FIFO_RdCE1      =>  Bus2FIFO_RdCE1,
       Bus2FIFO_RdCE2      =>  Bus2FIFO_RdCE2,
       Bus2FIFO_RdCE3      =>  Bus2FIFO_RdCE3,
       Bus2FIFO_WrCE1      =>  Bus2FIFO_WrCE1,
       Bus2FIFO_WrCE2      =>  Bus2FIFO_WrCE2,
       Bus2FIFO_WrCE3      =>  Bus2FIFO_WrCE3,
       Bus_DBus            =>  sig_bus_dbus_lsnib,

     -- Inputs from the FIFO Interface Logic
       Fifo_rd_data        =>  sig_mem_rd_data       ,
       BRAMFifo_RdAck      =>  sig_bramfifo_rdack    ,
       SRLFifo_RdAck       =>  sig_srlfifo_rdack     ,
       Occupancy           =>  sig_fifo_occupancy    ,
       AlmostEmpty         =>  sig_fifo_almost_empty ,
       Empty               =>  sig_fifo_empty        ,
       Deadlock            =>  sig_fifo_deadlock     ,

     -- Outputs to the FIFO
       Fifo_rst            =>  sig_fifo_logic_reset ,
       BRAMFifo_RdReq      =>  sig_bram_rdreq       ,
       SRLFifo_RdReq       =>  sig_srl_rdreq        ,
       Fifo_burst_rd_xfer  =>  sig_burst_rd_xfer    ,

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


       sig_srlfifo_rdack <= '0';



     -- Connect the Dual Port Address Controller to the VHDL wrapper
      I_DP_CONTROLLER: entity opb_v20_v1_10_d.rdpfifo_dp_cntl

        Generic map (
           C_DP_ADDRESS_WIDTH     =>  C_FIFO_DEPTH_LOG2X,
           C_INCLUDE_PACKET_MODE  =>  C_INCLUDE_PACKET_MODE,
           C_INCLUDE_VACANCY      =>  C_INCLUDE_VACANCY
           )
        port map(

        -- Inputs
          Bus_rst       =>   sig_fifo_logic_reset,
          Bus_clk       =>   Bus_Clk  ,
          Rdreq         =>   sig_bram_rdreq,
          Wrreq         =>   sig_mem_wrreq,
          Burst_rd_xfer =>   sig_burst_rd_xfer,
          Mark          =>   IP2RFIFO_WrMark   ,
          Restore       =>   IP2RFIFO_WrRestore,
          Release       =>   IP2RFIFO_WrRelease,

        -- Outputs
          WrAck         =>   sig_data_wrack,
          RdAck         =>   sig_bramfifo_rdack,
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

       sig_fifo_deadlock  <= '0';
       sig_srlfifo_rdack  <= sig_srl_rdreq and not(sig_fifo_empty);
       sig_data_wrack     <= sig_mem_wrreq and not(sig_fifo_full);
       sig_bramfifo_rdack <= '0';

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
            Rd_Req      =>   sig_srl_rdreq,
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

