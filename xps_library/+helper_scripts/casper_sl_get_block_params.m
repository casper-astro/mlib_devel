function casper_sl_get_block_params(~)
try
    maskvars = {
        get_param(gcb, 'MaskVariables'), ...
        get_param(gcb, 'MaskValues') ...
        get_param(gcb, 'Position') ...
    };
catch
    error('Could not scrape mask. Is this block masked?')
end
assignin('base', 'block_p_ar__ams', maskvars);

blkpos___ = get_param(gcb, 'Position');
block_size_x = blkpos___(3) - blkpos___(1);
block_size_y = blkpos___(4) - blkpos___(2);
clear blkpos___;
assignin('base', 'block_size_x', block_size_x);
assignin('base', 'block_size_y', block_size_y);
end
% end