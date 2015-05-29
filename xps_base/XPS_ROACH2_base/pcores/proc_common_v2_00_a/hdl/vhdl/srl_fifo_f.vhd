-------------------------------------------------------------------------------
-- $Id: srl_fifo_f.vhd,v 1.3 2007/12/13 00:20:22 ostlerf Exp $
-------------------------------------------------------------------------------
-- srl_fifo_f - entity / architecture pair
-------------------------------------------------------------------------------
--
--                  ****************************
--                  ** Copyright Xilinx, Inc. **
--                  ** All rights reserved.   **
--                  ****************************
--
-------------------------------------------------------------------------------
-- Filename:        srl_fifo_f.vhd
--
-- Description:     A small-to-medium depth FIFO. For
--                  data storage, the SRL elements native to the
--                  target FGPA family are used. If the FIFO depth
--                  exceeds the available depth of the SRL elements,
--                  then SRLs are cascaded and MUXFN elements are
--                  used to select the output of the appropriate SRL stage.
--
--                  Features:
--                      - Width and depth are arbitrary, but each doubling of
--                        depth, starting from the native SRL depth, adds
--                        a level of MUXFN. Generally, in performance-oriented
--                        applications, the fifo depth may need to be limited to
--                        not exceed the SRL cascade depth supported by local
--                        fast interconnect or the number of MUXFN levels.
--                        However, deeper fifos will correctly build.
--                      - Commands: read, write.
--                      - Flags: empty and full.
--                      - The Addr output is always one less than the current
--                        occupancy when the FIFO is non-empty, and is all ones
--                        otherwise. Therefore, the value <FIFO_Empty, Addr>--
--                        i.e. FIFO_Empty concatenated on the left to Addr--
--                        when taken as a signed value, is one less than the
--                        current occupancy.
--
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:   
--              srl_fifo_f.vhd
--                srl_fifo_rbu_f.vhd
--                proc_common_pkg.vhd
--
-------------------------------------------------------------------------------
-- Author:          Farrell Ostler
--
-- History:
--   FLO   12/13/05   First Version.
--
-- FLO            04/27/06
-- ^^^^^^
--   C_FAMILY made to default to "nofamily".
-- ~~~~~~
--  FLO         2007-12-12
-- ^^^^^^
--  Using function clog2 now instead of log2 to eliminate superfluous warnings.
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
--      predecessor value by # clks:            "*_p#"


library ieee;
use     ieee.std_logic_1164.all;
library proc_common_v2_00_a;
use     proc_common_v2_00_a.proc_common_pkg.clog2;
--
entity srl_fifo_f is
  generic (
    C_DWIDTH : natural;
    C_DEPTH  : positive := 16;
    C_FAMILY : string := "nofamily"
    );
  port (
    Clk           : in  std_logic;
    Reset         : in  std_logic;
    FIFO_Write    : in  std_logic;
    Data_In       : in  std_logic_vector(0 to C_DWIDTH-1);
    FIFO_Read     : in  std_logic;
    Data_Out      : out std_logic_vector(0 to C_DWIDTH-1);
    FIFO_Empty    : out std_logic;
    FIFO_Full     : out std_logic;
    Addr          : out std_logic_vector(0 to clog2(C_DEPTH)-1)
    );

end entity srl_fifo_f;


library proc_common_v2_00_a;
use     proc_common_v2_00_a.proc_common_pkg.clog2;
--
architecture imp of srl_fifo_f is
    constant ZEROES : std_logic_vector(0 to clog2(C_DEPTH)-1) := (others => '0');
begin

    I_SRL_FIFO_RBU_F : entity proc_common_v2_00_a.srl_fifo_rbu_f
    generic map (
                 C_DWIDTH => C_DWIDTH,
                 C_DEPTH  => C_DEPTH,
                 C_FAMILY => C_FAMILY
    )
    port map (
                 Clk           => Clk,
                 Reset         => Reset,
                 FIFO_Write    => FIFO_Write,
                 Data_In       => Data_In,
                 FIFO_Read     => FIFO_Read,
                 Data_Out      => Data_Out,
                 FIFO_Full     => FIFO_Full,
                 FIFO_Empty    => FIFO_Empty,
                 Addr          => Addr,
                 Num_To_Reread => ZEROES,
                 Underflow     => open,
                 Overflow      => open
    );

end architecture imp;
