-------------------------------------------------------------------------------
-- $Id: xor_f.vhd,v 1.1 2008/01/17 22:12:37 dougt Exp $
-------------------------------------------------------------------------------
-- xor_f
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
-- ** Copyright (c) 2006-2008 Xilinx, Inc. All rights reserved.           **
-- **                                                                     **
-- ** This copyright and support notice must be retained as part          **
-- ** of this text at all times.                                          **
-- **                                                                     **
-- *************************************************************************
--
-------------------------------------------------------------------------------
-- Filename:      xor_f.vhd
--
-- Description:   Xor_out <= xor_reduce(In_bus)
--
--                In other words the C_NUM_BITS bits of vector In_bus are
--                XOR'ed together to form Xor_out.
--
--                The implementation will depend on C_FAMILY. If the FPGA
--                architecture corresponding to C_FAMILY supports the
--                XORCY and MUXCY primitives and the traditional carry chain,
--                then the implementation will be structural and
--                a local XOR gate in the hierarchy will consist, in
--                general, of two LUTs programmed for XOR functionality
--                feeding their unique commonly reachable XORCY (through
--                a MUXCY in the case of the upstream LUT).
--
--                Here are some properties of the overall structural XOR gate:
--                  - The maximum number of levels of the local XOR gates will
--                  be minimal.
--                  - The number of inputs that have the maximum number of
--                  levels will also be minimal.
--                  - At most one LUT will have partially populated inputs.
--
--                The structural implementation also takes into account
--                the differences between pre-virtex5, LUT4-based FPGAs
--                and post-virtex5-style LUT6-based FPGAs.
--
--                If the structural XOR gate cannot be built, either because
--                C_FAMILY does not support the requisite primitives and
--                carry-chain structure or because C_FAMILY is set (or left
--                defaulted) to "nofamily", then the implementation is 
--                inferred by synthesis.
--
-------------------------------------------------------------------------------
-- Structure:       Common use module with two locally declared helper units.
-------------------------------------------------------------------------------

-- Author:      FLO
-- History:
--  FLO         07/24/06      -- First version
-- ~~~~~~
-- FLO            12/20/07
-- ^^^^^^
-- Eliminated making the min function directly visible from a package because
-- in ncsim this results in two min identifiers being made directly visible.
-- These two are the function and the min (minutes) identifier from the
-- 'pseudo' package, STANDARD.
-- ~~~~~~
--
--     DET     1/17/2008     v3_00_a
-- ~~~~~~
--     - Changed proc_common library version to v3_00_a
--     - Incorporated new disclaimer header
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

--------------------------------------------------------------------------------
-- The xor_f entity is declared further down.
-- First, a helper entity, recursive_xor, is declared.
--------------------------------------------------------------------------------

library ieee;
use     ieee.std_logic_1164.all;
--
entity recursive_xor is
    generic (
        L : positive; -- Length of the input vector
        N : positive  -- Width of xor gate used in the hierarchy
    );
    port (
        In_bus  : in  std_logic_vector(0 to L-1);
        Xor_out : out std_logic     
    );
end recursive_xor;

