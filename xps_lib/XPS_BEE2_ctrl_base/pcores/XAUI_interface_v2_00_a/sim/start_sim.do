# link to the ddr2 controller library

vlib work
vmap work work
vmap unisim        /opt/ISE81/iselib/unisim
vmap XilinxCoreLib /opt/ISE81/iselib/XilinxCoreLib

vcom -93 xaui_bench.vhd
vcom -93 ../hdl/vhdl/tx_fifo.vhd
vcom -93 ../hdl/vhdl/tx_fifo_2x.vhd
vcom -93 ../hdl/vhdl/rx_fifo.vhd
vcom -93 ../hdl/vhdl/rx_fifo_2x.vhd
vcom -93 ../hdl/vhdl/xaui_if.vhd
vcom -93 ../hdl/vhdl/transceiver.vhd
vcom -93 ../hdl/vhdl/XAUI_interface.vhd

vsim -t 1ps work.xaui_bench

add wave -divider {System signals}
add wave sim:/xaui_bench/mgt_clk_10G
add wave sim:/xaui_bench/mgt_clk_8G
add wave sim:/xaui_bench/app_clk

add wave -divider {TX ports}
add wave -radix Hexadecimal sim:/xaui_bench/tx_data      
add wave -radix Hexadecimal sim:/xaui_bench/tx_outofband 
add wave sim:/xaui_bench/tx_valid     
add wave sim:/xaui_bench/tx_ack
add wave -radix Decimal sim:/xaui_bench/tx_empty_slots

add wave -divider {RX ports}
add wave -radix Hexadecimal sim:/xaui_bench/rx_data      
add wave -radix Hexadecimal sim:/xaui_bench/rx_outofband 
add wave sim:/xaui_bench/rx_valid      
add wave sim:/xaui_bench/rx_ack       
add wave -radix Decimal sim:/xaui_bench/rx_full_slots

add wave -divider {TX Controller signals}
add wave -radix Symbolic    sim:/xaui_bench/xaui_if_0/tx_state
add wave -radix Hexadecimal sim:/xaui_bench/xaui_if_0/packet_counter           
add wave -radix Hexadecimal sim:/xaui_bench/xaui_if_0/xaui_tx_outofband_last   
add wave sim:/xaui_bench/xaui_if_0/xaui_tx_fifo_ack         
add wave sim:/xaui_bench/xaui_if_0/xaui_tx_fifo_packet_ack
add wave sim:/xaui_bench/xaui_if_0/xaui_tx_fifo_outofband_ack    
add wave -radix Hexadecimal sim:/xaui_bench/xaui_if_0/xaui_tx_fifo_data        
add wave -radix Hexadecimal sim:/xaui_bench/xaui_if_0/xaui_tx_fifo_outofband   
add wave sim:/xaui_bench/xaui_if_0/xaui_tx_fifo_valid       
add wave sim:/xaui_bench/xaui_if_0/xaui_tx_stop_sending

add wave -divider {RX Controller signals}
add wave -radix Symbolic    sim:/xaui_bench/xaui_if_0/rx_state
add wave sim:/xaui_bench/xaui_if_0/rx_data_is_aligned
add wave -radix Hexadecimal sim:/xaui_bench/xaui_if_0/xaui_rx_fifo_data        
add wave -radix Hexadecimal sim:/xaui_bench/xaui_if_0/xaui_rx_fifo_outofband   
add wave sim:/xaui_bench/xaui_if_0/xaui_rx_fifo_valid
add wave sim:/xaui_bench/xaui_if_0/xaui_rx_fifo_almost_full

add wave -divider {RX Controller signals}
add wave -radix Hexadecimal sim:/xaui_bench/test_diff
add wave -radix Hexadecimal sim:/xaui_bench/test_last

add wave -divider {Controller <-> XAUI IP signals}
add wave -radix Hexadecimal sim:/xaui_bench/xaui_if_0/xaui_tx_data              
add wave -radix Binary sim:/xaui_bench/xaui_if_0/xaui_tx_ctrl              
add wave -radix Hexadecimal sim:/xaui_bench/xaui_if_0/xaui_rx_data              
add wave -radix Binary sim:/xaui_bench/xaui_if_0/xaui_rx_ctrl              
add wave -radix Binary sim:/xaui_bench/xaui_if_0/xaui_configuration_vector 
add wave -radix Binary sim:/xaui_bench/xaui_if_0/xaui_status_vector        

add wave -divider {Monitor signals}
add wave -radix Symbolic    sim:/xaui_bench/xaui_if_0/monitor_state
add wave sim:/xaui_bench/xaui_if_0/rx_up
add wave -radix Binary sim:/xaui_bench/xaui_if_0/xaui_reset_cnt
add wave sim:/xaui_bench/linkdown


add wave -divider {High speed lines}
add wave sim:/xaui_bench/fault;
add wave sim:/xaui_bench/mgt_rx_l0_p;
add wave sim:/xaui_bench/mgt_rx_l0_n;
add wave sim:/xaui_bench/mgt_rx_l1_p;
add wave sim:/xaui_bench/mgt_rx_l1_n;
add wave sim:/xaui_bench/mgt_rx_l2_p;
add wave sim:/xaui_bench/mgt_rx_l2_n;
add wave sim:/xaui_bench/mgt_rx_l3_p;
add wave sim:/xaui_bench/mgt_rx_l3_n;
add wave sim:/xaui_bench/mgt_tx_l0_p;
add wave sim:/xaui_bench/mgt_tx_l0_n;
add wave sim:/xaui_bench/mgt_tx_l1_p;
add wave sim:/xaui_bench/mgt_tx_l1_n;
add wave sim:/xaui_bench/mgt_tx_l2_p;
add wave sim:/xaui_bench/mgt_tx_l2_n;
add wave sim:/xaui_bench/mgt_tx_l3_p;
add wave sim:/xaui_bench/mgt_tx_l3_n;

run 40us
