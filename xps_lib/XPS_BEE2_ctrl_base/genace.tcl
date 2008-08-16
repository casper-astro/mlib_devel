###############################################################################
##
## Copyright (c) 1995-2002 Xilinx, Inc.  All rights reserved.
##
## genace.tcl
## Generate SystemACE configuration file from FPGA bitstream 
## and PowerPC ELF program
## 
## $Header: /home/cvs/BEE2_BSP/RAMP_workshop/XPS_Ctrlfpga/genace.tcl,v 1.1 2006/02/01 09:32:09 alschult Exp $
###############################################################################

# Quick Start:
#
# USAGE: 
# xmd -tcl genace.tcl [-opt <genace options file>] [-jprog]  [-target <target type>] 
# [-hw <bitstream>] [-elf <Elf Files>] [-data <Data files>] [-board <board type>] -ace <ACE file>
#
#
# Note: 
# This script has been tested for ML300 V2P4/7,Memec V2P4/7 boards and Microblaze Demo Board
# For other boards, the options that may have to be modified below are :
# "xmd_options", "jtag_fpga_position" and "jtag_devices" 
#
# Raj: Added Boards ML401, ML402 and ML403


set usage "\nUSAGE:\nxmd -tcl genace.tcl \[-opt <genace options file>\] \[-jprog\] \[-target <target type>\] \[-hw <bitstream>\] \[-elf {ELF files}\]  \[-data <Data files>\] \[-board <target board>\] -ace <output ACE file>\n\n\
\t<target type>  - \[ppc_hw|mdm\]\n\
\t\[bitstream\]    - bit/svf file\n\
\t\[ELF files\]    - elf/svf files\n\
\t\[Data files\]   - data/svf files\n\
\t<target board> - \[ml300|memec|mbdemo|auto\]\n\
\t\tml300  -> Virtex2P7 device\n\
\t\tml401  -> Virtex4Lx25 device\n\
\t\tml402  -> Virtex4Sx35 device\n\
\t\tml403  -> Virtex4Fx12 device\n\
\t\tmemec  -> Virtex2P4 device with P160\n\
\t\tmbdemo -> Virtex21000 device\n\
\t\tauto   -> Auto Detect Scan Chain. Board should be connected\n\
\t\tuser   -> User Specified Config parameters\n\n"


# Setting some default options
set param(board) "ml300"
set param(target) "ppc_hw"
set param(hw) ""
set param(sw) [list]
set param(data) [list]
set param(ace) ""
set param(jprog) "false"
set param(xmd_options) ""
set param(jtag_fpga_position) 1
set param(jtag_devices) ""
set param(configdevice) [list]
set param(debugdevice) ""

# Setting some board specific options
set ml300(xmd_options) "-configdevice devicenr 1 idcode 0x123e093 irlength 10 partname xc2vp7 -debugdevice devicenr 1 cpunr 1"
set ml300(jtag_fpga_position) 1
set ml300(jtag_devices) "xc2vp7"

set memec(xmd_options) "-configdevice devicenr 1 irlength 8 partname xc18v04 -configdevice devicenr 2 irlength 8 partname xc18v04 -configdevice devicenr 3 idcode 0x123E093 irLength 10 partname xc2vp4 -debugdevice devicenr 3 cpunr 1"
set memec(jtag_fpga_position) 3
set memec(jtag_devices) "xc18v04 xc18v04 xc2vp4"

set mbdemo(xmd_options) "-configdevice devicenr 1 idcode 0x1028093 irlength 6 partname xc2v1000 -debugdevice devicenr 1 cpunr 1"
set mbdemo(jtag_fpga_position) 1
set mbdemo(jtag_devices) "xc2v1000"

# Production ML403
set ml403(xmd_options) "-configdevice devicenr 1 idcode 0x05059093 irlength 16 partname xcf32p -configdevice devicenr 2 idcode 0x01E58093 irlength 10 partname xc4vfx12 -configdevice devicenr 3 idcode 0x09608093 irlength 8 partname xc95144xl -debugdevice devicenr 2 cpunr 1"
set ml403(jtag_fpga_position) 2
set ml403(jtag_devices) "xcf32p xc4vfx12 xc95144xl"

