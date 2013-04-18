namespace inscope :: source [file join [info library] package.tcl]
package require sha1

proc min {a b} {
  if {$a<=$b} {
    return $a
  }
  if {$a>$b} {
    return $b
  }
}

proc generate_bram {mhsinst} {

  # Cache directory is ".../<design_name>/XPS_ROACH2_base/../cache_dir"
  #      equivalent to ".../<design_name>/cache_dir"
  set mhsdir          [xget_mhs_dir $mhsinst]
  set cachedir        [file join $mhsdir ".." cache_dir]
  set filePath        [xget_ncf_dir $mhsinst]
  set dwidtha         [xget_value $mhsinst "parameter" "C_PORTA_DWIDTH"]
  set dwidthb         [xget_value $mhsinst "parameter" "C_PORTB_DWIDTH"]
  set awidtha         [xget_value $mhsinst "parameter" "C_PORTA_DEPTH"]
  set optimization    [xget_value $mhsinst "parameter" "OPTIMIZATION"]
  set reg_core_output [xget_value $mhsinst "parameter" "REG_CORE_OUTPUT"]
  set reg_prim_output [xget_value $mhsinst "parameter" "REG_PRIM_OUTPUT"]

  # Make sure cachedir exists
  file mkdir $cachedir

  # Delete and recreate $filePath
  file delete -force $filePath
  file mkdir $filePath
  file mkdir [file join $filePath tmp]

  # Generate xco text
  set     lines ""
  lappend lines "# BEGIN Project Options"
  lappend lines "NEWPROJECT ."
  lappend lines "SET addpads = false"
  lappend lines "SET asysymbol = true"
  lappend lines "SET busformat = BusFormatAngleBracketNotRipped"
  lappend lines "SET createndf = false"
  lappend lines "SET designentry = Verilog"
  lappend lines "SET device = xc6vsx475t"
  lappend lines "SET devicefamily = virtex6"
  lappend lines "SET flowvendor = Other"
  lappend lines "SET formalverification = false"
  lappend lines "SET foundationsym = false"
  lappend lines "SET implementationfiletype = Ngc"
  lappend lines "SET package = ff1759"
  lappend lines "SET removerpms = false"
  lappend lines "SET simulationfiles = Behavioral"
  lappend lines "SET speedgrade = -1"
  lappend lines "SET verilogsim = True"
  lappend lines "SET vhdlsim = False"
  lappend lines "# END Project Options"
  lappend lines "# BEGIN Select"
  lappend lines "SELECT Block_Memory_Generator xilinx.com:ip:blk_mem_gen:6.1"
  lappend lines "# END Select"
  lappend lines "# BEGIN Parameters"
  lappend lines "CSET additional_inputs_for_power_estimation=false"
  lappend lines "CSET algorithm=$optimization"
  lappend lines "CSET assume_synchronous_clk=false"
  lappend lines "CSET axi_id_width=4"
  lappend lines "CSET axi_slave_type=Memory_Slave"
  lappend lines "CSET axi_type=AXI4_Full"
  lappend lines "CSET byte_size=8"
  lappend lines "CSET coe_file=no_coe_file_loaded"
  lappend lines "CSET collision_warnings=ALL"
  lappend lines "CSET component_name=bram"
  lappend lines "CSET disable_collision_warnings=false"
  lappend lines "CSET disable_out_of_range_warnings=false"
  lappend lines "CSET ecc=false"
  lappend lines "CSET ecctype=No_ECC"
  lappend lines "CSET enable_32bit_address=false"
  lappend lines "CSET enable_a=use_ENA_pin"
  lappend lines "CSET enable_b=use_ENB_pin"
  lappend lines "CSET error_injection_type=Single_Bit_Error_Injection"
  lappend lines "CSET fill_remaining_memory_locations=false"
  lappend lines "CSET interface_type=Native"
  lappend lines "CSET load_init_file=false"
  lappend lines "CSET memory_type=True_Dual_Port_RAM"
  lappend lines "CSET mem_file=no_Mem_file_loaded"
  lappend lines "CSET operating_mode_a=WRITE_FIRST"
  lappend lines "CSET operating_mode_b=WRITE_FIRST"
  lappend lines "CSET output_reset_value_a=0"
  lappend lines "CSET output_reset_value_b=0"
  lappend lines "CSET pipeline_stages=0"
  lappend lines "CSET port_a_clock=100"
  lappend lines "CSET port_a_enable_rate=100"
  lappend lines "CSET port_a_write_rate=50"
  lappend lines "CSET port_b_clock=100"
  lappend lines "CSET port_b_enable_rate=100"
  lappend lines "CSET port_b_write_rate=50"
  lappend lines "CSET primitive=8kx2"
  lappend lines "CSET register_porta_input_of_softecc=false"
  lappend lines "CSET register_porta_output_of_memory_core=$reg_prim_output"
  lappend lines "CSET register_porta_output_of_memory_primitives=$reg_core_output"
  lappend lines "CSET register_portb_output_of_memory_core=false"
  lappend lines "CSET register_portb_output_of_memory_primitives=false"
  lappend lines "CSET register_portb_output_of_softecc=false"
  lappend lines "CSET remaining_memory_locations=0"
  lappend lines "CSET reset_memory_latch_a=false"
  lappend lines "CSET reset_memory_latch_b=false"
  lappend lines "CSET reset_priority_a=CE"
  lappend lines "CSET reset_priority_b=CE"
  lappend lines "CSET reset_type=SYNC"
  lappend lines "CSET softecc=false"
  lappend lines "CSET use_axi_id=false"
  lappend lines "CSET use_bram_block=Stand_Alone"
  lappend lines "CSET use_byte_write_enable=true"
  lappend lines "CSET use_error_injection_pins=false"
  lappend lines "CSET use_regcea_pin=false"
  lappend lines "CSET use_regceb_pin=false"
  lappend lines "CSET use_rsta_pin=false"
  lappend lines "CSET use_rstb_pin=false"
  lappend lines "CSET write_depth_a=[expr 1 << $awidtha]"
  lappend lines "CSET write_width_a=$dwidtha"
  lappend lines "CSET read_width_a=$dwidtha"
  lappend lines "CSET write_width_b=$dwidthb"
  lappend lines "CSET read_width_b=$dwidthb"
  lappend lines "# END Parameters"
  lappend lines "GENERATE"

  set xco_text [join $lines "\n"]

  # Generate hash of xco text
  set hash [::sha1::sha1 $xco_text]
  # Create name of cached (or to-be-cached) ngc file
  set cache_ngc [file join $cachedir "${hash}.ngc"]

  # If $hash.ngc exists in cachedir
  if [file exists $cache_ngc] {
    puts "NETLIST CACHE HIT - Copying $cache_ngc to [file join $filePath "bram.ngc"]"
    # Copy NGC to bram.ngc file in ncf directory
    file copy $cache_ngc [file join $filePath "bram.ngc"]
  } else {
    puts "NETLIST CACHE MISS - Running coregen..."

    # Create bram.xco file
    set coregenfile [file join $filePath tmp bram.xco]
    set outputFile [open $coregenfile "w"]
    puts $outputFile $xco_text
    close $outputFile

    # Run coregen
    set old_dir [pwd]
    cd $filePath
    puts [exec coregen -b $coregenfile 2>@stderr]
    cd $old_dir

    # Copy bram.ngc to cachedir
    puts "NETLIST CACHE SAVE - Copying [file join $filePath "bram.ngc"] to $cache_ngc"
    file copy [file join $filePath "bram.ngc"] $cache_ngc
  }
}
