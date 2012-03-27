#!/usr/bin/tclsh

###### Function to rewrite a piece of code as a self-writing TCL source file ######
proc rewrite_file {in_file out_file dest_file} {

	if [catch {set infile [open $in_file r]}] {
		puts "ERROR: Cannot open file \"$in_file\" for reading"
		exit
	}
 	if [catch {set outfile [open "${out_file}" w]}] {
		puts "ERROR: Cannot open file \"${out_file}\" for writing"
		exit	
	}

	puts $outfile "set output_file \[open \"$dest_file\" w \]"

	set line_num 0
	while {![eof $infile]} {
		set line [gets $infile]
		incr line_num
		if [regexp "^ *!TCL!(.*)$" $line temp tcl_line] {
			puts $outfile "set line_num $line_num; $tcl_line"
		} else {
			regsub -all {\\} $line {\\\\} line
			regsub -all {\"} $line {\\"} line
			regsub -all {\[} $line {\\[} line
			regsub -all {\]} $line {\\]} line
			puts $outfile "set line_num $line_num; puts \$output_file \"$line\""
		}
	}

	puts $outfile "close \$output_file"

	close $infile
	close $outfile

}

###### Functions to compare two file names ######
proc comp_fname {file1 file2} {
	return [expr 1-[regexp ^.*parameter.vhd$ $file1 $file2]]
}

###### Main flow ######

# first arguement is the initialization file name
set init_file [lindex $argv 0]
if {![file exist $init_file]} {
	puts "ERROR: Cannot find file \"$init_file\""
	exit
}
if {![regexp {^(.*)\.ini$} $init_file tmp project_name]} {
	puts "ERROR: init file name should be formatted as : <project_name>.ini"
	exit
}

puts "Reading init file \"${init_file}\""

if {[catch {source $init_file} err_result]} {
	puts "ERROR: syntax error in the init file : $err_result"
	exit
}

# open template source files, and rewrite them
set src_files [glob -nocomplain [file join hdl verilog "*.tcl"]]
puts "Rewriting verilog source files :"
foreach file $src_files {
	puts "\t$file"

	set out_file [file join tmp "[file tail ${file}].tcl"]
	set dest_file [file rootname ${file}]

	rewrite_file $file $out_file $dest_file

	set line_num 0

	if [catch {source ${out_file}} err_result] {
		puts "ERROR: $out_file : line $line_num : $err_result"
		exit
	}
}

# open template IP data files, and rewrite them
set src_files [glob -nocomplain [file join data "*.tcl"]]
puts "Rewriting IP data files :"
foreach file $src_files {
	puts "\t$file"

	set out_file [file join tmp "[file tail ${file}].tcl"]
	set dest_file [file rootname ${file}]

	rewrite_file $file $out_file $dest_file

	set line_num 0

	if [catch {source ${out_file}} err_result] {
		puts "ERROR: $file : line $line_num : $err_result"
		exit
	}
}
