classdef Register
    %REGISTER Summary of this class goes here
    %   Detailed explanation goes here

    properties
        % simulink-specific data
        owner;      % the system that owns this block
        block;      % the full path of this register block
        datawords;  % the memory words that make up this register
    end

    methods
        function obj = Register(block)
            if nargin == 0,
                return
            elseif nargin == 1,
                obj = obj.load_from_block(block);    
            else
                error('This can only be instantiated by passing a Simulink block.');
            end
        end

        function obj = add_memory(obj, mem)
            obj.datawords = [obj.datawords, mem];
        end

        function obj = load_from_block(obj, blockname)
            tag = get_param(blockname, 'Tag');
            if strcmp(tag, 'xps:sw_reg'),
                % look for name1, to accomodate old sw_reg
                old_block = false;
                try
                    get_param(blockname, 'name1');
                catch ex
                    old_block = true;
                end
                obj.block = blockname;
                obj.owner = regexprep(obj.block, '/[^/]+$', '');
                if ~old_block,
                    obj = obj.load_from_sw_reg();
                else
                    obj = obj.load_from_sw_reg_old();
                end
            else
                error('Only defined for xps:sw_reg.');
            end
        end
        
        function obj = load_from_sw_reg_old(obj)
            io_dir = get_param(obj.block, 'io_dir');
            regname = strrep(regexprep(obj.block, '^[^/]*/', ''), '/', '_');
            block_sans_system = regexprep(obj.block, '^[^/]*/', '');
            obj.datawords = design_info.MemoryWord(block_sans_system, regname, -1, 0, 32, 1, 0, 'Unsigned', 0, io_dir);
        end
        
        function obj = load_from_sw_reg(obj)
            io_dir = get_param(obj.block, 'io_dir');
            regname = strrep(regexprep(obj.block, '^[^/]*/', ''), '/', '_');
            block_sans_system = regexprep(obj.block, '^[^/]*/', '');
            numios = str2double(get_param(obj.block,'numios'));
            offset = 0;
            %mem = design_info.MemoryWord(strcat(regname, '_raw'), -1, offset, 32, 1, 0, 'Unsigned', 0, io_dir);
            %obj = obj.add_memory(mem);
            for f = numios : -1 : 1,
                ioname = get_param(obj.block, sprintf('name%i', f));
                iobitwidth = str2double(get_param(obj.block, sprintf('bitwidth%i', f)));
                ioarith_type = get_param(obj.block, sprintf('arith_type%i', f));
                iobin_pt = str2double(get_param(obj.block, sprintf('bin_pt%i', f)));
                mem = design_info.MemoryWord(block_sans_system, strcat(regname, '_', ioname), -1, offset, iobitwidth, 1, 0, ioarith_type, iobin_pt, io_dir);
                obj = obj.add_memory(mem);
                offset = offset + iobitwidth;
            end
        end

        function nodes = to_xml_nodes(obj, xml_dom)
            for d = numel(obj.datawords) : -1 : 1,
                nodes(d) = obj.datawords(d).to_xml_node(xml_dom);
            end
        end
    end
    
end