# Production ML402
set ml402(xmd_options) "-configdevice devicenr 1 idcode 0x05059093 irlength 16 partname xcf32p -configdevice devicenr 2 idcode 0x02088093 irlength 10 partname xc4vsx35 -configdevice devicenr 3 idcode 0x09608093 irlength 8 partname xc95144xl -debugdevice devicenr 2 cpunr 1"
set ml402(jtag_fpga_position) 2
set ml402(jtag_devices) "xcf32p xc4vsx35 xc95144xl"

# Production ML401
set ml401(xmd_options) "-configdevice devicenr 1 idcode 0x05059093 irlength 16 partname xcf32p -configdevice devicenr 2 idcode 0x0167C093 irlength 10 partname xc4vlx25 -configdevice devicenr 3 idcode 0x09608093 irlength 8 partname xc95144xl -debugdevice devicenr 2 cpunr 1"
set ml401(jtag_fpga_position) 2
set ml401(jtag_devices) "xcf32p xc4vlx25 xc95144xl"

#
#
# Detailed description of the genace.tcl script :
#
#
# This script works in xmd (EDK3.2 or later) and generates a SystemACE file
# from a bitstream and one or more PowerPC software(ELF) program or Data Files.
#
# The main steps in generating the SystemACE file are :
#   1. Converting a bitstream into an SVF file using iMPACT
#         The SVF file contains the sequence of JTAG instructions 
#         used to configure the FPGA and bring it up. (Done pin going high)
#      NOTE: 
#         In order to create a valid SVF file, the JTAG chain of the 
#         board has to be specified correctly in the "jtag_fpga_position",
#         and "jtag_devices" options at the beginning of this script.
# 
#   2. Converting executables into SVF files using XMD
#         This SVF file contains the JTAG sequence used by XMD to
#         download the ELF executable to internal/external memory
#         through the JTAG debug port of the PowerPC on the Virtex2Pro or
#         through the MDM debug port of Microblaze
#      NOTE: 
#         (i) This step assumes that the FPGA was configured with a 
#         bitstream containing a PowerPC/Microblaze hardware system in which
#         the JTAG debug port has been connected to the FPGA JTAG pins 
#         using the JTAGPPC or Microblaze hardware system with opb_mdm.
#         (ii) In order to create a valid SVF file, 
#         the position of the PowerPC/Microblaze and the JTAG chain of 
#         the board has to be specified correctly in the 
#         "xmd_options" at the beginning of this script. Refer the 
#         XMD documentation for more information about these options.
#             NOTE on NOTE: 
#                These options could be used to create ACE files that would 
#                directly write to PPC I/DCaches, etc
#   3. Converting data/binary into SVF files using XMD
#   4. Concatenating the SVF files from step 1 and 2
#   5. Generating a SystemACE file from the combined SVF file using iMPACT
#
# IMPORTANT NOTE: 
#   The JTAG chain options for step 1,2 and 3 have to be specified based on 
#   the relative position of each device in the JTAG chain from 
#   the SystemACE controller.
#


#######################################################################
#  Procedures to convert bit->svf, elf->svf, data->svf  and svf->ave
#######################################################################

proc impact_bit2svf { bitfile jtag_fpga_position jtag_devices } {

    set svffile "[file rootname $bitfile].svf"
    set script [open "bit2svf.scr" "w"]
    puts $script "setmode -bs"
    puts $script "setCable -p svf -file $svffile"
    
    set devicePos 0
    foreach device $jtag_devices {
	incr devicePos 
	if { $devicePos != $jtag_fpga_position } {
	    puts $script "addDevice -p $devicePos -part $device"
	} else {
	    puts $script "addDevice -p $jtag_fpga_position -file $bitfile"
	}
    }
    puts $script "program -p $jtag_fpga_position"
    puts $script "quit"
    close $script

    puts "\n############################################################"
    puts "Converting Bitstream '$bitfile' to SVF file '$svffile'"
    puts "Executing 'impact -batch bit2svf.scr'"
    if { [catch {exec impact -batch bit2svf.scr} msg] } {
	if { ![string match "*Programmed successfully.*" $msg] } {
	    puts $msg
	    error "ERROR in SVF file generation"
	}
    }
    return
}

