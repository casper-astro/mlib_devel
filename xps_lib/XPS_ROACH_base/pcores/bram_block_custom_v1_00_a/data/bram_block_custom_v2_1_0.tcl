proc min {a b} {
	if {$a<=$b} {
		return $a
	}
	if {$a>$b} {
		return $b
	}
}

proc generate_bram {mhsinst} {
	set filePath [xget_ncf_dir $mhsinst]
	set dwidtha  [xget_value $mhsinst "parameter" "C_PORTA_DWIDTH"]
	set dwidthb  [xget_value $mhsinst "parameter" "C_PORTB_DWIDTH"]
	set awidtha  [xget_value $mhsinst "parameter" "C_PORTA_DEPTH"]
	file delete -force $filePath
	file mkdir $filePath
	file mkdir [file join $filePath tmp]

	set old_dir [pwd]
	cd $filePath

	set coregenfile [file join $filePath tmp bram.xco]
	set outputFile [open $coregenfile "w"]

  puts $outputFile "# BEGIN Project Options"
  puts $outputFile "SET addpads = False"
  puts $outputFile "SET asysymbol = True"
  puts $outputFile "SET busformat = BusFormatAngleBracketNotRipped"
  puts $outputFile "SET createndf = False"
  puts $outputFile "SET designentry = Verilog"
  puts $outputFile "SET device = xc5vsx95t"
  puts $outputFile "SET devicefamily = virtex5"
  puts $outputFile "SET flowvendor = Other"
  puts $outputFile "SET formalverification = False"
  puts $outputFile "SET foundationsym = False"
  puts $outputFile "SET implementationfiletype = Ngc"
  puts $outputFile "SET package = ff1136"
  puts $outputFile "SET removerpms = False"
  puts $outputFile "SET simulationfiles = Behavioral"
  puts $outputFile "SET speedgrade = -1"
  puts $outputFile "SET verilogsim = True"
  puts $outputFile "SET vhdlsim = False"
  puts $outputFile "# END Project Options"
  puts $outputFile "# BEGIN Select"
  puts $outputFile "SELECT Block_Memory_Generator family Xilinx,_Inc. 2.6"
  puts $outputFile "# END Select"
  puts $outputFile "# BEGIN Parameters"
  puts $outputFile "CSET algorithm=Minimum_Area"
  puts $outputFile "CSET assume_synchronous_clk=false"
  puts $outputFile "CSET byte_size=8"
  puts $outputFile "CSET coe_file=no_coe_file_loaded"
  puts $outputFile "CSET collision_warnings=ALL"
  puts $outputFile "CSET component_name=bram"
  puts $outputFile "CSET disable_collision_warnings=false"
  puts $outputFile "CSET disable_out_of_range_warnings=false"
  puts $outputFile "CSET ecc=false"
  puts $outputFile "CSET enable_a=Always_Enabled"
  puts $outputFile "CSET enable_b=Always_Enabled"
  puts $outputFile "CSET fill_remaining_memory_locations=false"
  puts $outputFile "CSET load_init_file=false"
  puts $outputFile "CSET memory_type=True_Dual_Port_RAM"
  puts $outputFile "CSET operating_mode_a=WRITE_FIRST"
  puts $outputFile "CSET operating_mode_b=WRITE_FIRST"
  puts $outputFile "CSET output_reset_value_a=0"
  puts $outputFile "CSET output_reset_value_b=0"
  puts $outputFile "CSET pipeline_stages=0"
  puts $outputFile "CSET primitive=8kx2"
  puts $outputFile "CSET register_porta_output_of_memory_core=false"
  puts $outputFile "CSET register_porta_output_of_memory_primitives=false"
  puts $outputFile "CSET register_portb_output_of_memory_core=false"
  puts $outputFile "CSET register_portb_output_of_memory_primitives=false"
  puts $outputFile "CSET remaining_memory_locations=0"
  puts $outputFile "CSET use_byte_write_enable=true"
  puts $outputFile "CSET use_regcea_pin=false"
  puts $outputFile "CSET use_regceb_pin=false"
  puts $outputFile "CSET write_depth_a=[expr 1 << $awidtha]"
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
