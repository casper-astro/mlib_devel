-------------------------------------------------------------------------------
-- $Id: dma_sg_pkg.vhd,v 1.2 2003/02/26 00:12:08 ostlerf Exp $
-------------------------------------------------------------------------------
-- dma_sg_pkg.vhd - package
-------------------------------------------------------------------------------
--
--                  ****************************
--                  ** Copyright Xilinx, Inc. **
--                  ** All rights reserved.   **
--                  ****************************
--
-------------------------------------------------------------------------------
-- Filename:        dma_sg_pkg.vhd
--
-- Description:     This package contains types, constants and functions that
--                  support the DMA/Scatter Gather IP block (entity dma_sg).
--
-------------------------------------------------------------------------------
-- Structure:       No dependencies.
-------------------------------------------------------------------------------
-- Author:          Farrell Ostler
-- History:
--  FLO      04/24/01      -- First version
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
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


package dma_sg_pkg is


--ToDo, remove these two types
    type NATURAL_VECTOR is array (natural range <>) of natural;
    type BOOLEAN_VECTOR is array (natural range <>) of boolean;

    constant UPCB : natural := 10;  -- The number of bits implemented in UPC.
    constant PWBB : natural := 10;  -- The number of bits implemented in PWB.

    -- Word offsets of registers from the channel register base addr.
    constant r_RSTMIR  : natural := 0;
    constant r_DMACR   : natural := 1;
    constant r_SA      : natural := 2;
    constant r_DA      : natural := 3;
    constant r_LENGTH  : natural := 4;
    constant r_DMASR   : natural := 5;
    constant r_BDA     : natural := 6;
    constant r_SWCR    : natural := 7;
    constant r_UPC     : natural := 8;
    constant r_PCT     : natural := 9;
    constant r_PWB     : natural :=10;
    constant r_ISR     : natural :=11;
    constant r_IER     : natural :=12;
    constant r_PLENGTH : natural :=15;

    -- Word offsets of fields in the Buffer Descriptor.
    constant bd_SR     : natural := 0;
    constant bd_DMACR  : natural := 1;
    constant bd_SA     : natural := 2;
    constant bd_DA     : natural := 3;
    constant bd_LENGTH : natural := 4;
    constant bd_DMASR  : natural := 5;
    constant bd_BDA    : natural := 6;

    -- Bit numbers.
    constant b_BSY    : natural := 0;
    constant b_SINC   : natural := 0;
    constant b_DINC   : natural := 1;
    constant b_SLOCAL : natural := 2;
    constant b_DLOCAL : natural := 3;
    constant b_SGS    : natural := 4;
    constant b_L_dmacr: natural := 6;
    constant b_L_dmasr: natural := 3;
    constant b_SGE    : natural := 0;
    constant b_DD     : natural :=31;
    constant b_DE     : natural :=30;
    constant b_PD     : natural :=29;
    constant b_PCTR   : natural :=28;
    constant b_PWBR   : natural :=27;
    constant b_SGDA   : natural :=26;
    constant b_SGEND  : natural :=25;


    -- Conversion of a boolean scalar to a std_logic scalar.
    function bo2sl(b: boolean) return std_logic;

    -- Returns the base 2 logarithm of n, rounded up, if non-integral,
    -- to the next integer.
    function ceil_log2(n : natural) return natural;

    -- Returns the the value, i, for which (2**i)*base_period
    -- is closest to target_period.
    function Div_Stages(base_period, target_period: natural) return natural;

end;


package body dma_sg_pkg is


    type     bo2sl_type is array (boolean) of std_logic;
    constant bo2sl_table : bo2sl_type := ('0', '1');
    function bo2sl(b: boolean) return std_logic is
    begin
      return bo2sl_table(b);
    end bo2sl;

    function ceil_log2(n : natural) return natural is
        variable m : natural := 0;
        variable nn : natural := n;
        variable some_non_even : boolean := false;
    begin
        while nn /= 1 loop
            m := m+1;
            some_non_even := some_non_even or (nn rem 2)/=0;
            nn := nn / 2;
        end loop;
        if some_non_even then m := m+1; end if;
        return m;
    end ceil_log2;

    function Div_Stages(base_period, target_period: natural) return natural is
        variable i: natural;
        variable t: natural;
    begin
        assert base_period <= target_period
          report "Div_Stages: base_period is not <= target_period, as required."
          severity failure;
        i := 0; t := base_period;
        while t <= target_period loop
            i := i + 1;
            t := 2*t;    -- t = (2**i)*base_period
        end loop;
        -- Pick either i or i-1 as the number of stages to give a power-or-2
        -- division of 1/base_period that gives the value closest to
        -- 1/target_period.
        if t - target_period < target_period - t/2 then
            return i;
        else
            return i-1;
        end if;
    end Div_Stages;

end;
