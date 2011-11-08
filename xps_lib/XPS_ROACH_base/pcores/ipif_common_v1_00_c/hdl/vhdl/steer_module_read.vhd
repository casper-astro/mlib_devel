--SINGLE_FILE_TAG
-------------------------------------------------------------------------------
-- $Id: steer_module_read.vhd,v 1.1 2003/02/18 19:16:01 ostlerf Exp $
-------------------------------------------------------------------------------
-- Steer_Module_Read - entity/architecture pair
-------------------------------------------------------------------------------
--
--                  ****************************
--                  ** Copyright Xilinx, Inc. **
--                  ** All rights reserved.   **
--                  ****************************
--
-------------------------------------------------------------------------------
-- Filename:        steer_module_read.vhd
-- Version:         v1.00b
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
--              steer_module_read.vhd
--
-------------------------------------------------------------------------------
-- Author:      BLT
-- History:
--  BLT             4-26-2002      -- First version
-- ^^^^^^
--      First version of steering logic module.
-- ~~~~~~
--  BLT            11-18-2002      -- Update to version v1.00b
-- ^^^^^^
--      Updated to use ipif_common_v1_00_b, which fixed a simulation problem
--      in the ipif_steer logic
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

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_signed.all;
use IEEE.std_logic_misc.all;
library ipif_common_v1_00_c;
use ipif_common_v1_00_c.STEER_TYPES.all;

-------------------------------------------------------------------------------
-- Port declarations
--   generic definitions:
--     C_DWIDTH    : integer := width of host databus attached to the IPIF
--     C_SMALLEST  : integer := width of smallest device (not access size)
--                              attached to the IPIF
--     C_LARGEST   : integer := width of largest device (not access size) 
--                              attached to the IPIF
--     C_MIRROR_SIZE : integer := smallest unit of data that is mirrored
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

entity Steer_Module_Read is
  generic (
    C_DWIDTH_IN        : integer := 32;   -- 8, 16, 32, 64, 128, 256, or 512  
    C_DWIDTH_OUT       : integer := 64;   -- 8, 16, 32, 64, 128, 256, or 512
    C_SMALLEST_OUT     : integer := 32;   -- 8, 16, 32, 64, 128, 256, or 512
    C_SMALLEST_IN      : integer := 8;   -- 8, 16, 32, 64, 128, 256, or 512  
    C_AWIDTH           : integer := 32  
    );   
  port (
    Data_In            : in  std_logic_vector(0 to C_DWIDTH_IN-1);
    Addr               : in  std_logic_vector(0 to C_AWIDTH-1);
    Decode_size        : in  std_logic_vector(0 to 2);
    Data_Out           : out std_logic_vector(0 to C_DWIDTH_OUT-1)
    );
end entity Steer_Module_Read;

-------------------------------------------------------------------------------
-- Architecture section
-------------------------------------------------------------------------------

architecture IMP of Steer_Module_Read is

-------------------------------------------------------------------------------
-- Function max -- returns maximum of x and y
-------------------------------------------------------------------------------

function max(x : integer; y : integer) return integer is
begin
  if x > y then return x;
  else          return y;
  end if;
end function max;

-------------------------------------------------------------------------------
-- Function min -- returns minimum of x and y
-------------------------------------------------------------------------------

function min(x : integer; y : integer) return integer is
begin
  if x < y then return x;
  else          return y;
  end if;
end function min;

-------------------------------------------------------------------------------
-- Function log2 -- returns number of bits needed to encode x choices
--   x = 0  returns 0
--   x = 1  returns 0
--   x = 2  returns 1
--   x = 4  returns 2, etc.
-------------------------------------------------------------------------------

function log2(x : natural) return integer is
  variable i  : integer := 0; 
  variable val: integer := 1;
begin 
  if x = 0 then return 0;
  else
    for j in 0 to 8 loop -- for loop for XST 
      if val >= x then null; 
      else
        i := i+1;
        val := val*2;
      end if;
    end loop;
    return i;
  end if;  
