-------------------------------------------------------------------------------
-- $Id: ld_arith_reg.vhd,v 1.3 2001/12/18 16:41:34 ostlerf Exp $
-------------------------------------------------------------------------------
-- Loadable arithmetic register.
-------------------------------------------------------------------------------
--
--                  ****************************
--                  ** Copyright Xilinx, Inc. **
--                  ** All rights reserved.   **
--                  ****************************
--
-------------------------------------------------------------------------------
-- Filename:        ld_arith_reg.vhd
-- Version:         
--------------------------------------------------------------------------------
-- Description:   A register that can be loaded and added to or subtracted from
--                (but not both). The width of the register is specified
--                with a generic. The load value and the arith
--                value, i.e. the value to be added (subtracted), may be of
--                lesser width than the register and may be
--                offset from the LSB position. (Uncovered positions
--                load or add (subtract) zero.) The register can be
--                reset, via the RST signal, to a freely selectable value.
--                The register is defined in terms of big-endian bit ordering.
--
-------------------------------------------------------------------------------
-- Structure: 
--
--              ld_arith_reg.vhd
-------------------------------------------------------------------------------
-- Author:      FO
--
-- History:
--
--      FO      08/01        -- First version
--
--      FO      11/14/01
--                        Cosmetic improvements
--
--      FO      12/18/01
--                        Renamed to ClkEn to workaround XST deficiency.
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

entity ld_arith_reg is
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
        -- Offset from the LSB (toward more significant) of the load data.
        C_LD_OFFSET   : natural :=  0;
        ------------------------------------------------------------------------
        -- Width of the arithmetic data.
        C_AD_WIDTH    : natural :=  8;
        ------------------------------------------------------------------------
        -- Offset from the LSB of the arithmetic data.
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
end ld_arith_reg;
  

library unisim;
use unisim.all;

library ieee;
use ieee.numeric_std.all;

architecture imp of ld_arith_reg is

    component MULT_AND
       port(
          LO :	out   std_ulogic;
          I1 :	in    std_ulogic;
          I0 :	in    std_ulogic);
    end component;

    component MUXCY_L is
      port (
        DI : in  std_logic;
        CI : in  std_logic;
        S  : in  std_logic;
        LO : out std_logic);
    end component MUXCY_L;

    component XORCY is
      port (
        LI : in  std_logic;
        CI : in  std_logic;
        O  : out std_logic);
    end component XORCY;

    component FDRE is
      port (
        Q  : out std_logic;
        C  : in  std_logic;
        CE : in  std_logic;
        D  : in  std_logic;
        R  : in  std_logic
      );
    end component FDRE;
  
    component FDSE is
      port (
        Q  : out std_logic;
        C  : in  std_logic;
        CE : in  std_logic;
        D  : in  std_logic;
        S  : in  std_logic
      );
    end component FDSE;
  
    signal q_i,
           q_i_ns,
           xorcy_out,
           gen_cry_kill_n : std_logic_vector(0 to C_REG_WIDTH-1);
    signal cry : std_logic_vector(0 to C_REG_WIDTH);

