entity unisim_void is
end unisim_void;
--******************************************************************************
--
--  Xilinx, Inc. 2002                 www.xilinx.com
--
--
--*******************************************************************************
--
--  File name :       ddr2_dm.vhd
--
--  Description :     This module instantiates DDR IOB output flip-flops, and an
--                    output buffer for the data mask bits.
--
--  Date - revision : 07/31/2003
--
--  Author :          Maria George
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

-- pragma translate_off
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
-- pragma translate_on
--

entity   ddr2_dm_72bit  is
port (
      ddr_dm       : out std_logic_vector(8 downto 0);   --Data mask output
      mask_falling : in std_logic_vector(8 downto 0);    --Mask output on falling edge
      mask_rising  : in std_logic_vector(8 downto 0);    --Mask output on rising edge
      write_en_val : in std_logic;
      clk90        : in std_logic   --Clock 90
      );
end   ddr2_dm_72bit;

architecture   arc_ddr2_dm_72bit of   ddr2_dm_72bit    is

attribute syn_keep : boolean;

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
       I : in std_logic;
       O : out std_logic);
end component;





--***********************************************************************\
--     Internal signal declaration
--***********************************************************************/

signal mask_o         : std_logic_vector(8 downto 0);  -- Mask output intermediate signal
signal gnd            : std_logic;
signal vcc            : std_logic;
signal write_enable_n : std_logic;

signal clk270    : std_logic;

attribute syn_keep of clk270 : signal is true;

begin

gnd      <= '0';
vcc      <= '1';
clk270   <= not clk90;

-- delay and invert the enable signal

process(clk90)
begin
	if clk90'event and clk90 = '1' then
		write_enable_n <= not write_en_val;
	end if;
end process;

-- Data Mask Output during a write command

DDR_DM0_OUT : FDDRRSE port map (
                               Q  => mask_o(0),
                               C0 => clk270,
                               C1 => clk90,
                               CE => vcc,
                               D0 => mask_rising(0),
                               D1 => mask_falling(0),
                               R  => write_enable_n,
                               S  => gnd
                              );

DDR_DM1_OUT : FDDRRSE port map (
                               Q  => mask_o(1),
                               C0 => clk270,
                               C1 => clk90,
                               CE => vcc,
                               D0 => mask_rising(1),
                               D1 => mask_falling(1),
                               R  => write_enable_n,
                               S  => gnd
                              );

DDR_DM2_OUT : FDDRRSE port map (
                               Q  => mask_o(2),
                               C0 => clk270,
                               C1 => clk90,
                               CE => vcc,
                               D0 => mask_rising(2),
                               D1 => mask_falling(2),
                               R  => write_enable_n,
                               S  => gnd
                              );

DDR_DM3_OUT : FDDRRSE port map (
                               Q  => mask_o(3),
                               C0 => clk270,
                               C1 => clk90,
                               CE => vcc,
                               D0 => mask_rising(3),
                               D1 => mask_falling(3),
                               R  => write_enable_n,
                               S  => gnd
                              );

DDR_DM4_OUT : FDDRRSE port map (
                               Q  => mask_o(4),
                               C0 => clk270,
                               C1 => clk90,
                               CE => vcc,
                               D0 => mask_rising(4),
                               D1 => mask_falling(4),
                               R  => write_enable_n,
                               S  => gnd
                              );

DDR_DM5_OUT : FDDRRSE port map (
                               Q  => mask_o(5),
                               C0 => clk270,
                               C1 => clk90,
                               CE => vcc,
                               D0 => mask_rising(5),
                               D1 => mask_falling(5),
                               R  => write_enable_n,
                               S  => gnd
                              );

DDR_DM6_OUT : FDDRRSE port map (
                               Q  => mask_o(6),
                               C0 => clk270,
                               C1 => clk90,
                               CE => vcc,
                               D0 => mask_rising(6),
                               D1 => mask_falling(6),
                               R  => write_enable_n,
                               S  => gnd
                              );

DDR_DM7_OUT : FDDRRSE port map (
                               Q  => mask_o(7),
                               C0 => clk270,
                               C1 => clk90,
                               CE => vcc,
                               D0 => mask_rising(7),
                               D1 => mask_falling(7),
                               R  => write_enable_n,
                               S  => gnd
                              );


DDR_DM8_OUT : FDDRRSE port map (
                               Q  => mask_o(8),
                               C0 => clk270,
                               C1 => clk90,
                               CE => vcc,
                               D0 => mask_rising(8),
                               D1 => mask_falling(8),
                               R  => write_enable_n,
                               S  => gnd
                              );

DM0_OBUF : OBUF port map (
                         I => mask_o(0),
                         O => ddr_dm(0)
                        );

DM1_OBUF : OBUF port map (
                         I => mask_o(1),
                         O => ddr_dm(1)
                        );

DM2_OBUF : OBUF port map (
                         I => mask_o(2),
                         O => ddr_dm(2)
                        );

DM3_OBUF : OBUF port map (
                         I => mask_o(3),
                         O => ddr_dm(3)
                        );

DM4_OBUF : OBUF port map (
                         I => mask_o(4),
                         O => ddr_dm(4)
                        );

DM5_OBUF : OBUF port map (
                         I => mask_o(5),
                         O => ddr_dm(5)
                        );

DM6_OBUF : OBUF port map (
                         I => mask_o(6),
                         O => ddr_dm(6)
                        );

DM7_OBUF : OBUF port map (
                         I => mask_o(7),
                         O => ddr_dm(7)
                        );

DM8_OBUF : OBUF port map (
                         I => mask_o(8),
                         O => ddr_dm(8)
                        );

end   arc_ddr2_dm_72bit;


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

--******************************************************************************
--
--  Xilinx, Inc. 2002                 www.xilinx.com
--
--
--*******************************************************************************
--
--  File name :       ddr_dqs_iob.vhd
--
--  Description :     This module instantiates DDR IOB output flip-flops, an
--                    output buffer with registered tri-state, and an input buffer
--                    for a single strobe/dqs bit. The DDR IOB output flip-flops
--                    are used to forward strobe to memory during a write. During
--                    a read, the output of the IBUF is routed to the internal
--                    delay module, dqs_delay.
--
--  Date - revision : 07/28/2003
--
--  Author :          Maria George
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
--library synplify;
--use synplify.attributes.all;

--
-- pragma translate_off
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
-- pragma translate_on
--

entity ddr_dqs_iob is
port(
     clk            : in std_logic;
     ddr_dqs_reset  : in std_logic;
     ddr_dqs_enable : in std_logic;
     ddr_dqs        : inout std_logic;
     dqs            : out std_logic);
end ddr_dqs_iob;


architecture arc_ddr_dqs_iob of ddr_dqs_iob is
component FD
port( D : in std_logic;
      Q : out std_logic;
      C : in std_logic);
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

component OBUFT
port(
      I : in std_logic;
      T : in std_logic;
      O : out std_logic);
end component;

component IBUF_SSTL2_II
port(
      I : in std_logic;
      O : out std_logic);
end component;

attribute syn_keep : boolean;

signal dqs_q            : std_logic;
signal ddr_dqs_enable1  : std_logic;
signal vcc              : std_logic;
signal gnd              : std_logic;
signal ddr_dqs_enable_b : std_logic;
signal data1            : std_logic;
  signal clk180           : std_logic;

  attribute syn_keep of clk180 : signal is true;

begin

--***********************************************************************
--     Output DDR generation
--     This includes instantiation of the output DDR flip flop.
--     Additionally, to keep synthesis tools from register sharing, manually
--     instantiate the output tri-state flip-flop.
--***********************************************************************
vcc <= '1';
gnd <= '0';
ddr_dqs_enable_b <= not ddr_dqs_enable;
data1 <= '0' when ddr_dqs_reset = '1' else
         '1';

  clk180 <= not clk;

U1 : FD port map  ( D => ddr_dqs_enable_b,
                    Q => ddr_dqs_enable1,
                    C => clk);

U2 : FDDRRSE port map (  Q => dqs_q,
                        C0 => clk180,
                        C1 => clk,
                        CE => vcc,
                        D0 => gnd,
                        D1 => data1,
                         R => gnd,
                         S => gnd);
--***********************************************************************
--    IO buffer for dqs signal. Allows for distribution of dqs
--     to the data (DQ) loads.
--***********************************************************************
U3 : OBUFT  port map ( I => dqs_q,
                       T => ddr_dqs_enable1 ,
                       O => ddr_dqs);

U4 : IBUF_SSTL2_II port map ( I => ddr_dqs,
                              O => dqs);


end arc_ddr_dqs_iob;
--******************************************************************************
--
--  Xilinx, Inc. 2002                 www.xilinx.com
--
--
--*******************************************************************************
--
--  File name :       ddr_dq_iob.vhd
--
--  Description :     This module instantiates DDR IOB output flip-flops, an
--                    output buffer with registered tri-state, and an input buffer
--                    for a single data bit. The DDR input flip-flops are not used
--                    since data is captured in the CLB flip-flops.
--
--  Date - revision : 07/28/2003
--
--  Author :          Maria George
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
--library synplify;
--use synplify.attributes.all;
--
-- pragma translate_off
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
-- pragma translate_on
--

entity ddr_dq_iob is
port (
      ddr_dq_inout       : inout std_logic; --Bi-directional SDRAM data bus
      write_data_falling : in std_logic;    --Transmit data, output on falling edge
      write_data_rising  : in std_logic;    --Transmit data, output on rising edge
      write_en_val       : in std_logic;
      read_data_in       : out std_logic;   -- Received data
      clk90              : in std_logic;    --Clock 90
      reset              : in std_logic);
 --attribute xc_props of ddr_dq_inout : signal is "IOB=TRUE";
end ddr_dq_iob;

architecture arc_ddr_dq_iob of ddr_dq_iob is

attribute syn_keep : boolean;

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

component FDPE
port(
       D   : in std_logic;
       PRE : in std_logic;
       C   : in std_logic;
       Q   : out std_logic;
       CE  : in std_logic);
end component;

component OBUFT
port (
       I : in std_logic;
       T : in std_logic;
       O : out std_logic);
end component;

component IBUF
port (
       I : in std_logic;
       O : out std_logic);
end component;



--***********************************************************************\
--     Internal signal declaration
--***********************************************************************/

signal ddr_en       : std_logic;  -- Tri-state enable signal
signal ddr_dq_q     : std_logic;  -- Data output intermediate signal
signal ddr_dq_o     : std_logic;  -- Data output intermediate signal
signal GND          : std_logic;
signal clock_en     : std_logic := '1';
signal enable_b     : std_logic;
  signal clk270       : std_logic;

  attribute syn_keep of clk270  : signal is true;

begin

GND    <= '0';
enable_b <= not write_en_val;
  clk270   <= not clk90;
-- Transmission data path

DDR_OUT : FDDRRSE port map
            (Q  => ddr_dq_q,
             C0 => clk270,
             C1 => clk90,
             CE => clock_en,
             D0 => write_data_rising,
             D1 => write_data_falling,
             R  => GND,
             S  => GND);

DQ_T   :   FDPE port map
           ( D   => enable_b,
             PRE => reset,
             C   => clk270,
             Q   => ddr_en,
             CE  => clock_en);


DQ_OBUFT : OBUFT port map
             ( I => ddr_dq_q,
               T => ddr_en,
               O => ddr_dq_inout);

-- Receive data path

DQ_IBUF :  IBUF port map
             ( I => ddr_dq_inout,
               O => read_data_in);


 end arc_ddr_dq_iob;


--#############################################################################//
--         Internal dqs delay structure for ddr sdram controller               //
--#############################################################################//

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- pragma translate_off
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
-- pragma translate_on

entity dqs_delay is
              port (
		    clk_in   : in std_logic;
		    sel_in   : in std_logic_vector(4 downto 0);
		    clk_out  : out std_logic
		  );
end dqs_delay;

architecture arc_dqs_delay of dqs_delay is

begin

	clk_out <= clk_in after 1 ms;

end arc_dqs_delay;
library ieee;
use ieee.std_logic_1164.all;
--library synplify;
--use synplify.attributes.all;
-- pragma translate_off
library UNISIM;
 use UNISIM.VCOMPONENTS.ALL;
 -- pragma translate_on
package parameter is
  constant row_address_p   : INTEGER   := 14;
  constant column_address_p: INTEGER   := 10;
  constant bank_address_p  : INTEGER   :=  2;
end parameter;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--
-- pragma translate_off
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
-- pragma translate_on
--
entity r_w_dly is
 port(
      clk     : in std_logic;
      rst     : in std_logic;
      dly_inc : in std_logic;
      dly_tc  : out std_logic;
      r_w     : out std_logic
      );
end r_w_dly;

architecture arc_r_w_dly of r_w_dly is

signal delay_count : std_logic_vector(4 downto 0);
signal delay_tc    : std_logic;
signal read_write  : std_logic;

begin

       read_write_proc : process(clk)
	begin
	     if falling_edge(clk) then
		if (rst='1') then
		  read_write <= '0';
		else
		  if (delay_tc = '1') then
		    read_write <= not(read_write);
		  end if;
		end if;
	     end if;
	end process read_write_proc;

	delay_counter : process(clk)
	begin
	     if falling_edge(clk) then
		if (rst='1') then
		    delay_count <= "00000";
		else
		        if dly_inc = '1' then
			   delay_count <= delay_count + "0001" ;
                 	end if;
		end if;
	     end if;
	end process delay_counter;

	delay_tc_proc : process(clk)
	begin
	     if falling_edge(clk) then
		if (rst='1') then
			delay_tc <= '0';
		else
			if (delay_count="11000") then -- decimal 28??
				delay_tc <= '1';
			else
				delay_tc <= '0';
			end if;
		end if;
	     end if;
	end process delay_tc_proc;

dly_tc <= delay_tc;
r_w    <= read_write;

end arc_r_w_dly;
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







--******************************************************************************
--
--  Xilinx, Inc. 2002                 www.xilinx.com
--
--
--*******************************************************************************
--
--  File name :       data_path_rst.vhd
--
--  Description :     This module generates the reset signals for data read module
--
--  Date - revision : 10/16/2003
--
--  Author :          Maria George ( Modified by Padmaja Sannala)
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
--library synplify;
--use synplify.attributes.all;
--
-- pragma translate_off
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
-- pragma translate_on
--
entity data_path_rst is
port(
     clk                : in std_logic;
     clk90              : in std_logic;
     reset              : in std_logic;
     reset90            : in std_logic;
     reset180           : in std_logic;
     reset270           : in std_logic;
     reset_r            : out std_logic;
     reset90_r          : out std_logic;
     reset180_r         : out std_logic;
     reset270_r         : out std_logic
     );
end data_path_rst;

architecture arc_data_path_rst of data_path_rst is

attribute syn_keep : boolean;
  component FD
    port(
      Q                              : out STD_LOGIC;
      C                              : in STD_LOGIC;
      D                              : in STD_LOGIC
      );
  end component;



  signal clk180    : std_logic;
  signal clk270    : std_logic;


  attribute syn_keep of clk180 : signal is true;
  attribute syn_keep of clk270 : signal is true;
begin

-- ********************************
--  generation of clk180 and clk270
-- *********************************


   clk180 <= not clk;
   clk270 <= not clk90;





--***********************************************************************
-- Reset flip-flops
--***********************************************************************

rst0_r : FD port map (
                      Q => reset_r,
                      C => clk,
                      D => reset
                      );

rst90_r : FD port map (
                      Q => reset90_r,
                      C => clk90,
                      D => reset90
                      );

rst180_r : FD port map (
                      Q => reset180_r,
                      C => clk180,
                      D => reset180
                      );

rst270_r : FD port map (
                      Q => reset270_r,
                      C => clk270,
                      D => reset270
                      );


end arc_data_path_rst;


























































































































































































































































































































































































































































































































































































































































































































































--******************************************************************************
--
--  Xilinx, Inc. 2002                 www.xilinx.com
--
--
--*******************************************************************************
--
--  File name :       data_read.vhd
--
--  Description :     This module comprises the write and read data paths for the
--                    ddr2 memory interface. The read data is
--                    captured in CLB FFs and finally input to FIFOs.
--
--
--  Date - revision : 10/16/2003
--
--  Author :          Maria George (modified by Sailaja)
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
--library synplify;
--use synplify.attributes.all;
--
-- pragma translate_off
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
-- pragma translate_on
--
entity   data_read_72bit_rl  is
port(
     clk                : in std_logic;
     clk90              : in std_logic;
     reset90_r          : in std_logic;
     reset270_r         : in std_logic;
     dq                 : in std_logic_vector(71 downto 0);
     read_data_valid_1  : in std_logic;
     read_data_valid_2  : in std_logic;
     transfer_done_0    : in std_logic_vector(3 downto 0);
     transfer_done_1    : in std_logic_vector(3 downto 0);
     transfer_done_2    : in std_logic_vector(3 downto 0);
     transfer_done_3    : in std_logic_vector(3 downto 0);
     transfer_done_4    : in std_logic_vector(3 downto 0);
     transfer_done_5    : in std_logic_vector(3 downto 0);
     transfer_done_6    : in std_logic_vector(3 downto 0);
     transfer_done_7    : in std_logic_vector(3 downto 0);
     transfer_done_8    : in std_logic_vector(3 downto 0);
     fifo_00_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_01_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_02_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_03_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_10_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_11_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_12_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_13_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_20_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_21_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_22_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_23_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_30_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_31_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_32_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_33_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_40_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_41_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_42_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_43_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_50_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_51_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_52_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_53_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_60_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_61_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_62_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_63_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_70_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_71_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_72_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_73_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_80_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_81_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_82_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_83_wr_addr    : in std_logic_vector(3 downto 0);
     dqs_delayed_col0   : in std_logic_vector(8 downto 0);
     dqs_delayed_col1   : in std_logic_vector(8 downto 0);
     dqs_div_col0       : in std_logic_vector(8 downto 0);
     dqs_div_col1       : in std_logic_vector(8 downto 0);
     fifo_00_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_01_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_02_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_03_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_10_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_11_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_12_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_13_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_20_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_21_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_22_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_23_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_30_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_31_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_32_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_33_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_40_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_41_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_42_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_43_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_50_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_51_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_52_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_53_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_60_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_61_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_62_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_63_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_70_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_71_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_72_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_73_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_80_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_81_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_82_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_83_rd_addr    : in std_logic_vector(3 downto 0);
     next_state_val     : out std_logic;
     output_data_90     : out std_logic_vector(143 downto 0);
     data_valid_90      : out std_logic
     );
end   data_read_72bit_rl;

architecture   arc_data_read_72bit_rl of   data_read_72bit_rl    is

component RAM_8D
port(
     DPO   : out std_logic_vector(7 downto 0);
     A0    : in std_logic;
     A1    : in std_logic;
     A2    : in std_logic;
     A3    : in std_logic;
     D     : in std_logic_vector(7 downto 0);
     DPRA0 : in std_logic;
     DPRA1 : in std_logic;
     DPRA2 : in std_logic;
     DPRA3 : in std_logic;
     WCLK  : in std_logic;
     WE    : in std_logic
     );
end component;

component ddr2_dqbit
  port (
        reset               : in std_logic;
        dqs                 : in std_logic;
        dqs1                : in std_logic;
        dqs_div_1           : in std_logic;
        dqs_div_2           : in std_logic;
        dq                  : in std_logic;
        fbit_0              : out std_logic;
        fbit_1              : out std_logic;
        fbit_2              : out std_logic;
        fbit_3              : out std_logic
       );
end component;




signal fbit_0                 : std_logic_vector(71 downto 0);
signal fbit_1                 : std_logic_vector(71 downto 0);
signal fbit_2                 : std_logic_vector(71 downto 0);
signal fbit_3                 : std_logic_vector(71 downto 0);
signal fifo_00_data_out       : std_logic_vector(7 downto 0);
signal fifo_01_data_out       : std_logic_vector(7 downto 0);
signal fifo_02_data_out       : std_logic_vector(7 downto 0);
signal fifo_03_data_out       : std_logic_vector(7 downto 0);
signal fifo_10_data_out       : std_logic_vector(7 downto 0);
signal fifo_11_data_out       : std_logic_vector(7 downto 0);
signal fifo_12_data_out       : std_logic_vector(7 downto 0);
signal fifo_13_data_out       : std_logic_vector(7 downto 0);
signal fifo_20_data_out       : std_logic_vector(7 downto 0);
signal fifo_21_data_out       : std_logic_vector(7 downto 0);
signal fifo_22_data_out       : std_logic_vector(7 downto 0);
signal fifo_23_data_out       : std_logic_vector(7 downto 0);
signal fifo_30_data_out       : std_logic_vector(7 downto 0);
signal fifo_31_data_out       : std_logic_vector(7 downto 0);
signal fifo_32_data_out       : std_logic_vector(7 downto 0);
signal fifo_33_data_out       : std_logic_vector(7 downto 0);
signal fifo_40_data_out       : std_logic_vector(7 downto 0);
signal fifo_41_data_out       : std_logic_vector(7 downto 0);
signal fifo_42_data_out       : std_logic_vector(7 downto 0);
signal fifo_43_data_out       : std_logic_vector(7 downto 0);
signal fifo_50_data_out       : std_logic_vector(7 downto 0);
signal fifo_51_data_out       : std_logic_vector(7 downto 0);
signal fifo_52_data_out       : std_logic_vector(7 downto 0);
signal fifo_53_data_out       : std_logic_vector(7 downto 0);
signal fifo_60_data_out       : std_logic_vector(7 downto 0);
signal fifo_61_data_out       : std_logic_vector(7 downto 0);
signal fifo_62_data_out       : std_logic_vector(7 downto 0);
signal fifo_63_data_out       : std_logic_vector(7 downto 0);
signal fifo_70_data_out       : std_logic_vector(7 downto 0);
signal fifo_71_data_out       : std_logic_vector(7 downto 0);
signal fifo_72_data_out       : std_logic_vector(7 downto 0);
signal fifo_73_data_out       : std_logic_vector(7 downto 0);
signal fifo_80_data_out       : std_logic_vector(7 downto 0);
signal fifo_81_data_out       : std_logic_vector(7 downto 0);
signal fifo_82_data_out       : std_logic_vector(7 downto 0);
signal fifo_83_data_out       : std_logic_vector(7 downto 0);
signal next_state             : std_logic;

--signal user_output_data_1     : std_logic_vector(143 downto 0);



 begin

next_state_val <= next_state;

process(clk90)
begin
if clk90'event and clk90 = '1' then
 if reset90_r = '1' then
    next_state       <= '0';
    data_valid_90    <= '0';
 else
    -- make sure that data_valid default value is 0
    data_valid_90    <= '0';
    case next_state is

         when '0' =>
             if (read_data_valid_1 = '1') then
               next_state      <= '1';
               data_valid_90   <= '1';
               output_data_90  <= (
								fifo_81_data_out &
								fifo_71_data_out &
								fifo_61_data_out &
								fifo_51_data_out &
								fifo_41_data_out &
								fifo_31_data_out &
								fifo_21_data_out &
								fifo_11_data_out &
								fifo_01_data_out &
								fifo_80_data_out &
								fifo_70_data_out &
								fifo_60_data_out &
								fifo_50_data_out &
								fifo_40_data_out &
								fifo_30_data_out &
								fifo_20_data_out &
								fifo_10_data_out &
								fifo_00_data_out
               );




             else
               next_state      <= '0';
             end if;
         when '1' =>
             if (read_data_valid_2 = '1') then
               next_state     <= '0';
               data_valid_90  <= '1';
               output_data_90 <= (
								fifo_83_data_out &
								fifo_73_data_out &
								fifo_63_data_out &
								fifo_53_data_out &
								fifo_43_data_out &
								fifo_33_data_out &
								fifo_23_data_out &
								fifo_13_data_out &
								fifo_03_data_out &
								fifo_82_data_out &
								fifo_72_data_out &
								fifo_62_data_out &
								fifo_52_data_out &
								fifo_42_data_out &
								fifo_32_data_out &
								fifo_22_data_out &
								fifo_12_data_out &
								fifo_02_data_out
               );
             else
               next_state <= '1';
             end if;
         when others =>
             next_state <= '0';
             output_data_90 <= (others => '0');

     end case;
end if;
end if;
end process;
--------------------------------------- End of modification


--------------------------------------------------------------------------------------------------------------------------------
--******************************************************************************************************************************
-- DDR Data bit instantiations (72-bits)
--******************************************************************************************************************************


ddr2_dqbit0 : ddr2_dqbit port map
                              (
                               reset                 => reset270_r,
                               dqs                   => dqs_delayed_col0(0),
                               dqs1                  => dqs_delayed_col1(0),
                               dqs_div_1             => dqs_div_col0(0),
                               dqs_div_2             => dqs_div_col1(0),
                               dq                    => dq(0),
                               fbit_0                => fbit_0(0),
                               fbit_1                => fbit_1(0),
                               fbit_2                => fbit_2(0),
                               fbit_3                => fbit_3(0)
                              );

ddr2_dqbit1 : ddr2_dqbit port map
                              (
                               reset              => reset270_r,
                               dqs                => dqs_delayed_col0(0),
                               dqs1               => dqs_delayed_col1(0),
                               dqs_div_1          => dqs_div_col0(0),
                               dqs_div_2          => dqs_div_col1(0),
                               dq                 => dq(1),
                               fbit_0             => fbit_0(1),
                               fbit_1             => fbit_1(1),
                               fbit_2             => fbit_2(1),
                               fbit_3             => fbit_3(1)
                              );

ddr2_dqbit2 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(0),
                               dqs1               => dqs_delayed_col1(0),
                               dqs_div_1          => dqs_div_col0(0),
                               dqs_div_2          => dqs_div_col1(0),
                               dq                 => dq(2),
                               fbit_0             => fbit_0(2),
                               fbit_1             => fbit_1(2),
                               fbit_2             => fbit_2(2),
                               fbit_3             => fbit_3(2)
                              );

ddr2_dqbit3 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(0),
                               dqs1               => dqs_delayed_col1(0),
                               dqs_div_1          => dqs_div_col0(0),
                               dqs_div_2          => dqs_div_col1(0),
                               dq                 => dq(3),
                               fbit_0             => fbit_0(3),
                               fbit_1             => fbit_1(3),
                               fbit_2             => fbit_2(3),
                               fbit_3             => fbit_3(3)
                              );

ddr2_dqbit4 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(0),
                               dqs1               => dqs_delayed_col1(0),
                               dqs_div_1          => dqs_div_col0(0),
                               dqs_div_2          => dqs_div_col1(0),
                               dq                 => dq(4),
                               fbit_0             => fbit_0(4),
                               fbit_1             => fbit_1(4),
                               fbit_2             => fbit_2(4),
                               fbit_3             => fbit_3(4)
                              );

ddr2_dqbit5 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(0),
                               dqs1               => dqs_delayed_col1(0),
                               dqs_div_1          => dqs_div_col0(0),
                               dqs_div_2          => dqs_div_col1(0),
                               dq                 => dq(5),
                               fbit_0             => fbit_0(5),
                               fbit_1             => fbit_1(5),
                               fbit_2             => fbit_2(5),
                               fbit_3             => fbit_3(5)
                              );

ddr2_dqbit6 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(0),
                               dqs1               => dqs_delayed_col1(0),
                               dqs_div_1          => dqs_div_col0(0),
                               dqs_div_2          => dqs_div_col1(0),
                               dq                 => dq(6),
                               fbit_0             => fbit_0(6),
                               fbit_1             => fbit_1(6),
                               fbit_2             => fbit_2(6),
                               fbit_3             => fbit_3(6)
                              );

ddr2_dqbit7 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(0),
                               dqs1               => dqs_delayed_col1(0),
                               dqs_div_1          => dqs_div_col0(0),
                               dqs_div_2          => dqs_div_col1(0),
                               dq                 => dq(7),
                               fbit_0             => fbit_0(7),
                               fbit_1             => fbit_1(7),
                               fbit_2             => fbit_2(7),
                               fbit_3             => fbit_3(7)
                              );

ddr2_dqbit8 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(1),
                               dqs1               => dqs_delayed_col1(1),
                               dqs_div_1          => dqs_div_col0(1),
                               dqs_div_2          => dqs_div_col1(1),
                               dq                 => dq(8),
                               fbit_0             => fbit_0(8),
                               fbit_1             => fbit_1(8),
                               fbit_2             => fbit_2(8),
                               fbit_3             => fbit_3(8)
                              );

ddr2_dqbit9 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(1),
                               dqs1               => dqs_delayed_col1(1),
                               dqs_div_1          => dqs_div_col0(1),
                               dqs_div_2          => dqs_div_col1(1),
                               dq                 => dq(9),
                               fbit_0             => fbit_0(9),
                               fbit_1             => fbit_1(9),
                               fbit_2             => fbit_2(9),
                               fbit_3             => fbit_3(9)
                              );

ddr2_dqbit10 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(1),
                               dqs1               => dqs_delayed_col1(1),
                               dqs_div_1          => dqs_div_col0(1),
                               dqs_div_2          => dqs_div_col1(1),
                               dq                 => dq(10),
                               fbit_0             => fbit_0(10),
                               fbit_1             => fbit_1(10),
                               fbit_2             => fbit_2(10),
                               fbit_3             => fbit_3(10)
                              );

ddr2_dqbit11 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(1),
                               dqs1               => dqs_delayed_col1(1),
                               dqs_div_1          => dqs_div_col0(1),
                               dqs_div_2          => dqs_div_col1(1),
                               dq                 => dq(11),
                               fbit_0             => fbit_0(11),
                               fbit_1             => fbit_1(11),
                               fbit_2             => fbit_2(11),
                               fbit_3             => fbit_3(11)
                              );

ddr2_dqbit12 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(1),
                               dqs1               => dqs_delayed_col1(1),
                               dqs_div_1          => dqs_div_col0(1),
                               dqs_div_2          => dqs_div_col1(1),
                               dq                 => dq(12),
                               fbit_0             => fbit_0(12),
                               fbit_1             => fbit_1(12),
                               fbit_2             => fbit_2(12),
                               fbit_3             => fbit_3(12)
                              );

ddr2_dqbit13 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(1),
                               dqs1               => dqs_delayed_col1(1),
                               dqs_div_1          => dqs_div_col0(1),
                               dqs_div_2          => dqs_div_col1(1),
                               dq                 => dq(13),
                               fbit_0             => fbit_0(13),
                               fbit_1             => fbit_1(13),
                               fbit_2             => fbit_2(13),
                               fbit_3             => fbit_3(13)
                              );

ddr2_dqbit14 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(1),
                               dqs1               => dqs_delayed_col1(1),
                               dqs_div_1          => dqs_div_col0(1),
                               dqs_div_2          => dqs_div_col1(1),
                               dq                 => dq(14),
                               fbit_0             => fbit_0(14),
                               fbit_1             => fbit_1(14),
                               fbit_2             => fbit_2(14),
                               fbit_3             => fbit_3(14)
                              );

ddr2_dqbit15 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(1),
                               dqs1               => dqs_delayed_col1(1),
                               dqs_div_1          => dqs_div_col0(1),
                               dqs_div_2          => dqs_div_col1(1),
                               dq                 => dq(15),
                               fbit_0             => fbit_0(15),
                               fbit_1             => fbit_1(15),
                               fbit_2             => fbit_2(15),
                               fbit_3             => fbit_3(15)
                              );

ddr2_dqbit16 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(2),
                               dqs1               => dqs_delayed_col1(2),
                               dqs_div_1          => dqs_div_col0(2),
                               dqs_div_2          => dqs_div_col1(2),
                               dq                 => dq(16),
                               fbit_0             => fbit_0(16),
                               fbit_1             => fbit_1(16),
                               fbit_2             => fbit_2(16),
                               fbit_3             => fbit_3(16)
                              );

ddr2_dqbit17 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(2),
                               dqs1               => dqs_delayed_col1(2),
                               dqs_div_1          => dqs_div_col0(2),
                               dqs_div_2          => dqs_div_col1(2),
                               dq                 => dq(17),
                               fbit_0             => fbit_0(17),
                               fbit_1             => fbit_1(17),
                               fbit_2             => fbit_2(17),
                               fbit_3             => fbit_3(17)
                              );

ddr2_dqbit18 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(2),
                               dqs1               => dqs_delayed_col1(2),
                               dqs_div_1          => dqs_div_col0(2),
                               dqs_div_2          => dqs_div_col1(2),
                               dq                 => dq(18),
                               fbit_0             => fbit_0(18),
                               fbit_1             => fbit_1(18),
                               fbit_2             => fbit_2(18),
                               fbit_3             => fbit_3(18)
                              );

ddr2_dqbit19 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(2),
                               dqs1               => dqs_delayed_col1(2),
                               dqs_div_1          => dqs_div_col0(2),
                               dqs_div_2          => dqs_div_col1(2),
                               dq                 => dq(19),
                               fbit_0             => fbit_0(19),
                               fbit_1             => fbit_1(19),
                               fbit_2             => fbit_2(19),
                               fbit_3             => fbit_3(19)
                              );

ddr2_dqbit20 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(2),
                               dqs1               => dqs_delayed_col1(2),
                               dqs_div_1          => dqs_div_col0(2),
                               dqs_div_2          => dqs_div_col1(2),
                               dq                 => dq(20),
                               fbit_0             => fbit_0(20),
                               fbit_1             => fbit_1(20),
                               fbit_2             => fbit_2(20),
                               fbit_3             => fbit_3(20)
                              );

ddr2_dqbit21 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(2),
                               dqs1               => dqs_delayed_col1(2),
                               dqs_div_1          => dqs_div_col0(2),
                               dqs_div_2          => dqs_div_col1(2),
                               dq                 => dq(21),
                               fbit_0             => fbit_0(21),
                               fbit_1             => fbit_1(21),
                               fbit_2             => fbit_2(21),
                               fbit_3             => fbit_3(21)
                              );

