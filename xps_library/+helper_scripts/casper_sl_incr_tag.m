function casper_sl_incr_tag(to_and_from)
DEBUG = false;
try
    change_this = to_and_from.userdata(1);
    to_this = to_and_from.userdata(2);
catch
    change_this = to_and_from(1);
    to_this = to_and_from(2);
end

block_names = find_system(gcs, 'LookUnderMasks', 'all', 'SearchDepth', 1, 'Regexp', 'on', 'BlockType', 'Goto|From', 'Selected', 'on', 'GotoTag', '[0-9]$|^[0-9]');
if isempty(block_names)
    error('No suitable selected goto/from blocks.');
end

for ctr = 1 : length(block_names)
    blkname = block_names{ctr};
    currenttag = get_param(blkname, 'GotoTag');
    numberindex = regexp(currenttag, '[0-9]*$');
    tagprefix = currenttag(1:numberindex-1);
    tagnumber = str2double(currenttag(numberindex:end));
    debug_str = [blkname, ': ', currenttag, ' (', tagprefix, ',', num2str(tagnumber), '), '];
    process_block = true;
    if (change_this ~= -1) && (change_this ~= tagnumber)
        process_block = false;
        debug_str = [debug_str, 'process(FALSE)'];
    end
    if process_block
        debug_str = [debug_str, 'process(TRUE), '];
        if to_this ~= -1
            newnumber = to_this;
        else
            newnumber = tagnumber + 1;
        end
        debug_str = [debug_str, num2str(change_this), '->', num2str(newnumber), ', '];
        newtag = [tagprefix, num2str(newnumber)];
        debug_str = [debug_str, 'FINALLY: ', newtag];
        set_param(blkname, 'GotoTag', newtag);
    end
    if DEBUG
        fprintf('%s\n', debug_str);
    end
end

end
% end
