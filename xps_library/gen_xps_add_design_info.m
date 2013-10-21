function gen_xps_add_design_info(sysname, mssge_paths, slash)
    clog('entering gen_xps_add_design_info','trace');

    %%%%%%%%%%%%%%%%%%%%%%%
    % Add your tag here if you want it to be exported to the boffile design info
    tag_list = {'xps:xsg', ...
        'xps:katadc', ...
        'casper:fft_wideband_real', ...
        'casper:fft', ...
        'casper:snapshot', ...
        'xps:sw_reg', ...
        'casper:pfb_fir', ...
        'casper:pfb_fir_async', ...
        'casper:pfb_fir_real', ...
        'xps:bram', ...
        'xps:tengbe', ...
        'xps:tengbe_v2', ...
        'casper:info'};
    %index = find(not(cellfun('isempty', strfind(tag_list, s))));
    %%%%%%%%%%%%%%%%%%%%%%%
    
    % exit if the right classes aren't found - at the moment it's not
    % critical to have this working
    if exist('design_info.Register', 'class') ~= 8,
        clog('exiting gen_xps_add_design_info - no design_info class support.', 'trace');
        return
    end
    
    % check that we can write the file before we do anything
    info_table_filename = 'newinfo.tab';
    info_xml_filename = 'newinfo.xml';
    design_xml_filename = 'design_info.xml';
    % paths
    info_table_path = [mssge_paths.xps_path, slash, info_table_filename];
    info_xml_path = [mssge_paths.xps_path, slash, info_xml_filename];
    design_xml_path = [mssge_paths.xps_path, slash, design_xml_filename];
    try
        fid = fopen(info_table_path, 'w');
        fprintf(fid, '');
    catch e
        error(['Could not open ', coreinfo_path, '.']);
    end
    fclose(fid);
    
    % find all objects in the tag list
    tagged_objects = {};
    for ctr = 1 : numel(tag_list),
        tag = tag_list{ctr};
        blks = find_system(sysname, 'FollowLinks', 'on', 'LookUnderMasks', 'all', 'Tag', tag);
        for b = 1 : numel(blks),
            tagged_objects = [tagged_objects, blks{b}];
        end
    end
    
    % write the coreinfo table file
    design_info.write_info_table(info_table_path, sysname, tagged_objects)
    
    return
    
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
    
    % write the coreinfo XML file
    design_info.write_info_xml(info_xml_path, sysname, tag_list)
    
    % write the XML for the system design xml file
    design_info.write_xml(design_xml_path, sysname, tag_list)

    clog('exiting gen_xps_add_design_info','trace');
end % end function gen_xps_add_design_info
