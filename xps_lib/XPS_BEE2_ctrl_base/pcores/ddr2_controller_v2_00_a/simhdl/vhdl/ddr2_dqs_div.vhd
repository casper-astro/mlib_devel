library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--library synplify; 
--use synplify.attributes.all; 

-- pragma translate_off
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
-- pragma translate_on

entity ddr2_dqs_div is
  port (        
        dqs                 : in std_logic;  -- first column (col0) for negative edge data
        dqs1                : in std_logic;  -- second column (col1) for positive edge data
        reset               : in std_logic; 
        rst_dqs_div_delayed : in std_logic; 
        dqs_divn            : out std_logic; -- col0
        dqs_divp            : out std_logic  -- col1
       );
end ddr2_dqs_div;

architecture ddr2_dqs_div_arch of ddr2_dqs_div is

  component FDC
    port(
      Q                              :	out   STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC     
      );
  end component;

signal dqs_div1_int  : std_logic;  
signal dqs_div0_int  : std_logic;
signal dqs_div0n     : std_logic;
signal dqs_div1n     : std_logic;
signal async_clr     : std_logic; 
signal dqs1_n        : std_logic; 
signal dqs_n         : std_logic; 

begin

dqs_divn  <= dqs_div1_int;
dqs_divp  <= dqs_div0_int;
dqs_div0n <= not dqs_div0_int; 
dqs_div1n <= not dqs_div1_int;
dqs1_n    <= not dqs1;
dqs_n     <= not dqs;


col1 :   FDC
    port map(
             Q   => dqs_div0_int, 
             C   => dqs1,
             CLR => rst_dqs_div_delayed,
             D   => dqs_div0n
            );

col0 :   FDC
    port map(
             Q   => dqs_div1_int, 
             C   => dqs_n,
             CLR => reset,
             D   => dqs_div0_int
            );
            
end ddr2_dqs_div_arch;
