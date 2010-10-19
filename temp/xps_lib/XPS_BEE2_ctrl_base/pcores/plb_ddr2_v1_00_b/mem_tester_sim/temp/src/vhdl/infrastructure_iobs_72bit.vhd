library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--
-- pragma translate_off
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
-- pragma translate_on
--
entity   infrastructure_iobs_72bit  is
 port(
      clk0              : in STD_LOGIC;
      clk90             : in STD_LOGIC;
      ddr2_clk0         : out STD_LOGIC;
      ddr2_clk0b        : out STD_LOGIC;
      ddr2_clk1         : out STD_LOGIC;
      ddr2_clk1b        : out STD_LOGIC;
      ddr2_clk2         : out STD_LOGIC;
      ddr2_clk2b        : out STD_LOGIC
    
      );
end   infrastructure_iobs_72bit;  

architecture   arc_infrastructure_iobs_72bit of   infrastructure_iobs_72bit    is


attribute syn_keep : boolean;
attribute xc_props : string;
  
     
---- Component declarations -----

 component IBUFGDS_LVDS_25     
  port ( I  : in std_logic;     
         IB : in std_logic;    
         O  : out std_logic);   
 end component;

 component FDDRRSE 
 port( Q  : out std_logic;
       C0 : in std_logic;
       C1 : in std_logic;
       CE : in std_logic;
       D0 : in std_logic;
       D1 : in std_logic;
       R  : in std_logic;
       S  : in std_logic);
 end component;

 component OBUF
 port (
   O : out std_logic;
   I : in std_logic);
 end component;

---- ******************* ----
---- Signal declarations ----
---- ******************* ----

signal ddr2_clk0_q          :std_logic;
signal ddr2_clk0b_q         :std_logic;
signal ddr2_clk1_q          :std_logic;
signal ddr2_clk1b_q         :std_logic;
signal ddr2_clk2_q          :std_logic;
signal ddr2_clk2b_q         :std_logic;

signal vcc                  :std_logic;
signal gnd                  :std_logic;
  signal clk180               :std_logic;
  signal clk270               : std_logic;



---- **************************************************
---- iob attributes for instantiated FDDRRSE components
---- **************************************************

attribute xc_props of U1: label is "IOB=TRUE";
attribute xc_props of U2: label is "IOB=TRUE";
attribute xc_props of U3: label is "IOB=TRUE";
attribute xc_props of U4: label is "IOB=TRUE";
attribute xc_props of U5: label is "IOB=TRUE";
attribute xc_props of U6: label is "IOB=TRUE";


  attribute syn_keep of clk180 : signal is true;
  attribute syn_keep of clk270 : signal is true;

begin

   clk180 <= not clk0;
   clk270 <= not clk90;
 gnd <= '0';
 vcc <= '1';



----  Component instantiations  ----

--- ***********************************
----     This includes instantiation of the output DDR flip flop
----     for ddr clk's 
---- ***********************************************************

U1 : FDDRRSE port map (
                        Q  => ddr2_clk0_q ,
                        C0 => clk0,
                        C1 => clk180,
                        CE => vcc,
                        D0 => vcc,
                        D1 => gnd,
                         R => gnd,
                         S => gnd);

U2 : FDDRRSE port map (
                        Q => ddr2_clk0b_q ,
                        C0 => clk0,
                        C1 => clk180,
                        CE => vcc,
                        D0 => gnd,
                        D1 => vcc,
                         R => gnd,
                         S => gnd);

U3 : FDDRRSE port map (
                        Q => ddr2_clk1_q ,
                        C0 => clk0,
                        C1 => clk180,
                        CE => vcc,
                        D0 => vcc,
                        D1 => gnd,
                         R => gnd,
                         S => gnd);

U4 : FDDRRSE port map (
                        Q => ddr2_clk1b_q ,
                        C0 => clk0,
                        C1 => clk180,
                        CE => vcc,
                        D0 => gnd,
                        D1 => vcc,
                         R => gnd,
                         S => gnd);

U5 : FDDRRSE port map (
                        Q => ddr2_clk2_q ,
                        C0 => clk0,
                        C1 => clk180,
                        CE => vcc,
                        D0 => vcc,
                        D1 => gnd,
                         R => gnd,
                         S => gnd);

U6 : FDDRRSE port map (
                        Q => ddr2_clk2b_q ,
                        C0 => clk0,
                        C1 => clk180,
                        CE => vcc,
                        D0 => gnd,
                        D1 => vcc,
                         R => gnd,
                         S => gnd);



---- ******************************************
---- Ouput BUffers for ddr clk's 
---- ******************************************


r1 : OBUF port map (
                     I => ddr2_clk0_q,
                     O => ddr2_clk0);

r2 : OBUF port map (
                     I => ddr2_clk0b_q,
                     O => ddr2_clk0b);

r3 : OBUF port map (
                     I => ddr2_clk1_q,
                     O => ddr2_clk1);

r4 : OBUF port map (
                     I => ddr2_clk1b_q,
                     O => ddr2_clk1b);

r5 : OBUF port map (
                     I => ddr2_clk2_q,
                     O => ddr2_clk2);

r6 : OBUF port map (
                     I => ddr2_clk2b_q,
                     O => ddr2_clk2b);



end   arc_infrastructure_iobs_72bit;  
