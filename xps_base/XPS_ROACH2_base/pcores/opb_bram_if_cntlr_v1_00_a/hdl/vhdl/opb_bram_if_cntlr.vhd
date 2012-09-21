-------------------------------------------------------------------------------
-- $Id: opb_bram_if_cntlr.vhd,v 1.10 2003/06/27 14:20:34 anitas Exp $
-------------------------------------------------------------------------------
-- opb_bram_if_cntlr.vhd  - entity/architecture pair
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
-- Filename:        opb_bram_if_cntlr.vhd
-- Version:         v1.00a
-- Description:     This is the top-level design file for the OPB External Bus
--                  Controller. It supports 1-16 masters and control for BRAM
--                  modules. 
-------------------------------------------------------------------------------
-- Structure:
--
--              opb_bram_if_cntlr.vhd
--                 -- bram_if.vhd
--
--
-------------------------------------------------------------------------------
-- Author:      DAB
-- History:
--  DAB      06-12-2002      -- First version
--  ALS      05-14-2003     
-- ^^^^^^
--  Upgraded to latest OPB_BAM (replaces OPB_IPIF) and added support for bursting
-- ~~~~~~
-- ALS      05-27-2003
-- ^^^^^^
--  Removed XST "dummy" entries in arrays
-- ~~~~~~
-- ALS      06-24-2003
-- ^^^^^^
--  Use proc_common_v1_00_b library to be consistent with bram_if_cntlr and 
--  plb_bram_if_cntlr.
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
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.conv_std_logic_vector;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_signed.all;
use IEEE.std_logic_misc.all;

library Unisim;
use Unisim.all;

library proc_common_v1_00_b;
use proc_common_v1_00_b.proc_common_pkg.all;
use proc_common_v1_00_b.all;

library ipif_common_v1_00_c;
use ipif_common_v1_00_c.ipif_pkg.all;
use ipif_common_v1_00_c.all;

library opb_ipif_v3_00_a;
use opb_ipif_v3_00_a.all;

library bram_if_cntlr_v1_00_a;
use bram_if_cntlr_v1_00_a.all;

--
-- library unsigned is used for overloading of "=" which allows integer to
-- be compared to std_logic_vector
use ieee.std_logic_unsigned.all;
--
-------------------------------------------------------------------------------
-- Port Declaration
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Definition of Generics:
--      C_BASEADDR                  -- BRAM memory base address                                                                                 
--      C_HIGHADDR                  -- BRAM memory high address
--      C_INCLUDE_BURST_SUPPORT     -- include support for PLB burst/cachelines
--      C_OPB_DWIDTH                -- OPB data bus width
--      C_OPB_AWIDTH                -- OPB address bus width
--      C_OPB_CLK_PERIOD_PS         -- OPB clock period in pico-seconds
--
-- Definition of Ports:
--  OPB Bus
--      OPB_ABus                    -- OPB address bus                                             
--      OPB_DBus                    -- OPB  data bus                                                   
--      Sln_DBus                    -- Slave read bus                                         
--      OPB_select                  -- OPB Select                                    
--      OPB_RNW                     -- OPB read not write                                           
--      OPB_seqAddr                 -- OPB sequential address                              
--      OPB_BE                      -- OPB byte enables                                              
--      Sln_xferAck                 -- Slave transfer acknowledge                            
--      Sln_errAck                  -- Slave Error acknowledge
--      Sln_toutSup                 -- Slave Timeout Suppress
--      Sln_retry                   -- Slave retry
--
--  BRAM interface signals
--      BRAM_Rst                      -- BRAM reset             
--      BRAM_CLK                      -- BRAM clock
--      BRAM_EN                       -- BRAM chip enable
--      BRAM_WEN                      -- BRAM write enable
--      BRAM_Addr                     -- BRAM address 
--      BRAM_Dout                     -- BRAM write data
--      BRAM_Din                      -- BRAM read data
-------------------------------------------------------------------------------

