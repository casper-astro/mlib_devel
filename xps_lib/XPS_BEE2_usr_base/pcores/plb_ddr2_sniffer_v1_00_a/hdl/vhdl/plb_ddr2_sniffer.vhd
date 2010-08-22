------------------------------------------------------------------------------
-- plb_ddr2_sniffer.vhd - entity/architecture pair
------------------------------------------------------------------------------
-- IMPORTANT:
-- DO NOT MODIFY THIS FILE EXCEPT IN THE DESIGNATED SECTIONS.
--
-- SEARCH FOR --USER TO DETERMINE WHERE CHANGES ARE ALLOWED.
--
-- TYPICALLY, THE ONLY ACCEPTABLE CHANGES INVOLVE ADDING NEW
-- PORTS AND GENERICS THAT GET PASSED THROUGH TO THE INSTANTIATION
-- OF THE USER_LOGIC ENTITY.
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
-- Filename:          plb_ddr2_sniffer.vhd
-- Version:           1.00.a
-- Description:       Top level design, instantiates IPIF and user logic.
-- Date:              Mon Jul 24 10:48:58 2006 (by Create and Import Peripheral Wizard)
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

library proc_common_v1_00_b;
use proc_common_v1_00_b.proc_common_pkg.all;

library ipif_common_v1_00_b;
use ipif_common_v1_00_b.ipif_pkg.all;
library plb_ipif_v1_00_e;
use plb_ipif_v1_00_e.all;

library plb_ddr2_sniffer_v1_00_a;
use plb_ddr2_sniffer_v1_00_a.all;

------------------------------------------------------------------------------
-- Entity section
------------------------------------------------------------------------------
-- Definition of Generics:
--   C_BASEADDR                   -- User logic base address
--   C_HIGHADDR                   -- User logic high address
--   C_PLB_AWIDTH                 -- PLB address bus width
--   C_PLB_DWIDTH                 -- PLB address data width
--   C_PLB_NUM_MASTERS            -- Number of PLB masters
--   C_PLB_MID_WIDTH              -- log2(C_PLB_NUM_MASTERS)
--   C_FAMILY                     -- Target FPGA architecture
--
-- Definition of Ports:
--   PLB_Clk                      -- PLB Clock
--   PLB_Rst                      -- PLB Reset
--   Sl_addrAck                   -- Slave address acknowledge
--   Sl_MBusy                     -- Slave busy indicator
--   Sl_MErr                      -- Slave error indicator
--   Sl_rdBTerm                   -- Slave terminate read burst transfer
--   Sl_rdComp                    -- Slave read transfer complete indicator
--   Sl_rdDAck                    -- Slave read data acknowledge
--   Sl_rdDBus                    -- Slave read data bus
--   Sl_rdWdAddr                  -- Slave read word address
--   Sl_rearbitrate               -- Slave re-arbitrate bus indicator
--   Sl_SSize                     -- Slave data bus size
--   Sl_wait                      -- Slave wait indicator
--   Sl_wrBTerm                   -- Slave terminate write burst transfer
--   Sl_wrComp                    -- Slave write transfer complete indicator
--   Sl_wrDAck                    -- Slave write data acknowledge
--   PLB_abort                    -- PLB abort request indicator
--   PLB_ABus                     -- PLB address bus
--   PLB_BE                       -- PLB byte enables
--   PLB_busLock                  -- PLB bus lock
--   PLB_compress                 -- PLB compressed data transfer indicator
--   PLB_guarded                  -- PLB guarded transfer indicator
--   PLB_lockErr                  -- PLB lock error indicator
--   PLB_masterID                 -- PLB current master identifier
--   PLB_MSize                    -- PLB master data bus size
--   PLB_ordered                  -- PLB synchronize transfer indicator
--   PLB_PAValid                  -- PLB primary address valid indicator
--   PLB_pendPri                  -- PLB pending request priority
--   PLB_pendReq                  -- PLB pending bus request indicator
--   PLB_rdBurst                  -- PLB burst read transfer indicator
--   PLB_rdPrim                   -- PLB secondary to primary read request indicator
--   PLB_reqPri                   -- PLB current request priority
--   PLB_RNW                      -- PLB read/not write
--   PLB_SAValid                  -- PLB secondary address valid indicator
--   PLB_size                     -- PLB transfer size
--   PLB_type                     -- PLB transfer type
--   PLB_wrBurst                  -- PLB burst write transfer indicator
--   PLB_wrDBus                   -- PLB write data bus
--   PLB_wrPrim                   -- PLB secondary to primary write request indicator
------------------------------------------------------------------------------

