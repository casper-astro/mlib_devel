-------------------------------------------------------------------------------
-- $Id: opb_flex_addr_cntr.vhd,v 1.1.2.1 2009/10/06 21:15:01 gburch Exp $
-------------------------------------------------------------------------------
-- opb_flex_addr_cntr.vhd
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
-- ** Copyright (c) 2003,2009 Xilinx, Inc. All rights reserved.           **
-- **                                                                     **
-- ** This copyright and support notice must be retained as part          **
-- ** of this text at all times.                                          **
-- **                                                                     **
-- *************************************************************************
--
-------------------------------------------------------------------------------
-- Filename:        opb_flex_addr_cntr.vhd
--
-- Description:
--    This VHDL design file implements a flexible counter that is used to implement
-- the address counting function needed for OPB Slave devices. It provides the
-- ability to increment addresses in the following manner:
--  - linear incrementing x1, x2, x4, x8, x16, x32, x64, x128 (burst support)
--
-- Special notes:
--
--  - Count enables must be held low during load operations
--  - Clock enables must be asserted during load operations
--
--
--
-- This file also implements the BE generator function.
--
--
--
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:
--              opb_flex_addr_cntr.vhd
--
-------------------------------------------------------------------------------
-- Author:          DET
-- Revision:        $Revision: 1.1.2.1 $
-- Date:            $3/11/2003$
--
-- History:
--   DET   3/11/2003       Initial Version
--
--
--     DET     7/10/2003     Granite Rls PLB IPIF V1.00.e
-- ^^^^^^
--     - Removed XON generic from LUT4 component declaration and instances.
-- ~~~~~~
--
--      ALS     12/09/2003
-- ^^^^^^
--      Modified for OPB
-- ~~~~~~
--      ALS     12/24/2003
-- ^^^^^^
--      Removed BE generation
-- ~~~~~~
--  GAB         10/05/09
-- ^^^^^^
--  Moved all helper libraries proc_common_v2_00_a, opb_ipif_v3_01_a, and
--  opb_arbiter_v1_02_e locally into opb_v20_v1_10_d
--
--  Updated legal header
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
use IEEE.numeric_std.all;


library unisim; -- Required for Xilinx primitives
use unisim.vcomponents.all;


-------------------------------------------------------------------------------

entity opb_flex_addr_cntr is
  Generic (
     C_AWIDTH : integer := 32
     );

  port (
    Clk            : in  std_logic;
    Rst            : in  std_logic;

   -- address generation
    Load_Enable    : in  std_logic;
    Load_addr      : in  std_logic_vector(C_AWIDTH-1 downto 0);
    Cnt_by_1       : in  std_logic;
    Cnt_by_2       : in  std_logic;
    Cnt_by_4       : in  std_logic;
    Cnt_by_8       : in  std_logic;
    Cnt_by_16      : in  std_logic;
    Cnt_by_32      : in  std_logic;
    Cnt_by_64      : in  std_logic;
    Cnt_by_128     : in  std_logic;
    Clk_En_0       : in  std_logic;
    Clk_En_1       : in  std_logic;
    Clk_En_2       : in  std_logic;
    Clk_En_3       : in  std_logic;
    Clk_En_4       : in  std_logic;
    Clk_En_5       : in  std_logic;
    Clk_En_6       : in  std_logic;
    Clk_En_7       : in  std_logic;
    Addr_out       : out std_logic_vector(C_AWIDTH-1 downto 0);
    Next_addr_out  : out std_logic_vector(C_AWIDTH-1 downto 0);
    Carry_Out      : out std_logic
   );

end entity opb_flex_addr_cntr;


architecture implementation of opb_flex_addr_cntr is

  -- Constants
  -- Types
  -- Counter Signals
     Signal lut_out      : std_logic_vector(C_AWIDTH-1 downto 0);
     Signal addr_out_i   : std_logic_vector(C_AWIDTH-1 downto 0);
     Signal next_addr_i  : std_logic_vector(C_AWIDTH-1 downto 0);
     Signal Cout         : std_logic_vector(C_AWIDTH downto 0);


  -- Component Declarations


  attribute INIT       : string;


