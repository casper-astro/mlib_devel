library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
--
-- pragma translate_off
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
-- pragma translate_on

entity mybufg is
port (I : in std_logic;
      O : out std_logic);
end entity;

architecture mybufg_arch of mybufg is

attribute syn_hier : string;
attribute syn_hier of mybufg_arch: architecture is "hard";

component BUFG
port (I : in std_logic;
      O : out std_logic);
end component;

begin

u1 : bufg port map (I,O);

end architecture;




