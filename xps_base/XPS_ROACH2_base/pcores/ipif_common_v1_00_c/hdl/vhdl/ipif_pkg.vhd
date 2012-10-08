-------------------------------------------------------------------------------
-- $Id: ipif_pkg.vhd,v 1.3 2003/04/28 20:47:23 ostlerf Exp $
-------------------------------------------------------------------------------
-- IPIF Common Library Package
-------------------------------------------------------------------------------
--
--                  ****************************
--                  ** Copyright Xilinx, Inc. **
--                  ** All rights reserved.   **
--                  ****************************
--
-------------------------------------------------------------------------------
-- Filename:        ipif_pkg.vhd
-- Version:         Intital
-- Description:     This file contains the constants and functions used in the 
--                  ipif common library components.
--
-------------------------------------------------------------------------------
-- Structure:       
--
-------------------------------------------------------------------------------
-- Author:      DET
-- History:
--  DET         02/21/02      -- Created from proc_common_pkg.vhd
--
--  DET         03/13/02      -- PLB IPIF development updates
-- ^^^^^^
--              - Commented out string types and string functions due to an XST
--                problem with string arrays and functions. THe string array
--                processing functions were replaced with comperable functions
--                operating on integer arrays.
-- ~~~~~~
--
--
--     DET     4/30/2002     Initial
-- ~~~~~~
--     - Added three functions: rebuild_slv32_array, rebuild_slv64_array, and
--       rebuild_int_array to support removal of unused elements from the 
--       ARD arrays.
-- ^^^^^^ --
--
--     FLO     8/12/2002
-- ~~~~~~
--     - Added three functions: bits_needed_for_vac, bits_needed_for_occ,
--       and get_id_index_iboe.
--       (Removed provisional functions bits_needed_for_vacancy,
--        bits needed_for_occupancy, and bits_needed_for.)
-- ^^^^^^
--
--     FLO     3/24/2003
-- ~~~~~~
--     - Added dependent property paramters for channelized DMA.
--     - Added common property parameter array type.
--     - Definded the KEYHOLD_BURST common-property parameter.
-- ^^^^^^
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
-- need conversion function to convert reals/integers to std logic vectors
use ieee.std_logic_arith.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


package ipif_pkg is


-------------------------------------------------------------------------------
-- Type Declarations
-------------------------------------------------------------------------------
Type SLV32_ARRAY_TYPE is array (natural range <>) of std_logic_vector(0 to 31);
subtype SLV64_TYPE is std_logic_vector(0 to 63);
Type SLV64_ARRAY_TYPE is array (natural range <>) of SLV64_TYPE;
Type INTEGER_ARRAY_TYPE is array (natural range <>) of integer;
--  xst work around!!!   Type ARD_NAME_TYPE is array (natural range <>) of string(1 to 32);

--ToDo, at some time when this file is otherwise stable, remove the
-- "xst work around!!!" stuff. The work arounds are permanent, now.
-------------------------------------------------------------------------------
-- Function and Procedure Declarations
-------------------------------------------------------------------------------
function "=" (s1: in string; s2: in string) return boolean;

function equaluseCase( str1, str2 : STRING ) RETURN BOOLEAN;

function calc_num_ce (ce_num_array : INTEGER_ARRAY_TYPE) return integer;

--  xst work around!!!   function find_ard_name (name_array : ARD_NAME_TYPE;
--  xst work around!!!                           name       : string) return boolean;

--  xst work around!!!   function get_name_index (name_array :ARD_NAME_TYPE; 
--  xst work around!!!                            name         : string) return integer;

function calc_start_ce_index (ce_num_array : INTEGER_ARRAY_TYPE;
                              index        : integer) return integer;
                              
function get_min_dwidth (dwidth_array: INTEGER_ARRAY_TYPE) return integer;

function get_max_dwidth (dwidth_array: INTEGER_ARRAY_TYPE) return integer;

--  xst work around!!!   function find_a_dwidth (name_array  : ARD_NAME_TYPE; 
--  xst work around!!!                           dwidth_array: INTEGER_ARRAY_TYPE;
--  xst work around!!!                           name        : string;
--  xst work around!!!                           default     : integer) return integer;

function S32 (in_string : string) return string;



--  xst work around!!!   function cnt_ipif_blks (name_array : ARD_NAME_TYPE) return integer;

--  xst work around!!!   function get_ipif_dbus_index (name_array: ARD_NAME_TYPE;
--  xst work around!!!                                 name      : string)
--  xst work around!!!                                 return integer ;





--/////////////////////////////////////////////////////////////////////////////
 --  xst debug!!!   
 -- Hopefully temporary functions that use an array of integers to identify
 -- functions specified in the ARD arrays

function get_id_index (id_array :INTEGER_ARRAY_TYPE; 
                       id       : integer)
                       return integer;

function get_id_index_iboe (id_array :INTEGER_ARRAY_TYPE; 
                       id       : integer)
                       return integer;


function find_ard_id (id_array : INTEGER_ARRAY_TYPE;
                      id       : integer) return boolean;


function find_id_dwidth (id_array    : INTEGER_ARRAY_TYPE; 
                         dwidth_array: INTEGER_ARRAY_TYPE;
                         id          : integer;
                         default     : integer) 
                         return integer;


function cnt_ipif_id_blks (id_array : INTEGER_ARRAY_TYPE) return integer;

