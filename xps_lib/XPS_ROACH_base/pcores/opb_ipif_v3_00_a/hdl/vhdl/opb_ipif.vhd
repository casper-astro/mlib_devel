-- $Id: opb_ipif.vhd,v 1.2 2004/05/05 23:12:12 gburch Exp $
-------------------------------------------------------------------------------
-- opb_ipif.vhd
-------------------------------------------------------------------------------
--
--                  ****************************
--                  ** Copyright Xilinx, Inc. **
--                  ** All rights reserved.   **
--                  ****************************
--
-------------------------------------------------------------------------------
-- Filename:        opb_ipif.vhd
--
-- Description:     Simple slave OPB IPIF, OPB to IPIC.
--                   
--
-------------------------------------------------------------------------------
-- Structure:       opb_ipif
--                  opb_ipif
--                      -- opb_bam
--                          -- reset_mir
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- @BEGIN_CHANGELOG EDK_Gm_SP2
--
--  Fixed problem with double clock wrce to interrupt control which caused
--  an interrupt to be generated when a user cleared an already pending 
--  interrupt.
--  
-- @END_CHANGELOG
-------------------------------------------------------------------------------
-- Author:      Farrell Ostler
--
-- History:
--
--      FLO     05/19/03
-- ^^^^^^
--      Initial version.
-- ~~~~~~
--      GAB     05/05/04
-- ^^^^^^
--      Added change log.
--      Fixed interrupt control double clock wrce
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
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ipif_common_v1_00_c;
use ipif_common_v1_00_c.ipif_pkg.INTEGER_ARRAY_TYPE;
use ipif_common_v1_00_c.ipif_pkg.SLV64_ARRAY_TYPE;
use ipif_common_v1_00_c.ipif_pkg.calc_num_ce;
use ipif_common_v1_00_c.ipif_pkg.calc_start_ce_index;
use ipif_common_v1_00_c.ipif_pkg.DEPENDENT_PROPS_ARRAY_TYPE;
use ipif_common_v1_00_c.ipif_pkg.get_min_dwidth;
use ipif_common_v1_00_c.ipif_pkg.IPIF_INTR;
use ipif_common_v1_00_c.ipif_pkg.IPIF_RST;
use ipif_common_v1_00_c.ipif_pkg.USER_00;

library opb_ipif_v3_00_a;
use opb_ipif_v3_00_a.all;

-----------------------------------------------------------------------------
-- Entity section
-----------------------------------------------------------------------------

