-- Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2014.3.1 (lin64) Build 1056140 Thu Oct 30 16:30:39 MDT 2014
-- Date        : Mon May 23 14:31:02 2016
-- Host        : adam-cm running 64-bit Ubuntu 14.04.4 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /home/aisaacson/work/git_work/ska_sa/projects/skarab_bsp_firmware/firmware/FRM123701U1R1/Vivado/Source/SKA_40GbE_PHY/IEEE802_3_XL_PCS/IEEE802_3_XL_PCS.srcs/sources_1/ip/XGMII_FIFO_DUAL_SYNC/XGMII_FIFO_DUAL_SYNC_stub.vhdl
-- Design      : XGMII_FIFO_DUAL_SYNC
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7vx690tffg1927-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity XGMII_FIFO_DUAL_SYNC is
  Port ( 
    rst : in STD_LOGIC;
    wr_clk : in STD_LOGIC;
    rd_clk : in STD_LOGIC;
    din : in STD_LOGIC_VECTOR ( 287 downto 0 );
    wr_en : in STD_LOGIC;
    rd_en : in STD_LOGIC;
    dout : out STD_LOGIC_VECTOR ( 287 downto 0 );
    full : out STD_LOGIC;
    empty : out STD_LOGIC
  );

end XGMII_FIFO_DUAL_SYNC;

architecture stub of XGMII_FIFO_DUAL_SYNC is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "rst,wr_clk,rd_clk,din[287:0],wr_en,rd_en,dout[287:0],full,empty";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "fifo_generator_v12_0,Vivado 2014.3.1";
begin
end;
