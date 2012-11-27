function gen_xps_mod_mss(xsg_obj, xps_objs, mssge_proj, mssge_paths, slash)
% Modifies the EDK project's MSS file to include design elements.
%
% gen_xps_mod_mss(xsg_obj, xps_objs, mssge_proj, mssge_paths)

    %disp('Running gen_xps_mod_mss');

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Extract common design parameters
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   sys             = mssge_proj.sys;
%   hw_sys          = mssge_proj.hw_sys;
%   hw_subsys       = mssge_proj.hw_subsys;
    sw_os           = mssge_proj.sw_os;
%   app_clk         = mssge_proj.app_clk;
%   app_clk_rate    = mssge_proj.app_clk_rate;
%   xsg_core_name   = mssge_proj.xsg_core_name;
%   mpc_type        = mssge_proj.mpc_type;

%   XPS_BASE_PATH   = mssge_paths.XPS_BASE_PATH;
%   simulink_path   = mssge_paths.simulink_path;
%   src_path        = mssge_paths.src_path;
%   xsg_path        = mssge_paths.xsg_path;
%   netlist_path    = mssge_paths.netlist_path;
%   work_path       = mssge_paths.work_path;
    xps_path        = mssge_paths.xps_path;

    if ~strcmp(sw_os,'none')
        if ~exist([xps_path, slash, 'system.mss.bac'],'file')
            [copystatus,copymessage,copymessageid] = copyfile([xps_path, slash, 'system.mss'],[xps_path, slash, 'system.mss.bac']);
            if ~copystatus
                disp('Error trying to backup system.mss:');
                disp(copymessage);
            end % if ~copystatus
        end % if ~exist([xps_path, slash, 'system.mss.bac'],'file')

        in_fid = fopen([xps_path, slash, 'system.mss.bac'],'r');
        mss_fid = fopen([xps_path, slash, 'system.mss'],'w');

        detokenize(in_fid, mss_fid, xps_objs);
        fclose(in_fid);

        fprintf(mss_fid,'############################\n');
        fprintf(mss_fid,'# Simulink interfaces      #\n');
        fprintf(mss_fid,'############################\n');
        fprintf(mss_fid,'\n');

        for n = 1:length(xps_objs)
            blk_obj = xps_objs{n};
            try
                fprintf(mss_fid,['# ',get(blk_obj,'simulink_name'),'\n']);
                fprintf(mss_fid,gen_mss(blk_obj));
                fprintf(mss_fid,'\n');
            catch
                disp('Problem with block : ')
                display(blk_obj);
                disp(lasterr);
                error('Error found during generation in MSS (gen_mss).');
            end
        end
        fprintf(mss_fid,'\n');
        fclose(mss_fid);
    end %if ~strcmp(sw_os,'none')

% end gen_xps_mod_mss
