-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1.1 (lin64) Build 2580384 Sat Jun 29 08:04:45 MDT 2019
-- Date        : Mon Jul 15 17:22:22 2019
-- Host        : casper1 running 64-bit Ubuntu 16.04.6 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /home/hpw1/work/tutorials_devel/vivado_2018/skarab/tut_intro/skarab_tut_intro/myproj/myproj.srcs/sources_1/ip/fifo_dual_clk/fifo_dual_clk_stub.vhdl
-- Design      : fifo_dual_clk
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7vx690tffg1927-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fifo_dual_clk is
  Port ( 
    rst : in STD_LOGIC;
    wr_clk : in STD_LOGIC;
    rd_clk : in STD_LOGIC;
    din : in STD_LOGIC_VECTOR ( 263 downto 0 );
    wr_en : in STD_LOGIC;
    rd_en : in STD_LOGIC;
    dout : out STD_LOGIC_VECTOR ( 263 downto 0 );
    full : out STD_LOGIC;
    empty : out STD_LOGIC
  );

end fifo_dual_clk;

architecture stub of fifo_dual_clk is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "rst,wr_clk,rd_clk,din[263:0],wr_en,rd_en,dout[263:0],full,empty";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "fifo_generator_v13_2_4,Vivado 2019.1.1";
begin
end;