ddr2_dqbit22 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(2),
                               dqs1               => dqs_delayed_col1(2),
                               dqs_div_1          => dqs_div_col0(2),
                               dqs_div_2          => dqs_div_col1(2),
                               dq                 => dq(22),
                               fbit_0             => fbit_0(22),
                               fbit_1             => fbit_1(22),
                               fbit_2             => fbit_2(22),
                               fbit_3             => fbit_3(22)
                              );

ddr2_dqbit23 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(2),
                               dqs1               => dqs_delayed_col1(2),
                               dqs_div_1          => dqs_div_col0(2),
                               dqs_div_2          => dqs_div_col1(2),
                               dq                 => dq(23),
                               fbit_0             => fbit_0(23),
                               fbit_1             => fbit_1(23),
                               fbit_2             => fbit_2(23),
                               fbit_3             => fbit_3(23)
                              );

ddr2_dqbit24 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(3),
                               dqs1               => dqs_delayed_col1(3),
                               dqs_div_1          => dqs_div_col0(3),
                               dqs_div_2          => dqs_div_col1(3),
                               dq                 => dq(24),
                               fbit_0             => fbit_0(24),
                               fbit_1             => fbit_1(24),
                               fbit_2             => fbit_2(24),
                               fbit_3             => fbit_3(24)
                              );

ddr2_dqbit25 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(3),
                               dqs1               => dqs_delayed_col1(3),
                               dqs_div_1          => dqs_div_col0(3),
                               dqs_div_2          => dqs_div_col1(3),
                               dq                 => dq(25),
                               fbit_0             => fbit_0(25),
                               fbit_1             => fbit_1(25),
                               fbit_2             => fbit_2(25),
                               fbit_3             => fbit_3(25)
                              );

ddr2_dqbit26 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(3),
                               dqs1               => dqs_delayed_col1(3),
                               dqs_div_1          => dqs_div_col0(3),
                               dqs_div_2          => dqs_div_col1(3),
                               dq                 => dq(26),
                               fbit_0             => fbit_0(26),
                               fbit_1             => fbit_1(26),
                               fbit_2             => fbit_2(26),
                               fbit_3             => fbit_3(26)
                              );

ddr2_dqbit27 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(3),
                               dqs1               => dqs_delayed_col1(3),
                               dqs_div_1          => dqs_div_col0(3),
                               dqs_div_2          => dqs_div_col1(3),
                               dq                 => dq(27),
                               fbit_0             => fbit_0(27),
                               fbit_1             => fbit_1(27),
                               fbit_2             => fbit_2(27),
                               fbit_3             => fbit_3(27)
                              );

ddr2_dqbit28 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(3),
                               dqs1               => dqs_delayed_col1(3),
                               dqs_div_1          => dqs_div_col0(3),
                               dqs_div_2          => dqs_div_col1(3),
                               dq                 => dq(28),
                               fbit_0             => fbit_0(28),
                               fbit_1             => fbit_1(28),
                               fbit_2             => fbit_2(28),
                               fbit_3             => fbit_3(28)
                              );

ddr2_dqbit29 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(3),
                               dqs1               => dqs_delayed_col1(3),
                               dqs_div_1          => dqs_div_col0(3),
                               dqs_div_2          => dqs_div_col1(3),
                               dq                 => dq(29),
                               fbit_0             => fbit_0(29),
                               fbit_1             => fbit_1(29),
                               fbit_2             => fbit_2(29),
                               fbit_3             => fbit_3(29)
                              );

ddr2_dqbit30 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(3),
                               dqs1               => dqs_delayed_col1(3),
                               dqs_div_1          => dqs_div_col0(3),
                               dqs_div_2          => dqs_div_col1(3),
                               dq                 => dq(30),
                               fbit_0             => fbit_0(30),
                               fbit_1             => fbit_1(30),
                               fbit_2             => fbit_2(30),
                               fbit_3             => fbit_3(30)
                              );

ddr2_dqbit31 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(3),
                               dqs1               => dqs_delayed_col1(3),
                               dqs_div_1          => dqs_div_col0(3),
                               dqs_div_2          => dqs_div_col1(3),
                               dq                 => dq(31),
                               fbit_0             => fbit_0(31),
                               fbit_1             => fbit_1(31),
                               fbit_2             => fbit_2(31),
                               fbit_3             => fbit_3(31)
                              );

ddr2_dqbit32 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(4),
                               dqs1               => dqs_delayed_col1(4),
                               dqs_div_1          => dqs_div_col0(4),
                               dqs_div_2          => dqs_div_col1(4),
                               dq                 => dq(32),
                               fbit_0             => fbit_0(32),
                               fbit_1             => fbit_1(32),
                               fbit_2             => fbit_2(32),
                               fbit_3             => fbit_3(32)
                              );

ddr2_dqbit33 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(4),
                               dqs1               => dqs_delayed_col1(4),
                               dqs_div_1          => dqs_div_col0(4),
                               dqs_div_2          => dqs_div_col1(4),
                               dq                 => dq(33),
                               fbit_0             => fbit_0(33),
                               fbit_1             => fbit_1(33),
                               fbit_2             => fbit_2(33),
                               fbit_3             => fbit_3(33)
                              );

ddr2_dqbit34 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(4),
                               dqs1               => dqs_delayed_col1(4),
                               dqs_div_1          => dqs_div_col0(4),
                               dqs_div_2          => dqs_div_col1(4),
                               dq                 => dq(34),
                               fbit_0             => fbit_0(34),
                               fbit_1             => fbit_1(34),
                               fbit_2             => fbit_2(34),
                               fbit_3             => fbit_3(34)
                              );

ddr2_dqbit35 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(4),
                               dqs1               => dqs_delayed_col1(4),
                               dqs_div_1          => dqs_div_col0(4),
                               dqs_div_2          => dqs_div_col1(4),
                               dq                 => dq(35),
                               fbit_0             => fbit_0(35),
                               fbit_1             => fbit_1(35),
                               fbit_2             => fbit_2(35),
                               fbit_3             => fbit_3(35)
                              );

ddr2_dqbit36 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(4),
                               dqs1               => dqs_delayed_col1(4),
                               dqs_div_1          => dqs_div_col0(4),
                               dqs_div_2          => dqs_div_col1(4),
                               dq                 => dq(36),
                               fbit_0             => fbit_0(36),
                               fbit_1             => fbit_1(36),
                               fbit_2             => fbit_2(36),
                               fbit_3             => fbit_3(36)
                              );

ddr2_dqbit37 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(4),
                               dqs1               => dqs_delayed_col1(4),
                               dqs_div_1          => dqs_div_col0(4),
                               dqs_div_2          => dqs_div_col1(4),
                               dq                 => dq(37),
                               fbit_0             => fbit_0(37),
                               fbit_1             => fbit_1(37),
                               fbit_2             => fbit_2(37),
                               fbit_3             => fbit_3(37)
                              );

ddr2_dqbit38 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(4),
                               dqs1               => dqs_delayed_col1(4),
                               dqs_div_1          => dqs_div_col0(4),
                               dqs_div_2          => dqs_div_col1(4),
                               dq                 => dq(38),
                               fbit_0             => fbit_0(38),
                               fbit_1             => fbit_1(38),
                               fbit_2             => fbit_2(38),
                               fbit_3             => fbit_3(38)
                              );

ddr2_dqbit39 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(4),
                               dqs1               => dqs_delayed_col1(4),
                               dqs_div_1          => dqs_div_col0(4),
                               dqs_div_2          => dqs_div_col1(4),
                               dq                 => dq(39),
                               fbit_0             => fbit_0(39),
                               fbit_1             => fbit_1(39),
                               fbit_2             => fbit_2(39),
                               fbit_3             => fbit_3(39)
                              );

ddr2_dqbit40 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(5),
                               dqs1               => dqs_delayed_col1(5),
                               dqs_div_1          => dqs_div_col0(5),
                               dqs_div_2          => dqs_div_col1(5),
                               dq                 => dq(40),
                               fbit_0             => fbit_0(40),
                               fbit_1             => fbit_1(40),
                               fbit_2             => fbit_2(40),
                               fbit_3             => fbit_3(40)
                              );

ddr2_dqbit41 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(5),
                               dqs1               => dqs_delayed_col1(5),
                               dqs_div_1          => dqs_div_col0(5),
                               dqs_div_2          => dqs_div_col1(5),
                               dq                 => dq(41),
                               fbit_0             => fbit_0(41),
                               fbit_1             => fbit_1(41),
                               fbit_2             => fbit_2(41),
                               fbit_3             => fbit_3(41)
                              );

ddr2_dqbit42 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(5),
                               dqs1               => dqs_delayed_col1(5),
                               dqs_div_1          => dqs_div_col0(5),
                               dqs_div_2          => dqs_div_col1(5),
                               dq                 => dq(42),
                               fbit_0             => fbit_0(42),
                               fbit_1             => fbit_1(42),
                               fbit_2             => fbit_2(42),
                               fbit_3             => fbit_3(42)
                              );

ddr2_dqbit43 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(5),
                               dqs1               => dqs_delayed_col1(5),
                               dqs_div_1          => dqs_div_col0(5),
                               dqs_div_2          => dqs_div_col1(5),
                               dq                 => dq(43),
                               fbit_0             => fbit_0(43),
                               fbit_1             => fbit_1(43),
                               fbit_2             => fbit_2(43),
                               fbit_3             => fbit_3(43)
                              );

ddr2_dqbit44 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(5),
                               dqs1               => dqs_delayed_col1(5),
                               dqs_div_1          => dqs_div_col0(5),
                               dqs_div_2          => dqs_div_col1(5),
                               dq                 => dq(44),
                               fbit_0             => fbit_0(44),
                               fbit_1             => fbit_1(44),
                               fbit_2             => fbit_2(44),
                               fbit_3             => fbit_3(44)
                              );

ddr2_dqbit45 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(5),
                               dqs1               => dqs_delayed_col1(5),
                               dqs_div_1          => dqs_div_col0(5),
                               dqs_div_2          => dqs_div_col1(5),
                               dq                 => dq(45),
                               fbit_0             => fbit_0(45),
                               fbit_1             => fbit_1(45),
                               fbit_2             => fbit_2(45),
                               fbit_3             => fbit_3(45)
                              );

ddr2_dqbit46 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(5),
                               dqs1               => dqs_delayed_col1(5),
                               dqs_div_1          => dqs_div_col0(5),
                               dqs_div_2          => dqs_div_col1(5),
                               dq                 => dq(46),
                               fbit_0             => fbit_0(46),
                               fbit_1             => fbit_1(46),
                               fbit_2             => fbit_2(46),
                               fbit_3             => fbit_3(46)
                              );

ddr2_dqbit47 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(5),
                               dqs1               => dqs_delayed_col1(5),
                               dqs_div_1          => dqs_div_col0(5),
                               dqs_div_2          => dqs_div_col1(5),
                               dq                 => dq(47),
                               fbit_0             => fbit_0(47),
                               fbit_1             => fbit_1(47),
                               fbit_2             => fbit_2(47),
                               fbit_3             => fbit_3(47)
                              );

ddr2_dqbit48 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(6),
                               dqs1               => dqs_delayed_col1(6),
                               dqs_div_1          => dqs_div_col0(6),
                               dqs_div_2          => dqs_div_col1(6),
                               dq                 => dq(48),
                               fbit_0             => fbit_0(48),
                               fbit_1             => fbit_1(48),
                               fbit_2             => fbit_2(48),
                               fbit_3             => fbit_3(48)
                              );

ddr2_dqbit49 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(6),
                               dqs1               => dqs_delayed_col1(6),
                               dqs_div_1          => dqs_div_col0(6),
                               dqs_div_2          => dqs_div_col1(6),
                               dq                 => dq(49),
                               fbit_0             => fbit_0(49),
                               fbit_1             => fbit_1(49),
                               fbit_2             => fbit_2(49),
                               fbit_3             => fbit_3(49)
                              );

ddr2_dqbit50 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(6),
                               dqs1               => dqs_delayed_col1(6),
                               dqs_div_1          => dqs_div_col0(6),
                               dqs_div_2          => dqs_div_col1(6),
                               dq                 => dq(50),
                               fbit_0             => fbit_0(50),
                               fbit_1             => fbit_1(50),
                               fbit_2             => fbit_2(50),
                               fbit_3             => fbit_3(50)
                              );

ddr2_dqbit51 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(6),
                               dqs1               => dqs_delayed_col1(6),
                               dqs_div_1          => dqs_div_col0(6),
                               dqs_div_2          => dqs_div_col1(6),
                               dq                 => dq(51),
                               fbit_0             => fbit_0(51),
                               fbit_1             => fbit_1(51),
                               fbit_2             => fbit_2(51),
                               fbit_3             => fbit_3(51)
                              );

ddr2_dqbit52 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(6),
                               dqs1               => dqs_delayed_col1(6),
                               dqs_div_1          => dqs_div_col0(6),
                               dqs_div_2          => dqs_div_col1(6),
                               dq                 => dq(52),
                               fbit_0             => fbit_0(52),
                               fbit_1             => fbit_1(52),
                               fbit_2             => fbit_2(52),
                               fbit_3             => fbit_3(52)
                              );

ddr2_dqbit53 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(6),
                               dqs1               => dqs_delayed_col1(6),
                               dqs_div_1          => dqs_div_col0(6),
                               dqs_div_2          => dqs_div_col1(6),
                               dq                 => dq(53),
                               fbit_0             => fbit_0(53),
                               fbit_1             => fbit_1(53),
                               fbit_2             => fbit_2(53),
                               fbit_3             => fbit_3(53)
                              );

ddr2_dqbit54 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(6),
                               dqs1               => dqs_delayed_col1(6),
                               dqs_div_1          => dqs_div_col0(6),
                               dqs_div_2          => dqs_div_col1(6),
                               dq                 => dq(54),
                               fbit_0             => fbit_0(54),
                               fbit_1             => fbit_1(54),
                               fbit_2             => fbit_2(54),
                               fbit_3             => fbit_3(54)
                              );

ddr2_dqbit55 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(6),
                               dqs1               => dqs_delayed_col1(6),
                               dqs_div_1          => dqs_div_col0(6),
                               dqs_div_2          => dqs_div_col1(6),
                               dq                 => dq(55),
                               fbit_0             => fbit_0(55),
                               fbit_1             => fbit_1(55),
                               fbit_2             => fbit_2(55),
                               fbit_3             => fbit_3(55)
                              );

ddr2_dqbit56 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(7),
                               dqs1               => dqs_delayed_col1(7),
                               dqs_div_1          => dqs_div_col0(7),
                               dqs_div_2          => dqs_div_col1(7),
                               dq                 => dq(56),
                               fbit_0             => fbit_0(56),
                               fbit_1             => fbit_1(56),
                               fbit_2             => fbit_2(56),
                               fbit_3             => fbit_3(56)
                              );

ddr2_dqbit57 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(7),
                               dqs1               => dqs_delayed_col1(7),
                               dqs_div_1          => dqs_div_col0(7),
                               dqs_div_2          => dqs_div_col1(7),
                               dq                 => dq(57),
                               fbit_0             => fbit_0(57),
                               fbit_1             => fbit_1(57),
                               fbit_2             => fbit_2(57),
                               fbit_3             => fbit_3(57)
                              );

ddr2_dqbit58 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(7),
                               dqs1               => dqs_delayed_col1(7),
                               dqs_div_1          => dqs_div_col0(7),
                               dqs_div_2          => dqs_div_col1(7),
                               dq                 => dq(58),
                               fbit_0             => fbit_0(58),
                               fbit_1             => fbit_1(58),
                               fbit_2             => fbit_2(58),
                               fbit_3             => fbit_3(58)
                              );

ddr2_dqbit59 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(7),
                               dqs1               => dqs_delayed_col1(7),
                               dqs_div_1          => dqs_div_col0(7),
                               dqs_div_2          => dqs_div_col1(7),
                               dq                 => dq(59),
                               fbit_0             => fbit_0(59),
                               fbit_1             => fbit_1(59),
                               fbit_2             => fbit_2(59),
                               fbit_3             => fbit_3(59)
                              );

ddr2_dqbit60 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(7),
                               dqs1               => dqs_delayed_col1(7),
                               dqs_div_1          => dqs_div_col0(7),
                               dqs_div_2          => dqs_div_col1(7),
                               dq                 => dq(60),
                               fbit_0             => fbit_0(60),
                               fbit_1             => fbit_1(60),
                               fbit_2             => fbit_2(60),
                               fbit_3             => fbit_3(60)
                              );

ddr2_dqbit61 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(7),
                               dqs1               => dqs_delayed_col1(7),
                               dqs_div_1          => dqs_div_col0(7),
                               dqs_div_2          => dqs_div_col1(7),
                               dq                 => dq(61),
                               fbit_0             => fbit_0(61),
                               fbit_1             => fbit_1(61),
                               fbit_2             => fbit_2(61),
                               fbit_3             => fbit_3(61)
                              );

ddr2_dqbit62 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(7),
                               dqs1               => dqs_delayed_col1(7),
                               dqs_div_1          => dqs_div_col0(7),
                               dqs_div_2          => dqs_div_col1(7),
                               dq                 => dq(62),
                               fbit_0             => fbit_0(62),
                               fbit_1             => fbit_1(62),
                               fbit_2             => fbit_2(62),
                               fbit_3             => fbit_3(62)
                              );

ddr2_dqbit63 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(7),
                               dqs1               => dqs_delayed_col1(7),
                               dqs_div_1          => dqs_div_col0(7),
                               dqs_div_2          => dqs_div_col1(7),
                               dq                 => dq(63),
                               fbit_0             => fbit_0(63),
                               fbit_1             => fbit_1(63),
                               fbit_2             => fbit_2(63),
                               fbit_3             => fbit_3(63)
                              );

ddr2_dqbit64 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(8),
                               dqs1               => dqs_delayed_col1(8),
                               dqs_div_1          => dqs_div_col0(8),
                               dqs_div_2          => dqs_div_col1(8),
                               dq                 => dq(64),
                               fbit_0             => fbit_0(64),
                               fbit_1             => fbit_1(64),
                               fbit_2             => fbit_2(64),
                               fbit_3             => fbit_3(64)
                              );

ddr2_dqbit65 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(8),
                               dqs1               => dqs_delayed_col1(8),
                               dqs_div_1          => dqs_div_col0(8),
                               dqs_div_2          => dqs_div_col1(8),
                               dq                 => dq(65),
                               fbit_0             => fbit_0(65),
                               fbit_1             => fbit_1(65),
                               fbit_2             => fbit_2(65),
                               fbit_3             => fbit_3(65)
                              );

ddr2_dqbit66 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(8),
                               dqs1               => dqs_delayed_col1(8),
                               dqs_div_1          => dqs_div_col0(8),
                               dqs_div_2          => dqs_div_col1(8),
                               dq                 => dq(66),
                               fbit_0             => fbit_0(66),
                               fbit_1             => fbit_1(66),
                               fbit_2             => fbit_2(66),
                               fbit_3             => fbit_3(66)
                              );

ddr2_dqbit67 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(8),
                               dqs1               => dqs_delayed_col1(8),
                               dqs_div_1          => dqs_div_col0(8),
                               dqs_div_2          => dqs_div_col1(8),
                               dq                 => dq(67),
                               fbit_0             => fbit_0(67),
                               fbit_1             => fbit_1(67),
                               fbit_2             => fbit_2(67),
                               fbit_3             => fbit_3(67)
                              );

ddr2_dqbit68 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(8),
                               dqs1               => dqs_delayed_col1(8),
                               dqs_div_1          => dqs_div_col0(8),
                               dqs_div_2          => dqs_div_col1(8),
                               dq                 => dq(68),
                               fbit_0             => fbit_0(68),
                               fbit_1             => fbit_1(68),
                               fbit_2             => fbit_2(68),
                               fbit_3             => fbit_3(68)
                              );

ddr2_dqbit69 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(8),
                               dqs1               => dqs_delayed_col1(8),
                               dqs_div_1          => dqs_div_col0(8),
                               dqs_div_2          => dqs_div_col1(8),
                               dq                 => dq(69),
                               fbit_0             => fbit_0(69),
                               fbit_1             => fbit_1(69),
                               fbit_2             => fbit_2(69),
                               fbit_3             => fbit_3(69)
                              );

ddr2_dqbit70 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(8),
                               dqs1               => dqs_delayed_col1(8),
                               dqs_div_1          => dqs_div_col0(8),
                               dqs_div_2          => dqs_div_col1(8),
                               dq                 => dq(70),
                               fbit_0             => fbit_0(70),
                               fbit_1             => fbit_1(70),
                               fbit_2             => fbit_2(70),
                               fbit_3             => fbit_3(70)
                              );

ddr2_dqbit71 : ddr2_dqbit port map
                              (
                               reset              => reset270_r,
                               dqs                => dqs_delayed_col0(8),
                               dqs1               => dqs_delayed_col1(8),
                               dqs_div_1          => dqs_div_col0(8),
                               dqs_div_2          => dqs_div_col1(8),
                               dq                 => dq(71),
                               fbit_0             => fbit_0(71),
                               fbit_1             => fbit_1(71),
                               fbit_2             => fbit_2(71),
                               fbit_3             => fbit_3(71)
                              );

--*************************************************************************************************************************
-- Distributed RAM 8 bit wide FIFO instantiations (4 FIFOs per strobe, 1 for each fbit0 through 3)
--*************************************************************************************************************************
-- FIFOs associated with ddr2_dqs(0)
ram_8d_dqs0_fbit0 : RAM_8D
port map (
          DPO    => fifo_00_data_out,
          A0     => fifo_00_wr_addr(0),
          A1     => fifo_00_wr_addr(1),
          A2     => fifo_00_wr_addr(2),
          A3     => fifo_00_wr_addr(3),
          D      => fbit_0(7 downto 0),
          DPRA0  => fifo_00_rd_addr(0),
          DPRA1  => fifo_00_rd_addr(1),
          DPRA2  => fifo_00_rd_addr(2),
          DPRA3  => fifo_00_rd_addr(3),
          WCLK   => clk90,
          WE     => transfer_done_0(0)
         );

ram_8d_dqs0_fbit1 : RAM_8D
port map (
          DPO    => fifo_01_data_out,
          A0     => fifo_01_wr_addr(0),
          A1     => fifo_01_wr_addr(1),
          A2     => fifo_01_wr_addr(2),
          A3     => fifo_01_wr_addr(3),
          D      => fbit_1(7 downto 0),
          DPRA0  => fifo_01_rd_addr(0),
          DPRA1  => fifo_01_rd_addr(1),
          DPRA2  => fifo_01_rd_addr(2),
          DPRA3  => fifo_01_rd_addr(3),
          WCLK   => clk90,
          WE     => transfer_done_0(1)
         );

ram_8d_dqs0_fbit2 : RAM_8D
port map (
          DPO    => fifo_02_data_out,
          A0     => fifo_02_wr_addr(0),
          A1     => fifo_02_wr_addr(1),
          A2     => fifo_02_wr_addr(2),
          A3     => fifo_02_wr_addr(3),
          D      => fbit_2(7 downto 0),
          DPRA0  => fifo_02_rd_addr(0),
          DPRA1  => fifo_02_rd_addr(1),
          DPRA2  => fifo_02_rd_addr(2),
          DPRA3  => fifo_02_rd_addr(3),
          WCLK   => clk90,
          WE     => transfer_done_0(2)
         );

ram_8d_dqs0_fbit3 : RAM_8D
port map (
          DPO    => fifo_03_data_out,
          A0     => fifo_03_wr_addr(0),
          A1     => fifo_03_wr_addr(1),
          A2     => fifo_03_wr_addr(2),
          A3     => fifo_03_wr_addr(3),
          D      => fbit_3(7 downto 0),
          DPRA0  => fifo_03_rd_addr(0),
          DPRA1  => fifo_03_rd_addr(1),
          DPRA2  => fifo_03_rd_addr(2),
          DPRA3  => fifo_03_rd_addr(3),
          WCLK   => clk90,
          WE     => transfer_done_0(3)
         );

-- FIFOs associated with ddr2_dqs(1)

ram_8d_dqs1_fbit0 : RAM_8D
port map (
          DPO    => fifo_10_data_out,
          A0     => fifo_10_wr_addr(0),
          A1     => fifo_10_wr_addr(1),
          A2     => fifo_10_wr_addr(2),
          A3     => fifo_10_wr_addr(3),
          D      => fbit_0(15 downto 8),
          DPRA0  => fifo_10_rd_addr(0),
          DPRA1  => fifo_10_rd_addr(1),
          DPRA2  => fifo_10_rd_addr(2),
          DPRA3  => fifo_10_rd_addr(3),
          WCLK   => clk90,
          WE     => transfer_done_1(0)
         );

ram_8d_dqs1_fbit1 : RAM_8D
port map (
          DPO    => fifo_11_data_out,
          A0     => fifo_11_wr_addr(0),
          A1     => fifo_11_wr_addr(1),
          A2     => fifo_11_wr_addr(2),
          A3     => fifo_11_wr_addr(3),
          D      => fbit_1(15 downto 8),
          DPRA0  => fifo_11_rd_addr(0),
          DPRA1  => fifo_11_rd_addr(1),
          DPRA2  => fifo_11_rd_addr(2),
          DPRA3  => fifo_11_rd_addr(3),
          WCLK   => clk90,
          WE     => transfer_done_1(1)
         );

ram_8d_dqs1_fbit2 : RAM_8D
port map (
          DPO    => fifo_12_data_out,
          A0     => fifo_12_wr_addr(0),
          A1     => fifo_12_wr_addr(1),
          A2     => fifo_12_wr_addr(2),
          A3     => fifo_12_wr_addr(3),
          D      => fbit_2(15 downto 8),
          DPRA0  => fifo_12_rd_addr(0),
          DPRA1  => fifo_12_rd_addr(1),
          DPRA2  => fifo_12_rd_addr(2),
          DPRA3  => fifo_12_rd_addr(3),
          WCLK   => clk90,
          WE     => transfer_done_1(2)
         );

ram_8d_dqs1_fbit3 : RAM_8D
port map (
          DPO    => fifo_13_data_out,
          A0     => fifo_13_wr_addr(0),
          A1     => fifo_13_wr_addr(1),
          A2     => fifo_13_wr_addr(2),
          A3     => fifo_13_wr_addr(3),
          D      => fbit_3(15 downto 8),
          DPRA0  => fifo_13_rd_addr(0),
          DPRA1  => fifo_13_rd_addr(1),
          DPRA2  => fifo_13_rd_addr(2),
          DPRA3  => fifo_13_rd_addr(3),
          WCLK   => clk90,
          WE     => transfer_done_1(3)
         );

-- FIFOs associated with ddr2_dqs(2)

ram_8d_dqs2_fbit0 : RAM_8D
port map (
          DPO    => fifo_20_data_out,
          A0     => fifo_20_wr_addr(0),
          A1     => fifo_20_wr_addr(1),
          A2     => fifo_20_wr_addr(2),
          A3     => fifo_20_wr_addr(3),
          D      => fbit_0(23 downto 16),
          DPRA0  => fifo_20_rd_addr(0),
          DPRA1  => fifo_20_rd_addr(1),
          DPRA2  => fifo_20_rd_addr(2),
          DPRA3  => fifo_20_rd_addr(3),
          WCLK   => clk90,
          WE     => transfer_done_2(0)
         );

ram_8d_dqs2_fbit1 : RAM_8D
port map (
          DPO    => fifo_21_data_out,
          A0     => fifo_21_wr_addr(0),
          A1     => fifo_21_wr_addr(1),
          A2     => fifo_21_wr_addr(2),
          A3     => fifo_21_wr_addr(3),
          D      => fbit_1(23 downto 16),
          DPRA0  => fifo_21_rd_addr(0),
          DPRA1  => fifo_21_rd_addr(1),
          DPRA2  => fifo_21_rd_addr(2),
          DPRA3  => fifo_21_rd_addr(3),
          WCLK   => clk90,
          WE     => transfer_done_2(1)
         );

ram_8d_dqs2_fbit2 : RAM_8D
port map (
          DPO    => fifo_22_data_out,
          A0     => fifo_22_wr_addr(0),
          A1     => fifo_22_wr_addr(1),
          A2     => fifo_22_wr_addr(2),
          A3     => fifo_22_wr_addr(3),
          D      => fbit_2(23 downto 16),
          DPRA0  => fifo_22_rd_addr(0),
          DPRA1  => fifo_22_rd_addr(1),
          DPRA2  => fifo_22_rd_addr(2),
          DPRA3  => fifo_22_rd_addr(3),
          WCLK   => clk90,
          WE     => transfer_done_2(2)
         );

ram_8d_dqs2_fbit3 : RAM_8D
port map (
          DPO    => fifo_23_data_out,
          A0     => fifo_23_wr_addr(0),
          A1     => fifo_23_wr_addr(1),
          A2     => fifo_23_wr_addr(2),
          A3     => fifo_23_wr_addr(3),
          D      => fbit_3(23 downto 16),
          DPRA0  => fifo_23_rd_addr(0),
          DPRA1  => fifo_23_rd_addr(1),
          DPRA2  => fifo_23_rd_addr(2),
          DPRA3  => fifo_23_rd_addr(3),
          WCLK   => clk90,
          WE     => transfer_done_2(3)
         );

-- FIFOs associated with ddr2_dqs(3)

ram_8d_dqs3_fbit0 : RAM_8D
port map (
          DPO    => fifo_30_data_out,
          A0     => fifo_30_wr_addr(0),
          A1     => fifo_30_wr_addr(1),
          A2     => fifo_30_wr_addr(2),
          A3     => fifo_30_wr_addr(3),
          D      => fbit_0(31 downto 24),
          DPRA0  => fifo_30_rd_addr(0),
          DPRA1  => fifo_30_rd_addr(1),
          DPRA2  => fifo_30_rd_addr(2),
          DPRA3  => fifo_30_rd_addr(3),
          WCLK   => clk90,
          WE     => transfer_done_3(0)
         );

ram_8d_dqs3_fbit1 : RAM_8D
port map (
          DPO    => fifo_31_data_out,
          A0     => fifo_31_wr_addr(0),
          A1     => fifo_31_wr_addr(1),
          A2     => fifo_31_wr_addr(2),
          A3     => fifo_31_wr_addr(3),
          D      => fbit_1(31 downto 24),
          DPRA0  => fifo_31_rd_addr(0),
          DPRA1  => fifo_31_rd_addr(1),
          DPRA2  => fifo_31_rd_addr(2),
          DPRA3  => fifo_31_rd_addr(3),
          WCLK   => clk90,
          WE     => transfer_done_3(1)
         );

ram_8d_dqs3_fbit2 : RAM_8D
port map (
          DPO    => fifo_32_data_out,
          A0     => fifo_32_wr_addr(0),
          A1     => fifo_32_wr_addr(1),
          A2     => fifo_32_wr_addr(2),
          A3     => fifo_32_wr_addr(3),
          D      => fbit_2(31 downto 24),
          DPRA0  => fifo_32_rd_addr(0),
          DPRA1  => fifo_32_rd_addr(1),
          DPRA2  => fifo_32_rd_addr(2),
          DPRA3  => fifo_32_rd_addr(3),
          WCLK   => clk90,
          WE     => transfer_done_3(2)
         );

ram_8d_dqs3_fbit3 : RAM_8D
port map (
          DPO    => fifo_33_data_out,
          A0     => fifo_33_wr_addr(0),
          A1     => fifo_33_wr_addr(1),
          A2     => fifo_33_wr_addr(2),
          A3     => fifo_33_wr_addr(3),
          D      => fbit_3(31 downto 24),
          DPRA0  => fifo_33_rd_addr(0),
          DPRA1  => fifo_33_rd_addr(1),
          DPRA2  => fifo_33_rd_addr(2),
          DPRA3  => fifo_33_rd_addr(3),
          WCLK   => clk90,
          WE     => transfer_done_3(3)
         );

-- FIFOs associated with ddr2_dqs(4)

ram_8d_dqs4_fbit0 : RAM_8D
port map (
          DPO    => fifo_40_data_out,
          A0     => fifo_40_wr_addr(0),
          A1     => fifo_40_wr_addr(1),
          A2     => fifo_40_wr_addr(2),
          A3     => fifo_40_wr_addr(3),
          D      => fbit_0(39 downto 32),
          DPRA0  => fifo_40_rd_addr(0),
          DPRA1  => fifo_40_rd_addr(1),
          DPRA2  => fifo_40_rd_addr(2),
          DPRA3  => fifo_40_rd_addr(3),
          WCLK   => clk90,
          WE     => transfer_done_4(0)
         );

ram_8d_dqs4_fbit1 : RAM_8D
port map (
          DPO    => fifo_41_data_out,
          A0     => fifo_41_wr_addr(0),
          A1     => fifo_41_wr_addr(1),
          A2     => fifo_41_wr_addr(2),
          A3     => fifo_41_wr_addr(3),
          D      => fbit_1(39 downto 32),
          DPRA0  => fifo_41_rd_addr(0),
          DPRA1  => fifo_41_rd_addr(1),
          DPRA2  => fifo_41_rd_addr(2),
          DPRA3  => fifo_41_rd_addr(3),
          WCLK   => clk90,
          WE     => transfer_done_4(1)
         );

ram_8d_dqs4_fbit2 : RAM_8D
port map (
          DPO    => fifo_42_data_out,
          A0     => fifo_42_wr_addr(0),
          A1     => fifo_42_wr_addr(1),
          A2     => fifo_42_wr_addr(2),
          A3     => fifo_42_wr_addr(3),
          D      => fbit_2(39 downto 32),
          DPRA0  => fifo_42_rd_addr(0),
          DPRA1  => fifo_42_rd_addr(1),
          DPRA2  => fifo_42_rd_addr(2),
          DPRA3  => fifo_42_rd_addr(3),
          WCLK   => clk90,
          WE     => transfer_done_4(2)
         );

