view structure
view signals
view wave
onerror {resume}
quietly WaveActivateNextPane {} 0
#
add wave -noupdate -divider {System Signals}
add wave -noupdate -format logic /testbench/reset
add wave -noupdate -format logic /testbench/refclk_p
add wave -noupdate -format logic /testbench/refclk_n
#
add wave -noupdate -divider {XGMII TX Signals}
add wave -noupdate -format logic -hex /testbench/xgmii_txd
add wave -noupdate -format logic -binary /testbench/xgmii_txc
#
add wave -noupdate -divider {XGMII RX Signals}
add wave -noupdate -format logic -hex /testbench/xgmii_rxd
add wave -noupdate -format logic -binary /testbench/xgmii_rxc
#
add wave -noupdate -divider {XAUI TX Signals}
add wave -noupdate -format logic -binary /testbench/xaui_tx_l0_p
add wave -noupdate -format logic -binary /testbench/xaui_tx_l0_n
add wave -noupdate -format logic -binary /testbench/xaui_tx_l1_p
add wave -noupdate -format logic -binary /testbench/xaui_tx_l1_n
add wave -noupdate -format logic -binary /testbench/xaui_tx_l2_p
add wave -noupdate -format logic -binary /testbench/xaui_tx_l2_n
add wave -noupdate -format logic -binary /testbench/xaui_tx_l3_p
add wave -noupdate -format logic -binary /testbench/xaui_tx_l3_n
#
add wave -noupdate -divider {XAUI RX Signals}
add wave -noupdate -format logic -binary /testbench/xaui_rx_l0_p
add wave -noupdate -format logic -binary /testbench/xaui_rx_l0_n
add wave -noupdate -format logic -binary /testbench/xaui_rx_l1_p
add wave -noupdate -format logic -binary /testbench/xaui_rx_l1_n
add wave -noupdate -format logic -binary /testbench/xaui_rx_l2_p
add wave -noupdate -format logic -binary /testbench/xaui_rx_l2_n
add wave -noupdate -format logic -binary /testbench/xaui_rx_l3_p
add wave -noupdate -format logic -binary /testbench/xaui_rx_l3_n
add wave -noupdate -format logic -binary /testbench/signal_detect
add wave -noupdate -format logic -binary /testbench/align_status
add wave -noupdate -format logic -binary /testbench/sync_status
#
add wave -noupdate -divider {Management signals}
add wave -noupdate -format logic -binary /testbench/configuration_vector
add wave -noupdate -format logic -binary /testbench/status_vector

TreeUpdate [SetDefaultTree]
