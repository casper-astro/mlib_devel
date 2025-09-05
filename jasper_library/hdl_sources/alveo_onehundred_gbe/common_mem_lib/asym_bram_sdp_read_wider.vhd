--<h---------------------------------------------------------------------------
--
-- Copyright (C) 2015
-- University of Oxford <http://www.ox.ac.uk/>
-- Department of Physics
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
--
-----------------------------------------------------------------------------h>
-- Asymmetric port RAM
-- Read Wider than Write
-- File: HDL_Coding_Techniques/rams/asym_ram_sdp_read_wider.vhd

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity asym_bram_sdp_read_wider is

  generic (
    WIDTHA      : integer := 4;
    SIZEA       : integer := 1024;
    ADDRWIDTHA  : integer := 10;
    WIDTHB      : integer := 16;
    SIZEB       : integer := 256;
    ADDRWIDTHB  : integer := 8;
    READLAT     : integer range 1 to 2 := 1
    );

  port (
    clkA   : in  std_logic;
    clkB   : in  std_logic;
    enA    : in  std_logic;
    enB    : in  std_logic;
    weA    : in  std_logic;
    addrA  : in  std_logic_vector(ADDRWIDTHA-1 downto 0);
    addrB  : in  std_logic_vector(ADDRWIDTHB-1 downto 0);
    diA    : in  std_logic_vector(WIDTHA-1 downto 0);
    doB    : out std_logic_vector(WIDTHB-1 downto 0)
    );

end asym_bram_sdp_read_wider;

architecture behavioral of asym_bram_sdp_read_wider is

  function max(L, R: INTEGER) return INTEGER is
  begin
      if L > R then
          return L;
      else
          return R;
      end if;
  end;

  function min(L, R: INTEGER) return INTEGER is
  begin
      if L < R then
          return L;
      else
          return R;
      end if;
  end;

  function log2 (val: INTEGER) return natural is
    variable res : natural;
  begin
        for i in 0 to 31 loop
            if (val <= (2**i)) then
                res := i;
                exit;
            end if;
        end loop;
        return res;
  end function Log2;

  constant minWIDTH : integer := min(WIDTHA,WIDTHB);
  constant maxWIDTH : integer := max(WIDTHA,WIDTHB);
  constant maxSIZE  : integer := max(SIZEA,SIZEB);
  constant RATIO : integer := maxWIDTH / minWIDTH;

  -- An asymmetric RAM is modeled in a similar way as a symmetric RAM, with an
  -- array of array object. Its aspect ratio corresponds to the port with the
  -- lower data width (larger depth)
  type ramType is array (0 to maxSIZE-1) of std_logic_vector(minWIDTH-1 downto 0);

  shared variable my_ram : ramType := (others => (others => '0'));
  
  signal readB : std_logic_vector(WIDTHB-1 downto 0):= (others => '0');
  signal regA  : std_logic_vector(WIDTHA-1 downto 0):= (others => '0');
  signal regB  : std_logic_vector(WIDTHB-1 downto 0):= (others => '0');
  
  attribute ram_style: string;
  attribute ram_style of my_ram: variable is "block"; 
  
begin


-- Write process
  process (clkA)
  begin
    if rising_edge(clkA) then
      if enA = '1' then
        if weA = '1' then
          my_ram(conv_integer(addrA)) := diA;
        end if;
      end if;
    end if;
  end process;

-- Read process
  process (clkB)
  begin
    if rising_edge(clkB) then
    for i in 0 to RATIO-1 loop
      if enB = '1' then        
          if RATIO = 1 then
            readB((i+1)*minWIDTH-1 downto i*minWIDTH)
	        <= my_ram(conv_integer(addrB));
          else
            readB((i+1)*minWIDTH-1 downto i*minWIDTH)
	        <= my_ram(conv_integer(addrB & conv_std_logic_vector(i,log2(RATIO))));
          end if;
      end if;
      end loop;
      regB <= readB;
    end if;
  end process;

  READLAT_1_gen: if READLAT = 1 generate
    doB <= readB;
  end generate;
  READLAT_2_gen: if READLAT = 2 generate
    doB <= regB;   
  end generate;
  
end behavioral;