ram_8d_dqs4_fbit3 : RAM_8D
port map (
          DPO    => fifo_43_data_out,
          A0     => fifo_43_wr_addr(0),
          A1     => fifo_43_wr_addr(1),
          A2     => fifo_43_wr_addr(2),
          A3     => fifo_43_wr_addr(3),
          D      => fbit_3(39 downto 32),
          DPRA0  => fifo_43_rd_addr(0),
          DPRA1  => fifo_43_rd_addr(1),
          DPRA2  => fifo_43_rd_addr(2),
          DPRA3  => fifo_43_rd_addr(3),
          WCLK   => clk90,
          WE     => transfer_done_4(3)
         );

-- FIFOs associated with ddr2_dqs(5)

ram_8d_dqs5_fbit0 : RAM_8D
port map (
          DPO    => fifo_50_data_out,
          A0     => fifo_50_wr_addr(0),
          A1     => fifo_50_wr_addr(1),
          A2     => fifo_50_wr_addr(2),
          A3     => fifo_50_wr_addr(3),
          D      => fbit_0(47 downto 40),
          DPRA0  => fifo_50_rd_addr(0),
          DPRA1  => fifo_50_rd_addr(1),
          DPRA2  => fifo_50_rd_addr(2),
          DPRA3  => fifo_50_rd_addr(3),
          WCLK   => clk90,
          WE     => transfer_done_5(0)
         );

ram_8d_dqs5_fbit1 : RAM_8D
port map (
          DPO    => fifo_51_data_out,
          A0     => fifo_51_wr_addr(0),
          A1     => fifo_51_wr_addr(1),
          A2     => fifo_51_wr_addr(2),
          A3     => fifo_51_wr_addr(3),
          D      => fbit_1(47 downto 40),
          DPRA0  => fifo_51_rd_addr(0),
          DPRA1  => fifo_51_rd_addr(1),
          DPRA2  => fifo_51_rd_addr(2),
          DPRA3  => fifo_51_rd_addr(3),
          WCLK   => clk90,
          WE     => transfer_done_5(1)
         );

ram_8d_dqs5_fbit2 : RAM_8D
port map (
          DPO    => fifo_52_data_out,
          A0     => fifo_52_wr_addr(0),
          A1     => fifo_52_wr_addr(1),
          A2     => fifo_52_wr_addr(2),
          A3     => fifo_52_wr_addr(3),
          D      => fbit_2(47 downto 40),
          DPRA0  => fifo_52_rd_addr(0),
          DPRA1  => fifo_52_rd_addr(1),
          DPRA2  => fifo_52_rd_addr(2),
          DPRA3  => fifo_52_rd_addr(3),
          WCLK   => clk90,
          WE     => transfer_done_5(2)
         );

ram_8d_dqs5_fbit3 : RAM_8D
port map (
          DPO    => fifo_53_data_out,
          A0     => fifo_53_wr_addr(0),
          A1     => fifo_53_wr_addr(1),
          A2     => fifo_53_wr_addr(2),
          A3     => fifo_53_wr_addr(3),
          D      => fbit_3(47 downto 40),
          DPRA0  => fifo_53_rd_addr(0),
          DPRA1  => fifo_53_rd_addr(1),
          DPRA2  => fifo_53_rd_addr(2),
          DPRA3  => fifo_53_rd_addr(3),
          WCLK   => clk90,
          WE     => transfer_done_5(3)
         );

-- FIFOs associated with ddr2_dqs(6)

ram_8d_dqs6_fbit0 : RAM_8D
port map (
          DPO    => fifo_60_data_out,
          A0     => fifo_60_wr_addr(0),
          A1     => fifo_60_wr_addr(1),
          A2     => fifo_60_wr_addr(2),
          A3     => fifo_60_wr_addr(3),
          D      => fbit_0(55 downto 48),
          DPRA0  => fifo_60_rd_addr(0),
          DPRA1  => fifo_60_rd_addr(1),
          DPRA2  => fifo_60_rd_addr(2),
          DPRA3  => fifo_60_rd_addr(3),
          WCLK   => clk90,
          WE     => transfer_done_6(0)
         );

ram_8d_dqs6_fbit1 : RAM_8D
port map (
          DPO    => fifo_61_data_out,
          A0     => fifo_61_wr_addr(0),
          A1     => fifo_61_wr_addr(1),
          A2     => fifo_61_wr_addr(2),
          A3     => fifo_61_wr_addr(3),
          D      => fbit_1(55 downto 48),
          DPRA0  => fifo_61_rd_addr(0),
          DPRA1  => fifo_61_rd_addr(1),
          DPRA2  => fifo_61_rd_addr(2),
          DPRA3  => fifo_61_rd_addr(3),
          WCLK   => clk90,
          WE     => transfer_done_6(1)
         );

ram_8d_dqs6_fbit2 : RAM_8D
port map (
          DPO    => fifo_62_data_out,
          A0     => fifo_62_wr_addr(0),
          A1     => fifo_62_wr_addr(1),
          A2     => fifo_62_wr_addr(2),
          A3     => fifo_62_wr_addr(3),
          D      => fbit_2(55 downto 48),
          DPRA0  => fifo_62_rd_addr(0),
          DPRA1  => fifo_62_rd_addr(1),
          DPRA2  => fifo_62_rd_addr(2),
          DPRA3  => fifo_62_rd_addr(3),
          WCLK   => clk90,
          WE     => transfer_done_6(2)
         );

ram_8d_dqs6_fbit3 : RAM_8D
port map (
          DPO    => fifo_63_data_out,
          A0     => fifo_63_wr_addr(0),
          A1     => fifo_63_wr_addr(1),
          A2     => fifo_63_wr_addr(2),
          A3     => fifo_63_wr_addr(3),
          D      => fbit_3(55 downto 48),
          DPRA0  => fifo_63_rd_addr(0),
          DPRA1  => fifo_63_rd_addr(1),
          DPRA2  => fifo_63_rd_addr(2),
          DPRA3  => fifo_63_rd_addr(3),
          WCLK   => clk90,
          WE     => transfer_done_6(3)
         );

-- FIFOs associated with ddr2_dqs(7)

ram_8d_dqs7_fbit0 : RAM_8D
port map (
          DPO    => fifo_70_data_out,
          A0     => fifo_70_wr_addr(0),
          A1     => fifo_70_wr_addr(1),
          A2     => fifo_70_wr_addr(2),
          A3     => fifo_70_wr_addr(3),
          D      => fbit_0(63 downto 56),
          DPRA0  => fifo_70_rd_addr(0),
          DPRA1  => fifo_70_rd_addr(1),
          DPRA2  => fifo_70_rd_addr(2),
          DPRA3  => fifo_70_rd_addr(3),
          WCLK   => clk90,
          WE     => transfer_done_7(0)
         );

ram_8d_dqs7_fbit1 : RAM_8D
port map (
          DPO    => fifo_71_data_out,
          A0     => fifo_71_wr_addr(0),
          A1     => fifo_71_wr_addr(1),
          A2     => fifo_71_wr_addr(2),
          A3     => fifo_71_wr_addr(3),
          D      => fbit_1(63 downto 56),
          DPRA0  => fifo_71_rd_addr(0),
          DPRA1  => fifo_71_rd_addr(1),
          DPRA2  => fifo_71_rd_addr(2),
          DPRA3  => fifo_71_rd_addr(3),
          WCLK   => clk90,
          WE     => transfer_done_7(1)
         );

ram_8d_dqs7_fbit2 : RAM_8D
port map (
          DPO    => fifo_72_data_out,
          A0     => fifo_72_wr_addr(0),
          A1     => fifo_72_wr_addr(1),
          A2     => fifo_72_wr_addr(2),
          A3     => fifo_72_wr_addr(3),
          D      => fbit_2(63 downto 56),
          DPRA0  => fifo_72_rd_addr(0),
          DPRA1  => fifo_72_rd_addr(1),
          DPRA2  => fifo_72_rd_addr(2),
          DPRA3  => fifo_72_rd_addr(3),
          WCLK   => clk90,
          WE     => transfer_done_7(2)
         );

ram_8d_dqs7_fbit3 : RAM_8D
port map (
          DPO    => fifo_73_data_out,
          A0     => fifo_73_wr_addr(0),
          A1     => fifo_73_wr_addr(1),
          A2     => fifo_73_wr_addr(2),
          A3     => fifo_73_wr_addr(3),
          D      => fbit_3(63 downto 56),
          DPRA0  => fifo_73_rd_addr(0),
          DPRA1  => fifo_73_rd_addr(1),
          DPRA2  => fifo_73_rd_addr(2),
          DPRA3  => fifo_73_rd_addr(3),
          WCLK   => clk90,
          WE     => transfer_done_7(3)
         );

-- FIFOs associated with ddr2_dqs(8)

ram_8d_dqs8_fbit0 : RAM_8D
port map (
          DPO    => fifo_80_data_out,
          A0     => fifo_80_wr_addr(0),
          A1     => fifo_80_wr_addr(1),
          A2     => fifo_80_wr_addr(2),
          A3     => fifo_80_wr_addr(3),
          D      => fbit_0(71 downto 64),
          DPRA0  => fifo_80_rd_addr(0),
          DPRA1  => fifo_80_rd_addr(1),
          DPRA2  => fifo_80_rd_addr(2),
          DPRA3  => fifo_80_rd_addr(3),
          WCLK   => clk90,
          WE     => transfer_done_8(0)
         );

ram_8d_dqs8_fbit1 : RAM_8D
port map (
          DPO    => fifo_81_data_out,
          A0     => fifo_81_wr_addr(0),
          A1     => fifo_81_wr_addr(1),
          A2     => fifo_81_wr_addr(2),
          A3     => fifo_81_wr_addr(3),
          D      => fbit_1(71 downto 64),
          DPRA0  => fifo_81_rd_addr(0),
          DPRA1  => fifo_81_rd_addr(1),
          DPRA2  => fifo_81_rd_addr(2),
          DPRA3  => fifo_81_rd_addr(3),
          WCLK   => clk90,
          WE     => transfer_done_8(1)
         );

ram_8d_dqs8_fbit2 : RAM_8D
port map (
          DPO    => fifo_82_data_out,
          A0     => fifo_82_wr_addr(0),
          A1     => fifo_82_wr_addr(1),
          A2     => fifo_82_wr_addr(2),
          A3     => fifo_82_wr_addr(3),
          D      => fbit_2(71 downto 64),
          DPRA0  => fifo_82_rd_addr(0),
          DPRA1  => fifo_82_rd_addr(1),
          DPRA2  => fifo_82_rd_addr(2),
          DPRA3  => fifo_82_rd_addr(3),
          WCLK   => clk90,
          WE     => transfer_done_8(2)
         );

ram_8d_dqs8_fbit3 : RAM_8D
port map (
          DPO    => fifo_83_data_out,
          A0     => fifo_83_wr_addr(0),
          A1     => fifo_83_wr_addr(1),
          A2     => fifo_83_wr_addr(2),
          A3     => fifo_83_wr_addr(3),
          D      => fbit_3(71 downto 64),
          DPRA0  => fifo_83_rd_addr(0),
          DPRA1  => fifo_83_rd_addr(1),
          DPRA2  => fifo_83_rd_addr(2),
          DPRA3  => fifo_83_rd_addr(3),
          WCLK   => clk90,
          WE     => transfer_done_8(3)
         );



end   arc_data_read_72bit_rl;


























































































































































































































































































































































































































































































































































































































































































































































--******************************************************************************
--
--  Xilinx, Inc. 2002                 www.xilinx.com
--
--
--*******************************************************************************
--
--  File name :       data_read_controller.vhd
--
--  Description :     This module generates all the control signals  for the
--                     read data path.
--
--
--  Date - revision : 10/16/2003
--
--  Author :          Maria George ( Modified by Sailaja)
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
--library synplify;
--use synplify.attributes.all;
--
-- pragma translate_off
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
-- pragma translate_on
--
entity   data_read_controller_72bit_rl  is
port(
     clk                : in std_logic;
     clk90              : in std_logic;
     reset_r            : in std_logic;
     reset90_r          : in std_logic;
     reset180_r         : in std_logic;
     reset270_r         : in std_logic;
     rst_dqs_div        : in std_logic;
     delay_sel          : in std_logic_vector(4 downto 0);
     dqs_int_delay_in0  : in std_logic;
     dqs_int_delay_in1  : in std_logic;
     dqs_int_delay_in2  : in std_logic;
     dqs_int_delay_in3  : in std_logic;
     dqs_int_delay_in4  : in std_logic;
     dqs_int_delay_in5  : in std_logic;
     dqs_int_delay_in6  : in std_logic;
     dqs_int_delay_in7  : in std_logic;
     dqs_int_delay_in8  : in std_logic;
     next_state         : in std_logic;
     read_data_valid_1_val  : out std_logic;
     read_data_valid_2_val  : out std_logic;
     transfer_done_0_val    : out std_logic_vector(3 downto 0);
     transfer_done_1_val    : out std_logic_vector(3 downto 0);
     transfer_done_2_val    : out std_logic_vector(3 downto 0);
     transfer_done_3_val    : out std_logic_vector(3 downto 0);
     transfer_done_4_val    : out std_logic_vector(3 downto 0);
     transfer_done_5_val    : out std_logic_vector(3 downto 0);
     transfer_done_6_val    : out std_logic_vector(3 downto 0);
     transfer_done_7_val    : out std_logic_vector(3 downto 0);
     transfer_done_8_val    : out std_logic_vector(3 downto 0);
     fifo_00_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_01_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_02_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_03_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_10_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_11_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_12_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_13_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_20_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_21_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_22_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_23_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_30_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_31_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_32_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_33_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_40_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_41_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_42_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_43_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_50_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_51_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_52_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_53_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_60_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_61_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_62_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_63_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_70_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_71_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_72_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_73_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_80_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_81_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_82_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_83_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_00_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_01_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_02_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_03_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_10_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_11_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_12_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_13_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_20_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_21_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_22_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_23_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_30_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_31_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_32_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_33_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_40_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_41_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_42_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_43_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_50_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_51_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_52_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_53_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_60_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_61_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_62_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_63_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_70_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_71_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_72_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_73_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_80_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_81_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_82_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_83_rd_addr_val    : out std_logic_vector(3 downto 0);
     dqs_delayed_col0_val   : out std_logic_vector(8 downto 0);
     dqs_delayed_col1_val   : out std_logic_vector(8 downto 0);
     dqs_div_col0_val       : out std_logic_vector(8 downto 0);
     dqs_div_col1_val       : out std_logic_vector(8 downto 0)


     );
end   data_read_controller_72bit_rl;

architecture   arc_data_read_controller_72bit_rl of   data_read_controller_72bit_rl    is

component dqs_delay
              port (
		    clk_in   : in std_logic;
		    sel_in   : in std_logic_vector(4 downto 0);
		    clk_out  : out std_logic
		  );
end component;

component ddr2_dqs_div
  port (
        dqs           : in std_logic;  -- first column for negative edge data
        dqs1          : in std_logic;  -- second column for positive edge data
        reset         : in std_logic;
        rst_dqs_div_delayed   : in std_logic;
        dqs_divn      : out std_logic;
        dqs_divp      : out std_logic
       );
end component;

component ddr2_transfer_done
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
end component;


signal fifo_41_not_empty      : std_logic;
signal fifo_43_not_empty      : std_logic;

signal fifo_41_not_empty_r    : std_logic := '0';
signal fifo_43_not_empty_r    : std_logic := '0';
signal fifo_41_not_empty_r1   : std_logic := '0';
signal fifo_43_not_empty_r1   : std_logic := '0';
signal read_data_valid_1      : std_logic;
signal read_data_valid_2      : std_logic;
signal rst_dqs_div_int        : std_logic ;

 signal     transfer_done_0    : std_logic_vector(3 downto 0);
 signal     transfer_done_1    : std_logic_vector(3 downto 0);
 signal     transfer_done_2    : std_logic_vector(3 downto 0);
 signal     transfer_done_3    : std_logic_vector(3 downto 0);
 signal     transfer_done_4    : std_logic_vector(3 downto 0);
 signal     transfer_done_5    : std_logic_vector(3 downto 0);
 signal     transfer_done_6    : std_logic_vector(3 downto 0);
 signal     transfer_done_7    : std_logic_vector(3 downto 0);
 signal     transfer_done_8    : std_logic_vector(3 downto 0);
 signal     fifo_00_wr_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_01_wr_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_02_wr_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_03_wr_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_10_wr_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_11_wr_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_12_wr_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_13_wr_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_20_wr_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_21_wr_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_22_wr_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_23_wr_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_30_wr_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_31_wr_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_32_wr_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_33_wr_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_40_wr_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_41_wr_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_42_wr_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_43_wr_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_50_wr_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_51_wr_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_52_wr_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_53_wr_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_60_wr_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_61_wr_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_62_wr_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_63_wr_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_70_wr_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_71_wr_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_72_wr_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_73_wr_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_80_wr_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_81_wr_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_82_wr_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_83_wr_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     dqs_delayed_col0   : std_logic_vector(8 downto 0);
 signal     dqs_delayed_col1   : std_logic_vector(8 downto 0);
 signal     dqs_div_col0       : std_logic_vector(8 downto 0);
 signal     dqs_div_col1       : std_logic_vector(8 downto 0);
 signal     rst_dqs_div_delayed: std_logic;
 signal     fifo_00_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_01_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_02_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_03_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_10_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_11_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_12_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_13_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_20_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_21_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_22_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_23_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_30_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_31_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_32_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_33_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_40_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_41_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_42_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_43_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_50_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_51_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_52_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_53_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_60_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_61_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_62_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_63_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_70_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_71_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_72_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_73_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_80_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_81_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_82_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_83_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     read_data_valid_1_reg   : std_logic := '0';
 signal     read_data_valid_2_reg   : std_logic := '0';

 begin

 transfer_done_0_val <= transfer_done_0;
 transfer_done_1_val <= transfer_done_1;
 transfer_done_2_val <= transfer_done_2;
 transfer_done_3_val <= transfer_done_3;
 transfer_done_4_val <= transfer_done_4;
 transfer_done_5_val <= transfer_done_5;
 transfer_done_6_val <= transfer_done_6;
 transfer_done_7_val <= transfer_done_7;
 transfer_done_8_val <= transfer_done_8;
 fifo_00_wr_addr_val <= fifo_00_wr_addr;
 fifo_01_wr_addr_val <= fifo_01_wr_addr;
 fifo_02_wr_addr_val <= fifo_02_wr_addr;
 fifo_03_wr_addr_val <= fifo_03_wr_addr;
 fifo_10_wr_addr_val <= fifo_10_wr_addr;
 fifo_11_wr_addr_val <= fifo_11_wr_addr;
 fifo_12_wr_addr_val <= fifo_12_wr_addr;
 fifo_13_wr_addr_val <= fifo_13_wr_addr;
 fifo_20_wr_addr_val <= fifo_20_wr_addr;
 fifo_21_wr_addr_val <= fifo_21_wr_addr;
 fifo_22_wr_addr_val <= fifo_22_wr_addr;
 fifo_23_wr_addr_val <= fifo_23_wr_addr;
 fifo_30_wr_addr_val <= fifo_30_wr_addr;
 fifo_31_wr_addr_val <= fifo_31_wr_addr;
 fifo_32_wr_addr_val <= fifo_32_wr_addr;
 fifo_33_wr_addr_val <= fifo_33_wr_addr;
 fifo_40_wr_addr_val <= fifo_40_wr_addr;
 fifo_41_wr_addr_val <= fifo_41_wr_addr;
 fifo_42_wr_addr_val <= fifo_42_wr_addr;
 fifo_43_wr_addr_val <= fifo_43_wr_addr;
 fifo_50_wr_addr_val <= fifo_50_wr_addr;
 fifo_51_wr_addr_val <= fifo_51_wr_addr;
 fifo_52_wr_addr_val <= fifo_52_wr_addr;
 fifo_53_wr_addr_val <= fifo_53_wr_addr;
 fifo_60_wr_addr_val <= fifo_60_wr_addr;
 fifo_61_wr_addr_val <= fifo_61_wr_addr;
 fifo_62_wr_addr_val <= fifo_62_wr_addr;
 fifo_63_wr_addr_val <= fifo_63_wr_addr;
 fifo_70_wr_addr_val <= fifo_70_wr_addr;
 fifo_71_wr_addr_val <= fifo_71_wr_addr;
 fifo_72_wr_addr_val <= fifo_72_wr_addr;
 fifo_73_wr_addr_val <= fifo_73_wr_addr;
 fifo_80_wr_addr_val <= fifo_80_wr_addr;
 fifo_81_wr_addr_val <= fifo_81_wr_addr;
 fifo_82_wr_addr_val <= fifo_82_wr_addr;
 fifo_83_wr_addr_val <= fifo_83_wr_addr;
 dqs_delayed_col0_val <= dqs_delayed_col0;
 dqs_delayed_col1_val <= dqs_delayed_col1;
 dqs_div_col0_val <= dqs_div_col0;
 dqs_div_col1_val <= dqs_div_col1;

fifo_00_rd_addr_val <= fifo_00_rd_addr;
fifo_01_rd_addr_val <= fifo_01_rd_addr;
fifo_02_rd_addr_val <= fifo_02_rd_addr;
fifo_03_rd_addr_val <= fifo_03_rd_addr;
fifo_10_rd_addr_val <= fifo_10_rd_addr;
fifo_11_rd_addr_val <= fifo_11_rd_addr;
fifo_12_rd_addr_val <= fifo_12_rd_addr;
fifo_13_rd_addr_val <= fifo_13_rd_addr;
fifo_20_rd_addr_val <= fifo_20_rd_addr;
fifo_21_rd_addr_val <= fifo_21_rd_addr;
fifo_22_rd_addr_val <= fifo_22_rd_addr;
fifo_23_rd_addr_val <= fifo_23_rd_addr;
fifo_30_rd_addr_val <= fifo_30_rd_addr;
fifo_31_rd_addr_val <= fifo_31_rd_addr;
fifo_32_rd_addr_val <= fifo_32_rd_addr;
fifo_33_rd_addr_val <= fifo_33_rd_addr;
fifo_40_rd_addr_val <= fifo_40_rd_addr;
fifo_41_rd_addr_val <= fifo_41_rd_addr;
fifo_42_rd_addr_val <= fifo_42_rd_addr;
fifo_43_rd_addr_val <= fifo_43_rd_addr;
fifo_50_rd_addr_val <= fifo_50_rd_addr;
fifo_51_rd_addr_val <= fifo_51_rd_addr;
fifo_52_rd_addr_val <= fifo_52_rd_addr;
fifo_53_rd_addr_val <= fifo_53_rd_addr;
fifo_60_rd_addr_val <= fifo_60_rd_addr;
fifo_61_rd_addr_val <= fifo_61_rd_addr;
fifo_62_rd_addr_val <= fifo_62_rd_addr;
fifo_63_rd_addr_val <= fifo_63_rd_addr;
fifo_70_rd_addr_val <= fifo_70_rd_addr;
fifo_71_rd_addr_val <= fifo_71_rd_addr;
fifo_72_rd_addr_val <= fifo_72_rd_addr;
fifo_73_rd_addr_val <= fifo_73_rd_addr;
fifo_80_rd_addr_val <= fifo_80_rd_addr;
fifo_81_rd_addr_val <= fifo_81_rd_addr;
fifo_82_rd_addr_val <= fifo_82_rd_addr;
fifo_83_rd_addr_val <= fifo_83_rd_addr;



process(clk90)
begin
if clk90'event and clk90 = '1' then
 if reset90_r = '1' then
    fifo_00_rd_addr  <= "0000";
    fifo_01_rd_addr  <= "0000";
    fifo_02_rd_addr  <= "0000";
    fifo_03_rd_addr  <= "0000";
    fifo_10_rd_addr  <= "0000";
    fifo_11_rd_addr  <= "0000";
    fifo_12_rd_addr  <= "0000";
    fifo_13_rd_addr  <= "0000";
    fifo_20_rd_addr  <= "0000";
    fifo_21_rd_addr  <= "0000";
    fifo_22_rd_addr  <= "0000";
    fifo_23_rd_addr  <= "0000";
    fifo_30_rd_addr  <= "0000";
    fifo_31_rd_addr  <= "0000";
    fifo_32_rd_addr  <= "0000";
    fifo_33_rd_addr  <= "0000";
    fifo_40_rd_addr  <= "0000";
    fifo_41_rd_addr  <= "0000";
    fifo_42_rd_addr  <= "0000";
    fifo_43_rd_addr  <= "0000";
    fifo_50_rd_addr  <= "0000";
    fifo_51_rd_addr  <= "0000";
    fifo_52_rd_addr  <= "0000";
    fifo_53_rd_addr  <= "0000";
    fifo_60_rd_addr  <= "0000";
    fifo_61_rd_addr  <= "0000";
    fifo_62_rd_addr  <= "0000";
    fifo_63_rd_addr  <= "0000";
    fifo_70_rd_addr  <= "0000";
    fifo_71_rd_addr  <= "0000";
    fifo_72_rd_addr  <= "0000";
    fifo_73_rd_addr  <= "0000";
    fifo_80_rd_addr  <= "0000";
    fifo_81_rd_addr  <= "0000";
    fifo_82_rd_addr  <= "0000";
    fifo_83_rd_addr  <= "0000";
 else
    case next_state is

         when '0' =>
             if (read_data_valid_1_reg = '1') then
               fifo_00_rd_addr <= fifo_00_rd_addr + "0001";
               fifo_01_rd_addr <= fifo_01_rd_addr + "0001";
               fifo_10_rd_addr <= fifo_10_rd_addr + "0001";
               fifo_11_rd_addr <= fifo_11_rd_addr + "0001";
               fifo_20_rd_addr <= fifo_20_rd_addr + "0001";
               fifo_21_rd_addr <= fifo_21_rd_addr + "0001";
               fifo_30_rd_addr <= fifo_30_rd_addr + "0001";
               fifo_31_rd_addr <= fifo_31_rd_addr + "0001";
               fifo_40_rd_addr <= fifo_40_rd_addr + "0001";
               fifo_41_rd_addr <= fifo_41_rd_addr + "0001";
               fifo_50_rd_addr <= fifo_50_rd_addr + "0001";
               fifo_51_rd_addr <= fifo_51_rd_addr + "0001";
               fifo_60_rd_addr <= fifo_60_rd_addr + "0001";
               fifo_61_rd_addr <= fifo_61_rd_addr + "0001";
               fifo_70_rd_addr <= fifo_70_rd_addr + "0001";
               fifo_71_rd_addr <= fifo_71_rd_addr + "0001";
               fifo_80_rd_addr <= fifo_80_rd_addr + "0001";
               fifo_81_rd_addr <= fifo_81_rd_addr + "0001";
             else
               fifo_00_rd_addr <= fifo_00_rd_addr;
               fifo_01_rd_addr <= fifo_01_rd_addr;
               fifo_10_rd_addr <= fifo_10_rd_addr;
               fifo_11_rd_addr <= fifo_11_rd_addr;
               fifo_20_rd_addr <= fifo_20_rd_addr;
               fifo_21_rd_addr <= fifo_21_rd_addr;
               fifo_30_rd_addr <= fifo_30_rd_addr;
               fifo_31_rd_addr <= fifo_31_rd_addr;
               fifo_40_rd_addr <= fifo_40_rd_addr;
               fifo_41_rd_addr <= fifo_41_rd_addr;
               fifo_50_rd_addr <= fifo_50_rd_addr;
               fifo_51_rd_addr <= fifo_51_rd_addr;
               fifo_60_rd_addr <= fifo_60_rd_addr;
               fifo_61_rd_addr <= fifo_61_rd_addr;
               fifo_70_rd_addr <= fifo_70_rd_addr;
               fifo_71_rd_addr <= fifo_71_rd_addr;
               fifo_80_rd_addr <= fifo_80_rd_addr;
               fifo_81_rd_addr <= fifo_81_rd_addr;
             end if;

         when '1' =>
             if (read_data_valid_2_reg = '1') then
               fifo_02_rd_addr <= fifo_02_rd_addr + "0001";
               fifo_03_rd_addr <= fifo_03_rd_addr + "0001";
               fifo_12_rd_addr <= fifo_12_rd_addr + "0001";
               fifo_13_rd_addr <= fifo_13_rd_addr + "0001";
               fifo_22_rd_addr <= fifo_22_rd_addr + "0001";
               fifo_23_rd_addr <= fifo_23_rd_addr + "0001";
               fifo_32_rd_addr <= fifo_32_rd_addr + "0001";
               fifo_33_rd_addr <= fifo_33_rd_addr + "0001";
               fifo_42_rd_addr <= fifo_42_rd_addr + "0001";
               fifo_43_rd_addr <= fifo_43_rd_addr + "0001";
               fifo_52_rd_addr <= fifo_52_rd_addr + "0001";
               fifo_53_rd_addr <= fifo_53_rd_addr + "0001";
               fifo_62_rd_addr <= fifo_62_rd_addr + "0001";
               fifo_63_rd_addr <= fifo_63_rd_addr + "0001";
               fifo_72_rd_addr <= fifo_72_rd_addr + "0001";
               fifo_73_rd_addr <= fifo_73_rd_addr + "0001";
               fifo_82_rd_addr <= fifo_82_rd_addr + "0001";
               fifo_83_rd_addr <= fifo_83_rd_addr + "0001";
             else
               fifo_02_rd_addr <= fifo_02_rd_addr;
               fifo_03_rd_addr <= fifo_03_rd_addr;
               fifo_12_rd_addr <= fifo_12_rd_addr;
               fifo_13_rd_addr <= fifo_13_rd_addr;
               fifo_22_rd_addr <= fifo_22_rd_addr;
               fifo_23_rd_addr <= fifo_23_rd_addr;
               fifo_32_rd_addr <= fifo_32_rd_addr;
               fifo_33_rd_addr <= fifo_33_rd_addr;
               fifo_42_rd_addr <= fifo_42_rd_addr;
               fifo_43_rd_addr <= fifo_43_rd_addr;
               fifo_52_rd_addr <= fifo_52_rd_addr;
               fifo_53_rd_addr <= fifo_53_rd_addr;
               fifo_62_rd_addr <= fifo_62_rd_addr;
               fifo_63_rd_addr <= fifo_63_rd_addr;
               fifo_72_rd_addr <= fifo_72_rd_addr;
               fifo_73_rd_addr <= fifo_73_rd_addr;
               fifo_82_rd_addr <= fifo_82_rd_addr;
               fifo_83_rd_addr <= fifo_83_rd_addr;
             end if;
          when others =>
             fifo_00_rd_addr <= "0000";
             fifo_01_rd_addr <= "0000";
             fifo_02_rd_addr <= "0000";
             fifo_03_rd_addr <= "0000";
             fifo_10_rd_addr <= "0000";
             fifo_11_rd_addr <= "0000";
             fifo_12_rd_addr <= "0000";
             fifo_13_rd_addr <= "0000";
             fifo_20_rd_addr <= "0000";
             fifo_21_rd_addr <= "0000";
             fifo_22_rd_addr <= "0000";
             fifo_23_rd_addr <= "0000";
             fifo_30_rd_addr <= "0000";
             fifo_31_rd_addr <= "0000";
             fifo_32_rd_addr <= "0000";
             fifo_33_rd_addr <= "0000";
             fifo_40_rd_addr <= "0000";
             fifo_41_rd_addr <= "0000";
             fifo_42_rd_addr <= "0000";
             fifo_43_rd_addr <= "0000";
             fifo_50_rd_addr <= "0000";
             fifo_51_rd_addr <= "0000";
             fifo_52_rd_addr <= "0000";
             fifo_53_rd_addr <= "0000";
             fifo_60_rd_addr <= "0000";
             fifo_61_rd_addr <= "0000";
             fifo_62_rd_addr <= "0000";
             fifo_63_rd_addr <= "0000";
             fifo_70_rd_addr <= "0000";
             fifo_71_rd_addr <= "0000";
             fifo_72_rd_addr <= "0000";
             fifo_73_rd_addr <= "0000";
             fifo_80_rd_addr <= "0000";
             fifo_81_rd_addr <= "0000";
             fifo_82_rd_addr <= "0000";
             fifo_83_rd_addr <= "0000";
     end case;
end if;
end if;
end process;

read_data_valid_1_val <= read_data_valid_1_reg;
read_data_valid_2_val <= read_data_valid_2_reg;

rst_dqs_div_int <= not rst_dqs_div;

read_data_valid_1     <= '1' when (fifo_41_not_empty_r1 = '1' and fifo_41_not_empty = '1') else
                         '0';

read_data_valid_2     <= '1' when (fifo_43_not_empty_r1 = '1' and fifo_43_not_empty = '1') else
                         '0';


fifo_41_not_empty   <= '0' when (fifo_00_rd_addr(3 downto 0) = fifo_41_wr_addr(3 downto 0)) else
                       '1';
fifo_43_not_empty   <= '0' when (fifo_02_rd_addr(3 downto 0) = fifo_43_wr_addr(3 downto 0)) else
                       '1';



process (clk90)
begin
  if (rising_edge(clk90)) then
    if (reset90_r = '1') then
      fifo_41_not_empty_r   <= '0';
      fifo_43_not_empty_r   <= '0';
      fifo_41_not_empty_r1  <= '0';
      fifo_43_not_empty_r1  <= '0';
      read_data_valid_1_reg <= '0';
      read_data_valid_2_reg <= '0';
    else
      fifo_41_not_empty_r   <= fifo_41_not_empty;
      fifo_43_not_empty_r   <= fifo_43_not_empty;
      fifo_41_not_empty_r1  <= fifo_41_not_empty_r;
      fifo_43_not_empty_r1  <= fifo_43_not_empty_r;
      read_data_valid_1_reg <=  read_data_valid_1;
      read_data_valid_2_reg <=  read_data_valid_2;
    end if;
  end if;
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if (reset90_r = '1') then
      fifo_00_wr_addr <= "0000";
    elsif (transfer_done_0(0) = '1') then
      fifo_00_wr_addr <= fifo_00_wr_addr + "0001";
    end if;
  end if;
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if (reset90_r = '1') then
      fifo_01_wr_addr <= "0000";
    elsif (transfer_done_0(1) = '1') then
      fifo_01_wr_addr <= fifo_01_wr_addr + "0001";
    end if;
  end if;
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_02_wr_addr <= "0000";
    elsif (transfer_done_0(2) = '1') then
      fifo_02_wr_addr <= fifo_02_wr_addr + "0001";
    end if;
  end if;
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_03_wr_addr <= "0000";
    elsif (transfer_done_0(3) = '1') then
      fifo_03_wr_addr <= fifo_03_wr_addr + "0001";
    end if;
  end if;
