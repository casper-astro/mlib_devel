%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://seti.ssl.berkeley.edu/casper/                                      %
%   Copyright (C) 2006 University of California, Berkeley                     %
%                                                                             %
%   This program is free software; you can redistribute it and/or modify      %
%   it under the terms of the GNU General Public License as published by      %
%   the Free Software Foundation; either version 2 of the License, or         %
%   (at your option) any later version.                                       %
%                                                                             %
%   This program is distributed in the hope that it will be useful,           %
%   but WITHOUT ANY WARRANTY; without even the implied warranty of            %
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             %
%   GNU General Public License for more details.                              %
%                                                                             %
%   You should have received a copy of the GNU General Public License along   %
%   with this program; if not, write to the Free Software Foundation, Inc.,   %
%   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.               %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [time_total, time_struct] = gen_xps_files(sys,flow_vec)
% Generate all necessary file and optionally run the Xilinx backed tools

% close all previously opened files
fclose('all');

% flow step options
if nargin == 2 & isstruct(flow_vec)
    run_update   = flow_vec.update  ;
    run_drc      = flow_vec.drc     ;
    run_xsg      = flow_vec.xsg     ;
    run_copy     = flow_vec.copy    ;
    run_ip       = flow_vec.ip      ;
    run_edkgen   = flow_vec.edkgen  ;
    run_elab     = flow_vec.elab    ;
    run_software = flow_vec.software;
    run_edk      = flow_vec.edk     ;
    run_download = flow_vec.download;
else
    run_update   = 1;
    run_drc      = 1;
    run_xsg      = 1;
    run_copy     = 1;
    run_ip       = 1;
    run_edkgen   = 1;
    run_elab     = 1;
    run_software = 1;
    run_edk      = 1;
    run_download = 0;
end

time_update   = 0;
time_drc      = 0;
time_xsg      = 0;
time_copy     = 0;
time_ip       = 0;
time_edkgen   = 0;
time_elab     = 0;
time_software = 0;
time_edk      = 0;
time_download = 0;

% check if the system name is correct
if upper(sys(1))==sys(1)
    error('Due to EDK toolflow limitations, the system name cannot start with an upper case letter');
end

xps_blks = find_system(sys,'FollowLinks','on','LookUnderMasks','all','RegExp','on','Tag','^xps:');
xps_xsg_blks = find_system(sys,'FollowLinks','on','LookUnderMasks','all','Tag','xps:xsg');
if length(xps_xsg_blks) ~= 1
    error('There has to be exactly 1 XPS_xsg block on each chip level (sub)system (Is the current system the correct one ?)');
end
xsg_blk = xps_xsg_blks{1};

sysgen_blk = find_system(sys, 'SearchDepth', 1,'FollowLinks','on','LookUnderMasks','all','Tag','genX');
if length(sysgen_blk) == 1
    xsg_blk = sysgen_blk{1};
else
    error('XPS_xsg block must be on the same level as the Xilinx SysGen block. (Have you put a XSG block in you design, and is the current system the correct one ?)');
end

xps_pcore_blks = find_system(sys,'FollowLinks','on','LookUnderMasks','all','Tag','xps:pcore');

% cd into the design directory
sys_file = get_param(sys,'FileName');
[sys_dir, temp1, temp2, temp3] = fileparts(sys_file);
cd(sys_dir);

gateways_blk = find_system(sys, 'FollowLinks','on','LookUnderMasks','all','masktype','Xilinx Gateway In Block');
for i=[1:length(gateways_blk)]
    found_xps_tag = 0;
    parent = get_param(gateways_blk(i),'parent');
    gw_parent = parent;

    while ~strcmp(parent,'')
        parent_tag = char(get_param(parent,'tag'));
        if ~isempty(regexp(parent_tag,'^xps:'))
            found_xps_tag = 1;
        end
        parent = get_param(parent,'parent');
    end
    parent_tag = char(get_param(get_param(gateways_blk(i),'parent'),'tag'));
    if found_xps_tag == 0
        disregard_blocks = find_system(gw_parent, 'FollowLinks','on','LookUnderMasks','all','masktype','Xilinx Disregard Subsystem For Generation');
        if isempty(disregard_blocks)
            error('Xilinx input gateways cannot be used in a design. Only XPS GPIO blocks should be used.');
        end
    end
