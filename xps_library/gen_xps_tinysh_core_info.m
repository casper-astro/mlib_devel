function gen_xps_tinysh_core_info(xsg_obj, xps_objs, custom_xps_objs, mssge_proj, mssge_paths)
% Generates table of cores used for TinySH
%
% gen_xps_tinysh_core_info(xsg_obj, xps_objs, custom_xps_objs, mssge_proj, mssge_paths)

    %disp('Running gen_xps_tinysh_core_info');

%   hw_sys          = mssge_proj.hw_sys;
%   hw_subsys       = mssge_proj.hw_subsys;
%   sw_os           = mssge_proj.sw_os;
%   app_clk         = mssge_proj.app_clk;
%   app_clk_rate    = mssge_proj.app_clk_rate;
%   xsg_core_name   = mssge_proj.xsg_core_name;

%   XPS_BASE_PATH   = mssge_paths.XPS_BASE_PATH;
%   simulink_path   = mssge_paths.simulink_path;
%   work_path       = mssge_paths.work_path;
%   src_path        = mssge_paths.src_path;
%   xsg_path        = mssge_paths.xsg_path;
%   netlist_path    = mssge_paths.netlist_path;
    xps_path        = mssge_paths.xps_path;

    drivers_path = [xps_path,'\drivers'];
    nfo_fid = fopen([drivers_path,'\core_info.h'],'w');
    fprintf(nfo_fid,'/* ************************************ */\n');
    fprintf(nfo_fid,'/* **                                ** */\n');
    fprintf(nfo_fid,'/* **      Core info header file     ** */\n');
    fprintf(nfo_fid,'/* **                                ** */\n');
    fprintf(nfo_fid,'/* ************************************ */\n');
    fprintf(nfo_fid,'\n');

    fprintf(nfo_fid,'#ifndef CORE_INFO_H\n');
    fprintf(nfo_fid,'#define CORE_INFO_H\n');
    fprintf(nfo_fid,'\n');

    fprintf(nfo_fid,'#include <xbasic_types.h>\n');
    fprintf(nfo_fid,'#include <xparameters.h> \n');
    fprintf(nfo_fid,'\n');

    fprintf(nfo_fid,'typedef enum blk_types {xps_adc,xps_block,xps_bram,xps_corr_adc,xps_corr_dac,xps_corr_mxfe,xps_corr_rf,xps_dram,xps_ethlite,xps_framebuffer,xps_fifo,xps_gpio,xps_interchip,xps_lwip,xps_opb2opb,xps_probe,xps_quadc,xps_sram,xps_sw_reg,xps_tengbe,xps_vsi,xps_xaui,xps_xsg,xps_katadc,');

    custom_xps_types = {};
%    for n=1:length(custom_xps_objs)
%        fprintf(nfo_fid, [get(custom_xps_objs{n},'type'), ',']);
%    end % n=1:length(custom_xps_objs)
    for n=1:length(custom_xps_objs)
        custom_xps_types = [custom_xps_types, {get(custom_xps_objs{n}, 'type')}];
    end
    custom_xps_types = unique(custom_xps_types);

    for n=1:length(custom_xps_types)
        fprintf(nfo_fid, [custom_xps_types{n}, ',']);
    end

    fprintf(nfo_fid,'all} blk_type;\n');

    fprintf(nfo_fid,'typedef struct cores {\n');
    fprintf(nfo_fid,'   char*    name;\n');
    fprintf(nfo_fid,'   blk_type type;\n');
    fprintf(nfo_fid,'   Xuint32  address;\n');
    fprintf(nfo_fid,'   char*    params;\n');
    fprintf(nfo_fid,'} core;\n');
    fprintf(nfo_fid,'\n');

    nb_objs = 0;
    for n=1:length(xps_objs)
        obj_type = get(xps_objs{n},'type');
        nb_objs = nb_objs + 1;
    end % for n=1:length(xps_objs)

    fprintf(nfo_fid,['#define NUM_CORES ',num2str(nb_objs),'\n']);
    fprintf(nfo_fid,'\n');
    fprintf(nfo_fid,'extern core cores[NUM_CORES];\n');
    fprintf(nfo_fid,'\n');
    fprintf(nfo_fid,'#endif\n');
    fclose(nfo_fid);

    nfo_fid = fopen([drivers_path,'\core_info.c'],'w');
    fprintf(nfo_fid,'/* ************************************ */\n');
    fprintf(nfo_fid,'/* **                                ** */\n');
    fprintf(nfo_fid,'/* **          Core info file        ** */\n');
    fprintf(nfo_fid,'/* **                                ** */\n');
    fprintf(nfo_fid,'/* ************************************ */\n');
    fprintf(nfo_fid,'\n');

    fprintf(nfo_fid,'#include "core_info.h"\n');
    fprintf(nfo_fid,'\n');

    fprintf(nfo_fid,'core cores[NUM_CORES] = {\n');

    for n=1:length(xps_objs)
        blk_obj = xps_objs{n};
        try
            str = ['\t',gen_c_core_info(blk_obj)];
        catch
            disp('Problem with block : ')
            display(blk_obj);
            disp(lasterr);
            error('Error found during core info file generation (gen_c_core_info).');
        end % try
        fprintf(nfo_fid,str);
    end % for n=1:length(xps_objs)
    fprintf(nfo_fid,'};\n');
    fclose(nfo_fid);

% end function gen_xps_tinysh_core_info
