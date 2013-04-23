function gen_xps_mod_mhs_bitreg(sys, mssge_paths, slash)
    clog('entering gen_xps_mod_mhs_bitreg','trace');

    % load the bitreg structures for this system
    reg_blks = find_system(sys, 'FollowLinks', 'on', 'LookUnderMasks', 'all', 'Tag', 'casper:bitreg');
    plain_regs = find_system(sys, 'Tag', 'xps:sw_reg');
    numregs = numel(reg_blks) + numel(plain_regs);
    if numregs > 0,
        bitregs(numregs) = struct('name', '', 'direction', '', 'fields', struct());
        for n = 1 : numel(reg_blks),
            blk = reg_blks(n);
            fieldnames = eval(char(get_param(blk, 'io_names')));
            fieldwidths = eval(char(get_param(blk, 'io_widths')));
            fieldbp = eval(char(get_param(blk, 'io_bp')));
            fieldtype = eval(char(get_param(blk, 'io_type')));
            clear fields;
            fields(numel(fieldnames)) = struct('name', '', 'msb_offset', -1, 'width', 0, 'binpt', 0, 'type', 0);
            offset = 0;
            for s = 1 : numel(fieldnames),
                fields(s) = struct('name', fieldnames(s), 'msb_offset', offset, 'width', fieldwidths(s), 'binpt', fieldbp(s), 'type', fieldtype(s));
                offset = offset + fieldwidths(s);
            end
            regname = [regexprep(char(blk),'^.*/',''), '_reg'];
            reg = struct('name', regname, 'direction', get_param(blk, 'io_dir'), 'fields', fields);
            bitregs(n) = reg;
        end
        clear fields;
        for n = 1 : numel(plain_regs),
            blk = plain_regs(n);
            fields(1) = struct('name', 'field', 'msb_offset', 0, 'width', 32, 'binpt', 0, 'type', 0);
            reg = struct('name', regexprep(blk,'^.*/',''), 'direction', get_param(blk, 'io_dir'), 'fields', fields);
            bitregs(numel(reg_blks) + n) = reg;
        end
        numregs = numel(bitregs);
    end
    
%     % write snap info to file
%     snap_blks = find_system(sys, 'FollowLinks', 'on', 'LookUnderMasks', 'all', 'Tag', 'casper:snapshot');
%     xps_path = mssge_paths.xps_path;    
%     filename = [xps_path,  slash, 'snapshots.info'];
%     try
%         fid = fopen(filename, 'a');
%     catch e
%         error('Could not open snapshots.info to add snapshot info.');
%     end
%     fprintf(fid, '# List of snapshots in design:\n');
%     for n = 1 : numel(snap_blks),
%         snap = snap_blks(n);
%         name = regexprep(char(snap), '^.*/','');
%         storage = char(get_param(snap, 'storage'));
%         circap = char(get_param(snap, 'circap'));
%         offset = char(get_param(snap, 'offset'));
%         extra_value = char(get_param(snap, 'value'));
%         num_samples = 2^str2double(get_param(snap, 'nsamples'));
%         width = str2double(get_param(snap, 'data_width'));
%         fprintf(fid, '%s: storage(%s), num_samples(%i), width(%i), support[circular(%s), offset(%s), extra_value(%s)]\n', name, storage, num_samples, width, circap, offset, extra_value);
%     end
%     fclose(fid);
    
    % write reginfo to file
    xps_path = mssge_paths.xps_path;    
    filename = [xps_path,  slash, 'registers.info'];
    try
        fid = fopen(filename, 'a');
    catch e
        error('Could not open registers.info to add register info.');
    end
    fprintf(fid, '# register descriptions: name|direction|num_fields|field_msb(msb_offset,width,binary_pt,type)|...field_lsb(msb_offset,width,binary_pt,type)\n');
    fprintf(fid, '# type can be (ufix=0,fix=1,bool=2)\n');
    for n = 1 : numregs,
        reg = bitregs(n);
        if numel(reg.fields) > 0,
            fprintf(fid, '#%s|%s|32|%i|', reg.name, reg.direction, numel(reg.fields));
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