-----------------------------------------------------------------------------
-- Entity section
-----------------------------------------------------------------------------
entity opb_bram_if_cntlr is
   -- Generics to be set by user
  generic (
    C_BASEADDR                        : std_logic_vector := X"FFFF_FFFF";
    C_HIGHADDR                        : std_logic_vector := X"0000_0000";


    --Generics set for IPIF
    C_INCLUDE_BURST_SUPPORT           : integer := 0;
    C_OPB_DWIDTH                      : integer := 32;
    C_OPB_AWIDTH                      : integer := 32;
    C_OPB_CLK_PERIOD_PS               : integer := 40000

        );
  port
      (
       -- System Port Declarations ********************************************

       OPB_Clk         :   in std_logic;
       OPB_Rst         :   in std_logic;

       -- OPB Port Declarations ***********************************************
       OPB_ABus       : in std_logic_vector(0 to C_OPB_AWIDTH - 1 );
       OPB_DBus       : in std_logic_vector(0 to C_OPB_DWIDTH - 1 );
       Sln_DBus       : out std_logic_vector(0 to C_OPB_DWIDTH - 1 );
       OPB_select     : in std_logic := '0';
       OPB_RNW        : in std_logic := '0';
       OPB_seqAddr    : in std_logic := '0';
       OPB_BE         : in std_logic_vector(0 to C_OPB_DWIDTH/8 - 1 );
       Sln_xferAck    : out std_logic;
       Sln_errAck     : out std_logic;
       Sln_toutSup    : out std_logic;
       Sln_retry      : out std_logic;

       -- User BRAM Port

       BRAM_Rst        : out std_logic;
       BRAM_Clk        : out std_logic;
       BRAM_EN         : out std_logic;
       BRAM_WEN        : out std_logic_vector(0 to C_OPB_DWIDTH/8 - 1);
       BRAM_Addr       : out std_logic_vector(0 to C_OPB_AWIDTH-1);
       BRAM_Din        : in std_logic_vector(0 to C_OPB_DWIDTH-1);
       BRAM_Dout       : out std_logic_vector(0 to C_OPB_DWIDTH-1)

      );
      
      --fan-out attributes for XST
      attribute MAX_FANOUT                  : string;
      attribute MAX_FANOUT   of OPB_Clk     : signal is "10000";
      attribute MAX_FANOUT   of OPB_Rst     : signal is "10000";
      
      -- PSFUtil MPD attributes
      attribute MIN_SIZE    : string;
      attribute MIN_SIZE of C_BASEADDR : constant is "0x800";

      attribute SIGIS       : string;
      attribute SIGIS of OPB_Clk : signal is "CLK";
      attribute SIGIS of OPB_Rst : signal is "RST";
      
      attribute SPECIAL     : string;
      attribute SPECIAL of opb_bram_if_cntlr:entity is "BRAM_CNTLR";
      
      attribute ADDR_SLICE  : integer;
      attribute ADDR_SLICE of opb_bram_if_cntlr:entity is 29;
      
      attribute NUM_WRITE_ENABLES : integer;
      attribute NUM_WRITE_ENABLES of opb_bram_if_cntlr:entity is 4;
      
      attribute AWIDTH      : integer;
      attribute AWIDTH of opb_bram_if_cntlr:entity is 32;
      
      attribute DWIDTH      : integer;
      attribute DWIDTH of opb_bram_if_cntlr:entity is 32;

end opb_bram_if_cntlr;
-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------
architecture implementation of opb_bram_if_cntlr is

