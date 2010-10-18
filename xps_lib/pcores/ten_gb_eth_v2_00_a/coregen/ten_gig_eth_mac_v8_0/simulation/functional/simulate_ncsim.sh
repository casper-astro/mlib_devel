#!/bin/sh

mkdir work

echo "Compiling Core Simulation Models"
ncvhdl -v93 -work work ../../../ten_gig_eth_mac_v8_0.vhd
ncvhdl -v93 -work work ../../example_design/fifo/xgmac_fifo_pack.vhd
ncvhdl -v93 -work work ../../example_design/fifo/fifo_ram.vhd
ncvhdl -v93 -work work ../../example_design/fifo/tx_fifo.vhd
ncvhdl -v93 -work work ../../example_design/fifo/rx_fifo.vhd
ncvhdl -v93 -work work ../../example_design/fifo/xgmac_fifo.vhd
ncvhdl -v93 -work work ../../example_design/client_loopback.vhd
ncvhdl -v93 -work work ../../example_design/address_swap.vhd
ncvhdl -v93 -work work ../../example_design/physical_if.vhd
ncvhdl -v93 -work work ../../example_design/ten_gig_eth_mac_v8_0_block.vhd
ncvhdl -v93 -work work ../../example_design/ten_gig_eth_mac_v8_0_local_link.vhd
ncvhdl -v93 -work work ../../example_design/ten_gig_eth_mac_v8_0_example_design.vhd

echo "Compiling Testbench"
ncvhdl -v93 -work work ../demo_tb.vhd

echo "Elaborating Design"
ncelab  -generic 'func_sim=>"true"' -access +rwc work.testbench:behav

echo "Simulating Design"
ncsim -gui -input @"simvision -input wave_ncsim.sv" work.testbench:behav 
