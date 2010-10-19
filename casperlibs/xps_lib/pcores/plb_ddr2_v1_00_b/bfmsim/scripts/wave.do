onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -noupdate -divider {System Level Ports}
add wave -noupdate -format Logic /bfm_system/sys_clk
add wave -noupdate -format Logic /bfm_system/sys_reset

add wave -noupdate -divider {plb_ddr2 Interface Signals}
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/PLB_Clk
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/PLB_Rst
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/Sl_addrAck
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/Sl_MBusy
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/Sl_MErr
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/Sl_rdBTerm
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/Sl_rdComp
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/Sl_rdDAck
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/Sl_rdDBus
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/Sl_rdWdAddr
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/Sl_rearbitrate
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/Sl_SSize
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/Sl_wait
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/Sl_wrBTerm
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/Sl_wrComp
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/Sl_wrDAck
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/PLB_abort
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/PLB_ABus
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/PLB_BE
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/PLB_busLock
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/PLB_compress
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/PLB_guarded
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/PLB_lockErr
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/PLB_masterID
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/PLB_MSize
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/PLB_ordered
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/PLB_PAValid
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/PLB_pendPri
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/PLB_pendReq
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/PLB_rdBurst
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/PLB_rdPrim
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/PLB_reqPri
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/PLB_RNW
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/PLB_SAValid
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/PLB_size
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/PLB_type
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/PLB_wrBurst
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/PLB_wrDBus
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/PLB_wrPrim

add wave -noupdate -divider {User Logic Interface Signals}
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/PLB_Clk
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/DDR_Clk
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/CMD_rdy
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/CMD_req
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/CMD_done
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/RD_num_cmds
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/WR_cnt
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/WFIFO_full_100
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/RFIFO_empty_100
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/WFIFO_full
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/RFIFO_empty
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/WFIFO_empty
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/RFIFO_full
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/CTRL_cs
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/CTRL_wr_en_dly
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/CTRL_wr_en
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/CTRL_rd_en
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/CTRL_STG_en
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/wr_en
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/rd_en
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/CTRL_P2D_en
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/CTRL_BEAT_en
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/CTRL_done
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/REQ_rd_delay_cnt
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/REQ_rd_delay_done
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/REQ_rst
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/REQ_valid
add wave -noupdate -format Literal -radix binary /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/REQ_size
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/REQ_rnw
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/REQ_rst
add wave -noupdate -format Literal -radix binary /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/REQ_be
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/REQ_addr
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/DFIFO_rd_out
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/DDR_addr
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/DDR_ready_200
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/DDR_ready
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/DDR_wr
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/DDR_rd
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/DDR_rd_en
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/DDR_wr_en
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/DDR_din
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/DDR_dout
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/STG_be
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/STG_dout
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/P2D_dw_cnt
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/P2D_dw_cnt_l
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/BEAT_cnt
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/BEAT_cnt_l
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/TERM_cnt
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/BEAT_done
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/CTRL_start_rd
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/CTRL_start_wr
add wave -noupdate -format Literal -radix symbolic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/CMD_ctrl/CMD_cs
add wave -noupdate -format Literal -radix symbolic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/CMD_ctrl/ALLOC_cnt
add wave -noupdate -format Literal -radix symbolic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/CMD_ctrl/COMP_cnt
add wave -noupdate -format Literal -radix symbolic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/CMD_ctrl/RST_cnt
add wave -noupdate -format Literal -radix symbolic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/CMD_ctrl/RST_high_done
add wave -noupdate -format Literal -radix symbolic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/CMD_ctrl/RST_low_done
add wave -noupdate -format Literal -radix symbolic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/CMD_ctrl/start_num
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/CMD_ctrl/DDR_resp_cnt
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/CMD_ctrl/DDR_resp
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/CMD_ctrl/DDR_resp_100
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/CMD_ctrl/CMD_done
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/CMD_ctrl/DDR_rdy
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/CMD_ctrl/done
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/PLB_controller/PLB_Cycle_First_Half

add wave -noupdate -divider {DDR2 Controller}

add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_ddr2/plb_ddr2/uut/DDR_addr

add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_ddr2/plb_ddr2/uut/DDR_dout

add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_ddr2/plb_ddr2/uut/DDR_din

add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_ddr2/plb_ddr2/uut/DDR_be

add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_ddr2/plb_ddr2/uut/DDR_address

add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_ddr2/plb_ddr2/uut/DDR_input_data

add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_ddr2/plb_ddr2/uut/DDR_byte_enable

add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_ddr2/plb_ddr2/uut/DDR_output_data
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/DDR_data_valid
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/DDR_get_data
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/DDR_read
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/DDR_write
add wave -noupdate -format Logic /bfm_system/plb_ddr2/plb_ddr2/uut/DDR_ready

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {200 ns}
WaveRestoreZoom {0 ns} {2 us}
configure wave -namecolwidth 200
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