end process;
----------------------------------------------------------
process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_10_wr_addr <= "0000";
    elsif (transfer_done_1(0) = '1') then
      fifo_10_wr_addr <= fifo_10_wr_addr + "0001";
    end if;
  end if;
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_11_wr_addr <= "0000";
    elsif (transfer_done_1(1) = '1') then
      fifo_11_wr_addr <= fifo_11_wr_addr + "0001";
    end if;
  end if;
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_12_wr_addr <= "0000";
    elsif (transfer_done_1(2) = '1') then
      fifo_12_wr_addr <= fifo_12_wr_addr + "0001";
    end if;
  end if;
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_13_wr_addr <= "0000";
    elsif (transfer_done_1(3) = '1') then
      fifo_13_wr_addr <= fifo_13_wr_addr + "0001";
    end if;
  end if;
end process;

----------------------------------------------------------
process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_20_wr_addr <= "0000";
    elsif (transfer_done_2(0) = '1') then
      fifo_20_wr_addr <= fifo_20_wr_addr + "0001";
    end if;
  end if;
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_21_wr_addr <= "0000";
    elsif (transfer_done_2(1) = '1') then
      fifo_21_wr_addr <= fifo_21_wr_addr + "0001";
    end if;
  end if;
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_22_wr_addr <= "0000";
    elsif (transfer_done_2(2) = '1') then
      fifo_22_wr_addr <= fifo_22_wr_addr + "0001";
    end if;
  end if;
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_23_wr_addr <= "0000";
    elsif (transfer_done_2(3) = '1') then
      fifo_23_wr_addr <= fifo_23_wr_addr + "0001";
    end if;
  end if;
end process;

----------------------------------------------------------
process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_30_wr_addr <= "0000";
    elsif (transfer_done_3(0) = '1') then
      fifo_30_wr_addr <= fifo_30_wr_addr + "0001";
    end if;
  end if;
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_31_wr_addr <= "0000";
    elsif (transfer_done_3(1) = '1') then
      fifo_31_wr_addr <= fifo_31_wr_addr + "0001";
    end if;
  end if;
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_32_wr_addr <= "0000";
    elsif (transfer_done_3(2) = '1') then
      fifo_32_wr_addr <= fifo_32_wr_addr + "0001";
    end if;
  end if;
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_33_wr_addr <= "0000";
    elsif (transfer_done_3(3) = '1') then
      fifo_33_wr_addr <= fifo_33_wr_addr + "0001";
    end if;
  end if;
end process;

----------------------------------------------------------
process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_40_wr_addr <= "0000";
    elsif (transfer_done_4(0) = '1') then
      fifo_40_wr_addr <= fifo_40_wr_addr + "0001";
    end if;
  end if;
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_41_wr_addr <= "0000";
    elsif (transfer_done_4(1) = '1') then
      fifo_41_wr_addr <= fifo_41_wr_addr + "0001";
    end if;
  end if;
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_42_wr_addr <= "0000";
    elsif (transfer_done_4(2) = '1') then
      fifo_42_wr_addr <= fifo_42_wr_addr + "0001";
    end if;
  end if;
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_43_wr_addr <= "0000";
    elsif (transfer_done_4(3) = '1') then
      fifo_43_wr_addr <= fifo_43_wr_addr + "0001";
    end if;
  end if;
end process;

----------------------------------------------------------
process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_50_wr_addr <= "0000";
    elsif (transfer_done_5(0) = '1') then
      fifo_50_wr_addr <= fifo_50_wr_addr + "0001";
    end if;
  end if;
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_51_wr_addr <= "0000";
    elsif (transfer_done_5(1) = '1') then
      fifo_51_wr_addr <= fifo_51_wr_addr + "0001";
    end if;
  end if;
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_52_wr_addr <= "0000";
    elsif (transfer_done_5(2) = '1') then
      fifo_52_wr_addr <= fifo_52_wr_addr + "0001";
    end if;
  end if;
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_53_wr_addr <= "0000";
    elsif (transfer_done_5(3) = '1') then
      fifo_53_wr_addr <= fifo_53_wr_addr + "0001";
    end if;
  end if;
end process;

----------------------------------------------------------
process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_60_wr_addr <= "0000";
    elsif (transfer_done_6(0) = '1') then
      fifo_60_wr_addr <= fifo_60_wr_addr + "0001";
    end if;
  end if;
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_61_wr_addr <= "0000";
    elsif (transfer_done_6(1) = '1') then
      fifo_61_wr_addr <= fifo_61_wr_addr + "0001";
    end if;
  end if;
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_62_wr_addr <= "0000";
    elsif (transfer_done_6(2) = '1') then
      fifo_62_wr_addr <= fifo_62_wr_addr + "0001";
    end if;
  end if;
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_63_wr_addr <= "0000";
    elsif (transfer_done_6(3) = '1') then
      fifo_63_wr_addr <= fifo_63_wr_addr + "0001";
    end if;
  end if;
end process;

----------------------------------------------------------
process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_70_wr_addr <= "0000";
    elsif (transfer_done_7(0) = '1') then
      fifo_70_wr_addr <= fifo_70_wr_addr + "0001";
    end if;
  end if;
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_71_wr_addr <= "0000";
    elsif (transfer_done_7(1) = '1') then
      fifo_71_wr_addr <= fifo_71_wr_addr + "0001";
    end if;
  end if;
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_72_wr_addr <= "0000";
    elsif (transfer_done_7(2) = '1') then
      fifo_72_wr_addr <= fifo_72_wr_addr + "0001";
    end if;
  end if;
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_73_wr_addr <= "0000";
    elsif (transfer_done_7(3) = '1') then
      fifo_73_wr_addr <= fifo_73_wr_addr + "0001";
    end if;
  end if;
end process;

----------------------------------------------------------
process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_80_wr_addr <= "0000";
    elsif (transfer_done_8(0) = '1') then
      fifo_80_wr_addr <= fifo_80_wr_addr + "0001";
    end if;
  end if;
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_81_wr_addr <= "0000";
    elsif (transfer_done_8(1) = '1') then
      fifo_81_wr_addr <= fifo_81_wr_addr + "0001";
    end if;
  end if;
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_82_wr_addr <= "0000";
    elsif (transfer_done_8(2) = '1') then
      fifo_82_wr_addr <= fifo_82_wr_addr + "0001";
    end if;
  end if;
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_83_wr_addr <= "0000";
    elsif (transfer_done_8(3) = '1') then
      fifo_83_wr_addr <= fifo_83_wr_addr + "0001";
    end if;
  end if;
end process;




--***********************************************************************
--    Read Data Capture Module Instantiations
--


-------------------------------------------------------------------------------------------------------------------------------------------------
--**************************************************************************************************
-- rst_dqs_div internal delay to match dqs internal delay
--**************************************************************************************************
rst_dqs_div_delay0 : dqs_delay port map (
	                                 clk_in   => rst_dqs_div_int,  --rst_dqs_div, --
	                                 sel_in   => delay_sel,
	                                 clk_out  => rst_dqs_div_delayed
	                                 );

--**************************************************************************************************
-- DQS Internal Delay Circuit implemented in LUTs
--**************************************************************************************************

-- Internal Clock Delay circuit placed in the first column (for falling edge data) adjacent to IOBs
dqs_delay0_col0 : dqs_delay port map (
	                              clk_in   => dqs_int_delay_in0,
	                              sel_in   => delay_sel,
	                              clk_out  => dqs_delayed_col0(0)
	                             );

-- Internal Clock Delay circuit placed in the second column (for rising edge data) adjacent to IOBs
dqs_delay0_col1 : dqs_delay port map (
	                              clk_in   => dqs_int_delay_in0,
	                              sel_in   => delay_sel,
	                              clk_out  => dqs_delayed_col1(0)
	                             );

-- Internal Clock Delay circuit placed in the first column (for falling edge data) adjacent to IOBs
dqs_delay1_col0 : dqs_delay port map (
	                              clk_in   => dqs_int_delay_in1,
	                              sel_in   => delay_sel,
	                              clk_out  => dqs_delayed_col0(1)
	                             );

-- Internal Clock Delay circuit placed in the second column (for rising edge data) adjacent to IOBs
dqs_delay1_col1 : dqs_delay port map (
	                              clk_in   => dqs_int_delay_in1,
	                              sel_in   => delay_sel,
	                              clk_out  => dqs_delayed_col1(1)
	                             );

-- Internal Clock Delay circuit placed in the first column (for falling edge data) adjacent to IOBs
dqs_delay2_col0 : dqs_delay port map (
	                              clk_in   => dqs_int_delay_in2,
	                              sel_in   => delay_sel,
	                              clk_out  => dqs_delayed_col0(2)
	                             );

-- Clock Delay circuit placed in the second column (for rising edge data) adjacent to IOBs
dqs_delay2_col1 : dqs_delay port map (
	                              clk_in   => dqs_int_delay_in2,
	                              sel_in   => delay_sel,
	                              clk_out  => dqs_delayed_col1(2)
	                             );

-- Internal Clock Delay circuit placed in the first column (for falling edge data) adjacent to IOBs
dqs_delay3_col0 : dqs_delay port map (
	                              clk_in   => dqs_int_delay_in3,
	                              sel_in   => delay_sel,
	                              clk_out  => dqs_delayed_col0(3)
	                             );

-- Internal Clock Delay circuit placed in the second column (for rising edge data) adjacent to IOBs
dqs_delay3_col1 : dqs_delay port map (
	                              clk_in   => dqs_int_delay_in3,
	                              sel_in   => delay_sel,
	                              clk_out  => dqs_delayed_col1(3)
	                             );

-- Internal Clock Delay circuit placed in the first column (for falling edge data) adjacent to IOBs
dqs_delay4_col0 : dqs_delay port map (
	                              clk_in   => dqs_int_delay_in4,
	                              sel_in   => delay_sel,
	                              clk_out  => dqs_delayed_col0(4)
	                             );

-- Internal Clock Delay circuit placed in the second column (for rising edge data) adjacent to IOBs
dqs_delay4_col1 : dqs_delay port map (
	                              clk_in   => dqs_int_delay_in4,
	                              sel_in   => delay_sel,
	                              clk_out  => dqs_delayed_col1(4)
	                             );

-- Internal Clock Delay circuit placed in the first column (for falling edge data) adjacent to IOBs
dqs_delay5_col0 : dqs_delay port map (
	                              clk_in   => dqs_int_delay_in5,
	                              sel_in   => delay_sel,
	                              clk_out  => dqs_delayed_col0(5)
	                             );

-- Internal Clock Delay circuit placed in the second column (for rising edge data) adjacent to IOBs
dqs_delay5_col1 : dqs_delay port map (
	                              clk_in   => dqs_int_delay_in5,
	                              sel_in   => delay_sel,
	                              clk_out  => dqs_delayed_col1(5)
	                             );

-- Internal Clock Delay circuit placed in the first column (for falling edge data) adjacent to IOBs
dqs_delay6_col0 : dqs_delay port map (
	                              clk_in   => dqs_int_delay_in6,
	                              sel_in   => delay_sel,
	                              clk_out  => dqs_delayed_col0(6)
	                             );

-- Internal Clock Delay circuit placed in the second column (for rising edge data) adjacent to IOBs
dqs_delay6_col1 : dqs_delay port map (
	                              clk_in   => dqs_int_delay_in6,
	                              sel_in   => delay_sel,
	                              clk_out  => dqs_delayed_col1(6)
	                             );

-- Internal Clock Delay circuit placed in the first column (for falling edge data) adjacent to IOBs
dqs_delay7_col0 : dqs_delay port map (
	                              clk_in   => dqs_int_delay_in7,
	                              sel_in   => delay_sel,
	                              clk_out  => dqs_delayed_col0(7)
	                             );

-- Internal Clock Delay circuit placed in the second column (for rising edge data) adjacent to IOBs
dqs_delay7_col1 : dqs_delay port map (
	                              clk_in   => dqs_int_delay_in7,
	                              sel_in   => delay_sel,
	                              clk_out  => dqs_delayed_col1(7)
	                             );

-- Internal Clock Delay circuit placed in the first column (for falling edge data) adjacent to IOBs
dqs_delay8_col0 : dqs_delay port map (
	                              clk_in   => dqs_int_delay_in8,
	                              sel_in   => delay_sel,
	                              clk_out  => dqs_delayed_col0(8)
	                             );

-- Internal Clock Delay circuit placed in the second column (for rising edge data) adjacent to IOBs
dqs_delay8_col1 : dqs_delay port map (
	                              clk_in   => dqs_int_delay_in8,
	                              sel_in   => delay_sel,
	                              clk_out  => dqs_delayed_col1(8)
	                             );

--------------------------------------------------------------------------------------------------------------------------------------------------
--***************************************************************************************************
-- DQS Divide by 2 instantiations
--***************************************************************************************************

ddr2_dqs_div0 : ddr2_dqs_div
port map (
          dqs           => dqs_delayed_col0(0),
          dqs1          => dqs_delayed_col1(0),
          reset         => reset_r,
          rst_dqs_div_delayed   => rst_dqs_div_delayed,
          dqs_divn      => dqs_div_col0(0),
          dqs_divp      => dqs_div_col1(0)
         );

ddr2_dqs_div1 : ddr2_dqs_div
port map (
          dqs           => dqs_delayed_col0(1),
          dqs1          => dqs_delayed_col1(1),
          reset         => reset_r,
          rst_dqs_div_delayed   => rst_dqs_div_delayed,
          dqs_divn      => dqs_div_col0(1),
          dqs_divp      => dqs_div_col1(1)
         );

ddr2_dqs_div2 : ddr2_dqs_div
port map (
          dqs           => dqs_delayed_col0(2),
          dqs1          => dqs_delayed_col1(2),
          reset         => reset_r,
          rst_dqs_div_delayed   => rst_dqs_div_delayed,
          dqs_divn      => dqs_div_col0(2),
          dqs_divp      => dqs_div_col1(2)
         );

ddr2_dqs_div3 : ddr2_dqs_div
port map (
          dqs           => dqs_delayed_col0(3),
          dqs1          => dqs_delayed_col1(3),
          reset         => reset_r,
          rst_dqs_div_delayed   => rst_dqs_div_delayed,
          dqs_divn      => dqs_div_col0(3),
          dqs_divp      => dqs_div_col1(3)
         );

ddr2_dqs_div4 : ddr2_dqs_div
port map (
          dqs           => dqs_delayed_col0(4),
          dqs1          => dqs_delayed_col1(4),
          reset         => reset_r,
          rst_dqs_div_delayed   => rst_dqs_div_delayed,
          dqs_divn      => dqs_div_col0(4),
          dqs_divp      => dqs_div_col1(4)
         );

ddr2_dqs_div5 : ddr2_dqs_div
port map (
          dqs           => dqs_delayed_col0(5),
          dqs1          => dqs_delayed_col1(5),
          reset         => reset_r,
          rst_dqs_div_delayed   => rst_dqs_div_delayed,
          dqs_divn      => dqs_div_col0(5),
          dqs_divp      => dqs_div_col1(5)
         );

ddr2_dqs_div6 : ddr2_dqs_div
port map (
          dqs           => dqs_delayed_col0(6),
          dqs1          => dqs_delayed_col1(6),
          reset         => reset_r,
          rst_dqs_div_delayed   => rst_dqs_div_delayed,
          dqs_divn      => dqs_div_col0(6),
          dqs_divp      => dqs_div_col1(6)
         );

ddr2_dqs_div7 : ddr2_dqs_div
port map (
          dqs           => dqs_delayed_col0(7),
          dqs1          => dqs_delayed_col1(7),
          reset         => reset_r,
          rst_dqs_div_delayed   => rst_dqs_div_delayed,
          dqs_divn      => dqs_div_col0(7),
          dqs_divp      => dqs_div_col1(7)
         );

ddr2_dqs_div8 : ddr2_dqs_div
port map (
          dqs           => dqs_delayed_col0(8),
          dqs1          => dqs_delayed_col1(8),
          reset         => reset_r,
          rst_dqs_div_delayed   => rst_dqs_div_delayed,
          dqs_divn      => dqs_div_col0(8),
          dqs_divp      => dqs_div_col1(8)
         );

--------------------------------------------------------------------------------------------------------------------------------------------
--****************************************************************************************************************
-- Transfer done instantiations (One instantiation peer strobe)
--****************************************************************************************************************

ddr2_transfer_done0 : ddr2_transfer_done
  port map (
            clk0            => clk,
            clk90           => clk90,
           reset           => reset_r,
            reset90         => reset90_r,
            reset180        => reset180_r,
            reset270        => reset270_r,
            dqs_div         => dqs_div_col1(0),
            transfer_done0  => transfer_done_0(0),
            transfer_done1  => transfer_done_0(1),
            transfer_done2  => transfer_done_0(2),
            transfer_done3  => transfer_done_0(3)
           );

ddr2_transfer_done1 : ddr2_transfer_done
  port map (
            clk0            => clk,
            clk90           => clk90,
           reset           => reset_r,
            reset90         => reset90_r,
            reset180        => reset180_r,
            reset270        => reset270_r,
            dqs_div         => dqs_div_col1(1),
            transfer_done0  => transfer_done_1(0),
            transfer_done1  => transfer_done_1(1),
            transfer_done2  => transfer_done_1(2),
            transfer_done3  => transfer_done_1(3)
           );

ddr2_transfer_done2 : ddr2_transfer_done
  port map (
            clk0            => clk,
            clk90           => clk90,
            reset           => reset_r,
            reset90         => reset90_r,
            reset180        => reset180_r,
            reset270        => reset270_r,
            dqs_div         => dqs_div_col1(2),
            transfer_done0  => transfer_done_2(0),
            transfer_done1  => transfer_done_2(1),
            transfer_done2  => transfer_done_2(2),
            transfer_done3  => transfer_done_2(3)
           );

ddr2_transfer_done3 : ddr2_transfer_done
  port map (
            clk0            => clk,
            clk90           => clk90,
          reset           => reset_r,
            reset90         => reset90_r,
            reset180        => reset180_r,
            reset270        => reset270_r,
            dqs_div         => dqs_div_col1(3),
            transfer_done0  => transfer_done_3(0),
            transfer_done1  => transfer_done_3(1),
            transfer_done2  => transfer_done_3(2),
            transfer_done3  => transfer_done_3(3)
           );

ddr2_transfer_done4 : ddr2_transfer_done
  port map (
            clk0            => clk,
            clk90           => clk90,
           reset           => reset_r,
            reset90         => reset90_r,
            reset180        => reset180_r,
            reset270        => reset270_r,
            dqs_div         => dqs_div_col1(4),
            transfer_done0  => transfer_done_4(0),
            transfer_done1  => transfer_done_4(1),
            transfer_done2  => transfer_done_4(2),
            transfer_done3  => transfer_done_4(3)
           );

ddr2_transfer_done5 : ddr2_transfer_done
  port map (
            clk0            => clk,
            clk90           => clk90,
            reset           => reset_r,
            reset90         => reset90_r,
            reset180        => reset180_r,
            reset270        => reset270_r,
            dqs_div         => dqs_div_col1(5),
            transfer_done0  => transfer_done_5(0),
            transfer_done1  => transfer_done_5(1),
            transfer_done2  => transfer_done_5(2),
            transfer_done3  => transfer_done_5(3)
           );

ddr2_transfer_done6 : ddr2_transfer_done
  port map (
            clk0            => clk,
            clk90           => clk90,
           reset           => reset_r,
            reset90         => reset90_r,
            reset180        => reset180_r,
            reset270        => reset270_r,
            dqs_div         => dqs_div_col1(6),
            transfer_done0  => transfer_done_6(0),
            transfer_done1  => transfer_done_6(1),
            transfer_done2  => transfer_done_6(2),
            transfer_done3  => transfer_done_6(3)
           );

ddr2_transfer_done7 : ddr2_transfer_done
  port map (
            clk0            => clk,
            clk90           => clk90,
           reset           => reset_r,
            reset90         => reset90_r,
            reset180        => reset180_r,
            reset270        => reset270_r,
            dqs_div         => dqs_div_col1(7),
            transfer_done0  => transfer_done_7(0),
            transfer_done1  => transfer_done_7(1),
            transfer_done2  => transfer_done_7(2),
            transfer_done3  => transfer_done_7(3)
           );

ddr2_transfer_done8 : ddr2_transfer_done
  port map (
            clk0            => clk,
            clk90           => clk90,
          reset           => reset_r,
            reset90         => reset90_r,
            reset180        => reset180_r,
            reset270        => reset270_r,
            dqs_div         => dqs_div_col1(8),
            transfer_done0  => transfer_done_8(0),
            transfer_done1  => transfer_done_8(1),
            transfer_done2  => transfer_done_8(2),
            transfer_done3  => transfer_done_8(3)
           );

end   arc_data_read_controller_72bit_rl;

--******************************************************************************
--
--  Xilinx, Inc. 2002                 www.xilinx.com
--
--
--*******************************************************************************
--
--  File name :       data_write.vhd
--
--  Description :     This module comprises the write data paths for the
--                    DDR1 memory interface.
--
--
--  Date - revision : 10/16/2003
--
--  Author :          Maria George (Modifed by Sailaja)
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
--library synplify;
--use synplify.attributes.all;
--
-- pragma translate_off
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
-- pragma translate_on
--
entity   data_write_72bit  is
port(
	clk                : in std_logic;
	clk90              : in std_logic;
	reset_r            : in std_logic;
	reset90_r          : in std_logic;
	reset180_r         : in std_logic;
	reset270_r         : in std_logic;

	input_data         : in std_logic_vector(143 downto 0);
	byte_enable        : in std_logic_vector(17 downto 0);
	write_enable       : in std_logic;
	input_data_valid   : in std_logic;
	input_data_dummy   : in std_logic;

	write_en_val       : out std_logic;
	write_data_falling : out std_logic_vector(71 downto 0);
	write_data_rising  : out std_logic_vector(71 downto 0);
	data_mask_falling  : out std_logic_vector(8 downto 0);
	data_mask_rising   : out std_logic_vector(8 downto 0)
     );
end   data_write_72bit;

architecture   arc_data_write_72bit of   data_write_72bit    is

signal write_data             : std_logic_vector(143 downto 0);
signal write_data_falling_int : std_logic_vector(71 downto 0);
signal write_data_rising_int  : std_logic_vector(71 downto 0);
signal data_mask_falling_int  : std_logic_vector(8 downto 0);
signal data_mask_rising_int   : std_logic_vector(8 downto 0);

signal write_data_falling_val : std_logic_vector(71 downto 0);
signal write_data_rising_val  : std_logic_vector(71 downto 0);
signal data_mask_falling_val  : std_logic_vector(8 downto 0);
signal data_mask_rising_val   : std_logic_vector(8 downto 0);

signal clk180                 : std_logic;
signal clk270                 : std_logic;

attribute syn_preserve : boolean;
attribute syn_preserve of write_data_falling_val  : signal is true;
attribute syn_preserve of write_data_rising_val   : signal is true;
attribute syn_preserve of write_data_falling_int  : signal is true;
attribute syn_preserve of write_data_rising_int   : signal is true;
attribute syn_preserve of data_mask_falling_val   : signal is true;
attribute syn_preserve of data_mask_rising_val    : signal is true;
attribute syn_preserve of data_mask_falling_int   : signal is true;
attribute syn_preserve of data_mask_rising_int    : signal is true;

begin

clk270      <= not clk90;
clk180      <= not clk;

-- internal signal remapping
write_data_falling <= write_data_falling_val;
write_data_rising  <= write_data_rising_val ;
data_mask_falling  <= data_mask_falling_val ;
data_mask_rising   <= data_mask_rising_val  ;

-- first data sampling on clk
process(clk)
begin
	if clk'event and clk = '1' then
		if reset_r = '1' then
			write_data_falling_int    <= (others => '0');
			write_data_rising_int     <= (others => '0');
			data_mask_falling_int     <= (others => '0');
			data_mask_rising_int      <= (others => '0');
		else
			if input_data_dummy = '1' then
				data_mask_rising_int     <= "111111111";
				data_mask_falling_int    <= "111111111";
			end if;
			if input_data_valid = '1' then
				write_data_rising_int    <= input_data(71 downto 0);
				write_data_falling_int   <= input_data(143 downto 72);
				data_mask_rising_int     <= not byte_enable(8 downto 0);
				data_mask_falling_int    <= not byte_enable(17 downto 9);
			end if;
		end if;

	end if;
end process;

-- falling needs a second data sampling on clk180, rising is directly connected to the output
process(clk180)
begin
	if clk180'event and clk180 = '1' then
		if reset180_r = '1' then
			write_data_falling_val  <= (others => '0');
			data_mask_falling_val   <= (others => '0');
		else
			write_data_falling_val  <= write_data_falling_int;
			data_mask_falling_val   <= data_mask_falling_int;
		end if;
	end if;
end process;

write_data_rising_val <= write_data_rising_int;
data_mask_rising_val  <= data_mask_rising_int ;

-- write enable data path

process(clk270)
begin
	if clk270'event and clk270 = '1' then
		if reset270_r = '1' then
			write_en_val    <= '0';
		else
			write_en_val    <= write_enable;
		end if;
	end if;
end process;

end   arc_data_write_72bit;

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

--  File name :       controller.vhd
--
--  Description :
--                    Main DDR SDRAM controller block.
--
--  Date - revision : 08/10/2005
--
--  Author :          Pierre-Yves Droz
--


--                   #
--                   #
-- ## ##    #####   ####    #####   #####
--  ##  #  #     #   #     #     # #     #
--  #   #  #     #   #     #######  ###
--  #   #  #     #   #     #           ##
--  #   #  #     #   #  #  #     # #     #
-- ### ###  #####     ##    #####   #####

-- * The automatic row closing mechanism has been removed as the regular occurence of refreshes forces precharges more often than needed
-- * To ensure proper timing closure, we use the set bit of the io register to toggle the control pads during init
-- * The controller does speculative execution when a request comes in for read or write. The command is cancelled in the pad register if a precharge
--     needs to be done before accessing the row

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

entity controller is
generic(
	bank_management        : integer := 0
);
port(
	-- system signals
	clk                    : in  std_logic;
	reset                  : in  std_logic;

	-- user interface
	user_get_data          : out std_logic;
	user_col_address       : in  std_logic_vector((column_address_p - 1) downto 0);
	user_row_address       : in  std_logic_vector((row_address_p - 1) downto 0);
	user_bank_address      : in  std_logic_vector((bank_address_p - 1) downto 0);
	user_rank_address      : in  std_logic;
	user_read              : in  std_logic;
	user_write             : in  std_logic;
	user_half_burst        : in  std_logic := '0';
	user_ready             : out std_logic := '0';

	-- pad control
	ddr_rasb               : out std_logic;
	ddr_casb               : out std_logic;
	ddr_web                : out std_logic;
	ddr_ba                 : out std_logic_vector((bank_address_p-1) downto 0);
	ddr_address            : out std_logic_vector((row_address_p-1) downto 0);
	ddr_csb                : out std_logic_vector(1 downto 0);
	ddr_rst_dqs_div_out    : out std_logic;
	ddr_force_nop          : out std_logic;
	ddr_cke                : out std_logic;
	ddr_ODT                : out std_logic_vector(1 downto 0);

	-- init pad control
	ddr_rasb_init          : out std_logic;
	ddr_casb_init          : out std_logic;
	ddr_web_init           : out std_logic;
	ddr_ba_init            : out std_logic_vector((bank_address_p-1) downto 0);
	ddr_address_init       : out std_logic_vector((row_address_p-1) downto 0);
	ddr_csb_init           : out std_logic_vector(1 downto 0);

	-- data path control
	dqs_enable             : out std_logic;
	dqs_reset              : out std_logic;
	write_enable           : out std_logic;
	disable_data           : out std_logic;
	disable_data_valid     : out std_logic;
	input_data_valid       : out std_logic;
	input_data_dummy       : out std_logic
);
end controller;

architecture arc_controller of controller is

function conv(b:std_logic_vector) return integer is
begin
	if bank_management = 1 then
		return conv_integer(b);
	else
		return 0;
	end if;
end;

attribute syn_noprune  : boolean;

constant managed_banks : integer := 3*bank_management;

-- declarations for array of signals
type cnt_array_2    is array (managed_banks downto 0) of std_logic_vector(1 downto 0);
type cnt_array_3    is array (managed_banks downto 0) of std_logic_vector(2 downto 0);
type cnt_array_4    is array (managed_banks downto 0) of std_logic_vector(3 downto 0);
type csb_array      is array (managed_banks downto 0) of std_logic_vector(1 downto 0);
type row_addr_array is array (managed_banks downto 0) of std_logic_vector((row_address_p-1) downto 0);

type fsm_state is (
			INIT_WAIT_POWER_UP,
			INIT_WAIT_01_COMMAND,
			INIT_WAIT_02_COMMAND,
			INIT_WAIT_03_COMMAND,
			INIT_WAIT_04_COMMAND,
			INIT_WAIT_05_COMMAND,
			INIT_WAIT_06_COMMAND,
			INIT_WAIT_07_COMMAND,
			INIT_WAIT_08_COMMAND,
			INIT_WAIT_09_COMMAND,
			INIT_WAIT_10_COMMAND,
			INIT_WAIT_11_COMMAND,
			INIT_WAIT_12_COMMAND,
			INIT_WAIT_COMPLETION,
			INIT_COMPLETE
		);
