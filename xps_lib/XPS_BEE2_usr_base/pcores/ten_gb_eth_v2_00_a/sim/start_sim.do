# link to the ddr2 controller library

vlib work
vmap work work

vcom -93 ten_gb_eth_bench.vhd
vcom -93 ../simhdl/vhdl/packet_buffer.vhd
vcom -93 ../simhdl/vhdl/packet_buffer_cpu.vhd
vcom -93 ../simhdl/vhdl/arp_cache.vhd
vcom -93 ../simhdl/vhdl/address_fifo.vhd
vcom -93 ../simhdl/vhdl/xaui_v6_2.vhd
vcom -93 ../simhdl/vhdl/ten_gig_eth_mac_v8_0.vhd
vcom -93 ../simhdl/vhdl/plb_attach.vhd
vcom -93 ../hdl/vhdl/ten_gig_eth_mac_UCB.vhd
vcom -93 ../hdl/vhdl/retimer.vhd
vcom -93 ../hdl/vhdl/transceiver.vhd
vcom -93 ../hdl/vhdl/ten_gb_eth.vhd

vsim -t 1ps work.ten_gb_eth_bench

add wave -divider {System signals}
add wave sim:/ten_gb_eth_bench/mgt_clk_10G
add wave sim:/ten_gb_eth_bench/mgt_clk_8G
add wave sim:/ten_gb_eth_bench/app_clk
add wave sim:/ten_gb_eth_bench/PLB_Clk

add wave -divider {TX ports}
add wave -radix Hexadecimal sim:/ten_gb_eth_bench/tx_data      
add wave -radix Hexadecimal sim:/ten_gb_eth_bench/tx_dest_ip
add wave -radix Hexadecimal sim:/ten_gb_eth_bench/tx_dest_port
add wave sim:/ten_gb_eth_bench/tx_valid     
add wave sim:/ten_gb_eth_bench/tx_ack
add wave sim:/ten_gb_eth_bench/tx_end_of_frame
add wave sim:/ten_gb_eth_bench/tx_discard

add wave -divider {RX ports}
add wave -radix Hexadecimal sim:/ten_gb_eth_bench/rx_data      
add wave -radix Hexadecimal sim:/ten_gb_eth_bench/rx_size
add wave -radix Hexadecimal sim:/ten_gb_eth_bench/rx_source_ip
add wave -radix Hexadecimal sim:/ten_gb_eth_bench/rx_source_port 
add wave sim:/ten_gb_eth_bench/rx_valid      
add wave sim:/ten_gb_eth_bench/rx_ack       
add wave sim:/ten_gb_eth_bench/rx_end_of_frame

add wave -divider {Local parameters signals}
add wave -radix Hexadecimal    sim:/ten_gb_eth_bench/ten_gb_eth_0/local_*

add wave -divider {TX Controller signals}
add wave -radix Hexadecimal    sim:/ten_gb_eth_bench/ten_gb_eth_0/tx_*

add wave -divider {RX Controller signals}
add wave -radix Hexadecimal    sim:/ten_gb_eth_bench/ten_gb_eth_0/rx_*

add wave -divider {CPU signals}
add wave -radix Hexadecimal    sim:/ten_gb_eth_bench/ten_gb_eth_0/cpu_*

