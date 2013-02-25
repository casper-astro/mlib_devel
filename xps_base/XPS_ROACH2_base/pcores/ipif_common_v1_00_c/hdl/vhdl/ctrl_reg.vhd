-------------------------------------------------------------------------------
-- $Id: ctrl_reg.vhd,v 1.1 2003/02/18 19:16:00 ostlerf Exp $
-------------------------------------------------------------------------------
-- A generic control register for use with the dma_sg block.
-------------------------------------------------------------------------------
--
--                  ****************************
--                  ** Copyright Xilinx, Inc. **
--                  ** All rights reserved.   **
--                  ****************************
--
-------------------------------------------------------------------------------
-- Filename:        ctrl_reg.vhd
--
-- Description:     Control register with parameterizable width and two
--                  write enables.
--
-------------------------------------------------------------------------------
-- Structure: 
--              ctrl_reg.vhds
--
-------------------------------------------------------------------------------
-- Author:      Farrell Ostler
-- History:
--      FLO     12/19/01        -- Header added
--
--                              -- Two point solution registers are declared
--                              -- for this version as XST E.33 does not handle
--                              -- the parameterized width.
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

entity ctrl_reg is
    generic(
        C_RESET_VAL: std_logic_vector
    );
    port(
        clk       : in  std_logic;
        rst       : in  std_logic;
        chan_sel  : in  std_logic;
        reg_sel   : in  std_logic;
        wr_ce     : in  std_logic;
        d         : in  std_logic_vector;
        q         : out std_logic_vector
    );
end ctrl_reg;

architecture sim of ctrl_reg is
begin
    CTRL_REG_PROCESS: process (clk)
    begin
        if clk'event and clk='1' then
            if (rst = '1') then
                q <= C_RESET_VAL; 
            elsif (chan_sel and reg_sel and wr_ce) = '1' then
                q <= d;
            end if;
        end if;
    end process;
end;


library ieee;
use ieee.std_logic_1164.all;

entity ctrl_reg_0_to_6 is
    generic(
        C_RESET_VAL: std_logic_vector
    );
    port(
        clk       : in  std_logic;
        rst       : in  std_logic;
        chan_sel  : in  std_logic;
        reg_sel   : in  std_logic;
        wr_ce     : in  std_logic;
        d         : in  std_logic_vector(0 to 6);
        q         : out std_logic_vector(0 to 6)
    );
end ctrl_reg_0_to_6;

architecture sim of ctrl_reg_0_to_6 is
begin
    CTRL_REG_PROCESS: process (clk)
    begin
        if clk'event and clk='1' then
            if (rst = '1') then
                q <= C_RESET_VAL; 
            elsif (chan_sel and reg_sel and wr_ce) = '1' then
                q <= d;
            end if;
        end if;
    end process;
end;


library ieee;
use ieee.std_logic_1164.all;

entity ctrl_reg_0_to_0 is
    generic(
        C_RESET_VAL: std_logic_vector
    );
    port(
        clk       : in  std_logic;
        rst       : in  std_logic;
        chan_sel  : in  std_logic;
        reg_sel   : in  std_logic;
        wr_ce     : in  std_logic;
-- XGR_E33        d         : in  std_logic_vector(0 to 0);
-- XGR_E33        q         : out std_logic_vector(0 to 0)
        d         : in  std_logic;
        q         : out std_logic
    );
end ctrl_reg_0_to_0;

architecture sim of ctrl_reg_0_to_0 is
begin
    CTRL_REG_PROCESS: process (clk)
    begin
        if clk'event and clk='1' then
            if (rst = '1') then
-- XGR_E33                q <= C_RESET_VAL; 
                q <= C_RESET_VAL(0); 
            elsif (chan_sel and reg_sel and wr_ce) = '1' then
                q <= d;
            end if;
        end if;
    end process;
end;
