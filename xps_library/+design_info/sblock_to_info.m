function infoblocks = sblock_to_info(block)
    %
    % Populate an InfoBlock from a tagged Simulink block.
    % Each parameter in the mask of a block becomes a unique InfoBlock
    %
    clog(sprintf('entering sblock_to_info for %s', block), 'trace');
    tag = get_param(block, 'Tag');
    if numel(tag) == 0,
        error('Block %s: sblock_to_info_nodes called without tag, not good.', block);
    end
    maskparms = get_param(block, 'MaskNames');

    % loop through the mask parameters and add a new info line for each one
    for ctr = numel(maskparms) : -1 : 1,
        parm = maskparms{ctr};
        value = get_param(block, parm);
        if isempty(strtrim(parm)) == 1,
            error('Block %s: parameter is empty?', block);
        end
        if isempty(strtrim(value)) == 1,
            error('Block %s: parameter %s has an empty value?', ...
                block, strtrim(value));
        end
        if isnumeric(value),
            value = num2str(value);
        end
        if ischar(value),
            try
                tmp = evalin('base', value);
                tmpstr = num2str(tmp);
                if numel(tmp) > 1,
                    tmpstr = ['[', tmpstr, ']'];
                end
                while isempty(strfind(tmpstr, '  ')) == 0,
                    tmpstr = strrep(tmpstr, '  ', ' ');
                end
                if (~isempty(tmpstr)) && (length(tmpstr) < 100),
                    value = tmpstr;
                end
            catch exc
                % nothing to do
            end
        else
            error('%s: a non-char value at this point makes no sense: %s', block, parm);
        end
        infoblock = design_info.InfoBlock(lower(parm), value, block, tag);
        infoblocks(ctr) = infoblock;
    end
    clog('exiting sblock_to_info', 'trace');
end
