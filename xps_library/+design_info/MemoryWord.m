classdef MemoryWord
    % MemoryWord - one or more bits that form an arbitrary-length memory word
    %   Registers, snapblocks, brams, are all just memory words. Our bus
    %   interface is 32-bit, but we often break registers, snapshots,
    %   etc into smaller units of different types. These units are
    %   described by this class.
    
    properties
        % base properties that memory has
        owner;          % the name of the block that owns this memory
        owner_width;    % the width of the parent block
        name;           % memory word's name. e.g. bus_reset, gpio_value
        address;        % the base bus address at which this memory is located
        offset;         % the offset into that address, in bits, from the LSB
        width;          % the memory word width, in bits
        length;         % how many times this word is repeated
        stride_bytes;   % if length > 1, what is the stride, in bytes, between words?
        type;           % the type of data stored in this word
        bin_pt;         % the position of the binary point for this data
        direction;      % to/from/bi -> 1/2/3
    end % /properties
    
    methods

        % MemoryWord constructor
        % takes all the objects properties, in order
        function obj = MemoryWord(varargin)
            if nargin == 0,
                return;
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
        end % /MemoryWord
        
        function node = to_xml_node(obj, xml_dom)
            node = xml_dom.createElement('memoryword');
            props = properties(obj);
            for n = 1 : numel(props),
                val = eval(['obj.', char(props(n))]);
                if isnumeric(val),
                    val = num2str(val);
                end
                node.setAttribute(char(props(n)), val);
            end            
%             node.setAttribute('owner',          obj.owner);
%             node.setAttribute('name',           obj.name);
%             node.setAttribute('address',        num2str(obj.address));
%             node.setAttribute('offset_bits',    num2str(obj.offset_bits));
%             node.setAttribute('width_bits',     num2str(obj.width_bits));
%             node.setAttribute('length',         num2str(obj.length));
%             node.setAttribute('stride_bytes',   num2str(obj.stride_bytes));
%             node.setAttribute('type',           obj.type);
%             node.setAttribute('bin_pt',         num2str(obj.bin_pt));
%             node.setAttribute('direction',      obj.direction);
        end % /to_xml_node

    end % /methods
    
end % /class