entity plb_ddr2_sniffer is
  generic
  (
    -- ADD USER GENERICS BELOW THIS LINE ---------------
    -- ADD USER GENERICS ABOVE THIS LINE ---------------

    -- DO NOT EDIT BELOW THIS LINE ---------------------
    -- Bus protocol parameters, do not add to or delete
    C_BASEADDR                     : std_logic_vector     := X"FFFFFFFF";
    C_HIGHADDR                     : std_logic_vector     := X"00000000";
    C_PLB_AWIDTH                   : integer              := 32;
    C_PLB_DWIDTH                   : integer              := 64;
    C_PLB_NUM_MASTERS              : integer              := 8;
    C_PLB_MID_WIDTH                : integer              := 3;
    C_FAMILY                       : string               := "virtex2p"
    -- DO NOT EDIT ABOVE THIS LINE ---------------------
  );
  port
  (
    -- ADD USER PORTS BELOW THIS LINE ------------------
    -- Clock
    ddr_clk          : in  std_logic;  
    
    -- USER interface
    user_input_data  : in  std_logic_vector(143 downto 0);
    user_byte_enable : in  std_logic_vector(17  downto 0);
    user_get_data    : out std_logic;
    user_output_data : out std_logic_vector(143 downto 0);
    user_data_valid  : out std_logic;
    user_address     : in  std_logic_vector(31  downto 0);
    user_read        : in  std_logic;
    user_write       : in  std_logic;
    user_half_burst  : in  std_logic;
    user_ready       : out std_logic;
    user_reset       : in  std_logic;
    
    -- DDR2 controller ports                       
    ctrl_input_data  : out std_logic_vector(143 downto 0);
    ctrl_byte_enable : out std_logic_vector(17  downto 0);
    ctrl_get_data    : in  std_logic;  
    ctrl_output_data : in  std_logic_vector(143 downto 0);
    ctrl_data_valid  : in  std_logic;  
    ctrl_address     : out std_logic_vector(31  downto 0);
    ctrl_read        : out std_logic;
    ctrl_write       : out std_logic;
    ctrl_half_burst  : out std_logic;
    ctrl_ready       : in  std_logic;
    ctrl_reset       : out std_logic;
    -- ADD USER PORTS ABOVE THIS LINE ------------------

    -- DO NOT EDIT BELOW THIS LINE ---------------------
    -- Bus protocol ports, do not add to or delete
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
    PLB_wrPrim                     : in  std_logic
    -- DO NOT EDIT ABOVE THIS LINE ---------------------
  );

  attribute SIGIS : string;
  attribute SIGIS of PLB_Clk       : signal is "Clk";
  attribute SIGIS of PLB_Rst       : signal is "Rst";

end entity plb_ddr2_sniffer;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