end function log2; 

-------------------------------------------------------------------------------
-- Function pwr -- returns x**y for integers x and y, y>=0
-------------------------------------------------------------------------------

function pwr(x: integer; y: integer) return integer is
  variable z : integer := 1;
begin
  if y = 0 then return 1; 
  else
    for i in 1 to y loop
      z := z * x;
    end loop;
    return z;
  end if;
end function pwr;

function Addr_Start_Func (C_SMALLEST_OUT  : integer;
                          C_DWIDTH_IN : integer) 
  return integer is
variable IP_Addr_Start : integer;                       
variable IP_Addr_Stop  : integer;                       
  begin
    case C_SMALLEST_OUT is
      when 8 => 
        case C_DWIDTH_IN is
          when 8      => IP_Addr_Start := -1; IP_Addr_Stop := -1;      
          when 16     => IP_Addr_Start := 0;  IP_Addr_Stop := 0;
          when 32     => IP_Addr_Start := 0;  IP_Addr_Stop := 1;
          when 64     => IP_Addr_Start := 0;  IP_Addr_Stop := 2;
          when 128    => IP_Addr_Start := 0;  IP_Addr_Stop := 3;
          when 256    => IP_Addr_Start := 0;  IP_Addr_Stop := 4;
          when 512    => IP_Addr_Start := 0;  IP_Addr_Stop := 5;
          when others => IP_Addr_Start := 0;  IP_Addr_Stop := 6;
        end case;
      when 16 =>
        case C_DWIDTH_IN is
          when 8      => IP_Addr_Start := -1; IP_Addr_Stop := -1;      
          when 16     => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when 32     => IP_Addr_Start := 1;  IP_Addr_Stop := 1;
          when 64     => IP_Addr_Start := 1;  IP_Addr_Stop := 2;
          when 128    => IP_Addr_Start := 1;  IP_Addr_Stop := 3;
          when 256    => IP_Addr_Start := 1;  IP_Addr_Stop := 4;
          when 512    => IP_Addr_Start := 1;  IP_Addr_Stop := 5;
          when others => IP_Addr_Start := 1;  IP_Addr_Stop := 6;
        end case;
      when 32 =>
        case C_DWIDTH_IN is
          when 8      => IP_Addr_Start := -1; IP_Addr_Stop := -1;      
          when 16     => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when 32     => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when 64     => IP_Addr_Start := 2;  IP_Addr_Stop := 2;
          when 128    => IP_Addr_Start := 2;  IP_Addr_Stop := 3;
          when 256    => IP_Addr_Start := 2;  IP_Addr_Stop := 4;
          when 512    => IP_Addr_Start := 2;  IP_Addr_Stop := 5;
          when others => IP_Addr_Start := 2;  IP_Addr_Stop := 6;
        end case;
      when 64 =>
        case C_DWIDTH_IN is
          when 8      => IP_Addr_Start := -1; IP_Addr_Stop := -1;      
          when 16     => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when 32     => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when 64     => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when 128    => IP_Addr_Start := 3;  IP_Addr_Stop := 3;
          when 256    => IP_Addr_Start := 3;  IP_Addr_Stop := 4;
          when 512    => IP_Addr_Start := 3;  IP_Addr_Stop := 5;
          when others => IP_Addr_Start := 3;  IP_Addr_Stop := 6;
        end case;
      when 128 =>
        case C_DWIDTH_IN is
          when 8      => IP_Addr_Start := -1; IP_Addr_Stop := -1;       
          when 16     => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when 32     => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when 64     => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when 128    => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when 256    => IP_Addr_Start := 4;  IP_Addr_Stop := 4;
          when 512    => IP_Addr_Start := 4;  IP_Addr_Stop := 5;
          when others => IP_Addr_Start := 4;  IP_Addr_Stop := 6;
        end case;
      when 256 =>
        case C_DWIDTH_IN is
          when 8      => IP_Addr_Start := -1; IP_Addr_Stop := -1;      
          when 16     => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when 32     => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when 64     => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when 128    => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when 256    => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when 512    => IP_Addr_Start := 5;  IP_Addr_Stop := 5;
          when others => IP_Addr_Start := 5;  IP_Addr_Stop := 6;
        end case;
      when 512 =>
        case C_DWIDTH_IN is
          when 8      => IP_Addr_Start := -1; IP_Addr_Stop := -1;      
          when 16     => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when 32     => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when 64     => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when 128    => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when 256    => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when 512    => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when others => IP_Addr_Start := 6;  IP_Addr_Stop := 6;
        end case;
      when others => IP_Addr_Start := -1; IP_Addr_Stop := -1;
    end case;
  return IP_Addr_Start;
