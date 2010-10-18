vmap unisim /opt/Xilinx/iselib/unisim
vmap xilinxcorelib /opt/Xilinx/iselib/XilinxCoreLib
vmap xilinxcorelib_ver /opt/Xilinx/iselib/XilinxCoreLib_ver

vlib opb_selectmap_fifo_v1_01_a
vmap opb_selectmap_fifo_v1_01_a opb_selectmap_fifo_v1_01_a

vlog -work opb_selectmap_fifo_v1_01_a ../../pcores/opb_selectmap_fifo_v1_01_a/hdl/verilog/async_fifo_8_8_128.v
vlog -work opb_selectmap_fifo_v1_01_a ../../pcores/opb_selectmap_fifo_v1_01_a/hdl/verilog/user_fifo.v
