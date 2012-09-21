-------------------------------------------------------------------------------
-- $Id: dma_sg_cmp.vhd,v 1.2 2003/03/12 01:04:29 ostlerf Exp $
-------------------------------------------------------------------------------
-- Package with component declarations to support the DMA Scatter/Gather entity
-------------------------------------------------------------------------------
--
--                  ****************************
--                  ** Copyright Xilinx, Inc. **
--                  ** All rights reserved.   **
--                  ****************************
--
-------------------------------------------------------------------------------
-- Filename:        dma_sg_cmp.vhd
--
-- Description:     Components instantiated within dma_sg are declared here.
--
-------------------------------------------------------------------------------
-- Structure: 
--
--              dma_sg_cmp.vhds
--                  dma_sg_pkg.vhds
--
-------------------------------------------------------------------------------
-- Author:      Farrell Ostler
-- History:
--      FLO     12/19/01        -- Header added
--
--  FLO      01/30/03
-- ^^^^^^
--  Changed the dma_sg component to correspond to a changes made to the entity
-- when fixed DMASG as a 32-bit device.
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

package dma_sg_cmp is

component dma_sg is

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
      C_PACKET_WAIT_UNIT_NS : integer := 1000; --ns
    
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
--     : SLV64_ARRAY_TYPE (0 to 3)
       : SLV64_ARRAY_TYPE
       :=                    (   X"0000_0000_0000_0000",
                                       X"0000_0000_0000_0000",
                                             X"0000_0000_0000_3800",
                                                  X"0000_0000_0000_4800" );
  
      C_STAT_FIFO_ADDR
--     : SLV64_ARRAY_TYPE (0 to 3)
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

-- Two channel, 23, tx rx coalesc.
--  generic (
--     C_OPB_DWIDTH : natural := 32;  --  Width of data bus (32, 64).
--     C_OPB_AWIDTH : natural := 32;  --  width of Bus addr.
--     C_IPIF_ABUS_WIDTH : natural :=15;
--
--     C_CLK_PERIOD_PS : integer := 10000; --ps  Period of Bus2IP_Clk.
--
--     -- The time unit, in nanoseconds, that applies to
--     -- the Packet Wait Bound register. The specified value of this
--     -- generic is 1,000,000 (1 ms), but a smaller value can be used for
--     -- simulations. 
--     C_PACKET_WAIT_UNIT_NS : integer := 1000000; --ns
--
--     C_DMA_CHAN_TYPE         -- 0=simple, 1=sg, 2=tx, 3=rx
--      : INTEGER_ARRAY_TYPE
--      :=                    (    2,    3  );
--
--     -- The leftmost defined bit of the LENGTH field, assuming
--     -- big endian bit numbering and a LSB at bit 31.
--     -- If the channel is a packet channel, it is assumed that
--     -- the number bits defined in the LENGTH register is also
--     -- enough bits to hold the length of a maximum sized packet.
--     -- ToDo, current impl requires all channels to be the same length.
--     C_DMA_LENGTH_WIDTH
--      : INTEGER_ARRAY_TYPE
--      :=                    (   11,  11  );
--
--     C_LEN_FIFO_ADDR
--      : SLV64_ARRAY_TYPE (0 to 1)
--      :=                    (   X"0000_0000_0000_1800",
--                                     X"0000_0000_0000_2800" );
--
--     C_STAT_FIFO_ADDR
--      : SLV64_ARRAY_TYPE (0 to 1)
--      :=                    (   X"0000_0000_0000_1804",
--                                     X"0000_0000_0000_2804" );
--
--     C_INTR_COALESCE
--      : INTEGER_ARRAY_TYPE
--      :=                    (  1,  1  );
--
--     C_DEV_BLK_ID  : integer := 0;
--
--     C_DMA_BASEADDR : std_logic_vector
--               := X"0000_0000_0000_0000";
--
--     C_DMA_ALLOW_BURST : boolean := true;
--
--     C_MA2SA_NUM_WIDTH : INTEGER := 4;  
--
--     C_WFIFO_VACANCY_WIDTH : integer := 10
--);

