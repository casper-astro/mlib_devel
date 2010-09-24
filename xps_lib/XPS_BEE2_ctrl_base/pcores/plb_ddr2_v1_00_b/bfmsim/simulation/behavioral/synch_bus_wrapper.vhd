-------------------------------------------------------------------------------
-- synch_bus_wrapper.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

library bfm_synch_v1_00_a;
use bfm_synch_v1_00_a.all;

entity synch_bus_wrapper is
  port (
    FROM_SYNCH_OUT : in std_logic_vector(0 to 95);
    TO_SYNCH_IN : out std_logic_vector(0 to 31)
  );
end synch_bus_wrapper;

architecture STRUCTURE of synch_bus_wrapper is

  component bfm_synch is
    generic (
      C_NUM_SYNCH : integer
    );
    port (
      FROM_SYNCH_OUT : in std_logic_vector(0 to (C_NUM_SYNCH*32)-1);
      TO_SYNCH_IN : out std_logic_vector(0 to 31)
    );
  end component;

begin

  synch_bus : bfm_synch
    generic map (
      C_NUM_SYNCH => 3
    )
    port map (
      FROM_SYNCH_OUT => FROM_SYNCH_OUT,
      TO_SYNCH_IN => TO_SYNCH_IN
    );

end architecture STRUCTURE;

