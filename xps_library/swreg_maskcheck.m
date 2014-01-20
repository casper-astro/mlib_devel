function swreg_maskcheck(blk)
    mode = get_param(blk, 'mode');
    current_names = textscan(strtrim(strrep(strrep(get_param(blk, 'names'), ']', ''), '[', '')), '%s');
    current_names = current_names{1};
    numios = length(current_names);
    current_types = eval(get_param(blk, 'arith_types'));
    current_bins = eval(get_param(blk, 'bin_pts'));
    current_widths = eval(get_param(blk, 'bitwidths'));
    if strcmp(mode, 'one value'),
        if (numios ~= 1)
            error('One value specified, but numios == %d.', numios);
        end
        if (length(current_types) ~= numios) || (length(current_bins) ~= numios) || (length(current_widths) ~= numios),
            error('Improperly formatted mask variables: wrong number of field variables.');
        end
    elseif strcmp(mode, 'fields of arbitrary size'),
        if (length(current_types) ~= numios) || (length(current_bins) ~= numios) || (length(current_widths) ~= numios),
            error('Improperly formatted mask variables: wrong number of field variables.');
        end
    else
        if (length(current_types) ~= 1) || (length(current_bins) ~= 1) || (length(current_widths) ~= 1),
            error('Improperly formatted mask variables: wrong number of field variables.');
        end
    end
end