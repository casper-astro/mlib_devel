#!/bin/sh

mkdir work

echo "Compiling Core Netlist"
ncvhdl -v93 -work work ../../implement/results/routed.vhd

echo "Compiling Testbench"
ncvhdl -v93 -work work ../demo_tb.vhd 

echo "Compiling SDF file"
ncsdfc ../../implement/results/routed.sdf -output ./routed.sdf.X

echo "Generating SDF command file"
echo 'COMPILED_SDF_FILE = "routed.sdf.X",' > sdf.cmd
echo 'SCOPE = behav.dut,' >> sdf.cmd
echo 'MTM_CONTROL = "MINIMUM";' >> sdf.cmd

echo "Elaborating Design"
ncelab -nowarn BNDMEM -access +rwc -sdf_cmd_file sdf.cmd work.testbench:behav

echo "Simulating Design"
ncsim -gui -input @"simvision -input wave_ncsim.sv" work.testbench:behav
