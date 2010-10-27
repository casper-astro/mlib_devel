library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--library synplify; 
--use synplify.attributes.all; 

-- pragma translate_off
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
-- pragma translate_on

entity ddr2_dqbit is

  port (
        reset                : in std_logic;         
        dqs                  : in std_logic;
        dqs1                 : in std_logic;        
        dqs_div_1            : in std_logic;
        dqs_div_2            : in std_logic;
        dq                   : in std_logic;
        fbit_0               : out std_logic;
        fbit_1               : out std_logic;
        fbit_2               : out std_logic;
        fbit_3               : out std_logic
       );
--attribute syn_noclockbuf : boolean;       
--attribute syn_noclockbuf of dqs : signal is true;                   
--attribute syn_noclockbuf of dqs1 : signal is true;                   
end ddr2_dqbit;

architecture ddr2_dqbit_arch of ddr2_dqbit is       

  component FDCE
    port(
      Q                              :	out   STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      CE                             :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC     
      );
  end component;




signal fbit      : std_logic_vector(3 downto 0);
signal async_clr : std_logic;
signal dqsn      : std_logic;
signal dqs_div2n : std_logic;
signal dqs_div1n : std_logic; 

begin

--resetn    <= not reset; 
async_clr  <= reset;  --(not resetn); --  or (not rd_cmd)   
dqsn       <= not dqs;
dqs_div2n  <= not dqs_div_2;
dqs_div1n  <= not dqs_div_1;
fbit_0     <= fbit(0);
fbit_1     <= fbit(1);
fbit_2     <= fbit(2);
fbit_3     <= fbit(3);


-- Read data from memory is first registered in CLB ff using delayed strobe from memory
-- A data bit from data words 0, 1, 2, and 3

fbit0 : FDCE port map (
                      Q   => fbit(0),
                      C   => dqs1,
                      CE  => dqs_div2n,
                      CLR => async_clr,
                      D   => dq
                     );

fbit1 : FDCE port map (
                      Q   => fbit(1),
                      C   => dqsn,
                      CE  => dqs_div_2,
                      CLR => async_clr,
                      D   => dq
                     );
                     
fbit2 : FDCE port map (
                       Q   => fbit(2),
                       C   => dqs1,
                       CE  => dqs_div_2,
                       CLR => async_clr,
                       D   => dq
                      );
                      
fbit3 : FDCE port map (
                       Q   => fbit(3),
                       C   => dqsn,
                       CE  => dqs_div_1,
                       CLR => async_clr,
                       D   => dq
                      );                                            
  

end ddr2_dqbit_arch;