end function Addr_Start_Func;

function Addr_Stop_Func (C_SMALLEST_OUT  : integer;
                         C_DWIDTH_IN : integer) 
  return integer is
variable IP_Addr_Start : integer;                       
variable IP_Addr_Stop  : integer;                       
  begin
    case C_SMALLEST_OUT is
      when 8 => 
        case C_DWIDTH_IN is
          when 8      => IP_Addr_Start := -1; IP_Addr_Stop := -1;      
          when 16     => IP_Addr_Start := 0;  IP_Addr_Stop := 0;
          when 32     => IP_Addr_Start := 0;  IP_Addr_Stop := 1;
          when 64     => IP_Addr_Start := 0;  IP_Addr_Stop := 2;
          when 128    => IP_Addr_Start := 0;  IP_Addr_Stop := 3;
          when 256    => IP_Addr_Start := 0;  IP_Addr_Stop := 4;
          when 512    => IP_Addr_Start := 0;  IP_Addr_Stop := 5;
          when others => IP_Addr_Start := 0;  IP_Addr_Stop := 6;
        end case;
      when 16 =>
        case C_DWIDTH_IN is
          when 8      => IP_Addr_Start := -1; IP_Addr_Stop := -1;      
          when 16     => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when 32     => IP_Addr_Start := 1;  IP_Addr_Stop := 1;
          when 64     => IP_Addr_Start := 1;  IP_Addr_Stop := 2;
          when 128    => IP_Addr_Start := 1;  IP_Addr_Stop := 3;
          when 256    => IP_Addr_Start := 1;  IP_Addr_Stop := 4;
          when 512    => IP_Addr_Start := 1;  IP_Addr_Stop := 5;
          when others => IP_Addr_Start := 1;  IP_Addr_Stop := 6;
        end case;
      when 32 =>
        case C_DWIDTH_IN is
          when 8      => IP_Addr_Start := -1; IP_Addr_Stop := -1;      
          when 16     => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when 32     => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when 64     => IP_Addr_Start := 2;  IP_Addr_Stop := 2;
          when 128    => IP_Addr_Start := 2;  IP_Addr_Stop := 3;
          when 256    => IP_Addr_Start := 2;  IP_Addr_Stop := 4;
          when 512    => IP_Addr_Start := 2;  IP_Addr_Stop := 5;
          when others => IP_Addr_Start := 2;  IP_Addr_Stop := 6;
        end case;
      when 64 =>
        case C_DWIDTH_IN is
          when 8      => IP_Addr_Start := -1; IP_Addr_Stop := -1;      
          when 16     => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when 32     => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when 64     => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when 128    => IP_Addr_Start := 3;  IP_Addr_Stop := 3;
          when 256    => IP_Addr_Start := 3;  IP_Addr_Stop := 4;
          when 512    => IP_Addr_Start := 3;  IP_Addr_Stop := 5;
          when others => IP_Addr_Start := 3;  IP_Addr_Stop := 6;
        end case;
      when 128 =>
        case C_DWIDTH_IN is
          when 8      => IP_Addr_Start := -1; IP_Addr_Stop := -1;       
          when 16     => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when 32     => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when 64     => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when 128    => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when 256    => IP_Addr_Start := 4;  IP_Addr_Stop := 4;
          when 512    => IP_Addr_Start := 4;  IP_Addr_Stop := 5;
          when others => IP_Addr_Start := 4;  IP_Addr_Stop := 6;
        end case;
      when 256 =>
        case C_DWIDTH_IN is
          when 8      => IP_Addr_Start := -1; IP_Addr_Stop := -1;      
          when 16     => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when 32     => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when 64     => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when 128    => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when 256    => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when 512    => IP_Addr_Start := 5;  IP_Addr_Stop := 5;
          when others => IP_Addr_Start := 5;  IP_Addr_Stop := 6;
        end case;
      when 512 =>
        case C_DWIDTH_IN is
          when 8      => IP_Addr_Start := -1; IP_Addr_Stop := -1;      
          when 16     => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when 32     => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when 64     => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when 128    => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when 256    => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when 512    => IP_Addr_Start := -1; IP_Addr_Stop := -1;
          when others => IP_Addr_Start := 6;  IP_Addr_Stop := 6;
        end case;
      when others => IP_Addr_Start := -1; IP_Addr_Stop := -1;
    end case;
  return IP_Addr_Stop;
