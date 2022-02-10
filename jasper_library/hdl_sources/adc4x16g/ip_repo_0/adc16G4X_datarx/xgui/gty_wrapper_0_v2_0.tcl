# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  ipgui::add_page $IPINST -name "Page 0"

  ipgui::add_param $IPINST -name "GTY_bank" -widget comboBox

}

proc update_PARAM_VALUE.GTY_bank { PARAM_VALUE.GTY_bank } {
	# Procedure called to update GTY_bank when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.GTY_bank { PARAM_VALUE.GTY_bank } {
	# Procedure called to validate GTY_bank
	return true
}


proc update_MODELPARAM_VALUE.GTY_bank { MODELPARAM_VALUE.GTY_bank PARAM_VALUE.GTY_bank } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.GTY_bank}] ${MODELPARAM_VALUE.GTY_bank}
}

