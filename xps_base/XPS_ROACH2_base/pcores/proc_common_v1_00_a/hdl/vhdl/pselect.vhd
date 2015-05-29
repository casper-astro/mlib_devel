-------------------------------------------------------------------------------
-- $Id: pselect.vhd,v 1.4 2003/06/29 21:50:26 jcanaris Exp $
-------------------------------------------------------------------------------
-- pselect.vhd - entity/architecture pair
-------------------------------------------------------------------------------
--
--                  ****************************
--                  ** Copyright Xilinx, Inc. **
--                  ** All rights reserved.   **
--                  ****************************
--
-------------------------------------------------------------------------------
-- Filename:        pselect.vhd
--
-- Description:     Parameterizeable peripheral select (address decode).
--                  AValid qualifier comes in on Carry In at bottom 
--                  of carry chain. For version with AValid at top of
--                  carry chain, see pselect_top.vhd.
--                  
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:   
--                  pselect.vhd
--
-------------------------------------------------------------------------------
-- Author:          B.L. Tise
-- Revision:        $Revision: 1.4 $
-- Date:            $Date: 2003/06/29 21:50:26 $
--
-- History:
--   BLT            2001-04-10    First Version
--   BLT            2001-04-23    Moved function to this file
--   BLT            2001-05-21    Changed library to MicroBlaze
--   BLT            2001-08-13    Changed pragma to synthesis
--   ALS            2001-10-15    C_BAR is now padded to nearest multiple of 4
--                                to handle lut equations
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
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

library unisim;
use unisim.all;

-- use PAD4 function from proc common package
library proc_common_v1_00_a;
use proc_common_v1_00_a.proc_common_pkg.all;

-----------------------------------------------------------------------------
-- Entity section
-----------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Definition of Generics:
--          C_AB            -- number of address bits to decode
--          C_AW            -- width of address bus
--          C_BAR           -- base address of peripheral (peripheral select
--                             is asserted when the C_AB most significant
--                             address bits match the C_AB most significant
--                             C_BAR bits
-- Definition of Ports:
--          A               -- address input
--          AValid          -- address qualifier
--          CS              -- peripheral select
-------------------------------------------------------------------------------

entity pselect is
  
  generic (
    C_AB     : integer := 9;
    C_AW     : integer := 32;
    C_BAR    : std_logic_vector
    );
  port (
    A        : in   std_logic_vector(0 to C_AW-1);
    AValid   : in   std_logic;
    CS       : out  std_logic
    );

end entity pselect;

-----------------------------------------------------------------------------
-- Architecture section
-----------------------------------------------------------------------------

architecture imp of pselect is

  component LUT4
    generic(
      INIT : bit_vector := X"0000"
      );
    port (
      O  : out std_logic;
      I0 : in  std_logic := '0';
      I1 : in  std_logic := '0';
      I2 : in  std_logic := '0';
      I3 : in  std_logic := '0');
  end component;
  component MUXCY is
    port (
      O  : out std_logic;
      CI : in  std_logic;
      DI : in  std_logic;
      S  : in  std_logic
    );
  end component MUXCY;
   
  attribute INIT        : string;

-----------------------------------------------------------------------------
-- Constant Declarations
-----------------------------------------------------------------------------
  constant  NUM_LUTS    : integer := (C_AB-1)/4+1;
-- pad size of address bus to nearest multiple of 4
  constant  AW_4        : integer := pad_4(C_AW);   
  
-----------------------------------------------------------------------------
-- Signal Declarations
-----------------------------------------------------------------------------
  
  signal    lut_out     : std_logic_vector(0 to NUM_LUTS-1);
  signal    carry_chain : std_logic_vector(0 to NUM_LUTS);

-- initialize the padded base address to all zeros
  signal    bar_4       : std_logic_vector(0 to AW_4-1) := (others => '0');
  

  -- function to initialize LUT within pselect 
  type int4 is array (3 downto 0) of integer;  
  function pselect_init_lut(i        : integer;
                    AB       : integer;
                    NUM_LUTS : integer;
                    C_AW     : integer;
                    C_BAR    : std_logic_vector(0 to 31)) 
  return bit_vector is
    variable init_vector : bit_vector(15 downto 0) := X"0001";
    variable j           : integer := 0;
    variable val_in      : int4;
  begin
    for j in 0 to 3 loop
      if i < NUM_LUTS-1 or j <= ((AB-1) mod 4) then
           val_in(j) := conv_integer(C_BAR(i*4+j));
      else val_in(j) := 0;
      end if;
    end loop;
    init_vector := To_bitvector(conv_std_logic_vector(2**(val_in(3)*8+
                   val_in(2)*4+val_in(1)*2+val_in(0)*1),16));
    return init_vector;
  end pselect_init_lut;

-------------------------------------------------------------------------------
-- Begin architecture section
-------------------------------------------------------------------------------
begin  -- VHDL_RTL

-- assign the padded base address to the input base address
bar_4(0 to C_AW-1) <= C_BAR;

carry_chain(0) <= AValid;
GEN_DECODE: for i in 0 to NUM_LUTS-1 generate
  signal   lut_in    : std_logic_vector(3 downto 0);
  begin
    GEN_LUT_INPUTS: for j in 0 to 3 generate
       -- Generate to assign address bits to LUT4 inputs
       GEN_INPUT: if i < NUM_LUTS-1 or j <= ((C_AB-1) mod 4) generate
         lut_in(j) <= A(i*4+j);
       end generate;
       -- Generate to assign zeros to remaining LUT4 inputs
       GEN_ZEROS: if not(i < NUM_LUTS-1 or j <= ((C_AB-1) mod 4)) generate
         lut_in(j) <= '0';
       end generate;
    end generate;

-------------------------------------------------------------------------------
-- RTL version without LUT instantiation for XST
-------------------------------------------------------------------------------
    
--    lut_out(i) <=  (lut_in(0) xnor C_BAR(i*4+0)) and
--                   (lut_in(1) xnor C_BAR(i*4+1)) and
--                   (lut_in(2) xnor C_BAR(i*4+2)) and
--                   (lut_in(3) xnor C_BAR(i*4+3));
--
    lut_out(i) <=  (lut_in(0) xnor bar_4(i*4+0)) and
                   (lut_in(1) xnor bar_4(i*4+1)) and
                   (lut_in(2) xnor bar_4(i*4+2)) and
                   (lut_in(3) xnor bar_4(i*4+3));

-------------------------------------------------------------------------------
-- Structural version with LUT instantiation for Synplicity (when RLOC is
--  desired for placing LUT
-------------------------------------------------------------------------------
                  
--    LUT4_I : LUT4
--      generic map(
--        -- Function init_lut is used to generate INIT value for LUT4
--        INIT => pselect_init_lut(i,C_AB,NUM_LUTS,C_AW,C_BAR)
--        )
--      port map (
--        O  => lut_out(i),  -- [out]
--        I0 => lut_in(0),   -- [in]
--        I1 => lut_in(1),   -- [in]
--        I2 => lut_in(2),   -- [in]
--        I3 => lut_in(3));  -- [in]

-------------------------------------------------------------------------------

    MUXCY_I: MUXCY
      port map (
        O  => carry_chain(i+1), --[out]
        CI => carry_chain(i),   --[in]
        DI => '0',              --[in]
        S  => lut_out(i)        --[in]
      );    
end generate;
CS <= carry_chain(NUM_LUTS); -- assign end of carry chain to output
end imp;

