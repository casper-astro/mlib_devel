-------------------------------------------------------------------------------
-- $Id: brst_addr_cntr_reg.vhd,v 1.1.2.1 2009/10/06 21:15:00 gburch Exp $
-------------------------------------------------------------------------------
-- brst_addr_cntr_reg.vhd - vhdl design file for the entity and architecture
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
-- Filename:        brst_addr_cntr_reg.vhd
--
-- Description:     This vhdl design file is for the entity and architecture
--                  of the Mauna Loa IPIF Bus to IPIF Bus Address Bus Output
--                  multiplexer.
--
-------------------------------------------------------------------------------
-- Structure:
--
--
--              brst_addr_cntr_reg.vhd
--
-------------------------------------------------------------------------------
-- Author:      D. Thorpe
-- History:
--
--      ALS        12/24/03
-- ^^^^^^
--      Adapted from burst_addr_be_cntr_reg - removed BE generation
-- ~~~~~~~
--  GAB         10/05/09
-- ^^^^^^
--  Moved all helper libraries proc_common_v2_00_a, opb_ipif_v3_01_a, and
--  opb_arbiter_v1_02_e locally into opb_v20_v1_10_d
--
--  Updated legal header
-- ~~~~~~
--
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
use ieee.std_logic_arith.all; -- need the unsigned functions

library opb_v20_v1_10_d;
use opb_v20_v1_10_d.opb_flex_addr_cntr;

library unisim;
Use unisim.vcomponents.all;

-------------------------------------------------------------------------------
-- Port Declaration
-------------------------------------------------------------------------------
entity brst_addr_cntr_reg is
  generic (
           C_CNTR_WIDTH         : integer := 32;
           C_OPB_AWIDTH         : integer := 32;
           C_OPB_DWIDTH         : integer := 32
          );
    port (
       -- Clock and Reset
         Bus_reset          : in  std_logic;
         Bus_clk            : in  std_logic;


       -- Inputs
        -- Burst              : in  std_logic;
         Xfer_done          : in  std_logic;
         RNW                : in  std_logic;
         Addr_Load          : in  std_logic;
         Addr_Cnt_en        : in  std_logic;
         Addr_Cnt_Rst       : in  std_logic;
         Address_In         : in  std_logic_vector(0 to C_OPB_AWIDTH-1);

         Byte_xfer          : in  std_logic;
         Hw_xfer            : in  std_logic;
         Fw_xfer            : in  std_logic;


       -- IPIF & IP address bus source (AMUX output)
         Next_address_out   : out std_logic_vector(0 to C_OPB_AWIDTH-1);
         Address_Out        : out std_logic_vector(0 to C_OPB_AWIDTH-1)

         );
end brst_addr_cntr_reg;




architecture implementation of brst_addr_cntr_reg is



--INTERNAL SIGNALS
  signal  address_cnt       : std_logic_vector(0 to C_CNTR_WIDTH-1);
  signal  next_address_cnt  : std_logic_vector(0 to C_CNTR_WIDTH-1);
  signal  cken0             : std_logic;
  signal  cntx1             : std_logic;
  signal  cntx2             : std_logic;
  signal  cntx4             : std_logic;


  signal  clr_addr          : std_logic;

--------------------------------------------------------------------------------------------------------------
-------------------------------------- start of logic -------------------------------------------------

begin