signal init_state: fsm_state;

	-- timming constants
	-- init
	constant POWERUP_CNT       : std_logic_vector(3 downto 0) := "1111";
	constant CLKLOCK_CNT       : std_logic_vector(6 downto 0)  := "1010000";
	constant TRPA_CNT          : std_logic_vector(2 downto 0)  := "100";
	constant TMRD_CNT          : std_logic_vector(1 downto 0)  := "10";
	constant TRFC_CNT          : std_logic_vector(4 downto 0)  := "10101";
	constant PLLLOCK_CNT       : std_logic_vector(7 downto 0)  := "11001010";
	-- refresh
	constant REF_2_REF_CNT     : std_logic_vector(4 downto 0)  := "10101";
	constant REF_2_ACT_CNT     : std_logic_vector(4 downto 0)  := "10101";
	constant PRE_2_REF_CNT     : std_logic_vector(1 downto 0)  := "11";
	-- bus contentions
	constant ANY_RD_2_WR_CNT   : std_logic_vector(2 downto 0)  := "101";
	constant ANY_WR_2_RD_CNT   : std_logic_vector(2 downto 0)  := "110";
	constant ANY_RD_2_RD_CNT   : std_logic_vector(1 downto 0)  := "10";
	constant ANY_WR_2_WR_CNT   : std_logic_vector(1 downto 0)  := "10";
	-- bank management
	constant BK_WR_2_PRE_CNT   : std_logic_vector(2 downto 0)  := "111";
	constant BK_ACT_2_PRE_CNT  : std_logic_vector(3 downto 0)  := "1000";
	constant BK_ACT_2_RD_CNT   : std_logic_vector(1 downto 0)  := "11";
	constant BK_ACT_2_WR_CNT   : std_logic_vector(1 downto 0)  := "11";
	constant BK_PRE_2_ACT_CNT  : std_logic_vector(1 downto 0)  := "11";
	constant BK_RD_2_PRE_CNT   : std_logic_vector(1 downto 0)  := "10";
	-- command to ready
	constant REF_2_READY_CNT   : std_logic_vector(4 downto 0)  := "10101";
	constant PRE_2_READY_CNT   : std_logic_vector(1 downto 0)  := "11";
	constant RD_2_READY_CNT    : std_logic_vector(1 downto 0)  := "10";
	constant WR_2_READY_CNT    : std_logic_vector(1 downto 0)  := "10";
	-- maximum time
	constant REFRESHMAX_CNT    : std_logic_vector(10 downto 0) := "11000000001";

	-- command constant
	constant CMD_NOP           : std_logic_vector(2 downto 0) := "111";
	constant CMD_READ          : std_logic_vector(2 downto 0) := "101";
	constant CMD_WRITE         : std_logic_vector(2 downto 0) := "100";
	constant CMD_ACTIVE        : std_logic_vector(2 downto 0) := "011";
	constant CMD_PRECHARGE     : std_logic_vector(2 downto 0) := "010";
	constant CMD_REFRESH       : std_logic_vector(2 downto 0) := "001";
	constant CMD_MODESET       : std_logic_vector(2 downto 0) := "000";

	-- CSB constants
	constant CSB_BOTH          : std_logic_vector(1 downto 0) := "00";
	constant CSB_ZERO          : std_logic_vector(1 downto 0) := "10";
	constant CSB_ONE           : std_logic_vector(1 downto 0) := "01";
	constant CSB_NONE          : std_logic_vector(1 downto 0) := "11";

	-- ODT constants
	constant ODT_BOTH          : std_logic_vector(1 downto 0) := "11";
	constant ODT_ZERO          : std_logic_vector(1 downto 0) := "01";
	constant ODT_ONE           : std_logic_vector(1 downto 0) := "10";
	constant ODT_NONE          : std_logic_vector(1 downto 0) := "00";

	-- CKE constants
	constant CKE_DISABLED      : std_logic := '0';
	constant CKE_ENABLED       : std_logic := '1';

	-- address constants
	constant ADD_PADZEROS      : std_logic_vector((row_address_p-12) downto 0) := (others => '0');
	constant ADD_ALLBANKS      : std_logic_vector((row_address_p-1) downto 0) := ADD_PADZEROS & "10000000000";
	constant ADD_SINGLEBANK    : std_logic_vector((row_address_p-1) downto 0) := ADD_PADZEROS & "00000000000";
	constant ADD_AUTOPRE       : std_logic_vector((row_address_p-1) downto 0) := ADD_PADZEROS & "10000000000";
	constant ADD_NOAUTOPRE     : std_logic_vector((row_address_p-1) downto 0) := ADD_PADZEROS & "00000000000";

	-- bank address constants
	constant BA_MR             : std_logic_vector((bank_address_p-1) downto 0) := "00";
	constant BA_EMR1           : std_logic_vector((bank_address_p-1) downto 0) := "01";
	constant BA_EMR2           : std_logic_vector((bank_address_p-1) downto 0) := "10";
	constant BA_EMR3           : std_logic_vector((bank_address_p-1) downto 0) := "11";

	-- internal mode registers values
	constant REG_PADZEROS      : std_logic_vector((row_address_p-14) downto 0) := (others => '0');
	constant REG_MR            : std_logic_vector((row_address_p-1) downto 0) := REG_PADZEROS & "0010000110010";
	-- Fast-exit down mode-----------------------------------------------------------------------0
	-- Write Recovery = 3 ------------------------------------------------------------------------010
	-- PLL reset disabled ---------------------------------------------------------------------------0
	-- Test mode disabled ----------------------------------------------------------------------------0
	-- CAS latency = 3    -----------------------------------------------------------------------------011
    -- sequential burst   --------------------------------------------------------------------------------0
	-- burstlength = 4    ---------------------------------------------------------------------------------010
	constant REG_MR_DLL_RESET  : std_logic_vector((row_address_p-1) downto 0) := REG_PADZEROS & "0010100110010";
	-- Fast-exit down mode-----------------------------------------------------------------------0
	-- Write Recovery = 3 ------------------------------------------------------------------------010
	-- PLL reset enabled  ---------------------------------------------------------------------------1
	-- Test mode disabled ----------------------------------------------------------------------------0
	-- CAS latency = 3    -----------------------------------------------------------------------------011
    -- sequential burst   --------------------------------------------------------------------------------0
	-- burstlength = 4    ---------------------------------------------------------------------------------010
	constant REG_EMR1_OCD_DEF  : std_logic_vector((row_address_p-1) downto 0) := REG_PADZEROS & "0011110000100";
	-- output enabled     -----------------------------------------------------------------------0
	-- RDQS disabled      ------------------------------------------------------------------------0
	-- DQS# disabled      -------------------------------------------------------------------------1
	-- Default OCD state  --------------------------------------------------------------------------111
	-- Posted AL = 0      ------------------------------------------------------------------------------000
	-- RTT = 75 Ohm       -----------------------------------------------------------------------------0---1
    -- Full strength out  ----------------------------------------------------------------------------------0
	-- DLL enabled        -----------------------------------------------------------------------------------0
	constant REG_EMR1_OCD_EXIT : std_logic_vector((row_address_p-1) downto 0) := REG_PADZEROS & "0010000000100";
	-- output enabled     -----------------------------------------------------------------------0
	-- RDQS disabled      ------------------------------------------------------------------------0
	-- DQS# disabled      -------------------------------------------------------------------------1
	-- Default OCD state  --------------------------------------------------------------------------000
	-- Posted AL = 0      ------------------------------------------------------------------------------000
	-- RTT = 75 Ohm       -----------------------------------------------------------------------------0---1
    -- Full strength out  ----------------------------------------------------------------------------------0
	-- DLL enabled        -----------------------------------------------------------------------------------0
	constant REG_EMR2          : std_logic_vector((row_address_p-1) downto 0) := REG_PADZEROS & "0000000000000";
	-- reserved           -----------------------------------------------------------------------0000000000000
	constant REG_EMR3          : std_logic_vector((row_address_p-1) downto 0) := REG_PADZEROS & "0000000000000";
	-- reserved           -----------------------------------------------------------------------0000000000000

	constant NO_BANK           : std_logic_vector(managed_banks downto 0) := (others => '0');

	-- command signal
	signal ddr_cmd                 : std_logic_vector(2 downto 0) := CMD_NOP;
	signal ddr_cmd_init            : std_logic_vector(2 downto 0) := CMD_NOP;
	-- timing counters
	-- init
	signal powerup_counter         : std_logic_vector(3 downto 0) := "0000";
	signal clklock_counter         : std_logic_vector(6 downto 0)  := CLKLOCK_CNT;
	signal trpa_counter            : std_logic_vector(2 downto 0)  := TRPA_CNT;
	signal tmrd_counter            : std_logic_vector(1 downto 0)  := TMRD_CNT;
	signal trfc_counter            : std_logic_vector(4 downto 0)  := TRFC_CNT;
	signal plllock_counter         : std_logic_vector(7 downto 0)  := PLLLOCK_CNT;
	-- refresh
	signal ref_2_ref_counter       : std_logic_vector(4 downto 0)  := REF_2_REF_CNT;
	signal ref_2_act_counter       : std_logic_vector(4 downto 0)  := REF_2_ACT_CNT;
	signal pre_2_ref_counter       : std_logic_vector(1 downto 0)  := PRE_2_REF_CNT;
	-- bus contentions
	signal any_rd_2_wr_counter     : std_logic_vector(2 downto 0)  := ANY_RD_2_WR_CNT;
	signal any_wr_2_rd_counter     : std_logic_vector(2 downto 0)  := ANY_WR_2_RD_CNT;
	signal any_rd_2_rd_counter     : std_logic_vector(1 downto 0)  := ANY_RD_2_RD_CNT;
	signal any_wr_2_wr_counter     : std_logic_vector(1 downto 0)  := ANY_WR_2_WR_CNT;
	-- bank management
	signal bk_wr_2_pre_counter     : cnt_array_3 := (others => BK_WR_2_PRE_CNT );
	signal bk_act_2_pre_counter    : cnt_array_4 := (others => BK_ACT_2_PRE_CNT);
	signal bk_act_2_rd_counter     : cnt_array_2 := (others => BK_ACT_2_RD_CNT );
	signal bk_act_2_wr_counter     : cnt_array_2 := (others => BK_ACT_2_WR_CNT );
	signal bk_pre_2_act_counter    : cnt_array_2 := (others => BK_PRE_2_ACT_CNT);
	signal bk_rd_2_pre_counter     : cnt_array_2 := (others => BK_RD_2_PRE_CNT );
	-- command to ready
	signal ref_2_ready_counter     : std_logic_vector(4 downto 0)  := REF_2_READY_CNT;
	signal pre_2_ready_counter     : std_logic_vector(1 downto 0)  := PRE_2_READY_CNT;
	signal rd_2_ready_counter      : std_logic_vector(1 downto 0)  := RD_2_READY_CNT ;
	signal wr_2_ready_counter      : std_logic_vector(1 downto 0)  := WR_2_READY_CNT ;
	-- maximum time
	signal refreshmax_counter      : std_logic_vector(10 downto 0) := REFRESHMAX_CNT  ;
	-- timing ok signals
	signal time_ok_4_read          : std_logic_vector(managed_banks downto 0) := (others => '0');
	signal time_ok_4_write         : std_logic_vector(managed_banks downto 0) := (others => '0');
	signal time_ok_4_pre           : std_logic_vector(managed_banks downto 0) := (others => '0');
	signal time_ok_4_act           : std_logic_vector(managed_banks downto 0) := (others => '0');
	signal time_ok_4_ref           : std_logic                    := '0';
	-- timing counters reached signals
	-- init
	signal powerup_reached         : std_logic := '0';
	signal clklock_reached         : std_logic := '1';
	signal trpa_reached            : std_logic := '1';
	signal tmrd_reached            : std_logic := '1';
	signal trfc_reached            : std_logic := '1';
	signal plllock_reached         : std_logic := '1';
	-- refresh
	signal ref_2_ref_reached       : std_logic := '1';
	signal ref_2_act_reached       : std_logic := '1';
	signal pre_2_ref_reached       : std_logic := '1';
	-- bus contention
	signal any_rd_2_wr_reached     : std_logic := '1';
	signal any_wr_2_rd_reached     : std_logic := '1';
	signal any_rd_2_rd_reached     : std_logic := '1';
	signal any_wr_2_wr_reached     : std_logic := '1';
	-- bank management
	signal bk_wr_2_pre_reached     : std_logic_vector(managed_banks downto 0) := (others => '1');
	signal bk_act_2_pre_reached    : std_logic_vector(managed_banks downto 0) := (others => '1');
	signal bk_act_2_rd_reached     : std_logic_vector(managed_banks downto 0) := (others => '1');
	signal bk_act_2_wr_reached     : std_logic_vector(managed_banks downto 0) := (others => '1');
	signal bk_pre_2_act_reached    : std_logic_vector(managed_banks downto 0) := (others => '1');
	signal bk_rd_2_pre_reached     : std_logic_vector(managed_banks downto 0) := (others => '1');
	-- command to ready
	signal ref_2_ready_reached     : std_logic := '1';
	signal pre_2_ready_reached     : std_logic := '1';
	signal rd_2_ready_reached      : std_logic := '1';
	signal wr_2_ready_reached      : std_logic := '1';
	-- maximum time
	signal refreshmax_reached      : std_logic := '1';

	-- timming counters almost reached signals
	-- command to ready
	signal ref_2_ready_almost      : std_logic := '0';
	signal pre_2_ready_almost      : std_logic := '0';

	-- opened bank state
	signal bank_is_opened          : std_logic_vector(managed_banks downto 0) := (others => '0');
	signal opened_row              : row_addr_array               := (others => (others => '0'));
	signal opened_bank             : std_logic_vector(1 downto 0) := (others => '0');

	-- last accessed rank state
	signal last_rank_read          : std_logic := '0';

	-- precharge before refresh test
	signal launch_pre_for_ref      : std_logic := '0';

	-- initialisation done
	signal init_done               : std_logic := '0';
	signal init_done_delay         : std_logic := '0';

	-- address conflict
	signal address_conflict        : std_logic := '0';

	-- csb decoding
	signal user_csb                : std_logic_vector(1 downto 0);

	-- refresh internal command
	signal auto_refresh            : std_logic;
	signal do_auto_refresh         : std_logic := '0';
	signal next_bank_to_precharge  : std_logic_vector(1 downto 0) := (others => '0');
	signal bank_needs_precharge    : std_logic := '0';

	-- registered and latched input signals
	signal reg_col_address         : std_logic_vector((column_address_p - 1) downto 0) := (others => '0');
	signal reg_row_address         : std_logic_vector((row_address_p - 1) downto 0) := (others => '0');
	signal reg_bank_address        : std_logic_vector((bank_address_p - 1) downto 0) := (others => '0');
	signal reg_rank_address        : std_logic := '0';
	signal reg_read                : std_logic := '0';
	signal reg_write               : std_logic := '0';
	signal reg_half_burst          : std_logic := '0';
	signal reg_csb                 : std_logic_vector(1 downto 0);
	signal latch_col_address       : std_logic_vector((column_address_p - 1) downto 0);
	signal latch_row_address       : std_logic_vector((row_address_p - 1) downto 0);
	signal latch_bank_address      : std_logic_vector((bank_address_p - 1) downto 0);
	signal latch_rank_address      : std_logic;
	signal latch_read              : std_logic;
	signal latch_write             : std_logic;
	signal latch_half_burst        : std_logic;
	signal latch_csb               : std_logic_vector(1 downto 0);

	-- data request from the user
	signal user_get_data_next      : std_logic := '0';
	signal user_use_dummy_next     : std_logic := '0';
	signal user_use_dummy          : std_logic := '0';

	-- internal version of output signals
	signal input_data_valid_int    : std_logic := '0';
	signal input_data_dummy_int    : std_logic := '0';
	signal disable_data_int        : std_logic := '0';
	attribute syn_noprune of disable_data_int: signal is true;
	signal disable_data_valid_int  : std_logic := '0';
	attribute syn_noprune of disable_data_valid_int: signal is true;
	signal user_get_data_int       : std_logic := '0';
	signal user_ready_int          : std_logic := '0';
	signal dqs_reset_int           : std_logic := '0';
	signal dqs_enable_int          : std_logic := '0';
	signal write_enable_int        : std_logic := '0';
	signal ddr_rst_dqs_div_out_int : std_logic := '0';
	attribute syn_noprune of ddr_rst_dqs_div_out_int: signal is true;
	signal ddr_csb_int             : std_logic_vector(1 downto 0) := CSB_NONE;
	signal ddr_odt_int             : std_logic_vector(1 downto 0) := ODT_NONE;
	attribute syn_noprune of ddr_csb_int: signal is true;
	signal ddr_ba_int              : std_logic_vector((bank_address_p - 1) downto 0) := (others => '0');
	signal ddr_address_int         : std_logic_vector((row_address_p - 1) downto 0) := (others => '0');
	signal ddr_cke_int             : std_logic := CKE_DISABLED;
	signal ddr_force_nop_int       : std_logic := '0';

	-- enable receive path
	signal receive_enable          : std_logic := '0';
	signal receive_enable_delay1   : std_logic := '0';
	signal receive_enable_delay2   : std_logic := '0';
	signal receive_enable_next     : std_logic := '0';

	-- receive path invalidation
	signal disable_data_previous0  : std_logic := '0';
	signal disable_data_previous1  : std_logic := '0';
	signal disable_data_previous2  : std_logic := '0';
	signal disable_data_previous3  : std_logic := '0';

	-- enable sending path
	signal write_enable_delay1     : std_logic := '0';
	signal write_enable_delay2     : std_logic := '0';

	-- abort command mode signal
	signal abort_read              : std_logic;
	signal abort_write             : std_logic;
	signal valid_read              : std_logic;
	signal valid_write             : std_logic;

	-- pipeline empty signal
	signal pipeline_not_empty      : std_logic := '0';

	-- tell what was the command executed on the previous cycles
	signal last_was_read           : std_logic := '0';
	signal last_was_write          : std_logic := '0';
	signal last_was_precharge      : std_logic := '0';
	signal last_was_active         : std_logic := '0';
	signal last_was_refresh        : std_logic := '0';
	signal last_last_was_read      : std_logic := '0';
	signal last_last_was_write     : std_logic := '0';
	signal last_last_was_precharge : std_logic := '0';
	signal last_last_was_active    : std_logic := '0';
	signal last_last_was_refresh   : std_logic := '0';

begin

-- #######  #####  ##   ##
--  #    # #     #  #   #
--  #      #        ## ##
--  #  #   #        ## ##
--  ####    #####   # # #
--  #  #         #  # # #
--  #            #  #   #
--  #      #     #  #   #
-- ####     #####  ### ###