proc xmd_elf2svf { target_type elffile xmd_options } {
    set svffile "[file rootname $elffile].svf"
    puts "\n############################################################"
    puts "Converting ELF file '$elffile' to SVF file '$svffile'"

    set tgt 0
    if { $target_type == "ppc_hw" } {
	set a "xconnect ppc hw -cable type xilinx_svffile fname $svffile $xmd_options"
    } else {
	set a "xconnect mb mdm -cable type xilinx_svffile fname $svffile $xmd_options"
    }
    # puts "$a\n"
    if { [catch {set tgt [eval $a]} retval] } {
	puts "$retval"
	error "ERROR: Unable to create SVF file '$svffile' for ELF file : $elffile"
    }
    #puts "xconnect Done..\n\n"
# doing a reset here is not advisable as the processor is already up and running correctly,
# and the ddr will not havve enough time to come out of reset properly before data gets written to it
#    xreset $tgt

    xdownload $tgt $elffile
    #puts "xdownload Done.. \n\n"

    # Fix for PowerPC CPU errata 212/213 on Virtex4. Causes erroneous data to be loaded when data
    # cache is loaded. Workaround is to set 1 and 3 bits of CCR0 
    if { $target_type == "ppc_hw" } {
	xwreg $tgt 68 0x50700000
    }

    xdisconnect $tgt
    #puts "xdisconnect Done..\n\n"
    return
}

proc xmd_data2svf { target_type dfile load_addr xmd_options } {
    set svffile "[file rootname $dfile].svf"
    puts "\n############################################################"
    puts "Converting Data file '$dfile' to SVF file '$svffile'"

    set tgt 0
    if { $target_type == "ppc_hw" } {
	set a "xconnect ppc hw -cable type xilinx_svffile fname $svffile $xmd_options"
    } else {
	set a "xconnect mb mdm -cable type xilinx_svffile fname $svffile $xmd_options"
    }
    # puts "$a\n"
    if { [catch {set tgt [eval $a]} retval] } {
	puts "$retval"
	error "ERROR: Unable to create SVF file '$svffile' for Data file : $dfile"
    }
    #puts "xconnect Done..\n\n"
    xreset $tgt

    xdownload $tgt -data $dfile $load_addr
    #puts "xdownload Done.. \n\n"
    xdisconnect $tgt
    #puts "xdisconnect Done..\n\n"
    return
}

proc write_swsuffix { target_type elffile xmd_options } {
    set svffile "[file rootname $elffile].svf"
    puts "\n############################################################"
    puts "Writing Processor JTAG \"continue\" command to SVF file '$svffile'"

    set tgt 0
    if { $target_type == "ppc_hw" } {
	set a "xconnect ppc hw -cable type xilinx_svffile fname $svffile $xmd_options"
    } else {
	set a "xconnect mb mdm -cable type xilinx_svffile fname $svffile $xmd_options"
    }
    if { [catch {set tgt [eval $a]} retval] } {
	puts "$retval"
	error "ERROR: Unable to create SVF file '$svffile' for ELF file : $elffile"
    }
    xcontinue $tgt -quit 
    xdisconnect $tgt
    return
}

proc impact_svf2ace { acefile } {
    set svffile "[file rootname $acefile].svf"
    set script [open "svf2ace.scr" "w"]
    puts $script "svf2ace -wtck -d -m 16776192 -i $svffile -o $acefile"
    puts $script quit
    close $script
    
    puts "\n############################################################"
    puts "Converting SVF file '$svffile' to SystemACE file '$acefile'"    
    puts "Executing 'impact -batch svf2ace.scr'"
    catch {exec impact -batch svf2ace.scr}
    return
}

proc write_swprefix { svffile } {
    puts $svffile "
//======================================================= 
// proghdr.svf 
// 
STATE RESET IDLE; 
//RUNTEST 100000 TCK; 
// We need 1 second of reset here to let the DDR2 controller reset in peace
// SystemACE does not support RUNTEST sequences longer than 20000000 TCK,
// so we split it in several sequences
RUNTEST 10000000 TCK; 
RUNTEST 10000000 TCK; 
RUNTEST 10000000 TCK; 
RUNTEST  5000000 TCK; 
HIR 0 ; 
HDR 0 ; 
TIR 0 ; 
TDR 0 ; 
// start ELF downloading here 
//======================================================="
    return
}

