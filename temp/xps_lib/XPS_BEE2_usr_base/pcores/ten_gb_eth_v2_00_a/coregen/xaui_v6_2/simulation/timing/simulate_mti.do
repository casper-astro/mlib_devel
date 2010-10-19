vlib work
vmap work work
vcom -work work ../../implement/results/routed.vhd
vcom -work work ../demo_tb.vhd
vsim +no_tchk_msg -t ps -sdfmax /dut=../../implement/results/routed.sdf work.testbench
do wave_mti.do
run -all
