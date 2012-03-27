-- simulation model for dcmx3y0_2vp70
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--library synplify; 
--use synplify.attributes.all;
--
-- model for simulation only
-- pragma translate_off
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
-- pragma translate_on

entity   dcmx3y0_2vp70_sim  is
port(
	clock1_in     : in std_logic;   
	clock2_in     : in std_logic;   
	clock1_out    : out std_logic;   
	clock2_out    : out std_logic
);
end   dcmx3y0_2vp70_sim;  

architecture   arc_dcmx3y0_2vp70_sim of   dcmx3y0_2vp70_sim    is

component LUT4
   generic(
      INIT                           :  bit_vector(15 downto 0) := x"0000" );
   port(
      O                              :	out   STD_ULOGIC;
      I0                             :	in    STD_ULOGIC;
      I1                             :	in    STD_ULOGIC;
      I2                             :	in    STD_ULOGIC;
      I3                             :	in    STD_ULOGIC
      );
end component;		  

signal one: std_logic;
signal clkd1inv_1        : std_logic;
signal clkd1buf_1        : std_logic;
signal dualinv_out_sig_1 : std_logic;
signal clkd1buf_2        : std_logic;
signal clkd1inv_2        : std_logic;
signal dualinv_out_sig_2 : std_logic;

begin

one <= '1';

BUF1_1 :  LUT4  generic map (INIT => x"AAAA")   
port map   ( 
            I0 => clock1_in, 
            I1 => one, 
            I2 => one, 
            I3 => one, 
            O  => clkd1buf_1
           );

INV1_1 :  LUT4  generic map (INIT => x"00FF")   
port map   ( 
            I0 => one, 
            I1 => one, 
            I2 => one, 
            I3 => clkd1buf_1, 
            O  => clkd1inv_1
           );

INV2_1 :  LUT4  generic map (INIT => x"3333")   
port map   ( 
            I0 => one, 
            I1 => clkd1inv_1, 
            I2 => one, 
            I3 => one, 
            O  => dualinv_out_sig_1
           );

BUF2_1 :  LUT4  generic map (INIT => x"CCCC")   
port map   ( 
            I0 => one, 
            I1 => dualinv_out_sig_1, 
            I2 => one, 
            I3 => one, 
            O  => clock1_out
           );

BUF1_2 :  LUT4  generic map (INIT => x"CCCC")   
port map   ( 
            I0 => one, 
            I1 => clock2_in, 
            I2 => one, 
            I3 => one, 
            O  => clkd1buf_2
           );

INV1_2 :  LUT4  generic map (INIT => x"00FF")   
port map   ( 
            I0 => one, 
            I1 => one, 
            I2 => one, 
            I3 => clkd1buf_2, 
            O  => clkd1inv_2
           );

INV2_2 :  LUT4  generic map (INIT => x"3333")   
port map   ( 
            I0 => one, 
            I1 => clkd1inv_2, 
            I2 => one, 
            I3 => one, 
            O  => dualinv_out_sig_2
           );

BUF2_2 :  LUT4  generic map (INIT => x"CCCC")   
port map   ( 
            I0 => one, 
            I1 => dualinv_out_sig_2, 
            I2 => one, 
            I3 => one, 
            O  => clock2_out
           );

end architecture;


