onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Framebuffer
add wave -noupdate -format Literal /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/dvi_data
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/dvi_idck_p
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/dvi_idck_m
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/dvi_vsync
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/dvi_hsync
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/dvi_de
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/pixel_clk
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/pixel_clk90
add wave -noupdate -format Literal /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/mem_cmd_address
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/mem_cmd_rnw
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/mem_cmd_valid
add wave -noupdate -format Literal /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/mem_cmd_tag
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/mem_cmd_ack
add wave -noupdate -format Literal /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/mem_rd_dout
add wave -noupdate -format Literal /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/mem_rd_tag
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/mem_rd_ack
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/mem_rd_valid
add wave -noupdate -format Literal /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/mem_wr_din
add wave -noupdate -format Literal /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/mem_wr_be
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/opb_clk
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/opb_rst
add wave -noupdate -format Literal /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/sl_dbus
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/sl_errack
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/sl_retry
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/sl_toutsup
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/sl_xferack
add wave -noupdate -format Literal /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/opb_abus
add wave -noupdate -format Literal /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/opb_be
add wave -noupdate -format Literal /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/opb_dbus
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/opb_rnw
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/opb_select
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/opb_seqaddr
add wave -noupdate -format Literal /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/ibus2ip_rdce
add wave -noupdate -format Literal /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/ibus2ip_wrce
add wave -noupdate -format Literal /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/ibus2ip_data
add wave -noupdate -format Literal /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/ibus2ip_be
add wave -noupdate -format Literal /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/iip2bus_data
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/iip2bus_ack
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/iip2bus_error
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/iip2bus_retry
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/iip2bus_toutsup
add wave -noupdate -format Literal /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/zero_ip2bus_postedwrinh
add wave -noupdate -format Literal /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/zero_ip2rfifo_data
add wave -noupdate -format Literal /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/zero_wfifo2ip_data
add wave -noupdate -format Literal /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/zero_ip2bus_intrevent
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/ibus2ip_clk
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/ibus2ip_reset
add wave -noupdate -format Literal /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/ubus2ip_data
add wave -noupdate -format Literal /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/ubus2ip_be
add wave -noupdate -format Literal /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/ubus2ip_rdce
add wave -noupdate -format Literal /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/ubus2ip_wrce
add wave -noupdate -format Literal /bfm_system/my_core/my_core/gen_fb_shared/opb_framebuffer_0/uip2bus_data
add wave -noupdate -divider Arbiter
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/arbiter_0/Clk
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/arbiter_0/Rst
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/arbiter_0/En
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/arbiter_0/Full
add wave -noupdate -format Literal /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/arbiter_0/Req
add wave -noupdate -format Literal /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/arbiter_0/Ack
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/arbiter_0/Select
add wave -noupdate -format Literal /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/arbiter_0/ack_int
add wave -noupdate -format Literal /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/arbiter_0/last_ack
add wave -noupdate -format Literal /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/arbiter_0/pass_ack_L0
add wave -noupdate -format Literal /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/arbiter_0/pass_ack_L1
add wave -noupdate -format Literal /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/arbiter_0/i
add wave -noupdate -format Literal /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/arbiter_0/window_cnt
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/arbiter_0/window_cnt_down
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/arbiter_0/window_cnt_rst
add wave -noupdate -divider {Rd Select FIFO}
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/fifo_sync_0/clk
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/fifo_sync_0/rst
add wave -noupdate -format Logic -radix hexadecimal /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/fifo_sync_0/din
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/fifo_sync_0/wr_en
add wave -noupdate -format Logic -radix hexadecimal /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/fifo_sync_0/dout
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/fifo_sync_0/rd_en
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/fifo_sync_0/empty
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/fifo_sync_0/full
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/fifo_sync_0/full_state
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/fifo_sync_0/head
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/fifo_sync_0/tail
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/fifo_sync_0/push
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/fifo_sync_0/pop
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/fifo_sync_0/full_test
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/fifo_sync_0/empty_test
add wave -noupdate -divider Multiport
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/Clk
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/Rst
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/In0_Cmd_Address
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/In0_Cmd_RNW
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/In0_Cmd_Valid
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/In0_Cmd_Tag
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/In0_Cmd_Ack
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/In0_Rd_Dout
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/In0_Rd_Tag
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/In0_Rd_Ack
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/In0_Rd_Valid
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/In0_Wr_Din
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/In0_Wr_BE
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/In1_Cmd_Address
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/In1_Cmd_RNW
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/In1_Cmd_Valid
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/In1_Cmd_Tag
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/In1_Cmd_Ack
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/In1_Rd_Dout
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/In1_Rd_Tag
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/In1_Rd_Ack
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/In1_Rd_Valid
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/In1_Wr_Din
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/In1_Wr_BE
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/Out_Cmd_Address
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/Out_Cmd_RNW
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/Out_Cmd_Valid
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/Out_Cmd_Tag
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/Out_Cmd_Ack
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/Out_Rd_Dout
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/Out_Rd_Tag
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/Out_Rd_Ack
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/Out_Rd_Valid
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/Out_Wr_Din
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/Out_Wr_BE
add wave -noupdate -format Logic -radix hexadecimal /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/arb_select
add wave -noupdate -format Logic -radix hexadecimal /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/arb_rd_select
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/arb_req
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/arb_ack
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/mux_address
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/mux_tag
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/mux_rnw
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/mux_din
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_multiport_shared/multiport_ddr2_0/mux_be
add wave -noupdate -divider {User logic}
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/pending
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/wr_req
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/wr_req_dly
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/bus_fifo_full
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/bus_fifo_empty
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/bus_fifo_dout
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/bus_fifo_din
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/next_rd_addr
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/rd_cmd_inc_dly
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/rd_cmd_inc
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/rd_cmd_issue_dly
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/rd_cmd_issue
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/fifo_rd_en
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/fifo_wr_en_dly
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/fifo_wr_en
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/dword_rd_en
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/dword_wr_en
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/dword_reg_en
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/xfer_size
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/rd_addr
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/byte_addr
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/dword_addr
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/wr_be_in
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/wr_data_in
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/rd_data_out
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/IP2Bus_WrAck
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/IP2Bus_RdAck
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/IP2Bus_Busy
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/IP2Bus_AddrAck
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/IP2Bus_ToutSup
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/IP2Bus_Error
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/IP2Bus_Retry
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/IP2Bus_Data
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/Bus2IP_WrReq
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/Bus2IP_RdReq
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/Bus2IP_WrCE
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/Bus2IP_RdCE
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/Bus2IP_RNW
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/Bus2IP_Burst
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/Bus2IP_BE
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/Bus2IP_Data
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/Bus2IP_Addr
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/Bus2IP_Reset
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/Bus2IP_Clk
add wave -noupdate -divider {Async DDR2}
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/Mem_Clk
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/Mem_Rst
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/Mem_Cmd_Address
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/Mem_Cmd_RNW
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/Mem_Cmd_Valid
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/Mem_Cmd_Tag
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/Mem_Cmd_Ack
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/Mem_Rd_Dout
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/Mem_Rd_Tag
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/Mem_Rd_Ack
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/Mem_Rd_Valid
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/Mem_Wr_Din
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/Mem_Wr_BE
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/DDR_clk
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/DDR_input_data
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/DDR_byte_enable
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/DDR_get_data
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/DDR_output_data
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/DDR_data_valid
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/DDR_address
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/DDR_read
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/DDR_write
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/DDR_half_burst
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/DDR_ready
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/DDR_reset
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/mem_cmd_full
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/cmd_full
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/cmd_empty
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/cmd_out
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/tag_waiting
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/tag_empty
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/tag_full
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/tag_rd_en
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/wr_data_full
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/wr_be_full
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/wr_data_empty
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/wr_be_empty
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/write_wr_en
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/rd_data_full
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/rd_data_full_0
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/rd_data_full_1
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/rd_data_empty
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/rd_data_empty_0
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/rd_data_empty_1
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/rd_dout
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/wr_cmd_cnt
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/rd_cmd_cnt
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_async_no_shared/async_ddr2_0/rst_cmd_cnt

