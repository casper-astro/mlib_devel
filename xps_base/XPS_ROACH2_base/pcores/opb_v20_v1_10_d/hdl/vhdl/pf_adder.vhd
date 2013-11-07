-------------------------------------------------------------------------------
-- $Id: pf_adder.vhd,v 1.1.2.1 2009/10/06 21:15:01 gburch Exp $
-------------------------------------------------------------------------------
-- pf_adder - entity/architecture pair
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
-- Filename:        pf_adder.vhd
--
-- Description:     Parameterized adder/subtractor for Mauna Loa Packet FIFO
--                  vacancy calculation. This design has a combinational
--                  output. The carry out is not used by the PFIFO so it has
--                  been removed.
--
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:
--                  pf_adder.vhd
--
-------------------------------------------------------------------------------
-- Author:          D. Thorpe
-- Revision:        $Revision: 1.1.2.1 $
-- Date:            $Date: 2009/10/06 21:15:01 $
--
-- History:
--   DET            2001-08-30    First Version
--                  - adapted from B Tise MicroBlaze timer counters
--
--  DET             2001-09-11
--                  - Added the Rst input to the pf_adder_bit component
--
--
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

library unisim;
use unisim.all;

library opb_v20_v1_10_d;
use opb_v20_v1_10_d.all;

-----------------------------------------------------------------------------
-- Entity section
-----------------------------------------------------------------------------

entity pf_adder is
  generic (
    C_REGISTERED_RESULT : Boolean := false;
    C_COUNT_WIDTH       : integer := 10
    );
  port (
    Clk           : in  std_logic;
    Rst           : in  std_logic;
    --Carry_Out     : out std_logic;
    Ain           : in  std_logic_vector(0 to C_COUNT_WIDTH-1);
    Bin           : in  std_logic_vector(0 to C_COUNT_WIDTH-1);
    Add_sub_n     : in  std_logic;
    result_out    : out std_logic_vector(0 to C_COUNT_WIDTH-1)
    );
end entity pf_adder;

-----------------------------------------------------------------------------
-- Architecture section
-----------------------------------------------------------------------------

architecture implementation of pf_adder is


  constant CY_START : integer := 1;


  signal alu_cy            : std_logic_vector(0 to C_COUNT_WIDTH);
  signal iresult_out       : std_logic_vector(0 to C_COUNT_WIDTH-1);
  signal count_clock_en    : std_logic;
  --signal carry_active_high : std_logic;



begin  -- VHDL_RTL

  -----------------------------------------------------------------------------
  -- Generate the Counter bits
  -----------------------------------------------------------------------------

  alu_cy(C_COUNT_WIDTH) <= not(Add_sub_n); -- initial carry-in to adder LSB


  count_clock_en <= '1';


  I_ADDSUB_GEN : for i in 0 to C_COUNT_WIDTH-1 generate
  begin
    Counter_Bit_I : entity opb_v20_v1_10_d.pf_adder_bit
      Generic map(
        C_REGISTERED_RESULT => C_REGISTERED_RESULT
      )
      port map (
        Clk           => Clk,                       -- [in]
        Rst           => Rst,                       -- [in]
        Ain           => Ain(i),                    -- [in]
        Bin           => Bin(i),                    -- [in]
        Add_sub_n     => Add_sub_n,                 -- [in]
        Carry_In      => alu_cy(i+CY_Start),        -- [in]
        Clock_Enable  => count_clock_en,            -- [in]
        Result        => iresult_out(i),            -- [out]
        Carry_Out     => alu_cy(i+(1-CY_Start)));   -- [out]
  end generate I_ADDSUB_GEN;





  result_out <= iresult_out;



end architecture implementation;

