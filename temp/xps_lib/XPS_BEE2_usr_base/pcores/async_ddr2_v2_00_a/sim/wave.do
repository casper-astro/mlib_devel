onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider System
add wave -noupdate -format Logic /sim_bench/clk
add wave -noupdate -format Logic /sim_bench/rst
add wave -noupdate -format Logic /sim_bench/ddr_inf_reset
add wave -noupdate -format Literal -radix hexadecimal /sim_bench/ddr_delay_sel
add wave -noupdate -format Logic /sim_bench/ddr_clk90
add wave -noupdate -format Logic /sim_bench/ddr_clk
add wave -noupdate -format Logic /sim_bench/sys_dcmlock_in
add wave -noupdate -format Logic /sim_bench/sys_reset_in
add wave -noupdate -format Logic /sim_bench/sys_clk_in
add wave -noupdate -divider {Mem command interface}
add wave -noupdate -format Literal -radix hexadecimal /sim_bench/async_ddr2_0/Mem_Wr_BE
add wave -noupdate -format Literal -radix hexadecimal /sim_bench/async_ddr2_0/Mem_Wr_Din
add wave -noupdate -format Logic /sim_bench/async_ddr2_0/Mem_Rd_Valid
add wave -noupdate -format Logic /sim_bench/async_ddr2_0/Mem_Rd_Ack
add wave -noupdate -format Literal -radix hexadecimal /sim_bench/async_ddr2_0/Mem_Rd_Tag
add wave -noupdate -format Literal -radix hexadecimal /sim_bench/async_ddr2_0/Mem_Rd_Dout
add wave -noupdate -format Logic /sim_bench/async_ddr2_0/Mem_Cmd_Ack
add wave -noupdate -format Literal -radix hexadecimal /sim_bench/async_ddr2_0/Mem_Cmd_Tag
add wave -noupdate -format Logic /sim_bench/async_ddr2_0/Mem_Cmd_Valid
add wave -noupdate -format Logic /sim_bench/async_ddr2_0/Mem_Cmd_RNW
add wave -noupdate -format Literal -radix hexadecimal /sim_bench/async_ddr2_0/Mem_Cmd_Address
add wave -noupdate -format Logic /sim_bench/async_ddr2_0/Mem_Rst
add wave -noupdate -format Logic /sim_bench/async_ddr2_0/Mem_Clk
add wave -noupdate -divider {DDR controller interface}
add wave -noupdate -format Logic /sim_bench/async_ddr2_0/DDR_reset
add wave -noupdate -format Logic /sim_bench/async_ddr2_0/DDR_ready
add wave -noupdate -format Logic /sim_bench/async_ddr2_0/DDR_half_burst
add wave -noupdate -format Logic /sim_bench/async_ddr2_0/DDR_write
add wave -noupdate -format Logic /sim_bench/async_ddr2_0/DDR_read
add wave -noupdate -format Literal -radix hexadecimal /sim_bench/async_ddr2_0/DDR_address
add wave -noupdate -format Logic /sim_bench/async_ddr2_0/DDR_data_valid
add wave -noupdate -format Literal -radix hexadecimal /sim_bench/async_ddr2_0/DDR_output_data
add wave -noupdate -format Logic /sim_bench/async_ddr2_0/DDR_get_data
add wave -noupdate -format Literal -radix hexadecimal /sim_bench/async_ddr2_0/DDR_byte_enable
add wave -noupdate -format Literal -radix hexadecimal /sim_bench/async_ddr2_0/DDR_input_data
add wave -noupdate -format Logic /sim_bench/async_ddr2_0/DDR_clk
add wave -noupdate -divider {Internal signals}
add wave -noupdate -format Literal -radix hexadecimal /sim_bench/async_ddr2_0/rst_cmd_cnt
add wave -noupdate -format Logic /sim_bench/async_ddr2_0/rd_cmd_cnt
add wave -noupdate -format Logic /sim_bench/async_ddr2_0/wr_cmd_cnt
add wave -noupdate -format Literal -radix hexadecimal /sim_bench/async_ddr2_0/rd_dout
add wave -noupdate -format Logic /sim_bench/async_ddr2_0/rd_data_empty_1
add wave -noupdate -format Logic /sim_bench/async_ddr2_0/rd_data_empty_0
add wave -noupdate -format Logic /sim_bench/async_ddr2_0/rd_data_empty
add wave -noupdate -format Logic /sim_bench/async_ddr2_0/rd_data_full_1
add wave -noupdate -format Logic /sim_bench/async_ddr2_0/rd_data_full_0
add wave -noupdate -format Logic /sim_bench/async_ddr2_0/rd_data_full
add wave -noupdate -format Logic /sim_bench/async_ddr2_0/write_wr_en
add wave -noupdate -format Logic /sim_bench/async_ddr2_0/wr_be_empty
add wave -noupdate -format Logic /sim_bench/async_ddr2_0/wr_data_empty
add wave -noupdate -format Logic /sim_bench/async_ddr2_0/wr_be_full
add wave -noupdate -format Logic /sim_bench/async_ddr2_0/wr_data_full
add wave -noupdate -format Logic /sim_bench/async_ddr2_0/tag_rd_en
add wave -noupdate -format Logic /sim_bench/async_ddr2_0/tag_full
add wave -noupdate -format Logic /sim_bench/async_ddr2_0/tag_empty
add wave -noupdate -format Logic /sim_bench/async_ddr2_0/tag_waiting
add wave -noupdate -format Literal -radix hexadecimal /sim_bench/async_ddr2_0/cmd_out
add wave -noupdate -format Logic /sim_bench/async_ddr2_0/cmd_empty
add wave -noupdate -format Logic /sim_bench/async_ddr2_0/cmd_full
add wave -noupdate -divider Others
add wave -noupdate -format Literal -radix hexadecimal /sim_bench/cmd_count
add wave -noupdate -format Literal -radix hexadecimal /sim_bench/wr_address
add wave -noupdate -format Literal -radix hexadecimal /sim_bench/rd_address
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
configure wave -namecolwidth 211
configure wave -valuecolwidth 124
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
update
WaveRestoreZoom {0 ps} {6448848 ps}
