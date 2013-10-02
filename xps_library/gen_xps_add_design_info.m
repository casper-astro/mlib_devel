function gen_xps_add_design_info(sysname, mssge_paths, slash)
    clog('entering gen_xps_add_design_info','trace');

    %%%%%%%%%%%%%%%%%%%%%%%
    % Add your tag here if you want it to be exported to the boffile design info
    tag_list = {'xps:katadc', ...
        'casper:fft_wideband_real', ...
        'casper:fft', ...
        'casper:snapshot', ...
        'xps:sw_reg', ...
        'casper:pfb_fir', ...
        'casper:pfb_fir_async', ...
        'casper:pfb_fir_real', ...
        'xps:bram', ...
        'xps:tengbe', ...
        'xps:tengbe_v2'};
    %index = find(not(cellfun('isempty', strfind(tag_list, s))));
    %%%%%%%%%%%%%%%%%%%%%%%
    
    % exit if the right classes aren't found - at the moment it's not
    % critical to have this working
    if exist('design_info.Register', 'class') ~= 8,
        clog('exiting gen_xps_add_design_info - no design_info class support.', 'trace');
        return
    end
    
    % check that we can write the file before we do anything
    coreinfo_filename = 'casper_newcoreinfo.xml';
    system_design_filename = 'casper_design_info.xml';
    coreinfo_path = [mssge_paths.xps_path, slash, coreinfo_filename];
    system_design_path = [mssge_paths.xps_path, slash, system_design_filename];
    try
        fid = fopen(coreinfo_path, 'w');
        fprintf(fid, '');
    catch e
        error(['Could not open ', coreinfo_path, '.']);
    end
    fclose(fid);
    
    % info blocks
    info_blks = find_system(sysname, 'FollowLinks', 'on', 'LookUnderMasks', 'all', 'Tag', 'casper:info');
    if numel(info_blks) > 0,
        infoBlocks(1, numel(info_blks)) = design_info.InfoBlock;
        for n = 1 : numel(info_blks),
            infoBlocks(n) = design_info.InfoBlock(info_blks(n));
        end
    else
        infoBlocks = [];
    end
    clear info_blks;
    
    % process registers
    register_blks = find_system(sysname, 'FollowLinks', 'on', 'LookUnderMasks', 'all', 'Tag', 'xps:sw_reg');
    register_names = '';
    if numel(register_blks) > 0,
        registers(1, numel(register_blks)) = design_info.Register;
        for n = 1 : numel(register_blks),
            registers(n) = design_info.Register(register_blks{n});
            register_names = strcat(register_names, ', ', registers(n).get_block_name(true));
        end
        register_names = register_names(2:end);
    else
        registers = [];
    end
    clear register_blks;
    
    % and now bitsnaps and snap blocks
    snapshot_blks = find_system(sysname, 'FollowLinks', 'on', 'LookUnderMasks', 'all', 'Tag', 'casper:snapshot');
    snapshot_names = '';
    if numel(snapshot_blks) > 0,
        snapshots(1, numel(snapshot_blks)) = design_info.Snapshot;
        for n = 1 : numel(snapshot_blks),
            snap_block = design_info.Snapshot(snapshot_blks{n});
            snapshot_names = strcat(snapshot_names, ', ', snap_block.get_block_name(true));
            % remove info blocks that are in the snapshot as well
            for o = 1 : numel(snap_block.infos),
                s_info = snap_block.infos(o);
                for p = 1 : numel(infoBlocks),
                    o_info = infoBlocks(p);
                    if (strcmp(char(s_info.parent_block), char(o_info.parent_block))) && ...
                            (strcmp(char(s_info.block), char(o_info.block))),
                        infoBlocks(p) = [];
                        break;
                    end % /if
                end % /for
            end % /for
            snapshots(n) = snap_block;
        end
        snapshot_names = snapshot_names(2:end);
    else
        snapshots = [];
    end
    clear snapshot_blks;

    % write the XML for the new coreinfo.xml
    xml_dom = com.mathworks.xml.XMLUtils.createDocument(coreinfo_filename);
    xml_node_root = xml_dom.getDocumentElement;
    xml_node_root.setAttribute('version', '0.1');
    xml_node_root.setAttribute('system', sysname);
    xml_node_root.setAttribute('datestr', datestr(now));

    % info element
    xml_node_infos = xml_dom.createElement('design_info');
    xml_node_root.appendChild(xml_node_infos);
    
    % memory element
    xml_node_memory = xml_dom.createElement('memory');
    xml_node_root.appendChild(xml_node_memory);
    
    % process registers and bitregs
    for n = 1 : numel(registers),
        reg = registers(n);
        nodes = reg.to_coreinfo(xml_dom);
        for o = 1 : numel(nodes),
            node = nodes(o);
            xml_node_memory.appendChild(node);
        end
    end
    
    % process snapshots
    for n = 1 : numel(snapshots),
        snap = snapshots(n);
        [mem, extra, info] = snap.to_coreinfo(xml_dom);
        for o = 1 : numel(mem),
            node = mem(o);
            xml_node_memory.appendChild(node);
        end
        if isa(extra, 'org.apache.xerces.dom.ElementImpl'),
            for o = 1 : numel(extra),
                node = extra(o);
                xml_node_memory.appendChild(node);
            end
        end