function get_ipif_id_dbus_index (id_array : INTEGER_ARRAY_TYPE;
                                 id          : integer)
                                 return integer ;


function rebuild_slv32_array (slv32_array     : SLV32_ARRAY_TYPE;
                              num_valid_pairs : integer)
                              return SLV32_ARRAY_TYPE;

function rebuild_slv64_array (slv64_array     : SLV64_ARRAY_TYPE;
                              num_valid_pairs : integer)
                              return SLV64_ARRAY_TYPE;


function rebuild_int_array (int_array       : INTEGER_ARRAY_TYPE;
                            num_valid_entry : integer)
                            return INTEGER_ARRAY_TYPE;



--/////////////////////////////////////////////////////////////////////////////



-------------------------------------------------------------------------------
-- Constant Declarations
-------------------------------------------------------------------------------

--  xst debug!!!   -- constant declarations of ARD Name array reserved words of IPIF modules
--  xst debug!!!   Constant IPIF_WRFIFO_REG        : string := "ipif_wrfifo_reg                 ";
--  xst debug!!!   Constant IPIF_WRFIFO_DATA       : string := "ipif_wrfifo_data                ";
--  xst debug!!!   Constant IPIF_RDFIFO_REG        : string := "ipif_rdfifo_reg                 ";
--  xst debug!!!   Constant IPIF_RDFIFO_DATA       : string := "ipif_rdfifo_data                ";
--  xst debug!!!   Constant IPIF_RST               : string := "ipif_reset                      ";
--  xst debug!!!   Constant IPIF_INTR              : string := "ipif_interrupt                  ";
--  xst debug!!!   Constant IPIF_DMA_SG            : string := "ipif_dma_sg                     ";
--  xst debug!!!   Constant IPIF_SESR_SEAR         : string := "ipif_sear_sesr                  ";



--/////////////////////////////////////////////////////////////////////////////
--  xst debug!!!   
-- temporary integer aliases of ARD ID (in place of strings)       
-- IPIF Module aliases
Constant IPIF_INTR              : integer := 1;
Constant IPIF_RST               : integer := 2;
Constant IPIF_SESR_SEAR         : integer := 3;
Constant IPIF_DMA_SG            : integer := 4;
Constant IPIF_WRFIFO_REG        : integer := 5;
Constant IPIF_WRFIFO_DATA       : integer := 6;
Constant IPIF_RDFIFO_REG        : integer := 7;
Constant IPIF_RDFIFO_DATA       : integer := 8;
Constant IPIF_CHDMA_CHANNELS    : integer := 9;
Constant IPIF_CHDMA_EVENT_FIFO  : integer := 10;
Constant CHDMA_STATUS_FIFO      : integer := 90;

-- Some predefined user module aliases
Constant USER_00                : integer := 100;
Constant USER_01                : integer := 101;
Constant USER_02                : integer := 102;
Constant USER_03                : integer := 103;
Constant USER_04                : integer := 104;
Constant USER_05                : integer := 105;
Constant USER_06                : integer := 106;
Constant USER_07                : integer := 107;
Constant USER_08                : integer := 108;
Constant USER_09                : integer := 109;
Constant USER_10                : integer := 110;
Constant USER_11                : integer := 111;
Constant USER_12                : integer := 112;
Constant USER_13                : integer := 113;
Constant USER_14                : integer := 114;
Constant USER_15                : integer := 115;
Constant USER_16                : integer := 116;
        
--/////////////////////////////////////////////////////////////////////////////
                                          
                                          
--------------------------------------------------------------------------------
-- Declarations for Dependent Properties (properties that depend on the type of
-- the address range). There is one property, i.e. one parameter, encoded as
-- an integer at each index of the properties array. There is one properties
-- array for each address range.
--------------------------------------------------------------------------------

constant DEPENDENT_PROPS_SIZE : integer := 6;

subtype DEPENDENT_PROPS_TYPE
         is INTEGER_ARRAY_TYPE(0 to DEPENDENT_PROPS_SIZE-1);

type DEPENDENT_PROPS_ARRAY_TYPE
         is array (natural range <>) of DEPENDENT_PROPS_TYPE;


--------------------------------------------------------------------------------
-- Below are the indices of dependent properties for the different types of
-- address ranges.
--
-- Example: Let C_ARD_DEPENDENT_PROPS_ARRAY hold the dependent properites
-- for a set of address ranges. Then, e.g.,
--
--   C_ARD_DEPENDENT_PROPS_ARRAY(i)(FIFO_CAPACITY_BITS)
--
-- gives the fifo capacity in bits, provided that the i'th address range
-- is of type IPIF_WRFIFO_DATA or IPIF_RDFIFO_DATA.
--
-- These indices should be referenced only by the names below and never
-- by numerical literals. (The right to change numerical index assignments
-- is reserved; applications using the names will not be affected by such
-- reassignments.)
--------------------------------------------------------------------------------
--
--ToDo, if the interrupt controller parameterization is ever moved to
--      C_ARD_DEPENDENT_PROPS_ARRAY, then the following declarations
--      could be uncommented and used.
---- IPIF_INTR                                                                 IDX
------------------------------------------------------------------------------ ---
--constant EXCLUDE_DEV_ISC                                         : integer := 0;
--      -- 1 specifies that only the global interrupt
--      -- enable is present in the device interrupt source
--      -- controller and that the only source of interrupts
--      -- in the device is the IP interrupt source controller.
--      -- 0 specifies that the full device interrupt
--      -- source controller structure will be included.
--constant INCLUDE_DEV_PENCODER                                    : integer := 1;
----    -- 1 will include the Device IID in the device interrupt
----    -- source controller, 0 will exclude it.


