# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "G_CORE_FREQ_KHZ" -parent ${Page_0}
  ipgui::add_param $IPINST -name "G_EXT_CLK_FIFOS" -parent ${Page_0}
  ipgui::add_param $IPINST -name "G_FIFO_IMPLEMENTATION" -parent ${Page_0}
  ipgui::add_param $IPINST -name "G_FIFO_TYPE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "G_FPGA_FAMILY" -parent ${Page_0}
  ipgui::add_param $IPINST -name "G_FPGA_VENDOR" -parent ${Page_0}
  ipgui::add_param $IPINST -name "G_INC_ARP" -parent ${Page_0}
  ipgui::add_param $IPINST -name "G_INC_ETH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "G_INC_IPV4" -parent ${Page_0}
  ipgui::add_param $IPINST -name "G_INC_PING" -parent ${Page_0}
  ipgui::add_param $IPINST -name "G_NUM_OF_ARP_POS" -parent ${Page_0}
  ipgui::add_param $IPINST -name "G_RX_INPUT_PIPE_STAGES" -parent ${Page_0}
  ipgui::add_param $IPINST -name "G_RX_IN_FIFO_CAP" -parent ${Page_0}
  ipgui::add_param $IPINST -name "G_TX_EXT_ETH_FIFO_CAP" -parent ${Page_0}
  ipgui::add_param $IPINST -name "G_TX_EXT_IP_FIFO_CAP" -parent ${Page_0}
  ipgui::add_param $IPINST -name "G_TX_OUT_FIFO_CAP" -parent ${Page_0}
  ipgui::add_param $IPINST -name "G_UDP_CLK_FIFOS" -parent ${Page_0}


}

proc update_PARAM_VALUE.G_CORE_FREQ_KHZ { PARAM_VALUE.G_CORE_FREQ_KHZ } {
	# Procedure called to update G_CORE_FREQ_KHZ when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.G_CORE_FREQ_KHZ { PARAM_VALUE.G_CORE_FREQ_KHZ } {
	# Procedure called to validate G_CORE_FREQ_KHZ
	return true
}

proc update_PARAM_VALUE.G_EXT_CLK_FIFOS { PARAM_VALUE.G_EXT_CLK_FIFOS } {
	# Procedure called to update G_EXT_CLK_FIFOS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.G_EXT_CLK_FIFOS { PARAM_VALUE.G_EXT_CLK_FIFOS } {
	# Procedure called to validate G_EXT_CLK_FIFOS
	return true
}

proc update_PARAM_VALUE.G_FIFO_IMPLEMENTATION { PARAM_VALUE.G_FIFO_IMPLEMENTATION } {
	# Procedure called to update G_FIFO_IMPLEMENTATION when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.G_FIFO_IMPLEMENTATION { PARAM_VALUE.G_FIFO_IMPLEMENTATION } {
	# Procedure called to validate G_FIFO_IMPLEMENTATION
	return true
}

proc update_PARAM_VALUE.G_FIFO_TYPE { PARAM_VALUE.G_FIFO_TYPE } {
	# Procedure called to update G_FIFO_TYPE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.G_FIFO_TYPE { PARAM_VALUE.G_FIFO_TYPE } {
	# Procedure called to validate G_FIFO_TYPE
	return true
}

proc update_PARAM_VALUE.G_FPGA_FAMILY { PARAM_VALUE.G_FPGA_FAMILY } {
	# Procedure called to update G_FPGA_FAMILY when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.G_FPGA_FAMILY { PARAM_VALUE.G_FPGA_FAMILY } {
	# Procedure called to validate G_FPGA_FAMILY
	return true
}

proc update_PARAM_VALUE.G_FPGA_VENDOR { PARAM_VALUE.G_FPGA_VENDOR } {
	# Procedure called to update G_FPGA_VENDOR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.G_FPGA_VENDOR { PARAM_VALUE.G_FPGA_VENDOR } {
	# Procedure called to validate G_FPGA_VENDOR
	return true
}

proc update_PARAM_VALUE.G_INC_ARP { PARAM_VALUE.G_INC_ARP } {
	# Procedure called to update G_INC_ARP when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.G_INC_ARP { PARAM_VALUE.G_INC_ARP } {
	# Procedure called to validate G_INC_ARP
	return true
}

proc update_PARAM_VALUE.G_INC_ETH { PARAM_VALUE.G_INC_ETH } {
	# Procedure called to update G_INC_ETH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.G_INC_ETH { PARAM_VALUE.G_INC_ETH } {
	# Procedure called to validate G_INC_ETH
	return true
}