proc write_hwprefix { svffile use_jprog fpga_irlength } {
    puts $svffile "
//======================================================= 
// Initial JTAG Reset
// 
HIR 0 ; 
TIR 0 ; 
TDR 0 ; 
HDR 0 ; 
STATE RESET IDLE; 
//======================================================="
    if { $fpga_irlength <= 5 } {
	return 
    }
    if { $use_jprog == "true" } {
	switch -- $fpga_irlength {
	    6 {
		set jprog 0b
		set smask 3f
	    }
	    10 {
		set jprog 3cb
		set smask 3ff
	    }
	    14 {
		set jprog 3fcb
		set smask 3fff
	    }
	}
	puts $svffile "
// For runtime reconfiguration, using 'jprog_b' instruction
// Loading device with 'jprog_b' instruction. 
SIR $fpga_irlength TDI ($jprog) SMASK ($smask) ; 
RUNTEST 1000 TCK ;
// end of jprog_b 
// NOTE - The following delay will have to be modified in genace.tcl 
//        for non-ML300, non-xc2vp7 devices. The frame information is
//        available in <Device> user guide (Configration Details)
// Send into bypass and idle until program latency is over 
//   4 us per frame.  XC2VP7 is 1320 frames = 5280 us 
//   @maximum TCK freq 33 MHz = 174240 cycles 
// Setting it to max value.. XC2VP100 = 3500 frames
SIR $fpga_irlength TDI ($smask) SMASK ($smask) ; 
RUNTEST 462000 TCK ; 
//======================================================="
    }
    return
}


proc write_prefix { svffile argv } {
    puts $svffile "
//======================================================= 
//======================================================= 
//  SVF file automatically created using XMD + genace.tcl
//  Commandline : xmd genace.tcl $argv
//  Date/Time : [clock format [clock seconds]]
//======================================================= 
//======================================================= 
"
    return
}


#######################################################################
#  Procedure to automatically generate the jtag options, 
#  by scanning the jtag chain, uses tcljtag.tcl commands
#######################################################################
proc gen_jtag_options { } {
    global param

    # Reduce verbocity level from 3->1
    jtag_debug 1

    # Open the jtag cable
    set handle [jtag_open]
    if {$handle == ""} {
	error "Could not open JTAG Cable. Check board connection."
    }
    
    # Get an exclusive lock
    if {[jtag_lock $handle 5000] == 0} {
	error "Could not lock JTAG Cable"
    }

    # Autodetect the jtag chain and attempt to assign
    # idcodes and irlengths
    set chain [jtag_autodetect $handle]
    # puts $chain

    if {[llength $chain] == 0} {
	error "JTAG Cable Scan Chain.."
    }

    set count 0
    set debug_device -1
    foreach device $chain {
	set idcode [lindex $device 0]
	if {[string length $idcode] == 10} {
	    set idcode [string replace $idcode 2 2]
	}
	# Check if the device is System ACE
	if {[string match -nocase "0xA001093" $idcode]} {
	    continue
	}
	incr count

	# Check for UNKNOWN Device. 
	set irlength [lindex $device 2]
	if {$irlength == "UNKNOWN"} {
	    error "Device:$count ($idcode) UNKNOWN device.IR Length must be assigned manually.\
                   ** Refer XMD section of EST guide for details **"
	}

	# Try to figure out the FPGA device - JTAGCableInterface.cpp
	if { $debug_device == -1 } {
	    if { $irlength == 5 || $irlength == 6 || $irlength == 10 || $irlength == 14 || $irlength == 22 } {
		set debug_device $count
		set debug_device_name [lindex $device 1]
	    }
	}

	set configdevice_option "-configdevice devicenr $count idcode $idcode irlength [lindex $device 2] partname [lindex $device 1]"
	# There shld be a better way to do this !!
	if { [llength $param(configdevice)] == 0 } {
	    set param(configdevice) [concat $param(configdevice) $configdevice_option]
	} else {
	    set param(configdevice) [list $param(configdevice) $configdevice_option]
	}
	set param(xmd_options) [concat $param(xmd_options) $configdevice_option]
	set param(jtag_devices) [concat $param(jtag_devices) "[lindex $device 1]"]
    }


    if { $debug_device == -1 } {
	error "Device containing PowerPC/Microblaze system not found !!!"
    }

    puts "Assuming Device $debug_device ($debug_device_name) contains PowerPC/Microblaze system\n"
    set param(xmd_options) [concat $param(xmd_options) "-debugdevice devicenr $debug_device cpunr 1"]
    set param(debugdevice) [concat $param(debugdevice) "-debugdevice devicenr $debug_device cpunr 1"]
    set param(jtag_fpga_position) $debug_device

    #puts "xmd_options        : $param(xmd_options)"
    #puts "jtag_fpga_position : $debug_device"
    #puts "jtag_devices       : $param(jtag_devices)"

    # Release the exclusive lock
    jtag_unlock $handle

    # Close the connection
    jtag_close $handle
    return
}


