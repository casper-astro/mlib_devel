-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
-- Date        : Tue Jul 31 13:23:56 2018
-- Host        : gavin-win7 running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode synth_stub
--               W:/VHDL/Proj/FRM123701U1R4/Vivado/FRM123701U1R4.srcs/sources_1/ip/adc_data_sync_fifo/adc_data_sync_fifo_stub.vhdl
-- Design      : adc_data_sync_fifo
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7vx690tffg1927-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adc_data_sync_fifo is
  Port ( 
    clk : in STD_LOGIC;
    srst : in STD_LOGIC;
    din : in STD_LOGIC_VECTOR ( 128 downto 0 );
    wr_en : in STD_LOGIC;
    rd_en : in STD_LOGIC;
    dout : out STD_LOGIC_VECTOR ( 128 downto 0 );
    full : out STD_LOGIC;
    empty : out STD_LOGIC
  );

end adc_data_sync_fifo;

architecture stub of adc_data_sync_fifo is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,srst,din[128:0],wr_en,rd_en,dout[128:0],full,empty";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "fifo_generator_v13_1_1,Vivado 2016.2";
begin
end;