controller_fsm: process(clk)
begin
	if clk'event and clk = '1' then
		if reset = '1' then
            --                                   #
            --                                   #
            -- ### ##   #####   #####   #####   ####
            --   ##  # #     # #     # #     #   #
            --   #     #######  ###    #######   #
            --   #     #           ##  #         #
            --   #     #     # #     # #     #   #  #
            -- #####    #####   #####   #####     ##

			-- disable outputs and clock
			ddr_cmd                 <= CMD_NOP;
			ddr_csb_int             <= CSB_NONE;
			ddr_odt_int             <= ODT_NONE;
			ddr_ba_int              <= (others => '0');
			ddr_address_int         <= (others => '0');
			ddr_cke_int             <= CKE_DISABLED;
			-- disable the data path
			input_data_valid_int    <= '0';
			input_data_dummy_int    <= '0';
			disable_data_int        <= '0';
			disable_data_valid_int  <= '0';
			dqs_enable_int          <= '0';
			dqs_reset_int           <= '0';
			write_enable_delay1     <= '0';
			write_enable_delay2     <= '0';
			write_enable_int        <= '0';
			receive_enable          <= '0';
			receive_enable_delay1   <= '0';
			receive_enable_delay2   <= '0';
			receive_enable_next     <= '0';
			disable_data_previous0  <= '0';
			disable_data_previous1  <= '0';
			disable_data_previous2  <= '0';
			disable_data_previous3  <= '0';
			ddr_rst_dqs_div_out_int <= '0';
			-- user interface disabled
			user_ready_int          <= '0';
			user_ready              <= '0';
			user_get_data_int       <= '0';
			user_get_data_next      <= '0';
			user_use_dummy          <= '0';
			user_use_dummy_next     <= '0';
			-- initial state
			init_state              <= INIT_WAIT_POWER_UP;
			-- timing counters reset
			-- init
			powerup_counter         <=  "0000"          ;
			trpa_counter            <=  TRPA_CNT        ;
			tmrd_counter            <=  TMRD_CNT        ;
			trfc_counter            <=  TRFC_CNT        ;
			plllock_counter         <=  PLLLOCK_CNT     ;
			clklock_counter         <=  CLKLOCK_CNT     ;
			-- refresh
			ref_2_ref_counter       <= REF_2_REF_CNT    ;
			ref_2_act_counter       <= REF_2_ACT_CNT    ;
			pre_2_ref_counter       <= PRE_2_REF_CNT    ;
			-- bus contentions
			any_rd_2_wr_counter     <= ANY_RD_2_WR_CNT  ;
			any_wr_2_rd_counter     <= ANY_WR_2_RD_CNT  ;
			any_rd_2_rd_counter     <= ANY_RD_2_RD_CNT  ;
			any_wr_2_wr_counter     <= ANY_WR_2_WR_CNT  ;
			-- bank management
			bk_wr_2_pre_counter     <= (others => BK_WR_2_PRE_CNT );
			bk_act_2_pre_counter    <= (others => BK_ACT_2_PRE_CNT);
			bk_act_2_rd_counter     <= (others => BK_ACT_2_RD_CNT );
			bk_act_2_wr_counter     <= (others => BK_ACT_2_WR_CNT );
			bk_pre_2_act_counter    <= (others => BK_PRE_2_ACT_CNT);
			bk_rd_2_pre_counter     <= (others => BK_RD_2_PRE_CNT );
			-- command to ready
			ref_2_ready_counter     <=  REF_2_READY_CNT ;
			pre_2_ready_counter     <=  PRE_2_READY_CNT ;
			rd_2_ready_counter      <=  RD_2_READY_CNT  ;
			wr_2_ready_counter      <=  WR_2_READY_CNT  ;
			-- max time
			refreshmax_counter      <=  REFRESHMAX_CNT  ;
			-- timing ok signals
			time_ok_4_read          <= (others => '0');
			time_ok_4_write         <= (others => '0');
			time_ok_4_pre           <= (others => '0');
			time_ok_4_act           <= (others => '0');
			time_ok_4_ref           <= '0';
			-- timming counters reached signals
			-- init
			powerup_reached         <= '0';
			clklock_reached         <= '1';
			trpa_reached            <= '1';
			tmrd_reached            <= '1';
			trfc_reached            <= '1';
			plllock_reached         <= '1';
			-- refresh
			ref_2_ref_reached       <= '1';
			ref_2_act_reached       <= '1';
			pre_2_ref_reached       <= '1';
			-- bus contention
			any_rd_2_wr_reached     <= '1';
			any_wr_2_rd_reached     <= '1';
			any_rd_2_rd_reached     <= '1';
			any_wr_2_wr_reached     <= '1';
			-- bank management
			bk_wr_2_pre_reached     <= (others => '1');
			bk_act_2_pre_reached    <= (others => '1');
			bk_act_2_rd_reached     <= (others => '1');
			bk_act_2_wr_reached     <= (others => '1');
			bk_pre_2_act_reached    <= (others => '1');
			bk_rd_2_pre_reached     <= (others => '1');
			-- command to ready
			ref_2_ready_reached     <= '1';
			pre_2_ready_reached     <= '1';
			rd_2_ready_reached      <= '1';
			wr_2_ready_reached      <= '1';
			-- maximum time
			refreshmax_reached      <= '1';
			-- timming counters reached signals
			-- command to ready
			ref_2_ready_almost      <= '0';
			pre_2_ready_almost      <= '0';
			-- bank opened state
			bank_is_opened          <= (others => '0');
			opened_row              <= (others => (others => '0'));
			opened_bank             <= (others => '0');
			-- last accessed rank state
			last_rank_read          <= '0';
			-- precharge before refresh test
			launch_pre_for_ref      <= '0';
			-- initialisation done
			init_done               <= '0';
			init_done_delay         <= '0';
			-- registered input signals
			reg_col_address         <= (others => '0');
			reg_row_address         <= (others => '0');
			reg_bank_address        <= (others => '0');
			reg_rank_address        <= '0';
			reg_read                <= '0';
			reg_write               <= '0';
			reg_half_burst          <= '0';
			-- delayed refresh command
			do_auto_refresh         <= '0';
			next_bank_to_precharge  <= (others => '0');
			bank_needs_precharge    <= '0';
			-- pipeline empty signal
			pipeline_not_empty      <= '0';
			-- address conflict detect
			address_conflict        <= '0';
			-- tell what was the command executed on the previous cycle
			last_was_read           <= '0';
			last_was_write          <= '0';
			last_was_precharge      <= '0';
			last_was_active         <= '0';
			last_was_refresh        <= '0';
			last_last_was_read      <= '0';
			last_last_was_write     <= '0';
			last_last_was_precharge <= '0';
			last_last_was_active    <= '0';
			last_last_was_refresh   <= '0';
			-- init command signals
			ddr_csb_init            <= CSB_NONE;
			ddr_cmd_init            <= CMD_NOP;
			ddr_address_init        <= (others => '0');
			ddr_ba_init             <= (others => '0');
			-- abort signals
			ddr_force_nop_int       <= '0';
		else
			-- make sure the default value of chip selects is (none selected)
			ddr_csb_int         <= CSB_NONE;
			ddr_csb_init        <= CSB_NONE;
			-- make sure the default value of the abort signals is low
			ddr_force_nop_int   <= '0';
			-- delay the init_done signal
			init_done_delay     <= init_done;
			-- make sure the default value of the last command indicators is 0
			last_was_read       <= '0';
			last_was_write      <= '0';
			last_was_precharge  <= '0';
			last_was_active     <= '0';
			last_was_refresh    <= '0';
			-- delay the last command signals
			last_last_was_read       <= last_was_read     ;
			last_last_was_write      <= last_was_write    ;
			last_last_was_precharge  <= last_was_precharge;
			last_last_was_active     <= last_was_active   ;
			last_last_was_refresh    <= last_was_refresh  ;
			-- registered input signals
			if user_ready_int = '1' then
				reg_col_address     <= user_col_address ;
				reg_row_address     <= user_row_address ;
				reg_bank_address    <= user_bank_address;
				reg_rank_address    <= user_rank_address;
				reg_read            <= user_read        ;
				reg_write           <= user_write       ;
				reg_half_burst      <= user_half_burst  ;
	    		end if;

			--     ##                                                          ##
			--      #            #                                       #      #
			--      #            #                                       #      #
			--  #####   ####    ####    ####           ######   ####    ####    # ##
			-- #    #       #    #          #           #    #      #    #      ##  #
			-- #    #   #####    #      #####           #    #  #####    #      #   #
			-- #    #  #    #    #     #    #           #    # #    #    #      #   #
			-- #    #  #    #    #  #  #    #           #    # #    #    #  #   #   #
			--  ######  #### #    ##    #### #          #####   #### #    ##   ### ###
			--                                          #
			--                                         ###

			-- delaying of data request from the user
			user_get_data_next         <= '0';
			user_use_dummy_next        <= '0';
			user_get_data_int          <= user_get_data_next;
			user_use_dummy             <= user_use_dummy_next;
			-- signaling a valid data to the data path
			input_data_valid_int       <= user_get_data_int;
			-- signaling a dummy write to the data path
			input_data_dummy_int       <= user_use_dummy;
			-- delaying of receive enable
			receive_enable_next        <= '0';
			receive_enable             <= receive_enable_next;
			receive_enable_delay1      <= receive_enable;
			receive_enable_delay2      <= receive_enable_delay1;
			-- delaying of invalidate signals
			disable_data_previous0     <= '0';
			disable_data_previous1     <= disable_data_previous0;
			disable_data_previous2     <= disable_data_previous1;
			disable_data_previous3     <= disable_data_previous2;
			-- dqs div output reset
			ddr_rst_dqs_div_out_int    <= receive_enable_delay2;
			-- data invalidation mechanism
			disable_data_valid_int     <= receive_enable_delay2;
			disable_data_int           <= disable_data_previous3;
			-- write enable signal
			write_enable_delay1        <= '0';
			write_enable_delay2        <= write_enable_delay1;
			write_enable_int           <= write_enable_delay2;
			-- bring dqs enable down at the end of a burst
			if write_enable_int = '0' then
				dqs_enable_int  <= '0';
			end if;
			-- make sure the default value of dqs reset is (not reset)
			dqs_reset_int <= '0';
			-- if we are not currently bursting, reset the dqs circuitry and take the bus
			if write_enable_delay2 = '1' and write_enable_int = '0' and abort_write = '0' then
				dqs_enable_int  <= '1';
				dqs_reset_int   <= '1';
			end if;

			--                            ##     ##       #
			--                           #        #                      #
			--                           #        #                      #
			--  #####   #####  ## ##    ####      #     ###     #####   ####
			-- #     # #     #  ##  #    #        #       #    #     #   #
			-- #       #     #  #   #    #        #       #    #         #
			-- #       #     #  #   #    #        #       #    #         #
			-- #     # #     #  #   #    #        #       #    #     #   #  #
			--  #####   #####  ### ###  ####    #####   #####   #####     ##

			-- address conflict detection
			if user_ready_int = '1' and (user_read = '1' or user_write = '1') then
				if bank_management = 1 then
					if
					(
						bank_is_opened(conv(user_bank_address)) = '1'                 and
						user_row_address  /= opened_row(conv(user_bank_address))
					)
					then
						-- if we asked for a transaction in the cycle in any case we want to cancel the next command
						ddr_force_nop_int <= '1';
						address_conflict  <= '1';
						--
					end if;
				else
					if
					(
						bank_is_opened(0)   = '1'                                                and
						(user_row_address  /= opened_row(0) or user_bank_address  /= opened_bank)
					)
					then
						-- if we asked for a transaction in the cycle in any case we want to cancel the next command
						ddr_force_nop_int <= '1';
						address_conflict  <= '1';
						--
					end if;
				end if;
			end if;


            --                                   #
            --                                   #
            --  #####   #####  ##  ##  ## ##    ####    #####  ### ##   #####
            -- #     # #     #  #   #   ##  #    #     #     #   ##  # #     #
            -- #       #     #  #   #   #   #    #     #######   #      ###
            -- #       #     #  #   #   #   #    #     #         #         ##
            -- #     # #     #  #  ##   #   #    #  #  #     #   #     #     #
            --  #####   #####    ## ## ### ###    ##    #####  #####    #####

			-- counters
			-- init
			if powerup_reached        = '0' then powerup_counter       <= powerup_counter       + 1; end if;
			if clklock_reached        = '0' then clklock_counter       <= clklock_counter       + 1; end if;
			if trpa_reached           = '0' then trpa_counter          <= trpa_counter          + 1; end if;
			if tmrd_reached           = '0' then tmrd_counter          <= tmrd_counter          + 1; end if;
			if trfc_reached           = '0' then trfc_counter          <= trfc_counter          + 1; end if;
			if plllock_reached        = '0' then plllock_counter       <= plllock_counter       + 1; end if;
			-- refresh
			if ref_2_ref_reached      = '0' then ref_2_ref_counter     <= ref_2_ref_counter     + 1; end if;
			if ref_2_act_reached      = '0' then ref_2_act_counter     <= ref_2_act_counter     + 1; end if;
			if pre_2_ref_reached      = '0' then pre_2_ref_counter     <= pre_2_ref_counter     + 1; end if;
			-- bus contention
			if any_rd_2_wr_reached    = '0' then any_rd_2_wr_counter   <= any_rd_2_wr_counter   + 1; end if;
			if any_wr_2_rd_reached    = '0' then any_wr_2_rd_counter   <= any_wr_2_rd_counter   + 1; end if;
			-- bank management
			for bank_index in 0 to managed_banks loop
				if bk_wr_2_pre_reached(bank_index)   = '0' then bk_wr_2_pre_counter(bank_index)  <= bk_wr_2_pre_counter(bank_index)  + 1; end if;
				if bk_act_2_pre_reached(bank_index)  = '0' then bk_act_2_pre_counter(bank_index) <= bk_act_2_pre_counter(bank_index) + 1; end if;
				if bk_act_2_rd_reached(bank_index)   = '0' then bk_act_2_rd_counter(bank_index)  <= bk_act_2_rd_counter(bank_index)  + 1; end if;
				if bk_act_2_wr_reached(bank_index)   = '0' then bk_act_2_wr_counter(bank_index)  <= bk_act_2_wr_counter(bank_index)  + 1; end if;
				if bk_pre_2_act_reached(bank_index)  = '0' then bk_pre_2_act_counter(bank_index) <= bk_pre_2_act_counter(bank_index) + 1; end if;
				if bk_rd_2_pre_reached(bank_index)   = '0' then bk_rd_2_pre_counter(bank_index)  <= bk_rd_2_pre_counter(bank_index)  + 1; end if;
			end loop;
			-- command to ready
			if ref_2_ready_reached    = '0' then ref_2_ready_counter   <= ref_2_ready_counter   + 1; end if;
			if pre_2_ready_reached    = '0' then pre_2_ready_counter   <= pre_2_ready_counter   + 1; end if;
			if rd_2_ready_reached     = '0' then rd_2_ready_counter    <= rd_2_ready_counter    + 1; end if;
			if wr_2_ready_reached     = '0' then wr_2_ready_counter    <= wr_2_ready_counter    + 1; end if;
			-- max time
			if refreshmax_reached     = '0' then refreshmax_counter    <= refreshmax_counter    + 1; end if;

			-- counters overflow detect
			-- init
			if powerup_counter      = POWERUP_CNT     - 2 then powerup_reached      <= '1'; end if;
			if clklock_counter      = CLKLOCK_CNT     - 2 then clklock_reached      <= '1'; end if;
			if trpa_counter         = TRPA_CNT        - 2 then trpa_reached         <= '1'; end if;
			if tmrd_counter         = TMRD_CNT        - 2 then tmrd_reached         <= '1'; end if;
			if trfc_counter         = TRFC_CNT        - 2 then trfc_reached         <= '1'; end if;
			if plllock_counter      = PLLLOCK_CNT     - 2 then plllock_reached      <= '1'; end if;
			-- refresh
			if ref_2_ref_counter    = REF_2_REF_CNT   - 2 then ref_2_ref_reached    <= '1'; end if;
			if ref_2_act_counter    = REF_2_ACT_CNT   - 2 then ref_2_act_reached    <= '1'; end if;
			if pre_2_ref_counter    = PRE_2_REF_CNT   - 2 then pre_2_ref_reached    <= '1'; end if;
			-- bus contention
			if any_rd_2_wr_counter  = ANY_RD_2_WR_CNT - 2 then any_rd_2_wr_reached  <= '1'; end if;
			if any_wr_2_rd_counter  = ANY_WR_2_RD_CNT - 2 then any_wr_2_rd_reached  <= '1'; end if;
			-- bank management
			for bank_index in 0 to managed_banks loop
				if bk_wr_2_pre_counter(bank_index)     = BK_WR_2_PRE_CNT    - 2 then bk_wr_2_pre_reached(bank_index)     <= '1'; end if;
				if bk_act_2_pre_counter(bank_index)    = BK_ACT_2_PRE_CNT   - 2 then bk_act_2_pre_reached(bank_index)    <= '1'; end if;
				if bk_act_2_rd_counter(bank_index)     = BK_ACT_2_RD_CNT    - 2 then bk_act_2_rd_reached(bank_index)     <= '1'; end if;
				if bk_act_2_wr_counter(bank_index)     = BK_ACT_2_WR_CNT    - 2 then bk_act_2_wr_reached(bank_index)     <= '1'; end if;
				if bk_pre_2_act_counter(bank_index)    = BK_PRE_2_ACT_CNT   - 2 then bk_pre_2_act_reached(bank_index)    <= '1'; end if;
				if bk_rd_2_pre_counter(bank_index)     = BK_RD_2_PRE_CNT    - 2 then bk_rd_2_pre_reached(bank_index)     <= '1'; end if;
			end loop;
			-- command to ready
			if ref_2_ready_counter  = REF_2_READY_CNT - 2 then ref_2_ready_reached  <= '1'; end if;
			if pre_2_ready_counter  = PRE_2_READY_CNT - 2 then pre_2_ready_reached  <= '1'; end if;
			if rd_2_ready_counter   = RD_2_READY_CNT  - 2 then rd_2_ready_reached   <= '1'; end if;
			if wr_2_ready_counter   = WR_2_READY_CNT  - 2 then wr_2_ready_reached   <= '1'; end if;
			-- maximum time
			if refreshmax_counter   = REFRESHMAX_CNT  - 2 then refreshmax_reached   <= '1'; end if;
			-- counters almost reached detect
			if ref_2_ready_counter  = REF_2_READY_CNT - 3 then ref_2_ready_almost   <= '1'; else ref_2_ready_almost <= '0'; end if;
			if pre_2_ready_counter  = PRE_2_READY_CNT - 3 then pre_2_ready_almost   <= '1'; else pre_2_ready_almost <= '0'; end if;

			--    #               #
			--                           #
			--                           #
			--  ###    ## ##    ###     ####
			--    #     ##  #     #      #
			--    #     #   #     #      #
			--    #     #   #     #      #
			--    #     #   #     #      #  #
			--  #####  ### ###  #####     ##

			case init_state is
				-- wait for full power up of the DIMM
				when INIT_WAIT_POWER_UP =>
					-- bring cke up at the beginning of the count and then back down after some time
					if powerup_counter = X"0001" then
						ddr_cke_int      <= CKE_ENABLED;
					end if;

					-- wait for DDR power-up
					if powerup_reached = '1' then
						-- send a first NOP to the two ranks
						ddr_cmd_init     <= CMD_NOP;
						ddr_csb_init     <= CSB_BOTH;
						-- activate the clock
						ddr_cke_int      <= CKE_ENABLED;
						-- start the clklock counter
						clklock_counter   <= (others => '0');
						clklock_reached   <= '0';
						-- go to the next state
						init_state       <= INIT_WAIT_01_COMMAND;
					end if;
				-- first precharge
				when INIT_WAIT_01_COMMAND =>
					-- wait 400ns for the first clock lock
					if clklock_reached = '1' then
						-- send a precharge all command
						ddr_cmd_init     <= CMD_PRECHARGE;
						ddr_address_init <= ADD_ALLBANKS;
						ddr_csb_init     <= CSB_BOTH;
						-- start the t(RPA) counter
						trpa_counter     <= (others => '0');
						trpa_reached     <= '0';
						-- go to the next state
						init_state       <= INIT_WAIT_02_COMMAND;
					end if;
				-- load EMR2
				when INIT_WAIT_02_COMMAND =>
					-- wait until last precharge all finished
					if trpa_reached = '1' then
						-- Load EMR2
						ddr_cmd_init     <= CMD_MODESET;
						ddr_address_init <= REG_EMR2;
						ddr_csb_init     <= CSB_BOTH;
						ddr_ba_init      <= BA_EMR2;
						-- start the t(MRD) counter
						tmrd_counter     <= (others => '0');
						tmrd_reached     <= '0';
						-- go to the next state
						init_state       <= INIT_WAIT_03_COMMAND;
					end if;
				-- load EMR3
				when INIT_WAIT_03_COMMAND =>
					-- wait until last modeset finished
					if tmrd_reached = '1' then
						-- Load EMR3
						ddr_cmd_init     <= CMD_MODESET;
						ddr_address_init <= REG_EMR3;
						ddr_csb_init     <= CSB_BOTH;
						ddr_ba_init      <= BA_EMR3;
						-- start the t(MRD) counter
						tmrd_counter     <= (others => '0');
						tmrd_reached     <= '0';
						-- go to the next state
						init_state       <= INIT_WAIT_04_COMMAND;
					end if;
				-- load EMR	to enable DLL
				when INIT_WAIT_04_COMMAND =>
					-- wait until last modeset finished
					if tmrd_reached = '1' then
						-- Load EMR1 with OCD exit
						ddr_cmd_init     <= CMD_MODESET;
						ddr_address_init <= REG_EMR1_OCD_EXIT;
						ddr_csb_init     <= CSB_BOTH;
						ddr_ba_init      <= BA_EMR1;
						-- start the t(MRD) counter
						tmrd_counter     <= (others => '0');
						tmrd_reached     <= '0';
						-- go to the next state
						init_state       <= INIT_WAIT_05_COMMAND;
					end if;
				-- load MR with DLL reset
				when INIT_WAIT_05_COMMAND =>
					-- wait until last modeset finished
					if tmrd_reached = '1' then
						-- Load MR with DLL reset
						ddr_cmd_init     <= CMD_MODESET;
						ddr_address_init <= REG_MR_DLL_RESET;
						ddr_csb_init     <= CSB_BOTH;
						ddr_ba_init      <= BA_MR;
						-- start the t(MRD) and the plllock counter
						tmrd_counter     <= (others => '0');
						tmrd_reached     <= '0';
						plllock_counter  <= (others => '0');
						plllock_reached  <= '0';
						-- go to the next state
						init_state       <= INIT_WAIT_06_COMMAND;
					end if;
				-- second precharge
				when INIT_WAIT_06_COMMAND =>
					-- wait until last modeset finished
					if tmrd_reached = '1' then
						-- send a precharge all command
						ddr_cmd_init     <= CMD_PRECHARGE;
						ddr_address_init <= ADD_ALLBANKS;
						ddr_csb_init     <= CSB_BOTH;
						-- start the t(RPA) counter
						trpa_counter     <= (others => '0');
						trpa_reached     <= '0';
						-- go to the next state
						init_state       <= INIT_WAIT_07_COMMAND;
					end if;
				-- first refresh
				when INIT_WAIT_07_COMMAND =>
					-- wait until last precharge all finished
					if trpa_reached = '1' then
						-- issue a refresh
						ddr_cmd_init     <= CMD_REFRESH;
						ddr_csb_init     <= CSB_BOTH;
						-- start the t(RFC) counter
						trfc_counter     <= (others => '0');
						trfc_reached     <= '0';
						-- go to the next state
						init_state       <= INIT_WAIT_08_COMMAND;
					end if;
				-- second refresh
				when INIT_WAIT_08_COMMAND =>
					-- wait until last refresh finished
					if trfc_reached = '1' then
						-- issue a refresh
						ddr_cmd_init     <= CMD_REFRESH;
						ddr_csb_init     <= CSB_BOTH;
						-- start the t(RFC) counter
						trfc_counter     <= (others => '0');
						trfc_reached     <= '0';
						-- go to the next state
						init_state       <= INIT_WAIT_09_COMMAND;
					end if;
				-- load MR without DLL reset
				when INIT_WAIT_09_COMMAND =>
					-- wait until last refresh finished
					if trfc_reached = '1' then
						-- Load MR without DLL reset
						ddr_cmd_init     <= CMD_MODESET;
						ddr_address_init <= REG_MR;
						ddr_csb_init     <= CSB_BOTH;
						ddr_ba_init      <= BA_MR;
						-- start the t(MRD) counter
						tmrd_counter     <= (others => '0');
						tmrd_reached     <= '0';
						-- go to the next state
						init_state       <= INIT_WAIT_10_COMMAND;
					end if;
				-- load EMR1 with OCD default
				when INIT_WAIT_10_COMMAND =>
					-- wait until last modeset finished
					if tmrd_reached = '1' then
						-- Load EMR1 with OCD default
						ddr_cmd_init     <= CMD_MODESET;
						ddr_address_init <= REG_EMR1_OCD_DEF;
						ddr_csb_init     <= CSB_BOTH;
						ddr_ba_init      <= BA_EMR1;
						-- start the t(MRD) counter
						tmrd_counter     <= (others => '0');
						tmrd_reached     <= '0';
						-- go to the next state
						init_state       <= INIT_WAIT_11_COMMAND;
					end if;
				-- load EMR1 with OCD exit
				when INIT_WAIT_11_COMMAND =>
					-- wait until last modeset finished
					if tmrd_reached = '1' then
						-- Load EMR1 with OCD exit
						ddr_cmd_init     <= CMD_MODESET;
						ddr_address_init <= REG_EMR1_OCD_EXIT;
						ddr_csb_init     <= CSB_BOTH;
						ddr_ba_init      <= BA_EMR1;
						-- start the t(MRD) counter
						tmrd_counter     <= (others => '0');
						tmrd_reached     <= '0';
						-- go to the next state
						init_state       <= INIT_WAIT_12_COMMAND;
					end if;
				-- issue a NOP
				when INIT_WAIT_12_COMMAND =>
					-- wait until last modeset finished
					if tmrd_reached = '1' then
						-- Load EMR1 with OCD exit
						ddr_cmd_init     <= CMD_NOP;
						ddr_csb_init     <= CSB_BOTH;
						-- go to the next state
						init_state       <= INIT_WAIT_COMPLETION;
					end if;
				-- wait until the PLL is locked to start normal operation
				when INIT_WAIT_COMPLETION =>
					-- wait until the pll locked
					if plllock_reached = '1' then
						-- go to idle state and launches a first auto refresh
						init_state       <= INIT_COMPLETE;
						do_auto_refresh  <= '1';
						-- signals the end of the init process
						init_done        <= '1';
						-- leave all the init signals in a default state to make sure they
						--   don't interfere with the regular control signals
						ddr_cmd_init     <= CMD_NOP;
						ddr_csb_init     <= CSB_NONE;
						ddr_address_init <= (others => '0');
						ddr_ba_init      <= (others => '0');
						-- enable ODT
						ddr_odt_int      <= ODT_BOTH;
					end if;

				when INIT_COMPLETE =>

				when others =>
			end case;

			-- #####     #    #    #     #    #    #   ####
			--   #       #    ##  ##     #    ##   #  #    #
			--   #       #    # ## #     #    # #  #  #
			--   #       #    #    #     #    #  # #  #  ###
			--   #       #    #    #     #    #   ##  #    #
			--   #       #    #    #     #    #    #   ####

			-- while init is not over, all the timings are invalid
			if init_done_delay = '0' then
				time_ok_4_read   <= (others => '0');
				time_ok_4_write  <= (others => '0');
				time_ok_4_pre    <= (others => '0');
				time_ok_4_act    <= (others => '0');
				time_ok_4_ref    <= '0';
			else
				-- pipelined command timming checks :
				for bank_index in 0 to managed_banks loop
					-- READ
					if
					(
						(bk_act_2_rd_counter(bank_index)  >= BK_ACT_2_RD_CNT - 2)  and
						(any_wr_2_rd_counter              >= ANY_WR_2_RD_CNT - 2)
					)
					then
						time_ok_4_read(bank_index)      <= '1';
					else
						time_ok_4_read(bank_index)      <= '0';
					end if;
					-- WRITE
					if
					(
						(bk_act_2_wr_counter(bank_index)  >= BK_ACT_2_WR_CNT - 2)  and
						(any_rd_2_wr_counter              >= ANY_RD_2_WR_CNT - 2)
					)
					then
						time_ok_4_write(bank_index)     <= '1';
					else
						time_ok_4_write(bank_index)     <= '0';
					end if;
					-- PRECHARGE
					if
					(
						(bk_act_2_pre_counter(bank_index) >= BK_ACT_2_PRE_CNT - 2) and
						(bk_rd_2_pre_counter(bank_index)  >= BK_RD_2_PRE_CNT  - 2) and
						(bk_wr_2_pre_counter(bank_index)  >= BK_WR_2_PRE_CNT  - 2)
					)
					then
						time_ok_4_pre(bank_index)       <= '1';
					else
						time_ok_4_pre(bank_index)       <= '0';
					end if;
					-- ACTIVE
					if
					(
						(ref_2_act_counter                >= REF_2_ACT_CNT    - 2) and
						(bk_pre_2_act_counter(bank_index) >= BK_PRE_2_ACT_CNT - 2)
					)
					then
						time_ok_4_act(bank_index)       <= '1';
					else
						time_ok_4_act(bank_index)       <= '0';
					end if;
					-- REFRESH
					if
					(
						(ref_2_ref_counter                >= REF_2_REF_CNT    - 2) and
						(pre_2_ref_counter                >= PRE_2_REF_CNT    - 2)
					)
					then
						time_ok_4_ref                   <= '1';
					else
						time_ok_4_ref                   <= '0';
					end if;
				end loop;
			end if;


			--                             ##
			--                              #
			--                              #
			-- ### ##   #####   ####    #####
			--   ##  # #     #      #  #    #
			--   #     #######  #####  #    #
			--   #     #       #    #  #    #
			--   #     #     # #    #  #    #
			-- #####    #####   #### #  ######

			-- we issue a read command in the following cases:
			--   * a READ request is issued and a bank is opened and there is no write request on the same cycle

			if
			(
				-- timming check
				time_ok_4_read(conv(latch_bank_address)) = '1' and
				-- if we had a read two cycles ago, we should make sure it was on the same rank than the one we plan to read from
				(last_last_was_read                      = '0' or latch_rank_address = last_rank_read) and
				-- issue condition
				latch_read                               = '1' and
				bank_is_opened(conv(latch_bank_address)) = '1' and
				address_conflict                         = '0'
			)
			then
				-- send a read command
				ddr_cmd          <= CMD_READ;
				ddr_address_int  <= ADD_PADZEROS & '0' & latch_col_address;
				ddr_ba_int       <= latch_bank_address;
				ddr_csb_int      <= latch_csb;
				-- enable receive circuitry during two cycles
				receive_enable      <= '1';
				receive_enable_next <= '1';
				-- signal one or two data to be validated at receive
				if latch_half_burst = '0' then
					disable_data_previous0 <= '0';
					disable_data_previous1 <= '0';
				else
					disable_data_previous0 <= '1';
					disable_data_previous1 <= '0';
				end if;
				-- signal the read
				last_was_read       <= '1';
				-- change the last accessed rank state
				last_rank_read      <= latch_rank_address;
				-- prevent back-to-back double reads and double writes
				for bank_index in 0 to managed_banks loop
					time_ok_4_read(bank_index)   <= '0';
					time_ok_4_write(bank_index)  <= '0';
				end loop;
			end if;

			-- Read abort logic
			-- we abort the previous read in the following cases:
			--   * A read was issued on the previous cycle and there is an address conflict

			if abort_read = '1' then
				-- disable the receive circuitry during two cycles
				receive_enable        <= '0';
				receive_enable_delay1 <= '0';
				receive_enable_next   <= '0';
			end if;

			if valid_read = '1' then
				-- start the timming counters now that we know that the read was valid
				bk_rd_2_pre_counter(conv(latch_bank_address)) <= "01";
				any_rd_2_wr_counter                           <= "001";
				rd_2_ready_counter                            <= "01";
				bk_rd_2_pre_reached(conv(latch_bank_address)) <= '1';
				any_rd_2_wr_reached                           <= '0';
				rd_2_ready_reached                            <= '1';
				if
				(
					(bk_act_2_pre_counter(conv(latch_bank_address)) >= BK_ACT_2_PRE_CNT - 2) and
					(bk_wr_2_pre_counter(conv(latch_bank_address))  >= BK_WR_2_PRE_CNT  - 2)
				)
				then
					time_ok_4_pre(conv(latch_bank_address)) <= '0';
				else
					time_ok_4_pre(conv(latch_bank_address)) <= '0';
				end if;
				for bank_index in 0 to managed_banks loop
					time_ok_4_write(bank_index)             <= '0';
				end loop;
			end if;

			--                    #
			--                           #
			--                           #
			-- ### ### ### ##   ###     ####    #####
			--  #   #    ##  #    #      #     #     #
			--  # # #    #        #      #     #######
			--  # # #    #        #      #     #
			--   # #     #        #      #  #  #     #
			--   # #   #####    #####     ##    #####

			-- we issue a write command in the following cases:
			--   * a WRITE request is issued and a bank is opened and there is no write request on the same cycle

			if
			(
				-- timming check
				time_ok_4_write(conv(latch_bank_address)) = '1' and
				-- issue condition
				latch_write                               = '1' and
				bank_is_opened(conv(latch_bank_address))  = '1' and
				address_conflict                          = '0'
			)
			then
				-- send a write command
				ddr_cmd          <= CMD_WRITE;
				ddr_address_int  <= ADD_PADZEROS & '0' & latch_col_address;
				ddr_ba_int       <= latch_bank_address;
				ddr_csb_int      <= latch_csb;
				-- request data on one, two or zero cycles depending on the state of the pipeline and if the user wants a full burst or a half burst
				if latch_half_burst = '0' then
					if pipeline_not_empty = '1' then
						user_get_data_int      <= '0';
						user_use_dummy         <= '0';
						user_get_data_next     <= '1';
						user_use_dummy_next    <= '0';
						pipeline_not_empty     <= '0';
					else
						user_get_data_int      <= '1';
						user_use_dummy         <= '0';
						user_get_data_next     <= '1';
						user_use_dummy_next    <= '0';
					end if;
				else
					if pipeline_not_empty = '1' then
						user_get_data_int      <= '0';
						user_use_dummy         <= '0';
						user_get_data_next     <= '0';
						user_use_dummy_next    <= '1';
						pipeline_not_empty     <= '0';
					else
						user_get_data_int      <= '1';
						user_use_dummy         <= '0';
						user_get_data_next     <= '0';
						user_use_dummy_next    <= '1';
					end if;
				end if;
				-- enable data write on two cycles
				write_enable_delay1    <= '1';
				write_enable_delay2    <= '1';
				-- signal the write
				last_was_write         <= '1';
				-- prevent back-to-back double reads and double writes
				for bank_index in 0 to managed_banks loop
					time_ok_4_read(bank_index)  <= '0';
					time_ok_4_write(bank_index) <= '0';
				end loop;
			end if;

			-- Write abort logic
			-- we abort the previous write in the following cases:
			--   * A write was issued on the previous cycle and there is an address conflict

			if abort_write = '1' then
				-- disable the write pipeline
				user_get_data_int     <= '0';
				user_use_dummy        <= '0';
				-- data write
				write_enable_delay2   <= '0';
				write_enable_int      <= '0';
				-- signal that we have one word waiting in the pipeline
				pipeline_not_empty    <= '1';
			end if;

			if valid_write = '1' then
				-- start the timming counters now that we know that the write was valid
				bk_wr_2_pre_counter(conv(latch_bank_address)) <= "001";
				any_wr_2_rd_counter                           <= "001";
				wr_2_ready_counter                            <= "01";
				bk_wr_2_pre_reached(conv(latch_bank_address)) <= '0';
				any_wr_2_rd_reached                           <= '0';
				wr_2_ready_reached                            <= '1';
				time_ok_4_pre(conv(latch_bank_address))       <= '0';
				for bank_index in 0 to managed_banks loop
					time_ok_4_read(bank_index)              <= '0';
				end loop;
			end if;

			--                                 ##
			--                                  #
			--                                  #
			-- ######  ### ##   #####   #####   # ##    ####   ### ##   ######  #####
			--  #    #   ##  # #     # #     #  ##  #       #    ##  # #    #  #     #
			--  #    #   #     ####### #        #   #   #####    #     #    #  #######
			--  #    #   #     #       #        #   #  #    #    #     #    #  #
			--  #    #   #     #     # #     #  #   #  #    #    #      #####  #     #
			--  #####  #####    #####   #####  ### ###  #### # #####        #   #####
			--  #                                                           #
			-- ###                                                      ####

			-- we need to precharge in the following cases:
			--   * a READ  request is issued whith an address conflict on an opened bank
			--   * a WRITE request is issued whith an address conflict or an opened bank
			--   * a refresh has to be issued but a bank is opened

			-- a precharge signal never happens on the cycle where a command is issued. This means we can use the registered bank address in place of the latched bank address

			if
			(
				-- timming check
				time_ok_4_pre(conv(reg_bank_address))    = '1' and
				-- issue condition
				bank_is_opened(conv(reg_bank_address))   = '1' and
				address_conflict                         = '1'
			) or (
				-- this variable, evaluated in the previous cycle, contains all the necessary checks (timings plus issue condition) to launch a
				--   precharge before refresh
				launch_pre_for_ref = '1'
			)
			then
				-- send a precharge command
				ddr_cmd              <= CMD_PRECHARGE;
				ddr_address_int      <= ADD_SINGLEBANK;
				ddr_csb_int          <= CSB_BOTH;
				-- start the common timming counters
				pre_2_ref_counter    <= (others => '0');
				pre_2_ready_counter  <= (others => '0');
				pre_2_ref_reached    <= '0';
				pre_2_ready_reached  <= '0';
				time_ok_4_ref        <= '0';
				-- command specific assignements
				if do_auto_refresh = '0' then
					-- send a precharge command to the right bank
					if bank_management = 1 then
						ddr_ba_int                               <= latch_bank_address;
					else
						ddr_ba_int                               <= opened_bank;
					end if;
					-- start the timming counters
					bk_pre_2_act_counter(conv(latch_bank_address)) <= (others => '0');
					bk_pre_2_act_reached(conv(latch_bank_address)) <= '0';
					time_ok_4_act(conv(latch_bank_address))        <= '0';
					-- signal that the bank is closed
					bank_is_opened(conv(latch_bank_address))       <= '0';
				else
					-- send a precharge command to the right bank
					if bank_management = 1 then
						ddr_ba_int                               <= next_bank_to_precharge;
					else
						ddr_ba_int                               <= opened_bank;
					end if;
					-- start the timming counters
					bk_pre_2_act_counter(conv(next_bank_to_precharge)) <= (others => '0');
					bk_pre_2_act_reached(conv(next_bank_to_precharge)) <= '0';
					time_ok_4_act(conv(next_bank_to_precharge))        <= '0';
					-- signal that the bank is closed
					bank_is_opened(conv(next_bank_to_precharge))       <= '0';
				end if;
				-- signal that the address conflict has been solved
				address_conflict     <= '0';
				-- signal the precharge
				last_was_precharge   <= '1';
			end if;

			-- evaluate what bank needs to be precharged in case a refresh happens
			bank_needs_precharge   <= '0';
			for bank_index in 0 to managed_banks loop
				if bank_is_opened(bank_index) = '1' then
					if bank_index = 0 then next_bank_to_precharge <= "00"; end if;
					if bank_index = 1 then next_bank_to_precharge <= "01"; end if;
					if bank_index = 2 then next_bank_to_precharge <= "10"; end if;
					if bank_index = 3 then next_bank_to_precharge <= "11"; end if;
					bank_needs_precharge   <= '1';
				end if;
			end loop;
			-- We delay the start of a precharge before a refresh by one cycle. This does not impact the performance by much and gives us much wider time margins to do the issue and timing checks
			if
			(
				-- timming check
				time_ok_4_pre(conv(next_bank_to_precharge)) = '1' and
				do_auto_refresh                             = '1' and
				bank_needs_precharge                        = '1' and
				-- if the last command was active or precharge, we cannot trust the bank information, so we do nothing
				last_was_precharge                          = '0' and
				last_was_active                             = '0' and
				-- avoids issuing two a back to back precharges on the same bank
				launch_pre_for_ref                          = '0'
			)
			then
				launch_pre_for_ref <= '1';
			else
				launch_pre_for_ref <= '0';
			end if;


			--                            #
			--                   #
			--                   #
			--  ####    #####   ####    ###    ### ###  #####
			--      #  #     #   #        #     #   #  #     #
			--  #####  #         #        #     #   #  #######
			-- #    #  #         #        #      # #   #
			-- #    #  #     #   #  #     #      # #   #     #
			--  #### #  #####     ##    #####     #     #####

			-- we need to activate in the following cases:
			--   * a READ  request is issued on a closed bank
			--   * a WRITE request is issued on a closed bank

			if
			(
				-- timming check
				time_ok_4_act(conv(latch_bank_address))  = '1' and
				-- issue condition
				bank_is_opened(conv(latch_bank_address)) = '0' and
				(latch_read  = '1' or latch_write = '1')
			)
			then
				-- send an activate command
				ddr_cmd          <= CMD_ACTIVE;
				ddr_address_int  <= latch_row_address;
				ddr_ba_int       <= latch_bank_address;
				ddr_csb_int      <= CSB_BOTH;
				-- start the timming counters
				bk_act_2_pre_counter(conv(latch_bank_address)) <= (others => '0');
				bk_act_2_rd_counter(conv(latch_bank_address))  <= (others => '0');
				bk_act_2_wr_counter(conv(latch_bank_address))  <= (others => '0');
				bk_act_2_pre_reached(conv(latch_bank_address)) <= '0';
				bk_act_2_rd_reached(conv(latch_bank_address))  <= '0';
				bk_act_2_wr_reached(conv(latch_bank_address))  <= '0';
				time_ok_4_read(conv(latch_bank_address))       <= '0';
				time_ok_4_write(conv(latch_bank_address))      <= '0';
				time_ok_4_pre(conv(latch_bank_address))        <= '0';
				-- signal that the bank is opened
				bank_is_opened(conv(latch_bank_address))       <= '1';
				-- latches the addresses for the opened bank
				opened_row(conv(latch_bank_address))           <= latch_row_address;
				opened_bank                                    <= latch_bank_address;
				-- signal the active
				last_was_active  <= '1';
			end if;


			--                    ##                           ##
			--                   #                              #
			--                   #                              #
			-- ### ##   #####   ####   ### ##   #####   #####   # ##
			--   ##  # #     #   #       ##  # #     # #     #  ##  #
			--   #     #######   #       #     #######  ###     #   #
			--   #     #         #       #     #           ##   #   #
			--   #     #     #   #       #     #     # #     #  #   #
			-- #####    #####   ####   #####    #####   #####  ### ###

			-- we need to refresh in the following cases:
			--   * the refresh controller is requesting a refresh, the bank is opened and there is no read or write going on

			if
			(
				-- timming check
				time_ok_4_ref     = '1'     and
				-- issue condition
				do_auto_refresh   = '1'     and
				bank_is_opened    = NO_BANK
			)
			then
				ddr_cmd                         <= CMD_REFRESH;
				ddr_csb_int                     <= CSB_BOTH;
				-- start the timming counters
				ref_2_ref_counter               <= (others => '0');
				ref_2_act_counter               <= (others => '0');
				ref_2_ready_counter             <= (others => '0');
				refreshmax_counter              <= (others => '0');
				ref_2_ref_reached               <= '0';
				ref_2_act_reached               <= '0';
				ref_2_ready_reached             <= '0';
				refreshmax_reached              <= '0';
				time_ok_4_ref                   <= '0';
				for bank_index in 0 to managed_banks loop
					time_ok_4_act(bank_index) <= '0';
				end loop;
				-- signal the refresh
				last_was_refresh                <= '1';
			end if;
		end if;


		--                             ##
		--                              #
		--                              #
		-- ### ##   #####   ####    #####  ### ###
		--   ##  # #     #      #  #    #   #   #
		--   #     #######  #####  #    #   #   #
		--   #     #       #    #  #    #    # #
		--   #     #     # #    #  #    #    # #
		-- #####    #####   #### #  ######    #
		--                                    #
		--                                  ##

		-- take the ready bit down if we got a command to execute
		if
		(
			(user_ready_int = '1' and
			(user_write     = '1' or user_read = '1'))
		)
		then
			-- disable the ready bit
			user_ready_int <= '0';
			user_ready     <= '0';
		end if;
		-- when a transaction is over or when we are idle, evaluate what to do next
		if	(
				-- a refresh is about to complete
				(ref_2_ready_almost = '1' and do_auto_refresh = '1') or
				-- a read is about to complete
				(valid_read = '1' and latch_read = '1') or
				-- a write is about to complete
				(valid_write = '1' and latch_write = '1') or
				-- no command was sent previsously
				(user_ready_int = '1' and latch_read = '0' and latch_write = '0')
			)
		then
			-- deassert the command signals
			do_auto_refresh  <= '0';
			reg_read         <= '0';
			reg_write        <= '0';
			-- by default we request a new command
			user_ready_int   <= '1';
			user_ready       <= '1';
			-- if a refresh is needed, we execute it and we don't assert ready
			if auto_refresh = '1' then
				do_auto_refresh <= '1';
				user_ready_int  <= '0';
				user_ready      <= '0';
			end if;
		end if;
	end if;
end process controller_fsm;

-- abort signals
abort_read           <= '1' when address_conflict = '1' and last_was_read  = '1' else '0';
abort_write          <= '1' when address_conflict = '1' and last_was_write = '1' else '0';
valid_read           <= '1' when address_conflict = '0' and last_was_read  = '1' else '0';
valid_write          <= '1' when address_conflict = '0' and last_was_write = '1' else '0';

-- refresh command
auto_refresh    <= refreshmax_reached;

-- command signals assignments
ddr_rasb        <= ddr_cmd(2);
ddr_casb        <= ddr_cmd(1);
ddr_web         <= ddr_cmd(0);
ddr_csb         <= ddr_csb_int;
ddr_ba          <= ddr_ba_int;
ddr_address     <= ddr_address_int;
ddr_ODT         <= ddr_odt_int;
ddr_cke         <= ddr_cke_int;
ddr_force_nop   <= ddr_force_nop_int;

-- init command signals assignments
ddr_rasb_init   <= ddr_cmd_init(2);
ddr_casb_init   <= ddr_cmd_init(1);
ddr_web_init    <= ddr_cmd_init(0);

-- decoded csbs
user_csb        <= CSB_ZERO when user_rank_address  = '0'  else CSB_ONE;
latch_csb       <= CSB_ZERO when latch_rank_address = '0'  else CSB_ONE;
reg_csb         <= CSB_ZERO when reg_rank_address   = '0'  else CSB_ONE;

-- latched input signals
latch_col_address     <= user_col_address  when user_ready_int = '1' else reg_col_address ;
latch_row_address     <= user_row_address  when user_ready_int = '1' else reg_row_address ;
latch_bank_address    <= user_bank_address when user_ready_int = '1' else reg_bank_address;
latch_rank_address    <= user_rank_address when user_ready_int = '1' else reg_rank_address;
latch_read            <= user_read         when user_ready_int = '1' else reg_read        ;
latch_write           <= user_write        when user_ready_int = '1' else reg_write       ;
latch_half_burst      <= user_half_burst   when user_ready_int = '1' else reg_half_burst  ;
latch_csb             <= user_csb          when user_ready_int = '1' else reg_csb         ;

-- internal version of output signals
user_get_data       <= user_get_data_int;
dqs_reset           <= dqs_reset_int;
write_enable        <= write_enable_int;
dqs_enable          <= dqs_enable_int;
ddr_rst_dqs_div_out <= ddr_rst_dqs_div_out_int;
input_data_valid    <= input_data_valid_int;
input_data_dummy    <= input_data_dummy_int;
disable_data        <= disable_data_int;
disable_data_valid  <= disable_data_valid_int;


-- user_ready is coassigned with user_ready_int directly in the code
--    to avoid delta delay simulation problems and make routing easier
-- user_ready          <= user_ready_int;

end arc_controller;


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--library synplify;
--use synplify.attributes.all;
--
-- pragma translate_off
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
-- pragma translate_on
--
entity   data_path_72bit_rl  is
port(
	-- system ports
	clk                    : in std_logic;
	clk90                  : in std_logic;
	reset                  : in std_logic;
	reset90                : in std_logic;
	reset180               : in std_logic;
	reset270               : in std_logic;
	delay_sel              : in std_logic_vector(4 downto 0);

	-- data ports (on clk0)
	input_data             : in  std_logic_vector(143 downto 0);
	write_enable           : in  std_logic;
	input_data_valid       : in  std_logic;
	input_data_dummy       : in  std_logic;
	byte_enable            : in  std_logic_vector(17 downto 0);
	disable_data           : in  std_logic;
	disable_data_valid     : in  std_logic;
	output_data_valid      : out std_logic;
	output_data            : out std_logic_vector(143 downto 0);

	-- iobs ports
	ddr_dqs_int_delay_in0  : in std_logic;
	ddr_dqs_int_delay_in1  : in std_logic;
	ddr_dqs_int_delay_in2  : in std_logic;
	ddr_dqs_int_delay_in3  : in std_logic;
	ddr_dqs_int_delay_in4  : in std_logic;
	ddr_dqs_int_delay_in5  : in std_logic;
	ddr_dqs_int_delay_in6  : in std_logic;
	ddr_dqs_int_delay_in7  : in std_logic;
	ddr_dqs_int_delay_in8  : in std_logic;
	ddr_dq                 : in std_logic_vector(71 downto 0);
	ddr_write_en           : out std_logic;
	ddr_data_mask_falling  : out std_logic_vector(8 downto 0);
	ddr_data_mask_rising   : out std_logic_vector(8 downto 0);
	ddr_write_data_falling : out std_logic_vector(71 downto 0);
	ddr_write_data_rising  : out std_logic_vector(71 downto 0);
	ddr_rst_dqs_div_in     : in std_logic
     );
end   data_path_72bit_rl;

architecture   arc_data_path_72bit_rl of   data_path_72bit_rl    is

component	data_read_72bit_rl
port(
     clk                : in std_logic;
     clk90              : in std_logic;
     reset90_r          : in std_logic;
     reset270_r         : in std_logic;
     dq                 : in std_logic_vector(71 downto 0);
     read_data_valid_1  : in std_logic;
     read_data_valid_2  : in std_logic;
     transfer_done_0    : in std_logic_vector(3 downto 0);
     transfer_done_1    : in std_logic_vector(3 downto 0);
     transfer_done_2    : in std_logic_vector(3 downto 0);
     transfer_done_3    : in std_logic_vector(3 downto 0);
     transfer_done_4    : in std_logic_vector(3 downto 0);
     transfer_done_5    : in std_logic_vector(3 downto 0);
     transfer_done_6    : in std_logic_vector(3 downto 0);
     transfer_done_7    : in std_logic_vector(3 downto 0);
     transfer_done_8    : in std_logic_vector(3 downto 0);
     fifo_00_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_01_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_02_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_03_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_10_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_11_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_12_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_13_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_20_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_21_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_22_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_23_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_30_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_31_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_32_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_33_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_40_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_41_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_42_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_43_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_50_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_51_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_52_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_53_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_60_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_61_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_62_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_63_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_70_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_71_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_72_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_73_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_80_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_81_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_82_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_83_wr_addr    : in std_logic_vector(3 downto 0);
     dqs_delayed_col0   : in std_logic_vector(8 downto 0);
     dqs_delayed_col1   : in std_logic_vector(8 downto 0);
     dqs_div_col0       : in std_logic_vector(8 downto 0);
     dqs_div_col1       : in std_logic_vector(8 downto 0);
     fifo_00_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_01_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_02_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_03_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_10_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_11_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_12_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_13_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_20_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_21_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_22_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_23_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_30_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_31_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_32_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_33_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_40_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_41_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_42_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_43_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_50_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_51_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_52_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_53_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_60_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_61_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_62_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_63_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_70_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_71_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_72_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_73_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_80_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_81_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_82_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_83_rd_addr    : in std_logic_vector(3 downto 0);
     next_state_val     : out std_logic;
     output_data_90     : out std_logic_vector(143 downto 0);
     data_valid_90      : out std_logic
    );
end component;

