function sl_goto_reindex(varargin)
%--------------------------------------------------------------------------
% Description : Change a parameter for all of a bunch of selected blocks
%

% find all selected blocks 'Parent',gcs excludes the current
% subsystem. I assume there is a better way to do this I don't
% know.

BlockList = find_system(gcs,'LookUnderMasks','all','Parent',gcs,'Selected','on')

if isempty(BlockList)
    % nothing selected
    disp 'No blocks selected!';
    return
end

% set the parameters of all the selected blocks
for i = 1 : length(BlockList)
    set_param(BlockList{i},varargin{:})
end


