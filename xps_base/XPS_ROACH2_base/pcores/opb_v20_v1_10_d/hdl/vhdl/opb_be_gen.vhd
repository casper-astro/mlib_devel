-------------------------------------------------------------------------------
-- $Id: opb_be_gen.vhd,v 1.1.2.1 2009/10/06 21:15:01 gburch Exp $
-------------------------------------------------------------------------------
-- opb_be_gen.vhd - vhdl design file for the entity and architecture
--                            of the Mauna Loa IPIF Bus to IPIF Bus Address
--                            multiplexer.
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
-- Filename:        opb_be_gen.vhd
--
-- Description:     This counter provides the byte enables during
--                  burst operations. It advances based on IP2Bus_addrAck.
-------------------------------------------------------------------------------
-- Structure:
--
--
--              opb_be_gen.vhd
--
-------------------------------------------------------------------------------
-- Author:      ALS
-- History:
--
--      ALS       12/24/03
-- ^^^^^^
--      Adapted from brst_addr_be_cntr.vhd
-- ~~~~~~~
--      GAB       04/14/04
-- ^^^^^^
--      Updated to proc_common_v2_00_a
-- ~~~~~~~
--      ALS      04/27/04
-- ^^^^^^
--      Fixed equations for byte_xfer_i, hw_xfer_i, and fw_xfer_i to equal the
--      bus decodes when Load_BE=1 and the sample and hold bus decodes when
--      Load_BE=0
-- ~~~~~~~
--  GAB         10/05/09
-- ^^^^^^
--  Moved all helper libraries proc_common_v2_00_a, opb_ipif_v3_01_a, and
--  opb_arbiter_v1_02_e locally into opb_v20_v1_10_d
--
--  Updated legal header
-- ~~~~~~
---------------------------------------------------------------------------------
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
--
-- Library definitions

library ieee;
use ieee.std_logic_1164.all;

library opb_v20_v1_10_d;
use opb_v20_v1_10_d.proc_common_pkg.log2;
-------------------------------------------------------------------------------
-- Port Declaration
-------------------------------------------------------------------------------
entity opb_be_gen is
  generic (
           C_OPB_AWIDTH         : integer := 32;
           C_OPB_DWIDTH         : integer := 32;
           C_INCLUDE_WR_BUF     : integer := 1
          );
    port (
       -- Inputs
         Bus_clk            : in  std_logic;

         Address_in         : in  std_logic_vector(0 to C_OPB_AWIDTH-1);
         BE_in              : in  std_logic_vector(0 to (C_OPB_DWIDTH/8)-1);

         Load_BE            : in  std_logic;
         Rst_BE             : in  std_logic;

       -- BE Outputs
         BE_out             : out std_logic_vector(0 to (C_OPB_DWIDTH/8)-1);

       -- Xfer size outputs
         Byte_xfer          : out std_logic;
         Hw_xfer            : out std_logic;
         Fw_xfer            : out std_logic

         );

end opb_be_gen;


library unisim;
use unisim.vcomponents.all;

-------------------------------------------------------------------------------
-- Begin Architecture
-------------------------------------------------------------------------------
architecture implementation of opb_be_gen is

-------------------------------------------------------------------------------
-- Signal Declarations
-------------------------------------------------------------------------------

  signal be_out_i           : std_logic_vector(0 to (C_OPB_DWIDTH/8)-1);

  signal byte_xfer_d        : std_logic;
  signal hw_xfer_d          : std_logic;
  signal fw_xfer_d          : std_logic;

  signal byte_xfer_i        : std_logic;
  signal hw_xfer_i          : std_logic;
  signal fw_xfer_i          : std_logic;

  signal s_h_byte_xfer      : std_logic;
  signal s_h_hw_xfer        : std_logic;
  signal s_h_fw_xfer        : std_logic;

  signal s_h_reset          : std_logic;

  signal addr_in            : std_logic_vector(30 to 31);
  signal be0_lutsel         : std_logic;
  signal be1_lutsel         : std_logic;
  signal be2_lutsel         : std_logic;
  signal be3_lutsel         : std_logic;

-------------------------------------------------------------------------------
begin



    -- Output assignments
    BE_out      <= be_out_i;

-----------------------------------------------------------------------
    -- Determine the transfer size
    -- NOTE: this logic is specific to a 32-bit wide OPB bus and has not
    -- been written for the generalized case
    -- (1-lut per signal)

    byte_xfer_d <= '1'
                when BE_in = "0001" or
                     BE_in = "0010" or
                     BE_in = "0100" or
                     BE_in = "1000"
                else '0';

    hw_xfer_d <= '1'
                when BE_in = "0011" or
                     BE_in = "1100"
                else '0';

    fw_xfer_d <= '1'
                when BE_in = "1111"
                else '0';

