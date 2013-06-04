--SINGLE_FILE_TAG
-------------------------------------------------------------------------------
-- $Id: ipif_data_steer.vhd,v 1.1 2003/02/18 19:16:01 ostlerf Exp $
-------------------------------------------------------------------------------
-- IPIF_Data_Steer - entity/architecture pair
-------------------------------------------------------------------------------
--
--                  ****************************
--                  ** Copyright Xilinx, Inc. **
--                  ** All rights reserved.   **
--                  ****************************
--
-------------------------------------------------------------------------------
-- Filename:        ipif_data_steer.vhd
-- Version:         v1.10.a
-- Description:     Read and Write Steering logic for IPIF
--
--                  For writes, this logic steers data from the correct byte
--                  lane to IPIF devices which may be smaller than the bus
--                  width. The BE signals are also steered if the BE_Steer
--                  signal is asserted, which indicates that the address space
--                  being accessed has a smaller maximum data transfer size
--                  than the bus size. 
--
--                  For writes, the Decode_size signal determines how read
--                  data is steered onto the byte lanes. To simplify the 
--                  logic, the read data is mirrored onto the entire data
--                  bus, insuring that the lanes corrsponding to the BE's
--                  have correct data.
-- 
--                  
--
-------------------------------------------------------------------------------
-- Structure: 
--
--              ipif_data_steer.vhd
--
-------------------------------------------------------------------------------
-- Author:      BLT
-- History:
--  BLT             2-5-2002      -- First version
-- ^^^^^^
--      First version of IPIF steering logic.
-- ~~~~~~
--  BLT             2-12-2002     -- Removed BE_Steer, now generated internally
--
--  DET             2-24-2002     -- Added 'When others' to size case statement
--                                   in BE_STEER_PROC process.
--  BLT             5-13-2002     -- Added capability for peripherals larger
--                                   than bus, new optimizations
--
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
--      combinatorial signals:                  "*_cmb" 
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
use IEEE.std_logic_arith.all;
use IEEE.std_logic_signed.all;
use IEEE.std_logic_misc.all;
library ipif_common_v1_00_c;
use ipif_common_v1_00_c.all;

-------------------------------------------------------------------------------
-- Port declarations
--   generic definitions:
--     C_DWIDTH_BUS       : integer := width of host databus attached to the IPIF
--     C_DWIDTH_IP        : integer := width of IP databus attached to the IPIF
--     C_SMALLEST_MASTER  : integer := width of smallest master (not access size)
--                              attached to the IPIF
--     C_SMALLEST_IP      : integer := width of smallest IP device (not access size)
--                              attached to the IPIF
--     C_AWIDTH    : integer := width of the host address bus attached to
--                              the IPIF
--   port definitions:
--     Wr_Data_In         : in  Write Data In (from host data bus)
--     Rd_Data_In         : in  Read Data In (from IPIC data bus)
--     Addr               : in  Address bus from host address bus
--     BE_In              : in  Byte Enables In from host side
--     Decode_size        : in  Size of MAXIMUM data access allowed to
--                              a particular address map decode.
--
--                                Size indication (Decode_size)
--                                  001 - byte           
--                                  010 - halfword       
--                                  011 - word           
--                                  100 - doubleword     
--                                  101 - 128-b          
--                                  110 - 256-b
--                                  111 - 512-b
--                                  num_bytes = 2^(n-1)
--
--     BE_Steer           : in  BE_Steer = 1 : steer BE's onto IPIF BE bus
--                              BE_Steer = 0 : don't steer BE's, pass through
--     Wr_Data_Out        : out Write Data Out (to IPIF data bus)
--     Rd_Data_Out        : out Read Data Out (to host data bus)
--     BE_Out             : out Byte Enables Out to IPIF side
-- 
-------------------------------------------------------------------------------

entity IPIF_Data_Steer is
  generic (
    C_DWIDTH_BUS       : integer := 32;   -- 8, 16, 32, 64, 128, 256, or 512
    C_DWIDTH_IP        : integer := 64;   -- 8, 16, 32, 64, 128, 256, or 512
    C_SMALLEST_MASTER  : integer := 32;   -- 8, 16, 32, 64, 128, 256, or 512
    C_SMALLEST_IP      : integer := 8;   -- 8, 16, 32, 64, 128, 256, or 512
    C_AWIDTH           : integer := 32
    );   
  port (
    Wr_Data_In         : in  std_logic_vector(0 to C_DWIDTH_BUS-1);
    Rd_Data_In         : in  std_logic_vector(0 to C_DWIDTH_IP-1);
    Addr               : in  std_logic_vector(0 to C_AWIDTH-1);
    BE_In              : in  std_logic_vector(0 to C_DWIDTH_BUS/8-1);
    Decode_size        : in  std_logic_vector(0 to 2);
    Wr_Data_Out        : out std_logic_vector(0 to C_DWIDTH_IP-1);
    Rd_Data_Out        : out std_logic_vector(0 to C_DWIDTH_BUS-1);
    BE_Out             : out std_logic_vector(0 to C_DWIDTH_IP/8-1)
    );
