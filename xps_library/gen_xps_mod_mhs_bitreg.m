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
        fields(numel(fieldnames)) = struct('name', '', 'start', -1, 'width', 0, 'binpt', 0, 'type', 0);
        offset = 0;
        for s = 1 : numel(fieldnames),
            fields(s) = struct('name', fieldnames(s), 'start', offset, 'width', fieldwidths(s), 'binpt', fieldbp(s), 'type', fieldtype(s));
            offset = offset + fieldwidths(s);
        end
        reg = struct('name', regexprep(blk,'^.*/',''), 'direction', get_param(blk, 'io_dir'), 'fields', fields);
        bitregs(n) = reg;
    end
    
    % write them to file
    xps_path = mssge_paths.xps_path;    
    filename = [xps_path,  slash, 'core_info.tab'];
    try
        fid = fopen(filename,'a');
    catch e
        error('Could not open core_info.tab to add register info.');
    end
    
    fprintf(fid, '# register fields: start, width, binary_pt, type(ufix=0,fix=1,bool=2), name\n');
    for n = 1 : numel(bitregs),
        reg = bitregs(n);
        fprintf(fid, '# %s,%s\n', reg.name, reg.direction);
        for f = 1 : numel(reg.fields),
            field = reg.fields(f);
            fprintf(fid, '#\t%i,%i,%i,%i,%s\n', field.start, field.width, field.binpt, field.type, field.name);
        end
    end
    
    fclose(fid);

    clog('exiting gen_xps_mod_mhs_bitreg','trace');
% end function gen_xps_mod_mhs_bitreg
