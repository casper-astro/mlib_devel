# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  ipgui::add_page $IPINST -name "Page 0"


}

proc update_PARAM_VALUE.DID_INVERT_VECTOR { PARAM_VALUE.DID_INVERT_VECTOR } {
	# Procedure called to update DID_INVERT_VECTOR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DID_INVERT_VECTOR { PARAM_VALUE.DID_INVERT_VECTOR } {
	# Procedure called to validate DID_INVERT_VECTOR
	return true
}

proc update_PARAM_VALUE.DI_INVERT_VECTOR { PARAM_VALUE.DI_INVERT_VECTOR } {
	# Procedure called to update DI_INVERT_VECTOR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DI_INVERT_VECTOR { PARAM_VALUE.DI_INVERT_VECTOR } {
	# Procedure called to validate DI_INVERT_VECTOR
	return true
}

proc update_PARAM_VALUE.DQD_INVERT_VECTOR { PARAM_VALUE.DQD_INVERT_VECTOR } {
	# Procedure called to update DQD_INVERT_VECTOR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DQD_INVERT_VECTOR { PARAM_VALUE.DQD_INVERT_VECTOR } {
	# Procedure called to validate DQD_INVERT_VECTOR
	return true
}

proc update_PARAM_VALUE.DQ_INVERT_VECTOR { PARAM_VALUE.DQ_INVERT_VECTOR } {
	# Procedure called to update DQ_INVERT_VECTOR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DQ_INVERT_VECTOR { PARAM_VALUE.DQ_INVERT_VECTOR } {
	# Procedure called to validate DQ_INVERT_VECTOR
	return true
}

proc update_PARAM_VALUE.OR_INVERT_VECTOR { PARAM_VALUE.OR_INVERT_VECTOR } {
	# Procedure called to update OR_INVERT_VECTOR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.OR_INVERT_VECTOR { PARAM_VALUE.OR_INVERT_VECTOR } {
	# Procedure called to validate OR_INVERT_VECTOR
	return true
}


proc update_MODELPARAM_VALUE.DI_INVERT_VECTOR { MODELPARAM_VALUE.DI_INVERT_VECTOR PARAM_VALUE.DI_INVERT_VECTOR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DI_INVERT_VECTOR}] ${MODELPARAM_VALUE.DI_INVERT_VECTOR}
}

proc update_MODELPARAM_VALUE.DID_INVERT_VECTOR { MODELPARAM_VALUE.DID_INVERT_VECTOR PARAM_VALUE.DID_INVERT_VECTOR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DID_INVERT_VECTOR}] ${MODELPARAM_VALUE.DID_INVERT_VECTOR}
}

proc update_MODELPARAM_VALUE.DQ_INVERT_VECTOR { MODELPARAM_VALUE.DQ_INVERT_VECTOR PARAM_VALUE.DQ_INVERT_VECTOR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DQ_INVERT_VECTOR}] ${MODELPARAM_VALUE.DQ_INVERT_VECTOR}
}

proc update_MODELPARAM_VALUE.DQD_INVERT_VECTOR { MODELPARAM_VALUE.DQD_INVERT_VECTOR PARAM_VALUE.DQD_INVERT_VECTOR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DQD_INVERT_VECTOR}] ${MODELPARAM_VALUE.DQD_INVERT_VECTOR}
}

proc update_MODELPARAM_VALUE.OR_INVERT_VECTOR { MODELPARAM_VALUE.OR_INVERT_VECTOR PARAM_VALUE.OR_INVERT_VECTOR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.OR_INVERT_VECTOR}] ${MODELPARAM_VALUE.OR_INVERT_VECTOR}
}

