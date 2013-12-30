-------------------------------------------------------------------------------
-- $Id: sync_fifo_fg.vhd,v 1.5.20.3 2010/02/09 20:15:59 dougt Exp $
-------------------------------------------------------------------------------
-- sync_fifo_fg.vhd
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
-- ** Copyright (c) 2008, 2009, 2010 Xilinx, Inc. All rights reserved.    **
-- **                                                                     **
-- ** This copyright and support notice must be retained as part          **
-- ** of this text at all times.                                          **
-- **                                                                     **
-- *************************************************************************
--
-------------------------------------------------------------------------------
-- Filename:        sync_fifo_fg.vhd
--
-- Description:     
-- This HDL file adapts the legacy CoreGen Sync FIFO interface to the new                
-- FIFO Generator Sync FIFO interface. This wrapper facilitates the "on
-- the fly" call of FIFO Generator during design implementation.                
--                  
--                  
--                  
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:   
--              sync_fifo_fg.vhd
--                 |
--                 |-- fifo_generator_v4_3
--                 |
--                 |-- fifo_generator_v5_3
--
-------------------------------------------------------------------------------
-- Revision History:
--
--
-- Author:          DET
-- Revision:        $Revision: 1.5.20.3 $
-- Date:            $1/16/2008$
--
-- History:
--   DET   1/16/2008       Initial Version
-- 
--     DET     7/30/2008     for EDK 11.1
-- ~~~~~~
--     - Replaced fifo_generator_v4_2 component with fifo_generator_v4_3
-- ^^^^^^
--
--      MSH and DET     3/2/2009     For Lava SP2
-- ~~~~~~
--     - Added FIFO Generator version 5.1 for use with Virtex6 and Spartan6 
--       devices.
--     - IfGen used so that legacy FPGA families still use Fifo Generator 
--       version 4.3.
-- ^^^^^^
--
--     DET     4/9/2009     EDK 11.2
-- ~~~~~~
--     - Replaced FIFO Generator version 5.1 with 5.2.
-- ^^^^^^
--
--
--     DET     2/9/2010     for EDK 11.5
-- ~~~~~~
--     - Updated the S6/V6 FIFO Generator version from V5.2 to V5.3.
-- ^^^^^^
--
--
--
-------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


library proc_common_v3_00_a;
use proc_common_v3_00_a.coregen_comp_defs.all;
use proc_common_v3_00_a.proc_common_pkg.all;
use proc_common_v3_00_a.proc_common_pkg.log2;
use proc_common_v3_00_a.family_support.all;


-- synopsys translate_off
library XilinxCoreLib;
--use XilinxCoreLib.all;
-- synopsys translate_on


-------------------------------------------------------------------------------

entity sync_fifo_fg is
  generic (
    C_FAMILY             :    String  := "virtex5"; -- new for FIFO Gen
    C_DCOUNT_WIDTH       :    integer := 4 ;
    C_ENABLE_RLOCS       :    integer := 0 ; -- not supported in sync fifo
    C_HAS_DCOUNT         :    integer := 1 ;
    C_HAS_RD_ACK         :    integer := 0 ;
    C_HAS_RD_ERR         :    integer := 0 ;
    C_HAS_WR_ACK         :    integer := 0 ;
    C_HAS_WR_ERR         :    integer := 0 ;
    C_HAS_ALMOST_FULL    :    integer := 0 ;
    C_MEMORY_TYPE        :    integer := 0 ;  -- 0 = distributed RAM, 1 = BRAM
    C_PORTS_DIFFER       :    integer := 0 ;  
    C_RD_ACK_LOW         :    integer := 0 ;
    C_READ_DATA_WIDTH    :    integer := 16;
    C_READ_DEPTH         :    integer := 16;
    C_RD_ERR_LOW         :    integer := 0 ;
    C_WR_ACK_LOW         :    integer := 0 ;
    C_WR_ERR_LOW         :    integer := 0 ;
    C_PRELOAD_REGS       :    integer := 0 ;  -- 1 = first word fall through
    C_PRELOAD_LATENCY    :    integer := 1 ;  -- 0 = first word fall through
    C_WRITE_DATA_WIDTH   :    integer := 16;
    C_WRITE_DEPTH        :    integer := 16
    );
  port (
    Clk          : in  std_logic;
    Sinit        : in  std_logic;
    Din          : in  std_logic_vector(C_WRITE_DATA_WIDTH-1 downto 0);
    Wr_en        : in  std_logic;
    Rd_en        : in  std_logic;
    Dout         : out std_logic_vector(C_READ_DATA_WIDTH-1 downto 0);
    Almost_full  : out std_logic;
    Full         : out std_logic;
    Empty        : out std_logic;
    Rd_ack       : out std_logic;
    Wr_ack       : out std_logic;
    Rd_err       : out std_logic;
    Wr_err       : out std_logic;
    Data_count   : out std_logic_vector(C_DCOUNT_WIDTH-1 downto 0)
    );