component	data_read_controller_72bit_rl
port(
     clk                : in std_logic;
     clk90              : in std_logic;
     reset_r            : in std_logic;
     reset90_r          : in std_logic;
     reset180_r         : in std_logic;
     reset270_r         : in std_logic;
     rst_dqs_div        : in std_logic;
     delay_sel          : in std_logic_vector(4 downto 0);
     dqs_int_delay_in0  : in std_logic;
     dqs_int_delay_in1  : in std_logic;
     dqs_int_delay_in2  : in std_logic;
     dqs_int_delay_in3  : in std_logic;
     dqs_int_delay_in4  : in std_logic;
     dqs_int_delay_in5  : in std_logic;
     dqs_int_delay_in6  : in std_logic;
     dqs_int_delay_in7  : in std_logic;
     dqs_int_delay_in8  : in std_logic;
     next_state         : in std_logic;
     read_data_valid_1_val  : out std_logic;
     read_data_valid_2_val  : out std_logic;
     transfer_done_0_val    : out std_logic_vector(3 downto 0);
     transfer_done_1_val    : out std_logic_vector(3 downto 0);
     transfer_done_2_val    : out std_logic_vector(3 downto 0);
     transfer_done_3_val    : out std_logic_vector(3 downto 0);
     transfer_done_4_val    : out std_logic_vector(3 downto 0);
     transfer_done_5_val    : out std_logic_vector(3 downto 0);
     transfer_done_6_val    : out std_logic_vector(3 downto 0);
     transfer_done_7_val    : out std_logic_vector(3 downto 0);
     transfer_done_8_val    : out std_logic_vector(3 downto 0);
     fifo_00_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_01_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_02_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_03_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_10_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_11_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_12_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_13_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_20_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_21_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_22_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_23_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_30_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_31_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_32_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_33_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_40_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_41_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_42_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_43_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_50_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_51_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_52_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_53_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_60_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_61_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_62_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_63_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_70_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_71_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_72_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_73_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_80_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_81_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_82_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_83_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_00_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_01_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_02_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_03_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_10_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_11_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_12_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_13_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_20_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_21_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_22_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_23_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_30_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_31_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_32_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_33_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_40_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_41_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_42_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_43_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_50_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_51_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_52_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_53_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_60_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_61_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_62_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_63_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_70_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_71_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_72_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_73_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_80_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_81_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_82_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_83_rd_addr_val    : out std_logic_vector(3 downto 0);
     dqs_delayed_col0_val   : out std_logic_vector(8 downto 0);
     dqs_delayed_col1_val   : out std_logic_vector(8 downto 0);
     dqs_div_col0_val      : out std_logic_vector(8 downto 0);
     dqs_div_col1_val       : out std_logic_vector(8 downto 0)
    );
end component;

component	data_write_72bit
port(
     clk                : in std_logic;
     clk90              : in std_logic;
     reset_r            : in std_logic;
     reset90_r          : in std_logic;
     reset180_r         : in std_logic;
     reset270_r         : in std_logic;

     input_data         : in std_logic_vector(143 downto 0);
     byte_enable        : in std_logic_vector(17 downto 0);
     write_enable       : in std_logic;
     input_data_valid   : in std_logic;
     input_data_dummy   : in std_logic;

     write_en_val       : out std_logic;
     write_data_falling : out std_logic_vector(71 downto 0);
     write_data_rising  : out std_logic_vector(71 downto 0);
     data_mask_falling  : out std_logic_vector(8 downto 0);
     data_mask_rising   : out std_logic_vector(8 downto 0)
     );
end component;

component data_path_rst
port(
     clk                : in std_logic;
     clk90              : in std_logic;
     reset              : in std_logic;
     reset90            : in std_logic;
     reset180           : in std_logic;
     reset270           : in std_logic;
     reset_r            : out std_logic;
     reset90_r          : out std_logic;
     reset180_r         : out std_logic;
     reset270_r         : out std_logic
    );
end component;

component RAM16X1D
port (
     D       : in std_logic;
     WE      : in std_logic;
     WCLK    : in std_logic;
     A0      : in std_logic;
     A1      : in std_logic;
     A2      : in std_logic;
     A3      : in std_logic;
     DPRA0   : in std_logic;
     DPRA1   : in std_logic;
     DPRA2   : in std_logic;
     DPRA3   : in std_logic;
     SPO     : out std_logic;
     DPO     : out std_logic
    );
end component;

signal reset_r          : std_logic;
signal reset90_r        : std_logic;
signal reset180_r       : std_logic;
signal reset270_r       : std_logic;

 signal fifo_00_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_01_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_02_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_03_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_10_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_11_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_12_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_13_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_20_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_21_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_22_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_23_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_30_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_31_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_32_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_33_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_40_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_41_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_42_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_43_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_50_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_51_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_52_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_53_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_60_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_61_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_62_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_63_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_70_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_71_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_72_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_73_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_80_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_81_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_82_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_83_rd_addr    : std_logic_vector(3 downto 0);
 signal read_data_valid_1  : std_logic;
 signal read_data_valid_2  : std_logic;
 signal transfer_done_0    : std_logic_vector(3 downto 0);
 signal transfer_done_1    : std_logic_vector(3 downto 0);
 signal transfer_done_2    : std_logic_vector(3 downto 0);
 signal transfer_done_3    : std_logic_vector(3 downto 0);
 signal transfer_done_4    : std_logic_vector(3 downto 0);
 signal transfer_done_5    : std_logic_vector(3 downto 0);
 signal transfer_done_6    : std_logic_vector(3 downto 0);
 signal transfer_done_7    : std_logic_vector(3 downto 0);
 signal transfer_done_8    : std_logic_vector(3 downto 0);
 signal fifo_00_wr_addr    : std_logic_vector(3 downto 0);
 signal fifo_01_wr_addr    : std_logic_vector(3 downto 0);
 signal fifo_02_wr_addr    : std_logic_vector(3 downto 0);
 signal fifo_03_wr_addr    : std_logic_vector(3 downto 0);
 signal fifo_10_wr_addr    : std_logic_vector(3 downto 0);
 signal fifo_11_wr_addr    : std_logic_vector(3 downto 0);
 signal fifo_12_wr_addr    : std_logic_vector(3 downto 0);
 signal fifo_13_wr_addr    : std_logic_vector(3 downto 0);
 signal fifo_20_wr_addr    : std_logic_vector(3 downto 0);
 signal fifo_21_wr_addr    : std_logic_vector(3 downto 0);
 signal fifo_22_wr_addr    : std_logic_vector(3 downto 0);
 signal fifo_23_wr_addr    : std_logic_vector(3 downto 0);
 signal fifo_30_wr_addr    : std_logic_vector(3 downto 0);
 signal fifo_31_wr_addr    : std_logic_vector(3 downto 0);
 signal fifo_32_wr_addr    : std_logic_vector(3 downto 0);
 signal fifo_33_wr_addr    : std_logic_vector(3 downto 0);
 signal fifo_40_wr_addr    : std_logic_vector(3 downto 0);
 signal fifo_41_wr_addr    : std_logic_vector(3 downto 0);
 signal fifo_42_wr_addr    : std_logic_vector(3 downto 0);
 signal fifo_43_wr_addr    : std_logic_vector(3 downto 0);
 signal fifo_50_wr_addr    : std_logic_vector(3 downto 0);
 signal fifo_51_wr_addr    : std_logic_vector(3 downto 0);
 signal fifo_52_wr_addr    : std_logic_vector(3 downto 0);
 signal fifo_53_wr_addr    : std_logic_vector(3 downto 0);
 signal fifo_60_wr_addr    : std_logic_vector(3 downto 0);
 signal fifo_61_wr_addr    : std_logic_vector(3 downto 0);
 signal fifo_62_wr_addr    : std_logic_vector(3 downto 0);
 signal fifo_63_wr_addr    : std_logic_vector(3 downto 0);
 signal fifo_70_wr_addr    : std_logic_vector(3 downto 0);
 signal fifo_71_wr_addr    : std_logic_vector(3 downto 0);
 signal fifo_72_wr_addr    : std_logic_vector(3 downto 0);
 signal fifo_73_wr_addr    : std_logic_vector(3 downto 0);
 signal fifo_80_wr_addr    : std_logic_vector(3 downto 0);
 signal fifo_81_wr_addr    : std_logic_vector(3 downto 0);
 signal fifo_82_wr_addr    : std_logic_vector(3 downto 0);
 signal fifo_83_wr_addr    : std_logic_vector(3 downto 0);
 signal dqs_delayed_col0   : std_logic_vector(8 downto 0);
 signal dqs_delayed_col1   : std_logic_vector(8 downto 0);
 signal dqs_div_col0       : std_logic_vector(8 downto 0);
 signal dqs_div_col1       : std_logic_vector(8 downto 0);
 signal next_state         : std_logic;

 signal data_valid_90      : std_logic;
 signal output_data_90     : std_logic_vector(143 downto 0);

 signal validate_fifo_read_address  : std_logic_vector(3 downto 0) := (others => '0');
 signal validate_fifo_write_address : std_logic_vector(3 downto 0) := (others => '0');
 signal disable_current_data        : std_logic;

 begin

data_read0	:	data_read_72bit_rl
port map (
           clk                 =>    clk,
           clk90               =>    clk90,
           reset90_r           =>    reset90_r,
           reset270_r          =>    reset270_r,
           dq                  =>    ddr_dq,
           read_data_valid_1   =>    read_data_valid_1,
           read_data_valid_2   =>    read_data_valid_2,
           transfer_done_0     =>    transfer_done_0,
           transfer_done_1     =>    transfer_done_1,
           transfer_done_2     =>    transfer_done_2,
           transfer_done_3     =>    transfer_done_3,
           transfer_done_4     =>    transfer_done_4,
           transfer_done_5     =>    transfer_done_5,
           transfer_done_6     =>    transfer_done_6,
           transfer_done_7     =>    transfer_done_7,
           transfer_done_8     =>    transfer_done_8,
           fifo_00_wr_addr     =>    fifo_00_wr_addr,
           fifo_01_wr_addr     =>    fifo_01_wr_addr,
           fifo_02_wr_addr     =>    fifo_02_wr_addr,
           fifo_03_wr_addr     =>    fifo_03_wr_addr,
           fifo_10_wr_addr     =>    fifo_10_wr_addr,
           fifo_11_wr_addr     =>    fifo_11_wr_addr,
           fifo_12_wr_addr     =>    fifo_12_wr_addr,
           fifo_13_wr_addr     =>    fifo_13_wr_addr,
           fifo_20_wr_addr     =>    fifo_20_wr_addr,
           fifo_21_wr_addr     =>    fifo_21_wr_addr,
           fifo_22_wr_addr     =>    fifo_22_wr_addr,
           fifo_23_wr_addr     =>    fifo_23_wr_addr,
           fifo_30_wr_addr     =>    fifo_30_wr_addr,
           fifo_31_wr_addr     =>    fifo_31_wr_addr,
           fifo_32_wr_addr     =>    fifo_32_wr_addr,
           fifo_33_wr_addr     =>    fifo_33_wr_addr,
           fifo_40_wr_addr     =>    fifo_40_wr_addr,
           fifo_41_wr_addr     =>    fifo_41_wr_addr,
           fifo_42_wr_addr     =>    fifo_42_wr_addr,
           fifo_43_wr_addr     =>    fifo_43_wr_addr,
           fifo_50_wr_addr     =>    fifo_50_wr_addr,
           fifo_51_wr_addr     =>    fifo_51_wr_addr,
           fifo_52_wr_addr     =>    fifo_52_wr_addr,
           fifo_53_wr_addr     =>    fifo_53_wr_addr,
           fifo_60_wr_addr     =>    fifo_60_wr_addr,
           fifo_61_wr_addr     =>    fifo_61_wr_addr,
           fifo_62_wr_addr     =>    fifo_62_wr_addr,
           fifo_63_wr_addr     =>    fifo_63_wr_addr,
           fifo_70_wr_addr     =>    fifo_70_wr_addr,
           fifo_71_wr_addr     =>    fifo_71_wr_addr,
           fifo_72_wr_addr     =>    fifo_72_wr_addr,
           fifo_73_wr_addr     =>    fifo_73_wr_addr,
           fifo_80_wr_addr     =>    fifo_80_wr_addr,
           fifo_81_wr_addr     =>    fifo_81_wr_addr,
           fifo_82_wr_addr     =>    fifo_82_wr_addr,
           fifo_83_wr_addr     =>    fifo_83_wr_addr,
           dqs_delayed_col0    =>    dqs_delayed_col0,
           dqs_delayed_col1    =>    dqs_delayed_col1,
           dqs_div_col0        =>    dqs_div_col0,
           dqs_div_col1        =>    dqs_div_col1,
           fifo_00_rd_addr     =>    fifo_00_rd_addr,
           fifo_01_rd_addr     =>    fifo_01_rd_addr,
           fifo_02_rd_addr     =>    fifo_02_rd_addr,
           fifo_03_rd_addr     =>    fifo_03_rd_addr,
           fifo_10_rd_addr     =>    fifo_10_rd_addr,
           fifo_11_rd_addr     =>    fifo_11_rd_addr,
           fifo_12_rd_addr     =>    fifo_12_rd_addr,
           fifo_13_rd_addr     =>    fifo_13_rd_addr,
           fifo_20_rd_addr     =>    fifo_20_rd_addr,
           fifo_21_rd_addr     =>    fifo_21_rd_addr,
           fifo_22_rd_addr     =>    fifo_22_rd_addr,
           fifo_23_rd_addr     =>    fifo_23_rd_addr,
           fifo_30_rd_addr     =>    fifo_30_rd_addr,
           fifo_31_rd_addr     =>    fifo_31_rd_addr,
           fifo_32_rd_addr     =>    fifo_32_rd_addr,
           fifo_33_rd_addr     =>    fifo_33_rd_addr,
           fifo_40_rd_addr     =>    fifo_40_rd_addr,
           fifo_41_rd_addr     =>    fifo_41_rd_addr,
           fifo_42_rd_addr     =>    fifo_42_rd_addr,
           fifo_43_rd_addr     =>    fifo_43_rd_addr,
           fifo_50_rd_addr     =>    fifo_50_rd_addr,
           fifo_51_rd_addr     =>    fifo_51_rd_addr,
           fifo_52_rd_addr     =>    fifo_52_rd_addr,
           fifo_53_rd_addr     =>    fifo_53_rd_addr,
           fifo_60_rd_addr     =>    fifo_60_rd_addr,
           fifo_61_rd_addr     =>    fifo_61_rd_addr,
           fifo_62_rd_addr     =>    fifo_62_rd_addr,
           fifo_63_rd_addr     =>    fifo_63_rd_addr,
           fifo_70_rd_addr     =>    fifo_70_rd_addr,
           fifo_71_rd_addr     =>    fifo_71_rd_addr,
           fifo_72_rd_addr     =>    fifo_72_rd_addr,
           fifo_73_rd_addr     =>    fifo_73_rd_addr,
           fifo_80_rd_addr     =>    fifo_80_rd_addr,
           fifo_81_rd_addr     =>    fifo_81_rd_addr,
           fifo_82_rd_addr     =>    fifo_82_rd_addr,
           fifo_83_rd_addr     =>    fifo_83_rd_addr,
           output_data_90      =>    output_data_90,
           next_state_val      =>    next_state,
           data_valid_90       =>    data_valid_90
         );


data_read_controller0	:	data_read_controller_72bit_rl
port map (
            clk                =>   clk,
            clk90              =>   clk90,
            reset_r            =>   reset_r,
            reset90_r          =>   reset90_r,
            reset180_r         =>   reset180_r,
            reset270_r         =>   reset270_r,
            rst_dqs_div        =>   ddr_rst_dqs_div_in,
            delay_sel          =>   delay_sel,
            dqs_int_delay_in0  =>   ddr_dqs_int_delay_in0,
            dqs_int_delay_in1  =>   ddr_dqs_int_delay_in1,
            dqs_int_delay_in2  =>   ddr_dqs_int_delay_in2,
            dqs_int_delay_in3  =>   ddr_dqs_int_delay_in3,
            dqs_int_delay_in4  =>   ddr_dqs_int_delay_in4,
            dqs_int_delay_in5  =>   ddr_dqs_int_delay_in5,
            dqs_int_delay_in6  =>   ddr_dqs_int_delay_in6,
            dqs_int_delay_in7  =>   ddr_dqs_int_delay_in7,
            dqs_int_delay_in8  =>   ddr_dqs_int_delay_in8,
            next_state             =>    next_state,
            fifo_00_rd_addr_val    =>    fifo_00_rd_addr,
            fifo_01_rd_addr_val    =>    fifo_01_rd_addr,
            fifo_02_rd_addr_val    =>    fifo_02_rd_addr,
            fifo_03_rd_addr_val    =>    fifo_03_rd_addr,
            fifo_10_rd_addr_val    =>    fifo_10_rd_addr,
            fifo_11_rd_addr_val    =>    fifo_11_rd_addr,
            fifo_12_rd_addr_val    =>    fifo_12_rd_addr,
            fifo_13_rd_addr_val    =>    fifo_13_rd_addr,
            fifo_20_rd_addr_val    =>    fifo_20_rd_addr,
            fifo_21_rd_addr_val    =>    fifo_21_rd_addr,
            fifo_22_rd_addr_val    =>    fifo_22_rd_addr,
            fifo_23_rd_addr_val    =>    fifo_23_rd_addr,
            fifo_30_rd_addr_val    =>    fifo_30_rd_addr,
            fifo_31_rd_addr_val    =>    fifo_31_rd_addr,
            fifo_32_rd_addr_val    =>    fifo_32_rd_addr,
            fifo_33_rd_addr_val    =>    fifo_33_rd_addr,
            fifo_40_rd_addr_val    =>    fifo_40_rd_addr,
            fifo_41_rd_addr_val    =>    fifo_41_rd_addr,
            fifo_42_rd_addr_val    =>    fifo_42_rd_addr,
            fifo_43_rd_addr_val    =>    fifo_43_rd_addr,
            fifo_50_rd_addr_val    =>    fifo_50_rd_addr,
            fifo_51_rd_addr_val    =>    fifo_51_rd_addr,
            fifo_52_rd_addr_val    =>    fifo_52_rd_addr,
            fifo_53_rd_addr_val    =>    fifo_53_rd_addr,
            fifo_60_rd_addr_val    =>    fifo_60_rd_addr,
            fifo_61_rd_addr_val    =>    fifo_61_rd_addr,
            fifo_62_rd_addr_val    =>    fifo_62_rd_addr,
            fifo_63_rd_addr_val    =>    fifo_63_rd_addr,
            fifo_70_rd_addr_val    =>    fifo_70_rd_addr,
            fifo_71_rd_addr_val    =>    fifo_71_rd_addr,
            fifo_72_rd_addr_val    =>    fifo_72_rd_addr,
            fifo_73_rd_addr_val    =>    fifo_73_rd_addr,
            fifo_80_rd_addr_val    =>    fifo_80_rd_addr,
            fifo_81_rd_addr_val    =>    fifo_81_rd_addr,
            fifo_82_rd_addr_val    =>    fifo_82_rd_addr,
            fifo_83_rd_addr_val    =>    fifo_83_rd_addr,
            read_data_valid_1_val  =>   read_data_valid_1,
            read_data_valid_2_val  =>   read_data_valid_2,
            transfer_done_0_val    =>   transfer_done_0,
            transfer_done_1_val    =>   transfer_done_1,
            transfer_done_2_val    =>   transfer_done_2,
            transfer_done_3_val    =>   transfer_done_3,
            transfer_done_4_val    =>   transfer_done_4,
            transfer_done_5_val    =>   transfer_done_5,
            transfer_done_6_val    =>   transfer_done_6,
            transfer_done_7_val    =>   transfer_done_7,
            transfer_done_8_val    =>   transfer_done_8,
            fifo_00_wr_addr_val    =>   fifo_00_wr_addr,
            fifo_01_wr_addr_val    =>   fifo_01_wr_addr,
            fifo_02_wr_addr_val    =>   fifo_02_wr_addr,
            fifo_03_wr_addr_val    =>   fifo_03_wr_addr,
            fifo_10_wr_addr_val    =>   fifo_10_wr_addr,
            fifo_11_wr_addr_val    =>   fifo_11_wr_addr,
            fifo_12_wr_addr_val    =>   fifo_12_wr_addr,
            fifo_13_wr_addr_val    =>   fifo_13_wr_addr,
            fifo_20_wr_addr_val    =>   fifo_20_wr_addr,
            fifo_21_wr_addr_val    =>   fifo_21_wr_addr,
            fifo_22_wr_addr_val    =>   fifo_22_wr_addr,
            fifo_23_wr_addr_val    =>   fifo_23_wr_addr,
            fifo_30_wr_addr_val    =>   fifo_30_wr_addr,
            fifo_31_wr_addr_val    =>   fifo_31_wr_addr,
            fifo_32_wr_addr_val    =>   fifo_32_wr_addr,
            fifo_33_wr_addr_val    =>   fifo_33_wr_addr,
            fifo_40_wr_addr_val    =>   fifo_40_wr_addr,
            fifo_41_wr_addr_val    =>   fifo_41_wr_addr,
            fifo_42_wr_addr_val    =>   fifo_42_wr_addr,
            fifo_43_wr_addr_val    =>   fifo_43_wr_addr,
            fifo_50_wr_addr_val    =>   fifo_50_wr_addr,
            fifo_51_wr_addr_val    =>   fifo_51_wr_addr,
            fifo_52_wr_addr_val    =>   fifo_52_wr_addr,
            fifo_53_wr_addr_val    =>   fifo_53_wr_addr,
            fifo_60_wr_addr_val    =>   fifo_60_wr_addr,
            fifo_61_wr_addr_val    =>   fifo_61_wr_addr,
            fifo_62_wr_addr_val    =>   fifo_62_wr_addr,
            fifo_63_wr_addr_val    =>   fifo_63_wr_addr,
            fifo_70_wr_addr_val    =>   fifo_70_wr_addr,
            fifo_71_wr_addr_val    =>   fifo_71_wr_addr,
            fifo_72_wr_addr_val    =>   fifo_72_wr_addr,
            fifo_73_wr_addr_val    =>   fifo_73_wr_addr,
            fifo_80_wr_addr_val    =>   fifo_80_wr_addr,
            fifo_81_wr_addr_val    =>   fifo_81_wr_addr,
            fifo_82_wr_addr_val    =>   fifo_82_wr_addr,
            fifo_83_wr_addr_val    =>   fifo_83_wr_addr,
            dqs_delayed_col0_val   =>   dqs_delayed_col0,
            dqs_delayed_col1_val   =>   dqs_delayed_col1,
            dqs_div_col0_val       =>   dqs_div_col0,
            dqs_div_col1_val       =>   dqs_div_col1
         );


data_write0	:	data_write_72bit
port map (
			clk                =>   clk,
			clk90              =>   clk90,
			reset_r            =>   reset_r,
			reset90_r          =>   reset90_r,
			reset180_r         =>   reset180_r,
			reset270_r         =>   reset270_r,

			input_data         =>   input_data,
			byte_enable        =>   byte_enable,
			write_enable       =>   write_enable,
			input_data_valid   =>   input_data_valid,
			input_data_dummy   =>   input_data_dummy,

			write_en_val       =>   ddr_write_en,
			write_data_falling =>   ddr_write_data_falling,
			write_data_rising  =>   ddr_write_data_rising,
			data_mask_falling  =>   ddr_data_mask_falling,
			data_mask_rising   =>   ddr_data_mask_rising
			);

data_path_rst0 : data_path_rst
port map (
		clk                =>   clk,
		clk90              =>   clk90,
		reset              =>   reset,
		reset90            =>   reset90,
		reset180           =>   reset180,
		reset270           =>   reset270,
		reset_r            =>   reset_r,
		reset90_r          =>   reset90_r,
		reset180_r         =>   reset180_r,
		reset270_r         =>   reset270_r
	);

-- resample the data from the data path on clk0
data_resample: process(clk)
begin
	if clk'event and clk = '1' then
		if reset = '1' then
			output_data        <= (others => '0');
			output_data_valid  <= '0';
		else
			output_data        <= output_data_90;
			output_data_valid  <= data_valid_90 and not disable_current_data;
		end if;
	end if;
end process data_resample;

-- LUT-RAM used to delay the validation of data when it comes back from the read controller
data_validate_write: process(clk)
begin
	if clk'event and clk = '1' then
		if reset = '1' then
			validate_fifo_write_address <= (others => '0');
		else
			if disable_data_valid = '1' then
				validate_fifo_write_address <= validate_fifo_write_address + 1;
			end if;
		end if;
	end if;
end process data_validate_write;

data_validate_read: process(clk90)
begin
	if clk90'event and clk90 = '1' then
		if reset90 = '1' then
			validate_fifo_read_address  <= (others => '0');
		else
			if data_valid_90 = '1' then
				validate_fifo_read_address <= validate_fifo_read_address + 1;
			end if;
		end if;
	end if;
end process data_validate_read;

validate_FIFO : RAM16X1D
port map (
		D      =>  disable_data,
		WE     =>  disable_data_valid,
		WCLK   =>  clk,
		A0     =>  validate_fifo_write_address(0),
		A1     =>  validate_fifo_write_address(1),
		A2     =>  validate_fifo_write_address(2),
		A3     =>  validate_fifo_write_address(3),
		DPRA0  =>  validate_fifo_read_address(0),
		DPRA1  =>  validate_fifo_read_address(1),
		DPRA2  =>  validate_fifo_read_address(2),
		DPRA3  =>  validate_fifo_read_address(3),
		SPO    =>  open ,
		DPO    =>  disable_current_data
		);

end   arc_data_path_72bit_rl;


library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- pragma translate_off
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
-- pragma translate_on
--

entity infrastructure is
port(
	clk                    : in std_logic;
	clk90                  : in std_logic;
	inf_reset              : in std_logic;
	user_reset             : in std_logic;
	reset0                 : out std_logic;
	reset90                : out std_logic;
	reset180               : out std_logic;
	reset270               : out std_logic
);
end   infrastructure;

architecture arc_infrastructure of infrastructure is

signal reset                 : std_logic := '1';
signal reset_reg0            : std_logic := '1';
signal reset_reg90           : std_logic := '1';
signal reset_reg180          : std_logic := '1';
signal reset_reg270          : std_logic := '1';
signal reset_reg0_resamp     : std_logic := '1';
signal reset_reg90_resamp    : std_logic := '1';
signal reset_reg180_resamp   : std_logic := '1';
signal reset_reg270_resamp   : std_logic := '1';
signal reset0_0              : std_logic := '1';
signal reset90_0             : std_logic := '1';
signal reset180_0            : std_logic := '1';
signal reset270_0            : std_logic := '1';
signal reset0_1              : std_logic := '1';
signal reset90_1             : std_logic := '1';
signal reset180_1            : std_logic := '1';
signal reset270_1            : std_logic := '1';

attribute syn_noprune : boolean;
attribute syn_noprune of reset_reg0      : signal is true;
attribute syn_noprune of reset_reg90     : signal is true;
attribute syn_noprune of reset_reg180    : signal is true;
attribute syn_noprune of reset_reg270    : signal is true;

begin


-- register the reset a first time
process(clk)
begin
	if clk'event and clk = '1' then
		reset       <= user_reset or inf_reset;
	end if;
end process;

-- register the reset a second time with a different register for each clock
process(clk)
begin
	if clk'event and clk = '1' then
		reset_reg0    <= reset;
		reset_reg90   <= reset;
		reset_reg180  <= reset;
		reset_reg270  <= reset;
	end if;
end process;

-- resample the reset on each clock
process(clk)
begin
	if clk'event and clk = '1' then
		if reset_reg0 = '1' then
			reset0_0    <= '1';
			reset0_1    <= '1';
			reset0      <= '1';
		else
			reset0_0    <= '0';
			reset0_1    <= reset0_0;
			reset0      <= reset0_1;
		end if;
	end if;
end process;

process(clk90)
begin
	if clk90'event and clk90 = '1' then
		if reset_reg90_resamp = '1' then
			reset90_0   <= '1';
			reset90_1   <= '1';
			reset90     <= '1';
		else
			reset90_0   <= '0';
			reset90_1   <= reset90_0;
			reset90     <= reset90_1;
		end if;
		reset_reg90_resamp <= reset_reg90;
	end if;
end process;

process(clk)
begin
	if clk'event and clk = '0' then
		if reset_reg180_resamp = '1' then
			reset180_0  <= '1';
			reset180_1  <= '1';
			reset180    <= '1';
		else
			reset180_0  <= '0';
			reset180_1  <= reset180_0;
			reset180    <= reset180_1;
		end if;
		reset_reg180_resamp <= reset_reg180;
	end if;
end process;

process(clk90)
begin
	if clk90'event and clk90 = '0' then
		if reset_reg270_resamp = '1' then
			reset270_0  <= '1';
			reset270_1  <= '1';
			reset270    <= '1';
		else
			reset270_0  <= '0';
			reset270_1  <= reset270_0;
			reset270    <= reset270_1;
		end if;
		reset_reg270_resamp <= reset_reg270;
	end if;
end process;



end arc_infrastructure;



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
entity   iobs_72bit  is
port(
	-- system ports
	clk                    : in  std_logic;
	clk90                  : in  std_logic;
	reset                  : in  std_logic;
	reset90                : in  std_logic;
	reset180               : in  std_logic;
	reset270               : in  std_logic;

	-- signals from/to the fabric
	ddr_rasb               : in  std_logic;
	ddr_casb               : in  std_logic;
	ddr_web                : in  std_logic;
	ddr_cke                : in  std_logic;
	ddr_csb                : in  std_logic_vector(1 downto 0);
	ddr_ODT                : in  std_logic_vector(1 downto 0);
	ddr_address            : in  std_logic_vector((row_address_p-1) downto 0);
	ddr_ba                 : in  std_logic_vector((bank_address_p-1) downto 0);
	ddr_rasb_init          : in  std_logic;
	ddr_casb_init          : in  std_logic;
	ddr_web_init           : in  std_logic;
	ddr_ba_init            : in  std_logic_vector((bank_address_p-1) downto 0);
	ddr_address_init       : in  std_logic_vector((row_address_p-1) downto 0);
	ddr_csb_init           : in  std_logic_vector(1 downto 0);
	ddr_write_data_falling : in  std_logic_vector(71 downto 0);
	ddr_write_data_rising  : in  std_logic_vector(71 downto 0);
	ddr_data_mask_falling  : in  std_logic_vector(8 downto 0);
	ddr_data_mask_rising   : in  std_logic_vector(8 downto 0);
	ddr_rst_dqs_div_out    : in  std_logic;
	ddr_rst_dqs_div_in     : out std_logic;
	ddr_dqs_int_delay_in0  : out std_logic;
	ddr_dqs_int_delay_in1  : out std_logic;
	ddr_dqs_int_delay_in2  : out std_logic;
	ddr_dqs_int_delay_in3  : out std_logic;
	ddr_dqs_int_delay_in4  : out std_logic;
	ddr_dqs_int_delay_in5  : out std_logic;
	ddr_dqs_int_delay_in6  : out std_logic;
	ddr_dqs_int_delay_in7  : out std_logic;
	ddr_dqs_int_delay_in8  : out std_logic;
	ddr_dq                 : out std_logic_vector(71 downto 0);
	ddr_force_nop          : in  std_logic;

	-- I/O pads
	pad_dqs                : inout std_logic_vector(8 downto 0);
	pad_dq                 : inout std_logic_vector(71 downto 0);
	pad_dm                 : out std_logic_vector(8 downto 0);
	pad_clk0               : out std_logic;
	pad_clk0b              : out std_logic;
	pad_clk1               : out std_logic;
	pad_clk1b              : out std_logic;
	pad_clk2               : out std_logic;
	pad_clk2b              : out std_logic;
	pad_rasb               : out std_logic;
	pad_casb               : out std_logic;
	pad_web                : out std_logic;
	pad_ba                 : out std_logic_vector((bank_address_p-1) downto 0);
	pad_address            : out std_logic_vector((row_address_p-1) downto 0);
	pad_cke                : out std_logic;
	pad_csb                : out std_logic_vector(1 downto 0);
	pad_ODT                : out std_logic_vector(1 downto 0);
	pad_rst_dqs_div_in     : in  std_logic;
	pad_rst_dqs_div_out    : out std_logic;

	-- control signals
	ctrl_dqs_reset         : in std_logic;
	ctrl_dqs_enable        : in std_logic;
	ctrl_write_en          : in std_logic
);
end   iobs_72bit;


architecture   arc_iobs_72bit of   iobs_72bit    is

component	infrastructure_iobs_72bit
port(
     clk0              : in std_logic;
     clk90             : in std_logic;
     ddr2_clk0         : out std_logic;
     ddr2_clk0b        : out std_logic;
     ddr2_clk1         : out std_logic;
     ddr2_clk1b        : out std_logic;
     ddr2_clk2         : out std_logic;
     ddr2_clk2b        : out std_logic
     );
end component;


component controller_iobs
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
end component;


component	data_path_iobs_72bit
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
end component;

signal reset270_r : std_logic;
signal clk270     : std_logic;
attribute syn_keep : boolean;
attribute syn_keep of clk270 : signal is true;

begin

-- generation of clk270
clk270 <= not clk90;

-- register the reset270 signal
reset_reg270: process(clk270)
begin
	if clk270'event and clk270 = '0' then
		reset270_r <= reset270;
	end if;
end process;

infrastructure_iobs0	:	infrastructure_iobs_72bit	port	map	(
                                                     clk0             => clk,
                                                     clk90            => clk90,
                                                     ddr2_clk0        => pad_clk0,
                                                     ddr2_clk0b       => pad_clk0b,
                                                     ddr2_clk1        => pad_clk1,
                                                     ddr2_clk1b       => pad_clk1b,
                                                     ddr2_clk2        => pad_clk2,
                                                     ddr2_clk2b       => pad_clk2b
                                                    );

