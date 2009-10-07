function gen_xps_mod_mhs(xsg_obj, xps_objs, mssge_proj, mssge_paths, slash)
% Modifies the EDK project's MHS file to include design elements.
%
% gen_xps_mod_mhs(xsg_obj, xps_objs, mssge_proj, mssge_paths, slash)

    %disp('Running gen_xps_mod_mhs');

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Extract common design parameters
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   hw_subsys       = mssge_proj.hw_subsys;
%   sw_os           = mssge_proj.sw_os;
%   app_clk         = mssge_proj.app_clk;
%   app_clk_rate    = mssge_proj.app_clk_rate;
    hw_sys          = mssge_proj.hw_sys;
    xsg_core_name   = mssge_proj.xsg_core_name;
    mpc_type        = mssge_proj.mpc_type;

%   XPS_LIB_PATH    = mssge_paths.XPS_LIB_PATH;
%   simulink_path   = mssge_paths.simulink_path;
%   src_path        = mssge_paths.src_path;
%   xsg_path        = mssge_paths.xsg_path;
%   netlist_path    = mssge_paths.netlist_path;
    work_path       = mssge_paths.work_path;
    xps_path        = mssge_paths.xps_path;


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Initialize buses
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Backup and preprocess skeleton MHS and core_info.tab
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if ~exist([xps_path, slash, 'system.mhs.bac'],'file')
        [copystatus,copymessage,copymessageid] = copyfile([xps_path, slash, 'system.mhs'],[xps_path, slash, 'system.mhs.bac']);
        if ~copystatus
            disp('Error trying to backup system.mhs:');
            disp(copymessage)
        end % if ~copystatus
    end % if ~exist([xps_path, slash, 'system.mhs.bac'],'file')

    if ~exist([xps_path, slash, 'core_info.tab.bac'],'file')
        [copystatus,copymessage,copymessageid] = copyfile([xps_path, slash, 'core_info.tab'],[xps_path, slash, 'core_info.tab.bac']);
        if ~copystatus
            disp('Error trying to backup core_info.tab:');
            disp(copymessage);
        end % if ~copystatus
    end % if ~exist([xps_path, slash, 'core_info.tab.bac'],'file')

    mhs_fid = fopen([xps_path, slash, 'system.mhs'],'w');
    nfo_fid = fopen([work_path, slash, 'core_info.m'],'w');
    bof_fid = fopen([xps_path, slash, 'core_info.tab'],'w');

    in_fid = fopen([xps_path, slash, 'system.mhs.bac'],'r');
    detokenize(in_fid, mhs_fid, xps_objs);
    fclose(in_fid);

    in_fid = fopen([xps_path, slash, 'core_info.tab.bac'],'r');
    detokenize(in_fid, bof_fid, xps_objs);
    fclose(in_fid);


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Add Simulink design pcore to EDK project
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Add yellow block pcores to EDK project
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    fprintf(mhs_fid,'############################\n');
    fprintf(mhs_fid,'# Simulink interfaces      #\n');
    fprintf(mhs_fid,'############################\n');
    fprintf(mhs_fid,'\n');

    n = 1;
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
                    try
                        opb_bridge_obj = xps_plb2opb(opb_name,opb_addr,opb_bridge_size);
                    catch
                        disp('Problem when generating plb2opb bridge: ')
                        disp(lasterr);
                        error('Error found during plb2opb bridge creation (xps_plb2opb).');
                    end
                    opb_addr = get(opb_bridge_obj,'opb_addr_start');
                    xps_objs = [xps_objs,{opb_bridge_obj}];
                else
                    opb_slaves = opb_slaves + opb_cores;
                end
            % end case 'powerpc405'

            case 'microblaze'
                if plb_slaves ~= 0
                    error('Microblaze processor does not support PLB devices.');
                end
                if opb_cores + opb_slaves > 16
                    error('OPB exceeds 16 total slave devices.');
                else
                    opb_slaves = opb_slaves + opb_cores;
                end
            % end case 'microblaze'

            case 'powerpc440_ext'
                if opb_cores + opb_slaves > 32
                    opb_bus_inst = opb_bus_inst + 1;
                    opb_slaves = 0;
                    opb_name = ['opb',num2str(opb_bus_inst)];
                    opb_addr = hex2dec('01000000') + opb_bus_inst * opb_bridge_size;
                    try
                        opb_bridge_obj = xps_opb2opb(opb_name,opb_addr,opb_bridge_size);
                    catch
                        disp('Problem when generating opb2opb bridge: ')
                        disp(lasterr);
                        error('Error found during opb2opb bridge creation (xps_opb2opb).');
                    end
                    xps_objs = [xps_objs,{opb_bridge_obj}];
                else
                    opb_slaves = opb_slaves + opb_cores;
                end
                if plb_slaves ~= 0
                    error('External PowerPC 440 does not support PLB devices.');
                end
            % end case 'powerpc440_ext'

            otherwise
                error(['Unsupported MPC type: ',mpc_type]);
            % end otherwise

        end % switch mpc_type

        try
            [str, opb_addr, plb_addr,this_opb_addr_start] = gen_mhs_ip(blk_obj,opb_addr,plb_addr,plb_name,opb_name);
        catch
            disp('Problem with block : ')
            display(blk_obj);
            disp(lasterr);
            error('Error found during Peripheral generation in MHS (gen_mhs_ip).');
        end

        fprintf(mhs_fid,['# ',get(blk_obj,'simulink_name'),'\n']);
        fprintf(mhs_fid,str);
        fprintf(mhs_fid,'\n');

        str = gen_m_core_info(blk_obj, str);
        fprintf(nfo_fid,['%% ',get(blk_obj,'simulink_name'),'\n']);
        fprintf(nfo_fid,str);
        fprintf(nfo_fid,'\n');

        try
            if strcmp(hw_sys, 'ROACH')
              str = gen_borf_info(n, blk_obj, this_opb_addr_start);
            else
              str = gen_borf_info(n, blk_obj, {});
            end
            fprintf(bof_fid,str);
        catch
            disp('Problem with block : ')
            display(blk_obj);
            disp(lasterr);
            error('Error found during Peripheral generation in BOF (gen_borf_info).');
        end

        n = n + 1;
    end % while n <= length(xps_objs)

    fclose(mhs_fid);
    fclose(nfo_fid);
    fclose(bof_fid);

% end function gen_xps_mod_mhs
