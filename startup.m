warning off Simulink:SL_SaveWithParameterizedLinks_Warning
warning off Simulink:SL_LoadMdlParameterizedLink
addpath([getenv('XILINX_PATH'), '/ISE/sysgen/util/']);
addpath([getenv('XILINX_PATH'), '/ISE/sysgen/bin/lin64']);
addpath([getenv('MLIB_DEVEL_PATH'), '/casper_library']);
addpath([getenv('MLIB_DEVEL_PATH'), '/xps_library']);
xlAddSysgen([getenv('XILINX_PATH'), '/ISE'])
sysgen_startup
load_system('casper_library');
load_system('xps_library');