add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/Mem_Clk
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/Mem_Rst
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/Mem_Cmd_Address
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/Mem_Cmd_RNW
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/Mem_Cmd_Valid
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/Mem_Cmd_Tag
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/Mem_Cmd_Ack
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/Mem_Rd_Dout
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/Mem_Rd_Tag
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/Mem_Rd_Ack
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/Mem_Rd_Valid
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/Mem_Wr_Din
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/Mem_Wr_BE
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/DDR_clk
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/DDR_input_data
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/DDR_byte_enable
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/DDR_get_data
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/DDR_output_data
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/DDR_data_valid
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/DDR_address
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/DDR_read
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/DDR_write
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/DDR_half_burst
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/DDR_ready
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/DDR_reset
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/mem_cmd_full
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/cmd_full
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/cmd_empty
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/cmd_out
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/tag_waiting
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/tag_empty
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/tag_full
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/tag_rd_en
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/wr_data_full
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/wr_be_full
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/wr_data_empty
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/wr_be_empty
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/write_wr_en
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/rd_data_full
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/rd_data_full_0
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/rd_data_full_1
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/rd_data_empty
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/rd_data_empty_0
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/rd_data_empty_1
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/rd_dout
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/wr_cmd_cnt
add wave -noupdate -format Logic /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/rd_cmd_cnt
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/gen_async_shared/async_ddr2_0/rst_cmd_cnt
add wave -noupdate -divider {DDR2 Controller}
add wave -noupdate -format Logic /bfm_system/my_core/my_core/ddr2_controller_0/user_reset
add wave -noupdate -format Logic /bfm_system/my_core/my_core/ddr2_controller_0/user_ready
add wave -noupdate -format Logic /bfm_system/my_core/my_core/ddr2_controller_0/user_half_burst
add wave -noupdate -format Logic /bfm_system/my_core/my_core/ddr2_controller_0/user_write
add wave -noupdate -format Logic /bfm_system/my_core/my_core/ddr2_controller_0/user_read
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/ddr2_controller_0/user_address
add wave -noupdate -format Logic /bfm_system/my_core/my_core/ddr2_controller_0/user_data_valid
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/ddr2_controller_0/user_output_data
add wave -noupdate -format Logic /bfm_system/my_core/my_core/ddr2_controller_0/user_get_data
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/ddr2_controller_0/user_byte_enable
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/ddr2_controller_0/user_input_data
add wave -noupdate -divider {DDR2 Infrastructure}
add wave -noupdate -format Logic /bfm_system/my_core/my_core/ddr2_infrastructure_0/dcm_lock
add wave -noupdate -format Logic /bfm_system/my_core/my_core/ddr2_infrastructure_0/ddr_clk90_int
add wave -noupdate -format Logic /bfm_system/my_core/my_core/ddr2_infrastructure_0/ddr_clk_int
add wave -noupdate -format Logic /bfm_system/my_core/my_core/ddr2_infrastructure_0/ddr_clk90
add wave -noupdate -format Logic /bfm_system/my_core/my_core/ddr2_infrastructure_0/ddr_clk
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/ddr2_infrastructure_0/ddr_delay_sel
add wave -noupdate -format Logic /bfm_system/my_core/my_core/ddr2_infrastructure_0/ddr_inf_reset
add wave -noupdate -format Logic /bfm_system/my_core/my_core/ddr2_infrastructure_0/dcmlock_in
add wave -noupdate -format Logic /bfm_system/my_core/my_core/ddr2_infrastructure_0/clk_in
add wave -noupdate -format Logic /bfm_system/my_core/my_core/ddr2_infrastructure_0/reset_in
add wave -noupdate -divider {System Level Ports}
add wave -noupdate -format Logic /bfm_system/sys_clk
add wave -noupdate -format Logic /bfm_system/sys_reset
add wave -noupdate -divider {PLB Bus Master Signals}
add wave -noupdate -format Literal /bfm_system/plb_bus_m_abort
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_bus_m_abus
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_bus_m_be
add wave -noupdate -format Literal /bfm_system/plb_bus_m_buslock
add wave -noupdate -format Literal /bfm_system/plb_bus_m_compress
add wave -noupdate -format Literal /bfm_system/plb_bus_m_guarded
add wave -noupdate -format Literal /bfm_system/plb_bus_m_lockerr
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_bus_m_msize
add wave -noupdate -format Literal /bfm_system/plb_bus_m_ordered
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_bus_m_priority
add wave -noupdate -format Literal /bfm_system/plb_bus_m_rdburst
add wave -noupdate -format Literal /bfm_system/plb_bus_m_request
add wave -noupdate -format Literal /bfm_system/plb_bus_m_rnw
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_bus_m_size
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_bus_m_type
add wave -noupdate -format Literal /bfm_system/plb_bus_m_wrburst
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_bus_m_wrdbus
add wave -noupdate -format Literal /bfm_system/plb_bus_plb_mbusy
add wave -noupdate -format Literal /bfm_system/plb_bus_plb_merr
add wave -noupdate -format Literal /bfm_system/plb_bus_plb_mwrbterm
add wave -noupdate -format Literal /bfm_system/plb_bus_plb_mwrdack
add wave -noupdate -format Literal /bfm_system/plb_bus_plb_maddrack
add wave -noupdate -format Literal /bfm_system/plb_bus_plb_mrdbterm
add wave -noupdate -format Literal /bfm_system/plb_bus_plb_mrddack
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_bus_plb_mrddbus
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_bus_plb_mrdwdaddr
add wave -noupdate -format Literal /bfm_system/plb_bus_plb_mrearbitrate
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_bus_plb_mssize
add wave -noupdate -divider {PLB Bus Slave Signals}
add wave -noupdate -format Literal /bfm_system/plb_bus_sl_addrack
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_bus_sl_mbusy
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_bus_sl_merr
add wave -noupdate -format Literal /bfm_system/plb_bus_sl_rdbterm
add wave -noupdate -format Literal /bfm_system/plb_bus_sl_rdcomp
add wave -noupdate -format Literal /bfm_system/plb_bus_sl_rddack
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_bus_sl_rddbus
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_bus_sl_rdwdaddr
add wave -noupdate -format Literal /bfm_system/plb_bus_sl_rearbitrate
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_bus_sl_ssize
add wave -noupdate -format Literal /bfm_system/plb_bus_sl_wait
add wave -noupdate -format Literal /bfm_system/plb_bus_sl_wrbterm
add wave -noupdate -format Literal /bfm_system/plb_bus_sl_wrcomp
add wave -noupdate -format Literal /bfm_system/plb_bus_sl_wrdack
add wave -noupdate -format Logic /bfm_system/plb_bus_plb_abort
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_bus_plb_abus
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_bus_plb_be
add wave -noupdate -format Logic /bfm_system/plb_bus_plb_buslock
add wave -noupdate -format Logic /bfm_system/plb_bus_plb_compress
add wave -noupdate -format Logic /bfm_system/plb_bus_plb_guarded
add wave -noupdate -format Logic /bfm_system/plb_bus_plb_lockerr
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_bus_plb_masterid
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_bus_plb_msize
add wave -noupdate -format Logic /bfm_system/plb_bus_plb_ordered
add wave -noupdate -format Logic /bfm_system/plb_bus_plb_pavalid
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_bus_plb_pendpri
add wave -noupdate -format Logic /bfm_system/plb_bus_plb_pendreq
add wave -noupdate -format Logic /bfm_system/plb_bus_plb_rdburst
add wave -noupdate -format Logic /bfm_system/plb_bus_plb_rdprim
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_bus_plb_reqpri
add wave -noupdate -format Logic /bfm_system/plb_bus_plb_rnw
add wave -noupdate -format Logic /bfm_system/plb_bus_plb_savalid
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_bus_plb_size
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_bus_plb_type
add wave -noupdate -format Logic /bfm_system/plb_bus_plb_wrburst
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/plb_bus_plb_wrdbus
add wave -noupdate -format Logic /bfm_system/plb_bus_plb_wrprim
add wave -noupdate -divider {BFM Synch Bus Signals}
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/synch_bus/synch_bus/from_synch_out
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/synch_bus/synch_bus/to_synch_in
add wave -noupdate -divider {plb_ddr2 Interface Signals}
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/plb_clk
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/plb_rst
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/sl_addrack
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/sl_mbusy
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/sl_merr
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/sl_rdbterm
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/sl_rdcomp
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/sl_rddack
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/sl_rddbus
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/sl_rdwdaddr
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/sl_rearbitrate
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/sl_ssize
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/sl_wait
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/sl_wrbterm
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/sl_wrcomp
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/sl_wrdack
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/plb_abort
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/plb_abus
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/plb_be
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/plb_buslock
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/plb_compress
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/plb_guarded
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/plb_lockerr
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/plb_masterid
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/plb_msize
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/plb_ordered
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/plb_pavalid
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/plb_pendpri
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/plb_pendreq
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/plb_rdburst
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/plb_rdprim
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/plb_reqpri
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/plb_rnw
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/plb_savalid
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/plb_size
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/plb_type
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/plb_wrburst
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/plb_wrdbus
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/plb_wrprim
add wave -noupdate -divider {User Logic Interface Signals}
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/Bus2IP_Clk
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/Bus2IP_Reset
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/Bus2IP_RNW
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/Bus2IP_Addr
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/Bus2IP_Data
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/Bus2IP_BE
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/Bus2IP_Burst
add wave -noupdate -format Literal /bfm_system/my_core/my_core/uut/user_logic_i/Bus2IP_RdCE
add wave -noupdate -format Literal /bfm_system/my_core/my_core/uut/user_logic_i/Bus2IP_WrCE
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/Bus2IP_RdReq
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/Bus2IP_WrReq
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/IP2Bus_Data
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/IP2Bus_Retry
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/IP2Bus_Error
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/IP2Bus_ToutSup
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/IP2Bus_AddrAck
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/IP2Bus_Busy
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/IP2Bus_RdAck
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/IP2Bus_WrAck
add wave -noupdate -divider {DDR2 Interface signals}
add wave -noupdate -format Logic /bfm_system/my_core/my_core/ddr_clk
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/ddr_input_data
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/ddr_byte_enable
add wave -noupdate -format Logic /bfm_system/my_core/my_core/ddr_get_data
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/ddr_output_data
add wave -noupdate -format Logic /bfm_system/my_core/my_core/ddr_data_valid
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/ddr_address
add wave -noupdate -format Logic /bfm_system/my_core/my_core/ddr_read
add wave -noupdate -format Logic /bfm_system/my_core/my_core/ddr_write
add wave -noupdate -format Logic /bfm_system/my_core/my_core/ddr_ready
add wave -noupdate -divider {PLB DDR2 signals}
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/rd_data_out
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/wr_data_in
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/wr_be_in
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/rd_addr
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/xfer_size
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/dword_addr
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/byte_addr
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/user_logic_i/dword_reg_en
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/dword_wr_en
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/dword_rd_en
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/fifo_wr_en
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/fifo_wr_en_dly
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/fifo_rd_en
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/rd_cmd_issue
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/rd_cmd_inc
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/user_logic_i/rd_cmd_inc_dly
add wave -noupdate -divider STUFF
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/plb_ipif_i/bus2ip_wrce_i
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/plb_ipif_i/bus2ip_rdce_i
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/bus2ip_wrce_i
add wave -noupdate -format Literal -radix hexadecimal /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/bus2ip_rdce_i
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/i_decoder/bus_clk
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/i_decoder/bus_rst
add wave -noupdate -format Literal /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/i_decoder/address_in
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/i_decoder/address_valid
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/i_decoder/bus_rnw
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/i_decoder/cs_sample_hold_n
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/i_decoder/cs_sample_hold_clr
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/i_decoder/cs_ce_ld_enable
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/i_decoder/clear_cs_ce_reg
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/i_decoder/rw_ce_ld_enable
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/i_decoder/clear_rw_ce_reg
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/i_decoder/clear_addr_match
add wave -noupdate -format Literal /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/i_decoder/pselect_hit
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/i_decoder/addr_match_early
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/i_decoder/addr_match
add wave -noupdate -format Literal /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/i_decoder/cs_out
add wave -noupdate -format Literal /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/i_decoder/cs_out_early
add wave -noupdate -format Literal /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/i_decoder/cs_size
add wave -noupdate -format Literal /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/i_decoder/ce_out
add wave -noupdate -format Literal /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/i_decoder/rdce_out
add wave -noupdate -format Literal /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/i_decoder/wrce_out
add wave -noupdate -format Literal /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/i_decoder/pselect_hit_i
add wave -noupdate -format Literal /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/i_decoder/cs_out_i
add wave -noupdate -format Literal /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/i_decoder/cs_out_s_h
add wave -noupdate -format Literal /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/i_decoder/ce_expnd_i
add wave -noupdate -format Literal /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/i_decoder/ce_out_i
add wave -noupdate -format Literal /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/i_decoder/rdce_out_i
add wave -noupdate -format Literal /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/i_decoder/wrce_out_i
add wave -noupdate -format Literal /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/i_decoder/cs_size_i
add wave -noupdate -format Literal /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/i_decoder/cs_size_i_reg
add wave -noupdate -format Literal /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/i_decoder/cs_size_array
add wave -noupdate -format Literal /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/i_decoder/size_or_bus
add wave -noupdate -format Literal /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/i_decoder/decode_hit
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/i_decoder/decode_hit_reg
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/i_decoder/cs_s_h_clr
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/i_decoder/cs_ce_clr
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/i_decoder/rdce_clr
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/i_decoder/wrce_clr
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/i_decoder/addr_match_clr
add wave -noupdate -format Logic /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/i_decoder/rnw_s_h
add wave -noupdate -format Literal /bfm_system/my_core/my_core/uut/plb_ipif_i/i_slave_attachment/i_decoder/addr_out_s_h
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {364162 ps} 0}
configure wave -namecolwidth 200
configure wave -valuecolwidth 88
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
update
WaveRestoreZoom {1710775 ps} {4207378 ps}
