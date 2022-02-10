# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_static_text $IPINST -name "This IP core is supported on BoardRev1" -parent ${Page_0} -text {This IP core is supported on ADC4C16G-4 Board, and the board verion is BoardVer1.}

  ipgui::add_param $IPINST -name "CHANNEL_SEL" -widget comboBox

}

proc update_PARAM_VALUE.CHANNEL_SEL { PARAM_VALUE.CHANNEL_SEL } {
	# Procedure called to update CHANNEL_SEL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CHANNEL_SEL { PARAM_VALUE.CHANNEL_SEL } {
	# Procedure called to validate CHANNEL_SEL
	return true
}


proc update_MODELPARAM_VALUE.CHANNEL_SEL { MODELPARAM_VALUE.CHANNEL_SEL PARAM_VALUE.CHANNEL_SEL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CHANNEL_SEL}] ${MODELPARAM_VALUE.CHANNEL_SEL}
}

