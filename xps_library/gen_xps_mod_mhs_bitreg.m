function gen_xps_mod_mhs_bitreg(sys, mssge_paths, slash)
    clog('entering gen_xps_mod_mhs_bitreg','trace');

    % load the bitreg structures for this system
    reg_blks = find_system(sys, 'FollowLinks', 'on', 'LookUnderMasks', 'all', 'Tag','bitreg');
    if numel(reg_blks) == 0,
        return
    end
    bitregs(numel(reg_blks)) = struct('name', '', 'direction', '', 'fields', struct());
    for n = 1 : numel(reg_blks),
        blk = reg_blks(n);
        fieldnames = eval(char(get_param(blk, 'io_names')));
        fieldwidths = eval(char(get_param(blk, 'io_widths')));
        fieldbp = eval(char(get_param(blk, 'io_bp')));
        fieldtype = eval(char(get_param(blk, 'io_type')));
        fields(numel(fieldnames)) = struct('name', '', 'msb_offset', -1, 'width', 0, 'binpt', 0, 'type', 0);
        offset = 0;
        for s = 1 : numel(fieldnames),
            fields(s) = struct('name', fieldnames(s), 'msb_offset', offset, 'width', fieldwidths(s), 'binpt', fieldbp(s), 'type', fieldtype(s));
            offset = offset + fieldwidths(s);
        end
        reg = struct('name', regexprep(blk,'^.*/',''), 'direction', get_param(blk, 'io_dir'), 'fields', fields);
        bitregs(n) = reg;
    end
    
    % write them to file
    xps_path = mssge_paths.xps_path;    
    filename = [xps_path,  slash, 'registers.info'];
    try
        fid = fopen(filename,'a');
    catch e
        error('Could not open register_info.tab to add register info.');
    end
    
    fprintf(fid, '# register descriptions: name|direction|num_fields|field_msb(msb_offset,width,binary_pt,type)|...field_lsb(msb_offset,width,binary_pt,type)\n');
    fprintf(fid, '# type can be (ufix=0,fix=1,bool=2)\n');
    for n = 1 : numel(bitregs),
        reg = bitregs(n);
        if numel(reg.fields) > 0,
            fprintf(fid, '#%s|%s|%i|', reg.name, reg.direction, numel(reg.fields));
            for f = 1 : numel(reg.fields),
                field = reg.fields(f);
                fprintf(fid, '%s(%i,%i,%i,%i)', field.name, field.msb_offset, field.width, field.binpt, field.type);
                if f == numel(reg.fields),
                    fprintf(fid, '\n');
                else
                    fprintf(fid, '|');
                end
            end
        end
    end
    
    fclose(fid);

    clog('exiting gen_xps_mod_mhs_bitreg','trace');
% end function gen_xps_mod_mhs_bitreg
