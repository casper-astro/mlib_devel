// as the number of the ports may change, we need an index to get the width of the port.
// the width of some of the ports are fixed, like `we`, `rst` or some other control signals;
// the width of the other ports are not fixed, like `addr`, `data_in`, `data_out`.

// to deal with this, we get the port index from the block's model.in2/out2 field, 
// which specifies the index of width of the ports in the config file.
// if the id is negative, it means the width is fixed, and we will use the default width in the default config, which is in mlib_devel/scilab_library/scilab_blocks/casper_xxx/xxx.json.
// if the id is positive, it means the width is not fixed, and we will get the width from the user config file, which is in builddir/bconfig/xx.json.

function [width] = get_port_width(obj, port_id, port_type)
    // get the block name, type and tag
    type = get_block_type(obj);
    tag = get_block_tag(obj);
    name = get_block_name(obj);
    // open the config, and get the key for the bit width
    config = get_block_config(name, type, tag);
    // get the width_id from the config struct
    if port_type == 'in' then
        width_id = config('input_ports')('width_id')(port_id);
    else
        width_id = config('output_ports')('width_id')(port_id);
    end
    // if the width_id is a negative value, it means we can get the port width directly;
    // just do abs(width_id) to get the width.
    if width_id < 0 then
        width = abs(width_id);
        return;
    else
        // get the port width from the parameters field in the config file.
        // we need to convert the string to dec, as the values are strings.
        width = strtod(config('parameters')('values')(width_id + 1));
    end
endfunction