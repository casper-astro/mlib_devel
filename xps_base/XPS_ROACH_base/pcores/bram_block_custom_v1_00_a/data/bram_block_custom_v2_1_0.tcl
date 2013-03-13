proc min {a b} {
	if {$a<=$b} {
		return $a
	}
	if {$a>$b} {
		return $b
	}
}

proc generate_bram {mhsinst} {
	set filePath        [xget_ncf_dir $mhsinst]
	set dwidtha         [xget_value $mhsinst "parameter" "C_PORTA_DWIDTH"]
	set dwidthb         [xget_value $mhsinst "parameter" "C_PORTB_DWIDTH"]
	set awidtha         [xget_value $mhsinst "parameter" "C_PORTA_DEPTH"]
	set optimization    [xget_value $mhsinst "parameter" "OPTIMIZATION"]
	set reg_core_output [xget_value $mhsinst "parameter" "REG_CORE_OUTPUT"]
	set reg_prim_output [xget_value $mhsinst "parameter" "REG_PRIM_OUTPUT"]
	file delete -force $filePath
	file mkdir $filePath
	file mkdir [file join $filePath tmp]

	set old_dir [pwd]
	cd $filePath

	set coregenfile [file join $filePath tmp bram.xco]
	set outputFile [open $coregenfile "w"]


  puts $outputFile "# BEGIN Project Options"
  puts $outputFile "NEWPROJECT ."
  puts $outputFile "SET addpads = false"
  puts $outputFile "SET asysymbol = true"
  puts $outputFile "SET busformat = BusFormatAngleBracketNotRipped"
  puts $outputFile "SET createndf = false"
  puts $outputFile "SET designentry = Verilog"
  puts $outputFile "SET device = xc5vsx95t"
  puts $outputFile "SET devicefamily = virtex5"
  puts $outputFile "SET flowvendor = Other"
  puts $outputFile "SET formalverification = false"
  puts $outputFile "SET foundationsym = false"
  puts $outputFile "SET implementationfiletype = Ngc"
  puts $outputFile "SET package = ff1136"
  puts $outputFile "SET removerpms = false"
  puts $outputFile "SET simulationfiles = Behavioral"
  puts $outputFile "SET speedgrade = -1"
  puts $outputFile "SET verilogsim = True"
  puts $outputFile "SET vhdlsim = False"
  puts $outputFile "# END Project Options"
  puts $outputFile "# BEGIN Select"
  puts $outputFile "SELECT Block_Memory_Generator xilinx.com:ip:blk_mem_gen:7.3"
  puts $outputFile "# END Select"
  puts $outputFile "# BEGIN Parameters"
  puts $outputFile "CSET additional_inputs_for_power_estimation=false"
  puts $outputFile "CSET algorithm=$optimization"
  puts $outputFile "CSET assume_synchronous_clk=false"
  puts $outputFile "CSET axi_id_width=4"
  puts $outputFile "CSET axi_slave_type=Memory_Slave"
  puts $outputFile "CSET axi_type=AXI4_Full"
  puts $outputFile "CSET byte_size=8"
  puts $outputFile "CSET coe_file=no_coe_file_loaded"
  puts $outputFile "CSET collision_warnings=ALL"
  puts $outputFile "CSET component_name=bram"
  puts $outputFile "CSET disable_collision_warnings=false"
  puts $outputFile "CSET disable_out_of_range_warnings=false"
  puts $outputFile "CSET ecc=false"
  puts $outputFile "CSET ecctype=No_ECC"
  puts $outputFile "CSET enable_32bit_address=true"
  puts $outputFile "CSET enable_a=Use_ENA_Pin"
  puts $outputFile "CSET enable_b=Use_ENB_Pin"
  puts $outputFile "CSET error_injection_type=Single_Bit_Error_Injection"
  puts $outputFile "CSET fill_remaining_memory_locations=false"
  puts $outputFile "CSET interface_type=Native"
  puts $outputFile "CSET load_init_file=false"
  puts $outputFile "CSET mem_file=no_Mem_file_loaded"
  puts $outputFile "CSET memory_type=True_Dual_Port_RAM"
  puts $outputFile "CSET operating_mode_a=WRITE_FIRST"
  puts $outputFile "CSET operating_mode_b=WRITE_FIRST"
  puts $outputFile "CSET output_reset_value_a=0"
  puts $outputFile "CSET output_reset_value_b=0"
  puts $outputFile "CSET pipeline_stages=0"
  puts $outputFile "CSET port_a_clock=100"
  puts $outputFile "CSET port_a_enable_rate=100"
  puts $outputFile "CSET port_a_write_rate=50"
  puts $outputFile "CSET port_b_clock=100"
  puts $outputFile "CSET port_b_enable_rate=100"
  puts $outputFile "CSET port_b_write_rate=50"
  puts $outputFile "CSET primitive=8kx2"
  puts $outputFile "CSET register_porta_input_of_softecc=false"
  puts $outputFile "CSET register_porta_output_of_memory_core=$reg_prim_output"
  puts $outputFile "CSET register_porta_output_of_memory_primitives=$reg_core_output"
  puts $outputFile "CSET register_portb_output_of_memory_core=false"
  puts $outputFile "CSET register_portb_output_of_memory_primitives=false"
  puts $outputFile "CSET register_portb_output_of_softecc=false"
  puts $outputFile "CSET remaining_memory_locations=0"
  puts $outputFile "CSET reset_memory_latch_a=false"
  puts $outputFile "CSET reset_memory_latch_b=false"
  puts $outputFile "CSET reset_priority_a=CE"
  puts $outputFile "CSET reset_priority_b=CE"
  puts $outputFile "CSET reset_type=SYNC"
  puts $outputFile "CSET softecc=false"
  puts $outputFile "CSET use_axi_id=false"
  puts $outputFile "CSET use_bram_block=Stand_Alone"
  puts $outputFile "CSET use_byte_write_enable=true"
  puts $outputFile "CSET use_error_injection_pins=false"
  puts $outputFile "CSET use_regcea_pin=false"
  puts $outputFile "CSET use_regceb_pin=false"
  puts $outputFile "CSET use_rsta_pin=false"
  puts $outputFile "CSET use_rstb_pin=false"
  puts $outputFile "CSET write_depth_a=16"
  puts $outputFile "CSET write_width_a=$dwidtha"
  puts $outputFile "CSET read_width_a=$dwidtha"
  puts $outputFile "CSET write_width_b=$dwidthb"
  puts $outputFile "CSET read_width_b=$dwidthb"
  puts $outputFile "# END Parameters"
  puts $outputFile "GENERATE"

	close $outputFile

	cd $filePath
	puts [exec coregen -b $coregenfile 2>@stderr]
	cd $old_dir
}
