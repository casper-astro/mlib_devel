classdef MemoryWord
    %MEMORY Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % base properties that memory has
        owner;          % the block that owns this memory
        name;           % describe this piece of memory, in one word :)
        address;        % the bus address this memory will have at some stage
        offset_bits;    % an offset into that address, in bits, from the LSB
        width_bits;     % word width in bits
        length;         % length in words
        stride_bytes;   % if length > 1, what is the stride in bytes?
        type;           % type of data stored in this word
        bin_pt;         % the position of the binary point for this data
        direction;      % to/from/bi -> 1,2,3
    end
    
    methods
        function obj = MemoryWord(varargin)
            if nargin == 0,
                return
            end
            props = properties(obj);
            num_props = numel(props);
            if nargin == num_props,
                for n = 1 : num_props,
                    eval(['obj.', char(props(n)), ' = varargin{', num2str(n),'};'])
                end
            else
                errorstr = 'Expecting MemoryWord(';
                for n = 1 : num_props,
                    errorstr = strcat(errorstr, props(n), ', ');
                end
                error(char(strcat(errorstr, ')')));
            end
        end

        function node = to_xml_node(obj, xml_dom)
            node = xml_dom.createElement('memoryword');
            node.setAttribute('owner',          obj.owner);
            node.setAttribute('name',           obj.name);
            node.setAttribute('address',        num2str(obj.address));
            node.setAttribute('offset_bits',    num2str(obj.offset_bits));
            node.setAttribute('width_bits',     num2str(obj.width_bits));
            node.setAttribute('length',         num2str(obj.length));
            node.setAttribute('stride_bytes',   num2str(obj.stride_bytes));
            node.setAttribute('type',           obj.type);
            node.setAttribute('bin_pt',         num2str(obj.bin_pt));
            node.setAttribute('direction',      obj.direction);
        end
    end
    
end