end entity IPIF_Data_Steer;

-------------------------------------------------------------------------------
-- Architecture section
-------------------------------------------------------------------------------

architecture IMP of IPIF_Data_Steer is

component Steer_Module_Write is
  generic (
    C_DWIDTH_IN        : integer;    -- 8, 16, 32, 64, 128, 256, or 512 -- HOST 
    C_DWIDTH_OUT       : integer;    -- 8, 16, 32, 64, 128, 256, or 512 -- IP
    C_SMALLEST_OUT     : integer;    -- 8, 16, 32, 64, 128, 256, or 512 -- IP
    C_AWIDTH           : integer  
    );   
  port (
    Data_In            : in  std_logic_vector(0 to C_DWIDTH_IN-1);
    BE_In              : in  std_logic_vector(0 to C_DWIDTH_IN/8-1);
    Addr               : in  std_logic_vector(0 to C_AWIDTH-1);
    Decode_size        : in  std_logic_vector(0 to 2);
    Data_Out           : out std_logic_vector(0 to C_DWIDTH_OUT-1);
    BE_Out             : out std_logic_vector(0 to C_DWIDTH_OUT/8-1)
    );
end component Steer_Module_Write;

component Steer_Module_Read is
  generic (
    C_DWIDTH_IN        : integer;   -- 8, 16, 32, 64, 128, 256, or 512  -- IP 
    C_DWIDTH_OUT       : integer;   -- 8, 16, 32, 64, 128, 256, or 512  -- HOST
    C_SMALLEST_OUT     : integer;   -- 8, 16, 32, 64, 128, 256, or 512  -- HOST
    C_SMALLEST_IN      : integer;   -- 8, 16, 32, 64, 128, 256, or 512  -- IP
    C_AWIDTH           : integer  
    );   
  port (
    Data_In            : in  std_logic_vector(0 to C_DWIDTH_IN-1);
    Addr               : in  std_logic_vector(0 to C_AWIDTH-1);
    Decode_size        : in  std_logic_vector(0 to 2);
    Data_Out           : out std_logic_vector(0 to C_DWIDTH_OUT-1)
    );
end component Steer_Module_Read;

-------------------------------------------------------------------------------
-- Begin architecture
-------------------------------------------------------------------------------

begin -- architecture IMP
    
  -----------------------------------------------------------------------------
  -- OPB Data Muxing and Steering
  -----------------------------------------------------------------------------
  
  -- Size indication (Decode_size)
  -- n = 001 byte           2^0
  -- n = 010 halfword       2^1
  -- n = 011 word           2^2
  -- n = 100 doubleword     2^3
  -- n = 101 128-b
  -- n = 110 256-b
  -- n = 111 512-b
  -- num_bytes = 2^(n-1)

WRITE_I: Steer_Module_Write
  generic map (
    C_DWIDTH_IN    => C_DWIDTH_BUS,   -- 8, 16, 32, 64, 128, 256, or 512 -- HOST 
    C_DWIDTH_OUT   => C_DWIDTH_IP,    -- 8, 16, 32, 64, 128, 256, or 512 -- IP
    C_SMALLEST_OUT => C_SMALLEST_IP,  -- 8, 16, 32, 64, 128, 256, or 512 -- IP
    C_AWIDTH       => C_AWIDTH )
  port map (
    Data_In        => Wr_Data_In,  --[in]
    BE_In          => BE_In,       --[in]
    Addr           => Addr,        --[in]
    Decode_size    => Decode_size, --[in]
    Data_Out       => Wr_Data_Out, --[out]
    BE_Out         => BE_Out       --[out]
    );

READ_I: Steer_Module_Read
  generic map (
    C_DWIDTH_IN    => C_DWIDTH_IP,         -- 8, 16, 32, 64, 128, 256, or 512  -- IP 
    C_DWIDTH_OUT   => C_DWIDTH_BUS,        -- 8, 16, 32, 64, 128, 256, or 512  -- HOST
    C_SMALLEST_OUT => C_SMALLEST_MASTER,   -- 8, 16, 32, 64, 128, 256, or 512  -- HOST
    C_SMALLEST_IN  => C_SMALLEST_IP,       -- 8, 16, 32, 64, 128, 256, or 512  -- IP
    C_AWIDTH       => C_AWIDTH  )  
  port map (
    Data_In        => Rd_Data_In,  --[in]
    Addr           => Addr,        --[in]
    Decode_size    => Decode_size, --[in]
    Data_Out       => Rd_Data_Out  --[out]
    );
    
end architecture IMP;