end

XPS_LIB_PATH = getenv('BEE2_XPS_LIB_PATH');
if isempty(XPS_LIB_PATH)
    error('Environment variable BEE2_XPS_LIB_PATH must be defined');
end


simulink_path = pwd;
design_name = clear_name(get_param(xsg_blk,'parent'));
work_path = [simulink_path,'\',clear_name(get_param(xsg_blk,'parent'))];
if exist(work_path,'dir') ~= 7
    mkdir(pwd,clear_name(get_param(xsg_blk,'parent')));
end
src_path = [work_path,'\src'];
if exist(src_path,'dir') ~= 7
    mkdir(work_path,'src');
end
xsg_path = [work_path,'\sysgen'];
bit_path = [work_path,'\bit_files'];
if exist(bit_path,'dir') ~= 7
    mkdir(work_path,'bit_files');
end
netlist_path = [work_path,'\netlist'];
if exist(netlist_path,'dir') ~= 7
    mkdir(work_path,'netlist');
end

start_time = now;
if run_update
disp('#############################');
disp('##      System Update      ##');
disp('#############################');
    % update the current system
    set_param(sys,'SimulationCommand','update');
end
time_update = now - start_time;

%access all XPS blocks
disp('#############################');
disp('## Block objects creation  ##');
disp('#############################');
xps_objs = {};
probe_objs = {};
blocks_types = {};
custom_xps_objs = {};
core_types = {};
j=0;
for i = 1:length(xps_blks)
    if strcmp(get_param(xps_blks(i),'tag'),'xps:xsg')
        try
            xsg_obj = xps_block(xps_blks{i},{});
            xsg_obj = xps_xsg(xsg_obj);
            nb_objs.xps_xsg = 1;
        catch
            disp(['Problem with block: ',xps_blks{i}]);
            disp(lasterr);
            error('Error found during Object creation.');
        end
    end
end
for i = 1:length(xps_blks)
    if ~(strcmp(get_param(xps_blks(i),'tag'),'xps:xsg') || strcmp(get_param(xps_blks(i),'tag'),'xps:pcore'))
        try
            blk_obj = xps_block(xps_blks{i},xsg_obj);
            eval(['blk_obj = ',get(blk_obj,'type'),'(blk_obj);']);

            xps_objs = [xps_objs,{blk_obj}];

            if isempty(find(strcmp(get(blk_obj, 'type'), {'xps_adc' 'xps_block' 'xps_bram' 'xps_corr_adc' 'xps_corr_dac' 'xps_corr_mxfe' 'xps_corr_rf' 'xps_dram' 'xps_ethlite' 'xps_framebuffer' 'xps_fifo' 'xps_gpio' 'xps_interchip' 'xps_lwip' 'xps_opb2opb' 'xps_plb2opb' 'xps_probe' 'xps_sram' 'xps_sw_reg' 'xps_tengbe' 'xps_vsi' 'xps_xaui' 'xps_xsg'})))
                custom_xps_objs = [custom_xps_objs, {blk_obj}];
            else
                if isempty(find(strcmp(get(blk_obj, 'type'), core_types)))
                    core_types = [core_types, {get(blk_obj, 'type')}];
                end
            end

            try
                eval(['nb_objs.',get(blk_obj,'type'),' = nb_objs.',get(blk_obj,'type'),' + 1;'])
            catch
                eval(['nb_objs.',get(blk_obj,'type'),' = 1;'])
            end
        catch
            disp(['Problem with block: ',xps_blks{i}]);
            disp(lasterr);
            error('Error found during Object creation.');
        end
    end
end
xps_objs = [{xsg_obj},xps_objs];

hw_sys = get(xsg_obj,'hw_sys');
sw_os = get(xsg_obj,'sw_os');
mpc_type = get(xsg_obj,'mpc_type');
app_clk = get(xsg_obj,'clk_src');
app_clk_rate = get(xsg_obj,'clk_rate');
xsg_core_name = clear_name(get(xsg_obj,'parent'));
xps_path = [work_path,'\XPS_',hw_sys,'_base'];

start_time = now;
if run_drc
    disp('######################');
    disp('## Checking objects ##');
    disp('######################');
    for n=1:length(xps_objs)
        [result, msg] = drc(xps_objs{n},xps_objs);
        if result
            disp('Error with block:');
            display(xps_objs{n});
            disp(msg);
            error('DRC failed!');
        end
    end
end
time_drc = now - start_time;

start_time = now;
if run_xsg
    if exist(xsg_path,'dir')
        rmdir(xsg_path,'s');
    end
    disp('Running system generator ...');
    xsg_result = xlGenerateButton(xsg_blk);
    if xsg_result == 0
        disp('XSG generation complete.');
    else
        error(['XSG generation failed: ',xsg_result]);
        help xlGenerateButton;
    end
end
time_xsg = now - start_time;

start_time = now;
if run_copy
    disp('#########################');
    disp('## Copying base system ##');
    disp('#########################');
    if exist(xps_path,'dir')
        rmdir(xps_path,'s');
    end
    if exist([XPS_LIB_PATH,'\XPS_',hw_sys,'_base'],'dir')
        mkdir(xps_path);
        [copy_result,copy_message] = dos(['xcopy /Q /E /Y ', getenv('BEE2_XPS_LIB_PATH'), '\XPS_',hw_sys,'_base ', xps_path,'\.']);
        if copy_result
            cd(simulink_path);
            error('Unpackage base system files failed.');
        else
            cd(simulink_path);
        end
    else
        error(['Base XPS package "','XPS_',hw_sys,'_base" does not exist.']);
    end
end
time_copy = now - start_time;

start_time = now;
if run_ip
    disp('########################');
    disp('## Copying custom IPs ##');
    disp('########################');

    cd(simulink_path);
    for n = 1:length(xps_pcore_blks)
        path_param = get_param(xps_pcore_blks(n), 'pcore_path');
        pcore_path = clear_path(path_param{1});

        if dos(['xcopy /E /Y ', pcore_path, ' ', work_path, '\XPS_', hw_sys, '_base\pcores\']);
            cd(simulink_path);
            error(['Error copying custom pcores from ', pcore_path]);
        end
    end

    disp('##########################');
    disp('## Creating Simulink IP ##');
    disp('##########################');

    % delete old IP directory in the pcores directory
    if exist([xps_path,'\pcores\',xsg_core_name,'_v1_00_a'],'dir')
        rmdir([xps_path,'\pcores\',xsg_core_name,'_v1_00_a'],'s');
    end

    % create IP directory in the pcores directory
    mkdir([xps_path,'\pcores\',xsg_core_name,'_v1_00_a']);
    mkdir([xps_path,'\pcores\',xsg_core_name,'_v1_00_a'],'netlist');
    mkdir([xps_path,'\pcores\',xsg_core_name,'_v1_00_a'],'data');

    % copy the XSG netlist into the netlist directory
    file_name = [xsg_core_name,'_cw_complete.ngc'];
    if ~exist([xsg_path,'\synth_model\',file_name],'file')
        error('Cannot find any compiled XSG netlist. Have you run the Xilinx System Generator on your design ?')
    end
    copyfile([xsg_path,'\synth_model\',file_name],[xps_path,'\pcores\',xsg_core_name,'_v1_00_a\netlist\',xsg_core_name,'.ngc']);

    % create the BBD file in the data directory
    bbd_fid = fopen([xps_path,'\pcores\',xsg_core_name,'_v1_00_a\data\',xsg_core_name,'_v2_1_0.bbd'],'w');
    if bbd_fid == -1
        error(['Cannot open file ',xps_path,'\pcores\',xsg_core_name,'_v1_00_a\data\',xsg_core_name,'_v2_1_0.bbd for writing.'])
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
    mpd_fid = fopen([xps_path,'\pcores\',xsg_core_name,'_v1_00_a\data\',xsg_core_name,'_v2_1_0.mpd'],'w');
    if mpd_fid == -1
        error(['Cannot open file ',xps_path,'\pcores\',xsg_core_name,'_v1_00_a\data\',xsg_core_name,'_v2_1_0.mpd for writing.'])
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
end
time_ip = now - start_time;

start_time = now;
if run_edkgen
    disp('##########################');
    disp('## Creating EDK files   ##');
    disp('##########################');

    %modifying MHS file
    switch hw_sys
        case 'ROACH'
            plb_slaves = 0;
            opb_slaves = 2; % The system block and the adc controller

            opb_addr        = hex2dec('01000000');
            plb_addr        = hex2dec('04000000');
            opb_bridge_size = hex2dec('00080000');
        % end case 'ROACH'
        otherwise
            plb_slaves = 2; % the memory and the opb bridge
            opb_slaves = 3; % the UART, the selectmap fifo and the serial switch reader

            opb_addr = hex2dec('d0000000');
            plb_addr = hex2dec('40000000');
            opb_bridge_size = 2^24;
        % end case otherwise
    end % switch hw_sys

    opb_bus_inst = 0;
    plb_name = 'plb';
    opb_name = 'opb0';

    if ~exist([xps_path,'\system.mhs.bac'],'file')
        copyfile([xps_path,'\system.mhs'],[xps_path,'\system.mhs.bac']);
    end
    in_fid = fopen([xps_path,'/system.mhs.bac'],'r');
    mhs_fid = fopen([xps_path,'/system.mhs'],'w');
    nfo_fid = fopen([work_path, '/core_info.m'],'w');
    bof_fid = fopen([xps_path, '/core_info.tab'],'w');

    while 1
        line = fgets(in_fid);
        if ~ischar(line)
            break;
        else
            toks = regexp(line,'(.*)#IF#(.*)#(.*)','tokens');
            if isempty(toks)
                fprintf(mhs_fid,line);
            else
                default   = toks{1}{1};
                condition = toks{1}{2};
                real_line = toks{1}{3};
                condition_met = 0;
                for i = 1:length(xps_objs)
                    b = xps_objs{i};
                    try
                        if eval(condition)
                            condition_met = 1;
                            fprintf(mhs_fid,real_line);
                            break;
                        end
                    end
                end
                if ~condition_met & ~isempty(default)
                    fprintf(mhs_fid, [default, '\n']);
                end
            end
        end
    end
    fclose(in_fid);

    fprintf(mhs_fid,'##############################################\n');
    fprintf(mhs_fid,'# User XSG IP core                           #\n');
    fprintf(mhs_fid,'##############################################\n');
    fprintf(mhs_fid,'\n');
    fprintf(mhs_fid,['BEGIN ',xsg_core_name,'\n']);
    try
        for n = 1:length(xps_objs)
            blk_obj = xps_objs{n};
            [str, opb_addr, plb_addr] = gen_mhs_xsg(blk_obj,opb_addr,plb_addr,plb_name,opb_name);
            fprintf(mhs_fid,str);
        end
    catch
        disp('Problem with block : ')
        display(blk_obj);
        disp(lasterr);
        error('Error found during XSG IP core generation in MHS (gen_mhs_xsg).');
    end
    fprintf(mhs_fid,'END\n\n');

    fprintf(mhs_fid,'############################\n');
    fprintf(mhs_fid,'# Simulink interfaces      #\n');
    fprintf(mhs_fid,'############################\n');
    fprintf(mhs_fid,'\n');

    n = 1;
    loc = 0;
    while n <= length(xps_objs)
        blk_obj = xps_objs{n};
        [plb_cores, opb_cores] = probe_bus_usage(blk_obj);
        if plb_cores + plb_slaves > 16
            error('The total number of slave cores on PLB bus exceed 16 devices');
        else
            plb_slaves = plb_slaves + plb_cores;
        end
        switch mpc_type
            case 'powerpc405'
                if opb_cores + opb_slaves > 16
                    opb_bus_inst = opb_bus_inst + 1;
                    opb_slaves = 0;
                    opb_name = ['opb',num2str(opb_bus_inst)];
                    opb_bridge_obj = xps_plb2opb(opb_name,opb_addr,opb_bridge_size);
                    opb_addr = get(opb_bridge_obj,'opb_addr_start');
                    xps_objs = [xps_objs,{opb_bridge_obj}];
                else
                    opb_slaves = opb_slaves + opb_cores;
                end
            case 'microblaze'
                if plb_slaves ~= 0
                    error('Microblaze processor does not support PLB devices.');
                end
                if opb_cores + opb_slaves > 16
                    error('OPB exceeds 16 total slave devices.');
                else
                    opb_slaves = opb_slaves + opb_cores;
                end
            case 'powerpc440_ext'
                if opb_cores + opb_slaves > 32
                    opb_bus_inst = opb_bus_inst + 1;
                    opb_slaves = 0;
                    opb_name = ['opb',num2str(opb_bus_inst)];
                    opb_addr = hex2dec('01000000') + opb_bus_inst * opb_bridge_size;
                    opb_bridge_obj = xps_opb2opb(opb_name,opb_addr,opb_bridge_size);
                    xps_objs = [xps_objs,{opb_bridge_obj}];
                else
                    opb_slaves = opb_slaves + opb_cores;
                end
                if plb_slaves ~= 0
                    error('External PowerPC 440 does not support PLB devices.');
                end
            otherwise
                error(['Unsupported MPC type: ',mpc_type]);
        end

        try
            [str, opb_addr, plb_addr] = gen_mhs_ip(blk_obj,opb_addr,plb_addr,plb_name,opb_name);
        catch
            disp('Problem with block : ')
            display(blk_obj);
            disp(lasterr);
            error('Error found during Peripheral generation in MHS (gen_mhs_ip).');
        end
        fprintf(mhs_fid,['# ',get(blk_obj,'simulink_name'),'\n']);
        fprintf(mhs_fid,str);
        fprintf(mhs_fid,'\n');

        [str, loc] = gen_borf_info(loc, blk_obj);
        fprintf(bof_fid,str);

        str = gen_m_core_info(blk_obj, str);
        fprintf(nfo_fid,['%% ',get(blk_obj,'simulink_name'),'\n']);
        fprintf(nfo_fid,str);
        fprintf(nfo_fid,'\n');

        n = n + 1;
    end
    fclose(mhs_fid);
    fclose(nfo_fid);
    fclose(bof_fid);

    % modifying MSS file

    if ~strcmp(sw_os,'none')
        if ~exist([xps_path,'\system.mss.bac'],'file')
            copyfile([xps_path,'\system.mss'],[xps_path,'\system.mss.bac']);
        end
        in_fid = fopen([xps_path,'/system.mss.bac'],'r');
        mss_fid = fopen([xps_path,'/system.mss'],'w');

        while 1
            line = fgets(in_fid);
            if ~ischar(line)
                break;
            else
                toks = regexp(line,'(.*)#IF#(.*)#(.*)','tokens');
                if isempty(toks)
                    fprintf(mss_fid,line);
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
                                fprintf(mss_fid,real_line);
                                break;
                            end
                        end
                    end
                    if ~condition_met && ~isempty(default)
                        fprintf(mss_fid, [default, '\n']);
                    end
                end
            end
        end
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

    % modifying UCF file
    if ~exist([xps_path,'\data\system.ucf.bac'],'file')
        copyfile([xps_path,'\data\system.ucf'],[xps_path,'\data\system.ucf.bac']);
    end
    in_fid = fopen([xps_path,'/data/system.ucf.bac'],'r');
    ucf_fid = fopen([xps_path,'/data/system.ucf'],'w');

    while 1
        line = fgets(in_fid);
        if ~ischar(line)
            break;
        else
            toks = regexp(line,'(.*)#IF#(.*)#(.*)','tokens');
            if isempty(toks)
                fprintf(ucf_fid,line);
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
                            fprintf(ucf_fid,real_line);
                            break;
                        end
                    end
                end
                if ~condition_met && ~isempty(default)
                    fprintf(ucf_fid, [default, '\n']);
                end
            end
        end
    end
    fclose(in_fid);

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
        error('?Error found during IP UCF generation in MHS');
    end
    fprintf(ucf_fid,'\n');
    fclose(ucf_fid);
end
time_edkgen = now - start_time;

start_time = now;
if run_elab
    disp('#########################');
    disp('## Elaborating objects ##');
    disp('#########################');
    for n=1:length(xps_objs)
        try
            xps_objs{n} = elaborate(xps_objs{n});
        catch
            display(xps_objs{n})
            disp(lasterr)
            error(['Elaboration of object failed.'])
        end
    end
end
time_elab = now - start_time;

start_time = now;
if run_software
    disp('##############################');
    disp('## Preparing software files ##');
    disp('##############################');

    switch sw_os
        case 'tinySH'
            % Creating software core info files
            src_path = [xps_path,'\drivers'];
            nfo_fid = fopen([src_path,'\core_info.h'],'w');
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

            fprintf(nfo_fid,'typedef enum blk_types {xps_adc,xps_block,xps_bram,xps_corr_adc,xps_corr_dac,xps_corr_mxfe,xps_corr_rf,xps_dram,xps_ethlite,xps_framebuffer,xps_fifo,xps_gpio,xps_interchip,xps_lwip,xps_plb2opb,xps_opb2opb,xps_probe,xps_sram,xps_sw_reg,xps_tengbe,xps_vsi,xps_xaui,xps_xsg,');

            for n=1:length(custom_xps_objs)
                fprintf(nfo_fid, [get(custom_xps_objs{n},'type'), ',']);
            end % n=1:length(custom_xps_objs)

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
                if ~strcmp(obj_type, 'xps_plb2opb')
                    nb_objs = nb_objs + 1;
                end
            end % for n=1:length(xps_objs)

            fprintf(nfo_fid,['#define NUM_CORES ',num2str(nb_objs),'\n']);
            fprintf(nfo_fid,'\n');
            fprintf(nfo_fid,'extern core cores[NUM_CORES];\n');
            fprintf(nfo_fid,'\n');
            fprintf(nfo_fid,'#endif\n');
            fclose(nfo_fid);

            src_path = [xps_path,'\drivers'];
            nfo_fid = fopen([src_path,'\core_info.c'],'w');
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

            % Gathering information on the software files
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

            % Reading source code and extracting functions information
            commands = {};
            repeats = {};
            inits = {};
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

            % prepare strings for text insertion
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


            % write main.c file
            str = '';
            if ~exist([xps_path,'\Software\main.c.bac'],'file')
                copyfile([xps_path,'\Software\main.c'],[xps_path,'\Software\main.c.bac']);
            end
            in_fid = fopen([xps_path,'\Software\main.c.bac'],'r');

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

            str = regexprep(str, '\/\*\s*<\s*prototypes\s*>\s*\*\/', prototypes_str);
            str = regexprep(str, '\/\*\s*<\s*commands_defs\s*>\s*\*\/', commandsdefs_str);
            str = regexprep(str, '\/\*\s*<\s*commands_adds\s*>\s*\*\/', commandsadds_str);
            str = regexprep(str, '\/\*\s*<\s*inits\s*>\s*\*\/', inits_str);
            str = regexprep(str, '\/\*\s*<\s*repeats\s*>\s*\*\/', repeats_str);
            str = regexprep(str, '\/\*\s*<\s*hello\s*>\s*\*\/', hello_str);
            main_fid = fopen([xps_path,'\Software\main.c'],'w');

            fwrite(main_fid,str);
            fclose(main_fid);

            % write project file
            str = '';
            if ~exist([xps_path,'\system.xmp.bac'],'file')
                copyfile([xps_path,'\system.xmp'],[xps_path,'\system.xmp.bac']);
            end
            in_fid = fopen([xps_path,'\system.xmp.bac'],'r');

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
        % end case 'tinySH'

        case 'linux'

        case 'none'

        otherwise
            error(['Unsupported OS: ',sw_os]);
    end % switch sw_os

    win_fid = fopen([xps_path,'\gen_prog_files.bat'],'w');
    unix_fid = fopen([xps_path,'\gen_prog_files'],'w');
    fprintf(unix_fid,['#!/bin/bash\n']);
    time_stamp = clear_name(datestr(now, 'yyyy-mmm-dd HHMM'));

    switch sw_os
        case 'none'
            fprintf(win_fid,['copy implementation\\system.bit ..\\bit_files\\',design_name,'_',time_stamp,'.bit\n']);
            fprintf(unix_fid,['cp implementation/system.bit ../bit_files/',design_name,'_',time_stamp,'.bit\n']);
        % end case 'none'
        otherwise
            fprintf(win_fid,['copy implementation\\download.bit ..\\bit_files\\',design_name,'_',time_stamp,'.bit\n']);
            fprintf(unix_fid,['cp implementation/download.bit ../bit_files/',design_name,'_',time_stamp,'.bit\n']);
        % end otherwise
    end % switch sw_os

    if strcmp(hw_sys, 'iBOB')
        fprintf(win_fid,'mkbof.exe -o implementation\\download.bof -s core_info.tab -p 4 -c -v implementation\\download.bit\n');
        fprintf(unix_fid,'./mkbof -o implementation/download.bof -s core_info.tab -p 4 -c -v implementation/download.bit\n');
        fprintf(win_fid,['copy implementation\\download.bof ..\\bit_files\\',design_name,'_',time_stamp,'.bof\n']);
        fprintf(unix_fid,['cp implementation/download.bof ../bit_files/',design_name,'_',time_stamp,'.bof\n']);
    end % if strcmp*hw_sys, 'iBOB')
    if strcmp(hw_sys, 'BEE2_ctrl')
        fprintf(win_fid,'xmd -tcl ./genace.tcl -opt bee2Genace.opt\n');
        fprintf(unix_fid,'xmd -tcl ./genace.tcl -opt bee2Genace.opt\n');
        fprintf(win_fid,['copy implementation\\cflash.ace ..\\bit_files\\',design_name,'_',time_stamp,'.ace\n']);
        fprintf(unix_fid,['cp implementation/cflash.ace ../bit_files/',design_name,'_',time_stamp,'.ace\n']);
        fprintf(win_fid,'mkbof.exe -o implementation\\download.bof -s core_info.tab -p 4 -c -v implementation\\download.bit\n');
        fprintf(unix_fid,'./mkbof -o implementation/download.bof -s core_info.tab -p 4 -c -v implementation/download.bit\n');
        fprintf(win_fid,['copy implementation\\download.bof ..\\bit_files\\',design_name,'_',time_stamp,'.bof\n']);
        fprintf(unix_fid,['cp implementation/download.bof ../bit_files/',design_name,'_',time_stamp,'.bof\n']);
    end % if strcmp(hw_sys, 'BEE2_ctrl')
    if strcmp(hw_sys, 'BEE2_usr')
        fprintf(win_fid,'mkbof.exe -o implementation\\download.bof -s core_info.tab -v implementation\\download.bit\n');
        fprintf(unix_fid,'./mkbof -o implementation/download.bof -s core_info.tab -v implementation/download.bit\n');
        fprintf(win_fid,['copy implementation\\download.bof ..\\bit_files\\',design_name,'_floating_',time_stamp,'.bof\n']);
        fprintf(unix_fid,['cp implementation/download.bof ../bit_files/',design_name,'_floating_',time_stamp,'.bof\n']);
        fprintf(win_fid,'mkbof.exe -o implementation\\download.bof -s core_info.tab -p 0 -v implementation\\download.bit\n');
        fprintf(unix_fid,'./mkbof -o implementation/download.bof -s core_info.tab -p 0 -v implementation/download.bit\n');
        fprintf(win_fid,['copy implementation\\download.bof ..\\bit_files\\',design_name,'_fpga1_',time_stamp,'.bof\n']);
        fprintf(unix_fid,['cp implementation/download.bof ../bit_files/',design_name,'_fpga1_',time_stamp,'.bof\n']);
        fprintf(win_fid,'mkbof.exe -o implementation\\download.bof -s core_info.tab -p 1 -v implementation\\download.bit\n');
        fprintf(unix_fid,'./mkbof -o implementation/download.bof -s core_info.tab -p 1 -v implementation/download.bit\n');
        fprintf(win_fid,['copy implementation\\download.bof ..\\bit_files\\',design_name,'_fpga2_',time_stamp,'.bof\n']);
        fprintf(unix_fid,['cp implementation/download.bof ../bit_files/',design_name,'_fpga2_',time_stamp,'.bof\n']);
        fprintf(win_fid,'mkbof.exe -o implementation\\download.bof -s core_info.tab -p 2 -v implementation\\download.bit\n');
        fprintf(unix_fid,'./mkbof -o implementation/download.bof -s core_info.tab -p 2 -v implementation/download.bit\n');
        fprintf(win_fid,['copy implementation\\download.bof ..\\bit_files\\',design_name,'_fpga3_',time_stamp,'.bof\n']);
        fprintf(unix_fid,['cp implementation/download.bof ../bit_files/',design_name,'_fpga3_',time_stamp,'.bof\n']);
        fprintf(win_fid,'mkbof.exe -o implementation\\download.bof -s core_info.tab -p 3 -v implementation\\download.bit\n');
        fprintf(unix_fid,'./mkbof -o implementation/download.bof -s core_info.tab -p 3 -v implementation/download.bit\n');
        fprintf(win_fid,['copy implementation\\download.bof ..\\bit_files\\',design_name,'_fpga4_',time_stamp,'.bof\n']);
        fprintf(unix_fid,['cp implementation/download.bof ../bit_files/',design_name,'_fpga4_',time_stamp,'.bof\n']);
    end % if strcmp(hw_sys, 'BEE2_usr')

    fclose(win_fid);
    fclose(unix_fid);

end % if run_software
time_software = now - start_time;

start_time = now;
if run_edk
    disp('#########################');
    disp('## Running EDK backend ##');
    disp('#########################');
    % erase download.bit to make sure a failing compilation will report an error
    delete([xps_path,'\implementation\system.bit']);
    delete([xps_path,'\implementation\download.bit']);
    fid = fopen([xps_path,'\run_xps.tcl'],'w');

    mpc_type = get(xsg_obj,'mpc_type');

    switch mpc_type
        case 'powerpc440_ext'
            fprintf(fid,['run bits\n']);
        % end case 'powerpc440_ext'
        otherwise
            fprintf(fid,['run init_bram\n']);
        % end otherwise
    end % switch mpc_type
    fprintf(fid,['exit\n']);
    fclose(fid);

    eval(['cd ',xps_path]);
    if(dos(['xps -nw -scr run_xps.tcl system.xmp']))
        cd(simulink_path);
        error('XPS failed.');
    else
        if dos ('gen_prog_files.bat')
            cd(simulink_path);
            error('Programation files generation failed, EDK compilation probably also failed.');
        end % if dos ('gen_prog_files.bat')
    end % if(dos(['xps -nw -scr run_xps.tcl system.xmp']))

    cd(simulink_path);
end % if run_edk
time_edk = now - start_time;

start_time = now;
if run_download
    fid = fopen([xps_path,'/run_download.tcl'],'w');
    fprintf(fid,['run download\n']);
    fprintf(fid,['exit\n']);
    fclose(fid);
    eval(['cd ',xps_path]);
    if(dos(['xps -nw -scr run_download.tcl system.xmp']))
        cd(simulink_path);
        error('Download failed.');
    end % if(dos(['xps -nw -scr run_download.tcl system.xmp']))
    cd(simulink_path);
end % if run_download
time_download = now - start_time;

time_total = time_update + time_drc + time_xsg + time_copy + time_ip + time_edkgen + time_elab + time_software + time_edk + time_download;

time_struct.update   = time_update   ;
time_struct.drc      = time_drc      ;
time_struct.xsg      = time_xsg      ;
time_struct.copy     = time_copy     ;
time_struct.ip       = time_ip       ;
time_struct.edkgen   = time_edkgen   ;
time_struct.elab     = time_elab     ;
time_struct.software = time_software ;
time_struct.edk      = time_edk      ;
time_struct.download = time_download ;