#######################################################################
#  Procedure to generate the ACE file from .bit and .elf
#######################################################################
proc genace { } {
    global param ml300 memec mbdemo
    global ml401 ml402 ml403
    global argv
    
    set acefile $param(ace)
    set final_svf [open "[file rootname $acefile].svf" "w"]

    write_prefix $final_svf $argv

    set board $param(board)
    if { [string match $board "auto"] || [string match $board "user"]} {
	# auto - get the board config information
	# user - get the board config information from user
	set xmd_options $param(xmd_options)
	set jtag_fpga_position $param(jtag_fpga_position)
	set jtag_devices $param(jtag_devices)
    } else {
	set xmd_options [lindex [array get $board "xmd_options"] 1]
	set jtag_devices [lindex [array get $board "jtag_devices"] 1]
	set jtag_fpga_position [lindex [array get $board "jtag_fpga_position"] 1]
    }

    # Get the irLength of FPGA.
    set options_list [concat $xmd_options]
    set index $jtag_fpga_position
    set i 1
    while { $i < [llength $options_list] } {
	if {[string match -nocase "-configdevice" [lindex $options_list $i]]} {
	    incr i 
	    continue
	}
	if {[string match -nocase "irlength" [lindex $options_list $i]]} {
	    incr index -1
	    if { $index == 0 } {
		set fpga_irlength [lindex $options_list [expr $i+1]]
		break
	    }
	}
	incr i 2
    }
    if { $index > 0 } {
	error "Cannot find FPGA Instr Register Length.. Please check your JTAG options"
    }
    #puts "FPGA irlength : $fpga_irlength"

    # Convert bit->svf file
    set bitfile $param(hw)
    if { $bitfile != "" } {
	if { ![file readable $bitfile] } {
	    error "Unable to open Bitstream file : $bitfile"
	}

	write_hwprefix $final_svf $param(jprog) $fpga_irlength
	if { ![string match "[file extension $bitfile]" ".svf"] } {
	    # Generate the .svf file for .bit file
	    impact_bit2svf $bitfile $jtag_fpga_position $jtag_devices
	}
	set bitsvf [open "[file rootname $bitfile].svf" "r"]
	puts "\nCopying [file rootname $bitfile].svf File to \
	    [file rootname $acefile].svf File\n" 
	fcopy $bitsvf $final_svf
	close $bitsvf
    }

    # Convert data->svf files
    set data_files $param(data)
    if { [llength $data_files] > 0 } {
	write_swprefix $final_svf
	set i 0
	while { $i < [llength $data_files] } {
	    set dfile [lindex $data_files $i]
	    set laddr [lindex $data_files [incr i 1]]
	    incr i 1
	    if { ![file readable $dfile] } {
		error "Unable to open data file : $dfile"
	    }

	    if { ![string match "[file extension $dfile]" ".svf"] } {
		# Generate the .svf file for data file
		xmd_data2svf $param(target) $dfile $laddr $xmd_options
	    }
	    set datasvf [open "[file rootname $dfile].svf" "r"]
	    puts $final_svf "\n// Starting Download of Data file : $dfile\n"
	    puts "\nCopying [file rootname $dfile].svf File to \
	    [file rootname $acefile].svf File\n" 
	    fcopy $datasvf $final_svf
	    close $datasvf
	}
    }

    # Convert elf->svf files.
    set elf_files $param(sw)
    if { [llength $elf_files] > 0 } {
	write_swprefix $final_svf
	foreach elf $elf_files { 
	    if { ![file readable $elf] } {
		error "Unable to open executable file : $elf"
	    }

	    if { ![string match "[file extension $elf]" ".svf"] } {
		# Generate the .svf file for .elf file
		xmd_elf2svf $param(target) $elf $xmd_options
	    }
	    set elfsvf [open "[file rootname $elf].svf" "r"]
	    puts $final_svf "\n// Starting Download of ELF file : $elf\n"
	    puts "\nCopying [file rootname $elf].svf File to \
	    [file rootname $acefile].svf File\n" 
	    fcopy $elfsvf $final_svf
	    close $elfsvf
	}
        write_swsuffix $param(target) "sw_suffix.elf" $xmd_options
	# Generate code to execute the program downloaded
	set suffixsvf [open "sw_suffix.svf" "r"]
	puts $final_svf "\n// Issuing Run command to PowerPC to start execution\n"
	fcopy $suffixsvf $final_svf
	close $suffixsvf
    }
    close $final_svf
    impact_svf2ace $acefile

    puts "\nSystemACE file '$acefile' created successfully"
    return
}

