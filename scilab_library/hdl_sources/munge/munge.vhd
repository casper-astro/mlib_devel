-- A VHDL implementation of the CASPER munge block.
-- @author: Ross Donnachie
-- @company: Mydon Solutions

LIBRARY IEEE, common_pkg_lib;
USE IEEE.std_logic_1164.all;
USE common_pkg_lib.common_pkg.all;

ENTITY munge is
  generic (
    g_number_of_divisions : NATURAL := 4;
    g_division_size_bits  : NATURAL := 2;
    g_packing_order  : t_natural_arr := (0, 1, 2, 3)
  );
  port (
    clk   : in std_logic := '1';
    ce    : in std_logic := '1';

    din   : in std_logic_vector(g_number_of_divisions * g_division_size_bits - 1 downto 0);
    dout  : out std_logic_vector(g_number_of_divisions * g_division_size_bits - 1 downto 0)
  );
end ENTITY;

ARCHITECTURE rtl of munge is
  alias din_v : STD_LOGIC_VECTOR (din'length-1 downto 0) is din;
  alias dout_v : STD_LOGIC_VECTOR (dout'length-1 downto 0) is dout;
begin

  division_reorder: FOR I IN 0 TO g_number_of_divisions-1 GENERATE
    dout_v((g_packing_order(g_packing_order'LOW+I)+1)*g_division_size_bits - 1 downto g_packing_order(g_packing_order'LOW+I)*g_division_size_bits) <= din_v((I+1)*g_division_size_bits - 1 downto I*g_division_size_bits);
  end GENERATE;

end ARCHITECTURE;
