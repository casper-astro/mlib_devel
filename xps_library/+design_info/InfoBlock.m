classdef InfoBlock
    %REGISTER Summary of this class goes here
    %   Detailed explanation goes here

    properties
        % simulink-specific data
        block;          % the full path of this info block
        parent_block;   % in which (sub)system is this block found?
        parent_tag;
        info;
    end

    methods
        function obj = InfoBlock(varargin)
            if nargin == 0,
                return
            elseif nargin == 1,
                obj = obj.load_from_block(varargin{1});    
            elseif nargin == 4,
                obj.block = varargin{1};
                obj.info = varargin{2};
                obj.parent_block = varargin{3};
                obj.parent_tag = varargin{4};
            else
                error('Wrong number of arguments supplied. Need 1 or 4, got %i.', nargin);
            end
        end

        function obj = load_from_block(obj, blockname)
            tag = get_param(blockname, 'Tag');
            if strcmp(tag, 'casper:info'),
                obj.parent_block = get_param(blockname, 'Parent');
                obj.parent_tag = get_param(get_param(blockname, 'Parent'), 'Tag');
                obj.info = get_param(blockname, 'info');
                obj.block = blockname;
            else
                error('Only defined for casper:info.');
            end
        end

        function node = to_xml_node(obj, xml_dom)
            % Return an XML info node object representation of this
            % InfoBlock.
            node = xml_dom.createElement('info');
            node.setAttribute('param', regexprep(obj.block, '.*/', ''));
            node.setAttribute('value', obj.info);
            node.setAttribute('owner', design_info.strip_system_from_name(obj.parent_block));
            node.setAttribute('owner_tag', obj.parent_tag);
        end
        
        function rstr = to_table_row(obj)
            % Return the InfoBlock information in string form for the
            % information table.
            rstr = '';
            rstr = [rstr, design_info.strip_system_from_name(obj.parent_block), '\t'];
            rstr = [rstr, obj.parent_tag, '\t'];
            rstr = [rstr, regexprep(obj.block, '.*/', ''), '\t'];
            replace_spaces = strrep(obj.info, ' ', '\\_');
            %replace_spaces = strrep(replace_spaces, char(10), '');
            if isempty(regexp(replace_spaces, '\n$', 'ONCE')) == 1,
                rstr = [rstr, replace_spaces, '\n'];
            else
                rstr = [rstr, replace_spaces];
            end
            if isempty(strtrim(rstr)) == 1,
                error('Big problem, empty string!');
            end
        end
    end
    
end

