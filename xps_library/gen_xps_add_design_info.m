function gen_xps_add_design_info(sys, mssge_paths, slash)
    clog('entering gen_xps_add_design_info','trace');

    base_filename = 'design_info.casper';
    
    function fstr = field2string(field)
        if ~isstruct(field),
            fstr = 'name(msb_offset,width,binpt,type)';
        else
            fstr = sprintf('%s(%s,%s,%s,%s)', field.name, field.msb_offset, field.width, field.binpt, field.type);
        end
    end
    function regstr = reg2str(reg)
        fieldstring = field2string(NaN);
        for p = 1 : numel(reg.bitfields),
            f = reg.bitfields(p);
            fieldstring = strcat(fieldstring, '|', field2string(f));
        end
        regstr = sprintf('name(%s)|direction(%s)|bitfields(%s)', reg.name, reg.direction, fieldstring);
    end
    
    % load the bitreg structures for this system
    reg_blks = find_system(sys, 'FollowLinks', 'on', 'LookUnderMasks', 'all', 'Tag', 'casper:bitreg');
    plain_regs = find_system(sys, 'Tag', 'xps:sw_reg');
    numregs = numel(reg_blks) + numel(plain_regs);
    if numregs > 0,
        bitregs(numregs) = struct('name', '', 'direction', '', 'bitfields', struct());
        for n = 1 : numel(reg_blks),
            blk = reg_blks(n);
            field_names = eval(char(get_param(blk, 'io_names')));
            field_widths = eval(char(get_param(blk, 'io_widths')));
            field_bps = eval(char(get_param(blk, 'io_bp')));
            field_types = eval(char(get_param(blk, 'io_type')));
            fields(numel(field_names)) = struct('name', '', 'msb_offset', '-1', 'width', '0', 'binpt', '0', 'type', '0');
            offset = 0;
            for s = 1 : numel(field_names),
                fields(s) = struct('name', field_names(s), 'msb_offset', num2str(offset), 'width', num2str(field_widths(s)), 'binpt', num2str(field_bps(s)), 'type', num2str(field_types(s)));
                offset = offset + field_widths(s);
            end
            regname = [regexprep(char(blk),'^.*/',''), '_reg'];
            bitregs(n) = struct('name', regname, 'direction', get_param(blk, 'io_dir'), 'bitfields', fields);
            clear field_* regname fields;
        end
        for n = 1 : numel(plain_regs),
            blk = plain_regs(n);
            fields(1) = struct('name', 'field', 'msb_offset', '0', 'width', '32', 'binpt', '0', 'type', '0');
            bitregs(numel(reg_blks) + n) = struct('name', regexprep(blk,'^.*/',''), 'direction', get_param(blk, 'io_dir'), 'bitfields', fields);
            clear fields;
        end
        numregs = numel(bitregs);
    end
    % write reginfo to file
    xps_path = mssge_paths.xps_path;    
    filename = [xps_path,  slash, base_filename];
    try
        fid = fopen(filename, 'w');
    catch e
        error(['Could not open ', base_filename, '.']);
    end
    fprintf(fid, 'register_info: NB: types can be (ufix=0,fix=1,bool=2)\n');
    for n = 1 : numregs,
        fprintf(fid, strcat(reg2str(bitregs(n)), '\n'));
    end
    fprintf(fid, '\\register_info\n');
    fclose(fid);
    
    % load the bitsnap structures for this system
    function snapstr = snap2str(snap)
        bitfield_string = field2string(NaN);
        for p = 1 : numel(snap.bitfields),
            f = snap.bitfields(p);
            bitfield_string = strcat(bitfield_string, '|', field2string(f));
        end
        extra_bitfield_string = field2string(NaN);
        for p = 1 : numel(snap.extra_bitfields),
            f = snap.extra_bitfields(p);
            extra_bitfield_string = strcat(extra_bitfield_string, '|', field2string(f));
        end
        snapstr = sprintf('name(%s)|storage(%s)|dram_dimm(%s)|dram_clock(%s)|num_samples(%s)|width(%s)|start_delay(%s)|circular(%s)|extra_value(%s)|use_dsp48s(%s)|bitfields(%s)|extra_bitfields(%s)', ...
            snap.name, snap.storage, snap.dram_dimm, snap.dram_clock, snap.num_samples, snap.width, snap.start_delay, snap.circular, snap.extra_value, snap.use_dsp48s, ...
            bitfield_string, extra_bitfield_string);
    end
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
            'num_samples', '', 'width', '', 'bitfields', struct(), 'start_delay', '', ...
            'circular', '', 'use_dsp48s', '', 'extra_value', '', 'extra_bitfields', struct());
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
            snap_fields(numel(field_names)) = struct('name', '', 'msb_offset', '-1', 'width', '0', 'binpt', '0', 'type', '0');
            offset = 0;
            for s = 1 : numel(field_names),
                snap_fields(s) = struct('name', field_names(s), 'msb_offset', num2str(offset), 'width', num2str(field_widths(s)), 'binpt', num2str(field_bps(s)), 'type', num2str(field_types(s)));
                offset = offset + field_widths(s);
            end
            clear field_*;
            % extra fields
            if strcmp(snap_extra_value, 'on'),
                field_names = eval(char(get_param(blk, 'extra_names')));
                field_widths = eval(char(get_param(blk, 'extra_widths')));
                field_bps = eval(char(get_param(blk, 'extra_bps')));
                field_types = eval(char(get_param(blk, 'extra_types')));
                snap_extra_value_fields(numel(field_names)) = struct('name', '', 'msb_offset', '-1', 'width', '0', 'binpt', '0', 'type', '0');
                offset = 0;
                for s = 1 : numel(field_names),
                    snap_extra_value_fields(s) = struct('name', field_names(s), 'msb_offset', num2str(offset), 'width', ...
                        num2str(field_widths(s)), 'binpt', num2str(field_bps(s)), 'type', num2str(field_types(s)));
                    offset = offset + field_widths(s);
                end
                clear field_*;
            else
                snap_extra_value_fields = '';
            end
            snap = struct('name', snap_name, 'storage', snap_storage, 'dram_dimm', snap_dram_dimm, 'dram_clock', snap_dram_clock, ...
                'num_samples', snap_num_samples, 'width', snap_width, 'bitfields', snap_fields, 'start_delay', snap_start_delay, ...
                'circular', snap_circular, 'use_dsp48s', snap_use_dsp48s, 'extra_value', snap_extra_value, ...
                'extra_bitfields', snap_extra_value_fields);
            bitsnaps(n) = snap;
            clear snap snap_*;
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
                'num_samples', snap_num_samples, 'width', snap_width, 'bitfields', snap_fields, 'start_delay', snap_start_delay, ...
                'circular', snap_circular, 'use_dsp48s', snap_use_dsp48s, 'extra_value', snap_extra_value, ...
                'extra_bitfields', snap_extra_value_fields);
            bitsnaps(n + numel(bitsnap_blks)) = snap;
            clear snap snap_*;
        end
        numsnaps = numel(bitsnaps);
    end

    % write snap info to file
    xps_path = mssge_paths.xps_path;    
    filename = [xps_path,  slash, base_filename];
    try
        fid = fopen(filename, 'a');
    catch e
        error(['Could not open ', base_filename, '.']);
    end
    fprintf(fid, 'snapshot_info:\n');
    for n = 1 : numsnaps,
        snap = bitsnaps(n);
        fprintf(fid, strcat(snap2str(snap), '\n'));