-- Two channel, 00, simple DMA only
--generic (
--     C_OPB_DWIDTH : natural := 32;  --  Width of data bus (32, 64).
--     C_OPB_AWIDTH : natural := 32;  --  width of Bus addr.
--     C_IPIF_ABUS_WIDTH : natural :=15;
--
--     C_CLK_PERIOD_PS : integer := 16000; --ps  Period of Bus2IP_Clk.
--
--     -- The time unit, in nanoseconds, that applies to
--     -- the Packet Wait Bound register. The specified value of this
--     -- generic is 1,000,000 (1 ms), but a smaller value can be used for
--     -- simulations. 
--     C_PACKET_WAIT_UNIT_NS : integer := 1000; --ns
--
--     C_DMA_CHAN_TYPE         -- 0=simple, 1=sg, 2=tx, 3=rx
--      : INTEGER_ARRAY_TYPE
--      :=                    (    0,    0  );
--
--     -- The leftmost defined bit of the LENGTH field, assuming
--     -- big endian bit numbering and a LSB at bit 31.
--     -- If the channel is a packet channel, it is assumed that
--     -- the number bits defined in the LENGTH register is also
--     -- enough bits to hold the length of a maximum sized packet.
--     -- ToDo, current impl requires all channels to be the same length.
--     C_DMA_LENGTH_WIDTH
--      : INTEGER_ARRAY_TYPE
--      :=                    (   11,  11  );
--
--         C_LEN_FIFO_ADDR
--          : SLV64_ARRAY_TYPE (0 to 1)
--          :=                (   X"0000_0000_0000_0000",
--                                     X"0000_0000_0000_0000" );
--
--         C_STAT_FIFO_ADDR
--          : SLV64_ARRAY_TYPE (0 to 1)
--          :=                (   X"0000_0000_0000_0000",
--                                     X"0000_0000_0000_0000" );
--  
--     C_INTR_COALESCE
--      : INTEGER_ARRAY_TYPE
--      :=                    (  0,  0  );
--
--     C_DEV_BLK_ID  : integer := 0;
--
--     C_DMA_BASEADDR : std_logic_vector
--               := X"0000_0000_0000_0000";
--
--     C_DMA_ALLOW_BURST : boolean := 1;
--
--     C_MA2SA_NUM_WIDTH : INTEGER := 4;  
--
--     C_WFIFO_VACANCY_WIDTH : integer := 10
--);

-- Three channel, 000, simple DMA only
--generic (
--     C_OPB_DWIDTH : natural := 32;  --  Width of data bus (32, 64).
--     C_OPB_AWIDTH : natural := 32;  --  width of Bus addr.
--     C_IPIF_ABUS_WIDTH : natural :=15;
--
--     C_CLK_PERIOD_PS : integer := 16000; --ps  Period of Bus2IP_Clk.
--
--     -- The time unit, in nanoseconds, that applies to
--     -- the Packet Wait Bound register. The specified value of this
--     -- generic is 1,000,000 (1 ms), but a smaller value can be used for
--     -- simulations. 
--     C_PACKET_WAIT_UNIT_NS : integer := 1000; --ns
--
--     C_DMA_CHAN_TYPE         -- 0=simple, 1=sg, 2=tx, 3=rx
--      : INTEGER_ARRAY_TYPE
--      :=                    (    0,    0,    0  );
--
--     -- The leftmost defined bit of the LENGTH field, assuming
--     -- big endian bit numbering and a LSB at bit 31.
--     -- If the channel is a packet channel, it is assumed that
--     -- the number bits defined in the LENGTH register is also
--     -- enough bits to hold the length of a maximum sized packet.
--     -- ToDo, current impl requires all channels to be the same length.
--     C_DMA_LENGTH_WIDTH
--      : INTEGER_ARRAY_TYPE
--      :=                    (   11,  11,   11  );
--
--         C_LEN_FIFO_ADDR
--          : SLV64_ARRAY_TYPE (0 to 1)
--          :=                (   X"0000_0000_0000_0000",
--                                     X"0000_0000_0000_0000", 
--                                           X"0000_0000_0000_0000" );
--
--         C_STAT_FIFO_ADDR
--          : SLV64_ARRAY_TYPE (0 to 1)
--          :=                (   X"0000_0000_0000_0000",
--                                     X"0000_0000_0000_0000", 
--                                           X"0000_0000_0000_0000" );
--  
--     C_INTR_COALESCE
--      : INTEGER_ARRAY_TYPE
--      :=                    (  0,  0,  0  );
--
--     C_DEV_BLK_ID  : integer := 0;
--
--     C_DMA_BASEADDR : std_logic_vector
--               := X"0000_0000_0000_0000";
--
--     C_DMA_ALLOW_BURST : boolean := 1;
--
--     C_MA2SA_NUM_WIDTH : INTEGER := 4;  
--
--     C_WFIFO_VACANCY_WIDTH : integer := 10
--);

