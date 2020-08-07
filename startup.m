warning off Simulink:SL_SaveWithParameterizedLinks_Warning
warning off Simulink:SL_LoadMdlParameterizedLink
warning off Simulink:Engine:SaveWithParameterizedLinks_Warning
warning off Simulink:Engine:SaveWithDisabledLinks_Warning
warning off Simulink:Commands:LoadMdlParameterizedLink

jasper_backend = getenv('JASPER_BACKEND');

%if vivado is to be used
if strcmp(jasper_backend, 'vivado') || isempty(jasper_backend)
  disp('Starting Vivado Sysgen')
  addpath([getenv('MLIB_DEVEL_PATH'), '/casper_library']);
  addpath([getenv('MLIB_DEVEL_PATH'), '/xps_library']);
  addpath([getenv('MLIB_DEVEL_PATH'), '/jasper_library']);
  %addpath(getenv('HDL_DSP_DEVEL'));
  if ~isempty(getenv('DSP_HDL_SL_PATH'))
    addpath(getenv('DSP_HDL_SL_PATH'));
  end
%if ISE is to be used  
elseif strcmp(jasper_backend, 'ise')
  disp('Starting ISE Sysgen')
  addpath([getenv('XILINX_PATH'), '/ISE/sysgen/util/']);
  addpath([getenv('XILINX_PATH'), '/ISE/sysgen/bin/lin64']);
  addpath([getenv('MLIB_DEVEL_PATH'), '/casper_library']);
  addpath([getenv('MLIB_DEVEL_PATH'), '/xps_library']);
  addpath([getenv('MLIB_DEVEL_PATH'), '/jasper_library']);
  %addpath(getenv('HDL_DSP_DEVEL'));
  if ~isempty(getenv('DSP_HDL_SL_PATH'))
    addpath(getenv('DSP_HDL_SL_PATH'));
  end
  xlAddSysgen([getenv('XILINX_PATH'), '/ISE'])
  sysgen_startup
else
  fprintf('Unknown JASPER_BACKEND ''%s''\n', jasper_library);
  % Hopefully helpful in this case
  addpath([getenv('MLIB_DEVEL_PATH'), '/casper_library']);
  addpath([getenv('MLIB_DEVEL_PATH'), '/xps_library']);
  addpath([getenv('MLIB_DEVEL_PATH'), '/jasper_library']);
  %addpath(getenv('HDL_DSP_DEVEL'));
  if ~isempty(getenv('DSP_HDL_SL_PATH'))
    addpath(getenv('DSP_HDL_SL_PATH'));
  end
end

load_system('casper_library');
load_system('xps_library');
if ~isempty(getenv('DSP_HDL_SL_PATH'))
  load_system('hdl_library');
end

casper_startup_dir = getenv('CASPER_STARTUP_DIR');
if ~isempty(casper_startup_dir)
  cd(casper_startup_dir);
  % If a 'casper_startup.m' file exists, run it!
  if exist('casper_startup.m', 'file')
    run('./casper_startup.m');
  end
end

% Add the local python directory to MATLAB's python environment
insert(py.sys.path, int32(0), [getenv('MLIB_DEVEL_PATH'), '/casper_library/python'])

clear casper_startup_dir;
clear jasper_backend;
