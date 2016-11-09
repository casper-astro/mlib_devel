------------------------------------------------------------------------
--
--  Filename      : xlconcat.vhd
--
--  Date          : 03/14/2014
--
--  Description   : VHDL description of a concat block.  This
--                  block does not use a core.
--
------------------------------------------------------------------------


------------------------------------------------------------------------
--
--  Entity        : xlconcat
--
--  Architecture  : behavior
--
--  Description   : Top level VHDL description of bus concatenater
--
------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity xlconcat is
    generic (
      NUM_PORTS      : integer := 2;       -- Number of input ports to concat
      IN0_WIDTH      : integer := 1;       -- Width of a In0 input
      IN1_WIDTH      : integer := 1;       -- Width of a In1 input
      IN2_WIDTH      : integer := 1;       -- Width of a In2 input
      IN3_WIDTH      : integer := 1;       -- Width of a In3 input
      IN4_WIDTH      : integer := 1;       -- Width of a In4 input
      IN5_WIDTH      : integer := 1;       -- Width of a In5 input
      IN6_WIDTH      : integer := 1;       -- Width of a In6 input
      IN7_WIDTH      : integer := 1;       -- Width of a In7 input
      IN8_WIDTH      : integer := 1;       -- Width of a In8 input
      IN9_WIDTH      : integer := 1;       -- Width of a In9 input
      IN10_WIDTH     : integer := 1;       -- Width of a In10 input
      IN11_WIDTH     : integer := 1;       -- Width of a In10 input
      IN12_WIDTH     : integer := 1;       -- Width of a In10 input
      IN13_WIDTH     : integer := 1;       -- Width of a In10 input
      IN14_WIDTH     : integer := 1;       -- Width of a In10 input 
      IN15_WIDTH     : integer := 1;       -- Width of a In15 input
      IN16_WIDTH     : integer := 1;       -- Width of a In16 input
      IN17_WIDTH     : integer := 1;       -- Width of a In17 input
      IN18_WIDTH     : integer := 1;       -- Width of a In18 input
      IN19_WIDTH     : integer := 1;       -- Width of a In19 input
      IN20_WIDTH     : integer := 1;       -- Width of a In20 input
      IN21_WIDTH     : integer := 1;       -- Width of a In21 input
      IN22_WIDTH     : integer := 1;       -- Width of a In22 input
      IN23_WIDTH     : integer := 1;       -- Width of a In23 input
      IN24_WIDTH     : integer := 1;       -- Width of a In24 input
      IN25_WIDTH     : integer := 1;       -- Width of a In25 input
      IN26_WIDTH     : integer := 1;       -- Width of a In26 input
      IN27_WIDTH     : integer := 1;       -- Width of a In27 input
      IN28_WIDTH     : integer := 1;       -- Width of a In28 input
      IN29_WIDTH     : integer := 1;       -- Width of a In29 input
      IN30_WIDTH     : integer := 1;       -- Width of a In30 input
      IN31_WIDTH     : integer := 1;       -- Width of a In31 input
      dout_width      : integer := 2);      -- Width of output
    port (
      In0 : in std_logic_vector (IN0_WIDTH-1 downto 0);
      In1 : in std_logic_vector (IN1_WIDTH-1 downto 0);
      In2 : in std_logic_vector (IN2_WIDTH-1 downto 0);
      In3 : in std_logic_vector (IN3_WIDTH-1 downto 0);
      In4 : in std_logic_vector (IN4_WIDTH-1 downto 0);
      In5 : in std_logic_vector (IN5_WIDTH-1 downto 0);
      In6 : in std_logic_vector (IN6_WIDTH-1 downto 0);
      In7 : in std_logic_vector (IN7_WIDTH-1 downto 0);
      In8 : in std_logic_vector (IN8_WIDTH-1 downto 0);
      In9 : in std_logic_vector (IN9_WIDTH-1 downto 0);
      In10 : in std_logic_vector (IN10_WIDTH-1 downto 0);
      In11 : in std_logic_vector (IN11_WIDTH-1 downto 0);
      In12 : in std_logic_vector (IN12_WIDTH-1 downto 0);
      In13 : in std_logic_vector (IN13_WIDTH-1 downto 0);
      In14 : in std_logic_vector (IN14_WIDTH-1 downto 0);
      In15 : in std_logic_vector (IN15_WIDTH-1 downto 0);
      In16 : in std_logic_vector (IN16_WIDTH-1 downto 0);
      In17 : in std_logic_vector (IN17_WIDTH-1 downto 0);
      In18 : in std_logic_vector (IN18_WIDTH-1 downto 0);
      In19 : in std_logic_vector (IN19_WIDTH-1 downto 0);
      In20 : in std_logic_vector (IN20_WIDTH-1 downto 0);
      In21 : in std_logic_vector (IN21_WIDTH-1 downto 0);
      In22 : in std_logic_vector (IN22_WIDTH-1 downto 0);
      In23 : in std_logic_vector (IN23_WIDTH-1 downto 0);
      In24 : in std_logic_vector (IN24_WIDTH-1 downto 0);
      In25 : in std_logic_vector (IN25_WIDTH-1 downto 0);
      In26 : in std_logic_vector (IN26_WIDTH-1 downto 0);
      In27 : in std_logic_vector (IN27_WIDTH-1 downto 0);
      In28 : in std_logic_vector (IN28_WIDTH-1 downto 0);
      In29 : in std_logic_vector (IN29_WIDTH-1 downto 0);
      In30 : in std_logic_vector (IN30_WIDTH-1 downto 0);
      In31 : in std_logic_vector (IN31_WIDTH-1 downto 0);
      dout : out std_logic_vector (dout_width-1 downto 0)
	  );