--
-- IPIF_WRFIFO_DATA or IPIF_RDFIFO_DATA                                      IDX
---------------------------------------------------------------------------- ---
constant FIFO_CAPACITY_BITS                                      : integer := 0;
constant WR_WIDTH_BITS                                           : integer := 1;
constant RD_WIDTH_BITS                                           : integer := 2;
constant EXCLUDE_PACKET_MODE                                     : integer := 3;
      -- 1  Don't include packet mode features
      -- 0  Include packet mode features
constant EXCLUDE_VACANCY                                         : integer := 4;
      -- 1  Don't include vacancy calculation
      -- 0  Include vacancy calculation
--------------------------------------------------------------------------------

-- IPIF_CHDMA_CHANNELS                                                        IDX
---------------------------------------------------------------------------- ---
constant NUM_CHANNELS                                          : integer := 0;
constant INTR_COALESCE                                         : integer := 1;
      -- 0 Interrupt coalescing is disabled
      -- 1 Interrupt coalescing is enabled
constant CLK_PERIOD_PS                                         : integer := 2;
      -- The period of the OPB Bus clock in ps.
      -- The default value of 0 is a special value that
      -- is synonymous with 10000 ps (10 ns).
      -- Relevant only if (INTR_COALESCE = 1).
constant PACKET_WAIT_UNIT_NS                                   : integer := 3;  
      -- Gives the unit for used for timing pack-wait bounds.
      -- The default value of 0 is a special value that
      -- is synonymous with 1,000,000 ps (1 ms).
      -- Relevant only if (INTR_COALESCE = 1).
constant DISALLOW_BURST                                        : integer := 4;  
      -- 0 allows DMA to initiate burst transfers
      -- 1 inhibits DMA initiated burst transfers
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Calculates the number of bits needed to convey the vacancy (emptiness) of
-- the fifo described by dependent_props, if fifo_present. If not fifo_present,
-- returns 0 (or the smallest value allowed by tool limitations on null arrays)
-- without making reference to dependent_props.
--------------------------------------------------------------------------------
function  bits_needed_for_vac(
              fifo_present: boolean;
              dependent_props : DEPENDENT_PROPS_TYPE
          ) return integer;

--------------------------------------------------------------------------------
-- Calculates the number of bits needed to convey the occupancy (fullness) of
-- the fifo described by dependent_props, if fifo_present. If not fifo_present,
-- returns 0 (or the smallest value allowed by tool limitations on null arrays)
-- without making reference to dependent_props.
--------------------------------------------------------------------------------
function  bits_needed_for_occ(
              fifo_present: boolean;
              dependent_props : DEPENDENT_PROPS_TYPE
          ) return integer;



--------------------------------------------------------------------------------
-- Declarations for Common Properties (properties that apply regardless of the
-- type of the address range). Structurally, these work the same as
-- the dependent properties.
--------------------------------------------------------------------------------

constant COMMON_PROPS_SIZE : integer := 2;

subtype COMMON_PROPS_TYPE
         is INTEGER_ARRAY_TYPE(0 to COMMON_PROPS_SIZE-1);

type COMMON_PROPS_ARRAY_TYPE
         is array (natural range <>) of COMMON_PROPS_TYPE;

--------------------------------------------------------------------------------
-- Below are the indices of the common properties.
--
-- These indices should be referenced only by the names below and never
-- by numerical literals.
--                                                                           IDX
---------------------------------------------------------------------------- ---
constant KEYHOLE_BURST                                           : integer := 0;
      -- 1 All addresses of a burst are forced to the initial
      --   address of the burst.
      -- 0 Burst addresses follow the bus protocol.




-- IP interrupt mode array constants
Constant INTR_PASS_THRU         : integer := 1;
Constant INTR_PASS_THRU_INV     : integer := 2;
Constant INTR_REG_EVENT         : integer := 3;
Constant INTR_REG_EVENT_INV     : integer := 4;
Constant INTR_POS_EDGE_DETECT   : integer := 5;
Constant INTR_NEG_EDGE_DETECT   : integer := 6;




 
end ipif_pkg;

library proc_common_v1_00_b;
use     proc_common_v1_00_b.proc_common_pkg.log2;
package body ipif_pkg is



-------------------------------------------------------------------------------
-- Function Definitions
-------------------------------------------------------------------------------

