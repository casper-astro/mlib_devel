-------------------------------------------------------------------------------
-- $Id: brst_addr_cntr.vhd,v 1.1.2.1 2009/10/06 21:15:00 gburch Exp $
-------------------------------------------------------------------------------
-- brst_addr_cntr.vhd - vhdl design file for the entity and architecture
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
-- Filename:        brst_addr_cntr.vhd
--
-- Description:     This counter provides the addresses and byte enables during
--                  burst operations. It advances based on IP2Bus_addrAck.
-------------------------------------------------------------------------------
-- Structure:
--
--
--              brst_addr_cntr.vhd
--
-------------------------------------------------------------------------------
-- Author:      D. Thorpe
-- History:
--
--      ALS       11/21/03
-- ~~~~~~
--      Adapted from addr_reg_cntr_brst.vhd
-- ^^^^^^
--      ALS       12/24/03
-- ^^^^^^
--      Removed BE generation from this file
-- ~~~~~~~
--      GAB       04/14/04
-- ^^^^^^
--      Updated to proc_common_v2_00_a
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

-------------------------------------------------------------------------------
-- Port Declaration
-------------------------------------------------------------------------------
entity brst_addr_cntr is
  generic (
           C_CNTR_WIDTH         : integer := 32;
           C_OPB_AWIDTH         : integer := 32;
           C_OPB_DWIDTH         : integer := 32
          );
    port (
       -- Inputs
         Address_in         : in  std_logic_vector(0 to C_OPB_AWIDTH-1);

         Addr_load          : in  std_logic;
         Addr_CntEn         : in  std_logic;

         Byte_xfer          : in  std_logic;
         Hw_xfer            : in  std_logic;
         Fw_xfer            : in  std_logic;

       -- Address Outputs
         Address_Out        : out std_logic_vector(0 to C_OPB_AWIDTH-1);

         OPB_Clk            : in std_logic
         );

end brst_addr_cntr;

library opb_v20_v1_10_d;
use opb_v20_v1_10_d.proc_common_pkg.all;
use opb_v20_v1_10_d.direct_path_cntr_ai;

library unisim;
use unisim.vcomponents.all;

-------------------------------------------------------------------------------
-- Begin Architecture
-------------------------------------------------------------------------------
architecture implementation of brst_addr_cntr is

-------------------------------------------------------------------------------
-- Function Declarations
-------------------------------------------------------------------------------
-- Function set_cntr_width sets the counter width to generic C_CNTR_WIDTH if
-- it is >= 3, otherwise, the counter width is set to 3. This is due to the
-- fact that for OPB addresses, the counter must at least be of width 3 in order
-- to count byte, half-word, and word addresses
function set_cntr_width ( input_cntr_width  : integer)
                         return integer is
begin
    if input_cntr_width >= 3 then
        return input_cntr_width;
    else
        return 3;
    end if;
end function set_cntr_width;

-------------------------------------------------------------------------------
-- Constant Declarations
-------------------------------------------------------------------------------
  constant CNTR_WIDTH       : integer := set_cntr_width(C_CNTR_WIDTH);
-------------------------------------------------------------------------------
-- Signal Declarations
-------------------------------------------------------------------------------

  signal address_out_i      : std_logic_vector(0 to C_OPB_AWIDTH-1);

  signal xfer_size          : std_logic_vector(0 to CNTR_WIDTH-1);

  signal addr_load_n        : std_logic;
  signal address_cnt        : std_logic_vector(0 to CNTR_WIDTH-1);

-------------------------------------------------------------------------------
begin



    -- Output assignments
    Address_out   <=  address_out_i;

-----------------------------------------------------------------------
    -- Determine the transfer size

    ZERO_XFER_SIZE_GEN: if CNTR_WIDTH > 3 generate
        xfer_size(0 to CNTR_WIDTH-4) <= (others => '0');
    end generate ZERO_XFER_SIZE_GEN;

    xfer_size(CNTR_WIDTH-3 to CNTR_WIDTH-1) <= Fw_xfer & Hw_xfer & Byte_xfer;

-------------------------------------------------------------------------------
-- Address Counter
--
-- Use the direct path counter so a clock delay is not incurred when the address
-- is loaded. Based on the xfer size, increment the counter by 1 ,2 , or 4
-------------------------------------------------------------------------------
addr_load_n <= not(Addr_load);

DIRECT_PATH_CNTR_I: entity opb_v20_v1_10_d.direct_path_cntr_ai
    generic map (C_WIDTH    => CNTR_WIDTH)
    port map (
                Clk        =>  OPB_Clk,
                Din        =>  Address_in(C_OPB_AWIDTH-CNTR_WIDTH to C_OPB_AWIDTH-1),
                Dout       =>  address_cnt,
                Load_n     =>  addr_load_n,
                Cnt_en     =>  Addr_CntEn,
                Delta      =>  xfer_size
             );

address_out_i <= address_in(0 to C_OPB_AWIDTH-CNTR_WIDTH-1) & address_cnt;

end implementation;





