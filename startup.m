xilinx_path='/data/Xilinx';
mlib_devel='/data/casper/mlib_devel';
warning off Simulink:SL_SaveWithParameterizedLinks_Warning
warning off Simulink:SL_LoadMdlParameterizedLink
addpath([xilinx_path, '/14.2/ISE_DS/ISE/sysgen/util/']);
addpath([xilinx_path, '/14.2/ISE_DS/ISE/sysgen/bin/lin64']);
addpath([mlib_devel, '/casper_library']);
addpath([mlib_devel, '/xps_library']);
xlAddSysgen(getenv('XILINX_SYS_GEN'))
sysgen_startup
load_system('casper_library');
load_system('xps_library');