proc update_PARAM_VALUE.G_INC_IPV4 { PARAM_VALUE.G_INC_IPV4 } {
	# Procedure called to update G_INC_IPV4 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.G_INC_IPV4 { PARAM_VALUE.G_INC_IPV4 } {
	# Procedure called to validate G_INC_IPV4
	return true
}

proc update_PARAM_VALUE.G_INC_PING { PARAM_VALUE.G_INC_PING } {
	# Procedure called to update G_INC_PING when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.G_INC_PING { PARAM_VALUE.G_INC_PING } {
	# Procedure called to validate G_INC_PING
	return true
}

proc update_PARAM_VALUE.G_NUM_OF_ARP_POS { PARAM_VALUE.G_NUM_OF_ARP_POS } {
	# Procedure called to update G_NUM_OF_ARP_POS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.G_NUM_OF_ARP_POS { PARAM_VALUE.G_NUM_OF_ARP_POS } {
	# Procedure called to validate G_NUM_OF_ARP_POS
	return true
}

proc update_PARAM_VALUE.G_RX_INPUT_PIPE_STAGES { PARAM_VALUE.G_RX_INPUT_PIPE_STAGES } {
	# Procedure called to update G_RX_INPUT_PIPE_STAGES when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.G_RX_INPUT_PIPE_STAGES { PARAM_VALUE.G_RX_INPUT_PIPE_STAGES } {
	# Procedure called to validate G_RX_INPUT_PIPE_STAGES
	return true
}

proc update_PARAM_VALUE.G_RX_IN_FIFO_CAP { PARAM_VALUE.G_RX_IN_FIFO_CAP } {
	# Procedure called to update G_RX_IN_FIFO_CAP when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.G_RX_IN_FIFO_CAP { PARAM_VALUE.G_RX_IN_FIFO_CAP } {
	# Procedure called to validate G_RX_IN_FIFO_CAP
	return true
}

proc update_PARAM_VALUE.G_TX_EXT_ETH_FIFO_CAP { PARAM_VALUE.G_TX_EXT_ETH_FIFO_CAP } {
	# Procedure called to update G_TX_EXT_ETH_FIFO_CAP when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.G_TX_EXT_ETH_FIFO_CAP { PARAM_VALUE.G_TX_EXT_ETH_FIFO_CAP } {
	# Procedure called to validate G_TX_EXT_ETH_FIFO_CAP
	return true
}

proc update_PARAM_VALUE.G_TX_EXT_IP_FIFO_CAP { PARAM_VALUE.G_TX_EXT_IP_FIFO_CAP } {
	# Procedure called to update G_TX_EXT_IP_FIFO_CAP when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.G_TX_EXT_IP_FIFO_CAP { PARAM_VALUE.G_TX_EXT_IP_FIFO_CAP } {
	# Procedure called to validate G_TX_EXT_IP_FIFO_CAP
	return true
}

proc update_PARAM_VALUE.G_TX_OUT_FIFO_CAP { PARAM_VALUE.G_TX_OUT_FIFO_CAP } {
	# Procedure called to update G_TX_OUT_FIFO_CAP when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.G_TX_OUT_FIFO_CAP { PARAM_VALUE.G_TX_OUT_FIFO_CAP } {
	# Procedure called to validate G_TX_OUT_FIFO_CAP
	return true
}

proc update_PARAM_VALUE.G_UDP_CLK_FIFOS { PARAM_VALUE.G_UDP_CLK_FIFOS } {
	# Procedure called to update G_UDP_CLK_FIFOS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.G_UDP_CLK_FIFOS { PARAM_VALUE.G_UDP_CLK_FIFOS } {
	# Procedure called to validate G_UDP_CLK_FIFOS
	return true
}


proc update_MODELPARAM_VALUE.G_FPGA_VENDOR { MODELPARAM_VALUE.G_FPGA_VENDOR PARAM_VALUE.G_FPGA_VENDOR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.G_FPGA_VENDOR}] ${MODELPARAM_VALUE.G_FPGA_VENDOR}
}

proc update_MODELPARAM_VALUE.G_FPGA_FAMILY { MODELPARAM_VALUE.G_FPGA_FAMILY PARAM_VALUE.G_FPGA_FAMILY } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.G_FPGA_FAMILY}] ${MODELPARAM_VALUE.G_FPGA_FAMILY}
}

proc update_MODELPARAM_VALUE.G_FIFO_IMPLEMENTATION { MODELPARAM_VALUE.G_FIFO_IMPLEMENTATION PARAM_VALUE.G_FIFO_IMPLEMENTATION } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.G_FIFO_IMPLEMENTATION}] ${MODELPARAM_VALUE.G_FIFO_IMPLEMENTATION}
}