-------------------------------------------------------------------------------
-- Constant Declarations
-------------------------------------------------------------------------------
-------------------- Pipeline Model -------------------------------------------
-- Note: the OPBOUT pipeline registers are always required as the reset to
-- these registers is what guarantees that the Sln_DBus is zero'd at the end
-- of the read transaction

    -- for smaller latency and perhaps potentially slower Fmax,
    -- include only OPBOUT pipeline registers
    -- set the PIPELINE_MODEL constant to 4
    constant PIPELINE_MODEL         : integer := 4; 
    
    -- for 1 clock more latency and perhaps potentially faster Fmax,
    -- include OPBIN and OPBOUT pipeline registers
    -- set the PIPELINE_MODEL constant to 5
    --constant PIPELINE_MODEL         : integer := 5; 

    constant BRAM                : integer := 120;

    constant ARD_ID_ARRAY : INTEGER_ARRAY_TYPE :=
            (
             0 => BRAM     -- Memory  
               );

    constant ZEROES              :  std_logic_vector := X"00000000";

    constant ARD_ADDR_RANGE_ARRAY: SLV64_ARRAY_TYPE :=
           (
            ZEROES & C_BASEADDR, -- BRAM Base Address 
            ZEROES & C_HIGHADDR -- BRAM High Address 
           );

    constant ARD_DWIDTH_ARRAY     : INTEGER_ARRAY_TYPE :=
            (
             0 => C_OPB_DWIDTH   --  BRAM data width
            );

    constant ARD_NUM_CE_ARRAY   : INTEGER_ARRAY_TYPE :=
            (
             0 => 1    -- BRAM CE number
            );

    constant IP_INTR_MODE_ARRAY     : integer_array_type := (1,1);

    constant ZERO_AWIDTH         : std_logic_vector(0 to C_OPB_AWIDTH - 1) 
                                                := (others => '0');
    constant ZERO_DWIDTH         : std_logic_vector(0 to C_OPB_DWIDTH - 1) 
                                                := (others => '0');
    constant ZERO_BE             : std_logic_vector(0 to C_OPB_DWIDTH/8 - 1) 
                                                := (others => '0');
    constant ZERO_INTR           : std_logic_vector(0 to IP_INTR_MODE_ARRAY'length-1) 
                                                := (others => '0');
    constant ZERO_POSTED_WRINH   : std_logic_vector(0 to ARD_ID_ARRAY'length-1) 
                                                := (others => '0');
-------------------------------------------------------------------------------
-- Signal and Type Declarations
-------------------------------------------------------------------------------

-- IPIC Used Signals

  signal ip2bus_rdack             : std_logic;
  signal IP2Bus_wrAck             : std_logic;
  signal IP2Bus_Ack               : std_logic_vector(0 to ARD_ID_ARRAY'length-1);
  signal IP2Bus_toutSup           : std_logic_vector(0 to ARD_ID_ARRAY'length-1);
  signal IP2Bus_retry             : std_logic_vector(0 to ARD_ID_ARRAY'length-1);
  signal IP2Bus_errAck            : std_logic_vector(0 to ARD_ID_ARRAY'length-1);
  signal IP2Bus_Data              : std_logic_vector(0 to C_OPB_DWIDTH*calc_num_ce(ARD_NUM_CE_ARRAY)-1);
  signal Bus2IP_Addr              : std_logic_vector(0 to C_OPB_AWIDTH - 1);
  signal Bus2IP_Data              : std_logic_vector(0 to C_OPB_DWIDTH - 1);
  signal Bus2IP_RNW               : std_logic;
  signal Bus2IP_RdReq             : std_logic;
  signal Bus2IP_WrReq             : std_logic;
  signal Bus2IP_CS                : std_logic_vector(0 to ((ARD_ADDR_RANGE_ARRAY'LENGTH)/2)-1);
  signal Bus2IP_CE                : std_logic_vector(0 to calc_num_ce(ARD_NUM_CE_ARRAY)-1);
  signal Bus2IP_RdCE              : std_logic_vector(0 to calc_num_ce(ARD_NUM_CE_ARRAY)-1);
  signal Bus2IP_WrCE              : std_logic_vector(0 to calc_num_ce(ARD_NUM_CE_ARRAY)-1);
  signal Bus2IP_BE                : std_logic_vector(0 to (C_OPB_DWIDTH / 8) - 1);
  signal Bus2IP_Burst             : std_logic;
  signal Bus2IP_Clk               : std_logic;
  signal Bus2IP_Reset             : std_logic;

-- registered signals
  signal bus2ip_rdce_d1           : std_logic;
  
-- internal signals
  signal bram_if_address          : std_logic_vector(0 to C_OPB_AWIDTH-1);
  
-------------------------------------------------------------------------------
-- Component Declarations
-------------------------------------------------------------------------------
component opb_ipif 
  generic
  (
    C_ARD_ID_ARRAY              : INTEGER_ARRAY_TYPE
                                := ( 0 => IPIF_INTR,
                                     1 => IPIF_RST,
                                     2 => USER_00
                                   );
    C_ARD_ADDR_RANGE_ARRAY      : SLV64_ARRAY_TYPE
                                := ( x"0000_0000_6000_0000",  -- IPIF_INTR
                                     x"0000_0000_6000_003F",
                                   --
                                     x"0000_0000_6000_0040",  -- IPIF_RST
                                     x"0000_0000_6000_0043",
                                   --
                                     x"0000_0000_6000_0100",  -- USER_00
                                     x"0000_0000_6000_01FF"
                                   );
    C_ARD_DWIDTH_ARRAY          : INTEGER_ARRAY_TYPE
                                := ( 32,                      -- IPIF_INTR
                                     32,                      -- IPIF_INTR
                                     32                       -- USER_00
                                   );
    C_ARD_NUM_CE_ARRAY          : INTEGER_ARRAY_TYPE
                                := ( 16,                      -- IPIF_INTR
                                      1,                      -- IPIF_RST
                                      8                       -- USER_00
                                    );
    C_ARD_DEPENDENT_PROPS_ARRAY : DEPENDENT_PROPS_ARRAY_TYPE
                           := (
                                0 => (others => 0)
                               ,1 => (others => 0)
                               ,2 => (others => 0)
                              );
    C_PIPELINE_MODEL            : integer                    := 7;
      -- The pipe stages are enumerated and numbered as:
      --   --  ----------
      --    n  Pipe stage
      --   --  ----------
      --    0  OPBIN
      --    1  IPIC
      --    2  OPBOUT
      -- Each pipe stage is either present or absent (i.e. bypassed).
      -- The pipe stage, n, is present iff the (2^n)th
      -- bit in C_PIPELINE_MODEL is 1.
      --
    C_DEV_BLK_ID : INTEGER := 1;   
      --  Unique block ID, assigned to the device when the system is built.
    C_DEV_MIR_ENABLE : INTEGER := 0;   
    C_AWIDTH : INTEGER := 32;   
      -- width of Address Bus (in bits)
    C_DWIDTH : INTEGER := 32;   
      -- Width of the Data Bus (in bits)
    C_FAMILY : string := "virtexe";
      --
    C_IP_INTR_MODE_ARRAY   : INTEGER_ARRAY_TYPE := ( 5, 1 );
      -- 
      -- There will be one interrupt signal for each entry in
      -- C_IP_INTR_MODE_ARRAY. The leftmost entry will be the
      -- mode for input port IP2Bus_Intr(0), the next entry
      -- for IP2Bus_Intr(1), etc.
      --
      -- These modes are supported:
      --
      --  Mode  Description
      --
      --   1    Active-high interrupt condition.
      --        The IP core drives a signal--via the corresponding
      --        IP2Bus_Intr(i) port-- that is an interrupt condition 
      --        that is latched and cleared in the IP core and made available
      --        to the system via the Interrupt Source Controller in
      --        the Bus Attachment Module.
      --
      --   2    Active-low interrupt condition.
      --        Like 1, except that the interrupt condition is asserted low.
      --
      --   3    Active-high pulse interrupt event.
      --        The IP core drives a signal--via the corresponding
      --        IP2Bus_Intr(i) port--whose single clock period of active-high
      --        assertion is an interrupt event that is latched,
      --        and cleared as a service of the Interrupt Source
      --        Controller in the Bus Attachment Module.
      --
      --   4    Active-low pulse interrupt event.
      --        Like 3, except the interrupt-event pulse is active low.
      --
      --   5    Positive-edge interrupt event.
      --        The IP core drives a signal--via the corresponding
      --        IP2Bus_Intr(i) port--whose low-to-high transition, synchronous
      --        with the clock, is an interrupt event that is latched,
      --        and cleared as a service of the Interrupt Source
      --        Controller in the Bus Attachment Module.
      --
      --   6    Negative-edge interrupt event.
      --        Like 5, except that the interrupt event is a
      --        high-to-low transition.
      --
      --   Other mode codes are reserved.
      --
    C_INCLUDE_DEV_ISC : INTEGER := 1;
      -- 'true' specifies that the full device interrupt
      -- source controller structure will be included;
      -- 'false' specifies that only the global interrupt
      -- enable register of the device interrupt source
      -- controller and that the only source of interrupts
      -- in the device is the IP interrupt source controller
    C_INCLUDE_DEV_IID : integer := 0;
      -- 'true' will include the Device IID register in the device ISC
    C_DEV_BURST_ENABLE : INTEGER := 0
      -- Burst Enable for IPIF Interface
  );
  port
  (
    OPB_select         : in  std_logic;
    OPB_DBus           : in  std_logic_vector(0 to C_DWIDTH-1);
    OPB_ABus           : in  std_logic_vector(0 to C_AWIDTH-1);
    OPB_BE             : in  std_logic_vector(0 to C_DWIDTH/8-1);
    OPB_RNW            : in  std_logic;
    OPB_seqAddr        : in  std_logic;
    OPB_xferAck        : in  std_logic;
    Sln_DBus           : out std_logic_vector(0 to C_DWIDTH-1);
    Sln_xferAck        : out std_logic;
    Sln_errAck         : out std_logic;
    Sln_retry          : out std_logic;
    Sln_toutSup        : out std_logic;
    Bus2IP_CS          : out std_logic_vector(0 to C_ARD_ID_ARRAY'length-1);
    Bus2IP_CE          : out std_logic_vector(0 to calc_num_ce(C_ARD_NUM_CE_ARRAY)-1);
    Bus2IP_RdCE        : out std_logic_vector(0 to calc_num_ce(C_ARD_NUM_CE_ARRAY)-1);
    Bus2IP_WrCE        : out std_logic_vector(0 to calc_num_ce(C_ARD_NUM_CE_ARRAY)-1);
    Bus2IP_Data        : out std_logic_vector(0 to C_DWIDTH-1);
    Bus2IP_Addr        : out std_logic_vector(0 to C_AWIDTH-1);
    Bus2IP_BE          : out std_logic_vector(0 to C_DWIDTH/8-1);
    Bus2IP_RNW         : out std_logic;
    Bus2IP_Burst       : out std_logic;
    IP2Bus_Data        : in  std_logic_vector(0 to C_DWIDTH*calc_num_ce(C_ARD_NUM_CE_ARRAY)-1);
    IP2Bus_Ack         : in  std_logic_vector(0 to C_ARD_ID_ARRAY'length-1);
    IP2Bus_Error       : in  std_logic_vector(0 to C_ARD_ID_ARRAY'length-1);
    IP2Bus_Retry       : in  std_logic_vector(0 to C_ARD_ID_ARRAY'length-1);
    IP2Bus_ToutSup     : in  std_logic_vector(0 to C_ARD_ID_ARRAY'length-1);
    IP2Bus_PostedWrInh : in  std_logic_vector(0 to C_ARD_ID_ARRAY'length-1);
    OPB_Clk            : in  std_logic;
    Bus2IP_Clk         : out std_logic;
    IP2Bus_Clk         : in  std_logic;
    Reset              : in  std_logic;
    Bus2IP_Reset       : out std_logic;
    IP2Bus_Intr        : in  std_logic_vector(0 to C_IP_INTR_MODE_ARRAY'length-1);
    Device_Intr        : out std_logic
  );
end component opb_ipif;

component bram_if
  generic (
    C_IPIF_AWIDTH : Integer := 32;
        -- The width if the IPIF address bus

    C_IPIF_DWIDTH : Integer := 32
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
    BRAM_WEN        : out std_logic_vector(0 to C_IPIF_DWIDTH/8 - 1 );
    BRAM_Addr       : out  std_logic_vector(0 to C_IPIF_AWIDTH-1);
    BRAM_Dout       : out std_logic_vector(0 to C_IPIF_DWIDTH-1);
    BRAM_Din        : in  std_logic_vector(0 to C_IPIF_DWIDTH-1)

    );
  end component;


component direct_path_cntr 
    generic (
        C_WIDTH   : natural := 8
    );
    port (
        Clk      : in  std_logic;
        Din      : in  std_logic_vector(0 to C_WIDTH-1);
        Dout     : out std_logic_vector(0 to C_WIDTH-1);
        Load_n   : in  std_logic;
        Cnt_en   : in  std_logic
    );
end component direct_path_cntr;


begin -- architecture IMP
-------------------------------------------------------------------------------
-- Signal assignments to make new IPIC more like original
-------------------------------------------------------------------------------
-- if bursts are enabled, instantiate address counter for read bursts
-- note: this assumes that burst reads will be of OPB_DWIDTH size

BURST_GENERATE: if C_INCLUDE_BURST_SUPPORT=1 generate

  constant DATA_OFFSET          : integer := log2(C_OPB_DWIDTH/8);
  constant BRST_CNT_WIDTH       : integer := C_OPB_AWIDTH - 
                                     addr_bits(C_BASEADDR, C_HIGHADDR);
  constant ZERO_LOW_ADDR_BITS   : std_logic_vector(0 to DATA_OFFSET-1)
                                     := (others => '0');
                                        
  signal burst_cnt       : std_logic_vector(0 to BRST_CNT_WIDTH - DATA_OFFSET -1);
  signal load_n          : std_logic;
  signal burst_rdaddr    : std_logic_vector(0 to C_OPB_AWIDTH-1);

  begin
  
    load_n <= (Bus2IP_Burst and Bus2IP_RNW);
    
    I_BRST_CNT: direct_path_cntr 
       generic map(
                C_WIDTH => BRST_CNT_WIDTH-DATA_OFFSET
              )

      port map (
        Clk           => OPB_Clk,
        Din           => Bus2IP_Addr(C_OPB_AWIDTH-BRST_CNT_WIDTH 
                                        to C_OPB_AWIDTH - DATA_OFFSET -1),
        Cnt_en        => Bus2IP_Burst,
        Load_n        => load_n,
        Dout          => burst_cnt
        );
        
    burst_rdaddr <= Bus2IP_Addr(0 to C_OPB_AWIDTH-BRST_CNT_WIDTH-1) & 
                    burst_cnt & ZERO_LOW_ADDR_BITS;
   
    bram_if_address <= burst_rdaddr;
                        
end generate BURST_GENERATE;

-- If bursts aren't supported, set bram_if_address to Bus2IP_Addr
NOBURST_GENERATE: if C_INCLUDE_BURST_SUPPORT=0 generate
    bram_if_address <= Bus2IP_Addr; 
end generate NOBURST_GENERATE;

-- rdack is simply a registered version of RdCE to account for registered
-- output of BRAMs
IP2BUS_RDACK_PROC: process (Bus2IP_Clk)
begin
    if Bus2IP_Clk'event and Bus2IP_Clk = '1' then
        if Bus2IP_CS(0) = '0' then
            ip2bus_rdack <= '0';
        else
            ip2bus_rdack <= Bus2IP_RdCE(0);
        end if;
    end if;
end process;


IP2Bus_Ack(0) <= ip2bus_rdack or IP2Bus_WrAck after 1 ns;
Bus2IP_RdReq <= Bus2IP_RdCE(0);
Bus2IP_WrReq <= Bus2IP_WrCE(0);

-------------------------------------------------------------------------------
-- Component Instantiations
-------------------------------------------------------------------------------

I_opb_ipif: opb_ipif
  generic map(
      -- Generics to be set for ipif
      C_ARD_ID_ARRAY                 =>   ARD_ID_ARRAY       ,
      C_ARD_ADDR_RANGE_ARRAY         =>   ARD_ADDR_RANGE_ARRAY ,
      C_ARD_DWIDTH_ARRAY             =>   ARD_DWIDTH_ARRAY   ,
      C_ARD_NUM_CE_ARRAY             =>   ARD_NUM_CE_ARRAY   ,
      C_PIPELINE_MODEL               =>   PIPELINE_MODEL     ,
      C_DEV_MIR_ENABLE               =>   0                  ,
      C_AWIDTH                       =>   C_OPB_AWIDTH       ,
      C_DWIDTH                       =>   C_OPB_DWIDTH       ,
      C_IP_INTR_MODE_ARRAY           =>   IP_INTR_MODE_ARRAY ,
      C_INCLUDE_DEV_ISC              =>   0                  ,
      C_DEV_BURST_ENABLE             =>   C_INCLUDE_BURST_SUPPORT
      )
    port map (

        OPB_select             => OPB_select,
        OPB_DBus               => OPB_DBus,
        OPB_ABus               => OPB_ABus,
        OPB_BE                 => OPB_BE,
        OPB_RNW                => OPB_RNW,
        OPB_seqAddr            => OPB_seqAddr,
        OPB_xferAck            => '0',
        Sln_DBus               => Sln_DBus,
        Sln_xferAck            => Sln_xferAck,
        Sln_errAck             => Sln_errAck,
        Sln_retry              => Sln_retry,
        Sln_toutSup            => Sln_toutSup,
        Bus2IP_CS              => Bus2IP_CS,
        Bus2IP_CE              => Bus2IP_CE,
        Bus2IP_RdCE            => Bus2IP_RdCE,
        Bus2IP_WrCE            => Bus2IP_WrCE,
        Bus2IP_Data            => Bus2IP_Data,
        Bus2IP_Addr            => Bus2IP_Addr,
        Bus2IP_RNW             => Bus2IP_RNW,
        Bus2IP_BE              => Bus2IP_BE,
        Bus2IP_Burst           => Bus2IP_Burst,
        IP2Bus_Data            => IP2Bus_Data,
        IP2Bus_Ack             => IP2Bus_Ack,
        IP2Bus_Error           => IP2Bus_errAck,
        IP2Bus_Retry           => IP2Bus_Retry,
        IP2Bus_ToutSup         => IP2Bus_toutSup,
        IP2Bus_PostedWrInh     => ZERO_POSTED_WRINH,
        OPB_Clk                => OPB_Clk,
        Bus2IP_Clk             => Bus2IP_Clk,
        IP2Bus_Clk             => '0',
        Reset                  => OPB_Rst,
        Bus2IP_Reset           => Bus2IP_Reset,
        IP2Bus_Intr            => ZERO_INTR,
        Device_Intr            => open
      );

-------------------------------------------------------------------------------
-- Instantiate BRAM controller
-------------------------------------------------------------------------------

I_BRAM_CONTROLLER: bram_if
  generic map(
       C_IPIF_DWIDTH       => C_OPB_DWIDTH,
       C_IPIF_AWIDTH       => C_OPB_AWIDTH
       )

    port map (

       bus_reset          =>  Bus2IP_Reset,
       bus_clk            =>  Bus2IP_Clk,
       Bus2IP_Addr        =>  bram_if_address,
       Bus2IP_BE          =>  Bus2IP_BE,
       Bus2IP_Data        =>  Bus2IP_Data,
       Bus2IP_RNW         =>  Bus2IP_RNW,
       Bus2IP_WrReq       =>  Bus2IP_WrReq,
       Bus2IP_RdReq       =>  Bus2IP_RdReq,
       Bus2IP_BRAM_CS     =>  Bus2IP_CS(0),

       IP2Bus_Data        => IP2Bus_Data(0 to C_OPB_DWIDTH-1),
       IP2Bus_Error       => IP2Bus_errAck(0),
       IP2Bus_retry       => IP2Bus_retry(0),
       IP2Bus_toutSup     => IP2Bus_toutSup(0),
       IP2Bus_RdAck       => open,      -- use the rdack generated above
       IP2Bus_WrAck       => IP2Bus_WrAck,

       BRAM_Rst        =>   BRAM_Rst,
       BRAM_Clk        =>   BRAM_Clk,
       BRAM_EN         =>   BRAM_EN,
       BRAM_WEN        =>   BRAM_WEN,
       BRAM_Addr       =>   BRAM_Addr,
       BRAM_Din        =>   BRAM_Din,
       BRAM_Dout       =>   BRAM_Dout
       );

end implementation;
