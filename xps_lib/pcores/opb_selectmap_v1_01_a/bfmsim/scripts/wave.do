onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {System Level Ports}
add wave -noupdate -format Logic /bfm_system/sys_clk
add wave -noupdate -format Logic /bfm_system/sys_reset
add wave -noupdate -divider {OPB Bus Master Signals}
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/opb_bus_M_ABus
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/opb_bus_M_BE
add wave -noupdate -format Logic /bfm_system/opb_bus_M_busLock
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/opb_bus_M_DBus
add wave -noupdate -format Logic /bfm_system/opb_bus_M_request
add wave -noupdate -format Logic /bfm_system/opb_bus_M_RNW
add wave -noupdate -format Logic /bfm_system/opb_bus_M_select
add wave -noupdate -format Logic /bfm_system/opb_bus_M_seqAddr
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/opb_bus_OPB_DBus
add wave -noupdate -format Logic /bfm_system/opb_bus_OPB_errAck
add wave -noupdate -format Logic /bfm_system/opb_bus_OPB_MGrant
add wave -noupdate -format Logic /bfm_system/opb_bus_OPB_retry
add wave -noupdate -format Logic /bfm_system/opb_bus_OPB_timeout
add wave -noupdate -format Logic /bfm_system/opb_bus_OPB_xferAck
add wave -noupdate -divider {OPB Bus Slave Signals}
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/opb_bus_Sl_DBus
add wave -noupdate -format Logic /bfm_system/opb_bus_Sl_errAck
add wave -noupdate -format Logic /bfm_system/opb_bus_Sl_retry
add wave -noupdate -format Logic /bfm_system/opb_bus_Sl_toutSup
add wave -noupdate -format Logic /bfm_system/opb_bus_Sl_xferAck
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/opb_bus_OPB_ABus
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/opb_bus_OPB_BE
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/opb_bus_OPB_DBus
add wave -noupdate -format Logic /bfm_system/opb_bus_OPB_RNW
add wave -noupdate -format Logic /bfm_system/opb_bus_OPB_select
add wave -noupdate -format Logic /bfm_system/opb_bus_OPB_seqAddr
add wave -noupdate -divider {BFM Synch Bus Signals}
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/synch_bus/synch_bus/FROM_SYNCH_OUT
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/synch_bus/synch_bus/TO_SYNCH_IN
add wave -noupdate -divider {opb_selectmap Interface Signals}
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/OPB_Clk
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/OPB_Rst
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/Sl_DBus
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/Sl_errAck
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/Sl_retry
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/Sl_toutSup
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/Sl_xferAck
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/OPB_ABus
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/OPB_BE
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/OPB_DBus
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/OPB_RNW
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/OPB_select
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/OPB_seqAddr
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/IP2INTC_Irpt
add wave -noupdate -divider {User Logic Interface Signals}
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/Bus2IP_Clk
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/Bus2IP_Reset
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/IP2Bus_IntrEvent
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/Bus2IP_Data
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/Bus2IP_BE
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/Bus2IP_RdCE
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/Bus2IP_WrCE
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/IP2Bus_Data
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/IP2Bus_Ack
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/IP2Bus_Retry
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/IP2Bus_Error
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/IP2Bus_ToutSup

add wave -noupdate -divider {User Logic Internal Slave Space Signals}
add wave -noupdate -divider {SelectMAP Interface Signals}
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/D_I
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/D_O
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/D_T
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/RDWR_B
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/CS_B
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/PROG_B
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/INIT_B
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/DONE
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/CCLK

add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/CCLK_reg
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/D_I_reg
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/D_O_reg
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/D_T_reg
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/RDWR_B_reg
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/CS_B_reg
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/PROG_B_reg
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/INIT_B_reg
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/DONE_reg

add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/RDWR_B_int
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/CS_B_int

add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/CTRL_intr
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/CTRL_mode
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/CTRL_RdCnt
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/CTRL_WrCnt
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/CTRL_rd_cntr
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/CTRL_WrStart
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/CTRL_RdCE_dly
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/CTRL_RdStart
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/CTRL_RdEnd
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/CTRL_BusData
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/CTRL_RdCE
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/CTRL_WrCE
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/CTRL_Ack

add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/DATA_wr_cntr
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/DATA_rd_cntr
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/DATA_WrCE_dly
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/DATA_WrStart
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/DATA_RdCE_dly
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/DATA_RdStart
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/DATA_BusData
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/DATA_RdCE
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/DATA_WrCE
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/FPGA1_selectmap/DATA_Ack

add wave -noupdate -divider {Loopback Test Signals}
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/FPGA1_LoopData
add wave -noupdate -format Logic /bfm_system/my_core/my_core/FPGA1_LoopFull
add wave -noupdate -format Logic /bfm_system/my_core/my_core/FPGA1_LoopEmpty
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/FPGA1_WrFifo_WrCnt
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/FPGA1_RdFifo_RdCnt
add wave -noupdate -format Logic /bfm_system/my_core/my_core/FPGA1_WrEn
add wave -noupdate -format Logic /bfm_system/my_core/my_core/FPGA1_RdEn

add wave -noupdate -divider {User Fifo}
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/SMF1/WrFifo_Dout
add wave -noupdate -format Logic /bfm_system/my_core/my_core/SMF1/WrFifo_Empty
add wave -noupdate -format Logic /bfm_system/my_core/my_core/SMF1/WrFifo_RdEn
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/SMF1/WrFifo_RdCnt
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/SMF1/WrFifo_Din
add wave -noupdate -format Logic /bfm_system/my_core/my_core/SMF1/WrFifo_Full
add wave -noupdate -format Logic /bfm_system/my_core/my_core/SMF1/WrFifo_WrEn
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/SMF1/WrFifo_WrCnt

add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/SMF1/RdFifo_Din
add wave -noupdate -format Logic /bfm_system/my_core/my_core/SMF1/RdFifo_Full
add wave -noupdate -format Logic /bfm_system/my_core/my_core/SMF1/RdFifo_WrEn
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/SMF1/RdFifo_WrCnt
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/SMF1/RdFifo_Dout
add wave -noupdate -format Logic /bfm_system/my_core/my_core/SMF1/RdFifo_Empty
add wave -noupdate -format Logic /bfm_system/my_core/my_core/SMF1/RdFifo_RdEn
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/SMF1/RdFifo_RdCnt

add wave -noupdate -format Logic /bfm_system/my_core/my_core/SMF1/CCLK
add wave -noupdate -format Logic /bfm_system/my_core/my_core/SMF1/SYNC_done

add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/SMF1/D_I_reg
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/SMF1/D_O_reg
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/SMF1/D_T
add wave -noupdate -format Logic /bfm_system/my_core/my_core/SMF1/RDWR_B_reg
add wave -noupdate -format Logic /bfm_system/my_core/my_core/SMF1/CS_B_reg
add wave -noupdate -format Logic /bfm_system/my_core/my_core/SMF1/INIT_B_reg

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
