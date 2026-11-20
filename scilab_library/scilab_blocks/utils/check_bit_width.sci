/*
check that every link in the design has matching src/dst port widths.

Reads the jasper.json file that collect_block_info(fn) writes to fn's
build directory -- this must be called AFTER collect_block_info(fn),
since it depends on that file already existing with up-to-date link_info.

Returns '' if every link's widths match. Otherwise returns an aligned
ASCII table, one row per mismatched link, naming both ends of the link
and their widths.
*/
function [msg] = check_bit_width(fn)
    msg = '';
    [path, name, ext] = fileparts(fn);
    builddir = path + '/' + name;
    // port names in jasper.json are "<design_name>_<blk_name>_<port>";
    // strip the design_name prefix so the table just shows "<blk_name>_<port>"
    design_prefix = name + '_';
    prefix_len = length(design_prefix);
    jasperfn = builddir + '/jasper.json';
    model_info = fromJSON(jasperfn, 'file');
    link_info = model_info('link_info');

    n_links = size(link_info, '*');
    if n_links == 0 then
        return;
    end

    // collect one row per mismatched link
    src_blks = []; src_ports = []; src_widths = [];
    dst_blks = []; dst_ports = []; dst_widths = [];
    for i = 1:n_links
        link = link_info(i);
        sw = link('src_port_width');
        dw = link('dst_port_width');
        if strtod(string(sw)) <> strtod(string(dw)) then
            src_blks($+1) = link('src_blk_name');
            src_ports($+1) = strip_prefix(link('src_port_name'), design_prefix, prefix_len);
            src_widths($+1) = string(sw);
            dst_blks($+1) = link('dst_blk_name');
            dst_ports($+1) = strip_prefix(link('dst_port_name'), design_prefix, prefix_len);
            dst_widths($+1) = string(dw);
        end
    end

    if size(src_blks, '*') == 0 then
        return;
    end

    // build an aligned ASCII table
    col1 = 'Src Block'; col2 = 'Src Port'; col3 = 'Src Width';
    col4 = 'Dst Block'; col5 = 'Dst Port'; col6 = 'Dst Width';
    w1 = length(col1); w2 = length(col2); w3 = length(col3);
    w4 = length(col4); w5 = length(col5); w6 = length(col6);
    for i = 1:size(src_blks, '*')
        w1 = max(w1, length(src_blks(i)));
        w2 = max(w2, length(src_ports(i)));
        w3 = max(w3, length(src_widths(i)));
        w4 = max(w4, length(dst_blks(i)));
        w5 = max(w5, length(dst_ports(i)));
        w6 = max(w6, length(dst_widths(i)));
    end

    border = '+' + strcat(repmat('-', 1, w1+2)) + '+' + strcat(repmat('-', 1, w2+2)) + '+' + strcat(repmat('-', 1, w3+2)) + '+' + strcat(repmat('-', 1, w4+2)) + '+' + strcat(repmat('-', 1, w5+2)) + '+' + strcat(repmat('-', 1, w6+2)) + '+';
    row_fmt = '| %-' + string(w1) + 's | %-' + string(w2) + 's | %' + string(w3) + 's | %-' + string(w4) + 's | %-' + string(w5) + 's | %' + string(w6) + 's |';

    msg = 'Bit-width mismatch:' + ascii(10);
    msg = msg + border + ascii(10);
    msg = msg + sprintf(row_fmt, col1, col2, col3, col4, col5, col6) + ascii(10);
    msg = msg + border + ascii(10);
    for i = 1:size(src_blks, '*')
        msg = msg + sprintf(row_fmt, src_blks(i), src_ports(i), src_widths(i), dst_blks(i), dst_ports(i), dst_widths(i)) + ascii(10);
    end
    msg = msg + border;
endfunction

// strip a leading "prefix" (design_name + '_') from a port name, for
// display only -- if s doesn't actually start with prefix, return it
// unchanged.
function [s] = strip_prefix(s, prefix, prefix_len)
    if length(s) > prefix_len & part(s, 1:prefix_len) == prefix then
        s = part(s, prefix_len+1:length(s));
    end
endfunction