proc update_MODELPARAM_VALUE.G_FIFO_TYPE { MODELPARAM_VALUE.G_FIFO_TYPE PARAM_VALUE.G_FIFO_TYPE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.G_FIFO_TYPE}] ${MODELPARAM_VALUE.G_FIFO_TYPE}
}

proc update_MODELPARAM_VALUE.G_NUM_OF_ARP_POS { MODELPARAM_VALUE.G_NUM_OF_ARP_POS PARAM_VALUE.G_NUM_OF_ARP_POS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.G_NUM_OF_ARP_POS}] ${MODELPARAM_VALUE.G_NUM_OF_ARP_POS}
}

proc update_MODELPARAM_VALUE.G_UDP_CLK_FIFOS { MODELPARAM_VALUE.G_UDP_CLK_FIFOS PARAM_VALUE.G_UDP_CLK_FIFOS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.G_UDP_CLK_FIFOS}] ${MODELPARAM_VALUE.G_UDP_CLK_FIFOS}
}

proc update_MODELPARAM_VALUE.G_EXT_CLK_FIFOS { MODELPARAM_VALUE.G_EXT_CLK_FIFOS PARAM_VALUE.G_EXT_CLK_FIFOS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.G_EXT_CLK_FIFOS}] ${MODELPARAM_VALUE.G_EXT_CLK_FIFOS}
}

proc update_MODELPARAM_VALUE.G_TX_EXT_IP_FIFO_CAP { MODELPARAM_VALUE.G_TX_EXT_IP_FIFO_CAP PARAM_VALUE.G_TX_EXT_IP_FIFO_CAP } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.G_TX_EXT_IP_FIFO_CAP}] ${MODELPARAM_VALUE.G_TX_EXT_IP_FIFO_CAP}
}

proc update_MODELPARAM_VALUE.G_TX_EXT_ETH_FIFO_CAP { MODELPARAM_VALUE.G_TX_EXT_ETH_FIFO_CAP PARAM_VALUE.G_TX_EXT_ETH_FIFO_CAP } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.G_TX_EXT_ETH_FIFO_CAP}] ${MODELPARAM_VALUE.G_TX_EXT_ETH_FIFO_CAP}
}

proc update_MODELPARAM_VALUE.G_TX_OUT_FIFO_CAP { MODELPARAM_VALUE.G_TX_OUT_FIFO_CAP PARAM_VALUE.G_TX_OUT_FIFO_CAP } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.G_TX_OUT_FIFO_CAP}] ${MODELPARAM_VALUE.G_TX_OUT_FIFO_CAP}
}

proc update_MODELPARAM_VALUE.G_RX_IN_FIFO_CAP { MODELPARAM_VALUE.G_RX_IN_FIFO_CAP PARAM_VALUE.G_RX_IN_FIFO_CAP } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.G_RX_IN_FIFO_CAP}] ${MODELPARAM_VALUE.G_RX_IN_FIFO_CAP}
}

proc update_MODELPARAM_VALUE.G_RX_INPUT_PIPE_STAGES { MODELPARAM_VALUE.G_RX_INPUT_PIPE_STAGES PARAM_VALUE.G_RX_INPUT_PIPE_STAGES } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.G_RX_INPUT_PIPE_STAGES}] ${MODELPARAM_VALUE.G_RX_INPUT_PIPE_STAGES}
}

proc update_MODELPARAM_VALUE.G_INC_PING { MODELPARAM_VALUE.G_INC_PING PARAM_VALUE.G_INC_PING } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.G_INC_PING}] ${MODELPARAM_VALUE.G_INC_PING}
}

proc update_MODELPARAM_VALUE.G_INC_ARP { MODELPARAM_VALUE.G_INC_ARP PARAM_VALUE.G_INC_ARP } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.G_INC_ARP}] ${MODELPARAM_VALUE.G_INC_ARP}
}

proc update_MODELPARAM_VALUE.G_CORE_FREQ_KHZ { MODELPARAM_VALUE.G_CORE_FREQ_KHZ PARAM_VALUE.G_CORE_FREQ_KHZ } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.G_CORE_FREQ_KHZ}] ${MODELPARAM_VALUE.G_CORE_FREQ_KHZ}
}

proc update_MODELPARAM_VALUE.G_INC_ETH { MODELPARAM_VALUE.G_INC_ETH PARAM_VALUE.G_INC_ETH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.G_INC_ETH}] ${MODELPARAM_VALUE.G_INC_ETH}
}

proc update_MODELPARAM_VALUE.G_INC_IPV4 { MODELPARAM_VALUE.G_INC_IPV4 PARAM_VALUE.G_INC_IPV4 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.G_INC_IPV4}] ${MODELPARAM_VALUE.G_INC_IPV4}
}

