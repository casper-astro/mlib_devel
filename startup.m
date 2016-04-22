warning off Simulink:SL_SaveWithParameterizedLinks_Warning
warning off Simulink:SL_LoadMdlParameterizedLink
warning off Simulink:Engine:SaveWithParameterizedLinks_Warning
warning off Simulink:Engine:SaveWithDisabledLinks_Warning
warning off Simulink:Commands:LoadMdlParameterizedLink

if length(getenv('XILINX_PATH')) == 0
  setenv('XILINX_PATH', regexprep(getenv('XILINX'),'/ISE$',''));
end

%if vivado is to be used
if getenv('USE_VIVADO_RUNTIME_FOR_MATLAB') == 1
  %addpath([getenv('XILINX_PATH'), '/ISE/sysgen/util/']);
  %addpath([getenv('XILINX_PATH'), '/ISE/sysgen/bin/lin64']);
  addpath([getenv('MLIB_DEVEL_PATH'), '/casper_library']);
  addpath([getenv('MLIB_DEVEL_PATH'), '/xps_library']);
  addpath([getenv('MLIB_DEVEL_PATH'), '/jasper_library']);
  %xlAddSysgen([getenv('XILINX_PATH'), '/ISE'])
  %sysgen_startup
%if ISE is to be used  
else
  addpath([getenv('XILINX_PATH'), '/ISE/sysgen/util/']);
  addpath([getenv('XILINX_PATH'), '/ISE/sysgen/bin/lin64']);
  addpath([getenv('MLIB_DEVEL_PATH'), '/casper_library']);
  addpath([getenv('MLIB_DEVEL_PATH'), '/xps_library']);
  addpath([getenv('MLIB_DEVEL_PATH'), '/jasper_library']);
  xlAddSysgen([getenv('XILINX_PATH'), '/ISE'])
  sysgen_startup
end
% If CASPER_BACKPORT is in the environment with non-zero length, then force
% block reuse and do NOT preload CASPER libraries.  This prevents problems when
% saving libraries in older Simulink formats (aka "backporting"), but should
% NOT be used for normal development.
%if length(getenv('CASPER_BACKPORT')) > 0
%  casper_force_reuse_block = 1;
%else
%  load_system('casper_library');
%  load_system('xps_library');
%end
