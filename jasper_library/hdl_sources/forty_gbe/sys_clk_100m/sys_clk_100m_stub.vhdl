-- Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2014.3.1 (win64) Build 1056140 Thu Oct 30 17:03:40 MDT 2014
-- Date        : Mon Jan 19 12:24:34 2015
-- Host        : gavin-win7 running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode synth_stub
--               w:/VHDL/Proj/FRM123701U1R1/Vivado/FRM123701U1R1.srcs/sources_1/ip/sys_clk_100m/sys_clk_100m_stub.vhdl
-- Design      : sys_clk_100m
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7vx690tffg1927-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sys_clk_100m is
  Port ( 
    clk_in1 : in STD_LOGIC;
    clkfb_in : in STD_LOGIC;
    clk_out1 : out STD_LOGIC;
    clkfb_out : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC
  );

end sys_clk_100m;

architecture stub of sys_clk_100m is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_in1,clkfb_in,clk_out1,clkfb_out,reset,locked";
begin
end;
