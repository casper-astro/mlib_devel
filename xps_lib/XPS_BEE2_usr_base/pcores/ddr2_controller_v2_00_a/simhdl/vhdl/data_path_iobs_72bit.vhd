--******************************************************************************
--
--  Xilinx, Inc. 2002                 www.xilinx.com
--
--  XAPP 253 - Synthesizable DDR SDRAM Controller
--
--*******************************************************************************
--
--  File name :       data_path_iobs.vhd
--
--  Description :     All the inputs and outputs related to data path module 
--                    are declared here. The outputs and inputs are 
--                    registered within the IOB's.                   
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
--
-- pragma translate_off
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
-- pragma translate_on
--
entity   data_path_iobs_72bit  is
port(
    clk               : in std_logic;
    dqs_reset         : in std_logic;
    dqs_enable        : in std_logic;
    ddr_dqs           : inout std_logic_vector(8 downto 0);
    ddr_dq            : inout std_logic_vector(71 downto 0);
    write_data_falling: in std_logic_vector(71 downto 0);
    write_data_rising : in std_logic_vector(71 downto 0);
    write_en_val      : in std_logic;
    clk90             : in std_logic;
    reset270_r        : in std_logic;
    data_mask_f       : in std_logic_vector(8 downto 0);
    data_mask_r       : in std_logic_vector(8 downto 0);
    dqs_int_delay_in0 : out std_logic;
    dqs_int_delay_in1 : out std_logic;
    dqs_int_delay_in2 : out std_logic;
    dqs_int_delay_in3 : out std_logic;
    dqs_int_delay_in4 : out std_logic;
    dqs_int_delay_in5 : out std_logic;
    dqs_int_delay_in6 : out std_logic;
    dqs_int_delay_in7 : out std_logic;
    dqs_int_delay_in8 : out std_logic;
    dq                : out std_logic_vector(71 downto 0);
    ddr_dm            : out std_logic_vector(8 downto 0)
);
end   data_path_iobs_72bit;  


architecture   arc_data_path_iobs_72bit of   data_path_iobs_72bit    is


component ddr_dqs_iob
port(
     clk            : in std_logic;
     ddr_dqs_reset  : in std_logic;
     ddr_dqs_enable : in std_logic;
     ddr_dqs        : inout std_logic;
     dqs            : out std_logic
     );
end component;

component ddr_dq_iob
port (
      ddr_dq_inout       : inout std_logic; --Bi-directional SDRAM data bus
      write_data_falling : in std_logic;    --Transmit data, output on falling edge
      write_data_rising  : in std_logic;    --Transmit data, output on rising edge
      read_data_in       : out std_logic;   -- Received data
      clk90              : in std_logic;    --Clock 90
      write_en_val       : in std_logic;    --Transmit enable
      reset              : in std_logic); 
end component;


component	ddr2_dm_72bit 
port (                                                
      ddr_dm       : out std_logic_vector(8 downto 0);
      mask_falling : in std_logic_vector(8 downto 0); 
      mask_rising  : in std_logic_vector(8 downto 0); 
      write_en_val : in std_logic;
      clk90        : in std_logic    --Clock 90                          
      );                                              
end component; 


component IOBUF_SSTL2_II
port (
       I  : in std_logic;
       T  : in std_logic;
       IO : inout std_logic;
       O  : out std_logic);
end component;

component FD
   port(
      Q                              :  out   STD_LOGIC;
      D                              :  in    STD_LOGIC;
      C                              :  in    STD_LOGIC);
end component;

component OBUF
 port (
   O : out std_logic;
   I : in std_logic);
 end component;



