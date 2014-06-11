function write_xml(filename, sysname, valid_tags)

xml_dom = com.mathworks.xml.XMLUtils.createDocument(filename);
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

end