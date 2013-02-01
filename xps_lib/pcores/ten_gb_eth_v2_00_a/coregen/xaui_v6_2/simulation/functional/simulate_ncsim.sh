#!/bin/sh

mkdir work

echo "Compiling Core Simulation Models"
ncvhdl -v93 -work work ../../../xaui_v6_2.vhd
ncvhdl -v93 -work work ../../example_design/transceiver.vhd
ncvhdl -v93 -work work ../../example_design/xaui_v6_2_top.vhd

echo "Compiling Testbench"
ncvhdl -v93 -work work ../demo_tb.vhd

echo "Elaborating Design"
ncelab  -access +rwc work.testbench:behav

echo "Simulating Design"
ncsim -gui -input @"simvision -input wave_ncsim.sv" work.testbench:behav
