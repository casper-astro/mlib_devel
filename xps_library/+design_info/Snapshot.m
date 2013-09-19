classdef Snapshot
    %SNAPSHOT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        storage, dram_dimm, dram_clock, start_offset, circular_capture, extra_value, use_dsp48, extra_value_reg;
        % simulink-specific data
        owner;      % the system that owns this block
        block;      % the full path of this register block
        datawords;  % the memory words that make up this register
    end
    
    methods
        function obj = Snapshot(block)
            if nargin == 0,
                return
            elseif nargin == 1,
                obj = obj.load_from_block(block);    
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
                error('Only defined for xps:snapshot.');
            end
        end
        
        function obj = load_from_snapshot(obj, block)
            % Populate this object from the Simulink block
            % block
            obj.block = block;
            obj.owner = regexprep(obj.block, '/[^/]+$', '');
            obj.storage = get_param(block, 'storage');
            obj.dram_dimm = get_param(block, 'dram_dimm');
            obj.dram_clock = get_param(block, 'dram_clock');
            obj.start_offset = get_param(block, 'offset');
            obj.circular_capture = get_param(block, 'circap');
            obj.extra_value = get_param(block, 'value');
            obj.use_dsp48 = get_param(block, 'use_dsp48');
            % data
            snapname = regexprep(obj.block, '^[^/]*/', '');
            mem_name = [strrep(snapname, '/', '_'), '_data'];
            mem_address = -1;
            mem_offset = 0;
            mem_width = str2double(get_param(block, 'data_width'));
            mem_length = pow2(str2double(get_param(block, 'nsamples')));
            mem_stride = mem_width / 8;
            mem_type = 'Unsigned';
            mem_bp = 0;
            mem_direction = 'To Processor';
            obj.datawords = design_info.MemoryWord(snapname, mem_name, mem_address, mem_offset, mem_width, mem_length, mem_stride, mem_type, mem_bp, mem_direction);
            % extra value register
            if strcmp(obj.extra_value, 'on'),
                obj.extra_value_reg = design_info.Register(strcat(obj.block, '/val'));
            else
                obj.extra_value_reg = NaN;
            end
        end
        
%         function obj = load_from_bitsnap(obj, blk)
%             obj.path = strcat(obj.path, '/ss');
%             obj.name = strcat(obj.name, '_ss');
%             obj.length = str2double(get_param(blk, 'snap_nsamples'));
%             obj.width = str2double(get_param(blk, 'snap_data_width'));
%             obj.storage = get_param(blk, 'snap_storage');
%             obj.dram_dimm = str2double(get_param(blk, 'snap_dram_dimm'));
%             obj.dram_clock = str2double(get_param(blk, 'snap_dram_clock'));
%             obj.circular_capture = get_param(blk, 'snap_circap');
%             obj.start_offset = get_param(blk, 'snap_offset');
%             obj.extra_value = get_param(blk, 'snap_value');
%             obj.use_dsp48 = get_param(blk, 'snap_use_dsp48');
%             obj = obj.add_field(Field(strcat(obj.name, '_raw'), obj.width, obj.width, 0, 0, 0));
%             % fields
%             field_names =   fliplr(eval(char(get_param(blk, 'io_names'))));
%             field_widths =  fliplr(eval(char(get_param(blk, 'io_widths'))));
%             field_bps =     fliplr(eval(char(get_param(blk, 'io_bps'))));
%             field_types =   fliplr(eval(char(get_param(blk, 'io_types'))));
%             offset = 0;
%             for f = 1 : numel(field_names),
%                 field = Field(strcat(obj.name, '_', field_names(f)), field_widths(f), obj.width, offset, field_bps(f), field_types(f));
%                 obj = obj.add_field(field);
%                 offset = offset + field_widths(f);
%             end
%             clear field_names field_widths field_bps field_types;
%             % extra fields
%             if strcmp(obj.extra_value, 'on'),
%                 field_names =   fliplr(eval(char(get_param(blk, 'extra_names'))));
%                 field_widths =  fliplr(eval(char(get_param(blk, 'extra_widths'))));
%                 field_bps =     fliplr(eval(char(get_param(blk, 'extra_bps'))));
%                 field_types =   fliplr(eval(char(get_param(blk, 'extra_types'))));
%                 obj.extra_value_reg = design_info.Register(strcat(obj.path, '/val'));
%                 offset = 0;
%                 for f = 1 : numel(field_names),
%                     field = Field(strcat(obj.extra_value_reg.name, '_', field_names(f)), field_widths(f), 0, offset, field_bps(f), field_types(f));
%                     obj.extra_value_reg = obj.extra_value_reg.add_field(field);
%                     offset = offset + field_widths(f);
%                 end
%                 clear field_names field_widths field_bps field_types;
%             end
%         end
        
        function [snapnodes, extravalue, infonodes] = to_xml_nodes(obj, xml_dom)
            % data words
            for d = numel(obj.datawords) : -1 : 1,
                dword = obj.datawords(d);
                snapnodes(d) = dword.to_xml_node(xml_dom);
            end
%             % info - will be in info blocks ideally
%             snapname = regexprep(obj.block, '^[^/]*/', '');
%             snaptag = get_param(obj.block, 'Tag');
%             infos(1) = design_info.InfoBlock([snapname, '/block'], obj.block, snapname, snaptag);
%             infos(2) = design_info.InfoBlock([snapname, '/storage'], obj.storage, snapname, snaptag);
%             infos(3) = design_info.InfoBlock([snapname, '/dram_dimm'], obj.dram_dimm, snapname, snaptag);
%             infos(4) = design_info.InfoBlock([snapname, '/dram_clock'], obj.dram_clock, snapname, snaptag);
%             infos(5) = design_info.InfoBlock([snapname, '/start_offset'], obj.start_offset, snapname, snaptag);
%             infos(6) = design_info.InfoBlock([snapname, '/circular_capture'], obj.circular_capture, snapname, snaptag);
%             infos(7) = design_info.InfoBlock([snapname, '/extra_value'], obj.extra_value, snapname, snaptag);
%             infos(8) = design_info.InfoBlock([snapname, '/use_dsp48'], obj.use_dsp48, snapname, snaptag);
%             for n = numel(infos) : -1 : 1,
%                 infonodes(n) = infos(n).to_xml_node(xml_dom);
%             end
            infonodes = NaN;
            % extra value
            if strcmp(obj.extra_value, 'on'),
                extravalue = obj.extra_value_reg.to_xml_nodes(xml_dom);
            else
                extravalue = NaN;
            end
        end

    end
end
