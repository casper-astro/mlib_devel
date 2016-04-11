function swreg_cb(blk)
%
% Init script for swreg - software register for which arbitrary fields can be defined.
%

clog('entering swreg_cb', 'trace');

check_mask_type(blk, 'swreg');

warning('Deprecated - %s - update your software registers from the library', blk)
return

% % get current mask information
% mask_names = get_param(blk, 'MaskNames');
% mask_enables = get_param(blk, 'MaskEnables');
% mask_prompts = get_param(blk, 'MaskPrompts');
% 
% current_names = get_param(blk, 'names');
% current_names = strrep(current_names, ']', '');
% current_names = strrep(current_names, '[', '');
% current_names = strrep(current_names, ',', ' ');
% current_names = strrep(current_names, '  ', ' ');
% current_names = strtrim(current_names);
% current_names = textscan(current_names, '%s');
% current_names = current_names{1};
% 
% % check the mode and set enables appropriately
% mode = get_param(blk, 'mode');
% mask_prompts{ismember(mask_names, 'names')} = 'Name';
% mask_prompts{ismember(mask_names, 'bitwidths')} = 'Bitwidth';
% mask_prompts{ismember(mask_names, 'bin_pts')} = 'Binary pt';
% mask_prompts{ismember(mask_names, 'arith_types')} = 'Data type, ufix=0, fix=1, bool=2';
% if strcmp(mode, 'one value'),
%     set_param(blk, 'names', current_names{1});
% else
%     mask_enables{ismember(mask_names, 'bitwidths')} = 'on';
%     mask_prompts{ismember(mask_names, 'names')} = 'Names [msb...lsb]';
%     if strcmp(mode, 'fields of arbitrary size'),
%         mask_prompts{ismember(mask_names, 'bitwidths')} = 'Bitwidths [msb...lsb]';
%         mask_prompts{ismember(mask_names, 'bin_pts')} = 'Binary pts [msb...lsb]';
%         mask_prompts{ismember(mask_names, 'arith_types')} = 'Data types [msb...lsb], ufix=0, fix=1, bool=2';
%     end
% end
% 
% % set the mask prompts and enables
% set_param(blk, 'MaskEnables', mask_enables);
% set_param(blk, 'MaskPrompts', mask_prompts);

end % function end