%         fprintf(fid, '%s: storage(%s), dram_dimm(%s), dram_clock(%s), num_samples(%i), width(%s), support[circular(%s), offset(%s), extra_value(%s)], ', snap.name, ...
%             snap.storage, snap.dram_dimm, snap.dram_clock, 2^str2double(snap.num_samples), snap.width, snap.circular, snap.start_delay, snap.extra_value);
%         fprintf(fid, 'fields[');
%         for p = 1 : numel(snap.fields),
%             field = snap.fields(p);
%             fprintf(fid, '%s(%s,%s,%s,%s)', field.name, field.msb_offset, field.width, field.binpt, field.type);
%             if p == numel(snap.fields),
%                 fprintf(fid, '], ');
%             else
%                 fprintf(fid, '|');
%             end
%         end
%         fprintf(fid, 'extra_fields[');
%         if numel(snap.extra_value_fields) == 0,
%             fprintf(fid, ']\n');
%         else
%             for p = 1 : numel(snap.extra_value_fields),
%                 field = snap.extra_value_fields(p);
%                 fprintf(fid, '%s(%s,%s,%s,%s)', field.name, field.msb_offset, field.width, field.binpt, field.type);
%                 if p == numel(snap.extra_value_fields),
%                     fprintf(fid, ']\n');
%                 else
%                     fprintf(fid, '|');
%                 end
%             end
%         end
    end
    fprintf(fid, '\\snapshot_info\n');
    fclose(fid);

    clog('exiting gen_xps_add_design_info','trace');
end % end function gen_xps_mod_mhs_bitreg
