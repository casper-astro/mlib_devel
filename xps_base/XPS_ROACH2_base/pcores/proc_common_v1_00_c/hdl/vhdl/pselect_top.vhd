-------------------------------------------------------------------------------
-- $Id: pselect_top.vhd,v 1.2 2003/06/29 21:53:54 jcanaris Exp $
-------------------------------------------------------------------------------
-- pselect_top_imp.vhd - entity/architecture pair
-------------------------------------------------------------------------------
--
--                  ****************************
--                  ** Copyright Xilinx, Inc. **
--                  ** All rights reserved.   **
--                  ****************************
--
-------------------------------------------------------------------------------
-- Filename:        pselect_top_imp.vhd
--
-- Description:     Parameterizeable peripheral select (address decode) that
--                  brings AValid qualifier in at top of carry chain
--                  
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:   
--                  pselect_top_imp.vhd
--
-------------------------------------------------------------------------------
-- Author:          B.L. Tise
-- Revision:        $Revision: 1.2 $
-- Date:            $Date: 2003/06/29 21:53:54 $
--
-- History:
--   BLT            2001-04-23    First Version
--   BLT            2001-05-21    Changed library to MicroBlaze
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
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
library MicroBlaze;
use MicroBlaze.XSRA_Types.all;
use MicroBlaze.XSRA32_ISA.all;
library Unisim;
use Unisim.all;

-----------------------------------------------------------------------------
-- Entity section
-----------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Definition of Generics:
--          C_TARGET        -- Xilinx target family, legal values are
--                             VIRTEX and VIRTEXII (not a string)
--          C_Y             -- Y offset from origin of RPM (family-independent
--                             coordinate system)       Y
--          C_X             -- X offset from origin     ^
--                                                      |
--                                                      |
--                                                       ----> X
--          C_U_SET         -- which USER SET the RLOC parameters belong to
--          C_AB            -- number of address bits to decode
--          C_AW            -- width of address bus
--          C_BAR           -- base address of peripheral (peripheral select
--                             is asserted when the C_AB most significant
--                             address bits match the C_AB most significant
--                             C_BAR bits
-- Definition of Ports:
--          A               -- address input
--          AValid          -- address qualifier
--          PS              -- peripheral select
-------------------------------------------------------------------------------

entity pselect_top is
  
  generic (
    C_TARGET : TARGET_FAMILY_TYPE := VIRTEXII; 
    C_Y      : integer := 0;
    C_X      : integer := 0;
    C_U_SET  : string  := "pselect";
    C_AB     : integer := 11;
    C_AW     : integer := 32;
    C_BAR    : std_logic_vector := X"00000000"
    );
  port (
    A        : in   std_logic_vector(0 to C_AW-1);
    AValid   : in   std_logic;
    PS       : out  std_logic
    );

end entity pselect_top;

-----------------------------------------------------------------------------
-- Architecture section
-----------------------------------------------------------------------------

architecture imp of pselect_top is

  component LUT4
    generic(
      INIT : bit_vector := X"00"
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
  attribute RLOC        : string;
  attribute U_SET       : string;
  constant  NUM_LUTS    : integer := (C_AB)/4+1;
  signal    lut_out     : std_logic_vector(0 to NUM_LUTS-1);
  signal    carry_chain : std_logic_vector(0 to NUM_LUTS);

  type int4 is array (3 downto 0) of integer; 
  
  function pselect_top_init_lut(i        : integer;
                                AB       : integer;
                                NUM_LUTS : integer;
                                C_AW     : integer;
                                C_BAR    : std_logic_vector) 
  return bit_vector is
    variable init_vector : bit_vector(15 downto 0) := X"0001";
    variable j           : integer := 0;
    variable val_in      : int4;
  begin
    for j in 0 to 3 loop
      if i = NUM_LUTS-1 and j+2>((AB+1) mod 4) and 
         ((AB+1) mod 4)>0 and not(AB=4*i+j) then
           val_in(j) := 0;
      end if;
      if AB=4*i+j then
           val_in(j) := 1;
      end if;       
      if not((i = NUM_LUTS-1 and j+2>((AB+1) mod 4))
         and ((AB+1) mod 4)>0) and not(AB=4*i+j) then
           val_in(j) := conv_integer(C_BAR(i*4+j));
      end if;
    end loop;
    init_vector := To_bitvector(conv_std_logic_vector(2**(val_in(3)*8+
                   val_in(2)*4+val_in(1)*2+val_in(0)*1),16));
    return init_vector;
  end pselect_top_init_lut;

begin  -- VHDL_RTL

carry_chain(0) <= '1';
GEN_DECODE: for i in 0 to NUM_LUTS-1 generate
  signal   lut_in    : std_logic_vector(3 downto 0);
  constant RLOC_NAME : string := Get_RLOC_Name(Target => C_TARGET,
                                               Y => C_Y + i,
                                               X => C_X);
  attribute RLOC  of LUT4_I  : label is RLOC_NAME;
  attribute RLOC  of MUXCY_I : label is RLOC_NAME;
  attribute U_SET of LUT4_I  : label is C_U_SET;
  attribute U_SET of MUXCY_I : label is C_U_SET;
  begin
    GEN_LUT_INPUTS: for j in 0 to 3 generate
       -- Generate to assign AValid to last LUT4 in the chain
       GEN_VALID: if C_AB=4*i+j generate
                    lut_in(j) <= AValid;
       end generate;
       -- Generate to assign address bits to LUT4 inputs
       GEN_INPUT: if not((i = NUM_LUTS-1 and j+2>((C_AB+1) mod 4))
                  and ((C_AB+1) mod 4)>0) and not(C_AB=4*i+j) generate
                    lut_in(j) <= A(i*4+j);
       end generate;
       GEN_ZEROS: if i = NUM_LUTS-1 and j+2>((C_AB+1) mod 4) and 
                  ((C_AB+1) mod 4)>0 and not(C_AB=4*i+j) generate
                    lut_in(j) <= '0';
       end generate;
    end generate; 
    LUT4_I : LUT4
      generic map(
        -- Function init_lut is used to generate INIT value for LUT4
        INIT => pselect_top_init_lut(i,C_AB,NUM_LUTS,C_AW,C_BAR)
        )
      port map (
        O  => lut_out(i),  -- [out]
        I0 => lut_in(0),   -- [in]
        I1 => lut_in(1),   -- [in]
        I2 => lut_in(2),   -- [in]
        I3 => lut_in(3));  -- [in]
    MUXCY_I: MUXCY
      port map (
        O  => carry_chain(i+1), --[out]
        CI => carry_chain(i),   --[in]
        DI => '0',              --[in]
        S  => lut_out(i)        --[in]
      );    
end generate;
PS <= carry_chain(NUM_LUTS); -- assign end of carry chain to output
end imp;

