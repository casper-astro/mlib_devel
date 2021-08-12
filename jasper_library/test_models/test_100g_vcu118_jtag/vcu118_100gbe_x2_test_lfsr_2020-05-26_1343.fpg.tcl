create_hw_axi_txn cntrl_rd [get_hw_axis hw_axi_1] -type READ -address 10000000 -len 1 -force
run_hw_axi [get_hw_axi_txns cntrl_rd]
create_hw_axi_txn cntrl_wr [get_hw_axis hw_axi_1] -type WRITE -address 10000000 -len 1 -data 00000003 -force
create_hw_axi_txn cycle_len_rd [get_hw_axis hw_axi_1] -type READ -address 10000004 -len 1 -force
run_hw_axi [get_hw_axi_txns cycle_len_rd]
create_hw_axi_txn cycle_len_wr [get_hw_axis hw_axi_1] -type WRITE -address 10000004 -len 1 -data 00000013 -force
run_hw_axi [get_hw_axi_txns cycle_len_wr]
create_hw_axi_txn duty_cycle_rd [get_hw_axis hw_axi_1] -type READ -address 10000008 -len 1 -force
run_hw_axi [get_hw_axi_txns duty_cycle_rd]
create_hw_axi_txn duty_cycle_wr [get_hw_axis hw_axi_1] -type WRITE -address 10000008 -len 1 -data 00000005 -force
run_hw_axi [get_hw_axi_txns duty_cycle_wr]
create_hw_axi_txn gbe0_rx_err_cnt_reg_rd [get_hw_axis hw_axi_1] -type READ -address 1000000c -len 1 -force
run_hw_axi [get_hw_axi_txns gbe0_rx_err_cnt_reg_rd]
create_hw_axi_txn gbe0_rx_err_cnt_reg_wr [get_hw_axis hw_axi_1] -type WRITE -address 1000000c -len 1 -data 00000000 -force
create_hw_axi_txn gbe0_rx_pkt_cnt_reg_rd [get_hw_axis hw_axi_1] -type READ -address 10000010 -len 1 -force
run_hw_axi [get_hw_axi_txns gbe0_rx_pkt_cnt_reg_rd]
create_hw_axi_txn gbe0_rx_pkt_cnt_reg_wr [get_hw_axis hw_axi_1] -type WRITE -address 10000010 -len 1 -data 00000000 -force
create_hw_axi_txn gbe0_rx_pkt_cnt_reg1_rd [get_hw_axis hw_axi_1] -type READ -address 10000014 -len 1 -force
run_hw_axi [get_hw_axi_txns gbe0_rx_pkt_cnt_reg1_rd]
create_hw_axi_txn gbe0_rx_pkt_cnt_reg1_wr [get_hw_axis hw_axi_1] -type WRITE -address 10000014 -len 1 -data 00000000 -force
create_hw_axi_txn gbe1_rx_err_cnt_reg_rd [get_hw_axis hw_axi_1] -type READ -address 10000018 -len 1 -force
run_hw_axi [get_hw_axi_txns gbe1_rx_err_cnt_reg_rd]
create_hw_axi_txn gbe1_rx_err_cnt_reg_wr [get_hw_axis hw_axi_1] -type WRITE -address 10000018 -len 1 -data 00000000 -force
create_hw_axi_txn gbe1_rx_pkt_cnt_reg_rd [get_hw_axis hw_axi_1] -type READ -address 1000001c -len 1 -force
run_hw_axi [get_hw_axi_txns gbe1_rx_pkt_cnt_reg_rd]
create_hw_axi_txn gbe1_rx_pkt_cnt_reg_wr [get_hw_axis hw_axi_1] -type WRITE -address 1000001c -len 1 -data 00000000 -force
create_hw_axi_txn gbe1_rx_pkt_cnt_reg1_rd [get_hw_axis hw_axi_1] -type READ -address 10000020 -len 1 -force
run_hw_axi [get_hw_axi_txns gbe1_rx_pkt_cnt_reg1_rd]
create_hw_axi_txn gbe1_rx_pkt_cnt_reg1_wr [get_hw_axis hw_axi_1] -type WRITE -address 10000020 -len 1 -data 00000000 -force
create_hw_axi_txn sw_reg_in_rd [get_hw_axis hw_axi_1] -type READ -address 10000024 -len 1 -force
run_hw_axi [get_hw_axi_txns sw_reg_in_rd]
create_hw_axi_txn sw_reg_in_wr [get_hw_axis hw_axi_1] -type WRITE -address 10000024 -len 1 -data 00000000 -force
create_hw_axi_txn sw_reg_out_rd [get_hw_axis hw_axi_1] -type READ -address 10000028 -len 1 -force
run_hw_axi [get_hw_axi_txns sw_reg_out_rd]
create_hw_axi_txn sw_reg_out_wr [get_hw_axis hw_axi_1] -type WRITE -address 10000028 -len 1 -data 00000000 -force
create_hw_axi_txn sw_reg_out1_rd [get_hw_axis hw_axi_1] -type READ -address 1000002c -len 1 -force
run_hw_axi [get_hw_axi_txns sw_reg_out1_rd]
create_hw_axi_txn sw_reg_out1_wr [get_hw_axis hw_axi_1] -type WRITE -address 1000002c -len 1 -data 00000000 -force
create_hw_axi_txn tx_pkt_cnt_reg_rd [get_hw_axis hw_axi_1] -type READ -address 10000030 -len 1 -force
run_hw_axi [get_hw_axi_txns tx_pkt_cnt_reg_rd]
create_hw_axi_txn tx_pkt_cnt_reg_wr [get_hw_axis hw_axi_1] -type WRITE -address 10000030 -len 1 -data 00000000 -force
create_hw_axi_txn tx_pkt_cnt_reg1_rd [get_hw_axis hw_axi_1] -type READ -address 10000034 -len 1 -force
run_hw_axi [get_hw_axi_txns tx_pkt_cnt_reg1_rd]
create_hw_axi_txn tx_pkt_cnt_reg1_wr [get_hw_axis hw_axi_1] -type WRITE -address 10000034 -len 1 -data 00000000 -force
create_hw_axi_txn sys_block_rd [get_hw_axis hw_axi_1] -type READ -address 10000040 -len 1 -force
run_hw_axi [get_hw_axi_txns sys_block_rd]
create_hw_axi_txn sys_block_wr [get_hw_axis hw_axi_1] -type WRITE -address 10000040 -len 1 -data 00000000 -force
create_hw_axi_txn sys_board_id_rd [get_hw_axis hw_axi_1] -type READ -address 10000040 -len 1 -force
run_hw_axi [get_hw_axi_txns sys_board_id_rd]
create_hw_axi_txn sys_board_id_wr [get_hw_axis hw_axi_1] -type WRITE -address 10000040 -len 1 -data 00000000 -force
create_hw_axi_txn sys_rev_rd [get_hw_axis hw_axi_1] -type READ -address 10000044 -len 1 -force
run_hw_axi [get_hw_axi_txns sys_rev_rd]
create_hw_axi_txn sys_rev_wr [get_hw_axis hw_axi_1] -type WRITE -address 10000044 -len 1 -data 00000000 -force
create_hw_axi_txn sys_rev_rcs_rd [get_hw_axis hw_axi_1] -type READ -address 1000004c -len 1 -force
run_hw_axi [get_hw_axi_txns sys_rev_rcs_rd]
create_hw_axi_txn sys_rev_rcs_wr [get_hw_axis hw_axi_1] -type WRITE -address 1000004c -len 1 -data 00000000 -force
create_hw_axi_txn sys_scratchpad_rd [get_hw_axis hw_axi_1] -type READ -address 10000050 -len 1 -force
run_hw_axi [get_hw_axi_txns sys_scratchpad_rd]
create_hw_axi_txn sys_scratchpad_wr [get_hw_axis hw_axi_1] -type WRITE -address 10000050 -len 1 -data 00000000 -force
create_hw_axi_txn sys_clkcounter_rd [get_hw_axis hw_axi_1] -type READ -address 10000054 -len 1 -force
run_hw_axi [get_hw_axi_txns sys_clkcounter_rd]
create_hw_axi_txn sys_clkcounter_wr [get_hw_axis hw_axi_1] -type WRITE -address 10000054 -len 1 -data 00000000 -force
