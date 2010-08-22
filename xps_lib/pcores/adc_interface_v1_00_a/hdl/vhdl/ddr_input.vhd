--------------------------------------------------------------------------
-- ddr_input.vhd
--------------------------------------------------------------------------
--
-- $Id$
--
-- Adapted from Virtex-II Pro User Guide
-- [UG012 (v4.0) 23 March 2005, pp 250-1]

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ddr_input is
  port (
    clk   : in  std_logic;
    d     : in  std_logic;
    rst   : in  std_logic := '0';
    qrise : out std_logic;
    qfall : out std_logic
  );
end ddr_input;

--Describe input DDR registers (behaviorally) to be inferred
architecture behavioral of ddr_input is

  attribute iob : string;
  attribute iob of qrisereg : label is "true"; 
  attribute iob of qfallreg : label is "true"; 

begin

  qrisereg : process (clk, d, rst)
  begin
    if rst='1' then --asynchronous reset, active high
      qrise <= '0';
    elsif clk'event and clk='1' then --Clock event - posedge
      qrise <= d;
    end if;
  end process;

  qfallreg : process (clk, d, rst)
  begin
    if rst='1' then --asynchronous reset, active high
      qfall <= '0';
    elsif clk'event and clk='0' then --Clock event - negedge
      qfall <= d;
    end if;
  end process;

end behavioral;
