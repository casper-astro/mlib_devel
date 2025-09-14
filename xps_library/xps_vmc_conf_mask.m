function [] = xps_vmc_conf_mask_init()
if ~strcmp(bdroot, 'xps_library')
    vmchub_blk = find_system(gcs, 'SearchDepth', 1,'FollowLinks','on','LookUnderMasks','all','Tag','genX');
    if length(vmchub_blk) == 1
        vmchub = vmchub_blk{1};
    else
        error('XPS block must be on the same level as the Vitis Model Composer Hub block');
    end

    [hw_sys, hw_subsys] = xps_get_hw_plat(get_param(gcb,'hw_sys'));
    set_param(gcb, 'Name', hw_sys);

    % Model Composers hardware part needs to be set before a simulink 'update' (ctrl-D)
    vmchub_set_param(vmchub, gcs, 'SelectHardware', hw_subsys);

    % Other mask initialization can be done by calling functions in 'code'
    % section of mask
end
