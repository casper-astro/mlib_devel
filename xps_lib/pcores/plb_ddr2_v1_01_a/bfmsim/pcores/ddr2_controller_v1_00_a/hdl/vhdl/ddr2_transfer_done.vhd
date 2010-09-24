library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--library synplify; 
--use synplify.attributes.all; 

-- pragma translate_off
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
-- pragma translate_on

entity ddr2_transfer_done is
  port (
        clk0            : in std_logic;
        clk90           : in std_logic;             
        reset           : in std_logic;
        reset90         : in std_logic;
        reset180        : in std_logic;
        reset270        : in std_logic;
        dqs_div         : in std_logic;
        transfer_done0  : out std_logic;
        transfer_done1  : out std_logic;
        transfer_done2  : out std_logic;
        transfer_done3  : out std_logic
       );
end ddr2_transfer_done;

architecture ddr2_transfer_done_arch of ddr2_transfer_done is

attribute syn_keep: boolean;

  component FD
    port(
      Q                              :	out   STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC
      );
  end component;

  component FDR
    port(
      Q                              :	out   STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      R                              :	in    STD_ULOGIC
      );
  end component; 
  
component LUT2
   generic(
      INIT                           :  bit_vector(3 downto 0) := x"0");
   port(
      O                              :	out   STD_ULOGIC;
      I0                             :	in    STD_ULOGIC;
      I1                             :	in    STD_ULOGIC
      );
end component;   
  
component LUT3
   generic(
      INIT                           :  bit_vector(7 downto 0) := x"00" );
   port(
      O                              :	out   STD_ULOGIC;
      I0                             :	in    STD_ULOGIC;
      I1                             :	in    STD_ULOGIC;
      I2                             :	in    STD_ULOGIC
      );
end component;


signal transfer_done_int      : std_logic_vector(3 downto 0);
signal transfer_done0_clk0    : std_logic;
signal transfer_done0_clk90   : std_logic;
signal transfer_done0_clk180  : std_logic;
signal transfer_done0_clk270  : std_logic;
signal transfer_done1_clk90   : std_logic;
signal transfer_done1_clk270  : std_logic;
signal transfer_done2_clk90   : std_logic;
signal transfer_done2_clk270  : std_logic;
signal transfer_done3_clk90   : std_logic;
signal transfer_done3_clk270  : std_logic;
signal sync_rst_xdone0_ck0    : std_logic;
signal sync_rst_xdone0_ck180  : std_logic;
signal sync_rst_clk90         : std_logic;
signal sync_rst_clk270        : std_logic;

  signal clk180                 : std_logic;
  signal clk270                 : std_logic;

  attribute syn_keep of clk270 : signal is true;
  attribute syn_keep of clk180 : signal is true;

attribute syn_replicate : boolean;
attribute syn_replicate of transfer_done0_clk270 : signal is false;
begin

  clk180 <= not clk0;
  clk270 <= not clk90;

sync_rst_xdone0_ck0   <= reset or transfer_done0_clk0; 
sync_rst_xdone0_ck180 <= reset180 or transfer_done0_clk180;

transfer_done0        <= transfer_done_int(0);
transfer_done1        <= transfer_done_int(1);
transfer_done2        <= transfer_done_int(2);
transfer_done3        <= transfer_done_int(3);

xdone0 : LUT2 generic map (INIT => x"e") 
port map (
          O  => transfer_done_int(0),
          I0 => transfer_done0_clk90,
          I1 => transfer_done0_clk270
         );

xdone1 : LUT2 generic map (INIT => x"e") 
port map (
          O  => transfer_done_int(1),
          I0 => transfer_done1_clk90,
          I1 => transfer_done1_clk270
         );
                      
xdone2 : LUT2 generic map (INIT => x"e")  
port map (
          O  => transfer_done_int(2),
          I0 => transfer_done2_clk90,
          I1 => transfer_done2_clk270
         ); 
                      
xdone3 : LUT2 generic map (INIT => x"e")  
port map (
          O  => transfer_done_int(3),
          I0 => transfer_done3_clk90,
          I1 => transfer_done3_clk270
         );                                           

xdone0_clk0 : FDR port map (
                             Q   => transfer_done0_clk0,     
                             C   => clk0,
                             R   => sync_rst_xdone0_ck0,
                             D   => dqs_div
                            ); 
                            
xdone0_clk90 : FDR port map (
                               Q   => transfer_done0_clk90,     
                               C   => clk90,
                               R   => sync_rst_clk90,
                               D   => transfer_done0_clk0
                              );
                              
xdone0_clk180 : FDR port map (
                              Q   => transfer_done0_clk180,     
                              C   => clk180,
                              R   => sync_rst_xdone0_ck180,
                              D   => dqs_div
                             );  
                             
xdone0_clk270 : FDR  port map (
                               Q   => transfer_done0_clk270,     
                               C   => clk270,
                               R   => sync_rst_clk270,
                               D   => transfer_done0_clk180
                              ); 
                              
xdone0_rst90 : LUT3 generic map (INIT => x"fe")
                   port map (                      
                             O  => sync_rst_clk90,   
                             I0 => reset90,     
                             I1 => transfer_done0_clk270,
                             I2 => transfer_done0_clk90
                            );
                            
xdone0_rst270 : LUT3 generic map (INIT => x"fe")
                   port map (                      
                             O  => sync_rst_clk270,   
                             I0 => reset270,     
                             I1 => transfer_done0_clk270,
                             I2 => transfer_done0_clk90
                            );                                                       
                            
xdone1_clk90 : FD  port map (
                             Q   => transfer_done1_clk90,     
                             C   => clk90,
                             D   => transfer_done0_clk270
                            );
                            
xdone1_clk270 : FD port map (
                             Q   => transfer_done1_clk270,     
                             C   => clk270,
                             D   => transfer_done0_clk90
                            );                            
                            
xdone2_clk90 : FD  port map (
                             Q   => transfer_done2_clk90,     
                             C   => clk90,
                             D   => transfer_done1_clk270
                            );
                            
xdone2_clk270 : FD port map (
                             Q   => transfer_done2_clk270,     
                             C   => clk270,
                             D   => transfer_done1_clk90
                            );                            
                            
xdone3_clk90 : FD port map (
                             Q   => transfer_done3_clk90,     
                             C   => clk90,
                             D   => transfer_done2_clk270
                            ); 
                            
xdone3_clk270 : FD port map (
                             Q   => transfer_done3_clk270,     
                             C   => clk270,
                             D   => transfer_done2_clk90
                            );                                                                                   

end ddr2_transfer_done_arch;