begin --(architecture implementation)



  -- Misc logic assignments

   Addr_out         <= addr_out_i;
   Next_addr_out    <= next_addr_i;

   Carry_Out <= Cout(C_AWIDTH);





   ------------------------------------------------------------
   -- For Generate
   --
   -- Label: GEN_ADDR_MSB
   --
   -- For Generate Description:
   --   This For-Gen implements bits 7 and beyond for the the
   -- address counter. The entire slice shares the same clock
   -- enable.
   --
   --
   --
   ------------------------------------------------------------
  -- GEN_ADDR_MSB : for addr_bit_index in 5 to C_AWIDTH-1 generate
   GEN_ADDR_MSB : for addr_bit_index in 7 to C_AWIDTH-1 generate
      -- local variables
      -- local constants
      -- local signals
      -- local component declarations

   begin


      -------------------------------------------------------------------------------
      ---- Address Counter Bits 7 to max address bit


      I_LUT_N : LUT4
        generic map(
          INIT => X"F202"
          )
        port map (
          O  => lut_out(addr_bit_index),
          I0 => addr_out_i(addr_bit_index),
          I1 => '0',
          I2 => Load_Enable,
          I3 => Load_addr(addr_bit_index)
          );

      I_MUXCY_N : MUXCY
        port map (
          DI => '0',
          CI => Cout(addr_bit_index),
          S  => lut_out(addr_bit_index),
          O  => Cout(addr_bit_index+1)
          );

      I_XOR_N : XORCY
        port map (
          LI => lut_out(addr_bit_index),
          CI => Cout(addr_bit_index),
          O  => next_addr_i(addr_bit_index)
          );

      I_FDRE_N: FDRE
        port map (
          Q  => addr_out_i(addr_bit_index),
          C  => Clk,
          CE => Clk_En_7,
          D  => next_addr_i(addr_bit_index),
          R  => Rst
          );


   end generate GEN_ADDR_MSB;



-------------------------------------------------------------------------------
---- Address Counter Bit 6


  I_LUT6 : LUT4
    generic map(
      INIT => X"F202"
      )
    port map (
      O  => lut_out(6),
      I0 => addr_out_i(6),
      I1 => Cnt_by_128,
      I2 => Load_Enable,
      I3 => Load_addr(6)
      );

  I_MUXCY6 : MUXCY
    port map (
      DI => Cnt_by_128,
      CI => Cout(6),
      S  => lut_out(6),
      O  => Cout(7)
      );

  I_XOR6 : XORCY
    port map (
      LI => lut_out(6),
      CI => Cout(6),
      O  => next_addr_i(6)
      );

  I_FDRE6 : FDRE
    port map (
      Q  => addr_out_i(6),
      C  => Clk,
      CE => Clk_En_6,
      D  => next_addr_i(6),
      R  => Rst
      );




-------------------------------------------------------------------------------
---- Address Counter Bit 5


  I_LUT5 : LUT4
    generic map(
      INIT => X"F202"
      )
    port map (
      O  => lut_out(5),
      I0 => addr_out_i(5),
      I1 => Cnt_by_64,
      I2 => Load_Enable,
      I3 => Load_addr(5)
      );

  I_MUXCY5 : MUXCY
    port map (
      DI => Cnt_by_64,
      CI => Cout(5),
      S  => lut_out(5),
      O  => Cout(6)
      );

  I_XOR5 : XORCY
    port map (
      LI => lut_out(5),
      CI => Cout(5),
      O  => next_addr_i(5)
      );

  I_FDRE5: FDRE
    port map (
      Q  => addr_out_i(5),
      C  => Clk,
      CE => Clk_En_5,
      D  => next_addr_i(5),
      R  => Rst
      );




-------------------------------------------------------------------------------
---- Address Counter Bit 4


  I_LUT4 : LUT4
    generic map(
      INIT => X"F202"
      )
    port map (
      O  => lut_out(4),
      I0 => addr_out_i(4),
      I1 => Cnt_by_32,
      I2 => Load_Enable,
      I3 => Load_addr(4)
      );

  I_MUXCY4 : MUXCY
    port map (
      DI => Cnt_by_32,
      CI => Cout(4),
      S  => lut_out(4),
      O  => Cout(5)
      );

  I_XOR4 : XORCY
    port map (
      LI => lut_out(4),
      CI => Cout(4),
      O  => next_addr_i(4)
      );

  I_FDRE4: FDRE
    port map (
      Q  => addr_out_i(4),
      C  => Clk,
      CE => Clk_En_4,
      D  => next_addr_i(4),
      R  => Rst
      );