add wave -divider {RX Retimer signals}
add wave -radix Hexadecimal sim:/ten_gb_eth_bench/ten_gb_eth_0/rx_read_address_retimer/*

add wave -divider {TX Retimer signals}
add wave -radix Hexadecimal sim:/ten_gb_eth_bench/ten_gb_eth_0/tx_read_address_retimer/*

add wave -divider {10Gb core signals}
add wave -radix Hexadecimal sim:/ten_gb_eth_bench/ten_gb_eth_0/ucb_mac/mac/reset                
add wave -radix Hexadecimal sim:/ten_gb_eth_bench/ten_gb_eth_0/ucb_mac/mac/tx_underrun          
add wave -radix Hexadecimal sim:/ten_gb_eth_bench/ten_gb_eth_0/ucb_mac/mac/tx_data              
add wave -radix Hexadecimal sim:/ten_gb_eth_bench/ten_gb_eth_0/ucb_mac/mac/tx_data_valid        
add wave -radix Hexadecimal sim:/ten_gb_eth_bench/ten_gb_eth_0/ucb_mac/mac/tx_start             
add wave -radix Hexadecimal sim:/ten_gb_eth_bench/ten_gb_eth_0/ucb_mac/mac/tx_ack               
add wave -radix Hexadecimal sim:/ten_gb_eth_bench/ten_gb_eth_0/ucb_mac/mac/tx_ifg_delay         
add wave -radix Hexadecimal sim:/ten_gb_eth_bench/ten_gb_eth_0/ucb_mac/mac/tx_statistics_vector 
add wave -radix Hexadecimal sim:/ten_gb_eth_bench/ten_gb_eth_0/ucb_mac/mac/tx_statistics_valid  
add wave -radix Hexadecimal sim:/ten_gb_eth_bench/ten_gb_eth_0/ucb_mac/mac/rx_data              
add wave -radix Hexadecimal sim:/ten_gb_eth_bench/ten_gb_eth_0/ucb_mac/mac/rx_data_valid        
add wave -radix Hexadecimal sim:/ten_gb_eth_bench/ten_gb_eth_0/ucb_mac/mac/rx_good_frame        
add wave -radix Hexadecimal sim:/ten_gb_eth_bench/ten_gb_eth_0/ucb_mac/mac/rx_bad_frame         
add wave -radix Hexadecimal sim:/ten_gb_eth_bench/ten_gb_eth_0/ucb_mac/mac/rx_statistics_vector 
add wave -radix Hexadecimal sim:/ten_gb_eth_bench/ten_gb_eth_0/ucb_mac/mac/rx_statistics_valid  
add wave -radix Hexadecimal sim:/ten_gb_eth_bench/ten_gb_eth_0/ucb_mac/mac/pause_val            
add wave -radix Hexadecimal sim:/ten_gb_eth_bench/ten_gb_eth_0/ucb_mac/mac/pause_req            
add wave -radix Hexadecimal sim:/ten_gb_eth_bench/ten_gb_eth_0/ucb_mac/mac/configuration_vector 
add wave -radix Hexadecimal sim:/ten_gb_eth_bench/ten_gb_eth_0/ucb_mac/mac/tx_clk0              
add wave -radix Hexadecimal sim:/ten_gb_eth_bench/ten_gb_eth_0/ucb_mac/mac/tx_dcm_lock          
add wave -radix Hexadecimal sim:/ten_gb_eth_bench/ten_gb_eth_0/ucb_mac/mac/xgmii_txd            
add wave -radix Hexadecimal sim:/ten_gb_eth_bench/ten_gb_eth_0/ucb_mac/mac/xgmii_txc            
add wave -radix Hexadecimal sim:/ten_gb_eth_bench/ten_gb_eth_0/ucb_mac/mac/rx_clk0              
add wave -radix Hexadecimal sim:/ten_gb_eth_bench/ten_gb_eth_0/ucb_mac/mac/rx_dcm_lock          
add wave -radix Hexadecimal sim:/ten_gb_eth_bench/ten_gb_eth_0/ucb_mac/mac/xgmii_rxd            
add wave -radix Hexadecimal sim:/ten_gb_eth_bench/ten_gb_eth_0/ucb_mac/mac/xgmii_rxc            

add wave -divider {LEDs signals}
add wave sim:/ten_gb_eth_bench/ten_gb_eth_0/led_up
add wave sim:/ten_gb_eth_bench/ten_gb_eth_0/led_rx
add wave sim:/ten_gb_eth_bench/ten_gb_eth_0/led_tx

add wave -divider {High speed lines}
add wave sim:/ten_gb_eth_bench/fault;
add wave sim:/ten_gb_eth_bench/mgt_rx_l0_p;
add wave sim:/ten_gb_eth_bench/mgt_rx_l0_n;
add wave sim:/ten_gb_eth_bench/mgt_rx_l1_p;
add wave sim:/ten_gb_eth_bench/mgt_rx_l1_n;
add wave sim:/ten_gb_eth_bench/mgt_rx_l2_p;
add wave sim:/ten_gb_eth_bench/mgt_rx_l2_n;
add wave sim:/ten_gb_eth_bench/mgt_rx_l3_p;
add wave sim:/ten_gb_eth_bench/mgt_rx_l3_n;
add wave sim:/ten_gb_eth_bench/mgt_tx_l0_p;
add wave sim:/ten_gb_eth_bench/mgt_tx_l0_n;
add wave sim:/ten_gb_eth_bench/mgt_tx_l1_p;
add wave sim:/ten_gb_eth_bench/mgt_tx_l1_n;
add wave sim:/ten_gb_eth_bench/mgt_tx_l2_p;
add wave sim:/ten_gb_eth_bench/mgt_tx_l2_n;
add wave sim:/ten_gb_eth_bench/mgt_tx_l3_p;
add wave sim:/ten_gb_eth_bench/mgt_tx_l3_n;

run 40us
