library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--
-- pragma translate_off
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
-- pragma translate_on

entity cal_reg is
port(
     clk            : in  std_logic;
     dInp           : in  std_logic;
     iReg           : out std_logic;
     dReg           : out std_logic
     );
end cal_reg;


architecture arc_cal_reg of cal_reg is

component FD
   port(
      Q                              :  out   STD_LOGIC;
      D                              :  in    STD_LOGIC;
      C                              :  in    STD_LOGIC);
end component;


signal iReg_val  : std_logic;
---signal iReg : std_logic;
signal dReg_val : std_logic;


attribute syn_replicate : boolean;
attribute syn_replicate of dReg_val : signal is false;

begin

iReg <= iReg_val;      
dReg <= dReg_val;      
	
ireg_FD : FD port map (
                      Q => iReg_val,
                      --Q => iReg,
                      D => dInp,
                      C => clk);

dreg_FD : FD port map (
                      Q => dReg_val,
                      D => iReg_val,
                      --D => iReg,
                      C => clk);
end arc_cal_reg;