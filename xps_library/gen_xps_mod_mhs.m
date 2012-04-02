function gen_xps_mod_mhs(xsg_obj, xps_objs, mssge_proj, mssge_paths, slash)
% Modifies the EDK project's MHS file to include design elements.
%
% gen_xps_mod_mhs(xsg_obj, xps_objs, mssge_proj, mssge_paths, slash)

    clog('entering gen_xps_mod_mhs','trace');

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
        case {'ROACH','ROACH2'}
            
            plb_slaves = 0;
            opb_slaves_init = 1;  % The system block
            opb_slaves = opb_slaves_init;             
            max_opb_per_bridge = 32; 

            opb_addr_init   = hex2dec('01000000');
            opb_addr        = opb_addr_init;
            plb_addr        = hex2dec('04000000');
            opb_bridge_size = hex2dec('00080000');
            opb_addr_max    = hex2dec('01FFFFFF'); %upper limit of address space allocated
        % end case {'ROACH','ROACH2'}
        otherwise
            plb_slaves = 2; % the memory and the opb bridge
            opb_slaves = 3; % the UART, the selectmap fifo and the serial switch reader
            max_opb = 16;

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

    if strcmp(mpc_type, 'powerpc440_ext'),
      %calculate number of fixed opb0 devices
      opb0_devs = 0;  
      opb_offset_tmp = opb_addr;        
      plb_offset_tmp = plb_addr;
      n = 1;        
      clog(['Searching for fixed opb0 devices. ',num2str(opb_slaves),' initial fixed devices'],'gen_xps_mod_mhs_debug');
      while (n <= length(xps_objs)),
        blk_obj = xps_objs{n};
        [plb_cores, plb_offset_tmp, opb_cores, opb_offset_tmp, opb0_devices] = probe_bus_usage(blk_obj, plb_offset_tmp, opb_offset_tmp);
        clog([get(blk_obj,'simulink_name'),': ',num2str(opb0_devices),' opb0 devices found'],'gen_xps_mod_mhs_desperate_debug');
        if opb0_devices ~= 0, clog([get(blk_obj,'simulink_name'),': ', num2str(opb0_devices),' opb0 devices'],'gen_xps_mod_mhs_debug'); end
        opb0_devs = opb0_devs + opb0_devices;
        n = n + 1;
      end
      opb_slaves = opb_slaves + opb0_devs;
      clog([num2str(opb0_devs),' fixed opb0 devices in total found'],'gen_xps_mod_mhs_debug');

      %calculate number of opb2opb bridges to be added to opb0
      opb2opbs = 0;
      redo = 1;

      %we iterate through all devices every time we add a new bridge (adding bridges to opb0 may push devices into 
      %other bridges' address spaces which may cause more bridges to be required
      clog(['Searching for opb bridges from address 0x', dec2hex(opb_addr,8),' with ', num2str(opb_slaves),' initial devices on opb0'],'gen_xps_mod_mhs_debug');
      while redo == 1, 
        opb2opbs_tmp = 0;                         %restart counting bridges
        opb_offset_tmp = opb_addr;        
        plb_offset_tmp = plb_addr;        
        opb_slaves_tmp = opb_slaves + opb2opbs;   %initial number of slaves is inital value + number bridges
        clog(['Searching for opb bridges from address 0x',dec2hex(opb_offset_tmp,8),'. ',num2str(opb2opbs),' bridges and ',num2str(opb0_devs),' fixed devices found giving ',num2str(opb_slaves_tmp),' initial devices on opb0'],'gen_xps_mod_mhs_desperate_debug');
        
        n = 1;
        while (n <= length(xps_objs)),
          redo = 0;

          blk_obj = xps_objs{n};
          [plb_cores, plb_offset_tmp, opb_cores, opb_offset_tmp, opb0_devices] = probe_bus_usage(blk_obj, plb_offset_tmp, opb_offset_tmp);

          clog([get(blk_obj,'simulink_name'),' with ',num2str(plb_cores),': plb cores, ',num2str(opb_cores),': opb cores at ',num2str(plb_offset_tmp),': plb offset, ',num2str(opb_offset_tmp),': opb offset'],'gen_xps_mod_mhs_desperate_debug');

          bridge_start = opb_addr_init + ((opb2opbs_tmp+1) * opb_bridge_size);

          of_space = (opb_offset_tmp > bridge_start);
          of_devices = ((opb_slaves_tmp + opb_cores) > max_opb_per_bridge);

          if (of_space || of_devices),                                   %if we run out of space on bus
            opb2opbs_tmp = opb2opbs_tmp + 1;
            if (opb2opbs_tmp > opb2opbs),                                % and we need a bridge that pushes the number to more than we have already
              if (of_space),
                clog(['Overflowed bus space for opb',num2str(opb2opbs),' at device ',num2str(n),', ending at address 0x',dec2hex(opb_offset_tmp,8)],'gen_xps_mod_mhs_debug');
              else
                clog(['Overflowed number of devices for opb',num2str(opb2opbs),' at device ',num2str(n),'. ',num2str(max_opb_per_bridge),' allowed, got ',num2str(opb_slaves_tmp+opb_cores)],'gen_xps_mod_mhs_debug');
              end
              redo = 1;                                                  %   then add to the master count of devices and start again 
              opb2opbs = opb2opbs + 1; 
              break;                                  
            else                                                         % otherwise 
              opb_slaves_tmp = opb_cores;                                %  reset slaves
              opb_offset_tmp = bridge_start;                             %  set address to start at bridge
            end
          else                                                           %otherwise  
            opb_slaves_tmp = opb_slaves_tmp + opb_cores;                 % increment number of devices
            n = n + 1;                                                   % next block
          end
        end
      end %while redo
      opb_slaves = opb_slaves + opb2opbs; %on the last iteration we have the number of bridges required on opb0
      clog(['Finished searching. ',num2str(opb2opbs),' opb2opb bridges found giving ',num2str(opb_slaves),' initial devices on opb0'], 'gen_xps_mod_mhs_debug')

      if opb_slaves > max_opb_per_bridge,
        error('Number opb2opb bridges and fixed devices on opb0 exceeds maximum allowed. You have a problem');
      end
    end

    n = 1;
    while n <= length(xps_objs)
        blk_obj = xps_objs{n};

        plb_addr_start = plb_addr;
        opb_addr_start = opb_addr;
        [plb_cores, plb_offset_tmp, opb_cores, opb_offset_tmp, opb0_devices] = probe_bus_usage(blk_obj, plb_addr, opb_addr);

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

                opb_slaves = opb_slaves + opb_cores;
                bridge_start = opb_addr_init + ((opb_bus_inst+1) * opb_bridge_size);

                of_space = opb_offset_tmp > bridge_start;
                of_devices = opb_slaves > max_opb_per_bridge;
                
                if (of_space || of_devices),                              % if need another bridge
                    if of_space,
                      clog(['adding opb bridge ',opb_name,' for ',get(blk_obj,'simulink_name'),' device number ',num2str(n),' causing address space overflow at addr 0x',dec2hex(opb_offset_tmp,8)],'gen_xps_mod_mhs_debug');
                    else
                      clog(['adding opb bridge ',opb_name,' for ',get(blk_obj,'simulink_name'),' device number ',num2str(n),' causing device overflow at device ',num2str(opb_slaves)],'gen_xps_mod_mhs_debug');
                    end
                    opb_bus_inst = opb_bus_inst + 1;
                    opb_slaves = opb_cores;   %put all cores on new bus
                    opb_name = ['opb',num2str(opb_bus_inst)];
                    opb_addr = bridge_start;
                    try
                        opb_bridge_obj = xps_opb2opb(opb_name, opb_addr, opb_bridge_size);
                    catch
                        disp(['Problem when generating opb2opb bridge ',opb_name,':'])
                        disp(lasterr);
                        error('Error found during opb2opb bridge creation (xps_opb2opb).');
                    end
                    xps_objs = [xps_objs,{opb_bridge_obj}];
                end
                if plb_cores ~= 0
                    error('External PowerPC 440 does not support PLB devices.');
                end

                clog(['0x',dec2hex(opb_addr_start,8),'-0x',dec2hex(opb_addr,8), ' opbs: ',num2str(opb_cores),'(',num2str(opb0_devices), ') => ', num2str(opb_slaves),' on opb',num2str(opb_bus_inst),' (',get(blk_obj,'simulink_name'),')'],'gen_xps_mod_mhs_debug'); 
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
            if strcmp(hw_sys, 'ROACH') ||  strcmp(hw_sys, 'ROACH2')
              str = gen_borf_info(n, blk_obj, this_opb_addr_start);
            else
              str = gen_borf_info(n-1, blk_obj, {});
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

    clog('exiting gen_xps_mod_mhs','trace');
% end function gen_xps_mod_mhs
