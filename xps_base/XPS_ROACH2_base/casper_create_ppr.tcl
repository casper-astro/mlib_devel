# Procedure to make sure given file exists
proc must_exist_or_die {filename} {
  if {![file exist $filename]} {
    error "could not find $filename"
  }
}

must_exist implementation/system.ngc
must_exist implementation/system.ncd
must_exist implementation/system.ucf
must_exist implementation/system.twr

# Get project name via `git describe`
if {[catch {exec git describe --always --dirty} proj_name]} {
  error {could not run "git describe" to get project name}
}
puts "project name is $proj_name"

set proj_dir [file normalize [file join [info script] {../../planahead}]]
puts "project dir is $proj_dir"

create_project -force $proj_name $proj_dir -part xc6vsx475tff1759-1
set_property design_mode GateLvl [current_fileset]
set_property edif_top_file implementation/system.ngc [current_fileset]
add_files -norecurse {implementation pcores}
import_files -fileset constrs_1 -force -norecurse implementation/system.ucf
import_as_run -run impl_1 -twx implementation/system.twx implementation/system.ncd
#open_run impl_1
close_project