-------------------------------------------------------------------------------
---- Address Counter Bit 3


  I_LUT3 : LUT4
    generic map(
      INIT => X"F202"
      )
    port map (
      O  => lut_out(3),
      I0 => addr_out_i(3),
      I1 => Cnt_by_16,
      I2 => Load_Enable,
      I3 => Load_addr(3)
      );

  I_MUXCY3 : MUXCY
    port map (
      DI => Cnt_by_16,
      CI => Cout(3),
      S  => lut_out(3),
      O  => Cout(4)
      );

  I_XOR3 : XORCY
    port map (
      LI => lut_out(3),
      CI => Cout(3),
      O  => next_addr_i(3)
      );

  I_FDRE3: FDRE
    port map (
      Q  => addr_out_i(3),
      C  => Clk,
      CE => Clk_En_3,
      D  => next_addr_i(3),
      R  => Rst
      );




-------------------------------------------------------------------------------
---- Address Counter Bit 2


  I_LUT2 : LUT4
    generic map(
      INIT => X"F202"
      )
    port map (
      O  => lut_out(2),
      I0 => addr_out_i(2),
      I1 => Cnt_by_8,
      I2 => Load_Enable,
      I3 => Load_addr(2)
      );

  I_MUXCY2 : MUXCY
    port map (
      DI => Cnt_by_8,
      CI => Cout(2),
      S  => lut_out(2),
      O  => Cout(3)
      );

  I_XOR2 : XORCY
    port map (
      LI => lut_out(2),
      CI => Cout(2),
      O  => next_addr_i(2)
      );

  I_FDRE2: FDRE
    port map (
      Q  => addr_out_i(2),
      C  => Clk,
      CE => Clk_En_2,
      D  => next_addr_i(2),
      R  => Rst
      );




-------------------------------------------------------------------------------
---- Address Counter Bit 1


  I_LUT1 : LUT4
    generic map(
      INIT => X"F202"
      )
    port map (
      O  => lut_out(1),
      I0 => addr_out_i(1),
      I1 => Cnt_by_4,
      I2 => Load_Enable,
      I3 => Load_addr(1)
      );

  I_MUXCY1 : MUXCY
    port map (
      DI => Cnt_by_4,
      CI => Cout(1),
      S  => lut_out(1),
      O  => Cout(2)
      );

  I_XOR1 : XORCY
    port map (
      LI => lut_out(1),
      CI => Cout(1),
      O  => next_addr_i(1)
      );

  I_FDRE1: FDRE
    port map (
      Q  => addr_out_i(1),
      C  => Clk,
      CE => Clk_En_1,
      D  => next_addr_i(1),
      R  => Rst
      );



-------------------------------------------------------------------------------
---- Address Counter Bit 0


  I_LUT0 : LUT4
    generic map(
      INIT => X"F202"
      )
    port map (
      O  => lut_out(0),
      I0 => addr_out_i(0),
      I1 => Cnt_by_2,
      I2 => Load_Enable,
      I3 => Load_addr(0)
      );

  I_MUXCY0 : MUXCY
    port map (
      DI => Cnt_by_2,
      CI => Cout(0),
      S  => lut_out(0),
      O  => Cout(1)
      );

  I_XOR0 : XORCY
    port map (
      LI => lut_out(0),
      CI => Cout(0),
      O  => next_addr_i(0)
      );

  I_FDRE0: FDRE
    port map (
      Q  => addr_out_i(0),
      C  => Clk,
      CE => Clk_En_0,
      D  => next_addr_i(0),
      R  => Rst
      );




-------------------------------------------------------------------------------
---- Carry in selection for LS Bit


  I_MUXCY : MUXCY
    port map (
      DI => Cnt_by_1,
      CI => '0',
      S  => Load_Enable,
      O  => Cout(0)
      );


end implementation;
