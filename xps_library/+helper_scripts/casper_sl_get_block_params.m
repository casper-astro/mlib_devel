function casper_sl_get_block_params(~)
try
    maskvars = {
        get_param(gcb, 'MaskVariables'), ...
        get_param(gcb, 'MaskValues') ...
    };
catch
    error('Could not scrape mask. Is this block masked?')
end
assignin('base', 'block_p_ar__ams', maskvars);
end
% end