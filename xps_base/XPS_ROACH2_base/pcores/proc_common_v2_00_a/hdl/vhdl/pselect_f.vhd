-------------------------------------------------------------------------------
-- $Id: pselect_f.vhd,v 1.6 2006/06/01 14:55:06 murtuzac Exp $
-------------------------------------------------------------------------------
-- pselect_f.vhd - entity/architecture pair
-------------------------------------------------------------------------------
--
--                  ****************************
--                  ** Copyright Xilinx, Inc. **
--                  ** All rights reserved.   **
--                  ****************************
--
-------------------------------------------------------------------------------
-- Filename:        pselect_f.vhd
--
-- Description:
--                  (Note: At least as early as I.31, XST implements a carry-
--                   chain structure for most decoders when these are coded in
--                   inferrable VHLD. An example of such code can be seen
--                   below in the "INFERRED_GEN" Generate Statement.
--
--                   ->  New code should not need to instantiate pselect-type
--                       components.
--
--                   ->  Existing code can be ported to Virtex5 and later by
--                       replacing pselect instances by pselect_f instances.
--                       As long as the C_FAMILY parameter is not included
--                       in the Generic Map, an inferred implementation
--                       will result.
--
--                   ->  If the designer wishes to force an explicit carry-
--                       chain implementation, pselect_f can be used with
--                       the C_FAMILY parameter set to the target
--                       Xilinx FPGA family.
--                  )
--
--                  Parameterizeable peripheral select (address decode).
--                  AValid qualifier comes in on Carry In at bottom
--                  of carry chain.
--
--
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:       pselect_f.vhd
--                    family_support.vhd
--
-------------------------------------------------------------------------------
-- History:
-- Vaibhav & FLO   05/26/06    First Version
--
-- XYZ            mm/dd/yy
-- ^^^^^^
--   Next log entry.
-- ~~~~~~
-------------------------------------------------------------------------------
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

library unisim;
use unisim.all;

library proc_common_v2_00_a;
use proc_common_v2_00_a.family_support.all;

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

entity pselect_f is

  generic (
    C_AB     : integer := 9;
    C_AW     : integer := 32;
    C_BAR    : std_logic_vector;
    C_FAMILY : string := "nofamily"
    );
  port (
    A        : in   std_logic_vector(0 to C_AW-1);
    AValid   : in   std_logic;
    CS       : out  std_logic
    );

end entity pselect_f;

-----------------------------------------------------------------------------
-- Architecture section
-----------------------------------------------------------------------------

architecture imp of pselect_f is

  component MUXCY is
    port (
      O  : out std_logic;
      CI : in  std_logic;
      DI : in  std_logic;
      S  : in  std_logic
    );
  end component MUXCY;

  constant NLS            : natural := native_lut_size(C_FAMILY);
  constant USE_INFERRED   : boolean :=  not supported(C_FAMILY, u_MUXCY)
                                        or NLS=0         -- LUT not supported.
                                        or C_AB <= NLS;  -- Just one LUT
                                                         -- needed.

  -----------------------------------------------------------------------------
  -- C_BAR may not be indexed from 0 and may not be ascending;
  -- BAR recasts C_BAR to have these properties.
  -----------------------------------------------------------------------------
  constant BAR          : std_logic_vector(0 to C_BAR'length-1) := C_BAR;

  type bo2sl_type is array (boolean) of std_logic;
  constant bo2sl  : bo2sl_type := (false => '0', true => '1');
 
  function min(i, j: integer) return integer is
  begin
      if i<j then return i; else return j; end if;
  end;

begin

  ------------------------------------------------------------------------------
  -- Check that the generics are valid.
  ------------------------------------------------------------------------------
  -- synthesis translate_off
     assert (C_AB <= C_BAR'length) and (C_AB <= C_AW)
     report "pselect_f generic error: " &
            "(C_AB <= C_BAR'length) and (C_AB <= C_AW)" &
            " does not hold."
     severity failure;
  -- synthesis translate_on


  ------------------------------------------------------------------------------
  -- Build a behavioral decoder
  ------------------------------------------------------------------------------
  INFERRED_GEN : if (USE_INFERRED = TRUE ) generate
  begin
  
    XST_WA:if C_AB > 0 generate
      CS  <= AValid when A(0 to C_AB-1) = BAR (0 to C_AB-1) else
             '0' ;
    end generate XST_WA;
    
    PASS_ON_GEN:if C_AB = 0 generate
      CS  <= AValid ;
    end generate PASS_ON_GEN;
    
  end generate INFERRED_GEN;


  ------------------------------------------------------------------------------
  -- Build a structural decoder using the fast carry chain
  ------------------------------------------------------------------------------
  GEN_STRUCTURAL_A : if (USE_INFERRED = FALSE ) generate

      constant  NUM_LUTS    : integer := (C_AB+(NLS-1))/NLS;

      signal    lut_out     : std_logic_vector(0 to NUM_LUTS); -- XST workaround
      signal    carry_chain : std_logic_vector(0 to NUM_LUTS);

  begin

      carry_chain(NUM_LUTS) <= AValid;         -- Initialize start of carry chain.
      CS                    <= carry_chain(0); -- Assign end of carry chain to output.

      XST_WA: if NUM_LUTS > 0 generate         -- workaround for XST
      begin
          GEN_DECODE: for i in 0 to NUM_LUTS-1 generate

            constant NI  : natural  := i;
            constant BTL : positive := min(NLS, C_AB-NI*NLS);-- num Bits This LUT

          begin

                           
              lut_out(i) <= bo2sl(A(NI*NLS to NI*NLS+BTL-1) =     -- LUT
                                  BAR(NI*NLS to NI*NLS+BTL-1));

              MUXCY_I: component MUXCY                            -- MUXCY
                port map (
                  O  => carry_chain(i),
                  CI => carry_chain(i+1),
                  DI => '0',
                  S  => lut_out(i)
                );

          end generate GEN_DECODE;
      end generate XST_WA;

  end generate GEN_STRUCTURAL_A;

end imp;