begin

  
--***********************************************************************
-- DQS IOB instantiations
--***********************************************************************

 ddr_dqs_iob0 : ddr_dqs_iob port map (
                              clk            => clk,
                              ddr_dqs_reset  => dqs_reset,
                              ddr_dqs_enable => dqs_enable,
                              ddr_dqs        => ddr_dqs(0),
                              dqs            => dqs_int_delay_in0
                             );
                             
 ddr_dqs_iob1 : ddr_dqs_iob port map (
                              clk            => clk,
                              ddr_dqs_reset  => dqs_reset,
                              ddr_dqs_enable => dqs_enable,
                              ddr_dqs        => ddr_dqs(1),
                              dqs            => dqs_int_delay_in1
                             );
                             
 ddr_dqs_iob2 : ddr_dqs_iob port map (
                              clk            => clk,
                              ddr_dqs_reset  => dqs_reset,
                              ddr_dqs_enable => dqs_enable,
                              ddr_dqs        => ddr_dqs(2),
                              dqs            => dqs_int_delay_in2
                             );
                             
 ddr_dqs_iob3 : ddr_dqs_iob port map (
                              clk            => clk,
                              ddr_dqs_reset  => dqs_reset,
                              ddr_dqs_enable => dqs_enable,
                              ddr_dqs        => ddr_dqs(3),
                              dqs            => dqs_int_delay_in3
                             );
                             
 ddr_dqs_iob4 : ddr_dqs_iob port map (
                              clk            => clk,
                              ddr_dqs_reset  => dqs_reset,
                              ddr_dqs_enable => dqs_enable,
                              ddr_dqs        => ddr_dqs(4),
                              dqs            => dqs_int_delay_in4
                             );
                             
 ddr_dqs_iob5 : ddr_dqs_iob port map (
                              clk            => clk,
                              ddr_dqs_reset  => dqs_reset,
                              ddr_dqs_enable => dqs_enable,
                              ddr_dqs        => ddr_dqs(5),
                              dqs            => dqs_int_delay_in5
                             );
                             
 ddr_dqs_iob6 : ddr_dqs_iob port map (
                              clk            => clk,
                              ddr_dqs_reset  => dqs_reset,
                              ddr_dqs_enable => dqs_enable,
                              ddr_dqs        => ddr_dqs(6),
                              dqs            => dqs_int_delay_in6
                             );
                             
 ddr_dqs_iob7 : ddr_dqs_iob port map (
                              clk            => clk,
                              ddr_dqs_reset  => dqs_reset,
                              ddr_dqs_enable => dqs_enable,
                              ddr_dqs        => ddr_dqs(7),
                              dqs            => dqs_int_delay_in7
                             );
                             
 ddr_dqs_iob8 : ddr_dqs_iob port map (
                              clk            => clk,
                              ddr_dqs_reset  => dqs_reset,
                              ddr_dqs_enable => dqs_enable,
                              ddr_dqs        => ddr_dqs(8),
                              dqs            => dqs_int_delay_in8
                              );
--***********************************************************************
-- Dq IOB instantiations
--***********************************************************************                            );

