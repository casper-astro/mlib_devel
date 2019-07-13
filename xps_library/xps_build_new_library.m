% Author: Brian Bradford, June 2018
% This script must be ran from xps_library folder
% input: source_dir = char array, source directory where models are stored
% input: lib_name = char array, name of new library
% With no arguments:
% source_dir defaults to $MLIB_DEVEL_PATH/xps_library/xps_models
% lib_name defaults to xps_library
% i.e., by default update this repository's library with this repository's
% blocks.
function xps_build_new_library(source_dir,lib_name)
    warning('off','all');
    if nargin == 0
        source_dir = fullfile(getenv('MLIB_DEVEL_PATH'), 'xps_library', 'xps_models');
        lib_name = 'xps_library';
    end;
    disp(source_dir)
    % always ignore first two elements of struct below
    source_struct = dir(source_dir);
    % find sub directories
    source_is_subdir = [source_struct.isdir];
    % get struct of sub directories
    subDirs = source_struct(source_is_subdir);
    % get struct of models that aren't grouped
    files_not_dirs = source_struct(~source_is_subdir);
    % Does the library already exist?
    isloaded = exist(lib_name);
    if isloaded == 4
        prompt = sprintf('Existing library with the same name has been found.\nWould you like to overwrite this library?');
        button = questdlg(prompt,'Existing Library','Yes','No','Yes');
        if strcmpi(button,'Yes')
            % library exists and is loaded
            load_system(lib_name);
            xps_lib = find_system(lib_name);
            % unlock the library
            set_param(lib_name,'Lock','off');
            % iterate over all blocks in existing library and delete
            for i=1:length(xps_lib)
                try
                    delete_block(char(xps_lib(i)));
                catch
                    % do nothing as there will be some blocks that can't be
                    % deleted or already have been deleted
                end
            end
        else
            return;
        end
    else
        disp(['Creating a new library: ',lib_name])
        % create new library
        new_system(lib_name, 'Library');
        % Add property so this library will open in the Library Browser
        set_param(lib_name,'EnableLBRepository','on');
    end
    cd(source_dir)
    disp('Adding individual models')
    left = 0;
    top = 0;
    width = 50;
    height = 50;
    % Iterate over models that are not grouped
      
    for i = 1:length(files_not_dirs)
        cur_model = files_not_dirs(i).name;
        % remove the .slx appended to the end of the model
        cur_model = erase(cur_model,'.slx');
        % disp(['Adding block: ',cur_model])
        add_block([cur_model, '/', cur_model],[lib_name, '/', cur_model]);
        % set position of groups (offset each by 100 to the right)
        set_param([lib_name,'/',cur_model],'Position', ...
            [left top left+width top+height]);
        set_param([lib_name,'/',cur_model],'MaskSelfModifiable','on');
        % increment position for next block placing
        left = left + (width*2);
    end
    
    disp('Adding grouped models')
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
            set_param([lib_name,'/',cur_dir],'Position', ...
                [left top left+width top+height]);
            set_param([lib_name,'/',cur_dir],'MaskSelfModifiable','on');
            % increment position for next group placing
            left = left + (width*2);
            % get list of models in directory
            cur_dir_struct = dir(cur_dir);
            % only get models in the sub directory
            subdir_models = cur_dir_struct(~[cur_dir_struct.isdir]);
            cd(cur_dir);
            if(strcmp(cur_dir,'ADCs'))
                cur_model = 'conv';
                % remove .slx appended to the end of the model
                cur_model = erase(cur_model,'.slx');
                disp(['Adding block: ',cur_model])
                % add block to grouping
                add_block([cur_model, '/', cur_model],[lib_name, '/', cur_dir, '/', cur_model]);
                set_param([lib_name, '/', cur_dir, '/', cur_model],'MaskSelfModifiable','on');
            end
            % iterate over models in subdir and add to new grouping
            for j = 1:length(subdir_models)
                cur_model = subdir_models(j).name;
                cur_model = erase(cur_model,'.slx');
                if(strcmp(cur_model,"conv"))
                   continue
                end
                % remove .slx appended to the end of the model
                disp(['Adding block: ',cur_model])
                % add block to grouping
                add_block([cur_model, '/', cur_model],[lib_name, '/', cur_dir, '/', cur_model]);
                set_param([lib_name, '/', cur_dir, '/', cur_model],'MaskSelfModifiable','on');
            end
            cd ..
        end
    end
    % only draw if this is a new system.
    if isloaded ~= 4
        % Draw GNU License annotation
        lic_position = [100 100 250 400];
        lic_text = 'Center for Astronomy Signal Processing and Electronics Research';
        lic_text = [lic_text newline 'http://seti.ssl.berkeley.edu/casper/'];
        lic_text = [lic_text newline 'Copyright (C) 2006 University of California, Berkeley' newline];
        lic_text = [lic_text newline 'This program is free software; you can redistribute it and/or modify'];
        lic_text = [lic_text newline 'it under the terms of the GNU General Public License as published by'];
        lic_text = [lic_text newline 'the Free Software Foundation; either version 2 of the License, or'];
        lic_text = [lic_text newline '(at your option) any later version.' newline];
        lic_text = [lic_text newline 'This program is distributed in the hope that it will be useful,'];
        lic_text = [lic_text newline 'but WITHOUT ANY WARRANTY; without even the implied warranty of'];
        lic_text = [lic_text newline 'MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the'];
        lic_text = [lic_text newline 'GNU General Public License for more details.' newline];
        lic_text = [lic_text newline 'You should have received a copy of the GNU General Public License along'];
        lic_text = [lic_text newline 'with this program; if not, write to the Free Software Foundation, Inc.,'];
        lic_text = [lic_text newline '51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.'];
        add_block('built-in/Note',[lib_name,'/GNUlicense'],'Position',lic_position,'Text',lic_text);
    end
    disp('Finished build, saving library...')
    % Finished, so save the new library
    cd ..
    save_system(lib_name);
    % NOTE: in order for this library to show up in the Library Browser,
    %       this must be defined in the 'slblocks.m' file and loaded in the
    %       'startup.m' file
end
