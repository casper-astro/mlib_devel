function casper_sl_set_block_params(~)
try
    parms = evalin('base', 'block_p_ar__ams');
catch
    error('Scraped block parameters can''t be found?')
end
maskvars = split(strip(parms{1}), ';');
maskvals = parms{2};
% process the names
masknames = cell(length(maskvars) - 1, 1);
for ctr = 1 : length(maskvars) - 1
    thisname = split(maskvars{ctr}, '=');
    masknames{ctr} = thisname{1};
end
% check that all vars have homes
for ctr = 1 : length(maskvars) - 1
    % fprintf('%i - %s = %s\n', ctr, maskvars{ctr}, maskvals{ctr});
    try
        get_param(gcb, masknames{ctr});
    catch
        error('Target block does not have parameter ''%s'' - will not continue.', masknames{ctr});
    end
end
% set them
for ctr = 1 : length(masknames) - 1
    set_param(gcb, masknames{ctr}, maskvals{ctr});
end

% and set the size
try
    block_size_x = evalin('base', 'block_size_x');
    block_size_y = evalin('base', 'block_size_y');
    blkpos = get_param(gcb, 'Position');
    new_pos = sprintf('[%i %i %i %i]', blkpos(1), blkpos(2), blkpos(1) + block_size_x, blkpos(2) + block_size_y);
    set_param(gcb, 'Position', new_pos);
catch
    % error('block_size_x and block_size_y must exist before you call this function! Did you get_block_size?')
end

end
% end