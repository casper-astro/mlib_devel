import yaml

def gen_verilog_module(module_name, in_port, out_port, bitwidth = 1, path = './'):
    '''
    Description: 
        Generate user module for jasper.
        The module only has one in_port, but it may have multiple out_ports.
        The only one in_port drives all of the out_ports.
    Inputs:
        - module_name(str): the name of the user module
        - in_ports(list): the names of the in_ports
        - out_ports(list): the names of the out_ports
        - bitwidth(int): the bitwidth of the in_port
        - path(str): the path to save the user module
    '''
    src_str = []
    # add module name
    src_str.append('module %s('%module_name)
    # add clock port
    src_str.append('input clk,')
    # add in_ports
    src_str.append('input [%d:0] %s,'%(bitwidth-1, in_port))
    # add out_ports
    src_str.append('output [%d:0] %s,'%(bitwidth-1, out_port))
    # remove the last comma
    src_str[-1] = src_str[-1][:-1]
    # add endmodule
    src_str.append(');\n')
    # add logic
    src_str.append('assign %s = %s;'%(out_port, in_port))
    # add endmodule
    src_str.append('')
    src_str.append('endmodule')
    # write to file
    with open('%s/%s.v'%(path, module_name), 'w') as f:
        f.write('\n'.join(src_str))

def gen_glue_module(link_info,file_dir='./'):
    module_name = link_info['link_type'] + '_' + link_info['src_blk_name'] + '_' \
        + 'out%d_'%(link_info['src_port_id'] - 1) + link_info['dst_blk_name'] + '_' \
        + 'in%d'%(link_info['dst_port_id'] - 1)
    in_port = link_info['src_port_name']
    out_port = link_info['dst_port_name']
    if link_info['src_port_width'] != link_info['dst_port_width']:
        print('port width not match')
        return
    bitwidth = link_info['src_port_width']
    gen_verilog_module(module_name, in_port, out_port, bitwidth, file_dir)

# try to convert the value to int or float
def val_format_conv(obj):
    for k, v in obj.items():
        try:
            obj[k] = int(v)
        except:
            try:
                obj[k] = float(v)
            except:
                if v == 'on':
                    v = True
                elif v == 'off':
                    v = False
                obj[k] = v
    return obj

# dump the jasper_dict to jasper.per
def dump_jasper(jasper_per, fn = 'jasper.per'):
    f = open(fn, 'w+')
    yaml.dump(jasper_per, f, sort_keys=False)
    f.close()