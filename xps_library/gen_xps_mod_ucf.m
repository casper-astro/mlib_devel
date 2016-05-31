function gen_xps_mod_ucf(xsg_obj, xps_objs, mssge_proj, mssge_paths, slash)
% Modifies the EDK project's UCF file to include design elements.
%
% gen_xps_mod_ucf(xsg_obj, xps_objs, mssge_proj, mssge_pathsm, slash)

    %disp('Running gen_xps_mod_ucf');

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Extract common design parameters
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   sys             = mssge_proj.sys;
%   hw_sys          = mssge_proj.hw_sys;
%   hw_subsys       = mssge_proj.hw_subsys;
%   sw_os           = mssge_proj.sw_os;
    app_clk         = mssge_proj.app_clk;
    app_clk_rate    = mssge_proj.app_clk_rate;
%   xsg_core_name   = mssge_proj.xsg_core_name;

%   XPS_BASE_PATH   = mssge_paths.XPS_BASE_PATH;
%   simulink_path   = mssge_paths.simulink_path;
%   src_path        = mssge_paths.src_path;
%   xsg_path        = mssge_paths.xsg_path;
%   netlist_path    = mssge_paths.netlist_path;
%   work_path       = mssge_paths.work_path;
    xps_path        = mssge_paths.xps_path;


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Backup and preprocess skeleton UCF
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if ~exist([xps_path, slash, 'data', slash, 'system.ucf.bac'],'file')
        [copystatus,copymessage,copymessageid] = copyfile([xps_path, slash, 'data', slash, 'system.ucf'],[xps_path, slash, 'data', slash, 'system.ucf.bac']);
        if ~copystatus
            disp('Error trying to backup system.ucf:');
            disp(copymessage);
        end % if ~copystatus
    end % if ~exist([xps_path, slash, 'data', slash, 'system.ucf.bac'],'file')

    in_fid = fopen([xps_path, slash, 'data', slash, 'system.ucf.bac'],'r');
    ucf_fid = fopen([xps_path, slash, 'data', slash, 'system.ucf'],'w');

    detokenize(in_fid, ucf_fid, xps_objs);

    fclose(in_fid);


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Write clock constraints
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if ( strcmp(app_clk, 'usr_clk') || strcmp(app_clk, 'usr_clk2x') )

        fprintf(ucf_fid,'##############################################\n');
        fprintf(ucf_fid,'# User Clock constraints                     #\n');
        fprintf(ucf_fid,'##############################################\n');
        fprintf(ucf_fid,'\n');
        fprintf(ucf_fid,'NET "usrclk_in"             TNM_NET = "usrclk_in" ;\n');

        if strcmp(app_clk,'usr_clk2x')
            fprintf(ucf_fid,['TIMESPEC "TS_usrclk_in" = PERIOD "usrclk_in" ', num2str(app_clk_rate/2, '%3.2f'),' MHz ;\n']);
        else
            fprintf(ucf_fid,['TIMESPEC "TS_usrclk_in" = PERIOD "usrclk_in" ', num2str(app_clk_rate),' MHz ;\n']);
        end

        fprintf(ucf_fid,'\n\n');
    end


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Write design-specific constraints
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    fprintf(ucf_fid,'##############################################\n');
    fprintf(ucf_fid,'# IP UCF constraints                         #\n');
    fprintf(ucf_fid,'##############################################\n');
    fprintf(ucf_fid,'\n');
    try
        for n = 1:length(xps_objs)
            blk_obj = xps_objs{n};
            fprintf(ucf_fid,['# ',get(blk_obj,'simulink_name'),'\n']);
            fprintf(ucf_fid,gen_ucf(blk_obj));
            fprintf(ucf_fid,'\n');
        end
    catch
        disp('Problem with block : ')
        display(blk_obj);
        disp(lasterr);
        error('Error found during IP UCF generation in MHS');
    end
    fprintf(ucf_fid,'\n');

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Concatenate user-specified constraints files
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    user_ucf_path = getenv('USER_UCF_PATH');
    strict = true;

    if isempty(user_ucf_path)
      user_ucf_path = fullfile(mssge_paths.work_path, 'ucf');
      strict = false;
    end
    
    if(user_ucf_path)
        
        user_ucf_files = dir(fullfile(user_ucf_path, '*.ucf'));
        
        if(~isempty(user_ucf_files))

            fprintf(ucf_fid,'##############################################\n');
            fprintf(ucf_fid,'# User-specified constraints                 #\n');
            fprintf(ucf_fid,'##############################################\n');

            for n = 1:length(user_ucf_files)
                file_path = fullfile(user_ucf_path, user_ucf_files(n).name);
                fprintf(ucf_fid, '\n\n### BEGIN %s\n\n', file_path);
                fprintf(ucf_fid, '%s', fileread(file_path));
                fprintf(ucf_fid, '\n\n### END %s\n\n', file_path);
            end
            
        elseif strict
            error(['No *.ucf files  found in: USER_UCF_PATH=', user_ucf_path]);
        end
    
    end
    
    fclose(ucf_fid);

% end function gen_xps_mod_ucf