architecture IMP of plb_ddr2_sniffer is

  ------------------------------------------
  -- Constant: array of address range identifiers
  ------------------------------------------
  constant ARD_ID_ARRAY                   : INTEGER_ARRAY_TYPE   :=
    (
      0  => USER_00,                           -- user logic address space
      1  => USER_01
    );

  ------------------------------------------
  -- Constant: array of address pairs for each address range
  ------------------------------------------
  constant ZERO_ADDR_PAD                  : std_logic_vector(0 to 64-C_PLB_AWIDTH-1) := (others => '0');

  constant USER_BASEADDR  : std_logic_vector  := C_BASEADDR;
  constant USER_HIGHADDR  : std_logic_vector  := C_HIGHADDR;

  constant ARD_ADDR_RANGE_ARRAY           : SLV64_ARRAY_TYPE     :=
    (
      X"0000000000000000",
      X"000000003FFFFFFF",
      ZERO_ADDR_PAD & USER_BASEADDR,              -- user logic base address
      ZERO_ADDR_PAD & USER_HIGHADDR               -- user logic high address
    );

  ------------------------------------------
  -- Constant: array of data widths for each target address range
  ------------------------------------------
  constant USER_DWIDTH                    : integer              := C_PLB_DWIDTH;

  constant ARD_DWIDTH_ARRAY               : INTEGER_ARRAY_TYPE   :=
    (
      0  => USER_DWIDTH,                       -- user logic data width
      1  => USER_DWIDTH                        -- user logic data width
    );

  ------------------------------------------
  -- Constant: array of desired number of chip enables for each address range
  ------------------------------------------
  constant USER_NUM_CE                    : integer              := 1;

  constant ARD_NUM_CE_ARRAY               : INTEGER_ARRAY_TYPE   :=
    (
      0  => pad_power2(USER_NUM_CE),          -- user logic number of CEs
      1  => pad_power2(USER_NUM_CE)           -- user logic number of CEs
    );

  ------------------------------------------
  -- Constant: user core ID code
  ------------------------------------------
  constant DEV_BLK_ID                     : integer              := 0;

  ------------------------------------------
  -- Constant: enable MIR/Reset register
  ------------------------------------------
  constant DEV_MIR_ENABLE                 : boolean              := false;

  ------------------------------------------
  -- Constant: enable burst support
  ------------------------------------------
  constant DEV_BURST_ENABLE               : boolean              := false;

  ------------------------------------------
  -- Constant: use fast transfer protocol for burst and cacheline
  ------------------------------------------
  constant DEV_FAST_DATA_XFER             : boolean              := false;

  ------------------------------------------
  -- Constant: max burst size in bytes - reserved
  ------------------------------------------
  constant DEV_MAX_BURST_SIZE             : integer              := 64;

  ------------------------------------------
  -- Constant: size of the largest target burstable memory space in bytes - reserved
  ------------------------------------------
  constant DEV_BURST_PAGE_SIZE            : integer              := 1024;

  ------------------------------------------
  -- Constant: dataphase timeout value for IPIF
  ------------------------------------------
  constant DEV_DPHASE_TIMEOUT             : integer              := 64;

  ------------------------------------------
  -- Constant: include device interrupt source controller
  ------------------------------------------
  constant INCLUDE_DEV_ISC                : boolean              := false;

  ------------------------------------------
  -- Constant: include IPIF ISC priority encoder
  ------------------------------------------
  constant INCLUDE_DEV_PENCODER           : boolean              := false;

  ------------------------------------------
  -- Constant: array of IP interrupt mode
  -- 1 = Level Pass through (non-inverted)
  -- 2 = Level Pass through (invert input)
  -- 3 = Registered Event (non-inverted)
  -- 4 = Registered Event (inverted input)
  -- 5 = Rising Edge Detect
  -- 6 = Falling Edge Detect
  ------------------------------------------
  constant IP_INTR_MODE_ARRAY             : INTEGER_ARRAY_TYPE   :=
    (
      0  => 0  -- not used
    );

  ------------------------------------------
  -- Constant: include PLB master service - reserved
  ------------------------------------------
  constant IP_MASTER_PRESENT              : boolean              := false;

  ------------------------------------------
  -- Constant: write FIFO depth
  ------------------------------------------
  constant WRFIFO_DEPTH                   : integer              := 512;

  ------------------------------------------
  -- Constant: include write FIFO packet mode service
  ------------------------------------------
  constant WRFIFO_INCLUDE_PACKET_MODE     : boolean              := false;

  ------------------------------------------
  -- Constant: include write FIFO vacancy status
  ------------------------------------------
  constant WRFIFO_INCLUDE_VACANCY         : boolean              := true;

  ------------------------------------------
  -- Constant: read FIFO depth
  ------------------------------------------
  constant RDFIFO_DEPTH                   : integer              := 512;

  ------------------------------------------
  -- Constant: include read FIFO packet mode service
  ------------------------------------------
  constant RDFIFO_INCLUDE_PACKET_MODE     : boolean              := false;

  ------------------------------------------
  -- Constant: include read FIFO vacancy status
  ------------------------------------------
  constant RDFIFO_INCLUDE_VACANCY         : boolean              := true;

  ------------------------------------------
  -- Constant: PLB clock period in ps - reserved
  ------------------------------------------
  constant PLB_CLK_PERIOD_PS              : integer              := 10000;

  ------------------------------------------
  -- Constant: index for CS/CE
  ------------------------------------------
  constant USER00_CS_INDEX                : integer              := get_id_index(ARD_ID_ARRAY, USER_00);
  constant USER01_CS_INDEX                : integer              := get_id_index(ARD_ID_ARRAY, USER_01);

  constant USER00_CE_INDEX                : integer              := calc_start_ce_index(ARD_NUM_CE_ARRAY, USER00_CS_INDEX);
  constant USER01_CE_INDEX                : integer              := calc_start_ce_index(ARD_NUM_CE_ARRAY, USER01_CS_INDEX);

  ------------------------------------------
  -- IP Interconnect (IPIC) signal declarations -- do not delete
  -- prefix 'i' stands for IPIF while prefix 'u' stands for user logic
  -- typically user logic will be hooked up to IPIF directly via i<sig>
  -- unless signal slicing and muxing are needed via u<sig>
  ------------------------------------------
  signal ZERO_PLB_MSSize                : std_logic_vector(0 to 1)   := (others => '0'); -- work around for XST not taking (others => '0') in port mapping
  signal ZERO_PLB_MRdDBus               : std_logic_vector(0 to (C_PLB_DWIDTH-1))   := (others => '0'); -- work around for XST not taking (others => '0') in port mapping
  signal ZERO_PLB_MRdWdAddr             : std_logic_vector(0 to 3)   := (others => '0'); -- work around for XST not taking (others => '0') in port mapping
  signal iBus2IP_Clk                    : std_logic;
  signal iBus2IP_Reset                  : std_logic;
  signal ZERO_IP2Bus_IntrEvent          : std_logic_vector(0 to IP_INTR_MODE_ARRAY'length - 1)   := (others => '0'); -- work around for XST not taking (others => '0') in port mapping
  signal iIP2Bus_Data                   : std_logic_vector(0 to C_PLB_DWIDTH-1)   := (others => '0');
  signal iIP2Bus_WrAck                  : std_logic   := '0';
  signal iIP2Bus_RdAck                  : std_logic   := '0';
  signal iIP2Bus_Retry                  : std_logic   := '0';
  signal iIP2Bus_Error                  : std_logic   := '0';
  signal iIP2Bus_ToutSup                : std_logic   := '0';
  signal iIP2Bus_Busy                   : std_logic   := '0';
  signal iBus2IP_Addr                   : std_logic_vector(0 to C_PLB_AWIDTH - 1);
  signal iBus2IP_Data                   : std_logic_vector(0 to C_PLB_DWIDTH - 1);
  signal iBus2IP_BE                     : std_logic_vector(0 to (C_PLB_DWIDTH/8) - 1);
  signal iBus2IP_WrReq                  : std_logic;
  signal iBus2IP_RdReq                  : std_logic;
  signal iBus2IP_RNW                    : std_logic;
  signal ZERO_IP2Bus_Addr               : std_logic_vector(0 to C_PLB_AWIDTH - 1)   := (others => '0'); -- work around for XST not taking (others => '0') in port mapping
  signal ZERO_IP2Bus_MstBE              : std_logic_vector(0 to (C_PLB_DWIDTH/8) - 1)   := (others => '0'); -- work around for XST not taking (others => '0') in port mapping
  signal ZERO_IP2IP_Addr                : std_logic_vector(0 to C_PLB_AWIDTH - 1)   := (others => '0'); -- work around for XST not taking (others => '0') in port mapping
  signal ZERO_IP2RFIFO_Data             : std_logic_vector(0 to find_id_dwidth(ARD_ID_ARRAY, ARD_DWIDTH_ARRAY, IPIF_RDFIFO_DATA, C_PLB_DWIDTH)-1)   := (others => '0'); -- work around for XST not taking (others => '0') in port mapping
  signal uBus2IP_Data                   : std_logic_vector(0 to USER_DWIDTH-1);
  signal uBus2IP_BE                     : std_logic_vector(0 to USER_DWIDTH/8-1);
  signal uBus2IP_RdCE                   : std_logic_vector(0 to USER_NUM_CE-1);
  signal uBus2IP_WrCE                   : std_logic_vector(0 to USER_NUM_CE-1);
  signal uIP2Bus_Data                   : std_logic_vector(0 to USER_DWIDTH-1);
  signal iBus2IP_CS                     : std_logic_vector(0 to ((ARD_ADDR_RANGE_ARRAY'LENGTH)/2)-1);

begin

  ------------------------------------------
  -- instantiate the PLB IPIF
  ------------------------------------------
  PLB_IPIF_I : entity plb_ipif_v1_00_e.plb_ipif
    generic map
    (
      C_ARD_ID_ARRAY                 => ARD_ID_ARRAY,
      C_ARD_ADDR_RANGE_ARRAY         => ARD_ADDR_RANGE_ARRAY,
      C_ARD_DWIDTH_ARRAY             => ARD_DWIDTH_ARRAY,
      C_ARD_NUM_CE_ARRAY             => ARD_NUM_CE_ARRAY,
      C_DEV_BLK_ID                   => DEV_BLK_ID,
      C_DEV_MIR_ENABLE               => DEV_MIR_ENABLE,
      C_DEV_BURST_ENABLE             => DEV_BURST_ENABLE,
      C_DEV_FAST_DATA_XFER           => DEV_FAST_DATA_XFER,
      C_DEV_MAX_BURST_SIZE           => DEV_MAX_BURST_SIZE,
      C_DEV_BURST_PAGE_SIZE          => DEV_BURST_PAGE_SIZE,
      C_DEV_DPHASE_TIMEOUT           => DEV_DPHASE_TIMEOUT,
      C_INCLUDE_DEV_ISC              => INCLUDE_DEV_ISC,
      C_INCLUDE_DEV_PENCODER         => INCLUDE_DEV_PENCODER,
      C_IP_INTR_MODE_ARRAY           => IP_INTR_MODE_ARRAY,
      C_IP_MASTER_PRESENT            => IP_MASTER_PRESENT,
      C_WRFIFO_DEPTH                 => WRFIFO_DEPTH,
      C_WRFIFO_INCLUDE_PACKET_MODE   => WRFIFO_INCLUDE_PACKET_MODE,
      C_WRFIFO_INCLUDE_VACANCY       => WRFIFO_INCLUDE_VACANCY,
      C_RDFIFO_DEPTH                 => RDFIFO_DEPTH,
      C_RDFIFO_INCLUDE_PACKET_MODE   => RDFIFO_INCLUDE_PACKET_MODE,
      C_RDFIFO_INCLUDE_VACANCY       => RDFIFO_INCLUDE_VACANCY,
      C_PLB_MID_WIDTH                => C_PLB_MID_WIDTH,
      C_PLB_NUM_MASTERS              => C_PLB_NUM_MASTERS,
      C_PLB_AWIDTH                   => C_PLB_AWIDTH,
      C_PLB_DWIDTH                   => C_PLB_DWIDTH,
      C_PLB_CLK_PERIOD_PS            => PLB_CLK_PERIOD_PS,
      C_IPIF_DWIDTH                  => C_PLB_DWIDTH,
      C_IPIF_AWIDTH                  => C_PLB_AWIDTH,
      C_FAMILY                       => C_FAMILY
    )
    port map
    (
      PLB_clk                        => PLB_Clk,
      Reset                          => PLB_Rst,
      Freeze                         => '0',
      IP2INTC_Irpt                   => open,
      PLB_ABus                       => PLB_ABus,
      PLB_PAValid                    => PLB_PAValid,
      PLB_SAValid                    => PLB_SAValid,
      PLB_rdPrim                     => PLB_rdPrim,
      PLB_wrPrim                     => PLB_wrPrim,
      PLB_masterID                   => PLB_masterID,
      PLB_abort                      => PLB_abort,
      PLB_busLock                    => PLB_busLock,
      PLB_RNW                        => PLB_RNW,
      PLB_BE                         => PLB_BE,
      PLB_MSize                      => PLB_MSize,
      PLB_size                       => PLB_size,
      PLB_type                       => PLB_type,
      PLB_compress                   => PLB_compress,
      PLB_guarded                    => PLB_guarded,
      PLB_ordered                    => PLB_ordered,
      PLB_lockErr                    => PLB_lockErr,
      PLB_wrDBus                     => PLB_wrDBus,
      PLB_wrBurst                    => PLB_wrBurst,
      PLB_rdBurst                    => PLB_rdBurst,
      PLB_pendReq                    => PLB_pendReq,
      PLB_pendPri                    => PLB_pendPri,
      PLB_reqPri                     => PLB_reqPri,
      Sl_addrAck                     => Sl_addrAck,
      Sl_SSize                       => Sl_SSize,
      Sl_wait                        => Sl_wait,
      Sl_rearbitrate                 => Sl_rearbitrate,
      Sl_wrDAck                      => Sl_wrDAck,
      Sl_wrComp                      => Sl_wrComp,
      Sl_wrBTerm                     => Sl_wrBTerm,
      Sl_rdDBus                      => Sl_rdDBus,
      Sl_rdWdAddr                    => Sl_rdWdAddr,
      Sl_rdDAck                      => Sl_rdDAck,
      Sl_rdComp                      => Sl_rdComp,
      Sl_rdBTerm                     => Sl_rdBTerm,
      Sl_MBusy                       => Sl_MBusy,
      Sl_MErr                        => Sl_MErr,
      PLB_MAddrAck                   => '0',
      PLB_MSSize                     => ZERO_PLB_MSSize,
      PLB_MRearbitrate               => '0',
      PLB_MBusy                      => '0',
      PLB_MErr                       => '0',
      PLB_MWrDAck                    => '0',
      PLB_MRdDBus                    => ZERO_PLB_MRdDBus,
      PLB_MRdWdAddr                  => ZERO_PLB_MRdWdAddr,
      PLB_MRdDAck                    => '0',
      PLB_MRdBTerm                   => '0',
      PLB_MWrBTerm                   => '0',
      M_request                      => open,
      M_priority                     => open,
      M_busLock                      => open,
      M_RNW                          => open,
      M_BE                           => open,
      M_MSize                        => open,
      M_size                         => open,
      M_type                         => open,
      M_compress                     => open,
      M_guarded                      => open,
      M_ordered                      => open,
      M_lockErr                      => open,
      M_abort                        => open,
      M_ABus                         => open,
      M_wrDBus                       => open,
      M_wrBurst                      => open,
      M_rdBurst                      => open,
      IP2Bus_Clk                     => '0',
      Bus2IP_Clk                     => iBus2IP_Clk,
      Bus2IP_Reset                   => iBus2IP_Reset,
      Bus2IP_Freeze                  => open,
      IP2Bus_IntrEvent               => ZERO_IP2Bus_IntrEvent,
      IP2Bus_Data                    => iIP2Bus_Data,
      IP2Bus_WrAck                   => iIP2Bus_WrAck,
      IP2Bus_RdAck                   => iIP2Bus_RdAck,
      IP2Bus_Retry                   => iIP2Bus_Retry,
      IP2Bus_Error                   => iIP2Bus_Error,
      IP2Bus_ToutSup                 => iIP2Bus_ToutSup,
      IP2Bus_PostedWrInh             => '0',
      IP2Bus_Busy                    => iIP2Bus_Busy,
      IP2Bus_AddrAck                 => '0',
      IP2Bus_BTerm                   => '0',
      Bus2IP_Addr                    => iBus2IP_Addr,
      Bus2IP_Data                    => iBus2IP_Data,
      Bus2IP_RNW                     => iBus2IP_RNW,
      Bus2IP_BE                      => iBus2IP_BE,
      Bus2IP_Burst                   => open,
      Bus2IP_IBurst                  => open,
      Bus2IP_WrReq                   => iBus2IP_WrReq,
      Bus2IP_RdReq                   => iBus2IP_RdReq,
      Bus2IP_RNW_Early               => open,
      Bus2IP_PselHit                 => open,
      Bus2IP_CS                      => iBus2IP_CS,
      Bus2IP_CE                      => open,
      Bus2IP_RdCE                    => open,
      Bus2IP_WrCE                    => open,
      IP2DMA_RxLength_Empty          => '0',
      IP2DMA_RxStatus_Empty          => '0',
      IP2DMA_TxLength_Full           => '0',
      IP2DMA_TxStatus_Empty          => '0',
      IP2Bus_Addr                    => ZERO_IP2Bus_Addr,
      IP2Bus_MstBE                   => ZERO_IP2Bus_MstBE,
      IP2IP_Addr                     => ZERO_IP2IP_Addr,
      IP2Bus_MstWrReq                => '0',
      IP2Bus_MstRdReq                => '0',
      IP2Bus_MstBurst                => '0',
      IP2Bus_MstBusLock              => '0',
      Bus2IP_MstWrAck                => open,
      Bus2IP_MstRdAck                => open,
      Bus2IP_MstRetry                => open,
      Bus2IP_MstError                => open,
      Bus2IP_MstTimeOut              => open,
      Bus2IP_MstLastAck              => open,
      IP2RFIFO_WrReq                 => '0',
      IP2RFIFO_Data                  => ZERO_IP2RFIFO_Data,
      IP2RFIFO_WrMark                => '0',
      IP2RFIFO_WrRelease             => '0',
      IP2RFIFO_WrRestore             => '0',
      RFIFO2IP_WrAck                 => open,
      RFIFO2IP_AlmostFull            => open,
      RFIFO2IP_Full                  => open,
      RFIFO2IP_Vacancy               => open,
      IP2WFIFO_RdReq                 => '0',
      IP2WFIFO_RdMark                => '0',
      IP2WFIFO_RdRelease             => '0',
      IP2WFIFO_RdRestore             => '0',
      WFIFO2IP_Data                  => open,
      WFIFO2IP_RdAck                 => open,
      WFIFO2IP_AlmostEmpty           => open,
      WFIFO2IP_Empty                 => open,
      WFIFO2IP_Occupancy             => open,
      IP2Bus_DMA_Req                 => '0',
      Bus2IP_DMA_Ack                 => open
    );

  ------------------------------------------
  -- instantiate the User Logic
  ------------------------------------------
  USER_LOGIC_I : entity plb_ddr2_sniffer_v1_00_a.user_logic
    generic map
    (
      -- MAP USER GENERICS BELOW THIS LINE ---------------
      -- MAP USER GENERICS ABOVE THIS LINE ---------------

      C_DWIDTH                       => USER_DWIDTH,
      C_AWIDTH                       => C_PLB_AWIDTH
    )
    port map
    (
      -- MAP USER PORTS BELOW THIS LINE ------------------
      ddr_clk                        => ddr_clk,
      user_input_data                => user_input_data,
      user_byte_enable               => user_byte_enable,
      user_get_data                  => user_get_data,
      user_output_data               => user_output_data,
      user_data_valid                => user_data_valid,
      user_address                   => user_address,
      user_read                      => user_read,
      user_write                     => user_write,
      user_half_burst                => user_half_burst,
      user_ready                     => user_ready,
      user_reset                     => user_reset,
      ctrl_input_data                => ctrl_input_data,
      ctrl_byte_enable               => ctrl_byte_enable,
      ctrl_get_data                  => ctrl_get_data,
      ctrl_output_data               => ctrl_output_data,
      ctrl_data_valid                => ctrl_data_valid,
      ctrl_address                   => ctrl_address,
      ctrl_read                      => ctrl_read,
      ctrl_write                     => ctrl_write,
      ctrl_half_burst                => ctrl_half_burst,
      ctrl_ready                     => ctrl_ready,
      ctrl_reset                     => ctrl_reset,
      -- MAP USER PORTS ABOVE THIS LINE ------------------

      Bus2IP_Clk                     => iBus2IP_Clk,
      Bus2IP_Reset                   => iBus2IP_Reset,
      Bus2IP_Addr                    => iBus2IP_Addr,
      Bus2IP_Data                    => uBus2IP_Data,
      Bus2IP_BE                      => uBus2IP_BE,
      Bus2IP_CS                      => iBus2IP_CS,
      Bus2IP_RdReq                   => iBus2IP_RdReq,
      Bus2IP_WrReq                   => iBus2IP_WrReq,
      Bus2IP_RNW                     => iBus2IP_RNW,
      IP2Bus_Data                    => uIP2Bus_Data,
      IP2Bus_Retry                   => iIP2Bus_Retry,
      IP2Bus_Error                   => iIP2Bus_Error,
      IP2Bus_ToutSup                 => iIP2Bus_ToutSup,
      IP2Bus_Busy                    => iIP2Bus_Busy,
      IP2Bus_RdAck                   => iIP2Bus_RdAck,
      IP2Bus_WrAck                   => iIP2Bus_WrAck
    );

  ------------------------------------------
  -- hooking up signal slicing
  ------------------------------------------
  uBus2IP_BE <= iBus2IP_BE(0 to USER_DWIDTH/8-1);
  uBus2IP_Data <= iBus2IP_Data(0 to USER_DWIDTH-1);
  iIP2Bus_Data(0 to USER_DWIDTH-1) <= uIP2Bus_Data;

end IMP;
