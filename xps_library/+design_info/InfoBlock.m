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
            else
                obj.block = varargin{1};
                obj.info = varargin{2};
                obj.parent_block = varargin{3};
                obj.parent_tag = varargin{4};
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
            node = xml_dom.createElement('info');
            node.setAttribute('param', regexprep(obj.block, '.*/', ''));
            node.setAttribute('value', obj.info);
            node.setAttribute('owner', regexprep(obj.parent_block, '^[^/]*/', ''));
            node.setAttribute('owner_tag', obj.parent_tag);
        end
    end
    
end

