
proc gen_dts {xsa} {
    hsi::open_hw_design $xsa
    hsi::set_repo_path /home/mcb/git/xilinx/device-tree-xlnx
    set processor [hsi::get_cells * -filter {IP_TYPE==PROCESSOR}]
    set processor [lindex $processor 0]
    hsi::create_sw_design device-tree -os device_tree -proc $processor
    hsi::set_property CONFIG.dt_overlay true [hsi::get_os]
    hsi::generate_target -dir my_dts_dto
}
