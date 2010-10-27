vlib work
vmap work work
vcom -work work ../../../xaui_v6_2.vhd
vcom -work work ../../example_design/transceiver.vhd
vcom -work work ../../example_design/xaui_v6_2_top.vhd
vcom -work work ../demo_tb.vhd

vsim -t ps work.testbench
do wave_mti.do
run -all
