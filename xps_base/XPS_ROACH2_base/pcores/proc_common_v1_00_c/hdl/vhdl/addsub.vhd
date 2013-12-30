-------------------------------------------------------------------------------
-- $Id: addsub.vhd,v 1.1 2003/08/29 17:58:59 ostlerf Exp $
-------------------------------------------------------------------------------
-- Either add an ArgA or subtract an ArgS from an ArgD.
-------------------------------------------------------------------------------
--
--                  ****************************
--                  ** Copyright Xilinx, Inc. **
--                  ** All rights reserved.   **
--                  ****************************
--
-------------------------------------------------------------------------------
-- Filename:        addsub.vhd
-- Version:         
--------------------------------------------------------------------------------
-- Description:  
--                Either add an ArgA or subtract an ArgS from an ArgD. The
--                output, Result, can be optionally combinatorial or registered.
--
--                When C_REGISTERED is false, Result will take on one of
--                two values:
--
--                ArgD - ArgS, when Sub is asserted, or
--                ArgD + ArgA, when Sub is not asserted.
--
--                Cry_BrwN will be '1' if ArgD + ArgA produces a carry 
--                and it will be   '0' if ArgD - ArgS produces a borrow.
--
--                The signals Clk, Rst and CE are meaningful and used only
--                if C_REGISTERED is true. These may be "tied off" to any
--                std_logic value in combinatorial instantiations (e.g. 
--                connected to '0').
--
--                This table details the operation in registered mode:
--
--                Clk        Rst       CE    Sub      <Cry_BrwN, Result>
--                ---        ---       --    ---      ------------------
--                  _
--                _|          1         x     x       0
--                
--                  _
--                _|          0         1     0       ArgD + ArgA
--
--                  _
--                _|          0         1     1       ArgD - ArgS
--
--                  _
--                _|          0         0     x       No change
--
--                     _
--               not _|       x         x     x       No change
--
-------------------------------------------------------------------------------
-- Structure: 
--
--              addsub.vhd
-------------------------------------------------------------------------------
-- Author:      FO
--
-- History:
--
--      FO      08/14/2003        -- First version
--
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

entity addsub is
    generic (
        C_WIDTH   : natural := 8;
        C_REGISTERED : boolean := false
    );
    port (
        Clk      : in  std_logic;
        Rst      : in  std_logic; -- Reset Result and Cry_BrwN to zero
        CE       : in  std_logic;
        ArgD     : in  std_logic_vector(0 to C_WIDTH-1);
        ArgA     : in  std_logic_vector(0 to C_WIDTH-1);
        ArgS     : in  std_logic_vector(0 to C_WIDTH-1);
        Sub      : in  std_logic;
        Cry_BrwN : out std_logic;
        Result   : out std_logic_vector(0 to C_WIDTH-1)
    );
end addsub;
  

library unisim;
use unisim.VCOMPONENTS.FDRE;
use unisim.VCOMPONENTS.MUXCY;
use unisim.VCOMPONENTS.XORCY;

library ieee;
use ieee.numeric_std.all;

architecture imp of addsub is

    signal lutout,
           xorcy_out : std_logic_vector(0 to C_WIDTH-1);
    signal cry : std_logic_vector(0 to C_WIDTH);

begin

    cry(C_WIDTH) <= Sub;


    PERBIT_GEN: for j in C_WIDTH-1 downto 0 generate
    begin

        ------------------------------------------------------------------------
        -- LUT output generation.
        ------------------------------------------------------------------------
        lutout(j) <= ArgD(j) xor  ArgA(j) when Sub = '0' else
                     ArgD(j) xnor ArgS(j);

        ------------------------------------------------------------------------
        -- Propagate the carry (borrow) out.
        ------------------------------------------------------------------------
        MUXCY_i1: MUXCY
          port map (
            DI => ArgD(j),
            CI => cry(j+1),
            S  => lutout(j),
            O  => cry(j)
          );

        ------------------------------------------------------------------------
        -- Apply the effect of carry (borrow) in.
        ------------------------------------------------------------------------
        XORCY_i1: XORCY
          port map (
            LI => lutout(j),
            CI => cry(j+1),
            O  =>  xorcy_out(j)
          );


        ------------------------------------------------------------------------
        -- Result, combinatorial or registered.
        ------------------------------------------------------------------------
        COM_GEN : if not C_REGISTERED generate
            Result(j) <= xorcy_out(j);
        end generate;
        -- else
        REG_GEN : if     C_REGISTERED generate
                FDRE_I1: FDRE
                  port map (
                    Q  => Result(j),
                    C  => Clk,
                    CE => CE,
                    D  => xorcy_out(j),
                    R  => Rst
                  );
        end generate;

    end generate;

    ----------------------------------------------------------------------------
    -- Cry_BrwN, combinatorial or registered.
    ----------------------------------------------------------------------------
    COM_GEN : if not C_REGISTERED generate
        Cry_BrwN <= cry(0);
    end generate;
    -- else
    REG_GEN : if     C_REGISTERED generate
            FDRE_I1: FDRE
              port map (
                Q  => Cry_BrwN,
                C  => Clk,
                CE => CE,
                D  => cry(0),
                R  => Rst
              );
    end generate;

end imp;
