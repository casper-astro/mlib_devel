function casper_sl_set_param_selected(~)

block_names = find_system(gcs, 'LookUnderMasks', 'all', 'SearchDepth', 1, 'Type', 'Block', 'Selected', 'on');
if isempty(block_names)
    error('No blocks selected.');
end

% get the parameter name and values
prompt = {'Param name:', 'Param value:'};
name='Which param to change';
numlines=1;
answer = inputdlg(prompt, name, numlines);
if isempty(answer{1}) || isempty(answer{2})
    error('Empty parameter name or value.');
end

% loop through the blocks and change the param if it exist for that block
for ctr = 1 : length(block_names)
    blkname = block_names{ctr};
    if strcmp(blkname, gcs) == 0
        try
            set_param(blkname, answer{1}, answer{2});
        catch
            % pass
        end
    end
end

end