function vmc_result = start_vmc_compile(model, compile_dir, update, skipload)

warning off Simulink:Engine:UsingDefaultMaxStepSize
warning off Simulink:Engine:UsingDiscreteSolver
warning off Simulink:Engine:OutputNotConnected
warning off Simulink:Engine:InputNotConnected

if nargin < 4
    skipload = 0;
end

if skipload == 0
    % load model file
    fprintf('Loading model: %s\n', model);
    load_system(model);
end

sys = gcs;
fprintf('Current system is: %s\n', sys);

% find model composer hub block
disp('Searching for Model Composer Hub block');
vmchub_blk = find_system(sys, 'FollowLinks', 'on', 'LookUnderMasks', 'all', 'SearchDepth', 1, 'Tag', 'genX');
if length(vmchub_blk) == 1
    vmchub = vmchub_blk{1};
else
    error('Platform (XPS_xsg) block must be on the same level as the Vitis Model Composer block. Have you put an Platform (XSG) block in you design, and is the current system the correct one?');
end

% configure vmc hub parameters using informsation from platform block
plat_blk = find_system(gcs, 'SearchDepth', 1,'FollowLinks','on','LookUnderMasks','all','Tag','xps:xsg');
if length(plat_blk) == 1
    platform = plat_blk{1};
else
    error('Only can have one platform yellow block block in the design');
end
[hw_sys, hw_subsys] = xps_get_hw_plat(get_param(platform,'hw_sys'));
clk_rate = str2double(get_param(platform, 'clk_rate'));
vmchub_set_param(vmchub, gcs, 'SelectHardware', hw_subsys);
% use legacy hdl mode
% TODO: remove legacy treatment and use model composer features
vmchub_set_param(vmchub, sys, 'TreatDesignAsLegacyHDL', 1);
% Treating the design as a legacy SysGen HDL design allows for targeting the
% top-level as a single subsystem. This must be enabled prior to selecting the
% subsystem when targeting legacy HDL.
vmchub_set_param(vmchub, sys, 'SelectSubsystem', 1)
% A subsystem needs to be selected before the following parameters are can be
% set. To When treating model composer as a legacy system generator HDL design 
vmchub_set_param(vmchub, gcs, 'HardwareDescription', 'VHDL');
vmchub_set_param(vmchub, gcs, 'FPGAClockPeriod', num2str(1000/clk_rate));
vmchub_set_param(vmchub, gcs, 'SimulinkSystemPeriod', num2str(1));
vmchub_set_param(vmchub, gcs, 'ClockPinLocation', 'd7hack')

% move into compile directory
fprintf('Setting compile directory to: %s\n', compile_dir);
export_path = [compile_dir, '/', 'sysgen'];
if exist(export_path, 'dir')
    rmdir(export_path, 's');
end

fprintf('Configuring IP settings and output directory to: %s\n', export_path);
vmchub_set_param(vmchub, sys, 'ExportDirectory', export_path);
% TODO IPLibrary is set here to'SysGen' for backwards compatibility to match
% what the rest of the toolflow where this string is expected to appear.
% Consider generalizing or fully converting all of the name references (castro.py?)
vmchub_set_param(vmchub, sys, 'IPLibrary', 'SysGen');

% Using compile to IP catalog breaks current black box
% inputs. This is a work around until the black box path
% issues can be corrected.
RUN_IP=1;

% Set compilation type *before* compile directory location
if RUN_IP == 1
    vmchub_set_param(vmchub, sys, 'ExportType', 'IP Catalog');
else
    vmchub_Set_param(vmchub, sys, 'ExportType', 'HDL Netlist');
end

if update == 1
    % update the current system
    disp('Updating diagram');
    set_param(sys, 'SimulationCommand', 'update');
else
    disp('Skipping diagram update');
end

disp('Running Model Composer...');
vmc_result = vmcExport(vmchub);

if vmc_result == 0
    disp('VMC generation complete.');
else
    error(['VMC generation failed: ', vmc_result]);
    help vmcExport;
end

end % /function
