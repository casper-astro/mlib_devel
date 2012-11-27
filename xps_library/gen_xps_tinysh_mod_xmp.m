function gen_xps_tinysh_mod_xmp(xsg_obj, xps_objs, mssge_proj, mssge_paths, headers, sources)
% Modifies the EDK project's XMP file to include user software sources
%
% gen_xps_tinysh_mod_xmp(xsg_obj, xps_objs, mssge_proj, mssge_paths, headers, sources)

    %disp('Running gen_xps_tinysh_mod_xmp');

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Extract common design parameters
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   sys             = mssge_proj.sys;
    hw_sys          = mssge_proj.hw_sys;
    hw_subsys       = mssge_proj.hw_subsys;
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


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Write XMP file
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    str = '';

    xmpfile = 'system.xmp';

    if ~isempty(hw_subsys)
        xmpfile = [xmpfile, '.', hw_subsys];
    end % if ~isempty(hw_subsys)

    in_fid = fopen([xps_path,'\',xmpfile,'.bac'],'r');

    % read out skeleton system.xmp and detokenize
    while 1
        line = fgets(in_fid);
        if ~ischar(line)
            break;
        else
            toks = regexp(line,'(.*)#IF#(.*)#(.*)','tokens');
            if isempty(toks)
                str = [str, line];
            else
                default   = toks{1}{1};
                condition = toks{1}{2};
                real_line = toks{1}{3};
                condition_met = 0;
                for n = 1:length(xps_objs)
                    b = xps_objs{n};
                    try
                        if eval(condition)
                            condition_met = 1;
                            str = [str, real_line];
                            break;
                        end % if eval(condition)
                    end % try
                end % for n = 1:length(xps_objs)
                if ~condition_met && ~isempty(default)
                    str = [str, sprintf([default, '\n'])];
                end % if ~condition_met && ~isempty(default)
            end % if isempty(toks)
        end % if ~ischar(line)
    end % while 1

    work_path_filtered = regexprep(work_path,'\\','\/');
    fclose(in_fid);


    headers_str = '';
    for n=1:length(headers)
        headers_str = [headers_str,'Header: ',headers{n},10];
    end
    headers_str = [headers_str,'Header: drivers/core_info.h',10];
    headers_str = regexprep(headers_str,'\\','\/');
    headers_str = regexprep(headers_str,[work_path_filtered,'/XPS_',hw_sys,'_base/'],'');
    headers_str = regexprep(headers_str,work_path_filtered,'..');

    sources_str = '';
    for n=1:length(sources)
        sources_str = [sources_str,'Source: ',sources{n},10];
    end
    sources_str = [sources_str,'Source: drivers/core_info.c',10];
    sources_str = regexprep(sources_str,'\\','\/');
    sources_str = regexprep(sources_str,[work_path_filtered,'/XPS_',hw_sys,'_base/'],'');
    sources_str = regexprep(sources_str,work_path_filtered,'..');

    str = regexprep(str, '#\s*<\s*sources\s*>\s*[(\n)(\r\n)]', sources_str);
    str = regexprep(str, '#\s*<\s*headers\s*>\s*[(\n)(\r\n)]', headers_str);

    proj_fid = fopen([xps_path,'\system.xmp'],'w');
    fwrite(proj_fid,str);
    fclose(proj_fid);

% end function gen_xps_tinysh_mod_xmp
