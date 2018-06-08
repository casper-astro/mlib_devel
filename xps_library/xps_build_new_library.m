% Author: Brian Bradford, June 2018
% This script must be ran from xps_library folder
% input: source_dir = char array, source directory where models are stored
% input: lib_name = char array, name of new library
function xps_build_new_library(source_dir,lib_name)
    % always ignore first two elements of struct below
    source_struct = dir(source_dir);
    % find sub directories
    source_is_subdir = [source_struct.isdir];
    % get struct of sub directories
    subDirs = source_struct(source_is_subdir);
    % get struct of models that aren't grouped
    files_not_dirs = source_struct(~source_is_subdir);
    % create new library
    new_system(lib_name, 'Library');
    % Add property so this library will open in the Library Browser
    set_param(lib_name,'EnableLBRepository','on');
    cd(source_dir)
    disp('Adding individual models')
    % Iterate over models that are not grouped
    for i = 1:length(files_not_dirs)
        cur_model = files_not_dirs(i).name;
        % remove the .slx appended to the end of the model
        cur_model = erase(cur_model,'.slx');
        % disp(['Adding block: ',cur_model])
        add_block([cur_model, '/', cur_model],[lib_name, '/', cur_model]);
    end
    disp('Adding grouped models')
    left = 0;
    top = 0;
    width = 50;
    height = 50;
    % Iterate over subdirectories, ignoring hidden
    for i = 1:length(subDirs)
        % change to current groups directory
        cur_dir = subDirs(i).name;
        % ignore hidden subdirectories
        if ~contains(cur_dir,'.')
            disp(['Adding group: ',cur_dir])
            % create grouping in library and tag as 'group'
            add_block('built-in/Subsystem',[lib_name,'/',cur_dir]);
            set_param([lib_name,'/',cur_dir],'Tag','group');
            % set position of groups (offset each by 100 to the right)
            set_param([lib_name,'/',cur_dir],'Position',[left top left+width top+height]);
            % increment position for next group placing
            left = left + (width*2);
            % get list of models in directory
            cur_dir_struct = dir(cur_dir);
            % only get models in the sub directory
            subdir_models = cur_dir_struct(~[cur_dir_struct.isdir]);
            cd(cur_dir);
            % iterate over models in subdir and add to new grouping
            for j = 1:length(subdir_models)
                cur_model = subdir_models(j).name;
                % remove .slx appended to the end of the model
                cur_model = erase(cur_model,'.slx');
                % disp(['Adding block: ',cur_model])
                % add block to grouping
                add_block([cur_model, '/', cur_model],[lib_name, '/', cur_dir, '/', cur_model]);
            end
            cd ..
        end
    end
    disp('Finished build, saving new library...')
    % lock the library
    
    % Finished, so save the new library
    cd ..
    save_system(lib_name);
    
    % NOTE: in order for this library to show up in the Library Browser,
    %       this must be defined in the 'slblocks.m' file and loaded in the
    %       'startup.m' file
end