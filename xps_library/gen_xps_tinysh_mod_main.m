function gen_xps_tinysh_mod_main(xsg_obj, xps_objs, mssge_proj, mssge_paths, headers, sources)
% Modifies skeleton main.c file for TinySH projects with user functions.
%
% gen_xps_tinysh_mod_main(sys, xsg_obj, xps_objs, mssge_paths, headers, sources)

    %disp('running gen_xps_tinysh_mod_main');

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Extract common design parameters
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    sys             = mssge_proj.sys;
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


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Parse user source files to determine function type
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    commands = {};
    repeats  = {};
    inits    = {};

    for n=1:length(sources)
        source = sources{n};
        source_fid = fopen(source,'r');
        str = '';
        while 1
            line = fgets(source_fid);
            if ~ischar(line)
                break;
            else
                str = [str, line];
            end % if ~ischar(line)
        end % while 1
        commands = [commands,regexp(str,'void\s+(\w*)\s*\(\s*int\s*\w*\s*,\s*char\s*\*\*\s*\w*\s*\)\s*\/\*\s*command\s*=\s*"([^"]*)"\s*\*\/\s*\/\*\s*help\s*=\s*"([^"]*)"\s*\*\/\s*\/\*\s*params\s*=\s*"([^"]*)"\s*\*\/\s*{','tokens')];
        repeats  = [repeats ,regexp(str,'void\s+(\w*)\s*\(\s*)\s*\/\*\s*repeat\s*\*\/\s*{','tokens')];
        inits    = [inits   ,regexp(str,'void\s+(\w*)\s*\(\s*)\s*\/\*\s*init\s*\*\/\s*{','tokens')];

        fclose(source_fid);
    end % for n=1:length(sources)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Prepare strings for insertion based on function type
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    prototypes_str   = '';
    commandsdefs_str = '';
    commandsadds_str = '';
    inits_str        = '';
    repeats_str      = '';
    hello_str        = '';

    for n = 1:length(commands)
        command = commands{n};
        prototype_str    = ['void ',command{1},' (int , char**);\n'];
        commanddef_str   = ['static tinysh_cmd_t cmd_',num2str(n),' = {0,"',command{2},'","',command{3},'","',command{4},'",',command{1},',0,0,0};\n'];
        commandadd_str   = ['\ttinysh_add_command(&cmd_',num2str(n),');\n'];
        prototypes_str   = [prototypes_str  , prototype_str ];
        commandsdefs_str = [commandsdefs_str, commanddef_str];
        commandsadds_str = [commandsadds_str, commandadd_str];
    end % for n = 1:length(commands)

    for n = 1:length(inits)
        init = inits{n};
        init_str         = ['\t',init{1},'();\n'];
        inits_str        = [inits_str  , init_str ];
    end % for n = 1:length(inits)

    for n = 1:length(repeats)
        repeat = repeats{n};
        repeat_str       = ['\t\t',repeat{n},'();\n'];
        repeats_str      = [repeats_str  , repeat_str ];
    end % for n = 1:length(repeats)

    hello_str = [hello_str, '\n#define DESIGN_NAME "',sys,'"'];
    hello_str = [hello_str, '\n#define COMPILED_ON "',datestr(now),'"\n'];
    hello_str = [hello_str, '\txil_printf("Design name : " DESIGN_NAME "\\n\\r");\n'];
    hello_str = [hello_str, '\txil_printf("Compiled on : " COMPILED_ON "\\n\\r");\n'];


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Write main.c file
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    str = '';

    if ~exist([xps_path,'\Software\main.c.bac'],'file')
        [copystatus,copymessage,copymessageid] = copyfile([xps_path,'\Software\main.c'],[xps_path,'\Software\main.c.bac']);
        if ~copystatus
            disp('Error trying to backup main.c:')
            disp(copymessage);
        end % if ~copystatus
    end %~exist([xps_path,'\Software\main.c.bac'],'file')
    in_fid = fopen([xps_path,'\Software\main.c.bac'],'r');

    % read out skeleton main.c and detokenize
    while 1
        line = fgets(in_fid);
        if ~ischar(line)
            break;
        else
            toks = regexp(line,'^\s*//IF//(.*)//(.*)','tokens');
            if isempty(toks)
                str = [str, line];
            else
                condition = toks{1}{1};
                real_line = toks{1}{2};
                for n = 1:length(xps_objs)
                    b = xps_objs{n};
                    try
                        if eval(condition)
                            str = [str, real_line];
                            break;
                        end % if eval(condition)
                    end % try
                end % for n = 1:length(xps_objs)
            end % if isempty(toks)
        end % if ~ischar(line)
    end % while 1

    fclose(in_fid);

    % overwrite placeholders with info based on user source
    str = regexprep(str, '\/\*\s*<\s*prototypes\s*>\s*\*\/', prototypes_str);
    str = regexprep(str, '\/\*\s*<\s*commands_defs\s*>\s*\*\/', commandsdefs_str);
    str = regexprep(str, '\/\*\s*<\s*commands_adds\s*>\s*\*\/', commandsadds_str);
    str = regexprep(str, '\/\*\s*<\s*inits\s*>\s*\*\/', inits_str);
    str = regexprep(str, '\/\*\s*<\s*repeats\s*>\s*\*\/', repeats_str);
    str = regexprep(str, '\/\*\s*<\s*hello\s*>\s*\*\/', hello_str);

    main_fid = fopen([xps_path,'\Software\main.c'],'w');
    fwrite(main_fid,str);
    fclose(main_fid);

% end function gen_xps_tinysh_mod_main
