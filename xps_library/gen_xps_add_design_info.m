function gen_xps_add_design_info(sysname, mssge_paths, slash)
    clog('entering gen_xps_add_design_info','trace');

    % exit if the right classes aren't found - at the moment it's not
    % critical to have this working
    if exist('design_info.Register', 'class') ~= 8,
        clog('exiting gen_xps_add_design_info - no design_info class support.', 'trace');
        return
    end
    
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
    
    % process registers
    regs = find_system(sysname, 'FollowLinks', 'on', 'LookUnderMasks', 'all', 'Tag', 'xps:sw_reg');
    registers(1, numel(regs)) = design_info.Register;
    if numel(regs) > 0,
        for n = 1 : numel(regs),
            registers(n) = design_info.Register(regs{n});
        end
    end
    clear regs;
    
    % and now bitsnaps and snap blocks
    %bitsnap_blks = find_system(sysname, 'FollowLinks', 'on', 'LookUnderMasks', 'all', 'Tag', 'casper:bitsnap');
    snapshot_blks = find_system(sysname, 'FollowLinks', 'on', 'LookUnderMasks', 'all', 'Tag', 'casper:snapshot');
    % take out snapshots that are inside bitsnaps or we'll have duplicates
    %snapshot_blks = snapshot_blks(~strcmp(get_param(get_param(snapshot_blks, 'Parent'), 'Tag'), 'casper:bitsnap'));
    %snaps = vertcat(bitsnap_blks, snapshot_blks);
    snapshots(1, numel(snapshot_blks)) = design_info.Snapshot;
    if numel(snapshot_blks) > 0,
        for n = 1 : numel(snapshot_blks),
            snapshots(n) = design_info.Snapshot(snapshot_blks{n});
        end
    end
    clear snapshot_blks;
    
    % now comments/info blocks
    info_blks = find_system(sysname, 'FollowLinks', 'on', 'LookUnderMasks', 'all', 'Tag', 'casper:info');
    
    % write the XML - use a global id counter to id blocks
    
    % make the DOM object
    xml_dom = com.mathworks.xml.XMLUtils.createDocument(base_filename);
    xml_node_root = xml_dom.getDocumentElement;
    xml_node_root.setAttribute('version', '0.1');
    xml_node_root.setAttribute('system', sysname);
    xml_node_root.setAttribute('datestr', datestr(now));

    xml_node_infos = xml_dom.createElement('design_info');
    xml_node_root.appendChild(xml_node_infos);
    
    % process registers and bitregs
    xml_node_registers = xml_dom.createElement('device_class');
    xml_node_registers.setAttribute('class', 'register');
    xml_node_root.appendChild(xml_node_registers);
    %xml_node_registers.appendChild(xml_dom.createComment('Both bitreg and regular registers.'));
    for n = 1 : numel(registers),
        reg = registers(n);
        nodes = reg.to_xml_nodes(xml_dom);
        for node = 1 : numel(nodes),
            xml_node_registers.appendChild(nodes(node));
        end
    end
    clear registers;
    
    % process snapshots
    xml_node_snapshots = xml_dom.createElement('device_class');
    xml_node_snapshots.setAttribute('class', 'snapshot');
    xml_node_root.appendChild(xml_node_snapshots);
    for n = 1 : numel(snapshots),
        snap = snapshots(n);
        [mem, extra, info] = snap.to_xml_nodes(xml_dom);
        for node = 1 : numel(mem),
            xml_node_snapshots.appendChild(mem(node));
        end
        if isa(extra, 'org.apache.xerces.dom.ElementImpl'),
            for node = 1 : numel(extra),
                xml_node_registers.appendChild(extra(node));
            end
        end
        if isa(info, 'org.apache.xerces.dom.ElementImpl'),
            for node = 1 : numel(info),
                xml_node_infos.appendChild(info(node));
            end
        end
    end
    clear registers;
    
%     function node = find_node(parent_node, newnode)
%         % Find a node within a parent node list, by name
%         node = NaN;
%         for c = 0 : parent_node.getLength() - 1,
%             oldnode = parent_node.item(c);
%             if oldnode.getAttribute('name').equals(newnode.getAttribute('name')),
%                 if isa(node, 'org.apache.xerces.dom.ElementImpl'),
%                     error('Searching for node ''%s'' gives more than one match in parent list!', newnode.getAttribute('name'));
%                 end
%                 node = oldnode;
%             end
%         end
%     end
%     % and now bitsnaps and snap blocks
%     xml_node_snapshots = xml_dom.createElement('device_class');
%     xml_node_snapshots.setAttribute('class', 'snapshot');
%     xml_node_root.appendChild(xml_node_snapshots);
%     for n = 1 : numel(snapshots),
%         snap = snapshots(n);
%         [nodes, extranodes] = snap.to_xml_nodes(xml_dom);
%         for node = 1 : numel(nodes),
%             xml_node_snapshots.appendChild(nodes(node));
%         end
%         if strcmp(snap.extra_value, 'on'),
%             for node = 1 : numel(extranodes),
%                 % check that this node doesn't exist already from
%                 % populating the registers
%                 oldnode = find_node(xml_node_registers, extranodes(node));
%                 if isa(oldnode, 'org.apache.xerces.dom.ElementImpl'),
%                     xml_node_registers.replaceChild(extranodes(node), oldnode);
%                 else
%                     xml_node_registers.appendChild(extranodes(node));
%                 end
%             end
%         end
%     end
%     clear snapshots;
    
    % now comments/info blocks
    for n = 1 : numel(info_blks),
        info = design_info.InfoBlock(info_blks(n));
        xml_node_infos.appendChild(info.to_xml_node(xml_dom));
    end
    clear info_blks;
    
    % and write the dom to file
    xmlwrite(filename, xml_dom);

    clog('exiting gen_xps_add_design_info','trace');
end % end function gen_xps_add_design_info