#######################################################################
# Proc to parse genace option file options
#######################################################################
proc parse_genace_optfile { optfilename } {
    global param

    if { ![file readable $optfilename] } {
	error "Unable to open GenACE option file : $optfilename"
    }
    set optfile [open "$optfilename" "r"]
    puts "Using GenACE option file : $optfilename"

    set debugdevice 1
    set configdevice 1
    while { [gets $optfile optline] != -1 } {
	set llist [concat $optline]
	set genace_opt [lindex $llist 0]
	switch -- $genace_opt {
	    -jprog {
		set param(jprog) "true"
	    }
	    -target {
		set param(target) [lindex $llist 1]
	    }
	    -hw {
		set param(hw) [lindex $llist 1]
	    }
	    -elf {
		set param(sw) [concat $param(sw) [lrange $llist 1 end]]
	    }
	    -data {
		set param(data) [concat $param(data) [lrange $llist 1 end]]
	    }
	    -board {
		set param(board) [lindex $llist 1]
	    }
	    -ace {
		set param(ace) [lindex $llist 1]
	    }
	    -configdevice {
		set param(xmd_options) [concat $param(xmd_options) $llist]
		set i 1
		while { $i < [llength $llist] } {
		    if {[string match -nocase "partname" [lindex $llist $i]]} {
			set param(jtag_devices) [concat $param(jtag_devices) [lindex $llist [expr $i+1]]]
			break
		    }
		    incr i 2
		}
		if { $i >= [llength $llist] } {
		    error "Device partname not specifed in -configdevice option"
		}
		set configdevice 0
	    }
	    -debugdevice {
		set param(xmd_options) [concat $param(xmd_options) $llist]
		set i 1
		while { $i < [llength $llist] } {
		    if {[string match -nocase "devicenr" [lindex $llist $i]]} {
			set param(jtag_fpga_position) [lindex $llist [expr $i+1]]
			break
		    }
		    incr i 2
		}
		if { $i >= [llength $llist] } {
		    error "Device number to debug not specifed in -debugdevice option"
		}
		set debugdevice 0
	    }
	    default {
		error "Unknown option"
	    }
	}
    }
    close $optfile

    if { [string match -nocase $param(board) "user"] && [expr $configdevice || $debugdevice]} {
	error "\[-board user\] option missing either -configdevice or -debugdevice options"
    }
    
    #puts "\nxmd_options        : $param(xmd_options)"
    #puts "jtag_fpga_position : $param(jtag_fpga_position)"
    #puts "jtag_devices       : $param(jtag_devices)"

    return
}

#######################################################################
# Proc to write genACE options file
#######################################################################
proc write_genace_opt { } {
    global param 

    set optfile [open "genace.opt" "w"]

    if { [string match $param(jprog) "true"] } {
	puts $optfile "-jprog"
    }
    puts $optfile "-target $param(target)"
    if {$param(hw) != ""} {
	puts $optfile "-hw $param(hw)"
    }
    if {[llength $param(sw)] != 0} {
	puts $optfile "-elf $param(sw)"
    }
    if {[llength $param(data)] != 0} {
	puts $optfile "-data $param(data)"
    }
    puts $optfile "-ace $param(ace)"
    puts $optfile "-board user"
    set i 0
    while {$i < [llength $param(configdevice)]} {
	puts $optfile [lindex $param(configdevice) $i]
	incr i
    }
    puts $optfile $param(debugdevice)

    close $optfile
    return
}

