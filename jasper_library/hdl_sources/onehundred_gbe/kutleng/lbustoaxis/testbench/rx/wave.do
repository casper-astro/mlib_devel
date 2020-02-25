onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /lbusrxaxistx_tb/lbus_rxclk
add wave -noupdate /lbusrxaxistx_tb/lbus_rxreset
add wave -noupdate -color Gold /lbusrxaxistx_tb/UUT_i/aligned_rxenain0
add wave -noupdate -expand -group AXIS /lbusrxaxistx_tb/lbus_rxclk
add wave -noupdate -expand -group AXIS /lbusrxaxistx_tb/axis_tx_tdata
add wave -noupdate -expand -group AXIS -color Magenta /lbusrxaxistx_tb/axis_tx_tvalid
add wave -noupdate -expand -group AXIS /lbusrxaxistx_tb/axis_tx_tkeep
add wave -noupdate -expand -group AXIS -color Red /lbusrxaxistx_tb/axis_tx_tlast
add wave -noupdate -expand -group AXIS /lbusrxaxistx_tb/axis_tx_tuser
add wave -noupdate -expand -group LBUS /lbusrxaxistx_tb/lbus_rxdatain0
add wave -noupdate -expand -group LBUS -color Magenta /lbusrxaxistx_tb/lbus_rxenain0
add wave -noupdate -expand -group LBUS -color Red /lbusrxaxistx_tb/lbus_rxsopin0
add wave -noupdate -expand -group LBUS -color Pink /lbusrxaxistx_tb/lbus_rxeopin0
add wave -noupdate -expand -group LBUS /lbusrxaxistx_tb/lbus_rxerrin0
add wave -noupdate -expand -group LBUS /lbusrxaxistx_tb/lbus_rxmtyin0
add wave -noupdate -expand -group LBUS /lbusrxaxistx_tb/lbus_rxdatain1
add wave -noupdate -expand -group LBUS -color Magenta /lbusrxaxistx_tb/lbus_rxenain1
add wave -noupdate -expand -group LBUS -color Red /lbusrxaxistx_tb/lbus_rxsopin1
add wave -noupdate -expand -group LBUS -color Pink /lbusrxaxistx_tb/lbus_rxeopin1
add wave -noupdate -expand -group LBUS /lbusrxaxistx_tb/lbus_rxerrin1
add wave -noupdate -expand -group LBUS /lbusrxaxistx_tb/lbus_rxmtyin1
add wave -noupdate -expand -group LBUS /lbusrxaxistx_tb/lbus_rxdatain2
add wave -noupdate -expand -group LBUS -color Magenta /lbusrxaxistx_tb/lbus_rxenain2
add wave -noupdate -expand -group LBUS -color Red /lbusrxaxistx_tb/lbus_rxsopin2
add wave -noupdate -expand -group LBUS -color Pink /lbusrxaxistx_tb/lbus_rxeopin2
add wave -noupdate -expand -group LBUS /lbusrxaxistx_tb/lbus_rxerrin2
add wave -noupdate -expand -group LBUS /lbusrxaxistx_tb/lbus_rxmtyin2
add wave -noupdate -expand -group LBUS /lbusrxaxistx_tb/lbus_rxdatain3
add wave -noupdate -expand -group LBUS -color Magenta /lbusrxaxistx_tb/lbus_rxenain3
add wave -noupdate -expand -group LBUS -color Red /lbusrxaxistx_tb/lbus_rxsopin3
add wave -noupdate -expand -group LBUS -color Pink /lbusrxaxistx_tb/lbus_rxeopin3
add wave -noupdate -expand -group LBUS /lbusrxaxistx_tb/lbus_rxerrin3
add wave -noupdate -expand -group LBUS /lbusrxaxistx_tb/lbus_rxmtyin3
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxclk
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxreset
add wave -noupdate -expand -group UUT -group UUT_AXIS /lbusrxaxistx_tb/UUT_i/axis_tx_tdata
add wave -noupdate -expand -group UUT -group UUT_AXIS /lbusrxaxistx_tb/UUT_i/axis_tx_tvalid
add wave -noupdate -expand -group UUT -group UUT_AXIS /lbusrxaxistx_tb/UUT_i/axis_tx_tkeep
add wave -noupdate -expand -group UUT -group UUT_AXIS /lbusrxaxistx_tb/UUT_i/axis_tx_tlast
add wave -noupdate -expand -group UUT -group UUT_AXIS /lbusrxaxistx_tb/UUT_i/axis_tx_tuser
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxdatain0
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxenain0
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxsopin0
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxeopin0
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxerrin0
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxmtyin0
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxdatain1
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxenain1
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxsopin1
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxeopin1
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxerrin1
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxmtyin1
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxdatain2
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxenain2
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxsopin2
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxeopin2
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxerrin2
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxmtyin2
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxdatain3
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxenain3
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxsopin3
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxeopin3
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxerrin3
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxmtyin3
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxdatain0fs1
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxdatain1fs1
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxdatain2fs1
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxdatain3fs1
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/aligned_rxdatain0
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/aligned_rxdatain1
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/aligned_rxdatain2
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/aligned_rxdatain3
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxmtyin0fs1
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxmtyin1fs1
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxmtyin2fs1
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxmtyin3fs1
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/aligned_rxmtyin0
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/aligned_rxmtyin1
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/aligned_rxmtyin2
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/aligned_rxmtyin3
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxeopin0fs1
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxeopin1fs1
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxeopin2fs1
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxeopin3fs1
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/aligned_rxeopin0
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/aligned_rxeopin1
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/aligned_rxeopin2
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/aligned_rxeopin3
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxenain0fs1
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxenain1fs1
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxenain2fs1
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxenain3fs1
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/aligned_rxenain0
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/aligned_rxenain1
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/aligned_rxenain2
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/aligned_rxenain3
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/CurrentAlignment
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxenain2fs0
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxenain1fs0
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxenain0fs0
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxeopin2fs0
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxeopin1fs0
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxeopin0fs0
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxmtyin2fs0
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxmtyin1fs0
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxmtyin0fs0
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxdatain2fs0
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxdatain1fs0
add wave -noupdate -expand -group UUT /lbusrxaxistx_tb/UUT_i/lbus_rxdatain0fs0
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {316267411 fs} 0}
quietly wave cursor active 1
configure wave -namecolwidth 376
configure wave -valuecolwidth 100
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
configure wave -timelineunits ns
update
WaveRestoreZoom {307756250 fs} {415381250 fs}