entity opb_ipif is
  generic
  (
    C_ARD_ID_ARRAY              : INTEGER_ARRAY_TYPE         := ( 0 => IPIF_INTR, 1 => IPIF_RST, 2 => USER_00 );
    C_ARD_ADDR_RANGE_ARRAY      : SLV64_ARRAY_TYPE           := ( x"0000_0000_6000_0000", x"0000_0000_6000_003F", x"0000_0000_6000_0040", x"0000_0000_6000_0043", x"0000_0000_6000_0100", x"0000_0000_6000_01FF" );
    C_ARD_DWIDTH_ARRAY          : INTEGER_ARRAY_TYPE         := ( 32, 32, 32 );
    C_ARD_NUM_CE_ARRAY          : INTEGER_ARRAY_TYPE         := ( 16, 1, 8 );
    C_ARD_DEPENDENT_PROPS_ARRAY : DEPENDENT_PROPS_ARRAY_TYPE := ( 0 => (others => 0) ,1 => (others => 0) ,2 => (others => 0) );
    C_PIPELINE_MODEL            : integer                    := 7;
    C_DEV_BLK_ID                : INTEGER                    := 1;
    C_DEV_MIR_ENABLE            : INTEGER                    := 0;
    C_AWIDTH                    : INTEGER                    := 32;
    C_DWIDTH                    : INTEGER                    := 32;
    C_FAMILY                    : string                     := "virtexe";
    C_IP_INTR_MODE_ARRAY        : INTEGER_ARRAY_TYPE         := ( 5, 1 );
    C_INCLUDE_DEV_ISC           : INTEGER                    := 1;
    C_INCLUDE_DEV_IID           : integer                    := 0;
    C_DEV_BURST_ENABLE          : INTEGER                    := 0
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
end entity opb_ipif;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------
architecture imp of opb_ipif is

  component opb_bam is
    generic
    (
      C_ARD_ID_ARRAY              : INTEGER_ARRAY_TYPE         := ( 0 => IPIF_INTR, 1 => IPIF_RST, 2 => USER_00 );
      C_ARD_ADDR_RANGE_ARRAY      : SLV64_ARRAY_TYPE           := ( x"0000_0000_6000_0000", x"0000_0000_6000_003F", x"0000_0000_6000_0040", x"0000_0000_6000_0043", x"0000_0000_6000_0100", x"0000_0000_6000_01FF" );
      C_ARD_DWIDTH_ARRAY          : INTEGER_ARRAY_TYPE         := ( 32, 32, 32 );
      C_ARD_NUM_CE_ARRAY          : INTEGER_ARRAY_TYPE         := ( 16, 1, 8 );
      C_ARD_DEPENDENT_PROPS_ARRAY : DEPENDENT_PROPS_ARRAY_TYPE := ( 0 => (others => 0) ,1 => (others => 0) ,2 => (others => 0) );
      C_PIPELINE_MODEL            : integer                    := 7;
      C_DEV_BLK_ID                : INTEGER                    := 1;
      C_DEV_MIR_ENABLE            : INTEGER                    := 0;
      C_AWIDTH                    : INTEGER                    := 32;
      C_DWIDTH                    : INTEGER                    := 32;
      C_FAMILY                    : string                     := "virtexe";
      C_IP_INTR_MODE_ARRAY        : INTEGER_ARRAY_TYPE         := ( 5, 1 );
      C_INCLUDE_DEV_ISC           : INTEGER                    := 1;
      C_INCLUDE_DEV_IID           : integer                    := 0;
      C_DEV_BURST_ENABLE          : INTEGER                    := 0
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
  end component opb_bam;

begin  ------------------------------------------------------------------------

  OPB_BAM_I : opb_bam
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
      C_AWIDTH                    => C_AWIDTH,
      C_DWIDTH                    => C_DWIDTH,
      C_FAMILY                    => C_FAMILY,
      C_IP_INTR_MODE_ARRAY        => C_IP_INTR_MODE_ARRAY,
      C_INCLUDE_DEV_ISC           => C_INCLUDE_DEV_ISC,
      C_INCLUDE_DEV_IID           => C_INCLUDE_DEV_IID,
      C_DEV_BURST_ENABLE          => C_DEV_BURST_ENABLE
    )
    port map
    (
      OPB_select         => OPB_select,
      OPB_DBus           => OPB_DBus,
      OPB_ABus           => OPB_ABus,
      OPB_BE             => OPB_BE,
      OPB_RNW            => OPB_RNW,
      OPB_seqAddr        => OPB_seqAddr,
      OPB_xferAck        => OPB_xferAck,
      Sln_DBus           => Sln_DBus,
      Sln_xferAck        => Sln_xferAck,
      Sln_errAck         => Sln_errAck,
      Sln_retry          => Sln_retry,
      Sln_toutSup        => Sln_toutSup,
      Bus2IP_CS          => Bus2IP_CS,
      Bus2IP_CE          => Bus2IP_CE,
      Bus2IP_RdCE        => Bus2IP_RdCE,
      Bus2IP_WrCE        => Bus2IP_WrCE,
      Bus2IP_Data        => Bus2IP_Data,
      Bus2IP_Addr        => Bus2IP_Addr,
      Bus2IP_BE          => Bus2IP_BE,
      Bus2IP_RNW         => Bus2IP_RNW,
      Bus2IP_Burst       => Bus2IP_Burst,
      IP2Bus_Data        => IP2Bus_Data,
      IP2Bus_Ack         => IP2Bus_Ack,
      IP2Bus_Error       => IP2Bus_Error,
      IP2Bus_Retry       => IP2Bus_Retry,
      IP2Bus_ToutSup     => IP2Bus_ToutSup,
      IP2Bus_PostedWrInh => IP2Bus_PostedWrInh,
      OPB_Clk            => OPB_Clk,
      Bus2IP_Clk         => Bus2IP_Clk,
      IP2Bus_Clk         => IP2Bus_Clk,
      Reset              => Reset,
      Bus2IP_Reset       => Bus2IP_Reset,
      IP2Bus_Intr        => IP2Bus_Intr,
      Device_Intr        => Device_Intr
    );

end architecture imp;

