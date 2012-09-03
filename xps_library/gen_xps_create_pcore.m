function gen_xps_create_pcore(xsg_obj, xps_objs, mssge_proj, mssge_paths, slash)
% Generates the EDK pcore from the compiled Simulink/System Generator design.
%
% gen_xps_create_pcore(xsg_obj, xps_objs, mssge_proj, mssge_paths)

    %disp('Running gen_xps_create_pcore');

%   hw_sys          = mssge_proj.hw_sys;
%   hw_subsys       = mssge_proj.hw_subsys;
%   sw_os           = mssge_proj.sw_os;
%   mpc_type        = mssge_proj.mpc_type;
    app_clk         = mssge_proj.app_clk;
    app_clk_rate    = mssge_proj.app_clk_rate;
    xsg_core_name   = mssge_proj.xsg_core_name;

%   XPS_BASE_PATH   = mssge_paths.XPS_BASE_PATH;
%   simulink_path   = mssge_paths.simulink_path;
%   work_path       = mssge_paths.work_path;
%   src_path        = mssge_paths.src_path;
    xsg_path        = mssge_paths.xsg_path;
%   netlist_path    = mssge_paths.netlist_path;
    xps_path        = mssge_paths.xps_path;

    disp('##########################');
    disp('## Creating Simulink IP ##');
    disp('##########################');

    % delete old IP directory in the pcores directory
    if exist([xps_path, slash, 'pcores', slash, xsg_core_name,'_v1_00_a'],'dir')
        rmdir([xps_path, slash, 'pcores', slash, xsg_core_name,'_v1_00_a'],'s');
    end

    % create IP directory in the pcores directory
    mkdir([xps_path, slash, 'pcores', slash, xsg_core_name,'_v1_00_a']);
    mkdir([xps_path, slash, 'pcores', slash, xsg_core_name,'_v1_00_a'],'netlist');
    mkdir([xps_path, slash, 'pcores', slash, xsg_core_name,'_v1_00_a'],'data');

    % copy the XSG netlist into the netlist directory
    file_name = [xsg_core_name,'_cw_complete.ngc'];
    if ~exist([xsg_path, slash, 'synth_model', slash, file_name],'file')
        error('Cannot find any compiled XSG netlist. Have you run the Xilinx System Generator on your design ?')
    end
    [copystatus,copymessage,copymessageid] = copyfile([xsg_path, slash, 'synth_model', slash,file_name],[xps_path, slash, 'pcores', slash, xsg_core_name,'_v1_00_a', slash, 'netlist', slash, xsg_core_name,'.ngc']);
    if ~copystatus
        disp('Error trying to copy pcore netlist:');
        disp(copymessage);
    end % if ~copystatus

    % create the BBD file in the data directory
    bbd_fid = fopen([xps_path, slash,'pcores', slash,xsg_core_name,'_v1_00_a', slash,'data', slash,xsg_core_name,'_v2_1_0.bbd'],'w');
    if bbd_fid == -1
        error(['Cannot open file ',xps_path, slash, 'pcores',slash,xsg_core_name,'_v1_00_a',slash,'data',slash,xsg_core_name,'_v2_1_0.bbd for writing.'])
    end

    fprintf(bbd_fid, '#############################################################################\n');
    fprintf(bbd_fid, '##\n');
    fprintf(bbd_fid,['## IP Name  : ',xsg_core_name,'\n']);
    fprintf(bbd_fid, '## Desc     : Automatically generated IP core wrapping a\n');
    fprintf(bbd_fid, '##            Simulink Xilinx System Generator netlist.\n');
    fprintf(bbd_fid, '##            Please do not modify by hand, this file will be erased\n');
    fprintf(bbd_fid, '##\n');
    fprintf(bbd_fid, '#############################################################################\n');
    fprintf(bbd_fid, '\n');
    fprintf(bbd_fid, 'Files\n');
    fprintf(bbd_fid,[xsg_core_name,'.ngc\n']);
    fclose(bbd_fid);

    % create the MPD file in the data directory
    mpd_fid = fopen([xps_path, slash, 'pcores', slash,xsg_core_name,'_v1_00_a',slash, 'data', slash, xsg_core_name,'_v2_1_0.mpd'],'w');
    if mpd_fid == -1
        error(['Cannot open file ',xps_path, slash,'pcores', slash,xsg_core_name,'_v1_00_a', slash,'data',slash,xsg_core_name,'_v2_1_0.mpd for writing.'])
    end

    fprintf(mpd_fid, '#############################################################################\n');
    fprintf(mpd_fid, '##\n');
    fprintf(mpd_fid,['## IP Name  : ',xsg_core_name,'\n']);
    fprintf(mpd_fid, '## Desc     : Automatically generated IP core wrapping a\n');
    fprintf(mpd_fid, '##            Simulink Xilinx System Generator netlist.\n');
    fprintf(mpd_fid, '##            Please do not modify by hand, this file will be erased\n');
    fprintf(mpd_fid, '##\n');
    fprintf(mpd_fid, '#############################################################################\n');
    fprintf(mpd_fid, '\n');
    fprintf(mpd_fid,['BEGIN ',xsg_core_name,'\n']);
    fprintf(mpd_fid, '\n');
    fprintf(mpd_fid, '###################\n');
    fprintf(mpd_fid, '# Generic Options #\n');
    fprintf(mpd_fid, '###################\n');
    fprintf(mpd_fid, 'OPTION IPTYPE = IP\n');
    fprintf(mpd_fid, 'OPTION STYLE  = BLACKBOX\n');
    fprintf(mpd_fid, '\n');
    fprintf(mpd_fid, '###################\n');
    fprintf(mpd_fid, '# Clock port      #\n');
    fprintf(mpd_fid, '###################\n');
    fprintf(mpd_fid,['PORT clk = "", DIR = I, SIGIS = CLK, CLK_FREQ = ', num2str(app_clk_rate*1e6), '\n']);
    fprintf(mpd_fid, '\n');
    fprintf(mpd_fid, '###################\n');
    fprintf(mpd_fid, '# Interfaces      #\n');
    fprintf(mpd_fid, '###################\n');
    fprintf(mpd_fid, '\n');

    try
        for n = 1:length(xps_objs)
            blk_obj = xps_objs{n};
            fprintf(mpd_fid,['# ',get(blk_obj,'simulink_name'),'\n']);
            fprintf(mpd_fid,gen_mpd(blk_obj));
            fprintf(mpd_fid,'\n');
        end
    catch
        disp('Problem with block : ')
        display(blk_obj);
        disp(lasterr);
        error('Error found during Peripheral generation in MPD (gen_mpd).');
    end

    fprintf(mpd_fid,['END\n']);
    fclose(mpd_fid);

% end function
