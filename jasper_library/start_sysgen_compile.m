function xsg_result = start_sysgen_compile(model, compile_dir, update, skipload)

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

% find sysgen block
disp('Searching for sysgen block');
sysgen_blk      = find_system(sys, 'FollowLinks', 'on', 'LookUnderMasks', 'all', 'SearchDepth', 1, 'Tag', 'genX');

if length(sysgen_blk) == 1
    xsg_blk = sysgen_blk{1};
else
    error('XPS_xsg block must be on the same level as the Xilinx SysGen block. Have you put a XSG block in you design, and is the current system the correct one?');
end

% move into compile directory
fprintf('Setting compile directory to: %s\n', compile_dir);
xsg_path = [compile_dir, '/', 'sysgen'];
if exist(xsg_path, 'dir')
    rmdir(xsg_path, 's');
end

fprintf('Setting output directory to: %s\n', xsg_path);

% Use xlsetparam rather than set_param to configure Sysgen block properties
% Set compilation type *before* compile directory location
xlsetparam(xsg_blk, 'compilation_display', 'HDL Netlist', 'compilation', 'HDL Netlist', 'directory', xsg_path);


if update == 1
    % update the current system
    disp('Updating diagram');
    set_param(sys, 'SimulationCommand', 'update');
else
    disp('Skipping diagram update');
end

disp('Running system generator ...');
xsg_result = xlGenerateButton(xsg_blk);

if xsg_result == 0
    disp('XSG generation complete.');
else
    error(['XSG generation failed: ', xsg_result]);
    help xlGenerateButton;
end

end % /function
