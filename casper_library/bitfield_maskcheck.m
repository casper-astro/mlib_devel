function [numios, current_names, current_widths, current_bins, current_types] = bitfield_maskcheck(blk, blktype, fld_nms, fld_typ, fld_bps, fld_wid)
    % blktype 1 = register, 2 = snap, 3 = snap_extraval

    function clist = str_to_cell_list(cstr)
        % convert a cell list in a string to a cell list
        cstr = strrep(cstr, ']', '');
        cstr = strrep(cstr, '[', '');
        cstr = strrep(cstr, ',', ' ');
        while ~isempty(strfind(cstr, '  '))
            cstr = strrep(cstr, '  ', ' ');
        end
        cstr = strtrim(cstr);
        cstr = textscan(cstr, '%s');
        clist = cstr{1};
    end
    
    function nlist = mixed_list_to_nums(mlist)
        % convert a mixed list, received as a string, to a list of
        % numbers by searching the base workspace for variables given.
        mlist = str_to_cell_list(mlist);
        mlist_len = length(mlist);
        nlist = zeros(1, mlist_len);
        for ictr = 1 : mlist_len,
            itm = mlist{ictr};
            try
                nlist(ictr) = eval(itm);
            catch err_eval
                nlist(ictr) = evalin('base', itm);
            end
        end
    end

    % get the params from the mask
    current_names = str_to_cell_list(get_param(blk, fld_nms));
    numios = length(current_names);
    try
        current_types = eval(get_param(blk, fld_typ));
    catch err_typ
        current_types = mixed_list_to_nums(get_param(blk, fld_typ));
    end
    
    try
        current_bins = eval(get_param(blk, fld_bps));
    catch err_bps
        current_bins = mixed_list_to_nums(get_param(blk, fld_bps));
    end
    
    try
        current_widths = eval(get_param(blk, fld_wid));
    catch err_wid
        current_widths = mixed_list_to_nums(get_param(blk, fld_wid));
    end
        
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
