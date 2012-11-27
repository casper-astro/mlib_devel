-------------------------------------------------------------------------------
-- $Id: bram_if.vhd,v 1.4 2003/05/20 21:22:04 anitas Exp $
-------------------------------------------------------------------------------
-- bram_if.vhd  - entity/architecture pair
-------------------------------------------------------------------------------
--
--  ***************************************************************************
--  **  Copyright(C) 2003 by Xilinx, Inc. All rights reserved.               **
--  **                                                                       **
--  **  This text contains proprietary, confidential                         **
--  **  information of Xilinx, Inc. , is distributed by                      **
--  **  under license from Xilinx, Inc., and may be used,                    **
--  **  copied and/or disclosed only pursuant to the terms                   **
--  **  of a valid license agreement with Xilinx, Inc.                       **
--  **                                                                       **
--  **  Unmodified source code is guaranteed to place and route,             **
--  **  function and run at speed according to the datasheet                 **
--  **  specification. Source code is provided "as-is", with no              **
--  **  obligation on the part of Xilinx to provide support.                 **
--  **                                                                       **
--  **  Xilinx Hotline support of source code IP shall only include          **
--  **  standard level Xilinx Hotline support, and will only address         **
--  **  issues and questions related to the standard released Netlist        **
--  **  version of the core (and thus indirectly, the original core source). **
--  **                                                                       **
--  **  The Xilinx Support Hotline does not have access to source            **
--  **  code and therefore cannot answer specific questions related          **
--  **  to source HDL. The Xilinx Support Hotline will only be able          **
--  **  to confirm the problem in the Netlist version of the core.           **
--  **                                                                       **
--  **  This copyright and support notice must be retained as part           **
--  **  of this text at all times.                                           **
--  ***************************************************************************
--
-------------------------------------------------------------------------------
-- Filename:        bram_if.vhd
-- Version:         v1.00a         
-- Description:     This design module is for a simple byte addressable memory 
--                  using the Xilinx BRAM primitives present in Xilinx FPGA 
--                  devices.
--
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:
--              bram_if.vhd
-------------------------------------------------------------------------------
-- Author:          DAB
-- Revision:        $Revision: 1.4 $
-- Date:            $4/5/2002$
--
-- History:
--     dab     6/12/2002    Initial Version
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
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library proc_common_v1_00_b;
Use proc_common_v1_00_b.proc_common_pkg.all;

-------------------------------------------------------------------------------
-- Definition of Generics:
--      C_IPIF_DWIDTH               -- IPIC data width
--      C_IPIF_AWIDTH               -- IPIC address width
--
-- Definition of Ports:
--    -- Clock and reset          
--    bus_reset                     -- Reset
--    bus_clk                       -- PLB/OPB clock

--  -- IPIC
--    Bus2IP_BE                     -- Processor bus byte enables
--    Bus2IP_Addr                   -- Processor bus address                
--    Bus2IP_Data                   -- Processor data
--    Bus2IP_BRAM_CS                -- BRAM is being accessed
--    Bus2IP_RNW                    -- Processor read not write
--    Bus2IP_WrReq                  -- Processor write request
--    Bus2IP_RdReq                  -- Processor read request
--
--    -- IPIC outputs
--    IP2Bus_Data                   -- Data to processor bus
--    IP2Bus_RdAck                  -- Read acknowledge
--    IP2Bus_WrAck                  -- Write acknowledge
--    IP2Bus_Retry                  -- Retry indicator
--    IP2Bus_ToutSup                -- Suppress watch dog timer
--    
--    -- BRAM interface signals
--    BRAM_Rst                      -- BRAM reset             
--    BRAM_CLK                      -- BRAM clock
--    BRAM_EN                       -- BRAM chip enable
--    BRAM_WEN                      -- BRAM write enable
--    BRAM_Addr                     -- BRAM address 
--    BRAM_Dout                     -- BRAM write data
--    BRAM_Din                      -- BRAM read data
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Entity section
-------------------------------------------------------------------------------

entity bram_if is
  generic (
    C_IPIF_AWIDTH : Integer := 32;
        -- The width if the IPIF address bus

    C_IPIF_DWIDTH : Integer := 64
        -- The width of the IPIF data bus
    );

  port (
    -- input ports
    bus_reset       : in std_logic;
    bus_clk         : in std_logic;
    Bus2IP_BE       : in std_logic_vector(0 to (C_IPIF_DWIDTH/8)-1);
    Bus2IP_Addr     : in std_logic_vector(0 to C_IPIF_AWIDTH-1);
    Bus2IP_Data     : in std_logic_vector(0 to C_IPIF_DWIDTH-1);
    Bus2IP_BRAM_CS  : in std_logic;
    Bus2IP_RNW      : in std_logic;
    Bus2IP_WrReq    : in std_logic;
    Bus2IP_RdReq    : in std_logic;

    -- Output ports
    IP2Bus_Data     : out std_logic_vector(0 to C_IPIF_DWIDTH-1);
    IP2Bus_RdAck    : out std_logic;
    IP2Bus_WrAck    : out std_logic;
    IP2Bus_Retry    : out std_logic;
    IP2Bus_Error    : out std_logic;
    IP2Bus_ToutSup  : out std_logic;

    --BRAM Ports
    BRAM_Rst        : out  std_logic;
    BRAM_CLK        : out  std_logic;
    BRAM_EN         : out  std_logic;
    BRAM_WEN        : out  std_logic_vector(0 to C_IPIF_DWIDTH/8-1); --Qualified WE
    BRAM_Addr       : out  std_logic_vector(0 to C_IPIF_AWIDTH-1);
    BRAM_Dout       : out std_logic_vector(0 to C_IPIF_DWIDTH-1);
    BRAM_Din        : in  std_logic_vector(0 to C_IPIF_DWIDTH-1)
    );

