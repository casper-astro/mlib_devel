classdef Register
    %REGISTER Summary of this class goes here
    %   Detailed explanation goes here

    properties
        % block-specific data
        block;      % the full path of this register block
        datawords;  % the memory words that make up this register
        width;      % the width of this register, in bits
        direction;  % the direction of this register - to or from the processor
        
        %%%%% Object parameters to collect from block
        block_parameters = {'Name', 'Tag', 'Parent', 'Handle', 'numios', 'io_dir', 'io_delay', 'sample_period'};
        % io details are in name3, bitwidth3, arith_type3, bin_pt3
        %%%%%
    end

    methods
        function obj = Register(varargin)
            % constructor - takes a simulink swreg block and an ID
            if nargin == 0,
                return
            elseif nargin == 1,
                obj = obj.load_from_block(varargin{1});
            else
                error('This can only be instantiated by passing a Simulink block and ID number.');
            end
        end

        function obj = add_memory(obj, mem)
            obj.datawords = [obj.datawords, mem];
        end

        function obj = load_from_block(obj, blockname)
            tag = get_param(blockname, 'Tag');
            if strcmp(tag, 'xps:sw_reg'),
                obj.block = blockname;
                obj.width = 32;
                % look for name1, to accomodate old sw_reg
                old_reg = false;
                try
                    get_param(blockname, 'name1');
                catch
                    old_reg = true;
                end
                if old_reg,
                    % look for a mode flag to distinguish the latest swreg
                    % from the oldest one - blergh - too much support
                    super_old = false;
                    try
                        get_param(blockname, 'mode');
                    catch
                        super_old = true;
                    end
                    if super_old,
                        obj = obj.load_from_sw_reg_old();
                    else
                        obj = obj.load_from_sw_reg_latest();
                    end
                else
                    obj = obj.load_from_sw_reg();
                end
            else
                error('Only defined for xps:sw_reg.');
            end
        end
        
        function regname = get_register_name(obj)
            regname = strrep(regexprep(obj.block, '^[^/]*/', ''), '/', '_');
        end
        
        function blockname = get_block_name(obj, strip_system_name)
            if strip_system_name == 1,
                blockname = regexprep(obj.block, '^[^/]*/', '');
            else
                blockname = obj.block;
            end
        end
        
        function obj = load_from_sw_reg_old(obj)
            % load the object from an original sw reg block
            io_dir = get_param(obj.block, 'io_dir');
            regname = strrep(regexprep(obj.block, '^[^/]*/', ''), '/', '_');
            block_sans_system = regexprep(obj.block, '^[^/]*/', '');
            obj.datawords = design_info.MemoryWord(block_sans_system, 32, regname, -1, 0, 32, 1, 0, 'Unsigned', 0, io_dir);
        end
        
        function obj = load_from_sw_reg(obj)
            % load the object details from a new sw reg
            io_dir = get_param(obj.block, 'io_dir');
            numios = str2double(get_param(obj.block,'numios'));
            offset = 0;
            %mem = design_info.MemoryWord(strcat(regname, '_raw'), -1, offset, 32, 1, 0, 'Unsigned', 0, io_dir);
            %obj = obj.add_memory(mem);
            for f = numios : -1 : 1,
                ioname = get_param(obj.block, sprintf('name%i', f));
                %wordname = strcat(obj.get_register_name(), '_', ioname);
                iobitwidth = str2double(get_param(obj.block, sprintf('bitwidth%i', f)));
                ioarith_type = get_param(obj.block, sprintf('arith_type%i', f));
                iobin_pt = str2double(get_param(obj.block, sprintf('bin_pt%i', f)));
                mem = design_info.MemoryWord(obj.get_block_name(true), obj.width, ioname, -1, offset, iobitwidth, 1, 0, ioarith_type, iobin_pt, io_dir);
                obj = obj.add_memory(mem);
                offset = offset + iobitwidth;
            end
        end
        
        function obj = load_from_sw_reg_latest(obj)
            % load the object details from the latest (last?) sw reg
            io_dir = get_param(obj.block, 'io_dir');
            current_names = textscan(strtrim(strrep(strrep(get_param(obj.block, 'names'), ']', ''), '[', '')), '%s');
            current_names = current_names{1};
            numios = length(current_names);
            current_types = eval(get_param(obj.block, 'arith_types'));
            current_bins = eval(get_param(obj.block, 'bin_pts'));
            current_widths = eval(get_param(obj.block, 'bitwidths'));
            for f = numios : -1 : 1,
                iobitwidth = current_widths(f);
                ioarith_type = current_types(f);
                iobin_pt = current_bins(f);
                mem = design_info.MemoryWord(obj.get_block_name(true), obj.width, ioname, -1, offset, iobitwidth, 1, 0, ioarith_type, iobin_pt, io_dir);
                obj = obj.add_memory(mem);
                offset = offset + iobitwidth;
            end
        end

        function node = to_xml_node(obj, xml_dom)
            % Return an XML node representation of this register
            node = xml_dom.createElement('register');
            % include defined object parameters
            for ctr = 1 : numel(obj.block_parameters),
                parm = char(obj.block_parameters(ctr));
                try
                    value = get_param(obj.block, parm);
                catch err
                    error('No such parameter %s in block %s.', parm, obj.block)
                end
                if isnumeric(value),
                    value = num2str(value);
                end
                node.setAttribute(lower(parm), value);
            end
            % and memory words for this register
            for d = numel(obj.datawords) : -1 : 1,
                memnode = obj.datawords(d).to_xml_node(xml_dom);
                node.appendChild(memnode);
            end
        end
        
        function nodes = to_coreinfo(obj, xml_dom)
            %
            % Returns nodes for the core_info.tab replacement table
            %
            for d = numel(obj.datawords) : -1 : 1,
                node = obj.datawords(d).to_xml_node(xml_dom);
                nodes(d) = node;
            end
        end

    end % /methods
    
end

