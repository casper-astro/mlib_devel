function [numios, current_names, current_widths, current_bins, current_types] = bitfield_maskcheck(blk, blktype, mode, fld_nms, fld_typ, fld_bps, fld_wid)
    % blktype 1 = register, 2 = snap, 3 = snap_extraval

    % get the params from the mask
    current_names = get_param(blk, fld_nms);
    current_names = strrep(current_names, ']', '');
    current_names = strrep(current_names, '[', '');
    current_names = strrep(current_names, ',', ' ');
    current_names = strrep(current_names, '  ', ' ');
    current_names = strtrim(current_names);
    current_names = textscan(current_names, '%s');
    current_names = current_names{1};
    numios = length(current_names);
    current_types = eval(get_param(blk, fld_typ));
    current_bins = eval(get_param(blk, fld_bps));
    current_widths = eval(get_param(blk, fld_wid));
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
    else
        % fields of equal size
        if (length(current_types) ~= 1) || (length(current_bins) ~= 1) || (length(current_widths) ~= 1),
            error('Fields of equal size needs widths, types and binary pt fields of length one.');
        end
        current_types = ones(1, numios) * current_types;
        current_bins = ones(1, numios) * current_bins;
        current_widths = ones(1, numios) * current_widths;
    end
        
    % check the types specified
    problem = 0;
    for ctr = 1 : numios,
        t = current_types(ctr);
        if (t < 0) || (t > 2),
            problem = t;
            break;
        end
    end
    if problem ~= 0,
        error('Type cannot be %i, must be 0, 1 or 2.', problem);
    end
    
    % check the width of the fields add up to less than or equal to 32
    check_width = 32;
    if blktype == 2,
        check_width = eval(get_param(blk, 'snap_data_width'));
    end
    total_width = sum(current_widths);
    if total_width > check_width,
        error('Total width must be %i or less, set to %d.', check_width, total_width);
    end
end
