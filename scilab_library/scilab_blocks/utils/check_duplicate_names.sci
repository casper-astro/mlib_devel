/*
check whether any two blocks in the design share the same name
(obj.graphics.exprs(1)).

Returns '' if every block's name is unique. Otherwise returns a
human-readable, aligned ASCII table (one row per duplicated name, naming
the block type(s) that use it and how many instances share that name).
*/
function [msg] = check_duplicate_names(fn)
    scs_m = xcosDiagramToScilab(fn);
    n_objs = length(scs_m.objs);

    // collect (name, tag) for every real casper block in the design
    names = [];
    tags = [];
    for i = 1:n_objs
        obj = scs_m.objs(i);
        if typeof(obj) == 'Block' then
            tag = get_block_tag(obj);
            if tag == 'SPLIT_f' then
                continue;
            end
            names($+1) = obj.graphics.exprs(1);
            tags($+1) = tag;
        end
    end

    msg = '';
    if size(names, '*') == 0 then
        return;
    end

    // collect one row per duplicated name: name / type(s) / count
    dup_names = [];
    dup_types = [];
    dup_counts = [];
    uniq_names = unique(names);
    for i = 1:size(uniq_names, '*')
        n = uniq_names(i);
        idx = find(names == n);
        count = size(idx, '*');
        if count > 1 then
            dup_tags = unique(tags(idx));
            tag_list = dup_tags(1);
            for j = 2:size(dup_tags, '*')
                tag_list = tag_list + ', ' + dup_tags(j);
            end
            dup_names($+1) = n;
            dup_types($+1) = tag_list;
            dup_counts($+1) = count;
        end
    end

    if size(dup_names, '*') == 0 then
        return;
    end

    // build an aligned ASCII table: Name | Type(s) | Count
    col1 = 'Name'; col2 = 'Type(s)'; col3 = 'Count';
    w1 = length(col1);
    w2 = length(col2);
    w3 = length(col3);
    for i = 1:size(dup_names, '*')
        w1 = max(w1, length(dup_names(i)));
        w2 = max(w2, length(dup_types(i)));
        w3 = max(w3, length(string(dup_counts(i))));
    end

    border = '+' + strcat(repmat('-', 1, w1+2)) + '+' + strcat(repmat('-', 1, w2+2)) + '+' + strcat(repmat('-', 1, w3+2)) + '+';
    row_fmt = '| %-' + string(w1) + 's | %-' + string(w2) + 's | %' + string(w3) + 's |';

    msg = 'Duplicate block names:' + ascii(10);
    msg = msg + border + ascii(10);
    msg = msg + sprintf(row_fmt, col1, col2, col3) + ascii(10);
    msg = msg + border + ascii(10);
    for i = 1:size(dup_names, '*')
        msg = msg + sprintf(row_fmt, dup_names(i), dup_types(i), string(dup_counts(i))) + ascii(10);
    end
    msg = msg + border;
endfunction
