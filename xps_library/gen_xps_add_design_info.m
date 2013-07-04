function gen_xps_add_design_info(sysname, mssge_paths, slash)
    clog('entering gen_xps_add_design_info','trace');

    % check that we can write the file before we do anything
    base_filename = 'casper_design_info.xml';
    filename = [mssge_paths.xps_path, slash, base_filename];
    try
        fid = fopen(filename, 'w');
        fprintf(fid, '');
    catch e
        error(['Could not open ', filename, '.']);
    end
    fclose(fid);
    
    % make the DOM object
    xml_dom = com.mathworks.xml.XMLUtils.createDocument(base_filename);
    xml_node_root = xml_dom.getDocumentElement;
    xml_node_root.setAttribute('version', '0.1');
    xml_node_root.setAttribute('sysname', sysname);
    xml_node_root.setAttribute('datestr', datestr(now));
    
    % process registers and bitregs
    xml_node_registers = xml_dom.createElement('device_class');
    xml_node_registers.setAttribute('class', 'register');
    xml_node_root.appendChild(xml_node_registers);
    %xml_node_registers.appendChild(xml_dom.createComment('Both bitreg and regular registers.'));
    reg_blks = find_system(sysname, 'FollowLinks', 'on', 'LookUnderMasks', 'all', 'Tag', 'casper:bitreg');
    if numel(reg_blks) > 0,
        for n = 1 : numel(reg_blks),
            blk = reg_blks(n);
            regname = [regexprep(char(blk), '^.*/', ''), '_reg'];
            xml_node_bitreg = xml_dom.createElement('register');
            xml_node_bitreg.setAttribute('name', regname);
            xml_node_bitreg.setAttribute('direction', get_param(blk, 'io_dir'));
            xml_node_bitreg.setAttribute('width', '32');
            xml_node_registers.appendChild(xml_node_bitreg);
            % fields
            append_field_nodes(blk, xml_dom, xml_node_bitreg, 'io', 'field');
        end
    end
    plain_regs = find_system(sysname, 'Tag', 'xps:sw_reg');
    if numel(plain_regs) > 0,
        for n = 1 : numel(plain_regs),
            blk = plain_regs(n);
            regname = regexprep(blk, '^.*/', '');
            xml_node_bitreg = xml_dom.createElement('register');
            xml_node_bitreg.setAttribute('name', regname);
            xml_node_bitreg.setAttribute('direction', get_param(blk, 'io_dir'));
            xml_node_bitreg.setAttribute('width', '32');
            xml_node_registers.appendChild(xml_node_bitreg);
            xml_node_bitreg.appendChild(make_field_node(xml_dom.createElement('field'), 'field', 32, 0, 0, 0));
            clear regname;
        end
    end
    
    % and now snap blocks
    xml_node_snapshots = xml_dom.createElement('device_class');
    xml_node_snapshots.setAttribute('class', 'snapshot');
    xml_node_root.appendChild(xml_node_snapshots);
    bitsnap_blks = find_system(sysname, 'FollowLinks', 'on', 'LookUnderMasks', 'all', 'Tag', 'casper:bitsnap');
    snapshot_blks = find_system(sysname, 'FollowLinks', 'on', 'LookUnderMasks', 'all', 'Tag', 'casper:snapshot');
    % take out snapshots that are inside bitsnaps
    snapshot_blks = snapshot_blks(~strcmp(get_param(get_param(snapshot_blks, 'Parent'), 'Tag'), 'casper:bitsnap'));
    if numel(bitsnap_blks) > 0,
        for n = 1 : numel(bitsnap_blks),
            blk = bitsnap_blks(n);
            xml_node_snapshot = make_snapshot_node(sysname, strcat(blk, '/ss'), xml_dom.createElement('snapshot'));
            xml_node_snapshots.appendChild(xml_node_snapshot);
            % fields
            append_field_nodes(blk, xml_dom, xml_node_snapshot, 'io', 'field');
            % extra val?
            if strcmp(get_param(strcat(blk, '/ss'), 'value'), 'on'),
                append_field_nodes(blk, xml_dom, xml_node_snapshot, 'extra', 'extra_field');
            end
        end
    end
    if numel(snapshot_blks) > 0,
        for n = 1 : numel(snapshot_blks),
            blk = snapshot_blks(n);
            xml_node_snapshot = make_snapshot_node(sysname, blk, xml_dom.createElement('snapshot'));
            xml_node_snapshots.appendChild(xml_node_snapshot);
            xml_node_snapshot.appendChild(make_field_node(xml_dom.createElement('field'), 'field', str2double(get_param(blk, 'data_width')), 0, 0, 0));
        end
    end
    
    function append_field_nodes(blk, dom, parent_node, param_prefix, name)
        field_names = fliplr(eval(char(get_param(blk, strcat(param_prefix, '_names')))));
        field_widths = fliplr(eval(char(get_param(blk, strcat(param_prefix, '_widths')))));
        field_bps = fliplr(eval(char(get_param(blk, strcat(param_prefix, '_bps')))));
        field_types = fliplr(eval(char(get_param(blk, strcat(param_prefix, '_types')))));
        offset = 0;
        for f = 1 : numel(field_names),
            node = make_field_node(dom.createElement(name), field_names(f), field_widths(f), offset, field_bps(f), field_types(f));
            parent_node.appendChild(node);
            offset = offset + field_widths(f);
        end
    end
    
    function node = make_snapshot_node(sysname, blk, node)
        node.setAttribute('name', regexprep(regexprep(blk, ['^' sysname '/'], ''), '/', '_'));
        node.setAttribute('storage', get_param(blk, 'storage'));
        node.setAttribute('dram_dimm', get_param(blk, 'dram_dimm'));
        node.setAttribute('dram_clock', get_param(blk, 'dram_clock'));
        node.setAttribute('nsamples', get_param(blk, 'nsamples'));
        node.setAttribute('data_width', get_param(blk, 'data_width'));
        node.setAttribute('offset', get_param(blk, 'offset'));
        node.setAttribute('circap', get_param(blk, 'circap'));
        node.setAttribute('value', get_param(blk, 'value'));
        node.setAttribute('use_dsp48', get_param(blk, 'use_dsp48'));
    end
    
    function node = make_field_node(node, name, width, lsb_offset, bin_pt, bin_type)
        node.setAttribute('name', name);
        node.setAttribute('lsb_offset', num2str(lsb_offset));
        node.setAttribute('binpt', num2str(bin_pt));
        node.setAttribute('type', typenum2str(bin_type));
        node.setAttribute('width', num2str(width));
    end
    
    function typestr = typenum2str(typenum)
        switch(typenum),
            case {2}
                typestr = 'bool';
            case {1}
                typestr = 'fix';
            case {0}
                typestr = 'ufix';
        end
    end

    % and write the dom to file
    xmlwrite(filename, xml_dom);

    clog('exiting gen_xps_add_design_info','trace');
end % end function gen_xps_add_design_info
