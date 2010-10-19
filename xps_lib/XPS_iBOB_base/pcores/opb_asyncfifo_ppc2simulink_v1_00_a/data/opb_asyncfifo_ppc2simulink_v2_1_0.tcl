proc min {a b} {
	if {$a<=$b} {
		return $a
	}
	if {$a>$b} {
		return $b
	}
}

proc generate_fifo {mhsinst} {
	set filePath [xget_ncf_dir $mhsinst]
	set length [xget_value $mhsinst "parameter" "FIFO_LENGTH"]
	set width  [xget_value $mhsinst "parameter" "FIFO_WIDTH"]
	file delete -force $filePath
	file mkdir $filePath
	file mkdir [file join $filePath tmp]

	set old_dir [pwd]
	cd $filePath

	set coregenfile [file join $filePath tmp asyncfifo.xco]
	set outputFile [open $coregenfile "w"]

	puts $outputFile "# BEGIN Project Options"
	puts $outputFile "SET flowvendor             = Other"
	puts $outputFile "SET vhdlsim                = False"
	puts $outputFile "SET verilogsim             = False"
	puts $outputFile "SET foundationsym          = False"
	puts $outputFile "SET workingdirectory       = $filePath"
	puts $outputFile "SET speedgrade             = -7"
	puts $outputFile "SET simulationfiles        = Behavioral"
	puts $outputFile "SET asysymbol              = False"
	puts $outputFile "SET addpads                = False"
	puts $outputFile "SET device                 = xc2vp50"
	puts $outputFile "SET devicefamily           = virtex2p"
	puts $outputFile "SET package                = ff1517"
	puts $outputFile "SET implementationfiletype = Edif"
	puts $outputFile "SET busformat              = BusFormatParenNotRipped"
	puts $outputFile "SET createndf              = False"
	puts $outputFile "SET designentry            = VHDL"
	puts $outputFile "SET formalverification     = False"
	puts $outputFile "SET removerpms             = False"
	puts $outputFile "# END Project Options"

	puts $outputFile "# BEGIN Select"
	puts $outputFile "SELECT Fifo_Generator family Xilinx,_Inc. 2.2"
	puts $outputFile "# END Select"

	puts $outputFile "# BEGIN Parameters"
	puts $outputFile "CSET almost_empty_flag              = false"
	puts $outputFile "CSET write_data_count               = true"
	puts $outputFile "CSET read_data_count                = false"
	puts $outputFile "CSET full_threshold_negate_value    = 1"
	puts $outputFile "CSET use_built_in_fifo_flags        = false"
	puts $outputFile "CSET empty_threshold_negate_value   = 1"
	puts $outputFile "CSET input_data_width               = 32"
	puts $outputFile "CSET output_data_width              = $width"
	puts $outputFile "CSET input_depth                    = [expr $length*$width/32]"
	puts $outputFile "CSET output_depth                   = $length"
	puts $outputFile "CSET valid_flag                     = false"
	puts $outputFile "CSET empty_threshold_negate_presets = 3/4_Empty"
	puts $outputFile "CSET write_acknowledge_flag         = false"
	puts $outputFile "CSET programmable_empty_type        = Single_Programmable_Empty_Threshold_Input_Port"
	puts $outputFile "CSET programmable_full_type         = No_Programmable_Full_Threshold"
	puts $outputFile "CSET full_threshold_negate_presets  = 3/4_Full"
	puts $outputFile "CSET fifo_implementation            = Independent_Clocks_Block_RAM"
	puts $outputFile "CSET underflow_flag                 = false"
	puts $outputFile "CSET use_extra_logic                = false"
	puts $outputFile "CSET valid_sense                    = Active_High"
	puts $outputFile "CSET write_data_count_width         = [min [expr round(log10($length*$width/32)/log10(2))] [expr round(log10($length)/log10(2))]]"
	puts $outputFile "CSET read_data_count_width          = 2"
	puts $outputFile "CSET data_count_width               = 2"
	puts $outputFile "CSET dout_reset_value               = 0"
	puts $outputFile "CSET underflow_sense                = Active_High"
	puts $outputFile "CSET component_name                 = asyncfifo"
	puts $outputFile "CSET overflow_sense                 = Active_High"
	puts $outputFile "CSET overflow_flag                  = false"
	puts $outputFile "CSET data_count                     = false"
	puts $outputFile "CSET primitive_depth                = 512"
	puts $outputFile "CSET performance_options            = Standard_FIFO"
	puts $outputFile "CSET empty_threshold_assert_presets = 3/4_Empty"
	puts $outputFile "CSET full_threshold_assert_value    = 1"
	puts $outputFile "CSET almost_full_flag               = false"
	puts $outputFile "CSET full_threshold_assert_presets  = 3/4_Full"
	puts $outputFile "CSET write_acknowledge_sense        = Active_High"
	puts $outputFile "CSET empty_threshold_assert_value   = 1"
	puts $outputFile "# END Parameters"
	puts $outputFile "GENERATE"

	close $outputFile
	
	cd $filePath
	puts [exec coregen -b $coregenfile 2>@stderr]
	cd $old_dir
}
