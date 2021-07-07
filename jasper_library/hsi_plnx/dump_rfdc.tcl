proc dump_rfdc {xsa} {

  hsi::open_hw_design $xsa
  foreach ip [hsi::get_cells -filter {IS_PL==1}] {
      if {[common::get_property IP_NAME [hsi::get_cells $ip]] == "usp_rf_data_converter"} {
          common::report_property [hsi::get_cells $ip] > dump_rfdc.txt
      }
  }
  hsi::close_hw_design [hsi::current_hw_design]
}

proc rfdc_prop_list {} {
  set prop_list ""
  foreach ip [hsi::get_cells -filter {IS_PL==1}] {
      if {[common::get_property IP_NAME [hsi::get_cells $ip]] == "usp_rf_data_converter"} {
          set prop_list [common::report_property -return_string [hsi::get_cells $ip]]
      }
  }
  return $prop_list
}

proc get_rfdc_clks {} {
  set rfdc [hsi::get_cells usp_rf_data_converter_0]
  set clk_pins [hsi::get_pins -of_objects [hsi::get_cells -hier $rfdc] -filter {TYPE==clk&&DIRECTION==I}]
  return $clk_pins
}

proc rfdc_dts_info {xsa ofile} {

  hsi::open_hw_design $xsa
  set prop [rfdc_prop_list]
  set clks [get_rfdc_clks]
  set out "${prop}\nDT.CLOCKS ${clks}"
  set dts_outfile [open $ofile w+]
  puts $dts_outfile $out
  close $dts_outfile
  hsi::close_hw_design [hsi::current_hw_design]
}