#######################################################################
# Proc to parse genace commandline options
#######################################################################
proc parse_genace_options {optc optv} {
    global param

    if {[string match -nocase "-opt" [lindex $optv 0]]} {
	if { [catch {parse_genace_optfile [lindex $optv 1]} err] } {
	    error "(OptFile) $err"
	}	    
	return
    }

    for {set i 0} { $i < $optc } { incr i } {
	set arg [lindex $optv $i]
	switch -- $arg {
	    -jprog { 
		set param(jprog) "true"
	    }
	    -target  {
		incr i
		# No check done !!
		set param(target) [lindex $optv $i] 
	    }
	    -hw  {
		incr i
		set param(hw) [lindex $optv $i]
	    }
	    -elf {
		incr i
		set next_option_index [lsearch [lrange $optv $i end] "-*"]
		if {$next_option_index == -1 } {
		    set next_option_index $optc
		} else {
		    incr next_option_index $i
		}

		while {$i < $next_option_index} {
		    set param(sw) [concat $param(sw) [lindex $optv $i]]
		    incr i
		}
		# go back one arg as outer loop would "incr i" too
		incr i -1 
	    }
	    -data {
		incr i
		set next_option_index [lsearch [lrange $optv $i end] "-*"]
		if {$next_option_index == -1 } {
		    set next_option_index $optc
		} else {
		    incr next_option_index $i
		}
		if { [expr ($next_option_index - $i)%2] != 0 } {
		    error "Missing load address for data file"
		}

		while {$i < $next_option_index} {
		    set param(data) [concat $param(data) [lrange $optv $i [incr i]]]
		    incr i
		}
		# go back one arg as outer loop would "incr i" too
		incr i -1 
	    }
	    -board {
		incr i
		set param(board) [lindex $optv $i]
	    }
	    -ace {
		incr i
		set param(ace) [lindex $optv $i]
	    }
	    default {
		error "Unknown option $arg"
	    }
	}
    }
    return
}

#######################################################################
# Start GenACE 
#######################################################################

puts "\n#######################################################################"
puts "XMD GenACE utility. Generate SystemACE File from bit/elf/data Files"
puts "#######################################################################"

# Platform Check
set platform [lindex [array get tcl_platform os] 1]
if { [string match -nocase $platform "SunOS"] } {
    puts "\nERROR : Solaris platform NOT supported by GenACE Utility"
    return
}

if { [catch {parse_genace_options $argc $argv} err] } {
    puts "\nCmdline Error: $err"
    puts $usage
    return
}

# Check if either -elf or -hw options are specified 
if { [llength $param(sw)] == 0 && [llength $param(data)] == 0 && $param(hw) == "" } {
    puts "\nERROR : Either a hw bitstream or sw ELF/data file should be provided to generate the ACE file"
    puts $usage
    return
}

# Check if -ace option has beeb specified
if { $param(ace) == "" } {
    puts "\nERROR : An output ACE file should be specified using the -ace option"
    puts $usage
    return
}

# Check Filenames. BIT/ELF/Data filename prefix should not match ACE filename prefix
set ace_prefix [file rootname $param(ace)]
set flist [concat $param(hw) $param(sw) $param(data)]
foreach filename $flist {
    set fname_prefix [file rootname $filename]
    if { [string match $ace_prefix $fname_prefix] } {
	puts "\nERROR : Output ACE File($param(ace)) & I/P $filename have same Filename prefix \"$ace_prefix\""
	puts "ERROR : Please provide a different ACE file name\n"
	return
    }    
}

puts "GenACE Options:"
puts "\tBoard      : $param(board)"
puts "\tTarget     : $param(target)"
puts "\tElf Files  : $param(sw)"
puts "\tData Files : $param(data)"
puts "\tHW File    : $param(hw)"
puts "\tACE File   : $param(ace)"
puts "\tJPROG      : $param(jprog)"

if { [string match $param(board) "auto"] } {
    # auto - get the board config information
    puts "\nBoard \"auto\" - Generating GenACE JTAG Options for the board"
    set xilinx_edk_path [lindex [array get env XILINX_EDK] 1]
    set tcljtag_script [file join $xilinx_edk_path "data" "xmd" "tcljtag.tcl"]
    if { [file exists $tcljtag_script] } {
	#puts "Executing TCLJTAG script : $tcljtag_script"
	if { [catch {source $tcljtag_script} err] } {
	    puts "ERROR : Unable to load libTcljtag10.dll for detection of JTAG devices"
	    return
	}
    } else {
	puts "ERROR: Could not find $tcljtag_script.\n"
	puts "ERROR: Check EDK Installation or XILINX_EDK Path Variable\n"
	return
    }

    if { [catch {gen_jtag_options} err] } {
	puts "ERROR \[Scan Chain\]: $err"
	return
    }

    write_genace_opt
    puts "GenACE options written to genace.opt File.\
          Use genace.opt for SystemACE generation for this System\n"
}

if { [catch {genace} err] } {
    puts "Error: $err"
    return
}