end xlconcat;

architecture behavioral of xlconcat is
begin

NUM_1_INST : if NUM_PORTS = 1 generate
begin
     dout <= In0;
end generate NUM_1_INST; 
  
NUM_2_INST : if NUM_PORTS = 2 generate
begin
     dout <= In1 & In0;
end generate NUM_2_INST; 

NUM_3_INST : if NUM_PORTS = 3 generate
begin
     dout <= In2 & In1 & In0;
end generate NUM_3_INST; 

NUM_4_INST : if NUM_PORTS = 4 generate
begin
     dout <= In3 & In2 & In1 & In0;
end generate NUM_4_INST; 

NUM_5_INST : if NUM_PORTS = 5 generate
begin
     dout <= In4 & In3 & In2 & In1 & In0;
end generate NUM_5_INST; 

NUM_6_INST : if NUM_PORTS = 6 generate
begin
     dout <= In5 & In4 & In3 & In2 & In1 & In0;
end generate NUM_6_INST; 

NUM_7_INST : if NUM_PORTS = 7 generate
begin
     dout <= In6 & In5 & In4 & In3 & In2 & In1 & In0;
end generate NUM_7_INST; 

NUM_8_INST : if NUM_PORTS = 8 generate
begin
     dout <= In7 & In6 & In5 & In4 & In3 & In2 & In1 & In0;
end generate NUM_8_INST; 

NUM_9_INST : if NUM_PORTS = 9 generate
begin
     dout <= In8 & In7 & In6 & In5 & In4 & In3 & In2 & In1 & In0;
end generate NUM_9_INST; 

NUM_10_INST : if NUM_PORTS = 10 generate
begin
     dout <= In9 & In8 & In7 & In6 & In5 & In4 & In3 & In2 & In1 & In0;
end generate NUM_10_INST; 

NUM_11_INST : if NUM_PORTS = 11 generate
begin
     dout <= In10 & In9 & In8 & In7 & In6 & In5 & In4 & In3 & In2 & In1 & In0;
end generate NUM_11_INST; 

NUM_12_INST : if NUM_PORTS = 12 generate
begin
     dout <= In11 & In10 & In9 & In8 & In7 & In6 & In5 & In4 & In3 & In2 & In1 & In0;
end generate NUM_12_INST; 

NUM_13_INST : if NUM_PORTS = 13 generate
begin
     dout <= In12 & In11 & In10 & In9 & In8 & In7 & In6 & In5 & In4 & In3 & In2 & In1 & In0;
end generate NUM_13_INST; 

NUM_14_INST : if NUM_PORTS = 14 generate
begin
     dout <= In13 & In12 & In11 & In10 & In9 & In8 & In7 & In6 & In5 & In4 & In3 & In2 & In1 & In0;
end generate NUM_14_INST; 

NUM_15_INST : if NUM_PORTS = 15 generate
begin
     dout <= In14 & In13 & In12 & In11 & In10 & In9 & In8 & In7 & In6 & In5 & In4 & In3 & In2 & In1 & In0;
end generate NUM_15_INST; 

NUM_16_INST : if NUM_PORTS = 16 generate
begin
     dout <= In15 & In14 & In13 & In12 & In11 & In10 & In9 & In8 & In7 & In6 & In5 & In4 & In3 & In2 & In1 & In0;
end generate NUM_16_INST; 

NUM_17_INST : if NUM_PORTS = 17 generate
begin
     dout <= In16 & In15 & In14 & In13 & In12 & In11 & In10 & In9 & In8 & In7 & In6 & In5 & In4 & In3 & In2 & In1 & In0;
end generate NUM_17_INST; 

NUM_18_INST : if NUM_PORTS = 18 generate
begin
     dout <= In17 & In16 & In15 & In14 & In13 & In12 & In11 & In10 & In9 & In8 & In7 & In6 & In5 & In4 & In3 & In2 & In1 & In0;
end generate NUM_18_INST; 

NUM_19_INST : if NUM_PORTS = 19 generate
begin
     dout <= In18 & In17 & In16 & In15 & In14 & In13 & In12 & In11 & In10 & In9 & In8 & In7 & In6 & In5 & In4 & In3 & In2 & In1 & In0;
end generate NUM_19_INST; 

