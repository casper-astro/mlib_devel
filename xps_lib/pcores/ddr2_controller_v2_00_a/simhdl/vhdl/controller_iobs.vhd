library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.parameter.all;
--
-- pragma translate_off
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
-- pragma translate_on
--
entity controller_iobs is
port(
	clk0                : in  std_logic;
	clk90               : in  std_logic;
	ddr_rasb            : in  std_logic;
	ddr_casb            : in  std_logic;
	ddr_web             : in  std_logic;
	ddr_cke             : in  std_logic;
	ddr_csb             : in  std_logic_vector(1 downto 0);
	ddr_ODT             : in  std_logic_vector(1 downto 0);
	ddr_address         : in  std_logic_vector((row_address_p -1) downto 0);
	ddr_ba              : in  std_logic_vector((bank_address_p -1) downto 0);
	ddr_rst_dqs_div_out : in  std_logic;
	ddr_rst_dqs_div_in  : out std_logic;
	ddr_force_nop       : in  std_logic;
	ddr_rasb_init       : in  std_logic;
	ddr_casb_init       : in  std_logic;
	ddr_web_init        : in  std_logic;
	ddr_ba_init         : in  std_logic_vector((bank_address_p-1) downto 0);
	ddr_address_init    : in  std_logic_vector((row_address_p-1) downto 0);
	ddr_csb_init        : in  std_logic_vector(1 downto 0);
	pad_rasb            : out std_logic;
	pad_casb            : out std_logic;
	pad_web             : out std_logic;
	pad_ba              : out std_logic_vector((bank_address_p -1) downto 0);
	pad_address         : out std_logic_vector((row_address_p -1) downto 0);
	pad_cke             : out std_logic;
	pad_csb             : out std_logic_vector(1 downto 0);
	pad_ODT             : out std_logic_vector(1 downto 0);
	pad_rst_dqs_div_out : out std_logic;
	pad_rst_dqs_div_in  : in std_logic
   
);
end controller_iobs;


architecture arc_controller_iobs of controller_iobs is

attribute xc_props : string;
attribute syn_keep : boolean;

component FD
   port(
      Q                              :  out   STD_LOGIC;
      D                              :  in    STD_LOGIC;
      C                              :  in    STD_LOGIC);
end component;

component FDS
   port(
      Q                              :  out   STD_LOGIC;
      D                              :  in    STD_LOGIC;
      C                              :  in    STD_LOGIC;
      S                              :  in    STD_LOGIC);
end component;

component FDR
   port(
      Q                              :  out   STD_LOGIC;
      D                              :  in    STD_LOGIC;
      C                              :  in    STD_LOGIC;
      R                              :  in    STD_LOGIC);
end component;

component FDRS
   port(
      Q                              :  out   STD_LOGIC;
      D                              :  in    STD_LOGIC;
      C                              :  in    STD_LOGIC;
      S                              :  in    STD_LOGIC;
      R                              :  in    STD_LOGIC);
end component;

component IBUF
 port (
   I : in std_logic;
   O : out std_logic);
 end component;

component OBUF
 port (
   O : out std_logic;
   I : in std_logic);
 end component;


---- **************************************************
---- iob attributes for instantiated FD components
---- **************************************************

signal clk180              : std_logic;
signal clk270              : std_logic;
signal GND                 : std_logic;
signal buf_rasb            : std_logic;
signal buf_casb            : std_logic;
signal buf_web             : std_logic;
signal buf_ba              : std_logic_vector((bank_address_p -1) downto 0);
signal buf_address         : std_logic_vector((row_address_p -1) downto 0);
signal buf_cke             : std_logic;
signal buf_csb             : std_logic_vector(1 downto 0);
signal buf_ODT             : std_logic_vector(1 downto 0);
signal buf_rst_dqs_div_out : std_logic;
signal buf_rst_dqs_div_in  : std_logic;
signal ddr_rasb_reset      : std_logic;
signal ddr_casb_reset      : std_logic;
signal ddr_web_reset       : std_logic;
signal ddr_ba_set          : std_logic_vector((bank_address_p-1) downto 0);
signal ddr_address_set     : std_logic_vector((row_address_p-1) downto 0);
signal ddr_csb_reset       : std_logic_vector(1 downto 0);
signal ddr_csb_set         : std_logic_vector(1 downto 0);

attribute xc_props of iob_web              : label is "IOB=TRUE";
attribute syn_keep of iob_web              : label is true; 
attribute xc_props of iob_rasb             : label is "IOB=TRUE";
attribute syn_keep of iob_rasb             : label is true; 
attribute xc_props of iob_casb             : label is "IOB=TRUE";
attribute syn_keep of iob_casb             : label is true; 
attribute xc_props of iob_csb0             : label is "IOB=TRUE";
attribute syn_keep of iob_csb0             : label is true; 
attribute xc_props of iob_csb1             : label is "IOB=TRUE";
attribute syn_keep of iob_csb1             : label is true; 
attribute xc_props of iob_cke              : label is "IOB=TRUE";
attribute syn_keep of iob_cke              : label is true; 
attribute xc_props of iob_ODT0             : label is "IOB=TRUE";
attribute syn_keep of iob_ODT0             : label is true; 
attribute xc_props of iob_ODT1             : label is "IOB=TRUE";
attribute syn_keep of iob_ODT1             : label is true; 
attribute xc_props of iob_rst_dqs_div_out  : label is "IOB=TRUE";
attribute syn_keep of iob_rst_dqs_div_out  : label is true; 
attribute syn_keep of clk180 : signal is true; 
attribute syn_keep of clk270 : signal is true; 

