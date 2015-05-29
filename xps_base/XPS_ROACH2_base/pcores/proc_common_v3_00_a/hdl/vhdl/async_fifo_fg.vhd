-------------------------------------------------------------------------------
-- $Id: async_fifo_fg.vhd,v 1.5.20.3 2010/02/09 20:15:59 dougt Exp $
-------------------------------------------------------------------------------
-- async_fifo_fg.vhd
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
-- Filename:        async_fifo_fg.vhd
--
-- Description:     
-- This HDL file adapts the legacy CoreGen Async FIFO interface to the new                
-- FIFO Generator async FIFO interface. This wrapper facilitates the "on
-- the fly" call of FIFO Generator during design implementation.                
--                  
--                  
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:   
--              async_fifo_fg.vhd
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
-- Date:            $1/15/2008$
--
-- History:
--   DET   1/15/2008       Initial Version
-- 
--     DET     7/30/2008     for EDK 11.1
-- ~~~~~~
--     - Added parameter C_ALLOW_2N_DEPTH to enable use of FIFO Generator
--       feature of specifing 2**N depth of FIFO, Legacy CoreGen Async FIFOs
--       only allowed (2**N)-1 depth specification. Parameter is defalted to 
--       the legacy CoreGen method so current users are not impacted.
--     - Incorporated calculation and assignment corrections for the Read and 
--       Write Pointer Widths.
--     - Upgraded to FIFO Generator Version 4.3.
--     - Corrected a swap of the Rd_Err and the Wr_Err connections on the FIFO
--       Generator instance.
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
use proc_common_v3_00_a.proc_common_pkg.all;
use proc_common_v3_00_a.coregen_comp_defs.all;
use proc_common_v3_00_a.family_support.all;


-- synopsys translate_off
library XilinxCoreLib;
--use XilinxCoreLib.all;
-- synopsys translate_on


-------------------------------------------------------------------------------

entity async_fifo_fg is
  generic (
        C_ALLOW_2N_DEPTH   : Integer := 0;  -- New paramter to leverage FIFO Gen 2**N depth
        C_FAMILY           : String  := "virtex5";  -- new for FIFO Gen
        C_DATA_WIDTH       : integer := 16;
        C_ENABLE_RLOCS     : integer := 0 ;  -- not supported in FG
        C_FIFO_DEPTH       : integer := 15;
        C_HAS_ALMOST_EMPTY : integer := 1 ;
        C_HAS_ALMOST_FULL  : integer := 1 ;
        C_HAS_RD_ACK       : integer := 0 ;
        C_HAS_RD_COUNT     : integer := 1 ;
        C_HAS_RD_ERR       : integer := 0 ;
        C_HAS_WR_ACK       : integer := 0 ;
        C_HAS_WR_COUNT     : integer := 1 ;
        C_HAS_WR_ERR       : integer := 0 ;
        C_RD_ACK_LOW       : integer := 0 ;
        C_RD_COUNT_WIDTH   : integer := 3 ;
        C_RD_ERR_LOW       : integer := 0 ;
        C_USE_BLOCKMEM     : integer := 1 ;  -- 0 = distributed RAM, 1 = BRAM
        C_WR_ACK_LOW       : integer := 0 ;
        C_WR_COUNT_WIDTH   : integer := 3 ;
        C_WR_ERR_LOW       : integer := 0   
    );
  port (
        Din            : in std_logic_vector(C_DATA_WIDTH-1 downto 0) := (others => '0');
        Wr_en          : in std_logic := '1';
        Wr_clk         : in std_logic := '1';
        Rd_en          : in std_logic := '0';
        Rd_clk         : in std_logic := '1';
        Ainit          : in std_logic := '1';   
        Dout           : out std_logic_vector(C_DATA_WIDTH-1 downto 0);
        Full           : out std_logic; 
        Empty          : out std_logic; 
        Almost_full    : out std_logic;  
        Almost_empty   : out std_logic;  
        Wr_count       : out std_logic_vector(C_WR_COUNT_WIDTH-1 downto 0);
        Rd_count       : out std_logic_vector(C_RD_COUNT_WIDTH-1 downto 0);
        Rd_ack         : out std_logic;
        Rd_err         : out std_logic;
        Wr_ack         : out std_logic;
        Wr_err         : out std_logic
    );

end entity async_fifo_fg;


architecture implementation of async_fifo_fg is

 -- Function delarations 
    
    
    -------------------------------------------------------------------
    -- Function
    --
    -- Function Name: GetMemType
    --
    -- Function Description:
    -- Generates the required integer value for the FG instance assignment
    -- of the C_MEMORY_TYPE parameter. Derived from
    -- the input memory type parameter C_USE_BLOCKMEM.
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
    
                                    
    
  
  
  
  
  
  -- Constant Declarations
    
    Constant FAM_IS_V6_OR_S6     : boolean := (equalIgnoringCase(C_FAMILY, "virtex6" ) or 
                                               equalIgnoringCase(C_FAMILY, "spartan6"));
    
    Constant FAM_IS_NOT_V6_OR_S6 : boolean := not(FAM_IS_V6_OR_S6);
    
    Constant FG_MEM_TYPE         : integer := GetMemType(C_USE_BLOCKMEM);
    
    
    
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
    Constant FG_IMP_TYPE         : integer := 2;
    
    
    

