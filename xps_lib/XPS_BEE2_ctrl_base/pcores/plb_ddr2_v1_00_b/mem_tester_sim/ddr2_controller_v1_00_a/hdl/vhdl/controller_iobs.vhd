--******************************************************************************
--
--  Xilinx, Inc. 2002                 www.xilinx.com
--
--  XAPP 253 - Synthesizable DDR SDRAM Controller
--
--*******************************************************************************
--
--  File name :       controller_iobs.vhd
--
--  Description :     
--                  All the IO's related to controller module are declared as
--                  IOBUF's in this module
--
--  Date - revision : 05/01/2002
--
--  Author :          Lakshmi Gopalakrishnan ( Modified by Sailaja)
--
--  Contact : e-mail  hotline@xilinx.com
--            phone   + 1 800 255 7778 
--
--  Disclaimer: LIMITED WARRANTY AND DISCLAMER. These designs are 
--              provided to you "as is". Xilinx and its licensors make and you 
--              receive no warranties or conditions, express, implied, 
--              statutory or otherwise, and Xilinx specifically disclaims any 
--              implied warranties of merchantability, non-infringement, or 
--              fitness for a particular purpose. Xilinx does not warrant that 
--              the functions contained in these designs will meet your 
--              requirements, or that the operation of these designs will be 
--              uninterrupted or error free, or that defects in the Designs 
--              will be corrected. Furthermore, Xilinx does not warrant or 
--              make any representations regarding use or the results of the 
--              use of the designs in terms of correctness, accuracy, 
--              reliability, or otherwise. 
--
--              LIMITATION OF LIABILITY. In no event will Xilinx or its 
--              licensors be liable for any loss of data, lost profits, cost 
--              or procurement of substitute goods or services, or for any 
--              special, incidental, consequential, or indirect damages 
--              arising from the use or operation of the designs or 
--              accompanying documentation, however caused and on any theory 
--              of liability. This limitation will apply even if Xilinx 
--              has been advised of the possibility of such damage. This 
--              limitation shall apply not-withstanding the failure of the 
--              essential purpose of any limited remedies herein. 
--
--  Copyright © 2002 Xilinx, Inc.
--  All rights reserved 
-- 
--*****************************************************************************
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
	clk0                : in std_logic;
	clk90               : in std_logic;
	ddr_rasb            : in std_logic;
	ddr_casb            : in std_logic;
	ddr_web             : in std_logic;
	ddr_cke             : in std_logic;
	ddr_csb             : in std_logic_vector(1 downto 0);
	ddr_ODT             : in std_logic_vector(1 downto 0);
	ddr_address         : in std_logic_vector((row_address_p -1) downto 0);
	ddr_ba              : in std_logic_vector((bank_address_p -1) downto 0);
	ddr_rst_dqs_div_out : in std_logic;
	ddr_rst_dqs_div_in  : out std_logic;
	ddr_force_nop       : in std_logic_vector(1 downto 0);
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
----            FD for control signals           ----
---- ******************************************* ----
           
iob_web : FD port map (
                         Q    => buf_web,
                         D    => ddr_web,
                         C    => clk180);
                         
iob_rasb : FD port map (
                         Q    => buf_rasb,
                         D    => ddr_rasb,
                         C    => clk180);
                         
iob_casb : FD port map (
                         Q    => buf_casb,
                         D    => ddr_casb,
                         C    => clk180);

iob_csb0 : FDS port map (
                         Q    => buf_csb(0),
                         D    => ddr_csb(0),
                         S    => ddr_force_nop(0),
                         C    => clk180);

iob_csb1 : FDS port map (
                         Q    => buf_csb(1),
                         D    => ddr_csb(1),
                         S    => ddr_force_nop(1),
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
		iob_address: FD port map ( 
               Q => buf_address(bit_index),
               D => ddr_address(bit_index),
               C => clk180
                );
    end generate;

gen_iob_ba: for bit_index in 0 to (bank_address_p-1) generate
		attribute xc_props of iob_ba: label is "IOB=TRUE";
	begin
		iob_ba: FD port map ( 
               Q => buf_ba(bit_index),
               D => ddr_ba(bit_index),
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
         
 




   

