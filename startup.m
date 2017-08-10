warning off Simulink:SL_SaveWithParameterizedLinks_Warning
warning off Simulink:SL_LoadMdlParameterizedLink
warning off Simulink:Engine:SaveWithParameterizedLinks_Warning
warning off Simulink:Engine:SaveWithDisabledLinks_Warning
warning off Simulink:Commands:LoadMdlParameterizedLink

%if vivado is to be used
if getenv('JASPER_BACKEND') == 'vivado'
  disp('Starting Vivado Sysgen')
  %addpath([getenv('XILINX_PATH'), '/ISE/sysgen/util/']);
  %addpath([getenv('XILINX_PATH'), '/ISE/sysgen/bin/lin64']);
  addpath([getenv('MLIB_DEVEL_PATH'), '/casper_library']);
  addpath([getenv('MLIB_DEVEL_PATH'), '/xps_library']);
  addpath([getenv('MLIB_DEVEL_PATH'), '/jasper_library']);
  %xlAddSysgen([getenv('XILINX_PATH'), '/ISE'])
  %sysgen_startup
%if ISE is to be used  
else
  disp('Starting ISE Sysgen')
  addpath([getenv('XILINX_PATH'), '/ISE/sysgen/util/']);
  addpath([getenv('XILINX_PATH'), '/ISE/sysgen/bin/lin64']);
  addpath([getenv('MLIB_DEVEL_PATH'), '/casper_library']);
  addpath([getenv('MLIB_DEVEL_PATH'), '/xps_library']);
  addpath([getenv('MLIB_DEVEL_PATH'), '/jasper_library']);
  xlAddSysgen([getenv('XILINX_PATH'), '/ISE'])
  sysgen_startup
end

casper_startup_dir = getenv('CASPER_STARTUP_DIR');
if ~isempty(casper_startup_dir)
  cd(casper_startup_dir);
  % If a 'casper_startup.m' file exists, run it!
  if exist('casper_startup.m', 'file')
    run('./casper_startup.m');
  end
end
clear casper_startup_dir;