begin

    -- synthesis translate_off

    assert C_LD_WIDTH + C_LD_OFFSET <= C_REG_WIDTH 
        report "ld_arith_reg, constraint does not hold: " &
               "C_LD_WIDTH + C_LD_OFFSET <= C_REG_WIDTH"
        severity error;
    assert C_AD_WIDTH + C_AD_OFFSET <= C_REG_WIDTH 
        report "ld_arith_reg, constraint does not hold: " &
               "C_AD_WIDTH + C_AD_OFFSET <= C_REG_WIDTH"
        severity error;

    -- synthesis translate_on

    Q <= q_i;

    cry(C_REG_WIDTH) <= '0' when C_ADD_SUB_NOT else OP;

    PERBIT_GEN: for j in C_REG_WIDTH-1 downto 0 generate
        signal load_bit, arith_bit, ClkEn : std_logic;
    begin

        ------------------------------------------------------------------------
        -- Assign to load_bit either zero or the bit from input port LD.
        ------------------------------------------------------------------------
        D_ZERO_GEN: if    j > C_REG_WIDTH - 1 - C_LD_OFFSET 
                       or j < C_REG_WIDTH - C_LD_WIDTH - C_LD_OFFSET generate
            load_bit <= '0';
        end generate;
        D_NON_ZERO_GEN: if    j <= C_REG_WIDTH - 1 - C_LD_OFFSET 
                          and j >= C_REG_WIDTH - C_LD_OFFSET - C_LD_WIDTH
        generate
            load_bit <= LD(j - (C_REG_WIDTH - C_LD_WIDTH - C_LD_OFFSET));
        end generate;

        ------------------------------------------------------------------------
        -- Assign to arith_bit either zero or the bit from input port AD.
        ------------------------------------------------------------------------
        AD_ZERO_GEN: if    j > C_REG_WIDTH - 1 - C_AD_OFFSET 
                        or j < C_REG_WIDTH - C_AD_WIDTH - C_AD_OFFSET
        generate
            arith_bit <= '0';
        end generate;
        AD_NON_ZERO_GEN: if    j <= C_REG_WIDTH - 1 - C_AD_OFFSET 
                           and j >= C_REG_WIDTH - C_AD_OFFSET - C_AD_WIDTH
        generate
            arith_bit <= AD(j - (C_REG_WIDTH - C_AD_WIDTH - C_AD_OFFSET));
        end generate;


        ------------------------------------------------------------------------
        -- LUT output generation.
        -- Adder case
        ------------------------------------------------------------------------
        Q_I_GEN_ADD: if C_ADD_SUB_NOT generate
            q_i_ns(j) <= q_i(j) xor  arith_bit when  OP = '1' else load_bit;
        end generate;
        ------------------------------------------------------------------------
        -- Subtractor case
        ------------------------------------------------------------------------
        Q_I_GEN_SUB: if not C_ADD_SUB_NOT generate
            q_i_ns(j) <= q_i(j) xnor arith_bit when  OP = '1' else load_bit;
        end generate;


        ------------------------------------------------------------------------
        -- Kill carries (borrows) for loads but
        -- generate or kill carries (borrows) for add (sub).
        ------------------------------------------------------------------------
        MULT_AND_i1: MULT_AND
           port map (
              LO => gen_cry_kill_n(j),
              I1 => OP,
              I0 => Q_i(j)
           );

        ------------------------------------------------------------------------
        -- Propagate the carry (borrow) out.
        ------------------------------------------------------------------------
        MUXCY_L_i1: MUXCY_L
          port map (
            DI => gen_cry_kill_n(j),
            CI => cry(j+1),
            S  => q_i_ns(j),
            LO => cry(j)
          );

        ------------------------------------------------------------------------
        -- Apply the effect of carry (borrow) in.
        ------------------------------------------------------------------------
        XORCY_i1: XORCY
          port map (
            LI => q_i_ns(j),
            CI => cry(j+1),
            O  =>  xorcy_out(j)
          );


        ClkEn <= LOAD or OP;


        ------------------------------------------------------------------------
        -- Generate either a resettable or setable FF for bit j, depending
        -- on C_RESET_VALUE at bit j.
        ------------------------------------------------------------------------
        FF_RST0_GEN: if C_RESET_VALUE(j) = '0' generate
            FDRE_i1: FDRE
              port map (
                Q  => q_i(j),
                C  => CK,
                CE => ClkEn,
                D  => xorcy_out(j),
                R  => RST
              );
        end generate;
        FF_RST1_GEN: if C_RESET_VALUE(j) = '1' generate
            FDSE_i1: FDSE
              port map (
                Q  => q_i(j),
                C  => CK,
                CE => ClkEn,
                D  => xorcy_out(j),
                S  => RST
              );
        end generate;

      end generate;

end imp;