%         if isa(info, 'org.apache.xerces.dom.ElementImpl[]'),
%             for o = 1 : numel(info),
%                 node = info(o);
%                 xml_node_infos.appendChild(node);
%             end
%         end
    end
    
    % now comments/info blocks
    for n = 1 : numel(infoBlocks),
        info_block = infoBlocks(n);
        xml_node_infos.appendChild(info_block.to_xml_node(xml_dom));
    end

    % specified block tags
    for ctr = 1 : numel(tag_list),
        tag = tag_list{ctr};
        blocks = find_system(sysname, 'FollowLinks', 'on', 'LookUnderMasks', 'all', 'Tag', tag);
        blockstr = '';
        for blkctr = 1 : numel(blocks),
            nodes = design_info.sblock_to_info_nodes(xml_dom, blocks{blkctr});
            for n = 1 : numel(nodes),
                xml_node_infos.appendChild(nodes(n));
            end
            blockstr = [blockstr, ',', design_info.strip_system_from_name(blocks{blkctr})];
        end
        infoblock = design_info.InfoBlock(tag, blockstr(2:end), '', '');
        xml_node_infos.appendChild(infoblock.to_xml_node(xml_dom));
    end
    
%     infoblock = design_info.InfoBlock('snapshots', snapshot_names, '', '');
%     xml_node_infos.appendChild(infoblock.to_xml_node(xml_dom));
%     infoblock = design_info.InfoBlock('registers', register_names, '', '');
%     xml_node_infos.appendChild(infoblock.to_xml_node(xml_dom));
    
    % and write the dom to file
    xmlwrite(coreinfo_path, xml_dom);
    
    % write the XML for the system design xml file
    xml_dom = com.mathworks.xml.XMLUtils.createDocument(system_design_filename);
    xml_node_root = xml_dom.getDocumentElement;
    xml_node_root.setAttribute('version', '0.1');
    xml_node_root.setAttribute('system', sysname);
    xml_node_root.setAttribute('datestr', datestr(now));

    % info element
    xml_node_infos = xml_dom.createElement('design_info');
    xml_node_root.appendChild(xml_node_infos);
    
    % memory elements all go under the memory node
    xml_node_memory = xml_dom.createElement('memory');
    xml_node_root.appendChild(xml_node_memory);
    
    % process shared brams
    xml_node_sbrams = xml_dom.createElement('memory_class');
    xml_node_sbrams.setAttribute('class', 'sbram');
    xml_node_root.appendChild(xml_node_sbrams);
    
    % process registers and bitregs
    xml_node_registers = xml_dom.createElement('memory_class');
    xml_node_registers.setAttribute('class', 'register');
    xml_node_memory.appendChild(xml_node_registers);
    xml_node_registers.appendChild(xml_dom.createComment('Register information for this design.'));
    for n = 1 : numel(registers),
        reg = registers(n);
        node = reg.to_xml_node(xml_dom);
        xml_node_registers.appendChild(node);
    end
    clear registers;
    
    % process snapshots
    xml_node_snapshots = xml_dom.createElement('memory_class');
    xml_node_snapshots.setAttribute('class', 'snapshot');
    xml_node_memory.appendChild(xml_node_snapshots);
    xml_node_registers.appendChild(xml_dom.createComment('Snapshot information for this design.'));
    for n = 1 : numel(snapshots),
        snap = snapshots(n);
        node = snap.to_xml_node(xml_dom);
        xml_node_snapshots.appendChild(node);
    end
    clear snapshots;
    
    % now comments/info blocks
    for n = 1 : numel(infoBlocks),
        info_block = infoBlocks(n);
        xml_node_infos.appendChild(info_block.to_xml_node(xml_dom));
    end
    clear infoBlocks;
    
    % specified tags
    for ctr = 1 : numel(tag_list),
        tag = tag_list{ctr};
        blocks = find_system(sysname, 'FollowLinks', 'on', 'LookUnderMasks', 'all', 'Tag', tag);
        if numel(blocks) > 0,
            tag_element = strrep(tag, ':', '_');
            xml_node = xml_dom.createElement(tag_element);
            xml_node_root.appendChild(xml_node);
            for blkctr = 1 : numel(blocks),
                node = design_info.sblock_to_xml(xml_dom, blocks{blkctr});
                xml_node.appendChild(node);
            end
        end
    end
    
    % and write the dom to file
    xmlwrite(system_design_path, xml_dom);

    clog('exiting gen_xps_add_design_info','trace');
end % end function gen_xps_add_design_info