-----------------------------------------------------------------------------
-- Function "="
--
-- This function is used to overload the "=" operator when comparing
-- strings.
-----------------------------------------------------------------------------
  function "=" (s1: in string; s2: in string) return boolean is
      constant tc: character := ' ';  -- string termination character
      variable i: integer := 1;
      variable v1 : string(1 to s1'length) := s1;
      variable v2 : string(1 to s2'length) := s2;
  begin
      while (i <= v1'length) and (v1(i) /= tc) and
            (i <= v2'length) and (v2(i) /= tc) and
            (v1(i) = v2(i))
      loop
          i := i+1;
      end loop;
      return ((i > v1'length) or (v1(i) = tc)) and
             ((i > v2'length) or (v2(i) = tc));
  end;




----------------------------------------------------------------------------
-- Function equaluseCase
--
-- This function returns true if case sensitive string comparison determines
-- that str1 and str2 are the same.
-----------------------------------------------------------------------------
   FUNCTION equaluseCase( str1, str2 : STRING ) RETURN BOOLEAN IS
     CONSTANT len1 : INTEGER := str1'length;
     CONSTANT len2 : INTEGER := str2'length;
     VARIABLE equal : BOOLEAN := TRUE;
   BEGIN
      IF NOT (len1=len2) THEN
        equal := FALSE;
      ELSE
        FOR i IN str1'range LOOP
          IF NOT (str1(i) = str2(i)) THEN
            equal := FALSE;
          END IF;
        END LOOP;
      END IF;

      RETURN equal;
   END equaluseCase;

-----------------------------------------------------------------------------
-- Function calc_num_ce
--
-- This function is used to process the array specifying the number of Chip
-- Enables required for a Base Address specification. The array is input to
-- the function and an integer is returned reflecting the total number of 
-- Chip Enables required for the CE, RdCE, and WrCE Buses
-----------------------------------------------------------------------------
  function calc_num_ce (ce_num_array : INTEGER_ARRAY_TYPE) return integer is

     Variable ce_num_sum : integer := 0;

  begin
    
    for i in 0 to (ce_num_array'length)-1 loop
        ce_num_sum := ce_num_sum + ce_num_array(i);
    End loop;
     
    return(ce_num_sum);
       
  end function calc_num_ce;


--  xst work around!!!   -----------------------------------------------------------------------------
--  xst work around!!!   -- Function find_ard_name
--  xst work around!!!   --
--  xst work around!!!   -- This function is used to process the array specifying the target function
--  xst work around!!!   -- assigned to a Base Address pair address range. The dest_name_array and a 
--  xst work around!!!   -- string name is input to the function. A boolean is returned reflecting the
--  xst work around!!!   -- presence (or not) of a string matching the name input string.
--  xst work around!!!   -----------------------------------------------------------------------------
--  xst work around!!!   function find_ard_name (name_array : ARD_NAME_TYPE; 
--  xst work around!!!                           name       : string) return boolean is
--  xst work around!!!    
--  xst work around!!!       Variable match       : Boolean := false;
--  xst work around!!!       Variable temp_string : string(1 to 32);
--  xst work around!!!       
--  xst work around!!!    begin
--  xst work around!!!    
--  xst work around!!!       for array_index in 0 to name_array'length-1 loop
--  xst work around!!!           
--  xst work around!!!           temp_string :=  name_array(array_index);
--  xst work around!!!           If (match = true) Then  -- match already found so do nothing
--  xst work around!!!               
--  xst work around!!!               null; 
--  xst work around!!!               
--  xst work around!!!           else  -- compare string characters one by one
--  xst work around!!!             
--  xst work around!!!               match := equaluseCase(temp_string, name);
--  xst work around!!!             
--  xst work around!!!           End if;
--  xst work around!!!           
--  xst work around!!!       End loop;
--  xst work around!!!      
--  xst work around!!!       return(match);
--  xst work around!!!       
--  xst work around!!!    end function find_ard_name;
 


-- optional implementation -----------------------------------------------------------------------------
-- optional implementation -- Function find_ard_name
-- optional implementation --
-- optional implementation -- This function is used to process the array specifying the target function
-- optional implementation -- assigned to a Base Address pair address range. The dest_name_array and a 
-- optional implementation -- string name is input to the function. A boolean is returned reflecting the
-- optional implementation -- presence (or not) of a string matching the name input string.
-- optional implementation -----------------------------------------------------------------------------
-- optional implementation function find_ard_name (name_array : ARD_NAME_TYPE; 
-- optional implementation                         name       : string) return boolean is
-- optional implementation  
-- optional implementation     Variable match       : Boolean := false;
-- optional implementation     Variable temp_string : string(1 to 32);
-- optional implementation     
-- optional implementation  begin
-- optional implementation  
-- optional implementation     --for array_index in 0 to name_array'length-1 loop
-- optional implementation     for array_index in 0 to name_array'length-1 loop
-- optional implementation         
-- optional implementation         temp_string :=  name_array(array_index);
-- optional implementation         
-- optional implementation         If (match = true) Then  -- match already found so do nothing
-- optional implementation             
-- optional implementation             null; 
-- optional implementation             
-- optional implementation         else  -- compare the strings using "=" overload function
-- optional implementation 
-- optional implementation            If (temp_string = name) Then
-- optional implementation               match := true;
-- optional implementation            else
-- optional implementation                null;
-- optional implementation            End if;
-- optional implementation           
-- optional implementation         End if;
-- optional implementation         
-- optional implementation     End loop;
-- optional implementation    
-- optional implementation     return(match);
-- optional implementation     
-- optional implementation  end function find_ard_name;
-- optional implementation  
 
 
 

--  xst work around!!!   -----------------------------------------------------------------------------
--  xst work around!!!   -- Function get_name_index
--  xst work around!!!   --
--  xst work around!!!   -- This function is used to process the array specifying the target function
--  xst work around!!!   -- assigned to a Base Address pair address range. The dest_name_array and a 
--  xst work around!!!   -- string name is input to the function. A integer is returned reflecting the
--  xst work around!!!   -- array index of the string matching the name input string. This function
--  xst work around!!!   -- should only be called if the compare string is known to exist in the 
--  xst work around!!!   -- name_array input. This can be detirmined by using the  find_ard_name
--  xst work around!!!   -- function.
--  xst work around!!!   -----------------------------------------------------------------------------
--  xst work around!!!    function get_name_index (name_array :ARD_NAME_TYPE; 
--  xst work around!!!                             name       : string) return integer is
--  xst work around!!!    
--  xst work around!!!       Variable match       : Boolean := false;
--  xst work around!!!       Variable match_index : Integer := 0;
--  xst work around!!!       Variable temp_string : string(1 to 32);
--  xst work around!!!       
--  xst work around!!!       
--  xst work around!!!    begin
--  xst work around!!!    
--  xst work around!!!       for array_index in 0 to name_array'length-1 loop
--  xst work around!!!           
--  xst work around!!!           
--  xst work around!!!           temp_string := name_array(array_index);
--  xst work around!!!           
--  xst work around!!!           If (match = true) Then  -- match already found so do nothing
--  xst work around!!!               
--  xst work around!!!               null; 
--  xst work around!!!               
--  xst work around!!!           else  -- compare string characters one by one
--  xst work around!!!             
--  xst work around!!!               match := equaluseCase(temp_string, name);
--  xst work around!!!               match_index := array_index;
--  xst work around!!!             
--  xst work around!!!           End if;
--  xst work around!!!           
--  xst work around!!!       End loop;
--  xst work around!!!      
--  xst work around!!!       return(match_index);
--  xst work around!!!       
--  xst work around!!!    end function get_name_index;
 
 

-----------------------------------------------------------------------------
-- Function calc_start_ce_index
--
-- This function is used to process the array specifying the number of Chip
-- Enables required for a Base Address specification. The CE Size array is 
-- input to the function and an integer index representing the index of the 
-- target module in the ce_num_array. An integer is returned reflecting the 
-- starting index of the assigned Chip Enables within the CE, RdCE, and 
-- WrCE Buses.
-----------------------------------------------------------------------------
 function calc_start_ce_index (ce_num_array : INTEGER_ARRAY_TYPE;
                               index        : integer) return integer is

    Variable ce_num_sum : integer := 0;

 begin
   If (index = 0) Then
     ce_num_sum := 0;
   else
      for i in 0 to index-1 loop
          ce_num_sum := ce_num_sum + ce_num_array(i);
      End loop;
   End if;
    
   return(ce_num_sum);
      
 end function calc_start_ce_index;

 
 
 
 
-----------------------------------------------------------------------------
-- Function get_min_dwidth
--
-- This function is used to process the array specifying the data bus width
-- for each of the target modules. The dwidth_array is input to the function
-- and an integer is returned that is the smallest value found of all the 
-- entries in the array.
-----------------------------------------------------------------------------
 function get_min_dwidth (dwidth_array: INTEGER_ARRAY_TYPE) return integer is

    Variable temp_min : Integer := 1024;
    
 begin

    for i in 0 to dwidth_array'length-1 loop
        
       If (dwidth_array(i) < temp_min) Then
          temp_min := dwidth_array(i);
       else
           null;
       End if;
        
    End loop;
    
    return(temp_min);
                  
 end function get_min_dwidth;

 
 
-----------------------------------------------------------------------------
-- Function get_max_dwidth
--
-- This function is used to process the array specifying the data bus width
-- for each of the target modules. The dwidth_array is input to the function
-- and an integer is returned that is the largest value found of all the 
-- entries in the array.
-----------------------------------------------------------------------------
 function get_max_dwidth (dwidth_array: INTEGER_ARRAY_TYPE) return integer is

    Variable temp_max : Integer := 0;
    
 begin

    for i in 0 to dwidth_array'length-1 loop
        
       If (dwidth_array(i) > temp_max) Then
          temp_max := dwidth_array(i);
       else
           null;
       End if;
        
    End loop;
    
    return(temp_max);
                  
 end function get_max_dwidth;

 
 


--  xst work around!!!   -----------------------------------------------------------------------------
--  xst work around!!!   -- Function find_a_dwidth
--  xst work around!!!   --
--  xst work around!!!   -- This function is used to find the data width of a target module. If the
--  xst work around!!!   -- target module exists, the data width is extracted from the input dwidth 
--  xst work around!!!   -- array. If the module is not in the name array, the default input is 
--  xst work around!!!   -- returned. This function is needed to assign data port size constraints.
--  xst work around!!!   -----------------------------------------------------------------------------
--  xst work around!!!    function find_a_dwidth (name_array  : ARD_NAME_TYPE; 
--  xst work around!!!                            dwidth_array: INTEGER_ARRAY_TYPE;
--  xst work around!!!                            name          : string;
--  xst work around!!!                            default     : integer) return integer is
--  xst work around!!!   
--  xst work around!!!   
--  xst work around!!!        Variable name_present : Boolean := false;
--  xst work around!!!        Variable array_index: Integer := 0;
--  xst work around!!!        Variable dwidth     : Integer := default;
--  xst work around!!!   
--  xst work around!!!    begin
--  xst work around!!!   
--  xst work around!!!       name_present := find_ard_name(name_array, name);
--  xst work around!!!      
--  xst work around!!!       If (name_present) Then
--  xst work around!!!         array_index :=  get_name_index (name_array, name);
--  xst work around!!!         dwidth      :=  dwidth_array(array_index);
--  xst work around!!!       else
--  xst work around!!!          null; -- use default input 
--  xst work around!!!       End if;
--  xst work around!!!      
--  xst work around!!!      
--  xst work around!!!      Return (dwidth);
--  xst work around!!!      
--  xst work around!!!    end function find_a_dwidth;


    
-----------------------------------------------------------------------------
-- Function S32
--
-- This function is used to expand an input string to 32 characters by
-- padding with spaces. If the input string is larger than 32 characters,
-- it will truncate to 32 characters.
-----------------------------------------------------------------------------
 function S32 (in_string : string) return string is

   constant OUTPUT_STRING_LENGTH : integer := 32;
   Constant space : character := ' ';
   
   variable new_string    : string(1 to 32);
   Variable start_index   : Integer :=  in_string'length+1;
   
 begin

   If (in_string'length < OUTPUT_STRING_LENGTH) Then
    
      for i in 1 to in_string'length loop
          new_string(i) :=  in_string(i);
      End loop; 
   
      for j in start_index to OUTPUT_STRING_LENGTH loop
          new_string(j) :=  space;
      End loop; 
   
   
   else  -- use first 32 chars of in_string (truncate the rest)

      for k in 1 to OUTPUT_STRING_LENGTH loop
          new_string(k) :=  in_string(k);
      End loop; 
   
   End if;
  
   return(new_string);
  
 end function S32;
 



--  xst work around!!!   function cnt_ipif_blks (name_array : ARD_NAME_TYPE) return integer is
--  xst work around!!!   
--  xst work around!!!       Variable blk_count   : integer := 0;
--  xst work around!!!       Variable temp_string : string(1 to 32);
--  xst work around!!!       
--  xst work around!!!    begin
--  xst work around!!!    
--  xst work around!!!       for array_index in 0 to name_array'length-1 loop
--  xst work around!!!           
--  xst work around!!!           temp_string :=  name_array(array_index);
--  xst work around!!!           
--  xst work around!!!           If (temp_string = IPIF_WRFIFO_DATA or
--  xst work around!!!               temp_string = IPIF_RDFIFO_DATA or
--  xst work around!!!               temp_string = IPIF_RST or
--  xst work around!!!               temp_string = IPIF_INTR or
--  xst work around!!!               temp_string = IPIF_DMA_SG or
--  xst work around!!!               temp_string = IPIF_SESR_SEAR
--  xst work around!!!              ) Then  -- IPIF block found
--  xst work around!!!               
--  xst work around!!!               blk_count := blk_count+1; 
--  xst work around!!!               
--  xst work around!!!           else  -- go to next loop iteration
--  xst work around!!!             
--  xst work around!!!               null;
--  xst work around!!!             
--  xst work around!!!           End if;
--  xst work around!!!           
--  xst work around!!!       End loop;
--  xst work around!!!      
--  xst work around!!!       return(blk_count);
--  xst work around!!!       
--  xst work around!!!   end function cnt_ipif_blks;



--  xst work around!!!   function get_ipif_dbus_index (name_array: ARD_NAME_TYPE;
--  xst work around!!!                                 name      : string)
--  xst work around!!!                                 return integer is
--  xst work around!!!       
--  xst work around!!!       Variable blk_index   : integer := 0;
--  xst work around!!!       Variable temp_string : string(1 to 32);
--  xst work around!!!       Variable name_found  : Boolean := false;
--  xst work around!!!       
--  xst work around!!!   begin
--  xst work around!!!   
--  xst work around!!!       for array_index in 0 to name_array'length-1 loop
--  xst work around!!!           
--  xst work around!!!           temp_string :=  name_array(array_index);
--  xst work around!!!           
--  xst work around!!!           If (name_found) then
--  xst work around!!!   
--  xst work around!!!              null;
--  xst work around!!!               
--  xst work around!!!           elsif (temp_string = name) then
--  xst work around!!!           
--  xst work around!!!             name_found := true;
--  xst work around!!!           
--  xst work around!!!           elsif (temp_string = IPIF_WRFIFO_DATA or 
--  xst work around!!!                  temp_string = IPIF_RDFIFO_DATA or 
--  xst work around!!!                  temp_string = IPIF_RST or         
--  xst work around!!!                  temp_string = IPIF_INTR or        
--  xst work around!!!                  temp_string = IPIF_DMA_SG or      
--  xst work around!!!                  temp_string = IPIF_SESR_SEAR      
--  xst work around!!!                 ) Then  -- IPIF block found
--  xst work around!!!               
--  xst work around!!!               blk_index := blk_index+1; 
--  xst work around!!!               
--  xst work around!!!           else  -- user block so do nothing
--  xst work around!!!             
--  xst work around!!!               null;
--  xst work around!!!             
--  xst work around!!!           End if;
--  xst work around!!!           
--  xst work around!!!       End loop;
--  xst work around!!!      
--  xst work around!!!       return(blk_index);
--  xst work around!!!       
--  xst work around!!!      
--  xst work around!!!   end function get_ipif_dbus_index;




--/////////////////////////////////////////////////////////////////////////////
 --  xst debug!!!   
 -- Hopefully temporary functions


-----------------------------------------------------------------------------
-- Function get_id_index
--
-- This function is used to process the array specifying the target function
-- assigned to a Base Address pair address range. The id_array and a 
-- id number is input to the function. A integer is returned reflecting the
-- array index of the id matching the id input number. This function
-- should only be called if the id number is known to exist in the 
-- name_array input. This can be detirmined by using the  find_ard_id
-- function.
-----------------------------------------------------------------------------
 function get_id_index (id_array :INTEGER_ARRAY_TYPE;      
                        id       : integer) return integer is
 
    Variable match       : Boolean := false;
    Variable match_index : Integer := 10000; -- a really big number!
    
    
 begin
 
    for array_index in 0 to id_array'length-1 loop
        
               
        If (match = true) Then  -- match already found so do nothing
            
            null; 
            
        else  -- compare the numbers one by one
          
           match       := (id_array(array_index) = id);
           
           If (match) Then
              match_index := array_index;
           else
               null;
           End if;
          
        End if;
        
    End loop;
   
    return(match_index);
    
 end function get_id_index;
 

--------------------------------------------------------------------------------
-- get_id_index but return a value in bounds on error (iboe).
--
-- This function is the same as get_id_index, except that when id does
-- not exist in id_array, the value returned is any index that is
-- within the index range of id_array.
--
-- This function would normally only be used where function find_ard_id
-- is used to establish the existence of id but, even when non-existent,
-- an element of one of the ARD arrays will be computed from the
-- returned get_id_index_iboe value. See, e.g., function bits_needed_for_vac
-- and the example call, below
--
--      bits_needed_for_vac(
--        find_ard_id(C_ARD_ID_ARRAY, IPIF_RDFIFO_DATA),
--        C_ARD_DEPENDENT_PROPS_ARRAY(get_id_index_iboe(C_ARD_ID_ARRAY,
--                                                      IPIF_RDFIFO_DATA))
--      )
--------------------------------------------------------------------------------
 function get_id_index_iboe (id_array :INTEGER_ARRAY_TYPE;      
                             id       : integer) return integer is
 
    Variable match       : Boolean := false;
    Variable match_index : Integer := id_array'left; -- any valid array index
    
 begin
    for array_index in 0 to id_array'length-1 loop
        If (match = true) Then  -- match already found so do nothing
            null; 
        else  -- compare the numbers one by one
           match       := (id_array(array_index) = id);
           If (match) Then match_index := array_index;
           else null;
           End if;
        End if;
    End loop;
    return(match_index);
 end function get_id_index_iboe;
 


-----------------------------------------------------------------------------
-- Function find_ard_id
--
-- This function is used to process the array specifying the target function
-- assigned to a Base Address pair address range. The id_array and a 
-- integer id is input to the function. A boolean is returned reflecting the
-- presence (or not) of a number in the array matching the id input number.
-----------------------------------------------------------------------------
function find_ard_id (id_array : INTEGER_ARRAY_TYPE;
                      id       : integer) return boolean is
 
    Variable match       : Boolean := false;
    
 begin
 
    for array_index in 0 to id_array'length-1 loop
        
        
        If (match = true) Then  -- match already found so do nothing
            
            null; 
            
        else  -- compare the numbers one by one

           match       := (id_array(array_index) = id);
          
        End if;
        
    End loop;
   
    return(match);
    
 end function find_ard_id;
 







 
-----------------------------------------------------------------------------
-- Function find_id_dwidth
--
-- This function is used to find the data width of a target module. If the
-- target module exists, the data width is extracted from the input dwidth 
-- array. If the module is not in the ID array, the default input is 
-- returned. This function is needed to assign data port size constraints on
-- unconstrained port widths.
-----------------------------------------------------------------------------
function find_id_dwidth (id_array    : INTEGER_ARRAY_TYPE; 
                        dwidth_array: INTEGER_ARRAY_TYPE;
                        id          : integer;
                        default     : integer) return integer is


     Variable id_present   : Boolean := false;
     Variable array_index  : Integer := 0;
     Variable dwidth       : Integer := default;

 begin

    id_present := find_ard_id(id_array, id);
   
    If (id_present) Then
      array_index :=  get_id_index (id_array, id);
      dwidth      :=  dwidth_array(array_index);
    else
       null; -- use default input 
    End if;
   
   
   Return (dwidth);
   
 end function find_id_dwidth;

 
 
 

-----------------------------------------------------------------------------
-- Function cnt_ipif_id_blks
--
-- This function is used to detirmine the number of IPIF components specified
-- in the ARD ID Array. An integer is returned representing the number
-- of elements counted. User IDs are ignored in the counting process.
-----------------------------------------------------------------------------
function cnt_ipif_id_blks (id_array : INTEGER_ARRAY_TYPE) 
                           return integer is

    Variable blk_count   : integer := 0;
    Variable temp_id     : integer;
    
 begin
 
    for array_index in 0 to id_array'length-1 loop
        
        temp_id :=  id_array(array_index);
        
        If (temp_id = IPIF_WRFIFO_DATA or
            temp_id = IPIF_RDFIFO_DATA or
            temp_id = IPIF_RST or
            temp_id = IPIF_INTR or
            temp_id = IPIF_DMA_SG or
            temp_id = IPIF_SESR_SEAR
           ) Then  -- IPIF block found
            
            blk_count := blk_count+1; 
            
        else  -- go to next loop iteration
          
            null;
          
        End if;
        
    End loop;
   
    return(blk_count);
    
end function cnt_ipif_id_blks;



-----------------------------------------------------------------------------
-- Function get_ipif_id_dbus_index
--
-- This function is used to detirmine the IPIF relative index of a given
-- ID value. User IDs are ignored in the index detirmination.
-----------------------------------------------------------------------------
function get_ipif_id_dbus_index (id_array : INTEGER_ARRAY_TYPE;
                                 id       : integer)
                                 return integer is
    
    Variable blk_index   : integer := 0;
    Variable temp_id     : integer;
    Variable id_found    : Boolean := false;
    
begin

    for array_index in 0 to id_array'length-1 loop
        
        temp_id :=  id_array(array_index);
        
        If (id_found) then

           null;
            
        elsif (temp_id = id) then
        
          id_found := true;
        
        elsif (temp_id = IPIF_WRFIFO_DATA or 
               temp_id = IPIF_RDFIFO_DATA or 
               temp_id = IPIF_RST or         
               temp_id = IPIF_INTR or        
               temp_id = IPIF_DMA_SG or      
               temp_id = IPIF_SESR_SEAR      
              ) Then  -- IPIF block found
            
            blk_index := blk_index+1; 
            
        else  -- user block so do nothing
          
            null;
          
        End if;
        
    End loop;
   
    return(blk_index);
    
   
end function get_ipif_id_dbus_index;


 
 
-- End of xst debug functions 
--/////////////////////////////////////////////////////////////////////////////




 ------------------------------------------------------------------------------ 
 -- Function: rebuild_slv32_array
 --
 -- Description:
 -- This function takes an input slv32 array and rebuilds an output slv32
 -- array composed of the first "num_valid_entry" elements from the input 
 -- array.
 ------------------------------------------------------------------------------ 
 function rebuild_slv32_array (slv32_array  : SLV32_ARRAY_TYPE;
                               num_valid_pairs : integer)
                               return SLV32_ARRAY_TYPE is
 
      --Constants
      constant num_elements          : Integer := num_valid_pairs * 2;
      
      -- Variables
      variable temp_baseaddr32_array :  SLV32_ARRAY_TYPE( 0 to num_elements-1);
 
 begin
 
     for array_index in 0 to num_elements-1 loop
     
        temp_baseaddr32_array(array_index) := slv32_array(array_index);
     
     end loop;
   
   
     return(temp_baseaddr32_array);
   
 end function rebuild_slv32_array;
 


  
 ------------------------------------------------------------------------------ 
 -- Function: rebuild_slv64_array
 --
 -- Description:
 -- This function takes an input slv64 array and rebuilds an output slv64
 -- array composed of the first "num_valid_entry" elements from the input 
 -- array.
 ------------------------------------------------------------------------------ 
 function rebuild_slv64_array (slv64_array  : SLV64_ARRAY_TYPE;
                               num_valid_pairs : integer)
                               return SLV64_ARRAY_TYPE is
 
      --Constants
      constant num_elements          : Integer := num_valid_pairs * 2;
      
      -- Variables
      variable temp_baseaddr64_array :  SLV64_ARRAY_TYPE( 0 to num_elements-1);
 
 begin
 
     for array_index in 0 to num_elements-1 loop
     
        temp_baseaddr64_array(array_index) := slv64_array(array_index);
     
     end loop;
   
   
     return(temp_baseaddr64_array);
   
 end function rebuild_slv64_array;
 


 ------------------------------------------------------------------------------ 
 -- Function: rebuild_int_array
 --
 -- Description:
 -- This function takes an input integer array and rebuilds an output integer
 -- array composed of the first "num_valid_entry" elements from the input 
 -- array.
 ------------------------------------------------------------------------------ 
 function rebuild_int_array (int_array       : INTEGER_ARRAY_TYPE;
                             num_valid_entry : integer)
                             return INTEGER_ARRAY_TYPE is
 
      -- Variables
      variable temp_int_array   : INTEGER_ARRAY_TYPE( 0 to num_valid_entry-1);
 
 begin
 
     for array_index in 0 to num_valid_entry-1 loop
     
        temp_int_array(array_index) := int_array(array_index);
     
     end loop;
   
   
     return(temp_int_array);
   
 end function rebuild_int_array;
 

 
    function  bits_needed_for_vac(
                  fifo_present: boolean;
                  dependent_props : DEPENDENT_PROPS_TYPE
              ) return integer is
    begin
        if not fifo_present then
            return 1; -- Zero would be better but leads to "0 to -1" null
                      -- ranges that are not handled by XST Flint or earlier
                      -- because of the negative index.
        else
            return
            log2(1 + dependent_props(FIFO_CAPACITY_BITS) /
                     dependent_props(RD_WIDTH_BITS)
            );
        end if;
    end function bits_needed_for_vac;


    function  bits_needed_for_occ(
                  fifo_present: boolean;
                  dependent_props : DEPENDENT_PROPS_TYPE
              ) return integer is
    begin
        if not fifo_present then
            return 1; -- Zero would be better but leads to "0 to -1" null
                      -- ranges that are not handled by XST Flint or earlier
                      -- because of the negative index.
        else
            return
            log2(1 + dependent_props(FIFO_CAPACITY_BITS) /
                     dependent_props(WR_WIDTH_BITS)
            );
        end if;
    end function bits_needed_for_occ;

end package body ipif_pkg;