ddr_dq_iob0 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(0),
                                     write_data_rising  => write_data_rising(0),
                                     write_data_falling => write_data_falling(0),
                                     read_data_in       => dq(0),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob1 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(1),
                                     write_data_rising  => write_data_rising(1),
                                     write_data_falling => write_data_falling(1),
                                     read_data_in       => dq(1),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob2 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(2),
                                     write_data_rising  => write_data_rising(2),
                                     write_data_falling => write_data_falling(2),
                                     read_data_in       => dq(2),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob3 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(3),
                                     write_data_rising  => write_data_rising(3),
                                     write_data_falling => write_data_falling(3),
                                     read_data_in       => dq(3),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob4 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(4),
                                     write_data_rising  => write_data_rising(4),
                                     write_data_falling => write_data_falling(4),
                                     read_data_in       => dq(4),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob5 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(5),
                                     write_data_rising  => write_data_rising(5),
                                     write_data_falling => write_data_falling(5),
                                     read_data_in       => dq(5),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob6 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(6),
                                     write_data_rising  => write_data_rising(6),
                                     write_data_falling => write_data_falling(6),
                                     read_data_in       => dq(6),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob7 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(7),
                                     write_data_rising  => write_data_rising(7),
                                     write_data_falling => write_data_falling(7),
                                     read_data_in       => dq(7),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob8 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(8),
                                     write_data_rising  => write_data_rising(8),
                                     write_data_falling => write_data_falling(8),
                                     read_data_in       => dq(8),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob9 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(9),
                                     write_data_rising  => write_data_rising(9),
                                     write_data_falling => write_data_falling(9),
                                     read_data_in       => dq(9),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob10 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(10),
                                     write_data_rising  => write_data_rising(10),
                                     write_data_falling => write_data_falling(10),
                                     read_data_in       => dq(10),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob11 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(11),
                                     write_data_rising  => write_data_rising(11),
                                     write_data_falling => write_data_falling(11),
                                     read_data_in       => dq(11),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob12 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(12),
                                     write_data_rising  => write_data_rising(12),
                                     write_data_falling => write_data_falling(12),
                                     read_data_in       => dq(12),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob13 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(13),
                                     write_data_rising  => write_data_rising(13),
                                     write_data_falling => write_data_falling(13),
                                     read_data_in       => dq(13),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob14 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(14),
                                     write_data_rising  => write_data_rising(14),
                                     write_data_falling => write_data_falling(14),
                                     read_data_in       => dq(14),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob15 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(15),
                                     write_data_rising  => write_data_rising(15),
                                     write_data_falling => write_data_falling(15),
                                     read_data_in       => dq(15),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob16 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(16),
                                     write_data_rising  => write_data_rising(16),
                                     write_data_falling => write_data_falling(16),
                                     read_data_in       => dq(16),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob17 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(17),
                                     write_data_rising  => write_data_rising(17),
                                     write_data_falling => write_data_falling(17),
                                     read_data_in       => dq(17),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob18 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(18),
                                     write_data_rising  => write_data_rising(18),
                                     write_data_falling => write_data_falling(18),
                                     read_data_in       => dq(18),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob19 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(19),
                                     write_data_rising  => write_data_rising(19),
                                     write_data_falling => write_data_falling(19),
                                     read_data_in       => dq(19),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob20 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(20),
                                     write_data_rising  => write_data_rising(20),
                                     write_data_falling => write_data_falling(20),
                                     read_data_in       => dq(20),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob21 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(21),
                                     write_data_rising  => write_data_rising(21),
                                     write_data_falling => write_data_falling(21),
                                     read_data_in       => dq(21),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob22 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(22),
                                     write_data_rising  => write_data_rising(22),
                                     write_data_falling => write_data_falling(22),
                                     read_data_in       => dq(22),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob23 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(23),
                                     write_data_rising  => write_data_rising(23),
                                     write_data_falling => write_data_falling(23),
                                     read_data_in       => dq(23),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob24 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(24),
                                     write_data_rising  => write_data_rising(24),
                                     write_data_falling => write_data_falling(24),
                                     read_data_in       => dq(24),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob25 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(25),
                                     write_data_rising  => write_data_rising(25),
                                     write_data_falling => write_data_falling(25),
                                     read_data_in       => dq(25),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob26 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(26),
                                     write_data_rising  => write_data_rising(26),
                                     write_data_falling => write_data_falling(26),
                                     read_data_in       => dq(26),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob27 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(27),
                                     write_data_rising  => write_data_rising(27),
                                     write_data_falling => write_data_falling(27),
                                     read_data_in       => dq(27),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob28 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(28),
                                     write_data_rising  => write_data_rising(28),
                                     write_data_falling => write_data_falling(28),
                                     read_data_in       => dq(28),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob29 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(29),
                                     write_data_rising  => write_data_rising(29),
                                     write_data_falling => write_data_falling(29),
                                     read_data_in       => dq(29),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob30 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(30),
                                     write_data_rising  => write_data_rising(30),
                                     write_data_falling => write_data_falling(30),
                                     read_data_in       => dq(30),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob31 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(31),
                                     write_data_rising  => write_data_rising(31),
                                     write_data_falling => write_data_falling(31),
                                     read_data_in       => dq(31),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob32 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(32),
                                     write_data_rising  => write_data_rising(32),
                                     write_data_falling => write_data_falling(32),
                                     read_data_in       => dq(32),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob33 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(33),
                                     write_data_rising  => write_data_rising(33),
                                     write_data_falling => write_data_falling(33),
                                     read_data_in       => dq(33),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob34 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(34),
                                     write_data_rising  => write_data_rising(34),
                                     write_data_falling => write_data_falling(34),
                                     read_data_in       => dq(34),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob35 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(35),
                                     write_data_rising  => write_data_rising(35),
                                     write_data_falling => write_data_falling(35),
                                     read_data_in       => dq(35),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob36 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(36),
                                     write_data_rising  => write_data_rising(36),
                                     write_data_falling => write_data_falling(36),
                                     read_data_in       => dq(36),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob37 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(37),
                                     write_data_rising  => write_data_rising(37),
                                     write_data_falling => write_data_falling(37),
                                     read_data_in       => dq(37),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob38 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(38),
                                     write_data_rising  => write_data_rising(38),
                                     write_data_falling => write_data_falling(38),
                                     read_data_in       => dq(38),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob39 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(39),
                                     write_data_rising  => write_data_rising(39),
                                     write_data_falling => write_data_falling(39),
                                     read_data_in       => dq(39),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob40 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(40),
                                     write_data_rising  => write_data_rising(40),
                                     write_data_falling => write_data_falling(40),
                                     read_data_in       => dq(40),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob41 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(41),
                                     write_data_rising  => write_data_rising(41),
                                     write_data_falling => write_data_falling(41),
                                     read_data_in       => dq(41),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob42 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(42),
                                     write_data_rising  => write_data_rising(42),
                                     write_data_falling => write_data_falling(42),
                                     read_data_in       => dq(42),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob43 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(43),
                                     write_data_rising  => write_data_rising(43),
                                     write_data_falling => write_data_falling(43),
                                     read_data_in       => dq(43),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob44 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(44),
                                     write_data_rising  => write_data_rising(44),
                                     write_data_falling => write_data_falling(44),
                                     read_data_in       => dq(44),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob45 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(45),
                                     write_data_rising  => write_data_rising(45),
                                     write_data_falling => write_data_falling(45),
                                     read_data_in       => dq(45),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob46 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(46),
                                     write_data_rising  => write_data_rising(46),
                                     write_data_falling => write_data_falling(46),
                                     read_data_in       => dq(46),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob47 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(47),
                                     write_data_rising  => write_data_rising(47),
                                     write_data_falling => write_data_falling(47),
                                     read_data_in       => dq(47),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob48 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(48),
                                     write_data_rising  => write_data_rising(48),
                                     write_data_falling => write_data_falling(48),
                                     read_data_in       => dq(48),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob49 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(49),
                                     write_data_rising  => write_data_rising(49),
                                     write_data_falling => write_data_falling(49),
                                     read_data_in       => dq(49),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob50 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(50),
                                     write_data_rising  => write_data_rising(50),
                                     write_data_falling => write_data_falling(50),
                                     read_data_in       => dq(50),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob51 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(51),
                                     write_data_rising  => write_data_rising(51),
                                     write_data_falling => write_data_falling(51),
                                     read_data_in       => dq(51),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob52 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(52),
                                     write_data_rising  => write_data_rising(52),
                                     write_data_falling => write_data_falling(52),
                                     read_data_in       => dq(52),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob53 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(53),
                                     write_data_rising  => write_data_rising(53),
                                     write_data_falling => write_data_falling(53),
                                     read_data_in       => dq(53),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob54 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(54),
                                     write_data_rising  => write_data_rising(54),
                                     write_data_falling => write_data_falling(54),
                                     read_data_in       => dq(54),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob55 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(55),
                                     write_data_rising  => write_data_rising(55),
                                     write_data_falling => write_data_falling(55),
                                     read_data_in       => dq(55),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob56 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(56),
                                     write_data_rising  => write_data_rising(56),
                                     write_data_falling => write_data_falling(56),
                                     read_data_in       => dq(56),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob57 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(57),
                                     write_data_rising  => write_data_rising(57),
                                     write_data_falling => write_data_falling(57),
                                     read_data_in       => dq(57),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob58 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(58),
                                     write_data_rising  => write_data_rising(58),
                                     write_data_falling => write_data_falling(58),
                                     read_data_in       => dq(58),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob59 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(59),
                                     write_data_rising  => write_data_rising(59),
                                     write_data_falling => write_data_falling(59),
                                     read_data_in       => dq(59),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob60 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(60),
                                     write_data_rising  => write_data_rising(60),
                                     write_data_falling => write_data_falling(60),
                                     read_data_in       => dq(60),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob61 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(61),
                                     write_data_rising  => write_data_rising(61),
                                     write_data_falling => write_data_falling(61),
                                     read_data_in       => dq(61),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob62 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(62),
                                     write_data_rising  => write_data_rising(62),
                                     write_data_falling => write_data_falling(62),
                                     read_data_in       => dq(62),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob63 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(63),
                                     write_data_rising  => write_data_rising(63),
                                     write_data_falling => write_data_falling(63),
                                     read_data_in       => dq(63),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob64 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(64),
                                     write_data_rising  => write_data_rising(64),
                                     write_data_falling => write_data_falling(64),
                                     read_data_in       => dq(64),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob65 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(65),
                                     write_data_rising  => write_data_rising(65),
                                     write_data_falling => write_data_falling(65),
                                     read_data_in       => dq(65),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob66 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(66),
                                     write_data_rising  => write_data_rising(66),
                                     write_data_falling => write_data_falling(66),
                                     read_data_in       => dq(66),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob67 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(67),
                                     write_data_rising  => write_data_rising(67),
                                     write_data_falling => write_data_falling(67),
                                     read_data_in       => dq(67),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob68 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(68),
                                     write_data_rising  => write_data_rising(68),
                                     write_data_falling => write_data_falling(68),
                                     read_data_in       => dq(68),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob69 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(69),
                                     write_data_rising  => write_data_rising(69),
                                     write_data_falling => write_data_falling(69),
                                     read_data_in       => dq(69),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob70 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(70),
                                     write_data_rising  => write_data_rising(70),
                                     write_data_falling => write_data_falling(70),
                                     read_data_in       => dq(70),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );

ddr_dq_iob71 : ddr_dq_iob port map( 
                                     ddr_dq_inout       => ddr_dq(71),
                                     write_data_rising  => write_data_rising(71),
                                     write_data_falling => write_data_falling(71),
                                     read_data_in       => dq(71),
                                     clk90              => clk90,
                                     write_en_val       => write_en_val,
                                     reset              => reset270_r
                                     );


--***********************************************************************
--  DM IOB instantiations
--***********************************************************************  


ddr2_dm0	:	ddr2_dm_72bit	port	map	( 
                             ddr_dm       => ddr_dm(8 downto 0),
                             mask_falling => data_mask_f(8 downto 0),
                             mask_rising  => data_mask_r(8 downto 0),
                             write_en_val => write_en_val,
                             clk90        => clk90
                            );    


end   arc_data_path_iobs_72bit;  
         
 




   