NUM_20_INST : if NUM_PORTS = 20 generate
begin
     dout <= In19 & In18 & In17 & In16 & In15 & In14 & In13 & In12 & In11 & In10 & In9 & In8 & In7 & In6 & In5 & In4 & In3 & In2 & In1 & In0;
end generate NUM_20_INST; 

NUM_21_INST : if NUM_PORTS = 21 generate
begin
     dout <= In20 & In19 & In18 & In17 & In16 & In15 & In14 & In13 & In12 & In11 & In10 & In9 & In8 & In7 & In6 & In5 & In4 & In3 & In2 & In1 & In0;
end generate NUM_21_INST; 

NUM_22_INST : if NUM_PORTS = 22 generate
begin
     dout <= In21 & In20 & In19 & In18 & In17 & In16 & In15 & In14 & In13 & In12 & In11 & In10 & In9 & In8 & In7 & In6 & In5 & In4 & In3 & In2 & In1 & In0;
end generate NUM_22_INST; 

NUM_23_INST : if NUM_PORTS = 23 generate
begin
     dout <= In22 & In21 & In20 & In19 & In18 & In17 & In16 & In15 & In14 & In13 & In12 & In11 & In10 & In9 & In8 & In7 & In6 & In5 & In4 & In3 & In2 & In1 & In0;
end generate NUM_23_INST; 

NUM_24_INST : if NUM_PORTS = 24 generate
begin
     dout <= In23 & In22 & In21 & In20 & In19 & In18 & In17 & In16 & In15 & In14 & In13 & In12 & In11 & In10 & In9 & In8 & In7 & In6 & In5 & In4 & In3 & In2 & In1 & In0;
end generate NUM_24_INST; 

NUM_25_INST : if NUM_PORTS = 25 generate
begin
     dout <= In24 & In23 & In22 & In21 & In20 & In19 & In18 & In17 & In16 & In15 & In14 & In13 & In12 & In11 & In10 & In9 & In8 & In7 & In6 & In5 & In4 & In3 & In2 & In1 & In0;
end generate NUM_25_INST; 

NUM_26_INST : if NUM_PORTS = 26 generate
begin
     dout <= In25 & In24 & In23 & In22 & In21 & In20 & In19 & In18 & In17 & In16 & In15 & In14 & In13 & In12 & In11 & In10 & In9 & In8 & In7 & In6 & In5 & In4 & In3 & In2 & In1 & In0;
end generate NUM_26_INST; 

NUM_27_INST : if NUM_PORTS = 27 generate
begin
     dout <= In26 & In25 & In24 & In23 & In22 & In21 & In20 & In19 & In18 & In17 & In16 & In15 & In14 & In13 & In12 & In11 & In10 & In9 & In8 & In7 & In6 & In5 & In4 & In3 & In2 & In1 & In0;
end generate NUM_27_INST; 

NUM_28_INST : if NUM_PORTS = 28 generate
begin
     dout <= In27 & In26 & In25 & In24 & In23 & In22 & In21 & In20 & In19 & In18 & In17 & In16 & In15 & In14 & In13 & In12 & In11 & In10 & In9 & In8 & In7 & In6 & In5 & In4 & In3 & In2 & In1 & In0;
end generate NUM_28_INST; 

NUM_29_INST : if NUM_PORTS = 29 generate
begin
     dout <= In28 & In27 & In26 & In25 & In24 & In23 & In22 & In21 & In20 & In19 & In18 & In17 & In16 & In15 & In14 & In13 & In12 & In11 & In10 & In9 & In8 & In7 & In6 & In5 & In4 & In3 & In2 & In1 & In0;
end generate NUM_29_INST; 

NUM_30_INST : if NUM_PORTS = 30 generate
begin
     dout <= In29 & In28 & In27 & In26 & In25 & In24 & In23 & In22 & In21 & In20 & In19 & In18 & In17 & In16 & In15 & In14 & In13 & In12 & In11 & In10 & In9 & In8 & In7 & In6 & In5 & In4 & In3 & In2 & In1 & In0;
end generate NUM_30_INST; 

NUM_31_INST : if NUM_PORTS = 31 generate
begin
     dout <= In30 & In29 & In28 & In27 & In26 & In25 & In24 & In23 & In22 & In21 & In20 & In19 & In18 & In17 & In16 & In15 & In14 & In13 & In12 & In11 & In10 & In9 & In8 & In7 & In6 & In5 & In4 & In3 & In2 & In1 & In0;
end generate NUM_31_INST; 

NUM_32_INST : if NUM_PORTS = 32 generate
begin
     dout <= In31 & In30 & In29 & In28 & In27 & In26 & In25 & In24 & In23 & In22 & In21 & In20 & In19 & In18 & In17 & In16 & In15 & In14 & In13 & In12 & In11 & In10 & In9 & In8 & In7 & In6 & In5 & In4 & In3 & In2 & In1 & In0;
end generate NUM_32_INST; 

end behavioral;