------------------------------------------------------------------------------
-- For an address counter of width less than C_OPB_AWIDTH, address_out and
-- next_address_out are a concatination of an upper address portion and the
-- address counter's output
------------------------------------------------------------------------------
GEN_LESS_THAN_OPB_AWIDTH : if C_CNTR_WIDTH < C_OPB_AWIDTH generate
signal  s_h_upper_addr    : std_logic_vector(0 to C_OPB_AWIDTH-C_CNTR_WIDTH-1);
begin
    -- Output assignments
    Address_out         <= s_h_upper_addr(0 to C_OPB_AWIDTH-C_CNTR_WIDTH-1) & address_cnt;
    Next_address_out    <= s_h_upper_addr(0 to C_OPB_AWIDTH-C_CNTR_WIDTH-1) & next_address_cnt
                            when cken0 = '1'
                            else
                            s_h_upper_addr(0 to C_OPB_AWIDTH-C_CNTR_WIDTH-1) & address_cnt;

    clr_addr         <=  Addr_Cnt_Rst and not(Addr_load);



   -- Sample and Hold registers

      UPPER_ADDR_REG_GEN: for i in 0 to C_OPB_AWIDTH-C_CNTR_WIDTH-1 generate
        UPPER_ADDR_REG: FDRE
            port map(
              Q  =>  s_h_upper_addr(i),
              C  =>  Bus_clk,
              CE =>  Addr_Load,
              D  =>  Address_in(i),
              R  =>  clr_addr
            );
      end generate UPPER_ADDR_REG_GEN;


   -- Set the "count by' controls
    cntx1         <=  byte_xfer and not(Addr_Load);

    cntx2         <=  hw_xfer and not(Addr_Load);

    cntx4         <=  fw_xfer and not(Addr_Load);


    cken0         <=  Addr_Load or ((Addr_Cnt_en and not(RNW)) or
                                    (Addr_cnt_en and RNW and not(Xfer_done)));

end generate;

------------------------------------------------------------------------------
-- For an address counter width equal to C_OPB_AWIDTH, address_out and
-- next_address_out are simply the address counter's output
------------------------------------------------------------------------------
GEN_EQUAL_TO_OPB_AWIDTH : if C_CNTR_WIDTH = C_OPB_AWIDTH generate
begin
    -- Output assignments
    Address_out         <= address_cnt;
    Next_address_out    <= next_address_cnt
                            when cken0 = '1'
                            else
                           address_cnt;

    clr_addr         <=  Addr_Cnt_Rst and not(Addr_load);


   -- Set the "count by' controls
    cntx1         <=  byte_xfer and not(Addr_Load);

    cntx2         <=  hw_xfer and not(Addr_Load);

    cntx4         <=  fw_xfer and not(Addr_Load);


    cken0         <=  Addr_Load or ((Addr_Cnt_en and not(RNW)) or
                                    (Addr_cnt_en and RNW and not(Xfer_done)));

end generate GEN_EQUAL_TO_OPB_AWIDTH;




  I_FLEX_ADDR_CNTR : entity opb_v20_v1_10_d.opb_flex_addr_cntr
    Generic map(
       C_AWIDTH      => C_CNTR_WIDTH
       )

    port map(
      Clk            =>  Bus_clk,  -- : in  std_logic;
      Rst            =>  clr_addr,
      Load_Enable    =>  Addr_Load,  -- : in  std_logic;
      Load_addr      =>  Address_In(C_OPB_AWIDTH-C_CNTR_WIDTH to C_OPB_AWIDTH-1),  -- : in  std_logic_vector(C_AWIDTH-1 downto 0);
      Cnt_by_1       =>  cntx1,  -- : in  std_logic;
      Cnt_by_2       =>  cntx2,  -- : in  std_logic;
      Cnt_by_4       =>  cntx4,  -- : in  std_logic;
      Cnt_by_8       =>  '0',  -- : in  std_logic;
      Cnt_by_16      =>  '0',  -- : in  std_logic;
      Cnt_by_32      =>  '0',  -- : in  std_logic;
      Cnt_by_64      =>  '0',  -- : in  std_logic;
      Cnt_by_128     =>  '0',  -- : in  std_logic;
      Clk_En_0       =>  cken0,  -- : in  std_logic;
      Clk_En_1       =>  cken0,  -- : in  std_logic;
      Clk_En_2       =>  cken0,  -- : in  std_logic;
      Clk_En_3       =>  cken0,  -- : in  std_logic;
      Clk_En_4       =>  cken0,  -- : in  std_logic;
      Clk_En_5       =>  cken0,  -- : in  std_logic;
      Clk_En_6       =>  cken0,  -- : in  std_logic;
      Clk_En_7       =>  cken0,  -- : in  std_logic;
      Addr_out       =>  address_cnt,  -- : out std_logic_vector(C_AWIDTH-1 downto 0);
      Next_addr_out  =>  next_address_cnt,
      Carry_Out      =>  open    -- : out std_logic;
     );



end implementation;