end function Addr_Stop_Func;

constant Addr_Size : integer_array_type(0 to 63) :=
  (1=>1,3=>1,5=>1,7=>1,9=>1,11=>1,13=>1,15=>1,
   17=>1,19=>1,21=>1,23=>1,25=>1,27=>1,29=>1,31=>1,
   33=>1,35=>1,37=>1,39=>1,41=>1,43=>1,45=>1,47=>1,
   49=>1,51=>1,53=>1,55=>1,57=>1,59=>1,61=>1,63=>1,

   2=>2,6=>2,10=>2,14=>2,18=>2,22=>2,26=>2,30=>2,
   34=>2,38=>2,42=>2,46=>2,50=>2,54=>2,58=>2,62=>2,

   4=>4,12=>4,20=>4,28=>4,36=>4,44=>4,52=>4,60=>4,
   
   8=>8,24=>8,40=>8,56=>8,16=>16,48=>16,32=>32,0=>64);
   
constant IP_Addr_Start        : integer := Addr_Start_Func(C_SMALLEST_OUT,C_DWIDTH_IN);
constant IP_Addr_Stop         : integer := Addr_Stop_Func(C_SMALLEST_OUT,C_DWIDTH_IN);

-------------------------------------------------------------------------------
-- Begin architecture
-------------------------------------------------------------------------------