-- One channel version. (under construction)
--generic (
--     C_OPB_DWIDTH : natural := 32;  --  Width of data bus (32, 64).
--     C_OPB_AWIDTH : natural := 32;  --  width of Bus addr.
--     C_IPIF_ABUS_WIDTH : natural :=15;
--
--     C_CLK_PERIOD_PS : integer := 16000; --ps  Period of Bus2IP_Clk.
--
--     -- The time unit, in nanoseconds, that applies to
--     -- the Packet Wait Bound register. The specified value of this
--     -- generic is 1,000,000 (1 ms), but a smaller value can be used for
--     -- simulations. 
--     C_PACKET_WAIT_UNIT_NS : integer := 1000; --ns
--
--     C_DMA_CHAN_TYPE         -- 0=simple, 1=sg, 2=tx, 3=rx
--      : INTEGER_ARRAY_TYPE
--      :=                    (    2,    3  );
--
--     -- The leftmost defined bit of the LENGTH field, assuming
--     -- big endian bit numbering and a LSB at bit 31.
--     -- If the channel is a packet channel, it is assumed that
--     -- the number bits defined in the LENGTH register is also
--     -- enough bits to hold the length of a maximum sized packet.
--     -- ToDo, current impl requires all channels to be the same length.
--     C_DMA_LENGTH_WIDTH
--      : INTEGER_ARRAY_TYPE
--      :=                    (   11,  11  );
--
--         C_LEN_FIFO_ADDR
--          : SLV64_ARRAY_TYPE (0 to 1)
--          :=                    (   X"0000_0000_0000_1800", X"0000_0000_0000_2800" );
--
--         C_STAT_FIFO_ADDR
--          : SLV64_ARRAY_TYPE (0 to 1)
--          :=                    (   X"0000_0000_0000_1804", X"0000_0000_0000_2804" );
--  
--
--     C_INTR_COALESCE
--      : INTEGER_ARRAY_TYPE
--      :=                    (  1,  1  );
--
--     C_DEV_BLK_ID  : integer := 0;
--
--     C_DMA_BASEADDR : std_logic_vector
--               := X"0000_0000_0000_0000";
--
--     C_DMA_ALLOW_BURST : boolean := true;
--
--     C_MA2SA_NUM_WIDTH : INTEGER := 4;  
--
--     C_WFIFO_VACANCY_WIDTH : integer := 10
--);

    port (
          DMA2Bus_Data : out std_logic_vector(0 to 31);
          DMA2Bus_Addr : out std_logic_vector(0 to C_OPB_AWIDTH-1 );
          DMA2Bus_MstBE : out std_logic_vector(0 to C_OPB_DWIDTH/8 - 1);
          DMA2Bus_MstWrReq : out std_logic;
          DMA2Bus_MstRdReq : out std_logic;
          DMA2Bus_MstNum : out std_logic_vector(
                                      0 to C_MA2SA_NUM_WIDTH-1);
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
          DMA2Intr_Intr  : out std_logic_vector(0 to 1)
    );
