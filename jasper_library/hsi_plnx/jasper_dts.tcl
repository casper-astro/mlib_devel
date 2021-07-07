puts "starting device tree generation"

set tclpath "/home/mcb/git/casper/mlib_devel/jasper_library/hsi_plnx"
source "${tclpath}/dump_rfdc.tcl"
rfdc_dts_info [lindex $argv 0] [lindex $argv 1]