end entity bram_if;

-----------------------------------------------------------------------------
-- Architecture section
-----------------------------------------------------------------------------
architecture implementation of bram_if is

-----------------------------------------------------------------------------
-- Function declarations
-----------------------------------------------------------------------------
function "and"  ( l : std_logic_vector; r : std_logic )
return std_logic_vector is
    variable rex : std_logic_vector(l'range);
begin
    rex := (others=>r);
    return( l and rex );
end function "and";

-----------------------------------------------------------------------------
-- Signal declarations
-----------------------------------------------------------------------------
      signal  IP2Bus_Data_i  : std_logic_vector(0 to C_IPIF_DWIDTH-1);
      Signal  IP2Bus_RdAck_i : std_logic;
      Signal  IP2Bus_WrAck_i : std_logic;
      Signal  address_bus_i  : std_logic_vector(0 to C_IPIF_AWIDTH-1);
      Signal  write_data_i   : std_logic_vector(0 to C_IPIF_DWIDTH-1);
      Signal  read_data_i    : std_logic_vector(0 to C_IPIF_DWIDTH-1);
      Signal  read_enable    : std_logic;
      Signal  read_enable_dly1 : std_logic;
      Signal  BRAM_QWEN : std_logic_vector(0 to C_IPIF_DWIDTH/8-1);

-----------------------------------------------------------------------------
-- Begin architecture
-----------------------------------------------------------------------------

begin -- (architecture implementation)

  -- (Misc Assignments)
   address_bus_i    <= Bus2IP_ADDR;
   write_data_i     <= Bus2IP_Data;
   read_enable      <= Bus2IP_BRAM_CS and Bus2IP_RdReq;
   IP2Bus_Data      <= IP2Bus_Data_i;
   IP2Bus_RdAck     <= IP2Bus_RdAck_i;
   IP2Bus_WrAck     <= Bus2IP_BRAM_CS and Bus2IP_WrReq;
   IP2Bus_Retry     <= '0';
   IP2Bus_Error     <= '0';
   IP2Bus_ToutSup   <= '0';

   BRAM_QWEN <= (Bus2IP_BE and Bus2IP_WrReq);
   
-------------------------------------------------------------
 -- Synchronous Process
 --
 -- Label: GEN_RD_ACK
 --
 -- Process Description:
 -- This process generates the read acknowledge 1 clock after
 -- read enable signal is presented to the BRAM block. The
 -- BRAM block primitive has a 1 clock delay from read enable
 -- to data out.
 ---------------------------------------------------------------
 GEN_RD_ACK : process (bus_clk)
    begin
      if (bus_clk'event and bus_clk = '1') then
         if (bus_reset = '1') then
 
           read_enable_dly1   <= '0';
 
         else
 
           read_enable_dly1   <= read_enable;
 
         end if;
 
 
         if (bus_reset = '1') then
 
           IP2Bus_RdAck_i <= '0';
 
         elsif (read_enable_dly1 = '0' and
                read_enable = '1') then
 
             IP2Bus_RdAck_i <= '1';
 
         else
 
           IP2Bus_RdAck_i <= '0';
 
         end if;
 
      else
        null;
      end if;
 
    end process GEN_RD_ACK;
 
 -------------------------------------------------------------
 -- Assign the read data
 --
 -- No mux is necessary since the bram data is the only data
 -- source
 -------------------------------------------------------------
IP2Bus_Data_i <= read_data_i;


 ------------------------------------------------------------
 -- Label: CONNECT_BRAM
 --
 -- Concurrent signal assignments to connect the  BRAM
 -- interface
 ------------------------------------------------------------

      --  Port A signals
      BRAM_Rst      <=     bus_reset;
      BRAM_Clk      <=     bus_clk;
      BRAM_EN       <=     Bus2IP_BRAM_CS;
      BRAM_WEN      <=     BRAM_QWEN;
      BRAM_Addr     <=     address_bus_i;
      BRAM_Dout     <=     write_data_i;
      read_data_i   <=     BRAM_Din;

end implementation;
