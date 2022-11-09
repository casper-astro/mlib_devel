# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "SR_EXT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "SR_INIT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "SR_LEN" -parent ${Page_0}
  ipgui::add_param $IPINST -name "SR_RST" -parent ${Page_0}


}

proc update_PARAM_VALUE.SR_EXT { PARAM_VALUE.SR_EXT } {
	# Procedure called to update SR_EXT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SR_EXT { PARAM_VALUE.SR_EXT } {
	# Procedure called to validate SR_EXT
	return true
}

proc update_PARAM_VALUE.SR_INIT { PARAM_VALUE.SR_INIT } {
	# Procedure called to update SR_INIT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SR_INIT { PARAM_VALUE.SR_INIT } {
	# Procedure called to validate SR_INIT
	return true
}

proc update_PARAM_VALUE.SR_LEN { PARAM_VALUE.SR_LEN } {
	# Procedure called to update SR_LEN when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SR_LEN { PARAM_VALUE.SR_LEN } {
	# Procedure called to validate SR_LEN
	return true
}

proc update_PARAM_VALUE.SR_RST { PARAM_VALUE.SR_RST } {
	# Procedure called to update SR_RST when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SR_RST { PARAM_VALUE.SR_RST } {
	# Procedure called to validate SR_RST
	return true
}


proc update_MODELPARAM_VALUE.SR_LEN { MODELPARAM_VALUE.SR_LEN PARAM_VALUE.SR_LEN } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SR_LEN}] ${MODELPARAM_VALUE.SR_LEN}
}

proc update_MODELPARAM_VALUE.SR_INIT { MODELPARAM_VALUE.SR_INIT PARAM_VALUE.SR_INIT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SR_INIT}] ${MODELPARAM_VALUE.SR_INIT}
}

proc update_MODELPARAM_VALUE.SR_RST { MODELPARAM_VALUE.SR_RST PARAM_VALUE.SR_RST } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SR_RST}] ${MODELPARAM_VALUE.SR_RST}
}

proc update_MODELPARAM_VALUE.SR_EXT { MODELPARAM_VALUE.SR_EXT PARAM_VALUE.SR_EXT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SR_EXT}] ${MODELPARAM_VALUE.SR_EXT}
}

