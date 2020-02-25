onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /lbusaxisrx_tb/UUT_i/axis_clk
add wave -noupdate /lbusaxisrx_tb/UUT_i/axis_aresetn
add wave -noupdate /lbusaxisrx_tb/UUT_i/axis_tdata
add wave -noupdate /lbusaxisrx_tb/UUT_i/axis_tvalid
add wave -noupdate /lbusaxisrx_tb/UUT_i/axis_tready
add wave -noupdate /lbusaxisrx_tb/UUT_i/axis_tkeep
add wave -noupdate /lbusaxisrx_tb/UUT_i/axis_tlast
add wave -noupdate /lbusaxisrx_tb/UUT_i/axis_clk
add wave -noupdate /lbusaxisrx_tb/UUT_i/lbus_rxdataout0
add wave -noupdate -color Magenta /lbusaxisrx_tb/UUT_i/lbus_rxenaout0
add wave -noupdate -color Pink /lbusaxisrx_tb/UUT_i/lbus_rxsopout0
add wave -noupdate -color Red /lbusaxisrx_tb/UUT_i/lbus_rxeopout0
add wave -noupdate /lbusaxisrx_tb/UUT_i/lbus_rxerrout0
add wave -noupdate /lbusaxisrx_tb/UUT_i/lbus_rxmtyout0
add wave -noupdate /lbusaxisrx_tb/UUT_i/lbus_rxdataout1
add wave -noupdate -color Magenta /lbusaxisrx_tb/UUT_i/lbus_rxenaout1
add wave -noupdate -color Pink /lbusaxisrx_tb/UUT_i/lbus_rxsopout1
add wave -noupdate -color Red /lbusaxisrx_tb/UUT_i/lbus_rxeopout1
add wave -noupdate /lbusaxisrx_tb/UUT_i/lbus_rxerrout1
add wave -noupdate /lbusaxisrx_tb/UUT_i/lbus_rxmtyout1
add wave -noupdate /lbusaxisrx_tb/UUT_i/lbus_rxdataout2
add wave -noupdate -color Magenta /lbusaxisrx_tb/UUT_i/lbus_rxenaout2
add wave -noupdate -color Pink /lbusaxisrx_tb/UUT_i/lbus_rxsopout2
add wave -noupdate -color Red /lbusaxisrx_tb/UUT_i/lbus_rxeopout2
add wave -noupdate /lbusaxisrx_tb/UUT_i/lbus_rxerrout2
add wave -noupdate /lbusaxisrx_tb/UUT_i/lbus_rxmtyout2
add wave -noupdate /lbusaxisrx_tb/UUT_i/lbus_rxdataout3
add wave -noupdate -color Magenta /lbusaxisrx_tb/UUT_i/lbus_rxenaout3
add wave -noupdate -color Pink /lbusaxisrx_tb/UUT_i/lbus_rxsopout3
add wave -noupdate -color Red /lbusaxisrx_tb/UUT_i/lbus_rxeopout3
add wave -noupdate /lbusaxisrx_tb/UUT_i/lbus_rxerrout3
add wave -noupdate /lbusaxisrx_tb/UUT_i/lbus_rxmtyout3
add wave -noupdate /lbusaxisrx_tb/UUT_i/paxis_tvalid
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {224448020 fs} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
configure wave -timelineunits ns
update
WaveRestoreZoom {40750 ps} {355750 ps}