-------------------------------------------------------------------------------
    -- When write buffer is included in design, need to sample and hold the
    -- xfer size until the write buffer has emptied. This will keep the correct byte
    -- enabled asserted until write transaction has completed

    s_h_reset <= Rst_BE and not(Load_BE);

    XFER_ADDR_REG_GEN: if C_INCLUDE_WR_BUF = 1 generate
            BYTE_XFER_REG : FDRE
                port map(
                  Q  =>  s_h_byte_xfer,
                  C  =>  Bus_clk,
                  CE =>  Load_BE,
                  D  =>  byte_xfer_d,
                  R  =>  s_h_reset
                );
            HW_XFER_REG : FDRE
                port map(
                  Q  =>  s_h_hw_xfer,
                  C  =>  Bus_clk,
                  CE =>  Load_BE,
                  D  =>  hw_xfer_d,
                  R  =>  s_h_reset
                );
            FW_XFER_REG : FDRE
                port map(
                  Q  =>  s_h_fw_xfer,
                  C  =>  Bus_clk,
                  CE =>  Load_BE,
                  D  =>  fw_xfer_d,
                  R  =>  s_h_reset
                );

            -- extend the xfer size indicators
            byte_xfer_i <= (byte_xfer_d and Load_BE) or (s_h_byte_xfer and not(Load_BE));
            hw_xfer_i   <= (hw_xfer_d and Load_BE) or (s_h_hw_xfer and not(Load_BE));
            fw_xfer_i   <= (fw_xfer_d and Load_BE) or (s_h_fw_xfer and not (Load_BE));


            Byte_xfer  <= s_h_byte_xfer;
            Hw_xfer    <= s_h_hw_xfer;
            Fw_xfer    <= s_h_fw_xfer;

    end generate XFER_ADDR_REG_GEN;

    NOXFERADDR_REG_GEN: if C_INCLUDE_WR_BUF = 0 generate
        byte_xfer_i  <= byte_xfer_d;
        hw_xfer_i    <= hw_xfer_d;
        fw_xfer_i    <= fw_xfer_d;

        Byte_xfer   <= byte_xfer_i;
        Hw_xfer     <= hw_xfer_i;
        Fw_xfer     <= fw_xfer_i;
    end generate NOXFERADDR_REG_GEN;


 ------------------------------------------------------------------------------
 -- Determine BE based on the xfer size and the LSBs of the current address
 -- BE_OUT will be "0000" if illegal input BE combinations

addr_in(30 to 31)   <= Address_in(30 to 31);

-- generate BE0 using luts and muxcy
-- equivalent logic:
--      BE0 <= '1' when
--               ( byte_xfer = '1' and addr_in(30 to 31) = "00" ) or
--               ( hw_xfer = '1' and addr_in(30 to 31) =  "00") or
--               ( fw_xfer = '1')
--               else '0';
   be0_lutsel <= '0' when
                    ( byte_xfer_i = '1' and addr_in(30 to 31) = "00" ) or
                    ( hw_xfer_i = '1' and addr_in(30 to 31) =  "00")
                 else '1';

   BE0_MUXCY_I : MUXCY
     port map (
       O    => be_out_i(0),
       CI   => fw_xfer_i,
       DI   => '1',
       S    =>  be0_lutsel
     );

-- generate BE1 using luts and muxcy
-- equivalent logic:
--      BE1 <= '1' when
--               ( byte_xfer_i = '1' and addr_in(30 to 31) = "01" ) or
--               ( hw_xfer_i = '1' and addr_in(30 to 31) =  "00") or
--               ( fw_xfer_i = '1')
--               else '0';

   be1_lutsel <= '0' when
                    ( byte_xfer_i = '1' and addr_in(30 to 31) = "01" ) or
                    ( hw_xfer_i = '1' and addr_in(30 to 31) =  "00")
                 else '1';

   BE1_MUXCY_I : MUXCY
     port map (
       O    => be_out_i(1),
       CI   => fw_xfer_i,
       DI   => '1',
       S    =>  be1_lutsel
     );

-- generate BE2 using luts and muxcy
-- equivalent logic:
--      BE2 <= '1' when
--               ( byte_xfer_i = '1' and addr_in(30 to 31) = "10" ) or
--               ( hw_xfer_i = '1' and addr_in(30 to 31) =  "10") or
--               ( fw_xfer_i = '1')
--               else '0';

   be2_lutsel <= '0' when
                    ( byte_xfer_i = '1' and addr_in(30 to 31) = "10" ) or
                    ( hw_xfer_i = '1' and addr_in(30 to 31) =  "10")
                 else '1';

   BE2_MUXCY_I : MUXCY
     port map (
       O    => be_out_i(2),
       CI   => fw_xfer_i,
       DI   => '1',
       S    =>  be2_lutsel
     );

-- generate BE3 using luts and muxcy
-- equivalent logic:
--      BE3 <= '1' when
--               ( byte_xfer_i = '1' and addr_in(30 to 31) = "11" ) or
--               ( hw_xfer_i = '1' and addr_in(30 to 31) =  "10") or
--               ( fw_xfer_i = '1')
--               else '0';

   be3_lutsel <= '0' when
                    ( byte_xfer_i = '1' and addr_in(30 to 31) = "11" ) or
                    ( hw_xfer_i = '1' and addr_in(30 to 31) =  "10")
                 else '1';

   BE3_MUXCY_I : MUXCY
     port map (
       O    => be_out_i(3),
       CI   => fw_xfer_i,
       DI   => '1',
       S    =>  be3_lutsel
     );

end implementation;





