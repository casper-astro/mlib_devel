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
end
% end