begin -- architecture IMP
  
  MUX_PROCESS: process( Data_In,Decode_size,Addr ) is
    variable factor           : integer;
    variable addr_loop        : integer;
    variable addr_integer     : integer;
    variable num_addr_bits    : integer;
    variable size             : integer;
    variable address          : integer;
    variable data_address     : integer;
    variable replicate_factor : integer;
  begin
      num_addr_bits := IP_Addr_Stop-IP_Addr_Start+1;

      -- Set up default condition
      if C_DWIDTH_IN <= C_DWIDTH_OUT then
        for i in 0 to C_DWIDTH_OUT/C_DWIDTH_IN-1 loop
          Data_Out(i*C_DWIDTH_IN to (i+1)*C_DWIDTH_IN-1) <= Data_In;
        end loop;
      else
        Data_Out <= Data_In(0 to C_DWIDTH_OUT-1);
      end if;
      
      if C_DWIDTH_IN > C_SMALLEST_IN then -- Data_Out is a function of Decode_size
        for k in log2(C_SMALLEST_IN/8)+1 to log2(C_DWIDTH_IN/8)+1 loop  -- 1,2,3,4,5,6,7   6 for now
          factor := pwr(2,k)/2; -- 1,2,4,8,16,32,64 number of byte lanes
           if Decode_size = Conv_std_logic_vector(k,3) then
             if IP_Addr_Start > -1 then -- Data_Out IS a function of address -- TESTED
               for j in 0 to pwr(2,num_addr_bits)-1 loop 
                 if Addr(C_AWIDTH-IP_Addr_Stop-1 to C_AWIDTH-IP_Addr_Start-1) = Conv_std_logic_vector(j,num_addr_bits) then
                   address := j*pwr(2,IP_Addr_Start); -- generate real address from j loop variable
                   data_address := address;
                   if address = 0 then     -- special case for address zero
                     size := factor*8;     -- size in bits
                   end if;
                   if address > 0 then     -- else look up in size table
                     size := ADDR_SIZE(address)*8;  -- size in bits
                   end if;
                   if size <= C_DWIDTH_OUT then   -- for case when data at address is smaller than host data bus
                     replicate_factor := C_DWIDTH_OUT/size;
                     while data_address >= factor loop    -- modulo operator since mod doesn't work in Synplify if right side isn't constant
                       data_address := data_address - factor;
                     end loop;
                     for r in 0 to replicate_factor-1 loop
                       for m in 0 to size-1 loop  -- set first "size" data to data on Data_In at "address"
                         Data_Out(r*size+m) <= Data_In(data_address*8 + m);
                       end loop;
                     end loop;
                   else  -- for case when data at address is larger than host data bus, just det first C_DWIDTH_OUT bits  
                       Data_Out(0 to C_DWIDTH_OUT-1) <= Data_In(address*8 to address*8+C_DWIDTH_OUT-1);
                   end if;
                 end if;
               end loop;
             else -- Data_Out is not a function of address 
                   if factor*8 <= C_DWIDTH_OUT then
                     for m in 0 to C_DWIDTH_OUT/(factor*8)-1 loop
                       Data_Out(factor*8*m to factor*8*(m+1)-1) <= Data_In(0 to factor*8-1);
                     end loop;
                   else 
                     for m in 0 to C_DWIDTH_OUT-1 loop
                       Data_Out(m) <= Data_In(m mod C_DWIDTH_IN); -- just carry data across.
                     end loop;
                   end if;
             end if;
           end if;
         end loop;

      else -- Data_Out is not a function of Decode_Size
             if IP_Addr_Start > -1 then -- Data_Out IS a function of address -- TESTED
               for j in 0 to pwr(2,num_addr_bits)-1 loop 
                 if Addr(C_AWIDTH-IP_Addr_Stop-1 to C_AWIDTH-IP_Addr_Start-1) = Conv_std_logic_vector(j,num_addr_bits) then
                   address := j*pwr(2,IP_Addr_Start); -- generate real address from j loop variable
                   if address = 0 then     -- special case for address zero
                     size := C_DWIDTH_IN; -- size in bits
                   end if;
                   if address > 0 then     -- else look up in size table
                     size := ADDR_SIZE(address)*8;  -- size in bits
                   end if;
                   if size <= C_DWIDTH_OUT then   -- for case when data at address is smaller than host data bus
                     replicate_factor := C_DWIDTH_OUT/size;
                     for r in 0 to replicate_factor-1 loop
                       for m in 0 to size-1 loop  -- set first "size" data to data on Data_In at "address"
                         Data_Out(r*size+m) <= Data_In(address*8+m);
                       end loop;
                     end loop;
--                     for m in size to C_DWIDTH_OUT-1 loop  -- set remaining bits to default
--                       Data_Out(m) <= Data_In(m mod C_DWIDTH_IN); -- mod in case host data bus larger than Data_In
--                     end loop;
                   else  -- for case when data at address is larger than host data bus, just det first C_DWIDTH_OUT bits  
                       Data_Out(0 to C_DWIDTH_OUT-1) <= Data_In(address*8 to address*8+C_DWIDTH_OUT-1);
                   end if;
                 end if;
               end loop;
             else -- Data_Out is not a function of address
               for m in 0 to C_DWIDTH_OUT-1 loop  -- 0 to 3
                 Data_Out(m) <= Data_In(m mod C_DWIDTH_IN); -- just carry data across.
               end loop;
             end if;

      end if;
  end process MUX_PROCESS;       
  
end architecture IMP;
