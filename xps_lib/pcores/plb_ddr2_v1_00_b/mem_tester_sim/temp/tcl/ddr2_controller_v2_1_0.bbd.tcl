set output_file [open "mem_tester_sim/ddr2_controller_v1_00_a/data/ddr2_controller_v2_1_0.bbd" w ]
set line_num 1; puts $output_file "## Black box definition file"
set line_num 2; puts $output_file ""
set line_num 3; puts $output_file "Files"
set line_num 4; puts $output_file "ddr2_controller.edf, dcmx3y0_2vp70.edn"
set line_num 5; puts $output_file ""
close $output_file
