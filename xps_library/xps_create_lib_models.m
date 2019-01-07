% Author: Brian Bradford, June 2018
% This script must be ran from xps_library folder
% input: folderdest = new folder to save models within xps_library
% input: lib_name = name of library to build models from
% Note: this script will only work for one level of grouping blocks.
function xps_create_lib_models(folderdest,lib_name)
    % get all subsystems in xps_library model
    load_system(lib_name);
    xps_lib = find_system(lib_name);
    % make new directory to store all the models under xps_library
    mkdir(folderdest)
    cd(folderdest)
    group_count = 1;
    % create empty cell array for individual blocks.
    ind_blocks = {};
    ind_count = 0;
    group_struct = struct;
    disp('Finding groupings...')
    % Loop over xps_lib and find top level groupings
    for i = 2:length(xps_lib)
        cur_blk = xps_lib(i);
        if strcmp(get_param(cur_blk,'Tag'),'group')
            % make a new group
            group_struct(group_count).groupname = char(get_param(cur_blk,'Name'));
            group_struct(group_count).count = 0;
            group_struct(group_count).blocknames = {};
            group_count = group_count +1;
        end
    end
    disp('Sorting by grouped or individual blocks')
    % Loop over xps_lib and sort grouped or individual blocks
    for i = 2:length(xps_lib)
        % split to ignore first element in block path 'xps_library/'
        ignore_lib = strsplit(char(xps_lib(i)),[lib_name,'/']);
        % split each block path
        split_path = strsplit(char(ignore_lib(2)),'/');
        % we already created grouping above, so we ignore these top level blocks
        if ~strcmp(get_param(xps_lib(i),'Tag'),'group')
            % check if this path is in a group or an individual block
            if length(split_path) > 1
                % find index of group
                index = find(strcmp({group_struct.groupname},char(split_path(1)))==1);
                % iterate counter
                group_struct(index).count = group_struct(index).count +1;
                count = group_struct(index).count;
                % append to cell array of blocknames belonging to this group
                group_struct(index).blocknames{count} = char(split_path(2));
            else 
                % append to cell array of individual blocks
                ind_count = ind_count + 1;
                ind_blocks{ind_count} = char(ignore_lib(2));
            end
        end
    end
    cd ..
    cd(folderdest)
    
    % loop over individual blocks, create a new model, add block,
    % save/name/close model
    disp('Adding individual blocks')
    for i = 1:length(ind_blocks)
        cur_blk = char(ind_blocks(i));
        new_system(cur_blk, 'Model');
        add_block([lib_name,'/',cur_blk],[cur_blk, '/', cur_blk]);
        % disable and break library links
        set_param([cur_blk, '/', cur_blk],'LinkStatus', 'none');
        save_system(cur_blk);
    end

    % loop over each group, make new directory, 
    % for each block in blocknames:
    % - create a new model, add block, save/name/close model
    disp('Adding grouped blocks')
    for i = 1:length(group_struct)
        group_name = char(group_struct(i).groupname);
        % make new directory for group
        mkdir(group_name)
        cd(group_name)
        for j = 1:length(group_struct(i).blocknames)
            cur_blk = char(group_struct(i).blocknames(j));
            % loop over each block in group
            blockpath = [lib_name,'/',group_name,'/',cur_blk]; 
            new_system(cur_blk,'Model');
            add_block(blockpath,[cur_blk, '/', cur_blk]);
            % disable and break library links
            set_param([cur_blk, '/', cur_blk],'LinkStatus', 'none');           
            save_system(cur_blk)
        end
        cd ..
    end
end