library proc_common_v3_00_a;
library unisim;
use     unisim.vcomponents.all;
---(
architecture implementation of recursive_xor is
    --
    type bo2na_type is array (boolean) of natural;
    constant bo2na : bo2na_type := (false => 0, true => 1);
    --
    function greatest_power_of_N_lt_L (N, L: positive) return positive is
        variable x : positive := 1;
    begin
        while x*N < L loop
            x := x*N;
        end loop;
        return x;
    end;
    --
    constant G  : positive := greatest_power_of_N_lt_L(N, L);
    constant LDG: natural  := L/G; -- L divided by G
    constant EXTRA_G_NEEDED: boolean  := L-(LDG*G) > (N-LDG)*(G/N); -- Another
        -- sub XOR with more than G/N inputs, but less than G inputs, is
        -- needed if the rest of the inputs beyond (LDG)*G won't fit into
        -- the (N-LDG) inputs that are left over and are allocated to
        -- each process a sub XOR of size G/N.
    constant NG : natural  := LDG + bo2na(EXTRA_G_NEEDED); -- Number of sub
        -- XOR's of size G.
        -- Note: One of these groupings of "size G" in general is adjusted
        -- to a smaller size and represents the only sub XOR that may be
        -- of size not a power of N.
    constant P   :  positive := L - (NG-1)*G - (N-NG)*(G/N); -- Each of the N
        -- sub XORs will have either G or G/N inputs, except one, which
        -- will have P inputs, where G/N < P <= G.
    constant NIB :  positive
                 := bo2na(L< N)*L +
                    bo2na(L>=N)*N; -- Number of ib bits used at this level.
    constant DLS : positive := bo2na(N=8)*4 + bo2na(N=11)*6; -- Downstream
        -- LUT Size. In general, the XOR at the current level is made up of two
        -- carry-chain-adjacent LUTs whose outputs are XOR'ed by the
        -- XORCY associated with the downstream LUT. DLS is the size of
        -- the downstream LUT. The size of the upstream LUT is N-DLS.
    --
    function min (a, b: natural) return natural is
    begin
        if (a>b) then return b; else return a; end if;
    end;
    --
    function xor_reduce (v : std_logic_vector) return std_logic is
        variable r : std_logic := '0';
    begin
        for i in v'range loop
            r := r xor v(i);
        end loop;
        return r;
    end;
    --
    signal ib : std_logic_vector(0 to N-1); -- The Input Bits to the
        -- xor at this level.
    attribute keep : string;
    attribute keep of ib : signal is "true"; -- To inhibit unpredictable
        -- (and possibly non-productive) synthesis optimizations.
    --
    signal lutout0 : std_logic;
    --
begin
  ---(--------------------------------------------------------------------------
  -- Sub-divide the XOR problem across the N inputs at the current level.
  -- Use recursive instantiation as needed.
  ------------------------------------------------------------------------------
  --
  PARTIAL_N_GEN : if NIB < N generate -- Some inputs at current level are unfilled.
      ib(0 to L-1) <= In_bus;
  end generate;
  --
  FULL_N_GEN : if NIB = N generate -- All N inputs at current level are filled.
    SUBSTRUCTURE_GEN : for i in 0 to N-1 generate
       constant START :  natural
                      :=   bo2na(i<=NG-1)*i*G
                         + bo2na(i> NG-1)*((NG-1)*G + P + (i-NG)*(G/N));
       constant LEN   :  natural
                      :=   bo2na(i<NG-1)*G
                         + bo2na(i=NG-1)*P
                         + bo2na(i>NG-1)*(G/N);
    begin
        --
        RECUR_GEN : if LEN /= 1 generate -- Recursive instantiation
            --
            RECURSIVE_XOR_I : entity recursive_xor
                generic map (L => LEN, N => N)
                port map (
                    In_bus  => In_bus(START to START + LEN - 1),
                    Xor_out => ib(i)
                );
            --
        end generate;
        --
        BASE_GEN : if LEN = 1 generate
            ib(i) <= In_bus(START);
        end generate;
        --
    end generate;
  end generate;
  ---)
  ---(------------------------------------------------------------------------
  -- Build the XOR gate at the current level.
  ----------------------------------------------------------------------------
  --
  NO_LUT_NEEDED_GEN : if NIB = 1 generate
      Xor_out <= In_bus(0);
  end generate;
  --
  DOWNSTREAM_LUT_NEEDED_GEN : if NIB /= 1 generate
      --
      lutout0 <= xor_reduce(ib(0 to min(NIB, DLS)-1));
      --
      OUTPUT_FROM_GEN : if NIB <= DLS generate
          Xor_out <= lutout0;
      end generate;
      --
  end generate;
  --
  UPSTREAM_LUT_NEEDED_GEN : if NIB > DLS generate
      signal lutout1, di, ci, cy : std_logic;
  begin
      --------------------------------------------------------------------------
      -- - When N=8, the pre-virtex5 LUT-MUXCY-XORCY structure is used. The
      -- CI and DI inputs are set to '1' and '0', respectively, to
      -- allow the xor function realized in the upstream LUT to be
      -- sent downstream through the MUXCY.
      --
      -- - When N=11, a virtex5-type LUT-MUXCY-XORCY structure is assumed.
      -- The facts that (1) carry chains can only be initialized on 4-LUT
      -- slice boundaries and (2) the DI and S inputs of the MUXCY can be
      -- driven by separate LUT5's are taken into consideration.
      -- Driving the upstream XOR function through DI means
      -- that only a five-bit XOR is implemented in the upstream LUT.
      -- On the other hand, since the CI input is not needed,
      -- the 11-bit upstream/downstream LUT pair can be packed at
      -- any LUT position except the very last (most downstream) in a
      -- whole column. If the CI input were used, only one in four LUTs
      -- could serve as the upstream LUT. The better packing flexibility
      -- is preferred over utilization of all 12, rather than 11, of
      -- the available LUT inputs. 
      --------------------------------------------------------------------------
      --
      lutout1 <= xor_reduce(ib(DLS to NIB-1)) when N=8  else '0';
      di      <= xor_reduce(ib(DLS to NIB-1)) when N=11 else '0';
      ci      <= '1' when N=8  else '-';
      --
      MUXCY_I : component MUXCY port map (
          O  => cy,
          CI => ci,
          DI => di,
          S  => lutout1
      );
      --
      XORCY_I : component XORCY port map (
          O  => Xor_out,
          CI => cy,
          LI => lutout0
      );
      --
  end generate;
  ---)
end architecture implementation;
---)


