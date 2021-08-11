disp('Initializing libraries')
addpath([getenv('MLIB_DEVEL_PATH'), '/casper_library']);
addpath([getenv('MLIB_DEVEL_PATH'), '/xps_library']);
addpath([getenv('MLIB_DEVEL_PATH'), '/jasper_library']);
if ~isempty(getenv('DSP_HDL_SL_PATH'))
  addpath(getenv('DSP_HDL_SL_PATH'));
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

