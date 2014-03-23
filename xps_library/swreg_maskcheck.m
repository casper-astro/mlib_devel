function [numios, current_names, current_widths, current_bins, current_types] = swreg_maskcheck(blk)
    mode = get_param(blk, 'mode');
    current_names = textscan(strtrim(strrep(strrep(strrep(strrep(get_param(blk, 'names'), ']', ''), '[', ''), ',', ' '), '  ', ' ')), '%s');
    current_names = current_names{1};
    numios = length(current_names);
    current_types = eval(get_param(blk, 'arith_types'));
    current_bins = eval(get_param(blk, 'bin_pts'));
    current_widths = eval(get_param(blk, 'bitwidths'));
    if strcmp(mode, 'one value'),
        if numios ~= 1,
            error('One value specified, but numios == %d.', numios);
        end
        if (length(current_types) ~= 1) || (length(current_bins) ~= 1) || (length(current_widths) ~= 1),
            error('Width, binary pt and type vectors must be length one.');
        end
    elseif strcmp(mode, 'fields of arbitrary size'),
        if length(current_widths) == 1,
            current_widths = ones(1, numios) * current_widths;
        elseif numios ~= length(current_widths),
            error('Field width vector must be the same length as the number of names, or one, when using arbitrary field sizes.');
        end
        if length(current_types) == 1,
            current_types = ones(1, numios) * current_types;
        elseif numios ~= length(current_types),
            error('Field arithmetic type vector must be the same length as the number of names, or one, when using arbitrary field sizes.');
        end
        if length(current_bins) == 1,
            current_bins = ones(1, numios) * current_bins;
        elseif numios ~= length(current_bins),
            error('Field binary pt vector must be the same length as the number of names, or one, when using arbitrary field sizes.');
        end
    else % fields of equal size
        if (length(current_types) ~= 1) || (length(current_bins) ~= 1) || (length(current_widths) ~= 1),
            error('Fields of equal size needs widths, types and binary pt fields of length one.');
        end
        current_types = ones(1, numios) * current_types;
        current_bins = ones(1, numios) * current_bins;
        current_widths = ones(1, numios) * current_widths;
    end
    
    % check the width of the fields add up to less than or equal to 32
    total_width = sum(current_widths);
    if total_width > 32,
        error('Total width must be 32 or less, set to %d. The top bits will be truncated.', total_width);
    end
end