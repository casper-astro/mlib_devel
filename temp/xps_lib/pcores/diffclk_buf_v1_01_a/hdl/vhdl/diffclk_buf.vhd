--SINGLE_FILE_TAG
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- diffclk_buf - entity/architecture pair
-------------------------------------------------------------------------------
--
--
-------------------------------------------------------------------------------
-- Filename:        diffclk_buf.vhd
--
-- Description:     differential clock input buffer
--
--
-------------------------------------------------------------------------------
-- Structure:   This section should show the hierarchical structure of the
--              designs. Separate lines with blank lines if necessary to improve
--              readability.
--
--              diffclk_buf.vhd
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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library UNISIM;
use UNISIM.VComponents.all;
-------------------------------------------------------------------------------
-- Port Declaration
-------------------------------------------------------------------------------
-- Definition of Generics:
--
-- Definition of Ports:
--          Clkin_p                -- Positive input clock
--          Clkin_m                -- Negative input clock
--          Clkout                 -- Output clock
--
-------------------------------------------------------------------------------
entity diffclk_buf is

    port (
          Clkin_p     : in  std_logic;
          Clkin_m     : in  std_logic;
          Clkout      : out  std_logic
         );

end entity diffclk_buf;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------
architecture imp of diffclk_buf is

    attribute DIFF_TERM : string ;

    attribute DIFF_TERM of clk_ibuf : label is "true" ;

begin

	clk_ibuf : IBUFGDS port map (I=>Clkin_p, IB=>Clkin_m, O=>Clkout);

end imp;

--END_SINGLE_FILE_TAG
