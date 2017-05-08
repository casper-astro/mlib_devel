-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.2 (lin64) Build 1577090 Thu Jun  2 16:32:35 MDT 2016
-- Date        : Fri May  5 15:25:53 2017
-- Host        : adam-cm running 64-bit Ubuntu 14.04.5 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /home/aisaacson/work/git_work/ska_sa/projects/mlib_devel/jasper_library/test_models/test_hmc_vacc_nosnap/myproj/myproj.srcs/sources_1/ip/hmc_user_axi_fifo/hmc_user_axi_fifo_stub.vhdl
-- Design      : hmc_user_axi_fifo
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7vx690tffg1927-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hmc_user_axi_fifo is
  Port ( 
    s_aclk : in STD_LOGIC;
    s_aresetn : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 511 downto 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 511 downto 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 15 downto 0 );
    axis_overflow : out STD_LOGIC;
    axis_underflow : out STD_LOGIC
  );

end hmc_user_axi_fifo;

architecture stub of hmc_user_axi_fifo is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "s_aclk,s_aresetn,s_axis_tvalid,s_axis_tready,s_axis_tdata[511:0],s_axis_tuser[15:0],m_axis_tvalid,m_axis_tready,m_axis_tdata[511:0],m_axis_tuser[15:0],axis_overflow,axis_underflow";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "fifo_generator_v13_1_1,Vivado 2016.2";
begin
end;
