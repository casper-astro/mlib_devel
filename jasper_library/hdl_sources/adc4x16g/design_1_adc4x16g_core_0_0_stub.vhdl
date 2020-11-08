-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
-- Date        : Mon Aug 10 16:12:58 2020
-- Host        : DESKTOP-V18QKD3 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               C:/XilinxProjects/SAO_ADC/ADC4X16G_system/ADC4X16G_system.srcs/sources_1/bd/design_1/ip/design_1_adc4x16g_core_0_0/design_1_adc4x16g_core_0_0_stub.vhdl
-- Design      : design_1_adc4x16g_core_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xcvu37p-fsvh2892-2L-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_1_adc4x16g_core_0_0 is
  Port ( 
    refclk0_p : in STD_LOGIC;
    refclk0_n : in STD_LOGIC;
    refclk1_p : in STD_LOGIC;
    refclk1_n : in STD_LOGIC;
    refclk2_p : in STD_LOGIC;
    refclk2_n : in STD_LOGIC;
    refclk3_p : in STD_LOGIC;
    refclk3_n : in STD_LOGIC;
    clk100 : in STD_LOGIC;
    clk_freerun : in STD_LOGIC;
    gtwiz_reset_all_in : in STD_LOGIC;
    bit_sel : in STD_LOGIC_VECTOR ( 1 downto 0 );
    chan_sel : in STD_LOGIC_VECTOR ( 1 downto 0 );
    gty0rxp_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gty0rxn_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gty1rxp_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gty1rxn_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gty2rxp_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gty2rxn_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gty3rxp_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gty3rxn_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxcdrhold : in STD_LOGIC;
    rxslide : in STD_LOGIC;
    XOR_ON : in STD_LOGIC;
    match_pattern : in STD_LOGIC_VECTOR ( 31 downto 0 );
    pattern_match_enable : in STD_LOGIC;
    rxprbserr_out : out STD_LOGIC_VECTOR ( 15 downto 0 );
    rxprbslocked : out STD_LOGIC;
    fifo_reset : in STD_LOGIC;
    fifo_read : in STD_LOGIC;
    fifo_full : out STD_LOGIC;
    data_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    prbs_error_count_reset : in STD_LOGIC;
    drp_addr : in STD_LOGIC_VECTOR ( 9 downto 0 );
    drp_reset : in STD_LOGIC;
    drp_read : in STD_LOGIC;
    drp_data : out STD_LOGIC_VECTOR ( 15 downto 0 );
    write_interval : in STD_LOGIC_VECTOR ( 7 downto 0 )
  );

end design_1_adc4x16g_core_0_0;

architecture stub of design_1_adc4x16g_core_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "refclk0_p,refclk0_n,refclk1_p,refclk1_n,refclk2_p,refclk2_n,refclk3_p,refclk3_n,clk100,clk_freerun,gtwiz_reset_all_in,bit_sel[1:0],chan_sel[1:0],gty0rxp_in[3:0],gty0rxn_in[3:0],gty1rxp_in[3:0],gty1rxn_in[3:0],gty2rxp_in[3:0],gty2rxn_in[3:0],gty3rxp_in[3:0],gty3rxn_in[3:0],rxcdrhold,rxslide,XOR_ON,match_pattern[31:0],pattern_match_enable,rxprbserr_out[15:0],rxprbslocked,fifo_reset,fifo_read,fifo_full,data_out[31:0],prbs_error_count_reset,drp_addr[9:0],drp_reset,drp_read,drp_data[15:0],write_interval[7:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "gty_wrapper_0,Vivado 2019.2";
begin
end;