library ieee;
use     ieee.std_logic_1164.all;
--
entity xor_f is
    generic (
        C_NUM_BITS             : natural;
        C_FAMILY               : string := "nofamily"
    );
    port (
        In_bus  : in  std_logic_vector(0 to C_NUM_BITS-1);
        Xor_out : out std_logic     
    );
end xor_f;


library proc_common_v3_00_a;
use     proc_common_v3_00_a.family_support.all;
        -- Makes visible the function 'supported' and related types,
        -- including enumeration literals for the unisim primitives (e.g.
        -- the "u_" prefixed identifiers such as u_MUXCY, u_LUT4, etc.).
library work;
use     work.recursive_xor;
--
architecture implementation of xor_f is
    --
    type bo2na_type is array (boolean) of natural;
    constant bo2na : bo2na_type := (false => 0, true => 1);
    ----------------------------------------------------------------------------
    -- Here is determined which structural or inferred implementation to use.
    ----------------------------------------------------------------------------
    constant USE_STRUCTURAL_A : boolean := (In_bus'length > 0) and
                                           supported(C_FAMILY,
                                                     (u_MUXCY, u_XORCY)
                                                    );
    constant NLS              : natural := native_lut_size(C_FAMILY);
    constant USE_INFERRED     : boolean := not USE_STRUCTURAL_A;
    --
    function xor_reduce (v : std_logic_vector) return std_logic is
        variable r : std_logic := '0';
    begin
        for i in v'range loop
            r := r xor v(i);
        end loop;
        return r;
    end;
    --
begin
    ---(------------------------------------------------------------------------
    -- Inferred implementation.
    ----------------------------------------------------------------------------
    INFERRED_GEN : if USE_INFERRED generate
    begin
        Xor_out <= xor_reduce(In_bus);
    end generate;
    ---)
    ---(------------------------------------------------------------------------
    -- Structural implementation A.
    ----------------------------------------------------------------------------
    STRUCTURAL_A_GEN : if USE_STRUCTURAL_A generate
        constant N : positive := bo2na(NLS=4)*8 + bo2na(NLS=6)*11;
    begin
        I_RECURSIVE_XOR_A: entity recursive_xor
            generic map (
                L => C_NUM_BITS,
                N => N
            )
            port map (
                In_bus  => In_bus,
                Xor_out => Xor_out
            );
    end generate;
    ---)
end implementation;

