view structure
view signals
view wave
onerror {resume}
quietly WaveActivateNextPane {} 0
#
add wave -noupdate -divider {System Signals}
add wave -noupdate -format logic /testbench/reset
add wave -noupdate -format logic /testbench/gtx_clk
#
add wave -noupdate -divider {TX Client Interface}
add wave -noupdate -format logic /testbench/tx_clk
#add wave -noupdate -format logic -hex /testbench/dut/tx_data
#add wave -noupdate -format logic -binary /testbench/dut/tx_data_valid
#add wave -noupdate -format logic /testbench/dut/tx_start
#add wave -noupdate -format logic /testbench/dut/tx_ack
# tx_underrun is tied to '0' in the example design and is minimised out
#add wave -noupdate -format logic /testbench/dut/tx_underrun
add wave -noupdate -format logic -hex /testbench/tx_ifg_delay
#
add wave -noupdate -divider {TX Statistics Vector}
add wave -noupdate -format logic -binary /testbench/tx_statistics_vector
add wave -noupdate -format logic /testbench/tx_statistics_valid
#
add wave -noupdate -divider {RX Client Interface}
add wave -noupdate -format logic /testbench/rx_clk
#add wave -noupdate -format logic -hex /testbench/dut/rx_data
#add wave -noupdate -format logic -binary /testbench/dut/rx_data_valid
#add wave -noupdate -format logic /testbench/dut/rx_good_frame
#add wave -noupdate -format logic /testbench/dut/rx_bad_frame
add wave -noupdate -divider {RX Statistics Vector}
add wave -noupdate -format logic -binary /testbench/rx_statistics_vector
add wave -noupdate -format logic /testbench/rx_statistics_valid
#
add wave -noupdate -divider {Flow Control}
add wave -noupdate -format logic -hex /testbench/pause_val
add wave -noupdate -format logic /testbench/pause_req
#
add wave -noupdate -divider {TX PHY Interface}
add wave -noupdate -format logic -hex /testbench/xgmii_txd
add wave -noupdate -format logic -binary /testbench/xgmii_txc
#
add wave -noupdate -divider {RX PHY Interface}
add wave -noupdate -format logic /testbench/xgmii_rx_clk
add wave -noupdate -format logic -hex /testbench/xgmii_rxd
add wave -noupdate -format logic -binary /testbench/xgmii_rxc
#
add wave -noupdate -divider {Management Interface}
add wave -noupdate -format logic -binary /testbench/configuration_vector
#
TreeUpdate [SetDefaultTree]