begin --(architecture implementation)

 
 
 ------------------------------------------------------------
 -- If Generate
 --
 -- Label: LEGACY_COREGEN_DEPTH
 --
 -- If Generate Description:
 --     This IfGen implements the FIFO Generator call where
 -- the User specified depth and count widths follow the 
 -- legacy CoreGen Async FIFO requirements of depth being 
 -- (2**N)-1 and the count widths set to reflect the (2**N)-1
 -- FIFO depth. 
 --
 -- Special Note:
 -- The legacy CoreGen Async FIFOs would only support fifo depths of (2**n)-1 
 -- and the Dcount widths were 1 less than if a full 2**n depth were supported.
 -- Thus legacy IP will be calling this wrapper with the (2**n)-1 FIFo depths
 -- specified and the Dcount widths smaller by 1 bit.
 -- This wrapper file has to account for this since the new FIFO Generator 
 -- does not follow this convention for Async FIFOs and expects depths to 
 -- be specified in full 2**n values.
 --
 ------------------------------------------------------------
 LEGACY_COREGEN_DEPTH : if (C_ALLOW_2N_DEPTH = 0) generate
 
  -- IfGen Constant Declarations -------------
   
   -- See Special Note above for reasoning behind
   -- this adjustment of the requested FIFO depth and data count
   -- widths.
   Constant ADJUSTED_AFIFO_DEPTH : integer := C_FIFO_DEPTH+1;
   Constant ADJUSTED_RDCNT_WIDTH : integer := C_RD_COUNT_WIDTH;
   Constant ADJUSTED_WRCNT_WIDTH : integer := C_WR_COUNT_WIDTH;
   
   -- The programable thresholds are not used so this is housekeeping.
   Constant PROG_FULL_THRESH_ASSERT_VAL : integer := ADJUSTED_AFIFO_DEPTH-3;
   Constant PROG_FULL_THRESH_NEGATE_VAL : integer := ADJUSTED_AFIFO_DEPTH-4;
 
    
    -- The parameters C_RD_PNTR_WIDTH and C_WR_PNTR_WIDTH for Fifo_generator_v4_3 core 
    -- must be in the range of 4 thru 22.  The setting is dependant upon the 
    -- log2 function of the MIN and MAX FIFO DEPTH settings in coregen.  Since Async FIFOs
    -- previous to development of fifo generator do not support separate read and 
    -- write fifo widths (and depths dependant upon the widths) both of the pointer value 
    -- calculations below will use the parameter ADJUSTED_AFIFO_DEPTH.  The valid range for 
    -- the ADJUSTED_AFIFO_DEPTH is 16 to 65536 (the async FIFO range is 15 to 65,535...it 
    -- must be equal to (2^N-1;, N = 4 to 16) per DS232 November 11, 2004 - 
    -- Asynchronous FIFO v6.1)                            
    Constant ADJUSTED_RD_PNTR_WIDTH : integer range 4 to 22 := log2(ADJUSTED_AFIFO_DEPTH);
    Constant ADJUSTED_WR_PNTR_WIDTH : integer range 4 to 22 := log2(ADJUSTED_AFIFO_DEPTH);

 
    -- Constant zeros for programmable threshold inputs
    Constant PROG_RDTHRESH_ZEROS : std_logic_vector(ADJUSTED_RD_PNTR_WIDTH-1
                                   DOWNTO 0) := (OTHERS => '0');
    Constant PROG_WRTHRESH_ZEROS : std_logic_vector(ADJUSTED_WR_PNTR_WIDTH-1 
                                   DOWNTO 0) := (OTHERS => '0');
    
      
  -- IfGen Signal Declarations --------------
  
   Signal sig_full_fifo_rdcnt : std_logic_vector(ADJUSTED_RDCNT_WIDTH-1 DOWNTO 0);
   Signal sig_full_fifo_wrcnt : std_logic_vector(ADJUSTED_WRCNT_WIDTH-1 DOWNTO 0);


 
   begin
    
     -- Rip the LS bits of the write data count and assign to Write Count 
     -- output port  
     Wr_count  <= sig_full_fifo_wrcnt(C_WR_COUNT_WIDTH-1 downto 0);
 
     -- Rip the LS bits of the read data count and assign to Read Count 
     -- output port  
     Rd_count  <= sig_full_fifo_rdcnt(C_RD_COUNT_WIDTH-1 downto 0);
 
 
     
     ------------------------------------------------------------
     -- If Generate
     --
     -- Label: NO_S6_OR_V6
     --
     -- If Generate Description:
     --  This IFGen Implemets the FIFO using FIFO Generator 4.3
     --  for FPGA Families other than Virtex-6 and Spartan-6.
     --
     ------------------------------------------------------------
     NO_S6_OR_V6 : if (FAM_IS_NOT_V6_OR_S6) generate
     
       begin

         -------------------------------------------------------------------------------
         -- Instantiate the generalized FIFO Generator instance
         --
         -- NOTE:
         -- DO NOT CHANGE TO DIRECT ENTITY INSTANTIATION!!!
         -- This is a Coregen FIFO Generator Call module for 
         -- legacy BRAM implementations of an Async FIFo.
         --
         -------------------------------------------------------------------------------
         I_ASYNC_FIFO_BRAM : fifo_generator_v4_3
            generic map(
              C_COMMON_CLOCK                 =>  0,   
              C_COUNT_TYPE                   =>  0,   
              C_DATA_COUNT_WIDTH             =>  ADJUSTED_WRCNT_WIDTH,   
              C_DEFAULT_VALUE                =>  "BlankString",          
              C_DIN_WIDTH                    =>  C_DATA_WIDTH,   
              C_DOUT_RST_VAL                 =>  "0",   
              C_DOUT_WIDTH                   =>  C_DATA_WIDTH,   
              C_ENABLE_RLOCS                 =>  C_ENABLE_RLOCS,   
              C_FAMILY                       =>  C_FAMILY,             
              C_HAS_ALMOST_EMPTY             =>  C_HAS_ALMOST_EMPTY,   
              C_HAS_ALMOST_FULL              =>  C_HAS_ALMOST_FULL,   
              C_HAS_BACKUP                   =>  0,   
              C_HAS_DATA_COUNT               =>  0,   
              C_HAS_MEMINIT_FILE             =>  0,   
              C_HAS_OVERFLOW                 =>  C_HAS_WR_ERR,   
              C_HAS_RD_DATA_COUNT            =>  C_HAS_RD_COUNT,   
              C_HAS_RD_RST                   =>  0,   
              C_HAS_RST                      =>  1,   
              C_HAS_SRST                     =>  0,   
              C_HAS_UNDERFLOW                =>  C_HAS_RD_ERR,   
              C_HAS_VALID                    =>  C_HAS_RD_ACK,   
              C_HAS_WR_ACK                   =>  C_HAS_WR_ACK,   
              C_HAS_WR_DATA_COUNT            =>  C_HAS_WR_COUNT,   
              C_HAS_WR_RST                   =>  0,   
              C_IMPLEMENTATION_TYPE          =>  FG_IMP_TYPE,     
              C_INIT_WR_PNTR_VAL             =>  0,   
              C_MEMORY_TYPE                  =>  FG_MEM_TYPE,      
              C_MIF_FILE_NAME                =>  "BlankString",    
              C_OPTIMIZATION_MODE            =>  0,   
              C_OVERFLOW_LOW                 =>  C_WR_ERR_LOW,   
              C_PRELOAD_REGS                 =>  0,   
              C_PRELOAD_LATENCY              =>  1,   
              C_PRIM_FIFO_TYPE               =>  "512x36",  -- only used for V5 Hard FIFO   
              C_PROG_EMPTY_THRESH_ASSERT_VAL =>  2,   
              C_PROG_EMPTY_THRESH_NEGATE_VAL =>  3,   
              C_PROG_EMPTY_TYPE              =>  0,   
              C_PROG_FULL_THRESH_ASSERT_VAL  =>  PROG_FULL_THRESH_ASSERT_VAL,   
              C_PROG_FULL_THRESH_NEGATE_VAL  =>  PROG_FULL_THRESH_NEGATE_VAL,   
              C_PROG_FULL_TYPE               =>  0,   
              C_RD_DATA_COUNT_WIDTH          =>  ADJUSTED_RDCNT_WIDTH,   
              C_RD_DEPTH                     =>  ADJUSTED_AFIFO_DEPTH,   
              C_RD_FREQ                      =>  1,   
              C_RD_PNTR_WIDTH                =>  ADJUSTED_RD_PNTR_WIDTH,   
              C_UNDERFLOW_LOW                =>  C_RD_ERR_LOW,   
              C_USE_DOUT_RST                 =>  1,   
              C_USE_EMBEDDED_REG             =>  0,   
              C_USE_FIFO16_FLAGS             =>  0,   
              C_USE_FWFT_DATA_COUNT          =>  0,   
              C_VALID_LOW                    =>  0,   
              C_WR_ACK_LOW                   =>  C_WR_ACK_LOW,   
              C_WR_DATA_COUNT_WIDTH          =>  ADJUSTED_WRCNT_WIDTH,   
              C_WR_DEPTH                     =>  ADJUSTED_AFIFO_DEPTH,   
              C_WR_FREQ                      =>  1,   
              C_WR_PNTR_WIDTH                =>  ADJUSTED_WR_PNTR_WIDTH,   
              C_WR_RESPONSE_LATENCY          =>  1,   
              C_USE_ECC                      =>  0,   
              C_FULL_FLAGS_RST_VAL           =>  0,   
              C_HAS_INT_CLK                  =>  0,                                                   
              C_MSGON_VAL                    =>  1 --cannot find info on this, leave at default : integer := 1
             )
            port map (
              CLK                       =>  '0',                  
              BACKUP                    =>  '0',                  
              BACKUP_MARKER             =>  '0',                  
              DIN                       =>  Din,                  
              PROG_EMPTY_THRESH         =>  PROG_RDTHRESH_ZEROS,  
              PROG_EMPTY_THRESH_ASSERT  =>  PROG_RDTHRESH_ZEROS,  
              PROG_EMPTY_THRESH_NEGATE  =>  PROG_RDTHRESH_ZEROS,  
              PROG_FULL_THRESH          =>  PROG_WRTHRESH_ZEROS,  
              PROG_FULL_THRESH_ASSERT   =>  PROG_WRTHRESH_ZEROS,  
              PROG_FULL_THRESH_NEGATE   =>  PROG_WRTHRESH_ZEROS,  
              RD_CLK                    =>  Rd_clk,               
              RD_EN                     =>  Rd_en,                
              RD_RST                    =>  Ainit,                
              RST                       =>  Ainit,                
              SRST                      =>  '0',                  
              WR_CLK                    =>  Wr_clk,               
              WR_EN                     =>  Wr_en,                
              WR_RST                    =>  Ainit,                
              INT_CLK                   =>  '0',                  

              ALMOST_EMPTY              =>  Almost_empty,         
              ALMOST_FULL               =>  Almost_full,          
              DATA_COUNT                =>  open,                 
              DOUT                      =>  Dout,                 
              EMPTY                     =>  Empty,                
              FULL                      =>  Full,                 
              OVERFLOW                  =>  Wr_err,               
              PROG_EMPTY                =>  open,                 
              PROG_FULL                 =>  open,                 
              VALID                     =>  Rd_ack,               
              RD_DATA_COUNT             =>  sig_full_fifo_rdcnt,  
              UNDERFLOW                 =>  Rd_err,               
              WR_ACK                    =>  Wr_ack,               
              WR_DATA_COUNT             =>  sig_full_fifo_wrcnt,  
              SBITERR                   =>  open,                 
              DBITERR                   =>  open                  
             );
           
       end generate NO_S6_OR_V6;
  




     ------------------------------------------------------------
     -- If Generate
     --
     -- Label: YES_S6_OR_V6
     --
     -- If Generate Description:
     --  This IFGen Implemets the FIFO using FIFO Generator 5.3
     --  for FPGA Families that are Virtex-6 and Spartan-6.
     --
     ------------------------------------------------------------
     YES_S6_OR_V6 : if (FAM_IS_V6_OR_S6) generate
     
       begin

         -------------------------------------------------------------------------------
         -- Instantiate the generalized FIFO Generator instance
         --
         -- NOTE:
         -- DO NOT CHANGE TO DIRECT ENTITY INSTANTIATION!!!
         -- This is a Coregen FIFO Generator Call module for 
         -- legacy BRAM implementations of an Async FIFo.
         --
         -------------------------------------------------------------------------------
         I_ASYNC_FIFO_BRAM : fifo_generator_v5_3
            generic map(
              C_COMMON_CLOCK                 =>  0,   
              C_COUNT_TYPE                   =>  0,   
              C_DATA_COUNT_WIDTH             =>  ADJUSTED_WRCNT_WIDTH,   
              C_DEFAULT_VALUE                =>  "BlankString",          
              C_DIN_WIDTH                    =>  C_DATA_WIDTH,   
              C_DOUT_RST_VAL                 =>  "0",   
              C_DOUT_WIDTH                   =>  C_DATA_WIDTH,   
              C_ENABLE_RLOCS                 =>  C_ENABLE_RLOCS,   
              C_FAMILY                       =>  C_FAMILY,             
              C_HAS_ALMOST_EMPTY             =>  C_HAS_ALMOST_EMPTY,   
              C_HAS_ALMOST_FULL              =>  C_HAS_ALMOST_FULL,   
              C_HAS_BACKUP                   =>  0,   
              C_HAS_DATA_COUNT               =>  0,   
              C_HAS_MEMINIT_FILE             =>  0,   
              C_HAS_OVERFLOW                 =>  C_HAS_WR_ERR,   
              C_HAS_RD_DATA_COUNT            =>  C_HAS_RD_COUNT,   
              C_HAS_RD_RST                   =>  0,   
              C_HAS_RST                      =>  1,   
              C_HAS_SRST                     =>  0,   
              C_HAS_UNDERFLOW                =>  C_HAS_RD_ERR,   
              C_HAS_VALID                    =>  C_HAS_RD_ACK,   
              C_HAS_WR_ACK                   =>  C_HAS_WR_ACK,   
              C_HAS_WR_DATA_COUNT            =>  C_HAS_WR_COUNT,   
              C_HAS_WR_RST                   =>  0,   
              C_IMPLEMENTATION_TYPE          =>  FG_IMP_TYPE,     
              C_INIT_WR_PNTR_VAL             =>  0,   
              C_MEMORY_TYPE                  =>  FG_MEM_TYPE,      
              C_MIF_FILE_NAME                =>  "BlankString",    
              C_OPTIMIZATION_MODE            =>  0,   
              C_OVERFLOW_LOW                 =>  C_WR_ERR_LOW,   
              C_PRELOAD_REGS                 =>  0,   
              C_PRELOAD_LATENCY              =>  1,   
              C_PRIM_FIFO_TYPE               =>  "512x36",  -- only used for V5 Hard FIFO   
              C_PROG_EMPTY_THRESH_ASSERT_VAL =>  2,   
              C_PROG_EMPTY_THRESH_NEGATE_VAL =>  3,   
              C_PROG_EMPTY_TYPE              =>  0,   
              C_PROG_FULL_THRESH_ASSERT_VAL  =>  PROG_FULL_THRESH_ASSERT_VAL,   
              C_PROG_FULL_THRESH_NEGATE_VAL  =>  PROG_FULL_THRESH_NEGATE_VAL,   
              C_PROG_FULL_TYPE               =>  0,   
              C_RD_DATA_COUNT_WIDTH          =>  ADJUSTED_RDCNT_WIDTH,   
              C_RD_DEPTH                     =>  ADJUSTED_AFIFO_DEPTH,   
              C_RD_FREQ                      =>  1,   
              C_RD_PNTR_WIDTH                =>  ADJUSTED_RD_PNTR_WIDTH,   
              C_UNDERFLOW_LOW                =>  C_RD_ERR_LOW,   
              C_USE_DOUT_RST                 =>  1,   
              C_USE_EMBEDDED_REG             =>  0,   
              C_USE_FIFO16_FLAGS             =>  0,   
              C_USE_FWFT_DATA_COUNT          =>  0,   
              C_VALID_LOW                    =>  0,   
              C_WR_ACK_LOW                   =>  C_WR_ACK_LOW,   
              C_WR_DATA_COUNT_WIDTH          =>  ADJUSTED_WRCNT_WIDTH,   
              C_WR_DEPTH                     =>  ADJUSTED_AFIFO_DEPTH,   
              C_WR_FREQ                      =>  1,   
              C_WR_PNTR_WIDTH                =>  ADJUSTED_WR_PNTR_WIDTH,   
              C_WR_RESPONSE_LATENCY          =>  1,   
              C_USE_ECC                      =>  0,   
              C_FULL_FLAGS_RST_VAL           =>  0,   
              C_HAS_INT_CLK                  =>  0,                                                   
              C_MSGON_VAL                    =>  1,
              C_ENABLE_RST_SYNC              =>  1,  -- new FG 5.1/5.2
              C_ERROR_INJECTION_TYPE         =>  0   -- new FG 5.1/5.2
             )
            port map (
              CLK                       =>  '0',                  
              BACKUP                    =>  '0',                  
              BACKUP_MARKER             =>  '0',                  
              DIN                       =>  Din,                  
              PROG_EMPTY_THRESH         =>  PROG_RDTHRESH_ZEROS,  
              PROG_EMPTY_THRESH_ASSERT  =>  PROG_RDTHRESH_ZEROS,  
              PROG_EMPTY_THRESH_NEGATE  =>  PROG_RDTHRESH_ZEROS,  
              PROG_FULL_THRESH          =>  PROG_WRTHRESH_ZEROS,  
              PROG_FULL_THRESH_ASSERT   =>  PROG_WRTHRESH_ZEROS,  
              PROG_FULL_THRESH_NEGATE   =>  PROG_WRTHRESH_ZEROS,  
              RD_CLK                    =>  Rd_clk,               
              RD_EN                     =>  Rd_en,                
              RD_RST                    =>  Ainit,                
              RST                       =>  Ainit,                
              SRST                      =>  '0',                  
              WR_CLK                    =>  Wr_clk,               
              WR_EN                     =>  Wr_en,                
              WR_RST                    =>  Ainit,                
              INT_CLK                   =>  '0',                  
              INJECTDBITERR             =>  '0', -- new FG 5.1/5.2    
              INJECTSBITERR             =>  '0', -- new FG 5.1/5.2    

              ALMOST_EMPTY              =>  Almost_empty,         
              ALMOST_FULL               =>  Almost_full,          
              DATA_COUNT                =>  open,                 
              DOUT                      =>  Dout,                 
              EMPTY                     =>  Empty,                
              FULL                      =>  Full,                 
              OVERFLOW                  =>  Wr_err,               
              PROG_EMPTY                =>  open,                 
              PROG_FULL                 =>  open,                 
              VALID                     =>  Rd_ack,               
              RD_DATA_COUNT             =>  sig_full_fifo_rdcnt,  
              UNDERFLOW                 =>  Rd_err,               
              WR_ACK                    =>  Wr_ack,               
              WR_DATA_COUNT             =>  sig_full_fifo_wrcnt,  
              SBITERR                   =>  open,                 
              DBITERR                   =>  open                  
             );

       end generate YES_S6_OR_V6;
   
   

 
 
    end generate LEGACY_COREGEN_DEPTH;
    
    
    
    
    
    
    
   
   
   
   
 

 ------------------------------------------------------------
 -- If Generate
 --
 -- Label: USE_2N_DEPTH
 --
 -- If Generate Description:
 --     This IfGen implements the FIFO Generator call where
 -- the User may specify depth and count widths of 2**N 
 -- for Async FIFOs The associated count widths are set to 
 -- reflect the 2**N FIFO depth.
 --
 ------------------------------------------------------------
 USE_2N_DEPTH : if (C_ALLOW_2N_DEPTH = 1) generate
 
    -- The programable thresholds are not used so this is housekeeping.
    Constant PROG_FULL_THRESH_ASSERT_VAL : integer := C_FIFO_DEPTH-3;
    Constant PROG_FULL_THRESH_NEGATE_VAL : integer := C_FIFO_DEPTH-4;
 
    
    Constant RD_PNTR_WIDTH : integer range 4 to 22 := log2(C_FIFO_DEPTH);
    Constant WR_PNTR_WIDTH : integer range 4 to 22 := log2(C_FIFO_DEPTH);
    
 
    -- Constant zeros for programmable threshold inputs
    Constant PROG_RDTHRESH_ZEROS : std_logic_vector(RD_PNTR_WIDTH-1
                                   DOWNTO 0) := (OTHERS => '0');
    Constant PROG_WRTHRESH_ZEROS : std_logic_vector(WR_PNTR_WIDTH-1 
                                   DOWNTO 0) := (OTHERS => '0');
    
    
    
    
    
  
  -- Signals Declarations
    Signal sig_full_fifo_rdcnt : std_logic_vector(C_RD_COUNT_WIDTH-1 DOWNTO 0);
    Signal sig_full_fifo_wrcnt : std_logic_vector(C_WR_COUNT_WIDTH-1 DOWNTO 0);


    begin
    
      -- Rip the LS bits of the write data count and assign to Write Count 
      -- output port  
      Wr_count  <= sig_full_fifo_wrcnt(C_WR_COUNT_WIDTH-1 downto 0);
   
      -- Rip the LS bits of the read data count and assign to Read Count 
      -- output port  
      Rd_count  <= sig_full_fifo_rdcnt(C_RD_COUNT_WIDTH-1 downto 0);
 
 
     ------------------------------------------------------------
     -- If Generate
     --
     -- Label: NO_S6_OR_V6
     --
     -- If Generate Description:
     --  This IFGen Implemets the FIFO using FIFO Generator 4.3
     --  for FPGA Families other than Virtex-6 and Spartan-6.
     --
     ------------------------------------------------------------
     NO_S6_OR_V6 : if (FAM_IS_NOT_V6_OR_S6) generate
     
       begin

         -------------------------------------------------------------------------------
         -- Instantiate the generalized FIFO Generator instance
         --
         -- NOTE:
         -- DO NOT CHANGE TO DIRECT ENTITY INSTANTIATION!!!
         -- This is a Coregen FIFO Generator Call module for 
         -- legacy BRAM implementations of an Async FIFo.
         --
         -------------------------------------------------------------------------------
         I_ASYNC_FIFO_BRAM : fifo_generator_v4_3
            generic map(
              C_COMMON_CLOCK                 =>  0,                                              
              C_COUNT_TYPE                   =>  0,                                              
              C_DATA_COUNT_WIDTH             =>  C_WR_COUNT_WIDTH,                               
              C_DEFAULT_VALUE                =>  "BlankString",                                  
              C_DIN_WIDTH                    =>  C_DATA_WIDTH,                                   
              C_DOUT_RST_VAL                 =>  "0",                                            
              C_DOUT_WIDTH                   =>  C_DATA_WIDTH,                                   
              C_ENABLE_RLOCS                 =>  C_ENABLE_RLOCS,                                 
              C_FAMILY                       =>  C_FAMILY,                                       
              C_HAS_ALMOST_EMPTY             =>  C_HAS_ALMOST_EMPTY,                             
              C_HAS_ALMOST_FULL              =>  C_HAS_ALMOST_FULL,                              
              C_HAS_BACKUP                   =>  0,                                              
              C_HAS_DATA_COUNT               =>  0,                                              
              C_HAS_MEMINIT_FILE             =>  0,                                              
              C_HAS_OVERFLOW                 =>  C_HAS_WR_ERR,                                   
              C_HAS_RD_DATA_COUNT            =>  C_HAS_RD_COUNT,                                 
              C_HAS_RD_RST                   =>  0,                                              
              C_HAS_RST                      =>  1,                                              
              C_HAS_SRST                     =>  0,                                              
              C_HAS_UNDERFLOW                =>  C_HAS_RD_ERR,                                   
              C_HAS_VALID                    =>  C_HAS_RD_ACK,                                   
              C_HAS_WR_ACK                   =>  C_HAS_WR_ACK,                                   
              C_HAS_WR_DATA_COUNT            =>  C_HAS_WR_COUNT,                                 
              C_HAS_WR_RST                   =>  0,                                              
              C_IMPLEMENTATION_TYPE          =>  FG_IMP_TYPE,                                    
              C_INIT_WR_PNTR_VAL             =>  0,                                              
              C_MEMORY_TYPE                  =>  FG_MEM_TYPE,                                    
              C_MIF_FILE_NAME                =>  "BlankString",                                  
              C_OPTIMIZATION_MODE            =>  0,                                              
              C_OVERFLOW_LOW                 =>  C_WR_ERR_LOW,                                   
              C_PRELOAD_REGS                 =>  0,                                              
              C_PRELOAD_LATENCY              =>  1,                                              
              C_PRIM_FIFO_TYPE               =>  "512x36",  -- only used for V5 Hard FIFO        
              C_PROG_EMPTY_THRESH_ASSERT_VAL =>  2,                                              
              C_PROG_EMPTY_THRESH_NEGATE_VAL =>  3,                                              
              C_PROG_EMPTY_TYPE              =>  0,                                              
              C_PROG_FULL_THRESH_ASSERT_VAL  =>  PROG_FULL_THRESH_ASSERT_VAL,                    
              C_PROG_FULL_THRESH_NEGATE_VAL  =>  PROG_FULL_THRESH_NEGATE_VAL,                    
              C_PROG_FULL_TYPE               =>  0,                                              
              C_RD_DATA_COUNT_WIDTH          =>  C_RD_COUNT_WIDTH,                               
              C_RD_DEPTH                     =>  C_FIFO_DEPTH,                                   
              C_RD_FREQ                      =>  1,                                              
              C_RD_PNTR_WIDTH                =>  RD_PNTR_WIDTH,                                  
              C_UNDERFLOW_LOW                =>  C_RD_ERR_LOW,                                   
              C_USE_DOUT_RST                 =>  1,                                              
              C_USE_EMBEDDED_REG             =>  0,                                              
              C_USE_FIFO16_FLAGS             =>  0,                                              
              C_USE_FWFT_DATA_COUNT          =>  0,                                              
              C_VALID_LOW                    =>  0,                                              
              C_WR_ACK_LOW                   =>  C_WR_ACK_LOW,                                   
              C_WR_DATA_COUNT_WIDTH          =>  C_WR_COUNT_WIDTH,                               
              C_WR_DEPTH                     =>  C_FIFO_DEPTH,                                   
              C_WR_FREQ                      =>  1,                                              
              C_WR_PNTR_WIDTH                =>  WR_PNTR_WIDTH,                                  
              C_WR_RESPONSE_LATENCY          =>  1,                                              
              C_USE_ECC                      =>  0,                                              
              C_FULL_FLAGS_RST_VAL           =>  0,                                              
              C_HAS_INT_CLK                  =>  0,                                              
              C_MSGON_VAL                    =>  1 
             )
            port map (
              CLK                       =>  '0',                  -- : IN  std_logic := '0';
              BACKUP                    =>  '0',                  -- : IN  std_logic := '0';
              BACKUP_MARKER             =>  '0',                  -- : IN  std_logic := '0';
              DIN                       =>  Din,                  -- : IN  std_logic_vector(C_DIN_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
              PROG_EMPTY_THRESH         =>  PROG_RDTHRESH_ZEROS,  -- : IN  std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
              PROG_EMPTY_THRESH_ASSERT  =>  PROG_RDTHRESH_ZEROS,  -- : IN  std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
              PROG_EMPTY_THRESH_NEGATE  =>  PROG_RDTHRESH_ZEROS,  -- : IN  std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
              PROG_FULL_THRESH          =>  PROG_WRTHRESH_ZEROS,  -- : IN  std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
              PROG_FULL_THRESH_ASSERT   =>  PROG_WRTHRESH_ZEROS,  -- : IN  std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
              PROG_FULL_THRESH_NEGATE   =>  PROG_WRTHRESH_ZEROS,  -- : IN  std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
              RD_CLK                    =>  Rd_clk,               -- : IN  std_logic := '0';
              RD_EN                     =>  Rd_en,                -- : IN  std_logic := '0';
              RD_RST                    =>  Ainit,                -- : IN  std_logic := '0';
              RST                       =>  Ainit,                -- : IN  std_logic := '0';
              SRST                      =>  '0',                  -- : IN  std_logic := '0';
              WR_CLK                    =>  Wr_clk,               -- : IN  std_logic := '0';
              WR_EN                     =>  Wr_en,                -- : IN  std_logic := '0';
              WR_RST                    =>  Ainit,                -- : IN  std_logic := '0';
              INT_CLK                   =>  '0',                  -- : IN  std_logic := '0';

              ALMOST_EMPTY              =>  Almost_empty,         -- : OUT std_logic;
              ALMOST_FULL               =>  Almost_full,          -- : OUT std_logic;
              DATA_COUNT                =>  open,                 -- : OUT std_logic_vector(C_DATA_COUNT_WIDTH-1 DOWNTO 0);
              DOUT                      =>  Dout,                 -- : OUT std_logic_vector(C_DOUT_WIDTH-1 DOWNTO 0);
              EMPTY                     =>  Empty,                -- : OUT std_logic;
              FULL                      =>  Full,                 -- : OUT std_logic;
              OVERFLOW                  =>  Rd_err,               -- : OUT std_logic;
              PROG_EMPTY                =>  open,                 -- : OUT std_logic;
              PROG_FULL                 =>  open,                 -- : OUT std_logic;
              VALID                     =>  Rd_ack,               -- : OUT std_logic;
              RD_DATA_COUNT             =>  sig_full_fifo_rdcnt,  -- : OUT std_logic_vector(C_RD_DATA_COUNT_WIDTH-1 DOWNTO 0);
              UNDERFLOW                 =>  Wr_err,               -- : OUT std_logic;
              WR_ACK                    =>  Wr_ack,               -- : OUT std_logic;
              WR_DATA_COUNT             =>  sig_full_fifo_wrcnt,  -- : OUT std_logic_vector(C_WR_DATA_COUNT_WIDTH-1 DOWNTO 0);
              SBITERR                   =>  open,                 -- : OUT std_logic;
              DBITERR                   =>  open                  -- : OUT std_logic
             );
           
       end generate NO_S6_OR_V6;
  




     ------------------------------------------------------------
     -- If Generate
     --
     -- Label: YES_S6_OR_V6
     --
     -- If Generate Description:
     --  This IFGen Implemets the FIFO using FIFO Generator 5.3
     --  for FPGA Families that are Virtex-6 and Spartan-6.
     --
     ------------------------------------------------------------
     YES_S6_OR_V6 : if (FAM_IS_V6_OR_S6) generate
     
       begin

         -------------------------------------------------------------------------------
         -- Instantiate the generalized FIFO Generator instance
         --
         -- NOTE:
         -- DO NOT CHANGE TO DIRECT ENTITY INSTANTIATION!!!
         -- This is a Coregen FIFO Generator Call module for 
         -- legacy BRAM implementations of an Async FIFo.
         --
         -------------------------------------------------------------------------------
         I_ASYNC_FIFO_BRAM : fifo_generator_v5_3
            generic map(
              C_COMMON_CLOCK                 =>  0,                                              
              C_COUNT_TYPE                   =>  0,                                              
              C_DATA_COUNT_WIDTH             =>  C_WR_COUNT_WIDTH,                               
              C_DEFAULT_VALUE                =>  "BlankString",                                  
              C_DIN_WIDTH                    =>  C_DATA_WIDTH,                                   
              C_DOUT_RST_VAL                 =>  "0",                                            
              C_DOUT_WIDTH                   =>  C_DATA_WIDTH,                                   
              C_ENABLE_RLOCS                 =>  C_ENABLE_RLOCS,                                 
              C_FAMILY                       =>  C_FAMILY,                                       
              C_HAS_ALMOST_EMPTY             =>  C_HAS_ALMOST_EMPTY,                             
              C_HAS_ALMOST_FULL              =>  C_HAS_ALMOST_FULL,                              
              C_HAS_BACKUP                   =>  0,                                              
              C_HAS_DATA_COUNT               =>  0,                                              
              C_HAS_MEMINIT_FILE             =>  0,                                              
              C_HAS_OVERFLOW                 =>  C_HAS_WR_ERR,                                   
              C_HAS_RD_DATA_COUNT            =>  C_HAS_RD_COUNT,                                 
              C_HAS_RD_RST                   =>  0,                                              
              C_HAS_RST                      =>  1,                                              
              C_HAS_SRST                     =>  0,                                              
              C_HAS_UNDERFLOW                =>  C_HAS_RD_ERR,                                   
              C_HAS_VALID                    =>  C_HAS_RD_ACK,                                   
              C_HAS_WR_ACK                   =>  C_HAS_WR_ACK,                                   
              C_HAS_WR_DATA_COUNT            =>  C_HAS_WR_COUNT,                                 
              C_HAS_WR_RST                   =>  0,                                              
              C_IMPLEMENTATION_TYPE          =>  FG_IMP_TYPE,                                    
              C_INIT_WR_PNTR_VAL             =>  0,                                              
              C_MEMORY_TYPE                  =>  FG_MEM_TYPE,                                    
              C_MIF_FILE_NAME                =>  "BlankString",                                  
              C_OPTIMIZATION_MODE            =>  0,                                              
              C_OVERFLOW_LOW                 =>  C_WR_ERR_LOW,                                   
              C_PRELOAD_REGS                 =>  0,                                              
              C_PRELOAD_LATENCY              =>  1,                                              
              C_PRIM_FIFO_TYPE               =>  "512x36",  -- only used for V5 Hard FIFO        
              C_PROG_EMPTY_THRESH_ASSERT_VAL =>  2,                                              
              C_PROG_EMPTY_THRESH_NEGATE_VAL =>  3,                                              
              C_PROG_EMPTY_TYPE              =>  0,                                              
              C_PROG_FULL_THRESH_ASSERT_VAL  =>  PROG_FULL_THRESH_ASSERT_VAL,                    
              C_PROG_FULL_THRESH_NEGATE_VAL  =>  PROG_FULL_THRESH_NEGATE_VAL,                    
              C_PROG_FULL_TYPE               =>  0,                                              
              C_RD_DATA_COUNT_WIDTH          =>  C_RD_COUNT_WIDTH,                               
              C_RD_DEPTH                     =>  C_FIFO_DEPTH,                                   
              C_RD_FREQ                      =>  1,                                              
              C_RD_PNTR_WIDTH                =>  RD_PNTR_WIDTH,                                  
              C_UNDERFLOW_LOW                =>  C_RD_ERR_LOW,                                   
              C_USE_DOUT_RST                 =>  1,                                              
              C_USE_EMBEDDED_REG             =>  0,                                              
              C_USE_FIFO16_FLAGS             =>  0,                                              
              C_USE_FWFT_DATA_COUNT          =>  0,                                              
              C_VALID_LOW                    =>  0,                                              
              C_WR_ACK_LOW                   =>  C_WR_ACK_LOW,                                   
              C_WR_DATA_COUNT_WIDTH          =>  C_WR_COUNT_WIDTH,                               
              C_WR_DEPTH                     =>  C_FIFO_DEPTH,                                   
              C_WR_FREQ                      =>  1,                                              
              C_WR_PNTR_WIDTH                =>  WR_PNTR_WIDTH,                                  
              C_WR_RESPONSE_LATENCY          =>  1,                                              
              C_USE_ECC                      =>  0,                                              
              C_FULL_FLAGS_RST_VAL           =>  0,                                              
              C_HAS_INT_CLK                  =>  0,                                                      
              C_MSGON_VAL                    =>  1,
              C_ENABLE_RST_SYNC              =>  1,  -- new FG 5.1
              C_ERROR_INJECTION_TYPE         =>  0   -- new FG 5.1
             )
            port map (
              CLK                       =>  '0',                  -- : IN  std_logic := '0';
              BACKUP                    =>  '0',                  -- : IN  std_logic := '0';
              BACKUP_MARKER             =>  '0',                  -- : IN  std_logic := '0';
              DIN                       =>  Din,                  -- : IN  std_logic_vector(C_DIN_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
              PROG_EMPTY_THRESH         =>  PROG_RDTHRESH_ZEROS,  -- : IN  std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
              PROG_EMPTY_THRESH_ASSERT  =>  PROG_RDTHRESH_ZEROS,  -- : IN  std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
              PROG_EMPTY_THRESH_NEGATE  =>  PROG_RDTHRESH_ZEROS,  -- : IN  std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
              PROG_FULL_THRESH          =>  PROG_WRTHRESH_ZEROS,  -- : IN  std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
              PROG_FULL_THRESH_ASSERT   =>  PROG_WRTHRESH_ZEROS,  -- : IN  std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
              PROG_FULL_THRESH_NEGATE   =>  PROG_WRTHRESH_ZEROS,  -- : IN  std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
              RD_CLK                    =>  Rd_clk,               -- : IN  std_logic := '0';
              RD_EN                     =>  Rd_en,                -- : IN  std_logic := '0';
              RD_RST                    =>  Ainit,                -- : IN  std_logic := '0';
              RST                       =>  Ainit,                -- : IN  std_logic := '0';
              SRST                      =>  '0',                  -- : IN  std_logic := '0';
              WR_CLK                    =>  Wr_clk,               -- : IN  std_logic := '0';
              WR_EN                     =>  Wr_en,                -- : IN  std_logic := '0';
              WR_RST                    =>  Ainit,                -- : IN  std_logic := '0';
              INT_CLK                   =>  '0',                  -- : IN  std_logic := '0';
              INJECTDBITERR             =>  '0', -- new FG 5.1    -- : IN  std_logic := '0';
              INJECTSBITERR             =>  '0', -- new FG 5.1    -- : IN  std_logic := '0';

              ALMOST_EMPTY              =>  Almost_empty,         -- : OUT std_logic;
              ALMOST_FULL               =>  Almost_full,          -- : OUT std_logic;
              DATA_COUNT                =>  open,                 -- : OUT std_logic_vector(C_DATA_COUNT_WIDTH-1 DOWNTO 0);
              DOUT                      =>  Dout,                 -- : OUT std_logic_vector(C_DOUT_WIDTH-1 DOWNTO 0);
              EMPTY                     =>  Empty,                -- : OUT std_logic;
              FULL                      =>  Full,                 -- : OUT std_logic;
              OVERFLOW                  =>  Rd_err,               -- : OUT std_logic;
              PROG_EMPTY                =>  open,                 -- : OUT std_logic;
              PROG_FULL                 =>  open,                 -- : OUT std_logic;
              VALID                     =>  Rd_ack,               -- : OUT std_logic;
              RD_DATA_COUNT             =>  sig_full_fifo_rdcnt,  -- : OUT std_logic_vector(C_RD_DATA_COUNT_WIDTH-1 DOWNTO 0);
              UNDERFLOW                 =>  Wr_err,               -- : OUT std_logic;
              WR_ACK                    =>  Wr_ack,               -- : OUT std_logic;
              WR_DATA_COUNT             =>  sig_full_fifo_wrcnt,  -- : OUT std_logic_vector(C_WR_DATA_COUNT_WIDTH-1 DOWNTO 0);
              SBITERR                   =>  open,                 -- : OUT std_logic;
              DBITERR                   =>  open                  -- : OUT std_logic
             );

       end generate YES_S6_OR_V6;
   
 
 
    end generate USE_2N_DEPTH;
    -----------------------------------------------------------------------
 
 

end implementation;