begin

clk180 <= not clk0;
clk270 <= not clk90;
GND <= '0';

---- ******************************************* ----
----           control signals set/reset         ----
---- ******************************************* ----

ddr_rasb_reset   <= not ddr_rasb_init;
ddr_casb_reset   <= not ddr_casb_init;
ddr_web_reset    <= not ddr_web_init;
ddr_ba_set       <= ddr_ba_init;
ddr_address_set  <= ddr_address_init;
ddr_csb_reset    <= not ddr_csb_init;
ddr_csb_set      <= ddr_force_nop & ddr_force_nop;

---- ******************************************* ----
----            FD for control signals           ----
---- ******************************************* ----

iob_web : FDR port map (
                         Q    => buf_web,
                         D    => ddr_web,
                         R    => ddr_web_reset,
                         C    => clk180);
                         
iob_rasb : FDR port map (
                         Q    => buf_rasb,
                         D    => ddr_rasb,
                         R    => ddr_rasb_reset,
                         C    => clk180);
                         
iob_casb : FDR port map (
                         Q    => buf_casb,
                         D    => ddr_casb,
                         R    => ddr_casb_reset,
                         C    => clk180);

iob_csb0 : FDRS port map (
                         Q    => buf_csb(0),
                         D    => ddr_csb(0),
                         R    => ddr_csb_reset(0),
                         S    => ddr_csb_set(0),
                         C    => clk180);

iob_csb1 : FDRS port map (
                         Q    => buf_csb(1),
                         D    => ddr_csb(1),
                         R    => ddr_csb_reset(1),
                         S    => ddr_csb_set(1),
                         C    => clk180);

iob_cke : FD port map (
                         Q    => buf_cke,
                         D    => ddr_cke,
                         C    => clk180);

iob_ODT0 : FD port map (
                         Q    => buf_ODT(0),
                         D    => ddr_ODT(0),
                         C    => clk180);

iob_ODT1 : FD port map (
                         Q    => buf_ODT(1),
                         D    => ddr_ODT(1),
                         C    => clk180);

iob_rst_dqs_div_out : FD port map (
                         Q    => buf_rst_dqs_div_out,
                         D    => ddr_rst_dqs_div_out,
                         C    => clk180);

---- ******************************************* ----
----            FD for addresses                 ----
---- ******************************************* ----

gen_iob_address: for bit_index in 0 to (row_address_p-1) generate
		attribute xc_props of iob_address: label is "IOB=TRUE";
	begin
		iob_address: FDS port map ( 
               Q => buf_address(bit_index),
               D => ddr_address(bit_index),
               S => ddr_address_set(bit_index),
               C => clk180
                );
    end generate;

gen_iob_ba: for bit_index in 0 to (bank_address_p-1) generate
		attribute xc_props of iob_ba: label is "IOB=TRUE";
	begin
		iob_ba: FDS port map ( 
               Q => buf_ba(bit_index),
               D => ddr_ba(bit_index),
               S => ddr_ba_set(bit_index),
               C => clk180
                );
    end generate;
                                                        
---- ************************************* ----
----  Output buffers for control signals   ----
---- ************************************* ----

iobuf_web : OBUF port map (
                     I => buf_web,
                     O => pad_web);

iobuf_rasb : OBUF port map (
                     I => buf_rasb,
                     O => pad_rasb);

iobuf_casb : OBUF port map (
                     I => buf_casb,
                     O => pad_casb);

iobuf_cke : OBUF port map (
                     I => buf_cke,
                     O => pad_cke);

iobuf_csb0 : OBUF port map (
                     I => buf_csb(0),
                     O => pad_csb(0));

iobuf_csb1 : OBUF port map (
                     I => buf_csb(1),
                     O => pad_csb(1));

iobuf_ODT0 : OBUF port map (
                     I => buf_ODT(0),
                     O => pad_ODT(0));

iobuf_ODT1 : OBUF port map (
                     I => buf_ODT(1),
                     O => pad_ODT(1));

iobuf_rst_dqs_div_out : OBUF port map (
                     I => buf_rst_dqs_div_out,
                     O => pad_rst_dqs_div_out);

iobuf_rst_dqs_div_in : IBUF port map (
                     I => pad_rst_dqs_div_in,
                     O => buf_rst_dqs_div_in);

ddr_rst_dqs_div_in <= buf_rst_dqs_div_in;

---- ************************************* ----
----  Output buffers for address signals   ----
---- ************************************* ----

gen_iobuf_address: for i in (row_address_p -1) downto 0 generate
		iobuf_address:OBUF port map (
                     I => buf_address(i),
                     O => pad_address(i));
end generate;

gen_iobuf_ba: for i in (bank_address_p -1) downto 0 generate
		iobuf_ba:OBUF port map (
                     I => buf_ba(i),
                     O => pad_ba(i));
end generate;                     



end arc_controller_iobs;                
         
 




   