end component;

component ctrl_reg_0_to_6
    generic(
        C_RESET_VAL: std_logic_vector
    );
    port(
        clk       : in  std_logic;
        rst       : in  std_logic;
        chan_sel  : in  std_logic;
        reg_sel   : in  std_logic;
        wr_ce     : in  std_logic;
        d         : in  std_logic_vector(0 to 6);
        q         : out std_logic_vector(0 to 6)
    );
end component;

component ctrl_reg_0_to_0
    generic(
        C_RESET_VAL: std_logic_vector
    );
    port(
        clk       : in  std_logic;
        rst       : in  std_logic;
        chan_sel  : in  std_logic;
        reg_sel   : in  std_logic;
        wr_ce     : in  std_logic;
-- XGR_E33        d         : in  std_logic_vector(0 to 0);
-- XGR_E33        q         : out std_logic_vector(0 to 0)
        d         : in  std_logic;
        q         : out std_logic
    );
end component;

component SRL_FIFO
  generic (
    C_DATA_BITS : natural := 8;
    C_DEPTH     : natural := 16
    );
  port (
    Clk         : in  std_logic;
    Reset       : in  std_logic;
    FIFO_Write  : in  std_logic;
    Data_In     : in  std_logic_vector(0 to C_DATA_BITS-1);
    FIFO_Read   : in  std_logic;
    Data_Out    : out std_logic_vector(0 to C_DATA_BITS-1);
    FIFO_Full   : out std_logic;
    Data_Exists : out std_logic;
    Addr        : out std_logic_vector(0 to 3) -- Added Addr as a port
    );
end component;

component ld_arith_reg
    generic (
        ------------------------------------------------------------------------
        -- True if the arithmetic operation is add, false if subtract.
        C_ADD_SUB_NOT : boolean := false;
        ------------------------------------------------------------------------
        -- Width of the register.
        C_REG_WIDTH   : natural := 8;
        ------------------------------------------------------------------------
        -- Reset value. (No default, must be specified in the instantiation.)
        C_RESET_VALUE : std_logic_vector;
        ------------------------------------------------------------------------
        -- Width of the load data.
        C_LD_WIDTH    : natural :=  8;
        ------------------------------------------------------------------------
        -- Offset to left (toward more significant) of the load data.
        C_LD_OFFSET   : natural :=  0;
        ------------------------------------------------------------------------
        -- Width of the arithmetic data.
        C_AD_WIDTH    : natural :=  8;
        ------------------------------------------------------------------------
        -- Offset to left of the arithmetic data.
        C_AD_OFFSET   : natural :=  0
        ------------------------------------------------------------------------
        -- Dependencies: (1) C_LD_WIDTH + C_LD_OFFSET <= C_REG_WIDTH
        --               (2) C_AD_WIDTH + C_AD_OFFSET <= C_REG_WIDTH
        ------------------------------------------------------------------------
    );
    port (
        CK       : in  std_logic;
        RST      : in  std_logic; -- Reset to C_RESET_VALUE. (Overrides OP,LOAD)
        Q        : out std_logic_vector(0 to C_REG_WIDTH-1);
        LD       : in  std_logic_vector(0 to C_LD_WIDTH-1); -- Load data.
        AD       : in  std_logic_vector(0 to C_AD_WIDTH-1); -- Arith data.
        LOAD     : in  std_logic;  -- Enable for the load op, Q <= LD.
        OP       : in  std_logic   -- Enable for the arith op, Q <= Q + AD.
                                   -- (Q <= Q - AD if C_ADD_SUB_NOT = false.)
                                   -- (Overrrides LOAD.)
    );
end component;

end package;