end entity sync_fifo_fg;


architecture implementation of sync_fifo_fg is

 -- Function delarations 
 
 
    -------------------------------------------------------------------
    -- Function
    --
    -- Function Name: GetMaxDepth
    --
    -- Function Description:
    -- Returns the largest value of either Write depth or Read depth
    -- requested by input parameters.
    --
    -------------------------------------------------------------------
    function GetMaxDepth (rd_depth : integer; 
                          wr_depth : integer) 
                          return integer is
    
      Variable max_value : integer := 0;
    
    begin
       
       If (rd_depth < wr_depth) Then
         max_value := wr_depth;
       else
         max_value := rd_depth;
       End if;
      
      return(max_value);
      
    end function GetMaxDepth;
    
  
                
    -------------------------------------------------------------------
    -- Function
    --
    -- Function Name: GetMemType
    --
    -- Function Description:
    -- Generates the required integer value for the FG instance assignment
    -- of the C_MEMORY_TYPE parameter. Derived from
    -- the input memory type parameter C_MEMORY_TYPE.
    -- 
    -- FIFO Generator values
    --   0 = Any
    --   1 = BRAM
    --   2 = Distributed Memory  
    --   3 = Shift Registers
    --
    -------------------------------------------------------------------
    function GetMemType (inputmemtype : integer) return integer is
    
      Variable memtype : Integer := 0;
      
    begin
    
       If (inputmemtype = 0) Then -- distributed Memory 
         memtype := 2;
       else
         memtype := 1;            -- BRAM
       End if;
      
      return(memtype);
      
    end function GetMemType;
    
                                    
  
  
  
  
  -- Constants
    
    Constant FAM_IS_V6_OR_S6     : boolean := (equalIgnoringCase(C_FAMILY, "virtex6" ) or 
                                               equalIgnoringCase(C_FAMILY, "spartan6"));
    
    Constant FAM_IS_NOT_V6_OR_S6 : boolean := not(FAM_IS_V6_OR_S6);
    
    Constant MAX_DEPTH           : integer := GetMaxDepth(C_READ_DEPTH,C_WRITE_DEPTH);
    Constant FGEN_CNT_WIDTH      : integer := log2(MAX_DEPTH)+1;
    Constant ADJ_FGEN_CNT_WIDTH  : integer := FGEN_CNT_WIDTH-1;
    
    Constant FG_MEM_TYPE         : integer := GetMemType(C_MEMORY_TYPE);
    
    
    -- Set the required integer value for the FG instance assignment
    -- of the C_IMPLEMENTATION_TYPE parameter. Derived from
    -- the input memory type parameter C_MEMORY_TYPE.
    --
    --  0 = Common Clock BRAM / Distributed RAM (Synchronous FIFO)
    --  1 = Common Clock Shift Register (Synchronous FIFO)
    --  2 = Independent Clock BRAM/Distributed RAM (Asynchronous FIFO)
    --  3 = Independent/Common Clock V4 Built In Memory -- not used in legacy fifo calls
    --  5 = Independent/Common Clock V5 Built in Memory  -- not used in legacy fifo calls
    --
    Constant FG_IMP_TYPE         : integer := 0;
    
     
     
    -- The programable thresholds are not used so this is housekeeping.
    Constant PROG_FULL_THRESH_ASSERT_VAL : integer := MAX_DEPTH-3;
    Constant PROG_FULL_THRESH_NEGATE_VAL : integer := MAX_DEPTH-4;
  
 
 
    -- Constant zeros for programmable threshold inputs
    Constant PROG_RDTHRESH_ZEROS : std_logic_vector(ADJ_FGEN_CNT_WIDTH-1
                                   DOWNTO 0) := (OTHERS => '0');
    Constant PROG_WRTHRESH_ZEROS : std_logic_vector(ADJ_FGEN_CNT_WIDTH-1 
                                   DOWNTO 0) := (OTHERS => '0');
    
    
 -- Signals
    
    signal sig_full            : std_logic;
    signal sig_full_fg_datacnt : std_logic_vector(FGEN_CNT_WIDTH-1 downto 0);
    signal sig_prim_fg_datacnt : std_logic_vector(ADJ_FGEN_CNT_WIDTH-1 downto 0);


