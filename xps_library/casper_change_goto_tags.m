function casper_change_goto_tags(sys, change_this, to_this)
%casper_change_goto_tags Change prefix on tags from one number to another
%   Useful for changing many tags in a system at once.
DEBUG = false;
block_names = find_system(sys, 'LookUnderMasks', 'all', 'SearchDepth', 1, 'Regexp', 'on', 'BlockType', 'Goto|From', 'GotoTag', '[0-9]$');
if isempty(block_names),
    error('No suitable selected goto/from blocks.');
end
% loop through the blocks and process them
for ctr = 1 : length(block_names),
    blkname = block_names{ctr};
    currenttag = get_param(blkname, 'GotoTag');
    numberindex = regexp(currenttag, '[0-9]*$');
    tagprefix = currenttag(1:numberindex-1);
    tagnumber = str2double(currenttag(numberindex:end));
    debug_str = [blkname, ': ', currenttag, ' (', tagprefix, ',', num2str(tagnumber), '), '];
    process_block = true;
    if (change_this ~= -1) && (change_this ~= tagnumber),
        process_block = false;
        debug_str = [debug_str, 'process(FALSE)'];
    end
    if process_block,
        debug_str = [debug_str, 'process(TRUE), '];
        if to_this ~= -1,
            newnumber = to_this;
        else
            newnumber = tagnumber + 1;
        end
        debug_str = [debug_str, num2str(change_this), '->', num2str(newnumber), ', '];
        newtag = [tagprefix, num2str(newnumber)];
        debug_str = [debug_str, 'FINALLY: ', newtag];
        set_param(blkname, 'GotoTag', newtag);
    end
    if DEBUG,
        fprintf('%s\n', debug_str);
    end
end
