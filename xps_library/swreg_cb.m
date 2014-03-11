function swreg_cb(blk)
%
% Init script for swreg - software register for which arbitrary fields can be defined.
%

clog('entering swreg_cb', 'trace');

check_mask_type(blk, 'swreg');

% get current mask information
mask_names = get_param(blk, 'MaskNames');
mask_enables = get_param(blk, 'MaskEnables');
mask_prompts = get_param(blk, 'MaskPrompts');
current_names = textscan(strtrim(strrep(strrep(get_param(blk, 'names'), ']', ''), '[', '')), '%s');
current_names = current_names{1};
%current_types = eval(get_param(blk, 'arith_types'));
%current_bins = eval(get_param(blk, 'bin_pts'));
numios = length(current_names);

% check the mode and set enables appropriately
mode = get_param(blk, 'mode');
mask_prompts{ismember(mask_names, 'names')} = 'Name:';
mask_prompts{ismember(mask_names, 'bitwidths')} = 'Bitwidth:';
mask_prompts{ismember(mask_names, 'arith_types')} = 'Type (ufix=0, fix=1, bool=2):';
mask_prompts{ismember(mask_names, 'bin_pts')} = 'Binary pt:';
if strcmp(mode, 'one value'),
    set_param(blk, 'names', current_names{1});
    %set_param(blk, 'bitwidths', '32');
    %set_param(blk, 'arith_types', num2str(current_types(1)));
    %set_param(blk, 'bin_pts', num2str(current_bins(1)));
    %mask_enables{ismember(mask_names, 'bitwidths')} = 'off';
else
    mask_enables{ismember(mask_names, 'bitwidths')} = 'on';
    mask_prompts{ismember(mask_names, 'names')} = 'Names [msb ... lsb]:';
    if numios == 1,
        set_param(blk, 'names', strcat('[', current_names{1},' field2]'));
    end
    if strcmp(mode, 'fields of arbitrary size'),
        mask_prompts{ismember(mask_names, 'bitwidths')} = 'Bitwidths [msb ... lsb]:';
        mask_prompts{ismember(mask_names, 'arith_types')} = 'Types (ufix=0, fix=1, bool=2) [msb ... lsb]:';
        mask_prompts{ismember(mask_names, 'bin_pts')} = 'Binary pts [msb ... lsb]:';
        %set_param(blk, 'bitwidths', '[16 16]');
        %set_param(blk, 'arith_types', '[0 0]');
        %set_param(blk, 'bin_pts', '[0 0]');
    else
        %set_param(blk, 'bitwidths', num2str(floor(32 / numios)));
        %set_param(blk, 'arith_types', '0');
        %set_param(blk, 'bin_pts', '0');
    end
end

% set the mask prompts and enables
set_param(blk, 'MaskEnables', mask_enables);
set_param(blk, 'MaskPrompts', mask_prompts);

end % function end
