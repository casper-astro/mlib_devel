-------------------------------------------------------------------------------
-- $Id: dma_sg.vhd,v 1.4 2003/04/28 20:49:28 ostlerf Exp $
-------------------------------------------------------------------------------
-- dma_sg entity (DMA and scatter gather)
-------------------------------------------------------------------------------
--
--                  ****************************
--                  ** Copyright Xilinx, Inc. **
--                  ** All rights reserved.   **
--                  ****************************
--
-------------------------------------------------------------------------------
-- Filename:        dma_sg.vhd
--
-- Description:     Entity declaration for dma_sg.
--                  This entity defines a DMA capability that is intended
--                  for embodiement inside the IPIF (IP Interface).
--
--                  Four types of DMA channels are available:
--                    (1) Simple DMA
--                    (2) Scatter gather DMA
--                    (3) Scatter gather packet transmit
--                    (4) Scatter gather packet receive
--
--                  An arbitrary number of channels, each of any of the types,
--                  may be included in an instantiation through appropriate
--                  generic settings.
--
--                  Packet transmit and receive channels may be outfitted with
--                  optional interrupt-coalescing support.
--
--                  The maximum length of DMA transfers is user selectable and
--                  using the smallest feasible value may reduce FPGA resource
--                  usage.
--
-------------------------------------------------------------------------------
-- Structure: 
--
--              dma_sg.vhds
--                  dma_sg_pkg.vhds
--
-------------------------------------------------------------------------------
-- Author:      Farrell Ostler
-- History:
--      FLO     12/19/01        -- Header added
--                              -- Channels fixed at two for this version
--                              -- to allow XST E.33 compatibility.
--
--      FLO     06/07/02        -- Added generic C_WFIFO_VACANCY_WIDTH.
--
--  FLO      01/30/03
-- ^^^^^^
--  Fixed Bus2IP_Data and DMA2Bus_Data at 32 bits, 0 to 31.
--  Fixed Bus2IP_BE 4 bits, 0 to 3.
-- ~~~~~~
--
--  FLO      03/02/03
-- ^^^^^^
--  Added signal DMA2Bus_MstLoc2Loc.
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

library ipif_common_v1_00_c;
use ipif_common_v1_00_c.ipif_pkg.SLV64_ARRAY_TYPE;
use ipif_common_v1_00_c.ipif_pkg.INTEGER_ARRAY_TYPE;

library proc_common_v1_00_b;
use proc_common_v1_00_b.proc_common_pkg.log2;

entity dma_sg is
-- Four channel, 0123, simple sg tx rx coalesc.
    generic (
      C_OPB_DWIDTH : natural := 32;  --  Width of data bus (32, 64).
      C_OPB_AWIDTH : natural := 32;  --  width of Bus addr.
      C_IPIF_ABUS_WIDTH : natural :=15;

      C_CLK_PERIOD_PS : integer := 16000; --ps  Period of Bus2IP_Clk.

      -- The time unit, in nanoseconds, that applies to
      -- the Packet Wait Bound register. The specified value of this
      -- generic is 1,000,000 (1 ms), but a smaller value can be used for
      -- simulations. 
      C_PACKET_WAIT_UNIT_NS : integer := 1000000; --ns
    
      C_DMA_CHAN_TYPE         -- 0=simple, 1=sg, 2=tx, 3=rx
       : INTEGER_ARRAY_TYPE
       :=                    (    0,    1,    2,    3  );
    
      -- The leftmost defined bit of the LENGTH field, assuming
      -- big endian bit numbering and a LSB at bit 31.
      -- If the channel is a packet channel, it is assumed that
      -- the number bits defined in the LENGTH register is also
      -- enough bits to hold the length of a maximum sized packet.
      -- ToDo, current impl requires all channels to be the same length.
      C_DMA_LENGTH_WIDTH
       : INTEGER_ARRAY_TYPE
       :=                    (   11,   11,   11,  11  );
    
      C_LEN_FIFO_ADDR
       : SLV64_ARRAY_TYPE
       :=                    (   X"0000_0000_0000_0000",
                                       X"0000_0000_0000_0000",
                                             X"0000_0000_0000_3800",
                                                  X"0000_0000_0000_4800" );
  
      C_STAT_FIFO_ADDR
       : SLV64_ARRAY_TYPE
       :=                    (   X"0000_0000_0000_0000",
                                       X"0000_0000_0000_0000",
                                             X"0000_0000_0000_3804",
                                                  X"0000_0000_0000_4804" );

      C_INTR_COALESCE
       : INTEGER_ARRAY_TYPE
       :=                    (  0,  0,  1,  1  );
    
      C_DEV_BLK_ID  : integer := 0;

      C_DMA_BASEADDR : std_logic_vector
                := X"0000_0000_0000_0000";

      C_DMA_ALLOW_BURST : boolean := true;

      C_MA2SA_NUM_WIDTH : INTEGER := 4;  

      C_WFIFO_VACANCY_WIDTH : integer := 10
    );
    port (
          DMA2Bus_Data : out std_logic_vector(0 to 31);
          DMA2Bus_Addr : out std_logic_vector(0 to C_OPB_AWIDTH-1 );
          DMA2Bus_MstBE : out std_logic_vector(0 to C_OPB_DWIDTH/8 - 1);
          DMA2Bus_MstWrReq : out std_logic;
          DMA2Bus_MstRdReq : out std_logic;
          DMA2Bus_MstNum : out std_logic_vector(0 to C_MA2SA_NUM_WIDTH-1);
          DMA2Bus_MstBurst : out std_logic;
          DMA2Bus_MstBusLock : out std_logic;
          DMA2Bus_MstLoc2Loc : out std_logic;
          DMA2IP_Addr : out std_logic_vector(0 to C_IPIF_ABUS_WIDTH-3);
          DMA2Bus_WrAck : out std_logic;
          DMA2Bus_RdAck : out std_logic;
          DMA2Bus_Retry : out std_logic;
          DMA2Bus_Error : out std_logic;
          DMA2Bus_ToutSup : out std_logic;
          Bus2IP_MstWrAck : in std_logic;
          Bus2IP_MstRdAck : in std_logic;
          Mstr_sel_ma : in std_logic;
          Bus2IP_MstRetry : in std_logic;
          Bus2IP_MstError : in std_logic;
          Bus2IP_MstTimeOut : in std_logic;
          Bus2IP_BE : in std_logic_vector(0 to 3);
          Bus2IP_WrReq : in std_logic;
          Bus2IP_RdReq : in std_logic;
          Bus2IP_Clk : in std_logic;
          Bus2IP_Reset : in std_logic;
          Bus2IP_Freeze : in std_logic;
          Bus2IP_Addr : in std_logic_vector(0 to C_IPIF_ABUS_WIDTH-3);
          Bus2IP_Data : in std_logic_vector(0 to 31);
          Bus2IP_Burst : in std_logic;
          WFIFO2DMA_Vacancy : in std_logic_vector(0 to C_WFIFO_VACANCY_WIDTH-1);
          Bus2IP_MstLastAck : in std_logic;
          DMA_RdCE : in std_logic;
          DMA_WrCE : in std_logic;
          IP2DMA_RxStatus_Empty : in std_logic;
          IP2DMA_RxLength_Empty : in std_logic;
          IP2DMA_TxStatus_Empty : in std_logic;
          IP2DMA_TxLength_Full : in std_logic;
          IP2Bus_DMA_Req : in std_logic;
          Bus2IP_DMA_Ack : out std_logic;
          DMA2Intr_Intr  : out std_logic_vector(0 to C_DMA_CHAN_TYPE'length-1)
    );

end dma_sg;




