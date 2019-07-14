# Note: This file is produced automatically, and will be overwritten the next
# time you press "Generate" in System Generator. 
#


namespace eval ::xilinx::dsp::planaheaddriver {
	set Compilation {HDL Netlist}
	set CompilationFlow {STANDARD}
	set DSPDevice {xcvu37p}
	set DSPFamily {virtexuplusHBM}
	set DSPPackage {fsvh2892}
	set DSPSpeed {-2L-e-es1}
	set FPGAClockPeriod 10
	set GenerateTestBench 0
	set HDLLanguage {vhdl}
	set IPOOCCacheRootPath {/home/hpw1/.Xilinx/Sysgen/SysgenVivado/lnx64.o/ip}
	set ImplStrategyName {Vivado Implementation Defaults}
	set Project {test_vcu128}
	set ProjectFiles {
		{{conv_pkg.vhd} -lib {xil_defaultlib}}
		{{synth_reg.vhd} -lib {xil_defaultlib}}
		{{synth_reg_w_init.vhd} -lib {xil_defaultlib}}
		{{srl17e.vhd} -lib {xil_defaultlib}}
		{{srl33e.vhd} -lib {xil_defaultlib}}
		{{synth_reg_reg.vhd} -lib {xil_defaultlib}}
		{{single_reg_w_init.vhd} -lib {xil_defaultlib}}
		{{xlclockdriver_rd.vhd} -lib {xil_defaultlib}}
		{{vivado_ip.tcl}}
		{{test_vcu128_entity_declarations.vhd} -lib {xil_defaultlib}}
		{{test_vcu128.vhd} -lib {xil_defaultlib}}
		{{test_vcu128_clock.xdc}}
		{{test_vcu128.xdc}}
	}
	set SimPeriod 1
	set SimTime 10
	set SimulationTime {310.00000000 ns}
	set SynthStrategyName {Vivado Synthesis Defaults}
	set SynthesisTool {Vivado}
	set TargetDir {/home/hpw1/amit/mlib_devel/test_vcu128/sysgen}
	set TopLevelModule {test_vcu128}
	set TopLevelSimulinkHandle 17496
	set VHDLLib {xil_defaultlib}
	set TopLevelPortInterface {}
	dict set TopLevelPortInterface test_vcu128_rst_user_data_out Name {test_vcu128_rst_user_data_out}
	dict set TopLevelPortInterface test_vcu128_rst_user_data_out Type UFix_32_0
	dict set TopLevelPortInterface test_vcu128_rst_user_data_out ArithmeticType xlUnsigned
	dict set TopLevelPortInterface test_vcu128_rst_user_data_out BinaryPoint 0
	dict set TopLevelPortInterface test_vcu128_rst_user_data_out Width 32
	dict set TopLevelPortInterface test_vcu128_rst_user_data_out DatFile {test_vcu128_rst_test_vcu128_rst_user_data_out.dat}
	dict set TopLevelPortInterface test_vcu128_rst_user_data_out IconText {test_vcu128_rst_user_data_out}
	dict set TopLevelPortInterface test_vcu128_rst_user_data_out Direction in
	dict set TopLevelPortInterface test_vcu128_rst_user_data_out Period 1
	dict set TopLevelPortInterface test_vcu128_rst_user_data_out Interface 0
	dict set TopLevelPortInterface test_vcu128_rst_user_data_out InterfaceName {}
	dict set TopLevelPortInterface test_vcu128_rst_user_data_out InterfaceString {DATA}
	dict set TopLevelPortInterface test_vcu128_rst_user_data_out ClockDomain {test_vcu128}
	dict set TopLevelPortInterface test_vcu128_rst_user_data_out Locs {}
	dict set TopLevelPortInterface test_vcu128_rst_user_data_out IOStandard {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_overflow Name {test_vcu128_gbe_app_tx_overflow}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_overflow Type Bool
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_overflow ArithmeticType xlUnsigned
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_overflow BinaryPoint 0
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_overflow Width 1
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_overflow DatFile {test_vcu128_gbe_test_vcu128_gbe_app_tx_overflow.dat}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_overflow IconText {test_vcu128_gbe_app_tx_overflow}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_overflow Direction in
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_overflow Period 1
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_overflow Interface 0
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_overflow InterfaceName {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_overflow InterfaceString {DATA}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_overflow ClockDomain {test_vcu128}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_overflow Locs {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_overflow IOStandard {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_afull Name {test_vcu128_gbe_app_tx_afull}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_afull Type Bool
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_afull ArithmeticType xlUnsigned
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_afull BinaryPoint 0
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_afull Width 1
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_afull DatFile {test_vcu128_gbe_test_vcu128_gbe_app_tx_afull.dat}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_afull IconText {test_vcu128_gbe_app_tx_afull}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_afull Direction in
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_afull Period 1
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_afull Interface 0
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_afull InterfaceName {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_afull InterfaceString {DATA}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_afull ClockDomain {test_vcu128}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_afull Locs {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_afull IOStandard {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_srcport Name {test_vcu128_gbe_app_rx_srcport}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_srcport Type UFix_16_0
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_srcport ArithmeticType xlUnsigned
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_srcport BinaryPoint 0
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_srcport Width 16
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_srcport DatFile {test_vcu128_gbe_test_vcu128_gbe_app_rx_srcport.dat}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_srcport IconText {test_vcu128_gbe_app_rx_srcport}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_srcport Direction in
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_srcport Period 1
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_srcport Interface 0
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_srcport InterfaceName {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_srcport InterfaceString {DATA}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_srcport ClockDomain {test_vcu128}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_srcport Locs {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_srcport IOStandard {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_srcip Name {test_vcu128_gbe_app_rx_srcip}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_srcip Type UFix_32_0
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_srcip ArithmeticType xlUnsigned
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_srcip BinaryPoint 0
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_srcip Width 32
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_srcip DatFile {test_vcu128_gbe_test_vcu128_gbe_app_rx_srcip.dat}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_srcip IconText {test_vcu128_gbe_app_rx_srcip}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_srcip Direction in
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_srcip Period 1
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_srcip Interface 0
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_srcip InterfaceName {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_srcip InterfaceString {DATA}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_srcip ClockDomain {test_vcu128}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_srcip Locs {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_srcip IOStandard {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_overrun Name {test_vcu128_gbe_app_rx_overrun}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_overrun Type Bool
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_overrun ArithmeticType xlUnsigned
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_overrun BinaryPoint 0
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_overrun Width 1
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_overrun DatFile {test_vcu128_gbe_test_vcu128_gbe_app_rx_overrun.dat}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_overrun IconText {test_vcu128_gbe_app_rx_overrun}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_overrun Direction in
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_overrun Period 1
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_overrun Interface 0
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_overrun InterfaceName {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_overrun InterfaceString {DATA}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_overrun ClockDomain {test_vcu128}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_overrun Locs {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_overrun IOStandard {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_eof Name {test_vcu128_gbe_app_rx_eof}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_eof Type Bool
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_eof ArithmeticType xlUnsigned
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_eof BinaryPoint 0
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_eof Width 1
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_eof DatFile {test_vcu128_gbe_test_vcu128_gbe_app_rx_eof.dat}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_eof IconText {test_vcu128_gbe_app_rx_eof}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_eof Direction in
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_eof Period 1
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_eof Interface 0
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_eof InterfaceName {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_eof InterfaceString {DATA}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_eof ClockDomain {test_vcu128}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_eof Locs {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_eof IOStandard {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_dvld Name {test_vcu128_gbe_app_rx_dvld}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_dvld Type Bool
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_dvld ArithmeticType xlUnsigned
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_dvld BinaryPoint 0
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_dvld Width 1
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_dvld DatFile {test_vcu128_gbe_test_vcu128_gbe_app_rx_dvld.dat}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_dvld IconText {test_vcu128_gbe_app_rx_dvld}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_dvld Direction in
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_dvld Period 1
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_dvld Interface 0
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_dvld InterfaceName {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_dvld InterfaceString {DATA}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_dvld ClockDomain {test_vcu128}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_dvld Locs {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_dvld IOStandard {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_data Name {test_vcu128_gbe_app_rx_data}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_data Type UFix_8_0
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_data ArithmeticType xlUnsigned
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_data BinaryPoint 0
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_data Width 8
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_data DatFile {test_vcu128_gbe_test_vcu128_gbe_app_rx_data.dat}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_data IconText {test_vcu128_gbe_app_rx_data}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_data Direction in
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_data Period 1
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_data Interface 0
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_data InterfaceName {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_data InterfaceString {DATA}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_data ClockDomain {test_vcu128}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_data Locs {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_data IOStandard {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_badframe Name {test_vcu128_gbe_app_rx_badframe}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_badframe Type Bool
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_badframe ArithmeticType xlUnsigned
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_badframe BinaryPoint 0
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_badframe Width 1
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_badframe DatFile {test_vcu128_gbe_test_vcu128_gbe_app_rx_badframe.dat}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_badframe IconText {test_vcu128_gbe_app_rx_badframe}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_badframe Direction in
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_badframe Period 1
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_badframe Interface 0
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_badframe InterfaceName {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_badframe InterfaceString {DATA}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_badframe ClockDomain {test_vcu128}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_badframe Locs {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_badframe IOStandard {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_dbg_dvld Name {test_vcu128_gbe_app_dbg_dvld}
	dict set TopLevelPortInterface test_vcu128_gbe_app_dbg_dvld Type Bool
	dict set TopLevelPortInterface test_vcu128_gbe_app_dbg_dvld ArithmeticType xlUnsigned
	dict set TopLevelPortInterface test_vcu128_gbe_app_dbg_dvld BinaryPoint 0
	dict set TopLevelPortInterface test_vcu128_gbe_app_dbg_dvld Width 1
	dict set TopLevelPortInterface test_vcu128_gbe_app_dbg_dvld DatFile {test_vcu128_gbe_test_vcu128_gbe_app_dbg_dvld.dat}
	dict set TopLevelPortInterface test_vcu128_gbe_app_dbg_dvld IconText {test_vcu128_gbe_app_dbg_dvld}
	dict set TopLevelPortInterface test_vcu128_gbe_app_dbg_dvld Direction in
	dict set TopLevelPortInterface test_vcu128_gbe_app_dbg_dvld Period 1
	dict set TopLevelPortInterface test_vcu128_gbe_app_dbg_dvld Interface 0
	dict set TopLevelPortInterface test_vcu128_gbe_app_dbg_dvld InterfaceName {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_dbg_dvld InterfaceString {DATA}
	dict set TopLevelPortInterface test_vcu128_gbe_app_dbg_dvld ClockDomain {test_vcu128}
	dict set TopLevelPortInterface test_vcu128_gbe_app_dbg_dvld Locs {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_dbg_dvld IOStandard {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_dbg_data Name {test_vcu128_gbe_app_dbg_data}
	dict set TopLevelPortInterface test_vcu128_gbe_app_dbg_data Type UFix_32_0
	dict set TopLevelPortInterface test_vcu128_gbe_app_dbg_data ArithmeticType xlUnsigned
	dict set TopLevelPortInterface test_vcu128_gbe_app_dbg_data BinaryPoint 0
	dict set TopLevelPortInterface test_vcu128_gbe_app_dbg_data Width 32
	dict set TopLevelPortInterface test_vcu128_gbe_app_dbg_data DatFile {test_vcu128_gbe_test_vcu128_gbe_app_dbg_data.dat}
	dict set TopLevelPortInterface test_vcu128_gbe_app_dbg_data IconText {test_vcu128_gbe_app_dbg_data}
	dict set TopLevelPortInterface test_vcu128_gbe_app_dbg_data Direction in
	dict set TopLevelPortInterface test_vcu128_gbe_app_dbg_data Period 1
	dict set TopLevelPortInterface test_vcu128_gbe_app_dbg_data Interface 0
	dict set TopLevelPortInterface test_vcu128_gbe_app_dbg_data InterfaceName {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_dbg_data InterfaceString {DATA}
	dict set TopLevelPortInterface test_vcu128_gbe_app_dbg_data ClockDomain {test_vcu128}
	dict set TopLevelPortInterface test_vcu128_gbe_app_dbg_data Locs {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_dbg_data IOStandard {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_ack Name {test_vcu128_gbe_app_rx_ack}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_ack Type Bool
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_ack ArithmeticType xlUnsigned
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_ack BinaryPoint 0
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_ack Width 1
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_ack DatFile {test_vcu128_gbe_test_vcu128_gbe_app_rx_ack.dat}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_ack IconText {test_vcu128_gbe_app_rx_ack}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_ack Direction out
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_ack Period 1
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_ack Interface 0
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_ack InterfaceName {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_ack InterfaceString {DATA}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_ack ClockDomain {test_vcu128}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_ack Locs {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_ack IOStandard {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_rst Name {test_vcu128_gbe_app_rx_rst}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_rst Type Bool
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_rst ArithmeticType xlUnsigned
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_rst BinaryPoint 0
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_rst Width 1
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_rst DatFile {test_vcu128_gbe_test_vcu128_gbe_app_rx_rst.dat}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_rst IconText {test_vcu128_gbe_app_rx_rst}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_rst Direction out
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_rst Period 1
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_rst Interface 0
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_rst InterfaceName {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_rst InterfaceString {DATA}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_rst ClockDomain {test_vcu128}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_rst Locs {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_rx_rst IOStandard {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_data Name {test_vcu128_gbe_app_tx_data}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_data Type UFix_8_0
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_data ArithmeticType xlUnsigned
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_data BinaryPoint 0
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_data Width 8
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_data DatFile {test_vcu128_gbe_test_vcu128_gbe_app_tx_data.dat}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_data IconText {test_vcu128_gbe_app_tx_data}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_data Direction out
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_data Period 1
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_data Interface 0
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_data InterfaceName {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_data InterfaceString {DATA}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_data ClockDomain {test_vcu128}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_data Locs {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_data IOStandard {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_destip Name {test_vcu128_gbe_app_tx_destip}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_destip Type UFix_32_0
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_destip ArithmeticType xlUnsigned
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_destip BinaryPoint 0
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_destip Width 32
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_destip DatFile {test_vcu128_gbe_test_vcu128_gbe_app_tx_destip.dat}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_destip IconText {test_vcu128_gbe_app_tx_destip}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_destip Direction out
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_destip Period 1
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_destip Interface 0
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_destip InterfaceName {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_destip InterfaceString {DATA}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_destip ClockDomain {test_vcu128}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_destip Locs {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_destip IOStandard {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_destport Name {test_vcu128_gbe_app_tx_destport}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_destport Type UFix_16_0
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_destport ArithmeticType xlUnsigned
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_destport BinaryPoint 0
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_destport Width 16
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_destport DatFile {test_vcu128_gbe_test_vcu128_gbe_app_tx_destport.dat}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_destport IconText {test_vcu128_gbe_app_tx_destport}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_destport Direction out
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_destport Period 1
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_destport Interface 0
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_destport InterfaceName {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_destport InterfaceString {DATA}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_destport ClockDomain {test_vcu128}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_destport Locs {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_destport IOStandard {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_dvld Name {test_vcu128_gbe_app_tx_dvld}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_dvld Type Bool
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_dvld ArithmeticType xlUnsigned
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_dvld BinaryPoint 0
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_dvld Width 1
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_dvld DatFile {test_vcu128_gbe_test_vcu128_gbe_app_tx_dvld.dat}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_dvld IconText {test_vcu128_gbe_app_tx_dvld}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_dvld Direction out
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_dvld Period 1
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_dvld Interface 0
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_dvld InterfaceName {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_dvld InterfaceString {DATA}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_dvld ClockDomain {test_vcu128}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_dvld Locs {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_dvld IOStandard {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_eof Name {test_vcu128_gbe_app_tx_eof}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_eof Type Bool
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_eof ArithmeticType xlUnsigned
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_eof BinaryPoint 0
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_eof Width 1
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_eof DatFile {test_vcu128_gbe_test_vcu128_gbe_app_tx_eof.dat}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_eof IconText {test_vcu128_gbe_app_tx_eof}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_eof Direction out
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_eof Period 1
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_eof Interface 0
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_eof InterfaceName {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_eof InterfaceString {DATA}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_eof ClockDomain {test_vcu128}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_eof Locs {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_eof IOStandard {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_rst Name {test_vcu128_gbe_app_tx_rst}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_rst Type Bool
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_rst ArithmeticType xlUnsigned
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_rst BinaryPoint 0
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_rst Width 1
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_rst DatFile {test_vcu128_gbe_test_vcu128_gbe_app_tx_rst.dat}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_rst IconText {test_vcu128_gbe_app_tx_rst}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_rst Direction out
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_rst Period 1
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_rst Interface 0
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_rst InterfaceName {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_rst InterfaceString {DATA}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_rst ClockDomain {test_vcu128}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_rst Locs {}
	dict set TopLevelPortInterface test_vcu128_gbe_app_tx_rst IOStandard {}
	dict set TopLevelPortInterface test_vcu128_led_gateway Name {test_vcu128_led_gateway}
	dict set TopLevelPortInterface test_vcu128_led_gateway Type Bool
	dict set TopLevelPortInterface test_vcu128_led_gateway ArithmeticType xlUnsigned
	dict set TopLevelPortInterface test_vcu128_led_gateway BinaryPoint 0
	dict set TopLevelPortInterface test_vcu128_led_gateway Width 1
	dict set TopLevelPortInterface test_vcu128_led_gateway DatFile {test_vcu128_led_test_vcu128_led_gateway.dat}
	dict set TopLevelPortInterface test_vcu128_led_gateway IconText {test_vcu128_led_gateway}
	dict set TopLevelPortInterface test_vcu128_led_gateway Direction out
	dict set TopLevelPortInterface test_vcu128_led_gateway Period 1
	dict set TopLevelPortInterface test_vcu128_led_gateway Interface 0
	dict set TopLevelPortInterface test_vcu128_led_gateway InterfaceName {}
	dict set TopLevelPortInterface test_vcu128_led_gateway InterfaceString {DATA}
	dict set TopLevelPortInterface test_vcu128_led_gateway ClockDomain {test_vcu128}
	dict set TopLevelPortInterface test_vcu128_led_gateway Locs {}
	dict set TopLevelPortInterface test_vcu128_led_gateway IOStandard {}
	dict set TopLevelPortInterface clk Name {clk}
	dict set TopLevelPortInterface clk Type -
	dict set TopLevelPortInterface clk ArithmeticType xlUnsigned
	dict set TopLevelPortInterface clk BinaryPoint 0
	dict set TopLevelPortInterface clk Width 1
	dict set TopLevelPortInterface clk DatFile {}
	dict set TopLevelPortInterface clk Direction in
	dict set TopLevelPortInterface clk Period 1
	dict set TopLevelPortInterface clk Interface 6
	dict set TopLevelPortInterface clk InterfaceName {}
	dict set TopLevelPortInterface clk InterfaceString {CLOCK}
	dict set TopLevelPortInterface clk ClockDomain {test_vcu128}
	dict set TopLevelPortInterface clk Locs {}
	dict set TopLevelPortInterface clk IOStandard {}
	dict set TopLevelPortInterface clk AssociatedInterfaces {}
	dict set TopLevelPortInterface clk AssociatedResets {}
	set MemoryMappedPort {}
}

source SgPaProject.tcl
::xilinx::dsp::planaheadworker::dsp_create_project