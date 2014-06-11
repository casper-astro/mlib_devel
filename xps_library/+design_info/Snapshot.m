classdef Snapshot
    %SNAPSHOT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % simulink-specific data
        block;                              % the full path of this register block
        datawords;                          % the memory words that make up this register
        width;                              % the width of this register, in bits
        direction;                          % the direction of this register - to or from the processor
        infos = design_info.InfoBlock;      % info blocks associated with this snapshot block
        extra_value_register = NaN;
        
        %%%%% Object parameters to collect from block
        block_parameters = {'Name', 'Tag', 'Parent', 'Handle', 'storage', 'dram_dimm', 'dram_clock', 'nsamples', 'data_width', 'offset', 'circap', 'value', 'use_dsp48'};
        % io details are in name3, bitwidth3, arith_type3, bin_pt3
        %%%%%
    end
    
    methods
        function obj = Snapshot(varargin)
            % constructor - takes a simulink snapshot block and an ID
            if nargin == 0,
                return
            elseif nargin == 1,
                obj = obj.load_from_block(varargin{1});
            else
                error('This can only be instantiated by passing a Simulink block.');
            end
        end
        
        function obj = load_from_block(obj, block)
            % Load snapshot details from a Simulink block
            tag = get_param(block, 'Tag');
            if strcmp(tag, 'casper:snapshot'),
                obj = obj.load_from_snapshot(block);
            else
                error('Only defined for casper:snapshot.');
            end
        end
        
        function obj = load_from_snapshot(obj, block)
            %
            % Populate this object from the Simulink block
            %
            % block
            obj.block = block;
            % data
            mem_name = [strrep(obj.get_block_name(true), '/', '_'), '_data'];
            mem_address = -1;
            mem_offset = 0;
            obj.width = str2double(get_param(block, 'data_width'));
            mem_length = pow2(str2double(get_param(block, 'nsamples')));
            mem_stride = obj.width / 8;
            mem_type = 'Unsigned';
            mem_bp = 0;
            mem_direction = 'To Processor';
            obj.datawords = design_info.MemoryWord(obj.get_block_name(true), obj.width, mem_name, mem_address, mem_offset, obj.width, mem_length, mem_stride, mem_type, mem_bp, mem_direction);
            % extra value register
            extra_value = get_param(block, 'value');
            if strcmp(extra_value, 'on'),
                obj.extra_value_register = design_info.Register(strcat(obj.block, '/val'));
            end
            % info blocks
            info_blks = find_system(obj.block, 'FollowLinks', 'off', 'LookUnderMasks', 'all', 'Tag', 'casper:info');
            if numel(info_blks) == 0,
                error('No info blocks found in snapblock %s, perhaps an old one?', obj.block);
            end
            obj.infos(1, numel(info_blks)) = design_info.InfoBlock;
            if numel(info_blks) > 0,
                for n = 1 : numel(info_blks),
                    obj.infos(n) = design_info.InfoBlock(info_blks(n));
                end
            end
        end % /load_from_snapshot
        
        function snapname = get_snapshot_name(obj)
            snapname = strrep(obj.get_block_name(true), '/', '_');
        end
        
        function blockname = get_block_name(obj, strip_system_name)
            if strip_system_name == 1,
                blockname = regexprep(obj.block, '^[^/]*/', '');
            else
                blockname = obj.block;
            end
        end

        function snapnode = to_xml_node(obj, xml_dom)
            %
            % Return an XML node representation of this snapshot block
            %
            snapnode = xml_dom.createElement('snapshot');
            % include defined object parameters
            for ctr = 1 : numel(obj.block_parameters),
                parm = char(obj.block_parameters(ctr));
                value = get_param(obj.block, parm);
                if isnumeric(value),
                    value = num2str(value);
                end
                snapnode.setAttribute(lower(parm), value);
            end
            % data words
            for d = numel(obj.datawords) : -1 : 1,
                dword = obj.datawords(d);
                node = dword.to_xml_node(xml_dom);
                snapnode.appendChild(node);
            end
            % info - will be in info blocks ideally
            for n = numel(obj.infos) : -1 : 1,
                snapnode.appendChild(obj.infos(n).to_xml_node(xml_dom));
            end
            % extra value
            if isa(obj.extra_value_register, 'design_info.Register'),
                extravalue = obj.extra_value_register.to_xml_node(xml_dom);
                snapnode.appendChild(extravalue);
            end
        end % /to_xml_node

        function [snapnodes, extravalue, infonodes] = to_coreinfo(obj, xml_dom)
            %
            % Returns nodes for the core_info.tab replacement table
            %
            % data words
            for d = numel(obj.datawords) : -1 : 1,
                dword = obj.datawords(d);
                node = dword.to_xml_node(xml_dom);
                snapnodes(d) = node;
            end
            % info - will be in info blocks ideally
            for n = numel(obj.infos) : -1 : 1,
                infonodes(n) = obj.infos(n).to_xml_node(xml_dom);
            end
            % extra value
            extra_value = get_param(obj.block, 'value');
            if strcmp(extra_value, 'on'),
                extravalue = obj.extra_value_register.to_coreinfo(xml_dom);
            else
                extravalue = NaN;
            end
        end
        
        function str = to_tablerow(obj)
            %
            % Returns a row of the info table
            %
            % data words
            error('Not working.')
            for d = numel(obj.datawords) : -1 : 1,
                dword = obj.datawords(d);
                node = dword.to_xml_node(xml_dom);
                snapnodes(d) = node;
            end
            % info - will be in info blocks ideally
            for n = numel(obj.infos) : -1 : 1,
                infonodes(n) = obj.infos(n).to_xml_node(xml_dom);
            end
            % extra value
            extra_value = get_param(obj.block, 'value');
            if strcmp(extra_value, 'on'),
                extravalue = obj.extra_value_register.to_coreinfo(xml_dom);
            else
                extravalue = NaN;
            end
        end

    end
end
