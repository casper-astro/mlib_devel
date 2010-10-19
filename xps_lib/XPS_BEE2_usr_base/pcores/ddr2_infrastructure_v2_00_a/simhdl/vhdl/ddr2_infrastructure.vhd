
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--library synplify; 
--use synplify.attributes.all;
--
-- pragma translate_off
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
-- pragma translate_on
--

entity ddr2_infrastructure is
port(
	reset_in             : in  std_logic;
	clk_in               : in  std_logic;
	dcmlock_in           : in  std_logic;
	user_ddr_reset       : out std_logic;
	user_ddr_clk         : out std_logic;
	lnk0_ddr_inf_reset   : out std_logic;
	lnk0_ddr_delay_sel   : out std_logic_vector(4 downto 0);
	lnk0_ddr_clk         : out std_logic;
	lnk0_ddr_clk90       : out std_logic;
	lnk1_ddr_inf_reset   : out std_logic;
	lnk1_ddr_delay_sel   : out std_logic_vector(4 downto 0);
	lnk1_ddr_clk         : out std_logic;
	lnk1_ddr_clk90       : out std_logic;
	lnk2_ddr_inf_reset   : out std_logic;
	lnk2_ddr_delay_sel   : out std_logic_vector(4 downto 0);
	lnk2_ddr_clk         : out std_logic;
	lnk2_ddr_clk90       : out std_logic;
	lnk3_ddr_inf_reset   : out std_logic;
	lnk3_ddr_delay_sel   : out std_logic_vector(4 downto 0);
	lnk3_ddr_clk         : out std_logic;
	lnk3_ddr_clk90       : out std_logic
);
end ddr2_infrastructure;

architecture arc_ddr2_infrastructure  of ddr2_infrastructure is

---- Component declarations -----

component clk_dcm 
port(
	input_clk   : in  std_logic;
	rst         : in  std_logic;
	clk         : out std_logic;
	clk90       : out std_logic;
	dcm_lock    : out std_logic
);
end component;

component cal_top                                                 
port (                                                
	clk         : in  std_logic;                     
	clk0        : in  std_logic;                     
	clk0dcmlock : in  std_logic;                     
	reset       : in  std_logic;                     
	okToSelTap  : in  std_logic;
	tapForDqs   : out std_logic_vector(4 downto 0)
);
end component;

signal ddr_clk_int             : std_logic;
signal ddr_clk90_int           : std_logic;
signal dcm_lock                : std_logic;
signal vcc                     : std_logic;
signal not_dcmlock_in          : std_logic;
signal powerup_counter         : std_logic_vector(31 downto 0) := (others => '0');
signal powerup_reset           : std_logic := '1';

signal ddr_inf_reset           : std_logic;
signal ddr_delay_sel           : std_logic_vector(4 downto 0);
signal ddr_clk                 : std_logic;
signal ddr_clk90               : std_logic;

attribute syn_noprune : boolean;
attribute syn_noprune of ddr_delay_sel: signal is true;

begin

vcc       <= '1';
ddr_clk   <= clk_in; -- use input clock directly in simulation to prevent delta delays issues
ddr_clk90 <= ddr_clk90_int;

-- external dcm lock input
not_dcmlock_in <= not dcmlock_in;

-- external infrastructure reset
process(clk_in)
begin
	if clk_in'event and clk_in = '1' then
		if powerup_counter /= X"0000000F" then -- 16 cycles
			powerup_counter <= powerup_counter + 1;
			powerup_reset   <= '1';
		else
			powerup_reset   <= '0';
		end if;
	end if;
end process;
ddr_inf_reset <= reset_in or (not dcm_lock) or powerup_reset;

clk_dcm0 : clk_dcm port map (
                             input_clk   => clk_in,
                             rst         => not_dcmlock_in,                            
                             clk         => ddr_clk_int,
                             clk90       => ddr_clk90_int,
                             dcm_lock    => dcm_lock
                            ); 
                            
cal_top0 : cal_top port map (                                                 
                             clk         => clk_in,  
                             clk0        => ddr_clk_int,
                             clk0dcmlock => dcm_lock,  
                             reset       => reset_in,      
                             okToSelTap  => vcc,
                             tapForDqs   => ddr_delay_sel
                            );       

-- signal fanout
user_ddr_reset       <= ddr_inf_reset;
user_ddr_clk         <= ddr_clk      ;
lnk0_ddr_inf_reset   <= ddr_inf_reset;
lnk0_ddr_delay_sel   <= ddr_delay_sel;
lnk0_ddr_clk         <= ddr_clk      ;
lnk0_ddr_clk90       <= ddr_clk90    ;
lnk1_ddr_inf_reset   <= ddr_inf_reset;
lnk1_ddr_delay_sel   <= ddr_delay_sel;
lnk1_ddr_clk         <= ddr_clk      ;
lnk1_ddr_clk90       <= ddr_clk90    ;
lnk2_ddr_inf_reset   <= ddr_inf_reset;
lnk2_ddr_delay_sel   <= ddr_delay_sel;
lnk2_ddr_clk         <= ddr_clk      ;
lnk2_ddr_clk90       <= ddr_clk90    ;
lnk3_ddr_inf_reset   <= ddr_inf_reset;
lnk3_ddr_delay_sel   <= ddr_delay_sel;
lnk3_ddr_clk         <= ddr_clk      ;
lnk3_ddr_clk90       <= ddr_clk90    ;


end arc_ddr2_infrastructure ;


