vlib work
vmap work work
vcom -work work ../../../ten_gig_eth_mac_v8_0.vhd
vcom -work work ../../example_design/fifo/xgmac_fifo_pack.vhd
vcom -work work ../../example_design/fifo/fifo_ram.vhd
vcom -work work ../../example_design/fifo/tx_fifo.vhd
vcom -work work ../../example_design/fifo/rx_fifo.vhd
vcom -work work ../../example_design/fifo/xgmac_fifo.vhd
vcom -work work ../../example_design/client_loopback.vhd
vcom -work work ../../example_design/address_swap.vhd
vcom -work work ../../example_design/physical_if.vhd
 
vcom -work work ../../example_design/ten_gig_eth_mac_v8_0_block.vhd
vcom -work work ../../example_design/ten_gig_eth_mac_v8_0_local_link.vhd
vcom -work work ../../example_design/ten_gig_eth_mac_v8_0_example_design.vhd
vcom -work work ../demo_tb.vhd
vsim -gfunc_sim=true -t ps work.testbench
do wave_mti.do
run -all
