function write_info_xml(filepath, sysname, valid_tags)

filename = regexprep(filepath, ['.*[\/]', ], '');

% write the XML for the new coreinfo.xml
try
    xml_dom = com.mathworks.xml.XMLUtils.createDocument(filename);
catch
    error('Cannot create XML file %s', filename);
end
xml_node_root = xml_dom.getDocumentElement;
xml_node_root.setAttribute('version', '0.1');
xml_node_root.setAttribute('system', sysname);
xml_node_root.setAttribute('datestr', datestr(now));

% info element
xml_node_infos = xml_dom.createElement('design_info');
xml_node_root.appendChild(xml_node_infos);
tagstr = '';
for n = 1 : numel(valid_tags),
    tag = valid_tags{n};
    tagstr = [tagstr, ',', tag];
end
infoblock = design_info.InfoBlock('tags', tagstr(2:end), '', '');
xml_node_infos.appendChild(infoblock.to_xml_node(xml_dom));

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
for ctr = 1 : numel(valid_tags),
    tag = valid_tags{ctr};
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

end