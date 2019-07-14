puts "Starting tcl script"
create_project -f myproj /home/hpw1/amit/mlib_devel/test_vcu128/myproj -part xcvu37p-fsvh2892-2L-e-es1
import_files -force /home/hpw1/amit/mlib_devel/test_vcu128/top.v
import_files -force /home/hpw1/amit/mlib_devel/jasper_library/hdl_sources/onegbe/CRC_gen.v
import_files -force /home/hpw1/amit/mlib_devel/jasper_library/hdl_sources/onegbe/gbe_cpu_attach_wb.v
import_files -force /home/hpw1/amit/mlib_devel/jasper_library/hdl_sources/onegbe/gbe_udp.v
import_files -force /home/hpw1/amit/mlib_devel/jasper_library/hdl_sources/onegbe/gig_eth_mac_rx.v
import_files -force /home/hpw1/amit/mlib_devel/jasper_library/hdl_sources/onegbe/gbe_rx.v
import_files -force /home/hpw1/amit/mlib_devel/jasper_library/hdl_sources/onegbe/mdio_config.v
import_files -force /home/hpw1/amit/mlib_devel/jasper_library/hdl_sources/onegbe/gbe_tx.v
import_files -force /home/hpw1/amit/mlib_devel/jasper_library/hdl_sources/onegbe/CRC_chk.v
import_files -force /home/hpw1/amit/mlib_devel/jasper_library/hdl_sources/onegbe/mdio_master.v
import_files -force /home/hpw1/amit/mlib_devel/jasper_library/hdl_sources/onegbe/gig_eth_mac.v
import_files -force /home/hpw1/amit/mlib_devel/jasper_library/hdl_sources/onegbe/gig_eth_mac_tx.v
import_files -force /home/hpw1/amit/mlib_devel/jasper_library/hdl_sources/onegbe/virtexuplus/gig_ethernet_pcs_pma_sgmii_lvds.xci
import_files -force /home/hpw1/amit/mlib_devel/jasper_library/hdl_sources/onegbe/virtexuplus/gbe_tx_packet_fifo.xci
import_files -force /home/hpw1/amit/mlib_devel/jasper_library/hdl_sources/onegbe/virtexuplus/gig_ethernet_pcs_pma_sgmii.xci
import_files -force /home/hpw1/amit/mlib_devel/jasper_library/hdl_sources/onegbe/virtexuplus/gbe_ctrl_fifo.xci
import_files -force /home/hpw1/amit/mlib_devel/jasper_library/hdl_sources/onegbe/virtexuplus/gbe_rx_packet_fifo.xci
import_files -force /home/hpw1/amit/mlib_devel/jasper_library/hdl_sources/onegbe/virtexuplus/gbe_cpu_buffer.xci
import_files -force /home/hpw1/amit/mlib_devel/jasper_library/hdl_sources/onegbe/virtexuplus/gbe_rx_ctrl_fifo.xci
import_files -force /home/hpw1/amit/mlib_devel/jasper_library/hdl_sources/onegbe/virtexuplus/gbe_arp_cache.xci
import_files -force /home/hpw1/amit/mlib_devel/jasper_library/hdl_sources/wb_register_ppc2simulink
import_files -force /home/hpw1/amit/mlib_devel/jasper_library/hdl_sources/gpio_simulink2ext
import_files -force /home/hpw1/amit/mlib_devel/jasper_library/hdl_sources/infrastructure/vcu128_infrastructure.v
import_files -force /home/hpw1/amit/mlib_devel/jasper_library/hdl_sources/wbs_arbiter
import_files -force /home/hpw1/amit/mlib_devel/jasper_library/hdl_sources/sys_block
import_files -force /home/hpw1/amit/mlib_devel/test_vcu128/sysgen/hdl_netlist/test_vcu128.srcs/sources_1/imports/sysgen
import_files -force /home/hpw1/amit/mlib_devel/test_vcu128/sysgen/hdl_netlist/test_vcu128.srcs/sources_1/ip/test_vcu128_c_counter_binary_v12_0_i0/test_vcu128_c_counter_binary_v12_0_i0.xci
set repos [get_property ip_repo_paths [current_project]]
set_property ip_repo_paths "$repos /home/hpw1/amit/mlib_devel/jasper_library/hdl_sources/axi_wb_bridge/ip_repo" [current_project]
update_ip_catalog
import_files -force -fileset constrs_1 /home/hpw1/amit/mlib_devel/test_vcu128/user_const.xdc
set_property top top [current_fileset]
update_compile_order -fileset sources_1
if {[llength [glob -nocomplain [get_property directory [current_project]]/myproj.srcs/sources_1/imports/*.coe]] > 0} {
file copy -force {*}[glob [get_property directory [current_project]]/myproj.srcs/sources_1/imports/*.coe] [get_property directory [current_project]]/myproj.srcs/sources_1/ip/
}
upgrade_ip -quiet [get_ips *]
source /home/hpw1/amit/mlib_devel/jasper_library/hdl_sources/microblaze_wb/microblaze_wb_us_plus.tcl
reset_run synth_1
launch_runs synth_1 -jobs 4
wait_on_run synth_1
open_run synth_1
set_property STEPS.WRITE_BITSTREAM.ARGS.BIN_FILE true [get_runs impl_1]
set_property STEPS.PHYS_OPT_DESIGN.IS_ENABLED true [get_runs impl_1]
set_property STEPS.POST_ROUTE_PHYS_OPT_DESIGN.IS_ENABLED true [get_runs impl_1]
launch_runs impl_1 -jobs 4
wait_on_run impl_1
open_run impl_1
launch_runs impl_1 -to_step write_bitstream
wait_on_run impl_1
cd [get_property DIRECTORY [current_project]]
if { [get_property STATS.WNS [get_runs impl_1] ] < 0 } {
puts "Found timing violations => Worst Negative Slack: [get_property STATS.WNS [get_runs impl_1]] ns" 
} else {
puts "No timing violations => Worst Negative Slack: [get_property STATS.WNS [get_runs impl_1]] ns" 
}
if { [get_property STATS.TNS [get_runs impl_1] ] < 0 } {
puts "Found timing violations => Total Negative Slack: [get_property STATS.TNS [get_runs impl_1]] ns" 
} else {
puts "No timing violations => Total Negative Slack: [get_property STATS.TNS [get_runs impl_1]] ns" 
}
if { [get_property STATS.WHS [get_runs impl_1] ] < 0 } {
puts "Found timing violations => Worst Hold Slack: [get_property STATS.WHS [get_runs impl_1]] ns" 
} else {
puts "No timing violations => Worst Hold Slack: [get_property STATS.WHS [get_runs impl_1]] ns" 
}
if { [get_property STATS.THS [get_runs impl_1] ] < 0 } {
puts "Found timing violations => Total Hold Slack: [get_property STATS.THS [get_runs impl_1]] ns" 
} else {
puts "No timing violations => Total Hold Slack: [get_property STATS.THS [get_runs impl_1]] ns" 
}
exec cat /home/hpw1/amit/mlib_devel/jasper_library/hdl_sources/microblaze_wb/executable_us_plus.mem ../core_info.jam.tab.mem > ../executable_core_info.mem
exec -ignorestderr updatemem -bit ./myproj.runs/impl_1/top.bit -meminfo ./myproj.runs/impl_1/top.mmi -data ../executable_core_info.mem  -proc cont_microblaze_inst/microblaze_0 -out ./myproj.runs/impl_1/top.bit -force