begin --(architecture implementation)

     Full <= sig_full;
 
   
     -- Create legacy data count by concatonating the Full flag to the 
     -- MS Bit position of the FIFO data count
     -- This is per the Fifo Generator Migration Guide
     sig_full_fg_datacnt <= sig_full & sig_prim_fg_datacnt;  
     
     Data_count <=  sig_full_fg_datacnt(FGEN_CNT_WIDTH-1 downto 
                    FGEN_CNT_WIDTH-C_DCOUNT_WIDTH);   
   
   
   
  ------------------------------------------------------------
  -- If Generate
  --
  -- Label: NOT_V6_OR_S6
  --
  -- If Generate Description:
  -- This IfGen implements the fifo using FIFO Generator 4.3
  -- when the designated FPGA Family is not Spartan-6 or Virtex-6.
  --
  ------------------------------------------------------------
  NOT_V6_OR_S6: if(FAM_IS_NOT_V6_OR_S6) generate
  begin
   
   -------------------------------------------------------------------------------
   -- Instantiate the generalized FIFO Generator instance
   --
   -- NOTE:
   -- DO NOT CHANGE TO DIRECT ENTITY INSTANTIATION!!!
   -- This is a Coregen FIFO Generator Call module for 
   -- BRAM implementations of a legacy Sync FIFO
   --
   -------------------------------------------------------------------------------
    I_SYNC_FIFO_BRAM : fifo_generator_v4_3 
      generic map(
        C_COMMON_CLOCK                 =>  1,   
        C_COUNT_TYPE                   =>  0,   
        C_DATA_COUNT_WIDTH             =>  ADJ_FGEN_CNT_WIDTH,   -- what to do here ???
        C_DEFAULT_VALUE                =>  "BlankString",         -- what to do here ???
        C_DIN_WIDTH                    =>  C_WRITE_DATA_WIDTH,   
        C_DOUT_RST_VAL                 =>  "0",   
        C_DOUT_WIDTH                   =>  C_READ_DATA_WIDTH,   
        C_ENABLE_RLOCS                 =>  0,                     -- not supported
        C_FAMILY                       =>  C_FAMILY,
        C_HAS_ALMOST_EMPTY             =>  1,   
        C_HAS_ALMOST_FULL              =>  C_HAS_ALMOST_FULL,                                           
        C_HAS_BACKUP                   =>  0,   
        C_HAS_DATA_COUNT               =>  C_HAS_DCOUNT,   
        C_HAS_MEMINIT_FILE             =>  0,   
        C_HAS_OVERFLOW                 =>  C_HAS_WR_ERR,   
        C_HAS_RD_DATA_COUNT            =>  0,              -- not used for sync FIFO
        C_HAS_RD_RST                   =>  0,              -- not used for sync FIFO
        C_HAS_RST                      =>  0,              -- not used for sync FIFO
        C_HAS_SRST                     =>  1,   
        C_HAS_UNDERFLOW                =>  C_HAS_RD_ERR,   
        C_HAS_VALID                    =>  C_HAS_RD_ACK,   
        C_HAS_WR_ACK                   =>  C_HAS_WR_ACK,   
        C_HAS_WR_DATA_COUNT            =>  0,              -- not used for sync FIFO
        C_HAS_WR_RST                   =>  0,              -- not used for sync FIFO
        C_IMPLEMENTATION_TYPE          =>  FG_IMP_TYPE,  
        C_INIT_WR_PNTR_VAL             =>  0,   
        C_MEMORY_TYPE                  =>  FG_MEM_TYPE,    
        C_MIF_FILE_NAME                =>  "BlankString",    
        C_OPTIMIZATION_MODE            =>  0,   
        C_OVERFLOW_LOW                 =>  C_WR_ERR_LOW,   
        C_PRELOAD_REGS                 =>  C_PRELOAD_REGS,     -- 1 = first word fall through                                      
        C_PRELOAD_LATENCY              =>  C_PRELOAD_LATENCY,  -- 0 = first word fall through                                          
        C_PRIM_FIFO_TYPE               =>  "512x36", -- only used for V5 Hard FIFO   
        C_PROG_EMPTY_THRESH_ASSERT_VAL =>  2,   
        C_PROG_EMPTY_THRESH_NEGATE_VAL =>  3,   
        C_PROG_EMPTY_TYPE              =>  0,   
        C_PROG_FULL_THRESH_ASSERT_VAL  =>  PROG_FULL_THRESH_ASSERT_VAL,   
        C_PROG_FULL_THRESH_NEGATE_VAL  =>  PROG_FULL_THRESH_NEGATE_VAL,   
        C_PROG_FULL_TYPE               =>  0,   
        C_RD_DATA_COUNT_WIDTH          =>  ADJ_FGEN_CNT_WIDTH,   
        C_RD_DEPTH                     =>  MAX_DEPTH,   
        C_RD_FREQ                      =>  1,   
        C_RD_PNTR_WIDTH                =>  ADJ_FGEN_CNT_WIDTH,   
        C_UNDERFLOW_LOW                =>  C_RD_ERR_LOW,   
        C_USE_DOUT_RST                 =>  1,   
        C_USE_EMBEDDED_REG             =>  0,   
        C_USE_FIFO16_FLAGS             =>  0,   
        C_USE_FWFT_DATA_COUNT          =>  0,   
        C_VALID_LOW                    =>  C_RD_ACK_LOW,   
        C_WR_ACK_LOW                   =>  C_WR_ACK_LOW,   
        C_WR_DATA_COUNT_WIDTH          =>  ADJ_FGEN_CNT_WIDTH,   
        C_WR_DEPTH                     =>  MAX_DEPTH,   
        C_WR_FREQ                      =>  1,   
        C_WR_PNTR_WIDTH                =>  ADJ_FGEN_CNT_WIDTH,   
        C_WR_RESPONSE_LATENCY          =>  1,   
        C_USE_ECC                      =>  0,   
        C_FULL_FLAGS_RST_VAL           =>  0,   
        C_HAS_INT_CLK                  =>  0,  
        C_MSGON_VAL                    =>  1
       )
      port map (
        CLK                       =>  Clk,                  -- : IN  std_logic := '0';
        BACKUP                    =>  '0',                  -- : IN  std_logic := '0';
        BACKUP_MARKER             =>  '0',                  -- : IN  std_logic := '0';
        DIN                       =>  Din,                  -- : IN  std_logic_vector(C_DIN_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
        PROG_EMPTY_THRESH         =>  PROG_RDTHRESH_ZEROS,  -- : IN  std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
        PROG_EMPTY_THRESH_ASSERT  =>  PROG_RDTHRESH_ZEROS,  -- : IN  std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
        PROG_EMPTY_THRESH_NEGATE  =>  PROG_RDTHRESH_ZEROS,  -- : IN  std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
        PROG_FULL_THRESH          =>  PROG_WRTHRESH_ZEROS,  -- : IN  std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
        PROG_FULL_THRESH_ASSERT   =>  PROG_WRTHRESH_ZEROS,  -- : IN  std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
        PROG_FULL_THRESH_NEGATE   =>  PROG_WRTHRESH_ZEROS,  -- : IN  std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
        RD_CLK                    =>  '0',                  -- : IN  std_logic := '0';
        RD_EN                     =>  Rd_en,                -- : IN  std_logic := '0';
        RD_RST                    =>  '0',                  -- : IN  std_logic := '0';
        RST                       =>  '0',                  -- : IN  std_logic := '0';
        SRST                      =>  Sinit,                -- : IN  std_logic := '0';
        WR_CLK                    =>  '0',                  -- : IN  std_logic := '0';
        WR_EN                     =>  Wr_en,                -- : IN  std_logic := '0';
        WR_RST                    =>  '0',                  -- : IN  std_logic := '0';
        INT_CLK                   =>  '0',                  -- : IN  std_logic := '0';

        ALMOST_EMPTY              =>  open,                 -- : OUT std_logic;
        ALMOST_FULL               =>  Almost_full,          -- : OUT std_logic;                                                      
        DATA_COUNT                =>  sig_prim_fg_datacnt,  -- : OUT std_logic_vector(C_DATA_COUNT_WIDTH-1 DOWNTO 0);
        DOUT                      =>  Dout,                 -- : OUT std_logic_vector(C_DOUT_WIDTH-1 DOWNTO 0);
        EMPTY                     =>  Empty,                -- : OUT std_logic;
        FULL                      =>  sig_full,             -- : OUT std_logic;
        OVERFLOW                  =>  Wr_err,               -- : OUT std_logic;
        PROG_EMPTY                =>  open,                 -- : OUT std_logic;
        PROG_FULL                 =>  open,                 -- : OUT std_logic;
        VALID                     =>  Rd_ack,               -- : OUT std_logic;
        RD_DATA_COUNT             =>  open,                 -- : OUT std_logic_vector(C_RD_DATA_COUNT_WIDTH-1 DOWNTO 0);
        UNDERFLOW                 =>  Rd_err,               -- : OUT std_logic;
        WR_ACK                    =>  Wr_ack,               -- : OUT std_logic;
        WR_DATA_COUNT             =>  open,                 -- : OUT std_logic_vector(C_WR_DATA_COUNT_WIDTH-1 DOWNTO 0);
        SBITERR                   =>  open,                 -- : OUT std_logic;
        DBITERR                   =>  open                  -- : OUT std_logic
       );
  end generate NOT_V6_OR_S6;






  
  ------------------------------------------------------------
  -- If Generate
  --
  -- Label: YES_V6_OR_S6
  --
  -- If Generate Description:
  -- This IfGen implements the fifo using FIFO Generator 5.3
  -- when the designated FPGA Family is Spartan-6 or Virtex-6.
  --
  ------------------------------------------------------------
  YES_V6_OR_S6: if(FAM_IS_V6_OR_S6) generate
  begin
   
    -------------------------------------------------------------------------------
    -- Instantiate the generalized FIFO Generator instance
    --
    -- NOTE:
    -- DO NOT CHANGE TO DIRECT ENTITY INSTANTIATION!!!
    -- This is a Coregen FIFO Generator Call module for 
    -- BRAM implementations of a legacy Sync FIFO
    --
    -------------------------------------------------------------------------------
    I_SYNC_FIFO_BRAM : fifo_generator_v5_3 
      generic map(
        C_COMMON_CLOCK                =>  1,                                           
        C_COUNT_TYPE                  =>  0,                                           
        C_DATA_COUNT_WIDTH            =>  ADJ_FGEN_CNT_WIDTH,   -- what to do here ??? 
        C_DEFAULT_VALUE               =>  "BlankString",         -- what to do here ???
        C_DIN_WIDTH                   =>  C_WRITE_DATA_WIDTH,                          
        C_DOUT_RST_VAL                =>  "0",                                         
        C_DOUT_WIDTH                  =>  C_READ_DATA_WIDTH,                           
        C_ENABLE_RLOCS                =>  0,                     -- not supported      
        C_FAMILY                      =>  C_FAMILY,                                    
        C_HAS_ALMOST_EMPTY            =>  1,                                           
        C_HAS_ALMOST_FULL             =>  C_HAS_ALMOST_FULL,                                           
        C_HAS_BACKUP                  =>  0,                                           
        C_HAS_DATA_COUNT              =>  C_HAS_DCOUNT,                                
        C_HAS_MEMINIT_FILE            =>  0,                                           
        C_HAS_OVERFLOW                =>  C_HAS_WR_ERR,                                
        C_HAS_RD_DATA_COUNT           =>  0,              -- not used for sync FIFO    
        C_HAS_RD_RST                  =>  0,              -- not used for sync FIFO    
        C_HAS_RST                     =>  0,              -- not used for sync FIFO    
        C_HAS_SRST                    =>  1,                                           
        C_HAS_UNDERFLOW               =>  C_HAS_RD_ERR,                                
        C_HAS_VALID                   =>  C_HAS_RD_ACK,                                
        C_HAS_WR_ACK                  =>  C_HAS_WR_ACK,                                
        C_HAS_WR_DATA_COUNT           =>  0,              -- not used for sync FIFO    
        C_HAS_WR_RST                  =>  0,              -- not used for sync FIFO    
        C_IMPLEMENTATION_TYPE         =>  FG_IMP_TYPE,                                 
        C_INIT_WR_PNTR_VAL            =>  0,                                           
        C_MEMORY_TYPE                 =>  FG_MEM_TYPE,                                 
        C_MIF_FILE_NAME               =>  "BlankString",                               
        C_OPTIMIZATION_MODE           =>  0,                                           
        C_OVERFLOW_LOW                =>  C_WR_ERR_LOW,                                
        C_PRELOAD_REGS                =>  C_PRELOAD_REGS,     -- 1 = first word fall through                                      
        C_PRELOAD_LATENCY             =>  C_PRELOAD_LATENCY,  -- 0 = first word fall through                                          
        C_PRIM_FIFO_TYPE              =>  "512x36", -- only used for V5 Hard FIFO      
        C_PROG_EMPTY_THRESH_ASSERT_VAL=>  2,                                           
        C_PROG_EMPTY_THRESH_NEGATE_VAL=>  3,                                           
        C_PROG_EMPTY_TYPE             =>  0,                                           
        C_PROG_FULL_THRESH_ASSERT_VAL =>  PROG_FULL_THRESH_ASSERT_VAL,                 
        C_PROG_FULL_THRESH_NEGATE_VAL =>  PROG_FULL_THRESH_NEGATE_VAL,                 
        C_PROG_FULL_TYPE              =>  0,                                           
        C_RD_DATA_COUNT_WIDTH         =>  ADJ_FGEN_CNT_WIDTH,                          
        C_RD_DEPTH                    =>  MAX_DEPTH,                                   
        C_RD_FREQ                     =>  1,                                           
        C_RD_PNTR_WIDTH               =>  ADJ_FGEN_CNT_WIDTH,                          
        C_UNDERFLOW_LOW               =>  C_RD_ERR_LOW,                                
        C_USE_DOUT_RST                =>  1,                                           
        C_USE_EMBEDDED_REG            =>  0,                                           
        C_USE_FIFO16_FLAGS            =>  0,                                           
        C_USE_FWFT_DATA_COUNT         =>  0,                                           
        C_VALID_LOW                   =>  C_RD_ACK_LOW,                                
        C_WR_ACK_LOW                  =>  C_WR_ACK_LOW,                                
        C_WR_DATA_COUNT_WIDTH         =>  ADJ_FGEN_CNT_WIDTH,                          
        C_WR_DEPTH                    =>  MAX_DEPTH,                                   
        C_WR_FREQ                     =>  1,                                           
        C_WR_PNTR_WIDTH               =>  ADJ_FGEN_CNT_WIDTH,                          
        C_WR_RESPONSE_LATENCY         =>  1,                                           
        C_USE_ECC                     =>  0,                                           
        C_FULL_FLAGS_RST_VAL          =>  0,                                           
        C_HAS_INT_CLK                 =>  0,                                            
        C_MSGON_VAL                   =>  1,
        C_ENABLE_RST_SYNC             =>  1,  -- new FG 5.1/5.2
        C_ERROR_INJECTION_TYPE        =>  0   -- new FG 5.1/5.2
        )
      port map(
        CLK                       =>  Clk,                  
        BACKUP                    =>  '0',                  
        BACKUP_MARKER             =>  '0',                  
        DIN                       =>  Din,                  
        PROG_EMPTY_THRESH         =>  PROG_RDTHRESH_ZEROS,  
        PROG_EMPTY_THRESH_ASSERT  =>  PROG_RDTHRESH_ZEROS,  
        PROG_EMPTY_THRESH_NEGATE  =>  PROG_RDTHRESH_ZEROS,  
        PROG_FULL_THRESH          =>  PROG_WRTHRESH_ZEROS,  
        PROG_FULL_THRESH_ASSERT   =>  PROG_WRTHRESH_ZEROS,  
        PROG_FULL_THRESH_NEGATE   =>  PROG_WRTHRESH_ZEROS,  
        RD_CLK                    =>  '0',                  
        RD_EN                     =>  Rd_en,                
        RD_RST                    =>  '0',                  
        RST                       =>  '0',                  
        SRST                      =>  Sinit,                
        WR_CLK                    =>  '0',                  
        WR_EN                     =>  Wr_en,                
        WR_RST                    =>  '0',                  
        INT_CLK                   =>  '0',                  
        INJECTDBITERR             =>  '0', -- new FG 5.1/5.2
        INJECTSBITERR             =>  '0', -- new FG 5.1/5.2
                                                                                                                                     
        ALMOST_EMPTY              =>  open,                              
        ALMOST_FULL               =>  Almost_full,                       
        DATA_COUNT                =>  sig_prim_fg_datacnt,               
        DOUT                      =>  Dout,                              
        EMPTY                     =>  Empty,                             
        FULL                      =>  sig_full,                          
        OVERFLOW                  =>  Wr_err,                            
        PROG_EMPTY                =>  open,                              
        PROG_FULL                 =>  open,                              
        VALID                     =>  Rd_ack,                            
        RD_DATA_COUNT             =>  open,                              
        UNDERFLOW                 =>  Rd_err,                            
        WR_ACK                    =>  Wr_ack,                            
        WR_DATA_COUNT             =>  open,                              
        SBITERR                   =>  open,                              
        DBITERR                   =>  open                               
        );
  end generate YES_V6_OR_S6;



end implementation;
