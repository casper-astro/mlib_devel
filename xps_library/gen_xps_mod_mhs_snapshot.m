function gen_xps_mod_mhs_snapshot(sys, mssge_paths, slash)
    clog('entering gen_xps_mod_mhs_snapshot','trace');

    % load the bitreg structures for this system
    bitsnap_blks = find_system(sys, 'FollowLinks', 'on', 'LookUnderMasks', 'all', 'Tag', 'casper:bitsnap');
    snapshot_blks = find_system(sys, 'FollowLinks', 'on', 'LookUnderMasks', 'all', 'Tag', 'casper:snapshot');
    % take out duplicates
    function new = pop(find, in)
        new = {};
        for m = 1 : numel(in),
            if numel(strfind(char(in(m)), char(find))) == 0,
                new(numel(new)+1) = in(m);
            end
        end
    end
    for p = 1 : numel(bitsnap_blks),
        snapshot_blks = pop(bitsnap_blks(p), snapshot_blks);
    end
    
    numsnaps = numel(bitsnap_blks) + numel(snapshot_blks);
    if numsnaps > 0,
    
        bitsnaps(numsnaps) = struct('name', '', 'storage', '', 'dram_dimm', '', 'dram_clock', '', ...
            'num_samples', '', 'width', '', 'fields', struct(), 'start_delay', '', ...
            'circular', '', 'use_dsp48s', '', 'extra_value', '', 'extra_value_fields', struct());

        % bitsnap blocks
        for n = 1 : numel(bitsnap_blks),
            blk = bitsnap_blks(n);
            snap_name = regexprep(char(blk),'^.*/','');
            snap_storage = char(get_param(blk, 'snap_storage'));
            snap_dram_dimm = char(get_param(blk, 'snap_dram_dimm'));
            snap_dram_clock = char(get_param(blk, 'snap_dram_clock'));
            snap_num_samples = char(get_param(blk, 'snap_nsamples'));
            snap_width = char(get_param(blk, 'snap_data_width'));
            snap_start_delay = char(get_param(blk, 'snap_offset'));
            snap_circular = char(get_param(blk, 'snap_circap'));
            snap_use_dsp48s = char(get_param(blk, 'snap_use_dsp48'));
            snap_extra_value = char(get_param(blk, 'snap_value'));
            % main fields
            field_names = eval(char(get_param(blk, 'io_names')));
            field_widths = eval(char(get_param(blk, 'io_widths')));
            field_bps = eval(char(get_param(blk, 'io_bps')));
            field_types = eval(char(get_param(blk, 'io_types')));
            clear snap_fields;
            snap_fields(numel(field_names)) = struct('name', '', 'msb_offset', -1, 'width', 0, 'binpt', 0, 'type', 0);
            offset = 0;
            for s = 1 : numel(field_names),
                snap_fields(s) = struct('name', field_names(s), 'msb_offset', num2str(offset), 'width', num2str(field_widths(s)), 'binpt', num2str(field_bps(s)), 'type', num2str(field_types(s)));
                offset = offset + field_widths(s);
            end
            % extra fields
            if strcmp(snap_extra_value, 'on'),
                field_names = eval(char(get_param(blk, 'extra_names')));
                field_widths = eval(char(get_param(blk, 'extra_widths')));
                field_bps = eval(char(get_param(blk, 'extra_bps')));
                field_types = eval(char(get_param(blk, 'extra_types')));
                clear snap_extra_value_fields;
                snap_extra_value_fields(numel(field_names)) = struct('name', '', 'msb_offset', '-1', 'width', '0', 'binpt', '0', 'type', '0');
                offset = 0;
                for s = 1 : numel(field_names),
                    snap_extra_value_fields(s) = struct('name', field_names(s), 'msb_offset', num2str(offset), 'width', ...
                        num2str(field_widths(s)), 'binpt', num2str(field_bps(s)), 'type', num2str(field_types(s)));
                    offset = offset + field_widths(s);
                end
            else
                snap_extra_value_fields = [];
            end

            snap = struct('name', snap_name, 'storage', snap_storage, 'dram_dimm', snap_dram_dimm, 'dram_clock', snap_dram_clock, ...
                'num_samples', snap_num_samples, 'width', snap_width, 'fields', snap_fields, 'start_delay', snap_start_delay, ...
                'circular', snap_circular, 'use_dsp48s', snap_use_dsp48s, 'extra_value', snap_extra_value, ...
                'extra_value_fields', snap_extra_value_fields);
            bitsnaps(n) = snap;
        end

        % plain snap blocks
        for n = 1 : numel(snapshot_blks),
            blk = snapshot_blks(n);
            snap_name = regexprep(char(blk),'^.*/','');
            snap_storage = char(get_param(blk, 'storage'));
            snap_dram_dimm = char(get_param(blk, 'dram_dimm'));
            snap_dram_clock = char(get_param(blk, 'dram_clock'));
            snap_num_samples = char(get_param(blk, 'nsamples'));
            snap_width = char(get_param(blk, 'data_width'));
            snap_start_delay = char(get_param(blk, 'offset'));
            snap_circular = char(get_param(blk, 'circap'));
            snap_use_dsp48s = char(get_param(blk, 'use_dsp48'));
            snap_extra_value = char(get_param(blk, 'value'));
            snap_fields(1) = struct('name', 'word', 'msb_offset', '0', 'width', snap_width, 'binpt', '0', 'type', '0');
            if strcmp(snap_extra_value, 'on'),
                snap_extra_value_fields = struct('name', 'word', 'msb_offset', '0', 'width', '32', 'binpt', '0', 'type', '0');
            else
                snap_extra_value_fields = '';
            end
            snap = struct('name', snap_name, 'storage', snap_storage, 'dram_dimm', snap_dram_dimm, 'dram_clock', snap_dram_clock, ...
                'num_samples', snap_num_samples, 'width', snap_width, 'fields', snap_fields, 'start_delay', snap_start_delay, ...
                'circular', snap_circular, 'use_dsp48s', snap_use_dsp48s, 'extra_value', snap_extra_value, ...
                'extra_value_fields', snap_extra_value_fields);
            bitsnaps(n + numel(bitsnap_blks)) = snap;
        end
        
        numsnaps = numel(bitsnaps);
    end

    % write snap info to file
    xps_path = mssge_paths.xps_path;    
    filename = [xps_path,  slash, 'snapshots.info'];
    try
        fid = fopen(filename, 'a');
    catch e
        error('Could not open snapshots.info.');
    end
    fprintf(fid, '# List of snapshots in design:\n');
    for n = 1 : numsnaps,
        snap = bitsnaps(n);
        fprintf(fid, '%s: storage(%s), dram_dimm(%s), dram_clock(%s), num_samples(%i), width(%s), support[circular(%s), offset(%s), extra_value(%s)], ', snap.name, ...
            snap.storage, snap.dram_dimm, snap.dram_clock, 2^str2double(snap.num_samples), snap.width, snap.circular, snap.start_delay, snap.extra_value);
        fprintf(fid, 'fields[');
        for p = 1 : numel(snap.fields),
            field = snap.fields(p);
            fprintf(fid, '%s(%s,%s,%s,%s)', field.name, field.msb_offset, field.width, field.binpt, field.type);
            if p == numel(snap.fields),
                fprintf(fid, '], ');
            else
                fprintf(fid, '|');
            end
        end
        fprintf(fid, 'extra_fields[');
        if numel(snap.extra_value_fields) == 0,
            fprintf(fid, ']\n');
        else
            for p = 1 : numel(snap.extra_value_fields),
                field = snap.extra_value_fields(p);
                fprintf(fid, '%s(%s,%s,%s,%s)', field.name, field.msb_offset, field.width, field.binpt, field.type);
                if p == numel(snap.extra_value_fields),
                    fprintf(fid, ']\n');
                else
                    fprintf(fid, '|');
                end
            end
        end
    end
    fclose(fid);

    clog('exiting gen_xps_mod_mhs_snapshot','trace');
end % end function gen_xps_mod_mhs_snapshot