controller_iobs0 : controller_iobs port map (
			clk0                 =>  clk,
			clk90                =>  clk90,
			ddr_rasb             =>  ddr_rasb,
			ddr_casb             =>  ddr_casb,
			ddr_web              =>  ddr_web,
			ddr_cke              =>  ddr_cke,
			ddr_csb              =>  ddr_csb,
			ddr_ODT              =>  ddr_ODT,
			ddr_address          =>  ddr_address((row_address_p -1) downto 0),
			ddr_ba               =>  ddr_ba((bank_address_p -1) downto 0),
			ddr_rst_dqs_div_out  =>  ddr_rst_dqs_div_out,
			ddr_rst_dqs_div_in   =>  ddr_rst_dqs_div_in,
			ddr_force_nop        =>  ddr_force_nop,
			ddr_rasb_init        =>  ddr_rasb_init,
			ddr_casb_init        =>  ddr_casb_init,
			ddr_web_init         =>  ddr_web_init,
			ddr_ba_init          =>  ddr_ba_init,
			ddr_address_init     =>  ddr_address_init,
			ddr_csb_init         =>  ddr_csb_init,
			pad_rasb             =>  pad_rasb,
			pad_casb             =>  pad_casb,
			pad_web              =>  pad_web,
			pad_ba               =>  pad_ba((bank_address_p -1) downto 0),
			pad_address          =>  pad_address((row_address_p -1) downto 0),
			pad_cke              =>  pad_cke,
			pad_csb              =>  pad_csb,
			pad_ODT              =>  pad_ODT,
			pad_rst_dqs_div_in	 =>  pad_rst_dqs_div_in,
			pad_rst_dqs_div_out  =>  pad_rst_dqs_div_out
);

data_path_iobs0	:	data_path_iobs_72bit	port	map	(
                                         clk                =>   clk,
                                         dqs_reset          =>   ctrl_dqs_reset,
                                         dqs_enable         =>   ctrl_dqs_enable,
                                         ddr_dqs            =>   pad_dqs(8 downto 0),
                                         ddr_dq             =>   pad_dq(71 downto 0),
                                         write_data_falling =>   ddr_write_data_falling(71 downto 0),
                                         write_data_rising  =>   ddr_write_data_rising(71 downto 0),
                                         write_en_val       =>   ctrl_write_en,
                                         clk90              =>   clk90,
                                         reset270_r         =>   reset270_r,
                                         data_mask_f        =>   ddr_data_mask_falling(8 downto 0),
                                         data_mask_r        =>   ddr_data_mask_rising(8 downto 0),
                                         dqs_int_delay_in0  =>   ddr_dqs_int_delay_in0,
                                         dqs_int_delay_in1  =>   ddr_dqs_int_delay_in1,
                                         dqs_int_delay_in2  =>   ddr_dqs_int_delay_in2,
                                         dqs_int_delay_in3  =>   ddr_dqs_int_delay_in3,
                                         dqs_int_delay_in4  =>   ddr_dqs_int_delay_in4,
                                         dqs_int_delay_in5  =>   ddr_dqs_int_delay_in5,
                                         dqs_int_delay_in6  =>   ddr_dqs_int_delay_in6,
                                         dqs_int_delay_in7  =>   ddr_dqs_int_delay_in7,
                                         dqs_int_delay_in8  =>   ddr_dqs_int_delay_in8,
                                         dq                 =>   ddr_dq(71 downto 0),
                                         ddr_dm             =>   pad_dm(8 downto 0)
                                        );



end   arc_iobs_72bit;



--******************************************************************************
--
--  Xilinx, Inc. 2002                 www.xilinx.com
--
--  XAPP 253 - Synthesizable DDR SDRAM Controller
--
--*******************************************************************************
--
--  File name :       RAM_8D.vhd
--
--  Description :      This block is used to build the asynchronous FIFOs from the
--                     LUT RAMs. This is specific for data clocked at the rising edge
--                     of the clock
--
--  Date - revision : 05/01/2002
--
--  Author :          Lakshmi Gopalakrishnan
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
--****************************************************************************************
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--
-- pragma translate_off
-- library UNISIM;
-- use UNISIM.VCOMPONENTS.ALL;
library work;
use work.vcomponents.all;
-- pragma translate_on
--

entity RAM_8D is
port(
   DPO : out std_logic_vector(7 downto 0);
   A0 : in std_logic;
   A1 : in std_logic;
   A2 : in std_logic;
   A3 : in std_logic;
   D  : in std_logic_vector(7 downto 0);
   DPRA0 : in std_logic;
   DPRA1 : in std_logic;
   DPRA2 : in std_logic;
   DPRA3 : in std_logic;
   WCLK  : in std_logic;
   WE    : in std_logic);
end RAM_8D;

architecture arc_RAM_8D of RAM_8D is

component RAM16X1D
  port (D     : in std_logic;
        WE    : in std_logic;
        WCLK  : in std_logic;
        A0    : in std_logic;
        A1    : in std_logic;
        A2    : in std_logic;
        A3    : in std_logic;
        DPRA0 : in std_logic;
        DPRA1 : in std_logic;
        DPRA2 : in std_logic;
        DPRA3 : in std_logic;

        SPO   : out std_logic;
        DPO   : out std_logic);
end component;


begin

B0 : RAM16X1D port map ( D => D(0),
                         WE => WE ,
                         WCLK => WCLK ,
                         A0 => A0,
                         A1 => A1,
                         A2 => A2,
                         A3 => A3,
                         DPRA0 => DPRA0,
                         DPRA1 => DPRA1,
                         DPRA2 => DPRA2,
                         DPRA3 => DPRA3,
                         SPO   => open,
                         DPO   => DPO(0) );

B1 : RAM16X1D port map ( D => D(1),
                         WE => WE ,
                         WCLK => WCLK ,
                         A0 => A0,
                         A1 => A1,
                         A2 => A2,
                         A3 => A3,
                         DPRA0 => DPRA0,
                         DPRA1 => DPRA1,
                         DPRA2 => DPRA2,
                         DPRA3 => DPRA3,
                         SPO   => open,
                         DPO   => DPO(1) );

B2 : RAM16X1D port map ( D => D(2),
                         WE => WE ,
                         WCLK => WCLK ,
                         A0 => A0,
                         A1 => A1,
                         A2 => A2,
                         A3 => A3,
                         DPRA0 => DPRA0,
                         DPRA1 => DPRA1,
                         DPRA2 => DPRA2,
                         DPRA3 => DPRA3,
                         SPO   => open,
                         DPO   => DPO(2) );

B3 : RAM16X1D port map ( D => D(3),
                         WE => WE ,
                         WCLK => WCLK ,
                         A0 => A0,
                         A1 => A1,
                         A2 => A2,
                         A3 => A3,
                         DPRA0 => DPRA0,
                         DPRA1 => DPRA1,
                         DPRA2 => DPRA2,
                         DPRA3 => DPRA3,
                         SPO   => open,
                         DPO   => DPO(3) );

B4 : RAM16X1D port map ( D => D(4),
                         WE => WE ,
                         WCLK => WCLK ,
                         A0 => A0,
                         A1 => A1,
                         A2 => A2,
                         A3 => A3,
                         DPRA0 => DPRA0,
                         DPRA1 => DPRA1,
                         DPRA2 => DPRA2,
                         DPRA3 => DPRA3,
                         SPO   => open,
                         DPO   => DPO(4) );

B5 : RAM16X1D port map ( D => D(5),
                         WE => WE ,
                         WCLK => WCLK ,
                         A0 => A0,
                         A1 => A1,
                         A2 => A2,
                         A3 => A3,
                         DPRA0 => DPRA0,
                         DPRA1 => DPRA1,
                         DPRA2 => DPRA2,
                         DPRA3 => DPRA3,
                         SPO   => open,
                         DPO   => DPO(5) );

B6 : RAM16X1D port map ( D => D(6),
                         WE => WE ,
                         WCLK => WCLK ,
                         A0 => A0,
                         A1 => A1,
                         A2 => A2,
                         A3 => A3,
                         DPRA0 => DPRA0,
                         DPRA1 => DPRA1,
                         DPRA2 => DPRA2,
                         DPRA3 => DPRA3,
                         SPO   => open,
                         DPO   => DPO(6) );

B7 : RAM16X1D port map ( D => D(7),
                         WE => WE ,
                         WCLK => WCLK ,
                         A0 => A0,
                         A1 => A1,
                         A2 => A2,
                         A3 => A3,
                         DPRA0 => DPRA0,
                         DPRA1 => DPRA1,
                         DPRA2 => DPRA2,
                         DPRA3 => DPRA3,
                         SPO   => open,
                         DPO   => DPO(7) );

end arc_RAM_8D;
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.parameter.all;
--library synplify;
--use synplify.attributes.all;
--
-- pragma translate_off
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
-- pragma translate_on
--
----------------------------------------
-- ENTITY DECLARATION
----------------------------------------
entity   ddr2_controller  is
generic(
	DIMM                    : integer := 1;
	bank_management         : integer := 0;
	IP_CLOCK                : integer := 200
);
port(
	-- user interface
	user_input_data        : in    std_logic_vector(143 downto 0);
	user_byte_enable       : in    std_logic_vector(17 downto 0);
	user_get_data          : out   std_logic;
	user_output_data       : out   std_logic_vector(143 downto 0):=(others => 'Z');
	user_data_valid        : out   std_logic;
	user_address           : in    std_logic_vector(31 downto 0);
	user_read              : in    std_logic;
	user_write             : in    std_logic;
	user_half_burst        : in    std_logic := '0';
	user_ready             : out   std_logic;
	user_reset             : in    std_logic;

	-- pads
	pad_rst_dqs_div_in     : in    std_logic;
	pad_rst_dqs_div_out    : out   std_logic;
	pad_dqs                : inout std_logic_vector(8 downto 0);
	pad_dq                 : inout std_logic_vector(71 downto 0):= (OTHERS => 'Z');
	pad_cke                : out   std_logic;
	pad_csb                : out   std_logic_vector(1 downto 0);
	pad_rasb               : out   std_logic;
	pad_casb               : out   std_logic;
	pad_web                : out   std_logic;
	pad_dm                 : out   std_logic_vector(8 downto 0);
	pad_ba                 : out   std_logic_vector((bank_address_p-1) downto 0);
	pad_address            : out   std_logic_vector((row_address_p-1) downto 0);
	pad_ODT                : out   std_logic_vector(1 downto 0);
	pad_clk0               : out   std_logic;
	pad_clk0b              : out   std_logic;
	pad_clk1               : out   std_logic;
	pad_clk1b              : out   std_logic;
	pad_clk2               : out   std_logic;
	pad_clk2b              : out   std_logic;

	-- system interface
	sys_clk                : in    std_logic;
	sys_clk90              : in    std_logic;
	sys_delay_sel          : in    std_logic_vector(4 downto 0);
	sys_inf_reset          : in    std_logic

);
end   ddr2_controller;

----------------------------------------
-- ARCHITECTURE DECLARATION
----------------------------------------

architecture   arc_ddr2_controller of   ddr2_controller is

----------------------------------------
-- state machine controller declaration
----------------------------------------
component controller
generic(
	bank_management        : integer := 0
);
port(
	-- system signals
	clk                    : in std_logic;
	reset                  : in std_logic;

	-- user interface
	user_get_data          : out std_logic;
	user_col_address       : in  std_logic_vector((column_address_p - 1) downto 0);
	user_row_address       : in  std_logic_vector((row_address_p - 1) downto 0);
	user_bank_address      : in  std_logic_vector((bank_address_p - 1) downto 0);
	user_rank_address      : in  std_logic;
	user_read              : in  std_logic;
	user_write             : in  std_logic;
	user_half_burst        : in  std_logic := '0';
	user_ready             : out std_logic;

	-- pads
	ddr_rasb               : out std_logic;
	ddr_casb               : out std_logic;
	ddr_ODT                : out std_logic_vector(1 downto 0);
	ddr_web                : out std_logic;
	ddr_ba                 : out std_logic_vector((bank_address_p-1) downto 0);
	ddr_address            : out std_logic_vector((row_address_p-1) downto 0);
	ddr_cke                : out std_logic;
	ddr_csb                : out std_logic_vector(1 downto 0);
	ddr_rst_dqs_div_out    : out std_logic;
	ddr_force_nop          : out std_logic;

	-- init pads
	ddr_rasb_init          : out std_logic;
	ddr_casb_init          : out std_logic;
	ddr_web_init           : out std_logic;
	ddr_ba_init            : out std_logic_vector((bank_address_p-1) downto 0);
	ddr_address_init       : out std_logic_vector((row_address_p-1) downto 0);
	ddr_csb_init           : out std_logic_vector(1 downto 0);

	-- data path control
	dqs_enable             : out std_logic;
	dqs_reset              : out std_logic;
	write_enable           : out std_logic;
	disable_data           : out std_logic;
	disable_data_valid     : out std_logic;
	input_data_valid       : out std_logic;
	input_data_dummy       : out std_logic
);
end component;

----------------------------------------
-- data path declaration
----------------------------------------
component	data_path_72bit_rl
port(
	-- system ports
	clk                    : in std_logic;
	clk90                  : in std_logic;
	reset                  : in std_logic;
	reset90                : in std_logic;
	reset180               : in std_logic;
	reset270               : in std_logic;
	delay_sel              : in std_logic_vector(4 downto 0);

	-- data ports (on clk0)
	input_data             : in std_logic_vector(143 downto 0);
	write_enable           : in std_logic;
	input_data_valid       : in std_logic;
	input_data_dummy       : in std_logic;
	byte_enable            : in std_logic_vector(17 downto 0);
	disable_data           : in std_logic;
	disable_data_valid     : in std_logic;
	output_data_valid      : out std_logic;
	output_data            : out std_logic_vector(143 downto 0);

	-- iobs ports
	ddr_dqs_int_delay_in0  : in std_logic;
	ddr_dqs_int_delay_in1  : in std_logic;
	ddr_dqs_int_delay_in2  : in std_logic;
	ddr_dqs_int_delay_in3  : in std_logic;
	ddr_dqs_int_delay_in4  : in std_logic;
	ddr_dqs_int_delay_in5  : in std_logic;
	ddr_dqs_int_delay_in6  : in std_logic;
	ddr_dqs_int_delay_in7  : in std_logic;
	ddr_dqs_int_delay_in8  : in std_logic;
	ddr_dq                 : in std_logic_vector(71 downto 0);
	ddr_rst_dqs_div_in     : in std_logic;
	ddr_write_en           : out std_logic;
	ddr_data_mask_falling  : out std_logic_vector(8 downto 0);
	ddr_data_mask_rising   : out std_logic_vector(8 downto 0);
	ddr_write_data_falling : out std_logic_vector(71 downto 0);
	ddr_write_data_rising  : out std_logic_vector(71 downto 0)
);
end component;

----------------------------------------
-- IO pads declaration
----------------------------------------
component	iobs_72bit
port(
	-- system ports
	clk                    : in std_logic;
	clk90                  : in std_logic;
	reset                  : in std_logic;
	reset90                : in std_logic;
	reset180               : in std_logic;
	reset270               : in std_logic;

	-- signals from/to the fabric
	ddr_rasb               : in std_logic;
	ddr_casb               : in std_logic;
	ddr_web                : in std_logic;
	ddr_cke                : in std_logic;
	ddr_csb                : in std_logic_vector(1 downto 0);
	ddr_ODT                : in std_logic_vector(1 downto 0);
	ddr_address            : in std_logic_vector((row_address_p-1) downto 0);
	ddr_ba                 : in std_logic_vector((bank_address_p-1) downto 0);
	ddr_rasb_init          : in std_logic;
	ddr_casb_init          : in std_logic;
	ddr_web_init           : in std_logic;
	ddr_ba_init            : in std_logic_vector((bank_address_p-1) downto 0);
	ddr_address_init       : in std_logic_vector((row_address_p-1) downto 0);
	ddr_csb_init           : in std_logic_vector(1 downto 0);
	ddr_write_data_falling : in std_logic_vector(71 downto 0);
	ddr_write_data_rising  : in std_logic_vector(71 downto 0);
	ddr_data_mask_falling  : in std_logic_vector(8 downto 0);
	ddr_data_mask_rising   : in std_logic_vector(8 downto 0);
	ddr_rst_dqs_div_out    : in std_logic;
	ddr_rst_dqs_div_in     : out std_logic;
	ddr_dqs_int_delay_in0  : out std_logic;
	ddr_dqs_int_delay_in1  : out std_logic;
	ddr_dqs_int_delay_in2  : out std_logic;
	ddr_dqs_int_delay_in3  : out std_logic;
	ddr_dqs_int_delay_in4  : out std_logic;
	ddr_dqs_int_delay_in5  : out std_logic;
	ddr_dqs_int_delay_in6  : out std_logic;
	ddr_dqs_int_delay_in7  : out std_logic;
	ddr_dqs_int_delay_in8  : out std_logic;
	ddr_dq                 : out std_logic_vector(71 downto 0);
	ddr_force_nop          : in  std_logic;

	-- I/O pads
	pad_dqs                : inout std_logic_vector(8 downto 0);
	pad_dq                 : inout std_logic_vector(71 downto 0);
	pad_dm                 : out std_logic_vector(8 downto 0);
	pad_clk0               : out std_logic;
	pad_clk0b              : out std_logic;
	pad_clk1               : out std_logic;
	pad_clk1b              : out std_logic;
	pad_clk2               : out std_logic;
	pad_clk2b              : out std_logic;
	pad_rasb               : out std_logic;
	pad_casb               : out std_logic;
	pad_web                : out std_logic;
	pad_ba                 : out std_logic_vector((bank_address_p-1) downto 0);
	pad_address            : out std_logic_vector((row_address_p-1) downto 0);
	pad_cke                : out std_logic;
	pad_csb                : out std_logic_vector(1 downto 0);
	pad_ODT                : out std_logic_vector(1 downto 0);
	pad_rst_dqs_div_in     : in std_logic;
	pad_rst_dqs_div_out    : out std_logic;

	-- control signals
	ctrl_dqs_reset         : in std_logic;
	ctrl_dqs_enable        : in std_logic;
	ctrl_write_en          : in std_logic

);
end component;

----------------------------------------
-- infrastructure declaration
----------------------------------------
component infrastructure
port(
	clk                    : in std_logic;
	clk90                  : in std_logic;
	inf_reset              : in std_logic;
	user_reset             : in std_logic;
	reset0                 : out std_logic;
	reset90                : out std_logic;
	reset180               : out std_logic;
	reset270               : out std_logic
);
end component;

----------------------------------------
-- DDR2 DIMM declaration
----------------------------------------

component   ddr2dimm
generic(
    bawidth            : integer := 3;
    awidth             : integer := 14;
    IP_CLOCK           : integer := 200
);
port(
	ClockPos           : in    std_logic_vector( 2 downto 0);
	ClockNeg           : in    std_logic_vector( 2 downto 0);
	ODT                : in    std_logic_vector( 1 downto 0);
	CKE                : in    std_logic_vector( 1 downto 0);
	CS_N               : in    std_logic_vector( 1 downto 0);
	RAS_N              : in    std_logic;
	CAS_N              : in    std_logic;
	WE_N               : in    std_logic;
	BA                 : in    std_logic_vector( 2 downto 0);
	A                  : in    std_logic_vector(13 downto 0);
	DM                 : in    std_logic_vector( 8 downto 0);
	DQ                 : inout std_logic_vector(71 downto 0);
	DQS                : inout std_logic_vector( 8 downto 0);
	DQS_N              : inout std_logic_vector( 8 downto 0)
);
end component;

----------------------------------------
-- signals declaration
----------------------------------------

	-- controller local resets
	signal reset0                 : std_logic := '1';
	signal reset90                : std_logic := '1';
	signal reset180               : std_logic := '1';
	signal reset270               : std_logic := '1';

	-- state machine controller signals
	signal ddr_rasb               :  std_logic;
	signal ddr_casb               :  std_logic;
	signal ddr_web                :  std_logic;
	signal ddr_ba                 :  std_logic_vector((bank_address_p-1) downto 0);
	signal ddr_address            :  std_logic_vector((row_address_p-1) downto 0);
	signal ddr_cke                :  std_logic;
	signal ddr_csb                :  std_logic_vector(1 downto 0);
	signal ddr_ODT                :  std_logic_vector(1 downto 0);
	signal ddr_force_nop          :  std_logic;
	signal ddr_rasb_init          :  std_logic;
	signal ddr_casb_init          :  std_logic;
	signal ddr_web_init           :  std_logic;
	signal ddr_ba_init            :  std_logic_vector((bank_address_p-1) downto 0);
	signal ddr_address_init       :  std_logic_vector((row_address_p-1) downto 0);
	signal ddr_csb_init           :  std_logic_vector(1 downto 0);

	-- data path signals
	-- control
	signal write_enable           : std_logic;
	signal dqs_enable             : std_logic;
	signal dqs_reset              : std_logic;
	signal input_data_valid       : std_logic;
	signal input_data_dummy       : std_logic;
	signal disable_data           : std_logic;
	signal disable_data_valid     : std_logic;
	-- active signals
	signal ddr_rst_dqs_div_in     : std_logic;
	signal ddr_rst_dqs_div_out    : std_logic;
	signal ddr_dqs_int_delay_in0  : std_logic;
	signal ddr_dqs_int_delay_in1  : std_logic;
	signal ddr_dqs_int_delay_in2  : std_logic;
	signal ddr_dqs_int_delay_in3  : std_logic;
	signal ddr_dqs_int_delay_in4  : std_logic;
	signal ddr_dqs_int_delay_in5  : std_logic;
	signal ddr_dqs_int_delay_in6  : std_logic;
	signal ddr_dqs_int_delay_in7  : std_logic;
	signal ddr_dqs_int_delay_in8  : std_logic;
	signal ddr_dq                 : std_logic_vector(71 downto 0);
	signal ddr_write_en           : std_logic;
	signal ddr_data_mask_falling  : std_logic_vector(8 downto 0);
	signal ddr_data_mask_rising   : std_logic_vector(8 downto 0);
	signal ddr_write_data_falling : std_logic_vector(71 downto 0);
	signal ddr_write_data_rising  : std_logic_vector(71 downto 0);

	-- DIMM pads
	signal sim_pad_rst_dqs_div_in  : std_logic;
	signal sim_pad_rst_dqs_div_out : std_logic;
	signal sim_pad_casb            : std_logic;
	signal sim_pad_cke             : std_logic;
	signal sim_pad_clk0            : std_logic;
	signal sim_pad_clk0b           : std_logic;
	signal sim_pad_clk1            : std_logic;
	signal sim_pad_clk1b           : std_logic;
	signal sim_pad_clk2            : std_logic;
	signal sim_pad_clk2b           : std_logic;
	signal sim_pad_csb             : std_logic_vector(1 downto 0);
	signal sim_pad_rasb            : std_logic;
	signal sim_pad_web             : std_logic;
	signal sim_pad_ODT             : std_logic_vector(1 downto 0);
	signal sim_pad_address         : std_logic_vector((row_address_p - 1) downto 0);
	signal sim_pad_ba              : std_logic_vector((bank_address_p - 1) downto 0);
	signal sim_pad_dm              : std_logic_vector(8 downto 0);
	signal sim_pad_dqs             : std_logic_vector(8 downto 0);
	signal sim_pad_dq              : std_logic_vector(71 downto 0);
	-- DIMM wiring signals
	signal dimm_clk                : std_logic_vector(2 downto 0);
	signal dimm_clkb               : std_logic_vector(2 downto 0);
	signal dimm_dqsb               : std_logic_vector(8 downto 0);
	signal dimm_cke                : std_logic_vector(1 downto 0);
	signal dimm_ba                 : std_logic_vector(2 downto 0);


begin

----------------------------------------
-- dummy assignments for XPS
----------------------------------------
pad_rst_dqs_div_out    <= '0';
pad_dqs                <= (others => '0');
pad_dq                 <= (others => '0');
pad_cke                <= '0';
pad_csb                <= (others => '0');
pad_rasb               <= '0';
pad_casb               <= '0';
pad_web                <= '0';
pad_dm                 <= (others => '0');
pad_ba                 <= (others => '0');
pad_address            <= (others => '0');
pad_ODT                <= (others => '0');
pad_clk0               <= '0';
pad_clk0b              <= '0';
pad_clk1               <= '0';
pad_clk1b              <= '0';
pad_clk2               <= '0';
pad_clk2b              <= '0';

----------------------------------------
-- state machine controller signals mapping
----------------------------------------
controller0 : controller
generic map (
	bank_management        => bank_management
)
port map (
	-- system signals
	clk                    => sys_clk                    ,
	reset                  => reset0                     ,

	-- user interface
	user_get_data          => user_get_data              ,
	user_col_address       => user_address(12 downto 3)  ,
	user_row_address       => user_address(27 downto 14) ,
	user_bank_address      => user_address(29 downto 28) ,
	user_rank_address      => user_address(13)           ,
	user_read              => user_read                  ,
	user_write             => user_write                 ,
	user_half_burst        => user_half_burst            ,
	user_ready             => user_ready                 ,

	-- pads
	ddr_rasb               => ddr_rasb                   ,
	ddr_casb               => ddr_casb                   ,
	ddr_ODT                => ddr_ODT                    ,
	ddr_web                => ddr_web                    ,
	ddr_ba                 => ddr_ba                     ,
	ddr_address            => ddr_address                ,
	ddr_cke                => ddr_cke                    ,
	ddr_csb                => ddr_csb                    ,
	ddr_rst_dqs_div_out    => ddr_rst_dqs_div_out        ,
	ddr_force_nop          => ddr_force_nop              ,

	-- init_pads
	ddr_rasb_init          => ddr_rasb_init              ,
	ddr_casb_init          => ddr_casb_init              ,
	ddr_web_init           => ddr_web_init               ,
	ddr_ba_init            => ddr_ba_init                ,
	ddr_address_init       => ddr_address_init           ,
	ddr_csb_init           => ddr_csb_init               ,

	-- data path control
	dqs_enable             => dqs_enable                 ,
	dqs_reset              => dqs_reset                  ,
	write_enable           => write_enable               ,
	disable_data           => disable_data               ,
	disable_data_valid     => disable_data_valid         ,
	input_data_valid       => input_data_valid           ,
	input_data_dummy       => input_data_dummy
);

----------------------------------------
-- data path signals mapping
----------------------------------------
data_path0	:	data_path_72bit_rl
port	map	(
	-- system ports
	clk                    => sys_clk               ,
	clk90                  => sys_clk90             ,
	reset                  => reset0                ,
	reset90                => reset90               ,
	reset180               => reset180              ,
	reset270               => reset270              ,
	delay_sel              => sys_delay_sel         ,

	-- data ports (on clk0)
	input_data             => user_input_data       ,
	write_enable           => write_enable          ,
	disable_data           => disable_data          ,
	disable_data_valid     => disable_data_valid    ,
	byte_enable            => user_byte_enable      ,
	output_data_valid      => user_data_valid       ,
	output_data            => user_output_data      ,
	input_data_valid       => input_data_valid      ,
	input_data_dummy       => input_data_dummy      ,

	-- iobs ports
	ddr_dqs_int_delay_in0  => ddr_dqs_int_delay_in0 ,
	ddr_dqs_int_delay_in1  => ddr_dqs_int_delay_in1 ,
	ddr_dqs_int_delay_in2  => ddr_dqs_int_delay_in2 ,
	ddr_dqs_int_delay_in3  => ddr_dqs_int_delay_in3 ,
	ddr_dqs_int_delay_in4  => ddr_dqs_int_delay_in4 ,
	ddr_dqs_int_delay_in5  => ddr_dqs_int_delay_in5 ,
	ddr_dqs_int_delay_in6  => ddr_dqs_int_delay_in6 ,
	ddr_dqs_int_delay_in7  => ddr_dqs_int_delay_in7 ,
	ddr_dqs_int_delay_in8  => ddr_dqs_int_delay_in8 ,
	ddr_dq                 => ddr_dq                ,
	ddr_rst_dqs_div_in     => ddr_rst_dqs_div_in    ,
	ddr_write_en           => ddr_write_en          ,
	ddr_data_mask_falling  => ddr_data_mask_falling ,
	ddr_data_mask_rising   => ddr_data_mask_rising  ,
	ddr_write_data_falling => ddr_write_data_falling,
	ddr_write_data_rising  => ddr_write_data_rising
);

----------------------------------------
-- IO pads signals mapping
----------------------------------------
iobs0	:	iobs_72bit	port	map
(
	-- system ports
	clk                    => sys_clk               ,
	clk90                  => sys_clk90             ,
	reset                  => reset0                ,
	reset90                => reset90               ,
	reset180               => reset180              ,
	reset270               => reset270              ,

	-- signals from/to the fabric
	ddr_rasb               => ddr_rasb              ,
	ddr_casb               => ddr_casb              ,
	ddr_web                => ddr_web               ,
	ddr_cke                => ddr_cke               ,
	ddr_csb                => ddr_csb               ,
	ddr_ODT                => ddr_ODT               ,
	ddr_address            => ddr_address           ,
	ddr_ba                 => ddr_ba                ,
	ddr_rasb_init          => ddr_rasb_init         ,
	ddr_casb_init          => ddr_casb_init         ,
	ddr_web_init           => ddr_web_init          ,
	ddr_ba_init            => ddr_ba_init           ,
	ddr_address_init       => ddr_address_init      ,
	ddr_csb_init           => ddr_csb_init          ,
	ddr_write_data_falling => ddr_write_data_falling,
	ddr_write_data_rising  => ddr_write_data_rising ,
	ddr_data_mask_falling  => ddr_data_mask_falling ,
	ddr_data_mask_rising   => ddr_data_mask_rising  ,
	ddr_rst_dqs_div_out    => ddr_rst_dqs_div_out   ,
	ddr_rst_dqs_div_in     => ddr_rst_dqs_div_in    ,
	ddr_dqs_int_delay_in0  => ddr_dqs_int_delay_in0 ,
	ddr_dqs_int_delay_in1  => ddr_dqs_int_delay_in1 ,
	ddr_dqs_int_delay_in2  => ddr_dqs_int_delay_in2 ,
	ddr_dqs_int_delay_in3  => ddr_dqs_int_delay_in3 ,
	ddr_dqs_int_delay_in4  => ddr_dqs_int_delay_in4 ,
	ddr_dqs_int_delay_in5  => ddr_dqs_int_delay_in5 ,
	ddr_dqs_int_delay_in6  => ddr_dqs_int_delay_in6 ,
	ddr_dqs_int_delay_in7  => ddr_dqs_int_delay_in7 ,
	ddr_dqs_int_delay_in8  => ddr_dqs_int_delay_in8 ,
	ddr_dq                 => ddr_dq                ,
	ddr_force_nop          => ddr_force_nop         ,

	-- I/O pads
	pad_dqs                => sim_pad_dqs               ,
	pad_dq                 => sim_pad_dq                ,
	pad_dm                 => sim_pad_dm                ,
	pad_clk0               => sim_pad_clk0              ,
	pad_clk0b              => sim_pad_clk0b             ,
	pad_clk1               => sim_pad_clk1              ,
	pad_clk1b              => sim_pad_clk1b             ,
	pad_clk2               => sim_pad_clk2              ,
	pad_clk2b              => sim_pad_clk2b             ,
	pad_rasb               => sim_pad_rasb              ,
	pad_casb               => sim_pad_casb              ,
	pad_web                => sim_pad_web               ,
	pad_ba                 => sim_pad_ba                ,
	pad_address            => sim_pad_address           ,
	pad_cke                => sim_pad_cke               ,
	pad_csb                => sim_pad_csb               ,
	pad_ODT                => sim_pad_ODT               ,
	pad_rst_dqs_div_in     => sim_pad_rst_dqs_div_in    ,
	pad_rst_dqs_div_out    => sim_pad_rst_dqs_div_out   ,

	-- control signals
	ctrl_dqs_reset         => dqs_reset             ,
	ctrl_dqs_enable        => dqs_enable            ,
	ctrl_write_en          => ddr_write_en

);

----------------------------------------
-- infrastructure signals mapping
----------------------------------------
infrastructure0 : infrastructure port map
(
	clk                    => sys_clk               ,
	clk90                  => sys_clk90             ,
	inf_reset              => sys_inf_reset         ,
	user_reset             => user_reset            ,
	reset0                 => reset0                ,
	reset90                => reset90               ,
	reset180               => reset180              ,
	reset270               => reset270
);

----------------------------------------
-- DDR2 DIMM signal mapping
----------------------------------------

sim_pad_rst_dqs_div_in <= sim_pad_rst_dqs_div_out after 10 ms;

dimm_clk(0)  <= sim_pad_clk0;
dimm_clk(1)  <= sim_pad_clk1;
dimm_clk(2)  <= sim_pad_clk2;
dimm_clkb(0) <= sim_pad_clk0b;
dimm_clkb(1) <= sim_pad_clk1b;
dimm_clkb(2) <= sim_pad_clk2b;
dimm_dqsb    <= (others => '0');
dimm_cke     <= sim_pad_cke & sim_pad_cke;
dimm_ba      <= '0' & sim_pad_ba;

ddr2dimm0 : ddr2dimm
generic map
(
    IP_CLOCK           => IP_CLOCK
)
port map
(
	ClockPos           => dimm_clk        ,
	ClockNeg           => dimm_clkb       ,
	ODT                => sim_pad_ODT     ,
	CKE                => dimm_cke        ,
	CS_N               => sim_pad_csb     ,
	RAS_N              => sim_pad_rasb    ,
	CAS_N              => sim_pad_casb    ,
	WE_N               => sim_pad_web     ,
	BA                 => dimm_ba         ,
	A                  => sim_pad_address ,
	DM                 => sim_pad_dm      ,
	DQ                 => sim_pad_dq      ,
	DQS                => sim_pad_dqs     ,
	DQS_N              => dimm_dqsb
);

end   arc_ddr2_controller;


