-------------------------------------------------------------------------------
-- $Id: pf_dly1_mux.vhd,v 1.1.2.1 2009/10/06 21:15:01 gburch Exp $
-------------------------------------------------------------------------------
-- pf_dly1_mux.vhd - entity/architecture pair
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
-- Filename:        pf_dly1_mux.vhd
--
-- Description:     Implements a multiplexer and register combo that allows
--                  selection of a registered or non-registered version of
--                  the input signal for output.
--
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:
--                  pf_dly1_mux.vhd
--
-------------------------------------------------------------------------------
-- Author:          B.L. Tise
-- Revision:        $Revision: 1.1.2.1 $
-- Date:            $Date: 2009/10/06 21:15:01 $
--
-- History:
--   D. Thorpe      2001-08-30    First Version
--                  - adapted from B Tise MicroBlaze counters
--
--   DET            2001-09-11
--                  - Added the Rst input signal and connected it to the FDRE
--                    reset input.
--
--
--     DET     4/2/2004     IPIF to v2_02_a
-- ~~~~~~
--     - Updated proc common library reference to v2_00_a
-- ^^^^^^
--
--
--     DET     4/12/2004     IPIF to V1_00_f
-- ~~~~~~
--     - Updated unisim library reference to unisim.vcomponents.all.
--     - Commented out Xilinx primitive component declarations
-- ^^^^^^
--  GAB         10/05/09
-- ^^^^^^
--  Moved all helper libraries proc_common_v2_00_a, opb_ipif_v3_01_a, and
--  opb_arbiter_v1_02_e locally into opb_v20_v1_10_d
--
--  Updated legal header
-- ~~~~~~
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
-----------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

library opb_v20_v1_10_d;
Use opb_v20_v1_10_d.inferred_lut4;

-- Xilinx primitive library
library unisim;
use unisim.vcomponents.all;


-----------------------------------------------------------------------------
-- Entity section
-----------------------------------------------------------------------------

entity pf_dly1_mux is
  Generic (C_MUX_WIDTH : Integer := 12
       );
  port (
    Clk           : in  std_logic;
    Rst           : In  std_logic;
    dly_sel1      : in  std_logic;
    dly_sel2      : in  std_logic;
    Inputs        : in  std_logic_vector(0 to C_MUX_WIDTH-1);
    Y_out         : out std_logic_vector(0 to C_MUX_WIDTH-1)
    );

end pf_dly1_mux;

-----------------------------------------------------------------------------
-- Architecture section
-----------------------------------------------------------------------------

architecture implementation of pf_dly1_mux is




  signal    lut_out  : std_logic_vector(0 to C_MUX_WIDTH-1);
  signal    reg_out  : std_logic_vector(0 to C_MUX_WIDTH-1);
  signal    count_Result_Reg : std_logic;

  attribute INIT       : string;

begin  -- VHDL_RTL



   MAKE_DLY_MUX : for i in 0 to C_MUX_WIDTH-1 generate



        --- xst wrk around  I_SEL_LUT : LUT4
        --- xst wrk around    generic map(
        --- xst wrk around    -- synthesis translate_off
        --- xst wrk around      Xon  => false,
        --- xst wrk around    -- synthesis translate_on
        --- xst wrk around      INIT => X"FE10"
        --- xst wrk around      )
        --- xst wrk around    port map (
        --- xst wrk around      O  => lut_out(i),
        --- xst wrk around      I0 => dly_sel1,
        --- xst wrk around      I1 => dly_sel2,
        --- xst wrk around      I2 => Inputs(i),
        --- xst wrk around      I3 => reg_out(i)
        --- xst wrk around     );




        I_SEL_LUT : entity opb_v20_v1_10_d.inferred_lut4
          generic map(
            INIT => X"FE10"
            )
          port map (
            O  => lut_out(i),
            I0 => dly_sel1,
            I1 => dly_sel2,
            I2 => Inputs(i),
            I3 => reg_out(i)
           );



        FDRE_I: FDRE
          port map (
            Q  =>  reg_out(i),
            C  =>  Clk,
            CE =>  '1',
            D  =>  Inputs(i),
            R  =>  Rst
          );

   End generate MAKE_DLY_MUX;


   Y_out <= lut_out;



end implementation;


