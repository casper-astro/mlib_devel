function [headers, sources] = gen_xps_tinysh_get_src(xsg_obj, xps_objs, mssge_proj, mssge_paths)
% Returns list of user source and headers for TinySH
%
% [headers, sources] = gen_xps_tinysh_src_files(xsg_obj, xps_objs, mssge_proj, mssge_paths)

    %disp('Running gen_xps_tinysh_get_src');

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Extract common design parameters
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   sys             = mssge_proj.sys;
%   hw_sys          = mssge_proj.hw_sys;
%   hw_subsys       = mssge_proj.hw_subsys;
%   sw_os           = mssge_proj.sw_os;
%   app_clk         = mssge_proj.app_clk;
%   app_clk_rate    = mssge_proj.app_clk_rate;
%   xsg_core_name   = mssge_proj.xsg_core_name;
%   mpc_type        = mssge_proj.mpc_type;

%   XPS_BASE_PATH   = mssge_paths.XPS_BASE_PATH;
%   simulink_path   = mssge_paths.simulink_path;
    work_path       = mssge_paths.work_path;
%   src_path        = mssge_paths.src_path;
%   xsg_path        = mssge_paths.xsg_path;
%   netlist_path    = mssge_paths.netlist_path;
    xps_path        = mssge_paths.xps_path;

    headers = {};
    sources = {};

    % driver files
    for n=1:length(xps_objs)
        blk_obj = xps_objs{n};
        src_path = [xps_path,'\drivers\',get(blk_obj,'type')];
        if exist(src_path,'dir')
            files = dir(src_path);
            for k=3:length(files)
                file = files(k).name;
                if regexp(file,'\w*\.[h]')
                    filepath = [src_path,'\',file];
                    if isempty(find(strcmp(headers,filepath)))
                        headers = [headers {filepath}];
                    end
                elseif regexp(file,'\w*\.[c]')
                    filepath = [src_path,'\',file];
                    if isempty(find(strcmp(sources,filepath)))
                        sources = [sources {filepath}];
                    end
                else
                    disp(['Warning: unsupported file extension in drivers source directory: ',file]);
                end %if regexp(file,'\w*\.[h]')
            end % for k=3:length(files)
        end % if exist(src_path,'dir')
    end % for n=1:length(xps_objs)

    % user source code
    src_path = [work_path,'\src'];
    if exist(src_path,'dir')
        files = dir(src_path);
        for n=3:length(files)
            file = files(n).name;
            if regexp(file,'\w*\.[h]')
                filepath = [src_path,'\',file];
                if isempty(find(strcmp(headers,filepath)))
                    headers = [headers {filepath}];
                end % isempty(find(strcmp(headers,filepath)))
            elseif regexp(file,'\w*\.[c]')
                filepath = [src_path,'\',file];
                if isempty(find(strcmp(sources,filepath)))
                    sources = [sources {filepath}];
                end % isempty(find(strcmp(sources,filepath)))
            else
                disp(['Warning: unsupported file extension in drivers source directory: ',file]);
            end %if regexp(file,'\w*\.[h]')
        end % for n=3:length(files)
    end % if exist(src_path,'dir')

% end function gen_xps_tinysh_get_src
